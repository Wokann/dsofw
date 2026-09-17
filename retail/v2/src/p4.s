; official_v2_p4
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
	.word P2_Entry_037FC07C + 1	; 02300288

; ===== function loc_0230028C =====
P4_ForwardSystemServiceB:
loc_0230028C:
	ldr r12,[pool_02300294]	; 0230028C
	bx r12	; 02300290
pool_02300294:
loc_02300294:
	.word P2_Entry_037FC070 + 1	; 02300294

; ===== function loc_02300298 =====
P4_ForwardSystemServiceC:
loc_02300298:
	ldr r12,[pool_023002A0]	; 02300298
	bx r12	; 0230029C
pool_023002A0:
loc_023002A0:
	.word P2_Entry_037FC168 + 1	; 023002A0

; ===== function loc_023002A4 =====
P4_ForwardSystemServiceD:
loc_023002A4:
	ldr r12,[pool_023002AC]	; 023002A4
	bx r12	; 023002A8
pool_023002AC:
loc_023002AC:
	.word loc_037FBFD0 + 1	; 023002AC

; ===== function loc_023002B0 =====
P4_ForwardSystemServiceE:
loc_023002B0:
	ldr r12,[pool_023002B8]	; 023002B0
	bx r12	; 023002B4
pool_023002B8:
loc_023002B8:
	.word P2_Entry_037FC07C + 1	; 023002B8

; ===== function loc_023002BC =====
P4_ForwardSystemServiceF:
loc_023002BC:
	ldr r12,[pool_023002C4]	; 023002BC
	bx r12	; 023002C0
pool_023002C4:
loc_023002C4:
	.word P2_Entry_037FC070 + 1	; 023002C4

; ===== function loc_023002C8 =====
P4_ForwardSystemServiceG:
loc_023002C8:
	ldr r12,[pool_023002D0]	; 023002C8
	bx r12	; 023002CC
pool_023002D0:
loc_023002D0:
	.word P2_Entry_037FC0F4 + 1	; 023002D0

; ===== function loc_023002D4 =====
P4_ForwardSystemServiceH:
loc_023002D4:
	ldr r12,[pool_023002DC]	; 023002D4
	bx r12	; 023002D8
pool_023002DC:
loc_023002DC:
	.word loc_037FCCC0 + 1	; 023002DC

; ===== function loc_023002E0 =====
P4_ForwardSystemServiceI:
loc_023002E0:
	ldr r12,[pool_023002E8]	; 023002E0
	bx r12	; 023002E4
pool_023002E8:
loc_023002E8:
	.word P2_Entry_037FC1E4 + 1	; 023002E8

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
	.word 0x02311070	; 023003B4
pool_023003B8:
loc_023003B8:
	.word 0x02311070	; 023003B8
pool_023003BC:
loc_023003BC:
	.word 0x023108B0	; 023003BC

; Cross-component veneer for ARM7 BIOS CpuFastSet (Thumb target). / 面向 ARM7 BIOS CpuFastSet 的跨组件跳板（Thumb 目标）。
P4_ForwardP2CpuFastSet:
; ===== function loc_023003C0 =====
loc_023003C0:
	ldr r12,[pool_023003C8]	; 023003C0
	bx r12	; 023003C4
pool_023003C8:
loc_023003C8:
	.word P2_SwiCpuFastSet + 1	; 0x03802289

; ===== function loc_023003CC =====
; Forwards the prepared configuration to the P4 service backend initializer.
; 将准备好的配置转发给 P4 服务后端初始化器。
P4_ForwardServiceBackendInitializer:
loc_023003CC:
	ldr r12,[pool_023003D4]	; 023003CC
	bx r12	; 023003D0
pool_023003D4:
loc_023003D4:
	.word loc_023008BC + 1	; 023003D4

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

; ===== function loc_023003E4 =====
loc_023003E4:
	push {r4,r5,r6,lr}	; 023003E4
	add r5,r0,#0x0	; 023003E6
	add r4,r1,#0x0	; 023003E8
	add r6,r2,#0x0	; 023003EA
	bl loc_02300404	; 023003EC
	strh r5,[r0,#0x0]	; 023003F0
	mov r1,#0x1	; 023003F2
	strh r1,[r0,#0x2]	; 023003F4
	strh r4,[r0,#0x4]	; 023003F6
	strh r6,[r0,#0x6]	; 023003F8
	bl loc_02300414	; 023003FA
	pop {r4,r5,r6}	; 023003FE
	pop {r3}	; 02300400
	bx r3	; 02300402

; ===== function loc_02300404 =====
loc_02300404:
	bx pc	; 02300404
	.byte 0xC0, 0x46	; 02300408
.arm

; ===== function loc_02300408 =====
loc_02300408:
	ldr r12,[pool_02300410]	; 02300408
	bx r12	; 0230040C
pool_02300410:
loc_02300410:
	.word P2_Runtime_037F80F0 + 1	; 02300410
.thumb

; ===== function loc_02300414 =====
loc_02300414:
	bx pc	; 02300414
	.byte 0xC0, 0x46	; 02300418
.arm

; ===== function loc_02300418 =====
loc_02300418:
	ldr r12,[pool_02300420]	; 02300418
	bx r12	; 0230041C
pool_02300420:
loc_02300420:
	.word P2_Runtime_037F816C + 1	; 02300420
.thumb

; ===== function P4_ClassifyByteArrayAverage =====
; Averages a caller-supplied byte array, then maps the average into one of four threshold bands.
; 对调用方提供的字节数组求平均值，再映射到四个阈值档位之一。
.func P4_ClassifyByteArrayAverage
loc_02300424:
	push {r4,lr}	; 02300424
	mov r3,#0x0	; 02300426
	add r4,r3,#0x0	; 02300428
	b loc_02300432	; 0230042A
loc_0230042C:
	ldrb r2,[r0,r4]	; 0230042C
	add r3,r3,r2	; 0230042E
	add r4,r4,#0x1	; 02300430
loc_02300432:
	cmp r4,r1	; 02300432
	bcc loc_0230042C	; 02300434
	cmp r1,#0x0	; 02300436
	beq loc_02300442	; 02300438
	add r0,r3,#0x0	; 0230043A
	bl loc_02300464	; 0230043C
	add r3,r0,#0x0	; 02300440
loc_02300442:
	cmp r3,#0x8	; 02300442
	bcs loc_0230044A	; 02300444
	mov r0,#0x0	; 02300446
	b loc_0230045C	; 02300448
loc_0230044A:
	cmp r3,#0xe	; 0230044A
	bcs loc_02300452	; 0230044C
	mov r0,#0x1	; 0230044E
	b loc_0230045C	; 02300450
loc_02300452:
	cmp r3,#0x14	; 02300452
	bcs loc_0230045A	; 02300454
	mov r0,#0x2	; 02300456
	b loc_0230045C	; 02300458
loc_0230045A:
	mov r0,#0x3	; 0230045A
loc_0230045C:
	pop {r4}	; 0230045C
	pop {r3}	; 0230045E
	bx r3	; 02300460
.endfunc
	.byte 0xC0, 0x46	; 02300464

; ===== function loc_02300464 =====
loc_02300464:
	bx pc	; 02300464
	.byte 0xC0, 0x46	; 02300468
.arm

; ===== function loc_02300468 =====
loc_02300468:
	ldr pc,[pool_0230046C]	; 02300468
pool_0230046C:
loc_0230046C:
	.word loc_03802720	; 0230046C
.thumb

; ===== function loc_02300470 =====
loc_02300470:
	mov r1,#0x2	; 02300470
	add r2,r0,#0x0	; 02300472
	and r2,r1	; 02300474
	cmp r2,#0x0	; 02300476
	beq loc_02300480	; 02300478
	lsl r0,r0,#0x16	; 0230047A
	lsr r0,r0,#0x18	; 0230047C
	bx lr	; 0230047E
loc_02300480:
	asr r0,r0,#0x2	; 02300480
	add r0,#0x19	; 02300482
	lsl r0,r0,#0x18	; 02300484
	lsr r0,r0,#0x18	; 02300486
	bx lr	; 02300488
	.byte 0x00, 0x00	; 0230048C

; ===== function loc_0230048C =====
loc_0230048C:
	push {r4,r5,r6,r7,lr}	; 0230048C
	sub sp,#0xc	; 0230048E
	ldr r1,[pool_02300550]	; 02300490
	and r0,r1	; 02300492
	lsl r0,r0,#0x10	; 02300494
	lsr r0,r0,#0x10	; 02300496
	str r0,[sp,#0x0]	; 02300498
	cmp r0,#0x0	; 0230049A
	bne loc_023004A2	; 0230049C
	mov r0,#0x0	; 0230049E
	b loc_02300548	; 023004A0
loc_023004A2:
	mov r4,#0x0	; 023004A2
	mov r0,#0x1	; 023004A4
	b loc_023004B6	; 023004A6
loc_023004A8:
	add r1,r0,#0x0	; 023004A8
	lsl r1,r4	; 023004AA
	ldr r2,[sp,#0x0]	; 023004AC
	and r2,r1	; 023004AE
	cmp r2,#0x0	; 023004B0
	bne loc_023004BA	; 023004B2
	add r4,r4,#0x1	; 023004B4
loc_023004B6:
	cmp r4,#0x10	; 023004B6
	blt loc_023004A8	; 023004B8
loc_023004BA:
	mov r5,#0xf	; 023004BA
	mov r0,#0x1	; 023004BC
	b loc_023004CE	; 023004BE
loc_023004C0:
	add r1,r0,#0x0	; 023004C0
	lsl r1,r5	; 023004C2
	ldr r2,[sp,#0x0]	; 023004C4
	and r2,r1	; 023004C6
	cmp r2,#0x0	; 023004C8
	bne loc_023004D2	; 023004CA
	sub r5,r5,#0x1	; 023004CC
loc_023004CE:
	cmp r5,#0x0	; 023004CE
	bne loc_023004C0	; 023004D0
loc_023004D2:
	sub r0,r5,r4	; 023004D2
	str r0,[sp,#0x4]	; 023004D4
	cmp r0,#0x5	; 023004D6
	bge loc_023004E4	; 023004D8
	mov r0,#0x1	; 023004DA
	lsl r0,r4	; 023004DC
	lsl r0,r0,#0x10	; 023004DE
	lsr r0,r0,#0x10	; 023004E0
	b loc_02300548	; 023004E2
loc_023004E4:
	add r0,r5,r4	; 023004E4
	mov r1,#0x2	; 023004E6
	bl loc_02300554	; 023004E8
	add r6,r0,#0x0	; 023004EC
	mov r7,#0x0	; 023004EE
	b loc_02300512	; 023004F0
loc_023004F2:
	add r0,r7,#0x0	; 023004F2
	mov r1,#0x2	; 023004F4
	bl loc_02300560	; 023004F6
	lsl r0,r1,#0x1	; 023004FA
	sub r0,r0,#0x1	; 023004FC
	add r1,r7,#0x0	; 023004FE
	mul r1,r0	; 02300500
	add r6,r6,r1	; 02300502
	mov r0,#0x1	; 02300504
	lsl r0,r6	; 02300506
	ldr r1,[sp,#0x0]	; 02300508
	and r1,r0	; 0230050A
	cmp r1,#0x0	; 0230050C
	bne loc_02300518	; 0230050E
	add r7,r7,#0x1	; 02300510
loc_02300512:
	ldr r0,[sp,#0x4]	; 02300512
	cmp r7,r0	; 02300514
	blt loc_023004F2	; 02300516
loc_02300518:
	sub r0,r5,r6	; 02300518
	cmp r0,#0x5	; 0230051A
	blt loc_02300524	; 0230051C
	sub r0,r6,r4	; 0230051E
	cmp r0,#0x5	; 02300520
	bge loc_02300534	; 02300522
loc_02300524:
	mov r0,#0x1	; 02300524
	add r1,r0,#0x0	; 02300526
	lsl r1,r4	; 02300528
	lsl r0,r5	; 0230052A
	orr r1,r0	; 0230052C
	lsl r0,r1,#0x10	; 0230052E
	lsr r0,r0,#0x10	; 02300530
	b loc_02300548	; 02300532
loc_02300534:
	mov r1,#0x1	; 02300534
	add r2,r1,#0x0	; 02300536
	lsl r2,r4	; 02300538
	add r0,r1,#0x0	; 0230053A
	lsl r0,r5	; 0230053C
	lsl r1,r6	; 0230053E
	orr r0,r1	; 02300540
	orr r2,r0	; 02300542
	lsl r0,r2,#0x10	; 02300544
	lsr r0,r0,#0x10	; 02300546
loc_02300548:
	add sp,#0xc	; 02300548
	pop {r4,r5,r6,r7}	; 0230054A
	pop {r3}	; 0230054C
	bx r3	; 0230054E
pool_02300550:
loc_02300550:
	.word 0x00001FFF	; 02300550

; ===== function loc_02300554 =====
loc_02300554:
	bx pc	; 02300554
	.byte 0xC0, 0x46	; 02300558
.arm

; ===== function loc_02300558 =====
loc_02300558:
	ldr pc,[pool_0230055C]	; 02300558
pool_0230055C:
loc_0230055C:
	.word loc_03802514	; 0230055C
.thumb

; ===== function loc_02300560 =====
loc_02300560:
	bx pc	; 02300560
	.byte 0xC0, 0x46	; 02300564
.arm

; ===== function loc_02300564 =====
loc_02300564:
	ldr pc,[pool_02300568]	; 02300564
pool_02300568:
loc_02300568:
	.word loc_03802514	; 02300568
.thumb

; ===== function loc_0230056C =====
loc_0230056C:
	push {r4,r5,r6,lr}	; 0230056C
	sub sp,#0x8	; 0230056E
	add r6,r0,#0x0	; 02300570
	add r5,r1,#0x0	; 02300572
	bl loc_023008B4	; 02300574
	ldr r1,[pool_02300680]	; 02300578
	ldr r4,[r0,r1]	; 0230057A
	add r0,r5,#0x0	; 0230057C
	add r0,#0x10	; 0230057E
	ldr r1,[r4,#0x0]	; 02300580
	add r1,#0xdc	; 02300582
	bl loc_023007BC	; 02300584
	mov r0,#0x7	; 02300588
	strh r0,[r5,#0x16]	; 0230058A
	ldr r1,[r4,#0x0]	; 0230058C
	ldr r0,[pool_02300684]	; 0230058E
	ldrh r0,[r1,r0]	; 02300590
	strh r0,[r5,#0x18]	; 02300592
	ldr r1,[r4,#0x0]	; 02300594
	ldr r0,[pool_02300688]	; 02300596
	ldrh r0,[r1,r0]	; 02300598
	strh r0,[r5,#0x1e]	; 0230059A
	ldr r0,[r4,#0x0]	; 0230059C
	add r0,#0xe2	; 0230059E
	ldrh r0,[r0,#0x0]	; 023005A0
	strh r0,[r5,#0x1c]	; 023005A2
	ldr r1,[r4,#0x0]	; 023005A4
	ldr r0,[pool_0230068C]	; 023005A6
	ldr r0,[r1,r0]	; 023005A8
	cmp r0,#0x0	; 023005AA
	bne loc_023005CE	; 023005AC
	mov r1,#0x0	; 023005AE
	strh r1,[r5,#0x20]	; 023005B0
	strh r1,[r5,#0x22]	; 023005B2
	add r0,sp,#0x0	; 023005B4
	strh r1,[r0,#0x0]	; 023005B6
	ldrh r0,[r0,#0x0]	; 023005B8
	add r1,r5,#0x0	; 023005BA
	add r1,#0x24	; 023005BC
	mov r2,#0x50	; 023005BE
	bl loc_023006A8	; 023005C0
	mov r1,#0x0	; 023005C4
	add r0,r5,#0x0	; 023005C6
	add r0,#0x9e	; 023005C8
	strh r1,[r0,#0x0]	; 023005CA
	b loc_023005FA	; 023005CC
loc_023005CE:
	bl loc_023008B4	; 023005CE
	ldr r1,[pool_02300690]	; 023005D2
	ldr r0,[r0,r1]	; 023005D4
	ldr r2,[r4,#0x0]	; 023005D6
	ldr r1,[pool_02300694]	; 023005D8
	ldrh r1,[r2,r1]	; 023005DA
	strh r1,[r5,#0x20]	; 023005DC
	mov r1,#0x0	; 023005DE
	strh r1,[r5,#0x22]	; 023005E0
	ldr r2,[r4,#0x0]	; 023005E2
	ldr r1,[pool_02300698]	; 023005E4
	add r1,r2,r1	; 023005E6
	add r2,r5,#0x0	; 023005E8
	add r2,#0x24	; 023005EA
	mov r3,#0x50	; 023005EC
	bl loc_023006B4	; 023005EE
	mov r1,#0x1	; 023005F2
	add r0,r5,#0x0	; 023005F4
	add r0,#0x9e	; 023005F6
	strh r1,[r0,#0x0]	; 023005F8
loc_023005FA:
	mov r1,#0x1	; 023005FA
	add r0,r5,#0x0	; 023005FC
	add r0,#0x74	; 023005FE
	strh r1,[r0,#0x0]	; 02300600
	add r0,r5,#0x0	; 02300602
	add r0,#0x76	; 02300604
	strh r1,[r0,#0x0]	; 02300606
	ldr r0,[r4,#0x0]	; 02300608
	add r0,#0xe2	; 0230060A
	ldrh r0,[r0,#0x0]	; 0230060C
	cmp r0,#0x1	; 0230060E
	bne loc_0230061C	; 02300610
	mov r1,#0x0	; 02300612
	add r0,r5,#0x0	; 02300614
	add r0,#0x78	; 02300616
	strh r1,[r0,#0x0]	; 02300618
	b loc_02300624	; 0230061A
loc_0230061C:
	mov r1,#0x10	; 0230061C
	add r0,r5,#0x0	; 0230061E
	add r0,#0x78	; 02300620
	strh r1,[r0,#0x0]	; 02300622
loc_02300624:
	mov r1,#0xa	; 02300624
	add r0,r5,#0x0	; 02300626
	add r0,#0x7a	; 02300628
	strh r1,[r0,#0x0]	; 0230062A
	mov r1,#0x0	; 0230062C
	add r0,sp,#0x0	; 0230062E
	strh r1,[r0,#0x2]	; 02300630
	ldrh r0,[r0,#0x2]	; 02300632
	add r1,r5,#0x0	; 02300634
	add r1,#0x7c	; 02300636
	mov r2,#0x8	; 02300638
	bl loc_023006C4	; 0230063A
	ldr r1,[pool_0230069C]	; 0230063E
	add r0,sp,#0x0	; 02300640
	strh r1,[r0,#0x4]	; 02300642
	ldrh r0,[r0,#0x4]	; 02300644
	add r1,r5,#0x0	; 02300646
	add r1,#0x84	; 02300648
	mov r2,#0x18	; 0230064A
	bl loc_023006D0	; 0230064C
	ldr r1,[r4,#0x0]	; 02300650
	ldr r0,[pool_023006A0]	; 02300652
	ldrh r1,[r1,r0]	; 02300654
	add r0,r5,#0x0	; 02300656
	add r0,#0x9c	; 02300658
	strh r1,[r0,#0x0]	; 0230065A
	add r0,r5,#0x0	; 0230065C
	bl loc_02301AD0	; 0230065E
	ldrh r2,[r0,#0x4]	; 02300662
	cmp r2,#0x0	; 02300664
	beq loc_02300674	; 02300666
	add r0,r6,#0x0	; 02300668
	ldr r1,[pool_023006A4]	; 0230066A
	bl loc_023003E4	; 0230066C
	mov r0,#0x0	; 02300670
	b loc_02300676	; 02300672
loc_02300674:
	mov r0,#0x1	; 02300674
loc_02300676:
	add sp,#0x8	; 02300676
	pop {r4,r5,r6}	; 02300678
	pop {r3}	; 0230067A
	bx r3	; 0230067C
	.byte 0xC0, 0x46	; 02300680
pool_02300680:
loc_02300680:
	.word 0x00001518	; 02300680
pool_02300684:
loc_02300684:
	.word 0x000001F0	; 02300684
pool_02300688:
loc_02300688:
	.word 0x000001E8	; 02300688
pool_0230068C:
loc_0230068C:
	.word 0x00000194	; 0230068C
pool_02300690:
loc_02300690:
	.word 0x0000150C	; 02300690
pool_02300694:
loc_02300694:
	.word 0x00000192	; 02300694
pool_02300698:
loc_02300698:
	.word 0x00000198	; 02300698
pool_0230069C:
loc_0230069C:
	.word 0x0000FFFF	; 0230069C
pool_023006A0:
loc_023006A0:
	.word 0x000001EA	; 023006A0
pool_023006A4:
loc_023006A4:
	.word 0x00000200	; 023006A4

; ===== function loc_023006A8 =====
loc_023006A8:
	bx pc	; 023006A8
	.byte 0xC0, 0x46	; 023006AC
.arm

; ===== function loc_023006AC =====
loc_023006AC:
	ldr pc,[pool_023006B0]	; 023006AC
pool_023006B0:
loc_023006B0:
	.word loc_037FCE04	; 023006B0
.thumb

; ===== function loc_023006B4 =====
loc_023006B4:
	bx pc	; 023006B4
	.byte 0xC0, 0x46	; 023006B8
.arm

; ===== function loc_023006B8 =====
loc_023006B8:
	ldr r12,[pool_023006C0]	; 023006B8
	bx r12	; 023006BC
pool_023006C0:
loc_023006C0:
	.word P2_Entry_037FCD30 + 1	; 023006C0
.thumb

; ===== function loc_023006C4 =====
loc_023006C4:
	bx pc	; 023006C4
	.byte 0xC0, 0x46	; 023006C8
.arm

; ===== function loc_023006C8 =====
loc_023006C8:
	ldr pc,[pool_023006CC]	; 023006C8
pool_023006CC:
loc_023006CC:
	.word loc_037FCE04	; 023006CC
.thumb

; ===== function loc_023006D0 =====
loc_023006D0:
	bx pc	; 023006D0
	.byte 0xC0, 0x46	; 023006D4
.arm

; ===== function loc_023006D4 =====
loc_023006D4:
	ldr pc,[pool_023006D8]	; 023006D4
pool_023006D8:
loc_023006D8:
	.word loc_037FCE04	; 023006D8
.thumb

; ===== function loc_023006DC =====
loc_023006DC:
	push {r4,r5,lr}	; 023006DC
	sub sp,#0x4	; 023006DE
	add r2,r0,#0x0	; 023006E0
	ldrh r0,[r1,#0x6]	; 023006E2
	strh r0,[r2,#0x4]	; 023006E4
	ldrh r0,[r1,#0x8]	; 023006E6
	strh r0,[r2,#0x6]	; 023006E8
	ldrh r0,[r1,#0xa]	; 023006EA
	strh r0,[r2,#0x8]	; 023006EC
	ldrh r0,[r1,#0x10]	; 023006EE
	cmp r0,#0x0	; 023006F0
	beq loc_023006F8	; 023006F2
	mov r3,#0x2	; 023006F4
	b loc_023006FA	; 023006F6
loc_023006F8:
	mov r3,#0x0	; 023006F8
loc_023006FA:
	ldrh r0,[r1,#0xc]	; 023006FA
	cmp r0,#0x0	; 023006FC
	beq loc_02300704	; 023006FE
	mov r4,#0x1	; 02300700
	b loc_02300706	; 02300702
loc_02300704:
	mov r4,#0x0	; 02300704
loc_02300706:
	ldrh r0,[r1,#0x12]	; 02300706
	cmp r0,#0x0	; 02300708
	beq loc_02300710	; 0230070A
	mov r5,#0x4	; 0230070C
	b loc_02300712	; 0230070E
loc_02300710:
	mov r5,#0x0	; 02300710
loc_02300712:
	ldrh r0,[r1,#0x14]	; 02300712
	cmp r0,#0x0	; 02300714
	beq loc_0230071C	; 02300716
	mov r0,#0x8	; 02300718
	b loc_0230071E	; 0230071A
loc_0230071C:
	mov r0,#0x0	; 0230071C
loc_0230071E:
	orr r4,r3	; 0230071E
	orr r5,r4	; 02300720
	orr r0,r5	; 02300722
	strb r0,[r2,#0xb]	; 02300724
	ldrh r0,[r1,#0x4]	; 02300726
	strb r0,[r2,#0xa]	; 02300728
	mov r4,#0x1	; 0230072A
	strh r4,[r2,#0x0]	; 0230072C
	ldrh r0,[r1,#0x32]	; 0230072E
	strh r0,[r2,#0xc]	; 02300730
	ldrh r0,[r1,#0x34]	; 02300732
	strh r0,[r2,#0xe]	; 02300734
	ldrb r3,[r2,#0xa]	; 02300736
	cmp r3,#0x0	; 02300738
	beq loc_0230074C	; 0230073A
	ldr r0,[pool_02300754]	; 0230073C
	ldr r0,[r0,#0xc]	; 0230073E
	ldr r1,[r1,#0x0]	; 02300740
	add r2,#0x10	; 02300742
	add r3,r3,#0x1	; 02300744
	bic r3,r4	; 02300746
	bl loc_023006B4	; 02300748
loc_0230074C:
	add sp,#0x4	; 0230074C
	pop {r4,r5}	; 0230074E
	pop {r3}	; 02300750
	bx r3	; 02300752
pool_02300754:
loc_02300754:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 02300754

; ===== function loc_02300758 =====
loc_02300758:
	push {r4,r5,lr}	; 02300758
	sub sp,#0x4	; 0230075A
	ldr r1,[pool_023007B8]	; 0230075C
	ldr r1,[r1,#0x18]	; 0230075E
	ldr r1,[r1,#0x0]	; 02300760
	add r2,r1,#0x0	; 02300762
	add r2,#0xdc	; 02300764
	ldrh r2,[r2,#0x0]	; 02300766
	ldrh r5,[r0,#0x0]	; 02300768
	asr r4,r2,#0x8	; 0230076A
	mov r3,#0xff	; 0230076C
	and r2,r3	; 0230076E
	lsl r2,r2,#0x8	; 02300770
	orr r4,r2	; 02300772
	lsl r2,r4,#0x10	; 02300774
	lsr r2,r2,#0x10	; 02300776
	cmp r5,r2	; 02300778
	bne loc_023007AE	; 0230077A
	add r2,r1,#0x0	; 0230077C
	add r2,#0xde	; 0230077E
	ldrh r2,[r2,#0x0]	; 02300780
	ldrh r5,[r0,#0x2]	; 02300782
	asr r4,r2,#0x8	; 02300784
	and r2,r3	; 02300786
	lsl r2,r2,#0x8	; 02300788
	orr r4,r2	; 0230078A
	lsl r2,r4,#0x10	; 0230078C
	lsr r2,r2,#0x10	; 0230078E
	cmp r5,r2	; 02300790
	bne loc_023007AE	; 02300792
	add r1,#0xe0	; 02300794
	ldrh r4,[r1,#0x0]	; 02300796
	ldrh r2,[r0,#0x4]	; 02300798
	asr r1,r4,#0x8	; 0230079A
	and r4,r3	; 0230079C
	lsl r0,r4,#0x8	; 0230079E
	orr r1,r0	; 023007A0
	lsl r0,r1,#0x10	; 023007A2
	lsr r0,r0,#0x10	; 023007A4
	cmp r2,r0	; 023007A6
	bne loc_023007AE	; 023007A8
	mov r0,#0x1	; 023007AA
	b loc_023007B0	; 023007AC
loc_023007AE:
	mov r0,#0x0	; 023007AE
loc_023007B0:
	add sp,#0x4	; 023007B0
	pop {r4,r5}	; 023007B2
	pop {r3}	; 023007B4
	bx r3	; 023007B6
pool_023007B8:
loc_023007B8:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 023007B8

; ===== function loc_023007BC =====
loc_023007BC:
	push {r4,r5,lr}	; 023007BC
	sub sp,#0x4	; 023007BE
	mov r5,#0x0	; 023007C0
	mov r2,#0xff	; 023007C2
loc_023007C4:
	ldrh r3,[r1,#0x0]	; 023007C4
	asr r4,r3,#0x8	; 023007C6
	and r3,r2	; 023007C8
	lsl r3,r3,#0x8	; 023007CA
	orr r4,r3	; 023007CC
	strh r4,[r0,#0x0]	; 023007CE
	add r0,r0,#0x2	; 023007D0
	add r1,r1,#0x2	; 023007D2
	add r5,r5,#0x1	; 023007D4
	cmp r5,#0x3	; 023007D6
	blt loc_023007C4	; 023007D8
	add sp,#0x4	; 023007DA
	pop {r4,r5}	; 023007DC
	pop {r3}	; 023007DE
	bx r3	; 023007E0
	.byte 0x00, 0x00	; 023007E4
P4_PxiCallback_023007E4:
	push {r4,lr}	; 023007E4
	add r4,r1,#0x0	; 023007E6
	cmp r2,#0x0	; 023007E8
	bne loc_02300816	; 023007EA
	ldr r0,[pool_0230081C]	; 023007EC
	mov r2,#0x0	; 023007EE
	bl loc_02300824	; 023007F0
	cmp r0,#0x0	; 023007F4
	bne loc_02300816	; 023007F6
	ldr r0,[pool_02300820]	; 023007F8
	ldr r0,[r0,#0x18]	; 023007FA
	cmp r0,#0x0	; 023007FC
	beq loc_02300816	; 023007FE
	bl loc_02300404	; 02300800
	ldrh r1,[r4,#0x0]	; 02300804
	strh r1,[r0,#0x0]	; 02300806
	mov r1,#0x8	; 02300808
	strh r1,[r0,#0x2]	; 0230080A
	mov r1,#0x0	; 0230080C
	strh r1,[r0,#0x4]	; 0230080E
	strh r1,[r0,#0x6]	; 02300810
	bl loc_02300414	; 02300812
loc_02300816:
	pop {r4}	; 02300816
	pop {r3}	; 02300818
	bx r3	; 0230081A
pool_0230081C:
loc_0230081C:
	.word 0x023117D4	; 0230081C
pool_02300820:
loc_02300820:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 02300820

; ===== function loc_02300824 =====
loc_02300824:
	bx pc	; 02300824
	.byte 0xC0, 0x46	; 02300828
.arm

; ===== function loc_02300828 =====
loc_02300828:
	ldr r12,[pool_02300830]	; 02300828
	bx r12	; 0230082C
pool_02300830:
loc_02300830:
	.word loc_037FBE10 + 1	; 02300830
.thumb

; ===== function loc_02300834 =====
loc_02300834:
	push {lr}	; 02300834
	sub sp,#0x4	; 02300836
	add r1,r0,#0x0	; 02300838
	ldr r0,[pool_0230087C]	; 0230083A
	mov r2,#0x1	; 0230083C
	bl loc_02300824	; 0230083E
	ldr r0,[pool_02300880]	; 02300842
	add r1,sp,#0x0	; 02300844
	mov r2,#0x1	; 02300846
	bl loc_02300884	; 02300848
	ldr r1,[sp,#0x0]	; 0230084C
	ldrh r0,[r1,#0xe]	; 0230084E
	lsl r0,r0,#0x1	; 02300850
	add r0,r1,r0	; 02300852
	ldrh r0,[r0,#0x14]	; 02300854
	cmp r0,#0xe	; 02300856
	bne loc_02300872	; 02300858
	bl loc_02300404	; 0230085A
	mov r1,#0x80	; 0230085E
	strh r1,[r0,#0x0]	; 02300860
	mov r1,#0x13	; 02300862
	strh r1,[r0,#0x2]	; 02300864
	bl loc_02300414	; 02300866
	bl loc_02300894	; 0230086A
	bl loc_023008A4	; 0230086E
loc_02300872:
	ldr r0,[sp,#0x0]	; 02300872
	add sp,#0x4	; 02300874
	pop {r3}	; 02300876
	bx r3	; 02300878
	.byte 0xC0, 0x46	; 0230087C
pool_0230087C:
loc_0230087C:
	.word 0x02311770	; 0230087C
pool_02300880:
loc_02300880:
	.word 0x023117B0	; 02300880

; ===== function loc_02300884 =====
loc_02300884:
	bx pc	; 02300884
	.byte 0xC0, 0x46	; 02300888
.arm

; ===== function loc_02300888 =====
loc_02300888:
	ldr r12,[pool_02300890]	; 02300888
	bx r12	; 0230088C
pool_02300890:
loc_02300890:
	.word loc_037FBD94 + 1	; 02300890
.thumb

; ===== function loc_02300894 =====
loc_02300894:
	bx pc	; 02300894
	.byte 0xC0, 0x46	; 02300898
.arm

; ===== function loc_02300898 =====
loc_02300898:
	ldr r12,[pool_023008A0]	; 02300898
	bx r12	; 0230089C
pool_023008A0:
loc_023008A0:
	.word P2_Entry_037FCF60 + 1	; 023008A0
.thumb

; ===== function loc_023008A4 =====
loc_023008A4:
	bx pc	; 023008A4
	.byte 0xC0, 0x46	; 023008A8
.arm

; ===== function loc_023008A8 =====
loc_023008A8:
	ldr r12,[pool_023008B0]	; 023008A8
	bx r12	; 023008AC
pool_023008B0:
loc_023008B0:
	.word loc_037FCCC0 + 1	; 023008B0
.thumb

; ===== function loc_023008B4 =====
loc_023008B4:
	ldr r0,[pool_023008B8]	; 023008B4
	bx lr	; 023008B6
pool_023008B8:
loc_023008B8:
	.word 0x02311770	; 023008B8

; ===== function loc_023008BC =====
loc_023008BC:
	push {r4,r5,lr}	; 023008BC
	sub sp,#0xc	; 023008BE
	add r5,r0,#0x0	; 023008C0
	add r4,r1,#0x0	; 023008C2
	ldr r1,[r4,#0x0]	; 023008C4
	ldr r0,[pool_02300974]	; 023008C6
	str r1,[r0,#0xc]	; 023008C8
	ldr r1,[r5,#0x24]	; 023008CA
	str r1,[r0,#0x10]	; 023008CC
	ldr r1,[r5,#0x28]	; 023008CE
	str r1,[r0,#0x14]	; 023008D0
	mov r1,#0x0	; 023008D2
	str r1,[r0,#0x18]	; 023008D4
	ldr r0,[pool_02300978]	; 023008D6
	ldr r1,[pool_0230097C]	; 023008D8
	mov r2,#0x2	; 023008DA
	bl loc_023009C0	; 023008DC
	ldr r0,[pool_02300980]	; 023008E0
	ldr r1,[pool_02300984]	; 023008E2
	mov r2,#0x4	; 023008E4
	bl loc_023009C0	; 023008E6
	ldr r0,[pool_02300988]	; 023008EA
	ldr r1,[pool_0230098C]	; 023008EC
	mov r2,#0x4	; 023008EE
	bl loc_023009C0	; 023008F0
	ldr r0,[pool_02300990]	; 023008F4
	ldr r1,[pool_02300994]	; 023008F6
	mov r2,#0x20	; 023008F8
	bl loc_023009C0	; 023008FA
	ldr r0,[pool_02300978]	; 023008FE
	str r0,[r5,#0x10]	; 02300900
	ldr r0,[pool_02300980]	; 02300902
	str r0,[r5,#0x14]	; 02300904
	ldr r0,[pool_02300998]	; 02300906
	bl loc_023009D0	; 02300908
	ldr r0,[pool_0230099C]	; 0230090C
	str r0,[sp,#0x0]	; 0230090E
	ldr r0,[r4,#0x4]	; 02300910
	str r0,[sp,#0x4]	; 02300912
	ldr r0,[pool_023009A0]	; 02300914
	ldr r1,[pool_023009A4]	; 02300916
	mov r2,#0x0	; 02300918
	ldr r3,[pool_02300998]	; 0230091A
	bl loc_023009E0	; 0230091C
	ldr r0,[pool_023009A0]	; 02300920
	bl loc_023009F0	; 02300922
	ldr r0,[pool_023009A8]	; 02300926
	str r0,[sp,#0x0]	; 02300928
	ldr r0,[r4,#0x8]	; 0230092A
	str r0,[sp,#0x4]	; 0230092C
	ldr r0,[pool_023009AC]	; 0230092E
	ldr r1,[pool_023009B0]	; 02300930
	mov r2,#0x0	; 02300932
	ldr r3,[pool_023009B4]	; 02300934
	bl loc_023009E0	; 02300936
	ldr r0,[pool_023009AC]	; 0230093A
	bl loc_023009F0	; 0230093C
	mov r4,#0x0	; 02300940
	add r3,r4,#0x0	; 02300942
	ldr r2,[pool_02300978]	; 02300944
	ldr r0,[pool_023009B8]	; 02300946
loc_02300948:
	add r1,r2,r4	; 02300948
	strb r3,[r1,r0]	; 0230094A
	add r4,r4,#0x1	; 0230094C
	cmp r4,#0x10	; 0230094E
	blt loc_02300948	; 02300950
	ldr r0,[pool_02300974]	; 02300952
	str r3,[r0,#0x2c]	; 02300954
	bl loc_02300A00	; 02300956
	mov r0,#0xa	; 0230095A
	ldr r1,[pool_023009BC]	; 0230095C
	bl loc_02300A10	; 0230095E
	mov r0,#0x2	; 02300962
	str r0,[r5,#0x18]	; 02300964
	add r0,r5,#0x0	; 02300966
	bl loc_023048B8	; 02300968
	add sp,#0xc	; 0230096C
	pop {r4,r5}	; 0230096E
	pop {r3}	; 02300970
	bx r3	; 02300972
pool_02300974:
loc_02300974:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 02300974
pool_02300978:
loc_02300978:
	.word 0x02311770	; 02300978
pool_0230097C:
loc_0230097C:
	.word 0x02311784	; 0230097C
pool_02300980:
loc_02300980:
	.word 0x0231178C	; 02300980
pool_02300984:
loc_02300984:
	.word 0x023117A0	; 02300984
pool_02300988:
loc_02300988:
	.word 0x023117B0	; 02300988
pool_0230098C:
loc_0230098C:
	.word 0x023117C4	; 0230098C
pool_02300990:
loc_02300990:
	.word 0x023117D4	; 02300990
pool_02300994:
loc_02300994:
	.word 0x023117E8	; 02300994
pool_02300998:
loc_02300998:
	.word P4_ServicePrimaryThreadRecord	; 02300998
pool_0230099C:
loc_0230099C:
	.word 0x00000400	; 0230099C
pool_023009A0:
loc_023009A0:
	.word P2_P4ServicePrimaryThreadStackTop	; 023009A0
pool_023009A4:
loc_023009A4:
	.word P4_ThreadEntry_023017C0 + 1	; 023009A4
pool_023009A8:
loc_023009A8:
	.word 0x00001000	; 023009A8
pool_023009AC:
loc_023009AC:
	.word P2_P4ServiceSecondaryThreadStackTop	; 023009AC
pool_023009B0:
loc_023009B0:
	.word P4_ThreadEntry_02301824 + 1	; 023009B0
pool_023009B4:
loc_023009B4:
	.word P4_ServiceSecondaryThreadRecord	; 023009B4
pool_023009B8:
loc_023009B8:
	.word 0x0000151C	; 023009B8
pool_023009BC:
loc_023009BC:
	.word P4_PxiCallback_023007E4 + 1	; 023009BC

; ===== function loc_023009C0 =====
loc_023009C0:
	bx pc	; 023009C0
	.byte 0xC0, 0x46	; 023009C4
.arm

; ===== function loc_023009C4 =====
loc_023009C4:
	ldr r12,[pool_023009CC]	; 023009C4
	bx r12	; 023009C8
pool_023009CC:
loc_023009CC:
	.word loc_037FBE70 + 1	; 023009CC
.thumb

; ===== function loc_023009D0 =====
loc_023009D0:
	bx pc	; 023009D0
	.byte 0xC0, 0x46	; 023009D4
.arm

; ===== function loc_023009D4 =====
loc_023009D4:
	ldr r12,[pool_023009DC]	; 023009D4
	bx r12	; 023009D8
pool_023009DC:
loc_023009DC:
	.word P2_Entry_037FBF98 + 1	; 023009DC
.thumb

; ===== function loc_023009E0 =====
loc_023009E0:
	bx pc	; 023009E0
	.byte 0xC0, 0x46	; 023009E4
.arm

; ===== function loc_023009E4 =====
loc_023009E4:
	ldr r12,[pool_023009EC]	; 023009E4
	bx r12	; 023009E8
pool_023009EC:
loc_023009EC:
	.word P2_CreateThread + 1	; 023009EC
.thumb

; ===== function loc_023009F0 =====
loc_023009F0:
	bx pc	; 023009F0
	.byte 0xC0, 0x46	; 023009F4
.arm

; ===== function loc_023009F4 =====
loc_023009F4:
	ldr r12,[pool_023009FC]	; 023009F4
	bx r12	; 023009F8
pool_023009FC:
loc_023009FC:
	.word loc_037FB9EC + 1	; 023009FC
.thumb

; ===== function loc_02300A00 =====
loc_02300A00:
	bx pc	; 02300A00
	.byte 0xC0, 0x46	; 02300A04
.arm

; ===== function loc_02300A04 =====
loc_02300A04:
	ldr r12,[pool_02300A0C]	; 02300A04
	bx r12	; 02300A08
pool_02300A0C:
loc_02300A0C:
	.word loc_037FF938 + 1	; 02300A0C
.thumb

; ===== function loc_02300A10 =====
loc_02300A10:
	bx pc	; 02300A10
	.byte 0xC0, 0x46	; 02300A14
.arm

; ===== function loc_02300A14 =====
loc_02300A14:
	ldr r12,[pool_02300A1C]	; 02300A14
	bx r12	; 02300A18
pool_02300A1C:
loc_02300A1C:
	.word P2_SetPxiReceiveCallback + 1	; 02300A1C
.thumb

; ===== function loc_02300A20 =====
loc_02300A20:
	push {lr}	; 02300A20
	sub sp,#0x4	; 02300A22
	bl loc_02300404	; 02300A24
	mov r1,#0x80	; 02300A28
	strh r1,[r0,#0x0]	; 02300A2A
	mov r1,#0x0	; 02300A2C
	strh r1,[r0,#0x2]	; 02300A2E
	mov r1,#0x13	; 02300A30
	strh r1,[r0,#0x4]	; 02300A32
	bl loc_02300414	; 02300A34
	add sp,#0x4	; 02300A38
	pop {r3}	; 02300A3A
	bx r3	; 02300A3C
	.byte 0x00, 0x00	; 02300A40

; ===== function loc_02300A40 =====
loc_02300A40:
	push {r4,r5,r6,r7,lr}	; 02300A40
	sub sp,#0x14	; 02300A42
	add r4,r0,#0x0	; 02300A44
	bl loc_023008B4	; 02300A46
	ldr r1,[pool_02300B2C]	; 02300A4A
	ldr r0,[r0,r1]	; 02300A4C
	ldr r5,[r0,#0x0]	; 02300A4E
	ldrh r0,[r5,#0x0]	; 02300A50
	cmp r0,#0x7	; 02300A52
	beq loc_02300A5A	; 02300A54
	cmp r0,#0x9	; 02300A56
	bne loc_02300AFC	; 02300A58
loc_02300A5A:
	add r0,sp,#0x8	; 02300A5A
	add r1,r4,#0x0	; 02300A5C
	add r1,#0x10	; 02300A5E
	bl loc_023007BC	; 02300A60
	mov r6,#0x0	; 02300A64
	add r1,r6,#0x0	; 02300A66
	add r2,sp,#0x8	; 02300A68
	ldrh r7,[r2,#0x0]	; 02300A6A
	ldrh r0,[r2,#0x2]	; 02300A6C
	str r0,[sp,#0x4]	; 02300A6E
	ldrh r0,[r2,#0x4]	; 02300A70
	str r0,[sp,#0x0]	; 02300A72
	b loc_02300AC8	; 02300A74
loc_02300A76:
	add r2,r1,#0x0	; 02300A76
	mov r0,#0x6	; 02300A78
	mul r2,r0	; 02300A7A
	add r0,r5,r2	; 02300A7C
	ldr r2,[pool_02300B30]	; 02300A7E
	ldrh r2,[r0,r2]	; 02300A80
	cmp r7,r2	; 02300A82
	bne loc_02300AC6	; 02300A84
	ldr r2,[pool_02300B34]	; 02300A86
	ldrh r3,[r0,r2]	; 02300A88
	ldr r2,[sp,#0x4]	; 02300A8A
	cmp r2,r3	; 02300A8C
	bne loc_02300AC6	; 02300A8E
	ldr r2,[pool_02300B38]	; 02300A90
	ldrh r3,[r0,r2]	; 02300A92
	ldr r2,[sp,#0x0]	; 02300A94
	cmp r2,r3	; 02300A96
	bne loc_02300AC6	; 02300A98
	add r1,r1,#0x1	; 02300A9A
	lsl r1,r1,#0x10	; 02300A9C
	lsr r6,r1,#0x10	; 02300A9E
	mov r1,#0x1	; 02300AA0
	lsl r1,r6	; 02300AA2
	ldr r2,[pool_02300B3C]	; 02300AA4
	add r3,r5,r2	; 02300AA6
	ldrh r2,[r3,#0x0]	; 02300AA8
	bic r2,r1	; 02300AAA
	strh r2,[r3,#0x0]	; 02300AAC
	add r5,#0x86	; 02300AAE
	ldrh r2,[r5,#0x0]	; 02300AB0
	bic r2,r1	; 02300AB2
	strh r2,[r5,#0x0]	; 02300AB4
	mov r2,#0x0	; 02300AB6
	ldr r1,[pool_02300B30]	; 02300AB8
	strh r2,[r0,r1]	; 02300ABA
	ldr r1,[pool_02300B34]	; 02300ABC
	strh r2,[r0,r1]	; 02300ABE
	ldr r1,[pool_02300B38]	; 02300AC0
	strh r2,[r0,r1]	; 02300AC2
	b loc_02300ACC	; 02300AC4
loc_02300AC6:
	add r1,r1,#0x1	; 02300AC6
loc_02300AC8:
	cmp r1,#0xf	; 02300AC8
	blt loc_02300A76	; 02300ACA
loc_02300ACC:
	cmp r6,#0x0	; 02300ACC
	beq loc_02300B22	; 02300ACE
	bl loc_02300404	; 02300AD0
	add r5,r0,#0x0	; 02300AD4
	mov r0,#0x8	; 02300AD6
	strh r0,[r5,#0x0]	; 02300AD8
	mov r0,#0x0	; 02300ADA
	strh r0,[r5,#0x2]	; 02300ADC
	mov r0,#0x9	; 02300ADE
	strh r0,[r5,#0x8]	; 02300AE0
	ldrh r0,[r4,#0x16]	; 02300AE2
	strh r0,[r5,#0x12]	; 02300AE4
	strh r6,[r5,#0x10]	; 02300AE6
	add r0,r5,#0x0	; 02300AE8
	add r0,#0xa	; 02300AEA
	add r4,#0x10	; 02300AEC
	add r1,r4,#0x0	; 02300AEE
	bl loc_023007BC	; 02300AF0
	add r0,r5,#0x0	; 02300AF4
	bl loc_02300414	; 02300AF6
	b loc_02300B22	; 02300AFA
loc_02300AFC:
	bl loc_02300404	; 02300AFC
	mov r1,#0xc	; 02300B00
	strh r1,[r0,#0x0]	; 02300B02
	mov r1,#0x0	; 02300B04
	strh r1,[r0,#0x2]	; 02300B06
	mov r2,#0x9	; 02300B08
	strh r2,[r0,#0x8]	; 02300B0A
	ldrh r2,[r4,#0x16]	; 02300B0C
	strh r2,[r0,#0xc]	; 02300B0E
	ldr r2,[pool_02300B40]	; 02300B10
	ldrh r2,[r5,r2]	; 02300B12
	strh r2,[r0,#0xa]	; 02300B14
	ldr r2,[pool_02300B44]	; 02300B16
	strh r1,[r5,r2]	; 02300B18
	ldr r2,[pool_02300B48]	; 02300B1A
	strh r1,[r5,r2]	; 02300B1C
	bl loc_02300414	; 02300B1E
loc_02300B22:
	add sp,#0x14	; 02300B22
	pop {r4,r5,r6,r7}	; 02300B24
	pop {r3}	; 02300B26
	bx r3	; 02300B28
	.byte 0xC0, 0x46	; 02300B2C
pool_02300B2C:
loc_02300B2C:
	.word 0x00001518	; 02300B2C
pool_02300B30:
loc_02300B30:
	.word 0x00000124	; 02300B30
pool_02300B34:
loc_02300B34:
	.word 0x00000126	; 02300B34
pool_02300B38:
loc_02300B38:
	.word 0x00000128	; 02300B38
pool_02300B3C:
loc_02300B3C:
	.word 0x0000017E	; 02300B3C
pool_02300B40:
loc_02300B40:
	.word 0x00000184	; 02300B40
pool_02300B44:
loc_02300B44:
	.word 0x0000018E	; 02300B44
pool_02300B48:
loc_02300B48:
	.word 0x00000190	; 02300B48

; ===== function loc_02300B4C =====
loc_02300B4C:
	push {r4,r5,r6,lr}	; 02300B4C
	sub sp,#0x8	; 02300B4E
	add r4,r0,#0x0	; 02300B50
	bl loc_023008B4	; 02300B52
	ldr r1,[pool_02300C20]	; 02300B56
	ldr r0,[r0,r1]	; 02300B58
	ldr r5,[r0,#0x0]	; 02300B5A
	add r0,r5,#0x0	; 02300B5C
	add r0,#0xf0	; 02300B5E
	ldrh r0,[r0,#0x0]	; 02300B60
	cmp r0,#0x0	; 02300B62
	bne loc_02300BA4	; 02300B64
	mov r1,#0x22	; 02300B66
	ldr r0,[pool_02300C24]	; 02300B68
	str r1,[r0,#0x0]	; 02300B6A
	add r4,#0x10	; 02300B6C
	add r0,r4,#0x0	; 02300B6E
	ldr r1,[pool_02300C28]	; 02300B70
	mov r2,#0x6	; 02300B72
	bl loc_02300C38	; 02300B74
	bl loc_023008B4	; 02300B78
	add r0,#0x64	; 02300B7C
	ldr r1,[pool_02300C24]	; 02300B7E
	mov r2,#0x0	; 02300B80
	bl loc_02300824	; 02300B82
	cmp r0,#0x0	; 02300B86
	bne loc_02300C18	; 02300B88
	bl loc_02300404	; 02300B8A
	mov r1,#0x80	; 02300B8E
	strh r1,[r0,#0x0]	; 02300B90
	mov r1,#0x8	; 02300B92
	strh r1,[r0,#0x2]	; 02300B94
	mov r1,#0x16	; 02300B96
	strh r1,[r0,#0x4]	; 02300B98
	mov r1,#0x22	; 02300B9A
	strh r1,[r0,#0x6]	; 02300B9C
	bl loc_02300414	; 02300B9E
	b loc_02300C18	; 02300BA2
loc_02300BA4:
	ldr r0,[pool_02300C2C]	; 02300BA4
	add r2,r5,r0	; 02300BA6
	ldrh r0,[r4,#0x16]	; 02300BA8
	sub r1,r0,#0x1	; 02300BAA
	mov r0,#0x6	; 02300BAC
	mul r1,r0	; 02300BAE
	add r0,r2,r1	; 02300BB0
	add r1,r4,#0x0	; 02300BB2
	add r1,#0x10	; 02300BB4
	bl loc_023007BC	; 02300BB6
	ldr r0,[pool_02300C30]	; 02300BBA
	add r6,r5,r0	; 02300BBC
	ldrh r3,[r6,#0x0]	; 02300BBE
	mov r1,#0x1	; 02300BC0
	ldrh r0,[r4,#0x16]	; 02300BC2
	add r2,r1,#0x0	; 02300BC4
	lsl r2,r0	; 02300BC6
	orr r3,r2	; 02300BC8
	strh r3,[r6,#0x0]	; 02300BCA
	add r0,sp,#0x0	; 02300BCC
	strh r1,[r0,#0x0]	; 02300BCE
	ldrh r0,[r0,#0x0]	; 02300BD0
	ldr r1,[pool_02300C34]	; 02300BD2
	add r2,r5,r1	; 02300BD4
	ldrh r1,[r4,#0x16]	; 02300BD6
	lsl r1,r1,#0x4	; 02300BD8
	add r1,r2,r1	; 02300BDA
	mov r2,#0x20	; 02300BDC
	bl loc_02300C44	; 02300BDE
	bl loc_02300404	; 02300BE2
	add r5,r0,#0x0	; 02300BE6
	mov r0,#0x8	; 02300BE8
	strh r0,[r5,#0x0]	; 02300BEA
	mov r0,#0x0	; 02300BEC
	strh r0,[r5,#0x2]	; 02300BEE
	mov r0,#0x7	; 02300BF0
	strh r0,[r5,#0x8]	; 02300BF2
	add r0,r5,#0x0	; 02300BF4
	add r0,#0xa	; 02300BF6
	add r1,r4,#0x0	; 02300BF8
	add r1,#0x10	; 02300BFA
	bl loc_023007BC	; 02300BFC
	ldrh r0,[r4,#0x16]	; 02300C00
	strh r0,[r5,#0x10]	; 02300C02
	add r4,#0x22	; 02300C04
	add r0,r4,#0x0	; 02300C06
	add r1,r5,#0x0	; 02300C08
	add r1,#0x14	; 02300C0A
	mov r2,#0x18	; 02300C0C
	bl loc_02300C50	; 02300C0E
	add r0,r5,#0x0	; 02300C12
	bl loc_02300414	; 02300C14
loc_02300C18:
	add sp,#0x8	; 02300C18
	pop {r4,r5,r6}	; 02300C1A
	pop {r3}	; 02300C1C
	bx r3	; 02300C1E
pool_02300C20:
loc_02300C20:
	.word 0x00001518	; 02300C20
pool_02300C24:
loc_02300C24:
	.word P4_BssStart + 0x2414	; 02300C24
pool_02300C28:
loc_02300C28:
	.word 0x02312CC8	; 02300C28
pool_02300C2C:
loc_02300C2C:
	.word 0x00000124	; 02300C2C
pool_02300C30:
loc_02300C30:
	.word 0x0000017E	; 02300C30
pool_02300C34:
loc_02300C34:
	.word 0x000001F4	; 02300C34

; ===== function loc_02300C38 =====
loc_02300C38:
	bx pc	; 02300C38
	.byte 0xC0, 0x46	; 02300C3C
.arm

; ===== function loc_02300C3C =====
loc_02300C3C:
	ldr pc,[pool_02300C40]	; 02300C3C
pool_02300C40:
loc_02300C40:
	.word P2_Entry_037FCE1C	; 02300C40
.thumb

; ===== function loc_02300C44 =====
loc_02300C44:
	bx pc	; 02300C44
	.byte 0xC0, 0x46	; 02300C48
.arm

; ===== function loc_02300C48 =====
loc_02300C48:
	ldr pc,[pool_02300C4C]	; 02300C48
pool_02300C4C:
loc_02300C4C:
	.word loc_037FCE04	; 02300C4C
.thumb

; ===== function loc_02300C50 =====
loc_02300C50:
	bx pc	; 02300C50
	.byte 0xC0, 0x46	; 02300C54
.arm

; ===== function loc_02300C54 =====
loc_02300C54:
	ldr pc,[pool_02300C58]	; 02300C54
pool_02300C58:
loc_02300C58:
	.word P2_Entry_037FCEC8	; 02300C58
.thumb

; ===== function loc_02300C5C =====
loc_02300C5C:
	push {lr}	; 02300C5C
	sub sp,#0x4	; 02300C5E
	bl loc_02300404	; 02300C60
	mov r1,#0x80	; 02300C64
	strh r1,[r0,#0x0]	; 02300C66
	mov r1,#0x0	; 02300C68
	strh r1,[r0,#0x2]	; 02300C6A
	mov r1,#0x12	; 02300C6C
	strh r1,[r0,#0x4]	; 02300C6E
	bl loc_02300414	; 02300C70
	add sp,#0x4	; 02300C74
	pop {r3}	; 02300C76
	bx r3	; 02300C78
	.byte 0x00, 0x00	; 02300C7C

; ===== function loc_02300C7C =====
loc_02300C7C:
	push {lr}	; 02300C7C
	sub sp,#0x4	; 02300C7E
	bl loc_02300404	; 02300C80
	mov r1,#0x80	; 02300C84
	strh r1,[r0,#0x0]	; 02300C86
	mov r1,#0x0	; 02300C88
	strh r1,[r0,#0x2]	; 02300C8A
	mov r1,#0x11	; 02300C8C
	strh r1,[r0,#0x4]	; 02300C8E
	bl loc_02300414	; 02300C90
	add sp,#0x4	; 02300C94
	pop {r3}	; 02300C96
	bx r3	; 02300C98
	.byte 0x00, 0x00	; 02300C9C

; ===== function loc_02300C9C =====
loc_02300C9C:
	push {lr}	; 02300C9C
	sub sp,#0x4	; 02300C9E
	bl loc_023008B4	; 02300CA0
	ldr r1,[pool_02300D0C]	; 02300CA4
	ldr r2,[r0,r1]	; 02300CA6
	ldr r0,[r2,#0x0]	; 02300CA8
	add r0,#0xda	; 02300CAA
	ldrh r0,[r0,#0x0]	; 02300CAC
	cmp r0,#0x1	; 02300CAE
	beq loc_02300D04	; 02300CB0
	mov r1,#0x24	; 02300CB2
	ldr r0,[pool_02300D10]	; 02300CB4
	str r1,[r0,#0x0]	; 02300CB6
	ldr r0,[r2,#0x0]	; 02300CB8
	ldrh r0,[r0,#0x0]	; 02300CBA
	cmp r0,#0x9	; 02300CBC
	beq loc_02300CC4	; 02300CBE
	cmp r0,#0x7	; 02300CC0
	bne loc_02300CCC	; 02300CC2
loc_02300CC4:
	ldr r1,[pool_02300D14]	; 02300CC4
	ldr r0,[pool_02300D10]	; 02300CC6
	str r1,[r0,#0x4]	; 02300CC8
	b loc_02300CDA	; 02300CCA
loc_02300CCC:
	cmp r0,#0xa	; 02300CCC
	beq loc_02300CD4	; 02300CCE
	cmp r0,#0x8	; 02300CD0
	bne loc_02300CDA	; 02300CD2
loc_02300CD4:
	mov r1,#0x1	; 02300CD4
	ldr r0,[pool_02300D10]	; 02300CD6
	str r1,[r0,#0x4]	; 02300CD8
loc_02300CDA:
	bl loc_023008B4	; 02300CDA
	add r0,#0x64	; 02300CDE
	ldr r1,[pool_02300D10]	; 02300CE0
	mov r2,#0x0	; 02300CE2
	bl loc_02300824	; 02300CE4
	cmp r0,#0x0	; 02300CE8
	bne loc_02300D04	; 02300CEA
	bl loc_02300404	; 02300CEC
	mov r1,#0x80	; 02300CF0
	strh r1,[r0,#0x0]	; 02300CF2
	mov r1,#0x8	; 02300CF4
	strh r1,[r0,#0x2]	; 02300CF6
	mov r1,#0x16	; 02300CF8
	strh r1,[r0,#0x4]	; 02300CFA
	mov r1,#0x24	; 02300CFC
	strh r1,[r0,#0x6]	; 02300CFE
	bl loc_02300414	; 02300D00
loc_02300D04:
	add sp,#0x4	; 02300D04
	pop {r3}	; 02300D06
	bx r3	; 02300D08
	.byte 0xC0, 0x46	; 02300D0C
pool_02300D0C:
loc_02300D0C:
	.word 0x00001518	; 02300D0C
pool_02300D10:
loc_02300D10:
	.word P4_BssStart + 0x240C	; 02300D10
pool_02300D14:
loc_02300D14:
	.word 0x00007FFE	; 02300D14

; ===== function loc_02300D18 =====
loc_02300D18:
	push {r4,r5,r6,lr}	; 02300D18
	add r5,r0,#0x0	; 02300D1A
	bl loc_023008B4	; 02300D1C
	ldr r1,[pool_02300DCC]	; 02300D20
	ldr r0,[r0,r1]	; 02300D22
	ldr r4,[r0,#0x0]	; 02300D24
	bl loc_023008B4	; 02300D26
	add r6,r0,#0x0	; 02300D2A
	ldrb r0,[r5,#0x1f]	; 02300D2C
	bl loc_02300470	; 02300D2E
	ldr r1,[pool_02300DD0]	; 02300D32
	add r1,r6,r1	; 02300D34
	ldr r2,[r1,#0x0]	; 02300D36
	add r3,r6,r2	; 02300D38
	ldr r2,[pool_02300DD4]	; 02300D3A
	strb r0,[r3,r2]	; 02300D3C
	ldr r0,[r1,#0x0]	; 02300D3E
	add r3,r0,#0x1	; 02300D40
	mov r0,#0xf	; 02300D42
	and r3,r0	; 02300D44
	str r3,[r1,#0x0]	; 02300D46
	add r0,r6,r2	; 02300D48
	mov r1,#0x10	; 02300D4A
	bl P4_ClassifyByteArrayAverage	; 02300D4C
	add r1,r4,#0x0	; 02300D50
	add r1,#0xb8	; 02300D52
	strh r0,[r1,#0x0]	; 02300D54
	add r5,#0x10	; 02300D56
	add r0,r5,#0x0	; 02300D58
	add r0,#0x1e	; 02300D5A
	bl loc_02300758	; 02300D5C
	cmp r0,#0x1	; 02300D60
	beq loc_02300DC4	; 02300D62
	add r2,r4,#0x0	; 02300D64
	add r2,#0xaa	; 02300D66
	ldrh r1,[r2,#0x0]	; 02300D68
	mov r0,#0x1	; 02300D6A
	eor r1,r0	; 02300D6C
	strh r1,[r2,#0x0]	; 02300D6E
	add r0,r4,#0x0	; 02300D70
	add r0,#0xaa	; 02300D72
	ldrh r0,[r0,#0x0]	; 02300D74
	lsl r0,r0,#0x2	; 02300D76
	add r0,r4,r0	; 02300D78
	add r0,#0xac	; 02300D7A
	ldr r4,[r0,#0x0]	; 02300D7C
	bl loc_023008B4	; 02300D7E
	ldr r1,[pool_02300DD8]	; 02300D82
	ldr r0,[r0,r1]	; 02300D84
	add r1,r5,#0x0	; 02300D86
	add r2,r4,#0x0	; 02300D88
	ldrh r3,[r5,#0x6]	; 02300D8A
	add r3,#0x2d	; 02300D8C
	mov r6,#0x1	; 02300D8E
	bic r3,r6	; 02300D90
	bl loc_023006B4	; 02300D92
	add r0,r4,#0x0	; 02300D96
	add r0,#0x18	; 02300D98
	add r1,r5,#0x0	; 02300D9A
	add r1,#0x18	; 02300D9C
	bl loc_023007BC	; 02300D9E
	add r0,r4,#0x0	; 02300DA2
	add r0,#0x1e	; 02300DA4
	add r5,#0x1e	; 02300DA6
	add r1,r5,#0x0	; 02300DA8
	bl loc_023007BC	; 02300DAA
	bl loc_02300404	; 02300DAE
	mov r1,#0x11	; 02300DB2
	strh r1,[r0,#0x0]	; 02300DB4
	mov r1,#0x0	; 02300DB6
	strh r1,[r0,#0x2]	; 02300DB8
	mov r1,#0xf	; 02300DBA
	strh r1,[r0,#0x4]	; 02300DBC
	str r4,[r0,#0x8]	; 02300DBE
	bl loc_02300414	; 02300DC0
loc_02300DC4:
	pop {r4,r5,r6}	; 02300DC4
	pop {r3}	; 02300DC6
	bx r3	; 02300DC8
	.byte 0xC0, 0x46	; 02300DCC
pool_02300DCC:
loc_02300DCC:
	.word 0x00001518	; 02300DCC
pool_02300DD0:
loc_02300DD0:
	.word 0x0000152C	; 02300DD0
pool_02300DD4:
loc_02300DD4:
	.word 0x0000151C	; 02300DD4
pool_02300DD8:
loc_02300DD8:
	.word 0x0000150C	; 02300DD8

; ===== function loc_02300DDC =====
loc_02300DDC:
	push {r4,r5,r6,r7,lr}	; 02300DDC
	sub sp,#0xc	; 02300DDE
	add r5,r0,#0x0	; 02300DE0
	add r6,r5,#0x0	; 02300DE2
	add r6,#0x10	; 02300DE4
	bl loc_023008B4	; 02300DE6
	ldr r1,[pool_02300F9C]	; 02300DEA
	ldr r0,[r0,r1]	; 02300DEC
	ldr r4,[r0,#0x0]	; 02300DEE
	mov r0,#0x0	; 02300DF0
	str r0,[sp,#0x0]	; 02300DF2
	ldr r0,[r4,#0x10]	; 02300DF4
	cmp r0,#0x0	; 02300DF6
	bne loc_02300DFC	; 02300DF8
	b loc_02300F92	; 02300DFA
loc_02300DFC:
	ldrh r0,[r5,#0xe]	; 02300DFC
	cmp r0,#0x0	; 02300DFE
	bne loc_02300E30	; 02300E00
	mov r7,#0x1	; 02300E02
	ldr r1,[pool_02300FA0]	; 02300E04
	ldrh r3,[r1,#0x0]	; 02300E06
	ldr r2,[pool_02300FA4]	; 02300E08
	ldrh r0,[r2,#0x0]	; 02300E0A
	ldrh r1,[r1,#0x0]	; 02300E0C
	cmp r3,r1	; 02300E0E
	bls loc_02300E14	; 02300E10
	ldrh r0,[r2,#0x0]	; 02300E12
loc_02300E14:
	lsl r2,r0,#0xc	; 02300E14
	asr r0,r1,#0x4	; 02300E16
	orr r2,r0	; 02300E18
	lsl r0,r2,#0x10	; 02300E1A
	lsr r1,r0,#0x10	; 02300E1C
	add r0,r4,#0x0	; 02300E1E
	add r0,#0x56	; 02300E20
	ldrh r0,[r0,#0x0]	; 02300E22
	sub r0,r1,r0	; 02300E24
	lsl r0,r0,#0x10	; 02300E26
	asr r0,r0,#0x10	; 02300E28
	cmp r0,#0x0	; 02300E2A
	bgt loc_02300E32	; 02300E2C
	b loc_02300F92	; 02300E2E
loc_02300E30:
	ldr r7,[sp,#0x0]	; 02300E30
loc_02300E32:
	bl loc_02300FB0	; 02300E32
	add r5,r0,#0x0	; 02300E36
	add r1,r4,#0x0	; 02300E38
	add r1,#0x84	; 02300E3A
	ldrh r1,[r1,#0x0]	; 02300E3C
	cmp r1,#0x0	; 02300E3E
	bne loc_02300E48	; 02300E40
	bl loc_02300FBC	; 02300E42
	b loc_02300F92	; 02300E46
loc_02300E48:
	mov r1,#0x0	; 02300E48
	add r0,r4,#0x0	; 02300E4A
	add r0,#0x84	; 02300E4C
	strh r1,[r0,#0x0]	; 02300E4E
	add r0,r4,#0x0	; 02300E50
	add r0,#0x90	; 02300E52
	ldrh r0,[r0,#0x0]	; 02300E54
	str r0,[sp,#0x4]	; 02300E56
	add r0,r4,#0x0	; 02300E58
	add r0,#0x58	; 02300E5A
	bl loc_02300FC8	; 02300E5C
	add r0,r5,#0x0	; 02300E60
	bl loc_02300FD8	; 02300E62
	mov r3,#0x1	; 02300E66
	add r0,r4,#0x0	; 02300E68
	add r0,#0x8c	; 02300E6A
	ldrh r2,[r0,#0x0]	; 02300E6C
	cmp r2,#0x0	; 02300E6E
	beq loc_02300E88	; 02300E70
	cmp r7,#0x0	; 02300E72
	bne loc_02300E86	; 02300E74
	ldrh r1,[r6,#0x2e]	; 02300E76
	ldr r0,[pool_02300FA8]	; 02300E78
	ldrh r0,[r4,r0]	; 02300E7A
	add r5,r3,#0x0	; 02300E7C
	lsl r5,r0	; 02300E7E
	and r1,r5	; 02300E80
	cmp r1,#0x0	; 02300E82
	bne loc_02300E88	; 02300E84
loc_02300E86:
	mov r3,#0x0	; 02300E86
loc_02300E88:
	cmp r2,#0x0	; 02300E88
	beq loc_02300E94	; 02300E8A
	mov r1,#0x0	; 02300E8C
	add r0,r4,#0x0	; 02300E8E
	add r0,#0x8c	; 02300E90
	strh r1,[r0,#0x0]	; 02300E92
loc_02300E94:
	add r0,r4,#0x0	; 02300E94
	add r0,#0x8e	; 02300E96
	ldrh r0,[r0,#0x0]	; 02300E98
	cmp r0,#0x0	; 02300E9A
	beq loc_02300EB8	; 02300E9C
	mov r1,#0x0	; 02300E9E
	add r0,r4,#0x0	; 02300EA0
	add r0,#0x8e	; 02300EA2
	strh r1,[r0,#0x0]	; 02300EA4
	cmp r3,#0x0	; 02300EA6
	beq loc_02300EAC	; 02300EA8
	mov r1,#0x1	; 02300EAA
loc_02300EAC:
	add r0,r7,#0x0	; 02300EAC
	lsl r1,r1,#0x10	; 02300EAE
	lsr r1,r1,#0x10	; 02300EB0
	bl loc_02303ADC	; 02300EB2
	str r0,[sp,#0x0]	; 02300EB6
loc_02300EB8:
	bl loc_02300404	; 02300EB8
	add r5,r0,#0x0	; 02300EBC
	mov r0,#0xe	; 02300EBE
	strh r0,[r5,#0x0]	; 02300EC0
	ldr r0,[sp,#0x4]	; 02300EC2
	cmp r0,#0x0	; 02300EC4
	bne loc_02300ECE	; 02300EC6
	mov r0,#0xd	; 02300EC8
	strh r0,[r5,#0x2]	; 02300ECA
	b loc_02300EF2	; 02300ECC
loc_02300ECE:
	cmp r7,#0x0	; 02300ECE
	beq loc_02300ED8	; 02300ED0
	mov r0,#0x9	; 02300ED2
	strh r0,[r5,#0x2]	; 02300ED4
	b loc_02300EF2	; 02300ED6
loc_02300ED8:
	ldrh r1,[r6,#0x2e]	; 02300ED8
	mov r0,#0x1	; 02300EDA
	ldr r2,[pool_02300FA8]	; 02300EDC
	ldrh r2,[r4,r2]	; 02300EDE
	lsl r0,r2	; 02300EE0
	and r1,r0	; 02300EE2
	cmp r1,#0x0	; 02300EE4
	beq loc_02300EEE	; 02300EE6
	mov r0,#0xf	; 02300EE8
	strh r0,[r5,#0x2]	; 02300EEA
	b loc_02300EF2	; 02300EEC
loc_02300EEE:
	mov r0,#0x0	; 02300EEE
	strh r0,[r5,#0x2]	; 02300EF0
loc_02300EF2:
	mov r0,#0xd	; 02300EF2
	strh r0,[r5,#0x4]	; 02300EF4
	mov r0,#0x0	; 02300EF6
	str r0,[r5,#0x8]	; 02300EF8
	cmp r7,#0x0	; 02300EFA
	bne loc_02300F2A	; 02300EFC
	ldrh r0,[r6,#0xc]	; 02300EFE
	strh r0,[r5,#0xc]	; 02300F00
	ldrh r0,[r6,#0xe]	; 02300F02
	strh r0,[r5,#0xe]	; 02300F04
	add r0,r5,#0x0	; 02300F06
	add r0,#0x10	; 02300F08
	add r1,r6,#0x0	; 02300F0A
	add r1,#0x18	; 02300F0C
	bl loc_023007BC	; 02300F0E
	add r0,r5,#0x0	; 02300F12
	add r0,#0x16	; 02300F14
	add r1,r6,#0x0	; 02300F16
	add r1,#0x1e	; 02300F18
	bl loc_023007BC	; 02300F1A
	ldrh r0,[r6,#0x2a]	; 02300F1E
	strh r0,[r5,#0x1c]	; 02300F20
	ldrh r0,[r6,#0x2c]	; 02300F22
	strh r0,[r5,#0x1e]	; 02300F24
	ldrh r0,[r6,#0x2e]	; 02300F26
	strh r0,[r5,#0x20]	; 02300F28
loc_02300F2A:
	add r0,r5,#0x0	; 02300F2A
	bl loc_02300414	; 02300F2C
	ldr r0,[sp,#0x4]	; 02300F30
	cmp r0,#0x0	; 02300F32
	beq loc_02300F92	; 02300F34
	ldr r0,[sp,#0x0]	; 02300F36
	cmp r0,#0x1	; 02300F38
	beq loc_02300F42	; 02300F3A
	ldrh r0,[r4,#0x38]	; 02300F3C
	cmp r0,#0x0	; 02300F3E
	bne loc_02300F86	; 02300F40
loc_02300F42:
	bl loc_023008B4	; 02300F42
	add r5,r0,#0x0	; 02300F46
	mov r0,#0x26	; 02300F48
	ldr r1,[pool_02300FAC]	; 02300F4A
	str r0,[r1,#0x0]	; 02300F4C
	mov r2,#0x0	; 02300F4E
	strh r2,[r4,#0x38]	; 02300F50
	strh r2,[r4,#0x3a]	; 02300F52
	add r4,#0x88	; 02300F54
	strh r2,[r4,#0x0]	; 02300F56
	add r0,r5,#0x0	; 02300F58
	add r0,#0x64	; 02300F5A
	bl loc_02300824	; 02300F5C
	cmp r0,#0x0	; 02300F60
	bne loc_02300F92	; 02300F62
	ldr r0,[pool_02300F9C]	; 02300F64
	ldr r0,[r5,r0]	; 02300F66
	cmp r0,#0x0	; 02300F68
	beq loc_02300F92	; 02300F6A
	bl loc_02300404	; 02300F6C
	mov r1,#0x80	; 02300F70
	strh r1,[r0,#0x0]	; 02300F72
	mov r1,#0x8	; 02300F74
	strh r1,[r0,#0x2]	; 02300F76
	mov r1,#0x16	; 02300F78
	strh r1,[r0,#0x4]	; 02300F7A
	mov r1,#0x26	; 02300F7C
	strh r1,[r0,#0x6]	; 02300F7E
	bl loc_02300414	; 02300F80
	b loc_02300F92	; 02300F84
loc_02300F86:
	mov r1,#0x0	; 02300F86
	strh r1,[r4,#0x38]	; 02300F88
	mov r0,#0x1	; 02300F8A
	strh r0,[r4,#0x3a]	; 02300F8C
	add r4,#0x88	; 02300F8E
	strh r1,[r4,#0x0]	; 02300F90
loc_02300F92:
	add sp,#0xc	; 02300F92
	pop {r4,r5,r6,r7}	; 02300F94
	pop {r3}	; 02300F96
	bx r3	; 02300F98
	.byte 0xC0, 0x46	; 02300F9C
pool_02300F9C:
loc_02300F9C:
	.word 0x00001518	; 02300F9C
pool_02300FA0:
loc_02300FA0:
	.word REG_WIFI_US_COUNT0	; 02300FA0
pool_02300FA4:
loc_02300FA4:
	.word REG_WIFI_US_COUNT1	; 02300FA4
pool_02300FA8:
loc_02300FA8:
	.word 0x00000184	; 02300FA8
pool_02300FAC:
loc_02300FAC:
	.word P4_BssStart + 0x23F0	; 02300FAC

; ===== function loc_02300FB0 =====
loc_02300FB0:
	bx pc	; 02300FB0
	.byte 0xC0, 0x46	; 02300FB4
.arm

; ===== function loc_02300FB4 =====
loc_02300FB4:
	ldr pc,[pool_02300FB8]	; 02300FB4
pool_02300FB8:
loc_02300FB8:
	.word loc_037FCBF0	; 02300FB8
.thumb

; ===== function loc_02300FBC =====
loc_02300FBC:
	bx pc	; 02300FBC
	.byte 0xC0, 0x46	; 02300FC0
.arm

; ===== function loc_02300FC0 =====
loc_02300FC0:
	ldr pc,[pool_02300FC4]	; 02300FC0
pool_02300FC4:
loc_02300FC4:
	.word loc_037FCC04	; 02300FC4
.thumb

; ===== function loc_02300FC8 =====
loc_02300FC8:
	bx pc	; 02300FC8
	.byte 0xC0, 0x46	; 02300FCC
.arm

; ===== function loc_02300FCC =====
loc_02300FCC:
	ldr r12,[pool_02300FD4]	; 02300FCC
	bx r12	; 02300FD0
pool_02300FD4:
loc_02300FD4:
	.word loc_037FC5A0 + 1	; 02300FD4
.thumb

; ===== function loc_02300FD8 =====
loc_02300FD8:
	bx pc	; 02300FD8
	.byte 0xC0, 0x46	; 02300FDC
.arm

; ===== function loc_02300FDC =====
loc_02300FDC:
	ldr pc,[pool_02300FE0]	; 02300FDC
pool_02300FE0:
loc_02300FE0:
	.word loc_037FCC04	; 02300FE0
.thumb
P4_Code_02300FE4:
	push {r4,lr}	; 02300FE4
	bl loc_023008B4	; 02300FE6
	add r4,r0,#0x0	; 02300FEA
	ldr r0,[pool_02301034]	; 02300FEC
	ldr r0,[r4,r0]	; 02300FEE
	ldr r1,[pool_02301038]	; 02300FF0
	ldr r1,[r4,r1]	; 02300FF2
	mov r2,#0x40	; 02300FF4
	bl loc_02301044	; 02300FF6
	add r1,r0,#0x0	; 02300FFA
	ldr r0,[pool_0230103C]	; 02300FFC
	strh r0,[r1,#0xc]	; 02300FFE
	mov r2,#0x0	; 02301000
	strh r2,[r1,#0xe]	; 02301002
	add r0,r4,#0x0	; 02301004
	add r0,#0x1c	; 02301006
	bl loc_02300824	; 02301008
	cmp r0,#0x0	; 0230100C
	bne loc_0230102E	; 0230100E
	ldr r0,[pool_02301040]	; 02301010
	ldr r0,[r4,r0]	; 02301012
	cmp r0,#0x0	; 02301014
	beq loc_0230102E	; 02301016
	bl loc_02300404	; 02301018
	mov r2,#0x80	; 0230101C
	strh r2,[r0,#0x0]	; 0230101E
	mov r1,#0x8	; 02301020
	strh r1,[r0,#0x2]	; 02301022
	mov r1,#0x16	; 02301024
	strh r1,[r0,#0x4]	; 02301026
	strh r2,[r0,#0x6]	; 02301028
	bl loc_02300414	; 0230102A
loc_0230102E:
	pop {r4}	; 0230102E
	pop {r3}	; 02301030
	bx r3	; 02301032
pool_02301034:
loc_02301034:
	.word 0x00001510	; 02301034
pool_02301038:
loc_02301038:
	.word 0x00001514	; 02301038
pool_0230103C:
loc_0230103C:
	.word 0x00000185	; 0230103C
pool_02301040:
loc_02301040:
	.word 0x00001518	; 02301040

; ===== function loc_02301044 =====
loc_02301044:
	bx pc	; 02301044
	.byte 0xC0, 0x46	; 02301048
.arm

; ===== function loc_02301048 =====
loc_02301048:
	ldr r12,[pool_02301050]	; 02301048
	bx r12	; 0230104C
pool_02301050:
loc_02301050:
	.word P2_Entry_037FC258 + 1	; 02301050
.thumb

; ===== function loc_02301054 =====
loc_02301054:
	push {r4,r5,r6,r7,lr}	; 02301054
	sub sp,#0x14	; 02301056
	add r7,r0,#0x0	; 02301058
	bl loc_023008B4	; 0230105A
	ldr r1,[pool_02301278]	; 0230105E
	ldr r0,[r0,r1]	; 02301060
	ldr r5,[r0,#0x0]	; 02301062
	bl loc_023008B4	; 02301064
	add r4,r0,#0x0	; 02301068
	ldrb r0,[r7,#0x1f]	; 0230106A
	bl loc_02300470	; 0230106C
	ldr r1,[pool_0230127C]	; 02301070
	add r1,r4,r1	; 02301072
	ldr r2,[r1,#0x0]	; 02301074
	add r3,r4,r2	; 02301076
	ldr r2,[pool_02301280]	; 02301078
	strb r0,[r3,r2]	; 0230107A
	ldr r0,[r1,#0x0]	; 0230107C
	add r3,r0,#0x1	; 0230107E
	mov r0,#0xf	; 02301080
	and r3,r0	; 02301082
	str r3,[r1,#0x0]	; 02301084
	add r0,r4,r2	; 02301086
	mov r1,#0x10	; 02301088
	bl P4_ClassifyByteArrayAverage	; 0230108A
	add r1,r5,#0x0	; 0230108E
	add r1,#0xb8	; 02301090
	strh r0,[r1,#0x0]	; 02301092
	ldr r0,[r5,#0x10]	; 02301094
	cmp r0,#0x0	; 02301096
	bne loc_0230109C	; 02301098
	b loc_0230126E	; 0230109A
loc_0230109C:
	ldrh r0,[r5,#0x3a]	; 0230109C
	cmp r0,#0x1	; 0230109E
	bne loc_023010A6	; 023010A0
	mov r0,#0x0	; 023010A2
	strh r0,[r5,#0x3a]	; 023010A4
loc_023010A6:
	add r0,r5,#0x0	; 023010A6
	add r0,#0x8e	; 023010A8
	ldrh r0,[r0,#0x0]	; 023010AA
	str r0,[sp,#0xc]	; 023010AC
	add r2,r5,#0x0	; 023010AE
	add r2,#0x42	; 023010B0
	ldrh r1,[r2,#0x0]	; 023010B2
	mov r0,#0x1	; 023010B4
	eor r1,r0	; 023010B6
	strh r1,[r2,#0x0]	; 023010B8
	add r0,r5,#0x0	; 023010BA
	add r0,#0x42	; 023010BC
	ldrh r0,[r0,#0x0]	; 023010BE
	lsl r0,r0,#0x2	; 023010C0
	add r0,r5,r0	; 023010C2
	ldr r4,[r0,#0x48]	; 023010C4
	bl loc_023008B4	; 023010C6
	ldr r1,[pool_02301284]	; 023010CA
	ldr r0,[r0,r1]	; 023010CC
	add r1,r7,#0x0	; 023010CE
	add r1,#0x10	; 023010D0
	add r2,r4,#0x0	; 023010D2
	add r3,r5,#0x0	; 023010D4
	add r3,#0x46	; 023010D6
	ldrh r3,[r3,#0x0]	; 023010D8
	bl loc_023006B4	; 023010DA
	bl loc_023012A4	; 023010DE
	str r0,[sp,#0x4]	; 023010E2
	mov r0,#0x0	; 023010E4
	str r0,[sp,#0x8]	; 023010E6
	add r0,r5,#0x0	; 023010E8
	add r0,#0x84	; 023010EA
	ldrh r0,[r0,#0x0]	; 023010EC
	cmp r0,#0x1	; 023010EE
	bne loc_023010FE	; 023010F0
	mov r0,#0x1	; 023010F2
	str r0,[sp,#0x8]	; 023010F4
	add r0,r5,#0x0	; 023010F6
	add r0,#0x58	; 023010F8
	bl loc_02300FC8	; 023010FA
loc_023010FE:
	mov r6,#0x1	; 023010FE
	add r0,r5,#0x0	; 02301100
	add r0,#0x84	; 02301102
	strh r6,[r0,#0x0]	; 02301104
	ldrh r1,[r4,#0xa]	; 02301106
	add r0,r5,#0x0	; 02301108
	add r0,#0x56	; 0230110A
	strh r1,[r0,#0x0]	; 0230110C
	ldrh r0,[r4,#0x2e]	; 0230110E
	ldr r1,[pool_02301288]	; 02301110
	ldrh r1,[r5,r1]	; 02301112
	add r2,r6,#0x0	; 02301114
	lsl r2,r1	; 02301116
	and r0,r2	; 02301118
	cmp r0,#0x0	; 0230111A
	bne loc_02301120	; 0230111C
	mov r6,#0x0	; 0230111E
loc_02301120:
	add r0,r5,#0x0	; 02301120
	add r0,#0x90	; 02301122
	strh r6,[r0,#0x0]	; 02301124
	ldrh r1,[r4,#0xa]	; 02301126
	ldrh r0,[r4,#0xc]	; 02301128
	sub r0,r1,r0	; 0230112A
	lsl r0,r0,#0x10	; 0230112C
	lsr r0,r0,#0x10	; 0230112E
	add r0,#0x60	; 02301130
	lsl r0,r0,#0x4	; 02301132
	ldr r1,[pool_0230128C]	; 02301134
	mul r0,r1	; 02301136
	mov r1,#0x40	; 02301138
	bl loc_023012B0	; 0230113A
	ldr r1,[pool_02301290]	; 0230113E
	bl loc_023012BC	; 02301140
	add r1,r0,#0x0	; 02301144
	mov r0,#0x0	; 02301146
	str r0,[sp,#0x0]	; 02301148
	add r0,r5,#0x0	; 0230114A
	add r0,#0x58	; 0230114C
	asr r2,r1,#0x1f	; 0230114E
	ldr r3,[pool_02301294]	; 02301150
	bl loc_023012C8	; 02301152
	ldrh r0,[r7,#0x18]	; 02301156
	ldr r1,[pool_02301298]	; 02301158
	add r2,r0,#0x0	; 0230115A
	and r2,r1	; 0230115C
	cmp r2,r1	; 0230115E
	bne loc_02301166	; 02301160
	mov r1,#0x1	; 02301162
	b loc_02301168	; 02301164
loc_02301166:
	mov r1,#0x0	; 02301166
loc_02301168:
	ldr r2,[pool_0230129C]	; 02301168
	and r0,r2	; 0230116A
	cmp r0,r2	; 0230116C
	bne loc_02301174	; 0230116E
	mov r2,#0x1	; 02301170
	b loc_02301176	; 02301172
loc_02301174:
	mov r2,#0x0	; 02301174
loc_02301176:
	cmp r1,#0x0	; 02301176
	beq loc_02301182	; 02301178
	mov r3,#0x0	; 0230117A
	add r0,r5,#0x0	; 0230117C
	add r0,#0x8a	; 0230117E
	strh r3,[r0,#0x0]	; 02301180
loc_02301182:
	cmp r1,#0x0	; 02301182
	beq loc_0230118A	; 02301184
	mov r1,#0x1	; 02301186
	b loc_0230118C	; 02301188
loc_0230118A:
	mov r1,#0x0	; 0230118A
loc_0230118C:
	add r0,r5,#0x0	; 0230118C
	add r0,#0x8e	; 0230118E
	strh r1,[r0,#0x0]	; 02301190
	cmp r2,#0x0	; 02301192
	beq loc_0230119A	; 02301194
	mov r1,#0x1	; 02301196
	b loc_0230119C	; 02301198
loc_0230119A:
	mov r1,#0x0	; 0230119A
loc_0230119C:
	add r0,r5,#0x0	; 0230119C
	add r0,#0x8c	; 0230119E
	strh r1,[r0,#0x0]	; 023011A0
	ldr r0,[sp,#0x4]	; 023011A2
	bl loc_023012D8	; 023011A4
	ldr r0,[sp,#0x8]	; 023011A8
	cmp r0,#0x0	; 023011AA
	beq loc_023011D4	; 023011AC
	ldr r0,[sp,#0xc]	; 023011AE
	cmp r0,#0x1	; 023011B0
	bne loc_023011BC	; 023011B2
	ldr r0,[sp,#0x8]	; 023011B4
	mov r1,#0x0	; 023011B6
	bl loc_02303ADC	; 023011B8
loc_023011BC:
	bl loc_02300404	; 023011BC
	mov r1,#0xe	; 023011C0
	strh r1,[r0,#0x0]	; 023011C2
	mov r1,#0x9	; 023011C4
	strh r1,[r0,#0x2]	; 023011C6
	mov r1,#0xd	; 023011C8
	strh r1,[r0,#0x4]	; 023011CA
	mov r1,#0x0	; 023011CC
	str r1,[r0,#0x8]	; 023011CE
	bl loc_02300414	; 023011D0
loc_023011D4:
	add r0,r4,#0x0	; 023011D4
	add r0,#0x18	; 023011D6
	add r1,r7,#0x0	; 023011D8
	add r1,#0x28	; 023011DA
	bl loc_023007BC	; 023011DC
	add r0,r4,#0x0	; 023011E0
	add r0,#0x18	; 023011E2
	add r7,#0x2e	; 023011E4
	add r1,r7,#0x0	; 023011E6
	bl loc_023007BC	; 023011E8
	ldrh r0,[r4,#0x6]	; 023011EC
	cmp r0,#0x2	; 023011EE
	bcc loc_02301246	; 023011F0
	add r1,r4,#0x6	; 023011F2
	ldrh r0,[r1,#0x0]	; 023011F4
	sub r0,r0,#0x2	; 023011F6
	strh r0,[r1,#0x0]	; 023011F8
	ldrh r1,[r4,#0x30]	; 023011FA
	ldr r0,[pool_023012A0]	; 023011FC
	and r1,r0	; 023011FE
	cmp r1,#0x0	; 02301200
	beq loc_02301208	; 02301202
	mov r0,#0x1	; 02301204
	b loc_0230120A	; 02301206
loc_02301208:
	mov r0,#0x0	; 02301208
loc_0230120A:
	strh r0,[r5,#0x38]	; 0230120A
	bl loc_02300404	; 0230120C
	mov r1,#0xe	; 02301210
	strh r1,[r0,#0x0]	; 02301212
	cmp r6,#0x0	; 02301214
	beq loc_0230121E	; 02301216
	mov r1,#0x0	; 02301218
	strh r1,[r0,#0x2]	; 0230121A
	b loc_02301222	; 0230121C
loc_0230121E:
	mov r1,#0xd	; 0230121E
	strh r1,[r0,#0x2]	; 02301220
loc_02301222:
	mov r1,#0xc	; 02301222
	strh r1,[r0,#0x4]	; 02301224
	str r4,[r0,#0x8]	; 02301226
	bl loc_02300414	; 02301228
	ldrh r3,[r4,#0x6]	; 0230122C
	cmp r3,#0x0	; 0230122E
	beq loc_0230126E	; 02301230
	str r4,[sp,#0x0]	; 02301232
	mov r0,#0x0	; 02301234
	ldrh r1,[r4,#0x30]	; 02301236
	add r4,#0x32	; 02301238
	add r2,r4,#0x0	; 0230123A
	bl loc_02303958	; 0230123C
	bl loc_023012E4	; 02301240
	b loc_0230126E	; 02301244
loc_02301246:
	mov r0,#0x0	; 02301246
	strh r0,[r4,#0x6]	; 02301248
	strh r0,[r5,#0x38]	; 0230124A
	bl loc_02300404	; 0230124C
	mov r1,#0xe	; 02301250
	strh r1,[r0,#0x0]	; 02301252
	cmp r6,#0x0	; 02301254
	beq loc_0230125C	; 02301256
	strh r1,[r0,#0x2]	; 02301258
	b loc_02301260	; 0230125A
loc_0230125C:
	mov r1,#0xd	; 0230125C
	strh r1,[r0,#0x2]	; 0230125E
loc_02301260:
	mov r1,#0xc	; 02301260
	strh r1,[r0,#0x4]	; 02301262
	str r4,[r0,#0x8]	; 02301264
	bl loc_02300414	; 02301266
	bl loc_023012E4	; 0230126A
loc_0230126E:
	add sp,#0x14	; 0230126E
	pop {r4,r5,r6,r7}	; 02301270
	pop {r3}	; 02301272
	bx r3	; 02301274
	.byte 0xC0, 0x46	; 02301278
pool_02301278:
loc_02301278:
	.word 0x00001518	; 02301278
pool_0230127C:
loc_0230127C:
	.word 0x0000152C	; 0230127C
pool_02301280:
loc_02301280:
	.word 0x0000151C	; 02301280
pool_02301284:
loc_02301284:
	.word 0x0000150C	; 02301284
pool_02301288:
loc_02301288:
	.word 0x00000184	; 02301288
pool_0230128C:
loc_0230128C:
	.word 0x000082EA	; 0230128C
pool_02301290:
loc_02301290:
	.word 0x000003E8	; 02301290
pool_02301294:
loc_02301294:
	.word P4_Code_02300FE4 + 1	; 02301294
pool_02301298:
loc_02301298:
	.word 0x00002800	; 02301298
pool_0230129C:
loc_0230129C:
	.word 0x00006000	; 0230129C
pool_023012A0:
loc_023012A0:
	.word 0x00008000	; 023012A0

; ===== function loc_023012A4 =====
loc_023012A4:
	bx pc	; 023012A4
	.byte 0xC0, 0x46	; 023012A8
.arm

; ===== function loc_023012A8 =====
loc_023012A8:
	ldr pc,[pool_023012AC]	; 023012A8
pool_023012AC:
loc_023012AC:
	.word loc_037FCBF0	; 023012AC
.thumb

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
	.word loc_03802514	; 023012B8
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
	.word loc_03802514	; 023012C4
.thumb

; ===== function loc_023012C8 =====
loc_023012C8:
	bx pc	; 023012C8
	.byte 0xC0, 0x46	; 023012CC
.arm

; ===== function loc_023012CC =====
loc_023012CC:
	ldr r12,[pool_023012D4]	; 023012CC
	bx r12	; 023012D0
pool_023012D4:
loc_023012D4:
	.word loc_037FC64C + 1	; 023012D4
.thumb

; ===== function loc_023012D8 =====
loc_023012D8:
	bx pc	; 023012D8
	.byte 0xC0, 0x46	; 023012DC
.arm

; ===== function loc_023012DC =====
loc_023012DC:
	ldr pc,[pool_023012E0]	; 023012DC
pool_023012E0:
loc_023012E0:
	.word loc_037FCC04	; 023012E0
.thumb

; ===== function loc_023012E4 =====
loc_023012E4:
	bx pc	; 023012E4
	.byte 0xC0, 0x46	; 023012E8
.arm

; ===== function loc_023012E8 =====
loc_023012E8:
	ldr r12,[pool_023012F0]	; 023012E8
	bx r12	; 023012EC
pool_023012F0:
loc_023012F0:
	.word P2_Runtime_037F8134 + 1	; 023012F0
.thumb

; ===== function loc_023012F4 =====
loc_023012F4:
	push {r4,r5,r6,r7,lr}	; 023012F4
	sub sp,#0x4	; 023012F6
	add r6,r0,#0x0	; 023012F8
	add r5,r1,#0x0	; 023012FA
	add r7,r2,#0x0	; 023012FC
	bl loc_023008B4	; 023012FE
	add r4,r0,#0x0	; 02301302
	cmp r5,#0x0	; 02301304
	beq loc_0230130C	; 02301306
	mov r7,#0x0	; 02301308
	b loc_02301350	; 0230130A
loc_0230130C:
	ldrh r0,[r6,#0x14]	; 0230130C
	cmp r0,#0x1	; 0230130E
	bcs loc_02301326	; 02301310
	cmp r7,#0x0	; 02301312
	beq loc_02301322	; 02301314
	ldr r0,[pool_02301378]	; 02301316
	add r0,r4,r0	; 02301318
	mov r1,#0x10	; 0230131A
	bl P4_ClassifyByteArrayAverage	; 0230131C
	b loc_0230136E	; 02301320
loc_02301322:
	mov r7,#0x0	; 02301322
	b loc_02301350	; 02301324
loc_02301326:
	mov r7,#0xff	; 02301326
	mov r5,#0x0	; 02301328
	add r0,r6,#0x0	; 0230132A
	str r0,[sp,#0x0]	; 0230132C
	add r0,#0x1a	; 0230132E
	str r0,[sp,#0x0]	; 02301330
	b loc_0230134A	; 02301332
loc_02301334:
	ldrh r1,[r6,#0x16]	; 02301334
	mul r1,r5	; 02301336
	ldr r0,[sp,#0x0]	; 02301338
	add r0,r0,r1	; 0230133A
	ldrb r0,[r0,#0x3]	; 0230133C
	bl loc_02300470	; 0230133E
	cmp r0,r7	; 02301342
	bcs loc_02301348	; 02301344
	add r7,r0,#0x0	; 02301346
loc_02301348:
	add r5,r5,#0x1	; 02301348
loc_0230134A:
	ldrh r0,[r6,#0x14]	; 0230134A
	cmp r5,r0	; 0230134C
	blt loc_02301334	; 0230134E
loc_02301350:
	ldr r0,[pool_0230137C]	; 02301350
	add r1,r4,r0	; 02301352
	ldr r0,[r1,#0x0]	; 02301354
	add r0,r4,r0	; 02301356
	ldr r2,[pool_02301378]	; 02301358
	strb r7,[r0,r2]	; 0230135A
	ldr r0,[r1,#0x0]	; 0230135C
	add r3,r0,#0x1	; 0230135E
	mov r0,#0xf	; 02301360
	and r3,r0	; 02301362
	str r3,[r1,#0x0]	; 02301364
	add r0,r4,r2	; 02301366
	mov r1,#0x10	; 02301368
	bl P4_ClassifyByteArrayAverage	; 0230136A
loc_0230136E:
	add sp,#0x4	; 0230136E
	pop {r4,r5,r6,r7}	; 02301370
	pop {r3}	; 02301372
	bx r3	; 02301374
	.byte 0xC0, 0x46	; 02301378
pool_02301378:
loc_02301378:
	.word 0x0000151C	; 02301378
pool_0230137C:
loc_0230137C:
	.word 0x0000152C	; 0230137C

; ===== function loc_02301380 =====
loc_02301380:
	push {r4,r5,r6,r7,lr}	; 02301380
	sub sp,#0xc	; 02301382
	add r7,r0,#0x0	; 02301384
	bl loc_023008B4	; 02301386
	ldr r1,[pool_0230152C]	; 0230138A
	ldr r0,[r0,r1]	; 0230138C
	ldr r5,[r0,#0x0]	; 0230138E
	mov r0,#0x0	; 02301390
	str r0,[sp,#0x8]	; 02301392
	ldr r0,[r5,#0x10]	; 02301394
	cmp r0,#0x0	; 02301396
	bne loc_0230139C	; 02301398
	b loc_02301524	; 0230139A
loc_0230139C:
	add r0,r5,#0x0	; 0230139C
	add r0,#0x42	; 0230139E
	ldrh r0,[r0,#0x0]	; 023013A0
	lsl r0,r0,#0x2	; 023013A2
	add r0,r5,r0	; 023013A4
	ldr r4,[r0,#0x48]	; 023013A6
	bl loc_023008B4	; 023013A8
	ldr r1,[pool_02301530]	; 023013AC
	ldr r0,[r0,r1]	; 023013AE
	add r1,r7,#0x0	; 023013B0
	add r1,#0x10	; 023013B2
	add r2,r4,#0x0	; 023013B4
	add r3,r5,#0x0	; 023013B6
	add r3,#0x46	; 023013B8
	ldrh r3,[r3,#0x0]	; 023013BA
	bl loc_023006B4	; 023013BC
	add r0,r7,#0x0	; 023013C0
	ldrh r1,[r4,#0x0]	; 023013C2
	add r2,r5,#0x0	; 023013C4
	add r2,#0x92	; 023013C6
	ldrh r2,[r2,#0x0]	; 023013C8
	bl loc_023012F4	; 023013CA
	add r1,r5,#0x0	; 023013CE
	add r1,#0xb8	; 023013D0
	strh r0,[r1,#0x0]	; 023013D2
	add r6,r4,#0x0	; 023013D4
	add r6,#0xa	; 023013D6
	mov r0,#0x0	; 023013D8
	str r0,[sp,#0x4]	; 023013DA
	b loc_02301420	; 023013DC
loc_023013DE:
	ldrh r1,[r6,#0x0]	; 023013DE
	cmp r1,#0x2	; 023013E0
	bcc loc_02301412	; 023013E2
	ldr r0,[pool_02301534]	; 023013E4
	cmp r1,r0	; 023013E6
	beq loc_02301412	; 023013E8
	sub r0,r1,#0x2	; 023013EA
	strh r0,[r6,#0x0]	; 023013EC
	add r2,r5,#0x0	; 023013EE
	add r2,#0x86	; 023013F0
	ldrh r1,[r2,#0x0]	; 023013F2
	ldrh r0,[r6,#0x4]	; 023013F4
	mov r3,#0x1	; 023013F6
	lsl r3,r0	; 023013F8
	orr r1,r3	; 023013FA
	strh r1,[r2,#0x0]	; 023013FC
	ldrh r3,[r6,#0x0]	; 023013FE
	cmp r3,#0x0	; 02301400
	beq loc_02301412	; 02301402
	str r4,[sp,#0x0]	; 02301404
	ldrh r0,[r6,#0x4]	; 02301406
	ldrh r1,[r6,#0x8]	; 02301408
	add r2,r6,#0x0	; 0230140A
	add r2,#0xa	; 0230140C
	bl loc_02303958	; 0230140E
loc_02301412:
	ldr r0,[sp,#0x4]	; 02301412
	add r0,r0,#0x1	; 02301414
	lsl r0,r0,#0x10	; 02301416
	lsr r0,r0,#0x10	; 02301418
	str r0,[sp,#0x4]	; 0230141A
	ldrh r0,[r4,#0x6]	; 0230141C
	add r6,r6,r0	; 0230141E
loc_02301420:
	ldrh r1,[r4,#0x4]	; 02301420
	ldr r0,[sp,#0x4]	; 02301422
	cmp r0,r1	; 02301424
	bcc loc_023013DE	; 02301426
	mov r0,#0x0	; 02301428
	ldrh r1,[r4,#0x0]	; 0230142A
	bl loc_02303ADC	; 0230142C
	ldrh r0,[r4,#0x0]	; 02301430
	cmp r0,#0x0	; 02301432
	beq loc_0230144A	; 02301434
	add r0,r5,#0x0	; 02301436
	add r0,#0x96	; 02301438
	ldrh r0,[r0,#0x0]	; 0230143A
	cmp r0,#0x0	; 0230143C
	bne loc_0230144A	; 0230143E
	ldrh r0,[r5,#0x3c]	; 02301440
	cmp r0,#0x0	; 02301442
	beq loc_0230144A	; 02301444
	mov r0,#0x1	; 02301446
	str r0,[sp,#0x8]	; 02301448
loc_0230144A:
	bl loc_02300404	; 0230144A
	mov r1,#0xe	; 0230144E
	strh r1,[r0,#0x0]	; 02301450
	mov r1,#0x0	; 02301452
	strh r1,[r0,#0x2]	; 02301454
	mov r1,#0xb	; 02301456
	strh r1,[r0,#0x4]	; 02301458
	str r4,[r0,#0x8]	; 0230145A
	bl loc_02300414	; 0230145C
	bl loc_023012E4	; 02301460
	ldrh r0,[r7,#0x12]	; 02301464
	cmp r0,#0x0	; 02301466
	beq loc_023014A8	; 02301468
	add r0,r5,#0x0	; 0230146A
	add r0,#0xda	; 0230146C
	ldrh r0,[r0,#0x0]	; 0230146E
	cmp r0,#0x0	; 02301470
	bne loc_023014A8	; 02301472
	mov r1,#0x24	; 02301474
	ldr r0,[pool_02301538]	; 02301476
	str r1,[r0,#0x0]	; 02301478
	ldrh r1,[r7,#0x12]	; 0230147A
	str r1,[r0,#0x4]	; 0230147C
	bl loc_023008B4	; 0230147E
	add r0,#0x64	; 02301482
	ldr r1,[pool_02301538]	; 02301484
	mov r2,#0x0	; 02301486
	bl loc_02300824	; 02301488
	cmp r0,#0x0	; 0230148C
	bne loc_023014A8	; 0230148E
	bl loc_02300404	; 02301490
	mov r1,#0x80	; 02301494
	strh r1,[r0,#0x0]	; 02301496
	mov r1,#0x8	; 02301498
	strh r1,[r0,#0x2]	; 0230149A
	mov r1,#0x16	; 0230149C
	strh r1,[r0,#0x4]	; 0230149E
	mov r1,#0x24	; 023014A0
	strh r1,[r0,#0x6]	; 023014A2
	bl loc_02300414	; 023014A4
loc_023014A8:
	add r2,r5,#0x0	; 023014A8
	add r2,#0x42	; 023014AA
	ldrh r1,[r2,#0x0]	; 023014AC
	mov r0,#0x1	; 023014AE
	eor r1,r0	; 023014B0
	strh r1,[r2,#0x0]	; 023014B2
	bl loc_02301540	; 023014B4
	ldr r1,[sp,#0x8]	; 023014B8
	cmp r1,#0x0	; 023014BA
	bne loc_023014C8	; 023014BC
	add r2,r5,#0x0	; 023014BE
	add r2,#0x3e	; 023014C0
	ldrh r1,[r2,#0x0]	; 023014C2
	sub r1,r1,#0x1	; 023014C4
	strh r1,[r2,#0x0]	; 023014C6
loc_023014C8:
	ldrh r1,[r5,#0x3e]	; 023014C8
	cmp r1,#0x0	; 023014CA
	beq loc_023014D2	; 023014CC
	mov r4,#0x1	; 023014CE
	b loc_023014D4	; 023014D0
loc_023014D2:
	mov r4,#0x0	; 023014D2
loc_023014D4:
	bl loc_0230154C	; 023014D4
	cmp r4,#0x0	; 023014D8
	beq loc_02301524	; 023014DA
	ldr r0,[sp,#0x8]	; 023014DC
	cmp r0,#0x1	; 023014DE
	bne loc_023014E6	; 023014E0
	ldrh r5,[r7,#0x10]	; 023014E2
	b loc_023014E8	; 023014E4
loc_023014E6:
	ldr r5,[pool_02301534]	; 023014E6
loc_023014E8:
	bl loc_023008B4	; 023014E8
	add r4,r0,#0x0	; 023014EC
	mov r0,#0x25	; 023014EE
	ldr r1,[pool_0230153C]	; 023014F0
	str r0,[r1,#0x0]	; 023014F2
	str r5,[r1,#0x4]	; 023014F4
	add r0,r4,#0x0	; 023014F6
	add r0,#0x64	; 023014F8
	mov r2,#0x0	; 023014FA
	bl loc_02300824	; 023014FC
	cmp r0,#0x0	; 02301500
	bne loc_02301524	; 02301502
	ldr r0,[pool_0230152C]	; 02301504
	ldr r0,[r4,r0]	; 02301506
	cmp r0,#0x0	; 02301508
	beq loc_02301524	; 0230150A
	bl loc_02300404	; 0230150C
	mov r1,#0x80	; 02301510
	strh r1,[r0,#0x0]	; 02301512
	mov r1,#0x8	; 02301514
	strh r1,[r0,#0x2]	; 02301516
	mov r1,#0x16	; 02301518
	strh r1,[r0,#0x4]	; 0230151A
	mov r1,#0x25	; 0230151C
	strh r1,[r0,#0x6]	; 0230151E
	bl loc_02300414	; 02301520
loc_02301524:
	add sp,#0xc	; 02301524
	pop {r4,r5,r6,r7}	; 02301526
	pop {r3}	; 02301528
	bx r3	; 0230152A
pool_0230152C:
loc_0230152C:
	.word 0x00001518	; 0230152C
pool_02301530:
loc_02301530:
	.word 0x0000150C	; 02301530
pool_02301534:
loc_02301534:
	.word 0x0000FFFF	; 02301534
pool_02301538:
loc_02301538:
	.word P4_BssStart + 0x2404	; 02301538
pool_0230153C:
loc_0230153C:
	.word P4_BssStart + 0x23FC	; 0230153C

; ===== function loc_02301540 =====
loc_02301540:
	bx pc	; 02301540
	.byte 0xC0, 0x46	; 02301544
.arm

; ===== function loc_02301544 =====
loc_02301544:
	ldr pc,[pool_02301548]	; 02301544
pool_02301548:
loc_02301548:
	.word loc_037FCBF0	; 02301548
.thumb

; ===== function loc_0230154C =====
loc_0230154C:
	bx pc	; 0230154C
	.byte 0xC0, 0x46	; 02301550
.arm

; ===== function loc_02301550 =====
loc_02301550:
	ldr pc,[pool_02301554]	; 02301550
pool_02301554:
loc_02301554:
	.word loc_037FCC04	; 02301554
.thumb

; ===== function loc_02301558 =====
loc_02301558:
	push {lr}	; 02301558
	sub sp,#0x4	; 0230155A
	bl loc_02300404	; 0230155C
	mov r1,#0xc	; 02301560
	strh r1,[r0,#0x0]	; 02301562
	mov r1,#0x0	; 02301564
	strh r1,[r0,#0x2]	; 02301566
	mov r1,#0x8	; 02301568
	strh r1,[r0,#0x8]	; 0230156A
	bl loc_02300414	; 0230156C
	add sp,#0x4	; 02301570
	pop {r3}	; 02301572
	bx r3	; 02301574
	.byte 0x00, 0x00	; 02301578

; ===== function loc_02301578 =====
loc_02301578:
	push {r4,r5,r6,r7,lr}	; 02301578
	sub sp,#0x4	; 0230157A
	add r7,r0,#0x0	; 0230157C
	bl loc_023008B4	; 0230157E
	str r0,[sp,#0x0]	; 02301582
	ldr r1,[pool_02301624]	; 02301584
	ldr r6,[r0,r1]	; 02301586
	add r5,r7,#0x0	; 02301588
	add r5,#0x3c	; 0230158A
	ldr r1,[r6,#0x0]	; 0230158C
	ldrh r0,[r1,#0x0]	; 0230158E
	cmp r0,#0x8	; 02301590
	beq loc_02301598	; 02301592
	cmp r0,#0xa	; 02301594
	bne loc_0230161A	; 02301596
loc_02301598:
	add r1,#0xb6	; 02301598
	ldrh r1,[r1,#0x0]	; 0230159A
	ldrh r0,[r5,#0x8]	; 0230159C
	cmp r1,r0	; 0230159E
	beq loc_023015D8	; 023015A0
	mov r1,#0x24	; 023015A2
	ldr r0,[pool_02301628]	; 023015A4
	str r1,[r0,#0x0]	; 023015A6
	mov r1,#0x1	; 023015A8
	str r1,[r0,#0x4]	; 023015AA
	bl loc_023008B4	; 023015AC
	add r0,#0x64	; 023015B0
	ldr r1,[pool_02301628]	; 023015B2
	mov r2,#0x0	; 023015B4
	bl loc_02300824	; 023015B6
	cmp r0,#0x0	; 023015BA
	bne loc_0230161A	; 023015BC
	bl loc_02300404	; 023015BE
	mov r1,#0x80	; 023015C2
	strh r1,[r0,#0x0]	; 023015C4
	mov r1,#0x8	; 023015C6
	strh r1,[r0,#0x2]	; 023015C8
	mov r1,#0x16	; 023015CA
	strh r1,[r0,#0x4]	; 023015CC
	mov r1,#0x24	; 023015CE
	strh r1,[r0,#0x6]	; 023015D0
	bl loc_02300414	; 023015D2
	b loc_0230161A	; 023015D6
loc_023015D8:
	bl loc_02300404	; 023015D8
	add r4,r0,#0x0	; 023015DC
	mov r0,#0x80	; 023015DE
	strh r0,[r4,#0x0]	; 023015E0
	mov r0,#0x0	; 023015E2
	strh r0,[r4,#0x2]	; 023015E4
	mov r0,#0x10	; 023015E6
	strh r0,[r4,#0x4]	; 023015E8
	ldrh r0,[r5,#0x8]	; 023015EA
	strh r0,[r4,#0x6]	; 023015EC
	ldr r0,[r6,#0x0]	; 023015EE
	ldrh r0,[r0,#0x0]	; 023015F0
	strh r0,[r4,#0x8]	; 023015F2
	ldrh r0,[r7,#0x16]	; 023015F4
	strh r0,[r4,#0xa]	; 023015F6
	ldrh r3,[r4,#0xa]	; 023015F8
	cmp r3,#0x80	; 023015FA
	bhi loc_02301614	; 023015FC
	ldr r1,[pool_0230162C]	; 023015FE
	ldr r0,[sp,#0x0]	; 02301600
	ldr r0,[r0,r1]	; 02301602
	add r1,r5,#0x0	; 02301604
	add r2,r4,#0x0	; 02301606
	add r2,#0xc	; 02301608
	add r3,r3,#0x1	; 0230160A
	mov r5,#0x1	; 0230160C
	bic r3,r5	; 0230160E
	bl loc_023006B4	; 02301610
loc_02301614:
	add r0,r4,#0x0	; 02301614
	bl loc_02300414	; 02301616
loc_0230161A:
	add sp,#0x4	; 0230161A
	pop {r4,r5,r6,r7}	; 0230161C
	pop {r3}	; 0230161E
	bx r3	; 02301620
	.byte 0xC0, 0x46	; 02301624
pool_02301624:
loc_02301624:
	.word 0x00001518	; 02301624
pool_02301628:
loc_02301628:
	.word P4_BssStart + 0x23F4	; 02301628
pool_0230162C:
loc_0230162C:
	.word 0x0000150C	; 0230162C

; ===== function loc_02301630 =====
loc_02301630:
	push {lr}	; 02301630
	sub sp,#0x4	; 02301632
	bl loc_02300404	; 02301634
	mov r1,#0x8	; 02301638
	strh r1,[r0,#0x0]	; 0230163A
	mov r1,#0x0	; 0230163C
	strh r1,[r0,#0x2]	; 0230163E
	mov r1,#0x2	; 02301640
	strh r1,[r0,#0x8]	; 02301642
	bl loc_02300414	; 02301644
	add sp,#0x4	; 02301648
	pop {r3}	; 0230164A
	bx r3	; 0230164C
	.byte 0x00, 0x00	; 02301650

; ===== function loc_02301650 =====
loc_02301650:
	bx lr	; 02301650
	.byte 0x00, 0x00	; 02301654

; ===== function loc_02301654 =====
loc_02301654:
	push {r4,r5,r6,lr}	; 02301654
	add r5,r0,#0x0	; 02301656
	bl loc_023008B4	; 02301658
	add r4,r0,#0x0	; 0230165C
	bl loc_02301688	; 0230165E
	add r6,r0,#0x0	; 02301662
	ldr r0,[pool_02301680]	; 02301664
	ldr r0,[r4,r0]	; 02301666
	ldr r1,[pool_02301684]	; 02301668
	ldr r1,[r4,r1]	; 0230166A
	add r2,r5,#0x0	; 0230166C
	bl loc_02301694	; 0230166E
	add r0,r6,#0x0	; 02301672
	bl loc_023016A4	; 02301674
	pop {r4,r5,r6}	; 02301678
	pop {r3}	; 0230167A
	bx r3	; 0230167C
	.byte 0xC0, 0x46	; 02301680
pool_02301680:
loc_02301680:
	.word 0x00001510	; 02301680
pool_02301684:
loc_02301684:
	.word 0x00001514	; 02301684

; ===== function loc_02301688 =====
loc_02301688:
	bx pc	; 02301688
	.byte 0xC0, 0x46	; 0230168C
.arm

; ===== function loc_0230168C =====
loc_0230168C:
	ldr pc,[pool_02301690]	; 0230168C
pool_02301690:
loc_02301690:
	.word loc_037FCBF0	; 02301690
.thumb

; ===== function loc_02301694 =====
loc_02301694:
	bx pc	; 02301694
	.byte 0xC0, 0x46	; 02301698
.arm

; ===== function loc_02301698 =====
loc_02301698:
	ldr r12,[pool_023016A0]	; 02301698
	bx r12	; 0230169C
pool_023016A0:
loc_023016A0:
	.word P2_Entry_037FC20C + 1	; 023016A0
.thumb

; ===== function loc_023016A4 =====
loc_023016A4:
	bx pc	; 023016A4
	.byte 0xC0, 0x46	; 023016A8
.arm

; ===== function loc_023016A8 =====
loc_023016A8:
	ldr pc,[pool_023016AC]	; 023016A8
pool_023016AC:
loc_023016AC:
	.word loc_037FCC04	; 023016AC
.thumb

; ===== function loc_023016B0 =====
loc_023016B0:
	push {r4,lr}	; 023016B0
	add r4,r0,#0x0	; 023016B2
	bl loc_023008B4	; 023016B4
	ldr r1,[pool_023017A8]	; 023016B8
	ldr r0,[r0,r1]	; 023016BA
	cmp r0,#0x0	; 023016BC
	beq loc_023017A0	; 023016BE
	bl loc_023008B4	; 023016C0
	ldr r1,[pool_023017A8]	; 023016C4
	ldr r0,[r0,r1]	; 023016C6
	ldr r0,[r0,#0x0]	; 023016C8
	ldrh r0,[r0,#0x0]	; 023016CA
	cmp r0,#0x1	; 023016CC
	beq loc_023017A0	; 023016CE
	ldrh r0,[r4,#0xc]	; 023016D0
	ldr r1,[pool_023017AC]	; 023016D2
	cmp r0,r1	; 023016D4
	bgt loc_02301712	; 023016D6
	cmp r0,r1	; 023016D8
	bge loc_02301774	; 023016DA
	cmp r0,#0x8d	; 023016DC
	bgt loc_0230170A	; 023016DE
	add r1,r0,#0x0	; 023016E0
	sub r1,#0x84	; 023016E2
	cmp r1,#0x0	; 023016E4
	blt loc_02301794	; 023016E6
	add r1,r1,r1	; 023016E8
P4_SwitchIndexPC_023016E8:
	add r1,pc	; 023016EA
	ldrh r1,[r1,#(P4_SwitchTable_023016E8 - (P4_SwitchIndexPC_023016E8 + 4))]	; 023016EC
	lsl r1,r1,#0x10	; 023016EE
	asr r1,r1,#0x10	; 023016F0
P4_SwitchTargetPC_023016E8:
	add r1,pc	; 023016F2
	bx r1	; 023016F4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_023016E8:
	.halfword (loc_0230172C + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_02301734 + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_0230173C + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_02301744 + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_0230174C + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_02301794 + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_02301794 + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_02301754 + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_0230175C + 1) - (P4_SwitchTargetPC_023016E8 + 4)
	.halfword (loc_02301764 + 1) - (P4_SwitchTargetPC_023016E8 + 4)
P4_SwitchTable_023016E8End:
loc_0230170A:
	ldr r1,[pool_023017B0]	; 0230170A
	cmp r0,r1	; 0230170C
	beq loc_0230176C	; 0230170E
	b loc_02301794	; 02301710
loc_02301712:
	ldr r1,[pool_023017B4]	; 02301712
	cmp r0,r1	; 02301714
	bgt loc_02301724	; 02301716
	cmp r0,r1	; 02301718
	bge loc_02301784	; 0230171A
	ldr r1,[pool_023017B8]	; 0230171C
	cmp r0,r1	; 0230171E
	beq loc_0230177C	; 02301720
	b loc_02301794	; 02301722
loc_02301724:
	ldr r1,[pool_023017BC]	; 02301724
	cmp r0,r1	; 02301726
	beq loc_0230178C	; 02301728
	b loc_02301794	; 0230172A
loc_0230172C:
	add r0,r4,#0x0	; 0230172C
	bl loc_02300A20	; 0230172E
	b loc_0230179A	; 02301732
loc_02301734:
	add r0,r4,#0x0	; 02301734
	bl loc_02300A40	; 02301736
	b loc_0230179A	; 0230173A
loc_0230173C:
	add r0,r4,#0x0	; 0230173C
	bl loc_02300B4C	; 0230173E
	b loc_0230179A	; 02301742
loc_02301744:
	add r0,r4,#0x0	; 02301744
	bl loc_02300C5C	; 02301746
	b loc_0230179A	; 0230174A
loc_0230174C:
	add r0,r4,#0x0	; 0230174C
	bl loc_02300C7C	; 0230174E
	b loc_0230179A	; 02301752
loc_02301754:
	add r0,r4,#0x0	; 02301754
	bl loc_02301558	; 02301756
	b loc_0230179A	; 0230175A
loc_0230175C:
	add r0,r4,#0x0	; 0230175C
	bl loc_02301630	; 0230175E
	b loc_0230179A	; 02301762
loc_02301764:
	add r0,r4,#0x0	; 02301764
	bl loc_02301578	; 02301766
	b loc_0230179A	; 0230176A
loc_0230176C:
	add r0,r4,#0x0	; 0230176C
	bl loc_02300D18	; 0230176E
	b loc_0230179A	; 02301772
loc_02301774:
	add r0,r4,#0x0	; 02301774
	bl loc_02301054	; 02301776
	b loc_0230179A	; 0230177A
loc_0230177C:
	add r0,r4,#0x0	; 0230177C
	bl loc_02301380	; 0230177E
	b loc_0230179A	; 02301782
loc_02301784:
	add r0,r4,#0x0	; 02301784
	bl loc_02300DDC	; 02301786
	b loc_0230179A	; 0230178A
loc_0230178C:
	add r0,r4,#0x0	; 0230178C
	bl loc_02300C9C	; 0230178E
	b loc_0230179A	; 02301792
loc_02301794:
	add r0,r4,#0x0	; 02301794
	bl loc_02301650	; 02301796
loc_0230179A:
	add r0,r4,#0x0	; 0230179A
	bl loc_02301654	; 0230179C
loc_023017A0:
	pop {r4}	; 023017A0
	pop {r3}	; 023017A2
	bx r3	; 023017A4
	.byte 0xC0, 0x46	; 023017A8
pool_023017A8:
loc_023017A8:
	.word 0x00001518	; 023017A8
pool_023017AC:
loc_023017AC:
	.word 0x00000182	; 023017AC
pool_023017B0:
loc_023017B0:
	.word 0x00000180	; 023017B0
pool_023017B4:
loc_023017B4:
	.word 0x00000185	; 023017B4
pool_023017B8:
loc_023017B8:
	.word 0x00000184	; 023017B8
pool_023017BC:
loc_023017BC:
	.word 0x00000186	; 023017BC

; ===== function loc_023017C0 =====
P4_ThreadEntry_023017C0:
	push {r4,r5,r6,r7,lr}	; 023017C0
	sub sp,#0x4	; 023017C2
	bl loc_023008B4	; 023017C4
	add r4,r0,#0x0	; 023017C8
	add r4,#0x40	; 023017CA
	add r5,r0,#0x0	; 023017CC
	add r5,#0x1c	; 023017CE
	mov r7,#0xff	; 023017D0
	ldr r6,[pool_02301818]	; 023017D2
loc_023017D4:
	add r0,r5,#0x0	; 023017D4
	add r1,sp,#0x0	; 023017D6
	mov r2,#0x1	; 023017D8
	bl loc_02300884	; 023017DA
	ldr r2,[sp,#0x0]	; 023017DE
	ldrh r0,[r2,#0xc]	; 023017E0
	add r1,r0,#0x0	; 023017E2
	and r1,r7	; 023017E4
	lsl r1,r1,#0x10	; 023017E6
	lsr r3,r1,#0x10	; 023017E8
	and r0,r6	; 023017EA
	lsl r0,r0,#0x10	; 023017EC
	lsr r1,r0,#0x10	; 023017EE
	cmp r1,#0x0	; 023017F0
	beq loc_023017FA	; 023017F2
	ldr r0,[pool_0230181C]	; 023017F4
	cmp r1,r0	; 023017F6
	bne loc_0230180A	; 023017F8
loc_023017FA:
	mov r0,#0x80	; 023017FA
	and r3,r0	; 023017FC
	cmp r3,#0x0	; 023017FE
	beq loc_0230180A	; 02301800
	add r0,r2,#0x0	; 02301802
	bl loc_023016B0	; 02301804
	b loc_023017D4	; 02301808
loc_0230180A:
	add r0,r4,#0x0	; 0230180A
	add r1,r2,#0x0	; 0230180C
	mov r2,#0x1	; 0230180E
	bl loc_02300824	; 02301810
	b loc_023017D4	; 02301814
	.byte 0xC0, 0x46	; 02301818
pool_02301818:
loc_02301818:
	.word 0x0000FF00	; 02301818
pool_0230181C:
loc_0230181C:
	.word 0x00000100	; 0230181C
	bx lr	; 02301820
	.byte 0x00, 0x00	; 02301824

; ===== function loc_02301824 =====
P4_ThreadEntry_02301824:
	push {r4,r5,r6,r7,lr}	; 02301824
	sub sp,#0x4	; 02301826
	bl loc_023008B4	; 02301828
	add r5,r0,#0x0	; 0230182C
	mov r6,#0x1	; 0230182E
	ldr r7,[pool_02301868]	; 02301830
	ldr r4,[pool_0230186C]	; 02301832
loc_02301834:
	add r0,r5,#0x0	; 02301834
	add r0,#0x64	; 02301836
	add r1,sp,#0x0	; 02301838
	add r2,r6,#0x0	; 0230183A
	bl loc_02300884	; 0230183C
	ldr r0,[sp,#0x0]	; 02301840
	ldrh r1,[r0,#0x0]	; 02301842
	cmp r1,#0x27	; 02301844
	bcs loc_02301834	; 02301846
	ldr r0,[r5,r4]	; 02301848
	ldr r0,[r0,#0x0]	; 0230184A
	str r6,[r0,#0x4]	; 0230184C
	ldr r0,[r5,r4]	; 0230184E
	ldr r0,[r0,#0x0]	; 02301850
	strh r1,[r0,#0x2]	; 02301852
	ldr r0,[sp,#0x0]	; 02301854
	lsl r1,r1,#0x2	; 02301856
	ldr r1,[r7,r1]	; 02301858
	bl loc_02301870	; 0230185A
	ldr r0,[r5,r4]	; 0230185E
	ldr r1,[r0,#0x0]	; 02301860
	mov r0,#0x0	; 02301862
	str r0,[r1,#0x4]	; 02301864
	b loc_02301834	; 02301866
pool_02301868:
loc_02301868:
	.word 0x02310284	; 02301868
pool_0230186C:
loc_0230186C:
	.word 0x00001518	; 0230186C

; ===== function loc_02301870 =====
loc_02301870:
	bx pc	; 02301870
	.byte 0xC0, 0x46	; 02301874
.arm

; ===== function loc_02301874 =====
loc_02301874:
	ldr r12,[pool_0230187C]	; 02301874
	bx r12	; 02301878
pool_0230187C:
loc_0230187C:
	.word loc_038029F8 + 1	; 0230187C
.thumb
loc_02301880:
	push {r4,lr}	; 02301880
	mov r3,#0x0	; 02301882
	strh r3,[r0,#0x0]	; 02301884
	strh r3,[r0,#0x2]	; 02301886
	strh r3,[r0,#0x4]	; 02301888
	strh r3,[r0,#0x6]	; 0230188A
	strh r3,[r0,#0x8]	; 0230188C
	strh r3,[r0,#0xa]	; 0230188E
	strh r1,[r0,#0xc]	; 02301890
	strh r3,[r0,#0xe]	; 02301892
	ldrh r1,[r0,#0xe]	; 02301894
	lsl r1,r1,#0x1	; 02301896
	add r4,r0,r1	; 02301898
	add r4,#0x10	; 0230189A
	ldrh r1,[r0,#0xc]	; 0230189C
	strh r1,[r4,#0x0]	; 0230189E
	strh r2,[r4,#0x2]	; 023018A0
	bl loc_02300834	; 023018A2
	add r0,r4,#0x0	; 023018A6
	pop {r4}	; 023018A8
	pop {r3}	; 023018AA
	bx r3	; 023018AC
	.byte 0x00, 0x00	; 023018B0

; ===== function loc_023018B0 =====
loc_023018B0:
	push {r4,lr}	; 023018B0
	mov r4,#0x0	; 023018B2
	strh r4,[r0,#0x0]	; 023018B4
	strh r4,[r0,#0x2]	; 023018B6
	strh r4,[r0,#0x4]	; 023018B8
	strh r4,[r0,#0x6]	; 023018BA
	strh r4,[r0,#0x8]	; 023018BC
	strh r4,[r0,#0xa]	; 023018BE
	ldr r4,[pool_023018F4]	; 023018C0
	strh r4,[r0,#0xc]	; 023018C2
	mov r4,#0x4	; 023018C4
	strh r4,[r0,#0xe]	; 023018C6
	strh r1,[r0,#0x10]	; 023018C8
	strh r2,[r0,#0x12]	; 023018CA
	strh r3,[r0,#0x14]	; 023018CC
	ldr r1,[pool_023018F8]	; 023018CE
	add r1,sp	; 023018D0
	ldrh r1,[r1,#0x10]	; 023018D2
	strh r1,[r0,#0x16]	; 023018D4
	ldrh r1,[r0,#0xe]	; 023018D6
	lsl r1,r1,#0x1	; 023018D8
	add r4,r0,r1	; 023018DA
	add r4,#0x10	; 023018DC
	ldrh r1,[r0,#0xc]	; 023018DE
	strh r1,[r4,#0x0]	; 023018E0
	mov r1,#0x1	; 023018E2
	strh r1,[r4,#0x2]	; 023018E4
	bl loc_02300834	; 023018E6
	add r0,r4,#0x0	; 023018EA
	pop {r4}	; 023018EC
	pop {r3}	; 023018EE
	bx r3	; 023018F0
	.byte 0xC0, 0x46	; 023018F4
pool_023018F4:
loc_023018F4:
	.word 0x00000309	; 023018F4
pool_023018F8:
loc_023018F8:
	.word 0xFFFFFFF8	; 023018F8

; ===== function loc_023018FC =====
loc_023018FC:
	ldr r1,[pool_02301904]	; 023018FC
	mov r2,#0x2	; 023018FE
	ldr r3,[pool_02301908]	; 02301900
	bx r3	; 02301902
pool_02301904:
loc_02301904:
	.word 0x00000308	; 02301904
pool_02301908:
loc_02301908:
	.word loc_02301880 + 1	; 02301908

; ===== function loc_0230190C =====
loc_0230190C:
	ldr r1,[pool_02301914]	; 0230190C
	mov r2,#0x5c	; 0230190E
	ldr r3,[pool_02301918]	; 02301910
	bx r3	; 02301912
pool_02301914:
loc_02301914:
	.word 0x00000307	; 02301914
pool_02301918:
loc_02301918:
	.word loc_02301880 + 1	; 02301918

; ===== function loc_0230191C =====
loc_0230191C:
	ldr r1,[pool_02301924]	; 0230191C
	mov r2,#0x9	; 0230191E
	ldr r3,[pool_02301928]	; 02301920
	bx r3	; 02301922
pool_02301924:
loc_02301924:
	.word 0x00000306	; 02301924
pool_02301928:
loc_02301928:
	.word loc_02301880 + 1	; 02301928

; ===== function loc_0230192C =====
loc_0230192C:
	ldr r1,[pool_02301934]	; 0230192C
	mov r2,#0x1	; 0230192E
	ldr r3,[pool_02301938]	; 02301930
	bx r3	; 02301932
pool_02301934:
loc_02301934:
	.word 0x00000305	; 02301934
pool_02301938:
loc_02301938:
	.word loc_02301880 + 1	; 02301938

; ===== function loc_0230193C =====
loc_0230193C:
	ldr r1,[pool_02301944]	; 0230193C
	mov r2,#0x1	; 0230193E
	ldr r3,[pool_02301948]	; 02301940
	bx r3	; 02301942
pool_02301944:
loc_02301944:
	.word 0x00000304	; 02301944
pool_02301948:
loc_02301948:
	.word loc_02301880 + 1	; 02301948

; ===== function loc_0230194C =====
loc_0230194C:
	ldr r1,[pool_02301954]	; 0230194C
	mov r2,#0x1	; 0230194E
	ldr r3,[pool_02301958]	; 02301950
	bx r3	; 02301952
pool_02301954:
loc_02301954:
	.word 0x00000303	; 02301954
pool_02301958:
loc_02301958:
	.word loc_02301880 + 1	; 02301958

; ===== function loc_0230195C =====
loc_0230195C:
	ldr r1,[pool_02301964]	; 0230195C
	mov r2,#0x1	; 0230195E
	ldr r3,[pool_02301968]	; 02301960
	bx r3	; 02301962
pool_02301964:
loc_02301964:
	.word 0x00000302	; 02301964
pool_02301968:
loc_02301968:
	.word loc_02301880 + 1	; 02301968

; ===== function loc_0230196C =====
loc_0230196C:
	ldr r1,[pool_02301974]	; 0230196C
	mov r2,#0x1	; 0230196E
	ldr r3,[pool_02301978]	; 02301970
	bx r3	; 02301972
pool_02301974:
loc_02301974:
	.word 0x00000301	; 02301974
pool_02301978:
loc_02301978:
	.word loc_02301880 + 1	; 02301978

; ===== function loc_0230197C =====
loc_0230197C:
	ldr r1,[pool_02301984]	; 0230197C
	mov r2,#0x2	; 0230197E
	ldr r3,[pool_02301988]	; 02301980
	bx r3	; 02301982
pool_02301984:
loc_02301984:
	.word 0x00000284	; 02301984
pool_02301988:
loc_02301988:
	.word loc_02301880 + 1	; 02301988

; ===== function loc_0230198C =====
loc_0230198C:
	ldr r1,[pool_02301994]	; 0230198C
	mov r2,#0x3	; 0230198E
	ldr r3,[pool_02301998]	; 02301990
	bx r3	; 02301992
pool_02301994:
loc_02301994:
	.word 0x00000283	; 02301994
pool_02301998:
loc_02301998:
	.word loc_02301880 + 1	; 02301998

; ===== function loc_0230199C =====
loc_0230199C:
	ldr r1,[pool_023019A4]	; 0230199C
	mov r2,#0x4	; 0230199E
	ldr r3,[pool_023019A8]	; 023019A0
	bx r3	; 023019A2
pool_023019A4:
loc_023019A4:
	.word 0x00000281	; 023019A4
pool_023019A8:
loc_023019A8:
	.word loc_02301880 + 1	; 023019A8

; ===== function loc_023019AC =====
loc_023019AC:
	push {r4,r5,r6,lr}	; 023019AC
	add r5,r0,#0x0	; 023019AE
	add r4,r1,#0x0	; 023019B0
	add r6,r2,#0x0	; 023019B2
	bl loc_023008B4	; 023019B4
	mov r0,#0x0	; 023019B8
	strh r0,[r5,#0x0]	; 023019BA
	strh r0,[r5,#0x2]	; 023019BC
	strh r0,[r5,#0x4]	; 023019BE
	strh r0,[r5,#0x6]	; 023019C0
	strh r0,[r5,#0x8]	; 023019C2
	strh r0,[r5,#0xa]	; 023019C4
	ldr r0,[pool_02301A04]	; 023019C6
	strh r0,[r5,#0xc]	; 023019C8
	add r0,r4,#0x1	; 023019CA
	mov r1,#0x2	; 023019CC
	bl loc_02301A08	; 023019CE
	add r0,r0,#0x1	; 023019D2
	strh r0,[r5,#0xe]	; 023019D4
	strh r4,[r5,#0x10]	; 023019D6
	add r0,r6,#0x0	; 023019D8
	add r1,r5,#0x0	; 023019DA
	add r1,#0x12	; 023019DC
	add r2,r4,#0x0	; 023019DE
	bl loc_02301A14	; 023019E0
	ldrh r0,[r5,#0xe]	; 023019E4
	lsl r0,r0,#0x1	; 023019E6
	add r4,r5,r0	; 023019E8
	add r4,#0x10	; 023019EA
	ldrh r0,[r5,#0xc]	; 023019EC
	strh r0,[r4,#0x0]	; 023019EE
	mov r0,#0x1	; 023019F0
	strh r0,[r4,#0x2]	; 023019F2
	add r0,r5,#0x0	; 023019F4
	bl loc_02300834	; 023019F6
	add r0,r4,#0x0	; 023019FA
	pop {r4,r5,r6}	; 023019FC
	pop {r3}	; 023019FE
	bx r3	; 02301A00
	.byte 0xC0, 0x46	; 02301A04
pool_02301A04:
loc_02301A04:
	.word 0x00000245	; 02301A04

; ===== function loc_02301A08 =====
loc_02301A08:
	bx pc	; 02301A08
	.byte 0xC0, 0x46	; 02301A0C
.arm

; ===== function loc_02301A0C =====
loc_02301A0C:
	ldr pc,[pool_02301A10]	; 02301A0C
pool_02301A10:
loc_02301A10:
	.word loc_03802514	; 02301A10
.thumb

; ===== function loc_02301A14 =====
loc_02301A14:
	bx pc	; 02301A14
	.byte 0xC0, 0x46	; 02301A18
.arm

; ===== function loc_02301A18 =====
loc_02301A18:
	ldr pc,[pool_02301A1C]	; 02301A18
pool_02301A1C:
loc_02301A1C:
	.word P2_Entry_037FCE1C	; 02301A1C
.thumb

; ===== function loc_02301A20 =====
loc_02301A20:
	push {r4,lr}	; 02301A20
	mov r2,#0x0	; 02301A22
	strh r2,[r0,#0x0]	; 02301A24
	strh r2,[r0,#0x2]	; 02301A26
	strh r2,[r0,#0x4]	; 02301A28
	strh r2,[r0,#0x6]	; 02301A2A
	strh r2,[r0,#0x8]	; 02301A2C
	strh r2,[r0,#0xa]	; 02301A2E
	ldr r2,[pool_02301A54]	; 02301A30
	strh r2,[r0,#0xc]	; 02301A32
	mov r2,#0x1	; 02301A34
	strh r2,[r0,#0xe]	; 02301A36
	strh r1,[r0,#0x10]	; 02301A38
	ldrh r1,[r0,#0xe]	; 02301A3A
	lsl r1,r1,#0x1	; 02301A3C
	add r4,r0,r1	; 02301A3E
	add r4,#0x10	; 02301A40
	ldrh r1,[r0,#0xc]	; 02301A42
	strh r1,[r4,#0x0]	; 02301A44
	strh r2,[r4,#0x2]	; 02301A46
	bl loc_02300834	; 02301A48
	add r0,r4,#0x0	; 02301A4C
	pop {r4}	; 02301A4E
	pop {r3}	; 02301A50
	bx r3	; 02301A52
pool_02301A54:
loc_02301A54:
	.word 0x00000215	; 02301A54

; ===== function loc_02301A58 =====
loc_02301A58:
	push {r4,lr}	; 02301A58
	mov r2,#0x0	; 02301A5A
	strh r2,[r0,#0x0]	; 02301A5C
	strh r2,[r0,#0x2]	; 02301A5E
	strh r2,[r0,#0x4]	; 02301A60
	strh r2,[r0,#0x6]	; 02301A62
	strh r2,[r0,#0x8]	; 02301A64
	strh r2,[r0,#0xa]	; 02301A66
	ldr r2,[pool_02301A8C]	; 02301A68
	strh r2,[r0,#0xc]	; 02301A6A
	mov r2,#0x1	; 02301A6C
	strh r2,[r0,#0xe]	; 02301A6E
	strh r1,[r0,#0x10]	; 02301A70
	ldrh r1,[r0,#0xe]	; 02301A72
	lsl r1,r1,#0x1	; 02301A74
	add r4,r0,r1	; 02301A76
	add r4,#0x10	; 02301A78
	ldrh r1,[r0,#0xc]	; 02301A7A
	strh r1,[r4,#0x0]	; 02301A7C
	strh r2,[r4,#0x2]	; 02301A7E
	bl loc_02300834	; 02301A80
	add r0,r4,#0x0	; 02301A84
	pop {r4}	; 02301A86
	pop {r3}	; 02301A88
	bx r3	; 02301A8A
pool_02301A8C:
loc_02301A8C:
	.word 0x00000212	; 02301A8C

; ===== function loc_02301A90 =====
loc_02301A90:
	push {r4,lr}	; 02301A90
	mov r4,#0x0	; 02301A92
	strh r4,[r0,#0x0]	; 02301A94
	strh r4,[r0,#0x2]	; 02301A96
	strh r4,[r0,#0x4]	; 02301A98
	strh r4,[r0,#0x6]	; 02301A9A
	strh r4,[r0,#0x8]	; 02301A9C
	strh r4,[r0,#0xa]	; 02301A9E
	ldr r4,[pool_02301ACC]	; 02301AA0
	strh r4,[r0,#0xc]	; 02301AA2
	mov r4,#0x3	; 02301AA4
	strh r4,[r0,#0xe]	; 02301AA6
	strh r1,[r0,#0x10]	; 02301AA8
	strh r2,[r0,#0x12]	; 02301AAA
	strh r3,[r0,#0x14]	; 02301AAC
	ldrh r1,[r0,#0xe]	; 02301AAE
	lsl r1,r1,#0x1	; 02301AB0
	add r4,r0,r1	; 02301AB2
	add r4,#0x10	; 02301AB4
	ldrh r1,[r0,#0xc]	; 02301AB6
	strh r1,[r4,#0x0]	; 02301AB8
	mov r1,#0x1	; 02301ABA
	strh r1,[r4,#0x2]	; 02301ABC
	bl loc_02300834	; 02301ABE
	add r0,r4,#0x0	; 02301AC2
	pop {r4}	; 02301AC4
	pop {r3}	; 02301AC6
	bx r3	; 02301AC8
	.byte 0xC0, 0x46	; 02301ACC
pool_02301ACC:
loc_02301ACC:
	.word 0x00000211	; 02301ACC

; ===== function loc_02301AD0 =====
loc_02301AD0:
	push {r4,lr}	; 02301AD0
	mov r1,#0x0	; 02301AD2
	strh r1,[r0,#0x0]	; 02301AD4
	strh r1,[r0,#0x2]	; 02301AD6
	strh r1,[r0,#0x4]	; 02301AD8
	strh r1,[r0,#0x6]	; 02301ADA
	strh r1,[r0,#0x8]	; 02301ADC
	strh r1,[r0,#0xa]	; 02301ADE
	ldr r1,[pool_02301B04]	; 02301AE0
	strh r1,[r0,#0xc]	; 02301AE2
	mov r1,#0x48	; 02301AE4
	strh r1,[r0,#0xe]	; 02301AE6
	ldrh r1,[r0,#0xe]	; 02301AE8
	lsl r1,r1,#0x1	; 02301AEA
	add r4,r0,r1	; 02301AEC
	add r4,#0x10	; 02301AEE
	ldrh r1,[r0,#0xc]	; 02301AF0
	strh r1,[r4,#0x0]	; 02301AF2
	mov r1,#0x1	; 02301AF4
	strh r1,[r4,#0x2]	; 02301AF6
	bl loc_02300834	; 02301AF8
	add r0,r4,#0x0	; 02301AFC
	pop {r4}	; 02301AFE
	pop {r3}	; 02301B00
	bx r3	; 02301B02
pool_02301B04:
loc_02301B04:
	.word 0x00000200	; 02301B04

; ===== function loc_02301B08 =====
loc_02301B08:
	push {r4,lr}	; 02301B08
	mov r4,#0x0	; 02301B0A
	strh r4,[r0,#0x0]	; 02301B0C
	strh r4,[r0,#0x2]	; 02301B0E
	strh r4,[r0,#0x4]	; 02301B10
	strh r4,[r0,#0x6]	; 02301B12
	strh r4,[r0,#0x8]	; 02301B14
	strh r4,[r0,#0xa]	; 02301B16
	ldr r4,[pool_02301B60]	; 02301B18
	strh r4,[r0,#0xc]	; 02301B1A
	mov r4,#0xa	; 02301B1C
	strh r4,[r0,#0xe]	; 02301B1E
	strh r1,[r0,#0x10]	; 02301B20
	strh r2,[r0,#0x12]	; 02301B22
	strh r3,[r0,#0x14]	; 02301B24
	ldr r1,[pool_02301B64]	; 02301B26
	add r1,sp	; 02301B28
	ldrh r2,[r1,#0x10]	; 02301B2A
	strh r2,[r0,#0x16]	; 02301B2C
	ldrh r2,[r1,#0x14]	; 02301B2E
	strh r2,[r0,#0x18]	; 02301B30
	ldrh r2,[r1,#0x18]	; 02301B32
	strh r2,[r0,#0x1a]	; 02301B34
	ldrh r2,[r1,#0x1c]	; 02301B36
	strh r2,[r0,#0x1c]	; 02301B38
	ldrh r1,[r1,#0x20]	; 02301B3A
	strh r1,[r0,#0x1e]	; 02301B3C
	ldr r1,[sp,#0x1c]	; 02301B3E
	str r1,[r0,#0x20]	; 02301B40
	ldrh r1,[r0,#0xe]	; 02301B42
	lsl r1,r1,#0x1	; 02301B44
	add r4,r0,r1	; 02301B46
	add r4,#0x10	; 02301B48
	ldrh r1,[r0,#0xc]	; 02301B4A
	strh r1,[r4,#0x0]	; 02301B4C
	mov r1,#0x1	; 02301B4E
	strh r1,[r4,#0x2]	; 02301B50
	bl loc_02300834	; 02301B52
	add r0,r4,#0x0	; 02301B56
	pop {r4}	; 02301B58
	pop {r3}	; 02301B5A
	bx r3	; 02301B5C
	.byte 0xC0, 0x46	; 02301B60
pool_02301B60:
loc_02301B60:
	.word 0x00000102	; 02301B60
pool_02301B64:
loc_02301B64:
	.word 0xFFFFFFF8	; 02301B64

; ===== function loc_02301B68 =====
loc_02301B68:
	push {r4,lr}	; 02301B68
	mov r4,#0x0	; 02301B6A
	strh r4,[r0,#0x0]	; 02301B6C
	strh r4,[r0,#0x2]	; 02301B6E
	strh r4,[r0,#0x4]	; 02301B70
	strh r4,[r0,#0x6]	; 02301B72
	strh r4,[r0,#0x8]	; 02301B74
	strh r4,[r0,#0xa]	; 02301B76
	ldr r4,[pool_02301BA4]	; 02301B78
	strh r4,[r0,#0xc]	; 02301B7A
	mov r4,#0x4	; 02301B7C
	strh r4,[r0,#0xe]	; 02301B7E
	strh r1,[r0,#0x10]	; 02301B80
	strh r2,[r0,#0x12]	; 02301B82
	str r3,[r0,#0x14]	; 02301B84
	ldrh r1,[r0,#0xe]	; 02301B86
	lsl r1,r1,#0x1	; 02301B88
	add r4,r0,r1	; 02301B8A
	add r4,#0x10	; 02301B8C
	ldrh r1,[r0,#0xc]	; 02301B8E
	strh r1,[r4,#0x0]	; 02301B90
	mov r1,#0x1	; 02301B92
	strh r1,[r4,#0x2]	; 02301B94
	bl loc_02300834	; 02301B96
	add r0,r4,#0x0	; 02301B9A
	pop {r4}	; 02301B9C
	pop {r3}	; 02301B9E
	bx r3	; 02301BA0
	.byte 0xC0, 0x46	; 02301BA4
pool_02301BA4:
loc_02301BA4:
	.word 0x00000101	; 02301BA4

; ===== function loc_02301BA8 =====
loc_02301BA8:
	push {r4,r5,lr}	; 02301BA8
	sub sp,#0x4	; 02301BAA
	add r5,r0,#0x0	; 02301BAC
	mov r4,#0x0	; 02301BAE
	strh r4,[r5,#0x0]	; 02301BB0
	strh r4,[r5,#0x2]	; 02301BB2
	strh r4,[r5,#0x4]	; 02301BB4
	strh r4,[r5,#0x6]	; 02301BB6
	strh r4,[r5,#0x8]	; 02301BB8
	strh r4,[r5,#0xa]	; 02301BBA
	mov r0,#0xa	; 02301BBC
	strh r0,[r5,#0xc]	; 02301BBE
	mov r0,#0xc	; 02301BC0
	strh r0,[r5,#0xe]	; 02301BC2
	strh r4,[r5,#0x10]	; 02301BC4
	strh r1,[r5,#0x12]	; 02301BC6
	strh r2,[r5,#0x14]	; 02301BC8
	strh r3,[r5,#0x16]	; 02301BCA
	ldr r0,[sp,#0x10]	; 02301BCC
	add r1,r5,#0x0	; 02301BCE
	add r1,#0x18	; 02301BD0
	mov r2,#0x10	; 02301BD2
	bl loc_02301BF8	; 02301BD4
	ldrh r0,[r5,#0xe]	; 02301BD8
	lsl r0,r0,#0x1	; 02301BDA
	add r4,r5,r0	; 02301BDC
	add r4,#0x10	; 02301BDE
	ldrh r0,[r5,#0xc]	; 02301BE0
	strh r0,[r4,#0x0]	; 02301BE2
	mov r0,#0x12	; 02301BE4
	strh r0,[r4,#0x2]	; 02301BE6
	add r0,r5,#0x0	; 02301BE8
	bl loc_02300834	; 02301BEA
	add r0,r4,#0x0	; 02301BEE
	add sp,#0x4	; 02301BF0
	pop {r4,r5}	; 02301BF2
	pop {r3}	; 02301BF4
	bx r3	; 02301BF6

; ===== function loc_02301BF8 =====
loc_02301BF8:
	bx pc	; 02301BF8
	.byte 0xC0, 0x46	; 02301BFC
.arm

; ===== function loc_02301BFC =====
loc_02301BFC:
	ldr pc,[pool_02301C00]	; 02301BFC
pool_02301C00:
loc_02301C00:
	.word P2_Entry_037FCE1C	; 02301C00
.thumb

; ===== function loc_02301C04 =====
loc_02301C04:
	push {r4,r5,r6,r7,lr}	; 02301C04
	sub sp,#0x4	; 02301C06
	add r5,r0,#0x0	; 02301C08
	add r4,r1,#0x0	; 02301C0A
	add r7,r2,#0x0	; 02301C0C
	add r6,r3,#0x0	; 02301C0E
	mov r0,#0x0	; 02301C10
	strh r0,[r5,#0x0]	; 02301C12
	strh r0,[r5,#0x2]	; 02301C14
	strh r0,[r5,#0x4]	; 02301C16
	strh r0,[r5,#0x6]	; 02301C18
	strh r0,[r5,#0x8]	; 02301C1A
	strh r0,[r5,#0xa]	; 02301C1C
	mov r0,#0x9	; 02301C1E
	strh r0,[r5,#0xc]	; 02301C20
	add r0,sp,#0x8	; 02301C22
	ldrh r0,[r0,#0x20]	; 02301C24
	add r0,r0,#0x1	; 02301C26
	mov r1,#0x2	; 02301C28
	bl loc_02301C84	; 02301C2A
	add r0,#0x17	; 02301C2E
	strh r0,[r5,#0xe]	; 02301C30
	strh r4,[r5,#0x10]	; 02301C32
	add r0,r7,#0x0	; 02301C34
	add r1,r5,#0x0	; 02301C36
	add r1,#0x12	; 02301C38
	mov r2,#0x20	; 02301C3A
	bl loc_02301C90	; 02301C3C
	strh r6,[r5,#0x32]	; 02301C40
	add r0,sp,#0x8	; 02301C42
	ldrh r1,[r0,#0x10]	; 02301C44
	strh r1,[r5,#0x34]	; 02301C46
	ldrh r1,[r0,#0x14]	; 02301C48
	strh r1,[r5,#0x36]	; 02301C4A
	ldrh r1,[r0,#0x18]	; 02301C4C
	strh r1,[r5,#0x38]	; 02301C4E
	ldrh r1,[r0,#0x1c]	; 02301C50
	strh r1,[r5,#0x3a]	; 02301C52
	ldrh r2,[r0,#0x20]	; 02301C54
	strh r2,[r5,#0x3c]	; 02301C56
	ldr r0,[sp,#0x2c]	; 02301C58
	add r1,r5,#0x0	; 02301C5A
	add r1,#0x3e	; 02301C5C
	bl loc_02301C9C	; 02301C5E
	ldrh r0,[r5,#0xe]	; 02301C62
	lsl r0,r0,#0x1	; 02301C64
	add r4,r5,r0	; 02301C66
	add r4,#0x10	; 02301C68
	ldrh r0,[r5,#0xc]	; 02301C6A
	strh r0,[r4,#0x0]	; 02301C6C
	mov r0,#0x1	; 02301C6E
	strh r0,[r4,#0x2]	; 02301C70
	add r0,r5,#0x0	; 02301C72
	bl loc_02300834	; 02301C74
	add r0,r4,#0x0	; 02301C78
	add sp,#0x4	; 02301C7A
	pop {r4,r5,r6,r7}	; 02301C7C
	pop {r3}	; 02301C7E
	bx r3	; 02301C80
	.byte 0xC0, 0x46	; 02301C84

; ===== function loc_02301C84 =====
loc_02301C84:
	bx pc	; 02301C84
	.byte 0xC0, 0x46	; 02301C88
.arm

; ===== function loc_02301C88 =====
loc_02301C88:
	ldr pc,[pool_02301C8C]	; 02301C88
pool_02301C8C:
loc_02301C8C:
	.word loc_03802514	; 02301C8C
.thumb

; ===== function loc_02301C90 =====
loc_02301C90:
	bx pc	; 02301C90
	.byte 0xC0, 0x46	; 02301C94
.arm

; ===== function loc_02301C94 =====
loc_02301C94:
	ldr pc,[pool_02301C98]	; 02301C94
pool_02301C98:
loc_02301C98:
	.word P2_Entry_037FCE1C	; 02301C98
.thumb

; ===== function loc_02301C9C =====
loc_02301C9C:
	bx pc	; 02301C9C
	.byte 0xC0, 0x46	; 02301CA0
.arm

; ===== function loc_02301CA0 =====
loc_02301CA0:
	ldr pc,[pool_02301CA4]	; 02301CA0
pool_02301CA4:
loc_02301CA4:
	.word P2_Entry_037FCE1C	; 02301CA4
.thumb

; ===== function loc_02301CA8 =====
loc_02301CA8:
	push {r4,r5,r6,lr}	; 02301CA8
	add r5,r0,#0x0	; 02301CAA
	add r4,r2,#0x0	; 02301CAC
	add r6,r3,#0x0	; 02301CAE
	mov r0,#0x0	; 02301CB0
	strh r0,[r5,#0x0]	; 02301CB2
	strh r0,[r5,#0x2]	; 02301CB4
	strh r0,[r5,#0x4]	; 02301CB6
	strh r0,[r5,#0x6]	; 02301CB8
	strh r0,[r5,#0x8]	; 02301CBA
	strh r0,[r5,#0xa]	; 02301CBC
	mov r2,#0x6	; 02301CBE
	strh r2,[r5,#0xc]	; 02301CC0
	mov r0,#0x5	; 02301CC2
	strh r0,[r5,#0xe]	; 02301CC4
	add r0,r1,#0x0	; 02301CC6
	add r1,r5,#0x0	; 02301CC8
	add r1,#0x10	; 02301CCA
	bl loc_02301CF4	; 02301CCC
	strh r4,[r5,#0x16]	; 02301CD0
	strh r6,[r5,#0x18]	; 02301CD2
	ldrh r0,[r5,#0xe]	; 02301CD4
	lsl r0,r0,#0x1	; 02301CD6
	add r4,r5,r0	; 02301CD8
	add r4,#0x10	; 02301CDA
	ldrh r0,[r5,#0xc]	; 02301CDC
	strh r0,[r4,#0x0]	; 02301CDE
	mov r0,#0x3	; 02301CE0
	strh r0,[r4,#0x2]	; 02301CE2
	add r0,r5,#0x0	; 02301CE4
	bl loc_02300834	; 02301CE6
	add r0,r4,#0x0	; 02301CEA
	pop {r4,r5,r6}	; 02301CEC
	pop {r3}	; 02301CEE
	bx r3	; 02301CF0
	.byte 0xC0, 0x46	; 02301CF4

; ===== function loc_02301CF4 =====
loc_02301CF4:
	bx pc	; 02301CF4
	.byte 0xC0, 0x46	; 02301CF8
.arm

; ===== function loc_02301CF8 =====
loc_02301CF8:
	ldr pc,[pool_02301CFC]	; 02301CF8
pool_02301CFC:
loc_02301CFC:
	.word P2_Entry_037FCE1C	; 02301CFC
.thumb

; ===== function loc_02301D00 =====
loc_02301D00:
	push {r4,r5,lr}	; 02301D00
	sub sp,#0x4	; 02301D02
	add r4,r0,#0x0	; 02301D04
	add r5,r2,#0x0	; 02301D06
	mov r0,#0x0	; 02301D08
	strh r0,[r4,#0x0]	; 02301D0A
	strh r0,[r4,#0x2]	; 02301D0C
	strh r0,[r4,#0x4]	; 02301D0E
	strh r0,[r4,#0x6]	; 02301D10
	strh r0,[r4,#0x8]	; 02301D12
	strh r0,[r4,#0xa]	; 02301D14
	mov r0,#0x5	; 02301D16
	strh r0,[r4,#0xc]	; 02301D18
	mov r0,#0x4	; 02301D1A
	strh r0,[r4,#0xe]	; 02301D1C
	add r0,r1,#0x0	; 02301D1E
	add r1,r4,#0x0	; 02301D20
	add r1,#0x10	; 02301D22
	mov r2,#0x6	; 02301D24
	bl loc_02301D4C	; 02301D26
	strh r5,[r4,#0x16]	; 02301D2A
	ldrh r0,[r4,#0xe]	; 02301D2C
	lsl r0,r0,#0x1	; 02301D2E
	add r5,r4,r0	; 02301D30
	add r5,#0x10	; 02301D32
	ldrh r0,[r4,#0xc]	; 02301D34
	strh r0,[r5,#0x0]	; 02301D36
	mov r0,#0x4	; 02301D38
	strh r0,[r5,#0x2]	; 02301D3A
	add r0,r4,#0x0	; 02301D3C
	bl loc_02300834	; 02301D3E
	add r0,r5,#0x0	; 02301D42
	add sp,#0x4	; 02301D44
	pop {r4,r5}	; 02301D46
	pop {r3}	; 02301D48
	bx r3	; 02301D4A

; ===== function loc_02301D4C =====
loc_02301D4C:
	bx pc	; 02301D4C
	.byte 0xC0, 0x46	; 02301D50
.arm

; ===== function loc_02301D50 =====
loc_02301D50:
	ldr pc,[pool_02301D54]	; 02301D50
pool_02301D54:
loc_02301D54:
	.word P2_Entry_037FCE1C	; 02301D54
.thumb

; ===== function loc_02301D58 =====
loc_02301D58:
	push {r4,r5,r6,lr}	; 02301D58
	add r5,r0,#0x0	; 02301D5A
	add r4,r2,#0x0	; 02301D5C
	add r6,r3,#0x0	; 02301D5E
	mov r0,#0x0	; 02301D60
	strh r0,[r5,#0x0]	; 02301D62
	strh r0,[r5,#0x2]	; 02301D64
	strh r0,[r5,#0x4]	; 02301D66
	strh r0,[r5,#0x6]	; 02301D68
	strh r0,[r5,#0x8]	; 02301D6A
	strh r0,[r5,#0xa]	; 02301D6C
	mov r0,#0x4	; 02301D6E
	strh r0,[r5,#0xc]	; 02301D70
	mov r0,#0x5	; 02301D72
	strh r0,[r5,#0xe]	; 02301D74
	add r0,r1,#0x0	; 02301D76
	add r1,r5,#0x0	; 02301D78
	add r1,#0x10	; 02301D7A
	mov r2,#0x6	; 02301D7C
	bl loc_02301DA4	; 02301D7E
	strh r4,[r5,#0x16]	; 02301D82
	strh r6,[r5,#0x18]	; 02301D84
	ldrh r0,[r5,#0xe]	; 02301D86
	lsl r0,r0,#0x1	; 02301D88
	add r4,r5,r0	; 02301D8A
	add r4,#0x10	; 02301D8C
	ldrh r0,[r5,#0xc]	; 02301D8E
	strh r0,[r4,#0x0]	; 02301D90
	mov r0,#0x6	; 02301D92
	strh r0,[r4,#0x2]	; 02301D94
	add r0,r5,#0x0	; 02301D96
	bl loc_02300834	; 02301D98
	add r0,r4,#0x0	; 02301D9C
	pop {r4,r5,r6}	; 02301D9E
	pop {r3}	; 02301DA0
	bx r3	; 02301DA2

; ===== function loc_02301DA4 =====
loc_02301DA4:
	bx pc	; 02301DA4
	.byte 0xC0, 0x46	; 02301DA8
.arm

; ===== function loc_02301DA8 =====
loc_02301DA8:
	ldr pc,[pool_02301DAC]	; 02301DA8
pool_02301DAC:
loc_02301DAC:
	.word P2_Entry_037FCE1C	; 02301DAC
.thumb

; ===== function loc_02301DB0 =====
loc_02301DB0:
	push {r4,r5,lr}	; 02301DB0
	sub sp,#0x4	; 02301DB2
	add r5,r0,#0x0	; 02301DB4
	mov r3,#0x0	; 02301DB6
	strh r3,[r5,#0x0]	; 02301DB8
	strh r3,[r5,#0x2]	; 02301DBA
	strh r3,[r5,#0x4]	; 02301DBC
	strh r3,[r5,#0x6]	; 02301DBE
	strh r3,[r5,#0x8]	; 02301DC0
	strh r3,[r5,#0xa]	; 02301DC2
	mov r0,#0x3	; 02301DC4
	strh r0,[r5,#0xc]	; 02301DC6
	mov r0,#0x22	; 02301DC8
	strh r0,[r5,#0xe]	; 02301DCA
	strh r1,[r5,#0x10]	; 02301DCC
	strh r3,[r5,#0x12]	; 02301DCE
	add r0,r2,#0x0	; 02301DD0
	add r1,r5,#0x0	; 02301DD2
	add r1,#0x14	; 02301DD4
	mov r2,#0x44	; 02301DD6
	bl loc_02301DFC	; 02301DD8
	ldrh r0,[r5,#0xe]	; 02301DDC
	lsl r0,r0,#0x1	; 02301DDE
	add r4,r5,r0	; 02301DE0
	add r4,#0x10	; 02301DE2
	ldrh r0,[r5,#0xc]	; 02301DE4
	strh r0,[r4,#0x0]	; 02301DE6
	mov r0,#0x5	; 02301DE8
	strh r0,[r4,#0x2]	; 02301DEA
	add r0,r5,#0x0	; 02301DEC
	bl loc_02300834	; 02301DEE
	add r0,r4,#0x0	; 02301DF2
	add sp,#0x4	; 02301DF4
	pop {r4,r5}	; 02301DF6
	pop {r3}	; 02301DF8
	bx r3	; 02301DFA

; ===== function loc_02301DFC =====
loc_02301DFC:
	bx pc	; 02301DFC
	.byte 0xC0, 0x46	; 02301E00
.arm

; ===== function loc_02301E00 =====
loc_02301E00:
	ldr pc,[pool_02301E04]	; 02301E00
pool_02301E04:
loc_02301E04:
	.word P2_Entry_037FCE1C	; 02301E04
.thumb

; ===== function loc_02301E08 =====
loc_02301E08:
	push {r4,r5,r6,lr}	; 02301E08
	add r4,r0,#0x0	; 02301E0A
	add r6,r1,#0x0	; 02301E0C
	add r5,r3,#0x0	; 02301E0E
	mov r0,#0x0	; 02301E10
	strh r0,[r4,#0x0]	; 02301E12
	strh r0,[r4,#0x2]	; 02301E14
	strh r0,[r4,#0x4]	; 02301E16
	strh r0,[r4,#0x6]	; 02301E18
	strh r0,[r4,#0x8]	; 02301E1A
	strh r0,[r4,#0xa]	; 02301E1C
	mov r0,#0x2	; 02301E1E
	strh r0,[r4,#0xc]	; 02301E20
	mov r0,#0x1f	; 02301E22
	strh r0,[r4,#0xe]	; 02301E24
	add r0,r2,#0x0	; 02301E26
	add r1,r4,#0x0	; 02301E28
	add r1,#0x10	; 02301E2A
	mov r2,#0x6	; 02301E2C
	bl loc_02301E84	; 02301E2E
	strh r5,[r4,#0x16]	; 02301E32
	ldr r0,[sp,#0x10]	; 02301E34
	add r1,r4,#0x0	; 02301E36
	add r1,#0x18	; 02301E38
	mov r2,#0x20	; 02301E3A
	bl loc_02301E90	; 02301E3C
	add r0,sp,#0x0	; 02301E40
	ldrh r0,[r0,#0x14]	; 02301E42
	strh r0,[r4,#0x38]	; 02301E44
	ldr r0,[sp,#0x18]	; 02301E46
	add r1,r4,#0x0	; 02301E48
	add r1,#0x3a	; 02301E4A
	mov r2,#0x10	; 02301E4C
	bl loc_02301E9C	; 02301E4E
	add r0,sp,#0x0	; 02301E52
	ldrh r1,[r0,#0x1c]	; 02301E54
	add r0,r4,#0x0	; 02301E56
	add r0,#0x4a	; 02301E58
	strh r1,[r0,#0x0]	; 02301E5A
	mov r1,#0x0	; 02301E5C
	add r0,r4,#0x0	; 02301E5E
	add r0,#0x4c	; 02301E60
	strh r1,[r0,#0x0]	; 02301E62
	ldrh r0,[r4,#0xe]	; 02301E64
	lsl r0,r0,#0x1	; 02301E66
	add r5,r4,r0	; 02301E68
	add r5,#0x10	; 02301E6A
	ldrh r0,[r4,#0xc]	; 02301E6C
	strh r0,[r5,#0x0]	; 02301E6E
	lsr r0,r6,#0x1	; 02301E70
	sub r0,#0x2c	; 02301E72
	strh r0,[r5,#0x2]	; 02301E74
	add r0,r4,#0x0	; 02301E76
	bl loc_02300834	; 02301E78
	add r0,r5,#0x0	; 02301E7C
	pop {r4,r5,r6}	; 02301E7E
	pop {r3}	; 02301E80
	bx r3	; 02301E82

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
	.word P2_Entry_037FCE1C	; 02301E8C
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
	.word P2_Entry_037FCE1C	; 02301E98
.thumb

; ===== function loc_02301E9C =====
loc_02301E9C:
	bx pc	; 02301E9C
	.byte 0xC0, 0x46	; 02301EA0
.arm

; ===== function loc_02301EA0 =====
loc_02301EA0:
	ldr pc,[pool_02301EA4]	; 02301EA0
pool_02301EA4:
loc_02301EA4:
	.word P2_Entry_037FCE1C	; 02301EA4
.thumb

; ===== function loc_02301EA8 =====
loc_02301EA8:
	push {r4,r5,lr}	; 02301EA8
	sub sp,#0x4	; 02301EAA
	mov r4,#0x0	; 02301EAC
	strh r4,[r0,#0x0]	; 02301EAE
	strh r4,[r0,#0x2]	; 02301EB0
	strh r4,[r0,#0x4]	; 02301EB2
	strh r4,[r0,#0x6]	; 02301EB4
	strh r4,[r0,#0x8]	; 02301EB6
	strh r4,[r0,#0xa]	; 02301EB8
	mov r4,#0x1	; 02301EBA
	strh r4,[r0,#0xc]	; 02301EBC
	mov r5,#0x3	; 02301EBE
	strh r5,[r0,#0xe]	; 02301EC0
	strh r1,[r0,#0x10]	; 02301EC2
	strh r2,[r0,#0x12]	; 02301EC4
	strh r3,[r0,#0x14]	; 02301EC6
	ldrh r1,[r0,#0xe]	; 02301EC8
	lsl r1,r1,#0x1	; 02301ECA
	add r5,r0,r1	; 02301ECC
	add r5,#0x10	; 02301ECE
	ldrh r1,[r0,#0xc]	; 02301ED0
	strh r1,[r5,#0x0]	; 02301ED2
	strh r4,[r5,#0x2]	; 02301ED4
	bl loc_02300834	; 02301ED6
	add r0,r5,#0x0	; 02301EDA
	add sp,#0x4	; 02301EDC
	pop {r4,r5}	; 02301EDE
	pop {r3}	; 02301EE0
	bx r3	; 02301EE2

; ===== function loc_02301EE4 =====
loc_02301EE4:
	push {r4,lr}	; 02301EE4
	mov r2,#0x0	; 02301EE6
	strh r2,[r0,#0x0]	; 02301EE8
	strh r2,[r0,#0x2]	; 02301EEA
	strh r2,[r0,#0x4]	; 02301EEC
	strh r2,[r0,#0x6]	; 02301EEE
	strh r2,[r0,#0x8]	; 02301EF0
	strh r2,[r0,#0xa]	; 02301EF2
	strh r2,[r0,#0xc]	; 02301EF4
	mov r2,#0x1	; 02301EF6
	strh r2,[r0,#0xe]	; 02301EF8
	strh r1,[r0,#0x10]	; 02301EFA
	ldrh r1,[r0,#0xe]	; 02301EFC
	lsl r1,r1,#0x1	; 02301EFE
	add r4,r0,r1	; 02301F00
	add r4,#0x10	; 02301F02
	ldrh r1,[r0,#0xc]	; 02301F04
	strh r1,[r4,#0x0]	; 02301F06
	strh r2,[r4,#0x2]	; 02301F08
	bl loc_02300834	; 02301F0A
	add r0,r4,#0x0	; 02301F0E
	pop {r4}	; 02301F10
	pop {r3}	; 02301F12
	bx r3	; 02301F14
	.byte 0x00, 0x00	; 02301F18
	push {r4,r5,lr}	; 02301F18
	sub sp,#0x4	; 02301F1A
	add r5,r0,#0x0	; 02301F1C
	bl loc_023008B4	; 02301F1E
	ldr r2,[r5,#0x4]	; 02301F22
	ldr r1,[pool_02301F8C]	; 02301F24
	add r0,r0,r1	; 02301F26
	str r2,[r0,#0x0]	; 02301F28
	ldr r4,[r0,#0x0]	; 02301F2A
	ldr r0,[r5,#0x8]	; 02301F2C
	str r0,[r4,#0x0]	; 02301F2E
	ldr r0,[r5,#0xc]	; 02301F30
	str r0,[r4,#0x8]	; 02301F32
	bl loc_023044AC	; 02301F34
	mov r0,#0xf	; 02301F38
	bl loc_02301F90	; 02301F3A
	mov r1,#0x1	; 02301F3E
	ldr r0,[r4,#0x0]	; 02301F40
	strh r1,[r0,#0x0]	; 02301F42
	add r0,sp,#0x0	; 02301F44
	add r1,sp,#0x0	; 02301F46
	add r1,#0x2	; 02301F48
	bl loc_02304608	; 02301F4A
	cmp r0,#0x0	; 02301F4E
	bne loc_02301F6E	; 02301F50
	bl loc_02300404	; 02301F52
	mov r1,#0x0	; 02301F56
	strh r1,[r0,#0x0]	; 02301F58
	mov r1,#0x1	; 02301F5A
	strh r1,[r0,#0x2]	; 02301F5C
	add r1,sp,#0x0	; 02301F5E
	ldrh r2,[r1,#0x0]	; 02301F60
	strh r2,[r0,#0x4]	; 02301F62
	ldrh r1,[r1,#0x2]	; 02301F64
	strh r1,[r0,#0x6]	; 02301F66
	bl loc_02300414	; 02301F68
	b loc_02301F82	; 02301F6C
loc_02301F6E:
	mov r1,#0x2	; 02301F6E
	ldr r0,[r4,#0x0]	; 02301F70
	strh r1,[r0,#0x0]	; 02301F72
	bl loc_02300404	; 02301F74
	mov r1,#0x0	; 02301F78
	strh r1,[r0,#0x0]	; 02301F7A
	strh r1,[r0,#0x2]	; 02301F7C
	bl loc_02300414	; 02301F7E
loc_02301F82:
	add sp,#0x4	; 02301F82
	pop {r4,r5}	; 02301F84
	pop {r3}	; 02301F86
	bx r3	; 02301F88
	.byte 0xC0, 0x46	; 02301F8C
pool_02301F8C:
loc_02301F8C:
	.word 0x00001518	; 02301F8C

; ===== function loc_02301F90 =====
loc_02301F90:
	bx pc	; 02301F90
	.byte 0xC0, 0x46	; 02301F94
.arm

; ===== function loc_02301F94 =====
loc_02301F94:
	ldr r12,[pool_02301F9C]	; 02301F94
	bx r12	; 02301F98
pool_02301F9C:
loc_02301F9C:
	.word loc_03802120 + 1	; 02301F9C
.thumb

; ===== function loc_02301FA0 =====
loc_02301FA0:
	push {r4,r5,lr}	; 02301FA0
	sub sp,#0x4	; 02301FA2
	add r5,r0,#0x0	; 02301FA4
	add r4,r1,#0x0	; 02301FA6
	bl loc_02300404	; 02301FA8
	mov r1,#0x1	; 02301FAC
	strh r1,[r0,#0x0]	; 02301FAE
	strh r1,[r0,#0x2]	; 02301FB0
	strh r5,[r0,#0x4]	; 02301FB2
	strh r4,[r0,#0x6]	; 02301FB4
	bl loc_02300414	; 02301FB6
	add sp,#0x4	; 02301FBA
	pop {r4,r5}	; 02301FBC
	pop {r3}	; 02301FBE
	bx r3	; 02301FC0
	.byte 0x00, 0x00	; 02301FC4
	push {r4,r5,r6,r7,lr}	; 02301FC4
	sub sp,#0x1fc	; 02301FC6
	sub sp,#0x10	; 02301FC8
	bl loc_023008B4	; 02301FCA
	ldr r1,[pool_023020D0]	; 02301FCE
	ldr r5,[r0,r1]	; 02301FD0
	add r7,sp,#0xc	; 02301FD2
	mov r1,#0x0	; 02301FD4
	ldr r0,[r5,#0x0]	; 02301FD6
	str r1,[r0,#0x10]	; 02301FD8
	ldr r0,[r5,#0x0]	; 02301FDA
	str r1,[r0,#0x18]	; 02301FDC
	ldr r0,[r5,#0x0]	; 02301FDE
	str r1,[r0,#0x14]	; 02301FE0
	add r0,r7,#0x0	; 02301FE2
	bl loc_023018FC	; 02301FE4
	ldrh r1,[r0,#0x4]	; 02301FE8
	cmp r1,#0x0	; 02301FEA
	beq loc_02301FF6	; 02301FEC
	ldr r0,[pool_023020D4]	; 02301FEE
	bl loc_02301FA0	; 02301FF0
	b loc_023020C6	; 02301FF4
loc_02301FF6:
	ldrh r4,[r0,#0x6]	; 02301FF6
	add r0,r7,#0x0	; 02301FF8
	bl loc_0230197C	; 02301FFA
	ldrh r1,[r0,#0x4]	; 02301FFE
	cmp r1,#0x0	; 02302000
	beq loc_0230200C	; 02302002
	ldr r0,[pool_023020D4]	; 02302004
	bl loc_02301FA0	; 02302006
	b loc_023020C6	; 0230200A
loc_0230200C:
	ldrh r6,[r0,#0x6]	; 0230200C
	cmp r4,#0x20	; 0230200E
	bgt loc_02302026	; 02302010
	cmp r4,#0x20	; 02302012
	bge loc_02302064	; 02302014
	cmp r4,#0x0	; 02302016
	bgt loc_02302020	; 02302018
	cmp r4,#0x0	; 0230201A
	beq loc_0230207A	; 0230201C
	b loc_023020B0	; 0230201E
loc_02302020:
	cmp r4,#0x10	; 02302020
	beq loc_0230208E	; 02302022
	b loc_023020B0	; 02302024
loc_02302026:
	cmp r4,#0x30	; 02302026
	bgt loc_02302030	; 02302028
	cmp r4,#0x30	; 0230202A
	beq loc_02302034	; 0230202C
	b loc_023020B0	; 0230202E
loc_02302030:
	cmp r4,#0x40	; 02302030
	bne loc_023020B0	; 02302032
loc_02302034:
	ldr r0,[pool_023020D8]	; 02302034
	add r0,r6,r0	; 02302036
	lsl r0,r0,#0x10	; 02302038
	lsr r0,r0,#0x10	; 0230203A
	cmp r0,#0x1	; 0230203C
	bhi loc_02302064	; 0230203E
	add r0,sp,#0x4	; 02302040
	ldr r2,[r5,#0x0]	; 02302042
	ldr r1,[pool_023020DC]	; 02302044
	add r1,r2,r1	; 02302046
	bl loc_023007BC	; 02302048
	add r0,r7,#0x0	; 0230204C
	add r1,sp,#0x4	; 0230204E
	mov r2,#0x3	; 02302050
	bl loc_02301D00	; 02302052
	ldrh r1,[r0,#0x4]	; 02302056
	cmp r1,#0x0	; 02302058
	beq loc_02302064	; 0230205A
	mov r0,#0x5	; 0230205C
	bl loc_02301FA0	; 0230205E
	b loc_023020C6	; 02302062
loc_02302064:
	add r0,r7,#0x0	; 02302064
	mov r1,#0x1	; 02302066
	bl loc_02301EE4	; 02302068
	ldrh r1,[r0,#0x4]	; 0230206C
	cmp r1,#0x0	; 0230206E
	beq loc_0230207A	; 02302070
	mov r0,#0x0	; 02302072
	bl loc_02301FA0	; 02302074
	b loc_023020C6	; 02302078
loc_0230207A:
	add r0,r7,#0x0	; 0230207A
	bl loc_0230195C	; 0230207C
	ldrh r1,[r0,#0x4]	; 02302080
	cmp r1,#0x0	; 02302082
	beq loc_0230208E	; 02302084
	ldr r0,[pool_023020E0]	; 02302086
	bl loc_02301FA0	; 02302088
	b loc_023020C6	; 0230208C
loc_0230208E:
	cmp r6,#0x0	; 0230208E
	bne loc_023020B0	; 02302090
	mov r0,#0x1	; 02302092
	str r0,[sp,#0x0]	; 02302094
	add r0,r7,#0x0	; 02302096
	mov r1,#0x0	; 02302098
	add r2,r1,#0x0	; 0230209A
	mov r3,#0x14	; 0230209C
	bl loc_023018B0	; 0230209E
	ldrh r1,[r0,#0x4]	; 023020A2
	cmp r1,#0x0	; 023020A4
	beq loc_023020B0	; 023020A6
	ldr r0,[pool_023020E4]	; 023020A8
	bl loc_02301FA0	; 023020AA
	b loc_023020C6	; 023020AE
loc_023020B0:
	mov r1,#0x2	; 023020B0
	ldr r0,[r5,#0x0]	; 023020B2
	strh r1,[r0,#0x0]	; 023020B4
	bl loc_02300404	; 023020B6
	mov r1,#0x1	; 023020BA
	strh r1,[r0,#0x0]	; 023020BC
	mov r1,#0x0	; 023020BE
	strh r1,[r0,#0x2]	; 023020C0
	bl loc_02300414	; 023020C2
loc_023020C6:
	add sp,#0x1fc	; 023020C6
	add sp,#0x10	; 023020C8
	pop {r4,r5,r6,r7}	; 023020CA
	pop {r3}	; 023020CC
	bx r3	; 023020CE
pool_023020D0:
loc_023020D0:
	.word 0x00001518	; 023020D0
pool_023020D4:
loc_023020D4:
	.word 0x00000308	; 023020D4
pool_023020D8:
loc_023020D8:
	.word 0x0000FFFE	; 023020D8
pool_023020DC:
loc_023020DC:
	.word 0x00000186	; 023020DC
pool_023020E0:
loc_023020E0:
	.word 0x00000302	; 023020E0
pool_023020E4:
loc_023020E4:
	.word 0x00000309	; 023020E4

; ===== function loc_023020E8 =====
loc_023020E8:
	push {r4,r5,lr}	; 023020E8
	sub sp,#0x4	; 023020EA
	add r5,r0,#0x0	; 023020EC
	add r4,r1,#0x0	; 023020EE
	bl loc_02300404	; 023020F0
	mov r1,#0x2	; 023020F4
	strh r1,[r0,#0x0]	; 023020F6
	mov r1,#0x1	; 023020F8
	strh r1,[r0,#0x2]	; 023020FA
	strh r5,[r0,#0x4]	; 023020FC
	strh r4,[r0,#0x6]	; 023020FE
	bl loc_02300414	; 02302100
	add sp,#0x4	; 02302104
	pop {r4,r5}	; 02302106
	pop {r3}	; 02302108
	bx r3	; 0230210A

; ===== function loc_0230210C =====
	push {r4,lr}	; 0230210C
	sub sp,#0x1fc	; 0230210E
	sub sp,#0x4	; 02302110
	bl loc_023008B4	; 02302112
	ldr r1,[pool_02302174]	; 02302116
	ldr r4,[r0,r1]	; 02302118
	ldr r0,[r4,#0x0]	; 0230211A
	ldrh r0,[r0,#0x0]	; 0230211C
	cmp r0,#0x2	; 0230211E
	beq loc_02302134	; 02302120
	bl loc_02300404	; 02302122
	mov r1,#0x2	; 02302126
	strh r1,[r0,#0x0]	; 02302128
	mov r1,#0x3	; 0230212A
	strh r1,[r0,#0x2]	; 0230212C
	bl loc_02300414	; 0230212E
	b loc_02302168	; 02302132
loc_02302134:
	add r0,sp,#0x0	; 02302134
	bl loc_0230196C	; 02302136
	ldrh r1,[r0,#0x4]	; 0230213A
	cmp r1,#0x0	; 0230213C
	beq loc_02302148	; 0230213E
	ldr r0,[pool_02302178]	; 02302140
	bl loc_023020E8	; 02302142
	b loc_02302168	; 02302146
loc_02302148:
	mov r0,#0x1	; 02302148
	ldr r1,[r4,#0x0]	; 0230214A
	strh r0,[r1,#0x0]	; 0230214C
	bl loc_02301F90	; 0230214E
	mov r1,#0x0	; 02302152
	ldr r0,[r4,#0x0]	; 02302154
	strh r1,[r0,#0x0]	; 02302156
	bl loc_02300404	; 02302158
	mov r1,#0x2	; 0230215C
	strh r1,[r0,#0x0]	; 0230215E
	mov r1,#0x0	; 02302160
	strh r1,[r0,#0x2]	; 02302162
	bl loc_02300414	; 02302164
loc_02302168:
	add sp,#0x1fc	; 02302168
	add sp,#0x4	; 0230216A
	pop {r4}	; 0230216C
	pop {r3}	; 0230216E
	bx r3	; 02302170
	.byte 0xC0, 0x46	; 02302174
pool_02302174:
loc_02302174:
	.word 0x00001518	; 02302174
pool_02302178:
loc_02302178:
	.word 0x00000301	; 02302178

; ===== function loc_0230217C =====
loc_0230217C:
	push {r4,r5,lr}	; 0230217C
	sub sp,#0x4	; 0230217E
	add r5,r0,#0x0	; 02302180
	add r4,r1,#0x0	; 02302182
	bl loc_02300404	; 02302184
	mov r1,#0x7	; 02302188
	strh r1,[r0,#0x0]	; 0230218A
	mov r1,#0x1	; 0230218C
	strh r1,[r0,#0x2]	; 0230218E
	strh r5,[r0,#0x4]	; 02302190
	strh r4,[r0,#0x6]	; 02302192
	bl loc_02300414	; 02302194
	add sp,#0x4	; 02302198
	pop {r4,r5}	; 0230219A
	pop {r3}	; 0230219C
	bx r3	; 0230219E

; ===== function loc_023021A0 =====
	push {r4,r5,lr}	; 023021A0
	sub sp,#0x1fc	; 023021A2
	sub sp,#0x8	; 023021A4
	add r5,r0,#0x0	; 023021A6
	bl loc_023008B4	; 023021A8
	ldr r1,[pool_0230221C]	; 023021AC
	ldr r4,[r0,r1]	; 023021AE
	bl loc_023008B4	; 023021B0
	ldr r1,[pool_02302220]	; 023021B4
	ldr r0,[r0,r1]	; 023021B6
	ldr r1,[r5,#0x4]	; 023021B8
	ldr r2,[r4,#0x0]	; 023021BA
	add r2,#0xe4	; 023021BC
	mov r3,#0x40	; 023021BE
	bl loc_023006B4	; 023021C0
	ldr r2,[r4,#0x0]	; 023021C4
	mov r1,#0x1	; 023021C6
	ldr r0,[pool_02302224]	; 023021C8
	ldrh r0,[r2,r0]	; 023021CA
	lsl r1,r0	; 023021CC
	ldr r0,[pool_02302228]	; 023021CE
	ldrh r0,[r2,r0]	; 023021D0
	and r1,r0	; 023021D2
	cmp r1,#0x0	; 023021D4
	bne loc_023021EA	; 023021D6
	bl loc_02300404	; 023021D8
	mov r1,#0x7	; 023021DC
	strh r1,[r0,#0x0]	; 023021DE
	mov r1,#0x6	; 023021E0
	strh r1,[r0,#0x2]	; 023021E2
	bl loc_02300414	; 023021E4
	b loc_02302212	; 023021E8
loc_023021EA:
	add r0,sp,#0x0	; 023021EA
	add r2,#0xf2	; 023021EC
	ldrh r1,[r2,#0x0]	; 023021EE
	bl loc_02301A58	; 023021F0
	ldrh r1,[r0,#0x4]	; 023021F4
	cmp r1,#0x0	; 023021F6
	beq loc_02302202	; 023021F8
	ldr r0,[pool_0230222C]	; 023021FA
	bl loc_0230217C	; 023021FC
	b loc_02302212	; 02302200
loc_02302202:
	bl loc_02300404	; 02302202
	mov r1,#0x7	; 02302206
	strh r1,[r0,#0x0]	; 02302208
	mov r1,#0x0	; 0230220A
	strh r1,[r0,#0x2]	; 0230220C
	bl loc_02300414	; 0230220E
loc_02302212:
	add sp,#0x1fc	; 02302212
	add sp,#0x8	; 02302214
	pop {r4,r5}	; 02302216
	pop {r3}	; 02302218
	bx r3	; 0230221A
pool_0230221C:
loc_0230221C:
	.word 0x00001518	; 0230221C
pool_02302220:
loc_02302220:
	.word 0x0000150C	; 02302220
pool_02302224:
loc_02302224:
	.word 0x00000114	; 02302224
pool_02302228:
loc_02302228:
	.word 0x000001F0	; 02302228
pool_0230222C:
loc_0230222C:
	.word 0x00000212	; 0230222C

; ===== function loc_02302230 =====
loc_02302230:
	push {r4,r5,lr}	; 02302230
	sub sp,#0x4	; 02302232
	add r5,r0,#0x0	; 02302234
	add r4,r1,#0x0	; 02302236
	bl loc_02300404	; 02302238
	mov r1,#0x8	; 0230223C
	strh r1,[r0,#0x0]	; 0230223E
	mov r1,#0x1	; 02302240
	strh r1,[r0,#0x2]	; 02302242
	mov r1,#0x0	; 02302244
	strh r1,[r0,#0x8]	; 02302246
	strh r5,[r0,#0x4]	; 02302248
	strh r4,[r0,#0x6]	; 0230224A
	bl loc_02300414	; 0230224C
	add sp,#0x4	; 02302250
	pop {r4,r5}	; 02302252
	pop {r3}	; 02302254
	bx r3	; 02302256

; ===== function loc_02302258 =====
	push {r4,r5,r6,lr}	; 02302258
	sub sp,#0x1fc	; 0230225A
	sub sp,#0xc4	; 0230225C
	add r6,sp,#0x3c	; 0230225E
	bl loc_023008B4	; 02302260
	ldr r1,[pool_02302384]	; 02302264
	ldr r5,[r0,r1]	; 02302266
	mov r1,#0x1	; 02302268
	ldr r0,[r5,#0x0]	; 0230226A
	add r0,#0xe2	; 0230226C
	strh r1,[r0,#0x0]	; 0230226E
	mov r0,#0x0	; 02302270
	ldr r2,[r5,#0x0]	; 02302272
	ldr r1,[pool_02302388]	; 02302274
	strh r0,[r2,r1]	; 02302276
	ldr r2,[r5,#0x0]	; 02302278
	ldr r1,[pool_0230238C]	; 0230227A
	strh r0,[r2,r1]	; 0230227C
	ldr r1,[r5,#0x0]	; 0230227E
	add r1,#0x86	; 02302280
	strh r0,[r1,#0x0]	; 02302282
	mov r0,#0x8	; 02302284
	add r1,r6,#0x0	; 02302286
	bl loc_0230056C	; 02302288
	cmp r0,#0x0	; 0230228C
	beq loc_0230237A	; 0230228E
	add r0,r6,#0x0	; 02302290
	bl loc_0230194C	; 02302292
	ldrh r1,[r0,#0x4]	; 02302296
	cmp r1,#0x0	; 02302298
	beq loc_023022A4	; 0230229A
	ldr r0,[pool_02302390]	; 0230229C
	bl loc_02302230	; 0230229E
	b loc_0230237A	; 023022A2
loc_023022A4:
	add r0,r6,#0x0	; 023022A4
	mov r1,#0x1	; 023022A6
	mov r2,#0x0	; 023022A8
	add r3,r1,#0x0	; 023022AA
	bl loc_02301EA8	; 023022AC
	ldrh r1,[r0,#0x4]	; 023022B0
	cmp r1,#0x0	; 023022B2
	beq loc_023022BE	; 023022B4
	mov r0,#0x1	; 023022B6
	bl loc_02302230	; 023022B8
	b loc_0230237A	; 023022BC
loc_023022BE:
	ldr r4,[r5,#0x0]	; 023022BE
	add r4,#0xe4	; 023022C0
	mov r1,#0x0	; 023022C2
	add r0,sp,#0x18	; 023022C4
	strh r1,[r0,#0x0]	; 023022C6
	ldrh r0,[r0,#0x0]	; 023022C8
	add r1,sp,#0x23c	; 023022CA
	mov r2,#0x80	; 023022CC
	bl loc_0230239C	; 023022CE
	add r0,sp,#0x23c	; 023022D2
	add r1,r4,#0x0	; 023022D4
	bl loc_023006DC	; 023022D6
	mov r1,#0x0	; 023022DA
	add r0,sp,#0x18	; 023022DC
	strh r1,[r0,#0x2]	; 023022DE
	ldrh r0,[r0,#0x2]	; 023022E0
	add r1,sp,#0x1c	; 023022E2
	mov r2,#0x20	; 023022E4
	bl loc_023023A8	; 023022E6
	ldrh r1,[r4,#0x6]	; 023022EA
	add r0,sp,#0x18	; 023022EC
	strh r1,[r0,#0x4]	; 023022EE
	ldrh r1,[r4,#0x8]	; 023022F0
	strh r1,[r0,#0x6]	; 023022F2
	ldrh r1,[r4,#0xa]	; 023022F4
	strh r1,[r0,#0x8]	; 023022F6
	mov r1,#0x0	; 023022F8
	strh r1,[r0,#0xa]	; 023022FA
	mov r0,#0x2	; 023022FC
	str r0,[sp,#0x0]	; 023022FE
	ldrh r0,[r4,#0x30]	; 02302300
	str r0,[sp,#0x4]	; 02302302
	mov r0,#0x3	; 02302304
	str r0,[sp,#0x8]	; 02302306
	str r0,[sp,#0xc]	; 02302308
	ldrh r0,[r4,#0x4]	; 0230230A
	add r0,#0x10	; 0230230C
	lsl r0,r0,#0x10	; 0230230E
	lsr r0,r0,#0x10	; 02302310
	str r0,[sp,#0x10]	; 02302312
	add r0,sp,#0x23c	; 02302314
	str r0,[sp,#0x14]	; 02302316
	add r0,r6,#0x0	; 02302318
	mov r1,#0x20	; 0230231A
	add r2,sp,#0x1c	; 0230231C
	ldrh r3,[r4,#0x16]	; 0230231E
	bl loc_02301C04	; 02302320
	ldrh r1,[r0,#0x4]	; 02302324
	cmp r1,#0x0	; 02302326
	beq loc_02302332	; 02302328
	mov r0,#0x9	; 0230232A
	bl loc_02302230	; 0230232C
	b loc_0230237A	; 02302330
loc_02302332:
	ldrh r0,[r4,#0x12]	; 02302332
	cmp r0,#0x0	; 02302334
	beq loc_0230233C	; 02302336
	mov r1,#0x2a	; 02302338
	b loc_0230233E	; 0230233A
loc_0230233C:
	mov r1,#0x0	; 0230233C
loc_0230233E:
	ldrh r0,[r4,#0x32]	; 0230233E
	add r0,r0,#0x4	; 02302340
	add r2,r0,r1	; 02302342
	ldr r1,[r5,#0x0]	; 02302344
	ldr r0,[pool_02302394]	; 02302346
	strh r2,[r1,r0]	; 02302348
	ldrh r0,[r4,#0x12]	; 0230234A
	cmp r0,#0x0	; 0230234C
	beq loc_02302354	; 0230234E
	mov r1,#0x6	; 02302350
	b loc_02302356	; 02302352
loc_02302354:
	mov r1,#0x0	; 02302354
loc_02302356:
	ldrh r0,[r4,#0x34]	; 02302356
	add r0,r0,#0x2	; 02302358
	add r2,r0,r1	; 0230235A
	ldr r1,[r5,#0x0]	; 0230235C
	ldr r0,[pool_02302398]	; 0230235E
	strh r2,[r1,r0]	; 02302360
	bl loc_02300404	; 02302362
	mov r2,#0x7	; 02302366
	ldr r1,[r5,#0x0]	; 02302368
	strh r2,[r1,#0x0]	; 0230236A
	mov r1,#0x8	; 0230236C
	strh r1,[r0,#0x0]	; 0230236E
	mov r1,#0x0	; 02302370
	strh r1,[r0,#0x2]	; 02302372
	strh r1,[r0,#0x8]	; 02302374
	bl loc_02300414	; 02302376
loc_0230237A:
	add sp,#0x1fc	; 0230237A
	add sp,#0xc4	; 0230237C
	pop {r4,r5,r6}	; 0230237E
	pop {r3}	; 02302380
	bx r3	; 02302382
pool_02302384:
loc_02302384:
	.word 0x00001518	; 02302384
pool_02302388:
loc_02302388:
	.word 0x00000184	; 02302388
pool_0230238C:
loc_0230238C:
	.word 0x0000017E	; 0230238C
pool_02302390:
loc_02302390:
	.word 0x00000303	; 02302390
pool_02302394:
loc_02302394:
	.word 0x0000018E	; 02302394
pool_02302398:
loc_02302398:
	.word 0x00000190	; 02302398

; ===== function loc_0230239C =====
loc_0230239C:
	bx pc	; 0230239C
	.byte 0xC0, 0x46	; 023023A0
.arm

; ===== function loc_023023A0 =====
loc_023023A0:
	ldr pc,[pool_023023A4]	; 023023A0
pool_023023A4:
loc_023023A4:
	.word loc_037FCE04	; 023023A4
.thumb

; ===== function loc_023023A8 =====
loc_023023A8:
	bx pc	; 023023A8
	.byte 0xC0, 0x46	; 023023AC
.arm

; ===== function loc_023023AC =====
loc_023023AC:
	ldr pc,[pool_023023B0]	; 023023AC
pool_023023B0:
loc_023023B0:
	.word loc_037FCE04	; 023023B0
.thumb

; ===== function loc_023023B4 =====
loc_023023B4:
	push {r4,r5,lr}	; 023023B4
	sub sp,#0x4	; 023023B6
	add r5,r0,#0x0	; 023023B8
	add r4,r1,#0x0	; 023023BA
	bl loc_02300404	; 023023BC
	mov r1,#0x9	; 023023C0
	strh r1,[r0,#0x0]	; 023023C2
	mov r1,#0x1	; 023023C4
	strh r1,[r0,#0x2]	; 023023C6
	strh r5,[r0,#0x4]	; 023023C8
	strh r4,[r0,#0x6]	; 023023CA
	bl loc_02300414	; 023023CC
	add sp,#0x4	; 023023D0
	pop {r4,r5}	; 023023D2
	pop {r3}	; 023023D4
	bx r3	; 023023D6

; ===== function loc_023023D8 =====
	push {r4,r5,r6,r7,lr}	; 023023D8
	sub sp,#0x1fc	; 023023DA
	sub sp,#0x10	; 023023DC
	bl loc_023008B4	; 023023DE
	ldr r1,[pool_0230248C]	; 023023E2
	ldr r5,[r0,r1]	; 023023E4
	mov r4,#0x1	; 023023E6
	add r7,r4,#0x0	; 023023E8
loc_023023EA:
	ldr r1,[r5,#0x0]	; 023023EA
	add r6,r7,#0x0	; 023023EC
	lsl r6,r4	; 023023EE
	ldr r0,[pool_02302490]	; 023023F0
	ldrh r0,[r1,r0]	; 023023F2
	and r0,r6	; 023023F4
	cmp r0,#0x0	; 023023F6
	beq loc_0230242C	; 023023F8
	add r0,sp,#0x0	; 023023FA
	ldr r2,[pool_02302494]	; 023023FC
	add r3,r1,r2	; 023023FE
	sub r2,r4,#0x1	; 02302400
	mov r1,#0x6	; 02302402
	mul r2,r1	; 02302404
	add r1,r3,r2	; 02302406
	bl loc_023007BC	; 02302408
	add r0,sp,#0x8	; 0230240C
	add r1,sp,#0x0	; 0230240E
	mov r2,#0x3	; 02302410
	bl loc_02301D00	; 02302412
	ldr r1,[r5,#0x0]	; 02302416
	ldr r0,[pool_02302490]	; 02302418
	add r1,r1,r0	; 0230241A
	ldrh r0,[r1,#0x0]	; 0230241C
	bic r0,r6	; 0230241E
	strh r0,[r1,#0x0]	; 02302420
	ldr r1,[r5,#0x0]	; 02302422
	add r1,#0x86	; 02302424
	ldrh r0,[r1,#0x0]	; 02302426
	bic r0,r6	; 02302428
	strh r0,[r1,#0x0]	; 0230242A
loc_0230242C:
	add r4,r4,#0x1	; 0230242C
	cmp r4,#0x10	; 0230242E
	blt loc_023023EA	; 02302430
	add r0,sp,#0x8	; 02302432
	mov r1,#0x1	; 02302434
	bl loc_02301EE4	; 02302436
	ldrh r1,[r0,#0x4]	; 0230243A
	cmp r1,#0x0	; 0230243C
	beq loc_02302448	; 0230243E
	mov r0,#0x0	; 02302440
	bl loc_023023B4	; 02302442
	b loc_02302480	; 02302446
loc_02302448:
	add r0,sp,#0x8	; 02302448
	bl loc_0230195C	; 0230244A
	ldrh r1,[r0,#0x4]	; 0230244E
	cmp r1,#0x0	; 02302450
	beq loc_0230245C	; 02302452
	ldr r0,[pool_02302498]	; 02302454
	bl loc_023023B4	; 02302456
	b loc_02302480	; 0230245A
loc_0230245C:
	mov r1,#0x2	; 0230245C
	ldr r0,[r5,#0x0]	; 0230245E
	strh r1,[r0,#0x0]	; 02302460
	mov r2,#0x0	; 02302462
	ldr r1,[r5,#0x0]	; 02302464
	ldr r0,[pool_0230249C]	; 02302466
	strh r2,[r1,r0]	; 02302468
	ldr r1,[r5,#0x0]	; 0230246A
	ldr r0,[pool_023024A0]	; 0230246C
	strh r2,[r1,r0]	; 0230246E
	bl loc_02300404	; 02302470
	mov r1,#0x9	; 02302474
	strh r1,[r0,#0x0]	; 02302476
	mov r1,#0x0	; 02302478
	strh r1,[r0,#0x2]	; 0230247A
	bl loc_02300414	; 0230247C
loc_02302480:
	add sp,#0x1fc	; 02302480
	add sp,#0x10	; 02302482
	pop {r4,r5,r6,r7}	; 02302484
	pop {r3}	; 02302486
	bx r3	; 02302488
	.byte 0xC0, 0x46	; 0230248C
pool_0230248C:
loc_0230248C:
	.word 0x00001518	; 0230248C
pool_02302490:
loc_02302490:
	.word 0x0000017E	; 02302490
pool_02302494:
loc_02302494:
	.word 0x00000124	; 02302494
pool_02302498:
loc_02302498:
	.word 0x00000302	; 02302498
pool_0230249C:
loc_0230249C:
	.word 0x0000018E	; 0230249C
pool_023024A0:
loc_023024A0:
	.word 0x00000190	; 023024A0

; ===== function loc_023024A4 =====
loc_023024A4:
	push {r4,r5,lr}	; 023024A4
	sub sp,#0x4	; 023024A6
	add r5,r0,#0x0	; 023024A8
	add r4,r1,#0x0	; 023024AA
	bl loc_02300404	; 023024AC
	mov r1,#0xa	; 023024B0
	strh r1,[r0,#0x0]	; 023024B2
	mov r1,#0x1	; 023024B4
	strh r1,[r0,#0x2]	; 023024B6
	strh r5,[r0,#0x4]	; 023024B8
	strh r4,[r0,#0x6]	; 023024BA
	bl loc_02300414	; 023024BC
	add sp,#0x4	; 023024C0
	pop {r4,r5}	; 023024C2
	pop {r3}	; 023024C4
	bx r3	; 023024C6

; ===== function loc_023024C8 =====
	push {r4,r5,r6,r7,lr}	; 023024C8
	sub sp,#0x1fc	; 023024CA
	sub sp,#0x58	; 023024CC
	add r4,r0,#0x0	; 023024CE
	bl loc_023008B4	; 023024D0
	str r0,[sp,#0x10]	; 023024D4
	ldr r1,[pool_023026E4]	; 023024D6
	ldr r6,[r0,r1]	; 023024D8
	ldr r2,[r4,#0x4]	; 023024DA
	ldr r1,[r6,#0x0]	; 023024DC
	ldr r0,[pool_023026E8]	; 023024DE
	str r2,[r1,r0]	; 023024E0
	ldrh r7,[r4,#0x2]	; 023024E2
	ldr r1,[r6,#0x0]	; 023024E4
	ldr r0,[pool_023026EC]	; 023024E6
	strh r7,[r1,r0]	; 023024E8
	ldrh r5,[r4,#0x8]	; 023024EA
	ldrh r1,[r4,#0xa]	; 023024EC
	add r0,sp,#0x14	; 023024EE
	strh r1,[r0,#0x4]	; 023024F0
	ldrh r1,[r4,#0xc]	; 023024F2
	strh r1,[r0,#0x6]	; 023024F4
	ldrh r1,[r4,#0xe]	; 023024F6
	strh r1,[r0,#0x8]	; 023024F8
	cmp r7,#0x0	; 023024FA
	bne loc_0230250E	; 023024FC
	bl loc_02300404	; 023024FE
	mov r1,#0xa	; 02302502
	strh r1,[r0,#0x0]	; 02302504
	mov r1,#0x6	; 02302506
	strh r1,[r0,#0x2]	; 02302508
	bl loc_02300414	; 0230250A
loc_0230250E:
	ldr r0,[r6,#0x0]	; 0230250E
	mov r2,#0x1	; 02302510
	lsl r2,r7	; 02302512
	ldr r1,[pool_023026F0]	; 02302514
	ldrh r1,[r0,r1]	; 02302516
	and r2,r1	; 02302518
	cmp r2,#0x0	; 0230251A
	bne loc_02302530	; 0230251C
	bl loc_02300404	; 0230251E
	mov r1,#0xa	; 02302522
	strh r1,[r0,#0x0]	; 02302524
	mov r1,#0x6	; 02302526
	strh r1,[r0,#0x2]	; 02302528
	bl loc_02300414	; 0230252A
	b loc_023026D8	; 0230252E
loc_02302530:
	mov r1,#0x2	; 02302530
	add r0,#0xe2	; 02302532
	strh r1,[r0,#0x0]	; 02302534
	add r0,sp,#0x50	; 02302536
	bl loc_023018FC	; 02302538
	ldrh r1,[r0,#0x4]	; 0230253C
	cmp r1,#0x0	; 0230253E
	beq loc_0230254A	; 02302540
	ldr r0,[pool_023026F4]	; 02302542
	bl loc_023024A4	; 02302544
	b loc_023026D8	; 02302548
loc_0230254A:
	ldrh r0,[r0,#0x6]	; 0230254A
	cmp r0,#0x10	; 0230254C
	bne loc_02302592	; 0230254E
	mov r0,#0xa	; 02302550
	add r1,sp,#0x50	; 02302552
	bl loc_0230056C	; 02302554
	cmp r0,#0x0	; 02302558
	bne loc_0230255E	; 0230255A
	b loc_023026D8	; 0230255C
loc_0230255E:
	add r0,sp,#0x50	; 0230255E
	bl loc_0230194C	; 02302560
	ldrh r1,[r0,#0x4]	; 02302564
	cmp r1,#0x0	; 02302566
	beq loc_02302572	; 02302568
	ldr r0,[pool_023026F8]	; 0230256A
	bl loc_023024A4	; 0230256C
	b loc_023026D8	; 02302570
loc_02302572:
	mov r1,#0x3	; 02302572
	ldr r0,[r6,#0x0]	; 02302574
	strh r1,[r0,#0x0]	; 02302576
	add r0,sp,#0x50	; 02302578
	mov r1,#0x1	; 0230257A
	mov r2,#0x0	; 0230257C
	add r3,r1,#0x0	; 0230257E
	bl loc_02301EA8	; 02302580
	ldrh r1,[r0,#0x4]	; 02302584
	cmp r1,#0x0	; 02302586
	beq loc_02302592	; 02302588
	mov r0,#0x1	; 0230258A
	bl loc_023024A4	; 0230258C
	b loc_023026D8	; 02302590
loc_02302592:
	mov r1,#0x5	; 02302592
	ldr r0,[r6,#0x0]	; 02302594
	strh r1,[r0,#0x0]	; 02302596
	ldr r1,[pool_023026FC]	; 02302598
	add r0,sp,#0x14	; 0230259A
	strh r1,[r0,#0x2]	; 0230259C
	ldrh r0,[r0,#0x2]	; 0230259E
	add r1,sp,#0x1c	; 023025A0
	add r1,#0x2	; 023025A2
	mov r2,#0x20	; 023025A4
	bl loc_02302708	; 023025A6
	add r0,sp,#0x3c	; 023025AA
	add r0,#0x2	; 023025AC
	strb r7,[r0,#0x0]	; 023025AE
	add r0,sp,#0x3c	; 023025B0
	add r0,#0x3	; 023025B2
	mov r1,#0x0	; 023025B4
	mov r2,#0xf	; 023025B6
	bl loc_02302714	; 023025B8
	add r0,sp,#0x1c	; 023025BC
	add r0,#0x2	; 023025BE
	str r0,[sp,#0x0]	; 023025C0
	mov r0,#0x1	; 023025C2
	str r0,[sp,#0x4]	; 023025C4
	add r0,sp,#0x3c	; 023025C6
	add r0,#0x2	; 023025C8
	str r0,[sp,#0x8]	; 023025CA
	str r5,[sp,#0xc]	; 023025CC
	add r0,sp,#0x50	; 023025CE
	ldr r1,[pool_02302700]	; 023025D0
	add r2,sp,#0x18	; 023025D2
	mov r3,#0x0	; 023025D4
	bl loc_02301E08	; 023025D6
	add r4,r0,#0x0	; 023025DA
	ldrh r1,[r4,#0x4]	; 023025DC
	cmp r1,#0x0	; 023025DE
	beq loc_023025EA	; 023025E0
	mov r0,#0x2	; 023025E2
	bl loc_023024A4	; 023025E4
	b loc_023026D8	; 023025E8
loc_023025EA:
	bl loc_02300404	; 023025EA
	add r5,r0,#0x0	; 023025EE
	ldrh r0,[r4,#0x8]	; 023025F0
	cmp r0,#0x0	; 023025F2
	bne loc_02302608	; 023025F4
	mov r0,#0xa	; 023025F6
	strh r0,[r5,#0x0]	; 023025F8
	mov r1,#0x0	; 023025FA
	strh r1,[r5,#0x2]	; 023025FC
	mov r0,#0x4	; 023025FE
	strh r0,[r5,#0x8]	; 02302600
	strh r7,[r5,#0x10]	; 02302602
	strh r1,[r5,#0x12]	; 02302604
	b loc_023026D2	; 02302606
loc_02302608:
	ldr r1,[pool_02302704]	; 02302608
	ldr r0,[sp,#0x10]	; 0230260A
	ldr r0,[r0,r1]	; 0230260C
	ldr r2,[r6,#0x0]	; 0230260E
	ldr r1,[pool_023026E8]	; 02302610
	ldr r1,[r2,r1]	; 02302612
	add r1,#0x40	; 02302614
	mov r2,#0x0	; 02302616
	mov r3,#0x80	; 02302618
	bl loc_02302720	; 0230261A
	ldr r1,[pool_02302704]	; 0230261E
	ldr r0,[sp,#0x10]	; 02302620
	ldr r0,[r0,r1]	; 02302622
	add r1,r4,#0x0	; 02302624
	add r1,#0xa	; 02302626
	ldr r3,[r6,#0x0]	; 02302628
	ldr r2,[pool_023026E8]	; 0230262A
	ldr r2,[r3,r2]	; 0230262C
	ldrh r3,[r4,#0xa]	; 0230262E
	lsl r3,r3,#0x1	; 02302630
	bl loc_023006B4	; 02302632
	mov r0,#0xa	; 02302636
	strh r0,[r5,#0x0]	; 02302638
	mov r0,#0x0	; 0230263A
	strh r0,[r5,#0x2]	; 0230263C
	mov r0,#0x5	; 0230263E
	strh r0,[r5,#0x8]	; 02302640
	add r0,r4,#0x0	; 02302642
	add r0,#0x40	; 02302644
	ldrh r0,[r0,#0x0]	; 02302646
	strh r0,[r5,#0x10]	; 02302648
	ldrh r0,[r4,#0xc]	; 0230264A
	lsl r0,r0,#0x18	; 0230264C
	lsr r0,r0,#0x18	; 0230264E
	bl loc_02300470	; 02302650
	add r1,sp,#0x14	; 02302654
	strb r0,[r1,#0x0]	; 02302656
	add r0,sp,#0x14	; 02302658
	mov r1,#0x1	; 0230265A
	bl P4_ClassifyByteArrayAverage	; 0230265C
	strh r0,[r5,#0x12]	; 02302660
	ldrh r0,[r4,#0x14]	; 02302662
	strh r0,[r5,#0x14]	; 02302664
	add r0,r5,#0x0	; 02302666
	add r0,#0xa	; 02302668
	add r1,r4,#0x0	; 0230266A
	add r1,#0xe	; 0230266C
	bl loc_023007BC	; 0230266E
	ldr r1,[pool_02302704]	; 02302672
	ldr r0,[sp,#0x10]	; 02302674
	ldr r0,[r0,r1]	; 02302676
	add r1,r4,#0x0	; 02302678
	add r1,#0x16	; 0230267A
	add r2,r5,#0x0	; 0230267C
	add r2,#0x16	; 0230267E
	mov r3,#0x20	; 02302680
	bl loc_023006B4	; 02302682
	add r0,r4,#0x0	; 02302686
	add r0,#0x46	; 02302688
	ldrh r0,[r0,#0x0]	; 0230268A
	strh r0,[r5,#0x36]	; 0230268C
	ldrh r0,[r5,#0x36]	; 0230268E
	cmp r0,#0x80	; 02302690
	bls loc_023026A6	; 02302692
	mov r0,#0xa	; 02302694
	strh r0,[r5,#0x0]	; 02302696
	mov r1,#0x0	; 02302698
	strh r1,[r5,#0x2]	; 0230269A
	mov r0,#0x4	; 0230269C
	strh r0,[r5,#0x8]	; 0230269E
	strh r7,[r5,#0x10]	; 023026A0
	strh r1,[r5,#0x12]	; 023026A2
	b loc_023026D2	; 023026A4
loc_023026A6:
	ldr r1,[pool_02302704]	; 023026A6
	ldr r0,[sp,#0x10]	; 023026A8
	ldr r0,[r0,r1]	; 023026AA
	add r1,r5,#0x0	; 023026AC
	add r1,#0x38	; 023026AE
	mov r2,#0x0	; 023026B0
	mov r3,#0x80	; 023026B2
	bl loc_02302720	; 023026B4
	ldr r1,[pool_02302704]	; 023026B8
	ldr r0,[sp,#0x10]	; 023026BA
	ldr r0,[r0,r1]	; 023026BC
	add r4,#0x4a	; 023026BE
	add r1,r4,#0x0	; 023026C0
	add r2,r5,#0x0	; 023026C2
	add r2,#0x38	; 023026C4
	ldrh r3,[r5,#0x36]	; 023026C6
	add r3,r3,#0x1	; 023026C8
	mov r4,#0x1	; 023026CA
	bic r3,r4	; 023026CC
	bl loc_023006B4	; 023026CE
loc_023026D2:
	add r0,r5,#0x0	; 023026D2
	bl loc_02300414	; 023026D4
loc_023026D8:
	add sp,#0x1fc	; 023026D8
	add sp,#0x58	; 023026DA
	pop {r4,r5,r6,r7}	; 023026DC
	pop {r3}	; 023026DE
	bx r3	; 023026E0
	.byte 0xC0, 0x46	; 023026E4
pool_023026E4:
loc_023026E4:
	.word 0x00001518	; 023026E4
pool_023026E8:
loc_023026E8:
	.word 0x00000180	; 023026E8
pool_023026EC:
loc_023026EC:
	.word 0x0000018C	; 023026EC
pool_023026F0:
loc_023026F0:
	.word 0x000001F0	; 023026F0
pool_023026F4:
loc_023026F4:
	.word 0x00000308	; 023026F4
pool_023026F8:
loc_023026F8:
	.word 0x00000303	; 023026F8
pool_023026FC:
loc_023026FC:
	.word 0x0000FFFF	; 023026FC
pool_02302700:
loc_02302700:
	.word 0x0000011C	; 02302700
pool_02302704:
loc_02302704:
	.word 0x0000150C	; 02302704

; ===== function loc_02302708 =====
loc_02302708:
	bx pc	; 02302708
	.byte 0xC0, 0x46	; 0230270C
.arm

; ===== function loc_0230270C =====
loc_0230270C:
	ldr pc,[pool_02302710]	; 0230270C
pool_02302710:
loc_02302710:
	.word loc_037FCE04	; 02302710
.thumb

; ===== function loc_02302714 =====
loc_02302714:
	bx pc	; 02302714
	.byte 0xC0, 0x46	; 02302718
.arm

; ===== function loc_02302718 =====
loc_02302718:
	ldr pc,[pool_0230271C]	; 02302718
pool_0230271C:
loc_0230271C:
	.word loc_037FCEB0	; 0230271C
.thumb

; ===== function loc_02302720 =====
loc_02302720:
	bx pc	; 02302720
	.byte 0xC0, 0x46	; 02302724
.arm

; ===== function loc_02302724 =====
loc_02302724:
	ldr r12,[pool_0230272C]	; 02302724
	bx r12	; 02302728
pool_0230272C:
loc_0230272C:
	.word P2_Entry_037FCD94 + 1	; 0230272C
.thumb

; ===== function loc_02302730 =====
loc_02302730:
	push {r4,r5,lr}	; 02302730
	sub sp,#0x4	; 02302732
	add r5,r0,#0x0	; 02302734
	add r4,r1,#0x0	; 02302736
	bl loc_02300404	; 02302738
	mov r1,#0xb	; 0230273C
	strh r1,[r0,#0x0]	; 0230273E
	mov r1,#0x1	; 02302740
	strh r1,[r0,#0x2]	; 02302742
	strh r5,[r0,#0x4]	; 02302744
	strh r4,[r0,#0x6]	; 02302746
	bl loc_02300414	; 02302748
	add sp,#0x4	; 0230274C
	pop {r4,r5}	; 0230274E
	pop {r3}	; 02302750
	bx r3	; 02302752

; ===== function loc_02302754 =====
	push {r4,r5,lr}	; 02302754
	sub sp,#0x1fc	; 02302756
	sub sp,#0x8	; 02302758
	add r5,sp,#0x0	; 0230275A
	bl loc_023008B4	; 0230275C
	ldr r1,[pool_023027B4]	; 02302760
	ldr r4,[r0,r1]	; 02302762
	ldr r0,[r4,#0x0]	; 02302764
	ldrh r0,[r0,#0x0]	; 02302766
	cmp r0,#0x5	; 02302768
	beq loc_0230277E	; 0230276A
	bl loc_02300404	; 0230276C
	mov r1,#0xb	; 02302770
	strh r1,[r0,#0x0]	; 02302772
	mov r1,#0x3	; 02302774
	strh r1,[r0,#0x2]	; 02302776
	bl loc_02300414	; 02302778
	b loc_023027A8	; 0230277C
loc_0230277E:
	add r0,r5,#0x0	; 0230277E
	bl loc_0230195C	; 02302780
	ldrh r1,[r0,#0x4]	; 02302784
	cmp r1,#0x0	; 02302786
	beq loc_02302792	; 02302788
	ldr r0,[pool_023027B8]	; 0230278A
	bl loc_02302730	; 0230278C
	b loc_023027A8	; 02302790
loc_02302792:
	mov r1,#0x2	; 02302792
	ldr r0,[r4,#0x0]	; 02302794
	strh r1,[r0,#0x0]	; 02302796
	bl loc_02300404	; 02302798
	mov r1,#0xb	; 0230279C
	strh r1,[r0,#0x0]	; 0230279E
	mov r1,#0x0	; 023027A0
	strh r1,[r0,#0x2]	; 023027A2
	bl loc_02300414	; 023027A4
loc_023027A8:
	add sp,#0x1fc	; 023027A8
	add sp,#0x8	; 023027AA
	pop {r4,r5}	; 023027AC
	pop {r3}	; 023027AE
	bx r3	; 023027B0
	.byte 0xC0, 0x46	; 023027B4
pool_023027B4:
loc_023027B4:
	.word 0x00001518	; 023027B4
pool_023027B8:
loc_023027B8:
	.word 0x00000302	; 023027B8

; ===== function loc_023027BC =====
loc_023027BC:
	push {r4,r5,lr}	; 023027BC
	sub sp,#0x4	; 023027BE
	add r5,r0,#0x0	; 023027C0
	add r4,r1,#0x0	; 023027C2
	bl loc_02300404	; 023027C4
	mov r1,#0xc	; 023027C8
	strh r1,[r0,#0x0]	; 023027CA
	mov r1,#0x1	; 023027CC
	strh r1,[r0,#0x2]	; 023027CE
	strh r5,[r0,#0x4]	; 023027D0
	strh r4,[r0,#0x6]	; 023027D2
	bl loc_02300414	; 023027D4
	add sp,#0x4	; 023027D8
	pop {r4,r5}	; 023027DA
	pop {r3}	; 023027DC
	bx r3	; 023027DE

; ===== function loc_023027E0 =====
	push {r4,r5,r6,r7,lr}	; 023027E0
	sub sp,#0x1fc	; 023027E2
	sub sp,#0x58	; 023027E4
	add r5,r0,#0x0	; 023027E6
	add r7,sp,#0x10	; 023027E8
	bl loc_023008B4	; 023027EA
	add r6,r0,#0x0	; 023027EE
	ldr r0,[pool_02302AC0]	; 023027F0
	ldr r4,[r6,r0]	; 023027F2
	ldr r0,[pool_02302AC4]	; 023027F4
	ldr r0,[r6,r0]	; 023027F6
	ldr r1,[r5,#0x4]	; 023027F8
	add r2,r4,#0x0	; 023027FA
	add r2,#0x10	; 023027FC
	mov r3,#0xc0	; 023027FE
	bl loc_023006B4	; 02302800
	add r0,r4,#0x0	; 02302804
	add r0,#0x4c	; 02302806
	ldrh r0,[r0,#0x0]	; 02302808
	cmp r0,#0x10	; 0230280A
	bcc loc_02302832	; 0230280C
	add r0,r4,#0x0	; 0230280E
	add r0,#0x5b	; 02302810
	ldrb r1,[r0,#0x0]	; 02302812
	mov r0,#0x1	; 02302814
	and r1,r0	; 02302816
	cmp r1,#0x0	; 02302818
	bne loc_02302832	; 0230281A
	bl loc_02300404	; 0230281C
	mov r1,#0xc	; 02302820
	strh r1,[r0,#0x0]	; 02302822
	mov r1,#0xb	; 02302824
	strh r1,[r0,#0x2]	; 02302826
	mov r1,#0x6	; 02302828
	strh r1,[r0,#0x8]	; 0230282A
	bl loc_02300414	; 0230282C
	b loc_02302AB6	; 02302830
loc_02302832:
	mov r0,#0x1	; 02302832
	add r1,r4,#0x0	; 02302834
	add r1,#0x46	; 02302836
	ldrh r1,[r1,#0x0]	; 02302838
	lsl r0,r1	; 0230283A
	ldr r2,[r4,#0x0]	; 0230283C
	ldr r1,[pool_02302AC8]	; 0230283E
	ldrh r1,[r2,r1]	; 02302840
	and r0,r1	; 02302842
	cmp r0,#0x0	; 02302844
	bne loc_0230285C	; 02302846
	bl loc_02300404	; 02302848
	mov r1,#0xc	; 0230284C
	strh r1,[r0,#0x0]	; 0230284E
	mov r1,#0x6	; 02302850
	strh r1,[r0,#0x2]	; 02302852
	strh r1,[r0,#0x8]	; 02302854
	bl loc_02300414	; 02302856
	b loc_02302AB6	; 0230285A
loc_0230285C:
	bl loc_02300404	; 0230285C
	mov r1,#0xc	; 02302860
	strh r1,[r0,#0x0]	; 02302862
	mov r1,#0x0	; 02302864
	strh r1,[r0,#0x2]	; 02302866
	mov r1,#0x6	; 02302868
	strh r1,[r0,#0x8]	; 0230286A
	bl loc_02300414	; 0230286C
	ldr r1,[r4,#0x0]	; 02302870
	ldr r0,[pool_02302ACC]	; 02302872
	add r0,r1,r0	; 02302874
	ldrh r1,[r0,#0x0]	; 02302876
	cmp r1,#0x1	; 02302878
	bne loc_02302890	; 0230287A
	ldrh r2,[r4,#0x3e]	; 0230287C
	mov r1,#0x1	; 0230287E
	and r2,r1	; 02302880
	cmp r2,#0x0	; 02302882
	beq loc_0230288A	; 02302884
	strh r1,[r0,#0x0]	; 02302886
	b loc_023028A2	; 02302888
loc_0230288A:
	mov r1,#0x2	; 0230288A
	strh r1,[r0,#0x0]	; 0230288C
	b loc_023028A2	; 0230288E
loc_02302890:
	ldrh r2,[r4,#0x3e]	; 02302890
	mov r1,#0x2	; 02302892
	and r2,r1	; 02302894
	cmp r2,#0x0	; 02302896
	beq loc_0230289E	; 02302898
	strh r1,[r0,#0x0]	; 0230289A
	b loc_023028A2	; 0230289C
loc_0230289E:
	mov r1,#0x1	; 0230289E
	strh r1,[r0,#0x0]	; 023028A0
loc_023028A2:
	ldrh r1,[r4,#0x3c]	; 023028A2
	mov r0,#0x20	; 023028A4
	and r1,r0	; 023028A6
	cmp r1,#0x0	; 023028A8
	beq loc_023028B6	; 023028AA
	mov r2,#0x1	; 023028AC
	ldr r1,[r4,#0x0]	; 023028AE
	ldr r0,[pool_02302AD0]	; 023028B0
	strh r2,[r1,r0]	; 023028B2
	b loc_023028BE	; 023028B4
loc_023028B6:
	mov r2,#0x0	; 023028B6
	ldr r1,[r4,#0x0]	; 023028B8
	ldr r0,[pool_02302AD0]	; 023028BA
	strh r2,[r1,r0]	; 023028BC
loc_023028BE:
	ldrh r1,[r4,#0x3c]	; 023028BE
	mov r0,#0x10	; 023028C0
	and r1,r0	; 023028C2
	cmp r1,#0x0	; 023028C4
	beq loc_023028D2	; 023028C6
	mov r2,#0x1	; 023028C8
	ldr r1,[r4,#0x0]	; 023028CA
	ldr r0,[pool_02302AD4]	; 023028CC
	str r2,[r1,r0]	; 023028CE
	b loc_023028DA	; 023028D0
loc_023028D2:
	mov r2,#0x0	; 023028D2
	ldr r1,[r4,#0x0]	; 023028D4
	ldr r0,[pool_02302AD4]	; 023028D6
	str r2,[r1,r0]	; 023028D8
loc_023028DA:
	add r0,r4,#0x0	; 023028DA
	add r0,#0x4c	; 023028DC
	ldrh r0,[r0,#0x0]	; 023028DE
	cmp r0,#0x0	; 023028E0
	bne loc_023028EE	; 023028E2
	mov r1,#0x3	; 023028E4
	ldr r0,[r4,#0x0]	; 023028E6
	add r0,#0xe2	; 023028E8
	strh r1,[r0,#0x0]	; 023028EA
	b loc_023028F6	; 023028EC
loc_023028EE:
	mov r1,#0x2	; 023028EE
	ldr r0,[r4,#0x0]	; 023028F0
	add r0,#0xe2	; 023028F2
	strh r1,[r0,#0x0]	; 023028F4
loc_023028F6:
	mov r0,#0xc	; 023028F6
	add r1,r7,#0x0	; 023028F8
	bl loc_0230056C	; 023028FA
	cmp r0,#0x0	; 023028FE
	bne loc_02302904	; 02302900
	b loc_02302AB6	; 02302902
loc_02302904:
	add r0,r7,#0x0	; 02302904
	bl loc_0230194C	; 02302906
	ldrh r1,[r0,#0x4]	; 0230290A
	cmp r1,#0x0	; 0230290C
	beq loc_02302918	; 0230290E
	ldr r0,[pool_02302AD8]	; 02302910
	bl loc_023027BC	; 02302912
	b loc_02302AB6	; 02302916
loc_02302918:
	ldr r0,[pool_02302AC4]	; 02302918
	ldr r0,[r6,r0]	; 0230291A
	add r1,r4,#0x0	; 0230291C
	add r1,#0x10	; 0230291E
	add r2,sp,#0x210	; 02302920
	mov r3,#0x40	; 02302922
	bl loc_023006B4	; 02302924
	ldr r0,[r4,#0x0]	; 02302928
	add r0,#0xe2	; 0230292A
	ldrh r0,[r0,#0x0]	; 0230292C
	cmp r0,#0x2	; 0230292E
	bne loc_02302960	; 02302930
	mov r0,#0x20	; 02302932
	add r1,sp,#0x210	; 02302934
	strh r0,[r1,#0xa]	; 02302936
	add r0,r4,#0x0	; 02302938
	add r0,#0x54	; 0230293A
	ldrh r0,[r0,#0x0]	; 0230293C
	strh r0,[r1,#0xc]	; 0230293E
	add r0,r4,#0x0	; 02302940
	add r0,#0x56	; 02302942
	ldrh r0,[r0,#0x0]	; 02302944
	strh r0,[r1,#0xe]	; 02302946
	add r0,r4,#0x0	; 02302948
	add r0,#0x58	; 0230294A
	ldrh r0,[r0,#0x0]	; 0230294C
	strh r0,[r1,#0x10]	; 0230294E
	mov r0,#0x0	; 02302950
	strh r0,[r1,#0x12]	; 02302952
	add r5,#0x8	; 02302954
	add r0,r5,#0x0	; 02302956
	add r1,sp,#0x224	; 02302958
	mov r2,#0x18	; 0230295A
	bl loc_02302AF4	; 0230295C
loc_02302960:
	add r0,r7,#0x0	; 02302960
	ldr r1,[pool_02302ADC]	; 02302962
	add r2,sp,#0x210	; 02302964
	bl loc_02301DB0	; 02302966
	add r2,r0,#0x0	; 0230296A
	ldrh r1,[r2,#0x4]	; 0230296C
	cmp r1,#0x0	; 0230296E
	bne loc_02302978	; 02302970
	ldrh r0,[r2,#0x6]	; 02302972
	cmp r0,#0x0	; 02302974
	beq loc_02302980	; 02302976
loc_02302978:
	mov r0,#0x3	; 02302978
	bl loc_023027BC	; 0230297A
	b loc_02302AB6	; 0230297E
loc_02302980:
	ldr r1,[r4,#0x0]	; 02302980
	ldr r0,[pool_02302AE0]	; 02302982
	add r0,r1,r0	; 02302984
	add r2,#0x8	; 02302986
	add r1,r2,#0x0	; 02302988
	bl loc_023007BC	; 0230298A
	add r0,r4,#0x0	; 0230298E
	add r0,#0x5b	; 02302990
	ldrb r1,[r0,#0x0]	; 02302992
	mov r0,#0x4	; 02302994
	and r1,r0	; 02302996
	cmp r1,#0x0	; 02302998
	beq loc_023029A0	; 0230299A
	mov r1,#0x6	; 0230299C
	b loc_023029A2	; 0230299E
loc_023029A0:
	mov r1,#0x0	; 023029A0
loc_023029A2:
	add r0,r4,#0x0	; 023029A2
	add r0,#0x5e	; 023029A4
	ldrh r0,[r0,#0x0]	; 023029A6
	add r0,r0,#0x2	; 023029A8
	add r2,r0,r1	; 023029AA
	ldr r1,[r4,#0x0]	; 023029AC
	ldr r0,[pool_02302AE4]	; 023029AE
	strh r2,[r1,r0]	; 023029B0
	add r0,r4,#0x0	; 023029B2
	add r0,#0x5b	; 023029B4
	ldrb r1,[r0,#0x0]	; 023029B6
	mov r0,#0x4	; 023029B8
	and r1,r0	; 023029BA
	cmp r1,#0x0	; 023029BC
	beq loc_023029C4	; 023029BE
	mov r1,#0x2a	; 023029C0
	b loc_023029C6	; 023029C2
loc_023029C4:
	mov r1,#0x0	; 023029C4
loc_023029C6:
	add r0,r4,#0x0	; 023029C6
	add r0,#0x5c	; 023029C8
	ldrh r0,[r0,#0x0]	; 023029CA
	add r0,r0,#0x4	; 023029CC
	add r2,r0,r1	; 023029CE
	ldr r1,[r4,#0x0]	; 023029D0
	ldr r0,[pool_02302AE8]	; 023029D2
	strh r2,[r1,r0]	; 023029D4
	add r0,sp,#0x0	; 023029D6
	add r0,#0x2	; 023029D8
	ldr r2,[r4,#0x0]	; 023029DA
	ldr r1,[pool_02302AE0]	; 023029DC
	add r1,r2,r1	; 023029DE
	bl loc_023007BC	; 023029E0
	add r0,r7,#0x0	; 023029E4
	add r1,sp,#0x0	; 023029E6
	add r1,#0x2	; 023029E8
	mov r2,#0x0	; 023029EA
	ldr r3,[pool_02302ADC]	; 023029EC
	bl loc_02301D58	; 023029EE
	ldrh r1,[r0,#0x4]	; 023029F2
	cmp r1,#0xc	; 023029F4
	bne loc_02302A0E	; 023029F6
	ldrh r2,[r0,#0x6]	; 023029F8
	cmp r2,#0x13	; 023029FA
	bne loc_02302A0E	; 023029FC
	bl loc_02300404	; 023029FE
	mov r1,#0xc	; 02302A02
	strh r1,[r0,#0x0]	; 02302A04
	strh r1,[r0,#0x2]	; 02302A06
	bl loc_02300414	; 02302A08
	b loc_02302AB6	; 02302A0C
loc_02302A0E:
	cmp r1,#0x0	; 02302A0E
	bne loc_02302A18	; 02302A10
	ldrh r0,[r0,#0x6]	; 02302A12
	cmp r0,#0x0	; 02302A14
	beq loc_02302A20	; 02302A16
loc_02302A18:
	mov r0,#0x4	; 02302A18
	bl loc_023027BC	; 02302A1A
	b loc_02302AB6	; 02302A1E
loc_02302A20:
	add r0,sp,#0x8	; 02302A20
	ldr r2,[r4,#0x0]	; 02302A22
	ldr r1,[pool_02302AE0]	; 02302A24
	add r1,r2,r1	; 02302A26
	bl loc_023007BC	; 02302A28
	add r0,r7,#0x0	; 02302A2C
	add r1,sp,#0x8	; 02302A2E
	mov r2,#0x1	; 02302A30
	ldr r3,[pool_02302ADC]	; 02302A32
	bl loc_02301CA8	; 02302A34
	ldrh r1,[r0,#0x4]	; 02302A38
	cmp r1,#0xc	; 02302A3A
	bne loc_02302A56	; 02302A3C
	ldrh r2,[r0,#0x6]	; 02302A3E
	cmp r2,#0x13	; 02302A40
	bne loc_02302A56	; 02302A42
	bl loc_02300404	; 02302A44
	mov r1,#0xc	; 02302A48
	strh r1,[r0,#0x0]	; 02302A4A
	mov r1,#0xb	; 02302A4C
	strh r1,[r0,#0x2]	; 02302A4E
	bl loc_02300414	; 02302A50
	b loc_02302AB6	; 02302A54
loc_02302A56:
	cmp r1,#0x0	; 02302A56
	bne loc_02302A60	; 02302A58
	ldrh r2,[r0,#0x6]	; 02302A5A
	cmp r2,#0x0	; 02302A5C
	beq loc_02302A68	; 02302A5E
loc_02302A60:
	mov r0,#0x6	; 02302A60
	bl loc_023027BC	; 02302A62
	b loc_02302AB6	; 02302A66
loc_02302A68:
	ldrh r2,[r0,#0x8]	; 02302A68
	ldr r1,[r4,#0x0]	; 02302A6A
	ldr r0,[pool_02302AEC]	; 02302A6C
	strh r2,[r1,r0]	; 02302A6E
	add r0,r4,#0x0	; 02302A70
	add r0,#0x58	; 02302A72
	ldrh r1,[r0,#0x0]	; 02302A74
	ldr r0,[r4,#0x0]	; 02302A76
	add r0,#0xb6	; 02302A78
	strh r1,[r0,#0x0]	; 02302A7A
	mov r1,#0x1	; 02302A7C
	add r0,sp,#0x0	; 02302A7E
	strh r1,[r0,#0x0]	; 02302A80
	ldrh r0,[r0,#0x0]	; 02302A82
	ldr r2,[r4,#0x0]	; 02302A84
	ldr r1,[pool_02302AF0]	; 02302A86
	add r1,r2,r1	; 02302A88
	mov r2,#0x20	; 02302A8A
	bl loc_02302B00	; 02302A8C
	bl loc_02304324	; 02302A90
	mov r1,#0x8	; 02302A94
	ldr r0,[r4,#0x0]	; 02302A96
	strh r1,[r0,#0x0]	; 02302A98
	bl loc_02300404	; 02302A9A
	mov r1,#0xc	; 02302A9E
	strh r1,[r0,#0x0]	; 02302AA0
	mov r1,#0x0	; 02302AA2
	strh r1,[r0,#0x2]	; 02302AA4
	mov r1,#0x7	; 02302AA6
	strh r1,[r0,#0x8]	; 02302AA8
	ldr r2,[r4,#0x0]	; 02302AAA
	ldr r1,[pool_02302AEC]	; 02302AAC
	ldrh r1,[r2,r1]	; 02302AAE
	strh r1,[r0,#0xa]	; 02302AB0
	bl loc_02300414	; 02302AB2
loc_02302AB6:
	add sp,#0x1fc	; 02302AB6
	add sp,#0x58	; 02302AB8
	pop {r4,r5,r6,r7}	; 02302ABA
	pop {r3}	; 02302ABC
	bx r3	; 02302ABE
pool_02302AC0:
loc_02302AC0:
	.word 0x00001518	; 02302AC0
pool_02302AC4:
loc_02302AC4:
	.word 0x0000150C	; 02302AC4
pool_02302AC8:
loc_02302AC8:
	.word 0x000001F0	; 02302AC8
pool_02302ACC:
loc_02302ACC:
	.word 0x000001E8	; 02302ACC
pool_02302AD0:
loc_02302AD0:
	.word 0x000001EA	; 02302AD0
pool_02302AD4:
loc_02302AD4:
	.word 0x00000194	; 02302AD4
pool_02302AD8:
loc_02302AD8:
	.word 0x00000303	; 02302AD8
pool_02302ADC:
loc_02302ADC:
	.word 0x000007D0	; 02302ADC
pool_02302AE0:
loc_02302AE0:
	.word 0x00000186	; 02302AE0
pool_02302AE4:
loc_02302AE4:
	.word 0x0000018E	; 02302AE4
pool_02302AE8:
loc_02302AE8:
	.word 0x00000190	; 02302AE8
pool_02302AEC:
loc_02302AEC:
	.word 0x00000184	; 02302AEC
pool_02302AF0:
loc_02302AF0:
	.word 0x000001F4	; 02302AF0

; ===== function loc_02302AF4 =====
loc_02302AF4:
	bx pc	; 02302AF4
	.byte 0xC0, 0x46	; 02302AF8
.arm

; ===== function loc_02302AF8 =====
loc_02302AF8:
	ldr pc,[pool_02302AFC]	; 02302AF8
pool_02302AFC:
loc_02302AFC:
	.word P2_Entry_037FCEC8	; 02302AFC
.thumb

; ===== function loc_02302B00 =====
loc_02302B00:
	bx pc	; 02302B00
	.byte 0xC0, 0x46	; 02302B04
.arm

; ===== function loc_02302B04 =====
loc_02302B04:
	ldr pc,[pool_02302B08]	; 02302B04
pool_02302B08:
loc_02302B08:
	.word loc_037FCE04	; 02302B08
.thumb

; ===== function loc_02302B0C =====
loc_02302B0C:
	push {r4,r5,lr}	; 02302B0C
	sub sp,#0x4	; 02302B0E
	add r5,r0,#0x0	; 02302B10
	add r4,r1,#0x0	; 02302B12
	bl loc_02300404	; 02302B14
	mov r1,#0xd	; 02302B18
	strh r1,[r0,#0x0]	; 02302B1A
	mov r1,#0x1	; 02302B1C
	strh r1,[r0,#0x2]	; 02302B1E
	strh r5,[r0,#0x4]	; 02302B20
	strh r4,[r0,#0x6]	; 02302B22
	bl loc_02300414	; 02302B24
	add sp,#0x4	; 02302B28
	pop {r4,r5}	; 02302B2A
	pop {r3}	; 02302B2C
	bx r3	; 02302B2E

; ===== function loc_02302B30 =====
loc_02302B30:
	push {r4,r5,r6,r7,lr}	; 02302B30
	sub sp,#0x1fc	; 02302B32
	sub sp,#0x20	; 02302B34
	add r4,r0,#0x0	; 02302B36
	add r7,r1,#0x0	; 02302B38
	bl loc_023008B4	; 02302B3A
	ldr r1,[pool_02302CEC]	; 02302B3E
	ldr r5,[r0,r1]	; 02302B40
	ldr r0,[r4,#0x4]	; 02302B42
	lsl r0,r0,#0x10	; 02302B44
	lsr r0,r0,#0x10	; 02302B46
	str r0,[sp,#0x0]	; 02302B48
	ldr r2,[r5,#0x0]	; 02302B4A
	ldrh r0,[r2,#0x0]	; 02302B4C
	cmp r0,#0x9	; 02302B4E
	beq loc_02302B74	; 02302B50
	cmp r0,#0x7	; 02302B52
	beq loc_02302B74	; 02302B54
	cmp r0,#0xa	; 02302B56
	beq loc_02302B5E	; 02302B58
	cmp r0,#0x8	; 02302B5A
	bne loc_02302B70	; 02302B5C
loc_02302B5E:
	cmp r0,#0xa	; 02302B5E
	bne loc_02302B74	; 02302B60
	mov r1,#0x0	; 02302B62
	str r1,[r2,#0x10]	; 02302B64
	ldr r0,[r5,#0x0]	; 02302B66
	str r1,[r0,#0x18]	; 02302B68
	ldr r0,[r5,#0x0]	; 02302B6A
	str r1,[r0,#0x24]	; 02302B6C
	b loc_02302B74	; 02302B6E
loc_02302B70:
	mov r0,#0x0	; 02302B70
	b loc_02302CE0	; 02302B72
loc_02302B74:
	ldr r2,[r5,#0x0]	; 02302B74
	ldrh r0,[r2,#0x0]	; 02302B76
	cmp r0,#0xa	; 02302B78
	beq loc_02302B80	; 02302B7A
	cmp r0,#0x8	; 02302B7C
	bne loc_02302C1E	; 02302B7E
loc_02302B80:
	add r0,sp,#0xc	; 02302B80
	ldr r1,[pool_02302CF0]	; 02302B82
	add r1,r2,r1	; 02302B84
	bl loc_023007BC	; 02302B86
	add r0,sp,#0x18	; 02302B8A
	add r1,sp,#0xc	; 02302B8C
	mov r2,#0x3	; 02302B8E
	bl loc_02301D00	; 02302B90
	ldrh r1,[r0,#0x4]	; 02302B94
	cmp r1,#0x0	; 02302B96
	beq loc_02302BA4	; 02302B98
	mov r0,#0x5	; 02302B9A
	bl loc_02302B0C	; 02302B9C
	mov r0,#0x0	; 02302BA0
	b loc_02302CE0	; 02302BA2
loc_02302BA4:
	add r0,sp,#0x18	; 02302BA4
	mov r1,#0x1	; 02302BA6
	bl loc_02301EE4	; 02302BA8
	ldrh r1,[r0,#0x4]	; 02302BAC
	cmp r1,#0x0	; 02302BAE
	beq loc_02302BBC	; 02302BB0
	mov r0,#0x0	; 02302BB2
	bl loc_02302B0C	; 02302BB4
	mov r0,#0x0	; 02302BB8
	b loc_02302CE0	; 02302BBA
loc_02302BBC:
	mov r1,#0x3	; 02302BBC
	ldr r0,[r5,#0x0]	; 02302BBE
	strh r1,[r0,#0x0]	; 02302BC0
	add r0,sp,#0x18	; 02302BC2
	bl loc_0230195C	; 02302BC4
	ldrh r1,[r0,#0x4]	; 02302BC8
	cmp r1,#0x0	; 02302BCA
	beq loc_02302BD8	; 02302BCC
	ldr r0,[pool_02302CF4]	; 02302BCE
	bl loc_02302B0C	; 02302BD0
	mov r0,#0x0	; 02302BD4
	b loc_02302CE0	; 02302BD6
loc_02302BD8:
	mov r1,#0x2	; 02302BD8
	ldr r0,[r5,#0x0]	; 02302BDA
	strh r1,[r0,#0x0]	; 02302BDC
	mov r1,#0x0	; 02302BDE
	ldr r0,[r5,#0x0]	; 02302BE0
	str r1,[r0,#0x10]	; 02302BE2
	ldr r0,[r5,#0x0]	; 02302BE4
	str r1,[r0,#0x18]	; 02302BE6
	ldr r0,[r5,#0x0]	; 02302BE8
	str r1,[r0,#0x14]	; 02302BEA
	cmp r7,#0x1	; 02302BEC
	bne loc_02302CDE	; 02302BEE
	bl loc_02300404	; 02302BF0
	mov r1,#0xc	; 02302BF4
	strh r1,[r0,#0x0]	; 02302BF6
	mov r1,#0x0	; 02302BF8
	strh r1,[r0,#0x2]	; 02302BFA
	mov r2,#0x9	; 02302BFC
	strh r2,[r0,#0x8]	; 02302BFE
	mov r2,#0x24	; 02302C00
	strh r2,[r0,#0xc]	; 02302C02
	ldr r3,[r5,#0x0]	; 02302C04
	ldr r2,[pool_02302CF8]	; 02302C06
	ldrh r2,[r3,r2]	; 02302C08
	strh r2,[r0,#0xa]	; 02302C0A
	ldr r3,[r5,#0x0]	; 02302C0C
	ldr r2,[pool_02302CFC]	; 02302C0E
	strh r1,[r3,r2]	; 02302C10
	ldr r3,[r5,#0x0]	; 02302C12
	ldr r2,[pool_02302D00]	; 02302C14
	strh r1,[r3,r2]	; 02302C16
	bl loc_02300414	; 02302C18
	b loc_02302CDE	; 02302C1C
loc_02302C1E:
	mov r4,#0x1	; 02302C1E
	str r4,[sp,#0x8]	; 02302C20
	b loc_02302CDA	; 02302C22
loc_02302C24:
	ldr r1,[r5,#0x0]	; 02302C24
	ldr r6,[sp,#0x8]	; 02302C26
	lsl r6,r4	; 02302C28
	ldr r0,[pool_02302D04]	; 02302C2A
	ldrh r2,[r1,r0]	; 02302C2C
	ldr r0,[sp,#0x0]	; 02302C2E
	and r2,r0	; 02302C30
	add r0,r6,#0x0	; 02302C32
	and r0,r2	; 02302C34
	cmp r0,#0x0	; 02302C36
	beq loc_02302CD8	; 02302C38
	lsl r0,r4,#0x10	; 02302C3A
	lsr r0,r0,#0x10	; 02302C3C
	str r0,[sp,#0x4]	; 02302C3E
	add r0,sp,#0x10	; 02302C40
	add r0,#0x2	; 02302C42
	ldr r2,[pool_02302D08]	; 02302C44
	add r2,r1,r2	; 02302C46
	sub r3,r4,#0x1	; 02302C48
	mov r1,#0x6	; 02302C4A
	mul r3,r1	; 02302C4C
	add r1,r2,r3	; 02302C4E
	bl loc_023007BC	; 02302C50
	add r0,sp,#0x18	; 02302C54
	add r1,sp,#0x10	; 02302C56
	add r1,#0x2	; 02302C58
	mov r2,#0x3	; 02302C5A
	bl loc_02301D00	; 02302C5C
	ldrh r1,[r0,#0x4]	; 02302C60
	cmp r1,#0x0	; 02302C62
	beq loc_02302C70	; 02302C64
	mov r0,#0x5	; 02302C66
	bl loc_02302B0C	; 02302C68
	mov r0,#0x0	; 02302C6C
	b loc_02302CE0	; 02302C6E
loc_02302C70:
	ldr r1,[r5,#0x0]	; 02302C70
	ldr r0,[pool_02302D04]	; 02302C72
	add r1,r1,r0	; 02302C74
	ldrh r0,[r1,#0x0]	; 02302C76
	bic r0,r6	; 02302C78
	strh r0,[r1,#0x0]	; 02302C7A
	ldr r1,[r5,#0x0]	; 02302C7C
	add r1,#0x86	; 02302C7E
	ldrh r0,[r1,#0x0]	; 02302C80
	bic r0,r6	; 02302C82
	strh r0,[r1,#0x0]	; 02302C84
	add r0,r4,#0x0	; 02302C86
	mov r1,#0x6	; 02302C88
	mul r0,r1	; 02302C8A
	ldr r1,[r5,#0x0]	; 02302C8C
	add r3,r1,r0	; 02302C8E
	mov r2,#0x0	; 02302C90
	ldr r1,[pool_02302D0C]	; 02302C92
	strh r2,[r3,r1]	; 02302C94
	ldr r1,[r5,#0x0]	; 02302C96
	add r3,r1,r0	; 02302C98
	ldr r1,[pool_02302D10]	; 02302C9A
	strh r2,[r3,r1]	; 02302C9C
	ldr r1,[r5,#0x0]	; 02302C9E
	add r2,r1,r0	; 02302CA0
	mov r1,#0x0	; 02302CA2
	ldr r0,[pool_02302D14]	; 02302CA4
	strh r1,[r2,r0]	; 02302CA6
	cmp r7,#0x1	; 02302CA8
	bne loc_02302CD8	; 02302CAA
	bl loc_02300404	; 02302CAC
	add r6,r0,#0x0	; 02302CB0
	mov r0,#0x8	; 02302CB2
	strh r0,[r6,#0x0]	; 02302CB4
	mov r0,#0x0	; 02302CB6
	strh r0,[r6,#0x2]	; 02302CB8
	mov r0,#0x9	; 02302CBA
	strh r0,[r6,#0x8]	; 02302CBC
	mov r0,#0x24	; 02302CBE
	strh r0,[r6,#0x12]	; 02302CC0
	ldr r0,[sp,#0x4]	; 02302CC2
	strh r0,[r6,#0x10]	; 02302CC4
	add r0,r6,#0x0	; 02302CC6
	add r0,#0xa	; 02302CC8
	add r1,sp,#0x10	; 02302CCA
	add r1,#0x2	; 02302CCC
	bl loc_023007BC	; 02302CCE
	add r0,r6,#0x0	; 02302CD2
	bl loc_02300414	; 02302CD4
loc_02302CD8:
	add r4,r4,#0x1	; 02302CD8
loc_02302CDA:
	cmp r4,#0x10	; 02302CDA
	blt loc_02302C24	; 02302CDC
loc_02302CDE:
	mov r0,#0x1	; 02302CDE
loc_02302CE0:
	add sp,#0x1fc	; 02302CE0
	add sp,#0x20	; 02302CE2
	pop {r4,r5,r6,r7}	; 02302CE4
	pop {r3}	; 02302CE6
	bx r3	; 02302CE8
	.byte 0xC0, 0x46	; 02302CEC
pool_02302CEC:
loc_02302CEC:
	.word 0x00001518	; 02302CEC
pool_02302CF0:
loc_02302CF0:
	.word 0x00000186	; 02302CF0
pool_02302CF4:
loc_02302CF4:
	.word 0x00000302	; 02302CF4
pool_02302CF8:
loc_02302CF8:
	.word 0x00000184	; 02302CF8
pool_02302CFC:
loc_02302CFC:
	.word 0x0000018E	; 02302CFC
pool_02302D00:
loc_02302D00:
	.word 0x00000190	; 02302D00
pool_02302D04:
loc_02302D04:
	.word 0x0000017E	; 02302D04
pool_02302D08:
loc_02302D08:
	.word 0x00000124	; 02302D08
pool_02302D0C:
loc_02302D0C:
	.word 0x0000011E	; 02302D0C
pool_02302D10:
loc_02302D10:
	.word 0x00000120	; 02302D10
pool_02302D14:
loc_02302D14:
	.word 0x00000122	; 02302D14

; ===== function loc_02302D18 =====
	push {lr}	; 02302D18
	sub sp,#0x4	; 02302D1A
	mov r1,#0x0	; 02302D1C
	bl loc_02302B30	; 02302D1E
	cmp r0,#0x1	; 02302D22
	bne loc_02302D38	; 02302D24
	bl loc_02300404	; 02302D26
	mov r1,#0xd	; 02302D2A
	strh r1,[r0,#0x0]	; 02302D2C
	mov r1,#0x0	; 02302D2E
	strh r1,[r0,#0x2]	; 02302D30
	bl loc_02300414	; 02302D32
	b loc_02302D48	; 02302D36
loc_02302D38:
	bl loc_02300404	; 02302D38
	mov r1,#0xd	; 02302D3C
	strh r1,[r0,#0x0]	; 02302D3E
	mov r1,#0x1	; 02302D40
	strh r1,[r0,#0x2]	; 02302D42
	bl loc_02300414	; 02302D44
loc_02302D48:
	add sp,#0x4	; 02302D48
	pop {r3}	; 02302D4A
	bx r3	; 02302D4C
	.byte 0x00, 0x00	; 02302D50
	push {r4,r5,r6,lr}	; 02302D50
	add r5,r0,#0x0	; 02302D52
	bl loc_023008B4	; 02302D54
	ldr r1,[pool_02302E5C]	; 02302D58
	ldr r0,[r0,r1]	; 02302D5A
	ldr r4,[r0,#0x0]	; 02302D5C
	ldr r2,[r5,#0x4]	; 02302D5E
	ldr r0,[r5,#0x8]	; 02302D60
	lsl r0,r0,#0x10	; 02302D62
	lsr r1,r0,#0x10	; 02302D64
	mov r6,#0x1	; 02302D66
	str r6,[r4,#0x10]	; 02302D68
	mov r0,#0x0	; 02302D6A
	str r0,[r4,#0xc]	; 02302D6C
	add r3,r4,#0x0	; 02302D6E
	add r3,#0x84	; 02302D70
	strh r0,[r3,#0x0]	; 02302D72
	strh r0,[r4,#0x38]	; 02302D74
	strh r6,[r4,#0x3a]	; 02302D76
	add r3,r4,#0x0	; 02302D78
	add r3,#0x88	; 02302D7A
	strh r0,[r3,#0x0]	; 02302D7C
	add r3,r4,#0x0	; 02302D7E
	add r3,#0x9a	; 02302D80
	strh r0,[r3,#0x0]	; 02302D82
	mov r6,#0x3c	; 02302D84
	add r3,r4,#0x0	; 02302D86
	add r3,#0x9c	; 02302D88
	strh r6,[r3,#0x0]	; 02302D8A
	ldr r3,[pool_02302E60]	; 02302D8C
	str r0,[r4,r3]	; 02302D8E
	add r3,r4,#0x0	; 02302D90
	add r3,#0x8a	; 02302D92
	strh r0,[r3,#0x0]	; 02302D94
	add r3,r4,#0x0	; 02302D96
	add r3,#0x8c	; 02302D98
	strh r0,[r3,#0x0]	; 02302D9A
	add r3,r4,#0x0	; 02302D9C
	add r3,#0x8e	; 02302D9E
	strh r0,[r3,#0x0]	; 02302DA0
	add r3,r4,#0x0	; 02302DA2
	add r3,#0x90	; 02302DA4
	strh r0,[r3,#0x0]	; 02302DA6
	str r2,[r4,#0x48]	; 02302DA8
	add r3,r4,#0x0	; 02302DAA
	add r3,#0x46	; 02302DAC
	strh r1,[r3,#0x0]	; 02302DAE
	add r1,r2,r1	; 02302DB0
	str r1,[r4,#0x4c]	; 02302DB2
	add r1,r4,#0x0	; 02302DB4
	add r1,#0x42	; 02302DB6
	strh r0,[r1,#0x0]	; 02302DB8
	ldr r0,[r5,#0xc]	; 02302DBA
	str r0,[r4,#0x50]	; 02302DBC
	ldr r1,[r5,#0x10]	; 02302DBE
	add r0,r4,#0x0	; 02302DC0
	add r0,#0x54	; 02302DC2
	strh r1,[r0,#0x0]	; 02302DC4
	ldr r0,[r5,#0x14]	; 02302DC6
	strh r0,[r4,#0x3c]	; 02302DC8
	ldrh r0,[r4,#0x3c]	; 02302DCA
	cmp r0,#0x0	; 02302DCC
	bne loc_02302DD4	; 02302DCE
	mov r0,#0x10	; 02302DD0
	strh r0,[r4,#0x3c]	; 02302DD2
loc_02302DD4:
	ldr r1,[r5,#0x18]	; 02302DD4
	add r0,r4,#0x0	; 02302DD6
	add r0,#0x98	; 02302DD8
	strh r1,[r0,#0x0]	; 02302DDA
	ldr r0,[r5,#0x1c]	; 02302DDC
	cmp r0,#0x0	; 02302DDE
	beq loc_02302DE6	; 02302DE0
	mov r1,#0x1	; 02302DE2
	b loc_02302DE8	; 02302DE4
loc_02302DE6:
	mov r1,#0x0	; 02302DE6
loc_02302DE8:
	add r0,r4,#0x0	; 02302DE8
	add r0,#0x92	; 02302DEA
	strh r1,[r0,#0x0]	; 02302DEC
	ldr r0,[r5,#0x20]	; 02302DEE
	cmp r0,#0x0	; 02302DF0
	beq loc_02302DF8	; 02302DF2
	mov r1,#0x1	; 02302DF4
	b loc_02302DFA	; 02302DF6
loc_02302DF8:
	mov r1,#0x0	; 02302DF8
loc_02302DFA:
	add r0,r4,#0x0	; 02302DFA
	add r0,#0x94	; 02302DFC
	strh r1,[r0,#0x0]	; 02302DFE
	ldr r0,[r5,#0x24]	; 02302E00
	cmp r0,#0x0	; 02302E02
	beq loc_02302E0A	; 02302E04
	mov r1,#0x1	; 02302E06
	b loc_02302E0C	; 02302E08
loc_02302E0A:
	mov r1,#0x0	; 02302E0A
loc_02302E0C:
	add r0,r4,#0x0	; 02302E0C
	add r0,#0x96	; 02302E0E
	strh r1,[r0,#0x0]	; 02302E10
	mov r1,#0x0	; 02302E12
	strh r1,[r4,#0x3e]	; 02302E14
	ldr r0,[r5,#0x28]	; 02302E16
	cmp r0,#0x0	; 02302E18
	beq loc_02302E1E	; 02302E1A
	mov r1,#0x1	; 02302E1C
loc_02302E1E:
	add r0,r4,#0x0	; 02302E1E
	add r0,#0xda	; 02302E20
	strh r1,[r0,#0x0]	; 02302E22
	bl loc_02304324	; 02302E24
	bl loc_023036E4	; 02302E28
	ldrh r0,[r4,#0x0]	; 02302E2C
	cmp r0,#0x8	; 02302E2E
	bne loc_02302E38	; 02302E30
	mov r0,#0xa	; 02302E32
	strh r0,[r4,#0x0]	; 02302E34
	b loc_02302E40	; 02302E36
loc_02302E38:
	cmp r0,#0x7	; 02302E38
	bne loc_02302E40	; 02302E3A
	mov r0,#0x9	; 02302E3C
	strh r0,[r4,#0x0]	; 02302E3E
loc_02302E40:
	bl loc_02300404	; 02302E40
	mov r1,#0xe	; 02302E44
	strh r1,[r0,#0x0]	; 02302E46
	mov r1,#0x0	; 02302E48
	strh r1,[r0,#0x2]	; 02302E4A
	mov r1,#0xa	; 02302E4C
	strh r1,[r0,#0x4]	; 02302E4E
	bl loc_02300414	; 02302E50
	pop {r4,r5,r6}	; 02302E54
	pop {r3}	; 02302E56
	bx r3	; 02302E58
	.byte 0xC0, 0x46	; 02302E5C
pool_02302E5C:
loc_02302E5C:
	.word 0x00001518	; 02302E5C
pool_02302E60:
loc_02302E60:
	.word 0x0000092C	; 02302E60

; ===== function loc_02302E64 =====
	push {r4,r5,r6,r7,lr}	; 02302E64
	sub sp,#0x1c	; 02302E66
	add r4,r0,#0x0	; 02302E68
	bl loc_023008B4	; 02302E6A
	ldr r1,[r4,#0x4]	; 02302E6E
	str r1,[sp,#0xc]	; 02302E70
	ldr r1,[r4,#0x8]	; 02302E72
	lsl r1,r1,#0x10	; 02302E74
	lsr r5,r1,#0x10	; 02302E76
	ldr r1,[r4,#0xc]	; 02302E78
	lsl r1,r1,#0x10	; 02302E7A
	lsr r6,r1,#0x10	; 02302E7C
	ldr r1,[r4,#0x10]	; 02302E7E
	lsl r1,r1,#0x10	; 02302E80
	lsr r1,r1,#0x10	; 02302E82
	str r1,[sp,#0x10]	; 02302E84
	ldr r1,[r4,#0x14]	; 02302E86
	lsl r1,r1,#0x10	; 02302E88
	lsr r1,r1,#0x10	; 02302E8A
	ldr r7,[r4,#0x18]	; 02302E8C
	ldr r4,[r4,#0x1c]	; 02302E8E
	ldr r2,[pool_02302EE8]	; 02302E90
	ldr r0,[r0,r2]	; 02302E92
	ldr r2,[r0,#0x0]	; 02302E94
	ldr r0,[pool_02302EEC]	; 02302E96
	ldrh r0,[r2,r0]	; 02302E98
	cmp r0,#0x0	; 02302E9A
	beq loc_02302EA0	; 02302E9C
	mov r6,#0x1	; 02302E9E
loc_02302EA0:
	str r5,[sp,#0x0]	; 02302EA0
	str r7,[sp,#0x4]	; 02302EA2
	str r4,[sp,#0x8]	; 02302EA4
	add r0,r1,#0x0	; 02302EA6
	ldr r1,[sp,#0x10]	; 02302EA8
	add r2,r6,#0x0	; 02302EAA
	ldr r3,[sp,#0xc]	; 02302EAC
	bl loc_02303D14	; 02302EAE
	str r0,[sp,#0x14]	; 02302EB2
	cmp r0,#0x2	; 02302EB4
	beq loc_02302EE0	; 02302EB6
	bl loc_02300404	; 02302EB8
	mov r1,#0x81	; 02302EBC
	strh r1,[r0,#0x0]	; 02302EBE
	ldr r1,[sp,#0x14]	; 02302EC0
	strh r1,[r0,#0x2]	; 02302EC2
	mov r1,#0x14	; 02302EC4
	strh r1,[r0,#0x8]	; 02302EC6
	ldr r1,[sp,#0x10]	; 02302EC8
	strh r1,[r0,#0xa]	; 02302ECA
	strh r6,[r0,#0xc]	; 02302ECC
	strh r5,[r0,#0xe]	; 02302ECE
	ldr r1,[sp,#0xc]	; 02302ED0
	str r1,[r0,#0x10]	; 02302ED2
	str r7,[r0,#0x14]	; 02302ED4
	str r4,[r0,#0x18]	; 02302ED6
	ldr r1,[pool_02302EF0]	; 02302ED8
	strh r1,[r0,#0x1c]	; 02302EDA
	bl loc_02300414	; 02302EDC
loc_02302EE0:
	add sp,#0x1c	; 02302EE0
	pop {r4,r5,r6,r7}	; 02302EE2
	pop {r3}	; 02302EE4
	bx r3	; 02302EE6
pool_02302EE8:
loc_02302EE8:
	.word 0x00001518	; 02302EE8
pool_02302EEC:
loc_02302EEC:
	.word 0x00000184	; 02302EEC
pool_02302EF0:
loc_02302EF0:
	.word 0x0000FFFF	; 02302EF0

; ===== function loc_02302EF4 =====
	push {lr}	; 02302EF4
	sub sp,#0x4	; 02302EF6
	bl loc_023008B4	; 02302EF8
	ldr r1,[pool_02302F30]	; 02302EFC
	ldr r0,[r0,r1]	; 02302EFE
	ldr r1,[r0,#0x0]	; 02302F00
	mov r0,#0x0	; 02302F02
	str r0,[r1,#0x10]	; 02302F04
	ldrh r0,[r1,#0x0]	; 02302F06
	cmp r0,#0xa	; 02302F08
	bne loc_02302F12	; 02302F0A
	mov r0,#0x8	; 02302F0C
	strh r0,[r1,#0x0]	; 02302F0E
	b loc_02302F1A	; 02302F10
loc_02302F12:
	cmp r0,#0x9	; 02302F12
	bne loc_02302F1A	; 02302F14
	mov r0,#0x7	; 02302F16
	strh r0,[r1,#0x0]	; 02302F18
loc_02302F1A:
	bl loc_02300404	; 02302F1A
	mov r1,#0x10	; 02302F1E
	strh r1,[r0,#0x0]	; 02302F20
	mov r1,#0x0	; 02302F22
	strh r1,[r0,#0x2]	; 02302F24
	bl loc_02300414	; 02302F26
	add sp,#0x4	; 02302F2A
	pop {r3}	; 02302F2C
	bx r3	; 02302F2E
pool_02302F30:
loc_02302F30:
	.word 0x00001518	; 02302F30

; ===== function loc_02302F34 =====
	push {r4,r5,lr}	; 02302F34
	sub sp,#0x1fc	; 02302F36
	sub sp,#0x88	; 02302F38
	add r5,r0,#0x0	; 02302F3A
	bl loc_023008B4	; 02302F3C
	ldr r1,[pool_02303018]	; 02302F40
	ldr r0,[r0,r1]	; 02302F42
	ldr r4,[r0,#0x0]	; 02302F44
	ldr r1,[r5,#0x4]	; 02302F46
	add r0,r4,#0x0	; 02302F48
	add r0,#0xe4	; 02302F4A
	str r1,[r0,#0x0]	; 02302F4C
	ldr r1,[r5,#0x8]	; 02302F4E
	add r0,r4,#0x0	; 02302F50
	add r0,#0xe8	; 02302F52
	strh r1,[r0,#0x0]	; 02302F54
	ldr r1,[r5,#0xc]	; 02302F56
	add r0,r4,#0x0	; 02302F58
	add r0,#0xea	; 02302F5A
	strh r1,[r0,#0x0]	; 02302F5C
	ldr r1,[r5,#0x10]	; 02302F5E
	add r0,r4,#0x0	; 02302F60
	add r0,#0xec	; 02302F62
	strh r1,[r0,#0x0]	; 02302F64
	ldr r1,[r5,#0x14]	; 02302F66
	add r0,r4,#0x0	; 02302F68
	add r0,#0xee	; 02302F6A
	strh r1,[r0,#0x0]	; 02302F6C
	ldr r0,[r5,#0x18]	; 02302F6E
	lsl r0,r0,#0x18	; 02302F70
	lsr r0,r0,#0x18	; 02302F72
	mov r2,#0x1	; 02302F74
	add r1,r0,#0x0	; 02302F76
	and r1,r2	; 02302F78
	cmp r1,#0x0	; 02302F7A
	bne loc_02302F80	; 02302F7C
	mov r2,#0x0	; 02302F7E
loc_02302F80:
	add r1,r4,#0x0	; 02302F80
	add r1,#0xf0	; 02302F82
	strh r2,[r1,#0x0]	; 02302F84
	mov r1,#0x2	; 02302F86
	add r2,r0,#0x0	; 02302F88
	and r2,r1	; 02302F8A
	cmp r2,#0x0	; 02302F8C
	beq loc_02302F94	; 02302F8E
	mov r2,#0x1	; 02302F90
	b loc_02302F96	; 02302F92
loc_02302F94:
	mov r2,#0x0	; 02302F94
loc_02302F96:
	add r1,r4,#0x0	; 02302F96
	add r1,#0xf4	; 02302F98
	strh r2,[r1,#0x0]	; 02302F9A
	mov r1,#0x4	; 02302F9C
	add r2,r0,#0x0	; 02302F9E
	and r2,r1	; 02302FA0
	cmp r2,#0x0	; 02302FA2
	beq loc_02302FAA	; 02302FA4
	mov r2,#0x1	; 02302FA6
	b loc_02302FAC	; 02302FA8
loc_02302FAA:
	mov r2,#0x0	; 02302FAA
loc_02302FAC:
	add r1,r4,#0x0	; 02302FAC
	add r1,#0xf6	; 02302FAE
	strh r2,[r1,#0x0]	; 02302FB0
	mov r1,#0x8	; 02302FB2
	and r0,r1	; 02302FB4
	cmp r0,#0x0	; 02302FB6
	beq loc_02302FBE	; 02302FB8
	mov r1,#0x1	; 02302FBA
	b loc_02302FC0	; 02302FBC
loc_02302FBE:
	mov r1,#0x0	; 02302FBE
loc_02302FC0:
	add r0,r4,#0x0	; 02302FC0
	add r0,#0xf8	; 02302FC2
	strh r1,[r0,#0x0]	; 02302FC4
	add r0,sp,#0x200	; 02302FC6
	add r1,r4,#0x0	; 02302FC8
	add r1,#0xe4	; 02302FCA
	bl loc_023006DC	; 02302FCC
	add r0,sp,#0x0	; 02302FD0
	add r4,#0xe8	; 02302FD2
	ldrh r1,[r4,#0x0]	; 02302FD4
	add r1,#0x10	; 02302FD6
	lsl r1,r1,#0x10	; 02302FD8
	lsr r1,r1,#0x10	; 02302FDA
	add r2,sp,#0x200	; 02302FDC
	bl loc_023019AC	; 02302FDE
	add r4,r0,#0x0	; 02302FE2
	bl loc_02300404	; 02302FE4
	mov r1,#0x18	; 02302FE8
	strh r1,[r0,#0x0]	; 02302FEA
	ldrh r1,[r4,#0x4]	; 02302FEC
	cmp r1,#0x0	; 02302FEE
	bne loc_02302FF6	; 02302FF0
	mov r1,#0x0	; 02302FF2
	b loc_02302FF8	; 02302FF4
loc_02302FF6:
	mov r1,#0x1	; 02302FF6
loc_02302FF8:
	strh r1,[r0,#0x2]	; 02302FF8
	ldrh r1,[r4,#0x4]	; 02302FFA
	cmp r1,#0x0	; 02302FFC
	beq loc_02303008	; 02302FFE
	ldr r1,[pool_0230301C]	; 02303000
	strh r1,[r0,#0x4]	; 02303002
	ldrh r1,[r4,#0x4]	; 02303004
	strh r1,[r0,#0x6]	; 02303006
loc_02303008:
	bl loc_02300414	; 02303008
	add sp,#0x1fc	; 0230300C
	add sp,#0x88	; 0230300E
	pop {r4,r5}	; 02303010
	pop {r3}	; 02303012
	bx r3	; 02303014
	.byte 0xC0, 0x46	; 02303018
pool_02303018:
loc_02303018:
	.word 0x00001518	; 02303018
pool_0230301C:
loc_0230301C:
	.word 0x00000245	; 0230301C

; ===== function loc_02303020 =====
loc_02303020:
	push {r4,r5,lr}	; 02303020
	sub sp,#0x4	; 02303022
	add r5,r0,#0x0	; 02303024
	add r4,r1,#0x0	; 02303026
	bl loc_02300404	; 02303028
	mov r1,#0x19	; 0230302C
	strh r1,[r0,#0x0]	; 0230302E
	mov r1,#0x1	; 02303030
	strh r1,[r0,#0x2]	; 02303032
	strh r5,[r0,#0x4]	; 02303034
	strh r4,[r0,#0x6]	; 02303036
	bl loc_02300414	; 02303038
	add sp,#0x4	; 0230303C
	pop {r4,r5}	; 0230303E
	pop {r3}	; 02303040
	bx r3	; 02303042

; ===== function loc_02303044 =====
	push {r4,lr}	; 02303044
	sub sp,#0x1fc	; 02303046
	sub sp,#0x4	; 02303048
	add r4,r0,#0x0	; 0230304A
	bl loc_023008B4	; 0230304C
	add r0,sp,#0x0	; 02303050
	ldr r1,[r4,#0x4]	; 02303052
	lsl r1,r1,#0x10	; 02303054
	lsr r1,r1,#0x10	; 02303056
	bl loc_02301A20	; 02303058
	ldrh r1,[r0,#0x4]	; 0230305C
	cmp r1,#0x0	; 0230305E
	beq loc_0230306A	; 02303060
	ldr r0,[pool_02303084]	; 02303062
	bl loc_02303020	; 02303064
	b loc_0230307A	; 02303068
loc_0230306A:
	bl loc_02300404	; 0230306A
	mov r1,#0x19	; 0230306E
	strh r1,[r0,#0x0]	; 02303070
	mov r1,#0x0	; 02303072
	strh r1,[r0,#0x2]	; 02303074
	bl loc_02300414	; 02303076
loc_0230307A:
	add sp,#0x1fc	; 0230307A
	add sp,#0x4	; 0230307C
	pop {r4}	; 0230307E
	pop {r3}	; 02303080
	bx r3	; 02303082
pool_02303084:
loc_02303084:
	.word 0x00000215	; 02303084

; ===== function loc_02303088 =====
loc_02303088:
	push {r4,r5,lr}	; 02303088
	sub sp,#0x4	; 0230308A
	add r5,r0,#0x0	; 0230308C
	add r4,r1,#0x0	; 0230308E
	bl loc_02300404	; 02303090
	mov r1,#0x7	; 02303094
	strh r1,[r0,#0x0]	; 02303096
	mov r1,#0x1	; 02303098
	strh r1,[r0,#0x2]	; 0230309A
	strh r5,[r0,#0x4]	; 0230309C
	strh r4,[r0,#0x6]	; 0230309E
	bl loc_02300414	; 023030A0
	add sp,#0x4	; 023030A4
	pop {r4,r5}	; 023030A6
	pop {r3}	; 023030A8
	bx r3	; 023030AA

; ===== function loc_023030AC =====
	push {r4,lr}	; 023030AC
	sub sp,#0x1fc	; 023030AE
	sub sp,#0x4	; 023030B0
	add r4,r0,#0x0	; 023030B2
	bl loc_023008B4	; 023030B4
	add r0,sp,#0x0	; 023030B8
	ldr r1,[r4,#0x4]	; 023030BA
	lsl r1,r1,#0x10	; 023030BC
	lsr r1,r1,#0x10	; 023030BE
	ldr r2,[r4,#0x8]	; 023030C0
	lsl r2,r2,#0x10	; 023030C2
	lsr r2,r2,#0x10	; 023030C4
	ldr r3,[r4,#0xc]	; 023030C6
	lsl r3,r3,#0x10	; 023030C8
	lsr r3,r3,#0x10	; 023030CA
	bl loc_02301A90	; 023030CC
	ldrh r1,[r0,#0x4]	; 023030D0
	cmp r1,#0x0	; 023030D2
	beq loc_023030DE	; 023030D4
	ldr r0,[pool_023030F8]	; 023030D6
	bl loc_02303088	; 023030D8
	b loc_023030EE	; 023030DC
loc_023030DE:
	bl loc_02300404	; 023030DE
	mov r1,#0x1d	; 023030E2
	strh r1,[r0,#0x0]	; 023030E4
	mov r1,#0x0	; 023030E6
	strh r1,[r0,#0x2]	; 023030E8
	bl loc_02300414	; 023030EA
loc_023030EE:
	add sp,#0x1fc	; 023030EE
	add sp,#0x4	; 023030F0
	pop {r4}	; 023030F2
	pop {r3}	; 023030F4
	bx r3	; 023030F6
pool_023030F8:
loc_023030F8:
	.word 0x00000211	; 023030F8

; ===== function loc_023030FC =====
loc_023030FC:
	push {r4,r5,lr}	; 023030FC
	sub sp,#0x4	; 023030FE
	add r5,r0,#0x0	; 02303100
	add r4,r1,#0x0	; 02303102
	bl loc_02300404	; 02303104
	mov r1,#0x1e	; 02303108
	strh r1,[r0,#0x0]	; 0230310A
	mov r1,#0x1	; 0230310C
	strh r1,[r0,#0x2]	; 0230310E
	strh r5,[r0,#0x4]	; 02303110
	strh r4,[r0,#0x6]	; 02303112
	bl loc_02300414	; 02303114
	add sp,#0x4	; 02303118
	pop {r4,r5}	; 0230311A
	pop {r3}	; 0230311C
	bx r3	; 0230311E

; ===== function loc_02303120 =====
	push {r4,r5,r6,r7,lr}	; 02303120
	sub sp,#0x1fc	; 02303122
	sub sp,#0x20	; 02303124
	add r5,r0,#0x0	; 02303126
	bl loc_023008B4	; 02303128
	ldr r1,[pool_02303210]	; 0230312C
	ldr r4,[r0,r1]	; 0230312E
	add r0,sp,#0x18	; 02303130
	bl loc_023018FC	; 02303132
	ldrh r1,[r0,#0x4]	; 02303136
	cmp r1,#0x0	; 02303138
	beq loc_02303144	; 0230313A
	ldr r0,[pool_02303214]	; 0230313C
	bl loc_023030FC	; 0230313E
	b loc_02303206	; 02303142
loc_02303144:
	ldrh r2,[r0,#0x6]	; 02303144
	mov r1,#0x2	; 02303146
	ldr r0,[r4,#0x0]	; 02303148
	add r0,#0xe2	; 0230314A
	strh r1,[r0,#0x0]	; 0230314C
	cmp r2,#0x10	; 0230314E
	bne loc_02303192	; 02303150
	mov r0,#0xa	; 02303152
	add r1,sp,#0x18	; 02303154
	bl loc_0230056C	; 02303156
	cmp r0,#0x0	; 0230315A
	beq loc_02303206	; 0230315C
	add r0,sp,#0x18	; 0230315E
	bl loc_0230194C	; 02303160
	ldrh r1,[r0,#0x4]	; 02303164
	cmp r1,#0x0	; 02303166
	beq loc_02303172	; 02303168
	ldr r0,[pool_02303218]	; 0230316A
	bl loc_023030FC	; 0230316C
	b loc_02303206	; 02303170
loc_02303172:
	mov r1,#0x3	; 02303172
	ldr r0,[r4,#0x0]	; 02303174
	strh r1,[r0,#0x0]	; 02303176
	add r0,sp,#0x18	; 02303178
	mov r1,#0x1	; 0230317A
	mov r2,#0x0	; 0230317C
	add r3,r1,#0x0	; 0230317E
	bl loc_02301EA8	; 02303180
	ldrh r1,[r0,#0x4]	; 02303184
	cmp r1,#0x0	; 02303186
	beq loc_02303192	; 02303188
	mov r0,#0x1	; 0230318A
	bl loc_023030FC	; 0230318C
	b loc_02303206	; 02303190
loc_02303192:
	ldrh r7,[r5,#0x2]	; 02303192
	ldrh r0,[r5,#0x4]	; 02303194
	str r0,[sp,#0x4]	; 02303196
	ldrh r6,[r5,#0x6]	; 02303198
	ldrh r5,[r5,#0x8]	; 0230319A
	add r0,sp,#0x8	; 0230319C
	mov r1,#0x0	; 0230319E
	mov r2,#0x10	; 023031A0
	bl loc_02303220	; 023031A2
	add r0,sp,#0x8	; 023031A6
	strb r6,[r0,#0x0]	; 023031A8
	add r0,sp,#0x8	; 023031AA
	str r0,[sp,#0x0]	; 023031AC
	add r0,sp,#0x18	; 023031AE
	add r1,r7,#0x0	; 023031B0
	ldr r2,[sp,#0x4]	; 023031B2
	add r3,r5,#0x0	; 023031B4
	bl loc_02301BA8	; 023031B6
	ldrh r1,[r0,#0x4]	; 023031BA
	cmp r1,#0x0	; 023031BC
	beq loc_023031C8	; 023031BE
	mov r0,#0xa	; 023031C0
	bl loc_023030FC	; 023031C2
	b loc_02303206	; 023031C6
loc_023031C8:
	ldrh r2,[r0,#0x8]	; 023031C8
	mov r0,#0xff	; 023031CA
	add r1,r2,#0x0	; 023031CC
	and r1,r0	; 023031CE
	lsl r0,r1,#0x10	; 023031D0
	lsr r5,r0,#0x10	; 023031D2
	lsl r0,r2,#0x8	; 023031D4
	lsr r6,r0,#0x10	; 023031D6
	add r0,sp,#0x18	; 023031D8
	bl loc_0230195C	; 023031DA
	ldrh r1,[r0,#0x4]	; 023031DE
	cmp r1,#0x0	; 023031E0
	beq loc_023031EC	; 023031E2
	ldr r0,[pool_0230321C]	; 023031E4
	bl loc_023030FC	; 023031E6
	b loc_02303206	; 023031EA
loc_023031EC:
	mov r1,#0x2	; 023031EC
	ldr r0,[r4,#0x0]	; 023031EE
	strh r1,[r0,#0x0]	; 023031F0
	bl loc_02300404	; 023031F2
	mov r1,#0x1e	; 023031F6
	strh r1,[r0,#0x0]	; 023031F8
	mov r1,#0x0	; 023031FA
	strh r1,[r0,#0x2]	; 023031FC
	strh r5,[r0,#0x8]	; 023031FE
	strh r6,[r0,#0xa]	; 02303200
	bl loc_02300414	; 02303202
loc_02303206:
	add sp,#0x1fc	; 02303206
	add sp,#0x20	; 02303208
	pop {r4,r5,r6,r7}	; 0230320A
	pop {r3}	; 0230320C
	bx r3	; 0230320E
pool_02303210:
loc_02303210:
	.word 0x00001518	; 02303210
pool_02303214:
loc_02303214:
	.word 0x00000308	; 02303214
pool_02303218:
loc_02303218:
	.word 0x00000303	; 02303218
pool_0230321C:
loc_0230321C:
	.word 0x00000302	; 0230321C

; ===== function loc_02303220 =====
loc_02303220:
	bx pc	; 02303220
	.byte 0xC0, 0x46	; 02303224
.arm

; ===== function loc_02303224 =====
loc_02303224:
	ldr pc,[pool_02303228]	; 02303224
pool_02303228:
loc_02303228:
	.word loc_037FCEB0	; 02303228
.thumb

; ===== function loc_0230322C =====
loc_0230322C:
	push {r4,r5,lr}	; 0230322C
	sub sp,#0x4	; 0230322E
	add r5,r0,#0x0	; 02303230
	add r4,r1,#0x0	; 02303232
	bl loc_02300404	; 02303234
	mov r1,#0x1f	; 02303238
	strh r1,[r0,#0x0]	; 0230323A
	mov r1,#0x1	; 0230323C
	strh r1,[r0,#0x2]	; 0230323E
	strh r5,[r0,#0x4]	; 02303240
	strh r4,[r0,#0x6]	; 02303242
	bl loc_02300414	; 02303244
	add sp,#0x4	; 02303248
	pop {r4,r5}	; 0230324A
	pop {r3}	; 0230324C
	bx r3	; 0230324E

; ===== function loc_02303250 =====
	push {lr}	; 02303250
	sub sp,#0x1fc	; 02303252
	sub sp,#0x8	; 02303254
	bl loc_023008B4	; 02303256
	add r0,sp,#0x0	; 0230325A
	bl loc_0230192C	; 0230325C
	ldrh r1,[r0,#0x4]	; 02303260
	cmp r1,#0x0	; 02303262
	beq loc_0230326E	; 02303264
	ldr r0,[pool_02303288]	; 02303266
	bl loc_0230322C	; 02303268
	b loc_0230327E	; 0230326C
loc_0230326E:
	bl loc_02300404	; 0230326E
	mov r1,#0x1f	; 02303272
	strh r1,[r0,#0x0]	; 02303274
	mov r1,#0x0	; 02303276
	strh r1,[r0,#0x2]	; 02303278
	bl loc_02300414	; 0230327A
loc_0230327E:
	add sp,#0x1fc	; 0230327E
	add sp,#0x8	; 02303280
	pop {r3}	; 02303282
	bx r3	; 02303284
	.byte 0xC0, 0x46	; 02303288
pool_02303288:
loc_02303288:
	.word 0x00000305	; 02303288

; ===== function loc_0230328C =====
loc_0230328C:
	push {r4,r5,lr}	; 0230328C
	sub sp,#0x4	; 0230328E
	add r5,r0,#0x0	; 02303290
	add r4,r1,#0x0	; 02303292
	bl loc_02300404	; 02303294
	mov r1,#0x20	; 02303298
	strh r1,[r0,#0x0]	; 0230329A
	mov r1,#0x1	; 0230329C
	strh r1,[r0,#0x2]	; 0230329E
	strh r5,[r0,#0x4]	; 023032A0
	strh r4,[r0,#0x6]	; 023032A2
	bl loc_02300414	; 023032A4
	add sp,#0x4	; 023032A8
	pop {r4,r5}	; 023032AA
	pop {r3}	; 023032AC
	bx r3	; 023032AE

; ===== function loc_023032B0 =====
	push {r4,r5,lr}	; 023032B0
	sub sp,#0x1fc	; 023032B2
	sub sp,#0x8	; 023032B4
	bl loc_023008B4	; 023032B6
	add r0,sp,#0x0	; 023032BA
	bl loc_0230190C	; 023032BC
	add r5,r0,#0x0	; 023032C0
	ldrh r1,[r5,#0x4]	; 023032C2
	cmp r1,#0x0	; 023032C4
	beq loc_023032D0	; 023032C6
	ldr r0,[pool_023032FC]	; 023032C8
	bl loc_0230328C	; 023032CA
	b loc_023032F2	; 023032CE
loc_023032D0:
	bl loc_02300404	; 023032D0
	add r4,r0,#0x0	; 023032D4
	mov r0,#0x20	; 023032D6
	strh r0,[r4,#0x0]	; 023032D8
	mov r0,#0x0	; 023032DA
	strh r0,[r4,#0x2]	; 023032DC
	add r5,#0x8	; 023032DE
	add r0,r5,#0x0	; 023032E0
	add r1,r4,#0x0	; 023032E2
	add r1,#0x8	; 023032E4
	mov r2,#0xb4	; 023032E6
	bl loc_02303300	; 023032E8
	add r0,r4,#0x0	; 023032EC
	bl loc_02300414	; 023032EE
loc_023032F2:
	add sp,#0x1fc	; 023032F2
	add sp,#0x8	; 023032F4
	pop {r4,r5}	; 023032F6
	pop {r3}	; 023032F8
	bx r3	; 023032FA
pool_023032FC:
loc_023032FC:
	.word 0x00000307	; 023032FC

; ===== function loc_02303300 =====
loc_02303300:
	bx pc	; 02303300
	.byte 0xC0, 0x46	; 02303304
.arm

; ===== function loc_02303304 =====
loc_02303304:
	ldr pc,[pool_02303308]	; 02303304
pool_02303308:
loc_02303308:
	.word P2_Entry_037FCE1C	; 02303308
.thumb

; ===== function loc_0230330C =====
loc_0230330C:
	bx lr	; 0230330C
	.byte 0x00, 0x00	; 02303310

; ===== function loc_02303310 =====
loc_02303310:
	push {r4,lr}	; 02303310
	bl loc_023008B4	; 02303312
	add r4,r0,#0x0	; 02303316
	mov r0,#0x1c	; 02303318
	ldr r1,[pool_02303354]	; 0230331A
	str r0,[r1,#0x0]	; 0230331C
	add r0,r4,#0x0	; 0230331E
	add r0,#0x64	; 02303320
	mov r2,#0x0	; 02303322
	bl loc_02300824	; 02303324
	cmp r0,#0x0	; 02303328
	bne loc_0230334C	; 0230332A
	ldr r0,[pool_02303358]	; 0230332C
	ldr r0,[r4,r0]	; 0230332E
	cmp r0,#0x0	; 02303330
	beq loc_0230334C	; 02303332
	bl loc_02300404	; 02303334
	mov r1,#0x80	; 02303338
	strh r1,[r0,#0x0]	; 0230333A
	mov r1,#0x8	; 0230333C
	strh r1,[r0,#0x2]	; 0230333E
	mov r1,#0x16	; 02303340
	strh r1,[r0,#0x4]	; 02303342
	mov r1,#0x1c	; 02303344
	strh r1,[r0,#0x6]	; 02303346
	bl loc_02300414	; 02303348
loc_0230334C:
	pop {r4}	; 0230334C
	pop {r3}	; 0230334E
	bx r3	; 02303350
	.byte 0xC0, 0x46	; 02303354
pool_02303354:
loc_02303354:
	.word P4_BssStart + 0x2420	; 02303354
pool_02303358:
loc_02303358:
	.word 0x00001518	; 02303358

; ===== function loc_0230335C =====
loc_0230335C:
	push {lr}	; 0230335C
	sub sp,#0x4	; 0230335E
	bl loc_023008B4	; 02303360
	ldr r1,[pool_02303388]	; 02303364
	ldr r0,[r0,r1]	; 02303366
	ldr r1,[r0,#0x0]	; 02303368
	ldr r1,[r1,#0x10]	; 0230336A
	cmp r1,#0x1	; 0230336C
	bne loc_02303380	; 0230336E
	add r0,#0xd0	; 02303370
	mov r1,#0xd3	; 02303372
	ldr r2,[pool_0230338C]	; 02303374
	add r3,r1,#0x0	; 02303376
	bl loc_02303390	; 02303378
	bl loc_02303310	; 0230337C
loc_02303380:
	add sp,#0x4	; 02303380
	pop {r3}	; 02303382
	bx r3	; 02303384
	.byte 0xC0, 0x46	; 02303388
pool_02303388:
loc_02303388:
	.word 0x00001518	; 02303388
pool_0230338C:
loc_0230338C:
	.word P4_Code_02303688 + 1	; 0230338C

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
	.word P2_Entry_037FCA24 + 1	; 0230339C
.thumb

; ===== function loc_023033A0 =====
loc_023033A0:
	push {r4,lr}	; 023033A0
	bl loc_023008B4	; 023033A2
	ldr r1,[pool_023033EC]	; 023033A6
	ldr r4,[r0,r1]	; 023033A8
	ldr r1,[r4,#0x0]	; 023033AA
	add r0,r1,#0x0	; 023033AC
	add r0,#0xd8	; 023033AE
	ldrh r0,[r0,#0x0]	; 023033B0
	cmp r0,#0x3c	; 023033B2
	bcc loc_023033CC	; 023033B4
	ldr r1,[pool_023033F0]	; 023033B6
	ldrh r0,[r1,#0x0]	; 023033B8
	cmp r0,#0xd3	; 023033BA
	bne loc_023033C2	; 023033BC
	mov r0,#0xd3	; 023033BE
	strh r0,[r1,#0x0]	; 023033C0
loc_023033C2:
	mov r1,#0x0	; 023033C2
	ldr r0,[r4,#0x0]	; 023033C4
	add r0,#0xd8	; 023033C6
	strh r1,[r0,#0x0]	; 023033C8
	b loc_023033D4	; 023033CA
loc_023033CC:
	add r1,#0xd8	; 023033CC
	ldrh r0,[r1,#0x0]	; 023033CE
	add r0,r0,#0x1	; 023033D0
	strh r0,[r1,#0x0]	; 023033D2
loc_023033D4:
	bl loc_02303648	; 023033D4
	add r4,#0xd0	; 023033D8
	add r0,r4,#0x0	; 023033DA
	ldr r1,[pool_023033F4]	; 023033DC
	ldr r2,[pool_023033F8]	; 023033DE
	add r3,r1,#0x0	; 023033E0
	bl loc_02303390	; 023033E2
	pop {r4}	; 023033E6
	pop {r3}	; 023033E8
	bx r3	; 023033EA
pool_023033EC:
loc_023033EC:
	.word 0x00001518	; 023033EC
pool_023033F0:
loc_023033F0:
	.word REG_VCOUNT	; 023033F0
pool_023033F4:
loc_023033F4:
	.word 0x00000104	; 023033F4
pool_023033F8:
loc_023033F8:
	.word P4_Code_02303688 + 1	; 023033F8

; ===== function loc_023033FC =====
loc_023033FC:
	push {lr}	; 023033FC
	sub sp,#0x4	; 023033FE
	bl loc_023008B4	; 02303400
	ldr r1,[pool_02303428]	; 02303404
	ldr r0,[r0,r1]	; 02303406
	ldr r1,[r0,#0x0]	; 02303408
	ldr r1,[r1,#0x10]	; 0230340A
	cmp r1,#0x1	; 0230340C
	bne loc_02303420	; 0230340E
	add r0,#0xd0	; 02303410
	mov r1,#0xc8	; 02303412
	ldr r2,[pool_0230342C]	; 02303414
	add r3,r1,#0x0	; 02303416
	bl loc_02303390	; 02303418
	bl loc_02303310	; 0230341C
loc_02303420:
	add sp,#0x4	; 02303420
	pop {r3}	; 02303422
	bx r3	; 02303424
	.byte 0xC0, 0x46	; 02303428
pool_02303428:
loc_02303428:
	.word 0x00001518	; 02303428
pool_0230342C:
loc_0230342C:
	.word P4_Code_02303688 + 1	; 0230342C

; ===== function loc_02303430 =====
loc_02303430:
	push {r4,lr}	; 02303430
	bl loc_023008B4	; 02303432
	ldr r1,[pool_02303464]	; 02303436
	ldr r4,[r0,r1]	; 02303438
	ldr r2,[r4,#0x0]	; 0230343A
	add r0,r2,#0x0	; 0230343C
	add r0,#0xd4	; 0230343E
	ldr r1,[r0,#0x0]	; 02303440
	ldr r0,[pool_02303468]	; 02303442
	cmp r1,r0	; 02303444
	bls loc_0230344C	; 02303446
	mov r0,#0x0	; 02303448
	str r0,[r2,#0x24]	; 0230344A
loc_0230344C:
	bl loc_023034E0	; 0230344C
	add r4,#0xd0	; 02303450
	add r0,r4,#0x0	; 02303452
	mov r1,#0xf0	; 02303454
	ldr r2,[pool_0230346C]	; 02303456
	add r3,r1,#0x0	; 02303458
	bl loc_02303390	; 0230345A
	pop {r4}	; 0230345E
	pop {r3}	; 02303460
	bx r3	; 02303462
pool_02303464:
loc_02303464:
	.word 0x00001518	; 02303464
pool_02303468:
loc_02303468:
	.word 0x00000190	; 02303468
pool_0230346C:
loc_0230346C:
	.word P4_Code_02303688 + 1	; 0230346C

; ===== function loc_02303470 =====
loc_02303470:
	push {r4,lr}	; 02303470
	bl loc_023008B4	; 02303472
	ldr r1,[pool_023034D4]	; 02303476
	ldr r4,[r0,r1]	; 02303478
	ldr r0,[pool_023034D8]	; 0230347A
	ldrh r1,[r0,#0x0]	; 0230347C
	ldr r0,[r4,#0x0]	; 0230347E
	add r0,#0xcc	; 02303480
	str r1,[r0,#0x0]	; 02303482
	ldr r2,[r4,#0x0]	; 02303484
	add r0,r2,#0x0	; 02303486
	add r0,#0xcc	; 02303488
	ldr r1,[r0,#0x0]	; 0230348A
	add r0,r2,#0x0	; 0230348C
	add r0,#0xd0	; 0230348E
	ldr r0,[r0,#0x0]	; 02303490
	cmp r0,r1	; 02303492
	beq loc_0230349E	; 02303494
	add r2,#0xd0	; 02303496
	str r1,[r2,#0x0]	; 02303498
	bl loc_0230358C	; 0230349A
loc_0230349E:
	ldr r1,[r4,#0x0]	; 0230349E
	add r0,r1,#0x0	; 023034A0
	add r0,#0xd4	; 023034A2
	ldr r0,[r0,#0x0]	; 023034A4
	cmp r0,#0x8c	; 023034A6
	bls loc_023034BA	; 023034A8
	add r4,#0xd0	; 023034AA
	add r0,r4,#0x0	; 023034AC
	mov r1,#0xd2	; 023034AE
	ldr r2,[pool_023034DC]	; 023034B0
	add r3,r1,#0x0	; 023034B2
	bl loc_02303390	; 023034B4
	b loc_023034CC	; 023034B8
loc_023034BA:
	mov r0,#0x1	; 023034BA
	str r0,[r1,#0x24]	; 023034BC
	add r4,#0xd0	; 023034BE
	add r0,r4,#0x0	; 023034C0
	mov r1,#0xf0	; 023034C2
	ldr r2,[pool_023034DC]	; 023034C4
	add r3,r1,#0x0	; 023034C6
	bl loc_02303390	; 023034C8
loc_023034CC:
	pop {r4}	; 023034CC
	pop {r3}	; 023034CE
	bx r3	; 023034D0
	.byte 0xC0, 0x46	; 023034D4
pool_023034D4:
loc_023034D4:
	.word 0x00001518	; 023034D4
pool_023034D8:
loc_023034D8:
	.word FirmwareWlAdjustedTimeSlot	; 023034D8
pool_023034DC:
loc_023034DC:
	.word P4_Code_02303688 + 1	; 023034DC

; ===== function loc_023034E0 =====
loc_023034E0:
	push {lr}	; 023034E0
	sub sp,#0x4	; 023034E2
	bl loc_023008B4	; 023034E4
	ldr r1,[pool_02303570]	; 023034E8
	ldr r1,[r0,r1]	; 023034EA
	ldr r0,[r1,#0x0]	; 023034EC
	add r0,#0xd4	; 023034EE
	ldr r0,[r0,#0x0]	; 023034F0
	cmp r0,#0x8c	; 023034F2
	bls loc_0230350E	; 023034F4
	ldr r2,[pool_02303574]	; 023034F6
	cmp r0,r2	; 023034F8
	bhi loc_0230350E	; 023034FA
	mov r2,#0xd2	; 023034FC
	ldr r0,[pool_02303578]	; 023034FE
	strh r2,[r0,#0x0]	; 02303500
	ldr r1,[r1,#0x0]	; 02303502
	add r1,#0xd4	; 02303504
	ldr r0,[r1,#0x0]	; 02303506
	sub r0,#0x41	; 02303508
	str r0,[r1,#0x0]	; 0230350A
	b loc_02303568	; 0230350C
loc_0230350E:
	ldr r2,[pool_02303574]	; 0230350E
	cmp r0,r2	; 02303510
	bls loc_0230352C	; 02303512
	ldr r2,[pool_0230357C]	; 02303514
	cmp r0,r2	; 02303516
	bhi loc_0230352C	; 02303518
	mov r2,#0xd1	; 0230351A
	ldr r0,[pool_02303578]	; 0230351C
	strh r2,[r0,#0x0]	; 0230351E
	ldr r1,[r1,#0x0]	; 02303520
	add r1,#0xd4	; 02303522
	ldr r0,[r1,#0x0]	; 02303524
	sub r0,#0x82	; 02303526
	str r0,[r1,#0x0]	; 02303528
	b loc_02303568	; 0230352A
loc_0230352C:
	ldr r2,[pool_0230357C]	; 0230352C
	cmp r0,r2	; 0230352E
	bls loc_0230354A	; 02303530
	ldr r2,[pool_02303580]	; 02303532
	cmp r0,r2	; 02303534
	bhi loc_0230354A	; 02303536
	mov r2,#0xd0	; 02303538
	ldr r0,[pool_02303578]	; 0230353A
	strh r2,[r0,#0x0]	; 0230353C
	ldr r1,[r1,#0x0]	; 0230353E
	add r1,#0xd4	; 02303540
	ldr r0,[r1,#0x0]	; 02303542
	sub r0,#0xc3	; 02303544
	str r0,[r1,#0x0]	; 02303546
	b loc_02303568	; 02303548
loc_0230354A:
	ldr r2,[pool_02303580]	; 0230354A
	cmp r0,r2	; 0230354C
	bls loc_02303568	; 0230354E
	ldr r2,[pool_02303584]	; 02303550
	cmp r0,r2	; 02303552
	bhi loc_02303568	; 02303554
	mov r2,#0xca	; 02303556
	ldr r0,[pool_02303578]	; 02303558
	strh r2,[r0,#0x0]	; 0230355A
	ldr r2,[r1,#0x0]	; 0230355C
	add r2,#0xd4	; 0230355E
	ldr r1,[r2,#0x0]	; 02303560
	ldr r0,[pool_02303588]	; 02303562
	sub r0,r1,r0	; 02303564
	str r0,[r2,#0x0]	; 02303566
loc_02303568:
	add sp,#0x4	; 02303568
	pop {r3}	; 0230356A
	bx r3	; 0230356C
	.byte 0xC0, 0x46	; 02303570
pool_02303570:
loc_02303570:
	.word 0x00001518	; 02303570
pool_02303574:
loc_02303574:
	.word 0x0000012C	; 02303574
pool_02303578:
loc_02303578:
	.word REG_VCOUNT	; 02303578
pool_0230357C:
loc_0230357C:
	.word 0x000001F4	; 0230357C
pool_02303580:
loc_02303580:
	.word 0x000003E8	; 02303580
pool_02303584:
loc_02303584:
	.word 0x000041A0	; 02303584
pool_02303588:
loc_02303588:
	.word 0x00000249	; 02303588

; ===== function loc_0230358C =====
loc_0230358C:
	push {r4,r5,lr}	; 0230358C
	sub sp,#0x4	; 0230358E
	bl loc_023008B4	; 02303590
	ldr r1,[pool_02303628]	; 02303594
	ldr r2,[r0,r1]	; 02303596
	ldr r1,[r2,#0x0]	; 02303598
	add r1,#0xcc	; 0230359A
	ldr r0,[r1,#0x0]	; 0230359C
	lsl r0,r0,#0x6	; 0230359E
	str r0,[r1,#0x0]	; 023035A0
	ldr r3,[pool_0230362C]	; 023035A2
	ldrh r1,[r3,#0x0]	; 023035A4
	ldr r0,[pool_02303630]	; 023035A6
	ldrh r4,[r0,#0x0]	; 023035A8
	ldrh r3,[r3,#0x0]	; 023035AA
	cmp r1,r3	; 023035AC
	bls loc_023035B2	; 023035AE
	ldrh r4,[r0,#0x0]	; 023035B0
loc_023035B2:
	lsl r4,r4,#0x10	; 023035B2
	orr r4,r3	; 023035B4
	ldr r0,[pool_02303634]	; 023035B6
	ldrh r1,[r0,#0x0]	; 023035B8
	ldr r3,[pool_02303638]	; 023035BA
	and r4,r3	; 023035BC
	lsl r4,r4,#0x1	; 023035BE
	ldr r0,[pool_0230363C]	; 023035C0
	sub r1,r0,r1	; 023035C2
	mov r0,#0x7f	; 023035C4
	mul r1,r0	; 023035C6
	add r0,r4,r1	; 023035C8
	lsr r1,r0,#0x1	; 023035CA
	and r1,r3	; 023035CC
	ldr r3,[r2,#0x0]	; 023035CE
	add r0,r3,#0x0	; 023035D0
	add r0,#0xcc	; 023035D2
	ldr r0,[r0,#0x0]	; 023035D4
	cmp r0,r1	; 023035D6
	bls loc_023035E2	; 023035D8
	mov r0,#0x0	; 023035DA
	add r3,#0xd4	; 023035DC
	str r0,[r3,#0x0]	; 023035DE
	b loc_0230361E	; 023035E0
loc_023035E2:
	mov r3,#0x1	; 023035E2
	ldr r4,[pool_02303640]	; 023035E4
	b loc_0230361A	; 023035E6
loc_023035E8:
	ldr r0,[r2,#0x0]	; 023035E8
	add r5,r0,#0x0	; 023035EA
	add r5,#0xcc	; 023035EC
	ldr r5,[r5,#0x0]	; 023035EE
	cmp r5,r1	; 023035F0
	bls loc_02303610	; 023035F2
	sub r1,r5,r1	; 023035F4
	add r0,#0xd4	; 023035F6
	str r1,[r0,#0x0]	; 023035F8
	ldr r2,[r2,#0x0]	; 023035FA
	add r0,r2,#0x0	; 023035FC
	add r0,#0xd4	; 023035FE
	ldr r1,[r0,#0x0]	; 02303600
	ldr r0,[pool_02303644]	; 02303602
	cmp r1,r0	; 02303604
	bls loc_0230361E	; 02303606
	mov r0,#0x0	; 02303608
	add r2,#0xd4	; 0230360A
	str r0,[r2,#0x0]	; 0230360C
	b loc_0230361E	; 0230360E
loc_02303610:
	add r0,#0xcc	; 02303610
	ldr r5,[r0,#0x0]	; 02303612
	add r5,r5,r4	; 02303614
	str r5,[r0,#0x0]	; 02303616
	add r3,r3,#0x1	; 02303618
loc_0230361A:
	cmp r3,#0x1e	; 0230361A
	blt loc_023035E8	; 0230361C
loc_0230361E:
	add sp,#0x4	; 0230361E
	pop {r4,r5}	; 02303620
	pop {r3}	; 02303622
	bx r3	; 02303624
	.byte 0xC0, 0x46	; 02303628
pool_02303628:
loc_02303628:
	.word 0x00001518	; 02303628
pool_0230362C:
loc_0230362C:
	.word REG_WIFI_US_COUNT0	; 0230362C
pool_02303630:
loc_02303630:
	.word REG_WIFI_US_COUNT1	; 02303630
pool_02303634:
loc_02303634:
	.word REG_VCOUNT	; 02303634
pool_02303638:
loc_02303638:
	.word 0x003FFFC0	; 02303638
pool_0230363C:
loc_0230363C:
	.word 0x00000107	; 0230363C
pool_02303640:
loc_02303640:
	.word 0x0000414B	; 02303640
pool_02303644:
loc_02303644:
	.word 0x00004000	; 02303644

; ===== function loc_02303648 =====
loc_02303648:
; 对 Wi-Fi 微秒计数作 VCOUNT 校正，截为 16 位后写入共享槽。
; Adjust the Wi-Fi microsecond count using VCOUNT, storing its low 16-bit result.
.func P4_UpdateScanlineAdjustedWifiTime
	push {r4,lr}	; 02303648
	ldr r0,[pool_02303678]	; 0230364A
	ldrh r0,[r0,#0x0]	; 0230364C
	ldr r3,[pool_0230367C]	; 0230364E
	ldrh r2,[r3,#0x0]	; 02303650
	ldr r1,[pool_02303680]	; 02303652
	ldrh r4,[r1,#0x0]	; 02303654
	ldrh r3,[r3,#0x0]	; 02303656
	cmp r2,r3	; 02303658
	bls loc_0230365E	; 0230365A
	ldrh r4,[r1,#0x0]	; 0230365C
loc_0230365E:
	lsl r1,r4,#0x10	; 0230365E
	orr r1,r3	; 02303660
	lsl r2,r1,#0x1	; 02303662
	mov r1,#0x7f	; 02303664
	mul r0,r1	; 02303666
	sub r0,r2,r0	; 02303668
	lsr r1,r0,#0x7	; 0230366A
	ldr r0,[pool_02303684]	; 0230366C
	strh r1,[r0,#0x0]	; 0230366E
	pop {r4}	; 02303670
	pop {r3}	; 02303672
	bx r3	; 02303674
.endfunc
	.byte 0xC0, 0x46	; 02303678
pool_02303678:
loc_02303678:
	.word REG_VCOUNT	; 02303678
pool_0230367C:
loc_0230367C:
	.word REG_WIFI_US_COUNT0	; 0230367C
pool_02303680:
loc_02303680:
	.word REG_WIFI_US_COUNT1	; 02303680
pool_02303684:
loc_02303684:
	.word FirmwareWlAdjustedTimeSlot	; 02303684

; ===== function loc_02303688 =====
P4_Code_02303688:
	push {lr}	; 02303688
	sub sp,#0x4	; 0230368A
	cmp r0,#0xd3	; 0230368C
	bhi loc_023036A4	; 0230368E
	cmp r0,#0xd2	; 02303690
	bcc loc_0230369E	; 02303692
	cmp r0,#0xd2	; 02303694
	beq loc_023036C0	; 02303696
	cmp r0,#0xd3	; 02303698
	beq loc_023036CC	; 0230369A
	b loc_023036DA	; 0230369C
loc_0230369E:
	cmp r0,#0xc8	; 0230369E
	beq loc_023036B6	; 023036A0
	b loc_023036DA	; 023036A2
loc_023036A4:
	cmp r0,#0xf0	; 023036A4
	bhi loc_023036AE	; 023036A6
	cmp r0,#0xf0	; 023036A8
	beq loc_023036C6	; 023036AA
	b loc_023036DA	; 023036AC
loc_023036AE:
	ldr r1,[pool_023036E0]	; 023036AE
	cmp r0,r1	; 023036B0
	beq loc_023036D6	; 023036B2
	b loc_023036DA	; 023036B4
loc_023036B6:
	bl loc_0230330C	; 023036B6
	bl loc_02303470	; 023036BA
	b loc_023036DA	; 023036BE
loc_023036C0:
	bl loc_02303430	; 023036C0
	b loc_023036DA	; 023036C4
loc_023036C6:
	bl loc_023033FC	; 023036C6
	b loc_023036DA	; 023036CA
loc_023036CC:
	bl loc_0230330C	; 023036CC
	bl loc_023033A0	; 023036D0
	b loc_023036DA	; 023036D4
loc_023036D6:
	bl loc_0230335C	; 023036D6
loc_023036DA:
	add sp,#0x4	; 023036DA
	pop {r3}	; 023036DC
	bx r3	; 023036DE
pool_023036E0:
loc_023036E0:
	.word 0x00000104	; 023036E0

; ===== function loc_023036E4 =====
loc_023036E4:
	push {r4,lr}	; 023036E4
	bl loc_023008B4	; 023036E6
	ldr r1,[pool_02303730]	; 023036EA
	ldr r4,[r0,r1]	; 023036EC
	ldr r1,[r4,#0x0]	; 023036EE
	add r0,r1,#0x0	; 023036F0
	add r0,#0xe2	; 023036F2
	ldrh r0,[r0,#0x0]	; 023036F4
	cmp r0,#0x1	; 023036F6
	bne loc_0230370A	; 023036F8
	add r4,#0xd0	; 023036FA
	add r0,r4,#0x0	; 023036FC
	mov r1,#0xd3	; 023036FE
	ldr r2,[pool_02303734]	; 02303700
	add r3,r1,#0x0	; 02303702
	bl loc_02303390	; 02303704
	b loc_02303728	; 02303708
loc_0230370A:
	cmp r0,#0x2	; 0230370A
	bne loc_02303728	; 0230370C
	mov r0,#0x0	; 0230370E
	str r0,[r1,#0x24]	; 02303710
	add r0,r4,#0x0	; 02303712
	add r0,#0xd0	; 02303714
	mov r1,#0xc8	; 02303716
	ldr r2,[pool_02303734]	; 02303718
	add r3,r1,#0x0	; 0230371A
	bl loc_02303390	; 0230371C
	mov r1,#0x0	; 02303720
	ldr r0,[r4,#0x0]	; 02303722
	add r0,#0xd4	; 02303724
	str r1,[r0,#0x0]	; 02303726
loc_02303728:
	pop {r4}	; 02303728
	pop {r3}	; 0230372A
	bx r3	; 0230372C
	.byte 0xC0, 0x46	; 02303730
pool_02303730:
loc_02303730:
	.word 0x00001518	; 02303730
pool_02303734:
loc_02303734:
	.word P4_Code_02303688 + 1	; 02303734

; ===== function loc_02303738 =====
loc_02303738:
	push {lr}	; 02303738
	sub sp,#0x4	; 0230373A
	bl loc_023008B4	; 0230373C
	ldr r1,[pool_02303750]	; 02303740
	ldr r0,[r0,r1]	; 02303742
	add r0,#0xd0	; 02303744
	bl loc_02303754	; 02303746
	add sp,#0x4	; 0230374A
	pop {r3}	; 0230374C
	bx r3	; 0230374E
pool_02303750:
loc_02303750:
	.word 0x00001518	; 02303750

; ===== function loc_02303754 =====
loc_02303754:
	bx pc	; 02303754
	.byte 0xC0, 0x46	; 02303758
.arm

; ===== function loc_02303758 =====
loc_02303758:
	ldr r12,[pool_02303760]	; 02303758
	bx r12	; 0230375C
pool_02303760:
loc_02303760:
	.word loc_037FCB1C + 1	; 02303760
.thumb

; ===== function loc_02303764 =====
	push {lr}	; 02303764
	sub sp,#0x4	; 02303766
	bl loc_023008B4	; 02303768
	ldr r1,[pool_02303784]	; 0230376C
	ldr r0,[r0,r1]	; 0230376E
	ldr r0,[r0,#0x0]	; 02303770
	ldrh r0,[r0,#0x0]	; 02303772
	cmp r0,#0xa	; 02303774
	bne loc_0230377C	; 02303776
	bl loc_023042B4	; 02303778
loc_0230377C:
	add sp,#0x4	; 0230377C
	pop {r3}	; 0230377E
	bx r3	; 02303780
	.byte 0xC0, 0x46	; 02303784
pool_02303784:
loc_02303784:
	.word 0x00001518	; 02303784

; ===== function loc_02303788 =====
	push {r4,lr}	; 02303788
	add r4,r0,#0x0	; 0230378A
	bl loc_023008B4	; 0230378C
	ldr r1,[pool_023037AC]	; 02303790
	ldr r0,[r0,r1]	; 02303792
	ldr r0,[r0,#0x0]	; 02303794
	ldrh r0,[r0,#0x0]	; 02303796
	cmp r0,#0x9	; 02303798
	bne loc_023037A6	; 0230379A
	ldr r0,[r4,#0x4]	; 0230379C
	lsl r0,r0,#0x10	; 0230379E
	lsr r0,r0,#0x10	; 023037A0
	bl loc_02304190	; 023037A2
loc_023037A6:
	pop {r4}	; 023037A6
	pop {r3}	; 023037A8
	bx r3	; 023037AA
pool_023037AC:
loc_023037AC:
	.word 0x00001518	; 023037AC

; ===== function loc_023037B0 =====
	push {r4,r5,lr}	; 023037B0
	sub sp,#0x4	; 023037B2
	bl loc_023008B4	; 023037B4
	ldr r1,[pool_02303870]	; 023037B8
	ldr r0,[r0,r1]	; 023037BA
	ldr r5,[r0,#0x0]	; 023037BC
	mov r1,#0x1	; 023037BE
	add r0,r5,#0x0	; 023037C0
	add r0,#0x88	; 023037C2
	strh r1,[r0,#0x0]	; 023037C4
	ldrh r0,[r5,#0x0]	; 023037C6
	cmp r0,#0x9	; 023037C8
	bne loc_0230383E	; 023037CA
	bl loc_02303880	; 023037CC
	ldrh r1,[r5,#0x3e]	; 023037D0
	cmp r1,#0x0	; 023037D2
	bne loc_023037DA	; 023037D4
	mov r1,#0x1	; 023037D6
	b loc_023037DC	; 023037D8
loc_023037DA:
	mov r1,#0x0	; 023037DA
loc_023037DC:
	add r4,r5,#0x0	; 023037DC
	add r4,#0x3e	; 023037DE
	ldrh r3,[r4,#0x0]	; 023037E0
	ldrh r2,[r5,#0x3c]	; 023037E2
	add r2,r3,r2	; 023037E4
	strh r2,[r4,#0x0]	; 023037E6
	ldrh r3,[r5,#0x3e]	; 023037E8
	ldr r2,[pool_02303874]	; 023037EA
	cmp r3,r2	; 023037EC
	bls loc_023037F2	; 023037EE
	strh r2,[r5,#0x3e]	; 023037F0
loc_023037F2:
	cmp r1,#0x0	; 023037F2
	beq loc_02303800	; 023037F4
	ldrh r1,[r5,#0x3e]	; 023037F6
	cmp r1,#0x0	; 023037F8
	beq loc_02303800	; 023037FA
	mov r4,#0x1	; 023037FC
	b loc_02303802	; 023037FE
loc_02303800:
	mov r4,#0x0	; 02303800
loc_02303802:
	bl loc_0230388C	; 02303802
	cmp r4,#0x0	; 02303806
	beq loc_02303810	; 02303808
	ldr r0,[pool_02303878]	; 0230380A
	bl loc_02304190	; 0230380C
loc_02303810:
	add r0,r5,#0x0	; 02303810
	add r0,#0x92	; 02303812
	ldrh r0,[r0,#0x0]	; 02303814
	cmp r0,#0x1	; 02303816
	bne loc_02303868	; 02303818
	add r1,r5,#0x0	; 0230381A
	add r1,#0x9c	; 0230381C
	ldrh r0,[r1,#0x0]	; 0230381E
	sub r0,r0,#0x1	; 02303820
	strh r0,[r1,#0x0]	; 02303822
	add r0,r5,#0x0	; 02303824
	add r0,#0x9c	; 02303826
	ldrh r0,[r0,#0x0]	; 02303828
	cmp r0,#0x0	; 0230382A
	bne loc_02303868	; 0230382C
	mov r1,#0x1	; 0230382E
	add r0,r5,#0x0	; 02303830
	add r0,#0x9a	; 02303832
	strh r1,[r0,#0x0]	; 02303834
	mov r0,#0x3c	; 02303836
	add r5,#0x9c	; 02303838
	strh r0,[r5,#0x0]	; 0230383A
	b loc_02303868	; 0230383C
loc_0230383E:
	cmp r0,#0xa	; 0230383E
	bne loc_02303868	; 02303840
	mov r4,#0x0	; 02303842
	bl loc_02303898	; 02303844
	ldrh r1,[r5,#0x3a]	; 02303848
	cmp r1,#0x1	; 0230384A
	bne loc_0230385C	; 0230384C
	ldr r1,[pool_0230387C]	; 0230384E
	ldr r1,[r5,r1]	; 02303850
	cmp r1,#0x1	; 02303852
	beq loc_0230385C	; 02303854
	mov r4,#0x1	; 02303856
	mov r1,#0x0	; 02303858
	strh r1,[r5,#0x3a]	; 0230385A
loc_0230385C:
	bl loc_023038A4	; 0230385C
	cmp r4,#0x1	; 02303860
	bne loc_02303868	; 02303862
	bl loc_023042B4	; 02303864
loc_02303868:
	add sp,#0x4	; 02303868
	pop {r4,r5}	; 0230386A
	pop {r3}	; 0230386C
	bx r3	; 0230386E
pool_02303870:
loc_02303870:
	.word 0x00001518	; 02303870
pool_02303874:
loc_02303874:
	.word 0x00000100	; 02303874
pool_02303878:
loc_02303878:
	.word 0x0000FFFF	; 02303878
pool_0230387C:
loc_0230387C:
	.word 0x0000092C	; 0230387C

; ===== function loc_02303880 =====
loc_02303880:
	bx pc	; 02303880
	.byte 0xC0, 0x46	; 02303884
.arm

; ===== function loc_02303884 =====
loc_02303884:
	ldr pc,[pool_02303888]	; 02303884
pool_02303888:
loc_02303888:
	.word loc_037FCBF0	; 02303888
.thumb

; ===== function loc_0230388C =====
loc_0230388C:
	bx pc	; 0230388C
	.byte 0xC0, 0x46	; 02303890
.arm

; ===== function loc_02303890 =====
loc_02303890:
	ldr pc,[pool_02303894]	; 02303890
pool_02303894:
loc_02303894:
	.word loc_037FCC04	; 02303894
.thumb

; ===== function loc_02303898 =====
loc_02303898:
	bx pc	; 02303898
	.byte 0xC0, 0x46	; 0230389C
.arm

; ===== function loc_0230389C =====
loc_0230389C:
	ldr pc,[pool_023038A0]	; 0230389C
pool_023038A0:
loc_023038A0:
	.word loc_037FCBF0	; 023038A0
.thumb

; ===== function loc_023038A4 =====
loc_023038A4:
	bx pc	; 023038A4
	.byte 0xC0, 0x46	; 023038A8
.arm

; ===== function loc_023038A8 =====
loc_023038A8:
	ldr pc,[pool_023038AC]	; 023038A8
pool_023038AC:
loc_023038AC:
	.word loc_037FCC04	; 023038AC
.thumb

; ===== function loc_023038B0 =====
loc_023038B0:
	push {r4,r5,r6,r7,lr}	; 023038B0
	sub sp,#0x4	; 023038B2
	add r3,r0,#0x0	; 023038B4
	add r0,r1,#0x0	; 023038B6
	add r6,r2,#0x0	; 023038B8
	mov r5,#0x0	; 023038BA
	add r4,r5,#0x0	; 023038BC
	mov r7,#0x1	; 023038BE
loc_023038C0:
	add r1,r7,#0x0	; 023038C0
	lsl r1,r4	; 023038C2
	add r2,r6,#0x0	; 023038C4
	and r2,r1	; 023038C6
	cmp r2,#0x0	; 023038C8
	beq loc_023038D2	; 023038CA
	add r1,r5,#0x1	; 023038CC
	lsl r1,r1,#0x10	; 023038CE
	lsr r5,r1,#0x10	; 023038D0
loc_023038D2:
	add r4,r4,#0x1	; 023038D2
	cmp r4,#0x10	; 023038D4
	blt loc_023038C0	; 023038D6
	add r3,#0x22	; 023038D8
	lsl r2,r3,#0x2	; 023038DA
	add r2,#0x60	; 023038DC
	mul r0,r5	; 023038DE
	ldr r1,[pool_0230392C]	; 023038E0
	add r0,r0,r1	; 023038E2
	add r4,r2,r0	; 023038E4
	ldr r0,[pool_02303930]	; 023038E6
	ldrh r1,[r0,#0x0]	; 023038E8
	ldr r0,[pool_02303934]	; 023038EA
	cmp r1,r0	; 023038EC
	bls loc_02303904	; 023038EE
	ldr r0,[pool_02303938]	; 023038F0
	sub r0,r0,r1	; 023038F2
	mov r1,#0x7f	; 023038F4
	mul r0,r1	; 023038F6
	mov r1,#0x14	; 023038F8
	bl loc_02303940	; 023038FA
	lsl r0,r0,#0x10	; 023038FE
	lsr r0,r0,#0x10	; 02303900
	b loc_02303916	; 02303902
loc_02303904:
	ldr r0,[pool_0230393C]	; 02303904
	sub r0,r0,r1	; 02303906
	mov r1,#0x7f	; 02303908
	mul r0,r1	; 0230390A
	mov r1,#0x14	; 0230390C
	bl loc_0230394C	; 0230390E
	lsl r0,r0,#0x10	; 02303912
	lsr r0,r0,#0x10	; 02303914
loc_02303916:
	mov r1,#0xa	; 02303916
	add r2,r0,#0x0	; 02303918
	mul r2,r1	; 0230391A
	cmp r2,r4	; 0230391C
	bcs loc_02303922	; 0230391E
	mov r0,#0x0	; 02303920
loc_02303922:
	add sp,#0x4	; 02303922
	pop {r4,r5,r6,r7}	; 02303924
	pop {r3}	; 02303926
	bx r3	; 02303928
	.byte 0xC0, 0x46	; 0230392C
pool_0230392C:
loc_0230392C:
	.word 0x00000388	; 0230392C
pool_02303930:
loc_02303930:
	.word REG_VCOUNT	; 02303930
pool_02303934:
loc_02303934:
	.word 0x00000104	; 02303934
pool_02303938:
loc_02303938:
	.word 0x00000209	; 02303938
pool_0230393C:
loc_0230393C:
	.word 0x00000102	; 0230393C

; ===== function loc_02303940 =====
loc_02303940:
	bx pc	; 02303940
	.byte 0xC0, 0x46	; 02303944
.arm

; ===== function loc_02303944 =====
loc_02303944:
	ldr pc,[pool_02303948]	; 02303944
pool_02303948:
loc_02303948:
	.word loc_03802514	; 02303948
.thumb

; ===== function loc_0230394C =====
loc_0230394C:
	bx pc	; 0230394C
	.byte 0xC0, 0x46	; 02303950
.arm

; ===== function loc_02303950 =====
loc_02303950:
	ldr pc,[pool_02303954]	; 02303950
pool_02303954:
loc_02303954:
	.word loc_03802514	; 02303954
.thumb

; ===== function loc_02303958 =====
loc_02303958:
	push {r0,r1,r2,r3}	; 02303958
	push {r4,r5,r6,r7,lr}	; 0230395A
	sub sp,#0x34	; 0230395C
	str r0,[sp,#0x0]	; 0230395E
	str r2,[sp,#0x4]	; 02303960
	add r5,r3,#0x0	; 02303962
	ldr r0,[sp,#0x58]	; 02303964
	str r0,[sp,#0x58]	; 02303966
	bl loc_023008B4	; 02303968
	ldr r1,[pool_02303ABC]	; 0230396C
	ldr r0,[r0,r1]	; 0230396E
	ldr r4,[r0,#0x0]	; 02303970
	cmp r5,#0x0	; 02303972
	bne loc_02303978	; 02303974
	b loc_02303AB2	; 02303976
loc_02303978:
	ldr r0,[pool_02303AC0]	; 02303978
	ldrh r0,[r4,r0]	; 0230397A
	cmp r5,r0	; 0230397C
	bls loc_02303982	; 0230397E
	b loc_02303AB2	; 02303980
loc_02303982:
	ldr r0,[pool_02303AC4]	; 02303982
	ldrh r1,[r4,r0]	; 02303984
	ldr r0,[sp,#0x0]	; 02303986
	cmp r0,r1	; 02303988
	bne loc_0230398E	; 0230398A
	b loc_02303AB2	; 0230398C
loc_0230398E:
	mov r0,#0x1	; 0230398E
	str r0,[sp,#0xc]	; 02303990
	add r1,r5,#0x0	; 02303992
	and r1,r0	; 02303994
	cmp r1,#0x0	; 02303996
	beq loc_0230399C	; 02303998
	b loc_02303AB2	; 0230399A
loc_0230399C:
	ldr r0,[pool_02303AC8]	; 0230399C
	add r1,r4,r0	; 0230399E
	ldr r0,[sp,#0x0]	; 023039A0
	lsl r0,r0,#0x4	; 023039A2
	add r0,r1,r0	; 023039A4
	str r0,[sp,#0x18]	; 023039A6
	ldr r0,[sp,#0xc]	; 023039A8
	str r0,[sp,#0x1c]	; 023039AA
	str r0,[sp,#0x20]	; 023039AC
	str r0,[sp,#0x24]	; 023039AE
	str r0,[sp,#0x28]	; 023039B0
	b loc_02303AAE	; 023039B2
loc_023039B4:
	ldr r6,[pool_02303ACC]	; 023039B4
	ldr r0,[sp,#0xc]	; 023039B6
	cmp r0,#0x1	; 023039B8
	bne loc_023039C4	; 023039BA
	mov r0,#0x0	; 023039BC
	str r0,[sp,#0xc]	; 023039BE
	add r1,sp,#0x4c	; 023039C0
	b loc_023039CE	; 023039C2
loc_023039C4:
	ldr r1,[sp,#0x4]	; 023039C4
	lsl r0,r1,#0	; 023039C6
	add r0,r0,#0x2	; 023039C8
	str r0,[sp,#0x4]	; 023039CA
	sub r5,r5,#0x2	; 023039CC
loc_023039CE:
	ldrh r2,[r1,#0x0]	; 023039CE
	add r1,r2,#0x0	; 023039D0
	mov r0,#0xff	; 023039D2
	and r1,r0	; 023039D4
	lsl r7,r1,#0x1	; 023039D6
	add r1,r2,#0x0	; 023039D8
	ldr r0,[pool_02303AD0]	; 023039DA
	and r1,r0	; 023039DC
	cmp r1,#0x0	; 023039DE
	beq loc_023039E8	; 023039E0
	ldr r0,[sp,#0x1c]	; 023039E2
	str r0,[sp,#0x8]	; 023039E4
	b loc_023039EC	; 023039E6
loc_023039E8:
	mov r0,#0x0	; 023039E8
	str r0,[sp,#0x8]	; 023039EA
loc_023039EC:
	add r1,r2,#0x0	; 023039EC
	ldr r0,[pool_02303AD4]	; 023039EE
	and r1,r0	; 023039F0
	cmp r1,#0x0	; 023039F2
	beq loc_023039FA	; 023039F4
	ldr r0,[sp,#0x20]	; 023039F6
	b loc_023039FC	; 023039F8
loc_023039FA:
	mov r0,#0x0	; 023039FA
loc_023039FC:
	ldr r1,[sp,#0x8]	; 023039FC
	cmp r1,#0x0	; 023039FE
	beq loc_02303A06	; 02303A00
	mov r3,#0x2	; 02303A02
	b loc_02303A08	; 02303A04
loc_02303A06:
	mov r3,#0x0	; 02303A06
loc_02303A08:
	cmp r0,#0x0	; 02303A08
	beq loc_02303A10	; 02303A0A
	mov r1,#0x2	; 02303A0C
	b loc_02303A12	; 02303A0E
loc_02303A10:
	mov r1,#0x0	; 02303A10
loc_02303A12:
	add r1,r7,r1	; 02303A12
	add r3,r1,r3	; 02303A14
	sub r5,r5,r3	; 02303A16
	cmp r5,#0x0	; 02303A18
	blt loc_02303AB2	; 02303A1A
	ldr r1,[pool_02303AD8]	; 02303A1C
	and r2,r1	; 02303A1E
	lsl r1,r2,#0x8	; 02303A20
	lsr r1,r1,#0x10	; 02303A22
	str r1,[sp,#0x14]	; 02303A24
	ldr r1,[sp,#0x4]	; 02303A26
	str r1,[sp,#0x10]	; 02303A28
	add r2,r1,r7	; 02303A2A
	add r1,r1,r3	; 02303A2C
	str r1,[sp,#0x4]	; 02303A2E
	cmp r0,#0x1	; 02303A30
	bne loc_02303A66	; 02303A32
	ldr r1,[sp,#0x14]	; 02303A34
	mov r0,#0x7	; 02303A36
	and r1,r0	; 02303A38
	lsl r1,r1,#0x1	; 02303A3A
	ldr r0,[sp,#0x18]	; 02303A3C
	add r3,r0,r1	; 02303A3E
	ldrh r6,[r2,#0x0]	; 02303A40
	add r2,r2,#0x2	; 02303A42
	ldrh r0,[r0,r1]	; 02303A44
	str r0,[sp,#0x30]	; 02303A46
	str r0,[sp,#0x2c]	; 02303A48
	ldr r1,[sp,#0x28]	; 02303A4A
	and r0,r1	; 02303A4C
	str r0,[sp,#0x2c]	; 02303A4E
	cmp r0,#0x0	; 02303A50
	beq loc_02303A5A	; 02303A52
	lsl r0,r6,#0x1	; 02303A54
	strh r0,[r3,#0x0]	; 02303A56
	b loc_02303A66	; 02303A58
loc_02303A5A:
	lsl r0,r6,#0x11	; 02303A5A
	lsr r6,r0,#0x10	; 02303A5C
	ldr r0,[sp,#0x30]	; 02303A5E
	cmp r0,r6	; 02303A60
	beq loc_02303AAE	; 02303A62
	strh r6,[r3,#0x0]	; 02303A64
loc_02303A66:
	ldr r0,[sp,#0x8]	; 02303A66
	cmp r0,#0x1	; 02303A68
	bne loc_02303A7C	; 02303A6A
	ldrh r0,[r2,#0x0]	; 02303A6C
	ldr r1,[pool_02303AC4]	; 02303A6E
	ldrh r1,[r4,r1]	; 02303A70
	ldr r2,[sp,#0x24]	; 02303A72
	lsl r2,r1	; 02303A74
	and r0,r2	; 02303A76
	cmp r0,#0x0	; 02303A78
	beq loc_02303AAE	; 02303A7A
loc_02303A7C:
	cmp r7,#0x0	; 02303A7C
	ble loc_02303AAE	; 02303A7E
	bl loc_02300404	; 02303A80
	mov r1,#0x82	; 02303A84
	strh r1,[r0,#0x0]	; 02303A86
	mov r1,#0x0	; 02303A88
	strh r1,[r0,#0x2]	; 02303A8A
	mov r1,#0x15	; 02303A8C
	strh r1,[r0,#0x4]	; 02303A8E
	ldr r1,[sp,#0x14]	; 02303A90
	strh r1,[r0,#0x6]	; 02303A92
	ldr r1,[sp,#0x58]	; 02303A94
	str r1,[r0,#0x8]	; 02303A96
	ldr r1,[sp,#0x10]	; 02303A98
	str r1,[r0,#0xc]	; 02303A9A
	strh r7,[r0,#0x10]	; 02303A9C
	ldr r1,[sp,#0x0]	; 02303A9E
	strh r1,[r0,#0x12]	; 02303AA0
	ldr r1,[pool_02303AC4]	; 02303AA2
	ldrh r1,[r4,r1]	; 02303AA4
	strh r1,[r0,#0x20]	; 02303AA6
	strh r6,[r0,#0x1a]	; 02303AA8
	bl loc_02300414	; 02303AAA
loc_02303AAE:
	cmp r5,#0x0	; 02303AAE
	bgt loc_023039B4	; 02303AB0
loc_02303AB2:
	add sp,#0x34	; 02303AB2
	pop {r4,r5,r6,r7}	; 02303AB4
	pop {r3}	; 02303AB6
	add sp,#0x10	; 02303AB8
	bx r3	; 02303ABA
pool_02303ABC:
loc_02303ABC:
	.word 0x00001518	; 02303ABC
pool_02303AC0:
loc_02303AC0:
	.word 0x00000190	; 02303AC0
pool_02303AC4:
loc_02303AC4:
	.word 0x00000184	; 02303AC4
pool_02303AC8:
loc_02303AC8:
	.word 0x000001F4	; 02303AC8
pool_02303ACC:
loc_02303ACC:
	.word 0x0000FFFF	; 02303ACC
pool_02303AD0:
loc_02303AD0:
	.word 0x00001000	; 02303AD0
pool_02303AD4:
loc_02303AD4:
	.word 0x00000800	; 02303AD4
pool_02303AD8:
loc_02303AD8:
	.word 0x00000F00	; 02303AD8

; ===== function loc_02303ADC =====
loc_02303ADC:
	push {r4,r5,r6,r7,lr}	; 02303ADC
	sub sp,#0x2c	; 02303ADE
	str r0,[sp,#0x0]	; 02303AE0
	str r1,[sp,#0x4]	; 02303AE2
	bl loc_023008B4	; 02303AE4
	ldr r1,[pool_02303CCC]	; 02303AE8
	ldr r0,[r0,r1]	; 02303AEA
	ldr r5,[r0,#0x0]	; 02303AEC
	ldr r0,[pool_02303CD0]	; 02303AEE
	add r0,r5,r0	; 02303AF0
	str r0,[sp,#0x8]	; 02303AF2
	mov r0,#0x0	; 02303AF4
	str r0,[sp,#0x10]	; 02303AF6
	ldrh r0,[r5,#0x0]	; 02303AF8
	cmp r0,#0x9	; 02303AFA
	bne loc_02303B02	; 02303AFC
	mov r4,#0x1	; 02303AFE
	b loc_02303B0E	; 02303B00
loc_02303B02:
	cmp r0,#0xa	; 02303B02
	bne loc_02303B0A	; 02303B04
	ldr r4,[sp,#0x10]	; 02303B06
	b loc_02303B0E	; 02303B08
loc_02303B0A:
	ldr r0,[sp,#0x10]	; 02303B0A
	b loc_02303CC2	; 02303B0C
loc_02303B0E:
	ldr r0,[pool_02303CD4]	; 02303B0E
	add r0,r5,r0	; 02303B10
	bl loc_02303CF4	; 02303B12
	ldr r0,[pool_02303CD8]	; 02303B16
	ldr r0,[r5,r0]	; 02303B18
	cmp r0,#0x0	; 02303B1A
	bne loc_02303B2A	; 02303B1C
	ldr r0,[pool_02303CD4]	; 02303B1E
	add r0,r5,r0	; 02303B20
	bl loc_02303D04	; 02303B22
	mov r0,#0x0	; 02303B26
	b loc_02303CC2	; 02303B28
loc_02303B2A:
	cmp r4,#0x1	; 02303B2A
	bne loc_02303B36	; 02303B2C
	add r0,r5,#0x0	; 02303B2E
	add r0,#0x86	; 02303B30
	ldrh r1,[r0,#0x0]	; 02303B32
	b loc_02303B38	; 02303B34
loc_02303B36:
	mov r1,#0x1	; 02303B36
loc_02303B38:
	mov r0,#0x0	; 02303B38
	str r0,[sp,#0xc]	; 02303B3A
	lsl r0,r1,#0x10	; 02303B3C
	lsr r0,r0,#0x10	; 02303B3E
	str r0,[sp,#0x1c]	; 02303B40
	ldr r0,[sp,#0xc]	; 02303B42
	str r0,[sp,#0x28]	; 02303B44
	str r0,[sp,#0x24]	; 02303B46
loc_02303B48:
	ldr r0,[sp,#0xc]	; 02303B48
	lsl r0,r0,#0x2	; 02303B4A
	str r0,[sp,#0x20]	; 02303B4C
	ldr r0,[pool_02303CDC]	; 02303B4E
	add r1,r5,r0	; 02303B50
	ldr r0,[sp,#0x20]	; 02303B52
	add r7,r1,r0	; 02303B54
	ldr r0,[pool_02303CE0]	; 02303B56
	str r0,[sp,#0x14]	; 02303B58
	str r0,[sp,#0x18]	; 02303B5A
	ldr r0,[sp,#0x20]	; 02303B5C
	ldrh r6,[r1,r0]	; 02303B5E
	b loc_02303C70	; 02303B60
loc_02303B62:
	add r1,r6,#0x0	; 02303B62
	mov r0,#0x18	; 02303B64
	mul r1,r0	; 02303B66
	ldr r0,[sp,#0x8]	; 02303B68
	add r4,r0,r1	; 02303B6A
	ldrh r0,[r4,#0x4]	; 02303B6C
	add r2,r0,#0x0	; 02303B6E
	ldr r1,[sp,#0x1c]	; 02303B70
	and r2,r1	; 02303B72
	cmp r2,#0x0	; 02303B74
	beq loc_02303BE4	; 02303B76
	ldr r1,[sp,#0x0]	; 02303B78
	cmp r1,#0x0	; 02303B7A
	bne loc_02303B86	; 02303B7C
	ldr r1,[sp,#0x4]	; 02303B7E
	and r1,r0	; 02303B80
	cmp r1,#0x0	; 02303B82
	beq loc_02303BE4	; 02303B84
loc_02303B86:
	ldrh r1,[r4,#0x2]	; 02303B86
	mov r0,#0x8	; 02303B88
	and r1,r0	; 02303B8A
	cmp r1,#0x0	; 02303B8C
	bne loc_02303B96	; 02303B8E
	ldrh r0,[r4,#0xa]	; 02303B90
	cmp r0,#0x0	; 02303B92
	beq loc_02303BE4	; 02303B94
loc_02303B96:
	mov r0,#0x1	; 02303B96
	str r0,[sp,#0x10]	; 02303B98
	ldrh r0,[r4,#0xa]	; 02303B9A
	cmp r0,#0x0	; 02303B9C
	beq loc_02303BAA	; 02303B9E
	add r1,r4,#0x0	; 02303BA0
	add r1,#0xa	; 02303BA2
	ldrh r0,[r1,#0x0]	; 02303BA4
	sub r0,r0,#0x1	; 02303BA6
	strh r0,[r1,#0x0]	; 02303BA8
loc_02303BAA:
	ldr r0,[sp,#0x0]	; 02303BAA
	cmp r0,#0x0	; 02303BAC
	bne loc_02303BBA	; 02303BAE
	add r2,r4,#0x4	; 02303BB0
	ldrh r1,[r2,#0x0]	; 02303BB2
	ldr r0,[sp,#0x4]	; 02303BB4
	and r1,r0	; 02303BB6
	strh r1,[r2,#0x0]	; 02303BB8
loc_02303BBA:
	ldrh r1,[r4,#0x0]	; 02303BBA
	ldr r0,[pool_02303CE0]	; 02303BBC
	cmp r1,r0	; 02303BBE
	bne loc_02303BC4	; 02303BC0
	strh r0,[r7,#0x2]	; 02303BC2
loc_02303BC4:
	ldrh r0,[r4,#0x0]	; 02303BC4
	strh r0,[r7,#0x0]	; 02303BC6
	ldr r0,[pool_02303CE0]	; 02303BC8
	strh r0,[r4,#0x0]	; 02303BCA
	ldr r1,[sp,#0x14]	; 02303BCC
	cmp r1,r0	; 02303BCE
	bne loc_02303BD6	; 02303BD0
	str r6,[sp,#0x18]	; 02303BD2
	b loc_02303BE0	; 02303BD4
loc_02303BD6:
	mov r0,#0x18	; 02303BD6
	mul r1,r0	; 02303BD8
	str r1,[sp,#0x14]	; 02303BDA
	ldr r0,[sp,#0x8]	; 02303BDC
	strh r6,[r0,r1]	; 02303BDE
loc_02303BE0:
	str r6,[sp,#0x14]	; 02303BE0
	b loc_02303C6E	; 02303BE2
loc_02303BE4:
	bl loc_02300404	; 02303BE4
	add r2,r0,#0x0	; 02303BE8
	mov r0,#0x81	; 02303BEA
	strh r0,[r2,#0x0]	; 02303BEC
	ldrh r1,[r4,#0x4]	; 02303BEE
	add r3,r1,#0x0	; 02303BF0
	ldr r0,[sp,#0x1c]	; 02303BF2
	and r3,r0	; 02303BF4
	cmp r3,#0x0	; 02303BF6
	bne loc_02303C02	; 02303BF8
	ldr r0,[sp,#0x24]	; 02303BFA
	strh r0,[r2,#0x2]	; 02303BFC
	strh r0,[r4,#0x4]	; 02303BFE
	b loc_02303C1A	; 02303C00
loc_02303C02:
	ldr r0,[sp,#0x0]	; 02303C02
	cmp r0,#0x0	; 02303C04
	bne loc_02303C10	; 02303C06
	ldr r0,[sp,#0x4]	; 02303C08
	and r0,r1	; 02303C0A
	cmp r0,#0x0	; 02303C0C
	beq loc_02303C16	; 02303C0E
loc_02303C10:
	mov r0,#0xf	; 02303C10
	strh r0,[r2,#0x2]	; 02303C12
	b loc_02303C1A	; 02303C14
loc_02303C16:
	ldr r0,[sp,#0x28]	; 02303C16
	strh r0,[r2,#0x2]	; 02303C18
loc_02303C1A:
	mov r0,#0x14	; 02303C1A
	strh r0,[r2,#0x8]	; 02303C1C
	ldrh r0,[r4,#0x2]	; 02303C1E
	strh r0,[r2,#0xa]	; 02303C20
	ldrh r0,[r4,#0x4]	; 02303C22
	strh r0,[r2,#0xc]	; 02303C24
	ldrh r0,[r4,#0x6]	; 02303C26
	strh r0,[r2,#0xe]	; 02303C28
	ldr r0,[r4,#0xc]	; 02303C2A
	str r0,[r2,#0x10]	; 02303C2C
	ldr r0,[r4,#0x10]	; 02303C2E
	str r0,[r2,#0x14]	; 02303C30
	ldr r0,[r4,#0x14]	; 02303C32
	str r0,[r2,#0x18]	; 02303C34
	ldrh r0,[r4,#0x8]	; 02303C36
	strh r0,[r2,#0x1c]	; 02303C38
	add r0,r2,#0x0	; 02303C3A
	bl loc_02300414	; 02303C3C
	ldrh r1,[r4,#0x0]	; 02303C40
	ldr r0,[pool_02303CE0]	; 02303C42
	cmp r1,r0	; 02303C44
	bne loc_02303C4A	; 02303C46
	strh r0,[r7,#0x2]	; 02303C48
loc_02303C4A:
	ldrh r0,[r4,#0x0]	; 02303C4A
	strh r0,[r7,#0x0]	; 02303C4C
	ldr r0,[pool_02303CE0]	; 02303C4E
	strh r0,[r4,#0x0]	; 02303C50
	ldr r0,[pool_02303CE4]	; 02303C52
	ldrh r1,[r5,r0]	; 02303C54
	ldr r0,[pool_02303CE0]	; 02303C56
	cmp r1,r0	; 02303C58
	bne loc_02303C62	; 02303C5A
	ldr r0,[pool_02303CE8]	; 02303C5C
	strh r6,[r5,r0]	; 02303C5E
	b loc_02303C6A	; 02303C60
loc_02303C62:
	mov r0,#0x18	; 02303C62
	mul r1,r0	; 02303C64
	ldr r0,[sp,#0x8]	; 02303C66
	strh r6,[r0,r1]	; 02303C68
loc_02303C6A:
	ldr r0,[pool_02303CE4]	; 02303C6A
	strh r6,[r5,r0]	; 02303C6C
loc_02303C6E:
	ldrh r6,[r7,#0x0]	; 02303C6E
loc_02303C70:
	ldr r0,[pool_02303CE0]	; 02303C70
	cmp r6,r0	; 02303C72
	beq loc_02303C78	; 02303C74
	b loc_02303B62	; 02303C76
loc_02303C78:
	ldr r1,[sp,#0x14]	; 02303C78
	cmp r1,r0	; 02303C7A
	beq loc_02303CA6	; 02303C7C
	ldr r0,[sp,#0x20]	; 02303C7E
	add r0,r5,r0	; 02303C80
	ldr r1,[pool_02303CEC]	; 02303C82
	ldrh r3,[r0,r1]	; 02303C84
	ldr r2,[sp,#0x14]	; 02303C86
	mov r1,#0x18	; 02303C88
	mul r2,r1	; 02303C8A
	ldr r1,[sp,#0x8]	; 02303C8C
	strh r3,[r1,r2]	; 02303C8E
	ldr r1,[pool_02303CF0]	; 02303C90
	ldrh r2,[r0,r1]	; 02303C92
	ldr r1,[pool_02303CE0]	; 02303C94
	cmp r2,r1	; 02303C96
	bne loc_02303CA0	; 02303C98
	ldr r2,[sp,#0x14]	; 02303C9A
	ldr r1,[pool_02303CF0]	; 02303C9C
	strh r2,[r0,r1]	; 02303C9E
loc_02303CA0:
	ldr r2,[sp,#0x18]	; 02303CA0
	ldr r1,[pool_02303CEC]	; 02303CA2
	strh r2,[r0,r1]	; 02303CA4
loc_02303CA6:
	ldr r0,[sp,#0xc]	; 02303CA6
	add r0,r0,#0x1	; 02303CA8
	str r0,[sp,#0xc]	; 02303CAA
	cmp r0,#0x4	; 02303CAC
	bge loc_02303CB2	; 02303CAE
	b loc_02303B48	; 02303CB0
loc_02303CB2:
	mov r1,#0x0	; 02303CB2
	ldr r0,[pool_02303CD8]	; 02303CB4
	str r1,[r5,r0]	; 02303CB6
	ldr r0,[pool_02303CD4]	; 02303CB8
	add r0,r5,r0	; 02303CBA
	bl loc_02303D04	; 02303CBC
	ldr r0,[sp,#0x10]	; 02303CC0
loc_02303CC2:
	add sp,#0x2c	; 02303CC2
	pop {r4,r5,r6,r7}	; 02303CC4
	pop {r3}	; 02303CC6
	bx r3	; 02303CC8
	.byte 0xC0, 0x46	; 02303CCC
pool_02303CCC:
loc_02303CCC:
	.word 0x00001518	; 02303CCC
pool_02303CD0:
loc_02303CD0:
	.word 0x000002F4	; 02303CD0
pool_02303CD4:
loc_02303CD4:
	.word 0x00000918	; 02303CD4
pool_02303CD8:
loc_02303CD8:
	.word 0x0000092C	; 02303CD8
pool_02303CDC:
loc_02303CDC:
	.word 0x000008F8	; 02303CDC
pool_02303CE0:
loc_02303CE0:
	.word 0x0000FFFF	; 02303CE0
pool_02303CE4:
loc_02303CE4:
	.word 0x000008F6	; 02303CE4
pool_02303CE8:
loc_02303CE8:
	.word 0x000008F4	; 02303CE8
pool_02303CEC:
loc_02303CEC:
	.word 0x00000908	; 02303CEC
pool_02303CF0:
loc_02303CF0:
	.word 0x0000090A	; 02303CF0

; ===== function loc_02303CF4 =====
loc_02303CF4:
	bx pc	; 02303CF4
	.byte 0xC0, 0x46	; 02303CF8
.arm

; ===== function loc_02303CF8 =====
loc_02303CF8:
	ldr r12,[pool_02303D00]	; 02303CF8
	bx r12	; 02303CFC
pool_02303D00:
loc_02303D00:
	.word P2_Entry_037FBF3C + 1	; 02303D00
.thumb

; ===== function loc_02303D04 =====
loc_02303D04:
	bx pc	; 02303D04
	.byte 0xC0, 0x46	; 02303D08
.arm

; ===== function loc_02303D08 =====
loc_02303D08:
	ldr r12,[pool_02303D10]	; 02303D08
	bx r12	; 02303D0C
pool_02303D10:
loc_02303D10:
	.word P2_Entry_037FBEF4 + 1	; 02303D10
.thumb

; ===== function loc_02303D14 =====
loc_02303D14:
	push {r4,r5,r6,r7,lr}	; 02303D14
	sub sp,#0xc	; 02303D16
	add r4,r0,#0x0	; 02303D18
	add r7,r1,#0x0	; 02303D1A
	str r2,[sp,#0x0]	; 02303D1C
	str r3,[sp,#0x4]	; 02303D1E
	bl loc_023008B4	; 02303D20
	ldr r1,[pool_02303DE8]	; 02303D24
	ldr r0,[r0,r1]	; 02303D26
	ldr r5,[r0,#0x0]	; 02303D28
	ldr r0,[pool_02303DEC]	; 02303D2A
	add r6,r5,r0	; 02303D2C
	ldr r0,[pool_02303DF0]	; 02303D2E
	add r1,r5,r0	; 02303D30
	lsl r0,r4,#0x2	; 02303D32
	add r4,r1,r0	; 02303D34
	add r0,sp,#0x10	; 02303D36
	ldrh r0,[r0,#0x10]	; 02303D38
	cmp r0,#0x0	; 02303D3A
	bne loc_02303D42	; 02303D3C
	mov r0,#0x6	; 02303D3E
	b loc_02303DE0	; 02303D40
loc_02303D42:
	mov r0,#0x8	; 02303D42
	add r1,r7,#0x0	; 02303D44
	and r1,r0	; 02303D46
	cmp r1,#0x0	; 02303D48
	beq loc_02303D50	; 02303D4A
	mov r1,#0x2	; 02303D4C
	b loc_02303D52	; 02303D4E
loc_02303D50:
	mov r1,#0x0	; 02303D50
loc_02303D52:
	add r0,sp,#0x10	; 02303D52
	ldrh r0,[r0,#0x10]	; 02303D54
	add r1,r0,r1	; 02303D56
	ldr r0,[pool_02303DF4]	; 02303D58
	ldrh r0,[r5,r0]	; 02303D5A
	cmp r1,r0	; 02303D5C
	ble loc_02303D64	; 02303D5E
	mov r0,#0x6	; 02303D60
	b loc_02303DE0	; 02303D62
loc_02303D64:
	ldr r0,[pool_02303DF8]	; 02303D64
	add r0,r5,r0	; 02303D66
	bl loc_02303CF4	; 02303D68
	ldr r0,[pool_02303DFC]	; 02303D6C
	add r2,r5,r0	; 02303D6E
	ldrh r0,[r2,#0x0]	; 02303D70
	ldr r1,[pool_02303E00]	; 02303D72
	cmp r0,r1	; 02303D74
	bne loc_02303D84	; 02303D76
	ldr r0,[pool_02303DF8]	; 02303D78
	add r0,r5,r0	; 02303D7A
	bl loc_02303D04	; 02303D7C
	mov r0,#0xa	; 02303D80
	b loc_02303DE0	; 02303D82
loc_02303D84:
	mov r1,#0x18	; 02303D84
	add r3,r0,#0x0	; 02303D86
	mul r3,r1	; 02303D88
	add r1,r6,r3	; 02303D8A
	ldrh r3,[r6,r3]	; 02303D8C
	strh r3,[r2,#0x0]	; 02303D8E
	ldr r2,[pool_02303E04]	; 02303D90
	add r3,r5,r2	; 02303D92
	ldrh r2,[r3,#0x0]	; 02303D94
	cmp r2,r0	; 02303D96
	bne loc_02303D9E	; 02303D98
	ldr r2,[pool_02303E00]	; 02303D9A
	strh r2,[r3,#0x0]	; 02303D9C
loc_02303D9E:
	strh r7,[r1,#0x2]	; 02303D9E
	ldr r2,[sp,#0x0]	; 02303DA0
	strh r2,[r1,#0x4]	; 02303DA2
	ldr r2,[sp,#0x4]	; 02303DA4
	str r2,[r1,#0xc]	; 02303DA6
	add r2,sp,#0x10	; 02303DA8
	ldrh r2,[r2,#0x10]	; 02303DAA
	strh r2,[r1,#0x6]	; 02303DAC
	ldr r2,[sp,#0x24]	; 02303DAE
	str r2,[r1,#0x10]	; 02303DB0
	ldr r2,[sp,#0x28]	; 02303DB2
	str r2,[r1,#0x14]	; 02303DB4
	ldr r2,[pool_02303E00]	; 02303DB6
	strh r2,[r1,#0x0]	; 02303DB8
	strh r2,[r1,#0x8]	; 02303DBA
	add r3,r5,#0x0	; 02303DBC
	add r3,#0x98	; 02303DBE
	ldrh r3,[r3,#0x0]	; 02303DC0
	strh r3,[r1,#0xa]	; 02303DC2
	ldrh r3,[r4,#0x2]	; 02303DC4
	cmp r3,r2	; 02303DC6
	bne loc_02303DCE	; 02303DC8
	strh r0,[r4,#0x0]	; 02303DCA
	b loc_02303DD4	; 02303DCC
loc_02303DCE:
	mov r1,#0x18	; 02303DCE
	mul r3,r1	; 02303DD0
	strh r0,[r6,r3]	; 02303DD2
loc_02303DD4:
	strh r0,[r4,#0x2]	; 02303DD4
	ldr r0,[pool_02303DF8]	; 02303DD6
	add r0,r5,r0	; 02303DD8
	bl loc_02303D04	; 02303DDA
	mov r0,#0x2	; 02303DDE
loc_02303DE0:
	add sp,#0xc	; 02303DE0
	pop {r4,r5,r6,r7}	; 02303DE2
	pop {r3}	; 02303DE4
	bx r3	; 02303DE6
pool_02303DE8:
loc_02303DE8:
	.word 0x00001518	; 02303DE8
pool_02303DEC:
loc_02303DEC:
	.word 0x000002F4	; 02303DEC
pool_02303DF0:
loc_02303DF0:
	.word 0x00000908	; 02303DF0
pool_02303DF4:
loc_02303DF4:
	.word 0x0000018E	; 02303DF4
pool_02303DF8:
loc_02303DF8:
	.word 0x00000918	; 02303DF8
pool_02303DFC:
loc_02303DFC:
	.word 0x000008F4	; 02303DFC
pool_02303E00:
loc_02303E00:
	.word 0x0000FFFF	; 02303E00
pool_02303E04:
loc_02303E04:
	.word 0x000008F6	; 02303E04

; ===== function loc_02303E08 =====
loc_02303E08:
	push {r4,r5,r6,r7,lr}	; 02303E08
	sub sp,#0x6c	; 02303E0A
	add r4,r0,#0x0	; 02303E0C
	add r7,r1,#0x0	; 02303E0E
	str r2,[sp,#0x0]	; 02303E10
	str r3,[sp,#0x4]	; 02303E12
	ldr r0,[sp,#0x80]	; 02303E14
	str r0,[sp,#0x80]	; 02303E16
	ldr r0,[sp,#0x84]	; 02303E18
	str r0,[sp,#0x84]	; 02303E1A
	bl loc_023008B4	; 02303E1C
	str r0,[sp,#0x10]	; 02303E20
	ldr r1,[pool_0230415C]	; 02303E22
	ldr r0,[r0,r1]	; 02303E24
	ldr r6,[r0,#0x0]	; 02303E26
	ldrh r0,[r6,#0x0]	; 02303E28
	cmp r0,#0x9	; 02303E2A
	bne loc_02303E34	; 02303E2C
	mov r0,#0x1	; 02303E2E
	str r0,[sp,#0x20]	; 02303E30
	b loc_02303E42	; 02303E32
loc_02303E34:
	cmp r0,#0xa	; 02303E34
	bne loc_02303E3E	; 02303E36
	mov r0,#0x0	; 02303E38
	str r0,[sp,#0x20]	; 02303E3A
	b loc_02303E42	; 02303E3C
loc_02303E3E:
	mov r0,#0x1	; 02303E3E
	b loc_02304152	; 02303E40
loc_02303E42:
	mov r1,#0x0	; 02303E42
	str r1,[sp,#0x24]	; 02303E44
	ldr r0,[sp,#0x0]	; 02303E46
	strh r1,[r0,#0x0]	; 02303E48
	ldr r0,[sp,#0x80]	; 02303E4A
	strh r1,[r0,#0x0]	; 02303E4C
	ldr r0,[sp,#0x84]	; 02303E4E
	strh r1,[r0,#0x0]	; 02303E50
	lsl r0,r1,#0	; 02303E52
	str r0,[sp,#0x28]	; 02303E54
	ldr r0,[sp,#0x20]	; 02303E56
	cmp r0,#0x1	; 02303E58
	bne loc_02303E64	; 02303E5A
	add r0,r6,#0x0	; 02303E5C
	add r0,#0x86	; 02303E5E
	ldrh r0,[r0,#0x0]	; 02303E60
	b loc_02303E66	; 02303E62
loc_02303E64:
	mov r0,#0x1	; 02303E64
loc_02303E66:
	lsl r0,r0,#0x10	; 02303E66
	lsr r0,r0,#0x10	; 02303E68
	str r0,[sp,#0x18]	; 02303E6A
	cmp r7,#0x0	; 02303E6C
	bge loc_02303E74	; 02303E6E
	mov r0,#0x1	; 02303E70
	b loc_02304152	; 02303E72
loc_02303E74:
	mov r0,#0x0	; 02303E74
	str r0,[sp,#0x14]	; 02303E76
	mov r0,#0x1	; 02303E78
	str r0,[sp,#0x1c]	; 02303E7A
	ldr r0,[pool_02304160]	; 02303E7C
	add r0,r6,r0	; 02303E7E
	bl loc_02303CF4	; 02303E80
	ldr r0,[pool_02304164]	; 02303E84
	add r1,r6,r0	; 02303E86
	ldr r0,[r1,#0x0]	; 02303E88
	cmp r0,#0x1	; 02303E8A
	bne loc_02303E9A	; 02303E8C
	ldr r0,[pool_02304160]	; 02303E8E
	add r0,r6,r0	; 02303E90
	bl loc_02303D04	; 02303E92
	mov r0,#0x1	; 02303E96
	b loc_02304152	; 02303E98
loc_02303E9A:
	mov r0,#0x1	; 02303E9A
	str r0,[r1,#0x0]	; 02303E9C
	ldr r0,[pool_02304168]	; 02303E9E
	add r0,r6,r0	; 02303EA0
	str r0,[sp,#0x2c]	; 02303EA2
	mov r0,#0x0	; 02303EA4
	str r0,[sp,#0x30]	; 02303EA6
	ldr r0,[sp,#0x18]	; 02303EA8
	and r0,r4	; 02303EAA
	mvn r0,r0	; 02303EAC
	str r0,[sp,#0x48]	; 02303EAE
	ldr r0,[sp,#0x30]	; 02303EB0
	str r0,[sp,#0x50]	; 02303EB2
	str r0,[sp,#0x54]	; 02303EB4
	str r0,[sp,#0x58]	; 02303EB6
	str r0,[sp,#0x5c]	; 02303EB8
	str r0,[sp,#0x60]	; 02303EBA
	str r0,[sp,#0x64]	; 02303EBC
	str r0,[sp,#0x68]	; 02303EBE
	b loc_02304130	; 02303EC0
loc_02303EC2:
	ldr r0,[sp,#0x30]	; 02303EC2
	lsl r1,r0,#0x2	; 02303EC4
	ldr r0,[pool_0230416C]	; 02303EC6
	add r0,r6,r0	; 02303EC8
	add r2,r0,r1	; 02303ECA
	str r2,[sp,#0x34]	; 02303ECC
	ldr r2,[pool_02304170]	; 02303ECE
	add r2,r6,r2	; 02303ED0
	add r2,r2,r1	; 02303ED2
	str r2,[sp,#0x38]	; 02303ED4
	ldr r2,[sp,#0x34]	; 02303ED6
	str r2,[sp,#0x3c]	; 02303ED8
	ldr r2,[pool_02304174]	; 02303EDA
	str r2,[sp,#0x40]	; 02303EDC
	ldrh r5,[r0,r1]	; 02303EDE
	b loc_0230411A	; 02303EE0
loc_02303EE2:
	add r1,r5,#0x0	; 02303EE2
	mov r0,#0x18	; 02303EE4
	mul r1,r0	; 02303EE6
	ldr r0,[sp,#0x2c]	; 02303EE8
	add r4,r0,r1	; 02303EEA
	ldrh r1,[r4,#0x2]	; 02303EEC
	mov r0,#0x1	; 02303EEE
	lsl r0,r1	; 02303EF0
	lsl r0,r0,#0x10	; 02303EF2
	lsr r0,r0,#0x10	; 02303EF4
	str r0,[sp,#0x4c]	; 02303EF6
	ldr r2,[sp,#0x14]	; 02303EF8
	and r2,r0	; 02303EFA
	lsl r0,r2,#0x10	; 02303EFC
	lsr r0,r0,#0x10	; 02303EFE
	cmp r0,#0x0	; 02303F00
	beq loc_02303F06	; 02303F02
	b loc_02304106	; 02303F04
loc_02303F06:
	ldr r2,[sp,#0x14]	; 02303F06
	ldr r0,[sp,#0x4c]	; 02303F08
	orr r2,r0	; 02303F0A
	str r2,[sp,#0x14]	; 02303F0C
	ldrh r0,[r4,#0x4]	; 02303F0E
	add r3,r0,#0x0	; 02303F10
	ldr r2,[sp,#0x18]	; 02303F12
	and r3,r2	; 02303F14
	lsl r2,r3,#0x10	; 02303F16
	lsr r2,r2,#0x10	; 02303F18
	str r2,[sp,#0x44]	; 02303F1A
	ldr r2,[sp,#0x20]	; 02303F1C
	cmp r2,#0x0	; 02303F1E
	beq loc_02303F32	; 02303F20
	ldr r3,[sp,#0x44]	; 02303F22
	ldr r2,[sp,#0x48]	; 02303F24
	and r3,r2	; 02303F26
	mov r2,#0x1	; 02303F28
	bic r3,r2	; 02303F2A
	cmp r3,#0x0	; 02303F2C
	beq loc_02303F32	; 02303F2E
	b loc_02304106	; 02303F30
loc_02303F32:
	mov r2,#0x8	; 02303F32
	and r1,r2	; 02303F34
	cmp r1,#0x0	; 02303F36
	beq loc_02303F40	; 02303F38
	mov r1,#0x1	; 02303F3A
	str r1,[sp,#0xc]	; 02303F3C
	b loc_02303F44	; 02303F3E
loc_02303F40:
	ldr r1,[sp,#0x50]	; 02303F40
	str r1,[sp,#0xc]	; 02303F42
loc_02303F44:
	ldr r1,[sp,#0x20]	; 02303F44
	cmp r1,#0x0	; 02303F46
	beq loc_02303F5A	; 02303F48
	mov r1,#0x1	; 02303F4A
	orr r0,r1	; 02303F4C
	ldr r1,[pool_02304174]	; 02303F4E
	cmp r0,r1	; 02303F50
	beq loc_02303F5A	; 02303F52
	mov r0,#0x1	; 02303F54
	str r0,[sp,#0x8]	; 02303F56
	b loc_02303F5E	; 02303F58
loc_02303F5A:
	ldr r0,[sp,#0x54]	; 02303F5A
	str r0,[sp,#0x8]	; 02303F5C
loc_02303F5E:
	ldrh r1,[r4,#0x6]	; 02303F5E
	mov r0,#0x1	; 02303F60
	and r1,r0	; 02303F62
	cmp r1,#0x1	; 02303F64
	bne loc_02303F70	; 02303F66
	add r1,r4,#0x6	; 02303F68
	ldrh r0,[r1,#0x0]	; 02303F6A
	add r0,r0,#0x1	; 02303F6C
	strh r0,[r1,#0x0]	; 02303F6E
loc_02303F70:
	ldr r0,[sp,#0xc]	; 02303F70
	cmp r0,#0x0	; 02303F72
	beq loc_02303F7A	; 02303F74
	mov r3,#0x2	; 02303F76
	b loc_02303F7C	; 02303F78
loc_02303F7A:
	ldr r3,[sp,#0x58]	; 02303F7A
loc_02303F7C:
	ldr r0,[sp,#0x1c]	; 02303F7C
	cmp r0,#0x0	; 02303F7E
	beq loc_02303F86	; 02303F80
	ldr r1,[sp,#0x5c]	; 02303F82
	b loc_02303F88	; 02303F84
loc_02303F86:
	mov r1,#0x2	; 02303F86
loc_02303F88:
	ldr r0,[sp,#0x8]	; 02303F88
	cmp r0,#0x0	; 02303F8A
	beq loc_02303F92	; 02303F8C
	mov r2,#0x2	; 02303F8E
	b loc_02303F94	; 02303F90
loc_02303F92:
	ldr r2,[sp,#0x60]	; 02303F92
loc_02303F94:
	ldrh r0,[r4,#0x6]	; 02303F94
	add r0,r0,r1	; 02303F96
	add r0,r0,r3	; 02303F98
	add r0,r2,r0	; 02303F9A
	cmp r0,r7	; 02303F9C
	ble loc_02303FA2	; 02303F9E
	b loc_023040EC	; 02303FA0
loc_02303FA2:
	ldr r0,[sp,#0x1c]	; 02303FA2
	cmp r0,#0x0	; 02303FA4
	bne loc_02303FC0	; 02303FA6
	ldr r0,[sp,#0x4]	; 02303FA8
	str r0,[sp,#0x0]	; 02303FAA
	ldr r1,[sp,#0x64]	; 02303FAC
	strh r1,[r0,#0x0]	; 02303FAE
	add r0,r0,#0x2	; 02303FB0
	str r0,[sp,#0x4]	; 02303FB2
	ldr r0,[sp,#0x28]	; 02303FB4
	add r0,r0,#0x2	; 02303FB6
	lsl r0,r0,#0x10	; 02303FB8
	lsr r0,r0,#0x10	; 02303FBA
	str r0,[sp,#0x28]	; 02303FBC
	sub r7,r7,#0x2	; 02303FBE
loc_02303FC0:
	ldr r0,[sp,#0x0]	; 02303FC0
	ldrh r0,[r0,#0x0]	; 02303FC2
	ldrh r1,[r4,#0x2]	; 02303FC4
	lsl r2,r1,#0x8	; 02303FC6
	ldr r1,[pool_02304178]	; 02303FC8
	and r2,r1	; 02303FCA
	orr r0,r2	; 02303FCC
	ldr r1,[sp,#0x0]	; 02303FCE
	strh r0,[r1,#0x0]	; 02303FD0
	lsl r0,r1,#0	; 02303FD2
	ldrh r0,[r0,#0x0]	; 02303FD4
	ldrh r1,[r4,#0x6]	; 02303FD6
	lsr r2,r1,#0x1	; 02303FD8
	mov r1,#0xff	; 02303FDA
	and r2,r1	; 02303FDC
	orr r0,r2	; 02303FDE
	ldr r1,[sp,#0x0]	; 02303FE0
	strh r0,[r1,#0x0]	; 02303FE2
	ldr r1,[sp,#0x10]	; 02303FE4
	ldr r0,[pool_0230417C]	; 02303FE6
	ldr r0,[r1,r0]	; 02303FE8
	ldr r1,[r4,#0xc]	; 02303FEA
	ldr r2,[sp,#0x4]	; 02303FEC
	ldrh r3,[r4,#0x6]	; 02303FEE
	bl loc_023006B4	; 02303FF0
	ldrh r1,[r4,#0x6]	; 02303FF4
	add r0,r1,#0x0	; 02303FF6
	mov r2,#0x1	; 02303FF8
	bic r0,r2	; 02303FFA
	ldr r2,[sp,#0x4]	; 02303FFC
	add r0,r2,r0	; 02303FFE
	str r0,[sp,#0x4]	; 02304000
	ldr r0,[sp,#0x28]	; 02304002
	add r0,r0,r1	; 02304004
	lsl r0,r0,#0x10	; 02304006
	lsr r0,r0,#0x10	; 02304008
	str r0,[sp,#0x28]	; 0230400A
	sub r7,r7,r1	; 0230400C
	ldr r0,[sp,#0xc]	; 0230400E
	cmp r0,#0x1	; 02304010
	bne loc_02304064	; 02304012
	ldrh r2,[r4,#0x8]	; 02304014
	add r1,r2,#0x0	; 02304016
	mov r0,#0x1	; 02304018
	and r1,r0	; 0230401A
	cmp r1,#0x0	; 0230401C
	beq loc_02304046	; 0230401E
	ldr r0,[pool_02304180]	; 02304020
	ldrh r0,[r6,r0]	; 02304022
	lsl r0,r0,#0x4	; 02304024
	add r0,r6,r0	; 02304026
	ldrh r2,[r4,#0x2]	; 02304028
	mov r1,#0x7	; 0230402A
	and r2,r1	; 0230402C
	lsl r1,r2,#0x1	; 0230402E
	add r0,r0,r1	; 02304030
	ldr r1,[pool_02304184]	; 02304032
	ldrh r1,[r0,r1]	; 02304034
	ldr r2,[pool_02304184]	; 02304036
	add r0,r0,r2	; 02304038
	ldrh r2,[r0,#0x0]	; 0230403A
	add r2,r2,#0x1	; 0230403C
	strh r2,[r0,#0x0]	; 0230403E
	lsl r0,r1,#0x1	; 02304040
	strh r0,[r4,#0x8]	; 02304042
	b loc_02304050	; 02304044
loc_02304046:
	asr r1,r2,#0x1	; 02304046
	ldr r0,[pool_02304188]	; 02304048
	and r1,r0	; 0230404A
	lsl r0,r1,#0x10	; 0230404C
	lsr r1,r0,#0x10	; 0230404E
loc_02304050:
	ldr r0,[sp,#0x4]	; 02304050
	strh r1,[r0,#0x0]	; 02304052
	add r0,r0,#0x2	; 02304054
	str r0,[sp,#0x4]	; 02304056
	ldr r0,[sp,#0x28]	; 02304058
	add r0,r0,#0x2	; 0230405A
	lsl r0,r0,#0x10	; 0230405C
	lsr r0,r0,#0x10	; 0230405E
	str r0,[sp,#0x28]	; 02304060
	sub r7,r7,#0x2	; 02304062
loc_02304064:
	ldr r0,[sp,#0x8]	; 02304064
	cmp r0,#0x1	; 02304066
	bne loc_0230408C	; 02304068
	ldr r0,[sp,#0x0]	; 0230406A
	ldrh r1,[r0,#0x0]	; 0230406C
	ldr r0,[pool_0230418C]	; 0230406E
	orr r1,r0	; 02304070
	ldr r0,[sp,#0x0]	; 02304072
	strh r1,[r0,#0x0]	; 02304074
	ldr r1,[sp,#0x44]	; 02304076
	ldr r0,[sp,#0x4]	; 02304078
	strh r1,[r0,#0x0]	; 0230407A
	add r0,r0,#0x2	; 0230407C
	str r0,[sp,#0x4]	; 0230407E
	ldr r0,[sp,#0x28]	; 02304080
	add r0,r0,#0x2	; 02304082
	lsl r0,r0,#0x10	; 02304084
	lsr r0,r0,#0x10	; 02304086
	str r0,[sp,#0x28]	; 02304088
	sub r7,r7,#0x2	; 0230408A
loc_0230408C:
	ldr r0,[sp,#0x1c]	; 0230408C
	cmp r0,#0x1	; 0230408E
	bne loc_02304096	; 02304090
	ldr r0,[sp,#0x68]	; 02304092
	str r0,[sp,#0x1c]	; 02304094
loc_02304096:
	ldr r0,[sp,#0x34]	; 02304096
	ldrh r0,[r0,#0x2]	; 02304098
	cmp r0,r5	; 0230409A
	bne loc_023040A4	; 0230409C
	ldr r1,[sp,#0x40]	; 0230409E
	ldr r0,[sp,#0x34]	; 023040A0
	strh r1,[r0,#0x2]	; 023040A2
loc_023040A4:
	ldrh r1,[r4,#0x0]	; 023040A4
	ldr r0,[sp,#0x3c]	; 023040A6
	strh r1,[r0,#0x0]	; 023040A8
	ldr r0,[pool_02304174]	; 023040AA
	strh r0,[r4,#0x0]	; 023040AC
	ldr r0,[sp,#0x38]	; 023040AE
	ldrh r0,[r0,#0x2]	; 023040B0
	ldr r1,[pool_02304174]	; 023040B2
	cmp r0,r1	; 023040B4
	bne loc_023040BE	; 023040B6
	ldr r0,[sp,#0x38]	; 023040B8
	strh r5,[r0,#0x0]	; 023040BA
	b loc_023040C6	; 023040BC
loc_023040BE:
	mov r1,#0x18	; 023040BE
	mul r0,r1	; 023040C0
	ldr r1,[sp,#0x2c]	; 023040C2
	strh r5,[r1,r0]	; 023040C4
loc_023040C6:
	ldr r0,[sp,#0x38]	; 023040C6
	strh r5,[r0,#0x2]	; 023040C8
	ldr r1,[sp,#0x14]	; 023040CA
	ldr r0,[sp,#0x4c]	; 023040CC
	bic r1,r0	; 023040CE
	str r1,[sp,#0x14]	; 023040D0
	lsl r0,r1,#0x10	; 023040D2
	lsr r0,r0,#0x10	; 023040D4
	str r0,[sp,#0x14]	; 023040D6
	ldrh r1,[r4,#0x4]	; 023040D8
	ldr r0,[sp,#0x24]	; 023040DA
	orr r0,r1	; 023040DC
	str r0,[sp,#0x24]	; 023040DE
	ldr r5,[sp,#0x40]	; 023040E0
	add r0,r6,#0x0	; 023040E2
	add r0,#0x94	; 023040E4
	ldrh r0,[r0,#0x0]	; 023040E6
	cmp r0,#0x1	; 023040E8
	beq loc_0230413C	; 023040EA
loc_023040EC:
	ldr r0,[pool_02304174]	; 023040EC
	cmp r5,r0	; 023040EE
	beq loc_02304100	; 023040F0
	add r1,r5,#0x0	; 023040F2
	mov r0,#0x18	; 023040F4
	mul r1,r0	; 023040F6
	ldr r0,[sp,#0x2c]	; 023040F8
	add r0,r0,r1	; 023040FA
	str r0,[sp,#0x3c]	; 023040FC
	b loc_02304104	; 023040FE
loc_02304100:
	ldr r0,[sp,#0x34]	; 02304100
	str r0,[sp,#0x3c]	; 02304102
loc_02304104:
	str r5,[sp,#0x40]	; 02304104
loc_02304106:
	ldr r0,[pool_02304174]	; 02304106
	cmp r5,r0	; 02304108
	beq loc_02304116	; 0230410A
	mov r0,#0x18	; 0230410C
	mul r5,r0	; 0230410E
	ldr r0,[sp,#0x2c]	; 02304110
	ldrh r5,[r0,r5]	; 02304112
	b loc_0230411A	; 02304114
loc_02304116:
	ldr r0,[sp,#0x34]	; 02304116
	ldrh r5,[r0,#0x0]	; 02304118
loc_0230411A:
	ldr r0,[pool_02304174]	; 0230411A
	cmp r5,r0	; 0230411C
	beq loc_02304126	; 0230411E
	cmp r7,#0x2	; 02304120
	ble loc_02304126	; 02304122
	b loc_02303EE2	; 02304124
loc_02304126:
	ldr r0,[sp,#0x30]	; 02304126
	add r0,r0,#0x1	; 02304128
	lsl r0,r0,#0x10	; 0230412A
	lsr r0,r0,#0x10	; 0230412C
	str r0,[sp,#0x30]	; 0230412E
loc_02304130:
	ldr r0,[sp,#0x30]	; 02304130
	cmp r0,#0x4	; 02304132
	bcs loc_0230413C	; 02304134
	cmp r7,#0x2	; 02304136
	ble loc_0230413C	; 02304138
	b loc_02303EC2	; 0230413A
loc_0230413C:
	ldr r1,[sp,#0x24]	; 0230413C
	ldr r0,[sp,#0x80]	; 0230413E
	strh r1,[r0,#0x0]	; 02304140
	ldr r1,[sp,#0x28]	; 02304142
	ldr r0,[sp,#0x84]	; 02304144
	strh r1,[r0,#0x0]	; 02304146
	ldr r0,[pool_02304160]	; 02304148
	add r0,r6,r0	; 0230414A
	bl loc_02303D04	; 0230414C
	mov r0,#0x0	; 02304150
loc_02304152:
	add sp,#0x6c	; 02304152
	pop {r4,r5,r6,r7}	; 02304154
	pop {r3}	; 02304156
	bx r3	; 02304158
	.byte 0xC0, 0x46	; 0230415C
pool_0230415C:
loc_0230415C:
	.word 0x00001518	; 0230415C
pool_02304160:
loc_02304160:
	.word 0x00000918	; 02304160
pool_02304164:
loc_02304164:
	.word 0x0000092C	; 02304164
pool_02304168:
loc_02304168:
	.word 0x000002F4	; 02304168
pool_0230416C:
loc_0230416C:
	.word 0x00000908	; 0230416C
pool_02304170:
loc_02304170:
	.word 0x000008F8	; 02304170
pool_02304174:
loc_02304174:
	.word 0x0000FFFF	; 02304174
pool_02304178:
loc_02304178:
	.word 0x00000F00	; 02304178
pool_0230417C:
loc_0230417C:
	.word 0x0000150C	; 0230417C
pool_02304180:
loc_02304180:
	.word 0x00000184	; 02304180
pool_02304184:
loc_02304184:
	.word 0x000001F4	; 02304184
pool_02304188:
loc_02304188:
	.word 0x00007FFF	; 02304188
pool_0230418C:
loc_0230418C:
	.word 0x00001000	; 0230418C

; ===== function loc_02304190 =====
loc_02304190:
	push {r4,r5,r6,r7,lr}	; 02304190
	sub sp,#0x1fc	; 02304192
	sub sp,#0x30	; 02304194
	add r5,r0,#0x0	; 02304196
	bl loc_023008B4	; 02304198
	ldr r1,[pool_02304294]	; 0230419C
	ldr r0,[r0,r1]	; 0230419E
	ldr r4,[r0,#0x0]	; 023041A0
	mov r6,#0x0	; 023041A2
	ldr r7,[r4,#0x50]	; 023041A4
	ldr r0,[pool_02304298]	; 023041A6
	ldrh r1,[r4,r0]	; 023041A8
	add r0,r4,#0x0	; 023041AA
	add r0,#0x88	; 023041AC
	ldrh r0,[r0,#0x0]	; 023041AE
	cmp r0,#0x1	; 023041B0
	bne loc_023041BC	; 023041B2
	ldr r5,[pool_0230429C]	; 023041B4
	add r0,r4,#0x0	; 023041B6
	add r0,#0x88	; 023041B8
	strh r6,[r0,#0x0]	; 023041BA
loc_023041BC:
	add r0,r4,#0x0	; 023041BC
	add r0,#0x9a	; 023041BE
	ldrh r0,[r0,#0x0]	; 023041C0
	cmp r0,#0x1	; 023041C2
	bne loc_023041D2	; 023041C4
	ldr r5,[pool_0230429C]	; 023041C6
	mov r6,#0x1	; 023041C8
	mov r1,#0x0	; 023041CA
	add r0,r4,#0x0	; 023041CC
	add r0,#0x9a	; 023041CE
	strh r1,[r0,#0x0]	; 023041D0
loc_023041D2:
	add r0,sp,#0x24	; 023041D2
	str r0,[sp,#0x0]	; 023041D4
	add r0,sp,#0x24	; 023041D6
	add r0,#0x2	; 023041D8
	str r0,[sp,#0x4]	; 023041DA
	add r0,r5,#0x0	; 023041DC
	add r2,sp,#0x28	; 023041DE
	add r3,r7,#0x0	; 023041E0
	bl loc_02303E08	; 023041E2
	cmp r0,#0x1	; 023041E6
	beq loc_02304288	; 023041E8
	ldr r0,[pool_023042A0]	; 023041EA
	ldrh r0,[r4,r0]	; 023041EC
	add r0,r0,#0x2	; 023041EE
	lsl r0,r0,#0x10	; 023041F0
	lsr r0,r0,#0x10	; 023041F2
	str r0,[sp,#0x1c]	; 023041F4
	ldr r0,[pool_023042A4]	; 023041F6
	ldrh r0,[r0,#0x0]	; 023041F8
	str r0,[sp,#0x20]	; 023041FA
	ldrh r0,[r4,#0x3e]	; 023041FC
	cmp r0,#0x1	; 023041FE
	bne loc_02304220	; 02304200
	mov r0,#0x0	; 02304202
	str r0,[sp,#0x18]	; 02304204
	add r0,sp,#0x24	; 02304206
	ldrh r0,[r0,#0x2]	; 02304208
	ldr r1,[sp,#0x1c]	; 0230420A
	add r2,r5,#0x0	; 0230420C
	bl loc_023038B0	; 0230420E
	add r2,r0,#0x0	; 02304212
	add r3,sp,#0x24	; 02304214
	ldrh r1,[r3,#0x4]	; 02304216
	ldr r0,[pool_023042A8]	; 02304218
	orr r1,r0	; 0230421A
	strh r1,[r3,#0x4]	; 0230421C
	b loc_02304224	; 0230421E
loc_02304220:
	mov r2,#0x0	; 02304220
	str r2,[sp,#0x18]	; 02304222
loc_02304224:
	add r0,r4,#0x0	; 02304224
	add r0,#0x92	; 02304226
	ldrh r0,[r0,#0x0]	; 02304228
	cmp r0,#0x1	; 0230422A
	bne loc_0230425E	; 0230422C
	cmp r6,#0x0	; 0230422E
	bne loc_02304242	; 02304230
	add r0,sp,#0x24	; 02304232
	ldrh r1,[r0,#0x0]	; 02304234
	ldr r0,[pool_023042AC]	; 02304236
	ldrh r0,[r4,r0]	; 02304238
	and r1,r0	; 0230423A
	lsl r0,r1,#0x10	; 0230423C
	lsr r0,r0,#0x10	; 0230423E
	b loc_02304268	; 02304240
loc_02304242:
	ldr r0,[pool_023042AC]	; 02304242
	ldrh r0,[r4,r0]	; 02304244
	mov r2,#0x0	; 02304246
	str r2,[sp,#0x1c]	; 02304248
	add r4,#0x3e	; 0230424A
	ldrh r1,[r4,#0x0]	; 0230424C
	add r1,r1,#0x1	; 0230424E
	strh r1,[r4,#0x0]	; 02304250
	add r3,sp,#0x24	; 02304252
	ldrh r4,[r3,#0x4]	; 02304254
	ldr r1,[pool_023042B0]	; 02304256
	and r4,r1	; 02304258
	strh r4,[r3,#0x4]	; 0230425A
	b loc_02304268	; 0230425C
loc_0230425E:
	ldr r0,[pool_023042AC]	; 0230425E
	ldrh r0,[r4,r0]	; 02304260
	and r5,r0	; 02304262
	lsl r0,r5,#0x10	; 02304264
	lsr r0,r0,#0x10	; 02304266
loc_02304268:
	str r0,[sp,#0x0]	; 02304268
	str r2,[sp,#0x4]	; 0230426A
	ldr r0,[sp,#0x20]	; 0230426C
	str r0,[sp,#0x8]	; 0230426E
	add r0,sp,#0x24	; 02304270
	ldrh r1,[r0,#0x2]	; 02304272
	str r1,[sp,#0xc]	; 02304274
	ldrh r0,[r0,#0x4]	; 02304276
	str r0,[sp,#0x10]	; 02304278
	str r7,[sp,#0x14]	; 0230427A
	add r0,sp,#0x2c	; 0230427C
	mov r1,#0x0	; 0230427E
	ldr r2,[sp,#0x18]	; 02304280
	ldr r3,[sp,#0x1c]	; 02304282
	bl loc_02301B08	; 02304284
loc_02304288:
	add sp,#0x1fc	; 02304288
	add sp,#0x30	; 0230428A
	pop {r4,r5,r6,r7}	; 0230428C
	pop {r3}	; 0230428E
	bx r3	; 02304290
	.byte 0xC0, 0x46	; 02304294
pool_02304294:
loc_02304294:
	.word 0x00001518	; 02304294
pool_02304298:
loc_02304298:
	.word 0x0000018E	; 02304298
pool_0230429C:
loc_0230429C:
	.word 0x0000FFFF	; 0230429C
pool_023042A0:
loc_023042A0:
	.word 0x00000190	; 023042A0
pool_023042A4:
loc_023042A4:
	.word REG_WIFI_US_COUNT0	; 023042A4
pool_023042A8:
loc_023042A8:
	.word 0x00008000	; 023042A8
pool_023042AC:
loc_023042AC:
	.word 0x0000017E	; 023042AC
pool_023042B0:
loc_023042B0:
	.word 0xFFFF7FFF	; 023042B0

; ===== function loc_023042B4 =====
loc_023042B4:
	push {r4,r5,lr}	; 023042B4
	sub sp,#0x1fc	; 023042B6
	sub sp,#0x18	; 023042B8
	bl loc_023008B4	; 023042BA
	ldr r1,[pool_02304318]	; 023042BE
	ldr r0,[r0,r1]	; 023042C0
	ldr r5,[r0,#0x0]	; 023042C2
	ldr r4,[r5,#0x50]	; 023042C4
	add r0,sp,#0x8	; 023042C6
	str r0,[sp,#0x0]	; 023042C8
	add r0,sp,#0x8	; 023042CA
	add r0,#0x2	; 023042CC
	str r0,[sp,#0x4]	; 023042CE
	mov r0,#0x1	; 023042D0
	ldr r1,[pool_0230431C]	; 023042D2
	ldrh r1,[r5,r1]	; 023042D4
	add r2,sp,#0xc	; 023042D6
	add r3,r4,#0x0	; 023042D8
	bl loc_02303E08	; 023042DA
	cmp r0,#0x0	; 023042DE
	bne loc_0230430C	; 023042E0
	ldr r0,[r5,#0x24]	; 023042E2
	cmp r0,#0x1	; 023042E4
	bne loc_023042F2	; 023042E6
	add r1,sp,#0x8	; 023042E8
	ldrh r2,[r1,#0x4]	; 023042EA
	ldr r0,[pool_02304320]	; 023042EC
	orr r2,r0	; 023042EE
	strh r2,[r1,#0x4]	; 023042F0
loc_023042F2:
	add r0,sp,#0x10	; 023042F2
	add r2,sp,#0x8	; 023042F4
	ldrh r1,[r2,#0x2]	; 023042F6
	ldrh r2,[r2,#0x4]	; 023042F8
	add r3,r4,#0x0	; 023042FA
	bl loc_02301B68	; 023042FC
	ldrh r0,[r0,#0x4]	; 02304300
	cmp r0,#0x0	; 02304302
	bne loc_0230430C	; 02304304
	mov r0,#0x1	; 02304306
	add r5,#0x8a	; 02304308
	strh r0,[r5,#0x0]	; 0230430A
loc_0230430C:
	add sp,#0x1fc	; 0230430C
	add sp,#0x18	; 0230430E
	pop {r4,r5}	; 02304310
	pop {r3}	; 02304312
	bx r3	; 02304314
	.byte 0xC0, 0x46	; 02304318
pool_02304318:
loc_02304318:
	.word 0x00001518	; 02304318
pool_0230431C:
loc_0230431C:
	.word 0x0000018E	; 0230431C
pool_02304320:
loc_02304320:
	.word 0x00008000	; 02304320

; ===== function loc_02304324 =====
loc_02304324:
	push {r4,r5,r6,r7,lr}	; 02304324
	sub sp,#0x4	; 02304326
	bl loc_023008B4	; 02304328
	ldr r1,[pool_023043AC]	; 0230432C
	ldr r0,[r0,r1]	; 0230432E
	ldr r4,[r0,#0x0]	; 02304330
	ldr r0,[pool_023043B0]	; 02304332
	add r0,r4,r0	; 02304334
	bl loc_02303CF4	; 02304336
	mov r1,#0x0	; 0230433A
	add r0,sp,#0x0	; 0230433C
	strh r1,[r0,#0x0]	; 0230433E
	ldrh r0,[r0,#0x0]	; 02304340
	ldr r1,[pool_023043B4]	; 02304342
	add r1,r4,r1	; 02304344
	ldr r2,[pool_023043B8]	; 02304346
	bl loc_023043D8	; 02304348
	mov r5,#0x0	; 0230434C
	mov r1,#0x18	; 0230434E
	ldr r3,[pool_023043B4]	; 02304350
loc_02304352:
	add r0,r5,#0x1	; 02304352
	lsl r0,r0,#0x10	; 02304354
	lsr r2,r0,#0x10	; 02304356
	mul r5,r1	; 02304358
	add r0,r4,r5	; 0230435A
	strh r2,[r0,r3]	; 0230435C
	add r5,r2,#0x0	; 0230435E
	cmp r2,#0x3f	; 02304360
	bcc loc_02304352	; 02304362
	ldr r0,[pool_023043BC]	; 02304364
	mov r1,#0x18	; 02304366
	add r3,r2,#0x0	; 02304368
	mul r3,r1	; 0230436A
	add r3,r4,r3	; 0230436C
	ldr r1,[pool_023043B4]	; 0230436E
	strh r0,[r3,r1]	; 02304370
	mov r1,#0x0	; 02304372
	ldr r3,[pool_023043C0]	; 02304374
	strh r1,[r4,r3]	; 02304376
	ldr r3,[pool_023043C4]	; 02304378
	strh r2,[r4,r3]	; 0230437A
	ldr r7,[pool_023043C8]	; 0230437C
	ldr r2,[pool_023043CC]	; 0230437E
	ldr r3,[pool_023043D0]	; 02304380
	ldr r5,[pool_023043D4]	; 02304382
loc_02304384:
	lsl r6,r1,#0x2	; 02304384
	add r6,r4,r6	; 02304386
	strh r0,[r6,r7]	; 02304388
	strh r0,[r6,r2]	; 0230438A
	strh r0,[r6,r3]	; 0230438C
	strh r0,[r6,r5]	; 0230438E
	add r1,r1,#0x1	; 02304390
	lsl r1,r1,#0x10	; 02304392
	lsr r1,r1,#0x10	; 02304394
	cmp r1,#0x4	; 02304396
	bcc loc_02304384	; 02304398
	ldr r0,[pool_023043B0]	; 0230439A
	add r0,r4,r0	; 0230439C
	bl loc_02303D04	; 0230439E
	add sp,#0x4	; 023043A2
	pop {r4,r5,r6,r7}	; 023043A4
	pop {r3}	; 023043A6
	bx r3	; 023043A8
	.byte 0xC0, 0x46	; 023043AC
pool_023043AC:
loc_023043AC:
	.word 0x00001518	; 023043AC
pool_023043B0:
loc_023043B0:
	.word 0x00000918	; 023043B0
pool_023043B4:
loc_023043B4:
	.word 0x000002F4	; 023043B4
pool_023043B8:
loc_023043B8:
	.word 0x00000600	; 023043B8
pool_023043BC:
loc_023043BC:
	.word 0x0000FFFF	; 023043BC
pool_023043C0:
loc_023043C0:
	.word 0x000008F4	; 023043C0
pool_023043C4:
loc_023043C4:
	.word 0x000008F6	; 023043C4
pool_023043C8:
loc_023043C8:
	.word 0x00000908	; 023043C8
pool_023043CC:
loc_023043CC:
	.word 0x0000090A	; 023043CC
pool_023043D0:
loc_023043D0:
	.word 0x000008F8	; 023043D0
pool_023043D4:
loc_023043D4:
	.word 0x000008FA	; 023043D4

; ===== function loc_023043D8 =====
loc_023043D8:
	bx pc	; 023043D8
	.byte 0xC0, 0x46	; 023043DC
.arm

; ===== function loc_023043DC =====
loc_023043DC:
	ldr pc,[pool_023043E0]	; 023043DC
pool_023043E0:
loc_023043E0:
	.word loc_037FCE04	; 023043E0
.thumb

; ===== function loc_023043E4 =====
	push {r4,r5,lr}	; 023043E4
	sub sp,#0x1fc	; 023043E6
	sub sp,#0x88	; 023043E8
	add r5,r0,#0x0	; 023043EA
	bl loc_023008B4	; 023043EC
	ldr r1,[pool_0230444C]	; 023043F0
	ldr r0,[r0,r1]	; 023043F2
	ldr r4,[r0,#0x0]	; 023043F4
	ldr r1,[r5,#0x4]	; 023043F6
	add r0,r4,#0x0	; 023043F8
	add r0,#0xf0	; 023043FA
	strh r1,[r0,#0x0]	; 023043FC
	add r0,sp,#0x200	; 023043FE
	add r1,r4,#0x0	; 02304400
	add r1,#0xe4	; 02304402
	bl loc_023006DC	; 02304404
	add r0,sp,#0x0	; 02304408
	add r4,#0xe8	; 0230440A
	ldrh r1,[r4,#0x0]	; 0230440C
	add r1,#0x10	; 0230440E
	lsl r1,r1,#0x10	; 02304410
	lsr r1,r1,#0x10	; 02304412
	add r2,sp,#0x200	; 02304414
	bl loc_023019AC	; 02304416
	add r4,r0,#0x0	; 0230441A
	bl loc_02300404	; 0230441C
	mov r1,#0x21	; 02304420
	strh r1,[r0,#0x0]	; 02304422
	ldrh r1,[r4,#0x4]	; 02304424
	cmp r1,#0x0	; 02304426
	bne loc_02304430	; 02304428
	mov r1,#0x0	; 0230442A
	strh r1,[r0,#0x2]	; 0230442C
	b loc_0230443C	; 0230442E
loc_02304430:
	mov r1,#0x1	; 02304430
	strh r1,[r0,#0x2]	; 02304432
	ldr r1,[pool_02304450]	; 02304434
	strh r1,[r0,#0x4]	; 02304436
	ldrh r1,[r4,#0x4]	; 02304438
	strh r1,[r0,#0x6]	; 0230443A
loc_0230443C:
	bl loc_02300414	; 0230443C
	add sp,#0x1fc	; 02304440
	add sp,#0x88	; 02304442
	pop {r4,r5}	; 02304444
	pop {r3}	; 02304446
	bx r3	; 02304448
	.byte 0xC0, 0x46	; 0230444C
pool_0230444C:
loc_0230444C:
	.word 0x00001518	; 0230444C
pool_02304450:
loc_02304450:
	.word 0x00000245	; 02304450

; ===== function loc_02304454 =====
	push {r4,lr}	; 02304454
	sub sp,#0x1fc	; 02304456
	sub sp,#0xc	; 02304458
	add r0,r0,#0x4	; 0230445A
	add r1,sp,#0x0	; 0230445C
	mov r2,#0x6	; 0230445E
	bl loc_023044A0	; 02304460
	add r0,sp,#0x8	; 02304464
	add r1,sp,#0x0	; 02304466
	mov r2,#0x13	; 02304468
	bl loc_02301D00	; 0230446A
	add r4,r0,#0x0	; 0230446E
	bl loc_02300404	; 02304470
	mov r1,#0x22	; 02304474
	strh r1,[r0,#0x0]	; 02304476
	ldrh r1,[r4,#0x4]	; 02304478
	cmp r1,#0x0	; 0230447A
	bne loc_02304484	; 0230447C
	mov r1,#0x0	; 0230447E
	strh r1,[r0,#0x2]	; 02304480
	b loc_02304490	; 02304482
loc_02304484:
	mov r1,#0x1	; 02304484
	strh r1,[r0,#0x2]	; 02304486
	mov r1,#0x5	; 02304488
	strh r1,[r0,#0x4]	; 0230448A
	ldrh r1,[r4,#0x4]	; 0230448C
	strh r1,[r0,#0x6]	; 0230448E
loc_02304490:
	bl loc_02300414	; 02304490
	add sp,#0x1fc	; 02304494
	add sp,#0xc	; 02304496
	pop {r4}	; 02304498
	pop {r3}	; 0230449A
	bx r3	; 0230449C
	.byte 0xC0, 0x46	; 023044A0

; ===== function loc_023044A0 =====
loc_023044A0:
	bx pc	; 023044A0
	.byte 0xC0, 0x46	; 023044A4
.arm

; ===== function loc_023044A4 =====
loc_023044A4:
	ldr pc,[pool_023044A8]	; 023044A4
pool_023044A8:
loc_023044A8:
	.word P2_Entry_037FCE1C	; 023044A8
.thumb

; ===== function loc_023044AC =====
loc_023044AC:
	push {r4,lr}	; 023044AC
	sub sp,#0x8	; 023044AE
	bl loc_023008B4	; 023044B0
	ldr r1,[pool_02304518]	; 023044B4
	ldr r4,[r0,r1]	; 023044B6
	mov r0,#0x0	; 023044B8
	ldr r1,[r4,#0x0]	; 023044BA
	str r0,[r1,#0x10]	; 023044BC
	ldr r1,[r4,#0x0]	; 023044BE
	str r0,[r1,#0x18]	; 023044C0
	ldr r1,[r4,#0x0]	; 023044C2
	str r0,[r1,#0x14]	; 023044C4
	ldr r1,[r4,#0x0]	; 023044C6
	add r1,#0x92	; 023044C8
	strh r0,[r1,#0x0]	; 023044CA
	ldr r1,[r4,#0x0]	; 023044CC
	add r1,#0x94	; 023044CE
	strh r0,[r1,#0x0]	; 023044D0
	ldr r1,[r4,#0x0]	; 023044D2
	add r1,#0x96	; 023044D4
	strh r0,[r1,#0x0]	; 023044D6
	ldr r2,[r4,#0x0]	; 023044D8
	ldr r1,[pool_0230451C]	; 023044DA
	strh r0,[r2,r1]	; 023044DC
	ldr r2,[r4,#0x0]	; 023044DE
	ldr r1,[pool_02304520]	; 023044E0
	strh r0,[r2,r1]	; 023044E2
	mov r1,#0x1	; 023044E4
	add r0,sp,#0x0	; 023044E6
	strh r1,[r0,#0x0]	; 023044E8
	ldrh r0,[r0,#0x0]	; 023044EA
	ldr r2,[r4,#0x0]	; 023044EC
	ldr r1,[pool_02304524]	; 023044EE
	add r1,r2,r1	; 023044F0
	ldr r2,[pool_02304528]	; 023044F2
	bl loc_02304530	; 023044F4
	ldr r0,[r4,#0x0]	; 023044F8
	add r0,#0x58	; 023044FA
	bl loc_0230453C	; 023044FC
	ldr r1,[r4,#0x0]	; 02304500
	ldr r0,[pool_0230452C]	; 02304502
	add r0,r1,r0	; 02304504
	bl loc_023009D0	; 02304506
	bl loc_02303738	; 0230450A
	add sp,#0x8	; 0230450E
	pop {r4}	; 02304510
	pop {r3}	; 02304512
	bx r3	; 02304514
	.byte 0xC0, 0x46	; 02304518
pool_02304518:
loc_02304518:
	.word 0x00001518	; 02304518
pool_0230451C:
loc_0230451C:
	.word 0x0000018E	; 0230451C
pool_02304520:
loc_02304520:
	.word 0x00000190	; 02304520
pool_02304524:
loc_02304524:
	.word 0x000001F4	; 02304524
pool_02304528:
loc_02304528:
	.word 0x00000200	; 02304528
pool_0230452C:
loc_0230452C:
	.word 0x00000918	; 0230452C

; ===== function loc_02304530 =====
loc_02304530:
	bx pc	; 02304530
	.byte 0xC0, 0x46	; 02304534
.arm

; ===== function loc_02304534 =====
loc_02304534:
	ldr pc,[pool_02304538]	; 02304534
pool_02304538:
loc_02304538:
	.word loc_037FCE04	; 02304538
.thumb

; ===== function loc_0230453C =====
loc_0230453C:
	bx pc	; 0230453C
	.byte 0xC0, 0x46	; 02304540
.arm

; ===== function loc_02304540 =====
loc_02304540:
	ldr r12,[pool_02304548]	; 02304540
	bx r12	; 02304544
pool_02304548:
loc_02304548:
	.word loc_037FC778 + 1	; 02304548
.thumb

; ===== function loc_0230454C =====
	push {r4,r5,lr}	; 0230454C
	sub sp,#0x4	; 0230454E
	add r5,r0,#0x0	; 02304550
	bl loc_023008B4	; 02304552
	ldr r2,[r5,#0x4]	; 02304556
	ldr r1,[pool_02304590]	; 02304558
	add r0,r0,r1	; 0230455A
	str r2,[r0,#0x0]	; 0230455C
	ldr r4,[r0,#0x0]	; 0230455E
	ldr r0,[r5,#0x8]	; 02304560
	str r0,[r4,#0x0]	; 02304562
	ldr r0,[r5,#0xc]	; 02304564
	str r0,[r4,#0x8]	; 02304566
	bl loc_023044AC	; 02304568
	mov r0,#0xf	; 0230456C
	bl loc_02301F90	; 0230456E
	mov r1,#0x1	; 02304572
	ldr r0,[r4,#0x0]	; 02304574
	strh r1,[r0,#0x0]	; 02304576
	bl loc_02300404	; 02304578
	mov r1,#0x3	; 0230457C
	strh r1,[r0,#0x0]	; 0230457E
	mov r1,#0x0	; 02304580
	strh r1,[r0,#0x2]	; 02304582
	bl loc_02300414	; 02304584
	add sp,#0x4	; 02304588
	pop {r4,r5}	; 0230458A
	pop {r3}	; 0230458C
	bx r3	; 0230458E
pool_02304590:
loc_02304590:
	.word 0x00001518	; 02304590
	push {r4,lr}	; 02304594
	bl loc_023008B4	; 02304596
	ldr r1,[pool_023045DC]	; 0230459A
	ldr r4,[r0,r1]	; 0230459C
	ldr r0,[r4,#0x0]	; 0230459E
	ldrh r0,[r0,#0x0]	; 023045A0
	cmp r0,#0x1	; 023045A2
	beq loc_023045B8	; 023045A4
	bl loc_02300404	; 023045A6
	mov r1,#0x4	; 023045AA
	strh r1,[r0,#0x0]	; 023045AC
	mov r1,#0x3	; 023045AE
	strh r1,[r0,#0x2]	; 023045B0
	bl loc_02300414	; 023045B2
	b loc_023045D4	; 023045B6
loc_023045B8:
	mov r0,#0x1	; 023045B8
	bl loc_02301F90	; 023045BA
	mov r1,#0x0	; 023045BE
	ldr r0,[r4,#0x0]	; 023045C0
	strh r1,[r0,#0x0]	; 023045C2
	bl loc_02300404	; 023045C4
	mov r1,#0x4	; 023045C8
	strh r1,[r0,#0x0]	; 023045CA
	mov r1,#0x0	; 023045CC
	strh r1,[r0,#0x2]	; 023045CE
	bl loc_02300414	; 023045D0
loc_023045D4:
	pop {r4}	; 023045D4
	pop {r3}	; 023045D6
	bx r3	; 023045D8
	.byte 0xC0, 0x46	; 023045DC
pool_023045DC:
loc_023045DC:
	.word 0x00001518	; 023045DC

; ===== function loc_023045E0 =====
loc_023045E0:
	mov r1,#0xc8	; 023045E0
	ldr r0,[pool_023045F4]	; 023045E2
	strh r1,[r0,#0x0]	; 023045E4
	ldr r1,[pool_023045F8]	; 023045E6
	ldr r0,[pool_023045FC]	; 023045E8
	strh r1,[r0,#0x0]	; 023045EA
	ldr r1,[pool_02304600]	; 023045EC
	ldr r0,[pool_02304604]	; 023045EE
	strh r1,[r0,#0x0]	; 023045F0
	bx lr	; 023045F2
pool_023045F4:
loc_023045F4:
	.word REG_WIFI_CONFIG_124	; 023045F4
pool_023045F8:
loc_023045F8:
	.word 0x000007D0	; 023045F8
pool_023045FC:
loc_023045FC:
	.word REG_WIFI_CONFIG_128	; 023045FC
pool_02304600:
loc_02304600:
	.word 0x00000202	; 02304600
pool_02304604:
loc_02304604:
	.word REG_WIFI_CONFIG_150	; 02304604

; ===== function loc_02304608 =====
loc_02304608:
	push {r4,r5,r6,r7,lr}	; 02304608
	sub sp,#0x1fc	; 0230460A
	sub sp,#0x8	; 0230460C
	add r5,r0,#0x0	; 0230460E
	add r6,r1,#0x0	; 02304610
	bl loc_023008B4	; 02304612
	ldr r1,[pool_02304720]	; 02304616
	ldr r4,[r0,r1]	; 02304618
	add r0,sp,#0x0	; 0230461A
	bl loc_0230193C	; 0230461C
	ldrh r1,[r0,#0x4]	; 02304620
	cmp r1,#0x0	; 02304622
	beq loc_02304632	; 02304624
	ldr r1,[pool_02304724]	; 02304626
	strh r1,[r5,#0x0]	; 02304628
	ldrh r0,[r0,#0x4]	; 0230462A
	strh r0,[r6,#0x0]	; 0230462C
	mov r0,#0x0	; 0230462E
	b loc_02304716	; 02304630
loc_02304632:
	add r0,sp,#0x0	; 02304632
	bl loc_0230195C	; 02304634
	ldrh r1,[r0,#0x4]	; 02304638
	cmp r1,#0x0	; 0230463A
	beq loc_0230464A	; 0230463C
	ldr r1,[pool_02304728]	; 0230463E
	strh r1,[r5,#0x0]	; 02304640
	ldrh r0,[r0,#0x4]	; 02304642
	strh r0,[r6,#0x0]	; 02304644
	mov r0,#0x0	; 02304646
	b loc_02304716	; 02304648
loc_0230464A:
	bl loc_023045E0	; 0230464A
	add r0,sp,#0x0	; 0230464E
	bl loc_0230198C	; 02304650
	ldrh r1,[r0,#0x4]	; 02304654
	cmp r1,#0x0	; 02304656
	beq loc_02304666	; 02304658
	ldr r1,[pool_0230472C]	; 0230465A
	strh r1,[r5,#0x0]	; 0230465C
	ldrh r0,[r0,#0x4]	; 0230465E
	strh r0,[r6,#0x0]	; 02304660
	mov r0,#0x0	; 02304662
	b loc_02304716	; 02304664
loc_02304666:
	ldrh r2,[r0,#0x6]	; 02304666
	ldr r1,[r4,#0x0]	; 02304668
	ldr r0,[pool_02304730]	; 0230466A
	strh r2,[r1,r0]	; 0230466C
	lsl r0,r2,#0xf	; 0230466E
	lsr r0,r0,#0x10	; 02304670
	bl loc_0230048C	; 02304672
	ldr r2,[r4,#0x0]	; 02304676
	ldr r1,[pool_02304734]	; 02304678
	strh r0,[r2,r1]	; 0230467A
	add r0,sp,#0x0	; 0230467C
	ldr r1,[pool_02304738]	; 0230467E
	mov r2,#0x28	; 02304680
	mov r3,#0x5	; 02304682
	bl loc_02301A90	; 02304684
	mov r2,#0x2	; 02304688
	ldr r1,[r4,#0x0]	; 0230468A
	ldr r0,[pool_0230473C]	; 0230468C
	strh r2,[r1,r0]	; 0230468E
	mov r2,#0x1	; 02304690
	ldr r1,[r4,#0x0]	; 02304692
	ldr r0,[pool_02304740]	; 02304694
	strh r2,[r1,r0]	; 02304696
	add r0,sp,#0x0	; 02304698
	bl loc_0230191C	; 0230469A
	add r7,r0,#0x0	; 0230469E
	ldrh r0,[r7,#0x4]	; 023046A0
	cmp r0,#0x0	; 023046A2
	beq loc_023046B2	; 023046A4
	ldr r0,[pool_02304744]	; 023046A6
	strh r0,[r5,#0x0]	; 023046A8
	ldrh r0,[r7,#0x4]	; 023046AA
	strh r0,[r6,#0x0]	; 023046AC
	mov r0,#0x0	; 023046AE
	b loc_02304716	; 023046B0
loc_023046B2:
	add r0,r7,#0x6	; 023046B2
	ldr r1,[r4,#0x0]	; 023046B4
	add r1,#0x28	; 023046B6
	mov r2,#0x8	; 023046B8
	bl loc_02304750	; 023046BA
	ldrh r1,[r7,#0xe]	; 023046BE
	ldr r0,[r4,#0x0]	; 023046C0
	strh r1,[r0,#0x30]	; 023046C2
	ldrh r1,[r7,#0x10]	; 023046C4
	ldr r0,[r4,#0x0]	; 023046C6
	strh r1,[r0,#0x34]	; 023046C8
	ldrh r1,[r7,#0x12]	; 023046CA
	ldr r0,[r4,#0x0]	; 023046CC
	strh r1,[r0,#0x36]	; 023046CE
	ldrh r1,[r7,#0x14]	; 023046D0
	ldr r0,[r4,#0x0]	; 023046D2
	strh r1,[r0,#0x32]	; 023046D4
	add r0,sp,#0x0	; 023046D6
	bl loc_0230199C	; 023046D8
	add r1,r0,#0x0	; 023046DC
	ldrh r0,[r1,#0x4]	; 023046DE
	cmp r0,#0x0	; 023046E0
	beq loc_023046F0	; 023046E2
	ldr r0,[pool_02304748]	; 023046E4
	strh r0,[r5,#0x0]	; 023046E6
	ldrh r0,[r1,#0x4]	; 023046E8
	strh r0,[r6,#0x0]	; 023046EA
	mov r0,#0x0	; 023046EC
	b loc_02304716	; 023046EE
loc_023046F0:
	ldr r0,[r4,#0x0]	; 023046F0
	add r0,#0xdc	; 023046F2
	add r1,r1,#0x6	; 023046F4
	bl loc_023007BC	; 023046F6
	add r0,sp,#0x0	; 023046FA
	mov r1,#0x1	; 023046FC
	bl loc_02301A20	; 023046FE
	ldrh r1,[r0,#0x4]	; 02304702
	cmp r1,#0x0	; 02304704
	beq loc_02304714	; 02304706
	ldr r1,[pool_0230474C]	; 02304708
	strh r1,[r5,#0x0]	; 0230470A
	ldrh r0,[r0,#0x4]	; 0230470C
	strh r0,[r6,#0x0]	; 0230470E
	mov r0,#0x0	; 02304710
	b loc_02304716	; 02304712
loc_02304714:
	mov r0,#0x1	; 02304714
loc_02304716:
	add sp,#0x1fc	; 02304716
	add sp,#0x8	; 02304718
	pop {r4,r5,r6,r7}	; 0230471A
	pop {r3}	; 0230471C
	bx r3	; 0230471E
pool_02304720:
loc_02304720:
	.word 0x00001518	; 02304720
pool_02304724:
loc_02304724:
	.word 0x00000304	; 02304724
pool_02304728:
loc_02304728:
	.word 0x00000302	; 02304728
pool_0230472C:
loc_0230472C:
	.word 0x00000283	; 0230472C
pool_02304730:
loc_02304730:
	.word 0x000001F0	; 02304730
pool_02304734:
loc_02304734:
	.word 0x000001F2	; 02304734
pool_02304738:
loc_02304738:
	.word 0x0000FFFF	; 02304738
pool_0230473C:
loc_0230473C:
	.word 0x000001E8	; 0230473C
pool_02304740:
loc_02304740:
	.word 0x000001EA	; 02304740
pool_02304744:
loc_02304744:
	.word 0x00000306	; 02304744
pool_02304748:
loc_02304748:
	.word 0x00000281	; 02304748
pool_0230474C:
loc_0230474C:
	.word 0x00000215	; 0230474C

; ===== function loc_02304750 =====
loc_02304750:
	bx pc	; 02304750
	.byte 0xC0, 0x46	; 02304754
.arm

; ===== function loc_02304754 =====
loc_02304754:
	ldr pc,[pool_02304758]	; 02304754
pool_02304758:
loc_02304758:
	.word P2_Entry_037FCE1C	; 02304758
.thumb

; ===== function loc_0230475C =====
	push {r4,lr}	; 0230475C
	sub sp,#0x8	; 0230475E
	bl loc_023008B4	; 02304760
	ldr r1,[pool_023047CC]	; 02304764
	ldr r4,[r0,r1]	; 02304766
	ldr r0,[r4,#0x0]	; 02304768
	ldrh r0,[r0,#0x0]	; 0230476A
	cmp r0,#0x1	; 0230476C
	beq loc_02304782	; 0230476E
	bl loc_02300404	; 02304770
	mov r1,#0x5	; 02304774
	strh r1,[r0,#0x0]	; 02304776
	mov r1,#0x3	; 02304778
	strh r1,[r0,#0x2]	; 0230477A
	bl loc_02300414	; 0230477C
	b loc_023047C2	; 02304780
loc_02304782:
	add r0,sp,#0x0	; 02304782
	add r1,sp,#0x0	; 02304784
	add r1,#0x2	; 02304786
	bl loc_02304608	; 02304788
	cmp r0,#0x0	; 0230478C
	bne loc_023047AC	; 0230478E
	bl loc_02300404	; 02304790
	mov r1,#0x5	; 02304794
	strh r1,[r0,#0x0]	; 02304796
	mov r1,#0x1	; 02304798
	strh r1,[r0,#0x2]	; 0230479A
	add r1,sp,#0x0	; 0230479C
	ldrh r2,[r1,#0x0]	; 0230479E
	strh r2,[r0,#0x4]	; 023047A0
	ldrh r1,[r1,#0x2]	; 023047A2
	strh r1,[r0,#0x6]	; 023047A4
	bl loc_02300414	; 023047A6
	b loc_023047C2	; 023047AA
loc_023047AC:
	mov r1,#0x2	; 023047AC
	ldr r0,[r4,#0x0]	; 023047AE
	strh r1,[r0,#0x0]	; 023047B0
	bl loc_02300404	; 023047B2
	mov r1,#0x5	; 023047B6
	strh r1,[r0,#0x0]	; 023047B8
	mov r1,#0x0	; 023047BA
	strh r1,[r0,#0x2]	; 023047BC
	bl loc_02300414	; 023047BE
loc_023047C2:
	add sp,#0x8	; 023047C2
	pop {r4}	; 023047C4
	pop {r3}	; 023047C6
	bx r3	; 023047C8
	.byte 0xC0, 0x46	; 023047CC
pool_023047CC:
loc_023047CC:
	.word 0x00001518	; 023047CC

; ===== function loc_023047D0 =====
	push {r4,r5,lr}	; 023047D0
	sub sp,#0x1fc	; 023047D2
	sub sp,#0x8	; 023047D4
	bl loc_023008B4	; 023047D6
	ldr r1,[pool_02304840]	; 023047DA
	ldr r5,[r0,r1]	; 023047DC
	ldr r0,[r5,#0x0]	; 023047DE
	ldrh r0,[r0,#0x0]	; 023047E0
	cmp r0,#0x2	; 023047E2
	beq loc_023047F8	; 023047E4
	bl loc_02300404	; 023047E6
	mov r1,#0x6	; 023047EA
	strh r1,[r0,#0x0]	; 023047EC
	mov r1,#0x3	; 023047EE
	strh r1,[r0,#0x2]	; 023047F0
	bl loc_02300414	; 023047F2
	b loc_02304836	; 023047F6
loc_023047F8:
	add r0,sp,#0x0	; 023047F8
	bl loc_0230196C	; 023047FA
	add r4,r0,#0x0	; 023047FE
	ldrh r0,[r4,#0x4]	; 02304800
	cmp r0,#0x0	; 02304802
	beq loc_02304820	; 02304804
	bl loc_02300404	; 02304806
	mov r1,#0x6	; 0230480A
	strh r1,[r0,#0x0]	; 0230480C
	mov r1,#0x1	; 0230480E
	strh r1,[r0,#0x2]	; 02304810
	ldr r1,[pool_02304844]	; 02304812
	strh r1,[r0,#0x4]	; 02304814
	ldrh r1,[r4,#0x4]	; 02304816
	strh r1,[r0,#0x6]	; 02304818
	bl loc_02300414	; 0230481A
	b loc_02304836	; 0230481E
loc_02304820:
	mov r1,#0x1	; 02304820
	ldr r0,[r5,#0x0]	; 02304822
	strh r1,[r0,#0x0]	; 02304824
	bl loc_02300404	; 02304826
	mov r1,#0x6	; 0230482A
	strh r1,[r0,#0x0]	; 0230482C
	mov r1,#0x0	; 0230482E
	strh r1,[r0,#0x2]	; 02304830
	bl loc_02300414	; 02304832
loc_02304836:
	add sp,#0x1fc	; 02304836
	add sp,#0x8	; 02304838
	pop {r4,r5}	; 0230483A
	pop {r3}	; 0230483C
	bx r3	; 0230483E
pool_02304840:
loc_02304840:
	.word 0x00001518	; 02304840
pool_02304844:
loc_02304844:
	.word 0x00000301	; 02304844

; ===== function loc_02304848 =====
	push {r4,r5,lr}	; 02304848
	sub sp,#0x4	; 0230484A
	add r4,r0,#0x0	; 0230484C
	bl loc_023008B4	; 0230484E
	ldr r1,[pool_02304890]	; 02304852
	ldr r0,[r0,r1]	; 02304854
	ldr r5,[r0,#0x0]	; 02304856
	ldr r0,[r4,#0x4]	; 02304858
	lsl r0,r0,#0x10	; 0230485A
	lsr r4,r0,#0x10	; 0230485C
	cmp r4,#0x0	; 0230485E
	bne loc_02304864	; 02304860
	mov r4,#0x10	; 02304862
loc_02304864:
	bl loc_02304894	; 02304864
	strh r4,[r5,#0x3c]	; 02304868
	ldrh r1,[r5,#0x3e]	; 0230486A
	cmp r1,r4	; 0230486C
	bls loc_02304872	; 0230486E
	strh r4,[r5,#0x3e]	; 02304870
loc_02304872:
	bl loc_023048A0	; 02304872
	bl loc_02300404	; 02304876
	mov r1,#0x23	; 0230487A
	strh r1,[r0,#0x0]	; 0230487C
	mov r1,#0x0	; 0230487E
	strh r1,[r0,#0x2]	; 02304880
	bl loc_02300414	; 02304882
	add sp,#0x4	; 02304886
	pop {r4,r5}	; 02304888
	pop {r3}	; 0230488A
	bx r3	; 0230488C
	.byte 0xC0, 0x46	; 02304890
pool_02304890:
loc_02304890:
	.word 0x00001518	; 02304890

; ===== function loc_02304894 =====
loc_02304894:
	bx pc	; 02304894
	.byte 0xC0, 0x46	; 02304898
.arm

; ===== function loc_02304898 =====
loc_02304898:
	ldr pc,[pool_0230489C]	; 02304898
pool_0230489C:
loc_0230489C:
	.word loc_037FCBF0	; 0230489C
.thumb

; ===== function loc_023048A0 =====
loc_023048A0:
	bx pc	; 023048A0
	.byte 0xC0, 0x46	; 023048A4
.arm

; ===== function loc_023048A4 =====
loc_023048A4:
	ldr pc,[pool_023048A8]	; 023048A4
pool_023048A8:
loc_023048A8:
	.word loc_037FCC04	; 023048A8
.thumb
	mov r1,#0x1	; 023048AC
	ldr r3,[pool_023048B4]	; 023048AE
	bx r3	; 023048B0
	.byte 0xC0, 0x46	; 023048B4
pool_023048B4:
loc_023048B4:
	.word loc_02302B30 + 1	; 023048B4

; ===== function loc_023048B8 =====
loc_023048B8:
; 保存参数中的无线工作区指针，初始化状态并开启 Wi-Fi 总线。
; Stores the supplied wireless work pointer, initializes state and enables the Wi-Fi bus.
.func P4_InitializeWirelessWork
	push {r4,r5,lr}	; 023048B8
	sub sp,#0x14	; 023048BA
	add r4,r0,#0x0	; 023048BC
	ldr r1,[r4,#0x0]	; 023048BE
	ldr r0,[pool_023049F4]	; 023048C0
	str r1,[r0,#0x0]	; 023048C2
	mov r0,#0x0	; 023048C4
	str r0,[sp,#0xc]	; 023048C6
	ldr r0,[sp,#0xc]	; 023048C8
	ldr r2,[pool_023049F8]	; 023048CA
	bl loc_02304A2C	; 023048CC
	bl loc_02304A38	; 023048D0
	ldr r1,[pool_023049F4]	; 023048D4
	ldr r3,[r1,#0x0]	; 023048D6
	ldr r2,[pool_023049FC]	; 023048D8
	str r0,[r3,r2]	; 023048DA
	ldr r3,[r4,#0x18]	; 023048DC
	ldr r2,[r1,#0x0]	; 023048DE
	ldr r0,[pool_02304A00]	; 023048E0
	str r3,[r2,r0]	; 023048E2
	ldr r0,[r4,#0x1c]	; 023048E4
	lsr r3,r0,#0x1	; 023048E6
	ldr r2,[r1,#0x0]	; 023048E8
	ldr r0,[pool_02304A04]	; 023048EA
	str r3,[r2,r0]	; 023048EC
	ldr r1,[r1,#0x0]	; 023048EE
	add r1,r1,r0	; 023048F0
	ldr r0,[r1,#0x0]	; 023048F2
	cmp r0,#0x0	; 023048F4
	bne loc_023048FE	; 023048F6
	mov r0,#0x0	; 023048F8
	mvn r0,r0	; 023048FA
	str r0,[r1,#0x0]	; 023048FC
loc_023048FE:
	add r0,r4,#0x0	; 023048FE
	add r0,#0x20	; 02304900
	bl loc_02304D70	; 02304902
	bl loc_023100BC	; 02304906
	ldr r2,[pool_02304A08]	; 0230490A
	ldrh r0,[r2,#0x0]	; 0230490C
	mov r1,#0x2	; 0230490E
	orr r0,r1	; 02304910
	strh r0,[r2,#0x0]	; 02304912
	mov r2,#0x30	; 02304914
	ldr r0,[pool_02304A0C]	; 02304916
	strh r2,[r0,#0x0]	; 02304918
	mov r5,#0x3	; 0230491A
	ldr r3,[pool_023049F4]	; 0230491C
	ldr r2,[r3,#0x0]	; 0230491E
	ldr r0,[pool_02304A10]	; 02304920
	str r5,[r2,r0]	; 02304922
	mov r0,#0x3c	; 02304924
	ldr r3,[r3,#0x0]	; 02304926
	ldr r2,[pool_02304A14]	; 02304928
	add r2,r3,r2	; 0230492A
	bl loc_0231019C	; 0230492C
	mov r0,#0x3e	; 02304930
	mov r1,#0x2	; 02304932
	ldr r2,[pool_023049F4]	; 02304934
	ldr r3,[r2,#0x0]	; 02304936
	ldr r2,[pool_02304A18]	; 02304938
	add r2,r3,r2	; 0230493A
	bl loc_0231019C	; 0230493C
	ldr r2,[r4,#0x10]	; 02304940
	ldr r3,[pool_023049F4]	; 02304942
	ldr r1,[r3,#0x0]	; 02304944
	ldr r0,[pool_02304A1C]	; 02304946
	str r2,[r1,r0]	; 02304948
	ldr r2,[r4,#0x14]	; 0230494A
	ldr r1,[r3,#0x0]	; 0230494C
	ldr r0,[pool_02304A20]	; 0230494E
	str r2,[r1,r0]	; 02304950
	ldr r0,[r4,#0x30]	; 02304952
	mov r1,#0x1c	; 02304954
	bl loc_02304A44	; 02304956
	add r1,r0,#0x0	; 0230495A
	ldr r0,[r4,#0x2c]	; 0230495C
	bl loc_02307340	; 0230495E
	bl loc_02304C84	; 02304962
	bl loc_0230951C	; 02304966
	bl loc_023097FC	; 0230496A
	bl loc_02308E1C	; 0230496E
	bl loc_023057D0	; 02304972
	add r0,sp,#0x8	; 02304976
	bl loc_02310210	; 02304978
	cmp r0,#0x0	; 0230497C
	beq loc_02304992	; 0230497E
	ldr r0,[pool_023049F4]	; 02304980
	ldr r1,[r0,#0x0]	; 02304982
	ldr r0,[pool_02304A24]	; 02304984
	add r2,r1,r0	; 02304986
	ldrh r1,[r2,#0x0]	; 02304988
	mov r0,#0x80	; 0230498A
	orr r1,r0	; 0230498C
	strh r1,[r2,#0x0]	; 0230498E
	b loc_023049BE	; 02304990
loc_02304992:
	bl loc_023059AC	; 02304992
	bl loc_02307670	; 02304996
	bl loc_02306748	; 0230499A
	bl loc_02305984	; 0230499E
	bl loc_0230582C	; 023049A2
	bl loc_023075F8	; 023049A6
	bl loc_023075A4	; 023049AA
	bl loc_023073D0	; 023049AE
	bl loc_02305944	; 023049B2
	bl loc_02306AF0	; 023049B6
	bl loc_023067B0	; 023049BA
loc_023049BE:
	ldr r0,[r4,#0x8]	; 023049BE
	str r0,[sp,#0x0]	; 023049C0
	ldr r0,[r4,#0xc]	; 023049C2
	str r0,[sp,#0x4]	; 023049C4
	ldr r0,[pool_023049F4]	; 023049C6
	ldr r0,[r0,#0x0]	; 023049C8
	add r0,#0x18	; 023049CA
	ldr r1,[pool_02304A28]	; 023049CC
	mov r2,#0x0	; 023049CE
	ldr r3,[r4,#0x4]	; 023049D0
	bl loc_023009E0	; 023049D2
	ldr r0,[pool_023049F4]	; 023049D6
	ldr r0,[r0,#0x0]	; 023049D8
	add r0,#0x18	; 023049DA
	bl loc_023009F0	; 023049DC
	bl loc_02307724	; 023049E0
	ldr r0,[pool_023049F4]	; 023049E4
	ldr r1,[r0,#0x0]	; 023049E6
	ldr r0,[pool_02304A24]	; 023049E8
	ldrh r0,[r1,r0]	; 023049EA
	add sp,#0x14	; 023049EC
	pop {r4,r5}	; 023049EE
	pop {r3}	; 023049F0
	bx r3	; 023049F2
.endfunc
pool_023049F4:
loc_023049F4:
	.word FirmwareWlWorkPointerSlot	; 023049F4
pool_023049F8:
loc_023049F8:
	.word 0x00000678	; 023049F8
pool_023049FC:
loc_023049FC:
	.word 0x000002D8	; 023049FC
pool_02304A00:
loc_02304A00:
	.word 0x000002D0	; 02304A00
pool_02304A04:
loc_02304A04:
	.word 0x000002D4	; 02304A04
pool_02304A08:
loc_02304A08:
	.word REG_POWERCNT_ARM7	; 02304A08
pool_02304A0C:
loc_02304A0C:
	.word REG_WIFIWAITCNT_ARM7	; 02304A0C
pool_02304A10:
loc_02304A10:
	.word 0x00000618	; 02304A10
pool_02304A14:
loc_02304A14:
	.word 0x0000061E	; 02304A14
pool_02304A18:
loc_02304A18:
	.word 0x0000061C	; 02304A18
pool_02304A1C:
loc_02304A1C:
	.word 0x000002CC	; 02304A1C
pool_02304A20:
loc_02304A20:
	.word 0x000002C8	; 02304A20
pool_02304A24:
loc_02304A24:
	.word 0x00000302	; 02304A24
pool_02304A28:
loc_02304A28:
	.word P4_ThreadEntry_02304BF8 + 1	; 02304A28

; ===== function loc_02304A2C =====
loc_02304A2C:
	bx pc	; 02304A2C
	.byte 0xC0, 0x46	; 02304A30
.arm

; ===== function loc_02304A30 =====
loc_02304A30:
	ldr pc,[pool_02304A34]	; 02304A30
pool_02304A34:
loc_02304A34:
	.word P2_Entry_037FCE64	; 02304A34
.thumb

; ===== function loc_02304A38 =====
loc_02304A38:
	bx pc	; 02304A38
	.byte 0xC0, 0x46	; 02304A3C
.arm

; ===== function loc_02304A3C =====
loc_02304A3C:
	ldr pc,[pool_02304A40]	; 02304A3C
pool_02304A40:
loc_02304A40:
	.word loc_037FB6B4	; 02304A40
.thumb

; ===== function loc_02304A44 =====
loc_02304A44:
	bx pc	; 02304A44
	.byte 0xC0, 0x46	; 02304A48
.arm

; ===== function loc_02304A48 =====
loc_02304A48:
	ldr pc,[pool_02304A4C]	; 02304A48
pool_02304A4C:
loc_02304A4C:
	.word loc_03802720	; 02304A4C
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xF0, 0x9C, 0xFD, 0x01, 0xF0, 0xAA, 0xFE, 0x00, 0xF0, 0x92, 0xFF	; 02304A60
	.byte 0x00, 0xF0, 0x5A, 0xF9, 0x00, 0xF0, 0x0E, 0xF9, 0x09, 0x48, 0x02, 0x68, 0x09, 0x48, 0x10, 0x58	; 02304A70
	.byte 0x09, 0x49, 0x51, 0x5A, 0x02, 0xF0, 0x64, 0xFC, 0x04, 0xF0, 0x50, 0xFD, 0x04, 0xF0, 0xBE, 0xFE	; 02304A80
	.byte 0x04, 0xF0, 0xCC, 0xF9, 0x02, 0xF0, 0x34, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02304A90
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xE0, 0x02, 0x00, 0x00, 0xE4, 0x02, 0x00, 0x00	; 02304A9C
.thumb

; ===== function loc_02304A9C =====
loc_02304A9C:
	push {lr}	; 02304A9C
	sub sp,#0x4	; 02304A9E
	ldr r1,[r0,#0x0]	; 02304AA0
	cmp r1,#0x0	; 02304AA2
	beq loc_02304ABA	; 02304AA4
	ldr r0,[pool_02304AC0]	; 02304AA6
	ldr r2,[r0,#0x0]	; 02304AA8
	ldr r0,[pool_02304AC4]	; 02304AAA
	add r0,r2,r0	; 02304AAC
	bl loc_02304F58	; 02304AAE
	mov r0,#0x2	; 02304AB2
	mov r1,#0xb	; 02304AB4
	bl loc_02304B6C	; 02304AB6
loc_02304ABA:
	add sp,#0x4	; 02304ABA
	pop {r3}	; 02304ABC
	bx r3	; 02304ABE
pool_02304AC0:
loc_02304AC0:
	.word FirmwareWlWorkPointerSlot	; 02304AC0
pool_02304AC4:
loc_02304AC4:
	.word 0x000001C4	; 02304AC4

; ===== function loc_02304AC8 =====
	push {lr}	; 02304AC8
	sub sp,#0x4	; 02304ACA
	ldr r0,[pool_02304AF0]	; 02304ACC
	ldr r1,[r0,#0x0]	; 02304ACE
	ldr r0,[pool_02304AF4]	; 02304AD0
	ldr r0,[r1,r0]	; 02304AD2
	add r1,sp,#0x0	; 02304AD4
	mov r2,#0x1	; 02304AD6
	bl loc_02300884	; 02304AD8
	add r0,sp,#0x0	; 02304ADC
	bl loc_02304A9C	; 02304ADE
	mov r0,#0x3	; 02304AE2
	mov r1,#0xc	; 02304AE4
	bl loc_02304B6C	; 02304AE6
	add sp,#0x4	; 02304AEA
	pop {r3}	; 02304AEC
	bx r3	; 02304AEE
pool_02304AF0:
loc_02304AF0:
	.word FirmwareWlWorkPointerSlot	; 02304AF0
pool_02304AF4:
loc_02304AF4:
	.word 0x000002CC	; 02304AF4

; ===== function loc_02304AF8 =====
loc_02304AF8:
	push {r4,r5,r6,r7,lr}	; 02304AF8
	sub sp,#0x4	; 02304AFA
	add r4,r0,#0x0	; 02304AFC
	ldr r0,[pool_02304B40]	; 02304AFE
	ldr r5,[r0,#0x0]	; 02304B00
	ldr r0,[pool_02304B44]	; 02304B02
	bl loc_02304B4C	; 02304B04
	add r7,r0,#0x0	; 02304B08
	lsl r0,r4,#0x1	; 02304B0A
	add r6,r5,r0	; 02304B0C
	ldrh r4,[r5,r0]	; 02304B0E
	ldr r0,[pool_02304B48]	; 02304B10
	cmp r4,r0	; 02304B12
	beq loc_02304B30	; 02304B14
	add r5,#0x90	; 02304B16
	lsl r3,r4,#0x3	; 02304B18
	mov r2,#0x0	; 02304B1A
	add r1,r5,r3	; 02304B1C
	strh r2,[r1,#0x2]	; 02304B1E
	ldrh r1,[r5,r3]	; 02304B20
	cmp r1,r0	; 02304B22
	bne loc_02304B2C	; 02304B24
	strh r0,[r6,#0x0]	; 02304B26
	strh r0,[r6,#0x8]	; 02304B28
	b loc_02304B30	; 02304B2A
loc_02304B2C:
	strh r1,[r6,#0x0]	; 02304B2C
	strh r0,[r5,r3]	; 02304B2E
loc_02304B30:
	add r0,r7,#0x0	; 02304B30
	bl loc_02304B5C	; 02304B32
	add r0,r4,#0x0	; 02304B36
	add sp,#0x4	; 02304B38
	pop {r4,r5,r6,r7}	; 02304B3A
	pop {r3}	; 02304B3C
	bx r3	; 02304B3E
pool_02304B40:
loc_02304B40:
	.word FirmwareWlWorkPointerSlot	; 02304B40
pool_02304B44:
loc_02304B44:
	.word 0x01000010	; 02304B44
pool_02304B48:
loc_02304B48:
	.word 0x0000FFFF	; 02304B48

; ===== function loc_02304B4C =====
loc_02304B4C:
	bx pc	; 02304B4C
	.byte 0xC0, 0x46	; 02304B50
.arm

; ===== function loc_02304B50 =====
loc_02304B50:
	ldr r12,[pool_02304B58]	; 02304B50
	bx r12	; 02304B54
pool_02304B58:
loc_02304B58:
	.word loc_037FB570 + 1	; 02304B58
.thumb

; ===== function loc_02304B5C =====
loc_02304B5C:
	bx pc	; 02304B5C
	.byte 0xC0, 0x46	; 02304B60
.arm

; ===== function loc_02304B60 =====
loc_02304B60:
	ldr r12,[pool_02304B68]	; 02304B60
	bx r12	; 02304B64
pool_02304B68:
loc_02304B68:
	.word loc_037FB59C + 1	; 02304B68
.thumb

; ===== function loc_02304B6C =====
loc_02304B6C:
	push {r4,r5,r6,r7,lr}	; 02304B6C
	sub sp,#0x4	; 02304B6E
	add r5,r0,#0x0	; 02304B70
	add r6,r1,#0x0	; 02304B72
	ldr r0,[pool_02304BE8]	; 02304B74
	ldr r4,[r0,#0x0]	; 02304B76
	add r7,r4,#0x0	; 02304B78
	add r7,#0x90	; 02304B7A
	ldr r0,[pool_02304BEC]	; 02304B7C
	bl loc_02304B4C	; 02304B7E
	str r0,[sp,#0x0]	; 02304B82
	lsl r1,r6,#0x3	; 02304B84
	add r2,r7,#0x2	; 02304B86
	add r0,r2,r1	; 02304B88
	ldrh r2,[r2,r1]	; 02304B8A
	cmp r2,#0x0	; 02304B8C
	bne loc_02304BBE	; 02304B8E
	mov r2,#0x1	; 02304B90
	strh r2,[r0,#0x0]	; 02304B92
	ldr r0,[pool_02304BF0]	; 02304B94
	strh r0,[r7,r1]	; 02304B96
	lsl r0,r5,#0x1	; 02304B98
	add r2,r4,#0x0	; 02304B9A
	add r2,#0x8	; 02304B9C
	add r1,r2,r0	; 02304B9E
	ldrh r3,[r2,r0]	; 02304BA0
	ldr r2,[pool_02304BF0]	; 02304BA2
	cmp r3,r2	; 02304BA4
	bne loc_02304BAC	; 02304BA6
	strh r6,[r4,r0]	; 02304BA8
	b loc_02304BB4	; 02304BAA
loc_02304BAC:
	lsl r0,r3,#0x3	; 02304BAC
	add r0,r4,r0	; 02304BAE
	add r0,#0x90	; 02304BB0
	strh r6,[r0,#0x0]	; 02304BB2
loc_02304BB4:
	strh r6,[r1,#0x0]	; 02304BB4
	ldrh r0,[r4,#0x10]	; 02304BB6
	cmp r5,r0	; 02304BB8
	bge loc_02304BBE	; 02304BBA
	strh r5,[r4,#0x10]	; 02304BBC
loc_02304BBE:
	ldr r0,[sp,#0x0]	; 02304BBE
	bl loc_02304B5C	; 02304BC0
	cmp r5,#0x3	; 02304BC4
	beq loc_02304BDE	; 02304BC6
	ldrh r0,[r4,#0x12]	; 02304BC8
	cmp r0,#0x3	; 02304BCA
	bne loc_02304BDE	; 02304BCC
	ldr r0,[pool_02304BE8]	; 02304BCE
	ldr r1,[r0,#0x0]	; 02304BD0
	ldr r0,[pool_02304BF4]	; 02304BD2
	ldr r0,[r1,r0]	; 02304BD4
	mov r1,#0x0	; 02304BD6
	add r2,r1,#0x0	; 02304BD8
	bl loc_02300824	; 02304BDA
loc_02304BDE:
	add sp,#0x4	; 02304BDE
	pop {r4,r5,r6,r7}	; 02304BE0
	pop {r3}	; 02304BE2
	bx r3	; 02304BE4
	.byte 0xC0, 0x46	; 02304BE8
pool_02304BE8:
loc_02304BE8:
	.word FirmwareWlWorkPointerSlot	; 02304BE8
pool_02304BEC:
loc_02304BEC:
	.word 0x01000010	; 02304BEC
pool_02304BF0:
loc_02304BF0:
	.word 0x0000FFFF	; 02304BF0
pool_02304BF4:
loc_02304BF4:
	.word 0x000002CC	; 02304BF4

; ===== function loc_02304BF8 =====
P4_ThreadEntry_02304BF8:
	push {r4,r5,r6,r7,lr}	; 02304BF8
	sub sp,#0x4	; 02304BFA
	ldr r6,[pool_02304C64]	; 02304BFC
	ldr r5,[r6,#0x0]	; 02304BFE
	mov r0,#0x0	; 02304C00
	strh r0,[r5,#0x10]	; 02304C02
	strh r0,[r5,#0x14]	; 02304C04
	ldr r4,[pool_02304C68]	; 02304C06
	ldr r7,[pool_02304C6C]	; 02304C08
loc_02304C0A:
	ldr r0,[r6,#0x0]	; 02304C0A
	ldr r0,[r0,r7]	; 02304C0C
	add r1,sp,#0x0	; 02304C0E
	mov r2,#0x0	; 02304C10
	bl loc_02300884	; 02304C12
	cmp r0,#0x0	; 02304C16
	beq loc_02304C20	; 02304C18
	add r0,sp,#0x0	; 02304C1A
	bl loc_02304A9C	; 02304C1C
loc_02304C20:
	ldr r0,[pool_02304C70]	; 02304C20
	bl loc_02304B4C	; 02304C22
	ldrh r1,[r5,#0x10]	; 02304C26
	strh r1,[r5,#0x12]	; 02304C28
	ldrh r1,[r5,#0x12]	; 02304C2A
	lsl r1,r1,#0x1	; 02304C2C
	ldrh r1,[r5,r1]	; 02304C2E
	cmp r1,r4	; 02304C30
	bne loc_02304C44	; 02304C32
	add r1,r5,#0x0	; 02304C34
	add r1,#0x10	; 02304C36
	ldrh r2,[r1,#0x0]	; 02304C38
	add r2,r2,#0x1	; 02304C3A
	strh r2,[r1,#0x0]	; 02304C3C
	bl loc_02304B5C	; 02304C3E
	b loc_02304C0A	; 02304C42
loc_02304C44:
	bl loc_02304B5C	; 02304C44
	ldrh r0,[r5,#0x12]	; 02304C48
	bl loc_02304AF8	; 02304C4A
	strh r0,[r5,#0x14]	; 02304C4E
	ldrh r0,[r5,#0x14]	; 02304C50
	lsl r0,r0,#0x3	; 02304C52
	add r0,r5,r0	; 02304C54
	add r0,#0x94	; 02304C56
	ldr r0,[r0,#0x0]	; 02304C58
	bl loc_02304C74	; 02304C5A
	strh r4,[r5,#0x14]	; 02304C5E
	b loc_02304C0A	; 02304C60
	.byte 0xC0, 0x46	; 02304C64
pool_02304C64:
loc_02304C64:
	.word FirmwareWlWorkPointerSlot	; 02304C64
pool_02304C68:
loc_02304C68:
	.word 0x0000FFFF	; 02304C68
pool_02304C6C:
loc_02304C6C:
	.word 0x000002CC	; 02304C6C
pool_02304C70:
loc_02304C70:
	.word 0x01000010	; 02304C70

; ===== function loc_02304C74 =====
loc_02304C74:
	bx pc	; 02304C74
	.byte 0xC0, 0x46	; 02304C78
.arm

; ===== function loc_02304C78 =====
loc_02304C78:
	ldr r12,[pool_02304C80]	; 02304C78
	bx r12	; 02304C7C
pool_02304C80:
loc_02304C80:
	.word loc_038029F4 + 1	; 02304C80
.thumb

; ===== function loc_02304C84 =====
loc_02304C84:
	push {r4,r5,r6,lr}	; 02304C84
	ldr r0,[pool_02304CD8]	; 02304C86
	ldr r5,[r0,#0x0]	; 02304C88
	mov r3,#0x0	; 02304C8A
	strh r3,[r5,#0x10]	; 02304C8C
	strh r3,[r5,#0x12]	; 02304C8E
	ldr r1,[pool_02304CDC]	; 02304C90
loc_02304C92:
	lsl r2,r3,#0x1	; 02304C92
	add r0,r5,r2	; 02304C94
	strh r1,[r0,#0x8]	; 02304C96
	ldrh r0,[r0,#0x8]	; 02304C98
	strh r0,[r5,r2]	; 02304C9A
	add r3,r3,#0x1	; 02304C9C
	cmp r3,#0x4	; 02304C9E
	bcc loc_02304C92	; 02304CA0
	mov r4,#0x0	; 02304CA2
	ldr r2,[pool_02304CDC]	; 02304CA4
	add r1,r4,#0x0	; 02304CA6
	ldr r0,[pool_02304CE0]	; 02304CA8
loc_02304CAA:
	lsl r3,r4,#0x3	; 02304CAA
	add r3,r5,r3	; 02304CAC
	add r6,r3,#0x0	; 02304CAE
	add r6,#0x90	; 02304CB0
	strh r2,[r6,#0x0]	; 02304CB2
	add r6,r3,#0x0	; 02304CB4
	add r6,#0x92	; 02304CB6
	strh r1,[r6,#0x0]	; 02304CB8
	lsl r6,r4,#0x2	; 02304CBA
	ldr r6,[r0,r6]	; 02304CBC
	add r3,#0x94	; 02304CBE
	str r6,[r3,#0x0]	; 02304CC0
	add r4,r4,#0x1	; 02304CC2
	cmp r4,#0x16	; 02304CC4
	bcc loc_02304CAA	; 02304CC6
	mov r0,#0x3	; 02304CC8
	mov r1,#0xc	; 02304CCA
	bl loc_02304B6C	; 02304CCC
	pop {r4,r5,r6}	; 02304CD0
	pop {r3}	; 02304CD2
	bx r3	; 02304CD4
	.byte 0xC0, 0x46	; 02304CD8
pool_02304CD8:
loc_02304CD8:
	.word FirmwareWlWorkPointerSlot	; 02304CD8
pool_02304CDC:
loc_02304CDC:
	.word 0x0000FFFF	; 02304CDC
pool_02304CE0:
loc_02304CE0:
	.word P4_Data_02310320	; 02304CE0

; ===== function loc_02304CE4 =====
loc_02304CE4:
	push {r4,r5,r6,r7,lr}	; 02304CE4
	sub sp,#0x4	; 02304CE6
	add r6,r0,#0x0	; 02304CE8
	ldr r5,[r6,#0x0]	; 02304CEA
	ldrh r0,[r6,#0x8]	; 02304CEC
	cmp r0,#0x0	; 02304CEE
	beq loc_02304D0E	; 02304CF0
	mov r0,#0x0	; 02304CF2
	mvn r4,r0	; 02304CF4
	b loc_02304D0A	; 02304CF6
loc_02304CF8:
	add r0,r5,#0x0	; 02304CF8
	bl loc_02304E60	; 02304CFA
	add r7,r0,#0x0	; 02304CFE
	add r0,r6,#0x0	; 02304D00
	add r1,r5,#0x0	; 02304D02
	bl loc_02304FFC	; 02304D04
	add r5,r7,#0x0	; 02304D08
loc_02304D0A:
	cmp r5,r4	; 02304D0A
	bne loc_02304CF8	; 02304D0C
loc_02304D0E:
	add sp,#0x4	; 02304D0E
	pop {r4,r5,r6,r7}	; 02304D10
	pop {r3}	; 02304D12
	bx r3	; 02304D14
	.byte 0x00, 0x00	; 02304D18

; ===== function loc_02304D18 =====
loc_02304D18:
	push {r4,lr}	; 02304D18
	ldr r0,[pool_02304D68]	; 02304D1A
	ldr r1,[r0,#0x0]	; 02304D1C
	ldr r0,[pool_02304D6C]	; 02304D1E
	add r4,r1,r0	; 02304D20
	add r0,r4,#0x0	; 02304D22
	add r0,#0x18	; 02304D24
	bl loc_02304CE4	; 02304D26
	add r0,r4,#0x0	; 02304D2A
	add r0,#0x24	; 02304D2C
	bl loc_02304CE4	; 02304D2E
	add r0,r4,#0x0	; 02304D32
	add r0,#0x30	; 02304D34
	bl loc_02304CE4	; 02304D36
	add r0,r4,#0x0	; 02304D3A
	add r0,#0x3c	; 02304D3C
	bl loc_02304CE4	; 02304D3E
	add r0,r4,#0x0	; 02304D42
	add r0,#0x48	; 02304D44
	bl loc_02304CE4	; 02304D46
	add r0,r4,#0x0	; 02304D4A
	add r0,#0x54	; 02304D4C
	bl loc_02304CE4	; 02304D4E
	add r0,r4,#0x0	; 02304D52
	add r0,#0x60	; 02304D54
	bl loc_02304CE4	; 02304D56
	add r4,#0x6c	; 02304D5A
	add r0,r4,#0x0	; 02304D5C
	bl loc_02304CE4	; 02304D5E
	pop {r4}	; 02304D62
	pop {r3}	; 02304D64
	bx r3	; 02304D66
pool_02304D68:
loc_02304D68:
	.word FirmwareWlWorkPointerSlot	; 02304D68
pool_02304D6C:
loc_02304D6C:
	.word 0x00000140	; 02304D6C

; ===== function loc_02304D70 =====
loc_02304D70:
	push {r4,lr}	; 02304D70
	ldr r1,[pool_02304E3C]	; 02304D72
	ldr r2,[r1,#0x0]	; 02304D74
	ldr r1,[pool_02304E40]	; 02304D76
	add r4,r2,r1	; 02304D78
	ldr r1,[r0,#0x0]	; 02304D7A
	str r1,[r4,#0x0]	; 02304D7C
	ldr r1,[r0,#0x4]	; 02304D7E
	str r1,[r4,#0x4]	; 02304D80
	ldr r0,[r0,#0x8]	; 02304D82
	str r0,[r4,#0x8]	; 02304D84
	ldr r0,[r4,#0x0]	; 02304D86
	cmp r0,#0x0	; 02304D88
	beq loc_02304D92	; 02304D8A
	cmp r0,#0x1	; 02304D8C
	beq loc_02304DA6	; 02304D8E
	b loc_02304DB6	; 02304D90
loc_02304D92:
	ldr r0,[r4,#0x4]	; 02304D92
	ldr r1,[r4,#0x8]	; 02304D94
	mov r2,#0x81	; 02304D96
	bl loc_02301044	; 02304D98
	ldr r1,[pool_02304E3C]	; 02304D9C
	ldr r2,[r1,#0x0]	; 02304D9E
	ldr r1,[pool_02304E44]	; 02304DA0
	str r0,[r2,r1]	; 02304DA2
	b loc_02304DB6	; 02304DA4
loc_02304DA6:
	mov r0,#0x81	; 02304DA6
	ldr r1,[r4,#0x4]	; 02304DA8
	bl loc_02301870	; 02304DAA
	ldr r1,[pool_02304E3C]	; 02304DAE
	ldr r2,[r1,#0x0]	; 02304DB0
	ldr r1,[pool_02304E44]	; 02304DB2
	str r0,[r2,r1]	; 02304DB4
loc_02304DB6:
	mov r3,#0x0	; 02304DB6
	ldr r2,[pool_02304E3C]	; 02304DB8
	ldr r1,[r2,#0x0]	; 02304DBA
	ldr r0,[pool_02304E48]	; 02304DBC
	strh r3,[r1,r0]	; 02304DBE
	ldr r1,[r2,#0x0]	; 02304DC0
	ldr r0,[pool_02304E4C]	; 02304DC2
	strh r3,[r1,r0]	; 02304DC4
	add r0,r4,#0x0	; 02304DC6
	add r0,#0xc	; 02304DC8
	mov r1,#0x2	; 02304DCA
	bl loc_02304E50	; 02304DCC
	add r0,r4,#0x0	; 02304DD0
	add r0,#0x18	; 02304DD2
	mov r1,#0x3	; 02304DD4
	bl loc_02304E50	; 02304DD6
	add r0,r4,#0x0	; 02304DDA
	add r0,#0x24	; 02304DDC
	mov r1,#0x4	; 02304DDE
	bl loc_02304E50	; 02304DE0
	add r0,r4,#0x0	; 02304DE4
	add r0,#0x30	; 02304DE6
	mov r1,#0x5	; 02304DE8
	bl loc_02304E50	; 02304DEA
	add r0,r4,#0x0	; 02304DEE
	add r0,#0x3c	; 02304DF0
	mov r1,#0x6	; 02304DF2
	bl loc_02304E50	; 02304DF4
	add r0,r4,#0x0	; 02304DF8
	add r0,#0x48	; 02304DFA
	mov r1,#0x7	; 02304DFC
	bl loc_02304E50	; 02304DFE
	add r0,r4,#0x0	; 02304E02
	add r0,#0x54	; 02304E04
	mov r1,#0x8	; 02304E06
	bl loc_02304E50	; 02304E08
	add r0,r4,#0x0	; 02304E0C
	add r0,#0x60	; 02304E0E
	mov r1,#0x9	; 02304E10
	bl loc_02304E50	; 02304E12
	add r0,r4,#0x0	; 02304E16
	add r0,#0x6c	; 02304E18
	mov r1,#0xa	; 02304E1A
	bl loc_02304E50	; 02304E1C
	add r0,r4,#0x0	; 02304E20
	add r0,#0x78	; 02304E22
	mov r1,#0xb	; 02304E24
	bl loc_02304E50	; 02304E26
	add r4,#0x84	; 02304E2A
	add r0,r4,#0x0	; 02304E2C
	mov r1,#0xc	; 02304E2E
	bl loc_02304E50	; 02304E30
	pop {r4}	; 02304E34
	pop {r3}	; 02304E36
	bx r3	; 02304E38
	.byte 0xC0, 0x46	; 02304E3C
pool_02304E3C:
loc_02304E3C:
	.word FirmwareWlWorkPointerSlot	; 02304E3C
pool_02304E40:
loc_02304E40:
	.word 0x00000140	; 02304E40
pool_02304E44:
loc_02304E44:
	.word 0x00000398	; 02304E44
pool_02304E48:
loc_02304E48:
	.word 0x0000039C	; 02304E48
pool_02304E4C:
loc_02304E4C:
	.word 0x000003A0	; 02304E4C

; ===== function loc_02304E50 =====
loc_02304E50:
	mov r2,#0x0	; 02304E50
	mvn r3,r2	; 02304E52
	str r3,[r0,#0x0]	; 02304E54
	str r3,[r0,#0x4]	; 02304E56
	strh r2,[r0,#0x8]	; 02304E58
	strh r1,[r0,#0xa]	; 02304E5A
	bx lr	; 02304E5C
	.byte 0x00, 0x00	; 02304E60

; ===== function loc_02304E60 =====
loc_02304E60:
	ldr r0,[r0,#0x4]	; 02304E60
	bx lr	; 02304E62

; ===== function loc_02304E64 =====
loc_02304E64:
	push {r4,r5,lr}	; 02304E64
	sub sp,#0x4	; 02304E66
	add r5,r0,#0x0	; 02304E68
	add r4,r1,#0x0	; 02304E6A
	ldrh r1,[r4,#0xa]	; 02304E6C
	ldr r0,[pool_02304EEC]	; 02304E6E
	cmp r1,r0	; 02304E70
	beq loc_02304E78	; 02304E72
	mov r0,#0x1	; 02304E74
	b loc_02304EE2	; 02304E76
loc_02304E78:
	ldrh r1,[r4,#0x8]	; 02304E78
	ldrh r0,[r5,#0xa]	; 02304E7A
	cmp r1,r0	; 02304E7C
	beq loc_02304E84	; 02304E7E
	mov r0,#0x2	; 02304E80
	b loc_02304EE2	; 02304E82
loc_02304E84:
	ldr r0,[pool_02304EF0]	; 02304E84
	bl loc_02304B4C	; 02304E86
	add r2,r5,#0x0	; 02304E8A
	add r2,#0x8	; 02304E8C
	ldrh r1,[r2,#0x0]	; 02304E8E
	sub r1,r1,#0x1	; 02304E90
	strh r1,[r2,#0x0]	; 02304E92
	ldrh r1,[r5,#0x8]	; 02304E94
	cmp r1,#0x0	; 02304E96
	bne loc_02304EA4	; 02304E98
	mov r1,#0x0	; 02304E9A
	mvn r1,r1	; 02304E9C
	str r1,[r5,#0x0]	; 02304E9E
	str r1,[r5,#0x4]	; 02304EA0
	b loc_02304ED8	; 02304EA2
loc_02304EA4:
	ldr r1,[r5,#0x0]	; 02304EA4
	cmp r4,r1	; 02304EA6
	bne loc_02304EB8	; 02304EA8
	ldr r1,[r4,#0x4]	; 02304EAA
	str r1,[r5,#0x0]	; 02304EAC
	mov r1,#0x0	; 02304EAE
	mvn r2,r1	; 02304EB0
	ldr r1,[r5,#0x0]	; 02304EB2
	str r2,[r1,#0x0]	; 02304EB4
	b loc_02304ED8	; 02304EB6
loc_02304EB8:
	ldr r1,[r5,#0x4]	; 02304EB8
	cmp r4,r1	; 02304EBA
	bne loc_02304ECC	; 02304EBC
	ldr r1,[r4,#0x0]	; 02304EBE
	str r1,[r5,#0x4]	; 02304EC0
	mov r1,#0x0	; 02304EC2
	mvn r2,r1	; 02304EC4
	ldr r1,[r5,#0x4]	; 02304EC6
	str r2,[r1,#0x4]	; 02304EC8
	b loc_02304ED8	; 02304ECA
loc_02304ECC:
	ldr r2,[r4,#0x0]	; 02304ECC
	ldr r1,[r4,#0x4]	; 02304ECE
	str r2,[r1,#0x0]	; 02304ED0
	ldr r2,[r4,#0x4]	; 02304ED2
	ldr r1,[r4,#0x0]	; 02304ED4
	str r2,[r1,#0x4]	; 02304ED6
loc_02304ED8:
	mov r1,#0x0	; 02304ED8
	strh r1,[r4,#0x8]	; 02304EDA
	bl loc_02304B5C	; 02304EDC
	mov r0,#0x0	; 02304EE0
loc_02304EE2:
	add sp,#0x4	; 02304EE2
	pop {r4,r5}	; 02304EE4
	pop {r3}	; 02304EE6
	bx r3	; 02304EE8
	.byte 0xC0, 0x46	; 02304EEC
pool_02304EEC:
loc_02304EEC:
	.word 0x0000BF1D	; 02304EEC
pool_02304EF0:
loc_02304EF0:
	.word 0x01000000	; 02304EF0

; ===== function loc_02304EF4 =====
loc_02304EF4:
	push {r4,r5,lr}	; 02304EF4
	sub sp,#0x4	; 02304EF6
	add r5,r0,#0x0	; 02304EF8
	add r4,r1,#0x0	; 02304EFA
	ldrh r1,[r4,#0xa]	; 02304EFC
	ldr r0,[pool_02304F50]	; 02304EFE
	cmp r1,r0	; 02304F00
	beq loc_02304F08	; 02304F02
	mov r0,#0x1	; 02304F04
	b loc_02304F48	; 02304F06
loc_02304F08:
	ldrh r0,[r4,#0x8]	; 02304F08
	cmp r0,#0x0	; 02304F0A
	beq loc_02304F12	; 02304F0C
	mov r0,#0x2	; 02304F0E
	b loc_02304F48	; 02304F10
loc_02304F12:
	ldr r0,[pool_02304F54]	; 02304F12
	bl loc_02304B4C	; 02304F14
	ldrh r1,[r5,#0x8]	; 02304F18
	cmp r1,#0x0	; 02304F1A
	bne loc_02304F28	; 02304F1C
	mov r1,#0x0	; 02304F1E
	mvn r1,r1	; 02304F20
	str r1,[r4,#0x0]	; 02304F22
	str r4,[r5,#0x0]	; 02304F24
	b loc_02304F2E	; 02304F26
loc_02304F28:
	ldr r1,[r5,#0x4]	; 02304F28
	str r1,[r4,#0x0]	; 02304F2A
	str r4,[r1,#0x4]	; 02304F2C
loc_02304F2E:
	mov r1,#0x0	; 02304F2E
	mvn r1,r1	; 02304F30
	str r1,[r4,#0x4]	; 02304F32
	ldrh r1,[r5,#0xa]	; 02304F34
	strh r1,[r4,#0x8]	; 02304F36
	str r4,[r5,#0x4]	; 02304F38
	add r5,#0x8	; 02304F3A
	ldrh r1,[r5,#0x0]	; 02304F3C
	add r1,r1,#0x1	; 02304F3E
	strh r1,[r5,#0x0]	; 02304F40
	bl loc_02304B5C	; 02304F42
	mov r0,#0x0	; 02304F46
loc_02304F48:
	add sp,#0x4	; 02304F48
	pop {r4,r5}	; 02304F4A
	pop {r3}	; 02304F4C
	bx r3	; 02304F4E
pool_02304F50:
loc_02304F50:
	.word 0x0000BF1D	; 02304F50
pool_02304F54:
loc_02304F54:
	.word 0x01000000	; 02304F54

; ===== function loc_02304F58 =====
loc_02304F58:
	push {r4,r5,lr}	; 02304F58
	sub sp,#0x4	; 02304F5A
	add r5,r0,#0x0	; 02304F5C
	add r4,r1,#0x0	; 02304F5E
	ldr r0,[pool_02304FA4]	; 02304F60
	bl loc_02304B4C	; 02304F62
	ldrh r1,[r5,#0x8]	; 02304F66
	cmp r1,#0x0	; 02304F68
	bne loc_02304F76	; 02304F6A
	mov r1,#0x0	; 02304F6C
	mvn r1,r1	; 02304F6E
	str r1,[r4,#0x0]	; 02304F70
	str r4,[r5,#0x0]	; 02304F72
	b loc_02304F7C	; 02304F74
loc_02304F76:
	ldr r1,[r5,#0x4]	; 02304F76
	str r1,[r4,#0x0]	; 02304F78
	str r4,[r1,#0x4]	; 02304F7A
loc_02304F7C:
	mov r1,#0x0	; 02304F7C
	mvn r1,r1	; 02304F7E
	str r1,[r4,#0x4]	; 02304F80
	ldrh r1,[r5,#0xa]	; 02304F82
	strh r1,[r4,#0x8]	; 02304F84
	ldr r1,[pool_02304FA8]	; 02304F86
	strh r1,[r4,#0xa]	; 02304F88
	str r4,[r5,#0x4]	; 02304F8A
	add r5,#0x8	; 02304F8C
	ldrh r1,[r5,#0x0]	; 02304F8E
	add r1,r1,#0x1	; 02304F90
	strh r1,[r5,#0x0]	; 02304F92
	bl loc_02304B5C	; 02304F94
	mov r0,#0x0	; 02304F98
	add sp,#0x4	; 02304F9A
	pop {r4,r5}	; 02304F9C
	pop {r3}	; 02304F9E
	bx r3	; 02304FA0
	.byte 0xC0, 0x46	; 02304FA4
pool_02304FA4:
loc_02304FA4:
	.word 0x01000000	; 02304FA4
pool_02304FA8:
loc_02304FA8:
	.word 0x0000BF1D	; 02304FA8

; ===== function loc_02304FAC =====
loc_02304FAC:
	push {r4,r5,r6,r7,lr}	; 02304FAC
	sub sp,#0x4	; 02304FAE
	add r4,r0,#0x0	; 02304FB0
	add r6,r1,#0x0	; 02304FB2
	add r5,r2,#0x0	; 02304FB4
	ldrh r1,[r5,#0xa]	; 02304FB6
	ldr r0,[pool_02304FF4]	; 02304FB8
	cmp r1,r0	; 02304FBA
	beq loc_02304FC2	; 02304FBC
	mov r0,#0x1	; 02304FBE
	b loc_02304FEA	; 02304FC0
loc_02304FC2:
	ldr r0,[pool_02304FF8]	; 02304FC2
	bl loc_02304B4C	; 02304FC4
	add r7,r0,#0x0	; 02304FC8
	add r0,r4,#0x0	; 02304FCA
	add r1,r5,#0x0	; 02304FCC
	bl loc_02304E64	; 02304FCE
	add r4,r0,#0x0	; 02304FD2
	cmp r4,#0x0	; 02304FD4
	bne loc_02304FE2	; 02304FD6
	add r0,r6,#0x0	; 02304FD8
	add r1,r5,#0x0	; 02304FDA
	bl loc_02304EF4	; 02304FDC
	add r4,r0,#0x0	; 02304FE0
loc_02304FE2:
	add r0,r7,#0x0	; 02304FE2
	bl loc_02304B5C	; 02304FE4
	add r0,r4,#0x0	; 02304FE8
loc_02304FEA:
	add sp,#0x4	; 02304FEA
	pop {r4,r5,r6,r7}	; 02304FEC
	pop {r3}	; 02304FEE
	bx r3	; 02304FF0
	.byte 0xC0, 0x46	; 02304FF4
pool_02304FF4:
loc_02304FF4:
	.word 0x0000BF1D	; 02304FF4
pool_02304FF8:
loc_02304FF8:
	.word 0x01000000	; 02304FF8

; ===== function loc_02304FFC =====
loc_02304FFC:
	push {r4,r5,r6,lr}	; 02304FFC
	add r5,r1,#0x0	; 02304FFE
	ldr r2,[pool_02305048]	; 02305000
	ldr r3,[r2,#0x0]	; 02305002
	ldr r2,[pool_0230504C]	; 02305004
	add r4,r3,r2	; 02305006
	ldrh r3,[r5,#0xa]	; 02305008
	ldr r2,[pool_02305050]	; 0230500A
	cmp r3,r2	; 0230500C
	beq loc_02305014	; 0230500E
	mov r0,#0x1	; 02305010
	b loc_02305040	; 02305012
loc_02305014:
	bl loc_02304E64	; 02305014
	add r6,r0,#0x0	; 02305018
	cmp r6,#0x0	; 0230501A
	bne loc_0230503E	; 0230501C
	ldr r0,[r4,#0x0]	; 0230501E
	cmp r0,#0x0	; 02305020
	beq loc_0230502A	; 02305022
	cmp r0,#0x1	; 02305024
	beq loc_02305036	; 02305026
	b loc_0230503E	; 02305028
loc_0230502A:
	ldr r0,[r4,#0x4]	; 0230502A
	ldr r1,[r4,#0x8]	; 0230502C
	add r2,r5,#0x0	; 0230502E
	bl loc_02301694	; 02305030
	b loc_0230503E	; 02305034
loc_02305036:
	add r0,r5,#0x0	; 02305036
	ldr r1,[r4,#0x8]	; 02305038
	bl loc_02301870	; 0230503A
loc_0230503E:
	add r0,r6,#0x0	; 0230503E
loc_02305040:
	pop {r4,r5,r6}	; 02305040
	pop {r3}	; 02305042
	bx r3	; 02305044
	.byte 0xC0, 0x46	; 02305048
pool_02305048:
loc_02305048:
	.word FirmwareWlWorkPointerSlot	; 02305048
pool_0230504C:
loc_0230504C:
	.word 0x00000140	; 0230504C
pool_02305050:
loc_02305050:
	.word 0x0000BF1D	; 02305050

; ===== function loc_02305054 =====
loc_02305054:
	push {r4,r5,lr}	; 02305054
	sub sp,#0x4	; 02305056
	add r5,r0,#0x0	; 02305058
	ldr r0,[pool_023050B4]	; 0230505A
	ldr r2,[r0,#0x0]	; 0230505C
	ldr r0,[pool_023050B8]	; 0230505E
	add r3,r2,r0	; 02305060
	cmp r1,#0x0	; 02305062
	bne loc_0230506A	; 02305064
	mov r0,#0x0	; 02305066
	b loc_023050AA	; 02305068
loc_0230506A:
	add r2,r1,#0x0	; 0230506A
	add r2,#0xc	; 0230506C
	ldr r0,[r3,#0x0]	; 0230506E
	cmp r0,#0x0	; 02305070
	beq loc_0230507A	; 02305072
	cmp r0,#0x1	; 02305074
	beq loc_02305086	; 02305076
	b loc_02305090	; 02305078
loc_0230507A:
	ldr r0,[r3,#0x4]	; 0230507A
	ldr r1,[r3,#0x8]	; 0230507C
	bl loc_02301044	; 0230507E
	add r4,r0,#0x0	; 02305082
	b loc_02305090	; 02305084
loc_02305086:
	add r0,r2,#0x0	; 02305086
	ldr r1,[r3,#0x4]	; 02305088
	bl loc_02301870	; 0230508A
	add r4,r0,#0x0	; 0230508E
loc_02305090:
	cmp r4,#0x0	; 02305090
	beq loc_023050A8	; 02305092
	ldr r0,[pool_023050BC]	; 02305094
	strh r0,[r4,#0xa]	; 02305096
	mov r0,#0x0	; 02305098
	strh r0,[r4,#0x8]	; 0230509A
	add r0,r5,#0x0	; 0230509C
	add r1,r4,#0x0	; 0230509E
	bl loc_02304EF4	; 023050A0
	add r0,r4,#0x0	; 023050A4
	b loc_023050AA	; 023050A6
loc_023050A8:
	mov r0,#0x0	; 023050A8
loc_023050AA:
	add sp,#0x4	; 023050AA
	pop {r4,r5}	; 023050AC
	pop {r3}	; 023050AE
	bx r3	; 023050B0
	.byte 0xC0, 0x46	; 023050B4
pool_023050B4:
loc_023050B4:
	.word FirmwareWlWorkPointerSlot	; 023050B4
pool_023050B8:
loc_023050B8:
	.word 0x00000140	; 023050B8
pool_023050BC:
loc_023050BC:
	.word 0x0000BF1D	; 023050BC

; ===== function loc_023050C0 =====
	push {r4,r5,lr}	; 023050C0
	sub sp,#0x4	; 023050C2
	ldr r0,[pool_02305120]	; 023050C4
	ldr r1,[r0,#0x0]	; 023050C6
	ldr r0,[pool_02305124]	; 023050C8
	ldrh r0,[r1,r0]	; 023050CA
	cmp r0,#0x0	; 023050CC
	beq loc_02305118	; 023050CE
	ldr r0,[pool_02305128]	; 023050D0
	add r0,r1,r0	; 023050D2
	mov r1,#0x12	; 023050D4
	bl loc_02305054	; 023050D6
	add r4,r0,#0x0	; 023050DA
	cmp r4,#0x0	; 023050DC
	bne loc_023050E8	; 023050DE
	mov r0,#0x1	; 023050E0
	bl loc_02305134	; 023050E2
	b loc_02305118	; 023050E6
loc_023050E8:
	ldr r0,[pool_0230512C]	; 023050E8
	strh r0,[r4,#0xc]	; 023050EA
	mov r0,#0x1	; 023050EC
	strh r0,[r4,#0xe]	; 023050EE
	ldr r0,[pool_02305130]	; 023050F0
	bl loc_02304B4C	; 023050F2
	ldr r5,[pool_02305120]	; 023050F6
	ldr r2,[r5,#0x0]	; 023050F8
	ldr r1,[pool_02305124]	; 023050FA
	ldrh r2,[r2,r1]	; 023050FC
	strh r2,[r4,#0x10]	; 023050FE
	mov r3,#0x0	; 02305100
	ldr r2,[r5,#0x0]	; 02305102
	strh r3,[r2,r1]	; 02305104
	bl loc_02304B5C	; 02305106
	lsl r0,r5,#0	; 0230510A
	ldr r1,[r0,#0x0]	; 0230510C
	ldr r0,[pool_02305128]	; 0230510E
	add r0,r1,r0	; 02305110
	add r1,r4,#0x0	; 02305112
	bl loc_02309578	; 02305114
loc_02305118:
	add sp,#0x4	; 02305118
	pop {r4,r5}	; 0230511A
	pop {r3}	; 0230511C
	bx r3	; 0230511E
pool_02305120:
loc_02305120:
	.word FirmwareWlWorkPointerSlot	; 02305120
pool_02305124:
loc_02305124:
	.word 0x000003AC	; 02305124
pool_02305128:
loc_02305128:
	.word 0x0000014C	; 02305128
pool_0230512C:
loc_0230512C:
	.word 0x00000186	; 0230512C
pool_02305130:
loc_02305130:
	.word 0x01000000	; 02305130

; ===== function loc_02305134 =====
loc_02305134:
	push {r4,lr}	; 02305134
	add r4,r0,#0x0	; 02305136
	ldr r0,[pool_02305160]	; 02305138
	bl loc_02304B4C	; 0230513A
	ldr r1,[pool_02305164]	; 0230513E
	ldr r2,[r1,#0x0]	; 02305140
	ldr r1,[pool_02305168]	; 02305142
	add r2,r2,r1	; 02305144
	ldrh r1,[r2,#0x0]	; 02305146
	orr r1,r4	; 02305148
	strh r1,[r2,#0x0]	; 0230514A
	bl loc_02304B5C	; 0230514C
	mov r0,#0x2	; 02305150
	mov r1,#0x15	; 02305152
	bl loc_02304B6C	; 02305154
	pop {r4}	; 02305158
	pop {r3}	; 0230515A
	bx r3	; 0230515C
	.byte 0xC0, 0x46	; 02305160
pool_02305160:
loc_02305160:
	.word 0x01000000	; 02305160
pool_02305164:
loc_02305164:
	.word FirmwareWlWorkPointerSlot	; 02305164
pool_02305168:
loc_02305168:
	.word 0x000003AC	; 02305168

; ===== function loc_0230516C =====
loc_0230516C:
	push {r4,lr}	; 0230516C
	ldr r0,[pool_02305220]	; 0230516E
	ldr r1,[r0,#0x0]	; 02305170
	ldr r0,[pool_02305224]	; 02305172
	add r4,r1,r0	; 02305174
	ldr r0,[pool_02305228]	; 02305176
	ldrh r0,[r1,r0]	; 02305178
	cmp r0,#0x1	; 0230517A
	beq loc_02305186	; 0230517C
	cmp r0,#0x2	; 0230517E
	beq loc_023051B0	; 02305180
	cmp r0,#0x3	; 02305182
	b loc_023051E8	; 02305184
loc_02305186:
	add r0,r4,#0x0	; 02305186
	add r0,#0x78	; 02305188
	bl loc_02305294	; 0230518A
	cmp r0,#0x0	; 0230518E
	beq loc_0230519A	; 02305190
	bl loc_0230526C	; 02305192
	bl loc_0230C720	; 02305196
loc_0230519A:
	add r0,r4,#0x0	; 0230519A
	add r0,#0x28	; 0230519C
	bl loc_02305294	; 0230519E
	cmp r0,#0x0	; 023051A2
	beq loc_023051E8	; 023051A4
	add r0,r4,#0x0	; 023051A6
	add r0,#0x28	; 023051A8
	bl loc_02305238	; 023051AA
	b loc_023051E8	; 023051AE
loc_023051B0:
	add r0,r4,#0x0	; 023051B0
	add r0,#0x64	; 023051B2
	bl loc_02305294	; 023051B4
	add r0,r4,#0x0	; 023051B8
	add r0,#0x28	; 023051BA
	bl loc_02305294	; 023051BC
	cmp r0,#0x0	; 023051C0
	beq loc_023051E8	; 023051C2
	ldrh r0,[r4,#0x28]	; 023051C4
	cmp r0,#0x0	; 023051C6
	beq loc_023051CE	; 023051C8
	bl loc_0230526C	; 023051CA
loc_023051CE:
	ldr r0,[pool_02305220]	; 023051CE
	ldr r1,[r0,#0x0]	; 023051D0
	ldr r0,[pool_0230522C]	; 023051D2
	ldrh r0,[r1,r0]	; 023051D4
	bl loc_0230C014	; 023051D6
	ldr r0,[pool_02305220]	; 023051DA
	ldr r1,[r0,#0x0]	; 023051DC
	ldr r0,[pool_02305230]	; 023051DE
	add r1,r1,r0	; 023051E0
	ldrh r0,[r1,#0x0]	; 023051E2
	add r0,r0,#0x1	; 023051E4
	strh r0,[r1,#0x0]	; 023051E6
loc_023051E8:
	add r0,r4,#0x0	; 023051E8
	add r0,#0x14	; 023051EA
	bl loc_02305294	; 023051EC
	cmp r0,#0x0	; 023051F0
	beq loc_023051FC	; 023051F2
	add r0,r4,#0x0	; 023051F4
	add r0,#0x14	; 023051F6
	bl loc_02305238	; 023051F8
loc_023051FC:
	add r0,r4,#0x0	; 023051FC
	bl loc_02305294	; 023051FE
	cmp r0,#0x0	; 02305202
	beq loc_0230520C	; 02305204
	add r0,r4,#0x0	; 02305206
	bl loc_02305238	; 02305208
loc_0230520C:
	ldr r1,[pool_02305234]	; 0230520C
	ldrh r0,[r1,#0x0]	; 0230520E
	cmp r0,#0x0	; 02305210
	bne loc_02305218	; 02305212
	mov r0,#0x1	; 02305214
	strh r0,[r1,#0x0]	; 02305216
loc_02305218:
	pop {r4}	; 02305218
	pop {r3}	; 0230521A
	bx r3	; 0230521C
	.byte 0xC0, 0x46	; 02305220
pool_02305220:
loc_02305220:
	.word FirmwareWlWorkPointerSlot	; 02305220
pool_02305224:
loc_02305224:
	.word 0x000003E4	; 02305224
pool_02305228:
loc_02305228:
	.word 0x00000314	; 02305228
pool_0230522C:
loc_0230522C:
	.word 0x00000366	; 0230522C
pool_02305230:
loc_02305230:
	.word 0x000003B4	; 02305230
pool_02305234:
loc_02305234:
	.word REG_WIFI_MODE_RST	; 02305234

; ===== function loc_02305238 =====
loc_02305238:
	push {r4,lr}	; 02305238
	add r4,r0,#0x0	; 0230523A
	ldrh r0,[r4,#0x0]	; 0230523C
	cmp r0,#0x0	; 0230523E
	beq loc_0230525E	; 02305240
	bl loc_0230526C	; 02305242
	ldr r0,[r4,#0x8]	; 02305246
	ldr r1,[r4,#0xc]	; 02305248
	sub r1,#0x10	; 0230524A
	bl loc_0230D4DC	; 0230524C
	ldr r0,[pool_02305264]	; 02305250
	ldr r1,[r0,#0x0]	; 02305252
	ldr r0,[pool_02305268]	; 02305254
	add r1,r1,r0	; 02305256
	ldrh r0,[r1,#0x0]	; 02305258
	add r0,r0,#0x1	; 0230525A
	strh r0,[r1,#0x0]	; 0230525C
loc_0230525E:
	pop {r4}	; 0230525E
	pop {r3}	; 02305260
	bx r3	; 02305262
pool_02305264:
loc_02305264:
	.word FirmwareWlWorkPointerSlot	; 02305264
pool_02305268:
loc_02305268:
	.word 0x000003B4	; 02305268

; ===== function loc_0230526C =====
loc_0230526C:
	mov r1,#0x0	; 0230526C
	ldr r0,[pool_0230528C]	; 0230526E
	strh r1,[r0,#0x0]	; 02305270
	mov r2,#0x10	; 02305272
	ldr r1,[pool_02305290]	; 02305274
	b loc_02305284	; 02305276
loc_02305278:
	ldrh r0,[r1,#0x0]	; 02305278
	cmp r0,#0x0	; 0230527A
	beq loc_02305288	; 0230527C
	cmp r0,#0x9	; 0230527E
	beq loc_02305288	; 02305280
	sub r2,r2,#0x1	; 02305282
loc_02305284:
	cmp r2,#0x0	; 02305284
	bne loc_02305278	; 02305286
loc_02305288:
	bx lr	; 02305288
	.byte 0xC0, 0x46	; 0230528C
pool_0230528C:
loc_0230528C:
	.word REG_WIFI_MODE_RST	; 0230528C
pool_02305290:
loc_02305290:
	.word REG_WIFI_RF_STATUS	; 02305290

; ===== function loc_02305294 =====
loc_02305294:
	push {r4,lr}	; 02305294
	ldr r4,[r0,#0x8]	; 02305296
	sub r2,r4,#0x4	; 02305298
	ldrh r3,[r2,#0x0]	; 0230529A
	ldr r1,[pool_023052D8]	; 0230529C
	cmp r3,r1	; 0230529E
	bne loc_023052AA	; 023052A0
	ldrh r3,[r2,#0x2]	; 023052A2
	ldr r1,[pool_023052DC]	; 023052A4
	cmp r3,r1	; 023052A6
	beq loc_023052D0	; 023052A8
loc_023052AA:
	mov r1,#0x1	; 023052AA
	strh r1,[r4,#0xa]	; 023052AC
	ldr r4,[pool_023052D8]	; 023052AE
	strh r4,[r2,#0x0]	; 023052B0
	ldr r3,[pool_023052DC]	; 023052B2
	strh r3,[r2,#0x2]	; 023052B4
	ldr r0,[r0,#0x8]	; 023052B6
	add r0,#0xc	; 023052B8
	strh r4,[r0,#0x0]	; 023052BA
	strh r3,[r0,#0x2]	; 023052BC
	ldr r0,[pool_023052E0]	; 023052BE
	ldr r2,[r0,#0x0]	; 023052C0
	ldr r0,[pool_023052E4]	; 023052C2
	add r2,r2,r0	; 023052C4
	ldrh r0,[r2,#0x0]	; 023052C6
	add r0,r0,#0x1	; 023052C8
	strh r0,[r2,#0x0]	; 023052CA
	add r0,r1,#0x0	; 023052CC
	b loc_023052D2	; 023052CE
loc_023052D0:
	mov r0,#0x0	; 023052D0
loc_023052D2:
	pop {r4}	; 023052D2
	pop {r3}	; 023052D4
	bx r3	; 023052D6
pool_023052D8:
loc_023052D8:
	.word 0x0000B6B8	; 023052D8
pool_023052DC:
loc_023052DC:
	.word 0x00001D46	; 023052DC
pool_023052E0:
loc_023052E0:
	.word FirmwareWlWorkPointerSlot	; 023052E0
pool_023052E4:
loc_023052E4:
	.word 0x000003B2	; 023052E4

; ===== function loc_023052E8 =====
loc_023052E8:
	push {r4,r5,lr}	; 023052E8
	sub sp,#0x4	; 023052EA
	mov r2,#0xf	; 023052EC
	add r3,r1,#0x0	; 023052EE
	and r3,r2	; 023052F0
	lsl r3,r3,#0x1	; 023052F2
	ldr r4,[pool_02305338]	; 023052F4
	ldrh r3,[r4,r3]	; 023052F6
	asr r1,r1,#0x4	; 023052F8
	ldr r5,[pool_0230533C]	; 023052FA
	and r1,r5	; 023052FC
	lsl r1,r1,#0x10	; 023052FE
	lsr r1,r1,#0x10	; 02305300
	eor r1,r3	; 02305302
	add r3,r0,#0x0	; 02305304
	and r3,r2	; 02305306
	lsl r3,r3,#0x1	; 02305308
	ldrh r3,[r4,r3]	; 0230530A
	eor r1,r3	; 0230530C
	lsl r1,r1,#0x10	; 0230530E
	lsr r3,r1,#0x10	; 02305310
	asr r1,r3,#0x4	; 02305312
	and r1,r5	; 02305314
	lsl r1,r1,#0x10	; 02305316
	lsr r1,r1,#0x10	; 02305318
	and r3,r2	; 0230531A
	lsl r3,r3,#0x1	; 0230531C
	ldrh r3,[r4,r3]	; 0230531E
	eor r1,r3	; 02305320
	asr r0,r0,#0x4	; 02305322
	and r0,r2	; 02305324
	lsl r0,r0,#0x1	; 02305326
	ldrh r0,[r4,r0]	; 02305328
	eor r1,r0	; 0230532A
	lsl r0,r1,#0x10	; 0230532C
	lsr r0,r0,#0x10	; 0230532E
	add sp,#0x4	; 02305330
	pop {r4,r5}	; 02305332
	pop {r3}	; 02305334
	bx r3	; 02305336
pool_02305338:
loc_02305338:
	.word P4_Data_023103DC	; 02305338
pool_0230533C:
loc_0230533C:
	.word 0x00000FFF	; 0230533C

; ===== function loc_02305340 =====
loc_02305340:
	push {r4,r5,r6,lr}	; 02305340
	ldr r0,[pool_02305364]	; 02305342
	ldr r6,[r0,#0x0]	; 02305344
	ldr r1,[pool_02305368]	; 02305346
	ldrh r5,[r6,r1]	; 02305348
	ldr r3,[pool_0230536C]	; 0230534A
	add r2,r6,r3	; 0230534C
	ldrh r4,[r2,#0x0]	; 0230534E
	ldr r1,[pool_02305370]	; 02305350
	ldrh r1,[r6,r1]	; 02305352
	mul r4,r1	; 02305354
	add r1,r5,r4	; 02305356
	strh r1,[r2,#0x0]	; 02305358
	ldr r0,[r0,#0x0]	; 0230535A
	ldrh r0,[r0,r3]	; 0230535C
	pop {r4,r5,r6}	; 0230535E
	pop {r3}	; 02305360
	bx r3	; 02305362
pool_02305364:
loc_02305364:
	.word FirmwareWlWorkPointerSlot	; 02305364
pool_02305368:
loc_02305368:
	.word 0x000005AA	; 02305368
pool_0230536C:
loc_0230536C:
	.word 0x000005AC	; 0230536C
pool_02305370:
loc_02305370:
	.word 0x000005A8	; 02305370

; ===== function loc_02305374 =====
loc_02305374:
	ldr r1,[pool_02305380]	; 02305374
	ldr r2,[r1,#0x0]	; 02305376
	ldr r1,[pool_02305384]	; 02305378
	strh r0,[r2,r1]	; 0230537A
	bx lr	; 0230537C
	.byte 0xC0, 0x46	; 02305380
pool_02305380:
loc_02305380:
	.word FirmwareWlWorkPointerSlot	; 02305380
pool_02305384:
loc_02305384:
	.word 0x000005AC	; 02305384

; ===== function loc_02305388 =====
loc_02305388:
	push {r4,lr}	; 02305388
	ldr r2,[pool_023053A8]	; 0230538A
	and r0,r2	; 0230538C
	add r4,r0,#0x5	; 0230538E
	ldr r3,[pool_023053AC]	; 02305390
	ldr r2,[r3,#0x0]	; 02305392
	ldr r0,[pool_023053B0]	; 02305394
	strh r4,[r2,r0]	; 02305396
	mov r0,#0x1	; 02305398
	orr r1,r0	; 0230539A
	ldr r2,[r3,#0x0]	; 0230539C
	ldr r0,[pool_023053B4]	; 0230539E
	strh r1,[r2,r0]	; 023053A0
	pop {r4}	; 023053A2
	pop {r3}	; 023053A4
	bx r3	; 023053A6
pool_023053A8:
loc_023053A8:
	.word 0x0000FFF8	; 023053A8
pool_023053AC:
loc_023053AC:
	.word FirmwareWlWorkPointerSlot	; 023053AC
pool_023053B0:
loc_023053B0:
	.word 0x000005A8	; 023053B0
pool_023053B4:
loc_023053B4:
	.word 0x000005AA	; 023053B4

; ===== function loc_023053B8 =====
loc_023053B8:
	mov r1,#0x1	; 023053B8
	add r2,r0,#0x0	; 023053BA
	and r2,r1	; 023053BC
	cmp r2,#0x0	; 023053BE
	beq loc_023053CE	; 023053C0
	sub r0,r0,#0x1	; 023053C2
	ldrh r0,[r0,#0x0]	; 023053C4
	asr r0,r0,#0x8	; 023053C6
	lsl r0,r0,#0x18	; 023053C8
	lsr r0,r0,#0x18	; 023053CA
	b loc_023053D4	; 023053CC
loc_023053CE:
	ldrh r0,[r0,#0x0]	; 023053CE
	lsl r0,r0,#0x18	; 023053D0
	lsr r0,r0,#0x18	; 023053D2
loc_023053D4:
	lsl r0,r0,#0x18	; 023053D4
	lsr r0,r0,#0x18	; 023053D6
	bx lr	; 023053D8
	.byte 0x00, 0x00	; 023053DC

; ===== function loc_023053DC =====
loc_023053DC:
	mov r2,#0x1	; 023053DC
	add r3,r0,#0x0	; 023053DE
	and r3,r2	; 023053E0
	cmp r3,#0x0	; 023053E2
	beq loc_023053F6	; 023053E4
	sub r3,r0,#0x1	; 023053E6
	ldrh r2,[r3,#0x0]	; 023053E8
	mov r0,#0xff	; 023053EA
	and r2,r0	; 023053EC
	lsl r0,r1,#0x8	; 023053EE
	orr r2,r0	; 023053F0
	strh r2,[r3,#0x0]	; 023053F2
	bx lr	; 023053F4
loc_023053F6:
	ldrh r3,[r0,#0x0]	; 023053F6
	ldr r2,[pool_02305408]	; 023053F8
	and r3,r2	; 023053FA
	mov r2,#0xff	; 023053FC
	and r1,r2	; 023053FE
	orr r3,r1	; 02305400
	strh r3,[r0,#0x0]	; 02305402
	bx lr	; 02305404
	.byte 0xC0, 0x46	; 02305408
pool_02305408:
loc_02305408:
	.word 0x0000FF00	; 02305408

; ===== function loc_0230540C =====
loc_0230540C:
	push {r4,r5,r6,lr}	; 0230540C
	add r5,r0,#0x0	; 0230540E
	add r6,r2,#0x0	; 02305410
	add r4,r3,#0x0	; 02305412
	mov r2,#0x12	; 02305414
	bl loc_02305468	; 02305416
	cmp r4,#0x0	; 0230541A
	beq loc_0230542C	; 0230541C
	add r5,#0x28	; 0230541E
	add r0,r5,#0x0	; 02305420
	add r1,r6,#0x0	; 02305422
	add r2,r4,#0x1	; 02305424
	lsr r2,r2,#0x1	; 02305426
	bl loc_02305468	; 02305428
loc_0230542C:
	pop {r4,r5,r6}	; 0230542C
	pop {r3}	; 0230542E
	bx r3	; 02305430
	.byte 0x00, 0x00	; 02305434

; ===== function loc_02305434 =====
loc_02305434:
	push {r4,r5,r6,lr}	; 02305434
	add r5,r0,#0x0	; 02305436
	add r6,r2,#0x0	; 02305438
	add r4,r3,#0x0	; 0230543A
	mov r2,#0x12	; 0230543C
	bl loc_02305468	; 0230543E
	cmp r4,#0x0	; 02305442
	beq loc_02305454	; 02305444
	add r5,#0x24	; 02305446
	add r0,r5,#0x0	; 02305448
	add r1,r6,#0x0	; 0230544A
	add r2,r4,#0x1	; 0230544C
	lsr r2,r2,#0x1	; 0230544E
	bl loc_02305468	; 02305450
loc_02305454:
	pop {r4,r5,r6}	; 02305454
	pop {r3}	; 02305456
	bx r3	; 02305458
	.byte 0x00, 0x00	; 0230545C

; ===== function loc_0230545C =====
loc_0230545C:
	add r2,r2,#0x1	; 0230545C
	lsr r2,r2,#0x1	; 0230545E
	ldr r3,[pool_02305464]	; 02305460
	bx r3	; 02305462
pool_02305464:
loc_02305464:
	.word loc_02305468 + 1	; 02305464

; ===== function loc_02305468 =====
loc_02305468:
	push {r4,r5,r6,r7,lr}	; 02305468
	sub sp,#0x4	; 0230546A
	add r5,r0,#0x0	; 0230546C
	add r4,r1,#0x0	; 0230546E
	add r7,r2,#0x0	; 02305470
	ldr r0,[pool_023054CC]	; 02305472
	ldr r1,[r0,#0x0]	; 02305474
	ldr r0,[pool_023054D0]	; 02305476
	ldr r1,[r1,r0]	; 02305478
	mov r0,#0xc	; 0230547A
	mul r1,r0	; 0230547C
	ldr r0,[pool_023054D4]	; 0230547E
	add r6,r1,r0	; 02305480
	ldr r0,[pool_023054D8]	; 02305482
	bl loc_02304B4C	; 02305484
	str r0,[sp,#0x0]	; 02305488
	mov r2,#0x0	; 0230548A
	b loc_023054B8	; 0230548C
loc_0230548E:
	sub r3,r7,r2	; 0230548E
	ldr r0,[pool_023054CC]	; 02305490
	ldr r1,[r0,#0x0]	; 02305492
	ldr r0,[pool_023054DC]	; 02305494
	ldr r0,[r1,r0]	; 02305496
	cmp r3,r0	; 02305498
	bls loc_0230549E	; 0230549A
	add r3,r0,#0x0	; 0230549C
loc_0230549E:
	ldr r0,[pool_023054E0]	; 0230549E
	strh r5,[r0,#0x0]	; 023054A0
	str r4,[r6,#0x0]	; 023054A2
	ldr r0,[pool_023054E4]	; 023054A4
	str r0,[r6,#0x4]	; 023054A6
	add r1,r3,#0x0	; 023054A8
	ldr r0,[pool_023054E8]	; 023054AA
	orr r1,r0	; 023054AC
	str r1,[r6,#0x8]	; 023054AE
	lsl r0,r3,#0x1	; 023054B0
	add r4,r4,r0	; 023054B2
	add r5,r5,r0	; 023054B4
	add r2,r2,r3	; 023054B6
loc_023054B8:
	cmp r2,r7	; 023054B8
	bcc loc_0230548E	; 023054BA
	ldr r0,[sp,#0x0]	; 023054BC
	bl loc_02304B5C	; 023054BE
	add sp,#0x4	; 023054C2
	pop {r4,r5,r6,r7}	; 023054C4
	pop {r3}	; 023054C6
	bx r3	; 023054C8
	.byte 0xC0, 0x46	; 023054CC
pool_023054CC:
loc_023054CC:
	.word FirmwareWlWorkPointerSlot	; 023054CC
pool_023054D0:
loc_023054D0:
	.word 0x000002D0	; 023054D0
pool_023054D4:
loc_023054D4:
	.word REG_DMA0SAD	; 023054D4
pool_023054D8:
loc_023054D8:
	.word 0x01000000	; 023054D8
pool_023054DC:
loc_023054DC:
	.word 0x000002D4	; 023054DC
pool_023054E0:
loc_023054E0:
	.word REG_WIFI_TXBUF_WR_ADDR	; 023054E0
pool_023054E4:
loc_023054E4:
	.word 0x04808070	; 023054E4
pool_023054E8:
loc_023054E8:
	.word 0x80400000	; 023054E8

; ===== function loc_023054EC =====
loc_023054EC:
	push {r4,r5,r6,r7,lr}	; 023054EC
	sub sp,#0xc	; 023054EE
	add r7,r0,#0x0	; 023054F0
	add r5,r1,#0x0	; 023054F2
	add r0,r2,#0x1	; 023054F4
	lsr r0,r0,#0x1	; 023054F6
	str r0,[sp,#0x0]	; 023054F8
	ldr r0,[pool_02305568]	; 023054FA
	ldr r1,[r0,#0x0]	; 023054FC
	ldr r0,[pool_0230556C]	; 023054FE
	ldr r1,[r1,r0]	; 02305500
	mov r0,#0xc	; 02305502
	mul r1,r0	; 02305504
	ldr r0,[pool_02305570]	; 02305506
	add r0,r1,r0	; 02305508
	str r0,[sp,#0x4]	; 0230550A
	mov r6,#0x0	; 0230550C
	b loc_0230555A	; 0230550E
loc_02305510:
	ldr r0,[sp,#0x0]	; 02305510
	sub r4,r0,r6	; 02305512
	ldr r0,[pool_02305568]	; 02305514
	ldr r1,[r0,#0x0]	; 02305516
	ldr r0,[pool_02305574]	; 02305518
	ldr r0,[r1,r0]	; 0230551A
	cmp r4,r0	; 0230551C
	bls loc_02305522	; 0230551E
	add r4,r0,#0x0	; 02305520
loc_02305522:
	ldr r0,[pool_02305578]	; 02305522
	bl loc_02304B4C	; 02305524
	ldr r1,[pool_0230557C]	; 02305528
	strh r5,[r1,#0x0]	; 0230552A
	ldr r2,[pool_02305580]	; 0230552C
	ldr r1,[sp,#0x4]	; 0230552E
	str r2,[r1,#0x0]	; 02305530
	str r7,[r1,#0x4]	; 02305532
	add r1,r4,#0x0	; 02305534
	ldr r2,[pool_02305584]	; 02305536
	orr r1,r2	; 02305538
	ldr r2,[sp,#0x4]	; 0230553A
	str r1,[r2,#0x8]	; 0230553C
	bl loc_02304B5C	; 0230553E
	lsl r0,r4,#0x1	; 02305542
	add r7,r7,r0	; 02305544
	add r5,r5,r0	; 02305546
	ldr r0,[pool_02305588]	; 02305548
	cmp r5,r0	; 0230554A
	bcc loc_02305558	; 0230554C
	ldr r0,[pool_02305568]	; 0230554E
	ldr r1,[r0,#0x0]	; 02305550
	ldr r0,[pool_0230558C]	; 02305552
	ldrh r0,[r1,r0]	; 02305554
	sub r5,r5,r0	; 02305556
loc_02305558:
	add r6,r6,r4	; 02305558
loc_0230555A:
	ldr r0,[sp,#0x0]	; 0230555A
	cmp r6,r0	; 0230555C
	bcc loc_02305510	; 0230555E
	add sp,#0xc	; 02305560
	pop {r4,r5,r6,r7}	; 02305562
	pop {r3}	; 02305564
	bx r3	; 02305566
pool_02305568:
loc_02305568:
	.word FirmwareWlWorkPointerSlot	; 02305568
pool_0230556C:
loc_0230556C:
	.word 0x000002D0	; 0230556C
pool_02305570:
loc_02305570:
	.word REG_DMA0SAD	; 02305570
pool_02305574:
loc_02305574:
	.word 0x000002D4	; 02305574
pool_02305578:
loc_02305578:
	.word 0x01000000	; 02305578
pool_0230557C:
loc_0230557C:
	.word REG_WIFI_RXBUF_RD_ADDR	; 0230557C
pool_02305580:
loc_02305580:
	.word 0x04808060	; 02305580
pool_02305584:
loc_02305584:
	.word 0x81000000	; 02305584
pool_02305588:
loc_02305588:
	.word 0x04805F60	; 02305588
pool_0230558C:
loc_0230558C:
	.word 0x00000396	; 0230558C

; ===== function loc_02305590 =====
loc_02305590:
	ldr r0,[pool_0230559C]	; 02305590
	ldr r1,[r0,#0x0]	; 02305592
	ldr r0,[pool_023055A0]	; 02305594
	add r0,r1,r0	; 02305596
	ldr r3,[pool_023055A4]	; 02305598
	bx r3	; 0230559A
pool_0230559C:
loc_0230559C:
	.word FirmwareWlWorkPointerSlot	; 0230559C
pool_023055A0:
loc_023055A0:
	.word 0x000005EC	; 023055A0
pool_023055A4:
loc_023055A4:
	.word loc_037FC5A0 + 1	; 023055A4

; ===== function loc_023055A8 =====
loc_023055A8:
	push {r4,r5,lr}	; 023055A8
	sub sp,#0x4	; 023055AA
	add r5,r0,#0x0	; 023055AC
	add r4,r1,#0x0	; 023055AE
	bl loc_02305590	; 023055B0
	ldr r0,[pool_023055DC]	; 023055B4
	mul r5,r0	; 023055B6
	lsr r0,r5,#0x6	; 023055B8
	ldr r1,[pool_023055E0]	; 023055BA
	bl loc_023055EC	; 023055BC
	add r1,r0,#0x0	; 023055C0
	mov r2,#0x0	; 023055C2
	str r2,[sp,#0x0]	; 023055C4
	ldr r0,[pool_023055E4]	; 023055C6
	ldr r3,[r0,#0x0]	; 023055C8
	ldr r0,[pool_023055E8]	; 023055CA
	add r0,r3,r0	; 023055CC
	add r3,r4,#0x0	; 023055CE
	bl loc_023012C8	; 023055D0
	add sp,#0x4	; 023055D4
	pop {r4,r5}	; 023055D6
	pop {r3}	; 023055D8
	bx r3	; 023055DA
pool_023055DC:
loc_023055DC:
	.word 0x000082EA	; 023055DC
pool_023055E0:
loc_023055E0:
	.word 0x000003E8	; 023055E0
pool_023055E4:
loc_023055E4:
	.word FirmwareWlWorkPointerSlot	; 023055E4
pool_023055E8:
loc_023055E8:
	.word 0x000005EC	; 023055E8

; ===== function loc_023055EC =====
loc_023055EC:
	bx pc	; 023055EC
	.byte 0xC0, 0x46	; 023055F0
.arm

; ===== function loc_023055F0 =====
loc_023055F0:
	ldr pc,[pool_023055F4]	; 023055F0
pool_023055F4:
loc_023055F4:
	.word loc_03802720	; 023055F4
.thumb

; ===== function loc_023055F8 =====
loc_023055F8:
	push {r4,r5,lr}	; 023055F8
	sub sp,#0x4	; 023055FA
	add r5,r0,#0x0	; 023055FC
	add r4,r1,#0x0	; 023055FE
	bl loc_02305590	; 02305600
	mov r2,#0x0	; 02305604
	str r2,[sp,#0x0]	; 02305606
	ldr r0,[pool_02305624]	; 02305608
	ldr r1,[r0,#0x0]	; 0230560A
	ldr r0,[pool_02305628]	; 0230560C
	add r0,r1,r0	; 0230560E
	ldr r1,[pool_0230562C]	; 02305610
	mul r5,r1	; 02305612
	lsr r1,r5,#0x6	; 02305614
	add r3,r4,#0x0	; 02305616
	bl loc_023012C8	; 02305618
	add sp,#0x4	; 0230561C
	pop {r4,r5}	; 0230561E
	pop {r3}	; 02305620
	bx r3	; 02305622
pool_02305624:
loc_02305624:
	.word FirmwareWlWorkPointerSlot	; 02305624
pool_02305628:
loc_02305628:
	.word 0x000005EC	; 02305628
pool_0230562C:
loc_0230562C:
	.word 0x000082EA	; 0230562C
P4_Code_02305630:
	push {lr}	; 02305630
	sub sp,#0x4	; 02305632
	ldr r0,[pool_02305688]	; 02305634
	ldr r1,[r0,#0x0]	; 02305636
	ldr r0,[pool_0230568C]	; 02305638
	add r1,r1,r0	; 0230563A
	ldr r0,[r1,#0x0]	; 0230563C
	add r0,r0,#0x1	; 0230563E
	str r0,[r1,#0x0]	; 02305640
	mov r0,#0x1	; 02305642
	mov r1,#0xa	; 02305644
	bl loc_02304B6C	; 02305646
	mov r0,#0x2	; 0230564A
	mov r1,#0x12	; 0230564C
	bl loc_02304B6C	; 0230564E
	mov r0,#0x1	; 02305652
	mov r1,#0x11	; 02305654
	bl loc_02304B6C	; 02305656
	ldr r0,[pool_02305688]	; 0230565A
	ldr r1,[r0,#0x0]	; 0230565C
	ldr r0,[pool_02305690]	; 0230565E
	ldrh r0,[r1,r0]	; 02305660
	cmp r0,#0x0	; 02305662
	beq loc_0230566E	; 02305664
	mov r0,#0x2	; 02305666
	mov r1,#0x13	; 02305668
	bl loc_02304B6C	; 0230566A
loc_0230566E:
	ldr r0,[pool_02305688]	; 0230566E
	ldr r1,[r0,#0x0]	; 02305670
	ldr r0,[pool_02305694]	; 02305672
	ldrh r0,[r1,r0]	; 02305674
	cmp r0,#0x0	; 02305676
	beq loc_02305682	; 02305678
	mov r0,#0x2	; 0230567A
	mov r1,#0x15	; 0230567C
	bl loc_02304B6C	; 0230567E
loc_02305682:
	add sp,#0x4	; 02305682
	pop {r3}	; 02305684
	bx r3	; 02305686
pool_02305688:
loc_02305688:
	.word FirmwareWlWorkPointerSlot	; 02305688
pool_0230568C:
loc_0230568C:
	.word 0x000003A4	; 0230568C
pool_02305690:
loc_02305690:
	.word 0x000001C0	; 02305690
pool_02305694:
loc_02305694:
	.word 0x000003AC	; 02305694

; ===== function loc_02305698 =====
loc_02305698:
	ldr r0,[pool_023056A4]	; 02305698
	ldr r1,[r0,#0x0]	; 0230569A
	ldr r0,[pool_023056A8]	; 0230569C
	add r0,r1,r0	; 0230569E
	ldr r3,[pool_023056AC]	; 023056A0
	bx r3	; 023056A2
pool_023056A4:
loc_023056A4:
	.word FirmwareWlWorkPointerSlot	; 023056A4
pool_023056A8:
loc_023056A8:
	.word 0x000005C0	; 023056A8
pool_023056AC:
loc_023056AC:
	.word loc_037FC5A0 + 1	; 023056AC

; ===== function loc_023056B0 =====
loc_023056B0:
	push {r4,r5,r6,r7,lr}	; 023056B0
	sub sp,#0xc	; 023056B2
	add r5,r0,#0x0	; 023056B4
	add r4,r1,#0x0	; 023056B6
	ldr r0,[pool_023056F4]	; 023056B8
	ldr r1,[r0,#0x0]	; 023056BA
	ldr r0,[pool_023056F8]	; 023056BC
	add r0,r1,r0	; 023056BE
	bl loc_02300FC8	; 023056C0
	ldr r0,[pool_023056FC]	; 023056C4
	mul r5,r0	; 023056C6
	lsr r5,r5,#0x6	; 023056C8
	bl loc_02305700	; 023056CA
	mov r7,#0x0	; 023056CE
	add r6,r5,r0	; 023056D0
	lsl r2,r7,#0	; 023056D2
	adc r2,r1	; 023056D4
	str r4,[sp,#0x4]	; 023056D6
	str r7,[sp,#0x8]	; 023056D8
	add r3,r5,#0x0	; 023056DA
	str r7,[sp,#0x0]	; 023056DC
	ldr r0,[pool_023056F4]	; 023056DE
	ldr r1,[r0,#0x0]	; 023056E0
	ldr r0,[pool_023056F8]	; 023056E2
	add r0,r1,r0	; 023056E4
	add r1,r6,#0x0	; 023056E6
	bl loc_02305710	; 023056E8
	add sp,#0xc	; 023056EC
	pop {r4,r5,r6,r7}	; 023056EE
	pop {r3}	; 023056F0
	bx r3	; 023056F2
pool_023056F4:
loc_023056F4:
	.word FirmwareWlWorkPointerSlot	; 023056F4
pool_023056F8:
loc_023056F8:
	.word 0x000005C0	; 023056F8
pool_023056FC:
loc_023056FC:
	.word 0x000082EA	; 023056FC

; ===== function loc_02305700 =====
loc_02305700:
	bx pc	; 02305700
	.byte 0xC0, 0x46	; 02305704
.arm

; ===== function loc_02305704 =====
loc_02305704:
	ldr r12,[pool_0230570C]	; 02305704
	bx r12	; 02305708
pool_0230570C:
loc_0230570C:
	.word loc_037FC3AC + 1	; 0230570C
.thumb

; ===== function loc_02305710 =====
loc_02305710:
	bx pc	; 02305710
	.byte 0xC0, 0x46	; 02305714
.arm

; ===== function loc_02305714 =====
loc_02305714:
	ldr r12,[pool_0230571C]	; 02305714
	bx r12	; 02305718
pool_0230571C:
loc_0230571C:
	.word loc_037FC5FC + 1	; 0230571C
.thumb

; ===== function loc_02305720 =====
loc_02305720:
	push {lr}	; 02305720
	sub sp,#0xc	; 02305722
	mov r1,#0x1	; 02305724
	str r1,[sp,#0x4]	; 02305726
	ldr r1,[pool_02305758]	; 02305728
	mul r0,r1	; 0230572A
	lsr r0,r0,#0x6	; 0230572C
	ldr r1,[pool_0230575C]	; 0230572E
	bl loc_0230576C	; 02305730
	add r1,r0,#0x0	; 02305734
	add r0,sp,#0x4	; 02305736
	str r0,[sp,#0x0]	; 02305738
	ldr r0,[pool_02305760]	; 0230573A
	ldr r2,[r0,#0x0]	; 0230573C
	ldr r0,[pool_02305764]	; 0230573E
	add r0,r2,r0	; 02305740
	mov r2,#0x0	; 02305742
	ldr r3,[pool_02305768]	; 02305744
	bl loc_023012C8	; 02305746
loc_0230574A:
	ldr r0,[sp,#0x4]	; 0230574A
	cmp r0,#0x0	; 0230574C
	bne loc_0230574A	; 0230574E
	add sp,#0xc	; 02305750
	pop {r3}	; 02305752
	bx r3	; 02305754
	.byte 0xC0, 0x46	; 02305758
pool_02305758:
loc_02305758:
	.word 0x000082EA	; 02305758
pool_0230575C:
loc_0230575C:
	.word 0x000003E8	; 0230575C
pool_02305760:
loc_02305760:
	.word FirmwareWlWorkPointerSlot	; 02305760
pool_02305764:
loc_02305764:
	.word 0x000005EC	; 02305764
pool_02305768:
loc_02305768:
	.word P4_Code_023057C8 + 1	; 02305768

; ===== function loc_0230576C =====
loc_0230576C:
	bx pc	; 0230576C
	.byte 0xC0, 0x46	; 02305770
.arm

; ===== function loc_02305770 =====
loc_02305770:
	ldr pc,[pool_02305774]	; 02305770
pool_02305774:
loc_02305774:
	.word loc_03802720	; 02305774
.thumb

; ===== function loc_02305778 =====
loc_02305778:
	push {lr}	; 02305778
	sub sp,#0xc	; 0230577A
	mov r1,#0x1	; 0230577C
	str r1,[sp,#0x4]	; 0230577E
	ldr r1,[pool_023057AC]	; 02305780
	mul r0,r1	; 02305782
	mov r1,#0x40	; 02305784
	bl loc_023057BC	; 02305786
	add r1,r0,#0x0	; 0230578A
	add r0,sp,#0x4	; 0230578C
	str r0,[sp,#0x0]	; 0230578E
	ldr r0,[pool_023057B0]	; 02305790
	ldr r2,[r0,#0x0]	; 02305792
	ldr r0,[pool_023057B4]	; 02305794
	add r0,r2,r0	; 02305796
	asr r2,r1,#0x1f	; 02305798
	ldr r3,[pool_023057B8]	; 0230579A
	bl loc_023012C8	; 0230579C
loc_023057A0:
	ldr r0,[sp,#0x4]	; 023057A0
	cmp r0,#0x0	; 023057A2
	bne loc_023057A0	; 023057A4
	add sp,#0xc	; 023057A6
	pop {r3}	; 023057A8
	bx r3	; 023057AA
pool_023057AC:
loc_023057AC:
	.word 0x000082EA	; 023057AC
pool_023057B0:
loc_023057B0:
	.word FirmwareWlWorkPointerSlot	; 023057B0
pool_023057B4:
loc_023057B4:
	.word 0x000005EC	; 023057B4
pool_023057B8:
loc_023057B8:
	.word P4_Code_023057C8 + 1	; 023057B8

; ===== function loc_023057BC =====
loc_023057BC:
	bx pc	; 023057BC
	.byte 0xC0, 0x46	; 023057C0
.arm

; ===== function loc_023057C0 =====
loc_023057C0:
	ldr pc,[pool_023057C4]	; 023057C0
pool_023057C4:
loc_023057C4:
	.word loc_03802514	; 023057C4
.thumb
P4_Code_023057C8:
	mov r1,#0x0	; 023057C8
	str r1,[r0,#0x0]	; 023057CA
	bx lr	; 023057CC
	.byte 0x00, 0x00	; 023057D0

; ===== function loc_023057D0 =====
loc_023057D0:
	push {lr}	; 023057D0
	sub sp,#0x4	; 023057D2
	bl loc_0230581C	; 023057D4
	cmp r0,#0x0	; 023057D8
	beq loc_023057F6	; 023057DA
	ldr r0,[pool_0230580C]	; 023057DC
	ldr r1,[r0,#0x0]	; 023057DE
	ldr r0,[pool_02305810]	; 023057E0
	add r0,r1,r0	; 023057E2
	bl loc_0230453C	; 023057E4
	ldr r0,[pool_0230580C]	; 023057E8
	ldr r1,[r0,#0x0]	; 023057EA
	ldr r0,[pool_02305814]	; 023057EC
	add r0,r1,r0	; 023057EE
	bl loc_0230453C	; 023057F0
	b loc_02305806	; 023057F4
loc_023057F6:
	ldr r0,[pool_0230580C]	; 023057F6
	ldr r1,[r0,#0x0]	; 023057F8
	ldr r0,[pool_02305818]	; 023057FA
	add r2,r1,r0	; 023057FC
	ldrh r1,[r2,#0x0]	; 023057FE
	mov r0,#0x40	; 02305800
	orr r1,r0	; 02305802
	strh r1,[r2,#0x0]	; 02305804
loc_02305806:
	add sp,#0x4	; 02305806
	pop {r3}	; 02305808
	bx r3	; 0230580A
pool_0230580C:
loc_0230580C:
	.word FirmwareWlWorkPointerSlot	; 0230580C
pool_02305810:
loc_02305810:
	.word 0x000005C0	; 02305810
pool_02305814:
loc_02305814:
	.word 0x000005EC	; 02305814
pool_02305818:
loc_02305818:
	.word 0x00000302	; 02305818

; ===== function loc_0230581C =====
loc_0230581C:
	bx pc	; 0230581C
	.byte 0xC0, 0x46	; 02305820
.arm

; ===== function loc_02305820 =====
loc_02305820:
	ldr r12,[pool_02305828]	; 02305820
	bx r12	; 02305824
pool_02305828:
loc_02305828:
	.word loc_037FC780 + 1	; 02305828
.thumb

; ===== function loc_0230582C =====
loc_0230582C:
	push {r4,r5,r6,r7,lr}	; 0230582C
	sub sp,#0xc	; 0230582E
	mov r5,#0x0	; 02305830
	str r5,[sp,#0x4]	; 02305832
	ldr r6,[pool_0230590C]	; 02305834
	ldr r7,[pool_02305910]	; 02305836
loc_02305838:
	lsl r4,r5,#0x1	; 02305838
	add r0,r4,#0x0	; 0230583A
	add r0,#0x44	; 0230583C
	mov r1,#0x2	; 0230583E
	add r2,sp,#0x4	; 02305840
	bl loc_0231019C	; 02305842
	ldr r1,[sp,#0x4]	; 02305846
	ldrh r0,[r6,r4]	; 02305848
	strh r1,[r0,r7]	; 0230584A
	add r5,r5,#0x1	; 0230584C
	cmp r5,#0x10	; 0230584E
	bcc loc_02305838	; 02305850
	ldr r0,[pool_02305914]	; 02305852
	ldr r2,[r0,#0x0]	; 02305854
	ldr r1,[pool_02305918]	; 02305856
	ldrh r2,[r2,r1]	; 02305858
	lsr r2,r2,#0x7	; 0230585A
	lsl r4,r2,#0x8	; 0230585C
	str r4,[sp,#0x0]	; 0230585E
	ldr r2,[r0,#0x0]	; 02305860
	ldrh r3,[r2,r1]	; 02305862
	mov r2,#0x7f	; 02305864
	and r3,r2	; 02305866
	orr r4,r3	; 02305868
	str r4,[sp,#0x0]	; 0230586A
	ldr r3,[pool_0230591C]	; 0230586C
	strh r4,[r3,#0x0]	; 0230586E
	mov r5,#0xce	; 02305870
	ldr r6,[r0,#0x0]	; 02305872
	ldrh r0,[r6,r1]	; 02305874
	and r0,r2	; 02305876
	add r0,r0,#0x7	; 02305878
	mov r1,#0x8	; 0230587A
	bl loc_02305938	; 0230587C
	add r7,r0,#0x0	; 02305880
	ldr r0,[pool_02305920]	; 02305882
	ldrh r4,[r6,r0]	; 02305884
	ldr r0,[pool_02305924]	; 02305886
	ldrh r0,[r6,r0]	; 02305888
	cmp r0,#0x3	; 0230588A
	bne loc_023058C8	; 0230588C
	add r0,r4,#0x0	; 0230588E
	add r0,#0xce	; 02305890
	mov r1,#0x1	; 02305892
	ldr r2,[pool_02305928]	; 02305894
	add r2,r6,r2	; 02305896
	bl loc_0231019C	; 02305898
	mov r6,#0x0	; 0230589C
	add r7,r6,#0x0	; 0230589E
	b loc_023058C2	; 023058A0
loc_023058A2:
	str r7,[sp,#0x0]	; 023058A2
	add r0,r5,#0x0	; 023058A4
	mov r1,#0x1	; 023058A6
	add r2,sp,#0x0	; 023058A8
	bl loc_0231019C	; 023058AA
	ldr r0,[sp,#0x0]	; 023058AE
	lsl r2,r6,#0x8	; 023058B0
	ldr r1,[pool_0230592C]	; 023058B2
	add r1,r2,r1	; 023058B4
	orr r0,r1	; 023058B6
	str r0,[sp,#0x0]	; 023058B8
	bl loc_02305A6C	; 023058BA
	add r6,r6,#0x1	; 023058BE
	add r5,r5,#0x1	; 023058C0
loc_023058C2:
	cmp r6,r4	; 023058C2
	bcc loc_023058A2	; 023058C4
	b loc_02305902	; 023058C6
loc_023058C8:
	mov r0,#0x0	; 023058C8
	str r0,[sp,#0x0]	; 023058CA
	ldr r6,[pool_02305914]	; 023058CC
	b loc_023058FE	; 023058CE
loc_023058D0:
	add r0,r5,#0x0	; 023058D0
	add r1,r7,#0x0	; 023058D2
	add r2,sp,#0x0	; 023058D4
	bl loc_0231019C	; 023058D6
	ldr r0,[sp,#0x0]	; 023058DA
	bl loc_02305A6C	; 023058DC
	ldr r1,[r6,#0x0]	; 023058E0
	ldr r0,[pool_02305924]	; 023058E2
	ldrh r0,[r1,r0]	; 023058E4
	cmp r0,#0x2	; 023058E6
	bne loc_023058FA	; 023058E8
	ldr r0,[sp,#0x0]	; 023058EA
	lsr r2,r0,#0x12	; 023058EC
	cmp r2,#0x9	; 023058EE
	bne loc_023058FA	; 023058F0
	ldr r2,[pool_02305930]	; 023058F2
	and r0,r2	; 023058F4
	ldr r2,[pool_02305934]	; 023058F6
	str r0,[r1,r2]	; 023058F8
loc_023058FA:
	sub r4,r4,#0x1	; 023058FA
	add r5,r5,r7	; 023058FC
loc_023058FE:
	cmp r4,#0x0	; 023058FE
	bne loc_023058D0	; 02305900
loc_02305902:
	add sp,#0xc	; 02305902
	pop {r4,r5,r6,r7}	; 02305904
	pop {r3}	; 02305906
	bx r3	; 02305908
	.byte 0xC0, 0x46	; 0230590C
pool_0230590C:
loc_0230590C:
	.word 0x023103FC	; 0230590C
pool_02305910:
loc_02305910:
	.word WifiIoWs1Base	; 02305910
pool_02305914:
loc_02305914:
	.word FirmwareWlWorkPointerSlot	; 02305914
pool_02305918:
loc_02305918:
	.word 0x000005B2	; 02305918
pool_0230591C:
loc_0230591C:
	.word REG_WIFI_RF_CNT	; 0230591C
pool_02305920:
loc_02305920:
	.word 0x000005B4	; 02305920
pool_02305924:
loc_02305924:
	.word 0x000005B0	; 02305924
pool_02305928:
loc_02305928:
	.word 0x000005B8	; 02305928
pool_0230592C:
loc_0230592C:
	.word 0x00050000	; 0230592C
pool_02305930:
loc_02305930:
	.word 0xFFFF83FF	; 02305930
pool_02305934:
loc_02305934:
	.word 0x000005BC	; 02305934

; ===== function loc_02305938 =====
loc_02305938:
	bx pc	; 02305938
	.byte 0xC0, 0x46	; 0230593C
.arm

; ===== function loc_0230593C =====
loc_0230593C:
	ldr pc,[pool_02305940]	; 0230593C
pool_02305940:
loc_02305940:
	.word loc_03802514	; 02305940
.thumb

; ===== function loc_02305944 =====
loc_02305944:
	push {r4,r5,r6,r7,lr}	; 02305944
	sub sp,#0x4	; 02305946
	ldr r1,[pool_0230597C]	; 02305948
	ldr r0,[pool_02305980]	; 0230594A
	strh r1,[r0,#0x0]	; 0230594C
	mov r4,#0x64	; 0230594E
	mov r5,#0x0	; 02305950
	str r5,[sp,#0x0]	; 02305952
	mov r6,#0x1	; 02305954
	add r7,sp,#0x0	; 02305956
loc_02305958:
	add r0,r4,#0x0	; 02305958
	add r1,r6,#0x0	; 0230595A
	add r2,r7,#0x0	; 0230595C
	bl loc_0231019C	; 0230595E
	add r0,r5,#0x0	; 02305962
	ldr r1,[sp,#0x0]	; 02305964
	bl loc_02305A9C	; 02305966
	add r4,r4,#0x1	; 0230596A
	add r5,r5,#0x1	; 0230596C
	cmp r5,#0x69	; 0230596E
	bcc loc_02305958	; 02305970
	add sp,#0x4	; 02305972
	pop {r4,r5,r6,r7}	; 02305974
	pop {r3}	; 02305976
	bx r3	; 02305978
	.byte 0xC0, 0x46	; 0230597C
pool_0230597C:
loc_0230597C:
	.word 0x00000100	; 0230597C
pool_02305980:
loc_02305980:
	.word REG_WIFI_BB_MODE	; 02305980

; ===== function loc_02305984 =====
loc_02305984:
	push {r4,lr}	; 02305984
	mov r4,#0x0	; 02305986
	ldr r3,[pool_023059A4]	; 02305988
	ldr r0,[pool_023059A8]	; 0230598A
loc_0230598C:
	lsl r1,r4,#0x2	; 0230598C
	add r2,r3,r1	; 0230598E
	ldrh r2,[r2,#0x2]	; 02305990
	ldrh r1,[r3,r1]	; 02305992
	strh r2,[r1,r0]	; 02305994
	add r4,r4,#0x1	; 02305996
	cmp r4,#0x16	; 02305998
	bcc loc_0230598C	; 0230599A
	pop {r4}	; 0230599C
	pop {r3}	; 0230599E
	bx r3	; 023059A0
	.byte 0xC0, 0x46	; 023059A4
pool_023059A4:
loc_023059A4:
	.word P4_Data_0231046C	; 023059A4
pool_023059A8:
loc_023059A8:
	.word WifiIoWs1Base	; 023059A8

; ===== function loc_023059AC =====
loc_023059AC:
	push {lr}	; 023059AC
	sub sp,#0x4	; 023059AE
	mov r1,#0x0	; 023059B0
	add r0,sp,#0x0	; 023059B2
	strh r1,[r0,#0x0]	; 023059B4
	ldrh r0,[r0,#0x0]	; 023059B6
	ldr r1,[pool_02305A0C]	; 023059B8
	ldr r2,[r1,#0x0]	; 023059BA
	ldr r1,[pool_02305A10]	; 023059BC
	add r1,r2,r1	; 023059BE
	mov r2,#0x10	; 023059C0
	bl loc_02305A20	; 023059C2
	mov r0,#0x40	; 023059C6
	mov r1,#0x1	; 023059C8
	ldr r2,[pool_02305A0C]	; 023059CA
	ldr r3,[r2,#0x0]	; 023059CC
	ldr r2,[pool_02305A10]	; 023059CE
	add r2,r3,r2	; 023059D0
	bl loc_0231019C	; 023059D2
	mov r0,#0x41	; 023059D6
	mov r1,#0x1	; 023059D8
	ldr r2,[pool_02305A0C]	; 023059DA
	ldr r3,[r2,#0x0]	; 023059DC
	ldr r2,[pool_02305A14]	; 023059DE
	add r2,r3,r2	; 023059E0
	bl loc_0231019C	; 023059E2
	mov r0,#0x42	; 023059E6
	mov r1,#0x1	; 023059E8
	ldr r2,[pool_02305A0C]	; 023059EA
	ldr r3,[r2,#0x0]	; 023059EC
	ldr r2,[pool_02305A18]	; 023059EE
	add r2,r3,r2	; 023059F0
	bl loc_0231019C	; 023059F2
	mov r0,#0x43	; 023059F6
	mov r1,#0x1	; 023059F8
	ldr r2,[pool_02305A0C]	; 023059FA
	ldr r3,[r2,#0x0]	; 023059FC
	ldr r2,[pool_02305A1C]	; 023059FE
	add r2,r3,r2	; 02305A00
	bl loc_0231019C	; 02305A02
	add sp,#0x4	; 02305A06
	pop {r3}	; 02305A08
	bx r3	; 02305A0A
pool_02305A0C:
loc_02305A0C:
	.word FirmwareWlWorkPointerSlot	; 02305A0C
pool_02305A10:
loc_02305A10:
	.word 0x000005B0	; 02305A10
pool_02305A14:
loc_02305A14:
	.word 0x000005B2	; 02305A14
pool_02305A18:
loc_02305A18:
	.word 0x000005B4	; 02305A18
pool_02305A1C:
loc_02305A1C:
	.word 0x000005B6	; 02305A1C

; ===== function loc_02305A20 =====
loc_02305A20:
	bx pc	; 02305A20
	.byte 0xC0, 0x46	; 02305A24
.arm

; ===== function loc_02305A24 =====
loc_02305A24:
	ldr pc,[pool_02305A28]	; 02305A24
pool_02305A28:
loc_02305A28:
	.word loc_037FCE04	; 02305A28
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x64, 0x25, 0x00, 0x26, 0x00, 0x96, 0x34, 0x1C, 0x80, 0x27, 0x28, 0x1C	; 02305A3C
	.byte 0x01, 0x21, 0x00, 0xAA, 0x0A, 0xF0, 0xAC, 0xFB, 0x01, 0x2C, 0x02, 0xD1, 0x00, 0x98, 0x38, 0x40	; 02305A4C
	.byte 0x00, 0x90, 0x00, 0x98, 0x00, 0x06, 0x00, 0x0E, 0x31, 0x1C, 0xFF, 0xF7, 0x47, 0xFC, 0x06, 0x1C	; 02305A5C
	.byte 0x6D, 0x1C, 0x64, 0x1C, 0x69, 0x2C, 0xEA, 0xD3, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 02305A6C
.thumb

; ===== function loc_02305A6C =====
loc_02305A6C:
	ldr r2,[pool_02305A90]	; 02305A6C
	mov r1,#0x1	; 02305A6E
loc_02305A70:
	ldrh r3,[r2,#0x0]	; 02305A70
	and r3,r1	; 02305A72
	cmp r3,#0x0	; 02305A74
	bne loc_02305A70	; 02305A76
	ldr r1,[pool_02305A94]	; 02305A78
	strh r0,[r1,#0x0]	; 02305A7A
	lsr r1,r0,#0x10	; 02305A7C
	ldr r0,[pool_02305A98]	; 02305A7E
	strh r1,[r0,#0x0]	; 02305A80
	ldr r1,[pool_02305A90]	; 02305A82
	mov r0,#0x1	; 02305A84
loc_02305A86:
	ldrh r2,[r1,#0x0]	; 02305A86
	and r2,r0	; 02305A88
	cmp r2,#0x0	; 02305A8A
	bne loc_02305A86	; 02305A8C
	bx lr	; 02305A8E
pool_02305A90:
loc_02305A90:
	.word REG_WIFI_RF_BUSY	; 02305A90
pool_02305A94:
loc_02305A94:
	.word REG_WIFI_RF_DATA1	; 02305A94
pool_02305A98:
loc_02305A98:
	.word REG_WIFI_RF_DATA2	; 02305A98

; ===== function loc_02305A9C =====
loc_02305A9C:
	push {r4,r5,r6,lr}	; 02305A9C
	mov r6,#0x0	; 02305A9E
	ldr r4,[pool_02305AF4]	; 02305AA0
	ldr r3,[pool_02305AF8]	; 02305AA2
	mov r2,#0x1	; 02305AA4
	b loc_02305AB6	; 02305AA6
loc_02305AA8:
	add r5,r6,#0x0	; 02305AA8
	add r6,r6,#0x1	; 02305AAA
	cmp r5,r3	; 02305AAC
	bls loc_02305AB6	; 02305AAE
	mov r0,#0x0	; 02305AB0
	mvn r0,r0	; 02305AB2
	b loc_02305AEC	; 02305AB4
loc_02305AB6:
	ldrh r5,[r4,#0x0]	; 02305AB6
	and r5,r2	; 02305AB8
	cmp r5,#0x0	; 02305ABA
	bne loc_02305AA8	; 02305ABC
	ldr r2,[pool_02305AFC]	; 02305ABE
	strh r1,[r2,#0x0]	; 02305AC0
	ldr r1,[pool_02305B00]	; 02305AC2
	orr r0,r1	; 02305AC4
	ldr r1,[pool_02305B04]	; 02305AC6
	strh r0,[r1,#0x0]	; 02305AC8
	mov r4,#0x0	; 02305ACA
	ldr r2,[pool_02305AF4]	; 02305ACC
	ldr r1,[pool_02305AF8]	; 02305ACE
	mov r0,#0x1	; 02305AD0
	b loc_02305AE2	; 02305AD2
loc_02305AD4:
	add r3,r4,#0x0	; 02305AD4
	add r4,r4,#0x1	; 02305AD6
	cmp r3,r1	; 02305AD8
	bls loc_02305AE2	; 02305ADA
	mov r0,#0x0	; 02305ADC
	mvn r0,r0	; 02305ADE
	b loc_02305AEC	; 02305AE0
loc_02305AE2:
	ldrh r3,[r2,#0x0]	; 02305AE2
	and r3,r0	; 02305AE4
	cmp r3,#0x0	; 02305AE6
	bne loc_02305AD4	; 02305AE8
	mov r0,#0x0	; 02305AEA
loc_02305AEC:
	pop {r4,r5,r6}	; 02305AEC
	pop {r3}	; 02305AEE
	bx r3	; 02305AF0
	.byte 0xC0, 0x46	; 02305AF4
pool_02305AF4:
loc_02305AF4:
	.word REG_WIFI_BB_BUSY	; 02305AF4
pool_02305AF8:
loc_02305AF8:
	.word 0x00002710	; 02305AF8
pool_02305AFC:
loc_02305AFC:
	.word REG_WIFI_BB_WRITE	; 02305AFC
pool_02305B00:
loc_02305B00:
	.word 0x00005000	; 02305B00
pool_02305B04:
loc_02305B04:
	.word REG_WIFI_BB_CNT	; 02305B04

; ===== function loc_02305B08 =====
loc_02305B08:
	ldr r2,[pool_02305B30]	; 02305B08
	mov r1,#0x1	; 02305B0A
loc_02305B0C:
	ldrh r3,[r2,#0x0]	; 02305B0C
	and r3,r1	; 02305B0E
	cmp r3,#0x0	; 02305B10
	bne loc_02305B0C	; 02305B12
	ldr r1,[pool_02305B34]	; 02305B14
	orr r0,r1	; 02305B16
	ldr r1,[pool_02305B38]	; 02305B18
	strh r0,[r1,#0x0]	; 02305B1A
	ldr r1,[pool_02305B30]	; 02305B1C
	mov r0,#0x1	; 02305B1E
loc_02305B20:
	ldrh r2,[r1,#0x0]	; 02305B20
	and r2,r0	; 02305B22
	cmp r2,#0x0	; 02305B24
	bne loc_02305B20	; 02305B26
	ldr r0,[pool_02305B3C]	; 02305B28
	ldrh r0,[r0,#0x0]	; 02305B2A
	bx lr	; 02305B2C
	.byte 0xC0, 0x46	; 02305B30
pool_02305B30:
loc_02305B30:
	.word REG_WIFI_BB_BUSY	; 02305B30
pool_02305B34:
loc_02305B34:
	.word 0x00006000	; 02305B34
pool_02305B38:
loc_02305B38:
	.word REG_WIFI_BB_CNT	; 02305B38
pool_02305B3C:
loc_02305B3C:
	.word REG_WIFI_BB_READ	; 02305B3C

; ===== function loc_02305B40 =====
loc_02305B40:
	push {r4,lr}	; 02305B40
	bl loc_02305698	; 02305B42
	mov r0,#0x20	; 02305B46
	bl loc_0230646C	; 02305B48
	mov r1,#0x0	; 02305B4C
	ldr r0,[pool_02305BBC]	; 02305B4E
	ldr r3,[r0,#0x0]	; 02305B50
	ldr r2,[pool_02305BC0]	; 02305B52
	strh r1,[r3,r2]	; 02305B54
	ldr r3,[r0,#0x0]	; 02305B56
	ldr r2,[pool_02305BC4]	; 02305B58
	add r4,r3,r2	; 02305B5A
	ldrh r3,[r4,#0x0]	; 02305B5C
	mov r2,#0x4	; 02305B5E
	bic r3,r2	; 02305B60
	strh r3,[r4,#0x0]	; 02305B62
	ldr r2,[pool_02305BC8]	; 02305B64
	strh r1,[r2,#0x0]	; 02305B66
	ldr r2,[pool_02305BCC]	; 02305B68
	strh r1,[r2,#0x0]	; 02305B6A
	ldr r2,[pool_02305BD0]	; 02305B6C
	strh r1,[r2,#0x0]	; 02305B6E
	ldr r2,[pool_02305BD4]	; 02305B70
	strh r1,[r2,#0x0]	; 02305B72
	ldr r2,[pool_02305BD8]	; 02305B74
	strh r1,[r2,#0x0]	; 02305B76
	ldr r2,[pool_02305BDC]	; 02305B78
	strh r1,[r2,#0x0]	; 02305B7A
	ldr r1,[r0,#0x0]	; 02305B7C
	ldr r0,[pool_02305BE0]	; 02305B7E
	ldrh r0,[r1,r0]	; 02305B80
	cmp r0,#0x4	; 02305B82
	bhi loc_02305BA2	; 02305B84
	add r0,r0,r0	; 02305B86
P4_SwitchIndexPC_02305B86:
	add r0,pc	; 02305B88
	ldrh r0,[r0,#(P4_SwitchTable_02305B86 - (P4_SwitchIndexPC_02305B86 + 4))]	; 02305B8A
	lsl r0,r0,#0x10	; 02305B8C
	asr r0,r0,#0x10	; 02305B8E
P4_SwitchTargetPC_02305B86:
	add r0,pc	; 02305B90
	bx r0	; 02305B92
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02305B86:
	.halfword (loc_02305BA2 + 1) - (P4_SwitchTargetPC_02305B86 + 4)
	.halfword (loc_02305B9E + 1) - (P4_SwitchTargetPC_02305B86 + 4)
	.halfword (loc_02305BA2 + 1) - (P4_SwitchTargetPC_02305B86 + 4)
	.halfword (loc_02305BA2 + 1) - (P4_SwitchTargetPC_02305B86 + 4)
	.halfword (loc_02305BA2 + 1) - (P4_SwitchTargetPC_02305B86 + 4)
P4_SwitchTable_02305B86End:
loc_02305B9E:
	bl loc_0230CA38	; 02305B9E
loc_02305BA2:
	ldr r1,[pool_02305BE4]	; 02305BA2
	ldr r0,[pool_02305BE8]	; 02305BA4
	strh r1,[r0,#0x0]	; 02305BA6
	ldr r0,[pool_02305BEC]	; 02305BA8
	strh r1,[r0,#0x0]	; 02305BAA
	bl loc_0230CBCC	; 02305BAC
	bl loc_02304D18	; 02305BB0
	pop {r4}	; 02305BB4
	pop {r3}	; 02305BB6
	bx r3	; 02305BB8
	.byte 0xC0, 0x46	; 02305BBC
pool_02305BBC:
loc_02305BBC:
	.word FirmwareWlWorkPointerSlot	; 02305BBC
pool_02305BC0:
loc_02305BC0:
	.word 0x000003A0	; 02305BC0
pool_02305BC4:
loc_02305BC4:
	.word 0x00000316	; 02305BC4
pool_02305BC8:
loc_02305BC8:
	.word REG_WIFI_IE	; 02305BC8
pool_02305BCC:
loc_02305BCC:
	.word REG_WIFI_MODE_RST	; 02305BCC
pool_02305BD0:
loc_02305BD0:
	.word REG_WIFI_US_COMPARECNT	; 02305BD0
pool_02305BD4:
loc_02305BD4:
	.word REG_WIFI_US_COUNTCNT	; 02305BD4
pool_02305BD8:
loc_02305BD8:
	.word REG_WIFI_TXSTATCNT	; 02305BD8
pool_02305BDC:
loc_02305BDC:
	.word REG_WIFI_UNKNOWN_00A	; 02305BDC
pool_02305BE0:
loc_02305BE0:
	.word 0x00000314	; 02305BE0
pool_02305BE4:
loc_02305BE4:
	.word 0x0000FFFF	; 02305BE4
pool_02305BE8:
loc_02305BE8:
	.word REG_WIFI_TXREQ_RESET	; 02305BE8
pool_02305BEC:
loc_02305BEC:
	.word REG_WIFI_TXBUF_RESET	; 02305BEC

; ===== function loc_02305BF0 =====
loc_02305BF0:
	push {r4,r5,r6,lr}	; 02305BF0
	sub sp,#0x8	; 02305BF2
	bl loc_02305B40	; 02305BF4
	ldr r2,[pool_02305F44]	; 02305BF8
	ldrh r1,[r2,#0x0]	; 02305BFA
	ldrh r0,[r2,#0x0]	; 02305BFC
	lsl r0,r0,#0x8	; 02305BFE
	add r0,r1,r0	; 02305C00
	ldrh r1,[r2,#0x0]	; 02305C02
	bl loc_02305388	; 02305C04
	mov r3,#0x1	; 02305C08
	ldr r2,[pool_02305F48]	; 02305C0A
	ldr r1,[r2,#0x0]	; 02305C0C
	ldr r0,[pool_02305F4C]	; 02305C0E
	strh r3,[r1,r0]	; 02305C10
	ldr r2,[r2,#0x0]	; 02305C12
	ldr r1,[pool_02305F50]	; 02305C14
	ldrh r1,[r2,r1]	; 02305C16
	lsl r1,r1,#0x1d	; 02305C18
	lsr r1,r1,#0x1f	; 02305C1A
	cmp r1,#0x1	; 02305C1C
	bne loc_02305C2A	; 02305C1E
	add r2,r2,r0	; 02305C20
	ldrh r1,[r2,#0x0]	; 02305C22
	mov r0,#0x20	; 02305C24
	orr r1,r0	; 02305C26
	strh r1,[r2,#0x0]	; 02305C28
loc_02305C2A:
	ldr r0,[pool_02305F48]	; 02305C2A
	ldr r1,[r0,#0x0]	; 02305C2C
	ldr r0,[pool_02305F54]	; 02305C2E
	ldrh r0,[r1,r0]	; 02305C30
	cmp r0,#0x0	; 02305C32
	beq loc_02305C42	; 02305C34
	ldr r0,[pool_02305F4C]	; 02305C36
	add r2,r1,r0	; 02305C38
	ldrh r1,[r2,#0x0]	; 02305C3A
	mov r0,#0x10	; 02305C3C
	orr r1,r0	; 02305C3E
	strh r1,[r2,#0x0]	; 02305C40
loc_02305C42:
	ldr r0,[pool_02305F48]	; 02305C42
	ldr r1,[r0,#0x0]	; 02305C44
	ldr r0,[pool_02305F58]	; 02305C46
	add r2,r1,r0	; 02305C48
	ldrh r1,[r2,#0x0]	; 02305C4A
	mov r0,#0x4	; 02305C4C
	bic r1,r0	; 02305C4E
	strh r1,[r2,#0x0]	; 02305C50
	ldr r1,[pool_02305F5C]	; 02305C52
	ldr r0,[pool_02305F60]	; 02305C54
	strh r1,[r0,#0x0]	; 02305C56
	ldr r1,[pool_02305F64]	; 02305C58
	ldr r0,[pool_02305F68]	; 02305C5A
	strh r1,[r0,#0x0]	; 02305C5C
	mov r1,#0x0	; 02305C5E
	ldr r0,[pool_02305F6C]	; 02305C60
	strh r1,[r0,#0x0]	; 02305C62
	ldr r0,[pool_02305F70]	; 02305C64
	strh r1,[r0,#0x0]	; 02305C66
	mov r1,#0x1	; 02305C68
	ldr r0,[pool_02305F74]	; 02305C6A
	strh r1,[r0,#0x0]	; 02305C6C
	mov r1,#0xf	; 02305C6E
	ldr r0,[pool_02305F78]	; 02305C70
	strh r1,[r0,#0x0]	; 02305C72
	bl loc_02308D84	; 02305C74
	bl loc_0230FF90	; 02305C78
	bl loc_0230B9D4	; 02305C7C
	bl loc_0230D874	; 02305C80
	ldr r1,[pool_02305F5C]	; 02305C84
	ldr r0,[pool_02305F7C]	; 02305C86
	strh r1,[r0,#0x0]	; 02305C88
	ldr r1,[pool_02305F48]	; 02305C8A
	ldr r2,[r1,#0x0]	; 02305C8C
	ldr r0,[pool_02305F80]	; 02305C8E
	ldrh r0,[r2,r0]	; 02305C90
	cmp r0,#0x4	; 02305C92
	bls loc_02305C98	; 02305C94
	b loc_02305F02	; 02305C96
loc_02305C98:
	add r0,r0,r0	; 02305C98
P4_SwitchIndexPC_02305C98:
	add r0,pc	; 02305C9A
	ldrh r0,[r0,#(P4_SwitchTable_02305C98 - (P4_SwitchIndexPC_02305C98 + 4))]	; 02305C9C
	lsl r0,r0,#0x10	; 02305C9E
	asr r0,r0,#0x10	; 02305CA0
P4_SwitchTargetPC_02305C98:
	add r0,pc	; 02305CA2
	bx r0	; 02305CA4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02305C98:
	.halfword (loc_02305CB0 + 1) - (P4_SwitchTargetPC_02305C98 + 4)
	.halfword (loc_02305CFE + 1) - (P4_SwitchTargetPC_02305C98 + 4)
	.halfword (loc_02305DC6 + 1) - (P4_SwitchTargetPC_02305C98 + 4)
	.halfword (loc_02305E6A + 1) - (P4_SwitchTargetPC_02305C98 + 4)
	.halfword (loc_02305EDE + 1) - (P4_SwitchTargetPC_02305C98 + 4)
P4_SwitchTable_02305C98End:
loc_02305CB0:
	ldr r2,[pool_02305F64]	; 02305CB0
	ldr r0,[pool_02305F84]	; 02305CB2
	strh r2,[r0,#0x0]	; 02305CB4
	mov r2,#0x3f	; 02305CB6
	ldr r0,[pool_02305F88]	; 02305CB8
	strh r2,[r0,#0x0]	; 02305CBA
	ldr r2,[pool_02305F8C]	; 02305CBC
	ldr r0,[pool_02305F90]	; 02305CBE
	strh r2,[r0,#0x0]	; 02305CC0
	ldr r1,[r1,#0x0]	; 02305CC2
	ldr r0,[pool_02305F94]	; 02305CC4
	ldrh r1,[r1,r0]	; 02305CC6
	mov r0,#0x8	; 02305CC8
	and r1,r0	; 02305CCA
	cmp r1,#0x0	; 02305CCC
	beq loc_02305CD6	; 02305CCE
	ldr r1,[pool_02305F98]	; 02305CD0
	ldr r0,[pool_02305F9C]	; 02305CD2
	strh r1,[r0,#0x0]	; 02305CD4
loc_02305CD6:
	ldr r1,[pool_02305F64]	; 02305CD6
	ldr r0,[pool_02305FA0]	; 02305CD8
	strh r1,[r0,#0x0]	; 02305CDA
	mov r1,#0x8	; 02305CDC
	ldr r0,[pool_02305FA4]	; 02305CDE
	strh r1,[r0,#0x0]	; 02305CE0
	mov r1,#0x0	; 02305CE2
	ldr r0,[pool_02305FA8]	; 02305CE4
	strh r1,[r0,#0x0]	; 02305CE6
	ldr r0,[pool_02305FAC]	; 02305CE8
	strh r1,[r0,#0x0]	; 02305CEA
	ldr r0,[pool_02305F74]	; 02305CEC
	strh r1,[r0,#0x0]	; 02305CEE
	mov r1,#0x1	; 02305CF0
	ldr r0,[pool_02305FB0]	; 02305CF2
	strh r1,[r0,#0x0]	; 02305CF4
	mov r0,#0x40	; 02305CF6
	bl loc_0230646C	; 02305CF8
	b loc_02305F02	; 02305CFC
loc_02305CFE:
	ldr r2,[pool_02305FB4]	; 02305CFE
	ldr r0,[pool_02305F84]	; 02305D00
	strh r2,[r0,#0x0]	; 02305D02
	ldr r2,[pool_02305FB8]	; 02305D04
	ldr r0,[pool_02305F88]	; 02305D06
	strh r2,[r0,#0x0]	; 02305D08
	ldr r2,[pool_02305F8C]	; 02305D0A
	ldr r0,[pool_02305F90]	; 02305D0C
	strh r2,[r0,#0x0]	; 02305D0E
	mov r2,#0x0	; 02305D10
	ldr r0,[pool_02305F9C]	; 02305D12
	strh r2,[r0,#0x0]	; 02305D14
	ldr r2,[r1,#0x0]	; 02305D16
	ldr r1,[pool_02305F94]	; 02305D18
	ldrh r2,[r2,r1]	; 02305D1A
	mov r1,#0x8	; 02305D1C
	and r2,r1	; 02305D1E
	cmp r2,#0x0	; 02305D20
	beq loc_02305D2C	; 02305D22
	ldrh r2,[r0,#0x0]	; 02305D24
	ldr r1,[pool_02305F98]	; 02305D26
	orr r2,r1	; 02305D28
	strh r2,[r0,#0x0]	; 02305D2A
loc_02305D2C:
	ldr r1,[pool_02305FBC]	; 02305D2C
	ldr r0,[pool_02305FA0]	; 02305D2E
	strh r1,[r0,#0x0]	; 02305D30
	mov r1,#0xd	; 02305D32
	ldr r0,[pool_02305FA4]	; 02305D34
	strh r1,[r0,#0x0]	; 02305D36
	ldr r1,[pool_02305FC0]	; 02305D38
	ldr r0,[pool_02305FA8]	; 02305D3A
	strh r1,[r0,#0x0]	; 02305D3C
	mov r6,#0x0	; 02305D3E
	ldr r0,[pool_02305FAC]	; 02305D40
	strh r6,[r0,#0x0]	; 02305D42
	mov r1,#0x1	; 02305D44
	ldr r0,[pool_02305FB0]	; 02305D46
	strh r1,[r0,#0x0]	; 02305D48
	add r5,sp,#0x0	; 02305D4A
	ldr r0,[pool_02305FC4]	; 02305D4C
	ldrh r0,[r0,#0x0]	; 02305D4E
	strh r0,[r5,#0x0]	; 02305D50
	ldr r0,[pool_02305FC8]	; 02305D52
	ldrh r0,[r0,#0x0]	; 02305D54
	strh r0,[r5,#0x2]	; 02305D56
	ldr r0,[pool_02305FCC]	; 02305D58
	ldrh r0,[r0,#0x0]	; 02305D5A
	strh r0,[r5,#0x4]	; 02305D5C
	ldr r0,[pool_02305FD0]	; 02305D5E
	ldrh r0,[r0,#0x0]	; 02305D60
	strh r0,[r5,#0x6]	; 02305D62
	ldr r0,[pool_02305F48]	; 02305D64
	ldr r1,[r0,#0x0]	; 02305D66
	ldr r0,[pool_02305FD4]	; 02305D68
	ldrh r0,[r1,r0]	; 02305D6A
	lsl r4,r0,#0xa	; 02305D6C
	ldr r0,[sp,#0x0]	; 02305D6E
	ldr r1,[sp,#0x4]	; 02305D70
	add r2,r4,#0x0	; 02305D72
	add r3,r6,#0x0	; 02305D74
	bl loc_02306014	; 02305D76
	str r0,[sp,#0x0]	; 02305D7A
	str r1,[sp,#0x4]	; 02305D7C
	lsl r3,r6,#0	; 02305D7E
	mov r2,#0x1	; 02305D80
	add r0,r0,r2	; 02305D82
	adc r1,r3	; 02305D84
	str r0,[sp,#0x0]	; 02305D86
	str r1,[sp,#0x4]	; 02305D88
	add r2,r4,#0x0	; 02305D8A
	bl loc_02306020	; 02305D8C
	str r0,[sp,#0x0]	; 02305D90
	str r1,[sp,#0x4]	; 02305D92
	ldrh r1,[r5,#0x6]	; 02305D94
	ldr r0,[pool_02305FD8]	; 02305D96
	strh r1,[r0,#0x0]	; 02305D98
	ldrh r1,[r5,#0x4]	; 02305D9A
	ldr r0,[pool_02305FDC]	; 02305D9C
	strh r1,[r0,#0x0]	; 02305D9E
	ldrh r1,[r5,#0x2]	; 02305DA0
	ldr r0,[pool_02305FE0]	; 02305DA2
	strh r1,[r0,#0x0]	; 02305DA4
	ldrh r2,[r5,#0x0]	; 02305DA6
	mov r1,#0x1	; 02305DA8
	orr r2,r1	; 02305DAA
	ldr r0,[pool_02305FE4]	; 02305DAC
	strh r2,[r0,#0x0]	; 02305DAE
	ldr r0,[pool_02305FE8]	; 02305DB0
	strh r1,[r0,#0x0]	; 02305DB2
	mov r0,#0x40	; 02305DB4
	bl loc_0230646C	; 02305DB6
	bl loc_0230CA54	; 02305DBA
	mov r1,#0x2	; 02305DBE
	ldr r0,[pool_02305FEC]	; 02305DC0
	strh r1,[r0,#0x0]	; 02305DC2
	b loc_02305F02	; 02305DC4
loc_02305DC6:
	ldr r2,[pool_02305F64]	; 02305DC6
	ldr r0,[pool_02305F84]	; 02305DC8
	strh r2,[r0,#0x0]	; 02305DCA
	ldr r2,[pool_02305FF0]	; 02305DCC
	ldr r0,[pool_02305F88]	; 02305DCE
	strh r2,[r0,#0x0]	; 02305DD0
	ldr r2,[r1,#0x0]	; 02305DD2
	ldr r1,[pool_02305F94]	; 02305DD4
	ldrh r2,[r2,r1]	; 02305DD6
	mov r1,#0x20	; 02305DD8
	and r2,r1	; 02305DDA
	cmp r2,#0x0	; 02305DDC
	beq loc_02305DE8	; 02305DDE
	ldrh r2,[r0,#0x0]	; 02305DE0
	mov r1,#0xc0	; 02305DE2
	orr r2,r1	; 02305DE4
	strh r2,[r0,#0x0]	; 02305DE6
loc_02305DE8:
	ldr r1,[pool_02305F8C]	; 02305DE8
	ldr r0,[pool_02305F90]	; 02305DEA
	strh r1,[r0,#0x0]	; 02305DEC
	mov r1,#0x0	; 02305DEE
	ldr r0,[pool_02305F9C]	; 02305DF0
	strh r1,[r0,#0x0]	; 02305DF2
	ldr r1,[pool_02305F48]	; 02305DF4
	ldr r2,[r1,#0x0]	; 02305DF6
	ldr r1,[pool_02305F94]	; 02305DF8
	ldrh r2,[r2,r1]	; 02305DFA
	mov r1,#0x8	; 02305DFC
	and r2,r1	; 02305DFE
	cmp r2,#0x0	; 02305E00
	beq loc_02305E0C	; 02305E02
	ldrh r2,[r0,#0x0]	; 02305E04
	ldr r1,[pool_02305F98]	; 02305E06
	orr r2,r1	; 02305E08
	strh r2,[r0,#0x0]	; 02305E0A
loc_02305E0C:
	ldr r0,[pool_02305F48]	; 02305E0C
	ldr r1,[r0,#0x0]	; 02305E0E
	ldr r0,[pool_02305F94]	; 02305E10
	ldrh r1,[r1,r0]	; 02305E12
	mov r0,#0x20	; 02305E14
	and r1,r0	; 02305E16
	cmp r1,#0x0	; 02305E18
	beq loc_02305E26	; 02305E1A
	ldr r2,[pool_02305F9C]	; 02305E1C
	ldrh r1,[r2,#0x0]	; 02305E1E
	mov r0,#0x68	; 02305E20
	orr r1,r0	; 02305E22
	strh r1,[r2,#0x0]	; 02305E24
loc_02305E26:
	ldr r0,[pool_02305F48]	; 02305E26
	ldr r1,[r0,#0x0]	; 02305E28
	ldr r0,[pool_02305FF4]	; 02305E2A
	ldrh r1,[r1,r0]	; 02305E2C
	mov r0,#0x1	; 02305E2E
	and r1,r0	; 02305E30
	cmp r1,#0x0	; 02305E32
	beq loc_02305E3E	; 02305E34
	ldr r1,[pool_02305FF8]	; 02305E36
	ldr r0,[pool_02305FA0]	; 02305E38
	strh r1,[r0,#0x0]	; 02305E3A
	b loc_02305E44	; 02305E3C
loc_02305E3E:
	ldr r1,[pool_02305FFC]	; 02305E3E
	ldr r0,[pool_02305FA0]	; 02305E40
	strh r1,[r0,#0x0]	; 02305E42
loc_02305E44:
	mov r1,#0xb	; 02305E44
	ldr r0,[pool_02305FA4]	; 02305E46
	strh r1,[r0,#0x0]	; 02305E48
	mov r1,#0x0	; 02305E4A
	ldr r0,[pool_02305FA8]	; 02305E4C
	strh r1,[r0,#0x0]	; 02305E4E
	ldr r0,[pool_02305FAC]	; 02305E50
	strh r1,[r0,#0x0]	; 02305E52
	mov r1,#0x1	; 02305E54
	ldr r0,[pool_02305FB0]	; 02305E56
	strh r1,[r0,#0x0]	; 02305E58
	ldr r0,[pool_02305F74]	; 02305E5A
	strh r1,[r0,#0x0]	; 02305E5C
	ldr r0,[pool_02305FE8]	; 02305E5E
	strh r1,[r0,#0x0]	; 02305E60
	mov r0,#0x20	; 02305E62
	bl loc_0230646C	; 02305E64
	b loc_02305F02	; 02305E68
loc_02305E6A:
	ldr r2,[pool_02305F64]	; 02305E6A
	ldr r0,[pool_02305F84]	; 02305E6C
	strh r2,[r0,#0x0]	; 02305E6E
	ldr r2,[pool_02306000]	; 02305E70
	ldr r0,[pool_02305F88]	; 02305E72
	strh r2,[r0,#0x0]	; 02305E74
	ldr r2,[pool_02305F8C]	; 02305E76
	ldr r0,[pool_02305F90]	; 02305E78
	strh r2,[r0,#0x0]	; 02305E7A
	mov r2,#0x0	; 02305E7C
	ldr r0,[pool_02305F9C]	; 02305E7E
	strh r2,[r0,#0x0]	; 02305E80
	ldr r2,[r1,#0x0]	; 02305E82
	ldr r1,[pool_02305F94]	; 02305E84
	ldrh r2,[r2,r1]	; 02305E86
	mov r1,#0x8	; 02305E88
	and r2,r1	; 02305E8A
	cmp r2,#0x0	; 02305E8C
	beq loc_02305E98	; 02305E8E
	ldrh r2,[r0,#0x0]	; 02305E90
	ldr r1,[pool_02305F98]	; 02305E92
	orr r2,r1	; 02305E94
	strh r2,[r0,#0x0]	; 02305E96
loc_02305E98:
	ldr r0,[pool_02305F48]	; 02305E98
	ldr r1,[r0,#0x0]	; 02305E9A
	ldr r0,[pool_02305FF4]	; 02305E9C
	ldrh r0,[r1,r0]	; 02305E9E
	mov r1,#0x1	; 02305EA0
	and r0,r1	; 02305EA2
	cmp r0,#0x0	; 02305EA4
	beq loc_02305EB0	; 02305EA6
	ldr r1,[pool_02306004]	; 02305EA8
	ldr r0,[pool_02305FA0]	; 02305EAA
	strh r1,[r0,#0x0]	; 02305EAC
	b loc_02305EB4	; 02305EAE
loc_02305EB0:
	ldr r0,[pool_02305FA0]	; 02305EB0
	strh r1,[r0,#0x0]	; 02305EB2
loc_02305EB4:
	mov r1,#0xb	; 02305EB4
	ldr r0,[pool_02305FA4]	; 02305EB6
	strh r1,[r0,#0x0]	; 02305EB8
	mov r0,#0x0	; 02305EBA
	ldr r1,[pool_02305FA8]	; 02305EBC
	strh r0,[r1,#0x0]	; 02305EBE
	ldr r1,[pool_02305FAC]	; 02305EC0
	strh r0,[r1,#0x0]	; 02305EC2
	mov r2,#0x1	; 02305EC4
	ldr r1,[pool_02305FB0]	; 02305EC6
	strh r2,[r1,#0x0]	; 02305EC8
	ldr r1,[pool_02305F74]	; 02305ECA
	strh r2,[r1,#0x0]	; 02305ECC
	ldr r1,[pool_02305FE8]	; 02305ECE
	strh r2,[r1,#0x0]	; 02305ED0
	ldr r1,[pool_02306008]	; 02305ED2
	strh r0,[r1,#0x0]	; 02305ED4
	mov r0,#0x20	; 02305ED6
	bl loc_0230646C	; 02305ED8
	b loc_02305F02	; 02305EDC
loc_02305EDE:
	ldr r1,[pool_02305F64]	; 02305EDE
	ldr r0,[pool_02305F84]	; 02305EE0
	strh r1,[r0,#0x0]	; 02305EE2
	mov r1,#0x0	; 02305EE4
	ldr r0,[pool_02305F88]	; 02305EE6
	strh r1,[r0,#0x0]	; 02305EE8
	ldr r0,[pool_02305F90]	; 02305EEA
	strh r1,[r0,#0x0]	; 02305EEC
	ldr r0,[pool_02305FA8]	; 02305EEE
	strh r1,[r0,#0x0]	; 02305EF0
	ldr r0,[pool_02305FAC]	; 02305EF2
	strh r1,[r0,#0x0]	; 02305EF4
	mov r1,#0x1	; 02305EF6
	ldr r0,[pool_02305FB0]	; 02305EF8
	strh r1,[r0,#0x0]	; 02305EFA
	mov r0,#0x20	; 02305EFC
	bl loc_0230646C	; 02305EFE
loc_02305F02:
	mov r1,#0x0	; 02305F02
	ldr r0,[pool_02306008]	; 02305F04
	strh r1,[r0,#0x0]	; 02305F06
	bl loc_02306698	; 02305F08
	mov r0,#0x2	; 02305F0C
	ldr r1,[pool_02305FEC]	; 02305F0E
	strh r0,[r1,#0x0]	; 02305F10
	ldr r1,[pool_02305F48]	; 02305F12
	ldr r2,[r1,#0x0]	; 02305F14
	ldr r1,[pool_02305F58]	; 02305F16
	ldrh r1,[r2,r1]	; 02305F18
	lsl r1,r1,#0x1f	; 02305F1A
	lsr r1,r1,#0x1f	; 02305F1C
	cmp r1,#0x1	; 02305F1E
	bne loc_02305F26	; 02305F20
	bl loc_02306814	; 02305F22
loc_02305F26:
	ldr r3,[pool_0230600C]	; 02305F26
	ldr r1,[pool_02306010]	; 02305F28
	mov r0,#0x80	; 02305F2A
	b loc_02305F38	; 02305F2C
loc_02305F2E:
	ldrh r2,[r1,#0x0]	; 02305F2E
	and r2,r0	; 02305F30
	cmp r2,#0x0	; 02305F32
	bne loc_02305F3C	; 02305F34
	sub r3,r3,#0x1	; 02305F36
loc_02305F38:
	cmp r3,#0x0	; 02305F38
	bne loc_02305F2E	; 02305F3A
loc_02305F3C:
	add sp,#0x8	; 02305F3C
	pop {r4,r5,r6}	; 02305F3E
	pop {r3}	; 02305F40
	bx r3	; 02305F42
pool_02305F44:
loc_02305F44:
	.word REG_WIFI_RANDOM	; 02305F44
pool_02305F48:
loc_02305F48:
	.word FirmwareWlWorkPointerSlot	; 02305F48
pool_02305F4C:
loc_02305F4C:
	.word 0x00000378	; 02305F4C
pool_02305F50:
loc_02305F50:
	.word 0x000002FE	; 02305F50
pool_02305F54:
loc_02305F54:
	.word 0x000002F8	; 02305F54
pool_02305F58:
loc_02305F58:
	.word 0x00000316	; 02305F58
pool_02305F5C:
loc_02305F5C:
	.word 0x00008000	; 02305F5C
pool_02305F60:
loc_02305F60:
	.word REG_WIFI_WEP_CNT	; 02305F60
pool_02305F64:
loc_02305F64:
	.word 0x0000FFFF	; 02305F64
pool_02305F68:
loc_02305F68:
	.word REG_WIFI_POST_BEACON	; 02305F68
pool_02305F6C:
loc_02305F6C:
	.word REG_WIFI_AID_FULL	; 02305F6C
pool_02305F70:
loc_02305F70:
	.word REG_WIFI_AID_LOW	; 02305F70
pool_02305F74:
loc_02305F74:
	.word REG_WIFI_US_COUNTCNT	; 02305F74
pool_02305F78:
loc_02305F78:
	.word REG_WIFI_POWER_TX	; 02305F78
pool_02305F7C:
loc_02305F7C:
	.word REG_WIFI_RXCNT	; 02305F7C
pool_02305F80:
loc_02305F80:
	.word 0x00000314	; 02305F80
pool_02305F84:
loc_02305F84:
	.word REG_WIFI_IF	; 02305F84
pool_02305F88:
loc_02305F88:
	.word REG_WIFI_IE	; 02305F88
pool_02305F8C:
loc_02305F8C:
	.word 0x00001FFF	; 02305F8C
pool_02305F90:
loc_02305F90:
	.word REG_WIFI_RXSTAT_OVF_IE	; 02305F90
pool_02305F94:
loc_02305F94:
	.word 0x0000061C	; 02305F94
pool_02305F98:
loc_02305F98:
	.word 0x00000400	; 02305F98
pool_02305F9C:
loc_02305F9C:
	.word REG_WIFI_RXSTAT_INC_IE	; 02305F9C
pool_02305FA0:
loc_02305FA0:
	.word REG_WIFI_RXFILTER	; 02305FA0
pool_02305FA4:
loc_02305FA4:
	.word REG_WIFI_RXFILTER2	; 02305FA4
pool_02305FA8:
loc_02305FA8:
	.word REG_WIFI_TXSTATCNT	; 02305FA8
pool_02305FAC:
loc_02305FAC:
	.word REG_WIFI_UNKNOWN_00A	; 02305FAC
pool_02305FB0:
loc_02305FB0:
	.word REG_WIFI_MODE_RST	; 02305FB0
pool_02305FB4:
loc_02305FB4:
	.word 0x00000FFF	; 02305FB4
pool_02305FB8:
loc_02305FB8:
	.word 0x0000703F	; 02305FB8
pool_02305FBC:
loc_02305FBC:
	.word 0x00000301	; 02305FBC
pool_02305FC0:
loc_02305FC0:
	.word 0x0000E000	; 02305FC0
pool_02305FC4:
loc_02305FC4:
	.word REG_WIFI_US_COUNT0	; 02305FC4
pool_02305FC8:
loc_02305FC8:
	.word REG_WIFI_US_COUNT1	; 02305FC8
pool_02305FCC:
loc_02305FCC:
	.word REG_WIFI_US_COUNT2	; 02305FCC
pool_02305FD0:
loc_02305FD0:
	.word REG_WIFI_US_COUNT3	; 02305FD0
pool_02305FD4:
loc_02305FD4:
	.word 0x0000036A	; 02305FD4
pool_02305FD8:
loc_02305FD8:
	.word REG_WIFI_US_COMPARE3	; 02305FD8
pool_02305FDC:
loc_02305FDC:
	.word REG_WIFI_US_COMPARE2	; 02305FDC
pool_02305FE0:
loc_02305FE0:
	.word REG_WIFI_US_COMPARE1	; 02305FE0
pool_02305FE4:
loc_02305FE4:
	.word REG_WIFI_US_COMPARE0	; 02305FE4
pool_02305FE8:
loc_02305FE8:
	.word REG_WIFI_US_COMPARECNT	; 02305FE8
pool_02305FEC:
loc_02305FEC:
	.word REG_WIFI_TXREQ_SET	; 02305FEC
pool_02305FF0:
loc_02305FF0:
	.word 0x0000E03F	; 02305FF0
pool_02305FF4:
loc_02305FF4:
	.word 0x00000360	; 02305FF4
pool_02305FF8:
loc_02305FF8:
	.word 0x00000581	; 02305FF8
pool_02305FFC:
loc_02305FFC:
	.word 0x00000181	; 02305FFC
pool_02306000:
loc_02306000:
	.word 0x0000C03F	; 02306000
pool_02306004:
loc_02306004:
	.word 0x00000401	; 02306004
pool_02306008:
loc_02306008:
	.word REG_WIFI_UNKNOWN_048	; 02306008
pool_0230600C:
loc_0230600C:
	.word 0x00000FA0	; 0230600C
pool_02306010:
loc_02306010:
	.word REG_WIFI_RF_PINS	; 02306010

; ===== function loc_02306014 =====
loc_02306014:
	bx pc	; 02306014
	.byte 0xC0, 0x46	; 02306018
.arm

; ===== function loc_02306018 =====
loc_02306018:
	ldr pc,[pool_0230601C]	; 02306018
pool_0230601C:
loc_0230601C:
	.word loc_038022BC	; 0230601C
.thumb

; ===== function loc_02306020 =====
loc_02306020:
	bx pc	; 02306020
	.byte 0xC0, 0x46	; 02306024
.arm

; ===== function loc_02306024 =====
loc_02306024:
	ldr pc,[pool_02306028]	; 02306024
pool_02306028:
loc_02306028:
	.word loc_038024C4	; 02306028
.thumb

; ===== function loc_0230602C =====
loc_0230602C:
	ldr r0,[pool_02306058]	; 0230602C
	ldr r1,[r0,#0x0]	; 0230602E
	ldr r0,[pool_0230605C]	; 02306030
	ldrh r0,[r1,r0]	; 02306032
	cmp r0,#0x0	; 02306034
	beq loc_0230603E	; 02306036
	cmp r0,#0x1	; 02306038
	beq loc_0230604E	; 0230603A
	b loc_02306052	; 0230603C
loc_0230603E:
	ldr r0,[pool_02306060]	; 0230603E
	ldrh r1,[r1,r0]	; 02306040
	mov r0,#0x1	; 02306042
	and r1,r0	; 02306044
	cmp r1,#0x0	; 02306046
	beq loc_02306052	; 02306048
	mov r0,#0xa	; 0230604A
	bx lr	; 0230604C
loc_0230604E:
	mov r0,#0xa	; 0230604E
	bx lr	; 02306050
loc_02306052:
	mov r0,#0x14	; 02306052
	bx lr	; 02306054
	.byte 0xC0, 0x46	; 02306058
pool_02306058:
loc_02306058:
	.word FirmwareWlWorkPointerSlot	; 02306058
pool_0230605C:
loc_0230605C:
	.word 0x000002F4	; 0230605C
pool_02306060:
loc_02306060:
	.word 0x0000035C	; 02306060

; ===== function loc_02306064 =====
loc_02306064:
	push {r4,r5,r6,r7,lr}	; 02306064
	sub sp,#0x4	; 02306066
	add r6,r0,#0x0	; 02306068
	add r5,r1,#0x0	; 0230606A
	mov r0,#0x0	; 0230606C
	strh r0,[r5,#0x0]	; 0230606E
	strh r0,[r5,#0x2]	; 02306070
	add r0,r6,#0x1	; 02306072
	bl loc_023053B8	; 02306074
	add r7,r0,#0x0	; 02306078
	mov r4,#0x0	; 0230607A
	b loc_023060D4	; 0230607C
loc_0230607E:
	add r0,r6,#0x2	; 0230607E
	add r0,r0,r4	; 02306080
	bl loc_023053B8	; 02306082
	add r2,r0,#0x0	; 02306086
	mov r1,#0x7f	; 02306088
	and r2,r1	; 0230608A
	sub r1,r2,#0x1	; 0230608C
	cmp r1,#0x78	; 0230608E
	bcs loc_023060B8	; 02306090
	lsl r2,r1,#0x1	; 02306092
	ldr r1,[pool_023060E0]	; 02306094
	ldrh r1,[r1,r2]	; 02306096
	cmp r1,#0xff	; 02306098
	beq loc_023060B8	; 0230609A
	mov r3,#0x1	; 0230609C
	lsl r3,r1	; 0230609E
	add r2,r5,#0x2	; 023060A0
	ldrh r1,[r2,#0x0]	; 023060A2
	orr r1,r3	; 023060A4
	strh r1,[r2,#0x0]	; 023060A6
	mov r1,#0x80	; 023060A8
	and r0,r1	; 023060AA
	cmp r0,#0x0	; 023060AC
	beq loc_023060D2	; 023060AE
	ldrh r0,[r5,#0x0]	; 023060B0
	orr r0,r3	; 023060B2
	strh r0,[r5,#0x0]	; 023060B4
	b loc_023060D2	; 023060B6
loc_023060B8:
	add r3,r5,#0x2	; 023060B8
	ldrh r2,[r3,#0x0]	; 023060BA
	ldr r1,[pool_023060E4]	; 023060BC
	orr r2,r1	; 023060BE
	strh r2,[r3,#0x0]	; 023060C0
	mov r1,#0x80	; 023060C2
	and r0,r1	; 023060C4
	cmp r0,#0x0	; 023060C6
	beq loc_023060D2	; 023060C8
	ldrh r1,[r5,#0x0]	; 023060CA
	ldr r0,[pool_023060E4]	; 023060CC
	orr r1,r0	; 023060CE
	strh r1,[r5,#0x0]	; 023060D0
loc_023060D2:
	add r4,r4,#0x1	; 023060D2
loc_023060D4:
	cmp r4,r7	; 023060D4
	bcc loc_0230607E	; 023060D6
	add sp,#0x4	; 023060D8
	pop {r4,r5,r6,r7}	; 023060DA
	pop {r3}	; 023060DC
	bx r3	; 023060DE
pool_023060E0:
loc_023060E0:
	.word P4_Data_023104C4	; 023060E0
pool_023060E4:
loc_023060E4:
	.word 0x00008000	; 023060E4

; ===== function loc_023060E8 =====
loc_023060E8:
	push {r4,r5,r6,r7,lr}	; 023060E8
	sub sp,#0xc	; 023060EA
	add r5,r0,#0x0	; 023060EC
	str r1,[sp,#0x0]	; 023060EE
	cmp r5,#0x20	; 023060F0
	bls loc_023060F8	; 023060F2
	mov r0,#0x0	; 023060F4
	b loc_02306158	; 023060F6
loc_023060F8:
	ldr r0,[pool_02306160]	; 023060F8
	ldr r1,[r0,#0x0]	; 023060FA
	ldr r0,[pool_02306164]	; 023060FC
	ldrh r0,[r1,r0]	; 023060FE
	cmp r0,#0x0	; 02306100
	bne loc_02306108	; 02306102
	mov r0,#0x1	; 02306104
	b loc_02306158	; 02306106
loc_02306108:
	cmp r5,r0	; 02306108
	beq loc_02306110	; 0230610A
	mov r0,#0x0	; 0230610C
	b loc_02306158	; 0230610E
loc_02306110:
	ldr r0,[pool_02306168]	; 02306110
	add r6,r1,r0	; 02306112
	ldr r0,[pool_0230616C]	; 02306114
	add r7,r1,r0	; 02306116
	mov r4,#0x0	; 02306118
	b loc_02306152	; 0230611A
loc_0230611C:
	add r0,r7,#0x0	; 0230611C
	bl loc_023053B8	; 0230611E
	str r0,[sp,#0x4]	; 02306122
	add r7,r7,#0x1	; 02306124
	ldr r0,[sp,#0x0]	; 02306126
	bl loc_023053B8	; 02306128
	str r0,[sp,#0x8]	; 0230612C
	ldr r0,[sp,#0x0]	; 0230612E
	add r0,r0,#0x1	; 02306130
	str r0,[sp,#0x0]	; 02306132
	add r0,r6,#0x0	; 02306134
	bl loc_023053B8	; 02306136
	add r6,r6,#0x1	; 0230613A
	ldr r2,[sp,#0x8]	; 0230613C
	ldr r1,[sp,#0x4]	; 0230613E
	orr r2,r1	; 02306140
	str r2,[sp,#0x8]	; 02306142
	orr r0,r1	; 02306144
	lsl r1,r2,#0	; 02306146
	cmp r1,r0	; 02306148
	beq loc_02306150	; 0230614A
	mov r0,#0x0	; 0230614C
	b loc_02306158	; 0230614E
loc_02306150:
	add r4,r4,#0x1	; 02306150
loc_02306152:
	cmp r4,r5	; 02306152
	bcc loc_0230611C	; 02306154
	mov r0,#0x1	; 02306156
loc_02306158:
	add sp,#0xc	; 02306158
	pop {r4,r5,r6,r7}	; 0230615A
	pop {r3}	; 0230615C
	bx r3	; 0230615E
pool_02306160:
loc_02306160:
	.word FirmwareWlWorkPointerSlot	; 02306160
pool_02306164:
loc_02306164:
	.word 0x0000031A	; 02306164
pool_02306168:
loc_02306168:
	.word 0x0000031C	; 02306168
pool_0230616C:
loc_0230616C:
	.word 0x0000033C	; 0230616C

; ===== function loc_02306170 =====
loc_02306170:
	push {r4,r5,lr}	; 02306170
	sub sp,#0x4	; 02306172
	ldr r0,[pool_02306390]	; 02306174
	ldr r1,[r0,#0x0]	; 02306176
	ldr r0,[pool_02306394]	; 02306178
	add r0,r1,r0	; 0230617A
	ldr r1,[pool_02306398]	; 0230617C
	ldrh r2,[r1,#0x0]	; 0230617E
	add r4,r0,#0x0	; 02306180
	add r4,#0x50	; 02306182
	ldr r3,[r4,#0x0]	; 02306184
	mov r1,#0xff	; 02306186
	and r2,r1	; 02306188
	lsl r2,r2,#0x10	; 0230618A
	lsr r2,r2,#0x10	; 0230618C
	add r2,r3,r2	; 0230618E
	str r2,[r4,#0x0]	; 02306190
	ldr r2,[pool_0230639C]	; 02306192
	ldrh r2,[r2,#0x0]	; 02306194
	add r5,r0,#0x0	; 02306196
	add r5,#0x4c	; 02306198
	ldr r4,[r5,#0x0]	; 0230619A
	lsl r3,r2,#0x8	; 0230619C
	lsr r3,r3,#0x10	; 0230619E
	add r3,r4,r3	; 023061A0
	str r3,[r5,#0x0]	; 023061A2
	add r4,r0,#0x0	; 023061A4
	add r4,#0x5c	; 023061A6
	ldr r3,[r4,#0x0]	; 023061A8
	and r2,r1	; 023061AA
	lsl r2,r2,#0x10	; 023061AC
	lsr r2,r2,#0x10	; 023061AE
	add r2,r3,r2	; 023061B0
	str r2,[r4,#0x0]	; 023061B2
	ldr r2,[pool_023063A0]	; 023061B4
	ldrh r2,[r2,#0x0]	; 023061B6
	add r5,r0,#0x0	; 023061B8
	add r5,#0x58	; 023061BA
	ldr r4,[r5,#0x0]	; 023061BC
	lsl r3,r2,#0x8	; 023061BE
	lsr r3,r3,#0x10	; 023061C0
	add r3,r4,r3	; 023061C2
	str r3,[r5,#0x0]	; 023061C4
	add r4,r0,#0x0	; 023061C6
	add r4,#0x54	; 023061C8
	ldr r3,[r4,#0x0]	; 023061CA
	and r2,r1	; 023061CC
	lsl r2,r2,#0x10	; 023061CE
	lsr r2,r2,#0x10	; 023061D0
	add r2,r3,r2	; 023061D2
	str r2,[r4,#0x0]	; 023061D4
	ldr r2,[pool_023063A4]	; 023061D6
	ldrh r2,[r2,#0x0]	; 023061D8
	add r5,r0,#0x0	; 023061DA
	add r5,#0x60	; 023061DC
	ldr r4,[r5,#0x0]	; 023061DE
	lsl r3,r2,#0x8	; 023061E0
	lsr r3,r3,#0x10	; 023061E2
	add r3,r4,r3	; 023061E4
	str r3,[r5,#0x0]	; 023061E6
	add r4,r0,#0x0	; 023061E8
	add r4,#0x38	; 023061EA
	ldr r3,[r4,#0x0]	; 023061EC
	and r2,r1	; 023061EE
	lsl r2,r2,#0x10	; 023061F0
	lsr r2,r2,#0x10	; 023061F2
	add r2,r3,r2	; 023061F4
	str r2,[r4,#0x0]	; 023061F6
	ldr r2,[pool_023063A8]	; 023061F8
	ldrh r2,[r2,#0x0]	; 023061FA
	add r4,r0,#0x0	; 023061FC
	add r4,#0x48	; 023061FE
	ldr r3,[r4,#0x0]	; 02306200
	and r2,r1	; 02306202
	lsl r2,r2,#0x10	; 02306204
	lsr r2,r2,#0x10	; 02306206
	add r2,r3,r2	; 02306208
	str r2,[r4,#0x0]	; 0230620A
	ldr r2,[pool_023063AC]	; 0230620C
	ldrh r2,[r2,#0x0]	; 0230620E
	add r4,r0,#0x0	; 02306210
	add r4,#0x20	; 02306212
	ldr r3,[r4,#0x0]	; 02306214
	and r2,r1	; 02306216
	lsl r2,r2,#0x10	; 02306218
	lsr r2,r2,#0x10	; 0230621A
	add r2,r3,r2	; 0230621C
	str r2,[r4,#0x0]	; 0230621E
	ldr r2,[pool_023063B0]	; 02306220
	ldrh r2,[r2,#0x0]	; 02306222
	add r5,r0,#0x0	; 02306224
	add r5,#0x30	; 02306226
	ldr r4,[r5,#0x0]	; 02306228
	lsl r3,r2,#0x8	; 0230622A
	lsr r3,r3,#0x10	; 0230622C
	add r3,r4,r3	; 0230622E
	str r3,[r5,#0x0]	; 02306230
	add r4,r0,#0x0	; 02306232
	add r4,#0x44	; 02306234
	ldr r3,[r4,#0x0]	; 02306236
	and r2,r1	; 02306238
	lsl r2,r2,#0x10	; 0230623A
	lsr r2,r2,#0x10	; 0230623C
	add r2,r3,r2	; 0230623E
	str r2,[r4,#0x0]	; 02306240
	ldr r2,[pool_023063B4]	; 02306242
	ldrh r3,[r2,#0x0]	; 02306244
	add r2,r0,#0x0	; 02306246
	add r2,#0x3c	; 02306248
	ldr r5,[r2,#0x0]	; 0230624A
	add r4,r3,#0x0	; 0230624C
	and r4,r1	; 0230624E
	lsl r4,r4,#0x10	; 02306250
	lsr r4,r4,#0x10	; 02306252
	add r4,r5,r4	; 02306254
	str r4,[r2,#0x0]	; 02306256
	add r5,r0,#0x0	; 02306258
	add r5,#0x40	; 0230625A
	ldr r4,[r5,#0x0]	; 0230625C
	lsl r2,r3,#0x8	; 0230625E
	lsr r2,r2,#0x10	; 02306260
	add r2,r4,r2	; 02306262
	str r2,[r5,#0x0]	; 02306264
	ldr r2,[pool_023063B8]	; 02306266
	ldrh r2,[r2,#0x0]	; 02306268
	add r4,r0,#0x0	; 0230626A
	add r4,#0xc	; 0230626C
	ldr r3,[r4,#0x0]	; 0230626E
	and r2,r1	; 02306270
	lsl r2,r2,#0x10	; 02306272
	lsr r2,r2,#0x10	; 02306274
	add r2,r3,r2	; 02306276
	str r2,[r4,#0x0]	; 02306278
	ldr r2,[pool_023063BC]	; 0230627A
	ldrh r2,[r2,#0x0]	; 0230627C
	add r4,r0,#0x0	; 0230627E
	add r4,#0x78	; 02306280
	ldr r3,[r4,#0x0]	; 02306282
	lsl r2,r2,#0x8	; 02306284
	lsr r2,r2,#0x10	; 02306286
	add r2,r3,r2	; 02306288
	str r2,[r4,#0x0]	; 0230628A
	ldr r2,[pool_023063C0]	; 0230628C
	ldrh r3,[r2,#0x0]	; 0230628E
	add r2,r0,#0x0	; 02306290
	add r2,#0x7c	; 02306292
	ldr r5,[r2,#0x0]	; 02306294
	add r4,r3,#0x0	; 02306296
	and r4,r1	; 02306298
	lsl r4,r4,#0x10	; 0230629A
	lsr r4,r4,#0x10	; 0230629C
	add r4,r5,r4	; 0230629E
	str r4,[r2,#0x0]	; 023062A0
	add r5,r0,#0x0	; 023062A2
	add r5,#0x80	; 023062A4
	ldr r4,[r5,#0x0]	; 023062A6
	lsl r2,r3,#0x8	; 023062A8
	lsr r2,r2,#0x10	; 023062AA
	add r2,r4,r2	; 023062AC
	str r2,[r5,#0x0]	; 023062AE
	ldr r2,[pool_023063C4]	; 023062B0
	ldrh r3,[r2,#0x0]	; 023062B2
	add r2,r0,#0x0	; 023062B4
	add r2,#0x84	; 023062B6
	ldr r5,[r2,#0x0]	; 023062B8
	add r4,r3,#0x0	; 023062BA
	and r4,r1	; 023062BC
	lsl r4,r4,#0x10	; 023062BE
	lsr r4,r4,#0x10	; 023062C0
	add r4,r5,r4	; 023062C2
	str r4,[r2,#0x0]	; 023062C4
	add r5,r0,#0x0	; 023062C6
	add r5,#0x88	; 023062C8
	ldr r4,[r5,#0x0]	; 023062CA
	lsl r2,r3,#0x8	; 023062CC
	lsr r2,r2,#0x10	; 023062CE
	add r2,r4,r2	; 023062D0
	str r2,[r5,#0x0]	; 023062D2
	ldr r2,[pool_023063C8]	; 023062D4
	ldrh r3,[r2,#0x0]	; 023062D6
	add r2,r0,#0x0	; 023062D8
	add r2,#0x8c	; 023062DA
	ldr r5,[r2,#0x0]	; 023062DC
	add r4,r3,#0x0	; 023062DE
	and r4,r1	; 023062E0
	lsl r4,r4,#0x10	; 023062E2
	lsr r4,r4,#0x10	; 023062E4
	add r4,r5,r4	; 023062E6
	str r4,[r2,#0x0]	; 023062E8
	add r5,r0,#0x0	; 023062EA
	add r5,#0x90	; 023062EC
	ldr r4,[r5,#0x0]	; 023062EE
	lsl r2,r3,#0x8	; 023062F0
	lsr r2,r2,#0x10	; 023062F2
	add r2,r4,r2	; 023062F4
	str r2,[r5,#0x0]	; 023062F6
	ldr r2,[pool_023063CC]	; 023062F8
	ldrh r3,[r2,#0x0]	; 023062FA
	add r2,r0,#0x0	; 023062FC
	add r2,#0x94	; 023062FE
	ldr r5,[r2,#0x0]	; 02306300
	add r4,r3,#0x0	; 02306302
	and r4,r1	; 02306304
	lsl r4,r4,#0x10	; 02306306
	lsr r4,r4,#0x10	; 02306308
	add r4,r5,r4	; 0230630A
	str r4,[r2,#0x0]	; 0230630C
	add r5,r0,#0x0	; 0230630E
	add r5,#0x98	; 02306310
	ldr r4,[r5,#0x0]	; 02306312
	lsl r2,r3,#0x8	; 02306314
	lsr r2,r2,#0x10	; 02306316
	add r2,r4,r2	; 02306318
	str r2,[r5,#0x0]	; 0230631A
	ldr r2,[pool_023063D0]	; 0230631C
	ldrh r3,[r2,#0x0]	; 0230631E
	add r2,r0,#0x0	; 02306320
	add r2,#0x9c	; 02306322
	ldr r5,[r2,#0x0]	; 02306324
	add r4,r3,#0x0	; 02306326
	and r4,r1	; 02306328
	lsl r4,r4,#0x10	; 0230632A
	lsr r4,r4,#0x10	; 0230632C
	add r4,r5,r4	; 0230632E
	str r4,[r2,#0x0]	; 02306330
	add r5,r0,#0x0	; 02306332
	add r5,#0xa0	; 02306334
	ldr r4,[r5,#0x0]	; 02306336
	lsl r2,r3,#0x8	; 02306338
	lsr r2,r2,#0x10	; 0230633A
	add r2,r4,r2	; 0230633C
	str r2,[r5,#0x0]	; 0230633E
	ldr r2,[pool_023063D4]	; 02306340
	ldrh r3,[r2,#0x0]	; 02306342
	add r2,r0,#0x0	; 02306344
	add r2,#0xa4	; 02306346
	ldr r5,[r2,#0x0]	; 02306348
	add r4,r3,#0x0	; 0230634A
	and r4,r1	; 0230634C
	lsl r4,r4,#0x10	; 0230634E
	lsr r4,r4,#0x10	; 02306350
	add r4,r5,r4	; 02306352
	str r4,[r2,#0x0]	; 02306354
	add r5,r0,#0x0	; 02306356
	add r5,#0xa8	; 02306358
	ldr r4,[r5,#0x0]	; 0230635A
	lsl r2,r3,#0x8	; 0230635C
	lsr r2,r2,#0x10	; 0230635E
	add r2,r4,r2	; 02306360
	str r2,[r5,#0x0]	; 02306362
	ldr r2,[pool_023063D8]	; 02306364
	ldrh r3,[r2,#0x0]	; 02306366
	add r2,r0,#0x0	; 02306368
	add r2,#0xac	; 0230636A
	ldr r5,[r2,#0x0]	; 0230636C
	add r4,r3,#0x0	; 0230636E
	and r4,r1	; 02306370
	lsl r1,r4,#0x10	; 02306372
	lsr r1,r1,#0x10	; 02306374
	add r1,r5,r1	; 02306376
	str r1,[r2,#0x0]	; 02306378
	add r0,#0xb0	; 0230637A
	ldr r2,[r0,#0x0]	; 0230637C
	lsl r1,r3,#0x8	; 0230637E
	lsr r1,r1,#0x10	; 02306380
	add r1,r2,r1	; 02306382
	str r1,[r0,#0x0]	; 02306384
	add sp,#0x4	; 02306386
	pop {r4,r5}	; 02306388
	pop {r3}	; 0230638A
	bx r3	; 0230638C
	.byte 0xC0, 0x46	; 02306390
pool_02306390:
loc_02306390:
	.word FirmwareWlWorkPointerSlot	; 02306390
pool_02306394:
loc_02306394:
	.word 0x000004F4	; 02306394
pool_02306398:
loc_02306398:
	.word REG_WIFI_RXSTAT	; 02306398
pool_0230639C:
loc_0230639C:
	.word REG_WIFI_RXSTAT + 0x2	; 0230639C
pool_023063A0:
loc_023063A0:
	.word REG_WIFI_RXSTAT + 0x4	; 023063A0
pool_023063A4:
loc_023063A4:
	.word REG_WIFI_RXSTAT + 0x6	; 023063A4
pool_023063A8:
loc_023063A8:
	.word REG_WIFI_RXSTAT + 0x8	; 023063A8
pool_023063AC:
loc_023063AC:
	.word REG_WIFI_RXSTAT + 0xA	; 023063AC
pool_023063B0:
loc_023063B0:
	.word REG_WIFI_RXSTAT + 0xC	; 023063B0
pool_023063B4:
loc_023063B4:
	.word REG_WIFI_RXSTAT + 0xE	; 023063B4
pool_023063B8:
loc_023063B8:
	.word REG_WIFI_TX_ERR_COUNT	; 023063B8
pool_023063BC:
loc_023063BC:
	.word REG_WIFI_CMD_STAT	; 023063BC
pool_023063C0:
loc_023063C0:
	.word REG_WIFI_CMD_STAT + 0x2	; 023063C0
pool_023063C4:
loc_023063C4:
	.word REG_WIFI_CMD_STAT + 0x4	; 023063C4
pool_023063C8:
loc_023063C8:
	.word REG_WIFI_CMD_STAT + 0x6	; 023063C8
pool_023063CC:
loc_023063CC:
	.word REG_WIFI_CMD_STAT + 0x8	; 023063CC
pool_023063D0:
loc_023063D0:
	.word REG_WIFI_CMD_STAT + 0xA	; 023063D0
pool_023063D4:
loc_023063D4:
	.word REG_WIFI_CMD_STAT + 0xC	; 023063D4
pool_023063D8:
loc_023063D8:
	.word REG_WIFI_CMD_STAT + 0xE	; 023063D8
	.byte 0x00, 0xB5, 0x81, 0xB0, 0xFF, 0xF7, 0xC6, 0xFE, 0x00, 0x20, 0x00, 0x90, 0x00, 0x98, 0x05, 0x49	; 023063EC
	.byte 0x0A, 0x68, 0x05, 0x49, 0x51, 0x18, 0xB4, 0x22, 0x00, 0xF0, 0x08, 0xF8, 0x01, 0xB0, 0x08, 0xBC	; 023063FC
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF4, 0x04, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 0230640C
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x38, 0xCE, 0x7F, 0x03	; 02306414

; ===== function loc_02306414 =====
loc_02306414:
	push {r4,lr}	; 02306414
	ldrh r4,[r1,#0x0]	; 02306416
	strh r4,[r0,#0x0]	; 02306418
	ldrh r4,[r1,#0x2]	; 0230641A
	strh r4,[r0,#0x2]	; 0230641C
	ldrh r1,[r1,#0x4]	; 0230641E
	strh r1,[r0,#0x4]	; 02306420
	ldrh r1,[r2,#0x0]	; 02306422
	strh r1,[r0,#0x6]	; 02306424
	ldrh r1,[r2,#0x2]	; 02306426
	strh r1,[r0,#0x8]	; 02306428
	ldrh r1,[r2,#0x4]	; 0230642A
	strh r1,[r0,#0xa]	; 0230642C
	ldrh r1,[r3,#0x0]	; 0230642E
	strh r1,[r0,#0xc]	; 02306430
	ldrh r1,[r3,#0x2]	; 02306432
	strh r1,[r0,#0xe]	; 02306434
	ldrh r1,[r3,#0x4]	; 02306436
	strh r1,[r0,#0x10]	; 02306438
	pop {r4}	; 0230643A
	pop {r3}	; 0230643C
	bx r3	; 0230643E

; ===== function loc_02306440 =====
loc_02306440:
	ldrh r3,[r1,#0x0]	; 02306440
	strh r3,[r0,#0x0]	; 02306442
	ldrh r3,[r1,#0x2]	; 02306444
	strh r3,[r0,#0x2]	; 02306446
	ldrh r1,[r1,#0x4]	; 02306448
	strh r1,[r0,#0x4]	; 0230644A
	ldrh r1,[r2,#0x0]	; 0230644C
	strh r1,[r0,#0x6]	; 0230644E
	ldrh r1,[r2,#0x2]	; 02306450
	strh r1,[r0,#0x8]	; 02306452
	ldrh r1,[r2,#0x4]	; 02306454
	strh r1,[r0,#0xa]	; 02306456
	bx lr	; 02306458
	.byte 0x00, 0x00	; 0230645C

; ===== function loc_0230645C =====
loc_0230645C:
	ldrh r2,[r1,#0x0]	; 0230645C
	strh r2,[r0,#0x0]	; 0230645E
	ldrh r2,[r1,#0x2]	; 02306460
	strh r2,[r0,#0x2]	; 02306462
	ldrh r1,[r1,#0x4]	; 02306464
	strh r1,[r0,#0x4]	; 02306466
	bx lr	; 02306468
	.byte 0x00, 0x00	; 0230646C

; ===== function loc_0230646C =====
loc_0230646C:
	push {r4,lr}	; 0230646C
	add r4,r0,#0x0	; 0230646E
	ldr r0,[pool_023064C8]	; 02306470
	ldr r1,[r0,#0x0]	; 02306472
	ldr r0,[pool_023064CC]	; 02306474
	ldrh r0,[r1,r0]	; 02306476
	cmp r0,r4	; 02306478
	beq loc_023064C2	; 0230647A
	cmp r0,#0x40	; 0230647C
	bne loc_02306484	; 0230647E
	bl loc_02305590	; 02306480
loc_02306484:
	cmp r4,#0x0	; 02306484
	beq loc_02306492	; 02306486
	cmp r4,#0x10	; 02306488
	beq loc_02306498	; 0230648A
	cmp r4,#0x40	; 0230648C
	beq loc_023064A2	; 0230648E
	b loc_023064BA	; 02306490
loc_02306492:
	bl loc_023067B0	; 02306492
	b loc_023064BA	; 02306496
loc_02306498:
	bl loc_02305B40	; 02306498
	bl loc_02306748	; 0230649C
	b loc_023064BA	; 023064A0
loc_023064A2:
	ldr r0,[pool_023064C8]	; 023064A2
	ldr r1,[r0,#0x0]	; 023064A4
	ldr r0,[pool_023064D0]	; 023064A6
	ldrh r0,[r1,r0]	; 023064A8
	cmp r0,#0x2	; 023064AA
	bne loc_023064B2	; 023064AC
	bl loc_02306674	; 023064AE
loc_023064B2:
	mov r0,#0x64	; 023064B2
	ldr r1,[pool_023064D4]	; 023064B4
	bl loc_023056B0	; 023064B6
loc_023064BA:
	ldr r0,[pool_023064C8]	; 023064BA
	ldr r1,[r0,#0x0]	; 023064BC
	ldr r0,[pool_023064CC]	; 023064BE
	strh r4,[r1,r0]	; 023064C0
loc_023064C2:
	pop {r4}	; 023064C2
	pop {r3}	; 023064C4
	bx r3	; 023064C6
pool_023064C8:
loc_023064C8:
	.word FirmwareWlWorkPointerSlot	; 023064C8
pool_023064CC:
loc_023064CC:
	.word 0x00000310	; 023064CC
pool_023064D0:
loc_023064D0:
	.word 0x00000314	; 023064D0
pool_023064D4:
loc_023064D4:
	.word P4_Code_02305630 + 1	; 023064D4

; ===== function loc_023064D8 =====
loc_023064D8:
	push {lr}	; 023064D8
	sub sp,#0x4	; 023064DA
	mov r3,#0x0	; 023064DC
	ldr r2,[pool_02306540]	; 023064DE
	ldr r1,[r2,#0x0]	; 023064E0
	ldr r0,[pool_02306544]	; 023064E2
	strh r3,[r1,r0]	; 023064E4
	ldr r1,[r2,#0x0]	; 023064E6
	ldr r0,[pool_02306548]	; 023064E8
	strh r3,[r1,r0]	; 023064EA
	ldr r2,[pool_0230654C]	; 023064EC
	ldr r3,[pool_02306550]	; 023064EE
	mov r0,#0x1	; 023064F0
loc_023064F2:
	ldrh r1,[r3,#0x0]	; 023064F2
	and r1,r0	; 023064F4
	cmp r1,#0x0	; 023064F6
	bne loc_023064F2	; 023064F8
	ldrh r1,[r2,#0x0]	; 023064FA
	cmp r1,#0x6	; 023064FC
	beq loc_023064F2	; 023064FE
	ldrh r1,[r2,#0x0]	; 02306500
	cmp r1,#0x5	; 02306502
	beq loc_023064F2	; 02306504
	mov r1,#0x0	; 02306506
	ldr r0,[pool_02306554]	; 02306508
	strh r1,[r0,#0x0]	; 0230650A
	ldr r0,[pool_02306558]	; 0230650C
	strh r1,[r0,#0x0]	; 0230650E
	ldr r0,[pool_02306540]	; 02306510
	ldr r1,[r0,#0x0]	; 02306512
	ldr r0,[pool_0230655C]	; 02306514
	ldrh r0,[r1,r0]	; 02306516
	cmp r0,#0x0	; 02306518
	beq loc_02306538	; 0230651A
	bl loc_0230CC80	; 0230651C
	ldr r0,[pool_02306540]	; 02306520
	ldr r1,[r0,#0x0]	; 02306522
	ldr r0,[pool_0230655C]	; 02306524
	ldrh r0,[r1,r0]	; 02306526
	mov r1,#0x20	; 02306528
	bl loc_023091F0	; 0230652A
	mov r2,#0x0	; 0230652E
	ldr r0,[pool_02306540]	; 02306530
	ldr r1,[r0,#0x0]	; 02306532
	ldr r0,[pool_0230655C]	; 02306534
	strh r2,[r1,r0]	; 02306536
loc_02306538:
	add sp,#0x4	; 02306538
	pop {r3}	; 0230653A
	bx r3	; 0230653C
	.byte 0xC0, 0x46	; 02306540
pool_02306540:
loc_02306540:
	.word FirmwareWlWorkPointerSlot	; 02306540
pool_02306544:
loc_02306544:
	.word 0x00000366	; 02306544
pool_02306548:
loc_02306548:
	.word 0x00000486	; 02306548
pool_0230654C:
loc_0230654C:
	.word REG_WIFI_RF_STATUS	; 0230654C
pool_02306550:
loc_02306550:
	.word REG_WIFI_RF_PINS	; 02306550
pool_02306554:
loc_02306554:
	.word REG_WIFI_AID_LOW	; 02306554
pool_02306558:
loc_02306558:
	.word REG_WIFI_AID_FULL	; 02306558
pool_0230655C:
loc_0230655C:
	.word 0x00000384	; 0230655C

; ===== function loc_02306560 =====
loc_02306560:
	push {r4,lr}	; 02306560
	ldr r4,[pool_02306584]	; 02306562
	ldr r2,[r4,#0x0]	; 02306564
	ldr r1,[pool_02306588]	; 02306566
	strh r0,[r2,r1]	; 02306568
	mov r3,#0x1	; 0230656A
	lsl r3,r0	; 0230656C
	ldr r2,[r4,#0x0]	; 0230656E
	ldr r1,[pool_0230658C]	; 02306570
	strh r3,[r2,r1]	; 02306572
	ldr r1,[pool_02306590]	; 02306574
	strh r0,[r1,#0x0]	; 02306576
	ldr r1,[pool_02306594]	; 02306578
	strh r0,[r1,#0x0]	; 0230657A
	pop {r4}	; 0230657C
	pop {r3}	; 0230657E
	bx r3	; 02306580
	.byte 0xC0, 0x46	; 02306584
pool_02306584:
loc_02306584:
	.word FirmwareWlWorkPointerSlot	; 02306584
pool_02306588:
loc_02306588:
	.word 0x00000366	; 02306588
pool_0230658C:
loc_0230658C:
	.word 0x00000486	; 0230658C
pool_02306590:
loc_02306590:
	.word REG_WIFI_AID_FULL	; 02306590
pool_02306594:
loc_02306594:
	.word REG_WIFI_AID_LOW	; 02306594
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0F, 0x1C, 0x80, 0x2D, 0x01, 0xD9, 0x04, 0x20, 0x2E, 0xE0	; 023065A8
	.byte 0x00, 0x2D, 0x23, 0xD0, 0x18, 0x48, 0x01, 0x68, 0x18, 0x48, 0x0A, 0x5A, 0x01, 0x20, 0x02, 0x40	; 023065B8
	.byte 0x00, 0x2A, 0x15, 0xD0, 0x16, 0x48, 0x0C, 0x58, 0x20, 0x1C, 0xFF, 0x21, 0xFE, 0xF7, 0x0A, 0xFF	; 023065C8
	.byte 0x64, 0x1C, 0x00, 0x26, 0x09, 0xE0, 0x38, 0x1C, 0xFE, 0xF7, 0xF2, 0xFE, 0x01, 0x1C, 0x20, 0x1C	; 023065D8
	.byte 0xFE, 0xF7, 0x00, 0xFF, 0x64, 0x1C, 0x7F, 0x1C, 0x76, 0x1C, 0xAE, 0x42, 0xF3, 0xD3, 0x05, 0xE0	; 023065E8
	.byte 0x38, 0x1C, 0x0B, 0x4A, 0x89, 0x58, 0x6A, 0x1C, 0x00, 0xF0, 0x18, 0xF8, 0x06, 0x4B, 0x19, 0x68	; 023065F8
	.byte 0x08, 0x48, 0x0D, 0x52, 0x01, 0x22, 0x19, 0x68, 0x07, 0x48, 0x0A, 0x52, 0x00, 0x20, 0x01, 0xB0	; 02306608
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x9E, 0x03, 0x00, 0x00	; 02306618
	.byte 0x98, 0x03, 0x00, 0x00, 0x9C, 0x03, 0x00, 0x00, 0xA0, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 02306628
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x1C, 0xCE, 0x7F, 0x03, 0x10, 0xB5, 0x04, 0x1C, 0x80, 0x2C, 0x01, 0xD9	; 02306638
	.byte 0x04, 0x20, 0x0C, 0xE0, 0x08, 0x1C, 0x07, 0x49, 0x0A, 0x68, 0x07, 0x49, 0x51, 0x58, 0x62, 0x1C	; 02306648
	.byte 0x00, 0xF0, 0x0E, 0xF8, 0x03, 0x48, 0x01, 0x68, 0x04, 0x48, 0x0C, 0x52, 0x00, 0x20, 0x10, 0xBC	; 02306658
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x98, 0x03, 0x00, 0x00, 0x9C, 0x03, 0x00, 0x00	; 02306668
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x1C, 0xCE, 0x7F, 0x03	; 02306674

; ===== function loc_02306674 =====
loc_02306674:
	mov r2,#0x0	; 02306674
	ldr r0,[pool_0230668C]	; 02306676
	ldr r1,[r0,#0x0]	; 02306678
	ldr r0,[pool_02306690]	; 0230667A
	strh r2,[r1,r0]	; 0230667C
	ldr r2,[pool_02306694]	; 0230667E
	ldrh r1,[r2,#0x0]	; 02306680
	mov r0,#0x2	; 02306682
	orr r1,r0	; 02306684
	strh r1,[r2,#0x0]	; 02306686
	bx lr	; 02306688
	.byte 0xC0, 0x46	; 0230668C
pool_0230668C:
loc_0230668C:
	.word FirmwareWlWorkPointerSlot	; 0230668C
pool_02306690:
loc_02306690:
	.word 0x000003A2	; 02306690
pool_02306694:
loc_02306694:
	.word REG_WIFI_POWER_TX	; 02306694

; ===== function loc_02306698 =====
loc_02306698:
	mov r3,#0x1	; 02306698
	ldr r2,[pool_023066C0]	; 0230669A
	ldr r1,[r2,#0x0]	; 0230669C
	ldr r0,[pool_023066C4]	; 0230669E
	strh r3,[r1,r0]	; 023066A0
	ldr r1,[r2,#0x0]	; 023066A2
	ldr r0,[pool_023066C8]	; 023066A4
	ldrh r0,[r1,r0]	; 023066A6
	cmp r0,#0x0	; 023066A8
	bne loc_023066BC	; 023066AA
	ldr r2,[pool_023066CC]	; 023066AC
	ldrh r1,[r2,#0x0]	; 023066AE
	mov r0,#0x2	; 023066B0
	bic r1,r0	; 023066B2
	strh r1,[r2,#0x0]	; 023066B4
	mov r1,#0x0	; 023066B6
	ldr r0,[pool_023066D0]	; 023066B8
	strh r1,[r0,#0x0]	; 023066BA
loc_023066BC:
	bx lr	; 023066BC
	.byte 0xC0, 0x46	; 023066C0
pool_023066C0:
loc_023066C0:
	.word FirmwareWlWorkPointerSlot	; 023066C0
pool_023066C4:
loc_023066C4:
	.word 0x000003A2	; 023066C4
pool_023066C8:
loc_023066C8:
	.word 0x00000420	; 023066C8
pool_023066CC:
loc_023066CC:
	.word REG_WIFI_POWER_TX	; 023066CC
pool_023066D0:
loc_023066D0:
	.word REG_WIFI_UNKNOWN_048	; 023066D0

; ===== function loc_023066D4 =====
loc_023066D4:
	push {r4,r5,lr}	; 023066D4
	sub sp,#0x4	; 023066D6
	add r5,r0,#0x0	; 023066D8
	ldr r2,[pool_02306724]	; 023066DA
	cmp r5,r2	; 023066DC
	bne loc_023066F2	; 023066DE
	mov r4,#0xff	; 023066E0
	ldr r3,[pool_02306728]	; 023066E2
	ldr r1,[r3,#0x0]	; 023066E4
	ldr r0,[pool_0230672C]	; 023066E6
	strh r4,[r1,r0]	; 023066E8
	ldr r1,[r3,#0x0]	; 023066EA
	ldr r0,[pool_02306730]	; 023066EC
	strh r2,[r1,r0]	; 023066EE
	b loc_0230671A	; 023066F0
loc_023066F2:
	ldr r0,[pool_02306728]	; 023066F2
	ldr r4,[r0,#0x0]	; 023066F4
	ldr r0,[pool_02306734]	; 023066F6
	ldrh r1,[r4,r0]	; 023066F8
	add r0,r5,#0x0	; 023066FA
	mul r0,r1	; 023066FC
	mov r1,#0x64	; 023066FE
	bl loc_0230673C	; 02306700
	ldr r1,[pool_02306738]	; 02306704
	cmp r0,r1	; 02306706
	bls loc_0230670E	; 02306708
	mov r0,#0x5	; 0230670A
	b loc_0230671C	; 0230670C
loc_0230670E:
	ldr r1,[pool_0230672C]	; 0230670E
	strh r5,[r4,r1]	; 02306710
	ldr r1,[pool_02306728]	; 02306712
	ldr r2,[r1,#0x0]	; 02306714
	ldr r1,[pool_02306730]	; 02306716
	strh r0,[r2,r1]	; 02306718
loc_0230671A:
	mov r0,#0x0	; 0230671A
loc_0230671C:
	add sp,#0x4	; 0230671C
	pop {r4,r5}	; 0230671E
	pop {r3}	; 02306720
	bx r3	; 02306722
pool_02306724:
loc_02306724:
	.word 0x0000FFFF	; 02306724
pool_02306728:
loc_02306728:
	.word FirmwareWlWorkPointerSlot	; 02306728
pool_0230672C:
loc_0230672C:
	.word 0x000002FC	; 0230672C
pool_02306730:
loc_02306730:
	.word 0x00000388	; 02306730
pool_02306734:
loc_02306734:
	.word 0x0000036A	; 02306734
pool_02306738:
loc_02306738:
	.word 0x00010000	; 02306738

; ===== function loc_0230673C =====
loc_0230673C:
	bx pc	; 0230673C
	.byte 0xC0, 0x46	; 02306740
.arm

; ===== function loc_02306740 =====
loc_02306740:
	ldr pc,[pool_02306744]	; 02306740
pool_02306744:
loc_02306744:
	.word loc_03802720	; 02306744
.thumb

; ===== function loc_02306748 =====
loc_02306748:
	push {r4,lr}	; 02306748
	mov r1,#0x0	; 0230674A
	ldr r0,[pool_023067A0]	; 0230674C
	strh r1,[r0,#0x0]	; 0230674E
	mov r0,#0x8	; 02306750
	bl loc_02305778	; 02306752
	mov r1,#0x0	; 02306756
	ldr r0,[pool_023067A4]	; 02306758
	strh r1,[r0,#0x0]	; 0230675A
	ldr r0,[pool_023067A8]	; 0230675C
	ldr r1,[r0,#0x0]	; 0230675E
	ldr r0,[pool_023067AC]	; 02306760
	ldrh r0,[r1,r0]	; 02306762
	cmp r0,#0x2	; 02306764
	beq loc_0230676E	; 02306766
	cmp r0,#0x3	; 02306768
	beq loc_02306796	; 0230676A
	b loc_0230679A	; 0230676C
loc_0230676E:
	mov r0,#0x1	; 0230676E
	bl loc_02305B08	; 02306770
	add r4,r0,#0x0	; 02306774
	mov r0,#0x1	; 02306776
	mov r2,#0x7f	; 02306778
	add r1,r4,#0x0	; 0230677A
	and r1,r2	; 0230677C
	bl loc_02305A9C	; 0230677E
	mov r0,#0x1	; 02306782
	add r1,r4,#0x0	; 02306784
	bl loc_02305A9C	; 02306786
	mov r0,#0x28	; 0230678A
	bl loc_02305778	; 0230678C
	bl loc_0230582C	; 02306790
	b loc_0230679A	; 02306794
loc_02306796:
	bl loc_0230582C	; 02306796
loc_0230679A:
	pop {r4}	; 0230679A
	pop {r3}	; 0230679C
	bx r3	; 0230679E
pool_023067A0:
loc_023067A0:
	.word REG_WIFI_POWER_US	; 023067A0
pool_023067A4:
loc_023067A4:
	.word REG_WIFI_BB_POWER	; 023067A4
pool_023067A8:
loc_023067A8:
	.word FirmwareWlWorkPointerSlot	; 023067A8
pool_023067AC:
loc_023067AC:
	.word 0x000005B0	; 023067AC

; ===== function loc_023067B0 =====
loc_023067B0:
	push {lr}	; 023067B0
	sub sp,#0x4	; 023067B2
	ldr r0,[pool_023067F0]	; 023067B4
	ldr r1,[r0,#0x0]	; 023067B6
	ldr r0,[pool_023067F4]	; 023067B8
	ldrh r0,[r1,r0]	; 023067BA
	cmp r0,#0x2	; 023067BC
	beq loc_023067C4	; 023067BE
	cmp r0,#0x3	; 023067C0
	b loc_023067CA	; 023067C2
loc_023067C4:
	ldr r0,[pool_023067F8]	; 023067C4
	bl loc_02305A6C	; 023067C6
loc_023067CA:
	mov r0,#0x1e	; 023067CA
	bl loc_02305B08	; 023067CC
	mov r2,#0x3f	; 023067D0
	add r1,r0,#0x0	; 023067D2
	orr r1,r2	; 023067D4
	mov r0,#0x1e	; 023067D6
	bl loc_02305A9C	; 023067D8
	ldr r1,[pool_023067FC]	; 023067DC
	ldr r0,[pool_02306800]	; 023067DE
	strh r1,[r0,#0x0]	; 023067E0
	mov r1,#0x1	; 023067E2
	ldr r0,[pool_02306804]	; 023067E4
	strh r1,[r0,#0x0]	; 023067E6
	add sp,#0x4	; 023067E8
	pop {r3}	; 023067EA
	bx r3	; 023067EC
	.byte 0xC0, 0x46	; 023067F0
pool_023067F0:
loc_023067F0:
	.word FirmwareWlWorkPointerSlot	; 023067F0
pool_023067F4:
loc_023067F4:
	.word 0x000005B0	; 023067F4
pool_023067F8:
loc_023067F8:
	.word 0x0000C008	; 023067F8
pool_023067FC:
loc_023067FC:
	.word 0x0000800D	; 023067FC
pool_02306800:
loc_02306800:
	.word REG_WIFI_BB_POWER	; 02306800
pool_02306804:
loc_02306804:
	.word REG_WIFI_POWER_US	; 02306804

; ===== function loc_02306808 =====
loc_02306808:
	ldr r1,[pool_02306810]	; 02306808
	strh r0,[r1,#0x0]	; 0230680A
	mov r0,#0x0	; 0230680C
	bx lr	; 0230680E
pool_02306810:
loc_02306810:
	.word REG_WIFI_POWERFORCE	; 02306810

; ===== function loc_02306814 =====
loc_02306814:
	push {r4,lr}	; 02306814
	ldr r1,[pool_02306840]	; 02306816
	ldr r2,[r1,#0x0]	; 02306818
	ldr r1,[pool_02306844]	; 0230681A
	add r4,r2,r1	; 0230681C
	ldrh r3,[r4,#0x0]	; 0230681E
	mov r1,#0x2	; 02306820
	bic r3,r1	; 02306822
	lsl r1,r0,#0xf	; 02306824
	lsr r2,r1,#0x10	; 02306826
	mov r1,#0x1	; 02306828
	and r2,r1	; 0230682A
	lsl r1,r2,#0x1	; 0230682C
	orr r3,r1	; 0230682E
	strh r3,[r4,#0x0]	; 02306830
	ldr r1,[pool_02306848]	; 02306832
	strh r0,[r1,#0x0]	; 02306834
	mov r0,#0x0	; 02306836
	pop {r4}	; 02306838
	pop {r3}	; 0230683A
	bx r3	; 0230683C
	.byte 0xC0, 0x46	; 02306840
pool_02306840:
loc_02306840:
	.word FirmwareWlWorkPointerSlot	; 02306840
pool_02306844:
loc_02306844:
	.word 0x00000316	; 02306844
pool_02306848:
loc_02306848:
	.word REG_WIFI_POWERSTATE	; 02306848

; ===== function loc_0230684C =====
loc_0230684C:
	push {r4,r5,lr}	; 0230684C
	sub sp,#0x4	; 0230684E
	ldr r1,[pool_023068A4]	; 02306850
	ldr r3,[r1,#0x0]	; 02306852
	ldr r2,[pool_023068A8]	; 02306854
	add r5,r3,r2	; 02306856
	ldrh r4,[r5,#0x0]	; 02306858
	mov r3,#0x1	; 0230685A
	bic r4,r3	; 0230685C
	lsl r2,r0,#0x10	; 0230685E
	lsr r2,r2,#0x10	; 02306860
	and r2,r3	; 02306862
	orr r4,r2	; 02306864
	strh r4,[r5,#0x0]	; 02306866
	cmp r0,#0x0	; 02306868
	beq loc_02306882	; 0230686A
	ldr r1,[r1,#0x0]	; 0230686C
	ldr r0,[pool_023068AC]	; 0230686E
	ldrh r0,[r1,r0]	; 02306870
	cmp r0,#0x1	; 02306872
	beq loc_02306882	; 02306874
	ldr r2,[pool_023068B0]	; 02306876
	ldrh r1,[r2,#0x0]	; 02306878
	mov r0,#0x40	; 0230687A
	orr r1,r0	; 0230687C
	strh r1,[r2,#0x0]	; 0230687E
	b loc_0230689A	; 02306880
loc_02306882:
	ldr r2,[pool_023068B0]	; 02306882
	ldrh r1,[r2,#0x0]	; 02306884
	mov r0,#0x40	; 02306886
	bic r1,r0	; 02306888
	strh r1,[r2,#0x0]	; 0230688A
	ldr r0,[pool_023068A4]	; 0230688C
	ldr r1,[r0,#0x0]	; 0230688E
	ldr r0,[pool_023068B4]	; 02306890
	ldrh r0,[r1,r0]	; 02306892
	mov r1,#0x0	; 02306894
	bl loc_02306FCC	; 02306896
loc_0230689A:
	mov r0,#0x0	; 0230689A
	add sp,#0x4	; 0230689C
	pop {r4,r5}	; 0230689E
	pop {r3}	; 023068A0
	bx r3	; 023068A2
pool_023068A4:
loc_023068A4:
	.word FirmwareWlWorkPointerSlot	; 023068A4
pool_023068A8:
loc_023068A8:
	.word 0x00000316	; 023068A8
pool_023068AC:
loc_023068AC:
	.word 0x000002F2	; 023068AC
pool_023068B0:
loc_023068B0:
	.word REG_WIFI_MODE_WEP	; 023068B0
pool_023068B4:
loc_023068B4:
	.word 0x00000300	; 023068B4

; ===== function loc_023068B8 =====
loc_023068B8:
	push {lr}	; 023068B8
	sub sp,#0x4	; 023068BA
	ldr r0,[pool_02306900]	; 023068BC
	str r0,[sp,#0x0]	; 023068BE
	mov r0,#0x58	; 023068C0
	mov r1,#0x2	; 023068C2
	add r2,sp,#0x0	; 023068C4
	bl loc_0231019C	; 023068C6
	ldr r1,[sp,#0x0]	; 023068CA
	ldr r0,[pool_02306904]	; 023068CC
	add r0,r1,r0	; 023068CE
	str r0,[sp,#0x0]	; 023068D0
	bl loc_0230602C	; 023068D2
	cmp r0,#0x14	; 023068D6
	bne loc_023068F4	; 023068D8
	ldr r1,[sp,#0x0]	; 023068DA
	ldr r0,[pool_02306908]	; 023068DC
	sub r2,r1,r0	; 023068DE
	str r2,[sp,#0x0]	; 023068E0
	ldr r0,[pool_0230690C]	; 023068E2
	ldrh r1,[r0,#0x0]	; 023068E4
	mov r0,#0x2	; 023068E6
	and r1,r0	; 023068E8
	cmp r1,#0x0	; 023068EA
	beq loc_023068F4	; 023068EC
	ldr r0,[pool_02306910]	; 023068EE
	sub r0,r2,r0	; 023068F0
	str r0,[sp,#0x0]	; 023068F2
loc_023068F4:
	ldr r1,[sp,#0x0]	; 023068F4
	ldr r0,[pool_02306914]	; 023068F6
	strh r1,[r0,#0x0]	; 023068F8
	add sp,#0x4	; 023068FA
	pop {r3}	; 023068FC
	bx r3	; 023068FE
pool_02306900:
loc_02306900:
	.word 0x0000E2E2	; 02306900
pool_02306904:
loc_02306904:
	.word 0x00000202	; 02306904
pool_02306908:
loc_02306908:
	.word 0x00006161	; 02306908
pool_0230690C:
loc_0230690C:
	.word REG_WIFI_PREAMBLE	; 0230690C
pool_02306910:
loc_02306910:
	.word 0x00006060	; 02306910
pool_02306914:
loc_02306914:
	.word REG_WIFI_CONFIG_140	; 02306914

; ===== function loc_02306918 =====
loc_02306918:
	push {r4,lr}	; 02306918
	ldrh r4,[r0,#0x0]	; 0230691A
	ldr r3,[pool_0230693C]	; 0230691C
	ldr r2,[r3,#0x0]	; 0230691E
	ldr r1,[pool_02306940]	; 02306920
	strh r4,[r2,r1]	; 02306922
	ldrh r2,[r0,#0x2]	; 02306924
	ldrh r0,[r0,#0x0]	; 02306926
	orr r2,r0	; 02306928
	ldr r1,[r3,#0x0]	; 0230692A
	ldr r0,[pool_02306944]	; 0230692C
	strh r2,[r1,r0]	; 0230692E
	bl loc_023068B8	; 02306930
	mov r0,#0x0	; 02306934
	pop {r4}	; 02306936
	pop {r3}	; 02306938
	bx r3	; 0230693A
pool_0230693C:
loc_0230693C:
	.word FirmwareWlWorkPointerSlot	; 0230693C
pool_02306940:
loc_02306940:
	.word 0x0000035C	; 02306940
pool_02306944:
loc_02306944:
	.word 0x0000035E	; 02306944

; ===== function loc_02306948 =====
loc_02306948:
	push {r4,r5,r6,r7,lr}	; 02306948
	sub sp,#0x14	; 0230694A
	add r4,r0,#0x0	; 0230694C
	add r7,r1,#0x0	; 0230694E
	ldr r0,[pool_02306AB8]	; 02306950
	ldr r0,[r0,#0x0]	; 02306952
	mov r2,#0x1	; 02306954
	lsl r2,r4	; 02306956
	ldr r1,[pool_02306ABC]	; 02306958
	ldrh r1,[r0,r1]	; 0230695A
	and r2,r1	; 0230695C
	cmp r2,#0x0	; 0230695E
	bne loc_02306966	; 02306960
	mov r0,#0x5	; 02306962
	b loc_02306AB0	; 02306964
loc_02306966:
	ldr r1,[pool_02306AC0]	; 02306966
	strh r4,[r0,r1]	; 02306968
	ldr r0,[pool_02306AB8]	; 0230696A
	ldr r0,[r0,#0x0]	; 0230696C
	ldr r1,[pool_02306AC4]	; 0230696E
	ldrh r1,[r0,r1]	; 02306970
	cmp r1,#0x5	; 02306972
	bls loc_02306978	; 02306974
	b loc_02306AAE	; 02306976
loc_02306978:
	add r1,r1,r1	; 02306978
P4_SwitchIndexPC_02306978:
	add r1,pc	; 0230697A
	ldrh r1,[r1,#(P4_SwitchTable_02306978 - (P4_SwitchIndexPC_02306978 + 4))]	; 0230697C
	lsl r1,r1,#0x10	; 0230697E
	asr r1,r1,#0x10	; 02306980
P4_SwitchTargetPC_02306978:
	add r1,pc	; 02306982
	bx r1	; 02306984
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02306978:
	.halfword (loc_02306AAE + 1) - (P4_SwitchTargetPC_02306978 + 4)
	.halfword (loc_02306AAE + 1) - (P4_SwitchTargetPC_02306978 + 4)
	.halfword (loc_02306992 + 1) - (P4_SwitchTargetPC_02306978 + 4)
	.halfword (loc_02306A26 + 1) - (P4_SwitchTargetPC_02306978 + 4)
	.halfword (loc_02306AAE + 1) - (P4_SwitchTargetPC_02306978 + 4)
	.halfword (loc_02306992 + 1) - (P4_SwitchTargetPC_02306978 + 4)
P4_SwitchTable_02306978End:
loc_02306992:
	mov r0,#0x0	; 02306992
	str r0,[sp,#0x8]	; 02306994
	sub r4,r4,#0x1	; 02306996
	mov r0,#0x6	; 02306998
	add r5,r4,#0x0	; 0230699A
	mul r5,r0	; 0230699C
	add r0,r5,#0x0	; 0230699E
	add r0,#0xf2	; 023069A0
	mov r1,#0x3	; 023069A2
	add r2,sp,#0x8	; 023069A4
	bl loc_0231019C	; 023069A6
	ldr r0,[sp,#0x8]	; 023069AA
	bl loc_02305A6C	; 023069AC
	add r5,#0xf5	; 023069B0
	add r0,r5,#0x0	; 023069B2
	mov r1,#0x3	; 023069B4
	add r2,sp,#0x8	; 023069B6
	bl loc_0231019C	; 023069B8
	ldr r0,[sp,#0x8]	; 023069BC
	bl loc_02305A6C	; 023069BE
	cmp r7,#0x0	; 023069C2
	beq loc_023069CC	; 023069C4
	ldr r0,[pool_02306AC8]	; 023069C6
	bl loc_02305720	; 023069C8
loc_023069CC:
	mov r0,#0x0	; 023069CC
	str r0,[sp,#0x8]	; 023069CE
	ldr r0,[pool_02306AB8]	; 023069D0
	ldr r1,[r0,#0x0]	; 023069D2
	ldr r0,[pool_02306ACC]	; 023069D4
	ldr r2,[r1,r0]	; 023069D6
	ldr r0,[pool_02306AD0]	; 023069D8
	add r1,r2,#0x0	; 023069DA
	and r1,r0	; 023069DC
	cmp r1,#0x0	; 023069DE
	beq loc_02306A10	; 023069E0
	ldr r0,[pool_02306AD4]	; 023069E2
	and r2,r0	; 023069E4
	cmp r2,#0x0	; 023069E6
	bne loc_02306AAE	; 023069E8
	ldr r0,[pool_02306AD8]	; 023069EA
	add r0,r4,r0	; 023069EC
	mov r1,#0x1	; 023069EE
	add r2,sp,#0x8	; 023069F0
	bl loc_0231019C	; 023069F2
	ldr r0,[pool_02306AB8]	; 023069F6
	ldr r1,[r0,#0x0]	; 023069F8
	ldr r0,[pool_02306ACC]	; 023069FA
	ldr r0,[r1,r0]	; 023069FC
	ldr r2,[sp,#0x8]	; 023069FE
	mov r1,#0x1f	; 02306A00
	and r2,r1	; 02306A02
	lsl r1,r2,#0xa	; 02306A04
	orr r0,r1	; 02306A06
	str r0,[sp,#0x8]	; 02306A08
	bl loc_02305A6C	; 02306A0A
	b loc_02306AAE	; 02306A0E
loc_02306A10:
	ldr r0,[pool_02306ADC]	; 02306A10
	add r0,r4,r0	; 02306A12
	mov r1,#0x1	; 02306A14
	add r2,sp,#0x8	; 02306A16
	bl loc_0231019C	; 02306A18
	mov r0,#0x1e	; 02306A1C
	ldr r1,[sp,#0x8]	; 02306A1E
	bl loc_02305A9C	; 02306A20
	b loc_02306AAE	; 02306A24
loc_02306A26:
	ldr r1,[pool_02306AE0]	; 02306A26
	ldrh r5,[r0,r1]	; 02306A28
	add r5,#0xcf	; 02306A2A
	mov r6,#0x0	; 02306A2C
	str r6,[sp,#0x0]	; 02306A2E
	b loc_02306A58	; 02306A30
loc_02306A32:
	ldr r0,[sp,#0x0]	; 02306A32
	str r0,[sp,#0x8]	; 02306A34
	str r0,[sp,#0xc]	; 02306A36
	add r0,r5,#0x0	; 02306A38
	mov r1,#0x1	; 02306A3A
	add r2,sp,#0xc	; 02306A3C
	bl loc_0231019C	; 02306A3E
	add r0,r5,r4	; 02306A42
	mov r1,#0x1	; 02306A44
	add r2,sp,#0x8	; 02306A46
	bl loc_0231019C	; 02306A48
	ldr r0,[sp,#0xc]	; 02306A4C
	ldr r1,[sp,#0x8]	; 02306A4E
	bl loc_02305A9C	; 02306A50
	add r5,#0xf	; 02306A54
	add r6,r6,#0x1	; 02306A56
loc_02306A58:
	ldr r0,[pool_02306AB8]	; 02306A58
	ldr r1,[r0,#0x0]	; 02306A5A
	ldr r0,[pool_02306AE4]	; 02306A5C
	ldrh r0,[r1,r0]	; 02306A5E
	cmp r6,r0	; 02306A60
	bcc loc_02306A32	; 02306A62
	mov r6,#0x0	; 02306A64
	str r6,[sp,#0x4]	; 02306A66
	b loc_02306A98	; 02306A68
loc_02306A6A:
	ldr r0,[sp,#0x4]	; 02306A6A
	str r0,[sp,#0x8]	; 02306A6C
	add r0,r5,#0x0	; 02306A6E
	mov r1,#0x1	; 02306A70
	add r2,sp,#0x8	; 02306A72
	bl loc_0231019C	; 02306A74
	ldr r0,[sp,#0x8]	; 02306A78
	lsl r0,r0,#0x8	; 02306A7A
	str r0,[sp,#0x8]	; 02306A7C
	add r0,r5,r4	; 02306A7E
	mov r1,#0x1	; 02306A80
	add r2,sp,#0x8	; 02306A82
	bl loc_0231019C	; 02306A84
	ldr r0,[sp,#0x8]	; 02306A88
	ldr r1,[pool_02306AE8]	; 02306A8A
	orr r0,r1	; 02306A8C
	str r0,[sp,#0x8]	; 02306A8E
	bl loc_02305A6C	; 02306A90
	add r5,#0xf	; 02306A94
	add r6,r6,#0x1	; 02306A96
loc_02306A98:
	ldr r0,[pool_02306AB8]	; 02306A98
	ldr r1,[r0,#0x0]	; 02306A9A
	ldr r0,[pool_02306AEC]	; 02306A9C
	ldrh r0,[r1,r0]	; 02306A9E
	cmp r6,r0	; 02306AA0
	bcc loc_02306A6A	; 02306AA2
	cmp r7,#0x0	; 02306AA4
	beq loc_02306AAE	; 02306AA6
	ldr r0,[pool_02306AC8]	; 02306AA8
	bl loc_02305720	; 02306AAA
loc_02306AAE:
	mov r0,#0x0	; 02306AAE
loc_02306AB0:
	add sp,#0x14	; 02306AB0
	pop {r4,r5,r6,r7}	; 02306AB2
	pop {r3}	; 02306AB4
	bx r3	; 02306AB6
pool_02306AB8:
loc_02306AB8:
	.word FirmwareWlWorkPointerSlot	; 02306AB8
pool_02306ABC:
loc_02306ABC:
	.word 0x000002F0	; 02306ABC
pool_02306AC0:
loc_02306AC0:
	.word 0x00000376	; 02306AC0
pool_02306AC4:
loc_02306AC4:
	.word 0x000005B0	; 02306AC4
pool_02306AC8:
loc_02306AC8:
	.word 0x000005DC	; 02306AC8
pool_02306ACC:
loc_02306ACC:
	.word 0x000005BC	; 02306ACC
pool_02306AD0:
loc_02306AD0:
	.word 0x00010000	; 02306AD0
pool_02306AD4:
loc_02306AD4:
	.word 0x00008000	; 02306AD4
pool_02306AD8:
loc_02306AD8:
	.word 0x00000154	; 02306AD8
pool_02306ADC:
loc_02306ADC:
	.word 0x00000146	; 02306ADC
pool_02306AE0:
loc_02306AE0:
	.word 0x000005B4	; 02306AE0
pool_02306AE4:
loc_02306AE4:
	.word 0x000005B8	; 02306AE4
pool_02306AE8:
loc_02306AE8:
	.word 0x00050000	; 02306AE8
pool_02306AEC:
loc_02306AEC:
	.word 0x000005B6	; 02306AEC

; ===== function loc_02306AF0 =====
loc_02306AF0:
	push {lr}	; 02306AF0
	sub sp,#0xc	; 02306AF2
	mov r0,#0x36	; 02306AF4
	mov r1,#0x6	; 02306AF6
	add r2,sp,#0x0	; 02306AF8
	add r2,#0x2	; 02306AFA
	bl loc_0231019C	; 02306AFC
	mov r0,#0x3c	; 02306B00
	mov r1,#0x2	; 02306B02
	add r2,sp,#0x0	; 02306B04
	bl loc_0231019C	; 02306B06
	add r0,sp,#0x0	; 02306B0A
	add r0,#0x2	; 02306B0C
	bl loc_023072F0	; 02306B0E
	mov r0,#0x7	; 02306B12
	bl loc_023072CC	; 02306B14
	add r0,sp,#0x0	; 02306B18
	ldrh r1,[r0,#0x0]	; 02306B1A
	ldr r0,[pool_02306BD0]	; 02306B1C
	and r1,r0	; 02306B1E
	lsl r0,r1,#0x10	; 02306B20
	lsr r0,r0,#0x10	; 02306B22
	bl loc_02307294	; 02306B24
	mov r0,#0x2	; 02306B28
	bl loc_0230722C	; 02306B2A
	mov r0,#0x0	; 02306B2E
	bl loc_02307204	; 02306B30
	mov r0,#0x0	; 02306B34
	bl loc_0230714C	; 02306B36
	mov r0,#0x0	; 02306B3A
	bl loc_02307130	; 02306B3C
	ldr r0,[pool_02306BD4]	; 02306B40
	bl loc_023070E4	; 02306B42
	ldr r0,[pool_02306BD8]	; 02306B46
	bl loc_02306C1C	; 02306B48
	mov r0,#0x0	; 02306B4C
	bl loc_023070BC	; 02306B4E
	mov r0,#0x0	; 02306B52
	bl loc_02307090	; 02306B54
	mov r0,#0x10	; 02306B58
	bl loc_02307060	; 02306B5A
	ldr r0,[pool_02306BDC]	; 02306B5E
	mov r1,#0x0	; 02306B60
	bl loc_02306FCC	; 02306B62
	ldr r0,[pool_02306BE0]	; 02306B66
	bl loc_02306FA8	; 02306B68
	mov r0,#0x1	; 02306B6C
	bl loc_02306EFC	; 02306B6E
	mov r0,#0x0	; 02306B72
	bl loc_02306EE0	; 02306B74
	mov r0,#0xa	; 02306B78
	mov r1,#0x0	; 02306B7A
	bl loc_02306948	; 02306B7C
	ldr r0,[pool_02306BE4]	; 02306B80
	bl loc_02306918	; 02306B82
	mov r0,#0x0	; 02306B86
	mov r1,#0x1f	; 02306B88
	bl loc_02306EB0	; 02306B8A
	mov r0,#0x5	; 02306B8E
	bl loc_023066D4	; 02306B90
	mov r0,#0x0	; 02306B94
	add r1,r0,#0x0	; 02306B96
	bl loc_02306DC4	; 02306B98
	mov r0,#0x0	; 02306B9C
	bl loc_02306E60	; 02306B9E
	mov r0,#0x0	; 02306BA2
	bl loc_02306D94	; 02306BA4
	ldr r2,[pool_02306BE8]	; 02306BA8
	ldrh r1,[r2,#0x0]	; 02306BAA
	ldrh r0,[r2,#0x0]	; 02306BAC
	lsl r0,r0,#0x8	; 02306BAE
	add r0,r1,r0	; 02306BB0
	ldrh r1,[r2,#0x0]	; 02306BB2
	bl loc_02305388	; 02306BB4
	ldr r0,[pool_02306BEC]	; 02306BB8
	ldr r1,[r0,#0x0]	; 02306BBA
	ldr r0,[pool_02306BF0]	; 02306BBC
	add r2,r1,r0	; 02306BBE
	ldrh r1,[r2,#0x0]	; 02306BC0
	mov r0,#0x8	; 02306BC2
	orr r1,r0	; 02306BC4
	strh r1,[r2,#0x0]	; 02306BC6
	add sp,#0xc	; 02306BC8
	pop {r3}	; 02306BCA
	bx r3	; 02306BCC
	.byte 0xC0, 0x46	; 02306BD0
pool_02306BD0:
loc_02306BD0:
	.word 0x00007FFE	; 02306BD0
pool_02306BD4:
loc_02306BD4:
	.word 0x0231041C	; 02306BD4
pool_02306BD8:
loc_02306BD8:
	.word 0x000001F4	; 02306BD8
pool_02306BDC:
loc_02306BDC:
	.word 0x0000FFFF	; 02306BDC
pool_02306BE0:
loc_02306BE0:
	.word 0x023103BC	; 02306BE0
pool_02306BE4:
loc_02306BE4:
	.word 0x02310378	; 02306BE4
pool_02306BE8:
loc_02306BE8:
	.word REG_WIFI_RANDOM	; 02306BE8
pool_02306BEC:
loc_02306BEC:
	.word FirmwareWlWorkPointerSlot	; 02306BEC
pool_02306BF0:
loc_02306BF0:
	.word 0x00000316	; 02306BF0

; ===== function loc_02306BF4 =====
loc_02306BF4:
	cmp r0,#0x1	; 02306BF4
	bcc loc_02306BFC	; 02306BF6
	cmp r0,#0xff	; 02306BF8
	bls loc_02306C00	; 02306BFA
loc_02306BFC:
	mov r0,#0x5	; 02306BFC
	bx lr	; 02306BFE
loc_02306C00:
	ldr r1,[pool_02306C10]	; 02306C00
	ldr r2,[r1,#0x0]	; 02306C02
	ldr r1,[pool_02306C14]	; 02306C04
	strh r0,[r2,r1]	; 02306C06
	ldr r1,[pool_02306C18]	; 02306C08
	strh r0,[r1,#0x0]	; 02306C0A
	mov r0,#0x0	; 02306C0C
	bx lr	; 02306C0E
pool_02306C10:
loc_02306C10:
	.word FirmwareWlWorkPointerSlot	; 02306C10
pool_02306C14:
loc_02306C14:
	.word 0x00000370	; 02306C14
pool_02306C18:
loc_02306C18:
	.word REG_WIFI_LISTENINT	; 02306C18

; ===== function loc_02306C1C =====
loc_02306C1C:
	push {lr}	; 02306C1C
	sub sp,#0x4	; 02306C1E
	cmp r0,#0xa	; 02306C20
	bcc loc_02306C2A	; 02306C22
	ldr r1,[pool_02306C4C]	; 02306C24
	cmp r0,r1	; 02306C26
	bls loc_02306C2E	; 02306C28
loc_02306C2A:
	mov r0,#0x5	; 02306C2A
	b loc_02306C46	; 02306C2C
loc_02306C2E:
	ldr r3,[pool_02306C50]	; 02306C2E
	ldr r2,[r3,#0x0]	; 02306C30
	ldr r1,[pool_02306C54]	; 02306C32
	strh r0,[r2,r1]	; 02306C34
	ldr r1,[pool_02306C58]	; 02306C36
	strh r0,[r1,#0x0]	; 02306C38
	ldr r1,[r3,#0x0]	; 02306C3A
	ldr r0,[pool_02306C5C]	; 02306C3C
	ldrh r0,[r1,r0]	; 02306C3E
	bl loc_023066D4	; 02306C40
	mov r0,#0x0	; 02306C44
loc_02306C46:
	add sp,#0x4	; 02306C46
	pop {r3}	; 02306C48
	bx r3	; 02306C4A
pool_02306C4C:
loc_02306C4C:
	.word 0x000003E8	; 02306C4C
pool_02306C50:
loc_02306C50:
	.word FirmwareWlWorkPointerSlot	; 02306C50
pool_02306C54:
loc_02306C54:
	.word 0x0000036A	; 02306C54
pool_02306C58:
loc_02306C58:
	.word REG_WIFI_BEACONINT	; 02306C58
pool_02306C5C:
loc_02306C5C:
	.word 0x000002FC	; 02306C5C
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x00, 0x27, 0x20, 0x2D, 0x01, 0xD9, 0x05, 0x20	; 02306C70
	.byte 0x50, 0xE0, 0x2A, 0x48, 0x00, 0x68, 0x2A, 0x49, 0x41, 0x5A, 0x40, 0x29, 0x0E, 0xD1, 0x29, 0x49	; 02306C80
	.byte 0x41, 0x5A, 0x01, 0x29, 0x0A, 0xD1, 0x28, 0x49, 0x41, 0x5A, 0xA9, 0x42, 0x01, 0xD0, 0x06, 0x20	; 02306C90
	.byte 0x40, 0xE0, 0x26, 0x49, 0x40, 0x5A, 0x00, 0x28, 0x00, 0xD0, 0x01, 0x27, 0x00, 0x24, 0x0C, 0xE0	; 02306CA0
	.byte 0x30, 0x1C, 0xFE, 0xF7, 0x89, 0xFB, 0x01, 0x1C, 0x1C, 0x48, 0x02, 0x68, 0x20, 0x48, 0x10, 0x18	; 02306CB0
	.byte 0x00, 0x19, 0xFE, 0xF7, 0x93, 0xFB, 0x76, 0x1C, 0x64, 0x1C, 0xAC, 0x42, 0xF0, 0xD3, 0x17, 0x4E	; 02306CC0
	.byte 0x07, 0xE0, 0x31, 0x68, 0x1A, 0x48, 0x08, 0x18, 0x00, 0x19, 0x00, 0x21, 0xFE, 0xF7, 0x86, 0xFB	; 02306CD0
	.byte 0x64, 0x1C, 0x20, 0x2C, 0xF5, 0xD3, 0x11, 0x48, 0x01, 0x68, 0x13, 0x48, 0x0D, 0x52, 0x00, 0x2F	; 02306CE0
	.byte 0x17, 0xD0, 0x0E, 0x48, 0x02, 0x68, 0x13, 0x48, 0x11, 0x58, 0x26, 0x31, 0x0F, 0x48, 0x10, 0x5A	; 02306CF0
	.byte 0x0E, 0x18, 0x00, 0x24, 0x0E, 0x4F, 0x0A, 0xE0, 0x08, 0x48, 0x00, 0x68, 0xC0, 0x19, 0x00, 0x19	; 02306D00
	.byte 0xFE, 0xF7, 0x5A, 0xFB, 0x01, 0x1C, 0x30, 0x19, 0xFE, 0xF7, 0x68, 0xFB, 0x64, 0x1C, 0xAC, 0x42	; 02306D10
	.byte 0xF2, 0xD3, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02306D20
	.byte 0x10, 0x03, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00, 0x1A, 0x03, 0x00, 0x00, 0x8E, 0x03, 0x00, 0x00	; 02306D30
	.byte 0x1C, 0x03, 0x00, 0x00, 0x64, 0x04, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C, 0x0F, 0x48, 0x01, 0x68	; 02306D40
	.byte 0x0F, 0x48, 0x08, 0x18, 0x21, 0x1C, 0xFF, 0xF7, 0x89, 0xFB, 0x0E, 0x48, 0x21, 0x1C, 0xFF, 0xF7	; 02306D50
	.byte 0x85, 0xFB, 0x21, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x05, 0xD0, 0x0A, 0x4A, 0x11, 0x88	; 02306D60
	.byte 0x0A, 0x48, 0x01, 0x40, 0x11, 0x80, 0x04, 0xE0, 0x07, 0x4A, 0x11, 0x88, 0x08, 0x48, 0x01, 0x43	; 02306D70
	.byte 0x11, 0x80, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 02306D80
	.byte 0x60, 0x03, 0x00, 0x00, 0x20, 0x80, 0x80, 0x04, 0xD0, 0x80, 0x80, 0x04, 0xFF, 0xFB, 0xFF, 0xFF	; 02306D90
	.byte 0x00, 0x04, 0x00, 0x00	; 02306D94

; ===== function loc_02306D94 =====
loc_02306D94:
	cmp r0,#0x1	; 02306D94
	bls loc_02306D9C	; 02306D96
	mov r0,#0x5	; 02306D98
	bx lr	; 02306D9A
loc_02306D9C:
	ldr r1,[pool_02306DBC]	; 02306D9C
	ldr r2,[r1,#0x0]	; 02306D9E
	ldr r1,[pool_02306DC0]	; 02306DA0
	add r3,r2,r1	; 02306DA2
	ldrh r2,[r3,#0x0]	; 02306DA4
	mov r1,#0x40	; 02306DA6
	bic r2,r1	; 02306DA8
	lsl r0,r0,#0x10	; 02306DAA
	lsr r1,r0,#0x10	; 02306DAC
	mov r0,#0x1	; 02306DAE
	and r1,r0	; 02306DB0
	lsl r0,r1,#0x6	; 02306DB2
	orr r2,r0	; 02306DB4
	strh r2,[r3,#0x0]	; 02306DB6
	mov r0,#0x0	; 02306DB8
	bx lr	; 02306DBA
pool_02306DBC:
loc_02306DBC:
	.word FirmwareWlWorkPointerSlot	; 02306DBC
pool_02306DC0:
loc_02306DC0:
	.word 0x000002FE	; 02306DC0

; ===== function loc_02306DC4 =====
loc_02306DC4:
	push {r4,r5,lr}	; 02306DC4
	sub sp,#0x4	; 02306DC6
	cmp r0,#0x1	; 02306DC8
	bhi loc_02306DD0	; 02306DCA
	cmp r1,#0x1	; 02306DCC
	bls loc_02306DD4	; 02306DCE
loc_02306DD0:
	mov r0,#0x5	; 02306DD0
	b loc_02306E48	; 02306DD2
loc_02306DD4:
	cmp r0,#0x0	; 02306DD4
	beq loc_02306DDE	; 02306DD6
	cmp r0,#0x1	; 02306DD8
	beq loc_02306DFC	; 02306DDA
	b loc_02306E18	; 02306DDC
loc_02306DDE:
	ldr r2,[pool_02306E50]	; 02306DDE
	ldr r3,[r2,#0x0]	; 02306DE0
	ldr r2,[pool_02306E54]	; 02306DE2
	add r3,r3,r2	; 02306DE4
	ldrh r2,[r3,#0x0]	; 02306DE6
	mov r4,#0x20	; 02306DE8
	bic r2,r4	; 02306DEA
	lsl r1,r1,#0x10	; 02306DEC
	lsr r4,r1,#0x10	; 02306DEE
	mov r1,#0x1	; 02306DF0
	and r4,r1	; 02306DF2
	lsl r1,r4,#0x5	; 02306DF4
	orr r2,r1	; 02306DF6
	strh r2,[r3,#0x0]	; 02306DF8
	b loc_02306E18	; 02306DFA
loc_02306DFC:
	ldr r1,[pool_02306E50]	; 02306DFC
	ldr r2,[r1,#0x0]	; 02306DFE
	ldr r1,[pool_02306E58]	; 02306E00
	ldrh r1,[r2,r1]	; 02306E02
	cmp r1,#0x1	; 02306E04
	beq loc_02306E0C	; 02306E06
	mov r0,#0xb	; 02306E08
	b loc_02306E48	; 02306E0A
loc_02306E0C:
	ldr r1,[pool_02306E54]	; 02306E0C
	add r3,r2,r1	; 02306E0E
	ldrh r2,[r3,#0x0]	; 02306E10
	mov r1,#0x20	; 02306E12
	bic r2,r1	; 02306E14
	strh r2,[r3,#0x0]	; 02306E16
loc_02306E18:
	ldr r2,[pool_02306E50]	; 02306E18
	ldr r1,[r2,#0x0]	; 02306E1A
	ldr r5,[pool_02306E54]	; 02306E1C
	add r3,r1,r5	; 02306E1E
	ldrh r1,[r3,#0x0]	; 02306E20
	mov r4,#0x10	; 02306E22
	bic r1,r4	; 02306E24
	lsl r0,r0,#0x10	; 02306E26
	lsr r4,r0,#0x10	; 02306E28
	mov r0,#0x1	; 02306E2A
	and r4,r0	; 02306E2C
	lsl r0,r4,#0x4	; 02306E2E
	orr r1,r0	; 02306E30
	strh r1,[r3,#0x0]	; 02306E32
	ldr r0,[r2,#0x0]	; 02306E34
	ldrh r0,[r0,r5]	; 02306E36
	lsl r1,r0,#0x1a	; 02306E38
	lsr r1,r1,#0x1f	; 02306E3A
	lsl r0,r0,#0x1c	; 02306E3C
	lsr r0,r0,#0x1f	; 02306E3E
	eor r1,r0	; 02306E40
	ldr r0,[pool_02306E5C]	; 02306E42
	strh r1,[r0,#0x0]	; 02306E44
	mov r0,#0x0	; 02306E46
loc_02306E48:
	add sp,#0x4	; 02306E48
	pop {r4,r5}	; 02306E4A
	pop {r3}	; 02306E4C
	bx r3	; 02306E4E
pool_02306E50:
loc_02306E50:
	.word FirmwareWlWorkPointerSlot	; 02306E50
pool_02306E54:
loc_02306E54:
	.word 0x000002FE	; 02306E54
pool_02306E58:
loc_02306E58:
	.word 0x000002F2	; 02306E58
pool_02306E5C:
loc_02306E5C:
	.word REG_WIFI_UNKNOWN_290	; 02306E5C

; ===== function loc_02306E60 =====
loc_02306E60:
	push {r4,r5,lr}	; 02306E60
	sub sp,#0x4	; 02306E62
	cmp r0,#0x1	; 02306E64
	bls loc_02306E6C	; 02306E66
	mov r0,#0x5	; 02306E68
	b loc_02306E9C	; 02306E6A
loc_02306E6C:
	ldr r2,[pool_02306EA4]	; 02306E6C
	ldr r1,[r2,#0x0]	; 02306E6E
	ldr r5,[pool_02306EA8]	; 02306E70
	add r3,r1,r5	; 02306E72
	ldrh r1,[r3,#0x0]	; 02306E74
	mov r4,#0x8	; 02306E76
	bic r1,r4	; 02306E78
	lsl r0,r0,#0x10	; 02306E7A
	lsr r4,r0,#0x10	; 02306E7C
	mov r0,#0x1	; 02306E7E
	and r4,r0	; 02306E80
	lsl r0,r4,#0x3	; 02306E82
	orr r1,r0	; 02306E84
	strh r1,[r3,#0x0]	; 02306E86
	ldr r0,[r2,#0x0]	; 02306E88
	ldrh r0,[r0,r5]	; 02306E8A
	lsl r1,r0,#0x1a	; 02306E8C
	lsr r1,r1,#0x1f	; 02306E8E
	lsl r0,r0,#0x1c	; 02306E90
	lsr r0,r0,#0x1f	; 02306E92
	eor r1,r0	; 02306E94
	ldr r0,[pool_02306EAC]	; 02306E96
	strh r1,[r0,#0x0]	; 02306E98
	mov r0,#0x0	; 02306E9A
loc_02306E9C:
	add sp,#0x4	; 02306E9C
	pop {r4,r5}	; 02306E9E
	pop {r3}	; 02306EA0
	bx r3	; 02306EA2
pool_02306EA4:
loc_02306EA4:
	.word FirmwareWlWorkPointerSlot	; 02306EA4
pool_02306EA8:
loc_02306EA8:
	.word 0x000002FE	; 02306EA8
pool_02306EAC:
loc_02306EAC:
	.word REG_WIFI_UNKNOWN_290	; 02306EAC

; ===== function loc_02306EB0 =====
loc_02306EB0:
	push {r4,lr}	; 02306EB0
	add r2,r0,#0x0	; 02306EB2
	add r4,r1,#0x0	; 02306EB4
	cmp r2,#0x3	; 02306EB6
	bls loc_02306EBE	; 02306EB8
	mov r0,#0x5	; 02306EBA
	b loc_02306ED8	; 02306EBC
loc_02306EBE:
	cmp r4,#0x3f	; 02306EBE
	bls loc_02306EC6	; 02306EC0
	mov r0,#0x5	; 02306EC2
	b loc_02306ED8	; 02306EC4
loc_02306EC6:
	mov r0,#0x13	; 02306EC6
	add r1,r2,#0x0	; 02306EC8
	bl loc_02305A9C	; 02306ECA
	mov r0,#0x35	; 02306ECE
	add r1,r4,#0x0	; 02306ED0
	bl loc_02305A9C	; 02306ED2
	mov r0,#0x0	; 02306ED6
loc_02306ED8:
	pop {r4}	; 02306ED8
	pop {r3}	; 02306EDA
	bx r3	; 02306EDC
	.byte 0x00, 0x00	; 02306EE0

; ===== function loc_02306EE0 =====
loc_02306EE0:
	cmp r0,#0x1	; 02306EE0
	bls loc_02306EE8	; 02306EE2
	mov r0,#0x5	; 02306EE4
	bx lr	; 02306EE6
loc_02306EE8:
	ldr r1,[pool_02306EF4]	; 02306EE8
	ldr r2,[r1,#0x0]	; 02306EEA
	ldr r1,[pool_02306EF8]	; 02306EEC
	strh r0,[r2,r1]	; 02306EEE
	mov r0,#0x0	; 02306EF0
	bx lr	; 02306EF2
pool_02306EF4:
loc_02306EF4:
	.word FirmwareWlWorkPointerSlot	; 02306EF4
pool_02306EF8:
loc_02306EF8:
	.word 0x000002F6	; 02306EF8

; ===== function loc_02306EFC =====
loc_02306EFC:
	push {r4,r5,lr}	; 02306EFC
	sub sp,#0x4	; 02306EFE
	cmp r0,#0x1	; 02306F00
	bls loc_02306F08	; 02306F02
	mov r0,#0x5	; 02306F04
	b loc_02306F82	; 02306F06
loc_02306F08:
	ldr r2,[pool_02306F8C]	; 02306F08
	ldr r3,[r2,#0x0]	; 02306F0A
	ldr r1,[pool_02306F90]	; 02306F0C
	add r3,r3,r1	; 02306F0E
	ldrh r1,[r3,#0x0]	; 02306F10
	mov r4,#0x4	; 02306F12
	bic r1,r4	; 02306F14
	mov r4,#0x1	; 02306F16
	add r5,r0,#0x0	; 02306F18
	and r5,r4	; 02306F1A
	lsl r4,r5,#0x2	; 02306F1C
	orr r1,r4	; 02306F1E
	strh r1,[r3,#0x0]	; 02306F20
	cmp r0,#0x0	; 02306F22
	bne loc_02306F36	; 02306F24
	ldr r2,[r2,#0x0]	; 02306F26
	ldr r1,[pool_02306F94]	; 02306F28
	add r3,r2,r1	; 02306F2A
	ldrh r2,[r3,#0x0]	; 02306F2C
	mov r1,#0x20	; 02306F2E
	bic r2,r1	; 02306F30
	strh r2,[r3,#0x0]	; 02306F32
	b loc_02306F44	; 02306F34
loc_02306F36:
	ldr r2,[r2,#0x0]	; 02306F36
	ldr r1,[pool_02306F94]	; 02306F38
	add r3,r2,r1	; 02306F3A
	ldrh r2,[r3,#0x0]	; 02306F3C
	mov r1,#0x20	; 02306F3E
	orr r2,r1	; 02306F40
	strh r2,[r3,#0x0]	; 02306F42
loc_02306F44:
	ldr r1,[pool_02306F8C]	; 02306F44
	ldr r1,[r1,#0x0]	; 02306F46
	ldr r2,[pool_02306F98]	; 02306F48
	ldrh r2,[r1,r2]	; 02306F4A
	cmp r2,#0x40	; 02306F4C
	bne loc_02306F62	; 02306F4E
	ldr r2,[pool_02306F9C]	; 02306F50
	ldrh r2,[r1,r2]	; 02306F52
	cmp r2,#0x1	; 02306F54
	bne loc_02306F62	; 02306F56
	ldr r2,[pool_02306F94]	; 02306F58
	ldrh r3,[r1,r2]	; 02306F5A
	ldr r2,[pool_02306FA0]	; 02306F5C
	ldr r1,[r1,r2]	; 02306F5E
	strh r3,[r1,#0x2e]	; 02306F60
loc_02306F62:
	cmp r0,#0x0	; 02306F62
	bne loc_02306F72	; 02306F64
	ldr r2,[pool_02306FA4]	; 02306F66
	ldrh r1,[r2,#0x0]	; 02306F68
	mov r0,#0x6	; 02306F6A
	bic r1,r0	; 02306F6C
	strh r1,[r2,#0x0]	; 02306F6E
	b loc_02306F7C	; 02306F70
loc_02306F72:
	ldr r2,[pool_02306FA4]	; 02306F72
	ldrh r1,[r2,#0x0]	; 02306F74
	mov r0,#0x6	; 02306F76
	orr r1,r0	; 02306F78
	strh r1,[r2,#0x0]	; 02306F7A
loc_02306F7C:
	bl loc_023068B8	; 02306F7C
	mov r0,#0x0	; 02306F80
loc_02306F82:
	add sp,#0x4	; 02306F82
	pop {r4,r5}	; 02306F84
	pop {r3}	; 02306F86
	bx r3	; 02306F88
	.byte 0xC0, 0x46	; 02306F8C
pool_02306F8C:
loc_02306F8C:
	.word FirmwareWlWorkPointerSlot	; 02306F8C
pool_02306F90:
loc_02306F90:
	.word 0x000002FE	; 02306F90
pool_02306F94:
loc_02306F94:
	.word 0x00000378	; 02306F94
pool_02306F98:
loc_02306F98:
	.word 0x00000310	; 02306F98
pool_02306F9C:
loc_02306F9C:
	.word 0x000002F2	; 02306F9C
pool_02306FA0:
loc_02306FA0:
	.word 0x00000464	; 02306FA0
pool_02306FA4:
loc_02306FA4:
	.word REG_WIFI_PREAMBLE	; 02306FA4

; ===== function loc_02306FA8 =====
loc_02306FA8:
	ldr r1,[pool_02306FC4]	; 02306FA8
	ldr r2,[r1,#0x0]	; 02306FAA
	ldr r1,[pool_02306FC8]	; 02306FAC
	add r2,r2,r1	; 02306FAE
	mov r3,#0x0	; 02306FB0
loc_02306FB2:
	ldrh r1,[r0,#0x0]	; 02306FB2
	add r0,r0,#0x2	; 02306FB4
	strh r1,[r2,#0x0]	; 02306FB6
	add r2,r2,#0x2	; 02306FB8
	add r3,r3,#0x1	; 02306FBA
	cmp r3,#0x10	; 02306FBC
	bcc loc_02306FB2	; 02306FBE
	mov r0,#0x0	; 02306FC0
	bx lr	; 02306FC2
pool_02306FC4:
loc_02306FC4:
	.word FirmwareWlWorkPointerSlot	; 02306FC4
pool_02306FC8:
loc_02306FC8:
	.word 0x0000033C	; 02306FC8

; ===== function loc_02306FCC =====
loc_02306FCC:
	push {r4,r5,lr}	; 02306FCC
	sub sp,#0x4	; 02306FCE
	add r5,r0,#0x0	; 02306FD0
	cmp r5,#0xa	; 02306FD2
	bcs loc_02306FDA	; 02306FD4
	mov r0,#0x5	; 02306FD6
	b loc_0230703A	; 02306FD8
loc_02306FDA:
	ldr r0,[pool_02307044]	; 02306FDA
	ldr r2,[r0,#0x0]	; 02306FDC
	ldr r0,[pool_02307048]	; 02306FDE
	strh r5,[r2,r0]	; 02306FE0
	cmp r1,#0x0	; 02306FE2
	beq loc_02306FEA	; 02306FE4
	ldr r0,[pool_0230704C]	; 02306FE6
	strh r5,[r0,#0x0]	; 02306FE8
loc_02306FEA:
	ldr r0,[pool_02307044]	; 02306FEA
	ldr r0,[r0,#0x0]	; 02306FEC
	ldr r1,[pool_02307050]	; 02306FEE
	ldrh r1,[r0,r1]	; 02306FF0
	cmp r1,#0x0	; 02306FF2
	beq loc_02307038	; 02306FF4
	ldr r1,[pool_02307054]	; 02306FF6
	ldr r2,[r0,r1]	; 02306FF8
	add r2,#0x24	; 02306FFA
	ldr r1,[pool_02307058]	; 02306FFC
	ldrh r1,[r0,r1]	; 02306FFE
	add r1,r2,r1	; 02307000
	add r4,r1,#0x6	; 02307002
	ldr r1,[pool_0230705C]	; 02307004
	ldrh r0,[r0,r1]	; 02307006
	lsl r0,r0,#0x1f	; 02307008
	lsr r0,r0,#0x1f	; 0230700A
	cmp r0,#0x1	; 0230700C
	bne loc_02307028	; 0230700E
	add r0,r4,#0x0	; 02307010
	lsl r1,r5,#0x18	; 02307012
	lsr r1,r1,#0x18	; 02307014
	bl loc_023053DC	; 02307016
	add r0,r4,#0x1	; 0230701A
	asr r1,r5,#0x8	; 0230701C
	lsl r1,r1,#0x18	; 0230701E
	lsr r1,r1,#0x18	; 02307020
	bl loc_023053DC	; 02307022
	b loc_02307038	; 02307026
loc_02307028:
	add r0,r4,#0x0	; 02307028
	mov r1,#0xff	; 0230702A
	bl loc_023053DC	; 0230702C
	add r0,r4,#0x1	; 02307030
	mov r1,#0xff	; 02307032
	bl loc_023053DC	; 02307034
loc_02307038:
	mov r0,#0x0	; 02307038
loc_0230703A:
	add sp,#0x4	; 0230703A
	pop {r4,r5}	; 0230703C
	pop {r3}	; 0230703E
	bx r3	; 02307040
	.byte 0xC0, 0x46	; 02307044
pool_02307044:
loc_02307044:
	.word FirmwareWlWorkPointerSlot	; 02307044
pool_02307048:
loc_02307048:
	.word 0x00000300	; 02307048
pool_0230704C:
loc_0230704C:
	.word REG_WIFI_POST_BEACON	; 0230704C
pool_02307050:
loc_02307050:
	.word 0x0000045C	; 02307050
pool_02307054:
loc_02307054:
	.word 0x00000464	; 02307054
pool_02307058:
loc_02307058:
	.word 0x00000392	; 02307058
pool_0230705C:
loc_0230705C:
	.word 0x00000316	; 0230705C

; ===== function loc_02307060 =====
loc_02307060:
	push {r4,lr}	; 02307060
	cmp r0,#0xff	; 02307062
	bls loc_0230706A	; 02307064
	mov r0,#0x5	; 02307066
	b loc_0230707C	; 02307068
loc_0230706A:
	mov r4,#0x0	; 0230706A
	ldr r3,[pool_02307084]	; 0230706C
	ldr r2,[r3,#0x0]	; 0230706E
	ldr r1,[pool_02307088]	; 02307070
	strh r4,[r2,r1]	; 02307072
	ldr r2,[r3,#0x0]	; 02307074
	ldr r1,[pool_0230708C]	; 02307076
	strh r0,[r2,r1]	; 02307078
	add r0,r4,#0x0	; 0230707A
loc_0230707C:
	pop {r4}	; 0230707C
	pop {r3}	; 0230707E
	bx r3	; 02307080
	.byte 0xC0, 0x46	; 02307084
pool_02307084:
loc_02307084:
	.word FirmwareWlWorkPointerSlot	; 02307084
pool_02307088:
loc_02307088:
	.word 0x0000037C	; 02307088
pool_0230708C:
loc_0230708C:
	.word 0x0000037A	; 0230708C

; ===== function loc_02307090 =====
loc_02307090:
	cmp r0,#0x1	; 02307090
	bls loc_02307098	; 02307092
	mov r0,#0x5	; 02307094
	bx lr	; 02307096
loc_02307098:
	ldr r1,[pool_023070B4]	; 02307098
	ldr r2,[r1,#0x0]	; 0230709A
	ldr r1,[pool_023070B8]	; 0230709C
	add r3,r2,r1	; 0230709E
	ldrh r2,[r3,#0x0]	; 023070A0
	mov r1,#0x2	; 023070A2
	bic r2,r1	; 023070A4
	mov r1,#0x1	; 023070A6
	and r0,r1	; 023070A8
	lsl r0,r0,#0x1	; 023070AA
	orr r2,r0	; 023070AC
	strh r2,[r3,#0x0]	; 023070AE
	mov r0,#0x0	; 023070B0
	bx lr	; 023070B2
pool_023070B4:
loc_023070B4:
	.word FirmwareWlWorkPointerSlot	; 023070B4
pool_023070B8:
loc_023070B8:
	.word 0x000002FE	; 023070B8

; ===== function loc_023070BC =====
loc_023070BC:
	cmp r0,#0x1	; 023070BC
	bls loc_023070C4	; 023070BE
	mov r0,#0x5	; 023070C0
	bx lr	; 023070C2
loc_023070C4:
	ldr r1,[pool_023070DC]	; 023070C4
	ldr r2,[r1,#0x0]	; 023070C6
	ldr r1,[pool_023070E0]	; 023070C8
	add r3,r2,r1	; 023070CA
	ldrh r2,[r3,#0x0]	; 023070CC
	mov r1,#0x1	; 023070CE
	bic r2,r1	; 023070D0
	and r0,r1	; 023070D2
	orr r2,r0	; 023070D4
	strh r2,[r3,#0x0]	; 023070D6
	mov r0,#0x0	; 023070D8
	bx lr	; 023070DA
pool_023070DC:
loc_023070DC:
	.word FirmwareWlWorkPointerSlot	; 023070DC
pool_023070E0:
loc_023070E0:
	.word 0x000002FE	; 023070E0

; ===== function loc_023070E4 =====
loc_023070E4:
	push {r4,lr}	; 023070E4
	add r4,r0,#0x0	; 023070E6
	ldr r0,[pool_02307120]	; 023070E8
	add r1,r4,#0x0	; 023070EA
	mov r2,#0x14	; 023070EC
	bl loc_0230545C	; 023070EE
	ldr r0,[pool_02307124]	; 023070F2
	add r1,r4,#0x0	; 023070F4
	add r1,#0x14	; 023070F6
	mov r2,#0x14	; 023070F8
	bl loc_0230545C	; 023070FA
	ldr r0,[pool_02307128]	; 023070FE
	add r1,r4,#0x0	; 02307100
	add r1,#0x28	; 02307102
	mov r2,#0x14	; 02307104
	bl loc_0230545C	; 02307106
	ldr r0,[pool_0230712C]	; 0230710A
	add r4,#0x3c	; 0230710C
	add r1,r4,#0x0	; 0230710E
	mov r2,#0x14	; 02307110
	bl loc_0230545C	; 02307112
	mov r0,#0x0	; 02307116
	pop {r4}	; 02307118
	pop {r3}	; 0230711A
	bx r3	; 0230711C
	.byte 0xC0, 0x46	; 02307120
pool_02307120:
loc_02307120:
	.word 0x04805F80	; 02307120
pool_02307124:
loc_02307124:
	.word 0x04805FA0	; 02307124
pool_02307128:
loc_02307128:
	.word 0x04805FC0	; 02307128
pool_0230712C:
loc_0230712C:
	.word 0x04805FE0	; 0230712C

; ===== function loc_02307130 =====
loc_02307130:
	cmp r0,#0x3	; 02307130
	bls loc_02307138	; 02307132
	mov r0,#0x5	; 02307134
	bx lr	; 02307136
loc_02307138:
	ldr r1,[pool_02307144]	; 02307138
	ldr r2,[r1,#0x0]	; 0230713A
	ldr r1,[pool_02307148]	; 0230713C
	strh r0,[r2,r1]	; 0230713E
	mov r0,#0x0	; 02307140
	bx lr	; 02307142
pool_02307144:
loc_02307144:
	.word FirmwareWlWorkPointerSlot	; 02307144
pool_02307148:
loc_02307148:
	.word 0x000002FA	; 02307148

; ===== function loc_0230714C =====
loc_0230714C:
	push {r4,lr}	; 0230714C
	cmp r0,#0x3	; 0230714E
	bls loc_02307156	; 02307150
	mov r0,#0x5	; 02307152
	b loc_023071D0	; 02307154
loc_02307156:
	ldr r1,[pool_023071D8]	; 02307156
	ldr r3,[r1,#0x0]	; 02307158
	ldr r2,[pool_023071DC]	; 0230715A
	strh r0,[r3,r2]	; 0230715C
	cmp r0,#0x0	; 0230715E
	bne loc_02307180	; 02307160
	ldr r3,[r1,#0x0]	; 02307162
	ldr r2,[pool_023071E0]	; 02307164
	add r4,r3,r2	; 02307166
	ldrh r3,[r4,#0x0]	; 02307168
	mov r2,#0x10	; 0230716A
	bic r3,r2	; 0230716C
	strh r3,[r4,#0x0]	; 0230716E
	ldr r2,[r1,#0x0]	; 02307170
	ldr r1,[pool_023071E4]	; 02307172
	add r3,r2,r1	; 02307174
	ldrh r2,[r3,#0x0]	; 02307176
	ldr r1,[pool_023071E8]	; 02307178
	and r2,r1	; 0230717A
	strh r2,[r3,#0x0]	; 0230717C
	b loc_0230719C	; 0230717E
loc_02307180:
	ldr r3,[r1,#0x0]	; 02307180
	ldr r2,[pool_023071E0]	; 02307182
	add r4,r3,r2	; 02307184
	ldrh r3,[r4,#0x0]	; 02307186
	mov r2,#0x10	; 02307188
	orr r3,r2	; 0230718A
	strh r3,[r4,#0x0]	; 0230718C
	ldr r2,[r1,#0x0]	; 0230718E
	ldr r1,[pool_023071E4]	; 02307190
	add r3,r2,r1	; 02307192
	ldrh r2,[r3,#0x0]	; 02307194
	ldr r1,[pool_023071EC]	; 02307196
	orr r2,r1	; 02307198
	strh r2,[r3,#0x0]	; 0230719A
loc_0230719C:
	ldr r1,[pool_023071D8]	; 0230719C
	ldr r1,[r1,#0x0]	; 0230719E
	ldr r2,[pool_023071F0]	; 023071A0
	ldrh r2,[r1,r2]	; 023071A2
	cmp r2,#0x40	; 023071A4
	bne loc_023071BA	; 023071A6
	ldr r2,[pool_023071F4]	; 023071A8
	ldrh r2,[r1,r2]	; 023071AA
	cmp r2,#0x1	; 023071AC
	bne loc_023071BA	; 023071AE
	ldr r2,[pool_023071E0]	; 023071B0
	ldrh r3,[r1,r2]	; 023071B2
	ldr r2,[pool_023071F8]	; 023071B4
	ldr r1,[r1,r2]	; 023071B6
	strh r3,[r1,#0x2e]	; 023071B8
loc_023071BA:
	cmp r0,#0x0	; 023071BA
	bne loc_023071C0	; 023071BC
	mov r0,#0x1	; 023071BE
loc_023071C0:
	ldr r2,[pool_023071FC]	; 023071C0
	ldrh r3,[r2,#0x0]	; 023071C2
	ldr r1,[pool_02307200]	; 023071C4
	and r3,r1	; 023071C6
	lsl r0,r0,#0x3	; 023071C8
	orr r3,r0	; 023071CA
	strh r3,[r2,#0x0]	; 023071CC
	mov r0,#0x0	; 023071CE
loc_023071D0:
	pop {r4}	; 023071D0
	pop {r3}	; 023071D2
	bx r3	; 023071D4
	.byte 0xC0, 0x46	; 023071D8
pool_023071D8:
loc_023071D8:
	.word FirmwareWlWorkPointerSlot	; 023071D8
pool_023071DC:
loc_023071DC:
	.word 0x000002F8	; 023071DC
pool_023071E0:
loc_023071E0:
	.word 0x00000378	; 023071E0
pool_023071E4:
loc_023071E4:
	.word 0x00000386	; 023071E4
pool_023071E8:
loc_023071E8:
	.word 0xFFFFBFFF	; 023071E8
pool_023071EC:
loc_023071EC:
	.word 0x00004000	; 023071EC
pool_023071F0:
loc_023071F0:
	.word 0x00000310	; 023071F0
pool_023071F4:
loc_023071F4:
	.word 0x000002F2	; 023071F4
pool_023071F8:
loc_023071F8:
	.word 0x00000464	; 023071F8
pool_023071FC:
loc_023071FC:
	.word REG_WIFI_MODE_WEP	; 023071FC
pool_02307200:
loc_02307200:
	.word 0x0000FFC7	; 02307200

; ===== function loc_02307204 =====
loc_02307204:
	push {lr}	; 02307204
	sub sp,#0x4	; 02307206
	cmp r0,#0x2	; 02307208
	bhi loc_0230721C	; 0230720A
	ldr r1,[pool_02307224]	; 0230720C
	ldr r2,[r1,#0x0]	; 0230720E
	ldr r1,[pool_02307228]	; 02307210
	strh r0,[r2,r1]	; 02307212
	bl loc_023068B8	; 02307214
	mov r0,#0x0	; 02307218
	b loc_0230721E	; 0230721A
loc_0230721C:
	mov r0,#0x5	; 0230721C
loc_0230721E:
	add sp,#0x4	; 0230721E
	pop {r3}	; 02307220
	bx r3	; 02307222
pool_02307224:
loc_02307224:
	.word FirmwareWlWorkPointerSlot	; 02307224
pool_02307228:
loc_02307228:
	.word 0x000002F4	; 02307228

; ===== function loc_0230722C =====
loc_0230722C:
	push {r4,lr}	; 0230722C
	cmp r0,#0x3	; 0230722E
	bls loc_02307236	; 02307230
	mov r0,#0x5	; 02307232
	b loc_02307270	; 02307234
loc_02307236:
	ldr r1,[pool_02307278]	; 02307236
	ldr r3,[r1,#0x0]	; 02307238
	ldr r2,[pool_0230727C]	; 0230723A
	strh r0,[r3,r2]	; 0230723C
	ldr r3,[r1,#0x0]	; 0230723E
	ldr r2,[pool_02307280]	; 02307240
	strh r0,[r3,r2]	; 02307242
	ldr r3,[pool_02307284]	; 02307244
	ldrh r4,[r3,#0x0]	; 02307246
	ldr r2,[pool_02307288]	; 02307248
	and r4,r2	; 0230724A
	orr r4,r0	; 0230724C
	strh r4,[r3,#0x0]	; 0230724E
	ldr r1,[r1,#0x0]	; 02307250
	ldr r0,[pool_0230728C]	; 02307252
	ldrh r0,[r1,r0]	; 02307254
	lsl r0,r0,#0x1f	; 02307256
	lsr r0,r0,#0x1f	; 02307258
	bl loc_0230684C	; 0230725A
	ldr r0,[pool_02307278]	; 0230725E
	ldr r1,[r0,#0x0]	; 02307260
	ldr r0,[pool_02307290]	; 02307262
	add r2,r1,r0	; 02307264
	ldr r1,[r2,#0x0]	; 02307266
	mov r0,#0x8	; 02307268
	orr r1,r0	; 0230726A
	str r1,[r2,#0x0]	; 0230726C
	mov r0,#0x0	; 0230726E
loc_02307270:
	pop {r4}	; 02307270
	pop {r3}	; 02307272
	bx r3	; 02307274
	.byte 0xC0, 0x46	; 02307278
pool_02307278:
loc_02307278:
	.word FirmwareWlWorkPointerSlot	; 02307278
pool_0230727C:
loc_0230727C:
	.word 0x000002F2	; 0230727C
pool_02307280:
loc_02307280:
	.word 0x00000314	; 02307280
pool_02307284:
loc_02307284:
	.word REG_WIFI_MODE_WEP	; 02307284
pool_02307288:
loc_02307288:
	.word 0x0000FFF8	; 02307288
pool_0230728C:
loc_0230728C:
	.word 0x00000316	; 0230728C
pool_02307290:
loc_02307290:
	.word 0x00000304	; 02307290

; ===== function loc_02307294 =====
loc_02307294:
	ldr r1,[pool_023072BC]	; 02307294
	add r2,r0,#0x0	; 02307296
	and r2,r1	; 02307298
	cmp r2,#0x0	; 0230729A
	bne loc_023072A2	; 0230729C
	mov r0,#0x5	; 0230729E
	bx lr	; 023072A0
loc_023072A2:
	ldr r3,[pool_023072C0]	; 023072A2
	ldr r2,[r3,#0x0]	; 023072A4
	ldr r1,[pool_023072C4]	; 023072A6
	strh r0,[r2,r1]	; 023072A8
	ldr r1,[r3,#0x0]	; 023072AA
	ldr r0,[pool_023072C8]	; 023072AC
	add r2,r1,r0	; 023072AE
	ldr r1,[r2,#0x0]	; 023072B0
	mov r0,#0x4	; 023072B2
	orr r1,r0	; 023072B4
	str r1,[r2,#0x0]	; 023072B6
	mov r0,#0x0	; 023072B8
	bx lr	; 023072BA
pool_023072BC:
loc_023072BC:
	.word 0x00007FFE	; 023072BC
pool_023072C0:
loc_023072C0:
	.word FirmwareWlWorkPointerSlot	; 023072C0
pool_023072C4:
loc_023072C4:
	.word 0x000002F0	; 023072C4
pool_023072C8:
loc_023072C8:
	.word 0x00000304	; 023072C8

; ===== function loc_023072CC =====
loc_023072CC:
	cmp r0,#0xff	; 023072CC
	bls loc_023072D4	; 023072CE
	mov r0,#0x5	; 023072D0
	bx lr	; 023072D2
loc_023072D4:
	ldr r1,[pool_023072E4]	; 023072D4
	ldr r2,[r1,#0x0]	; 023072D6
	ldr r1,[pool_023072E8]	; 023072D8
	strh r0,[r2,r1]	; 023072DA
	ldr r1,[pool_023072EC]	; 023072DC
	strh r0,[r1,#0x0]	; 023072DE
	mov r0,#0x0	; 023072E0
	bx lr	; 023072E2
pool_023072E4:
loc_023072E4:
	.word FirmwareWlWorkPointerSlot	; 023072E4
pool_023072E8:
loc_023072E8:
	.word 0x000002EE	; 023072E8
pool_023072EC:
loc_023072EC:
	.word REG_WIFI_TX_RETRYLIMIT	; 023072EC

; ===== function loc_023072F0 =====
loc_023072F0:
	push {r4,lr}	; 023072F0
	add r4,r0,#0x0	; 023072F2
	ldrh r1,[r4,#0x0]	; 023072F4
	mov r0,#0x1	; 023072F6
	and r1,r0	; 023072F8
	cmp r1,#0x0	; 023072FA
	beq loc_02307302	; 023072FC
	mov r0,#0x5	; 023072FE
	b loc_0230732A	; 02307300
loc_02307302:
	ldr r0,[pool_02307330]	; 02307302
	ldr r1,[r0,#0x0]	; 02307304
	ldr r0,[pool_02307334]	; 02307306
	add r0,r1,r0	; 02307308
	add r1,r4,#0x0	; 0230730A
	bl loc_0230645C	; 0230730C
	ldr r0,[pool_02307338]	; 02307310
	add r1,r4,#0x0	; 02307312
	bl loc_0230645C	; 02307314
	ldr r0,[pool_02307330]	; 02307318
	ldr r1,[r0,#0x0]	; 0230731A
	ldr r0,[pool_0230733C]	; 0230731C
	add r2,r1,r0	; 0230731E
	ldr r1,[r2,#0x0]	; 02307320
	mov r0,#0x2	; 02307322
	orr r1,r0	; 02307324
	str r1,[r2,#0x0]	; 02307326
	mov r0,#0x0	; 02307328
loc_0230732A:
	pop {r4}	; 0230732A
	pop {r3}	; 0230732C
	bx r3	; 0230732E
pool_02307330:
loc_02307330:
	.word FirmwareWlWorkPointerSlot	; 02307330
pool_02307334:
loc_02307334:
	.word 0x000002E8	; 02307334
pool_02307338:
loc_02307338:
	.word 0x04808018	; 02307338
pool_0230733C:
loc_0230733C:
	.word 0x00000304	; 0230733C

; ===== function loc_02307340 =====
loc_02307340:
	push {r4,r5,r6,lr}	; 02307340
	sub sp,#0x8	; 02307342
	add r5,r0,#0x0	; 02307344
	add r6,r1,#0x0	; 02307346
	ldr r0,[pool_023073A0]	; 02307348
	ldr r1,[r0,#0x0]	; 0230734A
	ldr r0,[pool_023073A4]	; 0230734C
	ldr r4,[r1,r0]	; 0230734E
	mov r2,#0x0	; 02307350
	add r0,sp,#0x0	; 02307352
	strh r2,[r0,#0x0]	; 02307354
	ldrh r0,[r0,#0x0]	; 02307356
	ldr r2,[pool_023073A8]	; 02307358
	add r1,r1,r2	; 0230735A
	mov r2,#0x28	; 0230735C
	bl loc_023073B8	; 0230735E
	mov r1,#0x0	; 02307362
	add r0,sp,#0x0	; 02307364
	strh r1,[r0,#0x2]	; 02307366
	ldrh r0,[r0,#0x2]	; 02307368
	ldr r1,[pool_023073A0]	; 0230736A
	ldr r2,[r1,#0x0]	; 0230736C
	ldr r1,[pool_023073AC]	; 0230736E
	add r1,r2,r1	; 02307370
	mov r2,#0xb4	; 02307372
	bl loc_023073C4	; 02307374
	ldr r0,[pool_023073A0]	; 02307378
	ldr r2,[r0,#0x0]	; 0230737A
	ldr r1,[pool_023073A8]	; 0230737C
	str r5,[r2,r1]	; 0230737E
	lsl r1,r6,#0x10	; 02307380
	lsr r3,r1,#0x10	; 02307382
	ldr r2,[r0,#0x0]	; 02307384
	ldr r1,[pool_023073B0]	; 02307386
	strh r3,[r2,r1]	; 02307388
	ldr r2,[r0,#0x0]	; 0230738A
	ldr r1,[pool_023073B4]	; 0230738C
	strh r3,[r2,r1]	; 0230738E
	ldr r1,[r0,#0x0]	; 02307390
	ldr r0,[pool_023073A4]	; 02307392
	str r4,[r1,r0]	; 02307394
	add sp,#0x8	; 02307396
	pop {r4,r5,r6}	; 02307398
	pop {r3}	; 0230739A
	bx r3	; 0230739C
	.byte 0xC0, 0x46	; 023073A0
pool_023073A0:
loc_023073A0:
	.word FirmwareWlWorkPointerSlot	; 023073A0
pool_023073A4:
loc_023073A4:
	.word 0x00000398	; 023073A4
pool_023073A8:
loc_023073A8:
	.word 0x000002E0	; 023073A8
pool_023073AC:
loc_023073AC:
	.word 0x00000308	; 023073AC
pool_023073B0:
loc_023073B0:
	.word 0x000002E4	; 023073B0
pool_023073B4:
loc_023073B4:
	.word 0x000002E6	; 023073B4

; ===== function loc_023073B8 =====
loc_023073B8:
	bx pc	; 023073B8
	.byte 0xC0, 0x46	; 023073BC
.arm

; ===== function loc_023073BC =====
loc_023073BC:
	ldr pc,[pool_023073C0]	; 023073BC
pool_023073C0:
loc_023073C0:
	.word loc_037FCE04	; 023073C0
.thumb

; ===== function loc_023073C4 =====
loc_023073C4:
	bx pc	; 023073C4
	.byte 0xC0, 0x46	; 023073C8
.arm

; ===== function loc_023073C8 =====
loc_023073C8:
	ldr pc,[pool_023073CC]	; 023073C8
pool_023073CC:
loc_023073CC:
	.word loc_037FCE04	; 023073CC
.thumb

; ===== function loc_023073D0 =====
loc_023073D0:
	push {r4,r5,r6,r7,lr}	; 023073D0
	sub sp,#0x4	; 023073D2
	mov r7,#0x0	; 023073D4
	ldr r0,[pool_02307458]	; 023073D6
	ldr r1,[r0,#0x0]	; 023073D8
	ldr r0,[pool_0230745C]	; 023073DA
	ldrh r0,[r1,r0]	; 023073DC
	cmp r0,#0x5	; 023073DE
	bne loc_023073E8	; 023073E0
	ldr r0,[pool_02307460]	; 023073E2
	str r0,[sp,#0x0]	; 023073E4
	b loc_023073EC	; 023073E6
loc_023073E8:
	ldr r0,[pool_02307464]	; 023073E8
	str r0,[sp,#0x0]	; 023073EA
loc_023073EC:
	mov r4,#0xff	; 023073EC
	mov r5,#0x0	; 023073EE
loc_023073F0:
	add r0,r5,#0x0	; 023073F0
	add r1,r4,#0x0	; 023073F2
	bl loc_02305A9C	; 023073F4
	add r5,r5,#0x1	; 023073F8
	sub r0,r4,#0x1	; 023073FA
	lsl r0,r0,#0x10	; 023073FC
	lsr r4,r0,#0x10	; 023073FE
	cmp r5,#0x69	; 02307400
	bcc loc_023073F0	; 02307402
	mov r5,#0xff	; 02307404
	mov r4,#0x0	; 02307406
	add r6,r4,#0x0	; 02307408
	b loc_02307438	; 0230740A
loc_0230740C:
	lsl r1,r6,#0x1	; 0230740C
	ldr r0,[sp,#0x0]	; 0230740E
	ldrh r0,[r0,r1]	; 02307410
	cmp r4,r0	; 02307412
	bne loc_0230741A	; 02307414
	add r6,r6,#0x1	; 02307416
	b loc_02307430	; 02307418
loc_0230741A:
	add r0,r4,#0x0	; 0230741A
	bl loc_02305B08	; 0230741C
	lsl r0,r0,#0x10	; 02307420
	lsr r0,r0,#0x10	; 02307422
	cmp r0,r5	; 02307424
	beq loc_02307430	; 02307426
	add r0,r7,#0x0	; 02307428
	add r7,r7,#0x1	; 0230742A
	cmp r0,#0x20	; 0230742C
	bhi loc_0230743C	; 0230742E
loc_02307430:
	add r4,r4,#0x1	; 02307430
	sub r0,r5,#0x1	; 02307432
	lsl r0,r0,#0x10	; 02307434
	lsr r5,r0,#0x10	; 02307436
loc_02307438:
	cmp r4,#0x69	; 02307438
	bcc loc_0230740C	; 0230743A
loc_0230743C:
	cmp r7,#0x0	; 0230743C
	beq loc_02307450	; 0230743E
	ldr r0,[pool_02307458]	; 02307440
	ldr r1,[r0,#0x0]	; 02307442
	ldr r0,[pool_02307468]	; 02307444
	add r2,r1,r0	; 02307446
	ldrh r1,[r2,#0x0]	; 02307448
	mov r0,#0x8	; 0230744A
	orr r1,r0	; 0230744C
	strh r1,[r2,#0x0]	; 0230744E
loc_02307450:
	add sp,#0x4	; 02307450
	pop {r4,r5,r6,r7}	; 02307452
	pop {r3}	; 02307454
	bx r3	; 02307456
pool_02307458:
loc_02307458:
	.word FirmwareWlWorkPointerSlot	; 02307458
pool_0230745C:
loc_0230745C:
	.word 0x000005B0	; 0230745C
pool_02307460:
loc_02307460:
	.word 0x023105C8	; 02307460
pool_02307464:
loc_02307464:
	.word 0x023105FC	; 02307464
pool_02307468:
loc_02307468:
	.word 0x00000302	; 02307468

; ===== function loc_0230746C =====
loc_0230746C:
	push {r4,r5,r6,r7,lr}	; 0230746C
	sub sp,#0xc	; 0230746E
	str r0,[sp,#0x0]	; 02307470
	add r5,r1,#0x0	; 02307472
	mov r7,#0x0	; 02307474
	ldr r0,[pool_02307578]	; 02307476
	cmp r5,r0	; 02307478
	bcc loc_0230747E	; 0230747A
	add r5,r0,#0x0	; 0230747C
loc_0230747E:
	ldr r1,[pool_0230757C]	; 0230747E
	ldr r0,[pool_02307580]	; 02307480
	strh r1,[r0,#0x0]	; 02307482
	ldr r1,[pool_02307584]	; 02307484
	ldr r0,[pool_02307588]	; 02307486
	strh r1,[r0,#0x0]	; 02307488
	ldr r1,[pool_0230758C]	; 0230748A
	ldr r0,[pool_02307590]	; 0230748C
	strh r1,[r0,#0x0]	; 0230748E
	ldr r0,[sp,#0x0]	; 02307490
	mov r2,#0x0	; 02307492
	add r1,r2,#0x0	; 02307494
	b loc_023074A6	; 02307496
loc_02307498:
	add r3,r2,#0x0	; 02307498
	sub r2,r2,#0x1	; 0230749A
	lsl r2,r2,#0x10	; 0230749C
	lsr r2,r2,#0x10	; 0230749E
	strh r3,[r0,#0x0]	; 023074A0
	add r0,r0,#0x2	; 023074A2
	add r1,r1,#0x2	; 023074A4
loc_023074A6:
	cmp r1,r5	; 023074A6
	bcc loc_02307498	; 023074A8
	add r6,r5,#0x0	; 023074AA
	ldr r4,[pool_02307594]	; 023074AC
	b loc_023074EA	; 023074AE
loc_023074B0:
	add r1,r4,r5	; 023074B0
	ldr r0,[pool_02307598]	; 023074B2
	cmp r1,r0	; 023074B4
	bls loc_023074BA	; 023074B6
	sub r6,r0,r4	; 023074B8
loc_023074BA:
	add r0,r4,#0x0	; 023074BA
	ldr r1,[sp,#0x0]	; 023074BC
	add r2,r6,#0x0	; 023074BE
	bl loc_0230545C	; 023074C0
	add r3,r4,#0x0	; 023074C4
	mov r2,#0x0	; 023074C6
	lsl r1,r2,#0	; 023074C8
	b loc_023074E4	; 023074CA
loc_023074CC:
	ldrh r0,[r3,#0x0]	; 023074CC
	cmp r2,r0	; 023074CE
	beq loc_023074DA	; 023074D0
	add r0,r7,#0x0	; 023074D2
	add r7,r7,#0x1	; 023074D4
	cmp r0,#0x20	; 023074D6
	bhi loc_0230755A	; 023074D8
loc_023074DA:
	add r1,r1,#0x2	; 023074DA
	add r3,r3,#0x2	; 023074DC
	sub r0,r2,#0x1	; 023074DE
	lsl r0,r0,#0x10	; 023074E0
	lsr r2,r0,#0x10	; 023074E2
loc_023074E4:
	cmp r1,r6	; 023074E4
	bcc loc_023074CC	; 023074E6
	add r4,r4,r6	; 023074E8
loc_023074EA:
	ldr r0,[pool_02307598]	; 023074EA
	cmp r4,r0	; 023074EC
	bcc loc_023074B0	; 023074EE
	ldr r1,[pool_02307594]	; 023074F0
	mov r3,#0x0	; 023074F2
	add r0,r3,#0x0	; 023074F4
	ldr r4,[pool_02307578]	; 023074F6
loc_023074F8:
	add r2,r3,#0x0	; 023074F8
	sub r3,r3,#0x1	; 023074FA
	lsl r3,r3,#0x10	; 023074FC
	lsr r3,r3,#0x10	; 023074FE
	strh r2,[r1,#0x0]	; 02307500
	add r1,r1,#0x2	; 02307502
	add r0,r0,#0x2	; 02307504
	cmp r0,r4	; 02307506
	bcc loc_023074F8	; 02307508
	add r6,r5,#0x0	; 0230750A
	mov r0,#0x0	; 0230750C
	str r0,[sp,#0x4]	; 0230750E
	ldr r4,[pool_02307594]	; 02307510
	str r0,[sp,#0x8]	; 02307512
	b loc_02307554	; 02307514
loc_02307516:
	add r1,r4,r5	; 02307516
	ldr r0,[pool_02307598]	; 02307518
	cmp r1,r0	; 0230751A
	bls loc_02307520	; 0230751C
	sub r6,r0,r4	; 0230751E
loc_02307520:
	ldr r0,[sp,#0x0]	; 02307520
	add r1,r4,#0x0	; 02307522
	add r2,r6,#0x0	; 02307524
	bl loc_023054EC	; 02307526
	ldr r2,[sp,#0x0]	; 0230752A
	ldr r3,[sp,#0x8]	; 0230752C
	b loc_0230754E	; 0230752E
loc_02307530:
	ldrh r1,[r2,#0x0]	; 02307530
	ldr r0,[sp,#0x4]	; 02307532
	cmp r1,r0	; 02307534
	beq loc_02307540	; 02307536
	add r0,r7,#0x0	; 02307538
	add r7,r7,#0x1	; 0230753A
	cmp r0,#0x20	; 0230753C
	bhi loc_0230755A	; 0230753E
loc_02307540:
	add r3,r3,#0x2	; 02307540
	ldr r0,[sp,#0x4]	; 02307542
	sub r0,r0,#0x1	; 02307544
	lsl r0,r0,#0x10	; 02307546
	lsr r0,r0,#0x10	; 02307548
	str r0,[sp,#0x4]	; 0230754A
	add r2,r2,#0x2	; 0230754C
loc_0230754E:
	cmp r3,r6	; 0230754E
	bcc loc_02307530	; 02307550
	add r4,r4,r6	; 02307552
loc_02307554:
	ldr r0,[pool_02307598]	; 02307554
	cmp r4,r0	; 02307556
	bcc loc_02307516	; 02307558
loc_0230755A:
	cmp r7,#0x0	; 0230755A
	beq loc_0230756E	; 0230755C
	ldr r0,[pool_0230759C]	; 0230755E
	ldr r1,[r0,#0x0]	; 02307560
	ldr r0,[pool_023075A0]	; 02307562
	add r2,r1,r0	; 02307564
	ldrh r1,[r2,#0x0]	; 02307566
	mov r0,#0x4	; 02307568
	orr r1,r0	; 0230756A
	strh r1,[r2,#0x0]	; 0230756C
loc_0230756E:
	add r0,r7,#0x0	; 0230756E
	add sp,#0xc	; 02307570
	pop {r4,r5,r6,r7}	; 02307572
	pop {r3}	; 02307574
	bx r3	; 02307576
pool_02307578:
loc_02307578:
	.word 0x00002000	; 02307578
pool_0230757C:
loc_0230757C:
	.word 0x00004000	; 0230757C
pool_02307580:
loc_02307580:
	.word REG_WIFI_RXBUF_BEGIN	; 02307580
pool_02307584:
loc_02307584:
	.word 0x00006000	; 02307584
pool_02307588:
loc_02307588:
	.word REG_WIFI_RXBUF_END	; 02307588
pool_0230758C:
loc_0230758C:
	.word 0x00005000	; 0230758C
pool_02307590:
loc_02307590:
	.word REG_WIFI_RXBUF_GAP	; 02307590
pool_02307594:
loc_02307594:
	.word WifiRamBase	; 02307594
pool_02307598:
loc_02307598:
	.word 0x04806000	; 02307598
pool_0230759C:
loc_0230759C:
	.word FirmwareWlWorkPointerSlot	; 0230759C
pool_023075A0:
loc_023075A0:
	.word 0x00000302	; 023075A0

; ===== function loc_023075A4 =====
loc_023075A4:
	push {r4,lr}	; 023075A4
	ldr r0,[pool_023075EC]	; 023075A6
	ldr r1,[r0,#0x0]	; 023075A8
	ldr r0,[pool_023075F0]	; 023075AA
	add r0,r1,r0	; 023075AC
	ldr r1,[pool_023075F4]	; 023075AE
	bl loc_02305054	; 023075B0
	add r4,r0,#0x0	; 023075B4
	cmp r4,#0x0	; 023075B6
	beq loc_023075E4	; 023075B8
	add r0,#0x10	; 023075BA
	mov r1,#0xf6	; 023075BC
	bl loc_0230746C	; 023075BE
	cmp r0,#0x0	; 023075C2
	beq loc_023075D6	; 023075C4
	ldr r0,[pool_023075EC]	; 023075C6
	ldr r1,[r0,#0x0]	; 023075C8
	ldr r0,[pool_023075F0]	; 023075CA
	add r0,r1,r0	; 023075CC
	add r1,r4,#0x0	; 023075CE
	bl loc_02304FFC	; 023075D0
	b loc_023075E4	; 023075D4
loc_023075D6:
	ldr r0,[pool_023075EC]	; 023075D6
	ldr r1,[r0,#0x0]	; 023075D8
	ldr r0,[pool_023075F0]	; 023075DA
	add r0,r1,r0	; 023075DC
	add r1,r4,#0x0	; 023075DE
	bl loc_02304FFC	; 023075E0
loc_023075E4:
	pop {r4}	; 023075E4
	pop {r3}	; 023075E6
	bx r3	; 023075E8
	.byte 0xC0, 0x46	; 023075EC
pool_023075EC:
loc_023075EC:
	.word FirmwareWlWorkPointerSlot	; 023075EC
pool_023075F0:
loc_023075F0:
	.word 0x0000014C	; 023075F0
pool_023075F4:
loc_023075F4:
	.word 0x00000106	; 023075F4

; ===== function loc_023075F8 =====
loc_023075F8:
	push {r4,r5,lr}	; 023075F8
	sub sp,#0x4	; 023075FA
	mov r0,#0x0	; 023075FC
	ldr r4,[pool_0230765C]	; 023075FE
	ldr r1,[pool_02307660]	; 02307600
	add r5,r0,#0x0	; 02307602
	ldr r2,[pool_02307664]	; 02307604
loc_02307606:
	add r3,r1,#0x0	; 02307606
	sub r1,r1,#0x1	; 02307608
	lsl r1,r1,#0x10	; 0230760A
	lsr r1,r1,#0x10	; 0230760C
	strh r3,[r4,#0x0]	; 0230760E
	add r4,r4,#0x2	; 02307610
	add r5,r5,#0x2	; 02307612
	cmp r5,r2	; 02307614
	bcc loc_02307606	; 02307616
	ldr r5,[pool_0230765C]	; 02307618
	ldr r4,[pool_02307660]	; 0230761A
	mov r3,#0x0	; 0230761C
	ldr r1,[pool_02307664]	; 0230761E
	b loc_0230763A	; 02307620
loc_02307622:
	ldrh r2,[r5,#0x0]	; 02307622
	cmp r2,r4	; 02307624
	beq loc_02307630	; 02307626
	add r2,r0,#0x0	; 02307628
	add r0,r0,#0x1	; 0230762A
	cmp r2,#0x20	; 0230762C
	bhi loc_0230763E	; 0230762E
loc_02307630:
	add r3,r3,#0x2	; 02307630
	add r5,r5,#0x2	; 02307632
	sub r2,r4,#0x1	; 02307634
	lsl r2,r2,#0x10	; 02307636
	lsr r4,r2,#0x10	; 02307638
loc_0230763A:
	cmp r3,r1	; 0230763A
	bcc loc_02307622	; 0230763C
loc_0230763E:
	cmp r0,#0x0	; 0230763E
	beq loc_02307652	; 02307640
	ldr r0,[pool_02307668]	; 02307642
	ldr r1,[r0,#0x0]	; 02307644
	ldr r0,[pool_0230766C]	; 02307646
	add r2,r1,r0	; 02307648
	ldrh r1,[r2,#0x0]	; 0230764A
	mov r0,#0x2	; 0230764C
	orr r1,r0	; 0230764E
	strh r1,[r2,#0x0]	; 02307650
loc_02307652:
	add sp,#0x4	; 02307652
	pop {r4,r5}	; 02307654
	pop {r3}	; 02307656
	bx r3	; 02307658
	.byte 0xC0, 0x46	; 0230765C
pool_0230765C:
loc_0230765C:
	.word WifiRamBase	; 0230765C
pool_02307660:
loc_02307660:
	.word 0x0000FFFF	; 02307660
pool_02307664:
loc_02307664:
	.word 0x00002000	; 02307664
pool_02307668:
loc_02307668:
	.word FirmwareWlWorkPointerSlot	; 02307668
pool_0230766C:
loc_0230766C:
	.word 0x00000302	; 0230766C

; ===== function loc_02307670 =====
loc_02307670:
	push {r4,r5,r6,r7,lr}	; 02307670
	sub sp,#0x4	; 02307672
	mov r0,#0x0	; 02307674
	add r3,r0,#0x0	; 02307676
	ldr r4,[pool_02307710]	; 02307678
	ldr r2,[pool_02307714]	; 0230767A
	add r6,r4,#0x0	; 0230767C
loc_0230767E:
	lsl r7,r3,#0x2	; 0230767E
	add r1,r2,r7	; 02307680
	ldrh r5,[r1,#0x2]	; 02307682
	add r1,r4,#0x0	; 02307684
	and r1,r5	; 02307686
	ldrh r7,[r2,r7]	; 02307688
	ldr r5,[pool_02307718]	; 0230768A
	strh r1,[r7,r5]	; 0230768C
	add r1,r4,r6	; 0230768E
	lsl r1,r1,#0x10	; 02307690
	lsr r4,r1,#0x10	; 02307692
	add r3,r3,#0x1	; 02307694
	cmp r3,#0x5	; 02307696
	bcc loc_0230767E	; 02307698
	mov r5,#0x0	; 0230769A
	ldr r4,[pool_02307710]	; 0230769C
	ldr r2,[pool_02307714]	; 0230769E
	add r6,r4,#0x0	; 023076A0
	b loc_023076C8	; 023076A2
loc_023076A4:
	lsl r1,r5,#0x2	; 023076A4
	add r3,r2,r1	; 023076A6
	ldrh r7,[r2,r1]	; 023076A8
	ldr r1,[pool_02307718]	; 023076AA
	ldrh r1,[r7,r1]	; 023076AC
	ldrh r3,[r3,#0x2]	; 023076AE
	add r7,r4,#0x0	; 023076B0
	and r7,r3	; 023076B2
	cmp r1,r7	; 023076B4
	beq loc_023076C0	; 023076B6
	add r1,r0,#0x0	; 023076B8
	add r0,r0,#0x1	; 023076BA
	cmp r1,#0x20	; 023076BC
	bhi loc_023076F2	; 023076BE
loc_023076C0:
	add r1,r4,r6	; 023076C0
	lsl r1,r1,#0x10	; 023076C2
	lsr r4,r1,#0x10	; 023076C4
	add r5,r5,#0x1	; 023076C6
loc_023076C8:
	cmp r5,#0x5	; 023076C8
	bcc loc_023076A4	; 023076CA
	mov r1,#0x0	; 023076CC
	ldr r5,[pool_02307714]	; 023076CE
	add r4,r1,#0x0	; 023076D0
	ldr r2,[pool_02307718]	; 023076D2
	b loc_023076EE	; 023076D4
loc_023076D6:
	lsl r3,r1,#0x2	; 023076D6
	ldrh r3,[r5,r3]	; 023076D8
	add r3,r3,r2	; 023076DA
	strh r4,[r3,#0x0]	; 023076DC
	ldrh r3,[r3,#0x0]	; 023076DE
	cmp r3,#0x0	; 023076E0
	beq loc_023076EC	; 023076E2
	add r3,r0,#0x0	; 023076E4
	add r0,r0,#0x1	; 023076E6
	cmp r3,#0x20	; 023076E8
	bhi loc_023076F2	; 023076EA
loc_023076EC:
	add r1,r1,#0x1	; 023076EC
loc_023076EE:
	cmp r1,#0x5	; 023076EE
	bcc loc_023076D6	; 023076F0
loc_023076F2:
	cmp r0,#0x0	; 023076F2
	beq loc_02307706	; 023076F4
	ldr r0,[pool_0230771C]	; 023076F6
	ldr r1,[r0,#0x0]	; 023076F8
	ldr r0,[pool_02307720]	; 023076FA
	add r2,r1,r0	; 023076FC
	ldrh r1,[r2,#0x0]	; 023076FE
	mov r0,#0x1	; 02307700
	orr r1,r0	; 02307702
	strh r1,[r2,#0x0]	; 02307704
loc_02307706:
	add sp,#0x4	; 02307706
	pop {r4,r5,r6,r7}	; 02307708
	pop {r3}	; 0230770A
	bx r3	; 0230770C
	.byte 0xC0, 0x46	; 02307710
pool_02307710:
loc_02307710:
	.word 0x00001234	; 02307710
pool_02307714:
loc_02307714:
	.word P4_Data_023105B4	; 02307714
pool_02307718:
loc_02307718:
	.word WifiIoWs1Base	; 02307718
pool_0230771C:
loc_0230771C:
	.word FirmwareWlWorkPointerSlot	; 0230771C
pool_02307720:
loc_02307720:
	.word 0x00000302	; 02307720

; ===== function loc_02307724 =====
loc_02307724:
	push {lr}	; 02307724
	sub sp,#0x4	; 02307726
	ldr r0,[pool_0230773C]	; 02307728
	ldr r1,[pool_02307740]	; 0230772A
	bl loc_02307744	; 0230772C
	ldr r0,[pool_0230773C]	; 02307730
	bl loc_02304B5C	; 02307732
	add sp,#0x4	; 02307736
	pop {r3}	; 02307738
	bx r3	; 0230773A
pool_0230773C:
loc_0230773C:
	.word 0x01000000	; 0230773C
pool_02307740:
loc_02307740:
	.word P4_IrqHandler_023085BC + 1	; 02307740

; ===== function loc_02307744 =====
loc_02307744:
	bx pc	; 02307744
	.byte 0xC0, 0x46	; 02307748
.arm

; ===== function loc_02307748 =====
loc_02307748:
	ldr r12,[pool_02307750]	; 02307748
	bx r12	; 0230774C
pool_02307750:
loc_02307750:
	.word loc_037FB620 + 1	; 02307750
.thumb

; ===== function loc_02307754 =====
loc_02307754:
	push {lr}	; 02307754
	sub sp,#0x4	; 02307756
	ldr r0,[pool_023077CC]	; 02307758
	ldr r1,[r0,#0x0]	; 0230775A
	ldr r0,[pool_023077D0]	; 0230775C
	add r0,r1,r0	; 0230775E
	add r1,r0,#0x0	; 02307760
	add r1,#0x50	; 02307762
	ldrh r1,[r1,#0x0]	; 02307764
	cmp r1,#0x0	; 02307766
	beq loc_02307792	; 02307768
	ldr r3,[r0,#0x58]	; 0230776A
	ldrh r2,[r3,#0x0]	; 0230776C
	mov r1,#0x1	; 0230776E
	and r2,r1	; 02307770
	cmp r2,#0x0	; 02307772
	beq loc_02307792	; 02307774
	ldr r1,[pool_023077D4]	; 02307776
	and r3,r1	; 02307778
	lsr r2,r3,#0x1	; 0230777A
	ldr r1,[pool_023077D8]	; 0230777C
	orr r2,r1	; 0230777E
	ldr r1,[pool_023077DC]	; 02307780
	ldrh r1,[r1,#0x0]	; 02307782
	cmp r2,r1	; 02307784
	beq loc_02307792	; 02307786
	add r0,#0x50	; 02307788
	bl loc_0230CED4	; 0230778A
	mov r0,#0x1	; 0230778E
	b loc_023077C6	; 02307790
loc_02307792:
	add r1,r0,#0x0	; 02307792
	add r1,#0x64	; 02307794
	ldrh r1,[r1,#0x0]	; 02307796
	cmp r1,#0x0	; 02307798
	beq loc_023077C4	; 0230779A
	ldr r3,[r0,#0x6c]	; 0230779C
	ldrh r2,[r3,#0x0]	; 0230779E
	mov r1,#0x1	; 023077A0
	and r2,r1	; 023077A2
	cmp r2,#0x0	; 023077A4
	beq loc_023077C4	; 023077A6
	ldr r1,[pool_023077D4]	; 023077A8
	and r3,r1	; 023077AA
	lsr r2,r3,#0x1	; 023077AC
	ldr r1,[pool_023077D8]	; 023077AE
	orr r2,r1	; 023077B0
	ldr r1,[pool_023077DC]	; 023077B2
	ldrh r1,[r1,#0x0]	; 023077B4
	cmp r2,r1	; 023077B6
	beq loc_023077C4	; 023077B8
	add r0,#0x64	; 023077BA
	bl loc_0230CED4	; 023077BC
	mov r0,#0x1	; 023077C0
	b loc_023077C6	; 023077C2
loc_023077C4:
	mov r0,#0x0	; 023077C4
loc_023077C6:
	add sp,#0x4	; 023077C6
	pop {r3}	; 023077C8
	bx r3	; 023077CA
pool_023077CC:
loc_023077CC:
	.word FirmwareWlWorkPointerSlot	; 023077CC
pool_023077D0:
loc_023077D0:
	.word 0x000003E4	; 023077D0
pool_023077D4:
loc_023077D4:
	.word 0x00003FFF	; 023077D4
pool_023077D8:
loc_023077D8:
	.word 0x00008000	; 023077D8
pool_023077DC:
loc_023077DC:
	.word REG_WIFI_TXBUF_REPLY2	; 023077DC

; ===== function loc_023077E0 =====
loc_023077E0:
	push {r4,r5,r6,r7,lr}	; 023077E0
	sub sp,#0x4	; 023077E2
	ldr r0,[pool_02307810]	; 023077E4
	ldr r1,[r0,#0x0]	; 023077E6
	ldr r2,[pool_02307814]	; 023077E8
	ldrh r1,[r1,r2]	; 023077EA
	ldr r3,[pool_02307818]	; 023077EC
	cmp r1,r3	; 023077EE
	beq loc_02307808	; 023077F0
	ldr r7,[pool_0230781C]	; 023077F2
	ldrh r6,[r7,#0x0]	; 023077F4
	strh r1,[r7,#0x0]	; 023077F6
	ldr r5,[pool_02307820]	; 023077F8
	ldrh r4,[r5,#0x0]	; 023077FA
	mov r1,#0x80	; 023077FC
	orr r4,r1	; 023077FE
	strh r4,[r5,#0x0]	; 02307800
	strh r6,[r7,#0x0]	; 02307802
	ldr r0,[r0,#0x0]	; 02307804
	strh r3,[r0,r2]	; 02307806
loc_02307808:
	add sp,#0x4	; 02307808
	pop {r4,r5,r6,r7}	; 0230780A
	pop {r3}	; 0230780C
	bx r3	; 0230780E
pool_02307810:
loc_02307810:
	.word FirmwareWlWorkPointerSlot	; 02307810
pool_02307814:
loc_02307814:
	.word 0x0000048A	; 02307814
pool_02307818:
loc_02307818:
	.word 0x0000FFFF	; 02307818
pool_0230781C:
loc_0230781C:
	.word REG_WIFI_TXBUF_REPLY1	; 0230781C
pool_02307820:
loc_02307820:
	.word REG_WIFI_RXCNT	; 02307820

; ===== function loc_02307824 =====
loc_02307824:
	ldr r1,[pool_02307838]	; 02307824
	cmp r0,r1	; 02307826
	bcc loc_02307834	; 02307828
	ldr r1,[pool_0230783C]	; 0230782A
	ldr r2,[r1,#0x0]	; 0230782C
	ldr r1,[pool_02307840]	; 0230782E
	ldrh r1,[r2,r1]	; 02307830
	sub r0,r0,r1	; 02307832
loc_02307834:
	bx lr	; 02307834
	.byte 0xC0, 0x46	; 02307838
pool_02307838:
loc_02307838:
	.word 0x04805F60	; 02307838
pool_0230783C:
loc_0230783C:
	.word FirmwareWlWorkPointerSlot	; 0230783C
pool_02307840:
loc_02307840:
	.word 0x00000396	; 02307840

; ===== function loc_02307844 =====
P4_Code_02307844:
	push {r4,lr}	; 02307844
	ldr r0,[pool_02307880]	; 02307846
	bl loc_02304B4C	; 02307848
	add r4,r0,#0x0	; 0230784C
	ldr r2,[pool_02307884]	; 0230784E
	ldrh r3,[r2,#0x0]	; 02307850
	ldr r1,[pool_02307888]	; 02307852
	ldr r0,[pool_0230788C]	; 02307854
	strh r1,[r0,#0x0]	; 02307856
	mov r1,#0x64	; 02307858
	b loc_02307864	; 0230785A
loc_0230785C:
	ldrh r0,[r2,#0x0]	; 0230785C
	cmp r3,r0	; 0230785E
	bne loc_02307868	; 02307860
	sub r1,r1,#0x1	; 02307862
loc_02307864:
	cmp r1,#0x0	; 02307864
	bne loc_0230785C	; 02307866
loc_02307868:
	mov r0,#0x0	; 02307868
	ldr r1,[pool_0230788C]	; 0230786A
	strh r0,[r1,#0x0]	; 0230786C
	bl loc_02307B5C	; 0230786E
	add r0,r4,#0x0	; 02307872
	bl loc_02304B5C	; 02307874
	pop {r4}	; 02307878
	pop {r3}	; 0230787A
	bx r3	; 0230787C
	.byte 0xC0, 0x46	; 02307880
pool_02307880:
loc_02307880:
	.word 0x01000000	; 02307880
pool_02307884:
loc_02307884:
	.word REG_WIFI_TX_SEQNO	; 02307884
pool_02307888:
loc_02307888:
	.word 0x00001000	; 02307888
pool_0230788C:
loc_0230788C:
	.word REG_WIFI_UNKNOWN_244	; 0230788C

; ===== function loc_02307890 =====
loc_02307890:
	push {r4,lr}	; 02307890
	mov r4,#0x0	; 02307892
	mov r0,#0x1	; 02307894
	bl loc_0230CD38	; 02307896
	lsl r0,r4,#0	; 0230789A
	bl loc_0230CD38	; 0230789C
	ldr r0,[pool_023078EC]	; 023078A0
	ldr r2,[r0,#0x0]	; 023078A2
	ldr r0,[pool_023078F0]	; 023078A4
	ldr r0,[r2,r0]	; 023078A6
	ldrh r0,[r0,#0x0]	; 023078A8
	cmp r0,#0x0	; 023078AA
	beq loc_023078B2	; 023078AC
	mov r4,#0x1	; 023078AE
	b loc_023078B8	; 023078B0
loc_023078B2:
	lsl r1,r4,#0	; 023078B2
	ldr r0,[pool_023078F4]	; 023078B4
	strh r1,[r2,r0]	; 023078B6
loc_023078B8:
	ldr r0,[pool_023078EC]	; 023078B8
	ldr r2,[r0,#0x0]	; 023078BA
	ldr r0,[pool_023078F8]	; 023078BC
	ldr r0,[r2,r0]	; 023078BE
	ldrh r0,[r0,#0x0]	; 023078C0
	cmp r0,#0x0	; 023078C2
	beq loc_023078CA	; 023078C4
	mov r4,#0x1	; 023078C6
	b loc_023078D0	; 023078C8
loc_023078CA:
	mov r1,#0x0	; 023078CA
	ldr r0,[pool_023078FC]	; 023078CC
	strh r1,[r2,r0]	; 023078CE
loc_023078D0:
	cmp r4,#0x0	; 023078D0
	beq loc_023078DC	; 023078D2
	mov r0,#0x0	; 023078D4
	mov r1,#0xe	; 023078D6
	bl loc_02304B6C	; 023078D8
loc_023078DC:
	mov r0,#0x0	; 023078DC
	mov r1,#0x14	; 023078DE
	bl loc_02304B6C	; 023078E0
	pop {r4}	; 023078E4
	pop {r3}	; 023078E6
	bx r3	; 023078E8
	.byte 0xC0, 0x46	; 023078EC
pool_023078EC:
loc_023078EC:
	.word FirmwareWlWorkPointerSlot	; 023078EC
pool_023078F0:
loc_023078F0:
	.word 0x00000400	; 023078F0
pool_023078F4:
loc_023078F4:
	.word 0x000003F8	; 023078F4
pool_023078F8:
loc_023078F8:
	.word 0x000003EC	; 023078F8
pool_023078FC:
loc_023078FC:
	.word 0x000003E4	; 023078FC

; ===== function loc_02307900 =====
loc_02307900:
	push {r4,r5,r6,r7,lr}	; 02307900
	sub sp,#0x4	; 02307902
	mov r1,#0x40	; 02307904
	ldr r0,[pool_02307A78]	; 02307906
	strh r1,[r0,#0x0]	; 02307908
	ldr r0,[pool_02307A7C]	; 0230790A
	ldr r2,[r0,#0x0]	; 0230790C
	ldr r0,[pool_02307A80]	; 0230790E
	ldrh r1,[r2,r0]	; 02307910
	mov r0,#0x20	; 02307912
	and r1,r0	; 02307914
	cmp r1,#0x0	; 02307916
	bne loc_0230791C	; 02307918
	b loc_02307A70	; 0230791A
loc_0230791C:
	ldr r0,[pool_02307A84]	; 0230791C
	ldrh r1,[r2,r0]	; 0230791E
	ldr r0,[pool_02307A88]	; 02307920
	cmp r1,r0	; 02307922
	beq loc_02307928	; 02307924
	b loc_02307A70	; 02307926
loc_02307928:
	ldr r0,[pool_02307A8C]	; 02307928
	ldrh r1,[r0,#0x0]	; 0230792A
	mov r0,#0x3	; 0230792C
	and r1,r0	; 0230792E
	cmp r1,#0x3	; 02307930
	beq loc_02307936	; 02307932
	b loc_02307A70	; 02307934
loc_02307936:
	ldr r0,[pool_02307A90]	; 02307936
	ldrh r2,[r0,#0x0]	; 02307938
	ldr r0,[pool_02307A94]	; 0230793A
	ldrh r0,[r0,#0x0]	; 0230793C
	lsr r1,r0,#0x1	; 0230793E
	ldr r0,[pool_02307A98]	; 02307940
	and r1,r0	; 02307942
	cmp r2,r1	; 02307944
	bge loc_0230794A	; 02307946
	b loc_02307A70	; 02307948
loc_0230794A:
	ldr r0,[pool_02307A9C]	; 0230794A
	ldrh r6,[r0,#0x0]	; 0230794C
	lsl r1,r6,#0x1	; 0230794E
	ldr r0,[pool_02307AA0]	; 02307950
	add r0,r1,r0	; 02307952
	add r0,#0x8	; 02307954
	bl loc_02307824	; 02307956
	add r0,r0,#0x4	; 0230795A
	bl loc_02307824	; 0230795C
	ldrh r2,[r0,#0x0]	; 02307960
	ldr r1,[pool_02307AA4]	; 02307962
	and r2,r1	; 02307964
	ldr r1,[pool_02307AA8]	; 02307966
	cmp r2,r1	; 02307968
	beq loc_0230796E	; 0230796A
	b loc_02307A70	; 0230796C
loc_0230796E:
	add r0,r0,#0x2	; 0230796E
	bl loc_02307824	; 02307970
	add r1,r0,#0x0	; 02307974
	ldr r0,[pool_02307AAC]	; 02307976
	ldrh r3,[r0,#0x0]	; 02307978
	ldr r2,[pool_02307AB0]	; 0230797A
	sub r4,r3,r2	; 0230797C
	ldr r7,[pool_02307A90]	; 0230797E
loc_02307980:
	ldrh r2,[r7,#0x0]	; 02307980
	sub r2,r2,r6	; 02307982
	lsl r2,r2,#0x10	; 02307984
	lsr r2,r2,#0x10	; 02307986
	add r5,r2,#0x0	; 02307988
	ldr r3,[pool_02307AB4]	; 0230798A
	and r5,r3	; 0230798C
	cmp r5,#0x0	; 0230798E
	beq loc_023079A2	; 02307990
	ldr r3,[pool_02307A7C]	; 02307992
	ldr r5,[r3,#0x0]	; 02307994
	ldr r3,[pool_02307AB8]	; 02307996
	ldrh r3,[r5,r3]	; 02307998
	lsr r3,r3,#0x1	; 0230799A
	add r2,r2,r3	; 0230799C
	lsl r2,r2,#0x10	; 0230799E
	lsr r2,r2,#0x10	; 023079A0
loc_023079A2:
	cmp r2,#0xe	; 023079A2
	bhi loc_023079B4	; 023079A4
	ldrh r2,[r0,#0x0]	; 023079A6
	sub r2,r2,r4	; 023079A8
	lsl r2,r2,#0x10	; 023079AA
	lsr r2,r2,#0x10	; 023079AC
	cmp r2,#0x40	; 023079AE
	bls loc_02307980	; 023079B0
	b loc_02307A70	; 023079B2
loc_023079B4:
	add r1,#0x8	; 023079B4
	mov r5,#0x0	; 023079B6
	ldr r7,[pool_02307A7C]	; 023079B8
	b loc_023079D6	; 023079BA
loc_023079BC:
	add r0,r1,#0x0	; 023079BC
	bl loc_02307824	; 023079BE
	add r1,r0,#0x2	; 023079C2
	ldrh r0,[r0,#0x0]	; 023079C4
	ldr r3,[r7,#0x0]	; 023079C6
	lsl r2,r5,#0x1	; 023079C8
	add r3,r3,r2	; 023079CA
	ldr r2,[pool_02307ABC]	; 023079CC
	ldrh r2,[r3,r2]	; 023079CE
	cmp r0,r2	; 023079D0
	bne loc_02307A70	; 023079D2
	add r5,r5,#0x1	; 023079D4
loc_023079D6:
	cmp r5,#0x3	; 023079D6
	bcc loc_023079BC	; 023079D8
	add r1,#0xa	; 023079DA
	add r0,r1,#0x0	; 023079DC
	bl loc_02307824	; 023079DE
	add r2,r0,#0x0	; 023079E2
	ldr r7,[pool_02307A7C]	; 023079E4
	ldr r0,[pool_02307A90]	; 023079E6
loc_023079E8:
	ldrh r1,[r0,#0x0]	; 023079E8
	sub r1,r1,r6	; 023079EA
	lsl r1,r1,#0x10	; 023079EC
	lsr r1,r1,#0x10	; 023079EE
	add r5,r1,#0x0	; 023079F0
	ldr r3,[pool_02307AB4]	; 023079F2
	and r5,r3	; 023079F4
	cmp r5,#0x0	; 023079F6
	beq loc_02307A08	; 023079F8
	ldr r5,[r7,#0x0]	; 023079FA
	ldr r3,[pool_02307AB8]	; 023079FC
	ldrh r3,[r5,r3]	; 023079FE
	lsr r3,r3,#0x1	; 02307A00
	add r1,r1,r3	; 02307A02
	lsl r1,r1,#0x10	; 02307A04
	lsr r1,r1,#0x10	; 02307A06
loc_02307A08:
	cmp r1,#0x14	; 02307A08
	bhi loc_02307A1C	; 02307A0A
	ldr r1,[pool_02307AAC]	; 02307A0C
	ldrh r1,[r1,#0x0]	; 02307A0E
	sub r1,r1,r4	; 02307A10
	lsl r1,r1,#0x10	; 02307A12
	lsr r1,r1,#0x10	; 02307A14
	cmp r1,#0x70	; 02307A16
	bls loc_023079E8	; 02307A18
	b loc_02307A70	; 02307A1A
loc_02307A1C:
	ldr r1,[pool_02307A7C]	; 02307A1C
	ldr r0,[r1,#0x0]	; 02307A1E
	ldrh r3,[r2,#0x0]	; 02307A20
	ldr r2,[pool_02307AC0]	; 02307A22
	ldrh r2,[r0,r2]	; 02307A24
	and r3,r2	; 02307A26
	cmp r3,#0x0	; 02307A28
	bne loc_02307A70	; 02307A2A
	ldr r2,[pool_02307AC4]	; 02307A2C
	ldrh r3,[r2,#0x0]	; 02307A2E
	ldr r2,[pool_02307A84]	; 02307A30
	strh r3,[r0,r2]	; 02307A32
	mov r2,#0x40	; 02307A34
	ldr r0,[pool_02307AC8]	; 02307A36
	strh r2,[r0,#0x0]	; 02307A38
	ldr r1,[r1,#0x0]	; 02307A3A
	ldr r0,[pool_02307ACC]	; 02307A3C
	add r1,r1,r0	; 02307A3E
	ldrh r0,[r1,#0x0]	; 02307A40
	add r0,r0,#0x1	; 02307A42
	strh r0,[r1,#0x0]	; 02307A44
	ldr r1,[pool_02307A8C]	; 02307A46
	mov r0,#0x3	; 02307A48
loc_02307A4A:
	ldrh r2,[r1,#0x0]	; 02307A4A
	and r2,r0	; 02307A4C
	cmp r2,#0x3	; 02307A4E
	beq loc_02307A4A	; 02307A50
	ldr r2,[pool_02307AD0]	; 02307A52
	ldrh r1,[r2,#0x0]	; 02307A54
	mov r0,#0x40	; 02307A56
	orr r1,r0	; 02307A58
	strh r1,[r2,#0x0]	; 02307A5A
	ldrh r1,[r2,#0x0]	; 02307A5C
	bic r1,r0	; 02307A5E
	strh r1,[r2,#0x0]	; 02307A60
	mov r0,#0x8	; 02307A62
	ldr r1,[pool_02307AD4]	; 02307A64
	strh r0,[r1,#0x0]	; 02307A66
	mov r0,#0x0	; 02307A68
	strh r0,[r1,#0x0]	; 02307A6A
	bl loc_023077E0	; 02307A6C
loc_02307A70:
	add sp,#0x4	; 02307A70
	pop {r4,r5,r6,r7}	; 02307A72
	pop {r3}	; 02307A74
	bx r3	; 02307A76
pool_02307A78:
loc_02307A78:
	.word REG_WIFI_IF	; 02307A78
pool_02307A7C:
loc_02307A7C:
	.word FirmwareWlWorkPointerSlot	; 02307A7C
pool_02307A80:
loc_02307A80:
	.word 0x0000061C	; 02307A80
pool_02307A84:
loc_02307A84:
	.word 0x0000048A	; 02307A84
pool_02307A88:
loc_02307A88:
	.word 0x0000FFFF	; 02307A88
pool_02307A8C:
loc_02307A8C:
	.word REG_WIFI_RF_PINS	; 02307A8C
pool_02307A90:
loc_02307A90:
	.word REG_WIFI_RXTX_ADDR	; 02307A90
pool_02307A94:
loc_02307A94:
	.word REG_WIFI_RXBUF_BEGIN	; 02307A94
pool_02307A98:
loc_02307A98:
	.word 0x00000FFF	; 02307A98
pool_02307A9C:
loc_02307A9C:
	.word REG_WIFI_RXBUF_WRCSR	; 02307A9C
pool_02307AA0:
loc_02307AA0:
	.word WifiRamBase	; 02307AA0
pool_02307AA4:
loc_02307AA4:
	.word 0x0000E7FF	; 02307AA4
pool_02307AA8:
loc_02307AA8:
	.word 0x00000228	; 02307AA8
pool_02307AAC:
loc_02307AAC:
	.word REG_WIFI_US_COUNT0	; 02307AAC
pool_02307AB0:
loc_02307AB0:
	.word 0x00010000	; 02307AB0
pool_02307AB4:
loc_02307AB4:
	.word 0x00008000	; 02307AB4
pool_02307AB8:
loc_02307AB8:
	.word 0x00000396	; 02307AB8
pool_02307ABC:
loc_02307ABC:
	.word 0x00000360	; 02307ABC
pool_02307AC0:
loc_02307AC0:
	.word 0x00000486	; 02307AC0
pool_02307AC4:
loc_02307AC4:
	.word REG_WIFI_TXBUF_REPLY2	; 02307AC4
pool_02307AC8:
loc_02307AC8:
	.word REG_WIFI_TXBUF_RESET	; 02307AC8
pool_02307ACC:
loc_02307ACC:
	.word 0x000003BA	; 02307ACC
pool_02307AD0:
loc_02307AD0:
	.word REG_WIFI_UNKNOWN_244	; 02307AD0
pool_02307AD4:
loc_02307AD4:
	.word REG_WIFI_UNKNOWN_228	; 02307AD4

; ===== function loc_02307AD8 =====
loc_02307AD8:
	push {r4,lr}	; 02307AD8
	mov r2,#0x80	; 02307ADA
	ldr r0,[pool_02307B38]	; 02307ADC
	strh r2,[r0,#0x0]	; 02307ADE
	ldr r0,[pool_02307B3C]	; 02307AE0
	ldr r1,[r0,#0x0]	; 02307AE2
	ldr r0,[pool_02307B40]	; 02307AE4
	ldrh r3,[r1,r0]	; 02307AE6
	mov r0,#0x20	; 02307AE8
	and r3,r0	; 02307AEA
	cmp r3,#0x0	; 02307AEC
	beq loc_02307B30	; 02307AEE
	ldr r0,[pool_02307B44]	; 02307AF0
	ldrh r3,[r0,#0x0]	; 02307AF2
	mov r0,#0xff	; 02307AF4
	and r3,r0	; 02307AF6
	lsl r0,r3,#0x10	; 02307AF8
	lsr r3,r0,#0x10	; 02307AFA
	ldr r0,[pool_02307B48]	; 02307AFC
	ldrh r0,[r0,#0x0]	; 02307AFE
	cmp r3,#0x3	; 02307B00
	bcc loc_02307B30	; 02307B02
	cmp r3,#0x5	; 02307B04
	bhi loc_02307B30	; 02307B06
	ldr r3,[pool_02307B4C]	; 02307B08
	ldr r3,[r1,r3]	; 02307B0A
	lsr r3,r3,#0x1	; 02307B0C
	ldr r4,[pool_02307B50]	; 02307B0E
	and r3,r4	; 02307B10
	cmp r0,r3	; 02307B12
	bcc loc_02307B30	; 02307B14
	ldr r3,[pool_02307B54]	; 02307B16
	ldr r1,[r1,r3]	; 02307B18
	lsr r1,r1,#0x1	; 02307B1A
	and r1,r4	; 02307B1C
	cmp r0,r1	; 02307B1E
	bhi loc_02307B30	; 02307B20
	ldr r1,[pool_02307B58]	; 02307B22
	ldrh r0,[r1,#0x0]	; 02307B24
	orr r0,r2	; 02307B26
	strh r0,[r1,#0x0]	; 02307B28
	ldrh r0,[r1,#0x0]	; 02307B2A
	bic r0,r2	; 02307B2C
	strh r0,[r1,#0x0]	; 02307B2E
loc_02307B30:
	pop {r4}	; 02307B30
	pop {r3}	; 02307B32
	bx r3	; 02307B34
	.byte 0xC0, 0x46	; 02307B38
pool_02307B38:
loc_02307B38:
	.word REG_WIFI_IF	; 02307B38
pool_02307B3C:
loc_02307B3C:
	.word FirmwareWlWorkPointerSlot	; 02307B3C
pool_02307B40:
loc_02307B40:
	.word 0x0000061C	; 02307B40
pool_02307B44:
loc_02307B44:
	.word REG_WIFI_RF_STATUS	; 02307B44
pool_02307B48:
loc_02307B48:
	.word REG_WIFI_RXTX_ADDR	; 02307B48
pool_02307B4C:
loc_02307B4C:
	.word 0x0000043C	; 02307B4C
pool_02307B50:
loc_02307B50:
	.word 0x00000FFF	; 02307B50
pool_02307B54:
loc_02307B54:
	.word 0x00000414	; 02307B54
pool_02307B58:
loc_02307B58:
	.word REG_WIFI_UNKNOWN_244	; 02307B58

; ===== function loc_02307B5C =====
loc_02307B5C:
	push {r4,lr}	; 02307B5C
	ldr r1,[pool_02307BE8]	; 02307B5E
	ldr r3,[r1,#0x0]	; 02307B60
	ldr r2,[pool_02307BEC]	; 02307B62
	add r2,r3,r2	; 02307B64
	ldr r4,[pool_02307BF0]	; 02307B66
	ldr r3,[pool_02307BF4]	; 02307B68
	strh r4,[r3,#0x0]	; 02307B6A
	ldrh r3,[r2,#0x3c]	; 02307B6C
	cmp r3,#0x0	; 02307B6E
	beq loc_02307BE0	; 02307B70
	ldr r3,[r1,#0x0]	; 02307B72
	ldr r1,[pool_02307BF8]	; 02307B74
	ldrh r3,[r3,r1]	; 02307B76
	mov r1,#0x10	; 02307B78
	and r3,r1	; 02307B7A
	cmp r3,#0x0	; 02307B7C
	beq loc_02307BD8	; 02307B7E
	cmp r0,#0x0	; 02307B80
	beq loc_02307BD8	; 02307B82
	ldr r0,[pool_02307BFC]	; 02307B84
	ldrh r1,[r0,#0x0]	; 02307B86
	ldr r0,[pool_02307C00]	; 02307B88
	ldrh r0,[r0,#0x0]	; 02307B8A
	cmp r0,#0x3	; 02307B8C
	beq loc_02307B94	; 02307B8E
	cmp r0,#0x5	; 02307B90
	bne loc_02307BD8	; 02307B92
loc_02307B94:
	cmp r1,#0x0	; 02307B94
	bne loc_02307BD8	; 02307B96
	ldr r3,[r2,#0x44]	; 02307B98
	ldrh r4,[r3,#0x2]	; 02307B9A
	mov r0,#0x0	; 02307B9C
	mov r1,#0x1	; 02307B9E
	b loc_02307BAC	; 02307BA0
loc_02307BA2:
	add r2,r4,#0x0	; 02307BA2
	and r2,r1	; 02307BA4
	add r0,r0,r2	; 02307BA6
	lsl r2,r4,#0xf	; 02307BA8
	lsr r4,r2,#0x10	; 02307BAA
loc_02307BAC:
	cmp r4,#0x0	; 02307BAC
	bne loc_02307BA2	; 02307BAE
	ldrh r1,[r3,#0xa]	; 02307BB0
	lsl r2,r1,#0x2	; 02307BB2
	ldrh r1,[r3,#0x24]	; 02307BB4
	add r1,#0xa	; 02307BB6
	mul r0,r1	; 02307BB8
	add r0,#0xc0	; 02307BBA
	add r0,r2,r0	; 02307BBC
	lsl r0,r0,#0x10	; 02307BBE
	lsr r0,r0,#0x10	; 02307BC0
	ldr r1,[pool_02307C04]	; 02307BC2
	bl loc_023055A8	; 02307BC4
	ldr r0,[pool_02307BE8]	; 02307BC8
	ldr r1,[r0,#0x0]	; 02307BCA
	ldr r0,[pool_02307C08]	; 02307BCC
	add r1,r1,r0	; 02307BCE
	ldrh r0,[r1,#0x0]	; 02307BD0
	add r0,r0,#0x1	; 02307BD2
	strh r0,[r1,#0x0]	; 02307BD4
	b loc_02307BE0	; 02307BD6
loc_02307BD8:
	mov r0,#0x0	; 02307BD8
	mov r1,#0x10	; 02307BDA
	bl loc_02304B6C	; 02307BDC
loc_02307BE0:
	pop {r4}	; 02307BE0
	pop {r3}	; 02307BE2
	bx r3	; 02307BE4
	.byte 0xC0, 0x46	; 02307BE8
pool_02307BE8:
loc_02307BE8:
	.word FirmwareWlWorkPointerSlot	; 02307BE8
pool_02307BEC:
loc_02307BEC:
	.word 0x000003E4	; 02307BEC
pool_02307BF0:
loc_02307BF0:
	.word 0x00001000	; 02307BF0
pool_02307BF4:
loc_02307BF4:
	.word REG_WIFI_IF	; 02307BF4
pool_02307BF8:
loc_02307BF8:
	.word 0x0000061C	; 02307BF8
pool_02307BFC:
loc_02307BFC:
	.word REG_WIFI_TXBUSY	; 02307BFC
pool_02307C00:
loc_02307C00:
	.word REG_WIFI_RF_STATUS	; 02307C00
pool_02307C04:
loc_02307C04:
	.word P4_Code_02307844 + 1	; 02307C04
pool_02307C08:
loc_02307C08:
	.word 0x000003B8	; 02307C08

; ===== function loc_02307C0C =====
loc_02307C0C:
	push {r4,r5,r6,r7,lr}	; 02307C0C
	sub sp,#0xc	; 02307C0E
	ldr r1,[pool_02307DB8]	; 02307C10
	mov r0,#0x1	; 02307C12
	strh r0,[r1,#0x0]	; 02307C14
loc_02307C16:
	ldr r0,[pool_02307DBC]	; 02307C16
	ldr r0,[r0,#0x0]	; 02307C18
	ldr r1,[pool_02307DC0]	; 02307C1A
	ldrh r1,[r0,r1]	; 02307C1C
	ldr r2,[pool_02307DC4]	; 02307C1E
	ldrh r2,[r2,#0x0]	; 02307C20
	str r2,[sp,#0x0]	; 02307C22
	cmp r1,r2	; 02307C24
	bne loc_02307C2A	; 02307C26
	b loc_02307D70	; 02307C28
loc_02307C2A:
	ldr r2,[pool_02307DC8]	; 02307C2A
	ldrh r3,[r2,#0x0]	; 02307C2C
	ldr r2,[pool_02307DCC]	; 02307C2E
	ldrh r2,[r2,#0x0]	; 02307C30
	ldr r4,[pool_02307DC8]	; 02307C32
	ldrh r5,[r4,#0x0]	; 02307C34
	ldr r4,[pool_02307DCC]	; 02307C36
	ldrh r4,[r4,#0x0]	; 02307C38
	cmp r3,r5	; 02307C3A
	bls loc_02307C46	; 02307C3C
	lsr r5,r5,#0x4	; 02307C3E
	lsl r2,r4,#0xc	; 02307C40
	orr r5,r2	; 02307C42
	b loc_02307C4C	; 02307C44
loc_02307C46:
	lsr r5,r3,#0x4	; 02307C46
	lsl r2,r2,#0xc	; 02307C48
	orr r5,r2	; 02307C4A
loc_02307C4C:
	lsl r3,r1,#0x1	; 02307C4C
	ldr r2,[pool_02307DD0]	; 02307C4E
	add r3,r3,r2	; 02307C50
	add r4,r3,#0x2	; 02307C52
	ldr r2,[pool_02307DD4]	; 02307C54
	cmp r4,r2	; 02307C56
	bcc loc_02307C60	; 02307C58
	ldr r2,[pool_02307DD8]	; 02307C5A
	ldrh r2,[r0,r2]	; 02307C5C
	sub r4,r4,r2	; 02307C5E
loc_02307C60:
	add r2,r4,#0x2	; 02307C60
	ldr r6,[pool_02307DD4]	; 02307C62
	cmp r2,r6	; 02307C64
	bcc loc_02307C6E	; 02307C66
	ldr r6,[pool_02307DD8]	; 02307C68
	ldrh r6,[r0,r6]	; 02307C6A
	sub r2,r2,r6	; 02307C6C
loc_02307C6E:
	add r7,r2,#0x4	; 02307C6E
	ldr r6,[pool_02307DD4]	; 02307C70
	cmp r7,r6	; 02307C72
	bcc loc_02307C7C	; 02307C74
	ldr r6,[pool_02307DD8]	; 02307C76
	ldrh r0,[r0,r6]	; 02307C78
	sub r7,r7,r0	; 02307C7A
loc_02307C7C:
	ldrh r0,[r3,#0x0]	; 02307C7C
	str r0,[sp,#0x8]	; 02307C7E
	ldrh r0,[r4,#0x0]	; 02307C80
	lsl r0,r0,#0x1	; 02307C82
	str r0,[sp,#0x4]	; 02307C84
	ldr r0,[pool_02307DDC]	; 02307C86
	ldr r6,[sp,#0x4]	; 02307C88
	and r6,r0	; 02307C8A
	str r6,[sp,#0x4]	; 02307C8C
	ldr r0,[sp,#0x8]	; 02307C8E
	orr r0,r6	; 02307C90
	str r0,[sp,#0x8]	; 02307C92
	strh r0,[r3,#0x0]	; 02307C94
	strh r5,[r2,#0x0]	; 02307C96
	ldrh r2,[r7,#0x0]	; 02307C98
	lsl r0,r1,#0x1	; 02307C9A
	add r0,r2,r0	; 02307C9C
	add r0,#0xf	; 02307C9E
	lsr r0,r0,#0x2	; 02307CA0
	lsl r5,r0,#0x1	; 02307CA2
	ldr r0,[pool_02307DE0]	; 02307CA4
	cmp r5,r0	; 02307CA6
	bcc loc_02307CB6	; 02307CA8
	ldr r0,[pool_02307DBC]	; 02307CAA
	ldr r1,[r0,#0x0]	; 02307CAC
	ldr r0,[pool_02307DD8]	; 02307CAE
	ldrh r0,[r1,r0]	; 02307CB0
	lsr r0,r0,#0x1	; 02307CB2
	sub r5,r5,r0	; 02307CB4
loc_02307CB6:
	ldr r0,[pool_02307DE4]	; 02307CB6
	cmp r2,r0	; 02307CB8
	bls loc_02307CD2	; 02307CBA
	ldr r0,[pool_02307DE8]	; 02307CBC
	strh r0,[r3,#0x0]	; 02307CBE
	ldr r5,[sp,#0x0]	; 02307CC0
	ldr r0,[pool_02307DBC]	; 02307CC2
	ldr r1,[r0,#0x0]	; 02307CC4
	ldr r0,[pool_02307DEC]	; 02307CC6
	add r1,r1,r0	; 02307CC8
	ldrh r0,[r1,#0x0]	; 02307CCA
	add r0,r0,#0x1	; 02307CCC
	strh r0,[r1,#0x0]	; 02307CCE
	b loc_02307D40	; 02307CD0
loc_02307CD2:
	ldr r0,[pool_02307DBC]	; 02307CD2
	ldr r1,[r0,#0x0]	; 02307CD4
	ldr r0,[pool_02307DF0]	; 02307CD6
	ldrh r6,[r1,r0]	; 02307CD8
	mov r0,#0x1	; 02307CDA
	and r6,r0	; 02307CDC
	cmp r6,#0x0	; 02307CDE
	beq loc_02307D40	; 02307CE0
	ldr r0,[sp,#0x0]	; 02307CE2
	cmp r5,r0	; 02307CE4
	beq loc_02307D40	; 02307CE6
	lsl r6,r5,#0x1	; 02307CE8
	ldr r0,[pool_02307DD0]	; 02307CEA
	add r0,r6,r0	; 02307CEC
	ldrh r7,[r0,#0x0]	; 02307CEE
	ldr r6,[pool_02307DF4]	; 02307CF0
	cmp r0,r6	; 02307CF2
	bcs loc_02307D02	; 02307CF4
	ldrh r6,[r0,#0x6]	; 02307CF6
	mov r0,#0xff	; 02307CF8
	and r6,r0	; 02307CFA
	lsl r0,r6,#0x10	; 02307CFC
	lsr r6,r0,#0x10	; 02307CFE
	b loc_02307D0A	; 02307D00
loc_02307D02:
	ldr r6,[pool_02307DD8]	; 02307D02
	ldrh r6,[r1,r6]	; 02307D04
	sub r0,r0,r6	; 02307D06
	ldrh r6,[r0,#0x6]	; 02307D08
loc_02307D0A:
	ldr r0,[pool_02307DF8]	; 02307D0A
	and r7,r0	; 02307D0C
	cmp r7,#0x0	; 02307D0E
	bne loc_02307D20	; 02307D10
	cmp r6,#0xa	; 02307D12
	beq loc_02307D1A	; 02307D14
	cmp r6,#0x14	; 02307D16
	bne loc_02307D20	; 02307D18
loc_02307D1A:
	ldr r0,[pool_02307DFC]	; 02307D1A
	cmp r2,r0	; 02307D1C
	bls loc_02307D40	; 02307D1E
loc_02307D20:
	ldr r0,[pool_02307DEC]	; 02307D20
	add r1,r1,r0	; 02307D22
	ldrh r0,[r1,#0x0]	; 02307D24
	add r0,r0,#0x1	; 02307D26
	strh r0,[r1,#0x0]	; 02307D28
	ldr r0,[pool_02307DE8]	; 02307D2A
	strh r0,[r3,#0x0]	; 02307D2C
	ldr r0,[sp,#0x0]	; 02307D2E
	lsl r0,r0,#0x10	; 02307D30
	lsr r2,r0,#0x10	; 02307D32
	ldr r0,[pool_02307DBC]	; 02307D34
	ldr r1,[r0,#0x0]	; 02307D36
	ldr r0,[pool_02307DC0]	; 02307D38
	strh r2,[r1,r0]	; 02307D3A
	strh r2,[r4,#0x0]	; 02307D3C
	b loc_02307D70	; 02307D3E
loc_02307D40:
	ldrh r1,[r3,#0x0]	; 02307D40
	mov r0,#0xf	; 02307D42
	and r1,r0	; 02307D44
	cmp r1,#0xc	; 02307D46
	bne loc_02307D60	; 02307D48
	bl loc_02307754	; 02307D4A
	cmp r0,#0x0	; 02307D4E
	bne loc_02307D60	; 02307D50
	ldr r0,[pool_02307DBC]	; 02307D52
	ldr r1,[r0,#0x0]	; 02307D54
	ldr r0,[pool_02307E00]	; 02307D56
	add r1,r1,r0	; 02307D58
	ldr r0,[r1,#0x0]	; 02307D5A
	add r0,r0,#0x1	; 02307D5C
	str r0,[r1,#0x0]	; 02307D5E
loc_02307D60:
	lsl r0,r5,#0x10	; 02307D60
	lsr r2,r0,#0x10	; 02307D62
	ldr r0,[pool_02307DBC]	; 02307D64
	ldr r1,[r0,#0x0]	; 02307D66
	ldr r0,[pool_02307DC0]	; 02307D68
	strh r2,[r1,r0]	; 02307D6A
	strh r2,[r4,#0x0]	; 02307D6C
	b loc_02307C16	; 02307D6E
loc_02307D70:
	ldr r0,[pool_02307DBC]	; 02307D70
	ldr r1,[r0,#0x0]	; 02307D72
	ldr r0,[pool_02307DF0]	; 02307D74
	ldrh r1,[r1,r0]	; 02307D76
	mov r0,#0x1	; 02307D78
	and r1,r0	; 02307D7A
	cmp r1,#0x0	; 02307D7C
	beq loc_02307D9A	; 02307D7E
	ldr r0,[pool_02307DC4]	; 02307D80
	ldrh r4,[r0,#0x0]	; 02307D82
	bl loc_02307754	; 02307D84
	cmp r0,#0x0	; 02307D88
	beq loc_02307D9A	; 02307D8A
	ldr r0,[pool_02307DC4]	; 02307D8C
	ldrh r0,[r0,#0x0]	; 02307D8E
	cmp r4,r0	; 02307D90
	bne loc_02307D9A	; 02307D92
	mov r0,#0x20	; 02307D94
	bl loc_02305134	; 02307D96
loc_02307D9A:
	ldr r0,[pool_02307E04]	; 02307D9A
	ldrh r1,[r0,#0x0]	; 02307D9C
	ldr r0,[pool_02307DC4]	; 02307D9E
	ldrh r0,[r0,#0x0]	; 02307DA0
	cmp r1,r0	; 02307DA2
	beq loc_02307DAE	; 02307DA4
	mov r0,#0x0	; 02307DA6
	mov r1,#0xf	; 02307DA8
	bl loc_02304B6C	; 02307DAA
loc_02307DAE:
	add sp,#0xc	; 02307DAE
	pop {r4,r5,r6,r7}	; 02307DB0
	pop {r3}	; 02307DB2
	bx r3	; 02307DB4
	.byte 0xC0, 0x46	; 02307DB8
pool_02307DB8:
loc_02307DB8:
	.word REG_WIFI_IF	; 02307DB8
pool_02307DBC:
loc_02307DBC:
	.word FirmwareWlWorkPointerSlot	; 02307DBC
pool_02307DC0:
loc_02307DC0:
	.word 0x0000049C	; 02307DC0
pool_02307DC4:
loc_02307DC4:
	.word REG_WIFI_RXBUF_WRCSR	; 02307DC4
pool_02307DC8:
loc_02307DC8:
	.word REG_WIFI_US_COUNT0	; 02307DC8
pool_02307DCC:
loc_02307DCC:
	.word REG_WIFI_US_COUNT1	; 02307DCC
pool_02307DD0:
loc_02307DD0:
	.word WifiRamBase	; 02307DD0
pool_02307DD4:
loc_02307DD4:
	.word 0x04805F60	; 02307DD4
pool_02307DD8:
loc_02307DD8:
	.word 0x00000396	; 02307DD8
pool_02307DDC:
loc_02307DDC:
	.word 0x00000400	; 02307DDC
pool_02307DE0:
loc_02307DE0:
	.word 0x00000FB0	; 02307DE0
pool_02307DE4:
loc_02307DE4:
	.word 0x0000092C	; 02307DE4
pool_02307DE8:
loc_02307DE8:
	.word 0x0000FFFF	; 02307DE8
pool_02307DEC:
loc_02307DEC:
	.word 0x000003B0	; 02307DEC
pool_02307DF0:
loc_02307DF0:
	.word 0x0000061C	; 02307DF0
pool_02307DF4:
loc_02307DF4:
	.word 0x04805F5A	; 02307DF4
pool_02307DF8:
loc_02307DF8:
	.word 0x00007C00	; 02307DF8
pool_02307DFC:
loc_02307DFC:
	.word 0x00000FFF	; 02307DFC
pool_02307E00:
loc_02307E00:
	.word 0x00000560	; 02307E00
pool_02307E04:
loc_02307E04:
	.word REG_WIFI_RXBUF_READCSR	; 02307E04

; ===== function loc_02307E08 =====
loc_02307E08:
	push {r4,r5,r6,r7,lr}	; 02307E08
	sub sp,#0x4	; 02307E0A
	ldr r2,[pool_02307F80]	; 02307E0C
	ldr r1,[r2,#0x0]	; 02307E0E
	ldr r0,[pool_02307F84]	; 02307E10
	add r5,r1,r0	; 02307E12
	mov r1,#0x2	; 02307E14
	ldr r0,[pool_02307F88]	; 02307E16
	strh r1,[r0,#0x0]	; 02307E18
	ldr r0,[r2,#0x0]	; 02307E1A
	ldr r2,[pool_02307F8C]	; 02307E1C
	ldrh r2,[r0,r2]	; 02307E1E
	cmp r2,#0x12	; 02307E20
	bne loc_02307E2A	; 02307E22
	bl loc_0230ACB4	; 02307E24
	b loc_02307F78	; 02307E28
loc_02307E2A:
	ldr r2,[pool_02307F90]	; 02307E2A
	ldrh r4,[r2,#0x0]	; 02307E2C
	ldr r2,[pool_02307F94]	; 02307E2E
	and r4,r2	; 02307E30
	ldr r2,[pool_02307F98]	; 02307E32
	cmp r4,r2	; 02307E34
	beq loc_02307E46	; 02307E36
	ldr r2,[pool_02307F9C]	; 02307E38
	cmp r4,r2	; 02307E3A
	beq loc_02307E6C	; 02307E3C
	ldr r1,[pool_02307FA0]	; 02307E3E
	cmp r4,r1	; 02307E40
	beq loc_02307E9E	; 02307E42
	b loc_02307F16	; 02307E44
loc_02307E46:
	add r5,#0x8c	; 02307E46
	ldr r0,[r5,#0x0]	; 02307E48
	and r0,r1	; 02307E4A
	cmp r0,#0x0	; 02307E4C
	beq loc_02307E54	; 02307E4E
	bl loc_02307890	; 02307E50
loc_02307E54:
	ldr r0,[pool_02307F80]	; 02307E54
	ldr r1,[r0,#0x0]	; 02307E56
	ldr r0,[pool_02307FA4]	; 02307E58
	add r1,r1,r0	; 02307E5A
	ldr r0,[r1,#0x0]	; 02307E5C
	add r0,r0,#0x1	; 02307E5E
	str r0,[r1,#0x0]	; 02307E60
	mov r0,#0x0	; 02307E62
	mov r1,#0x8	; 02307E64
	bl loc_02304B6C	; 02307E66
	b loc_02307F16	; 02307E6A
loc_02307E6C:
	add r0,r5,#0x0	; 02307E6C
	add r0,#0x9e	; 02307E6E
	ldrh r0,[r0,#0x0]	; 02307E70
	ldr r2,[r5,#0x44]	; 02307E72
	ldrh r3,[r2,#0x4]	; 02307E74
	mov r2,#0xff	; 02307E76
	and r3,r2	; 02307E78
	lsl r2,r3,#0x10	; 02307E7A
	lsr r2,r2,#0x10	; 02307E7C
	cmp r0,r2	; 02307E7E
	bhi loc_02307E90	; 02307E80
	ldr r0,[pool_02307FA8]	; 02307E82
	strh r1,[r0,#0x0]	; 02307E84
	add r1,r5,#0x0	; 02307E86
	add r1,#0xaa	; 02307E88
	ldrh r0,[r1,#0x0]	; 02307E8A
	add r0,r0,#0x1	; 02307E8C
	strh r0,[r1,#0x0]	; 02307E8E
loc_02307E90:
	add r5,#0x90	; 02307E90
	ldr r1,[r5,#0x0]	; 02307E92
	add r1,#0x18	; 02307E94
	ldrh r0,[r1,#0x0]	; 02307E96
	add r0,r0,#0x1	; 02307E98
	strh r0,[r1,#0x0]	; 02307E9A
	b loc_02307F16	; 02307E9C
loc_02307E9E:
	add r1,r5,#0x0	; 02307E9E
	add r1,#0x98	; 02307EA0
	ldrh r3,[r1,#0x0]	; 02307EA2
	ldr r1,[r5,#0x44]	; 02307EA4
	ldrh r2,[r1,#0x2]	; 02307EA6
	add r1,r5,#0x0	; 02307EA8
	add r1,#0x90	; 02307EAA
	ldr r1,[r1,#0x0]	; 02307EAC
	add r1,#0x1a	; 02307EAE
	cmp r2,#0x1	; 02307EB0
	bls loc_02307ED4	; 02307EB2
	ldr r6,[pool_02307FAC]	; 02307EB4
	ldrh r0,[r0,r6]	; 02307EB6
	lsl r0,r0,#0x1b	; 02307EB8
	lsr r0,r0,#0x1f	; 02307EBA
	cmp r0,#0x0	; 02307EBC
	beq loc_02307ED4	; 02307EBE
	ldr r0,[pool_02307FB0]	; 02307EC0
	ldrh r0,[r0,#0x0]	; 02307EC2
	mov r7,#0x1	; 02307EC4
	and r0,r7	; 02307EC6
	cmp r0,#0x0	; 02307EC8
	bne loc_02307ED4	; 02307ECA
	ldr r6,[pool_02307FB4]	; 02307ECC
	ldrh r0,[r6,#0x0]	; 02307ECE
	eor r0,r7	; 02307ED0
	strh r0,[r6,#0x0]	; 02307ED2
loc_02307ED4:
	ldr r0,[pool_02307F80]	; 02307ED4
	ldr r6,[r0,#0x0]	; 02307ED6
	ldr r0,[pool_02307FB8]	; 02307ED8
	ldrh r6,[r6,r0]	; 02307EDA
	mov r0,#0x40	; 02307EDC
	and r6,r0	; 02307EDE
	cmp r6,#0x0	; 02307EE0
	beq loc_02307F16	; 02307EE2
	mov r7,#0x1	; 02307EE4
	b loc_02307F12	; 02307EE6
loc_02307EE8:
	lsl r0,r2,#0xf	; 02307EE8
	lsr r2,r0,#0x10	; 02307EEA
	add r0,r2,#0x0	; 02307EEC
	and r0,r7	; 02307EEE
	cmp r0,#0x0	; 02307EF0
	beq loc_02307EFC	; 02307EF2
	add r0,r1,#0x6	; 02307EF4
	ldrh r6,[r0,#0x0]	; 02307EF6
	add r6,r6,#0x1	; 02307EF8
	strh r6,[r0,#0x0]	; 02307EFA
loc_02307EFC:
	lsl r0,r3,#0xf	; 02307EFC
	lsr r3,r0,#0x10	; 02307EFE
	add r0,r3,#0x0	; 02307F00
	and r0,r7	; 02307F02
	cmp r0,#0x0	; 02307F04
	beq loc_02307F12	; 02307F06
	add r0,r5,#0x0	; 02307F08
	add r0,#0x90	; 02307F0A
	ldr r0,[r0,#0x0]	; 02307F0C
	ldrh r0,[r0,#0x16]	; 02307F0E
	add r1,r1,r0	; 02307F10
loc_02307F12:
	cmp r2,#0x1	; 02307F12
	bhi loc_02307EE8	; 02307F14
loc_02307F16:
	ldr r0,[pool_02307F9C]	; 02307F16
	cmp r4,r0	; 02307F18
	beq loc_02307F70	; 02307F1A
	ldr r0,[pool_02307FBC]	; 02307F1C
	ldrh r1,[r0,#0x0]	; 02307F1E
	mov r0,#0x2	; 02307F20
	and r1,r0	; 02307F22
	cmp r1,#0x0	; 02307F24
	bne loc_02307F70	; 02307F26
	ldr r1,[pool_02307F80]	; 02307F28
	ldr r3,[r1,#0x0]	; 02307F2A
	ldr r2,[pool_02307FC0]	; 02307F2C
	ldrh r2,[r3,r2]	; 02307F2E
	cmp r2,#0x0	; 02307F30
	beq loc_02307F6A	; 02307F32
	ldr r2,[pool_02307FC4]	; 02307F34
	strh r0,[r2,#0x0]	; 02307F36
	mov r3,#0x0	; 02307F38
	ldr r2,[pool_02307FC8]	; 02307F3A
	strh r3,[r2,#0x0]	; 02307F3C
	ldr r2,[pool_02307F88]	; 02307F3E
	ldrh r3,[r2,#0x0]	; 02307F40
	ldr r2,[pool_02307FCC]	; 02307F42
	and r3,r2	; 02307F44
	cmp r3,#0x0	; 02307F46
	bne loc_02307F50	; 02307F48
	bl loc_02307B5C	; 02307F4A
	b loc_02307F5C	; 02307F4E
loc_02307F50:
	ldr r1,[r1,#0x0]	; 02307F50
	ldr r0,[pool_02307FD0]	; 02307F52
	add r1,r1,r0	; 02307F54
	ldrh r0,[r1,#0x0]	; 02307F56
	add r0,r0,#0x1	; 02307F58
	strh r0,[r1,#0x0]	; 02307F5A
loc_02307F5C:
	ldr r0,[pool_02307F80]	; 02307F5C
	ldr r1,[r0,#0x0]	; 02307F5E
	ldr r0,[pool_02307FD4]	; 02307F60
	add r1,r1,r0	; 02307F62
	ldrh r0,[r1,#0x0]	; 02307F64
	add r0,r0,#0x1	; 02307F66
	strh r0,[r1,#0x0]	; 02307F68
loc_02307F6A:
	mov r1,#0x2	; 02307F6A
	ldr r0,[pool_02307FD8]	; 02307F6C
	strh r1,[r0,#0x0]	; 02307F6E
loc_02307F70:
	mov r0,#0x0	; 02307F70
	mov r1,#0xe	; 02307F72
	bl loc_02304B6C	; 02307F74
loc_02307F78:
	add sp,#0x4	; 02307F78
	pop {r4,r5,r6,r7}	; 02307F7A
	pop {r3}	; 02307F7C
	bx r3	; 02307F7E
pool_02307F80:
loc_02307F80:
	.word FirmwareWlWorkPointerSlot	; 02307F80
pool_02307F84:
loc_02307F84:
	.word 0x000003E4	; 02307F84
pool_02307F88:
loc_02307F88:
	.word REG_WIFI_IF	; 02307F88
pool_02307F8C:
loc_02307F8C:
	.word 0x00000310	; 02307F8C
pool_02307F90:
loc_02307F90:
	.word REG_WIFI_TXSTAT	; 02307F90
pool_02307F94:
loc_02307F94:
	.word 0x00000F00	; 02307F94
pool_02307F98:
loc_02307F98:
	.word 0x00000300	; 02307F98
pool_02307F9C:
loc_02307F9C:
	.word 0x00000800	; 02307F9C
pool_02307FA0:
loc_02307FA0:
	.word 0x00000B00	; 02307FA0
pool_02307FA4:
loc_02307FA4:
	.word 0x00000510	; 02307FA4
pool_02307FA8:
loc_02307FA8:
	.word REG_WIFI_TXREQ_RESET	; 02307FA8
pool_02307FAC:
loc_02307FAC:
	.word 0x000002FE	; 02307FAC
pool_02307FB0:
loc_02307FB0:
	.word REG_WIFI_RF_PINS	; 02307FB0
pool_02307FB4:
loc_02307FB4:
	.word REG_WIFI_UNKNOWN_290	; 02307FB4
pool_02307FB8:
loc_02307FB8:
	.word 0x0000061C	; 02307FB8
pool_02307FBC:
loc_02307FBC:
	.word REG_WIFI_TXREQ_READ	; 02307FBC
pool_02307FC0:
loc_02307FC0:
	.word 0x00000420	; 02307FC0
pool_02307FC4:
loc_02307FC4:
	.word REG_WIFI_TXBUF_RESET	; 02307FC4
pool_02307FC8:
loc_02307FC8:
	.word REG_WIFI_UNKNOWN_048	; 02307FC8
pool_02307FCC:
loc_02307FCC:
	.word 0x00001000	; 02307FCC
pool_02307FD0:
loc_02307FD0:
	.word 0x00000492	; 02307FD0
pool_02307FD4:
loc_02307FD4:
	.word 0x00000490	; 02307FD4
pool_02307FD8:
loc_02307FD8:
	.word REG_WIFI_TXREQ_SET	; 02307FD8

; ===== function loc_02307FDC =====
loc_02307FDC:
	push {r4,r5,lr}	; 02307FDC
	sub sp,#0x4	; 02307FDE
	mov r1,#0x4	; 02307FE0
	ldr r0,[pool_023080EC]	; 02307FE2
	strh r1,[r0,#0x0]	; 02307FE4
	ldr r0,[pool_023080F0]	; 02307FE6
	ldrh r3,[r0,#0x0]	; 02307FE8
	ldr r0,[pool_023080F4]	; 02307FEA
	ldr r0,[r0,#0x0]	; 02307FEC
	ldr r1,[pool_023080F8]	; 02307FEE
	ldrh r2,[r0,r1]	; 02307FF0
	mov r1,#0x8	; 02307FF2
	and r2,r1	; 02307FF4
	cmp r2,#0x0	; 02307FF6
	beq loc_02308084	; 02307FF8
	ldr r1,[pool_023080FC]	; 02307FFA
	add r2,r3,#0x0	; 02307FFC
	and r2,r1	; 02307FFE
	cmp r2,#0x0	; 02308000
	beq loc_02308084	; 02308002
	ldr r1,[pool_02308100]	; 02308004
	add r2,r0,r1	; 02308006
	ldr r1,[pool_02308104]	; 02308008
	ldrh r1,[r1,#0x0]	; 0230800A
	mov r4,#0x1	; 0230800C
	add r5,r1,#0x0	; 0230800E
	and r5,r4	; 02308010
	cmp r5,#0x0	; 02308012
	beq loc_0230801C	; 02308014
	ldrh r4,[r2,#0x0]	; 02308016
	cmp r4,#0x0	; 02308018
	bne loc_0230805A	; 0230801A
loc_0230801C:
	mov r4,#0x4	; 0230801C
	add r5,r1,#0x0	; 0230801E
	and r5,r4	; 02308020
	cmp r5,#0x0	; 02308022
	beq loc_0230802C	; 02308024
	ldrh r4,[r2,#0x14]	; 02308026
	cmp r4,#0x0	; 02308028
	bne loc_0230805A	; 0230802A
loc_0230802C:
	mov r4,#0x8	; 0230802C
	and r1,r4	; 0230802E
	cmp r1,#0x0	; 02308030
	beq loc_0230803A	; 02308032
	ldrh r1,[r2,#0x28]	; 02308034
	cmp r1,#0x0	; 02308036
	bne loc_0230805A	; 02308038
loc_0230803A:
	ldr r1,[pool_02308108]	; 0230803A
	ldrh r2,[r1,#0x0]	; 0230803C
	mov r1,#0x1	; 0230803E
	and r2,r1	; 02308040
	cmp r2,#0x0	; 02308042
	bne loc_0230805A	; 02308044
	mov r2,#0x0	; 02308046
	ldr r1,[pool_0230810C]	; 02308048
	strh r2,[r1,#0x0]	; 0230804A
	ldr r0,[pool_02308110]	; 0230804C
	strh r0,[r1,#0x0]	; 0230804E
	ldr r0,[pool_023080F4]	; 02308050
	ldr r1,[r0,#0x0]	; 02308052
	ldr r0,[pool_02308114]	; 02308054
	strh r2,[r1,r0]	; 02308056
	b loc_02308084	; 02308058
loc_0230805A:
	ldr r1,[pool_02308114]	; 0230805A
	add r2,r0,r1	; 0230805C
	ldrh r4,[r2,#0x0]	; 0230805E
	add r0,r4,#0x1	; 02308060
	strh r0,[r2,#0x0]	; 02308062
	cmp r4,#0xc	; 02308064
	bls loc_02308084	; 02308066
	mov r4,#0x0	; 02308068
	ldr r2,[pool_023080F4]	; 0230806A
	ldr r0,[r2,#0x0]	; 0230806C
	strh r4,[r0,r1]	; 0230806E
	ldr r1,[pool_0230810C]	; 02308070
	strh r4,[r1,#0x0]	; 02308072
	ldr r0,[pool_02308110]	; 02308074
	strh r0,[r1,#0x0]	; 02308076
	ldr r1,[r2,#0x0]	; 02308078
	ldr r0,[pool_02308118]	; 0230807A
	add r1,r1,r0	; 0230807C
	ldrh r0,[r1,#0x0]	; 0230807E
	add r0,r0,#0x1	; 02308080
	strh r0,[r1,#0x0]	; 02308082
loc_02308084:
	ldr r0,[pool_023080F4]	; 02308084
	ldr r1,[r0,#0x0]	; 02308086
	ldr r0,[pool_023080F8]	; 02308088
	ldrh r1,[r1,r0]	; 0230808A
	mov r0,#0x1	; 0230808C
	and r1,r0	; 0230808E
	cmp r1,#0x0	; 02308090
	beq loc_023080E4	; 02308092
	mov r0,#0x60	; 02308094
	and r3,r0	; 02308096
	cmp r3,#0x0	; 02308098
	beq loc_023080E4	; 0230809A
	ldr r0,[pool_0230811C]	; 0230809C
	ldrh r4,[r0,#0x0]	; 0230809E
	ldr r0,[pool_02308120]	; 023080A0
	ldrh r1,[r0,#0x0]	; 023080A2
	ldr r0,[pool_02308124]	; 023080A4
	sub r0,r1,r0	; 023080A6
	mov r1,#0x2	; 023080A8
	bl loc_02308140	; 023080AA
	cmp r4,r0	; 023080AE
	bge loc_023080C4	; 023080B0
	ldr r0,[pool_02308128]	; 023080B2
	ldrh r1,[r0,#0x0]	; 023080B4
	ldr r0,[pool_02308124]	; 023080B6
	sub r0,r1,r0	; 023080B8
	mov r1,#0x2	; 023080BA
	bl loc_0230814C	; 023080BC
	cmp r4,r0	; 023080C0
	bge loc_023080E0	; 023080C2
loc_023080C4:
	ldr r0,[pool_0230812C]	; 023080C4
	ldrh r1,[r0,#0x0]	; 023080C6
	ldr r0,[pool_02308130]	; 023080C8
	strh r1,[r0,#0x0]	; 023080CA
	ldr r1,[pool_02308134]	; 023080CC
	ldr r0,[pool_02308138]	; 023080CE
	strh r1,[r0,#0x0]	; 023080D0
	ldr r0,[pool_023080F4]	; 023080D2
	ldr r1,[r0,#0x0]	; 023080D4
	ldr r0,[pool_0230813C]	; 023080D6
	add r1,r1,r0	; 023080D8
	ldrh r0,[r1,#0x0]	; 023080DA
	add r0,r0,#0x1	; 023080DC
	strh r0,[r1,#0x0]	; 023080DE
loc_023080E0:
	bl loc_0230516C	; 023080E0
loc_023080E4:
	add sp,#0x4	; 023080E4
	pop {r4,r5}	; 023080E6
	pop {r3}	; 023080E8
	bx r3	; 023080EA
pool_023080EC:
loc_023080EC:
	.word REG_WIFI_IF	; 023080EC
pool_023080F0:
loc_023080F0:
	.word REG_WIFI_RXSTAT_INC_IF	; 023080F0
pool_023080F4:
loc_023080F4:
	.word FirmwareWlWorkPointerSlot	; 023080F4
pool_023080F8:
loc_023080F8:
	.word 0x0000061C	; 023080F8
pool_023080FC:
loc_023080FC:
	.word 0x00000400	; 023080FC
pool_02308100:
loc_02308100:
	.word 0x000003E4	; 02308100
pool_02308104:
loc_02308104:
	.word REG_WIFI_TXREQ_READ	; 02308104
pool_02308108:
loc_02308108:
	.word REG_WIFI_RF_PINS	; 02308108
pool_0230810C:
loc_0230810C:
	.word REG_WIFI_WEP_CNT	; 0230810C
pool_02308110:
loc_02308110:
	.word 0x00008000	; 02308110
pool_02308114:
loc_02308114:
	.word 0x0000049A	; 02308114
pool_02308118:
loc_02308118:
	.word 0x000003B6	; 02308118
pool_0230811C:
loc_0230811C:
	.word REG_WIFI_RXBUF_WRCSR	; 0230811C
pool_02308120:
loc_02308120:
	.word REG_WIFI_RXBUF_END	; 02308120
pool_02308124:
loc_02308124:
	.word 0x00004000	; 02308124
pool_02308128:
loc_02308128:
	.word REG_WIFI_RXBUF_BEGIN	; 02308128
pool_0230812C:
loc_0230812C:
	.word REG_WIFI_RXBUF_READCSR	; 0230812C
pool_02308130:
loc_02308130:
	.word REG_WIFI_RXBUF_WR_ADDR	; 02308130
pool_02308134:
loc_02308134:
	.word 0x00008001	; 02308134
pool_02308138:
loc_02308138:
	.word REG_WIFI_RXCNT	; 02308138
pool_0230813C:
loc_0230813C:
	.word 0x00000496	; 0230813C

; ===== function loc_02308140 =====
loc_02308140:
	bx pc	; 02308140
	.byte 0xC0, 0x46	; 02308144
.arm

; ===== function loc_02308144 =====
loc_02308144:
	ldr pc,[pool_02308148]	; 02308144
pool_02308148:
loc_02308148:
	.word loc_03802514	; 02308148
.thumb

; ===== function loc_0230814C =====
loc_0230814C:
	bx pc	; 0230814C
	.byte 0xC0, 0x46	; 02308150
.arm

; ===== function loc_02308150 =====
loc_02308150:
	ldr pc,[pool_02308154]	; 02308150
pool_02308154:
loc_02308154:
	.word loc_03802514	; 02308154
.thumb

; ===== function loc_02308158 =====
loc_02308158:
	push {r4,r5,r6,r7,lr}	; 02308158
	sub sp,#0x4	; 0230815A
	mov r1,#0x8	; 0230815C
	ldr r0,[pool_02308208]	; 0230815E
	strh r1,[r0,#0x0]	; 02308160
	ldr r0,[pool_0230820C]	; 02308162
	ldr r1,[r0,#0x0]	; 02308164
	ldr r0,[pool_02308210]	; 02308166
	ldrh r0,[r1,r0]	; 02308168
	lsl r0,r0,#0x1b	; 0230816A
	lsr r0,r0,#0x1f	; 0230816C
	cmp r0,#0x0	; 0230816E
	beq loc_02308186	; 02308170
	ldr r0,[pool_02308214]	; 02308172
	ldrh r1,[r0,#0x0]	; 02308174
	mov r0,#0x1	; 02308176
	and r1,r0	; 02308178
	cmp r1,#0x0	; 0230817A
	bne loc_02308186	; 0230817C
	ldr r2,[pool_02308218]	; 0230817E
	ldrh r1,[r2,#0x0]	; 02308180
	eor r1,r0	; 02308182
	strh r1,[r2,#0x0]	; 02308184
loc_02308186:
	ldr r5,[pool_0230820C]	; 02308186
	ldr r1,[r5,#0x0]	; 02308188
	ldr r0,[pool_0230821C]	; 0230818A
	ldrh r1,[r1,r0]	; 0230818C
	mov r0,#0x8	; 0230818E
	and r1,r0	; 02308190
	cmp r1,#0x0	; 02308192
	beq loc_023081FE	; 02308194
	mov r6,#0x0	; 02308196
	add r2,r6,#0x0	; 02308198
	ldr r1,[pool_02308220]	; 0230819A
	ldr r0,[pool_02308224]	; 0230819C
loc_0230819E:
	ldr r7,[r5,#0x0]	; 0230819E
	add r4,r6,#0x0	; 023081A0
	mov r3,#0x14	; 023081A2
	mul r4,r3	; 023081A4
	add r3,r7,r4	; 023081A6
	ldr r4,[pool_02308228]	; 023081A8
	ldrh r4,[r3,r4]	; 023081AA
	cmp r4,#0x0	; 023081AC
	beq loc_023081F8	; 023081AE
	ldr r4,[pool_0230822C]	; 023081B0
	ldr r4,[r3,r4]	; 023081B2
	ldrh r7,[r4,#0xc]	; 023081B4
	ldr r3,[pool_02308230]	; 023081B6
	and r7,r3	; 023081B8
	cmp r7,#0x0	; 023081BA
	beq loc_023081F8	; 023081BC
	ldrh r7,[r4,#0x4]	; 023081BE
	mov r3,#0xff	; 023081C0
	and r7,r3	; 023081C2
	lsl r3,r7,#0x10	; 023081C4
	lsr r3,r3,#0x10	; 023081C6
	cmp r3,#0x0	; 023081C8
	beq loc_023081F8	; 023081CA
	add r7,r4,#0x0	; 023081CC
	add r7,#0xc	; 023081CE
	ldrh r3,[r4,#0xa]	; 023081D0
	add r3,r7,r3	; 023081D2
	sub r3,r3,#0x7	; 023081D4
	mov r7,#0x1	; 023081D6
	bic r3,r7	; 023081D8
	ldrh r7,[r3,#0x0]	; 023081DA
	cmp r7,#0x0	; 023081DC
	bne loc_023081F8	; 023081DE
	ldrh r3,[r3,#0x2]	; 023081E0
	cmp r3,#0x0	; 023081E2
	bne loc_023081F8	; 023081E4
	strh r2,[r4,#0x4]	; 023081E6
	strh r2,[r1,#0x0]	; 023081E8
	strh r0,[r1,#0x0]	; 023081EA
	ldr r4,[r5,#0x0]	; 023081EC
	ldr r3,[pool_02308234]	; 023081EE
	add r4,r4,r3	; 023081F0
	ldrh r3,[r4,#0x0]	; 023081F2
	add r3,r3,#0x1	; 023081F4
	strh r3,[r4,#0x0]	; 023081F6
loc_023081F8:
	add r6,r6,#0x1	; 023081F8
	cmp r6,#0x3	; 023081FA
	bcc loc_0230819E	; 023081FC
loc_023081FE:
	add sp,#0x4	; 023081FE
	pop {r4,r5,r6,r7}	; 02308200
	pop {r3}	; 02308202
	bx r3	; 02308204
	.byte 0xC0, 0x46	; 02308208
pool_02308208:
loc_02308208:
	.word REG_WIFI_IF	; 02308208
pool_0230820C:
loc_0230820C:
	.word FirmwareWlWorkPointerSlot	; 0230820C
pool_02308210:
loc_02308210:
	.word 0x000002FE	; 02308210
pool_02308214:
loc_02308214:
	.word REG_WIFI_RF_PINS	; 02308214
pool_02308218:
loc_02308218:
	.word REG_WIFI_UNKNOWN_290	; 02308218
pool_0230821C:
loc_0230821C:
	.word 0x0000061C	; 0230821C
pool_02308220:
loc_02308220:
	.word REG_WIFI_WEP_CNT	; 02308220
pool_02308224:
loc_02308224:
	.word 0x00008000	; 02308224
pool_02308228:
loc_02308228:
	.word 0x000003E4	; 02308228
pool_0230822C:
loc_0230822C:
	.word 0x000003EC	; 0230822C
pool_02308230:
loc_02308230:
	.word 0x00004000	; 02308230
pool_02308234:
loc_02308234:
	.word 0x000003B6	; 02308234

; ===== function loc_02308238 =====
loc_02308238:
	push {lr}	; 02308238
	sub sp,#0x4	; 0230823A
	bl loc_02306170	; 0230823C
	ldr r1,[pool_02308254]	; 02308240
	ldr r0,[pool_02308258]	; 02308242
	strh r1,[r0,#0x0]	; 02308244
	mov r1,#0x10	; 02308246
	ldr r0,[pool_0230825C]	; 02308248
	strh r1,[r0,#0x0]	; 0230824A
	add sp,#0x4	; 0230824C
	pop {r3}	; 0230824E
	bx r3	; 02308250
	.byte 0xC0, 0x46	; 02308254
pool_02308254:
loc_02308254:
	.word 0x0000FFFF	; 02308254
pool_02308258:
loc_02308258:
	.word REG_WIFI_RXSTAT_OVF_IF	; 02308258
pool_0230825C:
loc_0230825C:
	.word REG_WIFI_IF	; 0230825C

; ===== function loc_02308260 =====
loc_02308260:
	push {lr}	; 02308260
	sub sp,#0x4	; 02308262
	bl loc_02306170	; 02308264
	ldr r1,[pool_0230827C]	; 02308268
	ldr r0,[pool_02308280]	; 0230826A
	strh r1,[r0,#0x0]	; 0230826C
	mov r1,#0x20	; 0230826E
	ldr r0,[pool_02308284]	; 02308270
	strh r1,[r0,#0x0]	; 02308272
	add sp,#0x4	; 02308274
	pop {r3}	; 02308276
	bx r3	; 02308278
	.byte 0xC0, 0x46	; 0230827C
pool_0230827C:
loc_0230827C:
	.word 0x0000FFFF	; 0230827C
pool_02308280:
loc_02308280:
	.word REG_WIFI_RXSTAT_OVF_IF	; 02308280
pool_02308284:
loc_02308284:
	.word REG_WIFI_IF	; 02308284

; ===== function loc_02308288 =====
loc_02308288:
	ldr r1,[pool_02308290]	; 02308288
	ldr r0,[pool_02308294]	; 0230828A
	strh r1,[r0,#0x0]	; 0230828C
	bx lr	; 0230828E
pool_02308290:
loc_02308290:
	.word 0x00000800	; 02308290
pool_02308294:
loc_02308294:
	.word REG_WIFI_IF	; 02308294

; ===== function loc_02308298 =====
loc_02308298:
	ldr r1,[pool_023082D8]	; 02308298
	ldr r0,[pool_023082DC]	; 0230829A
	strh r1,[r0,#0x0]	; 0230829C
	mov r1,#0xd	; 0230829E
	ldr r0,[pool_023082E0]	; 023082A0
	strh r1,[r0,#0x0]	; 023082A2
	ldr r0,[pool_023082E4]	; 023082A4
	ldr r0,[r0,#0x0]	; 023082A6
	ldr r1,[pool_023082E8]	; 023082A8
	add r1,r0,r1	; 023082AA
	ldrh r2,[r1,#0x0]	; 023082AC
	lsl r3,r2,#0x19	; 023082AE
	lsr r3,r3,#0x1f	; 023082B0
	cmp r3,#0x0	; 023082B2
	beq loc_023082BE	; 023082B4
	mov r0,#0x40	; 023082B6
	bic r2,r0	; 023082B8
	strh r2,[r1,#0x0]	; 023082BA
	bx lr	; 023082BC
loc_023082BE:
	ldr r1,[pool_023082EC]	; 023082BE
	ldrh r1,[r0,r1]	; 023082C0
	cmp r1,#0x2	; 023082C2
	bne loc_023082D4	; 023082C4
	ldr r1,[pool_023082F0]	; 023082C6
	ldrh r0,[r0,r1]	; 023082C8
	cmp r0,#0x40	; 023082CA
	beq loc_023082D4	; 023082CC
	mov r1,#0x0	; 023082CE
	ldr r0,[pool_023082F4]	; 023082D0
	strh r1,[r0,#0x0]	; 023082D2
loc_023082D4:
	bx lr	; 023082D4
	.byte 0xC0, 0x46	; 023082D8
pool_023082D8:
loc_023082D8:
	.word 0x00002000	; 023082D8
pool_023082DC:
loc_023082DC:
	.word REG_WIFI_IF	; 023082DC
pool_023082E0:
loc_023082E0:
	.word REG_WIFI_TXREQ_RESET	; 023082E0
pool_023082E4:
loc_023082E4:
	.word FirmwareWlWorkPointerSlot	; 023082E4
pool_023082E8:
loc_023082E8:
	.word 0x00000316	; 023082E8
pool_023082EC:
loc_023082EC:
	.word 0x00000314	; 023082EC
pool_023082F0:
loc_023082F0:
	.word 0x00000310	; 023082F0
pool_023082F4:
loc_023082F4:
	.word REG_WIFI_UNKNOWN_048	; 023082F4

; ===== function loc_023082F8 =====
loc_023082F8:
	push {r4,r5,r6,r7,lr}	; 023082F8
	sub sp,#0x4	; 023082FA
	ldr r0,[pool_023084E8]	; 023082FC
	ldr r2,[r0,#0x0]	; 023082FE
	ldr r1,[pool_023084EC]	; 02308300
	add r5,r2,r1	; 02308302
	ldr r1,[pool_023084F0]	; 02308304
	add r7,r2,r1	; 02308306
	ldr r2,[pool_023084F4]	; 02308308
	ldr r1,[pool_023084F8]	; 0230830A
	strh r2,[r1,#0x0]	; 0230830C
	ldrh r1,[r5,#0xc]	; 0230830E
	cmp r1,#0x1	; 02308310
	beq loc_0230831E	; 02308312
	cmp r1,#0x2	; 02308314
	beq loc_023083B6	; 02308316
	cmp r1,#0x3	; 02308318
	beq loc_023083D8	; 0230831A
	b loc_023084DE	; 0230831C
loc_0230831E:
	ldr r1,[r0,#0x0]	; 0230831E
	ldr r0,[pool_023084FC]	; 02308320
	ldr r1,[r1,r0]	; 02308322
	add r1,#0x24	; 02308324
	add r0,r5,#0x0	; 02308326
	add r0,#0x8a	; 02308328
	ldrh r0,[r0,#0x0]	; 0230832A
	add r4,r1,r0	; 0230832C
	add r4,#0x8	; 0230832E
	ldr r0,[pool_02308500]	; 02308330
	ldrh r6,[r0,#0x0]	; 02308332
	add r0,r4,#0x0	; 02308334
	lsl r1,r6,#0x18	; 02308336
	lsr r1,r1,#0x18	; 02308338
	bl loc_023053DC	; 0230833A
	add r0,r4,#0x1	; 0230833E
	lsr r1,r6,#0x8	; 02308340
	lsl r1,r1,#0x18	; 02308342
	lsr r1,r1,#0x18	; 02308344
	bl loc_023053DC	; 02308346
	ldrh r0,[r5,#0xe]	; 0230834A
	lsl r0,r0,#0x1f	; 0230834C
	lsr r0,r0,#0x1f	; 0230834E
	cmp r0,#0x1	; 02308350
	bne loc_02308366	; 02308352
	ldr r0,[pool_023084E8]	; 02308354
	ldr r1,[r0,#0x0]	; 02308356
	ldr r0,[pool_02308504]	; 02308358
	ldrh r2,[r1,r0]	; 0230835A
	ldr r1,[pool_02308508]	; 0230835C
	ldrh r0,[r1,#0x0]	; 0230835E
	add r0,r2,r0	; 02308360
	add r0,r0,#0x1	; 02308362
	strh r0,[r1,#0x0]	; 02308364
loc_02308366:
	ldr r1,[pool_023084E8]	; 02308366
	ldr r0,[r1,#0x0]	; 02308368
	ldr r2,[pool_0230850C]	; 0230836A
	ldrh r2,[r0,r2]	; 0230836C
	mvn r3,r2	; 0230836E
	ldr r2,[pool_02308510]	; 02308370
	ldrh r2,[r0,r2]	; 02308372
	orr r3,r2	; 02308374
	ldr r2,[pool_02308514]	; 02308376
	strh r3,[r0,r2]	; 02308378
	ldr r0,[pool_02308518]	; 0230837A
	ldrh r3,[r0,#0x0]	; 0230837C
	mov r0,#0x18	; 0230837E
	add r2,r3,#0x0	; 02308380
	and r2,r0	; 02308382
	cmp r2,#0x0	; 02308384
	bne loc_02308390	; 02308386
	mov r0,#0x6	; 02308388
	and r3,r0	; 0230838A
	cmp r3,#0x2	; 0230838C
	bne loc_023083A6	; 0230838E
loc_02308390:
	ldr r0,[pool_023084E8]	; 02308390
	ldr r1,[r0,#0x0]	; 02308392
	ldr r0,[pool_0230851C]	; 02308394
	add r2,r1,r0	; 02308396
	ldr r1,[r2,#0x0]	; 02308398
	mov r0,#0x2	; 0230839A
	bic r1,r0	; 0230839C
	str r1,[r2,#0x0]	; 0230839E
	bl loc_02307890	; 023083A0
	b loc_023084DE	; 023083A4
loc_023083A6:
	ldr r1,[r1,#0x0]	; 023083A6
	ldr r0,[pool_0230851C]	; 023083A8
	add r2,r1,r0	; 023083AA
	ldr r1,[r2,#0x0]	; 023083AC
	mov r0,#0x2	; 023083AE
	orr r1,r0	; 023083B0
	str r1,[r2,#0x0]	; 023083B2
	b loc_023084DE	; 023083B4
loc_023083B6:
	ldrh r1,[r5,#0xe]	; 023083B6
	lsl r1,r1,#0x1d	; 023083B8
	lsr r1,r1,#0x1f	; 023083BA
	cmp r1,#0x0	; 023083BC
	beq loc_023083D2	; 023083BE
	ldr r1,[r0,#0x0]	; 023083C0
	ldr r0,[pool_02308504]	; 023083C2
	ldrh r2,[r1,r0]	; 023083C4
	ldr r1,[pool_02308508]	; 023083C6
	ldrh r0,[r1,#0x0]	; 023083C8
	add r0,r2,r0	; 023083CA
	add r0,r0,#0x1	; 023083CC
	strh r0,[r1,#0x0]	; 023083CE
	b loc_023083D8	; 023083D0
loc_023083D2:
	ldr r1,[pool_02308520]	; 023083D2
	ldr r0,[pool_02308508]	; 023083D4
	strh r1,[r0,#0x0]	; 023083D6
loc_023083D8:
	ldrh r0,[r5,#0x8]	; 023083D8
	cmp r0,#0x40	; 023083DA
	beq loc_023083E2	; 023083DC
	mov r0,#0x1	; 023083DE
	b loc_02308414	; 023083E0
loc_023083E2:
	mov r0,#0x0	; 023083E2
	add r1,r5,#0x0	; 023083E4
	add r1,#0x66	; 023083E6
	ldrh r1,[r1,#0x0]	; 023083E8
	cmp r1,#0x1	; 023083EA
	bne loc_023083F0	; 023083EC
	mov r0,#0x1	; 023083EE
loc_023083F0:
	ldrh r1,[r5,#0xe]	; 023083F0
	lsl r1,r1,#0x1c	; 023083F2
	lsr r1,r1,#0x1f	; 023083F4
	cmp r1,#0x0	; 023083F6
	beq loc_02308414	; 023083F8
	add r1,r5,#0x0	; 023083FA
	add r1,#0x6a	; 023083FC
	ldrh r1,[r1,#0x0]	; 023083FE
	cmp r1,#0x1	; 02308400
	beq loc_02308412	; 02308402
	cmp r1,#0x0	; 02308404
	bne loc_02308414	; 02308406
	add r1,r5,#0x0	; 02308408
	add r1,#0x68	; 0230840A
	ldrh r1,[r1,#0x0]	; 0230840C
	cmp r1,#0x1	; 0230840E
	bne loc_02308414	; 02308410
loc_02308412:
	mov r0,#0x1	; 02308412
loc_02308414:
	cmp r0,#0x0	; 02308414
	beq loc_02308424	; 02308416
	ldr r2,[pool_02308524]	; 02308418
	ldrh r1,[r2,#0x0]	; 0230841A
	mov r0,#0x1	; 0230841C
	orr r1,r0	; 0230841E
	strh r1,[r2,#0x0]	; 02308420
	b loc_0230842E	; 02308422
loc_02308424:
	ldr r2,[pool_02308524]	; 02308424
	ldrh r1,[r2,#0x0]	; 02308426
	mov r0,#0x1	; 02308428
	bic r1,r0	; 0230842A
	strh r1,[r2,#0x0]	; 0230842C
loc_0230842E:
	ldr r0,[pool_02308528]	; 0230842E
	ldrh r0,[r0,#0x0]	; 02308430
	cmp r0,#0xa	; 02308432
	bls loc_0230843C	; 02308434
	mov r1,#0x0	; 02308436
	ldr r0,[pool_0230852C]	; 02308438
	strh r1,[r0,#0x0]	; 0230843A
loc_0230843C:
	add r1,r5,#0x0	; 0230843C
	add r1,#0x66	; 0230843E
	ldrh r0,[r1,#0x0]	; 02308440
	sub r0,r0,#0x1	; 02308442
	strh r0,[r1,#0x0]	; 02308444
	add r0,r5,#0x0	; 02308446
	add r0,#0x66	; 02308448
	ldrh r0,[r0,#0x0]	; 0230844A
	cmp r0,#0x0	; 0230844C
	bne loc_0230845C	; 0230844E
	add r0,r5,#0x0	; 02308450
	add r0,#0x64	; 02308452
	ldrh r1,[r0,#0x0]	; 02308454
	add r0,r5,#0x0	; 02308456
	add r0,#0x66	; 02308458
	strh r1,[r0,#0x0]	; 0230845A
loc_0230845C:
	add r0,r5,#0x0	; 0230845C
	add r0,#0x6a	; 0230845E
	ldrh r2,[r0,#0x0]	; 02308460
	add r1,r5,#0x0	; 02308462
	add r1,#0x6a	; 02308464
	ldrh r0,[r1,#0x0]	; 02308466
	sub r0,r0,#0x1	; 02308468
	strh r0,[r1,#0x0]	; 0230846A
	cmp r2,#0x0	; 0230846C
	bne loc_0230847E	; 0230846E
	add r0,r5,#0x0	; 02308470
	add r0,#0x68	; 02308472
	ldrh r0,[r0,#0x0]	; 02308474
	sub r1,r0,#0x1	; 02308476
	add r0,r5,#0x0	; 02308478
	add r0,#0x6a	; 0230847A
	strh r1,[r0,#0x0]	; 0230847C
loc_0230847E:
	mov r4,#0x0	; 0230847E
	str r4,[sp,#0x0]	; 02308480
loc_02308482:
	add r1,r4,#0x0	; 02308482
	mov r0,#0x14	; 02308484
	mul r1,r0	; 02308486
	add r6,r7,r1	; 02308488
	ldrh r0,[r7,r1]	; 0230848A
	cmp r0,#0x0	; 0230848C
	beq loc_023084D2	; 0230848E
	ldr r0,[r6,#0xc]	; 02308490
	ldrh r1,[r0,#0x8]	; 02308492
	cmp r1,#0x0	; 02308494
	bne loc_023084D2	; 02308496
	add r1,r5,#0x0	; 02308498
	add r1,#0x9c	; 0230849A
	ldr r1,[r1,#0x0]	; 0230849C
	ldrh r0,[r0,#0x4]	; 0230849E
	sub r0,r1,r0	; 023084A0
	lsl r0,r0,#0x10	; 023084A2
	lsr r1,r0,#0x10	; 023084A4
	add r0,r5,#0x0	; 023084A6
	add r0,#0x80	; 023084A8
	ldrh r0,[r0,#0x0]	; 023084AA
	cmp r1,r0	; 023084AC
	bls loc_023084D2	; 023084AE
	add r0,r4,#0x0	; 023084B0
	bl loc_0230CD38	; 023084B2
	ldr r1,[r6,#0x8]	; 023084B6
	mov r0,#0x2	; 023084B8
	strh r0,[r1,#0x0]	; 023084BA
	ldr r0,[sp,#0x0]	; 023084BC
	mov r1,#0xe	; 023084BE
	bl loc_02304B6C	; 023084C0
	ldr r0,[pool_023084E8]	; 023084C4
	ldr r1,[r0,#0x0]	; 023084C6
	ldr r0,[pool_02308530]	; 023084C8
	add r1,r1,r0	; 023084CA
	ldrh r0,[r1,#0x0]	; 023084CC
	add r0,r0,#0x1	; 023084CE
	strh r0,[r1,#0x0]	; 023084D0
loc_023084D2:
	add r4,r4,#0x1	; 023084D2
	cmp r4,#0x2	; 023084D4
	bcc loc_02308482	; 023084D6
	mov r1,#0xd	; 023084D8
	ldr r0,[pool_02308534]	; 023084DA
	strh r1,[r0,#0x0]	; 023084DC
loc_023084DE:
	add sp,#0x4	; 023084DE
	pop {r4,r5,r6,r7}	; 023084E0
	pop {r3}	; 023084E2
	bx r3	; 023084E4
	.byte 0xC0, 0x46	; 023084E8
pool_023084E8:
loc_023084E8:
	.word FirmwareWlWorkPointerSlot	; 023084E8
pool_023084EC:
loc_023084EC:
	.word 0x00000308	; 023084EC
pool_023084F0:
loc_023084F0:
	.word 0x000003E4	; 023084F0
pool_023084F4:
loc_023084F4:
	.word 0x00004000	; 023084F4
pool_023084F8:
loc_023084F8:
	.word REG_WIFI_IF	; 023084F8
pool_023084FC:
loc_023084FC:
	.word 0x00000464	; 023084FC
pool_02308500:
loc_02308500:
	.word FirmwareWlAdjustedTimeSlot	; 02308500
pool_02308504:
loc_02308504:
	.word 0x00000300	; 02308504
pool_02308508:
loc_02308508:
	.word REG_WIFI_POST_BEACON	; 02308508
pool_0230850C:
loc_0230850C:
	.word 0x000004EA	; 0230850C
pool_02308510:
loc_02308510:
	.word 0x000004EE	; 02308510
pool_02308514:
loc_02308514:
	.word 0x000004EC	; 02308514
pool_02308518:
loc_02308518:
	.word REG_WIFI_TXBUSY	; 02308518
pool_0230851C:
loc_0230851C:
	.word 0x00000470	; 0230851C
pool_02308520:
loc_02308520:
	.word 0x0000FFFF	; 02308520
pool_02308524:
loc_02308524:
	.word REG_WIFI_POWER_TX	; 02308524
pool_02308528:
loc_02308528:
	.word REG_WIFI_CMD_COUNT	; 02308528
pool_0230852C:
loc_0230852C:
	.word REG_WIFI_UNKNOWN_048	; 0230852C
pool_02308530:
loc_02308530:
	.word 0x00000494	; 02308530
pool_02308534:
loc_02308534:
	.word REG_WIFI_TXREQ_SET	; 02308534

; ===== function loc_02308538 =====
loc_02308538:
	push {lr}	; 02308538
	sub sp,#0x4	; 0230853A
	ldr r0,[pool_023085A8]	; 0230853C
	ldr r1,[r0,#0x0]	; 0230853E
	ldr r0,[pool_023085AC]	; 02308540
	add r0,r1,r0	; 02308542
	ldr r2,[pool_023085B0]	; 02308544
	ldr r1,[pool_023085B4]	; 02308546
	strh r2,[r1,#0x0]	; 02308548
	ldrh r1,[r0,#0x8]	; 0230854A
	cmp r1,#0x40	; 0230854C
	bne loc_02308592	; 0230854E
	add r1,r0,#0x0	; 02308550
	add r1,#0x72	; 02308552
	ldrh r1,[r1,#0x0]	; 02308554
	cmp r1,#0x0	; 02308556
	beq loc_02308592	; 02308558
	add r1,r0,#0x0	; 0230855A
	add r1,#0x66	; 0230855C
	ldrh r2,[r1,#0x0]	; 0230855E
	add r1,r0,#0x0	; 02308560
	add r1,#0x64	; 02308562
	ldrh r1,[r1,#0x0]	; 02308564
	cmp r2,r1	; 02308566
	bne loc_02308592	; 02308568
	add r2,r0,#0x0	; 0230856A
	add r2,#0x74	; 0230856C
	ldrh r1,[r2,#0x0]	; 0230856E
	add r1,r1,#0x1	; 02308570
	strh r1,[r2,#0x0]	; 02308572
	add r1,r0,#0x0	; 02308574
	add r1,#0x74	; 02308576
	ldrh r2,[r1,#0x0]	; 02308578
	add r1,r0,#0x0	; 0230857A
	add r1,#0x72	; 0230857C
	ldrh r1,[r1,#0x0]	; 0230857E
	cmp r2,r1	; 02308580
	bls loc_02308592	; 02308582
	mov r1,#0x0	; 02308584
	add r0,#0x74	; 02308586
	strh r1,[r0,#0x0]	; 02308588
	mov r0,#0x1	; 0230858A
	mov r1,#0xd	; 0230858C
	bl loc_02304B6C	; 0230858E
loc_02308592:
	ldr r0,[pool_023085A8]	; 02308592
	ldr r1,[r0,#0x0]	; 02308594
	ldr r0,[pool_023085B8]	; 02308596
	add r2,r1,r0	; 02308598
	ldrh r1,[r2,#0x0]	; 0230859A
	mov r0,#0x2	; 0230859C
	orr r1,r0	; 0230859E
	strh r1,[r2,#0x0]	; 023085A0
	add sp,#0x4	; 023085A2
	pop {r3}	; 023085A4
	bx r3	; 023085A6
pool_023085A8:
loc_023085A8:
	.word FirmwareWlWorkPointerSlot	; 023085A8
pool_023085AC:
loc_023085AC:
	.word 0x00000308	; 023085AC
pool_023085B0:
loc_023085B0:
	.word 0x00008000	; 023085B0
pool_023085B4:
loc_023085B4:
	.word REG_WIFI_IF	; 023085B4
pool_023085B8:
loc_023085B8:
	.word 0x00000316	; 023085B8

; ===== function loc_023085BC =====
P4_IrqHandler_023085BC:
	push {r4,r5,r6,r7,lr}	; 023085BC
	sub sp,#0x4	; 023085BE
	mov r7,#0x1	; 023085C0
	ldr r4,[pool_02308698]	; 023085C2
	ldr r6,[pool_0230869C]	; 023085C4
loc_023085C6:
	ldrh r5,[r4,#0x0]	; 023085C6
	ldrh r0,[r6,#0x0]	; 023085C8
	and r5,r0	; 023085CA
	cmp r5,#0x0	; 023085CC
	beq loc_02308686	; 023085CE
	add r1,r5,#0x0	; 023085D0
	mov r0,#0x80	; 023085D2
	and r1,r0	; 023085D4
	cmp r1,#0x0	; 023085D6
	beq loc_023085DE	; 023085D8
	bl loc_02307AD8	; 023085DA
loc_023085DE:
	add r1,r5,#0x0	; 023085DE
	mov r0,#0x40	; 023085E0
	and r1,r0	; 023085E2
	cmp r1,#0x0	; 023085E4
	beq loc_023085EC	; 023085E6
	bl loc_02307900	; 023085E8
loc_023085EC:
	add r1,r5,#0x0	; 023085EC
	ldr r0,[pool_023086A0]	; 023085EE
	and r1,r0	; 023085F0
	cmp r1,#0x0	; 023085F2
	beq loc_023085FA	; 023085F4
	bl loc_02308538	; 023085F6
loc_023085FA:
	add r1,r5,#0x0	; 023085FA
	ldr r0,[pool_023086A4]	; 023085FC
	and r1,r0	; 023085FE
	cmp r1,#0x0	; 02308600
	beq loc_02308608	; 02308602
	bl loc_023082F8	; 02308604
loc_02308608:
	add r1,r5,#0x0	; 02308608
	ldr r0,[pool_023086A8]	; 0230860A
	and r1,r0	; 0230860C
	cmp r1,#0x0	; 0230860E
	beq loc_02308616	; 02308610
	bl loc_02308298	; 02308612
loc_02308616:
	add r1,r5,#0x0	; 02308616
	mov r0,#0x20	; 02308618
	and r1,r0	; 0230861A
	cmp r1,#0x0	; 0230861C
	beq loc_02308624	; 0230861E
	bl loc_02308260	; 02308620
loc_02308624:
	add r1,r5,#0x0	; 02308624
	ldr r0,[pool_023086AC]	; 02308626
	and r1,r0	; 02308628
	cmp r1,#0x0	; 0230862A
	beq loc_02308632	; 0230862C
	bl loc_02308288	; 0230862E
loc_02308632:
	add r1,r5,#0x0	; 02308632
	mov r0,#0x8	; 02308634
	and r1,r0	; 02308636
	cmp r1,#0x0	; 02308638
	beq loc_02308640	; 0230863A
	bl loc_02308158	; 0230863C
loc_02308640:
	add r1,r5,#0x0	; 02308640
	mov r0,#0x4	; 02308642
	and r1,r0	; 02308644
	cmp r1,#0x0	; 02308646
	beq loc_0230864E	; 02308648
	bl loc_02307FDC	; 0230864A
loc_0230864E:
	add r0,r5,#0x0	; 0230864E
	and r0,r7	; 02308650
	cmp r0,#0x0	; 02308652
	beq loc_0230865A	; 02308654
	bl loc_02307C0C	; 02308656
loc_0230865A:
	add r1,r5,#0x0	; 0230865A
	mov r0,#0x10	; 0230865C
	and r1,r0	; 0230865E
	cmp r1,#0x0	; 02308660
	beq loc_02308668	; 02308662
	bl loc_02308238	; 02308664
loc_02308668:
	add r1,r5,#0x0	; 02308668
	mov r0,#0x2	; 0230866A
	and r1,r0	; 0230866C
	cmp r1,#0x0	; 0230866E
	beq loc_02308676	; 02308670
	bl loc_02307E08	; 02308672
loc_02308676:
	ldr r0,[pool_023086B0]	; 02308676
	and r5,r0	; 02308678
	cmp r5,#0x0	; 0230867A
	beq loc_023085C6	; 0230867C
	add r0,r7,#0x0	; 0230867E
	bl loc_02307B5C	; 02308680
	b loc_023085C6	; 02308684
loc_02308686:
	ldr r2,[pool_023086B4]	; 02308686
	ldr r1,[r2,#0x0]	; 02308688
	ldr r0,[pool_023086B8]	; 0230868A
	orr r1,r0	; 0230868C
	str r1,[r2,#0x0]	; 0230868E
	add sp,#0x4	; 02308690
	pop {r4,r5,r6,r7}	; 02308692
	pop {r3}	; 02308694
	bx r3	; 02308696
pool_02308698:
loc_02308698:
	.word REG_WIFI_IF	; 02308698
pool_0230869C:
loc_0230869C:
	.word REG_WIFI_IE	; 0230869C
pool_023086A0:
loc_023086A0:
	.word 0x00008000	; 023086A0
pool_023086A4:
loc_023086A4:
	.word 0x00004000	; 023086A4
pool_023086A8:
loc_023086A8:
	.word 0x00002000	; 023086A8
pool_023086AC:
loc_023086AC:
	.word 0x00000800	; 023086AC
pool_023086B0:
loc_023086B0:
	.word 0x00001000	; 023086B0
pool_023086B4:
loc_023086B4:
	.word Bios7IrqFlagsAddress	; 023086B4
pool_023086B8:
loc_023086B8:
	.word 0x01000000	; 023086B8

; ===== function loc_023086BC =====
loc_023086BC:
	push {r4,r5,r6,lr}	; 023086BC
	add r6,r0,#0x0	; 023086BE
	add r5,r1,#0x0	; 023086C0
	ldr r0,[pool_0230870C]	; 023086C2
	ldr r1,[r0,#0x0]	; 023086C4
	ldr r0,[pool_02308710]	; 023086C6
	add r0,r1,r0	; 023086C8
	add r1,r5,#0x0	; 023086CA
	add r1,#0x22	; 023086CC
	bl loc_02305054	; 023086CE
	cmp r0,#0x0	; 023086D2
	bne loc_023086DA	; 023086D4
	mov r0,#0x0	; 023086D6
	b loc_02308704	; 023086D8
loc_023086DA:
	add r4,r0,#0x0	; 023086DA
	add r4,#0x10	; 023086DC
	add r0,r4,#0x0	; 023086DE
	add r0,#0x8	; 023086E0
	add r1,r6,#0x0	; 023086E2
	add r2,r5,#0x0	; 023086E4
	add r2,#0xc	; 023086E6
	bl loc_023054EC	; 023086E8
	sub r5,#0x18	; 023086EC
	strh r5,[r4,#0x6]	; 023086EE
	ldrh r2,[r4,#0xe]	; 023086F0
	mov r0,#0xff	; 023086F2
	and r2,r0	; 023086F4
	ldrh r1,[r4,#0x12]	; 023086F6
	and r1,r0	; 023086F8
	lsl r0,r1,#0x10	; 023086FA
	lsr r0,r0,#0x8	; 023086FC
	orr r2,r0	; 023086FE
	strh r2,[r4,#0xe]	; 02308700
	add r0,r4,#0x0	; 02308702
loc_02308704:
	pop {r4,r5,r6}	; 02308704
	pop {r3}	; 02308706
	bx r3	; 02308708
	.byte 0xC0, 0x46	; 0230870C
pool_0230870C:
loc_0230870C:
	.word FirmwareWlWorkPointerSlot	; 0230870C
pool_02308710:
loc_02308710:
	.word 0x0000014C	; 02308710

; ===== function loc_02308714 =====
	push {lr}	; 02308714
	sub sp,#0x4	; 02308716
	ldr r0,[pool_02308790]	; 02308718
	ldrh r0,[r0,#0x0]	; 0230871A
	cmp r0,#0x0	; 0230871C
	bne loc_02308738	; 0230871E
	ldr r0,[pool_02308794]	; 02308720
	ldr r1,[r0,#0x0]	; 02308722
	ldr r0,[pool_02308798]	; 02308724
	ldrh r0,[r1,r0]	; 02308726
	cmp r0,#0x0	; 02308728
	beq loc_02308738	; 0230872A
	mov r1,#0x8	; 0230872C
	ldr r0,[pool_0230879C]	; 0230872E
	strh r1,[r0,#0x0]	; 02308730
	bl loc_0230D5C8	; 02308732
	b loc_02308788	; 02308736
loc_02308738:
	ldr r0,[pool_02308794]	; 02308738
	ldr r3,[r0,#0x0]	; 0230873A
	ldr r1,[pool_023087A0]	; 0230873C
	ldrh r2,[r3,r1]	; 0230873E
	ldr r1,[pool_023087A4]	; 02308740
	ldrh r1,[r3,r1]	; 02308742
	bic r2,r1	; 02308744
	cmp r2,#0x0	; 02308746
	bne loc_0230875E	; 02308748
	mov r2,#0x8	; 0230874A
	ldr r1,[pool_0230879C]	; 0230874C
	strh r2,[r1,#0x0]	; 0230874E
	ldr r1,[r0,#0x0]	; 02308750
	ldr r0,[pool_02308798]	; 02308752
	ldrh r0,[r1,r0]	; 02308754
	cmp r0,#0x0	; 02308756
	beq loc_0230875E	; 02308758
	bl loc_0230D5C8	; 0230875A
loc_0230875E:
	mov r1,#0x5	; 0230875E
	ldr r0,[pool_0230879C]	; 02308760
	strh r1,[r0,#0x0]	; 02308762
	ldr r0,[pool_02308794]	; 02308764
	ldr r1,[r0,#0x0]	; 02308766
	ldr r0,[pool_023087A8]	; 02308768
	ldrh r0,[r1,r0]	; 0230876A
	cmp r0,#0x0	; 0230876C
	beq loc_02308776	; 0230876E
	mov r0,#0x1	; 02308770
	bl loc_0230D674	; 02308772
loc_02308776:
	ldr r0,[pool_02308794]	; 02308776
	ldr r1,[r0,#0x0]	; 02308778
	ldr r0,[pool_023087AC]	; 0230877A
	ldrh r0,[r1,r0]	; 0230877C
	cmp r0,#0x0	; 0230877E
	beq loc_02308788	; 02308780
	mov r0,#0x0	; 02308782
	bl loc_0230D674	; 02308784
loc_02308788:
	add sp,#0x4	; 02308788
	pop {r3}	; 0230878A
	bx r3	; 0230878C
	.byte 0xC0, 0x46	; 02308790
pool_02308790:
loc_02308790:
	.word REG_WIFI_LISTENCOUNT	; 02308790
pool_02308794:
loc_02308794:
	.word FirmwareWlWorkPointerSlot	; 02308794
pool_02308798:
loc_02308798:
	.word 0x00000178	; 02308798
pool_0230879C:
loc_0230879C:
	.word REG_WIFI_TXREQ_SET	; 0230879C
pool_023087A0:
loc_023087A0:
	.word 0x000004EA	; 023087A0
pool_023087A4:
loc_023087A4:
	.word 0x000004EE	; 023087A4
pool_023087A8:
loc_023087A8:
	.word 0x0000016C	; 023087A8
pool_023087AC:
loc_023087AC:
	.word 0x00000160	; 023087AC

; ===== function loc_023087B0 =====
loc_023087B0:
	push {r4,lr}	; 023087B0
	ldr r0,[pool_02308850]	; 023087B2
	ldr r1,[r0,#0x0]	; 023087B4
	ldr r0,[pool_02308854]	; 023087B6
	add r4,r1,r0	; 023087B8
	add r0,r4,#0x0	; 023087BA
	add r0,#0x90	; 023087BC
	ldr r0,[r0,#0x0]	; 023087BE
	ldrh r1,[r0,#0x10]	; 023087C0
	ldr r0,[r4,#0x44]	; 023087C2
	ldrh r0,[r0,#0x2]	; 023087C4
	cmp r1,r0	; 023087C6
	beq loc_023087CE	; 023087C8
	bl loc_02308864	; 023087CA
loc_023087CE:
	ldr r0,[r4,#0x44]	; 023087CE
	ldrh r1,[r0,#0x4]	; 023087D0
	mov r0,#0xff	; 023087D2
	and r1,r0	; 023087D4
	lsl r0,r1,#0x10	; 023087D6
	lsr r2,r0,#0x10	; 023087D8
	cmp r2,#0x0	; 023087DA
	beq loc_023087EE	; 023087DC
	ldr r0,[pool_02308850]	; 023087DE
	ldr r1,[r0,#0x0]	; 023087E0
	ldr r0,[pool_02308858]	; 023087E2
	add r1,r1,r0	; 023087E4
	ldr r0,[r1,#0x0]	; 023087E6
	add r0,r0,r2	; 023087E8
	str r0,[r1,#0x0]	; 023087EA
	b loc_023087FC	; 023087EC
loc_023087EE:
	ldr r0,[pool_02308850]	; 023087EE
	ldr r1,[r0,#0x0]	; 023087F0
	ldr r0,[pool_02308858]	; 023087F2
	add r1,r1,r0	; 023087F4
	ldr r0,[r1,#0x0]	; 023087F6
	add r0,r0,#0x1	; 023087F8
	str r0,[r1,#0x0]	; 023087FA
loc_023087FC:
	add r1,r4,#0x0	; 023087FC
	add r1,#0x40	; 023087FE
	ldrh r0,[r1,#0x0]	; 02308800
	add r0,r0,#0x1	; 02308802
	strh r0,[r1,#0x0]	; 02308804
	add r0,r4,#0x0	; 02308806
	add r0,#0x90	; 02308808
	ldr r2,[r0,#0x0]	; 0230880A
	ldrh r1,[r2,#0x10]	; 0230880C
	ldr r0,[r4,#0x44]	; 0230880E
	ldrh r0,[r0,#0x2]	; 02308810
	eor r1,r0	; 02308812
	strh r1,[r2,#0x12]	; 02308814
	add r0,r4,#0x0	; 02308816
	add r0,#0x90	; 02308818
	ldr r0,[r0,#0x0]	; 0230881A
	ldrh r1,[r0,#0x10]	; 0230881C
	add r0,r4,#0x0	; 0230881E
	add r0,#0xa0	; 02308820
	strh r1,[r0,#0x0]	; 02308822
	mov r0,#0x0	; 02308824
	strh r0,[r4,#0x3c]	; 02308826
	ldr r0,[pool_02308850]	; 02308828
	ldr r1,[r0,#0x0]	; 0230882A
	ldr r0,[pool_0230885C]	; 0230882C
	ldrh r0,[r1,r0]	; 0230882E
	cmp r0,#0x0	; 02308830
	beq loc_02308838	; 02308832
	bl loc_02306698	; 02308834
loc_02308838:
	ldr r0,[pool_02308850]	; 02308838
	ldr r1,[r0,#0x0]	; 0230883A
	ldr r0,[pool_02308860]	; 0230883C
	add r0,r1,r0	; 0230883E
	add r4,#0x90	; 02308840
	ldr r1,[r4,#0x0]	; 02308842
	bl loc_02309578	; 02308844
	pop {r4}	; 02308848
	pop {r3}	; 0230884A
	bx r3	; 0230884C
	.byte 0xC0, 0x46	; 02308850
pool_02308850:
loc_02308850:
	.word FirmwareWlWorkPointerSlot	; 02308850
pool_02308854:
loc_02308854:
	.word 0x000003E4	; 02308854
pool_02308858:
loc_02308858:
	.word 0x00000558	; 02308858
pool_0230885C:
loc_0230885C:
	.word 0x000003A2	; 0230885C
pool_02308860:
loc_02308860:
	.word 0x0000014C	; 02308860

; ===== function loc_02308864 =====
loc_02308864:
	push {r4,r5,r6,r7,lr}	; 02308864
	sub sp,#0x1c	; 02308866
	mov r0,#0x0	; 02308868
	str r0,[sp,#0x0]	; 0230886A
	ldr r6,[pool_02308AC8]	; 0230886C
	str r0,[sp,#0x4]	; 0230886E
	str r0,[sp,#0x14]	; 02308870
	str r0,[sp,#0x10]	; 02308872
	str r0,[sp,#0xc]	; 02308874
	str r0,[sp,#0x8]	; 02308876
	str r0,[sp,#0x18]	; 02308878
loc_0230887A:
	ldr r0,[pool_02308ACC]	; 0230887A
	ldrh r2,[r0,#0x0]	; 0230887C
	ldr r1,[r6,#0x0]	; 0230887E
	ldr r0,[pool_02308AD0]	; 02308880
	ldrh r0,[r1,r0]	; 02308882
	cmp r2,r0	; 02308884
	bne loc_0230888A	; 02308886
	b loc_02308ABE	; 02308888
loc_0230888A:
	lsl r2,r2,#0x1	; 0230888A
	ldr r0,[pool_02308AD4]	; 0230888C
	add r5,r2,r0	; 0230888E
	add r0,r5,#0x2	; 02308890
	ldr r2,[pool_02308AD8]	; 02308892
	cmp r0,r2	; 02308894
	bcs loc_0230889C	; 02308896
	ldrh r7,[r5,#0x2]	; 02308898
	b loc_023088A4	; 0230889A
loc_0230889C:
	ldr r2,[pool_02308ADC]	; 0230889C
	ldrh r2,[r1,r2]	; 0230889E
	sub r0,r0,r2	; 023088A0
	ldrh r7,[r0,#0x0]	; 023088A2
loc_023088A4:
	ldrh r2,[r5,#0x0]	; 023088A4
	ldr r0,[pool_02308AE0]	; 023088A6
	cmp r2,r0	; 023088A8
	bne loc_023088B2	; 023088AA
	ldr r0,[pool_02308ACC]	; 023088AC
	strh r7,[r0,#0x0]	; 023088AE
	b loc_02308AB6	; 023088B0
loc_023088B2:
	add r0,r5,#0x0	; 023088B2
	add r0,#0x8	; 023088B4
	ldr r2,[pool_02308AD8]	; 023088B6
	cmp r0,r2	; 023088B8
	bcs loc_023088C0	; 023088BA
	ldrh r1,[r5,#0x8]	; 023088BC
	b loc_023088C8	; 023088BE
loc_023088C0:
	ldr r2,[pool_02308ADC]	; 023088C0
	ldrh r1,[r1,r2]	; 023088C2
	sub r0,r0,r1	; 023088C4
	ldrh r1,[r0,#0x0]	; 023088C6
loc_023088C8:
	add r0,r5,#0x0	; 023088C8
	bl loc_023086BC	; 023088CA
	add r4,r0,#0x0	; 023088CE
	ldr r0,[pool_02308ACC]	; 023088D0
	strh r7,[r0,#0x0]	; 023088D2
	cmp r4,#0x0	; 023088D4
	bne loc_023088F2	; 023088D6
	ldrh r1,[r5,#0x0]	; 023088D8
	mov r0,#0xf	; 023088DA
	and r1,r0	; 023088DC
	cmp r1,#0xc	; 023088DE
	bne loc_023088EA	; 023088E0
	mov r0,#0x10	; 023088E2
	bl loc_02305134	; 023088E4
	b loc_02308AB6	; 023088E8
loc_023088EA:
	mov r0,#0x8	; 023088EA
	bl loc_02305134	; 023088EC
	b loc_02308AB6	; 023088F0
loc_023088F2:
	ldr r0,[r6,#0x0]	; 023088F2
	ldr r1,[pool_02308AE4]	; 023088F4
	ldrh r2,[r0,r1]	; 023088F6
	mov r1,#0x8	; 023088F8
	and r2,r1	; 023088FA
	cmp r2,#0x0	; 023088FC
	beq loc_02308910	; 023088FE
	ldrh r2,[r4,#0x14]	; 02308900
	ldr r1,[pool_02308AE8]	; 02308902
	and r2,r1	; 02308904
	cmp r2,#0x0	; 02308906
	beq loc_02308910	; 02308908
	ldr r2,[sp,#0x4]	; 0230890A
	ldr r1,[pool_02308AEC]	; 0230890C
	strh r2,[r0,r1]	; 0230890E
loc_02308910:
	ldrh r1,[r4,#0x8]	; 02308910
	mov r7,#0x1	; 02308912
	add r2,r1,#0x0	; 02308914
	ldr r0,[pool_02308AF0]	; 02308916
	and r2,r0	; 02308918
	cmp r2,#0x0	; 0230891A
	beq loc_02308952	; 0230891C
	ldrh r0,[r4,#0x14]	; 0230891E
	lsl r0,r0,#0x15	; 02308920
	lsr r0,r0,#0x1f	; 02308922
	cmp r0,#0x1	; 02308924
	beq loc_02308934	; 02308926
	ldrh r0,[r4,#0x2a]	; 02308928
	lsl r0,r0,#0x1c	; 0230892A
	lsr r0,r0,#0x1c	; 0230892C
	cmp r0,#0x0	; 0230892E
	bne loc_02308934	; 02308930
	b loc_02308A7A	; 02308932
loc_02308934:
	ldr r7,[sp,#0x8]	; 02308934
	ldr r2,[r6,#0x0]	; 02308936
	ldr r0,[pool_02308AF4]	; 02308938
	add r0,r2,r0	; 0230893A
	ldr r1,[pool_02308AF8]	; 0230893C
	add r1,r2,r1	; 0230893E
	add r2,r4,#0x0	; 02308940
	sub r2,#0x10	; 02308942
	bl loc_02304FAC	; 02308944
	mov r0,#0x2	; 02308948
	mov r1,#0x9	; 0230894A
	bl loc_02304B6C	; 0230894C
	b loc_02308A7A	; 02308950
loc_02308952:
	mov r0,#0xf	; 02308952
	and r1,r0	; 02308954
	cmp r1,#0xf	; 02308956
	bls loc_0230895C	; 02308958
	b loc_02308A7A	; 0230895A
loc_0230895C:
	add r0,r1,r1	; 0230895C
P4_SwitchIndexPC_0230895C:
	add r0,pc	; 0230895E
	ldrh r0,[r0,#(P4_SwitchTable_0230895C - (P4_SwitchIndexPC_0230895C + 4))]	; 02308960
	lsl r0,r0,#0x10	; 02308962
	asr r0,r0,#0x10	; 02308964
P4_SwitchTargetPC_0230895C:
	add r0,pc	; 02308966
	bx r0	; 02308968
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230895C:
	.halfword (loc_023089C0 + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_023089B2 + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_023089E8 + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_0230898A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A7A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A24 + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A5A + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A10 + 1) - (P4_SwitchTargetPC_0230895C + 4)
	.halfword (loc_02308A10 + 1) - (P4_SwitchTargetPC_0230895C + 4)
P4_SwitchTable_0230895CEnd:
loc_0230898A:
	ldrh r1,[r4,#0x14]	; 0230898A
	mov r0,#0xf	; 0230898C
	and r1,r0	; 0230898E
	cmp r1,#0x8	; 02308990
	bne loc_02308A7A	; 02308992
	ldr r7,[sp,#0xc]	; 02308994
	ldr r2,[r6,#0x0]	; 02308996
	ldr r0,[pool_02308AF4]	; 02308998
	add r0,r2,r0	; 0230899A
	ldr r1,[pool_02308AFC]	; 0230899C
	add r1,r2,r1	; 0230899E
	add r2,r4,#0x0	; 023089A0
	sub r2,#0x10	; 023089A2
	bl loc_02304FAC	; 023089A4
	mov r0,#0x2	; 023089A8
	mov r1,#0x6	; 023089AA
	bl loc_02304B6C	; 023089AC
	b loc_02308A7A	; 023089B0
loc_023089B2:
	ldrh r0,[r4,#0x14]	; 023089B2
	cmp r0,#0x80	; 023089B4
	bne loc_02308A7A	; 023089B6
	add r0,r4,#0x0	; 023089B8
	bl loc_0230F2AC	; 023089BA
	b loc_02308A7A	; 023089BE
loc_023089C0:
	ldrh r1,[r4,#0x14]	; 023089C0
	mov r0,#0xf	; 023089C2
	and r1,r0	; 023089C4
	cmp r1,#0x0	; 023089C6
	bne loc_02308A7A	; 023089C8
	ldr r7,[sp,#0x10]	; 023089CA
	ldr r2,[r6,#0x0]	; 023089CC
	ldr r0,[pool_02308AF4]	; 023089CE
	add r0,r2,r0	; 023089D0
	ldr r1,[pool_02308B00]	; 023089D2
	add r1,r2,r1	; 023089D4
	add r2,r4,#0x0	; 023089D6
	sub r2,#0x10	; 023089D8
	bl loc_02304FAC	; 023089DA
	mov r0,#0x1	; 023089DE
	mov r1,#0x7	; 023089E0
	bl loc_02304B6C	; 023089E2
	b loc_02308A7A	; 023089E6
loc_023089E8:
	ldrh r1,[r4,#0x14]	; 023089E8
	ldr r0,[pool_02308B04]	; 023089EA
	and r1,r0	; 023089EC
	cmp r1,#0xa4	; 023089EE
	bne loc_02308A7A	; 023089F0
	ldr r7,[sp,#0x14]	; 023089F2
	ldr r2,[r6,#0x0]	; 023089F4
	ldr r0,[pool_02308AF4]	; 023089F6
	add r0,r2,r0	; 023089F8
	ldr r1,[pool_02308B00]	; 023089FA
	add r1,r2,r1	; 023089FC
	add r2,r4,#0x0	; 023089FE
	sub r2,#0x10	; 02308A00
	bl loc_02304FAC	; 02308A02
	mov r0,#0x1	; 02308A06
	mov r1,#0x7	; 02308A08
	bl loc_02304B6C	; 02308A0A
	b loc_02308A7A	; 02308A0E
loc_02308A10:
	ldrh r0,[r4,#0x14]	; 02308A10
	ldr r1,[pool_02308B08]	; 02308A12
	and r0,r1	; 02308A14
	ldr r1,[pool_02308B0C]	; 02308A16
	cmp r0,r1	; 02308A18
	bne loc_02308A7A	; 02308A1A
	add r0,r4,#0x0	; 02308A1C
	bl loc_0230F970	; 02308A1E
	b loc_02308A7A	; 02308A22
loc_02308A24:
	ldrh r0,[r4,#0x14]	; 02308A24
	ldr r1,[pool_02308B04]	; 02308A26
	and r0,r1	; 02308A28
	ldr r1,[pool_02308B10]	; 02308A2A
	cmp r0,r1	; 02308A2C
	bne loc_02308A7A	; 02308A2E
	ldr r1,[r6,#0x0]	; 02308A30
	ldr r0,[pool_02308B14]	; 02308A32
	ldrh r0,[r1,r0]	; 02308A34
	lsl r0,r0,#0x1e	; 02308A36
	lsr r0,r0,#0x1f	; 02308A38
	cmp r0,#0x0	; 02308A3A
	bne loc_02308A44	; 02308A3C
	lsl r1,r7,#0	; 02308A3E
	ldr r0,[pool_02308B18]	; 02308A40
	strh r1,[r0,#0x0]	; 02308A42
loc_02308A44:
	ldr r1,[r6,#0x0]	; 02308A44
	ldr r0,[pool_02308B1C]	; 02308A46
	add r1,r1,r0	; 02308A48
	ldr r0,[r1,#0x0]	; 02308A4A
	add r0,r0,#0x1	; 02308A4C
	str r0,[r1,#0x0]	; 02308A4E
	add r0,r4,#0x0	; 02308A50
	bl loc_0230FAE4	; 02308A52
	add r7,r0,#0x0	; 02308A56
	b loc_02308A7A	; 02308A58
loc_02308A5A:
	ldrh r0,[r4,#0x14]	; 02308A5A
	ldr r1,[pool_02308B04]	; 02308A5C
	and r0,r1	; 02308A5E
	ldr r1,[pool_02308B20]	; 02308A60
	cmp r0,r1	; 02308A62
	bne loc_02308A7A	; 02308A64
	ldr r1,[r6,#0x0]	; 02308A66
	ldr r0,[pool_02308B24]	; 02308A68
	add r1,r1,r0	; 02308A6A
	ldr r0,[r1,#0x0]	; 02308A6C
	add r0,r0,#0x1	; 02308A6E
	str r0,[r1,#0x0]	; 02308A70
	add r0,r4,#0x0	; 02308A72
	bl loc_0230F884	; 02308A74
	add r7,r0,#0x0	; 02308A78
loc_02308A7A:
	cmp r7,#0x0	; 02308A7A
	beq loc_02308A8C	; 02308A7C
	ldr r1,[r6,#0x0]	; 02308A7E
	ldr r0,[pool_02308AF4]	; 02308A80
	add r0,r1,r0	; 02308A82
	sub r4,#0x10	; 02308A84
	add r1,r4,#0x0	; 02308A86
	bl loc_02304FFC	; 02308A88
loc_02308A8C:
	ldr r1,[r6,#0x0]	; 02308A8C
	ldr r0,[pool_02308AE4]	; 02308A8E
	ldrh r1,[r1,r0]	; 02308A90
	mov r0,#0x1	; 02308A92
	and r1,r0	; 02308A94
	cmp r1,#0x0	; 02308A96
	beq loc_02308AB6	; 02308A98
	ldr r0,[sp,#0x18]	; 02308A9A
loc_02308A9C:
	ldr r1,[pool_02308AD8]	; 02308A9C
	cmp r5,r1	; 02308A9E
	bcc loc_02308AAA	; 02308AA0
	ldr r2,[r6,#0x0]	; 02308AA2
	ldr r1,[pool_02308ADC]	; 02308AA4
	ldrh r1,[r2,r1]	; 02308AA6
	sub r5,r5,r1	; 02308AA8
loc_02308AAA:
	ldr r1,[pool_02308AE0]	; 02308AAA
	strh r1,[r5,#0x0]	; 02308AAC
	add r5,r5,#0x2	; 02308AAE
	add r0,r0,#0x1	; 02308AB0
	cmp r0,#0x7	; 02308AB2
	bcc loc_02308A9C	; 02308AB4
loc_02308AB6:
	ldr r0,[sp,#0x0]	; 02308AB6
	add r0,r0,#0x1	; 02308AB8
	str r0,[sp,#0x0]	; 02308ABA
	b loc_0230887A	; 02308ABC
loc_02308ABE:
	add sp,#0x1c	; 02308ABE
	pop {r4,r5,r6,r7}	; 02308AC0
	pop {r3}	; 02308AC2
	bx r3	; 02308AC4
	.byte 0xC0, 0x46	; 02308AC8
pool_02308AC8:
loc_02308AC8:
	.word FirmwareWlWorkPointerSlot	; 02308AC8
pool_02308ACC:
loc_02308ACC:
	.word REG_WIFI_RXBUF_READCSR	; 02308ACC
pool_02308AD0:
loc_02308AD0:
	.word 0x0000049C	; 02308AD0
pool_02308AD4:
loc_02308AD4:
	.word WifiRamBase	; 02308AD4
pool_02308AD8:
loc_02308AD8:
	.word 0x04805F60	; 02308AD8
pool_02308ADC:
loc_02308ADC:
	.word 0x00000396	; 02308ADC
pool_02308AE0:
loc_02308AE0:
	.word 0x0000FFFF	; 02308AE0
pool_02308AE4:
loc_02308AE4:
	.word 0x0000061C	; 02308AE4
pool_02308AE8:
loc_02308AE8:
	.word 0x00004000	; 02308AE8
pool_02308AEC:
loc_02308AEC:
	.word 0x0000049A	; 02308AEC
pool_02308AF0:
loc_02308AF0:
	.word 0x00000200	; 02308AF0
pool_02308AF4:
loc_02308AF4:
	.word 0x0000014C	; 02308AF4
pool_02308AF8:
loc_02308AF8:
	.word 0x000001AC	; 02308AF8
pool_02308AFC:
loc_02308AFC:
	.word 0x00000188	; 02308AFC
pool_02308B00:
loc_02308B00:
	.word 0x000001A0	; 02308B00
pool_02308B04:
loc_02308B04:
	.word 0x0000E7FF	; 02308B04
pool_02308B08:
loc_02308B08:
	.word 0x0000E7BF	; 02308B08
pool_02308B0C:
loc_02308B0C:
	.word 0x00000118	; 02308B0C
pool_02308B10:
loc_02308B10:
	.word 0x00000228	; 02308B10
pool_02308B14:
loc_02308B14:
	.word 0x00000316	; 02308B14
pool_02308B18:
loc_02308B18:
	.word REG_WIFI_POWERSTATE	; 02308B18
pool_02308B1C:
loc_02308B1C:
	.word 0x00000564	; 02308B1C
pool_02308B20:
loc_02308B20:
	.word 0x00000218	; 02308B20
pool_02308B24:
loc_02308B24:
	.word 0x00000568	; 02308B24

; ===== function loc_02308B28 =====
	push {r4,r5,r6,r7,lr}	; 02308B28
	sub sp,#0xc	; 02308B2A
	ldr r7,[pool_02308C60]	; 02308B2C
	ldr r1,[r7,#0x0]	; 02308B2E
	ldr r0,[pool_02308C64]	; 02308B30
	add r0,r1,r0	; 02308B32
	str r0,[sp,#0x0]	; 02308B34
	mov r4,#0x2	; 02308B36
	str r4,[sp,#0x8]	; 02308B38
	str r4,[sp,#0x4]	; 02308B3A
loc_02308B3C:
	ldr r1,[r7,#0x0]	; 02308B3C
	ldr r0,[pool_02308C64]	; 02308B3E
	add r2,r1,r0	; 02308B40
	add r1,r4,#0x0	; 02308B42
	mov r0,#0x14	; 02308B44
	mul r1,r0	; 02308B46
	add r2,r2,r1	; 02308B48
	lsl r1,r4,#0x2	; 02308B4A
	ldr r0,[pool_02308C68]	; 02308B4C
	add r3,r1,r0	; 02308B4E
	ldrh r1,[r3,#0x0]	; 02308B50
	ldr r0,[pool_02308C6C]	; 02308B52
	and r1,r0	; 02308B54
	cmp r1,#0x0	; 02308B56
	bne loc_02308C50	; 02308B58
	ldrh r0,[r2,#0x0]	; 02308B5A
	cmp r0,#0x0	; 02308B5C
	beq loc_02308C50	; 02308B5E
	ldr r1,[r2,#0xc]	; 02308B60
	cmp r1,#0x0	; 02308B62
	beq loc_02308C3E	; 02308B64
	ldr r0,[r2,#0x8]	; 02308B66
	ldrh r0,[r0,#0x0]	; 02308B68
	strh r0,[r1,#0x8]	; 02308B6A
	ldr r0,[r2,#0x8]	; 02308B6C
	ldrh r1,[r0,#0xc]	; 02308B6E
	ldr r0,[r2,#0xc]	; 02308B70
	strh r1,[r0,#0x14]	; 02308B72
	ldr r5,[r2,#0x8]	; 02308B74
	ldrh r1,[r5,#0xc]	; 02308B76
	ldr r0,[pool_02308C70]	; 02308B78
	and r1,r0	; 02308B7A
	cmp r1,#0x0	; 02308B7C
	beq loc_02308C20	; 02308B7E
	ldr r1,[r7,#0x0]	; 02308B80
	ldr r0,[pool_02308C74]	; 02308B82
	ldrh r6,[r1,r0]	; 02308B84
	mov r0,#0x8	; 02308B86
	and r6,r0	; 02308B88
	cmp r6,#0x0	; 02308B8A
	beq loc_02308C0A	; 02308B8C
	add r6,r5,#0x0	; 02308B8E
	add r6,#0xc	; 02308B90
	ldrh r0,[r5,#0xa]	; 02308B92
	add r0,r6,r0	; 02308B94
	sub r0,r0,#0x7	; 02308B96
	mov r6,#0x1	; 02308B98
	bic r0,r6	; 02308B9A
	ldrh r6,[r0,#0x0]	; 02308B9C
	cmp r6,#0x0	; 02308B9E
	bne loc_02308C0A	; 02308BA0
	ldrh r0,[r0,#0x2]	; 02308BA2
	cmp r0,#0x0	; 02308BA4
	bne loc_02308C0A	; 02308BA6
	ldr r0,[pool_02308C78]	; 02308BA8
	ldr r1,[r1,r0]	; 02308BAA
	ldr r0,[r2,#0xc]	; 02308BAC
	ldrh r0,[r0,#0x4]	; 02308BAE
	sub r0,r1,r0	; 02308BB0
	lsl r0,r0,#0x10	; 02308BB2
	lsr r1,r0,#0x10	; 02308BB4
	mov r5,#0x0	; 02308BB6
	ldr r0,[pool_02308C7C]	; 02308BB8
	strh r5,[r0,#0x0]	; 02308BBA
	ldr r5,[pool_02308C6C]	; 02308BBC
	strh r5,[r0,#0x0]	; 02308BBE
	ldr r5,[r7,#0x0]	; 02308BC0
	ldr r0,[pool_02308C80]	; 02308BC2
	add r0,r5,r0	; 02308BC4
	ldrh r5,[r0,#0x0]	; 02308BC6
	add r5,r5,#0x1	; 02308BC8
	strh r5,[r0,#0x0]	; 02308BCA
	ldr r5,[r7,#0x0]	; 02308BCC
	ldr r0,[pool_02308C84]	; 02308BCE
	ldrh r0,[r5,r0]	; 02308BD0
	cmp r1,r0	; 02308BD2
	bls loc_02308BFA	; 02308BD4
	ldr r1,[r2,#0xc]	; 02308BD6
	ldr r0,[sp,#0x4]	; 02308BD8
	strh r0,[r1,#0x8]	; 02308BDA
	add r1,r2,#0x4	; 02308BDC
	ldrh r0,[r1,#0x0]	; 02308BDE
	add r0,r0,#0x1	; 02308BE0
	strh r0,[r1,#0x0]	; 02308BE2
	ldr r1,[sp,#0x0]	; 02308BE4
	add r1,#0xb0	; 02308BE6
	ldrh r0,[r1,#0x0]	; 02308BE8
	add r0,r0,#0x1	; 02308BEA
	strh r0,[r1,#0x0]	; 02308BEC
	ldr r0,[r2,#0xc]	; 02308BEE
	mov r1,#0x1	; 02308BF0
	ldr r2,[r2,#0x10]	; 02308BF2
	bl loc_02308C88	; 02308BF4
	b loc_02308C50	; 02308BF8
loc_02308BFA:
	ldr r1,[r2,#0xc]	; 02308BFA
	mov r0,#0x0	; 02308BFC
	strh r0,[r1,#0xc]	; 02308BFE
	ldrh r1,[r3,#0x0]	; 02308C00
	ldr r0,[pool_02308C6C]	; 02308C02
	orr r1,r0	; 02308C04
	strh r1,[r3,#0x0]	; 02308C06
	b loc_02308C50	; 02308C08
loc_02308C0A:
	ldr r1,[r2,#0xc]	; 02308C0A
	add r1,#0xc	; 02308C0C
	ldrh r0,[r1,#0x0]	; 02308C0E
	ldrh r5,[r5,#0x4]	; 02308C10
	mov r3,#0xff	; 02308C12
	and r5,r3	; 02308C14
	lsl r3,r5,#0x10	; 02308C16
	lsr r3,r3,#0x10	; 02308C18
	add r0,r0,r3	; 02308C1A
	strh r0,[r1,#0x0]	; 02308C1C
	b loc_02308C2A	; 02308C1E
loc_02308C20:
	ldrh r1,[r5,#0x4]	; 02308C20
	mov r0,#0xff	; 02308C22
	and r1,r0	; 02308C24
	ldr r0,[r2,#0xc]	; 02308C26
	strh r1,[r0,#0xc]	; 02308C28
loc_02308C2A:
	add r1,r2,#0x4	; 02308C2A
	ldrh r0,[r1,#0x0]	; 02308C2C
	add r0,r0,#0x1	; 02308C2E
	strh r0,[r1,#0x0]	; 02308C30
	ldr r0,[r2,#0xc]	; 02308C32
	ldr r1,[sp,#0x8]	; 02308C34
	ldr r2,[r2,#0x10]	; 02308C36
	bl loc_02308C88	; 02308C38
	b loc_02308C50	; 02308C3C
loc_02308C3E:
	add r1,r2,#0x4	; 02308C3E
	ldrh r0,[r1,#0x0]	; 02308C40
	add r0,r0,#0x1	; 02308C42
	strh r0,[r1,#0x0]	; 02308C44
	ldr r0,[r2,#0x8]	; 02308C46
	mov r1,#0x3	; 02308C48
	ldr r2,[r2,#0x10]	; 02308C4A
	bl loc_02308C88	; 02308C4C
loc_02308C50:
	sub r4,r4,#0x1	; 02308C50
	cmp r4,#0x0	; 02308C52
	blt loc_02308C58	; 02308C54
	b loc_02308B3C	; 02308C56
loc_02308C58:
	add sp,#0xc	; 02308C58
	pop {r4,r5,r6,r7}	; 02308C5A
	pop {r3}	; 02308C5C
	bx r3	; 02308C5E
pool_02308C60:
loc_02308C60:
	.word FirmwareWlWorkPointerSlot	; 02308C60
pool_02308C64:
loc_02308C64:
	.word 0x000003E4	; 02308C64
pool_02308C68:
loc_02308C68:
	.word REG_WIFI_TXBUF_LOC1	; 02308C68
pool_02308C6C:
loc_02308C6C:
	.word 0x00008000	; 02308C6C
pool_02308C70:
loc_02308C70:
	.word 0x00004000	; 02308C70
pool_02308C74:
loc_02308C74:
	.word 0x0000061C	; 02308C74
pool_02308C78:
loc_02308C78:
	.word 0x000003A4	; 02308C78
pool_02308C7C:
loc_02308C7C:
	.word REG_WIFI_WEP_CNT	; 02308C7C
pool_02308C80:
loc_02308C80:
	.word 0x000003B6	; 02308C80
pool_02308C84:
loc_02308C84:
	.word 0x00000388	; 02308C84

; ===== function loc_02308C88 =====
loc_02308C88:
	bx pc	; 02308C88
	.byte 0xC0, 0x46	; 02308C8C
.arm

; ===== function loc_02308C8C =====
loc_02308C8C:
	ldr r12,[pool_02308C94]	; 02308C8C
	bx r12	; 02308C90
pool_02308C94:
loc_02308C94:
	.word loc_038029FC + 1	; 02308C94
.thumb

; ===== function loc_02308C98 =====
	push {lr}	; 02308C98
	sub sp,#0x4	; 02308C9A
	ldr r0,[pool_02308CC8]	; 02308C9C
	ldr r1,[r0,#0x0]	; 02308C9E
	ldr r0,[pool_02308CCC]	; 02308CA0
	ldrh r0,[r1,r0]	; 02308CA2
	cmp r0,#0x0	; 02308CA4
	beq loc_02308CAC	; 02308CA6
	bl loc_0230C63C	; 02308CA8
loc_02308CAC:
	ldr r0,[pool_02308CC8]	; 02308CAC
	ldr r1,[r0,#0x0]	; 02308CAE
	ldr r0,[pool_02308CD0]	; 02308CB0
	ldrh r0,[r1,r0]	; 02308CB2
	lsl r0,r0,#0x19	; 02308CB4
	lsr r0,r0,#0x1f	; 02308CB6
	cmp r0,#0x0	; 02308CB8
	beq loc_02308CC0	; 02308CBA
	bl loc_02309934	; 02308CBC
loc_02308CC0:
	add sp,#0x4	; 02308CC0
	pop {r3}	; 02308CC2
	bx r3	; 02308CC4
	.byte 0xC0, 0x46	; 02308CC8
pool_02308CC8:
loc_02308CC8:
	.word FirmwareWlWorkPointerSlot	; 02308CC8
pool_02308CCC:
loc_02308CCC:
	.word 0x000003A0	; 02308CCC
pool_02308CD0:
loc_02308CD0:
	.word 0x000002FE	; 02308CD0

; ===== function loc_02308CD4 =====
loc_02308CD4:
	push {r4,r5,r6,lr}	; 02308CD4
	sub sp,#0x8	; 02308CD6
	add r5,r0,#0x0	; 02308CD8
	add r6,r1,#0x0	; 02308CDA
	ldr r0,[pool_02308D5C]	; 02308CDC
	ldr r0,[r0,#0x0]	; 02308CDE
	ldr r1,[pool_02308D60]	; 02308CE0
	ldr r3,[r0,r1]	; 02308CE2
	mov r1,#0x1c	; 02308CE4
	add r2,r5,#0x0	; 02308CE6
	mul r2,r1	; 02308CE8
	add r4,r3,r2	; 02308CEA
	ldrh r1,[r3,r2]	; 02308CEC
	cmp r1,#0x0	; 02308CEE
	bne loc_02308CFC	; 02308CF0
	ldr r1,[pool_02308D64]	; 02308CF2
	add r1,r0,r1	; 02308CF4
	ldrh r0,[r1,#0x0]	; 02308CF6
	add r0,r0,#0x1	; 02308CF8
	strh r0,[r1,#0x0]	; 02308CFA
loc_02308CFC:
	mov r1,#0x0	; 02308CFC
	add r0,sp,#0x0	; 02308CFE
	strh r1,[r0,#0x0]	; 02308D00
	ldrh r0,[r0,#0x0]	; 02308D02
	add r1,r4,#0x0	; 02308D04
	mov r2,#0x1a	; 02308D06
	bl loc_02308D78	; 02308D08
	lsl r0,r5,#0x10	; 02308D0C
	lsr r0,r0,#0x10	; 02308D0E
	mov r1,#0x0	; 02308D10
	bl loc_02309184	; 02308D12
	ldr r0,[pool_02308D5C]	; 02308D16
	ldr r1,[r0,#0x0]	; 02308D18
	ldr r0,[pool_02308D68]	; 02308D1A
	add r2,r1,r0	; 02308D1C
	ldrh r1,[r2,#0x0]	; 02308D1E
	mov r0,#0x1	; 02308D20
	lsl r0,r5	; 02308D22
	orr r1,r0	; 02308D24
	strh r1,[r2,#0x0]	; 02308D26
	add r0,r4,#0x4	; 02308D28
	add r1,r6,#0x0	; 02308D2A
	bl loc_0230645C	; 02308D2C
	ldr r0,[pool_02308D6C]	; 02308D30
	strh r0,[r4,#0x14]	; 02308D32
	ldr r2,[pool_02308D5C]	; 02308D34
	ldr r1,[r2,#0x0]	; 02308D36
	ldr r0,[pool_02308D70]	; 02308D38
	ldrh r0,[r1,r0]	; 02308D3A
	strh r0,[r4,#0x10]	; 02308D3C
	ldr r1,[r2,#0x0]	; 02308D3E
	ldr r0,[pool_02308D74]	; 02308D40
	ldrh r0,[r1,r0]	; 02308D42
	strh r0,[r4,#0x12]	; 02308D44
	ldrh r0,[r4,#0x1a]	; 02308D46
	strh r0,[r4,#0x18]	; 02308D48
	lsl r0,r5,#0x10	; 02308D4A
	lsr r0,r0,#0x10	; 02308D4C
	mov r1,#0x20	; 02308D4E
	bl loc_023091F0	; 02308D50
	add sp,#0x8	; 02308D54
	pop {r4,r5,r6}	; 02308D56
	pop {r3}	; 02308D58
	bx r3	; 02308D5A
pool_02308D5C:
loc_02308D5C:
	.word FirmwareWlWorkPointerSlot	; 02308D5C
pool_02308D60:
loc_02308D60:
	.word 0x000002E0	; 02308D60
pool_02308D64:
loc_02308D64:
	.word 0x000004E8	; 02308D64
pool_02308D68:
loc_02308D68:
	.word 0x000004EC	; 02308D68
pool_02308D6C:
loc_02308D6C:
	.word 0x0000FFFF	; 02308D6C
pool_02308D70:
loc_02308D70:
	.word 0x0000035E	; 02308D70
pool_02308D74:
loc_02308D74:
	.word 0x00000374	; 02308D74

; ===== function loc_02308D78 =====
loc_02308D78:
	bx pc	; 02308D78
	.byte 0xC0, 0x46	; 02308D7C
.arm

; ===== function loc_02308D7C =====
loc_02308D7C:
	ldr pc,[pool_02308D80]	; 02308D7C
pool_02308D80:
loc_02308D80:
	.word loc_037FCE04	; 02308D80
.thumb

; ===== function loc_02308D84 =====
loc_02308D84:
	push {r4,r5,r6,r7,lr}	; 02308D84
	sub sp,#0x4	; 02308D86
	ldr r4,[pool_02308DE8]	; 02308D88
	ldr r1,[r4,#0x0]	; 02308D8A
	ldr r0,[pool_02308DEC]	; 02308D8C
	ldr r6,[r1,r0]	; 02308D8E
	mov r5,#0x1	; 02308D90
	mov r7,#0x0	; 02308D92
	b loc_02308DAC	; 02308D94
loc_02308D96:
	add r0,sp,#0x0	; 02308D96
	strh r7,[r0,#0x0]	; 02308D98
	ldrh r0,[r0,#0x0]	; 02308D9A
	add r2,r5,#0x0	; 02308D9C
	mov r1,#0x1c	; 02308D9E
	mul r2,r1	; 02308DA0
	add r1,r6,r2	; 02308DA2
	mov r2,#0x1a	; 02308DA4
	bl loc_02308E10	; 02308DA6
	add r5,r5,#0x1	; 02308DAA
loc_02308DAC:
	ldr r0,[r4,#0x0]	; 02308DAC
	ldr r1,[pool_02308DF0]	; 02308DAE
	ldrh r1,[r0,r1]	; 02308DB0
	cmp r5,r1	; 02308DB2
	bcc loc_02308D96	; 02308DB4
	mov r1,#0x1	; 02308DB6
	ldr r2,[pool_02308DF4]	; 02308DB8
	strh r1,[r0,r2]	; 02308DBA
	mov r0,#0x0	; 02308DBC
	ldr r3,[r4,#0x0]	; 02308DBE
	ldr r2,[pool_02308DF8]	; 02308DC0
	strh r0,[r3,r2]	; 02308DC2
	ldr r3,[r4,#0x0]	; 02308DC4
	ldr r2,[pool_02308DFC]	; 02308DC6
	strh r1,[r3,r2]	; 02308DC8
	ldr r5,[pool_02308E00]	; 02308DCA
	ldr r3,[r4,#0x0]	; 02308DCC
	ldr r2,[pool_02308E04]	; 02308DCE
	strh r5,[r3,r2]	; 02308DD0
	ldr r3,[r4,#0x0]	; 02308DD2
	ldr r2,[pool_02308E08]	; 02308DD4
	strh r0,[r3,r2]	; 02308DD6
	ldr r2,[r4,#0x0]	; 02308DD8
	ldr r0,[pool_02308E0C]	; 02308DDA
	strh r1,[r2,r0]	; 02308DDC
	add sp,#0x4	; 02308DDE
	pop {r4,r5,r6,r7}	; 02308DE0
	pop {r3}	; 02308DE2
	bx r3	; 02308DE4
	.byte 0xC0, 0x46	; 02308DE8
pool_02308DE8:
loc_02308DE8:
	.word FirmwareWlWorkPointerSlot	; 02308DE8
pool_02308DEC:
loc_02308DEC:
	.word 0x000002E0	; 02308DEC
pool_02308DF0:
loc_02308DF0:
	.word 0x000002E6	; 02308DF0
pool_02308DF4:
loc_02308DF4:
	.word 0x000004E8	; 02308DF4
pool_02308DF8:
loc_02308DF8:
	.word 0x000004EA	; 02308DF8
pool_02308DFC:
loc_02308DFC:
	.word 0x000004EC	; 02308DFC
pool_02308E00:
loc_02308E00:
	.word 0x0000FFFE	; 02308E00
pool_02308E04:
loc_02308E04:
	.word 0x000004EE	; 02308E04
pool_02308E08:
loc_02308E08:
	.word 0x000004F0	; 02308E08
pool_02308E0C:
loc_02308E0C:
	.word 0x000004F2	; 02308E0C

; ===== function loc_02308E10 =====
loc_02308E10:
	bx pc	; 02308E10
	.byte 0xC0, 0x46	; 02308E14
.arm

; ===== function loc_02308E14 =====
loc_02308E14:
	ldr pc,[pool_02308E18]	; 02308E14
pool_02308E18:
loc_02308E18:
	.word loc_037FCE04	; 02308E18
.thumb

; ===== function loc_02308E1C =====
loc_02308E1C:
	push {r4,r5,r6,lr}	; 02308E1C
	sub sp,#0x8	; 02308E1E
	ldr r0,[pool_02308E8C]	; 02308E20
	ldr r2,[r0,#0x0]	; 02308E22
	ldr r0,[pool_02308E90]	; 02308E24
	ldr r4,[r2,r0]	; 02308E26
	mov r1,#0x0	; 02308E28
	add r0,sp,#0x0	; 02308E2A
	strh r1,[r0,#0x0]	; 02308E2C
	ldrh r0,[r0,#0x0]	; 02308E2E
	add r1,r4,#0x0	; 02308E30
	ldr r3,[pool_02308E94]	; 02308E32
	ldrh r2,[r2,r3]	; 02308E34
	mov r3,#0x1c	; 02308E36
	mul r2,r3	; 02308E38
	bl loc_02308EA4	; 02308E3A
	mov r1,#0x0	; 02308E3E
	add r0,sp,#0x0	; 02308E40
	strh r1,[r0,#0x2]	; 02308E42
	ldrh r0,[r0,#0x2]	; 02308E44
	ldr r1,[pool_02308E8C]	; 02308E46
	ldr r2,[r1,#0x0]	; 02308E48
	ldr r1,[pool_02308E98]	; 02308E4A
	add r1,r2,r1	; 02308E4C
	mov r2,#0xc	; 02308E4E
	bl loc_02308EB0	; 02308E50
	ldr r1,[pool_02308E9C]	; 02308E54
	strh r1,[r4,#0x1a]	; 02308E56
	mov r2,#0x1	; 02308E58
	ldr r0,[pool_02308E8C]	; 02308E5A
	mov r5,#0x1c	; 02308E5C
	ldr r3,[pool_02308E94]	; 02308E5E
	b loc_02308E6C	; 02308E60
loc_02308E62:
	add r6,r2,#0x0	; 02308E62
	mul r6,r5	; 02308E64
	add r6,r4,r6	; 02308E66
	strh r1,[r6,#0x1a]	; 02308E68
	add r2,r2,#0x1	; 02308E6A
loc_02308E6C:
	ldr r6,[r0,#0x0]	; 02308E6C
	ldrh r6,[r6,r3]	; 02308E6E
	cmp r2,r6	; 02308E70
	bcc loc_02308E62	; 02308E72
	mov r0,#0x0	; 02308E74
	ldr r1,[pool_02308EA0]	; 02308E76
	bl loc_02308CD4	; 02308E78
	mov r0,#0x0	; 02308E7C
	mov r1,#0x40	; 02308E7E
	bl loc_023091F0	; 02308E80
	add sp,#0x8	; 02308E84
	pop {r4,r5,r6}	; 02308E86
	pop {r3}	; 02308E88
	bx r3	; 02308E8A
pool_02308E8C:
loc_02308E8C:
	.word FirmwareWlWorkPointerSlot	; 02308E8C
pool_02308E90:
loc_02308E90:
	.word 0x000002E0	; 02308E90
pool_02308E94:
loc_02308E94:
	.word 0x000002E6	; 02308E94
pool_02308E98:
loc_02308E98:
	.word 0x000004E8	; 02308E98
pool_02308E9C:
loc_02308E9C:
	.word 0x0000FFFF	; 02308E9C
pool_02308EA0:
loc_02308EA0:
	.word 0x02310634	; 02308EA0

; ===== function loc_02308EA4 =====
loc_02308EA4:
	bx pc	; 02308EA4
	.byte 0xC0, 0x46	; 02308EA8
.arm

; ===== function loc_02308EA8 =====
loc_02308EA8:
	ldr pc,[pool_02308EAC]	; 02308EA8
pool_02308EAC:
loc_02308EAC:
	.word loc_037FCE04	; 02308EAC
.thumb

; ===== function loc_02308EB0 =====
loc_02308EB0:
	bx pc	; 02308EB0
	.byte 0xC0, 0x46	; 02308EB4
.arm

; ===== function loc_02308EB4 =====
loc_02308EB4:
	ldr pc,[pool_02308EB8]	; 02308EB4
pool_02308EB8:
loc_02308EB8:
	.word loc_037FCE04	; 02308EB8
.thumb

; ===== function loc_02308EBC =====
	push {r4,r5,r6,r7,lr}	; 02308EBC
	sub sp,#0xc	; 02308EBE
	ldr r0,[pool_02308F7C]	; 02308EC0
	ldr r1,[r0,#0x0]	; 02308EC2
	ldr r0,[pool_02308F80]	; 02308EC4
	ldr r5,[r1,r0]	; 02308EC6
	add r5,#0x1c	; 02308EC8
	ldr r0,[pool_02308F84]	; 02308ECA
	ldrh r7,[r1,r0]	; 02308ECC
	cmp r7,#0x1	; 02308ECE
	bls loc_02308F74	; 02308ED0
	mov r6,#0x0	; 02308ED2
	mov r4,#0x1	; 02308ED4
	str r4,[sp,#0x4]	; 02308ED6
	str r4,[sp,#0x0]	; 02308ED8
	str r6,[sp,#0x8]	; 02308EDA
	b loc_02308F68	; 02308EDC
loc_02308EDE:
	ldrh r0,[r5,#0x0]	; 02308EDE
	cmp r0,#0x0	; 02308EE0
	beq loc_02308F64	; 02308EE2
	ldrh r1,[r5,#0x18]	; 02308EE4
	cmp r1,#0x0	; 02308EE6
	beq loc_02308F5E	; 02308EE8
	ldr r0,[pool_02308F88]	; 02308EEA
	cmp r1,r0	; 02308EEC
	beq loc_02308F5E	; 02308EEE
	add r1,r5,#0x0	; 02308EF0
	add r1,#0x18	; 02308EF2
	ldrh r0,[r1,#0x0]	; 02308EF4
	sub r0,r0,#0x1	; 02308EF6
	strh r0,[r1,#0x0]	; 02308EF8
	ldrh r0,[r5,#0x18]	; 02308EFA
	cmp r0,#0x0	; 02308EFC
	bne loc_02308F5E	; 02308EFE
	ldrh r0,[r5,#0x0]	; 02308F00
	cmp r0,#0x20	; 02308F02
	bcc loc_02308F4C	; 02308F04
	add r0,r4,#0x0	; 02308F06
	bl loc_0230CC80	; 02308F08
	ldr r0,[pool_02308F7C]	; 02308F0C
	ldr r0,[r0,#0x0]	; 02308F0E
	ldr r1,[pool_02308F8C]	; 02308F10
	ldrh r1,[r0,r1]	; 02308F12
	cmp r1,#0x1	; 02308F14
	bne loc_02308F28	; 02308F16
	ldrh r0,[r5,#0x0]	; 02308F18
	cmp r0,#0x20	; 02308F1A
	bls loc_02308F42	; 02308F1C
	add r0,r5,#0x4	; 02308F1E
	ldr r1,[sp,#0x0]	; 02308F20
	bl loc_02309B6C	; 02308F22
	b loc_02308F42	; 02308F26
loc_02308F28:
	ldr r1,[pool_02308F90]	; 02308F28
	ldrh r0,[r0,r1]	; 02308F2A
	cmp r4,r0	; 02308F2C
	bne loc_02308F42	; 02308F2E
	mov r0,#0x20	; 02308F30
	bl loc_0230646C	; 02308F32
	bl loc_023064D8	; 02308F36
	add r0,r5,#0x4	; 02308F3A
	ldr r1,[sp,#0x4]	; 02308F3C
	bl loc_02309B6C	; 02308F3E
loc_02308F42:
	lsl r0,r4,#0x10	; 02308F42
	lsr r0,r0,#0x10	; 02308F44
	mov r1,#0x20	; 02308F46
	bl loc_023091F0	; 02308F48
loc_02308F4C:
	ldr r0,[sp,#0x8]	; 02308F4C
	strh r0,[r5,#0x0]	; 02308F4E
	ldr r0,[pool_02308F7C]	; 02308F50
	ldr r1,[r0,#0x0]	; 02308F52
	ldr r0,[pool_02308F84]	; 02308F54
	add r1,r1,r0	; 02308F56
	ldrh r0,[r1,#0x0]	; 02308F58
	sub r0,r0,#0x1	; 02308F5A
	strh r0,[r1,#0x0]	; 02308F5C
loc_02308F5E:
	add r6,r6,#0x1	; 02308F5E
	cmp r6,r7	; 02308F60
	bcs loc_02308F74	; 02308F62
loc_02308F64:
	add r4,r4,#0x1	; 02308F64
	add r5,#0x1c	; 02308F66
loc_02308F68:
	ldr r0,[pool_02308F7C]	; 02308F68
	ldr r1,[r0,#0x0]	; 02308F6A
	ldr r0,[pool_02308F94]	; 02308F6C
	ldrh r0,[r1,r0]	; 02308F6E
	cmp r4,r0	; 02308F70
	bcc loc_02308EDE	; 02308F72
loc_02308F74:
	add sp,#0xc	; 02308F74
	pop {r4,r5,r6,r7}	; 02308F76
	pop {r3}	; 02308F78
	bx r3	; 02308F7A
pool_02308F7C:
loc_02308F7C:
	.word FirmwareWlWorkPointerSlot	; 02308F7C
pool_02308F80:
loc_02308F80:
	.word 0x000002E0	; 02308F80
pool_02308F84:
loc_02308F84:
	.word 0x000004E8	; 02308F84
pool_02308F88:
loc_02308F88:
	.word 0x0000FFFF	; 02308F88
pool_02308F8C:
loc_02308F8C:
	.word 0x00000314	; 02308F8C
pool_02308F90:
loc_02308F90:
	.word 0x00000384	; 02308F90
pool_02308F94:
loc_02308F94:
	.word 0x000002E6	; 02308F94

; ===== function loc_02308F98 =====
loc_02308F98:
	push {r4,r5,r6,lr}	; 02308F98
	add r5,r0,#0x0	; 02308F9A
	ldr r0,[pool_0230900C]	; 02308F9C
	ldr r1,[r0,#0x0]	; 02308F9E
	ldr r0,[pool_02309010]	; 02308FA0
	ldrh r1,[r1,r0]	; 02308FA2
	ldr r0,[pool_02309014]	; 02308FA4
	add r4,r1,r0	; 02308FA6
	ldr r0,[pool_02309018]	; 02308FA8
	bl loc_02304B4C	; 02308FAA
	add r6,r0,#0x0	; 02308FAE
	cmp r5,#0x0	; 02308FB0
	bne loc_02308FCC	; 02308FB2
	add r0,r4,#0x4	; 02308FB4
	bl loc_023053B8	; 02308FB6
	mov r1,#0xfe	; 02308FBA
	add r2,r0,#0x0	; 02308FBC
	and r2,r1	; 02308FBE
	add r0,r4,#0x4	; 02308FC0
	lsl r1,r2,#0x18	; 02308FC2
	lsr r1,r1,#0x18	; 02308FC4
	bl loc_023053DC	; 02308FC6
	b loc_02308FFE	; 02308FCA
loc_02308FCC:
	ldr r0,[pool_0230900C]	; 02308FCC
	ldr r1,[r0,#0x0]	; 02308FCE
	ldr r0,[pool_0230901C]	; 02308FD0
	ldr r1,[r1,r0]	; 02308FD2
	mov r0,#0x1c	; 02308FD4
	mul r5,r0	; 02308FD6
	add r0,r1,r5	; 02308FD8
	ldrh r5,[r0,#0x2]	; 02308FDA
	add r1,r4,#0x5	; 02308FDC
	lsr r0,r5,#0x3	; 02308FDE
	add r4,r1,r0	; 02308FE0
	add r0,r4,#0x0	; 02308FE2
	bl loc_023053B8	; 02308FE4
	mov r2,#0x1	; 02308FE8
	mov r1,#0x7	; 02308FEA
	and r5,r1	; 02308FEC
	lsl r2,r5	; 02308FEE
	mvn r1,r2	; 02308FF0
	and r1,r0	; 02308FF2
	add r0,r4,#0x0	; 02308FF4
	lsl r1,r1,#0x18	; 02308FF6
	lsr r1,r1,#0x18	; 02308FF8
	bl loc_023053DC	; 02308FFA
loc_02308FFE:
	add r0,r6,#0x0	; 02308FFE
	bl loc_02304B5C	; 02309000
	pop {r4,r5,r6}	; 02309004
	pop {r3}	; 02309006
	bx r3	; 02309008
	.byte 0xC0, 0x46	; 0230900C
pool_0230900C:
loc_0230900C:
	.word FirmwareWlWorkPointerSlot	; 0230900C
pool_02309010:
loc_02309010:
	.word 0x00000390	; 02309010
pool_02309014:
loc_02309014:
	.word 0x04804258	; 02309014
pool_02309018:
loc_02309018:
	.word 0x01000000	; 02309018
pool_0230901C:
loc_0230901C:
	.word 0x000002E0	; 0230901C

; ===== function loc_02309020 =====
loc_02309020:
	push {r4,r5,r6,lr}	; 02309020
	add r5,r0,#0x0	; 02309022
	ldr r0,[pool_02309090]	; 02309024
	ldr r1,[r0,#0x0]	; 02309026
	ldr r0,[pool_02309094]	; 02309028
	ldrh r1,[r1,r0]	; 0230902A
	ldr r0,[pool_02309098]	; 0230902C
	add r4,r1,r0	; 0230902E
	ldr r0,[pool_0230909C]	; 02309030
	bl loc_02304B4C	; 02309032
	add r6,r0,#0x0	; 02309036
	cmp r5,#0x0	; 02309038
	bne loc_02309054	; 0230903A
	add r0,r4,#0x4	; 0230903C
	bl loc_023053B8	; 0230903E
	mov r1,#0x1	; 02309042
	add r2,r0,#0x0	; 02309044
	orr r2,r1	; 02309046
	add r0,r4,#0x4	; 02309048
	lsl r1,r2,#0x18	; 0230904A
	lsr r1,r1,#0x18	; 0230904C
	bl loc_023053DC	; 0230904E
	b loc_02309084	; 02309052
loc_02309054:
	ldr r0,[pool_02309090]	; 02309054
	ldr r1,[r0,#0x0]	; 02309056
	ldr r0,[pool_023090A0]	; 02309058
	ldr r1,[r1,r0]	; 0230905A
	mov r0,#0x1c	; 0230905C
	mul r5,r0	; 0230905E
	add r0,r1,r5	; 02309060
	ldrh r5,[r0,#0x2]	; 02309062
	add r1,r4,#0x5	; 02309064
	lsr r0,r5,#0x3	; 02309066
	add r4,r1,r0	; 02309068
	add r0,r4,#0x0	; 0230906A
	bl loc_023053B8	; 0230906C
	mov r2,#0x1	; 02309070
	mov r1,#0x7	; 02309072
	and r5,r1	; 02309074
	lsl r2,r5	; 02309076
	orr r2,r0	; 02309078
	add r0,r4,#0x0	; 0230907A
	lsl r1,r2,#0x18	; 0230907C
	lsr r1,r1,#0x18	; 0230907E
	bl loc_023053DC	; 02309080
loc_02309084:
	add r0,r6,#0x0	; 02309084
	bl loc_02304B5C	; 02309086
	pop {r4,r5,r6}	; 0230908A
	pop {r3}	; 0230908C
	bx r3	; 0230908E
pool_02309090:
loc_02309090:
	.word FirmwareWlWorkPointerSlot	; 02309090
pool_02309094:
loc_02309094:
	.word 0x00000390	; 02309094
pool_02309098:
loc_02309098:
	.word 0x04804258	; 02309098
pool_0230909C:
loc_0230909C:
	.word 0x01000000	; 0230909C
pool_023090A0:
loc_023090A0:
	.word 0x000002E0	; 023090A0

; ===== function loc_023090A4 =====
loc_023090A4:
	push {r4,lr}	; 023090A4
	ldr r2,[pool_023090E8]	; 023090A6
	ldr r3,[r2,#0x0]	; 023090A8
	ldr r1,[pool_023090EC]	; 023090AA
	ldr r1,[r3,r1]	; 023090AC
	add r4,r1,#0x2	; 023090AE
	mov r1,#0x1c	; 023090B0
	mul r0,r1	; 023090B2
	mov r1,#0x1	; 023090B4
	ldrh r3,[r4,r0]	; 023090B6
	lsl r1,r3	; 023090B8
	mov r3,#0x0	; 023090BA
	strh r3,[r4,r0]	; 023090BC
	ldr r3,[r2,#0x0]	; 023090BE
	ldr r0,[pool_023090F0]	; 023090C0
	add r3,r3,r0	; 023090C2
	ldrh r0,[r3,#0x0]	; 023090C4
	bic r0,r1	; 023090C6
	strh r0,[r3,#0x0]	; 023090C8
	ldr r1,[r2,#0x0]	; 023090CA
	ldr r0,[pool_023090F4]	; 023090CC
	add r3,r1,r0	; 023090CE
	ldrh r1,[r3,#0x0]	; 023090D0
	sub r1,r1,#0x1	; 023090D2
	strh r1,[r3,#0x0]	; 023090D4
	ldr r1,[r2,#0x0]	; 023090D6
	ldrh r0,[r1,r0]	; 023090D8
	cmp r0,#0x0	; 023090DA
	bne loc_023090E2	; 023090DC
	bl loc_02306698	; 023090DE
loc_023090E2:
	pop {r4}	; 023090E2
	pop {r3}	; 023090E4
	bx r3	; 023090E6
pool_023090E8:
loc_023090E8:
	.word FirmwareWlWorkPointerSlot	; 023090E8
pool_023090EC:
loc_023090EC:
	.word 0x000002E0	; 023090EC
pool_023090F0:
loc_023090F0:
	.word 0x000004F2	; 023090F0
pool_023090F4:
loc_023090F4:
	.word 0x000004F0	; 023090F4

; ===== function loc_023090F8 =====
loc_023090F8:
	push {r4,r5,r6,r7,lr}	; 023090F8
	sub sp,#0x4	; 023090FA
	add r5,r0,#0x0	; 023090FC
	ldr r0,[pool_02309170]	; 023090FE
	bl loc_02304B4C	; 02309100
	add r6,r0,#0x0	; 02309104
	mov r4,#0x1	; 02309106
	mov r3,#0x2	; 02309108
	ldr r2,[pool_02309174]	; 0230910A
	ldr r7,[pool_02309178]	; 0230910C
	b loc_0230915A	; 0230910E
loc_02309110:
	ldr r1,[r2,#0x0]	; 02309110
	ldrh r0,[r1,r7]	; 02309112
	and r0,r3	; 02309114
	cmp r0,#0x0	; 02309116
	bne loc_02309156	; 02309118
	ldr r0,[pool_02309178]	; 0230911A
	add r1,r1,r0	; 0230911C
	ldrh r0,[r1,#0x0]	; 0230911E
	orr r0,r3	; 02309120
	strh r0,[r1,#0x0]	; 02309122
	ldr r0,[r2,#0x0]	; 02309124
	ldr r1,[pool_0230917C]	; 02309126
	add r0,r0,r1	; 02309128
	ldrh r3,[r0,#0x0]	; 0230912A
	add r3,r3,#0x1	; 0230912C
	strh r3,[r0,#0x0]	; 0230912E
	ldr r0,[r2,#0x0]	; 02309130
	ldrh r0,[r0,r1]	; 02309132
	cmp r0,#0x1	; 02309134
	bne loc_0230913C	; 02309136
	bl loc_02306674	; 02309138
loc_0230913C:
	ldr r0,[pool_02309174]	; 0230913C
	ldr r1,[r0,#0x0]	; 0230913E
	ldr r0,[pool_02309180]	; 02309140
	ldr r1,[r1,r0]	; 02309142
	mov r0,#0x1c	; 02309144
	mul r5,r0	; 02309146
	add r0,r1,r5	; 02309148
	strh r4,[r0,#0x2]	; 0230914A
	add r0,r6,#0x0	; 0230914C
	bl loc_02304B5C	; 0230914E
	add r0,r4,#0x0	; 02309152
	b loc_02309166	; 02309154
loc_02309156:
	add r4,r4,#0x1	; 02309156
	lsl r3,r3,#0x1	; 02309158
loc_0230915A:
	cmp r4,#0x10	; 0230915A
	bcc loc_02309110	; 0230915C
	add r0,r6,#0x0	; 0230915E
	bl loc_02304B5C	; 02309160
	mov r0,#0x0	; 02309164
loc_02309166:
	add sp,#0x4	; 02309166
	pop {r4,r5,r6,r7}	; 02309168
	pop {r3}	; 0230916A
	bx r3	; 0230916C
	.byte 0xC0, 0x46	; 02309170
pool_02309170:
loc_02309170:
	.word 0x01000000	; 02309170
pool_02309174:
loc_02309174:
	.word FirmwareWlWorkPointerSlot	; 02309174
pool_02309178:
loc_02309178:
	.word 0x000004F2	; 02309178
pool_0230917C:
loc_0230917C:
	.word 0x000004F0	; 0230917C
pool_02309180:
loc_02309180:
	.word 0x000002E0	; 02309180

; ===== function loc_02309184 =====
loc_02309184:
	push {r4,r5,r6,lr}	; 02309184
	ldr r6,[pool_023091C0]	; 02309186
	ldr r2,[r6,#0x0]	; 02309188
	ldr r3,[pool_023091C4]	; 0230918A
	add r2,r2,r3	; 0230918C
	ldrh r5,[r2,#0x0]	; 0230918E
	mov r4,#0x1	; 02309190
	lsl r4,r0	; 02309192
	bic r5,r4	; 02309194
	lsl r1,r0	; 02309196
	orr r5,r1	; 02309198
	strh r5,[r2,#0x0]	; 0230919A
	ldr r2,[r6,#0x0]	; 0230919C
	ldrh r1,[r2,r3]	; 0230919E
	ldr r0,[pool_023091C8]	; 023091A0
	ldrh r0,[r2,r0]	; 023091A2
	bic r1,r0	; 023091A4
	cmp r1,#0x0	; 023091A6
	beq loc_023091B2	; 023091A8
	mov r1,#0x8	; 023091AA
	ldr r0,[pool_023091CC]	; 023091AC
	strh r1,[r0,#0x0]	; 023091AE
	b loc_023091B8	; 023091B0
loc_023091B2:
	mov r1,#0x8	; 023091B2
	ldr r0,[pool_023091D0]	; 023091B4
	strh r1,[r0,#0x0]	; 023091B6
loc_023091B8:
	pop {r4,r5,r6}	; 023091B8
	pop {r3}	; 023091BA
	bx r3	; 023091BC
	.byte 0xC0, 0x46	; 023091C0
pool_023091C0:
loc_023091C0:
	.word FirmwareWlWorkPointerSlot	; 023091C0
pool_023091C4:
loc_023091C4:
	.word 0x000004EA	; 023091C4
pool_023091C8:
loc_023091C8:
	.word 0x000004EE	; 023091C8
pool_023091CC:
loc_023091CC:
	.word REG_WIFI_TXREQ_RESET	; 023091CC
pool_023091D0:
loc_023091D0:
	.word REG_WIFI_TXREQ_SET	; 023091D0

; ===== function loc_023091D4 =====
loc_023091D4:
	ldr r2,[pool_023091E8]	; 023091D4
	ldr r3,[r2,#0x0]	; 023091D6
	ldr r2,[pool_023091EC]	; 023091D8
	ldr r3,[r3,r2]	; 023091DA
	mov r2,#0x1c	; 023091DC
	mul r0,r2	; 023091DE
	add r0,r3,r0	; 023091E0
	strh r1,[r0,#0xa]	; 023091E2
	bx lr	; 023091E4
	.byte 0xC0, 0x46	; 023091E8
pool_023091E8:
loc_023091E8:
	.word FirmwareWlWorkPointerSlot	; 023091E8
pool_023091EC:
loc_023091EC:
	.word 0x000002E0	; 023091EC

; ===== function loc_023091F0 =====
loc_023091F0:
	push {r4,r5,r6,r7,lr}	; 023091F0
	sub sp,#0x4	; 023091F2
	add r5,r0,#0x0	; 023091F4
	add r4,r1,#0x0	; 023091F6
	ldr r0,[pool_023092A0]	; 023091F8
	bl loc_02304B4C	; 023091FA
	add r7,r0,#0x0	; 023091FE
	cmp r4,#0x40	; 02309200
	bcs loc_02309244	; 02309202
	mov r1,#0x1	; 02309204
	lsl r1,r5	; 02309206
	ldr r0,[pool_023092A4]	; 02309208
	ldr r3,[r0,#0x0]	; 0230920A
	ldr r2,[pool_023092A8]	; 0230920C
	add r3,r3,r2	; 0230920E
	ldrh r2,[r3,#0x0]	; 02309210
	orr r2,r1	; 02309212
	strh r2,[r3,#0x0]	; 02309214
	ldr r3,[r0,#0x0]	; 02309216
	ldr r2,[pool_023092AC]	; 02309218
	add r3,r3,r2	; 0230921A
	ldrh r2,[r3,#0x0]	; 0230921C
	orr r2,r1	; 0230921E
	strh r2,[r3,#0x0]	; 02309220
	ldr r1,[r0,#0x0]	; 02309222
	ldr r0,[pool_023092B0]	; 02309224
	ldrh r0,[r1,r0]	; 02309226
	cmp r0,#0x1	; 02309228
	bne loc_02309282	; 0230922A
	ldr r0,[pool_023092B4]	; 0230922C
	ldr r2,[r1,r0]	; 0230922E
	mov r0,#0x1c	; 02309230
	add r1,r5,#0x0	; 02309232
	mul r1,r0	; 02309234
	ldrh r0,[r2,r1]	; 02309236
	cmp r0,#0x40	; 02309238
	bne loc_02309282	; 0230923A
	add r0,r5,#0x0	; 0230923C
	bl loc_023090A4	; 0230923E
	b loc_02309282	; 02309242
loc_02309244:
	mov r0,#0x1	; 02309244
	lsl r0,r5	; 02309246
	mvn r6,r0	; 02309248
	ldr r3,[pool_023092A4]	; 0230924A
	ldr r2,[r3,#0x0]	; 0230924C
	ldr r1,[pool_023092AC]	; 0230924E
	add r2,r2,r1	; 02309250
	ldrh r1,[r2,#0x0]	; 02309252
	bic r1,r0	; 02309254
	strh r1,[r2,#0x0]	; 02309256
	ldr r3,[r3,#0x0]	; 02309258
	ldr r0,[pool_023092B8]	; 0230925A
	ldrh r1,[r3,r0]	; 0230925C
	asr r1,r5	; 0230925E
	mov r0,#0x1	; 02309260
	and r1,r0	; 02309262
	cmp r1,#0x0	; 02309264
	beq loc_02309282	; 02309266
	ldr r0,[pool_023092B4]	; 02309268
	ldr r2,[r3,r0]	; 0230926A
	mov r0,#0x1c	; 0230926C
	add r1,r5,#0x0	; 0230926E
	mul r1,r0	; 02309270
	ldrh r0,[r2,r1]	; 02309272
	cmp r0,#0x40	; 02309274
	bne loc_02309282	; 02309276
	ldr r0,[pool_023092A8]	; 02309278
	add r1,r3,r0	; 0230927A
	ldrh r0,[r1,#0x0]	; 0230927C
	and r0,r6	; 0230927E
	strh r0,[r1,#0x0]	; 02309280
loc_02309282:
	ldr r0,[pool_023092A4]	; 02309282
	ldr r1,[r0,#0x0]	; 02309284
	ldr r0,[pool_023092B4]	; 02309286
	ldr r1,[r1,r0]	; 02309288
	mov r0,#0x1c	; 0230928A
	mul r5,r0	; 0230928C
	strh r4,[r1,r5]	; 0230928E
	add r0,r7,#0x0	; 02309290
	bl loc_02304B5C	; 02309292
	add sp,#0x4	; 02309296
	pop {r4,r5,r6,r7}	; 02309298
	pop {r3}	; 0230929A
	bx r3	; 0230929C
	.byte 0xC0, 0x46	; 023092A0
pool_023092A0:
loc_023092A0:
	.word 0x01000000	; 023092A0
pool_023092A4:
loc_023092A4:
	.word FirmwareWlWorkPointerSlot	; 023092A4
pool_023092A8:
loc_023092A8:
	.word 0x000004EC	; 023092A8
pool_023092AC:
loc_023092AC:
	.word 0x000004EE	; 023092AC
pool_023092B0:
loc_023092B0:
	.word 0x00000314	; 023092B0
pool_023092B4:
loc_023092B4:
	.word 0x000002E0	; 023092B4
pool_023092B8:
loc_023092B8:
	.word 0x000004EA	; 023092B8

; ===== function loc_023092BC =====
loc_023092BC:
	push {r4,r5,r6,lr}	; 023092BC
	ldrh r4,[r0,#0x2]	; 023092BE
	ldr r0,[pool_02309304]	; 023092C0
	ldr r1,[r0,#0x0]	; 023092C2
	ldr r0,[pool_02309308]	; 023092C4
	ldr r2,[r1,r0]	; 023092C6
	mov r0,#0x1c	; 023092C8
	add r1,r4,#0x0	; 023092CA
	mul r1,r0	; 023092CC
	add r5,r2,r1	; 023092CE
	ldr r0,[pool_0230930C]	; 023092D0
	bl loc_02304B4C	; 023092D2
	add r6,r0,#0x0	; 023092D6
	ldr r0,[pool_02309304]	; 023092D8
	ldr r1,[r0,#0x0]	; 023092DA
	ldr r0,[pool_02309310]	; 023092DC
	ldrh r0,[r1,r0]	; 023092DE
	cmp r0,#0x1	; 023092E0
	bne loc_023092F0	; 023092E2
	ldrh r0,[r5,#0x16]	; 023092E4
	cmp r0,#0x1	; 023092E6
	bne loc_023092F0	; 023092E8
	add r0,r4,#0x0	; 023092EA
	bl loc_02308F98	; 023092EC
loc_023092F0:
	add r5,#0x16	; 023092F0
	ldrh r0,[r5,#0x0]	; 023092F2
	sub r0,r0,#0x1	; 023092F4
	strh r0,[r5,#0x0]	; 023092F6
	add r0,r6,#0x0	; 023092F8
	bl loc_02304B5C	; 023092FA
	pop {r4,r5,r6}	; 023092FE
	pop {r3}	; 02309300
	bx r3	; 02309302
pool_02309304:
loc_02309304:
	.word FirmwareWlWorkPointerSlot	; 02309304
pool_02309308:
loc_02309308:
	.word 0x000002E0	; 02309308
pool_0230930C:
loc_0230930C:
	.word 0x01000000	; 0230930C
pool_02309310:
loc_02309310:
	.word 0x00000314	; 02309310

; ===== function loc_02309314 =====
loc_02309314:
	push {r4,r5,r6,lr}	; 02309314
	ldrh r4,[r0,#0x2]	; 02309316
	ldr r0,[pool_02309364]	; 02309318
	ldr r1,[r0,#0x0]	; 0230931A
	ldr r0,[pool_02309368]	; 0230931C
	ldr r2,[r1,r0]	; 0230931E
	mov r0,#0x1c	; 02309320
	add r1,r4,#0x0	; 02309322
	mul r1,r0	; 02309324
	add r5,r2,r1	; 02309326
	ldr r0,[pool_0230936C]	; 02309328
	bl loc_02304B4C	; 0230932A
	add r6,r0,#0x0	; 0230932E
	ldr r0,[pool_02309364]	; 02309330
	ldr r1,[r0,#0x0]	; 02309332
	ldr r0,[pool_02309370]	; 02309334
	ldrh r0,[r1,r0]	; 02309336
	cmp r0,#0x1	; 02309338
	bne loc_02309348	; 0230933A
	ldrh r0,[r5,#0x16]	; 0230933C
	cmp r0,#0x0	; 0230933E
	bne loc_02309348	; 02309340
	add r0,r4,#0x0	; 02309342
	bl loc_02309020	; 02309344
loc_02309348:
	add r1,r5,#0x0	; 02309348
	add r1,#0x16	; 0230934A
	ldrh r0,[r1,#0x0]	; 0230934C
	add r0,r0,#0x1	; 0230934E
	strh r0,[r1,#0x0]	; 02309350
	add r0,r6,#0x0	; 02309352
	bl loc_02304B5C	; 02309354
	ldrh r0,[r5,#0x1a]	; 02309358
	strh r0,[r5,#0x18]	; 0230935A
	pop {r4,r5,r6}	; 0230935C
	pop {r3}	; 0230935E
	bx r3	; 02309360
	.byte 0xC0, 0x46	; 02309364
pool_02309364:
loc_02309364:
	.word FirmwareWlWorkPointerSlot	; 02309364
pool_02309368:
loc_02309368:
	.word 0x000002E0	; 02309368
pool_0230936C:
loc_0230936C:
	.word 0x01000000	; 0230936C
pool_02309370:
loc_02309370:
	.word 0x00000314	; 02309370
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x0D, 0x48, 0xFB, 0xF7, 0xE6, 0xFB, 0x06, 0x1C, 0x0C, 0x48	; 02309384
	.byte 0x01, 0x68, 0x0C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x02, 0xD1, 0x00, 0x20, 0xFF, 0xF7, 0x46, 0xFE	; 02309394
	.byte 0x28, 0x1C, 0x07, 0x49, 0x0A, 0x68, 0x08, 0x49, 0x51, 0x18, 0x22, 0x1C, 0xFB, 0xF7, 0x04, 0xFE	; 023093A4
	.byte 0x30, 0x1C, 0xFB, 0xF7, 0xD9, 0xFB, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x00, 0x01	; 023093B4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x78, 0x01, 0x00, 0x00, 0x70, 0x01, 0x00, 0x00	; 023093C0

; ===== function loc_023093C0 =====
loc_023093C0:
	push {r4,r5,r6,r7,lr}	; 023093C0
	sub sp,#0xc	; 023093C2
	add r5,r0,#0x0	; 023093C4
	ldrh r0,[r5,#0x0]	; 023093C6
	str r0,[sp,#0x4]	; 023093C8
	mov r4,#0x1	; 023093CA
	and r0,r4	; 023093CC
	cmp r0,#0x0	; 023093CE
	beq loc_023093D6	; 023093D0
	mov r0,#0x0	; 023093D2
	b loc_02309482	; 023093D4
loc_023093D6:
	ldr r0,[pool_0230948C]	; 023093D6
	ldr r0,[r0,#0x0]	; 023093D8
	ldr r1,[pool_02309490]	; 023093DA
	ldrh r1,[r0,r1]	; 023093DC
	str r1,[sp,#0x8]	; 023093DE
	cmp r1,#0x1	; 023093E0
	bls loc_02309438	; 023093E2
	ldr r1,[pool_02309494]	; 023093E4
	ldr r2,[r0,r1]	; 023093E6
	add r2,#0x1c	; 023093E8
	mov r1,#0x0	; 023093EA
	add r7,r1,#0x0	; 023093EC
	ldr r3,[pool_02309498]	; 023093EE
	ldrh r3,[r0,r3]	; 023093F0
	str r3,[sp,#0x0]	; 023093F2
	b loc_0230942C	; 023093F4
loc_023093F6:
	ldrh r3,[r2,#0x0]	; 023093F6
	cmp r3,#0x0	; 023093F8
	beq loc_02309422	; 023093FA
	ldrh r6,[r2,#0x8]	; 023093FC
	ldrh r3,[r5,#0x4]	; 023093FE
	cmp r6,r3	; 02309400
	bne loc_02309418	; 02309402
	ldrh r6,[r2,#0x6]	; 02309404
	ldrh r3,[r5,#0x2]	; 02309406
	cmp r6,r3	; 02309408
	bne loc_02309418	; 0230940A
	ldrh r6,[r2,#0x4]	; 0230940C
	ldr r3,[sp,#0x4]	; 0230940E
	cmp r6,r3	; 02309410
	bne loc_02309418	; 02309412
	add r0,r4,#0x0	; 02309414
	b loc_02309482	; 02309416
loc_02309418:
	add r7,r7,#0x1	; 02309418
	ldr r3,[sp,#0x8]	; 0230941A
	cmp r7,r3	; 0230941C
	bcc loc_02309428	; 0230941E
	b loc_02309432	; 02309420
loc_02309422:
	cmp r1,#0x0	; 02309422
	bne loc_02309428	; 02309424
	add r1,r4,#0x0	; 02309426
loc_02309428:
	add r4,r4,#0x1	; 02309428
	add r2,#0x1c	; 0230942A
loc_0230942C:
	ldr r3,[sp,#0x0]	; 0230942C
	cmp r4,r3	; 0230942E
	bcc loc_023093F6	; 02309430
loc_02309432:
	cmp r1,#0x0	; 02309432
	beq loc_02309438	; 02309434
	add r4,r1,#0x0	; 02309436
loc_02309438:
	ldr r1,[pool_02309498]	; 02309438
	ldrh r2,[r0,r1]	; 0230943A
	cmp r4,r2	; 0230943C
	bcc loc_02309478	; 0230943E
	ldr r1,[pool_02309494]	; 02309440
	ldr r7,[r0,r1]	; 02309442
	ldr r3,[pool_0230949C]	; 02309444
	mov r1,#0x1	; 02309446
	mov r4,#0x0	; 02309448
	b loc_0230946C	; 0230944A
loc_0230944C:
	add r6,r1,#0x0	; 0230944C
	mov r0,#0x1c	; 0230944E
	mul r6,r0	; 02309450
	add r0,r7,r6	; 02309452
	ldrh r6,[r7,r6]	; 02309454
	cmp r6,#0x30	; 02309456
	bcs loc_0230946A	; 02309458
	ldrh r6,[r0,#0x16]	; 0230945A
	cmp r6,#0x0	; 0230945C
	bne loc_0230946A	; 0230945E
	ldrh r0,[r0,#0x18]	; 02309460
	cmp r3,r0	; 02309462
	bls loc_0230946A	; 02309464
	add r3,r0,#0x0	; 02309466
	add r4,r1,#0x0	; 02309468
loc_0230946A:
	add r1,r1,#0x1	; 0230946A
loc_0230946C:
	cmp r1,r2	; 0230946C
	bcc loc_0230944C	; 0230946E
	cmp r4,#0x0	; 02309470
	bne loc_02309478	; 02309472
	mov r0,#0xff	; 02309474
	b loc_02309482	; 02309476
loc_02309478:
	add r0,r4,#0x0	; 02309478
	add r1,r5,#0x0	; 0230947A
	bl loc_02308CD4	; 0230947C
	add r0,r4,#0x0	; 02309480
loc_02309482:
	add sp,#0xc	; 02309482
	pop {r4,r5,r6,r7}	; 02309484
	pop {r3}	; 02309486
	bx r3	; 02309488
	.byte 0xC0, 0x46	; 0230948C
pool_0230948C:
loc_0230948C:
	.word FirmwareWlWorkPointerSlot	; 0230948C
pool_02309490:
loc_02309490:
	.word 0x000004E8	; 02309490
pool_02309494:
loc_02309494:
	.word 0x000002E0	; 02309494
pool_02309498:
loc_02309498:
	.word 0x000002E6	; 02309498
pool_0230949C:
loc_0230949C:
	.word 0x00010000	; 0230949C

; ===== function loc_023094A0 =====
loc_023094A0:
	push {r4,r5,r6,r7,lr}	; 023094A0
	sub sp,#0x4	; 023094A2
	add r4,r0,#0x0	; 023094A4
	ldrh r0,[r4,#0x0]	; 023094A6
	str r0,[sp,#0x0]	; 023094A8
	mov r2,#0x1	; 023094AA
	and r0,r2	; 023094AC
	cmp r0,#0x0	; 023094AE
	beq loc_023094B6	; 023094B0
	mov r0,#0x0	; 023094B2
	b loc_02309502	; 023094B4
loc_023094B6:
	ldr r0,[pool_0230950C]	; 023094B6
	ldr r0,[r0,#0x0]	; 023094B8
	ldr r1,[pool_02309510]	; 023094BA
	ldrh r7,[r0,r1]	; 023094BC
	cmp r7,#0x1	; 023094BE
	bls loc_02309500	; 023094C0
	ldr r1,[pool_02309514]	; 023094C2
	ldr r3,[r0,r1]	; 023094C4
	add r3,#0x1c	; 023094C6
	mov r1,#0x0	; 023094C8
	ldr r5,[pool_02309518]	; 023094CA
	ldrh r0,[r0,r5]	; 023094CC
	b loc_023094FC	; 023094CE
loc_023094D0:
	ldrh r5,[r3,#0x0]	; 023094D0
	cmp r5,#0x0	; 023094D2
	beq loc_023094F8	; 023094D4
	ldrh r6,[r3,#0x8]	; 023094D6
	ldrh r5,[r4,#0x4]	; 023094D8
	cmp r6,r5	; 023094DA
	bne loc_023094F2	; 023094DC
	ldrh r6,[r3,#0x6]	; 023094DE
	ldrh r5,[r4,#0x2]	; 023094E0
	cmp r6,r5	; 023094E2
	bne loc_023094F2	; 023094E4
	ldrh r6,[r3,#0x4]	; 023094E6
	ldr r5,[sp,#0x0]	; 023094E8
	cmp r6,r5	; 023094EA
	bne loc_023094F2	; 023094EC
	add r0,r2,#0x0	; 023094EE
	b loc_02309502	; 023094F0
loc_023094F2:
	add r1,r1,#0x1	; 023094F2
	cmp r1,r7	; 023094F4
	bcs loc_02309500	; 023094F6
loc_023094F8:
	add r2,r2,#0x1	; 023094F8
	add r3,#0x1c	; 023094FA
loc_023094FC:
	cmp r2,r0	; 023094FC
	bcc loc_023094D0	; 023094FE
loc_02309500:
	mov r0,#0xff	; 02309500
loc_02309502:
	add sp,#0x4	; 02309502
	pop {r4,r5,r6,r7}	; 02309504
	pop {r3}	; 02309506
	bx r3	; 02309508
	.byte 0xC0, 0x46	; 0230950C
pool_0230950C:
loc_0230950C:
	.word FirmwareWlWorkPointerSlot	; 0230950C
pool_02309510:
loc_02309510:
	.word 0x000004E8	; 02309510
pool_02309514:
loc_02309514:
	.word 0x000002E0	; 02309514
pool_02309518:
loc_02309518:
	.word 0x000002E6	; 02309518

; ===== function loc_0230951C =====
loc_0230951C:
	mov r2,#0x0	; 0230951C
	ldr r0,[pool_02309528]	; 0230951E
	ldr r1,[r0,#0x0]	; 02309520
	ldr r0,[pool_0230952C]	; 02309522
	strh r2,[r1,r0]	; 02309524
	bx lr	; 02309526
pool_02309528:
loc_02309528:
	.word FirmwareWlWorkPointerSlot	; 02309528
pool_0230952C:
loc_0230952C:
	.word 0x000003E0	; 0230952C

; ===== function loc_02309530 =====
	push {r4,r5,r6,r7,lr}	; 02309530
	sub sp,#0x4	; 02309532
	ldr r4,[pool_0230956C]	; 02309534
	ldr r1,[r4,#0x0]	; 02309536
	ldr r6,[pool_02309570]	; 02309538
	ldr r5,[r1,r6]	; 0230953A
	mov r7,#0x0	; 0230953C
	b loc_0230955E	; 0230953E
loc_02309540:
	ldr r0,[pool_02309574]	; 02309540
	ldr r0,[r1,r0]	; 02309542
	add r1,r5,#0x0	; 02309544
	add r2,r7,#0x0	; 02309546
	bl loc_02300824	; 02309548
	cmp r0,#0x0	; 0230954C
	beq loc_02309564	; 0230954E
	ldr r0,[r4,#0x0]	; 02309550
	add r0,r0,r6	; 02309552
	add r1,r5,#0x0	; 02309554
	bl loc_02304E64	; 02309556
	ldr r1,[r4,#0x0]	; 0230955A
	ldr r5,[r1,r6]	; 0230955C
loc_0230955E:
	mvn r0,r7	; 0230955E
	cmp r5,r0	; 02309560
	bne loc_02309540	; 02309562
loc_02309564:
	add sp,#0x4	; 02309564
	pop {r4,r5,r6,r7}	; 02309566
	pop {r3}	; 02309568
	bx r3	; 0230956A
pool_0230956C:
loc_0230956C:
	.word FirmwareWlWorkPointerSlot	; 0230956C
pool_02309570:
loc_02309570:
	.word 0x000001B8	; 02309570
pool_02309574:
loc_02309574:
	.word 0x000002C8	; 02309574

; ===== function loc_02309578 =====
loc_02309578:
	push {r4,r5,lr}	; 02309578
	sub sp,#0x4	; 0230957A
	add r5,r0,#0x0	; 0230957C
	add r4,r1,#0x0	; 0230957E
	ldr r2,[pool_023095D0]	; 02309580
	ldr r2,[r2,#0x0]	; 02309582
	ldr r3,[pool_023095D4]	; 02309584
	ldrh r3,[r2,r3]	; 02309586
	cmp r3,#0x0	; 02309588
	beq loc_023095A0	; 0230958A
	ldr r1,[pool_023095D8]	; 0230958C
	add r1,r2,r1	; 0230958E
	add r2,r4,#0x0	; 02309590
	bl loc_02304FAC	; 02309592
	mov r0,#0x2	; 02309596
	mov r1,#0x13	; 02309598
	bl loc_02304B6C	; 0230959A
	b loc_023095C8	; 0230959E
loc_023095A0:
	ldr r0,[pool_023095DC]	; 023095A0
	ldr r0,[r2,r0]	; 023095A2
	mov r2,#0x0	; 023095A4
	bl loc_02300824	; 023095A6
	cmp r0,#0x0	; 023095AA
	beq loc_023095B8	; 023095AC
	add r0,r5,#0x0	; 023095AE
	add r1,r4,#0x0	; 023095B0
	bl loc_02304E64	; 023095B2
	b loc_023095C8	; 023095B6
loc_023095B8:
	add r0,r5,#0x0	; 023095B8
	ldr r1,[pool_023095D0]	; 023095BA
	ldr r2,[r1,#0x0]	; 023095BC
	ldr r1,[pool_023095D8]	; 023095BE
	add r1,r2,r1	; 023095C0
	add r2,r4,#0x0	; 023095C2
	bl loc_02304FAC	; 023095C4
loc_023095C8:
	add sp,#0x4	; 023095C8
	pop {r4,r5}	; 023095CA
	pop {r3}	; 023095CC
	bx r3	; 023095CE
pool_023095D0:
loc_023095D0:
	.word FirmwareWlWorkPointerSlot	; 023095D0
pool_023095D4:
loc_023095D4:
	.word 0x000001C0	; 023095D4
pool_023095D8:
loc_023095D8:
	.word 0x000001B8	; 023095D8
pool_023095DC:
loc_023095DC:
	.word 0x000002C8	; 023095DC
	.byte 0x03, 0x20, 0x70, 0x47	; 023095E4

; ===== function loc_023095E4 =====
	push {r4,r5,r6,r7,lr}	; 023095E4
	sub sp,#0xc	; 023095E6
	mov r6,#0x0	; 023095E8
	add r5,r6,#0x0	; 023095EA
	ldr r1,[pool_023097B8]	; 023095EC
	ldr r0,[r1,#0x0]	; 023095EE
	ldr r2,[pool_023097BC]	; 023095F0
	ldrh r2,[r0,r2]	; 023095F2
	cmp r2,#0x0	; 023095F4
	beq loc_023095FA	; 023095F6
	b loc_023097AE	; 023095F8
loc_023095FA:
	ldr r2,[pool_023097C0]	; 023095FA
	ldr r3,[r0,r2]	; 023095FC
	ldr r2,[pool_023097C4]	; 023095FE
	str r3,[r0,r2]	; 02309600
	ldr r3,[r1,#0x0]	; 02309602
	ldr r0,[r3,r2]	; 02309604
	str r0,[sp,#0x0]	; 02309606
	mvn r1,r6	; 02309608
	cmp r0,r1	; 0230960A
	bne loc_02309610	; 0230960C
	b loc_023097AE	; 0230960E
loc_02309610:
	ldrh r0,[r0,#0xe]	; 02309610
	lsl r1,r0,#0x1	; 02309612
	ldr r0,[sp,#0x0]	; 02309614
	add r4,r0,r1	; 02309616
	add r4,#0x10	; 02309618
	ldr r0,[pool_023097C8]	; 0230961A
	ldrh r0,[r3,r0]	; 0230961C
	cmp r0,#0x0	; 0230961E
	beq loc_0230962C	; 02309620
	mov r0,#0x1	; 02309622
	strh r0,[r4,#0x2]	; 02309624
	mov r0,#0x6	; 02309626
	strh r0,[r4,#0x4]	; 02309628
	b loc_0230977E	; 0230962A
loc_0230962C:
	ldr r0,[sp,#0x0]	; 0230962C
	ldrh r1,[r0,#0xc]	; 0230962E
	ldrh r0,[r4,#0x0]	; 02309630
	cmp r1,r0	; 02309632
	beq loc_0230963C	; 02309634
	mov r0,#0xd	; 02309636
	strh r0,[r4,#0x4]	; 02309638
	b loc_0230977E	; 0230963A
loc_0230963C:
	ldr r2,[pool_023097CC]	; 0230963C
	add r0,r1,#0x0	; 0230963E
	and r0,r2	; 02309640
	ldr r2,[pool_023097D0]	; 02309642
	cmp r0,r2	; 02309644
	bgt loc_02309652	; 02309646
	cmp r0,r2	; 02309648
	bge loc_0230968E	; 0230964A
	cmp r0,#0x0	; 0230964C
	beq loc_02309666	; 0230964E
	b loc_02309714	; 02309650
loc_02309652:
	ldr r2,[pool_023097D4]	; 02309652
	cmp r0,r2	; 02309654
	bgt loc_0230965E	; 02309656
	cmp r0,r2	; 02309658
	beq loc_023096A8	; 0230965A
	b loc_02309714	; 0230965C
loc_0230965E:
	ldr r2,[pool_023097D8]	; 0230965E
	cmp r0,r2	; 02309660
	beq loc_02309704	; 02309662
	b loc_02309714	; 02309664
loc_02309666:
	mov r5,#0x1	; 02309666
	ldr r7,[pool_023097DC]	; 02309668
	mov r0,#0xff	; 0230966A
	and r1,r0	; 0230966C
	lsl r0,r1,#0x10	; 0230966E
	lsr r2,r0,#0x10	; 02309670
	mov r0,#0xb	; 02309672
	ldr r1,[pool_023097BC]	; 02309674
	ldrh r1,[r3,r1]	; 02309676
	and r1,r5	; 02309678
	cmp r1,#0x0	; 0230967A
	beq loc_02309682	; 0230967C
	mov r6,#0x2	; 0230967E
	b loc_02309718	; 02309680
loc_02309682:
	ldr r1,[pool_023097E0]	; 02309682
	ldrh r1,[r3,r1]	; 02309684
	cmp r1,#0x20	; 02309686
	bcs loc_02309718	; 02309688
	add r6,r5,#0x0	; 0230968A
	b loc_02309718	; 0230968C
loc_0230968E:
	mov r5,#0x2	; 0230968E
	ldr r7,[pool_023097E4]	; 02309690
	mov r0,#0xff	; 02309692
	and r1,r0	; 02309694
	lsl r0,r1,#0x10	; 02309696
	lsr r2,r0,#0x10	; 02309698
	mov r0,#0x5	; 0230969A
	ldr r1,[pool_023097E0]	; 0230969C
	ldrh r1,[r3,r1]	; 0230969E
	cmp r1,#0x40	; 023096A0
	beq loc_02309718	; 023096A2
	mov r6,#0x1	; 023096A4
	b loc_02309718	; 023096A6
loc_023096A8:
	mov r0,#0xff	; 023096A8
	and r1,r0	; 023096AA
	lsl r0,r1,#0x10	; 023096AC
	lsr r2,r0,#0x10	; 023096AE
	cmp r2,#0x40	; 023096B0
	bcs loc_023096C6	; 023096B2
	ldr r0,[pool_023097E0]	; 023096B4
	ldrh r0,[r3,r0]	; 023096B6
	cmp r0,#0x10	; 023096B8
	bcs loc_023096BE	; 023096BA
	mov r6,#0x1	; 023096BC
loc_023096BE:
	mov r5,#0x4	; 023096BE
	ldr r7,[pool_023097E8]	; 023096C0
	mov r0,#0x16	; 023096C2
	b loc_02309718	; 023096C4
loc_023096C6:
	cmp r2,#0x80	; 023096C6
	bcs loc_023096E2	; 023096C8
	ldr r0,[pool_023097E0]	; 023096CA
	ldrh r0,[r3,r0]	; 023096CC
	cmp r0,#0x40	; 023096CE
	beq loc_023096D4	; 023096D0
	mov r6,#0x1	; 023096D2
loc_023096D4:
	mov r5,#0x8	; 023096D4
	ldr r7,[pool_023097EC]	; 023096D6
	sub r2,#0x40	; 023096D8
	lsl r0,r2,#0x10	; 023096DA
	lsr r2,r0,#0x10	; 023096DC
	mov r0,#0x6	; 023096DE
	b loc_02309718	; 023096E0
loc_023096E2:
	cmp r2,#0xc0	; 023096E2
	bcs loc_023096FE	; 023096E4
	ldr r0,[pool_023097E0]	; 023096E6
	ldrh r0,[r3,r0]	; 023096E8
	cmp r0,#0x10	; 023096EA
	bcs loc_023096F0	; 023096EC
	mov r6,#0x1	; 023096EE
loc_023096F0:
	mov r5,#0x10	; 023096F0
	ldr r7,[pool_023097F0]	; 023096F2
	sub r2,#0x80	; 023096F4
	lsl r0,r2,#0x10	; 023096F6
	lsr r2,r0,#0x10	; 023096F8
	mov r0,#0x16	; 023096FA
	b loc_02309718	; 023096FC
loc_023096FE:
	mov r2,#0x1	; 023096FE
	add r0,r6,#0x0	; 02309700
	b loc_02309718	; 02309702
loc_02309704:
	mov r5,#0x40	; 02309704
	ldr r7,[pool_023097F4]	; 02309706
	mov r0,#0xff	; 02309708
	and r1,r0	; 0230970A
	lsl r0,r1,#0x10	; 0230970C
	lsr r2,r0,#0x10	; 0230970E
	mov r0,#0xa	; 02309710
	b loc_02309718	; 02309712
loc_02309714:
	mov r2,#0x1	; 02309714
	mov r0,#0x0	; 02309716
loc_02309718:
	cmp r2,r0	; 02309718
	bls loc_02309720	; 0230971A
	mov r6,#0x3	; 0230971C
	b loc_0230973E	; 0230971E
loc_02309720:
	lsl r0,r2,#0x3	; 02309720
	str r0,[sp,#0x4]	; 02309722
	ldr r0,[sp,#0x0]	; 02309724
	ldrh r1,[r0,#0xe]	; 02309726
	ldr r0,[sp,#0x4]	; 02309728
	ldrh r0,[r7,r0]	; 0230972A
	cmp r1,r0	; 0230972C
	bcc loc_0230973C	; 0230972E
	ldrh r1,[r4,#0x2]	; 02309730
	ldr r0,[sp,#0x4]	; 02309732
	add r0,r7,r0	; 02309734
	ldrh r0,[r0,#0x2]	; 02309736
	cmp r1,r0	; 02309738
	bcs loc_0230973E	; 0230973A
loc_0230973C:
	mov r6,#0x4	; 0230973C
loc_0230973E:
	cmp r6,#0x0	; 0230973E
	beq loc_0230974A	; 02309740
	mov r0,#0x1	; 02309742
	strh r0,[r4,#0x2]	; 02309744
	strh r6,[r4,#0x4]	; 02309746
	b loc_0230977E	; 02309748
loc_0230974A:
	ldr r0,[pool_023097BC]	; 0230974A
	add r1,r3,r0	; 0230974C
	ldrh r0,[r1,#0x0]	; 0230974E
	orr r0,r5	; 02309750
	strh r0,[r1,#0x0]	; 02309752
	ldr r0,[sp,#0x0]	; 02309754
	add r1,r4,#0x0	; 02309756
	lsl r2,r2,#0x3	; 02309758
	add r2,r7,r2	; 0230975A
	ldr r2,[r2,#0x4]	; 0230975C
	bl loc_02308C88	; 0230975E
	strh r0,[r4,#0x4]	; 02309762
	ldrh r0,[r4,#0x4]	; 02309764
	cmp r0,#0x80	; 02309766
	beq loc_023097AE	; 02309768
	cmp r0,#0x81	; 0230976A
	bne loc_0230977E	; 0230976C
	ldr r0,[pool_023097B8]	; 0230976E
	ldr r1,[r0,#0x0]	; 02309770
	ldr r0,[pool_023097BC]	; 02309772
	add r1,r1,r0	; 02309774
	ldrh r0,[r1,#0x0]	; 02309776
	bic r0,r5	; 02309778
	strh r0,[r1,#0x0]	; 0230977A
	b loc_0230979A	; 0230977C
loc_0230977E:
	ldr r2,[pool_023097B8]	; 0230977E
	ldr r1,[r2,#0x0]	; 02309780
	ldr r0,[pool_023097BC]	; 02309782
	add r1,r1,r0	; 02309784
	ldrh r0,[r1,#0x0]	; 02309786
	bic r0,r5	; 02309788
	strh r0,[r1,#0x0]	; 0230978A
	ldr r2,[r2,#0x0]	; 0230978C
	ldr r0,[pool_023097C0]	; 0230978E
	add r0,r2,r0	; 02309790
	ldr r1,[pool_023097C4]	; 02309792
	ldr r1,[r2,r1]	; 02309794
	bl loc_02309578	; 02309796
loc_0230979A:
	ldr r0,[pool_023097B8]	; 0230979A
	ldr r1,[r0,#0x0]	; 0230979C
	ldr r0,[pool_023097F8]	; 0230979E
	ldrh r0,[r1,r0]	; 023097A0
	cmp r0,#0x0	; 023097A2
	beq loc_023097AE	; 023097A4
	mov r0,#0x2	; 023097A6
	mov r1,#0xb	; 023097A8
	bl loc_02304B6C	; 023097AA
loc_023097AE:
	add sp,#0xc	; 023097AE
	pop {r4,r5,r6,r7}	; 023097B0
	pop {r3}	; 023097B2
	bx r3	; 023097B4
	.byte 0xC0, 0x46	; 023097B8
pool_023097B8:
loc_023097B8:
	.word FirmwareWlWorkPointerSlot	; 023097B8
pool_023097BC:
loc_023097BC:
	.word 0x000003E0	; 023097BC
pool_023097C0:
loc_023097C0:
	.word 0x000001C4	; 023097C0
pool_023097C4:
loc_023097C4:
	.word 0x000003DC	; 023097C4
pool_023097C8:
loc_023097C8:
	.word 0x00000302	; 023097C8
pool_023097CC:
loc_023097CC:
	.word 0x0000FF00	; 023097CC
pool_023097D0:
loc_023097D0:
	.word 0x00000100	; 023097D0
pool_023097D4:
loc_023097D4:
	.word 0x00000200	; 023097D4
pool_023097D8:
loc_023097D8:
	.word 0x00000300	; 023097D8
pool_023097DC:
loc_023097DC:
	.word 0x023106E4	; 023097DC
pool_023097E0:
loc_023097E0:
	.word 0x00000310	; 023097E0
pool_023097E4:
loc_023097E4:
	.word 0x0231063C	; 023097E4
pool_023097E8:
loc_023097E8:
	.word 0x023107EC	; 023097E8
pool_023097EC:
loc_023097EC:
	.word 0x02310664	; 023097EC
pool_023097F0:
loc_023097F0:
	.word 0x0231073C	; 023097F0
pool_023097F4:
loc_023097F4:
	.word 0x02310694	; 023097F4
pool_023097F8:
loc_023097F8:
	.word 0x000001CC	; 023097F8

; ===== function loc_023097FC =====
loc_023097FC:
	push {lr}	; 023097FC
	sub sp,#0x4	; 023097FE
	mov r1,#0x0	; 02309800
	add r0,sp,#0x0	; 02309802
	strh r1,[r0,#0x0]	; 02309804
	ldrh r0,[r0,#0x0]	; 02309806
	ldr r1,[pool_0230981C]	; 02309808
	ldr r2,[r1,#0x0]	; 0230980A
	ldr r1,[pool_02309820]	; 0230980C
	add r1,r2,r1	; 0230980E
	mov r2,#0x20	; 02309810
	bl loc_02309824	; 02309812
	add sp,#0x4	; 02309816
	pop {r3}	; 02309818
	bx r3	; 0230981A
pool_0230981C:
loc_0230981C:
	.word FirmwareWlWorkPointerSlot	; 0230981C
pool_02309820:
loc_02309820:
	.word 0x000003BC	; 02309820

; ===== function loc_02309824 =====
loc_02309824:
	bx pc	; 02309824
	.byte 0xC0, 0x46	; 02309828
.arm

; ===== function loc_02309828 =====
loc_02309828:
	ldr pc,[pool_0230982C]	; 02309828
pool_0230982C:
loc_0230982C:
	.word loc_037FCE04	; 0230982C
.thumb

; ===== function loc_02309830 =====
loc_02309830:
	push {r4,r5,r6,r7,lr}	; 02309830
	sub sp,#0x4	; 02309832
	add r4,r0,#0x0	; 02309834
	ldr r0,[pool_02309908]	; 02309836
	ldr r2,[r0,#0x0]	; 02309838
	ldr r0,[pool_0230990C]	; 0230983A
	add r0,r2,r0	; 0230983C
	ldr r1,[pool_02309910]	; 0230983E
	ldrh r1,[r2,r1]	; 02309840
	add r1,#0x3e	; 02309842
	bl loc_02305054	; 02309844
	add r5,r0,#0x0	; 02309848
	cmp r5,#0x0	; 0230984A
	bne loc_02309858	; 0230984C
	mov r0,#0x1	; 0230984E
	bl loc_02305134	; 02309850
	mov r0,#0x0	; 02309854
	b loc_023098FE	; 02309856
loc_02309858:
	mov r0,#0x8d	; 02309858
	strh r0,[r5,#0xc]	; 0230985A
	ldr r0,[pool_02309908]	; 0230985C
	ldr r1,[r0,#0x0]	; 0230985E
	ldr r0,[pool_02309910]	; 02309860
	ldrh r0,[r1,r0]	; 02309862
	add r0,r0,#0x1	; 02309864
	mov r1,#0x2	; 02309866
	bl loc_0230991C	; 02309868
	add r0,#0x16	; 0230986C
	strh r0,[r5,#0xe]	; 0230986E
	add r0,r5,#0x0	; 02309870
	add r0,#0x1f	; 02309872
	ldrh r1,[r4,#0x12]	; 02309874
	lsl r1,r1,#0x18	; 02309876
	lsr r1,r1,#0x18	; 02309878
	bl loc_023053DC	; 0230987A
	add r0,r5,#0x0	; 0230987E
	add r0,#0x1e	; 02309880
	ldrh r1,[r4,#0xe]	; 02309882
	lsl r1,r1,#0x18	; 02309884
	lsr r1,r1,#0x18	; 02309886
	bl loc_023053DC	; 02309888
	add r0,r5,#0x0	; 0230988C
	add r0,#0x2e	; 0230988E
	add r4,#0x1e	; 02309890
	add r1,r4,#0x0	; 02309892
	bl loc_0230645C	; 02309894
	ldr r3,[pool_02309908]	; 02309898
	ldr r1,[r3,#0x0]	; 0230989A
	ldr r0,[pool_02309910]	; 0230989C
	ldrh r0,[r1,r0]	; 0230989E
	strh r0,[r5,#0x16]	; 023098A0
	ldrh r2,[r5,#0x16]	; 023098A2
	cmp r2,#0x0	; 023098A4
	beq loc_023098EE	; 023098A6
	ldr r0,[r3,#0x0]	; 023098A8
	ldr r1,[pool_02309914]	; 023098AA
	ldrh r3,[r0,r1]	; 023098AC
	mov r1,#0x1	; 023098AE
	and r3,r1	; 023098B0
	cmp r3,#0x0	; 023098B2
	beq loc_023098E0	; 023098B4
	ldr r1,[pool_02309918]	; 023098B6
	ldr r0,[r0,r1]	; 023098B8
	add r6,r0,#0x1	; 023098BA
	add r7,r5,#0x0	; 023098BC
	add r7,#0x3c	; 023098BE
	mov r4,#0x0	; 023098C0
	b loc_023098D8	; 023098C2
loc_023098C4:
	add r0,r6,#0x0	; 023098C4
	bl loc_023053B8	; 023098C6
	add r1,r0,#0x0	; 023098CA
	add r0,r7,#0x0	; 023098CC
	bl loc_023053DC	; 023098CE
	add r6,r6,#0x1	; 023098D2
	add r7,r7,#0x1	; 023098D4
	add r4,r4,#0x1	; 023098D6
loc_023098D8:
	ldrh r0,[r5,#0x16]	; 023098D8
	cmp r4,r0	; 023098DA
	bcc loc_023098C4	; 023098DC
	b loc_023098EE	; 023098DE
loc_023098E0:
	ldr r1,[pool_02309918]	; 023098E0
	ldr r0,[r0,r1]	; 023098E2
	add r1,r5,#0x0	; 023098E4
	add r1,#0x3c	; 023098E6
	add r2,r2,#0x1	; 023098E8
	bl loc_02309928	; 023098EA
loc_023098EE:
	ldr r0,[pool_02309908]	; 023098EE
	ldr r1,[r0,#0x0]	; 023098F0
	ldr r0,[pool_0230990C]	; 023098F2
	add r0,r1,r0	; 023098F4
	add r1,r5,#0x0	; 023098F6
	bl loc_02309578	; 023098F8
	mov r0,#0x1	; 023098FC
loc_023098FE:
	add sp,#0x4	; 023098FE
	pop {r4,r5,r6,r7}	; 02309900
	pop {r3}	; 02309902
	bx r3	; 02309904
	.byte 0xC0, 0x46	; 02309908
pool_02309908:
loc_02309908:
	.word FirmwareWlWorkPointerSlot	; 02309908
pool_0230990C:
loc_0230990C:
	.word 0x0000014C	; 0230990C
pool_02309910:
loc_02309910:
	.word 0x0000039C	; 02309910
pool_02309914:
loc_02309914:
	.word 0x0000039E	; 02309914
pool_02309918:
loc_02309918:
	.word 0x00000398	; 02309918

; ===== function loc_0230991C =====
loc_0230991C:
	bx pc	; 0230991C
	.byte 0xC0, 0x46	; 02309920
.arm

; ===== function loc_02309920 =====
loc_02309920:
	ldr pc,[pool_02309924]	; 02309920
pool_02309924:
loc_02309924:
	.word loc_03802514	; 02309924
.thumb

; ===== function loc_02309928 =====
loc_02309928:
	bx pc	; 02309928
	.byte 0xC0, 0x46	; 0230992C
.arm

; ===== function loc_0230992C =====
loc_0230992C:
	ldr pc,[pool_02309930]	; 0230992C
pool_02309930:
loc_02309930:
	.word P2_Entry_037FCE1C	; 02309930
.thumb

; ===== function loc_02309934 =====
loc_02309934:
	push {lr}	; 02309934
	sub sp,#0x4	; 02309936
	ldr r0,[pool_02309974]	; 02309938
	ldr r1,[r0,#0x0]	; 0230993A
	ldr r0,[pool_02309978]	; 0230993C
	add r0,r1,r0	; 0230993E
	mov r1,#0x10	; 02309940
	bl loc_02305054	; 02309942
	add r1,r0,#0x0	; 02309946
	cmp r1,#0x0	; 02309948
	bne loc_02309956	; 0230994A
	mov r0,#0x1	; 0230994C
	bl loc_02305134	; 0230994E
	mov r0,#0x0	; 02309952
	b loc_0230996C	; 02309954
loc_02309956:
	mov r0,#0x8c	; 02309956
	strh r0,[r1,#0xc]	; 02309958
	mov r0,#0x0	; 0230995A
	strh r0,[r1,#0xe]	; 0230995C
	ldr r0,[pool_02309974]	; 0230995E
	ldr r2,[r0,#0x0]	; 02309960
	ldr r0,[pool_02309978]	; 02309962
	add r0,r2,r0	; 02309964
	bl loc_02309578	; 02309966
	mov r0,#0x1	; 0230996A
loc_0230996C:
	add sp,#0x4	; 0230996C
	pop {r3}	; 0230996E
	bx r3	; 02309970
	.byte 0xC0, 0x46	; 02309974
pool_02309974:
loc_02309974:
	.word FirmwareWlWorkPointerSlot	; 02309974
pool_02309978:
loc_02309978:
	.word 0x0000014C	; 02309978
loc_0230997C:
	push {r4,r5,lr}	; 0230997C
	sub sp,#0x4	; 0230997E
	add r5,r0,#0x0	; 02309980
	ldr r0,[pool_023099CC]	; 02309982
	ldr r1,[r0,#0x0]	; 02309984
	ldr r0,[pool_023099D0]	; 02309986
	add r0,r1,r0	; 02309988
	mov r1,#0x16	; 0230998A
	bl loc_02305054	; 0230998C
	add r4,r0,#0x0	; 02309990
	cmp r4,#0x0	; 02309992
	bne loc_023099A0	; 02309994
	mov r0,#0x1	; 02309996
	bl loc_02305134	; 02309998
	mov r0,#0x0	; 0230999C
	b loc_023099C2	; 0230999E
loc_023099A0:
	mov r0,#0x8b	; 023099A0
	strh r0,[r4,#0xc]	; 023099A2
	mov r0,#0x3	; 023099A4
	strh r0,[r4,#0xe]	; 023099A6
	add r0,r4,#0x0	; 023099A8
	add r0,#0x10	; 023099AA
	add r1,r5,#0x0	; 023099AC
	bl loc_0230645C	; 023099AE
	ldr r0,[pool_023099CC]	; 023099B2
	ldr r1,[r0,#0x0]	; 023099B4
	ldr r0,[pool_023099D0]	; 023099B6
	add r0,r1,r0	; 023099B8
	add r1,r4,#0x0	; 023099BA
	bl loc_02309578	; 023099BC
	mov r0,#0x1	; 023099C0
loc_023099C2:
	add sp,#0x4	; 023099C2
	pop {r4,r5}	; 023099C4
	pop {r3}	; 023099C6
	bx r3	; 023099C8
	.byte 0xC0, 0x46	; 023099CC
pool_023099CC:
loc_023099CC:
	.word FirmwareWlWorkPointerSlot	; 023099CC
pool_023099D0:
loc_023099D0:
	.word 0x0000014C	; 023099D0

; ===== function loc_023099D4 =====
loc_023099D4:
	push {r4,r5,r6,lr}	; 023099D4
	add r6,r0,#0x0	; 023099D6
	add r5,r1,#0x0	; 023099D8
	ldr r0,[pool_02309A24]	; 023099DA
	ldr r1,[r0,#0x0]	; 023099DC
	ldr r0,[pool_02309A28]	; 023099DE
	add r0,r1,r0	; 023099E0
	mov r1,#0x18	; 023099E2
	bl loc_02305054	; 023099E4
	add r4,r0,#0x0	; 023099E8
	cmp r4,#0x0	; 023099EA
	bne loc_023099F8	; 023099EC
	mov r0,#0x1	; 023099EE
	bl loc_02305134	; 023099F0
	mov r0,#0x0	; 023099F4
	b loc_02309A1C	; 023099F6
loc_023099F8:
	mov r0,#0x88	; 023099F8
	strh r0,[r4,#0xc]	; 023099FA
	mov r0,#0x4	; 023099FC
	strh r0,[r4,#0xe]	; 023099FE
	add r0,r4,#0x0	; 02309A00
	add r0,#0x10	; 02309A02
	add r1,r6,#0x0	; 02309A04
	bl loc_0230645C	; 02309A06
	strh r5,[r4,#0x16]	; 02309A0A
	ldr r0,[pool_02309A24]	; 02309A0C
	ldr r1,[r0,#0x0]	; 02309A0E
	ldr r0,[pool_02309A28]	; 02309A10
	add r0,r1,r0	; 02309A12
	add r1,r4,#0x0	; 02309A14
	bl loc_02309578	; 02309A16
	mov r0,#0x1	; 02309A1A
loc_02309A1C:
	pop {r4,r5,r6}	; 02309A1C
	pop {r3}	; 02309A1E
	bx r3	; 02309A20
	.byte 0xC0, 0x46	; 02309A24
pool_02309A24:
loc_02309A24:
	.word FirmwareWlWorkPointerSlot	; 02309A24
pool_02309A28:
loc_02309A28:
	.word 0x0000014C	; 02309A28

; ===== function loc_02309A2C =====
loc_02309A2C:
	push {r4,r5,r6,r7,lr}	; 02309A2C
	sub sp,#0x4	; 02309A2E
	add r7,r0,#0x0	; 02309A30
	add r4,r1,#0x0	; 02309A32
	add r6,r2,#0x0	; 02309A34
	ldr r0,[pool_02309AC0]	; 02309A36
	ldr r1,[r0,#0x0]	; 02309A38
	ldr r0,[pool_02309AC4]	; 02309A3A
	add r0,r1,r0	; 02309A3C
	mov r1,#0x3a	; 02309A3E
	bl loc_02305054	; 02309A40
	add r5,r0,#0x0	; 02309A44
	cmp r5,#0x0	; 02309A46
	bne loc_02309A54	; 02309A48
	mov r0,#0x1	; 02309A4A
	bl loc_02305134	; 02309A4C
	mov r0,#0x0	; 02309A50
	b loc_02309AB8	; 02309A52
loc_02309A54:
	mov r0,#0x87	; 02309A54
	strh r0,[r5,#0xc]	; 02309A56
	mov r0,#0x15	; 02309A58
	strh r0,[r5,#0xe]	; 02309A5A
	add r0,r5,#0x0	; 02309A5C
	add r0,#0x10	; 02309A5E
	add r1,r7,#0x0	; 02309A60
	bl loc_0230645C	; 02309A62
	strh r4,[r5,#0x16]	; 02309A66
	add r0,r6,#0x1	; 02309A68
	bl loc_023053B8	; 02309A6A
	strh r0,[r5,#0x18]	; 02309A6E
	mov r4,#0x0	; 02309A70
	add r6,r6,#0x2	; 02309A72
	add r7,r5,#0x0	; 02309A74
	add r7,#0x1a	; 02309A76
	b loc_02309A8E	; 02309A78
loc_02309A7A:
	cmp r4,#0x20	; 02309A7A
	bcs loc_02309AA4	; 02309A7C
	add r0,r6,r4	; 02309A7E
	bl loc_023053B8	; 02309A80
	add r1,r0,#0x0	; 02309A84
	add r0,r7,r4	; 02309A86
	bl loc_023053DC	; 02309A88
	add r4,r4,#0x1	; 02309A8C
loc_02309A8E:
	ldrh r0,[r5,#0x18]	; 02309A8E
	cmp r4,r0	; 02309A90
	bcc loc_02309A7A	; 02309A92
	b loc_02309AA4	; 02309A94
loc_02309A96:
	add r0,r5,#0x0	; 02309A96
	add r0,#0x1a	; 02309A98
	add r0,r0,r4	; 02309A9A
	mov r1,#0x0	; 02309A9C
	bl loc_023053DC	; 02309A9E
	add r4,r4,#0x1	; 02309AA2
loc_02309AA4:
	cmp r4,#0x20	; 02309AA4
	bcc loc_02309A96	; 02309AA6
	ldr r0,[pool_02309AC0]	; 02309AA8
	ldr r1,[r0,#0x0]	; 02309AAA
	ldr r0,[pool_02309AC4]	; 02309AAC
	add r0,r1,r0	; 02309AAE
	add r1,r5,#0x0	; 02309AB0
	bl loc_02309578	; 02309AB2
	mov r0,#0x1	; 02309AB6
loc_02309AB8:
	add sp,#0x4	; 02309AB8
	pop {r4,r5,r6,r7}	; 02309ABA
	pop {r3}	; 02309ABC
	bx r3	; 02309ABE
pool_02309AC0:
loc_02309AC0:
	.word FirmwareWlWorkPointerSlot	; 02309AC0
pool_02309AC4:
loc_02309AC4:
	.word 0x0000014C	; 02309AC4

; ===== function loc_02309AC8 =====
loc_02309AC8:
	push {r4,r5,r6,r7,lr}	; 02309AC8
	sub sp,#0x4	; 02309ACA
	add r7,r0,#0x0	; 02309ACC
	add r4,r1,#0x0	; 02309ACE
	add r6,r2,#0x0	; 02309AD0
	ldr r0,[pool_02309B60]	; 02309AD2
	ldr r1,[r0,#0x0]	; 02309AD4
	ldr r0,[pool_02309B64]	; 02309AD6
	add r0,r1,r0	; 02309AD8
	mov r1,#0x3a	; 02309ADA
	bl loc_02305054	; 02309ADC
	add r5,r0,#0x0	; 02309AE0
	cmp r5,#0x0	; 02309AE2
	bne loc_02309AF0	; 02309AE4
	mov r0,#0x1	; 02309AE6
	bl loc_02305134	; 02309AE8
	mov r0,#0x0	; 02309AEC
	b loc_02309B58	; 02309AEE
loc_02309AF0:
	mov r0,#0x86	; 02309AF0
	strh r0,[r5,#0xc]	; 02309AF2
	mov r0,#0x15	; 02309AF4
	strh r0,[r5,#0xe]	; 02309AF6
	add r0,r5,#0x0	; 02309AF8
	add r0,#0x10	; 02309AFA
	add r1,r7,#0x0	; 02309AFC
	bl loc_0230645C	; 02309AFE
	ldr r0,[pool_02309B68]	; 02309B02
	and r4,r0	; 02309B04
	strh r4,[r5,#0x16]	; 02309B06
	add r0,r6,#0x1	; 02309B08
	bl loc_023053B8	; 02309B0A
	strh r0,[r5,#0x18]	; 02309B0E
	mov r4,#0x0	; 02309B10
	add r6,r6,#0x2	; 02309B12
	add r7,r5,#0x0	; 02309B14
	add r7,#0x1a	; 02309B16
	b loc_02309B2E	; 02309B18
loc_02309B1A:
	cmp r4,#0x20	; 02309B1A
	bcs loc_02309B44	; 02309B1C
	add r0,r6,r4	; 02309B1E
	bl loc_023053B8	; 02309B20
	add r1,r0,#0x0	; 02309B24
	add r0,r7,r4	; 02309B26
	bl loc_023053DC	; 02309B28
	add r4,r4,#0x1	; 02309B2C
loc_02309B2E:
	ldrh r0,[r5,#0x18]	; 02309B2E
	cmp r4,r0	; 02309B30
	bcc loc_02309B1A	; 02309B32
	b loc_02309B44	; 02309B34
loc_02309B36:
	add r0,r5,#0x0	; 02309B36
	add r0,#0x1a	; 02309B38
	add r0,r0,r4	; 02309B3A
	mov r1,#0x0	; 02309B3C
	bl loc_023053DC	; 02309B3E
	add r4,r4,#0x1	; 02309B42
loc_02309B44:
	cmp r4,#0x20	; 02309B44
	bcc loc_02309B36	; 02309B46
	ldr r0,[pool_02309B60]	; 02309B48
	ldr r1,[r0,#0x0]	; 02309B4A
	ldr r0,[pool_02309B64]	; 02309B4C
	add r0,r1,r0	; 02309B4E
	add r1,r5,#0x0	; 02309B50
	bl loc_02309578	; 02309B52
	mov r0,#0x1	; 02309B56
loc_02309B58:
	add sp,#0x4	; 02309B58
	pop {r4,r5,r6,r7}	; 02309B5A
	pop {r3}	; 02309B5C
	bx r3	; 02309B5E
pool_02309B60:
loc_02309B60:
	.word FirmwareWlWorkPointerSlot	; 02309B60
pool_02309B64:
loc_02309B64:
	.word 0x0000014C	; 02309B64
pool_02309B68:
loc_02309B68:
	.word 0x00000FFF	; 02309B68

; ===== function loc_02309B6C =====
loc_02309B6C:
	push {r4,r5,r6,lr}	; 02309B6C
	add r6,r0,#0x0	; 02309B6E
	add r5,r1,#0x0	; 02309B70
	ldr r0,[pool_02309BBC]	; 02309B72
	ldr r1,[r0,#0x0]	; 02309B74
	ldr r0,[pool_02309BC0]	; 02309B76
	add r0,r1,r0	; 02309B78
	mov r1,#0x18	; 02309B7A
	bl loc_02305054	; 02309B7C
	add r4,r0,#0x0	; 02309B80
	cmp r4,#0x0	; 02309B82
	bne loc_02309B90	; 02309B84
	mov r0,#0x1	; 02309B86
	bl loc_02305134	; 02309B88
	mov r0,#0x0	; 02309B8C
	b loc_02309BB4	; 02309B8E
loc_02309B90:
	mov r0,#0x85	; 02309B90
	strh r0,[r4,#0xc]	; 02309B92
	mov r0,#0x4	; 02309B94
	strh r0,[r4,#0xe]	; 02309B96
	add r0,r4,#0x0	; 02309B98
	add r0,#0x10	; 02309B9A
	add r1,r6,#0x0	; 02309B9C
	bl loc_0230645C	; 02309B9E
	strh r5,[r4,#0x16]	; 02309BA2
	ldr r0,[pool_02309BBC]	; 02309BA4
	ldr r1,[r0,#0x0]	; 02309BA6
	ldr r0,[pool_02309BC0]	; 02309BA8
	add r0,r1,r0	; 02309BAA
	add r1,r4,#0x0	; 02309BAC
	bl loc_02309578	; 02309BAE
	mov r0,#0x1	; 02309BB2
loc_02309BB4:
	pop {r4,r5,r6}	; 02309BB4
	pop {r3}	; 02309BB6
	bx r3	; 02309BB8
	.byte 0xC0, 0x46	; 02309BBC
pool_02309BBC:
loc_02309BBC:
	.word FirmwareWlWorkPointerSlot	; 02309BBC
pool_02309BC0:
loc_02309BC0:
	.word 0x0000014C	; 02309BC0

; ===== function loc_02309BC4 =====
loc_02309BC4:
	push {r4,r5,r6,lr}	; 02309BC4
	add r6,r0,#0x0	; 02309BC6
	add r5,r1,#0x0	; 02309BC8
	ldr r0,[pool_02309C14]	; 02309BCA
	ldr r1,[r0,#0x0]	; 02309BCC
	ldr r0,[pool_02309C18]	; 02309BCE
	add r0,r1,r0	; 02309BD0
	mov r1,#0x18	; 02309BD2
	bl loc_02305054	; 02309BD4
	add r4,r0,#0x0	; 02309BD8
	cmp r4,#0x0	; 02309BDA
	bne loc_02309BE8	; 02309BDC
	mov r0,#0x1	; 02309BDE
	bl loc_02305134	; 02309BE0
	mov r0,#0x0	; 02309BE4
	b loc_02309C0C	; 02309BE6
loc_02309BE8:
	mov r0,#0x84	; 02309BE8
	strh r0,[r4,#0xc]	; 02309BEA
	mov r0,#0x4	; 02309BEC
	strh r0,[r4,#0xe]	; 02309BEE
	add r0,r4,#0x0	; 02309BF0
	add r0,#0x10	; 02309BF2
	add r1,r6,#0x0	; 02309BF4
	bl loc_0230645C	; 02309BF6
	strh r5,[r4,#0x16]	; 02309BFA
	ldr r0,[pool_02309C14]	; 02309BFC
	ldr r1,[r0,#0x0]	; 02309BFE
	ldr r0,[pool_02309C18]	; 02309C00
	add r0,r1,r0	; 02309C02
	add r1,r4,#0x0	; 02309C04
	bl loc_02309578	; 02309C06
	mov r0,#0x1	; 02309C0A
loc_02309C0C:
	pop {r4,r5,r6}	; 02309C0C
	pop {r3}	; 02309C0E
	bx r3	; 02309C10
	.byte 0xC0, 0x46	; 02309C14
pool_02309C14:
loc_02309C14:
	.word FirmwareWlWorkPointerSlot	; 02309C14
pool_02309C18:
loc_02309C18:
	.word 0x0000014C	; 02309C18

; ===== function loc_02309C1C =====
loc_02309C1C:
	push {lr}	; 02309C1C
	sub sp,#0x4	; 02309C1E
	ldr r2,[pool_02309C58]	; 02309C20
	ldr r1,[r2,#0x0]	; 02309C22
	ldr r0,[pool_02309C5C]	; 02309C24
	add r3,r1,r0	; 02309C26
	ldrh r1,[r3,#0x0]	; 02309C28
	mov r0,#0x1	; 02309C2A
	bic r1,r0	; 02309C2C
	strh r1,[r3,#0x0]	; 02309C2E
	ldr r2,[r2,#0x0]	; 02309C30
	ldr r0,[pool_02309C60]	; 02309C32
	add r0,r2,r0	; 02309C34
	ldr r1,[pool_02309C64]	; 02309C36
	ldr r1,[r2,r1]	; 02309C38
	bl loc_02309578	; 02309C3A
	ldr r0,[pool_02309C58]	; 02309C3E
	ldr r1,[r0,#0x0]	; 02309C40
	ldr r0,[pool_02309C68]	; 02309C42
	ldrh r0,[r1,r0]	; 02309C44
	cmp r0,#0x0	; 02309C46
	beq loc_02309C52	; 02309C48
	mov r0,#0x2	; 02309C4A
	mov r1,#0xb	; 02309C4C
	bl loc_02304B6C	; 02309C4E
loc_02309C52:
	add sp,#0x4	; 02309C52
	pop {r3}	; 02309C54
	bx r3	; 02309C56
pool_02309C58:
loc_02309C58:
	.word FirmwareWlWorkPointerSlot	; 02309C58
pool_02309C5C:
loc_02309C5C:
	.word 0x000003E0	; 02309C5C
pool_02309C60:
loc_02309C60:
	.word 0x000001C4	; 02309C60
pool_02309C64:
loc_02309C64:
	.word 0x000003DC	; 02309C64
pool_02309C68:
loc_02309C68:
	.word 0x000001CC	; 02309C68
	ldr r0,[pool_02309C78]	; 02309C6C
	ldr r1,[r0,#0x0]	; 02309C6E
	ldr r0,[pool_02309C7C]	; 02309C70
	add r0,r1,r0	; 02309C72
	ldr r3,[pool_02309C80]	; 02309C74
	bx r3	; 02309C76
pool_02309C78:
loc_02309C78:
	.word FirmwareWlWorkPointerSlot	; 02309C78
pool_02309C7C:
loc_02309C7C:
	.word 0x0000037E	; 02309C7C
pool_02309C80:
loc_02309C80:
	.word loc_0230997C + 1	; 02309C80
P4_Code_02309C84:
	mov r2,#0x83	; 02309C84
	ldr r0,[pool_02309C98]	; 02309C86
	ldr r1,[r0,#0x0]	; 02309C88
	ldr r0,[pool_02309C9C]	; 02309C8A
	strh r2,[r1,r0]	; 02309C8C
	mov r0,#0x2	; 02309C8E
	mov r1,#0x5	; 02309C90
	ldr r3,[pool_02309CA0]	; 02309C92
	bx r3	; 02309C94
	.byte 0xC0, 0x46	; 02309C98
pool_02309C98:
loc_02309C98:
	.word FirmwareWlWorkPointerSlot	; 02309C98
pool_02309C9C:
loc_02309C9C:
	.word 0x000003BC	; 02309C9C
pool_02309CA0:
loc_02309CA0:
	.word loc_02304B6C + 1	; 02309CA0

; ===== function loc_02309CA4 =====
	push {r4,r5,lr}	; 02309CA4
	sub sp,#0x4	; 02309CA6
	ldr r0,[pool_02309E50]	; 02309CA8
	ldr r1,[r0,#0x0]	; 02309CAA
	ldr r0,[pool_02309E54]	; 02309CAC
	add r4,r1,r0	; 02309CAE
	ldrh r0,[r4,#0x0]	; 02309CB0
	sub r0,#0x80	; 02309CB2
	cmp r0,#0x4	; 02309CB4
	bls loc_02309CBA	; 02309CB6
	b loc_02309E3A	; 02309CB8
loc_02309CBA:
	add r0,r0,r0	; 02309CBA
P4_SwitchIndexPC_02309CBA:
	add r0,pc	; 02309CBC
	ldrh r0,[r0,#(P4_SwitchTable_02309CBA - (P4_SwitchIndexPC_02309CBA + 4))]	; 02309CBE
	lsl r0,r0,#0x10	; 02309CC0
	asr r0,r0,#0x10	; 02309CC2
P4_SwitchTargetPC_02309CBA:
	add r0,pc	; 02309CC4
	bx r0	; 02309CC6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02309CBA:
	.halfword (loc_02309CD2 + 1) - (P4_SwitchTargetPC_02309CBA + 4)
	.halfword (loc_02309CFE + 1) - (P4_SwitchTargetPC_02309CBA + 4)
	.halfword (loc_02309D80 + 1) - (P4_SwitchTargetPC_02309CBA + 4)
	.halfword (loc_02309DA0 + 1) - (P4_SwitchTargetPC_02309CBA + 4)
	.halfword (loc_02309DF4 + 1) - (P4_SwitchTargetPC_02309CBA + 4)
P4_SwitchTable_02309CBAEnd:
loc_02309CD2:
	mov r0,#0x0	; 02309CD2
	strh r0,[r4,#0x14]	; 02309CD4
	mov r0,#0x13	; 02309CD6
	bl loc_02305B08	; 02309CD8
	strh r0,[r4,#0xe]	; 02309CDC
	mov r0,#0x35	; 02309CDE
	bl loc_02305B08	; 02309CE0
	strh r0,[r4,#0x10]	; 02309CE4
	ldr r1,[r4,#0x18]	; 02309CE6
	ldrh r0,[r1,#0x12]	; 02309CE8
	ldrh r1,[r1,#0x14]	; 02309CEA
	bl loc_02306EB0	; 02309CEC
	mov r2,#0x4	; 02309CF0
	ldr r0,[pool_02309E50]	; 02309CF2
	ldr r1,[r0,#0x0]	; 02309CF4
	ldr r0,[pool_02309E58]	; 02309CF6
	strh r2,[r1,r0]	; 02309CF8
	mov r0,#0x0	; 02309CFA
	strh r0,[r4,#0x16]	; 02309CFC
loc_02309CFE:
	mov r3,#0x0	; 02309CFE
	ldr r2,[pool_02309E50]	; 02309D00
	ldr r1,[r2,#0x0]	; 02309D02
	ldr r0,[pool_02309E5C]	; 02309D04
	str r3,[r1,r0]	; 02309D06
	ldr r1,[r2,#0x0]	; 02309D08
	ldr r0,[pool_02309E60]	; 02309D0A
	str r3,[r1,r0]	; 02309D0C
	ldr r1,[r4,#0x18]	; 02309D0E
	add r1,#0x18	; 02309D10
	ldrh r0,[r4,#0x14]	; 02309D12
	add r0,r1,r0	; 02309D14
	bl loc_023053B8	; 02309D16
	add r5,r0,#0x0	; 02309D1A
	cmp r5,#0x0	; 02309D1C
	beq loc_02309D26	; 02309D1E
	ldrh r0,[r4,#0x14]	; 02309D20
	cmp r0,#0x10	; 02309D22
	bcc loc_02309D2C	; 02309D24
loc_02309D26:
	mov r0,#0x84	; 02309D26
	strh r0,[r4,#0x0]	; 02309D28
	b loc_02309E3A	; 02309D2A
loc_02309D2C:
	mov r0,#0x0	; 02309D2C
	bl loc_02310210	; 02309D2E
	cmp r0,#0x0	; 02309D32
	beq loc_02309D46	; 02309D34
	mov r0,#0xe	; 02309D36
	strh r0,[r4,#0x16]	; 02309D38
	mov r2,#0x84	; 02309D3A
	ldr r0,[pool_02309E50]	; 02309D3C
	ldr r1,[r0,#0x0]	; 02309D3E
	ldr r0,[pool_02309E54]	; 02309D40
	strh r2,[r1,r0]	; 02309D42
	b loc_02309E3A	; 02309D44
loc_02309D46:
	ldrh r0,[r4,#0x0]	; 02309D46
	cmp r0,#0x80	; 02309D48
	bne loc_02309D68	; 02309D4A
	lsl r0,r5,#0x10	; 02309D4C
	lsr r0,r0,#0x10	; 02309D4E
	mov r1,#0x0	; 02309D50
	bl loc_02306948	; 02309D52
	bl loc_02305BF0	; 02309D56
	ldr r0,[pool_02309E64]	; 02309D5A
	ldrh r0,[r0,#0x0]	; 02309D5C
	strh r0,[r4,#0xc]	; 02309D5E
	ldr r0,[pool_02309E68]	; 02309D60
	bl loc_02306808	; 02309D62
	b loc_02309D72	; 02309D66
loc_02309D68:
	lsl r0,r5,#0x10	; 02309D68
	lsr r0,r0,#0x10	; 02309D6A
	mov r1,#0x0	; 02309D6C
	bl loc_02306948	; 02309D6E
loc_02309D72:
	mov r0,#0x82	; 02309D72
	strh r0,[r4,#0x0]	; 02309D74
	ldr r0,[r4,#0x18]	; 02309D76
	ldrh r0,[r0,#0x16]	; 02309D78
	ldr r1,[pool_02309E6C]	; 02309D7A
	bl loc_023055F8	; 02309D7C
loc_02309D80:
	add r1,r4,#0x4	; 02309D80
	ldr r0,[r1,#0x0]	; 02309D82
	add r0,r0,#0x1	; 02309D84
	str r0,[r1,#0x0]	; 02309D86
	ldr r0,[pool_02309E70]	; 02309D88
	ldrh r1,[r0,#0x0]	; 02309D8A
	mov r0,#0x1	; 02309D8C
	and r1,r0	; 02309D8E
	cmp r1,#0x0	; 02309D90
	beq loc_02309E3A	; 02309D92
	add r1,r4,#0x0	; 02309D94
	add r1,#0x8	; 02309D96
	ldr r0,[r1,#0x0]	; 02309D98
	add r0,#0x64	; 02309D9A
	str r0,[r1,#0x0]	; 02309D9C
	b loc_02309E3A	; 02309D9E
loc_02309DA0:
	ldr r1,[r4,#0x18]	; 02309DA0
	add r1,#0x18	; 02309DA2
	ldrh r0,[r4,#0x14]	; 02309DA4
	add r0,r1,r0	; 02309DA6
	bl loc_023053B8	; 02309DA8
	add r5,r0,#0x0	; 02309DAC
	ldr r1,[r4,#0x4]	; 02309DAE
	cmp r1,#0x0	; 02309DB0
	beq loc_02309DDA	; 02309DB2
	ldr r0,[r4,#0x8]	; 02309DB4
	cmp r0,#0x0	; 02309DB6
	beq loc_02309DC8	; 02309DB8
	bl loc_02309E78	; 02309DBA
	add r0,r0,#0x1	; 02309DBE
	cmp r0,#0x64	; 02309DC0
	bls loc_02309DCA	; 02309DC2
	mov r0,#0x64	; 02309DC4
	b loc_02309DCA	; 02309DC6
loc_02309DC8:
	mov r0,#0x0	; 02309DC8
loc_02309DCA:
	lsl r0,r0,#0x8	; 02309DCA
	orr r5,r0	; 02309DCC
	ldr r1,[r4,#0x1c]	; 02309DCE
	ldrh r0,[r4,#0x14]	; 02309DD0
	lsl r0,r0,#0x1	; 02309DD2
	add r0,r1,r0	; 02309DD4
	strh r5,[r0,#0x8]	; 02309DD6
	b loc_02309DE4	; 02309DD8
loc_02309DDA:
	ldr r1,[r4,#0x1c]	; 02309DDA
	ldrh r0,[r4,#0x14]	; 02309DDC
	lsl r0,r0,#0x1	; 02309DDE
	add r0,r1,r0	; 02309DE0
	strh r5,[r0,#0x8]	; 02309DE2
loc_02309DE4:
	add r1,r4,#0x0	; 02309DE4
	add r1,#0x14	; 02309DE6
	ldrh r0,[r1,#0x0]	; 02309DE8
	add r0,r0,#0x1	; 02309DEA
	strh r0,[r1,#0x0]	; 02309DEC
	mov r0,#0x81	; 02309DEE
	strh r0,[r4,#0x0]	; 02309DF0
	b loc_02309E3A	; 02309DF2
loc_02309DF4:
	bl loc_02305B40	; 02309DF4
	ldr r0,[pool_02309E50]	; 02309DF8
	ldr r2,[r0,#0x0]	; 02309DFA
	ldr r0,[pool_02309E74]	; 02309DFC
	ldrh r1,[r2,r0]	; 02309DFE
	ldr r0,[pool_02309E58]	; 02309E00
	strh r1,[r2,r0]	; 02309E02
	mov r0,#0x13	; 02309E04
	ldrh r1,[r4,#0xe]	; 02309E06
	bl loc_02305A9C	; 02309E08
	mov r0,#0x35	; 02309E0C
	ldrh r1,[r4,#0x10]	; 02309E0E
	bl loc_02305A9C	; 02309E10
	ldrh r0,[r4,#0xc]	; 02309E14
	bl loc_02306808	; 02309E16
	ldrh r1,[r4,#0x16]	; 02309E1A
	ldr r0,[r4,#0x1c]	; 02309E1C
	strh r1,[r0,#0x4]	; 02309E1E
	mov r2,#0x0	; 02309E20
	strh r2,[r4,#0x0]	; 02309E22
	ldrh r3,[r4,#0x14]	; 02309E24
	b loc_02309E32	; 02309E26
loc_02309E28:
	ldr r1,[r4,#0x1c]	; 02309E28
	lsl r0,r3,#0x1	; 02309E2A
	add r0,r1,r0	; 02309E2C
	strh r2,[r0,#0x8]	; 02309E2E
	add r3,r3,#0x1	; 02309E30
loc_02309E32:
	cmp r3,#0x10	; 02309E32
	bcc loc_02309E28	; 02309E34
	bl loc_02309C1C	; 02309E36
loc_02309E3A:
	ldrh r0,[r4,#0x0]	; 02309E3A
	cmp r0,#0x0	; 02309E3C
	beq loc_02309E48	; 02309E3E
	mov r0,#0x2	; 02309E40
	mov r1,#0x5	; 02309E42
	bl loc_02304B6C	; 02309E44
loc_02309E48:
	add sp,#0x4	; 02309E48
	pop {r4,r5}	; 02309E4A
	pop {r3}	; 02309E4C
	bx r3	; 02309E4E
pool_02309E50:
loc_02309E50:
	.word FirmwareWlWorkPointerSlot	; 02309E50
pool_02309E54:
loc_02309E54:
	.word 0x000003BC	; 02309E54
pool_02309E58:
loc_02309E58:
	.word 0x00000314	; 02309E58
pool_02309E5C:
loc_02309E5C:
	.word 0x000003C0	; 02309E5C
pool_02309E60:
loc_02309E60:
	.word 0x000003C4	; 02309E60
pool_02309E64:
loc_02309E64:
	.word REG_WIFI_POWERFORCE	; 02309E64
pool_02309E68:
loc_02309E68:
	.word 0x00008000	; 02309E68
pool_02309E6C:
loc_02309E6C:
	.word P4_Code_02309C84 + 1	; 02309E6C
pool_02309E70:
loc_02309E70:
	.word REG_WIFI_RF_PINS	; 02309E70
pool_02309E74:
loc_02309E74:
	.word 0x000002F2	; 02309E74

; ===== function loc_02309E78 =====
loc_02309E78:
	bx pc	; 02309E78
	.byte 0xC0, 0x46	; 02309E7C
.arm

; ===== function loc_02309E7C =====
loc_02309E7C:
	ldr pc,[pool_02309E80]	; 02309E7C
pool_02309E80:
loc_02309E80:
	.word loc_03802720	; 02309E80
.thumb
	bx lr	; 02309E84
	.byte 0x00, 0x00	; 02309E88
P4_Code_02309E88:
	mov r2,#0x7	; 02309E88
	ldr r3,[pool_02309EA4]	; 02309E8A
	ldr r1,[r3,#0x0]	; 02309E8C
	ldr r0,[pool_02309EA8]	; 02309E8E
	ldr r0,[r1,r0]	; 02309E90
	strh r2,[r0,#0x4]	; 02309E92
	mov r2,#0x53	; 02309E94
	ldr r1,[r3,#0x0]	; 02309E96
	ldr r0,[pool_02309EAC]	; 02309E98
	strh r2,[r1,r0]	; 02309E9A
	mov r0,#0x2	; 02309E9C
	mov r1,#0x3	; 02309E9E
	ldr r3,[pool_02309EB0]	; 02309EA0
	bx r3	; 02309EA2
pool_02309EA4:
loc_02309EA4:
	.word FirmwareWlWorkPointerSlot	; 02309EA4
pool_02309EA8:
loc_02309EA8:
	.word 0x000003D8	; 02309EA8
pool_02309EAC:
loc_02309EAC:
	.word 0x000003BC	; 02309EAC
pool_02309EB0:
loc_02309EB0:
	.word loc_02304B6C + 1	; 02309EB0

; ===== function loc_02309EB4 =====
	push {r4,lr}	; 02309EB4
	ldr r0,[pool_02309F24]	; 02309EB6
	ldr r1,[r0,#0x0]	; 02309EB8
	ldr r0,[pool_02309F28]	; 02309EBA
	add r4,r1,r0	; 02309EBC
	ldrh r0,[r4,#0x0]	; 02309EBE
	cmp r0,#0x50	; 02309EC0
	beq loc_02309ECE	; 02309EC2
	cmp r0,#0x51	; 02309EC4
	beq loc_02309F1E	; 02309EC6
	cmp r0,#0x53	; 02309EC8
	beq loc_02309F02	; 02309ECA
	b loc_02309F1E	; 02309ECC
loc_02309ECE:
	ldr r0,[r4,#0x18]	; 02309ECE
	add r0,#0x10	; 02309ED0
	bl loc_0230C520	; 02309ED2
	cmp r0,#0x0	; 02309ED6
	bne loc_02309EEE	; 02309ED8
	mov r1,#0x8	; 02309EDA
	ldr r0,[r4,#0x1c]	; 02309EDC
	strh r1,[r0,#0x4]	; 02309EDE
	mov r0,#0x53	; 02309EE0
	strh r0,[r4,#0x0]	; 02309EE2
	mov r0,#0x2	; 02309EE4
	mov r1,#0x3	; 02309EE6
	bl loc_02304B6C	; 02309EE8
	b loc_02309F1E	; 02309EEC
loc_02309EEE:
	mov r1,#0x51	; 02309EEE
	strh r1,[r4,#0x0]	; 02309EF0
	bl loc_0230CAF0	; 02309EF2
	ldr r0,[r4,#0x18]	; 02309EF6
	ldrh r0,[r0,#0x18]	; 02309EF8
	ldr r1,[pool_02309F2C]	; 02309EFA
	bl loc_023055F8	; 02309EFC
	b loc_02309F1E	; 02309F00
loc_02309F02:
	mov r0,#0x1	; 02309F02
	bl loc_0230CD38	; 02309F04
	mov r0,#0x1	; 02309F08
	bl loc_0230CDA0	; 02309F0A
	mov r0,#0x1	; 02309F0E
	mov r1,#0x0	; 02309F10
	bl loc_0230CB60	; 02309F12
	mov r0,#0x0	; 02309F16
	strh r0,[r4,#0x0]	; 02309F18
	bl loc_02309C1C	; 02309F1A
loc_02309F1E:
	pop {r4}	; 02309F1E
	pop {r3}	; 02309F20
	bx r3	; 02309F22
pool_02309F24:
loc_02309F24:
	.word FirmwareWlWorkPointerSlot	; 02309F24
pool_02309F28:
loc_02309F28:
	.word 0x000003BC	; 02309F28
pool_02309F2C:
loc_02309F2C:
	.word P4_Code_02309E88 + 1	; 02309F2C
P4_Code_02309F30:
	mov r2,#0x7	; 02309F30
	ldr r3,[pool_02309F4C]	; 02309F32
	ldr r1,[r3,#0x0]	; 02309F34
	ldr r0,[pool_02309F50]	; 02309F36
	ldr r0,[r1,r0]	; 02309F38
	strh r2,[r0,#0x4]	; 02309F3A
	mov r2,#0x35	; 02309F3C
	ldr r1,[r3,#0x0]	; 02309F3E
	ldr r0,[pool_02309F54]	; 02309F40
	strh r2,[r1,r0]	; 02309F42
	mov r0,#0x2	; 02309F44
	add r1,r0,#0x0	; 02309F46
	ldr r3,[pool_02309F58]	; 02309F48
	bx r3	; 02309F4A
pool_02309F4C:
loc_02309F4C:
	.word FirmwareWlWorkPointerSlot	; 02309F4C
pool_02309F50:
loc_02309F50:
	.word 0x000003D8	; 02309F50
pool_02309F54:
loc_02309F54:
	.word 0x000003BC	; 02309F54
pool_02309F58:
loc_02309F58:
	.word loc_02304B6C + 1	; 02309F58

; ===== function loc_02309F5C =====
	push {r4,lr}	; 02309F5C
	ldr r0,[pool_02309FDC]	; 02309F5E
	ldr r1,[r0,#0x0]	; 02309F60
	ldr r0,[pool_02309FE0]	; 02309F62
	add r4,r1,r0	; 02309F64
	ldrh r0,[r4,#0x0]	; 02309F66
	cmp r0,#0x30	; 02309F68
	beq loc_02309F76	; 02309F6A
	cmp r0,#0x31	; 02309F6C
	beq loc_02309FD6	; 02309F6E
	cmp r0,#0x35	; 02309F70
	beq loc_02309FBA	; 02309F72
	b loc_02309FD6	; 02309F74
loc_02309F76:
	ldr r0,[r4,#0x18]	; 02309F76
	add r0,#0x10	; 02309F78
	mov r1,#0x0	; 02309F7A
	bl loc_0230C0D4	; 02309F7C
	cmp r0,#0x0	; 02309F80
	bne loc_02309F98	; 02309F82
	mov r1,#0x8	; 02309F84
	ldr r0,[r4,#0x1c]	; 02309F86
	strh r1,[r0,#0x4]	; 02309F88
	mov r0,#0x35	; 02309F8A
	strh r0,[r4,#0x0]	; 02309F8C
	mov r0,#0x2	; 02309F8E
	add r1,r0,#0x0	; 02309F90
	bl loc_02304B6C	; 02309F92
	b loc_02309FD6	; 02309F96
loc_02309F98:
	ldr r1,[r4,#0x18]	; 02309F98
	ldrh r1,[r1,#0x16]	; 02309F9A
	strh r1,[r0,#0x2c]	; 02309F9C
	mov r1,#0x1	; 02309F9E
	strh r1,[r0,#0x2e]	; 02309FA0
	mov r1,#0x0	; 02309FA2
	strh r1,[r0,#0x30]	; 02309FA4
	mov r1,#0x31	; 02309FA6
	strh r1,[r4,#0x0]	; 02309FA8
	bl loc_0230CAF0	; 02309FAA
	ldr r0,[r4,#0x18]	; 02309FAE
	ldrh r0,[r0,#0x18]	; 02309FB0
	ldr r1,[pool_02309FE4]	; 02309FB2
	bl loc_023055F8	; 02309FB4
	b loc_02309FD6	; 02309FB8
loc_02309FBA:
	mov r0,#0x1	; 02309FBA
	bl loc_0230CD38	; 02309FBC
	mov r0,#0x1	; 02309FC0
	bl loc_0230CDA0	; 02309FC2
	mov r0,#0x1	; 02309FC6
	mov r1,#0x0	; 02309FC8
	bl loc_0230CB60	; 02309FCA
	mov r0,#0x0	; 02309FCE
	strh r0,[r4,#0x0]	; 02309FD0
	bl loc_02309C1C	; 02309FD2
loc_02309FD6:
	pop {r4}	; 02309FD6
	pop {r3}	; 02309FD8
	bx r3	; 02309FDA
pool_02309FDC:
loc_02309FDC:
	.word FirmwareWlWorkPointerSlot	; 02309FDC
pool_02309FE0:
loc_02309FE0:
	.word 0x000003BC	; 02309FE0
pool_02309FE4:
loc_02309FE4:
	.word P4_Code_02309F30 + 1	; 02309FE4
P4_Code_02309FE8:
	mov r2,#0x7	; 02309FE8
	ldr r3,[pool_0230A004]	; 02309FEA
	ldr r1,[r3,#0x0]	; 02309FEC
	ldr r0,[pool_0230A008]	; 02309FEE
	strh r2,[r1,r0]	; 02309FF0
	mov r2,#0x25	; 02309FF2
	ldr r1,[r3,#0x0]	; 02309FF4
	ldr r0,[pool_0230A00C]	; 02309FF6
	strh r2,[r1,r0]	; 02309FF8
	mov r0,#0x2	; 02309FFA
	mov r1,#0x1	; 02309FFC
	ldr r3,[pool_0230A010]	; 02309FFE
	bx r3	; 0230A000
	.byte 0xC0, 0x46	; 0230A004
pool_0230A004:
loc_0230A004:
	.word FirmwareWlWorkPointerSlot	; 0230A004
pool_0230A008:
loc_0230A008:
	.word 0x000003C0	; 0230A008
pool_0230A00C:
loc_0230A00C:
	.word 0x000003BC	; 0230A00C
pool_0230A010:
loc_0230A010:
	.word loc_02304B6C + 1	; 0230A010

; ===== function loc_0230A014 =====
	push {r4,lr}	; 0230A014
	ldr r0,[pool_0230A06C]	; 0230A016
	ldr r1,[r0,#0x0]	; 0230A018
	ldr r0,[pool_0230A070]	; 0230A01A
	add r4,r1,r0	; 0230A01C
	ldrh r0,[r4,#0x0]	; 0230A01E
	cmp r0,#0x20	; 0230A020
	beq loc_0230A02E	; 0230A022
	cmp r0,#0x21	; 0230A024
	beq loc_0230A066	; 0230A026
	cmp r0,#0x25	; 0230A028
	beq loc_0230A048	; 0230A02A
	b loc_0230A066	; 0230A02C
loc_0230A02E:
	bl loc_02305BF0	; 0230A02E
	mov r0,#0x0	; 0230A032
	strh r0,[r4,#0x4]	; 0230A034
	strh r0,[r4,#0x6]	; 0230A036
	mov r0,#0x21	; 0230A038
	strh r0,[r4,#0x0]	; 0230A03A
	ldr r0,[r4,#0x18]	; 0230A03C
	ldrh r0,[r0,#0x10]	; 0230A03E
	ldr r1,[pool_0230A074]	; 0230A040
	bl loc_023055F8	; 0230A042
	b loc_0230A066	; 0230A046
loc_0230A048:
	ldrh r1,[r4,#0x4]	; 0230A048
	ldr r0,[r4,#0x1c]	; 0230A04A
	strh r1,[r0,#0x4]	; 0230A04C
	ldrh r1,[r4,#0x6]	; 0230A04E
	ldr r0,[r4,#0x1c]	; 0230A050
	strh r1,[r0,#0x6]	; 0230A052
	ldrh r0,[r4,#0x4]	; 0230A054
	cmp r0,#0x0	; 0230A056
	beq loc_0230A05E	; 0230A058
	bl loc_02305B40	; 0230A05A
loc_0230A05E:
	mov r0,#0x0	; 0230A05E
	strh r0,[r4,#0x0]	; 0230A060
	bl loc_02309C1C	; 0230A062
loc_0230A066:
	pop {r4}	; 0230A066
	pop {r3}	; 0230A068
	bx r3	; 0230A06A
pool_0230A06C:
loc_0230A06C:
	.word FirmwareWlWorkPointerSlot	; 0230A06C
pool_0230A070:
loc_0230A070:
	.word 0x000003BC	; 0230A070
pool_0230A074:
loc_0230A074:
	.word P4_Code_02309FE8 + 1	; 0230A074
P4_Code_0230A078:
	ldr r0,[pool_0230A0B0]	; 0230A078
	ldr r1,[r0,#0x0]	; 0230A07A
	ldr r0,[pool_0230A0B4]	; 0230A07C
	add r0,r1,r0	; 0230A07E
	add r3,r0,#0x0	; 0230A080
	add r3,#0xa	; 0230A082
	ldrh r2,[r3,#0x0]	; 0230A084
	ldrh r1,[r0,#0xc]	; 0230A086
	add r1,r2,r1	; 0230A088
	strh r1,[r3,#0x0]	; 0230A08A
	ldrh r2,[r0,#0xa]	; 0230A08C
	ldr r1,[r0,#0x18]	; 0230A08E
	add r1,#0x4a	; 0230A090
	ldrh r1,[r1,#0x0]	; 0230A092
	cmp r2,r1	; 0230A094
	bcc loc_0230A0A8	; 0230A096
	ldrh r1,[r0,#0x6]	; 0230A098
	cmp r1,#0x10	; 0230A09A
	bcs loc_0230A0A4	; 0230A09C
	mov r1,#0x11	; 0230A09E
	strh r1,[r0,#0x0]	; 0230A0A0
	b loc_0230A0A8	; 0230A0A2
loc_0230A0A4:
	mov r1,#0x15	; 0230A0A4
	strh r1,[r0,#0x0]	; 0230A0A6
loc_0230A0A8:
	mov r0,#0x2	; 0230A0A8
	mov r1,#0x0	; 0230A0AA
	ldr r3,[pool_0230A0B8]	; 0230A0AC
	bx r3	; 0230A0AE
pool_0230A0B0:
loc_0230A0B0:
	.word FirmwareWlWorkPointerSlot	; 0230A0B0
pool_0230A0B4:
loc_0230A0B4:
	.word 0x000003BC	; 0230A0B4
pool_0230A0B8:
loc_0230A0B8:
	.word loc_02304B6C + 1	; 0230A0B8

; ===== function loc_0230A0BC =====
	push {r4,r5,r6,lr}	; 0230A0BC
	ldr r0,[pool_0230A1F4]	; 0230A0BE
	ldr r1,[r0,#0x0]	; 0230A0C0
	ldr r0,[pool_0230A1F8]	; 0230A0C2
	add r4,r1,r0	; 0230A0C4
	mov r5,#0x0	; 0230A0C6
	ldrh r0,[r4,#0x0]	; 0230A0C8
	sub r0,#0x10	; 0230A0CA
	cmp r0,#0x5	; 0230A0CC
	bls loc_0230A0D2	; 0230A0CE
	b loc_0230A1E2	; 0230A0D0
loc_0230A0D2:
	add r0,r0,r0	; 0230A0D2
P4_SwitchIndexPC_0230A0D2:
	add r0,pc	; 0230A0D4
	ldrh r0,[r0,#(P4_SwitchTable_0230A0D2 - (P4_SwitchIndexPC_0230A0D2 + 4))]	; 0230A0D6
	lsl r0,r0,#0x10	; 0230A0D8
	asr r0,r0,#0x10	; 0230A0DA
P4_SwitchTargetPC_0230A0D2:
	add r0,pc	; 0230A0DC
	bx r0	; 0230A0DE
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230A0D2:
	.halfword (loc_0230A0EC + 1) - (P4_SwitchTargetPC_0230A0D2 + 4)
	.halfword (loc_0230A138 + 1) - (P4_SwitchTargetPC_0230A0D2 + 4)
	.halfword (loc_0230A19A + 1) - (P4_SwitchTargetPC_0230A0D2 + 4)
	.halfword (loc_0230A19A + 1) - (P4_SwitchTargetPC_0230A0D2 + 4)
	.halfword (loc_0230A1E2 + 1) - (P4_SwitchTargetPC_0230A0D2 + 4)
	.halfword (loc_0230A1CC + 1) - (P4_SwitchTargetPC_0230A0D2 + 4)
P4_SwitchTable_0230A0D2End:
loc_0230A0EC:
	mov r0,#0x20	; 0230A0EC
	bl loc_0230646C	; 0230A0EE
	mov r2,#0x2	; 0230A0F2
	ldr r0,[pool_0230A1F4]	; 0230A0F4
	ldr r1,[r0,#0x0]	; 0230A0F6
	ldr r0,[pool_0230A1FC]	; 0230A0F8
	strh r2,[r1,r0]	; 0230A0FA
	lsl r1,r5,#0	; 0230A0FC
	ldr r0,[r4,#0x1c]	; 0230A0FE
	strh r1,[r0,#0x8]	; 0230A100
	ldr r0,[r4,#0x1c]	; 0230A102
	strh r1,[r0,#0x6]	; 0230A104
	strh r1,[r4,#0x6]	; 0230A106
	strh r1,[r4,#0x8]	; 0230A108
	ldr r1,[r4,#0x18]	; 0230A10A
	ldrh r0,[r1,#0x38]	; 0230A10C
	cmp r0,#0x0	; 0230A10E
	bne loc_0230A12C	; 0230A110
	add r1,#0x4a	; 0230A112
	ldrh r0,[r1,#0x0]	; 0230A114
	add r0,r0,#0x3	; 0230A116
	mov r1,#0x4	; 0230A118
	bl loc_0230A208	; 0230A11A
	strh r0,[r4,#0xc]	; 0230A11E
	ldrh r0,[r4,#0xc]	; 0230A120
	cmp r0,#0xa	; 0230A122
	bcs loc_0230A132	; 0230A124
	mov r0,#0xa	; 0230A126
	strh r0,[r4,#0xc]	; 0230A128
	b loc_0230A132	; 0230A12A
loc_0230A12C:
	add r1,#0x4a	; 0230A12C
	ldrh r0,[r1,#0x0]	; 0230A12E
	strh r0,[r4,#0xc]	; 0230A130
loc_0230A132:
	mov r1,#0x0	; 0230A132
	ldr r0,[r4,#0x1c]	; 0230A134
	strh r1,[r0,#0x4]	; 0230A136
loc_0230A138:
	ldr r1,[r4,#0x18]	; 0230A138
	add r1,#0x3a	; 0230A13A
	ldrh r0,[r4,#0x6]	; 0230A13C
	add r0,r1,r0	; 0230A13E
	bl loc_023053B8	; 0230A140
	add r6,r0,#0x0	; 0230A144
	cmp r6,#0x0	; 0230A146
	bne loc_0230A152	; 0230A148
	mov r0,#0x15	; 0230A14A
	strh r0,[r4,#0x0]	; 0230A14C
	mov r5,#0x1	; 0230A14E
	b loc_0230A1E2	; 0230A150
loc_0230A152:
	add r1,r4,#0x6	; 0230A152
	ldrh r0,[r1,#0x0]	; 0230A154
	add r0,r0,#0x1	; 0230A156
	strh r0,[r1,#0x0]	; 0230A158
	mov r0,#0x0	; 0230A15A
	strh r0,[r4,#0xa]	; 0230A15C
	bl loc_02310210	; 0230A15E
	cmp r0,#0x0	; 0230A162
	beq loc_0230A17A	; 0230A164
	mov r1,#0xe	; 0230A166
	ldr r0,[r4,#0x1c]	; 0230A168
	strh r1,[r0,#0x4]	; 0230A16A
	mov r2,#0x15	; 0230A16C
	ldr r0,[pool_0230A1F4]	; 0230A16E
	ldr r1,[r0,#0x0]	; 0230A170
	ldr r0,[pool_0230A1F8]	; 0230A172
	strh r2,[r1,r0]	; 0230A174
	mov r5,#0x1	; 0230A176
	b loc_0230A1E2	; 0230A178
loc_0230A17A:
	ldrh r0,[r4,#0x0]	; 0230A17A
	cmp r0,#0x10	; 0230A17C
	bne loc_0230A18E	; 0230A17E
	add r0,r6,#0x0	; 0230A180
	mov r1,#0x0	; 0230A182
	bl loc_02306948	; 0230A184
	bl loc_02305BF0	; 0230A188
	b loc_0230A196	; 0230A18C
loc_0230A18E:
	add r0,r6,#0x0	; 0230A18E
	mov r1,#0x1	; 0230A190
	bl loc_02306948	; 0230A192
loc_0230A196:
	mov r0,#0x12	; 0230A196
	strh r0,[r4,#0x0]	; 0230A198
loc_0230A19A:
	mov r0,#0x13	; 0230A19A
	strh r0,[r4,#0x0]	; 0230A19C
	ldr r0,[r4,#0x18]	; 0230A19E
	ldrh r1,[r0,#0x38]	; 0230A1A0
	cmp r1,#0x0	; 0230A1A2
	bne loc_0230A1C2	; 0230A1A4
	add r0,#0x10	; 0230A1A6
	bl loc_0230C234	; 0230A1A8
	cmp r0,#0x0	; 0230A1AC
	bne loc_0230A1BE	; 0230A1AE
	mov r1,#0x8	; 0230A1B0
	ldr r0,[r4,#0x1c]	; 0230A1B2
	strh r1,[r0,#0x4]	; 0230A1B4
	mov r0,#0x15	; 0230A1B6
	strh r0,[r4,#0x0]	; 0230A1B8
	mov r5,#0x1	; 0230A1BA
	b loc_0230A1E2	; 0230A1BC
loc_0230A1BE:
	bl loc_0230CAF0	; 0230A1BE
loc_0230A1C2:
	ldrh r0,[r4,#0xc]	; 0230A1C2
	ldr r1,[pool_0230A200]	; 0230A1C4
	bl loc_023055F8	; 0230A1C6
	b loc_0230A1E2	; 0230A1CA
loc_0230A1CC:
	strh r5,[r4,#0x0]	; 0230A1CC
	bl loc_02305B40	; 0230A1CE
	ldr r0,[pool_0230A1F4]	; 0230A1D2
	ldr r2,[r0,#0x0]	; 0230A1D4
	ldr r0,[pool_0230A204]	; 0230A1D6
	ldrh r1,[r2,r0]	; 0230A1D8
	ldr r0,[pool_0230A1FC]	; 0230A1DA
	strh r1,[r2,r0]	; 0230A1DC
	bl loc_02309C1C	; 0230A1DE
loc_0230A1E2:
	cmp r5,#0x0	; 0230A1E2
	beq loc_0230A1EE	; 0230A1E4
	mov r0,#0x2	; 0230A1E6
	mov r1,#0x0	; 0230A1E8
	bl loc_02304B6C	; 0230A1EA
loc_0230A1EE:
	pop {r4,r5,r6}	; 0230A1EE
	pop {r3}	; 0230A1F0
	bx r3	; 0230A1F2
pool_0230A1F4:
loc_0230A1F4:
	.word FirmwareWlWorkPointerSlot	; 0230A1F4
pool_0230A1F8:
loc_0230A1F8:
	.word 0x000003BC	; 0230A1F8
pool_0230A1FC:
loc_0230A1FC:
	.word 0x00000314	; 0230A1FC
pool_0230A200:
loc_0230A200:
	.word P4_Code_0230A078 + 1	; 0230A200
pool_0230A204:
loc_0230A204:
	.word 0x000002F2	; 0230A204

; ===== function loc_0230A208 =====
loc_0230A208:
	bx pc	; 0230A208
	.byte 0xC0, 0x46	; 0230A20C
.arm

; ===== function loc_0230A20C =====
loc_0230A20C:
	ldr pc,[pool_0230A210]	; 0230A20C
pool_0230A210:
loc_0230A210:
	.word loc_03802514	; 0230A210
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x12, 0x20, 0x70, 0x80, 0x28, 0x48, 0x01, 0x68	; 0230A224
	.byte 0x28, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x44, 0xE0, 0x68, 0x8A, 0x03, 0x28	; 0230A234
	.byte 0x01, 0xD9, 0x05, 0x20, 0x3F, 0xE0, 0xA8, 0x8A, 0x3F, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x3A, 0xE0	; 0230A244
	.byte 0xE9, 0x8A, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x35, 0xE0, 0x1F, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230A254
	.byte 0x05, 0x20, 0x30, 0xE0, 0x00, 0x24, 0x2F, 0x1C, 0x18, 0x37, 0x17, 0xE0, 0x38, 0x19, 0xFB, 0xF7	; 0230A264
	.byte 0xA9, 0xF8, 0x00, 0x28, 0x14, 0xD0, 0x02, 0x1C, 0xF0, 0x21, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0	; 0230A274
	.byte 0x05, 0x20, 0x20, 0xE0, 0x01, 0x21, 0x81, 0x40, 0x11, 0x48, 0x02, 0x68, 0x13, 0x48, 0x10, 0x5A	; 0230A284
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x15, 0xE0, 0x64, 0x1C, 0x10, 0x2C, 0xE5, 0xD3	; 0230A294
	.byte 0x00, 0x2C, 0x01, 0xD1, 0x05, 0x20, 0x0E, 0xE0, 0x09, 0x48, 0x02, 0x68, 0x0C, 0x49, 0x55, 0x50	; 0230A2A4
	.byte 0x02, 0x68, 0x0C, 0x49, 0x56, 0x50, 0x80, 0x22, 0xB2, 0x80, 0x01, 0x68, 0x0A, 0x48, 0x0A, 0x52	; 0230A2B4
	.byte 0xFF, 0xF7, 0xF6, 0xFC, 0x80, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230A2C4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00	; 0230A2D4
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C	; 0230A2E4
	.byte 0x01, 0x20, 0x48, 0x80, 0x47, 0x48, 0x00, 0x68, 0x47, 0x49, 0x41, 0x5A, 0x01, 0x29, 0x03, 0xD0	; 0230A2F4
	.byte 0x00, 0x29, 0x01, 0xD0, 0x0B, 0x20, 0x81, 0xE0, 0x44, 0x49, 0x41, 0x5A, 0x20, 0x29, 0x01, 0xD0	; 0230A304
	.byte 0x01, 0x20, 0x7B, 0xE0, 0x21, 0x8A, 0x20, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x76, 0xE0, 0x00, 0x29	; 0230A314
	.byte 0x01, 0xD1, 0x05, 0x20, 0x72, 0xE0, 0x62, 0x8E, 0x0A, 0x2A, 0x01, 0xD2, 0x05, 0x20, 0x6D, 0xE0	; 0230A324
	.byte 0x3B, 0x49, 0x8A, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x68, 0xE0, 0xA1, 0x8E, 0x00, 0x29, 0x01, 0xD1	; 0230A334
	.byte 0x05, 0x20, 0x63, 0xE0, 0xFF, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x5F, 0xE0, 0xE3, 0x8E, 0x35, 0x49	; 0230A344
	.byte 0x1A, 0x1C, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0, 0x05, 0x20, 0x57, 0xE0, 0x01, 0x22, 0x9A, 0x40	; 0230A354
	.byte 0x31, 0x49, 0x40, 0x5A, 0x02, 0x40, 0x00, 0x2A, 0x01, 0xD1, 0x05, 0x20, 0x4E, 0xE0, 0x21, 0x8F	; 0230A364
	.byte 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x49, 0xE0, 0x2C, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0	; 0230A374
	.byte 0x05, 0x20, 0x43, 0xE0, 0x61, 0x8F, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x3E, 0xE0, 0x01, 0x40	; 0230A384
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x39, 0xE0, 0xA0, 0x8F, 0x80, 0x28, 0x01, 0xD9, 0x05, 0x20	; 0230A394
	.byte 0x34, 0xE0, 0x00, 0x20, 0x05, 0xF0, 0x3A, 0xFF, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x2D, 0xE0	; 0230A3A4
	.byte 0x18, 0x48, 0x01, 0x68, 0x18, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x03, 0xD1, 0x1C, 0x48, 0xFC, 0xF7	; 0230A3B4
	.byte 0xC1, 0xFC, 0x03, 0xE0, 0x1B, 0x48, 0x08, 0x18, 0xFC, 0xF7, 0xBC, 0xFC, 0x20, 0x8A, 0x21, 0x1C	; 0230A3C4
	.byte 0x12, 0x31, 0xFC, 0xF7, 0x4B, 0xFC, 0x60, 0x8E, 0xFC, 0xF7, 0x26, 0xFC, 0xA0, 0x8E, 0xFC, 0xF7	; 0230A3D4
	.byte 0x0F, 0xFC, 0xE0, 0x8E, 0x00, 0x21, 0xFC, 0xF7, 0xB5, 0xFA, 0x20, 0x1C, 0x38, 0x30, 0xFC, 0xF7	; 0230A3E4
	.byte 0x99, 0xFA, 0xA0, 0x8F, 0x3E, 0x34, 0x21, 0x1C, 0xFC, 0xF7, 0x20, 0xF9, 0x00, 0x22, 0x05, 0x48	; 0230A3F4
	.byte 0x01, 0x68, 0x0D, 0x48, 0x0A, 0x52, 0xFB, 0xF7, 0xF9, 0xFB, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC	; 0230A404
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00	; 0230A414
	.byte 0xE8, 0x03, 0x00, 0x00, 0xF0, 0xFF, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF	; 0230A424
	.byte 0x7C, 0x03, 0x31, 0x02, 0xE8, 0x02, 0x00, 0x00, 0xA0, 0x03, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0	; 0230A434
	.byte 0x05, 0x1C, 0x0C, 0x1C, 0x03, 0x20, 0x60, 0x80, 0x24, 0x48, 0x01, 0x68, 0x24, 0x48, 0x08, 0x5A	; 0230A444
	.byte 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x3A, 0xE0, 0x21, 0x48, 0x08, 0x5A	; 0230A454
	.byte 0x30, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x34, 0xE0, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 0230A464
	.byte 0x01, 0xD0, 0x05, 0x20, 0x2D, 0xE0, 0xE8, 0x8A, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x28, 0xE0	; 0230A474
	.byte 0xFF, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x24, 0xE0, 0x29, 0x8B, 0x17, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230A484
	.byte 0x05, 0x20, 0x1E, 0xE0, 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20, 0x1A, 0xE0, 0x30, 0x20, 0xFB, 0xF7	; 0230A494
	.byte 0xEB, 0xFF, 0xFC, 0xF7, 0x1F, 0xF8, 0xEB, 0x8A, 0x0C, 0x48, 0x02, 0x68, 0x0F, 0x49, 0x53, 0x52	; 0230A4A4
	.byte 0xEB, 0x8A, 0x02, 0x68, 0x0E, 0x49, 0x53, 0x52, 0x02, 0x68, 0x0E, 0x49, 0x55, 0x50, 0x02, 0x68	; 0230A4B4
	.byte 0x0D, 0x49, 0x54, 0x50, 0x50, 0x22, 0x01, 0x68, 0x0C, 0x48, 0x0A, 0x52, 0xFF, 0xF7, 0xF8, 0xFC	; 0230A4C4
	.byte 0x80, 0x20, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230A4D4
	.byte 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xD0, 0x07, 0x00, 0x00, 0x6C, 0x03, 0x00, 0x00	; 0230A4E4
	.byte 0x6E, 0x03, 0x00, 0x00, 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00	; 0230A4F4
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x04, 0x20, 0x60, 0x80, 0x21, 0x48, 0x02, 0x68, 0x21, 0x48	; 0230A504
	.byte 0x11, 0x5A, 0x03, 0x29, 0x05, 0xD0, 0x02, 0x29, 0x03, 0xD0, 0x01, 0x29, 0x01, 0xD0, 0x0B, 0x20	; 0230A514
	.byte 0x33, 0xE0, 0x1D, 0x48, 0x10, 0x5A, 0x30, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x2D, 0xE0, 0x1B, 0x48	; 0230A524
	.byte 0x08, 0x18, 0x00, 0x04, 0x00, 0x0C, 0x01, 0x28, 0x06, 0xD8, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40	; 0230A534
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x20, 0xE0, 0xA0, 0x1D, 0x29, 0x1C, 0x10, 0x31, 0xFB, 0xF7	; 0230A544
	.byte 0x8B, 0xFF, 0xA0, 0x1D, 0xE9, 0x8A, 0x01, 0xF0, 0x87, 0xFD, 0x06, 0x1C, 0x00, 0x2E, 0x01, 0xD1	; 0230A554
	.byte 0x08, 0x20, 0x12, 0xE0, 0x28, 0x1C, 0x10, 0x30, 0x02, 0xF0, 0x70, 0xFB, 0x08, 0x48, 0x02, 0x68	; 0230A564
	.byte 0x0B, 0x49, 0x55, 0x50, 0x02, 0x68, 0x0B, 0x49, 0x54, 0x50, 0x41, 0x22, 0x01, 0x68, 0x0A, 0x48	; 0230A574
	.byte 0x0A, 0x52, 0x30, 0x1C, 0x02, 0xF0, 0xBA, 0xFA, 0x80, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230A584
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xFE, 0xFF, 0x00, 0x00	; 0230A594
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0	; 0230A5A4
	.byte 0x05, 0x1C, 0x0C, 0x1C, 0x06, 0x20, 0x60, 0x80, 0x22, 0x48, 0x01, 0x68, 0x22, 0x48, 0x08, 0x5A	; 0230A5B4
	.byte 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x37, 0xE0, 0x1F, 0x48, 0x08, 0x5A	; 0230A5C4
	.byte 0x20, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x31, 0xE0, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 0230A5D4
	.byte 0x01, 0xD0, 0x05, 0x20, 0x2A, 0xE0, 0xE8, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x25, 0xE0	; 0230A5E4
	.byte 0x29, 0x8B, 0x17, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x1F, 0xE0, 0x0A, 0x29, 0x01, 0xD2	; 0230A5F4
	.byte 0x05, 0x20, 0x1B, 0xE0, 0x20, 0x20, 0xFB, 0xF7, 0x37, 0xFF, 0x0E, 0x49, 0x08, 0x68, 0x11, 0x4A	; 0230A604
	.byte 0x85, 0x50, 0x0B, 0x68, 0x10, 0x48, 0x1C, 0x50, 0x30, 0x25, 0x0B, 0x68, 0x0F, 0x48, 0x1D, 0x52	; 0230A614
	.byte 0x08, 0x68, 0x80, 0x58, 0xC0, 0x8A, 0xE0, 0x81, 0x08, 0x34, 0x20, 0x1C, 0x09, 0x68, 0x89, 0x58	; 0230A624
	.byte 0x10, 0x31, 0xFB, 0xF7, 0x19, 0xFF, 0xFF, 0xF7, 0x97, 0xFC, 0x80, 0x20, 0x01, 0xB0, 0x30, 0xBC	; 0230A634
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00	; 0230A644
	.byte 0xD0, 0x07, 0x00, 0x00, 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00	; 0230A654
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0C, 0x1C, 0x05, 0x20, 0x60, 0x80, 0x54, 0x48, 0x01, 0x68	; 0230A664
	.byte 0x54, 0x48, 0x08, 0x5A, 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x9A, 0xE0	; 0230A674
	.byte 0x51, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x94, 0xE0, 0x20, 0x20, 0xFB, 0xF7	; 0230A684
	.byte 0xF3, 0xFE, 0x29, 0x8B, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x8A, 0xE0	; 0230A694
	.byte 0xE9, 0x8B, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x85, 0xE0, 0x20, 0x29, 0x01, 0xD9, 0x05, 0x20	; 0230A6A4
	.byte 0x81, 0xE0, 0x29, 0x1C, 0x46, 0x31, 0x0A, 0x88, 0x0A, 0x2A, 0x01, 0xD2, 0x05, 0x20, 0x7A, 0xE0	; 0230A6B4
	.byte 0x42, 0x49, 0x8A, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x75, 0xE0, 0x29, 0x1C, 0x48, 0x31, 0x09, 0x88	; 0230A6C4
	.byte 0xFF, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x6E, 0xE0, 0x29, 0x1C, 0x4A, 0x31, 0x0B, 0x88, 0x3C, 0x49	; 0230A6D4
	.byte 0x1A, 0x1C, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0, 0x05, 0x20, 0x64, 0xE0, 0x98, 0x40, 0x34, 0x49	; 0230A6E4
	.byte 0x0A, 0x68, 0x38, 0x49, 0x51, 0x5A, 0x08, 0x40, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x5A, 0xE0	; 0230A6F4
	.byte 0x28, 0x1C, 0x42, 0x30, 0x00, 0x88, 0x34, 0x4A, 0x01, 0x1C, 0x11, 0x40, 0x00, 0x29, 0x01, 0xD0	; 0230A704
	.byte 0x05, 0x20, 0x50, 0xE0, 0x29, 0x1C, 0x44, 0x31, 0x0B, 0x88, 0x19, 0x1C, 0x11, 0x40, 0x00, 0x29	; 0230A714
	.byte 0x01, 0xD0, 0x05, 0x20, 0x47, 0xE0, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x43, 0xE0, 0x03, 0x43	; 0230A724
	.byte 0x00, 0x2B, 0x01, 0xD1, 0x05, 0x20, 0x3E, 0xE0, 0x29, 0x8A, 0x28, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230A734
	.byte 0x05, 0x20, 0x38, 0xE0, 0x00, 0x20, 0x05, 0xF0, 0x69, 0xFD, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20	; 0230A744
	.byte 0x31, 0xE0, 0x28, 0x1C, 0x40, 0x30, 0x01, 0x88, 0x20, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD1	; 0230A754
	.byte 0x00, 0x20, 0xFC, 0xF7, 0xD1, 0xFB, 0x28, 0x1C, 0x18, 0x30, 0xFC, 0xF7, 0xEB, 0xFA, 0xE8, 0x8B	; 0230A764
	.byte 0x29, 0x1C, 0x20, 0x31, 0xFC, 0xF7, 0x7A, 0xFA, 0x28, 0x1C, 0x46, 0x30, 0x00, 0x88, 0xFC, 0xF7	; 0230A774
	.byte 0x53, 0xFA, 0x28, 0x1C, 0x4A, 0x30, 0x00, 0x88, 0x00, 0x21, 0xFC, 0xF7, 0xE3, 0xF8, 0x28, 0x1C	; 0230A784
	.byte 0x42, 0x30, 0xFC, 0xF7, 0xC7, 0xF8, 0x0A, 0x48, 0x02, 0x68, 0x11, 0x49, 0x55, 0x50, 0x02, 0x68	; 0230A794
	.byte 0x10, 0x49, 0x54, 0x50, 0x20, 0x22, 0x01, 0x68, 0x0F, 0x48, 0x0A, 0x52, 0x02, 0x20, 0x01, 0x21	; 0230A7A4
	.byte 0xFA, 0xF7, 0xE2, 0xF9, 0x80, 0x20, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230A7B4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00	; 0230A7C4
	.byte 0xF0, 0xFF, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xD0, 0x07, 0x00, 0x00	; 0230A7D4
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0xF0, 0xB5, 0x81, 0xB0	; 0230A7E4
	.byte 0x05, 0x1C, 0x0E, 0x1C, 0x70, 0x88, 0x83, 0x1E, 0x3B, 0x4A, 0x11, 0x68, 0x3B, 0x48, 0x0B, 0x52	; 0230A7F4
	.byte 0x03, 0x20, 0x70, 0x80, 0x11, 0x68, 0x3A, 0x48, 0x08, 0x5A, 0x01, 0x28, 0x05, 0xD0, 0x03, 0x28	; 0230A804
	.byte 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x61, 0xE0, 0x36, 0x48, 0x08, 0x5A, 0x20, 0x28	; 0230A814
	.byte 0x01, 0xD2, 0x01, 0x20, 0x5B, 0xE0, 0xE8, 0x8A, 0x20, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x56, 0xE0	; 0230A824
	.byte 0x28, 0x8F, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x51, 0xE0, 0x28, 0x1C, 0x3A, 0x30, 0xFA, 0xF7	; 0230A834
	.byte 0xC1, 0xFD, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x49, 0xE0, 0x28, 0x1C, 0x4A, 0x30, 0x01, 0x88	; 0230A844
	.byte 0x29, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x41, 0xE0, 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20	; 0230A854
	.byte 0x3D, 0xE0, 0x28, 0x1C, 0x4C, 0x30, 0x00, 0x88, 0x10, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x36, 0xE0	; 0230A864
	.byte 0x00, 0x24, 0x2F, 0x1C, 0x3A, 0x37, 0x17, 0xE0, 0x38, 0x19, 0xFA, 0xF7, 0xA3, 0xFD, 0x00, 0x28	; 0230A874
	.byte 0x14, 0xD0, 0x02, 0x1C, 0xF0, 0x21, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0, 0x05, 0x20, 0x26, 0xE0	; 0230A884
	.byte 0x01, 0x21, 0x81, 0x40, 0x14, 0x48, 0x02, 0x68, 0x18, 0x48, 0x10, 0x5A, 0x01, 0x40, 0x00, 0x29	; 0230A894
	.byte 0x01, 0xD1, 0x05, 0x20, 0x1B, 0xE0, 0x64, 0x1C, 0x10, 0x2C, 0xE5, 0xD3, 0x28, 0x1C, 0x10, 0x30	; 0230A8A4
	.byte 0xFC, 0xF7, 0x48, 0xFA, 0xE8, 0x8A, 0x29, 0x1C, 0x18, 0x31, 0xFC, 0xF7, 0xD7, 0xF9, 0x0A, 0x48	; 0230A8B4
	.byte 0x02, 0x68, 0x0F, 0x49, 0x55, 0x50, 0x02, 0x68, 0x0E, 0x49, 0x56, 0x50, 0x10, 0x22, 0x01, 0x68	; 0230A8C4
	.byte 0x0D, 0x48, 0x0A, 0x52, 0x02, 0x20, 0x00, 0x21, 0xFA, 0xF7, 0x4E, 0xF9, 0x80, 0x20, 0x01, 0xB0	; 0230A8D4
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xC0, 0x03, 0x00, 0x00	; 0230A8E4
	.byte 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00	; 0230A8F4
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C	; 0230A904
	.byte 0x09, 0x20, 0x48, 0x80, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x2D, 0xE0, 0x61, 0x8A	; 0230A914
	.byte 0x01, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x28, 0xE0, 0xA1, 0x8A, 0x01, 0x29, 0x01, 0xD9, 0x05, 0x20	; 0230A924
	.byte 0x23, 0xE0, 0xFB, 0xF7, 0x91, 0xFF, 0x20, 0x8A, 0x01, 0x28, 0x17, 0xD1, 0x60, 0x8A, 0x01, 0x28	; 0230A934
	.byte 0x03, 0xD1, 0x0F, 0x48, 0xFB, 0xF7, 0x66, 0xFF, 0x02, 0xE0, 0x00, 0x20, 0xFB, 0xF7, 0x62, 0xFF	; 0230A944
	.byte 0x0C, 0x48, 0x01, 0x68, 0x0C, 0x48, 0x0B, 0x18, 0x1A, 0x88, 0x08, 0x20, 0x82, 0x43, 0xA1, 0x8A	; 0230A954
	.byte 0x01, 0x20, 0x01, 0x40, 0xC8, 0x00, 0x02, 0x43, 0x1A, 0x80, 0x05, 0xE0, 0x07, 0x48, 0xFB, 0xF7	; 0230A964
	.byte 0x51, 0xFF, 0x02, 0x20, 0xFB, 0xF7, 0x54, 0xFF, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230A974
	.byte 0x01, 0x80, 0x00, 0x00, 0xF4, 0xFF, 0x80, 0x03, 0x16, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 0230A984
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20	; 0230A994
	.byte 0x07, 0xE0, 0xFB, 0xF7, 0xD3, 0xF8, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD1, 0xFB, 0xF7, 0x1C, 0xFD	; 0230A9A4
	.byte 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68	; 0230A9B4
	.byte 0x03, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230A9C4
	.byte 0xF8, 0x02, 0x00, 0x00, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68, 0x03, 0x48, 0x10, 0x5A	; 0230A9D4
	.byte 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00	; 0230A9E4
	.byte 0x03, 0x20, 0x48, 0x80, 0x05, 0x4B, 0x1A, 0x68, 0x05, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x1A, 0x68	; 0230A9F4
	.byte 0x04, 0x48, 0x10, 0x5A, 0x08, 0x81, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230AA04
	.byte 0xF0, 0x02, 0x00, 0x00, 0x76, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x04, 0x20, 0x48, 0x80	; 0230AA14
	.byte 0x88, 0x1D, 0x05, 0x49, 0x0A, 0x68, 0x05, 0x49, 0x51, 0x18, 0xFB, 0xF7, 0x1D, 0xFD, 0x00, 0x20	; 0230AA24
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xE8, 0x02, 0x00, 0x00	; 0230AA34
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x0E, 0x48, 0x01, 0x68, 0x0E, 0x48	; 0230AA44
	.byte 0x08, 0x5A, 0x01, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x0F, 0xE0, 0x2C, 0x8A, 0x60, 0x1C, 0x02, 0x21	; 0230AA54
	.byte 0x00, 0xF0, 0x14, 0xF8, 0xE9, 0x89, 0x40, 0x1C, 0x81, 0x42, 0x01, 0xDA, 0x04, 0x20, 0x04, 0xE0	; 0230AA64
	.byte 0x20, 0x1C, 0x12, 0x35, 0x29, 0x1C, 0xFB, 0xF7, 0x95, 0xFD, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 0230AA74
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 0230AA84
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x14, 0x25, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x23, 0x4B, 0x80	; 0230AA94
	.byte 0x06, 0x49, 0x0A, 0x68, 0x06, 0x49, 0x51, 0x5A, 0x10, 0x29, 0x03, 0xD3, 0x00, 0x8A, 0xFC, 0xF7	; 0230AAA4
	.byte 0x77, 0xF9, 0x03, 0x1C, 0x18, 0x1C, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 0230AAB4
	.byte 0x10, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x01, 0x24, 0x4C, 0x80, 0x0D, 0x4B, 0x1A, 0x68, 0x0D, 0x49	; 0230AAC4
	.byte 0x51, 0x5A, 0x20, 0x29, 0x01, 0xD9, 0x20, 0x1C, 0x0F, 0xE0, 0x02, 0x1C, 0x10, 0x32, 0x11, 0x88	; 0230AAD4
	.byte 0x49, 0x1C, 0x11, 0x80, 0x1A, 0x68, 0x01, 0x8A, 0x07, 0x48, 0x10, 0x5A, 0x81, 0x42, 0x01, 0xD9	; 0230AAE4
	.byte 0x05, 0x20, 0x02, 0xE0, 0x05, 0x48, 0x11, 0x52, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230AAF4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xE4, 0x02, 0x00, 0x00, 0xE6, 0x02, 0x00, 0x00	; 0230AB04
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x03, 0x1C, 0x25, 0x48, 0x04, 0x68, 0x25, 0x4A, 0xA2, 0x58, 0x01, 0x24	; 0230AB14
	.byte 0x4C, 0x80, 0x19, 0x8A, 0x04, 0x68, 0x23, 0x48, 0x20, 0x5A, 0x81, 0x42, 0x04, 0xD3, 0x22, 0x48	; 0230AB24
	.byte 0x81, 0x42, 0x01, 0xD0, 0x05, 0x20, 0x35, 0xE0, 0x9C, 0x8A, 0x3F, 0x2C, 0x04, 0xD9, 0x1E, 0x48	; 0230AB34
	.byte 0x84, 0x42, 0x01, 0xD0, 0x05, 0x20, 0x2D, 0xE0, 0x1B, 0x48, 0x81, 0x42, 0x14, 0xD1, 0x01, 0x21	; 0230AB44
	.byte 0x16, 0x4D, 0x1C, 0x24, 0x17, 0x4F, 0x0A, 0xE0, 0x08, 0x1C, 0x60, 0x43, 0x10, 0x18, 0x5E, 0x8A	; 0230AB54
	.byte 0x46, 0x83, 0x06, 0x8B, 0x00, 0x2E, 0x01, 0xD0, 0x5E, 0x8A, 0x06, 0x83, 0x49, 0x1C, 0x28, 0x68	; 0230AB64
	.byte 0xC0, 0x5B, 0x81, 0x42, 0xF0, 0xD3, 0x0F, 0xE0, 0x00, 0x29, 0x0D, 0xD0, 0x5C, 0x8A, 0x1C, 0x20	; 0230AB74
	.byte 0x41, 0x43, 0x51, 0x18, 0x4C, 0x83, 0x18, 0x32, 0x19, 0x8A, 0x41, 0x43, 0x54, 0x18, 0x50, 0x5A	; 0230AB84
	.byte 0x00, 0x28, 0x01, 0xD0, 0x58, 0x8A, 0x20, 0x80, 0x98, 0x8A, 0x00, 0x28, 0x01, 0xD0, 0xFB, 0xF7	; 0230AB94
	.byte 0x9F, 0xFD, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 0230ABA4
	.byte 0xE0, 0x02, 0x00, 0x00, 0xE6, 0x02, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 0230ABB4
	.byte 0x01, 0x22, 0x4A, 0x80, 0x0B, 0x49, 0x0B, 0x68, 0x0B, 0x49, 0x59, 0x5A, 0x20, 0x29, 0x01, 0xD9	; 0230ABC4
	.byte 0x10, 0x1C, 0x0C, 0xE0, 0x20, 0x29, 0x07, 0xD1, 0x08, 0x49, 0x59, 0x5A, 0x49, 0x07, 0xC9, 0x0F	; 0230ABD4
	.byte 0x00, 0x29, 0x01, 0xD0, 0x10, 0x1C, 0x02, 0xE0, 0x00, 0x8A, 0xFC, 0xF7, 0x25, 0xFB, 0x01, 0xB0	; 0230ABE4
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x16, 0x03, 0x00, 0x00	; 0230ABF4
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x2B, 0x49, 0x0A, 0x68, 0x2B, 0x49	; 0230AC04
	.byte 0x51, 0x5A, 0x10, 0x29, 0x4B, 0xD1, 0x28, 0x1C, 0x10, 0x30, 0xFC, 0xF7, 0x6F, 0xFB, 0x04, 0x1C	; 0230AC14
	.byte 0xE8, 0x8A, 0xFC, 0xF7, 0x59, 0xFB, 0x04, 0x43, 0x28, 0x8B, 0xFC, 0xF7, 0x39, 0xFB, 0x04, 0x43	; 0230AC24
	.byte 0xA8, 0x8B, 0xFC, 0xF7, 0x01, 0xFB, 0x04, 0x43, 0xE8, 0x8B, 0xFC, 0xF7, 0xE9, 0xFA, 0x04, 0x43	; 0230AC34
	.byte 0x28, 0x8C, 0xFC, 0xF7, 0x89, 0xFA, 0x04, 0x43, 0x68, 0x8C, 0xFC, 0xF7, 0x77, 0xFA, 0x04, 0x43	; 0230AC44
	.byte 0x28, 0x1C, 0x24, 0x30, 0xFC, 0xF7, 0x4C, 0xFA, 0x04, 0x43, 0x28, 0x1C, 0x74, 0x30, 0x00, 0x88	; 0230AC54
	.byte 0xFC, 0xF7, 0x32, 0xFA, 0x04, 0x43, 0x28, 0x1C, 0x76, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0x16, 0xFA	; 0230AC64
	.byte 0x04, 0x43, 0x28, 0x1C, 0x78, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0xF8, 0xF9, 0x04, 0x43, 0x28, 0x1C	; 0230AC74
	.byte 0x7A, 0x30, 0x00, 0x88, 0x00, 0x21, 0xFC, 0xF7, 0xA7, 0xF9, 0x04, 0x43, 0x28, 0x1C, 0x7C, 0x30	; 0230AC84
	.byte 0xFC, 0xF7, 0x90, 0xF9, 0x04, 0x43, 0x28, 0x1C, 0x9C, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0x34, 0xF9	; 0230AC94
	.byte 0x04, 0x43, 0x9E, 0x35, 0x28, 0x88, 0xFC, 0xF7, 0x21, 0xF9, 0x04, 0x43, 0x20, 0x1C, 0x01, 0xB0	; 0230ACA4
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00	; 0230ACB4
.thumb

; ===== function loc_0230ACB4 =====
loc_0230ACB4:
	ldr r0,[pool_0230ACFC]	; 0230ACB4
	ldr r1,[r0,#0x0]	; 0230ACB6
	ldr r0,[pool_0230AD00]	; 0230ACB8
	ldrh r0,[r1,r0]	; 0230ACBA
	lsl r0,r0,#0x1a	; 0230ACBC
	lsr r0,r0,#0x1f	; 0230ACBE
	cmp r0,#0x0	; 0230ACC0
	beq loc_0230ACD8	; 0230ACC2
	mov r1,#0x0	; 0230ACC4
	ldr r0,[pool_0230AD04]	; 0230ACC6
	strh r1,[r0,#0x0]	; 0230ACC8
	strh r1,[r0,#0x4]	; 0230ACCA
	ldr r2,[pool_0230AD08]	; 0230ACCC
	ldrh r1,[r2,#0x0]	; 0230ACCE
	ldr r0,[pool_0230AD0C]	; 0230ACD0
	orr r1,r0	; 0230ACD2
	strh r1,[r2,#0x0]	; 0230ACD4
	bx lr	; 0230ACD6
loc_0230ACD8:
	mov r1,#0x1	; 0230ACD8
	ldr r0,[pool_0230AD10]	; 0230ACDA
	strh r1,[r0,#0x0]	; 0230ACDC
	mov r2,#0x0	; 0230ACDE
	ldr r0,[pool_0230AD14]	; 0230ACE0
	strh r2,[r0,#0x0]	; 0230ACE2
	mov r1,#0x2	; 0230ACE4
	ldr r0,[pool_0230AD18]	; 0230ACE6
	strh r1,[r0,#0x0]	; 0230ACE8
	ldr r1,[pool_0230AD1C]	; 0230ACEA
	ldr r0,[pool_0230AD20]	; 0230ACEC
	strh r1,[r0,#0x0]	; 0230ACEE
	ldr r0,[pool_0230AD24]	; 0230ACF0
	strh r2,[r0,#0x0]	; 0230ACF2
	ldr r0,[pool_0230AD28]	; 0230ACF4
	strh r2,[r0,#0x0]	; 0230ACF6
	bx lr	; 0230ACF8
	.byte 0xC0, 0x46	; 0230ACFC
pool_0230ACFC:
loc_0230ACFC:
	.word FirmwareWlWorkPointerSlot	; 0230ACFC
pool_0230AD00:
loc_0230AD00:
	.word 0x00000316	; 0230AD00
pool_0230AD04:
loc_0230AD04:
	.word WifiRamBase	; 0230AD04
pool_0230AD08:
loc_0230AD08:
	.word REG_WIFI_TXBUF_LOC1	; 0230AD08
pool_0230AD0C:
loc_0230AD0C:
	.word 0x00008000	; 0230AD0C
pool_0230AD10:
loc_0230AD10:
	.word REG_WIFI_TXREQ_RESET	; 0230AD10
pool_0230AD14:
loc_0230AD14:
	.word REG_WIFI_MODE_RST	; 0230AD14
pool_0230AD18:
loc_0230AD18:
	.word REG_WIFI_IE	; 0230AD18
pool_0230AD1C:
loc_0230AD1C:
	.word 0x0000FFFF	; 0230AD1C
pool_0230AD20:
loc_0230AD20:
	.word REG_WIFI_IF	; 0230AD20
pool_0230AD24:
loc_0230AD24:
	.word REG_WIFI_TX_HDR_CNT	; 0230AD24
pool_0230AD28:
loc_0230AD28:
	.word REG_WIFI_POWERFORCE	; 0230AD28
	.byte 0x10, 0xB5, 0x82, 0xB0, 0x04, 0x1C, 0xFA, 0xF7, 0x5D, 0xFF, 0xFA, 0xF7, 0x03, 0xFF, 0x06, 0x20	; 0230AD3C
	.byte 0xFA, 0xF7, 0xE4, 0xFE, 0x27, 0x49, 0x0A, 0x68, 0x27, 0x49, 0x50, 0x52, 0x60, 0x8A, 0x04, 0x28	; 0230AD4C
	.byte 0x03, 0xD1, 0x06, 0x20, 0x00, 0x21, 0xFA, 0xF7, 0xA3, 0xFE, 0x00, 0x21, 0x00, 0xA8, 0x01, 0x80	; 0230AD5C
	.byte 0x00, 0x88, 0x22, 0x49, 0x0C, 0x22, 0x00, 0xF0, 0x5D, 0xF8, 0x14, 0x20, 0x1F, 0x4A, 0x10, 0x81	; 0230AD6C
	.byte 0x1F, 0x48, 0x50, 0x81, 0x0C, 0x32, 0x00, 0x23, 0x1E, 0x49, 0x1F, 0x48, 0x11, 0x80, 0x92, 0x1C	; 0230AD7C
	.byte 0x9B, 0x1C, 0x83, 0x42, 0xFA, 0xD3, 0x08, 0x21, 0x18, 0x48, 0x81, 0x81, 0x06, 0x21, 0x1B, 0x48	; 0230AD8C
	.byte 0x01, 0x80, 0x12, 0x23, 0x13, 0x4A, 0x11, 0x68, 0x19, 0x48, 0x0B, 0x52, 0x11, 0x68, 0x19, 0x48	; 0230AD9C
	.byte 0x0A, 0x18, 0x11, 0x88, 0x20, 0x20, 0x01, 0x43, 0x11, 0x80, 0x17, 0x49, 0x17, 0x48, 0x01, 0x80	; 0230ADAC
	.byte 0xE0, 0x8A, 0x01, 0x21, 0xFB, 0xF7, 0xCA, 0xFD, 0x02, 0x21, 0x15, 0x48, 0x01, 0x80, 0x01, 0x21	; 0230ADBC
	.byte 0x14, 0x48, 0x01, 0x80, 0x14, 0x48, 0x01, 0x80, 0x08, 0x49, 0x14, 0x48, 0x01, 0x40, 0xC8, 0x03	; 0230ADCC
	.byte 0x01, 0x0C, 0x0D, 0x48, 0x01, 0x43, 0x12, 0x48, 0x01, 0x80, 0x02, 0xB0, 0x10, 0xBC, 0x08, 0xBC	; 0230ADDC
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xA8, 0x03, 0x00, 0x00, 0x00, 0x40, 0x80, 0x04	; 0230ADEC
	.byte 0xD0, 0x07, 0x00, 0x00, 0x55, 0x55, 0x00, 0x00, 0xF8, 0x05, 0x00, 0x00, 0x94, 0x81, 0x80, 0x04	; 0230ADFC
	.byte 0x10, 0x03, 0x00, 0x00, 0x16, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x40, 0x80, 0x80, 0x04	; 0230AE0C
	.byte 0x12, 0x80, 0x80, 0x04, 0x04, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0xFF, 0x3F, 0x00, 0x00	; 0230AE1C
	.byte 0xA0, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xCE, 0x7F, 0x03	; 0230AE2C
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x5D, 0x49, 0x09, 0x68, 0x5D, 0x4A, 0x8B, 0x5A	; 0230AE3C
	.byte 0xF0, 0x22, 0x13, 0x40, 0x10, 0x2B, 0x00, 0xD0, 0xAF, 0xE0, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9	; 0230AE4C
	.byte 0x05, 0x20, 0xAA, 0xE0, 0xA0, 0x8A, 0x0A, 0x28, 0x03, 0xD0, 0x14, 0x28, 0x01, 0xD0, 0x05, 0x20	; 0230AE5C
	.byte 0xA3, 0xE0, 0x01, 0x22, 0xE0, 0x8A, 0x82, 0x40, 0x53, 0x48, 0x08, 0x5A, 0x02, 0x40, 0x00, 0x2A	; 0230AE6C
	.byte 0x01, 0xD1, 0x05, 0x20, 0x99, 0xE0, 0x60, 0x8A, 0x04, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x94, 0xE0	; 0230AE7C
	.byte 0x00, 0x20, 0x05, 0xF0, 0xC7, 0xF9, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x8D, 0xE0, 0x20, 0x8A	; 0230AE8C
	.byte 0x00, 0x28, 0x54, 0xD0, 0x01, 0x28, 0x00, 0xD0, 0x86, 0xE0, 0x45, 0x48, 0x01, 0x68, 0x45, 0x48	; 0230AE9C
	.byte 0x09, 0x18, 0x08, 0x88, 0x10, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x7E, 0xE0, 0x60, 0x8A, 0x04, 0x28	; 0230AEAC
	.byte 0x7A, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44, 0x00, 0x47	; 0230AEBC
	.byte 0x0B, 0x00, 0x0B, 0x00, 0x0B, 0x00, 0x77, 0x00, 0x77, 0x00, 0x11, 0x20, 0x08, 0x80, 0x3B, 0x49	; 0230AECC
	.byte 0x3B, 0x48, 0x01, 0x80, 0xE0, 0x8A, 0x01, 0x21, 0xFB, 0xF7, 0x38, 0xFD, 0x34, 0x48, 0x01, 0x68	; 0230AEDC
	.byte 0x38, 0x48, 0x09, 0x18, 0x08, 0x88, 0x10, 0x22, 0x90, 0x43, 0xA2, 0x8A, 0x12, 0x03, 0x13, 0x0C	; 0230AEEC
	.byte 0x01, 0x22, 0x13, 0x40, 0x1A, 0x01, 0x10, 0x43, 0x08, 0x80, 0x02, 0x20, 0xFA, 0xF7, 0x06, 0xFE	; 0230AEFC
	.byte 0x01, 0x1C, 0x60, 0x8A, 0x01, 0x28, 0x01, 0xD8, 0x10, 0x20, 0x01, 0x43, 0xA2, 0x8A, 0x2E, 0x48	; 0230AF0C
	.byte 0x02, 0x80, 0x62, 0x8A, 0x01, 0x2A, 0x05, 0xD1, 0x20, 0x20, 0x01, 0x43, 0x03, 0x22, 0x2B, 0x48	; 0230AF1C
	.byte 0x02, 0x80, 0x01, 0xE0, 0x29, 0x48, 0x02, 0x80, 0x02, 0x20, 0xFA, 0xF7, 0xB9, 0xFD, 0x28, 0x49	; 0230AF2C
	.byte 0x28, 0x48, 0x01, 0x80, 0x38, 0xE0, 0x20, 0x1C, 0xFF, 0xF7, 0xFA, 0xFE, 0x34, 0xE0, 0x1C, 0x48	; 0230AF3C
	.byte 0x01, 0x68, 0x1C, 0x48, 0x08, 0x5A, 0x11, 0x28, 0x13, 0xD1, 0xFA, 0xF7, 0xA7, 0xFB, 0x00, 0x22	; 0230AF4C
	.byte 0x20, 0x48, 0x02, 0x80, 0x01, 0x21, 0x1D, 0x48, 0x01, 0x80, 0x19, 0x48, 0x02, 0x80, 0x02, 0x20	; 0230AF5C
	.byte 0xFA, 0xF7, 0xD4, 0xFD, 0x01, 0x1C, 0x02, 0x20, 0x30, 0x22, 0x91, 0x43, 0xFA, 0xF7, 0x98, 0xFD	; 0230AF6C
	.byte 0x15, 0xE0, 0x12, 0x28, 0x11, 0xD1, 0x13, 0x48, 0x0A, 0x18, 0x11, 0x88, 0x20, 0x20, 0x81, 0x43	; 0230AF7C
	.byte 0x11, 0x80, 0x15, 0x49, 0x08, 0x88, 0x00, 0x28, 0xFC, 0xD1, 0x06, 0x20, 0x08, 0x49, 0x0A, 0x68	; 0230AF8C
	.byte 0x12, 0x49, 0x51, 0x5A, 0xFA, 0xF7, 0x84, 0xFD, 0x01, 0xE0, 0x01, 0x20, 0x05, 0xE0, 0x10, 0x22	; 0230AF9C
	.byte 0x03, 0x48, 0x01, 0x68, 0x03, 0x48, 0x0A, 0x52, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230AFAC
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 0230AFBC
	.byte 0x40, 0x80, 0x80, 0x04, 0x16, 0x03, 0x00, 0x00, 0xA4, 0x81, 0x80, 0x04, 0xA2, 0x81, 0x80, 0x04	; 0230AFCC
	.byte 0x23, 0x08, 0x00, 0x00, 0xA0, 0x81, 0x80, 0x04, 0x04, 0x80, 0x80, 0x04, 0xA8, 0x03, 0x00, 0x00	; 0230AFDC
	.byte 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68, 0x03, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x00, 0x20	; 0230AFEC
	.byte 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x0C, 0x1C	; 0230AFFC
	.byte 0x0C, 0x48, 0x01, 0x68, 0x0C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD1, 0x01, 0x20, 0x0D, 0xE0	; 0230B00C
	.byte 0x5C, 0x20, 0x60, 0x80, 0xFB, 0xF7, 0xAE, 0xF8, 0x06, 0x48, 0x01, 0x68, 0x07, 0x48, 0x08, 0x18	; 0230B01C
	.byte 0x08, 0x34, 0x21, 0x1C, 0xB4, 0x22, 0x00, 0xF0, 0x0B, 0xF8, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC	; 0230B02C
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xF4, 0x04, 0x00, 0x00	; 0230B03C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x4C, 0xCE, 0x7F, 0x03, 0x10, 0xB5, 0x0C, 0x1C	; 0230B04C
	.byte 0x09, 0x20, 0x60, 0x80, 0x0B, 0x48, 0xA1, 0x1D, 0x08, 0x22, 0x00, 0xF0, 0x1B, 0xF8, 0x0A, 0x48	; 0230B05C
	.byte 0x00, 0x88, 0xE0, 0x81, 0x00, 0x20, 0xFA, 0xF7, 0x51, 0xFD, 0x20, 0x82, 0xFA, 0xF7, 0xE0, 0xFC	; 0230B06C
	.byte 0x60, 0x82, 0x06, 0x48, 0x01, 0x68, 0x06, 0x48, 0x08, 0x5A, 0xA0, 0x82, 0x00, 0x20, 0x10, 0xBC	; 0230B07C
	.byte 0x08, 0xBC, 0x18, 0x47, 0x9C, 0x08, 0x31, 0x02, 0x00, 0x80, 0x80, 0x04, 0xF4, 0xFF, 0x80, 0x03	; 0230B08C
	.byte 0xB0, 0x05, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x1C, 0xCE, 0x7F, 0x03	; 0230B09C
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x02, 0x68, 0x07, 0x48, 0x10, 0x5A, 0x00, 0x28, 0x01, 0xD1	; 0230B0AC
	.byte 0x01, 0x20, 0x04, 0xE0, 0x01, 0x20, 0x48, 0x80, 0xFB, 0xF7, 0x92, 0xF9, 0x00, 0x20, 0x01, 0xB0	; 0230B0BC
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 0230B0CC
	.byte 0x01, 0x20, 0x48, 0x80, 0x06, 0x48, 0x01, 0x68, 0x06, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD3	; 0230B0DC
	.byte 0xFA, 0xF7, 0x30, 0xFD, 0xF9, 0xF7, 0xB6, 0xFC, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47	; 0230B0EC
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x20, 0x48, 0x80	; 0230B0FC
	.byte 0x0B, 0x48, 0x01, 0x68, 0x0B, 0x48, 0x08, 0x5A, 0x10, 0x28, 0x07, 0xD0, 0x20, 0x28, 0x0A, 0xD1	; 0230B10C
	.byte 0x09, 0x48, 0x08, 0x5A, 0x40, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x04, 0xD1, 0x20, 0x20, 0xFB, 0xF7	; 0230B11C
	.byte 0xA7, 0xF9, 0x00, 0x20, 0x00, 0xE0, 0x01, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230B12C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x16, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 0230B13C
	.byte 0x01, 0x20, 0x48, 0x80, 0x0C, 0x49, 0x0A, 0x68, 0x0C, 0x49, 0x51, 0x5A, 0x20, 0x29, 0x10, 0xD8	; 0230B14C
	.byte 0x0B, 0x49, 0x51, 0x5A, 0x49, 0x07, 0xC9, 0x0F, 0x00, 0x29, 0x0A, 0xD1, 0x00, 0x20, 0x05, 0xF0	; 0230B15C
	.byte 0x59, 0xF8, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x03, 0xE0, 0x10, 0x20, 0xFB, 0xF7, 0x80, 0xF9	; 0230B16C
	.byte 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00	; 0230B17C
	.byte 0x16, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x20, 0x48, 0x80, 0x07, 0x49, 0x0A, 0x68	; 0230B18C
	.byte 0x07, 0x49, 0x51, 0x5A, 0x00, 0x29, 0x01, 0xD0, 0x10, 0x29, 0x03, 0xD1, 0x00, 0x20, 0xFB, 0xF7	; 0230B19C
	.byte 0x67, 0xF9, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230B1AC
	.byte 0x10, 0x03, 0x00, 0x00	; 0230B1B0

; ===== function loc_0230B1B0 =====
loc_0230B1B0:
	ldrh r2,[r1,#0xe]	; 0230B1B0
	lsl r2,r2,#0x1	; 0230B1B2
	add r3,r1,r2	; 0230B1B4
	add r3,#0x10	; 0230B1B6
	ldrh r2,[r3,#0x0]	; 0230B1B8
	strh r2,[r1,#0xc]	; 0230B1BA
	mov r2,#0x2	; 0230B1BC
	strh r2,[r3,#0x2]	; 0230B1BE
	mov r2,#0x0	; 0230B1C0
	strh r2,[r3,#0x4]	; 0230B1C2
	ldrh r2,[r1,#0x18]	; 0230B1C4
	strh r2,[r3,#0x6]	; 0230B1C6
	ldr r3,[pool_0230B1CC]	; 0230B1C8
	bx r3	; 0230B1CA
pool_0230B1CC:
loc_0230B1CC:
	.word loc_02309578 + 1	; 0230B1CC

; ===== function loc_0230B1D0 =====
	push {r4,lr}	; 0230B1D0
	add r4,r0,#0x0	; 0230B1D2
	mov r2,#0x1	; 0230B1D4
	strh r2,[r1,#0x2]	; 0230B1D6
	ldrh r0,[r4,#0x10]	; 0230B1D8
	and r0,r2	; 0230B1DA
	cmp r0,#0x0	; 0230B1DC
	beq loc_0230B1E4	; 0230B1DE
	bl loc_0230CE98	; 0230B1E0
loc_0230B1E4:
	ldrh r1,[r4,#0x10]	; 0230B1E4
	mov r0,#0x2	; 0230B1E6
	and r1,r0	; 0230B1E8
	cmp r1,#0x0	; 0230B1EA
	beq loc_0230B1F2	; 0230B1EC
	bl loc_0230CE5C	; 0230B1EE
loc_0230B1F2:
	ldrh r1,[r4,#0x10]	; 0230B1F2
	mov r0,#0x4	; 0230B1F4
	and r1,r0	; 0230B1F6
	cmp r1,#0x0	; 0230B1F8
	beq loc_0230B200	; 0230B1FA
	bl loc_0230CDE4	; 0230B1FC
loc_0230B200:
	mov r0,#0x0	; 0230B200
	pop {r4}	; 0230B202
	pop {r3}	; 0230B204
	bx r3	; 0230B206
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x0C, 0x48, 0xA0, 0x81, 0x20, 0x1C, 0x10, 0x30	; 0230B218
	.byte 0x00, 0x21, 0x41, 0x80, 0xC1, 0x88, 0x41, 0x82, 0xFE, 0xF7, 0x78, 0xF8, 0x08, 0x48, 0x02, 0x68	; 0230B228
	.byte 0x08, 0x48, 0x10, 0x18, 0x08, 0x49, 0x51, 0x18, 0x22, 0x1C, 0xF9, 0xF7, 0xBB, 0xFE, 0x00, 0x20	; 0230B238
	.byte 0x02, 0xF0, 0x1C, 0xFA, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xFF, 0xFF, 0x00, 0x00	; 0230B248
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xC4, 0x01, 0x00, 0x00, 0x58, 0x01, 0x00, 0x00, 0xF0, 0xB5, 0x87, 0xB0	; 0230B258
	.byte 0x05, 0x1C, 0xDC, 0x4B, 0x1A, 0x68, 0xDC, 0x48, 0x17, 0x18, 0x01, 0x20, 0x02, 0x90, 0x48, 0x80	; 0230B268
	.byte 0x19, 0x68, 0xDA, 0x48, 0x08, 0x5A, 0x01, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0xE1, 0xE1, 0xB8, 0x8F	; 0230B278
	.byte 0x00, 0x28, 0x01, 0xD0, 0x08, 0x20, 0xDC, 0xE1, 0x7C, 0x6C, 0x2A, 0x8A, 0xD4, 0x48, 0x11, 0x1C	; 0230B288
	.byte 0x01, 0x40, 0x00, 0x29, 0x24, 0xD0, 0x02, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x03, 0xD1, 0x38, 0x1C	; 0230B298
	.byte 0x94, 0x30, 0x00, 0x88, 0xA8, 0x82, 0x29, 0x8A, 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1	; 0230B2A8
	.byte 0x38, 0x1C, 0xA0, 0x30, 0x00, 0x88, 0xE8, 0x82, 0x29, 0x8A, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29	; 0230B2B8
	.byte 0x03, 0xD1, 0x38, 0x1C, 0x96, 0x30, 0x00, 0x88, 0x28, 0x83, 0x29, 0x8A, 0x10, 0x20, 0x01, 0x40	; 0230B2C8
	.byte 0x00, 0x29, 0x05, 0xD1, 0x38, 0x1C, 0x9C, 0x30, 0x00, 0x88, 0xA8, 0x83, 0x00, 0x20, 0x02, 0x90	; 0230B2D8
	.byte 0xA9, 0x8B, 0xC0, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0xAA, 0xE1, 0x02, 0x20, 0x00, 0x21	; 0230B2E8
	.byte 0x01, 0x91, 0x08, 0xE0, 0xE9, 0x8A, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x01, 0x99, 0x49, 0x1C	; 0230B2F8
	.byte 0x01, 0x91, 0x40, 0x04, 0x00, 0x0C, 0x00, 0x28, 0xF4, 0xD1, 0xA9, 0x8A, 0x38, 0x1C, 0x94, 0x30	; 0230B308
	.byte 0x01, 0x80, 0xA8, 0x8A, 0x06, 0x90, 0xB2, 0x48, 0x06, 0x99, 0x01, 0x40, 0x00, 0x29, 0x11, 0xD0	; 0230B318
	.byte 0x2A, 0x1C, 0x14, 0x32, 0x11, 0x88, 0xB0, 0x48, 0x01, 0x40, 0x11, 0x80, 0xA8, 0x8A, 0xD0, 0x38	; 0230B328
	.byte 0x80, 0x08, 0x06, 0x90, 0xEA, 0x20, 0xE0, 0x81, 0xAC, 0x49, 0x06, 0x98, 0x88, 0x42, 0x22, 0xD9	; 0230B338
	.byte 0x05, 0x20, 0x7E, 0xE1, 0xA3, 0x48, 0x01, 0x68, 0xA9, 0x48, 0x09, 0x5A, 0x02, 0x20, 0x01, 0x40	; 0230B348
	.byte 0x00, 0x29, 0x0D, 0xD0, 0x06, 0x98, 0x40, 0x1C, 0x06, 0x90, 0xA6, 0x49, 0x88, 0x42, 0x01, 0xD9	; 0230B358
	.byte 0x05, 0x20, 0x6E, 0xE1, 0x80, 0x00, 0xD2, 0x30, 0xA8, 0x82, 0xF0, 0x20, 0xE0, 0x81, 0x0A, 0xE0	; 0230B368
	.byte 0xA1, 0x49, 0x06, 0x98, 0x88, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x62, 0xE1, 0x80, 0x00, 0xD0, 0x30	; 0230B378
	.byte 0xA8, 0x82, 0xEA, 0x20, 0xE0, 0x81, 0x06, 0x98, 0x09, 0x30, 0x06, 0x90, 0x01, 0x20, 0x06, 0x99	; 0230B388
	.byte 0x81, 0x43, 0x06, 0x91, 0x03, 0x91, 0x01, 0x98, 0x41, 0x43, 0x03, 0x91, 0x8D, 0x48, 0x01, 0x68	; 0230B398
	.byte 0x96, 0x48, 0x08, 0x18, 0x03, 0x99, 0x1A, 0x31, 0xF9, 0xF7, 0x58, 0xFE, 0x39, 0x1C, 0x90, 0x31	; 0230B3A8
	.byte 0x08, 0x60, 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD1, 0x08, 0x20, 0x40, 0xE1	; 0230B3B8
	.byte 0x01, 0x20, 0xB8, 0x87, 0x39, 0x1C, 0x3E, 0x31, 0x08, 0x88, 0x40, 0x1C, 0x08, 0x80, 0x29, 0x8B	; 0230B3C8
	.byte 0x38, 0x1C, 0x96, 0x30, 0x01, 0x80, 0xE9, 0x8A, 0x38, 0x1C, 0x98, 0x30, 0x01, 0x80, 0x00, 0x20	; 0230B3D8
	.byte 0x39, 0x1C, 0x9A, 0x31, 0x08, 0x80, 0xAA, 0x8B, 0x39, 0x1C, 0x9C, 0x31, 0x0A, 0x80, 0x6A, 0x8A	; 0230B3E8
	.byte 0x39, 0x1C, 0x9E, 0x31, 0x0A, 0x80, 0x20, 0x80, 0xE9, 0x8A, 0x61, 0x80, 0xA0, 0x80, 0x14, 0x20	; 0230B3F8
	.byte 0x20, 0x81, 0xA8, 0x8B, 0x22, 0x30, 0x60, 0x81, 0x7D, 0x48, 0xA0, 0x81, 0x20, 0x1C, 0x0E, 0x30	; 0230B408
	.byte 0x03, 0x88, 0xAA, 0x8A, 0x0A, 0x32, 0x01, 0x99, 0x4A, 0x43, 0x99, 0x18, 0x01, 0x80, 0x6D, 0x48	; 0230B418
	.byte 0x00, 0x68, 0x04, 0x90, 0x20, 0x1C, 0x10, 0x30, 0x76, 0x49, 0x77, 0x4B, 0x04, 0x9A, 0xD2, 0x18	; 0230B428
	.byte 0x76, 0x4E, 0x04, 0x9B, 0x9B, 0x19, 0xFA, 0xF7, 0xF1, 0xFF, 0x29, 0x8A, 0x68, 0x48, 0x01, 0x40	; 0230B438
	.byte 0x00, 0x29, 0x06, 0xD0, 0x61, 0x8C, 0x72, 0x48, 0x81, 0x42, 0x02, 0xD0, 0x71, 0x48, 0x00, 0x90	; 0230B448
	.byte 0x03, 0xE0, 0x00, 0x20, 0x00, 0x90, 0x6E, 0x48, 0x60, 0x84, 0xA8, 0x8A, 0xA0, 0x84, 0xE8, 0x8A	; 0230B458
	.byte 0xE0, 0x84, 0xE8, 0x8B, 0x20, 0x85, 0x02, 0x98, 0x00, 0x28, 0x07, 0xD0, 0xAA, 0x8B, 0x00, 0x2A	; 0230B468
	.byte 0x04, 0xD0, 0x20, 0x1C, 0x2A, 0x30, 0x29, 0x6A, 0xF9, 0xF7, 0xF4, 0xFF, 0x55, 0x48, 0x01, 0x68	; 0230B478
	.byte 0x5B, 0x48, 0x09, 0x5A, 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x21, 0x1C, 0x28, 0x31	; 0230B488
	.byte 0xA8, 0x8B, 0x80, 0x1C, 0x08, 0x18, 0xC1, 0x1C, 0x03, 0x20, 0x81, 0x43, 0x5E, 0x48, 0x08, 0x80	; 0230B498
	.byte 0x5E, 0x48, 0x48, 0x80, 0x5E, 0x49, 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x81, 0x81, 0x03, 0x98	; 0230B4A8
	.byte 0x0B, 0x30, 0x03, 0x90, 0x41, 0x08, 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0xC1, 0x81, 0xE9, 0x8A	; 0230B4B8
	.byte 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x01, 0x82, 0x38, 0x1C, 0x90, 0x30, 0x01, 0x68, 0x01, 0x98	; 0230B4C8
	.byte 0x88, 0x82, 0x38, 0x1C, 0x90, 0x30, 0x01, 0x68, 0x06, 0x98, 0xC8, 0x82, 0x38, 0x1C, 0x90, 0x30	; 0230B4D8
	.byte 0x01, 0x68, 0x00, 0x20, 0x08, 0x83, 0x38, 0x1C, 0x90, 0x30, 0x02, 0x68, 0x1A, 0x32, 0x01, 0x21	; 0230B4E8
	.byte 0x02, 0x20, 0x0E, 0xE0, 0xEB, 0x8A, 0x03, 0x40, 0x00, 0x2B, 0x07, 0xD0, 0x44, 0x4B, 0x13, 0x80	; 0230B4F8
	.byte 0x00, 0x23, 0x53, 0x80, 0xD3, 0x80, 0x91, 0x80, 0x06, 0x9B, 0xD2, 0x18, 0x40, 0x04, 0x00, 0x0C	; 0230B508
	.byte 0x49, 0x1C, 0x00, 0x28, 0xEE, 0xD1, 0xA9, 0x8A, 0x42, 0x48, 0x01, 0x80, 0xE1, 0x89, 0x42, 0x48	; 0230B518
	.byte 0x01, 0x80, 0x69, 0x8B, 0x31, 0x48, 0x46, 0x1A, 0x28, 0x8B, 0x00, 0x28, 0x1E, 0xD1, 0xA8, 0x8B	; 0230B528
	.byte 0x22, 0x30, 0x82, 0x00, 0x60, 0x32, 0xA9, 0x8A, 0x01, 0x98, 0x41, 0x43, 0x3B, 0x48, 0x08, 0x18	; 0230B538
	.byte 0x10, 0x18, 0x32, 0x30, 0x0A, 0x21, 0x00, 0xF0, 0x81, 0xF8, 0x05, 0x1C, 0x00, 0xF0, 0x84, 0xF8	; 0230B548
	.byte 0x37, 0x49, 0x0D, 0x80, 0x37, 0x49, 0x0C, 0x40, 0x62, 0x08, 0x21, 0x49, 0x0A, 0x43, 0x00, 0x99	; 0230B558
	.byte 0x0A, 0x43, 0x35, 0x49, 0x0A, 0x80, 0x00, 0xF0, 0x7D, 0xF8, 0x69, 0xE0, 0x00, 0xF0, 0x80, 0xF8	; 0230B568
	.byte 0x05, 0x90, 0x32, 0x48, 0x00, 0x88, 0x30, 0x18, 0x25, 0x49, 0x08, 0x40, 0x0A, 0x21, 0x00, 0xF0	; 0230B578
	.byte 0x7D, 0xF8, 0x2A, 0x8B, 0xC1, 0x1C, 0x91, 0x42, 0x10, 0xD2, 0x10, 0x1A, 0x41, 0x1E, 0x28, 0x48	; 0230B588
	.byte 0x01, 0x80, 0x28, 0x48, 0x04, 0x40, 0x61, 0x08, 0x11, 0x48, 0x01, 0x43, 0x00, 0x98, 0x01, 0x43	; 0230B598
	.byte 0x25, 0x48, 0x01, 0x80, 0x05, 0x98, 0x00, 0xF0, 0x6F, 0xF8, 0x49, 0xE0, 0x05, 0x98, 0x00, 0xF0	; 0230B5A8
	.byte 0x71, 0xF8, 0x08, 0x48, 0x01, 0x68, 0x11, 0x48, 0x08, 0x18, 0x39, 0x1C, 0x90, 0x31, 0x09, 0x68	; 0230B5B8
	.byte 0xF9, 0xF7, 0x20, 0xFD, 0x00, 0x20, 0xB8, 0x87, 0x3E, 0x37, 0x38, 0x88, 0x40, 0x1E, 0x38, 0x80	; 0230B5C8
	.byte 0x05, 0x20, 0x36, 0xE0, 0xF4, 0xFF, 0x80, 0x03, 0xE4, 0x03, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00	; 0230B5D8
	.byte 0x00, 0x80, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 0230B5E8
	.byte 0x1C, 0x06, 0x00, 0x00, 0x03, 0x02, 0x00, 0x00, 0x02, 0x02, 0x00, 0x00, 0x4C, 0x01, 0x00, 0x00	; 0230B5F8
	.byte 0x28, 0x02, 0x00, 0x00, 0x94, 0x03, 0x31, 0x02, 0x60, 0x03, 0x00, 0x00, 0xE8, 0x02, 0x00, 0x00	; 0230B608
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0xB8, 0xB6, 0x00, 0x00, 0x46, 0x1D, 0x00, 0x00	; 0230B618
	.byte 0x84, 0x01, 0x00, 0x00, 0xC4, 0x80, 0x80, 0x04, 0xC0, 0x80, 0x80, 0x04, 0x88, 0x03, 0x00, 0x00	; 0230B628
	.byte 0x18, 0x81, 0x80, 0x04, 0xFF, 0x3F, 0x00, 0x00, 0x90, 0x80, 0x80, 0x04, 0xF8, 0x80, 0x80, 0x04	; 0230B638
	.byte 0x00, 0x20, 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x78, 0x47, 0xC0, 0x46	; 0230B648
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x20, 0x27, 0x80, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 0230B658
	.byte 0xF0, 0xCB, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xCC, 0x7F, 0x03	; 0230B668
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0xF0, 0xCB, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46	; 0230B678
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x20, 0x27, 0x80, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 0230B688
	.byte 0x04, 0xCC, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xCC, 0x7F, 0x03	; 0230B698
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x3A, 0x48, 0x04, 0x68, 0x3A, 0x4A, 0xA3, 0x18, 0x3A, 0x4A	; 0230B6A8
	.byte 0xA2, 0x18, 0x01, 0x26, 0x4E, 0x80, 0x00, 0x68, 0x38, 0x49, 0x41, 0x5A, 0x02, 0x29, 0x01, 0xD0	; 0230B6B8
	.byte 0x0B, 0x20, 0x61, 0xE0, 0x2C, 0x8A, 0x36, 0x49, 0x8C, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x5B, 0xE0	; 0230B6C8
	.byte 0x34, 0x49, 0x41, 0x5A, 0x00, 0x29, 0x00, 0xD1, 0x00, 0x26, 0x14, 0x27, 0x7E, 0x43, 0x84, 0x19	; 0230B6D8
	.byte 0x30, 0x48, 0x20, 0x5A, 0x00, 0x28, 0x01, 0xD0, 0x08, 0x20, 0x4D, 0xE0, 0x2E, 0x48, 0x01, 0x88	; 0230B6E8
	.byte 0x2E, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x08, 0x20, 0x45, 0xE0, 0x2C, 0x48, 0x24, 0x58	; 0230B6F8
	.byte 0x00, 0x20, 0x20, 0x80, 0xA0, 0x80, 0x27, 0x81, 0x28, 0x8A, 0x1E, 0x30, 0x60, 0x81, 0x29, 0x48	; 0230B708
	.byte 0xA0, 0x81, 0x20, 0x1C, 0x10, 0x30, 0x58, 0x33, 0x19, 0x1C, 0x08, 0x32, 0x26, 0x4B, 0xFA, 0xF7	; 0230B718
	.byte 0x7D, 0xFE, 0x68, 0x8A, 0xA0, 0x84, 0x2A, 0x8A, 0x00, 0x2A, 0x04, 0xD0, 0x20, 0x1C, 0x26, 0x30	; 0230B728
	.byte 0x69, 0x69, 0xF9, 0xF7, 0x97, 0xFE, 0x16, 0x48, 0x01, 0x68, 0x20, 0x48, 0x09, 0x5A, 0x04, 0x20	; 0230B738
	.byte 0x01, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x21, 0x1C, 0x24, 0x31, 0x28, 0x8A, 0x80, 0x1C, 0x08, 0x18	; 0230B748
	.byte 0xC1, 0x1C, 0x03, 0x20, 0x81, 0x43, 0x1A, 0x48, 0x08, 0x80, 0x1A, 0x48, 0x48, 0x80, 0x01, 0x23	; 0230B758
	.byte 0x0B, 0x4A, 0x10, 0x68, 0x81, 0x19, 0x0F, 0x48, 0x0B, 0x52, 0x10, 0x68, 0x81, 0x19, 0x16, 0x48	; 0230B768
	.byte 0x09, 0x18, 0x08, 0x88, 0x40, 0x1C, 0x08, 0x80, 0x14, 0x48, 0x04, 0x40, 0x61, 0x08, 0x0B, 0x48	; 0230B778
	.byte 0x01, 0x43, 0x09, 0x48, 0x01, 0x80, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230B788
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x08, 0x03, 0x00, 0x00, 0xE0, 0x02, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00	; 0230B798
	.byte 0x00, 0x02, 0x00, 0x00, 0x34, 0x04, 0x00, 0x00, 0x94, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00	; 0230B7A8
	.byte 0x3C, 0x04, 0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x84, 0x03, 0x31, 0x02, 0x1C, 0x06, 0x00, 0x00	; 0230B7B8
	.byte 0xB8, 0xB6, 0x00, 0x00, 0x46, 0x1D, 0x00, 0x00, 0x36, 0x04, 0x00, 0x00, 0xFF, 0x3F, 0x00, 0x00	; 0230B7C8
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x06, 0x1C, 0x75, 0x48, 0x00, 0x68, 0x75, 0x49, 0x45, 0x18, 0x34, 0x1C	; 0230B7D8
	.byte 0x10, 0x34, 0xF2, 0x8A, 0x73, 0x49, 0x8A, 0x42, 0x01, 0xD9, 0x05, 0x20, 0xDA, 0xE0, 0x72, 0x49	; 0230B7E8
	.byte 0x41, 0x5A, 0x01, 0x29, 0x04, 0xD0, 0x02, 0x29, 0x7C, 0xD0, 0x03, 0x29, 0x7A, 0xD0, 0xD0, 0xE0	; 0230B7F8
	.byte 0x6E, 0x49, 0x40, 0x58, 0xA0, 0x80, 0x20, 0x1C, 0x18, 0x30, 0xFD, 0xF7, 0x4D, 0xFE, 0x07, 0x1C	; 0230B808
	.byte 0xFF, 0x2F, 0x09, 0xD0, 0x1C, 0x20, 0x3A, 0x1C, 0x42, 0x43, 0x64, 0x48, 0x01, 0x68, 0x68, 0x48	; 0230B818
	.byte 0x08, 0x58, 0x80, 0x5A, 0x40, 0x28, 0x01, 0xD0, 0x0A, 0x20, 0xBB, 0xE0, 0x67, 0x80, 0xE1, 0x89	; 0230B828
	.byte 0xFF, 0x20, 0x0B, 0x1C, 0x03, 0x40, 0x18, 0x04, 0x00, 0x0C, 0x00, 0x28, 0x07, 0xD1, 0x5B, 0x48	; 0230B838
	.byte 0x01, 0x68, 0x5F, 0x48, 0x08, 0x58, 0x80, 0x18, 0x40, 0x8A, 0x20, 0x82, 0x02, 0xE0, 0x21, 0x82	; 0230B848
	.byte 0x00, 0x20, 0xE0, 0x81, 0xE0, 0x88, 0x00, 0x28, 0x0A, 0xD1, 0x28, 0x1C, 0x7E, 0x30, 0x01, 0x88	; 0230B858
	.byte 0x40, 0x20, 0x01, 0x43, 0x57, 0x48, 0x01, 0x40, 0xA1, 0x82, 0x1C, 0x20, 0x60, 0x82, 0x10, 0xE0	; 0230B868
	.byte 0x28, 0x1C, 0x7E, 0x30, 0x00, 0x88, 0xA0, 0x82, 0x4C, 0x48, 0x01, 0x68, 0x52, 0x48, 0x08, 0x5A	; 0230B878
	.byte 0x00, 0x28, 0x03, 0xD1, 0xE0, 0x88, 0x1C, 0x30, 0x60, 0x82, 0x02, 0xE0, 0xE0, 0x88, 0x24, 0x30	; 0230B888
	.byte 0x60, 0x82, 0x20, 0x1C, 0x24, 0x30, 0x21, 0x1C, 0x1E, 0x31, 0xFA, 0xF7, 0xE3, 0xFD, 0x20, 0x1C	; 0230B898
	.byte 0x1E, 0x30, 0x58, 0x35, 0x29, 0x1C, 0xFA, 0xF7, 0xDD, 0xFD, 0x00, 0x2F, 0x12, 0xD1, 0x3F, 0x48	; 0230B8A8
	.byte 0x01, 0x68, 0x46, 0x48, 0x08, 0x18, 0x31, 0x1C, 0xFD, 0xF7, 0x60, 0xFD, 0x3B, 0x48, 0x02, 0x68	; 0230B8B8
	.byte 0x43, 0x48, 0x11, 0x5A, 0x43, 0x48, 0x10, 0x5A, 0x81, 0x43, 0x00, 0x29, 0x69, 0xD1, 0x01, 0xF0	; 0230B8C8
	.byte 0x7F, 0xFE, 0x66, 0xE0, 0x20, 0x1C, 0xFD, 0xF7, 0x21, 0xFD, 0x34, 0x48, 0x02, 0x68, 0x3B, 0x48	; 0230B8D8
	.byte 0x10, 0x18, 0x3D, 0x49, 0x51, 0x18, 0x32, 0x1C, 0xF9, 0xF7, 0x64, 0xFB, 0x00, 0x20, 0x01, 0xF0	; 0230B8E8
	.byte 0xC5, 0xFE, 0x56, 0xE0, 0x31, 0x49, 0x40, 0x58, 0xA0, 0x80, 0x28, 0x1C, 0x7C, 0x30, 0x00, 0x88	; 0230B8F8
	.byte 0x60, 0x80, 0xE0, 0x89, 0xFF, 0x21, 0x02, 0x1C, 0x0A, 0x40, 0x11, 0x04, 0x09, 0x0C, 0x00, 0x29	; 0230B908
	.byte 0x0C, 0xD1, 0x26, 0x48, 0x01, 0x68, 0x2A, 0x48, 0x0A, 0x58, 0x28, 0x1C, 0x7C, 0x30, 0x01, 0x88	; 0230B918
	.byte 0x1C, 0x20, 0x41, 0x43, 0x50, 0x18, 0x40, 0x8A, 0x20, 0x82, 0x00, 0xE0, 0x20, 0x82, 0xE0, 0x88	; 0230B928
	.byte 0x00, 0x28, 0x0A, 0xD1, 0x28, 0x1C, 0x7E, 0x30, 0x01, 0x88, 0x40, 0x20, 0x01, 0x43, 0x21, 0x48	; 0230B938
	.byte 0x01, 0x40, 0xA1, 0x82, 0x1C, 0x20, 0x60, 0x82, 0x10, 0xE0, 0x28, 0x1C, 0x7E, 0x30, 0x00, 0x88	; 0230B948
	.byte 0xA0, 0x82, 0x16, 0x48, 0x01, 0x68, 0x1C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x03, 0xD1, 0xE0, 0x88	; 0230B958
	.byte 0x1C, 0x30, 0x60, 0x82, 0x02, 0xE0, 0xE0, 0x88, 0x24, 0x30, 0x60, 0x82, 0x20, 0x1C, 0x24, 0x30	; 0230B968
	.byte 0x21, 0x1C, 0x18, 0x31, 0xFA, 0xF7, 0x76, 0xFD, 0x20, 0x1C, 0x18, 0x30, 0x58, 0x35, 0x29, 0x1C	; 0230B978
	.byte 0xFA, 0xF7, 0x70, 0xFD, 0x20, 0x1C, 0xFD, 0xF7, 0xC9, 0xFC, 0x08, 0x48, 0x02, 0x68, 0x0F, 0x48	; 0230B988
	.byte 0x10, 0x18, 0x11, 0x49, 0x51, 0x18, 0x32, 0x1C, 0xF9, 0xF7, 0x0C, 0xFB, 0x00, 0x20, 0x01, 0xF0	; 0230B998
	.byte 0x6D, 0xFE, 0x81, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 0230B9A8
	.byte 0x08, 0x03, 0x00, 0x00, 0xE4, 0x05, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00, 0xA4, 0x03, 0x00, 0x00	; 0230B9B8
	.byte 0xE0, 0x02, 0x00, 0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xF8, 0x02, 0x00, 0x00, 0xC4, 0x01, 0x00, 0x00	; 0230B9C8
	.byte 0xEA, 0x04, 0x00, 0x00, 0xEE, 0x04, 0x00, 0x00, 0x58, 0x01, 0x00, 0x00	; 0230B9D4

; ===== function loc_0230B9D4 =====
loc_0230B9D4:
	push {lr}	; 0230B9D4
	sub sp,#0x14	; 0230B9D6
	mov r0,#0x0	; 0230B9D8
	str r0,[sp,#0x0]	; 0230B9DA
	ldr r0,[sp,#0x0]	; 0230B9DC
	ldr r1,[pool_0230BCB8]	; 0230B9DE
	ldr r2,[r1,#0x0]	; 0230B9E0
	ldr r1,[pool_0230BCBC]	; 0230B9E2
	add r1,r2,r1	; 0230B9E4
	mov r2,#0xb4	; 0230B9E6
	bl loc_0230BDE4	; 0230B9E8
	mov r1,#0x0	; 0230B9EC
	ldr r0,[pool_0230BCB8]	; 0230B9EE
	ldr r3,[r0,#0x0]	; 0230B9F0
	ldr r2,[pool_0230BCBC]	; 0230B9F2
	strh r1,[r3,r2]	; 0230B9F4
	ldr r3,[r0,#0x0]	; 0230B9F6
	ldr r2,[pool_0230BCC0]	; 0230B9F8
	str r1,[r3,r2]	; 0230B9FA
	ldr r3,[r0,#0x0]	; 0230B9FC
	ldr r2,[pool_0230BCC4]	; 0230B9FE
	strh r1,[r3,r2]	; 0230BA00
	ldr r3,[r0,#0x0]	; 0230BA02
	ldr r2,[pool_0230BCC8]	; 0230BA04
	str r1,[r3,r2]	; 0230BA06
	ldr r3,[r0,#0x0]	; 0230BA08
	ldr r2,[pool_0230BCCC]	; 0230BA0A
	strh r1,[r3,r2]	; 0230BA0C
	ldr r3,[r0,#0x0]	; 0230BA0E
	ldr r2,[pool_0230BCD0]	; 0230BA10
	str r1,[r3,r2]	; 0230BA12
	ldr r3,[pool_0230BCD4]	; 0230BA14
	ldr r2,[r0,#0x0]	; 0230BA16
	ldr r1,[pool_0230BCD8]	; 0230BA18
	strh r3,[r2,r1]	; 0230BA1A
	ldr r2,[r0,#0x0]	; 0230BA1C
	ldr r1,[pool_0230BCDC]	; 0230BA1E
	strh r3,[r2,r1]	; 0230BA20
	ldr r1,[r0,#0x0]	; 0230BA22
	ldr r2,[pool_0230BCE0]	; 0230BA24
	ldrh r2,[r1,r2]	; 0230BA26
	cmp r2,#0x3	; 0230BA28
	bls loc_0230BA2E	; 0230BA2A
	b loc_0230BCB0	; 0230BA2C
loc_0230BA2E:
	add r2,r2,r2	; 0230BA2E
P4_SwitchIndexPC_0230BA2E:
	add r2,pc	; 0230BA30
	ldrh r2,[r2,#(P4_SwitchTable_0230BA2E - (P4_SwitchIndexPC_0230BA2E + 4))]	; 0230BA32
	lsl r2,r2,#0x10	; 0230BA34
	asr r2,r2,#0x10	; 0230BA36
P4_SwitchTargetPC_0230BA2E:
	add r2,pc	; 0230BA38
	bx r2	; 0230BA3A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230BA2E:
	.halfword (loc_0230BA44 + 1) - (P4_SwitchTargetPC_0230BA2E + 4)
	.halfword (loc_0230BA96 + 1) - (P4_SwitchTargetPC_0230BA2E + 4)
	.halfword (loc_0230BB5A + 1) - (P4_SwitchTargetPC_0230BA2E + 4)
	.halfword (loc_0230BC16 + 1) - (P4_SwitchTargetPC_0230BA2E + 4)
P4_SwitchTable_0230BA2EEnd:
loc_0230BA44:
	ldr r3,[pool_0230BCE4]	; 0230BA44
	ldr r2,[pool_0230BCE8]	; 0230BA46
	str r3,[r1,r2]	; 0230BA48
	ldr r3,[pool_0230BCEC]	; 0230BA4A
	ldr r2,[r0,#0x0]	; 0230BA4C
	ldr r1,[pool_0230BCF0]	; 0230BA4E
	str r3,[r2,r1]	; 0230BA50
	ldr r3,[pool_0230BCF4]	; 0230BA52
	ldr r2,[r0,#0x0]	; 0230BA54
	ldr r1,[pool_0230BCF8]	; 0230BA56
	str r3,[r2,r1]	; 0230BA58
	ldr r3,[pool_0230BCFC]	; 0230BA5A
	ldr r2,[r0,#0x0]	; 0230BA5C
	ldr r1,[pool_0230BD00]	; 0230BA5E
	str r3,[r2,r1]	; 0230BA60
	ldr r3,[pool_0230BD04]	; 0230BA62
	ldr r2,[r0,#0x0]	; 0230BA64
	ldr r1,[pool_0230BD08]	; 0230BA66
	str r3,[r2,r1]	; 0230BA68
	ldr r2,[pool_0230BD0C]	; 0230BA6A
	ldr r1,[r0,#0x0]	; 0230BA6C
	ldr r0,[pool_0230BD10]	; 0230BA6E
	str r2,[r1,r0]	; 0230BA70
	ldr r2,[pool_0230BD14]	; 0230BA72
	ldr r0,[pool_0230BD18]	; 0230BA74
	strh r2,[r0,#0x0]	; 0230BA76
	ldr r1,[pool_0230BD1C]	; 0230BA78
	ldr r0,[pool_0230BD20]	; 0230BA7A
	strh r1,[r0,#0x0]	; 0230BA7C
	ldr r0,[pool_0230BD24]	; 0230BA7E
	strh r2,[r0,#0x0]	; 0230BA80
	ldr r0,[pool_0230BD28]	; 0230BA82
	strh r1,[r0,#0x0]	; 0230BA84
	ldr r0,[pool_0230BD2C]	; 0230BA86
	strh r2,[r0,#0x0]	; 0230BA88
	ldr r0,[pool_0230BD30]	; 0230BA8A
	strh r1,[r0,#0x0]	; 0230BA8C
	mov r1,#0x1	; 0230BA8E
	ldr r0,[pool_0230BD34]	; 0230BA90
	strh r1,[r0,#0x0]	; 0230BA92
	b loc_0230BCB0	; 0230BA94
loc_0230BA96:
	ldr r3,[pool_0230BD38]	; 0230BA96
	ldr r2,[pool_0230BCE8]	; 0230BA98
	str r3,[r1,r2]	; 0230BA9A
	ldr r3,[pool_0230BD3C]	; 0230BA9C
	ldr r2,[r0,#0x0]	; 0230BA9E
	ldr r1,[pool_0230BCF0]	; 0230BAA0
	str r3,[r2,r1]	; 0230BAA2
	ldr r3,[pool_0230BD40]	; 0230BAA4
	ldr r2,[r0,#0x0]	; 0230BAA6
	ldr r1,[pool_0230BCF8]	; 0230BAA8
	str r3,[r2,r1]	; 0230BAAA
	ldr r3,[pool_0230BCFC]	; 0230BAAC
	ldr r2,[r0,#0x0]	; 0230BAAE
	ldr r1,[pool_0230BD00]	; 0230BAB0
	str r3,[r2,r1]	; 0230BAB2
	ldr r3,[pool_0230BD04]	; 0230BAB4
	ldr r2,[r0,#0x0]	; 0230BAB6
	ldr r1,[pool_0230BD08]	; 0230BAB8
	str r3,[r2,r1]	; 0230BABA
	ldr r3,[pool_0230BD44]	; 0230BABC
	ldr r2,[r0,#0x0]	; 0230BABE
	ldr r1,[pool_0230BD10]	; 0230BAC0
	str r3,[r2,r1]	; 0230BAC2
	ldr r3,[pool_0230BD48]	; 0230BAC4
	ldr r2,[r0,#0x0]	; 0230BAC6
	ldr r1,[pool_0230BD4C]	; 0230BAC8
	str r3,[r2,r1]	; 0230BACA
	ldr r3,[pool_0230BCF4]	; 0230BACC
	ldr r2,[r0,#0x0]	; 0230BACE
	ldr r1,[pool_0230BD50]	; 0230BAD0
	str r3,[r2,r1]	; 0230BAD2
	ldr r2,[pool_0230BD14]	; 0230BAD4
	ldr r1,[pool_0230BD54]	; 0230BAD6
	strh r2,[r1,#0x0]	; 0230BAD8
	ldr r1,[pool_0230BD1C]	; 0230BADA
	ldr r3,[pool_0230BD58]	; 0230BADC
	strh r1,[r3,#0x0]	; 0230BADE
	ldr r3,[pool_0230BD5C]	; 0230BAE0
	strh r2,[r3,#0x0]	; 0230BAE2
	ldr r3,[pool_0230BD60]	; 0230BAE4
	strh r1,[r3,#0x0]	; 0230BAE6
	ldr r3,[pool_0230BD64]	; 0230BAE8
	strh r2,[r3,#0x0]	; 0230BAEA
	ldr r3,[pool_0230BD68]	; 0230BAEC
	strh r1,[r3,#0x0]	; 0230BAEE
	ldr r3,[pool_0230BD6C]	; 0230BAF0
	strh r2,[r3,#0x0]	; 0230BAF2
	ldr r3,[pool_0230BD70]	; 0230BAF4
	strh r1,[r3,#0x0]	; 0230BAF6
	ldr r3,[pool_0230BD74]	; 0230BAF8
	strh r2,[r3,#0x0]	; 0230BAFA
	ldr r2,[pool_0230BD78]	; 0230BAFC
	strh r1,[r2,#0x0]	; 0230BAFE
	ldr r2,[r0,#0x0]	; 0230BB00
	ldr r0,[pool_0230BD7C]	; 0230BB02
	ldrh r0,[r2,r0]	; 0230BB04
	cmp r0,#0x0	; 0230BB06
	bne loc_0230BB12	; 0230BB08
	ldr r1,[pool_0230BD80]	; 0230BB0A
	ldr r0,[pool_0230BD84]	; 0230BB0C
	strh r1,[r2,r0]	; 0230BB0E
	b loc_0230BB18	; 0230BB10
loc_0230BB12:
	ldr r1,[pool_0230BD88]	; 0230BB12
	ldr r0,[pool_0230BD84]	; 0230BB14
	strh r1,[r2,r0]	; 0230BB16
loc_0230BB18:
	mov r0,#0x0	; 0230BB18
	str r0,[sp,#0x4]	; 0230BB1A
	ldr r0,[sp,#0x4]	; 0230BB1C
	ldr r1,[pool_0230BCB8]	; 0230BB1E
	ldr r2,[r1,#0x0]	; 0230BB20
	ldr r1,[pool_0230BD8C]	; 0230BB22
	add r1,r2,r1	; 0230BB24
	mov r2,#0x2c	; 0230BB26
	bl loc_0230BDF0	; 0230BB28
	bl loc_0230602C	; 0230BB2C
	ldr r3,[pool_0230BCB8]	; 0230BB30
	ldr r2,[r3,#0x0]	; 0230BB32
	ldr r1,[pool_0230BD90]	; 0230BB34
	strh r0,[r2,r1]	; 0230BB36
	ldr r3,[r3,#0x0]	; 0230BB38
	ldr r0,[pool_0230BD94]	; 0230BB3A
	add r0,r3,r0	; 0230BB3C
	ldr r1,[pool_0230BD98]	; 0230BB3E
	add r1,r3,r1	; 0230BB40
	ldr r2,[pool_0230BD9C]	; 0230BB42
	add r2,r3,r2	; 0230BB44
	bl loc_02306440	; 0230BB46
	ldr r2,[pool_0230BD48]	; 0230BB4A
	ldr r0,[pool_0230BCB8]	; 0230BB4C
	ldr r1,[r0,#0x0]	; 0230BB4E
	ldr r0,[pool_0230BD4C]	; 0230BB50
	str r2,[r1,r0]	; 0230BB52
	bl loc_0230C720	; 0230BB54
	b loc_0230BCB0	; 0230BB58
loc_0230BB5A:
	ldr r3,[pool_0230BDA0]	; 0230BB5A
	ldr r2,[pool_0230BCE8]	; 0230BB5C
	str r3,[r1,r2]	; 0230BB5E
	ldr r3,[pool_0230BDA4]	; 0230BB60
	ldr r2,[r0,#0x0]	; 0230BB62
	ldr r1,[pool_0230BCF0]	; 0230BB64
	str r3,[r2,r1]	; 0230BB66
	ldr r3,[pool_0230BDA8]	; 0230BB68
	ldr r2,[r0,#0x0]	; 0230BB6A
	ldr r1,[pool_0230BCF8]	; 0230BB6C
	str r3,[r2,r1]	; 0230BB6E
	ldr r3,[pool_0230BCFC]	; 0230BB70
	ldr r2,[r0,#0x0]	; 0230BB72
	ldr r1,[pool_0230BD00]	; 0230BB74
	str r3,[r2,r1]	; 0230BB76
	ldr r3,[pool_0230BD04]	; 0230BB78
	ldr r2,[r0,#0x0]	; 0230BB7A
	ldr r1,[pool_0230BD08]	; 0230BB7C
	str r3,[r2,r1]	; 0230BB7E
	ldr r3,[pool_0230BD0C]	; 0230BB80
	ldr r2,[r0,#0x0]	; 0230BB82
	ldr r1,[pool_0230BD10]	; 0230BB84
	str r3,[r2,r1]	; 0230BB86
	ldr r3,[pool_0230BCF4]	; 0230BB88
	ldr r2,[r0,#0x0]	; 0230BB8A
	ldr r1,[pool_0230BDAC]	; 0230BB8C
	str r3,[r2,r1]	; 0230BB8E
	ldr r3,[pool_0230BD54]	; 0230BB90
	ldr r2,[r0,#0x0]	; 0230BB92
	ldr r1,[pool_0230BDB0]	; 0230BB94
	str r3,[r2,r1]	; 0230BB96
	ldr r2,[pool_0230BD14]	; 0230BB98
	ldr r1,[pool_0230BDB4]	; 0230BB9A
	strh r2,[r1,#0x0]	; 0230BB9C
	ldr r1,[pool_0230BD1C]	; 0230BB9E
	ldr r3,[pool_0230BDB8]	; 0230BBA0
	strh r1,[r3,#0x0]	; 0230BBA2
	ldr r3,[pool_0230BDBC]	; 0230BBA4
	strh r2,[r3,#0x0]	; 0230BBA6
	ldr r3,[pool_0230BDC0]	; 0230BBA8
	strh r1,[r3,#0x0]	; 0230BBAA
	ldr r3,[pool_0230BDC4]	; 0230BBAC
	strh r2,[r3,#0x0]	; 0230BBAE
	ldr r3,[pool_0230BDC8]	; 0230BBB0
	strh r1,[r3,#0x0]	; 0230BBB2
	ldr r3,[pool_0230BDCC]	; 0230BBB4
	strh r2,[r3,#0x0]	; 0230BBB6
	ldr r3,[pool_0230BDD0]	; 0230BBB8
	strh r1,[r3,#0x0]	; 0230BBBA
	ldr r3,[pool_0230BDD4]	; 0230BBBC
	strh r2,[r3,#0x0]	; 0230BBBE
	ldr r2,[pool_0230BDD8]	; 0230BBC0
	strh r1,[r2,#0x0]	; 0230BBC2
	ldr r2,[r0,#0x0]	; 0230BBC4
	ldr r0,[pool_0230BD7C]	; 0230BBC6
	ldrh r0,[r2,r0]	; 0230BBC8
	cmp r0,#0x0	; 0230BBCA
	bne loc_0230BBD6	; 0230BBCC
	ldr r1,[pool_0230BDDC]	; 0230BBCE
	ldr r0,[pool_0230BD84]	; 0230BBD0
	strh r1,[r2,r0]	; 0230BBD2
	b loc_0230BBDC	; 0230BBD4
loc_0230BBD6:
	ldr r1,[pool_0230BDE0]	; 0230BBD6
	ldr r0,[pool_0230BD84]	; 0230BBD8
	strh r1,[r2,r0]	; 0230BBDA
loc_0230BBDC:
	mov r0,#0x0	; 0230BBDC
	str r0,[sp,#0x8]	; 0230BBDE
	ldr r0,[sp,#0x8]	; 0230BBE0
	ldr r1,[pool_0230BCB8]	; 0230BBE2
	ldr r2,[r1,#0x0]	; 0230BBE4
	ldr r1,[pool_0230BD8C]	; 0230BBE6
	add r1,r2,r1	; 0230BBE8
	mov r2,#0x2c	; 0230BBEA
	bl loc_0230BDFC	; 0230BBEC
	bl loc_0230602C	; 0230BBF0
	ldr r3,[pool_0230BCB8]	; 0230BBF4
	ldr r2,[r3,#0x0]	; 0230BBF6
	ldr r1,[pool_0230BD90]	; 0230BBF8
	strh r0,[r2,r1]	; 0230BBFA
	ldr r3,[r3,#0x0]	; 0230BBFC
	ldr r0,[pool_0230BD94]	; 0230BBFE
	add r0,r3,r0	; 0230BC00
	ldr r1,[pool_0230BD98]	; 0230BC02
	add r1,r3,r1	; 0230BC04
	ldr r2,[pool_0230BD9C]	; 0230BC06
	add r2,r3,r2	; 0230BC08
	bl loc_02306440	; 0230BC0A
	mov r1,#0xd	; 0230BC0E
	ldr r0,[pool_0230BD34]	; 0230BC10
	strh r1,[r0,#0x0]	; 0230BC12
	b loc_0230BCB0	; 0230BC14
loc_0230BC16:
	ldr r3,[pool_0230BCE4]	; 0230BC16
	ldr r2,[pool_0230BCE8]	; 0230BC18
	str r3,[r1,r2]	; 0230BC1A
	ldr r3,[pool_0230BCEC]	; 0230BC1C
	ldr r2,[r0,#0x0]	; 0230BC1E
	ldr r1,[pool_0230BCF0]	; 0230BC20
	str r3,[r2,r1]	; 0230BC22
	ldr r3,[pool_0230BCF4]	; 0230BC24
	ldr r2,[r0,#0x0]	; 0230BC26
	ldr r1,[pool_0230BCF8]	; 0230BC28
	str r3,[r2,r1]	; 0230BC2A
	ldr r3,[pool_0230BCFC]	; 0230BC2C
	ldr r2,[r0,#0x0]	; 0230BC2E
	ldr r1,[pool_0230BD00]	; 0230BC30
	str r3,[r2,r1]	; 0230BC32
	ldr r3,[pool_0230BD04]	; 0230BC34
	ldr r2,[r0,#0x0]	; 0230BC36
	ldr r1,[pool_0230BD08]	; 0230BC38
	str r3,[r2,r1]	; 0230BC3A
	ldr r3,[pool_0230BD0C]	; 0230BC3C
	ldr r2,[r0,#0x0]	; 0230BC3E
	ldr r1,[pool_0230BD10]	; 0230BC40
	str r3,[r2,r1]	; 0230BC42
	ldr r2,[pool_0230BD14]	; 0230BC44
	ldr r1,[pool_0230BD18]	; 0230BC46
	strh r2,[r1,#0x0]	; 0230BC48
	ldr r1,[pool_0230BD1C]	; 0230BC4A
	ldr r3,[pool_0230BD20]	; 0230BC4C
	strh r1,[r3,#0x0]	; 0230BC4E
	ldr r3,[pool_0230BD24]	; 0230BC50
	strh r2,[r3,#0x0]	; 0230BC52
	ldr r3,[pool_0230BD28]	; 0230BC54
	strh r1,[r3,#0x0]	; 0230BC56
	ldr r3,[pool_0230BD2C]	; 0230BC58
	strh r2,[r3,#0x0]	; 0230BC5A
	ldr r2,[pool_0230BD30]	; 0230BC5C
	strh r1,[r2,#0x0]	; 0230BC5E
	ldr r2,[r0,#0x0]	; 0230BC60
	ldr r0,[pool_0230BD7C]	; 0230BC62
	ldrh r0,[r2,r0]	; 0230BC64
	cmp r0,#0x0	; 0230BC66
	bne loc_0230BC72	; 0230BC68
	ldr r1,[pool_0230BDDC]	; 0230BC6A
	ldr r0,[pool_0230BD84]	; 0230BC6C
	strh r1,[r2,r0]	; 0230BC6E
	b loc_0230BC78	; 0230BC70
loc_0230BC72:
	ldr r1,[pool_0230BDE0]	; 0230BC72
	ldr r0,[pool_0230BD84]	; 0230BC74
	strh r1,[r2,r0]	; 0230BC76
loc_0230BC78:
	mov r0,#0x0	; 0230BC78
	str r0,[sp,#0xc]	; 0230BC7A
	ldr r0,[sp,#0xc]	; 0230BC7C
	ldr r1,[pool_0230BCB8]	; 0230BC7E
	ldr r2,[r1,#0x0]	; 0230BC80
	ldr r1,[pool_0230BD8C]	; 0230BC82
	add r1,r2,r1	; 0230BC84
	mov r2,#0x2c	; 0230BC86
	bl loc_0230BE08	; 0230BC88
	bl loc_0230602C	; 0230BC8C
	ldr r3,[pool_0230BCB8]	; 0230BC90
	ldr r2,[r3,#0x0]	; 0230BC92
	ldr r1,[pool_0230BD90]	; 0230BC94
	strh r0,[r2,r1]	; 0230BC96
	ldr r3,[r3,#0x0]	; 0230BC98
	ldr r0,[pool_0230BD94]	; 0230BC9A
	add r0,r3,r0	; 0230BC9C
	ldr r1,[pool_0230BD98]	; 0230BC9E
	add r1,r3,r1	; 0230BCA0
	ldr r2,[pool_0230BD9C]	; 0230BCA2
	add r2,r3,r2	; 0230BCA4
	bl loc_02306440	; 0230BCA6
	mov r1,#0xd	; 0230BCAA
	ldr r0,[pool_0230BD34]	; 0230BCAC
	strh r1,[r0,#0x0]	; 0230BCAE
loc_0230BCB0:
	add sp,#0x14	; 0230BCB0
	pop {r3}	; 0230BCB2
	bx r3	; 0230BCB4
	.byte 0xC0, 0x46	; 0230BCB8
pool_0230BCB8:
loc_0230BCB8:
	.word FirmwareWlWorkPointerSlot	; 0230BCB8
pool_0230BCBC:
loc_0230BCBC:
	.word 0x000003E4	; 0230BCBC
pool_0230BCC0:
loc_0230BCC0:
	.word 0x000003F0	; 0230BCC0
pool_0230BCC4:
loc_0230BCC4:
	.word 0x000003F8	; 0230BCC4
pool_0230BCC8:
loc_0230BCC8:
	.word 0x00000404	; 0230BCC8
pool_0230BCCC:
loc_0230BCCC:
	.word 0x0000040C	; 0230BCCC
pool_0230BCD0:
loc_0230BCD0:
	.word 0x00000418	; 0230BCD0
pool_0230BCD4:
loc_0230BCD4:
	.word 0x0000FFFF	; 0230BCD4
pool_0230BCD8:
loc_0230BCD8:
	.word 0x00000488	; 0230BCD8
pool_0230BCDC:
loc_0230BCDC:
	.word 0x0000048A	; 0230BCDC
pool_0230BCE0:
loc_0230BCE0:
	.word 0x00000314	; 0230BCE0
pool_0230BCE4:
loc_0230BCE4:
	.word 0x04804170	; 0230BCE4
pool_0230BCE8:
loc_0230BCE8:
	.word 0x000003EC	; 0230BCE8
pool_0230BCEC:
loc_0230BCEC:
	.word 0x04804028	; 0230BCEC
pool_0230BCF0:
loc_0230BCF0:
	.word 0x00000400	; 0230BCF0
pool_0230BCF4:
loc_0230BCF4:
	.word WifiRamBase	; 0230BCF4
pool_0230BCF8:
loc_0230BCF8:
	.word 0x00000414	; 0230BCF8
pool_0230BCFC:
loc_0230BCFC:
	.word P4_Code_0230D358 + 1	; 0230BCFC
pool_0230BD00:
loc_0230BD00:
	.word 0x000003F4	; 0230BD00
pool_0230BD04:
loc_0230BD04:
	.word P4_Code_0230D038 + 1	; 0230BD04
pool_0230BD08:
loc_0230BD08:
	.word 0x00000408	; 0230BD08
pool_0230BD0C:
loc_0230BD0C:
	.word P4_Code_0230CFD8 + 1	; 0230BD0C
pool_0230BD10:
loc_0230BD10:
	.word 0x0000041C	; 0230BD10
pool_0230BD14:
loc_0230BD14:
	.word 0x0000B6B8	; 0230BD14
pool_0230BD18:
loc_0230BD18:
	.word WifiRamBase + 0x24	; 0230BD18
pool_0230BD1C:
loc_0230BD1C:
	.word 0x00001D46	; 0230BD1C
pool_0230BD20:
loc_0230BD20:
	.word WifiRamBase + 0x26	; 0230BD20
pool_0230BD24:
loc_0230BD24:
	.word WifiRamBase + 0x16C	; 0230BD24
pool_0230BD28:
loc_0230BD28:
	.word WifiRamBase + 0x16E	; 0230BD28
pool_0230BD2C:
loc_0230BD2C:
	.word WifiRamBase + 0x790	; 0230BD2C
pool_0230BD30:
loc_0230BD30:
	.word WifiRamBase + 0x792	; 0230BD30
pool_0230BD34:
loc_0230BD34:
	.word REG_WIFI_TXREQ_SET	; 0230BD34
pool_0230BD38:
loc_0230BD38:
	.word 0x04804A9C	; 0230BD38
pool_0230BD3C:
loc_0230BD3C:
	.word 0x04804954	; 0230BD3C
pool_0230BD40:
loc_0230BD40:
	.word 0x04804330	; 0230BD40
pool_0230BD44:
loc_0230BD44:
	.word P4_Code_0230CF1C + 1	; 0230BD44
pool_0230BD48:
loc_0230BD48:
	.word 0x04804234	; 0230BD48
pool_0230BD4C:
loc_0230BD4C:
	.word 0x00000464	; 0230BD4C
pool_0230BD50:
loc_0230BD50:
	.word 0x00000428	; 0230BD50
pool_0230BD54:
loc_0230BD54:
	.word WifiRamBase + 0x230	; 0230BD54
pool_0230BD58:
loc_0230BD58:
	.word WifiRamBase + 0x232	; 0230BD58
pool_0230BD5C:
loc_0230BD5C:
	.word WifiRamBase + 0x32C	; 0230BD5C
pool_0230BD60:
loc_0230BD60:
	.word WifiRamBase + 0x32E	; 0230BD60
pool_0230BD64:
loc_0230BD64:
	.word WifiRamBase + 0x950	; 0230BD64
pool_0230BD68:
loc_0230BD68:
	.word WifiRamBase + 0x952	; 0230BD68
pool_0230BD6C:
loc_0230BD6C:
	.word WifiRamBase + 0xA98	; 0230BD6C
pool_0230BD70:
loc_0230BD70:
	.word WifiRamBase + 0xA9A	; 0230BD70
pool_0230BD74:
loc_0230BD74:
	.word WifiRamBase + 0x10BC	; 0230BD74
pool_0230BD78:
loc_0230BD78:
	.word WifiRamBase + 0x10BE	; 0230BD78
pool_0230BD7C:
loc_0230BD7C:
	.word 0x000002F8	; 0230BD7C
pool_0230BD80:
loc_0230BD80:
	.word 0x00000208	; 0230BD80
pool_0230BD84:
loc_0230BD84:
	.word 0x00000386	; 0230BD84
pool_0230BD88:
loc_0230BD88:
	.word 0x00004208	; 0230BD88
pool_0230BD8C:
loc_0230BD8C:
	.word 0x0000064C	; 0230BD8C
pool_0230BD90:
loc_0230BD90:
	.word 0x0000065C	; 0230BD90
pool_0230BD94:
loc_0230BD94:
	.word 0x0000066A	; 0230BD94
pool_0230BD98:
loc_0230BD98:
	.word 0x000002E8	; 0230BD98
pool_0230BD9C:
loc_0230BD9C:
	.word 0x00000360	; 0230BD9C
pool_0230BDA0:
loc_0230BDA0:
	.word 0x048045D0	; 0230BDA0
pool_0230BDA4:
loc_0230BDA4:
	.word 0x04804488	; 0230BDA4
pool_0230BDA8:
loc_0230BDA8:
	.word 0x04804460	; 0230BDA8
pool_0230BDAC:
loc_0230BDAC:
	.word 0x0000043C	; 0230BDAC
pool_0230BDB0:
loc_0230BDB0:
	.word 0x00000450	; 0230BDB0
pool_0230BDB4:
loc_0230BDB4:
	.word WifiRamBase + 0x22C	; 0230BDB4
pool_0230BDB8:
loc_0230BDB8:
	.word WifiRamBase + 0x22E	; 0230BDB8
pool_0230BDBC:
loc_0230BDBC:
	.word WifiRamBase + 0x45C	; 0230BDBC
pool_0230BDC0:
loc_0230BDC0:
	.word WifiRamBase + 0x45E	; 0230BDC0
pool_0230BDC4:
loc_0230BDC4:
	.word WifiRamBase + 0x484	; 0230BDC4
pool_0230BDC8:
loc_0230BDC8:
	.word WifiRamBase + 0x486	; 0230BDC8
pool_0230BDCC:
loc_0230BDCC:
	.word WifiRamBase + 0x5CC	; 0230BDCC
pool_0230BDD0:
loc_0230BDD0:
	.word WifiRamBase + 0x5CE	; 0230BDD0
pool_0230BDD4:
loc_0230BDD4:
	.word WifiRamBase + 0xBF0	; 0230BDD4
pool_0230BDD8:
loc_0230BDD8:
	.word WifiRamBase + 0xBF2	; 0230BDD8
pool_0230BDDC:
loc_0230BDDC:
	.word 0x00000108	; 0230BDDC
pool_0230BDE0:
loc_0230BDE0:
	.word 0x00004108	; 0230BDE0

; ===== function loc_0230BDE4 =====
loc_0230BDE4:
	bx pc	; 0230BDE4
	.byte 0xC0, 0x46	; 0230BDE8
.arm

; ===== function loc_0230BDE8 =====
loc_0230BDE8:
	ldr pc,[pool_0230BDEC]	; 0230BDE8
pool_0230BDEC:
loc_0230BDEC:
	.word loc_037FCE38	; 0230BDEC
.thumb

; ===== function loc_0230BDF0 =====
loc_0230BDF0:
	bx pc	; 0230BDF0
	.byte 0xC0, 0x46	; 0230BDF4
.arm

; ===== function loc_0230BDF4 =====
loc_0230BDF4:
	ldr pc,[pool_0230BDF8]	; 0230BDF4
pool_0230BDF8:
loc_0230BDF8:
	.word loc_037FCE38	; 0230BDF8
.thumb

; ===== function loc_0230BDFC =====
loc_0230BDFC:
	bx pc	; 0230BDFC
	.byte 0xC0, 0x46	; 0230BE00
.arm

; ===== function loc_0230BE00 =====
loc_0230BE00:
	ldr pc,[pool_0230BE04]	; 0230BE00
pool_0230BE04:
loc_0230BE04:
	.word loc_037FCE38	; 0230BE04
.thumb

; ===== function loc_0230BE08 =====
loc_0230BE08:
	bx pc	; 0230BE08
	.byte 0xC0, 0x46	; 0230BE0C
.arm

; ===== function loc_0230BE0C =====
loc_0230BE0C:
	ldr pc,[pool_0230BE10]	; 0230BE0C
pool_0230BE10:
loc_0230BE10:
	.word loc_037FCE38	; 0230BE10
.thumb

; ===== function loc_0230BE14 =====
loc_0230BE14:
	push {r4,r5,r6,r7,lr}	; 0230BE14
	sub sp,#0x4	; 0230BE16
	add r5,r0,#0x0	; 0230BE18
	mov r4,#0x0	; 0230BE1A
	mov r1,#0xdd	; 0230BE1C
	bl loc_023053DC	; 0230BE1E
	add r0,r5,#0x1	; 0230BE22
	ldr r1,[pool_0230BEE8]	; 0230BE24
	ldr r2,[r1,#0x0]	; 0230BE26
	ldr r1,[pool_0230BEEC]	; 0230BE28
	ldrh r1,[r2,r1]	; 0230BE2A
	add r1,#0x8	; 0230BE2C
	lsl r1,r1,#0x18	; 0230BE2E
	lsr r1,r1,#0x18	; 0230BE30
	bl loc_023053DC	; 0230BE32
	add r0,r5,#0x2	; 0230BE36
	lsl r1,r4,#0	; 0230BE38
	bl loc_023053DC	; 0230BE3A
	add r0,r5,#0x3	; 0230BE3E
	mov r1,#0x9	; 0230BE40
	bl loc_023053DC	; 0230BE42
	add r0,r5,#0x4	; 0230BE46
	mov r1,#0xbf	; 0230BE48
	bl loc_023053DC	; 0230BE4A
	add r0,r5,#0x5	; 0230BE4E
	lsl r1,r4,#0	; 0230BE50
	bl loc_023053DC	; 0230BE52
	add r0,r5,#0x6	; 0230BE56
	ldr r1,[pool_0230BEE8]	; 0230BE58
	ldr r2,[r1,#0x0]	; 0230BE5A
	ldr r1,[pool_0230BEF0]	; 0230BE5C
	ldrh r1,[r2,r1]	; 0230BE5E
	lsl r1,r1,#0x18	; 0230BE60
	lsr r1,r1,#0x18	; 0230BE62
	bl loc_023053DC	; 0230BE64
	add r0,r5,#0x7	; 0230BE68
	ldr r1,[pool_0230BEE8]	; 0230BE6A
	ldr r2,[r1,#0x0]	; 0230BE6C
	ldr r1,[pool_0230BEF0]	; 0230BE6E
	ldrh r1,[r2,r1]	; 0230BE70
	asr r1,r1,#0x8	; 0230BE72
	lsl r1,r1,#0x18	; 0230BE74
	lsr r1,r1,#0x18	; 0230BE76
	bl loc_023053DC	; 0230BE78
	ldr r0,[pool_0230BEF4]	; 0230BE7C
	ldrh r6,[r0,#0x0]	; 0230BE7E
	add r0,r5,#0x0	; 0230BE80
	add r0,#0x8	; 0230BE82
	lsl r1,r6,#0x18	; 0230BE84
	lsr r1,r1,#0x18	; 0230BE86
	bl loc_023053DC	; 0230BE88
	add r0,r5,#0x0	; 0230BE8C
	add r0,#0x9	; 0230BE8E
	lsr r1,r6,#0x8	; 0230BE90
	lsl r1,r1,#0x18	; 0230BE92
	lsr r1,r1,#0x18	; 0230BE94
	bl loc_023053DC	; 0230BE96
	add r4,#0xa	; 0230BE9A
	ldr r0,[pool_0230BEE8]	; 0230BE9C
	ldr r0,[r0,#0x0]	; 0230BE9E
	ldr r1,[pool_0230BEEC]	; 0230BEA0
	ldrh r1,[r0,r1]	; 0230BEA2
	cmp r1,#0x0	; 0230BEA4
	beq loc_0230BEDE	; 0230BEA6
	ldr r1,[pool_0230BEF8]	; 0230BEA8
	ldr r6,[r0,r1]	; 0230BEAA
	ldr r1,[pool_0230BEFC]	; 0230BEAC
	ldrh r1,[r0,r1]	; 0230BEAE
	mov r0,#0x1	; 0230BEB0
	and r1,r0	; 0230BEB2
	cmp r1,#0x0	; 0230BEB4
	beq loc_0230BEBA	; 0230BEB6
	add r6,r6,#0x1	; 0230BEB8
loc_0230BEBA:
	mov r7,#0x0	; 0230BEBA
	b loc_0230BED2	; 0230BEBC
loc_0230BEBE:
	add r0,r6,#0x0	; 0230BEBE
	bl loc_023053B8	; 0230BEC0
	add r1,r0,#0x0	; 0230BEC4
	add r0,r5,r4	; 0230BEC6
	bl loc_023053DC	; 0230BEC8
	add r4,r4,#0x1	; 0230BECC
	add r6,r6,#0x1	; 0230BECE
	add r7,r7,#0x1	; 0230BED0
loc_0230BED2:
	ldr r0,[pool_0230BEE8]	; 0230BED2
	ldr r1,[r0,#0x0]	; 0230BED4
	ldr r0,[pool_0230BEEC]	; 0230BED6
	ldrh r0,[r1,r0]	; 0230BED8
	cmp r7,r0	; 0230BEDA
	bcc loc_0230BEBE	; 0230BEDC
loc_0230BEDE:
	add r0,r4,#0x0	; 0230BEDE
	add sp,#0x4	; 0230BEE0
	pop {r4,r5,r6,r7}	; 0230BEE2
	pop {r3}	; 0230BEE4
	bx r3	; 0230BEE6
pool_0230BEE8:
loc_0230BEE8:
	.word FirmwareWlWorkPointerSlot	; 0230BEE8
pool_0230BEEC:
loc_0230BEEC:
	.word 0x0000039C	; 0230BEEC
pool_0230BEF0:
loc_0230BEF0:
	.word 0x00000300	; 0230BEF0
pool_0230BEF4:
loc_0230BEF4:
	.word FirmwareWlAdjustedTimeSlot	; 0230BEF4
pool_0230BEF8:
loc_0230BEF8:
	.word 0x00000398	; 0230BEF8
pool_0230BEFC:
loc_0230BEFC:
	.word 0x0000039E	; 0230BEFC

; ===== function loc_0230BF00 =====
loc_0230BF00:
	push {r4,lr}	; 0230BF00
	add r4,r0,#0x0	; 0230BF02
	mov r1,#0x3	; 0230BF04
	bl loc_023053DC	; 0230BF06
	add r0,r4,#0x1	; 0230BF0A
	mov r1,#0x1	; 0230BF0C
	bl loc_023053DC	; 0230BF0E
	add r0,r4,#0x2	; 0230BF12
	ldr r1,[pool_0230BF2C]	; 0230BF14
	ldr r2,[r1,#0x0]	; 0230BF16
	ldr r1,[pool_0230BF30]	; 0230BF18
	ldrh r1,[r2,r1]	; 0230BF1A
	lsl r1,r1,#0x18	; 0230BF1C
	lsr r1,r1,#0x18	; 0230BF1E
	bl loc_023053DC	; 0230BF20
	mov r0,#0x3	; 0230BF24
	pop {r4}	; 0230BF26
	pop {r3}	; 0230BF28
	bx r3	; 0230BF2A
pool_0230BF2C:
loc_0230BF2C:
	.word FirmwareWlWorkPointerSlot	; 0230BF2C
pool_0230BF30:
loc_0230BF30:
	.word 0x00000376	; 0230BF30

; ===== function loc_0230BF34 =====
loc_0230BF34:
	push {r4,r5,r6,r7,lr}	; 0230BF34
	sub sp,#0x4	; 0230BF36
	add r6,r0,#0x0	; 0230BF38
	mov r5,#0x0	; 0230BF3A
	mov r1,#0x1	; 0230BF3C
	bl loc_023053DC	; 0230BF3E
	add r5,r5,#0x2	; 0230BF42
	mov r4,#0x0	; 0230BF44
	ldr r7,[pool_0230BFA4]	; 0230BF46
loc_0230BF48:
	mov r1,#0x1	; 0230BF48
	lsl r1,r4	; 0230BF4A
	ldr r0,[pool_0230BFA8]	; 0230BF4C
	ldr r0,[r0,#0x0]	; 0230BF4E
	ldr r2,[pool_0230BFAC]	; 0230BF50
	ldrh r2,[r0,r2]	; 0230BF52
	and r2,r1	; 0230BF54
	cmp r2,#0x0	; 0230BF56
	beq loc_0230BF88	; 0230BF58
	ldr r2,[pool_0230BFB0]	; 0230BF5A
	ldrh r0,[r0,r2]	; 0230BF5C
	and r0,r1	; 0230BF5E
	cmp r0,#0x0	; 0230BF60
	beq loc_0230BF78	; 0230BF62
	add r0,r6,r5	; 0230BF64
	lsl r1,r4,#0x1	; 0230BF66
	ldrh r2,[r7,r1]	; 0230BF68
	mov r1,#0x80	; 0230BF6A
	orr r2,r1	; 0230BF6C
	lsl r1,r2,#0x18	; 0230BF6E
	lsr r1,r1,#0x18	; 0230BF70
	bl loc_023053DC	; 0230BF72
	b loc_0230BF86	; 0230BF76
loc_0230BF78:
	add r0,r6,r5	; 0230BF78
	lsl r1,r4,#0x1	; 0230BF7A
	ldrh r1,[r7,r1]	; 0230BF7C
	lsl r1,r1,#0x18	; 0230BF7E
	lsr r1,r1,#0x18	; 0230BF80
	bl loc_023053DC	; 0230BF82
loc_0230BF86:
	add r5,r5,#0x1	; 0230BF86
loc_0230BF88:
	add r4,r4,#0x1	; 0230BF88
	cmp r4,#0x10	; 0230BF8A
	bcc loc_0230BF48	; 0230BF8C
	add r0,r6,#0x1	; 0230BF8E
	sub r1,r5,#0x2	; 0230BF90
	lsl r1,r1,#0x18	; 0230BF92
	lsr r1,r1,#0x18	; 0230BF94
	bl loc_023053DC	; 0230BF96
	add r0,r5,#0x0	; 0230BF9A
	add sp,#0x4	; 0230BF9C
	pop {r4,r5,r6,r7}	; 0230BF9E
	pop {r3}	; 0230BFA0
	bx r3	; 0230BFA2
pool_0230BFA4:
loc_0230BFA4:
	.word 0x0231039C	; 0230BFA4
pool_0230BFA8:
loc_0230BFA8:
	.word FirmwareWlWorkPointerSlot	; 0230BFA8
pool_0230BFAC:
loc_0230BFAC:
	.word 0x0000035E	; 0230BFAC
pool_0230BFB0:
loc_0230BFB0:
	.word 0x0000035C	; 0230BFB0

; ===== function loc_0230BFB4 =====
loc_0230BFB4:
	push {r4,r5,r6,r7,lr}	; 0230BFB4
	sub sp,#0x4	; 0230BFB6
	add r6,r0,#0x0	; 0230BFB8
	mov r5,#0x0	; 0230BFBA
	add r1,r5,#0x0	; 0230BFBC
	bl loc_023053DC	; 0230BFBE
	add r0,r6,#0x1	; 0230BFC2
	ldr r1,[pool_0230C008]	; 0230BFC4
	ldr r2,[r1,#0x0]	; 0230BFC6
	ldr r1,[pool_0230C00C]	; 0230BFC8
	ldrh r1,[r2,r1]	; 0230BFCA
	lsl r1,r1,#0x18	; 0230BFCC
	lsr r1,r1,#0x18	; 0230BFCE
	bl loc_023053DC	; 0230BFD0
	add r5,r5,#0x2	; 0230BFD4
	mov r4,#0x0	; 0230BFD6
	ldr r7,[pool_0230C008]	; 0230BFD8
	b loc_0230BFF2	; 0230BFDA
loc_0230BFDC:
	ldr r1,[pool_0230C010]	; 0230BFDC
	add r0,r0,r1	; 0230BFDE
	add r0,r0,r4	; 0230BFE0
	bl loc_023053B8	; 0230BFE2
	add r1,r0,#0x0	; 0230BFE6
	add r0,r6,r5	; 0230BFE8
	bl loc_023053DC	; 0230BFEA
	add r5,r5,#0x1	; 0230BFEE
	add r4,r4,#0x1	; 0230BFF0
loc_0230BFF2:
	ldr r0,[r7,#0x0]	; 0230BFF2
	ldr r1,[pool_0230C00C]	; 0230BFF4
	ldrh r1,[r0,r1]	; 0230BFF6
	cmp r4,r1	; 0230BFF8
	bcc loc_0230BFDC	; 0230BFFA
	add r0,r5,#0x0	; 0230BFFC
	add sp,#0x4	; 0230BFFE
	pop {r4,r5,r6,r7}	; 0230C000
	pop {r3}	; 0230C002
	bx r3	; 0230C004
	.byte 0xC0, 0x46	; 0230C008
pool_0230C008:
loc_0230C008:
	.word FirmwareWlWorkPointerSlot	; 0230C008
pool_0230C00C:
loc_0230C00C:
	.word 0x0000031A	; 0230C00C
pool_0230C010:
loc_0230C010:
	.word 0x0000031C	; 0230C010

; ===== function loc_0230C014 =====
loc_0230C014:
	ldr r2,[pool_0230C044]	; 0230C014
	ldr r3,[r2,#0x0]	; 0230C016
	ldr r1,[pool_0230C048]	; 0230C018
	ldr r1,[r3,r1]	; 0230C01A
	mov r3,#0x0	; 0230C01C
	strh r3,[r1,#0x0]	; 0230C01E
	strh r3,[r1,#0x2]	; 0230C020
	strh r3,[r1,#0x4]	; 0230C022
	mov r3,#0x14	; 0230C024
	strh r3,[r1,#0xa]	; 0230C026
	mov r3,#0xa4	; 0230C028
	strh r3,[r1,#0xc]	; 0230C02A
	ldr r3,[pool_0230C04C]	; 0230C02C
	orr r0,r3	; 0230C02E
	strh r0,[r1,#0xe]	; 0230C030
	ldr r3,[r2,#0x0]	; 0230C032
	add r1,#0x10	; 0230C034
	add r0,r1,#0x0	; 0230C036
	ldr r1,[pool_0230C050]	; 0230C038
	add r1,r3,r1	; 0230C03A
	ldr r2,[pool_0230C054]	; 0230C03C
	add r2,r3,r2	; 0230C03E
	ldr r3,[pool_0230C058]	; 0230C040
	bx r3	; 0230C042
pool_0230C044:
loc_0230C044:
	.word FirmwareWlWorkPointerSlot	; 0230C044
pool_0230C048:
loc_0230C048:
	.word 0x00000414	; 0230C048
pool_0230C04C:
loc_0230C04C:
	.word 0x0000C000	; 0230C04C
pool_0230C050:
loc_0230C050:
	.word 0x00000360	; 0230C050
pool_0230C054:
loc_0230C054:
	.word 0x000002E8	; 0230C054
pool_0230C058:
loc_0230C058:
	.word loc_02306440 + 1	; 0230C058

; ===== function loc_0230C05C =====
loc_0230C05C:
	push {r4,r5,r6,lr}	; 0230C05C
	add r6,r0,#0x0	; 0230C05E
	add r5,r1,#0x0	; 0230C060
	ldr r0,[pool_0230C0B8]	; 0230C062
	ldr r1,[r0,#0x0]	; 0230C064
	ldr r0,[pool_0230C0BC]	; 0230C066
	add r0,r1,r0	; 0230C068
	mov r1,#0x36	; 0230C06A
	bl loc_02305054	; 0230C06C
	add r4,r0,#0x0	; 0230C070
	cmp r4,#0x0	; 0230C072
	bne loc_0230C080	; 0230C074
	mov r0,#0x2	; 0230C076
	bl loc_02305134	; 0230C078
	add r0,r4,#0x0	; 0230C07C
	b loc_0230C0B2	; 0230C07E
loc_0230C080:
	ldr r0,[pool_0230C0C0]	; 0230C080
	strh r0,[r4,#0xc]	; 0230C082
	add r4,#0x10	; 0230C084
	ldr r0,[pool_0230C0B8]	; 0230C086
	ldr r1,[r0,#0x0]	; 0230C088
	ldr r0,[pool_0230C0C4]	; 0230C08A
	add r0,r1,r0	; 0230C08C
	add r1,r4,#0x0	; 0230C08E
	mov r2,#0x2c	; 0230C090
	bl loc_0230C0C8	; 0230C092
	strh r5,[r4,#0x2c]	; 0230C096
	mov r0,#0x2	; 0230C098
	strh r0,[r4,#0x6]	; 0230C09A
	ldrh r0,[r4,#0x6]	; 0230C09C
	add r0,#0x1c	; 0230C09E
	strh r0,[r4,#0x12]	; 0230C0A0
	mov r0,#0xc0	; 0230C0A2
	strh r0,[r4,#0x14]	; 0230C0A4
	add r0,r4,#0x0	; 0230C0A6
	add r0,#0x18	; 0230C0A8
	add r1,r6,#0x0	; 0230C0AA
	bl loc_0230645C	; 0230C0AC
	add r0,r4,#0x0	; 0230C0B0
loc_0230C0B2:
	pop {r4,r5,r6}	; 0230C0B2
	pop {r3}	; 0230C0B4
	bx r3	; 0230C0B6
pool_0230C0B8:
loc_0230C0B8:
	.word FirmwareWlWorkPointerSlot	; 0230C0B8
pool_0230C0BC:
loc_0230C0BC:
	.word 0x0000014C	; 0230C0BC
pool_0230C0C0:
loc_0230C0C0:
	.word 0x0000FFFF	; 0230C0C0
pool_0230C0C4:
loc_0230C0C4:
	.word 0x0000064C	; 0230C0C4

; ===== function loc_0230C0C8 =====
loc_0230C0C8:
	bx pc	; 0230C0C8
	.byte 0xC0, 0x46	; 0230C0CC
.arm

; ===== function loc_0230C0CC =====
loc_0230C0CC:
	ldr pc,[pool_0230C0D0]	; 0230C0CC
pool_0230C0D0:
loc_0230C0D0:
	.word loc_037FCE4C	; 0230C0D0
.thumb

; ===== function loc_0230C0D4 =====
loc_0230C0D4:
	push {r4,r5,r6,lr}	; 0230C0D4
	add r6,r0,#0x0	; 0230C0D6
	add r5,r1,#0x0	; 0230C0D8
	ldr r0,[pool_0230C150]	; 0230C0DA
	ldr r1,[r0,#0x0]	; 0230C0DC
	ldr r0,[pool_0230C154]	; 0230C0DE
	add r0,r1,r0	; 0230C0E0
	ldr r1,[pool_0230C158]	; 0230C0E2
	add r1,r5,r1	; 0230C0E4
	bl loc_02305054	; 0230C0E6
	add r4,r0,#0x0	; 0230C0EA
	cmp r4,#0x0	; 0230C0EC
	bne loc_0230C0FA	; 0230C0EE
	mov r0,#0x2	; 0230C0F0
	bl loc_02305134	; 0230C0F2
	add r0,r4,#0x0	; 0230C0F6
	b loc_0230C14A	; 0230C0F8
loc_0230C0FA:
	ldr r0,[pool_0230C15C]	; 0230C0FA
	strh r0,[r4,#0xc]	; 0230C0FC
	add r4,#0x10	; 0230C0FE
	ldr r0,[pool_0230C150]	; 0230C100
	ldr r1,[r0,#0x0]	; 0230C102
	ldr r0,[pool_0230C160]	; 0230C104
	add r0,r1,r0	; 0230C106
	add r1,r4,#0x0	; 0230C108
	mov r2,#0x2c	; 0230C10A
	bl loc_0230C164	; 0230C10C
	cmp r5,#0x0	; 0230C110
	beq loc_0230C130	; 0230C112
	add r0,r4,#0x0	; 0230C114
	add r0,#0x32	; 0230C116
	mov r1,#0x10	; 0230C118
	bl loc_023053DC	; 0230C11A
	add r0,r4,#0x0	; 0230C11E
	add r0,#0x33	; 0230C120
	lsl r1,r5,#0x18	; 0230C122
	lsr r1,r1,#0x18	; 0230C124
	bl loc_023053DC	; 0230C126
	add r0,r5,#0x2	; 0230C12A
	lsl r0,r0,#0x10	; 0230C12C
	lsr r5,r0,#0x10	; 0230C12E
loc_0230C130:
	add r0,r5,#0x6	; 0230C130
	strh r0,[r4,#0x6]	; 0230C132
	ldrh r0,[r4,#0x6]	; 0230C134
	add r0,#0x1c	; 0230C136
	strh r0,[r4,#0x12]	; 0230C138
	mov r0,#0xb0	; 0230C13A
	strh r0,[r4,#0x14]	; 0230C13C
	add r0,r4,#0x0	; 0230C13E
	add r0,#0x18	; 0230C140
	add r1,r6,#0x0	; 0230C142
	bl loc_0230645C	; 0230C144
	add r0,r4,#0x0	; 0230C148
loc_0230C14A:
	pop {r4,r5,r6}	; 0230C14A
	pop {r3}	; 0230C14C
	bx r3	; 0230C14E
pool_0230C150:
loc_0230C150:
	.word FirmwareWlWorkPointerSlot	; 0230C150
pool_0230C154:
loc_0230C154:
	.word 0x0000014C	; 0230C154
pool_0230C158:
loc_0230C158:
	.word 0x0000013A	; 0230C158
pool_0230C15C:
loc_0230C15C:
	.word 0x0000FFFF	; 0230C15C
pool_0230C160:
loc_0230C160:
	.word 0x0000064C	; 0230C160

; ===== function loc_0230C164 =====
loc_0230C164:
	bx pc	; 0230C164
	.byte 0xC0, 0x46	; 0230C168
.arm

; ===== function loc_0230C168 =====
loc_0230C168:
	ldr pc,[pool_0230C16C]	; 0230C168
pool_0230C16C:
loc_0230C16C:
	.word loc_037FCE4C	; 0230C16C
.thumb

; ===== function loc_0230C170 =====
loc_0230C170:
	push {r4,r5,r6,lr}	; 0230C170
	add r6,r0,#0x0	; 0230C172
	ldr r0,[pool_0230C20C]	; 0230C174
	ldr r2,[r0,#0x0]	; 0230C176
	ldr r0,[pool_0230C210]	; 0230C178
	add r0,r2,r0	; 0230C17A
	ldr r1,[pool_0230C214]	; 0230C17C
	ldrh r1,[r2,r1]	; 0230C17E
	add r1,#0x78	; 0230C180
	bl loc_02305054	; 0230C182
	add r4,r0,#0x0	; 0230C186
	cmp r4,#0x0	; 0230C188
	bne loc_0230C196	; 0230C18A
	mov r0,#0x2	; 0230C18C
	bl loc_02305134	; 0230C18E
	add r0,r4,#0x0	; 0230C192
	b loc_0230C206	; 0230C194
loc_0230C196:
	ldr r0,[pool_0230C218]	; 0230C196
	strh r0,[r4,#0xc]	; 0230C198
	add r4,#0x10	; 0230C19A
	ldr r0,[pool_0230C20C]	; 0230C19C
	ldr r1,[r0,#0x0]	; 0230C19E
	ldr r0,[pool_0230C21C]	; 0230C1A0
	add r0,r1,r0	; 0230C1A2
	add r1,r4,#0x0	; 0230C1A4
	mov r2,#0x2c	; 0230C1A6
	bl loc_0230C228	; 0230C1A8
	ldr r2,[pool_0230C20C]	; 0230C1AC
	ldr r1,[r2,#0x0]	; 0230C1AE
	ldr r0,[pool_0230C220]	; 0230C1B0
	ldrh r0,[r1,r0]	; 0230C1B2
	strh r0,[r4,#0x34]	; 0230C1B4
	ldr r1,[r2,#0x0]	; 0230C1B6
	ldr r0,[pool_0230C224]	; 0230C1B8
	ldrh r0,[r1,r0]	; 0230C1BA
	strh r0,[r4,#0x36]	; 0230C1BC
	add r0,r4,#0x0	; 0230C1BE
	add r0,#0x38	; 0230C1C0
	bl loc_0230BFB4	; 0230C1C2
	add r5,r0,#0x0	; 0230C1C6
	add r0,r4,#0x0	; 0230C1C8
	add r0,#0x38	; 0230C1CA
	add r0,r0,r5	; 0230C1CC
	bl loc_0230BF34	; 0230C1CE
	add r5,r5,r0	; 0230C1D2
	add r0,r4,#0x0	; 0230C1D4
	add r0,#0x38	; 0230C1D6
	add r0,r0,r5	; 0230C1D8
	bl loc_0230BF00	; 0230C1DA
	add r5,r5,r0	; 0230C1DE
	add r0,r4,#0x0	; 0230C1E0
	add r0,#0x38	; 0230C1E2
	add r0,r0,r5	; 0230C1E4
	bl loc_0230BE14	; 0230C1E6
	add r0,r5,r0	; 0230C1EA
	add r0,#0xc	; 0230C1EC
	strh r0,[r4,#0x6]	; 0230C1EE
	ldrh r0,[r4,#0x6]	; 0230C1F0
	add r0,#0x1c	; 0230C1F2
	strh r0,[r4,#0x12]	; 0230C1F4
	mov r0,#0x50	; 0230C1F6
	strh r0,[r4,#0x14]	; 0230C1F8
	add r0,r4,#0x0	; 0230C1FA
	add r0,#0x18	; 0230C1FC
	add r1,r6,#0x0	; 0230C1FE
	bl loc_0230645C	; 0230C200
	add r0,r4,#0x0	; 0230C204
loc_0230C206:
	pop {r4,r5,r6}	; 0230C206
	pop {r3}	; 0230C208
	bx r3	; 0230C20A
pool_0230C20C:
loc_0230C20C:
	.word FirmwareWlWorkPointerSlot	; 0230C20C
pool_0230C210:
loc_0230C210:
	.word 0x0000014C	; 0230C210
pool_0230C214:
loc_0230C214:
	.word 0x0000039C	; 0230C214
pool_0230C218:
loc_0230C218:
	.word 0x0000FFFF	; 0230C218
pool_0230C21C:
loc_0230C21C:
	.word 0x0000064C	; 0230C21C
pool_0230C220:
loc_0230C220:
	.word 0x0000036A	; 0230C220
pool_0230C224:
loc_0230C224:
	.word 0x00000378	; 0230C224

; ===== function loc_0230C228 =====
loc_0230C228:
	bx pc	; 0230C228
	.byte 0xC0, 0x46	; 0230C22C
.arm

; ===== function loc_0230C22C =====
loc_0230C22C:
	ldr pc,[pool_0230C230]	; 0230C22C
pool_0230C230:
loc_0230C230:
	.word loc_037FCE4C	; 0230C230
.thumb

; ===== function loc_0230C234 =====
loc_0230C234:
	push {r4,r5,r6,lr}	; 0230C234
	add r6,r0,#0x0	; 0230C236
	ldr r0,[pool_0230C2A0]	; 0230C238
	ldr r1,[r0,#0x0]	; 0230C23A
	ldr r0,[pool_0230C2A4]	; 0230C23C
	add r0,r1,r0	; 0230C23E
	mov r1,#0x5a	; 0230C240
	bl loc_02305054	; 0230C242
	add r5,r0,#0x0	; 0230C246
	cmp r5,#0x0	; 0230C248
	bne loc_0230C256	; 0230C24A
	mov r0,#0x2	; 0230C24C
	bl loc_02305134	; 0230C24E
	add r0,r5,#0x0	; 0230C252
	b loc_0230C298	; 0230C254
loc_0230C256:
	ldr r0,[pool_0230C2A8]	; 0230C256
	strh r0,[r5,#0xc]	; 0230C258
	add r5,#0x10	; 0230C25A
	ldr r0,[pool_0230C2A0]	; 0230C25C
	ldr r1,[r0,#0x0]	; 0230C25E
	ldr r0,[pool_0230C2AC]	; 0230C260
	add r0,r1,r0	; 0230C262
	add r1,r5,#0x0	; 0230C264
	mov r2,#0x2c	; 0230C266
	bl loc_0230C2B0	; 0230C268
	add r0,r5,#0x0	; 0230C26C
	add r0,#0x2c	; 0230C26E
	bl loc_0230BFB4	; 0230C270
	add r4,r0,#0x0	; 0230C274
	add r0,r5,#0x0	; 0230C276
	add r0,#0x2c	; 0230C278
	add r0,r0,r4	; 0230C27A
	bl loc_0230BF34	; 0230C27C
	add r0,r4,r0	; 0230C280
	strh r0,[r5,#0x6]	; 0230C282
	add r0,#0x1c	; 0230C284
	strh r0,[r5,#0x12]	; 0230C286
	mov r0,#0x40	; 0230C288
	strh r0,[r5,#0x14]	; 0230C28A
	add r0,r5,#0x0	; 0230C28C
	add r0,#0x18	; 0230C28E
	add r1,r6,#0x0	; 0230C290
	bl loc_0230645C	; 0230C292
	add r0,r5,#0x0	; 0230C296
loc_0230C298:
	pop {r4,r5,r6}	; 0230C298
	pop {r3}	; 0230C29A
	bx r3	; 0230C29C
	.byte 0xC0, 0x46	; 0230C2A0
pool_0230C2A0:
loc_0230C2A0:
	.word FirmwareWlWorkPointerSlot	; 0230C2A0
pool_0230C2A4:
loc_0230C2A4:
	.word 0x0000014C	; 0230C2A4
pool_0230C2A8:
loc_0230C2A8:
	.word 0x0000FFFF	; 0230C2A8
pool_0230C2AC:
loc_0230C2AC:
	.word 0x0000064C	; 0230C2AC

; ===== function loc_0230C2B0 =====
loc_0230C2B0:
	bx pc	; 0230C2B0
	.byte 0xC0, 0x46	; 0230C2B4
.arm

; ===== function loc_0230C2B4 =====
loc_0230C2B4:
	ldr pc,[pool_0230C2B8]	; 0230C2B4
pool_0230C2B8:
loc_0230C2B8:
	.word loc_037FCE4C	; 0230C2B8
.thumb

; ===== function loc_0230C2BC =====
loc_0230C2BC:
	push {r4,r5,r6,r7,lr}	; 0230C2BC
	sub sp,#0xc	; 0230C2BE
	add r6,r0,#0x0	; 0230C2C0
	add r4,r1,#0x0	; 0230C2C2
	add r7,r2,#0x0	; 0230C2C4
	ldr r0,[pool_0230C3C0]	; 0230C2C6
	ldr r1,[r0,#0x0]	; 0230C2C8
	ldr r0,[pool_0230C3C4]	; 0230C2CA
	add r0,r1,r0	; 0230C2CC
	mov r1,#0x60	; 0230C2CE
	bl loc_02305054	; 0230C2D0
	add r5,r0,#0x0	; 0230C2D4
	cmp r5,#0x0	; 0230C2D6
	bne loc_0230C2E4	; 0230C2D8
	mov r0,#0x2	; 0230C2DA
	bl loc_02305134	; 0230C2DC
	add r0,r5,#0x0	; 0230C2E0
	b loc_0230C3B8	; 0230C2E2
loc_0230C2E4:
	ldr r0,[pool_0230C3C8]	; 0230C2E4
	strh r0,[r5,#0xc]	; 0230C2E6
	add r5,#0x10	; 0230C2E8
	cmp r4,#0x0	; 0230C2EA
	bne loc_0230C2FE	; 0230C2EC
	add r0,r6,#0x0	; 0230C2EE
	bl loc_023090F8	; 0230C2F0
	str r0,[sp,#0x0]	; 0230C2F4
	cmp r0,#0x0	; 0230C2F6
	bne loc_0230C302	; 0230C2F8
	mov r4,#0x13	; 0230C2FA
	b loc_0230C302	; 0230C2FC
loc_0230C2FE:
	mov r0,#0x0	; 0230C2FE
	str r0,[sp,#0x0]	; 0230C300
loc_0230C302:
	ldr r0,[pool_0230C3C0]	; 0230C302
	ldr r1,[r0,#0x0]	; 0230C304
	ldr r0,[pool_0230C3CC]	; 0230C306
	add r0,r1,r0	; 0230C308
	add r1,r5,#0x0	; 0230C30A
	mov r2,#0x2c	; 0230C30C
	bl loc_0230C3DC	; 0230C30E
	ldr r0,[pool_0230C3C0]	; 0230C312
	ldr r1,[r0,#0x0]	; 0230C314
	ldr r0,[pool_0230C3D0]	; 0230C316
	ldrh r0,[r1,r0]	; 0230C318
	strh r0,[r5,#0x2c]	; 0230C31A
	strh r4,[r5,#0x2e]	; 0230C31C
	ldr r1,[pool_0230C3D4]	; 0230C31E
	ldr r0,[sp,#0x0]	; 0230C320
	orr r0,r1	; 0230C322
	str r0,[sp,#0x0]	; 0230C324
	strh r0,[r5,#0x30]	; 0230C326
	add r0,r5,#0x0	; 0230C328
	add r0,#0x32	; 0230C32A
	bl loc_0230BF34	; 0230C32C
	add r0,r0,#0x6	; 0230C330
	strh r0,[r5,#0x6]	; 0230C332
	ldrh r0,[r5,#0x6]	; 0230C334
	add r0,#0x1c	; 0230C336
	strh r0,[r5,#0x12]	; 0230C338
	mov r0,#0x30	; 0230C33A
	strh r0,[r5,#0x14]	; 0230C33C
	add r0,r5,#0x0	; 0230C33E
	add r0,#0x18	; 0230C340
	ldr r1,[pool_0230C3C0]	; 0230C342
	ldr r2,[r1,#0x0]	; 0230C344
	ldr r1,[pool_0230C3D8]	; 0230C346
	ldr r2,[r2,r1]	; 0230C348
	mov r1,#0x1c	; 0230C34A
	mul r6,r1	; 0230C34C
	add r1,r2,r6	; 0230C34E
	add r1,r1,#0x4	; 0230C350
	bl loc_0230645C	; 0230C352
	add r1,r5,#0x0	; 0230C356
	add r1,#0x14	; 0230C358
	ldrh r0,[r5,#0x12]	; 0230C35A
	add r4,r1,r0	; 0230C35C
	cmp r7,#0x0	; 0230C35E
	beq loc_0230C3A6	; 0230C360
	add r0,r7,#0x1	; 0230C362
	bl loc_023053B8	; 0230C364
	str r0,[sp,#0x4]	; 0230C368
	add r0,r7,#0x0	; 0230C36A
	bl loc_023053B8	; 0230C36C
	add r1,r0,#0x0	; 0230C370
	add r0,r4,#0x0	; 0230C372
	bl loc_023053DC	; 0230C374
	add r0,r4,#0x1	; 0230C378
	ldr r1,[sp,#0x4]	; 0230C37A
	lsl r1,r1,#0x18	; 0230C37C
	lsr r1,r1,#0x18	; 0230C37E
	bl loc_023053DC	; 0230C380
	add r4,r4,#0x2	; 0230C384
	mov r6,#0x0	; 0230C386
	b loc_0230C39E	; 0230C388
loc_0230C38A:
	add r0,r7,#0x2	; 0230C38A
	add r0,r0,r6	; 0230C38C
	bl loc_023053B8	; 0230C38E
	add r1,r0,#0x0	; 0230C392
	add r0,r4,#0x0	; 0230C394
	bl loc_023053DC	; 0230C396
	add r4,r4,#0x1	; 0230C39A
	add r6,r6,#0x1	; 0230C39C
loc_0230C39E:
	ldr r0,[sp,#0x4]	; 0230C39E
	cmp r6,r0	; 0230C3A0
	bcc loc_0230C38A	; 0230C3A2
	b loc_0230C3B6	; 0230C3A4
loc_0230C3A6:
	add r0,r4,#0x0	; 0230C3A6
	mov r1,#0x0	; 0230C3A8
	bl loc_023053DC	; 0230C3AA
	add r0,r4,#0x1	; 0230C3AE
	mov r1,#0x0	; 0230C3B0
	bl loc_023053DC	; 0230C3B2
loc_0230C3B6:
	add r0,r5,#0x0	; 0230C3B6
loc_0230C3B8:
	add sp,#0xc	; 0230C3B8
	pop {r4,r5,r6,r7}	; 0230C3BA
	pop {r3}	; 0230C3BC
	bx r3	; 0230C3BE
pool_0230C3C0:
loc_0230C3C0:
	.word FirmwareWlWorkPointerSlot	; 0230C3C0
pool_0230C3C4:
loc_0230C3C4:
	.word 0x0000014C	; 0230C3C4
pool_0230C3C8:
loc_0230C3C8:
	.word 0x0000FFFF	; 0230C3C8
pool_0230C3CC:
loc_0230C3CC:
	.word 0x0000064C	; 0230C3CC
pool_0230C3D0:
loc_0230C3D0:
	.word 0x00000378	; 0230C3D0
pool_0230C3D4:
loc_0230C3D4:
	.word 0x0000C000	; 0230C3D4
pool_0230C3D8:
loc_0230C3D8:
	.word 0x000002E0	; 0230C3D8

; ===== function loc_0230C3DC =====
loc_0230C3DC:
	bx pc	; 0230C3DC
	.byte 0xC0, 0x46	; 0230C3E0
.arm

; ===== function loc_0230C3E0 =====
loc_0230C3E0:
	ldr pc,[pool_0230C3E4]	; 0230C3E0
pool_0230C3E4:
loc_0230C3E4:
	.word loc_037FCE4C	; 0230C3E4
.thumb

; ===== function loc_0230C3E8 =====
loc_0230C3E8:
	push {r4,r5,r6,r7,lr}	; 0230C3E8
	sub sp,#0xc	; 0230C3EA
	add r6,r0,#0x0	; 0230C3EC
	add r4,r1,#0x0	; 0230C3EE
	add r7,r2,#0x0	; 0230C3F0
	ldr r0,[pool_0230C4F8]	; 0230C3F2
	ldr r1,[r0,#0x0]	; 0230C3F4
	ldr r0,[pool_0230C4FC]	; 0230C3F6
	add r0,r1,r0	; 0230C3F8
	mov r1,#0x60	; 0230C3FA
	bl loc_02305054	; 0230C3FC
	add r5,r0,#0x0	; 0230C400
	cmp r5,#0x0	; 0230C402
	bne loc_0230C410	; 0230C404
	mov r0,#0x2	; 0230C406
	bl loc_02305134	; 0230C408
	add r0,r5,#0x0	; 0230C40C
	b loc_0230C4EE	; 0230C40E
loc_0230C410:
	ldr r0,[pool_0230C500]	; 0230C410
	strh r0,[r5,#0xc]	; 0230C412
	add r5,#0x10	; 0230C414
	cmp r4,#0x0	; 0230C416
	bne loc_0230C42A	; 0230C418
	add r0,r6,#0x0	; 0230C41A
	bl loc_023090F8	; 0230C41C
	str r0,[sp,#0x0]	; 0230C420
	cmp r0,#0x0	; 0230C422
	bne loc_0230C42E	; 0230C424
	mov r4,#0x13	; 0230C426
	b loc_0230C42E	; 0230C428
loc_0230C42A:
	mov r0,#0x0	; 0230C42A
	str r0,[sp,#0x0]	; 0230C42C
loc_0230C42E:
	ldr r0,[pool_0230C4F8]	; 0230C42E
	ldr r1,[r0,#0x0]	; 0230C430
	ldr r0,[pool_0230C504]	; 0230C432
	add r0,r1,r0	; 0230C434
	add r1,r5,#0x0	; 0230C436
	mov r2,#0x2c	; 0230C438
	bl loc_0230C514	; 0230C43A
	ldr r0,[pool_0230C4F8]	; 0230C43E
	ldr r1,[r0,#0x0]	; 0230C440
	ldr r0,[pool_0230C508]	; 0230C442
	ldrh r0,[r1,r0]	; 0230C444
	strh r0,[r5,#0x2c]	; 0230C446
	strh r4,[r5,#0x2e]	; 0230C448
	ldr r0,[sp,#0x0]	; 0230C44A
	strh r0,[r5,#0x30]	; 0230C44C
	cmp r0,#0x0	; 0230C44E
	beq loc_0230C45E	; 0230C450
	add r2,r5,#0x0	; 0230C452
	add r2,#0x30	; 0230C454
	ldrh r1,[r2,#0x0]	; 0230C456
	ldr r0,[pool_0230C50C]	; 0230C458
	orr r1,r0	; 0230C45A
	strh r1,[r2,#0x0]	; 0230C45C
loc_0230C45E:
	add r0,r5,#0x0	; 0230C45E
	add r0,#0x32	; 0230C460
	bl loc_0230BF34	; 0230C462
	add r0,r0,#0x6	; 0230C466
	strh r0,[r5,#0x6]	; 0230C468
	ldrh r0,[r5,#0x6]	; 0230C46A
	add r0,#0x1c	; 0230C46C
	strh r0,[r5,#0x12]	; 0230C46E
	mov r0,#0x10	; 0230C470
	strh r0,[r5,#0x14]	; 0230C472
	add r0,r5,#0x0	; 0230C474
	add r0,#0x18	; 0230C476
	ldr r1,[pool_0230C4F8]	; 0230C478
	ldr r2,[r1,#0x0]	; 0230C47A
	ldr r1,[pool_0230C510]	; 0230C47C
	ldr r2,[r2,r1]	; 0230C47E
	mov r1,#0x1c	; 0230C480
	mul r6,r1	; 0230C482
	add r1,r2,r6	; 0230C484
	add r1,r1,#0x4	; 0230C486
	bl loc_0230645C	; 0230C488
	add r1,r5,#0x0	; 0230C48C
	add r1,#0x14	; 0230C48E
	ldrh r0,[r5,#0x12]	; 0230C490
	add r4,r1,r0	; 0230C492
	cmp r7,#0x0	; 0230C494
	beq loc_0230C4DC	; 0230C496
	add r0,r7,#0x1	; 0230C498
	bl loc_023053B8	; 0230C49A
	str r0,[sp,#0x4]	; 0230C49E
	add r0,r7,#0x0	; 0230C4A0
	bl loc_023053B8	; 0230C4A2
	add r1,r0,#0x0	; 0230C4A6
	add r0,r4,#0x0	; 0230C4A8
	bl loc_023053DC	; 0230C4AA
	add r0,r4,#0x1	; 0230C4AE
	add r4,r4,#0x2	; 0230C4B0
	ldr r1,[sp,#0x4]	; 0230C4B2
	lsl r1,r1,#0x18	; 0230C4B4
	lsr r1,r1,#0x18	; 0230C4B6
	bl loc_023053DC	; 0230C4B8
	mov r6,#0x0	; 0230C4BC
	b loc_0230C4D4	; 0230C4BE
loc_0230C4C0:
	add r0,r7,#0x2	; 0230C4C0
	add r0,r0,r6	; 0230C4C2
	bl loc_023053B8	; 0230C4C4
	add r1,r0,#0x0	; 0230C4C8
	add r0,r4,#0x0	; 0230C4CA
	bl loc_023053DC	; 0230C4CC
	add r6,r6,#0x1	; 0230C4D0
	add r4,r4,#0x1	; 0230C4D2
loc_0230C4D4:
	ldr r0,[sp,#0x4]	; 0230C4D4
	cmp r6,r0	; 0230C4D6
	bcc loc_0230C4C0	; 0230C4D8
	b loc_0230C4EC	; 0230C4DA
loc_0230C4DC:
	add r0,r4,#0x0	; 0230C4DC
	mov r1,#0x0	; 0230C4DE
	bl loc_023053DC	; 0230C4E0
	add r0,r4,#0x1	; 0230C4E4
	mov r1,#0x0	; 0230C4E6
	bl loc_023053DC	; 0230C4E8
loc_0230C4EC:
	add r0,r5,#0x0	; 0230C4EC
loc_0230C4EE:
	add sp,#0xc	; 0230C4EE
	pop {r4,r5,r6,r7}	; 0230C4F0
	pop {r3}	; 0230C4F2
	bx r3	; 0230C4F4
	.byte 0xC0, 0x46	; 0230C4F8
pool_0230C4F8:
loc_0230C4F8:
	.word FirmwareWlWorkPointerSlot	; 0230C4F8
pool_0230C4FC:
loc_0230C4FC:
	.word 0x0000014C	; 0230C4FC
pool_0230C500:
loc_0230C500:
	.word 0x0000FFFF	; 0230C500
pool_0230C504:
loc_0230C504:
	.word 0x0000064C	; 0230C504
pool_0230C508:
loc_0230C508:
	.word 0x00000378	; 0230C508
pool_0230C50C:
loc_0230C50C:
	.word 0x0000C000	; 0230C50C
pool_0230C510:
loc_0230C510:
	.word 0x000002E0	; 0230C510

; ===== function loc_0230C514 =====
loc_0230C514:
	bx pc	; 0230C514
	.byte 0xC0, 0x46	; 0230C518
.arm

; ===== function loc_0230C518 =====
loc_0230C518:
	ldr pc,[pool_0230C51C]	; 0230C518
pool_0230C51C:
loc_0230C51C:
	.word loc_037FCE4C	; 0230C51C
.thumb

; ===== function loc_0230C520 =====
loc_0230C520:
	push {r4,r5,r6,lr}	; 0230C520
	add r6,r0,#0x0	; 0230C522
	ldr r0,[pool_0230C5A0]	; 0230C524
	ldr r1,[r0,#0x0]	; 0230C526
	ldr r0,[pool_0230C5A4]	; 0230C528
	add r0,r1,r0	; 0230C52A
	mov r1,#0x5e	; 0230C52C
	bl loc_02305054	; 0230C52E
	add r5,r0,#0x0	; 0230C532
	cmp r5,#0x0	; 0230C534
	bne loc_0230C542	; 0230C536
	mov r0,#0x2	; 0230C538
	bl loc_02305134	; 0230C53A
	add r0,r5,#0x0	; 0230C53E
	b loc_0230C59A	; 0230C540
loc_0230C542:
	ldr r0,[pool_0230C5A8]	; 0230C542
	strh r0,[r5,#0xc]	; 0230C544
	add r5,#0x10	; 0230C546
	ldr r0,[pool_0230C5A0]	; 0230C548
	ldr r1,[r0,#0x0]	; 0230C54A
	ldr r0,[pool_0230C5AC]	; 0230C54C
	add r0,r1,r0	; 0230C54E
	add r1,r5,#0x0	; 0230C550
	mov r2,#0x2c	; 0230C552
	bl loc_0230C5B8	; 0230C554
	ldr r2,[pool_0230C5A0]	; 0230C558
	ldr r1,[r2,#0x0]	; 0230C55A
	ldr r0,[pool_0230C5B0]	; 0230C55C
	ldrh r0,[r1,r0]	; 0230C55E
	strh r0,[r5,#0x2c]	; 0230C560
	ldr r1,[r2,#0x0]	; 0230C562
	ldr r0,[pool_0230C5B4]	; 0230C564
	ldrh r0,[r1,r0]	; 0230C566
	strh r0,[r5,#0x2e]	; 0230C568
	add r0,r5,#0x0	; 0230C56A
	add r0,#0x30	; 0230C56C
	bl loc_0230BFB4	; 0230C56E
	add r4,r0,#0x0	; 0230C572
	add r0,r5,#0x0	; 0230C574
	add r0,#0x30	; 0230C576
	add r0,r0,r4	; 0230C578
	bl loc_0230BF34	; 0230C57A
	add r0,r4,r0	; 0230C57E
	add r0,r0,#0x4	; 0230C580
	strh r0,[r5,#0x6]	; 0230C582
	ldrh r0,[r5,#0x6]	; 0230C584
	add r0,#0x1c	; 0230C586
	strh r0,[r5,#0x12]	; 0230C588
	mov r0,#0x0	; 0230C58A
	strh r0,[r5,#0x14]	; 0230C58C
	add r0,r5,#0x0	; 0230C58E
	add r0,#0x18	; 0230C590
	add r1,r6,#0x0	; 0230C592
	bl loc_0230645C	; 0230C594
	add r0,r5,#0x0	; 0230C598
loc_0230C59A:
	pop {r4,r5,r6}	; 0230C59A
	pop {r3}	; 0230C59C
	bx r3	; 0230C59E
pool_0230C5A0:
loc_0230C5A0:
	.word FirmwareWlWorkPointerSlot	; 0230C5A0
pool_0230C5A4:
loc_0230C5A4:
	.word 0x0000014C	; 0230C5A4
pool_0230C5A8:
loc_0230C5A8:
	.word 0x0000FFFF	; 0230C5A8
pool_0230C5AC:
loc_0230C5AC:
	.word 0x0000064C	; 0230C5AC
pool_0230C5B0:
loc_0230C5B0:
	.word 0x00000378	; 0230C5B0
pool_0230C5B4:
loc_0230C5B4:
	.word 0x0000036C	; 0230C5B4

; ===== function loc_0230C5B8 =====
loc_0230C5B8:
	bx pc	; 0230C5B8
	.byte 0xC0, 0x46	; 0230C5BC
.arm

; ===== function loc_0230C5BC =====
loc_0230C5BC:
	ldr pc,[pool_0230C5C0]	; 0230C5BC
pool_0230C5C0:
loc_0230C5C0:
	.word loc_037FCE4C	; 0230C5C0
.thumb

; ===== function loc_0230C5C4 =====
loc_0230C5C4:
	push {r4,r5,r6,lr}	; 0230C5C4
	add r6,r0,#0x0	; 0230C5C6
	add r5,r1,#0x0	; 0230C5C8
	ldr r0,[pool_0230C620]	; 0230C5CA
	ldr r1,[r0,#0x0]	; 0230C5CC
	ldr r0,[pool_0230C624]	; 0230C5CE
	add r0,r1,r0	; 0230C5D0
	mov r1,#0x36	; 0230C5D2
	bl loc_02305054	; 0230C5D4
	add r4,r0,#0x0	; 0230C5D8
	cmp r4,#0x0	; 0230C5DA
	bne loc_0230C5E8	; 0230C5DC
	mov r0,#0x2	; 0230C5DE
	bl loc_02305134	; 0230C5E0
	add r0,r4,#0x0	; 0230C5E4
	b loc_0230C61A	; 0230C5E6
loc_0230C5E8:
	ldr r0,[pool_0230C628]	; 0230C5E8
	strh r0,[r4,#0xc]	; 0230C5EA
	add r4,#0x10	; 0230C5EC
	ldr r0,[pool_0230C620]	; 0230C5EE
	ldr r1,[r0,#0x0]	; 0230C5F0
	ldr r0,[pool_0230C62C]	; 0230C5F2
	add r0,r1,r0	; 0230C5F4
	add r1,r4,#0x0	; 0230C5F6
	mov r2,#0x2c	; 0230C5F8
	bl loc_0230C630	; 0230C5FA
	strh r5,[r4,#0x2c]	; 0230C5FE
	mov r0,#0x2	; 0230C600
	strh r0,[r4,#0x6]	; 0230C602
	ldrh r0,[r4,#0x6]	; 0230C604
	add r0,#0x1c	; 0230C606
	strh r0,[r4,#0x12]	; 0230C608
	mov r0,#0xa0	; 0230C60A
	strh r0,[r4,#0x14]	; 0230C60C
	add r0,r4,#0x0	; 0230C60E
	add r0,#0x18	; 0230C610
	add r1,r6,#0x0	; 0230C612
	bl loc_0230645C	; 0230C614
	add r0,r4,#0x0	; 0230C618
loc_0230C61A:
	pop {r4,r5,r6}	; 0230C61A
	pop {r3}	; 0230C61C
	bx r3	; 0230C61E
pool_0230C620:
loc_0230C620:
	.word FirmwareWlWorkPointerSlot	; 0230C620
pool_0230C624:
loc_0230C624:
	.word 0x0000014C	; 0230C624
pool_0230C628:
loc_0230C628:
	.word 0x0000FFFF	; 0230C628
pool_0230C62C:
loc_0230C62C:
	.word 0x0000064C	; 0230C62C

; ===== function loc_0230C630 =====
loc_0230C630:
	bx pc	; 0230C630
	.byte 0xC0, 0x46	; 0230C634
.arm

; ===== function loc_0230C634 =====
loc_0230C634:
	ldr pc,[pool_0230C638]	; 0230C634
pool_0230C638:
loc_0230C638:
	.word loc_037FCE4C	; 0230C638
.thumb

; ===== function loc_0230C63C =====
loc_0230C63C:
	push {r4,r5,lr}	; 0230C63C
	sub sp,#0x4	; 0230C63E
	ldr r0,[pool_0230C6F4]	; 0230C640
	ldr r1,[r0,#0x0]	; 0230C642
	ldr r0,[pool_0230C6F8]	; 0230C644
	ldr r2,[r1,r0]	; 0230C646
	add r2,#0x24	; 0230C648
	ldr r0,[pool_0230C6FC]	; 0230C64A
	ldrh r0,[r1,r0]	; 0230C64C
	add r4,r2,r0	; 0230C64E
	ldr r0,[pool_0230C700]	; 0230C650
	ldrh r2,[r1,r0]	; 0230C652
	cmp r2,#0x0	; 0230C654
	beq loc_0230C696	; 0230C656
	ldr r0,[pool_0230C704]	; 0230C658
	ldrh r3,[r1,r0]	; 0230C65A
	mov r0,#0x1	; 0230C65C
	and r3,r0	; 0230C65E
	cmp r3,#0x0	; 0230C660
	beq loc_0230C688	; 0230C662
	add r0,r4,#0x0	; 0230C664
	add r0,#0xa	; 0230C666
	sub r0,r0,#0x1	; 0230C668
	ldr r3,[pool_0230C708]	; 0230C66A
	ldr r1,[r1,r3]	; 0230C66C
	add r2,r2,#0x2	; 0230C66E
	bl loc_0230545C	; 0230C670
	add r0,r4,#0x0	; 0230C674
	add r0,#0x9	; 0230C676
	ldr r1,[pool_0230C70C]	; 0230C678
	ldrh r1,[r1,#0x0]	; 0230C67A
	asr r1,r1,#0x8	; 0230C67C
	lsl r1,r1,#0x18	; 0230C67E
	lsr r1,r1,#0x18	; 0230C680
	bl loc_023053DC	; 0230C682
	b loc_0230C696	; 0230C686
loc_0230C688:
	add r0,r4,#0x0	; 0230C688
	add r0,#0xa	; 0230C68A
	ldr r3,[pool_0230C708]	; 0230C68C
	ldr r1,[r1,r3]	; 0230C68E
	add r2,r2,#0x1	; 0230C690
	bl loc_0230545C	; 0230C692
loc_0230C696:
	ldr r1,[pool_0230C6F4]	; 0230C696
	ldr r0,[r1,#0x0]	; 0230C698
	ldr r2,[pool_0230C6FC]	; 0230C69A
	ldrh r5,[r0,r2]	; 0230C69C
	add r5,#0x26	; 0230C69E
	ldr r3,[pool_0230C700]	; 0230C6A0
	ldrh r2,[r0,r3]	; 0230C6A2
	add r5,r5,r2	; 0230C6A4
	ldr r2,[pool_0230C6F8]	; 0230C6A6
	ldr r0,[r0,r2]	; 0230C6A8
	strh r5,[r0,#0xa]	; 0230C6AA
	add r0,r4,#0x1	; 0230C6AC
	ldr r1,[r1,#0x0]	; 0230C6AE
	ldrh r1,[r1,r3]	; 0230C6B0
	add r1,#0x8	; 0230C6B2
	lsl r1,r1,#0x18	; 0230C6B4
	lsr r1,r1,#0x18	; 0230C6B6
	bl loc_023053DC	; 0230C6B8
	ldr r0,[pool_0230C6F4]	; 0230C6BC
	ldr r2,[r0,#0x0]	; 0230C6BE
	ldr r0,[pool_0230C710]	; 0230C6C0
	ldrh r1,[r2,r0]	; 0230C6C2
	mov r0,#0x4	; 0230C6C4
	and r1,r0	; 0230C6C6
	cmp r1,#0x0	; 0230C6C8
	beq loc_0230C6E0	; 0230C6CA
	add r4,#0xd	; 0230C6CC
	ldr r0,[pool_0230C700]	; 0230C6CE
	ldrh r0,[r2,r0]	; 0230C6D0
	add r1,r4,r0	; 0230C6D2
	mov r0,#0x3	; 0230C6D4
	bic r1,r0	; 0230C6D6
	ldr r0,[pool_0230C714]	; 0230C6D8
	strh r0,[r1,#0x0]	; 0230C6DA
	ldr r0,[pool_0230C718]	; 0230C6DC
	strh r0,[r1,#0x2]	; 0230C6DE
loc_0230C6E0:
	mov r2,#0x0	; 0230C6E0
	ldr r0,[pool_0230C6F4]	; 0230C6E2
	ldr r1,[r0,#0x0]	; 0230C6E4
	ldr r0,[pool_0230C71C]	; 0230C6E6
	strh r2,[r1,r0]	; 0230C6E8
	add sp,#0x4	; 0230C6EA
	pop {r4,r5}	; 0230C6EC
	pop {r3}	; 0230C6EE
	bx r3	; 0230C6F0
	.byte 0xC0, 0x46	; 0230C6F4
pool_0230C6F4:
loc_0230C6F4:
	.word FirmwareWlWorkPointerSlot	; 0230C6F4
pool_0230C6F8:
loc_0230C6F8:
	.word 0x00000464	; 0230C6F8
pool_0230C6FC:
loc_0230C6FC:
	.word 0x00000392	; 0230C6FC
pool_0230C700:
loc_0230C700:
	.word 0x0000039C	; 0230C700
pool_0230C704:
loc_0230C704:
	.word 0x0000039E	; 0230C704
pool_0230C708:
loc_0230C708:
	.word 0x00000398	; 0230C708
pool_0230C70C:
loc_0230C70C:
	.word FirmwareWlAdjustedTimeSlot	; 0230C70C
pool_0230C710:
loc_0230C710:
	.word 0x0000061C	; 0230C710
pool_0230C714:
loc_0230C714:
	.word 0x0000B6B8	; 0230C714
pool_0230C718:
loc_0230C718:
	.word 0x00001D46	; 0230C718
pool_0230C71C:
loc_0230C71C:
	.word 0x000003A0	; 0230C71C

; ===== function loc_0230C720 =====
loc_0230C720:
	push {r4,r5,r6,r7,lr}	; 0230C720
	sub sp,#0xc	; 0230C722
	ldr r0,[pool_0230C9D4]	; 0230C724
	ldr r1,[r0,#0x0]	; 0230C726
	ldr r0,[pool_0230C9D8]	; 0230C728
	ldr r7,[r1,r0]	; 0230C72A
	mov r0,#0x0	; 0230C72C
	strh r0,[r7,#0x0]	; 0230C72E
	strh r0,[r7,#0x2]	; 0230C730
	strh r0,[r7,#0x4]	; 0230C732
	strh r0,[r7,#0x6]	; 0230C734
	bl loc_0230602C	; 0230C736
	strh r0,[r7,#0x8]	; 0230C73A
	mov r0,#0x80	; 0230C73C
	strh r0,[r7,#0xc]	; 0230C73E
	mov r0,#0x0	; 0230C740
	strh r0,[r7,#0xe]	; 0230C742
	ldr r0,[pool_0230C9D4]	; 0230C744
	ldr r3,[r0,#0x0]	; 0230C746
	add r0,r7,#0x0	; 0230C748
	add r0,#0x10	; 0230C74A
	ldr r1,[pool_0230C9DC]	; 0230C74C
	ldr r2,[pool_0230C9E0]	; 0230C74E
	add r2,r3,r2	; 0230C750
	add r3,r2,#0x0	; 0230C752
	bl loc_02306414	; 0230C754
	mov r1,#0x0	; 0230C758
	strh r1,[r7,#0x22]	; 0230C75A
	add r5,r7,#0x0	; 0230C75C
	add r5,#0x24	; 0230C75E
	str r1,[r5,#0x0]	; 0230C760
	str r1,[r5,#0x4]	; 0230C762
	ldr r0,[pool_0230C9D4]	; 0230C764
	ldr r3,[r0,#0x0]	; 0230C766
	ldr r2,[pool_0230C9E4]	; 0230C768
	ldrh r2,[r3,r2]	; 0230C76A
	strh r2,[r5,#0x8]	; 0230C76C
	ldr r3,[r0,#0x0]	; 0230C76E
	ldr r2,[pool_0230C9E8]	; 0230C770
	ldrh r2,[r3,r2]	; 0230C772
	strh r2,[r5,#0xa]	; 0230C774
	add r4,r5,#0x0	; 0230C776
	add r4,#0xc	; 0230C778
	ldr r0,[r0,#0x0]	; 0230C77A
	ldr r2,[pool_0230C9EC]	; 0230C77C
	ldrh r2,[r0,r2]	; 0230C77E
	lsl r2,r2,#0x1f	; 0230C780
	lsr r2,r2,#0x1f	; 0230C782
	cmp r2,#0x0	; 0230C784
	bne loc_0230C7E0	; 0230C786
	sub r3,r4,r5	; 0230C788
	ldr r2,[pool_0230C9F0]	; 0230C78A
	strh r3,[r0,r2]	; 0230C78C
	add r0,r4,#0x0	; 0230C78E
	bl loc_023053DC	; 0230C790
	add r0,r4,#0x1	; 0230C794
	add r4,r4,#0x2	; 0230C796
	ldr r1,[pool_0230C9D4]	; 0230C798
	ldr r2,[r1,#0x0]	; 0230C79A
	ldr r1,[pool_0230C9F4]	; 0230C79C
	ldrh r1,[r2,r1]	; 0230C79E
	lsl r1,r1,#0x18	; 0230C7A0
	lsr r1,r1,#0x18	; 0230C7A2
	bl loc_023053DC	; 0230C7A4
	mov r6,#0x0	; 0230C7A8
	b loc_0230C7C2	; 0230C7AA
loc_0230C7AC:
	ldr r1,[pool_0230C9F8]	; 0230C7AC
	add r0,r0,r1	; 0230C7AE
	add r0,r0,r6	; 0230C7B0
	bl loc_023053B8	; 0230C7B2
	add r1,r0,#0x0	; 0230C7B6
	add r0,r4,#0x0	; 0230C7B8
	bl loc_023053DC	; 0230C7BA
	add r4,r4,#0x1	; 0230C7BE
	add r6,r6,#0x1	; 0230C7C0
loc_0230C7C2:
	ldr r0,[pool_0230C9D4]	; 0230C7C2
	ldr r0,[r0,#0x0]	; 0230C7C4
	ldr r1,[pool_0230C9F4]	; 0230C7C6
	ldrh r1,[r0,r1]	; 0230C7C8
	cmp r6,r1	; 0230C7CA
	bcc loc_0230C7AC	; 0230C7CC
	mov r0,#0x0	; 0230C7CE
	mvn r0,r0	; 0230C7D0
	sub r0,r0,r6	; 0230C7D2
	add r0,r4,r0	; 0230C7D4
	lsl r1,r6,#0x18	; 0230C7D6
	lsr r1,r1,#0x18	; 0230C7D8
	bl loc_023053DC	; 0230C7DA
	b loc_0230C7E4	; 0230C7DE
loc_0230C7E0:
	ldr r2,[pool_0230C9F0]	; 0230C7E0
	strh r1,[r0,r2]	; 0230C7E2
loc_0230C7E4:
	add r0,r4,#0x0	; 0230C7E4
	bl loc_0230BF34	; 0230C7E6
	add r4,r4,r0	; 0230C7EA
	add r0,r4,#0x0	; 0230C7EC
	mov r1,#0x3	; 0230C7EE
	bl loc_023053DC	; 0230C7F0
	add r0,r4,#0x1	; 0230C7F4
	mov r1,#0x1	; 0230C7F6
	bl loc_023053DC	; 0230C7F8
	add r0,r4,#0x2	; 0230C7FC
	ldr r1,[pool_0230C9D4]	; 0230C7FE
	ldr r2,[r1,#0x0]	; 0230C800
	ldr r1,[pool_0230C9FC]	; 0230C802
	ldrh r1,[r2,r1]	; 0230C804
	lsl r1,r1,#0x18	; 0230C806
	lsr r1,r1,#0x18	; 0230C808
	bl loc_023053DC	; 0230C80A
	add r2,r4,#0x3	; 0230C80E
	sub r3,r2,r5	; 0230C810
	ldr r1,[pool_0230C9D4]	; 0230C812
	ldr r0,[r1,#0x0]	; 0230C814
	ldr r6,[pool_0230CA00]	; 0230C816
	strh r3,[r0,r6]	; 0230C818
	ldr r0,[r1,#0x0]	; 0230C81A
	ldrh r0,[r0,r6]	; 0230C81C
	add r1,r0,#0x2	; 0230C81E
	ldr r0,[pool_0230CA04]	; 0230C820
	strh r1,[r0,#0x0]	; 0230C822
	add r0,r2,#0x0	; 0230C824
	mov r1,#0x5	; 0230C826
	bl loc_023053DC	; 0230C828
	add r0,r4,#0x4	; 0230C82C
	mov r1,#0x5	; 0230C82E
	bl loc_023053DC	; 0230C830
	add r0,r4,#0x5	; 0230C834
	mov r1,#0x0	; 0230C836
	bl loc_023053DC	; 0230C838
	add r0,r4,#0x6	; 0230C83C
	ldr r1,[pool_0230C9D4]	; 0230C83E
	ldr r2,[r1,#0x0]	; 0230C840
	ldr r1,[pool_0230CA08]	; 0230C842
	ldrh r1,[r2,r1]	; 0230C844
	lsl r1,r1,#0x18	; 0230C846
	lsr r1,r1,#0x18	; 0230C848
	bl loc_023053DC	; 0230C84A
	add r0,r4,#0x7	; 0230C84E
	mov r1,#0x0	; 0230C850
	bl loc_023053DC	; 0230C852
	add r0,r4,#0x0	; 0230C856
	add r0,#0x8	; 0230C858
	mov r1,#0x0	; 0230C85A
	bl loc_023053DC	; 0230C85C
	add r0,r4,#0x0	; 0230C860
	add r0,#0x9	; 0230C862
	mov r1,#0x0	; 0230C864
	bl loc_023053DC	; 0230C866
	add r2,r4,#0x0	; 0230C86A
	add r2,#0xa	; 0230C86C
	sub r3,r2,r5	; 0230C86E
	ldr r1,[pool_0230C9D4]	; 0230C870
	ldr r0,[r1,#0x0]	; 0230C872
	ldr r6,[pool_0230CA0C]	; 0230C874
	strh r3,[r0,r6]	; 0230C876
	ldr r1,[r1,#0x0]	; 0230C878
	ldrh r0,[r1,r6]	; 0230C87A
	mov r3,#0x1	; 0230C87C
	and r0,r3	; 0230C87E
	ldr r3,[pool_0230CA10]	; 0230C880
	strh r0,[r1,r3]	; 0230C882
	add r0,r2,#0x0	; 0230C884
	mov r1,#0xdd	; 0230C886
	bl loc_023053DC	; 0230C888
	add r0,r4,#0x0	; 0230C88C
	add r0,#0xb	; 0230C88E
	ldr r1,[pool_0230C9D4]	; 0230C890
	ldr r2,[r1,#0x0]	; 0230C892
	ldr r1,[pool_0230CA14]	; 0230C894
	ldrh r1,[r2,r1]	; 0230C896
	add r1,#0x8	; 0230C898
	lsl r1,r1,#0x18	; 0230C89A
	lsr r1,r1,#0x18	; 0230C89C
	bl loc_023053DC	; 0230C89E
	add r0,r4,#0x0	; 0230C8A2
	add r0,#0xc	; 0230C8A4
	mov r1,#0x0	; 0230C8A6
	bl loc_023053DC	; 0230C8A8
	add r0,r4,#0x0	; 0230C8AC
	add r0,#0xd	; 0230C8AE
	mov r1,#0x9	; 0230C8B0
	bl loc_023053DC	; 0230C8B2
	add r0,r4,#0x0	; 0230C8B6
	add r0,#0xe	; 0230C8B8
	mov r1,#0xbf	; 0230C8BA
	bl loc_023053DC	; 0230C8BC
	add r0,r4,#0x0	; 0230C8C0
	add r0,#0xf	; 0230C8C2
	mov r1,#0x0	; 0230C8C4
	bl loc_023053DC	; 0230C8C6
	ldr r0,[pool_0230C9D4]	; 0230C8CA
	ldr r1,[r0,#0x0]	; 0230C8CC
	ldr r0,[pool_0230CA18]	; 0230C8CE
	ldrh r0,[r1,r0]	; 0230C8D0
	lsl r0,r0,#0x1f	; 0230C8D2
	lsr r0,r0,#0x1f	; 0230C8D4
	cmp r0,#0x1	; 0230C8D6
	bne loc_0230C904	; 0230C8D8
	add r0,r4,#0x0	; 0230C8DA
	add r0,#0x10	; 0230C8DC
	ldr r2,[pool_0230CA1C]	; 0230C8DE
	ldrh r1,[r1,r2]	; 0230C8E0
	lsl r1,r1,#0x18	; 0230C8E2
	lsr r1,r1,#0x18	; 0230C8E4
	bl loc_023053DC	; 0230C8E6
	add r0,r4,#0x0	; 0230C8EA
	add r0,#0x11	; 0230C8EC
	add r4,#0x12	; 0230C8EE
	ldr r1,[pool_0230C9D4]	; 0230C8F0
	ldr r2,[r1,#0x0]	; 0230C8F2
	ldr r1,[pool_0230CA1C]	; 0230C8F4
	ldrh r1,[r2,r1]	; 0230C8F6
	asr r1,r1,#0x8	; 0230C8F8
	lsl r1,r1,#0x18	; 0230C8FA
	lsr r1,r1,#0x18	; 0230C8FC
	bl loc_023053DC	; 0230C8FE
	b loc_0230C91A	; 0230C902
loc_0230C904:
	add r0,r4,#0x0	; 0230C904
	add r0,#0x10	; 0230C906
	mov r1,#0xff	; 0230C908
	bl loc_023053DC	; 0230C90A
	add r0,r4,#0x0	; 0230C90E
	add r0,#0x11	; 0230C910
	add r4,#0x12	; 0230C912
	mov r1,#0xff	; 0230C914
	bl loc_023053DC	; 0230C916
loc_0230C91A:
	ldr r0,[pool_0230CA20]	; 0230C91A
	ldrh r6,[r0,#0x0]	; 0230C91C
	add r0,r4,#0x0	; 0230C91E
	lsl r1,r6,#0x18	; 0230C920
	lsr r1,r1,#0x18	; 0230C922
	bl loc_023053DC	; 0230C924
	add r0,r4,#0x1	; 0230C928
	add r4,r4,#0x2	; 0230C92A
	lsr r1,r6,#0x8	; 0230C92C
	lsl r1,r1,#0x18	; 0230C92E
	lsr r1,r1,#0x18	; 0230C930
	bl loc_023053DC	; 0230C932
	ldr r0,[pool_0230C9D4]	; 0230C936
	ldr r1,[r0,#0x0]	; 0230C938
	ldr r0,[pool_0230CA24]	; 0230C93A
	ldr r0,[r1,r0]	; 0230C93C
	str r0,[sp,#0x0]	; 0230C93E
	mov r6,#0x0	; 0230C940
	b loc_0230C95C	; 0230C942
loc_0230C944:
	ldr r0,[sp,#0x0]	; 0230C944
	bl loc_023053B8	; 0230C946
	add r1,r0,#0x0	; 0230C94A
	add r0,r4,#0x0	; 0230C94C
	bl loc_023053DC	; 0230C94E
	add r4,r4,#0x1	; 0230C952
	ldr r0,[sp,#0x0]	; 0230C954
	add r0,r0,#0x1	; 0230C956
	str r0,[sp,#0x0]	; 0230C958
	add r6,r6,#0x1	; 0230C95A
loc_0230C95C:
	ldr r0,[pool_0230C9D4]	; 0230C95C
	ldr r1,[r0,#0x0]	; 0230C95E
	ldr r0,[pool_0230CA14]	; 0230C960
	ldrh r0,[r1,r0]	; 0230C962
	cmp r6,r0	; 0230C964
	bcc loc_0230C944	; 0230C966
	ldr r2,[pool_0230CA10]	; 0230C968
	ldrh r2,[r1,r2]	; 0230C96A
	cmp r2,#0x0	; 0230C96C
	beq loc_0230C9A2	; 0230C96E
	ldr r2,[pool_0230CA24]	; 0230C970
	ldr r1,[r1,r2]	; 0230C972
	add r0,r1,r0	; 0230C974
	sub r6,r0,#0x1	; 0230C976
	mov r0,#0x0	; 0230C978
	str r0,[sp,#0x4]	; 0230C97A
	b loc_0230C994	; 0230C97C
loc_0230C97E:
	add r0,r6,#0x0	; 0230C97E
	bl loc_023053B8	; 0230C980
	add r1,r0,#0x0	; 0230C984
	add r0,r6,#0x1	; 0230C986
	bl loc_023053DC	; 0230C988
	ldr r0,[sp,#0x4]	; 0230C98C
	add r0,r0,#0x1	; 0230C98E
	str r0,[sp,#0x4]	; 0230C990
	sub r6,r6,#0x1	; 0230C992
loc_0230C994:
	ldr r0,[pool_0230C9D4]	; 0230C994
	ldr r1,[r0,#0x0]	; 0230C996
	ldr r0,[pool_0230CA14]	; 0230C998
	ldrh r2,[r1,r0]	; 0230C99A
	ldr r0,[sp,#0x4]	; 0230C99C
	cmp r0,r2	; 0230C99E
	bcc loc_0230C97E	; 0230C9A0
loc_0230C9A2:
	ldr r0,[pool_0230CA28]	; 0230C9A2
	ldrh r1,[r1,r0]	; 0230C9A4
	mov r0,#0x4	; 0230C9A6
	and r1,r0	; 0230C9A8
	cmp r1,#0x0	; 0230C9AA
	beq loc_0230C9BC	; 0230C9AC
	add r1,r4,#0x3	; 0230C9AE
	mov r0,#0x3	; 0230C9B0
	bic r1,r0	; 0230C9B2
	ldr r0,[pool_0230CA2C]	; 0230C9B4
	strh r0,[r1,#0x0]	; 0230C9B6
	ldr r0,[pool_0230CA30]	; 0230C9B8
	strh r0,[r1,#0x2]	; 0230C9BA
loc_0230C9BC:
	mov r2,#0x0	; 0230C9BC
	ldr r0,[pool_0230C9D4]	; 0230C9BE
	ldr r1,[r0,#0x0]	; 0230C9C0
	ldr r0,[pool_0230CA34]	; 0230C9C2
	strh r2,[r1,r0]	; 0230C9C4
	add r4,#0x1c	; 0230C9C6
	sub r0,r4,r5	; 0230C9C8
	strh r0,[r7,#0xa]	; 0230C9CA
	add sp,#0xc	; 0230C9CC
	pop {r4,r5,r6,r7}	; 0230C9CE
	pop {r3}	; 0230C9D0
	bx r3	; 0230C9D2
pool_0230C9D4:
loc_0230C9D4:
	.word FirmwareWlWorkPointerSlot	; 0230C9D4
pool_0230C9D8:
loc_0230C9D8:
	.word 0x00000464	; 0230C9D8
pool_0230C9DC:
loc_0230C9DC:
	.word 0x0231037C	; 0230C9DC
pool_0230C9E0:
loc_0230C9E0:
	.word 0x000002E8	; 0230C9E0
pool_0230C9E4:
loc_0230C9E4:
	.word 0x0000036A	; 0230C9E4
pool_0230C9E8:
loc_0230C9E8:
	.word 0x00000378	; 0230C9E8
pool_0230C9EC:
loc_0230C9EC:
	.word 0x000002FE	; 0230C9EC
pool_0230C9F0:
loc_0230C9F0:
	.word 0x0000038E	; 0230C9F0
pool_0230C9F4:
loc_0230C9F4:
	.word 0x0000031A	; 0230C9F4
pool_0230C9F8:
loc_0230C9F8:
	.word 0x0000031C	; 0230C9F8
pool_0230C9FC:
loc_0230C9FC:
	.word 0x00000376	; 0230C9FC
pool_0230CA00:
loc_0230CA00:
	.word 0x00000390	; 0230CA00
pool_0230CA04:
loc_0230CA04:
	.word REG_WIFI_TXBUF_TIM	; 0230CA04
pool_0230CA08:
loc_0230CA08:
	.word 0x00000370	; 0230CA08
pool_0230CA0C:
loc_0230CA0C:
	.word 0x00000392	; 0230CA0C
pool_0230CA10:
loc_0230CA10:
	.word 0x0000039E	; 0230CA10
pool_0230CA14:
loc_0230CA14:
	.word 0x0000039C	; 0230CA14
pool_0230CA18:
loc_0230CA18:
	.word 0x00000316	; 0230CA18
pool_0230CA1C:
loc_0230CA1C:
	.word 0x00000300	; 0230CA1C
pool_0230CA20:
loc_0230CA20:
	.word FirmwareWlAdjustedTimeSlot	; 0230CA20
pool_0230CA24:
loc_0230CA24:
	.word 0x00000398	; 0230CA24
pool_0230CA28:
loc_0230CA28:
	.word 0x0000061C	; 0230CA28
pool_0230CA2C:
loc_0230CA2C:
	.word 0x0000B6B8	; 0230CA2C
pool_0230CA30:
loc_0230CA30:
	.word 0x00001D46	; 0230CA30
pool_0230CA34:
loc_0230CA34:
	.word 0x000003A0	; 0230CA34

; ===== function loc_0230CA38 =====
loc_0230CA38:
	ldr r0,[pool_0230CA48]	; 0230CA38
	ldr r3,[r0,#0x0]	; 0230CA3A
	ldr r0,[pool_0230CA4C]	; 0230CA3C
	mov r2,#0x0	; 0230CA3E
	ldr r1,[pool_0230CA50]	; 0230CA40
	strh r2,[r1,#0x0]	; 0230CA42
	strh r2,[r3,r0]	; 0230CA44
	bx lr	; 0230CA46
pool_0230CA48:
loc_0230CA48:
	.word FirmwareWlWorkPointerSlot	; 0230CA48
pool_0230CA4C:
loc_0230CA4C:
	.word 0x0000045C	; 0230CA4C
pool_0230CA50:
loc_0230CA50:
	.word REG_WIFI_TXBUF_BEACON	; 0230CA50

; ===== function loc_0230CA54 =====
loc_0230CA54:
	ldr r0,[pool_0230CA74]	; 0230CA54
	ldr r1,[r0,#0x0]	; 0230CA56
	ldr r0,[pool_0230CA78]	; 0230CA58
	add r1,r1,r0	; 0230CA5A
	mov r0,#0x1	; 0230CA5C
	strh r0,[r1,#0x0]	; 0230CA5E
	ldr r1,[r1,#0x8]	; 0230CA60
	ldr r0,[pool_0230CA7C]	; 0230CA62
	and r1,r0	; 0230CA64
	lsr r1,r1,#0x1	; 0230CA66
	ldr r0,[pool_0230CA80]	; 0230CA68
	orr r1,r0	; 0230CA6A
	ldr r0,[pool_0230CA84]	; 0230CA6C
	strh r1,[r0,#0x0]	; 0230CA6E
	bx lr	; 0230CA70
	.byte 0xC0, 0x46	; 0230CA74
pool_0230CA74:
loc_0230CA74:
	.word FirmwareWlWorkPointerSlot	; 0230CA74
pool_0230CA78:
loc_0230CA78:
	.word 0x0000045C	; 0230CA78
pool_0230CA7C:
loc_0230CA7C:
	.word 0x00003FFF	; 0230CA7C
pool_0230CA80:
loc_0230CA80:
	.word 0x00008000	; 0230CA80
pool_0230CA84:
loc_0230CA84:
	.word REG_WIFI_TXBUF_BEACON	; 0230CA84

; ===== function loc_0230CA88 =====
loc_0230CA88:
	push {r4,lr}	; 0230CA88
	ldr r0,[pool_0230CAD8]	; 0230CA8A
	ldr r1,[r0,#0x0]	; 0230CA8C
	ldr r0,[pool_0230CADC]	; 0230CA8E
	add r4,r1,r0	; 0230CA90
	ldr r0,[pool_0230CAE0]	; 0230CA92
	add r1,r1,r0	; 0230CA94
	ldrh r0,[r1,#0x0]	; 0230CA96
	add r0,r0,#0x1	; 0230CA98
	strh r0,[r1,#0x0]	; 0230CA9A
	ldrh r0,[r4,#0x0]	; 0230CA9C
	cmp r0,#0x0	; 0230CA9E
	beq loc_0230CAAA	; 0230CAA0
	mov r1,#0x0	; 0230CAA2
	ldr r0,[r4,#0x8]	; 0230CAA4
	strh r1,[r0,#0x4]	; 0230CAA6
	b loc_0230CAD2	; 0230CAA8
loc_0230CAAA:
	mov r0,#0x1	; 0230CAAA
	strh r0,[r4,#0x0]	; 0230CAAC
	mov r1,#0x0	; 0230CAAE
	ldr r0,[r4,#0x8]	; 0230CAB0
	strh r1,[r0,#0x0]	; 0230CAB2
	ldr r0,[r4,#0x8]	; 0230CAB4
	strh r1,[r0,#0x4]	; 0230CAB6
	bl loc_0230602C	; 0230CAB8
	ldr r1,[r4,#0x8]	; 0230CABC
	strh r0,[r1,#0x8]	; 0230CABE
	ldr r1,[r4,#0x8]	; 0230CAC0
	ldr r0,[pool_0230CAE4]	; 0230CAC2
	and r1,r0	; 0230CAC4
	lsl r0,r1,#0xf	; 0230CAC6
	lsr r1,r0,#0x10	; 0230CAC8
	ldr r0,[pool_0230CAE8]	; 0230CACA
	orr r1,r0	; 0230CACC
	ldr r0,[pool_0230CAEC]	; 0230CACE
	strh r1,[r0,#0x0]	; 0230CAD0
loc_0230CAD2:
	pop {r4}	; 0230CAD2
	pop {r3}	; 0230CAD4
	bx r3	; 0230CAD6
pool_0230CAD8:
loc_0230CAD8:
	.word FirmwareWlWorkPointerSlot	; 0230CAD8
pool_0230CADC:
loc_0230CADC:
	.word 0x0000040C	; 0230CADC
pool_0230CAE0:
loc_0230CAE0:
	.word 0x0000040E	; 0230CAE0
pool_0230CAE4:
loc_0230CAE4:
	.word 0x00003FFF	; 0230CAE4
pool_0230CAE8:
loc_0230CAE8:
	.word 0x00008000	; 0230CAE8
pool_0230CAEC:
loc_0230CAEC:
	.word REG_WIFI_TXBUF_LOC3	; 0230CAEC

; ===== function loc_0230CAF0 =====
loc_0230CAF0:
	push {r4,lr}	; 0230CAF0
	add r4,r0,#0x0	; 0230CAF2
	add r0,#0x18	; 0230CAF4
	bl loc_023094A0	; 0230CAF6
	strh r0,[r4,#0x2]	; 0230CAFA
	ldrh r0,[r4,#0x2]	; 0230CAFC
	cmp r0,#0xff	; 0230CAFE
	bne loc_0230CB06	; 0230CB00
	mov r0,#0x0	; 0230CB02
	strh r0,[r4,#0x2]	; 0230CB04
loc_0230CB06:
	ldr r0,[pool_0230CB4C]	; 0230CB06
	ldr r1,[r0,#0x0]	; 0230CB08
	ldr r0,[pool_0230CB50]	; 0230CB0A
	ldr r0,[r1,r0]	; 0230CB0C
	strh r0,[r4,#0x4]	; 0230CB0E
	ldrh r1,[r4,#0x14]	; 0230CB10
	ldr r0,[pool_0230CB54]	; 0230CB12
	and r1,r0	; 0230CB14
	cmp r1,#0x0	; 0230CB16
	beq loc_0230CB24	; 0230CB18
	add r1,r4,#0x0	; 0230CB1A
	add r1,#0x12	; 0230CB1C
	ldrh r0,[r1,#0x0]	; 0230CB1E
	add r0,#0x8	; 0230CB20
	strh r0,[r1,#0x0]	; 0230CB22
loc_0230CB24:
	add r0,r4,#0x0	; 0230CB24
	bl loc_02309314	; 0230CB26
	ldr r0,[pool_0230CB4C]	; 0230CB2A
	ldr r2,[r0,#0x0]	; 0230CB2C
	ldr r0,[pool_0230CB58]	; 0230CB2E
	add r0,r2,r0	; 0230CB30
	ldr r1,[pool_0230CB5C]	; 0230CB32
	add r1,r2,r1	; 0230CB34
	sub r4,#0x10	; 0230CB36
	add r2,r4,#0x0	; 0230CB38
	bl loc_02304FAC	; 0230CB3A
	mov r0,#0x1	; 0230CB3E
	bl loc_0230D674	; 0230CB40
	pop {r4}	; 0230CB44
	pop {r3}	; 0230CB46
	bx r3	; 0230CB48
	.byte 0xC0, 0x46	; 0230CB4C
pool_0230CB4C:
loc_0230CB4C:
	.word FirmwareWlWorkPointerSlot	; 0230CB4C
pool_0230CB50:
loc_0230CB50:
	.word 0x000003A4	; 0230CB50
pool_0230CB54:
loc_0230CB54:
	.word 0x00004000	; 0230CB54
pool_0230CB58:
loc_0230CB58:
	.word 0x0000014C	; 0230CB58
pool_0230CB5C:
loc_0230CB5C:
	.word 0x00000164	; 0230CB5C

; ===== function loc_0230CB60 =====
loc_0230CB60:
	push {r4,r5,r6,r7,lr}	; 0230CB60
	sub sp,#0xc	; 0230CB62
	add r7,r0,#0x0	; 0230CB64
	str r1,[sp,#0x0]	; 0230CB66
	mov r0,#0xc	; 0230CB68
	add r4,r7,#0x0	; 0230CB6A
	mul r4,r0	; 0230CB6C
	ldr r0,[pool_0230CBC4]	; 0230CB6E
	ldr r0,[r0,#0x0]	; 0230CB70
	add r1,r0,r4	; 0230CB72
	ldr r0,[pool_0230CBC8]	; 0230CB74
	ldr r5,[r1,r0]	; 0230CB76
	mov r0,#0x0	; 0230CB78
	mvn r0,r0	; 0230CB7A
	cmp r5,r0	; 0230CB7C
	beq loc_0230CBBC	; 0230CB7E
loc_0230CB80:
	add r0,r5,#0x0	; 0230CB80
	bl loc_02304E60	; 0230CB82
	str r0,[sp,#0x4]	; 0230CB86
	add r6,r5,#0x0	; 0230CB88
	add r6,#0x10	; 0230CB8A
	cmp r7,#0x2	; 0230CB8C
	beq loc_0230CB96	; 0230CB8E
	add r0,r6,#0x0	; 0230CB90
	bl loc_023092BC	; 0230CB92
loc_0230CB96:
	mov r0,#0x2	; 0230CB96
	strh r0,[r6,#0x8]	; 0230CB98
	ldr r0,[sp,#0x0]	; 0230CB9A
	cmp r0,#0x0	; 0230CB9C
	beq loc_0230CBB0	; 0230CB9E
	ldr r0,[pool_0230CBC4]	; 0230CBA0
	ldr r1,[r0,#0x0]	; 0230CBA2
	ldr r0,[pool_0230CBC8]	; 0230CBA4
	add r0,r1,r0	; 0230CBA6
	add r0,r0,r4	; 0230CBA8
	add r1,r5,#0x0	; 0230CBAA
	bl loc_0230B1B0	; 0230CBAC
loc_0230CBB0:
	ldr r5,[sp,#0x4]	; 0230CBB0
	mov r0,#0x0	; 0230CBB2
	mvn r1,r0	; 0230CBB4
	lsl r0,r5,#0	; 0230CBB6
	cmp r0,r1	; 0230CBB8
	bne loc_0230CB80	; 0230CBBA
loc_0230CBBC:
	add sp,#0xc	; 0230CBBC
	pop {r4,r5,r6,r7}	; 0230CBBE
	pop {r3}	; 0230CBC0
	bx r3	; 0230CBC2
pool_0230CBC4:
loc_0230CBC4:
	.word FirmwareWlWorkPointerSlot	; 0230CBC4
pool_0230CBC8:
loc_0230CBC8:
	.word 0x00000158	; 0230CBC8

; ===== function loc_0230CBCC =====
loc_0230CBCC:
	push {lr}	; 0230CBCC
	sub sp,#0x4	; 0230CBCE
	ldr r0,[pool_0230CC38]	; 0230CBD0
	ldr r1,[r0,#0x0]	; 0230CBD2
	ldr r0,[pool_0230CC3C]	; 0230CBD4
	ldrh r0,[r1,r0]	; 0230CBD6
	cmp r0,#0x1	; 0230CBD8
	beq loc_0230CBE6	; 0230CBDA
	cmp r0,#0x2	; 0230CBDC
	beq loc_0230CC00	; 0230CBDE
	cmp r0,#0x3	; 0230CBE0
	beq loc_0230CC00	; 0230CBE2
	b loc_0230CC1A	; 0230CBE4
loc_0230CBE6:
	mov r0,#0x0	; 0230CBE6
	mov r1,#0x1	; 0230CBE8
	bl loc_0230CB60	; 0230CBEA
	mov r0,#0x1	; 0230CBEE
	mov r1,#0x0	; 0230CBF0
	bl loc_0230CB60	; 0230CBF2
	mov r0,#0x2	; 0230CBF6
	mov r1,#0x1	; 0230CBF8
	bl loc_0230CB60	; 0230CBFA
	b loc_0230CC32	; 0230CBFE
loc_0230CC00:
	mov r0,#0x0	; 0230CC00
	mov r1,#0x1	; 0230CC02
	bl loc_0230CB60	; 0230CC04
	mov r0,#0x1	; 0230CC08
	mov r1,#0x0	; 0230CC0A
	bl loc_0230CB60	; 0230CC0C
	mov r0,#0x2	; 0230CC10
	mov r1,#0x0	; 0230CC12
	bl loc_0230CB60	; 0230CC14
	b loc_0230CC32	; 0230CC18
loc_0230CC1A:
	mov r0,#0x0	; 0230CC1A
	add r1,r0,#0x0	; 0230CC1C
	bl loc_0230CB60	; 0230CC1E
	mov r0,#0x1	; 0230CC22
	mov r1,#0x0	; 0230CC24
	bl loc_0230CB60	; 0230CC26
	mov r0,#0x2	; 0230CC2A
	mov r1,#0x0	; 0230CC2C
	bl loc_0230CB60	; 0230CC2E
loc_0230CC32:
	add sp,#0x4	; 0230CC32
	pop {r3}	; 0230CC34
	bx r3	; 0230CC36
pool_0230CC38:
loc_0230CC38:
	.word FirmwareWlWorkPointerSlot	; 0230CC38
pool_0230CC3C:
loc_0230CC3C:
	.word 0x00000314	; 0230CC3C
	.byte 0x70, 0xB5, 0x01, 0x88, 0x01, 0x25, 0x29, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x0A, 0x4C, 0x0B, 0x4E	; 0230CC50
	.byte 0x03, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0x14, 0xF8, 0x6D, 0x1C, 0x20, 0x68, 0x80, 0x5B, 0x85, 0x42	; 0230CC60
	.byte 0xF7, 0xD3, 0x05, 0xE0, 0xFC, 0xF7, 0x1C, 0xFC, 0xFF, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x08, 0xF8	; 0230CC70
	.byte 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xE6, 0x02, 0x00, 0x00	; 0230CC80

; ===== function loc_0230CC80 =====
loc_0230CC80:
	push {r4,r5,r6,r7,lr}	; 0230CC80
	sub sp,#0x14	; 0230CC82
	add r7,r0,#0x0	; 0230CC84
	mov r4,#0x0	; 0230CC86
	ldr r0,[pool_0230CD28]	; 0230CC88
	ldr r1,[r0,#0x0]	; 0230CC8A
	ldr r0,[pool_0230CD2C]	; 0230CC8C
	ldr r2,[r1,r0]	; 0230CC8E
	mov r0,#0x1c	; 0230CC90
	add r1,r7,#0x0	; 0230CC92
	mul r1,r0	; 0230CC94
	add r0,r2,r1	; 0230CC96
	ldrh r0,[r0,#0x16]	; 0230CC98
	cmp r0,#0x0	; 0230CC9A
	beq loc_0230CD20	; 0230CC9C
	add r6,r4,#0x0	; 0230CC9E
	str r4,[sp,#0x10]	; 0230CCA0
	str r4,[sp,#0xc]	; 0230CCA2
loc_0230CCA4:
	add r1,r6,#0x0	; 0230CCA4
	str r1,[sp,#0x8]	; 0230CCA6
	mov r0,#0xc	; 0230CCA8
	mul r1,r0	; 0230CCAA
	str r1,[sp,#0x8]	; 0230CCAC
	ldr r0,[pool_0230CD28]	; 0230CCAE
	ldr r1,[r0,#0x0]	; 0230CCB0
	ldr r0,[sp,#0x8]	; 0230CCB2
	add r1,r1,r0	; 0230CCB4
	ldr r0,[pool_0230CD30]	; 0230CCB6
	ldr r5,[r1,r0]	; 0230CCB8
	ldr r0,[sp,#0xc]	; 0230CCBA
	mvn r0,r0	; 0230CCBC
	cmp r5,r0	; 0230CCBE
	beq loc_0230CD1A	; 0230CCC0
	add r1,r6,#0x0	; 0230CCC2
	str r1,[sp,#0x4]	; 0230CCC4
	mov r0,#0x14	; 0230CCC6
	mul r1,r0	; 0230CCC8
	str r1,[sp,#0x4]	; 0230CCCA
loc_0230CCCC:
	add r0,r5,#0x0	; 0230CCCC
	bl loc_02304E60	; 0230CCCE
	str r0,[sp,#0x0]	; 0230CCD2
	add r0,r5,#0x0	; 0230CCD4
	add r0,#0x10	; 0230CCD6
	ldrh r1,[r0,#0x2]	; 0230CCD8
	cmp r1,r7	; 0230CCDA
	bne loc_0230CD0E	; 0230CCDC
	ldr r1,[pool_0230CD28]	; 0230CCDE
	ldr r2,[r1,#0x0]	; 0230CCE0
	ldr r1,[sp,#0x4]	; 0230CCE2
	add r2,r1,r2	; 0230CCE4
	ldr r1,[pool_0230CD34]	; 0230CCE6
	ldr r1,[r2,r1]	; 0230CCE8
	cmp r0,r1	; 0230CCEA
	beq loc_0230CD0E	; 0230CCEC
	mov r1,#0x2	; 0230CCEE
	strh r1,[r0,#0x8]	; 0230CCF0
	bl loc_023092BC	; 0230CCF2
	ldr r0,[pool_0230CD28]	; 0230CCF6
	ldr r1,[r0,#0x0]	; 0230CCF8
	ldr r0,[pool_0230CD30]	; 0230CCFA
	add r1,r1,r0	; 0230CCFC
	ldr r0,[sp,#0x8]	; 0230CCFE
	add r0,r1,r0	; 0230CD00
	add r1,r5,#0x0	; 0230CD02
	bl loc_0230B1B0	; 0230CD04
	cmp r4,#0x0	; 0230CD08
	bne loc_0230CD0E	; 0230CD0A
	mov r4,#0x1	; 0230CD0C
loc_0230CD0E:
	ldr r5,[sp,#0x0]	; 0230CD0E
	ldr r0,[sp,#0x10]	; 0230CD10
	mvn r1,r0	; 0230CD12
	lsl r0,r5,#0	; 0230CD14
	cmp r0,r1	; 0230CD16
	bne loc_0230CCCC	; 0230CD18
loc_0230CD1A:
	add r6,r6,#0x2	; 0230CD1A
	cmp r6,#0x3	; 0230CD1C
	bcc loc_0230CCA4	; 0230CD1E
loc_0230CD20:
	add sp,#0x14	; 0230CD20
	pop {r4,r5,r6,r7}	; 0230CD22
	pop {r3}	; 0230CD24
	bx r3	; 0230CD26
pool_0230CD28:
loc_0230CD28:
	.word FirmwareWlWorkPointerSlot	; 0230CD28
pool_0230CD2C:
loc_0230CD2C:
	.word 0x000002E0	; 0230CD2C
pool_0230CD30:
loc_0230CD30:
	.word 0x00000158	; 0230CD30
pool_0230CD34:
loc_0230CD34:
	.word 0x000003F0	; 0230CD34

; ===== function loc_0230CD38 =====
loc_0230CD38:
	push {r4,r5,r6,lr}	; 0230CD38
	add r6,r0,#0x0	; 0230CD3A
	mov r0,#0x14	; 0230CD3C
	add r4,r6,#0x0	; 0230CD3E
	mul r4,r0	; 0230CD40
	ldr r0,[pool_0230CD88]	; 0230CD42
	ldr r1,[r0,#0x0]	; 0230CD44
	ldr r0,[pool_0230CD8C]	; 0230CD46
	add r0,r1,r0	; 0230CD48
	add r5,r0,r4	; 0230CD4A
	ldr r0,[pool_0230CD90]	; 0230CD4C
	bl loc_02304B4C	; 0230CD4E
	lsl r2,r6,#0x1	; 0230CD52
	ldr r1,[pool_0230CD94]	; 0230CD54
	ldrh r2,[r1,r2]	; 0230CD56
	ldr r1,[pool_0230CD98]	; 0230CD58
	strh r2,[r1,#0x0]	; 0230CD5A
	ldr r1,[pool_0230CD88]	; 0230CD5C
	ldr r1,[r1,#0x0]	; 0230CD5E
	add r2,r1,r4	; 0230CD60
	ldr r1,[pool_0230CD8C]	; 0230CD62
	ldrh r1,[r2,r1]	; 0230CD64
	cmp r1,#0x0	; 0230CD66
	beq loc_0230CD7C	; 0230CD68
	ldr r3,[r5,#0xc]	; 0230CD6A
	ldrh r2,[r3,#0x14]	; 0230CD6C
	ldr r1,[pool_0230CD9C]	; 0230CD6E
	and r2,r1	; 0230CD70
	cmp r2,#0x0	; 0230CD72
	bne loc_0230CD7C	; 0230CD74
	ldr r1,[r5,#0x8]	; 0230CD76
	ldrh r1,[r1,#0x4]	; 0230CD78
	strh r1,[r3,#0xc]	; 0230CD7A
loc_0230CD7C:
	bl loc_02304B5C	; 0230CD7C
	pop {r4,r5,r6}	; 0230CD80
	pop {r3}	; 0230CD82
	bx r3	; 0230CD84
	.byte 0xC0, 0x46	; 0230CD88
pool_0230CD88:
loc_0230CD88:
	.word FirmwareWlWorkPointerSlot	; 0230CD88
pool_0230CD8C:
loc_0230CD8C:
	.word 0x000003E4	; 0230CD8C
pool_0230CD90:
loc_0230CD90:
	.word 0x01000000	; 0230CD90
pool_0230CD94:
loc_0230CD94:
	.word P4_Data_023108A4	; 0230CD94
pool_0230CD98:
loc_0230CD98:
	.word REG_WIFI_TXBUF_RESET	; 0230CD98
pool_0230CD9C:
loc_0230CD9C:
	.word 0x00004000	; 0230CD9C

; ===== function loc_0230CDA0 =====
loc_0230CDA0:
	push {lr}	; 0230CDA0
	sub sp,#0x4	; 0230CDA2
	ldr r1,[pool_0230CDDC]	; 0230CDA4
	ldr r2,[r1,#0x0]	; 0230CDA6
	ldr r1,[pool_0230CDE0]	; 0230CDA8
	add r3,r2,r1	; 0230CDAA
	mov r1,#0x14	; 0230CDAC
	mul r0,r1	; 0230CDAE
	add r2,r3,r0	; 0230CDB0
	ldrh r0,[r3,r0]	; 0230CDB2
	cmp r0,#0x0	; 0230CDB4
	beq loc_0230CDD6	; 0230CDB6
	ldr r0,[r2,#0x8]	; 0230CDB8
	ldrh r1,[r0,#0x0]	; 0230CDBA
	cmp r1,#0x0	; 0230CDBC
	bne loc_0230CDC8	; 0230CDBE
	mov r1,#0x2	; 0230CDC0
	ldr r0,[r2,#0xc]	; 0230CDC2
	strh r1,[r0,#0x8]	; 0230CDC4
	b loc_0230CDCC	; 0230CDC6
loc_0230CDC8:
	ldr r0,[r2,#0xc]	; 0230CDC8
	strh r1,[r0,#0x8]	; 0230CDCA
loc_0230CDCC:
	ldr r0,[r2,#0xc]	; 0230CDCC
	mov r1,#0x0	; 0230CDCE
	ldr r2,[r2,#0x10]	; 0230CDD0
	bl loc_02308C88	; 0230CDD2
loc_0230CDD6:
	add sp,#0x4	; 0230CDD6
	pop {r3}	; 0230CDD8
	bx r3	; 0230CDDA
pool_0230CDDC:
loc_0230CDDC:
	.word FirmwareWlWorkPointerSlot	; 0230CDDC
pool_0230CDE0:
loc_0230CDE0:
	.word 0x000003E4	; 0230CDE0

; ===== function loc_0230CDE4 =====
loc_0230CDE4:
	push {r4,r5,lr}	; 0230CDE4
	sub sp,#0x4	; 0230CDE6
	ldr r0,[pool_0230CE48]	; 0230CDE8
	ldr r1,[r0,#0x0]	; 0230CDEA
	ldr r0,[pool_0230CE4C]	; 0230CDEC
	add r5,r1,r0	; 0230CDEE
	ldr r0,[pool_0230CE50]	; 0230CDF0
	bl loc_02304B4C	; 0230CDF2
	add r4,r0,#0x0	; 0230CDF6
	ldr r0,[pool_0230CE48]	; 0230CDF8
	ldr r1,[r0,#0x0]	; 0230CDFA
	ldr r0,[pool_0230CE54]	; 0230CDFC
	ldrh r0,[r1,r0]	; 0230CDFE
	cmp r0,#0x1	; 0230CE00
	bne loc_0230CE20	; 0230CE02
	mov r1,#0x9	; 0230CE04
	ldr r0,[pool_0230CE58]	; 0230CE06
	strh r1,[r0,#0x0]	; 0230CE08
	ldrh r0,[r5,#0x28]	; 0230CE0A
	cmp r0,#0x0	; 0230CE0C
	beq loc_0230CE16	; 0230CE0E
	mov r0,#0x2	; 0230CE10
	bl loc_0230CDA0	; 0230CE12
loc_0230CE16:
	mov r0,#0x2	; 0230CE16
	mov r1,#0x1	; 0230CE18
	bl loc_0230CB60	; 0230CE1A
	b loc_0230CE26	; 0230CE1E
loc_0230CE20:
	mov r1,#0x1	; 0230CE20
	ldr r0,[pool_0230CE58]	; 0230CE22
	strh r1,[r0,#0x0]	; 0230CE24
loc_0230CE26:
	ldrh r0,[r5,#0x0]	; 0230CE26
	cmp r0,#0x0	; 0230CE28
	beq loc_0230CE32	; 0230CE2A
	mov r0,#0x0	; 0230CE2C
	bl loc_0230CDA0	; 0230CE2E
loc_0230CE32:
	mov r0,#0x0	; 0230CE32
	mov r1,#0x1	; 0230CE34
	bl loc_0230CB60	; 0230CE36
	add r0,r4,#0x0	; 0230CE3A
	bl loc_02304B5C	; 0230CE3C
	add sp,#0x4	; 0230CE40
	pop {r4,r5}	; 0230CE42
	pop {r3}	; 0230CE44
	bx r3	; 0230CE46
pool_0230CE48:
loc_0230CE48:
	.word FirmwareWlWorkPointerSlot	; 0230CE48
pool_0230CE4C:
loc_0230CE4C:
	.word 0x000003E4	; 0230CE4C
pool_0230CE50:
loc_0230CE50:
	.word 0x01000000	; 0230CE50
pool_0230CE54:
loc_0230CE54:
	.word 0x00000314	; 0230CE54
pool_0230CE58:
loc_0230CE58:
	.word REG_WIFI_TXBUF_RESET	; 0230CE58

; ===== function loc_0230CE5C =====
loc_0230CE5C:
	push {r4,lr}	; 0230CE5C
	ldr r0,[pool_0230CE88]	; 0230CE5E
	bl loc_02304B4C	; 0230CE60
	add r4,r0,#0x0	; 0230CE64
	mov r1,#0x2	; 0230CE66
	ldr r0,[pool_0230CE8C]	; 0230CE68
	strh r1,[r0,#0x0]	; 0230CE6A
	ldr r0,[pool_0230CE90]	; 0230CE6C
	ldr r1,[r0,#0x0]	; 0230CE6E
	ldr r0,[pool_0230CE94]	; 0230CE70
	ldrh r0,[r1,r0]	; 0230CE72
	cmp r0,#0x0	; 0230CE74
	beq loc_0230CE7C	; 0230CE76
	bl loc_023087B0	; 0230CE78
loc_0230CE7C:
	add r0,r4,#0x0	; 0230CE7C
	bl loc_02304B5C	; 0230CE7E
	pop {r4}	; 0230CE82
	pop {r3}	; 0230CE84
	bx r3	; 0230CE86
pool_0230CE88:
loc_0230CE88:
	.word 0x01000000	; 0230CE88
pool_0230CE8C:
loc_0230CE8C:
	.word REG_WIFI_TXBUF_RESET	; 0230CE8C
pool_0230CE90:
loc_0230CE90:
	.word FirmwareWlWorkPointerSlot	; 0230CE90
pool_0230CE94:
loc_0230CE94:
	.word 0x00000420	; 0230CE94

; ===== function loc_0230CE98 =====
loc_0230CE98:
	push {r4,lr}	; 0230CE98
	ldr r0,[pool_0230CEC4]	; 0230CE9A
	ldr r1,[r0,#0x0]	; 0230CE9C
	ldr r0,[pool_0230CEC8]	; 0230CE9E
	add r4,r1,r0	; 0230CEA0
	ldr r0,[pool_0230CECC]	; 0230CEA2
	bl loc_02304B4C	; 0230CEA4
	mov r2,#0xc0	; 0230CEA8
	ldr r1,[pool_0230CED0]	; 0230CEAA
	strh r2,[r1,#0x0]	; 0230CEAC
	mov r2,#0x0	; 0230CEAE
	add r1,r4,#0x0	; 0230CEB0
	add r1,#0x50	; 0230CEB2
	strh r2,[r1,#0x0]	; 0230CEB4
	add r4,#0x64	; 0230CEB6
	strh r2,[r4,#0x0]	; 0230CEB8
	bl loc_02304B5C	; 0230CEBA
	pop {r4}	; 0230CEBE
	pop {r3}	; 0230CEC0
	bx r3	; 0230CEC2
pool_0230CEC4:
loc_0230CEC4:
	.word FirmwareWlWorkPointerSlot	; 0230CEC4
pool_0230CEC8:
loc_0230CEC8:
	.word 0x000003E4	; 0230CEC8
pool_0230CECC:
loc_0230CECC:
	.word 0x01000000	; 0230CECC
pool_0230CED0:
loc_0230CED0:
	.word REG_WIFI_TXBUF_RESET	; 0230CED0

; ===== function loc_0230CED4 =====
loc_0230CED4:
	ldr r1,[r0,#0x8]	; 0230CED4
	ldrh r2,[r1,#0x4]	; 0230CED6
	mov r1,#0xff	; 0230CED8
	and r2,r1	; 0230CEDA
	lsl r1,r2,#0x10	; 0230CEDC
	lsr r3,r1,#0x10	; 0230CEDE
	cmp r3,#0x0	; 0230CEE0
	bne loc_0230CEF4	; 0230CEE2
	ldr r1,[pool_0230CF10]	; 0230CEE4
	ldr r2,[r1,#0x0]	; 0230CEE6
	ldr r1,[pool_0230CF14]	; 0230CEE8
	add r2,r2,r1	; 0230CEEA
	ldr r1,[r2,#0x0]	; 0230CEEC
	add r1,r1,#0x1	; 0230CEEE
	str r1,[r2,#0x0]	; 0230CEF0
	b loc_0230CF02	; 0230CEF2
loc_0230CEF4:
	ldr r1,[pool_0230CF10]	; 0230CEF4
	ldr r2,[r1,#0x0]	; 0230CEF6
	ldr r1,[pool_0230CF18]	; 0230CEF8
	add r2,r2,r1	; 0230CEFA
	ldr r1,[r2,#0x0]	; 0230CEFC
	add r1,r1,r3	; 0230CEFE
	str r1,[r2,#0x0]	; 0230CF00
loc_0230CF02:
	add r2,r0,#0x4	; 0230CF02
	ldrh r1,[r2,#0x0]	; 0230CF04
	add r1,r1,#0x1	; 0230CF06
	strh r1,[r2,#0x0]	; 0230CF08
	mov r1,#0x0	; 0230CF0A
	strh r1,[r0,#0x0]	; 0230CF0C
	bx lr	; 0230CF0E
pool_0230CF10:
loc_0230CF10:
	.word FirmwareWlWorkPointerSlot	; 0230CF10
pool_0230CF14:
loc_0230CF14:
	.word 0x00000560	; 0230CF14
pool_0230CF18:
loc_0230CF18:
	.word 0x0000055C	; 0230CF18

; ===== function loc_0230CF1C =====
P4_Code_0230CF1C:
	push {r4,lr}	; 0230CF1C
	add r2,r0,#0x0	; 0230CF1E
	add r4,r1,#0x0	; 0230CF20
	ldr r3,[pool_0230CFB0]	; 0230CF22
	ldr r1,[r3,#0x0]	; 0230CF24
	ldr r0,[pool_0230CFB4]	; 0230CF26
	add r1,r1,r0	; 0230CF28
	ldr r0,[r1,#0x0]	; 0230CF2A
	add r0,r0,#0x1	; 0230CF2C
	str r0,[r1,#0x0]	; 0230CF2E
	ldr r1,[r3,#0x0]	; 0230CF30
	ldr r0,[pool_0230CFB8]	; 0230CF32
	add r0,r1,r0	; 0230CF34
	sub r2,#0x10	; 0230CF36
	add r1,r2,#0x0	; 0230CF38
	bl loc_0230B1B0	; 0230CF3A
	mov r3,#0x0	; 0230CF3E
	ldr r0,[pool_0230CFB0]	; 0230CF40
	ldr r2,[r0,#0x0]	; 0230CF42
	ldr r1,[pool_0230CFBC]	; 0230CF44
	strh r3,[r2,r1]	; 0230CF46
	ldr r2,[r0,#0x0]	; 0230CF48
	ldr r1,[pool_0230CFC0]	; 0230CF4A
	ldr r1,[r2,r1]	; 0230CF4C
	ldrh r1,[r1,#0xc]	; 0230CF4E
	lsl r1,r1,#0x12	; 0230CF50
	lsr r1,r1,#0x1f	; 0230CF52
	cmp r1,#0x0	; 0230CF54
	bne loc_0230CF8A	; 0230CF56
	mov r2,#0x8	; 0230CF58
	ldr r1,[pool_0230CFC4]	; 0230CF5A
	strh r2,[r1,#0x0]	; 0230CF5C
	mov r2,#0x5	; 0230CF5E
	ldr r1,[pool_0230CFC8]	; 0230CF60
	strh r2,[r1,#0x0]	; 0230CF62
	cmp r4,#0x0	; 0230CF64
	beq loc_0230CF8A	; 0230CF66
	ldr r1,[r0,#0x0]	; 0230CF68
	ldr r0,[pool_0230CFCC]	; 0230CF6A
	ldrh r0,[r1,r0]	; 0230CF6C
	cmp r0,#0x0	; 0230CF6E
	beq loc_0230CF78	; 0230CF70
	mov r0,#0x1	; 0230CF72
	bl loc_0230D674	; 0230CF74
loc_0230CF78:
	ldr r0,[pool_0230CFB0]	; 0230CF78
	ldr r1,[r0,#0x0]	; 0230CF7A
	ldr r0,[pool_0230CFD0]	; 0230CF7C
	ldrh r0,[r1,r0]	; 0230CF7E
	cmp r0,#0x0	; 0230CF80
	beq loc_0230CF8A	; 0230CF82
	mov r0,#0x0	; 0230CF84
	bl loc_0230D674	; 0230CF86
loc_0230CF8A:
	ldr r0,[pool_0230CFB0]	; 0230CF8A
	ldr r1,[r0,#0x0]	; 0230CF8C
	ldr r0,[pool_0230CFD4]	; 0230CF8E
	ldrh r0,[r1,r0]	; 0230CF90
	cmp r0,#0x0	; 0230CF92
	beq loc_0230CFA2	; 0230CF94
	cmp r4,#0x0	; 0230CF96
	beq loc_0230CFA8	; 0230CF98
	mov r0,#0x2	; 0230CF9A
	bl loc_0230D674	; 0230CF9C
	b loc_0230CFA8	; 0230CFA0
loc_0230CFA2:
	mov r0,#0x0	; 0230CFA2
	bl loc_02308F98	; 0230CFA4
loc_0230CFA8:
	pop {r4}	; 0230CFA8
	pop {r3}	; 0230CFAA
	bx r3	; 0230CFAC
	.byte 0xC0, 0x46	; 0230CFB0
pool_0230CFB0:
loc_0230CFB0:
	.word FirmwareWlWorkPointerSlot	; 0230CFB0
pool_0230CFB4:
loc_0230CFB4:
	.word 0x00000508	; 0230CFB4
pool_0230CFB8:
loc_0230CFB8:
	.word 0x00000170	; 0230CFB8
pool_0230CFBC:
loc_0230CFBC:
	.word 0x0000040C	; 0230CFBC
pool_0230CFC0:
loc_0230CFC0:
	.word 0x00000414	; 0230CFC0
pool_0230CFC4:
loc_0230CFC4:
	.word REG_WIFI_TXREQ_RESET	; 0230CFC4
pool_0230CFC8:
loc_0230CFC8:
	.word REG_WIFI_TXREQ_SET	; 0230CFC8
pool_0230CFCC:
loc_0230CFCC:
	.word 0x0000016C	; 0230CFCC
pool_0230CFD0:
loc_0230CFD0:
	.word 0x00000160	; 0230CFD0
pool_0230CFD4:
loc_0230CFD4:
	.word 0x00000178	; 0230CFD4

; ===== function loc_0230CFD8 =====
P4_Code_0230CFD8:
	push {r4,r5,lr}	; 0230CFD8
	sub sp,#0x4	; 0230CFDA
	ldr r1,[pool_0230D02C]	; 0230CFDC
	ldr r2,[r1,#0x0]	; 0230CFDE
	ldr r1,[pool_0230D030]	; 0230CFE0
	add r2,r2,r1	; 0230CFE2
	add r1,r2,#0x0	; 0230CFE4
	add r1,#0x8	; 0230CFE6
	ldr r5,[r1,#0x0]	; 0230CFE8
	ldrh r4,[r0,#0x4]	; 0230CFEA
	mov r3,#0xff	; 0230CFEC
	and r4,r3	; 0230CFEE
	lsl r3,r4,#0x10	; 0230CFF0
	lsr r3,r3,#0x10	; 0230CFF2
	add r3,r5,r3	; 0230CFF4
	str r3,[r1,#0x0]	; 0230CFF6
	ldrh r1,[r0,#0x0]	; 0230CFF8
	mov r0,#0x2	; 0230CFFA
	and r1,r0	; 0230CFFC
	cmp r1,#0x0	; 0230CFFE
	bne loc_0230D012	; 0230D000
	ldr r0,[r2,#0x0]	; 0230D002
	add r0,r0,#0x1	; 0230D004
	str r0,[r2,#0x0]	; 0230D006
	add r2,#0x10	; 0230D008
	ldr r0,[r2,#0x0]	; 0230D00A
	add r0,r0,#0x1	; 0230D00C
	str r0,[r2,#0x0]	; 0230D00E
	b loc_0230D01A	; 0230D010
loc_0230D012:
	add r1,r2,#0x4	; 0230D012
	ldr r0,[r1,#0x0]	; 0230D014
	add r0,r0,#0x1	; 0230D016
	str r0,[r1,#0x0]	; 0230D018
loc_0230D01A:
	mov r2,#0x0	; 0230D01A
	ldr r0,[pool_0230D02C]	; 0230D01C
	ldr r1,[r0,#0x0]	; 0230D01E
	ldr r0,[pool_0230D034]	; 0230D020
	strh r2,[r1,r0]	; 0230D022
	add sp,#0x4	; 0230D024
	pop {r4,r5}	; 0230D026
	pop {r3}	; 0230D028
	bx r3	; 0230D02A
pool_0230D02C:
loc_0230D02C:
	.word FirmwareWlWorkPointerSlot	; 0230D02C
pool_0230D030:
loc_0230D030:
	.word 0x000004F4	; 0230D030
pool_0230D034:
loc_0230D034:
	.word 0x0000040C	; 0230D034

; ===== function loc_0230D038 =====
P4_Code_0230D038:
	push {r4,r5,r6,r7,lr}	; 0230D038
	sub sp,#0x4	; 0230D03A
	add r5,r0,#0x0	; 0230D03C
	str r1,[sp,#0x0]	; 0230D03E
	ldr r0,[pool_0230D320]	; 0230D040
	ldr r1,[r0,#0x0]	; 0230D042
	ldr r0,[pool_0230D324]	; 0230D044
	add r4,r1,r0	; 0230D046
	ldrh r6,[r5,#0x2]	; 0230D048
	ldrh r1,[r5,#0x8]	; 0230D04A
	mov r0,#0x2	; 0230D04C
	and r1,r0	; 0230D04E
	cmp r1,#0x0	; 0230D050
	bne loc_0230D0B4	; 0230D052
	ldr r0,[r4,#0x0]	; 0230D054
	add r0,r0,#0x1	; 0230D056
	str r0,[r4,#0x0]	; 0230D058
	ldrh r1,[r5,#0x18]	; 0230D05A
	mov r0,#0x1	; 0230D05C
	and r1,r0	; 0230D05E
	cmp r1,#0x0	; 0230D060
	beq loc_0230D070	; 0230D062
	add r1,r4,#0x0	; 0230D064
	add r1,#0x14	; 0230D066
	ldr r0,[r1,#0x0]	; 0230D068
	add r0,r0,#0x1	; 0230D06A
	str r0,[r1,#0x0]	; 0230D06C
	b loc_0230D07A	; 0230D06E
loc_0230D070:
	add r1,r4,#0x0	; 0230D070
	add r1,#0x10	; 0230D072
	ldr r0,[r1,#0x0]	; 0230D074
	add r0,r0,#0x1	; 0230D076
	str r0,[r1,#0x0]	; 0230D078
loc_0230D07A:
	ldr r0,[pool_0230D320]	; 0230D07A
	ldr r3,[r0,#0x0]	; 0230D07C
	ldr r0,[pool_0230D328]	; 0230D07E
	ldrh r0,[r3,r0]	; 0230D080
	asr r0,r6	; 0230D082
	mov r1,#0x1	; 0230D084
	and r0,r1	; 0230D086
	cmp r0,#0x0	; 0230D088
	beq loc_0230D0BC	; 0230D08A
	ldrh r2,[r5,#0x14]	; 0230D08C
	ldr r0,[pool_0230D32C]	; 0230D08E
	and r2,r0	; 0230D090
	cmp r2,#0x0	; 0230D092
	bne loc_0230D0BC	; 0230D094
	ldr r0,[pool_0230D330]	; 0230D096
	ldr r2,[r3,r0]	; 0230D098
	mov r0,#0x1c	; 0230D09A
	add r7,r6,#0x0	; 0230D09C
	mul r7,r0	; 0230D09E
	ldrh r0,[r2,r7]	; 0230D0A0
	cmp r0,#0x40	; 0230D0A2
	bne loc_0230D0BC	; 0230D0A4
	ldr r0,[pool_0230D334]	; 0230D0A6
	add r2,r3,r0	; 0230D0A8
	ldrh r0,[r2,#0x0]	; 0230D0AA
	lsl r1,r6	; 0230D0AC
	bic r0,r1	; 0230D0AE
	strh r0,[r2,#0x0]	; 0230D0B0
	b loc_0230D0BC	; 0230D0B2
loc_0230D0B4:
	add r1,r4,#0x4	; 0230D0B4
	ldr r0,[r1,#0x0]	; 0230D0B6
	add r0,r0,#0x1	; 0230D0B8
	str r0,[r1,#0x0]	; 0230D0BA
loc_0230D0BC:
	ldrh r0,[r5,#0x14]	; 0230D0BC
	lsl r0,r0,#0x11	; 0230D0BE
	lsr r0,r0,#0x1f	; 0230D0C0
	cmp r0,#0x0	; 0230D0C2
	beq loc_0230D0D0	; 0230D0C4
	add r1,r4,#0x0	; 0230D0C6
	add r1,#0x18	; 0230D0C8
	ldr r0,[r1,#0x0]	; 0230D0CA
	add r0,r0,#0x1	; 0230D0CC
	str r0,[r1,#0x0]	; 0230D0CE
loc_0230D0D0:
	add r4,#0x8	; 0230D0D0
	ldr r1,[r4,#0x0]	; 0230D0D2
	ldrh r0,[r5,#0xc]	; 0230D0D4
	lsl r0,r0,#0x8	; 0230D0D6
	lsr r0,r0,#0x10	; 0230D0D8
	add r0,r1,r0	; 0230D0DA
	str r0,[r4,#0x0]	; 0230D0DC
	ldrh r4,[r5,#0x14]	; 0230D0DE
	mov r0,#0xfc	; 0230D0E0
	and r4,r0	; 0230D0E2
	cmp r4,#0x30	; 0230D0E4
	bhi loc_0230D0FC	; 0230D0E6
	cmp r4,#0x30	; 0230D0E8
	bcs loc_0230D172	; 0230D0EA
	cmp r4,#0x10	; 0230D0EC
	bhi loc_0230D0F8	; 0230D0EE
	cmp r4,#0x10	; 0230D0F0
	bcs loc_0230D172	; 0230D0F2
	cmp r4,#0x0	; 0230D0F4
	b loc_0230D2E2	; 0230D0F6
loc_0230D0F8:
	cmp r4,#0x20	; 0230D0F8
	b loc_0230D2E2	; 0230D0FA
loc_0230D0FC:
	cmp r4,#0xb0	; 0230D0FC
	bhi loc_0230D10A	; 0230D0FE
	cmp r4,#0xb0	; 0230D100
	bcs loc_0230D112	; 0230D102
	cmp r4,#0xa0	; 0230D104
	beq loc_0230D1C4	; 0230D106
	b loc_0230D2E2	; 0230D108
loc_0230D10A:
	cmp r4,#0xc0	; 0230D10A
	bne loc_0230D110	; 0230D10C
	b loc_0230D254	; 0230D10E
loc_0230D110:
	b loc_0230D2E2	; 0230D110
loc_0230D112:
	ldrh r1,[r5,#0x8]	; 0230D112
	mov r0,#0x2	; 0230D114
	and r1,r0	; 0230D116
	cmp r1,#0x0	; 0230D118
	beq loc_0230D11E	; 0230D11A
	b loc_0230D2E2	; 0230D11C
loc_0230D11E:
	ldrh r1,[r5,#0x2c]	; 0230D11E
	cmp r1,#0x0	; 0230D120
	bne loc_0230D146	; 0230D122
	ldrh r0,[r5,#0x2e]	; 0230D124
	cmp r0,#0x2	; 0230D126
	bne loc_0230D146	; 0230D128
	ldrh r0,[r5,#0x30]	; 0230D12A
	cmp r0,#0x0	; 0230D12C
	bne loc_0230D146	; 0230D12E
	lsl r0,r6,#0x10	; 0230D130
	lsr r0,r0,#0x10	; 0230D132
	mov r1,#0x30	; 0230D134
	bl loc_023091F0	; 0230D136
	add r0,r5,#0x0	; 0230D13A
	add r0,#0x18	; 0230D13C
	ldrh r1,[r5,#0x2c]	; 0230D13E
	bl loc_02309BC4	; 0230D140
	b loc_0230D2E2	; 0230D144
loc_0230D146:
	cmp r1,#0x1	; 0230D146
	beq loc_0230D14C	; 0230D148
	b loc_0230D2E2	; 0230D14A
loc_0230D14C:
	ldrh r0,[r5,#0x2e]	; 0230D14C
	cmp r0,#0x4	; 0230D14E
	beq loc_0230D154	; 0230D150
	b loc_0230D2E2	; 0230D152
loc_0230D154:
	ldrh r0,[r5,#0x30]	; 0230D154
	cmp r0,#0x0	; 0230D156
	beq loc_0230D15C	; 0230D158
	b loc_0230D2E2	; 0230D15A
loc_0230D15C:
	lsl r0,r6,#0x10	; 0230D15C
	lsr r0,r0,#0x10	; 0230D15E
	mov r1,#0x30	; 0230D160
	bl loc_023091F0	; 0230D162
	add r0,r5,#0x0	; 0230D166
	add r0,#0x18	; 0230D168
	ldrh r1,[r5,#0x2c]	; 0230D16A
	bl loc_02309BC4	; 0230D16C
	b loc_0230D2E2	; 0230D170
loc_0230D172:
	ldrh r1,[r5,#0x8]	; 0230D172
	mov r0,#0x2	; 0230D174
	and r1,r0	; 0230D176
	cmp r1,#0x0	; 0230D178
	bne loc_0230D1BA	; 0230D17A
	ldrh r0,[r5,#0x2e]	; 0230D17C
	cmp r0,#0x0	; 0230D17E
	beq loc_0230D184	; 0230D180
	b loc_0230D2E2	; 0230D182
loc_0230D184:
	lsl r0,r6,#0x10	; 0230D184
	lsr r0,r0,#0x10	; 0230D186
	mov r1,#0x40	; 0230D188
	bl loc_023091F0	; 0230D18A
	cmp r4,#0x10	; 0230D18E
	bne loc_0230D1A6	; 0230D190
	add r0,r5,#0x0	; 0230D192
	add r0,#0x18	; 0230D194
	ldrh r1,[r5,#0x30]	; 0230D196
	add r3,r5,#0x0	; 0230D198
	add r3,#0x14	; 0230D19A
	ldrh r2,[r5,#0x12]	; 0230D19C
	add r2,r3,r2	; 0230D19E
	bl loc_02309AC8	; 0230D1A0
	b loc_0230D2E2	; 0230D1A4
loc_0230D1A6:
	add r0,r5,#0x0	; 0230D1A6
	add r0,#0x18	; 0230D1A8
	ldrh r1,[r5,#0x30]	; 0230D1AA
	add r3,r5,#0x0	; 0230D1AC
	add r3,#0x14	; 0230D1AE
	ldrh r2,[r5,#0x12]	; 0230D1B0
	add r2,r3,r2	; 0230D1B2
	bl loc_02309A2C	; 0230D1B4
	b loc_0230D2E2	; 0230D1B8
loc_0230D1BA:
	lsl r0,r6,#0x10	; 0230D1BA
	lsr r0,r0,#0x10	; 0230D1BC
	bl loc_023090A4	; 0230D1BE
	b loc_0230D2E2	; 0230D1C2
loc_0230D1C4:
	ldr r7,[pool_0230D320]	; 0230D1C4
	ldr r0,[r7,#0x0]	; 0230D1C6
	ldr r1,[pool_0230D338]	; 0230D1C8
	ldrh r1,[r0,r1]	; 0230D1CA
	cmp r1,#0x1	; 0230D1CC
	bne loc_0230D224	; 0230D1CE
	cmp r6,#0x0	; 0230D1D0
	beq loc_0230D1F0	; 0230D1D2
	ldr r1,[pool_0230D330]	; 0230D1D4
	ldr r2,[r0,r1]	; 0230D1D6
	mov r0,#0x1c	; 0230D1D8
	add r1,r6,#0x0	; 0230D1DA
	mul r1,r0	; 0230D1DC
	ldrh r0,[r2,r1]	; 0230D1DE
	cmp r0,#0x30	; 0230D1E0
	bls loc_0230D236	; 0230D1E2
	lsl r0,r6,#0x10	; 0230D1E4
	lsr r0,r0,#0x10	; 0230D1E6
	mov r1,#0x30	; 0230D1E8
	bl loc_023091F0	; 0230D1EA
	b loc_0230D236	; 0230D1EE
loc_0230D1F0:
	ldrh r0,[r5,#0x18]	; 0230D1F0
	mov r4,#0x1	; 0230D1F2
	and r0,r4	; 0230D1F4
	cmp r0,#0x0	; 0230D1F6
	beq loc_0230D236	; 0230D1F8
	mov r6,#0x1c	; 0230D1FA
	b loc_0230D218	; 0230D1FC
loc_0230D1FE:
	ldr r1,[pool_0230D330]	; 0230D1FE
	ldr r1,[r0,r1]	; 0230D200
	add r0,r4,#0x0	; 0230D202
	mul r0,r6	; 0230D204
	ldrh r0,[r1,r0]	; 0230D206
	cmp r0,#0x30	; 0230D208
	bls loc_0230D216	; 0230D20A
	lsl r0,r4,#0x10	; 0230D20C
	lsr r0,r0,#0x10	; 0230D20E
	mov r1,#0x30	; 0230D210
	bl loc_023091F0	; 0230D212
loc_0230D216:
	add r4,r4,#0x1	; 0230D216
loc_0230D218:
	ldr r0,[r7,#0x0]	; 0230D218
	ldr r1,[pool_0230D33C]	; 0230D21A
	ldrh r1,[r0,r1]	; 0230D21C
	cmp r4,r1	; 0230D21E
	bcc loc_0230D1FE	; 0230D220
	b loc_0230D236	; 0230D222
loc_0230D224:
	ldr r1,[pool_0230D340]	; 0230D224
	ldrh r0,[r0,r1]	; 0230D226
	cmp r0,#0x30	; 0230D228
	bls loc_0230D236	; 0230D22A
	mov r0,#0x30	; 0230D22C
	bl loc_0230646C	; 0230D22E
	bl loc_023064D8	; 0230D232
loc_0230D236:
	ldr r0,[pool_0230D320]	; 0230D236
	ldr r4,[r0,#0x0]	; 0230D238
	ldr r2,[pool_0230D344]	; 0230D23A
	ldrh r1,[r4,r2]	; 0230D23C
	cmp r1,#0x71	; 0230D23E
	bne loc_0230D2E2	; 0230D240
	mov r3,#0x0	; 0230D242
	ldr r1,[pool_0230D348]	; 0230D244
	ldr r1,[r4,r1]	; 0230D246
	strh r3,[r1,#0x4]	; 0230D248
	ldr r0,[r0,#0x0]	; 0230D24A
	strh r3,[r0,r2]	; 0230D24C
	bl loc_02309C1C	; 0230D24E
	b loc_0230D2E2	; 0230D252
loc_0230D254:
	ldr r7,[pool_0230D320]	; 0230D254
	ldr r0,[r7,#0x0]	; 0230D256
	ldr r1,[pool_0230D338]	; 0230D258
	ldrh r1,[r0,r1]	; 0230D25A
	cmp r1,#0x1	; 0230D25C
	bne loc_0230D2B4	; 0230D25E
	cmp r6,#0x0	; 0230D260
	beq loc_0230D280	; 0230D262
	ldr r1,[pool_0230D330]	; 0230D264
	ldr r2,[r0,r1]	; 0230D266
	mov r0,#0x1c	; 0230D268
	add r1,r6,#0x0	; 0230D26A
	mul r1,r0	; 0230D26C
	ldrh r0,[r2,r1]	; 0230D26E
	cmp r0,#0x20	; 0230D270
	bls loc_0230D2C6	; 0230D272
	lsl r0,r6,#0x10	; 0230D274
	lsr r0,r0,#0x10	; 0230D276
	mov r1,#0x20	; 0230D278
	bl loc_023091F0	; 0230D27A
	b loc_0230D2C6	; 0230D27E
loc_0230D280:
	ldrh r0,[r5,#0x18]	; 0230D280
	mov r4,#0x1	; 0230D282
	and r0,r4	; 0230D284
	cmp r0,#0x0	; 0230D286
	beq loc_0230D2C6	; 0230D288
	mov r6,#0x1c	; 0230D28A
	b loc_0230D2A8	; 0230D28C
loc_0230D28E:
	ldr r1,[pool_0230D330]	; 0230D28E
	ldr r1,[r0,r1]	; 0230D290
	add r0,r4,#0x0	; 0230D292
	mul r0,r6	; 0230D294
	ldrh r0,[r1,r0]	; 0230D296
	cmp r0,#0x20	; 0230D298
	bls loc_0230D2A6	; 0230D29A
	lsl r0,r4,#0x10	; 0230D29C
	lsr r0,r0,#0x10	; 0230D29E
	mov r1,#0x20	; 0230D2A0
	bl loc_023091F0	; 0230D2A2
loc_0230D2A6:
	add r4,r4,#0x1	; 0230D2A6
loc_0230D2A8:
	ldr r0,[r7,#0x0]	; 0230D2A8
	ldr r1,[pool_0230D33C]	; 0230D2AA
	ldrh r1,[r0,r1]	; 0230D2AC
	cmp r4,r1	; 0230D2AE
	bcc loc_0230D28E	; 0230D2B0
	b loc_0230D2C6	; 0230D2B2
loc_0230D2B4:
	ldr r1,[pool_0230D340]	; 0230D2B4
	ldrh r0,[r0,r1]	; 0230D2B6
	cmp r0,#0x20	; 0230D2B8
	bls loc_0230D2C6	; 0230D2BA
	mov r0,#0x20	; 0230D2BC
	bl loc_0230646C	; 0230D2BE
	bl loc_023064D8	; 0230D2C2
loc_0230D2C6:
	ldr r0,[pool_0230D320]	; 0230D2C6
	ldr r4,[r0,#0x0]	; 0230D2C8
	ldr r2,[pool_0230D344]	; 0230D2CA
	ldrh r1,[r4,r2]	; 0230D2CC
	cmp r1,#0x41	; 0230D2CE
	bne loc_0230D2E2	; 0230D2D0
	mov r3,#0x0	; 0230D2D2
	ldr r1,[pool_0230D348]	; 0230D2D4
	ldr r1,[r4,r1]	; 0230D2D6
	strh r3,[r1,#0x4]	; 0230D2D8
	ldr r0,[r0,#0x0]	; 0230D2DA
	strh r3,[r0,r2]	; 0230D2DC
	bl loc_02309C1C	; 0230D2DE
loc_0230D2E2:
	add r0,r5,#0x0	; 0230D2E2
	bl loc_023092BC	; 0230D2E4
	ldr r0,[pool_0230D320]	; 0230D2E8
	ldr r1,[r0,#0x0]	; 0230D2EA
	ldr r0,[pool_0230D34C]	; 0230D2EC
	add r0,r1,r0	; 0230D2EE
	sub r5,#0x10	; 0230D2F0
	add r1,r5,#0x0	; 0230D2F2
	bl loc_02304FFC	; 0230D2F4
	mov r3,#0x0	; 0230D2F8
	ldr r2,[pool_0230D320]	; 0230D2FA
	ldr r1,[r2,#0x0]	; 0230D2FC
	ldr r0,[pool_0230D350]	; 0230D2FE
	strh r3,[r1,r0]	; 0230D300
	ldr r0,[sp,#0x0]	; 0230D302
	cmp r0,#0x0	; 0230D304
	beq loc_0230D318	; 0230D306
	ldr r1,[r2,#0x0]	; 0230D308
	ldr r0,[pool_0230D354]	; 0230D30A
	ldrh r0,[r1,r0]	; 0230D30C
	cmp r0,#0x0	; 0230D30E
	beq loc_0230D318	; 0230D310
	mov r0,#0x1	; 0230D312
	bl loc_0230D674	; 0230D314
loc_0230D318:
	add sp,#0x4	; 0230D318
	pop {r4,r5,r6,r7}	; 0230D31A
	pop {r3}	; 0230D31C
	bx r3	; 0230D31E
pool_0230D320:
loc_0230D320:
	.word FirmwareWlWorkPointerSlot	; 0230D320
pool_0230D324:
loc_0230D324:
	.word 0x000004F4	; 0230D324
pool_0230D328:
loc_0230D328:
	.word 0x000004EA	; 0230D328
pool_0230D32C:
loc_0230D32C:
	.word 0x00002000	; 0230D32C
pool_0230D330:
loc_0230D330:
	.word 0x000002E0	; 0230D330
pool_0230D334:
loc_0230D334:
	.word 0x000004EC	; 0230D334
pool_0230D338:
loc_0230D338:
	.word 0x00000314	; 0230D338
pool_0230D33C:
loc_0230D33C:
	.word 0x000002E6	; 0230D33C
pool_0230D340:
loc_0230D340:
	.word 0x00000310	; 0230D340
pool_0230D344:
loc_0230D344:
	.word 0x000003BC	; 0230D344
pool_0230D348:
loc_0230D348:
	.word 0x000003D8	; 0230D348
pool_0230D34C:
loc_0230D34C:
	.word 0x00000164	; 0230D34C
pool_0230D350:
loc_0230D350:
	.word 0x000003F8	; 0230D350
pool_0230D354:
loc_0230D354:
	.word 0x0000016C	; 0230D354

; ===== function loc_0230D358 =====
P4_Code_0230D358:
	push {r4,r5,r6,r7,lr}	; 0230D358
	sub sp,#0x4	; 0230D35A
	add r5,r0,#0x0	; 0230D35C
	add r6,r1,#0x0	; 0230D35E
	ldr r1,[pool_0230D4A0]	; 0230D360
	ldr r2,[r1,#0x0]	; 0230D362
	ldr r1,[pool_0230D4A4]	; 0230D364
	add r4,r2,r1	; 0230D366
	add r7,r5,#0x0	; 0230D368
	sub r7,#0x10	; 0230D36A
	bl loc_023092BC	; 0230D36C
	ldrh r1,[r5,#0x8]	; 0230D370
	mov r0,#0x2	; 0230D372
	and r1,r0	; 0230D374
	cmp r1,#0x0	; 0230D376
	bne loc_0230D3CE	; 0230D378
	ldr r0,[r4,#0x0]	; 0230D37A
	add r0,r0,#0x1	; 0230D37C
	str r0,[r4,#0x0]	; 0230D37E
	ldrh r0,[r5,#0x14]	; 0230D380
	lsl r0,r0,#0x17	; 0230D382
	lsr r0,r0,#0x1f	; 0230D384
	cmp r0,#0x0	; 0230D386
	beq loc_0230D3AC	; 0230D388
	ldrh r1,[r5,#0x24]	; 0230D38A
	mov r0,#0x1	; 0230D38C
	and r1,r0	; 0230D38E
	cmp r1,#0x0	; 0230D390
	beq loc_0230D3A0	; 0230D392
	add r1,r4,#0x0	; 0230D394
	add r1,#0x14	; 0230D396
	ldr r0,[r1,#0x0]	; 0230D398
	add r0,r0,#0x1	; 0230D39A
	str r0,[r1,#0x0]	; 0230D39C
	b loc_0230D3D6	; 0230D39E
loc_0230D3A0:
	add r1,r4,#0x0	; 0230D3A0
	add r1,#0x10	; 0230D3A2
	ldr r0,[r1,#0x0]	; 0230D3A4
	add r0,r0,#0x1	; 0230D3A6
	str r0,[r1,#0x0]	; 0230D3A8
	b loc_0230D3D6	; 0230D3AA
loc_0230D3AC:
	ldrh r1,[r5,#0x18]	; 0230D3AC
	mov r0,#0x1	; 0230D3AE
	and r1,r0	; 0230D3B0
	cmp r1,#0x0	; 0230D3B2
	beq loc_0230D3C2	; 0230D3B4
	add r1,r4,#0x0	; 0230D3B6
	add r1,#0x14	; 0230D3B8
	ldr r0,[r1,#0x0]	; 0230D3BA
	add r0,r0,#0x1	; 0230D3BC
	str r0,[r1,#0x0]	; 0230D3BE
	b loc_0230D3D6	; 0230D3C0
loc_0230D3C2:
	add r1,r4,#0x0	; 0230D3C2
	add r1,#0x10	; 0230D3C4
	ldr r0,[r1,#0x0]	; 0230D3C6
	add r0,r0,#0x1	; 0230D3C8
	str r0,[r1,#0x0]	; 0230D3CA
	b loc_0230D3D6	; 0230D3CC
loc_0230D3CE:
	add r1,r4,#0x4	; 0230D3CE
	ldr r0,[r1,#0x0]	; 0230D3D0
	add r0,r0,#0x1	; 0230D3D2
	str r0,[r1,#0x0]	; 0230D3D4
loc_0230D3D6:
	ldrh r0,[r5,#0x14]	; 0230D3D6
	lsl r0,r0,#0x11	; 0230D3D8
	lsr r0,r0,#0x1f	; 0230D3DA
	cmp r0,#0x0	; 0230D3DC
	beq loc_0230D3E8	; 0230D3DE
	add r4,#0x18	; 0230D3E0
	ldr r0,[r4,#0x0]	; 0230D3E2
	add r0,r0,#0x1	; 0230D3E4
	str r0,[r4,#0x0]	; 0230D3E6
loc_0230D3E8:
	ldr r0,[pool_0230D4A0]	; 0230D3E8
	ldr r1,[r0,#0x0]	; 0230D3EA
	ldr r0,[pool_0230D4A8]	; 0230D3EC
	add r0,r1,r0	; 0230D3EE
	add r1,r7,#0x0	; 0230D3F0
	bl loc_0230B1B0	; 0230D3F2
	mov r2,#0x0	; 0230D3F6
	ldr r3,[pool_0230D4A0]	; 0230D3F8
	ldr r1,[r3,#0x0]	; 0230D3FA
	ldr r0,[pool_0230D4AC]	; 0230D3FC
	strh r2,[r1,r0]	; 0230D3FE
	ldrh r2,[r5,#0x2]	; 0230D400
	ldr r1,[r3,#0x0]	; 0230D402
	ldr r0,[pool_0230D4B0]	; 0230D404
	ldrh r3,[r1,r0]	; 0230D406
	asr r3,r2	; 0230D408
	mov r0,#0x1	; 0230D40A
	and r3,r0	; 0230D40C
	cmp r3,#0x0	; 0230D40E
	beq loc_0230D438	; 0230D410
	ldrh r4,[r5,#0x14]	; 0230D412
	ldr r3,[pool_0230D4B4]	; 0230D414
	and r4,r3	; 0230D416
	cmp r4,#0x0	; 0230D418
	bne loc_0230D438	; 0230D41A
	ldr r3,[pool_0230D4B8]	; 0230D41C
	ldr r5,[r1,r3]	; 0230D41E
	mov r3,#0x1c	; 0230D420
	add r4,r2,#0x0	; 0230D422
	mul r4,r3	; 0230D424
	ldrh r3,[r5,r4]	; 0230D426
	cmp r3,#0x40	; 0230D428
	bne loc_0230D438	; 0230D42A
	ldr r3,[pool_0230D4BC]	; 0230D42C
	add r3,r1,r3	; 0230D42E
	ldrh r1,[r3,#0x0]	; 0230D430
	lsl r0,r2	; 0230D432
	bic r1,r0	; 0230D434
	strh r1,[r3,#0x0]	; 0230D436
loc_0230D438:
	cmp r6,#0x0	; 0230D438
	beq loc_0230D496	; 0230D43A
	ldr r0,[pool_0230D4A0]	; 0230D43C
	ldr r0,[r0,#0x0]	; 0230D43E
	ldr r1,[pool_0230D4C0]	; 0230D440
	ldrh r1,[r0,r1]	; 0230D442
	cmp r1,#0x0	; 0230D444
	beq loc_0230D450	; 0230D446
	mov r0,#0x0	; 0230D448
	bl loc_0230D674	; 0230D44A
	b loc_0230D496	; 0230D44E
loc_0230D450:
	ldr r1,[pool_0230D4C4]	; 0230D450
	ldrh r2,[r0,r1]	; 0230D452
	ldr r1,[pool_0230D4C8]	; 0230D454
	add r1,r2,r1	; 0230D456
	lsl r1,r1,#0x10	; 0230D458
	lsr r1,r1,#0x10	; 0230D45A
	cmp r1,#0x1	; 0230D45C
	bhi loc_0230D496	; 0230D45E
	ldr r1,[pool_0230D4CC]	; 0230D460
	ldrh r1,[r0,r1]	; 0230D462
	cmp r1,#0x40	; 0230D464
	bne loc_0230D496	; 0230D466
	ldr r1,[pool_0230D4D0]	; 0230D468
	ldrh r1,[r0,r1]	; 0230D46A
	lsl r1,r1,#0x1f	; 0230D46C
	lsr r1,r1,#0x1f	; 0230D46E
	cmp r1,#0x0	; 0230D470
	beq loc_0230D496	; 0230D472
	ldr r1,[pool_0230D4B8]	; 0230D474
	ldr r3,[r0,r1]	; 0230D476
	ldr r1,[pool_0230D4D4]	; 0230D478
	ldrh r2,[r0,r1]	; 0230D47A
	mov r1,#0x1c	; 0230D47C
	mul r2,r1	; 0230D47E
	add r1,r3,r2	; 0230D480
	ldrh r1,[r1,#0x16]	; 0230D482
	cmp r1,#0x0	; 0230D484
	bne loc_0230D496	; 0230D486
	ldr r1,[pool_0230D4D8]	; 0230D488
	ldrh r0,[r0,r1]	; 0230D48A
	cmp r0,#0x0	; 0230D48C
	bne loc_0230D496	; 0230D48E
	mov r0,#0x1	; 0230D490
	bl loc_02306814	; 0230D492
loc_0230D496:
	add sp,#0x4	; 0230D496
	pop {r4,r5,r6,r7}	; 0230D498
	pop {r3}	; 0230D49A
	bx r3	; 0230D49C
	.byte 0xC0, 0x46	; 0230D4A0
pool_0230D4A0:
loc_0230D4A0:
	.word FirmwareWlWorkPointerSlot	; 0230D4A0
pool_0230D4A4:
loc_0230D4A4:
	.word 0x000004F4	; 0230D4A4
pool_0230D4A8:
loc_0230D4A8:
	.word 0x00000158	; 0230D4A8
pool_0230D4AC:
loc_0230D4AC:
	.word 0x000003E4	; 0230D4AC
pool_0230D4B0:
loc_0230D4B0:
	.word 0x000004EA	; 0230D4B0
pool_0230D4B4:
loc_0230D4B4:
	.word 0x00002000	; 0230D4B4
pool_0230D4B8:
loc_0230D4B8:
	.word 0x000002E0	; 0230D4B8
pool_0230D4BC:
loc_0230D4BC:
	.word 0x000004EC	; 0230D4BC
pool_0230D4C0:
loc_0230D4C0:
	.word 0x00000160	; 0230D4C0
pool_0230D4C4:
loc_0230D4C4:
	.word 0x00000314	; 0230D4C4
pool_0230D4C8:
loc_0230D4C8:
	.word 0x0000FFFE	; 0230D4C8
pool_0230D4CC:
loc_0230D4CC:
	.word 0x00000310	; 0230D4CC
pool_0230D4D0:
loc_0230D4D0:
	.word 0x00000316	; 0230D4D0
pool_0230D4D4:
loc_0230D4D4:
	.word 0x00000384	; 0230D4D4
pool_0230D4D8:
loc_0230D4D8:
	.word 0x0000038A	; 0230D4D8

; ===== function loc_0230D4DC =====
loc_0230D4DC:
	push {r4,r5,lr}	; 0230D4DC
	sub sp,#0x4	; 0230D4DE
	add r5,r0,#0x0	; 0230D4E0
	add r4,r1,#0x0	; 0230D4E2
	add r4,#0x10	; 0230D4E4
	ldrh r3,[r4,#0x14]	; 0230D4E6
	ldr r2,[pool_0230D5A8]	; 0230D4E8
	and r3,r2	; 0230D4EA
	cmp r3,#0x0	; 0230D4EC
	beq loc_0230D558	; 0230D4EE
	ldrh r2,[r1,#0xc]	; 0230D4F0
	ldr r1,[pool_0230D5AC]	; 0230D4F2
	cmp r2,r1	; 0230D4F4
	bne loc_0230D508	; 0230D4F6
	add r1,r4,#0x0	; 0230D4F8
	add r1,#0x8	; 0230D4FA
	add r2,r4,#0x0	; 0230D4FC
	add r2,#0x2c	; 0230D4FE
	ldrh r3,[r4,#0x6]	; 0230D500
	bl loc_0230540C	; 0230D502
	b loc_0230D514	; 0230D506
loc_0230D508:
	add r1,r4,#0x0	; 0230D508
	add r1,#0x8	; 0230D50A
	ldr r2,[r4,#0x2c]	; 0230D50C
	ldrh r3,[r4,#0x6]	; 0230D50E
	bl loc_0230540C	; 0230D510
loc_0230D514:
	ldr r2,[pool_0230D5B0]	; 0230D514
	ldrh r1,[r2,#0x0]	; 0230D516
	ldrh r0,[r2,#0x0]	; 0230D518
	lsl r0,r0,#0x8	; 0230D51A
	add r0,r1,r0	; 0230D51C
	strh r0,[r5,#0x24]	; 0230D51E
	ldrh r0,[r2,#0x0]	; 0230D520
	mov r1,#0xff	; 0230D522
	and r0,r1	; 0230D524
	ldr r3,[pool_0230D5B4]	; 0230D526
	ldr r2,[r3,#0x0]	; 0230D528
	ldr r1,[pool_0230D5B8]	; 0230D52A
	ldrh r1,[r2,r1]	; 0230D52C
	lsl r1,r1,#0xe	; 0230D52E
	orr r0,r1	; 0230D530
	strh r0,[r5,#0x26]	; 0230D532
	ldr r1,[r3,#0x0]	; 0230D534
	ldr r0,[pool_0230D5BC]	; 0230D536
	ldrh r1,[r1,r0]	; 0230D538
	mov r0,#0x8	; 0230D53A
	and r1,r0	; 0230D53C
	cmp r1,#0x0	; 0230D53E
	beq loc_0230D57A	; 0230D540
	add r1,r5,#0x0	; 0230D542
	add r1,#0xc	; 0230D544
	ldrh r0,[r4,#0x12]	; 0230D546
	add r0,r1,r0	; 0230D548
	sub r1,r0,#0x7	; 0230D54A
	mov r0,#0x1	; 0230D54C
	bic r1,r0	; 0230D54E
	mov r0,#0x0	; 0230D550
	strh r0,[r1,#0x0]	; 0230D552
	strh r0,[r1,#0x2]	; 0230D554
	b loc_0230D57A	; 0230D556
loc_0230D558:
	ldrh r2,[r1,#0xc]	; 0230D558
	ldr r1,[pool_0230D5AC]	; 0230D55A
	cmp r2,r1	; 0230D55C
	bne loc_0230D56E	; 0230D55E
	add r1,r4,#0x0	; 0230D560
	add r1,#0x8	; 0230D562
	ldrh r2,[r4,#0x6]	; 0230D564
	add r2,#0x24	; 0230D566
	bl loc_0230545C	; 0230D568
	b loc_0230D57A	; 0230D56C
loc_0230D56E:
	add r1,r4,#0x0	; 0230D56E
	add r1,#0x8	; 0230D570
	ldr r2,[r4,#0x2c]	; 0230D572
	ldrh r3,[r4,#0x6]	; 0230D574
	bl loc_02305434	; 0230D576
loc_0230D57A:
	ldr r0,[pool_0230D5B4]	; 0230D57A
	ldr r1,[r0,#0x0]	; 0230D57C
	ldr r0,[pool_0230D5BC]	; 0230D57E
	ldrh r1,[r1,r0]	; 0230D580
	mov r0,#0x4	; 0230D582
	and r1,r0	; 0230D584
	cmp r1,#0x0	; 0230D586
	beq loc_0230D59E	; 0230D588
	add r5,#0xc	; 0230D58A
	ldrh r0,[r4,#0x12]	; 0230D58C
	add r0,r5,r0	; 0230D58E
	sub r1,r0,#0x1	; 0230D590
	mov r0,#0x3	; 0230D592
	bic r1,r0	; 0230D594
	ldr r0,[pool_0230D5C0]	; 0230D596
	strh r0,[r1,#0x0]	; 0230D598
	ldr r0,[pool_0230D5C4]	; 0230D59A
	strh r0,[r1,#0x2]	; 0230D59C
loc_0230D59E:
	add sp,#0x4	; 0230D59E
	pop {r4,r5}	; 0230D5A0
	pop {r3}	; 0230D5A2
	bx r3	; 0230D5A4
	.byte 0xC0, 0x46	; 0230D5A8
pool_0230D5A8:
loc_0230D5A8:
	.word 0x00004000	; 0230D5A8
pool_0230D5AC:
loc_0230D5AC:
	.word 0x0000FFFF	; 0230D5AC
pool_0230D5B0:
loc_0230D5B0:
	.word REG_WIFI_RANDOM	; 0230D5B0
pool_0230D5B4:
loc_0230D5B4:
	.word FirmwareWlWorkPointerSlot	; 0230D5B4
pool_0230D5B8:
loc_0230D5B8:
	.word 0x000002FA	; 0230D5B8
pool_0230D5BC:
loc_0230D5BC:
	.word 0x0000061C	; 0230D5BC
pool_0230D5C0:
loc_0230D5C0:
	.word 0x0000B6B8	; 0230D5C0
pool_0230D5C4:
loc_0230D5C4:
	.word 0x00001D46	; 0230D5C4

; ===== function loc_0230D5C8 =====
loc_0230D5C8:
	push {r4,r5,r6,lr}	; 0230D5C8
	ldr r0,[pool_0230D644]	; 0230D5CA
	ldr r1,[r0,#0x0]	; 0230D5CC
	ldr r0,[pool_0230D648]	; 0230D5CE
	ldrh r4,[r1,r0]	; 0230D5D0
	cmp r4,#0x0	; 0230D5D2
	beq loc_0230D63E	; 0230D5D4
	ldr r0,[pool_0230D64C]	; 0230D5D6
	bl loc_02304B4C	; 0230D5D8
	add r6,r0,#0x0	; 0230D5DC
	ldr r1,[pool_0230D644]	; 0230D5DE
	ldr r3,[r1,#0x0]	; 0230D5E0
	ldr r2,[pool_0230D650]	; 0230D5E2
	add r2,r3,r2	; 0230D5E4
	ldrh r3,[r2,#0x0]	; 0230D5E6
	cmp r3,#0x0	; 0230D5E8
	beq loc_0230D5F2	; 0230D5EA
	bl loc_02304B5C	; 0230D5EC
	b loc_0230D63E	; 0230D5F0
loc_0230D5F2:
	mov r0,#0x1	; 0230D5F2
	strh r0,[r2,#0x0]	; 0230D5F4
	ldr r2,[r1,#0x0]	; 0230D5F6
	ldr r0,[pool_0230D654]	; 0230D5F8
	add r2,r2,r0	; 0230D5FA
	ldrh r0,[r2,#0x0]	; 0230D5FC
	add r0,r0,#0x1	; 0230D5FE
	strh r0,[r2,#0x0]	; 0230D600
	ldr r0,[r1,#0x0]	; 0230D602
	ldr r1,[pool_0230D658]	; 0230D604
	ldr r1,[r0,r1]	; 0230D606
	ldr r2,[pool_0230D65C]	; 0230D608
	ldr r5,[r0,r2]	; 0230D60A
	add r3,r1,#0x0	; 0230D60C
	add r3,#0x10	; 0230D60E
	ldr r2,[pool_0230D660]	; 0230D610
	str r3,[r0,r2]	; 0230D612
	add r0,r5,#0x0	; 0230D614
	bl loc_0230D4DC	; 0230D616
	cmp r4,#0x1	; 0230D61A
	bls loc_0230D62A	; 0230D61C
	add r2,r5,#0x0	; 0230D61E
	add r2,#0xc	; 0230D620
	ldrh r1,[r2,#0x0]	; 0230D622
	ldr r0,[pool_0230D664]	; 0230D624
	orr r1,r0	; 0230D626
	strh r1,[r2,#0x0]	; 0230D628
loc_0230D62A:
	ldr r0,[pool_0230D668]	; 0230D62A
	and r5,r0	; 0230D62C
	lsr r1,r5,#0x1	; 0230D62E
	ldr r0,[pool_0230D66C]	; 0230D630
	orr r1,r0	; 0230D632
	ldr r0,[pool_0230D670]	; 0230D634
	strh r1,[r0,#0x0]	; 0230D636
	add r0,r6,#0x0	; 0230D638
	bl loc_02304B5C	; 0230D63A
loc_0230D63E:
	pop {r4,r5,r6}	; 0230D63E
	pop {r3}	; 0230D640
	bx r3	; 0230D642
pool_0230D644:
loc_0230D644:
	.word FirmwareWlWorkPointerSlot	; 0230D644
pool_0230D648:
loc_0230D648:
	.word 0x00000178	; 0230D648
pool_0230D64C:
loc_0230D64C:
	.word 0x01000000	; 0230D64C
pool_0230D650:
loc_0230D650:
	.word 0x0000040C	; 0230D650
pool_0230D654:
loc_0230D654:
	.word 0x0000040E	; 0230D654
pool_0230D658:
loc_0230D658:
	.word 0x00000170	; 0230D658
pool_0230D65C:
loc_0230D65C:
	.word 0x00000414	; 0230D65C
pool_0230D660:
loc_0230D660:
	.word 0x00000418	; 0230D660
pool_0230D664:
loc_0230D664:
	.word 0x00002000	; 0230D664
pool_0230D668:
loc_0230D668:
	.word 0x00003FFF	; 0230D668
pool_0230D66C:
loc_0230D66C:
	.word 0x00008000	; 0230D66C
pool_0230D670:
loc_0230D670:
	.word REG_WIFI_TXBUF_LOC3	; 0230D670

; ===== function loc_0230D674 =====
loc_0230D674:
	push {r4,r5,r6,r7,lr}	; 0230D674
	sub sp,#0xc	; 0230D676
	add r6,r0,#0x0	; 0230D678
	mov r0,#0xc	; 0230D67A
	add r4,r6,#0x0	; 0230D67C
	mul r4,r0	; 0230D67E
	ldr r0,[pool_0230D820]	; 0230D680
	ldr r0,[r0,#0x0]	; 0230D682
	add r1,r0,r4	; 0230D684
	ldr r0,[pool_0230D824]	; 0230D686
	ldrh r0,[r1,r0]	; 0230D688
	cmp r0,#0x0	; 0230D68A
	bne loc_0230D690	; 0230D68C
	b loc_0230D816	; 0230D68E
loc_0230D690:
	ldr r0,[pool_0230D828]	; 0230D690
	bl loc_02304B4C	; 0230D692
	str r0,[sp,#0x8]	; 0230D696
	mov r1,#0x14	; 0230D698
	add r5,r6,#0x0	; 0230D69A
	mul r5,r1	; 0230D69C
	ldr r1,[pool_0230D820]	; 0230D69E
	ldr r1,[r1,#0x0]	; 0230D6A0
	add r3,r1,r5	; 0230D6A2
	ldr r2,[pool_0230D82C]	; 0230D6A4
	ldrh r2,[r3,r2]	; 0230D6A6
	cmp r2,#0x0	; 0230D6A8
	beq loc_0230D6B2	; 0230D6AA
	bl loc_02304B5C	; 0230D6AC
	b loc_0230D816	; 0230D6B0
loc_0230D6B2:
	add r1,r1,r4	; 0230D6B2
	ldr r0,[pool_0230D830]	; 0230D6B4
	ldr r0,[r1,r0]	; 0230D6B6
	str r0,[sp,#0x4]	; 0230D6B8
loc_0230D6BA:
	mov r0,#0x0	; 0230D6BA
	mvn r1,r0	; 0230D6BC
	ldr r0,[sp,#0x4]	; 0230D6BE
	cmp r0,r1	; 0230D6C0
	bne loc_0230D6CC	; 0230D6C2
	ldr r0,[sp,#0x8]	; 0230D6C4
	bl loc_02304B5C	; 0230D6C6
	b loc_0230D816	; 0230D6CA
loc_0230D6CC:
	str r0,[sp,#0x0]	; 0230D6CC
	bl loc_02304E60	; 0230D6CE
	str r0,[sp,#0x4]	; 0230D6D2
	ldr r4,[sp,#0x0]	; 0230D6D4
	add r4,#0x10	; 0230D6D6
	ldrh r7,[r4,#0x2]	; 0230D6D8
	ldr r0,[pool_0230D820]	; 0230D6DA
	ldr r2,[r0,#0x0]	; 0230D6DC
	ldr r0,[pool_0230D834]	; 0230D6DE
	ldr r1,[r2,r0]	; 0230D6E0
	ldrh r0,[r4,#0x4]	; 0230D6E2
	sub r0,r1,r0	; 0230D6E4
	lsl r0,r0,#0x10	; 0230D6E6
	lsr r0,r0,#0x10	; 0230D6E8
	ldr r1,[pool_0230D838]	; 0230D6EA
	ldrh r1,[r2,r1]	; 0230D6EC
	cmp r0,r1	; 0230D6EE
	bls loc_0230D71A	; 0230D6F0
	ldr r0,[pool_0230D82C]	; 0230D6F2
	add r0,r2,r0	; 0230D6F4
	add r3,r0,r5	; 0230D6F6
	ldr r0,[pool_0230D83C]	; 0230D6F8
	add r1,r2,r0	; 0230D6FA
	ldrh r0,[r1,#0x0]	; 0230D6FC
	add r0,r0,#0x1	; 0230D6FE
	strh r0,[r1,#0x0]	; 0230D700
	mov r0,#0x2	; 0230D702
	strh r0,[r4,#0x8]	; 0230D704
	add r1,r3,#0x4	; 0230D706
	ldrh r0,[r1,#0x0]	; 0230D708
	add r0,r0,#0x1	; 0230D70A
	strh r0,[r1,#0x0]	; 0230D70C
	add r0,r4,#0x0	; 0230D70E
	mov r1,#0x0	; 0230D710
	ldr r2,[r3,#0x10]	; 0230D712
	bl loc_02308C88	; 0230D714
	b loc_0230D6BA	; 0230D718
loc_0230D71A:
	cmp r6,#0x0	; 0230D71A
	bne loc_0230D758	; 0230D71C
	ldr r0,[pool_0230D840]	; 0230D71E
	ldrh r1,[r2,r0]	; 0230D720
	asr r1,r7	; 0230D722
	mov r0,#0x1	; 0230D724
	and r1,r0	; 0230D726
	cmp r1,#0x0	; 0230D728
	beq loc_0230D6BA	; 0230D72A
	ldr r0,[pool_0230D844]	; 0230D72C
	ldr r1,[r2,r0]	; 0230D72E
	add r3,r7,#0x0	; 0230D730
	mov r0,#0x1c	; 0230D732
	mul r3,r0	; 0230D734
	ldrh r0,[r1,r3]	; 0230D736
	cmp r0,#0x40	; 0230D738
	beq loc_0230D758	; 0230D73A
	mov r0,#0x2	; 0230D73C
	strh r0,[r4,#0x8]	; 0230D73E
	ldr r0,[pool_0230D820]	; 0230D740
	ldr r1,[r0,#0x0]	; 0230D742
	ldr r0,[pool_0230D830]	; 0230D744
	add r0,r1,r0	; 0230D746
	add r1,r4,#0x0	; 0230D748
	sub r1,#0x10	; 0230D74A
	bl loc_0230B1B0	; 0230D74C
	add r0,r4,#0x0	; 0230D750
	bl loc_023092BC	; 0230D752
	b loc_0230D6BA	; 0230D756
loc_0230D758:
	mov r0,#0x1	; 0230D758
	add r2,r2,r5	; 0230D75A
	ldr r1,[pool_0230D82C]	; 0230D75C
	strh r0,[r2,r1]	; 0230D75E
	ldr r0,[pool_0230D820]	; 0230D760
	ldr r1,[r0,#0x0]	; 0230D762
	add r2,r1,r5	; 0230D764
	ldr r1,[pool_0230D848]	; 0230D766
	add r1,r2,r1	; 0230D768
	ldrh r2,[r1,#0x0]	; 0230D76A
	add r2,r2,#0x1	; 0230D76C
	strh r2,[r1,#0x0]	; 0230D76E
	ldr r1,[r0,#0x0]	; 0230D770
	add r2,r1,r5	; 0230D772
	ldr r1,[pool_0230D84C]	; 0230D774
	str r4,[r2,r1]	; 0230D776
	ldr r0,[r0,#0x0]	; 0230D778
	add r2,r0,r5	; 0230D77A
	ldr r1,[pool_0230D850]	; 0230D77C
	ldr r5,[r2,r1]	; 0230D77E
	ldr r1,[pool_0230D854]	; 0230D780
	ldrh r0,[r0,r1]	; 0230D782
	lsl r0,r0,#0x1e	; 0230D784
	lsr r0,r0,#0x1f	; 0230D786
	cmp r0,#0x1	; 0230D788
	bne loc_0230D792	; 0230D78A
	mov r0,#0x2	; 0230D78C
	bl loc_02306814	; 0230D78E
loc_0230D792:
	add r0,r5,#0x0	; 0230D792
	ldr r1,[sp,#0x0]	; 0230D794
	bl loc_0230D4DC	; 0230D796
	ldr r0,[pool_0230D820]	; 0230D79A
	ldr r0,[r0,#0x0]	; 0230D79C
	ldr r1,[pool_0230D858]	; 0230D79E
	ldrh r1,[r0,r1]	; 0230D7A0
	cmp r1,#0x1	; 0230D7A2
	bne loc_0230D7C2	; 0230D7A4
	ldr r1,[pool_0230D844]	; 0230D7A6
	ldr r1,[r0,r1]	; 0230D7A8
	mov r0,#0x1c	; 0230D7AA
	mul r7,r0	; 0230D7AC
	add r0,r1,r7	; 0230D7AE
	ldrh r0,[r0,#0x16]	; 0230D7B0
	cmp r0,#0x1	; 0230D7B2
	bls loc_0230D7C2	; 0230D7B4
	add r2,r5,#0x0	; 0230D7B6
	add r2,#0xc	; 0230D7B8
	ldrh r1,[r2,#0x0]	; 0230D7BA
	ldr r0,[pool_0230D85C]	; 0230D7BC
	orr r1,r0	; 0230D7BE
	strh r1,[r2,#0x0]	; 0230D7C0
loc_0230D7C2:
	ldrh r2,[r4,#0x14]	; 0230D7C2
	mov r0,#0xc	; 0230D7C4
	add r1,r2,#0x0	; 0230D7C6
	and r1,r0	; 0230D7C8
	cmp r1,#0x4	; 0230D7CA
	bne loc_0230D7E2	; 0230D7CC
	ldr r0,[pool_0230D860]	; 0230D7CE
	and r5,r0	; 0230D7D0
	lsl r0,r5,#0xf	; 0230D7D2
	lsr r2,r0,#0x10	; 0230D7D4
	ldr r0,[pool_0230D864]	; 0230D7D6
	orr r2,r0	; 0230D7D8
	lsl r1,r6,#0x2	; 0230D7DA
	ldr r0,[pool_0230D868]	; 0230D7DC
	strh r2,[r1,r0]	; 0230D7DE
	b loc_0230D810	; 0230D7E0
loc_0230D7E2:
	mov r0,#0xfc	; 0230D7E2
	and r2,r0	; 0230D7E4
	cmp r2,#0x50	; 0230D7E6
	bne loc_0230D7FE	; 0230D7E8
	ldr r0,[pool_0230D860]	; 0230D7EA
	and r5,r0	; 0230D7EC
	lsl r0,r5,#0xf	; 0230D7EE
	lsr r2,r0,#0x10	; 0230D7F0
	ldr r0,[pool_0230D86C]	; 0230D7F2
	orr r2,r0	; 0230D7F4
	lsl r1,r6,#0x2	; 0230D7F6
	ldr r0,[pool_0230D868]	; 0230D7F8
	strh r2,[r1,r0]	; 0230D7FA
	b loc_0230D810	; 0230D7FC
loc_0230D7FE:
	ldr r0,[pool_0230D860]	; 0230D7FE
	and r5,r0	; 0230D800
	lsl r0,r5,#0xf	; 0230D802
	lsr r2,r0,#0x10	; 0230D804
	ldr r0,[pool_0230D870]	; 0230D806
	orr r2,r0	; 0230D808
	lsl r1,r6,#0x2	; 0230D80A
	ldr r0,[pool_0230D868]	; 0230D80C
	strh r2,[r1,r0]	; 0230D80E
loc_0230D810:
	ldr r0,[sp,#0x8]	; 0230D810
	bl loc_02304B5C	; 0230D812
loc_0230D816:
	add sp,#0xc	; 0230D816
	pop {r4,r5,r6,r7}	; 0230D818
	pop {r3}	; 0230D81A
	bx r3	; 0230D81C
	.byte 0xC0, 0x46	; 0230D820
pool_0230D820:
loc_0230D820:
	.word FirmwareWlWorkPointerSlot	; 0230D820
pool_0230D824:
loc_0230D824:
	.word 0x00000160	; 0230D824
pool_0230D828:
loc_0230D828:
	.word 0x01000000	; 0230D828
pool_0230D82C:
loc_0230D82C:
	.word 0x000003E4	; 0230D82C
pool_0230D830:
loc_0230D830:
	.word 0x00000158	; 0230D830
pool_0230D834:
loc_0230D834:
	.word 0x000003A4	; 0230D834
pool_0230D838:
loc_0230D838:
	.word 0x00000388	; 0230D838
pool_0230D83C:
loc_0230D83C:
	.word 0x00000494	; 0230D83C
pool_0230D840:
loc_0230D840:
	.word 0x000004EC	; 0230D840
pool_0230D844:
loc_0230D844:
	.word 0x000002E0	; 0230D844
pool_0230D848:
loc_0230D848:
	.word 0x000003E6	; 0230D848
pool_0230D84C:
loc_0230D84C:
	.word 0x000003F0	; 0230D84C
pool_0230D850:
loc_0230D850:
	.word 0x000003EC	; 0230D850
pool_0230D854:
loc_0230D854:
	.word 0x00000316	; 0230D854
pool_0230D858:
loc_0230D858:
	.word 0x00000314	; 0230D858
pool_0230D85C:
loc_0230D85C:
	.word 0x00002000	; 0230D85C
pool_0230D860:
loc_0230D860:
	.word 0x00003FFF	; 0230D860
pool_0230D864:
loc_0230D864:
	.word 0x0000A000	; 0230D864
pool_0230D868:
loc_0230D868:
	.word REG_WIFI_TXBUF_LOC1	; 0230D868
pool_0230D86C:
loc_0230D86C:
	.word 0x00009000	; 0230D86C
pool_0230D870:
loc_0230D870:
	.word 0x00008000	; 0230D870

; ===== function loc_0230D874 =====
loc_0230D874:
	push {lr}	; 0230D874
	sub sp,#0x4	; 0230D876
	mov r0,#0x0	; 0230D878
	str r0,[sp,#0x0]	; 0230D87A
	ldr r0,[sp,#0x0]	; 0230D87C
	ldr r1,[pool_0230D948]	; 0230D87E
	ldr r2,[r1,#0x0]	; 0230D880
	ldr r1,[pool_0230D94C]	; 0230D882
	add r1,r2,r1	; 0230D884
	mov r2,#0x50	; 0230D886
	bl loc_0230D9B0	; 0230D888
	ldr r1,[pool_0230D950]	; 0230D88C
	ldr r0,[pool_0230D954]	; 0230D88E
	strh r1,[r0,#0x0]	; 0230D890
	ldr r0,[pool_0230D948]	; 0230D892
	ldr r2,[r0,#0x0]	; 0230D894
	ldr r1,[pool_0230D958]	; 0230D896
	ldrh r1,[r2,r1]	; 0230D898
	cmp r1,#0x3	; 0230D89A
	bhi loc_0230D90A	; 0230D89C
	add r1,r1,r1	; 0230D89E
P4_SwitchIndexPC_0230D89E:
	add r1,pc	; 0230D8A0
	ldrh r1,[r1,#(P4_SwitchTable_0230D89E - (P4_SwitchIndexPC_0230D89E + 4))]	; 0230D8A2
	lsl r1,r1,#0x10	; 0230D8A4
	asr r1,r1,#0x10	; 0230D8A6
P4_SwitchTargetPC_0230D89E:
	add r1,pc	; 0230D8A8
	bx r1	; 0230D8AA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230D89E:
	.halfword (loc_0230D8B4 + 1) - (P4_SwitchTargetPC_0230D89E + 4)
	.halfword (loc_0230D8CA + 1) - (P4_SwitchTargetPC_0230D89E + 4)
	.halfword (loc_0230D8E0 + 1) - (P4_SwitchTargetPC_0230D89E + 4)
	.halfword (loc_0230D8F6 + 1) - (P4_SwitchTargetPC_0230D89E + 4)
P4_SwitchTable_0230D89EEnd:
loc_0230D8B4:
	ldr r2,[pool_0230D95C]	; 0230D8B4
	ldr r1,[pool_0230D960]	; 0230D8B6
	strh r2,[r1,#0x0]	; 0230D8B8
	ldr r2,[pool_0230D964]	; 0230D8BA
	ldr r1,[pool_0230D968]	; 0230D8BC
	strh r2,[r1,#0x0]	; 0230D8BE
	ldr r2,[pool_0230D96C]	; 0230D8C0
	ldr r1,[r0,#0x0]	; 0230D8C2
	ldr r0,[pool_0230D970]	; 0230D8C4
	strh r2,[r1,r0]	; 0230D8C6
	b loc_0230D90A	; 0230D8C8
loc_0230D8CA:
	ldr r2,[pool_0230D974]	; 0230D8CA
	ldr r1,[pool_0230D960]	; 0230D8CC
	strh r2,[r1,#0x0]	; 0230D8CE
	ldr r2,[pool_0230D978]	; 0230D8D0
	ldr r1,[pool_0230D968]	; 0230D8D2
	strh r2,[r1,#0x0]	; 0230D8D4
	ldr r2,[pool_0230D97C]	; 0230D8D6
	ldr r1,[r0,#0x0]	; 0230D8D8
	ldr r0,[pool_0230D970]	; 0230D8DA
	strh r2,[r1,r0]	; 0230D8DC
	b loc_0230D90A	; 0230D8DE
loc_0230D8E0:
	ldr r2,[pool_0230D980]	; 0230D8E0
	ldr r1,[pool_0230D960]	; 0230D8E2
	strh r2,[r1,#0x0]	; 0230D8E4
	ldr r2,[pool_0230D984]	; 0230D8E6
	ldr r1,[pool_0230D968]	; 0230D8E8
	strh r2,[r1,#0x0]	; 0230D8EA
	ldr r2,[pool_0230D988]	; 0230D8EC
	ldr r1,[r0,#0x0]	; 0230D8EE
	ldr r0,[pool_0230D970]	; 0230D8F0
	strh r2,[r1,r0]	; 0230D8F2
	b loc_0230D90A	; 0230D8F4
loc_0230D8F6:
	ldr r2,[pool_0230D95C]	; 0230D8F6
	ldr r1,[pool_0230D960]	; 0230D8F8
	strh r2,[r1,#0x0]	; 0230D8FA
	ldr r2,[pool_0230D964]	; 0230D8FC
	ldr r1,[pool_0230D968]	; 0230D8FE
	strh r2,[r1,#0x0]	; 0230D900
	ldr r2,[pool_0230D96C]	; 0230D902
	ldr r1,[r0,#0x0]	; 0230D904
	ldr r0,[pool_0230D970]	; 0230D906
	strh r2,[r1,r0]	; 0230D908
loc_0230D90A:
	ldr r1,[pool_0230D98C]	; 0230D90A
	ldr r0,[pool_0230D990]	; 0230D90C
	strh r1,[r0,#0x0]	; 0230D90E
	ldr r0,[pool_0230D960]	; 0230D910
	ldrh r0,[r0,#0x0]	; 0230D912
	ldr r1,[pool_0230D994]	; 0230D914
	and r0,r1	; 0230D916
	mov r1,#0x2	; 0230D918
	bl loc_0230D9BC	; 0230D91A
	ldr r1,[pool_0230D998]	; 0230D91E
	strh r0,[r1,#0x0]	; 0230D920
	ldrh r2,[r1,#0x0]	; 0230D922
	ldr r3,[pool_0230D948]	; 0230D924
	ldr r1,[r3,#0x0]	; 0230D926
	ldr r0,[pool_0230D99C]	; 0230D928
	strh r2,[r1,r0]	; 0230D92A
	ldr r1,[pool_0230D9A0]	; 0230D92C
	ldr r0,[pool_0230D9A4]	; 0230D92E
	strh r1,[r0,#0x0]	; 0230D930
	ldr r1,[pool_0230D9A8]	; 0230D932
	ldr r0,[pool_0230D954]	; 0230D934
	strh r1,[r0,#0x0]	; 0230D936
	ldr r2,[pool_0230D9AC]	; 0230D938
	ldr r1,[r3,#0x0]	; 0230D93A
	ldr r0,[pool_0230D94C]	; 0230D93C
	strh r2,[r1,r0]	; 0230D93E
	add sp,#0x4	; 0230D940
	pop {r3}	; 0230D942
	bx r3	; 0230D944
	.byte 0xC0, 0x46	; 0230D948
pool_0230D948:
loc_0230D948:
	.word FirmwareWlWorkPointerSlot	; 0230D948
pool_0230D94C:
loc_0230D94C:
	.word 0x00000498	; 0230D94C
pool_0230D950:
loc_0230D950:
	.word 0x00008000	; 0230D950
pool_0230D954:
loc_0230D954:
	.word REG_WIFI_RXCNT	; 0230D954
pool_0230D958:
loc_0230D958:
	.word 0x00000314	; 0230D958
pool_0230D95C:
loc_0230D95C:
	.word 0x00004794	; 0230D95C
pool_0230D960:
loc_0230D960:
	.word REG_WIFI_RXBUF_BEGIN	; 0230D960
pool_0230D964:
loc_0230D964:
	.word 0x000003CA	; 0230D964
pool_0230D968:
loc_0230D968:
	.word REG_WIFI_RXBUF_WR_ADDR	; 0230D968
pool_0230D96C:
loc_0230D96C:
	.word 0x000017CC	; 0230D96C
pool_0230D970:
loc_0230D970:
	.word 0x00000396	; 0230D970
pool_0230D974:
loc_0230D974:
	.word 0x000050C0	; 0230D974
pool_0230D978:
loc_0230D978:
	.word 0x00000860	; 0230D978
pool_0230D97C:
loc_0230D97C:
	.word 0x00000EA0	; 0230D97C
pool_0230D980:
loc_0230D980:
	.word 0x00004BF4	; 0230D980
pool_0230D984:
loc_0230D984:
	.word 0x000005FA	; 0230D984
pool_0230D988:
loc_0230D988:
	.word 0x0000136C	; 0230D988
pool_0230D98C:
loc_0230D98C:
	.word 0x00005F60	; 0230D98C
pool_0230D990:
loc_0230D990:
	.word REG_WIFI_RXBUF_END	; 0230D990
pool_0230D994:
loc_0230D994:
	.word 0x00003FFF	; 0230D994
pool_0230D998:
loc_0230D998:
	.word REG_WIFI_RXBUF_READCSR	; 0230D998
pool_0230D99C:
loc_0230D99C:
	.word 0x0000049C	; 0230D99C
pool_0230D9A0:
loc_0230D9A0:
	.word 0x00005F5E	; 0230D9A0
pool_0230D9A4:
loc_0230D9A4:
	.word REG_WIFI_RXBUF_GAP	; 0230D9A4
pool_0230D9A8:
loc_0230D9A8:
	.word 0x00008001	; 0230D9A8
pool_0230D9AC:
loc_0230D9AC:
	.word 0x0000FFFF	; 0230D9AC

; ===== function loc_0230D9B0 =====
loc_0230D9B0:
	bx pc	; 0230D9B0
	.byte 0xC0, 0x46	; 0230D9B4
.arm

; ===== function loc_0230D9B4 =====
loc_0230D9B4:
	ldr pc,[pool_0230D9B8]	; 0230D9B4
pool_0230D9B8:
loc_0230D9B8:
	.word loc_037FCE38	; 0230D9B8
.thumb

; ===== function loc_0230D9BC =====
loc_0230D9BC:
	bx pc	; 0230D9BC
	.byte 0xC0, 0x46	; 0230D9C0
.arm

; ===== function loc_0230D9C0 =====
loc_0230D9C0:
	ldr pc,[pool_0230D9C4]	; 0230D9C0
pool_0230D9C4:
loc_0230D9C4:
	.word loc_03802514	; 0230D9C4
.thumb

; ===== function loc_0230D9C8 =====
	push {r4,r5,r6,r7,lr}	; 0230D9C8
	sub sp,#0x4	; 0230D9CA
	ldr r6,[pool_0230DA08]	; 0230D9CC
	ldr r1,[r6,#0x0]	; 0230D9CE
	ldr r0,[pool_0230DA0C]	; 0230D9D0
	add r5,r1,r0	; 0230D9D2
	mov r4,#0x0	; 0230D9D4
	mov r7,#0x18	; 0230D9D6
loc_0230D9D8:
	add r0,r4,#0x0	; 0230D9D8
	mul r0,r7	; 0230D9DA
	add r1,r5,r0	; 0230D9DC
	ldrh r0,[r5,r0]	; 0230D9DE
	cmp r0,#0x0	; 0230D9E0
	beq loc_0230D9FA	; 0230D9E2
	sub r0,r0,#0x1	; 0230D9E4
	strh r0,[r1,#0x0]	; 0230D9E6
	ldrh r0,[r1,#0x0]	; 0230D9E8
	cmp r0,#0x0	; 0230D9EA
	bne loc_0230D9FA	; 0230D9EC
	ldr r2,[r6,#0x0]	; 0230D9EE
	ldr r0,[pool_0230DA10]	; 0230D9F0
	add r0,r2,r0	; 0230D9F2
	ldr r1,[r1,#0x14]	; 0230D9F4
	bl loc_02304FFC	; 0230D9F6
loc_0230D9FA:
	add r4,r4,#0x1	; 0230D9FA
	cmp r4,#0x3	; 0230D9FC
	bcc loc_0230D9D8	; 0230D9FE
	add sp,#0x4	; 0230DA00
	pop {r4,r5,r6,r7}	; 0230DA02
	pop {r3}	; 0230DA04
	bx r3	; 0230DA06
pool_0230DA08:
loc_0230DA08:
	.word FirmwareWlWorkPointerSlot	; 0230DA08
pool_0230DA0C:
loc_0230DA0C:
	.word 0x000004A0	; 0230DA0C
pool_0230DA10:
loc_0230DA10:
	.word 0x0000014C	; 0230DA10

; ===== function loc_0230DA14 =====
loc_0230DA14:
	push {r4,r5,r6,r7,lr}	; 0230DA14
	sub sp,#0x14	; 0230DA16
	add r7,r0,#0x0	; 0230DA18
	add r2,r1,#0x0	; 0230DA1A
	ldr r0,[pool_0230DBC0]	; 0230DA1C
	ldr r1,[r0,#0x0]	; 0230DA1E
	ldr r0,[pool_0230DBC4]	; 0230DA20
	add r6,r1,r0	; 0230DA22
	add r1,r7,#0x0	; 0230DA24
	add r1,#0x8	; 0230DA26
	ldrh r0,[r1,#0x0]	; 0230DA28
	sub r0,#0x18	; 0230DA2A
	strh r0,[r1,#0x0]	; 0230DA2C
	mov r4,#0x0	; 0230DA2E
	b loc_0230DAB4	; 0230DA30
loc_0230DA32:
	add r3,r4,#0x0	; 0230DA32
	mov r0,#0x18	; 0230DA34
	mul r3,r0	; 0230DA36
	add r1,r6,r3	; 0230DA38
	ldrh r0,[r6,r3]	; 0230DA3A
	cmp r0,#0x0	; 0230DA3C
	beq loc_0230DAB2	; 0230DA3E
	ldrh r3,[r2,#0x4]	; 0230DA40
	ldrh r0,[r1,#0x8]	; 0230DA42
	cmp r3,r0	; 0230DA44
	bne loc_0230DAB2	; 0230DA46
	ldrh r3,[r2,#0x2]	; 0230DA48
	ldrh r0,[r1,#0x6]	; 0230DA4A
	cmp r3,r0	; 0230DA4C
	bne loc_0230DAB2	; 0230DA4E
	ldrh r3,[r2,#0x0]	; 0230DA50
	ldrh r0,[r1,#0x4]	; 0230DA52
	cmp r3,r0	; 0230DA54
	bne loc_0230DAB2	; 0230DA56
	ldrh r3,[r2,#0xa]	; 0230DA58
	ldrh r0,[r1,#0xe]	; 0230DA5A
	cmp r3,r0	; 0230DA5C
	bne loc_0230DAB2	; 0230DA5E
	ldrh r3,[r2,#0x8]	; 0230DA60
	ldrh r0,[r1,#0xc]	; 0230DA62
	cmp r3,r0	; 0230DA64
	bne loc_0230DAB2	; 0230DA66
	ldrh r3,[r2,#0x6]	; 0230DA68
	ldrh r0,[r1,#0xa]	; 0230DA6A
	cmp r3,r0	; 0230DA6C
	bne loc_0230DAB2	; 0230DA6E
	ldrh r5,[r2,#0xc]	; 0230DA70
	lsl r0,r5,#0x10	; 0230DA72
	lsr r0,r0,#0x14	; 0230DA74
	ldrh r3,[r1,#0x10]	; 0230DA76
	str r3,[sp,#0x10]	; 0230DA78
	lsl r3,r3,#0x10	; 0230DA7A
	lsr r3,r3,#0x14	; 0230DA7C
	cmp r0,r3	; 0230DA7E
	bne loc_0230DAB2	; 0230DA80
	ldr r0,[sp,#0x10]	; 0230DA82
	sub r0,r0,r5	; 0230DA84
	str r0,[sp,#0x4]	; 0230DA86
	ldr r0,[pool_0230DBC8]	; 0230DA88
	ldr r2,[sp,#0x4]	; 0230DA8A
	and r2,r0	; 0230DA8C
	cmp r2,#0x0	; 0230DA8E
	beq loc_0230DA94	; 0230DA90
	b loc_0230DBB8	; 0230DA92
loc_0230DA94:
	ldrh r2,[r1,#0x2]	; 0230DA94
	ldr r1,[sp,#0x4]	; 0230DA96
	str r1,[sp,#0x8]	; 0230DA98
	mul r1,r2	; 0230DA9A
	str r1,[sp,#0x8]	; 0230DA9C
	ldrh r2,[r7,#0x8]	; 0230DA9E
	sub r1,r2,r1	; 0230DAA0
	str r1,[sp,#0xc]	; 0230DAA2
	cmp r1,#0x0	; 0230DAA4
	bne loc_0230DAAA	; 0230DAA6
	b loc_0230DBB8	; 0230DAA8
loc_0230DAAA:
	and r1,r0	; 0230DAAA
	cmp r1,#0x0	; 0230DAAC
	beq loc_0230DAB8	; 0230DAAE
	b loc_0230DBB8	; 0230DAB0
loc_0230DAB2:
	add r4,r4,#0x1	; 0230DAB2
loc_0230DAB4:
	cmp r4,#0x3	; 0230DAB4
	bcc loc_0230DA32	; 0230DAB6
loc_0230DAB8:
	cmp r4,#0x3	; 0230DAB8
	beq loc_0230DBB8	; 0230DABA
	mov r0,#0x18	; 0230DABC
	mul r4,r0	; 0230DABE
	add r0,r6,r4	; 0230DAC0
	ldr r5,[r0,#0x14]	; 0230DAC2
	add r5,#0x10	; 0230DAC4
	ldrh r1,[r5,#0x10]	; 0230DAC6
	ldr r0,[sp,#0xc]	; 0230DAC8
	add r0,r1,r0	; 0230DACA
	str r0,[sp,#0x0]	; 0230DACC
	ldr r2,[pool_0230DBCC]	; 0230DACE
	cmp r0,r2	; 0230DAD0
	bls loc_0230DAEA	; 0230DAD2
	ldr r0,[pool_0230DBC0]	; 0230DAD4
	ldr r1,[r0,#0x0]	; 0230DAD6
	ldr r0,[pool_0230DBD0]	; 0230DAD8
	add r0,r1,r0	; 0230DADA
	sub r5,#0x10	; 0230DADC
	add r1,r5,#0x0	; 0230DADE
	bl loc_02304FFC	; 0230DAE0
	mov r0,#0x0	; 0230DAE4
	strh r0,[r6,r4]	; 0230DAE6
	b loc_0230DBB8	; 0230DAE8
loc_0230DAEA:
	add r2,r7,#0x0	; 0230DAEA
	add r2,#0x24	; 0230DAEC
	ldr r0,[sp,#0x8]	; 0230DAEE
	add r0,r2,r0	; 0230DAF0
	add r2,r5,#0x0	; 0230DAF2
	add r2,#0x2c	; 0230DAF4
	add r1,r2,r1	; 0230DAF6
	ldr r2,[sp,#0xc]	; 0230DAF8
	add r2,r2,#0x1	; 0230DAFA
	bl loc_0230DBE4	; 0230DAFC
	ldr r0,[sp,#0x0]	; 0230DB00
	strh r0,[r5,#0x10]	; 0230DB02
	ldrh r0,[r7,#0x0]	; 0230DB04
	mov r1,#0xf0	; 0230DB06
	and r0,r1	; 0230DB08
	mov r1,#0x10	; 0230DB0A
	bl loc_0230DBF0	; 0230DB0C
	add r6,r6,r4	; 0230DB10
	add r3,r6,#0x0	; 0230DB12
	add r3,#0x10	; 0230DB14
	ldrh r4,[r3,#0x0]	; 0230DB16
	add r2,r4,#0x0	; 0230DB18
	mov r1,#0xf	; 0230DB1A
	bic r2,r1	; 0230DB1C
	lsl r1,r4,#0x1c	; 0230DB1E
	lsr r1,r1,#0x1c	; 0230DB20
	ldr r4,[sp,#0x4]	; 0230DB22
	sub r4,r0,r4	; 0230DB24
	add r1,r1,r4	; 0230DB26
	lsl r1,r1,#0x10	; 0230DB28
	lsr r4,r1,#0x10	; 0230DB2A
	mov r1,#0xf	; 0230DB2C
	and r4,r1	; 0230DB2E
	orr r2,r4	; 0230DB30
	strh r2,[r3,#0x0]	; 0230DB32
	ldr r1,[pool_0230DBC0]	; 0230DB34
	ldr r3,[r1,#0x0]	; 0230DB36
	ldr r2,[pool_0230DBD4]	; 0230DB38
	add r2,r3,r2	; 0230DB3A
	ldr r3,[r2,#0x0]	; 0230DB3C
	add r0,r3,r0	; 0230DB3E
	str r0,[r2,#0x0]	; 0230DB40
	ldrh r2,[r7,#0x0]	; 0230DB42
	ldr r0,[pool_0230DBD8]	; 0230DB44
	and r2,r0	; 0230DB46
	cmp r2,#0x0	; 0230DB48
	bne loc_0230DBB8	; 0230DB4A
	mov r0,#0x0	; 0230DB4C
	strh r0,[r6,#0x0]	; 0230DB4E
	ldrh r2,[r5,#0x8]	; 0230DB50
	mov r0,#0xf0	; 0230DB52
	bic r2,r0	; 0230DB54
	add r2,#0x10	; 0230DB56
	strh r2,[r5,#0x8]	; 0230DB58
	add r2,r5,#0x0	; 0230DB5A
	add r2,#0x10	; 0230DB5C
	ldrh r0,[r2,#0x0]	; 0230DB5E
	add r0,#0x18	; 0230DB60
	strh r0,[r2,#0x0]	; 0230DB62
	ldrh r2,[r5,#0x8]	; 0230DB64
	mov r0,#0xf	; 0230DB66
	and r2,r0	; 0230DB68
	cmp r2,#0x0	; 0230DB6A
	beq loc_0230DB8E	; 0230DB6C
	cmp r2,#0x8	; 0230DB6E
	bne loc_0230DBAA	; 0230DB70
	ldr r2,[r1,#0x0]	; 0230DB72
	ldr r0,[pool_0230DBD0]	; 0230DB74
	add r0,r2,r0	; 0230DB76
	ldr r1,[pool_0230DBDC]	; 0230DB78
	add r1,r2,r1	; 0230DB7A
	sub r5,#0x10	; 0230DB7C
	add r2,r5,#0x0	; 0230DB7E
	bl loc_02304FAC	; 0230DB80
	mov r0,#0x2	; 0230DB84
	mov r1,#0x6	; 0230DB86
	bl loc_02304B6C	; 0230DB88
	b loc_0230DBB8	; 0230DB8C
loc_0230DB8E:
	ldr r2,[r1,#0x0]	; 0230DB8E
	ldr r0,[pool_0230DBD0]	; 0230DB90
	add r0,r2,r0	; 0230DB92
	ldr r1,[pool_0230DBE0]	; 0230DB94
	add r1,r2,r1	; 0230DB96
	sub r5,#0x10	; 0230DB98
	add r2,r5,#0x0	; 0230DB9A
	bl loc_02304FAC	; 0230DB9C
	mov r0,#0x1	; 0230DBA0
	mov r1,#0x7	; 0230DBA2
	bl loc_02304B6C	; 0230DBA4
	b loc_0230DBB8	; 0230DBA8
loc_0230DBAA:
	ldr r1,[r1,#0x0]	; 0230DBAA
	ldr r0,[pool_0230DBD0]	; 0230DBAC
	add r0,r1,r0	; 0230DBAE
	sub r5,#0x10	; 0230DBB0
	add r1,r5,#0x0	; 0230DBB2
	bl loc_02304FFC	; 0230DBB4
loc_0230DBB8:
	add sp,#0x14	; 0230DBB8
	pop {r4,r5,r6,r7}	; 0230DBBA
	pop {r3}	; 0230DBBC
	bx r3	; 0230DBBE
pool_0230DBC0:
loc_0230DBC0:
	.word FirmwareWlWorkPointerSlot	; 0230DBC0
pool_0230DBC4:
loc_0230DBC4:
	.word 0x000004A0	; 0230DBC4
pool_0230DBC8:
loc_0230DBC8:
	.word 0x80000000	; 0230DBC8
pool_0230DBCC:
loc_0230DBCC:
	.word 0x000005E4	; 0230DBCC
pool_0230DBD0:
loc_0230DBD0:
	.word 0x0000014C	; 0230DBD0
pool_0230DBD4:
loc_0230DBD4:
	.word 0x00000518	; 0230DBD4
pool_0230DBD8:
loc_0230DBD8:
	.word 0x00000100	; 0230DBD8
pool_0230DBDC:
loc_0230DBDC:
	.word 0x00000188	; 0230DBDC
pool_0230DBE0:
loc_0230DBE0:
	.word 0x000001A0	; 0230DBE0

; ===== function loc_0230DBE4 =====
loc_0230DBE4:
	bx pc	; 0230DBE4
	.byte 0xC0, 0x46	; 0230DBE8
.arm

; ===== function loc_0230DBE8 =====
loc_0230DBE8:
	ldr pc,[pool_0230DBEC]	; 0230DBE8
pool_0230DBEC:
loc_0230DBEC:
	.word P2_Entry_037FCE1C	; 0230DBEC
.thumb

; ===== function loc_0230DBF0 =====
loc_0230DBF0:
	bx pc	; 0230DBF0
	.byte 0xC0, 0x46	; 0230DBF4
.arm

; ===== function loc_0230DBF4 =====
loc_0230DBF4:
	ldr pc,[pool_0230DBF8]	; 0230DBF4
pool_0230DBF8:
loc_0230DBF8:
	.word loc_03802514	; 0230DBF8
.thumb

; ===== function loc_0230DBFC =====
loc_0230DBFC:
	push {r4,r5,r6,r7,lr}	; 0230DBFC
	sub sp,#0xc	; 0230DBFE
	str r0,[sp,#0x0]	; 0230DC00
	add r5,r1,#0x0	; 0230DC02
	ldr r0,[pool_0230DD9C]	; 0230DC04
	ldr r3,[r0,#0x0]	; 0230DC06
	ldr r0,[pool_0230DDA0]	; 0230DC08
	add r6,r3,r0	; 0230DC0A
	mov r1,#0x0	; 0230DC0C
	mvn r7,r1	; 0230DC0E
	b loc_0230DCEE	; 0230DC10
loc_0230DC12:
	add r2,r1,#0x0	; 0230DC12
	str r2,[sp,#0x4]	; 0230DC14
	mov r0,#0x18	; 0230DC16
	mul r2,r0	; 0230DC18
	str r2,[sp,#0x4]	; 0230DC1A
	add r4,r6,r2	; 0230DC1C
	lsl r0,r2,#0	; 0230DC1E
	ldrh r0,[r6,r0]	; 0230DC20
	cmp r0,#0x0	; 0230DC22
	beq loc_0230DCEA	; 0230DC24
	ldrh r2,[r5,#0x4]	; 0230DC26
	ldrh r0,[r4,#0x8]	; 0230DC28
	cmp r2,r0	; 0230DC2A
	bne loc_0230DCEC	; 0230DC2C
	ldrh r2,[r5,#0x2]	; 0230DC2E
	ldrh r0,[r4,#0x6]	; 0230DC30
	cmp r2,r0	; 0230DC32
	bne loc_0230DCEC	; 0230DC34
	ldrh r2,[r5,#0x0]	; 0230DC36
	ldrh r0,[r4,#0x4]	; 0230DC38
	cmp r2,r0	; 0230DC3A
	bne loc_0230DCEC	; 0230DC3C
	ldrh r2,[r5,#0xa]	; 0230DC3E
	ldrh r0,[r4,#0xe]	; 0230DC40
	cmp r2,r0	; 0230DC42
	bne loc_0230DCEC	; 0230DC44
	ldrh r2,[r5,#0x8]	; 0230DC46
	ldrh r0,[r4,#0xc]	; 0230DC48
	cmp r2,r0	; 0230DC4A
	bne loc_0230DCEC	; 0230DC4C
	ldrh r2,[r5,#0x6]	; 0230DC4E
	ldrh r0,[r4,#0xa]	; 0230DC50
	cmp r2,r0	; 0230DC52
	bne loc_0230DCEC	; 0230DC54
	ldrh r0,[r5,#0xc]	; 0230DC56
	lsl r0,r0,#0x10	; 0230DC58
	lsr r0,r0,#0x14	; 0230DC5A
	ldrh r2,[r4,#0x10]	; 0230DC5C
	lsl r2,r2,#0x10	; 0230DC5E
	lsr r2,r2,#0x14	; 0230DC60
	cmp r0,r2	; 0230DC62
	bne loc_0230DCEC	; 0230DC64
	ldr r0,[sp,#0x0]	; 0230DC66
	ldrh r0,[r0,#0x0]	; 0230DC68
	mov r1,#0xf0	; 0230DC6A
	and r0,r1	; 0230DC6C
	mov r1,#0x10	; 0230DC6E
	bl loc_0230DDB8	; 0230DC70
	add r7,r0,#0x0	; 0230DC74
	ldrh r0,[r4,#0x10]	; 0230DC76
	lsl r0,r0,#0x1c	; 0230DC78
	lsr r0,r0,#0x1c	; 0230DC7A
	sub r1,r7,r0	; 0230DC7C
	cmp r1,#0x0	; 0230DC7E
	bne loc_0230DC84	; 0230DC80
	b loc_0230DD92	; 0230DC82
loc_0230DC84:
	ldr r0,[pool_0230DDA4]	; 0230DC84
	and r1,r0	; 0230DC86
	cmp r1,#0x0	; 0230DC88
	beq loc_0230DC8E	; 0230DC8A
	b loc_0230DD92	; 0230DC8C
loc_0230DC8E:
	ldr r1,[sp,#0x4]	; 0230DC8E
	add r1,r6,r1	; 0230DC90
	ldr r5,[r1,#0x14]	; 0230DC92
	add r5,#0x10	; 0230DC94
	ldrh r1,[r5,#0x10]	; 0230DC96
	ldr r2,[sp,#0x0]	; 0230DC98
	ldrh r2,[r2,#0x8]	; 0230DC9A
	sub r6,r2,r1	; 0230DC9C
	sub r6,#0x18	; 0230DC9E
	cmp r6,#0x0	; 0230DCA0
	beq loc_0230DD92	; 0230DCA2
	add r2,r6,#0x0	; 0230DCA4
	and r2,r0	; 0230DCA6
	cmp r2,#0x0	; 0230DCA8
	bne loc_0230DD92	; 0230DCAA
	ldr r0,[sp,#0x0]	; 0230DCAC
	add r0,#0x24	; 0230DCAE
	str r0,[sp,#0x0]	; 0230DCB0
	add r0,r0,r1	; 0230DCB2
	add r2,r5,#0x0	; 0230DCB4
	add r2,#0x2c	; 0230DCB6
	add r1,r2,r1	; 0230DCB8
	add r2,r6,#0x0	; 0230DCBA
	bl loc_0230DDC4	; 0230DCBC
	add r5,#0x10	; 0230DCC0
	ldrh r0,[r5,#0x0]	; 0230DCC2
	add r0,r0,r6	; 0230DCC4
	strh r0,[r5,#0x0]	; 0230DCC6
	add r4,#0x10	; 0230DCC8
	ldrh r2,[r4,#0x0]	; 0230DCCA
	mov r1,#0xf	; 0230DCCC
	bic r2,r1	; 0230DCCE
	lsl r0,r7,#0x10	; 0230DCD0
	lsr r0,r0,#0x10	; 0230DCD2
	and r0,r1	; 0230DCD4
	orr r2,r0	; 0230DCD6
	strh r2,[r4,#0x0]	; 0230DCD8
	ldr r0,[pool_0230DD9C]	; 0230DCDA
	ldr r1,[r0,#0x0]	; 0230DCDC
	ldr r0,[pool_0230DDA8]	; 0230DCDE
	add r1,r1,r0	; 0230DCE0
	ldr r0,[r1,#0x0]	; 0230DCE2
	add r0,r0,r7	; 0230DCE4
	str r0,[r1,#0x0]	; 0230DCE6
	b loc_0230DD92	; 0230DCE8
loc_0230DCEA:
	add r7,r1,#0x0	; 0230DCEA
loc_0230DCEC:
	add r1,r1,#0x1	; 0230DCEC
loc_0230DCEE:
	cmp r1,#0x3	; 0230DCEE
	bcc loc_0230DC12	; 0230DCF0
	mov r0,#0x0	; 0230DCF2
	mvn r0,r0	; 0230DCF4
	cmp r7,r0	; 0230DCF6
	beq loc_0230DD92	; 0230DCF8
	ldr r0,[pool_0230DDAC]	; 0230DCFA
	add r0,r3,r0	; 0230DCFC
	ldr r1,[pool_0230DDB0]	; 0230DCFE
	bl loc_02305054	; 0230DD00
	add r4,r0,#0x0	; 0230DD04
	cmp r4,#0x0	; 0230DD06
	beq loc_0230DD8C	; 0230DD08
	mov r0,#0x18	; 0230DD0A
	mul r7,r0	; 0230DD0C
	add r0,r6,r7	; 0230DD0E
	str r0,[sp,#0x8]	; 0230DD10
	add r0,r5,#0x0	; 0230DD12
	ldr r1,[sp,#0x8]	; 0230DD14
	add r1,r1,#0x4	; 0230DD16
	mov r2,#0x10	; 0230DD18
	bl loc_0230DDD0	; 0230DD1A
	mov r0,#0x5	; 0230DD1E
	strh r0,[r6,r7]	; 0230DD20
	add r0,r6,r7	; 0230DD22
	str r4,[r0,#0x14]	; 0230DD24
	add r4,#0x10	; 0230DD26
	ldr r0,[sp,#0x0]	; 0230DD28
	add r1,r4,#0x0	; 0230DD2A
	add r1,#0x8	; 0230DD2C
	lsl r2,r0,#0	; 0230DD2E
	ldrh r2,[r2,#0x8]	; 0230DD30
	add r2,#0xc	; 0230DD32
	bl loc_0230DDDC	; 0230DD34
	ldr r0,[pool_0230DD9C]	; 0230DD38
	ldr r1,[r0,#0x0]	; 0230DD3A
	ldr r0,[pool_0230DDB4]	; 0230DD3C
	ldr r0,[r1,r0]	; 0230DD3E
	bl loc_0230DDE8	; 0230DD40
	ldrh r0,[r4,#0x8]	; 0230DD44
	mov r1,#0xf0	; 0230DD46
	and r0,r1	; 0230DD48
	mov r1,#0x10	; 0230DD4A
	bl loc_0230DDF8	; 0230DD4C
	add r1,r0,#0x0	; 0230DD50
	ldr r0,[sp,#0x8]	; 0230DD52
	add r0,#0x10	; 0230DD54
	str r0,[sp,#0x8]	; 0230DD56
	ldrh r0,[r0,#0x0]	; 0230DD58
	mov r3,#0xf	; 0230DD5A
	bic r0,r3	; 0230DD5C
	lsl r2,r1,#0x10	; 0230DD5E
	lsr r2,r2,#0x10	; 0230DD60
	and r2,r3	; 0230DD62
	orr r0,r2	; 0230DD64
	ldr r2,[sp,#0x8]	; 0230DD66
	strh r0,[r2,#0x0]	; 0230DD68
	ldr r0,[pool_0230DD9C]	; 0230DD6A
	ldr r2,[r0,#0x0]	; 0230DD6C
	ldr r0,[pool_0230DDA8]	; 0230DD6E
	add r2,r2,r0	; 0230DD70
	ldr r0,[r2,#0x0]	; 0230DD72
	add r0,r0,r1	; 0230DD74
	str r0,[r2,#0x0]	; 0230DD76
	ldr r0,[sp,#0x0]	; 0230DD78
	ldrh r0,[r0,#0x8]	; 0230DD7A
	sub r0,#0x18	; 0230DD7C
	strh r0,[r4,#0x10]	; 0230DD7E
	ldrh r0,[r4,#0x10]	; 0230DD80
	bl loc_0230DE04	; 0230DD82
	add r1,r6,r7	; 0230DD86
	strh r0,[r1,#0x2]	; 0230DD88
	b loc_0230DD92	; 0230DD8A
loc_0230DD8C:
	mov r0,#0x4	; 0230DD8C
	bl loc_02305134	; 0230DD8E
loc_0230DD92:
	add sp,#0xc	; 0230DD92
	pop {r4,r5,r6,r7}	; 0230DD94
	pop {r3}	; 0230DD96
	bx r3	; 0230DD98
	.byte 0xC0, 0x46	; 0230DD9C
pool_0230DD9C:
loc_0230DD9C:
	.word FirmwareWlWorkPointerSlot	; 0230DD9C
pool_0230DDA0:
loc_0230DDA0:
	.word 0x000004A0	; 0230DDA0
pool_0230DDA4:
loc_0230DDA4:
	.word 0x80000000	; 0230DDA4
pool_0230DDA8:
loc_0230DDA8:
	.word 0x00000518	; 0230DDA8
pool_0230DDAC:
loc_0230DDAC:
	.word 0x0000014C	; 0230DDAC
pool_0230DDB0:
loc_0230DDB0:
	.word 0x00000622	; 0230DDB0
pool_0230DDB4:
loc_0230DDB4:
	.word 0x000002D0	; 0230DDB4

; ===== function loc_0230DDB8 =====
loc_0230DDB8:
	bx pc	; 0230DDB8
	.byte 0xC0, 0x46	; 0230DDBC
.arm

; ===== function loc_0230DDBC =====
loc_0230DDBC:
	ldr pc,[pool_0230DDC0]	; 0230DDBC
pool_0230DDC0:
loc_0230DDC0:
	.word loc_03802514	; 0230DDC0
.thumb

; ===== function loc_0230DDC4 =====
loc_0230DDC4:
	bx pc	; 0230DDC4
	.byte 0xC0, 0x46	; 0230DDC8
.arm

; ===== function loc_0230DDC8 =====
loc_0230DDC8:
	ldr pc,[pool_0230DDCC]	; 0230DDC8
pool_0230DDCC:
loc_0230DDCC:
	.word P2_Entry_037FCE1C	; 0230DDCC
.thumb

; ===== function loc_0230DDD0 =====
loc_0230DDD0:
	bx pc	; 0230DDD0
	.byte 0xC0, 0x46	; 0230DDD4
.arm

; ===== function loc_0230DDD4 =====
loc_0230DDD4:
	ldr pc,[pool_0230DDD8]	; 0230DDD4
pool_0230DDD8:
loc_0230DDD8:
	.word P2_Entry_037FCE1C	; 0230DDD8
.thumb

; ===== function loc_0230DDDC =====
loc_0230DDDC:
	bx pc	; 0230DDDC
	.byte 0xC0, 0x46	; 0230DDE0
.arm

; ===== function loc_0230DDE0 =====
loc_0230DDE0:
	ldr pc,[pool_0230DDE4]	; 0230DDE0
pool_0230DDE4:
loc_0230DDE4:
	.word P2_Entry_037FCE1C	; 0230DDE4
.thumb

; ===== function loc_0230DDE8 =====
loc_0230DDE8:
	bx pc	; 0230DDE8
	.byte 0xC0, 0x46	; 0230DDEC
.arm

; ===== function loc_0230DDEC =====
loc_0230DDEC:
	ldr r12,[pool_0230DDF4]	; 0230DDEC
	bx r12	; 0230DDF0
pool_0230DDF4:
loc_0230DDF4:
	.word P2_Entry_037FCD10 + 1	; 0230DDF4
.thumb

; ===== function loc_0230DDF8 =====
loc_0230DDF8:
	bx pc	; 0230DDF8
	.byte 0xC0, 0x46	; 0230DDFC
.arm

; ===== function loc_0230DDFC =====
loc_0230DDFC:
	ldr pc,[pool_0230DE00]	; 0230DDFC
pool_0230DE00:
loc_0230DE00:
	.word loc_03802514	; 0230DE00
.thumb

; ===== function loc_0230DE04 =====
loc_0230DE04:
	bx pc	; 0230DE04
	.byte 0xC0, 0x46	; 0230DE08
.arm

; ===== function loc_0230DE08 =====
loc_0230DE08:
	ldr pc,[pool_0230DE0C]	; 0230DE08
pool_0230DE0C:
loc_0230DE0C:
	.word loc_03802720	; 0230DE0C
.thumb

; ===== function loc_0230DE10 =====
	push {r4,r5,lr}	; 0230DE10
	sub sp,#0x14	; 0230DE12
	ldr r0,[pool_0230DEEC]	; 0230DE14
	ldr r1,[r0,#0x0]	; 0230DE16
	ldr r0,[pool_0230DEF0]	; 0230DE18
	ldr r5,[r1,r0]	; 0230DE1A
	mov r0,#0x0	; 0230DE1C
	mvn r0,r0	; 0230DE1E
	cmp r5,r0	; 0230DE20
	beq loc_0230DEE4	; 0230DE22
	add r4,r5,#0x0	; 0230DE24
	add r4,#0x10	; 0230DE26
	ldr r0,[pool_0230DEF4]	; 0230DE28
	ldrh r0,[r1,r0]	; 0230DE2A
	cmp r0,#0x40	; 0230DE2C
	bne loc_0230DEC2	; 0230DE2E
	ldrh r1,[r4,#0x10]	; 0230DE30
	ldr r0,[pool_0230DEF8]	; 0230DE32
	cmp r1,r0	; 0230DE34
	bhi loc_0230DEC2	; 0230DE36
	ldrh r0,[r4,#0x14]	; 0230DE38
	lsl r0,r0,#0x17	; 0230DE3A
	lsr r0,r0,#0x1f	; 0230DE3C
	cmp r0,#0x0	; 0230DE3E
	beq loc_0230DE64	; 0230DE40
	add r0,sp,#0x0	; 0230DE42
	add r1,r4,#0x0	; 0230DE44
	add r1,#0x24	; 0230DE46
	bl loc_0230645C	; 0230DE48
	ldrh r0,[r4,#0x14]	; 0230DE4C
	lsl r0,r0,#0x16	; 0230DE4E
	lsr r0,r0,#0x1f	; 0230DE50
	cmp r0,#0x0	; 0230DE52
	bne loc_0230DEC2	; 0230DE54
	add r0,sp,#0x4	; 0230DE56
	add r0,#0x2	; 0230DE58
	add r1,r4,#0x0	; 0230DE5A
	add r1,#0x1e	; 0230DE5C
	bl loc_0230645C	; 0230DE5E
	b loc_0230DE92	; 0230DE62
loc_0230DE64:
	add r0,sp,#0x0	; 0230DE64
	add r1,r4,#0x0	; 0230DE66
	add r1,#0x18	; 0230DE68
	bl loc_0230645C	; 0230DE6A
	ldrh r0,[r4,#0x14]	; 0230DE6E
	lsl r0,r0,#0x16	; 0230DE70
	lsr r0,r0,#0x1f	; 0230DE72
	cmp r0,#0x0	; 0230DE74
	beq loc_0230DE86	; 0230DE76
	add r0,sp,#0x4	; 0230DE78
	add r0,#0x2	; 0230DE7A
	add r1,r4,#0x0	; 0230DE7C
	add r1,#0x24	; 0230DE7E
	bl loc_0230645C	; 0230DE80
	b loc_0230DE92	; 0230DE84
loc_0230DE86:
	add r0,sp,#0x4	; 0230DE86
	add r0,#0x2	; 0230DE88
	add r1,r4,#0x0	; 0230DE8A
	add r1,#0x1e	; 0230DE8C
	bl loc_0230645C	; 0230DE8E
loc_0230DE92:
	ldrh r1,[r4,#0x2a]	; 0230DE92
	add r0,sp,#0x0	; 0230DE94
	strh r1,[r0,#0xc]	; 0230DE96
	ldrh r0,[r4,#0x14]	; 0230DE98
	lsl r0,r0,#0x15	; 0230DE9A
	lsr r0,r0,#0x1f	; 0230DE9C
	cmp r0,#0x1	; 0230DE9E
	bne loc_0230DEB8	; 0230DEA0
	ldrh r0,[r4,#0x2a]	; 0230DEA2
	lsl r0,r0,#0x1c	; 0230DEA4
	lsr r0,r0,#0x1c	; 0230DEA6
	cmp r0,#0x0	; 0230DEA8
	bne loc_0230DEB8	; 0230DEAA
	add r4,#0x8	; 0230DEAC
	add r0,r4,#0x0	; 0230DEAE
	add r1,sp,#0x0	; 0230DEB0
	bl loc_0230DBFC	; 0230DEB2
	b loc_0230DEC2	; 0230DEB6
loc_0230DEB8:
	add r4,#0x8	; 0230DEB8
	add r0,r4,#0x0	; 0230DEBA
	add r1,sp,#0x0	; 0230DEBC
	bl loc_0230DA14	; 0230DEBE
loc_0230DEC2:
	ldr r0,[pool_0230DEEC]	; 0230DEC2
	ldr r1,[r0,#0x0]	; 0230DEC4
	ldr r0,[pool_0230DEF0]	; 0230DEC6
	add r0,r1,r0	; 0230DEC8
	add r1,r5,#0x0	; 0230DECA
	bl loc_02304FFC	; 0230DECC
	ldr r0,[pool_0230DEEC]	; 0230DED0
	ldr r1,[r0,#0x0]	; 0230DED2
	ldr r0,[pool_0230DEFC]	; 0230DED4
	ldrh r0,[r1,r0]	; 0230DED6
	cmp r0,#0x0	; 0230DED8
	beq loc_0230DEE4	; 0230DEDA
	mov r0,#0x2	; 0230DEDC
	mov r1,#0x9	; 0230DEDE
	bl loc_02304B6C	; 0230DEE0
loc_0230DEE4:
	add sp,#0x14	; 0230DEE4
	pop {r4,r5}	; 0230DEE6
	pop {r3}	; 0230DEE8
	bx r3	; 0230DEEA
pool_0230DEEC:
loc_0230DEEC:
	.word FirmwareWlWorkPointerSlot	; 0230DEEC
pool_0230DEF0:
loc_0230DEF0:
	.word 0x000001AC	; 0230DEF0
pool_0230DEF4:
loc_0230DEF4:
	.word 0x00000310	; 0230DEF4
pool_0230DEF8:
loc_0230DEF8:
	.word 0x000005FC	; 0230DEF8
pool_0230DEFC:
loc_0230DEFC:
	.word 0x000001B4	; 0230DEFC

; ===== function loc_0230DF00 =====
loc_0230DF00:
	push {r4,r5,r6,r7,lr}	; 0230DF00
	sub sp,#0x4	; 0230DF02
	add r5,r0,#0x0	; 0230DF04
	ldr r0,[pool_0230DF6C]	; 0230DF06
	ldr r1,[r0,#0x0]	; 0230DF08
	ldr r0,[pool_0230DF70]	; 0230DF0A
	ldr r2,[r1,r0]	; 0230DF0C
	ldrh r1,[r5,#0x2]	; 0230DF0E
	mov r0,#0x1c	; 0230DF10
	mul r1,r0	; 0230DF12
	add r0,r2,r1	; 0230DF14
	ldrh r0,[r0,#0xe]	; 0230DF16
	bl loc_02305374	; 0230DF18
	add r4,r5,#0x0	; 0230DF1C
	add r4,#0x34	; 0230DF1E
	add r5,#0x33	; 0230DF20
	add r0,r5,#0x0	; 0230DF22
	bl loc_023053B8	; 0230DF24
	add r6,r0,#0x0	; 0230DF28
	mov r5,#0x0	; 0230DF2A
	lsr r7,r6,#0x1	; 0230DF2C
	b loc_0230DF42	; 0230DF2E
loc_0230DF30:
	bl loc_02305340	; 0230DF30
	ldrh r1,[r4,#0x0]	; 0230DF34
	add r4,r4,#0x2	; 0230DF36
	cmp r1,r0	; 0230DF38
	beq loc_0230DF40	; 0230DF3A
	mov r0,#0x0	; 0230DF3C
	b loc_0230DF64	; 0230DF3E
loc_0230DF40:
	add r5,r5,#0x1	; 0230DF40
loc_0230DF42:
	cmp r5,r7	; 0230DF42
	bcc loc_0230DF30	; 0230DF44
	mov r0,#0x1	; 0230DF46
	and r6,r0	; 0230DF48
	cmp r6,#0x0	; 0230DF4A
	beq loc_0230DF62	; 0230DF4C
	bl loc_02305340	; 0230DF4E
	ldrh r2,[r4,#0x0]	; 0230DF52
	mov r1,#0xff	; 0230DF54
	and r2,r1	; 0230DF56
	and r0,r1	; 0230DF58
	cmp r2,r0	; 0230DF5A
	beq loc_0230DF62	; 0230DF5C
	mov r0,#0x0	; 0230DF5E
	b loc_0230DF64	; 0230DF60
loc_0230DF62:
	mov r0,#0x1	; 0230DF62
loc_0230DF64:
	add sp,#0x4	; 0230DF64
	pop {r4,r5,r6,r7}	; 0230DF66
	pop {r3}	; 0230DF68
	bx r3	; 0230DF6A
pool_0230DF6C:
loc_0230DF6C:
	.word FirmwareWlWorkPointerSlot	; 0230DF6C
pool_0230DF70:
loc_0230DF70:
	.word 0x000002E0	; 0230DF70

; ===== function loc_0230DF74 =====
loc_0230DF74:
	push {r4,r5,r6,lr}	; 0230DF74
	add r5,r0,#0x0	; 0230DF76
	add r6,r1,#0x0	; 0230DF78
	ldr r0,[pool_0230DFCC]	; 0230DF7A
	ldrh r1,[r0,#0x0]	; 0230DF7C
	ldrh r0,[r0,#0x0]	; 0230DF7E
	lsl r0,r0,#0x8	; 0230DF80
	add r0,r1,r0	; 0230DF82
	lsl r0,r0,#0x10	; 0230DF84
	lsr r4,r0,#0x10	; 0230DF86
	cmp r4,#0x0	; 0230DF88
	bne loc_0230DF8E	; 0230DF8A
	mov r4,#0x1	; 0230DF8C
loc_0230DF8E:
	add r0,r4,#0x0	; 0230DF8E
	bl loc_02305374	; 0230DF90
	ldr r0,[pool_0230DFD0]	; 0230DF94
	ldr r1,[r0,#0x0]	; 0230DF96
	ldr r0,[pool_0230DFD4]	; 0230DF98
	ldr r1,[r1,r0]	; 0230DF9A
	mov r0,#0x1c	; 0230DF9C
	mul r5,r0	; 0230DF9E
	add r0,r1,r5	; 0230DFA0
	strh r4,[r0,#0xe]	; 0230DFA2
	add r4,r6,#0x0	; 0230DFA4
	add r4,#0x34	; 0230DFA6
	add r6,#0x33	; 0230DFA8
	add r0,r6,#0x0	; 0230DFAA
	bl loc_023053B8	; 0230DFAC
	add r6,r0,#0x0	; 0230DFB0
	mov r5,#0x0	; 0230DFB2
	b loc_0230DFC0	; 0230DFB4
loc_0230DFB6:
	bl loc_02305340	; 0230DFB6
	strh r0,[r4,#0x0]	; 0230DFBA
	add r4,r4,#0x2	; 0230DFBC
	add r5,r5,#0x2	; 0230DFBE
loc_0230DFC0:
	cmp r5,r6	; 0230DFC0
	bcc loc_0230DFB6	; 0230DFC2
	pop {r4,r5,r6}	; 0230DFC4
	pop {r3}	; 0230DFC6
	bx r3	; 0230DFC8
	.byte 0xC0, 0x46	; 0230DFCC
pool_0230DFCC:
loc_0230DFCC:
	.word REG_WIFI_RANDOM	; 0230DFCC
pool_0230DFD0:
loc_0230DFD0:
	.word FirmwareWlWorkPointerSlot	; 0230DFD0
pool_0230DFD4:
loc_0230DFD4:
	.word 0x000002E0	; 0230DFD4

; ===== function loc_0230DFD8 =====
	push {r4,r5,r6,r7,lr}	; 0230DFD8
	sub sp,#0x4	; 0230DFDA
	ldr r0,[pool_0230E258]	; 0230DFDC
	ldr r1,[r0,#0x0]	; 0230DFDE
	ldr r0,[pool_0230E25C]	; 0230DFE0
	add r7,r1,r0	; 0230DFE2
	ldr r0,[pool_0230E260]	; 0230DFE4
	ldr r0,[r1,r0]	; 0230DFE6
	str r0,[sp,#0x0]	; 0230DFE8
	mov r0,#0x0	; 0230DFEA
	mvn r1,r0	; 0230DFEC
	ldr r0,[sp,#0x0]	; 0230DFEE
	cmp r0,r1	; 0230DFF0
	bne loc_0230DFF6	; 0230DFF2
	b loc_0230E250	; 0230DFF4
loc_0230DFF6:
	lsl r4,r0,#0	; 0230DFF6
	add r4,#0x10	; 0230DFF8
	add r5,r4,#0x0	; 0230DFFA
	add r5,#0x14	; 0230DFFC
	ldrh r1,[r4,#0x18]	; 0230DFFE
	mov r0,#0x1	; 0230E000
	and r1,r0	; 0230E002
	cmp r1,#0x0	; 0230E004
	beq loc_0230E014	; 0230E006
	add r1,r7,#0x0	; 0230E008
	add r1,#0x2c	; 0230E00A
	ldr r0,[r1,#0x0]	; 0230E00C
	add r0,r0,#0x1	; 0230E00E
	str r0,[r1,#0x0]	; 0230E010
	b loc_0230E01E	; 0230E012
loc_0230E014:
	add r1,r7,#0x0	; 0230E014
	add r1,#0x28	; 0230E016
	ldr r0,[r1,#0x0]	; 0230E018
	add r0,r0,#0x1	; 0230E01A
	str r0,[r1,#0x0]	; 0230E01C
loc_0230E01E:
	add r6,r7,#0x0	; 0230E01E
	add r6,#0x24	; 0230E020
	ldrh r0,[r4,#0x8]	; 0230E022
	mov r1,#0xf0	; 0230E024
	and r0,r1	; 0230E026
	mov r1,#0x10	; 0230E028
	bl loc_0230E270	; 0230E02A
	ldr r1,[r6,#0x0]	; 0230E02E
	sub r0,r0,#0x1	; 0230E030
	add r0,r1,r0	; 0230E032
	str r0,[r6,#0x0]	; 0230E034
	add r0,r5,#0x0	; 0230E036
	add r0,#0xa	; 0230E038
	bl loc_023093C0	; 0230E03A
	add r6,r0,#0x0	; 0230E03E
	lsl r0,r6,#0x10	; 0230E040
	lsr r0,r0,#0x10	; 0230E042
	strh r0,[r4,#0x2]	; 0230E044
	cmp r6,#0xff	; 0230E046
	bne loc_0230E092	; 0230E048
	mov r0,#0x0	; 0230E04A
	strh r0,[r4,#0x2]	; 0230E04C
	ldr r0,[pool_0230E258]	; 0230E04E
	ldr r1,[r0,#0x0]	; 0230E050
	ldr r0,[pool_0230E264]	; 0230E052
	ldrh r0,[r1,r0]	; 0230E054
	cmp r0,#0x1	; 0230E056
	beq loc_0230E05C	; 0230E058
	b loc_0230E22E	; 0230E05A
loc_0230E05C:
	ldrh r0,[r5,#0x0]	; 0230E05C
	lsl r1,r0,#0x1c	; 0230E05E
	lsr r1,r1,#0x1e	; 0230E060
	cmp r1,#0x0	; 0230E062
	beq loc_0230E068	; 0230E064
	b loc_0230E22E	; 0230E066
loc_0230E068:
	lsl r0,r0,#0x18	; 0230E068
	lsr r0,r0,#0x1c	; 0230E06A
	cmp r0,#0x0	; 0230E06C
	beq loc_0230E08A	; 0230E06E
	cmp r0,#0x4	; 0230E070
	beq loc_0230E082	; 0230E072
	cmp r0,#0xb	; 0230E074
	beq loc_0230E07A	; 0230E076
	b loc_0230E22E	; 0230E078
loc_0230E07A:
	add r0,r4,#0x0	; 0230E07A
	bl loc_0230E630	; 0230E07C
	b loc_0230E22E	; 0230E080
loc_0230E082:
	add r0,r4,#0x0	; 0230E082
	bl loc_0230ECD0	; 0230E084
	b loc_0230E22E	; 0230E088
loc_0230E08A:
	add r0,r4,#0x0	; 0230E08A
	bl loc_0230F0A8	; 0230E08C
	b loc_0230E22E	; 0230E090
loc_0230E092:
	ldrh r2,[r4,#0x12]	; 0230E092
	mov r1,#0xff	; 0230E094
	and r2,r1	; 0230E096
	lsl r1,r2,#0x10	; 0230E098
	lsr r1,r1,#0x10	; 0230E09A
	bl loc_023091D4	; 0230E09C
	ldrh r0,[r5,#0x0]	; 0230E0A0
	lsl r0,r0,#0x1c	; 0230E0A2
	lsr r0,r0,#0x1e	; 0230E0A4
	cmp r0,#0x0	; 0230E0A6
	bne loc_0230E0CC	; 0230E0A8
	ldrh r2,[r4,#0x2a]	; 0230E0AA
	ldr r0,[pool_0230E258]	; 0230E0AC
	ldr r1,[r0,#0x0]	; 0230E0AE
	ldr r0,[pool_0230E268]	; 0230E0B0
	ldr r1,[r1,r0]	; 0230E0B2
	mov r0,#0x1c	; 0230E0B4
	add r3,r6,#0x0	; 0230E0B6
	mul r3,r0	; 0230E0B8
	add r0,r1,r3	; 0230E0BA
	ldrh r0,[r0,#0x14]	; 0230E0BC
	cmp r2,r0	; 0230E0BE
	bne loc_0230E0CC	; 0230E0C0
	add r7,#0x3c	; 0230E0C2
	ldr r0,[r7,#0x0]	; 0230E0C4
	add r0,r0,#0x1	; 0230E0C6
	str r0,[r7,#0x0]	; 0230E0C8
	b loc_0230E22E	; 0230E0CA
loc_0230E0CC:
	ldr r0,[pool_0230E258]	; 0230E0CC
	ldr r1,[r0,#0x0]	; 0230E0CE
	ldr r0,[pool_0230E264]	; 0230E0D0
	ldrh r0,[r1,r0]	; 0230E0D2
	cmp r0,#0x1	; 0230E0D4
	beq loc_0230E0E2	; 0230E0D6
	cmp r0,#0x2	; 0230E0D8
	beq loc_0230E196	; 0230E0DA
	cmp r0,#0x3	; 0230E0DC
	beq loc_0230E196	; 0230E0DE
	b loc_0230E22E	; 0230E0E0
loc_0230E0E2:
	lsl r0,r6,#0x10	; 0230E0E2
	lsr r0,r0,#0x10	; 0230E0E4
	ldrh r1,[r5,#0x0]	; 0230E0E6
	lsl r1,r1,#0x13	; 0230E0E8
	lsr r1,r1,#0x1f	; 0230E0EA
	bl loc_02309184	; 0230E0EC
	ldrh r0,[r5,#0x0]	; 0230E0F0
	lsl r1,r0,#0x1c	; 0230E0F2
	lsr r1,r1,#0x1e	; 0230E0F4
	cmp r1,#0x0	; 0230E0F6
	bne loc_0230E182	; 0230E0F8
	ldrh r0,[r5,#0x16]	; 0230E0FA
	ldr r1,[pool_0230E258]	; 0230E0FC
	ldr r2,[r1,#0x0]	; 0230E0FE
	ldr r1,[pool_0230E268]	; 0230E100
	ldr r2,[r2,r1]	; 0230E102
	mov r1,#0x1c	; 0230E104
	mul r6,r1	; 0230E106
	add r1,r2,r6	; 0230E108
	strh r0,[r1,#0x14]	; 0230E10A
	ldrh r0,[r5,#0x0]	; 0230E10C
	lsl r0,r0,#0x18	; 0230E10E
	lsr r0,r0,#0x1c	; 0230E110
	cmp r0,#0xc	; 0230E112
	bls loc_0230E118	; 0230E114
	b loc_0230E22E	; 0230E116
loc_0230E118:
	add r0,r0,r0	; 0230E118
P4_SwitchIndexPC_0230E118:
	add r0,pc	; 0230E11A
	ldrh r0,[r0,#(P4_SwitchTable_0230E118 - (P4_SwitchIndexPC_0230E118 + 4))]	; 0230E11C
	lsl r0,r0,#0x10	; 0230E11E
	asr r0,r0,#0x10	; 0230E120
P4_SwitchTargetPC_0230E118:
	add r0,pc	; 0230E122
	bx r0	; 0230E124
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230E118:
	.halfword (loc_0230E148 + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E150 + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E158 + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E160 + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E140 + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E16A + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E172 + 1) - (P4_SwitchTargetPC_0230E118 + 4)
	.halfword (loc_0230E17A + 1) - (P4_SwitchTargetPC_0230E118 + 4)
P4_SwitchTable_0230E118End:
loc_0230E140:
	add r0,r4,#0x0	; 0230E140
	bl loc_0230F2AC	; 0230E142
	b loc_0230E22E	; 0230E146
loc_0230E148:
	add r0,r4,#0x0	; 0230E148
	bl loc_0230F0A8	; 0230E14A
	b loc_0230E22E	; 0230E14E
loc_0230E150:
	add r0,r4,#0x0	; 0230E150
	bl loc_0230EE80	; 0230E152
	b loc_0230E22E	; 0230E156
loc_0230E158:
	add r0,r4,#0x0	; 0230E158
	bl loc_0230ECD0	; 0230E15A
	b loc_0230E22E	; 0230E15E
loc_0230E160:
	add r0,r4,#0x0	; 0230E160
	mov r1,#0x0	; 0230E162
	bl loc_0230EA70	; 0230E164
	b loc_0230E22E	; 0230E168
loc_0230E16A:
	add r0,r4,#0x0	; 0230E16A
	bl loc_0230F1E0	; 0230E16C
	b loc_0230E22E	; 0230E170
loc_0230E172:
	add r0,r4,#0x0	; 0230E172
	bl loc_0230E630	; 0230E174
	b loc_0230E22E	; 0230E178
loc_0230E17A:
	add r0,r4,#0x0	; 0230E17A
	bl loc_0230E588	; 0230E17C
	b loc_0230E22E	; 0230E180
loc_0230E182:
	cmp r1,#0x1	; 0230E182
	bne loc_0230E22E	; 0230E184
	lsl r0,r0,#0x18	; 0230E186
	lsr r0,r0,#0x1c	; 0230E188
	cmp r0,#0xa	; 0230E18A
	bne loc_0230E22E	; 0230E18C
	add r0,r4,#0x0	; 0230E18E
	bl loc_0230E520	; 0230E190
	b loc_0230E22E	; 0230E194
loc_0230E196:
	ldrh r0,[r5,#0x16]	; 0230E196
	ldr r2,[pool_0230E268]	; 0230E198
	ldr r2,[r1,r2]	; 0230E19A
	mov r1,#0x1c	; 0230E19C
	mul r6,r1	; 0230E19E
	add r1,r2,r6	; 0230E1A0
	strh r0,[r1,#0x14]	; 0230E1A2
	ldrh r0,[r5,#0x0]	; 0230E1A4
	lsl r1,r0,#0x1c	; 0230E1A6
	lsr r1,r1,#0x1e	; 0230E1A8
	cmp r1,#0x0	; 0230E1AA
	bne loc_0230E218	; 0230E1AC
	lsl r0,r0,#0x18	; 0230E1AE
	lsr r0,r0,#0x1c	; 0230E1B0
	cmp r0,#0xc	; 0230E1B2
	bhi loc_0230E22E	; 0230E1B4
	add r0,r0,r0	; 0230E1B6
P4_SwitchIndexPC_0230E1B6:
	add r0,pc	; 0230E1B8
	ldrh r0,[r0,#(P4_SwitchTable_0230E1B6 - (P4_SwitchIndexPC_0230E1B6 + 4))]	; 0230E1BA
	lsl r0,r0,#0x10	; 0230E1BC
	asr r0,r0,#0x10	; 0230E1BE
P4_SwitchTargetPC_0230E1B6:
	add r0,pc	; 0230E1C0
	bx r0	; 0230E1C2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230E1B6:
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E1E6 + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E1EE + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E1F6 + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E1DE + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E22E + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E200 + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E208 + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
	.halfword (loc_0230E210 + 1) - (P4_SwitchTargetPC_0230E1B6 + 4)
P4_SwitchTable_0230E1B6End:
loc_0230E1DE:
	add r0,r4,#0x0	; 0230E1DE
	bl loc_0230F2AC	; 0230E1E0
	b loc_0230E22E	; 0230E1E4
loc_0230E1E6:
	add r0,r4,#0x0	; 0230E1E6
	bl loc_0230EF9C	; 0230E1E8
	b loc_0230E22E	; 0230E1EC
loc_0230E1EE:
	add r0,r4,#0x0	; 0230E1EE
	bl loc_0230ED60	; 0230E1F0
	b loc_0230E22E	; 0230E1F4
loc_0230E1F6:
	add r0,r4,#0x0	; 0230E1F6
	mov r1,#0x0	; 0230E1F8
	bl loc_0230EA70	; 0230E1FA
	b loc_0230E22E	; 0230E1FE
loc_0230E200:
	add r0,r4,#0x0	; 0230E200
	bl loc_0230F1E0	; 0230E202
	b loc_0230E22E	; 0230E206
loc_0230E208:
	add r0,r4,#0x0	; 0230E208
	bl loc_0230E630	; 0230E20A
	b loc_0230E22E	; 0230E20E
loc_0230E210:
	add r0,r4,#0x0	; 0230E210
	bl loc_0230E588	; 0230E212
	b loc_0230E22E	; 0230E216
loc_0230E218:
	cmp r1,#0x1	; 0230E218
	bne loc_0230E22E	; 0230E21A
	lsl r0,r0,#0x18	; 0230E21C
	lsr r0,r0,#0x1c	; 0230E21E
	cmp r0,#0xe	; 0230E220
	beq loc_0230E228	; 0230E222
	cmp r0,#0xf	; 0230E224
	bne loc_0230E22E	; 0230E226
loc_0230E228:
	add r0,r4,#0x0	; 0230E228
	bl loc_0230E51C	; 0230E22A
loc_0230E22E:
	ldr r0,[pool_0230E258]	; 0230E22E
	ldr r1,[r0,#0x0]	; 0230E230
	ldr r0,[pool_0230E260]	; 0230E232
	add r0,r1,r0	; 0230E234
	ldr r1,[sp,#0x0]	; 0230E236
	bl loc_02304FFC	; 0230E238
	ldr r0,[pool_0230E258]	; 0230E23C
	ldr r1,[r0,#0x0]	; 0230E23E
	ldr r0,[pool_0230E26C]	; 0230E240
	ldrh r0,[r1,r0]	; 0230E242
	cmp r0,#0x0	; 0230E244
	beq loc_0230E250	; 0230E246
	mov r0,#0x1	; 0230E248
	mov r1,#0x7	; 0230E24A
	bl loc_02304B6C	; 0230E24C
loc_0230E250:
	add sp,#0x4	; 0230E250
	pop {r4,r5,r6,r7}	; 0230E252
	pop {r3}	; 0230E254
	bx r3	; 0230E256
pool_0230E258:
loc_0230E258:
	.word FirmwareWlWorkPointerSlot	; 0230E258
pool_0230E25C:
loc_0230E25C:
	.word 0x000004F4	; 0230E25C
pool_0230E260:
loc_0230E260:
	.word 0x000001A0	; 0230E260
pool_0230E264:
loc_0230E264:
	.word 0x00000314	; 0230E264
pool_0230E268:
loc_0230E268:
	.word 0x000002E0	; 0230E268
pool_0230E26C:
loc_0230E26C:
	.word 0x000001A8	; 0230E26C

; ===== function loc_0230E270 =====
loc_0230E270:
	bx pc	; 0230E270
	.byte 0xC0, 0x46	; 0230E274
.arm

; ===== function loc_0230E274 =====
loc_0230E274:
	ldr pc,[pool_0230E278]	; 0230E274
pool_0230E278:
loc_0230E278:
	.word loc_03802514	; 0230E278
.thumb

; ===== function loc_0230E27C =====
loc_0230E27C:
	push {r4,r5,r6,r7,lr}	; 0230E27C
	sub sp,#0x4	; 0230E27E
	add r4,r0,#0x0	; 0230E280
	ldr r5,[r4,#0x0]	; 0230E282
	ldr r0,[pool_0230E4EC]	; 0230E284
	ldr r1,[r0,#0x0]	; 0230E286
	ldr r0,[pool_0230E4F0]	; 0230E288
	ldrh r0,[r1,r0]	; 0230E28A
	strh r0,[r4,#0x12]	; 0230E28C
	ldrh r1,[r4,#0xc]	; 0230E28E
	ldr r0,[pool_0230E4F4]	; 0230E290
	and r1,r0	; 0230E292
	cmp r1,#0x0	; 0230E294
	beq loc_0230E2A4	; 0230E296
	add r2,r4,#0x0	; 0230E298
	add r2,#0xa	; 0230E29A
	ldrh r1,[r2,#0x0]	; 0230E29C
	mov r0,#0x1	; 0230E29E
	orr r1,r0	; 0230E2A0
	strh r1,[r2,#0x0]	; 0230E2A2
loc_0230E2A4:
	ldrh r0,[r4,#0x8]	; 0230E2A4
	str r0,[sp,#0x0]	; 0230E2A6
	b loc_0230E464	; 0230E2A8
loc_0230E2AA:
	add r0,r5,#0x0	; 0230E2AA
	bl loc_023053B8	; 0230E2AC
	add r7,r0,#0x0	; 0230E2B0
	add r0,r5,#0x1	; 0230E2B2
	add r5,r5,#0x2	; 0230E2B4
	bl loc_023053B8	; 0230E2B6
	add r6,r0,#0x0	; 0230E2BA
	cmp r7,#0x5	; 0230E2BC
	bhi loc_0230E2DA	; 0230E2BE
	add r0,r7,r7	; 0230E2C0
P4_SwitchIndexPC_0230E2C0:
	add r0,pc	; 0230E2C2
	ldrh r0,[r0,#(P4_SwitchTable_0230E2C0 - (P4_SwitchIndexPC_0230E2C0 + 4))]	; 0230E2C4
	lsl r0,r0,#0x10	; 0230E2C6
	asr r0,r0,#0x10	; 0230E2C8
P4_SwitchTargetPC_0230E2C0:
	add r0,pc	; 0230E2CA
	bx r0	; 0230E2CC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230E2C0:
	.halfword (loc_0230E2E2 + 1) - (P4_SwitchTargetPC_0230E2C0 + 4)
	.halfword (loc_0230E396 + 1) - (P4_SwitchTargetPC_0230E2C0 + 4)
	.halfword (loc_0230E45A + 1) - (P4_SwitchTargetPC_0230E2C0 + 4)
	.halfword (loc_0230E34E + 1) - (P4_SwitchTargetPC_0230E2C0 + 4)
	.halfword (loc_0230E408 + 1) - (P4_SwitchTargetPC_0230E2C0 + 4)
	.halfword (loc_0230E3F2 + 1) - (P4_SwitchTargetPC_0230E2C0 + 4)
P4_SwitchTable_0230E2C0End:
loc_0230E2DA:
	cmp r7,#0xdd	; 0230E2DA
	bne loc_0230E2E0	; 0230E2DC
	b loc_0230E41E	; 0230E2DE
loc_0230E2E0:
	b loc_0230E45A	; 0230E2E0
loc_0230E2E2:
	cmp r6,#0x20	; 0230E2E2
	bhi loc_0230E33C	; 0230E2E4
	add r2,r4,#0x0	; 0230E2E6
	add r2,#0xc	; 0230E2E8
	ldrh r1,[r2,#0x0]	; 0230E2EA
	mov r0,#0x1	; 0230E2EC
	orr r1,r0	; 0230E2EE
	strh r1,[r2,#0x0]	; 0230E2F0
	sub r0,r5,#0x2	; 0230E2F2
	str r0,[r4,#0x18]	; 0230E2F4
	cmp r6,#0x0	; 0230E2F6
	bne loc_0230E312	; 0230E2F8
	ldrh r1,[r4,#0xc]	; 0230E2FA
	ldr r0,[pool_0230E4F4]	; 0230E2FC
	and r1,r0	; 0230E2FE
	cmp r1,#0x0	; 0230E300
	beq loc_0230E312	; 0230E302
	add r2,r4,#0x0	; 0230E304
	add r2,#0xa	; 0230E306
	ldrh r1,[r2,#0x0]	; 0230E308
	mov r0,#0x1	; 0230E30A
	orr r1,r0	; 0230E30C
	strh r1,[r2,#0x0]	; 0230E30E
	b loc_0230E45A	; 0230E310
loc_0230E312:
	add r2,r4,#0x0	; 0230E312
	add r2,#0xa	; 0230E314
	ldrh r1,[r2,#0x0]	; 0230E316
	mov r0,#0x1	; 0230E318
	bic r1,r0	; 0230E31A
	strh r1,[r2,#0x0]	; 0230E31C
	lsl r0,r6,#0x10	; 0230E31E
	lsr r0,r0,#0x10	; 0230E320
	add r1,r5,#0x0	; 0230E322
	bl loc_023060E8	; 0230E324
	cmp r0,#0x0	; 0230E328
	bne loc_0230E32E	; 0230E32A
	b loc_0230E45A	; 0230E32C
loc_0230E32E:
	add r2,r4,#0x0	; 0230E32E
	add r2,#0xa	; 0230E330
	ldrh r1,[r2,#0x0]	; 0230E332
	mov r0,#0x1	; 0230E334
	orr r1,r0	; 0230E336
	strh r1,[r2,#0x0]	; 0230E338
	b loc_0230E45A	; 0230E33A
loc_0230E33C:
	add r2,r4,#0x0	; 0230E33C
	add r2,#0xc	; 0230E33E
	ldrh r1,[r2,#0x0]	; 0230E340
	mov r0,#0x1	; 0230E342
	bic r1,r0	; 0230E344
	strh r1,[r2,#0x0]	; 0230E346
	mov r0,#0x0	; 0230E348
	str r0,[r4,#0x18]	; 0230E34A
	b loc_0230E45A	; 0230E34C
loc_0230E34E:
	cmp r6,#0x1	; 0230E34E
	bcs loc_0230E354	; 0230E350
	b loc_0230E45A	; 0230E352
loc_0230E354:
	add r2,r4,#0x0	; 0230E354
	add r2,#0xc	; 0230E356
	ldrh r1,[r2,#0x0]	; 0230E358
	mov r0,#0x2	; 0230E35A
	orr r1,r0	; 0230E35C
	strh r1,[r2,#0x0]	; 0230E35E
	add r0,r5,#0x0	; 0230E360
	bl loc_023053B8	; 0230E362
	strh r0,[r4,#0x12]	; 0230E366
	ldrh r0,[r4,#0x12]	; 0230E368
	ldr r1,[pool_0230E4EC]	; 0230E36A
	ldr r2,[r1,#0x0]	; 0230E36C
	ldr r1,[pool_0230E4F8]	; 0230E36E
	ldr r1,[r2,r1]	; 0230E370
	add r1,#0x4a	; 0230E372
	ldrh r1,[r1,#0x0]	; 0230E374
	cmp r0,r1	; 0230E376
	bne loc_0230E388	; 0230E378
	add r2,r4,#0x0	; 0230E37A
	add r2,#0xa	; 0230E37C
	ldrh r1,[r2,#0x0]	; 0230E37E
	mov r0,#0x2	; 0230E380
	orr r1,r0	; 0230E382
	strh r1,[r2,#0x0]	; 0230E384
	b loc_0230E45A	; 0230E386
loc_0230E388:
	add r2,r4,#0x0	; 0230E388
	add r2,#0xa	; 0230E38A
	ldrh r1,[r2,#0x0]	; 0230E38C
	mov r0,#0x2	; 0230E38E
	bic r1,r0	; 0230E390
	strh r1,[r2,#0x0]	; 0230E392
	b loc_0230E45A	; 0230E394
loc_0230E396:
	cmp r6,#0x1	; 0230E396
	bcc loc_0230E45A	; 0230E398
	add r2,r4,#0x0	; 0230E39A
	add r2,#0xc	; 0230E39C
	ldrh r1,[r2,#0x0]	; 0230E39E
	mov r0,#0x4	; 0230E3A0
	orr r1,r0	; 0230E3A2
	strh r1,[r2,#0x0]	; 0230E3A4
	sub r0,r5,#0x2	; 0230E3A6
	add r1,r4,#0x0	; 0230E3A8
	add r1,#0x14	; 0230E3AA
	bl loc_02306064	; 0230E3AC
	ldr r0,[pool_0230E4EC]	; 0230E3B0
	ldr r3,[r0,#0x0]	; 0230E3B2
	ldrh r2,[r4,#0x14]	; 0230E3B4
	ldr r0,[pool_0230E4FC]	; 0230E3B6
	ldrh r1,[r3,r0]	; 0230E3B8
	ldr r0,[pool_0230E500]	; 0230E3BA
	ldrh r0,[r3,r0]	; 0230E3BC
	add r3,r1,#0x0	; 0230E3BE
	orr r3,r0	; 0230E3C0
	add r0,r2,#0x0	; 0230E3C2
	bic r0,r3	; 0230E3C4
	cmp r0,#0x0	; 0230E3C6
	bne loc_0230E3E4	; 0230E3C8
	ldrh r0,[r4,#0x16]	; 0230E3CA
	orr r2,r0	; 0230E3CC
	add r0,r1,#0x0	; 0230E3CE
	and r0,r2	; 0230E3D0
	cmp r1,r0	; 0230E3D2
	bne loc_0230E3E4	; 0230E3D4
	add r2,r4,#0x0	; 0230E3D6
	add r2,#0xa	; 0230E3D8
	ldrh r1,[r2,#0x0]	; 0230E3DA
	mov r0,#0x4	; 0230E3DC
	orr r1,r0	; 0230E3DE
	strh r1,[r2,#0x0]	; 0230E3E0
	b loc_0230E45A	; 0230E3E2
loc_0230E3E4:
	add r2,r4,#0x0	; 0230E3E4
	add r2,#0xa	; 0230E3E6
	ldrh r1,[r2,#0x0]	; 0230E3E8
	mov r0,#0x4	; 0230E3EA
	bic r1,r0	; 0230E3EC
	strh r1,[r2,#0x0]	; 0230E3EE
	b loc_0230E45A	; 0230E3F0
loc_0230E3F2:
	cmp r6,#0x3	; 0230E3F2
	bcc loc_0230E45A	; 0230E3F4
	add r2,r4,#0x0	; 0230E3F6
	add r2,#0xc	; 0230E3F8
	ldrh r1,[r2,#0x0]	; 0230E3FA
	ldr r0,[pool_0230E504]	; 0230E3FC
	orr r1,r0	; 0230E3FE
	strh r1,[r2,#0x0]	; 0230E400
	sub r0,r5,#0x2	; 0230E402
	str r0,[r4,#0x20]	; 0230E404
	b loc_0230E45A	; 0230E406
loc_0230E408:
	cmp r6,#0x6	; 0230E408
	bcc loc_0230E45A	; 0230E40A
	add r2,r4,#0x0	; 0230E40C
	add r2,#0xc	; 0230E40E
	ldrh r1,[r2,#0x0]	; 0230E410
	ldr r0,[pool_0230E508]	; 0230E412
	orr r1,r0	; 0230E414
	strh r1,[r2,#0x0]	; 0230E416
	sub r0,r5,#0x2	; 0230E418
	str r0,[r4,#0x1c]	; 0230E41A
	b loc_0230E45A	; 0230E41C
loc_0230E41E:
	cmp r6,#0x8	; 0230E41E
	bcc loc_0230E45A	; 0230E420
	add r0,r5,#0x0	; 0230E422
	bl loc_023053B8	; 0230E424
	cmp r0,#0x0	; 0230E428
	bne loc_0230E45A	; 0230E42A
	add r0,r5,#0x1	; 0230E42C
	bl loc_023053B8	; 0230E42E
	cmp r0,#0x9	; 0230E432
	bne loc_0230E45A	; 0230E434
	add r0,r5,#0x2	; 0230E436
	bl loc_023053B8	; 0230E438
	cmp r0,#0xbf	; 0230E43C
	bne loc_0230E45A	; 0230E43E
	add r0,r5,#0x3	; 0230E440
	bl loc_023053B8	; 0230E442
	cmp r0,#0x0	; 0230E446
	bne loc_0230E45A	; 0230E448
	add r2,r4,#0x0	; 0230E44A
	add r2,#0xc	; 0230E44C
	ldrh r1,[r2,#0x0]	; 0230E44E
	ldr r0,[pool_0230E50C]	; 0230E450
	orr r1,r0	; 0230E452
	strh r1,[r2,#0x0]	; 0230E454
	sub r0,r5,#0x2	; 0230E456
	str r0,[r4,#0x24]	; 0230E458
loc_0230E45A:
	add r5,r5,r6	; 0230E45A
	add r1,r6,#0x2	; 0230E45C
	ldr r0,[sp,#0x0]	; 0230E45E
	sub r0,r0,r1	; 0230E460
	str r0,[sp,#0x0]	; 0230E462
loc_0230E464:
	ldr r0,[sp,#0x0]	; 0230E464
	cmp r0,#0x0	; 0230E466
	ble loc_0230E46C	; 0230E468
	b loc_0230E2AA	; 0230E46A
loc_0230E46C:
	ldrh r1,[r4,#0xc]	; 0230E46C
	mov r0,#0x8	; 0230E46E
	and r1,r0	; 0230E470
	cmp r1,#0x0	; 0230E472
	beq loc_0230E49C	; 0230E474
	ldr r0,[pool_0230E4EC]	; 0230E476
	ldr r1,[r0,#0x0]	; 0230E478
	ldr r0,[pool_0230E510]	; 0230E47A
	ldrh r1,[r1,r0]	; 0230E47C
	mov r0,#0x1	; 0230E47E
	and r1,r0	; 0230E480
	cmp r1,#0x0	; 0230E482
	bne loc_0230E490	; 0230E484
	ldrh r1,[r4,#0x4]	; 0230E486
	ldr r0,[pool_0230E514]	; 0230E488
	and r1,r0	; 0230E48A
	cmp r1,#0x0	; 0230E48C
	beq loc_0230E49C	; 0230E48E
loc_0230E490:
	add r2,r4,#0x0	; 0230E490
	add r2,#0xa	; 0230E492
	ldrh r1,[r2,#0x0]	; 0230E494
	mov r0,#0x8	; 0230E496
	orr r1,r0	; 0230E498
	strh r1,[r2,#0x0]	; 0230E49A
loc_0230E49C:
	ldrh r1,[r4,#0xc]	; 0230E49C
	mov r0,#0x30	; 0230E49E
	and r1,r0	; 0230E4A0
	cmp r1,#0x0	; 0230E4A2
	beq loc_0230E4E4	; 0230E4A4
	ldrh r3,[r4,#0x6]	; 0230E4A6
	mov r1,#0x3	; 0230E4A8
	and r3,r1	; 0230E4AA
	ldr r0,[pool_0230E4EC]	; 0230E4AC
	ldr r2,[r0,#0x0]	; 0230E4AE
	ldr r0,[pool_0230E518]	; 0230E4B0
	ldrh r0,[r2,r0]	; 0230E4B2
	and r0,r1	; 0230E4B4
	cmp r3,r0	; 0230E4B6
	bne loc_0230E4C6	; 0230E4B8
	add r2,r4,#0x0	; 0230E4BA
	add r2,#0xa	; 0230E4BC
	ldrh r1,[r2,#0x0]	; 0230E4BE
	mov r0,#0x10	; 0230E4C0
	orr r1,r0	; 0230E4C2
	strh r1,[r2,#0x0]	; 0230E4C4
loc_0230E4C6:
	ldrh r3,[r4,#0x6]	; 0230E4C6
	mov r1,#0x10	; 0230E4C8
	and r3,r1	; 0230E4CA
	ldr r0,[pool_0230E4EC]	; 0230E4CC
	ldr r2,[r0,#0x0]	; 0230E4CE
	ldr r0,[pool_0230E518]	; 0230E4D0
	ldrh r0,[r2,r0]	; 0230E4D2
	and r0,r1	; 0230E4D4
	cmp r3,r0	; 0230E4D6
	bne loc_0230E4E4	; 0230E4D8
	add r4,#0xa	; 0230E4DA
	ldrh r1,[r4,#0x0]	; 0230E4DC
	mov r0,#0x20	; 0230E4DE
	orr r1,r0	; 0230E4E0
	strh r1,[r4,#0x0]	; 0230E4E2
loc_0230E4E4:
	add sp,#0x4	; 0230E4E4
	pop {r4,r5,r6,r7}	; 0230E4E6
	pop {r3}	; 0230E4E8
	bx r3	; 0230E4EA
pool_0230E4EC:
loc_0230E4EC:
	.word FirmwareWlWorkPointerSlot	; 0230E4EC
pool_0230E4F0:
loc_0230E4F0:
	.word 0x00000376	; 0230E4F0
pool_0230E4F4:
loc_0230E4F4:
	.word 0x00000800	; 0230E4F4
pool_0230E4F8:
loc_0230E4F8:
	.word 0x000003D4	; 0230E4F8
pool_0230E4FC:
loc_0230E4FC:
	.word 0x0000035C	; 0230E4FC
pool_0230E500:
loc_0230E500:
	.word 0x0000035E	; 0230E500
pool_0230E504:
loc_0230E504:
	.word 0x00000100	; 0230E504
pool_0230E508:
loc_0230E508:
	.word 0x00000200	; 0230E508
pool_0230E50C:
loc_0230E50C:
	.word 0x00000400	; 0230E50C
pool_0230E510:
loc_0230E510:
	.word 0x00000360	; 0230E510
pool_0230E514:
loc_0230E514:
	.word 0x00008000	; 0230E514
pool_0230E518:
loc_0230E518:
	.word 0x00000378	; 0230E518

; ===== function loc_0230E51C =====
loc_0230E51C:
	bx lr	; 0230E51C
	.byte 0x00, 0x00	; 0230E520

; ===== function loc_0230E520 =====
loc_0230E520:
	push {r4,r5,lr}	; 0230E520
	sub sp,#0x4	; 0230E522
	ldrh r2,[r0,#0x2]	; 0230E524
	ldr r1,[pool_0230E574]	; 0230E526
	ldr r0,[r1,#0x0]	; 0230E528
	ldr r3,[pool_0230E578]	; 0230E52A
	ldr r5,[r0,r3]	; 0230E52C
	mov r3,#0x1c	; 0230E52E
	add r4,r2,#0x0	; 0230E530
	mul r4,r3	; 0230E532
	ldrh r3,[r5,r4]	; 0230E534
	cmp r3,#0x40	; 0230E536
	bne loc_0230E56A	; 0230E538
	ldr r3,[pool_0230E57C]	; 0230E53A
	add r5,r0,r3	; 0230E53C
	ldrh r4,[r5,#0x0]	; 0230E53E
	mov r0,#0x1	; 0230E540
	add r3,r0,#0x0	; 0230E542
	lsl r3,r2	; 0230E544
	orr r4,r3	; 0230E546
	strh r4,[r5,#0x0]	; 0230E548
	ldr r2,[r1,#0x0]	; 0230E54A
	ldr r1,[pool_0230E580]	; 0230E54C
	ldrh r1,[r2,r1]	; 0230E54E
	cmp r1,#0x0	; 0230E550
	beq loc_0230E558	; 0230E552
	bl loc_0230D674	; 0230E554
loc_0230E558:
	ldr r0,[pool_0230E574]	; 0230E558
	ldr r1,[r0,#0x0]	; 0230E55A
	ldr r0,[pool_0230E584]	; 0230E55C
	ldrh r0,[r1,r0]	; 0230E55E
	cmp r0,#0x0	; 0230E560
	beq loc_0230E56A	; 0230E562
	mov r0,#0x0	; 0230E564
	bl loc_0230D674	; 0230E566
loc_0230E56A:
	add sp,#0x4	; 0230E56A
	pop {r4,r5}	; 0230E56C
	pop {r3}	; 0230E56E
	bx r3	; 0230E570
	.byte 0xC0, 0x46	; 0230E574
pool_0230E574:
loc_0230E574:
	.word FirmwareWlWorkPointerSlot	; 0230E574
pool_0230E578:
loc_0230E578:
	.word 0x000002E0	; 0230E578
pool_0230E57C:
loc_0230E57C:
	.word 0x000004EC	; 0230E57C
pool_0230E580:
loc_0230E580:
	.word 0x0000016C	; 0230E580
pool_0230E584:
loc_0230E584:
	.word 0x00000160	; 0230E584

; ===== function loc_0230E588 =====
loc_0230E588:
	push {r4,r5,lr}	; 0230E588
	sub sp,#0x4	; 0230E58A
	add r5,r0,#0x0	; 0230E58C
	ldrh r4,[r5,#0x2]	; 0230E58E
	ldr r0,[pool_0230E614]	; 0230E590
	ldr r0,[r0,#0x0]	; 0230E592
	ldr r1,[pool_0230E618]	; 0230E594
	ldrh r1,[r0,r1]	; 0230E596
	cmp r1,#0x1	; 0230E598
	beq loc_0230E5A6	; 0230E59A
	cmp r1,#0x2	; 0230E59C
	beq loc_0230E5D2	; 0230E59E
	cmp r1,#0x3	; 0230E5A0
	beq loc_0230E5D2	; 0230E5A2
	b loc_0230E60C	; 0230E5A4
loc_0230E5A6:
	ldr r1,[pool_0230E61C]	; 0230E5A6
	ldr r2,[r0,r1]	; 0230E5A8
	mov r0,#0x1c	; 0230E5AA
	add r1,r4,#0x0	; 0230E5AC
	mul r1,r0	; 0230E5AE
	ldrh r0,[r2,r1]	; 0230E5B0
	cmp r0,#0x20	; 0230E5B2
	bls loc_0230E60C	; 0230E5B4
	lsl r0,r4,#0x10	; 0230E5B6
	lsr r0,r0,#0x10	; 0230E5B8
	mov r1,#0x20	; 0230E5BA
	bl loc_023091F0	; 0230E5BC
	add r0,r5,#0x0	; 0230E5C0
	add r0,#0x1e	; 0230E5C2
	ldrh r1,[r5,#0x2c]	; 0230E5C4
	bl loc_02309B6C	; 0230E5C6
	add r0,r4,#0x0	; 0230E5CA
	bl loc_0230CC80	; 0230E5CC
	b loc_0230E60C	; 0230E5D0
loc_0230E5D2:
	ldr r1,[pool_0230E620]	; 0230E5D2
	ldrh r1,[r0,r1]	; 0230E5D4
	cmp r1,#0x20	; 0230E5D6
	bls loc_0230E60C	; 0230E5D8
	ldrh r2,[r5,#0x22]	; 0230E5DA
	ldr r1,[pool_0230E624]	; 0230E5DC
	ldrh r1,[r0,r1]	; 0230E5DE
	cmp r2,r1	; 0230E5E0
	bne loc_0230E60C	; 0230E5E2
	ldrh r2,[r5,#0x20]	; 0230E5E4
	ldr r1,[pool_0230E628]	; 0230E5E6
	ldrh r1,[r0,r1]	; 0230E5E8
	cmp r2,r1	; 0230E5EA
	bne loc_0230E60C	; 0230E5EC
	ldrh r2,[r5,#0x1e]	; 0230E5EE
	ldr r1,[pool_0230E62C]	; 0230E5F0
	ldrh r0,[r0,r1]	; 0230E5F2
	cmp r2,r0	; 0230E5F4
	bne loc_0230E60C	; 0230E5F6
	mov r0,#0x20	; 0230E5F8
	bl loc_0230646C	; 0230E5FA
	bl loc_023064D8	; 0230E5FE
	add r0,r5,#0x0	; 0230E602
	add r0,#0x1e	; 0230E604
	ldrh r1,[r5,#0x2c]	; 0230E606
	bl loc_02309B6C	; 0230E608
loc_0230E60C:
	add sp,#0x4	; 0230E60C
	pop {r4,r5}	; 0230E60E
	pop {r3}	; 0230E610
	bx r3	; 0230E612
pool_0230E614:
loc_0230E614:
	.word FirmwareWlWorkPointerSlot	; 0230E614
pool_0230E618:
loc_0230E618:
	.word 0x00000314	; 0230E618
pool_0230E61C:
loc_0230E61C:
	.word 0x000002E0	; 0230E61C
pool_0230E620:
loc_0230E620:
	.word 0x00000310	; 0230E620
pool_0230E624:
loc_0230E624:
	.word 0x00000382	; 0230E624
pool_0230E628:
loc_0230E628:
	.word 0x00000380	; 0230E628
pool_0230E62C:
loc_0230E62C:
	.word 0x0000037E	; 0230E62C

; ===== function loc_0230E630 =====
loc_0230E630:
	push {r4,r5,r6,r7,lr}	; 0230E630
	sub sp,#0x14	; 0230E632
	add r5,r0,#0x0	; 0230E634
	add r4,r5,#0x0	; 0230E636
	add r4,#0x2c	; 0230E638
	ldr r0,[pool_0230E980]	; 0230E63A
	ldr r0,[r0,#0x0]	; 0230E63C
	ldr r1,[pool_0230E984]	; 0230E63E
	ldrh r2,[r0,r1]	; 0230E640
	mov r1,#0x8	; 0230E642
	and r2,r1	; 0230E644
	cmp r2,#0x0	; 0230E646
	beq loc_0230E69E	; 0230E648
	ldr r1,[pool_0230E988]	; 0230E64A
	add r1,r0,r1	; 0230E64C
	ldr r0,[pool_0230E98C]	; 0230E64E
	ldrh r0,[r0,#0x0]	; 0230E650
	mov r2,#0x1	; 0230E652
	add r3,r0,#0x0	; 0230E654
	and r3,r2	; 0230E656
	cmp r3,#0x0	; 0230E658
	beq loc_0230E662	; 0230E65A
	ldrh r2,[r1,#0x0]	; 0230E65C
	cmp r2,#0x0	; 0230E65E
	bne loc_0230E69E	; 0230E660
loc_0230E662:
	mov r2,#0x4	; 0230E662
	add r3,r0,#0x0	; 0230E664
	and r3,r2	; 0230E666
	cmp r3,#0x0	; 0230E668
	beq loc_0230E672	; 0230E66A
	ldrh r2,[r1,#0x14]	; 0230E66C
	cmp r2,#0x0	; 0230E66E
	bne loc_0230E69E	; 0230E670
loc_0230E672:
	mov r2,#0x8	; 0230E672
	and r0,r2	; 0230E674
	cmp r0,#0x0	; 0230E676
	beq loc_0230E680	; 0230E678
	ldrh r0,[r1,#0x28]	; 0230E67A
	cmp r0,#0x0	; 0230E67C
	bne loc_0230E69E	; 0230E67E
loc_0230E680:
	ldr r0,[pool_0230E990]	; 0230E680
	ldrh r1,[r0,#0x0]	; 0230E682
	mov r0,#0x1	; 0230E684
	and r1,r0	; 0230E686
	cmp r1,#0x0	; 0230E688
	bne loc_0230E69E	; 0230E68A
	mov r0,#0x0	; 0230E68C
	ldr r2,[pool_0230E994]	; 0230E68E
	strh r0,[r2,#0x0]	; 0230E690
	ldr r1,[pool_0230E998]	; 0230E692
	strh r1,[r2,#0x0]	; 0230E694
	ldr r1,[pool_0230E980]	; 0230E696
	ldr r2,[r1,#0x0]	; 0230E698
	ldr r1,[pool_0230E99C]	; 0230E69A
	strh r0,[r2,r1]	; 0230E69C
loc_0230E69E:
	mov r0,#0x0	; 0230E69E
	str r0,[sp,#0x0]	; 0230E6A0
	ldrh r0,[r4,#0x2]	; 0230E6A2
	add r0,r0,#0x1	; 0230E6A4
	lsl r0,r0,#0x10	; 0230E6A6
	lsr r0,r0,#0x10	; 0230E6A8
	str r0,[sp,#0x4]	; 0230E6AA
	ldrh r6,[r5,#0x2]	; 0230E6AC
	cmp r6,#0x0	; 0230E6AE
	bne loc_0230E6BA	; 0230E6B0
	mov r7,#0x13	; 0230E6B2
	mov r0,#0x1	; 0230E6B4
	str r0,[sp,#0x0]	; 0230E6B6
	b loc_0230EA2A	; 0230E6B8
loc_0230E6BA:
	ldr r0,[pool_0230E980]	; 0230E6BA
	ldr r0,[r0,#0x0]	; 0230E6BC
	ldr r1,[pool_0230E9A0]	; 0230E6BE
	ldrh r1,[r0,r1]	; 0230E6C0
	cmp r1,#0x1	; 0230E6C2
	bne loc_0230E726	; 0230E6C4
	mov r2,#0x1c	; 0230E6C6
	add r1,r6,#0x0	; 0230E6C8
	str r1,[sp,#0x8]	; 0230E6CA
	mul r1,r2	; 0230E6CC
	str r1,[sp,#0x8]	; 0230E6CE
	ldr r1,[pool_0230E9A4]	; 0230E6D0
	ldr r1,[r0,r1]	; 0230E6D2
	ldr r0,[sp,#0x8]	; 0230E6D4
	ldrh r0,[r1,r0]	; 0230E6D6
	cmp r0,#0x20	; 0230E6D8
	bls loc_0230E6F0	; 0230E6DA
	lsl r0,r6,#0x10	; 0230E6DC
	lsr r0,r0,#0x10	; 0230E6DE
	mov r1,#0x20	; 0230E6E0
	bl loc_023091F0	; 0230E6E2
	add r0,r5,#0x0	; 0230E6E6
	add r0,#0x1e	; 0230E6E8
	mov r1,#0x1	; 0230E6EA
	bl loc_02309B6C	; 0230E6EC
loc_0230E6F0:
	ldrh r1,[r5,#0x8]	; 0230E6F0
	ldr r0,[pool_0230E9A8]	; 0230E6F2
	and r1,r0	; 0230E6F4
	cmp r1,#0x0	; 0230E6F6
	beq loc_0230E726	; 0230E6F8
	ldr r2,[pool_0230E980]	; 0230E6FA
	ldr r0,[r2,#0x0]	; 0230E6FC
	ldr r3,[pool_0230E9A4]	; 0230E6FE
	ldr r1,[r0,r3]	; 0230E700
	ldr r0,[sp,#0x8]	; 0230E702
	add r0,r1,r0	; 0230E704
	ldrh r0,[r0,#0xe]	; 0230E706
	cmp r0,#0x0	; 0230E708
	beq loc_0230E726	; 0230E70A
	mov r0,#0x1	; 0230E70C
	str r0,[sp,#0x0]	; 0230E70E
	strh r0,[r4,#0x0]	; 0230E710
	mov r7,#0xf	; 0230E712
	mov r0,#0x4	; 0230E714
	str r0,[sp,#0x4]	; 0230E716
	mov r0,#0x0	; 0230E718
	ldr r1,[r2,#0x0]	; 0230E71A
	ldr r2,[r1,r3]	; 0230E71C
	ldr r1,[sp,#0x8]	; 0230E71E
	add r1,r2,r1	; 0230E720
	strh r0,[r1,#0xe]	; 0230E722
	b loc_0230EA2A	; 0230E724
loc_0230E726:
	ldrh r0,[r4,#0x0]	; 0230E726
	cmp r0,#0x0	; 0230E728
	beq loc_0230E732	; 0230E72A
	cmp r0,#0x1	; 0230E72C
	beq loc_0230E7FA	; 0230E72E
	b loc_0230EA18	; 0230E730
loc_0230E732:
	ldr r0,[pool_0230E980]	; 0230E732
	ldr r1,[r0,#0x0]	; 0230E734
	ldr r0,[pool_0230E9A0]	; 0230E736
	ldrh r2,[r1,r0]	; 0230E738
	cmp r2,#0x1	; 0230E73A
	bne loc_0230E74E	; 0230E73C
	ldr r0,[pool_0230E9AC]	; 0230E73E
	ldrh r0,[r1,r0]	; 0230E740
	cmp r0,#0x1	; 0230E742
	bne loc_0230E74E	; 0230E744
	mov r7,#0xd	; 0230E746
	mov r0,#0x1	; 0230E748
	str r0,[sp,#0x0]	; 0230E74A
	b loc_0230EA2A	; 0230E74C
loc_0230E74E:
	cmp r2,#0x1	; 0230E74E
	bne loc_0230E76C	; 0230E750
	ldrh r0,[r4,#0x2]	; 0230E752
	cmp r0,#0x1	; 0230E754
	bne loc_0230E760	; 0230E756
	mov r7,#0x0	; 0230E758
	mov r0,#0x1	; 0230E75A
	str r0,[sp,#0x0]	; 0230E75C
	b loc_0230EA2A	; 0230E75E
loc_0230E760:
	mov r7,#0xe	; 0230E760
	mov r0,#0x2	; 0230E762
	str r0,[sp,#0x4]	; 0230E764
	mov r0,#0x1	; 0230E766
	str r0,[sp,#0x0]	; 0230E768
	b loc_0230EA2A	; 0230E76A
loc_0230E76C:
	cmp r2,#0x1	; 0230E76C
	bne loc_0230E772	; 0230E76E
	b loc_0230EA2A	; 0230E770
loc_0230E772:
	ldrh r0,[r4,#0x2]	; 0230E772
	cmp r0,#0x2	; 0230E774
	beq loc_0230E77A	; 0230E776
	b loc_0230EA2A	; 0230E778
loc_0230E77A:
	ldr r0,[pool_0230E9B0]	; 0230E77A
	ldr r0,[r1,r0]	; 0230E77C
	ldrh r2,[r0,#0x16]	; 0230E77E
	cmp r2,#0x0	; 0230E780
	beq loc_0230E786	; 0230E782
	b loc_0230EA2A	; 0230E784
loc_0230E786:
	ldrh r3,[r0,#0x14]	; 0230E786
	ldrh r2,[r5,#0x22]	; 0230E788
	cmp r3,r2	; 0230E78A
	beq loc_0230E790	; 0230E78C
	b loc_0230EA2A	; 0230E78E
loc_0230E790:
	ldrh r3,[r0,#0x12]	; 0230E790
	ldrh r2,[r5,#0x20]	; 0230E792
	cmp r3,r2	; 0230E794
	beq loc_0230E79A	; 0230E796
	b loc_0230EA2A	; 0230E798
loc_0230E79A:
	ldrh r2,[r0,#0x10]	; 0230E79A
	ldrh r0,[r5,#0x1e]	; 0230E79C
	cmp r2,r0	; 0230E79E
	beq loc_0230E7A4	; 0230E7A0
	b loc_0230EA2A	; 0230E7A2
loc_0230E7A4:
	ldr r0,[pool_0230E9B4]	; 0230E7A4
	ldrh r0,[r1,r0]	; 0230E7A6
	cmp r0,#0x31	; 0230E7A8
	beq loc_0230E7AE	; 0230E7AA
	b loc_0230EA2A	; 0230E7AC
loc_0230E7AE:
	bl loc_02305590	; 0230E7AE
	ldrh r0,[r4,#0x4]	; 0230E7B2
	cmp r0,#0x0	; 0230E7B4
	bne loc_0230E7D2	; 0230E7B6
	mov r0,#0x30	; 0230E7B8
	bl loc_0230646C	; 0230E7BA
	mov r1,#0x0	; 0230E7BE
	ldr r0,[pool_0230E980]	; 0230E7C0
	ldr r3,[r0,#0x0]	; 0230E7C2
	ldr r2,[pool_0230E9B8]	; 0230E7C4
	ldr r3,[r3,r2]	; 0230E7C6
	strh r1,[r3,#0x4]	; 0230E7C8
	ldr r0,[r0,#0x0]	; 0230E7CA
	ldr r0,[r0,r2]	; 0230E7CC
	strh r1,[r0,#0x6]	; 0230E7CE
	b loc_0230E7E6	; 0230E7D0
loc_0230E7D2:
	mov r0,#0xc	; 0230E7D2
	ldr r1,[pool_0230E980]	; 0230E7D4
	ldr r3,[r1,#0x0]	; 0230E7D6
	ldr r2,[pool_0230E9B8]	; 0230E7D8
	ldr r3,[r3,r2]	; 0230E7DA
	strh r0,[r3,#0x4]	; 0230E7DC
	ldrh r0,[r4,#0x4]	; 0230E7DE
	ldr r1,[r1,#0x0]	; 0230E7E0
	ldr r1,[r1,r2]	; 0230E7E2
	strh r0,[r1,#0x6]	; 0230E7E4
loc_0230E7E6:
	mov r2,#0x35	; 0230E7E6
	ldr r0,[pool_0230E980]	; 0230E7E8
	ldr r1,[r0,#0x0]	; 0230E7EA
	ldr r0,[pool_0230E9B4]	; 0230E7EC
	strh r2,[r1,r0]	; 0230E7EE
	mov r0,#0x2	; 0230E7F0
	add r1,r0,#0x0	; 0230E7F2
	bl loc_02304B6C	; 0230E7F4
	b loc_0230EA2A	; 0230E7F8
loc_0230E7FA:
	ldr r0,[pool_0230E980]	; 0230E7FA
	ldr r1,[r0,#0x0]	; 0230E7FC
	ldr r0,[pool_0230E9A0]	; 0230E7FE
	ldrh r0,[r1,r0]	; 0230E800
	cmp r0,#0x1	; 0230E802
	bne loc_0230E8BA	; 0230E804
	lsl r0,r6,#0x10	; 0230E806
	lsr r0,r0,#0x10	; 0230E808
	mov r1,#0x20	; 0230E80A
	bl loc_023091F0	; 0230E80C
	ldrh r0,[r4,#0x2]	; 0230E810
	cmp r0,#0x1	; 0230E812
	bne loc_0230E844	; 0230E814
	add r0,r5,#0x0	; 0230E816
	add r0,#0x1e	; 0230E818
	mov r1,#0x80	; 0230E81A
	bl loc_0230C0D4	; 0230E81C
	str r0,[sp,#0xc]	; 0230E820
	cmp r0,#0x0	; 0230E822
	bne loc_0230E828	; 0230E824
	b loc_0230EA2A	; 0230E826
loc_0230E828:
	ldrh r1,[r4,#0x0]	; 0230E828
	strh r1,[r0,#0x2c]	; 0230E82A
	ldr r1,[sp,#0x4]	; 0230E82C
	strh r1,[r0,#0x2e]	; 0230E82E
	mov r1,#0x0	; 0230E830
	strh r1,[r0,#0x30]	; 0230E832
	add r0,r6,#0x0	; 0230E834
	ldr r1,[sp,#0xc]	; 0230E836
	bl loc_0230DF74	; 0230E838
	ldr r0,[sp,#0xc]	; 0230E83C
	bl loc_0230CAF0	; 0230E83E
	b loc_0230EA2A	; 0230E842
loc_0230E844:
	cmp r0,#0x3	; 0230E844
	bne loc_0230E89C	; 0230E846
	mov r0,#0x1c	; 0230E848
	mul r6,r0	; 0230E84A
	ldr r0,[pool_0230E980]	; 0230E84C
	ldr r1,[r0,#0x0]	; 0230E84E
	ldr r0,[pool_0230E9A4]	; 0230E850
	ldr r1,[r1,r0]	; 0230E852
	ldrh r0,[r1,r6]	; 0230E854
	cmp r0,#0x20	; 0230E856
	bne loc_0230E862	; 0230E858
	add r0,r1,r6	; 0230E85A
	ldrh r0,[r0,#0xe]	; 0230E85C
	cmp r0,#0x0	; 0230E85E
	bne loc_0230E868	; 0230E860
loc_0230E862:
	mov r7,#0x1	; 0230E862
	str r7,[sp,#0x0]	; 0230E864
	b loc_0230EA2A	; 0230E866
loc_0230E868:
	add r0,r5,#0x0	; 0230E868
	bl loc_0230DF00	; 0230E86A
	cmp r0,#0x0	; 0230E86E
	bne loc_0230E888	; 0230E870
	mov r7,#0xf	; 0230E872
	mov r0,#0x1	; 0230E874
	str r0,[sp,#0x0]	; 0230E876
	mov r0,#0x0	; 0230E878
	ldr r1,[pool_0230E980]	; 0230E87A
	ldr r2,[r1,#0x0]	; 0230E87C
	ldr r1,[pool_0230E9A4]	; 0230E87E
	ldr r1,[r2,r1]	; 0230E880
	add r1,r1,r6	; 0230E882
	strh r0,[r1,#0xe]	; 0230E884
	b loc_0230EA2A	; 0230E886
loc_0230E888:
	mov r7,#0x0	; 0230E888
	ldr r0,[pool_0230E980]	; 0230E88A
	ldr r1,[r0,#0x0]	; 0230E88C
	ldr r0,[pool_0230E9A4]	; 0230E88E
	ldr r0,[r1,r0]	; 0230E890
	add r0,r0,r6	; 0230E892
	strh r7,[r0,#0xe]	; 0230E894
	mov r0,#0x1	; 0230E896
	str r0,[sp,#0x0]	; 0230E898
	b loc_0230EA2A	; 0230E89A
loc_0230E89C:
	mov r0,#0x0	; 0230E89C
	ldr r1,[pool_0230E980]	; 0230E89E
	ldr r2,[r1,#0x0]	; 0230E8A0
	ldr r1,[pool_0230E9A4]	; 0230E8A2
	ldr r2,[r2,r1]	; 0230E8A4
	mov r1,#0x1c	; 0230E8A6
	mul r6,r1	; 0230E8A8
	add r1,r2,r6	; 0230E8AA
	strh r0,[r1,#0xe]	; 0230E8AC
	mov r7,#0xe	; 0230E8AE
	mov r0,#0x2	; 0230E8B0
	str r0,[sp,#0x4]	; 0230E8B2
	mov r0,#0x1	; 0230E8B4
	str r0,[sp,#0x0]	; 0230E8B6
	b loc_0230EA2A	; 0230E8B8
loc_0230E8BA:
	ldr r0,[pool_0230E9B0]	; 0230E8BA
	ldr r0,[r1,r0]	; 0230E8BC
	ldrh r2,[r0,#0x16]	; 0230E8BE
	cmp r2,#0x1	; 0230E8C0
	beq loc_0230E8C6	; 0230E8C2
	b loc_0230EA2A	; 0230E8C4
loc_0230E8C6:
	ldrh r3,[r0,#0x14]	; 0230E8C6
	ldrh r2,[r5,#0x22]	; 0230E8C8
	cmp r3,r2	; 0230E8CA
	bne loc_0230E8E2	; 0230E8CC
	ldrh r3,[r0,#0x12]	; 0230E8CE
	ldrh r2,[r5,#0x20]	; 0230E8D0
	cmp r3,r2	; 0230E8D2
	bne loc_0230E8E2	; 0230E8D4
	ldrh r2,[r0,#0x10]	; 0230E8D6
	ldrh r0,[r5,#0x1e]	; 0230E8D8
	cmp r2,r0	; 0230E8DA
	bne loc_0230E8E2	; 0230E8DC
	mov r0,#0x1	; 0230E8DE
	b loc_0230E8E4	; 0230E8E0
loc_0230E8E2:
	mov r0,#0x0	; 0230E8E2
loc_0230E8E4:
	cmp r0,#0x0	; 0230E8E4
	bne loc_0230E8EA	; 0230E8E6
	b loc_0230EA2A	; 0230E8E8
loc_0230E8EA:
	ldrh r0,[r4,#0x2]	; 0230E8EA
	cmp r0,#0x2	; 0230E8EC
	bne loc_0230E9C0	; 0230E8EE
	ldr r0,[pool_0230E9B4]	; 0230E8F0
	add r0,r1,r0	; 0230E8F2
	ldrh r1,[r0,#0x0]	; 0230E8F4
	cmp r1,#0x31	; 0230E8F6
	beq loc_0230E8FC	; 0230E8F8
	b loc_0230EA2A	; 0230E8FA
loc_0230E8FC:
	ldrh r1,[r4,#0x4]	; 0230E8FC
	cmp r1,#0x0	; 0230E8FE
	beq loc_0230E932	; 0230E900
	bl loc_02305590	; 0230E902
	mov r3,#0x35	; 0230E906
	ldr r1,[pool_0230E980]	; 0230E908
	ldr r2,[r1,#0x0]	; 0230E90A
	ldr r0,[pool_0230E9B4]	; 0230E90C
	strh r3,[r2,r0]	; 0230E90E
	mov r0,#0xc	; 0230E910
	ldr r3,[r1,#0x0]	; 0230E912
	ldr r2,[pool_0230E9B8]	; 0230E914
	ldr r3,[r3,r2]	; 0230E916
	strh r0,[r3,#0x4]	; 0230E918
	ldrh r0,[r4,#0x4]	; 0230E91A
	ldr r1,[r1,#0x0]	; 0230E91C
	ldr r1,[r1,r2]	; 0230E91E
	strh r0,[r1,#0x6]	; 0230E920
	mov r0,#0x2	; 0230E922
	add r1,r0,#0x0	; 0230E924
	bl loc_02304B6C	; 0230E926
	mov r0,#0x20	; 0230E92A
	bl loc_0230646C	; 0230E92C
	b loc_0230EA2A	; 0230E930
loc_0230E932:
	mov r1,#0x33	; 0230E932
	strh r1,[r0,#0x0]	; 0230E934
	add r0,r5,#0x0	; 0230E936
	add r0,#0x33	; 0230E938
	bl loc_023053B8	; 0230E93A
	add r1,r0,#0x0	; 0230E93E
	add r0,r5,#0x0	; 0230E940
	add r0,#0x1e	; 0230E942
	bl loc_0230C0D4	; 0230E944
	add r6,r0,#0x0	; 0230E948
	cmp r6,#0x0	; 0230E94A
	beq loc_0230EA2A	; 0230E94C
	add r2,r6,#0x0	; 0230E94E
	add r2,#0x14	; 0230E950
	ldrh r1,[r2,#0x0]	; 0230E952
	ldr r0,[pool_0230E9BC]	; 0230E954
	orr r1,r0	; 0230E956
	strh r1,[r2,#0x0]	; 0230E958
	add r0,r5,#0x0	; 0230E95A
	add r0,#0x2c	; 0230E95C
	add r1,r6,#0x0	; 0230E95E
	add r1,#0x2c	; 0230E960
	ldrh r2,[r5,#0x6]	; 0230E962
	add r2,r2,#0x1	; 0230E964
	bl loc_0230EA64	; 0230E966
	ldrh r0,[r4,#0x0]	; 0230E96A
	strh r0,[r6,#0x2c]	; 0230E96C
	mov r0,#0x3	; 0230E96E
	strh r0,[r6,#0x2e]	; 0230E970
	mov r0,#0x0	; 0230E972
	strh r0,[r6,#0x30]	; 0230E974
	add r0,r6,#0x0	; 0230E976
	bl loc_0230CAF0	; 0230E978
	b loc_0230EA2A	; 0230E97C
	.byte 0xC0, 0x46	; 0230E980
pool_0230E980:
loc_0230E980:
	.word FirmwareWlWorkPointerSlot	; 0230E980
pool_0230E984:
loc_0230E984:
	.word 0x0000061C	; 0230E984
pool_0230E988:
loc_0230E988:
	.word 0x000003E4	; 0230E988
pool_0230E98C:
loc_0230E98C:
	.word REG_WIFI_TXREQ_READ	; 0230E98C
pool_0230E990:
loc_0230E990:
	.word REG_WIFI_RF_PINS	; 0230E990
pool_0230E994:
loc_0230E994:
	.word REG_WIFI_WEP_CNT	; 0230E994
pool_0230E998:
loc_0230E998:
	.word 0x00008000	; 0230E998
pool_0230E99C:
loc_0230E99C:
	.word 0x0000049A	; 0230E99C
pool_0230E9A0:
loc_0230E9A0:
	.word 0x00000314	; 0230E9A0
pool_0230E9A4:
loc_0230E9A4:
	.word 0x000002E0	; 0230E9A4
pool_0230E9A8:
loc_0230E9A8:
	.word 0x00000400	; 0230E9A8
pool_0230E9AC:
loc_0230E9AC:
	.word 0x000002F6	; 0230E9AC
pool_0230E9B0:
loc_0230E9B0:
	.word 0x000003D4	; 0230E9B0
pool_0230E9B4:
loc_0230E9B4:
	.word 0x000003BC	; 0230E9B4
pool_0230E9B8:
loc_0230E9B8:
	.word 0x000003D8	; 0230E9B8
pool_0230E9BC:
loc_0230E9BC:
	.word 0x00004000	; 0230E9BC
loc_0230E9C0:
	cmp r0,#0x4	; 0230E9C0
	bne loc_0230EA2A	; 0230E9C2
	ldr r0,[pool_0230EA54]	; 0230E9C4
	ldrh r0,[r1,r0]	; 0230E9C6
	cmp r0,#0x33	; 0230E9C8
	bne loc_0230EA2A	; 0230E9CA
	bl loc_02305590	; 0230E9CC
	ldrh r0,[r4,#0x4]	; 0230E9D0
	cmp r0,#0x0	; 0230E9D2
	bne loc_0230E9F0	; 0230E9D4
	mov r0,#0x30	; 0230E9D6
	bl loc_0230646C	; 0230E9D8
	mov r1,#0x0	; 0230E9DC
	ldr r0,[pool_0230EA58]	; 0230E9DE
	ldr r3,[r0,#0x0]	; 0230E9E0
	ldr r2,[pool_0230EA5C]	; 0230E9E2
	ldr r3,[r3,r2]	; 0230E9E4
	strh r1,[r3,#0x4]	; 0230E9E6
	ldr r0,[r0,#0x0]	; 0230E9E8
	ldr r0,[r0,r2]	; 0230E9EA
	strh r1,[r0,#0x6]	; 0230E9EC
	b loc_0230EA04	; 0230E9EE
loc_0230E9F0:
	mov r0,#0xc	; 0230E9F0
	ldr r1,[pool_0230EA58]	; 0230E9F2
	ldr r3,[r1,#0x0]	; 0230E9F4
	ldr r2,[pool_0230EA5C]	; 0230E9F6
	ldr r3,[r3,r2]	; 0230E9F8
	strh r0,[r3,#0x4]	; 0230E9FA
	ldrh r0,[r4,#0x4]	; 0230E9FC
	ldr r1,[r1,#0x0]	; 0230E9FE
	ldr r1,[r1,r2]	; 0230EA00
	strh r0,[r1,#0x6]	; 0230EA02
loc_0230EA04:
	mov r2,#0x35	; 0230EA04
	ldr r0,[pool_0230EA58]	; 0230EA06
	ldr r1,[r0,#0x0]	; 0230EA08
	ldr r0,[pool_0230EA54]	; 0230EA0A
	strh r2,[r1,r0]	; 0230EA0C
	mov r0,#0x2	; 0230EA0E
	add r1,r0,#0x0	; 0230EA10
	bl loc_02304B6C	; 0230EA12
	b loc_0230EA2A	; 0230EA16
loc_0230EA18:
	ldr r0,[pool_0230EA58]	; 0230EA18
	ldr r1,[r0,#0x0]	; 0230EA1A
	ldr r0,[pool_0230EA60]	; 0230EA1C
	ldrh r0,[r1,r0]	; 0230EA1E
	cmp r0,#0x1	; 0230EA20
	bne loc_0230EA2A	; 0230EA22
	mov r7,#0xd	; 0230EA24
	mov r0,#0x1	; 0230EA26
	str r0,[sp,#0x0]	; 0230EA28
loc_0230EA2A:
	ldr r0,[sp,#0x0]	; 0230EA2A
	cmp r0,#0x0	; 0230EA2C
	beq loc_0230EA4C	; 0230EA2E
	add r5,#0x1e	; 0230EA30
	add r0,r5,#0x0	; 0230EA32
	mov r1,#0x0	; 0230EA34
	bl loc_0230C0D4	; 0230EA36
	cmp r0,#0x0	; 0230EA3A
	beq loc_0230EA4C	; 0230EA3C
	ldrh r1,[r4,#0x0]	; 0230EA3E
	strh r1,[r0,#0x2c]	; 0230EA40
	ldr r1,[sp,#0x4]	; 0230EA42
	strh r1,[r0,#0x2e]	; 0230EA44
	strh r7,[r0,#0x30]	; 0230EA46
	bl loc_0230CAF0	; 0230EA48
loc_0230EA4C:
	add sp,#0x14	; 0230EA4C
	pop {r4,r5,r6,r7}	; 0230EA4E
	pop {r3}	; 0230EA50
	bx r3	; 0230EA52
pool_0230EA54:
loc_0230EA54:
	.word 0x000003BC	; 0230EA54
pool_0230EA58:
loc_0230EA58:
	.word FirmwareWlWorkPointerSlot	; 0230EA58
pool_0230EA5C:
loc_0230EA5C:
	.word 0x000003D8	; 0230EA5C
pool_0230EA60:
loc_0230EA60:
	.word 0x00000314	; 0230EA60

; ===== function loc_0230EA64 =====
loc_0230EA64:
	bx pc	; 0230EA64
	.byte 0xC0, 0x46	; 0230EA68
.arm

; ===== function loc_0230EA68 =====
loc_0230EA68:
	ldr pc,[pool_0230EA6C]	; 0230EA68
pool_0230EA6C:
loc_0230EA6C:
	.word P2_Entry_037FCE1C	; 0230EA6C
.thumb

; ===== function loc_0230EA70 =====
loc_0230EA70:
	push {r4,r5,r6,r7,lr}	; 0230EA70
	sub sp,#0x44	; 0230EA72
	add r6,r0,#0x0	; 0230EA74
	add r5,r1,#0x0	; 0230EA76
	ldr r0,[pool_0230ECA4]	; 0230EA78
	ldr r1,[r0,#0x0]	; 0230EA7A
	ldr r0,[pool_0230ECA8]	; 0230EA7C
	add r4,r1,r0	; 0230EA7E
	ldrh r0,[r4,#0x0]	; 0230EA80
	cmp r0,#0x13	; 0230EA82
	beq loc_0230EA88	; 0230EA84
	b loc_0230EC9C	; 0230EA86
loc_0230EA88:
	ldr r0,[pool_0230ECAC]	; 0230EA88
	ldr r7,[r1,r0]	; 0230EA8A
	add r0,r6,#0x0	; 0230EA8C
	str r0,[sp,#0x0]	; 0230EA8E
	add r0,#0x2c	; 0230EA90
	str r0,[sp,#0x0]	; 0230EA92
	ldr r2,[r4,#0x18]	; 0230EA94
	add r0,r2,#0x0	; 0230EA96
	add r0,#0x4e	; 0230EA98
	mov r1,#0x0	; 0230EA9A
	add r2,#0x4c	; 0230EA9C
	ldrh r2,[r2,#0x0]	; 0230EA9E
	str r2,[sp,#0x8]	; 0230EAA0
	b loc_0230EAD0	; 0230EAA2
loc_0230EAA4:
	ldrh r3,[r0,#0x4]	; 0230EAA4
	ldrh r2,[r6,#0x28]	; 0230EAA6
	cmp r3,r2	; 0230EAA8
	bne loc_0230EACC	; 0230EAAA
	ldrh r3,[r0,#0x2]	; 0230EAAC
	ldrh r2,[r6,#0x26]	; 0230EAAE
	cmp r3,r2	; 0230EAB0
	bne loc_0230EACC	; 0230EAB2
	ldrh r3,[r0,#0x0]	; 0230EAB4
	ldrh r2,[r6,#0x24]	; 0230EAB6
	cmp r3,r2	; 0230EAB8
	bne loc_0230EACC	; 0230EABA
	ldr r0,[r4,#0x1c]	; 0230EABC
	add r3,r0,#0x6	; 0230EABE
	ldrh r2,[r3,#0x0]	; 0230EAC0
	mov r0,#0x1	; 0230EAC2
	lsl r0,r1	; 0230EAC4
	orr r2,r0	; 0230EAC6
	strh r2,[r3,#0x0]	; 0230EAC8
	b loc_0230EC9C	; 0230EACA
loc_0230EACC:
	add r0,r0,#0x6	; 0230EACC
	add r1,r1,#0x1	; 0230EACE
loc_0230EAD0:
	ldr r2,[sp,#0x8]	; 0230EAD0
	cmp r1,r2	; 0230EAD2
	bcc loc_0230EAA4	; 0230EAD4
	add r4,r7,#0x0	; 0230EAD6
	add r4,#0xa	; 0230EAD8
	mov r0,#0x0	; 0230EADA
	ldrh r3,[r7,#0x8]	; 0230EADC
	b loc_0230EB02	; 0230EADE
loc_0230EAE0:
	ldrh r2,[r6,#0x28]	; 0230EAE0
	ldrh r1,[r4,#0x8]	; 0230EAE2
	cmp r2,r1	; 0230EAE4
	bne loc_0230EAFA	; 0230EAE6
	ldrh r2,[r6,#0x26]	; 0230EAE8
	ldrh r1,[r4,#0x6]	; 0230EAEA
	cmp r2,r1	; 0230EAEC
	bne loc_0230EAFA	; 0230EAEE
	ldrh r2,[r6,#0x24]	; 0230EAF0
	ldrh r1,[r4,#0x4]	; 0230EAF2
	cmp r2,r1	; 0230EAF4
	bne loc_0230EAFA	; 0230EAF6
	b loc_0230EC9C	; 0230EAF8
loc_0230EAFA:
	ldrh r1,[r4,#0x0]	; 0230EAFA
	lsl r1,r1,#0x1	; 0230EAFC
	add r4,r4,r1	; 0230EAFE
	add r0,r0,#0x1	; 0230EB00
loc_0230EB02:
	cmp r0,r3	; 0230EB02
	bcc loc_0230EAE0	; 0230EB04
	mov r1,#0x0	; 0230EB06
	add r0,sp,#0x14	; 0230EB08
	strh r1,[r0,#0x0]	; 0230EB0A
	ldrh r0,[r0,#0x0]	; 0230EB0C
	add r1,r4,#0x0	; 0230EB0E
	mov r2,#0x44	; 0230EB10
	bl loc_0230ECB8	; 0230EB12
	ldrh r0,[r6,#0x6]	; 0230EB16
	str r0,[sp,#0x4]	; 0230EB18
	cmp r0,#0xc	; 0230EB1A
	bhi loc_0230EB20	; 0230EB1C
	b loc_0230EC9C	; 0230EB1E
loc_0230EB20:
	cmp r5,#0x0	; 0230EB20
	bne loc_0230EB5C	; 0230EB22
	mov r0,#0x0	; 0230EB24
	str r0,[sp,#0x18]	; 0230EB26
	ldr r0,[sp,#0x18]	; 0230EB28
	add r1,sp,#0x1c	; 0230EB2A
	mov r2,#0x28	; 0230EB2C
	bl loc_0230ECC4	; 0230EB2E
	ldr r0,[sp,#0x0]	; 0230EB32
	add r0,#0xc	; 0230EB34
	str r0,[sp,#0x1c]	; 0230EB36
	ldr r0,[sp,#0x4]	; 0230EB38
	sub r0,#0xc	; 0230EB3A
	str r0,[sp,#0x4]	; 0230EB3C
	add r1,sp,#0x14	; 0230EB3E
	strh r0,[r1,#0x10]	; 0230EB40
	mov r0,#0x3	; 0230EB42
	strh r0,[r1,#0x12]	; 0230EB44
	mov r0,#0x38	; 0230EB46
	strh r0,[r1,#0x14]	; 0230EB48
	ldrh r0,[r6,#0x8]	; 0230EB4A
	strh r0,[r1,#0xc]	; 0230EB4C
	ldr r0,[sp,#0x0]	; 0230EB4E
	ldrh r0,[r0,#0xa]	; 0230EB50
	strh r0,[r1,#0xe]	; 0230EB52
	add r0,sp,#0x1c	; 0230EB54
	bl loc_0230E27C	; 0230EB56
	add r5,sp,#0x1c	; 0230EB5A
loc_0230EB5C:
	ldr r0,[r5,#0x24]	; 0230EB5C
	cmp r0,#0x0	; 0230EB5E
	beq loc_0230EB6C	; 0230EB60
	add r0,r0,#0x1	; 0230EB62
	bl loc_023053B8	; 0230EB64
	sub r0,#0x8	; 0230EB68
	strh r0,[r4,#0x3c]	; 0230EB6A
loc_0230EB6C:
	ldrh r1,[r5,#0xa]	; 0230EB6C
	mov r0,#0x1	; 0230EB6E
	and r1,r0	; 0230EB70
	cmp r1,#0x1	; 0230EB72
	beq loc_0230EB78	; 0230EB74
	b loc_0230EC94	; 0230EB76
loc_0230EB78:
	ldr r0,[pool_0230ECA4]	; 0230EB78
	ldr r1,[r0,#0x0]	; 0230EB7A
	ldr r0,[pool_0230ECB0]	; 0230EB7C
	ldrh r1,[r1,r0]	; 0230EB7E
	ldrh r0,[r4,#0x3c]	; 0230EB80
	add r0,#0x41	; 0230EB82
	lsr r0,r0,#0x1	; 0230EB84
	cmp r1,r0	; 0230EB86
	bcs loc_0230EB8C	; 0230EB88
	b loc_0230EC94	; 0230EB8A
loc_0230EB8C:
	ldr r0,[sp,#0x0]	; 0230EB8C
	ldrh r0,[r0,#0xa]	; 0230EB8E
	strh r0,[r4,#0x2c]	; 0230EB90
	add r0,r4,#0x4	; 0230EB92
	add r1,r6,#0x0	; 0230EB94
	add r1,#0x24	; 0230EB96
	bl loc_0230645C	; 0230EB98
	ldr r0,[sp,#0x0]	; 0230EB9C
	ldrh r0,[r0,#0x8]	; 0230EB9E
	strh r0,[r4,#0x32]	; 0230EBA0
	ldrh r1,[r6,#0x12]	; 0230EBA2
	mov r0,#0xff	; 0230EBA4
	and r1,r0	; 0230EBA6
	strh r1,[r4,#0x2]	; 0230EBA8
	ldr r0,[r5,#0x24]	; 0230EBAA
	cmp r0,#0x0	; 0230EBAC
	beq loc_0230EBD2	; 0230EBAE
	mov r6,#0x0	; 0230EBB0
	b loc_0230EBCC	; 0230EBB2
loc_0230EBB4:
	ldr r0,[r5,#0x24]	; 0230EBB4
	add r0,#0xa	; 0230EBB6
	add r0,r0,r6	; 0230EBB8
	bl loc_023053B8	; 0230EBBA
	add r1,r0,#0x0	; 0230EBBE
	add r0,r4,#0x0	; 0230EBC0
	add r0,#0x40	; 0230EBC2
	add r0,r0,r6	; 0230EBC4
	bl loc_023053DC	; 0230EBC6
	add r6,r6,#0x1	; 0230EBCA
loc_0230EBCC:
	ldrh r0,[r4,#0x3c]	; 0230EBCC
	cmp r6,r0	; 0230EBCE
	bcc loc_0230EBB4	; 0230EBD0
loc_0230EBD2:
	ldr r0,[r5,#0x18]	; 0230EBD2
	cmp r0,#0x0	; 0230EBD4
	beq loc_0230EC04	; 0230EBD6
	add r0,r0,#0x1	; 0230EBD8
	bl loc_023053B8	; 0230EBDA
	strh r0,[r4,#0xa]	; 0230EBDE
	mov r6,#0x0	; 0230EBE0
	b loc_0230EBFC	; 0230EBE2
loc_0230EBE4:
	ldr r0,[r5,#0x18]	; 0230EBE4
	add r0,r0,#0x2	; 0230EBE6
	add r0,r0,r6	; 0230EBE8
	bl loc_023053B8	; 0230EBEA
	add r1,r0,#0x0	; 0230EBEE
	add r0,r4,#0x0	; 0230EBF0
	add r0,#0xc	; 0230EBF2
	add r0,r0,r6	; 0230EBF4
	bl loc_023053DC	; 0230EBF6
	add r6,r6,#0x1	; 0230EBFA
loc_0230EBFC:
	ldrh r0,[r4,#0xa]	; 0230EBFC
	cmp r6,r0	; 0230EBFE
	bcc loc_0230EBE4	; 0230EC00
	b loc_0230EC22	; 0230EC02
loc_0230EC04:
	mov r6,#0x0	; 0230EC04
	strh r6,[r4,#0xa]	; 0230EC06
	add r0,r4,#0x0	; 0230EC08
	str r0,[sp,#0xc]	; 0230EC0A
	add r0,#0xc	; 0230EC0C
	str r0,[sp,#0xc]	; 0230EC0E
	str r6,[sp,#0x10]	; 0230EC10
loc_0230EC12:
	ldr r0,[sp,#0xc]	; 0230EC12
	add r0,r0,r6	; 0230EC14
	ldr r1,[sp,#0x10]	; 0230EC16
	bl loc_023053DC	; 0230EC18
	add r6,r6,#0x1	; 0230EC1C
	cmp r6,#0x20	; 0230EC1E
	bcc loc_0230EC12	; 0230EC20
loc_0230EC22:
	ldrh r0,[r5,#0x14]	; 0230EC22
	strh r0,[r4,#0x2e]	; 0230EC24
	ldrh r0,[r5,#0x16]	; 0230EC26
	strh r0,[r4,#0x30]	; 0230EC28
	ldrh r0,[r5,#0x12]	; 0230EC2A
	strh r0,[r4,#0x36]	; 0230EC2C
	ldr r0,[r5,#0x1c]	; 0230EC2E
	cmp r0,#0x0	; 0230EC30
	beq loc_0230EC3C	; 0230EC32
	add r0,r0,#0x3	; 0230EC34
	bl loc_023053B8	; 0230EC36
	strh r0,[r4,#0x38]	; 0230EC3A
loc_0230EC3C:
	ldr r0,[r5,#0x20]	; 0230EC3C
	cmp r0,#0x0	; 0230EC3E
	beq loc_0230EC4A	; 0230EC40
	add r0,r0,#0x3	; 0230EC42
	bl loc_023053B8	; 0230EC44
	strh r0,[r4,#0x34]	; 0230EC48
loc_0230EC4A:
	ldrh r0,[r4,#0x3c]	; 0230EC4A
	add r0,#0x41	; 0230EC4C
	lsr r0,r0,#0x1	; 0230EC4E
	strh r0,[r4,#0x0]	; 0230EC50
	add r2,r7,#0x2	; 0230EC52
	ldrh r1,[r2,#0x0]	; 0230EC54
	ldrh r0,[r4,#0x0]	; 0230EC56
	add r0,r1,r0	; 0230EC58
	strh r0,[r2,#0x0]	; 0230EC5A
	add r7,#0x8	; 0230EC5C
	ldrh r0,[r7,#0x0]	; 0230EC5E
	add r0,r0,#0x1	; 0230EC60
	strh r0,[r7,#0x0]	; 0230EC62
	ldr r3,[pool_0230ECA4]	; 0230EC64
	ldr r1,[r3,#0x0]	; 0230EC66
	ldr r0,[pool_0230ECB0]	; 0230EC68
	add r5,r1,r0	; 0230EC6A
	ldrh r2,[r5,#0x0]	; 0230EC6C
	ldrh r1,[r4,#0x0]	; 0230EC6E
	sub r1,r2,r1	; 0230EC70
	strh r1,[r5,#0x0]	; 0230EC72
	ldr r1,[r3,#0x0]	; 0230EC74
	ldrh r0,[r1,r0]	; 0230EC76
	cmp r0,#0x20	; 0230EC78
	bcs loc_0230EC9C	; 0230EC7A
	bl loc_02305590	; 0230EC7C
	mov r2,#0x15	; 0230EC80
	ldr r0,[pool_0230ECA4]	; 0230EC82
	ldr r1,[r0,#0x0]	; 0230EC84
	ldr r0,[pool_0230ECA8]	; 0230EC86
	strh r2,[r1,r0]	; 0230EC88
	mov r0,#0x2	; 0230EC8A
	mov r1,#0x0	; 0230EC8C
	bl loc_02304B6C	; 0230EC8E
	b loc_0230EC9C	; 0230EC92
loc_0230EC94:
	add r0,r4,#0x4	; 0230EC94
	ldr r1,[pool_0230ECB4]	; 0230EC96
	bl loc_0230645C	; 0230EC98
loc_0230EC9C:
	add sp,#0x44	; 0230EC9C
	pop {r4,r5,r6,r7}	; 0230EC9E
	pop {r3}	; 0230ECA0
	bx r3	; 0230ECA2
pool_0230ECA4:
loc_0230ECA4:
	.word FirmwareWlWorkPointerSlot	; 0230ECA4
pool_0230ECA8:
loc_0230ECA8:
	.word 0x000003BC	; 0230ECA8
pool_0230ECAC:
loc_0230ECAC:
	.word 0x000003D8	; 0230ECAC
pool_0230ECB0:
loc_0230ECB0:
	.word 0x000003C0	; 0230ECB0
pool_0230ECB4:
loc_0230ECB4:
	.word 0x0231038C	; 0230ECB4

; ===== function loc_0230ECB8 =====
loc_0230ECB8:
	bx pc	; 0230ECB8
	.byte 0xC0, 0x46	; 0230ECBC
.arm

; ===== function loc_0230ECBC =====
loc_0230ECBC:
	ldr pc,[pool_0230ECC0]	; 0230ECBC
pool_0230ECC0:
loc_0230ECC0:
	.word loc_037FCE04	; 0230ECC0
.thumb

; ===== function loc_0230ECC4 =====
loc_0230ECC4:
	bx pc	; 0230ECC4
	.byte 0xC0, 0x46	; 0230ECC8
.arm

; ===== function loc_0230ECC8 =====
loc_0230ECC8:
	ldr pc,[pool_0230ECCC]	; 0230ECC8
pool_0230ECCC:
loc_0230ECCC:
	.word loc_037FCE38	; 0230ECCC
.thumb

; ===== function loc_0230ECD0 =====
loc_0230ECD0:
	push {r4,lr}	; 0230ECD0
	sub sp,#0x30	; 0230ECD2
	add r4,r0,#0x0	; 0230ECD4
	ldrh r1,[r4,#0x24]	; 0230ECD6
	mov r0,#0x1	; 0230ECD8
	and r1,r0	; 0230ECDA
	cmp r1,#0x0	; 0230ECDC
	bne loc_0230ECEA	; 0230ECDE
	ldrh r1,[r4,#0x8]	; 0230ECE0
	ldr r0,[pool_0230ED44]	; 0230ECE2
	and r1,r0	; 0230ECE4
	cmp r1,#0x0	; 0230ECE6
	beq loc_0230ED3A	; 0230ECE8
loc_0230ECEA:
	mov r0,#0x0	; 0230ECEA
	str r0,[sp,#0x0]	; 0230ECEC
	ldr r0,[sp,#0x0]	; 0230ECEE
	add r1,sp,#0x4	; 0230ECF0
	mov r2,#0x28	; 0230ECF2
	bl loc_0230ED54	; 0230ECF4
	add r0,r4,#0x0	; 0230ECF8
	add r0,#0x2c	; 0230ECFA
	str r0,[sp,#0x4]	; 0230ECFC
	ldrh r0,[r4,#0x6]	; 0230ECFE
	add r1,sp,#0x0	; 0230ED00
	strh r0,[r1,#0xc]	; 0230ED02
	ldr r0,[pool_0230ED48]	; 0230ED04
	ldr r2,[r0,#0x0]	; 0230ED06
	ldr r0,[pool_0230ED4C]	; 0230ED08
	ldrh r0,[r2,r0]	; 0230ED0A
	lsl r0,r0,#0x1e	; 0230ED0C
	lsr r0,r0,#0x1f	; 0230ED0E
	cmp r0,#0x0	; 0230ED10
	bne loc_0230ED18	; 0230ED12
	ldr r0,[pool_0230ED50]	; 0230ED14
	strh r0,[r1,#0x10]	; 0230ED16
loc_0230ED18:
	add r0,sp,#0x4	; 0230ED18
	bl loc_0230E27C	; 0230ED1A
	add r0,sp,#0x0	; 0230ED1E
	ldrh r1,[r0,#0xe]	; 0230ED20
	mov r0,#0x1	; 0230ED22
	and r1,r0	; 0230ED24
	cmp r1,#0x1	; 0230ED26
	bne loc_0230ED3A	; 0230ED28
	add r4,#0x1e	; 0230ED2A
	add r0,r4,#0x0	; 0230ED2C
	bl loc_0230C170	; 0230ED2E
	cmp r0,#0x0	; 0230ED32
	beq loc_0230ED3A	; 0230ED34
	bl loc_0230CAF0	; 0230ED36
loc_0230ED3A:
	add sp,#0x30	; 0230ED3A
	pop {r4}	; 0230ED3C
	pop {r3}	; 0230ED3E
	bx r3	; 0230ED40
	.byte 0xC0, 0x46	; 0230ED44
pool_0230ED44:
loc_0230ED44:
	.word 0x00008000	; 0230ED44
pool_0230ED48:
loc_0230ED48:
	.word FirmwareWlWorkPointerSlot	; 0230ED48
pool_0230ED4C:
loc_0230ED4C:
	.word 0x000002FE	; 0230ED4C
pool_0230ED50:
loc_0230ED50:
	.word 0x00000800	; 0230ED50

; ===== function loc_0230ED54 =====
loc_0230ED54:
	bx pc	; 0230ED54
	.byte 0xC0, 0x46	; 0230ED58
.arm

; ===== function loc_0230ED58 =====
loc_0230ED58:
	ldr pc,[pool_0230ED5C]	; 0230ED58
pool_0230ED5C:
loc_0230ED5C:
	.word loc_037FCE38	; 0230ED5C
.thumb

; ===== function loc_0230ED60 =====
loc_0230ED60:
	push {r4,r5,lr}	; 0230ED60
	sub sp,#0x4	; 0230ED62
	add r5,r0,#0x0	; 0230ED64
	add r4,r5,#0x0	; 0230ED66
	add r4,#0x2c	; 0230ED68
	ldr r0,[pool_0230EE5C]	; 0230ED6A
	ldr r0,[r0,#0x0]	; 0230ED6C
	ldr r1,[pool_0230EE60]	; 0230ED6E
	ldrh r1,[r0,r1]	; 0230ED70
	cmp r1,#0x2	; 0230ED72
	beq loc_0230ED7A	; 0230ED74
	cmp r1,#0x3	; 0230ED76
	bne loc_0230EE52	; 0230ED78
loc_0230ED7A:
	ldr r1,[pool_0230EE64]	; 0230ED7A
	ldrh r1,[r0,r1]	; 0230ED7C
	cmp r1,#0x61	; 0230ED7E
	bne loc_0230EE52	; 0230ED80
	ldr r1,[pool_0230EE68]	; 0230ED82
	ldr r2,[r0,r1]	; 0230ED84
	ldrh r1,[r2,#0x14]	; 0230ED86
	ldrh r0,[r5,#0x22]	; 0230ED88
	cmp r1,r0	; 0230ED8A
	bne loc_0230EE52	; 0230ED8C
	ldrh r1,[r2,#0x12]	; 0230ED8E
	ldrh r0,[r5,#0x20]	; 0230ED90
	cmp r1,r0	; 0230ED92
	bne loc_0230EE52	; 0230ED94
	ldrh r1,[r2,#0x10]	; 0230ED96
	ldrh r0,[r5,#0x1e]	; 0230ED98
	cmp r1,r0	; 0230ED9A
	bne loc_0230EE52	; 0230ED9C
	bl loc_02305590	; 0230ED9E
	ldrh r0,[r4,#0x2]	; 0230EDA2
	cmp r0,#0x0	; 0230EDA4
	bne loc_0230EE00	; 0230EDA6
	ldrh r1,[r4,#0x4]	; 0230EDA8
	ldr r0,[pool_0230EE6C]	; 0230EDAA
	and r1,r0	; 0230EDAC
	lsl r0,r1,#0x10	; 0230EDAE
	lsr r0,r0,#0x10	; 0230EDB0
	bl loc_02306560	; 0230EDB2
	ldr r0,[pool_0230EE5C]	; 0230EDB6
	ldr r1,[r0,#0x0]	; 0230EDB8
	ldr r0,[pool_0230EE70]	; 0230EDBA
	ldrh r0,[r1,r0]	; 0230EDBC
	bl loc_0230C014	; 0230EDBE
	ldr r0,[pool_0230EE5C]	; 0230EDC2
	ldr r1,[r0,#0x0]	; 0230EDC4
	ldr r0,[pool_0230EE74]	; 0230EDC6
	add r0,r1,r0	; 0230EDC8
	add r1,r5,#0x0	; 0230EDCA
	add r1,#0x1e	; 0230EDCC
	bl loc_0230645C	; 0230EDCE
	add r5,#0x1e	; 0230EDD2
	add r0,r5,#0x0	; 0230EDD4
	bl loc_023094A0	; 0230EDD6
	ldr r3,[pool_0230EE5C]	; 0230EDDA
	ldr r2,[r3,#0x0]	; 0230EDDC
	ldr r1,[pool_0230EE78]	; 0230EDDE
	strh r0,[r2,r1]	; 0230EDE0
	ldr r0,[r3,#0x0]	; 0230EDE2
	ldrh r0,[r0,r1]	; 0230EDE4
	mov r1,#0x40	; 0230EDE6
	bl loc_023091F0	; 0230EDE8
	ldr r0,[pool_0230EE5C]	; 0230EDEC
	ldr r1,[r0,#0x0]	; 0230EDEE
	ldr r0,[pool_0230EE78]	; 0230EDF0
	ldrh r0,[r1,r0]	; 0230EDF2
	mov r1,#0x40	; 0230EDF4
	bl loc_023091F0	; 0230EDF6
	mov r0,#0x40	; 0230EDFA
	bl loc_0230646C	; 0230EDFC
loc_0230EE00:
	ldrh r0,[r4,#0x2]	; 0230EE00
	cmp r0,#0x0	; 0230EE02
	bne loc_0230EE20	; 0230EE04
	mov r3,#0x0	; 0230EE06
	ldr r2,[pool_0230EE5C]	; 0230EE08
	ldr r1,[r2,#0x0]	; 0230EE0A
	ldr r0,[pool_0230EE7C]	; 0230EE0C
	ldr r1,[r1,r0]	; 0230EE0E
	strh r3,[r1,#0x4]	; 0230EE10
	ldr r1,[r2,#0x0]	; 0230EE12
	ldr r0,[r1,r0]	; 0230EE14
	strh r3,[r0,#0x6]	; 0230EE16
	mov r0,#0x40	; 0230EE18
	bl loc_0230646C	; 0230EE1A
	b loc_0230EE34	; 0230EE1E
loc_0230EE20:
	mov r2,#0xc	; 0230EE20
	ldr r3,[pool_0230EE5C]	; 0230EE22
	ldr r1,[r3,#0x0]	; 0230EE24
	ldr r0,[pool_0230EE7C]	; 0230EE26
	ldr r1,[r1,r0]	; 0230EE28
	strh r2,[r1,#0x4]	; 0230EE2A
	ldrh r2,[r4,#0x2]	; 0230EE2C
	ldr r1,[r3,#0x0]	; 0230EE2E
	ldr r0,[r1,r0]	; 0230EE30
	strh r2,[r0,#0x6]	; 0230EE32
loc_0230EE34:
	ldr r3,[pool_0230EE5C]	; 0230EE34
	ldr r2,[r3,#0x0]	; 0230EE36
	ldr r0,[pool_0230EE70]	; 0230EE38
	ldrh r1,[r2,r0]	; 0230EE3A
	ldr r0,[pool_0230EE7C]	; 0230EE3C
	ldr r0,[r2,r0]	; 0230EE3E
	strh r1,[r0,#0x8]	; 0230EE40
	mov r2,#0x63	; 0230EE42
	ldr r1,[r3,#0x0]	; 0230EE44
	ldr r0,[pool_0230EE64]	; 0230EE46
	strh r2,[r1,r0]	; 0230EE48
	mov r0,#0x2	; 0230EE4A
	mov r1,#0x4	; 0230EE4C
	bl loc_02304B6C	; 0230EE4E
loc_0230EE52:
	add sp,#0x4	; 0230EE52
	pop {r4,r5}	; 0230EE54
	pop {r3}	; 0230EE56
	bx r3	; 0230EE58
	.byte 0xC0, 0x46	; 0230EE5C
pool_0230EE5C:
loc_0230EE5C:
	.word FirmwareWlWorkPointerSlot	; 0230EE5C
pool_0230EE60:
loc_0230EE60:
	.word 0x00000314	; 0230EE60
pool_0230EE64:
loc_0230EE64:
	.word 0x000003BC	; 0230EE64
pool_0230EE68:
loc_0230EE68:
	.word 0x000003D4	; 0230EE68
pool_0230EE6C:
loc_0230EE6C:
	.word 0x00000FFF	; 0230EE6C
pool_0230EE70:
loc_0230EE70:
	.word 0x00000366	; 0230EE70
pool_0230EE74:
loc_0230EE74:
	.word 0x0000037E	; 0230EE74
pool_0230EE78:
loc_0230EE78:
	.word 0x00000384	; 0230EE78
pool_0230EE7C:
loc_0230EE7C:
	.word 0x000003D8	; 0230EE7C

; ===== function loc_0230EE80 =====
loc_0230EE80:
	push {r4,r5,r6,r7,lr}	; 0230EE80
	sub sp,#0x34	; 0230EE82
	add r7,r0,#0x0	; 0230EE84
	ldrh r6,[r7,#0x6]	; 0230EE86
	add r5,r7,#0x0	; 0230EE88
	add r5,#0x2c	; 0230EE8A
	cmp r6,#0xa	; 0230EE8C
	bls loc_0230EF70	; 0230EE8E
	ldr r0,[pool_0230EF78]	; 0230EE90
	ldr r0,[r0,#0x0]	; 0230EE92
	ldr r1,[pool_0230EF7C]	; 0230EE94
	ldrh r1,[r0,r1]	; 0230EE96
	cmp r1,#0x1	; 0230EE98
	bne loc_0230EF70	; 0230EE9A
	ldrh r1,[r7,#0x2]	; 0230EE9C
	str r1,[sp,#0x0]	; 0230EE9E
	mov r1,#0x1c	; 0230EEA0
	ldr r4,[sp,#0x0]	; 0230EEA2
	mul r4,r1	; 0230EEA4
	ldr r1,[pool_0230EF80]	; 0230EEA6
	ldr r0,[r0,r1]	; 0230EEA8
	ldrh r0,[r0,r4]	; 0230EEAA
	cmp r0,#0x30	; 0230EEAC
	bcs loc_0230EEC4	; 0230EEAE
	add r7,#0x1e	; 0230EEB0
	add r0,r7,#0x0	; 0230EEB2
	mov r1,#0x6	; 0230EEB4
	bl loc_0230C05C	; 0230EEB6
	cmp r0,#0x0	; 0230EEBA
	beq loc_0230EF70	; 0230EEBC
	bl loc_0230CAF0	; 0230EEBE
	b loc_0230EF70	; 0230EEC2
loc_0230EEC4:
	cmp r0,#0x40	; 0230EEC4
	bne loc_0230EEDA	; 0230EEC6
	ldr r0,[sp,#0x0]	; 0230EEC8
	mov r1,#0x30	; 0230EECA
	bl loc_023091F0	; 0230EECC
	add r7,#0x1e	; 0230EED0
	add r0,r7,#0x0	; 0230EED2
	mov r1,#0x1	; 0230EED4
	bl loc_023099D4	; 0230EED6
loc_0230EEDA:
	mov r0,#0x0	; 0230EEDA
	str r0,[sp,#0x4]	; 0230EEDC
	ldr r0,[sp,#0x4]	; 0230EEDE
	add r1,sp,#0x8	; 0230EEE0
	mov r2,#0x28	; 0230EEE2
	bl loc_0230EF90	; 0230EEE4
	add r0,r5,#0x0	; 0230EEE8
	add r0,#0xa	; 0230EEEA
	str r0,[sp,#0x8]	; 0230EEEC
	sub r6,#0xa	; 0230EEEE
	add r0,sp,#0x4	; 0230EEF0
	strh r6,[r0,#0xc]	; 0230EEF2
	ldr r1,[pool_0230EF84]	; 0230EEF4
	strh r1,[r0,#0x10]	; 0230EEF6
	add r0,sp,#0x8	; 0230EEF8
	bl loc_0230E27C	; 0230EEFA
	ldrh r0,[r5,#0x0]	; 0230EEFE
	ldr r1,[pool_0230EF88]	; 0230EF00
	add r2,r0,#0x0	; 0230EF02
	and r2,r1	; 0230EF04
	cmp r2,#0x0	; 0230EF06
	bne loc_0230EF2C	; 0230EF08
	ldr r1,[pool_0230EF78]	; 0230EF0A
	ldr r1,[r1,#0x0]	; 0230EF0C
	ldr r2,[pool_0230EF8C]	; 0230EF0E
	ldrh r3,[r1,r2]	; 0230EF10
	cmp r3,#0x0	; 0230EF12
	bne loc_0230EF1E	; 0230EF14
	lsl r2,r0,#0x1b	; 0230EF16
	lsr r2,r2,#0x1f	; 0230EF18
	cmp r2,#0x1	; 0230EF1A
	beq loc_0230EF2C	; 0230EF1C
loc_0230EF1E:
	cmp r3,#0x0	; 0230EF1E
	beq loc_0230EF30	; 0230EF20
	ldrh r2,[r5,#0x0]	; 0230EF22
	lsl r2,r2,#0x1b	; 0230EF24
	lsr r2,r2,#0x1f	; 0230EF26
	cmp r2,#0x0	; 0230EF28
	bne loc_0230EF30	; 0230EF2A
loc_0230EF2C:
	mov r1,#0xa	; 0230EF2C
	b loc_0230EF60	; 0230EF2E
loc_0230EF30:
	ldr r2,[pool_0230EF80]	; 0230EF30
	ldr r1,[r1,r2]	; 0230EF32
	add r1,r1,r4	; 0230EF34
	strh r0,[r1,#0xc]	; 0230EF36
	add r3,sp,#0x4	; 0230EF38
	ldrh r5,[r3,#0xe]	; 0230EF3A
	mov r1,#0x1	; 0230EF3C
	add r0,r5,#0x0	; 0230EF3E
	and r0,r1	; 0230EF40
	cmp r0,#0x0	; 0230EF42
	beq loc_0230EF60	; 0230EF44
	mov r0,#0x4	; 0230EF46
	and r5,r0	; 0230EF48
	cmp r5,#0x0	; 0230EF4A
	bne loc_0230EF52	; 0230EF4C
	mov r1,#0x12	; 0230EF4E
	b loc_0230EF60	; 0230EF50
loc_0230EF52:
	ldrh r1,[r3,#0x1a]	; 0230EF52
	ldr r0,[pool_0230EF78]	; 0230EF54
	ldr r0,[r0,#0x0]	; 0230EF56
	ldr r0,[r0,r2]	; 0230EF58
	add r0,r0,r4	; 0230EF5A
	strh r1,[r0,#0x10]	; 0230EF5C
	mov r1,#0x0	; 0230EF5E
loc_0230EF60:
	ldr r0,[sp,#0x0]	; 0230EF60
	ldr r2,[sp,#0x20]	; 0230EF62
	bl loc_0230C2BC	; 0230EF64
	cmp r0,#0x0	; 0230EF68
	beq loc_0230EF70	; 0230EF6A
	bl loc_0230CAF0	; 0230EF6C
loc_0230EF70:
	add sp,#0x34	; 0230EF70
	pop {r4,r5,r6,r7}	; 0230EF72
	pop {r3}	; 0230EF74
	bx r3	; 0230EF76
pool_0230EF78:
loc_0230EF78:
	.word FirmwareWlWorkPointerSlot	; 0230EF78
pool_0230EF7C:
loc_0230EF7C:
	.word 0x00000314	; 0230EF7C
pool_0230EF80:
loc_0230EF80:
	.word 0x000002E0	; 0230EF80
pool_0230EF84:
loc_0230EF84:
	.word 0x00000800	; 0230EF84
pool_0230EF88:
loc_0230EF88:
	.word 0x0000FFC2	; 0230EF88
pool_0230EF8C:
loc_0230EF8C:
	.word 0x000002F8	; 0230EF8C

; ===== function loc_0230EF90 =====
loc_0230EF90:
	bx pc	; 0230EF90
	.byte 0xC0, 0x46	; 0230EF94
.arm

; ===== function loc_0230EF94 =====
loc_0230EF94:
	ldr pc,[pool_0230EF98]	; 0230EF94
pool_0230EF98:
loc_0230EF98:
	.word loc_037FCE38	; 0230EF98
.thumb

; ===== function loc_0230EF9C =====
loc_0230EF9C:
	push {r4,r5,lr}	; 0230EF9C
	sub sp,#0x4	; 0230EF9E
	add r5,r0,#0x0	; 0230EFA0
	add r4,r5,#0x0	; 0230EFA2
	add r4,#0x2c	; 0230EFA4
	ldr r0,[pool_0230F084]	; 0230EFA6
	ldr r0,[r0,#0x0]	; 0230EFA8
	ldr r1,[pool_0230F088]	; 0230EFAA
	ldrh r1,[r0,r1]	; 0230EFAC
	cmp r1,#0x2	; 0230EFAE
	beq loc_0230EFB6	; 0230EFB0
	cmp r1,#0x3	; 0230EFB2
	bne loc_0230F07A	; 0230EFB4
loc_0230EFB6:
	ldr r1,[pool_0230F08C]	; 0230EFB6
	ldrh r1,[r0,r1]	; 0230EFB8
	cmp r1,#0x51	; 0230EFBA
	bne loc_0230F07A	; 0230EFBC
	ldr r1,[pool_0230F090]	; 0230EFBE
	ldr r2,[r0,r1]	; 0230EFC0
	ldrh r1,[r2,#0x14]	; 0230EFC2
	ldrh r0,[r5,#0x22]	; 0230EFC4
	cmp r1,r0	; 0230EFC6
	bne loc_0230F07A	; 0230EFC8
	ldrh r1,[r2,#0x12]	; 0230EFCA
	ldrh r0,[r5,#0x20]	; 0230EFCC
	cmp r1,r0	; 0230EFCE
	bne loc_0230F07A	; 0230EFD0
	ldrh r1,[r2,#0x10]	; 0230EFD2
	ldrh r0,[r5,#0x1e]	; 0230EFD4
	cmp r1,r0	; 0230EFD6
	bne loc_0230F07A	; 0230EFD8
	bl loc_02305590	; 0230EFDA
	ldrh r0,[r4,#0x2]	; 0230EFDE
	cmp r0,#0x0	; 0230EFE0
	bne loc_0230F028	; 0230EFE2
	ldrh r1,[r4,#0x4]	; 0230EFE4
	ldr r0,[pool_0230F094]	; 0230EFE6
	and r1,r0	; 0230EFE8
	lsl r0,r1,#0x10	; 0230EFEA
	lsr r0,r0,#0x10	; 0230EFEC
	bl loc_02306560	; 0230EFEE
	ldr r0,[pool_0230F084]	; 0230EFF2
	ldr r1,[r0,#0x0]	; 0230EFF4
	ldr r0,[pool_0230F098]	; 0230EFF6
	ldrh r0,[r1,r0]	; 0230EFF8
	bl loc_0230C014	; 0230EFFA
	ldr r0,[pool_0230F084]	; 0230EFFE
	ldr r1,[r0,#0x0]	; 0230F000
	ldr r0,[pool_0230F09C]	; 0230F002
	add r0,r1,r0	; 0230F004
	add r1,r5,#0x0	; 0230F006
	add r1,#0x1e	; 0230F008
	bl loc_0230645C	; 0230F00A
	add r5,#0x1e	; 0230F00E
	add r0,r5,#0x0	; 0230F010
	bl loc_023094A0	; 0230F012
	ldr r3,[pool_0230F084]	; 0230F016
	ldr r2,[r3,#0x0]	; 0230F018
	ldr r1,[pool_0230F0A0]	; 0230F01A
	strh r0,[r2,r1]	; 0230F01C
	ldr r0,[r3,#0x0]	; 0230F01E
	ldrh r0,[r0,r1]	; 0230F020
	mov r1,#0x40	; 0230F022
	bl loc_023091F0	; 0230F024
loc_0230F028:
	ldrh r0,[r4,#0x2]	; 0230F028
	cmp r0,#0x0	; 0230F02A
	bne loc_0230F048	; 0230F02C
	mov r3,#0x0	; 0230F02E
	ldr r2,[pool_0230F084]	; 0230F030
	ldr r1,[r2,#0x0]	; 0230F032
	ldr r0,[pool_0230F0A4]	; 0230F034
	ldr r1,[r1,r0]	; 0230F036
	strh r3,[r1,#0x4]	; 0230F038
	ldr r1,[r2,#0x0]	; 0230F03A
	ldr r0,[r1,r0]	; 0230F03C
	strh r3,[r0,#0x6]	; 0230F03E
	mov r0,#0x40	; 0230F040
	bl loc_0230646C	; 0230F042
	b loc_0230F05C	; 0230F046
loc_0230F048:
	mov r2,#0xc	; 0230F048
	ldr r3,[pool_0230F084]	; 0230F04A
	ldr r1,[r3,#0x0]	; 0230F04C
	ldr r0,[pool_0230F0A4]	; 0230F04E
	ldr r1,[r1,r0]	; 0230F050
	strh r2,[r1,#0x4]	; 0230F052
	ldrh r2,[r4,#0x2]	; 0230F054
	ldr r1,[r3,#0x0]	; 0230F056
	ldr r0,[r1,r0]	; 0230F058
	strh r2,[r0,#0x6]	; 0230F05A
loc_0230F05C:
	ldr r3,[pool_0230F084]	; 0230F05C
	ldr r2,[r3,#0x0]	; 0230F05E
	ldr r0,[pool_0230F098]	; 0230F060
	ldrh r1,[r2,r0]	; 0230F062
	ldr r0,[pool_0230F0A4]	; 0230F064
	ldr r0,[r2,r0]	; 0230F066
	strh r1,[r0,#0x8]	; 0230F068
	mov r2,#0x53	; 0230F06A
	ldr r1,[r3,#0x0]	; 0230F06C
	ldr r0,[pool_0230F08C]	; 0230F06E
	strh r2,[r1,r0]	; 0230F070
	mov r0,#0x2	; 0230F072
	mov r1,#0x3	; 0230F074
	bl loc_02304B6C	; 0230F076
loc_0230F07A:
	add sp,#0x4	; 0230F07A
	pop {r4,r5}	; 0230F07C
	pop {r3}	; 0230F07E
	bx r3	; 0230F080
	.byte 0xC0, 0x46	; 0230F084
pool_0230F084:
loc_0230F084:
	.word FirmwareWlWorkPointerSlot	; 0230F084
pool_0230F088:
loc_0230F088:
	.word 0x00000314	; 0230F088
pool_0230F08C:
loc_0230F08C:
	.word 0x000003BC	; 0230F08C
pool_0230F090:
loc_0230F090:
	.word 0x000003D4	; 0230F090
pool_0230F094:
loc_0230F094:
	.word 0x00000FFF	; 0230F094
pool_0230F098:
loc_0230F098:
	.word 0x00000366	; 0230F098
pool_0230F09C:
loc_0230F09C:
	.word 0x0000037E	; 0230F09C
pool_0230F0A0:
loc_0230F0A0:
	.word 0x00000384	; 0230F0A0
pool_0230F0A4:
loc_0230F0A4:
	.word 0x000003D8	; 0230F0A4

; ===== function loc_0230F0A8 =====
loc_0230F0A8:
	push {r4,r5,r6,r7,lr}	; 0230F0A8
	sub sp,#0x34	; 0230F0AA
	add r6,r0,#0x0	; 0230F0AC
	ldrh r7,[r6,#0x6]	; 0230F0AE
	add r5,r6,#0x0	; 0230F0B0
	add r5,#0x2c	; 0230F0B2
	cmp r7,#0x4	; 0230F0B4
	bls loc_0230F1B4	; 0230F0B6
	ldr r0,[pool_0230F1BC]	; 0230F0B8
	ldr r0,[r0,#0x0]	; 0230F0BA
	ldr r1,[pool_0230F1C0]	; 0230F0BC
	ldrh r1,[r0,r1]	; 0230F0BE
	cmp r1,#0x1	; 0230F0C0
	bne loc_0230F1B4	; 0230F0C2
	ldrh r1,[r6,#0x2]	; 0230F0C4
	str r1,[sp,#0x0]	; 0230F0C6
	cmp r1,#0x0	; 0230F0C8
	beq loc_0230F0DC	; 0230F0CA
	mov r1,#0x1c	; 0230F0CC
	ldr r4,[sp,#0x0]	; 0230F0CE
	mul r4,r1	; 0230F0D0
	ldr r1,[pool_0230F1C4]	; 0230F0D2
	ldr r0,[r0,r1]	; 0230F0D4
	ldrh r0,[r0,r4]	; 0230F0D6
	cmp r0,#0x30	; 0230F0D8
	bcs loc_0230F0F0	; 0230F0DA
loc_0230F0DC:
	add r6,#0x1e	; 0230F0DC
	add r0,r6,#0x0	; 0230F0DE
	mov r1,#0x6	; 0230F0E0
	bl loc_0230C05C	; 0230F0E2
	cmp r0,#0x0	; 0230F0E6
	beq loc_0230F1B4	; 0230F0E8
	bl loc_0230CAF0	; 0230F0EA
	b loc_0230F1B4	; 0230F0EE
loc_0230F0F0:
	cmp r0,#0x40	; 0230F0F0
	bne loc_0230F106	; 0230F0F2
	ldr r0,[sp,#0x0]	; 0230F0F4
	mov r1,#0x30	; 0230F0F6
	bl loc_023091F0	; 0230F0F8
	add r6,#0x1e	; 0230F0FC
	add r0,r6,#0x0	; 0230F0FE
	mov r1,#0x1	; 0230F100
	bl loc_023099D4	; 0230F102
loc_0230F106:
	mov r0,#0x0	; 0230F106
	str r0,[sp,#0x4]	; 0230F108
	ldr r0,[sp,#0x4]	; 0230F10A
	add r1,sp,#0x8	; 0230F10C
	mov r2,#0x28	; 0230F10E
	bl loc_0230F1D4	; 0230F110
	add r0,r5,#0x4	; 0230F114
	str r0,[sp,#0x8]	; 0230F116
	sub r1,r7,#0x4	; 0230F118
	add r0,sp,#0x4	; 0230F11A
	strh r1,[r0,#0xc]	; 0230F11C
	add r0,sp,#0x8	; 0230F11E
	bl loc_0230E27C	; 0230F120
	ldrh r0,[r5,#0x0]	; 0230F124
	ldr r1,[pool_0230F1C8]	; 0230F126
	add r2,r0,#0x0	; 0230F128
	and r2,r1	; 0230F12A
	cmp r2,#0x0	; 0230F12C
	bne loc_0230F170	; 0230F12E
	lsl r1,r0,#0x1f	; 0230F130
	lsr r1,r1,#0x1f	; 0230F132
	cmp r1,#0x0	; 0230F134
	beq loc_0230F170	; 0230F136
	ldr r1,[pool_0230F1BC]	; 0230F138
	ldr r1,[r1,#0x0]	; 0230F13A
	ldr r2,[pool_0230F1CC]	; 0230F13C
	ldrh r3,[r1,r2]	; 0230F13E
	cmp r3,#0x0	; 0230F140
	bne loc_0230F14C	; 0230F142
	lsl r2,r0,#0x1b	; 0230F144
	lsr r2,r2,#0x1f	; 0230F146
	cmp r2,#0x1	; 0230F148
	beq loc_0230F170	; 0230F14A
loc_0230F14C:
	cmp r3,#0x0	; 0230F14C
	beq loc_0230F15A	; 0230F14E
	ldrh r2,[r5,#0x0]	; 0230F150
	lsl r2,r2,#0x1b	; 0230F152
	lsr r2,r2,#0x1f	; 0230F154
	cmp r2,#0x0	; 0230F156
	beq loc_0230F170	; 0230F158
loc_0230F15A:
	ldr r2,[pool_0230F1D0]	; 0230F15A
	ldrh r2,[r1,r2]	; 0230F15C
	lsl r2,r2,#0x1d	; 0230F15E
	lsr r2,r2,#0x1f	; 0230F160
	cmp r2,#0x1	; 0230F162
	bne loc_0230F174	; 0230F164
	ldrh r2,[r5,#0x0]	; 0230F166
	lsl r2,r2,#0x1a	; 0230F168
	lsr r2,r2,#0x1f	; 0230F16A
	cmp r2,#0x0	; 0230F16C
	bne loc_0230F174	; 0230F16E
loc_0230F170:
	mov r1,#0xa	; 0230F170
	b loc_0230F1A4	; 0230F172
loc_0230F174:
	ldr r2,[pool_0230F1C4]	; 0230F174
	ldr r1,[r1,r2]	; 0230F176
	add r1,r1,r4	; 0230F178
	strh r0,[r1,#0xc]	; 0230F17A
	add r3,sp,#0x4	; 0230F17C
	ldrh r5,[r3,#0xe]	; 0230F17E
	mov r1,#0x1	; 0230F180
	add r0,r5,#0x0	; 0230F182
	and r0,r1	; 0230F184
	cmp r0,#0x0	; 0230F186
	beq loc_0230F1A4	; 0230F188
	mov r0,#0x4	; 0230F18A
	and r5,r0	; 0230F18C
	cmp r5,#0x0	; 0230F18E
	bne loc_0230F196	; 0230F190
	mov r1,#0x12	; 0230F192
	b loc_0230F1A4	; 0230F194
loc_0230F196:
	ldrh r1,[r3,#0x1a]	; 0230F196
	ldr r0,[pool_0230F1BC]	; 0230F198
	ldr r0,[r0,#0x0]	; 0230F19A
	ldr r0,[r0,r2]	; 0230F19C
	add r0,r0,r4	; 0230F19E
	strh r1,[r0,#0x10]	; 0230F1A0
	mov r1,#0x0	; 0230F1A2
loc_0230F1A4:
	ldr r0,[sp,#0x0]	; 0230F1A4
	ldr r2,[sp,#0x20]	; 0230F1A6
	bl loc_0230C3E8	; 0230F1A8
	cmp r0,#0x0	; 0230F1AC
	beq loc_0230F1B4	; 0230F1AE
	bl loc_0230CAF0	; 0230F1B0
loc_0230F1B4:
	add sp,#0x34	; 0230F1B4
	pop {r4,r5,r6,r7}	; 0230F1B6
	pop {r3}	; 0230F1B8
	bx r3	; 0230F1BA
pool_0230F1BC:
loc_0230F1BC:
	.word FirmwareWlWorkPointerSlot	; 0230F1BC
pool_0230F1C0:
loc_0230F1C0:
	.word 0x00000314	; 0230F1C0
pool_0230F1C4:
loc_0230F1C4:
	.word 0x000002E0	; 0230F1C4
pool_0230F1C8:
loc_0230F1C8:
	.word 0x0000FFC2	; 0230F1C8
pool_0230F1CC:
loc_0230F1CC:
	.word 0x000002F8	; 0230F1CC
pool_0230F1D0:
loc_0230F1D0:
	.word 0x000002FE	; 0230F1D0

; ===== function loc_0230F1D4 =====
loc_0230F1D4:
	bx pc	; 0230F1D4
	.byte 0xC0, 0x46	; 0230F1D8
.arm

; ===== function loc_0230F1D8 =====
loc_0230F1D8:
	ldr pc,[pool_0230F1DC]	; 0230F1D8
pool_0230F1DC:
loc_0230F1DC:
	.word loc_037FCE38	; 0230F1DC
.thumb

; ===== function loc_0230F1E0 =====
loc_0230F1E0:
	push {r4,r5,lr}	; 0230F1E0
	sub sp,#0x4	; 0230F1E2
	add r5,r0,#0x0	; 0230F1E4
	ldrh r4,[r5,#0x2]	; 0230F1E6
	ldr r0,[pool_0230F290]	; 0230F1E8
	ldr r0,[r0,#0x0]	; 0230F1EA
	ldr r1,[pool_0230F294]	; 0230F1EC
	ldrh r1,[r0,r1]	; 0230F1EE
	cmp r1,#0x1	; 0230F1F0
	beq loc_0230F1FE	; 0230F1F2
	cmp r1,#0x2	; 0230F1F4
	beq loc_0230F24E	; 0230F1F6
	cmp r1,#0x3	; 0230F1F8
	beq loc_0230F24E	; 0230F1FA
	b loc_0230F288	; 0230F1FC
loc_0230F1FE:
	ldr r1,[pool_0230F298]	; 0230F1FE
	ldr r2,[r0,r1]	; 0230F200
	mov r0,#0x1c	; 0230F202
	add r1,r4,#0x0	; 0230F204
	mul r1,r0	; 0230F206
	ldrh r0,[r2,r1]	; 0230F208
	cmp r0,#0x40	; 0230F20A
	bne loc_0230F22A	; 0230F20C
	lsl r0,r4,#0x10	; 0230F20E
	lsr r0,r0,#0x10	; 0230F210
	mov r1,#0x30	; 0230F212
	bl loc_023091F0	; 0230F214
	add r0,r5,#0x0	; 0230F218
	add r0,#0x1e	; 0230F21A
	ldrh r1,[r5,#0x2c]	; 0230F21C
	bl loc_023099D4	; 0230F21E
	add r0,r4,#0x0	; 0230F222
	bl loc_0230CC80	; 0230F224
	b loc_0230F288	; 0230F228
loc_0230F22A:
	cmp r0,#0x30	; 0230F22A
	bne loc_0230F23A	; 0230F22C
	add r5,#0x1e	; 0230F22E
	add r0,r5,#0x0	; 0230F230
	mov r1,#0x7	; 0230F232
	bl loc_0230C5C4	; 0230F234
	b loc_0230F244	; 0230F238
loc_0230F23A:
	add r5,#0x1e	; 0230F23A
	add r0,r5,#0x0	; 0230F23C
	mov r1,#0x7	; 0230F23E
	bl loc_0230C05C	; 0230F240
loc_0230F244:
	cmp r0,#0x0	; 0230F244
	beq loc_0230F288	; 0230F246
	bl loc_0230CAF0	; 0230F248
	b loc_0230F288	; 0230F24C
loc_0230F24E:
	ldr r1,[pool_0230F29C]	; 0230F24E
	ldrh r1,[r0,r1]	; 0230F250
	cmp r1,#0x40	; 0230F252
	bne loc_0230F288	; 0230F254
	ldrh r2,[r5,#0x22]	; 0230F256
	ldr r1,[pool_0230F2A0]	; 0230F258
	ldrh r1,[r0,r1]	; 0230F25A
	cmp r2,r1	; 0230F25C
	bne loc_0230F288	; 0230F25E
	ldrh r2,[r5,#0x20]	; 0230F260
	ldr r1,[pool_0230F2A4]	; 0230F262
	ldrh r1,[r0,r1]	; 0230F264
	cmp r2,r1	; 0230F266
	bne loc_0230F288	; 0230F268
	ldrh r2,[r5,#0x1e]	; 0230F26A
	ldr r1,[pool_0230F2A8]	; 0230F26C
	ldrh r0,[r0,r1]	; 0230F26E
	cmp r2,r0	; 0230F270
	bne loc_0230F288	; 0230F272
	mov r0,#0x30	; 0230F274
	bl loc_0230646C	; 0230F276
	bl loc_023064D8	; 0230F27A
	add r0,r5,#0x0	; 0230F27E
	add r0,#0x1e	; 0230F280
	ldrh r1,[r5,#0x2c]	; 0230F282
	bl loc_023099D4	; 0230F284
loc_0230F288:
	add sp,#0x4	; 0230F288
	pop {r4,r5}	; 0230F28A
	pop {r3}	; 0230F28C
	bx r3	; 0230F28E
pool_0230F290:
loc_0230F290:
	.word FirmwareWlWorkPointerSlot	; 0230F290
pool_0230F294:
loc_0230F294:
	.word 0x00000314	; 0230F294
pool_0230F298:
loc_0230F298:
	.word 0x000002E0	; 0230F298
pool_0230F29C:
loc_0230F29C:
	.word 0x00000310	; 0230F29C
pool_0230F2A0:
loc_0230F2A0:
	.word 0x00000382	; 0230F2A0
pool_0230F2A4:
loc_0230F2A4:
	.word 0x00000380	; 0230F2A4
pool_0230F2A8:
loc_0230F2A8:
	.word 0x0000037E	; 0230F2A8

; ===== function loc_0230F2AC =====
loc_0230F2AC:
	push {r4,r5,r6,r7,lr}	; 0230F2AC
	sub sp,#0x4c	; 0230F2AE
	add r5,r0,#0x0	; 0230F2B0
	ldr r0,[pool_0230F63C]	; 0230F2B2
	ldr r1,[r0,#0x0]	; 0230F2B4
	ldr r0,[pool_0230F640]	; 0230F2B6
	add r1,r1,r0	; 0230F2B8
	ldr r0,[r1,#0x0]	; 0230F2BA
	add r0,r0,#0x1	; 0230F2BC
	str r0,[r1,#0x0]	; 0230F2BE
	add r0,r5,#0x0	; 0230F2C0
	add r0,#0x1e	; 0230F2C2
	bl loc_023093C0	; 0230F2C4
	add r6,r0,#0x0	; 0230F2C8
	lsl r0,r6,#0x10	; 0230F2CA
	lsr r0,r0,#0x10	; 0230F2CC
	strh r0,[r5,#0x2]	; 0230F2CE
	cmp r6,#0xff	; 0230F2D0
	bne loc_0230F2D6	; 0230F2D2
	b loc_0230F802	; 0230F2D4
loc_0230F2D6:
	ldrh r1,[r5,#0x12]	; 0230F2D6
	bl loc_023091D4	; 0230F2D8
	add r4,r5,#0x0	; 0230F2DC
	add r4,#0x2c	; 0230F2DE
	ldrh r7,[r5,#0x6]	; 0230F2E0
	cmp r7,#0xc	; 0230F2E2
	bhi loc_0230F2E8	; 0230F2E4
	b loc_0230F802	; 0230F2E6
loc_0230F2E8:
	mov r0,#0x0	; 0230F2E8
	str r0,[sp,#0x20]	; 0230F2EA
	ldr r0,[sp,#0x20]	; 0230F2EC
	add r1,sp,#0x24	; 0230F2EE
	mov r2,#0x28	; 0230F2F0
	bl loc_0230F830	; 0230F2F2
	add r0,r4,#0x0	; 0230F2F6
	add r0,#0xc	; 0230F2F8
	str r0,[sp,#0x24]	; 0230F2FA
	sub r7,#0xc	; 0230F2FC
	add r1,sp,#0x8	; 0230F2FE
	strh r7,[r1,#0x24]	; 0230F300
	mov r0,#0x2	; 0230F302
	strh r0,[r1,#0x26]	; 0230F304
	ldr r0,[pool_0230F63C]	; 0230F306
	ldr r2,[r0,#0x0]	; 0230F308
	ldr r0,[pool_0230F644]	; 0230F30A
	ldrh r0,[r2,r0]	; 0230F30C
	cmp r0,#0x0	; 0230F30E
	bne loc_0230F31A	; 0230F310
	ldrh r2,[r1,#0x26]	; 0230F312
	mov r0,#0x1	; 0230F314
	orr r2,r0	; 0230F316
	strh r2,[r1,#0x26]	; 0230F318
loc_0230F31A:
	mov r1,#0x38	; 0230F31A
	add r0,sp,#0x8	; 0230F31C
	strh r1,[r0,#0x28]	; 0230F31E
	ldrh r1,[r5,#0x8]	; 0230F320
	strh r1,[r0,#0x20]	; 0230F322
	ldrh r1,[r4,#0xa]	; 0230F324
	strh r1,[r0,#0x22]	; 0230F326
	add r0,sp,#0x24	; 0230F328
	bl loc_0230E27C	; 0230F32A
	ldr r4,[sp,#0x40]	; 0230F32E
	cmp r4,#0x0	; 0230F330
	beq loc_0230F354	; 0230F332
	ldrh r1,[r5,#0x16]	; 0230F334
	ldr r0,[pool_0230F648]	; 0230F336
	and r1,r0	; 0230F338
	cmp r1,#0x0	; 0230F33A
	beq loc_0230F354	; 0230F33C
	add r0,r4,#0x6	; 0230F33E
	bl loc_023053B8	; 0230F340
	add r7,r0,#0x0	; 0230F344
	add r0,r4,#0x7	; 0230F346
	bl loc_023053B8	; 0230F348
	lsl r0,r0,#0x8	; 0230F34C
	add r1,r7,r0	; 0230F34E
	ldr r0,[pool_0230F64C]	; 0230F350
	strh r1,[r0,#0x0]	; 0230F352
loc_0230F354:
	ldr r0,[pool_0230F63C]	; 0230F354
	ldr r0,[r0,#0x0]	; 0230F356
	ldr r1,[pool_0230F650]	; 0230F358
	add r4,r0,r1	; 0230F35A
	ldr r1,[pool_0230F654]	; 0230F35C
	ldrh r3,[r0,r1]	; 0230F35E
	cmp r3,#0x13	; 0230F360
	bne loc_0230F386	; 0230F362
	ldr r1,[pool_0230F658]	; 0230F364
	ldr r0,[r0,r1]	; 0230F366
	ldrh r0,[r0,#0x38]	; 0230F368
	cmp r0,#0x1	; 0230F36A
	bne loc_0230F386	; 0230F36C
	add r0,sp,#0x8	; 0230F36E
	ldrh r1,[r0,#0x26]	; 0230F370
	mov r0,#0x9	; 0230F372
	and r1,r0	; 0230F374
	cmp r1,#0x9	; 0230F376
	beq loc_0230F37C	; 0230F378
	b loc_0230F7F2	; 0230F37A
loc_0230F37C:
	add r0,r5,#0x0	; 0230F37C
	add r1,sp,#0x24	; 0230F37E
	bl loc_0230EA70	; 0230F380
	b loc_0230F7F2	; 0230F384
loc_0230F386:
	add r7,sp,#0x8	; 0230F386
	ldrh r2,[r7,#0x26]	; 0230F388
	mov r0,#0x8	; 0230F38A
	add r1,r2,#0x0	; 0230F38C
	and r1,r0	; 0230F38E
	cmp r1,#0x0	; 0230F390
	bne loc_0230F396	; 0230F392
	b loc_0230F7F2	; 0230F394
loc_0230F396:
	ldrh r1,[r7,#0x28]	; 0230F396
	mov r0,#0x1	; 0230F398
	and r1,r0	; 0230F39A
	cmp r1,#0x0	; 0230F39C
	beq loc_0230F3AE	; 0230F39E
	cmp r1,#0x0	; 0230F3A0
	bne loc_0230F3A6	; 0230F3A2
	b loc_0230F7F2	; 0230F3A4
loc_0230F3A6:
	and r2,r0	; 0230F3A6
	cmp r2,#0x0	; 0230F3A8
	bne loc_0230F3AE	; 0230F3AA
	b loc_0230F7F2	; 0230F3AC
loc_0230F3AE:
	cmp r3,#0x21	; 0230F3AE
	beq loc_0230F3B4	; 0230F3B0
	b loc_0230F4F6	; 0230F3B2
loc_0230F3B4:
	bl loc_02305590	; 0230F3B4
	add r0,sp,#0x8	; 0230F3B8
	ldrh r1,[r0,#0x26]	; 0230F3BA
	mov r2,#0x30	; 0230F3BC
	add r3,r1,#0x0	; 0230F3BE
	and r3,r2	; 0230F3C0
	cmp r3,#0x30	; 0230F3C2
	beq loc_0230F3DA	; 0230F3C4
	mov r2,#0xc	; 0230F3C6
	ldr r3,[pool_0230F63C]	; 0230F3C8
	ldr r1,[r3,#0x0]	; 0230F3CA
	ldr r0,[pool_0230F65C]	; 0230F3CC
	strh r2,[r1,r0]	; 0230F3CE
	mov r2,#0xa	; 0230F3D0
	ldr r1,[r3,#0x0]	; 0230F3D2
	ldr r0,[pool_0230F660]	; 0230F3D4
	strh r2,[r1,r0]	; 0230F3D6
	b loc_0230F4D2	; 0230F3D8
loc_0230F3DA:
	mov r2,#0x4	; 0230F3DA
	and r1,r2	; 0230F3DC
	cmp r1,#0x0	; 0230F3DE
	bne loc_0230F3F6	; 0230F3E0
	mov r2,#0xc	; 0230F3E2
	ldr r3,[pool_0230F63C]	; 0230F3E4
	ldr r1,[r3,#0x0]	; 0230F3E6
	ldr r0,[pool_0230F65C]	; 0230F3E8
	strh r2,[r1,r0]	; 0230F3EA
	mov r2,#0x12	; 0230F3EC
	ldr r1,[r3,#0x0]	; 0230F3EE
	ldr r0,[pool_0230F660]	; 0230F3F0
	strh r2,[r1,r0]	; 0230F3F2
	b loc_0230F4D2	; 0230F3F4
loc_0230F3F6:
	ldrh r2,[r5,#0x34]	; 0230F3F6
	ldr r1,[pool_0230F664]	; 0230F3F8
	cmp r2,r1	; 0230F3FA
	bls loc_0230F412	; 0230F3FC
	mov r2,#0xc	; 0230F3FE
	ldr r3,[pool_0230F63C]	; 0230F400
	ldr r1,[r3,#0x0]	; 0230F402
	ldr r0,[pool_0230F65C]	; 0230F404
	strh r2,[r1,r0]	; 0230F406
	mov r2,#0x1	; 0230F408
	ldr r1,[r3,#0x0]	; 0230F40A
	ldr r0,[pool_0230F660]	; 0230F40C
	strh r2,[r1,r0]	; 0230F40E
	b loc_0230F4D2	; 0230F410
loc_0230F412:
	mov r1,#0x0	; 0230F412
	ldr r2,[pool_0230F63C]	; 0230F414
	ldr r3,[r2,#0x0]	; 0230F416
	ldr r2,[pool_0230F65C]	; 0230F418
	strh r1,[r3,r2]	; 0230F41A
	ldrh r3,[r0,#0x28]	; 0230F41C
	mov r2,#0x2	; 0230F41E
	and r3,r2	; 0230F420
	cmp r3,#0x0	; 0230F422
	beq loc_0230F434	; 0230F424
	ldrh r3,[r0,#0x26]	; 0230F426
	and r3,r2	; 0230F428
	cmp r3,#0x0	; 0230F42A
	bne loc_0230F434	; 0230F42C
	ldrh r0,[r0,#0x2e]	; 0230F42E
	bl loc_02306948	; 0230F430
loc_0230F434:
	ldrh r0,[r4,#0xc]	; 0230F434
	cmp r0,#0x2	; 0230F436
	bne loc_0230F488	; 0230F438
	ldr r7,[sp,#0x48]	; 0230F43A
	cmp r7,#0x0	; 0230F43C
	beq loc_0230F47A	; 0230F43E
	add r0,r7,#0x6	; 0230F440
	bl loc_023053B8	; 0230F442
	str r0,[sp,#0x0]	; 0230F446
	add r0,r7,#0x7	; 0230F448
	bl loc_023053B8	; 0230F44A
	lsl r1,r0,#0x8	; 0230F44E
	ldr r0,[sp,#0x0]	; 0230F450
	add r0,r0,r1	; 0230F452
	lsl r0,r0,#0x10	; 0230F454
	lsr r0,r0,#0x10	; 0230F456
	mov r1,#0x1	; 0230F458
	bl loc_02306FCC	; 0230F45A
	ldr r0,[sp,#0x48]	; 0230F45E
	add r0,#0x8	; 0230F460
	bl loc_023053B8	; 0230F462
	add r7,r0,#0x0	; 0230F466
	ldr r0,[sp,#0x48]	; 0230F468
	add r0,#0x9	; 0230F46A
	bl loc_023053B8	; 0230F46C
	lsl r0,r0,#0x8	; 0230F470
	add r1,r7,r0	; 0230F472
	ldr r0,[pool_0230F668]	; 0230F474
	strh r1,[r0,#0x0]	; 0230F476
	b loc_0230F488	; 0230F478
loc_0230F47A:
	ldr r0,[pool_0230F66C]	; 0230F47A
	mov r1,#0x1	; 0230F47C
	bl loc_02306FCC	; 0230F47E
	mov r1,#0x0	; 0230F482
	ldr r0,[pool_0230F668]	; 0230F484
	strh r1,[r0,#0x0]	; 0230F486
loc_0230F488:
	ldr r0,[sp,#0x44]	; 0230F488
	add r0,r0,#0x3	; 0230F48A
	bl loc_023053B8	; 0230F48C
	bl loc_02306BF4	; 0230F490
	ldr r0,[sp,#0x44]	; 0230F494
	add r0,r0,#0x2	; 0230F496
	bl loc_023053B8	; 0230F498
	add r1,r4,#0x0	; 0230F49C
	add r1,#0x6a	; 0230F49E
	strh r0,[r1,#0x0]	; 0230F4A0
	ldrh r0,[r5,#0x34]	; 0230F4A2
	bl loc_02306C1C	; 0230F4A4
	add r0,r4,#0x0	; 0230F4A8
	add r0,#0xe	; 0230F4AA
	ldrh r2,[r0,#0x0]	; 0230F4AC
	mov r1,#0x4	; 0230F4AE
	orr r2,r1	; 0230F4B0
	strh r2,[r0,#0x0]	; 0230F4B2
	ldrh r2,[r0,#0x0]	; 0230F4B4
	mov r1,#0x40	; 0230F4B6
	orr r2,r1	; 0230F4B8
	strh r2,[r0,#0x0]	; 0230F4BA
	ldrh r0,[r4,#0xc]	; 0230F4BC
	cmp r0,#0x2	; 0230F4BE
	bne loc_0230F4C8	; 0230F4C0
	mov r1,#0x3	; 0230F4C2
	ldr r0,[pool_0230F670]	; 0230F4C4
	strh r1,[r0,#0x0]	; 0230F4C6
loc_0230F4C8:
	ldr r2,[pool_0230F674]	; 0230F4C8
	ldrh r1,[r2,#0x0]	; 0230F4CA
	mov r0,#0x1	; 0230F4CC
	orr r1,r0	; 0230F4CE
	strh r1,[r2,#0x0]	; 0230F4D0
loc_0230F4D2:
	ldr r0,[pool_0230F63C]	; 0230F4D2
	ldr r1,[r0,#0x0]	; 0230F4D4
	ldr r0,[pool_0230F678]	; 0230F4D6
	ldr r0,[r1,r0]	; 0230F4D8
	add r0,#0x8	; 0230F4DA
	add r1,r5,#0x0	; 0230F4DC
	add r1,#0x1e	; 0230F4DE
	bl loc_0230645C	; 0230F4E0
	mov r2,#0x25	; 0230F4E4
	ldr r0,[pool_0230F63C]	; 0230F4E6
	ldr r1,[r0,#0x0]	; 0230F4E8
	ldr r0,[pool_0230F654]	; 0230F4EA
	strh r2,[r1,r0]	; 0230F4EC
	mov r0,#0x2	; 0230F4EE
	mov r1,#0x1	; 0230F4F0
	bl loc_02304B6C	; 0230F4F2
loc_0230F4F6:
	ldrh r0,[r4,#0xc]	; 0230F4F6
	cmp r0,#0x1	; 0230F4F8
	bne loc_0230F4FE	; 0230F4FA
	b loc_0230F7DC	; 0230F4FC
loc_0230F4FE:
	cmp r0,#0x2	; 0230F4FE
	beq loc_0230F508	; 0230F500
	cmp r0,#0x3	; 0230F502
	beq loc_0230F59A	; 0230F504
	b loc_0230F7DC	; 0230F506
loc_0230F508:
	ldr r7,[sp,#0x48]	; 0230F508
	cmp r7,#0x0	; 0230F50A
	beq loc_0230F59A	; 0230F50C
	add r0,r7,#0x6	; 0230F50E
	bl loc_023053B8	; 0230F510
	str r0,[sp,#0x4]	; 0230F514
	add r0,r7,#0x7	; 0230F516
	bl loc_023053B8	; 0230F518
	lsl r1,r0,#0x8	; 0230F51C
	ldr r0,[sp,#0x4]	; 0230F51E
	add r0,r0,r1	; 0230F520
	lsl r0,r0,#0x10	; 0230F522
	lsr r0,r0,#0x10	; 0230F524
	mov r1,#0x0	; 0230F526
	bl loc_02306FCC	; 0230F528
	ldr r0,[sp,#0x48]	; 0230F52C
	add r0,#0x8	; 0230F52E
	bl loc_023053B8	; 0230F530
	add r7,r0,#0x0	; 0230F534
	ldr r0,[sp,#0x48]	; 0230F536
	add r0,#0x9	; 0230F538
	bl loc_023053B8	; 0230F53A
	lsl r0,r0,#0x8	; 0230F53E
	add r1,r7,r0	; 0230F540
	ldr r0,[pool_0230F668]	; 0230F542
	strh r1,[r0,#0x0]	; 0230F544
	ldr r0,[sp,#0x48]	; 0230F546
	add r0,r0,#0x1	; 0230F548
	bl loc_023053B8	; 0230F54A
	sub r0,#0x8	; 0230F54E
	add r1,r4,#0x0	; 0230F550
	add r1,#0x94	; 0230F552
	strh r0,[r1,#0x0]	; 0230F554
	add r0,r4,#0x0	; 0230F556
	add r0,#0x94	; 0230F558
	ldrh r2,[r0,#0x0]	; 0230F55A
	cmp r2,#0x0	; 0230F55C
	beq loc_0230F59A	; 0230F55E
	ldr r0,[sp,#0x48]	; 0230F560
	mov r1,#0x1	; 0230F562
	add r3,r0,#0x0	; 0230F564
	and r3,r1	; 0230F566
	cmp r3,#0x0	; 0230F568
	beq loc_0230F584	; 0230F56A
	add r0,#0x9	; 0230F56C
	add r1,r4,#0x0	; 0230F56E
	add r1,#0x90	; 0230F570
	ldr r1,[r1,#0x0]	; 0230F572
	add r2,r2,#0x2	; 0230F574
	bl loc_0230F83C	; 0230F576
	mov r1,#0x1	; 0230F57A
	add r0,r4,#0x0	; 0230F57C
	add r0,#0x96	; 0230F57E
	strh r1,[r0,#0x0]	; 0230F580
	b loc_0230F59A	; 0230F582
loc_0230F584:
	add r0,#0xa	; 0230F584
	add r1,r4,#0x0	; 0230F586
	add r1,#0x90	; 0230F588
	ldr r1,[r1,#0x0]	; 0230F58A
	add r2,r2,#0x1	; 0230F58C
	bl loc_0230F848	; 0230F58E
	mov r1,#0x0	; 0230F592
	add r0,r4,#0x0	; 0230F594
	add r0,#0x96	; 0230F596
	strh r1,[r0,#0x0]	; 0230F598
loc_0230F59A:
	mov r7,#0x0	; 0230F59A
	add r0,r4,#0x0	; 0230F59C
	add r0,#0x74	; 0230F59E
	strh r7,[r0,#0x0]	; 0230F5A0
	mov r0,#0x1c	; 0230F5A2
	mul r6,r0	; 0230F5A4
	ldr r0,[pool_0230F63C]	; 0230F5A6
	ldr r2,[r0,#0x0]	; 0230F5A8
	ldr r1,[pool_0230F67C]	; 0230F5AA
	ldr r1,[r2,r1]	; 0230F5AC
	add r2,r1,r6	; 0230F5AE
	ldrh r1,[r2,#0x1a]	; 0230F5B0
	strh r1,[r2,#0x18]	; 0230F5B2
	add r1,r5,#0x0	; 0230F5B4
	add r1,#0x2c	; 0230F5B6
	ldmia r1!,{r2,r3}	; 0230F5B8
	add r1,sp,#0x8	; 0230F5BA
	stmia r1!,{r2,r3}	; 0230F5BC
	ldr r1,[r0,#0x0]	; 0230F5BE
	ldr r0,[pool_0230F680]	; 0230F5C0
	ldrh r0,[r1,r0]	; 0230F5C2
	lsl r6,r0,#0xa	; 0230F5C4
	ldr r0,[sp,#0x8]	; 0230F5C6
	ldr r1,[sp,#0xc]	; 0230F5C8
	add r2,r6,#0x0	; 0230F5CA
	add r3,r7,#0x0	; 0230F5CC
	bl loc_0230F854	; 0230F5CE
	str r0,[sp,#0x8]	; 0230F5D2
	str r1,[sp,#0xc]	; 0230F5D4
	lsl r3,r7,#0	; 0230F5D6
	mov r2,#0x1	; 0230F5D8
	add r0,r0,r2	; 0230F5DA
	adc r1,r3	; 0230F5DC
	str r0,[sp,#0x8]	; 0230F5DE
	str r1,[sp,#0xc]	; 0230F5E0
	add r2,r6,#0x0	; 0230F5E2
	bl loc_0230F860	; 0230F5E4
	str r0,[sp,#0x8]	; 0230F5E8
	str r1,[sp,#0xc]	; 0230F5EA
	add r0,sp,#0x8	; 0230F5EC
	ldrh r2,[r0,#0x6]	; 0230F5EE
	ldr r1,[pool_0230F684]	; 0230F5F0
	strh r2,[r1,#0x0]	; 0230F5F2
	ldrh r2,[r0,#0x4]	; 0230F5F4
	ldr r1,[pool_0230F688]	; 0230F5F6
	strh r2,[r1,#0x0]	; 0230F5F8
	ldrh r2,[r0,#0x2]	; 0230F5FA
	ldr r1,[pool_0230F68C]	; 0230F5FC
	strh r2,[r1,#0x0]	; 0230F5FE
	ldrh r1,[r0,#0x0]	; 0230F600
	mov r0,#0x1	; 0230F602
	orr r1,r0	; 0230F604
	ldr r0,[pool_0230F690]	; 0230F606
	strh r1,[r0,#0x0]	; 0230F608
	ldrh r0,[r4,#0xe]	; 0230F60A
	lsl r0,r0,#0x19	; 0230F60C
	lsr r0,r0,#0x1f	; 0230F60E
	cmp r0,#0x0	; 0230F610
	beq loc_0230F708	; 0230F612
	ldr r0,[sp,#0x8]	; 0230F614
	ldr r1,[sp,#0xc]	; 0230F616
	sub r0,r0,r6	; 0230F618
	sbc r1,r7	; 0230F61A
	str r0,[sp,#0x8]	; 0230F61C
	str r1,[sp,#0xc]	; 0230F61E
	bl loc_0230F86C	; 0230F620
	ldr r2,[pool_0230F694]	; 0230F624
	ldrh r1,[r2,#0x0]	; 0230F626
	add r6,sp,#0x8	; 0230F628
	strh r1,[r6,#0x8]	; 0230F62A
	ldr r1,[pool_0230F698]	; 0230F62C
	ldrh r3,[r1,#0x0]	; 0230F62E
	strh r3,[r6,#0xa]	; 0230F630
	ldr r7,[pool_0230F69C]	; 0230F632
	ldrh r3,[r7,#0x0]	; 0230F634
	strh r3,[r6,#0xc]	; 0230F636
	ldr r3,[pool_0230F6A0]	; 0230F638
	b loc_0230F6A4	; 0230F63A
pool_0230F63C:
loc_0230F63C:
	.word FirmwareWlWorkPointerSlot	; 0230F63C
pool_0230F640:
loc_0230F640:
	.word 0x00000528	; 0230F640
pool_0230F644:
loc_0230F644:
	.word 0x0000031A	; 0230F644
pool_0230F648:
loc_0230F648:
	.word 0x00008000	; 0230F648
pool_0230F64C:
loc_0230F64C:
	.word REG_WIFI_CONTENTFREE	; 0230F64C
pool_0230F650:
loc_0230F650:
	.word 0x00000308	; 0230F650
pool_0230F654:
loc_0230F654:
	.word 0x000003BC	; 0230F654
pool_0230F658:
loc_0230F658:
	.word 0x000003D4	; 0230F658
pool_0230F65C:
loc_0230F65C:
	.word 0x000003C0	; 0230F65C
pool_0230F660:
loc_0230F660:
	.word 0x000003C2	; 0230F660
pool_0230F664:
loc_0230F664:
	.word 0x000003E8	; 0230F664
pool_0230F668:
loc_0230F668:
	.word FirmwareWlAdjustedTimeSlot	; 0230F668
pool_0230F66C:
loc_0230F66C:
	.word 0x0000FFFF	; 0230F66C
pool_0230F670:
loc_0230F670:
	.word REG_WIFI_UNKNOWN_048	; 0230F670
pool_0230F674:
loc_0230F674:
	.word REG_WIFI_POWER_TX	; 0230F674
pool_0230F678:
loc_0230F678:
	.word 0x000003D8	; 0230F678
pool_0230F67C:
loc_0230F67C:
	.word 0x000002E0	; 0230F67C
pool_0230F680:
loc_0230F680:
	.word 0x0000036A	; 0230F680
pool_0230F684:
loc_0230F684:
	.word REG_WIFI_US_COMPARE3	; 0230F684
pool_0230F688:
loc_0230F688:
	.word REG_WIFI_US_COMPARE2	; 0230F688
pool_0230F68C:
loc_0230F68C:
	.word REG_WIFI_US_COMPARE1	; 0230F68C
pool_0230F690:
loc_0230F690:
	.word REG_WIFI_US_COMPARE0	; 0230F690
pool_0230F694:
loc_0230F694:
	.word REG_WIFI_US_COUNT0	; 0230F694
pool_0230F698:
loc_0230F698:
	.word REG_WIFI_US_COUNT1	; 0230F698
pool_0230F69C:
loc_0230F69C:
	.word REG_WIFI_US_COUNT2	; 0230F69C
pool_0230F6A0:
loc_0230F6A0:
	.word REG_WIFI_US_COUNT3	; 0230F6A0
loc_0230F6A4:
	ldrh r3,[r3,#0x0]	; 0230F6A4
	strh r3,[r6,#0xe]	; 0230F6A6
	ldrh r2,[r2,#0x0]	; 0230F6A8
	strh r2,[r6,#0x10]	; 0230F6AA
	ldrh r1,[r1,#0x0]	; 0230F6AC
	strh r1,[r6,#0x12]	; 0230F6AE
	ldrh r1,[r7,#0x0]	; 0230F6B0
	strh r1,[r6,#0x14]	; 0230F6B2
	ldr r1,[pool_0230F80C]	; 0230F6B4
	ldrh r1,[r1,#0x0]	; 0230F6B6
	strh r1,[r6,#0x16]	; 0230F6B8
	bl loc_0230F878	; 0230F6BA
	lsl r0,r6,#0	; 0230F6BE
	ldrh r1,[r0,#0x8]	; 0230F6C0
	ldrh r0,[r0,#0x10]	; 0230F6C2
	cmp r1,r0	; 0230F6C4
	bcs loc_0230F6DC	; 0230F6C6
	ldr r2,[sp,#0x10]	; 0230F6C8
	ldr r3,[sp,#0x14]	; 0230F6CA
	ldr r1,[sp,#0x8]	; 0230F6CC
	ldr r0,[sp,#0xc]	; 0230F6CE
	sub r2,r2,r1	; 0230F6D0
	sbc r3,r0	; 0230F6D2
	lsl r1,r3,#0x16	; 0230F6D4
	lsr r0,r2,#0xa	; 0230F6D6
	orr r0,r1	; 0230F6D8
	b loc_0230F6EE	; 0230F6DA
loc_0230F6DC:
	ldr r2,[sp,#0x18]	; 0230F6DC
	ldr r3,[sp,#0x1c]	; 0230F6DE
	ldr r1,[sp,#0x8]	; 0230F6E0
	ldr r0,[sp,#0xc]	; 0230F6E2
	sub r2,r2,r1	; 0230F6E4
	sbc r3,r0	; 0230F6E6
	lsl r1,r3,#0x16	; 0230F6E8
	lsr r0,r2,#0xa	; 0230F6EA
	orr r0,r1	; 0230F6EC
loc_0230F6EE:
	ldr r1,[pool_0230F810]	; 0230F6EE
	ldr r2,[r1,#0x0]	; 0230F6F0
	ldr r1,[pool_0230F814]	; 0230F6F2
	ldrh r1,[r2,r1]	; 0230F6F4
	cmp r0,r1	; 0230F6F6
	bcs loc_0230F702	; 0230F6F8
	sub r1,r1,r0	; 0230F6FA
	ldr r0,[pool_0230F818]	; 0230F6FC
	strh r1,[r0,#0x0]	; 0230F6FE
	b loc_0230F708	; 0230F700
loc_0230F702:
	mov r1,#0x0	; 0230F702
	ldr r0,[pool_0230F818]	; 0230F704
	strh r1,[r0,#0x0]	; 0230F706
loc_0230F708:
	ldr r0,[pool_0230F810]	; 0230F708
	ldr r2,[r0,#0x0]	; 0230F70A
	ldr r0,[pool_0230F81C]	; 0230F70C
	ldrh r0,[r2,r0]	; 0230F70E
	cmp r0,#0x40	; 0230F710
	bne loc_0230F7DC	; 0230F712
	ldr r1,[sp,#0x44]	; 0230F714
	cmp r1,#0x0	; 0230F716
	beq loc_0230F7DC	; 0230F718
	ldr r0,[pool_0230F820]	; 0230F71A
	ldrh r0,[r2,r0]	; 0230F71C
	lsl r0,r0,#0x1f	; 0230F71E
	lsr r0,r0,#0x1f	; 0230F720
	cmp r0,#0x1	; 0230F722
	bne loc_0230F7DC	; 0230F724
	add r0,r1,#0x2	; 0230F726
	bl loc_023053B8	; 0230F728
	add r1,r4,#0x0	; 0230F72C
	add r1,#0x6a	; 0230F72E
	ldrh r1,[r1,#0x0]	; 0230F730
	cmp r1,r0	; 0230F732
	beq loc_0230F73C	; 0230F734
	add r1,r4,#0x0	; 0230F736
	add r1,#0x6a	; 0230F738
	strh r0,[r1,#0x0]	; 0230F73A
loc_0230F73C:
	mov r2,#0x0	; 0230F73C
	add r1,r4,#0x0	; 0230F73E
	add r1,#0x82	; 0230F740
	strh r2,[r1,#0x0]	; 0230F742
	cmp r0,#0x0	; 0230F744
	bne loc_0230F762	; 0230F746
	ldr r0,[sp,#0x44]	; 0230F748
	add r0,r0,#0x4	; 0230F74A
	bl loc_023053B8	; 0230F74C
	mov r1,#0x1	; 0230F750
	and r0,r1	; 0230F752
	cmp r0,#0x0	; 0230F754
	beq loc_0230F762	; 0230F756
	add r2,r4,#0x0	; 0230F758
	add r2,#0x82	; 0230F75A
	ldrh r0,[r2,#0x0]	; 0230F75C
	orr r0,r1	; 0230F75E
	strh r0,[r2,#0x0]	; 0230F760
loc_0230F762:
	ldr r0,[sp,#0x44]	; 0230F762
	add r0,r0,#0x4	; 0230F764
	bl loc_023053B8	; 0230F766
	mov r1,#0xfe	; 0230F76A
	add r7,r0,#0x0	; 0230F76C
	and r7,r1	; 0230F76E
	lsl r6,r7,#0x3	; 0230F770
	ldr r0,[sp,#0x44]	; 0230F772
	add r0,r0,#0x1	; 0230F774
	bl loc_023053B8	; 0230F776
	add r0,r7,r0	; 0230F77A
	sub r0,r0,#0x3	; 0230F77C
	lsl r1,r0,#0x3	; 0230F77E
	add r0,r4,#0x0	; 0230F780
	add r0,#0x5e	; 0230F782
	ldrh r0,[r0,#0x0]	; 0230F784
	cmp r6,r0	; 0230F786
	bhi loc_0230F7BA	; 0230F788
	cmp r0,r1	; 0230F78A
	bhi loc_0230F7BA	; 0230F78C
	sub r6,r0,r6	; 0230F78E
	ldr r0,[sp,#0x44]	; 0230F790
	add r1,r0,#0x5	; 0230F792
	lsr r0,r6,#0x3	; 0230F794
	add r0,r1,r0	; 0230F796
	bl loc_023053B8	; 0230F798
	mov r2,#0x1	; 0230F79C
	mov r1,#0x7	; 0230F79E
	and r6,r1	; 0230F7A0
	lsl r2,r6	; 0230F7A2
	and r2,r0	; 0230F7A4
	cmp r2,#0x0	; 0230F7A6
	beq loc_0230F7BA	; 0230F7A8
	add r2,r4,#0x0	; 0230F7AA
	add r2,#0x82	; 0230F7AC
	ldrh r1,[r2,#0x0]	; 0230F7AE
	mov r0,#0x2	; 0230F7B0
	orr r1,r0	; 0230F7B2
	strh r1,[r2,#0x0]	; 0230F7B4
	bl loc_0230CA88	; 0230F7B6
loc_0230F7BA:
	ldr r0,[pool_0230F810]	; 0230F7BA
	ldr r1,[r0,#0x0]	; 0230F7BC
	ldr r0,[pool_0230F824]	; 0230F7BE
	ldrh r0,[r1,r0]	; 0230F7C0
	cmp r0,#0x0	; 0230F7C2
	bne loc_0230F7DC	; 0230F7C4
	ldr r0,[pool_0230F828]	; 0230F7C6
	ldrh r0,[r1,r0]	; 0230F7C8
	cmp r0,#0x0	; 0230F7CA
	bne loc_0230F7DC	; 0230F7CC
	add r4,#0x82	; 0230F7CE
	ldrh r0,[r4,#0x0]	; 0230F7D0
	cmp r0,#0x0	; 0230F7D2
	bne loc_0230F7DC	; 0230F7D4
	mov r0,#0x1	; 0230F7D6
	bl loc_02306814	; 0230F7D8
loc_0230F7DC:
	ldr r0,[pool_0230F810]	; 0230F7DC
	ldr r1,[r0,#0x0]	; 0230F7DE
	ldr r0,[pool_0230F82C]	; 0230F7E0
	ldrh r0,[r1,r0]	; 0230F7E2
	lsl r0,r0,#0x19	; 0230F7E4
	lsr r0,r0,#0x1f	; 0230F7E6
	cmp r0,#0x0	; 0230F7E8
	beq loc_0230F7F2	; 0230F7EA
	add r0,r5,#0x0	; 0230F7EC
	bl loc_02309830	; 0230F7EE
loc_0230F7F2:
	ldr r2,[sp,#0x3c]	; 0230F7F2
	cmp r2,#0x0	; 0230F7F4
	beq loc_0230F802	; 0230F7F6
	add r0,sp,#0x8	; 0230F7F8
	ldrh r0,[r0,#0x2e]	; 0230F7FA
	add r1,r5,#0x0	; 0230F7FC
	bl loc_0230FFC4	; 0230F7FE
loc_0230F802:
	add sp,#0x4c	; 0230F802
	pop {r4,r5,r6,r7}	; 0230F804
	pop {r3}	; 0230F806
	bx r3	; 0230F808
	.byte 0xC0, 0x46	; 0230F80C
pool_0230F80C:
loc_0230F80C:
	.word REG_WIFI_US_COUNT3	; 0230F80C
pool_0230F810:
loc_0230F810:
	.word FirmwareWlWorkPointerSlot	; 0230F810
pool_0230F814:
loc_0230F814:
	.word 0x00000300	; 0230F814
pool_0230F818:
loc_0230F818:
	.word REG_WIFI_POST_BEACON	; 0230F818
pool_0230F81C:
loc_0230F81C:
	.word 0x00000310	; 0230F81C
pool_0230F820:
loc_0230F820:
	.word 0x00000316	; 0230F820
pool_0230F824:
loc_0230F824:
	.word 0x00000160	; 0230F824
pool_0230F828:
loc_0230F828:
	.word 0x0000016C	; 0230F828
pool_0230F82C:
loc_0230F82C:
	.word 0x000002FE	; 0230F82C

; ===== function loc_0230F830 =====
loc_0230F830:
	bx pc	; 0230F830
	.byte 0xC0, 0x46	; 0230F834
.arm

; ===== function loc_0230F834 =====
loc_0230F834:
	ldr pc,[pool_0230F838]	; 0230F834
pool_0230F838:
loc_0230F838:
	.word loc_037FCE38	; 0230F838
.thumb

; ===== function loc_0230F83C =====
loc_0230F83C:
	bx pc	; 0230F83C
	.byte 0xC0, 0x46	; 0230F840
.arm

; ===== function loc_0230F840 =====
loc_0230F840:
	ldr pc,[pool_0230F844]	; 0230F840
pool_0230F844:
loc_0230F844:
	.word P2_Entry_037FCE1C	; 0230F844
.thumb

; ===== function loc_0230F848 =====
loc_0230F848:
	bx pc	; 0230F848
	.byte 0xC0, 0x46	; 0230F84C
.arm

; ===== function loc_0230F84C =====
loc_0230F84C:
	ldr pc,[pool_0230F850]	; 0230F84C
pool_0230F850:
loc_0230F850:
	.word P2_Entry_037FCE1C	; 0230F850
.thumb

; ===== function loc_0230F854 =====
loc_0230F854:
	bx pc	; 0230F854
	.byte 0xC0, 0x46	; 0230F858
.arm

; ===== function loc_0230F858 =====
loc_0230F858:
	ldr pc,[pool_0230F85C]	; 0230F858
pool_0230F85C:
loc_0230F85C:
	.word loc_038022BC	; 0230F85C
.thumb

; ===== function loc_0230F860 =====
loc_0230F860:
	bx pc	; 0230F860
	.byte 0xC0, 0x46	; 0230F864
.arm

; ===== function loc_0230F864 =====
loc_0230F864:
	ldr pc,[pool_0230F868]	; 0230F864
pool_0230F868:
loc_0230F868:
	.word loc_038024C4	; 0230F868
.thumb

; ===== function loc_0230F86C =====
loc_0230F86C:
	bx pc	; 0230F86C
	.byte 0xC0, 0x46	; 0230F870
.arm

; ===== function loc_0230F870 =====
loc_0230F870:
	ldr pc,[pool_0230F874]	; 0230F870
pool_0230F874:
loc_0230F874:
	.word loc_037FCBF0	; 0230F874
.thumb

; ===== function loc_0230F878 =====
loc_0230F878:
	bx pc	; 0230F878
	.byte 0xC0, 0x46	; 0230F87C
.arm

; ===== function loc_0230F87C =====
loc_0230F87C:
	ldr pc,[pool_0230F880]	; 0230F87C
pool_0230F880:
loc_0230F880:
	.word loc_037FCC04	; 0230F880
.thumb

; ===== function loc_0230F884 =====
loc_0230F884:
	push {r4,r5,r6,r7,lr}	; 0230F884
	sub sp,#0x4	; 0230F886
	ldr r1,[pool_0230F94C]	; 0230F888
	ldr r3,[r1,#0x0]	; 0230F88A
	ldr r1,[pool_0230F950]	; 0230F88C
	add r1,r3,r1	; 0230F88E
	ldr r2,[pool_0230F954]	; 0230F890
	ldrh r2,[r3,r2]	; 0230F892
	cmp r2,#0x40	; 0230F894
	beq loc_0230F89C	; 0230F896
	mov r0,#0x1	; 0230F898
	b loc_0230F942	; 0230F89A
loc_0230F89C:
	ldrh r3,[r0,#0x22]	; 0230F89C
	add r2,r1,#0x0	; 0230F89E
	add r2,#0x5c	; 0230F8A0
	ldrh r2,[r2,#0x0]	; 0230F8A2
	cmp r3,r2	; 0230F8A4
	bne loc_0230F8C4	; 0230F8A6
	ldrh r3,[r0,#0x20]	; 0230F8A8
	add r2,r1,#0x0	; 0230F8AA
	add r2,#0x5a	; 0230F8AC
	ldrh r2,[r2,#0x0]	; 0230F8AE
	cmp r3,r2	; 0230F8B0
	bne loc_0230F8C4	; 0230F8B2
	ldrh r3,[r0,#0x1e]	; 0230F8B4
	add r2,r1,#0x0	; 0230F8B6
	add r2,#0x58	; 0230F8B8
	ldrh r2,[r2,#0x0]	; 0230F8BA
	cmp r3,r2	; 0230F8BC
	bne loc_0230F8C4	; 0230F8BE
	mov r2,#0x1	; 0230F8C0
	b loc_0230F8C6	; 0230F8C2
loc_0230F8C4:
	mov r2,#0x0	; 0230F8C4
loc_0230F8C6:
	cmp r2,#0x0	; 0230F8C6
	beq loc_0230F8F6	; 0230F8C8
	ldrh r3,[r0,#0x28]	; 0230F8CA
	add r2,r1,#0x0	; 0230F8CC
	add r2,#0x7a	; 0230F8CE
	ldrh r2,[r2,#0x0]	; 0230F8D0
	cmp r3,r2	; 0230F8D2
	bne loc_0230F8F0	; 0230F8D4
	ldrh r3,[r0,#0x26]	; 0230F8D6
	add r2,r1,#0x0	; 0230F8D8
	add r2,#0x78	; 0230F8DA
	ldrh r2,[r2,#0x0]	; 0230F8DC
	cmp r3,r2	; 0230F8DE
	bne loc_0230F8F0	; 0230F8E0
	ldrh r2,[r0,#0x24]	; 0230F8E2
	add r1,#0x76	; 0230F8E4
	ldrh r1,[r1,#0x0]	; 0230F8E6
	cmp r2,r1	; 0230F8E8
	bne loc_0230F8F0	; 0230F8EA
	mov r1,#0x1	; 0230F8EC
	b loc_0230F8F2	; 0230F8EE
loc_0230F8F0:
	mov r1,#0x0	; 0230F8F0
loc_0230F8F2:
	cmp r1,#0x0	; 0230F8F2
	bne loc_0230F8FA	; 0230F8F4
loc_0230F8F6:
	mov r0,#0x1	; 0230F8F6
	b loc_0230F942	; 0230F8F8
loc_0230F8FA:
	ldrh r1,[r0,#0x10]	; 0230F8FA
	sub r1,#0x1c	; 0230F8FC
	strh r1,[r0,#0x6]	; 0230F8FE
	add r5,r0,#0x0	; 0230F900
	sub r5,#0x10	; 0230F902
	ldr r0,[pool_0230F958]	; 0230F904
	strh r0,[r5,#0xc]	; 0230F906
	mov r0,#0x18	; 0230F908
	strh r0,[r5,#0xe]	; 0230F90A
	add r4,r5,#0x0	; 0230F90C
	add r4,#0x18	; 0230F90E
	ldrh r3,[r4,#0x0]	; 0230F910
	ldr r0,[pool_0230F95C]	; 0230F912
	ldrh r0,[r0,#0x0]	; 0230F914
	ldr r7,[pool_0230F960]	; 0230F916
	and r0,r7	; 0230F918
	asr r2,r0,#0x3	; 0230F91A
	ldr r0,[pool_0230F94C]	; 0230F91C
	ldr r6,[r0,#0x0]	; 0230F91E
	ldr r1,[pool_0230F964]	; 0230F920
	ldrh r1,[r6,r1]	; 0230F922
	ldr r6,[pool_0230F968]	; 0230F924
	ldrh r6,[r6,#0x0]	; 0230F926
	and r6,r7	; 0230F928
	asr r6,r6,#0x4	; 0230F92A
	orr r1,r6	; 0230F92C
	orr r2,r1	; 0230F92E
	orr r3,r2	; 0230F930
	strh r3,[r4,#0x0]	; 0230F932
	ldr r1,[r0,#0x0]	; 0230F934
	ldr r0,[pool_0230F96C]	; 0230F936
	add r0,r1,r0	; 0230F938
	add r1,r5,#0x0	; 0230F93A
	bl loc_02309578	; 0230F93C
	mov r0,#0x0	; 0230F940
loc_0230F942:
	add sp,#0x4	; 0230F942
	pop {r4,r5,r6,r7}	; 0230F944
	pop {r3}	; 0230F946
	bx r3	; 0230F948
	.byte 0xC0, 0x46	; 0230F94C
pool_0230F94C:
loc_0230F94C:
	.word FirmwareWlWorkPointerSlot	; 0230F94C
pool_0230F950:
loc_0230F950:
	.word 0x00000308	; 0230F950
pool_0230F954:
loc_0230F954:
	.word 0x00000310	; 0230F954
pool_0230F958:
loc_0230F958:
	.word 0x00000185	; 0230F958
pool_0230F95C:
loc_0230F95C:
	.word REG_WIFI_TXBUF_REPLY1	; 0230F95C
pool_0230F960:
loc_0230F960:
	.word 0x00008000	; 0230F960
pool_0230F964:
loc_0230F964:
	.word 0x0000049E	; 0230F964
pool_0230F968:
loc_0230F968:
	.word REG_WIFI_TXBUF_REPLY2	; 0230F968
pool_0230F96C:
loc_0230F96C:
	.word 0x0000014C	; 0230F96C

; ===== function loc_0230F970 =====
loc_0230F970:
	push {r4,r5,r6,r7,lr}	; 0230F970
	sub sp,#0x4	; 0230F972
	add r5,r0,#0x0	; 0230F974
	ldr r0,[pool_0230FABC]	; 0230F976
	ldr r0,[r0,#0x0]	; 0230F978
	ldr r1,[pool_0230FAC0]	; 0230F97A
	add r7,r0,r1	; 0230F97C
	ldr r1,[pool_0230FAC4]	; 0230F97E
	ldr r6,[r0,r1]	; 0230F980
	add r6,#0x10	; 0230F982
	ldrh r1,[r7,#0x3c]	; 0230F984
	cmp r1,#0x0	; 0230F986
	bne loc_0230F98C	; 0230F988
	b loc_0230FAB2	; 0230F98A
loc_0230F98C:
	ldrh r2,[r5,#0x1c]	; 0230F98C
	ldr r1,[pool_0230FAC8]	; 0230F98E
	ldrh r1,[r0,r1]	; 0230F990
	cmp r2,r1	; 0230F992
	beq loc_0230F998	; 0230F994
	b loc_0230FAB2	; 0230F996
loc_0230F998:
	ldrh r2,[r5,#0x1a]	; 0230F998
	ldr r1,[pool_0230FACC]	; 0230F99A
	ldrh r1,[r0,r1]	; 0230F99C
	cmp r2,r1	; 0230F99E
	beq loc_0230F9A4	; 0230F9A0
	b loc_0230FAB2	; 0230F9A2
loc_0230F9A4:
	ldrh r2,[r5,#0x18]	; 0230F9A4
	ldr r1,[pool_0230FAD0]	; 0230F9A6
	ldrh r0,[r0,r1]	; 0230F9A8
	cmp r2,r0	; 0230F9AA
	beq loc_0230F9B0	; 0230F9AC
	b loc_0230FAB2	; 0230F9AE
loc_0230F9B0:
	ldrh r1,[r5,#0x10]	; 0230F9B0
	sub r1,#0x18	; 0230F9B2
	ldrh r0,[r6,#0x6]	; 0230F9B4
	sub r0,#0x8	; 0230F9B6
	cmp r1,r0	; 0230F9B8
	bgt loc_0230FAB2	; 0230F9BA
	add r0,r5,#0x0	; 0230F9BC
	add r0,#0x1e	; 0230F9BE
	bl loc_023094A0	; 0230F9C0
	cmp r0,#0xff	; 0230F9C4
	beq loc_0230FAB2	; 0230F9C6
	cmp r0,#0x0	; 0230F9C8
	beq loc_0230FAB2	; 0230F9CA
	mov r1,#0x1c	; 0230F9CC
	add r4,r0,#0x0	; 0230F9CE
	mul r4,r1	; 0230F9D0
	ldr r1,[pool_0230FABC]	; 0230F9D2
	ldr r2,[r1,#0x0]	; 0230F9D4
	ldr r1,[pool_0230FAD4]	; 0230F9D6
	ldr r1,[r2,r1]	; 0230F9D8
	ldrh r1,[r1,r4]	; 0230F9DA
	cmp r1,#0x40	; 0230F9DC
	beq loc_0230F9F4	; 0230F9DE
	add r5,#0x1e	; 0230F9E0
	add r0,r5,#0x0	; 0230F9E2
	mov r1,#0x7	; 0230F9E4
	bl loc_0230C05C	; 0230F9E6
	cmp r0,#0x0	; 0230F9EA
	beq loc_0230FAB2	; 0230F9EC
	bl loc_0230CAF0	; 0230F9EE
	b loc_0230FAB2	; 0230F9F2
loc_0230F9F4:
	lsl r0,r0,#0x10	; 0230F9F4
	lsr r0,r0,#0x10	; 0230F9F6
	ldrh r1,[r5,#0x14]	; 0230F9F8
	lsl r1,r1,#0x13	; 0230F9FA
	lsr r1,r1,#0x1f	; 0230F9FC
	bl loc_02309184	; 0230F9FE
	ldr r2,[pool_0230FABC]	; 0230FA02
	ldr r0,[r2,#0x0]	; 0230FA04
	ldr r3,[pool_0230FAD4]	; 0230FA06
	ldr r0,[r0,r3]	; 0230FA08
	add r1,r0,r4	; 0230FA0A
	ldrh r0,[r1,#0x1a]	; 0230FA0C
	strh r0,[r1,#0x18]	; 0230FA0E
	mov r0,#0x1	; 0230FA10
	ldr r1,[r2,#0x0]	; 0230FA12
	ldr r1,[r1,r3]	; 0230FA14
	add r1,r1,r4	; 0230FA16
	ldrh r1,[r1,#0x2]	; 0230FA18
	lsl r0,r1	; 0230FA1A
	lsl r0,r0,#0x10	; 0230FA1C
	lsr r0,r0,#0x10	; 0230FA1E
	add r1,r7,#0x0	; 0230FA20
	add r1,#0x9a	; 0230FA22
	ldrh r1,[r1,#0x0]	; 0230FA24
	add r2,r0,#0x0	; 0230FA26
	and r2,r1	; 0230FA28
	cmp r2,#0x0	; 0230FA2A
	bne loc_0230FAB2	; 0230FA2C
	add r1,r7,#0x0	; 0230FA2E
	add r1,#0x98	; 0230FA30
	ldrh r1,[r1,#0x0]	; 0230FA32
	add r2,r0,#0x0	; 0230FA34
	and r2,r1	; 0230FA36
	cmp r2,#0x0	; 0230FA38
	beq loc_0230FAB2	; 0230FA3A
	add r2,r7,#0x0	; 0230FA3C
	add r2,#0x9a	; 0230FA3E
	ldrh r1,[r2,#0x0]	; 0230FA40
	orr r1,r0	; 0230FA42
	strh r1,[r2,#0x0]	; 0230FA44
	ldrh r1,[r6,#0x0]	; 0230FA46
	bic r1,r0	; 0230FA48
	strh r1,[r6,#0x0]	; 0230FA4A
	add r4,r6,#0x0	; 0230FA4C
	add r4,#0xa	; 0230FA4E
	lsl r0,r0,#0xf	; 0230FA50
	lsr r0,r0,#0x10	; 0230FA52
	b loc_0230FA6C	; 0230FA54
loc_0230FA56:
	add r1,r7,#0x0	; 0230FA56
	add r1,#0x98	; 0230FA58
	ldrh r1,[r1,#0x0]	; 0230FA5A
	add r2,r0,#0x0	; 0230FA5C
	and r2,r1	; 0230FA5E
	cmp r2,#0x0	; 0230FA60
	beq loc_0230FA68	; 0230FA62
	ldrh r1,[r6,#0x6]	; 0230FA64
	add r4,r4,r1	; 0230FA66
loc_0230FA68:
	lsl r0,r0,#0xf	; 0230FA68
	lsr r0,r0,#0x10	; 0230FA6A
loc_0230FA6C:
	cmp r0,#0x1	; 0230FA6C
	bne loc_0230FA56	; 0230FA6E
	ldrh r0,[r5,#0x10]	; 0230FA70
	sub r0,#0x18	; 0230FA72
	strh r0,[r4,#0x0]	; 0230FA74
	add r0,r4,#0x3	; 0230FA76
	ldrh r2,[r5,#0x12]	; 0230FA78
	mov r1,#0xff	; 0230FA7A
	and r2,r1	; 0230FA7C
	lsl r1,r2,#0x10	; 0230FA7E
	lsr r1,r1,#0x10	; 0230FA80
	lsl r1,r1,#0x18	; 0230FA82
	lsr r1,r1,#0x18	; 0230FA84
	bl loc_023053DC	; 0230FA86
	add r0,r4,#0x2	; 0230FA8A
	ldrh r2,[r5,#0xe]	; 0230FA8C
	mov r1,#0xff	; 0230FA8E
	and r2,r1	; 0230FA90
	lsl r1,r2,#0x10	; 0230FA92
	lsr r1,r1,#0x10	; 0230FA94
	lsl r1,r1,#0x18	; 0230FA96
	lsr r1,r1,#0x18	; 0230FA98
	bl loc_023053DC	; 0230FA9A
	ldrh r2,[r4,#0x0]	; 0230FA9E
	cmp r2,#0x0	; 0230FAA0
	beq loc_0230FAB2	; 0230FAA2
	add r5,#0x2c	; 0230FAA4
	add r0,r5,#0x0	; 0230FAA6
	add r4,#0x8	; 0230FAA8
	add r1,r4,#0x0	; 0230FAAA
	add r2,r2,#0x1	; 0230FAAC
	bl loc_0230FAD8	; 0230FAAE
loc_0230FAB2:
	add sp,#0x4	; 0230FAB2
	pop {r4,r5,r6,r7}	; 0230FAB4
	pop {r3}	; 0230FAB6
	bx r3	; 0230FAB8
	.byte 0xC0, 0x46	; 0230FABC
pool_0230FABC:
loc_0230FABC:
	.word FirmwareWlWorkPointerSlot	; 0230FABC
pool_0230FAC0:
loc_0230FAC0:
	.word 0x000003E4	; 0230FAC0
pool_0230FAC4:
loc_0230FAC4:
	.word 0x00000474	; 0230FAC4
pool_0230FAC8:
loc_0230FAC8:
	.word 0x00000364	; 0230FAC8
pool_0230FACC:
loc_0230FACC:
	.word 0x00000362	; 0230FACC
pool_0230FAD0:
loc_0230FAD0:
	.word 0x00000360	; 0230FAD0
pool_0230FAD4:
loc_0230FAD4:
	.word 0x000002E0	; 0230FAD4

; ===== function loc_0230FAD8 =====
loc_0230FAD8:
	bx pc	; 0230FAD8
	.byte 0xC0, 0x46	; 0230FADC
.arm

; ===== function loc_0230FADC =====
loc_0230FADC:
	ldr pc,[pool_0230FAE0]	; 0230FADC
pool_0230FAE0:
loc_0230FAE0:
	.word P2_Entry_037FCE1C	; 0230FAE0
.thumb

; ===== function loc_0230FAE4 =====
loc_0230FAE4:
	push {r4,r5,r6,r7,lr}	; 0230FAE4
	sub sp,#0x4	; 0230FAE6
	ldr r1,[pool_0230FC60]	; 0230FAE8
	ldr r1,[r1,#0x0]	; 0230FAEA
	ldr r2,[pool_0230FC64]	; 0230FAEC
	add r2,r1,r2	; 0230FAEE
	ldr r3,[pool_0230FC68]	; 0230FAF0
	ldrh r3,[r1,r3]	; 0230FAF2
	cmp r3,#0x40	; 0230FAF4
	beq loc_0230FAFC	; 0230FAF6
	mov r0,#0x1	; 0230FAF8
	b loc_0230FC56	; 0230FAFA
loc_0230FAFC:
	ldrh r5,[r0,#0x2a]	; 0230FAFC
	ldr r3,[pool_0230FC6C]	; 0230FAFE
	add r3,r1,r3	; 0230FB00
	ldrh r4,[r3,#0x0]	; 0230FB02
	cmp r4,r5	; 0230FB04
	bne loc_0230FB16	; 0230FB06
	ldr r0,[pool_0230FC70]	; 0230FB08
	add r1,r1,r0	; 0230FB0A
	ldr r0,[r1,#0x0]	; 0230FB0C
	add r0,r0,#0x1	; 0230FB0E
	str r0,[r1,#0x0]	; 0230FB10
	mov r0,#0x1	; 0230FB12
	b loc_0230FC56	; 0230FB14
loc_0230FB16:
	strh r5,[r3,#0x0]	; 0230FB16
	ldrh r3,[r0,#0x22]	; 0230FB18
	add r1,r2,#0x0	; 0230FB1A
	add r1,#0x5c	; 0230FB1C
	ldrh r1,[r1,#0x0]	; 0230FB1E
	cmp r3,r1	; 0230FB20
	bne loc_0230FB40	; 0230FB22
	ldrh r3,[r0,#0x20]	; 0230FB24
	add r1,r2,#0x0	; 0230FB26
	add r1,#0x5a	; 0230FB28
	ldrh r1,[r1,#0x0]	; 0230FB2A
	cmp r3,r1	; 0230FB2C
	bne loc_0230FB40	; 0230FB2E
	ldrh r3,[r0,#0x1e]	; 0230FB30
	add r1,r2,#0x0	; 0230FB32
	add r1,#0x58	; 0230FB34
	ldrh r1,[r1,#0x0]	; 0230FB36
	cmp r3,r1	; 0230FB38
	bne loc_0230FB40	; 0230FB3A
	mov r1,#0x1	; 0230FB3C
	b loc_0230FB42	; 0230FB3E
loc_0230FB40:
	mov r1,#0x0	; 0230FB40
loc_0230FB42:
	cmp r1,#0x0	; 0230FB42
	beq loc_0230FB72	; 0230FB44
	ldrh r3,[r0,#0x28]	; 0230FB46
	add r1,r2,#0x0	; 0230FB48
	add r1,#0x7a	; 0230FB4A
	ldrh r1,[r1,#0x0]	; 0230FB4C
	cmp r3,r1	; 0230FB4E
	bne loc_0230FB6C	; 0230FB50
	ldrh r3,[r0,#0x26]	; 0230FB52
	add r1,r2,#0x0	; 0230FB54
	add r1,#0x78	; 0230FB56
	ldrh r1,[r1,#0x0]	; 0230FB58
	cmp r3,r1	; 0230FB5A
	bne loc_0230FB6C	; 0230FB5C
	ldrh r3,[r0,#0x24]	; 0230FB5E
	add r2,#0x76	; 0230FB60
	ldrh r1,[r2,#0x0]	; 0230FB62
	cmp r3,r1	; 0230FB64
	bne loc_0230FB6C	; 0230FB66
	mov r1,#0x1	; 0230FB68
	b loc_0230FB6E	; 0230FB6A
loc_0230FB6C:
	mov r1,#0x0	; 0230FB6C
loc_0230FB6E:
	cmp r1,#0x0	; 0230FB6E
	bne loc_0230FB76	; 0230FB70
loc_0230FB72:
	mov r0,#0x1	; 0230FB72
	b loc_0230FC56	; 0230FB74
loc_0230FB76:
	ldr r1,[pool_0230FC60]	; 0230FB76
	ldr r1,[r1,#0x0]	; 0230FB78
	mov r3,#0x1	; 0230FB7A
	ldr r2,[pool_0230FC74]	; 0230FB7C
	ldrh r2,[r1,r2]	; 0230FB7E
	lsl r3,r2	; 0230FB80
	lsl r2,r3,#0x10	; 0230FB82
	lsr r3,r2,#0x10	; 0230FB84
	ldrh r2,[r0,#0x2e]	; 0230FB86
	and r3,r2	; 0230FB88
	cmp r3,#0x0	; 0230FB8A
	bne loc_0230FB96	; 0230FB8C
	mov r3,#0x0	; 0230FB8E
	ldr r2,[pool_0230FC78]	; 0230FB90
	strh r3,[r1,r2]	; 0230FB92
	b loc_0230FB9C	; 0230FB94
loc_0230FB96:
	ldr r3,[pool_0230FC7C]	; 0230FB96
	ldr r2,[pool_0230FC78]	; 0230FB98
	strh r3,[r1,r2]	; 0230FB9A
loc_0230FB9C:
	ldr r1,[pool_0230FC80]	; 0230FB9C
	ldrh r3,[r1,#0x0]	; 0230FB9E
	ldr r1,[pool_0230FC84]	; 0230FBA0
	add r2,r3,#0x0	; 0230FBA2
	and r2,r1	; 0230FBA4
	cmp r2,#0x0	; 0230FBA6
	beq loc_0230FBC8	; 0230FBA8
	ldr r1,[pool_0230FC88]	; 0230FBAA
	and r3,r1	; 0230FBAC
	lsl r2,r3,#0x1	; 0230FBAE
	ldr r1,[pool_0230FC8C]	; 0230FBB0
	ldrh r1,[r2,r1]	; 0230FBB2
	cmp r1,#0x0	; 0230FBB4
	beq loc_0230FBC8	; 0230FBB6
	ldr r1,[pool_0230FC60]	; 0230FBB8
	ldr r2,[r1,#0x0]	; 0230FBBA
	ldr r1,[pool_0230FC78]	; 0230FBBC
	add r3,r2,r1	; 0230FBBE
	ldrh r2,[r3,#0x0]	; 0230FBC0
	ldr r1,[pool_0230FC90]	; 0230FBC2
	orr r2,r1	; 0230FBC4
	strh r2,[r3,#0x0]	; 0230FBC6
loc_0230FBC8:
	ldr r1,[pool_0230FC60]	; 0230FBC8
	ldr r3,[r1,#0x0]	; 0230FBCA
	ldr r1,[pool_0230FC94]	; 0230FBCC
	ldrh r2,[r3,r1]	; 0230FBCE
	mov r1,#0x1c	; 0230FBD0
	mul r2,r1	; 0230FBD2
	ldr r1,[pool_0230FC98]	; 0230FBD4
	ldr r1,[r3,r1]	; 0230FBD6
	add r2,r1,r2	; 0230FBD8
	ldrh r1,[r2,#0x1a]	; 0230FBDA
	strh r1,[r2,#0x18]	; 0230FBDC
	ldrh r1,[r0,#0x10]	; 0230FBDE
	sub r1,#0x1c	; 0230FBE0
	strh r1,[r0,#0x6]	; 0230FBE2
	add r1,r0,#0x0	; 0230FBE4
	sub r1,#0x10	; 0230FBE6
	ldr r2,[pool_0230FC9C]	; 0230FBE8
	strh r2,[r1,#0xc]	; 0230FBEA
	ldrh r0,[r0,#0x6]	; 0230FBEC
	add r0,#0x31	; 0230FBEE
	lsr r0,r0,#0x1	; 0230FBF0
	strh r0,[r1,#0xe]	; 0230FBF2
	ldrh r3,[r1,#0x3e]	; 0230FBF4
	mov r6,#0x0	; 0230FBF6
	mov r2,#0x1	; 0230FBF8
	b loc_0230FC0A	; 0230FBFA
loc_0230FBFC:
	add r0,r3,#0x0	; 0230FBFC
	and r0,r2	; 0230FBFE
	cmp r0,#0x0	; 0230FC00
	beq loc_0230FC06	; 0230FC02
	add r6,r6,#0x1	; 0230FC04
loc_0230FC06:
	lsl r0,r3,#0xf	; 0230FC06
	lsr r3,r0,#0x10	; 0230FC08
loc_0230FC0A:
	cmp r3,#0x0	; 0230FC0A
	bne loc_0230FBFC	; 0230FC0C
	add r5,r1,#0x0	; 0230FC0E
	add r5,#0x18	; 0230FC10
	ldrh r4,[r5,#0x0]	; 0230FC12
	ldr r0,[pool_0230FCA0]	; 0230FC14
	ldrh r2,[r0,#0x0]	; 0230FC16
	ldr r0,[pool_0230FC84]	; 0230FC18
	and r2,r0	; 0230FC1A
	asr r3,r2,#0x3	; 0230FC1C
	ldr r0,[pool_0230FC60]	; 0230FC1E
	ldr r2,[r0,#0x0]	; 0230FC20
	ldr r0,[pool_0230FC78]	; 0230FC22
	ldrh r2,[r2,r0]	; 0230FC24
	ldr r0,[pool_0230FC80]	; 0230FC26
	ldrh r7,[r0,#0x0]	; 0230FC28
	ldr r0,[pool_0230FC84]	; 0230FC2A
	and r7,r0	; 0230FC2C
	asr r0,r7,#0x4	; 0230FC2E
	orr r2,r0	; 0230FC30
	orr r3,r2	; 0230FC32
	orr r4,r3	; 0230FC34
	strh r4,[r5,#0x0]	; 0230FC36
	ldrh r2,[r1,#0x1c]	; 0230FC38
	ldrh r0,[r1,#0x3c]	; 0230FC3A
	add r0,#0xa	; 0230FC3C
	mul r6,r0	; 0230FC3E
	add r6,#0xfc	; 0230FC40
	lsr r0,r6,#0x4	; 0230FC42
	add r0,r2,r0	; 0230FC44
	strh r0,[r1,#0x1a]	; 0230FC46
	ldr r0,[pool_0230FC60]	; 0230FC48
	ldr r2,[r0,#0x0]	; 0230FC4A
	ldr r0,[pool_0230FCA4]	; 0230FC4C
	add r0,r2,r0	; 0230FC4E
	bl loc_02309578	; 0230FC50
	mov r0,#0x0	; 0230FC54
loc_0230FC56:
	add sp,#0x4	; 0230FC56
	pop {r4,r5,r6,r7}	; 0230FC58
	pop {r3}	; 0230FC5A
	bx r3	; 0230FC5C
	.byte 0xC0, 0x46	; 0230FC60
pool_0230FC60:
loc_0230FC60:
	.word FirmwareWlWorkPointerSlot	; 0230FC60
pool_0230FC64:
loc_0230FC64:
	.word 0x00000308	; 0230FC64
pool_0230FC68:
loc_0230FC68:
	.word 0x00000310	; 0230FC68
pool_0230FC6C:
loc_0230FC6C:
	.word 0x00000498	; 0230FC6C
pool_0230FC70:
loc_0230FC70:
	.word 0x00000534	; 0230FC70
pool_0230FC74:
loc_0230FC74:
	.word 0x00000366	; 0230FC74
pool_0230FC78:
loc_0230FC78:
	.word 0x0000049E	; 0230FC78
pool_0230FC7C:
loc_0230FC7C:
	.word 0x00002000	; 0230FC7C
pool_0230FC80:
loc_0230FC80:
	.word REG_WIFI_TXBUF_REPLY2	; 0230FC80
pool_0230FC84:
loc_0230FC84:
	.word 0x00008000	; 0230FC84
pool_0230FC88:
loc_0230FC88:
	.word 0x00007FFF	; 0230FC88
pool_0230FC8C:
loc_0230FC8C:
	.word 0x04804004	; 0230FC8C
pool_0230FC90:
loc_0230FC90:
	.word 0x00004000	; 0230FC90
pool_0230FC94:
loc_0230FC94:
	.word 0x00000384	; 0230FC94
pool_0230FC98:
loc_0230FC98:
	.word 0x000002E0	; 0230FC98
pool_0230FC9C:
loc_0230FC9C:
	.word 0x00000182	; 0230FC9C
pool_0230FCA0:
loc_0230FCA0:
	.word REG_WIFI_TXBUF_REPLY1	; 0230FCA0
pool_0230FCA4:
loc_0230FCA4:
	.word 0x0000014C	; 0230FCA4

; ===== function loc_0230FCA8 =====
	push {r4,r5,r6,r7,lr}	; 0230FCA8
	sub sp,#0xc	; 0230FCAA
	ldr r0,[pool_0230FF18]	; 0230FCAC
	ldr r1,[r0,#0x0]	; 0230FCAE
	ldr r0,[pool_0230FF1C]	; 0230FCB0
	add r4,r1,r0	; 0230FCB2
	ldr r0,[pool_0230FF20]	; 0230FCB4
	add r0,r1,r0	; 0230FCB6
	ldr r7,[r0,#0x0]	; 0230FCB8
	mov r2,#0x0	; 0230FCBA
	mvn r2,r2	; 0230FCBC
	cmp r7,r2	; 0230FCBE
	bne loc_0230FCC4	; 0230FCC0
	b loc_0230FF10	; 0230FCC2
loc_0230FCC4:
	ldr r2,[pool_0230FF24]	; 0230FCC4
	ldrh r1,[r1,r2]	; 0230FCC6
	cmp r1,#0x40	; 0230FCC8
	beq loc_0230FCD4	; 0230FCCA
	add r1,r7,#0x0	; 0230FCCC
	bl loc_02304FFC	; 0230FCCE
	b loc_0230FF10	; 0230FCD2
loc_0230FCD4:
	add r5,r7,#0x0	; 0230FCD4
	add r5,#0x10	; 0230FCD6
	ldrh r0,[r5,#0x14]	; 0230FCD8
	lsl r0,r0,#0x17	; 0230FCDA
	lsr r0,r0,#0x1f	; 0230FCDC
	cmp r0,#0x0	; 0230FCDE
	beq loc_0230FD04	; 0230FCE0
	ldrh r1,[r5,#0x24]	; 0230FCE2
	mov r0,#0x1	; 0230FCE4
	and r1,r0	; 0230FCE6
	cmp r1,#0x0	; 0230FCE8
	beq loc_0230FCF8	; 0230FCEA
	add r1,r4,#0x0	; 0230FCEC
	add r1,#0x2c	; 0230FCEE
	ldr r0,[r1,#0x0]	; 0230FCF0
	add r0,r0,#0x1	; 0230FCF2
	str r0,[r1,#0x0]	; 0230FCF4
	b loc_0230FD24	; 0230FCF6
loc_0230FCF8:
	add r1,r4,#0x0	; 0230FCF8
	add r1,#0x28	; 0230FCFA
	ldr r0,[r1,#0x0]	; 0230FCFC
	add r0,r0,#0x1	; 0230FCFE
	str r0,[r1,#0x0]	; 0230FD00
	b loc_0230FD24	; 0230FD02
loc_0230FD04:
	ldrh r1,[r5,#0x18]	; 0230FD04
	mov r0,#0x1	; 0230FD06
	and r1,r0	; 0230FD08
	cmp r1,#0x0	; 0230FD0A
	beq loc_0230FD1A	; 0230FD0C
	add r1,r4,#0x0	; 0230FD0E
	add r1,#0x2c	; 0230FD10
	ldr r0,[r1,#0x0]	; 0230FD12
	add r0,r0,#0x1	; 0230FD14
	str r0,[r1,#0x0]	; 0230FD16
	b loc_0230FD24	; 0230FD18
loc_0230FD1A:
	add r1,r4,#0x0	; 0230FD1A
	add r1,#0x28	; 0230FD1C
	ldr r0,[r1,#0x0]	; 0230FD1E
	add r0,r0,#0x1	; 0230FD20
	str r0,[r1,#0x0]	; 0230FD22
loc_0230FD24:
	add r0,r4,#0x0	; 0230FD24
	str r0,[sp,#0x0]	; 0230FD26
	add r0,#0x24	; 0230FD28
	str r0,[sp,#0x0]	; 0230FD2A
	ldrh r0,[r5,#0x8]	; 0230FD2C
	mov r1,#0xf0	; 0230FD2E
	and r0,r1	; 0230FD30
	mov r1,#0x10	; 0230FD32
	bl loc_0230FF48	; 0230FD34
	ldr r1,[sp,#0x0]	; 0230FD38
	ldr r1,[r1,#0x0]	; 0230FD3A
	sub r0,r0,#0x1	; 0230FD3C
	add r1,r1,r0	; 0230FD3E
	ldr r0,[sp,#0x0]	; 0230FD40
	str r1,[r0,#0x0]	; 0230FD42
	mov r0,#0x1	; 0230FD44
	str r0,[sp,#0x4]	; 0230FD46
	ldr r0,[pool_0230FF18]	; 0230FD48
	ldr r2,[r0,#0x0]	; 0230FD4A
	ldr r0,[pool_0230FF28]	; 0230FD4C
	ldrh r0,[r2,r0]	; 0230FD4E
	cmp r0,#0x1	; 0230FD50
	beq loc_0230FD5E	; 0230FD52
	cmp r0,#0x2	; 0230FD54
	beq loc_0230FE02	; 0230FD56
	cmp r0,#0x3	; 0230FD58
	beq loc_0230FE02	; 0230FD5A
	b loc_0230FE98	; 0230FD5C
loc_0230FD5E:
	ldrh r1,[r5,#0x14]	; 0230FD5E
	ldr r0,[sp,#0x4]	; 0230FD60
	and r1,r0	; 0230FD62
	cmp r1,#0x0	; 0230FD64
	beq loc_0230FD6A	; 0230FD66
	b loc_0230FE98	; 0230FD68
loc_0230FD6A:
	add r0,r5,#0x0	; 0230FD6A
	add r0,#0x1e	; 0230FD6C
	bl loc_023094A0	; 0230FD6E
	add r6,r0,#0x0	; 0230FD72
	cmp r6,#0xff	; 0230FD74
	beq loc_0230FD90	; 0230FD76
	mov r1,#0x1c	; 0230FD78
	str r0,[sp,#0x8]	; 0230FD7A
	mul r0,r1	; 0230FD7C
	str r0,[sp,#0x8]	; 0230FD7E
	ldr r0,[pool_0230FF18]	; 0230FD80
	ldr r1,[r0,#0x0]	; 0230FD82
	ldr r0,[pool_0230FF2C]	; 0230FD84
	ldr r1,[r1,r0]	; 0230FD86
	ldr r0,[sp,#0x8]	; 0230FD88
	ldrh r0,[r1,r0]	; 0230FD8A
	cmp r0,#0x40	; 0230FD8C
	beq loc_0230FDC4	; 0230FD8E
loc_0230FD90:
	ldr r0,[pool_0230FF18]	; 0230FD90
	ldr r1,[r0,#0x0]	; 0230FD92
	ldr r0,[pool_0230FF2C]	; 0230FD94
	ldr r2,[r1,r0]	; 0230FD96
	mov r0,#0x1c	; 0230FD98
	add r1,r6,#0x0	; 0230FD9A
	mul r1,r0	; 0230FD9C
	ldrh r0,[r2,r1]	; 0230FD9E
	cmp r0,#0x30	; 0230FDA0
	bne loc_0230FDB0	; 0230FDA2
	add r0,r5,#0x0	; 0230FDA4
	add r0,#0x1e	; 0230FDA6
	mov r1,#0x7	; 0230FDA8
	bl loc_0230C5C4	; 0230FDAA
	b loc_0230FDBA	; 0230FDAE
loc_0230FDB0:
	add r0,r5,#0x0	; 0230FDB0
	add r0,#0x1e	; 0230FDB2
	mov r1,#0x7	; 0230FDB4
	bl loc_0230C05C	; 0230FDB6
loc_0230FDBA:
	cmp r0,#0x0	; 0230FDBA
	beq loc_0230FE98	; 0230FDBC
	bl loc_0230CAF0	; 0230FDBE
	b loc_0230FE98	; 0230FDC2
loc_0230FDC4:
	lsl r0,r6,#0x10	; 0230FDC4
	lsr r0,r0,#0x10	; 0230FDC6
	ldrh r1,[r5,#0x14]	; 0230FDC8
	lsl r1,r1,#0x13	; 0230FDCA
	lsr r1,r1,#0x1f	; 0230FDCC
	bl loc_02309184	; 0230FDCE
	ldrh r0,[r5,#0x2a]	; 0230FDD2
	ldr r1,[pool_0230FF18]	; 0230FDD4
	ldr r2,[r1,#0x0]	; 0230FDD6
	ldr r1,[pool_0230FF2C]	; 0230FDD8
	ldr r2,[r2,r1]	; 0230FDDA
	ldr r1,[sp,#0x8]	; 0230FDDC
	add r1,r2,r1	; 0230FDDE
	ldrh r1,[r1,#0x14]	; 0230FDE0
	cmp r0,r1	; 0230FDE2
	bne loc_0230FDF0	; 0230FDE4
	add r4,#0x3c	; 0230FDE6
	ldr r0,[r4,#0x0]	; 0230FDE8
	add r0,r0,#0x1	; 0230FDEA
	str r0,[r4,#0x0]	; 0230FDEC
	b loc_0230FE98	; 0230FDEE
loc_0230FDF0:
	add r0,r5,#0x0	; 0230FDF0
	add r0,#0x18	; 0230FDF2
	add r1,r5,#0x0	; 0230FDF4
	add r1,#0x24	; 0230FDF6
	bl loc_0230645C	; 0230FDF8
	mov r0,#0x0	; 0230FDFC
	str r0,[sp,#0x4]	; 0230FDFE
	b loc_0230FE98	; 0230FE00
loc_0230FE02:
	ldrh r1,[r5,#0x14]	; 0230FE02
	mov r3,#0x1	; 0230FE04
	add r0,r1,#0x0	; 0230FE06
	and r0,r3	; 0230FE08
	cmp r0,#0x0	; 0230FE0A
	bne loc_0230FE98	; 0230FE0C
	ldr r0,[pool_0230FF30]	; 0230FE0E
	ldrh r0,[r2,r0]	; 0230FE10
	lsl r0,r0,#0x1f	; 0230FE12
	lsr r0,r0,#0x1f	; 0230FE14
	cmp r0,#0x0	; 0230FE16
	beq loc_0230FE62	; 0230FE18
	ldr r0,[pool_0230FF34]	; 0230FE1A
	and r1,r0	; 0230FE1C
	cmp r1,#0x0	; 0230FE1E
	bne loc_0230FE62	; 0230FE20
	ldrh r0,[r5,#0x18]	; 0230FE22
	and r0,r3	; 0230FE24
	cmp r0,#0x0	; 0230FE26
	beq loc_0230FE36	; 0230FE28
	ldr r0,[pool_0230FF38]	; 0230FE2A
	add r1,r2,r0	; 0230FE2C
	ldrh r0,[r1,#0x0]	; 0230FE2E
	bic r0,r3	; 0230FE30
	strh r0,[r1,#0x0]	; 0230FE32
	b loc_0230FE3C	; 0230FE34
loc_0230FE36:
	mov r1,#0x0	; 0230FE36
	ldr r0,[pool_0230FF38]	; 0230FE38
	strh r1,[r2,r0]	; 0230FE3A
loc_0230FE3C:
	ldr r0,[pool_0230FF18]	; 0230FE3C
	ldr r1,[r0,#0x0]	; 0230FE3E
	ldr r0,[pool_0230FF38]	; 0230FE40
	ldrh r0,[r1,r0]	; 0230FE42
	cmp r0,#0x0	; 0230FE44
	bne loc_0230FE62	; 0230FE46
	ldr r0,[pool_0230FF2C]	; 0230FE48
	ldr r0,[r1,r0]	; 0230FE4A
	ldr r2,[pool_0230FF3C]	; 0230FE4C
	ldrh r2,[r1,r2]	; 0230FE4E
	mov r1,#0x1c	; 0230FE50
	mul r2,r1	; 0230FE52
	add r0,r0,r2	; 0230FE54
	ldrh r0,[r0,#0x16]	; 0230FE56
	cmp r0,#0x0	; 0230FE58
	bne loc_0230FE62	; 0230FE5A
	mov r0,#0x1	; 0230FE5C
	bl loc_02306814	; 0230FE5E
loc_0230FE62:
	ldr r0,[pool_0230FF18]	; 0230FE62
	ldr r0,[r0,#0x0]	; 0230FE64
	ldr r1,[pool_0230FF3C]	; 0230FE66
	ldrh r6,[r0,r1]	; 0230FE68
	ldrh r2,[r5,#0x2a]	; 0230FE6A
	ldr r1,[pool_0230FF2C]	; 0230FE6C
	ldr r1,[r0,r1]	; 0230FE6E
	mov r0,#0x1c	; 0230FE70
	add r3,r6,#0x0	; 0230FE72
	mul r3,r0	; 0230FE74
	add r0,r1,r3	; 0230FE76
	ldrh r0,[r0,#0x14]	; 0230FE78
	cmp r2,r0	; 0230FE7A
	bne loc_0230FE88	; 0230FE7C
	add r4,#0x3c	; 0230FE7E
	ldr r0,[r4,#0x0]	; 0230FE80
	add r0,r0,#0x1	; 0230FE82
	str r0,[r4,#0x0]	; 0230FE84
	b loc_0230FE98	; 0230FE86
loc_0230FE88:
	add r0,r5,#0x0	; 0230FE88
	add r0,#0x1e	; 0230FE8A
	add r1,r5,#0x0	; 0230FE8C
	add r1,#0x24	; 0230FE8E
	bl loc_0230645C	; 0230FE90
	mov r0,#0x0	; 0230FE94
	str r0,[sp,#0x4]	; 0230FE96
loc_0230FE98:
	ldr r0,[sp,#0x4]	; 0230FE98
	cmp r0,#0x0	; 0230FE9A
	bne loc_0230FEEE	; 0230FE9C
	lsl r0,r6,#0x10	; 0230FE9E
	lsr r0,r0,#0x10	; 0230FEA0
	strh r0,[r5,#0x2]	; 0230FEA2
	ldrh r2,[r5,#0x12]	; 0230FEA4
	mov r1,#0xff	; 0230FEA6
	and r2,r1	; 0230FEA8
	lsl r1,r2,#0x10	; 0230FEAA
	lsr r1,r1,#0x10	; 0230FEAC
	bl loc_023091D4	; 0230FEAE
	mov r0,#0x1c	; 0230FEB2
	mul r6,r0	; 0230FEB4
	ldrh r1,[r5,#0x2a]	; 0230FEB6
	ldr r0,[pool_0230FF18]	; 0230FEB8
	ldr r3,[r0,#0x0]	; 0230FEBA
	ldr r2,[pool_0230FF2C]	; 0230FEBC
	ldr r3,[r3,r2]	; 0230FEBE
	add r3,r3,r6	; 0230FEC0
	strh r1,[r3,#0x14]	; 0230FEC2
	ldr r1,[r0,#0x0]	; 0230FEC4
	ldr r1,[r1,r2]	; 0230FEC6
	add r2,r1,r6	; 0230FEC8
	ldrh r1,[r2,#0x1a]	; 0230FECA
	strh r1,[r2,#0x18]	; 0230FECC
	ldrh r1,[r5,#0x10]	; 0230FECE
	sub r1,#0x18	; 0230FED0
	strh r1,[r5,#0x6]	; 0230FED2
	ldr r1,[pool_0230FF40]	; 0230FED4
	strh r1,[r7,#0xc]	; 0230FED6
	ldrh r1,[r5,#0x6]	; 0230FED8
	add r1,#0x2d	; 0230FEDA
	lsr r1,r1,#0x1	; 0230FEDC
	strh r1,[r7,#0xe]	; 0230FEDE
	ldr r1,[r0,#0x0]	; 0230FEE0
	ldr r0,[pool_0230FF20]	; 0230FEE2
	add r0,r1,r0	; 0230FEE4
	add r1,r7,#0x0	; 0230FEE6
	bl loc_02309578	; 0230FEE8
	b loc_0230FEFC	; 0230FEEC
loc_0230FEEE:
	ldr r0,[pool_0230FF18]	; 0230FEEE
	ldr r1,[r0,#0x0]	; 0230FEF0
	ldr r0,[pool_0230FF20]	; 0230FEF2
	add r0,r1,r0	; 0230FEF4
	add r1,r7,#0x0	; 0230FEF6
	bl loc_02304FFC	; 0230FEF8
loc_0230FEFC:
	ldr r0,[pool_0230FF18]	; 0230FEFC
	ldr r1,[r0,#0x0]	; 0230FEFE
	ldr r0,[pool_0230FF44]	; 0230FF00
	ldrh r0,[r1,r0]	; 0230FF02
	cmp r0,#0x0	; 0230FF04
	beq loc_0230FF10	; 0230FF06
	mov r0,#0x2	; 0230FF08
	mov r1,#0x6	; 0230FF0A
	bl loc_02304B6C	; 0230FF0C
loc_0230FF10:
	add sp,#0xc	; 0230FF10
	pop {r4,r5,r6,r7}	; 0230FF12
	pop {r3}	; 0230FF14
	bx r3	; 0230FF16
pool_0230FF18:
loc_0230FF18:
	.word FirmwareWlWorkPointerSlot	; 0230FF18
pool_0230FF1C:
loc_0230FF1C:
	.word 0x000004F4	; 0230FF1C
pool_0230FF20:
loc_0230FF20:
	.word 0x00000188	; 0230FF20
pool_0230FF24:
loc_0230FF24:
	.word 0x00000310	; 0230FF24
pool_0230FF28:
loc_0230FF28:
	.word 0x00000314	; 0230FF28
pool_0230FF2C:
loc_0230FF2C:
	.word 0x000002E0	; 0230FF2C
pool_0230FF30:
loc_0230FF30:
	.word 0x00000316	; 0230FF30
pool_0230FF34:
loc_0230FF34:
	.word 0x00002000	; 0230FF34
pool_0230FF38:
loc_0230FF38:
	.word 0x0000038A	; 0230FF38
pool_0230FF3C:
loc_0230FF3C:
	.word 0x00000384	; 0230FF3C
pool_0230FF40:
loc_0230FF40:
	.word 0x00000180	; 0230FF40
pool_0230FF44:
loc_0230FF44:
	.word 0x00000190	; 0230FF44

; ===== function loc_0230FF48 =====
loc_0230FF48:
	bx pc	; 0230FF48
	.byte 0xC0, 0x46	; 0230FF4C
.arm

; ===== function loc_0230FF4C =====
loc_0230FF4C:
	ldr pc,[pool_0230FF50]	; 0230FF4C
pool_0230FF50:
loc_0230FF50:
	.word loc_03802514	; 0230FF50
.thumb

; ===== function loc_0230FF54 =====
	push {r4,lr}	; 0230FF54
	ldr r0,[pool_0230FF88]	; 0230FF56
	ldr r1,[r0,#0x0]	; 0230FF58
	ldr r0,[pool_0230FF8C]	; 0230FF5A
	add r4,r1,r0	; 0230FF5C
	mov r3,#0x0	; 0230FF5E
	add r0,r3,#0x0	; 0230FF60
	add r2,r4,#0x0	; 0230FF62
	add r2,#0x30	; 0230FF64
loc_0230FF66:
	ldrh r1,[r4,#0x30]	; 0230FF66
	cmp r1,#0x0	; 0230FF68
	beq loc_0230FF7A	; 0230FF6A
	ldrh r1,[r2,#0x0]	; 0230FF6C
	sub r1,r1,#0x1	; 0230FF6E
	strh r1,[r2,#0x0]	; 0230FF70
	ldrh r1,[r4,#0x30]	; 0230FF72
	cmp r1,#0x0	; 0230FF74
	bne loc_0230FF7A	; 0230FF76
	strh r0,[r4,#0x0]	; 0230FF78
loc_0230FF7A:
	add r3,r3,#0x1	; 0230FF7A
	cmp r3,#0x4	; 0230FF7C
	bcc loc_0230FF66	; 0230FF7E
	pop {r4}	; 0230FF80
	pop {r3}	; 0230FF82
	bx r3	; 0230FF84
	.byte 0xC0, 0x46	; 0230FF88
pool_0230FF88:
loc_0230FF88:
	.word FirmwareWlWorkPointerSlot	; 0230FF88
pool_0230FF8C:
loc_0230FF8C:
	.word 0x00000200	; 0230FF8C

; ===== function loc_0230FF90 =====
loc_0230FF90:
	push {lr}	; 0230FF90
	sub sp,#0x4	; 0230FF92
	mov r1,#0x0	; 0230FF94
	add r0,sp,#0x0	; 0230FF96
	strh r1,[r0,#0x0]	; 0230FF98
	ldrh r0,[r0,#0x0]	; 0230FF9A
	ldr r1,[pool_0230FFB0]	; 0230FF9C
	ldr r2,[r1,#0x0]	; 0230FF9E
	ldr r1,[pool_0230FFB4]	; 0230FFA0
	add r1,r2,r1	; 0230FFA2
	mov r2,#0xc8	; 0230FFA4
	bl loc_0230FFB8	; 0230FFA6
	add sp,#0x4	; 0230FFAA
	pop {r3}	; 0230FFAC
	bx r3	; 0230FFAE
pool_0230FFB0:
loc_0230FFB0:
	.word FirmwareWlWorkPointerSlot	; 0230FFB0
pool_0230FFB4:
loc_0230FFB4:
	.word 0x00000200	; 0230FFB4

; ===== function loc_0230FFB8 =====
loc_0230FFB8:
	bx pc	; 0230FFB8
	.byte 0xC0, 0x46	; 0230FFBC
.arm

; ===== function loc_0230FFBC =====
loc_0230FFBC:
	ldr pc,[pool_0230FFC0]	; 0230FFBC
pool_0230FFC0:
loc_0230FFC0:
	.word loc_037FCE04	; 0230FFC0
.thumb

; ===== function loc_0230FFC4 =====
loc_0230FFC4:
	push {r4,r5,r6,r7,lr}	; 0230FFC4
	sub sp,#0x14	; 0230FFC6
	str r0,[sp,#0x0]	; 0230FFC8
	add r4,r1,#0x0	; 0230FFCA
	add r7,r2,#0x0	; 0230FFCC
	ldr r0,[pool_023100A4]	; 0230FFCE
	ldr r1,[r0,#0x0]	; 0230FFD0
	ldr r0,[pool_023100A8]	; 0230FFD2
	add r5,r1,r0	; 0230FFD4
	add r0,r7,#0x1	; 0230FFD6
	bl loc_023053B8	; 0230FFD8
	cmp r0,#0x20	; 0230FFDC
	bhi loc_0231009A	; 0230FFDE
	mov r0,#0x4	; 0230FFE0
	add r3,r0,#0x0	; 0230FFE2
	ldr r1,[pool_023100AC]	; 0230FFE4
	str r1,[sp,#0x4]	; 0230FFE6
	mov r6,#0x0	; 0230FFE8
	b loc_0231001E	; 0230FFEA
loc_0230FFEC:
	ldrh r1,[r5,#0x0]	; 0230FFEC
	cmp r1,#0x0	; 0230FFEE
	beq loc_02310018	; 0230FFF0
	ldrh r2,[r5,#0xa]	; 0230FFF2
	ldrh r1,[r4,#0x28]	; 0230FFF4
	cmp r2,r1	; 0230FFF6
	bne loc_0231000A	; 0230FFF8
	ldrh r2,[r5,#0x8]	; 0230FFFA
	ldrh r1,[r4,#0x26]	; 0230FFFC
	cmp r2,r1	; 0230FFFE
	bne loc_0231000A	; 02310000
	ldrh r2,[r5,#0x6]	; 02310002
	ldrh r1,[r4,#0x24]	; 02310004
	cmp r2,r1	; 02310006
	beq loc_02310030	; 02310008
loc_0231000A:
	ldrh r2,[r5,#0x30]	; 0231000A
	ldr r1,[sp,#0x4]	; 0231000C
	cmp r2,r1	; 0231000E
	bcs loc_0231001A	; 02310010
	str r2,[sp,#0x4]	; 02310012
	add r3,r6,#0x0	; 02310014
	b loc_0231001A	; 02310016
loc_02310018:
	add r0,r6,#0x0	; 02310018
loc_0231001A:
	add r6,r6,#0x1	; 0231001A
	add r5,#0x32	; 0231001C
loc_0231001E:
	cmp r6,#0x4	; 0231001E
	bcc loc_0230FFEC	; 02310020
	cmp r0,#0x4	; 02310022
	beq loc_0231002A	; 02310024
	add r6,r0,#0x0	; 02310026
	b loc_02310030	; 02310028
loc_0231002A:
	cmp r3,#0x4	; 0231002A
	beq loc_0231009A	; 0231002C
	add r6,r3,#0x0	; 0231002E
loc_02310030:
	ldr r0,[pool_023100A4]	; 02310030
	ldr r1,[r0,#0x0]	; 02310032
	ldr r0,[pool_023100A8]	; 02310034
	add r0,r1,r0	; 02310036
	str r0,[sp,#0x8]	; 02310038
	mov r2,#0x32	; 0231003A
	mul r6,r2	; 0231003C
	add r5,r0,r6	; 0231003E
	mov r1,#0x0	; 02310040
	add r0,sp,#0xc	; 02310042
	strh r1,[r0,#0x0]	; 02310044
	ldrh r0,[r0,#0x0]	; 02310046
	add r1,r5,#0x0	; 02310048
	bl loc_023100B0	; 0231004A
	ldr r0,[pool_023100AC]	; 0231004E
	strh r0,[r5,#0x30]	; 02310050
	ldrh r1,[r4,#0x12]	; 02310052
	mov r0,#0xff	; 02310054
	and r1,r0	; 02310056
	ldr r0,[sp,#0x8]	; 02310058
	strh r1,[r0,r6]	; 0231005A
	ldr r0,[sp,#0x0]	; 0231005C
	strh r0,[r5,#0x2]	; 0231005E
	add r0,r5,#0x6	; 02310060
	add r1,r4,#0x0	; 02310062
	add r1,#0x24	; 02310064
	bl loc_0230645C	; 02310066
	add r0,r7,#0x1	; 0231006A
	bl loc_023053B8	; 0231006C
	strh r0,[r5,#0xc]	; 02310070
	mov r6,#0x0	; 02310072
	add r7,r7,#0x2	; 02310074
	b loc_0231008C	; 02310076
loc_02310078:
	add r0,r7,r6	; 02310078
	bl loc_023053B8	; 0231007A
	add r1,r0,#0x0	; 0231007E
	add r0,r5,#0x0	; 02310080
	add r0,#0xe	; 02310082
	add r0,r0,r6	; 02310084
	bl loc_023053DC	; 02310086
	add r6,r6,#0x1	; 0231008A
loc_0231008C:
	ldrh r0,[r5,#0xc]	; 0231008C
	cmp r6,r0	; 0231008E
	bcc loc_02310078	; 02310090
	ldrh r0,[r4,#0x34]	; 02310092
	strh r0,[r5,#0x2e]	; 02310094
	ldrh r0,[r4,#0x36]	; 02310096
	strh r0,[r5,#0x4]	; 02310098
loc_0231009A:
	add sp,#0x14	; 0231009A
	pop {r4,r5,r6,r7}	; 0231009C
	pop {r3}	; 0231009E
	bx r3	; 023100A0
	.byte 0xC0, 0x46	; 023100A4
pool_023100A4:
loc_023100A4:
	.word FirmwareWlWorkPointerSlot	; 023100A4
pool_023100A8:
loc_023100A8:
	.word 0x00000200	; 023100A8
pool_023100AC:
loc_023100AC:
	.word 0x00000400	; 023100AC

; ===== function loc_023100B0 =====
loc_023100B0:
	bx pc	; 023100B0
	.byte 0xC0, 0x46	; 023100B4
.arm

; ===== function loc_023100B4 =====
loc_023100B4:
	ldr pc,[pool_023100B8]	; 023100B4
pool_023100B8:
loc_023100B8:
	.word loc_037FCE04	; 023100B8
.thumb

; ===== function loc_023100BC =====
loc_023100BC:
	push {lr}	; 023100BC
	sub sp,#0x4	; 023100BE
	ldr r0,[pool_02310158]	; 023100C0
	ldr r1,[r0,#0x0]	; 023100C2
	ldr r0,[pool_0231015C]	; 023100C4
	ldr r0,[r1,r0]	; 023100C6
	bl loc_0231016C	; 023100C8
	bl loc_023101DC	; 023100CC
	mov r0,#0x0	; 023100D0
	str r0,[sp,#0x0]	; 023100D2
	mov r0,#0x2c	; 023100D4
	mov r1,#0x2	; 023100D6
	add r2,sp,#0x0	; 023100D8
	bl loc_0231017C	; 023100DA
	ldr r0,[pool_02310158]	; 023100DE
	ldr r1,[r0,#0x0]	; 023100E0
	ldr r0,[pool_0231015C]	; 023100E2
	ldr r0,[r1,r0]	; 023100E4
	bl loc_0231018C	; 023100E6
	ldr r1,[sp,#0x0]	; 023100EA
	cmp r1,#0xa4	; 023100EC
	bcc loc_023100F6	; 023100EE
	ldr r0,[pool_02310160]	; 023100F0
	cmp r1,r0	; 023100F2
	bls loc_023100FA	; 023100F4
loc_023100F6:
	mov r0,#0x0	; 023100F6
	b loc_02310150	; 023100F8
loc_023100FA:
	add r1,r1,#0x2	; 023100FA
	str r1,[sp,#0x0]	; 023100FC
	ldr r0,[pool_02310158]	; 023100FE
	ldr r2,[r0,#0x0]	; 02310100
	ldr r0,[pool_02310164]	; 02310102
	add r0,r2,r0	; 02310104
	bl loc_02305054	; 02310106
	ldr r3,[pool_02310158]	; 0231010A
	ldr r2,[r3,#0x0]	; 0231010C
	ldr r1,[pool_02310168]	; 0231010E
	str r0,[r2,r1]	; 02310110
	ldr r0,[r3,#0x0]	; 02310112
	add r0,r0,r1	; 02310114
	ldr r1,[r0,#0x0]	; 02310116
	cmp r1,#0x0	; 02310118
	bne loc_02310120	; 0231011A
	mov r0,#0x0	; 0231011C
	b loc_02310150	; 0231011E
loc_02310120:
	add r1,#0xc	; 02310120
	str r1,[r0,#0x0]	; 02310122
	ldr r1,[r3,#0x0]	; 02310124
	ldr r0,[pool_0231015C]	; 02310126
	ldr r0,[r1,r0]	; 02310128
	bl loc_0231016C	; 0231012A
	bl loc_023101DC	; 0231012E
	mov r0,#0x2a	; 02310132
	ldr r1,[sp,#0x0]	; 02310134
	ldr r2,[pool_02310158]	; 02310136
	ldr r3,[r2,#0x0]	; 02310138
	ldr r2,[pool_02310168]	; 0231013A
	ldr r2,[r3,r2]	; 0231013C
	bl loc_0231017C	; 0231013E
	ldr r0,[pool_02310158]	; 02310142
	ldr r1,[r0,#0x0]	; 02310144
	ldr r0,[pool_0231015C]	; 02310146
	ldr r0,[r1,r0]	; 02310148
	bl loc_0231018C	; 0231014A
	mov r0,#0x1	; 0231014E
loc_02310150:
	add sp,#0x4	; 02310150
	pop {r3}	; 02310152
	bx r3	; 02310154
	.byte 0xC0, 0x46	; 02310158
pool_02310158:
loc_02310158:
	.word FirmwareWlWorkPointerSlot	; 02310158
pool_0231015C:
loc_0231015C:
	.word 0x000002D8	; 0231015C
pool_02310160:
loc_02310160:
	.word 0x000001D6	; 02310160
pool_02310164:
loc_02310164:
	.word 0x0000014C	; 02310164
pool_02310168:
loc_02310168:
	.word 0x000002DC	; 02310168

; ===== function loc_0231016C =====
loc_0231016C:
	bx pc	; 0231016C
	.byte 0xC0, 0x46	; 02310170
.arm

; ===== function loc_02310170 =====
loc_02310170:
	ldr r12,[pool_02310178]	; 02310170
	bx r12	; 02310174
pool_02310178:
loc_02310178:
	.word loc_03800A20 + 1	; 02310178
.thumb

; ===== function loc_0231017C =====
loc_0231017C:
	bx pc	; 0231017C
	.byte 0xC0, 0x46	; 02310180
.arm

; ===== function loc_02310180 =====
loc_02310180:
	ldr r12,[pool_02310188]	; 02310180
	bx r12	; 02310184
pool_02310188:
loc_02310188:
	.word loc_038018B8 + 1	; 02310188
.thumb

; ===== function loc_0231018C =====
loc_0231018C:
	bx pc	; 0231018C
	.byte 0xC0, 0x46	; 02310190
.arm

; ===== function loc_02310190 =====
loc_02310190:
	ldr r12,[pool_02310198]	; 02310190
	bx r12	; 02310194
pool_02310198:
loc_02310198:
	.word loc_038009D8 + 1	; 02310198
.thumb

; ===== function loc_0231019C =====
loc_0231019C:
	push {r4,r5,r6,lr}	; 0231019C
	add r5,r1,#0x0	; 0231019E
	add r6,r2,#0x0	; 023101A0
	ldr r1,[pool_023101D4]	; 023101A2
	ldr r2,[r1,#0x0]	; 023101A4
	ldr r1,[pool_023101D8]	; 023101A6
	ldr r1,[r2,r1]	; 023101A8
	cmp r1,#0x0	; 023101AA
	beq loc_023101CC	; 023101AC
	add r4,r1,r0	; 023101AE
	sub r4,#0x2a	; 023101B0
	b loc_023101C8	; 023101B2
loc_023101B4:
	add r0,r4,#0x0	; 023101B4
	bl loc_023053B8	; 023101B6
	add r4,r4,#0x1	; 023101BA
	add r1,r0,#0x0	; 023101BC
	add r0,r6,#0x0	; 023101BE
	bl loc_023053DC	; 023101C0
	add r6,r6,#0x1	; 023101C4
	sub r5,r5,#0x1	; 023101C6
loc_023101C8:
	cmp r5,#0x0	; 023101C8
	bne loc_023101B4	; 023101CA
loc_023101CC:
	pop {r4,r5,r6}	; 023101CC
	pop {r3}	; 023101CE
	bx r3	; 023101D0
	.byte 0xC0, 0x46	; 023101D4
pool_023101D4:
loc_023101D4:
	.word FirmwareWlWorkPointerSlot	; 023101D4
pool_023101D8:
loc_023101D8:
	.word 0x000002DC	; 023101D8

; ===== function loc_023101DC =====
loc_023101DC:
	push {r4,r5,lr}	; 023101DC
	sub sp,#0x4	; 023101DE
	mov r5,#0x2	; 023101E0
	str r5,[sp,#0x0]	; 023101E2
	add r4,sp,#0x0	; 023101E4
	b loc_023101EE	; 023101E6
loc_023101E8:
	add r0,r4,#0x0	; 023101E8
	bl loc_02310200	; 023101EA
loc_023101EE:
	ldr r0,[sp,#0x0]	; 023101EE
	and r0,r5	; 023101F0
	cmp r0,#0x0	; 023101F2
	bne loc_023101E8	; 023101F4
	add sp,#0x4	; 023101F6
	pop {r4,r5}	; 023101F8
	pop {r3}	; 023101FA
	bx r3	; 023101FC
	.byte 0xC0, 0x46	; 02310200

; ===== function loc_02310200 =====
loc_02310200:
	bx pc	; 02310200
	.byte 0xC0, 0x46	; 02310204
.arm

; ===== function loc_02310204 =====
loc_02310204:
	ldr r12,[pool_0231020C]	; 02310204
	bx r12	; 02310208
pool_0231020C:
loc_0231020C:
	.word loc_038019B4 + 1	; 0231020C
.thumb

; ===== function loc_02310210 =====
loc_02310210:
	push {r4,r5,r6,r7,lr}	; 02310210
	sub sp,#0x4	; 02310212
	add r7,r0,#0x0	; 02310214
	ldr r0,[pool_02310278]	; 02310216
	ldr r1,[r0,#0x0]	; 02310218
	ldr r0,[pool_0231027C]	; 0231021A
	ldr r1,[r1,r0]	; 0231021C
	ldrh r4,[r1,#0x2]	; 0231021E
	cmp r4,#0xa4	; 02310220
	bcc loc_0231022A	; 02310222
	ldr r0,[pool_02310280]	; 02310224
	cmp r4,r0	; 02310226
	bls loc_0231022E	; 02310228
loc_0231022A:
	mov r0,#0x2	; 0231022A
	b loc_0231026E	; 0231022C
loc_0231022E:
	add r6,r1,#0x2	; 0231022E
	mov r5,#0x0	; 02310230
	b loc_0231024C	; 02310232
loc_02310234:
	add r0,r6,#0x0	; 02310234
	bl loc_023053B8	; 02310236
	add r6,r6,#0x1	; 0231023A
	lsl r0,r0,#0x18	; 0231023C
	lsr r0,r0,#0x18	; 0231023E
	lsl r1,r5,#0x10	; 02310240
	lsr r1,r1,#0x10	; 02310242
	bl loc_023052E8	; 02310244
	add r5,r0,#0x0	; 02310248
	sub r4,r4,#0x1	; 0231024A
loc_0231024C:
	cmp r4,#0x0	; 0231024C
	bne loc_02310234	; 0231024E
	ldr r0,[pool_02310278]	; 02310250
	ldr r1,[r0,#0x0]	; 02310252
	ldr r0,[pool_0231027C]	; 02310254
	ldr r0,[r1,r0]	; 02310256
	ldrh r1,[r0,#0x0]	; 02310258
	cmp r7,#0x0	; 0231025A
	beq loc_02310264	; 0231025C
	lsl r0,r5,#0x10	; 0231025E
	orr r0,r1	; 02310260
	str r0,[r7,#0x0]	; 02310262
loc_02310264:
	cmp r5,r1	; 02310264
	beq loc_0231026C	; 02310266
	mov r0,#0x1	; 02310268
	b loc_0231026E	; 0231026A
loc_0231026C:
	mov r0,#0x0	; 0231026C
loc_0231026E:
	add sp,#0x4	; 0231026E
	pop {r4,r5,r6,r7}	; 02310270
	pop {r3}	; 02310272
	bx r3	; 02310274
	.byte 0xC0, 0x46	; 02310278
pool_02310278:
loc_02310278:
	.word FirmwareWlWorkPointerSlot	; 02310278
pool_0231027C:
loc_0231027C:
	.word 0x000002DC	; 0231027C
pool_02310280:
loc_02310280:
	.word 0x000001D6	; 02310280
	.byte 0x19, 0x1F, 0x30, 0x02, 0xC5, 0x1F, 0x30, 0x02, 0x0D, 0x21, 0x30, 0x02, 0x4D, 0x45, 0x30, 0x02	; 02310294
	.byte 0x95, 0x45, 0x30, 0x02, 0x5D, 0x47, 0x30, 0x02, 0xD1, 0x47, 0x30, 0x02, 0xA1, 0x21, 0x30, 0x02	; 023102A4
	.byte 0x59, 0x22, 0x30, 0x02, 0xD9, 0x23, 0x30, 0x02, 0xC9, 0x24, 0x30, 0x02, 0x55, 0x27, 0x30, 0x02	; 023102B4
	.byte 0xE1, 0x27, 0x30, 0x02, 0x19, 0x2D, 0x30, 0x02, 0x51, 0x2D, 0x30, 0x02, 0x65, 0x2E, 0x30, 0x02	; 023102C4
	.byte 0xF5, 0x2E, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02	; 023102D4
	.byte 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02	; 023102E4
	.byte 0x35, 0x2F, 0x30, 0x02, 0x45, 0x30, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02	; 023102F4
	.byte 0xB1, 0x37, 0x30, 0x02, 0xAD, 0x30, 0x30, 0x02, 0x21, 0x31, 0x30, 0x02, 0x51, 0x32, 0x30, 0x02	; 02310304
	.byte 0xB1, 0x32, 0x30, 0x02, 0xE5, 0x43, 0x30, 0x02, 0x55, 0x44, 0x30, 0x02, 0x49, 0x48, 0x30, 0x02	; 02310314
	.byte 0xAD, 0x48, 0x30, 0x02, 0x89, 0x37, 0x30, 0x02, 0x65, 0x37, 0x30, 0x02	; 02310314
P4_Data_02310320:
	.byte 0xBD, 0xA0, 0x30, 0x02	; 02310320
	.byte 0x15, 0xA0, 0x30, 0x02, 0x5D, 0x9F, 0x30, 0x02, 0xB5, 0x9E, 0x30, 0x02, 0x85, 0x9E, 0x30, 0x02	; 02310334
	.byte 0xA5, 0x9C, 0x30, 0x02, 0xA9, 0xFC, 0x30, 0x02, 0xD9, 0xDF, 0x30, 0x02, 0x99, 0x8C, 0x30, 0x02	; 02310344
	.byte 0x11, 0xDE, 0x30, 0x02, 0xBD, 0x8E, 0x30, 0x02, 0xE5, 0x95, 0x30, 0x02, 0xC9, 0x4A, 0x30, 0x02	; 02310354
	.byte 0x6D, 0x9C, 0x30, 0x02, 0x29, 0x8B, 0x30, 0x02, 0x65, 0x88, 0x30, 0x02, 0xB1, 0x87, 0x30, 0x02	; 02310364
	.byte 0xC9, 0xD9, 0x30, 0x02, 0x55, 0xFF, 0x30, 0x02, 0x31, 0x95, 0x30, 0x02, 0x15, 0x87, 0x30, 0x02	; 02310374
	.byte 0xC1, 0x50, 0x30, 0x02, 0x03, 0x00, 0x03, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 02310384
	.byte 0x03, 0x09, 0xBF, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310394
	.byte 0x03, 0x09, 0xBF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00, 0x0B, 0x00, 0x0C, 0x00	; 023103A4
	.byte 0x12, 0x00, 0x16, 0x00, 0x18, 0x00, 0x24, 0x00, 0x30, 0x00, 0x48, 0x00, 0x60, 0x00, 0x6C, 0x00	; 023103B4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023103C4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023103D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023103D4
P4_Data_023103DC:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14	; 023103DC
	.byte 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4, 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4	; 023103F4
	.byte 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44, 0x46, 0x01, 0x48, 0x01, 0x4A, 0x01, 0x4C, 0x01	; 02310404
	.byte 0x20, 0x01, 0x22, 0x01, 0x54, 0x01, 0x44, 0x01, 0x30, 0x01, 0x32, 0x01, 0x40, 0x01, 0x42, 0x01	; 02310414
	.byte 0x38, 0x00, 0x24, 0x01, 0x28, 0x01, 0x50, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310424
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310434
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310444
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310454
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310464
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310464
P4_Data_0231046C:
	.byte 0x04, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00	; 0231046C
	.byte 0x0A, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0xFF, 0xFF, 0x54, 0x02, 0x00, 0x00	; 02310484
	.byte 0xB4, 0x00, 0xFF, 0xFF, 0x80, 0x00, 0x00, 0x00, 0x2A, 0x00, 0x00, 0x00, 0x28, 0x00, 0x00, 0x00	; 02310494
	.byte 0xE8, 0x00, 0x00, 0x00, 0xEA, 0x00, 0x00, 0x00, 0xEE, 0x00, 0x01, 0x00, 0xEC, 0x00, 0x03, 0x3F	; 023104A4
	.byte 0xA2, 0x01, 0x01, 0x00, 0xA0, 0x01, 0x00, 0x00, 0x10, 0x01, 0x00, 0x08, 0xBC, 0x00, 0x01, 0x00	; 023104B4
	.byte 0xD4, 0x00, 0x03, 0x00, 0xD8, 0x00, 0x04, 0x00, 0xDA, 0x00, 0x02, 0x06, 0x76, 0x00, 0x00, 0x00	; 023104C4
P4_Data_023104C4:
	.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x01, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023104C4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0x02, 0x00, 0x03, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023104E4
	.byte 0xFF, 0x00, 0x04, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x05, 0x00, 0xFF, 0x00, 0x06, 0x00	; 023104F4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310504
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x07, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310514
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x08, 0x00	; 02310524
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310534
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310544
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x09, 0x00	; 02310554
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310564
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310574
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0A, 0x00	; 02310584
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310594
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0B, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023105A4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023105B4
P4_Data_023105B4:
	.byte 0x18, 0x00, 0xFF, 0xFF, 0x1A, 0x00, 0xFF, 0xFF, 0x1C, 0x00, 0xFF, 0xFF, 0x22, 0x01, 0xFF, 0xFF	; 023105B4
	.byte 0x24, 0x01, 0xFF, 0xFF, 0x02, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x1C, 0x00	; 023105D4
	.byte 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x26, 0x00, 0x29, 0x00, 0x2C, 0x00	; 023105E4
	.byte 0x2D, 0x00, 0x2E, 0x00, 0x2F, 0x00, 0x30, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00	; 023105F4
	.byte 0x37, 0x00, 0x65, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 02310604
	.byte 0x0C, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x11, 0x00, 0x12, 0x00, 0x14, 0x00	; 02310614
	.byte 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x19, 0x00, 0x1A, 0x00, 0x27, 0x00, 0x4D, 0x00	; 02310624
	.byte 0x5D, 0x00, 0x5E, 0x00, 0x5F, 0x00, 0x60, 0x00, 0x61, 0x00, 0x64, 0x00, 0x66, 0x00, 0x00, 0x00	; 02310634
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x18, 0x00, 0x02, 0x00, 0xC9, 0xB7, 0x30, 0x02	; 02310644
	.byte 0x04, 0x00, 0x01, 0x00, 0x99, 0xB6, 0x30, 0x02, 0x0A, 0x00, 0x01, 0x00, 0x55, 0xB2, 0x30, 0x02	; 02310654
	.byte 0x0C, 0x00, 0x01, 0x00, 0x09, 0xB2, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0xD1, 0xB1, 0x30, 0x02	; 02310664
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310674
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310684
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x35, 0xAA, 0x30, 0x02	; 02310694
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x81, 0xB1, 0x30, 0x02	; 023106A4
	.byte 0x00, 0x00, 0x01, 0x00, 0x39, 0xB1, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xF5, 0xB0, 0x30, 0x02	; 023106B4
	.byte 0x00, 0x00, 0x01, 0x00, 0xC9, 0xB0, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x9D, 0xB0, 0x30, 0x02	; 023106C4
	.byte 0x00, 0x00, 0x09, 0x00, 0x49, 0xB0, 0x30, 0x02, 0x00, 0x00, 0x5C, 0x00, 0xF9, 0xAF, 0x30, 0x02	; 023106D4
	.byte 0x00, 0x00, 0x02, 0x00, 0xDD, 0xAF, 0x30, 0x02, 0x04, 0x00, 0x01, 0x00, 0x2D, 0xAE, 0x30, 0x02	; 023106E4
	.byte 0x01, 0x00, 0x01, 0x00, 0x85, 0xA9, 0x30, 0x02, 0x03, 0x00, 0x01, 0x00, 0x01, 0xA9, 0x30, 0x02	; 023106F4
	.byte 0x1F, 0x00, 0x23, 0x00, 0xE1, 0xA7, 0x30, 0x02, 0x22, 0x00, 0x05, 0x00, 0x55, 0xA6, 0x30, 0x02	; 02310704
	.byte 0x05, 0x00, 0x06, 0x00, 0xA1, 0xA5, 0x30, 0x02, 0x04, 0x00, 0x04, 0x00, 0xF5, 0xA4, 0x30, 0x02	; 02310714
	.byte 0x05, 0x00, 0x03, 0x00, 0x31, 0xA4, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310724
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x17, 0x00, 0x01, 0x00, 0xE1, 0xA2, 0x30, 0x02	; 02310734
	.byte 0x0C, 0x00, 0x12, 0x00, 0x15, 0xA2, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310744
	.byte 0x00, 0x00, 0x04, 0x00, 0x0D, 0xAA, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310754
	.byte 0x00, 0x00, 0x03, 0x00, 0xE5, 0xA9, 0x30, 0x02, 0x00, 0x00, 0x02, 0x00, 0xC9, 0xA9, 0x30, 0x02	; 02310764
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x02, 0x00, 0xAD, 0xA9, 0x30, 0x02	; 02310774
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310784
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310794
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 023107A4
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 023107B4
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 023107C4
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 023107D4
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 023107E4
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x48, 0x00, 0x01, 0x00, 0xF5, 0xAB, 0x30, 0x02	; 023107F4
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310804
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0xB1, 0xAB, 0x30, 0x02	; 02310814
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310824
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310834
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310844
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310854
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310864
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310874
	.byte 0x03, 0x00, 0x01, 0x00, 0x05, 0xAB, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0xB9, 0xAA, 0x30, 0x02	; 02310884
	.byte 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xE1, 0x95, 0x30, 0x02	; 02310894
	.byte 0x01, 0x00, 0x01, 0x00, 0x8D, 0xAA, 0x30, 0x02, 0x32, 0x2E, 0x31, 0x30, 0x2E, 0x30, 0x30, 0x00	; 023108A4
P4_Data_023108A4:
	.byte 0x01, 0x00, 0x04, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023108A4
P4_ImageEnd:
P4_BssStart:
.close

; P4 初始化器从组件末尾清零运行区；只有边界符号，不向文件填充 BSS。
; P4 initialization clears runtime storage after its image; BSS emits no file data.
.definelabel P4_BssBytes, 0x2424
.definelabel P4_BssEnd, P4_BssStart + P4_BssBytes
; P4 服务线程记录 / Thread records used by the P4 service.
.definelabel P4_ServicePrimaryThreadRecord, P4_BssStart + 0x23B8
.definelabel P4_ServiceSecondaryThreadRecord, P4_BssStart + 0x1FB8
