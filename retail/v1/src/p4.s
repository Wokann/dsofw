; official_v1_p4
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
	.word 0x0231106C	; 023003B4
pool_023003B8:
loc_023003B8:
	.word 0x0231106C	; 023003B8
pool_023003BC:
loc_023003BC:
	.word 0x023108AC	; 023003BC

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
	.word 0x023117D0	; 0230081C
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
	.word 0x0231176C	; 0230087C
pool_02300880:
loc_02300880:
	.word 0x023117AC	; 02300880

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
	.word 0x0231176C	; 023008B8

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
	bl loc_023048B4	; 02300968
	add sp,#0xc	; 0230096C
	pop {r4,r5}	; 0230096E
	pop {r3}	; 02300970
	bx r3	; 02300972
pool_02300974:
loc_02300974:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 02300974
pool_02300978:
loc_02300978:
	.word 0x0231176C	; 02300978
pool_0230097C:
loc_0230097C:
	.word 0x02311780	; 0230097C
pool_02300980:
loc_02300980:
	.word 0x02311788	; 02300980
pool_02300984:
loc_02300984:
	.word 0x0231179C	; 02300984
pool_02300988:
loc_02300988:
	.word 0x023117AC	; 02300988
pool_0230098C:
loc_0230098C:
	.word 0x023117C0	; 0230098C
pool_02300990:
loc_02300990:
	.word 0x023117D0	; 02300990
pool_02300994:
loc_02300994:
	.word 0x023117E4	; 02300994
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
	.word 0x02312CC4	; 02300C28
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
	bl loc_02303AD8	; 02300EB2
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
	bl loc_02303AD8	; 023011B8
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
	bl loc_02303954	; 0230123C
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
	bl loc_02303954	; 0230140E
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
	bl loc_02303AD8	; 0230142C
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
	.word 0x02310280	; 02301868
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
	bl loc_023044A8	; 02301F34
	mov r0,#0xf	; 02301F38
	bl loc_02301F90	; 02301F3A
	mov r1,#0x1	; 02301F3E
	ldr r0,[r4,#0x0]	; 02301F40
	strh r1,[r0,#0x0]	; 02301F42
	add r0,sp,#0x0	; 02301F44
	add r1,sp,#0x0	; 02301F46
	add r1,#0x2	; 02301F48
	bl loc_02304604	; 02301F4A
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
	ldr r1,[pool_023026E0]	; 023024D6
	ldr r5,[r0,r1]	; 023024D8
	ldr r2,[r4,#0x4]	; 023024DA
	ldr r1,[r5,#0x0]	; 023024DC
	ldr r0,[pool_023026E4]	; 023024DE
	str r2,[r1,r0]	; 023024E0
	ldrh r7,[r4,#0x2]	; 023024E2
	ldr r1,[r5,#0x0]	; 023024E4
	ldr r0,[pool_023026E8]	; 023024E6
	strh r7,[r1,r0]	; 023024E8
	ldrh r6,[r4,#0x8]	; 023024EA
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
	ldr r0,[r5,#0x0]	; 0230250E
	mov r2,#0x1	; 02302510
	lsl r2,r7	; 02302512
	ldr r1,[pool_023026EC]	; 02302514
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
	b loc_023026D6	; 0230252E
loc_02302530:
	mov r1,#0x2	; 02302530
	add r0,#0xe2	; 02302532
	strh r1,[r0,#0x0]	; 02302534
	add r0,sp,#0x50	; 02302536
	bl loc_023018FC	; 02302538
	ldrh r1,[r0,#0x4]	; 0230253C
	cmp r1,#0x0	; 0230253E
	beq loc_0230254A	; 02302540
	ldr r0,[pool_023026F0]	; 02302542
	bl loc_023024A4	; 02302544
	b loc_023026D6	; 02302548
loc_0230254A:
	ldrh r0,[r0,#0x6]	; 0230254A
	cmp r0,#0x10	; 0230254C
	bne loc_02302592	; 0230254E
	mov r0,#0xa	; 02302550
	add r1,sp,#0x50	; 02302552
	bl loc_0230056C	; 02302554
	cmp r0,#0x0	; 02302558
	bne loc_0230255E	; 0230255A
	b loc_023026D6	; 0230255C
loc_0230255E:
	add r0,sp,#0x50	; 0230255E
	bl loc_0230194C	; 02302560
	ldrh r1,[r0,#0x4]	; 02302564
	cmp r1,#0x0	; 02302566
	beq loc_02302572	; 02302568
	ldr r0,[pool_023026F4]	; 0230256A
	bl loc_023024A4	; 0230256C
	b loc_023026D6	; 02302570
loc_02302572:
	mov r1,#0x3	; 02302572
	ldr r0,[r5,#0x0]	; 02302574
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
	b loc_023026D6	; 02302590
loc_02302592:
	mov r1,#0x5	; 02302592
	ldr r0,[r5,#0x0]	; 02302594
	strh r1,[r0,#0x0]	; 02302596
	ldr r1,[pool_023026F8]	; 02302598
	add r0,sp,#0x14	; 0230259A
	strh r1,[r0,#0x2]	; 0230259C
	ldrh r0,[r0,#0x2]	; 0230259E
	add r1,sp,#0x1c	; 023025A0
	add r1,#0x2	; 023025A2
	mov r2,#0x20	; 023025A4
	bl loc_02302704	; 023025A6
	add r0,sp,#0x3c	; 023025AA
	add r0,#0x2	; 023025AC
	strb r7,[r0,#0x0]	; 023025AE
	add r0,sp,#0x3c	; 023025B0
	add r0,#0x3	; 023025B2
	mov r1,#0x0	; 023025B4
	mov r2,#0xf	; 023025B6
	bl loc_02302710	; 023025B8
	add r0,sp,#0x1c	; 023025BC
	add r0,#0x2	; 023025BE
	str r0,[sp,#0x0]	; 023025C0
	mov r0,#0x1	; 023025C2
	str r0,[sp,#0x4]	; 023025C4
	add r0,sp,#0x3c	; 023025C6
	add r0,#0x2	; 023025C8
	str r0,[sp,#0x8]	; 023025CA
	str r6,[sp,#0xc]	; 023025CC
	add r0,sp,#0x50	; 023025CE
	ldr r1,[pool_023026FC]	; 023025D0
	add r2,sp,#0x18	; 023025D2
	mov r3,#0x0	; 023025D4
	bl loc_02301E08	; 023025D6
	add r6,r0,#0x0	; 023025DA
	ldrh r1,[r6,#0x4]	; 023025DC
	cmp r1,#0x0	; 023025DE
	beq loc_023025EA	; 023025E0
	mov r0,#0x2	; 023025E2
	bl loc_023024A4	; 023025E4
	b loc_023026D6	; 023025E8
loc_023025EA:
	bl loc_02300404	; 023025EA
	add r4,r0,#0x0	; 023025EE
	ldrh r0,[r6,#0x8]	; 023025F0
	cmp r0,#0x0	; 023025F2
	bne loc_02302608	; 023025F4
	mov r0,#0xa	; 023025F6
	strh r0,[r4,#0x0]	; 023025F8
	mov r1,#0x0	; 023025FA
	strh r1,[r4,#0x2]	; 023025FC
	mov r0,#0x4	; 023025FE
	strh r0,[r4,#0x8]	; 02302600
	strh r7,[r4,#0x10]	; 02302602
	strh r1,[r4,#0x12]	; 02302604
	b loc_023026D0	; 02302606
loc_02302608:
	ldr r1,[pool_02302700]	; 02302608
	ldr r0,[sp,#0x10]	; 0230260A
	ldr r0,[r0,r1]	; 0230260C
	ldr r2,[r5,#0x0]	; 0230260E
	ldr r1,[pool_023026E4]	; 02302610
	ldr r1,[r2,r1]	; 02302612
	add r1,#0x40	; 02302614
	mov r2,#0x0	; 02302616
	mov r3,#0x80	; 02302618
	bl loc_0230271C	; 0230261A
	ldr r1,[pool_02302700]	; 0230261E
	ldr r0,[sp,#0x10]	; 02302620
	ldr r0,[r0,r1]	; 02302622
	add r1,r6,#0x0	; 02302624
	add r1,#0xa	; 02302626
	ldr r3,[r5,#0x0]	; 02302628
	ldr r2,[pool_023026E4]	; 0230262A
	ldr r2,[r3,r2]	; 0230262C
	mov r3,#0xc0	; 0230262E
	bl loc_023006B4	; 02302630
	mov r0,#0xa	; 02302634
	strh r0,[r4,#0x0]	; 02302636
	mov r0,#0x0	; 02302638
	strh r0,[r4,#0x2]	; 0230263A
	mov r0,#0x5	; 0230263C
	strh r0,[r4,#0x8]	; 0230263E
	add r0,r6,#0x0	; 02302640
	add r0,#0x40	; 02302642
	ldrh r0,[r0,#0x0]	; 02302644
	strh r0,[r4,#0x10]	; 02302646
	ldrh r0,[r6,#0xc]	; 02302648
	lsl r0,r0,#0x18	; 0230264A
	lsr r0,r0,#0x18	; 0230264C
	bl loc_02300470	; 0230264E
	add r1,sp,#0x14	; 02302652
	strb r0,[r1,#0x0]	; 02302654
	add r0,sp,#0x14	; 02302656
	mov r1,#0x1	; 02302658
	bl P4_ClassifyByteArrayAverage	; 0230265A
	strh r0,[r4,#0x12]	; 0230265E
	ldrh r0,[r6,#0x14]	; 02302660
	strh r0,[r4,#0x14]	; 02302662
	add r0,r4,#0x0	; 02302664
	add r0,#0xa	; 02302666
	add r1,r6,#0x0	; 02302668
	add r1,#0xe	; 0230266A
	bl loc_023007BC	; 0230266C
	ldr r1,[pool_02302700]	; 02302670
	ldr r0,[sp,#0x10]	; 02302672
	ldr r0,[r0,r1]	; 02302674
	add r1,r6,#0x0	; 02302676
	add r1,#0x16	; 02302678
	add r2,r4,#0x0	; 0230267A
	add r2,#0x16	; 0230267C
	mov r3,#0x20	; 0230267E
	bl loc_023006B4	; 02302680
	add r0,r6,#0x0	; 02302684
	add r0,#0x46	; 02302686
	ldrh r0,[r0,#0x0]	; 02302688
	strh r0,[r4,#0x36]	; 0230268A
	ldrh r0,[r4,#0x36]	; 0230268C
	cmp r0,#0x80	; 0230268E
	bls loc_023026A4	; 02302690
	mov r0,#0xa	; 02302692
	strh r0,[r4,#0x0]	; 02302694
	mov r1,#0x0	; 02302696
	strh r1,[r4,#0x2]	; 02302698
	mov r0,#0x4	; 0230269A
	strh r0,[r4,#0x8]	; 0230269C
	strh r7,[r4,#0x10]	; 0230269E
	strh r1,[r4,#0x12]	; 023026A0
	b loc_023026D0	; 023026A2
loc_023026A4:
	ldr r1,[pool_02302700]	; 023026A4
	ldr r0,[sp,#0x10]	; 023026A6
	ldr r0,[r0,r1]	; 023026A8
	add r1,r4,#0x0	; 023026AA
	add r1,#0x38	; 023026AC
	mov r2,#0x0	; 023026AE
	mov r3,#0x80	; 023026B0
	bl loc_0230271C	; 023026B2
	ldr r1,[pool_02302700]	; 023026B6
	ldr r0,[sp,#0x10]	; 023026B8
	ldr r0,[r0,r1]	; 023026BA
	add r6,#0x4a	; 023026BC
	add r1,r6,#0x0	; 023026BE
	add r2,r4,#0x0	; 023026C0
	add r2,#0x38	; 023026C2
	ldrh r3,[r4,#0x36]	; 023026C4
	add r3,r3,#0x1	; 023026C6
	mov r5,#0x1	; 023026C8
	bic r3,r5	; 023026CA
	bl loc_023006B4	; 023026CC
loc_023026D0:
	add r0,r4,#0x0	; 023026D0
	bl loc_02300414	; 023026D2
loc_023026D6:
	add sp,#0x1fc	; 023026D6
	add sp,#0x58	; 023026D8
	pop {r4,r5,r6,r7}	; 023026DA
	pop {r3}	; 023026DC
	bx r3	; 023026DE
pool_023026E0:
loc_023026E0:
	.word 0x00001518	; 023026E0
pool_023026E4:
loc_023026E4:
	.word 0x00000180	; 023026E4
pool_023026E8:
loc_023026E8:
	.word 0x0000018C	; 023026E8
pool_023026EC:
loc_023026EC:
	.word 0x000001F0	; 023026EC
pool_023026F0:
loc_023026F0:
	.word 0x00000308	; 023026F0
pool_023026F4:
loc_023026F4:
	.word 0x00000303	; 023026F4
pool_023026F8:
loc_023026F8:
	.word 0x0000FFFF	; 023026F8
pool_023026FC:
loc_023026FC:
	.word 0x0000011C	; 023026FC
pool_02302700:
loc_02302700:
	.word 0x0000150C	; 02302700

; ===== function loc_02302704 =====
loc_02302704:
	bx pc	; 02302704
	.byte 0xC0, 0x46	; 02302708
.arm

; ===== function loc_02302708 =====
loc_02302708:
	ldr pc,[pool_0230270C]	; 02302708
pool_0230270C:
loc_0230270C:
	.word loc_037FCE04	; 0230270C
.thumb

; ===== function loc_02302710 =====
loc_02302710:
	bx pc	; 02302710
	.byte 0xC0, 0x46	; 02302714
.arm

; ===== function loc_02302714 =====
loc_02302714:
	ldr pc,[pool_02302718]	; 02302714
pool_02302718:
loc_02302718:
	.word loc_037FCEB0	; 02302718
.thumb

; ===== function loc_0230271C =====
loc_0230271C:
	bx pc	; 0230271C
	.byte 0xC0, 0x46	; 02302720
.arm

; ===== function loc_02302720 =====
loc_02302720:
	ldr r12,[pool_02302728]	; 02302720
	bx r12	; 02302724
pool_02302728:
loc_02302728:
	.word P2_Entry_037FCD94 + 1	; 02302728
.thumb

; ===== function loc_0230272C =====
loc_0230272C:
	push {r4,r5,lr}	; 0230272C
	sub sp,#0x4	; 0230272E
	add r5,r0,#0x0	; 02302730
	add r4,r1,#0x0	; 02302732
	bl loc_02300404	; 02302734
	mov r1,#0xb	; 02302738
	strh r1,[r0,#0x0]	; 0230273A
	mov r1,#0x1	; 0230273C
	strh r1,[r0,#0x2]	; 0230273E
	strh r5,[r0,#0x4]	; 02302740
	strh r4,[r0,#0x6]	; 02302742
	bl loc_02300414	; 02302744
	add sp,#0x4	; 02302748
	pop {r4,r5}	; 0230274A
	pop {r3}	; 0230274C
	bx r3	; 0230274E

; ===== function loc_02302750 =====
	push {r4,r5,lr}	; 02302750
	sub sp,#0x1fc	; 02302752
	sub sp,#0x8	; 02302754
	add r5,sp,#0x0	; 02302756
	bl loc_023008B4	; 02302758
	ldr r1,[pool_023027B0]	; 0230275C
	ldr r4,[r0,r1]	; 0230275E
	ldr r0,[r4,#0x0]	; 02302760
	ldrh r0,[r0,#0x0]	; 02302762
	cmp r0,#0x5	; 02302764
	beq loc_0230277A	; 02302766
	bl loc_02300404	; 02302768
	mov r1,#0xb	; 0230276C
	strh r1,[r0,#0x0]	; 0230276E
	mov r1,#0x3	; 02302770
	strh r1,[r0,#0x2]	; 02302772
	bl loc_02300414	; 02302774
	b loc_023027A4	; 02302778
loc_0230277A:
	add r0,r5,#0x0	; 0230277A
	bl loc_0230195C	; 0230277C
	ldrh r1,[r0,#0x4]	; 02302780
	cmp r1,#0x0	; 02302782
	beq loc_0230278E	; 02302784
	ldr r0,[pool_023027B4]	; 02302786
	bl loc_0230272C	; 02302788
	b loc_023027A4	; 0230278C
loc_0230278E:
	mov r1,#0x2	; 0230278E
	ldr r0,[r4,#0x0]	; 02302790
	strh r1,[r0,#0x0]	; 02302792
	bl loc_02300404	; 02302794
	mov r1,#0xb	; 02302798
	strh r1,[r0,#0x0]	; 0230279A
	mov r1,#0x0	; 0230279C
	strh r1,[r0,#0x2]	; 0230279E
	bl loc_02300414	; 023027A0
loc_023027A4:
	add sp,#0x1fc	; 023027A4
	add sp,#0x8	; 023027A6
	pop {r4,r5}	; 023027A8
	pop {r3}	; 023027AA
	bx r3	; 023027AC
	.byte 0xC0, 0x46	; 023027B0
pool_023027B0:
loc_023027B0:
	.word 0x00001518	; 023027B0
pool_023027B4:
loc_023027B4:
	.word 0x00000302	; 023027B4

; ===== function loc_023027B8 =====
loc_023027B8:
	push {r4,r5,lr}	; 023027B8
	sub sp,#0x4	; 023027BA
	add r5,r0,#0x0	; 023027BC
	add r4,r1,#0x0	; 023027BE
	bl loc_02300404	; 023027C0
	mov r1,#0xc	; 023027C4
	strh r1,[r0,#0x0]	; 023027C6
	mov r1,#0x1	; 023027C8
	strh r1,[r0,#0x2]	; 023027CA
	strh r5,[r0,#0x4]	; 023027CC
	strh r4,[r0,#0x6]	; 023027CE
	bl loc_02300414	; 023027D0
	add sp,#0x4	; 023027D4
	pop {r4,r5}	; 023027D6
	pop {r3}	; 023027D8
	bx r3	; 023027DA

; ===== function loc_023027DC =====
	push {r4,r5,r6,r7,lr}	; 023027DC
	sub sp,#0x1fc	; 023027DE
	sub sp,#0x58	; 023027E0
	add r5,r0,#0x0	; 023027E2
	add r7,sp,#0x10	; 023027E4
	bl loc_023008B4	; 023027E6
	add r6,r0,#0x0	; 023027EA
	ldr r0,[pool_02302ABC]	; 023027EC
	ldr r4,[r6,r0]	; 023027EE
	ldr r0,[pool_02302AC0]	; 023027F0
	ldr r0,[r6,r0]	; 023027F2
	ldr r1,[r5,#0x4]	; 023027F4
	add r2,r4,#0x0	; 023027F6
	add r2,#0x10	; 023027F8
	mov r3,#0xc0	; 023027FA
	bl loc_023006B4	; 023027FC
	add r0,r4,#0x0	; 02302800
	add r0,#0x4c	; 02302802
	ldrh r0,[r0,#0x0]	; 02302804
	cmp r0,#0x10	; 02302806
	bcc loc_0230282E	; 02302808
	add r0,r4,#0x0	; 0230280A
	add r0,#0x5b	; 0230280C
	ldrb r1,[r0,#0x0]	; 0230280E
	mov r0,#0x1	; 02302810
	and r1,r0	; 02302812
	cmp r1,#0x0	; 02302814
	bne loc_0230282E	; 02302816
	bl loc_02300404	; 02302818
	mov r1,#0xc	; 0230281C
	strh r1,[r0,#0x0]	; 0230281E
	mov r1,#0xb	; 02302820
	strh r1,[r0,#0x2]	; 02302822
	mov r1,#0x6	; 02302824
	strh r1,[r0,#0x8]	; 02302826
	bl loc_02300414	; 02302828
	b loc_02302AB2	; 0230282C
loc_0230282E:
	mov r0,#0x1	; 0230282E
	add r1,r4,#0x0	; 02302830
	add r1,#0x46	; 02302832
	ldrh r1,[r1,#0x0]	; 02302834
	lsl r0,r1	; 02302836
	ldr r2,[r4,#0x0]	; 02302838
	ldr r1,[pool_02302AC4]	; 0230283A
	ldrh r1,[r2,r1]	; 0230283C
	and r0,r1	; 0230283E
	cmp r0,#0x0	; 02302840
	bne loc_02302858	; 02302842
	bl loc_02300404	; 02302844
	mov r1,#0xc	; 02302848
	strh r1,[r0,#0x0]	; 0230284A
	mov r1,#0x6	; 0230284C
	strh r1,[r0,#0x2]	; 0230284E
	strh r1,[r0,#0x8]	; 02302850
	bl loc_02300414	; 02302852
	b loc_02302AB2	; 02302856
loc_02302858:
	bl loc_02300404	; 02302858
	mov r1,#0xc	; 0230285C
	strh r1,[r0,#0x0]	; 0230285E
	mov r1,#0x0	; 02302860
	strh r1,[r0,#0x2]	; 02302862
	mov r1,#0x6	; 02302864
	strh r1,[r0,#0x8]	; 02302866
	bl loc_02300414	; 02302868
	ldr r1,[r4,#0x0]	; 0230286C
	ldr r0,[pool_02302AC8]	; 0230286E
	add r0,r1,r0	; 02302870
	ldrh r1,[r0,#0x0]	; 02302872
	cmp r1,#0x1	; 02302874
	bne loc_0230288C	; 02302876
	ldrh r2,[r4,#0x3e]	; 02302878
	mov r1,#0x1	; 0230287A
	and r2,r1	; 0230287C
	cmp r2,#0x0	; 0230287E
	beq loc_02302886	; 02302880
	strh r1,[r0,#0x0]	; 02302882
	b loc_0230289E	; 02302884
loc_02302886:
	mov r1,#0x2	; 02302886
	strh r1,[r0,#0x0]	; 02302888
	b loc_0230289E	; 0230288A
loc_0230288C:
	ldrh r2,[r4,#0x3e]	; 0230288C
	mov r1,#0x2	; 0230288E
	and r2,r1	; 02302890
	cmp r2,#0x0	; 02302892
	beq loc_0230289A	; 02302894
	strh r1,[r0,#0x0]	; 02302896
	b loc_0230289E	; 02302898
loc_0230289A:
	mov r1,#0x1	; 0230289A
	strh r1,[r0,#0x0]	; 0230289C
loc_0230289E:
	ldrh r1,[r4,#0x3c]	; 0230289E
	mov r0,#0x20	; 023028A0
	and r1,r0	; 023028A2
	cmp r1,#0x0	; 023028A4
	beq loc_023028B2	; 023028A6
	mov r2,#0x1	; 023028A8
	ldr r1,[r4,#0x0]	; 023028AA
	ldr r0,[pool_02302ACC]	; 023028AC
	strh r2,[r1,r0]	; 023028AE
	b loc_023028BA	; 023028B0
loc_023028B2:
	mov r2,#0x0	; 023028B2
	ldr r1,[r4,#0x0]	; 023028B4
	ldr r0,[pool_02302ACC]	; 023028B6
	strh r2,[r1,r0]	; 023028B8
loc_023028BA:
	ldrh r1,[r4,#0x3c]	; 023028BA
	mov r0,#0x10	; 023028BC
	and r1,r0	; 023028BE
	cmp r1,#0x0	; 023028C0
	beq loc_023028CE	; 023028C2
	mov r2,#0x1	; 023028C4
	ldr r1,[r4,#0x0]	; 023028C6
	ldr r0,[pool_02302AD0]	; 023028C8
	str r2,[r1,r0]	; 023028CA
	b loc_023028D6	; 023028CC
loc_023028CE:
	mov r2,#0x0	; 023028CE
	ldr r1,[r4,#0x0]	; 023028D0
	ldr r0,[pool_02302AD0]	; 023028D2
	str r2,[r1,r0]	; 023028D4
loc_023028D6:
	add r0,r4,#0x0	; 023028D6
	add r0,#0x4c	; 023028D8
	ldrh r0,[r0,#0x0]	; 023028DA
	cmp r0,#0x0	; 023028DC
	bne loc_023028EA	; 023028DE
	mov r1,#0x3	; 023028E0
	ldr r0,[r4,#0x0]	; 023028E2
	add r0,#0xe2	; 023028E4
	strh r1,[r0,#0x0]	; 023028E6
	b loc_023028F2	; 023028E8
loc_023028EA:
	mov r1,#0x2	; 023028EA
	ldr r0,[r4,#0x0]	; 023028EC
	add r0,#0xe2	; 023028EE
	strh r1,[r0,#0x0]	; 023028F0
loc_023028F2:
	mov r0,#0xc	; 023028F2
	add r1,r7,#0x0	; 023028F4
	bl loc_0230056C	; 023028F6
	cmp r0,#0x0	; 023028FA
	bne loc_02302900	; 023028FC
	b loc_02302AB2	; 023028FE
loc_02302900:
	add r0,r7,#0x0	; 02302900
	bl loc_0230194C	; 02302902
	ldrh r1,[r0,#0x4]	; 02302906
	cmp r1,#0x0	; 02302908
	beq loc_02302914	; 0230290A
	ldr r0,[pool_02302AD4]	; 0230290C
	bl loc_023027B8	; 0230290E
	b loc_02302AB2	; 02302912
loc_02302914:
	ldr r0,[pool_02302AC0]	; 02302914
	ldr r0,[r6,r0]	; 02302916
	add r1,r4,#0x0	; 02302918
	add r1,#0x10	; 0230291A
	add r2,sp,#0x210	; 0230291C
	mov r3,#0x40	; 0230291E
	bl loc_023006B4	; 02302920
	ldr r0,[r4,#0x0]	; 02302924
	add r0,#0xe2	; 02302926
	ldrh r0,[r0,#0x0]	; 02302928
	cmp r0,#0x2	; 0230292A
	bne loc_0230295C	; 0230292C
	mov r0,#0x20	; 0230292E
	add r1,sp,#0x210	; 02302930
	strh r0,[r1,#0xa]	; 02302932
	add r0,r4,#0x0	; 02302934
	add r0,#0x54	; 02302936
	ldrh r0,[r0,#0x0]	; 02302938
	strh r0,[r1,#0xc]	; 0230293A
	add r0,r4,#0x0	; 0230293C
	add r0,#0x56	; 0230293E
	ldrh r0,[r0,#0x0]	; 02302940
	strh r0,[r1,#0xe]	; 02302942
	add r0,r4,#0x0	; 02302944
	add r0,#0x58	; 02302946
	ldrh r0,[r0,#0x0]	; 02302948
	strh r0,[r1,#0x10]	; 0230294A
	mov r0,#0x0	; 0230294C
	strh r0,[r1,#0x12]	; 0230294E
	add r5,#0x8	; 02302950
	add r0,r5,#0x0	; 02302952
	add r1,sp,#0x224	; 02302954
	mov r2,#0x18	; 02302956
	bl loc_02302AF0	; 02302958
loc_0230295C:
	add r0,r7,#0x0	; 0230295C
	ldr r1,[pool_02302AD8]	; 0230295E
	add r2,sp,#0x210	; 02302960
	bl loc_02301DB0	; 02302962
	add r2,r0,#0x0	; 02302966
	ldrh r1,[r2,#0x4]	; 02302968
	cmp r1,#0x0	; 0230296A
	bne loc_02302974	; 0230296C
	ldrh r0,[r2,#0x6]	; 0230296E
	cmp r0,#0x0	; 02302970
	beq loc_0230297C	; 02302972
loc_02302974:
	mov r0,#0x3	; 02302974
	bl loc_023027B8	; 02302976
	b loc_02302AB2	; 0230297A
loc_0230297C:
	ldr r1,[r4,#0x0]	; 0230297C
	ldr r0,[pool_02302ADC]	; 0230297E
	add r0,r1,r0	; 02302980
	add r2,#0x8	; 02302982
	add r1,r2,#0x0	; 02302984
	bl loc_023007BC	; 02302986
	add r0,r4,#0x0	; 0230298A
	add r0,#0x5b	; 0230298C
	ldrb r1,[r0,#0x0]	; 0230298E
	mov r0,#0x4	; 02302990
	and r1,r0	; 02302992
	cmp r1,#0x0	; 02302994
	beq loc_0230299C	; 02302996
	mov r1,#0x6	; 02302998
	b loc_0230299E	; 0230299A
loc_0230299C:
	mov r1,#0x0	; 0230299C
loc_0230299E:
	add r0,r4,#0x0	; 0230299E
	add r0,#0x5e	; 023029A0
	ldrh r0,[r0,#0x0]	; 023029A2
	add r0,r0,#0x2	; 023029A4
	add r2,r0,r1	; 023029A6
	ldr r1,[r4,#0x0]	; 023029A8
	ldr r0,[pool_02302AE0]	; 023029AA
	strh r2,[r1,r0]	; 023029AC
	add r0,r4,#0x0	; 023029AE
	add r0,#0x5b	; 023029B0
	ldrb r1,[r0,#0x0]	; 023029B2
	mov r0,#0x4	; 023029B4
	and r1,r0	; 023029B6
	cmp r1,#0x0	; 023029B8
	beq loc_023029C0	; 023029BA
	mov r1,#0x2a	; 023029BC
	b loc_023029C2	; 023029BE
loc_023029C0:
	mov r1,#0x0	; 023029C0
loc_023029C2:
	add r0,r4,#0x0	; 023029C2
	add r0,#0x5c	; 023029C4
	ldrh r0,[r0,#0x0]	; 023029C6
	add r0,r0,#0x4	; 023029C8
	add r2,r0,r1	; 023029CA
	ldr r1,[r4,#0x0]	; 023029CC
	ldr r0,[pool_02302AE4]	; 023029CE
	strh r2,[r1,r0]	; 023029D0
	add r0,sp,#0x0	; 023029D2
	add r0,#0x2	; 023029D4
	ldr r2,[r4,#0x0]	; 023029D6
	ldr r1,[pool_02302ADC]	; 023029D8
	add r1,r2,r1	; 023029DA
	bl loc_023007BC	; 023029DC
	add r0,r7,#0x0	; 023029E0
	add r1,sp,#0x0	; 023029E2
	add r1,#0x2	; 023029E4
	mov r2,#0x0	; 023029E6
	ldr r3,[pool_02302AD8]	; 023029E8
	bl loc_02301D58	; 023029EA
	ldrh r1,[r0,#0x4]	; 023029EE
	cmp r1,#0xc	; 023029F0
	bne loc_02302A0A	; 023029F2
	ldrh r2,[r0,#0x6]	; 023029F4
	cmp r2,#0x13	; 023029F6
	bne loc_02302A0A	; 023029F8
	bl loc_02300404	; 023029FA
	mov r1,#0xc	; 023029FE
	strh r1,[r0,#0x0]	; 02302A00
	strh r1,[r0,#0x2]	; 02302A02
	bl loc_02300414	; 02302A04
	b loc_02302AB2	; 02302A08
loc_02302A0A:
	cmp r1,#0x0	; 02302A0A
	bne loc_02302A14	; 02302A0C
	ldrh r0,[r0,#0x6]	; 02302A0E
	cmp r0,#0x0	; 02302A10
	beq loc_02302A1C	; 02302A12
loc_02302A14:
	mov r0,#0x4	; 02302A14
	bl loc_023027B8	; 02302A16
	b loc_02302AB2	; 02302A1A
loc_02302A1C:
	add r0,sp,#0x8	; 02302A1C
	ldr r2,[r4,#0x0]	; 02302A1E
	ldr r1,[pool_02302ADC]	; 02302A20
	add r1,r2,r1	; 02302A22
	bl loc_023007BC	; 02302A24
	add r0,r7,#0x0	; 02302A28
	add r1,sp,#0x8	; 02302A2A
	mov r2,#0x1	; 02302A2C
	ldr r3,[pool_02302AD8]	; 02302A2E
	bl loc_02301CA8	; 02302A30
	ldrh r1,[r0,#0x4]	; 02302A34
	cmp r1,#0xc	; 02302A36
	bne loc_02302A52	; 02302A38
	ldrh r2,[r0,#0x6]	; 02302A3A
	cmp r2,#0x13	; 02302A3C
	bne loc_02302A52	; 02302A3E
	bl loc_02300404	; 02302A40
	mov r1,#0xc	; 02302A44
	strh r1,[r0,#0x0]	; 02302A46
	mov r1,#0xb	; 02302A48
	strh r1,[r0,#0x2]	; 02302A4A
	bl loc_02300414	; 02302A4C
	b loc_02302AB2	; 02302A50
loc_02302A52:
	cmp r1,#0x0	; 02302A52
	bne loc_02302A5C	; 02302A54
	ldrh r2,[r0,#0x6]	; 02302A56
	cmp r2,#0x0	; 02302A58
	beq loc_02302A64	; 02302A5A
loc_02302A5C:
	mov r0,#0x6	; 02302A5C
	bl loc_023027B8	; 02302A5E
	b loc_02302AB2	; 02302A62
loc_02302A64:
	ldrh r2,[r0,#0x8]	; 02302A64
	ldr r1,[r4,#0x0]	; 02302A66
	ldr r0,[pool_02302AE8]	; 02302A68
	strh r2,[r1,r0]	; 02302A6A
	add r0,r4,#0x0	; 02302A6C
	add r0,#0x58	; 02302A6E
	ldrh r1,[r0,#0x0]	; 02302A70
	ldr r0,[r4,#0x0]	; 02302A72
	add r0,#0xb6	; 02302A74
	strh r1,[r0,#0x0]	; 02302A76
	mov r1,#0x1	; 02302A78
	add r0,sp,#0x0	; 02302A7A
	strh r1,[r0,#0x0]	; 02302A7C
	ldrh r0,[r0,#0x0]	; 02302A7E
	ldr r2,[r4,#0x0]	; 02302A80
	ldr r1,[pool_02302AEC]	; 02302A82
	add r1,r2,r1	; 02302A84
	mov r2,#0x20	; 02302A86
	bl loc_02302AFC	; 02302A88
	bl loc_02304320	; 02302A8C
	mov r1,#0x8	; 02302A90
	ldr r0,[r4,#0x0]	; 02302A92
	strh r1,[r0,#0x0]	; 02302A94
	bl loc_02300404	; 02302A96
	mov r1,#0xc	; 02302A9A
	strh r1,[r0,#0x0]	; 02302A9C
	mov r1,#0x0	; 02302A9E
	strh r1,[r0,#0x2]	; 02302AA0
	mov r1,#0x7	; 02302AA2
	strh r1,[r0,#0x8]	; 02302AA4
	ldr r2,[r4,#0x0]	; 02302AA6
	ldr r1,[pool_02302AE8]	; 02302AA8
	ldrh r1,[r2,r1]	; 02302AAA
	strh r1,[r0,#0xa]	; 02302AAC
	bl loc_02300414	; 02302AAE
loc_02302AB2:
	add sp,#0x1fc	; 02302AB2
	add sp,#0x58	; 02302AB4
	pop {r4,r5,r6,r7}	; 02302AB6
	pop {r3}	; 02302AB8
	bx r3	; 02302ABA
pool_02302ABC:
loc_02302ABC:
	.word 0x00001518	; 02302ABC
pool_02302AC0:
loc_02302AC0:
	.word 0x0000150C	; 02302AC0
pool_02302AC4:
loc_02302AC4:
	.word 0x000001F0	; 02302AC4
pool_02302AC8:
loc_02302AC8:
	.word 0x000001E8	; 02302AC8
pool_02302ACC:
loc_02302ACC:
	.word 0x000001EA	; 02302ACC
pool_02302AD0:
loc_02302AD0:
	.word 0x00000194	; 02302AD0
pool_02302AD4:
loc_02302AD4:
	.word 0x00000303	; 02302AD4
pool_02302AD8:
loc_02302AD8:
	.word 0x000007D0	; 02302AD8
pool_02302ADC:
loc_02302ADC:
	.word 0x00000186	; 02302ADC
pool_02302AE0:
loc_02302AE0:
	.word 0x0000018E	; 02302AE0
pool_02302AE4:
loc_02302AE4:
	.word 0x00000190	; 02302AE4
pool_02302AE8:
loc_02302AE8:
	.word 0x00000184	; 02302AE8
pool_02302AEC:
loc_02302AEC:
	.word 0x000001F4	; 02302AEC

; ===== function loc_02302AF0 =====
loc_02302AF0:
	bx pc	; 02302AF0
	.byte 0xC0, 0x46	; 02302AF4
.arm

; ===== function loc_02302AF4 =====
loc_02302AF4:
	ldr pc,[pool_02302AF8]	; 02302AF4
pool_02302AF8:
loc_02302AF8:
	.word P2_Entry_037FCEC8	; 02302AF8
.thumb

; ===== function loc_02302AFC =====
loc_02302AFC:
	bx pc	; 02302AFC
	.byte 0xC0, 0x46	; 02302B00
.arm

; ===== function loc_02302B00 =====
loc_02302B00:
	ldr pc,[pool_02302B04]	; 02302B00
pool_02302B04:
loc_02302B04:
	.word loc_037FCE04	; 02302B04
.thumb

; ===== function loc_02302B08 =====
loc_02302B08:
	push {r4,r5,lr}	; 02302B08
	sub sp,#0x4	; 02302B0A
	add r5,r0,#0x0	; 02302B0C
	add r4,r1,#0x0	; 02302B0E
	bl loc_02300404	; 02302B10
	mov r1,#0xd	; 02302B14
	strh r1,[r0,#0x0]	; 02302B16
	mov r1,#0x1	; 02302B18
	strh r1,[r0,#0x2]	; 02302B1A
	strh r5,[r0,#0x4]	; 02302B1C
	strh r4,[r0,#0x6]	; 02302B1E
	bl loc_02300414	; 02302B20
	add sp,#0x4	; 02302B24
	pop {r4,r5}	; 02302B26
	pop {r3}	; 02302B28
	bx r3	; 02302B2A

; ===== function loc_02302B2C =====
loc_02302B2C:
	push {r4,r5,r6,r7,lr}	; 02302B2C
	sub sp,#0x1fc	; 02302B2E
	sub sp,#0x20	; 02302B30
	add r4,r0,#0x0	; 02302B32
	add r7,r1,#0x0	; 02302B34
	bl loc_023008B4	; 02302B36
	ldr r1,[pool_02302CE8]	; 02302B3A
	ldr r5,[r0,r1]	; 02302B3C
	ldr r0,[r4,#0x4]	; 02302B3E
	lsl r0,r0,#0x10	; 02302B40
	lsr r0,r0,#0x10	; 02302B42
	str r0,[sp,#0x0]	; 02302B44
	ldr r2,[r5,#0x0]	; 02302B46
	ldrh r0,[r2,#0x0]	; 02302B48
	cmp r0,#0x9	; 02302B4A
	beq loc_02302B70	; 02302B4C
	cmp r0,#0x7	; 02302B4E
	beq loc_02302B70	; 02302B50
	cmp r0,#0xa	; 02302B52
	beq loc_02302B5A	; 02302B54
	cmp r0,#0x8	; 02302B56
	bne loc_02302B6C	; 02302B58
loc_02302B5A:
	cmp r0,#0xa	; 02302B5A
	bne loc_02302B70	; 02302B5C
	mov r1,#0x0	; 02302B5E
	str r1,[r2,#0x10]	; 02302B60
	ldr r0,[r5,#0x0]	; 02302B62
	str r1,[r0,#0x18]	; 02302B64
	ldr r0,[r5,#0x0]	; 02302B66
	str r1,[r0,#0x24]	; 02302B68
	b loc_02302B70	; 02302B6A
loc_02302B6C:
	mov r0,#0x0	; 02302B6C
	b loc_02302CDC	; 02302B6E
loc_02302B70:
	ldr r2,[r5,#0x0]	; 02302B70
	ldrh r0,[r2,#0x0]	; 02302B72
	cmp r0,#0xa	; 02302B74
	beq loc_02302B7C	; 02302B76
	cmp r0,#0x8	; 02302B78
	bne loc_02302C1A	; 02302B7A
loc_02302B7C:
	add r0,sp,#0xc	; 02302B7C
	ldr r1,[pool_02302CEC]	; 02302B7E
	add r1,r2,r1	; 02302B80
	bl loc_023007BC	; 02302B82
	add r0,sp,#0x18	; 02302B86
	add r1,sp,#0xc	; 02302B88
	mov r2,#0x3	; 02302B8A
	bl loc_02301D00	; 02302B8C
	ldrh r1,[r0,#0x4]	; 02302B90
	cmp r1,#0x0	; 02302B92
	beq loc_02302BA0	; 02302B94
	mov r0,#0x5	; 02302B96
	bl loc_02302B08	; 02302B98
	mov r0,#0x0	; 02302B9C
	b loc_02302CDC	; 02302B9E
loc_02302BA0:
	add r0,sp,#0x18	; 02302BA0
	mov r1,#0x1	; 02302BA2
	bl loc_02301EE4	; 02302BA4
	ldrh r1,[r0,#0x4]	; 02302BA8
	cmp r1,#0x0	; 02302BAA
	beq loc_02302BB8	; 02302BAC
	mov r0,#0x0	; 02302BAE
	bl loc_02302B08	; 02302BB0
	mov r0,#0x0	; 02302BB4
	b loc_02302CDC	; 02302BB6
loc_02302BB8:
	mov r1,#0x3	; 02302BB8
	ldr r0,[r5,#0x0]	; 02302BBA
	strh r1,[r0,#0x0]	; 02302BBC
	add r0,sp,#0x18	; 02302BBE
	bl loc_0230195C	; 02302BC0
	ldrh r1,[r0,#0x4]	; 02302BC4
	cmp r1,#0x0	; 02302BC6
	beq loc_02302BD4	; 02302BC8
	ldr r0,[pool_02302CF0]	; 02302BCA
	bl loc_02302B08	; 02302BCC
	mov r0,#0x0	; 02302BD0
	b loc_02302CDC	; 02302BD2
loc_02302BD4:
	mov r1,#0x2	; 02302BD4
	ldr r0,[r5,#0x0]	; 02302BD6
	strh r1,[r0,#0x0]	; 02302BD8
	mov r1,#0x0	; 02302BDA
	ldr r0,[r5,#0x0]	; 02302BDC
	str r1,[r0,#0x10]	; 02302BDE
	ldr r0,[r5,#0x0]	; 02302BE0
	str r1,[r0,#0x18]	; 02302BE2
	ldr r0,[r5,#0x0]	; 02302BE4
	str r1,[r0,#0x14]	; 02302BE6
	cmp r7,#0x1	; 02302BE8
	bne loc_02302CDA	; 02302BEA
	bl loc_02300404	; 02302BEC
	mov r1,#0xc	; 02302BF0
	strh r1,[r0,#0x0]	; 02302BF2
	mov r1,#0x0	; 02302BF4
	strh r1,[r0,#0x2]	; 02302BF6
	mov r2,#0x9	; 02302BF8
	strh r2,[r0,#0x8]	; 02302BFA
	mov r2,#0x24	; 02302BFC
	strh r2,[r0,#0xc]	; 02302BFE
	ldr r3,[r5,#0x0]	; 02302C00
	ldr r2,[pool_02302CF4]	; 02302C02
	ldrh r2,[r3,r2]	; 02302C04
	strh r2,[r0,#0xa]	; 02302C06
	ldr r3,[r5,#0x0]	; 02302C08
	ldr r2,[pool_02302CF8]	; 02302C0A
	strh r1,[r3,r2]	; 02302C0C
	ldr r3,[r5,#0x0]	; 02302C0E
	ldr r2,[pool_02302CFC]	; 02302C10
	strh r1,[r3,r2]	; 02302C12
	bl loc_02300414	; 02302C14
	b loc_02302CDA	; 02302C18
loc_02302C1A:
	mov r4,#0x1	; 02302C1A
	str r4,[sp,#0x8]	; 02302C1C
	b loc_02302CD6	; 02302C1E
loc_02302C20:
	ldr r1,[r5,#0x0]	; 02302C20
	ldr r6,[sp,#0x8]	; 02302C22
	lsl r6,r4	; 02302C24
	ldr r0,[pool_02302D00]	; 02302C26
	ldrh r2,[r1,r0]	; 02302C28
	ldr r0,[sp,#0x0]	; 02302C2A
	and r2,r0	; 02302C2C
	add r0,r6,#0x0	; 02302C2E
	and r0,r2	; 02302C30
	cmp r0,#0x0	; 02302C32
	beq loc_02302CD4	; 02302C34
	lsl r0,r4,#0x10	; 02302C36
	lsr r0,r0,#0x10	; 02302C38
	str r0,[sp,#0x4]	; 02302C3A
	add r0,sp,#0x10	; 02302C3C
	add r0,#0x2	; 02302C3E
	ldr r2,[pool_02302D04]	; 02302C40
	add r2,r1,r2	; 02302C42
	sub r3,r4,#0x1	; 02302C44
	mov r1,#0x6	; 02302C46
	mul r3,r1	; 02302C48
	add r1,r2,r3	; 02302C4A
	bl loc_023007BC	; 02302C4C
	add r0,sp,#0x18	; 02302C50
	add r1,sp,#0x10	; 02302C52
	add r1,#0x2	; 02302C54
	mov r2,#0x3	; 02302C56
	bl loc_02301D00	; 02302C58
	ldrh r1,[r0,#0x4]	; 02302C5C
	cmp r1,#0x0	; 02302C5E
	beq loc_02302C6C	; 02302C60
	mov r0,#0x5	; 02302C62
	bl loc_02302B08	; 02302C64
	mov r0,#0x0	; 02302C68
	b loc_02302CDC	; 02302C6A
loc_02302C6C:
	ldr r1,[r5,#0x0]	; 02302C6C
	ldr r0,[pool_02302D00]	; 02302C6E
	add r1,r1,r0	; 02302C70
	ldrh r0,[r1,#0x0]	; 02302C72
	bic r0,r6	; 02302C74
	strh r0,[r1,#0x0]	; 02302C76
	ldr r1,[r5,#0x0]	; 02302C78
	add r1,#0x86	; 02302C7A
	ldrh r0,[r1,#0x0]	; 02302C7C
	bic r0,r6	; 02302C7E
	strh r0,[r1,#0x0]	; 02302C80
	add r0,r4,#0x0	; 02302C82
	mov r1,#0x6	; 02302C84
	mul r0,r1	; 02302C86
	ldr r1,[r5,#0x0]	; 02302C88
	add r3,r1,r0	; 02302C8A
	mov r2,#0x0	; 02302C8C
	ldr r1,[pool_02302D08]	; 02302C8E
	strh r2,[r3,r1]	; 02302C90
	ldr r1,[r5,#0x0]	; 02302C92
	add r3,r1,r0	; 02302C94
	ldr r1,[pool_02302D0C]	; 02302C96
	strh r2,[r3,r1]	; 02302C98
	ldr r1,[r5,#0x0]	; 02302C9A
	add r2,r1,r0	; 02302C9C
	mov r1,#0x0	; 02302C9E
	ldr r0,[pool_02302D10]	; 02302CA0
	strh r1,[r2,r0]	; 02302CA2
	cmp r7,#0x1	; 02302CA4
	bne loc_02302CD4	; 02302CA6
	bl loc_02300404	; 02302CA8
	add r6,r0,#0x0	; 02302CAC
	mov r0,#0x8	; 02302CAE
	strh r0,[r6,#0x0]	; 02302CB0
	mov r0,#0x0	; 02302CB2
	strh r0,[r6,#0x2]	; 02302CB4
	mov r0,#0x9	; 02302CB6
	strh r0,[r6,#0x8]	; 02302CB8
	mov r0,#0x24	; 02302CBA
	strh r0,[r6,#0x12]	; 02302CBC
	ldr r0,[sp,#0x4]	; 02302CBE
	strh r0,[r6,#0x10]	; 02302CC0
	add r0,r6,#0x0	; 02302CC2
	add r0,#0xa	; 02302CC4
	add r1,sp,#0x10	; 02302CC6
	add r1,#0x2	; 02302CC8
	bl loc_023007BC	; 02302CCA
	add r0,r6,#0x0	; 02302CCE
	bl loc_02300414	; 02302CD0
loc_02302CD4:
	add r4,r4,#0x1	; 02302CD4
loc_02302CD6:
	cmp r4,#0x10	; 02302CD6
	blt loc_02302C20	; 02302CD8
loc_02302CDA:
	mov r0,#0x1	; 02302CDA
loc_02302CDC:
	add sp,#0x1fc	; 02302CDC
	add sp,#0x20	; 02302CDE
	pop {r4,r5,r6,r7}	; 02302CE0
	pop {r3}	; 02302CE2
	bx r3	; 02302CE4
	.byte 0xC0, 0x46	; 02302CE8
pool_02302CE8:
loc_02302CE8:
	.word 0x00001518	; 02302CE8
pool_02302CEC:
loc_02302CEC:
	.word 0x00000186	; 02302CEC
pool_02302CF0:
loc_02302CF0:
	.word 0x00000302	; 02302CF0
pool_02302CF4:
loc_02302CF4:
	.word 0x00000184	; 02302CF4
pool_02302CF8:
loc_02302CF8:
	.word 0x0000018E	; 02302CF8
pool_02302CFC:
loc_02302CFC:
	.word 0x00000190	; 02302CFC
pool_02302D00:
loc_02302D00:
	.word 0x0000017E	; 02302D00
pool_02302D04:
loc_02302D04:
	.word 0x00000124	; 02302D04
pool_02302D08:
loc_02302D08:
	.word 0x0000011E	; 02302D08
pool_02302D0C:
loc_02302D0C:
	.word 0x00000120	; 02302D0C
pool_02302D10:
loc_02302D10:
	.word 0x00000122	; 02302D10

; ===== function loc_02302D14 =====
	push {lr}	; 02302D14
	sub sp,#0x4	; 02302D16
	mov r1,#0x0	; 02302D18
	bl loc_02302B2C	; 02302D1A
	cmp r0,#0x1	; 02302D1E
	bne loc_02302D34	; 02302D20
	bl loc_02300404	; 02302D22
	mov r1,#0xd	; 02302D26
	strh r1,[r0,#0x0]	; 02302D28
	mov r1,#0x0	; 02302D2A
	strh r1,[r0,#0x2]	; 02302D2C
	bl loc_02300414	; 02302D2E
	b loc_02302D44	; 02302D32
loc_02302D34:
	bl loc_02300404	; 02302D34
	mov r1,#0xd	; 02302D38
	strh r1,[r0,#0x0]	; 02302D3A
	mov r1,#0x1	; 02302D3C
	strh r1,[r0,#0x2]	; 02302D3E
	bl loc_02300414	; 02302D40
loc_02302D44:
	add sp,#0x4	; 02302D44
	pop {r3}	; 02302D46
	bx r3	; 02302D48
	.byte 0x00, 0x00	; 02302D4C
	push {r4,r5,r6,lr}	; 02302D4C
	add r5,r0,#0x0	; 02302D4E
	bl loc_023008B4	; 02302D50
	ldr r1,[pool_02302E58]	; 02302D54
	ldr r0,[r0,r1]	; 02302D56
	ldr r4,[r0,#0x0]	; 02302D58
	ldr r2,[r5,#0x4]	; 02302D5A
	ldr r0,[r5,#0x8]	; 02302D5C
	lsl r0,r0,#0x10	; 02302D5E
	lsr r1,r0,#0x10	; 02302D60
	mov r6,#0x1	; 02302D62
	str r6,[r4,#0x10]	; 02302D64
	mov r0,#0x0	; 02302D66
	str r0,[r4,#0xc]	; 02302D68
	add r3,r4,#0x0	; 02302D6A
	add r3,#0x84	; 02302D6C
	strh r0,[r3,#0x0]	; 02302D6E
	strh r0,[r4,#0x38]	; 02302D70
	strh r6,[r4,#0x3a]	; 02302D72
	add r3,r4,#0x0	; 02302D74
	add r3,#0x88	; 02302D76
	strh r0,[r3,#0x0]	; 02302D78
	add r3,r4,#0x0	; 02302D7A
	add r3,#0x9a	; 02302D7C
	strh r0,[r3,#0x0]	; 02302D7E
	mov r6,#0x3c	; 02302D80
	add r3,r4,#0x0	; 02302D82
	add r3,#0x9c	; 02302D84
	strh r6,[r3,#0x0]	; 02302D86
	ldr r3,[pool_02302E5C]	; 02302D88
	str r0,[r4,r3]	; 02302D8A
	add r3,r4,#0x0	; 02302D8C
	add r3,#0x8a	; 02302D8E
	strh r0,[r3,#0x0]	; 02302D90
	add r3,r4,#0x0	; 02302D92
	add r3,#0x8c	; 02302D94
	strh r0,[r3,#0x0]	; 02302D96
	add r3,r4,#0x0	; 02302D98
	add r3,#0x8e	; 02302D9A
	strh r0,[r3,#0x0]	; 02302D9C
	add r3,r4,#0x0	; 02302D9E
	add r3,#0x90	; 02302DA0
	strh r0,[r3,#0x0]	; 02302DA2
	str r2,[r4,#0x48]	; 02302DA4
	add r3,r4,#0x0	; 02302DA6
	add r3,#0x46	; 02302DA8
	strh r1,[r3,#0x0]	; 02302DAA
	add r1,r2,r1	; 02302DAC
	str r1,[r4,#0x4c]	; 02302DAE
	add r1,r4,#0x0	; 02302DB0
	add r1,#0x42	; 02302DB2
	strh r0,[r1,#0x0]	; 02302DB4
	ldr r0,[r5,#0xc]	; 02302DB6
	str r0,[r4,#0x50]	; 02302DB8
	ldr r1,[r5,#0x10]	; 02302DBA
	add r0,r4,#0x0	; 02302DBC
	add r0,#0x54	; 02302DBE
	strh r1,[r0,#0x0]	; 02302DC0
	ldr r0,[r5,#0x14]	; 02302DC2
	strh r0,[r4,#0x3c]	; 02302DC4
	ldrh r0,[r4,#0x3c]	; 02302DC6
	cmp r0,#0x0	; 02302DC8
	bne loc_02302DD0	; 02302DCA
	mov r0,#0x10	; 02302DCC
	strh r0,[r4,#0x3c]	; 02302DCE
loc_02302DD0:
	ldr r1,[r5,#0x18]	; 02302DD0
	add r0,r4,#0x0	; 02302DD2
	add r0,#0x98	; 02302DD4
	strh r1,[r0,#0x0]	; 02302DD6
	ldr r0,[r5,#0x1c]	; 02302DD8
	cmp r0,#0x0	; 02302DDA
	beq loc_02302DE2	; 02302DDC
	mov r1,#0x1	; 02302DDE
	b loc_02302DE4	; 02302DE0
loc_02302DE2:
	mov r1,#0x0	; 02302DE2
loc_02302DE4:
	add r0,r4,#0x0	; 02302DE4
	add r0,#0x92	; 02302DE6
	strh r1,[r0,#0x0]	; 02302DE8
	ldr r0,[r5,#0x20]	; 02302DEA
	cmp r0,#0x0	; 02302DEC
	beq loc_02302DF4	; 02302DEE
	mov r1,#0x1	; 02302DF0
	b loc_02302DF6	; 02302DF2
loc_02302DF4:
	mov r1,#0x0	; 02302DF4
loc_02302DF6:
	add r0,r4,#0x0	; 02302DF6
	add r0,#0x94	; 02302DF8
	strh r1,[r0,#0x0]	; 02302DFA
	ldr r0,[r5,#0x24]	; 02302DFC
	cmp r0,#0x0	; 02302DFE
	beq loc_02302E06	; 02302E00
	mov r1,#0x1	; 02302E02
	b loc_02302E08	; 02302E04
loc_02302E06:
	mov r1,#0x0	; 02302E06
loc_02302E08:
	add r0,r4,#0x0	; 02302E08
	add r0,#0x96	; 02302E0A
	strh r1,[r0,#0x0]	; 02302E0C
	mov r1,#0x0	; 02302E0E
	strh r1,[r4,#0x3e]	; 02302E10
	ldr r0,[r5,#0x28]	; 02302E12
	cmp r0,#0x0	; 02302E14
	beq loc_02302E1A	; 02302E16
	mov r1,#0x1	; 02302E18
loc_02302E1A:
	add r0,r4,#0x0	; 02302E1A
	add r0,#0xda	; 02302E1C
	strh r1,[r0,#0x0]	; 02302E1E
	bl loc_02304320	; 02302E20
	bl loc_023036E0	; 02302E24
	ldrh r0,[r4,#0x0]	; 02302E28
	cmp r0,#0x8	; 02302E2A
	bne loc_02302E34	; 02302E2C
	mov r0,#0xa	; 02302E2E
	strh r0,[r4,#0x0]	; 02302E30
	b loc_02302E3C	; 02302E32
loc_02302E34:
	cmp r0,#0x7	; 02302E34
	bne loc_02302E3C	; 02302E36
	mov r0,#0x9	; 02302E38
	strh r0,[r4,#0x0]	; 02302E3A
loc_02302E3C:
	bl loc_02300404	; 02302E3C
	mov r1,#0xe	; 02302E40
	strh r1,[r0,#0x0]	; 02302E42
	mov r1,#0x0	; 02302E44
	strh r1,[r0,#0x2]	; 02302E46
	mov r1,#0xa	; 02302E48
	strh r1,[r0,#0x4]	; 02302E4A
	bl loc_02300414	; 02302E4C
	pop {r4,r5,r6}	; 02302E50
	pop {r3}	; 02302E52
	bx r3	; 02302E54
	.byte 0xC0, 0x46	; 02302E58
pool_02302E58:
loc_02302E58:
	.word 0x00001518	; 02302E58
pool_02302E5C:
loc_02302E5C:
	.word 0x0000092C	; 02302E5C

; ===== function loc_02302E60 =====
	push {r4,r5,r6,r7,lr}	; 02302E60
	sub sp,#0x1c	; 02302E62
	add r4,r0,#0x0	; 02302E64
	bl loc_023008B4	; 02302E66
	ldr r1,[r4,#0x4]	; 02302E6A
	str r1,[sp,#0xc]	; 02302E6C
	ldr r1,[r4,#0x8]	; 02302E6E
	lsl r1,r1,#0x10	; 02302E70
	lsr r5,r1,#0x10	; 02302E72
	ldr r1,[r4,#0xc]	; 02302E74
	lsl r1,r1,#0x10	; 02302E76
	lsr r6,r1,#0x10	; 02302E78
	ldr r1,[r4,#0x10]	; 02302E7A
	lsl r1,r1,#0x10	; 02302E7C
	lsr r1,r1,#0x10	; 02302E7E
	str r1,[sp,#0x10]	; 02302E80
	ldr r1,[r4,#0x14]	; 02302E82
	lsl r1,r1,#0x10	; 02302E84
	lsr r1,r1,#0x10	; 02302E86
	ldr r7,[r4,#0x18]	; 02302E88
	ldr r4,[r4,#0x1c]	; 02302E8A
	ldr r2,[pool_02302EE4]	; 02302E8C
	ldr r0,[r0,r2]	; 02302E8E
	ldr r2,[r0,#0x0]	; 02302E90
	ldr r0,[pool_02302EE8]	; 02302E92
	ldrh r0,[r2,r0]	; 02302E94
	cmp r0,#0x0	; 02302E96
	beq loc_02302E9C	; 02302E98
	mov r6,#0x1	; 02302E9A
loc_02302E9C:
	str r5,[sp,#0x0]	; 02302E9C
	str r7,[sp,#0x4]	; 02302E9E
	str r4,[sp,#0x8]	; 02302EA0
	add r0,r1,#0x0	; 02302EA2
	ldr r1,[sp,#0x10]	; 02302EA4
	add r2,r6,#0x0	; 02302EA6
	ldr r3,[sp,#0xc]	; 02302EA8
	bl loc_02303D10	; 02302EAA
	str r0,[sp,#0x14]	; 02302EAE
	cmp r0,#0x2	; 02302EB0
	beq loc_02302EDC	; 02302EB2
	bl loc_02300404	; 02302EB4
	mov r1,#0x81	; 02302EB8
	strh r1,[r0,#0x0]	; 02302EBA
	ldr r1,[sp,#0x14]	; 02302EBC
	strh r1,[r0,#0x2]	; 02302EBE
	mov r1,#0x14	; 02302EC0
	strh r1,[r0,#0x8]	; 02302EC2
	ldr r1,[sp,#0x10]	; 02302EC4
	strh r1,[r0,#0xa]	; 02302EC6
	strh r6,[r0,#0xc]	; 02302EC8
	strh r5,[r0,#0xe]	; 02302ECA
	ldr r1,[sp,#0xc]	; 02302ECC
	str r1,[r0,#0x10]	; 02302ECE
	str r7,[r0,#0x14]	; 02302ED0
	str r4,[r0,#0x18]	; 02302ED2
	ldr r1,[pool_02302EEC]	; 02302ED4
	strh r1,[r0,#0x1c]	; 02302ED6
	bl loc_02300414	; 02302ED8
loc_02302EDC:
	add sp,#0x1c	; 02302EDC
	pop {r4,r5,r6,r7}	; 02302EDE
	pop {r3}	; 02302EE0
	bx r3	; 02302EE2
pool_02302EE4:
loc_02302EE4:
	.word 0x00001518	; 02302EE4
pool_02302EE8:
loc_02302EE8:
	.word 0x00000184	; 02302EE8
pool_02302EEC:
loc_02302EEC:
	.word 0x0000FFFF	; 02302EEC

; ===== function loc_02302EF0 =====
	push {lr}	; 02302EF0
	sub sp,#0x4	; 02302EF2
	bl loc_023008B4	; 02302EF4
	ldr r1,[pool_02302F2C]	; 02302EF8
	ldr r0,[r0,r1]	; 02302EFA
	ldr r1,[r0,#0x0]	; 02302EFC
	mov r0,#0x0	; 02302EFE
	str r0,[r1,#0x10]	; 02302F00
	ldrh r0,[r1,#0x0]	; 02302F02
	cmp r0,#0xa	; 02302F04
	bne loc_02302F0E	; 02302F06
	mov r0,#0x8	; 02302F08
	strh r0,[r1,#0x0]	; 02302F0A
	b loc_02302F16	; 02302F0C
loc_02302F0E:
	cmp r0,#0x9	; 02302F0E
	bne loc_02302F16	; 02302F10
	mov r0,#0x7	; 02302F12
	strh r0,[r1,#0x0]	; 02302F14
loc_02302F16:
	bl loc_02300404	; 02302F16
	mov r1,#0x10	; 02302F1A
	strh r1,[r0,#0x0]	; 02302F1C
	mov r1,#0x0	; 02302F1E
	strh r1,[r0,#0x2]	; 02302F20
	bl loc_02300414	; 02302F22
	add sp,#0x4	; 02302F26
	pop {r3}	; 02302F28
	bx r3	; 02302F2A
pool_02302F2C:
loc_02302F2C:
	.word 0x00001518	; 02302F2C

; ===== function loc_02302F30 =====
	push {r4,r5,lr}	; 02302F30
	sub sp,#0x1fc	; 02302F32
	sub sp,#0x88	; 02302F34
	add r5,r0,#0x0	; 02302F36
	bl loc_023008B4	; 02302F38
	ldr r1,[pool_02303014]	; 02302F3C
	ldr r0,[r0,r1]	; 02302F3E
	ldr r4,[r0,#0x0]	; 02302F40
	ldr r1,[r5,#0x4]	; 02302F42
	add r0,r4,#0x0	; 02302F44
	add r0,#0xe4	; 02302F46
	str r1,[r0,#0x0]	; 02302F48
	ldr r1,[r5,#0x8]	; 02302F4A
	add r0,r4,#0x0	; 02302F4C
	add r0,#0xe8	; 02302F4E
	strh r1,[r0,#0x0]	; 02302F50
	ldr r1,[r5,#0xc]	; 02302F52
	add r0,r4,#0x0	; 02302F54
	add r0,#0xea	; 02302F56
	strh r1,[r0,#0x0]	; 02302F58
	ldr r1,[r5,#0x10]	; 02302F5A
	add r0,r4,#0x0	; 02302F5C
	add r0,#0xec	; 02302F5E
	strh r1,[r0,#0x0]	; 02302F60
	ldr r1,[r5,#0x14]	; 02302F62
	add r0,r4,#0x0	; 02302F64
	add r0,#0xee	; 02302F66
	strh r1,[r0,#0x0]	; 02302F68
	ldr r0,[r5,#0x18]	; 02302F6A
	lsl r0,r0,#0x18	; 02302F6C
	lsr r0,r0,#0x18	; 02302F6E
	mov r2,#0x1	; 02302F70
	add r1,r0,#0x0	; 02302F72
	and r1,r2	; 02302F74
	cmp r1,#0x0	; 02302F76
	bne loc_02302F7C	; 02302F78
	mov r2,#0x0	; 02302F7A
loc_02302F7C:
	add r1,r4,#0x0	; 02302F7C
	add r1,#0xf0	; 02302F7E
	strh r2,[r1,#0x0]	; 02302F80
	mov r1,#0x2	; 02302F82
	add r2,r0,#0x0	; 02302F84
	and r2,r1	; 02302F86
	cmp r2,#0x0	; 02302F88
	beq loc_02302F90	; 02302F8A
	mov r2,#0x1	; 02302F8C
	b loc_02302F92	; 02302F8E
loc_02302F90:
	mov r2,#0x0	; 02302F90
loc_02302F92:
	add r1,r4,#0x0	; 02302F92
	add r1,#0xf4	; 02302F94
	strh r2,[r1,#0x0]	; 02302F96
	mov r1,#0x4	; 02302F98
	add r2,r0,#0x0	; 02302F9A
	and r2,r1	; 02302F9C
	cmp r2,#0x0	; 02302F9E
	beq loc_02302FA6	; 02302FA0
	mov r2,#0x1	; 02302FA2
	b loc_02302FA8	; 02302FA4
loc_02302FA6:
	mov r2,#0x0	; 02302FA6
loc_02302FA8:
	add r1,r4,#0x0	; 02302FA8
	add r1,#0xf6	; 02302FAA
	strh r2,[r1,#0x0]	; 02302FAC
	mov r1,#0x8	; 02302FAE
	and r0,r1	; 02302FB0
	cmp r0,#0x0	; 02302FB2
	beq loc_02302FBA	; 02302FB4
	mov r1,#0x1	; 02302FB6
	b loc_02302FBC	; 02302FB8
loc_02302FBA:
	mov r1,#0x0	; 02302FBA
loc_02302FBC:
	add r0,r4,#0x0	; 02302FBC
	add r0,#0xf8	; 02302FBE
	strh r1,[r0,#0x0]	; 02302FC0
	add r0,sp,#0x200	; 02302FC2
	add r1,r4,#0x0	; 02302FC4
	add r1,#0xe4	; 02302FC6
	bl loc_023006DC	; 02302FC8
	add r0,sp,#0x0	; 02302FCC
	add r4,#0xe8	; 02302FCE
	ldrh r1,[r4,#0x0]	; 02302FD0
	add r1,#0x10	; 02302FD2
	lsl r1,r1,#0x10	; 02302FD4
	lsr r1,r1,#0x10	; 02302FD6
	add r2,sp,#0x200	; 02302FD8
	bl loc_023019AC	; 02302FDA
	add r4,r0,#0x0	; 02302FDE
	bl loc_02300404	; 02302FE0
	mov r1,#0x18	; 02302FE4
	strh r1,[r0,#0x0]	; 02302FE6
	ldrh r1,[r4,#0x4]	; 02302FE8
	cmp r1,#0x0	; 02302FEA
	bne loc_02302FF2	; 02302FEC
	mov r1,#0x0	; 02302FEE
	b loc_02302FF4	; 02302FF0
loc_02302FF2:
	mov r1,#0x1	; 02302FF2
loc_02302FF4:
	strh r1,[r0,#0x2]	; 02302FF4
	ldrh r1,[r4,#0x4]	; 02302FF6
	cmp r1,#0x0	; 02302FF8
	beq loc_02303004	; 02302FFA
	ldr r1,[pool_02303018]	; 02302FFC
	strh r1,[r0,#0x4]	; 02302FFE
	ldrh r1,[r4,#0x4]	; 02303000
	strh r1,[r0,#0x6]	; 02303002
loc_02303004:
	bl loc_02300414	; 02303004
	add sp,#0x1fc	; 02303008
	add sp,#0x88	; 0230300A
	pop {r4,r5}	; 0230300C
	pop {r3}	; 0230300E
	bx r3	; 02303010
	.byte 0xC0, 0x46	; 02303014
pool_02303014:
loc_02303014:
	.word 0x00001518	; 02303014
pool_02303018:
loc_02303018:
	.word 0x00000245	; 02303018

; ===== function loc_0230301C =====
loc_0230301C:
	push {r4,r5,lr}	; 0230301C
	sub sp,#0x4	; 0230301E
	add r5,r0,#0x0	; 02303020
	add r4,r1,#0x0	; 02303022
	bl loc_02300404	; 02303024
	mov r1,#0x19	; 02303028
	strh r1,[r0,#0x0]	; 0230302A
	mov r1,#0x1	; 0230302C
	strh r1,[r0,#0x2]	; 0230302E
	strh r5,[r0,#0x4]	; 02303030
	strh r4,[r0,#0x6]	; 02303032
	bl loc_02300414	; 02303034
	add sp,#0x4	; 02303038
	pop {r4,r5}	; 0230303A
	pop {r3}	; 0230303C
	bx r3	; 0230303E

; ===== function loc_02303040 =====
	push {r4,lr}	; 02303040
	sub sp,#0x1fc	; 02303042
	sub sp,#0x4	; 02303044
	add r4,r0,#0x0	; 02303046
	bl loc_023008B4	; 02303048
	add r0,sp,#0x0	; 0230304C
	ldr r1,[r4,#0x4]	; 0230304E
	lsl r1,r1,#0x10	; 02303050
	lsr r1,r1,#0x10	; 02303052
	bl loc_02301A20	; 02303054
	ldrh r1,[r0,#0x4]	; 02303058
	cmp r1,#0x0	; 0230305A
	beq loc_02303066	; 0230305C
	ldr r0,[pool_02303080]	; 0230305E
	bl loc_0230301C	; 02303060
	b loc_02303076	; 02303064
loc_02303066:
	bl loc_02300404	; 02303066
	mov r1,#0x19	; 0230306A
	strh r1,[r0,#0x0]	; 0230306C
	mov r1,#0x0	; 0230306E
	strh r1,[r0,#0x2]	; 02303070
	bl loc_02300414	; 02303072
loc_02303076:
	add sp,#0x1fc	; 02303076
	add sp,#0x4	; 02303078
	pop {r4}	; 0230307A
	pop {r3}	; 0230307C
	bx r3	; 0230307E
pool_02303080:
loc_02303080:
	.word 0x00000215	; 02303080

; ===== function loc_02303084 =====
loc_02303084:
	push {r4,r5,lr}	; 02303084
	sub sp,#0x4	; 02303086
	add r5,r0,#0x0	; 02303088
	add r4,r1,#0x0	; 0230308A
	bl loc_02300404	; 0230308C
	mov r1,#0x7	; 02303090
	strh r1,[r0,#0x0]	; 02303092
	mov r1,#0x1	; 02303094
	strh r1,[r0,#0x2]	; 02303096
	strh r5,[r0,#0x4]	; 02303098
	strh r4,[r0,#0x6]	; 0230309A
	bl loc_02300414	; 0230309C
	add sp,#0x4	; 023030A0
	pop {r4,r5}	; 023030A2
	pop {r3}	; 023030A4
	bx r3	; 023030A6

; ===== function loc_023030A8 =====
	push {r4,lr}	; 023030A8
	sub sp,#0x1fc	; 023030AA
	sub sp,#0x4	; 023030AC
	add r4,r0,#0x0	; 023030AE
	bl loc_023008B4	; 023030B0
	add r0,sp,#0x0	; 023030B4
	ldr r1,[r4,#0x4]	; 023030B6
	lsl r1,r1,#0x10	; 023030B8
	lsr r1,r1,#0x10	; 023030BA
	ldr r2,[r4,#0x8]	; 023030BC
	lsl r2,r2,#0x10	; 023030BE
	lsr r2,r2,#0x10	; 023030C0
	ldr r3,[r4,#0xc]	; 023030C2
	lsl r3,r3,#0x10	; 023030C4
	lsr r3,r3,#0x10	; 023030C6
	bl loc_02301A90	; 023030C8
	ldrh r1,[r0,#0x4]	; 023030CC
	cmp r1,#0x0	; 023030CE
	beq loc_023030DA	; 023030D0
	ldr r0,[pool_023030F4]	; 023030D2
	bl loc_02303084	; 023030D4
	b loc_023030EA	; 023030D8
loc_023030DA:
	bl loc_02300404	; 023030DA
	mov r1,#0x1d	; 023030DE
	strh r1,[r0,#0x0]	; 023030E0
	mov r1,#0x0	; 023030E2
	strh r1,[r0,#0x2]	; 023030E4
	bl loc_02300414	; 023030E6
loc_023030EA:
	add sp,#0x1fc	; 023030EA
	add sp,#0x4	; 023030EC
	pop {r4}	; 023030EE
	pop {r3}	; 023030F0
	bx r3	; 023030F2
pool_023030F4:
loc_023030F4:
	.word 0x00000211	; 023030F4

; ===== function loc_023030F8 =====
loc_023030F8:
	push {r4,r5,lr}	; 023030F8
	sub sp,#0x4	; 023030FA
	add r5,r0,#0x0	; 023030FC
	add r4,r1,#0x0	; 023030FE
	bl loc_02300404	; 02303100
	mov r1,#0x1e	; 02303104
	strh r1,[r0,#0x0]	; 02303106
	mov r1,#0x1	; 02303108
	strh r1,[r0,#0x2]	; 0230310A
	strh r5,[r0,#0x4]	; 0230310C
	strh r4,[r0,#0x6]	; 0230310E
	bl loc_02300414	; 02303110
	add sp,#0x4	; 02303114
	pop {r4,r5}	; 02303116
	pop {r3}	; 02303118
	bx r3	; 0230311A

; ===== function loc_0230311C =====
	push {r4,r5,r6,r7,lr}	; 0230311C
	sub sp,#0x1fc	; 0230311E
	sub sp,#0x20	; 02303120
	add r5,r0,#0x0	; 02303122
	bl loc_023008B4	; 02303124
	ldr r1,[pool_0230320C]	; 02303128
	ldr r4,[r0,r1]	; 0230312A
	add r0,sp,#0x18	; 0230312C
	bl loc_023018FC	; 0230312E
	ldrh r1,[r0,#0x4]	; 02303132
	cmp r1,#0x0	; 02303134
	beq loc_02303140	; 02303136
	ldr r0,[pool_02303210]	; 02303138
	bl loc_023030F8	; 0230313A
	b loc_02303202	; 0230313E
loc_02303140:
	ldrh r2,[r0,#0x6]	; 02303140
	mov r1,#0x2	; 02303142
	ldr r0,[r4,#0x0]	; 02303144
	add r0,#0xe2	; 02303146
	strh r1,[r0,#0x0]	; 02303148
	cmp r2,#0x10	; 0230314A
	bne loc_0230318E	; 0230314C
	mov r0,#0xa	; 0230314E
	add r1,sp,#0x18	; 02303150
	bl loc_0230056C	; 02303152
	cmp r0,#0x0	; 02303156
	beq loc_02303202	; 02303158
	add r0,sp,#0x18	; 0230315A
	bl loc_0230194C	; 0230315C
	ldrh r1,[r0,#0x4]	; 02303160
	cmp r1,#0x0	; 02303162
	beq loc_0230316E	; 02303164
	ldr r0,[pool_02303214]	; 02303166
	bl loc_023030F8	; 02303168
	b loc_02303202	; 0230316C
loc_0230316E:
	mov r1,#0x3	; 0230316E
	ldr r0,[r4,#0x0]	; 02303170
	strh r1,[r0,#0x0]	; 02303172
	add r0,sp,#0x18	; 02303174
	mov r1,#0x1	; 02303176
	mov r2,#0x0	; 02303178
	add r3,r1,#0x0	; 0230317A
	bl loc_02301EA8	; 0230317C
	ldrh r1,[r0,#0x4]	; 02303180
	cmp r1,#0x0	; 02303182
	beq loc_0230318E	; 02303184
	mov r0,#0x1	; 02303186
	bl loc_023030F8	; 02303188
	b loc_02303202	; 0230318C
loc_0230318E:
	ldrh r7,[r5,#0x2]	; 0230318E
	ldrh r0,[r5,#0x4]	; 02303190
	str r0,[sp,#0x4]	; 02303192
	ldrh r6,[r5,#0x6]	; 02303194
	ldrh r5,[r5,#0x8]	; 02303196
	add r0,sp,#0x8	; 02303198
	mov r1,#0x0	; 0230319A
	mov r2,#0x10	; 0230319C
	bl loc_0230321C	; 0230319E
	add r0,sp,#0x8	; 023031A2
	strb r6,[r0,#0x0]	; 023031A4
	add r0,sp,#0x8	; 023031A6
	str r0,[sp,#0x0]	; 023031A8
	add r0,sp,#0x18	; 023031AA
	add r1,r7,#0x0	; 023031AC
	ldr r2,[sp,#0x4]	; 023031AE
	add r3,r5,#0x0	; 023031B0
	bl loc_02301BA8	; 023031B2
	ldrh r1,[r0,#0x4]	; 023031B6
	cmp r1,#0x0	; 023031B8
	beq loc_023031C4	; 023031BA
	mov r0,#0xa	; 023031BC
	bl loc_023030F8	; 023031BE
	b loc_02303202	; 023031C2
loc_023031C4:
	ldrh r2,[r0,#0x8]	; 023031C4
	mov r0,#0xff	; 023031C6
	add r1,r2,#0x0	; 023031C8
	and r1,r0	; 023031CA
	lsl r0,r1,#0x10	; 023031CC
	lsr r5,r0,#0x10	; 023031CE
	lsl r0,r2,#0x8	; 023031D0
	lsr r6,r0,#0x10	; 023031D2
	add r0,sp,#0x18	; 023031D4
	bl loc_0230195C	; 023031D6
	ldrh r1,[r0,#0x4]	; 023031DA
	cmp r1,#0x0	; 023031DC
	beq loc_023031E8	; 023031DE
	ldr r0,[pool_02303218]	; 023031E0
	bl loc_023030F8	; 023031E2
	b loc_02303202	; 023031E6
loc_023031E8:
	mov r1,#0x2	; 023031E8
	ldr r0,[r4,#0x0]	; 023031EA
	strh r1,[r0,#0x0]	; 023031EC
	bl loc_02300404	; 023031EE
	mov r1,#0x1e	; 023031F2
	strh r1,[r0,#0x0]	; 023031F4
	mov r1,#0x0	; 023031F6
	strh r1,[r0,#0x2]	; 023031F8
	strh r5,[r0,#0x8]	; 023031FA
	strh r6,[r0,#0xa]	; 023031FC
	bl loc_02300414	; 023031FE
loc_02303202:
	add sp,#0x1fc	; 02303202
	add sp,#0x20	; 02303204
	pop {r4,r5,r6,r7}	; 02303206
	pop {r3}	; 02303208
	bx r3	; 0230320A
pool_0230320C:
loc_0230320C:
	.word 0x00001518	; 0230320C
pool_02303210:
loc_02303210:
	.word 0x00000308	; 02303210
pool_02303214:
loc_02303214:
	.word 0x00000303	; 02303214
pool_02303218:
loc_02303218:
	.word 0x00000302	; 02303218

; ===== function loc_0230321C =====
loc_0230321C:
	bx pc	; 0230321C
	.byte 0xC0, 0x46	; 02303220
.arm

; ===== function loc_02303220 =====
loc_02303220:
	ldr pc,[pool_02303224]	; 02303220
pool_02303224:
loc_02303224:
	.word loc_037FCEB0	; 02303224
.thumb

; ===== function loc_02303228 =====
loc_02303228:
	push {r4,r5,lr}	; 02303228
	sub sp,#0x4	; 0230322A
	add r5,r0,#0x0	; 0230322C
	add r4,r1,#0x0	; 0230322E
	bl loc_02300404	; 02303230
	mov r1,#0x1f	; 02303234
	strh r1,[r0,#0x0]	; 02303236
	mov r1,#0x1	; 02303238
	strh r1,[r0,#0x2]	; 0230323A
	strh r5,[r0,#0x4]	; 0230323C
	strh r4,[r0,#0x6]	; 0230323E
	bl loc_02300414	; 02303240
	add sp,#0x4	; 02303244
	pop {r4,r5}	; 02303246
	pop {r3}	; 02303248
	bx r3	; 0230324A

; ===== function loc_0230324C =====
	push {lr}	; 0230324C
	sub sp,#0x1fc	; 0230324E
	sub sp,#0x8	; 02303250
	bl loc_023008B4	; 02303252
	add r0,sp,#0x0	; 02303256
	bl loc_0230192C	; 02303258
	ldrh r1,[r0,#0x4]	; 0230325C
	cmp r1,#0x0	; 0230325E
	beq loc_0230326A	; 02303260
	ldr r0,[pool_02303284]	; 02303262
	bl loc_02303228	; 02303264
	b loc_0230327A	; 02303268
loc_0230326A:
	bl loc_02300404	; 0230326A
	mov r1,#0x1f	; 0230326E
	strh r1,[r0,#0x0]	; 02303270
	mov r1,#0x0	; 02303272
	strh r1,[r0,#0x2]	; 02303274
	bl loc_02300414	; 02303276
loc_0230327A:
	add sp,#0x1fc	; 0230327A
	add sp,#0x8	; 0230327C
	pop {r3}	; 0230327E
	bx r3	; 02303280
	.byte 0xC0, 0x46	; 02303284
pool_02303284:
loc_02303284:
	.word 0x00000305	; 02303284

; ===== function loc_02303288 =====
loc_02303288:
	push {r4,r5,lr}	; 02303288
	sub sp,#0x4	; 0230328A
	add r5,r0,#0x0	; 0230328C
	add r4,r1,#0x0	; 0230328E
	bl loc_02300404	; 02303290
	mov r1,#0x20	; 02303294
	strh r1,[r0,#0x0]	; 02303296
	mov r1,#0x1	; 02303298
	strh r1,[r0,#0x2]	; 0230329A
	strh r5,[r0,#0x4]	; 0230329C
	strh r4,[r0,#0x6]	; 0230329E
	bl loc_02300414	; 023032A0
	add sp,#0x4	; 023032A4
	pop {r4,r5}	; 023032A6
	pop {r3}	; 023032A8
	bx r3	; 023032AA

; ===== function loc_023032AC =====
	push {r4,r5,lr}	; 023032AC
	sub sp,#0x1fc	; 023032AE
	sub sp,#0x8	; 023032B0
	bl loc_023008B4	; 023032B2
	add r0,sp,#0x0	; 023032B6
	bl loc_0230190C	; 023032B8
	add r5,r0,#0x0	; 023032BC
	ldrh r1,[r5,#0x4]	; 023032BE
	cmp r1,#0x0	; 023032C0
	beq loc_023032CC	; 023032C2
	ldr r0,[pool_023032F8]	; 023032C4
	bl loc_02303288	; 023032C6
	b loc_023032EE	; 023032CA
loc_023032CC:
	bl loc_02300404	; 023032CC
	add r4,r0,#0x0	; 023032D0
	mov r0,#0x20	; 023032D2
	strh r0,[r4,#0x0]	; 023032D4
	mov r0,#0x0	; 023032D6
	strh r0,[r4,#0x2]	; 023032D8
	add r5,#0x8	; 023032DA
	add r0,r5,#0x0	; 023032DC
	add r1,r4,#0x0	; 023032DE
	add r1,#0x8	; 023032E0
	mov r2,#0xb4	; 023032E2
	bl loc_023032FC	; 023032E4
	add r0,r4,#0x0	; 023032E8
	bl loc_02300414	; 023032EA
loc_023032EE:
	add sp,#0x1fc	; 023032EE
	add sp,#0x8	; 023032F0
	pop {r4,r5}	; 023032F2
	pop {r3}	; 023032F4
	bx r3	; 023032F6
pool_023032F8:
loc_023032F8:
	.word 0x00000307	; 023032F8

; ===== function loc_023032FC =====
loc_023032FC:
	bx pc	; 023032FC
	.byte 0xC0, 0x46	; 02303300
.arm

; ===== function loc_02303300 =====
loc_02303300:
	ldr pc,[pool_02303304]	; 02303300
pool_02303304:
loc_02303304:
	.word P2_Entry_037FCE1C	; 02303304
.thumb

; ===== function loc_02303308 =====
loc_02303308:
	bx lr	; 02303308
	.byte 0x00, 0x00	; 0230330C

; ===== function loc_0230330C =====
loc_0230330C:
	push {r4,lr}	; 0230330C
	bl loc_023008B4	; 0230330E
	add r4,r0,#0x0	; 02303312
	mov r0,#0x1c	; 02303314
	ldr r1,[pool_02303350]	; 02303316
	str r0,[r1,#0x0]	; 02303318
	add r0,r4,#0x0	; 0230331A
	add r0,#0x64	; 0230331C
	mov r2,#0x0	; 0230331E
	bl loc_02300824	; 02303320
	cmp r0,#0x0	; 02303324
	bne loc_02303348	; 02303326
	ldr r0,[pool_02303354]	; 02303328
	ldr r0,[r4,r0]	; 0230332A
	cmp r0,#0x0	; 0230332C
	beq loc_02303348	; 0230332E
	bl loc_02300404	; 02303330
	mov r1,#0x80	; 02303334
	strh r1,[r0,#0x0]	; 02303336
	mov r1,#0x8	; 02303338
	strh r1,[r0,#0x2]	; 0230333A
	mov r1,#0x16	; 0230333C
	strh r1,[r0,#0x4]	; 0230333E
	mov r1,#0x1c	; 02303340
	strh r1,[r0,#0x6]	; 02303342
	bl loc_02300414	; 02303344
loc_02303348:
	pop {r4}	; 02303348
	pop {r3}	; 0230334A
	bx r3	; 0230334C
	.byte 0xC0, 0x46	; 02303350
pool_02303350:
loc_02303350:
	.word P4_BssStart + 0x2420	; 02303350
pool_02303354:
loc_02303354:
	.word 0x00001518	; 02303354

; ===== function loc_02303358 =====
loc_02303358:
	push {lr}	; 02303358
	sub sp,#0x4	; 0230335A
	bl loc_023008B4	; 0230335C
	ldr r1,[pool_02303384]	; 02303360
	ldr r0,[r0,r1]	; 02303362
	ldr r1,[r0,#0x0]	; 02303364
	ldr r1,[r1,#0x10]	; 02303366
	cmp r1,#0x1	; 02303368
	bne loc_0230337C	; 0230336A
	add r0,#0xd0	; 0230336C
	mov r1,#0xd3	; 0230336E
	ldr r2,[pool_02303388]	; 02303370
	add r3,r1,#0x0	; 02303372
	bl loc_0230338C	; 02303374
	bl loc_0230330C	; 02303378
loc_0230337C:
	add sp,#0x4	; 0230337C
	pop {r3}	; 0230337E
	bx r3	; 02303380
	.byte 0xC0, 0x46	; 02303384
pool_02303384:
loc_02303384:
	.word 0x00001518	; 02303384
pool_02303388:
loc_02303388:
	.word P4_Code_02303684 + 1	; 02303388

; ===== function loc_0230338C =====
loc_0230338C:
	bx pc	; 0230338C
	.byte 0xC0, 0x46	; 02303390
.arm

; ===== function loc_02303390 =====
loc_02303390:
	ldr r12,[pool_02303398]	; 02303390
	bx r12	; 02303394
pool_02303398:
loc_02303398:
	.word P2_Entry_037FCA24 + 1	; 02303398
.thumb

; ===== function loc_0230339C =====
loc_0230339C:
	push {r4,lr}	; 0230339C
	bl loc_023008B4	; 0230339E
	ldr r1,[pool_023033E8]	; 023033A2
	ldr r4,[r0,r1]	; 023033A4
	ldr r1,[r4,#0x0]	; 023033A6
	add r0,r1,#0x0	; 023033A8
	add r0,#0xd8	; 023033AA
	ldrh r0,[r0,#0x0]	; 023033AC
	cmp r0,#0x3c	; 023033AE
	bcc loc_023033C8	; 023033B0
	ldr r1,[pool_023033EC]	; 023033B2
	ldrh r0,[r1,#0x0]	; 023033B4
	cmp r0,#0xd3	; 023033B6
	bne loc_023033BE	; 023033B8
	mov r0,#0xd3	; 023033BA
	strh r0,[r1,#0x0]	; 023033BC
loc_023033BE:
	mov r1,#0x0	; 023033BE
	ldr r0,[r4,#0x0]	; 023033C0
	add r0,#0xd8	; 023033C2
	strh r1,[r0,#0x0]	; 023033C4
	b loc_023033D0	; 023033C6
loc_023033C8:
	add r1,#0xd8	; 023033C8
	ldrh r0,[r1,#0x0]	; 023033CA
	add r0,r0,#0x1	; 023033CC
	strh r0,[r1,#0x0]	; 023033CE
loc_023033D0:
	bl loc_02303644	; 023033D0
	add r4,#0xd0	; 023033D4
	add r0,r4,#0x0	; 023033D6
	ldr r1,[pool_023033F0]	; 023033D8
	ldr r2,[pool_023033F4]	; 023033DA
	add r3,r1,#0x0	; 023033DC
	bl loc_0230338C	; 023033DE
	pop {r4}	; 023033E2
	pop {r3}	; 023033E4
	bx r3	; 023033E6
pool_023033E8:
loc_023033E8:
	.word 0x00001518	; 023033E8
pool_023033EC:
loc_023033EC:
	.word REG_VCOUNT	; 023033EC
pool_023033F0:
loc_023033F0:
	.word 0x00000104	; 023033F0
pool_023033F4:
loc_023033F4:
	.word P4_Code_02303684 + 1	; 023033F4

; ===== function loc_023033F8 =====
loc_023033F8:
	push {lr}	; 023033F8
	sub sp,#0x4	; 023033FA
	bl loc_023008B4	; 023033FC
	ldr r1,[pool_02303424]	; 02303400
	ldr r0,[r0,r1]	; 02303402
	ldr r1,[r0,#0x0]	; 02303404
	ldr r1,[r1,#0x10]	; 02303406
	cmp r1,#0x1	; 02303408
	bne loc_0230341C	; 0230340A
	add r0,#0xd0	; 0230340C
	mov r1,#0xc8	; 0230340E
	ldr r2,[pool_02303428]	; 02303410
	add r3,r1,#0x0	; 02303412
	bl loc_0230338C	; 02303414
	bl loc_0230330C	; 02303418
loc_0230341C:
	add sp,#0x4	; 0230341C
	pop {r3}	; 0230341E
	bx r3	; 02303420
	.byte 0xC0, 0x46	; 02303424
pool_02303424:
loc_02303424:
	.word 0x00001518	; 02303424
pool_02303428:
loc_02303428:
	.word P4_Code_02303684 + 1	; 02303428

; ===== function loc_0230342C =====
loc_0230342C:
	push {r4,lr}	; 0230342C
	bl loc_023008B4	; 0230342E
	ldr r1,[pool_02303460]	; 02303432
	ldr r4,[r0,r1]	; 02303434
	ldr r2,[r4,#0x0]	; 02303436
	add r0,r2,#0x0	; 02303438
	add r0,#0xd4	; 0230343A
	ldr r1,[r0,#0x0]	; 0230343C
	ldr r0,[pool_02303464]	; 0230343E
	cmp r1,r0	; 02303440
	bls loc_02303448	; 02303442
	mov r0,#0x0	; 02303444
	str r0,[r2,#0x24]	; 02303446
loc_02303448:
	bl loc_023034DC	; 02303448
	add r4,#0xd0	; 0230344C
	add r0,r4,#0x0	; 0230344E
	mov r1,#0xf0	; 02303450
	ldr r2,[pool_02303468]	; 02303452
	add r3,r1,#0x0	; 02303454
	bl loc_0230338C	; 02303456
	pop {r4}	; 0230345A
	pop {r3}	; 0230345C
	bx r3	; 0230345E
pool_02303460:
loc_02303460:
	.word 0x00001518	; 02303460
pool_02303464:
loc_02303464:
	.word 0x00000190	; 02303464
pool_02303468:
loc_02303468:
	.word P4_Code_02303684 + 1	; 02303468

; ===== function loc_0230346C =====
loc_0230346C:
	push {r4,lr}	; 0230346C
	bl loc_023008B4	; 0230346E
	ldr r1,[pool_023034D0]	; 02303472
	ldr r4,[r0,r1]	; 02303474
	ldr r0,[pool_023034D4]	; 02303476
	ldrh r1,[r0,#0x0]	; 02303478
	ldr r0,[r4,#0x0]	; 0230347A
	add r0,#0xcc	; 0230347C
	str r1,[r0,#0x0]	; 0230347E
	ldr r2,[r4,#0x0]	; 02303480
	add r0,r2,#0x0	; 02303482
	add r0,#0xcc	; 02303484
	ldr r1,[r0,#0x0]	; 02303486
	add r0,r2,#0x0	; 02303488
	add r0,#0xd0	; 0230348A
	ldr r0,[r0,#0x0]	; 0230348C
	cmp r0,r1	; 0230348E
	beq loc_0230349A	; 02303490
	add r2,#0xd0	; 02303492
	str r1,[r2,#0x0]	; 02303494
	bl loc_02303588	; 02303496
loc_0230349A:
	ldr r1,[r4,#0x0]	; 0230349A
	add r0,r1,#0x0	; 0230349C
	add r0,#0xd4	; 0230349E
	ldr r0,[r0,#0x0]	; 023034A0
	cmp r0,#0x8c	; 023034A2
	bls loc_023034B6	; 023034A4
	add r4,#0xd0	; 023034A6
	add r0,r4,#0x0	; 023034A8
	mov r1,#0xd2	; 023034AA
	ldr r2,[pool_023034D8]	; 023034AC
	add r3,r1,#0x0	; 023034AE
	bl loc_0230338C	; 023034B0
	b loc_023034C8	; 023034B4
loc_023034B6:
	mov r0,#0x1	; 023034B6
	str r0,[r1,#0x24]	; 023034B8
	add r4,#0xd0	; 023034BA
	add r0,r4,#0x0	; 023034BC
	mov r1,#0xf0	; 023034BE
	ldr r2,[pool_023034D8]	; 023034C0
	add r3,r1,#0x0	; 023034C2
	bl loc_0230338C	; 023034C4
loc_023034C8:
	pop {r4}	; 023034C8
	pop {r3}	; 023034CA
	bx r3	; 023034CC
	.byte 0xC0, 0x46	; 023034D0
pool_023034D0:
loc_023034D0:
	.word 0x00001518	; 023034D0
pool_023034D4:
loc_023034D4:
	.word FirmwareWlAdjustedTimeSlot	; 023034D4
pool_023034D8:
loc_023034D8:
	.word P4_Code_02303684 + 1	; 023034D8

; ===== function loc_023034DC =====
loc_023034DC:
	push {lr}	; 023034DC
	sub sp,#0x4	; 023034DE
	bl loc_023008B4	; 023034E0
	ldr r1,[pool_0230356C]	; 023034E4
	ldr r1,[r0,r1]	; 023034E6
	ldr r0,[r1,#0x0]	; 023034E8
	add r0,#0xd4	; 023034EA
	ldr r0,[r0,#0x0]	; 023034EC
	cmp r0,#0x8c	; 023034EE
	bls loc_0230350A	; 023034F0
	ldr r2,[pool_02303570]	; 023034F2
	cmp r0,r2	; 023034F4
	bhi loc_0230350A	; 023034F6
	mov r2,#0xd2	; 023034F8
	ldr r0,[pool_02303574]	; 023034FA
	strh r2,[r0,#0x0]	; 023034FC
	ldr r1,[r1,#0x0]	; 023034FE
	add r1,#0xd4	; 02303500
	ldr r0,[r1,#0x0]	; 02303502
	sub r0,#0x41	; 02303504
	str r0,[r1,#0x0]	; 02303506
	b loc_02303564	; 02303508
loc_0230350A:
	ldr r2,[pool_02303570]	; 0230350A
	cmp r0,r2	; 0230350C
	bls loc_02303528	; 0230350E
	ldr r2,[pool_02303578]	; 02303510
	cmp r0,r2	; 02303512
	bhi loc_02303528	; 02303514
	mov r2,#0xd1	; 02303516
	ldr r0,[pool_02303574]	; 02303518
	strh r2,[r0,#0x0]	; 0230351A
	ldr r1,[r1,#0x0]	; 0230351C
	add r1,#0xd4	; 0230351E
	ldr r0,[r1,#0x0]	; 02303520
	sub r0,#0x82	; 02303522
	str r0,[r1,#0x0]	; 02303524
	b loc_02303564	; 02303526
loc_02303528:
	ldr r2,[pool_02303578]	; 02303528
	cmp r0,r2	; 0230352A
	bls loc_02303546	; 0230352C
	ldr r2,[pool_0230357C]	; 0230352E
	cmp r0,r2	; 02303530
	bhi loc_02303546	; 02303532
	mov r2,#0xd0	; 02303534
	ldr r0,[pool_02303574]	; 02303536
	strh r2,[r0,#0x0]	; 02303538
	ldr r1,[r1,#0x0]	; 0230353A
	add r1,#0xd4	; 0230353C
	ldr r0,[r1,#0x0]	; 0230353E
	sub r0,#0xc3	; 02303540
	str r0,[r1,#0x0]	; 02303542
	b loc_02303564	; 02303544
loc_02303546:
	ldr r2,[pool_0230357C]	; 02303546
	cmp r0,r2	; 02303548
	bls loc_02303564	; 0230354A
	ldr r2,[pool_02303580]	; 0230354C
	cmp r0,r2	; 0230354E
	bhi loc_02303564	; 02303550
	mov r2,#0xca	; 02303552
	ldr r0,[pool_02303574]	; 02303554
	strh r2,[r0,#0x0]	; 02303556
	ldr r2,[r1,#0x0]	; 02303558
	add r2,#0xd4	; 0230355A
	ldr r1,[r2,#0x0]	; 0230355C
	ldr r0,[pool_02303584]	; 0230355E
	sub r0,r1,r0	; 02303560
	str r0,[r2,#0x0]	; 02303562
loc_02303564:
	add sp,#0x4	; 02303564
	pop {r3}	; 02303566
	bx r3	; 02303568
	.byte 0xC0, 0x46	; 0230356C
pool_0230356C:
loc_0230356C:
	.word 0x00001518	; 0230356C
pool_02303570:
loc_02303570:
	.word 0x0000012C	; 02303570
pool_02303574:
loc_02303574:
	.word REG_VCOUNT	; 02303574
pool_02303578:
loc_02303578:
	.word 0x000001F4	; 02303578
pool_0230357C:
loc_0230357C:
	.word 0x000003E8	; 0230357C
pool_02303580:
loc_02303580:
	.word 0x000041A0	; 02303580
pool_02303584:
loc_02303584:
	.word 0x00000249	; 02303584

; ===== function loc_02303588 =====
loc_02303588:
	push {r4,r5,lr}	; 02303588
	sub sp,#0x4	; 0230358A
	bl loc_023008B4	; 0230358C
	ldr r1,[pool_02303624]	; 02303590
	ldr r2,[r0,r1]	; 02303592
	ldr r1,[r2,#0x0]	; 02303594
	add r1,#0xcc	; 02303596
	ldr r0,[r1,#0x0]	; 02303598
	lsl r0,r0,#0x6	; 0230359A
	str r0,[r1,#0x0]	; 0230359C
	ldr r3,[pool_02303628]	; 0230359E
	ldrh r1,[r3,#0x0]	; 023035A0
	ldr r0,[pool_0230362C]	; 023035A2
	ldrh r4,[r0,#0x0]	; 023035A4
	ldrh r3,[r3,#0x0]	; 023035A6
	cmp r1,r3	; 023035A8
	bls loc_023035AE	; 023035AA
	ldrh r4,[r0,#0x0]	; 023035AC
loc_023035AE:
	lsl r4,r4,#0x10	; 023035AE
	orr r4,r3	; 023035B0
	ldr r0,[pool_02303630]	; 023035B2
	ldrh r1,[r0,#0x0]	; 023035B4
	ldr r3,[pool_02303634]	; 023035B6
	and r4,r3	; 023035B8
	lsl r4,r4,#0x1	; 023035BA
	ldr r0,[pool_02303638]	; 023035BC
	sub r1,r0,r1	; 023035BE
	mov r0,#0x7f	; 023035C0
	mul r1,r0	; 023035C2
	add r0,r4,r1	; 023035C4
	lsr r1,r0,#0x1	; 023035C6
	and r1,r3	; 023035C8
	ldr r3,[r2,#0x0]	; 023035CA
	add r0,r3,#0x0	; 023035CC
	add r0,#0xcc	; 023035CE
	ldr r0,[r0,#0x0]	; 023035D0
	cmp r0,r1	; 023035D2
	bls loc_023035DE	; 023035D4
	mov r0,#0x0	; 023035D6
	add r3,#0xd4	; 023035D8
	str r0,[r3,#0x0]	; 023035DA
	b loc_0230361A	; 023035DC
loc_023035DE:
	mov r3,#0x1	; 023035DE
	ldr r4,[pool_0230363C]	; 023035E0
	b loc_02303616	; 023035E2
loc_023035E4:
	ldr r0,[r2,#0x0]	; 023035E4
	add r5,r0,#0x0	; 023035E6
	add r5,#0xcc	; 023035E8
	ldr r5,[r5,#0x0]	; 023035EA
	cmp r5,r1	; 023035EC
	bls loc_0230360C	; 023035EE
	sub r1,r5,r1	; 023035F0
	add r0,#0xd4	; 023035F2
	str r1,[r0,#0x0]	; 023035F4
	ldr r2,[r2,#0x0]	; 023035F6
	add r0,r2,#0x0	; 023035F8
	add r0,#0xd4	; 023035FA
	ldr r1,[r0,#0x0]	; 023035FC
	ldr r0,[pool_02303640]	; 023035FE
	cmp r1,r0	; 02303600
	bls loc_0230361A	; 02303602
	mov r0,#0x0	; 02303604
	add r2,#0xd4	; 02303606
	str r0,[r2,#0x0]	; 02303608
	b loc_0230361A	; 0230360A
loc_0230360C:
	add r0,#0xcc	; 0230360C
	ldr r5,[r0,#0x0]	; 0230360E
	add r5,r5,r4	; 02303610
	str r5,[r0,#0x0]	; 02303612
	add r3,r3,#0x1	; 02303614
loc_02303616:
	cmp r3,#0x1e	; 02303616
	blt loc_023035E4	; 02303618
loc_0230361A:
	add sp,#0x4	; 0230361A
	pop {r4,r5}	; 0230361C
	pop {r3}	; 0230361E
	bx r3	; 02303620
	.byte 0xC0, 0x46	; 02303624
pool_02303624:
loc_02303624:
	.word 0x00001518	; 02303624
pool_02303628:
loc_02303628:
	.word REG_WIFI_US_COUNT0	; 02303628
pool_0230362C:
loc_0230362C:
	.word REG_WIFI_US_COUNT1	; 0230362C
pool_02303630:
loc_02303630:
	.word REG_VCOUNT	; 02303630
pool_02303634:
loc_02303634:
	.word 0x003FFFC0	; 02303634
pool_02303638:
loc_02303638:
	.word 0x00000107	; 02303638
pool_0230363C:
loc_0230363C:
	.word 0x0000414B	; 0230363C
pool_02303640:
loc_02303640:
	.word 0x00004000	; 02303640

; ===== function loc_02303644 =====
loc_02303644:
; 对 Wi-Fi 微秒计数作 VCOUNT 校正，截为 16 位后写入共享槽。
; Adjust the Wi-Fi microsecond count using VCOUNT, storing its low 16-bit result.
.func P4_UpdateScanlineAdjustedWifiTime
	push {r4,lr}	; 02303644
	ldr r0,[pool_02303674]	; 02303646
	ldrh r0,[r0,#0x0]	; 02303648
	ldr r3,[pool_02303678]	; 0230364A
	ldrh r2,[r3,#0x0]	; 0230364C
	ldr r1,[pool_0230367C]	; 0230364E
	ldrh r4,[r1,#0x0]	; 02303650
	ldrh r3,[r3,#0x0]	; 02303652
	cmp r2,r3	; 02303654
	bls loc_0230365A	; 02303656
	ldrh r4,[r1,#0x0]	; 02303658
loc_0230365A:
	lsl r1,r4,#0x10	; 0230365A
	orr r1,r3	; 0230365C
	lsl r2,r1,#0x1	; 0230365E
	mov r1,#0x7f	; 02303660
	mul r0,r1	; 02303662
	sub r0,r2,r0	; 02303664
	lsr r1,r0,#0x7	; 02303666
	ldr r0,[pool_02303680]	; 02303668
	strh r1,[r0,#0x0]	; 0230366A
	pop {r4}	; 0230366C
	pop {r3}	; 0230366E
	bx r3	; 02303670
.endfunc
	.byte 0xC0, 0x46	; 02303674
pool_02303674:
loc_02303674:
	.word REG_VCOUNT	; 02303674
pool_02303678:
loc_02303678:
	.word REG_WIFI_US_COUNT0	; 02303678
pool_0230367C:
loc_0230367C:
	.word REG_WIFI_US_COUNT1	; 0230367C
pool_02303680:
loc_02303680:
	.word FirmwareWlAdjustedTimeSlot	; 02303680

; ===== function loc_02303684 =====
P4_Code_02303684:
	push {lr}	; 02303684
	sub sp,#0x4	; 02303686
	cmp r0,#0xd3	; 02303688
	bhi loc_023036A0	; 0230368A
	cmp r0,#0xd2	; 0230368C
	bcc loc_0230369A	; 0230368E
	cmp r0,#0xd2	; 02303690
	beq loc_023036BC	; 02303692
	cmp r0,#0xd3	; 02303694
	beq loc_023036C8	; 02303696
	b loc_023036D6	; 02303698
loc_0230369A:
	cmp r0,#0xc8	; 0230369A
	beq loc_023036B2	; 0230369C
	b loc_023036D6	; 0230369E
loc_023036A0:
	cmp r0,#0xf0	; 023036A0
	bhi loc_023036AA	; 023036A2
	cmp r0,#0xf0	; 023036A4
	beq loc_023036C2	; 023036A6
	b loc_023036D6	; 023036A8
loc_023036AA:
	ldr r1,[pool_023036DC]	; 023036AA
	cmp r0,r1	; 023036AC
	beq loc_023036D2	; 023036AE
	b loc_023036D6	; 023036B0
loc_023036B2:
	bl loc_02303308	; 023036B2
	bl loc_0230346C	; 023036B6
	b loc_023036D6	; 023036BA
loc_023036BC:
	bl loc_0230342C	; 023036BC
	b loc_023036D6	; 023036C0
loc_023036C2:
	bl loc_023033F8	; 023036C2
	b loc_023036D6	; 023036C6
loc_023036C8:
	bl loc_02303308	; 023036C8
	bl loc_0230339C	; 023036CC
	b loc_023036D6	; 023036D0
loc_023036D2:
	bl loc_02303358	; 023036D2
loc_023036D6:
	add sp,#0x4	; 023036D6
	pop {r3}	; 023036D8
	bx r3	; 023036DA
pool_023036DC:
loc_023036DC:
	.word 0x00000104	; 023036DC

; ===== function loc_023036E0 =====
loc_023036E0:
	push {r4,lr}	; 023036E0
	bl loc_023008B4	; 023036E2
	ldr r1,[pool_0230372C]	; 023036E6
	ldr r4,[r0,r1]	; 023036E8
	ldr r1,[r4,#0x0]	; 023036EA
	add r0,r1,#0x0	; 023036EC
	add r0,#0xe2	; 023036EE
	ldrh r0,[r0,#0x0]	; 023036F0
	cmp r0,#0x1	; 023036F2
	bne loc_02303706	; 023036F4
	add r4,#0xd0	; 023036F6
	add r0,r4,#0x0	; 023036F8
	mov r1,#0xd3	; 023036FA
	ldr r2,[pool_02303730]	; 023036FC
	add r3,r1,#0x0	; 023036FE
	bl loc_0230338C	; 02303700
	b loc_02303724	; 02303704
loc_02303706:
	cmp r0,#0x2	; 02303706
	bne loc_02303724	; 02303708
	mov r0,#0x0	; 0230370A
	str r0,[r1,#0x24]	; 0230370C
	add r0,r4,#0x0	; 0230370E
	add r0,#0xd0	; 02303710
	mov r1,#0xc8	; 02303712
	ldr r2,[pool_02303730]	; 02303714
	add r3,r1,#0x0	; 02303716
	bl loc_0230338C	; 02303718
	mov r1,#0x0	; 0230371C
	ldr r0,[r4,#0x0]	; 0230371E
	add r0,#0xd4	; 02303720
	str r1,[r0,#0x0]	; 02303722
loc_02303724:
	pop {r4}	; 02303724
	pop {r3}	; 02303726
	bx r3	; 02303728
	.byte 0xC0, 0x46	; 0230372C
pool_0230372C:
loc_0230372C:
	.word 0x00001518	; 0230372C
pool_02303730:
loc_02303730:
	.word P4_Code_02303684 + 1	; 02303730

; ===== function loc_02303734 =====
loc_02303734:
	push {lr}	; 02303734
	sub sp,#0x4	; 02303736
	bl loc_023008B4	; 02303738
	ldr r1,[pool_0230374C]	; 0230373C
	ldr r0,[r0,r1]	; 0230373E
	add r0,#0xd0	; 02303740
	bl loc_02303750	; 02303742
	add sp,#0x4	; 02303746
	pop {r3}	; 02303748
	bx r3	; 0230374A
pool_0230374C:
loc_0230374C:
	.word 0x00001518	; 0230374C

; ===== function loc_02303750 =====
loc_02303750:
	bx pc	; 02303750
	.byte 0xC0, 0x46	; 02303754
.arm

; ===== function loc_02303754 =====
loc_02303754:
	ldr r12,[pool_0230375C]	; 02303754
	bx r12	; 02303758
pool_0230375C:
loc_0230375C:
	.word loc_037FCB1C + 1	; 0230375C
.thumb

; ===== function loc_02303760 =====
	push {lr}	; 02303760
	sub sp,#0x4	; 02303762
	bl loc_023008B4	; 02303764
	ldr r1,[pool_02303780]	; 02303768
	ldr r0,[r0,r1]	; 0230376A
	ldr r0,[r0,#0x0]	; 0230376C
	ldrh r0,[r0,#0x0]	; 0230376E
	cmp r0,#0xa	; 02303770
	bne loc_02303778	; 02303772
	bl loc_023042B0	; 02303774
loc_02303778:
	add sp,#0x4	; 02303778
	pop {r3}	; 0230377A
	bx r3	; 0230377C
	.byte 0xC0, 0x46	; 02303780
pool_02303780:
loc_02303780:
	.word 0x00001518	; 02303780

; ===== function loc_02303784 =====
	push {r4,lr}	; 02303784
	add r4,r0,#0x0	; 02303786
	bl loc_023008B4	; 02303788
	ldr r1,[pool_023037A8]	; 0230378C
	ldr r0,[r0,r1]	; 0230378E
	ldr r0,[r0,#0x0]	; 02303790
	ldrh r0,[r0,#0x0]	; 02303792
	cmp r0,#0x9	; 02303794
	bne loc_023037A2	; 02303796
	ldr r0,[r4,#0x4]	; 02303798
	lsl r0,r0,#0x10	; 0230379A
	lsr r0,r0,#0x10	; 0230379C
	bl loc_0230418C	; 0230379E
loc_023037A2:
	pop {r4}	; 023037A2
	pop {r3}	; 023037A4
	bx r3	; 023037A6
pool_023037A8:
loc_023037A8:
	.word 0x00001518	; 023037A8

; ===== function loc_023037AC =====
	push {r4,r5,lr}	; 023037AC
	sub sp,#0x4	; 023037AE
	bl loc_023008B4	; 023037B0
	ldr r1,[pool_0230386C]	; 023037B4
	ldr r0,[r0,r1]	; 023037B6
	ldr r5,[r0,#0x0]	; 023037B8
	mov r1,#0x1	; 023037BA
	add r0,r5,#0x0	; 023037BC
	add r0,#0x88	; 023037BE
	strh r1,[r0,#0x0]	; 023037C0
	ldrh r0,[r5,#0x0]	; 023037C2
	cmp r0,#0x9	; 023037C4
	bne loc_0230383A	; 023037C6
	bl loc_0230387C	; 023037C8
	ldrh r1,[r5,#0x3e]	; 023037CC
	cmp r1,#0x0	; 023037CE
	bne loc_023037D6	; 023037D0
	mov r1,#0x1	; 023037D2
	b loc_023037D8	; 023037D4
loc_023037D6:
	mov r1,#0x0	; 023037D6
loc_023037D8:
	add r4,r5,#0x0	; 023037D8
	add r4,#0x3e	; 023037DA
	ldrh r3,[r4,#0x0]	; 023037DC
	ldrh r2,[r5,#0x3c]	; 023037DE
	add r2,r3,r2	; 023037E0
	strh r2,[r4,#0x0]	; 023037E2
	ldrh r3,[r5,#0x3e]	; 023037E4
	ldr r2,[pool_02303870]	; 023037E6
	cmp r3,r2	; 023037E8
	bls loc_023037EE	; 023037EA
	strh r2,[r5,#0x3e]	; 023037EC
loc_023037EE:
	cmp r1,#0x0	; 023037EE
	beq loc_023037FC	; 023037F0
	ldrh r1,[r5,#0x3e]	; 023037F2
	cmp r1,#0x0	; 023037F4
	beq loc_023037FC	; 023037F6
	mov r4,#0x1	; 023037F8
	b loc_023037FE	; 023037FA
loc_023037FC:
	mov r4,#0x0	; 023037FC
loc_023037FE:
	bl loc_02303888	; 023037FE
	cmp r4,#0x0	; 02303802
	beq loc_0230380C	; 02303804
	ldr r0,[pool_02303874]	; 02303806
	bl loc_0230418C	; 02303808
loc_0230380C:
	add r0,r5,#0x0	; 0230380C
	add r0,#0x92	; 0230380E
	ldrh r0,[r0,#0x0]	; 02303810
	cmp r0,#0x1	; 02303812
	bne loc_02303864	; 02303814
	add r1,r5,#0x0	; 02303816
	add r1,#0x9c	; 02303818
	ldrh r0,[r1,#0x0]	; 0230381A
	sub r0,r0,#0x1	; 0230381C
	strh r0,[r1,#0x0]	; 0230381E
	add r0,r5,#0x0	; 02303820
	add r0,#0x9c	; 02303822
	ldrh r0,[r0,#0x0]	; 02303824
	cmp r0,#0x0	; 02303826
	bne loc_02303864	; 02303828
	mov r1,#0x1	; 0230382A
	add r0,r5,#0x0	; 0230382C
	add r0,#0x9a	; 0230382E
	strh r1,[r0,#0x0]	; 02303830
	mov r0,#0x3c	; 02303832
	add r5,#0x9c	; 02303834
	strh r0,[r5,#0x0]	; 02303836
	b loc_02303864	; 02303838
loc_0230383A:
	cmp r0,#0xa	; 0230383A
	bne loc_02303864	; 0230383C
	mov r4,#0x0	; 0230383E
	bl loc_02303894	; 02303840
	ldrh r1,[r5,#0x3a]	; 02303844
	cmp r1,#0x1	; 02303846
	bne loc_02303858	; 02303848
	ldr r1,[pool_02303878]	; 0230384A
	ldr r1,[r5,r1]	; 0230384C
	cmp r1,#0x1	; 0230384E
	beq loc_02303858	; 02303850
	mov r4,#0x1	; 02303852
	mov r1,#0x0	; 02303854
	strh r1,[r5,#0x3a]	; 02303856
loc_02303858:
	bl loc_023038A0	; 02303858
	cmp r4,#0x1	; 0230385C
	bne loc_02303864	; 0230385E
	bl loc_023042B0	; 02303860
loc_02303864:
	add sp,#0x4	; 02303864
	pop {r4,r5}	; 02303866
	pop {r3}	; 02303868
	bx r3	; 0230386A
pool_0230386C:
loc_0230386C:
	.word 0x00001518	; 0230386C
pool_02303870:
loc_02303870:
	.word 0x00000100	; 02303870
pool_02303874:
loc_02303874:
	.word 0x0000FFFF	; 02303874
pool_02303878:
loc_02303878:
	.word 0x0000092C	; 02303878

; ===== function loc_0230387C =====
loc_0230387C:
	bx pc	; 0230387C
	.byte 0xC0, 0x46	; 02303880
.arm

; ===== function loc_02303880 =====
loc_02303880:
	ldr pc,[pool_02303884]	; 02303880
pool_02303884:
loc_02303884:
	.word loc_037FCBF0	; 02303884
.thumb

; ===== function loc_02303888 =====
loc_02303888:
	bx pc	; 02303888
	.byte 0xC0, 0x46	; 0230388C
.arm

; ===== function loc_0230388C =====
loc_0230388C:
	ldr pc,[pool_02303890]	; 0230388C
pool_02303890:
loc_02303890:
	.word loc_037FCC04	; 02303890
.thumb

; ===== function loc_02303894 =====
loc_02303894:
	bx pc	; 02303894
	.byte 0xC0, 0x46	; 02303898
.arm

; ===== function loc_02303898 =====
loc_02303898:
	ldr pc,[pool_0230389C]	; 02303898
pool_0230389C:
loc_0230389C:
	.word loc_037FCBF0	; 0230389C
.thumb

; ===== function loc_023038A0 =====
loc_023038A0:
	bx pc	; 023038A0
	.byte 0xC0, 0x46	; 023038A4
.arm

; ===== function loc_023038A4 =====
loc_023038A4:
	ldr pc,[pool_023038A8]	; 023038A4
pool_023038A8:
loc_023038A8:
	.word loc_037FCC04	; 023038A8
.thumb

; ===== function loc_023038AC =====
loc_023038AC:
	push {r4,r5,r6,r7,lr}	; 023038AC
	sub sp,#0x4	; 023038AE
	add r3,r0,#0x0	; 023038B0
	add r0,r1,#0x0	; 023038B2
	add r6,r2,#0x0	; 023038B4
	mov r5,#0x0	; 023038B6
	add r4,r5,#0x0	; 023038B8
	mov r7,#0x1	; 023038BA
loc_023038BC:
	add r1,r7,#0x0	; 023038BC
	lsl r1,r4	; 023038BE
	add r2,r6,#0x0	; 023038C0
	and r2,r1	; 023038C2
	cmp r2,#0x0	; 023038C4
	beq loc_023038CE	; 023038C6
	add r1,r5,#0x1	; 023038C8
	lsl r1,r1,#0x10	; 023038CA
	lsr r5,r1,#0x10	; 023038CC
loc_023038CE:
	add r4,r4,#0x1	; 023038CE
	cmp r4,#0x10	; 023038D0
	blt loc_023038BC	; 023038D2
	add r3,#0x22	; 023038D4
	lsl r2,r3,#0x2	; 023038D6
	add r2,#0x60	; 023038D8
	mul r0,r5	; 023038DA
	ldr r1,[pool_02303928]	; 023038DC
	add r0,r0,r1	; 023038DE
	add r4,r2,r0	; 023038E0
	ldr r0,[pool_0230392C]	; 023038E2
	ldrh r1,[r0,#0x0]	; 023038E4
	ldr r0,[pool_02303930]	; 023038E6
	cmp r1,r0	; 023038E8
	bls loc_02303900	; 023038EA
	ldr r0,[pool_02303934]	; 023038EC
	sub r0,r0,r1	; 023038EE
	mov r1,#0x7f	; 023038F0
	mul r0,r1	; 023038F2
	mov r1,#0x14	; 023038F4
	bl loc_0230393C	; 023038F6
	lsl r0,r0,#0x10	; 023038FA
	lsr r0,r0,#0x10	; 023038FC
	b loc_02303912	; 023038FE
loc_02303900:
	ldr r0,[pool_02303938]	; 02303900
	sub r0,r0,r1	; 02303902
	mov r1,#0x7f	; 02303904
	mul r0,r1	; 02303906
	mov r1,#0x14	; 02303908
	bl loc_02303948	; 0230390A
	lsl r0,r0,#0x10	; 0230390E
	lsr r0,r0,#0x10	; 02303910
loc_02303912:
	mov r1,#0xa	; 02303912
	add r2,r0,#0x0	; 02303914
	mul r2,r1	; 02303916
	cmp r2,r4	; 02303918
	bcs loc_0230391E	; 0230391A
	mov r0,#0x0	; 0230391C
loc_0230391E:
	add sp,#0x4	; 0230391E
	pop {r4,r5,r6,r7}	; 02303920
	pop {r3}	; 02303922
	bx r3	; 02303924
	.byte 0xC0, 0x46	; 02303928
pool_02303928:
loc_02303928:
	.word 0x00000388	; 02303928
pool_0230392C:
loc_0230392C:
	.word REG_VCOUNT	; 0230392C
pool_02303930:
loc_02303930:
	.word 0x00000104	; 02303930
pool_02303934:
loc_02303934:
	.word 0x00000209	; 02303934
pool_02303938:
loc_02303938:
	.word 0x00000102	; 02303938

; ===== function loc_0230393C =====
loc_0230393C:
	bx pc	; 0230393C
	.byte 0xC0, 0x46	; 02303940
.arm

; ===== function loc_02303940 =====
loc_02303940:
	ldr pc,[pool_02303944]	; 02303940
pool_02303944:
loc_02303944:
	.word loc_03802514	; 02303944
.thumb

; ===== function loc_02303948 =====
loc_02303948:
	bx pc	; 02303948
	.byte 0xC0, 0x46	; 0230394C
.arm

; ===== function loc_0230394C =====
loc_0230394C:
	ldr pc,[pool_02303950]	; 0230394C
pool_02303950:
loc_02303950:
	.word loc_03802514	; 02303950
.thumb

; ===== function loc_02303954 =====
loc_02303954:
	push {r0,r1,r2,r3}	; 02303954
	push {r4,r5,r6,r7,lr}	; 02303956
	sub sp,#0x34	; 02303958
	str r0,[sp,#0x0]	; 0230395A
	str r2,[sp,#0x4]	; 0230395C
	add r5,r3,#0x0	; 0230395E
	ldr r0,[sp,#0x58]	; 02303960
	str r0,[sp,#0x58]	; 02303962
	bl loc_023008B4	; 02303964
	ldr r1,[pool_02303AB8]	; 02303968
	ldr r0,[r0,r1]	; 0230396A
	ldr r4,[r0,#0x0]	; 0230396C
	cmp r5,#0x0	; 0230396E
	bne loc_02303974	; 02303970
	b loc_02303AAE	; 02303972
loc_02303974:
	ldr r0,[pool_02303ABC]	; 02303974
	ldrh r0,[r4,r0]	; 02303976
	cmp r5,r0	; 02303978
	bls loc_0230397E	; 0230397A
	b loc_02303AAE	; 0230397C
loc_0230397E:
	ldr r0,[pool_02303AC0]	; 0230397E
	ldrh r1,[r4,r0]	; 02303980
	ldr r0,[sp,#0x0]	; 02303982
	cmp r0,r1	; 02303984
	bne loc_0230398A	; 02303986
	b loc_02303AAE	; 02303988
loc_0230398A:
	mov r0,#0x1	; 0230398A
	str r0,[sp,#0xc]	; 0230398C
	add r1,r5,#0x0	; 0230398E
	and r1,r0	; 02303990
	cmp r1,#0x0	; 02303992
	beq loc_02303998	; 02303994
	b loc_02303AAE	; 02303996
loc_02303998:
	ldr r0,[pool_02303AC4]	; 02303998
	add r1,r4,r0	; 0230399A
	ldr r0,[sp,#0x0]	; 0230399C
	lsl r0,r0,#0x4	; 0230399E
	add r0,r1,r0	; 023039A0
	str r0,[sp,#0x18]	; 023039A2
	ldr r0,[sp,#0xc]	; 023039A4
	str r0,[sp,#0x1c]	; 023039A6
	str r0,[sp,#0x20]	; 023039A8
	str r0,[sp,#0x24]	; 023039AA
	str r0,[sp,#0x28]	; 023039AC
	b loc_02303AAA	; 023039AE
loc_023039B0:
	ldr r6,[pool_02303AC8]	; 023039B0
	ldr r0,[sp,#0xc]	; 023039B2
	cmp r0,#0x1	; 023039B4
	bne loc_023039C0	; 023039B6
	mov r0,#0x0	; 023039B8
	str r0,[sp,#0xc]	; 023039BA
	add r1,sp,#0x4c	; 023039BC
	b loc_023039CA	; 023039BE
loc_023039C0:
	ldr r1,[sp,#0x4]	; 023039C0
	lsl r0,r1,#0	; 023039C2
	add r0,r0,#0x2	; 023039C4
	str r0,[sp,#0x4]	; 023039C6
	sub r5,r5,#0x2	; 023039C8
loc_023039CA:
	ldrh r2,[r1,#0x0]	; 023039CA
	add r1,r2,#0x0	; 023039CC
	mov r0,#0xff	; 023039CE
	and r1,r0	; 023039D0
	lsl r7,r1,#0x1	; 023039D2
	add r1,r2,#0x0	; 023039D4
	ldr r0,[pool_02303ACC]	; 023039D6
	and r1,r0	; 023039D8
	cmp r1,#0x0	; 023039DA
	beq loc_023039E4	; 023039DC
	ldr r0,[sp,#0x1c]	; 023039DE
	str r0,[sp,#0x8]	; 023039E0
	b loc_023039E8	; 023039E2
loc_023039E4:
	mov r0,#0x0	; 023039E4
	str r0,[sp,#0x8]	; 023039E6
loc_023039E8:
	add r1,r2,#0x0	; 023039E8
	ldr r0,[pool_02303AD0]	; 023039EA
	and r1,r0	; 023039EC
	cmp r1,#0x0	; 023039EE
	beq loc_023039F6	; 023039F0
	ldr r0,[sp,#0x20]	; 023039F2
	b loc_023039F8	; 023039F4
loc_023039F6:
	mov r0,#0x0	; 023039F6
loc_023039F8:
	ldr r1,[sp,#0x8]	; 023039F8
	cmp r1,#0x0	; 023039FA
	beq loc_02303A02	; 023039FC
	mov r3,#0x2	; 023039FE
	b loc_02303A04	; 02303A00
loc_02303A02:
	mov r3,#0x0	; 02303A02
loc_02303A04:
	cmp r0,#0x0	; 02303A04
	beq loc_02303A0C	; 02303A06
	mov r1,#0x2	; 02303A08
	b loc_02303A0E	; 02303A0A
loc_02303A0C:
	mov r1,#0x0	; 02303A0C
loc_02303A0E:
	add r1,r7,r1	; 02303A0E
	add r3,r1,r3	; 02303A10
	sub r5,r5,r3	; 02303A12
	cmp r5,#0x0	; 02303A14
	blt loc_02303AAE	; 02303A16
	ldr r1,[pool_02303AD4]	; 02303A18
	and r2,r1	; 02303A1A
	lsl r1,r2,#0x8	; 02303A1C
	lsr r1,r1,#0x10	; 02303A1E
	str r1,[sp,#0x14]	; 02303A20
	ldr r1,[sp,#0x4]	; 02303A22
	str r1,[sp,#0x10]	; 02303A24
	add r2,r1,r7	; 02303A26
	add r1,r1,r3	; 02303A28
	str r1,[sp,#0x4]	; 02303A2A
	cmp r0,#0x1	; 02303A2C
	bne loc_02303A62	; 02303A2E
	ldr r1,[sp,#0x14]	; 02303A30
	mov r0,#0x7	; 02303A32
	and r1,r0	; 02303A34
	lsl r1,r1,#0x1	; 02303A36
	ldr r0,[sp,#0x18]	; 02303A38
	add r3,r0,r1	; 02303A3A
	ldrh r6,[r2,#0x0]	; 02303A3C
	add r2,r2,#0x2	; 02303A3E
	ldrh r0,[r0,r1]	; 02303A40
	str r0,[sp,#0x30]	; 02303A42
	str r0,[sp,#0x2c]	; 02303A44
	ldr r1,[sp,#0x28]	; 02303A46
	and r0,r1	; 02303A48
	str r0,[sp,#0x2c]	; 02303A4A
	cmp r0,#0x0	; 02303A4C
	beq loc_02303A56	; 02303A4E
	lsl r0,r6,#0x1	; 02303A50
	strh r0,[r3,#0x0]	; 02303A52
	b loc_02303A62	; 02303A54
loc_02303A56:
	lsl r0,r6,#0x11	; 02303A56
	lsr r6,r0,#0x10	; 02303A58
	ldr r0,[sp,#0x30]	; 02303A5A
	cmp r0,r6	; 02303A5C
	beq loc_02303AAA	; 02303A5E
	strh r6,[r3,#0x0]	; 02303A60
loc_02303A62:
	ldr r0,[sp,#0x8]	; 02303A62
	cmp r0,#0x1	; 02303A64
	bne loc_02303A78	; 02303A66
	ldrh r0,[r2,#0x0]	; 02303A68
	ldr r1,[pool_02303AC0]	; 02303A6A
	ldrh r1,[r4,r1]	; 02303A6C
	ldr r2,[sp,#0x24]	; 02303A6E
	lsl r2,r1	; 02303A70
	and r0,r2	; 02303A72
	cmp r0,#0x0	; 02303A74
	beq loc_02303AAA	; 02303A76
loc_02303A78:
	cmp r7,#0x0	; 02303A78
	ble loc_02303AAA	; 02303A7A
	bl loc_02300404	; 02303A7C
	mov r1,#0x82	; 02303A80
	strh r1,[r0,#0x0]	; 02303A82
	mov r1,#0x0	; 02303A84
	strh r1,[r0,#0x2]	; 02303A86
	mov r1,#0x15	; 02303A88
	strh r1,[r0,#0x4]	; 02303A8A
	ldr r1,[sp,#0x14]	; 02303A8C
	strh r1,[r0,#0x6]	; 02303A8E
	ldr r1,[sp,#0x58]	; 02303A90
	str r1,[r0,#0x8]	; 02303A92
	ldr r1,[sp,#0x10]	; 02303A94
	str r1,[r0,#0xc]	; 02303A96
	strh r7,[r0,#0x10]	; 02303A98
	ldr r1,[sp,#0x0]	; 02303A9A
	strh r1,[r0,#0x12]	; 02303A9C
	ldr r1,[pool_02303AC0]	; 02303A9E
	ldrh r1,[r4,r1]	; 02303AA0
	strh r1,[r0,#0x20]	; 02303AA2
	strh r6,[r0,#0x1a]	; 02303AA4
	bl loc_02300414	; 02303AA6
loc_02303AAA:
	cmp r5,#0x0	; 02303AAA
	bgt loc_023039B0	; 02303AAC
loc_02303AAE:
	add sp,#0x34	; 02303AAE
	pop {r4,r5,r6,r7}	; 02303AB0
	pop {r3}	; 02303AB2
	add sp,#0x10	; 02303AB4
	bx r3	; 02303AB6
pool_02303AB8:
loc_02303AB8:
	.word 0x00001518	; 02303AB8
pool_02303ABC:
loc_02303ABC:
	.word 0x00000190	; 02303ABC
pool_02303AC0:
loc_02303AC0:
	.word 0x00000184	; 02303AC0
pool_02303AC4:
loc_02303AC4:
	.word 0x000001F4	; 02303AC4
pool_02303AC8:
loc_02303AC8:
	.word 0x0000FFFF	; 02303AC8
pool_02303ACC:
loc_02303ACC:
	.word 0x00001000	; 02303ACC
pool_02303AD0:
loc_02303AD0:
	.word 0x00000800	; 02303AD0
pool_02303AD4:
loc_02303AD4:
	.word 0x00000F00	; 02303AD4

; ===== function loc_02303AD8 =====
loc_02303AD8:
	push {r4,r5,r6,r7,lr}	; 02303AD8
	sub sp,#0x2c	; 02303ADA
	str r0,[sp,#0x0]	; 02303ADC
	str r1,[sp,#0x4]	; 02303ADE
	bl loc_023008B4	; 02303AE0
	ldr r1,[pool_02303CC8]	; 02303AE4
	ldr r0,[r0,r1]	; 02303AE6
	ldr r5,[r0,#0x0]	; 02303AE8
	ldr r0,[pool_02303CCC]	; 02303AEA
	add r0,r5,r0	; 02303AEC
	str r0,[sp,#0x8]	; 02303AEE
	mov r0,#0x0	; 02303AF0
	str r0,[sp,#0x10]	; 02303AF2
	ldrh r0,[r5,#0x0]	; 02303AF4
	cmp r0,#0x9	; 02303AF6
	bne loc_02303AFE	; 02303AF8
	mov r4,#0x1	; 02303AFA
	b loc_02303B0A	; 02303AFC
loc_02303AFE:
	cmp r0,#0xa	; 02303AFE
	bne loc_02303B06	; 02303B00
	ldr r4,[sp,#0x10]	; 02303B02
	b loc_02303B0A	; 02303B04
loc_02303B06:
	ldr r0,[sp,#0x10]	; 02303B06
	b loc_02303CBE	; 02303B08
loc_02303B0A:
	ldr r0,[pool_02303CD0]	; 02303B0A
	add r0,r5,r0	; 02303B0C
	bl loc_02303CF0	; 02303B0E
	ldr r0,[pool_02303CD4]	; 02303B12
	ldr r0,[r5,r0]	; 02303B14
	cmp r0,#0x0	; 02303B16
	bne loc_02303B26	; 02303B18
	ldr r0,[pool_02303CD0]	; 02303B1A
	add r0,r5,r0	; 02303B1C
	bl loc_02303D00	; 02303B1E
	mov r0,#0x0	; 02303B22
	b loc_02303CBE	; 02303B24
loc_02303B26:
	cmp r4,#0x1	; 02303B26
	bne loc_02303B32	; 02303B28
	add r0,r5,#0x0	; 02303B2A
	add r0,#0x86	; 02303B2C
	ldrh r1,[r0,#0x0]	; 02303B2E
	b loc_02303B34	; 02303B30
loc_02303B32:
	mov r1,#0x1	; 02303B32
loc_02303B34:
	mov r0,#0x0	; 02303B34
	str r0,[sp,#0xc]	; 02303B36
	lsl r0,r1,#0x10	; 02303B38
	lsr r0,r0,#0x10	; 02303B3A
	str r0,[sp,#0x1c]	; 02303B3C
	ldr r0,[sp,#0xc]	; 02303B3E
	str r0,[sp,#0x28]	; 02303B40
	str r0,[sp,#0x24]	; 02303B42
loc_02303B44:
	ldr r0,[sp,#0xc]	; 02303B44
	lsl r0,r0,#0x2	; 02303B46
	str r0,[sp,#0x20]	; 02303B48
	ldr r0,[pool_02303CD8]	; 02303B4A
	add r1,r5,r0	; 02303B4C
	ldr r0,[sp,#0x20]	; 02303B4E
	add r7,r1,r0	; 02303B50
	ldr r0,[pool_02303CDC]	; 02303B52
	str r0,[sp,#0x14]	; 02303B54
	str r0,[sp,#0x18]	; 02303B56
	ldr r0,[sp,#0x20]	; 02303B58
	ldrh r6,[r1,r0]	; 02303B5A
	b loc_02303C6C	; 02303B5C
loc_02303B5E:
	add r1,r6,#0x0	; 02303B5E
	mov r0,#0x18	; 02303B60
	mul r1,r0	; 02303B62
	ldr r0,[sp,#0x8]	; 02303B64
	add r4,r0,r1	; 02303B66
	ldrh r0,[r4,#0x4]	; 02303B68
	add r2,r0,#0x0	; 02303B6A
	ldr r1,[sp,#0x1c]	; 02303B6C
	and r2,r1	; 02303B6E
	cmp r2,#0x0	; 02303B70
	beq loc_02303BE0	; 02303B72
	ldr r1,[sp,#0x0]	; 02303B74
	cmp r1,#0x0	; 02303B76
	bne loc_02303B82	; 02303B78
	ldr r1,[sp,#0x4]	; 02303B7A
	and r1,r0	; 02303B7C
	cmp r1,#0x0	; 02303B7E
	beq loc_02303BE0	; 02303B80
loc_02303B82:
	ldrh r1,[r4,#0x2]	; 02303B82
	mov r0,#0x8	; 02303B84
	and r1,r0	; 02303B86
	cmp r1,#0x0	; 02303B88
	bne loc_02303B92	; 02303B8A
	ldrh r0,[r4,#0xa]	; 02303B8C
	cmp r0,#0x0	; 02303B8E
	beq loc_02303BE0	; 02303B90
loc_02303B92:
	mov r0,#0x1	; 02303B92
	str r0,[sp,#0x10]	; 02303B94
	ldrh r0,[r4,#0xa]	; 02303B96
	cmp r0,#0x0	; 02303B98
	beq loc_02303BA6	; 02303B9A
	add r1,r4,#0x0	; 02303B9C
	add r1,#0xa	; 02303B9E
	ldrh r0,[r1,#0x0]	; 02303BA0
	sub r0,r0,#0x1	; 02303BA2
	strh r0,[r1,#0x0]	; 02303BA4
loc_02303BA6:
	ldr r0,[sp,#0x0]	; 02303BA6
	cmp r0,#0x0	; 02303BA8
	bne loc_02303BB6	; 02303BAA
	add r2,r4,#0x4	; 02303BAC
	ldrh r1,[r2,#0x0]	; 02303BAE
	ldr r0,[sp,#0x4]	; 02303BB0
	and r1,r0	; 02303BB2
	strh r1,[r2,#0x0]	; 02303BB4
loc_02303BB6:
	ldrh r1,[r4,#0x0]	; 02303BB6
	ldr r0,[pool_02303CDC]	; 02303BB8
	cmp r1,r0	; 02303BBA
	bne loc_02303BC0	; 02303BBC
	strh r0,[r7,#0x2]	; 02303BBE
loc_02303BC0:
	ldrh r0,[r4,#0x0]	; 02303BC0
	strh r0,[r7,#0x0]	; 02303BC2
	ldr r0,[pool_02303CDC]	; 02303BC4
	strh r0,[r4,#0x0]	; 02303BC6
	ldr r1,[sp,#0x14]	; 02303BC8
	cmp r1,r0	; 02303BCA
	bne loc_02303BD2	; 02303BCC
	str r6,[sp,#0x18]	; 02303BCE
	b loc_02303BDC	; 02303BD0
loc_02303BD2:
	mov r0,#0x18	; 02303BD2
	mul r1,r0	; 02303BD4
	str r1,[sp,#0x14]	; 02303BD6
	ldr r0,[sp,#0x8]	; 02303BD8
	strh r6,[r0,r1]	; 02303BDA
loc_02303BDC:
	str r6,[sp,#0x14]	; 02303BDC
	b loc_02303C6A	; 02303BDE
loc_02303BE0:
	bl loc_02300404	; 02303BE0
	add r2,r0,#0x0	; 02303BE4
	mov r0,#0x81	; 02303BE6
	strh r0,[r2,#0x0]	; 02303BE8
	ldrh r1,[r4,#0x4]	; 02303BEA
	add r3,r1,#0x0	; 02303BEC
	ldr r0,[sp,#0x1c]	; 02303BEE
	and r3,r0	; 02303BF0
	cmp r3,#0x0	; 02303BF2
	bne loc_02303BFE	; 02303BF4
	ldr r0,[sp,#0x24]	; 02303BF6
	strh r0,[r2,#0x2]	; 02303BF8
	strh r0,[r4,#0x4]	; 02303BFA
	b loc_02303C16	; 02303BFC
loc_02303BFE:
	ldr r0,[sp,#0x0]	; 02303BFE
	cmp r0,#0x0	; 02303C00
	bne loc_02303C0C	; 02303C02
	ldr r0,[sp,#0x4]	; 02303C04
	and r0,r1	; 02303C06
	cmp r0,#0x0	; 02303C08
	beq loc_02303C12	; 02303C0A
loc_02303C0C:
	mov r0,#0xf	; 02303C0C
	strh r0,[r2,#0x2]	; 02303C0E
	b loc_02303C16	; 02303C10
loc_02303C12:
	ldr r0,[sp,#0x28]	; 02303C12
	strh r0,[r2,#0x2]	; 02303C14
loc_02303C16:
	mov r0,#0x14	; 02303C16
	strh r0,[r2,#0x8]	; 02303C18
	ldrh r0,[r4,#0x2]	; 02303C1A
	strh r0,[r2,#0xa]	; 02303C1C
	ldrh r0,[r4,#0x4]	; 02303C1E
	strh r0,[r2,#0xc]	; 02303C20
	ldrh r0,[r4,#0x6]	; 02303C22
	strh r0,[r2,#0xe]	; 02303C24
	ldr r0,[r4,#0xc]	; 02303C26
	str r0,[r2,#0x10]	; 02303C28
	ldr r0,[r4,#0x10]	; 02303C2A
	str r0,[r2,#0x14]	; 02303C2C
	ldr r0,[r4,#0x14]	; 02303C2E
	str r0,[r2,#0x18]	; 02303C30
	ldrh r0,[r4,#0x8]	; 02303C32
	strh r0,[r2,#0x1c]	; 02303C34
	add r0,r2,#0x0	; 02303C36
	bl loc_02300414	; 02303C38
	ldrh r1,[r4,#0x0]	; 02303C3C
	ldr r0,[pool_02303CDC]	; 02303C3E
	cmp r1,r0	; 02303C40
	bne loc_02303C46	; 02303C42
	strh r0,[r7,#0x2]	; 02303C44
loc_02303C46:
	ldrh r0,[r4,#0x0]	; 02303C46
	strh r0,[r7,#0x0]	; 02303C48
	ldr r0,[pool_02303CDC]	; 02303C4A
	strh r0,[r4,#0x0]	; 02303C4C
	ldr r0,[pool_02303CE0]	; 02303C4E
	ldrh r1,[r5,r0]	; 02303C50
	ldr r0,[pool_02303CDC]	; 02303C52
	cmp r1,r0	; 02303C54
	bne loc_02303C5E	; 02303C56
	ldr r0,[pool_02303CE4]	; 02303C58
	strh r6,[r5,r0]	; 02303C5A
	b loc_02303C66	; 02303C5C
loc_02303C5E:
	mov r0,#0x18	; 02303C5E
	mul r1,r0	; 02303C60
	ldr r0,[sp,#0x8]	; 02303C62
	strh r6,[r0,r1]	; 02303C64
loc_02303C66:
	ldr r0,[pool_02303CE0]	; 02303C66
	strh r6,[r5,r0]	; 02303C68
loc_02303C6A:
	ldrh r6,[r7,#0x0]	; 02303C6A
loc_02303C6C:
	ldr r0,[pool_02303CDC]	; 02303C6C
	cmp r6,r0	; 02303C6E
	beq loc_02303C74	; 02303C70
	b loc_02303B5E	; 02303C72
loc_02303C74:
	ldr r1,[sp,#0x14]	; 02303C74
	cmp r1,r0	; 02303C76
	beq loc_02303CA2	; 02303C78
	ldr r0,[sp,#0x20]	; 02303C7A
	add r0,r5,r0	; 02303C7C
	ldr r1,[pool_02303CE8]	; 02303C7E
	ldrh r3,[r0,r1]	; 02303C80
	ldr r2,[sp,#0x14]	; 02303C82
	mov r1,#0x18	; 02303C84
	mul r2,r1	; 02303C86
	ldr r1,[sp,#0x8]	; 02303C88
	strh r3,[r1,r2]	; 02303C8A
	ldr r1,[pool_02303CEC]	; 02303C8C
	ldrh r2,[r0,r1]	; 02303C8E
	ldr r1,[pool_02303CDC]	; 02303C90
	cmp r2,r1	; 02303C92
	bne loc_02303C9C	; 02303C94
	ldr r2,[sp,#0x14]	; 02303C96
	ldr r1,[pool_02303CEC]	; 02303C98
	strh r2,[r0,r1]	; 02303C9A
loc_02303C9C:
	ldr r2,[sp,#0x18]	; 02303C9C
	ldr r1,[pool_02303CE8]	; 02303C9E
	strh r2,[r0,r1]	; 02303CA0
loc_02303CA2:
	ldr r0,[sp,#0xc]	; 02303CA2
	add r0,r0,#0x1	; 02303CA4
	str r0,[sp,#0xc]	; 02303CA6
	cmp r0,#0x4	; 02303CA8
	bge loc_02303CAE	; 02303CAA
	b loc_02303B44	; 02303CAC
loc_02303CAE:
	mov r1,#0x0	; 02303CAE
	ldr r0,[pool_02303CD4]	; 02303CB0
	str r1,[r5,r0]	; 02303CB2
	ldr r0,[pool_02303CD0]	; 02303CB4
	add r0,r5,r0	; 02303CB6
	bl loc_02303D00	; 02303CB8
	ldr r0,[sp,#0x10]	; 02303CBC
loc_02303CBE:
	add sp,#0x2c	; 02303CBE
	pop {r4,r5,r6,r7}	; 02303CC0
	pop {r3}	; 02303CC2
	bx r3	; 02303CC4
	.byte 0xC0, 0x46	; 02303CC8
pool_02303CC8:
loc_02303CC8:
	.word 0x00001518	; 02303CC8
pool_02303CCC:
loc_02303CCC:
	.word 0x000002F4	; 02303CCC
pool_02303CD0:
loc_02303CD0:
	.word 0x00000918	; 02303CD0
pool_02303CD4:
loc_02303CD4:
	.word 0x0000092C	; 02303CD4
pool_02303CD8:
loc_02303CD8:
	.word 0x000008F8	; 02303CD8
pool_02303CDC:
loc_02303CDC:
	.word 0x0000FFFF	; 02303CDC
pool_02303CE0:
loc_02303CE0:
	.word 0x000008F6	; 02303CE0
pool_02303CE4:
loc_02303CE4:
	.word 0x000008F4	; 02303CE4
pool_02303CE8:
loc_02303CE8:
	.word 0x00000908	; 02303CE8
pool_02303CEC:
loc_02303CEC:
	.word 0x0000090A	; 02303CEC

; ===== function loc_02303CF0 =====
loc_02303CF0:
	bx pc	; 02303CF0
	.byte 0xC0, 0x46	; 02303CF4
.arm

; ===== function loc_02303CF4 =====
loc_02303CF4:
	ldr r12,[pool_02303CFC]	; 02303CF4
	bx r12	; 02303CF8
pool_02303CFC:
loc_02303CFC:
	.word P2_Entry_037FBF3C + 1	; 02303CFC
.thumb

; ===== function loc_02303D00 =====
loc_02303D00:
	bx pc	; 02303D00
	.byte 0xC0, 0x46	; 02303D04
.arm

; ===== function loc_02303D04 =====
loc_02303D04:
	ldr r12,[pool_02303D0C]	; 02303D04
	bx r12	; 02303D08
pool_02303D0C:
loc_02303D0C:
	.word P2_Entry_037FBEF4 + 1	; 02303D0C
.thumb

; ===== function loc_02303D10 =====
loc_02303D10:
	push {r4,r5,r6,r7,lr}	; 02303D10
	sub sp,#0xc	; 02303D12
	add r4,r0,#0x0	; 02303D14
	add r7,r1,#0x0	; 02303D16
	str r2,[sp,#0x0]	; 02303D18
	str r3,[sp,#0x4]	; 02303D1A
	bl loc_023008B4	; 02303D1C
	ldr r1,[pool_02303DE4]	; 02303D20
	ldr r0,[r0,r1]	; 02303D22
	ldr r5,[r0,#0x0]	; 02303D24
	ldr r0,[pool_02303DE8]	; 02303D26
	add r6,r5,r0	; 02303D28
	ldr r0,[pool_02303DEC]	; 02303D2A
	add r1,r5,r0	; 02303D2C
	lsl r0,r4,#0x2	; 02303D2E
	add r4,r1,r0	; 02303D30
	add r0,sp,#0x10	; 02303D32
	ldrh r0,[r0,#0x10]	; 02303D34
	cmp r0,#0x0	; 02303D36
	bne loc_02303D3E	; 02303D38
	mov r0,#0x6	; 02303D3A
	b loc_02303DDC	; 02303D3C
loc_02303D3E:
	mov r0,#0x8	; 02303D3E
	add r1,r7,#0x0	; 02303D40
	and r1,r0	; 02303D42
	cmp r1,#0x0	; 02303D44
	beq loc_02303D4C	; 02303D46
	mov r1,#0x2	; 02303D48
	b loc_02303D4E	; 02303D4A
loc_02303D4C:
	mov r1,#0x0	; 02303D4C
loc_02303D4E:
	add r0,sp,#0x10	; 02303D4E
	ldrh r0,[r0,#0x10]	; 02303D50
	add r1,r0,r1	; 02303D52
	ldr r0,[pool_02303DF0]	; 02303D54
	ldrh r0,[r5,r0]	; 02303D56
	cmp r1,r0	; 02303D58
	ble loc_02303D60	; 02303D5A
	mov r0,#0x6	; 02303D5C
	b loc_02303DDC	; 02303D5E
loc_02303D60:
	ldr r0,[pool_02303DF4]	; 02303D60
	add r0,r5,r0	; 02303D62
	bl loc_02303CF0	; 02303D64
	ldr r0,[pool_02303DF8]	; 02303D68
	add r2,r5,r0	; 02303D6A
	ldrh r0,[r2,#0x0]	; 02303D6C
	ldr r1,[pool_02303DFC]	; 02303D6E
	cmp r0,r1	; 02303D70
	bne loc_02303D80	; 02303D72
	ldr r0,[pool_02303DF4]	; 02303D74
	add r0,r5,r0	; 02303D76
	bl loc_02303D00	; 02303D78
	mov r0,#0xa	; 02303D7C
	b loc_02303DDC	; 02303D7E
loc_02303D80:
	mov r1,#0x18	; 02303D80
	add r3,r0,#0x0	; 02303D82
	mul r3,r1	; 02303D84
	add r1,r6,r3	; 02303D86
	ldrh r3,[r6,r3]	; 02303D88
	strh r3,[r2,#0x0]	; 02303D8A
	ldr r2,[pool_02303E00]	; 02303D8C
	add r3,r5,r2	; 02303D8E
	ldrh r2,[r3,#0x0]	; 02303D90
	cmp r2,r0	; 02303D92
	bne loc_02303D9A	; 02303D94
	ldr r2,[pool_02303DFC]	; 02303D96
	strh r2,[r3,#0x0]	; 02303D98
loc_02303D9A:
	strh r7,[r1,#0x2]	; 02303D9A
	ldr r2,[sp,#0x0]	; 02303D9C
	strh r2,[r1,#0x4]	; 02303D9E
	ldr r2,[sp,#0x4]	; 02303DA0
	str r2,[r1,#0xc]	; 02303DA2
	add r2,sp,#0x10	; 02303DA4
	ldrh r2,[r2,#0x10]	; 02303DA6
	strh r2,[r1,#0x6]	; 02303DA8
	ldr r2,[sp,#0x24]	; 02303DAA
	str r2,[r1,#0x10]	; 02303DAC
	ldr r2,[sp,#0x28]	; 02303DAE
	str r2,[r1,#0x14]	; 02303DB0
	ldr r2,[pool_02303DFC]	; 02303DB2
	strh r2,[r1,#0x0]	; 02303DB4
	strh r2,[r1,#0x8]	; 02303DB6
	add r3,r5,#0x0	; 02303DB8
	add r3,#0x98	; 02303DBA
	ldrh r3,[r3,#0x0]	; 02303DBC
	strh r3,[r1,#0xa]	; 02303DBE
	ldrh r3,[r4,#0x2]	; 02303DC0
	cmp r3,r2	; 02303DC2
	bne loc_02303DCA	; 02303DC4
	strh r0,[r4,#0x0]	; 02303DC6
	b loc_02303DD0	; 02303DC8
loc_02303DCA:
	mov r1,#0x18	; 02303DCA
	mul r3,r1	; 02303DCC
	strh r0,[r6,r3]	; 02303DCE
loc_02303DD0:
	strh r0,[r4,#0x2]	; 02303DD0
	ldr r0,[pool_02303DF4]	; 02303DD2
	add r0,r5,r0	; 02303DD4
	bl loc_02303D00	; 02303DD6
	mov r0,#0x2	; 02303DDA
loc_02303DDC:
	add sp,#0xc	; 02303DDC
	pop {r4,r5,r6,r7}	; 02303DDE
	pop {r3}	; 02303DE0
	bx r3	; 02303DE2
pool_02303DE4:
loc_02303DE4:
	.word 0x00001518	; 02303DE4
pool_02303DE8:
loc_02303DE8:
	.word 0x000002F4	; 02303DE8
pool_02303DEC:
loc_02303DEC:
	.word 0x00000908	; 02303DEC
pool_02303DF0:
loc_02303DF0:
	.word 0x0000018E	; 02303DF0
pool_02303DF4:
loc_02303DF4:
	.word 0x00000918	; 02303DF4
pool_02303DF8:
loc_02303DF8:
	.word 0x000008F4	; 02303DF8
pool_02303DFC:
loc_02303DFC:
	.word 0x0000FFFF	; 02303DFC
pool_02303E00:
loc_02303E00:
	.word 0x000008F6	; 02303E00

; ===== function loc_02303E04 =====
loc_02303E04:
	push {r4,r5,r6,r7,lr}	; 02303E04
	sub sp,#0x6c	; 02303E06
	add r4,r0,#0x0	; 02303E08
	add r7,r1,#0x0	; 02303E0A
	str r2,[sp,#0x0]	; 02303E0C
	str r3,[sp,#0x4]	; 02303E0E
	ldr r0,[sp,#0x80]	; 02303E10
	str r0,[sp,#0x80]	; 02303E12
	ldr r0,[sp,#0x84]	; 02303E14
	str r0,[sp,#0x84]	; 02303E16
	bl loc_023008B4	; 02303E18
	str r0,[sp,#0x10]	; 02303E1C
	ldr r1,[pool_02304158]	; 02303E1E
	ldr r0,[r0,r1]	; 02303E20
	ldr r6,[r0,#0x0]	; 02303E22
	ldrh r0,[r6,#0x0]	; 02303E24
	cmp r0,#0x9	; 02303E26
	bne loc_02303E30	; 02303E28
	mov r0,#0x1	; 02303E2A
	str r0,[sp,#0x20]	; 02303E2C
	b loc_02303E3E	; 02303E2E
loc_02303E30:
	cmp r0,#0xa	; 02303E30
	bne loc_02303E3A	; 02303E32
	mov r0,#0x0	; 02303E34
	str r0,[sp,#0x20]	; 02303E36
	b loc_02303E3E	; 02303E38
loc_02303E3A:
	mov r0,#0x1	; 02303E3A
	b loc_0230414E	; 02303E3C
loc_02303E3E:
	mov r1,#0x0	; 02303E3E
	str r1,[sp,#0x24]	; 02303E40
	ldr r0,[sp,#0x0]	; 02303E42
	strh r1,[r0,#0x0]	; 02303E44
	ldr r0,[sp,#0x80]	; 02303E46
	strh r1,[r0,#0x0]	; 02303E48
	ldr r0,[sp,#0x84]	; 02303E4A
	strh r1,[r0,#0x0]	; 02303E4C
	lsl r0,r1,#0	; 02303E4E
	str r0,[sp,#0x28]	; 02303E50
	ldr r0,[sp,#0x20]	; 02303E52
	cmp r0,#0x1	; 02303E54
	bne loc_02303E60	; 02303E56
	add r0,r6,#0x0	; 02303E58
	add r0,#0x86	; 02303E5A
	ldrh r0,[r0,#0x0]	; 02303E5C
	b loc_02303E62	; 02303E5E
loc_02303E60:
	mov r0,#0x1	; 02303E60
loc_02303E62:
	lsl r0,r0,#0x10	; 02303E62
	lsr r0,r0,#0x10	; 02303E64
	str r0,[sp,#0x18]	; 02303E66
	cmp r7,#0x0	; 02303E68
	bge loc_02303E70	; 02303E6A
	mov r0,#0x1	; 02303E6C
	b loc_0230414E	; 02303E6E
loc_02303E70:
	mov r0,#0x0	; 02303E70
	str r0,[sp,#0x14]	; 02303E72
	mov r0,#0x1	; 02303E74
	str r0,[sp,#0x1c]	; 02303E76
	ldr r0,[pool_0230415C]	; 02303E78
	add r0,r6,r0	; 02303E7A
	bl loc_02303CF0	; 02303E7C
	ldr r0,[pool_02304160]	; 02303E80
	add r1,r6,r0	; 02303E82
	ldr r0,[r1,#0x0]	; 02303E84
	cmp r0,#0x1	; 02303E86
	bne loc_02303E96	; 02303E88
	ldr r0,[pool_0230415C]	; 02303E8A
	add r0,r6,r0	; 02303E8C
	bl loc_02303D00	; 02303E8E
	mov r0,#0x1	; 02303E92
	b loc_0230414E	; 02303E94
loc_02303E96:
	mov r0,#0x1	; 02303E96
	str r0,[r1,#0x0]	; 02303E98
	ldr r0,[pool_02304164]	; 02303E9A
	add r0,r6,r0	; 02303E9C
	str r0,[sp,#0x2c]	; 02303E9E
	mov r0,#0x0	; 02303EA0
	str r0,[sp,#0x30]	; 02303EA2
	ldr r0,[sp,#0x18]	; 02303EA4
	and r0,r4	; 02303EA6
	mvn r0,r0	; 02303EA8
	str r0,[sp,#0x48]	; 02303EAA
	ldr r0,[sp,#0x30]	; 02303EAC
	str r0,[sp,#0x50]	; 02303EAE
	str r0,[sp,#0x54]	; 02303EB0
	str r0,[sp,#0x58]	; 02303EB2
	str r0,[sp,#0x5c]	; 02303EB4
	str r0,[sp,#0x60]	; 02303EB6
	str r0,[sp,#0x64]	; 02303EB8
	str r0,[sp,#0x68]	; 02303EBA
	b loc_0230412C	; 02303EBC
loc_02303EBE:
	ldr r0,[sp,#0x30]	; 02303EBE
	lsl r1,r0,#0x2	; 02303EC0
	ldr r0,[pool_02304168]	; 02303EC2
	add r0,r6,r0	; 02303EC4
	add r2,r0,r1	; 02303EC6
	str r2,[sp,#0x34]	; 02303EC8
	ldr r2,[pool_0230416C]	; 02303ECA
	add r2,r6,r2	; 02303ECC
	add r2,r2,r1	; 02303ECE
	str r2,[sp,#0x38]	; 02303ED0
	ldr r2,[sp,#0x34]	; 02303ED2
	str r2,[sp,#0x3c]	; 02303ED4
	ldr r2,[pool_02304170]	; 02303ED6
	str r2,[sp,#0x40]	; 02303ED8
	ldrh r5,[r0,r1]	; 02303EDA
	b loc_02304116	; 02303EDC
loc_02303EDE:
	add r1,r5,#0x0	; 02303EDE
	mov r0,#0x18	; 02303EE0
	mul r1,r0	; 02303EE2
	ldr r0,[sp,#0x2c]	; 02303EE4
	add r4,r0,r1	; 02303EE6
	ldrh r1,[r4,#0x2]	; 02303EE8
	mov r0,#0x1	; 02303EEA
	lsl r0,r1	; 02303EEC
	lsl r0,r0,#0x10	; 02303EEE
	lsr r0,r0,#0x10	; 02303EF0
	str r0,[sp,#0x4c]	; 02303EF2
	ldr r2,[sp,#0x14]	; 02303EF4
	and r2,r0	; 02303EF6
	lsl r0,r2,#0x10	; 02303EF8
	lsr r0,r0,#0x10	; 02303EFA
	cmp r0,#0x0	; 02303EFC
	beq loc_02303F02	; 02303EFE
	b loc_02304102	; 02303F00
loc_02303F02:
	ldr r2,[sp,#0x14]	; 02303F02
	ldr r0,[sp,#0x4c]	; 02303F04
	orr r2,r0	; 02303F06
	str r2,[sp,#0x14]	; 02303F08
	ldrh r0,[r4,#0x4]	; 02303F0A
	add r3,r0,#0x0	; 02303F0C
	ldr r2,[sp,#0x18]	; 02303F0E
	and r3,r2	; 02303F10
	lsl r2,r3,#0x10	; 02303F12
	lsr r2,r2,#0x10	; 02303F14
	str r2,[sp,#0x44]	; 02303F16
	ldr r2,[sp,#0x20]	; 02303F18
	cmp r2,#0x0	; 02303F1A
	beq loc_02303F2E	; 02303F1C
	ldr r3,[sp,#0x44]	; 02303F1E
	ldr r2,[sp,#0x48]	; 02303F20
	and r3,r2	; 02303F22
	mov r2,#0x1	; 02303F24
	bic r3,r2	; 02303F26
	cmp r3,#0x0	; 02303F28
	beq loc_02303F2E	; 02303F2A
	b loc_02304102	; 02303F2C
loc_02303F2E:
	mov r2,#0x8	; 02303F2E
	and r1,r2	; 02303F30
	cmp r1,#0x0	; 02303F32
	beq loc_02303F3C	; 02303F34
	mov r1,#0x1	; 02303F36
	str r1,[sp,#0xc]	; 02303F38
	b loc_02303F40	; 02303F3A
loc_02303F3C:
	ldr r1,[sp,#0x50]	; 02303F3C
	str r1,[sp,#0xc]	; 02303F3E
loc_02303F40:
	ldr r1,[sp,#0x20]	; 02303F40
	cmp r1,#0x0	; 02303F42
	beq loc_02303F56	; 02303F44
	mov r1,#0x1	; 02303F46
	orr r0,r1	; 02303F48
	ldr r1,[pool_02304170]	; 02303F4A
	cmp r0,r1	; 02303F4C
	beq loc_02303F56	; 02303F4E
	mov r0,#0x1	; 02303F50
	str r0,[sp,#0x8]	; 02303F52
	b loc_02303F5A	; 02303F54
loc_02303F56:
	ldr r0,[sp,#0x54]	; 02303F56
	str r0,[sp,#0x8]	; 02303F58
loc_02303F5A:
	ldrh r1,[r4,#0x6]	; 02303F5A
	mov r0,#0x1	; 02303F5C
	and r1,r0	; 02303F5E
	cmp r1,#0x1	; 02303F60
	bne loc_02303F6C	; 02303F62
	add r1,r4,#0x6	; 02303F64
	ldrh r0,[r1,#0x0]	; 02303F66
	add r0,r0,#0x1	; 02303F68
	strh r0,[r1,#0x0]	; 02303F6A
loc_02303F6C:
	ldr r0,[sp,#0xc]	; 02303F6C
	cmp r0,#0x0	; 02303F6E
	beq loc_02303F76	; 02303F70
	mov r3,#0x2	; 02303F72
	b loc_02303F78	; 02303F74
loc_02303F76:
	ldr r3,[sp,#0x58]	; 02303F76
loc_02303F78:
	ldr r0,[sp,#0x1c]	; 02303F78
	cmp r0,#0x0	; 02303F7A
	beq loc_02303F82	; 02303F7C
	ldr r1,[sp,#0x5c]	; 02303F7E
	b loc_02303F84	; 02303F80
loc_02303F82:
	mov r1,#0x2	; 02303F82
loc_02303F84:
	ldr r0,[sp,#0x8]	; 02303F84
	cmp r0,#0x0	; 02303F86
	beq loc_02303F8E	; 02303F88
	mov r2,#0x2	; 02303F8A
	b loc_02303F90	; 02303F8C
loc_02303F8E:
	ldr r2,[sp,#0x60]	; 02303F8E
loc_02303F90:
	ldrh r0,[r4,#0x6]	; 02303F90
	add r0,r0,r1	; 02303F92
	add r0,r0,r3	; 02303F94
	add r0,r2,r0	; 02303F96
	cmp r0,r7	; 02303F98
	ble loc_02303F9E	; 02303F9A
	b loc_023040E8	; 02303F9C
loc_02303F9E:
	ldr r0,[sp,#0x1c]	; 02303F9E
	cmp r0,#0x0	; 02303FA0
	bne loc_02303FBC	; 02303FA2
	ldr r0,[sp,#0x4]	; 02303FA4
	str r0,[sp,#0x0]	; 02303FA6
	ldr r1,[sp,#0x64]	; 02303FA8
	strh r1,[r0,#0x0]	; 02303FAA
	add r0,r0,#0x2	; 02303FAC
	str r0,[sp,#0x4]	; 02303FAE
	ldr r0,[sp,#0x28]	; 02303FB0
	add r0,r0,#0x2	; 02303FB2
	lsl r0,r0,#0x10	; 02303FB4
	lsr r0,r0,#0x10	; 02303FB6
	str r0,[sp,#0x28]	; 02303FB8
	sub r7,r7,#0x2	; 02303FBA
loc_02303FBC:
	ldr r0,[sp,#0x0]	; 02303FBC
	ldrh r0,[r0,#0x0]	; 02303FBE
	ldrh r1,[r4,#0x2]	; 02303FC0
	lsl r2,r1,#0x8	; 02303FC2
	ldr r1,[pool_02304174]	; 02303FC4
	and r2,r1	; 02303FC6
	orr r0,r2	; 02303FC8
	ldr r1,[sp,#0x0]	; 02303FCA
	strh r0,[r1,#0x0]	; 02303FCC
	lsl r0,r1,#0	; 02303FCE
	ldrh r0,[r0,#0x0]	; 02303FD0
	ldrh r1,[r4,#0x6]	; 02303FD2
	lsr r2,r1,#0x1	; 02303FD4
	mov r1,#0xff	; 02303FD6
	and r2,r1	; 02303FD8
	orr r0,r2	; 02303FDA
	ldr r1,[sp,#0x0]	; 02303FDC
	strh r0,[r1,#0x0]	; 02303FDE
	ldr r1,[sp,#0x10]	; 02303FE0
	ldr r0,[pool_02304178]	; 02303FE2
	ldr r0,[r1,r0]	; 02303FE4
	ldr r1,[r4,#0xc]	; 02303FE6
	ldr r2,[sp,#0x4]	; 02303FE8
	ldrh r3,[r4,#0x6]	; 02303FEA
	bl loc_023006B4	; 02303FEC
	ldrh r1,[r4,#0x6]	; 02303FF0
	add r0,r1,#0x0	; 02303FF2
	mov r2,#0x1	; 02303FF4
	bic r0,r2	; 02303FF6
	ldr r2,[sp,#0x4]	; 02303FF8
	add r0,r2,r0	; 02303FFA
	str r0,[sp,#0x4]	; 02303FFC
	ldr r0,[sp,#0x28]	; 02303FFE
	add r0,r0,r1	; 02304000
	lsl r0,r0,#0x10	; 02304002
	lsr r0,r0,#0x10	; 02304004
	str r0,[sp,#0x28]	; 02304006
	sub r7,r7,r1	; 02304008
	ldr r0,[sp,#0xc]	; 0230400A
	cmp r0,#0x1	; 0230400C
	bne loc_02304060	; 0230400E
	ldrh r2,[r4,#0x8]	; 02304010
	add r1,r2,#0x0	; 02304012
	mov r0,#0x1	; 02304014
	and r1,r0	; 02304016
	cmp r1,#0x0	; 02304018
	beq loc_02304042	; 0230401A
	ldr r0,[pool_0230417C]	; 0230401C
	ldrh r0,[r6,r0]	; 0230401E
	lsl r0,r0,#0x4	; 02304020
	add r0,r6,r0	; 02304022
	ldrh r2,[r4,#0x2]	; 02304024
	mov r1,#0x7	; 02304026
	and r2,r1	; 02304028
	lsl r1,r2,#0x1	; 0230402A
	add r0,r0,r1	; 0230402C
	ldr r1,[pool_02304180]	; 0230402E
	ldrh r1,[r0,r1]	; 02304030
	ldr r2,[pool_02304180]	; 02304032
	add r0,r0,r2	; 02304034
	ldrh r2,[r0,#0x0]	; 02304036
	add r2,r2,#0x1	; 02304038
	strh r2,[r0,#0x0]	; 0230403A
	lsl r0,r1,#0x1	; 0230403C
	strh r0,[r4,#0x8]	; 0230403E
	b loc_0230404C	; 02304040
loc_02304042:
	asr r1,r2,#0x1	; 02304042
	ldr r0,[pool_02304184]	; 02304044
	and r1,r0	; 02304046
	lsl r0,r1,#0x10	; 02304048
	lsr r1,r0,#0x10	; 0230404A
loc_0230404C:
	ldr r0,[sp,#0x4]	; 0230404C
	strh r1,[r0,#0x0]	; 0230404E
	add r0,r0,#0x2	; 02304050
	str r0,[sp,#0x4]	; 02304052
	ldr r0,[sp,#0x28]	; 02304054
	add r0,r0,#0x2	; 02304056
	lsl r0,r0,#0x10	; 02304058
	lsr r0,r0,#0x10	; 0230405A
	str r0,[sp,#0x28]	; 0230405C
	sub r7,r7,#0x2	; 0230405E
loc_02304060:
	ldr r0,[sp,#0x8]	; 02304060
	cmp r0,#0x1	; 02304062
	bne loc_02304088	; 02304064
	ldr r0,[sp,#0x0]	; 02304066
	ldrh r1,[r0,#0x0]	; 02304068
	ldr r0,[pool_02304188]	; 0230406A
	orr r1,r0	; 0230406C
	ldr r0,[sp,#0x0]	; 0230406E
	strh r1,[r0,#0x0]	; 02304070
	ldr r1,[sp,#0x44]	; 02304072
	ldr r0,[sp,#0x4]	; 02304074
	strh r1,[r0,#0x0]	; 02304076
	add r0,r0,#0x2	; 02304078
	str r0,[sp,#0x4]	; 0230407A
	ldr r0,[sp,#0x28]	; 0230407C
	add r0,r0,#0x2	; 0230407E
	lsl r0,r0,#0x10	; 02304080
	lsr r0,r0,#0x10	; 02304082
	str r0,[sp,#0x28]	; 02304084
	sub r7,r7,#0x2	; 02304086
loc_02304088:
	ldr r0,[sp,#0x1c]	; 02304088
	cmp r0,#0x1	; 0230408A
	bne loc_02304092	; 0230408C
	ldr r0,[sp,#0x68]	; 0230408E
	str r0,[sp,#0x1c]	; 02304090
loc_02304092:
	ldr r0,[sp,#0x34]	; 02304092
	ldrh r0,[r0,#0x2]	; 02304094
	cmp r0,r5	; 02304096
	bne loc_023040A0	; 02304098
	ldr r1,[sp,#0x40]	; 0230409A
	ldr r0,[sp,#0x34]	; 0230409C
	strh r1,[r0,#0x2]	; 0230409E
loc_023040A0:
	ldrh r1,[r4,#0x0]	; 023040A0
	ldr r0,[sp,#0x3c]	; 023040A2
	strh r1,[r0,#0x0]	; 023040A4
	ldr r0,[pool_02304170]	; 023040A6
	strh r0,[r4,#0x0]	; 023040A8
	ldr r0,[sp,#0x38]	; 023040AA
	ldrh r0,[r0,#0x2]	; 023040AC
	ldr r1,[pool_02304170]	; 023040AE
	cmp r0,r1	; 023040B0
	bne loc_023040BA	; 023040B2
	ldr r0,[sp,#0x38]	; 023040B4
	strh r5,[r0,#0x0]	; 023040B6
	b loc_023040C2	; 023040B8
loc_023040BA:
	mov r1,#0x18	; 023040BA
	mul r0,r1	; 023040BC
	ldr r1,[sp,#0x2c]	; 023040BE
	strh r5,[r1,r0]	; 023040C0
loc_023040C2:
	ldr r0,[sp,#0x38]	; 023040C2
	strh r5,[r0,#0x2]	; 023040C4
	ldr r1,[sp,#0x14]	; 023040C6
	ldr r0,[sp,#0x4c]	; 023040C8
	bic r1,r0	; 023040CA
	str r1,[sp,#0x14]	; 023040CC
	lsl r0,r1,#0x10	; 023040CE
	lsr r0,r0,#0x10	; 023040D0
	str r0,[sp,#0x14]	; 023040D2
	ldrh r1,[r4,#0x4]	; 023040D4
	ldr r0,[sp,#0x24]	; 023040D6
	orr r0,r1	; 023040D8
	str r0,[sp,#0x24]	; 023040DA
	ldr r5,[sp,#0x40]	; 023040DC
	add r0,r6,#0x0	; 023040DE
	add r0,#0x94	; 023040E0
	ldrh r0,[r0,#0x0]	; 023040E2
	cmp r0,#0x1	; 023040E4
	beq loc_02304138	; 023040E6
loc_023040E8:
	ldr r0,[pool_02304170]	; 023040E8
	cmp r5,r0	; 023040EA
	beq loc_023040FC	; 023040EC
	add r1,r5,#0x0	; 023040EE
	mov r0,#0x18	; 023040F0
	mul r1,r0	; 023040F2
	ldr r0,[sp,#0x2c]	; 023040F4
	add r0,r0,r1	; 023040F6
	str r0,[sp,#0x3c]	; 023040F8
	b loc_02304100	; 023040FA
loc_023040FC:
	ldr r0,[sp,#0x34]	; 023040FC
	str r0,[sp,#0x3c]	; 023040FE
loc_02304100:
	str r5,[sp,#0x40]	; 02304100
loc_02304102:
	ldr r0,[pool_02304170]	; 02304102
	cmp r5,r0	; 02304104
	beq loc_02304112	; 02304106
	mov r0,#0x18	; 02304108
	mul r5,r0	; 0230410A
	ldr r0,[sp,#0x2c]	; 0230410C
	ldrh r5,[r0,r5]	; 0230410E
	b loc_02304116	; 02304110
loc_02304112:
	ldr r0,[sp,#0x34]	; 02304112
	ldrh r5,[r0,#0x0]	; 02304114
loc_02304116:
	ldr r0,[pool_02304170]	; 02304116
	cmp r5,r0	; 02304118
	beq loc_02304122	; 0230411A
	cmp r7,#0x2	; 0230411C
	ble loc_02304122	; 0230411E
	b loc_02303EDE	; 02304120
loc_02304122:
	ldr r0,[sp,#0x30]	; 02304122
	add r0,r0,#0x1	; 02304124
	lsl r0,r0,#0x10	; 02304126
	lsr r0,r0,#0x10	; 02304128
	str r0,[sp,#0x30]	; 0230412A
loc_0230412C:
	ldr r0,[sp,#0x30]	; 0230412C
	cmp r0,#0x4	; 0230412E
	bcs loc_02304138	; 02304130
	cmp r7,#0x2	; 02304132
	ble loc_02304138	; 02304134
	b loc_02303EBE	; 02304136
loc_02304138:
	ldr r1,[sp,#0x24]	; 02304138
	ldr r0,[sp,#0x80]	; 0230413A
	strh r1,[r0,#0x0]	; 0230413C
	ldr r1,[sp,#0x28]	; 0230413E
	ldr r0,[sp,#0x84]	; 02304140
	strh r1,[r0,#0x0]	; 02304142
	ldr r0,[pool_0230415C]	; 02304144
	add r0,r6,r0	; 02304146
	bl loc_02303D00	; 02304148
	mov r0,#0x0	; 0230414C
loc_0230414E:
	add sp,#0x6c	; 0230414E
	pop {r4,r5,r6,r7}	; 02304150
	pop {r3}	; 02304152
	bx r3	; 02304154
	.byte 0xC0, 0x46	; 02304158
pool_02304158:
loc_02304158:
	.word 0x00001518	; 02304158
pool_0230415C:
loc_0230415C:
	.word 0x00000918	; 0230415C
pool_02304160:
loc_02304160:
	.word 0x0000092C	; 02304160
pool_02304164:
loc_02304164:
	.word 0x000002F4	; 02304164
pool_02304168:
loc_02304168:
	.word 0x00000908	; 02304168
pool_0230416C:
loc_0230416C:
	.word 0x000008F8	; 0230416C
pool_02304170:
loc_02304170:
	.word 0x0000FFFF	; 02304170
pool_02304174:
loc_02304174:
	.word 0x00000F00	; 02304174
pool_02304178:
loc_02304178:
	.word 0x0000150C	; 02304178
pool_0230417C:
loc_0230417C:
	.word 0x00000184	; 0230417C
pool_02304180:
loc_02304180:
	.word 0x000001F4	; 02304180
pool_02304184:
loc_02304184:
	.word 0x00007FFF	; 02304184
pool_02304188:
loc_02304188:
	.word 0x00001000	; 02304188

; ===== function loc_0230418C =====
loc_0230418C:
	push {r4,r5,r6,r7,lr}	; 0230418C
	sub sp,#0x1fc	; 0230418E
	sub sp,#0x30	; 02304190
	add r5,r0,#0x0	; 02304192
	bl loc_023008B4	; 02304194
	ldr r1,[pool_02304290]	; 02304198
	ldr r0,[r0,r1]	; 0230419A
	ldr r4,[r0,#0x0]	; 0230419C
	mov r6,#0x0	; 0230419E
	ldr r7,[r4,#0x50]	; 023041A0
	ldr r0,[pool_02304294]	; 023041A2
	ldrh r1,[r4,r0]	; 023041A4
	add r0,r4,#0x0	; 023041A6
	add r0,#0x88	; 023041A8
	ldrh r0,[r0,#0x0]	; 023041AA
	cmp r0,#0x1	; 023041AC
	bne loc_023041B8	; 023041AE
	ldr r5,[pool_02304298]	; 023041B0
	add r0,r4,#0x0	; 023041B2
	add r0,#0x88	; 023041B4
	strh r6,[r0,#0x0]	; 023041B6
loc_023041B8:
	add r0,r4,#0x0	; 023041B8
	add r0,#0x9a	; 023041BA
	ldrh r0,[r0,#0x0]	; 023041BC
	cmp r0,#0x1	; 023041BE
	bne loc_023041CE	; 023041C0
	ldr r5,[pool_02304298]	; 023041C2
	mov r6,#0x1	; 023041C4
	mov r1,#0x0	; 023041C6
	add r0,r4,#0x0	; 023041C8
	add r0,#0x9a	; 023041CA
	strh r1,[r0,#0x0]	; 023041CC
loc_023041CE:
	add r0,sp,#0x24	; 023041CE
	str r0,[sp,#0x0]	; 023041D0
	add r0,sp,#0x24	; 023041D2
	add r0,#0x2	; 023041D4
	str r0,[sp,#0x4]	; 023041D6
	add r0,r5,#0x0	; 023041D8
	add r2,sp,#0x28	; 023041DA
	add r3,r7,#0x0	; 023041DC
	bl loc_02303E04	; 023041DE
	cmp r0,#0x1	; 023041E2
	beq loc_02304284	; 023041E4
	ldr r0,[pool_0230429C]	; 023041E6
	ldrh r0,[r4,r0]	; 023041E8
	add r0,r0,#0x2	; 023041EA
	lsl r0,r0,#0x10	; 023041EC
	lsr r0,r0,#0x10	; 023041EE
	str r0,[sp,#0x1c]	; 023041F0
	ldr r0,[pool_023042A0]	; 023041F2
	ldrh r0,[r0,#0x0]	; 023041F4
	str r0,[sp,#0x20]	; 023041F6
	ldrh r0,[r4,#0x3e]	; 023041F8
	cmp r0,#0x1	; 023041FA
	bne loc_0230421C	; 023041FC
	mov r0,#0x0	; 023041FE
	str r0,[sp,#0x18]	; 02304200
	add r0,sp,#0x24	; 02304202
	ldrh r0,[r0,#0x2]	; 02304204
	ldr r1,[sp,#0x1c]	; 02304206
	add r2,r5,#0x0	; 02304208
	bl loc_023038AC	; 0230420A
	add r2,r0,#0x0	; 0230420E
	add r3,sp,#0x24	; 02304210
	ldrh r1,[r3,#0x4]	; 02304212
	ldr r0,[pool_023042A4]	; 02304214
	orr r1,r0	; 02304216
	strh r1,[r3,#0x4]	; 02304218
	b loc_02304220	; 0230421A
loc_0230421C:
	mov r2,#0x0	; 0230421C
	str r2,[sp,#0x18]	; 0230421E
loc_02304220:
	add r0,r4,#0x0	; 02304220
	add r0,#0x92	; 02304222
	ldrh r0,[r0,#0x0]	; 02304224
	cmp r0,#0x1	; 02304226
	bne loc_0230425A	; 02304228
	cmp r6,#0x0	; 0230422A
	bne loc_0230423E	; 0230422C
	add r0,sp,#0x24	; 0230422E
	ldrh r1,[r0,#0x0]	; 02304230
	ldr r0,[pool_023042A8]	; 02304232
	ldrh r0,[r4,r0]	; 02304234
	and r1,r0	; 02304236
	lsl r0,r1,#0x10	; 02304238
	lsr r0,r0,#0x10	; 0230423A
	b loc_02304264	; 0230423C
loc_0230423E:
	ldr r0,[pool_023042A8]	; 0230423E
	ldrh r0,[r4,r0]	; 02304240
	mov r2,#0x0	; 02304242
	str r2,[sp,#0x1c]	; 02304244
	add r4,#0x3e	; 02304246
	ldrh r1,[r4,#0x0]	; 02304248
	add r1,r1,#0x1	; 0230424A
	strh r1,[r4,#0x0]	; 0230424C
	add r3,sp,#0x24	; 0230424E
	ldrh r4,[r3,#0x4]	; 02304250
	ldr r1,[pool_023042AC]	; 02304252
	and r4,r1	; 02304254
	strh r4,[r3,#0x4]	; 02304256
	b loc_02304264	; 02304258
loc_0230425A:
	ldr r0,[pool_023042A8]	; 0230425A
	ldrh r0,[r4,r0]	; 0230425C
	and r5,r0	; 0230425E
	lsl r0,r5,#0x10	; 02304260
	lsr r0,r0,#0x10	; 02304262
loc_02304264:
	str r0,[sp,#0x0]	; 02304264
	str r2,[sp,#0x4]	; 02304266
	ldr r0,[sp,#0x20]	; 02304268
	str r0,[sp,#0x8]	; 0230426A
	add r0,sp,#0x24	; 0230426C
	ldrh r1,[r0,#0x2]	; 0230426E
	str r1,[sp,#0xc]	; 02304270
	ldrh r0,[r0,#0x4]	; 02304272
	str r0,[sp,#0x10]	; 02304274
	str r7,[sp,#0x14]	; 02304276
	add r0,sp,#0x2c	; 02304278
	mov r1,#0x0	; 0230427A
	ldr r2,[sp,#0x18]	; 0230427C
	ldr r3,[sp,#0x1c]	; 0230427E
	bl loc_02301B08	; 02304280
loc_02304284:
	add sp,#0x1fc	; 02304284
	add sp,#0x30	; 02304286
	pop {r4,r5,r6,r7}	; 02304288
	pop {r3}	; 0230428A
	bx r3	; 0230428C
	.byte 0xC0, 0x46	; 02304290
pool_02304290:
loc_02304290:
	.word 0x00001518	; 02304290
pool_02304294:
loc_02304294:
	.word 0x0000018E	; 02304294
pool_02304298:
loc_02304298:
	.word 0x0000FFFF	; 02304298
pool_0230429C:
loc_0230429C:
	.word 0x00000190	; 0230429C
pool_023042A0:
loc_023042A0:
	.word REG_WIFI_US_COUNT0	; 023042A0
pool_023042A4:
loc_023042A4:
	.word 0x00008000	; 023042A4
pool_023042A8:
loc_023042A8:
	.word 0x0000017E	; 023042A8
pool_023042AC:
loc_023042AC:
	.word 0xFFFF7FFF	; 023042AC

; ===== function loc_023042B0 =====
loc_023042B0:
	push {r4,r5,lr}	; 023042B0
	sub sp,#0x1fc	; 023042B2
	sub sp,#0x18	; 023042B4
	bl loc_023008B4	; 023042B6
	ldr r1,[pool_02304314]	; 023042BA
	ldr r0,[r0,r1]	; 023042BC
	ldr r5,[r0,#0x0]	; 023042BE
	ldr r4,[r5,#0x50]	; 023042C0
	add r0,sp,#0x8	; 023042C2
	str r0,[sp,#0x0]	; 023042C4
	add r0,sp,#0x8	; 023042C6
	add r0,#0x2	; 023042C8
	str r0,[sp,#0x4]	; 023042CA
	mov r0,#0x1	; 023042CC
	ldr r1,[pool_02304318]	; 023042CE
	ldrh r1,[r5,r1]	; 023042D0
	add r2,sp,#0xc	; 023042D2
	add r3,r4,#0x0	; 023042D4
	bl loc_02303E04	; 023042D6
	cmp r0,#0x0	; 023042DA
	bne loc_02304308	; 023042DC
	ldr r0,[r5,#0x24]	; 023042DE
	cmp r0,#0x1	; 023042E0
	bne loc_023042EE	; 023042E2
	add r1,sp,#0x8	; 023042E4
	ldrh r2,[r1,#0x4]	; 023042E6
	ldr r0,[pool_0230431C]	; 023042E8
	orr r2,r0	; 023042EA
	strh r2,[r1,#0x4]	; 023042EC
loc_023042EE:
	add r0,sp,#0x10	; 023042EE
	add r2,sp,#0x8	; 023042F0
	ldrh r1,[r2,#0x2]	; 023042F2
	ldrh r2,[r2,#0x4]	; 023042F4
	add r3,r4,#0x0	; 023042F6
	bl loc_02301B68	; 023042F8
	ldrh r0,[r0,#0x4]	; 023042FC
	cmp r0,#0x0	; 023042FE
	bne loc_02304308	; 02304300
	mov r0,#0x1	; 02304302
	add r5,#0x8a	; 02304304
	strh r0,[r5,#0x0]	; 02304306
loc_02304308:
	add sp,#0x1fc	; 02304308
	add sp,#0x18	; 0230430A
	pop {r4,r5}	; 0230430C
	pop {r3}	; 0230430E
	bx r3	; 02304310
	.byte 0xC0, 0x46	; 02304314
pool_02304314:
loc_02304314:
	.word 0x00001518	; 02304314
pool_02304318:
loc_02304318:
	.word 0x0000018E	; 02304318
pool_0230431C:
loc_0230431C:
	.word 0x00008000	; 0230431C

; ===== function loc_02304320 =====
loc_02304320:
	push {r4,r5,r6,r7,lr}	; 02304320
	sub sp,#0x4	; 02304322
	bl loc_023008B4	; 02304324
	ldr r1,[pool_023043A8]	; 02304328
	ldr r0,[r0,r1]	; 0230432A
	ldr r4,[r0,#0x0]	; 0230432C
	ldr r0,[pool_023043AC]	; 0230432E
	add r0,r4,r0	; 02304330
	bl loc_02303CF0	; 02304332
	mov r1,#0x0	; 02304336
	add r0,sp,#0x0	; 02304338
	strh r1,[r0,#0x0]	; 0230433A
	ldrh r0,[r0,#0x0]	; 0230433C
	ldr r1,[pool_023043B0]	; 0230433E
	add r1,r4,r1	; 02304340
	ldr r2,[pool_023043B4]	; 02304342
	bl loc_023043D4	; 02304344
	mov r5,#0x0	; 02304348
	mov r1,#0x18	; 0230434A
	ldr r3,[pool_023043B0]	; 0230434C
loc_0230434E:
	add r0,r5,#0x1	; 0230434E
	lsl r0,r0,#0x10	; 02304350
	lsr r2,r0,#0x10	; 02304352
	mul r5,r1	; 02304354
	add r0,r4,r5	; 02304356
	strh r2,[r0,r3]	; 02304358
	add r5,r2,#0x0	; 0230435A
	cmp r2,#0x3f	; 0230435C
	bcc loc_0230434E	; 0230435E
	ldr r0,[pool_023043B8]	; 02304360
	mov r1,#0x18	; 02304362
	add r3,r2,#0x0	; 02304364
	mul r3,r1	; 02304366
	add r3,r4,r3	; 02304368
	ldr r1,[pool_023043B0]	; 0230436A
	strh r0,[r3,r1]	; 0230436C
	mov r1,#0x0	; 0230436E
	ldr r3,[pool_023043BC]	; 02304370
	strh r1,[r4,r3]	; 02304372
	ldr r3,[pool_023043C0]	; 02304374
	strh r2,[r4,r3]	; 02304376
	ldr r7,[pool_023043C4]	; 02304378
	ldr r2,[pool_023043C8]	; 0230437A
	ldr r3,[pool_023043CC]	; 0230437C
	ldr r5,[pool_023043D0]	; 0230437E
loc_02304380:
	lsl r6,r1,#0x2	; 02304380
	add r6,r4,r6	; 02304382
	strh r0,[r6,r7]	; 02304384
	strh r0,[r6,r2]	; 02304386
	strh r0,[r6,r3]	; 02304388
	strh r0,[r6,r5]	; 0230438A
	add r1,r1,#0x1	; 0230438C
	lsl r1,r1,#0x10	; 0230438E
	lsr r1,r1,#0x10	; 02304390
	cmp r1,#0x4	; 02304392
	bcc loc_02304380	; 02304394
	ldr r0,[pool_023043AC]	; 02304396
	add r0,r4,r0	; 02304398
	bl loc_02303D00	; 0230439A
	add sp,#0x4	; 0230439E
	pop {r4,r5,r6,r7}	; 023043A0
	pop {r3}	; 023043A2
	bx r3	; 023043A4
	.byte 0xC0, 0x46	; 023043A8
pool_023043A8:
loc_023043A8:
	.word 0x00001518	; 023043A8
pool_023043AC:
loc_023043AC:
	.word 0x00000918	; 023043AC
pool_023043B0:
loc_023043B0:
	.word 0x000002F4	; 023043B0
pool_023043B4:
loc_023043B4:
	.word 0x00000600	; 023043B4
pool_023043B8:
loc_023043B8:
	.word 0x0000FFFF	; 023043B8
pool_023043BC:
loc_023043BC:
	.word 0x000008F4	; 023043BC
pool_023043C0:
loc_023043C0:
	.word 0x000008F6	; 023043C0
pool_023043C4:
loc_023043C4:
	.word 0x00000908	; 023043C4
pool_023043C8:
loc_023043C8:
	.word 0x0000090A	; 023043C8
pool_023043CC:
loc_023043CC:
	.word 0x000008F8	; 023043CC
pool_023043D0:
loc_023043D0:
	.word 0x000008FA	; 023043D0

; ===== function loc_023043D4 =====
loc_023043D4:
	bx pc	; 023043D4
	.byte 0xC0, 0x46	; 023043D8
.arm

; ===== function loc_023043D8 =====
loc_023043D8:
	ldr pc,[pool_023043DC]	; 023043D8
pool_023043DC:
loc_023043DC:
	.word loc_037FCE04	; 023043DC
.thumb

; ===== function loc_023043E0 =====
	push {r4,r5,lr}	; 023043E0
	sub sp,#0x1fc	; 023043E2
	sub sp,#0x88	; 023043E4
	add r5,r0,#0x0	; 023043E6
	bl loc_023008B4	; 023043E8
	ldr r1,[pool_02304448]	; 023043EC
	ldr r0,[r0,r1]	; 023043EE
	ldr r4,[r0,#0x0]	; 023043F0
	ldr r1,[r5,#0x4]	; 023043F2
	add r0,r4,#0x0	; 023043F4
	add r0,#0xf0	; 023043F6
	strh r1,[r0,#0x0]	; 023043F8
	add r0,sp,#0x200	; 023043FA
	add r1,r4,#0x0	; 023043FC
	add r1,#0xe4	; 023043FE
	bl loc_023006DC	; 02304400
	add r0,sp,#0x0	; 02304404
	add r4,#0xe8	; 02304406
	ldrh r1,[r4,#0x0]	; 02304408
	add r1,#0x10	; 0230440A
	lsl r1,r1,#0x10	; 0230440C
	lsr r1,r1,#0x10	; 0230440E
	add r2,sp,#0x200	; 02304410
	bl loc_023019AC	; 02304412
	add r4,r0,#0x0	; 02304416
	bl loc_02300404	; 02304418
	mov r1,#0x21	; 0230441C
	strh r1,[r0,#0x0]	; 0230441E
	ldrh r1,[r4,#0x4]	; 02304420
	cmp r1,#0x0	; 02304422
	bne loc_0230442C	; 02304424
	mov r1,#0x0	; 02304426
	strh r1,[r0,#0x2]	; 02304428
	b loc_02304438	; 0230442A
loc_0230442C:
	mov r1,#0x1	; 0230442C
	strh r1,[r0,#0x2]	; 0230442E
	ldr r1,[pool_0230444C]	; 02304430
	strh r1,[r0,#0x4]	; 02304432
	ldrh r1,[r4,#0x4]	; 02304434
	strh r1,[r0,#0x6]	; 02304436
loc_02304438:
	bl loc_02300414	; 02304438
	add sp,#0x1fc	; 0230443C
	add sp,#0x88	; 0230443E
	pop {r4,r5}	; 02304440
	pop {r3}	; 02304442
	bx r3	; 02304444
	.byte 0xC0, 0x46	; 02304448
pool_02304448:
loc_02304448:
	.word 0x00001518	; 02304448
pool_0230444C:
loc_0230444C:
	.word 0x00000245	; 0230444C

; ===== function loc_02304450 =====
	push {r4,lr}	; 02304450
	sub sp,#0x1fc	; 02304452
	sub sp,#0xc	; 02304454
	add r0,r0,#0x4	; 02304456
	add r1,sp,#0x0	; 02304458
	mov r2,#0x6	; 0230445A
	bl loc_0230449C	; 0230445C
	add r0,sp,#0x8	; 02304460
	add r1,sp,#0x0	; 02304462
	mov r2,#0x13	; 02304464
	bl loc_02301D00	; 02304466
	add r4,r0,#0x0	; 0230446A
	bl loc_02300404	; 0230446C
	mov r1,#0x22	; 02304470
	strh r1,[r0,#0x0]	; 02304472
	ldrh r1,[r4,#0x4]	; 02304474
	cmp r1,#0x0	; 02304476
	bne loc_02304480	; 02304478
	mov r1,#0x0	; 0230447A
	strh r1,[r0,#0x2]	; 0230447C
	b loc_0230448C	; 0230447E
loc_02304480:
	mov r1,#0x1	; 02304480
	strh r1,[r0,#0x2]	; 02304482
	mov r1,#0x5	; 02304484
	strh r1,[r0,#0x4]	; 02304486
	ldrh r1,[r4,#0x4]	; 02304488
	strh r1,[r0,#0x6]	; 0230448A
loc_0230448C:
	bl loc_02300414	; 0230448C
	add sp,#0x1fc	; 02304490
	add sp,#0xc	; 02304492
	pop {r4}	; 02304494
	pop {r3}	; 02304496
	bx r3	; 02304498
	.byte 0xC0, 0x46	; 0230449C

; ===== function loc_0230449C =====
loc_0230449C:
	bx pc	; 0230449C
	.byte 0xC0, 0x46	; 023044A0
.arm

; ===== function loc_023044A0 =====
loc_023044A0:
	ldr pc,[pool_023044A4]	; 023044A0
pool_023044A4:
loc_023044A4:
	.word P2_Entry_037FCE1C	; 023044A4
.thumb

; ===== function loc_023044A8 =====
loc_023044A8:
	push {r4,lr}	; 023044A8
	sub sp,#0x8	; 023044AA
	bl loc_023008B4	; 023044AC
	ldr r1,[pool_02304514]	; 023044B0
	ldr r4,[r0,r1]	; 023044B2
	mov r0,#0x0	; 023044B4
	ldr r1,[r4,#0x0]	; 023044B6
	str r0,[r1,#0x10]	; 023044B8
	ldr r1,[r4,#0x0]	; 023044BA
	str r0,[r1,#0x18]	; 023044BC
	ldr r1,[r4,#0x0]	; 023044BE
	str r0,[r1,#0x14]	; 023044C0
	ldr r1,[r4,#0x0]	; 023044C2
	add r1,#0x92	; 023044C4
	strh r0,[r1,#0x0]	; 023044C6
	ldr r1,[r4,#0x0]	; 023044C8
	add r1,#0x94	; 023044CA
	strh r0,[r1,#0x0]	; 023044CC
	ldr r1,[r4,#0x0]	; 023044CE
	add r1,#0x96	; 023044D0
	strh r0,[r1,#0x0]	; 023044D2
	ldr r2,[r4,#0x0]	; 023044D4
	ldr r1,[pool_02304518]	; 023044D6
	strh r0,[r2,r1]	; 023044D8
	ldr r2,[r4,#0x0]	; 023044DA
	ldr r1,[pool_0230451C]	; 023044DC
	strh r0,[r2,r1]	; 023044DE
	mov r1,#0x1	; 023044E0
	add r0,sp,#0x0	; 023044E2
	strh r1,[r0,#0x0]	; 023044E4
	ldrh r0,[r0,#0x0]	; 023044E6
	ldr r2,[r4,#0x0]	; 023044E8
	ldr r1,[pool_02304520]	; 023044EA
	add r1,r2,r1	; 023044EC
	ldr r2,[pool_02304524]	; 023044EE
	bl loc_0230452C	; 023044F0
	ldr r0,[r4,#0x0]	; 023044F4
	add r0,#0x58	; 023044F6
	bl loc_02304538	; 023044F8
	ldr r1,[r4,#0x0]	; 023044FC
	ldr r0,[pool_02304528]	; 023044FE
	add r0,r1,r0	; 02304500
	bl loc_023009D0	; 02304502
	bl loc_02303734	; 02304506
	add sp,#0x8	; 0230450A
	pop {r4}	; 0230450C
	pop {r3}	; 0230450E
	bx r3	; 02304510
	.byte 0xC0, 0x46	; 02304514
pool_02304514:
loc_02304514:
	.word 0x00001518	; 02304514
pool_02304518:
loc_02304518:
	.word 0x0000018E	; 02304518
pool_0230451C:
loc_0230451C:
	.word 0x00000190	; 0230451C
pool_02304520:
loc_02304520:
	.word 0x000001F4	; 02304520
pool_02304524:
loc_02304524:
	.word 0x00000200	; 02304524
pool_02304528:
loc_02304528:
	.word 0x00000918	; 02304528

; ===== function loc_0230452C =====
loc_0230452C:
	bx pc	; 0230452C
	.byte 0xC0, 0x46	; 02304530
.arm

; ===== function loc_02304530 =====
loc_02304530:
	ldr pc,[pool_02304534]	; 02304530
pool_02304534:
loc_02304534:
	.word loc_037FCE04	; 02304534
.thumb

; ===== function loc_02304538 =====
loc_02304538:
	bx pc	; 02304538
	.byte 0xC0, 0x46	; 0230453C
.arm

; ===== function loc_0230453C =====
loc_0230453C:
	ldr r12,[pool_02304544]	; 0230453C
	bx r12	; 02304540
pool_02304544:
loc_02304544:
	.word loc_037FC778 + 1	; 02304544
.thumb

; ===== function loc_02304548 =====
	push {r4,r5,lr}	; 02304548
	sub sp,#0x4	; 0230454A
	add r5,r0,#0x0	; 0230454C
	bl loc_023008B4	; 0230454E
	ldr r2,[r5,#0x4]	; 02304552
	ldr r1,[pool_0230458C]	; 02304554
	add r0,r0,r1	; 02304556
	str r2,[r0,#0x0]	; 02304558
	ldr r4,[r0,#0x0]	; 0230455A
	ldr r0,[r5,#0x8]	; 0230455C
	str r0,[r4,#0x0]	; 0230455E
	ldr r0,[r5,#0xc]	; 02304560
	str r0,[r4,#0x8]	; 02304562
	bl loc_023044A8	; 02304564
	mov r0,#0xf	; 02304568
	bl loc_02301F90	; 0230456A
	mov r1,#0x1	; 0230456E
	ldr r0,[r4,#0x0]	; 02304570
	strh r1,[r0,#0x0]	; 02304572
	bl loc_02300404	; 02304574
	mov r1,#0x3	; 02304578
	strh r1,[r0,#0x0]	; 0230457A
	mov r1,#0x0	; 0230457C
	strh r1,[r0,#0x2]	; 0230457E
	bl loc_02300414	; 02304580
	add sp,#0x4	; 02304584
	pop {r4,r5}	; 02304586
	pop {r3}	; 02304588
	bx r3	; 0230458A
pool_0230458C:
loc_0230458C:
	.word 0x00001518	; 0230458C
	push {r4,lr}	; 02304590
	bl loc_023008B4	; 02304592
	ldr r1,[pool_023045D8]	; 02304596
	ldr r4,[r0,r1]	; 02304598
	ldr r0,[r4,#0x0]	; 0230459A
	ldrh r0,[r0,#0x0]	; 0230459C
	cmp r0,#0x1	; 0230459E
	beq loc_023045B4	; 023045A0
	bl loc_02300404	; 023045A2
	mov r1,#0x4	; 023045A6
	strh r1,[r0,#0x0]	; 023045A8
	mov r1,#0x3	; 023045AA
	strh r1,[r0,#0x2]	; 023045AC
	bl loc_02300414	; 023045AE
	b loc_023045D0	; 023045B2
loc_023045B4:
	mov r0,#0x1	; 023045B4
	bl loc_02301F90	; 023045B6
	mov r1,#0x0	; 023045BA
	ldr r0,[r4,#0x0]	; 023045BC
	strh r1,[r0,#0x0]	; 023045BE
	bl loc_02300404	; 023045C0
	mov r1,#0x4	; 023045C4
	strh r1,[r0,#0x0]	; 023045C6
	mov r1,#0x0	; 023045C8
	strh r1,[r0,#0x2]	; 023045CA
	bl loc_02300414	; 023045CC
loc_023045D0:
	pop {r4}	; 023045D0
	pop {r3}	; 023045D2
	bx r3	; 023045D4
	.byte 0xC0, 0x46	; 023045D8
pool_023045D8:
loc_023045D8:
	.word 0x00001518	; 023045D8

; ===== function loc_023045DC =====
loc_023045DC:
	mov r1,#0xc8	; 023045DC
	ldr r0,[pool_023045F0]	; 023045DE
	strh r1,[r0,#0x0]	; 023045E0
	ldr r1,[pool_023045F4]	; 023045E2
	ldr r0,[pool_023045F8]	; 023045E4
	strh r1,[r0,#0x0]	; 023045E6
	ldr r1,[pool_023045FC]	; 023045E8
	ldr r0,[pool_02304600]	; 023045EA
	strh r1,[r0,#0x0]	; 023045EC
	bx lr	; 023045EE
pool_023045F0:
loc_023045F0:
	.word REG_WIFI_CONFIG_124	; 023045F0
pool_023045F4:
loc_023045F4:
	.word 0x000007D0	; 023045F4
pool_023045F8:
loc_023045F8:
	.word REG_WIFI_CONFIG_128	; 023045F8
pool_023045FC:
loc_023045FC:
	.word 0x00000202	; 023045FC
pool_02304600:
loc_02304600:
	.word REG_WIFI_CONFIG_150	; 02304600

; ===== function loc_02304604 =====
loc_02304604:
	push {r4,r5,r6,r7,lr}	; 02304604
	sub sp,#0x1fc	; 02304606
	sub sp,#0x8	; 02304608
	add r5,r0,#0x0	; 0230460A
	add r6,r1,#0x0	; 0230460C
	bl loc_023008B4	; 0230460E
	ldr r1,[pool_0230471C]	; 02304612
	ldr r4,[r0,r1]	; 02304614
	add r0,sp,#0x0	; 02304616
	bl loc_0230193C	; 02304618
	ldrh r1,[r0,#0x4]	; 0230461C
	cmp r1,#0x0	; 0230461E
	beq loc_0230462E	; 02304620
	ldr r1,[pool_02304720]	; 02304622
	strh r1,[r5,#0x0]	; 02304624
	ldrh r0,[r0,#0x4]	; 02304626
	strh r0,[r6,#0x0]	; 02304628
	mov r0,#0x0	; 0230462A
	b loc_02304712	; 0230462C
loc_0230462E:
	add r0,sp,#0x0	; 0230462E
	bl loc_0230195C	; 02304630
	ldrh r1,[r0,#0x4]	; 02304634
	cmp r1,#0x0	; 02304636
	beq loc_02304646	; 02304638
	ldr r1,[pool_02304724]	; 0230463A
	strh r1,[r5,#0x0]	; 0230463C
	ldrh r0,[r0,#0x4]	; 0230463E
	strh r0,[r6,#0x0]	; 02304640
	mov r0,#0x0	; 02304642
	b loc_02304712	; 02304644
loc_02304646:
	bl loc_023045DC	; 02304646
	add r0,sp,#0x0	; 0230464A
	bl loc_0230198C	; 0230464C
	ldrh r1,[r0,#0x4]	; 02304650
	cmp r1,#0x0	; 02304652
	beq loc_02304662	; 02304654
	ldr r1,[pool_02304728]	; 02304656
	strh r1,[r5,#0x0]	; 02304658
	ldrh r0,[r0,#0x4]	; 0230465A
	strh r0,[r6,#0x0]	; 0230465C
	mov r0,#0x0	; 0230465E
	b loc_02304712	; 02304660
loc_02304662:
	ldrh r2,[r0,#0x6]	; 02304662
	ldr r1,[r4,#0x0]	; 02304664
	ldr r0,[pool_0230472C]	; 02304666
	strh r2,[r1,r0]	; 02304668
	lsl r0,r2,#0xf	; 0230466A
	lsr r0,r0,#0x10	; 0230466C
	bl loc_0230048C	; 0230466E
	ldr r2,[r4,#0x0]	; 02304672
	ldr r1,[pool_02304730]	; 02304674
	strh r0,[r2,r1]	; 02304676
	add r0,sp,#0x0	; 02304678
	ldr r1,[pool_02304734]	; 0230467A
	mov r2,#0x28	; 0230467C
	mov r3,#0x5	; 0230467E
	bl loc_02301A90	; 02304680
	mov r2,#0x2	; 02304684
	ldr r1,[r4,#0x0]	; 02304686
	ldr r0,[pool_02304738]	; 02304688
	strh r2,[r1,r0]	; 0230468A
	mov r2,#0x1	; 0230468C
	ldr r1,[r4,#0x0]	; 0230468E
	ldr r0,[pool_0230473C]	; 02304690
	strh r2,[r1,r0]	; 02304692
	add r0,sp,#0x0	; 02304694
	bl loc_0230191C	; 02304696
	add r7,r0,#0x0	; 0230469A
	ldrh r0,[r7,#0x4]	; 0230469C
	cmp r0,#0x0	; 0230469E
	beq loc_023046AE	; 023046A0
	ldr r0,[pool_02304740]	; 023046A2
	strh r0,[r5,#0x0]	; 023046A4
	ldrh r0,[r7,#0x4]	; 023046A6
	strh r0,[r6,#0x0]	; 023046A8
	mov r0,#0x0	; 023046AA
	b loc_02304712	; 023046AC
loc_023046AE:
	add r0,r7,#0x6	; 023046AE
	ldr r1,[r4,#0x0]	; 023046B0
	add r1,#0x28	; 023046B2
	mov r2,#0x8	; 023046B4
	bl loc_0230474C	; 023046B6
	ldrh r1,[r7,#0xe]	; 023046BA
	ldr r0,[r4,#0x0]	; 023046BC
	strh r1,[r0,#0x30]	; 023046BE
	ldrh r1,[r7,#0x10]	; 023046C0
	ldr r0,[r4,#0x0]	; 023046C2
	strh r1,[r0,#0x34]	; 023046C4
	ldrh r1,[r7,#0x12]	; 023046C6
	ldr r0,[r4,#0x0]	; 023046C8
	strh r1,[r0,#0x36]	; 023046CA
	ldrh r1,[r7,#0x14]	; 023046CC
	ldr r0,[r4,#0x0]	; 023046CE
	strh r1,[r0,#0x32]	; 023046D0
	add r0,sp,#0x0	; 023046D2
	bl loc_0230199C	; 023046D4
	add r1,r0,#0x0	; 023046D8
	ldrh r0,[r1,#0x4]	; 023046DA
	cmp r0,#0x0	; 023046DC
	beq loc_023046EC	; 023046DE
	ldr r0,[pool_02304744]	; 023046E0
	strh r0,[r5,#0x0]	; 023046E2
	ldrh r0,[r1,#0x4]	; 023046E4
	strh r0,[r6,#0x0]	; 023046E6
	mov r0,#0x0	; 023046E8
	b loc_02304712	; 023046EA
loc_023046EC:
	ldr r0,[r4,#0x0]	; 023046EC
	add r0,#0xdc	; 023046EE
	add r1,r1,#0x6	; 023046F0
	bl loc_023007BC	; 023046F2
	add r0,sp,#0x0	; 023046F6
	mov r1,#0x1	; 023046F8
	bl loc_02301A20	; 023046FA
	ldrh r1,[r0,#0x4]	; 023046FE
	cmp r1,#0x0	; 02304700
	beq loc_02304710	; 02304702
	ldr r1,[pool_02304748]	; 02304704
	strh r1,[r5,#0x0]	; 02304706
	ldrh r0,[r0,#0x4]	; 02304708
	strh r0,[r6,#0x0]	; 0230470A
	mov r0,#0x0	; 0230470C
	b loc_02304712	; 0230470E
loc_02304710:
	mov r0,#0x1	; 02304710
loc_02304712:
	add sp,#0x1fc	; 02304712
	add sp,#0x8	; 02304714
	pop {r4,r5,r6,r7}	; 02304716
	pop {r3}	; 02304718
	bx r3	; 0230471A
pool_0230471C:
loc_0230471C:
	.word 0x00001518	; 0230471C
pool_02304720:
loc_02304720:
	.word 0x00000304	; 02304720
pool_02304724:
loc_02304724:
	.word 0x00000302	; 02304724
pool_02304728:
loc_02304728:
	.word 0x00000283	; 02304728
pool_0230472C:
loc_0230472C:
	.word 0x000001F0	; 0230472C
pool_02304730:
loc_02304730:
	.word 0x000001F2	; 02304730
pool_02304734:
loc_02304734:
	.word 0x0000FFFF	; 02304734
pool_02304738:
loc_02304738:
	.word 0x000001E8	; 02304738
pool_0230473C:
loc_0230473C:
	.word 0x000001EA	; 0230473C
pool_02304740:
loc_02304740:
	.word 0x00000306	; 02304740
pool_02304744:
loc_02304744:
	.word 0x00000281	; 02304744
pool_02304748:
loc_02304748:
	.word 0x00000215	; 02304748

; ===== function loc_0230474C =====
loc_0230474C:
	bx pc	; 0230474C
	.byte 0xC0, 0x46	; 02304750
.arm

; ===== function loc_02304750 =====
loc_02304750:
	ldr pc,[pool_02304754]	; 02304750
pool_02304754:
loc_02304754:
	.word P2_Entry_037FCE1C	; 02304754
.thumb

; ===== function loc_02304758 =====
	push {r4,lr}	; 02304758
	sub sp,#0x8	; 0230475A
	bl loc_023008B4	; 0230475C
	ldr r1,[pool_023047C8]	; 02304760
	ldr r4,[r0,r1]	; 02304762
	ldr r0,[r4,#0x0]	; 02304764
	ldrh r0,[r0,#0x0]	; 02304766
	cmp r0,#0x1	; 02304768
	beq loc_0230477E	; 0230476A
	bl loc_02300404	; 0230476C
	mov r1,#0x5	; 02304770
	strh r1,[r0,#0x0]	; 02304772
	mov r1,#0x3	; 02304774
	strh r1,[r0,#0x2]	; 02304776
	bl loc_02300414	; 02304778
	b loc_023047BE	; 0230477C
loc_0230477E:
	add r0,sp,#0x0	; 0230477E
	add r1,sp,#0x0	; 02304780
	add r1,#0x2	; 02304782
	bl loc_02304604	; 02304784
	cmp r0,#0x0	; 02304788
	bne loc_023047A8	; 0230478A
	bl loc_02300404	; 0230478C
	mov r1,#0x5	; 02304790
	strh r1,[r0,#0x0]	; 02304792
	mov r1,#0x1	; 02304794
	strh r1,[r0,#0x2]	; 02304796
	add r1,sp,#0x0	; 02304798
	ldrh r2,[r1,#0x0]	; 0230479A
	strh r2,[r0,#0x4]	; 0230479C
	ldrh r1,[r1,#0x2]	; 0230479E
	strh r1,[r0,#0x6]	; 023047A0
	bl loc_02300414	; 023047A2
	b loc_023047BE	; 023047A6
loc_023047A8:
	mov r1,#0x2	; 023047A8
	ldr r0,[r4,#0x0]	; 023047AA
	strh r1,[r0,#0x0]	; 023047AC
	bl loc_02300404	; 023047AE
	mov r1,#0x5	; 023047B2
	strh r1,[r0,#0x0]	; 023047B4
	mov r1,#0x0	; 023047B6
	strh r1,[r0,#0x2]	; 023047B8
	bl loc_02300414	; 023047BA
loc_023047BE:
	add sp,#0x8	; 023047BE
	pop {r4}	; 023047C0
	pop {r3}	; 023047C2
	bx r3	; 023047C4
	.byte 0xC0, 0x46	; 023047C8
pool_023047C8:
loc_023047C8:
	.word 0x00001518	; 023047C8

; ===== function loc_023047CC =====
	push {r4,r5,lr}	; 023047CC
	sub sp,#0x1fc	; 023047CE
	sub sp,#0x8	; 023047D0
	bl loc_023008B4	; 023047D2
	ldr r1,[pool_0230483C]	; 023047D6
	ldr r5,[r0,r1]	; 023047D8
	ldr r0,[r5,#0x0]	; 023047DA
	ldrh r0,[r0,#0x0]	; 023047DC
	cmp r0,#0x2	; 023047DE
	beq loc_023047F4	; 023047E0
	bl loc_02300404	; 023047E2
	mov r1,#0x6	; 023047E6
	strh r1,[r0,#0x0]	; 023047E8
	mov r1,#0x3	; 023047EA
	strh r1,[r0,#0x2]	; 023047EC
	bl loc_02300414	; 023047EE
	b loc_02304832	; 023047F2
loc_023047F4:
	add r0,sp,#0x0	; 023047F4
	bl loc_0230196C	; 023047F6
	add r4,r0,#0x0	; 023047FA
	ldrh r0,[r4,#0x4]	; 023047FC
	cmp r0,#0x0	; 023047FE
	beq loc_0230481C	; 02304800
	bl loc_02300404	; 02304802
	mov r1,#0x6	; 02304806
	strh r1,[r0,#0x0]	; 02304808
	mov r1,#0x1	; 0230480A
	strh r1,[r0,#0x2]	; 0230480C
	ldr r1,[pool_02304840]	; 0230480E
	strh r1,[r0,#0x4]	; 02304810
	ldrh r1,[r4,#0x4]	; 02304812
	strh r1,[r0,#0x6]	; 02304814
	bl loc_02300414	; 02304816
	b loc_02304832	; 0230481A
loc_0230481C:
	mov r1,#0x1	; 0230481C
	ldr r0,[r5,#0x0]	; 0230481E
	strh r1,[r0,#0x0]	; 02304820
	bl loc_02300404	; 02304822
	mov r1,#0x6	; 02304826
	strh r1,[r0,#0x0]	; 02304828
	mov r1,#0x0	; 0230482A
	strh r1,[r0,#0x2]	; 0230482C
	bl loc_02300414	; 0230482E
loc_02304832:
	add sp,#0x1fc	; 02304832
	add sp,#0x8	; 02304834
	pop {r4,r5}	; 02304836
	pop {r3}	; 02304838
	bx r3	; 0230483A
pool_0230483C:
loc_0230483C:
	.word 0x00001518	; 0230483C
pool_02304840:
loc_02304840:
	.word 0x00000301	; 02304840

; ===== function loc_02304844 =====
	push {r4,r5,lr}	; 02304844
	sub sp,#0x4	; 02304846
	add r4,r0,#0x0	; 02304848
	bl loc_023008B4	; 0230484A
	ldr r1,[pool_0230488C]	; 0230484E
	ldr r0,[r0,r1]	; 02304850
	ldr r5,[r0,#0x0]	; 02304852
	ldr r0,[r4,#0x4]	; 02304854
	lsl r0,r0,#0x10	; 02304856
	lsr r4,r0,#0x10	; 02304858
	cmp r4,#0x0	; 0230485A
	bne loc_02304860	; 0230485C
	mov r4,#0x10	; 0230485E
loc_02304860:
	bl loc_02304890	; 02304860
	strh r4,[r5,#0x3c]	; 02304864
	ldrh r1,[r5,#0x3e]	; 02304866
	cmp r1,r4	; 02304868
	bls loc_0230486E	; 0230486A
	strh r4,[r5,#0x3e]	; 0230486C
loc_0230486E:
	bl loc_0230489C	; 0230486E
	bl loc_02300404	; 02304872
	mov r1,#0x23	; 02304876
	strh r1,[r0,#0x0]	; 02304878
	mov r1,#0x0	; 0230487A
	strh r1,[r0,#0x2]	; 0230487C
	bl loc_02300414	; 0230487E
	add sp,#0x4	; 02304882
	pop {r4,r5}	; 02304884
	pop {r3}	; 02304886
	bx r3	; 02304888
	.byte 0xC0, 0x46	; 0230488C
pool_0230488C:
loc_0230488C:
	.word 0x00001518	; 0230488C

; ===== function loc_02304890 =====
loc_02304890:
	bx pc	; 02304890
	.byte 0xC0, 0x46	; 02304894
.arm

; ===== function loc_02304894 =====
loc_02304894:
	ldr pc,[pool_02304898]	; 02304894
pool_02304898:
loc_02304898:
	.word loc_037FCBF0	; 02304898
.thumb

; ===== function loc_0230489C =====
loc_0230489C:
	bx pc	; 0230489C
	.byte 0xC0, 0x46	; 023048A0
.arm

; ===== function loc_023048A0 =====
loc_023048A0:
	ldr pc,[pool_023048A4]	; 023048A0
pool_023048A4:
loc_023048A4:
	.word loc_037FCC04	; 023048A4
.thumb
	mov r1,#0x1	; 023048A8
	ldr r3,[pool_023048B0]	; 023048AA
	bx r3	; 023048AC
	.byte 0xC0, 0x46	; 023048B0
pool_023048B0:
loc_023048B0:
	.word loc_02302B2C + 1	; 023048B0

; ===== function loc_023048B4 =====
loc_023048B4:
; 保存参数中的无线工作区指针，初始化状态并开启 Wi-Fi 总线。
; Stores the supplied wireless work pointer, initializes state and enables the Wi-Fi bus.
.func P4_InitializeWirelessWork
	push {r4,r5,lr}	; 023048B4
	sub sp,#0x14	; 023048B6
	add r4,r0,#0x0	; 023048B8
	ldr r1,[r4,#0x0]	; 023048BA
	ldr r0,[pool_023049F0]	; 023048BC
	str r1,[r0,#0x0]	; 023048BE
	mov r0,#0x0	; 023048C0
	str r0,[sp,#0xc]	; 023048C2
	ldr r0,[sp,#0xc]	; 023048C4
	ldr r2,[pool_023049F4]	; 023048C6
	bl loc_02304A28	; 023048C8
	bl loc_02304A34	; 023048CC
	ldr r1,[pool_023049F0]	; 023048D0
	ldr r3,[r1,#0x0]	; 023048D2
	ldr r2,[pool_023049F8]	; 023048D4
	str r0,[r3,r2]	; 023048D6
	ldr r3,[r4,#0x18]	; 023048D8
	ldr r2,[r1,#0x0]	; 023048DA
	ldr r0,[pool_023049FC]	; 023048DC
	str r3,[r2,r0]	; 023048DE
	ldr r0,[r4,#0x1c]	; 023048E0
	lsr r3,r0,#0x1	; 023048E2
	ldr r2,[r1,#0x0]	; 023048E4
	ldr r0,[pool_02304A00]	; 023048E6
	str r3,[r2,r0]	; 023048E8
	ldr r1,[r1,#0x0]	; 023048EA
	add r1,r1,r0	; 023048EC
	ldr r0,[r1,#0x0]	; 023048EE
	cmp r0,#0x0	; 023048F0
	bne loc_023048FA	; 023048F2
	mov r0,#0x0	; 023048F4
	mvn r0,r0	; 023048F6
	str r0,[r1,#0x0]	; 023048F8
loc_023048FA:
	add r0,r4,#0x0	; 023048FA
	add r0,#0x20	; 023048FC
	bl loc_02304D6C	; 023048FE
	bl loc_023100B8	; 02304902
	ldr r2,[pool_02304A04]	; 02304906
	ldrh r0,[r2,#0x0]	; 02304908
	mov r1,#0x2	; 0230490A
	orr r0,r1	; 0230490C
	strh r0,[r2,#0x0]	; 0230490E
	mov r2,#0x30	; 02304910
	ldr r0,[pool_02304A08]	; 02304912
	strh r2,[r0,#0x0]	; 02304914
	mov r5,#0x3	; 02304916
	ldr r3,[pool_023049F0]	; 02304918
	ldr r2,[r3,#0x0]	; 0230491A
	ldr r0,[pool_02304A0C]	; 0230491C
	str r5,[r2,r0]	; 0230491E
	mov r0,#0x3c	; 02304920
	ldr r3,[r3,#0x0]	; 02304922
	ldr r2,[pool_02304A10]	; 02304924
	add r2,r3,r2	; 02304926
	bl loc_02310198	; 02304928
	mov r0,#0x3e	; 0230492C
	mov r1,#0x2	; 0230492E
	ldr r2,[pool_023049F0]	; 02304930
	ldr r3,[r2,#0x0]	; 02304932
	ldr r2,[pool_02304A14]	; 02304934
	add r2,r3,r2	; 02304936
	bl loc_02310198	; 02304938
	ldr r2,[r4,#0x10]	; 0230493C
	ldr r3,[pool_023049F0]	; 0230493E
	ldr r1,[r3,#0x0]	; 02304940
	ldr r0,[pool_02304A18]	; 02304942
	str r2,[r1,r0]	; 02304944
	ldr r2,[r4,#0x14]	; 02304946
	ldr r1,[r3,#0x0]	; 02304948
	ldr r0,[pool_02304A1C]	; 0230494A
	str r2,[r1,r0]	; 0230494C
	ldr r0,[r4,#0x30]	; 0230494E
	mov r1,#0x1c	; 02304950
	bl loc_02304A40	; 02304952
	add r1,r0,#0x0	; 02304956
	ldr r0,[r4,#0x2c]	; 02304958
	bl loc_0230733C	; 0230495A
	bl loc_02304C80	; 0230495E
	bl loc_02309518	; 02304962
	bl loc_023097F8	; 02304966
	bl loc_02308E18	; 0230496A
	bl loc_023057CC	; 0230496E
	add r0,sp,#0x8	; 02304972
	bl loc_0231020C	; 02304974
	cmp r0,#0x0	; 02304978
	beq loc_0230498E	; 0230497A
	ldr r0,[pool_023049F0]	; 0230497C
	ldr r1,[r0,#0x0]	; 0230497E
	ldr r0,[pool_02304A20]	; 02304980
	add r2,r1,r0	; 02304982
	ldrh r1,[r2,#0x0]	; 02304984
	mov r0,#0x80	; 02304986
	orr r1,r0	; 02304988
	strh r1,[r2,#0x0]	; 0230498A
	b loc_023049BA	; 0230498C
loc_0230498E:
	bl loc_023059A8	; 0230498E
	bl loc_0230766C	; 02304992
	bl loc_02306744	; 02304996
	bl loc_02305980	; 0230499A
	bl loc_02305828	; 0230499E
	bl loc_023075F4	; 023049A2
	bl loc_023075A0	; 023049A6
	bl loc_023073CC	; 023049AA
	bl loc_02305940	; 023049AE
	bl loc_02306AEC	; 023049B2
	bl loc_023067AC	; 023049B6
loc_023049BA:
	ldr r0,[r4,#0x8]	; 023049BA
	str r0,[sp,#0x0]	; 023049BC
	ldr r0,[r4,#0xc]	; 023049BE
	str r0,[sp,#0x4]	; 023049C0
	ldr r0,[pool_023049F0]	; 023049C2
	ldr r0,[r0,#0x0]	; 023049C4
	add r0,#0x18	; 023049C6
	ldr r1,[pool_02304A24]	; 023049C8
	mov r2,#0x0	; 023049CA
	ldr r3,[r4,#0x4]	; 023049CC
	bl loc_023009E0	; 023049CE
	ldr r0,[pool_023049F0]	; 023049D2
	ldr r0,[r0,#0x0]	; 023049D4
	add r0,#0x18	; 023049D6
	bl loc_023009F0	; 023049D8
	bl loc_02307720	; 023049DC
	ldr r0,[pool_023049F0]	; 023049E0
	ldr r1,[r0,#0x0]	; 023049E2
	ldr r0,[pool_02304A20]	; 023049E4
	ldrh r0,[r1,r0]	; 023049E6
	add sp,#0x14	; 023049E8
	pop {r4,r5}	; 023049EA
	pop {r3}	; 023049EC
	bx r3	; 023049EE
.endfunc
pool_023049F0:
loc_023049F0:
	.word FirmwareWlWorkPointerSlot	; 023049F0
pool_023049F4:
loc_023049F4:
	.word 0x00000678	; 023049F4
pool_023049F8:
loc_023049F8:
	.word 0x000002D8	; 023049F8
pool_023049FC:
loc_023049FC:
	.word 0x000002D0	; 023049FC
pool_02304A00:
loc_02304A00:
	.word 0x000002D4	; 02304A00
pool_02304A04:
loc_02304A04:
	.word REG_POWERCNT_ARM7	; 02304A04
pool_02304A08:
loc_02304A08:
	.word REG_WIFIWAITCNT_ARM7	; 02304A08
pool_02304A0C:
loc_02304A0C:
	.word 0x00000618	; 02304A0C
pool_02304A10:
loc_02304A10:
	.word 0x0000061E	; 02304A10
pool_02304A14:
loc_02304A14:
	.word 0x0000061C	; 02304A14
pool_02304A18:
loc_02304A18:
	.word 0x000002CC	; 02304A18
pool_02304A1C:
loc_02304A1C:
	.word 0x000002C8	; 02304A1C
pool_02304A20:
loc_02304A20:
	.word 0x00000302	; 02304A20
pool_02304A24:
loc_02304A24:
	.word P4_ThreadEntry_02304BF4 + 1	; 02304A24

; ===== function loc_02304A28 =====
loc_02304A28:
	bx pc	; 02304A28
	.byte 0xC0, 0x46	; 02304A2C
.arm

; ===== function loc_02304A2C =====
loc_02304A2C:
	ldr pc,[pool_02304A30]	; 02304A2C
pool_02304A30:
loc_02304A30:
	.word P2_Entry_037FCE64	; 02304A30
.thumb

; ===== function loc_02304A34 =====
loc_02304A34:
	bx pc	; 02304A34
	.byte 0xC0, 0x46	; 02304A38
.arm

; ===== function loc_02304A38 =====
loc_02304A38:
	ldr pc,[pool_02304A3C]	; 02304A38
pool_02304A3C:
loc_02304A3C:
	.word loc_037FB6B4	; 02304A3C
.thumb

; ===== function loc_02304A40 =====
loc_02304A40:
	bx pc	; 02304A40
	.byte 0xC0, 0x46	; 02304A44
.arm

; ===== function loc_02304A44 =====
loc_02304A44:
	ldr pc,[pool_02304A48]	; 02304A44
pool_02304A48:
loc_02304A48:
	.word loc_03802720	; 02304A48
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xF0, 0x9C, 0xFD, 0x01, 0xF0, 0xAA, 0xFE, 0x00, 0xF0, 0x92, 0xFF	; 02304A5C
	.byte 0x00, 0xF0, 0x5A, 0xF9, 0x00, 0xF0, 0x0E, 0xF9, 0x09, 0x48, 0x02, 0x68, 0x09, 0x48, 0x10, 0x58	; 02304A6C
	.byte 0x09, 0x49, 0x51, 0x5A, 0x02, 0xF0, 0x64, 0xFC, 0x04, 0xF0, 0x50, 0xFD, 0x04, 0xF0, 0xBE, 0xFE	; 02304A7C
	.byte 0x04, 0xF0, 0xCC, 0xF9, 0x02, 0xF0, 0x34, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02304A8C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xE0, 0x02, 0x00, 0x00, 0xE4, 0x02, 0x00, 0x00	; 02304A98
.thumb

; ===== function loc_02304A98 =====
loc_02304A98:
	push {lr}	; 02304A98
	sub sp,#0x4	; 02304A9A
	ldr r1,[r0,#0x0]	; 02304A9C
	cmp r1,#0x0	; 02304A9E
	beq loc_02304AB6	; 02304AA0
	ldr r0,[pool_02304ABC]	; 02304AA2
	ldr r2,[r0,#0x0]	; 02304AA4
	ldr r0,[pool_02304AC0]	; 02304AA6
	add r0,r2,r0	; 02304AA8
	bl loc_02304F54	; 02304AAA
	mov r0,#0x2	; 02304AAE
	mov r1,#0xb	; 02304AB0
	bl loc_02304B68	; 02304AB2
loc_02304AB6:
	add sp,#0x4	; 02304AB6
	pop {r3}	; 02304AB8
	bx r3	; 02304ABA
pool_02304ABC:
loc_02304ABC:
	.word FirmwareWlWorkPointerSlot	; 02304ABC
pool_02304AC0:
loc_02304AC0:
	.word 0x000001C4	; 02304AC0

; ===== function loc_02304AC4 =====
	push {lr}	; 02304AC4
	sub sp,#0x4	; 02304AC6
	ldr r0,[pool_02304AEC]	; 02304AC8
	ldr r1,[r0,#0x0]	; 02304ACA
	ldr r0,[pool_02304AF0]	; 02304ACC
	ldr r0,[r1,r0]	; 02304ACE
	add r1,sp,#0x0	; 02304AD0
	mov r2,#0x1	; 02304AD2
	bl loc_02300884	; 02304AD4
	add r0,sp,#0x0	; 02304AD8
	bl loc_02304A98	; 02304ADA
	mov r0,#0x3	; 02304ADE
	mov r1,#0xc	; 02304AE0
	bl loc_02304B68	; 02304AE2
	add sp,#0x4	; 02304AE6
	pop {r3}	; 02304AE8
	bx r3	; 02304AEA
pool_02304AEC:
loc_02304AEC:
	.word FirmwareWlWorkPointerSlot	; 02304AEC
pool_02304AF0:
loc_02304AF0:
	.word 0x000002CC	; 02304AF0

; ===== function loc_02304AF4 =====
loc_02304AF4:
	push {r4,r5,r6,r7,lr}	; 02304AF4
	sub sp,#0x4	; 02304AF6
	add r4,r0,#0x0	; 02304AF8
	ldr r0,[pool_02304B3C]	; 02304AFA
	ldr r5,[r0,#0x0]	; 02304AFC
	ldr r0,[pool_02304B40]	; 02304AFE
	bl loc_02304B48	; 02304B00
	add r7,r0,#0x0	; 02304B04
	lsl r0,r4,#0x1	; 02304B06
	add r6,r5,r0	; 02304B08
	ldrh r4,[r5,r0]	; 02304B0A
	ldr r0,[pool_02304B44]	; 02304B0C
	cmp r4,r0	; 02304B0E
	beq loc_02304B2C	; 02304B10
	add r5,#0x90	; 02304B12
	lsl r3,r4,#0x3	; 02304B14
	mov r2,#0x0	; 02304B16
	add r1,r5,r3	; 02304B18
	strh r2,[r1,#0x2]	; 02304B1A
	ldrh r1,[r5,r3]	; 02304B1C
	cmp r1,r0	; 02304B1E
	bne loc_02304B28	; 02304B20
	strh r0,[r6,#0x0]	; 02304B22
	strh r0,[r6,#0x8]	; 02304B24
	b loc_02304B2C	; 02304B26
loc_02304B28:
	strh r1,[r6,#0x0]	; 02304B28
	strh r0,[r5,r3]	; 02304B2A
loc_02304B2C:
	add r0,r7,#0x0	; 02304B2C
	bl loc_02304B58	; 02304B2E
	add r0,r4,#0x0	; 02304B32
	add sp,#0x4	; 02304B34
	pop {r4,r5,r6,r7}	; 02304B36
	pop {r3}	; 02304B38
	bx r3	; 02304B3A
pool_02304B3C:
loc_02304B3C:
	.word FirmwareWlWorkPointerSlot	; 02304B3C
pool_02304B40:
loc_02304B40:
	.word 0x01000010	; 02304B40
pool_02304B44:
loc_02304B44:
	.word 0x0000FFFF	; 02304B44

; ===== function loc_02304B48 =====
loc_02304B48:
	bx pc	; 02304B48
	.byte 0xC0, 0x46	; 02304B4C
.arm

; ===== function loc_02304B4C =====
loc_02304B4C:
	ldr r12,[pool_02304B54]	; 02304B4C
	bx r12	; 02304B50
pool_02304B54:
loc_02304B54:
	.word loc_037FB570 + 1	; 02304B54
.thumb

; ===== function loc_02304B58 =====
loc_02304B58:
	bx pc	; 02304B58
	.byte 0xC0, 0x46	; 02304B5C
.arm

; ===== function loc_02304B5C =====
loc_02304B5C:
	ldr r12,[pool_02304B64]	; 02304B5C
	bx r12	; 02304B60
pool_02304B64:
loc_02304B64:
	.word loc_037FB59C + 1	; 02304B64
.thumb

; ===== function loc_02304B68 =====
loc_02304B68:
	push {r4,r5,r6,r7,lr}	; 02304B68
	sub sp,#0x4	; 02304B6A
	add r5,r0,#0x0	; 02304B6C
	add r6,r1,#0x0	; 02304B6E
	ldr r0,[pool_02304BE4]	; 02304B70
	ldr r4,[r0,#0x0]	; 02304B72
	add r7,r4,#0x0	; 02304B74
	add r7,#0x90	; 02304B76
	ldr r0,[pool_02304BE8]	; 02304B78
	bl loc_02304B48	; 02304B7A
	str r0,[sp,#0x0]	; 02304B7E
	lsl r1,r6,#0x3	; 02304B80
	add r2,r7,#0x2	; 02304B82
	add r0,r2,r1	; 02304B84
	ldrh r2,[r2,r1]	; 02304B86
	cmp r2,#0x0	; 02304B88
	bne loc_02304BBA	; 02304B8A
	mov r2,#0x1	; 02304B8C
	strh r2,[r0,#0x0]	; 02304B8E
	ldr r0,[pool_02304BEC]	; 02304B90
	strh r0,[r7,r1]	; 02304B92
	lsl r0,r5,#0x1	; 02304B94
	add r2,r4,#0x0	; 02304B96
	add r2,#0x8	; 02304B98
	add r1,r2,r0	; 02304B9A
	ldrh r3,[r2,r0]	; 02304B9C
	ldr r2,[pool_02304BEC]	; 02304B9E
	cmp r3,r2	; 02304BA0
	bne loc_02304BA8	; 02304BA2
	strh r6,[r4,r0]	; 02304BA4
	b loc_02304BB0	; 02304BA6
loc_02304BA8:
	lsl r0,r3,#0x3	; 02304BA8
	add r0,r4,r0	; 02304BAA
	add r0,#0x90	; 02304BAC
	strh r6,[r0,#0x0]	; 02304BAE
loc_02304BB0:
	strh r6,[r1,#0x0]	; 02304BB0
	ldrh r0,[r4,#0x10]	; 02304BB2
	cmp r5,r0	; 02304BB4
	bge loc_02304BBA	; 02304BB6
	strh r5,[r4,#0x10]	; 02304BB8
loc_02304BBA:
	ldr r0,[sp,#0x0]	; 02304BBA
	bl loc_02304B58	; 02304BBC
	cmp r5,#0x3	; 02304BC0
	beq loc_02304BDA	; 02304BC2
	ldrh r0,[r4,#0x12]	; 02304BC4
	cmp r0,#0x3	; 02304BC6
	bne loc_02304BDA	; 02304BC8
	ldr r0,[pool_02304BE4]	; 02304BCA
	ldr r1,[r0,#0x0]	; 02304BCC
	ldr r0,[pool_02304BF0]	; 02304BCE
	ldr r0,[r1,r0]	; 02304BD0
	mov r1,#0x0	; 02304BD2
	add r2,r1,#0x0	; 02304BD4
	bl loc_02300824	; 02304BD6
loc_02304BDA:
	add sp,#0x4	; 02304BDA
	pop {r4,r5,r6,r7}	; 02304BDC
	pop {r3}	; 02304BDE
	bx r3	; 02304BE0
	.byte 0xC0, 0x46	; 02304BE4
pool_02304BE4:
loc_02304BE4:
	.word FirmwareWlWorkPointerSlot	; 02304BE4
pool_02304BE8:
loc_02304BE8:
	.word 0x01000010	; 02304BE8
pool_02304BEC:
loc_02304BEC:
	.word 0x0000FFFF	; 02304BEC
pool_02304BF0:
loc_02304BF0:
	.word 0x000002CC	; 02304BF0

; ===== function loc_02304BF4 =====
P4_ThreadEntry_02304BF4:
	push {r4,r5,r6,r7,lr}	; 02304BF4
	sub sp,#0x4	; 02304BF6
	ldr r6,[pool_02304C60]	; 02304BF8
	ldr r5,[r6,#0x0]	; 02304BFA
	mov r0,#0x0	; 02304BFC
	strh r0,[r5,#0x10]	; 02304BFE
	strh r0,[r5,#0x14]	; 02304C00
	ldr r4,[pool_02304C64]	; 02304C02
	ldr r7,[pool_02304C68]	; 02304C04
loc_02304C06:
	ldr r0,[r6,#0x0]	; 02304C06
	ldr r0,[r0,r7]	; 02304C08
	add r1,sp,#0x0	; 02304C0A
	mov r2,#0x0	; 02304C0C
	bl loc_02300884	; 02304C0E
	cmp r0,#0x0	; 02304C12
	beq loc_02304C1C	; 02304C14
	add r0,sp,#0x0	; 02304C16
	bl loc_02304A98	; 02304C18
loc_02304C1C:
	ldr r0,[pool_02304C6C]	; 02304C1C
	bl loc_02304B48	; 02304C1E
	ldrh r1,[r5,#0x10]	; 02304C22
	strh r1,[r5,#0x12]	; 02304C24
	ldrh r1,[r5,#0x12]	; 02304C26
	lsl r1,r1,#0x1	; 02304C28
	ldrh r1,[r5,r1]	; 02304C2A
	cmp r1,r4	; 02304C2C
	bne loc_02304C40	; 02304C2E
	add r1,r5,#0x0	; 02304C30
	add r1,#0x10	; 02304C32
	ldrh r2,[r1,#0x0]	; 02304C34
	add r2,r2,#0x1	; 02304C36
	strh r2,[r1,#0x0]	; 02304C38
	bl loc_02304B58	; 02304C3A
	b loc_02304C06	; 02304C3E
loc_02304C40:
	bl loc_02304B58	; 02304C40
	ldrh r0,[r5,#0x12]	; 02304C44
	bl loc_02304AF4	; 02304C46
	strh r0,[r5,#0x14]	; 02304C4A
	ldrh r0,[r5,#0x14]	; 02304C4C
	lsl r0,r0,#0x3	; 02304C4E
	add r0,r5,r0	; 02304C50
	add r0,#0x94	; 02304C52
	ldr r0,[r0,#0x0]	; 02304C54
	bl loc_02304C70	; 02304C56
	strh r4,[r5,#0x14]	; 02304C5A
	b loc_02304C06	; 02304C5C
	.byte 0xC0, 0x46	; 02304C60
pool_02304C60:
loc_02304C60:
	.word FirmwareWlWorkPointerSlot	; 02304C60
pool_02304C64:
loc_02304C64:
	.word 0x0000FFFF	; 02304C64
pool_02304C68:
loc_02304C68:
	.word 0x000002CC	; 02304C68
pool_02304C6C:
loc_02304C6C:
	.word 0x01000010	; 02304C6C

; ===== function loc_02304C70 =====
loc_02304C70:
	bx pc	; 02304C70
	.byte 0xC0, 0x46	; 02304C74
.arm

; ===== function loc_02304C74 =====
loc_02304C74:
	ldr r12,[pool_02304C7C]	; 02304C74
	bx r12	; 02304C78
pool_02304C7C:
loc_02304C7C:
	.word loc_038029F4 + 1	; 02304C7C
.thumb

; ===== function loc_02304C80 =====
loc_02304C80:
	push {r4,r5,r6,lr}	; 02304C80
	ldr r0,[pool_02304CD4]	; 02304C82
	ldr r5,[r0,#0x0]	; 02304C84
	mov r3,#0x0	; 02304C86
	strh r3,[r5,#0x10]	; 02304C88
	strh r3,[r5,#0x12]	; 02304C8A
	ldr r1,[pool_02304CD8]	; 02304C8C
loc_02304C8E:
	lsl r2,r3,#0x1	; 02304C8E
	add r0,r5,r2	; 02304C90
	strh r1,[r0,#0x8]	; 02304C92
	ldrh r0,[r0,#0x8]	; 02304C94
	strh r0,[r5,r2]	; 02304C96
	add r3,r3,#0x1	; 02304C98
	cmp r3,#0x4	; 02304C9A
	bcc loc_02304C8E	; 02304C9C
	mov r4,#0x0	; 02304C9E
	ldr r2,[pool_02304CD8]	; 02304CA0
	add r1,r4,#0x0	; 02304CA2
	ldr r0,[pool_02304CDC]	; 02304CA4
loc_02304CA6:
	lsl r3,r4,#0x3	; 02304CA6
	add r3,r5,r3	; 02304CA8
	add r6,r3,#0x0	; 02304CAA
	add r6,#0x90	; 02304CAC
	strh r2,[r6,#0x0]	; 02304CAE
	add r6,r3,#0x0	; 02304CB0
	add r6,#0x92	; 02304CB2
	strh r1,[r6,#0x0]	; 02304CB4
	lsl r6,r4,#0x2	; 02304CB6
	ldr r6,[r0,r6]	; 02304CB8
	add r3,#0x94	; 02304CBA
	str r6,[r3,#0x0]	; 02304CBC
	add r4,r4,#0x1	; 02304CBE
	cmp r4,#0x16	; 02304CC0
	bcc loc_02304CA6	; 02304CC2
	mov r0,#0x3	; 02304CC4
	mov r1,#0xc	; 02304CC6
	bl loc_02304B68	; 02304CC8
	pop {r4,r5,r6}	; 02304CCC
	pop {r3}	; 02304CCE
	bx r3	; 02304CD0
	.byte 0xC0, 0x46	; 02304CD4
pool_02304CD4:
loc_02304CD4:
	.word FirmwareWlWorkPointerSlot	; 02304CD4
pool_02304CD8:
loc_02304CD8:
	.word 0x0000FFFF	; 02304CD8
pool_02304CDC:
loc_02304CDC:
	.word P4_Data_0231031C	; 02304CDC

; ===== function loc_02304CE0 =====
loc_02304CE0:
	push {r4,r5,r6,r7,lr}	; 02304CE0
	sub sp,#0x4	; 02304CE2
	add r6,r0,#0x0	; 02304CE4
	ldr r5,[r6,#0x0]	; 02304CE6
	ldrh r0,[r6,#0x8]	; 02304CE8
	cmp r0,#0x0	; 02304CEA
	beq loc_02304D0A	; 02304CEC
	mov r0,#0x0	; 02304CEE
	mvn r4,r0	; 02304CF0
	b loc_02304D06	; 02304CF2
loc_02304CF4:
	add r0,r5,#0x0	; 02304CF4
	bl loc_02304E5C	; 02304CF6
	add r7,r0,#0x0	; 02304CFA
	add r0,r6,#0x0	; 02304CFC
	add r1,r5,#0x0	; 02304CFE
	bl loc_02304FF8	; 02304D00
	add r5,r7,#0x0	; 02304D04
loc_02304D06:
	cmp r5,r4	; 02304D06
	bne loc_02304CF4	; 02304D08
loc_02304D0A:
	add sp,#0x4	; 02304D0A
	pop {r4,r5,r6,r7}	; 02304D0C
	pop {r3}	; 02304D0E
	bx r3	; 02304D10
	.byte 0x00, 0x00	; 02304D14

; ===== function loc_02304D14 =====
loc_02304D14:
	push {r4,lr}	; 02304D14
	ldr r0,[pool_02304D64]	; 02304D16
	ldr r1,[r0,#0x0]	; 02304D18
	ldr r0,[pool_02304D68]	; 02304D1A
	add r4,r1,r0	; 02304D1C
	add r0,r4,#0x0	; 02304D1E
	add r0,#0x18	; 02304D20
	bl loc_02304CE0	; 02304D22
	add r0,r4,#0x0	; 02304D26
	add r0,#0x24	; 02304D28
	bl loc_02304CE0	; 02304D2A
	add r0,r4,#0x0	; 02304D2E
	add r0,#0x30	; 02304D30
	bl loc_02304CE0	; 02304D32
	add r0,r4,#0x0	; 02304D36
	add r0,#0x3c	; 02304D38
	bl loc_02304CE0	; 02304D3A
	add r0,r4,#0x0	; 02304D3E
	add r0,#0x48	; 02304D40
	bl loc_02304CE0	; 02304D42
	add r0,r4,#0x0	; 02304D46
	add r0,#0x54	; 02304D48
	bl loc_02304CE0	; 02304D4A
	add r0,r4,#0x0	; 02304D4E
	add r0,#0x60	; 02304D50
	bl loc_02304CE0	; 02304D52
	add r4,#0x6c	; 02304D56
	add r0,r4,#0x0	; 02304D58
	bl loc_02304CE0	; 02304D5A
	pop {r4}	; 02304D5E
	pop {r3}	; 02304D60
	bx r3	; 02304D62
pool_02304D64:
loc_02304D64:
	.word FirmwareWlWorkPointerSlot	; 02304D64
pool_02304D68:
loc_02304D68:
	.word 0x00000140	; 02304D68

; ===== function loc_02304D6C =====
loc_02304D6C:
	push {r4,lr}	; 02304D6C
	ldr r1,[pool_02304E38]	; 02304D6E
	ldr r2,[r1,#0x0]	; 02304D70
	ldr r1,[pool_02304E3C]	; 02304D72
	add r4,r2,r1	; 02304D74
	ldr r1,[r0,#0x0]	; 02304D76
	str r1,[r4,#0x0]	; 02304D78
	ldr r1,[r0,#0x4]	; 02304D7A
	str r1,[r4,#0x4]	; 02304D7C
	ldr r0,[r0,#0x8]	; 02304D7E
	str r0,[r4,#0x8]	; 02304D80
	ldr r0,[r4,#0x0]	; 02304D82
	cmp r0,#0x0	; 02304D84
	beq loc_02304D8E	; 02304D86
	cmp r0,#0x1	; 02304D88
	beq loc_02304DA2	; 02304D8A
	b loc_02304DB2	; 02304D8C
loc_02304D8E:
	ldr r0,[r4,#0x4]	; 02304D8E
	ldr r1,[r4,#0x8]	; 02304D90
	mov r2,#0x81	; 02304D92
	bl loc_02301044	; 02304D94
	ldr r1,[pool_02304E38]	; 02304D98
	ldr r2,[r1,#0x0]	; 02304D9A
	ldr r1,[pool_02304E40]	; 02304D9C
	str r0,[r2,r1]	; 02304D9E
	b loc_02304DB2	; 02304DA0
loc_02304DA2:
	mov r0,#0x81	; 02304DA2
	ldr r1,[r4,#0x4]	; 02304DA4
	bl loc_02301870	; 02304DA6
	ldr r1,[pool_02304E38]	; 02304DAA
	ldr r2,[r1,#0x0]	; 02304DAC
	ldr r1,[pool_02304E40]	; 02304DAE
	str r0,[r2,r1]	; 02304DB0
loc_02304DB2:
	mov r3,#0x0	; 02304DB2
	ldr r2,[pool_02304E38]	; 02304DB4
	ldr r1,[r2,#0x0]	; 02304DB6
	ldr r0,[pool_02304E44]	; 02304DB8
	strh r3,[r1,r0]	; 02304DBA
	ldr r1,[r2,#0x0]	; 02304DBC
	ldr r0,[pool_02304E48]	; 02304DBE
	strh r3,[r1,r0]	; 02304DC0
	add r0,r4,#0x0	; 02304DC2
	add r0,#0xc	; 02304DC4
	mov r1,#0x2	; 02304DC6
	bl loc_02304E4C	; 02304DC8
	add r0,r4,#0x0	; 02304DCC
	add r0,#0x18	; 02304DCE
	mov r1,#0x3	; 02304DD0
	bl loc_02304E4C	; 02304DD2
	add r0,r4,#0x0	; 02304DD6
	add r0,#0x24	; 02304DD8
	mov r1,#0x4	; 02304DDA
	bl loc_02304E4C	; 02304DDC
	add r0,r4,#0x0	; 02304DE0
	add r0,#0x30	; 02304DE2
	mov r1,#0x5	; 02304DE4
	bl loc_02304E4C	; 02304DE6
	add r0,r4,#0x0	; 02304DEA
	add r0,#0x3c	; 02304DEC
	mov r1,#0x6	; 02304DEE
	bl loc_02304E4C	; 02304DF0
	add r0,r4,#0x0	; 02304DF4
	add r0,#0x48	; 02304DF6
	mov r1,#0x7	; 02304DF8
	bl loc_02304E4C	; 02304DFA
	add r0,r4,#0x0	; 02304DFE
	add r0,#0x54	; 02304E00
	mov r1,#0x8	; 02304E02
	bl loc_02304E4C	; 02304E04
	add r0,r4,#0x0	; 02304E08
	add r0,#0x60	; 02304E0A
	mov r1,#0x9	; 02304E0C
	bl loc_02304E4C	; 02304E0E
	add r0,r4,#0x0	; 02304E12
	add r0,#0x6c	; 02304E14
	mov r1,#0xa	; 02304E16
	bl loc_02304E4C	; 02304E18
	add r0,r4,#0x0	; 02304E1C
	add r0,#0x78	; 02304E1E
	mov r1,#0xb	; 02304E20
	bl loc_02304E4C	; 02304E22
	add r4,#0x84	; 02304E26
	add r0,r4,#0x0	; 02304E28
	mov r1,#0xc	; 02304E2A
	bl loc_02304E4C	; 02304E2C
	pop {r4}	; 02304E30
	pop {r3}	; 02304E32
	bx r3	; 02304E34
	.byte 0xC0, 0x46	; 02304E38
pool_02304E38:
loc_02304E38:
	.word FirmwareWlWorkPointerSlot	; 02304E38
pool_02304E3C:
loc_02304E3C:
	.word 0x00000140	; 02304E3C
pool_02304E40:
loc_02304E40:
	.word 0x00000398	; 02304E40
pool_02304E44:
loc_02304E44:
	.word 0x0000039C	; 02304E44
pool_02304E48:
loc_02304E48:
	.word 0x000003A0	; 02304E48

; ===== function loc_02304E4C =====
loc_02304E4C:
	mov r2,#0x0	; 02304E4C
	mvn r3,r2	; 02304E4E
	str r3,[r0,#0x0]	; 02304E50
	str r3,[r0,#0x4]	; 02304E52
	strh r2,[r0,#0x8]	; 02304E54
	strh r1,[r0,#0xa]	; 02304E56
	bx lr	; 02304E58
	.byte 0x00, 0x00	; 02304E5C

; ===== function loc_02304E5C =====
loc_02304E5C:
	ldr r0,[r0,#0x4]	; 02304E5C
	bx lr	; 02304E5E

; ===== function loc_02304E60 =====
loc_02304E60:
	push {r4,r5,lr}	; 02304E60
	sub sp,#0x4	; 02304E62
	add r5,r0,#0x0	; 02304E64
	add r4,r1,#0x0	; 02304E66
	ldrh r1,[r4,#0xa]	; 02304E68
	ldr r0,[pool_02304EE8]	; 02304E6A
	cmp r1,r0	; 02304E6C
	beq loc_02304E74	; 02304E6E
	mov r0,#0x1	; 02304E70
	b loc_02304EDE	; 02304E72
loc_02304E74:
	ldrh r1,[r4,#0x8]	; 02304E74
	ldrh r0,[r5,#0xa]	; 02304E76
	cmp r1,r0	; 02304E78
	beq loc_02304E80	; 02304E7A
	mov r0,#0x2	; 02304E7C
	b loc_02304EDE	; 02304E7E
loc_02304E80:
	ldr r0,[pool_02304EEC]	; 02304E80
	bl loc_02304B48	; 02304E82
	add r2,r5,#0x0	; 02304E86
	add r2,#0x8	; 02304E88
	ldrh r1,[r2,#0x0]	; 02304E8A
	sub r1,r1,#0x1	; 02304E8C
	strh r1,[r2,#0x0]	; 02304E8E
	ldrh r1,[r5,#0x8]	; 02304E90
	cmp r1,#0x0	; 02304E92
	bne loc_02304EA0	; 02304E94
	mov r1,#0x0	; 02304E96
	mvn r1,r1	; 02304E98
	str r1,[r5,#0x0]	; 02304E9A
	str r1,[r5,#0x4]	; 02304E9C
	b loc_02304ED4	; 02304E9E
loc_02304EA0:
	ldr r1,[r5,#0x0]	; 02304EA0
	cmp r4,r1	; 02304EA2
	bne loc_02304EB4	; 02304EA4
	ldr r1,[r4,#0x4]	; 02304EA6
	str r1,[r5,#0x0]	; 02304EA8
	mov r1,#0x0	; 02304EAA
	mvn r2,r1	; 02304EAC
	ldr r1,[r5,#0x0]	; 02304EAE
	str r2,[r1,#0x0]	; 02304EB0
	b loc_02304ED4	; 02304EB2
loc_02304EB4:
	ldr r1,[r5,#0x4]	; 02304EB4
	cmp r4,r1	; 02304EB6
	bne loc_02304EC8	; 02304EB8
	ldr r1,[r4,#0x0]	; 02304EBA
	str r1,[r5,#0x4]	; 02304EBC
	mov r1,#0x0	; 02304EBE
	mvn r2,r1	; 02304EC0
	ldr r1,[r5,#0x4]	; 02304EC2
	str r2,[r1,#0x4]	; 02304EC4
	b loc_02304ED4	; 02304EC6
loc_02304EC8:
	ldr r2,[r4,#0x0]	; 02304EC8
	ldr r1,[r4,#0x4]	; 02304ECA
	str r2,[r1,#0x0]	; 02304ECC
	ldr r2,[r4,#0x4]	; 02304ECE
	ldr r1,[r4,#0x0]	; 02304ED0
	str r2,[r1,#0x4]	; 02304ED2
loc_02304ED4:
	mov r1,#0x0	; 02304ED4
	strh r1,[r4,#0x8]	; 02304ED6
	bl loc_02304B58	; 02304ED8
	mov r0,#0x0	; 02304EDC
loc_02304EDE:
	add sp,#0x4	; 02304EDE
	pop {r4,r5}	; 02304EE0
	pop {r3}	; 02304EE2
	bx r3	; 02304EE4
	.byte 0xC0, 0x46	; 02304EE8
pool_02304EE8:
loc_02304EE8:
	.word 0x0000BF1D	; 02304EE8
pool_02304EEC:
loc_02304EEC:
	.word 0x01000000	; 02304EEC

; ===== function loc_02304EF0 =====
loc_02304EF0:
	push {r4,r5,lr}	; 02304EF0
	sub sp,#0x4	; 02304EF2
	add r5,r0,#0x0	; 02304EF4
	add r4,r1,#0x0	; 02304EF6
	ldrh r1,[r4,#0xa]	; 02304EF8
	ldr r0,[pool_02304F4C]	; 02304EFA
	cmp r1,r0	; 02304EFC
	beq loc_02304F04	; 02304EFE
	mov r0,#0x1	; 02304F00
	b loc_02304F44	; 02304F02
loc_02304F04:
	ldrh r0,[r4,#0x8]	; 02304F04
	cmp r0,#0x0	; 02304F06
	beq loc_02304F0E	; 02304F08
	mov r0,#0x2	; 02304F0A
	b loc_02304F44	; 02304F0C
loc_02304F0E:
	ldr r0,[pool_02304F50]	; 02304F0E
	bl loc_02304B48	; 02304F10
	ldrh r1,[r5,#0x8]	; 02304F14
	cmp r1,#0x0	; 02304F16
	bne loc_02304F24	; 02304F18
	mov r1,#0x0	; 02304F1A
	mvn r1,r1	; 02304F1C
	str r1,[r4,#0x0]	; 02304F1E
	str r4,[r5,#0x0]	; 02304F20
	b loc_02304F2A	; 02304F22
loc_02304F24:
	ldr r1,[r5,#0x4]	; 02304F24
	str r1,[r4,#0x0]	; 02304F26
	str r4,[r1,#0x4]	; 02304F28
loc_02304F2A:
	mov r1,#0x0	; 02304F2A
	mvn r1,r1	; 02304F2C
	str r1,[r4,#0x4]	; 02304F2E
	ldrh r1,[r5,#0xa]	; 02304F30
	strh r1,[r4,#0x8]	; 02304F32
	str r4,[r5,#0x4]	; 02304F34
	add r5,#0x8	; 02304F36
	ldrh r1,[r5,#0x0]	; 02304F38
	add r1,r1,#0x1	; 02304F3A
	strh r1,[r5,#0x0]	; 02304F3C
	bl loc_02304B58	; 02304F3E
	mov r0,#0x0	; 02304F42
loc_02304F44:
	add sp,#0x4	; 02304F44
	pop {r4,r5}	; 02304F46
	pop {r3}	; 02304F48
	bx r3	; 02304F4A
pool_02304F4C:
loc_02304F4C:
	.word 0x0000BF1D	; 02304F4C
pool_02304F50:
loc_02304F50:
	.word 0x01000000	; 02304F50

; ===== function loc_02304F54 =====
loc_02304F54:
	push {r4,r5,lr}	; 02304F54
	sub sp,#0x4	; 02304F56
	add r5,r0,#0x0	; 02304F58
	add r4,r1,#0x0	; 02304F5A
	ldr r0,[pool_02304FA0]	; 02304F5C
	bl loc_02304B48	; 02304F5E
	ldrh r1,[r5,#0x8]	; 02304F62
	cmp r1,#0x0	; 02304F64
	bne loc_02304F72	; 02304F66
	mov r1,#0x0	; 02304F68
	mvn r1,r1	; 02304F6A
	str r1,[r4,#0x0]	; 02304F6C
	str r4,[r5,#0x0]	; 02304F6E
	b loc_02304F78	; 02304F70
loc_02304F72:
	ldr r1,[r5,#0x4]	; 02304F72
	str r1,[r4,#0x0]	; 02304F74
	str r4,[r1,#0x4]	; 02304F76
loc_02304F78:
	mov r1,#0x0	; 02304F78
	mvn r1,r1	; 02304F7A
	str r1,[r4,#0x4]	; 02304F7C
	ldrh r1,[r5,#0xa]	; 02304F7E
	strh r1,[r4,#0x8]	; 02304F80
	ldr r1,[pool_02304FA4]	; 02304F82
	strh r1,[r4,#0xa]	; 02304F84
	str r4,[r5,#0x4]	; 02304F86
	add r5,#0x8	; 02304F88
	ldrh r1,[r5,#0x0]	; 02304F8A
	add r1,r1,#0x1	; 02304F8C
	strh r1,[r5,#0x0]	; 02304F8E
	bl loc_02304B58	; 02304F90
	mov r0,#0x0	; 02304F94
	add sp,#0x4	; 02304F96
	pop {r4,r5}	; 02304F98
	pop {r3}	; 02304F9A
	bx r3	; 02304F9C
	.byte 0xC0, 0x46	; 02304FA0
pool_02304FA0:
loc_02304FA0:
	.word 0x01000000	; 02304FA0
pool_02304FA4:
loc_02304FA4:
	.word 0x0000BF1D	; 02304FA4

; ===== function loc_02304FA8 =====
loc_02304FA8:
	push {r4,r5,r6,r7,lr}	; 02304FA8
	sub sp,#0x4	; 02304FAA
	add r4,r0,#0x0	; 02304FAC
	add r6,r1,#0x0	; 02304FAE
	add r5,r2,#0x0	; 02304FB0
	ldrh r1,[r5,#0xa]	; 02304FB2
	ldr r0,[pool_02304FF0]	; 02304FB4
	cmp r1,r0	; 02304FB6
	beq loc_02304FBE	; 02304FB8
	mov r0,#0x1	; 02304FBA
	b loc_02304FE6	; 02304FBC
loc_02304FBE:
	ldr r0,[pool_02304FF4]	; 02304FBE
	bl loc_02304B48	; 02304FC0
	add r7,r0,#0x0	; 02304FC4
	add r0,r4,#0x0	; 02304FC6
	add r1,r5,#0x0	; 02304FC8
	bl loc_02304E60	; 02304FCA
	add r4,r0,#0x0	; 02304FCE
	cmp r4,#0x0	; 02304FD0
	bne loc_02304FDE	; 02304FD2
	add r0,r6,#0x0	; 02304FD4
	add r1,r5,#0x0	; 02304FD6
	bl loc_02304EF0	; 02304FD8
	add r4,r0,#0x0	; 02304FDC
loc_02304FDE:
	add r0,r7,#0x0	; 02304FDE
	bl loc_02304B58	; 02304FE0
	add r0,r4,#0x0	; 02304FE4
loc_02304FE6:
	add sp,#0x4	; 02304FE6
	pop {r4,r5,r6,r7}	; 02304FE8
	pop {r3}	; 02304FEA
	bx r3	; 02304FEC
	.byte 0xC0, 0x46	; 02304FF0
pool_02304FF0:
loc_02304FF0:
	.word 0x0000BF1D	; 02304FF0
pool_02304FF4:
loc_02304FF4:
	.word 0x01000000	; 02304FF4

; ===== function loc_02304FF8 =====
loc_02304FF8:
	push {r4,r5,r6,lr}	; 02304FF8
	add r5,r1,#0x0	; 02304FFA
	ldr r2,[pool_02305044]	; 02304FFC
	ldr r3,[r2,#0x0]	; 02304FFE
	ldr r2,[pool_02305048]	; 02305000
	add r4,r3,r2	; 02305002
	ldrh r3,[r5,#0xa]	; 02305004
	ldr r2,[pool_0230504C]	; 02305006
	cmp r3,r2	; 02305008
	beq loc_02305010	; 0230500A
	mov r0,#0x1	; 0230500C
	b loc_0230503C	; 0230500E
loc_02305010:
	bl loc_02304E60	; 02305010
	add r6,r0,#0x0	; 02305014
	cmp r6,#0x0	; 02305016
	bne loc_0230503A	; 02305018
	ldr r0,[r4,#0x0]	; 0230501A
	cmp r0,#0x0	; 0230501C
	beq loc_02305026	; 0230501E
	cmp r0,#0x1	; 02305020
	beq loc_02305032	; 02305022
	b loc_0230503A	; 02305024
loc_02305026:
	ldr r0,[r4,#0x4]	; 02305026
	ldr r1,[r4,#0x8]	; 02305028
	add r2,r5,#0x0	; 0230502A
	bl loc_02301694	; 0230502C
	b loc_0230503A	; 02305030
loc_02305032:
	add r0,r5,#0x0	; 02305032
	ldr r1,[r4,#0x8]	; 02305034
	bl loc_02301870	; 02305036
loc_0230503A:
	add r0,r6,#0x0	; 0230503A
loc_0230503C:
	pop {r4,r5,r6}	; 0230503C
	pop {r3}	; 0230503E
	bx r3	; 02305040
	.byte 0xC0, 0x46	; 02305044
pool_02305044:
loc_02305044:
	.word FirmwareWlWorkPointerSlot	; 02305044
pool_02305048:
loc_02305048:
	.word 0x00000140	; 02305048
pool_0230504C:
loc_0230504C:
	.word 0x0000BF1D	; 0230504C

; ===== function loc_02305050 =====
loc_02305050:
	push {r4,r5,lr}	; 02305050
	sub sp,#0x4	; 02305052
	add r5,r0,#0x0	; 02305054
	ldr r0,[pool_023050B0]	; 02305056
	ldr r2,[r0,#0x0]	; 02305058
	ldr r0,[pool_023050B4]	; 0230505A
	add r3,r2,r0	; 0230505C
	cmp r1,#0x0	; 0230505E
	bne loc_02305066	; 02305060
	mov r0,#0x0	; 02305062
	b loc_023050A6	; 02305064
loc_02305066:
	add r2,r1,#0x0	; 02305066
	add r2,#0xc	; 02305068
	ldr r0,[r3,#0x0]	; 0230506A
	cmp r0,#0x0	; 0230506C
	beq loc_02305076	; 0230506E
	cmp r0,#0x1	; 02305070
	beq loc_02305082	; 02305072
	b loc_0230508C	; 02305074
loc_02305076:
	ldr r0,[r3,#0x4]	; 02305076
	ldr r1,[r3,#0x8]	; 02305078
	bl loc_02301044	; 0230507A
	add r4,r0,#0x0	; 0230507E
	b loc_0230508C	; 02305080
loc_02305082:
	add r0,r2,#0x0	; 02305082
	ldr r1,[r3,#0x4]	; 02305084
	bl loc_02301870	; 02305086
	add r4,r0,#0x0	; 0230508A
loc_0230508C:
	cmp r4,#0x0	; 0230508C
	beq loc_023050A4	; 0230508E
	ldr r0,[pool_023050B8]	; 02305090
	strh r0,[r4,#0xa]	; 02305092
	mov r0,#0x0	; 02305094
	strh r0,[r4,#0x8]	; 02305096
	add r0,r5,#0x0	; 02305098
	add r1,r4,#0x0	; 0230509A
	bl loc_02304EF0	; 0230509C
	add r0,r4,#0x0	; 023050A0
	b loc_023050A6	; 023050A2
loc_023050A4:
	mov r0,#0x0	; 023050A4
loc_023050A6:
	add sp,#0x4	; 023050A6
	pop {r4,r5}	; 023050A8
	pop {r3}	; 023050AA
	bx r3	; 023050AC
	.byte 0xC0, 0x46	; 023050B0
pool_023050B0:
loc_023050B0:
	.word FirmwareWlWorkPointerSlot	; 023050B0
pool_023050B4:
loc_023050B4:
	.word 0x00000140	; 023050B4
pool_023050B8:
loc_023050B8:
	.word 0x0000BF1D	; 023050B8

; ===== function loc_023050BC =====
	push {r4,r5,lr}	; 023050BC
	sub sp,#0x4	; 023050BE
	ldr r0,[pool_0230511C]	; 023050C0
	ldr r1,[r0,#0x0]	; 023050C2
	ldr r0,[pool_02305120]	; 023050C4
	ldrh r0,[r1,r0]	; 023050C6
	cmp r0,#0x0	; 023050C8
	beq loc_02305114	; 023050CA
	ldr r0,[pool_02305124]	; 023050CC
	add r0,r1,r0	; 023050CE
	mov r1,#0x12	; 023050D0
	bl loc_02305050	; 023050D2
	add r4,r0,#0x0	; 023050D6
	cmp r4,#0x0	; 023050D8
	bne loc_023050E4	; 023050DA
	mov r0,#0x1	; 023050DC
	bl loc_02305130	; 023050DE
	b loc_02305114	; 023050E2
loc_023050E4:
	ldr r0,[pool_02305128]	; 023050E4
	strh r0,[r4,#0xc]	; 023050E6
	mov r0,#0x1	; 023050E8
	strh r0,[r4,#0xe]	; 023050EA
	ldr r0,[pool_0230512C]	; 023050EC
	bl loc_02304B48	; 023050EE
	ldr r5,[pool_0230511C]	; 023050F2
	ldr r2,[r5,#0x0]	; 023050F4
	ldr r1,[pool_02305120]	; 023050F6
	ldrh r2,[r2,r1]	; 023050F8
	strh r2,[r4,#0x10]	; 023050FA
	mov r3,#0x0	; 023050FC
	ldr r2,[r5,#0x0]	; 023050FE
	strh r3,[r2,r1]	; 02305100
	bl loc_02304B58	; 02305102
	lsl r0,r5,#0	; 02305106
	ldr r1,[r0,#0x0]	; 02305108
	ldr r0,[pool_02305124]	; 0230510A
	add r0,r1,r0	; 0230510C
	add r1,r4,#0x0	; 0230510E
	bl loc_02309574	; 02305110
loc_02305114:
	add sp,#0x4	; 02305114
	pop {r4,r5}	; 02305116
	pop {r3}	; 02305118
	bx r3	; 0230511A
pool_0230511C:
loc_0230511C:
	.word FirmwareWlWorkPointerSlot	; 0230511C
pool_02305120:
loc_02305120:
	.word 0x000003AC	; 02305120
pool_02305124:
loc_02305124:
	.word 0x0000014C	; 02305124
pool_02305128:
loc_02305128:
	.word 0x00000186	; 02305128
pool_0230512C:
loc_0230512C:
	.word 0x01000000	; 0230512C

; ===== function loc_02305130 =====
loc_02305130:
	push {r4,lr}	; 02305130
	add r4,r0,#0x0	; 02305132
	ldr r0,[pool_0230515C]	; 02305134
	bl loc_02304B48	; 02305136
	ldr r1,[pool_02305160]	; 0230513A
	ldr r2,[r1,#0x0]	; 0230513C
	ldr r1,[pool_02305164]	; 0230513E
	add r2,r2,r1	; 02305140
	ldrh r1,[r2,#0x0]	; 02305142
	orr r1,r4	; 02305144
	strh r1,[r2,#0x0]	; 02305146
	bl loc_02304B58	; 02305148
	mov r0,#0x2	; 0230514C
	mov r1,#0x15	; 0230514E
	bl loc_02304B68	; 02305150
	pop {r4}	; 02305154
	pop {r3}	; 02305156
	bx r3	; 02305158
	.byte 0xC0, 0x46	; 0230515C
pool_0230515C:
loc_0230515C:
	.word 0x01000000	; 0230515C
pool_02305160:
loc_02305160:
	.word FirmwareWlWorkPointerSlot	; 02305160
pool_02305164:
loc_02305164:
	.word 0x000003AC	; 02305164

; ===== function loc_02305168 =====
loc_02305168:
	push {r4,lr}	; 02305168
	ldr r0,[pool_0230521C]	; 0230516A
	ldr r1,[r0,#0x0]	; 0230516C
	ldr r0,[pool_02305220]	; 0230516E
	add r4,r1,r0	; 02305170
	ldr r0,[pool_02305224]	; 02305172
	ldrh r0,[r1,r0]	; 02305174
	cmp r0,#0x1	; 02305176
	beq loc_02305182	; 02305178
	cmp r0,#0x2	; 0230517A
	beq loc_023051AC	; 0230517C
	cmp r0,#0x3	; 0230517E
	b loc_023051E4	; 02305180
loc_02305182:
	add r0,r4,#0x0	; 02305182
	add r0,#0x78	; 02305184
	bl loc_02305290	; 02305186
	cmp r0,#0x0	; 0230518A
	beq loc_02305196	; 0230518C
	bl loc_02305268	; 0230518E
	bl loc_0230C71C	; 02305192
loc_02305196:
	add r0,r4,#0x0	; 02305196
	add r0,#0x28	; 02305198
	bl loc_02305290	; 0230519A
	cmp r0,#0x0	; 0230519E
	beq loc_023051E4	; 023051A0
	add r0,r4,#0x0	; 023051A2
	add r0,#0x28	; 023051A4
	bl loc_02305234	; 023051A6
	b loc_023051E4	; 023051AA
loc_023051AC:
	add r0,r4,#0x0	; 023051AC
	add r0,#0x64	; 023051AE
	bl loc_02305290	; 023051B0
	add r0,r4,#0x0	; 023051B4
	add r0,#0x28	; 023051B6
	bl loc_02305290	; 023051B8
	cmp r0,#0x0	; 023051BC
	beq loc_023051E4	; 023051BE
	ldrh r0,[r4,#0x28]	; 023051C0
	cmp r0,#0x0	; 023051C2
	beq loc_023051CA	; 023051C4
	bl loc_02305268	; 023051C6
loc_023051CA:
	ldr r0,[pool_0230521C]	; 023051CA
	ldr r1,[r0,#0x0]	; 023051CC
	ldr r0,[pool_02305228]	; 023051CE
	ldrh r0,[r1,r0]	; 023051D0
	bl loc_0230C010	; 023051D2
	ldr r0,[pool_0230521C]	; 023051D6
	ldr r1,[r0,#0x0]	; 023051D8
	ldr r0,[pool_0230522C]	; 023051DA
	add r1,r1,r0	; 023051DC
	ldrh r0,[r1,#0x0]	; 023051DE
	add r0,r0,#0x1	; 023051E0
	strh r0,[r1,#0x0]	; 023051E2
loc_023051E4:
	add r0,r4,#0x0	; 023051E4
	add r0,#0x14	; 023051E6
	bl loc_02305290	; 023051E8
	cmp r0,#0x0	; 023051EC
	beq loc_023051F8	; 023051EE
	add r0,r4,#0x0	; 023051F0
	add r0,#0x14	; 023051F2
	bl loc_02305234	; 023051F4
loc_023051F8:
	add r0,r4,#0x0	; 023051F8
	bl loc_02305290	; 023051FA
	cmp r0,#0x0	; 023051FE
	beq loc_02305208	; 02305200
	add r0,r4,#0x0	; 02305202
	bl loc_02305234	; 02305204
loc_02305208:
	ldr r1,[pool_02305230]	; 02305208
	ldrh r0,[r1,#0x0]	; 0230520A
	cmp r0,#0x0	; 0230520C
	bne loc_02305214	; 0230520E
	mov r0,#0x1	; 02305210
	strh r0,[r1,#0x0]	; 02305212
loc_02305214:
	pop {r4}	; 02305214
	pop {r3}	; 02305216
	bx r3	; 02305218
	.byte 0xC0, 0x46	; 0230521C
pool_0230521C:
loc_0230521C:
	.word FirmwareWlWorkPointerSlot	; 0230521C
pool_02305220:
loc_02305220:
	.word 0x000003E4	; 02305220
pool_02305224:
loc_02305224:
	.word 0x00000314	; 02305224
pool_02305228:
loc_02305228:
	.word 0x00000366	; 02305228
pool_0230522C:
loc_0230522C:
	.word 0x000003B4	; 0230522C
pool_02305230:
loc_02305230:
	.word REG_WIFI_MODE_RST	; 02305230

; ===== function loc_02305234 =====
loc_02305234:
	push {r4,lr}	; 02305234
	add r4,r0,#0x0	; 02305236
	ldrh r0,[r4,#0x0]	; 02305238
	cmp r0,#0x0	; 0230523A
	beq loc_0230525A	; 0230523C
	bl loc_02305268	; 0230523E
	ldr r0,[r4,#0x8]	; 02305242
	ldr r1,[r4,#0xc]	; 02305244
	sub r1,#0x10	; 02305246
	bl loc_0230D4D8	; 02305248
	ldr r0,[pool_02305260]	; 0230524C
	ldr r1,[r0,#0x0]	; 0230524E
	ldr r0,[pool_02305264]	; 02305250
	add r1,r1,r0	; 02305252
	ldrh r0,[r1,#0x0]	; 02305254
	add r0,r0,#0x1	; 02305256
	strh r0,[r1,#0x0]	; 02305258
loc_0230525A:
	pop {r4}	; 0230525A
	pop {r3}	; 0230525C
	bx r3	; 0230525E
pool_02305260:
loc_02305260:
	.word FirmwareWlWorkPointerSlot	; 02305260
pool_02305264:
loc_02305264:
	.word 0x000003B4	; 02305264

; ===== function loc_02305268 =====
loc_02305268:
	mov r1,#0x0	; 02305268
	ldr r0,[pool_02305288]	; 0230526A
	strh r1,[r0,#0x0]	; 0230526C
	mov r2,#0x10	; 0230526E
	ldr r1,[pool_0230528C]	; 02305270
	b loc_02305280	; 02305272
loc_02305274:
	ldrh r0,[r1,#0x0]	; 02305274
	cmp r0,#0x0	; 02305276
	beq loc_02305284	; 02305278
	cmp r0,#0x9	; 0230527A
	beq loc_02305284	; 0230527C
	sub r2,r2,#0x1	; 0230527E
loc_02305280:
	cmp r2,#0x0	; 02305280
	bne loc_02305274	; 02305282
loc_02305284:
	bx lr	; 02305284
	.byte 0xC0, 0x46	; 02305288
pool_02305288:
loc_02305288:
	.word REG_WIFI_MODE_RST	; 02305288
pool_0230528C:
loc_0230528C:
	.word REG_WIFI_RF_STATUS	; 0230528C

; ===== function loc_02305290 =====
loc_02305290:
	push {r4,lr}	; 02305290
	ldr r4,[r0,#0x8]	; 02305292
	sub r2,r4,#0x4	; 02305294
	ldrh r3,[r2,#0x0]	; 02305296
	ldr r1,[pool_023052D4]	; 02305298
	cmp r3,r1	; 0230529A
	bne loc_023052A6	; 0230529C
	ldrh r3,[r2,#0x2]	; 0230529E
	ldr r1,[pool_023052D8]	; 023052A0
	cmp r3,r1	; 023052A2
	beq loc_023052CC	; 023052A4
loc_023052A6:
	mov r1,#0x1	; 023052A6
	strh r1,[r4,#0xa]	; 023052A8
	ldr r4,[pool_023052D4]	; 023052AA
	strh r4,[r2,#0x0]	; 023052AC
	ldr r3,[pool_023052D8]	; 023052AE
	strh r3,[r2,#0x2]	; 023052B0
	ldr r0,[r0,#0x8]	; 023052B2
	add r0,#0xc	; 023052B4
	strh r4,[r0,#0x0]	; 023052B6
	strh r3,[r0,#0x2]	; 023052B8
	ldr r0,[pool_023052DC]	; 023052BA
	ldr r2,[r0,#0x0]	; 023052BC
	ldr r0,[pool_023052E0]	; 023052BE
	add r2,r2,r0	; 023052C0
	ldrh r0,[r2,#0x0]	; 023052C2
	add r0,r0,#0x1	; 023052C4
	strh r0,[r2,#0x0]	; 023052C6
	add r0,r1,#0x0	; 023052C8
	b loc_023052CE	; 023052CA
loc_023052CC:
	mov r0,#0x0	; 023052CC
loc_023052CE:
	pop {r4}	; 023052CE
	pop {r3}	; 023052D0
	bx r3	; 023052D2
pool_023052D4:
loc_023052D4:
	.word 0x0000B6B8	; 023052D4
pool_023052D8:
loc_023052D8:
	.word 0x00001D46	; 023052D8
pool_023052DC:
loc_023052DC:
	.word FirmwareWlWorkPointerSlot	; 023052DC
pool_023052E0:
loc_023052E0:
	.word 0x000003B2	; 023052E0

; ===== function loc_023052E4 =====
loc_023052E4:
	push {r4,r5,lr}	; 023052E4
	sub sp,#0x4	; 023052E6
	mov r2,#0xf	; 023052E8
	add r3,r1,#0x0	; 023052EA
	and r3,r2	; 023052EC
	lsl r3,r3,#0x1	; 023052EE
	ldr r4,[pool_02305334]	; 023052F0
	ldrh r3,[r4,r3]	; 023052F2
	asr r1,r1,#0x4	; 023052F4
	ldr r5,[pool_02305338]	; 023052F6
	and r1,r5	; 023052F8
	lsl r1,r1,#0x10	; 023052FA
	lsr r1,r1,#0x10	; 023052FC
	eor r1,r3	; 023052FE
	add r3,r0,#0x0	; 02305300
	and r3,r2	; 02305302
	lsl r3,r3,#0x1	; 02305304
	ldrh r3,[r4,r3]	; 02305306
	eor r1,r3	; 02305308
	lsl r1,r1,#0x10	; 0230530A
	lsr r3,r1,#0x10	; 0230530C
	asr r1,r3,#0x4	; 0230530E
	and r1,r5	; 02305310
	lsl r1,r1,#0x10	; 02305312
	lsr r1,r1,#0x10	; 02305314
	and r3,r2	; 02305316
	lsl r3,r3,#0x1	; 02305318
	ldrh r3,[r4,r3]	; 0230531A
	eor r1,r3	; 0230531C
	asr r0,r0,#0x4	; 0230531E
	and r0,r2	; 02305320
	lsl r0,r0,#0x1	; 02305322
	ldrh r0,[r4,r0]	; 02305324
	eor r1,r0	; 02305326
	lsl r0,r1,#0x10	; 02305328
	lsr r0,r0,#0x10	; 0230532A
	add sp,#0x4	; 0230532C
	pop {r4,r5}	; 0230532E
	pop {r3}	; 02305330
	bx r3	; 02305332
pool_02305334:
loc_02305334:
	.word P4_Data_023103D8	; 02305334
pool_02305338:
loc_02305338:
	.word 0x00000FFF	; 02305338

; ===== function loc_0230533C =====
loc_0230533C:
	push {r4,r5,r6,lr}	; 0230533C
	ldr r0,[pool_02305360]	; 0230533E
	ldr r6,[r0,#0x0]	; 02305340
	ldr r1,[pool_02305364]	; 02305342
	ldrh r5,[r6,r1]	; 02305344
	ldr r3,[pool_02305368]	; 02305346
	add r2,r6,r3	; 02305348
	ldrh r4,[r2,#0x0]	; 0230534A
	ldr r1,[pool_0230536C]	; 0230534C
	ldrh r1,[r6,r1]	; 0230534E
	mul r4,r1	; 02305350
	add r1,r5,r4	; 02305352
	strh r1,[r2,#0x0]	; 02305354
	ldr r0,[r0,#0x0]	; 02305356
	ldrh r0,[r0,r3]	; 02305358
	pop {r4,r5,r6}	; 0230535A
	pop {r3}	; 0230535C
	bx r3	; 0230535E
pool_02305360:
loc_02305360:
	.word FirmwareWlWorkPointerSlot	; 02305360
pool_02305364:
loc_02305364:
	.word 0x000005AA	; 02305364
pool_02305368:
loc_02305368:
	.word 0x000005AC	; 02305368
pool_0230536C:
loc_0230536C:
	.word 0x000005A8	; 0230536C

; ===== function loc_02305370 =====
loc_02305370:
	ldr r1,[pool_0230537C]	; 02305370
	ldr r2,[r1,#0x0]	; 02305372
	ldr r1,[pool_02305380]	; 02305374
	strh r0,[r2,r1]	; 02305376
	bx lr	; 02305378
	.byte 0xC0, 0x46	; 0230537C
pool_0230537C:
loc_0230537C:
	.word FirmwareWlWorkPointerSlot	; 0230537C
pool_02305380:
loc_02305380:
	.word 0x000005AC	; 02305380

; ===== function loc_02305384 =====
loc_02305384:
	push {r4,lr}	; 02305384
	ldr r2,[pool_023053A4]	; 02305386
	and r0,r2	; 02305388
	add r4,r0,#0x5	; 0230538A
	ldr r3,[pool_023053A8]	; 0230538C
	ldr r2,[r3,#0x0]	; 0230538E
	ldr r0,[pool_023053AC]	; 02305390
	strh r4,[r2,r0]	; 02305392
	mov r0,#0x1	; 02305394
	orr r1,r0	; 02305396
	ldr r2,[r3,#0x0]	; 02305398
	ldr r0,[pool_023053B0]	; 0230539A
	strh r1,[r2,r0]	; 0230539C
	pop {r4}	; 0230539E
	pop {r3}	; 023053A0
	bx r3	; 023053A2
pool_023053A4:
loc_023053A4:
	.word 0x0000FFF8	; 023053A4
pool_023053A8:
loc_023053A8:
	.word FirmwareWlWorkPointerSlot	; 023053A8
pool_023053AC:
loc_023053AC:
	.word 0x000005A8	; 023053AC
pool_023053B0:
loc_023053B0:
	.word 0x000005AA	; 023053B0

; ===== function loc_023053B4 =====
loc_023053B4:
	mov r1,#0x1	; 023053B4
	add r2,r0,#0x0	; 023053B6
	and r2,r1	; 023053B8
	cmp r2,#0x0	; 023053BA
	beq loc_023053CA	; 023053BC
	sub r0,r0,#0x1	; 023053BE
	ldrh r0,[r0,#0x0]	; 023053C0
	asr r0,r0,#0x8	; 023053C2
	lsl r0,r0,#0x18	; 023053C4
	lsr r0,r0,#0x18	; 023053C6
	b loc_023053D0	; 023053C8
loc_023053CA:
	ldrh r0,[r0,#0x0]	; 023053CA
	lsl r0,r0,#0x18	; 023053CC
	lsr r0,r0,#0x18	; 023053CE
loc_023053D0:
	lsl r0,r0,#0x18	; 023053D0
	lsr r0,r0,#0x18	; 023053D2
	bx lr	; 023053D4
	.byte 0x00, 0x00	; 023053D8

; ===== function loc_023053D8 =====
loc_023053D8:
	mov r2,#0x1	; 023053D8
	add r3,r0,#0x0	; 023053DA
	and r3,r2	; 023053DC
	cmp r3,#0x0	; 023053DE
	beq loc_023053F2	; 023053E0
	sub r3,r0,#0x1	; 023053E2
	ldrh r2,[r3,#0x0]	; 023053E4
	mov r0,#0xff	; 023053E6
	and r2,r0	; 023053E8
	lsl r0,r1,#0x8	; 023053EA
	orr r2,r0	; 023053EC
	strh r2,[r3,#0x0]	; 023053EE
	bx lr	; 023053F0
loc_023053F2:
	ldrh r3,[r0,#0x0]	; 023053F2
	ldr r2,[pool_02305404]	; 023053F4
	and r3,r2	; 023053F6
	mov r2,#0xff	; 023053F8
	and r1,r2	; 023053FA
	orr r3,r1	; 023053FC
	strh r3,[r0,#0x0]	; 023053FE
	bx lr	; 02305400
	.byte 0xC0, 0x46	; 02305404
pool_02305404:
loc_02305404:
	.word 0x0000FF00	; 02305404

; ===== function loc_02305408 =====
loc_02305408:
	push {r4,r5,r6,lr}	; 02305408
	add r5,r0,#0x0	; 0230540A
	add r6,r2,#0x0	; 0230540C
	add r4,r3,#0x0	; 0230540E
	mov r2,#0x12	; 02305410
	bl loc_02305464	; 02305412
	cmp r4,#0x0	; 02305416
	beq loc_02305428	; 02305418
	add r5,#0x28	; 0230541A
	add r0,r5,#0x0	; 0230541C
	add r1,r6,#0x0	; 0230541E
	add r2,r4,#0x1	; 02305420
	lsr r2,r2,#0x1	; 02305422
	bl loc_02305464	; 02305424
loc_02305428:
	pop {r4,r5,r6}	; 02305428
	pop {r3}	; 0230542A
	bx r3	; 0230542C
	.byte 0x00, 0x00	; 02305430

; ===== function loc_02305430 =====
loc_02305430:
	push {r4,r5,r6,lr}	; 02305430
	add r5,r0,#0x0	; 02305432
	add r6,r2,#0x0	; 02305434
	add r4,r3,#0x0	; 02305436
	mov r2,#0x12	; 02305438
	bl loc_02305464	; 0230543A
	cmp r4,#0x0	; 0230543E
	beq loc_02305450	; 02305440
	add r5,#0x24	; 02305442
	add r0,r5,#0x0	; 02305444
	add r1,r6,#0x0	; 02305446
	add r2,r4,#0x1	; 02305448
	lsr r2,r2,#0x1	; 0230544A
	bl loc_02305464	; 0230544C
loc_02305450:
	pop {r4,r5,r6}	; 02305450
	pop {r3}	; 02305452
	bx r3	; 02305454
	.byte 0x00, 0x00	; 02305458

; ===== function loc_02305458 =====
loc_02305458:
	add r2,r2,#0x1	; 02305458
	lsr r2,r2,#0x1	; 0230545A
	ldr r3,[pool_02305460]	; 0230545C
	bx r3	; 0230545E
pool_02305460:
loc_02305460:
	.word loc_02305464 + 1	; 02305460

; ===== function loc_02305464 =====
loc_02305464:
	push {r4,r5,r6,r7,lr}	; 02305464
	sub sp,#0x4	; 02305466
	add r5,r0,#0x0	; 02305468
	add r4,r1,#0x0	; 0230546A
	add r7,r2,#0x0	; 0230546C
	ldr r0,[pool_023054C8]	; 0230546E
	ldr r1,[r0,#0x0]	; 02305470
	ldr r0,[pool_023054CC]	; 02305472
	ldr r1,[r1,r0]	; 02305474
	mov r0,#0xc	; 02305476
	mul r1,r0	; 02305478
	ldr r0,[pool_023054D0]	; 0230547A
	add r6,r1,r0	; 0230547C
	ldr r0,[pool_023054D4]	; 0230547E
	bl loc_02304B48	; 02305480
	str r0,[sp,#0x0]	; 02305484
	mov r2,#0x0	; 02305486
	b loc_023054B4	; 02305488
loc_0230548A:
	sub r3,r7,r2	; 0230548A
	ldr r0,[pool_023054C8]	; 0230548C
	ldr r1,[r0,#0x0]	; 0230548E
	ldr r0,[pool_023054D8]	; 02305490
	ldr r0,[r1,r0]	; 02305492
	cmp r3,r0	; 02305494
	bls loc_0230549A	; 02305496
	add r3,r0,#0x0	; 02305498
loc_0230549A:
	ldr r0,[pool_023054DC]	; 0230549A
	strh r5,[r0,#0x0]	; 0230549C
	str r4,[r6,#0x0]	; 0230549E
	ldr r0,[pool_023054E0]	; 023054A0
	str r0,[r6,#0x4]	; 023054A2
	add r1,r3,#0x0	; 023054A4
	ldr r0,[pool_023054E4]	; 023054A6
	orr r1,r0	; 023054A8
	str r1,[r6,#0x8]	; 023054AA
	lsl r0,r3,#0x1	; 023054AC
	add r4,r4,r0	; 023054AE
	add r5,r5,r0	; 023054B0
	add r2,r2,r3	; 023054B2
loc_023054B4:
	cmp r2,r7	; 023054B4
	bcc loc_0230548A	; 023054B6
	ldr r0,[sp,#0x0]	; 023054B8
	bl loc_02304B58	; 023054BA
	add sp,#0x4	; 023054BE
	pop {r4,r5,r6,r7}	; 023054C0
	pop {r3}	; 023054C2
	bx r3	; 023054C4
	.byte 0xC0, 0x46	; 023054C8
pool_023054C8:
loc_023054C8:
	.word FirmwareWlWorkPointerSlot	; 023054C8
pool_023054CC:
loc_023054CC:
	.word 0x000002D0	; 023054CC
pool_023054D0:
loc_023054D0:
	.word REG_DMA0SAD	; 023054D0
pool_023054D4:
loc_023054D4:
	.word 0x01000000	; 023054D4
pool_023054D8:
loc_023054D8:
	.word 0x000002D4	; 023054D8
pool_023054DC:
loc_023054DC:
	.word REG_WIFI_TXBUF_WR_ADDR	; 023054DC
pool_023054E0:
loc_023054E0:
	.word 0x04808070	; 023054E0
pool_023054E4:
loc_023054E4:
	.word 0x80400000	; 023054E4

; ===== function loc_023054E8 =====
loc_023054E8:
	push {r4,r5,r6,r7,lr}	; 023054E8
	sub sp,#0xc	; 023054EA
	add r7,r0,#0x0	; 023054EC
	add r5,r1,#0x0	; 023054EE
	add r0,r2,#0x1	; 023054F0
	lsr r0,r0,#0x1	; 023054F2
	str r0,[sp,#0x0]	; 023054F4
	ldr r0,[pool_02305564]	; 023054F6
	ldr r1,[r0,#0x0]	; 023054F8
	ldr r0,[pool_02305568]	; 023054FA
	ldr r1,[r1,r0]	; 023054FC
	mov r0,#0xc	; 023054FE
	mul r1,r0	; 02305500
	ldr r0,[pool_0230556C]	; 02305502
	add r0,r1,r0	; 02305504
	str r0,[sp,#0x4]	; 02305506
	mov r6,#0x0	; 02305508
	b loc_02305556	; 0230550A
loc_0230550C:
	ldr r0,[sp,#0x0]	; 0230550C
	sub r4,r0,r6	; 0230550E
	ldr r0,[pool_02305564]	; 02305510
	ldr r1,[r0,#0x0]	; 02305512
	ldr r0,[pool_02305570]	; 02305514
	ldr r0,[r1,r0]	; 02305516
	cmp r4,r0	; 02305518
	bls loc_0230551E	; 0230551A
	add r4,r0,#0x0	; 0230551C
loc_0230551E:
	ldr r0,[pool_02305574]	; 0230551E
	bl loc_02304B48	; 02305520
	ldr r1,[pool_02305578]	; 02305524
	strh r5,[r1,#0x0]	; 02305526
	ldr r2,[pool_0230557C]	; 02305528
	ldr r1,[sp,#0x4]	; 0230552A
	str r2,[r1,#0x0]	; 0230552C
	str r7,[r1,#0x4]	; 0230552E
	add r1,r4,#0x0	; 02305530
	ldr r2,[pool_02305580]	; 02305532
	orr r1,r2	; 02305534
	ldr r2,[sp,#0x4]	; 02305536
	str r1,[r2,#0x8]	; 02305538
	bl loc_02304B58	; 0230553A
	lsl r0,r4,#0x1	; 0230553E
	add r7,r7,r0	; 02305540
	add r5,r5,r0	; 02305542
	ldr r0,[pool_02305584]	; 02305544
	cmp r5,r0	; 02305546
	bcc loc_02305554	; 02305548
	ldr r0,[pool_02305564]	; 0230554A
	ldr r1,[r0,#0x0]	; 0230554C
	ldr r0,[pool_02305588]	; 0230554E
	ldrh r0,[r1,r0]	; 02305550
	sub r5,r5,r0	; 02305552
loc_02305554:
	add r6,r6,r4	; 02305554
loc_02305556:
	ldr r0,[sp,#0x0]	; 02305556
	cmp r6,r0	; 02305558
	bcc loc_0230550C	; 0230555A
	add sp,#0xc	; 0230555C
	pop {r4,r5,r6,r7}	; 0230555E
	pop {r3}	; 02305560
	bx r3	; 02305562
pool_02305564:
loc_02305564:
	.word FirmwareWlWorkPointerSlot	; 02305564
pool_02305568:
loc_02305568:
	.word 0x000002D0	; 02305568
pool_0230556C:
loc_0230556C:
	.word REG_DMA0SAD	; 0230556C
pool_02305570:
loc_02305570:
	.word 0x000002D4	; 02305570
pool_02305574:
loc_02305574:
	.word 0x01000000	; 02305574
pool_02305578:
loc_02305578:
	.word REG_WIFI_RXBUF_RD_ADDR	; 02305578
pool_0230557C:
loc_0230557C:
	.word 0x04808060	; 0230557C
pool_02305580:
loc_02305580:
	.word 0x81000000	; 02305580
pool_02305584:
loc_02305584:
	.word 0x04805F60	; 02305584
pool_02305588:
loc_02305588:
	.word 0x00000396	; 02305588

; ===== function loc_0230558C =====
loc_0230558C:
	ldr r0,[pool_02305598]	; 0230558C
	ldr r1,[r0,#0x0]	; 0230558E
	ldr r0,[pool_0230559C]	; 02305590
	add r0,r1,r0	; 02305592
	ldr r3,[pool_023055A0]	; 02305594
	bx r3	; 02305596
pool_02305598:
loc_02305598:
	.word FirmwareWlWorkPointerSlot	; 02305598
pool_0230559C:
loc_0230559C:
	.word 0x000005EC	; 0230559C
pool_023055A0:
loc_023055A0:
	.word loc_037FC5A0 + 1	; 023055A0

; ===== function loc_023055A4 =====
loc_023055A4:
	push {r4,r5,lr}	; 023055A4
	sub sp,#0x4	; 023055A6
	add r5,r0,#0x0	; 023055A8
	add r4,r1,#0x0	; 023055AA
	bl loc_0230558C	; 023055AC
	ldr r0,[pool_023055D8]	; 023055B0
	mul r5,r0	; 023055B2
	lsr r0,r5,#0x6	; 023055B4
	ldr r1,[pool_023055DC]	; 023055B6
	bl loc_023055E8	; 023055B8
	add r1,r0,#0x0	; 023055BC
	mov r2,#0x0	; 023055BE
	str r2,[sp,#0x0]	; 023055C0
	ldr r0,[pool_023055E0]	; 023055C2
	ldr r3,[r0,#0x0]	; 023055C4
	ldr r0,[pool_023055E4]	; 023055C6
	add r0,r3,r0	; 023055C8
	add r3,r4,#0x0	; 023055CA
	bl loc_023012C8	; 023055CC
	add sp,#0x4	; 023055D0
	pop {r4,r5}	; 023055D2
	pop {r3}	; 023055D4
	bx r3	; 023055D6
pool_023055D8:
loc_023055D8:
	.word 0x000082EA	; 023055D8
pool_023055DC:
loc_023055DC:
	.word 0x000003E8	; 023055DC
pool_023055E0:
loc_023055E0:
	.word FirmwareWlWorkPointerSlot	; 023055E0
pool_023055E4:
loc_023055E4:
	.word 0x000005EC	; 023055E4

; ===== function loc_023055E8 =====
loc_023055E8:
	bx pc	; 023055E8
	.byte 0xC0, 0x46	; 023055EC
.arm

; ===== function loc_023055EC =====
loc_023055EC:
	ldr pc,[pool_023055F0]	; 023055EC
pool_023055F0:
loc_023055F0:
	.word loc_03802720	; 023055F0
.thumb

; ===== function loc_023055F4 =====
loc_023055F4:
	push {r4,r5,lr}	; 023055F4
	sub sp,#0x4	; 023055F6
	add r5,r0,#0x0	; 023055F8
	add r4,r1,#0x0	; 023055FA
	bl loc_0230558C	; 023055FC
	mov r2,#0x0	; 02305600
	str r2,[sp,#0x0]	; 02305602
	ldr r0,[pool_02305620]	; 02305604
	ldr r1,[r0,#0x0]	; 02305606
	ldr r0,[pool_02305624]	; 02305608
	add r0,r1,r0	; 0230560A
	ldr r1,[pool_02305628]	; 0230560C
	mul r5,r1	; 0230560E
	lsr r1,r5,#0x6	; 02305610
	add r3,r4,#0x0	; 02305612
	bl loc_023012C8	; 02305614
	add sp,#0x4	; 02305618
	pop {r4,r5}	; 0230561A
	pop {r3}	; 0230561C
	bx r3	; 0230561E
pool_02305620:
loc_02305620:
	.word FirmwareWlWorkPointerSlot	; 02305620
pool_02305624:
loc_02305624:
	.word 0x000005EC	; 02305624
pool_02305628:
loc_02305628:
	.word 0x000082EA	; 02305628
P4_Code_0230562C:
	push {lr}	; 0230562C
	sub sp,#0x4	; 0230562E
	ldr r0,[pool_02305684]	; 02305630
	ldr r1,[r0,#0x0]	; 02305632
	ldr r0,[pool_02305688]	; 02305634
	add r1,r1,r0	; 02305636
	ldr r0,[r1,#0x0]	; 02305638
	add r0,r0,#0x1	; 0230563A
	str r0,[r1,#0x0]	; 0230563C
	mov r0,#0x1	; 0230563E
	mov r1,#0xa	; 02305640
	bl loc_02304B68	; 02305642
	mov r0,#0x2	; 02305646
	mov r1,#0x12	; 02305648
	bl loc_02304B68	; 0230564A
	mov r0,#0x1	; 0230564E
	mov r1,#0x11	; 02305650
	bl loc_02304B68	; 02305652
	ldr r0,[pool_02305684]	; 02305656
	ldr r1,[r0,#0x0]	; 02305658
	ldr r0,[pool_0230568C]	; 0230565A
	ldrh r0,[r1,r0]	; 0230565C
	cmp r0,#0x0	; 0230565E
	beq loc_0230566A	; 02305660
	mov r0,#0x2	; 02305662
	mov r1,#0x13	; 02305664
	bl loc_02304B68	; 02305666
loc_0230566A:
	ldr r0,[pool_02305684]	; 0230566A
	ldr r1,[r0,#0x0]	; 0230566C
	ldr r0,[pool_02305690]	; 0230566E
	ldrh r0,[r1,r0]	; 02305670
	cmp r0,#0x0	; 02305672
	beq loc_0230567E	; 02305674
	mov r0,#0x2	; 02305676
	mov r1,#0x15	; 02305678
	bl loc_02304B68	; 0230567A
loc_0230567E:
	add sp,#0x4	; 0230567E
	pop {r3}	; 02305680
	bx r3	; 02305682
pool_02305684:
loc_02305684:
	.word FirmwareWlWorkPointerSlot	; 02305684
pool_02305688:
loc_02305688:
	.word 0x000003A4	; 02305688
pool_0230568C:
loc_0230568C:
	.word 0x000001C0	; 0230568C
pool_02305690:
loc_02305690:
	.word 0x000003AC	; 02305690

; ===== function loc_02305694 =====
loc_02305694:
	ldr r0,[pool_023056A0]	; 02305694
	ldr r1,[r0,#0x0]	; 02305696
	ldr r0,[pool_023056A4]	; 02305698
	add r0,r1,r0	; 0230569A
	ldr r3,[pool_023056A8]	; 0230569C
	bx r3	; 0230569E
pool_023056A0:
loc_023056A0:
	.word FirmwareWlWorkPointerSlot	; 023056A0
pool_023056A4:
loc_023056A4:
	.word 0x000005C0	; 023056A4
pool_023056A8:
loc_023056A8:
	.word loc_037FC5A0 + 1	; 023056A8

; ===== function loc_023056AC =====
loc_023056AC:
	push {r4,r5,r6,r7,lr}	; 023056AC
	sub sp,#0xc	; 023056AE
	add r5,r0,#0x0	; 023056B0
	add r4,r1,#0x0	; 023056B2
	ldr r0,[pool_023056F0]	; 023056B4
	ldr r1,[r0,#0x0]	; 023056B6
	ldr r0,[pool_023056F4]	; 023056B8
	add r0,r1,r0	; 023056BA
	bl loc_02300FC8	; 023056BC
	ldr r0,[pool_023056F8]	; 023056C0
	mul r5,r0	; 023056C2
	lsr r5,r5,#0x6	; 023056C4
	bl loc_023056FC	; 023056C6
	mov r7,#0x0	; 023056CA
	add r6,r5,r0	; 023056CC
	lsl r2,r7,#0	; 023056CE
	adc r2,r1	; 023056D0
	str r4,[sp,#0x4]	; 023056D2
	str r7,[sp,#0x8]	; 023056D4
	add r3,r5,#0x0	; 023056D6
	str r7,[sp,#0x0]	; 023056D8
	ldr r0,[pool_023056F0]	; 023056DA
	ldr r1,[r0,#0x0]	; 023056DC
	ldr r0,[pool_023056F4]	; 023056DE
	add r0,r1,r0	; 023056E0
	add r1,r6,#0x0	; 023056E2
	bl loc_0230570C	; 023056E4
	add sp,#0xc	; 023056E8
	pop {r4,r5,r6,r7}	; 023056EA
	pop {r3}	; 023056EC
	bx r3	; 023056EE
pool_023056F0:
loc_023056F0:
	.word FirmwareWlWorkPointerSlot	; 023056F0
pool_023056F4:
loc_023056F4:
	.word 0x000005C0	; 023056F4
pool_023056F8:
loc_023056F8:
	.word 0x000082EA	; 023056F8

; ===== function loc_023056FC =====
loc_023056FC:
	bx pc	; 023056FC
	.byte 0xC0, 0x46	; 02305700
.arm

; ===== function loc_02305700 =====
loc_02305700:
	ldr r12,[pool_02305708]	; 02305700
	bx r12	; 02305704
pool_02305708:
loc_02305708:
	.word loc_037FC3AC + 1	; 02305708
.thumb

; ===== function loc_0230570C =====
loc_0230570C:
	bx pc	; 0230570C
	.byte 0xC0, 0x46	; 02305710
.arm

; ===== function loc_02305710 =====
loc_02305710:
	ldr r12,[pool_02305718]	; 02305710
	bx r12	; 02305714
pool_02305718:
loc_02305718:
	.word loc_037FC5FC + 1	; 02305718
.thumb

; ===== function loc_0230571C =====
loc_0230571C:
	push {lr}	; 0230571C
	sub sp,#0xc	; 0230571E
	mov r1,#0x1	; 02305720
	str r1,[sp,#0x4]	; 02305722
	ldr r1,[pool_02305754]	; 02305724
	mul r0,r1	; 02305726
	lsr r0,r0,#0x6	; 02305728
	ldr r1,[pool_02305758]	; 0230572A
	bl loc_02305768	; 0230572C
	add r1,r0,#0x0	; 02305730
	add r0,sp,#0x4	; 02305732
	str r0,[sp,#0x0]	; 02305734
	ldr r0,[pool_0230575C]	; 02305736
	ldr r2,[r0,#0x0]	; 02305738
	ldr r0,[pool_02305760]	; 0230573A
	add r0,r2,r0	; 0230573C
	mov r2,#0x0	; 0230573E
	ldr r3,[pool_02305764]	; 02305740
	bl loc_023012C8	; 02305742
loc_02305746:
	ldr r0,[sp,#0x4]	; 02305746
	cmp r0,#0x0	; 02305748
	bne loc_02305746	; 0230574A
	add sp,#0xc	; 0230574C
	pop {r3}	; 0230574E
	bx r3	; 02305750
	.byte 0xC0, 0x46	; 02305754
pool_02305754:
loc_02305754:
	.word 0x000082EA	; 02305754
pool_02305758:
loc_02305758:
	.word 0x000003E8	; 02305758
pool_0230575C:
loc_0230575C:
	.word FirmwareWlWorkPointerSlot	; 0230575C
pool_02305760:
loc_02305760:
	.word 0x000005EC	; 02305760
pool_02305764:
loc_02305764:
	.word P4_Code_023057C4 + 1	; 02305764

; ===== function loc_02305768 =====
loc_02305768:
	bx pc	; 02305768
	.byte 0xC0, 0x46	; 0230576C
.arm

; ===== function loc_0230576C =====
loc_0230576C:
	ldr pc,[pool_02305770]	; 0230576C
pool_02305770:
loc_02305770:
	.word loc_03802720	; 02305770
.thumb

; ===== function loc_02305774 =====
loc_02305774:
	push {lr}	; 02305774
	sub sp,#0xc	; 02305776
	mov r1,#0x1	; 02305778
	str r1,[sp,#0x4]	; 0230577A
	ldr r1,[pool_023057A8]	; 0230577C
	mul r0,r1	; 0230577E
	mov r1,#0x40	; 02305780
	bl loc_023057B8	; 02305782
	add r1,r0,#0x0	; 02305786
	add r0,sp,#0x4	; 02305788
	str r0,[sp,#0x0]	; 0230578A
	ldr r0,[pool_023057AC]	; 0230578C
	ldr r2,[r0,#0x0]	; 0230578E
	ldr r0,[pool_023057B0]	; 02305790
	add r0,r2,r0	; 02305792
	asr r2,r1,#0x1f	; 02305794
	ldr r3,[pool_023057B4]	; 02305796
	bl loc_023012C8	; 02305798
loc_0230579C:
	ldr r0,[sp,#0x4]	; 0230579C
	cmp r0,#0x0	; 0230579E
	bne loc_0230579C	; 023057A0
	add sp,#0xc	; 023057A2
	pop {r3}	; 023057A4
	bx r3	; 023057A6
pool_023057A8:
loc_023057A8:
	.word 0x000082EA	; 023057A8
pool_023057AC:
loc_023057AC:
	.word FirmwareWlWorkPointerSlot	; 023057AC
pool_023057B0:
loc_023057B0:
	.word 0x000005EC	; 023057B0
pool_023057B4:
loc_023057B4:
	.word P4_Code_023057C4 + 1	; 023057B4

; ===== function loc_023057B8 =====
loc_023057B8:
	bx pc	; 023057B8
	.byte 0xC0, 0x46	; 023057BC
.arm

; ===== function loc_023057BC =====
loc_023057BC:
	ldr pc,[pool_023057C0]	; 023057BC
pool_023057C0:
loc_023057C0:
	.word loc_03802514	; 023057C0
.thumb
P4_Code_023057C4:
	mov r1,#0x0	; 023057C4
	str r1,[r0,#0x0]	; 023057C6
	bx lr	; 023057C8
	.byte 0x00, 0x00	; 023057CC

; ===== function loc_023057CC =====
loc_023057CC:
	push {lr}	; 023057CC
	sub sp,#0x4	; 023057CE
	bl loc_02305818	; 023057D0
	cmp r0,#0x0	; 023057D4
	beq loc_023057F2	; 023057D6
	ldr r0,[pool_02305808]	; 023057D8
	ldr r1,[r0,#0x0]	; 023057DA
	ldr r0,[pool_0230580C]	; 023057DC
	add r0,r1,r0	; 023057DE
	bl loc_02304538	; 023057E0
	ldr r0,[pool_02305808]	; 023057E4
	ldr r1,[r0,#0x0]	; 023057E6
	ldr r0,[pool_02305810]	; 023057E8
	add r0,r1,r0	; 023057EA
	bl loc_02304538	; 023057EC
	b loc_02305802	; 023057F0
loc_023057F2:
	ldr r0,[pool_02305808]	; 023057F2
	ldr r1,[r0,#0x0]	; 023057F4
	ldr r0,[pool_02305814]	; 023057F6
	add r2,r1,r0	; 023057F8
	ldrh r1,[r2,#0x0]	; 023057FA
	mov r0,#0x40	; 023057FC
	orr r1,r0	; 023057FE
	strh r1,[r2,#0x0]	; 02305800
loc_02305802:
	add sp,#0x4	; 02305802
	pop {r3}	; 02305804
	bx r3	; 02305806
pool_02305808:
loc_02305808:
	.word FirmwareWlWorkPointerSlot	; 02305808
pool_0230580C:
loc_0230580C:
	.word 0x000005C0	; 0230580C
pool_02305810:
loc_02305810:
	.word 0x000005EC	; 02305810
pool_02305814:
loc_02305814:
	.word 0x00000302	; 02305814

; ===== function loc_02305818 =====
loc_02305818:
	bx pc	; 02305818
	.byte 0xC0, 0x46	; 0230581C
.arm

; ===== function loc_0230581C =====
loc_0230581C:
	ldr r12,[pool_02305824]	; 0230581C
	bx r12	; 02305820
pool_02305824:
loc_02305824:
	.word loc_037FC780 + 1	; 02305824
.thumb

; ===== function loc_02305828 =====
loc_02305828:
	push {r4,r5,r6,r7,lr}	; 02305828
	sub sp,#0xc	; 0230582A
	mov r5,#0x0	; 0230582C
	str r5,[sp,#0x4]	; 0230582E
	ldr r6,[pool_02305908]	; 02305830
	ldr r7,[pool_0230590C]	; 02305832
loc_02305834:
	lsl r4,r5,#0x1	; 02305834
	add r0,r4,#0x0	; 02305836
	add r0,#0x44	; 02305838
	mov r1,#0x2	; 0230583A
	add r2,sp,#0x4	; 0230583C
	bl loc_02310198	; 0230583E
	ldr r1,[sp,#0x4]	; 02305842
	ldrh r0,[r6,r4]	; 02305844
	strh r1,[r0,r7]	; 02305846
	add r5,r5,#0x1	; 02305848
	cmp r5,#0x10	; 0230584A
	bcc loc_02305834	; 0230584C
	ldr r0,[pool_02305910]	; 0230584E
	ldr r2,[r0,#0x0]	; 02305850
	ldr r1,[pool_02305914]	; 02305852
	ldrh r2,[r2,r1]	; 02305854
	lsr r2,r2,#0x7	; 02305856
	lsl r4,r2,#0x8	; 02305858
	str r4,[sp,#0x0]	; 0230585A
	ldr r2,[r0,#0x0]	; 0230585C
	ldrh r3,[r2,r1]	; 0230585E
	mov r2,#0x7f	; 02305860
	and r3,r2	; 02305862
	orr r4,r3	; 02305864
	str r4,[sp,#0x0]	; 02305866
	ldr r3,[pool_02305918]	; 02305868
	strh r4,[r3,#0x0]	; 0230586A
	mov r5,#0xce	; 0230586C
	ldr r6,[r0,#0x0]	; 0230586E
	ldrh r0,[r6,r1]	; 02305870
	and r0,r2	; 02305872
	add r0,r0,#0x7	; 02305874
	mov r1,#0x8	; 02305876
	bl loc_02305934	; 02305878
	add r7,r0,#0x0	; 0230587C
	ldr r0,[pool_0230591C]	; 0230587E
	ldrh r4,[r6,r0]	; 02305880
	ldr r0,[pool_02305920]	; 02305882
	ldrh r0,[r6,r0]	; 02305884
	cmp r0,#0x3	; 02305886
	bne loc_023058C4	; 02305888
	add r0,r4,#0x0	; 0230588A
	add r0,#0xce	; 0230588C
	mov r1,#0x1	; 0230588E
	ldr r2,[pool_02305924]	; 02305890
	add r2,r6,r2	; 02305892
	bl loc_02310198	; 02305894
	mov r6,#0x0	; 02305898
	add r7,r6,#0x0	; 0230589A
	b loc_023058BE	; 0230589C
loc_0230589E:
	str r7,[sp,#0x0]	; 0230589E
	add r0,r5,#0x0	; 023058A0
	mov r1,#0x1	; 023058A2
	add r2,sp,#0x0	; 023058A4
	bl loc_02310198	; 023058A6
	ldr r0,[sp,#0x0]	; 023058AA
	lsl r2,r6,#0x8	; 023058AC
	ldr r1,[pool_02305928]	; 023058AE
	add r1,r2,r1	; 023058B0
	orr r0,r1	; 023058B2
	str r0,[sp,#0x0]	; 023058B4
	bl loc_02305A68	; 023058B6
	add r6,r6,#0x1	; 023058BA
	add r5,r5,#0x1	; 023058BC
loc_023058BE:
	cmp r6,r4	; 023058BE
	bcc loc_0230589E	; 023058C0
	b loc_023058FE	; 023058C2
loc_023058C4:
	mov r0,#0x0	; 023058C4
	str r0,[sp,#0x0]	; 023058C6
	ldr r6,[pool_02305910]	; 023058C8
	b loc_023058FA	; 023058CA
loc_023058CC:
	add r0,r5,#0x0	; 023058CC
	add r1,r7,#0x0	; 023058CE
	add r2,sp,#0x0	; 023058D0
	bl loc_02310198	; 023058D2
	ldr r0,[sp,#0x0]	; 023058D6
	bl loc_02305A68	; 023058D8
	ldr r1,[r6,#0x0]	; 023058DC
	ldr r0,[pool_02305920]	; 023058DE
	ldrh r0,[r1,r0]	; 023058E0
	cmp r0,#0x2	; 023058E2
	bne loc_023058F6	; 023058E4
	ldr r0,[sp,#0x0]	; 023058E6
	lsr r2,r0,#0x12	; 023058E8
	cmp r2,#0x9	; 023058EA
	bne loc_023058F6	; 023058EC
	ldr r2,[pool_0230592C]	; 023058EE
	and r0,r2	; 023058F0
	ldr r2,[pool_02305930]	; 023058F2
	str r0,[r1,r2]	; 023058F4
loc_023058F6:
	sub r4,r4,#0x1	; 023058F6
	add r5,r5,r7	; 023058F8
loc_023058FA:
	cmp r4,#0x0	; 023058FA
	bne loc_023058CC	; 023058FC
loc_023058FE:
	add sp,#0xc	; 023058FE
	pop {r4,r5,r6,r7}	; 02305900
	pop {r3}	; 02305902
	bx r3	; 02305904
	.byte 0xC0, 0x46	; 02305908
pool_02305908:
loc_02305908:
	.word 0x023103F8	; 02305908
pool_0230590C:
loc_0230590C:
	.word WifiIoWs1Base	; 0230590C
pool_02305910:
loc_02305910:
	.word FirmwareWlWorkPointerSlot	; 02305910
pool_02305914:
loc_02305914:
	.word 0x000005B2	; 02305914
pool_02305918:
loc_02305918:
	.word REG_WIFI_RF_CNT	; 02305918
pool_0230591C:
loc_0230591C:
	.word 0x000005B4	; 0230591C
pool_02305920:
loc_02305920:
	.word 0x000005B0	; 02305920
pool_02305924:
loc_02305924:
	.word 0x000005B8	; 02305924
pool_02305928:
loc_02305928:
	.word 0x00050000	; 02305928
pool_0230592C:
loc_0230592C:
	.word 0xFFFF83FF	; 0230592C
pool_02305930:
loc_02305930:
	.word 0x000005BC	; 02305930

; ===== function loc_02305934 =====
loc_02305934:
	bx pc	; 02305934
	.byte 0xC0, 0x46	; 02305938
.arm

; ===== function loc_02305938 =====
loc_02305938:
	ldr pc,[pool_0230593C]	; 02305938
pool_0230593C:
loc_0230593C:
	.word loc_03802514	; 0230593C
.thumb

; ===== function loc_02305940 =====
loc_02305940:
	push {r4,r5,r6,r7,lr}	; 02305940
	sub sp,#0x4	; 02305942
	ldr r1,[pool_02305978]	; 02305944
	ldr r0,[pool_0230597C]	; 02305946
	strh r1,[r0,#0x0]	; 02305948
	mov r4,#0x64	; 0230594A
	mov r5,#0x0	; 0230594C
	str r5,[sp,#0x0]	; 0230594E
	mov r6,#0x1	; 02305950
	add r7,sp,#0x0	; 02305952
loc_02305954:
	add r0,r4,#0x0	; 02305954
	add r1,r6,#0x0	; 02305956
	add r2,r7,#0x0	; 02305958
	bl loc_02310198	; 0230595A
	add r0,r5,#0x0	; 0230595E
	ldr r1,[sp,#0x0]	; 02305960
	bl loc_02305A98	; 02305962
	add r4,r4,#0x1	; 02305966
	add r5,r5,#0x1	; 02305968
	cmp r5,#0x69	; 0230596A
	bcc loc_02305954	; 0230596C
	add sp,#0x4	; 0230596E
	pop {r4,r5,r6,r7}	; 02305970
	pop {r3}	; 02305972
	bx r3	; 02305974
	.byte 0xC0, 0x46	; 02305978
pool_02305978:
loc_02305978:
	.word 0x00000100	; 02305978
pool_0230597C:
loc_0230597C:
	.word REG_WIFI_BB_MODE	; 0230597C

; ===== function loc_02305980 =====
loc_02305980:
	push {r4,lr}	; 02305980
	mov r4,#0x0	; 02305982
	ldr r3,[pool_023059A0]	; 02305984
	ldr r0,[pool_023059A4]	; 02305986
loc_02305988:
	lsl r1,r4,#0x2	; 02305988
	add r2,r3,r1	; 0230598A
	ldrh r2,[r2,#0x2]	; 0230598C
	ldrh r1,[r3,r1]	; 0230598E
	strh r2,[r1,r0]	; 02305990
	add r4,r4,#0x1	; 02305992
	cmp r4,#0x16	; 02305994
	bcc loc_02305988	; 02305996
	pop {r4}	; 02305998
	pop {r3}	; 0230599A
	bx r3	; 0230599C
	.byte 0xC0, 0x46	; 023059A0
pool_023059A0:
loc_023059A0:
	.word P4_Data_02310468	; 023059A0
pool_023059A4:
loc_023059A4:
	.word WifiIoWs1Base	; 023059A4

; ===== function loc_023059A8 =====
loc_023059A8:
	push {lr}	; 023059A8
	sub sp,#0x4	; 023059AA
	mov r1,#0x0	; 023059AC
	add r0,sp,#0x0	; 023059AE
	strh r1,[r0,#0x0]	; 023059B0
	ldrh r0,[r0,#0x0]	; 023059B2
	ldr r1,[pool_02305A08]	; 023059B4
	ldr r2,[r1,#0x0]	; 023059B6
	ldr r1,[pool_02305A0C]	; 023059B8
	add r1,r2,r1	; 023059BA
	mov r2,#0x10	; 023059BC
	bl loc_02305A1C	; 023059BE
	mov r0,#0x40	; 023059C2
	mov r1,#0x1	; 023059C4
	ldr r2,[pool_02305A08]	; 023059C6
	ldr r3,[r2,#0x0]	; 023059C8
	ldr r2,[pool_02305A0C]	; 023059CA
	add r2,r3,r2	; 023059CC
	bl loc_02310198	; 023059CE
	mov r0,#0x41	; 023059D2
	mov r1,#0x1	; 023059D4
	ldr r2,[pool_02305A08]	; 023059D6
	ldr r3,[r2,#0x0]	; 023059D8
	ldr r2,[pool_02305A10]	; 023059DA
	add r2,r3,r2	; 023059DC
	bl loc_02310198	; 023059DE
	mov r0,#0x42	; 023059E2
	mov r1,#0x1	; 023059E4
	ldr r2,[pool_02305A08]	; 023059E6
	ldr r3,[r2,#0x0]	; 023059E8
	ldr r2,[pool_02305A14]	; 023059EA
	add r2,r3,r2	; 023059EC
	bl loc_02310198	; 023059EE
	mov r0,#0x43	; 023059F2
	mov r1,#0x1	; 023059F4
	ldr r2,[pool_02305A08]	; 023059F6
	ldr r3,[r2,#0x0]	; 023059F8
	ldr r2,[pool_02305A18]	; 023059FA
	add r2,r3,r2	; 023059FC
	bl loc_02310198	; 023059FE
	add sp,#0x4	; 02305A02
	pop {r3}	; 02305A04
	bx r3	; 02305A06
pool_02305A08:
loc_02305A08:
	.word FirmwareWlWorkPointerSlot	; 02305A08
pool_02305A0C:
loc_02305A0C:
	.word 0x000005B0	; 02305A0C
pool_02305A10:
loc_02305A10:
	.word 0x000005B2	; 02305A10
pool_02305A14:
loc_02305A14:
	.word 0x000005B4	; 02305A14
pool_02305A18:
loc_02305A18:
	.word 0x000005B6	; 02305A18

; ===== function loc_02305A1C =====
loc_02305A1C:
	bx pc	; 02305A1C
	.byte 0xC0, 0x46	; 02305A20
.arm

; ===== function loc_02305A20 =====
loc_02305A20:
	ldr pc,[pool_02305A24]	; 02305A20
pool_02305A24:
loc_02305A24:
	.word loc_037FCE04	; 02305A24
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x64, 0x25, 0x00, 0x26, 0x00, 0x96, 0x34, 0x1C, 0x80, 0x27, 0x28, 0x1C	; 02305A38
	.byte 0x01, 0x21, 0x00, 0xAA, 0x0A, 0xF0, 0xAC, 0xFB, 0x01, 0x2C, 0x02, 0xD1, 0x00, 0x98, 0x38, 0x40	; 02305A48
	.byte 0x00, 0x90, 0x00, 0x98, 0x00, 0x06, 0x00, 0x0E, 0x31, 0x1C, 0xFF, 0xF7, 0x47, 0xFC, 0x06, 0x1C	; 02305A58
	.byte 0x6D, 0x1C, 0x64, 0x1C, 0x69, 0x2C, 0xEA, 0xD3, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 02305A68
.thumb

; ===== function loc_02305A68 =====
loc_02305A68:
	ldr r2,[pool_02305A8C]	; 02305A68
	mov r1,#0x1	; 02305A6A
loc_02305A6C:
	ldrh r3,[r2,#0x0]	; 02305A6C
	and r3,r1	; 02305A6E
	cmp r3,#0x0	; 02305A70
	bne loc_02305A6C	; 02305A72
	ldr r1,[pool_02305A90]	; 02305A74
	strh r0,[r1,#0x0]	; 02305A76
	lsr r1,r0,#0x10	; 02305A78
	ldr r0,[pool_02305A94]	; 02305A7A
	strh r1,[r0,#0x0]	; 02305A7C
	ldr r1,[pool_02305A8C]	; 02305A7E
	mov r0,#0x1	; 02305A80
loc_02305A82:
	ldrh r2,[r1,#0x0]	; 02305A82
	and r2,r0	; 02305A84
	cmp r2,#0x0	; 02305A86
	bne loc_02305A82	; 02305A88
	bx lr	; 02305A8A
pool_02305A8C:
loc_02305A8C:
	.word REG_WIFI_RF_BUSY	; 02305A8C
pool_02305A90:
loc_02305A90:
	.word REG_WIFI_RF_DATA1	; 02305A90
pool_02305A94:
loc_02305A94:
	.word REG_WIFI_RF_DATA2	; 02305A94

; ===== function loc_02305A98 =====
loc_02305A98:
	push {r4,r5,r6,lr}	; 02305A98
	mov r6,#0x0	; 02305A9A
	ldr r4,[pool_02305AF0]	; 02305A9C
	ldr r3,[pool_02305AF4]	; 02305A9E
	mov r2,#0x1	; 02305AA0
	b loc_02305AB2	; 02305AA2
loc_02305AA4:
	add r5,r6,#0x0	; 02305AA4
	add r6,r6,#0x1	; 02305AA6
	cmp r5,r3	; 02305AA8
	bls loc_02305AB2	; 02305AAA
	mov r0,#0x0	; 02305AAC
	mvn r0,r0	; 02305AAE
	b loc_02305AE8	; 02305AB0
loc_02305AB2:
	ldrh r5,[r4,#0x0]	; 02305AB2
	and r5,r2	; 02305AB4
	cmp r5,#0x0	; 02305AB6
	bne loc_02305AA4	; 02305AB8
	ldr r2,[pool_02305AF8]	; 02305ABA
	strh r1,[r2,#0x0]	; 02305ABC
	ldr r1,[pool_02305AFC]	; 02305ABE
	orr r0,r1	; 02305AC0
	ldr r1,[pool_02305B00]	; 02305AC2
	strh r0,[r1,#0x0]	; 02305AC4
	mov r4,#0x0	; 02305AC6
	ldr r2,[pool_02305AF0]	; 02305AC8
	ldr r1,[pool_02305AF4]	; 02305ACA
	mov r0,#0x1	; 02305ACC
	b loc_02305ADE	; 02305ACE
loc_02305AD0:
	add r3,r4,#0x0	; 02305AD0
	add r4,r4,#0x1	; 02305AD2
	cmp r3,r1	; 02305AD4
	bls loc_02305ADE	; 02305AD6
	mov r0,#0x0	; 02305AD8
	mvn r0,r0	; 02305ADA
	b loc_02305AE8	; 02305ADC
loc_02305ADE:
	ldrh r3,[r2,#0x0]	; 02305ADE
	and r3,r0	; 02305AE0
	cmp r3,#0x0	; 02305AE2
	bne loc_02305AD0	; 02305AE4
	mov r0,#0x0	; 02305AE6
loc_02305AE8:
	pop {r4,r5,r6}	; 02305AE8
	pop {r3}	; 02305AEA
	bx r3	; 02305AEC
	.byte 0xC0, 0x46	; 02305AF0
pool_02305AF0:
loc_02305AF0:
	.word REG_WIFI_BB_BUSY	; 02305AF0
pool_02305AF4:
loc_02305AF4:
	.word 0x00002710	; 02305AF4
pool_02305AF8:
loc_02305AF8:
	.word REG_WIFI_BB_WRITE	; 02305AF8
pool_02305AFC:
loc_02305AFC:
	.word 0x00005000	; 02305AFC
pool_02305B00:
loc_02305B00:
	.word REG_WIFI_BB_CNT	; 02305B00

; ===== function loc_02305B04 =====
loc_02305B04:
	ldr r2,[pool_02305B2C]	; 02305B04
	mov r1,#0x1	; 02305B06
loc_02305B08:
	ldrh r3,[r2,#0x0]	; 02305B08
	and r3,r1	; 02305B0A
	cmp r3,#0x0	; 02305B0C
	bne loc_02305B08	; 02305B0E
	ldr r1,[pool_02305B30]	; 02305B10
	orr r0,r1	; 02305B12
	ldr r1,[pool_02305B34]	; 02305B14
	strh r0,[r1,#0x0]	; 02305B16
	ldr r1,[pool_02305B2C]	; 02305B18
	mov r0,#0x1	; 02305B1A
loc_02305B1C:
	ldrh r2,[r1,#0x0]	; 02305B1C
	and r2,r0	; 02305B1E
	cmp r2,#0x0	; 02305B20
	bne loc_02305B1C	; 02305B22
	ldr r0,[pool_02305B38]	; 02305B24
	ldrh r0,[r0,#0x0]	; 02305B26
	bx lr	; 02305B28
	.byte 0xC0, 0x46	; 02305B2C
pool_02305B2C:
loc_02305B2C:
	.word REG_WIFI_BB_BUSY	; 02305B2C
pool_02305B30:
loc_02305B30:
	.word 0x00006000	; 02305B30
pool_02305B34:
loc_02305B34:
	.word REG_WIFI_BB_CNT	; 02305B34
pool_02305B38:
loc_02305B38:
	.word REG_WIFI_BB_READ	; 02305B38

; ===== function loc_02305B3C =====
loc_02305B3C:
	push {r4,lr}	; 02305B3C
	bl loc_02305694	; 02305B3E
	mov r0,#0x20	; 02305B42
	bl loc_02306468	; 02305B44
	mov r1,#0x0	; 02305B48
	ldr r0,[pool_02305BB8]	; 02305B4A
	ldr r3,[r0,#0x0]	; 02305B4C
	ldr r2,[pool_02305BBC]	; 02305B4E
	strh r1,[r3,r2]	; 02305B50
	ldr r3,[r0,#0x0]	; 02305B52
	ldr r2,[pool_02305BC0]	; 02305B54
	add r4,r3,r2	; 02305B56
	ldrh r3,[r4,#0x0]	; 02305B58
	mov r2,#0x4	; 02305B5A
	bic r3,r2	; 02305B5C
	strh r3,[r4,#0x0]	; 02305B5E
	ldr r2,[pool_02305BC4]	; 02305B60
	strh r1,[r2,#0x0]	; 02305B62
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
	ldr r1,[r0,#0x0]	; 02305B78
	ldr r0,[pool_02305BDC]	; 02305B7A
	ldrh r0,[r1,r0]	; 02305B7C
	cmp r0,#0x4	; 02305B7E
	bhi loc_02305B9E	; 02305B80
	add r0,r0,r0	; 02305B82
P4_SwitchIndexPC_02305B82:
	add r0,pc	; 02305B84
	ldrh r0,[r0,#(P4_SwitchTable_02305B82 - (P4_SwitchIndexPC_02305B82 + 4))]	; 02305B86
	lsl r0,r0,#0x10	; 02305B88
	asr r0,r0,#0x10	; 02305B8A
P4_SwitchTargetPC_02305B82:
	add r0,pc	; 02305B8C
	bx r0	; 02305B8E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02305B82:
	.halfword (loc_02305B9E + 1) - (P4_SwitchTargetPC_02305B82 + 4)
	.halfword (loc_02305B9A + 1) - (P4_SwitchTargetPC_02305B82 + 4)
	.halfword (loc_02305B9E + 1) - (P4_SwitchTargetPC_02305B82 + 4)
	.halfword (loc_02305B9E + 1) - (P4_SwitchTargetPC_02305B82 + 4)
	.halfword (loc_02305B9E + 1) - (P4_SwitchTargetPC_02305B82 + 4)
P4_SwitchTable_02305B82End:
loc_02305B9A:
	bl loc_0230CA34	; 02305B9A
loc_02305B9E:
	ldr r1,[pool_02305BE0]	; 02305B9E
	ldr r0,[pool_02305BE4]	; 02305BA0
	strh r1,[r0,#0x0]	; 02305BA2
	ldr r0,[pool_02305BE8]	; 02305BA4
	strh r1,[r0,#0x0]	; 02305BA6
	bl loc_0230CBC8	; 02305BA8
	bl loc_02304D14	; 02305BAC
	pop {r4}	; 02305BB0
	pop {r3}	; 02305BB2
	bx r3	; 02305BB4
	.byte 0xC0, 0x46	; 02305BB8
pool_02305BB8:
loc_02305BB8:
	.word FirmwareWlWorkPointerSlot	; 02305BB8
pool_02305BBC:
loc_02305BBC:
	.word 0x000003A0	; 02305BBC
pool_02305BC0:
loc_02305BC0:
	.word 0x00000316	; 02305BC0
pool_02305BC4:
loc_02305BC4:
	.word REG_WIFI_IE	; 02305BC4
pool_02305BC8:
loc_02305BC8:
	.word REG_WIFI_MODE_RST	; 02305BC8
pool_02305BCC:
loc_02305BCC:
	.word REG_WIFI_US_COMPARECNT	; 02305BCC
pool_02305BD0:
loc_02305BD0:
	.word REG_WIFI_US_COUNTCNT	; 02305BD0
pool_02305BD4:
loc_02305BD4:
	.word REG_WIFI_TXSTATCNT	; 02305BD4
pool_02305BD8:
loc_02305BD8:
	.word REG_WIFI_UNKNOWN_00A	; 02305BD8
pool_02305BDC:
loc_02305BDC:
	.word 0x00000314	; 02305BDC
pool_02305BE0:
loc_02305BE0:
	.word 0x0000FFFF	; 02305BE0
pool_02305BE4:
loc_02305BE4:
	.word REG_WIFI_TXREQ_RESET	; 02305BE4
pool_02305BE8:
loc_02305BE8:
	.word REG_WIFI_TXBUF_RESET	; 02305BE8

; ===== function loc_02305BEC =====
loc_02305BEC:
	push {r4,r5,r6,lr}	; 02305BEC
	sub sp,#0x8	; 02305BEE
	bl loc_02305B3C	; 02305BF0
	ldr r2,[pool_02305F40]	; 02305BF4
	ldrh r1,[r2,#0x0]	; 02305BF6
	ldrh r0,[r2,#0x0]	; 02305BF8
	lsl r0,r0,#0x8	; 02305BFA
	add r0,r1,r0	; 02305BFC
	ldrh r1,[r2,#0x0]	; 02305BFE
	bl loc_02305384	; 02305C00
	mov r3,#0x1	; 02305C04
	ldr r2,[pool_02305F44]	; 02305C06
	ldr r1,[r2,#0x0]	; 02305C08
	ldr r0,[pool_02305F48]	; 02305C0A
	strh r3,[r1,r0]	; 02305C0C
	ldr r2,[r2,#0x0]	; 02305C0E
	ldr r1,[pool_02305F4C]	; 02305C10
	ldrh r1,[r2,r1]	; 02305C12
	lsl r1,r1,#0x1d	; 02305C14
	lsr r1,r1,#0x1f	; 02305C16
	cmp r1,#0x1	; 02305C18
	bne loc_02305C26	; 02305C1A
	add r2,r2,r0	; 02305C1C
	ldrh r1,[r2,#0x0]	; 02305C1E
	mov r0,#0x20	; 02305C20
	orr r1,r0	; 02305C22
	strh r1,[r2,#0x0]	; 02305C24
loc_02305C26:
	ldr r0,[pool_02305F44]	; 02305C26
	ldr r1,[r0,#0x0]	; 02305C28
	ldr r0,[pool_02305F50]	; 02305C2A
	ldrh r0,[r1,r0]	; 02305C2C
	cmp r0,#0x0	; 02305C2E
	beq loc_02305C3E	; 02305C30
	ldr r0,[pool_02305F48]	; 02305C32
	add r2,r1,r0	; 02305C34
	ldrh r1,[r2,#0x0]	; 02305C36
	mov r0,#0x10	; 02305C38
	orr r1,r0	; 02305C3A
	strh r1,[r2,#0x0]	; 02305C3C
loc_02305C3E:
	ldr r0,[pool_02305F44]	; 02305C3E
	ldr r1,[r0,#0x0]	; 02305C40
	ldr r0,[pool_02305F54]	; 02305C42
	add r2,r1,r0	; 02305C44
	ldrh r1,[r2,#0x0]	; 02305C46
	mov r0,#0x4	; 02305C48
	bic r1,r0	; 02305C4A
	strh r1,[r2,#0x0]	; 02305C4C
	ldr r1,[pool_02305F58]	; 02305C4E
	ldr r0,[pool_02305F5C]	; 02305C50
	strh r1,[r0,#0x0]	; 02305C52
	ldr r1,[pool_02305F60]	; 02305C54
	ldr r0,[pool_02305F64]	; 02305C56
	strh r1,[r0,#0x0]	; 02305C58
	mov r1,#0x0	; 02305C5A
	ldr r0,[pool_02305F68]	; 02305C5C
	strh r1,[r0,#0x0]	; 02305C5E
	ldr r0,[pool_02305F6C]	; 02305C60
	strh r1,[r0,#0x0]	; 02305C62
	mov r1,#0x1	; 02305C64
	ldr r0,[pool_02305F70]	; 02305C66
	strh r1,[r0,#0x0]	; 02305C68
	mov r1,#0xf	; 02305C6A
	ldr r0,[pool_02305F74]	; 02305C6C
	strh r1,[r0,#0x0]	; 02305C6E
	bl loc_02308D80	; 02305C70
	bl loc_0230FF8C	; 02305C74
	bl loc_0230B9D0	; 02305C78
	bl loc_0230D870	; 02305C7C
	ldr r1,[pool_02305F58]	; 02305C80
	ldr r0,[pool_02305F78]	; 02305C82
	strh r1,[r0,#0x0]	; 02305C84
	ldr r1,[pool_02305F44]	; 02305C86
	ldr r2,[r1,#0x0]	; 02305C88
	ldr r0,[pool_02305F7C]	; 02305C8A
	ldrh r0,[r2,r0]	; 02305C8C
	cmp r0,#0x4	; 02305C8E
	bls loc_02305C94	; 02305C90
	b loc_02305EFE	; 02305C92
loc_02305C94:
	add r0,r0,r0	; 02305C94
P4_SwitchIndexPC_02305C94:
	add r0,pc	; 02305C96
	ldrh r0,[r0,#(P4_SwitchTable_02305C94 - (P4_SwitchIndexPC_02305C94 + 4))]	; 02305C98
	lsl r0,r0,#0x10	; 02305C9A
	asr r0,r0,#0x10	; 02305C9C
P4_SwitchTargetPC_02305C94:
	add r0,pc	; 02305C9E
	bx r0	; 02305CA0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02305C94:
	.halfword (loc_02305CAC + 1) - (P4_SwitchTargetPC_02305C94 + 4)
	.halfword (loc_02305CFA + 1) - (P4_SwitchTargetPC_02305C94 + 4)
	.halfword (loc_02305DC2 + 1) - (P4_SwitchTargetPC_02305C94 + 4)
	.halfword (loc_02305E66 + 1) - (P4_SwitchTargetPC_02305C94 + 4)
	.halfword (loc_02305EDA + 1) - (P4_SwitchTargetPC_02305C94 + 4)
P4_SwitchTable_02305C94End:
loc_02305CAC:
	ldr r2,[pool_02305F60]	; 02305CAC
	ldr r0,[pool_02305F80]	; 02305CAE
	strh r2,[r0,#0x0]	; 02305CB0
	mov r2,#0x3f	; 02305CB2
	ldr r0,[pool_02305F84]	; 02305CB4
	strh r2,[r0,#0x0]	; 02305CB6
	ldr r2,[pool_02305F88]	; 02305CB8
	ldr r0,[pool_02305F8C]	; 02305CBA
	strh r2,[r0,#0x0]	; 02305CBC
	ldr r1,[r1,#0x0]	; 02305CBE
	ldr r0,[pool_02305F90]	; 02305CC0
	ldrh r1,[r1,r0]	; 02305CC2
	mov r0,#0x8	; 02305CC4
	and r1,r0	; 02305CC6
	cmp r1,#0x0	; 02305CC8
	beq loc_02305CD2	; 02305CCA
	ldr r1,[pool_02305F94]	; 02305CCC
	ldr r0,[pool_02305F98]	; 02305CCE
	strh r1,[r0,#0x0]	; 02305CD0
loc_02305CD2:
	ldr r1,[pool_02305F60]	; 02305CD2
	ldr r0,[pool_02305F9C]	; 02305CD4
	strh r1,[r0,#0x0]	; 02305CD6
	mov r1,#0x8	; 02305CD8
	ldr r0,[pool_02305FA0]	; 02305CDA
	strh r1,[r0,#0x0]	; 02305CDC
	mov r1,#0x0	; 02305CDE
	ldr r0,[pool_02305FA4]	; 02305CE0
	strh r1,[r0,#0x0]	; 02305CE2
	ldr r0,[pool_02305FA8]	; 02305CE4
	strh r1,[r0,#0x0]	; 02305CE6
	ldr r0,[pool_02305F70]	; 02305CE8
	strh r1,[r0,#0x0]	; 02305CEA
	mov r1,#0x1	; 02305CEC
	ldr r0,[pool_02305FAC]	; 02305CEE
	strh r1,[r0,#0x0]	; 02305CF0
	mov r0,#0x40	; 02305CF2
	bl loc_02306468	; 02305CF4
	b loc_02305EFE	; 02305CF8
loc_02305CFA:
	ldr r2,[pool_02305FB0]	; 02305CFA
	ldr r0,[pool_02305F80]	; 02305CFC
	strh r2,[r0,#0x0]	; 02305CFE
	ldr r2,[pool_02305FB4]	; 02305D00
	ldr r0,[pool_02305F84]	; 02305D02
	strh r2,[r0,#0x0]	; 02305D04
	ldr r2,[pool_02305F88]	; 02305D06
	ldr r0,[pool_02305F8C]	; 02305D08
	strh r2,[r0,#0x0]	; 02305D0A
	mov r2,#0x0	; 02305D0C
	ldr r0,[pool_02305F98]	; 02305D0E
	strh r2,[r0,#0x0]	; 02305D10
	ldr r2,[r1,#0x0]	; 02305D12
	ldr r1,[pool_02305F90]	; 02305D14
	ldrh r2,[r2,r1]	; 02305D16
	mov r1,#0x8	; 02305D18
	and r2,r1	; 02305D1A
	cmp r2,#0x0	; 02305D1C
	beq loc_02305D28	; 02305D1E
	ldrh r2,[r0,#0x0]	; 02305D20
	ldr r1,[pool_02305F94]	; 02305D22
	orr r2,r1	; 02305D24
	strh r2,[r0,#0x0]	; 02305D26
loc_02305D28:
	ldr r1,[pool_02305FB8]	; 02305D28
	ldr r0,[pool_02305F9C]	; 02305D2A
	strh r1,[r0,#0x0]	; 02305D2C
	mov r1,#0xd	; 02305D2E
	ldr r0,[pool_02305FA0]	; 02305D30
	strh r1,[r0,#0x0]	; 02305D32
	ldr r1,[pool_02305FBC]	; 02305D34
	ldr r0,[pool_02305FA4]	; 02305D36
	strh r1,[r0,#0x0]	; 02305D38
	mov r6,#0x0	; 02305D3A
	ldr r0,[pool_02305FA8]	; 02305D3C
	strh r6,[r0,#0x0]	; 02305D3E
	mov r1,#0x1	; 02305D40
	ldr r0,[pool_02305FAC]	; 02305D42
	strh r1,[r0,#0x0]	; 02305D44
	add r5,sp,#0x0	; 02305D46
	ldr r0,[pool_02305FC0]	; 02305D48
	ldrh r0,[r0,#0x0]	; 02305D4A
	strh r0,[r5,#0x0]	; 02305D4C
	ldr r0,[pool_02305FC4]	; 02305D4E
	ldrh r0,[r0,#0x0]	; 02305D50
	strh r0,[r5,#0x2]	; 02305D52
	ldr r0,[pool_02305FC8]	; 02305D54
	ldrh r0,[r0,#0x0]	; 02305D56
	strh r0,[r5,#0x4]	; 02305D58
	ldr r0,[pool_02305FCC]	; 02305D5A
	ldrh r0,[r0,#0x0]	; 02305D5C
	strh r0,[r5,#0x6]	; 02305D5E
	ldr r0,[pool_02305F44]	; 02305D60
	ldr r1,[r0,#0x0]	; 02305D62
	ldr r0,[pool_02305FD0]	; 02305D64
	ldrh r0,[r1,r0]	; 02305D66
	lsl r4,r0,#0xa	; 02305D68
	ldr r0,[sp,#0x0]	; 02305D6A
	ldr r1,[sp,#0x4]	; 02305D6C
	add r2,r4,#0x0	; 02305D6E
	add r3,r6,#0x0	; 02305D70
	bl loc_02306010	; 02305D72
	str r0,[sp,#0x0]	; 02305D76
	str r1,[sp,#0x4]	; 02305D78
	lsl r3,r6,#0	; 02305D7A
	mov r2,#0x1	; 02305D7C
	add r0,r0,r2	; 02305D7E
	adc r1,r3	; 02305D80
	str r0,[sp,#0x0]	; 02305D82
	str r1,[sp,#0x4]	; 02305D84
	add r2,r4,#0x0	; 02305D86
	bl loc_0230601C	; 02305D88
	str r0,[sp,#0x0]	; 02305D8C
	str r1,[sp,#0x4]	; 02305D8E
	ldrh r1,[r5,#0x6]	; 02305D90
	ldr r0,[pool_02305FD4]	; 02305D92
	strh r1,[r0,#0x0]	; 02305D94
	ldrh r1,[r5,#0x4]	; 02305D96
	ldr r0,[pool_02305FD8]	; 02305D98
	strh r1,[r0,#0x0]	; 02305D9A
	ldrh r1,[r5,#0x2]	; 02305D9C
	ldr r0,[pool_02305FDC]	; 02305D9E
	strh r1,[r0,#0x0]	; 02305DA0
	ldrh r2,[r5,#0x0]	; 02305DA2
	mov r1,#0x1	; 02305DA4
	orr r2,r1	; 02305DA6
	ldr r0,[pool_02305FE0]	; 02305DA8
	strh r2,[r0,#0x0]	; 02305DAA
	ldr r0,[pool_02305FE4]	; 02305DAC
	strh r1,[r0,#0x0]	; 02305DAE
	mov r0,#0x40	; 02305DB0
	bl loc_02306468	; 02305DB2
	bl loc_0230CA50	; 02305DB6
	mov r1,#0x2	; 02305DBA
	ldr r0,[pool_02305FE8]	; 02305DBC
	strh r1,[r0,#0x0]	; 02305DBE
	b loc_02305EFE	; 02305DC0
loc_02305DC2:
	ldr r2,[pool_02305F60]	; 02305DC2
	ldr r0,[pool_02305F80]	; 02305DC4
	strh r2,[r0,#0x0]	; 02305DC6
	ldr r2,[pool_02305FEC]	; 02305DC8
	ldr r0,[pool_02305F84]	; 02305DCA
	strh r2,[r0,#0x0]	; 02305DCC
	ldr r2,[r1,#0x0]	; 02305DCE
	ldr r1,[pool_02305F90]	; 02305DD0
	ldrh r2,[r2,r1]	; 02305DD2
	mov r1,#0x20	; 02305DD4
	and r2,r1	; 02305DD6
	cmp r2,#0x0	; 02305DD8
	beq loc_02305DE4	; 02305DDA
	ldrh r2,[r0,#0x0]	; 02305DDC
	mov r1,#0xc0	; 02305DDE
	orr r2,r1	; 02305DE0
	strh r2,[r0,#0x0]	; 02305DE2
loc_02305DE4:
	ldr r1,[pool_02305F88]	; 02305DE4
	ldr r0,[pool_02305F8C]	; 02305DE6
	strh r1,[r0,#0x0]	; 02305DE8
	mov r1,#0x0	; 02305DEA
	ldr r0,[pool_02305F98]	; 02305DEC
	strh r1,[r0,#0x0]	; 02305DEE
	ldr r1,[pool_02305F44]	; 02305DF0
	ldr r2,[r1,#0x0]	; 02305DF2
	ldr r1,[pool_02305F90]	; 02305DF4
	ldrh r2,[r2,r1]	; 02305DF6
	mov r1,#0x8	; 02305DF8
	and r2,r1	; 02305DFA
	cmp r2,#0x0	; 02305DFC
	beq loc_02305E08	; 02305DFE
	ldrh r2,[r0,#0x0]	; 02305E00
	ldr r1,[pool_02305F94]	; 02305E02
	orr r2,r1	; 02305E04
	strh r2,[r0,#0x0]	; 02305E06
loc_02305E08:
	ldr r0,[pool_02305F44]	; 02305E08
	ldr r1,[r0,#0x0]	; 02305E0A
	ldr r0,[pool_02305F90]	; 02305E0C
	ldrh r1,[r1,r0]	; 02305E0E
	mov r0,#0x20	; 02305E10
	and r1,r0	; 02305E12
	cmp r1,#0x0	; 02305E14
	beq loc_02305E22	; 02305E16
	ldr r2,[pool_02305F98]	; 02305E18
	ldrh r1,[r2,#0x0]	; 02305E1A
	mov r0,#0x68	; 02305E1C
	orr r1,r0	; 02305E1E
	strh r1,[r2,#0x0]	; 02305E20
loc_02305E22:
	ldr r0,[pool_02305F44]	; 02305E22
	ldr r1,[r0,#0x0]	; 02305E24
	ldr r0,[pool_02305FF0]	; 02305E26
	ldrh r1,[r1,r0]	; 02305E28
	mov r0,#0x1	; 02305E2A
	and r1,r0	; 02305E2C
	cmp r1,#0x0	; 02305E2E
	beq loc_02305E3A	; 02305E30
	ldr r1,[pool_02305FF4]	; 02305E32
	ldr r0,[pool_02305F9C]	; 02305E34
	strh r1,[r0,#0x0]	; 02305E36
	b loc_02305E40	; 02305E38
loc_02305E3A:
	ldr r1,[pool_02305FF8]	; 02305E3A
	ldr r0,[pool_02305F9C]	; 02305E3C
	strh r1,[r0,#0x0]	; 02305E3E
loc_02305E40:
	mov r1,#0xb	; 02305E40
	ldr r0,[pool_02305FA0]	; 02305E42
	strh r1,[r0,#0x0]	; 02305E44
	mov r1,#0x0	; 02305E46
	ldr r0,[pool_02305FA4]	; 02305E48
	strh r1,[r0,#0x0]	; 02305E4A
	ldr r0,[pool_02305FA8]	; 02305E4C
	strh r1,[r0,#0x0]	; 02305E4E
	mov r1,#0x1	; 02305E50
	ldr r0,[pool_02305FAC]	; 02305E52
	strh r1,[r0,#0x0]	; 02305E54
	ldr r0,[pool_02305F70]	; 02305E56
	strh r1,[r0,#0x0]	; 02305E58
	ldr r0,[pool_02305FE4]	; 02305E5A
	strh r1,[r0,#0x0]	; 02305E5C
	mov r0,#0x20	; 02305E5E
	bl loc_02306468	; 02305E60
	b loc_02305EFE	; 02305E64
loc_02305E66:
	ldr r2,[pool_02305F60]	; 02305E66
	ldr r0,[pool_02305F80]	; 02305E68
	strh r2,[r0,#0x0]	; 02305E6A
	ldr r2,[pool_02305FFC]	; 02305E6C
	ldr r0,[pool_02305F84]	; 02305E6E
	strh r2,[r0,#0x0]	; 02305E70
	ldr r2,[pool_02305F88]	; 02305E72
	ldr r0,[pool_02305F8C]	; 02305E74
	strh r2,[r0,#0x0]	; 02305E76
	mov r2,#0x0	; 02305E78
	ldr r0,[pool_02305F98]	; 02305E7A
	strh r2,[r0,#0x0]	; 02305E7C
	ldr r2,[r1,#0x0]	; 02305E7E
	ldr r1,[pool_02305F90]	; 02305E80
	ldrh r2,[r2,r1]	; 02305E82
	mov r1,#0x8	; 02305E84
	and r2,r1	; 02305E86
	cmp r2,#0x0	; 02305E88
	beq loc_02305E94	; 02305E8A
	ldrh r2,[r0,#0x0]	; 02305E8C
	ldr r1,[pool_02305F94]	; 02305E8E
	orr r2,r1	; 02305E90
	strh r2,[r0,#0x0]	; 02305E92
loc_02305E94:
	ldr r0,[pool_02305F44]	; 02305E94
	ldr r1,[r0,#0x0]	; 02305E96
	ldr r0,[pool_02305FF0]	; 02305E98
	ldrh r0,[r1,r0]	; 02305E9A
	mov r1,#0x1	; 02305E9C
	and r0,r1	; 02305E9E
	cmp r0,#0x0	; 02305EA0
	beq loc_02305EAC	; 02305EA2
	ldr r1,[pool_02306000]	; 02305EA4
	ldr r0,[pool_02305F9C]	; 02305EA6
	strh r1,[r0,#0x0]	; 02305EA8
	b loc_02305EB0	; 02305EAA
loc_02305EAC:
	ldr r0,[pool_02305F9C]	; 02305EAC
	strh r1,[r0,#0x0]	; 02305EAE
loc_02305EB0:
	mov r1,#0xb	; 02305EB0
	ldr r0,[pool_02305FA0]	; 02305EB2
	strh r1,[r0,#0x0]	; 02305EB4
	mov r0,#0x0	; 02305EB6
	ldr r1,[pool_02305FA4]	; 02305EB8
	strh r0,[r1,#0x0]	; 02305EBA
	ldr r1,[pool_02305FA8]	; 02305EBC
	strh r0,[r1,#0x0]	; 02305EBE
	mov r2,#0x1	; 02305EC0
	ldr r1,[pool_02305FAC]	; 02305EC2
	strh r2,[r1,#0x0]	; 02305EC4
	ldr r1,[pool_02305F70]	; 02305EC6
	strh r2,[r1,#0x0]	; 02305EC8
	ldr r1,[pool_02305FE4]	; 02305ECA
	strh r2,[r1,#0x0]	; 02305ECC
	ldr r1,[pool_02306004]	; 02305ECE
	strh r0,[r1,#0x0]	; 02305ED0
	mov r0,#0x20	; 02305ED2
	bl loc_02306468	; 02305ED4
	b loc_02305EFE	; 02305ED8
loc_02305EDA:
	ldr r1,[pool_02305F60]	; 02305EDA
	ldr r0,[pool_02305F80]	; 02305EDC
	strh r1,[r0,#0x0]	; 02305EDE
	mov r1,#0x0	; 02305EE0
	ldr r0,[pool_02305F84]	; 02305EE2
	strh r1,[r0,#0x0]	; 02305EE4
	ldr r0,[pool_02305F8C]	; 02305EE6
	strh r1,[r0,#0x0]	; 02305EE8
	ldr r0,[pool_02305FA4]	; 02305EEA
	strh r1,[r0,#0x0]	; 02305EEC
	ldr r0,[pool_02305FA8]	; 02305EEE
	strh r1,[r0,#0x0]	; 02305EF0
	mov r1,#0x1	; 02305EF2
	ldr r0,[pool_02305FAC]	; 02305EF4
	strh r1,[r0,#0x0]	; 02305EF6
	mov r0,#0x20	; 02305EF8
	bl loc_02306468	; 02305EFA
loc_02305EFE:
	mov r1,#0x0	; 02305EFE
	ldr r0,[pool_02306004]	; 02305F00
	strh r1,[r0,#0x0]	; 02305F02
	bl loc_02306694	; 02305F04
	mov r0,#0x2	; 02305F08
	ldr r1,[pool_02305FE8]	; 02305F0A
	strh r0,[r1,#0x0]	; 02305F0C
	ldr r1,[pool_02305F44]	; 02305F0E
	ldr r2,[r1,#0x0]	; 02305F10
	ldr r1,[pool_02305F54]	; 02305F12
	ldrh r1,[r2,r1]	; 02305F14
	lsl r1,r1,#0x1f	; 02305F16
	lsr r1,r1,#0x1f	; 02305F18
	cmp r1,#0x1	; 02305F1A
	bne loc_02305F22	; 02305F1C
	bl loc_02306810	; 02305F1E
loc_02305F22:
	ldr r3,[pool_02306008]	; 02305F22
	ldr r1,[pool_0230600C]	; 02305F24
	mov r0,#0x80	; 02305F26
	b loc_02305F34	; 02305F28
loc_02305F2A:
	ldrh r2,[r1,#0x0]	; 02305F2A
	and r2,r0	; 02305F2C
	cmp r2,#0x0	; 02305F2E
	bne loc_02305F38	; 02305F30
	sub r3,r3,#0x1	; 02305F32
loc_02305F34:
	cmp r3,#0x0	; 02305F34
	bne loc_02305F2A	; 02305F36
loc_02305F38:
	add sp,#0x8	; 02305F38
	pop {r4,r5,r6}	; 02305F3A
	pop {r3}	; 02305F3C
	bx r3	; 02305F3E
pool_02305F40:
loc_02305F40:
	.word REG_WIFI_RANDOM	; 02305F40
pool_02305F44:
loc_02305F44:
	.word FirmwareWlWorkPointerSlot	; 02305F44
pool_02305F48:
loc_02305F48:
	.word 0x00000378	; 02305F48
pool_02305F4C:
loc_02305F4C:
	.word 0x000002FE	; 02305F4C
pool_02305F50:
loc_02305F50:
	.word 0x000002F8	; 02305F50
pool_02305F54:
loc_02305F54:
	.word 0x00000316	; 02305F54
pool_02305F58:
loc_02305F58:
	.word 0x00008000	; 02305F58
pool_02305F5C:
loc_02305F5C:
	.word REG_WIFI_WEP_CNT	; 02305F5C
pool_02305F60:
loc_02305F60:
	.word 0x0000FFFF	; 02305F60
pool_02305F64:
loc_02305F64:
	.word REG_WIFI_POST_BEACON	; 02305F64
pool_02305F68:
loc_02305F68:
	.word REG_WIFI_AID_FULL	; 02305F68
pool_02305F6C:
loc_02305F6C:
	.word REG_WIFI_AID_LOW	; 02305F6C
pool_02305F70:
loc_02305F70:
	.word REG_WIFI_US_COUNTCNT	; 02305F70
pool_02305F74:
loc_02305F74:
	.word REG_WIFI_POWER_TX	; 02305F74
pool_02305F78:
loc_02305F78:
	.word REG_WIFI_RXCNT	; 02305F78
pool_02305F7C:
loc_02305F7C:
	.word 0x00000314	; 02305F7C
pool_02305F80:
loc_02305F80:
	.word REG_WIFI_IF	; 02305F80
pool_02305F84:
loc_02305F84:
	.word REG_WIFI_IE	; 02305F84
pool_02305F88:
loc_02305F88:
	.word 0x00001FFF	; 02305F88
pool_02305F8C:
loc_02305F8C:
	.word REG_WIFI_RXSTAT_OVF_IE	; 02305F8C
pool_02305F90:
loc_02305F90:
	.word 0x0000061C	; 02305F90
pool_02305F94:
loc_02305F94:
	.word 0x00000400	; 02305F94
pool_02305F98:
loc_02305F98:
	.word REG_WIFI_RXSTAT_INC_IE	; 02305F98
pool_02305F9C:
loc_02305F9C:
	.word REG_WIFI_RXFILTER	; 02305F9C
pool_02305FA0:
loc_02305FA0:
	.word REG_WIFI_RXFILTER2	; 02305FA0
pool_02305FA4:
loc_02305FA4:
	.word REG_WIFI_TXSTATCNT	; 02305FA4
pool_02305FA8:
loc_02305FA8:
	.word REG_WIFI_UNKNOWN_00A	; 02305FA8
pool_02305FAC:
loc_02305FAC:
	.word REG_WIFI_MODE_RST	; 02305FAC
pool_02305FB0:
loc_02305FB0:
	.word 0x00000FFF	; 02305FB0
pool_02305FB4:
loc_02305FB4:
	.word 0x0000703F	; 02305FB4
pool_02305FB8:
loc_02305FB8:
	.word 0x00000301	; 02305FB8
pool_02305FBC:
loc_02305FBC:
	.word 0x0000E000	; 02305FBC
pool_02305FC0:
loc_02305FC0:
	.word REG_WIFI_US_COUNT0	; 02305FC0
pool_02305FC4:
loc_02305FC4:
	.word REG_WIFI_US_COUNT1	; 02305FC4
pool_02305FC8:
loc_02305FC8:
	.word REG_WIFI_US_COUNT2	; 02305FC8
pool_02305FCC:
loc_02305FCC:
	.word REG_WIFI_US_COUNT3	; 02305FCC
pool_02305FD0:
loc_02305FD0:
	.word 0x0000036A	; 02305FD0
pool_02305FD4:
loc_02305FD4:
	.word REG_WIFI_US_COMPARE3	; 02305FD4
pool_02305FD8:
loc_02305FD8:
	.word REG_WIFI_US_COMPARE2	; 02305FD8
pool_02305FDC:
loc_02305FDC:
	.word REG_WIFI_US_COMPARE1	; 02305FDC
pool_02305FE0:
loc_02305FE0:
	.word REG_WIFI_US_COMPARE0	; 02305FE0
pool_02305FE4:
loc_02305FE4:
	.word REG_WIFI_US_COMPARECNT	; 02305FE4
pool_02305FE8:
loc_02305FE8:
	.word REG_WIFI_TXREQ_SET	; 02305FE8
pool_02305FEC:
loc_02305FEC:
	.word 0x0000E03F	; 02305FEC
pool_02305FF0:
loc_02305FF0:
	.word 0x00000360	; 02305FF0
pool_02305FF4:
loc_02305FF4:
	.word 0x00000581	; 02305FF4
pool_02305FF8:
loc_02305FF8:
	.word 0x00000181	; 02305FF8
pool_02305FFC:
loc_02305FFC:
	.word 0x0000C03F	; 02305FFC
pool_02306000:
loc_02306000:
	.word 0x00000401	; 02306000
pool_02306004:
loc_02306004:
	.word REG_WIFI_UNKNOWN_048	; 02306004
pool_02306008:
loc_02306008:
	.word 0x00000FA0	; 02306008
pool_0230600C:
loc_0230600C:
	.word REG_WIFI_RF_PINS	; 0230600C

; ===== function loc_02306010 =====
loc_02306010:
	bx pc	; 02306010
	.byte 0xC0, 0x46	; 02306014
.arm

; ===== function loc_02306014 =====
loc_02306014:
	ldr pc,[pool_02306018]	; 02306014
pool_02306018:
loc_02306018:
	.word loc_038022BC	; 02306018
.thumb

; ===== function loc_0230601C =====
loc_0230601C:
	bx pc	; 0230601C
	.byte 0xC0, 0x46	; 02306020
.arm

; ===== function loc_02306020 =====
loc_02306020:
	ldr pc,[pool_02306024]	; 02306020
pool_02306024:
loc_02306024:
	.word loc_038024C4	; 02306024
.thumb

; ===== function loc_02306028 =====
loc_02306028:
	ldr r0,[pool_02306054]	; 02306028
	ldr r1,[r0,#0x0]	; 0230602A
	ldr r0,[pool_02306058]	; 0230602C
	ldrh r0,[r1,r0]	; 0230602E
	cmp r0,#0x0	; 02306030
	beq loc_0230603A	; 02306032
	cmp r0,#0x1	; 02306034
	beq loc_0230604A	; 02306036
	b loc_0230604E	; 02306038
loc_0230603A:
	ldr r0,[pool_0230605C]	; 0230603A
	ldrh r1,[r1,r0]	; 0230603C
	mov r0,#0x1	; 0230603E
	and r1,r0	; 02306040
	cmp r1,#0x0	; 02306042
	beq loc_0230604E	; 02306044
	mov r0,#0xa	; 02306046
	bx lr	; 02306048
loc_0230604A:
	mov r0,#0xa	; 0230604A
	bx lr	; 0230604C
loc_0230604E:
	mov r0,#0x14	; 0230604E
	bx lr	; 02306050
	.byte 0xC0, 0x46	; 02306054
pool_02306054:
loc_02306054:
	.word FirmwareWlWorkPointerSlot	; 02306054
pool_02306058:
loc_02306058:
	.word 0x000002F4	; 02306058
pool_0230605C:
loc_0230605C:
	.word 0x0000035C	; 0230605C

; ===== function loc_02306060 =====
loc_02306060:
	push {r4,r5,r6,r7,lr}	; 02306060
	sub sp,#0x4	; 02306062
	add r6,r0,#0x0	; 02306064
	add r5,r1,#0x0	; 02306066
	mov r0,#0x0	; 02306068
	strh r0,[r5,#0x0]	; 0230606A
	strh r0,[r5,#0x2]	; 0230606C
	add r0,r6,#0x1	; 0230606E
	bl loc_023053B4	; 02306070
	add r7,r0,#0x0	; 02306074
	mov r4,#0x0	; 02306076
	b loc_023060D0	; 02306078
loc_0230607A:
	add r0,r6,#0x2	; 0230607A
	add r0,r0,r4	; 0230607C
	bl loc_023053B4	; 0230607E
	add r2,r0,#0x0	; 02306082
	mov r1,#0x7f	; 02306084
	and r2,r1	; 02306086
	sub r1,r2,#0x1	; 02306088
	cmp r1,#0x78	; 0230608A
	bcs loc_023060B4	; 0230608C
	lsl r2,r1,#0x1	; 0230608E
	ldr r1,[pool_023060DC]	; 02306090
	ldrh r1,[r1,r2]	; 02306092
	cmp r1,#0xff	; 02306094
	beq loc_023060B4	; 02306096
	mov r3,#0x1	; 02306098
	lsl r3,r1	; 0230609A
	add r2,r5,#0x2	; 0230609C
	ldrh r1,[r2,#0x0]	; 0230609E
	orr r1,r3	; 023060A0
	strh r1,[r2,#0x0]	; 023060A2
	mov r1,#0x80	; 023060A4
	and r0,r1	; 023060A6
	cmp r0,#0x0	; 023060A8
	beq loc_023060CE	; 023060AA
	ldrh r0,[r5,#0x0]	; 023060AC
	orr r0,r3	; 023060AE
	strh r0,[r5,#0x0]	; 023060B0
	b loc_023060CE	; 023060B2
loc_023060B4:
	add r3,r5,#0x2	; 023060B4
	ldrh r2,[r3,#0x0]	; 023060B6
	ldr r1,[pool_023060E0]	; 023060B8
	orr r2,r1	; 023060BA
	strh r2,[r3,#0x0]	; 023060BC
	mov r1,#0x80	; 023060BE
	and r0,r1	; 023060C0
	cmp r0,#0x0	; 023060C2
	beq loc_023060CE	; 023060C4
	ldrh r1,[r5,#0x0]	; 023060C6
	ldr r0,[pool_023060E0]	; 023060C8
	orr r1,r0	; 023060CA
	strh r1,[r5,#0x0]	; 023060CC
loc_023060CE:
	add r4,r4,#0x1	; 023060CE
loc_023060D0:
	cmp r4,r7	; 023060D0
	bcc loc_0230607A	; 023060D2
	add sp,#0x4	; 023060D4
	pop {r4,r5,r6,r7}	; 023060D6
	pop {r3}	; 023060D8
	bx r3	; 023060DA
pool_023060DC:
loc_023060DC:
	.word P4_Data_023104C0	; 023060DC
pool_023060E0:
loc_023060E0:
	.word 0x00008000	; 023060E0

; ===== function loc_023060E4 =====
loc_023060E4:
	push {r4,r5,r6,r7,lr}	; 023060E4
	sub sp,#0xc	; 023060E6
	add r5,r0,#0x0	; 023060E8
	str r1,[sp,#0x0]	; 023060EA
	cmp r5,#0x20	; 023060EC
	bls loc_023060F4	; 023060EE
	mov r0,#0x0	; 023060F0
	b loc_02306154	; 023060F2
loc_023060F4:
	ldr r0,[pool_0230615C]	; 023060F4
	ldr r1,[r0,#0x0]	; 023060F6
	ldr r0,[pool_02306160]	; 023060F8
	ldrh r0,[r1,r0]	; 023060FA
	cmp r0,#0x0	; 023060FC
	bne loc_02306104	; 023060FE
	mov r0,#0x1	; 02306100
	b loc_02306154	; 02306102
loc_02306104:
	cmp r5,r0	; 02306104
	beq loc_0230610C	; 02306106
	mov r0,#0x0	; 02306108
	b loc_02306154	; 0230610A
loc_0230610C:
	ldr r0,[pool_02306164]	; 0230610C
	add r6,r1,r0	; 0230610E
	ldr r0,[pool_02306168]	; 02306110
	add r7,r1,r0	; 02306112
	mov r4,#0x0	; 02306114
	b loc_0230614E	; 02306116
loc_02306118:
	add r0,r7,#0x0	; 02306118
	bl loc_023053B4	; 0230611A
	str r0,[sp,#0x4]	; 0230611E
	add r7,r7,#0x1	; 02306120
	ldr r0,[sp,#0x0]	; 02306122
	bl loc_023053B4	; 02306124
	str r0,[sp,#0x8]	; 02306128
	ldr r0,[sp,#0x0]	; 0230612A
	add r0,r0,#0x1	; 0230612C
	str r0,[sp,#0x0]	; 0230612E
	add r0,r6,#0x0	; 02306130
	bl loc_023053B4	; 02306132
	add r6,r6,#0x1	; 02306136
	ldr r2,[sp,#0x8]	; 02306138
	ldr r1,[sp,#0x4]	; 0230613A
	orr r2,r1	; 0230613C
	str r2,[sp,#0x8]	; 0230613E
	orr r0,r1	; 02306140
	lsl r1,r2,#0	; 02306142
	cmp r1,r0	; 02306144
	beq loc_0230614C	; 02306146
	mov r0,#0x0	; 02306148
	b loc_02306154	; 0230614A
loc_0230614C:
	add r4,r4,#0x1	; 0230614C
loc_0230614E:
	cmp r4,r5	; 0230614E
	bcc loc_02306118	; 02306150
	mov r0,#0x1	; 02306152
loc_02306154:
	add sp,#0xc	; 02306154
	pop {r4,r5,r6,r7}	; 02306156
	pop {r3}	; 02306158
	bx r3	; 0230615A
pool_0230615C:
loc_0230615C:
	.word FirmwareWlWorkPointerSlot	; 0230615C
pool_02306160:
loc_02306160:
	.word 0x0000031A	; 02306160
pool_02306164:
loc_02306164:
	.word 0x0000031C	; 02306164
pool_02306168:
loc_02306168:
	.word 0x0000033C	; 02306168

; ===== function loc_0230616C =====
loc_0230616C:
	push {r4,r5,lr}	; 0230616C
	sub sp,#0x4	; 0230616E
	ldr r0,[pool_0230638C]	; 02306170
	ldr r1,[r0,#0x0]	; 02306172
	ldr r0,[pool_02306390]	; 02306174
	add r0,r1,r0	; 02306176
	ldr r1,[pool_02306394]	; 02306178
	ldrh r2,[r1,#0x0]	; 0230617A
	add r4,r0,#0x0	; 0230617C
	add r4,#0x50	; 0230617E
	ldr r3,[r4,#0x0]	; 02306180
	mov r1,#0xff	; 02306182
	and r2,r1	; 02306184
	lsl r2,r2,#0x10	; 02306186
	lsr r2,r2,#0x10	; 02306188
	add r2,r3,r2	; 0230618A
	str r2,[r4,#0x0]	; 0230618C
	ldr r2,[pool_02306398]	; 0230618E
	ldrh r2,[r2,#0x0]	; 02306190
	add r5,r0,#0x0	; 02306192
	add r5,#0x4c	; 02306194
	ldr r4,[r5,#0x0]	; 02306196
	lsl r3,r2,#0x8	; 02306198
	lsr r3,r3,#0x10	; 0230619A
	add r3,r4,r3	; 0230619C
	str r3,[r5,#0x0]	; 0230619E
	add r4,r0,#0x0	; 023061A0
	add r4,#0x5c	; 023061A2
	ldr r3,[r4,#0x0]	; 023061A4
	and r2,r1	; 023061A6
	lsl r2,r2,#0x10	; 023061A8
	lsr r2,r2,#0x10	; 023061AA
	add r2,r3,r2	; 023061AC
	str r2,[r4,#0x0]	; 023061AE
	ldr r2,[pool_0230639C]	; 023061B0
	ldrh r2,[r2,#0x0]	; 023061B2
	add r5,r0,#0x0	; 023061B4
	add r5,#0x58	; 023061B6
	ldr r4,[r5,#0x0]	; 023061B8
	lsl r3,r2,#0x8	; 023061BA
	lsr r3,r3,#0x10	; 023061BC
	add r3,r4,r3	; 023061BE
	str r3,[r5,#0x0]	; 023061C0
	add r4,r0,#0x0	; 023061C2
	add r4,#0x54	; 023061C4
	ldr r3,[r4,#0x0]	; 023061C6
	and r2,r1	; 023061C8
	lsl r2,r2,#0x10	; 023061CA
	lsr r2,r2,#0x10	; 023061CC
	add r2,r3,r2	; 023061CE
	str r2,[r4,#0x0]	; 023061D0
	ldr r2,[pool_023063A0]	; 023061D2
	ldrh r2,[r2,#0x0]	; 023061D4
	add r5,r0,#0x0	; 023061D6
	add r5,#0x60	; 023061D8
	ldr r4,[r5,#0x0]	; 023061DA
	lsl r3,r2,#0x8	; 023061DC
	lsr r3,r3,#0x10	; 023061DE
	add r3,r4,r3	; 023061E0
	str r3,[r5,#0x0]	; 023061E2
	add r4,r0,#0x0	; 023061E4
	add r4,#0x38	; 023061E6
	ldr r3,[r4,#0x0]	; 023061E8
	and r2,r1	; 023061EA
	lsl r2,r2,#0x10	; 023061EC
	lsr r2,r2,#0x10	; 023061EE
	add r2,r3,r2	; 023061F0
	str r2,[r4,#0x0]	; 023061F2
	ldr r2,[pool_023063A4]	; 023061F4
	ldrh r2,[r2,#0x0]	; 023061F6
	add r4,r0,#0x0	; 023061F8
	add r4,#0x48	; 023061FA
	ldr r3,[r4,#0x0]	; 023061FC
	and r2,r1	; 023061FE
	lsl r2,r2,#0x10	; 02306200
	lsr r2,r2,#0x10	; 02306202
	add r2,r3,r2	; 02306204
	str r2,[r4,#0x0]	; 02306206
	ldr r2,[pool_023063A8]	; 02306208
	ldrh r2,[r2,#0x0]	; 0230620A
	add r4,r0,#0x0	; 0230620C
	add r4,#0x20	; 0230620E
	ldr r3,[r4,#0x0]	; 02306210
	and r2,r1	; 02306212
	lsl r2,r2,#0x10	; 02306214
	lsr r2,r2,#0x10	; 02306216
	add r2,r3,r2	; 02306218
	str r2,[r4,#0x0]	; 0230621A
	ldr r2,[pool_023063AC]	; 0230621C
	ldrh r2,[r2,#0x0]	; 0230621E
	add r5,r0,#0x0	; 02306220
	add r5,#0x30	; 02306222
	ldr r4,[r5,#0x0]	; 02306224
	lsl r3,r2,#0x8	; 02306226
	lsr r3,r3,#0x10	; 02306228
	add r3,r4,r3	; 0230622A
	str r3,[r5,#0x0]	; 0230622C
	add r4,r0,#0x0	; 0230622E
	add r4,#0x44	; 02306230
	ldr r3,[r4,#0x0]	; 02306232
	and r2,r1	; 02306234
	lsl r2,r2,#0x10	; 02306236
	lsr r2,r2,#0x10	; 02306238
	add r2,r3,r2	; 0230623A
	str r2,[r4,#0x0]	; 0230623C
	ldr r2,[pool_023063B0]	; 0230623E
	ldrh r3,[r2,#0x0]	; 02306240
	add r2,r0,#0x0	; 02306242
	add r2,#0x3c	; 02306244
	ldr r5,[r2,#0x0]	; 02306246
	add r4,r3,#0x0	; 02306248
	and r4,r1	; 0230624A
	lsl r4,r4,#0x10	; 0230624C
	lsr r4,r4,#0x10	; 0230624E
	add r4,r5,r4	; 02306250
	str r4,[r2,#0x0]	; 02306252
	add r5,r0,#0x0	; 02306254
	add r5,#0x40	; 02306256
	ldr r4,[r5,#0x0]	; 02306258
	lsl r2,r3,#0x8	; 0230625A
	lsr r2,r2,#0x10	; 0230625C
	add r2,r4,r2	; 0230625E
	str r2,[r5,#0x0]	; 02306260
	ldr r2,[pool_023063B4]	; 02306262
	ldrh r2,[r2,#0x0]	; 02306264
	add r4,r0,#0x0	; 02306266
	add r4,#0xc	; 02306268
	ldr r3,[r4,#0x0]	; 0230626A
	and r2,r1	; 0230626C
	lsl r2,r2,#0x10	; 0230626E
	lsr r2,r2,#0x10	; 02306270
	add r2,r3,r2	; 02306272
	str r2,[r4,#0x0]	; 02306274
	ldr r2,[pool_023063B8]	; 02306276
	ldrh r2,[r2,#0x0]	; 02306278
	add r4,r0,#0x0	; 0230627A
	add r4,#0x78	; 0230627C
	ldr r3,[r4,#0x0]	; 0230627E
	lsl r2,r2,#0x8	; 02306280
	lsr r2,r2,#0x10	; 02306282
	add r2,r3,r2	; 02306284
	str r2,[r4,#0x0]	; 02306286
	ldr r2,[pool_023063BC]	; 02306288
	ldrh r3,[r2,#0x0]	; 0230628A
	add r2,r0,#0x0	; 0230628C
	add r2,#0x7c	; 0230628E
	ldr r5,[r2,#0x0]	; 02306290
	add r4,r3,#0x0	; 02306292
	and r4,r1	; 02306294
	lsl r4,r4,#0x10	; 02306296
	lsr r4,r4,#0x10	; 02306298
	add r4,r5,r4	; 0230629A
	str r4,[r2,#0x0]	; 0230629C
	add r5,r0,#0x0	; 0230629E
	add r5,#0x80	; 023062A0
	ldr r4,[r5,#0x0]	; 023062A2
	lsl r2,r3,#0x8	; 023062A4
	lsr r2,r2,#0x10	; 023062A6
	add r2,r4,r2	; 023062A8
	str r2,[r5,#0x0]	; 023062AA
	ldr r2,[pool_023063C0]	; 023062AC
	ldrh r3,[r2,#0x0]	; 023062AE
	add r2,r0,#0x0	; 023062B0
	add r2,#0x84	; 023062B2
	ldr r5,[r2,#0x0]	; 023062B4
	add r4,r3,#0x0	; 023062B6
	and r4,r1	; 023062B8
	lsl r4,r4,#0x10	; 023062BA
	lsr r4,r4,#0x10	; 023062BC
	add r4,r5,r4	; 023062BE
	str r4,[r2,#0x0]	; 023062C0
	add r5,r0,#0x0	; 023062C2
	add r5,#0x88	; 023062C4
	ldr r4,[r5,#0x0]	; 023062C6
	lsl r2,r3,#0x8	; 023062C8
	lsr r2,r2,#0x10	; 023062CA
	add r2,r4,r2	; 023062CC
	str r2,[r5,#0x0]	; 023062CE
	ldr r2,[pool_023063C4]	; 023062D0
	ldrh r3,[r2,#0x0]	; 023062D2
	add r2,r0,#0x0	; 023062D4
	add r2,#0x8c	; 023062D6
	ldr r5,[r2,#0x0]	; 023062D8
	add r4,r3,#0x0	; 023062DA
	and r4,r1	; 023062DC
	lsl r4,r4,#0x10	; 023062DE
	lsr r4,r4,#0x10	; 023062E0
	add r4,r5,r4	; 023062E2
	str r4,[r2,#0x0]	; 023062E4
	add r5,r0,#0x0	; 023062E6
	add r5,#0x90	; 023062E8
	ldr r4,[r5,#0x0]	; 023062EA
	lsl r2,r3,#0x8	; 023062EC
	lsr r2,r2,#0x10	; 023062EE
	add r2,r4,r2	; 023062F0
	str r2,[r5,#0x0]	; 023062F2
	ldr r2,[pool_023063C8]	; 023062F4
	ldrh r3,[r2,#0x0]	; 023062F6
	add r2,r0,#0x0	; 023062F8
	add r2,#0x94	; 023062FA
	ldr r5,[r2,#0x0]	; 023062FC
	add r4,r3,#0x0	; 023062FE
	and r4,r1	; 02306300
	lsl r4,r4,#0x10	; 02306302
	lsr r4,r4,#0x10	; 02306304
	add r4,r5,r4	; 02306306
	str r4,[r2,#0x0]	; 02306308
	add r5,r0,#0x0	; 0230630A
	add r5,#0x98	; 0230630C
	ldr r4,[r5,#0x0]	; 0230630E
	lsl r2,r3,#0x8	; 02306310
	lsr r2,r2,#0x10	; 02306312
	add r2,r4,r2	; 02306314
	str r2,[r5,#0x0]	; 02306316
	ldr r2,[pool_023063CC]	; 02306318
	ldrh r3,[r2,#0x0]	; 0230631A
	add r2,r0,#0x0	; 0230631C
	add r2,#0x9c	; 0230631E
	ldr r5,[r2,#0x0]	; 02306320
	add r4,r3,#0x0	; 02306322
	and r4,r1	; 02306324
	lsl r4,r4,#0x10	; 02306326
	lsr r4,r4,#0x10	; 02306328
	add r4,r5,r4	; 0230632A
	str r4,[r2,#0x0]	; 0230632C
	add r5,r0,#0x0	; 0230632E
	add r5,#0xa0	; 02306330
	ldr r4,[r5,#0x0]	; 02306332
	lsl r2,r3,#0x8	; 02306334
	lsr r2,r2,#0x10	; 02306336
	add r2,r4,r2	; 02306338
	str r2,[r5,#0x0]	; 0230633A
	ldr r2,[pool_023063D0]	; 0230633C
	ldrh r3,[r2,#0x0]	; 0230633E
	add r2,r0,#0x0	; 02306340
	add r2,#0xa4	; 02306342
	ldr r5,[r2,#0x0]	; 02306344
	add r4,r3,#0x0	; 02306346
	and r4,r1	; 02306348
	lsl r4,r4,#0x10	; 0230634A
	lsr r4,r4,#0x10	; 0230634C
	add r4,r5,r4	; 0230634E
	str r4,[r2,#0x0]	; 02306350
	add r5,r0,#0x0	; 02306352
	add r5,#0xa8	; 02306354
	ldr r4,[r5,#0x0]	; 02306356
	lsl r2,r3,#0x8	; 02306358
	lsr r2,r2,#0x10	; 0230635A
	add r2,r4,r2	; 0230635C
	str r2,[r5,#0x0]	; 0230635E
	ldr r2,[pool_023063D4]	; 02306360
	ldrh r3,[r2,#0x0]	; 02306362
	add r2,r0,#0x0	; 02306364
	add r2,#0xac	; 02306366
	ldr r5,[r2,#0x0]	; 02306368
	add r4,r3,#0x0	; 0230636A
	and r4,r1	; 0230636C
	lsl r1,r4,#0x10	; 0230636E
	lsr r1,r1,#0x10	; 02306370
	add r1,r5,r1	; 02306372
	str r1,[r2,#0x0]	; 02306374
	add r0,#0xb0	; 02306376
	ldr r2,[r0,#0x0]	; 02306378
	lsl r1,r3,#0x8	; 0230637A
	lsr r1,r1,#0x10	; 0230637C
	add r1,r2,r1	; 0230637E
	str r1,[r0,#0x0]	; 02306380
	add sp,#0x4	; 02306382
	pop {r4,r5}	; 02306384
	pop {r3}	; 02306386
	bx r3	; 02306388
	.byte 0xC0, 0x46	; 0230638C
pool_0230638C:
loc_0230638C:
	.word FirmwareWlWorkPointerSlot	; 0230638C
pool_02306390:
loc_02306390:
	.word 0x000004F4	; 02306390
pool_02306394:
loc_02306394:
	.word REG_WIFI_RXSTAT	; 02306394
pool_02306398:
loc_02306398:
	.word REG_WIFI_RXSTAT + 0x2	; 02306398
pool_0230639C:
loc_0230639C:
	.word REG_WIFI_RXSTAT + 0x4	; 0230639C
pool_023063A0:
loc_023063A0:
	.word REG_WIFI_RXSTAT + 0x6	; 023063A0
pool_023063A4:
loc_023063A4:
	.word REG_WIFI_RXSTAT + 0x8	; 023063A4
pool_023063A8:
loc_023063A8:
	.word REG_WIFI_RXSTAT + 0xA	; 023063A8
pool_023063AC:
loc_023063AC:
	.word REG_WIFI_RXSTAT + 0xC	; 023063AC
pool_023063B0:
loc_023063B0:
	.word REG_WIFI_RXSTAT + 0xE	; 023063B0
pool_023063B4:
loc_023063B4:
	.word REG_WIFI_TX_ERR_COUNT	; 023063B4
pool_023063B8:
loc_023063B8:
	.word REG_WIFI_CMD_STAT	; 023063B8
pool_023063BC:
loc_023063BC:
	.word REG_WIFI_CMD_STAT + 0x2	; 023063BC
pool_023063C0:
loc_023063C0:
	.word REG_WIFI_CMD_STAT + 0x4	; 023063C0
pool_023063C4:
loc_023063C4:
	.word REG_WIFI_CMD_STAT + 0x6	; 023063C4
pool_023063C8:
loc_023063C8:
	.word REG_WIFI_CMD_STAT + 0x8	; 023063C8
pool_023063CC:
loc_023063CC:
	.word REG_WIFI_CMD_STAT + 0xA	; 023063CC
pool_023063D0:
loc_023063D0:
	.word REG_WIFI_CMD_STAT + 0xC	; 023063D0
pool_023063D4:
loc_023063D4:
	.word REG_WIFI_CMD_STAT + 0xE	; 023063D4
	.byte 0x00, 0xB5, 0x81, 0xB0, 0xFF, 0xF7, 0xC6, 0xFE, 0x00, 0x20, 0x00, 0x90, 0x00, 0x98, 0x05, 0x49	; 023063E8
	.byte 0x0A, 0x68, 0x05, 0x49, 0x51, 0x18, 0xB4, 0x22, 0x00, 0xF0, 0x08, 0xF8, 0x01, 0xB0, 0x08, 0xBC	; 023063F8
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF4, 0x04, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 02306408
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x38, 0xCE, 0x7F, 0x03	; 02306410

; ===== function loc_02306410 =====
loc_02306410:
	push {r4,lr}	; 02306410
	ldrh r4,[r1,#0x0]	; 02306412
	strh r4,[r0,#0x0]	; 02306414
	ldrh r4,[r1,#0x2]	; 02306416
	strh r4,[r0,#0x2]	; 02306418
	ldrh r1,[r1,#0x4]	; 0230641A
	strh r1,[r0,#0x4]	; 0230641C
	ldrh r1,[r2,#0x0]	; 0230641E
	strh r1,[r0,#0x6]	; 02306420
	ldrh r1,[r2,#0x2]	; 02306422
	strh r1,[r0,#0x8]	; 02306424
	ldrh r1,[r2,#0x4]	; 02306426
	strh r1,[r0,#0xa]	; 02306428
	ldrh r1,[r3,#0x0]	; 0230642A
	strh r1,[r0,#0xc]	; 0230642C
	ldrh r1,[r3,#0x2]	; 0230642E
	strh r1,[r0,#0xe]	; 02306430
	ldrh r1,[r3,#0x4]	; 02306432
	strh r1,[r0,#0x10]	; 02306434
	pop {r4}	; 02306436
	pop {r3}	; 02306438
	bx r3	; 0230643A

; ===== function loc_0230643C =====
loc_0230643C:
	ldrh r3,[r1,#0x0]	; 0230643C
	strh r3,[r0,#0x0]	; 0230643E
	ldrh r3,[r1,#0x2]	; 02306440
	strh r3,[r0,#0x2]	; 02306442
	ldrh r1,[r1,#0x4]	; 02306444
	strh r1,[r0,#0x4]	; 02306446
	ldrh r1,[r2,#0x0]	; 02306448
	strh r1,[r0,#0x6]	; 0230644A
	ldrh r1,[r2,#0x2]	; 0230644C
	strh r1,[r0,#0x8]	; 0230644E
	ldrh r1,[r2,#0x4]	; 02306450
	strh r1,[r0,#0xa]	; 02306452
	bx lr	; 02306454
	.byte 0x00, 0x00	; 02306458

; ===== function loc_02306458 =====
loc_02306458:
	ldrh r2,[r1,#0x0]	; 02306458
	strh r2,[r0,#0x0]	; 0230645A
	ldrh r2,[r1,#0x2]	; 0230645C
	strh r2,[r0,#0x2]	; 0230645E
	ldrh r1,[r1,#0x4]	; 02306460
	strh r1,[r0,#0x4]	; 02306462
	bx lr	; 02306464
	.byte 0x00, 0x00	; 02306468

; ===== function loc_02306468 =====
loc_02306468:
	push {r4,lr}	; 02306468
	add r4,r0,#0x0	; 0230646A
	ldr r0,[pool_023064C4]	; 0230646C
	ldr r1,[r0,#0x0]	; 0230646E
	ldr r0,[pool_023064C8]	; 02306470
	ldrh r0,[r1,r0]	; 02306472
	cmp r0,r4	; 02306474
	beq loc_023064BE	; 02306476
	cmp r0,#0x40	; 02306478
	bne loc_02306480	; 0230647A
	bl loc_0230558C	; 0230647C
loc_02306480:
	cmp r4,#0x0	; 02306480
	beq loc_0230648E	; 02306482
	cmp r4,#0x10	; 02306484
	beq loc_02306494	; 02306486
	cmp r4,#0x40	; 02306488
	beq loc_0230649E	; 0230648A
	b loc_023064B6	; 0230648C
loc_0230648E:
	bl loc_023067AC	; 0230648E
	b loc_023064B6	; 02306492
loc_02306494:
	bl loc_02305B3C	; 02306494
	bl loc_02306744	; 02306498
	b loc_023064B6	; 0230649C
loc_0230649E:
	ldr r0,[pool_023064C4]	; 0230649E
	ldr r1,[r0,#0x0]	; 023064A0
	ldr r0,[pool_023064CC]	; 023064A2
	ldrh r0,[r1,r0]	; 023064A4
	cmp r0,#0x2	; 023064A6
	bne loc_023064AE	; 023064A8
	bl loc_02306670	; 023064AA
loc_023064AE:
	mov r0,#0x64	; 023064AE
	ldr r1,[pool_023064D0]	; 023064B0
	bl loc_023056AC	; 023064B2
loc_023064B6:
	ldr r0,[pool_023064C4]	; 023064B6
	ldr r1,[r0,#0x0]	; 023064B8
	ldr r0,[pool_023064C8]	; 023064BA
	strh r4,[r1,r0]	; 023064BC
loc_023064BE:
	pop {r4}	; 023064BE
	pop {r3}	; 023064C0
	bx r3	; 023064C2
pool_023064C4:
loc_023064C4:
	.word FirmwareWlWorkPointerSlot	; 023064C4
pool_023064C8:
loc_023064C8:
	.word 0x00000310	; 023064C8
pool_023064CC:
loc_023064CC:
	.word 0x00000314	; 023064CC
pool_023064D0:
loc_023064D0:
	.word P4_Code_0230562C + 1	; 023064D0

; ===== function loc_023064D4 =====
loc_023064D4:
	push {lr}	; 023064D4
	sub sp,#0x4	; 023064D6
	mov r3,#0x0	; 023064D8
	ldr r2,[pool_0230653C]	; 023064DA
	ldr r1,[r2,#0x0]	; 023064DC
	ldr r0,[pool_02306540]	; 023064DE
	strh r3,[r1,r0]	; 023064E0
	ldr r1,[r2,#0x0]	; 023064E2
	ldr r0,[pool_02306544]	; 023064E4
	strh r3,[r1,r0]	; 023064E6
	ldr r2,[pool_02306548]	; 023064E8
	ldr r3,[pool_0230654C]	; 023064EA
	mov r0,#0x1	; 023064EC
loc_023064EE:
	ldrh r1,[r3,#0x0]	; 023064EE
	and r1,r0	; 023064F0
	cmp r1,#0x0	; 023064F2
	bne loc_023064EE	; 023064F4
	ldrh r1,[r2,#0x0]	; 023064F6
	cmp r1,#0x6	; 023064F8
	beq loc_023064EE	; 023064FA
	ldrh r1,[r2,#0x0]	; 023064FC
	cmp r1,#0x5	; 023064FE
	beq loc_023064EE	; 02306500
	mov r1,#0x0	; 02306502
	ldr r0,[pool_02306550]	; 02306504
	strh r1,[r0,#0x0]	; 02306506
	ldr r0,[pool_02306554]	; 02306508
	strh r1,[r0,#0x0]	; 0230650A
	ldr r0,[pool_0230653C]	; 0230650C
	ldr r1,[r0,#0x0]	; 0230650E
	ldr r0,[pool_02306558]	; 02306510
	ldrh r0,[r1,r0]	; 02306512
	cmp r0,#0x0	; 02306514
	beq loc_02306534	; 02306516
	bl loc_0230CC7C	; 02306518
	ldr r0,[pool_0230653C]	; 0230651C
	ldr r1,[r0,#0x0]	; 0230651E
	ldr r0,[pool_02306558]	; 02306520
	ldrh r0,[r1,r0]	; 02306522
	mov r1,#0x20	; 02306524
	bl loc_023091EC	; 02306526
	mov r2,#0x0	; 0230652A
	ldr r0,[pool_0230653C]	; 0230652C
	ldr r1,[r0,#0x0]	; 0230652E
	ldr r0,[pool_02306558]	; 02306530
	strh r2,[r1,r0]	; 02306532
loc_02306534:
	add sp,#0x4	; 02306534
	pop {r3}	; 02306536
	bx r3	; 02306538
	.byte 0xC0, 0x46	; 0230653C
pool_0230653C:
loc_0230653C:
	.word FirmwareWlWorkPointerSlot	; 0230653C
pool_02306540:
loc_02306540:
	.word 0x00000366	; 02306540
pool_02306544:
loc_02306544:
	.word 0x00000486	; 02306544
pool_02306548:
loc_02306548:
	.word REG_WIFI_RF_STATUS	; 02306548
pool_0230654C:
loc_0230654C:
	.word REG_WIFI_RF_PINS	; 0230654C
pool_02306550:
loc_02306550:
	.word REG_WIFI_AID_LOW	; 02306550
pool_02306554:
loc_02306554:
	.word REG_WIFI_AID_FULL	; 02306554
pool_02306558:
loc_02306558:
	.word 0x00000384	; 02306558

; ===== function loc_0230655C =====
loc_0230655C:
	push {r4,lr}	; 0230655C
	ldr r4,[pool_02306580]	; 0230655E
	ldr r2,[r4,#0x0]	; 02306560
	ldr r1,[pool_02306584]	; 02306562
	strh r0,[r2,r1]	; 02306564
	mov r3,#0x1	; 02306566
	lsl r3,r0	; 02306568
	ldr r2,[r4,#0x0]	; 0230656A
	ldr r1,[pool_02306588]	; 0230656C
	strh r3,[r2,r1]	; 0230656E
	ldr r1,[pool_0230658C]	; 02306570
	strh r0,[r1,#0x0]	; 02306572
	ldr r1,[pool_02306590]	; 02306574
	strh r0,[r1,#0x0]	; 02306576
	pop {r4}	; 02306578
	pop {r3}	; 0230657A
	bx r3	; 0230657C
	.byte 0xC0, 0x46	; 02306580
pool_02306580:
loc_02306580:
	.word FirmwareWlWorkPointerSlot	; 02306580
pool_02306584:
loc_02306584:
	.word 0x00000366	; 02306584
pool_02306588:
loc_02306588:
	.word 0x00000486	; 02306588
pool_0230658C:
loc_0230658C:
	.word REG_WIFI_AID_FULL	; 0230658C
pool_02306590:
loc_02306590:
	.word REG_WIFI_AID_LOW	; 02306590
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0F, 0x1C, 0x80, 0x2D, 0x01, 0xD9, 0x04, 0x20, 0x2E, 0xE0	; 023065A4
	.byte 0x00, 0x2D, 0x23, 0xD0, 0x18, 0x48, 0x01, 0x68, 0x18, 0x48, 0x0A, 0x5A, 0x01, 0x20, 0x02, 0x40	; 023065B4
	.byte 0x00, 0x2A, 0x15, 0xD0, 0x16, 0x48, 0x0C, 0x58, 0x20, 0x1C, 0xFF, 0x21, 0xFE, 0xF7, 0x0A, 0xFF	; 023065C4
	.byte 0x64, 0x1C, 0x00, 0x26, 0x09, 0xE0, 0x38, 0x1C, 0xFE, 0xF7, 0xF2, 0xFE, 0x01, 0x1C, 0x20, 0x1C	; 023065D4
	.byte 0xFE, 0xF7, 0x00, 0xFF, 0x64, 0x1C, 0x7F, 0x1C, 0x76, 0x1C, 0xAE, 0x42, 0xF3, 0xD3, 0x05, 0xE0	; 023065E4
	.byte 0x38, 0x1C, 0x0B, 0x4A, 0x89, 0x58, 0x6A, 0x1C, 0x00, 0xF0, 0x18, 0xF8, 0x06, 0x4B, 0x19, 0x68	; 023065F4
	.byte 0x08, 0x48, 0x0D, 0x52, 0x01, 0x22, 0x19, 0x68, 0x07, 0x48, 0x0A, 0x52, 0x00, 0x20, 0x01, 0xB0	; 02306604
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x9E, 0x03, 0x00, 0x00	; 02306614
	.byte 0x98, 0x03, 0x00, 0x00, 0x9C, 0x03, 0x00, 0x00, 0xA0, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 02306624
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x1C, 0xCE, 0x7F, 0x03, 0x10, 0xB5, 0x04, 0x1C, 0x80, 0x2C, 0x01, 0xD9	; 02306634
	.byte 0x04, 0x20, 0x0C, 0xE0, 0x08, 0x1C, 0x07, 0x49, 0x0A, 0x68, 0x07, 0x49, 0x51, 0x58, 0x62, 0x1C	; 02306644
	.byte 0x00, 0xF0, 0x0E, 0xF8, 0x03, 0x48, 0x01, 0x68, 0x04, 0x48, 0x0C, 0x52, 0x00, 0x20, 0x10, 0xBC	; 02306654
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x98, 0x03, 0x00, 0x00, 0x9C, 0x03, 0x00, 0x00	; 02306664
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x1C, 0xCE, 0x7F, 0x03	; 02306670

; ===== function loc_02306670 =====
loc_02306670:
	mov r2,#0x0	; 02306670
	ldr r0,[pool_02306688]	; 02306672
	ldr r1,[r0,#0x0]	; 02306674
	ldr r0,[pool_0230668C]	; 02306676
	strh r2,[r1,r0]	; 02306678
	ldr r2,[pool_02306690]	; 0230667A
	ldrh r1,[r2,#0x0]	; 0230667C
	mov r0,#0x2	; 0230667E
	orr r1,r0	; 02306680
	strh r1,[r2,#0x0]	; 02306682
	bx lr	; 02306684
	.byte 0xC0, 0x46	; 02306688
pool_02306688:
loc_02306688:
	.word FirmwareWlWorkPointerSlot	; 02306688
pool_0230668C:
loc_0230668C:
	.word 0x000003A2	; 0230668C
pool_02306690:
loc_02306690:
	.word REG_WIFI_POWER_TX	; 02306690

; ===== function loc_02306694 =====
loc_02306694:
	mov r3,#0x1	; 02306694
	ldr r2,[pool_023066BC]	; 02306696
	ldr r1,[r2,#0x0]	; 02306698
	ldr r0,[pool_023066C0]	; 0230669A
	strh r3,[r1,r0]	; 0230669C
	ldr r1,[r2,#0x0]	; 0230669E
	ldr r0,[pool_023066C4]	; 023066A0
	ldrh r0,[r1,r0]	; 023066A2
	cmp r0,#0x0	; 023066A4
	bne loc_023066B8	; 023066A6
	ldr r2,[pool_023066C8]	; 023066A8
	ldrh r1,[r2,#0x0]	; 023066AA
	mov r0,#0x2	; 023066AC
	bic r1,r0	; 023066AE
	strh r1,[r2,#0x0]	; 023066B0
	mov r1,#0x0	; 023066B2
	ldr r0,[pool_023066CC]	; 023066B4
	strh r1,[r0,#0x0]	; 023066B6
loc_023066B8:
	bx lr	; 023066B8
	.byte 0xC0, 0x46	; 023066BC
pool_023066BC:
loc_023066BC:
	.word FirmwareWlWorkPointerSlot	; 023066BC
pool_023066C0:
loc_023066C0:
	.word 0x000003A2	; 023066C0
pool_023066C4:
loc_023066C4:
	.word 0x00000420	; 023066C4
pool_023066C8:
loc_023066C8:
	.word REG_WIFI_POWER_TX	; 023066C8
pool_023066CC:
loc_023066CC:
	.word REG_WIFI_UNKNOWN_048	; 023066CC

; ===== function loc_023066D0 =====
loc_023066D0:
	push {r4,r5,lr}	; 023066D0
	sub sp,#0x4	; 023066D2
	add r5,r0,#0x0	; 023066D4
	ldr r2,[pool_02306720]	; 023066D6
	cmp r5,r2	; 023066D8
	bne loc_023066EE	; 023066DA
	mov r4,#0xff	; 023066DC
	ldr r3,[pool_02306724]	; 023066DE
	ldr r1,[r3,#0x0]	; 023066E0
	ldr r0,[pool_02306728]	; 023066E2
	strh r4,[r1,r0]	; 023066E4
	ldr r1,[r3,#0x0]	; 023066E6
	ldr r0,[pool_0230672C]	; 023066E8
	strh r2,[r1,r0]	; 023066EA
	b loc_02306716	; 023066EC
loc_023066EE:
	ldr r0,[pool_02306724]	; 023066EE
	ldr r4,[r0,#0x0]	; 023066F0
	ldr r0,[pool_02306730]	; 023066F2
	ldrh r1,[r4,r0]	; 023066F4
	add r0,r5,#0x0	; 023066F6
	mul r0,r1	; 023066F8
	mov r1,#0x64	; 023066FA
	bl loc_02306738	; 023066FC
	ldr r1,[pool_02306734]	; 02306700
	cmp r0,r1	; 02306702
	bls loc_0230670A	; 02306704
	mov r0,#0x5	; 02306706
	b loc_02306718	; 02306708
loc_0230670A:
	ldr r1,[pool_02306728]	; 0230670A
	strh r5,[r4,r1]	; 0230670C
	ldr r1,[pool_02306724]	; 0230670E
	ldr r2,[r1,#0x0]	; 02306710
	ldr r1,[pool_0230672C]	; 02306712
	strh r0,[r2,r1]	; 02306714
loc_02306716:
	mov r0,#0x0	; 02306716
loc_02306718:
	add sp,#0x4	; 02306718
	pop {r4,r5}	; 0230671A
	pop {r3}	; 0230671C
	bx r3	; 0230671E
pool_02306720:
loc_02306720:
	.word 0x0000FFFF	; 02306720
pool_02306724:
loc_02306724:
	.word FirmwareWlWorkPointerSlot	; 02306724
pool_02306728:
loc_02306728:
	.word 0x000002FC	; 02306728
pool_0230672C:
loc_0230672C:
	.word 0x00000388	; 0230672C
pool_02306730:
loc_02306730:
	.word 0x0000036A	; 02306730
pool_02306734:
loc_02306734:
	.word 0x00010000	; 02306734

; ===== function loc_02306738 =====
loc_02306738:
	bx pc	; 02306738
	.byte 0xC0, 0x46	; 0230673C
.arm

; ===== function loc_0230673C =====
loc_0230673C:
	ldr pc,[pool_02306740]	; 0230673C
pool_02306740:
loc_02306740:
	.word loc_03802720	; 02306740
.thumb

; ===== function loc_02306744 =====
loc_02306744:
	push {r4,lr}	; 02306744
	mov r1,#0x0	; 02306746
	ldr r0,[pool_0230679C]	; 02306748
	strh r1,[r0,#0x0]	; 0230674A
	mov r0,#0x8	; 0230674C
	bl loc_02305774	; 0230674E
	mov r1,#0x0	; 02306752
	ldr r0,[pool_023067A0]	; 02306754
	strh r1,[r0,#0x0]	; 02306756
	ldr r0,[pool_023067A4]	; 02306758
	ldr r1,[r0,#0x0]	; 0230675A
	ldr r0,[pool_023067A8]	; 0230675C
	ldrh r0,[r1,r0]	; 0230675E
	cmp r0,#0x2	; 02306760
	beq loc_0230676A	; 02306762
	cmp r0,#0x3	; 02306764
	beq loc_02306792	; 02306766
	b loc_02306796	; 02306768
loc_0230676A:
	mov r0,#0x1	; 0230676A
	bl loc_02305B04	; 0230676C
	add r4,r0,#0x0	; 02306770
	mov r0,#0x1	; 02306772
	mov r2,#0x7f	; 02306774
	add r1,r4,#0x0	; 02306776
	and r1,r2	; 02306778
	bl loc_02305A98	; 0230677A
	mov r0,#0x1	; 0230677E
	add r1,r4,#0x0	; 02306780
	bl loc_02305A98	; 02306782
	mov r0,#0x28	; 02306786
	bl loc_02305774	; 02306788
	bl loc_02305828	; 0230678C
	b loc_02306796	; 02306790
loc_02306792:
	bl loc_02305828	; 02306792
loc_02306796:
	pop {r4}	; 02306796
	pop {r3}	; 02306798
	bx r3	; 0230679A
pool_0230679C:
loc_0230679C:
	.word REG_WIFI_POWER_US	; 0230679C
pool_023067A0:
loc_023067A0:
	.word REG_WIFI_BB_POWER	; 023067A0
pool_023067A4:
loc_023067A4:
	.word FirmwareWlWorkPointerSlot	; 023067A4
pool_023067A8:
loc_023067A8:
	.word 0x000005B0	; 023067A8

; ===== function loc_023067AC =====
loc_023067AC:
	push {lr}	; 023067AC
	sub sp,#0x4	; 023067AE
	ldr r0,[pool_023067EC]	; 023067B0
	ldr r1,[r0,#0x0]	; 023067B2
	ldr r0,[pool_023067F0]	; 023067B4
	ldrh r0,[r1,r0]	; 023067B6
	cmp r0,#0x2	; 023067B8
	beq loc_023067C0	; 023067BA
	cmp r0,#0x3	; 023067BC
	b loc_023067C6	; 023067BE
loc_023067C0:
	ldr r0,[pool_023067F4]	; 023067C0
	bl loc_02305A68	; 023067C2
loc_023067C6:
	mov r0,#0x1e	; 023067C6
	bl loc_02305B04	; 023067C8
	mov r2,#0x3f	; 023067CC
	add r1,r0,#0x0	; 023067CE
	orr r1,r2	; 023067D0
	mov r0,#0x1e	; 023067D2
	bl loc_02305A98	; 023067D4
	ldr r1,[pool_023067F8]	; 023067D8
	ldr r0,[pool_023067FC]	; 023067DA
	strh r1,[r0,#0x0]	; 023067DC
	mov r1,#0x1	; 023067DE
	ldr r0,[pool_02306800]	; 023067E0
	strh r1,[r0,#0x0]	; 023067E2
	add sp,#0x4	; 023067E4
	pop {r3}	; 023067E6
	bx r3	; 023067E8
	.byte 0xC0, 0x46	; 023067EC
pool_023067EC:
loc_023067EC:
	.word FirmwareWlWorkPointerSlot	; 023067EC
pool_023067F0:
loc_023067F0:
	.word 0x000005B0	; 023067F0
pool_023067F4:
loc_023067F4:
	.word 0x0000C008	; 023067F4
pool_023067F8:
loc_023067F8:
	.word 0x0000800D	; 023067F8
pool_023067FC:
loc_023067FC:
	.word REG_WIFI_BB_POWER	; 023067FC
pool_02306800:
loc_02306800:
	.word REG_WIFI_POWER_US	; 02306800

; ===== function loc_02306804 =====
loc_02306804:
	ldr r1,[pool_0230680C]	; 02306804
	strh r0,[r1,#0x0]	; 02306806
	mov r0,#0x0	; 02306808
	bx lr	; 0230680A
pool_0230680C:
loc_0230680C:
	.word REG_WIFI_POWERFORCE	; 0230680C

; ===== function loc_02306810 =====
loc_02306810:
	push {r4,lr}	; 02306810
	ldr r1,[pool_0230683C]	; 02306812
	ldr r2,[r1,#0x0]	; 02306814
	ldr r1,[pool_02306840]	; 02306816
	add r4,r2,r1	; 02306818
	ldrh r3,[r4,#0x0]	; 0230681A
	mov r1,#0x2	; 0230681C
	bic r3,r1	; 0230681E
	lsl r1,r0,#0xf	; 02306820
	lsr r2,r1,#0x10	; 02306822
	mov r1,#0x1	; 02306824
	and r2,r1	; 02306826
	lsl r1,r2,#0x1	; 02306828
	orr r3,r1	; 0230682A
	strh r3,[r4,#0x0]	; 0230682C
	ldr r1,[pool_02306844]	; 0230682E
	strh r0,[r1,#0x0]	; 02306830
	mov r0,#0x0	; 02306832
	pop {r4}	; 02306834
	pop {r3}	; 02306836
	bx r3	; 02306838
	.byte 0xC0, 0x46	; 0230683C
pool_0230683C:
loc_0230683C:
	.word FirmwareWlWorkPointerSlot	; 0230683C
pool_02306840:
loc_02306840:
	.word 0x00000316	; 02306840
pool_02306844:
loc_02306844:
	.word REG_WIFI_POWERSTATE	; 02306844

; ===== function loc_02306848 =====
loc_02306848:
	push {r4,r5,lr}	; 02306848
	sub sp,#0x4	; 0230684A
	ldr r1,[pool_023068A0]	; 0230684C
	ldr r3,[r1,#0x0]	; 0230684E
	ldr r2,[pool_023068A4]	; 02306850
	add r5,r3,r2	; 02306852
	ldrh r4,[r5,#0x0]	; 02306854
	mov r3,#0x1	; 02306856
	bic r4,r3	; 02306858
	lsl r2,r0,#0x10	; 0230685A
	lsr r2,r2,#0x10	; 0230685C
	and r2,r3	; 0230685E
	orr r4,r2	; 02306860
	strh r4,[r5,#0x0]	; 02306862
	cmp r0,#0x0	; 02306864
	beq loc_0230687E	; 02306866
	ldr r1,[r1,#0x0]	; 02306868
	ldr r0,[pool_023068A8]	; 0230686A
	ldrh r0,[r1,r0]	; 0230686C
	cmp r0,#0x1	; 0230686E
	beq loc_0230687E	; 02306870
	ldr r2,[pool_023068AC]	; 02306872
	ldrh r1,[r2,#0x0]	; 02306874
	mov r0,#0x40	; 02306876
	orr r1,r0	; 02306878
	strh r1,[r2,#0x0]	; 0230687A
	b loc_02306896	; 0230687C
loc_0230687E:
	ldr r2,[pool_023068AC]	; 0230687E
	ldrh r1,[r2,#0x0]	; 02306880
	mov r0,#0x40	; 02306882
	bic r1,r0	; 02306884
	strh r1,[r2,#0x0]	; 02306886
	ldr r0,[pool_023068A0]	; 02306888
	ldr r1,[r0,#0x0]	; 0230688A
	ldr r0,[pool_023068B0]	; 0230688C
	ldrh r0,[r1,r0]	; 0230688E
	mov r1,#0x0	; 02306890
	bl loc_02306FC8	; 02306892
loc_02306896:
	mov r0,#0x0	; 02306896
	add sp,#0x4	; 02306898
	pop {r4,r5}	; 0230689A
	pop {r3}	; 0230689C
	bx r3	; 0230689E
pool_023068A0:
loc_023068A0:
	.word FirmwareWlWorkPointerSlot	; 023068A0
pool_023068A4:
loc_023068A4:
	.word 0x00000316	; 023068A4
pool_023068A8:
loc_023068A8:
	.word 0x000002F2	; 023068A8
pool_023068AC:
loc_023068AC:
	.word REG_WIFI_MODE_WEP	; 023068AC
pool_023068B0:
loc_023068B0:
	.word 0x00000300	; 023068B0

; ===== function loc_023068B4 =====
loc_023068B4:
	push {lr}	; 023068B4
	sub sp,#0x4	; 023068B6
	ldr r0,[pool_023068FC]	; 023068B8
	str r0,[sp,#0x0]	; 023068BA
	mov r0,#0x58	; 023068BC
	mov r1,#0x2	; 023068BE
	add r2,sp,#0x0	; 023068C0
	bl loc_02310198	; 023068C2
	ldr r1,[sp,#0x0]	; 023068C6
	ldr r0,[pool_02306900]	; 023068C8
	add r0,r1,r0	; 023068CA
	str r0,[sp,#0x0]	; 023068CC
	bl loc_02306028	; 023068CE
	cmp r0,#0x14	; 023068D2
	bne loc_023068F0	; 023068D4
	ldr r1,[sp,#0x0]	; 023068D6
	ldr r0,[pool_02306904]	; 023068D8
	sub r2,r1,r0	; 023068DA
	str r2,[sp,#0x0]	; 023068DC
	ldr r0,[pool_02306908]	; 023068DE
	ldrh r1,[r0,#0x0]	; 023068E0
	mov r0,#0x2	; 023068E2
	and r1,r0	; 023068E4
	cmp r1,#0x0	; 023068E6
	beq loc_023068F0	; 023068E8
	ldr r0,[pool_0230690C]	; 023068EA
	sub r0,r2,r0	; 023068EC
	str r0,[sp,#0x0]	; 023068EE
loc_023068F0:
	ldr r1,[sp,#0x0]	; 023068F0
	ldr r0,[pool_02306910]	; 023068F2
	strh r1,[r0,#0x0]	; 023068F4
	add sp,#0x4	; 023068F6
	pop {r3}	; 023068F8
	bx r3	; 023068FA
pool_023068FC:
loc_023068FC:
	.word 0x0000E2E2	; 023068FC
pool_02306900:
loc_02306900:
	.word 0x00000202	; 02306900
pool_02306904:
loc_02306904:
	.word 0x00006161	; 02306904
pool_02306908:
loc_02306908:
	.word REG_WIFI_PREAMBLE	; 02306908
pool_0230690C:
loc_0230690C:
	.word 0x00006060	; 0230690C
pool_02306910:
loc_02306910:
	.word REG_WIFI_CONFIG_140	; 02306910

; ===== function loc_02306914 =====
loc_02306914:
	push {r4,lr}	; 02306914
	ldrh r4,[r0,#0x0]	; 02306916
	ldr r3,[pool_02306938]	; 02306918
	ldr r2,[r3,#0x0]	; 0230691A
	ldr r1,[pool_0230693C]	; 0230691C
	strh r4,[r2,r1]	; 0230691E
	ldrh r2,[r0,#0x2]	; 02306920
	ldrh r0,[r0,#0x0]	; 02306922
	orr r2,r0	; 02306924
	ldr r1,[r3,#0x0]	; 02306926
	ldr r0,[pool_02306940]	; 02306928
	strh r2,[r1,r0]	; 0230692A
	bl loc_023068B4	; 0230692C
	mov r0,#0x0	; 02306930
	pop {r4}	; 02306932
	pop {r3}	; 02306934
	bx r3	; 02306936
pool_02306938:
loc_02306938:
	.word FirmwareWlWorkPointerSlot	; 02306938
pool_0230693C:
loc_0230693C:
	.word 0x0000035C	; 0230693C
pool_02306940:
loc_02306940:
	.word 0x0000035E	; 02306940

; ===== function loc_02306944 =====
loc_02306944:
	push {r4,r5,r6,r7,lr}	; 02306944
	sub sp,#0x14	; 02306946
	add r4,r0,#0x0	; 02306948
	add r7,r1,#0x0	; 0230694A
	ldr r0,[pool_02306AB4]	; 0230694C
	ldr r0,[r0,#0x0]	; 0230694E
	mov r2,#0x1	; 02306950
	lsl r2,r4	; 02306952
	ldr r1,[pool_02306AB8]	; 02306954
	ldrh r1,[r0,r1]	; 02306956
	and r2,r1	; 02306958
	cmp r2,#0x0	; 0230695A
	bne loc_02306962	; 0230695C
	mov r0,#0x5	; 0230695E
	b loc_02306AAC	; 02306960
loc_02306962:
	ldr r1,[pool_02306ABC]	; 02306962
	strh r4,[r0,r1]	; 02306964
	ldr r0,[pool_02306AB4]	; 02306966
	ldr r0,[r0,#0x0]	; 02306968
	ldr r1,[pool_02306AC0]	; 0230696A
	ldrh r1,[r0,r1]	; 0230696C
	cmp r1,#0x5	; 0230696E
	bls loc_02306974	; 02306970
	b loc_02306AAA	; 02306972
loc_02306974:
	add r1,r1,r1	; 02306974
P4_SwitchIndexPC_02306974:
	add r1,pc	; 02306976
	ldrh r1,[r1,#(P4_SwitchTable_02306974 - (P4_SwitchIndexPC_02306974 + 4))]	; 02306978
	lsl r1,r1,#0x10	; 0230697A
	asr r1,r1,#0x10	; 0230697C
P4_SwitchTargetPC_02306974:
	add r1,pc	; 0230697E
	bx r1	; 02306980
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02306974:
	.halfword (loc_02306AAA + 1) - (P4_SwitchTargetPC_02306974 + 4)
	.halfword (loc_02306AAA + 1) - (P4_SwitchTargetPC_02306974 + 4)
	.halfword (loc_0230698E + 1) - (P4_SwitchTargetPC_02306974 + 4)
	.halfword (loc_02306A22 + 1) - (P4_SwitchTargetPC_02306974 + 4)
	.halfword (loc_02306AAA + 1) - (P4_SwitchTargetPC_02306974 + 4)
	.halfword (loc_0230698E + 1) - (P4_SwitchTargetPC_02306974 + 4)
P4_SwitchTable_02306974End:
loc_0230698E:
	mov r0,#0x0	; 0230698E
	str r0,[sp,#0x8]	; 02306990
	sub r4,r4,#0x1	; 02306992
	mov r0,#0x6	; 02306994
	add r5,r4,#0x0	; 02306996
	mul r5,r0	; 02306998
	add r0,r5,#0x0	; 0230699A
	add r0,#0xf2	; 0230699C
	mov r1,#0x3	; 0230699E
	add r2,sp,#0x8	; 023069A0
	bl loc_02310198	; 023069A2
	ldr r0,[sp,#0x8]	; 023069A6
	bl loc_02305A68	; 023069A8
	add r5,#0xf5	; 023069AC
	add r0,r5,#0x0	; 023069AE
	mov r1,#0x3	; 023069B0
	add r2,sp,#0x8	; 023069B2
	bl loc_02310198	; 023069B4
	ldr r0,[sp,#0x8]	; 023069B8
	bl loc_02305A68	; 023069BA
	cmp r7,#0x0	; 023069BE
	beq loc_023069C8	; 023069C0
	ldr r0,[pool_02306AC4]	; 023069C2
	bl loc_0230571C	; 023069C4
loc_023069C8:
	mov r0,#0x0	; 023069C8
	str r0,[sp,#0x8]	; 023069CA
	ldr r0,[pool_02306AB4]	; 023069CC
	ldr r1,[r0,#0x0]	; 023069CE
	ldr r0,[pool_02306AC8]	; 023069D0
	ldr r2,[r1,r0]	; 023069D2
	ldr r0,[pool_02306ACC]	; 023069D4
	add r1,r2,#0x0	; 023069D6
	and r1,r0	; 023069D8
	cmp r1,#0x0	; 023069DA
	beq loc_02306A0C	; 023069DC
	ldr r0,[pool_02306AD0]	; 023069DE
	and r2,r0	; 023069E0
	cmp r2,#0x0	; 023069E2
	bne loc_02306AAA	; 023069E4
	ldr r0,[pool_02306AD4]	; 023069E6
	add r0,r4,r0	; 023069E8
	mov r1,#0x1	; 023069EA
	add r2,sp,#0x8	; 023069EC
	bl loc_02310198	; 023069EE
	ldr r0,[pool_02306AB4]	; 023069F2
	ldr r1,[r0,#0x0]	; 023069F4
	ldr r0,[pool_02306AC8]	; 023069F6
	ldr r0,[r1,r0]	; 023069F8
	ldr r2,[sp,#0x8]	; 023069FA
	mov r1,#0x1f	; 023069FC
	and r2,r1	; 023069FE
	lsl r1,r2,#0xa	; 02306A00
	orr r0,r1	; 02306A02
	str r0,[sp,#0x8]	; 02306A04
	bl loc_02305A68	; 02306A06
	b loc_02306AAA	; 02306A0A
loc_02306A0C:
	ldr r0,[pool_02306AD8]	; 02306A0C
	add r0,r4,r0	; 02306A0E
	mov r1,#0x1	; 02306A10
	add r2,sp,#0x8	; 02306A12
	bl loc_02310198	; 02306A14
	mov r0,#0x1e	; 02306A18
	ldr r1,[sp,#0x8]	; 02306A1A
	bl loc_02305A98	; 02306A1C
	b loc_02306AAA	; 02306A20
loc_02306A22:
	ldr r1,[pool_02306ADC]	; 02306A22
	ldrh r5,[r0,r1]	; 02306A24
	add r5,#0xcf	; 02306A26
	mov r6,#0x0	; 02306A28
	str r6,[sp,#0x0]	; 02306A2A
	b loc_02306A54	; 02306A2C
loc_02306A2E:
	ldr r0,[sp,#0x0]	; 02306A2E
	str r0,[sp,#0x8]	; 02306A30
	str r0,[sp,#0xc]	; 02306A32
	add r0,r5,#0x0	; 02306A34
	mov r1,#0x1	; 02306A36
	add r2,sp,#0xc	; 02306A38
	bl loc_02310198	; 02306A3A
	add r0,r5,r4	; 02306A3E
	mov r1,#0x1	; 02306A40
	add r2,sp,#0x8	; 02306A42
	bl loc_02310198	; 02306A44
	ldr r0,[sp,#0xc]	; 02306A48
	ldr r1,[sp,#0x8]	; 02306A4A
	bl loc_02305A98	; 02306A4C
	add r5,#0xf	; 02306A50
	add r6,r6,#0x1	; 02306A52
loc_02306A54:
	ldr r0,[pool_02306AB4]	; 02306A54
	ldr r1,[r0,#0x0]	; 02306A56
	ldr r0,[pool_02306AE0]	; 02306A58
	ldrh r0,[r1,r0]	; 02306A5A
	cmp r6,r0	; 02306A5C
	bcc loc_02306A2E	; 02306A5E
	mov r6,#0x0	; 02306A60
	str r6,[sp,#0x4]	; 02306A62
	b loc_02306A94	; 02306A64
loc_02306A66:
	ldr r0,[sp,#0x4]	; 02306A66
	str r0,[sp,#0x8]	; 02306A68
	add r0,r5,#0x0	; 02306A6A
	mov r1,#0x1	; 02306A6C
	add r2,sp,#0x8	; 02306A6E
	bl loc_02310198	; 02306A70
	ldr r0,[sp,#0x8]	; 02306A74
	lsl r0,r0,#0x8	; 02306A76
	str r0,[sp,#0x8]	; 02306A78
	add r0,r5,r4	; 02306A7A
	mov r1,#0x1	; 02306A7C
	add r2,sp,#0x8	; 02306A7E
	bl loc_02310198	; 02306A80
	ldr r0,[sp,#0x8]	; 02306A84
	ldr r1,[pool_02306AE4]	; 02306A86
	orr r0,r1	; 02306A88
	str r0,[sp,#0x8]	; 02306A8A
	bl loc_02305A68	; 02306A8C
	add r5,#0xf	; 02306A90
	add r6,r6,#0x1	; 02306A92
loc_02306A94:
	ldr r0,[pool_02306AB4]	; 02306A94
	ldr r1,[r0,#0x0]	; 02306A96
	ldr r0,[pool_02306AE8]	; 02306A98
	ldrh r0,[r1,r0]	; 02306A9A
	cmp r6,r0	; 02306A9C
	bcc loc_02306A66	; 02306A9E
	cmp r7,#0x0	; 02306AA0
	beq loc_02306AAA	; 02306AA2
	ldr r0,[pool_02306AC4]	; 02306AA4
	bl loc_0230571C	; 02306AA6
loc_02306AAA:
	mov r0,#0x0	; 02306AAA
loc_02306AAC:
	add sp,#0x14	; 02306AAC
	pop {r4,r5,r6,r7}	; 02306AAE
	pop {r3}	; 02306AB0
	bx r3	; 02306AB2
pool_02306AB4:
loc_02306AB4:
	.word FirmwareWlWorkPointerSlot	; 02306AB4
pool_02306AB8:
loc_02306AB8:
	.word 0x000002F0	; 02306AB8
pool_02306ABC:
loc_02306ABC:
	.word 0x00000376	; 02306ABC
pool_02306AC0:
loc_02306AC0:
	.word 0x000005B0	; 02306AC0
pool_02306AC4:
loc_02306AC4:
	.word 0x000005DC	; 02306AC4
pool_02306AC8:
loc_02306AC8:
	.word 0x000005BC	; 02306AC8
pool_02306ACC:
loc_02306ACC:
	.word 0x00010000	; 02306ACC
pool_02306AD0:
loc_02306AD0:
	.word 0x00008000	; 02306AD0
pool_02306AD4:
loc_02306AD4:
	.word 0x00000154	; 02306AD4
pool_02306AD8:
loc_02306AD8:
	.word 0x00000146	; 02306AD8
pool_02306ADC:
loc_02306ADC:
	.word 0x000005B4	; 02306ADC
pool_02306AE0:
loc_02306AE0:
	.word 0x000005B8	; 02306AE0
pool_02306AE4:
loc_02306AE4:
	.word 0x00050000	; 02306AE4
pool_02306AE8:
loc_02306AE8:
	.word 0x000005B6	; 02306AE8

; ===== function loc_02306AEC =====
loc_02306AEC:
	push {lr}	; 02306AEC
	sub sp,#0xc	; 02306AEE
	mov r0,#0x36	; 02306AF0
	mov r1,#0x6	; 02306AF2
	add r2,sp,#0x0	; 02306AF4
	add r2,#0x2	; 02306AF6
	bl loc_02310198	; 02306AF8
	mov r0,#0x3c	; 02306AFC
	mov r1,#0x2	; 02306AFE
	add r2,sp,#0x0	; 02306B00
	bl loc_02310198	; 02306B02
	add r0,sp,#0x0	; 02306B06
	add r0,#0x2	; 02306B08
	bl loc_023072EC	; 02306B0A
	mov r0,#0x7	; 02306B0E
	bl loc_023072C8	; 02306B10
	add r0,sp,#0x0	; 02306B14
	ldrh r1,[r0,#0x0]	; 02306B16
	ldr r0,[pool_02306BCC]	; 02306B18
	and r1,r0	; 02306B1A
	lsl r0,r1,#0x10	; 02306B1C
	lsr r0,r0,#0x10	; 02306B1E
	bl loc_02307290	; 02306B20
	mov r0,#0x2	; 02306B24
	bl loc_02307228	; 02306B26
	mov r0,#0x0	; 02306B2A
	bl loc_02307200	; 02306B2C
	mov r0,#0x0	; 02306B30
	bl loc_02307148	; 02306B32
	mov r0,#0x0	; 02306B36
	bl loc_0230712C	; 02306B38
	ldr r0,[pool_02306BD0]	; 02306B3C
	bl loc_023070E0	; 02306B3E
	ldr r0,[pool_02306BD4]	; 02306B42
	bl loc_02306C18	; 02306B44
	mov r0,#0x0	; 02306B48
	bl loc_023070B8	; 02306B4A
	mov r0,#0x0	; 02306B4E
	bl loc_0230708C	; 02306B50
	mov r0,#0x10	; 02306B54
	bl loc_0230705C	; 02306B56
	ldr r0,[pool_02306BD8]	; 02306B5A
	mov r1,#0x0	; 02306B5C
	bl loc_02306FC8	; 02306B5E
	ldr r0,[pool_02306BDC]	; 02306B62
	bl loc_02306FA4	; 02306B64
	mov r0,#0x1	; 02306B68
	bl loc_02306EF8	; 02306B6A
	mov r0,#0x0	; 02306B6E
	bl loc_02306EDC	; 02306B70
	mov r0,#0xa	; 02306B74
	mov r1,#0x0	; 02306B76
	bl loc_02306944	; 02306B78
	ldr r0,[pool_02306BE0]	; 02306B7C
	bl loc_02306914	; 02306B7E
	mov r0,#0x0	; 02306B82
	mov r1,#0x1f	; 02306B84
	bl loc_02306EAC	; 02306B86
	mov r0,#0x5	; 02306B8A
	bl loc_023066D0	; 02306B8C
	mov r0,#0x0	; 02306B90
	add r1,r0,#0x0	; 02306B92
	bl loc_02306DC0	; 02306B94
	mov r0,#0x0	; 02306B98
	bl loc_02306E5C	; 02306B9A
	mov r0,#0x0	; 02306B9E
	bl loc_02306D90	; 02306BA0
	ldr r2,[pool_02306BE4]	; 02306BA4
	ldrh r1,[r2,#0x0]	; 02306BA6
	ldrh r0,[r2,#0x0]	; 02306BA8
	lsl r0,r0,#0x8	; 02306BAA
	add r0,r1,r0	; 02306BAC
	ldrh r1,[r2,#0x0]	; 02306BAE
	bl loc_02305384	; 02306BB0
	ldr r0,[pool_02306BE8]	; 02306BB4
	ldr r1,[r0,#0x0]	; 02306BB6
	ldr r0,[pool_02306BEC]	; 02306BB8
	add r2,r1,r0	; 02306BBA
	ldrh r1,[r2,#0x0]	; 02306BBC
	mov r0,#0x8	; 02306BBE
	orr r1,r0	; 02306BC0
	strh r1,[r2,#0x0]	; 02306BC2
	add sp,#0xc	; 02306BC4
	pop {r3}	; 02306BC6
	bx r3	; 02306BC8
	.byte 0xC0, 0x46	; 02306BCC
pool_02306BCC:
loc_02306BCC:
	.word 0x00007FFE	; 02306BCC
pool_02306BD0:
loc_02306BD0:
	.word 0x02310418	; 02306BD0
pool_02306BD4:
loc_02306BD4:
	.word 0x000001F4	; 02306BD4
pool_02306BD8:
loc_02306BD8:
	.word 0x0000FFFF	; 02306BD8
pool_02306BDC:
loc_02306BDC:
	.word 0x023103B8	; 02306BDC
pool_02306BE0:
loc_02306BE0:
	.word 0x02310374	; 02306BE0
pool_02306BE4:
loc_02306BE4:
	.word REG_WIFI_RANDOM	; 02306BE4
pool_02306BE8:
loc_02306BE8:
	.word FirmwareWlWorkPointerSlot	; 02306BE8
pool_02306BEC:
loc_02306BEC:
	.word 0x00000316	; 02306BEC

; ===== function loc_02306BF0 =====
loc_02306BF0:
	cmp r0,#0x1	; 02306BF0
	bcc loc_02306BF8	; 02306BF2
	cmp r0,#0xff	; 02306BF4
	bls loc_02306BFC	; 02306BF6
loc_02306BF8:
	mov r0,#0x5	; 02306BF8
	bx lr	; 02306BFA
loc_02306BFC:
	ldr r1,[pool_02306C0C]	; 02306BFC
	ldr r2,[r1,#0x0]	; 02306BFE
	ldr r1,[pool_02306C10]	; 02306C00
	strh r0,[r2,r1]	; 02306C02
	ldr r1,[pool_02306C14]	; 02306C04
	strh r0,[r1,#0x0]	; 02306C06
	mov r0,#0x0	; 02306C08
	bx lr	; 02306C0A
pool_02306C0C:
loc_02306C0C:
	.word FirmwareWlWorkPointerSlot	; 02306C0C
pool_02306C10:
loc_02306C10:
	.word 0x00000370	; 02306C10
pool_02306C14:
loc_02306C14:
	.word REG_WIFI_LISTENINT	; 02306C14

; ===== function loc_02306C18 =====
loc_02306C18:
	push {lr}	; 02306C18
	sub sp,#0x4	; 02306C1A
	cmp r0,#0xa	; 02306C1C
	bcc loc_02306C26	; 02306C1E
	ldr r1,[pool_02306C48]	; 02306C20
	cmp r0,r1	; 02306C22
	bls loc_02306C2A	; 02306C24
loc_02306C26:
	mov r0,#0x5	; 02306C26
	b loc_02306C42	; 02306C28
loc_02306C2A:
	ldr r3,[pool_02306C4C]	; 02306C2A
	ldr r2,[r3,#0x0]	; 02306C2C
	ldr r1,[pool_02306C50]	; 02306C2E
	strh r0,[r2,r1]	; 02306C30
	ldr r1,[pool_02306C54]	; 02306C32
	strh r0,[r1,#0x0]	; 02306C34
	ldr r1,[r3,#0x0]	; 02306C36
	ldr r0,[pool_02306C58]	; 02306C38
	ldrh r0,[r1,r0]	; 02306C3A
	bl loc_023066D0	; 02306C3C
	mov r0,#0x0	; 02306C40
loc_02306C42:
	add sp,#0x4	; 02306C42
	pop {r3}	; 02306C44
	bx r3	; 02306C46
pool_02306C48:
loc_02306C48:
	.word 0x000003E8	; 02306C48
pool_02306C4C:
loc_02306C4C:
	.word FirmwareWlWorkPointerSlot	; 02306C4C
pool_02306C50:
loc_02306C50:
	.word 0x0000036A	; 02306C50
pool_02306C54:
loc_02306C54:
	.word REG_WIFI_BEACONINT	; 02306C54
pool_02306C58:
loc_02306C58:
	.word 0x000002FC	; 02306C58
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x00, 0x27, 0x20, 0x2D, 0x01, 0xD9, 0x05, 0x20	; 02306C6C
	.byte 0x50, 0xE0, 0x2A, 0x48, 0x00, 0x68, 0x2A, 0x49, 0x41, 0x5A, 0x40, 0x29, 0x0E, 0xD1, 0x29, 0x49	; 02306C7C
	.byte 0x41, 0x5A, 0x01, 0x29, 0x0A, 0xD1, 0x28, 0x49, 0x41, 0x5A, 0xA9, 0x42, 0x01, 0xD0, 0x06, 0x20	; 02306C8C
	.byte 0x40, 0xE0, 0x26, 0x49, 0x40, 0x5A, 0x00, 0x28, 0x00, 0xD0, 0x01, 0x27, 0x00, 0x24, 0x0C, 0xE0	; 02306C9C
	.byte 0x30, 0x1C, 0xFE, 0xF7, 0x89, 0xFB, 0x01, 0x1C, 0x1C, 0x48, 0x02, 0x68, 0x20, 0x48, 0x10, 0x18	; 02306CAC
	.byte 0x00, 0x19, 0xFE, 0xF7, 0x93, 0xFB, 0x76, 0x1C, 0x64, 0x1C, 0xAC, 0x42, 0xF0, 0xD3, 0x17, 0x4E	; 02306CBC
	.byte 0x07, 0xE0, 0x31, 0x68, 0x1A, 0x48, 0x08, 0x18, 0x00, 0x19, 0x00, 0x21, 0xFE, 0xF7, 0x86, 0xFB	; 02306CCC
	.byte 0x64, 0x1C, 0x20, 0x2C, 0xF5, 0xD3, 0x11, 0x48, 0x01, 0x68, 0x13, 0x48, 0x0D, 0x52, 0x00, 0x2F	; 02306CDC
	.byte 0x17, 0xD0, 0x0E, 0x48, 0x02, 0x68, 0x13, 0x48, 0x11, 0x58, 0x26, 0x31, 0x0F, 0x48, 0x10, 0x5A	; 02306CEC
	.byte 0x0E, 0x18, 0x00, 0x24, 0x0E, 0x4F, 0x0A, 0xE0, 0x08, 0x48, 0x00, 0x68, 0xC0, 0x19, 0x00, 0x19	; 02306CFC
	.byte 0xFE, 0xF7, 0x5A, 0xFB, 0x01, 0x1C, 0x30, 0x19, 0xFE, 0xF7, 0x68, 0xFB, 0x64, 0x1C, 0xAC, 0x42	; 02306D0C
	.byte 0xF2, 0xD3, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02306D1C
	.byte 0x10, 0x03, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00, 0x1A, 0x03, 0x00, 0x00, 0x8E, 0x03, 0x00, 0x00	; 02306D2C
	.byte 0x1C, 0x03, 0x00, 0x00, 0x64, 0x04, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C, 0x0F, 0x48, 0x01, 0x68	; 02306D3C
	.byte 0x0F, 0x48, 0x08, 0x18, 0x21, 0x1C, 0xFF, 0xF7, 0x89, 0xFB, 0x0E, 0x48, 0x21, 0x1C, 0xFF, 0xF7	; 02306D4C
	.byte 0x85, 0xFB, 0x21, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x05, 0xD0, 0x0A, 0x4A, 0x11, 0x88	; 02306D5C
	.byte 0x0A, 0x48, 0x01, 0x40, 0x11, 0x80, 0x04, 0xE0, 0x07, 0x4A, 0x11, 0x88, 0x08, 0x48, 0x01, 0x43	; 02306D6C
	.byte 0x11, 0x80, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 02306D7C
	.byte 0x60, 0x03, 0x00, 0x00, 0x20, 0x80, 0x80, 0x04, 0xD0, 0x80, 0x80, 0x04, 0xFF, 0xFB, 0xFF, 0xFF	; 02306D8C
	.byte 0x00, 0x04, 0x00, 0x00	; 02306D90

; ===== function loc_02306D90 =====
loc_02306D90:
	cmp r0,#0x1	; 02306D90
	bls loc_02306D98	; 02306D92
	mov r0,#0x5	; 02306D94
	bx lr	; 02306D96
loc_02306D98:
	ldr r1,[pool_02306DB8]	; 02306D98
	ldr r2,[r1,#0x0]	; 02306D9A
	ldr r1,[pool_02306DBC]	; 02306D9C
	add r3,r2,r1	; 02306D9E
	ldrh r2,[r3,#0x0]	; 02306DA0
	mov r1,#0x40	; 02306DA2
	bic r2,r1	; 02306DA4
	lsl r0,r0,#0x10	; 02306DA6
	lsr r1,r0,#0x10	; 02306DA8
	mov r0,#0x1	; 02306DAA
	and r1,r0	; 02306DAC
	lsl r0,r1,#0x6	; 02306DAE
	orr r2,r0	; 02306DB0
	strh r2,[r3,#0x0]	; 02306DB2
	mov r0,#0x0	; 02306DB4
	bx lr	; 02306DB6
pool_02306DB8:
loc_02306DB8:
	.word FirmwareWlWorkPointerSlot	; 02306DB8
pool_02306DBC:
loc_02306DBC:
	.word 0x000002FE	; 02306DBC

; ===== function loc_02306DC0 =====
loc_02306DC0:
	push {r4,r5,lr}	; 02306DC0
	sub sp,#0x4	; 02306DC2
	cmp r0,#0x1	; 02306DC4
	bhi loc_02306DCC	; 02306DC6
	cmp r1,#0x1	; 02306DC8
	bls loc_02306DD0	; 02306DCA
loc_02306DCC:
	mov r0,#0x5	; 02306DCC
	b loc_02306E44	; 02306DCE
loc_02306DD0:
	cmp r0,#0x0	; 02306DD0
	beq loc_02306DDA	; 02306DD2
	cmp r0,#0x1	; 02306DD4
	beq loc_02306DF8	; 02306DD6
	b loc_02306E14	; 02306DD8
loc_02306DDA:
	ldr r2,[pool_02306E4C]	; 02306DDA
	ldr r3,[r2,#0x0]	; 02306DDC
	ldr r2,[pool_02306E50]	; 02306DDE
	add r3,r3,r2	; 02306DE0
	ldrh r2,[r3,#0x0]	; 02306DE2
	mov r4,#0x20	; 02306DE4
	bic r2,r4	; 02306DE6
	lsl r1,r1,#0x10	; 02306DE8
	lsr r4,r1,#0x10	; 02306DEA
	mov r1,#0x1	; 02306DEC
	and r4,r1	; 02306DEE
	lsl r1,r4,#0x5	; 02306DF0
	orr r2,r1	; 02306DF2
	strh r2,[r3,#0x0]	; 02306DF4
	b loc_02306E14	; 02306DF6
loc_02306DF8:
	ldr r1,[pool_02306E4C]	; 02306DF8
	ldr r2,[r1,#0x0]	; 02306DFA
	ldr r1,[pool_02306E54]	; 02306DFC
	ldrh r1,[r2,r1]	; 02306DFE
	cmp r1,#0x1	; 02306E00
	beq loc_02306E08	; 02306E02
	mov r0,#0xb	; 02306E04
	b loc_02306E44	; 02306E06
loc_02306E08:
	ldr r1,[pool_02306E50]	; 02306E08
	add r3,r2,r1	; 02306E0A
	ldrh r2,[r3,#0x0]	; 02306E0C
	mov r1,#0x20	; 02306E0E
	bic r2,r1	; 02306E10
	strh r2,[r3,#0x0]	; 02306E12
loc_02306E14:
	ldr r2,[pool_02306E4C]	; 02306E14
	ldr r1,[r2,#0x0]	; 02306E16
	ldr r5,[pool_02306E50]	; 02306E18
	add r3,r1,r5	; 02306E1A
	ldrh r1,[r3,#0x0]	; 02306E1C
	mov r4,#0x10	; 02306E1E
	bic r1,r4	; 02306E20
	lsl r0,r0,#0x10	; 02306E22
	lsr r4,r0,#0x10	; 02306E24
	mov r0,#0x1	; 02306E26
	and r4,r0	; 02306E28
	lsl r0,r4,#0x4	; 02306E2A
	orr r1,r0	; 02306E2C
	strh r1,[r3,#0x0]	; 02306E2E
	ldr r0,[r2,#0x0]	; 02306E30
	ldrh r0,[r0,r5]	; 02306E32
	lsl r1,r0,#0x1a	; 02306E34
	lsr r1,r1,#0x1f	; 02306E36
	lsl r0,r0,#0x1c	; 02306E38
	lsr r0,r0,#0x1f	; 02306E3A
	eor r1,r0	; 02306E3C
	ldr r0,[pool_02306E58]	; 02306E3E
	strh r1,[r0,#0x0]	; 02306E40
	mov r0,#0x0	; 02306E42
loc_02306E44:
	add sp,#0x4	; 02306E44
	pop {r4,r5}	; 02306E46
	pop {r3}	; 02306E48
	bx r3	; 02306E4A
pool_02306E4C:
loc_02306E4C:
	.word FirmwareWlWorkPointerSlot	; 02306E4C
pool_02306E50:
loc_02306E50:
	.word 0x000002FE	; 02306E50
pool_02306E54:
loc_02306E54:
	.word 0x000002F2	; 02306E54
pool_02306E58:
loc_02306E58:
	.word REG_WIFI_UNKNOWN_290	; 02306E58

; ===== function loc_02306E5C =====
loc_02306E5C:
	push {r4,r5,lr}	; 02306E5C
	sub sp,#0x4	; 02306E5E
	cmp r0,#0x1	; 02306E60
	bls loc_02306E68	; 02306E62
	mov r0,#0x5	; 02306E64
	b loc_02306E98	; 02306E66
loc_02306E68:
	ldr r2,[pool_02306EA0]	; 02306E68
	ldr r1,[r2,#0x0]	; 02306E6A
	ldr r5,[pool_02306EA4]	; 02306E6C
	add r3,r1,r5	; 02306E6E
	ldrh r1,[r3,#0x0]	; 02306E70
	mov r4,#0x8	; 02306E72
	bic r1,r4	; 02306E74
	lsl r0,r0,#0x10	; 02306E76
	lsr r4,r0,#0x10	; 02306E78
	mov r0,#0x1	; 02306E7A
	and r4,r0	; 02306E7C
	lsl r0,r4,#0x3	; 02306E7E
	orr r1,r0	; 02306E80
	strh r1,[r3,#0x0]	; 02306E82
	ldr r0,[r2,#0x0]	; 02306E84
	ldrh r0,[r0,r5]	; 02306E86
	lsl r1,r0,#0x1a	; 02306E88
	lsr r1,r1,#0x1f	; 02306E8A
	lsl r0,r0,#0x1c	; 02306E8C
	lsr r0,r0,#0x1f	; 02306E8E
	eor r1,r0	; 02306E90
	ldr r0,[pool_02306EA8]	; 02306E92
	strh r1,[r0,#0x0]	; 02306E94
	mov r0,#0x0	; 02306E96
loc_02306E98:
	add sp,#0x4	; 02306E98
	pop {r4,r5}	; 02306E9A
	pop {r3}	; 02306E9C
	bx r3	; 02306E9E
pool_02306EA0:
loc_02306EA0:
	.word FirmwareWlWorkPointerSlot	; 02306EA0
pool_02306EA4:
loc_02306EA4:
	.word 0x000002FE	; 02306EA4
pool_02306EA8:
loc_02306EA8:
	.word REG_WIFI_UNKNOWN_290	; 02306EA8

; ===== function loc_02306EAC =====
loc_02306EAC:
	push {r4,lr}	; 02306EAC
	add r2,r0,#0x0	; 02306EAE
	add r4,r1,#0x0	; 02306EB0
	cmp r2,#0x3	; 02306EB2
	bls loc_02306EBA	; 02306EB4
	mov r0,#0x5	; 02306EB6
	b loc_02306ED4	; 02306EB8
loc_02306EBA:
	cmp r4,#0x3f	; 02306EBA
	bls loc_02306EC2	; 02306EBC
	mov r0,#0x5	; 02306EBE
	b loc_02306ED4	; 02306EC0
loc_02306EC2:
	mov r0,#0x13	; 02306EC2
	add r1,r2,#0x0	; 02306EC4
	bl loc_02305A98	; 02306EC6
	mov r0,#0x35	; 02306ECA
	add r1,r4,#0x0	; 02306ECC
	bl loc_02305A98	; 02306ECE
	mov r0,#0x0	; 02306ED2
loc_02306ED4:
	pop {r4}	; 02306ED4
	pop {r3}	; 02306ED6
	bx r3	; 02306ED8
	.byte 0x00, 0x00	; 02306EDC

; ===== function loc_02306EDC =====
loc_02306EDC:
	cmp r0,#0x1	; 02306EDC
	bls loc_02306EE4	; 02306EDE
	mov r0,#0x5	; 02306EE0
	bx lr	; 02306EE2
loc_02306EE4:
	ldr r1,[pool_02306EF0]	; 02306EE4
	ldr r2,[r1,#0x0]	; 02306EE6
	ldr r1,[pool_02306EF4]	; 02306EE8
	strh r0,[r2,r1]	; 02306EEA
	mov r0,#0x0	; 02306EEC
	bx lr	; 02306EEE
pool_02306EF0:
loc_02306EF0:
	.word FirmwareWlWorkPointerSlot	; 02306EF0
pool_02306EF4:
loc_02306EF4:
	.word 0x000002F6	; 02306EF4

; ===== function loc_02306EF8 =====
loc_02306EF8:
	push {r4,r5,lr}	; 02306EF8
	sub sp,#0x4	; 02306EFA
	cmp r0,#0x1	; 02306EFC
	bls loc_02306F04	; 02306EFE
	mov r0,#0x5	; 02306F00
	b loc_02306F7E	; 02306F02
loc_02306F04:
	ldr r2,[pool_02306F88]	; 02306F04
	ldr r3,[r2,#0x0]	; 02306F06
	ldr r1,[pool_02306F8C]	; 02306F08
	add r3,r3,r1	; 02306F0A
	ldrh r1,[r3,#0x0]	; 02306F0C
	mov r4,#0x4	; 02306F0E
	bic r1,r4	; 02306F10
	mov r4,#0x1	; 02306F12
	add r5,r0,#0x0	; 02306F14
	and r5,r4	; 02306F16
	lsl r4,r5,#0x2	; 02306F18
	orr r1,r4	; 02306F1A
	strh r1,[r3,#0x0]	; 02306F1C
	cmp r0,#0x0	; 02306F1E
	bne loc_02306F32	; 02306F20
	ldr r2,[r2,#0x0]	; 02306F22
	ldr r1,[pool_02306F90]	; 02306F24
	add r3,r2,r1	; 02306F26
	ldrh r2,[r3,#0x0]	; 02306F28
	mov r1,#0x20	; 02306F2A
	bic r2,r1	; 02306F2C
	strh r2,[r3,#0x0]	; 02306F2E
	b loc_02306F40	; 02306F30
loc_02306F32:
	ldr r2,[r2,#0x0]	; 02306F32
	ldr r1,[pool_02306F90]	; 02306F34
	add r3,r2,r1	; 02306F36
	ldrh r2,[r3,#0x0]	; 02306F38
	mov r1,#0x20	; 02306F3A
	orr r2,r1	; 02306F3C
	strh r2,[r3,#0x0]	; 02306F3E
loc_02306F40:
	ldr r1,[pool_02306F88]	; 02306F40
	ldr r1,[r1,#0x0]	; 02306F42
	ldr r2,[pool_02306F94]	; 02306F44
	ldrh r2,[r1,r2]	; 02306F46
	cmp r2,#0x40	; 02306F48
	bne loc_02306F5E	; 02306F4A
	ldr r2,[pool_02306F98]	; 02306F4C
	ldrh r2,[r1,r2]	; 02306F4E
	cmp r2,#0x1	; 02306F50
	bne loc_02306F5E	; 02306F52
	ldr r2,[pool_02306F90]	; 02306F54
	ldrh r3,[r1,r2]	; 02306F56
	ldr r2,[pool_02306F9C]	; 02306F58
	ldr r1,[r1,r2]	; 02306F5A
	strh r3,[r1,#0x2e]	; 02306F5C
loc_02306F5E:
	cmp r0,#0x0	; 02306F5E
	bne loc_02306F6E	; 02306F60
	ldr r2,[pool_02306FA0]	; 02306F62
	ldrh r1,[r2,#0x0]	; 02306F64
	mov r0,#0x6	; 02306F66
	bic r1,r0	; 02306F68
	strh r1,[r2,#0x0]	; 02306F6A
	b loc_02306F78	; 02306F6C
loc_02306F6E:
	ldr r2,[pool_02306FA0]	; 02306F6E
	ldrh r1,[r2,#0x0]	; 02306F70
	mov r0,#0x6	; 02306F72
	orr r1,r0	; 02306F74
	strh r1,[r2,#0x0]	; 02306F76
loc_02306F78:
	bl loc_023068B4	; 02306F78
	mov r0,#0x0	; 02306F7C
loc_02306F7E:
	add sp,#0x4	; 02306F7E
	pop {r4,r5}	; 02306F80
	pop {r3}	; 02306F82
	bx r3	; 02306F84
	.byte 0xC0, 0x46	; 02306F88
pool_02306F88:
loc_02306F88:
	.word FirmwareWlWorkPointerSlot	; 02306F88
pool_02306F8C:
loc_02306F8C:
	.word 0x000002FE	; 02306F8C
pool_02306F90:
loc_02306F90:
	.word 0x00000378	; 02306F90
pool_02306F94:
loc_02306F94:
	.word 0x00000310	; 02306F94
pool_02306F98:
loc_02306F98:
	.word 0x000002F2	; 02306F98
pool_02306F9C:
loc_02306F9C:
	.word 0x00000464	; 02306F9C
pool_02306FA0:
loc_02306FA0:
	.word REG_WIFI_PREAMBLE	; 02306FA0

; ===== function loc_02306FA4 =====
loc_02306FA4:
	ldr r1,[pool_02306FC0]	; 02306FA4
	ldr r2,[r1,#0x0]	; 02306FA6
	ldr r1,[pool_02306FC4]	; 02306FA8
	add r2,r2,r1	; 02306FAA
	mov r3,#0x0	; 02306FAC
loc_02306FAE:
	ldrh r1,[r0,#0x0]	; 02306FAE
	add r0,r0,#0x2	; 02306FB0
	strh r1,[r2,#0x0]	; 02306FB2
	add r2,r2,#0x2	; 02306FB4
	add r3,r3,#0x1	; 02306FB6
	cmp r3,#0x10	; 02306FB8
	bcc loc_02306FAE	; 02306FBA
	mov r0,#0x0	; 02306FBC
	bx lr	; 02306FBE
pool_02306FC0:
loc_02306FC0:
	.word FirmwareWlWorkPointerSlot	; 02306FC0
pool_02306FC4:
loc_02306FC4:
	.word 0x0000033C	; 02306FC4

; ===== function loc_02306FC8 =====
loc_02306FC8:
	push {r4,r5,lr}	; 02306FC8
	sub sp,#0x4	; 02306FCA
	add r5,r0,#0x0	; 02306FCC
	cmp r5,#0xa	; 02306FCE
	bcs loc_02306FD6	; 02306FD0
	mov r0,#0x5	; 02306FD2
	b loc_02307036	; 02306FD4
loc_02306FD6:
	ldr r0,[pool_02307040]	; 02306FD6
	ldr r2,[r0,#0x0]	; 02306FD8
	ldr r0,[pool_02307044]	; 02306FDA
	strh r5,[r2,r0]	; 02306FDC
	cmp r1,#0x0	; 02306FDE
	beq loc_02306FE6	; 02306FE0
	ldr r0,[pool_02307048]	; 02306FE2
	strh r5,[r0,#0x0]	; 02306FE4
loc_02306FE6:
	ldr r0,[pool_02307040]	; 02306FE6
	ldr r0,[r0,#0x0]	; 02306FE8
	ldr r1,[pool_0230704C]	; 02306FEA
	ldrh r1,[r0,r1]	; 02306FEC
	cmp r1,#0x0	; 02306FEE
	beq loc_02307034	; 02306FF0
	ldr r1,[pool_02307050]	; 02306FF2
	ldr r2,[r0,r1]	; 02306FF4
	add r2,#0x24	; 02306FF6
	ldr r1,[pool_02307054]	; 02306FF8
	ldrh r1,[r0,r1]	; 02306FFA
	add r1,r2,r1	; 02306FFC
	add r4,r1,#0x6	; 02306FFE
	ldr r1,[pool_02307058]	; 02307000
	ldrh r0,[r0,r1]	; 02307002
	lsl r0,r0,#0x1f	; 02307004
	lsr r0,r0,#0x1f	; 02307006
	cmp r0,#0x1	; 02307008
	bne loc_02307024	; 0230700A
	add r0,r4,#0x0	; 0230700C
	lsl r1,r5,#0x18	; 0230700E
	lsr r1,r1,#0x18	; 02307010
	bl loc_023053D8	; 02307012
	add r0,r4,#0x1	; 02307016
	asr r1,r5,#0x8	; 02307018
	lsl r1,r1,#0x18	; 0230701A
	lsr r1,r1,#0x18	; 0230701C
	bl loc_023053D8	; 0230701E
	b loc_02307034	; 02307022
loc_02307024:
	add r0,r4,#0x0	; 02307024
	mov r1,#0xff	; 02307026
	bl loc_023053D8	; 02307028
	add r0,r4,#0x1	; 0230702C
	mov r1,#0xff	; 0230702E
	bl loc_023053D8	; 02307030
loc_02307034:
	mov r0,#0x0	; 02307034
loc_02307036:
	add sp,#0x4	; 02307036
	pop {r4,r5}	; 02307038
	pop {r3}	; 0230703A
	bx r3	; 0230703C
	.byte 0xC0, 0x46	; 02307040
pool_02307040:
loc_02307040:
	.word FirmwareWlWorkPointerSlot	; 02307040
pool_02307044:
loc_02307044:
	.word 0x00000300	; 02307044
pool_02307048:
loc_02307048:
	.word REG_WIFI_POST_BEACON	; 02307048
pool_0230704C:
loc_0230704C:
	.word 0x0000045C	; 0230704C
pool_02307050:
loc_02307050:
	.word 0x00000464	; 02307050
pool_02307054:
loc_02307054:
	.word 0x00000392	; 02307054
pool_02307058:
loc_02307058:
	.word 0x00000316	; 02307058

; ===== function loc_0230705C =====
loc_0230705C:
	push {r4,lr}	; 0230705C
	cmp r0,#0xff	; 0230705E
	bls loc_02307066	; 02307060
	mov r0,#0x5	; 02307062
	b loc_02307078	; 02307064
loc_02307066:
	mov r4,#0x0	; 02307066
	ldr r3,[pool_02307080]	; 02307068
	ldr r2,[r3,#0x0]	; 0230706A
	ldr r1,[pool_02307084]	; 0230706C
	strh r4,[r2,r1]	; 0230706E
	ldr r2,[r3,#0x0]	; 02307070
	ldr r1,[pool_02307088]	; 02307072
	strh r0,[r2,r1]	; 02307074
	add r0,r4,#0x0	; 02307076
loc_02307078:
	pop {r4}	; 02307078
	pop {r3}	; 0230707A
	bx r3	; 0230707C
	.byte 0xC0, 0x46	; 02307080
pool_02307080:
loc_02307080:
	.word FirmwareWlWorkPointerSlot	; 02307080
pool_02307084:
loc_02307084:
	.word 0x0000037C	; 02307084
pool_02307088:
loc_02307088:
	.word 0x0000037A	; 02307088

; ===== function loc_0230708C =====
loc_0230708C:
	cmp r0,#0x1	; 0230708C
	bls loc_02307094	; 0230708E
	mov r0,#0x5	; 02307090
	bx lr	; 02307092
loc_02307094:
	ldr r1,[pool_023070B0]	; 02307094
	ldr r2,[r1,#0x0]	; 02307096
	ldr r1,[pool_023070B4]	; 02307098
	add r3,r2,r1	; 0230709A
	ldrh r2,[r3,#0x0]	; 0230709C
	mov r1,#0x2	; 0230709E
	bic r2,r1	; 023070A0
	mov r1,#0x1	; 023070A2
	and r0,r1	; 023070A4
	lsl r0,r0,#0x1	; 023070A6
	orr r2,r0	; 023070A8
	strh r2,[r3,#0x0]	; 023070AA
	mov r0,#0x0	; 023070AC
	bx lr	; 023070AE
pool_023070B0:
loc_023070B0:
	.word FirmwareWlWorkPointerSlot	; 023070B0
pool_023070B4:
loc_023070B4:
	.word 0x000002FE	; 023070B4

; ===== function loc_023070B8 =====
loc_023070B8:
	cmp r0,#0x1	; 023070B8
	bls loc_023070C0	; 023070BA
	mov r0,#0x5	; 023070BC
	bx lr	; 023070BE
loc_023070C0:
	ldr r1,[pool_023070D8]	; 023070C0
	ldr r2,[r1,#0x0]	; 023070C2
	ldr r1,[pool_023070DC]	; 023070C4
	add r3,r2,r1	; 023070C6
	ldrh r2,[r3,#0x0]	; 023070C8
	mov r1,#0x1	; 023070CA
	bic r2,r1	; 023070CC
	and r0,r1	; 023070CE
	orr r2,r0	; 023070D0
	strh r2,[r3,#0x0]	; 023070D2
	mov r0,#0x0	; 023070D4
	bx lr	; 023070D6
pool_023070D8:
loc_023070D8:
	.word FirmwareWlWorkPointerSlot	; 023070D8
pool_023070DC:
loc_023070DC:
	.word 0x000002FE	; 023070DC

; ===== function loc_023070E0 =====
loc_023070E0:
	push {r4,lr}	; 023070E0
	add r4,r0,#0x0	; 023070E2
	ldr r0,[pool_0230711C]	; 023070E4
	add r1,r4,#0x0	; 023070E6
	mov r2,#0x14	; 023070E8
	bl loc_02305458	; 023070EA
	ldr r0,[pool_02307120]	; 023070EE
	add r1,r4,#0x0	; 023070F0
	add r1,#0x14	; 023070F2
	mov r2,#0x14	; 023070F4
	bl loc_02305458	; 023070F6
	ldr r0,[pool_02307124]	; 023070FA
	add r1,r4,#0x0	; 023070FC
	add r1,#0x28	; 023070FE
	mov r2,#0x14	; 02307100
	bl loc_02305458	; 02307102
	ldr r0,[pool_02307128]	; 02307106
	add r4,#0x3c	; 02307108
	add r1,r4,#0x0	; 0230710A
	mov r2,#0x14	; 0230710C
	bl loc_02305458	; 0230710E
	mov r0,#0x0	; 02307112
	pop {r4}	; 02307114
	pop {r3}	; 02307116
	bx r3	; 02307118
	.byte 0xC0, 0x46	; 0230711C
pool_0230711C:
loc_0230711C:
	.word 0x04805F80	; 0230711C
pool_02307120:
loc_02307120:
	.word 0x04805FA0	; 02307120
pool_02307124:
loc_02307124:
	.word 0x04805FC0	; 02307124
pool_02307128:
loc_02307128:
	.word 0x04805FE0	; 02307128

; ===== function loc_0230712C =====
loc_0230712C:
	cmp r0,#0x3	; 0230712C
	bls loc_02307134	; 0230712E
	mov r0,#0x5	; 02307130
	bx lr	; 02307132
loc_02307134:
	ldr r1,[pool_02307140]	; 02307134
	ldr r2,[r1,#0x0]	; 02307136
	ldr r1,[pool_02307144]	; 02307138
	strh r0,[r2,r1]	; 0230713A
	mov r0,#0x0	; 0230713C
	bx lr	; 0230713E
pool_02307140:
loc_02307140:
	.word FirmwareWlWorkPointerSlot	; 02307140
pool_02307144:
loc_02307144:
	.word 0x000002FA	; 02307144

; ===== function loc_02307148 =====
loc_02307148:
	push {r4,lr}	; 02307148
	cmp r0,#0x3	; 0230714A
	bls loc_02307152	; 0230714C
	mov r0,#0x5	; 0230714E
	b loc_023071CC	; 02307150
loc_02307152:
	ldr r1,[pool_023071D4]	; 02307152
	ldr r3,[r1,#0x0]	; 02307154
	ldr r2,[pool_023071D8]	; 02307156
	strh r0,[r3,r2]	; 02307158
	cmp r0,#0x0	; 0230715A
	bne loc_0230717C	; 0230715C
	ldr r3,[r1,#0x0]	; 0230715E
	ldr r2,[pool_023071DC]	; 02307160
	add r4,r3,r2	; 02307162
	ldrh r3,[r4,#0x0]	; 02307164
	mov r2,#0x10	; 02307166
	bic r3,r2	; 02307168
	strh r3,[r4,#0x0]	; 0230716A
	ldr r2,[r1,#0x0]	; 0230716C
	ldr r1,[pool_023071E0]	; 0230716E
	add r3,r2,r1	; 02307170
	ldrh r2,[r3,#0x0]	; 02307172
	ldr r1,[pool_023071E4]	; 02307174
	and r2,r1	; 02307176
	strh r2,[r3,#0x0]	; 02307178
	b loc_02307198	; 0230717A
loc_0230717C:
	ldr r3,[r1,#0x0]	; 0230717C
	ldr r2,[pool_023071DC]	; 0230717E
	add r4,r3,r2	; 02307180
	ldrh r3,[r4,#0x0]	; 02307182
	mov r2,#0x10	; 02307184
	orr r3,r2	; 02307186
	strh r3,[r4,#0x0]	; 02307188
	ldr r2,[r1,#0x0]	; 0230718A
	ldr r1,[pool_023071E0]	; 0230718C
	add r3,r2,r1	; 0230718E
	ldrh r2,[r3,#0x0]	; 02307190
	ldr r1,[pool_023071E8]	; 02307192
	orr r2,r1	; 02307194
	strh r2,[r3,#0x0]	; 02307196
loc_02307198:
	ldr r1,[pool_023071D4]	; 02307198
	ldr r1,[r1,#0x0]	; 0230719A
	ldr r2,[pool_023071EC]	; 0230719C
	ldrh r2,[r1,r2]	; 0230719E
	cmp r2,#0x40	; 023071A0
	bne loc_023071B6	; 023071A2
	ldr r2,[pool_023071F0]	; 023071A4
	ldrh r2,[r1,r2]	; 023071A6
	cmp r2,#0x1	; 023071A8
	bne loc_023071B6	; 023071AA
	ldr r2,[pool_023071DC]	; 023071AC
	ldrh r3,[r1,r2]	; 023071AE
	ldr r2,[pool_023071F4]	; 023071B0
	ldr r1,[r1,r2]	; 023071B2
	strh r3,[r1,#0x2e]	; 023071B4
loc_023071B6:
	cmp r0,#0x0	; 023071B6
	bne loc_023071BC	; 023071B8
	mov r0,#0x1	; 023071BA
loc_023071BC:
	ldr r2,[pool_023071F8]	; 023071BC
	ldrh r3,[r2,#0x0]	; 023071BE
	ldr r1,[pool_023071FC]	; 023071C0
	and r3,r1	; 023071C2
	lsl r0,r0,#0x3	; 023071C4
	orr r3,r0	; 023071C6
	strh r3,[r2,#0x0]	; 023071C8
	mov r0,#0x0	; 023071CA
loc_023071CC:
	pop {r4}	; 023071CC
	pop {r3}	; 023071CE
	bx r3	; 023071D0
	.byte 0xC0, 0x46	; 023071D4
pool_023071D4:
loc_023071D4:
	.word FirmwareWlWorkPointerSlot	; 023071D4
pool_023071D8:
loc_023071D8:
	.word 0x000002F8	; 023071D8
pool_023071DC:
loc_023071DC:
	.word 0x00000378	; 023071DC
pool_023071E0:
loc_023071E0:
	.word 0x00000386	; 023071E0
pool_023071E4:
loc_023071E4:
	.word 0xFFFFBFFF	; 023071E4
pool_023071E8:
loc_023071E8:
	.word 0x00004000	; 023071E8
pool_023071EC:
loc_023071EC:
	.word 0x00000310	; 023071EC
pool_023071F0:
loc_023071F0:
	.word 0x000002F2	; 023071F0
pool_023071F4:
loc_023071F4:
	.word 0x00000464	; 023071F4
pool_023071F8:
loc_023071F8:
	.word REG_WIFI_MODE_WEP	; 023071F8
pool_023071FC:
loc_023071FC:
	.word 0x0000FFC7	; 023071FC

; ===== function loc_02307200 =====
loc_02307200:
	push {lr}	; 02307200
	sub sp,#0x4	; 02307202
	cmp r0,#0x2	; 02307204
	bhi loc_02307218	; 02307206
	ldr r1,[pool_02307220]	; 02307208
	ldr r2,[r1,#0x0]	; 0230720A
	ldr r1,[pool_02307224]	; 0230720C
	strh r0,[r2,r1]	; 0230720E
	bl loc_023068B4	; 02307210
	mov r0,#0x0	; 02307214
	b loc_0230721A	; 02307216
loc_02307218:
	mov r0,#0x5	; 02307218
loc_0230721A:
	add sp,#0x4	; 0230721A
	pop {r3}	; 0230721C
	bx r3	; 0230721E
pool_02307220:
loc_02307220:
	.word FirmwareWlWorkPointerSlot	; 02307220
pool_02307224:
loc_02307224:
	.word 0x000002F4	; 02307224

; ===== function loc_02307228 =====
loc_02307228:
	push {r4,lr}	; 02307228
	cmp r0,#0x3	; 0230722A
	bls loc_02307232	; 0230722C
	mov r0,#0x5	; 0230722E
	b loc_0230726C	; 02307230
loc_02307232:
	ldr r1,[pool_02307274]	; 02307232
	ldr r3,[r1,#0x0]	; 02307234
	ldr r2,[pool_02307278]	; 02307236
	strh r0,[r3,r2]	; 02307238
	ldr r3,[r1,#0x0]	; 0230723A
	ldr r2,[pool_0230727C]	; 0230723C
	strh r0,[r3,r2]	; 0230723E
	ldr r3,[pool_02307280]	; 02307240
	ldrh r4,[r3,#0x0]	; 02307242
	ldr r2,[pool_02307284]	; 02307244
	and r4,r2	; 02307246
	orr r4,r0	; 02307248
	strh r4,[r3,#0x0]	; 0230724A
	ldr r1,[r1,#0x0]	; 0230724C
	ldr r0,[pool_02307288]	; 0230724E
	ldrh r0,[r1,r0]	; 02307250
	lsl r0,r0,#0x1f	; 02307252
	lsr r0,r0,#0x1f	; 02307254
	bl loc_02306848	; 02307256
	ldr r0,[pool_02307274]	; 0230725A
	ldr r1,[r0,#0x0]	; 0230725C
	ldr r0,[pool_0230728C]	; 0230725E
	add r2,r1,r0	; 02307260
	ldr r1,[r2,#0x0]	; 02307262
	mov r0,#0x8	; 02307264
	orr r1,r0	; 02307266
	str r1,[r2,#0x0]	; 02307268
	mov r0,#0x0	; 0230726A
loc_0230726C:
	pop {r4}	; 0230726C
	pop {r3}	; 0230726E
	bx r3	; 02307270
	.byte 0xC0, 0x46	; 02307274
pool_02307274:
loc_02307274:
	.word FirmwareWlWorkPointerSlot	; 02307274
pool_02307278:
loc_02307278:
	.word 0x000002F2	; 02307278
pool_0230727C:
loc_0230727C:
	.word 0x00000314	; 0230727C
pool_02307280:
loc_02307280:
	.word REG_WIFI_MODE_WEP	; 02307280
pool_02307284:
loc_02307284:
	.word 0x0000FFF8	; 02307284
pool_02307288:
loc_02307288:
	.word 0x00000316	; 02307288
pool_0230728C:
loc_0230728C:
	.word 0x00000304	; 0230728C

; ===== function loc_02307290 =====
loc_02307290:
	ldr r1,[pool_023072B8]	; 02307290
	add r2,r0,#0x0	; 02307292
	and r2,r1	; 02307294
	cmp r2,#0x0	; 02307296
	bne loc_0230729E	; 02307298
	mov r0,#0x5	; 0230729A
	bx lr	; 0230729C
loc_0230729E:
	ldr r3,[pool_023072BC]	; 0230729E
	ldr r2,[r3,#0x0]	; 023072A0
	ldr r1,[pool_023072C0]	; 023072A2
	strh r0,[r2,r1]	; 023072A4
	ldr r1,[r3,#0x0]	; 023072A6
	ldr r0,[pool_023072C4]	; 023072A8
	add r2,r1,r0	; 023072AA
	ldr r1,[r2,#0x0]	; 023072AC
	mov r0,#0x4	; 023072AE
	orr r1,r0	; 023072B0
	str r1,[r2,#0x0]	; 023072B2
	mov r0,#0x0	; 023072B4
	bx lr	; 023072B6
pool_023072B8:
loc_023072B8:
	.word 0x00007FFE	; 023072B8
pool_023072BC:
loc_023072BC:
	.word FirmwareWlWorkPointerSlot	; 023072BC
pool_023072C0:
loc_023072C0:
	.word 0x000002F0	; 023072C0
pool_023072C4:
loc_023072C4:
	.word 0x00000304	; 023072C4

; ===== function loc_023072C8 =====
loc_023072C8:
	cmp r0,#0xff	; 023072C8
	bls loc_023072D0	; 023072CA
	mov r0,#0x5	; 023072CC
	bx lr	; 023072CE
loc_023072D0:
	ldr r1,[pool_023072E0]	; 023072D0
	ldr r2,[r1,#0x0]	; 023072D2
	ldr r1,[pool_023072E4]	; 023072D4
	strh r0,[r2,r1]	; 023072D6
	ldr r1,[pool_023072E8]	; 023072D8
	strh r0,[r1,#0x0]	; 023072DA
	mov r0,#0x0	; 023072DC
	bx lr	; 023072DE
pool_023072E0:
loc_023072E0:
	.word FirmwareWlWorkPointerSlot	; 023072E0
pool_023072E4:
loc_023072E4:
	.word 0x000002EE	; 023072E4
pool_023072E8:
loc_023072E8:
	.word REG_WIFI_TX_RETRYLIMIT	; 023072E8

; ===== function loc_023072EC =====
loc_023072EC:
	push {r4,lr}	; 023072EC
	add r4,r0,#0x0	; 023072EE
	ldrh r1,[r4,#0x0]	; 023072F0
	mov r0,#0x1	; 023072F2
	and r1,r0	; 023072F4
	cmp r1,#0x0	; 023072F6
	beq loc_023072FE	; 023072F8
	mov r0,#0x5	; 023072FA
	b loc_02307326	; 023072FC
loc_023072FE:
	ldr r0,[pool_0230732C]	; 023072FE
	ldr r1,[r0,#0x0]	; 02307300
	ldr r0,[pool_02307330]	; 02307302
	add r0,r1,r0	; 02307304
	add r1,r4,#0x0	; 02307306
	bl loc_02306458	; 02307308
	ldr r0,[pool_02307334]	; 0230730C
	add r1,r4,#0x0	; 0230730E
	bl loc_02306458	; 02307310
	ldr r0,[pool_0230732C]	; 02307314
	ldr r1,[r0,#0x0]	; 02307316
	ldr r0,[pool_02307338]	; 02307318
	add r2,r1,r0	; 0230731A
	ldr r1,[r2,#0x0]	; 0230731C
	mov r0,#0x2	; 0230731E
	orr r1,r0	; 02307320
	str r1,[r2,#0x0]	; 02307322
	mov r0,#0x0	; 02307324
loc_02307326:
	pop {r4}	; 02307326
	pop {r3}	; 02307328
	bx r3	; 0230732A
pool_0230732C:
loc_0230732C:
	.word FirmwareWlWorkPointerSlot	; 0230732C
pool_02307330:
loc_02307330:
	.word 0x000002E8	; 02307330
pool_02307334:
loc_02307334:
	.word 0x04808018	; 02307334
pool_02307338:
loc_02307338:
	.word 0x00000304	; 02307338

; ===== function loc_0230733C =====
loc_0230733C:
	push {r4,r5,r6,lr}	; 0230733C
	sub sp,#0x8	; 0230733E
	add r5,r0,#0x0	; 02307340
	add r6,r1,#0x0	; 02307342
	ldr r0,[pool_0230739C]	; 02307344
	ldr r1,[r0,#0x0]	; 02307346
	ldr r0,[pool_023073A0]	; 02307348
	ldr r4,[r1,r0]	; 0230734A
	mov r2,#0x0	; 0230734C
	add r0,sp,#0x0	; 0230734E
	strh r2,[r0,#0x0]	; 02307350
	ldrh r0,[r0,#0x0]	; 02307352
	ldr r2,[pool_023073A4]	; 02307354
	add r1,r1,r2	; 02307356
	mov r2,#0x28	; 02307358
	bl loc_023073B4	; 0230735A
	mov r1,#0x0	; 0230735E
	add r0,sp,#0x0	; 02307360
	strh r1,[r0,#0x2]	; 02307362
	ldrh r0,[r0,#0x2]	; 02307364
	ldr r1,[pool_0230739C]	; 02307366
	ldr r2,[r1,#0x0]	; 02307368
	ldr r1,[pool_023073A8]	; 0230736A
	add r1,r2,r1	; 0230736C
	mov r2,#0xb4	; 0230736E
	bl loc_023073C0	; 02307370
	ldr r0,[pool_0230739C]	; 02307374
	ldr r2,[r0,#0x0]	; 02307376
	ldr r1,[pool_023073A4]	; 02307378
	str r5,[r2,r1]	; 0230737A
	lsl r1,r6,#0x10	; 0230737C
	lsr r3,r1,#0x10	; 0230737E
	ldr r2,[r0,#0x0]	; 02307380
	ldr r1,[pool_023073AC]	; 02307382
	strh r3,[r2,r1]	; 02307384
	ldr r2,[r0,#0x0]	; 02307386
	ldr r1,[pool_023073B0]	; 02307388
	strh r3,[r2,r1]	; 0230738A
	ldr r1,[r0,#0x0]	; 0230738C
	ldr r0,[pool_023073A0]	; 0230738E
	str r4,[r1,r0]	; 02307390
	add sp,#0x8	; 02307392
	pop {r4,r5,r6}	; 02307394
	pop {r3}	; 02307396
	bx r3	; 02307398
	.byte 0xC0, 0x46	; 0230739C
pool_0230739C:
loc_0230739C:
	.word FirmwareWlWorkPointerSlot	; 0230739C
pool_023073A0:
loc_023073A0:
	.word 0x00000398	; 023073A0
pool_023073A4:
loc_023073A4:
	.word 0x000002E0	; 023073A4
pool_023073A8:
loc_023073A8:
	.word 0x00000308	; 023073A8
pool_023073AC:
loc_023073AC:
	.word 0x000002E4	; 023073AC
pool_023073B0:
loc_023073B0:
	.word 0x000002E6	; 023073B0

; ===== function loc_023073B4 =====
loc_023073B4:
	bx pc	; 023073B4
	.byte 0xC0, 0x46	; 023073B8
.arm

; ===== function loc_023073B8 =====
loc_023073B8:
	ldr pc,[pool_023073BC]	; 023073B8
pool_023073BC:
loc_023073BC:
	.word loc_037FCE04	; 023073BC
.thumb

; ===== function loc_023073C0 =====
loc_023073C0:
	bx pc	; 023073C0
	.byte 0xC0, 0x46	; 023073C4
.arm

; ===== function loc_023073C4 =====
loc_023073C4:
	ldr pc,[pool_023073C8]	; 023073C4
pool_023073C8:
loc_023073C8:
	.word loc_037FCE04	; 023073C8
.thumb

; ===== function loc_023073CC =====
loc_023073CC:
	push {r4,r5,r6,r7,lr}	; 023073CC
	sub sp,#0x4	; 023073CE
	mov r7,#0x0	; 023073D0
	ldr r0,[pool_02307454]	; 023073D2
	ldr r1,[r0,#0x0]	; 023073D4
	ldr r0,[pool_02307458]	; 023073D6
	ldrh r0,[r1,r0]	; 023073D8
	cmp r0,#0x5	; 023073DA
	bne loc_023073E4	; 023073DC
	ldr r0,[pool_0230745C]	; 023073DE
	str r0,[sp,#0x0]	; 023073E0
	b loc_023073E8	; 023073E2
loc_023073E4:
	ldr r0,[pool_02307460]	; 023073E4
	str r0,[sp,#0x0]	; 023073E6
loc_023073E8:
	mov r4,#0xff	; 023073E8
	mov r5,#0x0	; 023073EA
loc_023073EC:
	add r0,r5,#0x0	; 023073EC
	add r1,r4,#0x0	; 023073EE
	bl loc_02305A98	; 023073F0
	add r5,r5,#0x1	; 023073F4
	sub r0,r4,#0x1	; 023073F6
	lsl r0,r0,#0x10	; 023073F8
	lsr r4,r0,#0x10	; 023073FA
	cmp r5,#0x69	; 023073FC
	bcc loc_023073EC	; 023073FE
	mov r5,#0xff	; 02307400
	mov r4,#0x0	; 02307402
	add r6,r4,#0x0	; 02307404
	b loc_02307434	; 02307406
loc_02307408:
	lsl r1,r6,#0x1	; 02307408
	ldr r0,[sp,#0x0]	; 0230740A
	ldrh r0,[r0,r1]	; 0230740C
	cmp r4,r0	; 0230740E
	bne loc_02307416	; 02307410
	add r6,r6,#0x1	; 02307412
	b loc_0230742C	; 02307414
loc_02307416:
	add r0,r4,#0x0	; 02307416
	bl loc_02305B04	; 02307418
	lsl r0,r0,#0x10	; 0230741C
	lsr r0,r0,#0x10	; 0230741E
	cmp r0,r5	; 02307420
	beq loc_0230742C	; 02307422
	add r0,r7,#0x0	; 02307424
	add r7,r7,#0x1	; 02307426
	cmp r0,#0x20	; 02307428
	bhi loc_02307438	; 0230742A
loc_0230742C:
	add r4,r4,#0x1	; 0230742C
	sub r0,r5,#0x1	; 0230742E
	lsl r0,r0,#0x10	; 02307430
	lsr r5,r0,#0x10	; 02307432
loc_02307434:
	cmp r4,#0x69	; 02307434
	bcc loc_02307408	; 02307436
loc_02307438:
	cmp r7,#0x0	; 02307438
	beq loc_0230744C	; 0230743A
	ldr r0,[pool_02307454]	; 0230743C
	ldr r1,[r0,#0x0]	; 0230743E
	ldr r0,[pool_02307464]	; 02307440
	add r2,r1,r0	; 02307442
	ldrh r1,[r2,#0x0]	; 02307444
	mov r0,#0x8	; 02307446
	orr r1,r0	; 02307448
	strh r1,[r2,#0x0]	; 0230744A
loc_0230744C:
	add sp,#0x4	; 0230744C
	pop {r4,r5,r6,r7}	; 0230744E
	pop {r3}	; 02307450
	bx r3	; 02307452
pool_02307454:
loc_02307454:
	.word FirmwareWlWorkPointerSlot	; 02307454
pool_02307458:
loc_02307458:
	.word 0x000005B0	; 02307458
pool_0230745C:
loc_0230745C:
	.word 0x023105C4	; 0230745C
pool_02307460:
loc_02307460:
	.word 0x023105F8	; 02307460
pool_02307464:
loc_02307464:
	.word 0x00000302	; 02307464

; ===== function loc_02307468 =====
loc_02307468:
	push {r4,r5,r6,r7,lr}	; 02307468
	sub sp,#0xc	; 0230746A
	str r0,[sp,#0x0]	; 0230746C
	add r5,r1,#0x0	; 0230746E
	mov r7,#0x0	; 02307470
	ldr r0,[pool_02307574]	; 02307472
	cmp r5,r0	; 02307474
	bcc loc_0230747A	; 02307476
	add r5,r0,#0x0	; 02307478
loc_0230747A:
	ldr r1,[pool_02307578]	; 0230747A
	ldr r0,[pool_0230757C]	; 0230747C
	strh r1,[r0,#0x0]	; 0230747E
	ldr r1,[pool_02307580]	; 02307480
	ldr r0,[pool_02307584]	; 02307482
	strh r1,[r0,#0x0]	; 02307484
	ldr r1,[pool_02307588]	; 02307486
	ldr r0,[pool_0230758C]	; 02307488
	strh r1,[r0,#0x0]	; 0230748A
	ldr r0,[sp,#0x0]	; 0230748C
	mov r2,#0x0	; 0230748E
	add r1,r2,#0x0	; 02307490
	b loc_023074A2	; 02307492
loc_02307494:
	add r3,r2,#0x0	; 02307494
	sub r2,r2,#0x1	; 02307496
	lsl r2,r2,#0x10	; 02307498
	lsr r2,r2,#0x10	; 0230749A
	strh r3,[r0,#0x0]	; 0230749C
	add r0,r0,#0x2	; 0230749E
	add r1,r1,#0x2	; 023074A0
loc_023074A2:
	cmp r1,r5	; 023074A2
	bcc loc_02307494	; 023074A4
	add r6,r5,#0x0	; 023074A6
	ldr r4,[pool_02307590]	; 023074A8
	b loc_023074E6	; 023074AA
loc_023074AC:
	add r1,r4,r5	; 023074AC
	ldr r0,[pool_02307594]	; 023074AE
	cmp r1,r0	; 023074B0
	bls loc_023074B6	; 023074B2
	sub r6,r0,r4	; 023074B4
loc_023074B6:
	add r0,r4,#0x0	; 023074B6
	ldr r1,[sp,#0x0]	; 023074B8
	add r2,r6,#0x0	; 023074BA
	bl loc_02305458	; 023074BC
	add r3,r4,#0x0	; 023074C0
	mov r2,#0x0	; 023074C2
	lsl r1,r2,#0	; 023074C4
	b loc_023074E0	; 023074C6
loc_023074C8:
	ldrh r0,[r3,#0x0]	; 023074C8
	cmp r2,r0	; 023074CA
	beq loc_023074D6	; 023074CC
	add r0,r7,#0x0	; 023074CE
	add r7,r7,#0x1	; 023074D0
	cmp r0,#0x20	; 023074D2
	bhi loc_02307556	; 023074D4
loc_023074D6:
	add r1,r1,#0x2	; 023074D6
	add r3,r3,#0x2	; 023074D8
	sub r0,r2,#0x1	; 023074DA
	lsl r0,r0,#0x10	; 023074DC
	lsr r2,r0,#0x10	; 023074DE
loc_023074E0:
	cmp r1,r6	; 023074E0
	bcc loc_023074C8	; 023074E2
	add r4,r4,r6	; 023074E4
loc_023074E6:
	ldr r0,[pool_02307594]	; 023074E6
	cmp r4,r0	; 023074E8
	bcc loc_023074AC	; 023074EA
	ldr r1,[pool_02307590]	; 023074EC
	mov r3,#0x0	; 023074EE
	add r0,r3,#0x0	; 023074F0
	ldr r4,[pool_02307574]	; 023074F2
loc_023074F4:
	add r2,r3,#0x0	; 023074F4
	sub r3,r3,#0x1	; 023074F6
	lsl r3,r3,#0x10	; 023074F8
	lsr r3,r3,#0x10	; 023074FA
	strh r2,[r1,#0x0]	; 023074FC
	add r1,r1,#0x2	; 023074FE
	add r0,r0,#0x2	; 02307500
	cmp r0,r4	; 02307502
	bcc loc_023074F4	; 02307504
	add r6,r5,#0x0	; 02307506
	mov r0,#0x0	; 02307508
	str r0,[sp,#0x4]	; 0230750A
	ldr r4,[pool_02307590]	; 0230750C
	str r0,[sp,#0x8]	; 0230750E
	b loc_02307550	; 02307510
loc_02307512:
	add r1,r4,r5	; 02307512
	ldr r0,[pool_02307594]	; 02307514
	cmp r1,r0	; 02307516
	bls loc_0230751C	; 02307518
	sub r6,r0,r4	; 0230751A
loc_0230751C:
	ldr r0,[sp,#0x0]	; 0230751C
	add r1,r4,#0x0	; 0230751E
	add r2,r6,#0x0	; 02307520
	bl loc_023054E8	; 02307522
	ldr r2,[sp,#0x0]	; 02307526
	ldr r3,[sp,#0x8]	; 02307528
	b loc_0230754A	; 0230752A
loc_0230752C:
	ldrh r1,[r2,#0x0]	; 0230752C
	ldr r0,[sp,#0x4]	; 0230752E
	cmp r1,r0	; 02307530
	beq loc_0230753C	; 02307532
	add r0,r7,#0x0	; 02307534
	add r7,r7,#0x1	; 02307536
	cmp r0,#0x20	; 02307538
	bhi loc_02307556	; 0230753A
loc_0230753C:
	add r3,r3,#0x2	; 0230753C
	ldr r0,[sp,#0x4]	; 0230753E
	sub r0,r0,#0x1	; 02307540
	lsl r0,r0,#0x10	; 02307542
	lsr r0,r0,#0x10	; 02307544
	str r0,[sp,#0x4]	; 02307546
	add r2,r2,#0x2	; 02307548
loc_0230754A:
	cmp r3,r6	; 0230754A
	bcc loc_0230752C	; 0230754C
	add r4,r4,r6	; 0230754E
loc_02307550:
	ldr r0,[pool_02307594]	; 02307550
	cmp r4,r0	; 02307552
	bcc loc_02307512	; 02307554
loc_02307556:
	cmp r7,#0x0	; 02307556
	beq loc_0230756A	; 02307558
	ldr r0,[pool_02307598]	; 0230755A
	ldr r1,[r0,#0x0]	; 0230755C
	ldr r0,[pool_0230759C]	; 0230755E
	add r2,r1,r0	; 02307560
	ldrh r1,[r2,#0x0]	; 02307562
	mov r0,#0x4	; 02307564
	orr r1,r0	; 02307566
	strh r1,[r2,#0x0]	; 02307568
loc_0230756A:
	add r0,r7,#0x0	; 0230756A
	add sp,#0xc	; 0230756C
	pop {r4,r5,r6,r7}	; 0230756E
	pop {r3}	; 02307570
	bx r3	; 02307572
pool_02307574:
loc_02307574:
	.word 0x00002000	; 02307574
pool_02307578:
loc_02307578:
	.word 0x00004000	; 02307578
pool_0230757C:
loc_0230757C:
	.word REG_WIFI_RXBUF_BEGIN	; 0230757C
pool_02307580:
loc_02307580:
	.word 0x00006000	; 02307580
pool_02307584:
loc_02307584:
	.word REG_WIFI_RXBUF_END	; 02307584
pool_02307588:
loc_02307588:
	.word 0x00005000	; 02307588
pool_0230758C:
loc_0230758C:
	.word REG_WIFI_RXBUF_GAP	; 0230758C
pool_02307590:
loc_02307590:
	.word WifiRamBase	; 02307590
pool_02307594:
loc_02307594:
	.word 0x04806000	; 02307594
pool_02307598:
loc_02307598:
	.word FirmwareWlWorkPointerSlot	; 02307598
pool_0230759C:
loc_0230759C:
	.word 0x00000302	; 0230759C

; ===== function loc_023075A0 =====
loc_023075A0:
	push {r4,lr}	; 023075A0
	ldr r0,[pool_023075E8]	; 023075A2
	ldr r1,[r0,#0x0]	; 023075A4
	ldr r0,[pool_023075EC]	; 023075A6
	add r0,r1,r0	; 023075A8
	ldr r1,[pool_023075F0]	; 023075AA
	bl loc_02305050	; 023075AC
	add r4,r0,#0x0	; 023075B0
	cmp r4,#0x0	; 023075B2
	beq loc_023075E0	; 023075B4
	add r0,#0x10	; 023075B6
	mov r1,#0xf6	; 023075B8
	bl loc_02307468	; 023075BA
	cmp r0,#0x0	; 023075BE
	beq loc_023075D2	; 023075C0
	ldr r0,[pool_023075E8]	; 023075C2
	ldr r1,[r0,#0x0]	; 023075C4
	ldr r0,[pool_023075EC]	; 023075C6
	add r0,r1,r0	; 023075C8
	add r1,r4,#0x0	; 023075CA
	bl loc_02304FF8	; 023075CC
	b loc_023075E0	; 023075D0
loc_023075D2:
	ldr r0,[pool_023075E8]	; 023075D2
	ldr r1,[r0,#0x0]	; 023075D4
	ldr r0,[pool_023075EC]	; 023075D6
	add r0,r1,r0	; 023075D8
	add r1,r4,#0x0	; 023075DA
	bl loc_02304FF8	; 023075DC
loc_023075E0:
	pop {r4}	; 023075E0
	pop {r3}	; 023075E2
	bx r3	; 023075E4
	.byte 0xC0, 0x46	; 023075E8
pool_023075E8:
loc_023075E8:
	.word FirmwareWlWorkPointerSlot	; 023075E8
pool_023075EC:
loc_023075EC:
	.word 0x0000014C	; 023075EC
pool_023075F0:
loc_023075F0:
	.word 0x00000106	; 023075F0

; ===== function loc_023075F4 =====
loc_023075F4:
	push {r4,r5,lr}	; 023075F4
	sub sp,#0x4	; 023075F6
	mov r0,#0x0	; 023075F8
	ldr r4,[pool_02307658]	; 023075FA
	ldr r1,[pool_0230765C]	; 023075FC
	add r5,r0,#0x0	; 023075FE
	ldr r2,[pool_02307660]	; 02307600
loc_02307602:
	add r3,r1,#0x0	; 02307602
	sub r1,r1,#0x1	; 02307604
	lsl r1,r1,#0x10	; 02307606
	lsr r1,r1,#0x10	; 02307608
	strh r3,[r4,#0x0]	; 0230760A
	add r4,r4,#0x2	; 0230760C
	add r5,r5,#0x2	; 0230760E
	cmp r5,r2	; 02307610
	bcc loc_02307602	; 02307612
	ldr r5,[pool_02307658]	; 02307614
	ldr r4,[pool_0230765C]	; 02307616
	mov r3,#0x0	; 02307618
	ldr r1,[pool_02307660]	; 0230761A
	b loc_02307636	; 0230761C
loc_0230761E:
	ldrh r2,[r5,#0x0]	; 0230761E
	cmp r2,r4	; 02307620
	beq loc_0230762C	; 02307622
	add r2,r0,#0x0	; 02307624
	add r0,r0,#0x1	; 02307626
	cmp r2,#0x20	; 02307628
	bhi loc_0230763A	; 0230762A
loc_0230762C:
	add r3,r3,#0x2	; 0230762C
	add r5,r5,#0x2	; 0230762E
	sub r2,r4,#0x1	; 02307630
	lsl r2,r2,#0x10	; 02307632
	lsr r4,r2,#0x10	; 02307634
loc_02307636:
	cmp r3,r1	; 02307636
	bcc loc_0230761E	; 02307638
loc_0230763A:
	cmp r0,#0x0	; 0230763A
	beq loc_0230764E	; 0230763C
	ldr r0,[pool_02307664]	; 0230763E
	ldr r1,[r0,#0x0]	; 02307640
	ldr r0,[pool_02307668]	; 02307642
	add r2,r1,r0	; 02307644
	ldrh r1,[r2,#0x0]	; 02307646
	mov r0,#0x2	; 02307648
	orr r1,r0	; 0230764A
	strh r1,[r2,#0x0]	; 0230764C
loc_0230764E:
	add sp,#0x4	; 0230764E
	pop {r4,r5}	; 02307650
	pop {r3}	; 02307652
	bx r3	; 02307654
	.byte 0xC0, 0x46	; 02307658
pool_02307658:
loc_02307658:
	.word WifiRamBase	; 02307658
pool_0230765C:
loc_0230765C:
	.word 0x0000FFFF	; 0230765C
pool_02307660:
loc_02307660:
	.word 0x00002000	; 02307660
pool_02307664:
loc_02307664:
	.word FirmwareWlWorkPointerSlot	; 02307664
pool_02307668:
loc_02307668:
	.word 0x00000302	; 02307668

; ===== function loc_0230766C =====
loc_0230766C:
	push {r4,r5,r6,r7,lr}	; 0230766C
	sub sp,#0x4	; 0230766E
	mov r0,#0x0	; 02307670
	add r3,r0,#0x0	; 02307672
	ldr r4,[pool_0230770C]	; 02307674
	ldr r2,[pool_02307710]	; 02307676
	add r6,r4,#0x0	; 02307678
loc_0230767A:
	lsl r7,r3,#0x2	; 0230767A
	add r1,r2,r7	; 0230767C
	ldrh r5,[r1,#0x2]	; 0230767E
	add r1,r4,#0x0	; 02307680
	and r1,r5	; 02307682
	ldrh r7,[r2,r7]	; 02307684
	ldr r5,[pool_02307714]	; 02307686
	strh r1,[r7,r5]	; 02307688
	add r1,r4,r6	; 0230768A
	lsl r1,r1,#0x10	; 0230768C
	lsr r4,r1,#0x10	; 0230768E
	add r3,r3,#0x1	; 02307690
	cmp r3,#0x5	; 02307692
	bcc loc_0230767A	; 02307694
	mov r5,#0x0	; 02307696
	ldr r4,[pool_0230770C]	; 02307698
	ldr r2,[pool_02307710]	; 0230769A
	add r6,r4,#0x0	; 0230769C
	b loc_023076C4	; 0230769E
loc_023076A0:
	lsl r1,r5,#0x2	; 023076A0
	add r3,r2,r1	; 023076A2
	ldrh r7,[r2,r1]	; 023076A4
	ldr r1,[pool_02307714]	; 023076A6
	ldrh r1,[r7,r1]	; 023076A8
	ldrh r3,[r3,#0x2]	; 023076AA
	add r7,r4,#0x0	; 023076AC
	and r7,r3	; 023076AE
	cmp r1,r7	; 023076B0
	beq loc_023076BC	; 023076B2
	add r1,r0,#0x0	; 023076B4
	add r0,r0,#0x1	; 023076B6
	cmp r1,#0x20	; 023076B8
	bhi loc_023076EE	; 023076BA
loc_023076BC:
	add r1,r4,r6	; 023076BC
	lsl r1,r1,#0x10	; 023076BE
	lsr r4,r1,#0x10	; 023076C0
	add r5,r5,#0x1	; 023076C2
loc_023076C4:
	cmp r5,#0x5	; 023076C4
	bcc loc_023076A0	; 023076C6
	mov r1,#0x0	; 023076C8
	ldr r5,[pool_02307710]	; 023076CA
	add r4,r1,#0x0	; 023076CC
	ldr r2,[pool_02307714]	; 023076CE
	b loc_023076EA	; 023076D0
loc_023076D2:
	lsl r3,r1,#0x2	; 023076D2
	ldrh r3,[r5,r3]	; 023076D4
	add r3,r3,r2	; 023076D6
	strh r4,[r3,#0x0]	; 023076D8
	ldrh r3,[r3,#0x0]	; 023076DA
	cmp r3,#0x0	; 023076DC
	beq loc_023076E8	; 023076DE
	add r3,r0,#0x0	; 023076E0
	add r0,r0,#0x1	; 023076E2
	cmp r3,#0x20	; 023076E4
	bhi loc_023076EE	; 023076E6
loc_023076E8:
	add r1,r1,#0x1	; 023076E8
loc_023076EA:
	cmp r1,#0x5	; 023076EA
	bcc loc_023076D2	; 023076EC
loc_023076EE:
	cmp r0,#0x0	; 023076EE
	beq loc_02307702	; 023076F0
	ldr r0,[pool_02307718]	; 023076F2
	ldr r1,[r0,#0x0]	; 023076F4
	ldr r0,[pool_0230771C]	; 023076F6
	add r2,r1,r0	; 023076F8
	ldrh r1,[r2,#0x0]	; 023076FA
	mov r0,#0x1	; 023076FC
	orr r1,r0	; 023076FE
	strh r1,[r2,#0x0]	; 02307700
loc_02307702:
	add sp,#0x4	; 02307702
	pop {r4,r5,r6,r7}	; 02307704
	pop {r3}	; 02307706
	bx r3	; 02307708
	.byte 0xC0, 0x46	; 0230770C
pool_0230770C:
loc_0230770C:
	.word 0x00001234	; 0230770C
pool_02307710:
loc_02307710:
	.word P4_Data_023105B0	; 02307710
pool_02307714:
loc_02307714:
	.word WifiIoWs1Base	; 02307714
pool_02307718:
loc_02307718:
	.word FirmwareWlWorkPointerSlot	; 02307718
pool_0230771C:
loc_0230771C:
	.word 0x00000302	; 0230771C

; ===== function loc_02307720 =====
loc_02307720:
	push {lr}	; 02307720
	sub sp,#0x4	; 02307722
	ldr r0,[pool_02307738]	; 02307724
	ldr r1,[pool_0230773C]	; 02307726
	bl loc_02307740	; 02307728
	ldr r0,[pool_02307738]	; 0230772C
	bl loc_02304B58	; 0230772E
	add sp,#0x4	; 02307732
	pop {r3}	; 02307734
	bx r3	; 02307736
pool_02307738:
loc_02307738:
	.word 0x01000000	; 02307738
pool_0230773C:
loc_0230773C:
	.word P4_IrqHandler_023085B8 + 1	; 0230773C

; ===== function loc_02307740 =====
loc_02307740:
	bx pc	; 02307740
	.byte 0xC0, 0x46	; 02307744
.arm

; ===== function loc_02307744 =====
loc_02307744:
	ldr r12,[pool_0230774C]	; 02307744
	bx r12	; 02307748
pool_0230774C:
loc_0230774C:
	.word loc_037FB620 + 1	; 0230774C
.thumb

; ===== function loc_02307750 =====
loc_02307750:
	push {lr}	; 02307750
	sub sp,#0x4	; 02307752
	ldr r0,[pool_023077C8]	; 02307754
	ldr r1,[r0,#0x0]	; 02307756
	ldr r0,[pool_023077CC]	; 02307758
	add r0,r1,r0	; 0230775A
	add r1,r0,#0x0	; 0230775C
	add r1,#0x50	; 0230775E
	ldrh r1,[r1,#0x0]	; 02307760
	cmp r1,#0x0	; 02307762
	beq loc_0230778E	; 02307764
	ldr r3,[r0,#0x58]	; 02307766
	ldrh r2,[r3,#0x0]	; 02307768
	mov r1,#0x1	; 0230776A
	and r2,r1	; 0230776C
	cmp r2,#0x0	; 0230776E
	beq loc_0230778E	; 02307770
	ldr r1,[pool_023077D0]	; 02307772
	and r3,r1	; 02307774
	lsr r2,r3,#0x1	; 02307776
	ldr r1,[pool_023077D4]	; 02307778
	orr r2,r1	; 0230777A
	ldr r1,[pool_023077D8]	; 0230777C
	ldrh r1,[r1,#0x0]	; 0230777E
	cmp r2,r1	; 02307780
	beq loc_0230778E	; 02307782
	add r0,#0x50	; 02307784
	bl loc_0230CED0	; 02307786
	mov r0,#0x1	; 0230778A
	b loc_023077C2	; 0230778C
loc_0230778E:
	add r1,r0,#0x0	; 0230778E
	add r1,#0x64	; 02307790
	ldrh r1,[r1,#0x0]	; 02307792
	cmp r1,#0x0	; 02307794
	beq loc_023077C0	; 02307796
	ldr r3,[r0,#0x6c]	; 02307798
	ldrh r2,[r3,#0x0]	; 0230779A
	mov r1,#0x1	; 0230779C
	and r2,r1	; 0230779E
	cmp r2,#0x0	; 023077A0
	beq loc_023077C0	; 023077A2
	ldr r1,[pool_023077D0]	; 023077A4
	and r3,r1	; 023077A6
	lsr r2,r3,#0x1	; 023077A8
	ldr r1,[pool_023077D4]	; 023077AA
	orr r2,r1	; 023077AC
	ldr r1,[pool_023077D8]	; 023077AE
	ldrh r1,[r1,#0x0]	; 023077B0
	cmp r2,r1	; 023077B2
	beq loc_023077C0	; 023077B4
	add r0,#0x64	; 023077B6
	bl loc_0230CED0	; 023077B8
	mov r0,#0x1	; 023077BC
	b loc_023077C2	; 023077BE
loc_023077C0:
	mov r0,#0x0	; 023077C0
loc_023077C2:
	add sp,#0x4	; 023077C2
	pop {r3}	; 023077C4
	bx r3	; 023077C6
pool_023077C8:
loc_023077C8:
	.word FirmwareWlWorkPointerSlot	; 023077C8
pool_023077CC:
loc_023077CC:
	.word 0x000003E4	; 023077CC
pool_023077D0:
loc_023077D0:
	.word 0x00003FFF	; 023077D0
pool_023077D4:
loc_023077D4:
	.word 0x00008000	; 023077D4
pool_023077D8:
loc_023077D8:
	.word REG_WIFI_TXBUF_REPLY2	; 023077D8

; ===== function loc_023077DC =====
loc_023077DC:
	push {r4,r5,r6,r7,lr}	; 023077DC
	sub sp,#0x4	; 023077DE
	ldr r0,[pool_0230780C]	; 023077E0
	ldr r1,[r0,#0x0]	; 023077E2
	ldr r2,[pool_02307810]	; 023077E4
	ldrh r1,[r1,r2]	; 023077E6
	ldr r3,[pool_02307814]	; 023077E8
	cmp r1,r3	; 023077EA
	beq loc_02307804	; 023077EC
	ldr r7,[pool_02307818]	; 023077EE
	ldrh r6,[r7,#0x0]	; 023077F0
	strh r1,[r7,#0x0]	; 023077F2
	ldr r5,[pool_0230781C]	; 023077F4
	ldrh r4,[r5,#0x0]	; 023077F6
	mov r1,#0x80	; 023077F8
	orr r4,r1	; 023077FA
	strh r4,[r5,#0x0]	; 023077FC
	strh r6,[r7,#0x0]	; 023077FE
	ldr r0,[r0,#0x0]	; 02307800
	strh r3,[r0,r2]	; 02307802
loc_02307804:
	add sp,#0x4	; 02307804
	pop {r4,r5,r6,r7}	; 02307806
	pop {r3}	; 02307808
	bx r3	; 0230780A
pool_0230780C:
loc_0230780C:
	.word FirmwareWlWorkPointerSlot	; 0230780C
pool_02307810:
loc_02307810:
	.word 0x0000048A	; 02307810
pool_02307814:
loc_02307814:
	.word 0x0000FFFF	; 02307814
pool_02307818:
loc_02307818:
	.word REG_WIFI_TXBUF_REPLY1	; 02307818
pool_0230781C:
loc_0230781C:
	.word REG_WIFI_RXCNT	; 0230781C

; ===== function loc_02307820 =====
loc_02307820:
	ldr r1,[pool_02307834]	; 02307820
	cmp r0,r1	; 02307822
	bcc loc_02307830	; 02307824
	ldr r1,[pool_02307838]	; 02307826
	ldr r2,[r1,#0x0]	; 02307828
	ldr r1,[pool_0230783C]	; 0230782A
	ldrh r1,[r2,r1]	; 0230782C
	sub r0,r0,r1	; 0230782E
loc_02307830:
	bx lr	; 02307830
	.byte 0xC0, 0x46	; 02307834
pool_02307834:
loc_02307834:
	.word 0x04805F60	; 02307834
pool_02307838:
loc_02307838:
	.word FirmwareWlWorkPointerSlot	; 02307838
pool_0230783C:
loc_0230783C:
	.word 0x00000396	; 0230783C

; ===== function loc_02307840 =====
P4_Code_02307840:
	push {r4,lr}	; 02307840
	ldr r0,[pool_0230787C]	; 02307842
	bl loc_02304B48	; 02307844
	add r4,r0,#0x0	; 02307848
	ldr r2,[pool_02307880]	; 0230784A
	ldrh r3,[r2,#0x0]	; 0230784C
	ldr r1,[pool_02307884]	; 0230784E
	ldr r0,[pool_02307888]	; 02307850
	strh r1,[r0,#0x0]	; 02307852
	mov r1,#0x64	; 02307854
	b loc_02307860	; 02307856
loc_02307858:
	ldrh r0,[r2,#0x0]	; 02307858
	cmp r3,r0	; 0230785A
	bne loc_02307864	; 0230785C
	sub r1,r1,#0x1	; 0230785E
loc_02307860:
	cmp r1,#0x0	; 02307860
	bne loc_02307858	; 02307862
loc_02307864:
	mov r0,#0x0	; 02307864
	ldr r1,[pool_02307888]	; 02307866
	strh r0,[r1,#0x0]	; 02307868
	bl loc_02307B58	; 0230786A
	add r0,r4,#0x0	; 0230786E
	bl loc_02304B58	; 02307870
	pop {r4}	; 02307874
	pop {r3}	; 02307876
	bx r3	; 02307878
	.byte 0xC0, 0x46	; 0230787C
pool_0230787C:
loc_0230787C:
	.word 0x01000000	; 0230787C
pool_02307880:
loc_02307880:
	.word REG_WIFI_TX_SEQNO	; 02307880
pool_02307884:
loc_02307884:
	.word 0x00001000	; 02307884
pool_02307888:
loc_02307888:
	.word REG_WIFI_UNKNOWN_244	; 02307888

; ===== function loc_0230788C =====
loc_0230788C:
	push {r4,lr}	; 0230788C
	mov r4,#0x0	; 0230788E
	mov r0,#0x1	; 02307890
	bl loc_0230CD34	; 02307892
	lsl r0,r4,#0	; 02307896
	bl loc_0230CD34	; 02307898
	ldr r0,[pool_023078E8]	; 0230789C
	ldr r2,[r0,#0x0]	; 0230789E
	ldr r0,[pool_023078EC]	; 023078A0
	ldr r0,[r2,r0]	; 023078A2
	ldrh r0,[r0,#0x0]	; 023078A4
	cmp r0,#0x0	; 023078A6
	beq loc_023078AE	; 023078A8
	mov r4,#0x1	; 023078AA
	b loc_023078B4	; 023078AC
loc_023078AE:
	lsl r1,r4,#0	; 023078AE
	ldr r0,[pool_023078F0]	; 023078B0
	strh r1,[r2,r0]	; 023078B2
loc_023078B4:
	ldr r0,[pool_023078E8]	; 023078B4
	ldr r2,[r0,#0x0]	; 023078B6
	ldr r0,[pool_023078F4]	; 023078B8
	ldr r0,[r2,r0]	; 023078BA
	ldrh r0,[r0,#0x0]	; 023078BC
	cmp r0,#0x0	; 023078BE
	beq loc_023078C6	; 023078C0
	mov r4,#0x1	; 023078C2
	b loc_023078CC	; 023078C4
loc_023078C6:
	mov r1,#0x0	; 023078C6
	ldr r0,[pool_023078F8]	; 023078C8
	strh r1,[r2,r0]	; 023078CA
loc_023078CC:
	cmp r4,#0x0	; 023078CC
	beq loc_023078D8	; 023078CE
	mov r0,#0x0	; 023078D0
	mov r1,#0xe	; 023078D2
	bl loc_02304B68	; 023078D4
loc_023078D8:
	mov r0,#0x0	; 023078D8
	mov r1,#0x14	; 023078DA
	bl loc_02304B68	; 023078DC
	pop {r4}	; 023078E0
	pop {r3}	; 023078E2
	bx r3	; 023078E4
	.byte 0xC0, 0x46	; 023078E8
pool_023078E8:
loc_023078E8:
	.word FirmwareWlWorkPointerSlot	; 023078E8
pool_023078EC:
loc_023078EC:
	.word 0x00000400	; 023078EC
pool_023078F0:
loc_023078F0:
	.word 0x000003F8	; 023078F0
pool_023078F4:
loc_023078F4:
	.word 0x000003EC	; 023078F4
pool_023078F8:
loc_023078F8:
	.word 0x000003E4	; 023078F8

; ===== function loc_023078FC =====
loc_023078FC:
	push {r4,r5,r6,r7,lr}	; 023078FC
	sub sp,#0x4	; 023078FE
	mov r1,#0x40	; 02307900
	ldr r0,[pool_02307A74]	; 02307902
	strh r1,[r0,#0x0]	; 02307904
	ldr r0,[pool_02307A78]	; 02307906
	ldr r2,[r0,#0x0]	; 02307908
	ldr r0,[pool_02307A7C]	; 0230790A
	ldrh r1,[r2,r0]	; 0230790C
	mov r0,#0x20	; 0230790E
	and r1,r0	; 02307910
	cmp r1,#0x0	; 02307912
	bne loc_02307918	; 02307914
	b loc_02307A6C	; 02307916
loc_02307918:
	ldr r0,[pool_02307A80]	; 02307918
	ldrh r1,[r2,r0]	; 0230791A
	ldr r0,[pool_02307A84]	; 0230791C
	cmp r1,r0	; 0230791E
	beq loc_02307924	; 02307920
	b loc_02307A6C	; 02307922
loc_02307924:
	ldr r0,[pool_02307A88]	; 02307924
	ldrh r1,[r0,#0x0]	; 02307926
	mov r0,#0x3	; 02307928
	and r1,r0	; 0230792A
	cmp r1,#0x3	; 0230792C
	beq loc_02307932	; 0230792E
	b loc_02307A6C	; 02307930
loc_02307932:
	ldr r0,[pool_02307A8C]	; 02307932
	ldrh r2,[r0,#0x0]	; 02307934
	ldr r0,[pool_02307A90]	; 02307936
	ldrh r0,[r0,#0x0]	; 02307938
	lsr r1,r0,#0x1	; 0230793A
	ldr r0,[pool_02307A94]	; 0230793C
	and r1,r0	; 0230793E
	cmp r2,r1	; 02307940
	bge loc_02307946	; 02307942
	b loc_02307A6C	; 02307944
loc_02307946:
	ldr r0,[pool_02307A98]	; 02307946
	ldrh r6,[r0,#0x0]	; 02307948
	lsl r1,r6,#0x1	; 0230794A
	ldr r0,[pool_02307A9C]	; 0230794C
	add r0,r1,r0	; 0230794E
	add r0,#0x8	; 02307950
	bl loc_02307820	; 02307952
	add r0,r0,#0x4	; 02307956
	bl loc_02307820	; 02307958
	ldrh r2,[r0,#0x0]	; 0230795C
	ldr r1,[pool_02307AA0]	; 0230795E
	and r2,r1	; 02307960
	ldr r1,[pool_02307AA4]	; 02307962
	cmp r2,r1	; 02307964
	beq loc_0230796A	; 02307966
	b loc_02307A6C	; 02307968
loc_0230796A:
	add r0,r0,#0x2	; 0230796A
	bl loc_02307820	; 0230796C
	add r1,r0,#0x0	; 02307970
	ldr r0,[pool_02307AA8]	; 02307972
	ldrh r3,[r0,#0x0]	; 02307974
	ldr r2,[pool_02307AAC]	; 02307976
	sub r4,r3,r2	; 02307978
	ldr r7,[pool_02307A8C]	; 0230797A
loc_0230797C:
	ldrh r2,[r7,#0x0]	; 0230797C
	sub r2,r2,r6	; 0230797E
	lsl r2,r2,#0x10	; 02307980
	lsr r2,r2,#0x10	; 02307982
	add r5,r2,#0x0	; 02307984
	ldr r3,[pool_02307AB0]	; 02307986
	and r5,r3	; 02307988
	cmp r5,#0x0	; 0230798A
	beq loc_0230799E	; 0230798C
	ldr r3,[pool_02307A78]	; 0230798E
	ldr r5,[r3,#0x0]	; 02307990
	ldr r3,[pool_02307AB4]	; 02307992
	ldrh r3,[r5,r3]	; 02307994
	lsr r3,r3,#0x1	; 02307996
	add r2,r2,r3	; 02307998
	lsl r2,r2,#0x10	; 0230799A
	lsr r2,r2,#0x10	; 0230799C
loc_0230799E:
	cmp r2,#0xe	; 0230799E
	bhi loc_023079B0	; 023079A0
	ldrh r2,[r0,#0x0]	; 023079A2
	sub r2,r2,r4	; 023079A4
	lsl r2,r2,#0x10	; 023079A6
	lsr r2,r2,#0x10	; 023079A8
	cmp r2,#0x40	; 023079AA
	bls loc_0230797C	; 023079AC
	b loc_02307A6C	; 023079AE
loc_023079B0:
	add r1,#0x8	; 023079B0
	mov r5,#0x0	; 023079B2
	ldr r7,[pool_02307A78]	; 023079B4
	b loc_023079D2	; 023079B6
loc_023079B8:
	add r0,r1,#0x0	; 023079B8
	bl loc_02307820	; 023079BA
	add r1,r0,#0x2	; 023079BE
	ldrh r0,[r0,#0x0]	; 023079C0
	ldr r3,[r7,#0x0]	; 023079C2
	lsl r2,r5,#0x1	; 023079C4
	add r3,r3,r2	; 023079C6
	ldr r2,[pool_02307AB8]	; 023079C8
	ldrh r2,[r3,r2]	; 023079CA
	cmp r0,r2	; 023079CC
	bne loc_02307A6C	; 023079CE
	add r5,r5,#0x1	; 023079D0
loc_023079D2:
	cmp r5,#0x3	; 023079D2
	bcc loc_023079B8	; 023079D4
	add r1,#0xa	; 023079D6
	add r0,r1,#0x0	; 023079D8
	bl loc_02307820	; 023079DA
	add r2,r0,#0x0	; 023079DE
	ldr r7,[pool_02307A78]	; 023079E0
	ldr r0,[pool_02307A8C]	; 023079E2
loc_023079E4:
	ldrh r1,[r0,#0x0]	; 023079E4
	sub r1,r1,r6	; 023079E6
	lsl r1,r1,#0x10	; 023079E8
	lsr r1,r1,#0x10	; 023079EA
	add r5,r1,#0x0	; 023079EC
	ldr r3,[pool_02307AB0]	; 023079EE
	and r5,r3	; 023079F0
	cmp r5,#0x0	; 023079F2
	beq loc_02307A04	; 023079F4
	ldr r5,[r7,#0x0]	; 023079F6
	ldr r3,[pool_02307AB4]	; 023079F8
	ldrh r3,[r5,r3]	; 023079FA
	lsr r3,r3,#0x1	; 023079FC
	add r1,r1,r3	; 023079FE
	lsl r1,r1,#0x10	; 02307A00
	lsr r1,r1,#0x10	; 02307A02
loc_02307A04:
	cmp r1,#0x14	; 02307A04
	bhi loc_02307A18	; 02307A06
	ldr r1,[pool_02307AA8]	; 02307A08
	ldrh r1,[r1,#0x0]	; 02307A0A
	sub r1,r1,r4	; 02307A0C
	lsl r1,r1,#0x10	; 02307A0E
	lsr r1,r1,#0x10	; 02307A10
	cmp r1,#0x70	; 02307A12
	bls loc_023079E4	; 02307A14
	b loc_02307A6C	; 02307A16
loc_02307A18:
	ldr r1,[pool_02307A78]	; 02307A18
	ldr r0,[r1,#0x0]	; 02307A1A
	ldrh r3,[r2,#0x0]	; 02307A1C
	ldr r2,[pool_02307ABC]	; 02307A1E
	ldrh r2,[r0,r2]	; 02307A20
	and r3,r2	; 02307A22
	cmp r3,#0x0	; 02307A24
	bne loc_02307A6C	; 02307A26
	ldr r2,[pool_02307AC0]	; 02307A28
	ldrh r3,[r2,#0x0]	; 02307A2A
	ldr r2,[pool_02307A80]	; 02307A2C
	strh r3,[r0,r2]	; 02307A2E
	mov r2,#0x40	; 02307A30
	ldr r0,[pool_02307AC4]	; 02307A32
	strh r2,[r0,#0x0]	; 02307A34
	ldr r1,[r1,#0x0]	; 02307A36
	ldr r0,[pool_02307AC8]	; 02307A38
	add r1,r1,r0	; 02307A3A
	ldrh r0,[r1,#0x0]	; 02307A3C
	add r0,r0,#0x1	; 02307A3E
	strh r0,[r1,#0x0]	; 02307A40
	ldr r1,[pool_02307A88]	; 02307A42
	mov r0,#0x3	; 02307A44
loc_02307A46:
	ldrh r2,[r1,#0x0]	; 02307A46
	and r2,r0	; 02307A48
	cmp r2,#0x3	; 02307A4A
	beq loc_02307A46	; 02307A4C
	ldr r2,[pool_02307ACC]	; 02307A4E
	ldrh r1,[r2,#0x0]	; 02307A50
	mov r0,#0x40	; 02307A52
	orr r1,r0	; 02307A54
	strh r1,[r2,#0x0]	; 02307A56
	ldrh r1,[r2,#0x0]	; 02307A58
	bic r1,r0	; 02307A5A
	strh r1,[r2,#0x0]	; 02307A5C
	mov r0,#0x8	; 02307A5E
	ldr r1,[pool_02307AD0]	; 02307A60
	strh r0,[r1,#0x0]	; 02307A62
	mov r0,#0x0	; 02307A64
	strh r0,[r1,#0x0]	; 02307A66
	bl loc_023077DC	; 02307A68
loc_02307A6C:
	add sp,#0x4	; 02307A6C
	pop {r4,r5,r6,r7}	; 02307A6E
	pop {r3}	; 02307A70
	bx r3	; 02307A72
pool_02307A74:
loc_02307A74:
	.word REG_WIFI_IF	; 02307A74
pool_02307A78:
loc_02307A78:
	.word FirmwareWlWorkPointerSlot	; 02307A78
pool_02307A7C:
loc_02307A7C:
	.word 0x0000061C	; 02307A7C
pool_02307A80:
loc_02307A80:
	.word 0x0000048A	; 02307A80
pool_02307A84:
loc_02307A84:
	.word 0x0000FFFF	; 02307A84
pool_02307A88:
loc_02307A88:
	.word REG_WIFI_RF_PINS	; 02307A88
pool_02307A8C:
loc_02307A8C:
	.word REG_WIFI_RXTX_ADDR	; 02307A8C
pool_02307A90:
loc_02307A90:
	.word REG_WIFI_RXBUF_BEGIN	; 02307A90
pool_02307A94:
loc_02307A94:
	.word 0x00000FFF	; 02307A94
pool_02307A98:
loc_02307A98:
	.word REG_WIFI_RXBUF_WRCSR	; 02307A98
pool_02307A9C:
loc_02307A9C:
	.word WifiRamBase	; 02307A9C
pool_02307AA0:
loc_02307AA0:
	.word 0x0000E7FF	; 02307AA0
pool_02307AA4:
loc_02307AA4:
	.word 0x00000228	; 02307AA4
pool_02307AA8:
loc_02307AA8:
	.word REG_WIFI_US_COUNT0	; 02307AA8
pool_02307AAC:
loc_02307AAC:
	.word 0x00010000	; 02307AAC
pool_02307AB0:
loc_02307AB0:
	.word 0x00008000	; 02307AB0
pool_02307AB4:
loc_02307AB4:
	.word 0x00000396	; 02307AB4
pool_02307AB8:
loc_02307AB8:
	.word 0x00000360	; 02307AB8
pool_02307ABC:
loc_02307ABC:
	.word 0x00000486	; 02307ABC
pool_02307AC0:
loc_02307AC0:
	.word REG_WIFI_TXBUF_REPLY2	; 02307AC0
pool_02307AC4:
loc_02307AC4:
	.word REG_WIFI_TXBUF_RESET	; 02307AC4
pool_02307AC8:
loc_02307AC8:
	.word 0x000003BA	; 02307AC8
pool_02307ACC:
loc_02307ACC:
	.word REG_WIFI_UNKNOWN_244	; 02307ACC
pool_02307AD0:
loc_02307AD0:
	.word REG_WIFI_UNKNOWN_228	; 02307AD0

; ===== function loc_02307AD4 =====
loc_02307AD4:
	push {r4,lr}	; 02307AD4
	mov r2,#0x80	; 02307AD6
	ldr r0,[pool_02307B34]	; 02307AD8
	strh r2,[r0,#0x0]	; 02307ADA
	ldr r0,[pool_02307B38]	; 02307ADC
	ldr r1,[r0,#0x0]	; 02307ADE
	ldr r0,[pool_02307B3C]	; 02307AE0
	ldrh r3,[r1,r0]	; 02307AE2
	mov r0,#0x20	; 02307AE4
	and r3,r0	; 02307AE6
	cmp r3,#0x0	; 02307AE8
	beq loc_02307B2C	; 02307AEA
	ldr r0,[pool_02307B40]	; 02307AEC
	ldrh r3,[r0,#0x0]	; 02307AEE
	mov r0,#0xff	; 02307AF0
	and r3,r0	; 02307AF2
	lsl r0,r3,#0x10	; 02307AF4
	lsr r3,r0,#0x10	; 02307AF6
	ldr r0,[pool_02307B44]	; 02307AF8
	ldrh r0,[r0,#0x0]	; 02307AFA
	cmp r3,#0x3	; 02307AFC
	bcc loc_02307B2C	; 02307AFE
	cmp r3,#0x5	; 02307B00
	bhi loc_02307B2C	; 02307B02
	ldr r3,[pool_02307B48]	; 02307B04
	ldr r3,[r1,r3]	; 02307B06
	lsr r3,r3,#0x1	; 02307B08
	ldr r4,[pool_02307B4C]	; 02307B0A
	and r3,r4	; 02307B0C
	cmp r0,r3	; 02307B0E
	bcc loc_02307B2C	; 02307B10
	ldr r3,[pool_02307B50]	; 02307B12
	ldr r1,[r1,r3]	; 02307B14
	lsr r1,r1,#0x1	; 02307B16
	and r1,r4	; 02307B18
	cmp r0,r1	; 02307B1A
	bhi loc_02307B2C	; 02307B1C
	ldr r1,[pool_02307B54]	; 02307B1E
	ldrh r0,[r1,#0x0]	; 02307B20
	orr r0,r2	; 02307B22
	strh r0,[r1,#0x0]	; 02307B24
	ldrh r0,[r1,#0x0]	; 02307B26
	bic r0,r2	; 02307B28
	strh r0,[r1,#0x0]	; 02307B2A
loc_02307B2C:
	pop {r4}	; 02307B2C
	pop {r3}	; 02307B2E
	bx r3	; 02307B30
	.byte 0xC0, 0x46	; 02307B34
pool_02307B34:
loc_02307B34:
	.word REG_WIFI_IF	; 02307B34
pool_02307B38:
loc_02307B38:
	.word FirmwareWlWorkPointerSlot	; 02307B38
pool_02307B3C:
loc_02307B3C:
	.word 0x0000061C	; 02307B3C
pool_02307B40:
loc_02307B40:
	.word REG_WIFI_RF_STATUS	; 02307B40
pool_02307B44:
loc_02307B44:
	.word REG_WIFI_RXTX_ADDR	; 02307B44
pool_02307B48:
loc_02307B48:
	.word 0x0000043C	; 02307B48
pool_02307B4C:
loc_02307B4C:
	.word 0x00000FFF	; 02307B4C
pool_02307B50:
loc_02307B50:
	.word 0x00000414	; 02307B50
pool_02307B54:
loc_02307B54:
	.word REG_WIFI_UNKNOWN_244	; 02307B54

; ===== function loc_02307B58 =====
loc_02307B58:
	push {r4,lr}	; 02307B58
	ldr r1,[pool_02307BE4]	; 02307B5A
	ldr r3,[r1,#0x0]	; 02307B5C
	ldr r2,[pool_02307BE8]	; 02307B5E
	add r2,r3,r2	; 02307B60
	ldr r4,[pool_02307BEC]	; 02307B62
	ldr r3,[pool_02307BF0]	; 02307B64
	strh r4,[r3,#0x0]	; 02307B66
	ldrh r3,[r2,#0x3c]	; 02307B68
	cmp r3,#0x0	; 02307B6A
	beq loc_02307BDC	; 02307B6C
	ldr r3,[r1,#0x0]	; 02307B6E
	ldr r1,[pool_02307BF4]	; 02307B70
	ldrh r3,[r3,r1]	; 02307B72
	mov r1,#0x10	; 02307B74
	and r3,r1	; 02307B76
	cmp r3,#0x0	; 02307B78
	beq loc_02307BD4	; 02307B7A
	cmp r0,#0x0	; 02307B7C
	beq loc_02307BD4	; 02307B7E
	ldr r0,[pool_02307BF8]	; 02307B80
	ldrh r1,[r0,#0x0]	; 02307B82
	ldr r0,[pool_02307BFC]	; 02307B84
	ldrh r0,[r0,#0x0]	; 02307B86
	cmp r0,#0x3	; 02307B88
	beq loc_02307B90	; 02307B8A
	cmp r0,#0x5	; 02307B8C
	bne loc_02307BD4	; 02307B8E
loc_02307B90:
	cmp r1,#0x0	; 02307B90
	bne loc_02307BD4	; 02307B92
	ldr r3,[r2,#0x44]	; 02307B94
	ldrh r4,[r3,#0x2]	; 02307B96
	mov r0,#0x0	; 02307B98
	mov r1,#0x1	; 02307B9A
	b loc_02307BA8	; 02307B9C
loc_02307B9E:
	add r2,r4,#0x0	; 02307B9E
	and r2,r1	; 02307BA0
	add r0,r0,r2	; 02307BA2
	lsl r2,r4,#0xf	; 02307BA4
	lsr r4,r2,#0x10	; 02307BA6
loc_02307BA8:
	cmp r4,#0x0	; 02307BA8
	bne loc_02307B9E	; 02307BAA
	ldrh r1,[r3,#0xa]	; 02307BAC
	lsl r2,r1,#0x2	; 02307BAE
	ldrh r1,[r3,#0x24]	; 02307BB0
	add r1,#0xa	; 02307BB2
	mul r0,r1	; 02307BB4
	add r0,#0xc0	; 02307BB6
	add r0,r2,r0	; 02307BB8
	lsl r0,r0,#0x10	; 02307BBA
	lsr r0,r0,#0x10	; 02307BBC
	ldr r1,[pool_02307C00]	; 02307BBE
	bl loc_023055A4	; 02307BC0
	ldr r0,[pool_02307BE4]	; 02307BC4
	ldr r1,[r0,#0x0]	; 02307BC6
	ldr r0,[pool_02307C04]	; 02307BC8
	add r1,r1,r0	; 02307BCA
	ldrh r0,[r1,#0x0]	; 02307BCC
	add r0,r0,#0x1	; 02307BCE
	strh r0,[r1,#0x0]	; 02307BD0
	b loc_02307BDC	; 02307BD2
loc_02307BD4:
	mov r0,#0x0	; 02307BD4
	mov r1,#0x10	; 02307BD6
	bl loc_02304B68	; 02307BD8
loc_02307BDC:
	pop {r4}	; 02307BDC
	pop {r3}	; 02307BDE
	bx r3	; 02307BE0
	.byte 0xC0, 0x46	; 02307BE4
pool_02307BE4:
loc_02307BE4:
	.word FirmwareWlWorkPointerSlot	; 02307BE4
pool_02307BE8:
loc_02307BE8:
	.word 0x000003E4	; 02307BE8
pool_02307BEC:
loc_02307BEC:
	.word 0x00001000	; 02307BEC
pool_02307BF0:
loc_02307BF0:
	.word REG_WIFI_IF	; 02307BF0
pool_02307BF4:
loc_02307BF4:
	.word 0x0000061C	; 02307BF4
pool_02307BF8:
loc_02307BF8:
	.word REG_WIFI_TXBUSY	; 02307BF8
pool_02307BFC:
loc_02307BFC:
	.word REG_WIFI_RF_STATUS	; 02307BFC
pool_02307C00:
loc_02307C00:
	.word P4_Code_02307840 + 1	; 02307C00
pool_02307C04:
loc_02307C04:
	.word 0x000003B8	; 02307C04

; ===== function loc_02307C08 =====
loc_02307C08:
	push {r4,r5,r6,r7,lr}	; 02307C08
	sub sp,#0xc	; 02307C0A
	ldr r1,[pool_02307DB4]	; 02307C0C
	mov r0,#0x1	; 02307C0E
	strh r0,[r1,#0x0]	; 02307C10
loc_02307C12:
	ldr r0,[pool_02307DB8]	; 02307C12
	ldr r0,[r0,#0x0]	; 02307C14
	ldr r1,[pool_02307DBC]	; 02307C16
	ldrh r1,[r0,r1]	; 02307C18
	ldr r2,[pool_02307DC0]	; 02307C1A
	ldrh r2,[r2,#0x0]	; 02307C1C
	str r2,[sp,#0x0]	; 02307C1E
	cmp r1,r2	; 02307C20
	bne loc_02307C26	; 02307C22
	b loc_02307D6C	; 02307C24
loc_02307C26:
	ldr r2,[pool_02307DC4]	; 02307C26
	ldrh r3,[r2,#0x0]	; 02307C28
	ldr r2,[pool_02307DC8]	; 02307C2A
	ldrh r2,[r2,#0x0]	; 02307C2C
	ldr r4,[pool_02307DC4]	; 02307C2E
	ldrh r5,[r4,#0x0]	; 02307C30
	ldr r4,[pool_02307DC8]	; 02307C32
	ldrh r4,[r4,#0x0]	; 02307C34
	cmp r3,r5	; 02307C36
	bls loc_02307C42	; 02307C38
	lsr r5,r5,#0x4	; 02307C3A
	lsl r2,r4,#0xc	; 02307C3C
	orr r5,r2	; 02307C3E
	b loc_02307C48	; 02307C40
loc_02307C42:
	lsr r5,r3,#0x4	; 02307C42
	lsl r2,r2,#0xc	; 02307C44
	orr r5,r2	; 02307C46
loc_02307C48:
	lsl r3,r1,#0x1	; 02307C48
	ldr r2,[pool_02307DCC]	; 02307C4A
	add r3,r3,r2	; 02307C4C
	add r4,r3,#0x2	; 02307C4E
	ldr r2,[pool_02307DD0]	; 02307C50
	cmp r4,r2	; 02307C52
	bcc loc_02307C5C	; 02307C54
	ldr r2,[pool_02307DD4]	; 02307C56
	ldrh r2,[r0,r2]	; 02307C58
	sub r4,r4,r2	; 02307C5A
loc_02307C5C:
	add r2,r4,#0x2	; 02307C5C
	ldr r6,[pool_02307DD0]	; 02307C5E
	cmp r2,r6	; 02307C60
	bcc loc_02307C6A	; 02307C62
	ldr r6,[pool_02307DD4]	; 02307C64
	ldrh r6,[r0,r6]	; 02307C66
	sub r2,r2,r6	; 02307C68
loc_02307C6A:
	add r7,r2,#0x4	; 02307C6A
	ldr r6,[pool_02307DD0]	; 02307C6C
	cmp r7,r6	; 02307C6E
	bcc loc_02307C78	; 02307C70
	ldr r6,[pool_02307DD4]	; 02307C72
	ldrh r0,[r0,r6]	; 02307C74
	sub r7,r7,r0	; 02307C76
loc_02307C78:
	ldrh r0,[r3,#0x0]	; 02307C78
	str r0,[sp,#0x8]	; 02307C7A
	ldrh r0,[r4,#0x0]	; 02307C7C
	lsl r0,r0,#0x1	; 02307C7E
	str r0,[sp,#0x4]	; 02307C80
	ldr r0,[pool_02307DD8]	; 02307C82
	ldr r6,[sp,#0x4]	; 02307C84
	and r6,r0	; 02307C86
	str r6,[sp,#0x4]	; 02307C88
	ldr r0,[sp,#0x8]	; 02307C8A
	orr r0,r6	; 02307C8C
	str r0,[sp,#0x8]	; 02307C8E
	strh r0,[r3,#0x0]	; 02307C90
	strh r5,[r2,#0x0]	; 02307C92
	ldrh r2,[r7,#0x0]	; 02307C94
	lsl r0,r1,#0x1	; 02307C96
	add r0,r2,r0	; 02307C98
	add r0,#0xf	; 02307C9A
	lsr r0,r0,#0x2	; 02307C9C
	lsl r5,r0,#0x1	; 02307C9E
	ldr r0,[pool_02307DDC]	; 02307CA0
	cmp r5,r0	; 02307CA2
	bcc loc_02307CB2	; 02307CA4
	ldr r0,[pool_02307DB8]	; 02307CA6
	ldr r1,[r0,#0x0]	; 02307CA8
	ldr r0,[pool_02307DD4]	; 02307CAA
	ldrh r0,[r1,r0]	; 02307CAC
	lsr r0,r0,#0x1	; 02307CAE
	sub r5,r5,r0	; 02307CB0
loc_02307CB2:
	ldr r0,[pool_02307DE0]	; 02307CB2
	cmp r2,r0	; 02307CB4
	bls loc_02307CCE	; 02307CB6
	ldr r0,[pool_02307DE4]	; 02307CB8
	strh r0,[r3,#0x0]	; 02307CBA
	ldr r5,[sp,#0x0]	; 02307CBC
	ldr r0,[pool_02307DB8]	; 02307CBE
	ldr r1,[r0,#0x0]	; 02307CC0
	ldr r0,[pool_02307DE8]	; 02307CC2
	add r1,r1,r0	; 02307CC4
	ldrh r0,[r1,#0x0]	; 02307CC6
	add r0,r0,#0x1	; 02307CC8
	strh r0,[r1,#0x0]	; 02307CCA
	b loc_02307D3C	; 02307CCC
loc_02307CCE:
	ldr r0,[pool_02307DB8]	; 02307CCE
	ldr r1,[r0,#0x0]	; 02307CD0
	ldr r0,[pool_02307DEC]	; 02307CD2
	ldrh r6,[r1,r0]	; 02307CD4
	mov r0,#0x1	; 02307CD6
	and r6,r0	; 02307CD8
	cmp r6,#0x0	; 02307CDA
	beq loc_02307D3C	; 02307CDC
	ldr r0,[sp,#0x0]	; 02307CDE
	cmp r5,r0	; 02307CE0
	beq loc_02307D3C	; 02307CE2
	lsl r6,r5,#0x1	; 02307CE4
	ldr r0,[pool_02307DCC]	; 02307CE6
	add r0,r6,r0	; 02307CE8
	ldrh r7,[r0,#0x0]	; 02307CEA
	ldr r6,[pool_02307DF0]	; 02307CEC
	cmp r0,r6	; 02307CEE
	bcs loc_02307CFE	; 02307CF0
	ldrh r6,[r0,#0x6]	; 02307CF2
	mov r0,#0xff	; 02307CF4
	and r6,r0	; 02307CF6
	lsl r0,r6,#0x10	; 02307CF8
	lsr r6,r0,#0x10	; 02307CFA
	b loc_02307D06	; 02307CFC
loc_02307CFE:
	ldr r6,[pool_02307DD4]	; 02307CFE
	ldrh r6,[r1,r6]	; 02307D00
	sub r0,r0,r6	; 02307D02
	ldrh r6,[r0,#0x6]	; 02307D04
loc_02307D06:
	ldr r0,[pool_02307DF4]	; 02307D06
	and r7,r0	; 02307D08
	cmp r7,#0x0	; 02307D0A
	bne loc_02307D1C	; 02307D0C
	cmp r6,#0xa	; 02307D0E
	beq loc_02307D16	; 02307D10
	cmp r6,#0x14	; 02307D12
	bne loc_02307D1C	; 02307D14
loc_02307D16:
	ldr r0,[pool_02307DF8]	; 02307D16
	cmp r2,r0	; 02307D18
	bls loc_02307D3C	; 02307D1A
loc_02307D1C:
	ldr r0,[pool_02307DE8]	; 02307D1C
	add r1,r1,r0	; 02307D1E
	ldrh r0,[r1,#0x0]	; 02307D20
	add r0,r0,#0x1	; 02307D22
	strh r0,[r1,#0x0]	; 02307D24
	ldr r0,[pool_02307DE4]	; 02307D26
	strh r0,[r3,#0x0]	; 02307D28
	ldr r0,[sp,#0x0]	; 02307D2A
	lsl r0,r0,#0x10	; 02307D2C
	lsr r2,r0,#0x10	; 02307D2E
	ldr r0,[pool_02307DB8]	; 02307D30
	ldr r1,[r0,#0x0]	; 02307D32
	ldr r0,[pool_02307DBC]	; 02307D34
	strh r2,[r1,r0]	; 02307D36
	strh r2,[r4,#0x0]	; 02307D38
	b loc_02307D6C	; 02307D3A
loc_02307D3C:
	ldrh r1,[r3,#0x0]	; 02307D3C
	mov r0,#0xf	; 02307D3E
	and r1,r0	; 02307D40
	cmp r1,#0xc	; 02307D42
	bne loc_02307D5C	; 02307D44
	bl loc_02307750	; 02307D46
	cmp r0,#0x0	; 02307D4A
	bne loc_02307D5C	; 02307D4C
	ldr r0,[pool_02307DB8]	; 02307D4E
	ldr r1,[r0,#0x0]	; 02307D50
	ldr r0,[pool_02307DFC]	; 02307D52
	add r1,r1,r0	; 02307D54
	ldr r0,[r1,#0x0]	; 02307D56
	add r0,r0,#0x1	; 02307D58
	str r0,[r1,#0x0]	; 02307D5A
loc_02307D5C:
	lsl r0,r5,#0x10	; 02307D5C
	lsr r2,r0,#0x10	; 02307D5E
	ldr r0,[pool_02307DB8]	; 02307D60
	ldr r1,[r0,#0x0]	; 02307D62
	ldr r0,[pool_02307DBC]	; 02307D64
	strh r2,[r1,r0]	; 02307D66
	strh r2,[r4,#0x0]	; 02307D68
	b loc_02307C12	; 02307D6A
loc_02307D6C:
	ldr r0,[pool_02307DB8]	; 02307D6C
	ldr r1,[r0,#0x0]	; 02307D6E
	ldr r0,[pool_02307DEC]	; 02307D70
	ldrh r1,[r1,r0]	; 02307D72
	mov r0,#0x1	; 02307D74
	and r1,r0	; 02307D76
	cmp r1,#0x0	; 02307D78
	beq loc_02307D96	; 02307D7A
	ldr r0,[pool_02307DC0]	; 02307D7C
	ldrh r4,[r0,#0x0]	; 02307D7E
	bl loc_02307750	; 02307D80
	cmp r0,#0x0	; 02307D84
	beq loc_02307D96	; 02307D86
	ldr r0,[pool_02307DC0]	; 02307D88
	ldrh r0,[r0,#0x0]	; 02307D8A
	cmp r4,r0	; 02307D8C
	bne loc_02307D96	; 02307D8E
	mov r0,#0x20	; 02307D90
	bl loc_02305130	; 02307D92
loc_02307D96:
	ldr r0,[pool_02307E00]	; 02307D96
	ldrh r1,[r0,#0x0]	; 02307D98
	ldr r0,[pool_02307DC0]	; 02307D9A
	ldrh r0,[r0,#0x0]	; 02307D9C
	cmp r1,r0	; 02307D9E
	beq loc_02307DAA	; 02307DA0
	mov r0,#0x0	; 02307DA2
	mov r1,#0xf	; 02307DA4
	bl loc_02304B68	; 02307DA6
loc_02307DAA:
	add sp,#0xc	; 02307DAA
	pop {r4,r5,r6,r7}	; 02307DAC
	pop {r3}	; 02307DAE
	bx r3	; 02307DB0
	.byte 0xC0, 0x46	; 02307DB4
pool_02307DB4:
loc_02307DB4:
	.word REG_WIFI_IF	; 02307DB4
pool_02307DB8:
loc_02307DB8:
	.word FirmwareWlWorkPointerSlot	; 02307DB8
pool_02307DBC:
loc_02307DBC:
	.word 0x0000049C	; 02307DBC
pool_02307DC0:
loc_02307DC0:
	.word REG_WIFI_RXBUF_WRCSR	; 02307DC0
pool_02307DC4:
loc_02307DC4:
	.word REG_WIFI_US_COUNT0	; 02307DC4
pool_02307DC8:
loc_02307DC8:
	.word REG_WIFI_US_COUNT1	; 02307DC8
pool_02307DCC:
loc_02307DCC:
	.word WifiRamBase	; 02307DCC
pool_02307DD0:
loc_02307DD0:
	.word 0x04805F60	; 02307DD0
pool_02307DD4:
loc_02307DD4:
	.word 0x00000396	; 02307DD4
pool_02307DD8:
loc_02307DD8:
	.word 0x00000400	; 02307DD8
pool_02307DDC:
loc_02307DDC:
	.word 0x00000FB0	; 02307DDC
pool_02307DE0:
loc_02307DE0:
	.word 0x0000092C	; 02307DE0
pool_02307DE4:
loc_02307DE4:
	.word 0x0000FFFF	; 02307DE4
pool_02307DE8:
loc_02307DE8:
	.word 0x000003B0	; 02307DE8
pool_02307DEC:
loc_02307DEC:
	.word 0x0000061C	; 02307DEC
pool_02307DF0:
loc_02307DF0:
	.word 0x04805F5A	; 02307DF0
pool_02307DF4:
loc_02307DF4:
	.word 0x00007C00	; 02307DF4
pool_02307DF8:
loc_02307DF8:
	.word 0x00000FFF	; 02307DF8
pool_02307DFC:
loc_02307DFC:
	.word 0x00000560	; 02307DFC
pool_02307E00:
loc_02307E00:
	.word REG_WIFI_RXBUF_READCSR	; 02307E00

; ===== function loc_02307E04 =====
loc_02307E04:
	push {r4,r5,r6,r7,lr}	; 02307E04
	sub sp,#0x4	; 02307E06
	ldr r2,[pool_02307F7C]	; 02307E08
	ldr r1,[r2,#0x0]	; 02307E0A
	ldr r0,[pool_02307F80]	; 02307E0C
	add r5,r1,r0	; 02307E0E
	mov r1,#0x2	; 02307E10
	ldr r0,[pool_02307F84]	; 02307E12
	strh r1,[r0,#0x0]	; 02307E14
	ldr r0,[r2,#0x0]	; 02307E16
	ldr r2,[pool_02307F88]	; 02307E18
	ldrh r2,[r0,r2]	; 02307E1A
	cmp r2,#0x12	; 02307E1C
	bne loc_02307E26	; 02307E1E
	bl loc_0230ACB0	; 02307E20
	b loc_02307F74	; 02307E24
loc_02307E26:
	ldr r2,[pool_02307F8C]	; 02307E26
	ldrh r4,[r2,#0x0]	; 02307E28
	ldr r2,[pool_02307F90]	; 02307E2A
	and r4,r2	; 02307E2C
	ldr r2,[pool_02307F94]	; 02307E2E
	cmp r4,r2	; 02307E30
	beq loc_02307E42	; 02307E32
	ldr r2,[pool_02307F98]	; 02307E34
	cmp r4,r2	; 02307E36
	beq loc_02307E68	; 02307E38
	ldr r1,[pool_02307F9C]	; 02307E3A
	cmp r4,r1	; 02307E3C
	beq loc_02307E9A	; 02307E3E
	b loc_02307F12	; 02307E40
loc_02307E42:
	add r5,#0x8c	; 02307E42
	ldr r0,[r5,#0x0]	; 02307E44
	and r0,r1	; 02307E46
	cmp r0,#0x0	; 02307E48
	beq loc_02307E50	; 02307E4A
	bl loc_0230788C	; 02307E4C
loc_02307E50:
	ldr r0,[pool_02307F7C]	; 02307E50
	ldr r1,[r0,#0x0]	; 02307E52
	ldr r0,[pool_02307FA0]	; 02307E54
	add r1,r1,r0	; 02307E56
	ldr r0,[r1,#0x0]	; 02307E58
	add r0,r0,#0x1	; 02307E5A
	str r0,[r1,#0x0]	; 02307E5C
	mov r0,#0x0	; 02307E5E
	mov r1,#0x8	; 02307E60
	bl loc_02304B68	; 02307E62
	b loc_02307F12	; 02307E66
loc_02307E68:
	add r0,r5,#0x0	; 02307E68
	add r0,#0x9e	; 02307E6A
	ldrh r0,[r0,#0x0]	; 02307E6C
	ldr r2,[r5,#0x44]	; 02307E6E
	ldrh r3,[r2,#0x4]	; 02307E70
	mov r2,#0xff	; 02307E72
	and r3,r2	; 02307E74
	lsl r2,r3,#0x10	; 02307E76
	lsr r2,r2,#0x10	; 02307E78
	cmp r0,r2	; 02307E7A
	bhi loc_02307E8C	; 02307E7C
	ldr r0,[pool_02307FA4]	; 02307E7E
	strh r1,[r0,#0x0]	; 02307E80
	add r1,r5,#0x0	; 02307E82
	add r1,#0xaa	; 02307E84
	ldrh r0,[r1,#0x0]	; 02307E86
	add r0,r0,#0x1	; 02307E88
	strh r0,[r1,#0x0]	; 02307E8A
loc_02307E8C:
	add r5,#0x90	; 02307E8C
	ldr r1,[r5,#0x0]	; 02307E8E
	add r1,#0x18	; 02307E90
	ldrh r0,[r1,#0x0]	; 02307E92
	add r0,r0,#0x1	; 02307E94
	strh r0,[r1,#0x0]	; 02307E96
	b loc_02307F12	; 02307E98
loc_02307E9A:
	add r1,r5,#0x0	; 02307E9A
	add r1,#0x98	; 02307E9C
	ldrh r3,[r1,#0x0]	; 02307E9E
	ldr r1,[r5,#0x44]	; 02307EA0
	ldrh r2,[r1,#0x2]	; 02307EA2
	add r1,r5,#0x0	; 02307EA4
	add r1,#0x90	; 02307EA6
	ldr r1,[r1,#0x0]	; 02307EA8
	add r1,#0x1a	; 02307EAA
	cmp r2,#0x1	; 02307EAC
	bls loc_02307ED0	; 02307EAE
	ldr r6,[pool_02307FA8]	; 02307EB0
	ldrh r0,[r0,r6]	; 02307EB2
	lsl r0,r0,#0x1b	; 02307EB4
	lsr r0,r0,#0x1f	; 02307EB6
	cmp r0,#0x0	; 02307EB8
	beq loc_02307ED0	; 02307EBA
	ldr r0,[pool_02307FAC]	; 02307EBC
	ldrh r0,[r0,#0x0]	; 02307EBE
	mov r7,#0x1	; 02307EC0
	and r0,r7	; 02307EC2
	cmp r0,#0x0	; 02307EC4
	bne loc_02307ED0	; 02307EC6
	ldr r6,[pool_02307FB0]	; 02307EC8
	ldrh r0,[r6,#0x0]	; 02307ECA
	eor r0,r7	; 02307ECC
	strh r0,[r6,#0x0]	; 02307ECE
loc_02307ED0:
	ldr r0,[pool_02307F7C]	; 02307ED0
	ldr r6,[r0,#0x0]	; 02307ED2
	ldr r0,[pool_02307FB4]	; 02307ED4
	ldrh r6,[r6,r0]	; 02307ED6
	mov r0,#0x40	; 02307ED8
	and r6,r0	; 02307EDA
	cmp r6,#0x0	; 02307EDC
	beq loc_02307F12	; 02307EDE
	mov r7,#0x1	; 02307EE0
	b loc_02307F0E	; 02307EE2
loc_02307EE4:
	lsl r0,r2,#0xf	; 02307EE4
	lsr r2,r0,#0x10	; 02307EE6
	add r0,r2,#0x0	; 02307EE8
	and r0,r7	; 02307EEA
	cmp r0,#0x0	; 02307EEC
	beq loc_02307EF8	; 02307EEE
	add r0,r1,#0x6	; 02307EF0
	ldrh r6,[r0,#0x0]	; 02307EF2
	add r6,r6,#0x1	; 02307EF4
	strh r6,[r0,#0x0]	; 02307EF6
loc_02307EF8:
	lsl r0,r3,#0xf	; 02307EF8
	lsr r3,r0,#0x10	; 02307EFA
	add r0,r3,#0x0	; 02307EFC
	and r0,r7	; 02307EFE
	cmp r0,#0x0	; 02307F00
	beq loc_02307F0E	; 02307F02
	add r0,r5,#0x0	; 02307F04
	add r0,#0x90	; 02307F06
	ldr r0,[r0,#0x0]	; 02307F08
	ldrh r0,[r0,#0x16]	; 02307F0A
	add r1,r1,r0	; 02307F0C
loc_02307F0E:
	cmp r2,#0x1	; 02307F0E
	bhi loc_02307EE4	; 02307F10
loc_02307F12:
	ldr r0,[pool_02307F98]	; 02307F12
	cmp r4,r0	; 02307F14
	beq loc_02307F6C	; 02307F16
	ldr r0,[pool_02307FB8]	; 02307F18
	ldrh r1,[r0,#0x0]	; 02307F1A
	mov r0,#0x2	; 02307F1C
	and r1,r0	; 02307F1E
	cmp r1,#0x0	; 02307F20
	bne loc_02307F6C	; 02307F22
	ldr r1,[pool_02307F7C]	; 02307F24
	ldr r3,[r1,#0x0]	; 02307F26
	ldr r2,[pool_02307FBC]	; 02307F28
	ldrh r2,[r3,r2]	; 02307F2A
	cmp r2,#0x0	; 02307F2C
	beq loc_02307F66	; 02307F2E
	ldr r2,[pool_02307FC0]	; 02307F30
	strh r0,[r2,#0x0]	; 02307F32
	mov r3,#0x0	; 02307F34
	ldr r2,[pool_02307FC4]	; 02307F36
	strh r3,[r2,#0x0]	; 02307F38
	ldr r2,[pool_02307F84]	; 02307F3A
	ldrh r3,[r2,#0x0]	; 02307F3C
	ldr r2,[pool_02307FC8]	; 02307F3E
	and r3,r2	; 02307F40
	cmp r3,#0x0	; 02307F42
	bne loc_02307F4C	; 02307F44
	bl loc_02307B58	; 02307F46
	b loc_02307F58	; 02307F4A
loc_02307F4C:
	ldr r1,[r1,#0x0]	; 02307F4C
	ldr r0,[pool_02307FCC]	; 02307F4E
	add r1,r1,r0	; 02307F50
	ldrh r0,[r1,#0x0]	; 02307F52
	add r0,r0,#0x1	; 02307F54
	strh r0,[r1,#0x0]	; 02307F56
loc_02307F58:
	ldr r0,[pool_02307F7C]	; 02307F58
	ldr r1,[r0,#0x0]	; 02307F5A
	ldr r0,[pool_02307FD0]	; 02307F5C
	add r1,r1,r0	; 02307F5E
	ldrh r0,[r1,#0x0]	; 02307F60
	add r0,r0,#0x1	; 02307F62
	strh r0,[r1,#0x0]	; 02307F64
loc_02307F66:
	mov r1,#0x2	; 02307F66
	ldr r0,[pool_02307FD4]	; 02307F68
	strh r1,[r0,#0x0]	; 02307F6A
loc_02307F6C:
	mov r0,#0x0	; 02307F6C
	mov r1,#0xe	; 02307F6E
	bl loc_02304B68	; 02307F70
loc_02307F74:
	add sp,#0x4	; 02307F74
	pop {r4,r5,r6,r7}	; 02307F76
	pop {r3}	; 02307F78
	bx r3	; 02307F7A
pool_02307F7C:
loc_02307F7C:
	.word FirmwareWlWorkPointerSlot	; 02307F7C
pool_02307F80:
loc_02307F80:
	.word 0x000003E4	; 02307F80
pool_02307F84:
loc_02307F84:
	.word REG_WIFI_IF	; 02307F84
pool_02307F88:
loc_02307F88:
	.word 0x00000310	; 02307F88
pool_02307F8C:
loc_02307F8C:
	.word REG_WIFI_TXSTAT	; 02307F8C
pool_02307F90:
loc_02307F90:
	.word 0x00000F00	; 02307F90
pool_02307F94:
loc_02307F94:
	.word 0x00000300	; 02307F94
pool_02307F98:
loc_02307F98:
	.word 0x00000800	; 02307F98
pool_02307F9C:
loc_02307F9C:
	.word 0x00000B00	; 02307F9C
pool_02307FA0:
loc_02307FA0:
	.word 0x00000510	; 02307FA0
pool_02307FA4:
loc_02307FA4:
	.word REG_WIFI_TXREQ_RESET	; 02307FA4
pool_02307FA8:
loc_02307FA8:
	.word 0x000002FE	; 02307FA8
pool_02307FAC:
loc_02307FAC:
	.word REG_WIFI_RF_PINS	; 02307FAC
pool_02307FB0:
loc_02307FB0:
	.word REG_WIFI_UNKNOWN_290	; 02307FB0
pool_02307FB4:
loc_02307FB4:
	.word 0x0000061C	; 02307FB4
pool_02307FB8:
loc_02307FB8:
	.word REG_WIFI_TXREQ_READ	; 02307FB8
pool_02307FBC:
loc_02307FBC:
	.word 0x00000420	; 02307FBC
pool_02307FC0:
loc_02307FC0:
	.word REG_WIFI_TXBUF_RESET	; 02307FC0
pool_02307FC4:
loc_02307FC4:
	.word REG_WIFI_UNKNOWN_048	; 02307FC4
pool_02307FC8:
loc_02307FC8:
	.word 0x00001000	; 02307FC8
pool_02307FCC:
loc_02307FCC:
	.word 0x00000492	; 02307FCC
pool_02307FD0:
loc_02307FD0:
	.word 0x00000490	; 02307FD0
pool_02307FD4:
loc_02307FD4:
	.word REG_WIFI_TXREQ_SET	; 02307FD4

; ===== function loc_02307FD8 =====
loc_02307FD8:
	push {r4,r5,lr}	; 02307FD8
	sub sp,#0x4	; 02307FDA
	mov r1,#0x4	; 02307FDC
	ldr r0,[pool_023080E8]	; 02307FDE
	strh r1,[r0,#0x0]	; 02307FE0
	ldr r0,[pool_023080EC]	; 02307FE2
	ldrh r3,[r0,#0x0]	; 02307FE4
	ldr r0,[pool_023080F0]	; 02307FE6
	ldr r0,[r0,#0x0]	; 02307FE8
	ldr r1,[pool_023080F4]	; 02307FEA
	ldrh r2,[r0,r1]	; 02307FEC
	mov r1,#0x8	; 02307FEE
	and r2,r1	; 02307FF0
	cmp r2,#0x0	; 02307FF2
	beq loc_02308080	; 02307FF4
	ldr r1,[pool_023080F8]	; 02307FF6
	add r2,r3,#0x0	; 02307FF8
	and r2,r1	; 02307FFA
	cmp r2,#0x0	; 02307FFC
	beq loc_02308080	; 02307FFE
	ldr r1,[pool_023080FC]	; 02308000
	add r2,r0,r1	; 02308002
	ldr r1,[pool_02308100]	; 02308004
	ldrh r1,[r1,#0x0]	; 02308006
	mov r4,#0x1	; 02308008
	add r5,r1,#0x0	; 0230800A
	and r5,r4	; 0230800C
	cmp r5,#0x0	; 0230800E
	beq loc_02308018	; 02308010
	ldrh r4,[r2,#0x0]	; 02308012
	cmp r4,#0x0	; 02308014
	bne loc_02308056	; 02308016
loc_02308018:
	mov r4,#0x4	; 02308018
	add r5,r1,#0x0	; 0230801A
	and r5,r4	; 0230801C
	cmp r5,#0x0	; 0230801E
	beq loc_02308028	; 02308020
	ldrh r4,[r2,#0x14]	; 02308022
	cmp r4,#0x0	; 02308024
	bne loc_02308056	; 02308026
loc_02308028:
	mov r4,#0x8	; 02308028
	and r1,r4	; 0230802A
	cmp r1,#0x0	; 0230802C
	beq loc_02308036	; 0230802E
	ldrh r1,[r2,#0x28]	; 02308030
	cmp r1,#0x0	; 02308032
	bne loc_02308056	; 02308034
loc_02308036:
	ldr r1,[pool_02308104]	; 02308036
	ldrh r2,[r1,#0x0]	; 02308038
	mov r1,#0x1	; 0230803A
	and r2,r1	; 0230803C
	cmp r2,#0x0	; 0230803E
	bne loc_02308056	; 02308040
	mov r2,#0x0	; 02308042
	ldr r1,[pool_02308108]	; 02308044
	strh r2,[r1,#0x0]	; 02308046
	ldr r0,[pool_0230810C]	; 02308048
	strh r0,[r1,#0x0]	; 0230804A
	ldr r0,[pool_023080F0]	; 0230804C
	ldr r1,[r0,#0x0]	; 0230804E
	ldr r0,[pool_02308110]	; 02308050
	strh r2,[r1,r0]	; 02308052
	b loc_02308080	; 02308054
loc_02308056:
	ldr r1,[pool_02308110]	; 02308056
	add r2,r0,r1	; 02308058
	ldrh r4,[r2,#0x0]	; 0230805A
	add r0,r4,#0x1	; 0230805C
	strh r0,[r2,#0x0]	; 0230805E
	cmp r4,#0xc	; 02308060
	bls loc_02308080	; 02308062
	mov r4,#0x0	; 02308064
	ldr r2,[pool_023080F0]	; 02308066
	ldr r0,[r2,#0x0]	; 02308068
	strh r4,[r0,r1]	; 0230806A
	ldr r1,[pool_02308108]	; 0230806C
	strh r4,[r1,#0x0]	; 0230806E
	ldr r0,[pool_0230810C]	; 02308070
	strh r0,[r1,#0x0]	; 02308072
	ldr r1,[r2,#0x0]	; 02308074
	ldr r0,[pool_02308114]	; 02308076
	add r1,r1,r0	; 02308078
	ldrh r0,[r1,#0x0]	; 0230807A
	add r0,r0,#0x1	; 0230807C
	strh r0,[r1,#0x0]	; 0230807E
loc_02308080:
	ldr r0,[pool_023080F0]	; 02308080
	ldr r1,[r0,#0x0]	; 02308082
	ldr r0,[pool_023080F4]	; 02308084
	ldrh r1,[r1,r0]	; 02308086
	mov r0,#0x1	; 02308088
	and r1,r0	; 0230808A
	cmp r1,#0x0	; 0230808C
	beq loc_023080E0	; 0230808E
	mov r0,#0x60	; 02308090
	and r3,r0	; 02308092
	cmp r3,#0x0	; 02308094
	beq loc_023080E0	; 02308096
	ldr r0,[pool_02308118]	; 02308098
	ldrh r4,[r0,#0x0]	; 0230809A
	ldr r0,[pool_0230811C]	; 0230809C
	ldrh r1,[r0,#0x0]	; 0230809E
	ldr r0,[pool_02308120]	; 023080A0
	sub r0,r1,r0	; 023080A2
	mov r1,#0x2	; 023080A4
	bl loc_0230813C	; 023080A6
	cmp r4,r0	; 023080AA
	bge loc_023080C0	; 023080AC
	ldr r0,[pool_02308124]	; 023080AE
	ldrh r1,[r0,#0x0]	; 023080B0
	ldr r0,[pool_02308120]	; 023080B2
	sub r0,r1,r0	; 023080B4
	mov r1,#0x2	; 023080B6
	bl loc_02308148	; 023080B8
	cmp r4,r0	; 023080BC
	bge loc_023080DC	; 023080BE
loc_023080C0:
	ldr r0,[pool_02308128]	; 023080C0
	ldrh r1,[r0,#0x0]	; 023080C2
	ldr r0,[pool_0230812C]	; 023080C4
	strh r1,[r0,#0x0]	; 023080C6
	ldr r1,[pool_02308130]	; 023080C8
	ldr r0,[pool_02308134]	; 023080CA
	strh r1,[r0,#0x0]	; 023080CC
	ldr r0,[pool_023080F0]	; 023080CE
	ldr r1,[r0,#0x0]	; 023080D0
	ldr r0,[pool_02308138]	; 023080D2
	add r1,r1,r0	; 023080D4
	ldrh r0,[r1,#0x0]	; 023080D6
	add r0,r0,#0x1	; 023080D8
	strh r0,[r1,#0x0]	; 023080DA
loc_023080DC:
	bl loc_02305168	; 023080DC
loc_023080E0:
	add sp,#0x4	; 023080E0
	pop {r4,r5}	; 023080E2
	pop {r3}	; 023080E4
	bx r3	; 023080E6
pool_023080E8:
loc_023080E8:
	.word REG_WIFI_IF	; 023080E8
pool_023080EC:
loc_023080EC:
	.word REG_WIFI_RXSTAT_INC_IF	; 023080EC
pool_023080F0:
loc_023080F0:
	.word FirmwareWlWorkPointerSlot	; 023080F0
pool_023080F4:
loc_023080F4:
	.word 0x0000061C	; 023080F4
pool_023080F8:
loc_023080F8:
	.word 0x00000400	; 023080F8
pool_023080FC:
loc_023080FC:
	.word 0x000003E4	; 023080FC
pool_02308100:
loc_02308100:
	.word REG_WIFI_TXREQ_READ	; 02308100
pool_02308104:
loc_02308104:
	.word REG_WIFI_RF_PINS	; 02308104
pool_02308108:
loc_02308108:
	.word REG_WIFI_WEP_CNT	; 02308108
pool_0230810C:
loc_0230810C:
	.word 0x00008000	; 0230810C
pool_02308110:
loc_02308110:
	.word 0x0000049A	; 02308110
pool_02308114:
loc_02308114:
	.word 0x000003B6	; 02308114
pool_02308118:
loc_02308118:
	.word REG_WIFI_RXBUF_WRCSR	; 02308118
pool_0230811C:
loc_0230811C:
	.word REG_WIFI_RXBUF_END	; 0230811C
pool_02308120:
loc_02308120:
	.word 0x00004000	; 02308120
pool_02308124:
loc_02308124:
	.word REG_WIFI_RXBUF_BEGIN	; 02308124
pool_02308128:
loc_02308128:
	.word REG_WIFI_RXBUF_READCSR	; 02308128
pool_0230812C:
loc_0230812C:
	.word REG_WIFI_RXBUF_WR_ADDR	; 0230812C
pool_02308130:
loc_02308130:
	.word 0x00008001	; 02308130
pool_02308134:
loc_02308134:
	.word REG_WIFI_RXCNT	; 02308134
pool_02308138:
loc_02308138:
	.word 0x00000496	; 02308138

; ===== function loc_0230813C =====
loc_0230813C:
	bx pc	; 0230813C
	.byte 0xC0, 0x46	; 02308140
.arm

; ===== function loc_02308140 =====
loc_02308140:
	ldr pc,[pool_02308144]	; 02308140
pool_02308144:
loc_02308144:
	.word loc_03802514	; 02308144
.thumb

; ===== function loc_02308148 =====
loc_02308148:
	bx pc	; 02308148
	.byte 0xC0, 0x46	; 0230814C
.arm

; ===== function loc_0230814C =====
loc_0230814C:
	ldr pc,[pool_02308150]	; 0230814C
pool_02308150:
loc_02308150:
	.word loc_03802514	; 02308150
.thumb

; ===== function loc_02308154 =====
loc_02308154:
	push {r4,r5,r6,r7,lr}	; 02308154
	sub sp,#0x4	; 02308156
	mov r1,#0x8	; 02308158
	ldr r0,[pool_02308204]	; 0230815A
	strh r1,[r0,#0x0]	; 0230815C
	ldr r0,[pool_02308208]	; 0230815E
	ldr r1,[r0,#0x0]	; 02308160
	ldr r0,[pool_0230820C]	; 02308162
	ldrh r0,[r1,r0]	; 02308164
	lsl r0,r0,#0x1b	; 02308166
	lsr r0,r0,#0x1f	; 02308168
	cmp r0,#0x0	; 0230816A
	beq loc_02308182	; 0230816C
	ldr r0,[pool_02308210]	; 0230816E
	ldrh r1,[r0,#0x0]	; 02308170
	mov r0,#0x1	; 02308172
	and r1,r0	; 02308174
	cmp r1,#0x0	; 02308176
	bne loc_02308182	; 02308178
	ldr r2,[pool_02308214]	; 0230817A
	ldrh r1,[r2,#0x0]	; 0230817C
	eor r1,r0	; 0230817E
	strh r1,[r2,#0x0]	; 02308180
loc_02308182:
	ldr r5,[pool_02308208]	; 02308182
	ldr r1,[r5,#0x0]	; 02308184
	ldr r0,[pool_02308218]	; 02308186
	ldrh r1,[r1,r0]	; 02308188
	mov r0,#0x8	; 0230818A
	and r1,r0	; 0230818C
	cmp r1,#0x0	; 0230818E
	beq loc_023081FA	; 02308190
	mov r6,#0x0	; 02308192
	add r2,r6,#0x0	; 02308194
	ldr r1,[pool_0230821C]	; 02308196
	ldr r0,[pool_02308220]	; 02308198
loc_0230819A:
	ldr r7,[r5,#0x0]	; 0230819A
	add r4,r6,#0x0	; 0230819C
	mov r3,#0x14	; 0230819E
	mul r4,r3	; 023081A0
	add r3,r7,r4	; 023081A2
	ldr r4,[pool_02308224]	; 023081A4
	ldrh r4,[r3,r4]	; 023081A6
	cmp r4,#0x0	; 023081A8
	beq loc_023081F4	; 023081AA
	ldr r4,[pool_02308228]	; 023081AC
	ldr r4,[r3,r4]	; 023081AE
	ldrh r7,[r4,#0xc]	; 023081B0
	ldr r3,[pool_0230822C]	; 023081B2
	and r7,r3	; 023081B4
	cmp r7,#0x0	; 023081B6
	beq loc_023081F4	; 023081B8
	ldrh r7,[r4,#0x4]	; 023081BA
	mov r3,#0xff	; 023081BC
	and r7,r3	; 023081BE
	lsl r3,r7,#0x10	; 023081C0
	lsr r3,r3,#0x10	; 023081C2
	cmp r3,#0x0	; 023081C4
	beq loc_023081F4	; 023081C6
	add r7,r4,#0x0	; 023081C8
	add r7,#0xc	; 023081CA
	ldrh r3,[r4,#0xa]	; 023081CC
	add r3,r7,r3	; 023081CE
	sub r3,r3,#0x7	; 023081D0
	mov r7,#0x1	; 023081D2
	bic r3,r7	; 023081D4
	ldrh r7,[r3,#0x0]	; 023081D6
	cmp r7,#0x0	; 023081D8
	bne loc_023081F4	; 023081DA
	ldrh r3,[r3,#0x2]	; 023081DC
	cmp r3,#0x0	; 023081DE
	bne loc_023081F4	; 023081E0
	strh r2,[r4,#0x4]	; 023081E2
	strh r2,[r1,#0x0]	; 023081E4
	strh r0,[r1,#0x0]	; 023081E6
	ldr r4,[r5,#0x0]	; 023081E8
	ldr r3,[pool_02308230]	; 023081EA
	add r4,r4,r3	; 023081EC
	ldrh r3,[r4,#0x0]	; 023081EE
	add r3,r3,#0x1	; 023081F0
	strh r3,[r4,#0x0]	; 023081F2
loc_023081F4:
	add r6,r6,#0x1	; 023081F4
	cmp r6,#0x3	; 023081F6
	bcc loc_0230819A	; 023081F8
loc_023081FA:
	add sp,#0x4	; 023081FA
	pop {r4,r5,r6,r7}	; 023081FC
	pop {r3}	; 023081FE
	bx r3	; 02308200
	.byte 0xC0, 0x46	; 02308204
pool_02308204:
loc_02308204:
	.word REG_WIFI_IF	; 02308204
pool_02308208:
loc_02308208:
	.word FirmwareWlWorkPointerSlot	; 02308208
pool_0230820C:
loc_0230820C:
	.word 0x000002FE	; 0230820C
pool_02308210:
loc_02308210:
	.word REG_WIFI_RF_PINS	; 02308210
pool_02308214:
loc_02308214:
	.word REG_WIFI_UNKNOWN_290	; 02308214
pool_02308218:
loc_02308218:
	.word 0x0000061C	; 02308218
pool_0230821C:
loc_0230821C:
	.word REG_WIFI_WEP_CNT	; 0230821C
pool_02308220:
loc_02308220:
	.word 0x00008000	; 02308220
pool_02308224:
loc_02308224:
	.word 0x000003E4	; 02308224
pool_02308228:
loc_02308228:
	.word 0x000003EC	; 02308228
pool_0230822C:
loc_0230822C:
	.word 0x00004000	; 0230822C
pool_02308230:
loc_02308230:
	.word 0x000003B6	; 02308230

; ===== function loc_02308234 =====
loc_02308234:
	push {lr}	; 02308234
	sub sp,#0x4	; 02308236
	bl loc_0230616C	; 02308238
	ldr r1,[pool_02308250]	; 0230823C
	ldr r0,[pool_02308254]	; 0230823E
	strh r1,[r0,#0x0]	; 02308240
	mov r1,#0x10	; 02308242
	ldr r0,[pool_02308258]	; 02308244
	strh r1,[r0,#0x0]	; 02308246
	add sp,#0x4	; 02308248
	pop {r3}	; 0230824A
	bx r3	; 0230824C
	.byte 0xC0, 0x46	; 02308250
pool_02308250:
loc_02308250:
	.word 0x0000FFFF	; 02308250
pool_02308254:
loc_02308254:
	.word REG_WIFI_RXSTAT_OVF_IF	; 02308254
pool_02308258:
loc_02308258:
	.word REG_WIFI_IF	; 02308258

; ===== function loc_0230825C =====
loc_0230825C:
	push {lr}	; 0230825C
	sub sp,#0x4	; 0230825E
	bl loc_0230616C	; 02308260
	ldr r1,[pool_02308278]	; 02308264
	ldr r0,[pool_0230827C]	; 02308266
	strh r1,[r0,#0x0]	; 02308268
	mov r1,#0x20	; 0230826A
	ldr r0,[pool_02308280]	; 0230826C
	strh r1,[r0,#0x0]	; 0230826E
	add sp,#0x4	; 02308270
	pop {r3}	; 02308272
	bx r3	; 02308274
	.byte 0xC0, 0x46	; 02308278
pool_02308278:
loc_02308278:
	.word 0x0000FFFF	; 02308278
pool_0230827C:
loc_0230827C:
	.word REG_WIFI_RXSTAT_OVF_IF	; 0230827C
pool_02308280:
loc_02308280:
	.word REG_WIFI_IF	; 02308280

; ===== function loc_02308284 =====
loc_02308284:
	ldr r1,[pool_0230828C]	; 02308284
	ldr r0,[pool_02308290]	; 02308286
	strh r1,[r0,#0x0]	; 02308288
	bx lr	; 0230828A
pool_0230828C:
loc_0230828C:
	.word 0x00000800	; 0230828C
pool_02308290:
loc_02308290:
	.word REG_WIFI_IF	; 02308290

; ===== function loc_02308294 =====
loc_02308294:
	ldr r1,[pool_023082D4]	; 02308294
	ldr r0,[pool_023082D8]	; 02308296
	strh r1,[r0,#0x0]	; 02308298
	mov r1,#0xd	; 0230829A
	ldr r0,[pool_023082DC]	; 0230829C
	strh r1,[r0,#0x0]	; 0230829E
	ldr r0,[pool_023082E0]	; 023082A0
	ldr r0,[r0,#0x0]	; 023082A2
	ldr r1,[pool_023082E4]	; 023082A4
	add r1,r0,r1	; 023082A6
	ldrh r2,[r1,#0x0]	; 023082A8
	lsl r3,r2,#0x19	; 023082AA
	lsr r3,r3,#0x1f	; 023082AC
	cmp r3,#0x0	; 023082AE
	beq loc_023082BA	; 023082B0
	mov r0,#0x40	; 023082B2
	bic r2,r0	; 023082B4
	strh r2,[r1,#0x0]	; 023082B6
	bx lr	; 023082B8
loc_023082BA:
	ldr r1,[pool_023082E8]	; 023082BA
	ldrh r1,[r0,r1]	; 023082BC
	cmp r1,#0x2	; 023082BE
	bne loc_023082D0	; 023082C0
	ldr r1,[pool_023082EC]	; 023082C2
	ldrh r0,[r0,r1]	; 023082C4
	cmp r0,#0x40	; 023082C6
	beq loc_023082D0	; 023082C8
	mov r1,#0x0	; 023082CA
	ldr r0,[pool_023082F0]	; 023082CC
	strh r1,[r0,#0x0]	; 023082CE
loc_023082D0:
	bx lr	; 023082D0
	.byte 0xC0, 0x46	; 023082D4
pool_023082D4:
loc_023082D4:
	.word 0x00002000	; 023082D4
pool_023082D8:
loc_023082D8:
	.word REG_WIFI_IF	; 023082D8
pool_023082DC:
loc_023082DC:
	.word REG_WIFI_TXREQ_RESET	; 023082DC
pool_023082E0:
loc_023082E0:
	.word FirmwareWlWorkPointerSlot	; 023082E0
pool_023082E4:
loc_023082E4:
	.word 0x00000316	; 023082E4
pool_023082E8:
loc_023082E8:
	.word 0x00000314	; 023082E8
pool_023082EC:
loc_023082EC:
	.word 0x00000310	; 023082EC
pool_023082F0:
loc_023082F0:
	.word REG_WIFI_UNKNOWN_048	; 023082F0

; ===== function loc_023082F4 =====
loc_023082F4:
	push {r4,r5,r6,r7,lr}	; 023082F4
	sub sp,#0x4	; 023082F6
	ldr r0,[pool_023084E4]	; 023082F8
	ldr r2,[r0,#0x0]	; 023082FA
	ldr r1,[pool_023084E8]	; 023082FC
	add r5,r2,r1	; 023082FE
	ldr r1,[pool_023084EC]	; 02308300
	add r7,r2,r1	; 02308302
	ldr r2,[pool_023084F0]	; 02308304
	ldr r1,[pool_023084F4]	; 02308306
	strh r2,[r1,#0x0]	; 02308308
	ldrh r1,[r5,#0xc]	; 0230830A
	cmp r1,#0x1	; 0230830C
	beq loc_0230831A	; 0230830E
	cmp r1,#0x2	; 02308310
	beq loc_023083B2	; 02308312
	cmp r1,#0x3	; 02308314
	beq loc_023083D4	; 02308316
	b loc_023084DA	; 02308318
loc_0230831A:
	ldr r1,[r0,#0x0]	; 0230831A
	ldr r0,[pool_023084F8]	; 0230831C
	ldr r1,[r1,r0]	; 0230831E
	add r1,#0x24	; 02308320
	add r0,r5,#0x0	; 02308322
	add r0,#0x8a	; 02308324
	ldrh r0,[r0,#0x0]	; 02308326
	add r4,r1,r0	; 02308328
	add r4,#0x8	; 0230832A
	ldr r0,[pool_023084FC]	; 0230832C
	ldrh r6,[r0,#0x0]	; 0230832E
	add r0,r4,#0x0	; 02308330
	lsl r1,r6,#0x18	; 02308332
	lsr r1,r1,#0x18	; 02308334
	bl loc_023053D8	; 02308336
	add r0,r4,#0x1	; 0230833A
	lsr r1,r6,#0x8	; 0230833C
	lsl r1,r1,#0x18	; 0230833E
	lsr r1,r1,#0x18	; 02308340
	bl loc_023053D8	; 02308342
	ldrh r0,[r5,#0xe]	; 02308346
	lsl r0,r0,#0x1f	; 02308348
	lsr r0,r0,#0x1f	; 0230834A
	cmp r0,#0x1	; 0230834C
	bne loc_02308362	; 0230834E
	ldr r0,[pool_023084E4]	; 02308350
	ldr r1,[r0,#0x0]	; 02308352
	ldr r0,[pool_02308500]	; 02308354
	ldrh r2,[r1,r0]	; 02308356
	ldr r1,[pool_02308504]	; 02308358
	ldrh r0,[r1,#0x0]	; 0230835A
	add r0,r2,r0	; 0230835C
	add r0,r0,#0x1	; 0230835E
	strh r0,[r1,#0x0]	; 02308360
loc_02308362:
	ldr r1,[pool_023084E4]	; 02308362
	ldr r0,[r1,#0x0]	; 02308364
	ldr r2,[pool_02308508]	; 02308366
	ldrh r2,[r0,r2]	; 02308368
	mvn r3,r2	; 0230836A
	ldr r2,[pool_0230850C]	; 0230836C
	ldrh r2,[r0,r2]	; 0230836E
	orr r3,r2	; 02308370
	ldr r2,[pool_02308510]	; 02308372
	strh r3,[r0,r2]	; 02308374
	ldr r0,[pool_02308514]	; 02308376
	ldrh r3,[r0,#0x0]	; 02308378
	mov r0,#0x18	; 0230837A
	add r2,r3,#0x0	; 0230837C
	and r2,r0	; 0230837E
	cmp r2,#0x0	; 02308380
	bne loc_0230838C	; 02308382
	mov r0,#0x6	; 02308384
	and r3,r0	; 02308386
	cmp r3,#0x2	; 02308388
	bne loc_023083A2	; 0230838A
loc_0230838C:
	ldr r0,[pool_023084E4]	; 0230838C
	ldr r1,[r0,#0x0]	; 0230838E
	ldr r0,[pool_02308518]	; 02308390
	add r2,r1,r0	; 02308392
	ldr r1,[r2,#0x0]	; 02308394
	mov r0,#0x2	; 02308396
	bic r1,r0	; 02308398
	str r1,[r2,#0x0]	; 0230839A
	bl loc_0230788C	; 0230839C
	b loc_023084DA	; 023083A0
loc_023083A2:
	ldr r1,[r1,#0x0]	; 023083A2
	ldr r0,[pool_02308518]	; 023083A4
	add r2,r1,r0	; 023083A6
	ldr r1,[r2,#0x0]	; 023083A8
	mov r0,#0x2	; 023083AA
	orr r1,r0	; 023083AC
	str r1,[r2,#0x0]	; 023083AE
	b loc_023084DA	; 023083B0
loc_023083B2:
	ldrh r1,[r5,#0xe]	; 023083B2
	lsl r1,r1,#0x1d	; 023083B4
	lsr r1,r1,#0x1f	; 023083B6
	cmp r1,#0x0	; 023083B8
	beq loc_023083CE	; 023083BA
	ldr r1,[r0,#0x0]	; 023083BC
	ldr r0,[pool_02308500]	; 023083BE
	ldrh r2,[r1,r0]	; 023083C0
	ldr r1,[pool_02308504]	; 023083C2
	ldrh r0,[r1,#0x0]	; 023083C4
	add r0,r2,r0	; 023083C6
	add r0,r0,#0x1	; 023083C8
	strh r0,[r1,#0x0]	; 023083CA
	b loc_023083D4	; 023083CC
loc_023083CE:
	ldr r1,[pool_0230851C]	; 023083CE
	ldr r0,[pool_02308504]	; 023083D0
	strh r1,[r0,#0x0]	; 023083D2
loc_023083D4:
	ldrh r0,[r5,#0x8]	; 023083D4
	cmp r0,#0x40	; 023083D6
	beq loc_023083DE	; 023083D8
	mov r0,#0x1	; 023083DA
	b loc_02308410	; 023083DC
loc_023083DE:
	mov r0,#0x0	; 023083DE
	add r1,r5,#0x0	; 023083E0
	add r1,#0x66	; 023083E2
	ldrh r1,[r1,#0x0]	; 023083E4
	cmp r1,#0x1	; 023083E6
	bne loc_023083EC	; 023083E8
	mov r0,#0x1	; 023083EA
loc_023083EC:
	ldrh r1,[r5,#0xe]	; 023083EC
	lsl r1,r1,#0x1c	; 023083EE
	lsr r1,r1,#0x1f	; 023083F0
	cmp r1,#0x0	; 023083F2
	beq loc_02308410	; 023083F4
	add r1,r5,#0x0	; 023083F6
	add r1,#0x6a	; 023083F8
	ldrh r1,[r1,#0x0]	; 023083FA
	cmp r1,#0x1	; 023083FC
	beq loc_0230840E	; 023083FE
	cmp r1,#0x0	; 02308400
	bne loc_02308410	; 02308402
	add r1,r5,#0x0	; 02308404
	add r1,#0x68	; 02308406
	ldrh r1,[r1,#0x0]	; 02308408
	cmp r1,#0x1	; 0230840A
	bne loc_02308410	; 0230840C
loc_0230840E:
	mov r0,#0x1	; 0230840E
loc_02308410:
	cmp r0,#0x0	; 02308410
	beq loc_02308420	; 02308412
	ldr r2,[pool_02308520]	; 02308414
	ldrh r1,[r2,#0x0]	; 02308416
	mov r0,#0x1	; 02308418
	orr r1,r0	; 0230841A
	strh r1,[r2,#0x0]	; 0230841C
	b loc_0230842A	; 0230841E
loc_02308420:
	ldr r2,[pool_02308520]	; 02308420
	ldrh r1,[r2,#0x0]	; 02308422
	mov r0,#0x1	; 02308424
	bic r1,r0	; 02308426
	strh r1,[r2,#0x0]	; 02308428
loc_0230842A:
	ldr r0,[pool_02308524]	; 0230842A
	ldrh r0,[r0,#0x0]	; 0230842C
	cmp r0,#0xa	; 0230842E
	bls loc_02308438	; 02308430
	mov r1,#0x0	; 02308432
	ldr r0,[pool_02308528]	; 02308434
	strh r1,[r0,#0x0]	; 02308436
loc_02308438:
	add r1,r5,#0x0	; 02308438
	add r1,#0x66	; 0230843A
	ldrh r0,[r1,#0x0]	; 0230843C
	sub r0,r0,#0x1	; 0230843E
	strh r0,[r1,#0x0]	; 02308440
	add r0,r5,#0x0	; 02308442
	add r0,#0x66	; 02308444
	ldrh r0,[r0,#0x0]	; 02308446
	cmp r0,#0x0	; 02308448
	bne loc_02308458	; 0230844A
	add r0,r5,#0x0	; 0230844C
	add r0,#0x64	; 0230844E
	ldrh r1,[r0,#0x0]	; 02308450
	add r0,r5,#0x0	; 02308452
	add r0,#0x66	; 02308454
	strh r1,[r0,#0x0]	; 02308456
loc_02308458:
	add r0,r5,#0x0	; 02308458
	add r0,#0x6a	; 0230845A
	ldrh r2,[r0,#0x0]	; 0230845C
	add r1,r5,#0x0	; 0230845E
	add r1,#0x6a	; 02308460
	ldrh r0,[r1,#0x0]	; 02308462
	sub r0,r0,#0x1	; 02308464
	strh r0,[r1,#0x0]	; 02308466
	cmp r2,#0x0	; 02308468
	bne loc_0230847A	; 0230846A
	add r0,r5,#0x0	; 0230846C
	add r0,#0x68	; 0230846E
	ldrh r0,[r0,#0x0]	; 02308470
	sub r1,r0,#0x1	; 02308472
	add r0,r5,#0x0	; 02308474
	add r0,#0x6a	; 02308476
	strh r1,[r0,#0x0]	; 02308478
loc_0230847A:
	mov r4,#0x0	; 0230847A
	str r4,[sp,#0x0]	; 0230847C
loc_0230847E:
	add r1,r4,#0x0	; 0230847E
	mov r0,#0x14	; 02308480
	mul r1,r0	; 02308482
	add r6,r7,r1	; 02308484
	ldrh r0,[r7,r1]	; 02308486
	cmp r0,#0x0	; 02308488
	beq loc_023084CE	; 0230848A
	ldr r0,[r6,#0xc]	; 0230848C
	ldrh r1,[r0,#0x8]	; 0230848E
	cmp r1,#0x0	; 02308490
	bne loc_023084CE	; 02308492
	add r1,r5,#0x0	; 02308494
	add r1,#0x9c	; 02308496
	ldr r1,[r1,#0x0]	; 02308498
	ldrh r0,[r0,#0x4]	; 0230849A
	sub r0,r1,r0	; 0230849C
	lsl r0,r0,#0x10	; 0230849E
	lsr r1,r0,#0x10	; 023084A0
	add r0,r5,#0x0	; 023084A2
	add r0,#0x80	; 023084A4
	ldrh r0,[r0,#0x0]	; 023084A6
	cmp r1,r0	; 023084A8
	bls loc_023084CE	; 023084AA
	add r0,r4,#0x0	; 023084AC
	bl loc_0230CD34	; 023084AE
	ldr r1,[r6,#0x8]	; 023084B2
	mov r0,#0x2	; 023084B4
	strh r0,[r1,#0x0]	; 023084B6
	ldr r0,[sp,#0x0]	; 023084B8
	mov r1,#0xe	; 023084BA
	bl loc_02304B68	; 023084BC
	ldr r0,[pool_023084E4]	; 023084C0
	ldr r1,[r0,#0x0]	; 023084C2
	ldr r0,[pool_0230852C]	; 023084C4
	add r1,r1,r0	; 023084C6
	ldrh r0,[r1,#0x0]	; 023084C8
	add r0,r0,#0x1	; 023084CA
	strh r0,[r1,#0x0]	; 023084CC
loc_023084CE:
	add r4,r4,#0x1	; 023084CE
	cmp r4,#0x2	; 023084D0
	bcc loc_0230847E	; 023084D2
	mov r1,#0xd	; 023084D4
	ldr r0,[pool_02308530]	; 023084D6
	strh r1,[r0,#0x0]	; 023084D8
loc_023084DA:
	add sp,#0x4	; 023084DA
	pop {r4,r5,r6,r7}	; 023084DC
	pop {r3}	; 023084DE
	bx r3	; 023084E0
	.byte 0xC0, 0x46	; 023084E4
pool_023084E4:
loc_023084E4:
	.word FirmwareWlWorkPointerSlot	; 023084E4
pool_023084E8:
loc_023084E8:
	.word 0x00000308	; 023084E8
pool_023084EC:
loc_023084EC:
	.word 0x000003E4	; 023084EC
pool_023084F0:
loc_023084F0:
	.word 0x00004000	; 023084F0
pool_023084F4:
loc_023084F4:
	.word REG_WIFI_IF	; 023084F4
pool_023084F8:
loc_023084F8:
	.word 0x00000464	; 023084F8
pool_023084FC:
loc_023084FC:
	.word FirmwareWlAdjustedTimeSlot	; 023084FC
pool_02308500:
loc_02308500:
	.word 0x00000300	; 02308500
pool_02308504:
loc_02308504:
	.word REG_WIFI_POST_BEACON	; 02308504
pool_02308508:
loc_02308508:
	.word 0x000004EA	; 02308508
pool_0230850C:
loc_0230850C:
	.word 0x000004EE	; 0230850C
pool_02308510:
loc_02308510:
	.word 0x000004EC	; 02308510
pool_02308514:
loc_02308514:
	.word REG_WIFI_TXBUSY	; 02308514
pool_02308518:
loc_02308518:
	.word 0x00000470	; 02308518
pool_0230851C:
loc_0230851C:
	.word 0x0000FFFF	; 0230851C
pool_02308520:
loc_02308520:
	.word REG_WIFI_POWER_TX	; 02308520
pool_02308524:
loc_02308524:
	.word REG_WIFI_CMD_COUNT	; 02308524
pool_02308528:
loc_02308528:
	.word REG_WIFI_UNKNOWN_048	; 02308528
pool_0230852C:
loc_0230852C:
	.word 0x00000494	; 0230852C
pool_02308530:
loc_02308530:
	.word REG_WIFI_TXREQ_SET	; 02308530

; ===== function loc_02308534 =====
loc_02308534:
	push {lr}	; 02308534
	sub sp,#0x4	; 02308536
	ldr r0,[pool_023085A4]	; 02308538
	ldr r1,[r0,#0x0]	; 0230853A
	ldr r0,[pool_023085A8]	; 0230853C
	add r0,r1,r0	; 0230853E
	ldr r2,[pool_023085AC]	; 02308540
	ldr r1,[pool_023085B0]	; 02308542
	strh r2,[r1,#0x0]	; 02308544
	ldrh r1,[r0,#0x8]	; 02308546
	cmp r1,#0x40	; 02308548
	bne loc_0230858E	; 0230854A
	add r1,r0,#0x0	; 0230854C
	add r1,#0x72	; 0230854E
	ldrh r1,[r1,#0x0]	; 02308550
	cmp r1,#0x0	; 02308552
	beq loc_0230858E	; 02308554
	add r1,r0,#0x0	; 02308556
	add r1,#0x66	; 02308558
	ldrh r2,[r1,#0x0]	; 0230855A
	add r1,r0,#0x0	; 0230855C
	add r1,#0x64	; 0230855E
	ldrh r1,[r1,#0x0]	; 02308560
	cmp r2,r1	; 02308562
	bne loc_0230858E	; 02308564
	add r2,r0,#0x0	; 02308566
	add r2,#0x74	; 02308568
	ldrh r1,[r2,#0x0]	; 0230856A
	add r1,r1,#0x1	; 0230856C
	strh r1,[r2,#0x0]	; 0230856E
	add r1,r0,#0x0	; 02308570
	add r1,#0x74	; 02308572
	ldrh r2,[r1,#0x0]	; 02308574
	add r1,r0,#0x0	; 02308576
	add r1,#0x72	; 02308578
	ldrh r1,[r1,#0x0]	; 0230857A
	cmp r2,r1	; 0230857C
	bls loc_0230858E	; 0230857E
	mov r1,#0x0	; 02308580
	add r0,#0x74	; 02308582
	strh r1,[r0,#0x0]	; 02308584
	mov r0,#0x1	; 02308586
	mov r1,#0xd	; 02308588
	bl loc_02304B68	; 0230858A
loc_0230858E:
	ldr r0,[pool_023085A4]	; 0230858E
	ldr r1,[r0,#0x0]	; 02308590
	ldr r0,[pool_023085B4]	; 02308592
	add r2,r1,r0	; 02308594
	ldrh r1,[r2,#0x0]	; 02308596
	mov r0,#0x2	; 02308598
	orr r1,r0	; 0230859A
	strh r1,[r2,#0x0]	; 0230859C
	add sp,#0x4	; 0230859E
	pop {r3}	; 023085A0
	bx r3	; 023085A2
pool_023085A4:
loc_023085A4:
	.word FirmwareWlWorkPointerSlot	; 023085A4
pool_023085A8:
loc_023085A8:
	.word 0x00000308	; 023085A8
pool_023085AC:
loc_023085AC:
	.word 0x00008000	; 023085AC
pool_023085B0:
loc_023085B0:
	.word REG_WIFI_IF	; 023085B0
pool_023085B4:
loc_023085B4:
	.word 0x00000316	; 023085B4

; ===== function loc_023085B8 =====
P4_IrqHandler_023085B8:
	push {r4,r5,r6,r7,lr}	; 023085B8
	sub sp,#0x4	; 023085BA
	mov r7,#0x1	; 023085BC
	ldr r4,[pool_02308694]	; 023085BE
	ldr r6,[pool_02308698]	; 023085C0
loc_023085C2:
	ldrh r5,[r4,#0x0]	; 023085C2
	ldrh r0,[r6,#0x0]	; 023085C4
	and r5,r0	; 023085C6
	cmp r5,#0x0	; 023085C8
	beq loc_02308682	; 023085CA
	add r1,r5,#0x0	; 023085CC
	mov r0,#0x80	; 023085CE
	and r1,r0	; 023085D0
	cmp r1,#0x0	; 023085D2
	beq loc_023085DA	; 023085D4
	bl loc_02307AD4	; 023085D6
loc_023085DA:
	add r1,r5,#0x0	; 023085DA
	mov r0,#0x40	; 023085DC
	and r1,r0	; 023085DE
	cmp r1,#0x0	; 023085E0
	beq loc_023085E8	; 023085E2
	bl loc_023078FC	; 023085E4
loc_023085E8:
	add r1,r5,#0x0	; 023085E8
	ldr r0,[pool_0230869C]	; 023085EA
	and r1,r0	; 023085EC
	cmp r1,#0x0	; 023085EE
	beq loc_023085F6	; 023085F0
	bl loc_02308534	; 023085F2
loc_023085F6:
	add r1,r5,#0x0	; 023085F6
	ldr r0,[pool_023086A0]	; 023085F8
	and r1,r0	; 023085FA
	cmp r1,#0x0	; 023085FC
	beq loc_02308604	; 023085FE
	bl loc_023082F4	; 02308600
loc_02308604:
	add r1,r5,#0x0	; 02308604
	ldr r0,[pool_023086A4]	; 02308606
	and r1,r0	; 02308608
	cmp r1,#0x0	; 0230860A
	beq loc_02308612	; 0230860C
	bl loc_02308294	; 0230860E
loc_02308612:
	add r1,r5,#0x0	; 02308612
	mov r0,#0x20	; 02308614
	and r1,r0	; 02308616
	cmp r1,#0x0	; 02308618
	beq loc_02308620	; 0230861A
	bl loc_0230825C	; 0230861C
loc_02308620:
	add r1,r5,#0x0	; 02308620
	ldr r0,[pool_023086A8]	; 02308622
	and r1,r0	; 02308624
	cmp r1,#0x0	; 02308626
	beq loc_0230862E	; 02308628
	bl loc_02308284	; 0230862A
loc_0230862E:
	add r1,r5,#0x0	; 0230862E
	mov r0,#0x8	; 02308630
	and r1,r0	; 02308632
	cmp r1,#0x0	; 02308634
	beq loc_0230863C	; 02308636
	bl loc_02308154	; 02308638
loc_0230863C:
	add r1,r5,#0x0	; 0230863C
	mov r0,#0x4	; 0230863E
	and r1,r0	; 02308640
	cmp r1,#0x0	; 02308642
	beq loc_0230864A	; 02308644
	bl loc_02307FD8	; 02308646
loc_0230864A:
	add r0,r5,#0x0	; 0230864A
	and r0,r7	; 0230864C
	cmp r0,#0x0	; 0230864E
	beq loc_02308656	; 02308650
	bl loc_02307C08	; 02308652
loc_02308656:
	add r1,r5,#0x0	; 02308656
	mov r0,#0x10	; 02308658
	and r1,r0	; 0230865A
	cmp r1,#0x0	; 0230865C
	beq loc_02308664	; 0230865E
	bl loc_02308234	; 02308660
loc_02308664:
	add r1,r5,#0x0	; 02308664
	mov r0,#0x2	; 02308666
	and r1,r0	; 02308668
	cmp r1,#0x0	; 0230866A
	beq loc_02308672	; 0230866C
	bl loc_02307E04	; 0230866E
loc_02308672:
	ldr r0,[pool_023086AC]	; 02308672
	and r5,r0	; 02308674
	cmp r5,#0x0	; 02308676
	beq loc_023085C2	; 02308678
	add r0,r7,#0x0	; 0230867A
	bl loc_02307B58	; 0230867C
	b loc_023085C2	; 02308680
loc_02308682:
	ldr r2,[pool_023086B0]	; 02308682
	ldr r1,[r2,#0x0]	; 02308684
	ldr r0,[pool_023086B4]	; 02308686
	orr r1,r0	; 02308688
	str r1,[r2,#0x0]	; 0230868A
	add sp,#0x4	; 0230868C
	pop {r4,r5,r6,r7}	; 0230868E
	pop {r3}	; 02308690
	bx r3	; 02308692
pool_02308694:
loc_02308694:
	.word REG_WIFI_IF	; 02308694
pool_02308698:
loc_02308698:
	.word REG_WIFI_IE	; 02308698
pool_0230869C:
loc_0230869C:
	.word 0x00008000	; 0230869C
pool_023086A0:
loc_023086A0:
	.word 0x00004000	; 023086A0
pool_023086A4:
loc_023086A4:
	.word 0x00002000	; 023086A4
pool_023086A8:
loc_023086A8:
	.word 0x00000800	; 023086A8
pool_023086AC:
loc_023086AC:
	.word 0x00001000	; 023086AC
pool_023086B0:
loc_023086B0:
	.word Bios7IrqFlagsAddress	; 023086B0
pool_023086B4:
loc_023086B4:
	.word 0x01000000	; 023086B4

; ===== function loc_023086B8 =====
loc_023086B8:
	push {r4,r5,r6,lr}	; 023086B8
	add r6,r0,#0x0	; 023086BA
	add r5,r1,#0x0	; 023086BC
	ldr r0,[pool_02308708]	; 023086BE
	ldr r1,[r0,#0x0]	; 023086C0
	ldr r0,[pool_0230870C]	; 023086C2
	add r0,r1,r0	; 023086C4
	add r1,r5,#0x0	; 023086C6
	add r1,#0x22	; 023086C8
	bl loc_02305050	; 023086CA
	cmp r0,#0x0	; 023086CE
	bne loc_023086D6	; 023086D0
	mov r0,#0x0	; 023086D2
	b loc_02308700	; 023086D4
loc_023086D6:
	add r4,r0,#0x0	; 023086D6
	add r4,#0x10	; 023086D8
	add r0,r4,#0x0	; 023086DA
	add r0,#0x8	; 023086DC
	add r1,r6,#0x0	; 023086DE
	add r2,r5,#0x0	; 023086E0
	add r2,#0xc	; 023086E2
	bl loc_023054E8	; 023086E4
	sub r5,#0x18	; 023086E8
	strh r5,[r4,#0x6]	; 023086EA
	ldrh r2,[r4,#0xe]	; 023086EC
	mov r0,#0xff	; 023086EE
	and r2,r0	; 023086F0
	ldrh r1,[r4,#0x12]	; 023086F2
	and r1,r0	; 023086F4
	lsl r0,r1,#0x10	; 023086F6
	lsr r0,r0,#0x8	; 023086F8
	orr r2,r0	; 023086FA
	strh r2,[r4,#0xe]	; 023086FC
	add r0,r4,#0x0	; 023086FE
loc_02308700:
	pop {r4,r5,r6}	; 02308700
	pop {r3}	; 02308702
	bx r3	; 02308704
	.byte 0xC0, 0x46	; 02308708
pool_02308708:
loc_02308708:
	.word FirmwareWlWorkPointerSlot	; 02308708
pool_0230870C:
loc_0230870C:
	.word 0x0000014C	; 0230870C

; ===== function loc_02308710 =====
	push {lr}	; 02308710
	sub sp,#0x4	; 02308712
	ldr r0,[pool_0230878C]	; 02308714
	ldrh r0,[r0,#0x0]	; 02308716
	cmp r0,#0x0	; 02308718
	bne loc_02308734	; 0230871A
	ldr r0,[pool_02308790]	; 0230871C
	ldr r1,[r0,#0x0]	; 0230871E
	ldr r0,[pool_02308794]	; 02308720
	ldrh r0,[r1,r0]	; 02308722
	cmp r0,#0x0	; 02308724
	beq loc_02308734	; 02308726
	mov r1,#0x8	; 02308728
	ldr r0,[pool_02308798]	; 0230872A
	strh r1,[r0,#0x0]	; 0230872C
	bl loc_0230D5C4	; 0230872E
	b loc_02308784	; 02308732
loc_02308734:
	ldr r0,[pool_02308790]	; 02308734
	ldr r3,[r0,#0x0]	; 02308736
	ldr r1,[pool_0230879C]	; 02308738
	ldrh r2,[r3,r1]	; 0230873A
	ldr r1,[pool_023087A0]	; 0230873C
	ldrh r1,[r3,r1]	; 0230873E
	bic r2,r1	; 02308740
	cmp r2,#0x0	; 02308742
	bne loc_0230875A	; 02308744
	mov r2,#0x8	; 02308746
	ldr r1,[pool_02308798]	; 02308748
	strh r2,[r1,#0x0]	; 0230874A
	ldr r1,[r0,#0x0]	; 0230874C
	ldr r0,[pool_02308794]	; 0230874E
	ldrh r0,[r1,r0]	; 02308750
	cmp r0,#0x0	; 02308752
	beq loc_0230875A	; 02308754
	bl loc_0230D5C4	; 02308756
loc_0230875A:
	mov r1,#0x5	; 0230875A
	ldr r0,[pool_02308798]	; 0230875C
	strh r1,[r0,#0x0]	; 0230875E
	ldr r0,[pool_02308790]	; 02308760
	ldr r1,[r0,#0x0]	; 02308762
	ldr r0,[pool_023087A4]	; 02308764
	ldrh r0,[r1,r0]	; 02308766
	cmp r0,#0x0	; 02308768
	beq loc_02308772	; 0230876A
	mov r0,#0x1	; 0230876C
	bl loc_0230D670	; 0230876E
loc_02308772:
	ldr r0,[pool_02308790]	; 02308772
	ldr r1,[r0,#0x0]	; 02308774
	ldr r0,[pool_023087A8]	; 02308776
	ldrh r0,[r1,r0]	; 02308778
	cmp r0,#0x0	; 0230877A
	beq loc_02308784	; 0230877C
	mov r0,#0x0	; 0230877E
	bl loc_0230D670	; 02308780
loc_02308784:
	add sp,#0x4	; 02308784
	pop {r3}	; 02308786
	bx r3	; 02308788
	.byte 0xC0, 0x46	; 0230878C
pool_0230878C:
loc_0230878C:
	.word REG_WIFI_LISTENCOUNT	; 0230878C
pool_02308790:
loc_02308790:
	.word FirmwareWlWorkPointerSlot	; 02308790
pool_02308794:
loc_02308794:
	.word 0x00000178	; 02308794
pool_02308798:
loc_02308798:
	.word REG_WIFI_TXREQ_SET	; 02308798
pool_0230879C:
loc_0230879C:
	.word 0x000004EA	; 0230879C
pool_023087A0:
loc_023087A0:
	.word 0x000004EE	; 023087A0
pool_023087A4:
loc_023087A4:
	.word 0x0000016C	; 023087A4
pool_023087A8:
loc_023087A8:
	.word 0x00000160	; 023087A8

; ===== function loc_023087AC =====
loc_023087AC:
	push {r4,lr}	; 023087AC
	ldr r0,[pool_0230884C]	; 023087AE
	ldr r1,[r0,#0x0]	; 023087B0
	ldr r0,[pool_02308850]	; 023087B2
	add r4,r1,r0	; 023087B4
	add r0,r4,#0x0	; 023087B6
	add r0,#0x90	; 023087B8
	ldr r0,[r0,#0x0]	; 023087BA
	ldrh r1,[r0,#0x10]	; 023087BC
	ldr r0,[r4,#0x44]	; 023087BE
	ldrh r0,[r0,#0x2]	; 023087C0
	cmp r1,r0	; 023087C2
	beq loc_023087CA	; 023087C4
	bl loc_02308860	; 023087C6
loc_023087CA:
	ldr r0,[r4,#0x44]	; 023087CA
	ldrh r1,[r0,#0x4]	; 023087CC
	mov r0,#0xff	; 023087CE
	and r1,r0	; 023087D0
	lsl r0,r1,#0x10	; 023087D2
	lsr r2,r0,#0x10	; 023087D4
	cmp r2,#0x0	; 023087D6
	beq loc_023087EA	; 023087D8
	ldr r0,[pool_0230884C]	; 023087DA
	ldr r1,[r0,#0x0]	; 023087DC
	ldr r0,[pool_02308854]	; 023087DE
	add r1,r1,r0	; 023087E0
	ldr r0,[r1,#0x0]	; 023087E2
	add r0,r0,r2	; 023087E4
	str r0,[r1,#0x0]	; 023087E6
	b loc_023087F8	; 023087E8
loc_023087EA:
	ldr r0,[pool_0230884C]	; 023087EA
	ldr r1,[r0,#0x0]	; 023087EC
	ldr r0,[pool_02308854]	; 023087EE
	add r1,r1,r0	; 023087F0
	ldr r0,[r1,#0x0]	; 023087F2
	add r0,r0,#0x1	; 023087F4
	str r0,[r1,#0x0]	; 023087F6
loc_023087F8:
	add r1,r4,#0x0	; 023087F8
	add r1,#0x40	; 023087FA
	ldrh r0,[r1,#0x0]	; 023087FC
	add r0,r0,#0x1	; 023087FE
	strh r0,[r1,#0x0]	; 02308800
	add r0,r4,#0x0	; 02308802
	add r0,#0x90	; 02308804
	ldr r2,[r0,#0x0]	; 02308806
	ldrh r1,[r2,#0x10]	; 02308808
	ldr r0,[r4,#0x44]	; 0230880A
	ldrh r0,[r0,#0x2]	; 0230880C
	eor r1,r0	; 0230880E
	strh r1,[r2,#0x12]	; 02308810
	add r0,r4,#0x0	; 02308812
	add r0,#0x90	; 02308814
	ldr r0,[r0,#0x0]	; 02308816
	ldrh r1,[r0,#0x10]	; 02308818
	add r0,r4,#0x0	; 0230881A
	add r0,#0xa0	; 0230881C
	strh r1,[r0,#0x0]	; 0230881E
	mov r0,#0x0	; 02308820
	strh r0,[r4,#0x3c]	; 02308822
	ldr r0,[pool_0230884C]	; 02308824
	ldr r1,[r0,#0x0]	; 02308826
	ldr r0,[pool_02308858]	; 02308828
	ldrh r0,[r1,r0]	; 0230882A
	cmp r0,#0x0	; 0230882C
	beq loc_02308834	; 0230882E
	bl loc_02306694	; 02308830
loc_02308834:
	ldr r0,[pool_0230884C]	; 02308834
	ldr r1,[r0,#0x0]	; 02308836
	ldr r0,[pool_0230885C]	; 02308838
	add r0,r1,r0	; 0230883A
	add r4,#0x90	; 0230883C
	ldr r1,[r4,#0x0]	; 0230883E
	bl loc_02309574	; 02308840
	pop {r4}	; 02308844
	pop {r3}	; 02308846
	bx r3	; 02308848
	.byte 0xC0, 0x46	; 0230884C
pool_0230884C:
loc_0230884C:
	.word FirmwareWlWorkPointerSlot	; 0230884C
pool_02308850:
loc_02308850:
	.word 0x000003E4	; 02308850
pool_02308854:
loc_02308854:
	.word 0x00000558	; 02308854
pool_02308858:
loc_02308858:
	.word 0x000003A2	; 02308858
pool_0230885C:
loc_0230885C:
	.word 0x0000014C	; 0230885C

; ===== function loc_02308860 =====
loc_02308860:
	push {r4,r5,r6,r7,lr}	; 02308860
	sub sp,#0x1c	; 02308862
	mov r0,#0x0	; 02308864
	str r0,[sp,#0x0]	; 02308866
	ldr r6,[pool_02308AC4]	; 02308868
	str r0,[sp,#0x4]	; 0230886A
	str r0,[sp,#0x14]	; 0230886C
	str r0,[sp,#0x10]	; 0230886E
	str r0,[sp,#0xc]	; 02308870
	str r0,[sp,#0x8]	; 02308872
	str r0,[sp,#0x18]	; 02308874
loc_02308876:
	ldr r0,[pool_02308AC8]	; 02308876
	ldrh r2,[r0,#0x0]	; 02308878
	ldr r1,[r6,#0x0]	; 0230887A
	ldr r0,[pool_02308ACC]	; 0230887C
	ldrh r0,[r1,r0]	; 0230887E
	cmp r2,r0	; 02308880
	bne loc_02308886	; 02308882
	b loc_02308ABA	; 02308884
loc_02308886:
	lsl r2,r2,#0x1	; 02308886
	ldr r0,[pool_02308AD0]	; 02308888
	add r5,r2,r0	; 0230888A
	add r0,r5,#0x2	; 0230888C
	ldr r2,[pool_02308AD4]	; 0230888E
	cmp r0,r2	; 02308890
	bcs loc_02308898	; 02308892
	ldrh r7,[r5,#0x2]	; 02308894
	b loc_023088A0	; 02308896
loc_02308898:
	ldr r2,[pool_02308AD8]	; 02308898
	ldrh r2,[r1,r2]	; 0230889A
	sub r0,r0,r2	; 0230889C
	ldrh r7,[r0,#0x0]	; 0230889E
loc_023088A0:
	ldrh r2,[r5,#0x0]	; 023088A0
	ldr r0,[pool_02308ADC]	; 023088A2
	cmp r2,r0	; 023088A4
	bne loc_023088AE	; 023088A6
	ldr r0,[pool_02308AC8]	; 023088A8
	strh r7,[r0,#0x0]	; 023088AA
	b loc_02308AB2	; 023088AC
loc_023088AE:
	add r0,r5,#0x0	; 023088AE
	add r0,#0x8	; 023088B0
	ldr r2,[pool_02308AD4]	; 023088B2
	cmp r0,r2	; 023088B4
	bcs loc_023088BC	; 023088B6
	ldrh r1,[r5,#0x8]	; 023088B8
	b loc_023088C4	; 023088BA
loc_023088BC:
	ldr r2,[pool_02308AD8]	; 023088BC
	ldrh r1,[r1,r2]	; 023088BE
	sub r0,r0,r1	; 023088C0
	ldrh r1,[r0,#0x0]	; 023088C2
loc_023088C4:
	add r0,r5,#0x0	; 023088C4
	bl loc_023086B8	; 023088C6
	add r4,r0,#0x0	; 023088CA
	ldr r0,[pool_02308AC8]	; 023088CC
	strh r7,[r0,#0x0]	; 023088CE
	cmp r4,#0x0	; 023088D0
	bne loc_023088EE	; 023088D2
	ldrh r1,[r5,#0x0]	; 023088D4
	mov r0,#0xf	; 023088D6
	and r1,r0	; 023088D8
	cmp r1,#0xc	; 023088DA
	bne loc_023088E6	; 023088DC
	mov r0,#0x10	; 023088DE
	bl loc_02305130	; 023088E0
	b loc_02308AB2	; 023088E4
loc_023088E6:
	mov r0,#0x8	; 023088E6
	bl loc_02305130	; 023088E8
	b loc_02308AB2	; 023088EC
loc_023088EE:
	ldr r0,[r6,#0x0]	; 023088EE
	ldr r1,[pool_02308AE0]	; 023088F0
	ldrh r2,[r0,r1]	; 023088F2
	mov r1,#0x8	; 023088F4
	and r2,r1	; 023088F6
	cmp r2,#0x0	; 023088F8
	beq loc_0230890C	; 023088FA
	ldrh r2,[r4,#0x14]	; 023088FC
	ldr r1,[pool_02308AE4]	; 023088FE
	and r2,r1	; 02308900
	cmp r2,#0x0	; 02308902
	beq loc_0230890C	; 02308904
	ldr r2,[sp,#0x4]	; 02308906
	ldr r1,[pool_02308AE8]	; 02308908
	strh r2,[r0,r1]	; 0230890A
loc_0230890C:
	ldrh r1,[r4,#0x8]	; 0230890C
	mov r7,#0x1	; 0230890E
	add r2,r1,#0x0	; 02308910
	ldr r0,[pool_02308AEC]	; 02308912
	and r2,r0	; 02308914
	cmp r2,#0x0	; 02308916
	beq loc_0230894E	; 02308918
	ldrh r0,[r4,#0x14]	; 0230891A
	lsl r0,r0,#0x15	; 0230891C
	lsr r0,r0,#0x1f	; 0230891E
	cmp r0,#0x1	; 02308920
	beq loc_02308930	; 02308922
	ldrh r0,[r4,#0x2a]	; 02308924
	lsl r0,r0,#0x1c	; 02308926
	lsr r0,r0,#0x1c	; 02308928
	cmp r0,#0x0	; 0230892A
	bne loc_02308930	; 0230892C
	b loc_02308A76	; 0230892E
loc_02308930:
	ldr r7,[sp,#0x8]	; 02308930
	ldr r2,[r6,#0x0]	; 02308932
	ldr r0,[pool_02308AF0]	; 02308934
	add r0,r2,r0	; 02308936
	ldr r1,[pool_02308AF4]	; 02308938
	add r1,r2,r1	; 0230893A
	add r2,r4,#0x0	; 0230893C
	sub r2,#0x10	; 0230893E
	bl loc_02304FA8	; 02308940
	mov r0,#0x2	; 02308944
	mov r1,#0x9	; 02308946
	bl loc_02304B68	; 02308948
	b loc_02308A76	; 0230894C
loc_0230894E:
	mov r0,#0xf	; 0230894E
	and r1,r0	; 02308950
	cmp r1,#0xf	; 02308952
	bls loc_02308958	; 02308954
	b loc_02308A76	; 02308956
loc_02308958:
	add r0,r1,r1	; 02308958
P4_SwitchIndexPC_02308958:
	add r0,pc	; 0230895A
	ldrh r0,[r0,#(P4_SwitchTable_02308958 - (P4_SwitchIndexPC_02308958 + 4))]	; 0230895C
	lsl r0,r0,#0x10	; 0230895E
	asr r0,r0,#0x10	; 02308960
P4_SwitchTargetPC_02308958:
	add r0,pc	; 02308962
	bx r0	; 02308964
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02308958:
	.halfword (loc_023089BC + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_023089AE + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_023089E4 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308986 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A76 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A20 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A56 + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A0C + 1) - (P4_SwitchTargetPC_02308958 + 4)
	.halfword (loc_02308A0C + 1) - (P4_SwitchTargetPC_02308958 + 4)
P4_SwitchTable_02308958End:
loc_02308986:
	ldrh r1,[r4,#0x14]	; 02308986
	mov r0,#0xf	; 02308988
	and r1,r0	; 0230898A
	cmp r1,#0x8	; 0230898C
	bne loc_02308A76	; 0230898E
	ldr r7,[sp,#0xc]	; 02308990
	ldr r2,[r6,#0x0]	; 02308992
	ldr r0,[pool_02308AF0]	; 02308994
	add r0,r2,r0	; 02308996
	ldr r1,[pool_02308AF8]	; 02308998
	add r1,r2,r1	; 0230899A
	add r2,r4,#0x0	; 0230899C
	sub r2,#0x10	; 0230899E
	bl loc_02304FA8	; 023089A0
	mov r0,#0x2	; 023089A4
	mov r1,#0x6	; 023089A6
	bl loc_02304B68	; 023089A8
	b loc_02308A76	; 023089AC
loc_023089AE:
	ldrh r0,[r4,#0x14]	; 023089AE
	cmp r0,#0x80	; 023089B0
	bne loc_02308A76	; 023089B2
	add r0,r4,#0x0	; 023089B4
	bl loc_0230F2A8	; 023089B6
	b loc_02308A76	; 023089BA
loc_023089BC:
	ldrh r1,[r4,#0x14]	; 023089BC
	mov r0,#0xf	; 023089BE
	and r1,r0	; 023089C0
	cmp r1,#0x0	; 023089C2
	bne loc_02308A76	; 023089C4
	ldr r7,[sp,#0x10]	; 023089C6
	ldr r2,[r6,#0x0]	; 023089C8
	ldr r0,[pool_02308AF0]	; 023089CA
	add r0,r2,r0	; 023089CC
	ldr r1,[pool_02308AFC]	; 023089CE
	add r1,r2,r1	; 023089D0
	add r2,r4,#0x0	; 023089D2
	sub r2,#0x10	; 023089D4
	bl loc_02304FA8	; 023089D6
	mov r0,#0x1	; 023089DA
	mov r1,#0x7	; 023089DC
	bl loc_02304B68	; 023089DE
	b loc_02308A76	; 023089E2
loc_023089E4:
	ldrh r1,[r4,#0x14]	; 023089E4
	ldr r0,[pool_02308B00]	; 023089E6
	and r1,r0	; 023089E8
	cmp r1,#0xa4	; 023089EA
	bne loc_02308A76	; 023089EC
	ldr r7,[sp,#0x14]	; 023089EE
	ldr r2,[r6,#0x0]	; 023089F0
	ldr r0,[pool_02308AF0]	; 023089F2
	add r0,r2,r0	; 023089F4
	ldr r1,[pool_02308AFC]	; 023089F6
	add r1,r2,r1	; 023089F8
	add r2,r4,#0x0	; 023089FA
	sub r2,#0x10	; 023089FC
	bl loc_02304FA8	; 023089FE
	mov r0,#0x1	; 02308A02
	mov r1,#0x7	; 02308A04
	bl loc_02304B68	; 02308A06
	b loc_02308A76	; 02308A0A
loc_02308A0C:
	ldrh r0,[r4,#0x14]	; 02308A0C
	ldr r1,[pool_02308B04]	; 02308A0E
	and r0,r1	; 02308A10
	ldr r1,[pool_02308B08]	; 02308A12
	cmp r0,r1	; 02308A14
	bne loc_02308A76	; 02308A16
	add r0,r4,#0x0	; 02308A18
	bl loc_0230F96C	; 02308A1A
	b loc_02308A76	; 02308A1E
loc_02308A20:
	ldrh r0,[r4,#0x14]	; 02308A20
	ldr r1,[pool_02308B00]	; 02308A22
	and r0,r1	; 02308A24
	ldr r1,[pool_02308B0C]	; 02308A26
	cmp r0,r1	; 02308A28
	bne loc_02308A76	; 02308A2A
	ldr r1,[r6,#0x0]	; 02308A2C
	ldr r0,[pool_02308B10]	; 02308A2E
	ldrh r0,[r1,r0]	; 02308A30
	lsl r0,r0,#0x1e	; 02308A32
	lsr r0,r0,#0x1f	; 02308A34
	cmp r0,#0x0	; 02308A36
	bne loc_02308A40	; 02308A38
	lsl r1,r7,#0	; 02308A3A
	ldr r0,[pool_02308B14]	; 02308A3C
	strh r1,[r0,#0x0]	; 02308A3E
loc_02308A40:
	ldr r1,[r6,#0x0]	; 02308A40
	ldr r0,[pool_02308B18]	; 02308A42
	add r1,r1,r0	; 02308A44
	ldr r0,[r1,#0x0]	; 02308A46
	add r0,r0,#0x1	; 02308A48
	str r0,[r1,#0x0]	; 02308A4A
	add r0,r4,#0x0	; 02308A4C
	bl loc_0230FAE0	; 02308A4E
	add r7,r0,#0x0	; 02308A52
	b loc_02308A76	; 02308A54
loc_02308A56:
	ldrh r0,[r4,#0x14]	; 02308A56
	ldr r1,[pool_02308B00]	; 02308A58
	and r0,r1	; 02308A5A
	ldr r1,[pool_02308B1C]	; 02308A5C
	cmp r0,r1	; 02308A5E
	bne loc_02308A76	; 02308A60
	ldr r1,[r6,#0x0]	; 02308A62
	ldr r0,[pool_02308B20]	; 02308A64
	add r1,r1,r0	; 02308A66
	ldr r0,[r1,#0x0]	; 02308A68
	add r0,r0,#0x1	; 02308A6A
	str r0,[r1,#0x0]	; 02308A6C
	add r0,r4,#0x0	; 02308A6E
	bl loc_0230F880	; 02308A70
	add r7,r0,#0x0	; 02308A74
loc_02308A76:
	cmp r7,#0x0	; 02308A76
	beq loc_02308A88	; 02308A78
	ldr r1,[r6,#0x0]	; 02308A7A
	ldr r0,[pool_02308AF0]	; 02308A7C
	add r0,r1,r0	; 02308A7E
	sub r4,#0x10	; 02308A80
	add r1,r4,#0x0	; 02308A82
	bl loc_02304FF8	; 02308A84
loc_02308A88:
	ldr r1,[r6,#0x0]	; 02308A88
	ldr r0,[pool_02308AE0]	; 02308A8A
	ldrh r1,[r1,r0]	; 02308A8C
	mov r0,#0x1	; 02308A8E
	and r1,r0	; 02308A90
	cmp r1,#0x0	; 02308A92
	beq loc_02308AB2	; 02308A94
	ldr r0,[sp,#0x18]	; 02308A96
loc_02308A98:
	ldr r1,[pool_02308AD4]	; 02308A98
	cmp r5,r1	; 02308A9A
	bcc loc_02308AA6	; 02308A9C
	ldr r2,[r6,#0x0]	; 02308A9E
	ldr r1,[pool_02308AD8]	; 02308AA0
	ldrh r1,[r2,r1]	; 02308AA2
	sub r5,r5,r1	; 02308AA4
loc_02308AA6:
	ldr r1,[pool_02308ADC]	; 02308AA6
	strh r1,[r5,#0x0]	; 02308AA8
	add r5,r5,#0x2	; 02308AAA
	add r0,r0,#0x1	; 02308AAC
	cmp r0,#0x7	; 02308AAE
	bcc loc_02308A98	; 02308AB0
loc_02308AB2:
	ldr r0,[sp,#0x0]	; 02308AB2
	add r0,r0,#0x1	; 02308AB4
	str r0,[sp,#0x0]	; 02308AB6
	b loc_02308876	; 02308AB8
loc_02308ABA:
	add sp,#0x1c	; 02308ABA
	pop {r4,r5,r6,r7}	; 02308ABC
	pop {r3}	; 02308ABE
	bx r3	; 02308AC0
	.byte 0xC0, 0x46	; 02308AC4
pool_02308AC4:
loc_02308AC4:
	.word FirmwareWlWorkPointerSlot	; 02308AC4
pool_02308AC8:
loc_02308AC8:
	.word REG_WIFI_RXBUF_READCSR	; 02308AC8
pool_02308ACC:
loc_02308ACC:
	.word 0x0000049C	; 02308ACC
pool_02308AD0:
loc_02308AD0:
	.word WifiRamBase	; 02308AD0
pool_02308AD4:
loc_02308AD4:
	.word 0x04805F60	; 02308AD4
pool_02308AD8:
loc_02308AD8:
	.word 0x00000396	; 02308AD8
pool_02308ADC:
loc_02308ADC:
	.word 0x0000FFFF	; 02308ADC
pool_02308AE0:
loc_02308AE0:
	.word 0x0000061C	; 02308AE0
pool_02308AE4:
loc_02308AE4:
	.word 0x00004000	; 02308AE4
pool_02308AE8:
loc_02308AE8:
	.word 0x0000049A	; 02308AE8
pool_02308AEC:
loc_02308AEC:
	.word 0x00000200	; 02308AEC
pool_02308AF0:
loc_02308AF0:
	.word 0x0000014C	; 02308AF0
pool_02308AF4:
loc_02308AF4:
	.word 0x000001AC	; 02308AF4
pool_02308AF8:
loc_02308AF8:
	.word 0x00000188	; 02308AF8
pool_02308AFC:
loc_02308AFC:
	.word 0x000001A0	; 02308AFC
pool_02308B00:
loc_02308B00:
	.word 0x0000E7FF	; 02308B00
pool_02308B04:
loc_02308B04:
	.word 0x0000E7BF	; 02308B04
pool_02308B08:
loc_02308B08:
	.word 0x00000118	; 02308B08
pool_02308B0C:
loc_02308B0C:
	.word 0x00000228	; 02308B0C
pool_02308B10:
loc_02308B10:
	.word 0x00000316	; 02308B10
pool_02308B14:
loc_02308B14:
	.word REG_WIFI_POWERSTATE	; 02308B14
pool_02308B18:
loc_02308B18:
	.word 0x00000564	; 02308B18
pool_02308B1C:
loc_02308B1C:
	.word 0x00000218	; 02308B1C
pool_02308B20:
loc_02308B20:
	.word 0x00000568	; 02308B20

; ===== function loc_02308B24 =====
	push {r4,r5,r6,r7,lr}	; 02308B24
	sub sp,#0xc	; 02308B26
	ldr r7,[pool_02308C5C]	; 02308B28
	ldr r1,[r7,#0x0]	; 02308B2A
	ldr r0,[pool_02308C60]	; 02308B2C
	add r0,r1,r0	; 02308B2E
	str r0,[sp,#0x0]	; 02308B30
	mov r4,#0x2	; 02308B32
	str r4,[sp,#0x8]	; 02308B34
	str r4,[sp,#0x4]	; 02308B36
loc_02308B38:
	ldr r1,[r7,#0x0]	; 02308B38
	ldr r0,[pool_02308C60]	; 02308B3A
	add r2,r1,r0	; 02308B3C
	add r1,r4,#0x0	; 02308B3E
	mov r0,#0x14	; 02308B40
	mul r1,r0	; 02308B42
	add r2,r2,r1	; 02308B44
	lsl r1,r4,#0x2	; 02308B46
	ldr r0,[pool_02308C64]	; 02308B48
	add r3,r1,r0	; 02308B4A
	ldrh r1,[r3,#0x0]	; 02308B4C
	ldr r0,[pool_02308C68]	; 02308B4E
	and r1,r0	; 02308B50
	cmp r1,#0x0	; 02308B52
	bne loc_02308C4C	; 02308B54
	ldrh r0,[r2,#0x0]	; 02308B56
	cmp r0,#0x0	; 02308B58
	beq loc_02308C4C	; 02308B5A
	ldr r1,[r2,#0xc]	; 02308B5C
	cmp r1,#0x0	; 02308B5E
	beq loc_02308C3A	; 02308B60
	ldr r0,[r2,#0x8]	; 02308B62
	ldrh r0,[r0,#0x0]	; 02308B64
	strh r0,[r1,#0x8]	; 02308B66
	ldr r0,[r2,#0x8]	; 02308B68
	ldrh r1,[r0,#0xc]	; 02308B6A
	ldr r0,[r2,#0xc]	; 02308B6C
	strh r1,[r0,#0x14]	; 02308B6E
	ldr r5,[r2,#0x8]	; 02308B70
	ldrh r1,[r5,#0xc]	; 02308B72
	ldr r0,[pool_02308C6C]	; 02308B74
	and r1,r0	; 02308B76
	cmp r1,#0x0	; 02308B78
	beq loc_02308C1C	; 02308B7A
	ldr r1,[r7,#0x0]	; 02308B7C
	ldr r0,[pool_02308C70]	; 02308B7E
	ldrh r6,[r1,r0]	; 02308B80
	mov r0,#0x8	; 02308B82
	and r6,r0	; 02308B84
	cmp r6,#0x0	; 02308B86
	beq loc_02308C06	; 02308B88
	add r6,r5,#0x0	; 02308B8A
	add r6,#0xc	; 02308B8C
	ldrh r0,[r5,#0xa]	; 02308B8E
	add r0,r6,r0	; 02308B90
	sub r0,r0,#0x7	; 02308B92
	mov r6,#0x1	; 02308B94
	bic r0,r6	; 02308B96
	ldrh r6,[r0,#0x0]	; 02308B98
	cmp r6,#0x0	; 02308B9A
	bne loc_02308C06	; 02308B9C
	ldrh r0,[r0,#0x2]	; 02308B9E
	cmp r0,#0x0	; 02308BA0
	bne loc_02308C06	; 02308BA2
	ldr r0,[pool_02308C74]	; 02308BA4
	ldr r1,[r1,r0]	; 02308BA6
	ldr r0,[r2,#0xc]	; 02308BA8
	ldrh r0,[r0,#0x4]	; 02308BAA
	sub r0,r1,r0	; 02308BAC
	lsl r0,r0,#0x10	; 02308BAE
	lsr r1,r0,#0x10	; 02308BB0
	mov r5,#0x0	; 02308BB2
	ldr r0,[pool_02308C78]	; 02308BB4
	strh r5,[r0,#0x0]	; 02308BB6
	ldr r5,[pool_02308C68]	; 02308BB8
	strh r5,[r0,#0x0]	; 02308BBA
	ldr r5,[r7,#0x0]	; 02308BBC
	ldr r0,[pool_02308C7C]	; 02308BBE
	add r0,r5,r0	; 02308BC0
	ldrh r5,[r0,#0x0]	; 02308BC2
	add r5,r5,#0x1	; 02308BC4
	strh r5,[r0,#0x0]	; 02308BC6
	ldr r5,[r7,#0x0]	; 02308BC8
	ldr r0,[pool_02308C80]	; 02308BCA
	ldrh r0,[r5,r0]	; 02308BCC
	cmp r1,r0	; 02308BCE
	bls loc_02308BF6	; 02308BD0
	ldr r1,[r2,#0xc]	; 02308BD2
	ldr r0,[sp,#0x4]	; 02308BD4
	strh r0,[r1,#0x8]	; 02308BD6
	add r1,r2,#0x4	; 02308BD8
	ldrh r0,[r1,#0x0]	; 02308BDA
	add r0,r0,#0x1	; 02308BDC
	strh r0,[r1,#0x0]	; 02308BDE
	ldr r1,[sp,#0x0]	; 02308BE0
	add r1,#0xb0	; 02308BE2
	ldrh r0,[r1,#0x0]	; 02308BE4
	add r0,r0,#0x1	; 02308BE6
	strh r0,[r1,#0x0]	; 02308BE8
	ldr r0,[r2,#0xc]	; 02308BEA
	mov r1,#0x1	; 02308BEC
	ldr r2,[r2,#0x10]	; 02308BEE
	bl loc_02308C84	; 02308BF0
	b loc_02308C4C	; 02308BF4
loc_02308BF6:
	ldr r1,[r2,#0xc]	; 02308BF6
	mov r0,#0x0	; 02308BF8
	strh r0,[r1,#0xc]	; 02308BFA
	ldrh r1,[r3,#0x0]	; 02308BFC
	ldr r0,[pool_02308C68]	; 02308BFE
	orr r1,r0	; 02308C00
	strh r1,[r3,#0x0]	; 02308C02
	b loc_02308C4C	; 02308C04
loc_02308C06:
	ldr r1,[r2,#0xc]	; 02308C06
	add r1,#0xc	; 02308C08
	ldrh r0,[r1,#0x0]	; 02308C0A
	ldrh r5,[r5,#0x4]	; 02308C0C
	mov r3,#0xff	; 02308C0E
	and r5,r3	; 02308C10
	lsl r3,r5,#0x10	; 02308C12
	lsr r3,r3,#0x10	; 02308C14
	add r0,r0,r3	; 02308C16
	strh r0,[r1,#0x0]	; 02308C18
	b loc_02308C26	; 02308C1A
loc_02308C1C:
	ldrh r1,[r5,#0x4]	; 02308C1C
	mov r0,#0xff	; 02308C1E
	and r1,r0	; 02308C20
	ldr r0,[r2,#0xc]	; 02308C22
	strh r1,[r0,#0xc]	; 02308C24
loc_02308C26:
	add r1,r2,#0x4	; 02308C26
	ldrh r0,[r1,#0x0]	; 02308C28
	add r0,r0,#0x1	; 02308C2A
	strh r0,[r1,#0x0]	; 02308C2C
	ldr r0,[r2,#0xc]	; 02308C2E
	ldr r1,[sp,#0x8]	; 02308C30
	ldr r2,[r2,#0x10]	; 02308C32
	bl loc_02308C84	; 02308C34
	b loc_02308C4C	; 02308C38
loc_02308C3A:
	add r1,r2,#0x4	; 02308C3A
	ldrh r0,[r1,#0x0]	; 02308C3C
	add r0,r0,#0x1	; 02308C3E
	strh r0,[r1,#0x0]	; 02308C40
	ldr r0,[r2,#0x8]	; 02308C42
	mov r1,#0x3	; 02308C44
	ldr r2,[r2,#0x10]	; 02308C46
	bl loc_02308C84	; 02308C48
loc_02308C4C:
	sub r4,r4,#0x1	; 02308C4C
	cmp r4,#0x0	; 02308C4E
	blt loc_02308C54	; 02308C50
	b loc_02308B38	; 02308C52
loc_02308C54:
	add sp,#0xc	; 02308C54
	pop {r4,r5,r6,r7}	; 02308C56
	pop {r3}	; 02308C58
	bx r3	; 02308C5A
pool_02308C5C:
loc_02308C5C:
	.word FirmwareWlWorkPointerSlot	; 02308C5C
pool_02308C60:
loc_02308C60:
	.word 0x000003E4	; 02308C60
pool_02308C64:
loc_02308C64:
	.word REG_WIFI_TXBUF_LOC1	; 02308C64
pool_02308C68:
loc_02308C68:
	.word 0x00008000	; 02308C68
pool_02308C6C:
loc_02308C6C:
	.word 0x00004000	; 02308C6C
pool_02308C70:
loc_02308C70:
	.word 0x0000061C	; 02308C70
pool_02308C74:
loc_02308C74:
	.word 0x000003A4	; 02308C74
pool_02308C78:
loc_02308C78:
	.word REG_WIFI_WEP_CNT	; 02308C78
pool_02308C7C:
loc_02308C7C:
	.word 0x000003B6	; 02308C7C
pool_02308C80:
loc_02308C80:
	.word 0x00000388	; 02308C80

; ===== function loc_02308C84 =====
loc_02308C84:
	bx pc	; 02308C84
	.byte 0xC0, 0x46	; 02308C88
.arm

; ===== function loc_02308C88 =====
loc_02308C88:
	ldr r12,[pool_02308C90]	; 02308C88
	bx r12	; 02308C8C
pool_02308C90:
loc_02308C90:
	.word loc_038029FC + 1	; 02308C90
.thumb

; ===== function loc_02308C94 =====
	push {lr}	; 02308C94
	sub sp,#0x4	; 02308C96
	ldr r0,[pool_02308CC4]	; 02308C98
	ldr r1,[r0,#0x0]	; 02308C9A
	ldr r0,[pool_02308CC8]	; 02308C9C
	ldrh r0,[r1,r0]	; 02308C9E
	cmp r0,#0x0	; 02308CA0
	beq loc_02308CA8	; 02308CA2
	bl loc_0230C638	; 02308CA4
loc_02308CA8:
	ldr r0,[pool_02308CC4]	; 02308CA8
	ldr r1,[r0,#0x0]	; 02308CAA
	ldr r0,[pool_02308CCC]	; 02308CAC
	ldrh r0,[r1,r0]	; 02308CAE
	lsl r0,r0,#0x19	; 02308CB0
	lsr r0,r0,#0x1f	; 02308CB2
	cmp r0,#0x0	; 02308CB4
	beq loc_02308CBC	; 02308CB6
	bl loc_02309930	; 02308CB8
loc_02308CBC:
	add sp,#0x4	; 02308CBC
	pop {r3}	; 02308CBE
	bx r3	; 02308CC0
	.byte 0xC0, 0x46	; 02308CC4
pool_02308CC4:
loc_02308CC4:
	.word FirmwareWlWorkPointerSlot	; 02308CC4
pool_02308CC8:
loc_02308CC8:
	.word 0x000003A0	; 02308CC8
pool_02308CCC:
loc_02308CCC:
	.word 0x000002FE	; 02308CCC

; ===== function loc_02308CD0 =====
loc_02308CD0:
	push {r4,r5,r6,lr}	; 02308CD0
	sub sp,#0x8	; 02308CD2
	add r5,r0,#0x0	; 02308CD4
	add r6,r1,#0x0	; 02308CD6
	ldr r0,[pool_02308D58]	; 02308CD8
	ldr r0,[r0,#0x0]	; 02308CDA
	ldr r1,[pool_02308D5C]	; 02308CDC
	ldr r3,[r0,r1]	; 02308CDE
	mov r1,#0x1c	; 02308CE0
	add r2,r5,#0x0	; 02308CE2
	mul r2,r1	; 02308CE4
	add r4,r3,r2	; 02308CE6
	ldrh r1,[r3,r2]	; 02308CE8
	cmp r1,#0x0	; 02308CEA
	bne loc_02308CF8	; 02308CEC
	ldr r1,[pool_02308D60]	; 02308CEE
	add r1,r0,r1	; 02308CF0
	ldrh r0,[r1,#0x0]	; 02308CF2
	add r0,r0,#0x1	; 02308CF4
	strh r0,[r1,#0x0]	; 02308CF6
loc_02308CF8:
	mov r1,#0x0	; 02308CF8
	add r0,sp,#0x0	; 02308CFA
	strh r1,[r0,#0x0]	; 02308CFC
	ldrh r0,[r0,#0x0]	; 02308CFE
	add r1,r4,#0x0	; 02308D00
	mov r2,#0x1a	; 02308D02
	bl loc_02308D74	; 02308D04
	lsl r0,r5,#0x10	; 02308D08
	lsr r0,r0,#0x10	; 02308D0A
	mov r1,#0x0	; 02308D0C
	bl loc_02309180	; 02308D0E
	ldr r0,[pool_02308D58]	; 02308D12
	ldr r1,[r0,#0x0]	; 02308D14
	ldr r0,[pool_02308D64]	; 02308D16
	add r2,r1,r0	; 02308D18
	ldrh r1,[r2,#0x0]	; 02308D1A
	mov r0,#0x1	; 02308D1C
	lsl r0,r5	; 02308D1E
	orr r1,r0	; 02308D20
	strh r1,[r2,#0x0]	; 02308D22
	add r0,r4,#0x4	; 02308D24
	add r1,r6,#0x0	; 02308D26
	bl loc_02306458	; 02308D28
	ldr r0,[pool_02308D68]	; 02308D2C
	strh r0,[r4,#0x14]	; 02308D2E
	ldr r2,[pool_02308D58]	; 02308D30
	ldr r1,[r2,#0x0]	; 02308D32
	ldr r0,[pool_02308D6C]	; 02308D34
	ldrh r0,[r1,r0]	; 02308D36
	strh r0,[r4,#0x10]	; 02308D38
	ldr r1,[r2,#0x0]	; 02308D3A
	ldr r0,[pool_02308D70]	; 02308D3C
	ldrh r0,[r1,r0]	; 02308D3E
	strh r0,[r4,#0x12]	; 02308D40
	ldrh r0,[r4,#0x1a]	; 02308D42
	strh r0,[r4,#0x18]	; 02308D44
	lsl r0,r5,#0x10	; 02308D46
	lsr r0,r0,#0x10	; 02308D48
	mov r1,#0x20	; 02308D4A
	bl loc_023091EC	; 02308D4C
	add sp,#0x8	; 02308D50
	pop {r4,r5,r6}	; 02308D52
	pop {r3}	; 02308D54
	bx r3	; 02308D56
pool_02308D58:
loc_02308D58:
	.word FirmwareWlWorkPointerSlot	; 02308D58
pool_02308D5C:
loc_02308D5C:
	.word 0x000002E0	; 02308D5C
pool_02308D60:
loc_02308D60:
	.word 0x000004E8	; 02308D60
pool_02308D64:
loc_02308D64:
	.word 0x000004EC	; 02308D64
pool_02308D68:
loc_02308D68:
	.word 0x0000FFFF	; 02308D68
pool_02308D6C:
loc_02308D6C:
	.word 0x0000035E	; 02308D6C
pool_02308D70:
loc_02308D70:
	.word 0x00000374	; 02308D70

; ===== function loc_02308D74 =====
loc_02308D74:
	bx pc	; 02308D74
	.byte 0xC0, 0x46	; 02308D78
.arm

; ===== function loc_02308D78 =====
loc_02308D78:
	ldr pc,[pool_02308D7C]	; 02308D78
pool_02308D7C:
loc_02308D7C:
	.word loc_037FCE04	; 02308D7C
.thumb

; ===== function loc_02308D80 =====
loc_02308D80:
	push {r4,r5,r6,r7,lr}	; 02308D80
	sub sp,#0x4	; 02308D82
	ldr r4,[pool_02308DE4]	; 02308D84
	ldr r1,[r4,#0x0]	; 02308D86
	ldr r0,[pool_02308DE8]	; 02308D88
	ldr r6,[r1,r0]	; 02308D8A
	mov r5,#0x1	; 02308D8C
	mov r7,#0x0	; 02308D8E
	b loc_02308DA8	; 02308D90
loc_02308D92:
	add r0,sp,#0x0	; 02308D92
	strh r7,[r0,#0x0]	; 02308D94
	ldrh r0,[r0,#0x0]	; 02308D96
	add r2,r5,#0x0	; 02308D98
	mov r1,#0x1c	; 02308D9A
	mul r2,r1	; 02308D9C
	add r1,r6,r2	; 02308D9E
	mov r2,#0x1a	; 02308DA0
	bl loc_02308E0C	; 02308DA2
	add r5,r5,#0x1	; 02308DA6
loc_02308DA8:
	ldr r0,[r4,#0x0]	; 02308DA8
	ldr r1,[pool_02308DEC]	; 02308DAA
	ldrh r1,[r0,r1]	; 02308DAC
	cmp r5,r1	; 02308DAE
	bcc loc_02308D92	; 02308DB0
	mov r1,#0x1	; 02308DB2
	ldr r2,[pool_02308DF0]	; 02308DB4
	strh r1,[r0,r2]	; 02308DB6
	mov r0,#0x0	; 02308DB8
	ldr r3,[r4,#0x0]	; 02308DBA
	ldr r2,[pool_02308DF4]	; 02308DBC
	strh r0,[r3,r2]	; 02308DBE
	ldr r3,[r4,#0x0]	; 02308DC0
	ldr r2,[pool_02308DF8]	; 02308DC2
	strh r1,[r3,r2]	; 02308DC4
	ldr r5,[pool_02308DFC]	; 02308DC6
	ldr r3,[r4,#0x0]	; 02308DC8
	ldr r2,[pool_02308E00]	; 02308DCA
	strh r5,[r3,r2]	; 02308DCC
	ldr r3,[r4,#0x0]	; 02308DCE
	ldr r2,[pool_02308E04]	; 02308DD0
	strh r0,[r3,r2]	; 02308DD2
	ldr r2,[r4,#0x0]	; 02308DD4
	ldr r0,[pool_02308E08]	; 02308DD6
	strh r1,[r2,r0]	; 02308DD8
	add sp,#0x4	; 02308DDA
	pop {r4,r5,r6,r7}	; 02308DDC
	pop {r3}	; 02308DDE
	bx r3	; 02308DE0
	.byte 0xC0, 0x46	; 02308DE4
pool_02308DE4:
loc_02308DE4:
	.word FirmwareWlWorkPointerSlot	; 02308DE4
pool_02308DE8:
loc_02308DE8:
	.word 0x000002E0	; 02308DE8
pool_02308DEC:
loc_02308DEC:
	.word 0x000002E6	; 02308DEC
pool_02308DF0:
loc_02308DF0:
	.word 0x000004E8	; 02308DF0
pool_02308DF4:
loc_02308DF4:
	.word 0x000004EA	; 02308DF4
pool_02308DF8:
loc_02308DF8:
	.word 0x000004EC	; 02308DF8
pool_02308DFC:
loc_02308DFC:
	.word 0x0000FFFE	; 02308DFC
pool_02308E00:
loc_02308E00:
	.word 0x000004EE	; 02308E00
pool_02308E04:
loc_02308E04:
	.word 0x000004F0	; 02308E04
pool_02308E08:
loc_02308E08:
	.word 0x000004F2	; 02308E08

; ===== function loc_02308E0C =====
loc_02308E0C:
	bx pc	; 02308E0C
	.byte 0xC0, 0x46	; 02308E10
.arm

; ===== function loc_02308E10 =====
loc_02308E10:
	ldr pc,[pool_02308E14]	; 02308E10
pool_02308E14:
loc_02308E14:
	.word loc_037FCE04	; 02308E14
.thumb

; ===== function loc_02308E18 =====
loc_02308E18:
	push {r4,r5,r6,lr}	; 02308E18
	sub sp,#0x8	; 02308E1A
	ldr r0,[pool_02308E88]	; 02308E1C
	ldr r2,[r0,#0x0]	; 02308E1E
	ldr r0,[pool_02308E8C]	; 02308E20
	ldr r4,[r2,r0]	; 02308E22
	mov r1,#0x0	; 02308E24
	add r0,sp,#0x0	; 02308E26
	strh r1,[r0,#0x0]	; 02308E28
	ldrh r0,[r0,#0x0]	; 02308E2A
	add r1,r4,#0x0	; 02308E2C
	ldr r3,[pool_02308E90]	; 02308E2E
	ldrh r2,[r2,r3]	; 02308E30
	mov r3,#0x1c	; 02308E32
	mul r2,r3	; 02308E34
	bl loc_02308EA0	; 02308E36
	mov r1,#0x0	; 02308E3A
	add r0,sp,#0x0	; 02308E3C
	strh r1,[r0,#0x2]	; 02308E3E
	ldrh r0,[r0,#0x2]	; 02308E40
	ldr r1,[pool_02308E88]	; 02308E42
	ldr r2,[r1,#0x0]	; 02308E44
	ldr r1,[pool_02308E94]	; 02308E46
	add r1,r2,r1	; 02308E48
	mov r2,#0xc	; 02308E4A
	bl loc_02308EAC	; 02308E4C
	ldr r1,[pool_02308E98]	; 02308E50
	strh r1,[r4,#0x1a]	; 02308E52
	mov r2,#0x1	; 02308E54
	ldr r0,[pool_02308E88]	; 02308E56
	mov r5,#0x1c	; 02308E58
	ldr r3,[pool_02308E90]	; 02308E5A
	b loc_02308E68	; 02308E5C
loc_02308E5E:
	add r6,r2,#0x0	; 02308E5E
	mul r6,r5	; 02308E60
	add r6,r4,r6	; 02308E62
	strh r1,[r6,#0x1a]	; 02308E64
	add r2,r2,#0x1	; 02308E66
loc_02308E68:
	ldr r6,[r0,#0x0]	; 02308E68
	ldrh r6,[r6,r3]	; 02308E6A
	cmp r2,r6	; 02308E6C
	bcc loc_02308E5E	; 02308E6E
	mov r0,#0x0	; 02308E70
	ldr r1,[pool_02308E9C]	; 02308E72
	bl loc_02308CD0	; 02308E74
	mov r0,#0x0	; 02308E78
	mov r1,#0x40	; 02308E7A
	bl loc_023091EC	; 02308E7C
	add sp,#0x8	; 02308E80
	pop {r4,r5,r6}	; 02308E82
	pop {r3}	; 02308E84
	bx r3	; 02308E86
pool_02308E88:
loc_02308E88:
	.word FirmwareWlWorkPointerSlot	; 02308E88
pool_02308E8C:
loc_02308E8C:
	.word 0x000002E0	; 02308E8C
pool_02308E90:
loc_02308E90:
	.word 0x000002E6	; 02308E90
pool_02308E94:
loc_02308E94:
	.word 0x000004E8	; 02308E94
pool_02308E98:
loc_02308E98:
	.word 0x0000FFFF	; 02308E98
pool_02308E9C:
loc_02308E9C:
	.word 0x02310630	; 02308E9C

; ===== function loc_02308EA0 =====
loc_02308EA0:
	bx pc	; 02308EA0
	.byte 0xC0, 0x46	; 02308EA4
.arm

; ===== function loc_02308EA4 =====
loc_02308EA4:
	ldr pc,[pool_02308EA8]	; 02308EA4
pool_02308EA8:
loc_02308EA8:
	.word loc_037FCE04	; 02308EA8
.thumb

; ===== function loc_02308EAC =====
loc_02308EAC:
	bx pc	; 02308EAC
	.byte 0xC0, 0x46	; 02308EB0
.arm

; ===== function loc_02308EB0 =====
loc_02308EB0:
	ldr pc,[pool_02308EB4]	; 02308EB0
pool_02308EB4:
loc_02308EB4:
	.word loc_037FCE04	; 02308EB4
.thumb

; ===== function loc_02308EB8 =====
	push {r4,r5,r6,r7,lr}	; 02308EB8
	sub sp,#0xc	; 02308EBA
	ldr r0,[pool_02308F78]	; 02308EBC
	ldr r1,[r0,#0x0]	; 02308EBE
	ldr r0,[pool_02308F7C]	; 02308EC0
	ldr r5,[r1,r0]	; 02308EC2
	add r5,#0x1c	; 02308EC4
	ldr r0,[pool_02308F80]	; 02308EC6
	ldrh r7,[r1,r0]	; 02308EC8
	cmp r7,#0x1	; 02308ECA
	bls loc_02308F70	; 02308ECC
	mov r6,#0x0	; 02308ECE
	mov r4,#0x1	; 02308ED0
	str r4,[sp,#0x4]	; 02308ED2
	str r4,[sp,#0x0]	; 02308ED4
	str r6,[sp,#0x8]	; 02308ED6
	b loc_02308F64	; 02308ED8
loc_02308EDA:
	ldrh r0,[r5,#0x0]	; 02308EDA
	cmp r0,#0x0	; 02308EDC
	beq loc_02308F60	; 02308EDE
	ldrh r1,[r5,#0x18]	; 02308EE0
	cmp r1,#0x0	; 02308EE2
	beq loc_02308F5A	; 02308EE4
	ldr r0,[pool_02308F84]	; 02308EE6
	cmp r1,r0	; 02308EE8
	beq loc_02308F5A	; 02308EEA
	add r1,r5,#0x0	; 02308EEC
	add r1,#0x18	; 02308EEE
	ldrh r0,[r1,#0x0]	; 02308EF0
	sub r0,r0,#0x1	; 02308EF2
	strh r0,[r1,#0x0]	; 02308EF4
	ldrh r0,[r5,#0x18]	; 02308EF6
	cmp r0,#0x0	; 02308EF8
	bne loc_02308F5A	; 02308EFA
	ldrh r0,[r5,#0x0]	; 02308EFC
	cmp r0,#0x20	; 02308EFE
	bcc loc_02308F48	; 02308F00
	add r0,r4,#0x0	; 02308F02
	bl loc_0230CC7C	; 02308F04
	ldr r0,[pool_02308F78]	; 02308F08
	ldr r0,[r0,#0x0]	; 02308F0A
	ldr r1,[pool_02308F88]	; 02308F0C
	ldrh r1,[r0,r1]	; 02308F0E
	cmp r1,#0x1	; 02308F10
	bne loc_02308F24	; 02308F12
	ldrh r0,[r5,#0x0]	; 02308F14
	cmp r0,#0x20	; 02308F16
	bls loc_02308F3E	; 02308F18
	add r0,r5,#0x4	; 02308F1A
	ldr r1,[sp,#0x0]	; 02308F1C
	bl loc_02309B68	; 02308F1E
	b loc_02308F3E	; 02308F22
loc_02308F24:
	ldr r1,[pool_02308F8C]	; 02308F24
	ldrh r0,[r0,r1]	; 02308F26
	cmp r4,r0	; 02308F28
	bne loc_02308F3E	; 02308F2A
	mov r0,#0x20	; 02308F2C
	bl loc_02306468	; 02308F2E
	bl loc_023064D4	; 02308F32
	add r0,r5,#0x4	; 02308F36
	ldr r1,[sp,#0x4]	; 02308F38
	bl loc_02309B68	; 02308F3A
loc_02308F3E:
	lsl r0,r4,#0x10	; 02308F3E
	lsr r0,r0,#0x10	; 02308F40
	mov r1,#0x20	; 02308F42
	bl loc_023091EC	; 02308F44
loc_02308F48:
	ldr r0,[sp,#0x8]	; 02308F48
	strh r0,[r5,#0x0]	; 02308F4A
	ldr r0,[pool_02308F78]	; 02308F4C
	ldr r1,[r0,#0x0]	; 02308F4E
	ldr r0,[pool_02308F80]	; 02308F50
	add r1,r1,r0	; 02308F52
	ldrh r0,[r1,#0x0]	; 02308F54
	sub r0,r0,#0x1	; 02308F56
	strh r0,[r1,#0x0]	; 02308F58
loc_02308F5A:
	add r6,r6,#0x1	; 02308F5A
	cmp r6,r7	; 02308F5C
	bcs loc_02308F70	; 02308F5E
loc_02308F60:
	add r4,r4,#0x1	; 02308F60
	add r5,#0x1c	; 02308F62
loc_02308F64:
	ldr r0,[pool_02308F78]	; 02308F64
	ldr r1,[r0,#0x0]	; 02308F66
	ldr r0,[pool_02308F90]	; 02308F68
	ldrh r0,[r1,r0]	; 02308F6A
	cmp r4,r0	; 02308F6C
	bcc loc_02308EDA	; 02308F6E
loc_02308F70:
	add sp,#0xc	; 02308F70
	pop {r4,r5,r6,r7}	; 02308F72
	pop {r3}	; 02308F74
	bx r3	; 02308F76
pool_02308F78:
loc_02308F78:
	.word FirmwareWlWorkPointerSlot	; 02308F78
pool_02308F7C:
loc_02308F7C:
	.word 0x000002E0	; 02308F7C
pool_02308F80:
loc_02308F80:
	.word 0x000004E8	; 02308F80
pool_02308F84:
loc_02308F84:
	.word 0x0000FFFF	; 02308F84
pool_02308F88:
loc_02308F88:
	.word 0x00000314	; 02308F88
pool_02308F8C:
loc_02308F8C:
	.word 0x00000384	; 02308F8C
pool_02308F90:
loc_02308F90:
	.word 0x000002E6	; 02308F90

; ===== function loc_02308F94 =====
loc_02308F94:
	push {r4,r5,r6,lr}	; 02308F94
	add r5,r0,#0x0	; 02308F96
	ldr r0,[pool_02309008]	; 02308F98
	ldr r1,[r0,#0x0]	; 02308F9A
	ldr r0,[pool_0230900C]	; 02308F9C
	ldrh r1,[r1,r0]	; 02308F9E
	ldr r0,[pool_02309010]	; 02308FA0
	add r4,r1,r0	; 02308FA2
	ldr r0,[pool_02309014]	; 02308FA4
	bl loc_02304B48	; 02308FA6
	add r6,r0,#0x0	; 02308FAA
	cmp r5,#0x0	; 02308FAC
	bne loc_02308FC8	; 02308FAE
	add r0,r4,#0x4	; 02308FB0
	bl loc_023053B4	; 02308FB2
	mov r1,#0xfe	; 02308FB6
	add r2,r0,#0x0	; 02308FB8
	and r2,r1	; 02308FBA
	add r0,r4,#0x4	; 02308FBC
	lsl r1,r2,#0x18	; 02308FBE
	lsr r1,r1,#0x18	; 02308FC0
	bl loc_023053D8	; 02308FC2
	b loc_02308FFA	; 02308FC6
loc_02308FC8:
	ldr r0,[pool_02309008]	; 02308FC8
	ldr r1,[r0,#0x0]	; 02308FCA
	ldr r0,[pool_02309018]	; 02308FCC
	ldr r1,[r1,r0]	; 02308FCE
	mov r0,#0x1c	; 02308FD0
	mul r5,r0	; 02308FD2
	add r0,r1,r5	; 02308FD4
	ldrh r5,[r0,#0x2]	; 02308FD6
	add r1,r4,#0x5	; 02308FD8
	lsr r0,r5,#0x3	; 02308FDA
	add r4,r1,r0	; 02308FDC
	add r0,r4,#0x0	; 02308FDE
	bl loc_023053B4	; 02308FE0
	mov r2,#0x1	; 02308FE4
	mov r1,#0x7	; 02308FE6
	and r5,r1	; 02308FE8
	lsl r2,r5	; 02308FEA
	mvn r1,r2	; 02308FEC
	and r1,r0	; 02308FEE
	add r0,r4,#0x0	; 02308FF0
	lsl r1,r1,#0x18	; 02308FF2
	lsr r1,r1,#0x18	; 02308FF4
	bl loc_023053D8	; 02308FF6
loc_02308FFA:
	add r0,r6,#0x0	; 02308FFA
	bl loc_02304B58	; 02308FFC
	pop {r4,r5,r6}	; 02309000
	pop {r3}	; 02309002
	bx r3	; 02309004
	.byte 0xC0, 0x46	; 02309008
pool_02309008:
loc_02309008:
	.word FirmwareWlWorkPointerSlot	; 02309008
pool_0230900C:
loc_0230900C:
	.word 0x00000390	; 0230900C
pool_02309010:
loc_02309010:
	.word 0x04804258	; 02309010
pool_02309014:
loc_02309014:
	.word 0x01000000	; 02309014
pool_02309018:
loc_02309018:
	.word 0x000002E0	; 02309018

; ===== function loc_0230901C =====
loc_0230901C:
	push {r4,r5,r6,lr}	; 0230901C
	add r5,r0,#0x0	; 0230901E
	ldr r0,[pool_0230908C]	; 02309020
	ldr r1,[r0,#0x0]	; 02309022
	ldr r0,[pool_02309090]	; 02309024
	ldrh r1,[r1,r0]	; 02309026
	ldr r0,[pool_02309094]	; 02309028
	add r4,r1,r0	; 0230902A
	ldr r0,[pool_02309098]	; 0230902C
	bl loc_02304B48	; 0230902E
	add r6,r0,#0x0	; 02309032
	cmp r5,#0x0	; 02309034
	bne loc_02309050	; 02309036
	add r0,r4,#0x4	; 02309038
	bl loc_023053B4	; 0230903A
	mov r1,#0x1	; 0230903E
	add r2,r0,#0x0	; 02309040
	orr r2,r1	; 02309042
	add r0,r4,#0x4	; 02309044
	lsl r1,r2,#0x18	; 02309046
	lsr r1,r1,#0x18	; 02309048
	bl loc_023053D8	; 0230904A
	b loc_02309080	; 0230904E
loc_02309050:
	ldr r0,[pool_0230908C]	; 02309050
	ldr r1,[r0,#0x0]	; 02309052
	ldr r0,[pool_0230909C]	; 02309054
	ldr r1,[r1,r0]	; 02309056
	mov r0,#0x1c	; 02309058
	mul r5,r0	; 0230905A
	add r0,r1,r5	; 0230905C
	ldrh r5,[r0,#0x2]	; 0230905E
	add r1,r4,#0x5	; 02309060
	lsr r0,r5,#0x3	; 02309062
	add r4,r1,r0	; 02309064
	add r0,r4,#0x0	; 02309066
	bl loc_023053B4	; 02309068
	mov r2,#0x1	; 0230906C
	mov r1,#0x7	; 0230906E
	and r5,r1	; 02309070
	lsl r2,r5	; 02309072
	orr r2,r0	; 02309074
	add r0,r4,#0x0	; 02309076
	lsl r1,r2,#0x18	; 02309078
	lsr r1,r1,#0x18	; 0230907A
	bl loc_023053D8	; 0230907C
loc_02309080:
	add r0,r6,#0x0	; 02309080
	bl loc_02304B58	; 02309082
	pop {r4,r5,r6}	; 02309086
	pop {r3}	; 02309088
	bx r3	; 0230908A
pool_0230908C:
loc_0230908C:
	.word FirmwareWlWorkPointerSlot	; 0230908C
pool_02309090:
loc_02309090:
	.word 0x00000390	; 02309090
pool_02309094:
loc_02309094:
	.word 0x04804258	; 02309094
pool_02309098:
loc_02309098:
	.word 0x01000000	; 02309098
pool_0230909C:
loc_0230909C:
	.word 0x000002E0	; 0230909C

; ===== function loc_023090A0 =====
loc_023090A0:
	push {r4,lr}	; 023090A0
	ldr r2,[pool_023090E4]	; 023090A2
	ldr r3,[r2,#0x0]	; 023090A4
	ldr r1,[pool_023090E8]	; 023090A6
	ldr r1,[r3,r1]	; 023090A8
	add r4,r1,#0x2	; 023090AA
	mov r1,#0x1c	; 023090AC
	mul r0,r1	; 023090AE
	mov r1,#0x1	; 023090B0
	ldrh r3,[r4,r0]	; 023090B2
	lsl r1,r3	; 023090B4
	mov r3,#0x0	; 023090B6
	strh r3,[r4,r0]	; 023090B8
	ldr r3,[r2,#0x0]	; 023090BA
	ldr r0,[pool_023090EC]	; 023090BC
	add r3,r3,r0	; 023090BE
	ldrh r0,[r3,#0x0]	; 023090C0
	bic r0,r1	; 023090C2
	strh r0,[r3,#0x0]	; 023090C4
	ldr r1,[r2,#0x0]	; 023090C6
	ldr r0,[pool_023090F0]	; 023090C8
	add r3,r1,r0	; 023090CA
	ldrh r1,[r3,#0x0]	; 023090CC
	sub r1,r1,#0x1	; 023090CE
	strh r1,[r3,#0x0]	; 023090D0
	ldr r1,[r2,#0x0]	; 023090D2
	ldrh r0,[r1,r0]	; 023090D4
	cmp r0,#0x0	; 023090D6
	bne loc_023090DE	; 023090D8
	bl loc_02306694	; 023090DA
loc_023090DE:
	pop {r4}	; 023090DE
	pop {r3}	; 023090E0
	bx r3	; 023090E2
pool_023090E4:
loc_023090E4:
	.word FirmwareWlWorkPointerSlot	; 023090E4
pool_023090E8:
loc_023090E8:
	.word 0x000002E0	; 023090E8
pool_023090EC:
loc_023090EC:
	.word 0x000004F2	; 023090EC
pool_023090F0:
loc_023090F0:
	.word 0x000004F0	; 023090F0

; ===== function loc_023090F4 =====
loc_023090F4:
	push {r4,r5,r6,r7,lr}	; 023090F4
	sub sp,#0x4	; 023090F6
	add r5,r0,#0x0	; 023090F8
	ldr r0,[pool_0230916C]	; 023090FA
	bl loc_02304B48	; 023090FC
	add r6,r0,#0x0	; 02309100
	mov r4,#0x1	; 02309102
	mov r3,#0x2	; 02309104
	ldr r2,[pool_02309170]	; 02309106
	ldr r7,[pool_02309174]	; 02309108
	b loc_02309156	; 0230910A
loc_0230910C:
	ldr r1,[r2,#0x0]	; 0230910C
	ldrh r0,[r1,r7]	; 0230910E
	and r0,r3	; 02309110
	cmp r0,#0x0	; 02309112
	bne loc_02309152	; 02309114
	ldr r0,[pool_02309174]	; 02309116
	add r1,r1,r0	; 02309118
	ldrh r0,[r1,#0x0]	; 0230911A
	orr r0,r3	; 0230911C
	strh r0,[r1,#0x0]	; 0230911E
	ldr r0,[r2,#0x0]	; 02309120
	ldr r1,[pool_02309178]	; 02309122
	add r0,r0,r1	; 02309124
	ldrh r3,[r0,#0x0]	; 02309126
	add r3,r3,#0x1	; 02309128
	strh r3,[r0,#0x0]	; 0230912A
	ldr r0,[r2,#0x0]	; 0230912C
	ldrh r0,[r0,r1]	; 0230912E
	cmp r0,#0x1	; 02309130
	bne loc_02309138	; 02309132
	bl loc_02306670	; 02309134
loc_02309138:
	ldr r0,[pool_02309170]	; 02309138
	ldr r1,[r0,#0x0]	; 0230913A
	ldr r0,[pool_0230917C]	; 0230913C
	ldr r1,[r1,r0]	; 0230913E
	mov r0,#0x1c	; 02309140
	mul r5,r0	; 02309142
	add r0,r1,r5	; 02309144
	strh r4,[r0,#0x2]	; 02309146
	add r0,r6,#0x0	; 02309148
	bl loc_02304B58	; 0230914A
	add r0,r4,#0x0	; 0230914E
	b loc_02309162	; 02309150
loc_02309152:
	add r4,r4,#0x1	; 02309152
	lsl r3,r3,#0x1	; 02309154
loc_02309156:
	cmp r4,#0x10	; 02309156
	bcc loc_0230910C	; 02309158
	add r0,r6,#0x0	; 0230915A
	bl loc_02304B58	; 0230915C
	mov r0,#0x0	; 02309160
loc_02309162:
	add sp,#0x4	; 02309162
	pop {r4,r5,r6,r7}	; 02309164
	pop {r3}	; 02309166
	bx r3	; 02309168
	.byte 0xC0, 0x46	; 0230916C
pool_0230916C:
loc_0230916C:
	.word 0x01000000	; 0230916C
pool_02309170:
loc_02309170:
	.word FirmwareWlWorkPointerSlot	; 02309170
pool_02309174:
loc_02309174:
	.word 0x000004F2	; 02309174
pool_02309178:
loc_02309178:
	.word 0x000004F0	; 02309178
pool_0230917C:
loc_0230917C:
	.word 0x000002E0	; 0230917C

; ===== function loc_02309180 =====
loc_02309180:
	push {r4,r5,r6,lr}	; 02309180
	ldr r6,[pool_023091BC]	; 02309182
	ldr r2,[r6,#0x0]	; 02309184
	ldr r3,[pool_023091C0]	; 02309186
	add r2,r2,r3	; 02309188
	ldrh r5,[r2,#0x0]	; 0230918A
	mov r4,#0x1	; 0230918C
	lsl r4,r0	; 0230918E
	bic r5,r4	; 02309190
	lsl r1,r0	; 02309192
	orr r5,r1	; 02309194
	strh r5,[r2,#0x0]	; 02309196
	ldr r2,[r6,#0x0]	; 02309198
	ldrh r1,[r2,r3]	; 0230919A
	ldr r0,[pool_023091C4]	; 0230919C
	ldrh r0,[r2,r0]	; 0230919E
	bic r1,r0	; 023091A0
	cmp r1,#0x0	; 023091A2
	beq loc_023091AE	; 023091A4
	mov r1,#0x8	; 023091A6
	ldr r0,[pool_023091C8]	; 023091A8
	strh r1,[r0,#0x0]	; 023091AA
	b loc_023091B4	; 023091AC
loc_023091AE:
	mov r1,#0x8	; 023091AE
	ldr r0,[pool_023091CC]	; 023091B0
	strh r1,[r0,#0x0]	; 023091B2
loc_023091B4:
	pop {r4,r5,r6}	; 023091B4
	pop {r3}	; 023091B6
	bx r3	; 023091B8
	.byte 0xC0, 0x46	; 023091BC
pool_023091BC:
loc_023091BC:
	.word FirmwareWlWorkPointerSlot	; 023091BC
pool_023091C0:
loc_023091C0:
	.word 0x000004EA	; 023091C0
pool_023091C4:
loc_023091C4:
	.word 0x000004EE	; 023091C4
pool_023091C8:
loc_023091C8:
	.word REG_WIFI_TXREQ_RESET	; 023091C8
pool_023091CC:
loc_023091CC:
	.word REG_WIFI_TXREQ_SET	; 023091CC

; ===== function loc_023091D0 =====
loc_023091D0:
	ldr r2,[pool_023091E4]	; 023091D0
	ldr r3,[r2,#0x0]	; 023091D2
	ldr r2,[pool_023091E8]	; 023091D4
	ldr r3,[r3,r2]	; 023091D6
	mov r2,#0x1c	; 023091D8
	mul r0,r2	; 023091DA
	add r0,r3,r0	; 023091DC
	strh r1,[r0,#0xa]	; 023091DE
	bx lr	; 023091E0
	.byte 0xC0, 0x46	; 023091E4
pool_023091E4:
loc_023091E4:
	.word FirmwareWlWorkPointerSlot	; 023091E4
pool_023091E8:
loc_023091E8:
	.word 0x000002E0	; 023091E8

; ===== function loc_023091EC =====
loc_023091EC:
	push {r4,r5,r6,r7,lr}	; 023091EC
	sub sp,#0x4	; 023091EE
	add r5,r0,#0x0	; 023091F0
	add r4,r1,#0x0	; 023091F2
	ldr r0,[pool_0230929C]	; 023091F4
	bl loc_02304B48	; 023091F6
	add r7,r0,#0x0	; 023091FA
	cmp r4,#0x40	; 023091FC
	bcs loc_02309240	; 023091FE
	mov r1,#0x1	; 02309200
	lsl r1,r5	; 02309202
	ldr r0,[pool_023092A0]	; 02309204
	ldr r3,[r0,#0x0]	; 02309206
	ldr r2,[pool_023092A4]	; 02309208
	add r3,r3,r2	; 0230920A
	ldrh r2,[r3,#0x0]	; 0230920C
	orr r2,r1	; 0230920E
	strh r2,[r3,#0x0]	; 02309210
	ldr r3,[r0,#0x0]	; 02309212
	ldr r2,[pool_023092A8]	; 02309214
	add r3,r3,r2	; 02309216
	ldrh r2,[r3,#0x0]	; 02309218
	orr r2,r1	; 0230921A
	strh r2,[r3,#0x0]	; 0230921C
	ldr r1,[r0,#0x0]	; 0230921E
	ldr r0,[pool_023092AC]	; 02309220
	ldrh r0,[r1,r0]	; 02309222
	cmp r0,#0x1	; 02309224
	bne loc_0230927E	; 02309226
	ldr r0,[pool_023092B0]	; 02309228
	ldr r2,[r1,r0]	; 0230922A
	mov r0,#0x1c	; 0230922C
	add r1,r5,#0x0	; 0230922E
	mul r1,r0	; 02309230
	ldrh r0,[r2,r1]	; 02309232
	cmp r0,#0x40	; 02309234
	bne loc_0230927E	; 02309236
	add r0,r5,#0x0	; 02309238
	bl loc_023090A0	; 0230923A
	b loc_0230927E	; 0230923E
loc_02309240:
	mov r0,#0x1	; 02309240
	lsl r0,r5	; 02309242
	mvn r6,r0	; 02309244
	ldr r3,[pool_023092A0]	; 02309246
	ldr r2,[r3,#0x0]	; 02309248
	ldr r1,[pool_023092A8]	; 0230924A
	add r2,r2,r1	; 0230924C
	ldrh r1,[r2,#0x0]	; 0230924E
	bic r1,r0	; 02309250
	strh r1,[r2,#0x0]	; 02309252
	ldr r3,[r3,#0x0]	; 02309254
	ldr r0,[pool_023092B4]	; 02309256
	ldrh r1,[r3,r0]	; 02309258
	asr r1,r5	; 0230925A
	mov r0,#0x1	; 0230925C
	and r1,r0	; 0230925E
	cmp r1,#0x0	; 02309260
	beq loc_0230927E	; 02309262
	ldr r0,[pool_023092B0]	; 02309264
	ldr r2,[r3,r0]	; 02309266
	mov r0,#0x1c	; 02309268
	add r1,r5,#0x0	; 0230926A
	mul r1,r0	; 0230926C
	ldrh r0,[r2,r1]	; 0230926E
	cmp r0,#0x40	; 02309270
	bne loc_0230927E	; 02309272
	ldr r0,[pool_023092A4]	; 02309274
	add r1,r3,r0	; 02309276
	ldrh r0,[r1,#0x0]	; 02309278
	and r0,r6	; 0230927A
	strh r0,[r1,#0x0]	; 0230927C
loc_0230927E:
	ldr r0,[pool_023092A0]	; 0230927E
	ldr r1,[r0,#0x0]	; 02309280
	ldr r0,[pool_023092B0]	; 02309282
	ldr r1,[r1,r0]	; 02309284
	mov r0,#0x1c	; 02309286
	mul r5,r0	; 02309288
	strh r4,[r1,r5]	; 0230928A
	add r0,r7,#0x0	; 0230928C
	bl loc_02304B58	; 0230928E
	add sp,#0x4	; 02309292
	pop {r4,r5,r6,r7}	; 02309294
	pop {r3}	; 02309296
	bx r3	; 02309298
	.byte 0xC0, 0x46	; 0230929C
pool_0230929C:
loc_0230929C:
	.word 0x01000000	; 0230929C
pool_023092A0:
loc_023092A0:
	.word FirmwareWlWorkPointerSlot	; 023092A0
pool_023092A4:
loc_023092A4:
	.word 0x000004EC	; 023092A4
pool_023092A8:
loc_023092A8:
	.word 0x000004EE	; 023092A8
pool_023092AC:
loc_023092AC:
	.word 0x00000314	; 023092AC
pool_023092B0:
loc_023092B0:
	.word 0x000002E0	; 023092B0
pool_023092B4:
loc_023092B4:
	.word 0x000004EA	; 023092B4

; ===== function loc_023092B8 =====
loc_023092B8:
	push {r4,r5,r6,lr}	; 023092B8
	ldrh r4,[r0,#0x2]	; 023092BA
	ldr r0,[pool_02309300]	; 023092BC
	ldr r1,[r0,#0x0]	; 023092BE
	ldr r0,[pool_02309304]	; 023092C0
	ldr r2,[r1,r0]	; 023092C2
	mov r0,#0x1c	; 023092C4
	add r1,r4,#0x0	; 023092C6
	mul r1,r0	; 023092C8
	add r5,r2,r1	; 023092CA
	ldr r0,[pool_02309308]	; 023092CC
	bl loc_02304B48	; 023092CE
	add r6,r0,#0x0	; 023092D2
	ldr r0,[pool_02309300]	; 023092D4
	ldr r1,[r0,#0x0]	; 023092D6
	ldr r0,[pool_0230930C]	; 023092D8
	ldrh r0,[r1,r0]	; 023092DA
	cmp r0,#0x1	; 023092DC
	bne loc_023092EC	; 023092DE
	ldrh r0,[r5,#0x16]	; 023092E0
	cmp r0,#0x1	; 023092E2
	bne loc_023092EC	; 023092E4
	add r0,r4,#0x0	; 023092E6
	bl loc_02308F94	; 023092E8
loc_023092EC:
	add r5,#0x16	; 023092EC
	ldrh r0,[r5,#0x0]	; 023092EE
	sub r0,r0,#0x1	; 023092F0
	strh r0,[r5,#0x0]	; 023092F2
	add r0,r6,#0x0	; 023092F4
	bl loc_02304B58	; 023092F6
	pop {r4,r5,r6}	; 023092FA
	pop {r3}	; 023092FC
	bx r3	; 023092FE
pool_02309300:
loc_02309300:
	.word FirmwareWlWorkPointerSlot	; 02309300
pool_02309304:
loc_02309304:
	.word 0x000002E0	; 02309304
pool_02309308:
loc_02309308:
	.word 0x01000000	; 02309308
pool_0230930C:
loc_0230930C:
	.word 0x00000314	; 0230930C

; ===== function loc_02309310 =====
loc_02309310:
	push {r4,r5,r6,lr}	; 02309310
	ldrh r4,[r0,#0x2]	; 02309312
	ldr r0,[pool_02309360]	; 02309314
	ldr r1,[r0,#0x0]	; 02309316
	ldr r0,[pool_02309364]	; 02309318
	ldr r2,[r1,r0]	; 0230931A
	mov r0,#0x1c	; 0230931C
	add r1,r4,#0x0	; 0230931E
	mul r1,r0	; 02309320
	add r5,r2,r1	; 02309322
	ldr r0,[pool_02309368]	; 02309324
	bl loc_02304B48	; 02309326
	add r6,r0,#0x0	; 0230932A
	ldr r0,[pool_02309360]	; 0230932C
	ldr r1,[r0,#0x0]	; 0230932E
	ldr r0,[pool_0230936C]	; 02309330
	ldrh r0,[r1,r0]	; 02309332
	cmp r0,#0x1	; 02309334
	bne loc_02309344	; 02309336
	ldrh r0,[r5,#0x16]	; 02309338
	cmp r0,#0x0	; 0230933A
	bne loc_02309344	; 0230933C
	add r0,r4,#0x0	; 0230933E
	bl loc_0230901C	; 02309340
loc_02309344:
	add r1,r5,#0x0	; 02309344
	add r1,#0x16	; 02309346
	ldrh r0,[r1,#0x0]	; 02309348
	add r0,r0,#0x1	; 0230934A
	strh r0,[r1,#0x0]	; 0230934C
	add r0,r6,#0x0	; 0230934E
	bl loc_02304B58	; 02309350
	ldrh r0,[r5,#0x1a]	; 02309354
	strh r0,[r5,#0x18]	; 02309356
	pop {r4,r5,r6}	; 02309358
	pop {r3}	; 0230935A
	bx r3	; 0230935C
	.byte 0xC0, 0x46	; 02309360
pool_02309360:
loc_02309360:
	.word FirmwareWlWorkPointerSlot	; 02309360
pool_02309364:
loc_02309364:
	.word 0x000002E0	; 02309364
pool_02309368:
loc_02309368:
	.word 0x01000000	; 02309368
pool_0230936C:
loc_0230936C:
	.word 0x00000314	; 0230936C
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x0D, 0x48, 0xFB, 0xF7, 0xE6, 0xFB, 0x06, 0x1C, 0x0C, 0x48	; 02309380
	.byte 0x01, 0x68, 0x0C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x02, 0xD1, 0x00, 0x20, 0xFF, 0xF7, 0x46, 0xFE	; 02309390
	.byte 0x28, 0x1C, 0x07, 0x49, 0x0A, 0x68, 0x08, 0x49, 0x51, 0x18, 0x22, 0x1C, 0xFB, 0xF7, 0x04, 0xFE	; 023093A0
	.byte 0x30, 0x1C, 0xFB, 0xF7, 0xD9, 0xFB, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x00, 0x01	; 023093B0
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x78, 0x01, 0x00, 0x00, 0x70, 0x01, 0x00, 0x00	; 023093BC

; ===== function loc_023093BC =====
loc_023093BC:
	push {r4,r5,r6,r7,lr}	; 023093BC
	sub sp,#0xc	; 023093BE
	add r5,r0,#0x0	; 023093C0
	ldrh r0,[r5,#0x0]	; 023093C2
	str r0,[sp,#0x4]	; 023093C4
	mov r4,#0x1	; 023093C6
	and r0,r4	; 023093C8
	cmp r0,#0x0	; 023093CA
	beq loc_023093D2	; 023093CC
	mov r0,#0x0	; 023093CE
	b loc_0230947E	; 023093D0
loc_023093D2:
	ldr r0,[pool_02309488]	; 023093D2
	ldr r0,[r0,#0x0]	; 023093D4
	ldr r1,[pool_0230948C]	; 023093D6
	ldrh r1,[r0,r1]	; 023093D8
	str r1,[sp,#0x8]	; 023093DA
	cmp r1,#0x1	; 023093DC
	bls loc_02309434	; 023093DE
	ldr r1,[pool_02309490]	; 023093E0
	ldr r2,[r0,r1]	; 023093E2
	add r2,#0x1c	; 023093E4
	mov r1,#0x0	; 023093E6
	add r7,r1,#0x0	; 023093E8
	ldr r3,[pool_02309494]	; 023093EA
	ldrh r3,[r0,r3]	; 023093EC
	str r3,[sp,#0x0]	; 023093EE
	b loc_02309428	; 023093F0
loc_023093F2:
	ldrh r3,[r2,#0x0]	; 023093F2
	cmp r3,#0x0	; 023093F4
	beq loc_0230941E	; 023093F6
	ldrh r6,[r2,#0x8]	; 023093F8
	ldrh r3,[r5,#0x4]	; 023093FA
	cmp r6,r3	; 023093FC
	bne loc_02309414	; 023093FE
	ldrh r6,[r2,#0x6]	; 02309400
	ldrh r3,[r5,#0x2]	; 02309402
	cmp r6,r3	; 02309404
	bne loc_02309414	; 02309406
	ldrh r6,[r2,#0x4]	; 02309408
	ldr r3,[sp,#0x4]	; 0230940A
	cmp r6,r3	; 0230940C
	bne loc_02309414	; 0230940E
	add r0,r4,#0x0	; 02309410
	b loc_0230947E	; 02309412
loc_02309414:
	add r7,r7,#0x1	; 02309414
	ldr r3,[sp,#0x8]	; 02309416
	cmp r7,r3	; 02309418
	bcc loc_02309424	; 0230941A
	b loc_0230942E	; 0230941C
loc_0230941E:
	cmp r1,#0x0	; 0230941E
	bne loc_02309424	; 02309420
	add r1,r4,#0x0	; 02309422
loc_02309424:
	add r4,r4,#0x1	; 02309424
	add r2,#0x1c	; 02309426
loc_02309428:
	ldr r3,[sp,#0x0]	; 02309428
	cmp r4,r3	; 0230942A
	bcc loc_023093F2	; 0230942C
loc_0230942E:
	cmp r1,#0x0	; 0230942E
	beq loc_02309434	; 02309430
	add r4,r1,#0x0	; 02309432
loc_02309434:
	ldr r1,[pool_02309494]	; 02309434
	ldrh r2,[r0,r1]	; 02309436
	cmp r4,r2	; 02309438
	bcc loc_02309474	; 0230943A
	ldr r1,[pool_02309490]	; 0230943C
	ldr r7,[r0,r1]	; 0230943E
	ldr r3,[pool_02309498]	; 02309440
	mov r1,#0x1	; 02309442
	mov r4,#0x0	; 02309444
	b loc_02309468	; 02309446
loc_02309448:
	add r6,r1,#0x0	; 02309448
	mov r0,#0x1c	; 0230944A
	mul r6,r0	; 0230944C
	add r0,r7,r6	; 0230944E
	ldrh r6,[r7,r6]	; 02309450
	cmp r6,#0x30	; 02309452
	bcs loc_02309466	; 02309454
	ldrh r6,[r0,#0x16]	; 02309456
	cmp r6,#0x0	; 02309458
	bne loc_02309466	; 0230945A
	ldrh r0,[r0,#0x18]	; 0230945C
	cmp r3,r0	; 0230945E
	bls loc_02309466	; 02309460
	add r3,r0,#0x0	; 02309462
	add r4,r1,#0x0	; 02309464
loc_02309466:
	add r1,r1,#0x1	; 02309466
loc_02309468:
	cmp r1,r2	; 02309468
	bcc loc_02309448	; 0230946A
	cmp r4,#0x0	; 0230946C
	bne loc_02309474	; 0230946E
	mov r0,#0xff	; 02309470
	b loc_0230947E	; 02309472
loc_02309474:
	add r0,r4,#0x0	; 02309474
	add r1,r5,#0x0	; 02309476
	bl loc_02308CD0	; 02309478
	add r0,r4,#0x0	; 0230947C
loc_0230947E:
	add sp,#0xc	; 0230947E
	pop {r4,r5,r6,r7}	; 02309480
	pop {r3}	; 02309482
	bx r3	; 02309484
	.byte 0xC0, 0x46	; 02309488
pool_02309488:
loc_02309488:
	.word FirmwareWlWorkPointerSlot	; 02309488
pool_0230948C:
loc_0230948C:
	.word 0x000004E8	; 0230948C
pool_02309490:
loc_02309490:
	.word 0x000002E0	; 02309490
pool_02309494:
loc_02309494:
	.word 0x000002E6	; 02309494
pool_02309498:
loc_02309498:
	.word 0x00010000	; 02309498

; ===== function loc_0230949C =====
loc_0230949C:
	push {r4,r5,r6,r7,lr}	; 0230949C
	sub sp,#0x4	; 0230949E
	add r4,r0,#0x0	; 023094A0
	ldrh r0,[r4,#0x0]	; 023094A2
	str r0,[sp,#0x0]	; 023094A4
	mov r2,#0x1	; 023094A6
	and r0,r2	; 023094A8
	cmp r0,#0x0	; 023094AA
	beq loc_023094B2	; 023094AC
	mov r0,#0x0	; 023094AE
	b loc_023094FE	; 023094B0
loc_023094B2:
	ldr r0,[pool_02309508]	; 023094B2
	ldr r0,[r0,#0x0]	; 023094B4
	ldr r1,[pool_0230950C]	; 023094B6
	ldrh r7,[r0,r1]	; 023094B8
	cmp r7,#0x1	; 023094BA
	bls loc_023094FC	; 023094BC
	ldr r1,[pool_02309510]	; 023094BE
	ldr r3,[r0,r1]	; 023094C0
	add r3,#0x1c	; 023094C2
	mov r1,#0x0	; 023094C4
	ldr r5,[pool_02309514]	; 023094C6
	ldrh r0,[r0,r5]	; 023094C8
	b loc_023094F8	; 023094CA
loc_023094CC:
	ldrh r5,[r3,#0x0]	; 023094CC
	cmp r5,#0x0	; 023094CE
	beq loc_023094F4	; 023094D0
	ldrh r6,[r3,#0x8]	; 023094D2
	ldrh r5,[r4,#0x4]	; 023094D4
	cmp r6,r5	; 023094D6
	bne loc_023094EE	; 023094D8
	ldrh r6,[r3,#0x6]	; 023094DA
	ldrh r5,[r4,#0x2]	; 023094DC
	cmp r6,r5	; 023094DE
	bne loc_023094EE	; 023094E0
	ldrh r6,[r3,#0x4]	; 023094E2
	ldr r5,[sp,#0x0]	; 023094E4
	cmp r6,r5	; 023094E6
	bne loc_023094EE	; 023094E8
	add r0,r2,#0x0	; 023094EA
	b loc_023094FE	; 023094EC
loc_023094EE:
	add r1,r1,#0x1	; 023094EE
	cmp r1,r7	; 023094F0
	bcs loc_023094FC	; 023094F2
loc_023094F4:
	add r2,r2,#0x1	; 023094F4
	add r3,#0x1c	; 023094F6
loc_023094F8:
	cmp r2,r0	; 023094F8
	bcc loc_023094CC	; 023094FA
loc_023094FC:
	mov r0,#0xff	; 023094FC
loc_023094FE:
	add sp,#0x4	; 023094FE
	pop {r4,r5,r6,r7}	; 02309500
	pop {r3}	; 02309502
	bx r3	; 02309504
	.byte 0xC0, 0x46	; 02309508
pool_02309508:
loc_02309508:
	.word FirmwareWlWorkPointerSlot	; 02309508
pool_0230950C:
loc_0230950C:
	.word 0x000004E8	; 0230950C
pool_02309510:
loc_02309510:
	.word 0x000002E0	; 02309510
pool_02309514:
loc_02309514:
	.word 0x000002E6	; 02309514

; ===== function loc_02309518 =====
loc_02309518:
	mov r2,#0x0	; 02309518
	ldr r0,[pool_02309524]	; 0230951A
	ldr r1,[r0,#0x0]	; 0230951C
	ldr r0,[pool_02309528]	; 0230951E
	strh r2,[r1,r0]	; 02309520
	bx lr	; 02309522
pool_02309524:
loc_02309524:
	.word FirmwareWlWorkPointerSlot	; 02309524
pool_02309528:
loc_02309528:
	.word 0x000003E0	; 02309528

; ===== function loc_0230952C =====
	push {r4,r5,r6,r7,lr}	; 0230952C
	sub sp,#0x4	; 0230952E
	ldr r4,[pool_02309568]	; 02309530
	ldr r1,[r4,#0x0]	; 02309532
	ldr r6,[pool_0230956C]	; 02309534
	ldr r5,[r1,r6]	; 02309536
	mov r7,#0x0	; 02309538
	b loc_0230955A	; 0230953A
loc_0230953C:
	ldr r0,[pool_02309570]	; 0230953C
	ldr r0,[r1,r0]	; 0230953E
	add r1,r5,#0x0	; 02309540
	add r2,r7,#0x0	; 02309542
	bl loc_02300824	; 02309544
	cmp r0,#0x0	; 02309548
	beq loc_02309560	; 0230954A
	ldr r0,[r4,#0x0]	; 0230954C
	add r0,r0,r6	; 0230954E
	add r1,r5,#0x0	; 02309550
	bl loc_02304E60	; 02309552
	ldr r1,[r4,#0x0]	; 02309556
	ldr r5,[r1,r6]	; 02309558
loc_0230955A:
	mvn r0,r7	; 0230955A
	cmp r5,r0	; 0230955C
	bne loc_0230953C	; 0230955E
loc_02309560:
	add sp,#0x4	; 02309560
	pop {r4,r5,r6,r7}	; 02309562
	pop {r3}	; 02309564
	bx r3	; 02309566
pool_02309568:
loc_02309568:
	.word FirmwareWlWorkPointerSlot	; 02309568
pool_0230956C:
loc_0230956C:
	.word 0x000001B8	; 0230956C
pool_02309570:
loc_02309570:
	.word 0x000002C8	; 02309570

; ===== function loc_02309574 =====
loc_02309574:
	push {r4,r5,lr}	; 02309574
	sub sp,#0x4	; 02309576
	add r5,r0,#0x0	; 02309578
	add r4,r1,#0x0	; 0230957A
	ldr r2,[pool_023095CC]	; 0230957C
	ldr r2,[r2,#0x0]	; 0230957E
	ldr r3,[pool_023095D0]	; 02309580
	ldrh r3,[r2,r3]	; 02309582
	cmp r3,#0x0	; 02309584
	beq loc_0230959C	; 02309586
	ldr r1,[pool_023095D4]	; 02309588
	add r1,r2,r1	; 0230958A
	add r2,r4,#0x0	; 0230958C
	bl loc_02304FA8	; 0230958E
	mov r0,#0x2	; 02309592
	mov r1,#0x13	; 02309594
	bl loc_02304B68	; 02309596
	b loc_023095C4	; 0230959A
loc_0230959C:
	ldr r0,[pool_023095D8]	; 0230959C
	ldr r0,[r2,r0]	; 0230959E
	mov r2,#0x0	; 023095A0
	bl loc_02300824	; 023095A2
	cmp r0,#0x0	; 023095A6
	beq loc_023095B4	; 023095A8
	add r0,r5,#0x0	; 023095AA
	add r1,r4,#0x0	; 023095AC
	bl loc_02304E60	; 023095AE
	b loc_023095C4	; 023095B2
loc_023095B4:
	add r0,r5,#0x0	; 023095B4
	ldr r1,[pool_023095CC]	; 023095B6
	ldr r2,[r1,#0x0]	; 023095B8
	ldr r1,[pool_023095D4]	; 023095BA
	add r1,r2,r1	; 023095BC
	add r2,r4,#0x0	; 023095BE
	bl loc_02304FA8	; 023095C0
loc_023095C4:
	add sp,#0x4	; 023095C4
	pop {r4,r5}	; 023095C6
	pop {r3}	; 023095C8
	bx r3	; 023095CA
pool_023095CC:
loc_023095CC:
	.word FirmwareWlWorkPointerSlot	; 023095CC
pool_023095D0:
loc_023095D0:
	.word 0x000001C0	; 023095D0
pool_023095D4:
loc_023095D4:
	.word 0x000001B8	; 023095D4
pool_023095D8:
loc_023095D8:
	.word 0x000002C8	; 023095D8
	.byte 0x03, 0x20, 0x70, 0x47	; 023095E0

; ===== function loc_023095E0 =====
	push {r4,r5,r6,r7,lr}	; 023095E0
	sub sp,#0xc	; 023095E2
	mov r6,#0x0	; 023095E4
	add r5,r6,#0x0	; 023095E6
	ldr r1,[pool_023097B4]	; 023095E8
	ldr r0,[r1,#0x0]	; 023095EA
	ldr r2,[pool_023097B8]	; 023095EC
	ldrh r2,[r0,r2]	; 023095EE
	cmp r2,#0x0	; 023095F0
	beq loc_023095F6	; 023095F2
	b loc_023097AA	; 023095F4
loc_023095F6:
	ldr r2,[pool_023097BC]	; 023095F6
	ldr r3,[r0,r2]	; 023095F8
	ldr r2,[pool_023097C0]	; 023095FA
	str r3,[r0,r2]	; 023095FC
	ldr r3,[r1,#0x0]	; 023095FE
	ldr r0,[r3,r2]	; 02309600
	str r0,[sp,#0x0]	; 02309602
	mvn r1,r6	; 02309604
	cmp r0,r1	; 02309606
	bne loc_0230960C	; 02309608
	b loc_023097AA	; 0230960A
loc_0230960C:
	ldrh r0,[r0,#0xe]	; 0230960C
	lsl r1,r0,#0x1	; 0230960E
	ldr r0,[sp,#0x0]	; 02309610
	add r4,r0,r1	; 02309612
	add r4,#0x10	; 02309614
	ldr r0,[pool_023097C4]	; 02309616
	ldrh r0,[r3,r0]	; 02309618
	cmp r0,#0x0	; 0230961A
	beq loc_02309628	; 0230961C
	mov r0,#0x1	; 0230961E
	strh r0,[r4,#0x2]	; 02309620
	mov r0,#0x6	; 02309622
	strh r0,[r4,#0x4]	; 02309624
	b loc_0230977A	; 02309626
loc_02309628:
	ldr r0,[sp,#0x0]	; 02309628
	ldrh r1,[r0,#0xc]	; 0230962A
	ldrh r0,[r4,#0x0]	; 0230962C
	cmp r1,r0	; 0230962E
	beq loc_02309638	; 02309630
	mov r0,#0xd	; 02309632
	strh r0,[r4,#0x4]	; 02309634
	b loc_0230977A	; 02309636
loc_02309638:
	ldr r2,[pool_023097C8]	; 02309638
	add r0,r1,#0x0	; 0230963A
	and r0,r2	; 0230963C
	ldr r2,[pool_023097CC]	; 0230963E
	cmp r0,r2	; 02309640
	bgt loc_0230964E	; 02309642
	cmp r0,r2	; 02309644
	bge loc_0230968A	; 02309646
	cmp r0,#0x0	; 02309648
	beq loc_02309662	; 0230964A
	b loc_02309710	; 0230964C
loc_0230964E:
	ldr r2,[pool_023097D0]	; 0230964E
	cmp r0,r2	; 02309650
	bgt loc_0230965A	; 02309652
	cmp r0,r2	; 02309654
	beq loc_023096A4	; 02309656
	b loc_02309710	; 02309658
loc_0230965A:
	ldr r2,[pool_023097D4]	; 0230965A
	cmp r0,r2	; 0230965C
	beq loc_02309700	; 0230965E
	b loc_02309710	; 02309660
loc_02309662:
	mov r5,#0x1	; 02309662
	ldr r7,[pool_023097D8]	; 02309664
	mov r0,#0xff	; 02309666
	and r1,r0	; 02309668
	lsl r0,r1,#0x10	; 0230966A
	lsr r2,r0,#0x10	; 0230966C
	mov r0,#0xb	; 0230966E
	ldr r1,[pool_023097B8]	; 02309670
	ldrh r1,[r3,r1]	; 02309672
	and r1,r5	; 02309674
	cmp r1,#0x0	; 02309676
	beq loc_0230967E	; 02309678
	mov r6,#0x2	; 0230967A
	b loc_02309714	; 0230967C
loc_0230967E:
	ldr r1,[pool_023097DC]	; 0230967E
	ldrh r1,[r3,r1]	; 02309680
	cmp r1,#0x20	; 02309682
	bcs loc_02309714	; 02309684
	add r6,r5,#0x0	; 02309686
	b loc_02309714	; 02309688
loc_0230968A:
	mov r5,#0x2	; 0230968A
	ldr r7,[pool_023097E0]	; 0230968C
	mov r0,#0xff	; 0230968E
	and r1,r0	; 02309690
	lsl r0,r1,#0x10	; 02309692
	lsr r2,r0,#0x10	; 02309694
	mov r0,#0x5	; 02309696
	ldr r1,[pool_023097DC]	; 02309698
	ldrh r1,[r3,r1]	; 0230969A
	cmp r1,#0x40	; 0230969C
	beq loc_02309714	; 0230969E
	mov r6,#0x1	; 023096A0
	b loc_02309714	; 023096A2
loc_023096A4:
	mov r0,#0xff	; 023096A4
	and r1,r0	; 023096A6
	lsl r0,r1,#0x10	; 023096A8
	lsr r2,r0,#0x10	; 023096AA
	cmp r2,#0x40	; 023096AC
	bcs loc_023096C2	; 023096AE
	ldr r0,[pool_023097DC]	; 023096B0
	ldrh r0,[r3,r0]	; 023096B2
	cmp r0,#0x10	; 023096B4
	bcs loc_023096BA	; 023096B6
	mov r6,#0x1	; 023096B8
loc_023096BA:
	mov r5,#0x4	; 023096BA
	ldr r7,[pool_023097E4]	; 023096BC
	mov r0,#0x16	; 023096BE
	b loc_02309714	; 023096C0
loc_023096C2:
	cmp r2,#0x80	; 023096C2
	bcs loc_023096DE	; 023096C4
	ldr r0,[pool_023097DC]	; 023096C6
	ldrh r0,[r3,r0]	; 023096C8
	cmp r0,#0x40	; 023096CA
	beq loc_023096D0	; 023096CC
	mov r6,#0x1	; 023096CE
loc_023096D0:
	mov r5,#0x8	; 023096D0
	ldr r7,[pool_023097E8]	; 023096D2
	sub r2,#0x40	; 023096D4
	lsl r0,r2,#0x10	; 023096D6
	lsr r2,r0,#0x10	; 023096D8
	mov r0,#0x6	; 023096DA
	b loc_02309714	; 023096DC
loc_023096DE:
	cmp r2,#0xc0	; 023096DE
	bcs loc_023096FA	; 023096E0
	ldr r0,[pool_023097DC]	; 023096E2
	ldrh r0,[r3,r0]	; 023096E4
	cmp r0,#0x10	; 023096E6
	bcs loc_023096EC	; 023096E8
	mov r6,#0x1	; 023096EA
loc_023096EC:
	mov r5,#0x10	; 023096EC
	ldr r7,[pool_023097EC]	; 023096EE
	sub r2,#0x80	; 023096F0
	lsl r0,r2,#0x10	; 023096F2
	lsr r2,r0,#0x10	; 023096F4
	mov r0,#0x16	; 023096F6
	b loc_02309714	; 023096F8
loc_023096FA:
	mov r2,#0x1	; 023096FA
	add r0,r6,#0x0	; 023096FC
	b loc_02309714	; 023096FE
loc_02309700:
	mov r5,#0x40	; 02309700
	ldr r7,[pool_023097F0]	; 02309702
	mov r0,#0xff	; 02309704
	and r1,r0	; 02309706
	lsl r0,r1,#0x10	; 02309708
	lsr r2,r0,#0x10	; 0230970A
	mov r0,#0xa	; 0230970C
	b loc_02309714	; 0230970E
loc_02309710:
	mov r2,#0x1	; 02309710
	mov r0,#0x0	; 02309712
loc_02309714:
	cmp r2,r0	; 02309714
	bls loc_0230971C	; 02309716
	mov r6,#0x3	; 02309718
	b loc_0230973A	; 0230971A
loc_0230971C:
	lsl r0,r2,#0x3	; 0230971C
	str r0,[sp,#0x4]	; 0230971E
	ldr r0,[sp,#0x0]	; 02309720
	ldrh r1,[r0,#0xe]	; 02309722
	ldr r0,[sp,#0x4]	; 02309724
	ldrh r0,[r7,r0]	; 02309726
	cmp r1,r0	; 02309728
	bcc loc_02309738	; 0230972A
	ldrh r1,[r4,#0x2]	; 0230972C
	ldr r0,[sp,#0x4]	; 0230972E
	add r0,r7,r0	; 02309730
	ldrh r0,[r0,#0x2]	; 02309732
	cmp r1,r0	; 02309734
	bcs loc_0230973A	; 02309736
loc_02309738:
	mov r6,#0x4	; 02309738
loc_0230973A:
	cmp r6,#0x0	; 0230973A
	beq loc_02309746	; 0230973C
	mov r0,#0x1	; 0230973E
	strh r0,[r4,#0x2]	; 02309740
	strh r6,[r4,#0x4]	; 02309742
	b loc_0230977A	; 02309744
loc_02309746:
	ldr r0,[pool_023097B8]	; 02309746
	add r1,r3,r0	; 02309748
	ldrh r0,[r1,#0x0]	; 0230974A
	orr r0,r5	; 0230974C
	strh r0,[r1,#0x0]	; 0230974E
	ldr r0,[sp,#0x0]	; 02309750
	add r1,r4,#0x0	; 02309752
	lsl r2,r2,#0x3	; 02309754
	add r2,r7,r2	; 02309756
	ldr r2,[r2,#0x4]	; 02309758
	bl loc_02308C84	; 0230975A
	strh r0,[r4,#0x4]	; 0230975E
	ldrh r0,[r4,#0x4]	; 02309760
	cmp r0,#0x80	; 02309762
	beq loc_023097AA	; 02309764
	cmp r0,#0x81	; 02309766
	bne loc_0230977A	; 02309768
	ldr r0,[pool_023097B4]	; 0230976A
	ldr r1,[r0,#0x0]	; 0230976C
	ldr r0,[pool_023097B8]	; 0230976E
	add r1,r1,r0	; 02309770
	ldrh r0,[r1,#0x0]	; 02309772
	bic r0,r5	; 02309774
	strh r0,[r1,#0x0]	; 02309776
	b loc_02309796	; 02309778
loc_0230977A:
	ldr r2,[pool_023097B4]	; 0230977A
	ldr r1,[r2,#0x0]	; 0230977C
	ldr r0,[pool_023097B8]	; 0230977E
	add r1,r1,r0	; 02309780
	ldrh r0,[r1,#0x0]	; 02309782
	bic r0,r5	; 02309784
	strh r0,[r1,#0x0]	; 02309786
	ldr r2,[r2,#0x0]	; 02309788
	ldr r0,[pool_023097BC]	; 0230978A
	add r0,r2,r0	; 0230978C
	ldr r1,[pool_023097C0]	; 0230978E
	ldr r1,[r2,r1]	; 02309790
	bl loc_02309574	; 02309792
loc_02309796:
	ldr r0,[pool_023097B4]	; 02309796
	ldr r1,[r0,#0x0]	; 02309798
	ldr r0,[pool_023097F4]	; 0230979A
	ldrh r0,[r1,r0]	; 0230979C
	cmp r0,#0x0	; 0230979E
	beq loc_023097AA	; 023097A0
	mov r0,#0x2	; 023097A2
	mov r1,#0xb	; 023097A4
	bl loc_02304B68	; 023097A6
loc_023097AA:
	add sp,#0xc	; 023097AA
	pop {r4,r5,r6,r7}	; 023097AC
	pop {r3}	; 023097AE
	bx r3	; 023097B0
	.byte 0xC0, 0x46	; 023097B4
pool_023097B4:
loc_023097B4:
	.word FirmwareWlWorkPointerSlot	; 023097B4
pool_023097B8:
loc_023097B8:
	.word 0x000003E0	; 023097B8
pool_023097BC:
loc_023097BC:
	.word 0x000001C4	; 023097BC
pool_023097C0:
loc_023097C0:
	.word 0x000003DC	; 023097C0
pool_023097C4:
loc_023097C4:
	.word 0x00000302	; 023097C4
pool_023097C8:
loc_023097C8:
	.word 0x0000FF00	; 023097C8
pool_023097CC:
loc_023097CC:
	.word 0x00000100	; 023097CC
pool_023097D0:
loc_023097D0:
	.word 0x00000200	; 023097D0
pool_023097D4:
loc_023097D4:
	.word 0x00000300	; 023097D4
pool_023097D8:
loc_023097D8:
	.word 0x023106E0	; 023097D8
pool_023097DC:
loc_023097DC:
	.word 0x00000310	; 023097DC
pool_023097E0:
loc_023097E0:
	.word 0x02310638	; 023097E0
pool_023097E4:
loc_023097E4:
	.word 0x023107E8	; 023097E4
pool_023097E8:
loc_023097E8:
	.word 0x02310660	; 023097E8
pool_023097EC:
loc_023097EC:
	.word 0x02310738	; 023097EC
pool_023097F0:
loc_023097F0:
	.word 0x02310690	; 023097F0
pool_023097F4:
loc_023097F4:
	.word 0x000001CC	; 023097F4

; ===== function loc_023097F8 =====
loc_023097F8:
	push {lr}	; 023097F8
	sub sp,#0x4	; 023097FA
	mov r1,#0x0	; 023097FC
	add r0,sp,#0x0	; 023097FE
	strh r1,[r0,#0x0]	; 02309800
	ldrh r0,[r0,#0x0]	; 02309802
	ldr r1,[pool_02309818]	; 02309804
	ldr r2,[r1,#0x0]	; 02309806
	ldr r1,[pool_0230981C]	; 02309808
	add r1,r2,r1	; 0230980A
	mov r2,#0x20	; 0230980C
	bl loc_02309820	; 0230980E
	add sp,#0x4	; 02309812
	pop {r3}	; 02309814
	bx r3	; 02309816
pool_02309818:
loc_02309818:
	.word FirmwareWlWorkPointerSlot	; 02309818
pool_0230981C:
loc_0230981C:
	.word 0x000003BC	; 0230981C

; ===== function loc_02309820 =====
loc_02309820:
	bx pc	; 02309820
	.byte 0xC0, 0x46	; 02309824
.arm

; ===== function loc_02309824 =====
loc_02309824:
	ldr pc,[pool_02309828]	; 02309824
pool_02309828:
loc_02309828:
	.word loc_037FCE04	; 02309828
.thumb

; ===== function loc_0230982C =====
loc_0230982C:
	push {r4,r5,r6,r7,lr}	; 0230982C
	sub sp,#0x4	; 0230982E
	add r4,r0,#0x0	; 02309830
	ldr r0,[pool_02309904]	; 02309832
	ldr r2,[r0,#0x0]	; 02309834
	ldr r0,[pool_02309908]	; 02309836
	add r0,r2,r0	; 02309838
	ldr r1,[pool_0230990C]	; 0230983A
	ldrh r1,[r2,r1]	; 0230983C
	add r1,#0x3e	; 0230983E
	bl loc_02305050	; 02309840
	add r5,r0,#0x0	; 02309844
	cmp r5,#0x0	; 02309846
	bne loc_02309854	; 02309848
	mov r0,#0x1	; 0230984A
	bl loc_02305130	; 0230984C
	mov r0,#0x0	; 02309850
	b loc_023098FA	; 02309852
loc_02309854:
	mov r0,#0x8d	; 02309854
	strh r0,[r5,#0xc]	; 02309856
	ldr r0,[pool_02309904]	; 02309858
	ldr r1,[r0,#0x0]	; 0230985A
	ldr r0,[pool_0230990C]	; 0230985C
	ldrh r0,[r1,r0]	; 0230985E
	add r0,r0,#0x1	; 02309860
	mov r1,#0x2	; 02309862
	bl loc_02309918	; 02309864
	add r0,#0x16	; 02309868
	strh r0,[r5,#0xe]	; 0230986A
	add r0,r5,#0x0	; 0230986C
	add r0,#0x1f	; 0230986E
	ldrh r1,[r4,#0x12]	; 02309870
	lsl r1,r1,#0x18	; 02309872
	lsr r1,r1,#0x18	; 02309874
	bl loc_023053D8	; 02309876
	add r0,r5,#0x0	; 0230987A
	add r0,#0x1e	; 0230987C
	ldrh r1,[r4,#0xe]	; 0230987E
	lsl r1,r1,#0x18	; 02309880
	lsr r1,r1,#0x18	; 02309882
	bl loc_023053D8	; 02309884
	add r0,r5,#0x0	; 02309888
	add r0,#0x2e	; 0230988A
	add r4,#0x1e	; 0230988C
	add r1,r4,#0x0	; 0230988E
	bl loc_02306458	; 02309890
	ldr r3,[pool_02309904]	; 02309894
	ldr r1,[r3,#0x0]	; 02309896
	ldr r0,[pool_0230990C]	; 02309898
	ldrh r0,[r1,r0]	; 0230989A
	strh r0,[r5,#0x16]	; 0230989C
	ldrh r2,[r5,#0x16]	; 0230989E
	cmp r2,#0x0	; 023098A0
	beq loc_023098EA	; 023098A2
	ldr r0,[r3,#0x0]	; 023098A4
	ldr r1,[pool_02309910]	; 023098A6
	ldrh r3,[r0,r1]	; 023098A8
	mov r1,#0x1	; 023098AA
	and r3,r1	; 023098AC
	cmp r3,#0x0	; 023098AE
	beq loc_023098DC	; 023098B0
	ldr r1,[pool_02309914]	; 023098B2
	ldr r0,[r0,r1]	; 023098B4
	add r6,r0,#0x1	; 023098B6
	add r7,r5,#0x0	; 023098B8
	add r7,#0x3c	; 023098BA
	mov r4,#0x0	; 023098BC
	b loc_023098D4	; 023098BE
loc_023098C0:
	add r0,r6,#0x0	; 023098C0
	bl loc_023053B4	; 023098C2
	add r1,r0,#0x0	; 023098C6
	add r0,r7,#0x0	; 023098C8
	bl loc_023053D8	; 023098CA
	add r6,r6,#0x1	; 023098CE
	add r7,r7,#0x1	; 023098D0
	add r4,r4,#0x1	; 023098D2
loc_023098D4:
	ldrh r0,[r5,#0x16]	; 023098D4
	cmp r4,r0	; 023098D6
	bcc loc_023098C0	; 023098D8
	b loc_023098EA	; 023098DA
loc_023098DC:
	ldr r1,[pool_02309914]	; 023098DC
	ldr r0,[r0,r1]	; 023098DE
	add r1,r5,#0x0	; 023098E0
	add r1,#0x3c	; 023098E2
	add r2,r2,#0x1	; 023098E4
	bl loc_02309924	; 023098E6
loc_023098EA:
	ldr r0,[pool_02309904]	; 023098EA
	ldr r1,[r0,#0x0]	; 023098EC
	ldr r0,[pool_02309908]	; 023098EE
	add r0,r1,r0	; 023098F0
	add r1,r5,#0x0	; 023098F2
	bl loc_02309574	; 023098F4
	mov r0,#0x1	; 023098F8
loc_023098FA:
	add sp,#0x4	; 023098FA
	pop {r4,r5,r6,r7}	; 023098FC
	pop {r3}	; 023098FE
	bx r3	; 02309900
	.byte 0xC0, 0x46	; 02309904
pool_02309904:
loc_02309904:
	.word FirmwareWlWorkPointerSlot	; 02309904
pool_02309908:
loc_02309908:
	.word 0x0000014C	; 02309908
pool_0230990C:
loc_0230990C:
	.word 0x0000039C	; 0230990C
pool_02309910:
loc_02309910:
	.word 0x0000039E	; 02309910
pool_02309914:
loc_02309914:
	.word 0x00000398	; 02309914

; ===== function loc_02309918 =====
loc_02309918:
	bx pc	; 02309918
	.byte 0xC0, 0x46	; 0230991C
.arm

; ===== function loc_0230991C =====
loc_0230991C:
	ldr pc,[pool_02309920]	; 0230991C
pool_02309920:
loc_02309920:
	.word loc_03802514	; 02309920
.thumb

; ===== function loc_02309924 =====
loc_02309924:
	bx pc	; 02309924
	.byte 0xC0, 0x46	; 02309928
.arm

; ===== function loc_02309928 =====
loc_02309928:
	ldr pc,[pool_0230992C]	; 02309928
pool_0230992C:
loc_0230992C:
	.word P2_Entry_037FCE1C	; 0230992C
.thumb

; ===== function loc_02309930 =====
loc_02309930:
	push {lr}	; 02309930
	sub sp,#0x4	; 02309932
	ldr r0,[pool_02309970]	; 02309934
	ldr r1,[r0,#0x0]	; 02309936
	ldr r0,[pool_02309974]	; 02309938
	add r0,r1,r0	; 0230993A
	mov r1,#0x10	; 0230993C
	bl loc_02305050	; 0230993E
	add r1,r0,#0x0	; 02309942
	cmp r1,#0x0	; 02309944
	bne loc_02309952	; 02309946
	mov r0,#0x1	; 02309948
	bl loc_02305130	; 0230994A
	mov r0,#0x0	; 0230994E
	b loc_02309968	; 02309950
loc_02309952:
	mov r0,#0x8c	; 02309952
	strh r0,[r1,#0xc]	; 02309954
	mov r0,#0x0	; 02309956
	strh r0,[r1,#0xe]	; 02309958
	ldr r0,[pool_02309970]	; 0230995A
	ldr r2,[r0,#0x0]	; 0230995C
	ldr r0,[pool_02309974]	; 0230995E
	add r0,r2,r0	; 02309960
	bl loc_02309574	; 02309962
	mov r0,#0x1	; 02309966
loc_02309968:
	add sp,#0x4	; 02309968
	pop {r3}	; 0230996A
	bx r3	; 0230996C
	.byte 0xC0, 0x46	; 02309970
pool_02309970:
loc_02309970:
	.word FirmwareWlWorkPointerSlot	; 02309970
pool_02309974:
loc_02309974:
	.word 0x0000014C	; 02309974
loc_02309978:
	push {r4,r5,lr}	; 02309978
	sub sp,#0x4	; 0230997A
	add r5,r0,#0x0	; 0230997C
	ldr r0,[pool_023099C8]	; 0230997E
	ldr r1,[r0,#0x0]	; 02309980
	ldr r0,[pool_023099CC]	; 02309982
	add r0,r1,r0	; 02309984
	mov r1,#0x16	; 02309986
	bl loc_02305050	; 02309988
	add r4,r0,#0x0	; 0230998C
	cmp r4,#0x0	; 0230998E
	bne loc_0230999C	; 02309990
	mov r0,#0x1	; 02309992
	bl loc_02305130	; 02309994
	mov r0,#0x0	; 02309998
	b loc_023099BE	; 0230999A
loc_0230999C:
	mov r0,#0x8b	; 0230999C
	strh r0,[r4,#0xc]	; 0230999E
	mov r0,#0x3	; 023099A0
	strh r0,[r4,#0xe]	; 023099A2
	add r0,r4,#0x0	; 023099A4
	add r0,#0x10	; 023099A6
	add r1,r5,#0x0	; 023099A8
	bl loc_02306458	; 023099AA
	ldr r0,[pool_023099C8]	; 023099AE
	ldr r1,[r0,#0x0]	; 023099B0
	ldr r0,[pool_023099CC]	; 023099B2
	add r0,r1,r0	; 023099B4
	add r1,r4,#0x0	; 023099B6
	bl loc_02309574	; 023099B8
	mov r0,#0x1	; 023099BC
loc_023099BE:
	add sp,#0x4	; 023099BE
	pop {r4,r5}	; 023099C0
	pop {r3}	; 023099C2
	bx r3	; 023099C4
	.byte 0xC0, 0x46	; 023099C8
pool_023099C8:
loc_023099C8:
	.word FirmwareWlWorkPointerSlot	; 023099C8
pool_023099CC:
loc_023099CC:
	.word 0x0000014C	; 023099CC

; ===== function loc_023099D0 =====
loc_023099D0:
	push {r4,r5,r6,lr}	; 023099D0
	add r6,r0,#0x0	; 023099D2
	add r5,r1,#0x0	; 023099D4
	ldr r0,[pool_02309A20]	; 023099D6
	ldr r1,[r0,#0x0]	; 023099D8
	ldr r0,[pool_02309A24]	; 023099DA
	add r0,r1,r0	; 023099DC
	mov r1,#0x18	; 023099DE
	bl loc_02305050	; 023099E0
	add r4,r0,#0x0	; 023099E4
	cmp r4,#0x0	; 023099E6
	bne loc_023099F4	; 023099E8
	mov r0,#0x1	; 023099EA
	bl loc_02305130	; 023099EC
	mov r0,#0x0	; 023099F0
	b loc_02309A18	; 023099F2
loc_023099F4:
	mov r0,#0x88	; 023099F4
	strh r0,[r4,#0xc]	; 023099F6
	mov r0,#0x4	; 023099F8
	strh r0,[r4,#0xe]	; 023099FA
	add r0,r4,#0x0	; 023099FC
	add r0,#0x10	; 023099FE
	add r1,r6,#0x0	; 02309A00
	bl loc_02306458	; 02309A02
	strh r5,[r4,#0x16]	; 02309A06
	ldr r0,[pool_02309A20]	; 02309A08
	ldr r1,[r0,#0x0]	; 02309A0A
	ldr r0,[pool_02309A24]	; 02309A0C
	add r0,r1,r0	; 02309A0E
	add r1,r4,#0x0	; 02309A10
	bl loc_02309574	; 02309A12
	mov r0,#0x1	; 02309A16
loc_02309A18:
	pop {r4,r5,r6}	; 02309A18
	pop {r3}	; 02309A1A
	bx r3	; 02309A1C
	.byte 0xC0, 0x46	; 02309A20
pool_02309A20:
loc_02309A20:
	.word FirmwareWlWorkPointerSlot	; 02309A20
pool_02309A24:
loc_02309A24:
	.word 0x0000014C	; 02309A24

; ===== function loc_02309A28 =====
loc_02309A28:
	push {r4,r5,r6,r7,lr}	; 02309A28
	sub sp,#0x4	; 02309A2A
	add r7,r0,#0x0	; 02309A2C
	add r4,r1,#0x0	; 02309A2E
	add r6,r2,#0x0	; 02309A30
	ldr r0,[pool_02309ABC]	; 02309A32
	ldr r1,[r0,#0x0]	; 02309A34
	ldr r0,[pool_02309AC0]	; 02309A36
	add r0,r1,r0	; 02309A38
	mov r1,#0x3a	; 02309A3A
	bl loc_02305050	; 02309A3C
	add r5,r0,#0x0	; 02309A40
	cmp r5,#0x0	; 02309A42
	bne loc_02309A50	; 02309A44
	mov r0,#0x1	; 02309A46
	bl loc_02305130	; 02309A48
	mov r0,#0x0	; 02309A4C
	b loc_02309AB4	; 02309A4E
loc_02309A50:
	mov r0,#0x87	; 02309A50
	strh r0,[r5,#0xc]	; 02309A52
	mov r0,#0x15	; 02309A54
	strh r0,[r5,#0xe]	; 02309A56
	add r0,r5,#0x0	; 02309A58
	add r0,#0x10	; 02309A5A
	add r1,r7,#0x0	; 02309A5C
	bl loc_02306458	; 02309A5E
	strh r4,[r5,#0x16]	; 02309A62
	add r0,r6,#0x1	; 02309A64
	bl loc_023053B4	; 02309A66
	strh r0,[r5,#0x18]	; 02309A6A
	mov r4,#0x0	; 02309A6C
	add r6,r6,#0x2	; 02309A6E
	add r7,r5,#0x0	; 02309A70
	add r7,#0x1a	; 02309A72
	b loc_02309A8A	; 02309A74
loc_02309A76:
	cmp r4,#0x20	; 02309A76
	bcs loc_02309AA0	; 02309A78
	add r0,r6,r4	; 02309A7A
	bl loc_023053B4	; 02309A7C
	add r1,r0,#0x0	; 02309A80
	add r0,r7,r4	; 02309A82
	bl loc_023053D8	; 02309A84
	add r4,r4,#0x1	; 02309A88
loc_02309A8A:
	ldrh r0,[r5,#0x18]	; 02309A8A
	cmp r4,r0	; 02309A8C
	bcc loc_02309A76	; 02309A8E
	b loc_02309AA0	; 02309A90
loc_02309A92:
	add r0,r5,#0x0	; 02309A92
	add r0,#0x1a	; 02309A94
	add r0,r0,r4	; 02309A96
	mov r1,#0x0	; 02309A98
	bl loc_023053D8	; 02309A9A
	add r4,r4,#0x1	; 02309A9E
loc_02309AA0:
	cmp r4,#0x20	; 02309AA0
	bcc loc_02309A92	; 02309AA2
	ldr r0,[pool_02309ABC]	; 02309AA4
	ldr r1,[r0,#0x0]	; 02309AA6
	ldr r0,[pool_02309AC0]	; 02309AA8
	add r0,r1,r0	; 02309AAA
	add r1,r5,#0x0	; 02309AAC
	bl loc_02309574	; 02309AAE
	mov r0,#0x1	; 02309AB2
loc_02309AB4:
	add sp,#0x4	; 02309AB4
	pop {r4,r5,r6,r7}	; 02309AB6
	pop {r3}	; 02309AB8
	bx r3	; 02309ABA
pool_02309ABC:
loc_02309ABC:
	.word FirmwareWlWorkPointerSlot	; 02309ABC
pool_02309AC0:
loc_02309AC0:
	.word 0x0000014C	; 02309AC0

; ===== function loc_02309AC4 =====
loc_02309AC4:
	push {r4,r5,r6,r7,lr}	; 02309AC4
	sub sp,#0x4	; 02309AC6
	add r7,r0,#0x0	; 02309AC8
	add r4,r1,#0x0	; 02309ACA
	add r6,r2,#0x0	; 02309ACC
	ldr r0,[pool_02309B5C]	; 02309ACE
	ldr r1,[r0,#0x0]	; 02309AD0
	ldr r0,[pool_02309B60]	; 02309AD2
	add r0,r1,r0	; 02309AD4
	mov r1,#0x3a	; 02309AD6
	bl loc_02305050	; 02309AD8
	add r5,r0,#0x0	; 02309ADC
	cmp r5,#0x0	; 02309ADE
	bne loc_02309AEC	; 02309AE0
	mov r0,#0x1	; 02309AE2
	bl loc_02305130	; 02309AE4
	mov r0,#0x0	; 02309AE8
	b loc_02309B54	; 02309AEA
loc_02309AEC:
	mov r0,#0x86	; 02309AEC
	strh r0,[r5,#0xc]	; 02309AEE
	mov r0,#0x15	; 02309AF0
	strh r0,[r5,#0xe]	; 02309AF2
	add r0,r5,#0x0	; 02309AF4
	add r0,#0x10	; 02309AF6
	add r1,r7,#0x0	; 02309AF8
	bl loc_02306458	; 02309AFA
	ldr r0,[pool_02309B64]	; 02309AFE
	and r4,r0	; 02309B00
	strh r4,[r5,#0x16]	; 02309B02
	add r0,r6,#0x1	; 02309B04
	bl loc_023053B4	; 02309B06
	strh r0,[r5,#0x18]	; 02309B0A
	mov r4,#0x0	; 02309B0C
	add r6,r6,#0x2	; 02309B0E
	add r7,r5,#0x0	; 02309B10
	add r7,#0x1a	; 02309B12
	b loc_02309B2A	; 02309B14
loc_02309B16:
	cmp r4,#0x20	; 02309B16
	bcs loc_02309B40	; 02309B18
	add r0,r6,r4	; 02309B1A
	bl loc_023053B4	; 02309B1C
	add r1,r0,#0x0	; 02309B20
	add r0,r7,r4	; 02309B22
	bl loc_023053D8	; 02309B24
	add r4,r4,#0x1	; 02309B28
loc_02309B2A:
	ldrh r0,[r5,#0x18]	; 02309B2A
	cmp r4,r0	; 02309B2C
	bcc loc_02309B16	; 02309B2E
	b loc_02309B40	; 02309B30
loc_02309B32:
	add r0,r5,#0x0	; 02309B32
	add r0,#0x1a	; 02309B34
	add r0,r0,r4	; 02309B36
	mov r1,#0x0	; 02309B38
	bl loc_023053D8	; 02309B3A
	add r4,r4,#0x1	; 02309B3E
loc_02309B40:
	cmp r4,#0x20	; 02309B40
	bcc loc_02309B32	; 02309B42
	ldr r0,[pool_02309B5C]	; 02309B44
	ldr r1,[r0,#0x0]	; 02309B46
	ldr r0,[pool_02309B60]	; 02309B48
	add r0,r1,r0	; 02309B4A
	add r1,r5,#0x0	; 02309B4C
	bl loc_02309574	; 02309B4E
	mov r0,#0x1	; 02309B52
loc_02309B54:
	add sp,#0x4	; 02309B54
	pop {r4,r5,r6,r7}	; 02309B56
	pop {r3}	; 02309B58
	bx r3	; 02309B5A
pool_02309B5C:
loc_02309B5C:
	.word FirmwareWlWorkPointerSlot	; 02309B5C
pool_02309B60:
loc_02309B60:
	.word 0x0000014C	; 02309B60
pool_02309B64:
loc_02309B64:
	.word 0x00000FFF	; 02309B64

; ===== function loc_02309B68 =====
loc_02309B68:
	push {r4,r5,r6,lr}	; 02309B68
	add r6,r0,#0x0	; 02309B6A
	add r5,r1,#0x0	; 02309B6C
	ldr r0,[pool_02309BB8]	; 02309B6E
	ldr r1,[r0,#0x0]	; 02309B70
	ldr r0,[pool_02309BBC]	; 02309B72
	add r0,r1,r0	; 02309B74
	mov r1,#0x18	; 02309B76
	bl loc_02305050	; 02309B78
	add r4,r0,#0x0	; 02309B7C
	cmp r4,#0x0	; 02309B7E
	bne loc_02309B8C	; 02309B80
	mov r0,#0x1	; 02309B82
	bl loc_02305130	; 02309B84
	mov r0,#0x0	; 02309B88
	b loc_02309BB0	; 02309B8A
loc_02309B8C:
	mov r0,#0x85	; 02309B8C
	strh r0,[r4,#0xc]	; 02309B8E
	mov r0,#0x4	; 02309B90
	strh r0,[r4,#0xe]	; 02309B92
	add r0,r4,#0x0	; 02309B94
	add r0,#0x10	; 02309B96
	add r1,r6,#0x0	; 02309B98
	bl loc_02306458	; 02309B9A
	strh r5,[r4,#0x16]	; 02309B9E
	ldr r0,[pool_02309BB8]	; 02309BA0
	ldr r1,[r0,#0x0]	; 02309BA2
	ldr r0,[pool_02309BBC]	; 02309BA4
	add r0,r1,r0	; 02309BA6
	add r1,r4,#0x0	; 02309BA8
	bl loc_02309574	; 02309BAA
	mov r0,#0x1	; 02309BAE
loc_02309BB0:
	pop {r4,r5,r6}	; 02309BB0
	pop {r3}	; 02309BB2
	bx r3	; 02309BB4
	.byte 0xC0, 0x46	; 02309BB8
pool_02309BB8:
loc_02309BB8:
	.word FirmwareWlWorkPointerSlot	; 02309BB8
pool_02309BBC:
loc_02309BBC:
	.word 0x0000014C	; 02309BBC

; ===== function loc_02309BC0 =====
loc_02309BC0:
	push {r4,r5,r6,lr}	; 02309BC0
	add r6,r0,#0x0	; 02309BC2
	add r5,r1,#0x0	; 02309BC4
	ldr r0,[pool_02309C10]	; 02309BC6
	ldr r1,[r0,#0x0]	; 02309BC8
	ldr r0,[pool_02309C14]	; 02309BCA
	add r0,r1,r0	; 02309BCC
	mov r1,#0x18	; 02309BCE
	bl loc_02305050	; 02309BD0
	add r4,r0,#0x0	; 02309BD4
	cmp r4,#0x0	; 02309BD6
	bne loc_02309BE4	; 02309BD8
	mov r0,#0x1	; 02309BDA
	bl loc_02305130	; 02309BDC
	mov r0,#0x0	; 02309BE0
	b loc_02309C08	; 02309BE2
loc_02309BE4:
	mov r0,#0x84	; 02309BE4
	strh r0,[r4,#0xc]	; 02309BE6
	mov r0,#0x4	; 02309BE8
	strh r0,[r4,#0xe]	; 02309BEA
	add r0,r4,#0x0	; 02309BEC
	add r0,#0x10	; 02309BEE
	add r1,r6,#0x0	; 02309BF0
	bl loc_02306458	; 02309BF2
	strh r5,[r4,#0x16]	; 02309BF6
	ldr r0,[pool_02309C10]	; 02309BF8
	ldr r1,[r0,#0x0]	; 02309BFA
	ldr r0,[pool_02309C14]	; 02309BFC
	add r0,r1,r0	; 02309BFE
	add r1,r4,#0x0	; 02309C00
	bl loc_02309574	; 02309C02
	mov r0,#0x1	; 02309C06
loc_02309C08:
	pop {r4,r5,r6}	; 02309C08
	pop {r3}	; 02309C0A
	bx r3	; 02309C0C
	.byte 0xC0, 0x46	; 02309C10
pool_02309C10:
loc_02309C10:
	.word FirmwareWlWorkPointerSlot	; 02309C10
pool_02309C14:
loc_02309C14:
	.word 0x0000014C	; 02309C14

; ===== function loc_02309C18 =====
loc_02309C18:
	push {lr}	; 02309C18
	sub sp,#0x4	; 02309C1A
	ldr r2,[pool_02309C54]	; 02309C1C
	ldr r1,[r2,#0x0]	; 02309C1E
	ldr r0,[pool_02309C58]	; 02309C20
	add r3,r1,r0	; 02309C22
	ldrh r1,[r3,#0x0]	; 02309C24
	mov r0,#0x1	; 02309C26
	bic r1,r0	; 02309C28
	strh r1,[r3,#0x0]	; 02309C2A
	ldr r2,[r2,#0x0]	; 02309C2C
	ldr r0,[pool_02309C5C]	; 02309C2E
	add r0,r2,r0	; 02309C30
	ldr r1,[pool_02309C60]	; 02309C32
	ldr r1,[r2,r1]	; 02309C34
	bl loc_02309574	; 02309C36
	ldr r0,[pool_02309C54]	; 02309C3A
	ldr r1,[r0,#0x0]	; 02309C3C
	ldr r0,[pool_02309C64]	; 02309C3E
	ldrh r0,[r1,r0]	; 02309C40
	cmp r0,#0x0	; 02309C42
	beq loc_02309C4E	; 02309C44
	mov r0,#0x2	; 02309C46
	mov r1,#0xb	; 02309C48
	bl loc_02304B68	; 02309C4A
loc_02309C4E:
	add sp,#0x4	; 02309C4E
	pop {r3}	; 02309C50
	bx r3	; 02309C52
pool_02309C54:
loc_02309C54:
	.word FirmwareWlWorkPointerSlot	; 02309C54
pool_02309C58:
loc_02309C58:
	.word 0x000003E0	; 02309C58
pool_02309C5C:
loc_02309C5C:
	.word 0x000001C4	; 02309C5C
pool_02309C60:
loc_02309C60:
	.word 0x000003DC	; 02309C60
pool_02309C64:
loc_02309C64:
	.word 0x000001CC	; 02309C64
	ldr r0,[pool_02309C74]	; 02309C68
	ldr r1,[r0,#0x0]	; 02309C6A
	ldr r0,[pool_02309C78]	; 02309C6C
	add r0,r1,r0	; 02309C6E
	ldr r3,[pool_02309C7C]	; 02309C70
	bx r3	; 02309C72
pool_02309C74:
loc_02309C74:
	.word FirmwareWlWorkPointerSlot	; 02309C74
pool_02309C78:
loc_02309C78:
	.word 0x0000037E	; 02309C78
pool_02309C7C:
loc_02309C7C:
	.word loc_02309978 + 1	; 02309C7C
P4_Code_02309C80:
	mov r2,#0x83	; 02309C80
	ldr r0,[pool_02309C94]	; 02309C82
	ldr r1,[r0,#0x0]	; 02309C84
	ldr r0,[pool_02309C98]	; 02309C86
	strh r2,[r1,r0]	; 02309C88
	mov r0,#0x2	; 02309C8A
	mov r1,#0x5	; 02309C8C
	ldr r3,[pool_02309C9C]	; 02309C8E
	bx r3	; 02309C90
	.byte 0xC0, 0x46	; 02309C94
pool_02309C94:
loc_02309C94:
	.word FirmwareWlWorkPointerSlot	; 02309C94
pool_02309C98:
loc_02309C98:
	.word 0x000003BC	; 02309C98
pool_02309C9C:
loc_02309C9C:
	.word loc_02304B68 + 1	; 02309C9C

; ===== function loc_02309CA0 =====
	push {r4,r5,lr}	; 02309CA0
	sub sp,#0x4	; 02309CA2
	ldr r0,[pool_02309E4C]	; 02309CA4
	ldr r1,[r0,#0x0]	; 02309CA6
	ldr r0,[pool_02309E50]	; 02309CA8
	add r4,r1,r0	; 02309CAA
	ldrh r0,[r4,#0x0]	; 02309CAC
	sub r0,#0x80	; 02309CAE
	cmp r0,#0x4	; 02309CB0
	bls loc_02309CB6	; 02309CB2
	b loc_02309E36	; 02309CB4
loc_02309CB6:
	add r0,r0,r0	; 02309CB6
P4_SwitchIndexPC_02309CB6:
	add r0,pc	; 02309CB8
	ldrh r0,[r0,#(P4_SwitchTable_02309CB6 - (P4_SwitchIndexPC_02309CB6 + 4))]	; 02309CBA
	lsl r0,r0,#0x10	; 02309CBC
	asr r0,r0,#0x10	; 02309CBE
P4_SwitchTargetPC_02309CB6:
	add r0,pc	; 02309CC0
	bx r0	; 02309CC2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02309CB6:
	.halfword (loc_02309CCE + 1) - (P4_SwitchTargetPC_02309CB6 + 4)
	.halfword (loc_02309CFA + 1) - (P4_SwitchTargetPC_02309CB6 + 4)
	.halfword (loc_02309D7C + 1) - (P4_SwitchTargetPC_02309CB6 + 4)
	.halfword (loc_02309D9C + 1) - (P4_SwitchTargetPC_02309CB6 + 4)
	.halfword (loc_02309DF0 + 1) - (P4_SwitchTargetPC_02309CB6 + 4)
P4_SwitchTable_02309CB6End:
loc_02309CCE:
	mov r0,#0x0	; 02309CCE
	strh r0,[r4,#0x14]	; 02309CD0
	mov r0,#0x13	; 02309CD2
	bl loc_02305B04	; 02309CD4
	strh r0,[r4,#0xe]	; 02309CD8
	mov r0,#0x35	; 02309CDA
	bl loc_02305B04	; 02309CDC
	strh r0,[r4,#0x10]	; 02309CE0
	ldr r1,[r4,#0x18]	; 02309CE2
	ldrh r0,[r1,#0x12]	; 02309CE4
	ldrh r1,[r1,#0x14]	; 02309CE6
	bl loc_02306EAC	; 02309CE8
	mov r2,#0x4	; 02309CEC
	ldr r0,[pool_02309E4C]	; 02309CEE
	ldr r1,[r0,#0x0]	; 02309CF0
	ldr r0,[pool_02309E54]	; 02309CF2
	strh r2,[r1,r0]	; 02309CF4
	mov r0,#0x0	; 02309CF6
	strh r0,[r4,#0x16]	; 02309CF8
loc_02309CFA:
	mov r3,#0x0	; 02309CFA
	ldr r2,[pool_02309E4C]	; 02309CFC
	ldr r1,[r2,#0x0]	; 02309CFE
	ldr r0,[pool_02309E58]	; 02309D00
	str r3,[r1,r0]	; 02309D02
	ldr r1,[r2,#0x0]	; 02309D04
	ldr r0,[pool_02309E5C]	; 02309D06
	str r3,[r1,r0]	; 02309D08
	ldr r1,[r4,#0x18]	; 02309D0A
	add r1,#0x18	; 02309D0C
	ldrh r0,[r4,#0x14]	; 02309D0E
	add r0,r1,r0	; 02309D10
	bl loc_023053B4	; 02309D12
	add r5,r0,#0x0	; 02309D16
	cmp r5,#0x0	; 02309D18
	beq loc_02309D22	; 02309D1A
	ldrh r0,[r4,#0x14]	; 02309D1C
	cmp r0,#0x10	; 02309D1E
	bcc loc_02309D28	; 02309D20
loc_02309D22:
	mov r0,#0x84	; 02309D22
	strh r0,[r4,#0x0]	; 02309D24
	b loc_02309E36	; 02309D26
loc_02309D28:
	mov r0,#0x0	; 02309D28
	bl loc_0231020C	; 02309D2A
	cmp r0,#0x0	; 02309D2E
	beq loc_02309D42	; 02309D30
	mov r0,#0xe	; 02309D32
	strh r0,[r4,#0x16]	; 02309D34
	mov r2,#0x84	; 02309D36
	ldr r0,[pool_02309E4C]	; 02309D38
	ldr r1,[r0,#0x0]	; 02309D3A
	ldr r0,[pool_02309E50]	; 02309D3C
	strh r2,[r1,r0]	; 02309D3E
	b loc_02309E36	; 02309D40
loc_02309D42:
	ldrh r0,[r4,#0x0]	; 02309D42
	cmp r0,#0x80	; 02309D44
	bne loc_02309D64	; 02309D46
	lsl r0,r5,#0x10	; 02309D48
	lsr r0,r0,#0x10	; 02309D4A
	mov r1,#0x0	; 02309D4C
	bl loc_02306944	; 02309D4E
	bl loc_02305BEC	; 02309D52
	ldr r0,[pool_02309E60]	; 02309D56
	ldrh r0,[r0,#0x0]	; 02309D58
	strh r0,[r4,#0xc]	; 02309D5A
	ldr r0,[pool_02309E64]	; 02309D5C
	bl loc_02306804	; 02309D5E
	b loc_02309D6E	; 02309D62
loc_02309D64:
	lsl r0,r5,#0x10	; 02309D64
	lsr r0,r0,#0x10	; 02309D66
	mov r1,#0x0	; 02309D68
	bl loc_02306944	; 02309D6A
loc_02309D6E:
	mov r0,#0x82	; 02309D6E
	strh r0,[r4,#0x0]	; 02309D70
	ldr r0,[r4,#0x18]	; 02309D72
	ldrh r0,[r0,#0x16]	; 02309D74
	ldr r1,[pool_02309E68]	; 02309D76
	bl loc_023055F4	; 02309D78
loc_02309D7C:
	add r1,r4,#0x4	; 02309D7C
	ldr r0,[r1,#0x0]	; 02309D7E
	add r0,r0,#0x1	; 02309D80
	str r0,[r1,#0x0]	; 02309D82
	ldr r0,[pool_02309E6C]	; 02309D84
	ldrh r1,[r0,#0x0]	; 02309D86
	mov r0,#0x1	; 02309D88
	and r1,r0	; 02309D8A
	cmp r1,#0x0	; 02309D8C
	beq loc_02309E36	; 02309D8E
	add r1,r4,#0x0	; 02309D90
	add r1,#0x8	; 02309D92
	ldr r0,[r1,#0x0]	; 02309D94
	add r0,#0x64	; 02309D96
	str r0,[r1,#0x0]	; 02309D98
	b loc_02309E36	; 02309D9A
loc_02309D9C:
	ldr r1,[r4,#0x18]	; 02309D9C
	add r1,#0x18	; 02309D9E
	ldrh r0,[r4,#0x14]	; 02309DA0
	add r0,r1,r0	; 02309DA2
	bl loc_023053B4	; 02309DA4
	add r5,r0,#0x0	; 02309DA8
	ldr r1,[r4,#0x4]	; 02309DAA
	cmp r1,#0x0	; 02309DAC
	beq loc_02309DD6	; 02309DAE
	ldr r0,[r4,#0x8]	; 02309DB0
	cmp r0,#0x0	; 02309DB2
	beq loc_02309DC4	; 02309DB4
	bl loc_02309E74	; 02309DB6
	add r0,r0,#0x1	; 02309DBA
	cmp r0,#0x64	; 02309DBC
	bls loc_02309DC6	; 02309DBE
	mov r0,#0x64	; 02309DC0
	b loc_02309DC6	; 02309DC2
loc_02309DC4:
	mov r0,#0x0	; 02309DC4
loc_02309DC6:
	lsl r0,r0,#0x8	; 02309DC6
	orr r5,r0	; 02309DC8
	ldr r1,[r4,#0x1c]	; 02309DCA
	ldrh r0,[r4,#0x14]	; 02309DCC
	lsl r0,r0,#0x1	; 02309DCE
	add r0,r1,r0	; 02309DD0
	strh r5,[r0,#0x8]	; 02309DD2
	b loc_02309DE0	; 02309DD4
loc_02309DD6:
	ldr r1,[r4,#0x1c]	; 02309DD6
	ldrh r0,[r4,#0x14]	; 02309DD8
	lsl r0,r0,#0x1	; 02309DDA
	add r0,r1,r0	; 02309DDC
	strh r5,[r0,#0x8]	; 02309DDE
loc_02309DE0:
	add r1,r4,#0x0	; 02309DE0
	add r1,#0x14	; 02309DE2
	ldrh r0,[r1,#0x0]	; 02309DE4
	add r0,r0,#0x1	; 02309DE6
	strh r0,[r1,#0x0]	; 02309DE8
	mov r0,#0x81	; 02309DEA
	strh r0,[r4,#0x0]	; 02309DEC
	b loc_02309E36	; 02309DEE
loc_02309DF0:
	bl loc_02305B3C	; 02309DF0
	ldr r0,[pool_02309E4C]	; 02309DF4
	ldr r2,[r0,#0x0]	; 02309DF6
	ldr r0,[pool_02309E70]	; 02309DF8
	ldrh r1,[r2,r0]	; 02309DFA
	ldr r0,[pool_02309E54]	; 02309DFC
	strh r1,[r2,r0]	; 02309DFE
	mov r0,#0x13	; 02309E00
	ldrh r1,[r4,#0xe]	; 02309E02
	bl loc_02305A98	; 02309E04
	mov r0,#0x35	; 02309E08
	ldrh r1,[r4,#0x10]	; 02309E0A
	bl loc_02305A98	; 02309E0C
	ldrh r0,[r4,#0xc]	; 02309E10
	bl loc_02306804	; 02309E12
	ldrh r1,[r4,#0x16]	; 02309E16
	ldr r0,[r4,#0x1c]	; 02309E18
	strh r1,[r0,#0x4]	; 02309E1A
	mov r2,#0x0	; 02309E1C
	strh r2,[r4,#0x0]	; 02309E1E
	ldrh r3,[r4,#0x14]	; 02309E20
	b loc_02309E2E	; 02309E22
loc_02309E24:
	ldr r1,[r4,#0x1c]	; 02309E24
	lsl r0,r3,#0x1	; 02309E26
	add r0,r1,r0	; 02309E28
	strh r2,[r0,#0x8]	; 02309E2A
	add r3,r3,#0x1	; 02309E2C
loc_02309E2E:
	cmp r3,#0x10	; 02309E2E
	bcc loc_02309E24	; 02309E30
	bl loc_02309C18	; 02309E32
loc_02309E36:
	ldrh r0,[r4,#0x0]	; 02309E36
	cmp r0,#0x0	; 02309E38
	beq loc_02309E44	; 02309E3A
	mov r0,#0x2	; 02309E3C
	mov r1,#0x5	; 02309E3E
	bl loc_02304B68	; 02309E40
loc_02309E44:
	add sp,#0x4	; 02309E44
	pop {r4,r5}	; 02309E46
	pop {r3}	; 02309E48
	bx r3	; 02309E4A
pool_02309E4C:
loc_02309E4C:
	.word FirmwareWlWorkPointerSlot	; 02309E4C
pool_02309E50:
loc_02309E50:
	.word 0x000003BC	; 02309E50
pool_02309E54:
loc_02309E54:
	.word 0x00000314	; 02309E54
pool_02309E58:
loc_02309E58:
	.word 0x000003C0	; 02309E58
pool_02309E5C:
loc_02309E5C:
	.word 0x000003C4	; 02309E5C
pool_02309E60:
loc_02309E60:
	.word REG_WIFI_POWERFORCE	; 02309E60
pool_02309E64:
loc_02309E64:
	.word 0x00008000	; 02309E64
pool_02309E68:
loc_02309E68:
	.word P4_Code_02309C80 + 1	; 02309E68
pool_02309E6C:
loc_02309E6C:
	.word REG_WIFI_RF_PINS	; 02309E6C
pool_02309E70:
loc_02309E70:
	.word 0x000002F2	; 02309E70

; ===== function loc_02309E74 =====
loc_02309E74:
	bx pc	; 02309E74
	.byte 0xC0, 0x46	; 02309E78
.arm

; ===== function loc_02309E78 =====
loc_02309E78:
	ldr pc,[pool_02309E7C]	; 02309E78
pool_02309E7C:
loc_02309E7C:
	.word loc_03802720	; 02309E7C
.thumb
	bx lr	; 02309E80
	.byte 0x00, 0x00	; 02309E84
P4_Code_02309E84:
	mov r2,#0x7	; 02309E84
	ldr r3,[pool_02309EA0]	; 02309E86
	ldr r1,[r3,#0x0]	; 02309E88
	ldr r0,[pool_02309EA4]	; 02309E8A
	ldr r0,[r1,r0]	; 02309E8C
	strh r2,[r0,#0x4]	; 02309E8E
	mov r2,#0x53	; 02309E90
	ldr r1,[r3,#0x0]	; 02309E92
	ldr r0,[pool_02309EA8]	; 02309E94
	strh r2,[r1,r0]	; 02309E96
	mov r0,#0x2	; 02309E98
	mov r1,#0x3	; 02309E9A
	ldr r3,[pool_02309EAC]	; 02309E9C
	bx r3	; 02309E9E
pool_02309EA0:
loc_02309EA0:
	.word FirmwareWlWorkPointerSlot	; 02309EA0
pool_02309EA4:
loc_02309EA4:
	.word 0x000003D8	; 02309EA4
pool_02309EA8:
loc_02309EA8:
	.word 0x000003BC	; 02309EA8
pool_02309EAC:
loc_02309EAC:
	.word loc_02304B68 + 1	; 02309EAC

; ===== function loc_02309EB0 =====
	push {r4,lr}	; 02309EB0
	ldr r0,[pool_02309F20]	; 02309EB2
	ldr r1,[r0,#0x0]	; 02309EB4
	ldr r0,[pool_02309F24]	; 02309EB6
	add r4,r1,r0	; 02309EB8
	ldrh r0,[r4,#0x0]	; 02309EBA
	cmp r0,#0x50	; 02309EBC
	beq loc_02309ECA	; 02309EBE
	cmp r0,#0x51	; 02309EC0
	beq loc_02309F1A	; 02309EC2
	cmp r0,#0x53	; 02309EC4
	beq loc_02309EFE	; 02309EC6
	b loc_02309F1A	; 02309EC8
loc_02309ECA:
	ldr r0,[r4,#0x18]	; 02309ECA
	add r0,#0x10	; 02309ECC
	bl loc_0230C51C	; 02309ECE
	cmp r0,#0x0	; 02309ED2
	bne loc_02309EEA	; 02309ED4
	mov r1,#0x8	; 02309ED6
	ldr r0,[r4,#0x1c]	; 02309ED8
	strh r1,[r0,#0x4]	; 02309EDA
	mov r0,#0x53	; 02309EDC
	strh r0,[r4,#0x0]	; 02309EDE
	mov r0,#0x2	; 02309EE0
	mov r1,#0x3	; 02309EE2
	bl loc_02304B68	; 02309EE4
	b loc_02309F1A	; 02309EE8
loc_02309EEA:
	mov r1,#0x51	; 02309EEA
	strh r1,[r4,#0x0]	; 02309EEC
	bl loc_0230CAEC	; 02309EEE
	ldr r0,[r4,#0x18]	; 02309EF2
	ldrh r0,[r0,#0x18]	; 02309EF4
	ldr r1,[pool_02309F28]	; 02309EF6
	bl loc_023055F4	; 02309EF8
	b loc_02309F1A	; 02309EFC
loc_02309EFE:
	mov r0,#0x1	; 02309EFE
	bl loc_0230CD34	; 02309F00
	mov r0,#0x1	; 02309F04
	bl loc_0230CD9C	; 02309F06
	mov r0,#0x1	; 02309F0A
	mov r1,#0x0	; 02309F0C
	bl loc_0230CB5C	; 02309F0E
	mov r0,#0x0	; 02309F12
	strh r0,[r4,#0x0]	; 02309F14
	bl loc_02309C18	; 02309F16
loc_02309F1A:
	pop {r4}	; 02309F1A
	pop {r3}	; 02309F1C
	bx r3	; 02309F1E
pool_02309F20:
loc_02309F20:
	.word FirmwareWlWorkPointerSlot	; 02309F20
pool_02309F24:
loc_02309F24:
	.word 0x000003BC	; 02309F24
pool_02309F28:
loc_02309F28:
	.word P4_Code_02309E84 + 1	; 02309F28
P4_Code_02309F2C:
	mov r2,#0x7	; 02309F2C
	ldr r3,[pool_02309F48]	; 02309F2E
	ldr r1,[r3,#0x0]	; 02309F30
	ldr r0,[pool_02309F4C]	; 02309F32
	ldr r0,[r1,r0]	; 02309F34
	strh r2,[r0,#0x4]	; 02309F36
	mov r2,#0x35	; 02309F38
	ldr r1,[r3,#0x0]	; 02309F3A
	ldr r0,[pool_02309F50]	; 02309F3C
	strh r2,[r1,r0]	; 02309F3E
	mov r0,#0x2	; 02309F40
	add r1,r0,#0x0	; 02309F42
	ldr r3,[pool_02309F54]	; 02309F44
	bx r3	; 02309F46
pool_02309F48:
loc_02309F48:
	.word FirmwareWlWorkPointerSlot	; 02309F48
pool_02309F4C:
loc_02309F4C:
	.word 0x000003D8	; 02309F4C
pool_02309F50:
loc_02309F50:
	.word 0x000003BC	; 02309F50
pool_02309F54:
loc_02309F54:
	.word loc_02304B68 + 1	; 02309F54

; ===== function loc_02309F58 =====
	push {r4,lr}	; 02309F58
	ldr r0,[pool_02309FD8]	; 02309F5A
	ldr r1,[r0,#0x0]	; 02309F5C
	ldr r0,[pool_02309FDC]	; 02309F5E
	add r4,r1,r0	; 02309F60
	ldrh r0,[r4,#0x0]	; 02309F62
	cmp r0,#0x30	; 02309F64
	beq loc_02309F72	; 02309F66
	cmp r0,#0x31	; 02309F68
	beq loc_02309FD2	; 02309F6A
	cmp r0,#0x35	; 02309F6C
	beq loc_02309FB6	; 02309F6E
	b loc_02309FD2	; 02309F70
loc_02309F72:
	ldr r0,[r4,#0x18]	; 02309F72
	add r0,#0x10	; 02309F74
	mov r1,#0x0	; 02309F76
	bl loc_0230C0D0	; 02309F78
	cmp r0,#0x0	; 02309F7C
	bne loc_02309F94	; 02309F7E
	mov r1,#0x8	; 02309F80
	ldr r0,[r4,#0x1c]	; 02309F82
	strh r1,[r0,#0x4]	; 02309F84
	mov r0,#0x35	; 02309F86
	strh r0,[r4,#0x0]	; 02309F88
	mov r0,#0x2	; 02309F8A
	add r1,r0,#0x0	; 02309F8C
	bl loc_02304B68	; 02309F8E
	b loc_02309FD2	; 02309F92
loc_02309F94:
	ldr r1,[r4,#0x18]	; 02309F94
	ldrh r1,[r1,#0x16]	; 02309F96
	strh r1,[r0,#0x2c]	; 02309F98
	mov r1,#0x1	; 02309F9A
	strh r1,[r0,#0x2e]	; 02309F9C
	mov r1,#0x0	; 02309F9E
	strh r1,[r0,#0x30]	; 02309FA0
	mov r1,#0x31	; 02309FA2
	strh r1,[r4,#0x0]	; 02309FA4
	bl loc_0230CAEC	; 02309FA6
	ldr r0,[r4,#0x18]	; 02309FAA
	ldrh r0,[r0,#0x18]	; 02309FAC
	ldr r1,[pool_02309FE0]	; 02309FAE
	bl loc_023055F4	; 02309FB0
	b loc_02309FD2	; 02309FB4
loc_02309FB6:
	mov r0,#0x1	; 02309FB6
	bl loc_0230CD34	; 02309FB8
	mov r0,#0x1	; 02309FBC
	bl loc_0230CD9C	; 02309FBE
	mov r0,#0x1	; 02309FC2
	mov r1,#0x0	; 02309FC4
	bl loc_0230CB5C	; 02309FC6
	mov r0,#0x0	; 02309FCA
	strh r0,[r4,#0x0]	; 02309FCC
	bl loc_02309C18	; 02309FCE
loc_02309FD2:
	pop {r4}	; 02309FD2
	pop {r3}	; 02309FD4
	bx r3	; 02309FD6
pool_02309FD8:
loc_02309FD8:
	.word FirmwareWlWorkPointerSlot	; 02309FD8
pool_02309FDC:
loc_02309FDC:
	.word 0x000003BC	; 02309FDC
pool_02309FE0:
loc_02309FE0:
	.word P4_Code_02309F2C + 1	; 02309FE0
P4_Code_02309FE4:
	mov r2,#0x7	; 02309FE4
	ldr r3,[pool_0230A000]	; 02309FE6
	ldr r1,[r3,#0x0]	; 02309FE8
	ldr r0,[pool_0230A004]	; 02309FEA
	strh r2,[r1,r0]	; 02309FEC
	mov r2,#0x25	; 02309FEE
	ldr r1,[r3,#0x0]	; 02309FF0
	ldr r0,[pool_0230A008]	; 02309FF2
	strh r2,[r1,r0]	; 02309FF4
	mov r0,#0x2	; 02309FF6
	mov r1,#0x1	; 02309FF8
	ldr r3,[pool_0230A00C]	; 02309FFA
	bx r3	; 02309FFC
	.byte 0xC0, 0x46	; 0230A000
pool_0230A000:
loc_0230A000:
	.word FirmwareWlWorkPointerSlot	; 0230A000
pool_0230A004:
loc_0230A004:
	.word 0x000003C0	; 0230A004
pool_0230A008:
loc_0230A008:
	.word 0x000003BC	; 0230A008
pool_0230A00C:
loc_0230A00C:
	.word loc_02304B68 + 1	; 0230A00C

; ===== function loc_0230A010 =====
	push {r4,lr}	; 0230A010
	ldr r0,[pool_0230A068]	; 0230A012
	ldr r1,[r0,#0x0]	; 0230A014
	ldr r0,[pool_0230A06C]	; 0230A016
	add r4,r1,r0	; 0230A018
	ldrh r0,[r4,#0x0]	; 0230A01A
	cmp r0,#0x20	; 0230A01C
	beq loc_0230A02A	; 0230A01E
	cmp r0,#0x21	; 0230A020
	beq loc_0230A062	; 0230A022
	cmp r0,#0x25	; 0230A024
	beq loc_0230A044	; 0230A026
	b loc_0230A062	; 0230A028
loc_0230A02A:
	bl loc_02305BEC	; 0230A02A
	mov r0,#0x0	; 0230A02E
	strh r0,[r4,#0x4]	; 0230A030
	strh r0,[r4,#0x6]	; 0230A032
	mov r0,#0x21	; 0230A034
	strh r0,[r4,#0x0]	; 0230A036
	ldr r0,[r4,#0x18]	; 0230A038
	ldrh r0,[r0,#0x10]	; 0230A03A
	ldr r1,[pool_0230A070]	; 0230A03C
	bl loc_023055F4	; 0230A03E
	b loc_0230A062	; 0230A042
loc_0230A044:
	ldrh r1,[r4,#0x4]	; 0230A044
	ldr r0,[r4,#0x1c]	; 0230A046
	strh r1,[r0,#0x4]	; 0230A048
	ldrh r1,[r4,#0x6]	; 0230A04A
	ldr r0,[r4,#0x1c]	; 0230A04C
	strh r1,[r0,#0x6]	; 0230A04E
	ldrh r0,[r4,#0x4]	; 0230A050
	cmp r0,#0x0	; 0230A052
	beq loc_0230A05A	; 0230A054
	bl loc_02305B3C	; 0230A056
loc_0230A05A:
	mov r0,#0x0	; 0230A05A
	strh r0,[r4,#0x0]	; 0230A05C
	bl loc_02309C18	; 0230A05E
loc_0230A062:
	pop {r4}	; 0230A062
	pop {r3}	; 0230A064
	bx r3	; 0230A066
pool_0230A068:
loc_0230A068:
	.word FirmwareWlWorkPointerSlot	; 0230A068
pool_0230A06C:
loc_0230A06C:
	.word 0x000003BC	; 0230A06C
pool_0230A070:
loc_0230A070:
	.word P4_Code_02309FE4 + 1	; 0230A070
P4_Code_0230A074:
	ldr r0,[pool_0230A0AC]	; 0230A074
	ldr r1,[r0,#0x0]	; 0230A076
	ldr r0,[pool_0230A0B0]	; 0230A078
	add r0,r1,r0	; 0230A07A
	add r3,r0,#0x0	; 0230A07C
	add r3,#0xa	; 0230A07E
	ldrh r2,[r3,#0x0]	; 0230A080
	ldrh r1,[r0,#0xc]	; 0230A082
	add r1,r2,r1	; 0230A084
	strh r1,[r3,#0x0]	; 0230A086
	ldrh r2,[r0,#0xa]	; 0230A088
	ldr r1,[r0,#0x18]	; 0230A08A
	add r1,#0x4a	; 0230A08C
	ldrh r1,[r1,#0x0]	; 0230A08E
	cmp r2,r1	; 0230A090
	bcc loc_0230A0A4	; 0230A092
	ldrh r1,[r0,#0x6]	; 0230A094
	cmp r1,#0x10	; 0230A096
	bcs loc_0230A0A0	; 0230A098
	mov r1,#0x11	; 0230A09A
	strh r1,[r0,#0x0]	; 0230A09C
	b loc_0230A0A4	; 0230A09E
loc_0230A0A0:
	mov r1,#0x15	; 0230A0A0
	strh r1,[r0,#0x0]	; 0230A0A2
loc_0230A0A4:
	mov r0,#0x2	; 0230A0A4
	mov r1,#0x0	; 0230A0A6
	ldr r3,[pool_0230A0B4]	; 0230A0A8
	bx r3	; 0230A0AA
pool_0230A0AC:
loc_0230A0AC:
	.word FirmwareWlWorkPointerSlot	; 0230A0AC
pool_0230A0B0:
loc_0230A0B0:
	.word 0x000003BC	; 0230A0B0
pool_0230A0B4:
loc_0230A0B4:
	.word loc_02304B68 + 1	; 0230A0B4

; ===== function loc_0230A0B8 =====
	push {r4,r5,r6,lr}	; 0230A0B8
	ldr r0,[pool_0230A1F0]	; 0230A0BA
	ldr r1,[r0,#0x0]	; 0230A0BC
	ldr r0,[pool_0230A1F4]	; 0230A0BE
	add r4,r1,r0	; 0230A0C0
	mov r5,#0x0	; 0230A0C2
	ldrh r0,[r4,#0x0]	; 0230A0C4
	sub r0,#0x10	; 0230A0C6
	cmp r0,#0x5	; 0230A0C8
	bls loc_0230A0CE	; 0230A0CA
	b loc_0230A1DE	; 0230A0CC
loc_0230A0CE:
	add r0,r0,r0	; 0230A0CE
P4_SwitchIndexPC_0230A0CE:
	add r0,pc	; 0230A0D0
	ldrh r0,[r0,#(P4_SwitchTable_0230A0CE - (P4_SwitchIndexPC_0230A0CE + 4))]	; 0230A0D2
	lsl r0,r0,#0x10	; 0230A0D4
	asr r0,r0,#0x10	; 0230A0D6
P4_SwitchTargetPC_0230A0CE:
	add r0,pc	; 0230A0D8
	bx r0	; 0230A0DA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230A0CE:
	.halfword (loc_0230A0E8 + 1) - (P4_SwitchTargetPC_0230A0CE + 4)
	.halfword (loc_0230A134 + 1) - (P4_SwitchTargetPC_0230A0CE + 4)
	.halfword (loc_0230A196 + 1) - (P4_SwitchTargetPC_0230A0CE + 4)
	.halfword (loc_0230A196 + 1) - (P4_SwitchTargetPC_0230A0CE + 4)
	.halfword (loc_0230A1DE + 1) - (P4_SwitchTargetPC_0230A0CE + 4)
	.halfword (loc_0230A1C8 + 1) - (P4_SwitchTargetPC_0230A0CE + 4)
P4_SwitchTable_0230A0CEEnd:
loc_0230A0E8:
	mov r0,#0x20	; 0230A0E8
	bl loc_02306468	; 0230A0EA
	mov r2,#0x2	; 0230A0EE
	ldr r0,[pool_0230A1F0]	; 0230A0F0
	ldr r1,[r0,#0x0]	; 0230A0F2
	ldr r0,[pool_0230A1F8]	; 0230A0F4
	strh r2,[r1,r0]	; 0230A0F6
	lsl r1,r5,#0	; 0230A0F8
	ldr r0,[r4,#0x1c]	; 0230A0FA
	strh r1,[r0,#0x8]	; 0230A0FC
	ldr r0,[r4,#0x1c]	; 0230A0FE
	strh r1,[r0,#0x6]	; 0230A100
	strh r1,[r4,#0x6]	; 0230A102
	strh r1,[r4,#0x8]	; 0230A104
	ldr r1,[r4,#0x18]	; 0230A106
	ldrh r0,[r1,#0x38]	; 0230A108
	cmp r0,#0x0	; 0230A10A
	bne loc_0230A128	; 0230A10C
	add r1,#0x4a	; 0230A10E
	ldrh r0,[r1,#0x0]	; 0230A110
	add r0,r0,#0x3	; 0230A112
	mov r1,#0x4	; 0230A114
	bl loc_0230A204	; 0230A116
	strh r0,[r4,#0xc]	; 0230A11A
	ldrh r0,[r4,#0xc]	; 0230A11C
	cmp r0,#0xa	; 0230A11E
	bcs loc_0230A12E	; 0230A120
	mov r0,#0xa	; 0230A122
	strh r0,[r4,#0xc]	; 0230A124
	b loc_0230A12E	; 0230A126
loc_0230A128:
	add r1,#0x4a	; 0230A128
	ldrh r0,[r1,#0x0]	; 0230A12A
	strh r0,[r4,#0xc]	; 0230A12C
loc_0230A12E:
	mov r1,#0x0	; 0230A12E
	ldr r0,[r4,#0x1c]	; 0230A130
	strh r1,[r0,#0x4]	; 0230A132
loc_0230A134:
	ldr r1,[r4,#0x18]	; 0230A134
	add r1,#0x3a	; 0230A136
	ldrh r0,[r4,#0x6]	; 0230A138
	add r0,r1,r0	; 0230A13A
	bl loc_023053B4	; 0230A13C
	add r6,r0,#0x0	; 0230A140
	cmp r6,#0x0	; 0230A142
	bne loc_0230A14E	; 0230A144
	mov r0,#0x15	; 0230A146
	strh r0,[r4,#0x0]	; 0230A148
	mov r5,#0x1	; 0230A14A
	b loc_0230A1DE	; 0230A14C
loc_0230A14E:
	add r1,r4,#0x6	; 0230A14E
	ldrh r0,[r1,#0x0]	; 0230A150
	add r0,r0,#0x1	; 0230A152
	strh r0,[r1,#0x0]	; 0230A154
	mov r0,#0x0	; 0230A156
	strh r0,[r4,#0xa]	; 0230A158
	bl loc_0231020C	; 0230A15A
	cmp r0,#0x0	; 0230A15E
	beq loc_0230A176	; 0230A160
	mov r1,#0xe	; 0230A162
	ldr r0,[r4,#0x1c]	; 0230A164
	strh r1,[r0,#0x4]	; 0230A166
	mov r2,#0x15	; 0230A168
	ldr r0,[pool_0230A1F0]	; 0230A16A
	ldr r1,[r0,#0x0]	; 0230A16C
	ldr r0,[pool_0230A1F4]	; 0230A16E
	strh r2,[r1,r0]	; 0230A170
	mov r5,#0x1	; 0230A172
	b loc_0230A1DE	; 0230A174
loc_0230A176:
	ldrh r0,[r4,#0x0]	; 0230A176
	cmp r0,#0x10	; 0230A178
	bne loc_0230A18A	; 0230A17A
	add r0,r6,#0x0	; 0230A17C
	mov r1,#0x0	; 0230A17E
	bl loc_02306944	; 0230A180
	bl loc_02305BEC	; 0230A184
	b loc_0230A192	; 0230A188
loc_0230A18A:
	add r0,r6,#0x0	; 0230A18A
	mov r1,#0x1	; 0230A18C
	bl loc_02306944	; 0230A18E
loc_0230A192:
	mov r0,#0x12	; 0230A192
	strh r0,[r4,#0x0]	; 0230A194
loc_0230A196:
	mov r0,#0x13	; 0230A196
	strh r0,[r4,#0x0]	; 0230A198
	ldr r0,[r4,#0x18]	; 0230A19A
	ldrh r1,[r0,#0x38]	; 0230A19C
	cmp r1,#0x0	; 0230A19E
	bne loc_0230A1BE	; 0230A1A0
	add r0,#0x10	; 0230A1A2
	bl loc_0230C230	; 0230A1A4
	cmp r0,#0x0	; 0230A1A8
	bne loc_0230A1BA	; 0230A1AA
	mov r1,#0x8	; 0230A1AC
	ldr r0,[r4,#0x1c]	; 0230A1AE
	strh r1,[r0,#0x4]	; 0230A1B0
	mov r0,#0x15	; 0230A1B2
	strh r0,[r4,#0x0]	; 0230A1B4
	mov r5,#0x1	; 0230A1B6
	b loc_0230A1DE	; 0230A1B8
loc_0230A1BA:
	bl loc_0230CAEC	; 0230A1BA
loc_0230A1BE:
	ldrh r0,[r4,#0xc]	; 0230A1BE
	ldr r1,[pool_0230A1FC]	; 0230A1C0
	bl loc_023055F4	; 0230A1C2
	b loc_0230A1DE	; 0230A1C6
loc_0230A1C8:
	strh r5,[r4,#0x0]	; 0230A1C8
	bl loc_02305B3C	; 0230A1CA
	ldr r0,[pool_0230A1F0]	; 0230A1CE
	ldr r2,[r0,#0x0]	; 0230A1D0
	ldr r0,[pool_0230A200]	; 0230A1D2
	ldrh r1,[r2,r0]	; 0230A1D4
	ldr r0,[pool_0230A1F8]	; 0230A1D6
	strh r1,[r2,r0]	; 0230A1D8
	bl loc_02309C18	; 0230A1DA
loc_0230A1DE:
	cmp r5,#0x0	; 0230A1DE
	beq loc_0230A1EA	; 0230A1E0
	mov r0,#0x2	; 0230A1E2
	mov r1,#0x0	; 0230A1E4
	bl loc_02304B68	; 0230A1E6
loc_0230A1EA:
	pop {r4,r5,r6}	; 0230A1EA
	pop {r3}	; 0230A1EC
	bx r3	; 0230A1EE
pool_0230A1F0:
loc_0230A1F0:
	.word FirmwareWlWorkPointerSlot	; 0230A1F0
pool_0230A1F4:
loc_0230A1F4:
	.word 0x000003BC	; 0230A1F4
pool_0230A1F8:
loc_0230A1F8:
	.word 0x00000314	; 0230A1F8
pool_0230A1FC:
loc_0230A1FC:
	.word P4_Code_0230A074 + 1	; 0230A1FC
pool_0230A200:
loc_0230A200:
	.word 0x000002F2	; 0230A200

; ===== function loc_0230A204 =====
loc_0230A204:
	bx pc	; 0230A204
	.byte 0xC0, 0x46	; 0230A208
.arm

; ===== function loc_0230A208 =====
loc_0230A208:
	ldr pc,[pool_0230A20C]	; 0230A208
pool_0230A20C:
loc_0230A20C:
	.word loc_03802514	; 0230A20C
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x12, 0x20, 0x70, 0x80, 0x28, 0x48, 0x01, 0x68	; 0230A220
	.byte 0x28, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x44, 0xE0, 0x68, 0x8A, 0x03, 0x28	; 0230A230
	.byte 0x01, 0xD9, 0x05, 0x20, 0x3F, 0xE0, 0xA8, 0x8A, 0x3F, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x3A, 0xE0	; 0230A240
	.byte 0xE9, 0x8A, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x35, 0xE0, 0x1F, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230A250
	.byte 0x05, 0x20, 0x30, 0xE0, 0x00, 0x24, 0x2F, 0x1C, 0x18, 0x37, 0x17, 0xE0, 0x38, 0x19, 0xFB, 0xF7	; 0230A260
	.byte 0xA9, 0xF8, 0x00, 0x28, 0x14, 0xD0, 0x02, 0x1C, 0xF0, 0x21, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0	; 0230A270
	.byte 0x05, 0x20, 0x20, 0xE0, 0x01, 0x21, 0x81, 0x40, 0x11, 0x48, 0x02, 0x68, 0x13, 0x48, 0x10, 0x5A	; 0230A280
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x15, 0xE0, 0x64, 0x1C, 0x10, 0x2C, 0xE5, 0xD3	; 0230A290
	.byte 0x00, 0x2C, 0x01, 0xD1, 0x05, 0x20, 0x0E, 0xE0, 0x09, 0x48, 0x02, 0x68, 0x0C, 0x49, 0x55, 0x50	; 0230A2A0
	.byte 0x02, 0x68, 0x0C, 0x49, 0x56, 0x50, 0x80, 0x22, 0xB2, 0x80, 0x01, 0x68, 0x0A, 0x48, 0x0A, 0x52	; 0230A2B0
	.byte 0xFF, 0xF7, 0xF6, 0xFC, 0x80, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230A2C0
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00	; 0230A2D0
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C	; 0230A2E0
	.byte 0x01, 0x20, 0x48, 0x80, 0x47, 0x48, 0x00, 0x68, 0x47, 0x49, 0x41, 0x5A, 0x01, 0x29, 0x03, 0xD0	; 0230A2F0
	.byte 0x00, 0x29, 0x01, 0xD0, 0x0B, 0x20, 0x81, 0xE0, 0x44, 0x49, 0x41, 0x5A, 0x20, 0x29, 0x01, 0xD0	; 0230A300
	.byte 0x01, 0x20, 0x7B, 0xE0, 0x21, 0x8A, 0x20, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x76, 0xE0, 0x00, 0x29	; 0230A310
	.byte 0x01, 0xD1, 0x05, 0x20, 0x72, 0xE0, 0x62, 0x8E, 0x0A, 0x2A, 0x01, 0xD2, 0x05, 0x20, 0x6D, 0xE0	; 0230A320
	.byte 0x3B, 0x49, 0x8A, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x68, 0xE0, 0xA1, 0x8E, 0x00, 0x29, 0x01, 0xD1	; 0230A330
	.byte 0x05, 0x20, 0x63, 0xE0, 0xFF, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x5F, 0xE0, 0xE3, 0x8E, 0x35, 0x49	; 0230A340
	.byte 0x1A, 0x1C, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0, 0x05, 0x20, 0x57, 0xE0, 0x01, 0x22, 0x9A, 0x40	; 0230A350
	.byte 0x31, 0x49, 0x40, 0x5A, 0x02, 0x40, 0x00, 0x2A, 0x01, 0xD1, 0x05, 0x20, 0x4E, 0xE0, 0x21, 0x8F	; 0230A360
	.byte 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x49, 0xE0, 0x2C, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0	; 0230A370
	.byte 0x05, 0x20, 0x43, 0xE0, 0x61, 0x8F, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x3E, 0xE0, 0x01, 0x40	; 0230A380
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x39, 0xE0, 0xA0, 0x8F, 0x80, 0x28, 0x01, 0xD9, 0x05, 0x20	; 0230A390
	.byte 0x34, 0xE0, 0x00, 0x20, 0x05, 0xF0, 0x3A, 0xFF, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x2D, 0xE0	; 0230A3A0
	.byte 0x18, 0x48, 0x01, 0x68, 0x18, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x03, 0xD1, 0x1C, 0x48, 0xFC, 0xF7	; 0230A3B0
	.byte 0xC1, 0xFC, 0x03, 0xE0, 0x1B, 0x48, 0x08, 0x18, 0xFC, 0xF7, 0xBC, 0xFC, 0x20, 0x8A, 0x21, 0x1C	; 0230A3C0
	.byte 0x12, 0x31, 0xFC, 0xF7, 0x4B, 0xFC, 0x60, 0x8E, 0xFC, 0xF7, 0x26, 0xFC, 0xA0, 0x8E, 0xFC, 0xF7	; 0230A3D0
	.byte 0x0F, 0xFC, 0xE0, 0x8E, 0x00, 0x21, 0xFC, 0xF7, 0xB5, 0xFA, 0x20, 0x1C, 0x38, 0x30, 0xFC, 0xF7	; 0230A3E0
	.byte 0x99, 0xFA, 0xA0, 0x8F, 0x3E, 0x34, 0x21, 0x1C, 0xFC, 0xF7, 0x20, 0xF9, 0x00, 0x22, 0x05, 0x48	; 0230A3F0
	.byte 0x01, 0x68, 0x0D, 0x48, 0x0A, 0x52, 0xFB, 0xF7, 0xF9, 0xFB, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC	; 0230A400
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00	; 0230A410
	.byte 0xE8, 0x03, 0x00, 0x00, 0xF0, 0xFF, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF	; 0230A420
	.byte 0x78, 0x03, 0x31, 0x02, 0xE8, 0x02, 0x00, 0x00, 0xA0, 0x03, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0	; 0230A430
	.byte 0x05, 0x1C, 0x0C, 0x1C, 0x03, 0x20, 0x60, 0x80, 0x24, 0x48, 0x01, 0x68, 0x24, 0x48, 0x08, 0x5A	; 0230A440
	.byte 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x3A, 0xE0, 0x21, 0x48, 0x08, 0x5A	; 0230A450
	.byte 0x30, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x34, 0xE0, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 0230A460
	.byte 0x01, 0xD0, 0x05, 0x20, 0x2D, 0xE0, 0xE8, 0x8A, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x28, 0xE0	; 0230A470
	.byte 0xFF, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x24, 0xE0, 0x29, 0x8B, 0x17, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230A480
	.byte 0x05, 0x20, 0x1E, 0xE0, 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20, 0x1A, 0xE0, 0x30, 0x20, 0xFB, 0xF7	; 0230A490
	.byte 0xEB, 0xFF, 0xFC, 0xF7, 0x1F, 0xF8, 0xEB, 0x8A, 0x0C, 0x48, 0x02, 0x68, 0x0F, 0x49, 0x53, 0x52	; 0230A4A0
	.byte 0xEB, 0x8A, 0x02, 0x68, 0x0E, 0x49, 0x53, 0x52, 0x02, 0x68, 0x0E, 0x49, 0x55, 0x50, 0x02, 0x68	; 0230A4B0
	.byte 0x0D, 0x49, 0x54, 0x50, 0x50, 0x22, 0x01, 0x68, 0x0C, 0x48, 0x0A, 0x52, 0xFF, 0xF7, 0xF8, 0xFC	; 0230A4C0
	.byte 0x80, 0x20, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230A4D0
	.byte 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xD0, 0x07, 0x00, 0x00, 0x6C, 0x03, 0x00, 0x00	; 0230A4E0
	.byte 0x6E, 0x03, 0x00, 0x00, 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00	; 0230A4F0
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x04, 0x20, 0x60, 0x80, 0x21, 0x48, 0x02, 0x68, 0x21, 0x48	; 0230A500
	.byte 0x11, 0x5A, 0x03, 0x29, 0x05, 0xD0, 0x02, 0x29, 0x03, 0xD0, 0x01, 0x29, 0x01, 0xD0, 0x0B, 0x20	; 0230A510
	.byte 0x33, 0xE0, 0x1D, 0x48, 0x10, 0x5A, 0x30, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x2D, 0xE0, 0x1B, 0x48	; 0230A520
	.byte 0x08, 0x18, 0x00, 0x04, 0x00, 0x0C, 0x01, 0x28, 0x06, 0xD8, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40	; 0230A530
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x20, 0xE0, 0xA0, 0x1D, 0x29, 0x1C, 0x10, 0x31, 0xFB, 0xF7	; 0230A540
	.byte 0x8B, 0xFF, 0xA0, 0x1D, 0xE9, 0x8A, 0x01, 0xF0, 0x87, 0xFD, 0x06, 0x1C, 0x00, 0x2E, 0x01, 0xD1	; 0230A550
	.byte 0x08, 0x20, 0x12, 0xE0, 0x28, 0x1C, 0x10, 0x30, 0x02, 0xF0, 0x70, 0xFB, 0x08, 0x48, 0x02, 0x68	; 0230A560
	.byte 0x0B, 0x49, 0x55, 0x50, 0x02, 0x68, 0x0B, 0x49, 0x54, 0x50, 0x41, 0x22, 0x01, 0x68, 0x0A, 0x48	; 0230A570
	.byte 0x0A, 0x52, 0x30, 0x1C, 0x02, 0xF0, 0xBA, 0xFA, 0x80, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230A580
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xFE, 0xFF, 0x00, 0x00	; 0230A590
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0	; 0230A5A0
	.byte 0x05, 0x1C, 0x0C, 0x1C, 0x06, 0x20, 0x60, 0x80, 0x22, 0x48, 0x01, 0x68, 0x22, 0x48, 0x08, 0x5A	; 0230A5B0
	.byte 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x37, 0xE0, 0x1F, 0x48, 0x08, 0x5A	; 0230A5C0
	.byte 0x20, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x31, 0xE0, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 0230A5D0
	.byte 0x01, 0xD0, 0x05, 0x20, 0x2A, 0xE0, 0xE8, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x25, 0xE0	; 0230A5E0
	.byte 0x29, 0x8B, 0x17, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x1F, 0xE0, 0x0A, 0x29, 0x01, 0xD2	; 0230A5F0
	.byte 0x05, 0x20, 0x1B, 0xE0, 0x20, 0x20, 0xFB, 0xF7, 0x37, 0xFF, 0x0E, 0x49, 0x08, 0x68, 0x11, 0x4A	; 0230A600
	.byte 0x85, 0x50, 0x0B, 0x68, 0x10, 0x48, 0x1C, 0x50, 0x30, 0x25, 0x0B, 0x68, 0x0F, 0x48, 0x1D, 0x52	; 0230A610
	.byte 0x08, 0x68, 0x80, 0x58, 0xC0, 0x8A, 0xE0, 0x81, 0x08, 0x34, 0x20, 0x1C, 0x09, 0x68, 0x89, 0x58	; 0230A620
	.byte 0x10, 0x31, 0xFB, 0xF7, 0x19, 0xFF, 0xFF, 0xF7, 0x97, 0xFC, 0x80, 0x20, 0x01, 0xB0, 0x30, 0xBC	; 0230A630
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00	; 0230A640
	.byte 0xD0, 0x07, 0x00, 0x00, 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00	; 0230A650
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0C, 0x1C, 0x05, 0x20, 0x60, 0x80, 0x54, 0x48, 0x01, 0x68	; 0230A660
	.byte 0x54, 0x48, 0x08, 0x5A, 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x9A, 0xE0	; 0230A670
	.byte 0x51, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x94, 0xE0, 0x20, 0x20, 0xFB, 0xF7	; 0230A680
	.byte 0xF3, 0xFE, 0x29, 0x8B, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x8A, 0xE0	; 0230A690
	.byte 0xE9, 0x8B, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x85, 0xE0, 0x20, 0x29, 0x01, 0xD9, 0x05, 0x20	; 0230A6A0
	.byte 0x81, 0xE0, 0x29, 0x1C, 0x46, 0x31, 0x0A, 0x88, 0x0A, 0x2A, 0x01, 0xD2, 0x05, 0x20, 0x7A, 0xE0	; 0230A6B0
	.byte 0x42, 0x49, 0x8A, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x75, 0xE0, 0x29, 0x1C, 0x48, 0x31, 0x09, 0x88	; 0230A6C0
	.byte 0xFF, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x6E, 0xE0, 0x29, 0x1C, 0x4A, 0x31, 0x0B, 0x88, 0x3C, 0x49	; 0230A6D0
	.byte 0x1A, 0x1C, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0, 0x05, 0x20, 0x64, 0xE0, 0x98, 0x40, 0x34, 0x49	; 0230A6E0
	.byte 0x0A, 0x68, 0x38, 0x49, 0x51, 0x5A, 0x08, 0x40, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x5A, 0xE0	; 0230A6F0
	.byte 0x28, 0x1C, 0x42, 0x30, 0x00, 0x88, 0x34, 0x4A, 0x01, 0x1C, 0x11, 0x40, 0x00, 0x29, 0x01, 0xD0	; 0230A700
	.byte 0x05, 0x20, 0x50, 0xE0, 0x29, 0x1C, 0x44, 0x31, 0x0B, 0x88, 0x19, 0x1C, 0x11, 0x40, 0x00, 0x29	; 0230A710
	.byte 0x01, 0xD0, 0x05, 0x20, 0x47, 0xE0, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x43, 0xE0, 0x03, 0x43	; 0230A720
	.byte 0x00, 0x2B, 0x01, 0xD1, 0x05, 0x20, 0x3E, 0xE0, 0x29, 0x8A, 0x28, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230A730
	.byte 0x05, 0x20, 0x38, 0xE0, 0x00, 0x20, 0x05, 0xF0, 0x69, 0xFD, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20	; 0230A740
	.byte 0x31, 0xE0, 0x28, 0x1C, 0x40, 0x30, 0x01, 0x88, 0x20, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD1	; 0230A750
	.byte 0x00, 0x20, 0xFC, 0xF7, 0xD1, 0xFB, 0x28, 0x1C, 0x18, 0x30, 0xFC, 0xF7, 0xEB, 0xFA, 0xE8, 0x8B	; 0230A760
	.byte 0x29, 0x1C, 0x20, 0x31, 0xFC, 0xF7, 0x7A, 0xFA, 0x28, 0x1C, 0x46, 0x30, 0x00, 0x88, 0xFC, 0xF7	; 0230A770
	.byte 0x53, 0xFA, 0x28, 0x1C, 0x4A, 0x30, 0x00, 0x88, 0x00, 0x21, 0xFC, 0xF7, 0xE3, 0xF8, 0x28, 0x1C	; 0230A780
	.byte 0x42, 0x30, 0xFC, 0xF7, 0xC7, 0xF8, 0x0A, 0x48, 0x02, 0x68, 0x11, 0x49, 0x55, 0x50, 0x02, 0x68	; 0230A790
	.byte 0x10, 0x49, 0x54, 0x50, 0x20, 0x22, 0x01, 0x68, 0x0F, 0x48, 0x0A, 0x52, 0x02, 0x20, 0x01, 0x21	; 0230A7A0
	.byte 0xFA, 0xF7, 0xE2, 0xF9, 0x80, 0x20, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230A7B0
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00	; 0230A7C0
	.byte 0xF0, 0xFF, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xD0, 0x07, 0x00, 0x00	; 0230A7D0
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0xF0, 0xB5, 0x81, 0xB0	; 0230A7E0
	.byte 0x05, 0x1C, 0x0E, 0x1C, 0x70, 0x88, 0x83, 0x1E, 0x3B, 0x4A, 0x11, 0x68, 0x3B, 0x48, 0x0B, 0x52	; 0230A7F0
	.byte 0x03, 0x20, 0x70, 0x80, 0x11, 0x68, 0x3A, 0x48, 0x08, 0x5A, 0x01, 0x28, 0x05, 0xD0, 0x03, 0x28	; 0230A800
	.byte 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x61, 0xE0, 0x36, 0x48, 0x08, 0x5A, 0x20, 0x28	; 0230A810
	.byte 0x01, 0xD2, 0x01, 0x20, 0x5B, 0xE0, 0xE8, 0x8A, 0x20, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x56, 0xE0	; 0230A820
	.byte 0x28, 0x8F, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x51, 0xE0, 0x28, 0x1C, 0x3A, 0x30, 0xFA, 0xF7	; 0230A830
	.byte 0xC1, 0xFD, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x49, 0xE0, 0x28, 0x1C, 0x4A, 0x30, 0x01, 0x88	; 0230A840
	.byte 0x29, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x41, 0xE0, 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20	; 0230A850
	.byte 0x3D, 0xE0, 0x28, 0x1C, 0x4C, 0x30, 0x00, 0x88, 0x10, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x36, 0xE0	; 0230A860
	.byte 0x00, 0x24, 0x2F, 0x1C, 0x3A, 0x37, 0x17, 0xE0, 0x38, 0x19, 0xFA, 0xF7, 0xA3, 0xFD, 0x00, 0x28	; 0230A870
	.byte 0x14, 0xD0, 0x02, 0x1C, 0xF0, 0x21, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0, 0x05, 0x20, 0x26, 0xE0	; 0230A880
	.byte 0x01, 0x21, 0x81, 0x40, 0x14, 0x48, 0x02, 0x68, 0x18, 0x48, 0x10, 0x5A, 0x01, 0x40, 0x00, 0x29	; 0230A890
	.byte 0x01, 0xD1, 0x05, 0x20, 0x1B, 0xE0, 0x64, 0x1C, 0x10, 0x2C, 0xE5, 0xD3, 0x28, 0x1C, 0x10, 0x30	; 0230A8A0
	.byte 0xFC, 0xF7, 0x48, 0xFA, 0xE8, 0x8A, 0x29, 0x1C, 0x18, 0x31, 0xFC, 0xF7, 0xD7, 0xF9, 0x0A, 0x48	; 0230A8B0
	.byte 0x02, 0x68, 0x0F, 0x49, 0x55, 0x50, 0x02, 0x68, 0x0E, 0x49, 0x56, 0x50, 0x10, 0x22, 0x01, 0x68	; 0230A8C0
	.byte 0x0D, 0x48, 0x0A, 0x52, 0x02, 0x20, 0x00, 0x21, 0xFA, 0xF7, 0x4E, 0xF9, 0x80, 0x20, 0x01, 0xB0	; 0230A8D0
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xC0, 0x03, 0x00, 0x00	; 0230A8E0
	.byte 0xF2, 0x02, 0x00, 0x00, 0x10, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00	; 0230A8F0
	.byte 0xD4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0xBC, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C	; 0230A900
	.byte 0x09, 0x20, 0x48, 0x80, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x2D, 0xE0, 0x61, 0x8A	; 0230A910
	.byte 0x01, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x28, 0xE0, 0xA1, 0x8A, 0x01, 0x29, 0x01, 0xD9, 0x05, 0x20	; 0230A920
	.byte 0x23, 0xE0, 0xFB, 0xF7, 0x91, 0xFF, 0x20, 0x8A, 0x01, 0x28, 0x17, 0xD1, 0x60, 0x8A, 0x01, 0x28	; 0230A930
	.byte 0x03, 0xD1, 0x0F, 0x48, 0xFB, 0xF7, 0x66, 0xFF, 0x02, 0xE0, 0x00, 0x20, 0xFB, 0xF7, 0x62, 0xFF	; 0230A940
	.byte 0x0C, 0x48, 0x01, 0x68, 0x0C, 0x48, 0x0B, 0x18, 0x1A, 0x88, 0x08, 0x20, 0x82, 0x43, 0xA1, 0x8A	; 0230A950
	.byte 0x01, 0x20, 0x01, 0x40, 0xC8, 0x00, 0x02, 0x43, 0x1A, 0x80, 0x05, 0xE0, 0x07, 0x48, 0xFB, 0xF7	; 0230A960
	.byte 0x51, 0xFF, 0x02, 0x20, 0xFB, 0xF7, 0x54, 0xFF, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230A970
	.byte 0x01, 0x80, 0x00, 0x00, 0xF4, 0xFF, 0x80, 0x03, 0x16, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 0230A980
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20	; 0230A990
	.byte 0x07, 0xE0, 0xFB, 0xF7, 0xD3, 0xF8, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD1, 0xFB, 0xF7, 0x1C, 0xFD	; 0230A9A0
	.byte 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68	; 0230A9B0
	.byte 0x03, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230A9C0
	.byte 0xF8, 0x02, 0x00, 0x00, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68, 0x03, 0x48, 0x10, 0x5A	; 0230A9D0
	.byte 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00	; 0230A9E0
	.byte 0x03, 0x20, 0x48, 0x80, 0x05, 0x4B, 0x1A, 0x68, 0x05, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x1A, 0x68	; 0230A9F0
	.byte 0x04, 0x48, 0x10, 0x5A, 0x08, 0x81, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230AA00
	.byte 0xF0, 0x02, 0x00, 0x00, 0x76, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x04, 0x20, 0x48, 0x80	; 0230AA10
	.byte 0x88, 0x1D, 0x05, 0x49, 0x0A, 0x68, 0x05, 0x49, 0x51, 0x18, 0xFB, 0xF7, 0x1D, 0xFD, 0x00, 0x20	; 0230AA20
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xE8, 0x02, 0x00, 0x00	; 0230AA30
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x0E, 0x48, 0x01, 0x68, 0x0E, 0x48	; 0230AA40
	.byte 0x08, 0x5A, 0x01, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x0F, 0xE0, 0x2C, 0x8A, 0x60, 0x1C, 0x02, 0x21	; 0230AA50
	.byte 0x00, 0xF0, 0x14, 0xF8, 0xE9, 0x89, 0x40, 0x1C, 0x81, 0x42, 0x01, 0xDA, 0x04, 0x20, 0x04, 0xE0	; 0230AA60
	.byte 0x20, 0x1C, 0x12, 0x35, 0x29, 0x1C, 0xFB, 0xF7, 0x95, 0xFD, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 0230AA70
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF2, 0x02, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 0230AA80
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x14, 0x25, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x23, 0x4B, 0x80	; 0230AA90
	.byte 0x06, 0x49, 0x0A, 0x68, 0x06, 0x49, 0x51, 0x5A, 0x10, 0x29, 0x03, 0xD3, 0x00, 0x8A, 0xFC, 0xF7	; 0230AAA0
	.byte 0x77, 0xF9, 0x03, 0x1C, 0x18, 0x1C, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 0230AAB0
	.byte 0x10, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x01, 0x24, 0x4C, 0x80, 0x0D, 0x4B, 0x1A, 0x68, 0x0D, 0x49	; 0230AAC0
	.byte 0x51, 0x5A, 0x20, 0x29, 0x01, 0xD9, 0x20, 0x1C, 0x0F, 0xE0, 0x02, 0x1C, 0x10, 0x32, 0x11, 0x88	; 0230AAD0
	.byte 0x49, 0x1C, 0x11, 0x80, 0x1A, 0x68, 0x01, 0x8A, 0x07, 0x48, 0x10, 0x5A, 0x81, 0x42, 0x01, 0xD9	; 0230AAE0
	.byte 0x05, 0x20, 0x02, 0xE0, 0x05, 0x48, 0x11, 0x52, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230AAF0
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xE4, 0x02, 0x00, 0x00, 0xE6, 0x02, 0x00, 0x00	; 0230AB00
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x03, 0x1C, 0x25, 0x48, 0x04, 0x68, 0x25, 0x4A, 0xA2, 0x58, 0x01, 0x24	; 0230AB10
	.byte 0x4C, 0x80, 0x19, 0x8A, 0x04, 0x68, 0x23, 0x48, 0x20, 0x5A, 0x81, 0x42, 0x04, 0xD3, 0x22, 0x48	; 0230AB20
	.byte 0x81, 0x42, 0x01, 0xD0, 0x05, 0x20, 0x35, 0xE0, 0x9C, 0x8A, 0x3F, 0x2C, 0x04, 0xD9, 0x1E, 0x48	; 0230AB30
	.byte 0x84, 0x42, 0x01, 0xD0, 0x05, 0x20, 0x2D, 0xE0, 0x1B, 0x48, 0x81, 0x42, 0x14, 0xD1, 0x01, 0x21	; 0230AB40
	.byte 0x16, 0x4D, 0x1C, 0x24, 0x17, 0x4F, 0x0A, 0xE0, 0x08, 0x1C, 0x60, 0x43, 0x10, 0x18, 0x5E, 0x8A	; 0230AB50
	.byte 0x46, 0x83, 0x06, 0x8B, 0x00, 0x2E, 0x01, 0xD0, 0x5E, 0x8A, 0x06, 0x83, 0x49, 0x1C, 0x28, 0x68	; 0230AB60
	.byte 0xC0, 0x5B, 0x81, 0x42, 0xF0, 0xD3, 0x0F, 0xE0, 0x00, 0x29, 0x0D, 0xD0, 0x5C, 0x8A, 0x1C, 0x20	; 0230AB70
	.byte 0x41, 0x43, 0x51, 0x18, 0x4C, 0x83, 0x18, 0x32, 0x19, 0x8A, 0x41, 0x43, 0x54, 0x18, 0x50, 0x5A	; 0230AB80
	.byte 0x00, 0x28, 0x01, 0xD0, 0x58, 0x8A, 0x20, 0x80, 0x98, 0x8A, 0x00, 0x28, 0x01, 0xD0, 0xFB, 0xF7	; 0230AB90
	.byte 0x9F, 0xFD, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 0230ABA0
	.byte 0xE0, 0x02, 0x00, 0x00, 0xE6, 0x02, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 0230ABB0
	.byte 0x01, 0x22, 0x4A, 0x80, 0x0B, 0x49, 0x0B, 0x68, 0x0B, 0x49, 0x59, 0x5A, 0x20, 0x29, 0x01, 0xD9	; 0230ABC0
	.byte 0x10, 0x1C, 0x0C, 0xE0, 0x20, 0x29, 0x07, 0xD1, 0x08, 0x49, 0x59, 0x5A, 0x49, 0x07, 0xC9, 0x0F	; 0230ABD0
	.byte 0x00, 0x29, 0x01, 0xD0, 0x10, 0x1C, 0x02, 0xE0, 0x00, 0x8A, 0xFC, 0xF7, 0x25, 0xFB, 0x01, 0xB0	; 0230ABE0
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x16, 0x03, 0x00, 0x00	; 0230ABF0
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x2B, 0x49, 0x0A, 0x68, 0x2B, 0x49	; 0230AC00
	.byte 0x51, 0x5A, 0x10, 0x29, 0x4B, 0xD1, 0x28, 0x1C, 0x10, 0x30, 0xFC, 0xF7, 0x6F, 0xFB, 0x04, 0x1C	; 0230AC10
	.byte 0xE8, 0x8A, 0xFC, 0xF7, 0x59, 0xFB, 0x04, 0x43, 0x28, 0x8B, 0xFC, 0xF7, 0x39, 0xFB, 0x04, 0x43	; 0230AC20
	.byte 0xA8, 0x8B, 0xFC, 0xF7, 0x01, 0xFB, 0x04, 0x43, 0xE8, 0x8B, 0xFC, 0xF7, 0xE9, 0xFA, 0x04, 0x43	; 0230AC30
	.byte 0x28, 0x8C, 0xFC, 0xF7, 0x89, 0xFA, 0x04, 0x43, 0x68, 0x8C, 0xFC, 0xF7, 0x77, 0xFA, 0x04, 0x43	; 0230AC40
	.byte 0x28, 0x1C, 0x24, 0x30, 0xFC, 0xF7, 0x4C, 0xFA, 0x04, 0x43, 0x28, 0x1C, 0x74, 0x30, 0x00, 0x88	; 0230AC50
	.byte 0xFC, 0xF7, 0x32, 0xFA, 0x04, 0x43, 0x28, 0x1C, 0x76, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0x16, 0xFA	; 0230AC60
	.byte 0x04, 0x43, 0x28, 0x1C, 0x78, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0xF8, 0xF9, 0x04, 0x43, 0x28, 0x1C	; 0230AC70
	.byte 0x7A, 0x30, 0x00, 0x88, 0x00, 0x21, 0xFC, 0xF7, 0xA7, 0xF9, 0x04, 0x43, 0x28, 0x1C, 0x7C, 0x30	; 0230AC80
	.byte 0xFC, 0xF7, 0x90, 0xF9, 0x04, 0x43, 0x28, 0x1C, 0x9C, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0x34, 0xF9	; 0230AC90
	.byte 0x04, 0x43, 0x9E, 0x35, 0x28, 0x88, 0xFC, 0xF7, 0x21, 0xF9, 0x04, 0x43, 0x20, 0x1C, 0x01, 0xB0	; 0230ACA0
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00	; 0230ACB0
.thumb

; ===== function loc_0230ACB0 =====
loc_0230ACB0:
	ldr r0,[pool_0230ACF8]	; 0230ACB0
	ldr r1,[r0,#0x0]	; 0230ACB2
	ldr r0,[pool_0230ACFC]	; 0230ACB4
	ldrh r0,[r1,r0]	; 0230ACB6
	lsl r0,r0,#0x1a	; 0230ACB8
	lsr r0,r0,#0x1f	; 0230ACBA
	cmp r0,#0x0	; 0230ACBC
	beq loc_0230ACD4	; 0230ACBE
	mov r1,#0x0	; 0230ACC0
	ldr r0,[pool_0230AD00]	; 0230ACC2
	strh r1,[r0,#0x0]	; 0230ACC4
	strh r1,[r0,#0x4]	; 0230ACC6
	ldr r2,[pool_0230AD04]	; 0230ACC8
	ldrh r1,[r2,#0x0]	; 0230ACCA
	ldr r0,[pool_0230AD08]	; 0230ACCC
	orr r1,r0	; 0230ACCE
	strh r1,[r2,#0x0]	; 0230ACD0
	bx lr	; 0230ACD2
loc_0230ACD4:
	mov r1,#0x1	; 0230ACD4
	ldr r0,[pool_0230AD0C]	; 0230ACD6
	strh r1,[r0,#0x0]	; 0230ACD8
	mov r2,#0x0	; 0230ACDA
	ldr r0,[pool_0230AD10]	; 0230ACDC
	strh r2,[r0,#0x0]	; 0230ACDE
	mov r1,#0x2	; 0230ACE0
	ldr r0,[pool_0230AD14]	; 0230ACE2
	strh r1,[r0,#0x0]	; 0230ACE4
	ldr r1,[pool_0230AD18]	; 0230ACE6
	ldr r0,[pool_0230AD1C]	; 0230ACE8
	strh r1,[r0,#0x0]	; 0230ACEA
	ldr r0,[pool_0230AD20]	; 0230ACEC
	strh r2,[r0,#0x0]	; 0230ACEE
	ldr r0,[pool_0230AD24]	; 0230ACF0
	strh r2,[r0,#0x0]	; 0230ACF2
	bx lr	; 0230ACF4
	.byte 0xC0, 0x46	; 0230ACF8
pool_0230ACF8:
loc_0230ACF8:
	.word FirmwareWlWorkPointerSlot	; 0230ACF8
pool_0230ACFC:
loc_0230ACFC:
	.word 0x00000316	; 0230ACFC
pool_0230AD00:
loc_0230AD00:
	.word WifiRamBase	; 0230AD00
pool_0230AD04:
loc_0230AD04:
	.word REG_WIFI_TXBUF_LOC1	; 0230AD04
pool_0230AD08:
loc_0230AD08:
	.word 0x00008000	; 0230AD08
pool_0230AD0C:
loc_0230AD0C:
	.word REG_WIFI_TXREQ_RESET	; 0230AD0C
pool_0230AD10:
loc_0230AD10:
	.word REG_WIFI_MODE_RST	; 0230AD10
pool_0230AD14:
loc_0230AD14:
	.word REG_WIFI_IE	; 0230AD14
pool_0230AD18:
loc_0230AD18:
	.word 0x0000FFFF	; 0230AD18
pool_0230AD1C:
loc_0230AD1C:
	.word REG_WIFI_IF	; 0230AD1C
pool_0230AD20:
loc_0230AD20:
	.word REG_WIFI_TX_HDR_CNT	; 0230AD20
pool_0230AD24:
loc_0230AD24:
	.word REG_WIFI_POWERFORCE	; 0230AD24
	.byte 0x10, 0xB5, 0x82, 0xB0, 0x04, 0x1C, 0xFA, 0xF7, 0x5D, 0xFF, 0xFA, 0xF7, 0x03, 0xFF, 0x06, 0x20	; 0230AD38
	.byte 0xFA, 0xF7, 0xE4, 0xFE, 0x27, 0x49, 0x0A, 0x68, 0x27, 0x49, 0x50, 0x52, 0x60, 0x8A, 0x04, 0x28	; 0230AD48
	.byte 0x03, 0xD1, 0x06, 0x20, 0x00, 0x21, 0xFA, 0xF7, 0xA3, 0xFE, 0x00, 0x21, 0x00, 0xA8, 0x01, 0x80	; 0230AD58
	.byte 0x00, 0x88, 0x22, 0x49, 0x0C, 0x22, 0x00, 0xF0, 0x5D, 0xF8, 0x14, 0x20, 0x1F, 0x4A, 0x10, 0x81	; 0230AD68
	.byte 0x1F, 0x48, 0x50, 0x81, 0x0C, 0x32, 0x00, 0x23, 0x1E, 0x49, 0x1F, 0x48, 0x11, 0x80, 0x92, 0x1C	; 0230AD78
	.byte 0x9B, 0x1C, 0x83, 0x42, 0xFA, 0xD3, 0x08, 0x21, 0x18, 0x48, 0x81, 0x81, 0x06, 0x21, 0x1B, 0x48	; 0230AD88
	.byte 0x01, 0x80, 0x12, 0x23, 0x13, 0x4A, 0x11, 0x68, 0x19, 0x48, 0x0B, 0x52, 0x11, 0x68, 0x19, 0x48	; 0230AD98
	.byte 0x0A, 0x18, 0x11, 0x88, 0x20, 0x20, 0x01, 0x43, 0x11, 0x80, 0x17, 0x49, 0x17, 0x48, 0x01, 0x80	; 0230ADA8
	.byte 0xE0, 0x8A, 0x01, 0x21, 0xFB, 0xF7, 0xCA, 0xFD, 0x02, 0x21, 0x15, 0x48, 0x01, 0x80, 0x01, 0x21	; 0230ADB8
	.byte 0x14, 0x48, 0x01, 0x80, 0x14, 0x48, 0x01, 0x80, 0x08, 0x49, 0x14, 0x48, 0x01, 0x40, 0xC8, 0x03	; 0230ADC8
	.byte 0x01, 0x0C, 0x0D, 0x48, 0x01, 0x43, 0x12, 0x48, 0x01, 0x80, 0x02, 0xB0, 0x10, 0xBC, 0x08, 0xBC	; 0230ADD8
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xA8, 0x03, 0x00, 0x00, 0x00, 0x40, 0x80, 0x04	; 0230ADE8
	.byte 0xD0, 0x07, 0x00, 0x00, 0x55, 0x55, 0x00, 0x00, 0xF8, 0x05, 0x00, 0x00, 0x94, 0x81, 0x80, 0x04	; 0230ADF8
	.byte 0x10, 0x03, 0x00, 0x00, 0x16, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x40, 0x80, 0x80, 0x04	; 0230AE08
	.byte 0x12, 0x80, 0x80, 0x04, 0x04, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0xFF, 0x3F, 0x00, 0x00	; 0230AE18
	.byte 0xA0, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xCE, 0x7F, 0x03	; 0230AE28
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x5D, 0x49, 0x09, 0x68, 0x5D, 0x4A, 0x8B, 0x5A	; 0230AE38
	.byte 0xF0, 0x22, 0x13, 0x40, 0x10, 0x2B, 0x00, 0xD0, 0xAF, 0xE0, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9	; 0230AE48
	.byte 0x05, 0x20, 0xAA, 0xE0, 0xA0, 0x8A, 0x0A, 0x28, 0x03, 0xD0, 0x14, 0x28, 0x01, 0xD0, 0x05, 0x20	; 0230AE58
	.byte 0xA3, 0xE0, 0x01, 0x22, 0xE0, 0x8A, 0x82, 0x40, 0x53, 0x48, 0x08, 0x5A, 0x02, 0x40, 0x00, 0x2A	; 0230AE68
	.byte 0x01, 0xD1, 0x05, 0x20, 0x99, 0xE0, 0x60, 0x8A, 0x04, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x94, 0xE0	; 0230AE78
	.byte 0x00, 0x20, 0x05, 0xF0, 0xC7, 0xF9, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x8D, 0xE0, 0x20, 0x8A	; 0230AE88
	.byte 0x00, 0x28, 0x54, 0xD0, 0x01, 0x28, 0x00, 0xD0, 0x86, 0xE0, 0x45, 0x48, 0x01, 0x68, 0x45, 0x48	; 0230AE98
	.byte 0x09, 0x18, 0x08, 0x88, 0x10, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x7E, 0xE0, 0x60, 0x8A, 0x04, 0x28	; 0230AEA8
	.byte 0x7A, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44, 0x00, 0x47	; 0230AEB8
	.byte 0x0B, 0x00, 0x0B, 0x00, 0x0B, 0x00, 0x77, 0x00, 0x77, 0x00, 0x11, 0x20, 0x08, 0x80, 0x3B, 0x49	; 0230AEC8
	.byte 0x3B, 0x48, 0x01, 0x80, 0xE0, 0x8A, 0x01, 0x21, 0xFB, 0xF7, 0x38, 0xFD, 0x34, 0x48, 0x01, 0x68	; 0230AED8
	.byte 0x38, 0x48, 0x09, 0x18, 0x08, 0x88, 0x10, 0x22, 0x90, 0x43, 0xA2, 0x8A, 0x12, 0x03, 0x13, 0x0C	; 0230AEE8
	.byte 0x01, 0x22, 0x13, 0x40, 0x1A, 0x01, 0x10, 0x43, 0x08, 0x80, 0x02, 0x20, 0xFA, 0xF7, 0x06, 0xFE	; 0230AEF8
	.byte 0x01, 0x1C, 0x60, 0x8A, 0x01, 0x28, 0x01, 0xD8, 0x10, 0x20, 0x01, 0x43, 0xA2, 0x8A, 0x2E, 0x48	; 0230AF08
	.byte 0x02, 0x80, 0x62, 0x8A, 0x01, 0x2A, 0x05, 0xD1, 0x20, 0x20, 0x01, 0x43, 0x03, 0x22, 0x2B, 0x48	; 0230AF18
	.byte 0x02, 0x80, 0x01, 0xE0, 0x29, 0x48, 0x02, 0x80, 0x02, 0x20, 0xFA, 0xF7, 0xB9, 0xFD, 0x28, 0x49	; 0230AF28
	.byte 0x28, 0x48, 0x01, 0x80, 0x38, 0xE0, 0x20, 0x1C, 0xFF, 0xF7, 0xFA, 0xFE, 0x34, 0xE0, 0x1C, 0x48	; 0230AF38
	.byte 0x01, 0x68, 0x1C, 0x48, 0x08, 0x5A, 0x11, 0x28, 0x13, 0xD1, 0xFA, 0xF7, 0xA7, 0xFB, 0x00, 0x22	; 0230AF48
	.byte 0x20, 0x48, 0x02, 0x80, 0x01, 0x21, 0x1D, 0x48, 0x01, 0x80, 0x19, 0x48, 0x02, 0x80, 0x02, 0x20	; 0230AF58
	.byte 0xFA, 0xF7, 0xD4, 0xFD, 0x01, 0x1C, 0x02, 0x20, 0x30, 0x22, 0x91, 0x43, 0xFA, 0xF7, 0x98, 0xFD	; 0230AF68
	.byte 0x15, 0xE0, 0x12, 0x28, 0x11, 0xD1, 0x13, 0x48, 0x0A, 0x18, 0x11, 0x88, 0x20, 0x20, 0x81, 0x43	; 0230AF78
	.byte 0x11, 0x80, 0x15, 0x49, 0x08, 0x88, 0x00, 0x28, 0xFC, 0xD1, 0x06, 0x20, 0x08, 0x49, 0x0A, 0x68	; 0230AF88
	.byte 0x12, 0x49, 0x51, 0x5A, 0xFA, 0xF7, 0x84, 0xFD, 0x01, 0xE0, 0x01, 0x20, 0x05, 0xE0, 0x10, 0x22	; 0230AF98
	.byte 0x03, 0x48, 0x01, 0x68, 0x03, 0x48, 0x0A, 0x52, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230AFA8
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 0230AFB8
	.byte 0x40, 0x80, 0x80, 0x04, 0x16, 0x03, 0x00, 0x00, 0xA4, 0x81, 0x80, 0x04, 0xA2, 0x81, 0x80, 0x04	; 0230AFC8
	.byte 0x23, 0x08, 0x00, 0x00, 0xA0, 0x81, 0x80, 0x04, 0x04, 0x80, 0x80, 0x04, 0xA8, 0x03, 0x00, 0x00	; 0230AFD8
	.byte 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68, 0x03, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x00, 0x20	; 0230AFE8
	.byte 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x0C, 0x1C	; 0230AFF8
	.byte 0x0C, 0x48, 0x01, 0x68, 0x0C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD1, 0x01, 0x20, 0x0D, 0xE0	; 0230B008
	.byte 0x5C, 0x20, 0x60, 0x80, 0xFB, 0xF7, 0xAE, 0xF8, 0x06, 0x48, 0x01, 0x68, 0x07, 0x48, 0x08, 0x18	; 0230B018
	.byte 0x08, 0x34, 0x21, 0x1C, 0xB4, 0x22, 0x00, 0xF0, 0x0B, 0xF8, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC	; 0230B028
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0xF4, 0x04, 0x00, 0x00	; 0230B038
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x4C, 0xCE, 0x7F, 0x03, 0x10, 0xB5, 0x0C, 0x1C	; 0230B048
	.byte 0x09, 0x20, 0x60, 0x80, 0x0B, 0x48, 0xA1, 0x1D, 0x08, 0x22, 0x00, 0xF0, 0x1B, 0xF8, 0x0A, 0x48	; 0230B058
	.byte 0x00, 0x88, 0xE0, 0x81, 0x00, 0x20, 0xFA, 0xF7, 0x51, 0xFD, 0x20, 0x82, 0xFA, 0xF7, 0xE0, 0xFC	; 0230B068
	.byte 0x60, 0x82, 0x06, 0x48, 0x01, 0x68, 0x06, 0x48, 0x08, 0x5A, 0xA0, 0x82, 0x00, 0x20, 0x10, 0xBC	; 0230B078
	.byte 0x08, 0xBC, 0x18, 0x47, 0x98, 0x08, 0x31, 0x02, 0x00, 0x80, 0x80, 0x04, 0xF4, 0xFF, 0x80, 0x03	; 0230B088
	.byte 0xB0, 0x05, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x1C, 0xCE, 0x7F, 0x03	; 0230B098
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x02, 0x68, 0x07, 0x48, 0x10, 0x5A, 0x00, 0x28, 0x01, 0xD1	; 0230B0A8
	.byte 0x01, 0x20, 0x04, 0xE0, 0x01, 0x20, 0x48, 0x80, 0xFB, 0xF7, 0x92, 0xF9, 0x00, 0x20, 0x01, 0xB0	; 0230B0B8
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 0230B0C8
	.byte 0x01, 0x20, 0x48, 0x80, 0x06, 0x48, 0x01, 0x68, 0x06, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD3	; 0230B0D8
	.byte 0xFA, 0xF7, 0x30, 0xFD, 0xF9, 0xF7, 0xB6, 0xFC, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47	; 0230B0E8
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x20, 0x48, 0x80	; 0230B0F8
	.byte 0x0B, 0x48, 0x01, 0x68, 0x0B, 0x48, 0x08, 0x5A, 0x10, 0x28, 0x07, 0xD0, 0x20, 0x28, 0x0A, 0xD1	; 0230B108
	.byte 0x09, 0x48, 0x08, 0x5A, 0x40, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x04, 0xD1, 0x20, 0x20, 0xFB, 0xF7	; 0230B118
	.byte 0xA7, 0xF9, 0x00, 0x20, 0x00, 0xE0, 0x01, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230B128
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00, 0x16, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 0230B138
	.byte 0x01, 0x20, 0x48, 0x80, 0x0C, 0x49, 0x0A, 0x68, 0x0C, 0x49, 0x51, 0x5A, 0x20, 0x29, 0x10, 0xD8	; 0230B148
	.byte 0x0B, 0x49, 0x51, 0x5A, 0x49, 0x07, 0xC9, 0x0F, 0x00, 0x29, 0x0A, 0xD1, 0x00, 0x20, 0x05, 0xF0	; 0230B158
	.byte 0x59, 0xF8, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x03, 0xE0, 0x10, 0x20, 0xFB, 0xF7, 0x80, 0xF9	; 0230B168
	.byte 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x03, 0x00, 0x00	; 0230B178
	.byte 0x16, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x20, 0x48, 0x80, 0x07, 0x49, 0x0A, 0x68	; 0230B188
	.byte 0x07, 0x49, 0x51, 0x5A, 0x00, 0x29, 0x01, 0xD0, 0x10, 0x29, 0x03, 0xD1, 0x00, 0x20, 0xFB, 0xF7	; 0230B198
	.byte 0x67, 0xF9, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230B1A8
	.byte 0x10, 0x03, 0x00, 0x00	; 0230B1AC

; ===== function loc_0230B1AC =====
loc_0230B1AC:
	ldrh r2,[r1,#0xe]	; 0230B1AC
	lsl r2,r2,#0x1	; 0230B1AE
	add r3,r1,r2	; 0230B1B0
	add r3,#0x10	; 0230B1B2
	ldrh r2,[r3,#0x0]	; 0230B1B4
	strh r2,[r1,#0xc]	; 0230B1B6
	mov r2,#0x2	; 0230B1B8
	strh r2,[r3,#0x2]	; 0230B1BA
	mov r2,#0x0	; 0230B1BC
	strh r2,[r3,#0x4]	; 0230B1BE
	ldrh r2,[r1,#0x18]	; 0230B1C0
	strh r2,[r3,#0x6]	; 0230B1C2
	ldr r3,[pool_0230B1C8]	; 0230B1C4
	bx r3	; 0230B1C6
pool_0230B1C8:
loc_0230B1C8:
	.word loc_02309574 + 1	; 0230B1C8

; ===== function loc_0230B1CC =====
	push {r4,lr}	; 0230B1CC
	add r4,r0,#0x0	; 0230B1CE
	mov r2,#0x1	; 0230B1D0
	strh r2,[r1,#0x2]	; 0230B1D2
	ldrh r0,[r4,#0x10]	; 0230B1D4
	and r0,r2	; 0230B1D6
	cmp r0,#0x0	; 0230B1D8
	beq loc_0230B1E0	; 0230B1DA
	bl loc_0230CE94	; 0230B1DC
loc_0230B1E0:
	ldrh r1,[r4,#0x10]	; 0230B1E0
	mov r0,#0x2	; 0230B1E2
	and r1,r0	; 0230B1E4
	cmp r1,#0x0	; 0230B1E6
	beq loc_0230B1EE	; 0230B1E8
	bl loc_0230CE58	; 0230B1EA
loc_0230B1EE:
	ldrh r1,[r4,#0x10]	; 0230B1EE
	mov r0,#0x4	; 0230B1F0
	and r1,r0	; 0230B1F2
	cmp r1,#0x0	; 0230B1F4
	beq loc_0230B1FC	; 0230B1F6
	bl loc_0230CDE0	; 0230B1F8
loc_0230B1FC:
	mov r0,#0x0	; 0230B1FC
	pop {r4}	; 0230B1FE
	pop {r3}	; 0230B200
	bx r3	; 0230B202
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x0C, 0x48, 0xA0, 0x81, 0x20, 0x1C, 0x10, 0x30	; 0230B214
	.byte 0x00, 0x21, 0x41, 0x80, 0xC1, 0x88, 0x41, 0x82, 0xFE, 0xF7, 0x78, 0xF8, 0x08, 0x48, 0x02, 0x68	; 0230B224
	.byte 0x08, 0x48, 0x10, 0x18, 0x08, 0x49, 0x51, 0x18, 0x22, 0x1C, 0xF9, 0xF7, 0xBB, 0xFE, 0x00, 0x20	; 0230B234
	.byte 0x02, 0xF0, 0x1C, 0xFA, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xFF, 0xFF, 0x00, 0x00	; 0230B244
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xC4, 0x01, 0x00, 0x00, 0x58, 0x01, 0x00, 0x00, 0xF0, 0xB5, 0x87, 0xB0	; 0230B254
	.byte 0x05, 0x1C, 0xDC, 0x4B, 0x1A, 0x68, 0xDC, 0x48, 0x17, 0x18, 0x01, 0x20, 0x02, 0x90, 0x48, 0x80	; 0230B264
	.byte 0x19, 0x68, 0xDA, 0x48, 0x08, 0x5A, 0x01, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0xE1, 0xE1, 0xB8, 0x8F	; 0230B274
	.byte 0x00, 0x28, 0x01, 0xD0, 0x08, 0x20, 0xDC, 0xE1, 0x7C, 0x6C, 0x2A, 0x8A, 0xD4, 0x48, 0x11, 0x1C	; 0230B284
	.byte 0x01, 0x40, 0x00, 0x29, 0x24, 0xD0, 0x02, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x03, 0xD1, 0x38, 0x1C	; 0230B294
	.byte 0x94, 0x30, 0x00, 0x88, 0xA8, 0x82, 0x29, 0x8A, 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1	; 0230B2A4
	.byte 0x38, 0x1C, 0xA0, 0x30, 0x00, 0x88, 0xE8, 0x82, 0x29, 0x8A, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29	; 0230B2B4
	.byte 0x03, 0xD1, 0x38, 0x1C, 0x96, 0x30, 0x00, 0x88, 0x28, 0x83, 0x29, 0x8A, 0x10, 0x20, 0x01, 0x40	; 0230B2C4
	.byte 0x00, 0x29, 0x05, 0xD1, 0x38, 0x1C, 0x9C, 0x30, 0x00, 0x88, 0xA8, 0x83, 0x00, 0x20, 0x02, 0x90	; 0230B2D4
	.byte 0xA9, 0x8B, 0xC0, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0xAA, 0xE1, 0x02, 0x20, 0x00, 0x21	; 0230B2E4
	.byte 0x01, 0x91, 0x08, 0xE0, 0xE9, 0x8A, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x01, 0x99, 0x49, 0x1C	; 0230B2F4
	.byte 0x01, 0x91, 0x40, 0x04, 0x00, 0x0C, 0x00, 0x28, 0xF4, 0xD1, 0xA9, 0x8A, 0x38, 0x1C, 0x94, 0x30	; 0230B304
	.byte 0x01, 0x80, 0xA8, 0x8A, 0x06, 0x90, 0xB2, 0x48, 0x06, 0x99, 0x01, 0x40, 0x00, 0x29, 0x11, 0xD0	; 0230B314
	.byte 0x2A, 0x1C, 0x14, 0x32, 0x11, 0x88, 0xB0, 0x48, 0x01, 0x40, 0x11, 0x80, 0xA8, 0x8A, 0xD0, 0x38	; 0230B324
	.byte 0x80, 0x08, 0x06, 0x90, 0xEA, 0x20, 0xE0, 0x81, 0xAC, 0x49, 0x06, 0x98, 0x88, 0x42, 0x22, 0xD9	; 0230B334
	.byte 0x05, 0x20, 0x7E, 0xE1, 0xA3, 0x48, 0x01, 0x68, 0xA9, 0x48, 0x09, 0x5A, 0x02, 0x20, 0x01, 0x40	; 0230B344
	.byte 0x00, 0x29, 0x0D, 0xD0, 0x06, 0x98, 0x40, 0x1C, 0x06, 0x90, 0xA6, 0x49, 0x88, 0x42, 0x01, 0xD9	; 0230B354
	.byte 0x05, 0x20, 0x6E, 0xE1, 0x80, 0x00, 0xD2, 0x30, 0xA8, 0x82, 0xF0, 0x20, 0xE0, 0x81, 0x0A, 0xE0	; 0230B364
	.byte 0xA1, 0x49, 0x06, 0x98, 0x88, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x62, 0xE1, 0x80, 0x00, 0xD0, 0x30	; 0230B374
	.byte 0xA8, 0x82, 0xEA, 0x20, 0xE0, 0x81, 0x06, 0x98, 0x09, 0x30, 0x06, 0x90, 0x01, 0x20, 0x06, 0x99	; 0230B384
	.byte 0x81, 0x43, 0x06, 0x91, 0x03, 0x91, 0x01, 0x98, 0x41, 0x43, 0x03, 0x91, 0x8D, 0x48, 0x01, 0x68	; 0230B394
	.byte 0x96, 0x48, 0x08, 0x18, 0x03, 0x99, 0x1A, 0x31, 0xF9, 0xF7, 0x58, 0xFE, 0x39, 0x1C, 0x90, 0x31	; 0230B3A4
	.byte 0x08, 0x60, 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD1, 0x08, 0x20, 0x40, 0xE1	; 0230B3B4
	.byte 0x01, 0x20, 0xB8, 0x87, 0x39, 0x1C, 0x3E, 0x31, 0x08, 0x88, 0x40, 0x1C, 0x08, 0x80, 0x29, 0x8B	; 0230B3C4
	.byte 0x38, 0x1C, 0x96, 0x30, 0x01, 0x80, 0xE9, 0x8A, 0x38, 0x1C, 0x98, 0x30, 0x01, 0x80, 0x00, 0x20	; 0230B3D4
	.byte 0x39, 0x1C, 0x9A, 0x31, 0x08, 0x80, 0xAA, 0x8B, 0x39, 0x1C, 0x9C, 0x31, 0x0A, 0x80, 0x6A, 0x8A	; 0230B3E4
	.byte 0x39, 0x1C, 0x9E, 0x31, 0x0A, 0x80, 0x20, 0x80, 0xE9, 0x8A, 0x61, 0x80, 0xA0, 0x80, 0x14, 0x20	; 0230B3F4
	.byte 0x20, 0x81, 0xA8, 0x8B, 0x22, 0x30, 0x60, 0x81, 0x7D, 0x48, 0xA0, 0x81, 0x20, 0x1C, 0x0E, 0x30	; 0230B404
	.byte 0x03, 0x88, 0xAA, 0x8A, 0x0A, 0x32, 0x01, 0x99, 0x4A, 0x43, 0x99, 0x18, 0x01, 0x80, 0x6D, 0x48	; 0230B414
	.byte 0x00, 0x68, 0x04, 0x90, 0x20, 0x1C, 0x10, 0x30, 0x76, 0x49, 0x77, 0x4B, 0x04, 0x9A, 0xD2, 0x18	; 0230B424
	.byte 0x76, 0x4E, 0x04, 0x9B, 0x9B, 0x19, 0xFA, 0xF7, 0xF1, 0xFF, 0x29, 0x8A, 0x68, 0x48, 0x01, 0x40	; 0230B434
	.byte 0x00, 0x29, 0x06, 0xD0, 0x61, 0x8C, 0x72, 0x48, 0x81, 0x42, 0x02, 0xD0, 0x71, 0x48, 0x00, 0x90	; 0230B444
	.byte 0x03, 0xE0, 0x00, 0x20, 0x00, 0x90, 0x6E, 0x48, 0x60, 0x84, 0xA8, 0x8A, 0xA0, 0x84, 0xE8, 0x8A	; 0230B454
	.byte 0xE0, 0x84, 0xE8, 0x8B, 0x20, 0x85, 0x02, 0x98, 0x00, 0x28, 0x07, 0xD0, 0xAA, 0x8B, 0x00, 0x2A	; 0230B464
	.byte 0x04, 0xD0, 0x20, 0x1C, 0x2A, 0x30, 0x29, 0x6A, 0xF9, 0xF7, 0xF4, 0xFF, 0x55, 0x48, 0x01, 0x68	; 0230B474
	.byte 0x5B, 0x48, 0x09, 0x5A, 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x21, 0x1C, 0x28, 0x31	; 0230B484
	.byte 0xA8, 0x8B, 0x80, 0x1C, 0x08, 0x18, 0xC1, 0x1C, 0x03, 0x20, 0x81, 0x43, 0x5E, 0x48, 0x08, 0x80	; 0230B494
	.byte 0x5E, 0x48, 0x48, 0x80, 0x5E, 0x49, 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x81, 0x81, 0x03, 0x98	; 0230B4A4
	.byte 0x0B, 0x30, 0x03, 0x90, 0x41, 0x08, 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0xC1, 0x81, 0xE9, 0x8A	; 0230B4B4
	.byte 0x38, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x01, 0x82, 0x38, 0x1C, 0x90, 0x30, 0x01, 0x68, 0x01, 0x98	; 0230B4C4
	.byte 0x88, 0x82, 0x38, 0x1C, 0x90, 0x30, 0x01, 0x68, 0x06, 0x98, 0xC8, 0x82, 0x38, 0x1C, 0x90, 0x30	; 0230B4D4
	.byte 0x01, 0x68, 0x00, 0x20, 0x08, 0x83, 0x38, 0x1C, 0x90, 0x30, 0x02, 0x68, 0x1A, 0x32, 0x01, 0x21	; 0230B4E4
	.byte 0x02, 0x20, 0x0E, 0xE0, 0xEB, 0x8A, 0x03, 0x40, 0x00, 0x2B, 0x07, 0xD0, 0x44, 0x4B, 0x13, 0x80	; 0230B4F4
	.byte 0x00, 0x23, 0x53, 0x80, 0xD3, 0x80, 0x91, 0x80, 0x06, 0x9B, 0xD2, 0x18, 0x40, 0x04, 0x00, 0x0C	; 0230B504
	.byte 0x49, 0x1C, 0x00, 0x28, 0xEE, 0xD1, 0xA9, 0x8A, 0x42, 0x48, 0x01, 0x80, 0xE1, 0x89, 0x42, 0x48	; 0230B514
	.byte 0x01, 0x80, 0x69, 0x8B, 0x31, 0x48, 0x46, 0x1A, 0x28, 0x8B, 0x00, 0x28, 0x1E, 0xD1, 0xA8, 0x8B	; 0230B524
	.byte 0x22, 0x30, 0x82, 0x00, 0x60, 0x32, 0xA9, 0x8A, 0x01, 0x98, 0x41, 0x43, 0x3B, 0x48, 0x08, 0x18	; 0230B534
	.byte 0x10, 0x18, 0x32, 0x30, 0x0A, 0x21, 0x00, 0xF0, 0x81, 0xF8, 0x05, 0x1C, 0x00, 0xF0, 0x84, 0xF8	; 0230B544
	.byte 0x37, 0x49, 0x0D, 0x80, 0x37, 0x49, 0x0C, 0x40, 0x62, 0x08, 0x21, 0x49, 0x0A, 0x43, 0x00, 0x99	; 0230B554
	.byte 0x0A, 0x43, 0x35, 0x49, 0x0A, 0x80, 0x00, 0xF0, 0x7D, 0xF8, 0x69, 0xE0, 0x00, 0xF0, 0x80, 0xF8	; 0230B564
	.byte 0x05, 0x90, 0x32, 0x48, 0x00, 0x88, 0x30, 0x18, 0x25, 0x49, 0x08, 0x40, 0x0A, 0x21, 0x00, 0xF0	; 0230B574
	.byte 0x7D, 0xF8, 0x2A, 0x8B, 0xC1, 0x1C, 0x91, 0x42, 0x10, 0xD2, 0x10, 0x1A, 0x41, 0x1E, 0x28, 0x48	; 0230B584
	.byte 0x01, 0x80, 0x28, 0x48, 0x04, 0x40, 0x61, 0x08, 0x11, 0x48, 0x01, 0x43, 0x00, 0x98, 0x01, 0x43	; 0230B594
	.byte 0x25, 0x48, 0x01, 0x80, 0x05, 0x98, 0x00, 0xF0, 0x6F, 0xF8, 0x49, 0xE0, 0x05, 0x98, 0x00, 0xF0	; 0230B5A4
	.byte 0x71, 0xF8, 0x08, 0x48, 0x01, 0x68, 0x11, 0x48, 0x08, 0x18, 0x39, 0x1C, 0x90, 0x31, 0x09, 0x68	; 0230B5B4
	.byte 0xF9, 0xF7, 0x20, 0xFD, 0x00, 0x20, 0xB8, 0x87, 0x3E, 0x37, 0x38, 0x88, 0x40, 0x1E, 0x38, 0x80	; 0230B5C4
	.byte 0x05, 0x20, 0x36, 0xE0, 0xF4, 0xFF, 0x80, 0x03, 0xE4, 0x03, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00	; 0230B5D4
	.byte 0x00, 0x80, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 0230B5E4
	.byte 0x1C, 0x06, 0x00, 0x00, 0x03, 0x02, 0x00, 0x00, 0x02, 0x02, 0x00, 0x00, 0x4C, 0x01, 0x00, 0x00	; 0230B5F4
	.byte 0x28, 0x02, 0x00, 0x00, 0x90, 0x03, 0x31, 0x02, 0x60, 0x03, 0x00, 0x00, 0xE8, 0x02, 0x00, 0x00	; 0230B604
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0xB8, 0xB6, 0x00, 0x00, 0x46, 0x1D, 0x00, 0x00	; 0230B614
	.byte 0x84, 0x01, 0x00, 0x00, 0xC4, 0x80, 0x80, 0x04, 0xC0, 0x80, 0x80, 0x04, 0x88, 0x03, 0x00, 0x00	; 0230B624
	.byte 0x18, 0x81, 0x80, 0x04, 0xFF, 0x3F, 0x00, 0x00, 0x90, 0x80, 0x80, 0x04, 0xF8, 0x80, 0x80, 0x04	; 0230B634
	.byte 0x00, 0x20, 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x78, 0x47, 0xC0, 0x46	; 0230B644
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x20, 0x27, 0x80, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 0230B654
	.byte 0xF0, 0xCB, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xCC, 0x7F, 0x03	; 0230B664
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0xF0, 0xCB, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46	; 0230B674
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x20, 0x27, 0x80, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 0230B684
	.byte 0x04, 0xCC, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xCC, 0x7F, 0x03	; 0230B694
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x3A, 0x48, 0x04, 0x68, 0x3A, 0x4A, 0xA3, 0x18, 0x3A, 0x4A	; 0230B6A4
	.byte 0xA2, 0x18, 0x01, 0x26, 0x4E, 0x80, 0x00, 0x68, 0x38, 0x49, 0x41, 0x5A, 0x02, 0x29, 0x01, 0xD0	; 0230B6B4
	.byte 0x0B, 0x20, 0x61, 0xE0, 0x2C, 0x8A, 0x36, 0x49, 0x8C, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x5B, 0xE0	; 0230B6C4
	.byte 0x34, 0x49, 0x41, 0x5A, 0x00, 0x29, 0x00, 0xD1, 0x00, 0x26, 0x14, 0x27, 0x7E, 0x43, 0x84, 0x19	; 0230B6D4
	.byte 0x30, 0x48, 0x20, 0x5A, 0x00, 0x28, 0x01, 0xD0, 0x08, 0x20, 0x4D, 0xE0, 0x2E, 0x48, 0x01, 0x88	; 0230B6E4
	.byte 0x2E, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x08, 0x20, 0x45, 0xE0, 0x2C, 0x48, 0x24, 0x58	; 0230B6F4
	.byte 0x00, 0x20, 0x20, 0x80, 0xA0, 0x80, 0x27, 0x81, 0x28, 0x8A, 0x1E, 0x30, 0x60, 0x81, 0x29, 0x48	; 0230B704
	.byte 0xA0, 0x81, 0x20, 0x1C, 0x10, 0x30, 0x58, 0x33, 0x19, 0x1C, 0x08, 0x32, 0x26, 0x4B, 0xFA, 0xF7	; 0230B714
	.byte 0x7D, 0xFE, 0x68, 0x8A, 0xA0, 0x84, 0x2A, 0x8A, 0x00, 0x2A, 0x04, 0xD0, 0x20, 0x1C, 0x26, 0x30	; 0230B724
	.byte 0x69, 0x69, 0xF9, 0xF7, 0x97, 0xFE, 0x16, 0x48, 0x01, 0x68, 0x20, 0x48, 0x09, 0x5A, 0x04, 0x20	; 0230B734
	.byte 0x01, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x21, 0x1C, 0x24, 0x31, 0x28, 0x8A, 0x80, 0x1C, 0x08, 0x18	; 0230B744
	.byte 0xC1, 0x1C, 0x03, 0x20, 0x81, 0x43, 0x1A, 0x48, 0x08, 0x80, 0x1A, 0x48, 0x48, 0x80, 0x01, 0x23	; 0230B754
	.byte 0x0B, 0x4A, 0x10, 0x68, 0x81, 0x19, 0x0F, 0x48, 0x0B, 0x52, 0x10, 0x68, 0x81, 0x19, 0x16, 0x48	; 0230B764
	.byte 0x09, 0x18, 0x08, 0x88, 0x40, 0x1C, 0x08, 0x80, 0x14, 0x48, 0x04, 0x40, 0x61, 0x08, 0x0B, 0x48	; 0230B774
	.byte 0x01, 0x43, 0x09, 0x48, 0x01, 0x80, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230B784
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x08, 0x03, 0x00, 0x00, 0xE0, 0x02, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00	; 0230B794
	.byte 0x00, 0x02, 0x00, 0x00, 0x34, 0x04, 0x00, 0x00, 0x94, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00	; 0230B7A4
	.byte 0x3C, 0x04, 0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x80, 0x03, 0x31, 0x02, 0x1C, 0x06, 0x00, 0x00	; 0230B7B4
	.byte 0xB8, 0xB6, 0x00, 0x00, 0x46, 0x1D, 0x00, 0x00, 0x36, 0x04, 0x00, 0x00, 0xFF, 0x3F, 0x00, 0x00	; 0230B7C4
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x06, 0x1C, 0x75, 0x48, 0x00, 0x68, 0x75, 0x49, 0x45, 0x18, 0x34, 0x1C	; 0230B7D4
	.byte 0x10, 0x34, 0xF2, 0x8A, 0x73, 0x49, 0x8A, 0x42, 0x01, 0xD9, 0x05, 0x20, 0xDA, 0xE0, 0x72, 0x49	; 0230B7E4
	.byte 0x41, 0x5A, 0x01, 0x29, 0x04, 0xD0, 0x02, 0x29, 0x7C, 0xD0, 0x03, 0x29, 0x7A, 0xD0, 0xD0, 0xE0	; 0230B7F4
	.byte 0x6E, 0x49, 0x40, 0x58, 0xA0, 0x80, 0x20, 0x1C, 0x18, 0x30, 0xFD, 0xF7, 0x4D, 0xFE, 0x07, 0x1C	; 0230B804
	.byte 0xFF, 0x2F, 0x09, 0xD0, 0x1C, 0x20, 0x3A, 0x1C, 0x42, 0x43, 0x64, 0x48, 0x01, 0x68, 0x68, 0x48	; 0230B814
	.byte 0x08, 0x58, 0x80, 0x5A, 0x40, 0x28, 0x01, 0xD0, 0x0A, 0x20, 0xBB, 0xE0, 0x67, 0x80, 0xE1, 0x89	; 0230B824
	.byte 0xFF, 0x20, 0x0B, 0x1C, 0x03, 0x40, 0x18, 0x04, 0x00, 0x0C, 0x00, 0x28, 0x07, 0xD1, 0x5B, 0x48	; 0230B834
	.byte 0x01, 0x68, 0x5F, 0x48, 0x08, 0x58, 0x80, 0x18, 0x40, 0x8A, 0x20, 0x82, 0x02, 0xE0, 0x21, 0x82	; 0230B844
	.byte 0x00, 0x20, 0xE0, 0x81, 0xE0, 0x88, 0x00, 0x28, 0x0A, 0xD1, 0x28, 0x1C, 0x7E, 0x30, 0x01, 0x88	; 0230B854
	.byte 0x40, 0x20, 0x01, 0x43, 0x57, 0x48, 0x01, 0x40, 0xA1, 0x82, 0x1C, 0x20, 0x60, 0x82, 0x10, 0xE0	; 0230B864
	.byte 0x28, 0x1C, 0x7E, 0x30, 0x00, 0x88, 0xA0, 0x82, 0x4C, 0x48, 0x01, 0x68, 0x52, 0x48, 0x08, 0x5A	; 0230B874
	.byte 0x00, 0x28, 0x03, 0xD1, 0xE0, 0x88, 0x1C, 0x30, 0x60, 0x82, 0x02, 0xE0, 0xE0, 0x88, 0x24, 0x30	; 0230B884
	.byte 0x60, 0x82, 0x20, 0x1C, 0x24, 0x30, 0x21, 0x1C, 0x1E, 0x31, 0xFA, 0xF7, 0xE3, 0xFD, 0x20, 0x1C	; 0230B894
	.byte 0x1E, 0x30, 0x58, 0x35, 0x29, 0x1C, 0xFA, 0xF7, 0xDD, 0xFD, 0x00, 0x2F, 0x12, 0xD1, 0x3F, 0x48	; 0230B8A4
	.byte 0x01, 0x68, 0x46, 0x48, 0x08, 0x18, 0x31, 0x1C, 0xFD, 0xF7, 0x60, 0xFD, 0x3B, 0x48, 0x02, 0x68	; 0230B8B4
	.byte 0x43, 0x48, 0x11, 0x5A, 0x43, 0x48, 0x10, 0x5A, 0x81, 0x43, 0x00, 0x29, 0x69, 0xD1, 0x01, 0xF0	; 0230B8C4
	.byte 0x7F, 0xFE, 0x66, 0xE0, 0x20, 0x1C, 0xFD, 0xF7, 0x21, 0xFD, 0x34, 0x48, 0x02, 0x68, 0x3B, 0x48	; 0230B8D4
	.byte 0x10, 0x18, 0x3D, 0x49, 0x51, 0x18, 0x32, 0x1C, 0xF9, 0xF7, 0x64, 0xFB, 0x00, 0x20, 0x01, 0xF0	; 0230B8E4
	.byte 0xC5, 0xFE, 0x56, 0xE0, 0x31, 0x49, 0x40, 0x58, 0xA0, 0x80, 0x28, 0x1C, 0x7C, 0x30, 0x00, 0x88	; 0230B8F4
	.byte 0x60, 0x80, 0xE0, 0x89, 0xFF, 0x21, 0x02, 0x1C, 0x0A, 0x40, 0x11, 0x04, 0x09, 0x0C, 0x00, 0x29	; 0230B904
	.byte 0x0C, 0xD1, 0x26, 0x48, 0x01, 0x68, 0x2A, 0x48, 0x0A, 0x58, 0x28, 0x1C, 0x7C, 0x30, 0x01, 0x88	; 0230B914
	.byte 0x1C, 0x20, 0x41, 0x43, 0x50, 0x18, 0x40, 0x8A, 0x20, 0x82, 0x00, 0xE0, 0x20, 0x82, 0xE0, 0x88	; 0230B924
	.byte 0x00, 0x28, 0x0A, 0xD1, 0x28, 0x1C, 0x7E, 0x30, 0x01, 0x88, 0x40, 0x20, 0x01, 0x43, 0x21, 0x48	; 0230B934
	.byte 0x01, 0x40, 0xA1, 0x82, 0x1C, 0x20, 0x60, 0x82, 0x10, 0xE0, 0x28, 0x1C, 0x7E, 0x30, 0x00, 0x88	; 0230B944
	.byte 0xA0, 0x82, 0x16, 0x48, 0x01, 0x68, 0x1C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x03, 0xD1, 0xE0, 0x88	; 0230B954
	.byte 0x1C, 0x30, 0x60, 0x82, 0x02, 0xE0, 0xE0, 0x88, 0x24, 0x30, 0x60, 0x82, 0x20, 0x1C, 0x24, 0x30	; 0230B964
	.byte 0x21, 0x1C, 0x18, 0x31, 0xFA, 0xF7, 0x76, 0xFD, 0x20, 0x1C, 0x18, 0x30, 0x58, 0x35, 0x29, 0x1C	; 0230B974
	.byte 0xFA, 0xF7, 0x70, 0xFD, 0x20, 0x1C, 0xFD, 0xF7, 0xC9, 0xFC, 0x08, 0x48, 0x02, 0x68, 0x0F, 0x48	; 0230B984
	.byte 0x10, 0x18, 0x11, 0x49, 0x51, 0x18, 0x32, 0x1C, 0xF9, 0xF7, 0x0C, 0xFB, 0x00, 0x20, 0x01, 0xF0	; 0230B994
	.byte 0x6D, 0xFE, 0x81, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 0230B9A4
	.byte 0x08, 0x03, 0x00, 0x00, 0xE4, 0x05, 0x00, 0x00, 0xF2, 0x02, 0x00, 0x00, 0xA4, 0x03, 0x00, 0x00	; 0230B9B4
	.byte 0xE0, 0x02, 0x00, 0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xF8, 0x02, 0x00, 0x00, 0xC4, 0x01, 0x00, 0x00	; 0230B9C4
	.byte 0xEA, 0x04, 0x00, 0x00, 0xEE, 0x04, 0x00, 0x00, 0x58, 0x01, 0x00, 0x00	; 0230B9D0

; ===== function loc_0230B9D0 =====
loc_0230B9D0:
	push {lr}	; 0230B9D0
	sub sp,#0x14	; 0230B9D2
	mov r0,#0x0	; 0230B9D4
	str r0,[sp,#0x0]	; 0230B9D6
	ldr r0,[sp,#0x0]	; 0230B9D8
	ldr r1,[pool_0230BCB4]	; 0230B9DA
	ldr r2,[r1,#0x0]	; 0230B9DC
	ldr r1,[pool_0230BCB8]	; 0230B9DE
	add r1,r2,r1	; 0230B9E0
	mov r2,#0xb4	; 0230B9E2
	bl loc_0230BDE0	; 0230B9E4
	mov r1,#0x0	; 0230B9E8
	ldr r0,[pool_0230BCB4]	; 0230B9EA
	ldr r3,[r0,#0x0]	; 0230B9EC
	ldr r2,[pool_0230BCB8]	; 0230B9EE
	strh r1,[r3,r2]	; 0230B9F0
	ldr r3,[r0,#0x0]	; 0230B9F2
	ldr r2,[pool_0230BCBC]	; 0230B9F4
	str r1,[r3,r2]	; 0230B9F6
	ldr r3,[r0,#0x0]	; 0230B9F8
	ldr r2,[pool_0230BCC0]	; 0230B9FA
	strh r1,[r3,r2]	; 0230B9FC
	ldr r3,[r0,#0x0]	; 0230B9FE
	ldr r2,[pool_0230BCC4]	; 0230BA00
	str r1,[r3,r2]	; 0230BA02
	ldr r3,[r0,#0x0]	; 0230BA04
	ldr r2,[pool_0230BCC8]	; 0230BA06
	strh r1,[r3,r2]	; 0230BA08
	ldr r3,[r0,#0x0]	; 0230BA0A
	ldr r2,[pool_0230BCCC]	; 0230BA0C
	str r1,[r3,r2]	; 0230BA0E
	ldr r3,[pool_0230BCD0]	; 0230BA10
	ldr r2,[r0,#0x0]	; 0230BA12
	ldr r1,[pool_0230BCD4]	; 0230BA14
	strh r3,[r2,r1]	; 0230BA16
	ldr r2,[r0,#0x0]	; 0230BA18
	ldr r1,[pool_0230BCD8]	; 0230BA1A
	strh r3,[r2,r1]	; 0230BA1C
	ldr r1,[r0,#0x0]	; 0230BA1E
	ldr r2,[pool_0230BCDC]	; 0230BA20
	ldrh r2,[r1,r2]	; 0230BA22
	cmp r2,#0x3	; 0230BA24
	bls loc_0230BA2A	; 0230BA26
	b loc_0230BCAC	; 0230BA28
loc_0230BA2A:
	add r2,r2,r2	; 0230BA2A
P4_SwitchIndexPC_0230BA2A:
	add r2,pc	; 0230BA2C
	ldrh r2,[r2,#(P4_SwitchTable_0230BA2A - (P4_SwitchIndexPC_0230BA2A + 4))]	; 0230BA2E
	lsl r2,r2,#0x10	; 0230BA30
	asr r2,r2,#0x10	; 0230BA32
P4_SwitchTargetPC_0230BA2A:
	add r2,pc	; 0230BA34
	bx r2	; 0230BA36
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230BA2A:
	.halfword (loc_0230BA40 + 1) - (P4_SwitchTargetPC_0230BA2A + 4)
	.halfword (loc_0230BA92 + 1) - (P4_SwitchTargetPC_0230BA2A + 4)
	.halfword (loc_0230BB56 + 1) - (P4_SwitchTargetPC_0230BA2A + 4)
	.halfword (loc_0230BC12 + 1) - (P4_SwitchTargetPC_0230BA2A + 4)
P4_SwitchTable_0230BA2AEnd:
loc_0230BA40:
	ldr r3,[pool_0230BCE0]	; 0230BA40
	ldr r2,[pool_0230BCE4]	; 0230BA42
	str r3,[r1,r2]	; 0230BA44
	ldr r3,[pool_0230BCE8]	; 0230BA46
	ldr r2,[r0,#0x0]	; 0230BA48
	ldr r1,[pool_0230BCEC]	; 0230BA4A
	str r3,[r2,r1]	; 0230BA4C
	ldr r3,[pool_0230BCF0]	; 0230BA4E
	ldr r2,[r0,#0x0]	; 0230BA50
	ldr r1,[pool_0230BCF4]	; 0230BA52
	str r3,[r2,r1]	; 0230BA54
	ldr r3,[pool_0230BCF8]	; 0230BA56
	ldr r2,[r0,#0x0]	; 0230BA58
	ldr r1,[pool_0230BCFC]	; 0230BA5A
	str r3,[r2,r1]	; 0230BA5C
	ldr r3,[pool_0230BD00]	; 0230BA5E
	ldr r2,[r0,#0x0]	; 0230BA60
	ldr r1,[pool_0230BD04]	; 0230BA62
	str r3,[r2,r1]	; 0230BA64
	ldr r2,[pool_0230BD08]	; 0230BA66
	ldr r1,[r0,#0x0]	; 0230BA68
	ldr r0,[pool_0230BD0C]	; 0230BA6A
	str r2,[r1,r0]	; 0230BA6C
	ldr r2,[pool_0230BD10]	; 0230BA6E
	ldr r0,[pool_0230BD14]	; 0230BA70
	strh r2,[r0,#0x0]	; 0230BA72
	ldr r1,[pool_0230BD18]	; 0230BA74
	ldr r0,[pool_0230BD1C]	; 0230BA76
	strh r1,[r0,#0x0]	; 0230BA78
	ldr r0,[pool_0230BD20]	; 0230BA7A
	strh r2,[r0,#0x0]	; 0230BA7C
	ldr r0,[pool_0230BD24]	; 0230BA7E
	strh r1,[r0,#0x0]	; 0230BA80
	ldr r0,[pool_0230BD28]	; 0230BA82
	strh r2,[r0,#0x0]	; 0230BA84
	ldr r0,[pool_0230BD2C]	; 0230BA86
	strh r1,[r0,#0x0]	; 0230BA88
	mov r1,#0x1	; 0230BA8A
	ldr r0,[pool_0230BD30]	; 0230BA8C
	strh r1,[r0,#0x0]	; 0230BA8E
	b loc_0230BCAC	; 0230BA90
loc_0230BA92:
	ldr r3,[pool_0230BD34]	; 0230BA92
	ldr r2,[pool_0230BCE4]	; 0230BA94
	str r3,[r1,r2]	; 0230BA96
	ldr r3,[pool_0230BD38]	; 0230BA98
	ldr r2,[r0,#0x0]	; 0230BA9A
	ldr r1,[pool_0230BCEC]	; 0230BA9C
	str r3,[r2,r1]	; 0230BA9E
	ldr r3,[pool_0230BD3C]	; 0230BAA0
	ldr r2,[r0,#0x0]	; 0230BAA2
	ldr r1,[pool_0230BCF4]	; 0230BAA4
	str r3,[r2,r1]	; 0230BAA6
	ldr r3,[pool_0230BCF8]	; 0230BAA8
	ldr r2,[r0,#0x0]	; 0230BAAA
	ldr r1,[pool_0230BCFC]	; 0230BAAC
	str r3,[r2,r1]	; 0230BAAE
	ldr r3,[pool_0230BD00]	; 0230BAB0
	ldr r2,[r0,#0x0]	; 0230BAB2
	ldr r1,[pool_0230BD04]	; 0230BAB4
	str r3,[r2,r1]	; 0230BAB6
	ldr r3,[pool_0230BD40]	; 0230BAB8
	ldr r2,[r0,#0x0]	; 0230BABA
	ldr r1,[pool_0230BD0C]	; 0230BABC
	str r3,[r2,r1]	; 0230BABE
	ldr r3,[pool_0230BD44]	; 0230BAC0
	ldr r2,[r0,#0x0]	; 0230BAC2
	ldr r1,[pool_0230BD48]	; 0230BAC4
	str r3,[r2,r1]	; 0230BAC6
	ldr r3,[pool_0230BCF0]	; 0230BAC8
	ldr r2,[r0,#0x0]	; 0230BACA
	ldr r1,[pool_0230BD4C]	; 0230BACC
	str r3,[r2,r1]	; 0230BACE
	ldr r2,[pool_0230BD10]	; 0230BAD0
	ldr r1,[pool_0230BD50]	; 0230BAD2
	strh r2,[r1,#0x0]	; 0230BAD4
	ldr r1,[pool_0230BD18]	; 0230BAD6
	ldr r3,[pool_0230BD54]	; 0230BAD8
	strh r1,[r3,#0x0]	; 0230BADA
	ldr r3,[pool_0230BD58]	; 0230BADC
	strh r2,[r3,#0x0]	; 0230BADE
	ldr r3,[pool_0230BD5C]	; 0230BAE0
	strh r1,[r3,#0x0]	; 0230BAE2
	ldr r3,[pool_0230BD60]	; 0230BAE4
	strh r2,[r3,#0x0]	; 0230BAE6
	ldr r3,[pool_0230BD64]	; 0230BAE8
	strh r1,[r3,#0x0]	; 0230BAEA
	ldr r3,[pool_0230BD68]	; 0230BAEC
	strh r2,[r3,#0x0]	; 0230BAEE
	ldr r3,[pool_0230BD6C]	; 0230BAF0
	strh r1,[r3,#0x0]	; 0230BAF2
	ldr r3,[pool_0230BD70]	; 0230BAF4
	strh r2,[r3,#0x0]	; 0230BAF6
	ldr r2,[pool_0230BD74]	; 0230BAF8
	strh r1,[r2,#0x0]	; 0230BAFA
	ldr r2,[r0,#0x0]	; 0230BAFC
	ldr r0,[pool_0230BD78]	; 0230BAFE
	ldrh r0,[r2,r0]	; 0230BB00
	cmp r0,#0x0	; 0230BB02
	bne loc_0230BB0E	; 0230BB04
	ldr r1,[pool_0230BD7C]	; 0230BB06
	ldr r0,[pool_0230BD80]	; 0230BB08
	strh r1,[r2,r0]	; 0230BB0A
	b loc_0230BB14	; 0230BB0C
loc_0230BB0E:
	ldr r1,[pool_0230BD84]	; 0230BB0E
	ldr r0,[pool_0230BD80]	; 0230BB10
	strh r1,[r2,r0]	; 0230BB12
loc_0230BB14:
	mov r0,#0x0	; 0230BB14
	str r0,[sp,#0x4]	; 0230BB16
	ldr r0,[sp,#0x4]	; 0230BB18
	ldr r1,[pool_0230BCB4]	; 0230BB1A
	ldr r2,[r1,#0x0]	; 0230BB1C
	ldr r1,[pool_0230BD88]	; 0230BB1E
	add r1,r2,r1	; 0230BB20
	mov r2,#0x2c	; 0230BB22
	bl loc_0230BDEC	; 0230BB24
	bl loc_02306028	; 0230BB28
	ldr r3,[pool_0230BCB4]	; 0230BB2C
	ldr r2,[r3,#0x0]	; 0230BB2E
	ldr r1,[pool_0230BD8C]	; 0230BB30
	strh r0,[r2,r1]	; 0230BB32
	ldr r3,[r3,#0x0]	; 0230BB34
	ldr r0,[pool_0230BD90]	; 0230BB36
	add r0,r3,r0	; 0230BB38
	ldr r1,[pool_0230BD94]	; 0230BB3A
	add r1,r3,r1	; 0230BB3C
	ldr r2,[pool_0230BD98]	; 0230BB3E
	add r2,r3,r2	; 0230BB40
	bl loc_0230643C	; 0230BB42
	ldr r2,[pool_0230BD44]	; 0230BB46
	ldr r0,[pool_0230BCB4]	; 0230BB48
	ldr r1,[r0,#0x0]	; 0230BB4A
	ldr r0,[pool_0230BD48]	; 0230BB4C
	str r2,[r1,r0]	; 0230BB4E
	bl loc_0230C71C	; 0230BB50
	b loc_0230BCAC	; 0230BB54
loc_0230BB56:
	ldr r3,[pool_0230BD9C]	; 0230BB56
	ldr r2,[pool_0230BCE4]	; 0230BB58
	str r3,[r1,r2]	; 0230BB5A
	ldr r3,[pool_0230BDA0]	; 0230BB5C
	ldr r2,[r0,#0x0]	; 0230BB5E
	ldr r1,[pool_0230BCEC]	; 0230BB60
	str r3,[r2,r1]	; 0230BB62
	ldr r3,[pool_0230BDA4]	; 0230BB64
	ldr r2,[r0,#0x0]	; 0230BB66
	ldr r1,[pool_0230BCF4]	; 0230BB68
	str r3,[r2,r1]	; 0230BB6A
	ldr r3,[pool_0230BCF8]	; 0230BB6C
	ldr r2,[r0,#0x0]	; 0230BB6E
	ldr r1,[pool_0230BCFC]	; 0230BB70
	str r3,[r2,r1]	; 0230BB72
	ldr r3,[pool_0230BD00]	; 0230BB74
	ldr r2,[r0,#0x0]	; 0230BB76
	ldr r1,[pool_0230BD04]	; 0230BB78
	str r3,[r2,r1]	; 0230BB7A
	ldr r3,[pool_0230BD08]	; 0230BB7C
	ldr r2,[r0,#0x0]	; 0230BB7E
	ldr r1,[pool_0230BD0C]	; 0230BB80
	str r3,[r2,r1]	; 0230BB82
	ldr r3,[pool_0230BCF0]	; 0230BB84
	ldr r2,[r0,#0x0]	; 0230BB86
	ldr r1,[pool_0230BDA8]	; 0230BB88
	str r3,[r2,r1]	; 0230BB8A
	ldr r3,[pool_0230BD50]	; 0230BB8C
	ldr r2,[r0,#0x0]	; 0230BB8E
	ldr r1,[pool_0230BDAC]	; 0230BB90
	str r3,[r2,r1]	; 0230BB92
	ldr r2,[pool_0230BD10]	; 0230BB94
	ldr r1,[pool_0230BDB0]	; 0230BB96
	strh r2,[r1,#0x0]	; 0230BB98
	ldr r1,[pool_0230BD18]	; 0230BB9A
	ldr r3,[pool_0230BDB4]	; 0230BB9C
	strh r1,[r3,#0x0]	; 0230BB9E
	ldr r3,[pool_0230BDB8]	; 0230BBA0
	strh r2,[r3,#0x0]	; 0230BBA2
	ldr r3,[pool_0230BDBC]	; 0230BBA4
	strh r1,[r3,#0x0]	; 0230BBA6
	ldr r3,[pool_0230BDC0]	; 0230BBA8
	strh r2,[r3,#0x0]	; 0230BBAA
	ldr r3,[pool_0230BDC4]	; 0230BBAC
	strh r1,[r3,#0x0]	; 0230BBAE
	ldr r3,[pool_0230BDC8]	; 0230BBB0
	strh r2,[r3,#0x0]	; 0230BBB2
	ldr r3,[pool_0230BDCC]	; 0230BBB4
	strh r1,[r3,#0x0]	; 0230BBB6
	ldr r3,[pool_0230BDD0]	; 0230BBB8
	strh r2,[r3,#0x0]	; 0230BBBA
	ldr r2,[pool_0230BDD4]	; 0230BBBC
	strh r1,[r2,#0x0]	; 0230BBBE
	ldr r2,[r0,#0x0]	; 0230BBC0
	ldr r0,[pool_0230BD78]	; 0230BBC2
	ldrh r0,[r2,r0]	; 0230BBC4
	cmp r0,#0x0	; 0230BBC6
	bne loc_0230BBD2	; 0230BBC8
	ldr r1,[pool_0230BDD8]	; 0230BBCA
	ldr r0,[pool_0230BD80]	; 0230BBCC
	strh r1,[r2,r0]	; 0230BBCE
	b loc_0230BBD8	; 0230BBD0
loc_0230BBD2:
	ldr r1,[pool_0230BDDC]	; 0230BBD2
	ldr r0,[pool_0230BD80]	; 0230BBD4
	strh r1,[r2,r0]	; 0230BBD6
loc_0230BBD8:
	mov r0,#0x0	; 0230BBD8
	str r0,[sp,#0x8]	; 0230BBDA
	ldr r0,[sp,#0x8]	; 0230BBDC
	ldr r1,[pool_0230BCB4]	; 0230BBDE
	ldr r2,[r1,#0x0]	; 0230BBE0
	ldr r1,[pool_0230BD88]	; 0230BBE2
	add r1,r2,r1	; 0230BBE4
	mov r2,#0x2c	; 0230BBE6
	bl loc_0230BDF8	; 0230BBE8
	bl loc_02306028	; 0230BBEC
	ldr r3,[pool_0230BCB4]	; 0230BBF0
	ldr r2,[r3,#0x0]	; 0230BBF2
	ldr r1,[pool_0230BD8C]	; 0230BBF4
	strh r0,[r2,r1]	; 0230BBF6
	ldr r3,[r3,#0x0]	; 0230BBF8
	ldr r0,[pool_0230BD90]	; 0230BBFA
	add r0,r3,r0	; 0230BBFC
	ldr r1,[pool_0230BD94]	; 0230BBFE
	add r1,r3,r1	; 0230BC00
	ldr r2,[pool_0230BD98]	; 0230BC02
	add r2,r3,r2	; 0230BC04
	bl loc_0230643C	; 0230BC06
	mov r1,#0xd	; 0230BC0A
	ldr r0,[pool_0230BD30]	; 0230BC0C
	strh r1,[r0,#0x0]	; 0230BC0E
	b loc_0230BCAC	; 0230BC10
loc_0230BC12:
	ldr r3,[pool_0230BCE0]	; 0230BC12
	ldr r2,[pool_0230BCE4]	; 0230BC14
	str r3,[r1,r2]	; 0230BC16
	ldr r3,[pool_0230BCE8]	; 0230BC18
	ldr r2,[r0,#0x0]	; 0230BC1A
	ldr r1,[pool_0230BCEC]	; 0230BC1C
	str r3,[r2,r1]	; 0230BC1E
	ldr r3,[pool_0230BCF0]	; 0230BC20
	ldr r2,[r0,#0x0]	; 0230BC22
	ldr r1,[pool_0230BCF4]	; 0230BC24
	str r3,[r2,r1]	; 0230BC26
	ldr r3,[pool_0230BCF8]	; 0230BC28
	ldr r2,[r0,#0x0]	; 0230BC2A
	ldr r1,[pool_0230BCFC]	; 0230BC2C
	str r3,[r2,r1]	; 0230BC2E
	ldr r3,[pool_0230BD00]	; 0230BC30
	ldr r2,[r0,#0x0]	; 0230BC32
	ldr r1,[pool_0230BD04]	; 0230BC34
	str r3,[r2,r1]	; 0230BC36
	ldr r3,[pool_0230BD08]	; 0230BC38
	ldr r2,[r0,#0x0]	; 0230BC3A
	ldr r1,[pool_0230BD0C]	; 0230BC3C
	str r3,[r2,r1]	; 0230BC3E
	ldr r2,[pool_0230BD10]	; 0230BC40
	ldr r1,[pool_0230BD14]	; 0230BC42
	strh r2,[r1,#0x0]	; 0230BC44
	ldr r1,[pool_0230BD18]	; 0230BC46
	ldr r3,[pool_0230BD1C]	; 0230BC48
	strh r1,[r3,#0x0]	; 0230BC4A
	ldr r3,[pool_0230BD20]	; 0230BC4C
	strh r2,[r3,#0x0]	; 0230BC4E
	ldr r3,[pool_0230BD24]	; 0230BC50
	strh r1,[r3,#0x0]	; 0230BC52
	ldr r3,[pool_0230BD28]	; 0230BC54
	strh r2,[r3,#0x0]	; 0230BC56
	ldr r2,[pool_0230BD2C]	; 0230BC58
	strh r1,[r2,#0x0]	; 0230BC5A
	ldr r2,[r0,#0x0]	; 0230BC5C
	ldr r0,[pool_0230BD78]	; 0230BC5E
	ldrh r0,[r2,r0]	; 0230BC60
	cmp r0,#0x0	; 0230BC62
	bne loc_0230BC6E	; 0230BC64
	ldr r1,[pool_0230BDD8]	; 0230BC66
	ldr r0,[pool_0230BD80]	; 0230BC68
	strh r1,[r2,r0]	; 0230BC6A
	b loc_0230BC74	; 0230BC6C
loc_0230BC6E:
	ldr r1,[pool_0230BDDC]	; 0230BC6E
	ldr r0,[pool_0230BD80]	; 0230BC70
	strh r1,[r2,r0]	; 0230BC72
loc_0230BC74:
	mov r0,#0x0	; 0230BC74
	str r0,[sp,#0xc]	; 0230BC76
	ldr r0,[sp,#0xc]	; 0230BC78
	ldr r1,[pool_0230BCB4]	; 0230BC7A
	ldr r2,[r1,#0x0]	; 0230BC7C
	ldr r1,[pool_0230BD88]	; 0230BC7E
	add r1,r2,r1	; 0230BC80
	mov r2,#0x2c	; 0230BC82
	bl loc_0230BE04	; 0230BC84
	bl loc_02306028	; 0230BC88
	ldr r3,[pool_0230BCB4]	; 0230BC8C
	ldr r2,[r3,#0x0]	; 0230BC8E
	ldr r1,[pool_0230BD8C]	; 0230BC90
	strh r0,[r2,r1]	; 0230BC92
	ldr r3,[r3,#0x0]	; 0230BC94
	ldr r0,[pool_0230BD90]	; 0230BC96
	add r0,r3,r0	; 0230BC98
	ldr r1,[pool_0230BD94]	; 0230BC9A
	add r1,r3,r1	; 0230BC9C
	ldr r2,[pool_0230BD98]	; 0230BC9E
	add r2,r3,r2	; 0230BCA0
	bl loc_0230643C	; 0230BCA2
	mov r1,#0xd	; 0230BCA6
	ldr r0,[pool_0230BD30]	; 0230BCA8
	strh r1,[r0,#0x0]	; 0230BCAA
loc_0230BCAC:
	add sp,#0x14	; 0230BCAC
	pop {r3}	; 0230BCAE
	bx r3	; 0230BCB0
	.byte 0xC0, 0x46	; 0230BCB4
pool_0230BCB4:
loc_0230BCB4:
	.word FirmwareWlWorkPointerSlot	; 0230BCB4
pool_0230BCB8:
loc_0230BCB8:
	.word 0x000003E4	; 0230BCB8
pool_0230BCBC:
loc_0230BCBC:
	.word 0x000003F0	; 0230BCBC
pool_0230BCC0:
loc_0230BCC0:
	.word 0x000003F8	; 0230BCC0
pool_0230BCC4:
loc_0230BCC4:
	.word 0x00000404	; 0230BCC4
pool_0230BCC8:
loc_0230BCC8:
	.word 0x0000040C	; 0230BCC8
pool_0230BCCC:
loc_0230BCCC:
	.word 0x00000418	; 0230BCCC
pool_0230BCD0:
loc_0230BCD0:
	.word 0x0000FFFF	; 0230BCD0
pool_0230BCD4:
loc_0230BCD4:
	.word 0x00000488	; 0230BCD4
pool_0230BCD8:
loc_0230BCD8:
	.word 0x0000048A	; 0230BCD8
pool_0230BCDC:
loc_0230BCDC:
	.word 0x00000314	; 0230BCDC
pool_0230BCE0:
loc_0230BCE0:
	.word 0x04804170	; 0230BCE0
pool_0230BCE4:
loc_0230BCE4:
	.word 0x000003EC	; 0230BCE4
pool_0230BCE8:
loc_0230BCE8:
	.word 0x04804028	; 0230BCE8
pool_0230BCEC:
loc_0230BCEC:
	.word 0x00000400	; 0230BCEC
pool_0230BCF0:
loc_0230BCF0:
	.word WifiRamBase	; 0230BCF0
pool_0230BCF4:
loc_0230BCF4:
	.word 0x00000414	; 0230BCF4
pool_0230BCF8:
loc_0230BCF8:
	.word P4_Code_0230D354 + 1	; 0230BCF8
pool_0230BCFC:
loc_0230BCFC:
	.word 0x000003F4	; 0230BCFC
pool_0230BD00:
loc_0230BD00:
	.word P4_Code_0230D034 + 1	; 0230BD00
pool_0230BD04:
loc_0230BD04:
	.word 0x00000408	; 0230BD04
pool_0230BD08:
loc_0230BD08:
	.word P4_Code_0230CFD4 + 1	; 0230BD08
pool_0230BD0C:
loc_0230BD0C:
	.word 0x0000041C	; 0230BD0C
pool_0230BD10:
loc_0230BD10:
	.word 0x0000B6B8	; 0230BD10
pool_0230BD14:
loc_0230BD14:
	.word WifiRamBase + 0x24	; 0230BD14
pool_0230BD18:
loc_0230BD18:
	.word 0x00001D46	; 0230BD18
pool_0230BD1C:
loc_0230BD1C:
	.word WifiRamBase + 0x26	; 0230BD1C
pool_0230BD20:
loc_0230BD20:
	.word WifiRamBase + 0x16C	; 0230BD20
pool_0230BD24:
loc_0230BD24:
	.word WifiRamBase + 0x16E	; 0230BD24
pool_0230BD28:
loc_0230BD28:
	.word WifiRamBase + 0x790	; 0230BD28
pool_0230BD2C:
loc_0230BD2C:
	.word WifiRamBase + 0x792	; 0230BD2C
pool_0230BD30:
loc_0230BD30:
	.word REG_WIFI_TXREQ_SET	; 0230BD30
pool_0230BD34:
loc_0230BD34:
	.word 0x04804A9C	; 0230BD34
pool_0230BD38:
loc_0230BD38:
	.word 0x04804954	; 0230BD38
pool_0230BD3C:
loc_0230BD3C:
	.word 0x04804330	; 0230BD3C
pool_0230BD40:
loc_0230BD40:
	.word P4_Code_0230CF18 + 1	; 0230BD40
pool_0230BD44:
loc_0230BD44:
	.word 0x04804234	; 0230BD44
pool_0230BD48:
loc_0230BD48:
	.word 0x00000464	; 0230BD48
pool_0230BD4C:
loc_0230BD4C:
	.word 0x00000428	; 0230BD4C
pool_0230BD50:
loc_0230BD50:
	.word WifiRamBase + 0x230	; 0230BD50
pool_0230BD54:
loc_0230BD54:
	.word WifiRamBase + 0x232	; 0230BD54
pool_0230BD58:
loc_0230BD58:
	.word WifiRamBase + 0x32C	; 0230BD58
pool_0230BD5C:
loc_0230BD5C:
	.word WifiRamBase + 0x32E	; 0230BD5C
pool_0230BD60:
loc_0230BD60:
	.word WifiRamBase + 0x950	; 0230BD60
pool_0230BD64:
loc_0230BD64:
	.word WifiRamBase + 0x952	; 0230BD64
pool_0230BD68:
loc_0230BD68:
	.word WifiRamBase + 0xA98	; 0230BD68
pool_0230BD6C:
loc_0230BD6C:
	.word WifiRamBase + 0xA9A	; 0230BD6C
pool_0230BD70:
loc_0230BD70:
	.word WifiRamBase + 0x10BC	; 0230BD70
pool_0230BD74:
loc_0230BD74:
	.word WifiRamBase + 0x10BE	; 0230BD74
pool_0230BD78:
loc_0230BD78:
	.word 0x000002F8	; 0230BD78
pool_0230BD7C:
loc_0230BD7C:
	.word 0x00000208	; 0230BD7C
pool_0230BD80:
loc_0230BD80:
	.word 0x00000386	; 0230BD80
pool_0230BD84:
loc_0230BD84:
	.word 0x00004208	; 0230BD84
pool_0230BD88:
loc_0230BD88:
	.word 0x0000064C	; 0230BD88
pool_0230BD8C:
loc_0230BD8C:
	.word 0x0000065C	; 0230BD8C
pool_0230BD90:
loc_0230BD90:
	.word 0x0000066A	; 0230BD90
pool_0230BD94:
loc_0230BD94:
	.word 0x000002E8	; 0230BD94
pool_0230BD98:
loc_0230BD98:
	.word 0x00000360	; 0230BD98
pool_0230BD9C:
loc_0230BD9C:
	.word 0x048045D0	; 0230BD9C
pool_0230BDA0:
loc_0230BDA0:
	.word 0x04804488	; 0230BDA0
pool_0230BDA4:
loc_0230BDA4:
	.word 0x04804460	; 0230BDA4
pool_0230BDA8:
loc_0230BDA8:
	.word 0x0000043C	; 0230BDA8
pool_0230BDAC:
loc_0230BDAC:
	.word 0x00000450	; 0230BDAC
pool_0230BDB0:
loc_0230BDB0:
	.word WifiRamBase + 0x22C	; 0230BDB0
pool_0230BDB4:
loc_0230BDB4:
	.word WifiRamBase + 0x22E	; 0230BDB4
pool_0230BDB8:
loc_0230BDB8:
	.word WifiRamBase + 0x45C	; 0230BDB8
pool_0230BDBC:
loc_0230BDBC:
	.word WifiRamBase + 0x45E	; 0230BDBC
pool_0230BDC0:
loc_0230BDC0:
	.word WifiRamBase + 0x484	; 0230BDC0
pool_0230BDC4:
loc_0230BDC4:
	.word WifiRamBase + 0x486	; 0230BDC4
pool_0230BDC8:
loc_0230BDC8:
	.word WifiRamBase + 0x5CC	; 0230BDC8
pool_0230BDCC:
loc_0230BDCC:
	.word WifiRamBase + 0x5CE	; 0230BDCC
pool_0230BDD0:
loc_0230BDD0:
	.word WifiRamBase + 0xBF0	; 0230BDD0
pool_0230BDD4:
loc_0230BDD4:
	.word WifiRamBase + 0xBF2	; 0230BDD4
pool_0230BDD8:
loc_0230BDD8:
	.word 0x00000108	; 0230BDD8
pool_0230BDDC:
loc_0230BDDC:
	.word 0x00004108	; 0230BDDC

; ===== function loc_0230BDE0 =====
loc_0230BDE0:
	bx pc	; 0230BDE0
	.byte 0xC0, 0x46	; 0230BDE4
.arm

; ===== function loc_0230BDE4 =====
loc_0230BDE4:
	ldr pc,[pool_0230BDE8]	; 0230BDE4
pool_0230BDE8:
loc_0230BDE8:
	.word loc_037FCE38	; 0230BDE8
.thumb

; ===== function loc_0230BDEC =====
loc_0230BDEC:
	bx pc	; 0230BDEC
	.byte 0xC0, 0x46	; 0230BDF0
.arm

; ===== function loc_0230BDF0 =====
loc_0230BDF0:
	ldr pc,[pool_0230BDF4]	; 0230BDF0
pool_0230BDF4:
loc_0230BDF4:
	.word loc_037FCE38	; 0230BDF4
.thumb

; ===== function loc_0230BDF8 =====
loc_0230BDF8:
	bx pc	; 0230BDF8
	.byte 0xC0, 0x46	; 0230BDFC
.arm

; ===== function loc_0230BDFC =====
loc_0230BDFC:
	ldr pc,[pool_0230BE00]	; 0230BDFC
pool_0230BE00:
loc_0230BE00:
	.word loc_037FCE38	; 0230BE00
.thumb

; ===== function loc_0230BE04 =====
loc_0230BE04:
	bx pc	; 0230BE04
	.byte 0xC0, 0x46	; 0230BE08
.arm

; ===== function loc_0230BE08 =====
loc_0230BE08:
	ldr pc,[pool_0230BE0C]	; 0230BE08
pool_0230BE0C:
loc_0230BE0C:
	.word loc_037FCE38	; 0230BE0C
.thumb

; ===== function loc_0230BE10 =====
loc_0230BE10:
	push {r4,r5,r6,r7,lr}	; 0230BE10
	sub sp,#0x4	; 0230BE12
	add r5,r0,#0x0	; 0230BE14
	mov r4,#0x0	; 0230BE16
	mov r1,#0xdd	; 0230BE18
	bl loc_023053D8	; 0230BE1A
	add r0,r5,#0x1	; 0230BE1E
	ldr r1,[pool_0230BEE4]	; 0230BE20
	ldr r2,[r1,#0x0]	; 0230BE22
	ldr r1,[pool_0230BEE8]	; 0230BE24
	ldrh r1,[r2,r1]	; 0230BE26
	add r1,#0x8	; 0230BE28
	lsl r1,r1,#0x18	; 0230BE2A
	lsr r1,r1,#0x18	; 0230BE2C
	bl loc_023053D8	; 0230BE2E
	add r0,r5,#0x2	; 0230BE32
	lsl r1,r4,#0	; 0230BE34
	bl loc_023053D8	; 0230BE36
	add r0,r5,#0x3	; 0230BE3A
	mov r1,#0x9	; 0230BE3C
	bl loc_023053D8	; 0230BE3E
	add r0,r5,#0x4	; 0230BE42
	mov r1,#0xbf	; 0230BE44
	bl loc_023053D8	; 0230BE46
	add r0,r5,#0x5	; 0230BE4A
	lsl r1,r4,#0	; 0230BE4C
	bl loc_023053D8	; 0230BE4E
	add r0,r5,#0x6	; 0230BE52
	ldr r1,[pool_0230BEE4]	; 0230BE54
	ldr r2,[r1,#0x0]	; 0230BE56
	ldr r1,[pool_0230BEEC]	; 0230BE58
	ldrh r1,[r2,r1]	; 0230BE5A
	lsl r1,r1,#0x18	; 0230BE5C
	lsr r1,r1,#0x18	; 0230BE5E
	bl loc_023053D8	; 0230BE60
	add r0,r5,#0x7	; 0230BE64
	ldr r1,[pool_0230BEE4]	; 0230BE66
	ldr r2,[r1,#0x0]	; 0230BE68
	ldr r1,[pool_0230BEEC]	; 0230BE6A
	ldrh r1,[r2,r1]	; 0230BE6C
	asr r1,r1,#0x8	; 0230BE6E
	lsl r1,r1,#0x18	; 0230BE70
	lsr r1,r1,#0x18	; 0230BE72
	bl loc_023053D8	; 0230BE74
	ldr r0,[pool_0230BEF0]	; 0230BE78
	ldrh r6,[r0,#0x0]	; 0230BE7A
	add r0,r5,#0x0	; 0230BE7C
	add r0,#0x8	; 0230BE7E
	lsl r1,r6,#0x18	; 0230BE80
	lsr r1,r1,#0x18	; 0230BE82
	bl loc_023053D8	; 0230BE84
	add r0,r5,#0x0	; 0230BE88
	add r0,#0x9	; 0230BE8A
	lsr r1,r6,#0x8	; 0230BE8C
	lsl r1,r1,#0x18	; 0230BE8E
	lsr r1,r1,#0x18	; 0230BE90
	bl loc_023053D8	; 0230BE92
	add r4,#0xa	; 0230BE96
	ldr r0,[pool_0230BEE4]	; 0230BE98
	ldr r0,[r0,#0x0]	; 0230BE9A
	ldr r1,[pool_0230BEE8]	; 0230BE9C
	ldrh r1,[r0,r1]	; 0230BE9E
	cmp r1,#0x0	; 0230BEA0
	beq loc_0230BEDA	; 0230BEA2
	ldr r1,[pool_0230BEF4]	; 0230BEA4
	ldr r6,[r0,r1]	; 0230BEA6
	ldr r1,[pool_0230BEF8]	; 0230BEA8
	ldrh r1,[r0,r1]	; 0230BEAA
	mov r0,#0x1	; 0230BEAC
	and r1,r0	; 0230BEAE
	cmp r1,#0x0	; 0230BEB0
	beq loc_0230BEB6	; 0230BEB2
	add r6,r6,#0x1	; 0230BEB4
loc_0230BEB6:
	mov r7,#0x0	; 0230BEB6
	b loc_0230BECE	; 0230BEB8
loc_0230BEBA:
	add r0,r6,#0x0	; 0230BEBA
	bl loc_023053B4	; 0230BEBC
	add r1,r0,#0x0	; 0230BEC0
	add r0,r5,r4	; 0230BEC2
	bl loc_023053D8	; 0230BEC4
	add r4,r4,#0x1	; 0230BEC8
	add r6,r6,#0x1	; 0230BECA
	add r7,r7,#0x1	; 0230BECC
loc_0230BECE:
	ldr r0,[pool_0230BEE4]	; 0230BECE
	ldr r1,[r0,#0x0]	; 0230BED0
	ldr r0,[pool_0230BEE8]	; 0230BED2
	ldrh r0,[r1,r0]	; 0230BED4
	cmp r7,r0	; 0230BED6
	bcc loc_0230BEBA	; 0230BED8
loc_0230BEDA:
	add r0,r4,#0x0	; 0230BEDA
	add sp,#0x4	; 0230BEDC
	pop {r4,r5,r6,r7}	; 0230BEDE
	pop {r3}	; 0230BEE0
	bx r3	; 0230BEE2
pool_0230BEE4:
loc_0230BEE4:
	.word FirmwareWlWorkPointerSlot	; 0230BEE4
pool_0230BEE8:
loc_0230BEE8:
	.word 0x0000039C	; 0230BEE8
pool_0230BEEC:
loc_0230BEEC:
	.word 0x00000300	; 0230BEEC
pool_0230BEF0:
loc_0230BEF0:
	.word FirmwareWlAdjustedTimeSlot	; 0230BEF0
pool_0230BEF4:
loc_0230BEF4:
	.word 0x00000398	; 0230BEF4
pool_0230BEF8:
loc_0230BEF8:
	.word 0x0000039E	; 0230BEF8

; ===== function loc_0230BEFC =====
loc_0230BEFC:
	push {r4,lr}	; 0230BEFC
	add r4,r0,#0x0	; 0230BEFE
	mov r1,#0x3	; 0230BF00
	bl loc_023053D8	; 0230BF02
	add r0,r4,#0x1	; 0230BF06
	mov r1,#0x1	; 0230BF08
	bl loc_023053D8	; 0230BF0A
	add r0,r4,#0x2	; 0230BF0E
	ldr r1,[pool_0230BF28]	; 0230BF10
	ldr r2,[r1,#0x0]	; 0230BF12
	ldr r1,[pool_0230BF2C]	; 0230BF14
	ldrh r1,[r2,r1]	; 0230BF16
	lsl r1,r1,#0x18	; 0230BF18
	lsr r1,r1,#0x18	; 0230BF1A
	bl loc_023053D8	; 0230BF1C
	mov r0,#0x3	; 0230BF20
	pop {r4}	; 0230BF22
	pop {r3}	; 0230BF24
	bx r3	; 0230BF26
pool_0230BF28:
loc_0230BF28:
	.word FirmwareWlWorkPointerSlot	; 0230BF28
pool_0230BF2C:
loc_0230BF2C:
	.word 0x00000376	; 0230BF2C

; ===== function loc_0230BF30 =====
loc_0230BF30:
	push {r4,r5,r6,r7,lr}	; 0230BF30
	sub sp,#0x4	; 0230BF32
	add r6,r0,#0x0	; 0230BF34
	mov r5,#0x0	; 0230BF36
	mov r1,#0x1	; 0230BF38
	bl loc_023053D8	; 0230BF3A
	add r5,r5,#0x2	; 0230BF3E
	mov r4,#0x0	; 0230BF40
	ldr r7,[pool_0230BFA0]	; 0230BF42
loc_0230BF44:
	mov r1,#0x1	; 0230BF44
	lsl r1,r4	; 0230BF46
	ldr r0,[pool_0230BFA4]	; 0230BF48
	ldr r0,[r0,#0x0]	; 0230BF4A
	ldr r2,[pool_0230BFA8]	; 0230BF4C
	ldrh r2,[r0,r2]	; 0230BF4E
	and r2,r1	; 0230BF50
	cmp r2,#0x0	; 0230BF52
	beq loc_0230BF84	; 0230BF54
	ldr r2,[pool_0230BFAC]	; 0230BF56
	ldrh r0,[r0,r2]	; 0230BF58
	and r0,r1	; 0230BF5A
	cmp r0,#0x0	; 0230BF5C
	beq loc_0230BF74	; 0230BF5E
	add r0,r6,r5	; 0230BF60
	lsl r1,r4,#0x1	; 0230BF62
	ldrh r2,[r7,r1]	; 0230BF64
	mov r1,#0x80	; 0230BF66
	orr r2,r1	; 0230BF68
	lsl r1,r2,#0x18	; 0230BF6A
	lsr r1,r1,#0x18	; 0230BF6C
	bl loc_023053D8	; 0230BF6E
	b loc_0230BF82	; 0230BF72
loc_0230BF74:
	add r0,r6,r5	; 0230BF74
	lsl r1,r4,#0x1	; 0230BF76
	ldrh r1,[r7,r1]	; 0230BF78
	lsl r1,r1,#0x18	; 0230BF7A
	lsr r1,r1,#0x18	; 0230BF7C
	bl loc_023053D8	; 0230BF7E
loc_0230BF82:
	add r5,r5,#0x1	; 0230BF82
loc_0230BF84:
	add r4,r4,#0x1	; 0230BF84
	cmp r4,#0x10	; 0230BF86
	bcc loc_0230BF44	; 0230BF88
	add r0,r6,#0x1	; 0230BF8A
	sub r1,r5,#0x2	; 0230BF8C
	lsl r1,r1,#0x18	; 0230BF8E
	lsr r1,r1,#0x18	; 0230BF90
	bl loc_023053D8	; 0230BF92
	add r0,r5,#0x0	; 0230BF96
	add sp,#0x4	; 0230BF98
	pop {r4,r5,r6,r7}	; 0230BF9A
	pop {r3}	; 0230BF9C
	bx r3	; 0230BF9E
pool_0230BFA0:
loc_0230BFA0:
	.word 0x02310398	; 0230BFA0
pool_0230BFA4:
loc_0230BFA4:
	.word FirmwareWlWorkPointerSlot	; 0230BFA4
pool_0230BFA8:
loc_0230BFA8:
	.word 0x0000035E	; 0230BFA8
pool_0230BFAC:
loc_0230BFAC:
	.word 0x0000035C	; 0230BFAC

; ===== function loc_0230BFB0 =====
loc_0230BFB0:
	push {r4,r5,r6,r7,lr}	; 0230BFB0
	sub sp,#0x4	; 0230BFB2
	add r6,r0,#0x0	; 0230BFB4
	mov r5,#0x0	; 0230BFB6
	add r1,r5,#0x0	; 0230BFB8
	bl loc_023053D8	; 0230BFBA
	add r0,r6,#0x1	; 0230BFBE
	ldr r1,[pool_0230C004]	; 0230BFC0
	ldr r2,[r1,#0x0]	; 0230BFC2
	ldr r1,[pool_0230C008]	; 0230BFC4
	ldrh r1,[r2,r1]	; 0230BFC6
	lsl r1,r1,#0x18	; 0230BFC8
	lsr r1,r1,#0x18	; 0230BFCA
	bl loc_023053D8	; 0230BFCC
	add r5,r5,#0x2	; 0230BFD0
	mov r4,#0x0	; 0230BFD2
	ldr r7,[pool_0230C004]	; 0230BFD4
	b loc_0230BFEE	; 0230BFD6
loc_0230BFD8:
	ldr r1,[pool_0230C00C]	; 0230BFD8
	add r0,r0,r1	; 0230BFDA
	add r0,r0,r4	; 0230BFDC
	bl loc_023053B4	; 0230BFDE
	add r1,r0,#0x0	; 0230BFE2
	add r0,r6,r5	; 0230BFE4
	bl loc_023053D8	; 0230BFE6
	add r5,r5,#0x1	; 0230BFEA
	add r4,r4,#0x1	; 0230BFEC
loc_0230BFEE:
	ldr r0,[r7,#0x0]	; 0230BFEE
	ldr r1,[pool_0230C008]	; 0230BFF0
	ldrh r1,[r0,r1]	; 0230BFF2
	cmp r4,r1	; 0230BFF4
	bcc loc_0230BFD8	; 0230BFF6
	add r0,r5,#0x0	; 0230BFF8
	add sp,#0x4	; 0230BFFA
	pop {r4,r5,r6,r7}	; 0230BFFC
	pop {r3}	; 0230BFFE
	bx r3	; 0230C000
	.byte 0xC0, 0x46	; 0230C004
pool_0230C004:
loc_0230C004:
	.word FirmwareWlWorkPointerSlot	; 0230C004
pool_0230C008:
loc_0230C008:
	.word 0x0000031A	; 0230C008
pool_0230C00C:
loc_0230C00C:
	.word 0x0000031C	; 0230C00C

; ===== function loc_0230C010 =====
loc_0230C010:
	ldr r2,[pool_0230C040]	; 0230C010
	ldr r3,[r2,#0x0]	; 0230C012
	ldr r1,[pool_0230C044]	; 0230C014
	ldr r1,[r3,r1]	; 0230C016
	mov r3,#0x0	; 0230C018
	strh r3,[r1,#0x0]	; 0230C01A
	strh r3,[r1,#0x2]	; 0230C01C
	strh r3,[r1,#0x4]	; 0230C01E
	mov r3,#0x14	; 0230C020
	strh r3,[r1,#0xa]	; 0230C022
	mov r3,#0xa4	; 0230C024
	strh r3,[r1,#0xc]	; 0230C026
	ldr r3,[pool_0230C048]	; 0230C028
	orr r0,r3	; 0230C02A
	strh r0,[r1,#0xe]	; 0230C02C
	ldr r3,[r2,#0x0]	; 0230C02E
	add r1,#0x10	; 0230C030
	add r0,r1,#0x0	; 0230C032
	ldr r1,[pool_0230C04C]	; 0230C034
	add r1,r3,r1	; 0230C036
	ldr r2,[pool_0230C050]	; 0230C038
	add r2,r3,r2	; 0230C03A
	ldr r3,[pool_0230C054]	; 0230C03C
	bx r3	; 0230C03E
pool_0230C040:
loc_0230C040:
	.word FirmwareWlWorkPointerSlot	; 0230C040
pool_0230C044:
loc_0230C044:
	.word 0x00000414	; 0230C044
pool_0230C048:
loc_0230C048:
	.word 0x0000C000	; 0230C048
pool_0230C04C:
loc_0230C04C:
	.word 0x00000360	; 0230C04C
pool_0230C050:
loc_0230C050:
	.word 0x000002E8	; 0230C050
pool_0230C054:
loc_0230C054:
	.word loc_0230643C + 1	; 0230C054

; ===== function loc_0230C058 =====
loc_0230C058:
	push {r4,r5,r6,lr}	; 0230C058
	add r6,r0,#0x0	; 0230C05A
	add r5,r1,#0x0	; 0230C05C
	ldr r0,[pool_0230C0B4]	; 0230C05E
	ldr r1,[r0,#0x0]	; 0230C060
	ldr r0,[pool_0230C0B8]	; 0230C062
	add r0,r1,r0	; 0230C064
	mov r1,#0x36	; 0230C066
	bl loc_02305050	; 0230C068
	add r4,r0,#0x0	; 0230C06C
	cmp r4,#0x0	; 0230C06E
	bne loc_0230C07C	; 0230C070
	mov r0,#0x2	; 0230C072
	bl loc_02305130	; 0230C074
	add r0,r4,#0x0	; 0230C078
	b loc_0230C0AE	; 0230C07A
loc_0230C07C:
	ldr r0,[pool_0230C0BC]	; 0230C07C
	strh r0,[r4,#0xc]	; 0230C07E
	add r4,#0x10	; 0230C080
	ldr r0,[pool_0230C0B4]	; 0230C082
	ldr r1,[r0,#0x0]	; 0230C084
	ldr r0,[pool_0230C0C0]	; 0230C086
	add r0,r1,r0	; 0230C088
	add r1,r4,#0x0	; 0230C08A
	mov r2,#0x2c	; 0230C08C
	bl loc_0230C0C4	; 0230C08E
	strh r5,[r4,#0x2c]	; 0230C092
	mov r0,#0x2	; 0230C094
	strh r0,[r4,#0x6]	; 0230C096
	ldrh r0,[r4,#0x6]	; 0230C098
	add r0,#0x1c	; 0230C09A
	strh r0,[r4,#0x12]	; 0230C09C
	mov r0,#0xc0	; 0230C09E
	strh r0,[r4,#0x14]	; 0230C0A0
	add r0,r4,#0x0	; 0230C0A2
	add r0,#0x18	; 0230C0A4
	add r1,r6,#0x0	; 0230C0A6
	bl loc_02306458	; 0230C0A8
	add r0,r4,#0x0	; 0230C0AC
loc_0230C0AE:
	pop {r4,r5,r6}	; 0230C0AE
	pop {r3}	; 0230C0B0
	bx r3	; 0230C0B2
pool_0230C0B4:
loc_0230C0B4:
	.word FirmwareWlWorkPointerSlot	; 0230C0B4
pool_0230C0B8:
loc_0230C0B8:
	.word 0x0000014C	; 0230C0B8
pool_0230C0BC:
loc_0230C0BC:
	.word 0x0000FFFF	; 0230C0BC
pool_0230C0C0:
loc_0230C0C0:
	.word 0x0000064C	; 0230C0C0

; ===== function loc_0230C0C4 =====
loc_0230C0C4:
	bx pc	; 0230C0C4
	.byte 0xC0, 0x46	; 0230C0C8
.arm

; ===== function loc_0230C0C8 =====
loc_0230C0C8:
	ldr pc,[pool_0230C0CC]	; 0230C0C8
pool_0230C0CC:
loc_0230C0CC:
	.word loc_037FCE4C	; 0230C0CC
.thumb

; ===== function loc_0230C0D0 =====
loc_0230C0D0:
	push {r4,r5,r6,lr}	; 0230C0D0
	add r6,r0,#0x0	; 0230C0D2
	add r5,r1,#0x0	; 0230C0D4
	ldr r0,[pool_0230C14C]	; 0230C0D6
	ldr r1,[r0,#0x0]	; 0230C0D8
	ldr r0,[pool_0230C150]	; 0230C0DA
	add r0,r1,r0	; 0230C0DC
	ldr r1,[pool_0230C154]	; 0230C0DE
	add r1,r5,r1	; 0230C0E0
	bl loc_02305050	; 0230C0E2
	add r4,r0,#0x0	; 0230C0E6
	cmp r4,#0x0	; 0230C0E8
	bne loc_0230C0F6	; 0230C0EA
	mov r0,#0x2	; 0230C0EC
	bl loc_02305130	; 0230C0EE
	add r0,r4,#0x0	; 0230C0F2
	b loc_0230C146	; 0230C0F4
loc_0230C0F6:
	ldr r0,[pool_0230C158]	; 0230C0F6
	strh r0,[r4,#0xc]	; 0230C0F8
	add r4,#0x10	; 0230C0FA
	ldr r0,[pool_0230C14C]	; 0230C0FC
	ldr r1,[r0,#0x0]	; 0230C0FE
	ldr r0,[pool_0230C15C]	; 0230C100
	add r0,r1,r0	; 0230C102
	add r1,r4,#0x0	; 0230C104
	mov r2,#0x2c	; 0230C106
	bl loc_0230C160	; 0230C108
	cmp r5,#0x0	; 0230C10C
	beq loc_0230C12C	; 0230C10E
	add r0,r4,#0x0	; 0230C110
	add r0,#0x32	; 0230C112
	mov r1,#0x10	; 0230C114
	bl loc_023053D8	; 0230C116
	add r0,r4,#0x0	; 0230C11A
	add r0,#0x33	; 0230C11C
	lsl r1,r5,#0x18	; 0230C11E
	lsr r1,r1,#0x18	; 0230C120
	bl loc_023053D8	; 0230C122
	add r0,r5,#0x2	; 0230C126
	lsl r0,r0,#0x10	; 0230C128
	lsr r5,r0,#0x10	; 0230C12A
loc_0230C12C:
	add r0,r5,#0x6	; 0230C12C
	strh r0,[r4,#0x6]	; 0230C12E
	ldrh r0,[r4,#0x6]	; 0230C130
	add r0,#0x1c	; 0230C132
	strh r0,[r4,#0x12]	; 0230C134
	mov r0,#0xb0	; 0230C136
	strh r0,[r4,#0x14]	; 0230C138
	add r0,r4,#0x0	; 0230C13A
	add r0,#0x18	; 0230C13C
	add r1,r6,#0x0	; 0230C13E
	bl loc_02306458	; 0230C140
	add r0,r4,#0x0	; 0230C144
loc_0230C146:
	pop {r4,r5,r6}	; 0230C146
	pop {r3}	; 0230C148
	bx r3	; 0230C14A
pool_0230C14C:
loc_0230C14C:
	.word FirmwareWlWorkPointerSlot	; 0230C14C
pool_0230C150:
loc_0230C150:
	.word 0x0000014C	; 0230C150
pool_0230C154:
loc_0230C154:
	.word 0x0000013A	; 0230C154
pool_0230C158:
loc_0230C158:
	.word 0x0000FFFF	; 0230C158
pool_0230C15C:
loc_0230C15C:
	.word 0x0000064C	; 0230C15C

; ===== function loc_0230C160 =====
loc_0230C160:
	bx pc	; 0230C160
	.byte 0xC0, 0x46	; 0230C164
.arm

; ===== function loc_0230C164 =====
loc_0230C164:
	ldr pc,[pool_0230C168]	; 0230C164
pool_0230C168:
loc_0230C168:
	.word loc_037FCE4C	; 0230C168
.thumb

; ===== function loc_0230C16C =====
loc_0230C16C:
	push {r4,r5,r6,lr}	; 0230C16C
	add r6,r0,#0x0	; 0230C16E
	ldr r0,[pool_0230C208]	; 0230C170
	ldr r2,[r0,#0x0]	; 0230C172
	ldr r0,[pool_0230C20C]	; 0230C174
	add r0,r2,r0	; 0230C176
	ldr r1,[pool_0230C210]	; 0230C178
	ldrh r1,[r2,r1]	; 0230C17A
	add r1,#0x78	; 0230C17C
	bl loc_02305050	; 0230C17E
	add r4,r0,#0x0	; 0230C182
	cmp r4,#0x0	; 0230C184
	bne loc_0230C192	; 0230C186
	mov r0,#0x2	; 0230C188
	bl loc_02305130	; 0230C18A
	add r0,r4,#0x0	; 0230C18E
	b loc_0230C202	; 0230C190
loc_0230C192:
	ldr r0,[pool_0230C214]	; 0230C192
	strh r0,[r4,#0xc]	; 0230C194
	add r4,#0x10	; 0230C196
	ldr r0,[pool_0230C208]	; 0230C198
	ldr r1,[r0,#0x0]	; 0230C19A
	ldr r0,[pool_0230C218]	; 0230C19C
	add r0,r1,r0	; 0230C19E
	add r1,r4,#0x0	; 0230C1A0
	mov r2,#0x2c	; 0230C1A2
	bl loc_0230C224	; 0230C1A4
	ldr r2,[pool_0230C208]	; 0230C1A8
	ldr r1,[r2,#0x0]	; 0230C1AA
	ldr r0,[pool_0230C21C]	; 0230C1AC
	ldrh r0,[r1,r0]	; 0230C1AE
	strh r0,[r4,#0x34]	; 0230C1B0
	ldr r1,[r2,#0x0]	; 0230C1B2
	ldr r0,[pool_0230C220]	; 0230C1B4
	ldrh r0,[r1,r0]	; 0230C1B6
	strh r0,[r4,#0x36]	; 0230C1B8
	add r0,r4,#0x0	; 0230C1BA
	add r0,#0x38	; 0230C1BC
	bl loc_0230BFB0	; 0230C1BE
	add r5,r0,#0x0	; 0230C1C2
	add r0,r4,#0x0	; 0230C1C4
	add r0,#0x38	; 0230C1C6
	add r0,r0,r5	; 0230C1C8
	bl loc_0230BF30	; 0230C1CA
	add r5,r5,r0	; 0230C1CE
	add r0,r4,#0x0	; 0230C1D0
	add r0,#0x38	; 0230C1D2
	add r0,r0,r5	; 0230C1D4
	bl loc_0230BEFC	; 0230C1D6
	add r5,r5,r0	; 0230C1DA
	add r0,r4,#0x0	; 0230C1DC
	add r0,#0x38	; 0230C1DE
	add r0,r0,r5	; 0230C1E0
	bl loc_0230BE10	; 0230C1E2
	add r0,r5,r0	; 0230C1E6
	add r0,#0xc	; 0230C1E8
	strh r0,[r4,#0x6]	; 0230C1EA
	ldrh r0,[r4,#0x6]	; 0230C1EC
	add r0,#0x1c	; 0230C1EE
	strh r0,[r4,#0x12]	; 0230C1F0
	mov r0,#0x50	; 0230C1F2
	strh r0,[r4,#0x14]	; 0230C1F4
	add r0,r4,#0x0	; 0230C1F6
	add r0,#0x18	; 0230C1F8
	add r1,r6,#0x0	; 0230C1FA
	bl loc_02306458	; 0230C1FC
	add r0,r4,#0x0	; 0230C200
loc_0230C202:
	pop {r4,r5,r6}	; 0230C202
	pop {r3}	; 0230C204
	bx r3	; 0230C206
pool_0230C208:
loc_0230C208:
	.word FirmwareWlWorkPointerSlot	; 0230C208
pool_0230C20C:
loc_0230C20C:
	.word 0x0000014C	; 0230C20C
pool_0230C210:
loc_0230C210:
	.word 0x0000039C	; 0230C210
pool_0230C214:
loc_0230C214:
	.word 0x0000FFFF	; 0230C214
pool_0230C218:
loc_0230C218:
	.word 0x0000064C	; 0230C218
pool_0230C21C:
loc_0230C21C:
	.word 0x0000036A	; 0230C21C
pool_0230C220:
loc_0230C220:
	.word 0x00000378	; 0230C220

; ===== function loc_0230C224 =====
loc_0230C224:
	bx pc	; 0230C224
	.byte 0xC0, 0x46	; 0230C228
.arm

; ===== function loc_0230C228 =====
loc_0230C228:
	ldr pc,[pool_0230C22C]	; 0230C228
pool_0230C22C:
loc_0230C22C:
	.word loc_037FCE4C	; 0230C22C
.thumb

; ===== function loc_0230C230 =====
loc_0230C230:
	push {r4,r5,r6,lr}	; 0230C230
	add r6,r0,#0x0	; 0230C232
	ldr r0,[pool_0230C29C]	; 0230C234
	ldr r1,[r0,#0x0]	; 0230C236
	ldr r0,[pool_0230C2A0]	; 0230C238
	add r0,r1,r0	; 0230C23A
	mov r1,#0x5a	; 0230C23C
	bl loc_02305050	; 0230C23E
	add r5,r0,#0x0	; 0230C242
	cmp r5,#0x0	; 0230C244
	bne loc_0230C252	; 0230C246
	mov r0,#0x2	; 0230C248
	bl loc_02305130	; 0230C24A
	add r0,r5,#0x0	; 0230C24E
	b loc_0230C294	; 0230C250
loc_0230C252:
	ldr r0,[pool_0230C2A4]	; 0230C252
	strh r0,[r5,#0xc]	; 0230C254
	add r5,#0x10	; 0230C256
	ldr r0,[pool_0230C29C]	; 0230C258
	ldr r1,[r0,#0x0]	; 0230C25A
	ldr r0,[pool_0230C2A8]	; 0230C25C
	add r0,r1,r0	; 0230C25E
	add r1,r5,#0x0	; 0230C260
	mov r2,#0x2c	; 0230C262
	bl loc_0230C2AC	; 0230C264
	add r0,r5,#0x0	; 0230C268
	add r0,#0x2c	; 0230C26A
	bl loc_0230BFB0	; 0230C26C
	add r4,r0,#0x0	; 0230C270
	add r0,r5,#0x0	; 0230C272
	add r0,#0x2c	; 0230C274
	add r0,r0,r4	; 0230C276
	bl loc_0230BF30	; 0230C278
	add r0,r4,r0	; 0230C27C
	strh r0,[r5,#0x6]	; 0230C27E
	add r0,#0x1c	; 0230C280
	strh r0,[r5,#0x12]	; 0230C282
	mov r0,#0x40	; 0230C284
	strh r0,[r5,#0x14]	; 0230C286
	add r0,r5,#0x0	; 0230C288
	add r0,#0x18	; 0230C28A
	add r1,r6,#0x0	; 0230C28C
	bl loc_02306458	; 0230C28E
	add r0,r5,#0x0	; 0230C292
loc_0230C294:
	pop {r4,r5,r6}	; 0230C294
	pop {r3}	; 0230C296
	bx r3	; 0230C298
	.byte 0xC0, 0x46	; 0230C29C
pool_0230C29C:
loc_0230C29C:
	.word FirmwareWlWorkPointerSlot	; 0230C29C
pool_0230C2A0:
loc_0230C2A0:
	.word 0x0000014C	; 0230C2A0
pool_0230C2A4:
loc_0230C2A4:
	.word 0x0000FFFF	; 0230C2A4
pool_0230C2A8:
loc_0230C2A8:
	.word 0x0000064C	; 0230C2A8

; ===== function loc_0230C2AC =====
loc_0230C2AC:
	bx pc	; 0230C2AC
	.byte 0xC0, 0x46	; 0230C2B0
.arm

; ===== function loc_0230C2B0 =====
loc_0230C2B0:
	ldr pc,[pool_0230C2B4]	; 0230C2B0
pool_0230C2B4:
loc_0230C2B4:
	.word loc_037FCE4C	; 0230C2B4
.thumb

; ===== function loc_0230C2B8 =====
loc_0230C2B8:
	push {r4,r5,r6,r7,lr}	; 0230C2B8
	sub sp,#0xc	; 0230C2BA
	add r6,r0,#0x0	; 0230C2BC
	add r4,r1,#0x0	; 0230C2BE
	add r7,r2,#0x0	; 0230C2C0
	ldr r0,[pool_0230C3BC]	; 0230C2C2
	ldr r1,[r0,#0x0]	; 0230C2C4
	ldr r0,[pool_0230C3C0]	; 0230C2C6
	add r0,r1,r0	; 0230C2C8
	mov r1,#0x60	; 0230C2CA
	bl loc_02305050	; 0230C2CC
	add r5,r0,#0x0	; 0230C2D0
	cmp r5,#0x0	; 0230C2D2
	bne loc_0230C2E0	; 0230C2D4
	mov r0,#0x2	; 0230C2D6
	bl loc_02305130	; 0230C2D8
	add r0,r5,#0x0	; 0230C2DC
	b loc_0230C3B4	; 0230C2DE
loc_0230C2E0:
	ldr r0,[pool_0230C3C4]	; 0230C2E0
	strh r0,[r5,#0xc]	; 0230C2E2
	add r5,#0x10	; 0230C2E4
	cmp r4,#0x0	; 0230C2E6
	bne loc_0230C2FA	; 0230C2E8
	add r0,r6,#0x0	; 0230C2EA
	bl loc_023090F4	; 0230C2EC
	str r0,[sp,#0x0]	; 0230C2F0
	cmp r0,#0x0	; 0230C2F2
	bne loc_0230C2FE	; 0230C2F4
	mov r4,#0x13	; 0230C2F6
	b loc_0230C2FE	; 0230C2F8
loc_0230C2FA:
	mov r0,#0x0	; 0230C2FA
	str r0,[sp,#0x0]	; 0230C2FC
loc_0230C2FE:
	ldr r0,[pool_0230C3BC]	; 0230C2FE
	ldr r1,[r0,#0x0]	; 0230C300
	ldr r0,[pool_0230C3C8]	; 0230C302
	add r0,r1,r0	; 0230C304
	add r1,r5,#0x0	; 0230C306
	mov r2,#0x2c	; 0230C308
	bl loc_0230C3D8	; 0230C30A
	ldr r0,[pool_0230C3BC]	; 0230C30E
	ldr r1,[r0,#0x0]	; 0230C310
	ldr r0,[pool_0230C3CC]	; 0230C312
	ldrh r0,[r1,r0]	; 0230C314
	strh r0,[r5,#0x2c]	; 0230C316
	strh r4,[r5,#0x2e]	; 0230C318
	ldr r1,[pool_0230C3D0]	; 0230C31A
	ldr r0,[sp,#0x0]	; 0230C31C
	orr r0,r1	; 0230C31E
	str r0,[sp,#0x0]	; 0230C320
	strh r0,[r5,#0x30]	; 0230C322
	add r0,r5,#0x0	; 0230C324
	add r0,#0x32	; 0230C326
	bl loc_0230BF30	; 0230C328
	add r0,r0,#0x6	; 0230C32C
	strh r0,[r5,#0x6]	; 0230C32E
	ldrh r0,[r5,#0x6]	; 0230C330
	add r0,#0x1c	; 0230C332
	strh r0,[r5,#0x12]	; 0230C334
	mov r0,#0x30	; 0230C336
	strh r0,[r5,#0x14]	; 0230C338
	add r0,r5,#0x0	; 0230C33A
	add r0,#0x18	; 0230C33C
	ldr r1,[pool_0230C3BC]	; 0230C33E
	ldr r2,[r1,#0x0]	; 0230C340
	ldr r1,[pool_0230C3D4]	; 0230C342
	ldr r2,[r2,r1]	; 0230C344
	mov r1,#0x1c	; 0230C346
	mul r6,r1	; 0230C348
	add r1,r2,r6	; 0230C34A
	add r1,r1,#0x4	; 0230C34C
	bl loc_02306458	; 0230C34E
	add r1,r5,#0x0	; 0230C352
	add r1,#0x14	; 0230C354
	ldrh r0,[r5,#0x12]	; 0230C356
	add r4,r1,r0	; 0230C358
	cmp r7,#0x0	; 0230C35A
	beq loc_0230C3A2	; 0230C35C
	add r0,r7,#0x1	; 0230C35E
	bl loc_023053B4	; 0230C360
	str r0,[sp,#0x4]	; 0230C364
	add r0,r7,#0x0	; 0230C366
	bl loc_023053B4	; 0230C368
	add r1,r0,#0x0	; 0230C36C
	add r0,r4,#0x0	; 0230C36E
	bl loc_023053D8	; 0230C370
	add r0,r4,#0x1	; 0230C374
	ldr r1,[sp,#0x4]	; 0230C376
	lsl r1,r1,#0x18	; 0230C378
	lsr r1,r1,#0x18	; 0230C37A
	bl loc_023053D8	; 0230C37C
	add r4,r4,#0x2	; 0230C380
	mov r6,#0x0	; 0230C382
	b loc_0230C39A	; 0230C384
loc_0230C386:
	add r0,r7,#0x2	; 0230C386
	add r0,r0,r6	; 0230C388
	bl loc_023053B4	; 0230C38A
	add r1,r0,#0x0	; 0230C38E
	add r0,r4,#0x0	; 0230C390
	bl loc_023053D8	; 0230C392
	add r4,r4,#0x1	; 0230C396
	add r6,r6,#0x1	; 0230C398
loc_0230C39A:
	ldr r0,[sp,#0x4]	; 0230C39A
	cmp r6,r0	; 0230C39C
	bcc loc_0230C386	; 0230C39E
	b loc_0230C3B2	; 0230C3A0
loc_0230C3A2:
	add r0,r4,#0x0	; 0230C3A2
	mov r1,#0x0	; 0230C3A4
	bl loc_023053D8	; 0230C3A6
	add r0,r4,#0x1	; 0230C3AA
	mov r1,#0x0	; 0230C3AC
	bl loc_023053D8	; 0230C3AE
loc_0230C3B2:
	add r0,r5,#0x0	; 0230C3B2
loc_0230C3B4:
	add sp,#0xc	; 0230C3B4
	pop {r4,r5,r6,r7}	; 0230C3B6
	pop {r3}	; 0230C3B8
	bx r3	; 0230C3BA
pool_0230C3BC:
loc_0230C3BC:
	.word FirmwareWlWorkPointerSlot	; 0230C3BC
pool_0230C3C0:
loc_0230C3C0:
	.word 0x0000014C	; 0230C3C0
pool_0230C3C4:
loc_0230C3C4:
	.word 0x0000FFFF	; 0230C3C4
pool_0230C3C8:
loc_0230C3C8:
	.word 0x0000064C	; 0230C3C8
pool_0230C3CC:
loc_0230C3CC:
	.word 0x00000378	; 0230C3CC
pool_0230C3D0:
loc_0230C3D0:
	.word 0x0000C000	; 0230C3D0
pool_0230C3D4:
loc_0230C3D4:
	.word 0x000002E0	; 0230C3D4

; ===== function loc_0230C3D8 =====
loc_0230C3D8:
	bx pc	; 0230C3D8
	.byte 0xC0, 0x46	; 0230C3DC
.arm

; ===== function loc_0230C3DC =====
loc_0230C3DC:
	ldr pc,[pool_0230C3E0]	; 0230C3DC
pool_0230C3E0:
loc_0230C3E0:
	.word loc_037FCE4C	; 0230C3E0
.thumb

; ===== function loc_0230C3E4 =====
loc_0230C3E4:
	push {r4,r5,r6,r7,lr}	; 0230C3E4
	sub sp,#0xc	; 0230C3E6
	add r6,r0,#0x0	; 0230C3E8
	add r4,r1,#0x0	; 0230C3EA
	add r7,r2,#0x0	; 0230C3EC
	ldr r0,[pool_0230C4F4]	; 0230C3EE
	ldr r1,[r0,#0x0]	; 0230C3F0
	ldr r0,[pool_0230C4F8]	; 0230C3F2
	add r0,r1,r0	; 0230C3F4
	mov r1,#0x60	; 0230C3F6
	bl loc_02305050	; 0230C3F8
	add r5,r0,#0x0	; 0230C3FC
	cmp r5,#0x0	; 0230C3FE
	bne loc_0230C40C	; 0230C400
	mov r0,#0x2	; 0230C402
	bl loc_02305130	; 0230C404
	add r0,r5,#0x0	; 0230C408
	b loc_0230C4EA	; 0230C40A
loc_0230C40C:
	ldr r0,[pool_0230C4FC]	; 0230C40C
	strh r0,[r5,#0xc]	; 0230C40E
	add r5,#0x10	; 0230C410
	cmp r4,#0x0	; 0230C412
	bne loc_0230C426	; 0230C414
	add r0,r6,#0x0	; 0230C416
	bl loc_023090F4	; 0230C418
	str r0,[sp,#0x0]	; 0230C41C
	cmp r0,#0x0	; 0230C41E
	bne loc_0230C42A	; 0230C420
	mov r4,#0x13	; 0230C422
	b loc_0230C42A	; 0230C424
loc_0230C426:
	mov r0,#0x0	; 0230C426
	str r0,[sp,#0x0]	; 0230C428
loc_0230C42A:
	ldr r0,[pool_0230C4F4]	; 0230C42A
	ldr r1,[r0,#0x0]	; 0230C42C
	ldr r0,[pool_0230C500]	; 0230C42E
	add r0,r1,r0	; 0230C430
	add r1,r5,#0x0	; 0230C432
	mov r2,#0x2c	; 0230C434
	bl loc_0230C510	; 0230C436
	ldr r0,[pool_0230C4F4]	; 0230C43A
	ldr r1,[r0,#0x0]	; 0230C43C
	ldr r0,[pool_0230C504]	; 0230C43E
	ldrh r0,[r1,r0]	; 0230C440
	strh r0,[r5,#0x2c]	; 0230C442
	strh r4,[r5,#0x2e]	; 0230C444
	ldr r0,[sp,#0x0]	; 0230C446
	strh r0,[r5,#0x30]	; 0230C448
	cmp r0,#0x0	; 0230C44A
	beq loc_0230C45A	; 0230C44C
	add r2,r5,#0x0	; 0230C44E
	add r2,#0x30	; 0230C450
	ldrh r1,[r2,#0x0]	; 0230C452
	ldr r0,[pool_0230C508]	; 0230C454
	orr r1,r0	; 0230C456
	strh r1,[r2,#0x0]	; 0230C458
loc_0230C45A:
	add r0,r5,#0x0	; 0230C45A
	add r0,#0x32	; 0230C45C
	bl loc_0230BF30	; 0230C45E
	add r0,r0,#0x6	; 0230C462
	strh r0,[r5,#0x6]	; 0230C464
	ldrh r0,[r5,#0x6]	; 0230C466
	add r0,#0x1c	; 0230C468
	strh r0,[r5,#0x12]	; 0230C46A
	mov r0,#0x10	; 0230C46C
	strh r0,[r5,#0x14]	; 0230C46E
	add r0,r5,#0x0	; 0230C470
	add r0,#0x18	; 0230C472
	ldr r1,[pool_0230C4F4]	; 0230C474
	ldr r2,[r1,#0x0]	; 0230C476
	ldr r1,[pool_0230C50C]	; 0230C478
	ldr r2,[r2,r1]	; 0230C47A
	mov r1,#0x1c	; 0230C47C
	mul r6,r1	; 0230C47E
	add r1,r2,r6	; 0230C480
	add r1,r1,#0x4	; 0230C482
	bl loc_02306458	; 0230C484
	add r1,r5,#0x0	; 0230C488
	add r1,#0x14	; 0230C48A
	ldrh r0,[r5,#0x12]	; 0230C48C
	add r4,r1,r0	; 0230C48E
	cmp r7,#0x0	; 0230C490
	beq loc_0230C4D8	; 0230C492
	add r0,r7,#0x1	; 0230C494
	bl loc_023053B4	; 0230C496
	str r0,[sp,#0x4]	; 0230C49A
	add r0,r7,#0x0	; 0230C49C
	bl loc_023053B4	; 0230C49E
	add r1,r0,#0x0	; 0230C4A2
	add r0,r4,#0x0	; 0230C4A4
	bl loc_023053D8	; 0230C4A6
	add r0,r4,#0x1	; 0230C4AA
	add r4,r4,#0x2	; 0230C4AC
	ldr r1,[sp,#0x4]	; 0230C4AE
	lsl r1,r1,#0x18	; 0230C4B0
	lsr r1,r1,#0x18	; 0230C4B2
	bl loc_023053D8	; 0230C4B4
	mov r6,#0x0	; 0230C4B8
	b loc_0230C4D0	; 0230C4BA
loc_0230C4BC:
	add r0,r7,#0x2	; 0230C4BC
	add r0,r0,r6	; 0230C4BE
	bl loc_023053B4	; 0230C4C0
	add r1,r0,#0x0	; 0230C4C4
	add r0,r4,#0x0	; 0230C4C6
	bl loc_023053D8	; 0230C4C8
	add r6,r6,#0x1	; 0230C4CC
	add r4,r4,#0x1	; 0230C4CE
loc_0230C4D0:
	ldr r0,[sp,#0x4]	; 0230C4D0
	cmp r6,r0	; 0230C4D2
	bcc loc_0230C4BC	; 0230C4D4
	b loc_0230C4E8	; 0230C4D6
loc_0230C4D8:
	add r0,r4,#0x0	; 0230C4D8
	mov r1,#0x0	; 0230C4DA
	bl loc_023053D8	; 0230C4DC
	add r0,r4,#0x1	; 0230C4E0
	mov r1,#0x0	; 0230C4E2
	bl loc_023053D8	; 0230C4E4
loc_0230C4E8:
	add r0,r5,#0x0	; 0230C4E8
loc_0230C4EA:
	add sp,#0xc	; 0230C4EA
	pop {r4,r5,r6,r7}	; 0230C4EC
	pop {r3}	; 0230C4EE
	bx r3	; 0230C4F0
	.byte 0xC0, 0x46	; 0230C4F4
pool_0230C4F4:
loc_0230C4F4:
	.word FirmwareWlWorkPointerSlot	; 0230C4F4
pool_0230C4F8:
loc_0230C4F8:
	.word 0x0000014C	; 0230C4F8
pool_0230C4FC:
loc_0230C4FC:
	.word 0x0000FFFF	; 0230C4FC
pool_0230C500:
loc_0230C500:
	.word 0x0000064C	; 0230C500
pool_0230C504:
loc_0230C504:
	.word 0x00000378	; 0230C504
pool_0230C508:
loc_0230C508:
	.word 0x0000C000	; 0230C508
pool_0230C50C:
loc_0230C50C:
	.word 0x000002E0	; 0230C50C

; ===== function loc_0230C510 =====
loc_0230C510:
	bx pc	; 0230C510
	.byte 0xC0, 0x46	; 0230C514
.arm

; ===== function loc_0230C514 =====
loc_0230C514:
	ldr pc,[pool_0230C518]	; 0230C514
pool_0230C518:
loc_0230C518:
	.word loc_037FCE4C	; 0230C518
.thumb

; ===== function loc_0230C51C =====
loc_0230C51C:
	push {r4,r5,r6,lr}	; 0230C51C
	add r6,r0,#0x0	; 0230C51E
	ldr r0,[pool_0230C59C]	; 0230C520
	ldr r1,[r0,#0x0]	; 0230C522
	ldr r0,[pool_0230C5A0]	; 0230C524
	add r0,r1,r0	; 0230C526
	mov r1,#0x5e	; 0230C528
	bl loc_02305050	; 0230C52A
	add r5,r0,#0x0	; 0230C52E
	cmp r5,#0x0	; 0230C530
	bne loc_0230C53E	; 0230C532
	mov r0,#0x2	; 0230C534
	bl loc_02305130	; 0230C536
	add r0,r5,#0x0	; 0230C53A
	b loc_0230C596	; 0230C53C
loc_0230C53E:
	ldr r0,[pool_0230C5A4]	; 0230C53E
	strh r0,[r5,#0xc]	; 0230C540
	add r5,#0x10	; 0230C542
	ldr r0,[pool_0230C59C]	; 0230C544
	ldr r1,[r0,#0x0]	; 0230C546
	ldr r0,[pool_0230C5A8]	; 0230C548
	add r0,r1,r0	; 0230C54A
	add r1,r5,#0x0	; 0230C54C
	mov r2,#0x2c	; 0230C54E
	bl loc_0230C5B4	; 0230C550
	ldr r2,[pool_0230C59C]	; 0230C554
	ldr r1,[r2,#0x0]	; 0230C556
	ldr r0,[pool_0230C5AC]	; 0230C558
	ldrh r0,[r1,r0]	; 0230C55A
	strh r0,[r5,#0x2c]	; 0230C55C
	ldr r1,[r2,#0x0]	; 0230C55E
	ldr r0,[pool_0230C5B0]	; 0230C560
	ldrh r0,[r1,r0]	; 0230C562
	strh r0,[r5,#0x2e]	; 0230C564
	add r0,r5,#0x0	; 0230C566
	add r0,#0x30	; 0230C568
	bl loc_0230BFB0	; 0230C56A
	add r4,r0,#0x0	; 0230C56E
	add r0,r5,#0x0	; 0230C570
	add r0,#0x30	; 0230C572
	add r0,r0,r4	; 0230C574
	bl loc_0230BF30	; 0230C576
	add r0,r4,r0	; 0230C57A
	add r0,r0,#0x4	; 0230C57C
	strh r0,[r5,#0x6]	; 0230C57E
	ldrh r0,[r5,#0x6]	; 0230C580
	add r0,#0x1c	; 0230C582
	strh r0,[r5,#0x12]	; 0230C584
	mov r0,#0x0	; 0230C586
	strh r0,[r5,#0x14]	; 0230C588
	add r0,r5,#0x0	; 0230C58A
	add r0,#0x18	; 0230C58C
	add r1,r6,#0x0	; 0230C58E
	bl loc_02306458	; 0230C590
	add r0,r5,#0x0	; 0230C594
loc_0230C596:
	pop {r4,r5,r6}	; 0230C596
	pop {r3}	; 0230C598
	bx r3	; 0230C59A
pool_0230C59C:
loc_0230C59C:
	.word FirmwareWlWorkPointerSlot	; 0230C59C
pool_0230C5A0:
loc_0230C5A0:
	.word 0x0000014C	; 0230C5A0
pool_0230C5A4:
loc_0230C5A4:
	.word 0x0000FFFF	; 0230C5A4
pool_0230C5A8:
loc_0230C5A8:
	.word 0x0000064C	; 0230C5A8
pool_0230C5AC:
loc_0230C5AC:
	.word 0x00000378	; 0230C5AC
pool_0230C5B0:
loc_0230C5B0:
	.word 0x0000036C	; 0230C5B0

; ===== function loc_0230C5B4 =====
loc_0230C5B4:
	bx pc	; 0230C5B4
	.byte 0xC0, 0x46	; 0230C5B8
.arm

; ===== function loc_0230C5B8 =====
loc_0230C5B8:
	ldr pc,[pool_0230C5BC]	; 0230C5B8
pool_0230C5BC:
loc_0230C5BC:
	.word loc_037FCE4C	; 0230C5BC
.thumb

; ===== function loc_0230C5C0 =====
loc_0230C5C0:
	push {r4,r5,r6,lr}	; 0230C5C0
	add r6,r0,#0x0	; 0230C5C2
	add r5,r1,#0x0	; 0230C5C4
	ldr r0,[pool_0230C61C]	; 0230C5C6
	ldr r1,[r0,#0x0]	; 0230C5C8
	ldr r0,[pool_0230C620]	; 0230C5CA
	add r0,r1,r0	; 0230C5CC
	mov r1,#0x36	; 0230C5CE
	bl loc_02305050	; 0230C5D0
	add r4,r0,#0x0	; 0230C5D4
	cmp r4,#0x0	; 0230C5D6
	bne loc_0230C5E4	; 0230C5D8
	mov r0,#0x2	; 0230C5DA
	bl loc_02305130	; 0230C5DC
	add r0,r4,#0x0	; 0230C5E0
	b loc_0230C616	; 0230C5E2
loc_0230C5E4:
	ldr r0,[pool_0230C624]	; 0230C5E4
	strh r0,[r4,#0xc]	; 0230C5E6
	add r4,#0x10	; 0230C5E8
	ldr r0,[pool_0230C61C]	; 0230C5EA
	ldr r1,[r0,#0x0]	; 0230C5EC
	ldr r0,[pool_0230C628]	; 0230C5EE
	add r0,r1,r0	; 0230C5F0
	add r1,r4,#0x0	; 0230C5F2
	mov r2,#0x2c	; 0230C5F4
	bl loc_0230C62C	; 0230C5F6
	strh r5,[r4,#0x2c]	; 0230C5FA
	mov r0,#0x2	; 0230C5FC
	strh r0,[r4,#0x6]	; 0230C5FE
	ldrh r0,[r4,#0x6]	; 0230C600
	add r0,#0x1c	; 0230C602
	strh r0,[r4,#0x12]	; 0230C604
	mov r0,#0xa0	; 0230C606
	strh r0,[r4,#0x14]	; 0230C608
	add r0,r4,#0x0	; 0230C60A
	add r0,#0x18	; 0230C60C
	add r1,r6,#0x0	; 0230C60E
	bl loc_02306458	; 0230C610
	add r0,r4,#0x0	; 0230C614
loc_0230C616:
	pop {r4,r5,r6}	; 0230C616
	pop {r3}	; 0230C618
	bx r3	; 0230C61A
pool_0230C61C:
loc_0230C61C:
	.word FirmwareWlWorkPointerSlot	; 0230C61C
pool_0230C620:
loc_0230C620:
	.word 0x0000014C	; 0230C620
pool_0230C624:
loc_0230C624:
	.word 0x0000FFFF	; 0230C624
pool_0230C628:
loc_0230C628:
	.word 0x0000064C	; 0230C628

; ===== function loc_0230C62C =====
loc_0230C62C:
	bx pc	; 0230C62C
	.byte 0xC0, 0x46	; 0230C630
.arm

; ===== function loc_0230C630 =====
loc_0230C630:
	ldr pc,[pool_0230C634]	; 0230C630
pool_0230C634:
loc_0230C634:
	.word loc_037FCE4C	; 0230C634
.thumb

; ===== function loc_0230C638 =====
loc_0230C638:
	push {r4,r5,lr}	; 0230C638
	sub sp,#0x4	; 0230C63A
	ldr r0,[pool_0230C6F0]	; 0230C63C
	ldr r1,[r0,#0x0]	; 0230C63E
	ldr r0,[pool_0230C6F4]	; 0230C640
	ldr r2,[r1,r0]	; 0230C642
	add r2,#0x24	; 0230C644
	ldr r0,[pool_0230C6F8]	; 0230C646
	ldrh r0,[r1,r0]	; 0230C648
	add r4,r2,r0	; 0230C64A
	ldr r0,[pool_0230C6FC]	; 0230C64C
	ldrh r2,[r1,r0]	; 0230C64E
	cmp r2,#0x0	; 0230C650
	beq loc_0230C692	; 0230C652
	ldr r0,[pool_0230C700]	; 0230C654
	ldrh r3,[r1,r0]	; 0230C656
	mov r0,#0x1	; 0230C658
	and r3,r0	; 0230C65A
	cmp r3,#0x0	; 0230C65C
	beq loc_0230C684	; 0230C65E
	add r0,r4,#0x0	; 0230C660
	add r0,#0xa	; 0230C662
	sub r0,r0,#0x1	; 0230C664
	ldr r3,[pool_0230C704]	; 0230C666
	ldr r1,[r1,r3]	; 0230C668
	add r2,r2,#0x2	; 0230C66A
	bl loc_02305458	; 0230C66C
	add r0,r4,#0x0	; 0230C670
	add r0,#0x9	; 0230C672
	ldr r1,[pool_0230C708]	; 0230C674
	ldrh r1,[r1,#0x0]	; 0230C676
	asr r1,r1,#0x8	; 0230C678
	lsl r1,r1,#0x18	; 0230C67A
	lsr r1,r1,#0x18	; 0230C67C
	bl loc_023053D8	; 0230C67E
	b loc_0230C692	; 0230C682
loc_0230C684:
	add r0,r4,#0x0	; 0230C684
	add r0,#0xa	; 0230C686
	ldr r3,[pool_0230C704]	; 0230C688
	ldr r1,[r1,r3]	; 0230C68A
	add r2,r2,#0x1	; 0230C68C
	bl loc_02305458	; 0230C68E
loc_0230C692:
	ldr r1,[pool_0230C6F0]	; 0230C692
	ldr r0,[r1,#0x0]	; 0230C694
	ldr r2,[pool_0230C6F8]	; 0230C696
	ldrh r5,[r0,r2]	; 0230C698
	add r5,#0x26	; 0230C69A
	ldr r3,[pool_0230C6FC]	; 0230C69C
	ldrh r2,[r0,r3]	; 0230C69E
	add r5,r5,r2	; 0230C6A0
	ldr r2,[pool_0230C6F4]	; 0230C6A2
	ldr r0,[r0,r2]	; 0230C6A4
	strh r5,[r0,#0xa]	; 0230C6A6
	add r0,r4,#0x1	; 0230C6A8
	ldr r1,[r1,#0x0]	; 0230C6AA
	ldrh r1,[r1,r3]	; 0230C6AC
	add r1,#0x8	; 0230C6AE
	lsl r1,r1,#0x18	; 0230C6B0
	lsr r1,r1,#0x18	; 0230C6B2
	bl loc_023053D8	; 0230C6B4
	ldr r0,[pool_0230C6F0]	; 0230C6B8
	ldr r2,[r0,#0x0]	; 0230C6BA
	ldr r0,[pool_0230C70C]	; 0230C6BC
	ldrh r1,[r2,r0]	; 0230C6BE
	mov r0,#0x4	; 0230C6C0
	and r1,r0	; 0230C6C2
	cmp r1,#0x0	; 0230C6C4
	beq loc_0230C6DC	; 0230C6C6
	add r4,#0xd	; 0230C6C8
	ldr r0,[pool_0230C6FC]	; 0230C6CA
	ldrh r0,[r2,r0]	; 0230C6CC
	add r1,r4,r0	; 0230C6CE
	mov r0,#0x3	; 0230C6D0
	bic r1,r0	; 0230C6D2
	ldr r0,[pool_0230C710]	; 0230C6D4
	strh r0,[r1,#0x0]	; 0230C6D6
	ldr r0,[pool_0230C714]	; 0230C6D8
	strh r0,[r1,#0x2]	; 0230C6DA
loc_0230C6DC:
	mov r2,#0x0	; 0230C6DC
	ldr r0,[pool_0230C6F0]	; 0230C6DE
	ldr r1,[r0,#0x0]	; 0230C6E0
	ldr r0,[pool_0230C718]	; 0230C6E2
	strh r2,[r1,r0]	; 0230C6E4
	add sp,#0x4	; 0230C6E6
	pop {r4,r5}	; 0230C6E8
	pop {r3}	; 0230C6EA
	bx r3	; 0230C6EC
	.byte 0xC0, 0x46	; 0230C6F0
pool_0230C6F0:
loc_0230C6F0:
	.word FirmwareWlWorkPointerSlot	; 0230C6F0
pool_0230C6F4:
loc_0230C6F4:
	.word 0x00000464	; 0230C6F4
pool_0230C6F8:
loc_0230C6F8:
	.word 0x00000392	; 0230C6F8
pool_0230C6FC:
loc_0230C6FC:
	.word 0x0000039C	; 0230C6FC
pool_0230C700:
loc_0230C700:
	.word 0x0000039E	; 0230C700
pool_0230C704:
loc_0230C704:
	.word 0x00000398	; 0230C704
pool_0230C708:
loc_0230C708:
	.word FirmwareWlAdjustedTimeSlot	; 0230C708
pool_0230C70C:
loc_0230C70C:
	.word 0x0000061C	; 0230C70C
pool_0230C710:
loc_0230C710:
	.word 0x0000B6B8	; 0230C710
pool_0230C714:
loc_0230C714:
	.word 0x00001D46	; 0230C714
pool_0230C718:
loc_0230C718:
	.word 0x000003A0	; 0230C718

; ===== function loc_0230C71C =====
loc_0230C71C:
	push {r4,r5,r6,r7,lr}	; 0230C71C
	sub sp,#0xc	; 0230C71E
	ldr r0,[pool_0230C9D0]	; 0230C720
	ldr r1,[r0,#0x0]	; 0230C722
	ldr r0,[pool_0230C9D4]	; 0230C724
	ldr r7,[r1,r0]	; 0230C726
	mov r0,#0x0	; 0230C728
	strh r0,[r7,#0x0]	; 0230C72A
	strh r0,[r7,#0x2]	; 0230C72C
	strh r0,[r7,#0x4]	; 0230C72E
	strh r0,[r7,#0x6]	; 0230C730
	bl loc_02306028	; 0230C732
	strh r0,[r7,#0x8]	; 0230C736
	mov r0,#0x80	; 0230C738
	strh r0,[r7,#0xc]	; 0230C73A
	mov r0,#0x0	; 0230C73C
	strh r0,[r7,#0xe]	; 0230C73E
	ldr r0,[pool_0230C9D0]	; 0230C740
	ldr r3,[r0,#0x0]	; 0230C742
	add r0,r7,#0x0	; 0230C744
	add r0,#0x10	; 0230C746
	ldr r1,[pool_0230C9D8]	; 0230C748
	ldr r2,[pool_0230C9DC]	; 0230C74A
	add r2,r3,r2	; 0230C74C
	add r3,r2,#0x0	; 0230C74E
	bl loc_02306410	; 0230C750
	mov r1,#0x0	; 0230C754
	strh r1,[r7,#0x22]	; 0230C756
	add r5,r7,#0x0	; 0230C758
	add r5,#0x24	; 0230C75A
	str r1,[r5,#0x0]	; 0230C75C
	str r1,[r5,#0x4]	; 0230C75E
	ldr r0,[pool_0230C9D0]	; 0230C760
	ldr r3,[r0,#0x0]	; 0230C762
	ldr r2,[pool_0230C9E0]	; 0230C764
	ldrh r2,[r3,r2]	; 0230C766
	strh r2,[r5,#0x8]	; 0230C768
	ldr r3,[r0,#0x0]	; 0230C76A
	ldr r2,[pool_0230C9E4]	; 0230C76C
	ldrh r2,[r3,r2]	; 0230C76E
	strh r2,[r5,#0xa]	; 0230C770
	add r4,r5,#0x0	; 0230C772
	add r4,#0xc	; 0230C774
	ldr r0,[r0,#0x0]	; 0230C776
	ldr r2,[pool_0230C9E8]	; 0230C778
	ldrh r2,[r0,r2]	; 0230C77A
	lsl r2,r2,#0x1f	; 0230C77C
	lsr r2,r2,#0x1f	; 0230C77E
	cmp r2,#0x0	; 0230C780
	bne loc_0230C7DC	; 0230C782
	sub r3,r4,r5	; 0230C784
	ldr r2,[pool_0230C9EC]	; 0230C786
	strh r3,[r0,r2]	; 0230C788
	add r0,r4,#0x0	; 0230C78A
	bl loc_023053D8	; 0230C78C
	add r0,r4,#0x1	; 0230C790
	add r4,r4,#0x2	; 0230C792
	ldr r1,[pool_0230C9D0]	; 0230C794
	ldr r2,[r1,#0x0]	; 0230C796
	ldr r1,[pool_0230C9F0]	; 0230C798
	ldrh r1,[r2,r1]	; 0230C79A
	lsl r1,r1,#0x18	; 0230C79C
	lsr r1,r1,#0x18	; 0230C79E
	bl loc_023053D8	; 0230C7A0
	mov r6,#0x0	; 0230C7A4
	b loc_0230C7BE	; 0230C7A6
loc_0230C7A8:
	ldr r1,[pool_0230C9F4]	; 0230C7A8
	add r0,r0,r1	; 0230C7AA
	add r0,r0,r6	; 0230C7AC
	bl loc_023053B4	; 0230C7AE
	add r1,r0,#0x0	; 0230C7B2
	add r0,r4,#0x0	; 0230C7B4
	bl loc_023053D8	; 0230C7B6
	add r4,r4,#0x1	; 0230C7BA
	add r6,r6,#0x1	; 0230C7BC
loc_0230C7BE:
	ldr r0,[pool_0230C9D0]	; 0230C7BE
	ldr r0,[r0,#0x0]	; 0230C7C0
	ldr r1,[pool_0230C9F0]	; 0230C7C2
	ldrh r1,[r0,r1]	; 0230C7C4
	cmp r6,r1	; 0230C7C6
	bcc loc_0230C7A8	; 0230C7C8
	mov r0,#0x0	; 0230C7CA
	mvn r0,r0	; 0230C7CC
	sub r0,r0,r6	; 0230C7CE
	add r0,r4,r0	; 0230C7D0
	lsl r1,r6,#0x18	; 0230C7D2
	lsr r1,r1,#0x18	; 0230C7D4
	bl loc_023053D8	; 0230C7D6
	b loc_0230C7E0	; 0230C7DA
loc_0230C7DC:
	ldr r2,[pool_0230C9EC]	; 0230C7DC
	strh r1,[r0,r2]	; 0230C7DE
loc_0230C7E0:
	add r0,r4,#0x0	; 0230C7E0
	bl loc_0230BF30	; 0230C7E2
	add r4,r4,r0	; 0230C7E6
	add r0,r4,#0x0	; 0230C7E8
	mov r1,#0x3	; 0230C7EA
	bl loc_023053D8	; 0230C7EC
	add r0,r4,#0x1	; 0230C7F0
	mov r1,#0x1	; 0230C7F2
	bl loc_023053D8	; 0230C7F4
	add r0,r4,#0x2	; 0230C7F8
	ldr r1,[pool_0230C9D0]	; 0230C7FA
	ldr r2,[r1,#0x0]	; 0230C7FC
	ldr r1,[pool_0230C9F8]	; 0230C7FE
	ldrh r1,[r2,r1]	; 0230C800
	lsl r1,r1,#0x18	; 0230C802
	lsr r1,r1,#0x18	; 0230C804
	bl loc_023053D8	; 0230C806
	add r2,r4,#0x3	; 0230C80A
	sub r3,r2,r5	; 0230C80C
	ldr r1,[pool_0230C9D0]	; 0230C80E
	ldr r0,[r1,#0x0]	; 0230C810
	ldr r6,[pool_0230C9FC]	; 0230C812
	strh r3,[r0,r6]	; 0230C814
	ldr r0,[r1,#0x0]	; 0230C816
	ldrh r0,[r0,r6]	; 0230C818
	add r1,r0,#0x2	; 0230C81A
	ldr r0,[pool_0230CA00]	; 0230C81C
	strh r1,[r0,#0x0]	; 0230C81E
	add r0,r2,#0x0	; 0230C820
	mov r1,#0x5	; 0230C822
	bl loc_023053D8	; 0230C824
	add r0,r4,#0x4	; 0230C828
	mov r1,#0x5	; 0230C82A
	bl loc_023053D8	; 0230C82C
	add r0,r4,#0x5	; 0230C830
	mov r1,#0x0	; 0230C832
	bl loc_023053D8	; 0230C834
	add r0,r4,#0x6	; 0230C838
	ldr r1,[pool_0230C9D0]	; 0230C83A
	ldr r2,[r1,#0x0]	; 0230C83C
	ldr r1,[pool_0230CA04]	; 0230C83E
	ldrh r1,[r2,r1]	; 0230C840
	lsl r1,r1,#0x18	; 0230C842
	lsr r1,r1,#0x18	; 0230C844
	bl loc_023053D8	; 0230C846
	add r0,r4,#0x7	; 0230C84A
	mov r1,#0x0	; 0230C84C
	bl loc_023053D8	; 0230C84E
	add r0,r4,#0x0	; 0230C852
	add r0,#0x8	; 0230C854
	mov r1,#0x0	; 0230C856
	bl loc_023053D8	; 0230C858
	add r0,r4,#0x0	; 0230C85C
	add r0,#0x9	; 0230C85E
	mov r1,#0x0	; 0230C860
	bl loc_023053D8	; 0230C862
	add r2,r4,#0x0	; 0230C866
	add r2,#0xa	; 0230C868
	sub r3,r2,r5	; 0230C86A
	ldr r1,[pool_0230C9D0]	; 0230C86C
	ldr r0,[r1,#0x0]	; 0230C86E
	ldr r6,[pool_0230CA08]	; 0230C870
	strh r3,[r0,r6]	; 0230C872
	ldr r1,[r1,#0x0]	; 0230C874
	ldrh r0,[r1,r6]	; 0230C876
	mov r3,#0x1	; 0230C878
	and r0,r3	; 0230C87A
	ldr r3,[pool_0230CA0C]	; 0230C87C
	strh r0,[r1,r3]	; 0230C87E
	add r0,r2,#0x0	; 0230C880
	mov r1,#0xdd	; 0230C882
	bl loc_023053D8	; 0230C884
	add r0,r4,#0x0	; 0230C888
	add r0,#0xb	; 0230C88A
	ldr r1,[pool_0230C9D0]	; 0230C88C
	ldr r2,[r1,#0x0]	; 0230C88E
	ldr r1,[pool_0230CA10]	; 0230C890
	ldrh r1,[r2,r1]	; 0230C892
	add r1,#0x8	; 0230C894
	lsl r1,r1,#0x18	; 0230C896
	lsr r1,r1,#0x18	; 0230C898
	bl loc_023053D8	; 0230C89A
	add r0,r4,#0x0	; 0230C89E
	add r0,#0xc	; 0230C8A0
	mov r1,#0x0	; 0230C8A2
	bl loc_023053D8	; 0230C8A4
	add r0,r4,#0x0	; 0230C8A8
	add r0,#0xd	; 0230C8AA
	mov r1,#0x9	; 0230C8AC
	bl loc_023053D8	; 0230C8AE
	add r0,r4,#0x0	; 0230C8B2
	add r0,#0xe	; 0230C8B4
	mov r1,#0xbf	; 0230C8B6
	bl loc_023053D8	; 0230C8B8
	add r0,r4,#0x0	; 0230C8BC
	add r0,#0xf	; 0230C8BE
	mov r1,#0x0	; 0230C8C0
	bl loc_023053D8	; 0230C8C2
	ldr r0,[pool_0230C9D0]	; 0230C8C6
	ldr r1,[r0,#0x0]	; 0230C8C8
	ldr r0,[pool_0230CA14]	; 0230C8CA
	ldrh r0,[r1,r0]	; 0230C8CC
	lsl r0,r0,#0x1f	; 0230C8CE
	lsr r0,r0,#0x1f	; 0230C8D0
	cmp r0,#0x1	; 0230C8D2
	bne loc_0230C900	; 0230C8D4
	add r0,r4,#0x0	; 0230C8D6
	add r0,#0x10	; 0230C8D8
	ldr r2,[pool_0230CA18]	; 0230C8DA
	ldrh r1,[r1,r2]	; 0230C8DC
	lsl r1,r1,#0x18	; 0230C8DE
	lsr r1,r1,#0x18	; 0230C8E0
	bl loc_023053D8	; 0230C8E2
	add r0,r4,#0x0	; 0230C8E6
	add r0,#0x11	; 0230C8E8
	add r4,#0x12	; 0230C8EA
	ldr r1,[pool_0230C9D0]	; 0230C8EC
	ldr r2,[r1,#0x0]	; 0230C8EE
	ldr r1,[pool_0230CA18]	; 0230C8F0
	ldrh r1,[r2,r1]	; 0230C8F2
	asr r1,r1,#0x8	; 0230C8F4
	lsl r1,r1,#0x18	; 0230C8F6
	lsr r1,r1,#0x18	; 0230C8F8
	bl loc_023053D8	; 0230C8FA
	b loc_0230C916	; 0230C8FE
loc_0230C900:
	add r0,r4,#0x0	; 0230C900
	add r0,#0x10	; 0230C902
	mov r1,#0xff	; 0230C904
	bl loc_023053D8	; 0230C906
	add r0,r4,#0x0	; 0230C90A
	add r0,#0x11	; 0230C90C
	add r4,#0x12	; 0230C90E
	mov r1,#0xff	; 0230C910
	bl loc_023053D8	; 0230C912
loc_0230C916:
	ldr r0,[pool_0230CA1C]	; 0230C916
	ldrh r6,[r0,#0x0]	; 0230C918
	add r0,r4,#0x0	; 0230C91A
	lsl r1,r6,#0x18	; 0230C91C
	lsr r1,r1,#0x18	; 0230C91E
	bl loc_023053D8	; 0230C920
	add r0,r4,#0x1	; 0230C924
	add r4,r4,#0x2	; 0230C926
	lsr r1,r6,#0x8	; 0230C928
	lsl r1,r1,#0x18	; 0230C92A
	lsr r1,r1,#0x18	; 0230C92C
	bl loc_023053D8	; 0230C92E
	ldr r0,[pool_0230C9D0]	; 0230C932
	ldr r1,[r0,#0x0]	; 0230C934
	ldr r0,[pool_0230CA20]	; 0230C936
	ldr r0,[r1,r0]	; 0230C938
	str r0,[sp,#0x0]	; 0230C93A
	mov r6,#0x0	; 0230C93C
	b loc_0230C958	; 0230C93E
loc_0230C940:
	ldr r0,[sp,#0x0]	; 0230C940
	bl loc_023053B4	; 0230C942
	add r1,r0,#0x0	; 0230C946
	add r0,r4,#0x0	; 0230C948
	bl loc_023053D8	; 0230C94A
	add r4,r4,#0x1	; 0230C94E
	ldr r0,[sp,#0x0]	; 0230C950
	add r0,r0,#0x1	; 0230C952
	str r0,[sp,#0x0]	; 0230C954
	add r6,r6,#0x1	; 0230C956
loc_0230C958:
	ldr r0,[pool_0230C9D0]	; 0230C958
	ldr r1,[r0,#0x0]	; 0230C95A
	ldr r0,[pool_0230CA10]	; 0230C95C
	ldrh r0,[r1,r0]	; 0230C95E
	cmp r6,r0	; 0230C960
	bcc loc_0230C940	; 0230C962
	ldr r2,[pool_0230CA0C]	; 0230C964
	ldrh r2,[r1,r2]	; 0230C966
	cmp r2,#0x0	; 0230C968
	beq loc_0230C99E	; 0230C96A
	ldr r2,[pool_0230CA20]	; 0230C96C
	ldr r1,[r1,r2]	; 0230C96E
	add r0,r1,r0	; 0230C970
	sub r6,r0,#0x1	; 0230C972
	mov r0,#0x0	; 0230C974
	str r0,[sp,#0x4]	; 0230C976
	b loc_0230C990	; 0230C978
loc_0230C97A:
	add r0,r6,#0x0	; 0230C97A
	bl loc_023053B4	; 0230C97C
	add r1,r0,#0x0	; 0230C980
	add r0,r6,#0x1	; 0230C982
	bl loc_023053D8	; 0230C984
	ldr r0,[sp,#0x4]	; 0230C988
	add r0,r0,#0x1	; 0230C98A
	str r0,[sp,#0x4]	; 0230C98C
	sub r6,r6,#0x1	; 0230C98E
loc_0230C990:
	ldr r0,[pool_0230C9D0]	; 0230C990
	ldr r1,[r0,#0x0]	; 0230C992
	ldr r0,[pool_0230CA10]	; 0230C994
	ldrh r2,[r1,r0]	; 0230C996
	ldr r0,[sp,#0x4]	; 0230C998
	cmp r0,r2	; 0230C99A
	bcc loc_0230C97A	; 0230C99C
loc_0230C99E:
	ldr r0,[pool_0230CA24]	; 0230C99E
	ldrh r1,[r1,r0]	; 0230C9A0
	mov r0,#0x4	; 0230C9A2
	and r1,r0	; 0230C9A4
	cmp r1,#0x0	; 0230C9A6
	beq loc_0230C9B8	; 0230C9A8
	add r1,r4,#0x3	; 0230C9AA
	mov r0,#0x3	; 0230C9AC
	bic r1,r0	; 0230C9AE
	ldr r0,[pool_0230CA28]	; 0230C9B0
	strh r0,[r1,#0x0]	; 0230C9B2
	ldr r0,[pool_0230CA2C]	; 0230C9B4
	strh r0,[r1,#0x2]	; 0230C9B6
loc_0230C9B8:
	mov r2,#0x0	; 0230C9B8
	ldr r0,[pool_0230C9D0]	; 0230C9BA
	ldr r1,[r0,#0x0]	; 0230C9BC
	ldr r0,[pool_0230CA30]	; 0230C9BE
	strh r2,[r1,r0]	; 0230C9C0
	add r4,#0x1c	; 0230C9C2
	sub r0,r4,r5	; 0230C9C4
	strh r0,[r7,#0xa]	; 0230C9C6
	add sp,#0xc	; 0230C9C8
	pop {r4,r5,r6,r7}	; 0230C9CA
	pop {r3}	; 0230C9CC
	bx r3	; 0230C9CE
pool_0230C9D0:
loc_0230C9D0:
	.word FirmwareWlWorkPointerSlot	; 0230C9D0
pool_0230C9D4:
loc_0230C9D4:
	.word 0x00000464	; 0230C9D4
pool_0230C9D8:
loc_0230C9D8:
	.word 0x02310378	; 0230C9D8
pool_0230C9DC:
loc_0230C9DC:
	.word 0x000002E8	; 0230C9DC
pool_0230C9E0:
loc_0230C9E0:
	.word 0x0000036A	; 0230C9E0
pool_0230C9E4:
loc_0230C9E4:
	.word 0x00000378	; 0230C9E4
pool_0230C9E8:
loc_0230C9E8:
	.word 0x000002FE	; 0230C9E8
pool_0230C9EC:
loc_0230C9EC:
	.word 0x0000038E	; 0230C9EC
pool_0230C9F0:
loc_0230C9F0:
	.word 0x0000031A	; 0230C9F0
pool_0230C9F4:
loc_0230C9F4:
	.word 0x0000031C	; 0230C9F4
pool_0230C9F8:
loc_0230C9F8:
	.word 0x00000376	; 0230C9F8
pool_0230C9FC:
loc_0230C9FC:
	.word 0x00000390	; 0230C9FC
pool_0230CA00:
loc_0230CA00:
	.word REG_WIFI_TXBUF_TIM	; 0230CA00
pool_0230CA04:
loc_0230CA04:
	.word 0x00000370	; 0230CA04
pool_0230CA08:
loc_0230CA08:
	.word 0x00000392	; 0230CA08
pool_0230CA0C:
loc_0230CA0C:
	.word 0x0000039E	; 0230CA0C
pool_0230CA10:
loc_0230CA10:
	.word 0x0000039C	; 0230CA10
pool_0230CA14:
loc_0230CA14:
	.word 0x00000316	; 0230CA14
pool_0230CA18:
loc_0230CA18:
	.word 0x00000300	; 0230CA18
pool_0230CA1C:
loc_0230CA1C:
	.word FirmwareWlAdjustedTimeSlot	; 0230CA1C
pool_0230CA20:
loc_0230CA20:
	.word 0x00000398	; 0230CA20
pool_0230CA24:
loc_0230CA24:
	.word 0x0000061C	; 0230CA24
pool_0230CA28:
loc_0230CA28:
	.word 0x0000B6B8	; 0230CA28
pool_0230CA2C:
loc_0230CA2C:
	.word 0x00001D46	; 0230CA2C
pool_0230CA30:
loc_0230CA30:
	.word 0x000003A0	; 0230CA30

; ===== function loc_0230CA34 =====
loc_0230CA34:
	ldr r0,[pool_0230CA44]	; 0230CA34
	ldr r3,[r0,#0x0]	; 0230CA36
	ldr r0,[pool_0230CA48]	; 0230CA38
	mov r2,#0x0	; 0230CA3A
	ldr r1,[pool_0230CA4C]	; 0230CA3C
	strh r2,[r1,#0x0]	; 0230CA3E
	strh r2,[r3,r0]	; 0230CA40
	bx lr	; 0230CA42
pool_0230CA44:
loc_0230CA44:
	.word FirmwareWlWorkPointerSlot	; 0230CA44
pool_0230CA48:
loc_0230CA48:
	.word 0x0000045C	; 0230CA48
pool_0230CA4C:
loc_0230CA4C:
	.word REG_WIFI_TXBUF_BEACON	; 0230CA4C

; ===== function loc_0230CA50 =====
loc_0230CA50:
	ldr r0,[pool_0230CA70]	; 0230CA50
	ldr r1,[r0,#0x0]	; 0230CA52
	ldr r0,[pool_0230CA74]	; 0230CA54
	add r1,r1,r0	; 0230CA56
	mov r0,#0x1	; 0230CA58
	strh r0,[r1,#0x0]	; 0230CA5A
	ldr r1,[r1,#0x8]	; 0230CA5C
	ldr r0,[pool_0230CA78]	; 0230CA5E
	and r1,r0	; 0230CA60
	lsr r1,r1,#0x1	; 0230CA62
	ldr r0,[pool_0230CA7C]	; 0230CA64
	orr r1,r0	; 0230CA66
	ldr r0,[pool_0230CA80]	; 0230CA68
	strh r1,[r0,#0x0]	; 0230CA6A
	bx lr	; 0230CA6C
	.byte 0xC0, 0x46	; 0230CA70
pool_0230CA70:
loc_0230CA70:
	.word FirmwareWlWorkPointerSlot	; 0230CA70
pool_0230CA74:
loc_0230CA74:
	.word 0x0000045C	; 0230CA74
pool_0230CA78:
loc_0230CA78:
	.word 0x00003FFF	; 0230CA78
pool_0230CA7C:
loc_0230CA7C:
	.word 0x00008000	; 0230CA7C
pool_0230CA80:
loc_0230CA80:
	.word REG_WIFI_TXBUF_BEACON	; 0230CA80

; ===== function loc_0230CA84 =====
loc_0230CA84:
	push {r4,lr}	; 0230CA84
	ldr r0,[pool_0230CAD4]	; 0230CA86
	ldr r1,[r0,#0x0]	; 0230CA88
	ldr r0,[pool_0230CAD8]	; 0230CA8A
	add r4,r1,r0	; 0230CA8C
	ldr r0,[pool_0230CADC]	; 0230CA8E
	add r1,r1,r0	; 0230CA90
	ldrh r0,[r1,#0x0]	; 0230CA92
	add r0,r0,#0x1	; 0230CA94
	strh r0,[r1,#0x0]	; 0230CA96
	ldrh r0,[r4,#0x0]	; 0230CA98
	cmp r0,#0x0	; 0230CA9A
	beq loc_0230CAA6	; 0230CA9C
	mov r1,#0x0	; 0230CA9E
	ldr r0,[r4,#0x8]	; 0230CAA0
	strh r1,[r0,#0x4]	; 0230CAA2
	b loc_0230CACE	; 0230CAA4
loc_0230CAA6:
	mov r0,#0x1	; 0230CAA6
	strh r0,[r4,#0x0]	; 0230CAA8
	mov r1,#0x0	; 0230CAAA
	ldr r0,[r4,#0x8]	; 0230CAAC
	strh r1,[r0,#0x0]	; 0230CAAE
	ldr r0,[r4,#0x8]	; 0230CAB0
	strh r1,[r0,#0x4]	; 0230CAB2
	bl loc_02306028	; 0230CAB4
	ldr r1,[r4,#0x8]	; 0230CAB8
	strh r0,[r1,#0x8]	; 0230CABA
	ldr r1,[r4,#0x8]	; 0230CABC
	ldr r0,[pool_0230CAE0]	; 0230CABE
	and r1,r0	; 0230CAC0
	lsl r0,r1,#0xf	; 0230CAC2
	lsr r1,r0,#0x10	; 0230CAC4
	ldr r0,[pool_0230CAE4]	; 0230CAC6
	orr r1,r0	; 0230CAC8
	ldr r0,[pool_0230CAE8]	; 0230CACA
	strh r1,[r0,#0x0]	; 0230CACC
loc_0230CACE:
	pop {r4}	; 0230CACE
	pop {r3}	; 0230CAD0
	bx r3	; 0230CAD2
pool_0230CAD4:
loc_0230CAD4:
	.word FirmwareWlWorkPointerSlot	; 0230CAD4
pool_0230CAD8:
loc_0230CAD8:
	.word 0x0000040C	; 0230CAD8
pool_0230CADC:
loc_0230CADC:
	.word 0x0000040E	; 0230CADC
pool_0230CAE0:
loc_0230CAE0:
	.word 0x00003FFF	; 0230CAE0
pool_0230CAE4:
loc_0230CAE4:
	.word 0x00008000	; 0230CAE4
pool_0230CAE8:
loc_0230CAE8:
	.word REG_WIFI_TXBUF_LOC3	; 0230CAE8

; ===== function loc_0230CAEC =====
loc_0230CAEC:
	push {r4,lr}	; 0230CAEC
	add r4,r0,#0x0	; 0230CAEE
	add r0,#0x18	; 0230CAF0
	bl loc_0230949C	; 0230CAF2
	strh r0,[r4,#0x2]	; 0230CAF6
	ldrh r0,[r4,#0x2]	; 0230CAF8
	cmp r0,#0xff	; 0230CAFA
	bne loc_0230CB02	; 0230CAFC
	mov r0,#0x0	; 0230CAFE
	strh r0,[r4,#0x2]	; 0230CB00
loc_0230CB02:
	ldr r0,[pool_0230CB48]	; 0230CB02
	ldr r1,[r0,#0x0]	; 0230CB04
	ldr r0,[pool_0230CB4C]	; 0230CB06
	ldr r0,[r1,r0]	; 0230CB08
	strh r0,[r4,#0x4]	; 0230CB0A
	ldrh r1,[r4,#0x14]	; 0230CB0C
	ldr r0,[pool_0230CB50]	; 0230CB0E
	and r1,r0	; 0230CB10
	cmp r1,#0x0	; 0230CB12
	beq loc_0230CB20	; 0230CB14
	add r1,r4,#0x0	; 0230CB16
	add r1,#0x12	; 0230CB18
	ldrh r0,[r1,#0x0]	; 0230CB1A
	add r0,#0x8	; 0230CB1C
	strh r0,[r1,#0x0]	; 0230CB1E
loc_0230CB20:
	add r0,r4,#0x0	; 0230CB20
	bl loc_02309310	; 0230CB22
	ldr r0,[pool_0230CB48]	; 0230CB26
	ldr r2,[r0,#0x0]	; 0230CB28
	ldr r0,[pool_0230CB54]	; 0230CB2A
	add r0,r2,r0	; 0230CB2C
	ldr r1,[pool_0230CB58]	; 0230CB2E
	add r1,r2,r1	; 0230CB30
	sub r4,#0x10	; 0230CB32
	add r2,r4,#0x0	; 0230CB34
	bl loc_02304FA8	; 0230CB36
	mov r0,#0x1	; 0230CB3A
	bl loc_0230D670	; 0230CB3C
	pop {r4}	; 0230CB40
	pop {r3}	; 0230CB42
	bx r3	; 0230CB44
	.byte 0xC0, 0x46	; 0230CB48
pool_0230CB48:
loc_0230CB48:
	.word FirmwareWlWorkPointerSlot	; 0230CB48
pool_0230CB4C:
loc_0230CB4C:
	.word 0x000003A4	; 0230CB4C
pool_0230CB50:
loc_0230CB50:
	.word 0x00004000	; 0230CB50
pool_0230CB54:
loc_0230CB54:
	.word 0x0000014C	; 0230CB54
pool_0230CB58:
loc_0230CB58:
	.word 0x00000164	; 0230CB58

; ===== function loc_0230CB5C =====
loc_0230CB5C:
	push {r4,r5,r6,r7,lr}	; 0230CB5C
	sub sp,#0xc	; 0230CB5E
	add r7,r0,#0x0	; 0230CB60
	str r1,[sp,#0x0]	; 0230CB62
	mov r0,#0xc	; 0230CB64
	add r4,r7,#0x0	; 0230CB66
	mul r4,r0	; 0230CB68
	ldr r0,[pool_0230CBC0]	; 0230CB6A
	ldr r0,[r0,#0x0]	; 0230CB6C
	add r1,r0,r4	; 0230CB6E
	ldr r0,[pool_0230CBC4]	; 0230CB70
	ldr r5,[r1,r0]	; 0230CB72
	mov r0,#0x0	; 0230CB74
	mvn r0,r0	; 0230CB76
	cmp r5,r0	; 0230CB78
	beq loc_0230CBB8	; 0230CB7A
loc_0230CB7C:
	add r0,r5,#0x0	; 0230CB7C
	bl loc_02304E5C	; 0230CB7E
	str r0,[sp,#0x4]	; 0230CB82
	add r6,r5,#0x0	; 0230CB84
	add r6,#0x10	; 0230CB86
	cmp r7,#0x2	; 0230CB88
	beq loc_0230CB92	; 0230CB8A
	add r0,r6,#0x0	; 0230CB8C
	bl loc_023092B8	; 0230CB8E
loc_0230CB92:
	mov r0,#0x2	; 0230CB92
	strh r0,[r6,#0x8]	; 0230CB94
	ldr r0,[sp,#0x0]	; 0230CB96
	cmp r0,#0x0	; 0230CB98
	beq loc_0230CBAC	; 0230CB9A
	ldr r0,[pool_0230CBC0]	; 0230CB9C
	ldr r1,[r0,#0x0]	; 0230CB9E
	ldr r0,[pool_0230CBC4]	; 0230CBA0
	add r0,r1,r0	; 0230CBA2
	add r0,r0,r4	; 0230CBA4
	add r1,r5,#0x0	; 0230CBA6
	bl loc_0230B1AC	; 0230CBA8
loc_0230CBAC:
	ldr r5,[sp,#0x4]	; 0230CBAC
	mov r0,#0x0	; 0230CBAE
	mvn r1,r0	; 0230CBB0
	lsl r0,r5,#0	; 0230CBB2
	cmp r0,r1	; 0230CBB4
	bne loc_0230CB7C	; 0230CBB6
loc_0230CBB8:
	add sp,#0xc	; 0230CBB8
	pop {r4,r5,r6,r7}	; 0230CBBA
	pop {r3}	; 0230CBBC
	bx r3	; 0230CBBE
pool_0230CBC0:
loc_0230CBC0:
	.word FirmwareWlWorkPointerSlot	; 0230CBC0
pool_0230CBC4:
loc_0230CBC4:
	.word 0x00000158	; 0230CBC4

; ===== function loc_0230CBC8 =====
loc_0230CBC8:
	push {lr}	; 0230CBC8
	sub sp,#0x4	; 0230CBCA
	ldr r0,[pool_0230CC34]	; 0230CBCC
	ldr r1,[r0,#0x0]	; 0230CBCE
	ldr r0,[pool_0230CC38]	; 0230CBD0
	ldrh r0,[r1,r0]	; 0230CBD2
	cmp r0,#0x1	; 0230CBD4
	beq loc_0230CBE2	; 0230CBD6
	cmp r0,#0x2	; 0230CBD8
	beq loc_0230CBFC	; 0230CBDA
	cmp r0,#0x3	; 0230CBDC
	beq loc_0230CBFC	; 0230CBDE
	b loc_0230CC16	; 0230CBE0
loc_0230CBE2:
	mov r0,#0x0	; 0230CBE2
	mov r1,#0x1	; 0230CBE4
	bl loc_0230CB5C	; 0230CBE6
	mov r0,#0x1	; 0230CBEA
	mov r1,#0x0	; 0230CBEC
	bl loc_0230CB5C	; 0230CBEE
	mov r0,#0x2	; 0230CBF2
	mov r1,#0x1	; 0230CBF4
	bl loc_0230CB5C	; 0230CBF6
	b loc_0230CC2E	; 0230CBFA
loc_0230CBFC:
	mov r0,#0x0	; 0230CBFC
	mov r1,#0x1	; 0230CBFE
	bl loc_0230CB5C	; 0230CC00
	mov r0,#0x1	; 0230CC04
	mov r1,#0x0	; 0230CC06
	bl loc_0230CB5C	; 0230CC08
	mov r0,#0x2	; 0230CC0C
	mov r1,#0x0	; 0230CC0E
	bl loc_0230CB5C	; 0230CC10
	b loc_0230CC2E	; 0230CC14
loc_0230CC16:
	mov r0,#0x0	; 0230CC16
	add r1,r0,#0x0	; 0230CC18
	bl loc_0230CB5C	; 0230CC1A
	mov r0,#0x1	; 0230CC1E
	mov r1,#0x0	; 0230CC20
	bl loc_0230CB5C	; 0230CC22
	mov r0,#0x2	; 0230CC26
	mov r1,#0x0	; 0230CC28
	bl loc_0230CB5C	; 0230CC2A
loc_0230CC2E:
	add sp,#0x4	; 0230CC2E
	pop {r3}	; 0230CC30
	bx r3	; 0230CC32
pool_0230CC34:
loc_0230CC34:
	.word FirmwareWlWorkPointerSlot	; 0230CC34
pool_0230CC38:
loc_0230CC38:
	.word 0x00000314	; 0230CC38
	.byte 0x70, 0xB5, 0x01, 0x88, 0x01, 0x25, 0x29, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x0A, 0x4C, 0x0B, 0x4E	; 0230CC4C
	.byte 0x03, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0x14, 0xF8, 0x6D, 0x1C, 0x20, 0x68, 0x80, 0x5B, 0x85, 0x42	; 0230CC5C
	.byte 0xF7, 0xD3, 0x05, 0xE0, 0xFC, 0xF7, 0x1C, 0xFC, 0xFF, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x08, 0xF8	; 0230CC6C
	.byte 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xE6, 0x02, 0x00, 0x00	; 0230CC7C

; ===== function loc_0230CC7C =====
loc_0230CC7C:
	push {r4,r5,r6,r7,lr}	; 0230CC7C
	sub sp,#0x14	; 0230CC7E
	add r7,r0,#0x0	; 0230CC80
	mov r4,#0x0	; 0230CC82
	ldr r0,[pool_0230CD24]	; 0230CC84
	ldr r1,[r0,#0x0]	; 0230CC86
	ldr r0,[pool_0230CD28]	; 0230CC88
	ldr r2,[r1,r0]	; 0230CC8A
	mov r0,#0x1c	; 0230CC8C
	add r1,r7,#0x0	; 0230CC8E
	mul r1,r0	; 0230CC90
	add r0,r2,r1	; 0230CC92
	ldrh r0,[r0,#0x16]	; 0230CC94
	cmp r0,#0x0	; 0230CC96
	beq loc_0230CD1C	; 0230CC98
	add r6,r4,#0x0	; 0230CC9A
	str r4,[sp,#0x10]	; 0230CC9C
	str r4,[sp,#0xc]	; 0230CC9E
loc_0230CCA0:
	add r1,r6,#0x0	; 0230CCA0
	str r1,[sp,#0x8]	; 0230CCA2
	mov r0,#0xc	; 0230CCA4
	mul r1,r0	; 0230CCA6
	str r1,[sp,#0x8]	; 0230CCA8
	ldr r0,[pool_0230CD24]	; 0230CCAA
	ldr r1,[r0,#0x0]	; 0230CCAC
	ldr r0,[sp,#0x8]	; 0230CCAE
	add r1,r1,r0	; 0230CCB0
	ldr r0,[pool_0230CD2C]	; 0230CCB2
	ldr r5,[r1,r0]	; 0230CCB4
	ldr r0,[sp,#0xc]	; 0230CCB6
	mvn r0,r0	; 0230CCB8
	cmp r5,r0	; 0230CCBA
	beq loc_0230CD16	; 0230CCBC
	add r1,r6,#0x0	; 0230CCBE
	str r1,[sp,#0x4]	; 0230CCC0
	mov r0,#0x14	; 0230CCC2
	mul r1,r0	; 0230CCC4
	str r1,[sp,#0x4]	; 0230CCC6
loc_0230CCC8:
	add r0,r5,#0x0	; 0230CCC8
	bl loc_02304E5C	; 0230CCCA
	str r0,[sp,#0x0]	; 0230CCCE
	add r0,r5,#0x0	; 0230CCD0
	add r0,#0x10	; 0230CCD2
	ldrh r1,[r0,#0x2]	; 0230CCD4
	cmp r1,r7	; 0230CCD6
	bne loc_0230CD0A	; 0230CCD8
	ldr r1,[pool_0230CD24]	; 0230CCDA
	ldr r2,[r1,#0x0]	; 0230CCDC
	ldr r1,[sp,#0x4]	; 0230CCDE
	add r2,r1,r2	; 0230CCE0
	ldr r1,[pool_0230CD30]	; 0230CCE2
	ldr r1,[r2,r1]	; 0230CCE4
	cmp r0,r1	; 0230CCE6
	beq loc_0230CD0A	; 0230CCE8
	mov r1,#0x2	; 0230CCEA
	strh r1,[r0,#0x8]	; 0230CCEC
	bl loc_023092B8	; 0230CCEE
	ldr r0,[pool_0230CD24]	; 0230CCF2
	ldr r1,[r0,#0x0]	; 0230CCF4
	ldr r0,[pool_0230CD2C]	; 0230CCF6
	add r1,r1,r0	; 0230CCF8
	ldr r0,[sp,#0x8]	; 0230CCFA
	add r0,r1,r0	; 0230CCFC
	add r1,r5,#0x0	; 0230CCFE
	bl loc_0230B1AC	; 0230CD00
	cmp r4,#0x0	; 0230CD04
	bne loc_0230CD0A	; 0230CD06
	mov r4,#0x1	; 0230CD08
loc_0230CD0A:
	ldr r5,[sp,#0x0]	; 0230CD0A
	ldr r0,[sp,#0x10]	; 0230CD0C
	mvn r1,r0	; 0230CD0E
	lsl r0,r5,#0	; 0230CD10
	cmp r0,r1	; 0230CD12
	bne loc_0230CCC8	; 0230CD14
loc_0230CD16:
	add r6,r6,#0x2	; 0230CD16
	cmp r6,#0x3	; 0230CD18
	bcc loc_0230CCA0	; 0230CD1A
loc_0230CD1C:
	add sp,#0x14	; 0230CD1C
	pop {r4,r5,r6,r7}	; 0230CD1E
	pop {r3}	; 0230CD20
	bx r3	; 0230CD22
pool_0230CD24:
loc_0230CD24:
	.word FirmwareWlWorkPointerSlot	; 0230CD24
pool_0230CD28:
loc_0230CD28:
	.word 0x000002E0	; 0230CD28
pool_0230CD2C:
loc_0230CD2C:
	.word 0x00000158	; 0230CD2C
pool_0230CD30:
loc_0230CD30:
	.word 0x000003F0	; 0230CD30

; ===== function loc_0230CD34 =====
loc_0230CD34:
	push {r4,r5,r6,lr}	; 0230CD34
	add r6,r0,#0x0	; 0230CD36
	mov r0,#0x14	; 0230CD38
	add r4,r6,#0x0	; 0230CD3A
	mul r4,r0	; 0230CD3C
	ldr r0,[pool_0230CD84]	; 0230CD3E
	ldr r1,[r0,#0x0]	; 0230CD40
	ldr r0,[pool_0230CD88]	; 0230CD42
	add r0,r1,r0	; 0230CD44
	add r5,r0,r4	; 0230CD46
	ldr r0,[pool_0230CD8C]	; 0230CD48
	bl loc_02304B48	; 0230CD4A
	lsl r2,r6,#0x1	; 0230CD4E
	ldr r1,[pool_0230CD90]	; 0230CD50
	ldrh r2,[r1,r2]	; 0230CD52
	ldr r1,[pool_0230CD94]	; 0230CD54
	strh r2,[r1,#0x0]	; 0230CD56
	ldr r1,[pool_0230CD84]	; 0230CD58
	ldr r1,[r1,#0x0]	; 0230CD5A
	add r2,r1,r4	; 0230CD5C
	ldr r1,[pool_0230CD88]	; 0230CD5E
	ldrh r1,[r2,r1]	; 0230CD60
	cmp r1,#0x0	; 0230CD62
	beq loc_0230CD78	; 0230CD64
	ldr r3,[r5,#0xc]	; 0230CD66
	ldrh r2,[r3,#0x14]	; 0230CD68
	ldr r1,[pool_0230CD98]	; 0230CD6A
	and r2,r1	; 0230CD6C
	cmp r2,#0x0	; 0230CD6E
	bne loc_0230CD78	; 0230CD70
	ldr r1,[r5,#0x8]	; 0230CD72
	ldrh r1,[r1,#0x4]	; 0230CD74
	strh r1,[r3,#0xc]	; 0230CD76
loc_0230CD78:
	bl loc_02304B58	; 0230CD78
	pop {r4,r5,r6}	; 0230CD7C
	pop {r3}	; 0230CD7E
	bx r3	; 0230CD80
	.byte 0xC0, 0x46	; 0230CD84
pool_0230CD84:
loc_0230CD84:
	.word FirmwareWlWorkPointerSlot	; 0230CD84
pool_0230CD88:
loc_0230CD88:
	.word 0x000003E4	; 0230CD88
pool_0230CD8C:
loc_0230CD8C:
	.word 0x01000000	; 0230CD8C
pool_0230CD90:
loc_0230CD90:
	.word P4_Data_023108A0	; 0230CD90
pool_0230CD94:
loc_0230CD94:
	.word REG_WIFI_TXBUF_RESET	; 0230CD94
pool_0230CD98:
loc_0230CD98:
	.word 0x00004000	; 0230CD98

; ===== function loc_0230CD9C =====
loc_0230CD9C:
	push {lr}	; 0230CD9C
	sub sp,#0x4	; 0230CD9E
	ldr r1,[pool_0230CDD8]	; 0230CDA0
	ldr r2,[r1,#0x0]	; 0230CDA2
	ldr r1,[pool_0230CDDC]	; 0230CDA4
	add r3,r2,r1	; 0230CDA6
	mov r1,#0x14	; 0230CDA8
	mul r0,r1	; 0230CDAA
	add r2,r3,r0	; 0230CDAC
	ldrh r0,[r3,r0]	; 0230CDAE
	cmp r0,#0x0	; 0230CDB0
	beq loc_0230CDD2	; 0230CDB2
	ldr r0,[r2,#0x8]	; 0230CDB4
	ldrh r1,[r0,#0x0]	; 0230CDB6
	cmp r1,#0x0	; 0230CDB8
	bne loc_0230CDC4	; 0230CDBA
	mov r1,#0x2	; 0230CDBC
	ldr r0,[r2,#0xc]	; 0230CDBE
	strh r1,[r0,#0x8]	; 0230CDC0
	b loc_0230CDC8	; 0230CDC2
loc_0230CDC4:
	ldr r0,[r2,#0xc]	; 0230CDC4
	strh r1,[r0,#0x8]	; 0230CDC6
loc_0230CDC8:
	ldr r0,[r2,#0xc]	; 0230CDC8
	mov r1,#0x0	; 0230CDCA
	ldr r2,[r2,#0x10]	; 0230CDCC
	bl loc_02308C84	; 0230CDCE
loc_0230CDD2:
	add sp,#0x4	; 0230CDD2
	pop {r3}	; 0230CDD4
	bx r3	; 0230CDD6
pool_0230CDD8:
loc_0230CDD8:
	.word FirmwareWlWorkPointerSlot	; 0230CDD8
pool_0230CDDC:
loc_0230CDDC:
	.word 0x000003E4	; 0230CDDC

; ===== function loc_0230CDE0 =====
loc_0230CDE0:
	push {r4,r5,lr}	; 0230CDE0
	sub sp,#0x4	; 0230CDE2
	ldr r0,[pool_0230CE44]	; 0230CDE4
	ldr r1,[r0,#0x0]	; 0230CDE6
	ldr r0,[pool_0230CE48]	; 0230CDE8
	add r5,r1,r0	; 0230CDEA
	ldr r0,[pool_0230CE4C]	; 0230CDEC
	bl loc_02304B48	; 0230CDEE
	add r4,r0,#0x0	; 0230CDF2
	ldr r0,[pool_0230CE44]	; 0230CDF4
	ldr r1,[r0,#0x0]	; 0230CDF6
	ldr r0,[pool_0230CE50]	; 0230CDF8
	ldrh r0,[r1,r0]	; 0230CDFA
	cmp r0,#0x1	; 0230CDFC
	bne loc_0230CE1C	; 0230CDFE
	mov r1,#0x9	; 0230CE00
	ldr r0,[pool_0230CE54]	; 0230CE02
	strh r1,[r0,#0x0]	; 0230CE04
	ldrh r0,[r5,#0x28]	; 0230CE06
	cmp r0,#0x0	; 0230CE08
	beq loc_0230CE12	; 0230CE0A
	mov r0,#0x2	; 0230CE0C
	bl loc_0230CD9C	; 0230CE0E
loc_0230CE12:
	mov r0,#0x2	; 0230CE12
	mov r1,#0x1	; 0230CE14
	bl loc_0230CB5C	; 0230CE16
	b loc_0230CE22	; 0230CE1A
loc_0230CE1C:
	mov r1,#0x1	; 0230CE1C
	ldr r0,[pool_0230CE54]	; 0230CE1E
	strh r1,[r0,#0x0]	; 0230CE20
loc_0230CE22:
	ldrh r0,[r5,#0x0]	; 0230CE22
	cmp r0,#0x0	; 0230CE24
	beq loc_0230CE2E	; 0230CE26
	mov r0,#0x0	; 0230CE28
	bl loc_0230CD9C	; 0230CE2A
loc_0230CE2E:
	mov r0,#0x0	; 0230CE2E
	mov r1,#0x1	; 0230CE30
	bl loc_0230CB5C	; 0230CE32
	add r0,r4,#0x0	; 0230CE36
	bl loc_02304B58	; 0230CE38
	add sp,#0x4	; 0230CE3C
	pop {r4,r5}	; 0230CE3E
	pop {r3}	; 0230CE40
	bx r3	; 0230CE42
pool_0230CE44:
loc_0230CE44:
	.word FirmwareWlWorkPointerSlot	; 0230CE44
pool_0230CE48:
loc_0230CE48:
	.word 0x000003E4	; 0230CE48
pool_0230CE4C:
loc_0230CE4C:
	.word 0x01000000	; 0230CE4C
pool_0230CE50:
loc_0230CE50:
	.word 0x00000314	; 0230CE50
pool_0230CE54:
loc_0230CE54:
	.word REG_WIFI_TXBUF_RESET	; 0230CE54

; ===== function loc_0230CE58 =====
loc_0230CE58:
	push {r4,lr}	; 0230CE58
	ldr r0,[pool_0230CE84]	; 0230CE5A
	bl loc_02304B48	; 0230CE5C
	add r4,r0,#0x0	; 0230CE60
	mov r1,#0x2	; 0230CE62
	ldr r0,[pool_0230CE88]	; 0230CE64
	strh r1,[r0,#0x0]	; 0230CE66
	ldr r0,[pool_0230CE8C]	; 0230CE68
	ldr r1,[r0,#0x0]	; 0230CE6A
	ldr r0,[pool_0230CE90]	; 0230CE6C
	ldrh r0,[r1,r0]	; 0230CE6E
	cmp r0,#0x0	; 0230CE70
	beq loc_0230CE78	; 0230CE72
	bl loc_023087AC	; 0230CE74
loc_0230CE78:
	add r0,r4,#0x0	; 0230CE78
	bl loc_02304B58	; 0230CE7A
	pop {r4}	; 0230CE7E
	pop {r3}	; 0230CE80
	bx r3	; 0230CE82
pool_0230CE84:
loc_0230CE84:
	.word 0x01000000	; 0230CE84
pool_0230CE88:
loc_0230CE88:
	.word REG_WIFI_TXBUF_RESET	; 0230CE88
pool_0230CE8C:
loc_0230CE8C:
	.word FirmwareWlWorkPointerSlot	; 0230CE8C
pool_0230CE90:
loc_0230CE90:
	.word 0x00000420	; 0230CE90

; ===== function loc_0230CE94 =====
loc_0230CE94:
	push {r4,lr}	; 0230CE94
	ldr r0,[pool_0230CEC0]	; 0230CE96
	ldr r1,[r0,#0x0]	; 0230CE98
	ldr r0,[pool_0230CEC4]	; 0230CE9A
	add r4,r1,r0	; 0230CE9C
	ldr r0,[pool_0230CEC8]	; 0230CE9E
	bl loc_02304B48	; 0230CEA0
	mov r2,#0xc0	; 0230CEA4
	ldr r1,[pool_0230CECC]	; 0230CEA6
	strh r2,[r1,#0x0]	; 0230CEA8
	mov r2,#0x0	; 0230CEAA
	add r1,r4,#0x0	; 0230CEAC
	add r1,#0x50	; 0230CEAE
	strh r2,[r1,#0x0]	; 0230CEB0
	add r4,#0x64	; 0230CEB2
	strh r2,[r4,#0x0]	; 0230CEB4
	bl loc_02304B58	; 0230CEB6
	pop {r4}	; 0230CEBA
	pop {r3}	; 0230CEBC
	bx r3	; 0230CEBE
pool_0230CEC0:
loc_0230CEC0:
	.word FirmwareWlWorkPointerSlot	; 0230CEC0
pool_0230CEC4:
loc_0230CEC4:
	.word 0x000003E4	; 0230CEC4
pool_0230CEC8:
loc_0230CEC8:
	.word 0x01000000	; 0230CEC8
pool_0230CECC:
loc_0230CECC:
	.word REG_WIFI_TXBUF_RESET	; 0230CECC

; ===== function loc_0230CED0 =====
loc_0230CED0:
	ldr r1,[r0,#0x8]	; 0230CED0
	ldrh r2,[r1,#0x4]	; 0230CED2
	mov r1,#0xff	; 0230CED4
	and r2,r1	; 0230CED6
	lsl r1,r2,#0x10	; 0230CED8
	lsr r3,r1,#0x10	; 0230CEDA
	cmp r3,#0x0	; 0230CEDC
	bne loc_0230CEF0	; 0230CEDE
	ldr r1,[pool_0230CF0C]	; 0230CEE0
	ldr r2,[r1,#0x0]	; 0230CEE2
	ldr r1,[pool_0230CF10]	; 0230CEE4
	add r2,r2,r1	; 0230CEE6
	ldr r1,[r2,#0x0]	; 0230CEE8
	add r1,r1,#0x1	; 0230CEEA
	str r1,[r2,#0x0]	; 0230CEEC
	b loc_0230CEFE	; 0230CEEE
loc_0230CEF0:
	ldr r1,[pool_0230CF0C]	; 0230CEF0
	ldr r2,[r1,#0x0]	; 0230CEF2
	ldr r1,[pool_0230CF14]	; 0230CEF4
	add r2,r2,r1	; 0230CEF6
	ldr r1,[r2,#0x0]	; 0230CEF8
	add r1,r1,r3	; 0230CEFA
	str r1,[r2,#0x0]	; 0230CEFC
loc_0230CEFE:
	add r2,r0,#0x4	; 0230CEFE
	ldrh r1,[r2,#0x0]	; 0230CF00
	add r1,r1,#0x1	; 0230CF02
	strh r1,[r2,#0x0]	; 0230CF04
	mov r1,#0x0	; 0230CF06
	strh r1,[r0,#0x0]	; 0230CF08
	bx lr	; 0230CF0A
pool_0230CF0C:
loc_0230CF0C:
	.word FirmwareWlWorkPointerSlot	; 0230CF0C
pool_0230CF10:
loc_0230CF10:
	.word 0x00000560	; 0230CF10
pool_0230CF14:
loc_0230CF14:
	.word 0x0000055C	; 0230CF14

; ===== function loc_0230CF18 =====
P4_Code_0230CF18:
	push {r4,lr}	; 0230CF18
	add r2,r0,#0x0	; 0230CF1A
	add r4,r1,#0x0	; 0230CF1C
	ldr r3,[pool_0230CFAC]	; 0230CF1E
	ldr r1,[r3,#0x0]	; 0230CF20
	ldr r0,[pool_0230CFB0]	; 0230CF22
	add r1,r1,r0	; 0230CF24
	ldr r0,[r1,#0x0]	; 0230CF26
	add r0,r0,#0x1	; 0230CF28
	str r0,[r1,#0x0]	; 0230CF2A
	ldr r1,[r3,#0x0]	; 0230CF2C
	ldr r0,[pool_0230CFB4]	; 0230CF2E
	add r0,r1,r0	; 0230CF30
	sub r2,#0x10	; 0230CF32
	add r1,r2,#0x0	; 0230CF34
	bl loc_0230B1AC	; 0230CF36
	mov r3,#0x0	; 0230CF3A
	ldr r0,[pool_0230CFAC]	; 0230CF3C
	ldr r2,[r0,#0x0]	; 0230CF3E
	ldr r1,[pool_0230CFB8]	; 0230CF40
	strh r3,[r2,r1]	; 0230CF42
	ldr r2,[r0,#0x0]	; 0230CF44
	ldr r1,[pool_0230CFBC]	; 0230CF46
	ldr r1,[r2,r1]	; 0230CF48
	ldrh r1,[r1,#0xc]	; 0230CF4A
	lsl r1,r1,#0x12	; 0230CF4C
	lsr r1,r1,#0x1f	; 0230CF4E
	cmp r1,#0x0	; 0230CF50
	bne loc_0230CF86	; 0230CF52
	mov r2,#0x8	; 0230CF54
	ldr r1,[pool_0230CFC0]	; 0230CF56
	strh r2,[r1,#0x0]	; 0230CF58
	mov r2,#0x5	; 0230CF5A
	ldr r1,[pool_0230CFC4]	; 0230CF5C
	strh r2,[r1,#0x0]	; 0230CF5E
	cmp r4,#0x0	; 0230CF60
	beq loc_0230CF86	; 0230CF62
	ldr r1,[r0,#0x0]	; 0230CF64
	ldr r0,[pool_0230CFC8]	; 0230CF66
	ldrh r0,[r1,r0]	; 0230CF68
	cmp r0,#0x0	; 0230CF6A
	beq loc_0230CF74	; 0230CF6C
	mov r0,#0x1	; 0230CF6E
	bl loc_0230D670	; 0230CF70
loc_0230CF74:
	ldr r0,[pool_0230CFAC]	; 0230CF74
	ldr r1,[r0,#0x0]	; 0230CF76
	ldr r0,[pool_0230CFCC]	; 0230CF78
	ldrh r0,[r1,r0]	; 0230CF7A
	cmp r0,#0x0	; 0230CF7C
	beq loc_0230CF86	; 0230CF7E
	mov r0,#0x0	; 0230CF80
	bl loc_0230D670	; 0230CF82
loc_0230CF86:
	ldr r0,[pool_0230CFAC]	; 0230CF86
	ldr r1,[r0,#0x0]	; 0230CF88
	ldr r0,[pool_0230CFD0]	; 0230CF8A
	ldrh r0,[r1,r0]	; 0230CF8C
	cmp r0,#0x0	; 0230CF8E
	beq loc_0230CF9E	; 0230CF90
	cmp r4,#0x0	; 0230CF92
	beq loc_0230CFA4	; 0230CF94
	mov r0,#0x2	; 0230CF96
	bl loc_0230D670	; 0230CF98
	b loc_0230CFA4	; 0230CF9C
loc_0230CF9E:
	mov r0,#0x0	; 0230CF9E
	bl loc_02308F94	; 0230CFA0
loc_0230CFA4:
	pop {r4}	; 0230CFA4
	pop {r3}	; 0230CFA6
	bx r3	; 0230CFA8
	.byte 0xC0, 0x46	; 0230CFAC
pool_0230CFAC:
loc_0230CFAC:
	.word FirmwareWlWorkPointerSlot	; 0230CFAC
pool_0230CFB0:
loc_0230CFB0:
	.word 0x00000508	; 0230CFB0
pool_0230CFB4:
loc_0230CFB4:
	.word 0x00000170	; 0230CFB4
pool_0230CFB8:
loc_0230CFB8:
	.word 0x0000040C	; 0230CFB8
pool_0230CFBC:
loc_0230CFBC:
	.word 0x00000414	; 0230CFBC
pool_0230CFC0:
loc_0230CFC0:
	.word REG_WIFI_TXREQ_RESET	; 0230CFC0
pool_0230CFC4:
loc_0230CFC4:
	.word REG_WIFI_TXREQ_SET	; 0230CFC4
pool_0230CFC8:
loc_0230CFC8:
	.word 0x0000016C	; 0230CFC8
pool_0230CFCC:
loc_0230CFCC:
	.word 0x00000160	; 0230CFCC
pool_0230CFD0:
loc_0230CFD0:
	.word 0x00000178	; 0230CFD0

; ===== function loc_0230CFD4 =====
P4_Code_0230CFD4:
	push {r4,r5,lr}	; 0230CFD4
	sub sp,#0x4	; 0230CFD6
	ldr r1,[pool_0230D028]	; 0230CFD8
	ldr r2,[r1,#0x0]	; 0230CFDA
	ldr r1,[pool_0230D02C]	; 0230CFDC
	add r2,r2,r1	; 0230CFDE
	add r1,r2,#0x0	; 0230CFE0
	add r1,#0x8	; 0230CFE2
	ldr r5,[r1,#0x0]	; 0230CFE4
	ldrh r4,[r0,#0x4]	; 0230CFE6
	mov r3,#0xff	; 0230CFE8
	and r4,r3	; 0230CFEA
	lsl r3,r4,#0x10	; 0230CFEC
	lsr r3,r3,#0x10	; 0230CFEE
	add r3,r5,r3	; 0230CFF0
	str r3,[r1,#0x0]	; 0230CFF2
	ldrh r1,[r0,#0x0]	; 0230CFF4
	mov r0,#0x2	; 0230CFF6
	and r1,r0	; 0230CFF8
	cmp r1,#0x0	; 0230CFFA
	bne loc_0230D00E	; 0230CFFC
	ldr r0,[r2,#0x0]	; 0230CFFE
	add r0,r0,#0x1	; 0230D000
	str r0,[r2,#0x0]	; 0230D002
	add r2,#0x10	; 0230D004
	ldr r0,[r2,#0x0]	; 0230D006
	add r0,r0,#0x1	; 0230D008
	str r0,[r2,#0x0]	; 0230D00A
	b loc_0230D016	; 0230D00C
loc_0230D00E:
	add r1,r2,#0x4	; 0230D00E
	ldr r0,[r1,#0x0]	; 0230D010
	add r0,r0,#0x1	; 0230D012
	str r0,[r1,#0x0]	; 0230D014
loc_0230D016:
	mov r2,#0x0	; 0230D016
	ldr r0,[pool_0230D028]	; 0230D018
	ldr r1,[r0,#0x0]	; 0230D01A
	ldr r0,[pool_0230D030]	; 0230D01C
	strh r2,[r1,r0]	; 0230D01E
	add sp,#0x4	; 0230D020
	pop {r4,r5}	; 0230D022
	pop {r3}	; 0230D024
	bx r3	; 0230D026
pool_0230D028:
loc_0230D028:
	.word FirmwareWlWorkPointerSlot	; 0230D028
pool_0230D02C:
loc_0230D02C:
	.word 0x000004F4	; 0230D02C
pool_0230D030:
loc_0230D030:
	.word 0x0000040C	; 0230D030

; ===== function loc_0230D034 =====
P4_Code_0230D034:
	push {r4,r5,r6,r7,lr}	; 0230D034
	sub sp,#0x4	; 0230D036
	add r5,r0,#0x0	; 0230D038
	str r1,[sp,#0x0]	; 0230D03A
	ldr r0,[pool_0230D31C]	; 0230D03C
	ldr r1,[r0,#0x0]	; 0230D03E
	ldr r0,[pool_0230D320]	; 0230D040
	add r4,r1,r0	; 0230D042
	ldrh r6,[r5,#0x2]	; 0230D044
	ldrh r1,[r5,#0x8]	; 0230D046
	mov r0,#0x2	; 0230D048
	and r1,r0	; 0230D04A
	cmp r1,#0x0	; 0230D04C
	bne loc_0230D0B0	; 0230D04E
	ldr r0,[r4,#0x0]	; 0230D050
	add r0,r0,#0x1	; 0230D052
	str r0,[r4,#0x0]	; 0230D054
	ldrh r1,[r5,#0x18]	; 0230D056
	mov r0,#0x1	; 0230D058
	and r1,r0	; 0230D05A
	cmp r1,#0x0	; 0230D05C
	beq loc_0230D06C	; 0230D05E
	add r1,r4,#0x0	; 0230D060
	add r1,#0x14	; 0230D062
	ldr r0,[r1,#0x0]	; 0230D064
	add r0,r0,#0x1	; 0230D066
	str r0,[r1,#0x0]	; 0230D068
	b loc_0230D076	; 0230D06A
loc_0230D06C:
	add r1,r4,#0x0	; 0230D06C
	add r1,#0x10	; 0230D06E
	ldr r0,[r1,#0x0]	; 0230D070
	add r0,r0,#0x1	; 0230D072
	str r0,[r1,#0x0]	; 0230D074
loc_0230D076:
	ldr r0,[pool_0230D31C]	; 0230D076
	ldr r3,[r0,#0x0]	; 0230D078
	ldr r0,[pool_0230D324]	; 0230D07A
	ldrh r0,[r3,r0]	; 0230D07C
	asr r0,r6	; 0230D07E
	mov r1,#0x1	; 0230D080
	and r0,r1	; 0230D082
	cmp r0,#0x0	; 0230D084
	beq loc_0230D0B8	; 0230D086
	ldrh r2,[r5,#0x14]	; 0230D088
	ldr r0,[pool_0230D328]	; 0230D08A
	and r2,r0	; 0230D08C
	cmp r2,#0x0	; 0230D08E
	bne loc_0230D0B8	; 0230D090
	ldr r0,[pool_0230D32C]	; 0230D092
	ldr r2,[r3,r0]	; 0230D094
	mov r0,#0x1c	; 0230D096
	add r7,r6,#0x0	; 0230D098
	mul r7,r0	; 0230D09A
	ldrh r0,[r2,r7]	; 0230D09C
	cmp r0,#0x40	; 0230D09E
	bne loc_0230D0B8	; 0230D0A0
	ldr r0,[pool_0230D330]	; 0230D0A2
	add r2,r3,r0	; 0230D0A4
	ldrh r0,[r2,#0x0]	; 0230D0A6
	lsl r1,r6	; 0230D0A8
	bic r0,r1	; 0230D0AA
	strh r0,[r2,#0x0]	; 0230D0AC
	b loc_0230D0B8	; 0230D0AE
loc_0230D0B0:
	add r1,r4,#0x4	; 0230D0B0
	ldr r0,[r1,#0x0]	; 0230D0B2
	add r0,r0,#0x1	; 0230D0B4
	str r0,[r1,#0x0]	; 0230D0B6
loc_0230D0B8:
	ldrh r0,[r5,#0x14]	; 0230D0B8
	lsl r0,r0,#0x11	; 0230D0BA
	lsr r0,r0,#0x1f	; 0230D0BC
	cmp r0,#0x0	; 0230D0BE
	beq loc_0230D0CC	; 0230D0C0
	add r1,r4,#0x0	; 0230D0C2
	add r1,#0x18	; 0230D0C4
	ldr r0,[r1,#0x0]	; 0230D0C6
	add r0,r0,#0x1	; 0230D0C8
	str r0,[r1,#0x0]	; 0230D0CA
loc_0230D0CC:
	add r4,#0x8	; 0230D0CC
	ldr r1,[r4,#0x0]	; 0230D0CE
	ldrh r0,[r5,#0xc]	; 0230D0D0
	lsl r0,r0,#0x8	; 0230D0D2
	lsr r0,r0,#0x10	; 0230D0D4
	add r0,r1,r0	; 0230D0D6
	str r0,[r4,#0x0]	; 0230D0D8
	ldrh r4,[r5,#0x14]	; 0230D0DA
	mov r0,#0xfc	; 0230D0DC
	and r4,r0	; 0230D0DE
	cmp r4,#0x30	; 0230D0E0
	bhi loc_0230D0F8	; 0230D0E2
	cmp r4,#0x30	; 0230D0E4
	bcs loc_0230D16E	; 0230D0E6
	cmp r4,#0x10	; 0230D0E8
	bhi loc_0230D0F4	; 0230D0EA
	cmp r4,#0x10	; 0230D0EC
	bcs loc_0230D16E	; 0230D0EE
	cmp r4,#0x0	; 0230D0F0
	b loc_0230D2DE	; 0230D0F2
loc_0230D0F4:
	cmp r4,#0x20	; 0230D0F4
	b loc_0230D2DE	; 0230D0F6
loc_0230D0F8:
	cmp r4,#0xb0	; 0230D0F8
	bhi loc_0230D106	; 0230D0FA
	cmp r4,#0xb0	; 0230D0FC
	bcs loc_0230D10E	; 0230D0FE
	cmp r4,#0xa0	; 0230D100
	beq loc_0230D1C0	; 0230D102
	b loc_0230D2DE	; 0230D104
loc_0230D106:
	cmp r4,#0xc0	; 0230D106
	bne loc_0230D10C	; 0230D108
	b loc_0230D250	; 0230D10A
loc_0230D10C:
	b loc_0230D2DE	; 0230D10C
loc_0230D10E:
	ldrh r1,[r5,#0x8]	; 0230D10E
	mov r0,#0x2	; 0230D110
	and r1,r0	; 0230D112
	cmp r1,#0x0	; 0230D114
	beq loc_0230D11A	; 0230D116
	b loc_0230D2DE	; 0230D118
loc_0230D11A:
	ldrh r1,[r5,#0x2c]	; 0230D11A
	cmp r1,#0x0	; 0230D11C
	bne loc_0230D142	; 0230D11E
	ldrh r0,[r5,#0x2e]	; 0230D120
	cmp r0,#0x2	; 0230D122
	bne loc_0230D142	; 0230D124
	ldrh r0,[r5,#0x30]	; 0230D126
	cmp r0,#0x0	; 0230D128
	bne loc_0230D142	; 0230D12A
	lsl r0,r6,#0x10	; 0230D12C
	lsr r0,r0,#0x10	; 0230D12E
	mov r1,#0x30	; 0230D130
	bl loc_023091EC	; 0230D132
	add r0,r5,#0x0	; 0230D136
	add r0,#0x18	; 0230D138
	ldrh r1,[r5,#0x2c]	; 0230D13A
	bl loc_02309BC0	; 0230D13C
	b loc_0230D2DE	; 0230D140
loc_0230D142:
	cmp r1,#0x1	; 0230D142
	beq loc_0230D148	; 0230D144
	b loc_0230D2DE	; 0230D146
loc_0230D148:
	ldrh r0,[r5,#0x2e]	; 0230D148
	cmp r0,#0x4	; 0230D14A
	beq loc_0230D150	; 0230D14C
	b loc_0230D2DE	; 0230D14E
loc_0230D150:
	ldrh r0,[r5,#0x30]	; 0230D150
	cmp r0,#0x0	; 0230D152
	beq loc_0230D158	; 0230D154
	b loc_0230D2DE	; 0230D156
loc_0230D158:
	lsl r0,r6,#0x10	; 0230D158
	lsr r0,r0,#0x10	; 0230D15A
	mov r1,#0x30	; 0230D15C
	bl loc_023091EC	; 0230D15E
	add r0,r5,#0x0	; 0230D162
	add r0,#0x18	; 0230D164
	ldrh r1,[r5,#0x2c]	; 0230D166
	bl loc_02309BC0	; 0230D168
	b loc_0230D2DE	; 0230D16C
loc_0230D16E:
	ldrh r1,[r5,#0x8]	; 0230D16E
	mov r0,#0x2	; 0230D170
	and r1,r0	; 0230D172
	cmp r1,#0x0	; 0230D174
	bne loc_0230D1B6	; 0230D176
	ldrh r0,[r5,#0x2e]	; 0230D178
	cmp r0,#0x0	; 0230D17A
	beq loc_0230D180	; 0230D17C
	b loc_0230D2DE	; 0230D17E
loc_0230D180:
	lsl r0,r6,#0x10	; 0230D180
	lsr r0,r0,#0x10	; 0230D182
	mov r1,#0x40	; 0230D184
	bl loc_023091EC	; 0230D186
	cmp r4,#0x10	; 0230D18A
	bne loc_0230D1A2	; 0230D18C
	add r0,r5,#0x0	; 0230D18E
	add r0,#0x18	; 0230D190
	ldrh r1,[r5,#0x30]	; 0230D192
	add r3,r5,#0x0	; 0230D194
	add r3,#0x14	; 0230D196
	ldrh r2,[r5,#0x12]	; 0230D198
	add r2,r3,r2	; 0230D19A
	bl loc_02309AC4	; 0230D19C
	b loc_0230D2DE	; 0230D1A0
loc_0230D1A2:
	add r0,r5,#0x0	; 0230D1A2
	add r0,#0x18	; 0230D1A4
	ldrh r1,[r5,#0x30]	; 0230D1A6
	add r3,r5,#0x0	; 0230D1A8
	add r3,#0x14	; 0230D1AA
	ldrh r2,[r5,#0x12]	; 0230D1AC
	add r2,r3,r2	; 0230D1AE
	bl loc_02309A28	; 0230D1B0
	b loc_0230D2DE	; 0230D1B4
loc_0230D1B6:
	lsl r0,r6,#0x10	; 0230D1B6
	lsr r0,r0,#0x10	; 0230D1B8
	bl loc_023090A0	; 0230D1BA
	b loc_0230D2DE	; 0230D1BE
loc_0230D1C0:
	ldr r7,[pool_0230D31C]	; 0230D1C0
	ldr r0,[r7,#0x0]	; 0230D1C2
	ldr r1,[pool_0230D334]	; 0230D1C4
	ldrh r1,[r0,r1]	; 0230D1C6
	cmp r1,#0x1	; 0230D1C8
	bne loc_0230D220	; 0230D1CA
	cmp r6,#0x0	; 0230D1CC
	beq loc_0230D1EC	; 0230D1CE
	ldr r1,[pool_0230D32C]	; 0230D1D0
	ldr r2,[r0,r1]	; 0230D1D2
	mov r0,#0x1c	; 0230D1D4
	add r1,r6,#0x0	; 0230D1D6
	mul r1,r0	; 0230D1D8
	ldrh r0,[r2,r1]	; 0230D1DA
	cmp r0,#0x30	; 0230D1DC
	bls loc_0230D232	; 0230D1DE
	lsl r0,r6,#0x10	; 0230D1E0
	lsr r0,r0,#0x10	; 0230D1E2
	mov r1,#0x30	; 0230D1E4
	bl loc_023091EC	; 0230D1E6
	b loc_0230D232	; 0230D1EA
loc_0230D1EC:
	ldrh r0,[r5,#0x18]	; 0230D1EC
	mov r4,#0x1	; 0230D1EE
	and r0,r4	; 0230D1F0
	cmp r0,#0x0	; 0230D1F2
	beq loc_0230D232	; 0230D1F4
	mov r6,#0x1c	; 0230D1F6
	b loc_0230D214	; 0230D1F8
loc_0230D1FA:
	ldr r1,[pool_0230D32C]	; 0230D1FA
	ldr r1,[r0,r1]	; 0230D1FC
	add r0,r4,#0x0	; 0230D1FE
	mul r0,r6	; 0230D200
	ldrh r0,[r1,r0]	; 0230D202
	cmp r0,#0x30	; 0230D204
	bls loc_0230D212	; 0230D206
	lsl r0,r4,#0x10	; 0230D208
	lsr r0,r0,#0x10	; 0230D20A
	mov r1,#0x30	; 0230D20C
	bl loc_023091EC	; 0230D20E
loc_0230D212:
	add r4,r4,#0x1	; 0230D212
loc_0230D214:
	ldr r0,[r7,#0x0]	; 0230D214
	ldr r1,[pool_0230D338]	; 0230D216
	ldrh r1,[r0,r1]	; 0230D218
	cmp r4,r1	; 0230D21A
	bcc loc_0230D1FA	; 0230D21C
	b loc_0230D232	; 0230D21E
loc_0230D220:
	ldr r1,[pool_0230D33C]	; 0230D220
	ldrh r0,[r0,r1]	; 0230D222
	cmp r0,#0x30	; 0230D224
	bls loc_0230D232	; 0230D226
	mov r0,#0x30	; 0230D228
	bl loc_02306468	; 0230D22A
	bl loc_023064D4	; 0230D22E
loc_0230D232:
	ldr r0,[pool_0230D31C]	; 0230D232
	ldr r4,[r0,#0x0]	; 0230D234
	ldr r2,[pool_0230D340]	; 0230D236
	ldrh r1,[r4,r2]	; 0230D238
	cmp r1,#0x71	; 0230D23A
	bne loc_0230D2DE	; 0230D23C
	mov r3,#0x0	; 0230D23E
	ldr r1,[pool_0230D344]	; 0230D240
	ldr r1,[r4,r1]	; 0230D242
	strh r3,[r1,#0x4]	; 0230D244
	ldr r0,[r0,#0x0]	; 0230D246
	strh r3,[r0,r2]	; 0230D248
	bl loc_02309C18	; 0230D24A
	b loc_0230D2DE	; 0230D24E
loc_0230D250:
	ldr r7,[pool_0230D31C]	; 0230D250
	ldr r0,[r7,#0x0]	; 0230D252
	ldr r1,[pool_0230D334]	; 0230D254
	ldrh r1,[r0,r1]	; 0230D256
	cmp r1,#0x1	; 0230D258
	bne loc_0230D2B0	; 0230D25A
	cmp r6,#0x0	; 0230D25C
	beq loc_0230D27C	; 0230D25E
	ldr r1,[pool_0230D32C]	; 0230D260
	ldr r2,[r0,r1]	; 0230D262
	mov r0,#0x1c	; 0230D264
	add r1,r6,#0x0	; 0230D266
	mul r1,r0	; 0230D268
	ldrh r0,[r2,r1]	; 0230D26A
	cmp r0,#0x20	; 0230D26C
	bls loc_0230D2C2	; 0230D26E
	lsl r0,r6,#0x10	; 0230D270
	lsr r0,r0,#0x10	; 0230D272
	mov r1,#0x20	; 0230D274
	bl loc_023091EC	; 0230D276
	b loc_0230D2C2	; 0230D27A
loc_0230D27C:
	ldrh r0,[r5,#0x18]	; 0230D27C
	mov r4,#0x1	; 0230D27E
	and r0,r4	; 0230D280
	cmp r0,#0x0	; 0230D282
	beq loc_0230D2C2	; 0230D284
	mov r6,#0x1c	; 0230D286
	b loc_0230D2A4	; 0230D288
loc_0230D28A:
	ldr r1,[pool_0230D32C]	; 0230D28A
	ldr r1,[r0,r1]	; 0230D28C
	add r0,r4,#0x0	; 0230D28E
	mul r0,r6	; 0230D290
	ldrh r0,[r1,r0]	; 0230D292
	cmp r0,#0x20	; 0230D294
	bls loc_0230D2A2	; 0230D296
	lsl r0,r4,#0x10	; 0230D298
	lsr r0,r0,#0x10	; 0230D29A
	mov r1,#0x20	; 0230D29C
	bl loc_023091EC	; 0230D29E
loc_0230D2A2:
	add r4,r4,#0x1	; 0230D2A2
loc_0230D2A4:
	ldr r0,[r7,#0x0]	; 0230D2A4
	ldr r1,[pool_0230D338]	; 0230D2A6
	ldrh r1,[r0,r1]	; 0230D2A8
	cmp r4,r1	; 0230D2AA
	bcc loc_0230D28A	; 0230D2AC
	b loc_0230D2C2	; 0230D2AE
loc_0230D2B0:
	ldr r1,[pool_0230D33C]	; 0230D2B0
	ldrh r0,[r0,r1]	; 0230D2B2
	cmp r0,#0x20	; 0230D2B4
	bls loc_0230D2C2	; 0230D2B6
	mov r0,#0x20	; 0230D2B8
	bl loc_02306468	; 0230D2BA
	bl loc_023064D4	; 0230D2BE
loc_0230D2C2:
	ldr r0,[pool_0230D31C]	; 0230D2C2
	ldr r4,[r0,#0x0]	; 0230D2C4
	ldr r2,[pool_0230D340]	; 0230D2C6
	ldrh r1,[r4,r2]	; 0230D2C8
	cmp r1,#0x41	; 0230D2CA
	bne loc_0230D2DE	; 0230D2CC
	mov r3,#0x0	; 0230D2CE
	ldr r1,[pool_0230D344]	; 0230D2D0
	ldr r1,[r4,r1]	; 0230D2D2
	strh r3,[r1,#0x4]	; 0230D2D4
	ldr r0,[r0,#0x0]	; 0230D2D6
	strh r3,[r0,r2]	; 0230D2D8
	bl loc_02309C18	; 0230D2DA
loc_0230D2DE:
	add r0,r5,#0x0	; 0230D2DE
	bl loc_023092B8	; 0230D2E0
	ldr r0,[pool_0230D31C]	; 0230D2E4
	ldr r1,[r0,#0x0]	; 0230D2E6
	ldr r0,[pool_0230D348]	; 0230D2E8
	add r0,r1,r0	; 0230D2EA
	sub r5,#0x10	; 0230D2EC
	add r1,r5,#0x0	; 0230D2EE
	bl loc_02304FF8	; 0230D2F0
	mov r3,#0x0	; 0230D2F4
	ldr r2,[pool_0230D31C]	; 0230D2F6
	ldr r1,[r2,#0x0]	; 0230D2F8
	ldr r0,[pool_0230D34C]	; 0230D2FA
	strh r3,[r1,r0]	; 0230D2FC
	ldr r0,[sp,#0x0]	; 0230D2FE
	cmp r0,#0x0	; 0230D300
	beq loc_0230D314	; 0230D302
	ldr r1,[r2,#0x0]	; 0230D304
	ldr r0,[pool_0230D350]	; 0230D306
	ldrh r0,[r1,r0]	; 0230D308
	cmp r0,#0x0	; 0230D30A
	beq loc_0230D314	; 0230D30C
	mov r0,#0x1	; 0230D30E
	bl loc_0230D670	; 0230D310
loc_0230D314:
	add sp,#0x4	; 0230D314
	pop {r4,r5,r6,r7}	; 0230D316
	pop {r3}	; 0230D318
	bx r3	; 0230D31A
pool_0230D31C:
loc_0230D31C:
	.word FirmwareWlWorkPointerSlot	; 0230D31C
pool_0230D320:
loc_0230D320:
	.word 0x000004F4	; 0230D320
pool_0230D324:
loc_0230D324:
	.word 0x000004EA	; 0230D324
pool_0230D328:
loc_0230D328:
	.word 0x00002000	; 0230D328
pool_0230D32C:
loc_0230D32C:
	.word 0x000002E0	; 0230D32C
pool_0230D330:
loc_0230D330:
	.word 0x000004EC	; 0230D330
pool_0230D334:
loc_0230D334:
	.word 0x00000314	; 0230D334
pool_0230D338:
loc_0230D338:
	.word 0x000002E6	; 0230D338
pool_0230D33C:
loc_0230D33C:
	.word 0x00000310	; 0230D33C
pool_0230D340:
loc_0230D340:
	.word 0x000003BC	; 0230D340
pool_0230D344:
loc_0230D344:
	.word 0x000003D8	; 0230D344
pool_0230D348:
loc_0230D348:
	.word 0x00000164	; 0230D348
pool_0230D34C:
loc_0230D34C:
	.word 0x000003F8	; 0230D34C
pool_0230D350:
loc_0230D350:
	.word 0x0000016C	; 0230D350

; ===== function loc_0230D354 =====
P4_Code_0230D354:
	push {r4,r5,r6,r7,lr}	; 0230D354
	sub sp,#0x4	; 0230D356
	add r5,r0,#0x0	; 0230D358
	add r6,r1,#0x0	; 0230D35A
	ldr r1,[pool_0230D49C]	; 0230D35C
	ldr r2,[r1,#0x0]	; 0230D35E
	ldr r1,[pool_0230D4A0]	; 0230D360
	add r4,r2,r1	; 0230D362
	add r7,r5,#0x0	; 0230D364
	sub r7,#0x10	; 0230D366
	bl loc_023092B8	; 0230D368
	ldrh r1,[r5,#0x8]	; 0230D36C
	mov r0,#0x2	; 0230D36E
	and r1,r0	; 0230D370
	cmp r1,#0x0	; 0230D372
	bne loc_0230D3CA	; 0230D374
	ldr r0,[r4,#0x0]	; 0230D376
	add r0,r0,#0x1	; 0230D378
	str r0,[r4,#0x0]	; 0230D37A
	ldrh r0,[r5,#0x14]	; 0230D37C
	lsl r0,r0,#0x17	; 0230D37E
	lsr r0,r0,#0x1f	; 0230D380
	cmp r0,#0x0	; 0230D382
	beq loc_0230D3A8	; 0230D384
	ldrh r1,[r5,#0x24]	; 0230D386
	mov r0,#0x1	; 0230D388
	and r1,r0	; 0230D38A
	cmp r1,#0x0	; 0230D38C
	beq loc_0230D39C	; 0230D38E
	add r1,r4,#0x0	; 0230D390
	add r1,#0x14	; 0230D392
	ldr r0,[r1,#0x0]	; 0230D394
	add r0,r0,#0x1	; 0230D396
	str r0,[r1,#0x0]	; 0230D398
	b loc_0230D3D2	; 0230D39A
loc_0230D39C:
	add r1,r4,#0x0	; 0230D39C
	add r1,#0x10	; 0230D39E
	ldr r0,[r1,#0x0]	; 0230D3A0
	add r0,r0,#0x1	; 0230D3A2
	str r0,[r1,#0x0]	; 0230D3A4
	b loc_0230D3D2	; 0230D3A6
loc_0230D3A8:
	ldrh r1,[r5,#0x18]	; 0230D3A8
	mov r0,#0x1	; 0230D3AA
	and r1,r0	; 0230D3AC
	cmp r1,#0x0	; 0230D3AE
	beq loc_0230D3BE	; 0230D3B0
	add r1,r4,#0x0	; 0230D3B2
	add r1,#0x14	; 0230D3B4
	ldr r0,[r1,#0x0]	; 0230D3B6
	add r0,r0,#0x1	; 0230D3B8
	str r0,[r1,#0x0]	; 0230D3BA
	b loc_0230D3D2	; 0230D3BC
loc_0230D3BE:
	add r1,r4,#0x0	; 0230D3BE
	add r1,#0x10	; 0230D3C0
	ldr r0,[r1,#0x0]	; 0230D3C2
	add r0,r0,#0x1	; 0230D3C4
	str r0,[r1,#0x0]	; 0230D3C6
	b loc_0230D3D2	; 0230D3C8
loc_0230D3CA:
	add r1,r4,#0x4	; 0230D3CA
	ldr r0,[r1,#0x0]	; 0230D3CC
	add r0,r0,#0x1	; 0230D3CE
	str r0,[r1,#0x0]	; 0230D3D0
loc_0230D3D2:
	ldrh r0,[r5,#0x14]	; 0230D3D2
	lsl r0,r0,#0x11	; 0230D3D4
	lsr r0,r0,#0x1f	; 0230D3D6
	cmp r0,#0x0	; 0230D3D8
	beq loc_0230D3E4	; 0230D3DA
	add r4,#0x18	; 0230D3DC
	ldr r0,[r4,#0x0]	; 0230D3DE
	add r0,r0,#0x1	; 0230D3E0
	str r0,[r4,#0x0]	; 0230D3E2
loc_0230D3E4:
	ldr r0,[pool_0230D49C]	; 0230D3E4
	ldr r1,[r0,#0x0]	; 0230D3E6
	ldr r0,[pool_0230D4A4]	; 0230D3E8
	add r0,r1,r0	; 0230D3EA
	add r1,r7,#0x0	; 0230D3EC
	bl loc_0230B1AC	; 0230D3EE
	mov r2,#0x0	; 0230D3F2
	ldr r3,[pool_0230D49C]	; 0230D3F4
	ldr r1,[r3,#0x0]	; 0230D3F6
	ldr r0,[pool_0230D4A8]	; 0230D3F8
	strh r2,[r1,r0]	; 0230D3FA
	ldrh r2,[r5,#0x2]	; 0230D3FC
	ldr r1,[r3,#0x0]	; 0230D3FE
	ldr r0,[pool_0230D4AC]	; 0230D400
	ldrh r3,[r1,r0]	; 0230D402
	asr r3,r2	; 0230D404
	mov r0,#0x1	; 0230D406
	and r3,r0	; 0230D408
	cmp r3,#0x0	; 0230D40A
	beq loc_0230D434	; 0230D40C
	ldrh r4,[r5,#0x14]	; 0230D40E
	ldr r3,[pool_0230D4B0]	; 0230D410
	and r4,r3	; 0230D412
	cmp r4,#0x0	; 0230D414
	bne loc_0230D434	; 0230D416
	ldr r3,[pool_0230D4B4]	; 0230D418
	ldr r5,[r1,r3]	; 0230D41A
	mov r3,#0x1c	; 0230D41C
	add r4,r2,#0x0	; 0230D41E
	mul r4,r3	; 0230D420
	ldrh r3,[r5,r4]	; 0230D422
	cmp r3,#0x40	; 0230D424
	bne loc_0230D434	; 0230D426
	ldr r3,[pool_0230D4B8]	; 0230D428
	add r3,r1,r3	; 0230D42A
	ldrh r1,[r3,#0x0]	; 0230D42C
	lsl r0,r2	; 0230D42E
	bic r1,r0	; 0230D430
	strh r1,[r3,#0x0]	; 0230D432
loc_0230D434:
	cmp r6,#0x0	; 0230D434
	beq loc_0230D492	; 0230D436
	ldr r0,[pool_0230D49C]	; 0230D438
	ldr r0,[r0,#0x0]	; 0230D43A
	ldr r1,[pool_0230D4BC]	; 0230D43C
	ldrh r1,[r0,r1]	; 0230D43E
	cmp r1,#0x0	; 0230D440
	beq loc_0230D44C	; 0230D442
	mov r0,#0x0	; 0230D444
	bl loc_0230D670	; 0230D446
	b loc_0230D492	; 0230D44A
loc_0230D44C:
	ldr r1,[pool_0230D4C0]	; 0230D44C
	ldrh r2,[r0,r1]	; 0230D44E
	ldr r1,[pool_0230D4C4]	; 0230D450
	add r1,r2,r1	; 0230D452
	lsl r1,r1,#0x10	; 0230D454
	lsr r1,r1,#0x10	; 0230D456
	cmp r1,#0x1	; 0230D458
	bhi loc_0230D492	; 0230D45A
	ldr r1,[pool_0230D4C8]	; 0230D45C
	ldrh r1,[r0,r1]	; 0230D45E
	cmp r1,#0x40	; 0230D460
	bne loc_0230D492	; 0230D462
	ldr r1,[pool_0230D4CC]	; 0230D464
	ldrh r1,[r0,r1]	; 0230D466
	lsl r1,r1,#0x1f	; 0230D468
	lsr r1,r1,#0x1f	; 0230D46A
	cmp r1,#0x0	; 0230D46C
	beq loc_0230D492	; 0230D46E
	ldr r1,[pool_0230D4B4]	; 0230D470
	ldr r3,[r0,r1]	; 0230D472
	ldr r1,[pool_0230D4D0]	; 0230D474
	ldrh r2,[r0,r1]	; 0230D476
	mov r1,#0x1c	; 0230D478
	mul r2,r1	; 0230D47A
	add r1,r3,r2	; 0230D47C
	ldrh r1,[r1,#0x16]	; 0230D47E
	cmp r1,#0x0	; 0230D480
	bne loc_0230D492	; 0230D482
	ldr r1,[pool_0230D4D4]	; 0230D484
	ldrh r0,[r0,r1]	; 0230D486
	cmp r0,#0x0	; 0230D488
	bne loc_0230D492	; 0230D48A
	mov r0,#0x1	; 0230D48C
	bl loc_02306810	; 0230D48E
loc_0230D492:
	add sp,#0x4	; 0230D492
	pop {r4,r5,r6,r7}	; 0230D494
	pop {r3}	; 0230D496
	bx r3	; 0230D498
	.byte 0xC0, 0x46	; 0230D49C
pool_0230D49C:
loc_0230D49C:
	.word FirmwareWlWorkPointerSlot	; 0230D49C
pool_0230D4A0:
loc_0230D4A0:
	.word 0x000004F4	; 0230D4A0
pool_0230D4A4:
loc_0230D4A4:
	.word 0x00000158	; 0230D4A4
pool_0230D4A8:
loc_0230D4A8:
	.word 0x000003E4	; 0230D4A8
pool_0230D4AC:
loc_0230D4AC:
	.word 0x000004EA	; 0230D4AC
pool_0230D4B0:
loc_0230D4B0:
	.word 0x00002000	; 0230D4B0
pool_0230D4B4:
loc_0230D4B4:
	.word 0x000002E0	; 0230D4B4
pool_0230D4B8:
loc_0230D4B8:
	.word 0x000004EC	; 0230D4B8
pool_0230D4BC:
loc_0230D4BC:
	.word 0x00000160	; 0230D4BC
pool_0230D4C0:
loc_0230D4C0:
	.word 0x00000314	; 0230D4C0
pool_0230D4C4:
loc_0230D4C4:
	.word 0x0000FFFE	; 0230D4C4
pool_0230D4C8:
loc_0230D4C8:
	.word 0x00000310	; 0230D4C8
pool_0230D4CC:
loc_0230D4CC:
	.word 0x00000316	; 0230D4CC
pool_0230D4D0:
loc_0230D4D0:
	.word 0x00000384	; 0230D4D0
pool_0230D4D4:
loc_0230D4D4:
	.word 0x0000038A	; 0230D4D4

; ===== function loc_0230D4D8 =====
loc_0230D4D8:
	push {r4,r5,lr}	; 0230D4D8
	sub sp,#0x4	; 0230D4DA
	add r5,r0,#0x0	; 0230D4DC
	add r4,r1,#0x0	; 0230D4DE
	add r4,#0x10	; 0230D4E0
	ldrh r3,[r4,#0x14]	; 0230D4E2
	ldr r2,[pool_0230D5A4]	; 0230D4E4
	and r3,r2	; 0230D4E6
	cmp r3,#0x0	; 0230D4E8
	beq loc_0230D554	; 0230D4EA
	ldrh r2,[r1,#0xc]	; 0230D4EC
	ldr r1,[pool_0230D5A8]	; 0230D4EE
	cmp r2,r1	; 0230D4F0
	bne loc_0230D504	; 0230D4F2
	add r1,r4,#0x0	; 0230D4F4
	add r1,#0x8	; 0230D4F6
	add r2,r4,#0x0	; 0230D4F8
	add r2,#0x2c	; 0230D4FA
	ldrh r3,[r4,#0x6]	; 0230D4FC
	bl loc_02305408	; 0230D4FE
	b loc_0230D510	; 0230D502
loc_0230D504:
	add r1,r4,#0x0	; 0230D504
	add r1,#0x8	; 0230D506
	ldr r2,[r4,#0x2c]	; 0230D508
	ldrh r3,[r4,#0x6]	; 0230D50A
	bl loc_02305408	; 0230D50C
loc_0230D510:
	ldr r2,[pool_0230D5AC]	; 0230D510
	ldrh r1,[r2,#0x0]	; 0230D512
	ldrh r0,[r2,#0x0]	; 0230D514
	lsl r0,r0,#0x8	; 0230D516
	add r0,r1,r0	; 0230D518
	strh r0,[r5,#0x24]	; 0230D51A
	ldrh r0,[r2,#0x0]	; 0230D51C
	mov r1,#0xff	; 0230D51E
	and r0,r1	; 0230D520
	ldr r3,[pool_0230D5B0]	; 0230D522
	ldr r2,[r3,#0x0]	; 0230D524
	ldr r1,[pool_0230D5B4]	; 0230D526
	ldrh r1,[r2,r1]	; 0230D528
	lsl r1,r1,#0xe	; 0230D52A
	orr r0,r1	; 0230D52C
	strh r0,[r5,#0x26]	; 0230D52E
	ldr r1,[r3,#0x0]	; 0230D530
	ldr r0,[pool_0230D5B8]	; 0230D532
	ldrh r1,[r1,r0]	; 0230D534
	mov r0,#0x8	; 0230D536
	and r1,r0	; 0230D538
	cmp r1,#0x0	; 0230D53A
	beq loc_0230D576	; 0230D53C
	add r1,r5,#0x0	; 0230D53E
	add r1,#0xc	; 0230D540
	ldrh r0,[r4,#0x12]	; 0230D542
	add r0,r1,r0	; 0230D544
	sub r1,r0,#0x7	; 0230D546
	mov r0,#0x1	; 0230D548
	bic r1,r0	; 0230D54A
	mov r0,#0x0	; 0230D54C
	strh r0,[r1,#0x0]	; 0230D54E
	strh r0,[r1,#0x2]	; 0230D550
	b loc_0230D576	; 0230D552
loc_0230D554:
	ldrh r2,[r1,#0xc]	; 0230D554
	ldr r1,[pool_0230D5A8]	; 0230D556
	cmp r2,r1	; 0230D558
	bne loc_0230D56A	; 0230D55A
	add r1,r4,#0x0	; 0230D55C
	add r1,#0x8	; 0230D55E
	ldrh r2,[r4,#0x6]	; 0230D560
	add r2,#0x24	; 0230D562
	bl loc_02305458	; 0230D564
	b loc_0230D576	; 0230D568
loc_0230D56A:
	add r1,r4,#0x0	; 0230D56A
	add r1,#0x8	; 0230D56C
	ldr r2,[r4,#0x2c]	; 0230D56E
	ldrh r3,[r4,#0x6]	; 0230D570
	bl loc_02305430	; 0230D572
loc_0230D576:
	ldr r0,[pool_0230D5B0]	; 0230D576
	ldr r1,[r0,#0x0]	; 0230D578
	ldr r0,[pool_0230D5B8]	; 0230D57A
	ldrh r1,[r1,r0]	; 0230D57C
	mov r0,#0x4	; 0230D57E
	and r1,r0	; 0230D580
	cmp r1,#0x0	; 0230D582
	beq loc_0230D59A	; 0230D584
	add r5,#0xc	; 0230D586
	ldrh r0,[r4,#0x12]	; 0230D588
	add r0,r5,r0	; 0230D58A
	sub r1,r0,#0x1	; 0230D58C
	mov r0,#0x3	; 0230D58E
	bic r1,r0	; 0230D590
	ldr r0,[pool_0230D5BC]	; 0230D592
	strh r0,[r1,#0x0]	; 0230D594
	ldr r0,[pool_0230D5C0]	; 0230D596
	strh r0,[r1,#0x2]	; 0230D598
loc_0230D59A:
	add sp,#0x4	; 0230D59A
	pop {r4,r5}	; 0230D59C
	pop {r3}	; 0230D59E
	bx r3	; 0230D5A0
	.byte 0xC0, 0x46	; 0230D5A4
pool_0230D5A4:
loc_0230D5A4:
	.word 0x00004000	; 0230D5A4
pool_0230D5A8:
loc_0230D5A8:
	.word 0x0000FFFF	; 0230D5A8
pool_0230D5AC:
loc_0230D5AC:
	.word REG_WIFI_RANDOM	; 0230D5AC
pool_0230D5B0:
loc_0230D5B0:
	.word FirmwareWlWorkPointerSlot	; 0230D5B0
pool_0230D5B4:
loc_0230D5B4:
	.word 0x000002FA	; 0230D5B4
pool_0230D5B8:
loc_0230D5B8:
	.word 0x0000061C	; 0230D5B8
pool_0230D5BC:
loc_0230D5BC:
	.word 0x0000B6B8	; 0230D5BC
pool_0230D5C0:
loc_0230D5C0:
	.word 0x00001D46	; 0230D5C0

; ===== function loc_0230D5C4 =====
loc_0230D5C4:
	push {r4,r5,r6,lr}	; 0230D5C4
	ldr r0,[pool_0230D640]	; 0230D5C6
	ldr r1,[r0,#0x0]	; 0230D5C8
	ldr r0,[pool_0230D644]	; 0230D5CA
	ldrh r4,[r1,r0]	; 0230D5CC
	cmp r4,#0x0	; 0230D5CE
	beq loc_0230D63A	; 0230D5D0
	ldr r0,[pool_0230D648]	; 0230D5D2
	bl loc_02304B48	; 0230D5D4
	add r6,r0,#0x0	; 0230D5D8
	ldr r1,[pool_0230D640]	; 0230D5DA
	ldr r3,[r1,#0x0]	; 0230D5DC
	ldr r2,[pool_0230D64C]	; 0230D5DE
	add r2,r3,r2	; 0230D5E0
	ldrh r3,[r2,#0x0]	; 0230D5E2
	cmp r3,#0x0	; 0230D5E4
	beq loc_0230D5EE	; 0230D5E6
	bl loc_02304B58	; 0230D5E8
	b loc_0230D63A	; 0230D5EC
loc_0230D5EE:
	mov r0,#0x1	; 0230D5EE
	strh r0,[r2,#0x0]	; 0230D5F0
	ldr r2,[r1,#0x0]	; 0230D5F2
	ldr r0,[pool_0230D650]	; 0230D5F4
	add r2,r2,r0	; 0230D5F6
	ldrh r0,[r2,#0x0]	; 0230D5F8
	add r0,r0,#0x1	; 0230D5FA
	strh r0,[r2,#0x0]	; 0230D5FC
	ldr r0,[r1,#0x0]	; 0230D5FE
	ldr r1,[pool_0230D654]	; 0230D600
	ldr r1,[r0,r1]	; 0230D602
	ldr r2,[pool_0230D658]	; 0230D604
	ldr r5,[r0,r2]	; 0230D606
	add r3,r1,#0x0	; 0230D608
	add r3,#0x10	; 0230D60A
	ldr r2,[pool_0230D65C]	; 0230D60C
	str r3,[r0,r2]	; 0230D60E
	add r0,r5,#0x0	; 0230D610
	bl loc_0230D4D8	; 0230D612
	cmp r4,#0x1	; 0230D616
	bls loc_0230D626	; 0230D618
	add r2,r5,#0x0	; 0230D61A
	add r2,#0xc	; 0230D61C
	ldrh r1,[r2,#0x0]	; 0230D61E
	ldr r0,[pool_0230D660]	; 0230D620
	orr r1,r0	; 0230D622
	strh r1,[r2,#0x0]	; 0230D624
loc_0230D626:
	ldr r0,[pool_0230D664]	; 0230D626
	and r5,r0	; 0230D628
	lsr r1,r5,#0x1	; 0230D62A
	ldr r0,[pool_0230D668]	; 0230D62C
	orr r1,r0	; 0230D62E
	ldr r0,[pool_0230D66C]	; 0230D630
	strh r1,[r0,#0x0]	; 0230D632
	add r0,r6,#0x0	; 0230D634
	bl loc_02304B58	; 0230D636
loc_0230D63A:
	pop {r4,r5,r6}	; 0230D63A
	pop {r3}	; 0230D63C
	bx r3	; 0230D63E
pool_0230D640:
loc_0230D640:
	.word FirmwareWlWorkPointerSlot	; 0230D640
pool_0230D644:
loc_0230D644:
	.word 0x00000178	; 0230D644
pool_0230D648:
loc_0230D648:
	.word 0x01000000	; 0230D648
pool_0230D64C:
loc_0230D64C:
	.word 0x0000040C	; 0230D64C
pool_0230D650:
loc_0230D650:
	.word 0x0000040E	; 0230D650
pool_0230D654:
loc_0230D654:
	.word 0x00000170	; 0230D654
pool_0230D658:
loc_0230D658:
	.word 0x00000414	; 0230D658
pool_0230D65C:
loc_0230D65C:
	.word 0x00000418	; 0230D65C
pool_0230D660:
loc_0230D660:
	.word 0x00002000	; 0230D660
pool_0230D664:
loc_0230D664:
	.word 0x00003FFF	; 0230D664
pool_0230D668:
loc_0230D668:
	.word 0x00008000	; 0230D668
pool_0230D66C:
loc_0230D66C:
	.word REG_WIFI_TXBUF_LOC3	; 0230D66C

; ===== function loc_0230D670 =====
loc_0230D670:
	push {r4,r5,r6,r7,lr}	; 0230D670
	sub sp,#0xc	; 0230D672
	add r6,r0,#0x0	; 0230D674
	mov r0,#0xc	; 0230D676
	add r4,r6,#0x0	; 0230D678
	mul r4,r0	; 0230D67A
	ldr r0,[pool_0230D81C]	; 0230D67C
	ldr r0,[r0,#0x0]	; 0230D67E
	add r1,r0,r4	; 0230D680
	ldr r0,[pool_0230D820]	; 0230D682
	ldrh r0,[r1,r0]	; 0230D684
	cmp r0,#0x0	; 0230D686
	bne loc_0230D68C	; 0230D688
	b loc_0230D812	; 0230D68A
loc_0230D68C:
	ldr r0,[pool_0230D824]	; 0230D68C
	bl loc_02304B48	; 0230D68E
	str r0,[sp,#0x8]	; 0230D692
	mov r1,#0x14	; 0230D694
	add r5,r6,#0x0	; 0230D696
	mul r5,r1	; 0230D698
	ldr r1,[pool_0230D81C]	; 0230D69A
	ldr r1,[r1,#0x0]	; 0230D69C
	add r3,r1,r5	; 0230D69E
	ldr r2,[pool_0230D828]	; 0230D6A0
	ldrh r2,[r3,r2]	; 0230D6A2
	cmp r2,#0x0	; 0230D6A4
	beq loc_0230D6AE	; 0230D6A6
	bl loc_02304B58	; 0230D6A8
	b loc_0230D812	; 0230D6AC
loc_0230D6AE:
	add r1,r1,r4	; 0230D6AE
	ldr r0,[pool_0230D82C]	; 0230D6B0
	ldr r0,[r1,r0]	; 0230D6B2
	str r0,[sp,#0x4]	; 0230D6B4
loc_0230D6B6:
	mov r0,#0x0	; 0230D6B6
	mvn r1,r0	; 0230D6B8
	ldr r0,[sp,#0x4]	; 0230D6BA
	cmp r0,r1	; 0230D6BC
	bne loc_0230D6C8	; 0230D6BE
	ldr r0,[sp,#0x8]	; 0230D6C0
	bl loc_02304B58	; 0230D6C2
	b loc_0230D812	; 0230D6C6
loc_0230D6C8:
	str r0,[sp,#0x0]	; 0230D6C8
	bl loc_02304E5C	; 0230D6CA
	str r0,[sp,#0x4]	; 0230D6CE
	ldr r4,[sp,#0x0]	; 0230D6D0
	add r4,#0x10	; 0230D6D2
	ldrh r7,[r4,#0x2]	; 0230D6D4
	ldr r0,[pool_0230D81C]	; 0230D6D6
	ldr r2,[r0,#0x0]	; 0230D6D8
	ldr r0,[pool_0230D830]	; 0230D6DA
	ldr r1,[r2,r0]	; 0230D6DC
	ldrh r0,[r4,#0x4]	; 0230D6DE
	sub r0,r1,r0	; 0230D6E0
	lsl r0,r0,#0x10	; 0230D6E2
	lsr r0,r0,#0x10	; 0230D6E4
	ldr r1,[pool_0230D834]	; 0230D6E6
	ldrh r1,[r2,r1]	; 0230D6E8
	cmp r0,r1	; 0230D6EA
	bls loc_0230D716	; 0230D6EC
	ldr r0,[pool_0230D828]	; 0230D6EE
	add r0,r2,r0	; 0230D6F0
	add r3,r0,r5	; 0230D6F2
	ldr r0,[pool_0230D838]	; 0230D6F4
	add r1,r2,r0	; 0230D6F6
	ldrh r0,[r1,#0x0]	; 0230D6F8
	add r0,r0,#0x1	; 0230D6FA
	strh r0,[r1,#0x0]	; 0230D6FC
	mov r0,#0x2	; 0230D6FE
	strh r0,[r4,#0x8]	; 0230D700
	add r1,r3,#0x4	; 0230D702
	ldrh r0,[r1,#0x0]	; 0230D704
	add r0,r0,#0x1	; 0230D706
	strh r0,[r1,#0x0]	; 0230D708
	add r0,r4,#0x0	; 0230D70A
	mov r1,#0x0	; 0230D70C
	ldr r2,[r3,#0x10]	; 0230D70E
	bl loc_02308C84	; 0230D710
	b loc_0230D6B6	; 0230D714
loc_0230D716:
	cmp r6,#0x0	; 0230D716
	bne loc_0230D754	; 0230D718
	ldr r0,[pool_0230D83C]	; 0230D71A
	ldrh r1,[r2,r0]	; 0230D71C
	asr r1,r7	; 0230D71E
	mov r0,#0x1	; 0230D720
	and r1,r0	; 0230D722
	cmp r1,#0x0	; 0230D724
	beq loc_0230D6B6	; 0230D726
	ldr r0,[pool_0230D840]	; 0230D728
	ldr r1,[r2,r0]	; 0230D72A
	add r3,r7,#0x0	; 0230D72C
	mov r0,#0x1c	; 0230D72E
	mul r3,r0	; 0230D730
	ldrh r0,[r1,r3]	; 0230D732
	cmp r0,#0x40	; 0230D734
	beq loc_0230D754	; 0230D736
	mov r0,#0x2	; 0230D738
	strh r0,[r4,#0x8]	; 0230D73A
	ldr r0,[pool_0230D81C]	; 0230D73C
	ldr r1,[r0,#0x0]	; 0230D73E
	ldr r0,[pool_0230D82C]	; 0230D740
	add r0,r1,r0	; 0230D742
	add r1,r4,#0x0	; 0230D744
	sub r1,#0x10	; 0230D746
	bl loc_0230B1AC	; 0230D748
	add r0,r4,#0x0	; 0230D74C
	bl loc_023092B8	; 0230D74E
	b loc_0230D6B6	; 0230D752
loc_0230D754:
	mov r0,#0x1	; 0230D754
	add r2,r2,r5	; 0230D756
	ldr r1,[pool_0230D828]	; 0230D758
	strh r0,[r2,r1]	; 0230D75A
	ldr r0,[pool_0230D81C]	; 0230D75C
	ldr r1,[r0,#0x0]	; 0230D75E
	add r2,r1,r5	; 0230D760
	ldr r1,[pool_0230D844]	; 0230D762
	add r1,r2,r1	; 0230D764
	ldrh r2,[r1,#0x0]	; 0230D766
	add r2,r2,#0x1	; 0230D768
	strh r2,[r1,#0x0]	; 0230D76A
	ldr r1,[r0,#0x0]	; 0230D76C
	add r2,r1,r5	; 0230D76E
	ldr r1,[pool_0230D848]	; 0230D770
	str r4,[r2,r1]	; 0230D772
	ldr r0,[r0,#0x0]	; 0230D774
	add r2,r0,r5	; 0230D776
	ldr r1,[pool_0230D84C]	; 0230D778
	ldr r5,[r2,r1]	; 0230D77A
	ldr r1,[pool_0230D850]	; 0230D77C
	ldrh r0,[r0,r1]	; 0230D77E
	lsl r0,r0,#0x1e	; 0230D780
	lsr r0,r0,#0x1f	; 0230D782
	cmp r0,#0x1	; 0230D784
	bne loc_0230D78E	; 0230D786
	mov r0,#0x2	; 0230D788
	bl loc_02306810	; 0230D78A
loc_0230D78E:
	add r0,r5,#0x0	; 0230D78E
	ldr r1,[sp,#0x0]	; 0230D790
	bl loc_0230D4D8	; 0230D792
	ldr r0,[pool_0230D81C]	; 0230D796
	ldr r0,[r0,#0x0]	; 0230D798
	ldr r1,[pool_0230D854]	; 0230D79A
	ldrh r1,[r0,r1]	; 0230D79C
	cmp r1,#0x1	; 0230D79E
	bne loc_0230D7BE	; 0230D7A0
	ldr r1,[pool_0230D840]	; 0230D7A2
	ldr r1,[r0,r1]	; 0230D7A4
	mov r0,#0x1c	; 0230D7A6
	mul r7,r0	; 0230D7A8
	add r0,r1,r7	; 0230D7AA
	ldrh r0,[r0,#0x16]	; 0230D7AC
	cmp r0,#0x1	; 0230D7AE
	bls loc_0230D7BE	; 0230D7B0
	add r2,r5,#0x0	; 0230D7B2
	add r2,#0xc	; 0230D7B4
	ldrh r1,[r2,#0x0]	; 0230D7B6
	ldr r0,[pool_0230D858]	; 0230D7B8
	orr r1,r0	; 0230D7BA
	strh r1,[r2,#0x0]	; 0230D7BC
loc_0230D7BE:
	ldrh r2,[r4,#0x14]	; 0230D7BE
	mov r0,#0xc	; 0230D7C0
	add r1,r2,#0x0	; 0230D7C2
	and r1,r0	; 0230D7C4
	cmp r1,#0x4	; 0230D7C6
	bne loc_0230D7DE	; 0230D7C8
	ldr r0,[pool_0230D85C]	; 0230D7CA
	and r5,r0	; 0230D7CC
	lsl r0,r5,#0xf	; 0230D7CE
	lsr r2,r0,#0x10	; 0230D7D0
	ldr r0,[pool_0230D860]	; 0230D7D2
	orr r2,r0	; 0230D7D4
	lsl r1,r6,#0x2	; 0230D7D6
	ldr r0,[pool_0230D864]	; 0230D7D8
	strh r2,[r1,r0]	; 0230D7DA
	b loc_0230D80C	; 0230D7DC
loc_0230D7DE:
	mov r0,#0xfc	; 0230D7DE
	and r2,r0	; 0230D7E0
	cmp r2,#0x50	; 0230D7E2
	bne loc_0230D7FA	; 0230D7E4
	ldr r0,[pool_0230D85C]	; 0230D7E6
	and r5,r0	; 0230D7E8
	lsl r0,r5,#0xf	; 0230D7EA
	lsr r2,r0,#0x10	; 0230D7EC
	ldr r0,[pool_0230D868]	; 0230D7EE
	orr r2,r0	; 0230D7F0
	lsl r1,r6,#0x2	; 0230D7F2
	ldr r0,[pool_0230D864]	; 0230D7F4
	strh r2,[r1,r0]	; 0230D7F6
	b loc_0230D80C	; 0230D7F8
loc_0230D7FA:
	ldr r0,[pool_0230D85C]	; 0230D7FA
	and r5,r0	; 0230D7FC
	lsl r0,r5,#0xf	; 0230D7FE
	lsr r2,r0,#0x10	; 0230D800
	ldr r0,[pool_0230D86C]	; 0230D802
	orr r2,r0	; 0230D804
	lsl r1,r6,#0x2	; 0230D806
	ldr r0,[pool_0230D864]	; 0230D808
	strh r2,[r1,r0]	; 0230D80A
loc_0230D80C:
	ldr r0,[sp,#0x8]	; 0230D80C
	bl loc_02304B58	; 0230D80E
loc_0230D812:
	add sp,#0xc	; 0230D812
	pop {r4,r5,r6,r7}	; 0230D814
	pop {r3}	; 0230D816
	bx r3	; 0230D818
	.byte 0xC0, 0x46	; 0230D81C
pool_0230D81C:
loc_0230D81C:
	.word FirmwareWlWorkPointerSlot	; 0230D81C
pool_0230D820:
loc_0230D820:
	.word 0x00000160	; 0230D820
pool_0230D824:
loc_0230D824:
	.word 0x01000000	; 0230D824
pool_0230D828:
loc_0230D828:
	.word 0x000003E4	; 0230D828
pool_0230D82C:
loc_0230D82C:
	.word 0x00000158	; 0230D82C
pool_0230D830:
loc_0230D830:
	.word 0x000003A4	; 0230D830
pool_0230D834:
loc_0230D834:
	.word 0x00000388	; 0230D834
pool_0230D838:
loc_0230D838:
	.word 0x00000494	; 0230D838
pool_0230D83C:
loc_0230D83C:
	.word 0x000004EC	; 0230D83C
pool_0230D840:
loc_0230D840:
	.word 0x000002E0	; 0230D840
pool_0230D844:
loc_0230D844:
	.word 0x000003E6	; 0230D844
pool_0230D848:
loc_0230D848:
	.word 0x000003F0	; 0230D848
pool_0230D84C:
loc_0230D84C:
	.word 0x000003EC	; 0230D84C
pool_0230D850:
loc_0230D850:
	.word 0x00000316	; 0230D850
pool_0230D854:
loc_0230D854:
	.word 0x00000314	; 0230D854
pool_0230D858:
loc_0230D858:
	.word 0x00002000	; 0230D858
pool_0230D85C:
loc_0230D85C:
	.word 0x00003FFF	; 0230D85C
pool_0230D860:
loc_0230D860:
	.word 0x0000A000	; 0230D860
pool_0230D864:
loc_0230D864:
	.word REG_WIFI_TXBUF_LOC1	; 0230D864
pool_0230D868:
loc_0230D868:
	.word 0x00009000	; 0230D868
pool_0230D86C:
loc_0230D86C:
	.word 0x00008000	; 0230D86C

; ===== function loc_0230D870 =====
loc_0230D870:
	push {lr}	; 0230D870
	sub sp,#0x4	; 0230D872
	mov r0,#0x0	; 0230D874
	str r0,[sp,#0x0]	; 0230D876
	ldr r0,[sp,#0x0]	; 0230D878
	ldr r1,[pool_0230D944]	; 0230D87A
	ldr r2,[r1,#0x0]	; 0230D87C
	ldr r1,[pool_0230D948]	; 0230D87E
	add r1,r2,r1	; 0230D880
	mov r2,#0x50	; 0230D882
	bl loc_0230D9AC	; 0230D884
	ldr r1,[pool_0230D94C]	; 0230D888
	ldr r0,[pool_0230D950]	; 0230D88A
	strh r1,[r0,#0x0]	; 0230D88C
	ldr r0,[pool_0230D944]	; 0230D88E
	ldr r2,[r0,#0x0]	; 0230D890
	ldr r1,[pool_0230D954]	; 0230D892
	ldrh r1,[r2,r1]	; 0230D894
	cmp r1,#0x3	; 0230D896
	bhi loc_0230D906	; 0230D898
	add r1,r1,r1	; 0230D89A
P4_SwitchIndexPC_0230D89A:
	add r1,pc	; 0230D89C
	ldrh r1,[r1,#(P4_SwitchTable_0230D89A - (P4_SwitchIndexPC_0230D89A + 4))]	; 0230D89E
	lsl r1,r1,#0x10	; 0230D8A0
	asr r1,r1,#0x10	; 0230D8A2
P4_SwitchTargetPC_0230D89A:
	add r1,pc	; 0230D8A4
	bx r1	; 0230D8A6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230D89A:
	.halfword (loc_0230D8B0 + 1) - (P4_SwitchTargetPC_0230D89A + 4)
	.halfword (loc_0230D8C6 + 1) - (P4_SwitchTargetPC_0230D89A + 4)
	.halfword (loc_0230D8DC + 1) - (P4_SwitchTargetPC_0230D89A + 4)
	.halfword (loc_0230D8F2 + 1) - (P4_SwitchTargetPC_0230D89A + 4)
P4_SwitchTable_0230D89AEnd:
loc_0230D8B0:
	ldr r2,[pool_0230D958]	; 0230D8B0
	ldr r1,[pool_0230D95C]	; 0230D8B2
	strh r2,[r1,#0x0]	; 0230D8B4
	ldr r2,[pool_0230D960]	; 0230D8B6
	ldr r1,[pool_0230D964]	; 0230D8B8
	strh r2,[r1,#0x0]	; 0230D8BA
	ldr r2,[pool_0230D968]	; 0230D8BC
	ldr r1,[r0,#0x0]	; 0230D8BE
	ldr r0,[pool_0230D96C]	; 0230D8C0
	strh r2,[r1,r0]	; 0230D8C2
	b loc_0230D906	; 0230D8C4
loc_0230D8C6:
	ldr r2,[pool_0230D970]	; 0230D8C6
	ldr r1,[pool_0230D95C]	; 0230D8C8
	strh r2,[r1,#0x0]	; 0230D8CA
	ldr r2,[pool_0230D974]	; 0230D8CC
	ldr r1,[pool_0230D964]	; 0230D8CE
	strh r2,[r1,#0x0]	; 0230D8D0
	ldr r2,[pool_0230D978]	; 0230D8D2
	ldr r1,[r0,#0x0]	; 0230D8D4
	ldr r0,[pool_0230D96C]	; 0230D8D6
	strh r2,[r1,r0]	; 0230D8D8
	b loc_0230D906	; 0230D8DA
loc_0230D8DC:
	ldr r2,[pool_0230D97C]	; 0230D8DC
	ldr r1,[pool_0230D95C]	; 0230D8DE
	strh r2,[r1,#0x0]	; 0230D8E0
	ldr r2,[pool_0230D980]	; 0230D8E2
	ldr r1,[pool_0230D964]	; 0230D8E4
	strh r2,[r1,#0x0]	; 0230D8E6
	ldr r2,[pool_0230D984]	; 0230D8E8
	ldr r1,[r0,#0x0]	; 0230D8EA
	ldr r0,[pool_0230D96C]	; 0230D8EC
	strh r2,[r1,r0]	; 0230D8EE
	b loc_0230D906	; 0230D8F0
loc_0230D8F2:
	ldr r2,[pool_0230D958]	; 0230D8F2
	ldr r1,[pool_0230D95C]	; 0230D8F4
	strh r2,[r1,#0x0]	; 0230D8F6
	ldr r2,[pool_0230D960]	; 0230D8F8
	ldr r1,[pool_0230D964]	; 0230D8FA
	strh r2,[r1,#0x0]	; 0230D8FC
	ldr r2,[pool_0230D968]	; 0230D8FE
	ldr r1,[r0,#0x0]	; 0230D900
	ldr r0,[pool_0230D96C]	; 0230D902
	strh r2,[r1,r0]	; 0230D904
loc_0230D906:
	ldr r1,[pool_0230D988]	; 0230D906
	ldr r0,[pool_0230D98C]	; 0230D908
	strh r1,[r0,#0x0]	; 0230D90A
	ldr r0,[pool_0230D95C]	; 0230D90C
	ldrh r0,[r0,#0x0]	; 0230D90E
	ldr r1,[pool_0230D990]	; 0230D910
	and r0,r1	; 0230D912
	mov r1,#0x2	; 0230D914
	bl loc_0230D9B8	; 0230D916
	ldr r1,[pool_0230D994]	; 0230D91A
	strh r0,[r1,#0x0]	; 0230D91C
	ldrh r2,[r1,#0x0]	; 0230D91E
	ldr r3,[pool_0230D944]	; 0230D920
	ldr r1,[r3,#0x0]	; 0230D922
	ldr r0,[pool_0230D998]	; 0230D924
	strh r2,[r1,r0]	; 0230D926
	ldr r1,[pool_0230D99C]	; 0230D928
	ldr r0,[pool_0230D9A0]	; 0230D92A
	strh r1,[r0,#0x0]	; 0230D92C
	ldr r1,[pool_0230D9A4]	; 0230D92E
	ldr r0,[pool_0230D950]	; 0230D930
	strh r1,[r0,#0x0]	; 0230D932
	ldr r2,[pool_0230D9A8]	; 0230D934
	ldr r1,[r3,#0x0]	; 0230D936
	ldr r0,[pool_0230D948]	; 0230D938
	strh r2,[r1,r0]	; 0230D93A
	add sp,#0x4	; 0230D93C
	pop {r3}	; 0230D93E
	bx r3	; 0230D940
	.byte 0xC0, 0x46	; 0230D944
pool_0230D944:
loc_0230D944:
	.word FirmwareWlWorkPointerSlot	; 0230D944
pool_0230D948:
loc_0230D948:
	.word 0x00000498	; 0230D948
pool_0230D94C:
loc_0230D94C:
	.word 0x00008000	; 0230D94C
pool_0230D950:
loc_0230D950:
	.word REG_WIFI_RXCNT	; 0230D950
pool_0230D954:
loc_0230D954:
	.word 0x00000314	; 0230D954
pool_0230D958:
loc_0230D958:
	.word 0x00004794	; 0230D958
pool_0230D95C:
loc_0230D95C:
	.word REG_WIFI_RXBUF_BEGIN	; 0230D95C
pool_0230D960:
loc_0230D960:
	.word 0x000003CA	; 0230D960
pool_0230D964:
loc_0230D964:
	.word REG_WIFI_RXBUF_WR_ADDR	; 0230D964
pool_0230D968:
loc_0230D968:
	.word 0x000017CC	; 0230D968
pool_0230D96C:
loc_0230D96C:
	.word 0x00000396	; 0230D96C
pool_0230D970:
loc_0230D970:
	.word 0x000050C0	; 0230D970
pool_0230D974:
loc_0230D974:
	.word 0x00000860	; 0230D974
pool_0230D978:
loc_0230D978:
	.word 0x00000EA0	; 0230D978
pool_0230D97C:
loc_0230D97C:
	.word 0x00004BF4	; 0230D97C
pool_0230D980:
loc_0230D980:
	.word 0x000005FA	; 0230D980
pool_0230D984:
loc_0230D984:
	.word 0x0000136C	; 0230D984
pool_0230D988:
loc_0230D988:
	.word 0x00005F60	; 0230D988
pool_0230D98C:
loc_0230D98C:
	.word REG_WIFI_RXBUF_END	; 0230D98C
pool_0230D990:
loc_0230D990:
	.word 0x00003FFF	; 0230D990
pool_0230D994:
loc_0230D994:
	.word REG_WIFI_RXBUF_READCSR	; 0230D994
pool_0230D998:
loc_0230D998:
	.word 0x0000049C	; 0230D998
pool_0230D99C:
loc_0230D99C:
	.word 0x00005F5E	; 0230D99C
pool_0230D9A0:
loc_0230D9A0:
	.word REG_WIFI_RXBUF_GAP	; 0230D9A0
pool_0230D9A4:
loc_0230D9A4:
	.word 0x00008001	; 0230D9A4
pool_0230D9A8:
loc_0230D9A8:
	.word 0x0000FFFF	; 0230D9A8

; ===== function loc_0230D9AC =====
loc_0230D9AC:
	bx pc	; 0230D9AC
	.byte 0xC0, 0x46	; 0230D9B0
.arm

; ===== function loc_0230D9B0 =====
loc_0230D9B0:
	ldr pc,[pool_0230D9B4]	; 0230D9B0
pool_0230D9B4:
loc_0230D9B4:
	.word loc_037FCE38	; 0230D9B4
.thumb

; ===== function loc_0230D9B8 =====
loc_0230D9B8:
	bx pc	; 0230D9B8
	.byte 0xC0, 0x46	; 0230D9BC
.arm

; ===== function loc_0230D9BC =====
loc_0230D9BC:
	ldr pc,[pool_0230D9C0]	; 0230D9BC
pool_0230D9C0:
loc_0230D9C0:
	.word loc_03802514	; 0230D9C0
.thumb

; ===== function loc_0230D9C4 =====
	push {r4,r5,r6,r7,lr}	; 0230D9C4
	sub sp,#0x4	; 0230D9C6
	ldr r6,[pool_0230DA04]	; 0230D9C8
	ldr r1,[r6,#0x0]	; 0230D9CA
	ldr r0,[pool_0230DA08]	; 0230D9CC
	add r5,r1,r0	; 0230D9CE
	mov r4,#0x0	; 0230D9D0
	mov r7,#0x18	; 0230D9D2
loc_0230D9D4:
	add r0,r4,#0x0	; 0230D9D4
	mul r0,r7	; 0230D9D6
	add r1,r5,r0	; 0230D9D8
	ldrh r0,[r5,r0]	; 0230D9DA
	cmp r0,#0x0	; 0230D9DC
	beq loc_0230D9F6	; 0230D9DE
	sub r0,r0,#0x1	; 0230D9E0
	strh r0,[r1,#0x0]	; 0230D9E2
	ldrh r0,[r1,#0x0]	; 0230D9E4
	cmp r0,#0x0	; 0230D9E6
	bne loc_0230D9F6	; 0230D9E8
	ldr r2,[r6,#0x0]	; 0230D9EA
	ldr r0,[pool_0230DA0C]	; 0230D9EC
	add r0,r2,r0	; 0230D9EE
	ldr r1,[r1,#0x14]	; 0230D9F0
	bl loc_02304FF8	; 0230D9F2
loc_0230D9F6:
	add r4,r4,#0x1	; 0230D9F6
	cmp r4,#0x3	; 0230D9F8
	bcc loc_0230D9D4	; 0230D9FA
	add sp,#0x4	; 0230D9FC
	pop {r4,r5,r6,r7}	; 0230D9FE
	pop {r3}	; 0230DA00
	bx r3	; 0230DA02
pool_0230DA04:
loc_0230DA04:
	.word FirmwareWlWorkPointerSlot	; 0230DA04
pool_0230DA08:
loc_0230DA08:
	.word 0x000004A0	; 0230DA08
pool_0230DA0C:
loc_0230DA0C:
	.word 0x0000014C	; 0230DA0C

; ===== function loc_0230DA10 =====
loc_0230DA10:
	push {r4,r5,r6,r7,lr}	; 0230DA10
	sub sp,#0x14	; 0230DA12
	add r7,r0,#0x0	; 0230DA14
	add r2,r1,#0x0	; 0230DA16
	ldr r0,[pool_0230DBBC]	; 0230DA18
	ldr r1,[r0,#0x0]	; 0230DA1A
	ldr r0,[pool_0230DBC0]	; 0230DA1C
	add r6,r1,r0	; 0230DA1E
	add r1,r7,#0x0	; 0230DA20
	add r1,#0x8	; 0230DA22
	ldrh r0,[r1,#0x0]	; 0230DA24
	sub r0,#0x18	; 0230DA26
	strh r0,[r1,#0x0]	; 0230DA28
	mov r4,#0x0	; 0230DA2A
	b loc_0230DAB0	; 0230DA2C
loc_0230DA2E:
	add r3,r4,#0x0	; 0230DA2E
	mov r0,#0x18	; 0230DA30
	mul r3,r0	; 0230DA32
	add r1,r6,r3	; 0230DA34
	ldrh r0,[r6,r3]	; 0230DA36
	cmp r0,#0x0	; 0230DA38
	beq loc_0230DAAE	; 0230DA3A
	ldrh r3,[r2,#0x4]	; 0230DA3C
	ldrh r0,[r1,#0x8]	; 0230DA3E
	cmp r3,r0	; 0230DA40
	bne loc_0230DAAE	; 0230DA42
	ldrh r3,[r2,#0x2]	; 0230DA44
	ldrh r0,[r1,#0x6]	; 0230DA46
	cmp r3,r0	; 0230DA48
	bne loc_0230DAAE	; 0230DA4A
	ldrh r3,[r2,#0x0]	; 0230DA4C
	ldrh r0,[r1,#0x4]	; 0230DA4E
	cmp r3,r0	; 0230DA50
	bne loc_0230DAAE	; 0230DA52
	ldrh r3,[r2,#0xa]	; 0230DA54
	ldrh r0,[r1,#0xe]	; 0230DA56
	cmp r3,r0	; 0230DA58
	bne loc_0230DAAE	; 0230DA5A
	ldrh r3,[r2,#0x8]	; 0230DA5C
	ldrh r0,[r1,#0xc]	; 0230DA5E
	cmp r3,r0	; 0230DA60
	bne loc_0230DAAE	; 0230DA62
	ldrh r3,[r2,#0x6]	; 0230DA64
	ldrh r0,[r1,#0xa]	; 0230DA66
	cmp r3,r0	; 0230DA68
	bne loc_0230DAAE	; 0230DA6A
	ldrh r5,[r2,#0xc]	; 0230DA6C
	lsl r0,r5,#0x10	; 0230DA6E
	lsr r0,r0,#0x14	; 0230DA70
	ldrh r3,[r1,#0x10]	; 0230DA72
	str r3,[sp,#0x10]	; 0230DA74
	lsl r3,r3,#0x10	; 0230DA76
	lsr r3,r3,#0x14	; 0230DA78
	cmp r0,r3	; 0230DA7A
	bne loc_0230DAAE	; 0230DA7C
	ldr r0,[sp,#0x10]	; 0230DA7E
	sub r0,r0,r5	; 0230DA80
	str r0,[sp,#0x4]	; 0230DA82
	ldr r0,[pool_0230DBC4]	; 0230DA84
	ldr r2,[sp,#0x4]	; 0230DA86
	and r2,r0	; 0230DA88
	cmp r2,#0x0	; 0230DA8A
	beq loc_0230DA90	; 0230DA8C
	b loc_0230DBB4	; 0230DA8E
loc_0230DA90:
	ldrh r2,[r1,#0x2]	; 0230DA90
	ldr r1,[sp,#0x4]	; 0230DA92
	str r1,[sp,#0x8]	; 0230DA94
	mul r1,r2	; 0230DA96
	str r1,[sp,#0x8]	; 0230DA98
	ldrh r2,[r7,#0x8]	; 0230DA9A
	sub r1,r2,r1	; 0230DA9C
	str r1,[sp,#0xc]	; 0230DA9E
	cmp r1,#0x0	; 0230DAA0
	bne loc_0230DAA6	; 0230DAA2
	b loc_0230DBB4	; 0230DAA4
loc_0230DAA6:
	and r1,r0	; 0230DAA6
	cmp r1,#0x0	; 0230DAA8
	beq loc_0230DAB4	; 0230DAAA
	b loc_0230DBB4	; 0230DAAC
loc_0230DAAE:
	add r4,r4,#0x1	; 0230DAAE
loc_0230DAB0:
	cmp r4,#0x3	; 0230DAB0
	bcc loc_0230DA2E	; 0230DAB2
loc_0230DAB4:
	cmp r4,#0x3	; 0230DAB4
	beq loc_0230DBB4	; 0230DAB6
	mov r0,#0x18	; 0230DAB8
	mul r4,r0	; 0230DABA
	add r0,r6,r4	; 0230DABC
	ldr r5,[r0,#0x14]	; 0230DABE
	add r5,#0x10	; 0230DAC0
	ldrh r1,[r5,#0x10]	; 0230DAC2
	ldr r0,[sp,#0xc]	; 0230DAC4
	add r0,r1,r0	; 0230DAC6
	str r0,[sp,#0x0]	; 0230DAC8
	ldr r2,[pool_0230DBC8]	; 0230DACA
	cmp r0,r2	; 0230DACC
	bls loc_0230DAE6	; 0230DACE
	ldr r0,[pool_0230DBBC]	; 0230DAD0
	ldr r1,[r0,#0x0]	; 0230DAD2
	ldr r0,[pool_0230DBCC]	; 0230DAD4
	add r0,r1,r0	; 0230DAD6
	sub r5,#0x10	; 0230DAD8
	add r1,r5,#0x0	; 0230DADA
	bl loc_02304FF8	; 0230DADC
	mov r0,#0x0	; 0230DAE0
	strh r0,[r6,r4]	; 0230DAE2
	b loc_0230DBB4	; 0230DAE4
loc_0230DAE6:
	add r2,r7,#0x0	; 0230DAE6
	add r2,#0x24	; 0230DAE8
	ldr r0,[sp,#0x8]	; 0230DAEA
	add r0,r2,r0	; 0230DAEC
	add r2,r5,#0x0	; 0230DAEE
	add r2,#0x2c	; 0230DAF0
	add r1,r2,r1	; 0230DAF2
	ldr r2,[sp,#0xc]	; 0230DAF4
	add r2,r2,#0x1	; 0230DAF6
	bl loc_0230DBE0	; 0230DAF8
	ldr r0,[sp,#0x0]	; 0230DAFC
	strh r0,[r5,#0x10]	; 0230DAFE
	ldrh r0,[r7,#0x0]	; 0230DB00
	mov r1,#0xf0	; 0230DB02
	and r0,r1	; 0230DB04
	mov r1,#0x10	; 0230DB06
	bl loc_0230DBEC	; 0230DB08
	add r6,r6,r4	; 0230DB0C
	add r3,r6,#0x0	; 0230DB0E
	add r3,#0x10	; 0230DB10
	ldrh r4,[r3,#0x0]	; 0230DB12
	add r2,r4,#0x0	; 0230DB14
	mov r1,#0xf	; 0230DB16
	bic r2,r1	; 0230DB18
	lsl r1,r4,#0x1c	; 0230DB1A
	lsr r1,r1,#0x1c	; 0230DB1C
	ldr r4,[sp,#0x4]	; 0230DB1E
	sub r4,r0,r4	; 0230DB20
	add r1,r1,r4	; 0230DB22
	lsl r1,r1,#0x10	; 0230DB24
	lsr r4,r1,#0x10	; 0230DB26
	mov r1,#0xf	; 0230DB28
	and r4,r1	; 0230DB2A
	orr r2,r4	; 0230DB2C
	strh r2,[r3,#0x0]	; 0230DB2E
	ldr r1,[pool_0230DBBC]	; 0230DB30
	ldr r3,[r1,#0x0]	; 0230DB32
	ldr r2,[pool_0230DBD0]	; 0230DB34
	add r2,r3,r2	; 0230DB36
	ldr r3,[r2,#0x0]	; 0230DB38
	add r0,r3,r0	; 0230DB3A
	str r0,[r2,#0x0]	; 0230DB3C
	ldrh r2,[r7,#0x0]	; 0230DB3E
	ldr r0,[pool_0230DBD4]	; 0230DB40
	and r2,r0	; 0230DB42
	cmp r2,#0x0	; 0230DB44
	bne loc_0230DBB4	; 0230DB46
	mov r0,#0x0	; 0230DB48
	strh r0,[r6,#0x0]	; 0230DB4A
	ldrh r2,[r5,#0x8]	; 0230DB4C
	mov r0,#0xf0	; 0230DB4E
	bic r2,r0	; 0230DB50
	add r2,#0x10	; 0230DB52
	strh r2,[r5,#0x8]	; 0230DB54
	add r2,r5,#0x0	; 0230DB56
	add r2,#0x10	; 0230DB58
	ldrh r0,[r2,#0x0]	; 0230DB5A
	add r0,#0x18	; 0230DB5C
	strh r0,[r2,#0x0]	; 0230DB5E
	ldrh r2,[r5,#0x8]	; 0230DB60
	mov r0,#0xf	; 0230DB62
	and r2,r0	; 0230DB64
	cmp r2,#0x0	; 0230DB66
	beq loc_0230DB8A	; 0230DB68
	cmp r2,#0x8	; 0230DB6A
	bne loc_0230DBA6	; 0230DB6C
	ldr r2,[r1,#0x0]	; 0230DB6E
	ldr r0,[pool_0230DBCC]	; 0230DB70
	add r0,r2,r0	; 0230DB72
	ldr r1,[pool_0230DBD8]	; 0230DB74
	add r1,r2,r1	; 0230DB76
	sub r5,#0x10	; 0230DB78
	add r2,r5,#0x0	; 0230DB7A
	bl loc_02304FA8	; 0230DB7C
	mov r0,#0x2	; 0230DB80
	mov r1,#0x6	; 0230DB82
	bl loc_02304B68	; 0230DB84
	b loc_0230DBB4	; 0230DB88
loc_0230DB8A:
	ldr r2,[r1,#0x0]	; 0230DB8A
	ldr r0,[pool_0230DBCC]	; 0230DB8C
	add r0,r2,r0	; 0230DB8E
	ldr r1,[pool_0230DBDC]	; 0230DB90
	add r1,r2,r1	; 0230DB92
	sub r5,#0x10	; 0230DB94
	add r2,r5,#0x0	; 0230DB96
	bl loc_02304FA8	; 0230DB98
	mov r0,#0x1	; 0230DB9C
	mov r1,#0x7	; 0230DB9E
	bl loc_02304B68	; 0230DBA0
	b loc_0230DBB4	; 0230DBA4
loc_0230DBA6:
	ldr r1,[r1,#0x0]	; 0230DBA6
	ldr r0,[pool_0230DBCC]	; 0230DBA8
	add r0,r1,r0	; 0230DBAA
	sub r5,#0x10	; 0230DBAC
	add r1,r5,#0x0	; 0230DBAE
	bl loc_02304FF8	; 0230DBB0
loc_0230DBB4:
	add sp,#0x14	; 0230DBB4
	pop {r4,r5,r6,r7}	; 0230DBB6
	pop {r3}	; 0230DBB8
	bx r3	; 0230DBBA
pool_0230DBBC:
loc_0230DBBC:
	.word FirmwareWlWorkPointerSlot	; 0230DBBC
pool_0230DBC0:
loc_0230DBC0:
	.word 0x000004A0	; 0230DBC0
pool_0230DBC4:
loc_0230DBC4:
	.word 0x80000000	; 0230DBC4
pool_0230DBC8:
loc_0230DBC8:
	.word 0x000005E4	; 0230DBC8
pool_0230DBCC:
loc_0230DBCC:
	.word 0x0000014C	; 0230DBCC
pool_0230DBD0:
loc_0230DBD0:
	.word 0x00000518	; 0230DBD0
pool_0230DBD4:
loc_0230DBD4:
	.word 0x00000100	; 0230DBD4
pool_0230DBD8:
loc_0230DBD8:
	.word 0x00000188	; 0230DBD8
pool_0230DBDC:
loc_0230DBDC:
	.word 0x000001A0	; 0230DBDC

; ===== function loc_0230DBE0 =====
loc_0230DBE0:
	bx pc	; 0230DBE0
	.byte 0xC0, 0x46	; 0230DBE4
.arm

; ===== function loc_0230DBE4 =====
loc_0230DBE4:
	ldr pc,[pool_0230DBE8]	; 0230DBE4
pool_0230DBE8:
loc_0230DBE8:
	.word P2_Entry_037FCE1C	; 0230DBE8
.thumb

; ===== function loc_0230DBEC =====
loc_0230DBEC:
	bx pc	; 0230DBEC
	.byte 0xC0, 0x46	; 0230DBF0
.arm

; ===== function loc_0230DBF0 =====
loc_0230DBF0:
	ldr pc,[pool_0230DBF4]	; 0230DBF0
pool_0230DBF4:
loc_0230DBF4:
	.word loc_03802514	; 0230DBF4
.thumb

; ===== function loc_0230DBF8 =====
loc_0230DBF8:
	push {r4,r5,r6,r7,lr}	; 0230DBF8
	sub sp,#0xc	; 0230DBFA
	str r0,[sp,#0x0]	; 0230DBFC
	add r5,r1,#0x0	; 0230DBFE
	ldr r0,[pool_0230DD98]	; 0230DC00
	ldr r3,[r0,#0x0]	; 0230DC02
	ldr r0,[pool_0230DD9C]	; 0230DC04
	add r6,r3,r0	; 0230DC06
	mov r1,#0x0	; 0230DC08
	mvn r7,r1	; 0230DC0A
	b loc_0230DCEA	; 0230DC0C
loc_0230DC0E:
	add r2,r1,#0x0	; 0230DC0E
	str r2,[sp,#0x4]	; 0230DC10
	mov r0,#0x18	; 0230DC12
	mul r2,r0	; 0230DC14
	str r2,[sp,#0x4]	; 0230DC16
	add r4,r6,r2	; 0230DC18
	lsl r0,r2,#0	; 0230DC1A
	ldrh r0,[r6,r0]	; 0230DC1C
	cmp r0,#0x0	; 0230DC1E
	beq loc_0230DCE6	; 0230DC20
	ldrh r2,[r5,#0x4]	; 0230DC22
	ldrh r0,[r4,#0x8]	; 0230DC24
	cmp r2,r0	; 0230DC26
	bne loc_0230DCE8	; 0230DC28
	ldrh r2,[r5,#0x2]	; 0230DC2A
	ldrh r0,[r4,#0x6]	; 0230DC2C
	cmp r2,r0	; 0230DC2E
	bne loc_0230DCE8	; 0230DC30
	ldrh r2,[r5,#0x0]	; 0230DC32
	ldrh r0,[r4,#0x4]	; 0230DC34
	cmp r2,r0	; 0230DC36
	bne loc_0230DCE8	; 0230DC38
	ldrh r2,[r5,#0xa]	; 0230DC3A
	ldrh r0,[r4,#0xe]	; 0230DC3C
	cmp r2,r0	; 0230DC3E
	bne loc_0230DCE8	; 0230DC40
	ldrh r2,[r5,#0x8]	; 0230DC42
	ldrh r0,[r4,#0xc]	; 0230DC44
	cmp r2,r0	; 0230DC46
	bne loc_0230DCE8	; 0230DC48
	ldrh r2,[r5,#0x6]	; 0230DC4A
	ldrh r0,[r4,#0xa]	; 0230DC4C
	cmp r2,r0	; 0230DC4E
	bne loc_0230DCE8	; 0230DC50
	ldrh r0,[r5,#0xc]	; 0230DC52
	lsl r0,r0,#0x10	; 0230DC54
	lsr r0,r0,#0x14	; 0230DC56
	ldrh r2,[r4,#0x10]	; 0230DC58
	lsl r2,r2,#0x10	; 0230DC5A
	lsr r2,r2,#0x14	; 0230DC5C
	cmp r0,r2	; 0230DC5E
	bne loc_0230DCE8	; 0230DC60
	ldr r0,[sp,#0x0]	; 0230DC62
	ldrh r0,[r0,#0x0]	; 0230DC64
	mov r1,#0xf0	; 0230DC66
	and r0,r1	; 0230DC68
	mov r1,#0x10	; 0230DC6A
	bl loc_0230DDB4	; 0230DC6C
	add r7,r0,#0x0	; 0230DC70
	ldrh r0,[r4,#0x10]	; 0230DC72
	lsl r0,r0,#0x1c	; 0230DC74
	lsr r0,r0,#0x1c	; 0230DC76
	sub r1,r7,r0	; 0230DC78
	cmp r1,#0x0	; 0230DC7A
	bne loc_0230DC80	; 0230DC7C
	b loc_0230DD8E	; 0230DC7E
loc_0230DC80:
	ldr r0,[pool_0230DDA0]	; 0230DC80
	and r1,r0	; 0230DC82
	cmp r1,#0x0	; 0230DC84
	beq loc_0230DC8A	; 0230DC86
	b loc_0230DD8E	; 0230DC88
loc_0230DC8A:
	ldr r1,[sp,#0x4]	; 0230DC8A
	add r1,r6,r1	; 0230DC8C
	ldr r5,[r1,#0x14]	; 0230DC8E
	add r5,#0x10	; 0230DC90
	ldrh r1,[r5,#0x10]	; 0230DC92
	ldr r2,[sp,#0x0]	; 0230DC94
	ldrh r2,[r2,#0x8]	; 0230DC96
	sub r6,r2,r1	; 0230DC98
	sub r6,#0x18	; 0230DC9A
	cmp r6,#0x0	; 0230DC9C
	beq loc_0230DD8E	; 0230DC9E
	add r2,r6,#0x0	; 0230DCA0
	and r2,r0	; 0230DCA2
	cmp r2,#0x0	; 0230DCA4
	bne loc_0230DD8E	; 0230DCA6
	ldr r0,[sp,#0x0]	; 0230DCA8
	add r0,#0x24	; 0230DCAA
	str r0,[sp,#0x0]	; 0230DCAC
	add r0,r0,r1	; 0230DCAE
	add r2,r5,#0x0	; 0230DCB0
	add r2,#0x2c	; 0230DCB2
	add r1,r2,r1	; 0230DCB4
	add r2,r6,#0x0	; 0230DCB6
	bl loc_0230DDC0	; 0230DCB8
	add r5,#0x10	; 0230DCBC
	ldrh r0,[r5,#0x0]	; 0230DCBE
	add r0,r0,r6	; 0230DCC0
	strh r0,[r5,#0x0]	; 0230DCC2
	add r4,#0x10	; 0230DCC4
	ldrh r2,[r4,#0x0]	; 0230DCC6
	mov r1,#0xf	; 0230DCC8
	bic r2,r1	; 0230DCCA
	lsl r0,r7,#0x10	; 0230DCCC
	lsr r0,r0,#0x10	; 0230DCCE
	and r0,r1	; 0230DCD0
	orr r2,r0	; 0230DCD2
	strh r2,[r4,#0x0]	; 0230DCD4
	ldr r0,[pool_0230DD98]	; 0230DCD6
	ldr r1,[r0,#0x0]	; 0230DCD8
	ldr r0,[pool_0230DDA4]	; 0230DCDA
	add r1,r1,r0	; 0230DCDC
	ldr r0,[r1,#0x0]	; 0230DCDE
	add r0,r0,r7	; 0230DCE0
	str r0,[r1,#0x0]	; 0230DCE2
	b loc_0230DD8E	; 0230DCE4
loc_0230DCE6:
	add r7,r1,#0x0	; 0230DCE6
loc_0230DCE8:
	add r1,r1,#0x1	; 0230DCE8
loc_0230DCEA:
	cmp r1,#0x3	; 0230DCEA
	bcc loc_0230DC0E	; 0230DCEC
	mov r0,#0x0	; 0230DCEE
	mvn r0,r0	; 0230DCF0
	cmp r7,r0	; 0230DCF2
	beq loc_0230DD8E	; 0230DCF4
	ldr r0,[pool_0230DDA8]	; 0230DCF6
	add r0,r3,r0	; 0230DCF8
	ldr r1,[pool_0230DDAC]	; 0230DCFA
	bl loc_02305050	; 0230DCFC
	add r4,r0,#0x0	; 0230DD00
	cmp r4,#0x0	; 0230DD02
	beq loc_0230DD88	; 0230DD04
	mov r0,#0x18	; 0230DD06
	mul r7,r0	; 0230DD08
	add r0,r6,r7	; 0230DD0A
	str r0,[sp,#0x8]	; 0230DD0C
	add r0,r5,#0x0	; 0230DD0E
	ldr r1,[sp,#0x8]	; 0230DD10
	add r1,r1,#0x4	; 0230DD12
	mov r2,#0x10	; 0230DD14
	bl loc_0230DDCC	; 0230DD16
	mov r0,#0x5	; 0230DD1A
	strh r0,[r6,r7]	; 0230DD1C
	add r0,r6,r7	; 0230DD1E
	str r4,[r0,#0x14]	; 0230DD20
	add r4,#0x10	; 0230DD22
	ldr r0,[sp,#0x0]	; 0230DD24
	add r1,r4,#0x0	; 0230DD26
	add r1,#0x8	; 0230DD28
	lsl r2,r0,#0	; 0230DD2A
	ldrh r2,[r2,#0x8]	; 0230DD2C
	add r2,#0xc	; 0230DD2E
	bl loc_0230DDD8	; 0230DD30
	ldr r0,[pool_0230DD98]	; 0230DD34
	ldr r1,[r0,#0x0]	; 0230DD36
	ldr r0,[pool_0230DDB0]	; 0230DD38
	ldr r0,[r1,r0]	; 0230DD3A
	bl loc_0230DDE4	; 0230DD3C
	ldrh r0,[r4,#0x8]	; 0230DD40
	mov r1,#0xf0	; 0230DD42
	and r0,r1	; 0230DD44
	mov r1,#0x10	; 0230DD46
	bl loc_0230DDF4	; 0230DD48
	add r1,r0,#0x0	; 0230DD4C
	ldr r0,[sp,#0x8]	; 0230DD4E
	add r0,#0x10	; 0230DD50
	str r0,[sp,#0x8]	; 0230DD52
	ldrh r0,[r0,#0x0]	; 0230DD54
	mov r3,#0xf	; 0230DD56
	bic r0,r3	; 0230DD58
	lsl r2,r1,#0x10	; 0230DD5A
	lsr r2,r2,#0x10	; 0230DD5C
	and r2,r3	; 0230DD5E
	orr r0,r2	; 0230DD60
	ldr r2,[sp,#0x8]	; 0230DD62
	strh r0,[r2,#0x0]	; 0230DD64
	ldr r0,[pool_0230DD98]	; 0230DD66
	ldr r2,[r0,#0x0]	; 0230DD68
	ldr r0,[pool_0230DDA4]	; 0230DD6A
	add r2,r2,r0	; 0230DD6C
	ldr r0,[r2,#0x0]	; 0230DD6E
	add r0,r0,r1	; 0230DD70
	str r0,[r2,#0x0]	; 0230DD72
	ldr r0,[sp,#0x0]	; 0230DD74
	ldrh r0,[r0,#0x8]	; 0230DD76
	sub r0,#0x18	; 0230DD78
	strh r0,[r4,#0x10]	; 0230DD7A
	ldrh r0,[r4,#0x10]	; 0230DD7C
	bl loc_0230DE00	; 0230DD7E
	add r1,r6,r7	; 0230DD82
	strh r0,[r1,#0x2]	; 0230DD84
	b loc_0230DD8E	; 0230DD86
loc_0230DD88:
	mov r0,#0x4	; 0230DD88
	bl loc_02305130	; 0230DD8A
loc_0230DD8E:
	add sp,#0xc	; 0230DD8E
	pop {r4,r5,r6,r7}	; 0230DD90
	pop {r3}	; 0230DD92
	bx r3	; 0230DD94
	.byte 0xC0, 0x46	; 0230DD98
pool_0230DD98:
loc_0230DD98:
	.word FirmwareWlWorkPointerSlot	; 0230DD98
pool_0230DD9C:
loc_0230DD9C:
	.word 0x000004A0	; 0230DD9C
pool_0230DDA0:
loc_0230DDA0:
	.word 0x80000000	; 0230DDA0
pool_0230DDA4:
loc_0230DDA4:
	.word 0x00000518	; 0230DDA4
pool_0230DDA8:
loc_0230DDA8:
	.word 0x0000014C	; 0230DDA8
pool_0230DDAC:
loc_0230DDAC:
	.word 0x00000622	; 0230DDAC
pool_0230DDB0:
loc_0230DDB0:
	.word 0x000002D0	; 0230DDB0

; ===== function loc_0230DDB4 =====
loc_0230DDB4:
	bx pc	; 0230DDB4
	.byte 0xC0, 0x46	; 0230DDB8
.arm

; ===== function loc_0230DDB8 =====
loc_0230DDB8:
	ldr pc,[pool_0230DDBC]	; 0230DDB8
pool_0230DDBC:
loc_0230DDBC:
	.word loc_03802514	; 0230DDBC
.thumb

; ===== function loc_0230DDC0 =====
loc_0230DDC0:
	bx pc	; 0230DDC0
	.byte 0xC0, 0x46	; 0230DDC4
.arm

; ===== function loc_0230DDC4 =====
loc_0230DDC4:
	ldr pc,[pool_0230DDC8]	; 0230DDC4
pool_0230DDC8:
loc_0230DDC8:
	.word P2_Entry_037FCE1C	; 0230DDC8
.thumb

; ===== function loc_0230DDCC =====
loc_0230DDCC:
	bx pc	; 0230DDCC
	.byte 0xC0, 0x46	; 0230DDD0
.arm

; ===== function loc_0230DDD0 =====
loc_0230DDD0:
	ldr pc,[pool_0230DDD4]	; 0230DDD0
pool_0230DDD4:
loc_0230DDD4:
	.word P2_Entry_037FCE1C	; 0230DDD4
.thumb

; ===== function loc_0230DDD8 =====
loc_0230DDD8:
	bx pc	; 0230DDD8
	.byte 0xC0, 0x46	; 0230DDDC
.arm

; ===== function loc_0230DDDC =====
loc_0230DDDC:
	ldr pc,[pool_0230DDE0]	; 0230DDDC
pool_0230DDE0:
loc_0230DDE0:
	.word P2_Entry_037FCE1C	; 0230DDE0
.thumb

; ===== function loc_0230DDE4 =====
loc_0230DDE4:
	bx pc	; 0230DDE4
	.byte 0xC0, 0x46	; 0230DDE8
.arm

; ===== function loc_0230DDE8 =====
loc_0230DDE8:
	ldr r12,[pool_0230DDF0]	; 0230DDE8
	bx r12	; 0230DDEC
pool_0230DDF0:
loc_0230DDF0:
	.word P2_Entry_037FCD10 + 1	; 0230DDF0
.thumb

; ===== function loc_0230DDF4 =====
loc_0230DDF4:
	bx pc	; 0230DDF4
	.byte 0xC0, 0x46	; 0230DDF8
.arm

; ===== function loc_0230DDF8 =====
loc_0230DDF8:
	ldr pc,[pool_0230DDFC]	; 0230DDF8
pool_0230DDFC:
loc_0230DDFC:
	.word loc_03802514	; 0230DDFC
.thumb

; ===== function loc_0230DE00 =====
loc_0230DE00:
	bx pc	; 0230DE00
	.byte 0xC0, 0x46	; 0230DE04
.arm

; ===== function loc_0230DE04 =====
loc_0230DE04:
	ldr pc,[pool_0230DE08]	; 0230DE04
pool_0230DE08:
loc_0230DE08:
	.word loc_03802720	; 0230DE08
.thumb

; ===== function loc_0230DE0C =====
	push {r4,r5,lr}	; 0230DE0C
	sub sp,#0x14	; 0230DE0E
	ldr r0,[pool_0230DEE8]	; 0230DE10
	ldr r1,[r0,#0x0]	; 0230DE12
	ldr r0,[pool_0230DEEC]	; 0230DE14
	ldr r5,[r1,r0]	; 0230DE16
	mov r0,#0x0	; 0230DE18
	mvn r0,r0	; 0230DE1A
	cmp r5,r0	; 0230DE1C
	beq loc_0230DEE0	; 0230DE1E
	add r4,r5,#0x0	; 0230DE20
	add r4,#0x10	; 0230DE22
	ldr r0,[pool_0230DEF0]	; 0230DE24
	ldrh r0,[r1,r0]	; 0230DE26
	cmp r0,#0x40	; 0230DE28
	bne loc_0230DEBE	; 0230DE2A
	ldrh r1,[r4,#0x10]	; 0230DE2C
	ldr r0,[pool_0230DEF4]	; 0230DE2E
	cmp r1,r0	; 0230DE30
	bhi loc_0230DEBE	; 0230DE32
	ldrh r0,[r4,#0x14]	; 0230DE34
	lsl r0,r0,#0x17	; 0230DE36
	lsr r0,r0,#0x1f	; 0230DE38
	cmp r0,#0x0	; 0230DE3A
	beq loc_0230DE60	; 0230DE3C
	add r0,sp,#0x0	; 0230DE3E
	add r1,r4,#0x0	; 0230DE40
	add r1,#0x24	; 0230DE42
	bl loc_02306458	; 0230DE44
	ldrh r0,[r4,#0x14]	; 0230DE48
	lsl r0,r0,#0x16	; 0230DE4A
	lsr r0,r0,#0x1f	; 0230DE4C
	cmp r0,#0x0	; 0230DE4E
	bne loc_0230DEBE	; 0230DE50
	add r0,sp,#0x4	; 0230DE52
	add r0,#0x2	; 0230DE54
	add r1,r4,#0x0	; 0230DE56
	add r1,#0x1e	; 0230DE58
	bl loc_02306458	; 0230DE5A
	b loc_0230DE8E	; 0230DE5E
loc_0230DE60:
	add r0,sp,#0x0	; 0230DE60
	add r1,r4,#0x0	; 0230DE62
	add r1,#0x18	; 0230DE64
	bl loc_02306458	; 0230DE66
	ldrh r0,[r4,#0x14]	; 0230DE6A
	lsl r0,r0,#0x16	; 0230DE6C
	lsr r0,r0,#0x1f	; 0230DE6E
	cmp r0,#0x0	; 0230DE70
	beq loc_0230DE82	; 0230DE72
	add r0,sp,#0x4	; 0230DE74
	add r0,#0x2	; 0230DE76
	add r1,r4,#0x0	; 0230DE78
	add r1,#0x24	; 0230DE7A
	bl loc_02306458	; 0230DE7C
	b loc_0230DE8E	; 0230DE80
loc_0230DE82:
	add r0,sp,#0x4	; 0230DE82
	add r0,#0x2	; 0230DE84
	add r1,r4,#0x0	; 0230DE86
	add r1,#0x1e	; 0230DE88
	bl loc_02306458	; 0230DE8A
loc_0230DE8E:
	ldrh r1,[r4,#0x2a]	; 0230DE8E
	add r0,sp,#0x0	; 0230DE90
	strh r1,[r0,#0xc]	; 0230DE92
	ldrh r0,[r4,#0x14]	; 0230DE94
	lsl r0,r0,#0x15	; 0230DE96
	lsr r0,r0,#0x1f	; 0230DE98
	cmp r0,#0x1	; 0230DE9A
	bne loc_0230DEB4	; 0230DE9C
	ldrh r0,[r4,#0x2a]	; 0230DE9E
	lsl r0,r0,#0x1c	; 0230DEA0
	lsr r0,r0,#0x1c	; 0230DEA2
	cmp r0,#0x0	; 0230DEA4
	bne loc_0230DEB4	; 0230DEA6
	add r4,#0x8	; 0230DEA8
	add r0,r4,#0x0	; 0230DEAA
	add r1,sp,#0x0	; 0230DEAC
	bl loc_0230DBF8	; 0230DEAE
	b loc_0230DEBE	; 0230DEB2
loc_0230DEB4:
	add r4,#0x8	; 0230DEB4
	add r0,r4,#0x0	; 0230DEB6
	add r1,sp,#0x0	; 0230DEB8
	bl loc_0230DA10	; 0230DEBA
loc_0230DEBE:
	ldr r0,[pool_0230DEE8]	; 0230DEBE
	ldr r1,[r0,#0x0]	; 0230DEC0
	ldr r0,[pool_0230DEEC]	; 0230DEC2
	add r0,r1,r0	; 0230DEC4
	add r1,r5,#0x0	; 0230DEC6
	bl loc_02304FF8	; 0230DEC8
	ldr r0,[pool_0230DEE8]	; 0230DECC
	ldr r1,[r0,#0x0]	; 0230DECE
	ldr r0,[pool_0230DEF8]	; 0230DED0
	ldrh r0,[r1,r0]	; 0230DED2
	cmp r0,#0x0	; 0230DED4
	beq loc_0230DEE0	; 0230DED6
	mov r0,#0x2	; 0230DED8
	mov r1,#0x9	; 0230DEDA
	bl loc_02304B68	; 0230DEDC
loc_0230DEE0:
	add sp,#0x14	; 0230DEE0
	pop {r4,r5}	; 0230DEE2
	pop {r3}	; 0230DEE4
	bx r3	; 0230DEE6
pool_0230DEE8:
loc_0230DEE8:
	.word FirmwareWlWorkPointerSlot	; 0230DEE8
pool_0230DEEC:
loc_0230DEEC:
	.word 0x000001AC	; 0230DEEC
pool_0230DEF0:
loc_0230DEF0:
	.word 0x00000310	; 0230DEF0
pool_0230DEF4:
loc_0230DEF4:
	.word 0x000005FC	; 0230DEF4
pool_0230DEF8:
loc_0230DEF8:
	.word 0x000001B4	; 0230DEF8

; ===== function loc_0230DEFC =====
loc_0230DEFC:
	push {r4,r5,r6,r7,lr}	; 0230DEFC
	sub sp,#0x4	; 0230DEFE
	add r5,r0,#0x0	; 0230DF00
	ldr r0,[pool_0230DF68]	; 0230DF02
	ldr r1,[r0,#0x0]	; 0230DF04
	ldr r0,[pool_0230DF6C]	; 0230DF06
	ldr r2,[r1,r0]	; 0230DF08
	ldrh r1,[r5,#0x2]	; 0230DF0A
	mov r0,#0x1c	; 0230DF0C
	mul r1,r0	; 0230DF0E
	add r0,r2,r1	; 0230DF10
	ldrh r0,[r0,#0xe]	; 0230DF12
	bl loc_02305370	; 0230DF14
	add r4,r5,#0x0	; 0230DF18
	add r4,#0x34	; 0230DF1A
	add r5,#0x33	; 0230DF1C
	add r0,r5,#0x0	; 0230DF1E
	bl loc_023053B4	; 0230DF20
	add r6,r0,#0x0	; 0230DF24
	mov r5,#0x0	; 0230DF26
	lsr r7,r6,#0x1	; 0230DF28
	b loc_0230DF3E	; 0230DF2A
loc_0230DF2C:
	bl loc_0230533C	; 0230DF2C
	ldrh r1,[r4,#0x0]	; 0230DF30
	add r4,r4,#0x2	; 0230DF32
	cmp r1,r0	; 0230DF34
	beq loc_0230DF3C	; 0230DF36
	mov r0,#0x0	; 0230DF38
	b loc_0230DF60	; 0230DF3A
loc_0230DF3C:
	add r5,r5,#0x1	; 0230DF3C
loc_0230DF3E:
	cmp r5,r7	; 0230DF3E
	bcc loc_0230DF2C	; 0230DF40
	mov r0,#0x1	; 0230DF42
	and r6,r0	; 0230DF44
	cmp r6,#0x0	; 0230DF46
	beq loc_0230DF5E	; 0230DF48
	bl loc_0230533C	; 0230DF4A
	ldrh r2,[r4,#0x0]	; 0230DF4E
	mov r1,#0xff	; 0230DF50
	and r2,r1	; 0230DF52
	and r0,r1	; 0230DF54
	cmp r2,r0	; 0230DF56
	beq loc_0230DF5E	; 0230DF58
	mov r0,#0x0	; 0230DF5A
	b loc_0230DF60	; 0230DF5C
loc_0230DF5E:
	mov r0,#0x1	; 0230DF5E
loc_0230DF60:
	add sp,#0x4	; 0230DF60
	pop {r4,r5,r6,r7}	; 0230DF62
	pop {r3}	; 0230DF64
	bx r3	; 0230DF66
pool_0230DF68:
loc_0230DF68:
	.word FirmwareWlWorkPointerSlot	; 0230DF68
pool_0230DF6C:
loc_0230DF6C:
	.word 0x000002E0	; 0230DF6C

; ===== function loc_0230DF70 =====
loc_0230DF70:
	push {r4,r5,r6,lr}	; 0230DF70
	add r5,r0,#0x0	; 0230DF72
	add r6,r1,#0x0	; 0230DF74
	ldr r0,[pool_0230DFC8]	; 0230DF76
	ldrh r1,[r0,#0x0]	; 0230DF78
	ldrh r0,[r0,#0x0]	; 0230DF7A
	lsl r0,r0,#0x8	; 0230DF7C
	add r0,r1,r0	; 0230DF7E
	lsl r0,r0,#0x10	; 0230DF80
	lsr r4,r0,#0x10	; 0230DF82
	cmp r4,#0x0	; 0230DF84
	bne loc_0230DF8A	; 0230DF86
	mov r4,#0x1	; 0230DF88
loc_0230DF8A:
	add r0,r4,#0x0	; 0230DF8A
	bl loc_02305370	; 0230DF8C
	ldr r0,[pool_0230DFCC]	; 0230DF90
	ldr r1,[r0,#0x0]	; 0230DF92
	ldr r0,[pool_0230DFD0]	; 0230DF94
	ldr r1,[r1,r0]	; 0230DF96
	mov r0,#0x1c	; 0230DF98
	mul r5,r0	; 0230DF9A
	add r0,r1,r5	; 0230DF9C
	strh r4,[r0,#0xe]	; 0230DF9E
	add r4,r6,#0x0	; 0230DFA0
	add r4,#0x34	; 0230DFA2
	add r6,#0x33	; 0230DFA4
	add r0,r6,#0x0	; 0230DFA6
	bl loc_023053B4	; 0230DFA8
	add r6,r0,#0x0	; 0230DFAC
	mov r5,#0x0	; 0230DFAE
	b loc_0230DFBC	; 0230DFB0
loc_0230DFB2:
	bl loc_0230533C	; 0230DFB2
	strh r0,[r4,#0x0]	; 0230DFB6
	add r4,r4,#0x2	; 0230DFB8
	add r5,r5,#0x2	; 0230DFBA
loc_0230DFBC:
	cmp r5,r6	; 0230DFBC
	bcc loc_0230DFB2	; 0230DFBE
	pop {r4,r5,r6}	; 0230DFC0
	pop {r3}	; 0230DFC2
	bx r3	; 0230DFC4
	.byte 0xC0, 0x46	; 0230DFC8
pool_0230DFC8:
loc_0230DFC8:
	.word REG_WIFI_RANDOM	; 0230DFC8
pool_0230DFCC:
loc_0230DFCC:
	.word FirmwareWlWorkPointerSlot	; 0230DFCC
pool_0230DFD0:
loc_0230DFD0:
	.word 0x000002E0	; 0230DFD0

; ===== function loc_0230DFD4 =====
	push {r4,r5,r6,r7,lr}	; 0230DFD4
	sub sp,#0x4	; 0230DFD6
	ldr r0,[pool_0230E254]	; 0230DFD8
	ldr r1,[r0,#0x0]	; 0230DFDA
	ldr r0,[pool_0230E258]	; 0230DFDC
	add r7,r1,r0	; 0230DFDE
	ldr r0,[pool_0230E25C]	; 0230DFE0
	ldr r0,[r1,r0]	; 0230DFE2
	str r0,[sp,#0x0]	; 0230DFE4
	mov r0,#0x0	; 0230DFE6
	mvn r1,r0	; 0230DFE8
	ldr r0,[sp,#0x0]	; 0230DFEA
	cmp r0,r1	; 0230DFEC
	bne loc_0230DFF2	; 0230DFEE
	b loc_0230E24C	; 0230DFF0
loc_0230DFF2:
	lsl r4,r0,#0	; 0230DFF2
	add r4,#0x10	; 0230DFF4
	add r5,r4,#0x0	; 0230DFF6
	add r5,#0x14	; 0230DFF8
	ldrh r1,[r4,#0x18]	; 0230DFFA
	mov r0,#0x1	; 0230DFFC
	and r1,r0	; 0230DFFE
	cmp r1,#0x0	; 0230E000
	beq loc_0230E010	; 0230E002
	add r1,r7,#0x0	; 0230E004
	add r1,#0x2c	; 0230E006
	ldr r0,[r1,#0x0]	; 0230E008
	add r0,r0,#0x1	; 0230E00A
	str r0,[r1,#0x0]	; 0230E00C
	b loc_0230E01A	; 0230E00E
loc_0230E010:
	add r1,r7,#0x0	; 0230E010
	add r1,#0x28	; 0230E012
	ldr r0,[r1,#0x0]	; 0230E014
	add r0,r0,#0x1	; 0230E016
	str r0,[r1,#0x0]	; 0230E018
loc_0230E01A:
	add r6,r7,#0x0	; 0230E01A
	add r6,#0x24	; 0230E01C
	ldrh r0,[r4,#0x8]	; 0230E01E
	mov r1,#0xf0	; 0230E020
	and r0,r1	; 0230E022
	mov r1,#0x10	; 0230E024
	bl loc_0230E26C	; 0230E026
	ldr r1,[r6,#0x0]	; 0230E02A
	sub r0,r0,#0x1	; 0230E02C
	add r0,r1,r0	; 0230E02E
	str r0,[r6,#0x0]	; 0230E030
	add r0,r5,#0x0	; 0230E032
	add r0,#0xa	; 0230E034
	bl loc_023093BC	; 0230E036
	add r6,r0,#0x0	; 0230E03A
	lsl r0,r6,#0x10	; 0230E03C
	lsr r0,r0,#0x10	; 0230E03E
	strh r0,[r4,#0x2]	; 0230E040
	cmp r6,#0xff	; 0230E042
	bne loc_0230E08E	; 0230E044
	mov r0,#0x0	; 0230E046
	strh r0,[r4,#0x2]	; 0230E048
	ldr r0,[pool_0230E254]	; 0230E04A
	ldr r1,[r0,#0x0]	; 0230E04C
	ldr r0,[pool_0230E260]	; 0230E04E
	ldrh r0,[r1,r0]	; 0230E050
	cmp r0,#0x1	; 0230E052
	beq loc_0230E058	; 0230E054
	b loc_0230E22A	; 0230E056
loc_0230E058:
	ldrh r0,[r5,#0x0]	; 0230E058
	lsl r1,r0,#0x1c	; 0230E05A
	lsr r1,r1,#0x1e	; 0230E05C
	cmp r1,#0x0	; 0230E05E
	beq loc_0230E064	; 0230E060
	b loc_0230E22A	; 0230E062
loc_0230E064:
	lsl r0,r0,#0x18	; 0230E064
	lsr r0,r0,#0x1c	; 0230E066
	cmp r0,#0x0	; 0230E068
	beq loc_0230E086	; 0230E06A
	cmp r0,#0x4	; 0230E06C
	beq loc_0230E07E	; 0230E06E
	cmp r0,#0xb	; 0230E070
	beq loc_0230E076	; 0230E072
	b loc_0230E22A	; 0230E074
loc_0230E076:
	add r0,r4,#0x0	; 0230E076
	bl loc_0230E62C	; 0230E078
	b loc_0230E22A	; 0230E07C
loc_0230E07E:
	add r0,r4,#0x0	; 0230E07E
	bl loc_0230ECCC	; 0230E080
	b loc_0230E22A	; 0230E084
loc_0230E086:
	add r0,r4,#0x0	; 0230E086
	bl loc_0230F0A4	; 0230E088
	b loc_0230E22A	; 0230E08C
loc_0230E08E:
	ldrh r2,[r4,#0x12]	; 0230E08E
	mov r1,#0xff	; 0230E090
	and r2,r1	; 0230E092
	lsl r1,r2,#0x10	; 0230E094
	lsr r1,r1,#0x10	; 0230E096
	bl loc_023091D0	; 0230E098
	ldrh r0,[r5,#0x0]	; 0230E09C
	lsl r0,r0,#0x1c	; 0230E09E
	lsr r0,r0,#0x1e	; 0230E0A0
	cmp r0,#0x0	; 0230E0A2
	bne loc_0230E0C8	; 0230E0A4
	ldrh r2,[r4,#0x2a]	; 0230E0A6
	ldr r0,[pool_0230E254]	; 0230E0A8
	ldr r1,[r0,#0x0]	; 0230E0AA
	ldr r0,[pool_0230E264]	; 0230E0AC
	ldr r1,[r1,r0]	; 0230E0AE
	mov r0,#0x1c	; 0230E0B0
	add r3,r6,#0x0	; 0230E0B2
	mul r3,r0	; 0230E0B4
	add r0,r1,r3	; 0230E0B6
	ldrh r0,[r0,#0x14]	; 0230E0B8
	cmp r2,r0	; 0230E0BA
	bne loc_0230E0C8	; 0230E0BC
	add r7,#0x3c	; 0230E0BE
	ldr r0,[r7,#0x0]	; 0230E0C0
	add r0,r0,#0x1	; 0230E0C2
	str r0,[r7,#0x0]	; 0230E0C4
	b loc_0230E22A	; 0230E0C6
loc_0230E0C8:
	ldr r0,[pool_0230E254]	; 0230E0C8
	ldr r1,[r0,#0x0]	; 0230E0CA
	ldr r0,[pool_0230E260]	; 0230E0CC
	ldrh r0,[r1,r0]	; 0230E0CE
	cmp r0,#0x1	; 0230E0D0
	beq loc_0230E0DE	; 0230E0D2
	cmp r0,#0x2	; 0230E0D4
	beq loc_0230E192	; 0230E0D6
	cmp r0,#0x3	; 0230E0D8
	beq loc_0230E192	; 0230E0DA
	b loc_0230E22A	; 0230E0DC
loc_0230E0DE:
	lsl r0,r6,#0x10	; 0230E0DE
	lsr r0,r0,#0x10	; 0230E0E0
	ldrh r1,[r5,#0x0]	; 0230E0E2
	lsl r1,r1,#0x13	; 0230E0E4
	lsr r1,r1,#0x1f	; 0230E0E6
	bl loc_02309180	; 0230E0E8
	ldrh r0,[r5,#0x0]	; 0230E0EC
	lsl r1,r0,#0x1c	; 0230E0EE
	lsr r1,r1,#0x1e	; 0230E0F0
	cmp r1,#0x0	; 0230E0F2
	bne loc_0230E17E	; 0230E0F4
	ldrh r0,[r5,#0x16]	; 0230E0F6
	ldr r1,[pool_0230E254]	; 0230E0F8
	ldr r2,[r1,#0x0]	; 0230E0FA
	ldr r1,[pool_0230E264]	; 0230E0FC
	ldr r2,[r2,r1]	; 0230E0FE
	mov r1,#0x1c	; 0230E100
	mul r6,r1	; 0230E102
	add r1,r2,r6	; 0230E104
	strh r0,[r1,#0x14]	; 0230E106
	ldrh r0,[r5,#0x0]	; 0230E108
	lsl r0,r0,#0x18	; 0230E10A
	lsr r0,r0,#0x1c	; 0230E10C
	cmp r0,#0xc	; 0230E10E
	bls loc_0230E114	; 0230E110
	b loc_0230E22A	; 0230E112
loc_0230E114:
	add r0,r0,r0	; 0230E114
P4_SwitchIndexPC_0230E114:
	add r0,pc	; 0230E116
	ldrh r0,[r0,#(P4_SwitchTable_0230E114 - (P4_SwitchIndexPC_0230E114 + 4))]	; 0230E118
	lsl r0,r0,#0x10	; 0230E11A
	asr r0,r0,#0x10	; 0230E11C
P4_SwitchTargetPC_0230E114:
	add r0,pc	; 0230E11E
	bx r0	; 0230E120
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230E114:
	.halfword (loc_0230E144 + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E14C + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E154 + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E15C + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E13C + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E166 + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E16E + 1) - (P4_SwitchTargetPC_0230E114 + 4)
	.halfword (loc_0230E176 + 1) - (P4_SwitchTargetPC_0230E114 + 4)
P4_SwitchTable_0230E114End:
loc_0230E13C:
	add r0,r4,#0x0	; 0230E13C
	bl loc_0230F2A8	; 0230E13E
	b loc_0230E22A	; 0230E142
loc_0230E144:
	add r0,r4,#0x0	; 0230E144
	bl loc_0230F0A4	; 0230E146
	b loc_0230E22A	; 0230E14A
loc_0230E14C:
	add r0,r4,#0x0	; 0230E14C
	bl loc_0230EE7C	; 0230E14E
	b loc_0230E22A	; 0230E152
loc_0230E154:
	add r0,r4,#0x0	; 0230E154
	bl loc_0230ECCC	; 0230E156
	b loc_0230E22A	; 0230E15A
loc_0230E15C:
	add r0,r4,#0x0	; 0230E15C
	mov r1,#0x0	; 0230E15E
	bl loc_0230EA6C	; 0230E160
	b loc_0230E22A	; 0230E164
loc_0230E166:
	add r0,r4,#0x0	; 0230E166
	bl loc_0230F1DC	; 0230E168
	b loc_0230E22A	; 0230E16C
loc_0230E16E:
	add r0,r4,#0x0	; 0230E16E
	bl loc_0230E62C	; 0230E170
	b loc_0230E22A	; 0230E174
loc_0230E176:
	add r0,r4,#0x0	; 0230E176
	bl loc_0230E584	; 0230E178
	b loc_0230E22A	; 0230E17C
loc_0230E17E:
	cmp r1,#0x1	; 0230E17E
	bne loc_0230E22A	; 0230E180
	lsl r0,r0,#0x18	; 0230E182
	lsr r0,r0,#0x1c	; 0230E184
	cmp r0,#0xa	; 0230E186
	bne loc_0230E22A	; 0230E188
	add r0,r4,#0x0	; 0230E18A
	bl loc_0230E51C	; 0230E18C
	b loc_0230E22A	; 0230E190
loc_0230E192:
	ldrh r0,[r5,#0x16]	; 0230E192
	ldr r2,[pool_0230E264]	; 0230E194
	ldr r2,[r1,r2]	; 0230E196
	mov r1,#0x1c	; 0230E198
	mul r6,r1	; 0230E19A
	add r1,r2,r6	; 0230E19C
	strh r0,[r1,#0x14]	; 0230E19E
	ldrh r0,[r5,#0x0]	; 0230E1A0
	lsl r1,r0,#0x1c	; 0230E1A2
	lsr r1,r1,#0x1e	; 0230E1A4
	cmp r1,#0x0	; 0230E1A6
	bne loc_0230E214	; 0230E1A8
	lsl r0,r0,#0x18	; 0230E1AA
	lsr r0,r0,#0x1c	; 0230E1AC
	cmp r0,#0xc	; 0230E1AE
	bhi loc_0230E22A	; 0230E1B0
	add r0,r0,r0	; 0230E1B2
P4_SwitchIndexPC_0230E1B2:
	add r0,pc	; 0230E1B4
	ldrh r0,[r0,#(P4_SwitchTable_0230E1B2 - (P4_SwitchIndexPC_0230E1B2 + 4))]	; 0230E1B6
	lsl r0,r0,#0x10	; 0230E1B8
	asr r0,r0,#0x10	; 0230E1BA
P4_SwitchTargetPC_0230E1B2:
	add r0,pc	; 0230E1BC
	bx r0	; 0230E1BE
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230E1B2:
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E1E2 + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E1EA + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E1F2 + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E1DA + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E22A + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E1FC + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E204 + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
	.halfword (loc_0230E20C + 1) - (P4_SwitchTargetPC_0230E1B2 + 4)
P4_SwitchTable_0230E1B2End:
loc_0230E1DA:
	add r0,r4,#0x0	; 0230E1DA
	bl loc_0230F2A8	; 0230E1DC
	b loc_0230E22A	; 0230E1E0
loc_0230E1E2:
	add r0,r4,#0x0	; 0230E1E2
	bl loc_0230EF98	; 0230E1E4
	b loc_0230E22A	; 0230E1E8
loc_0230E1EA:
	add r0,r4,#0x0	; 0230E1EA
	bl loc_0230ED5C	; 0230E1EC
	b loc_0230E22A	; 0230E1F0
loc_0230E1F2:
	add r0,r4,#0x0	; 0230E1F2
	mov r1,#0x0	; 0230E1F4
	bl loc_0230EA6C	; 0230E1F6
	b loc_0230E22A	; 0230E1FA
loc_0230E1FC:
	add r0,r4,#0x0	; 0230E1FC
	bl loc_0230F1DC	; 0230E1FE
	b loc_0230E22A	; 0230E202
loc_0230E204:
	add r0,r4,#0x0	; 0230E204
	bl loc_0230E62C	; 0230E206
	b loc_0230E22A	; 0230E20A
loc_0230E20C:
	add r0,r4,#0x0	; 0230E20C
	bl loc_0230E584	; 0230E20E
	b loc_0230E22A	; 0230E212
loc_0230E214:
	cmp r1,#0x1	; 0230E214
	bne loc_0230E22A	; 0230E216
	lsl r0,r0,#0x18	; 0230E218
	lsr r0,r0,#0x1c	; 0230E21A
	cmp r0,#0xe	; 0230E21C
	beq loc_0230E224	; 0230E21E
	cmp r0,#0xf	; 0230E220
	bne loc_0230E22A	; 0230E222
loc_0230E224:
	add r0,r4,#0x0	; 0230E224
	bl loc_0230E518	; 0230E226
loc_0230E22A:
	ldr r0,[pool_0230E254]	; 0230E22A
	ldr r1,[r0,#0x0]	; 0230E22C
	ldr r0,[pool_0230E25C]	; 0230E22E
	add r0,r1,r0	; 0230E230
	ldr r1,[sp,#0x0]	; 0230E232
	bl loc_02304FF8	; 0230E234
	ldr r0,[pool_0230E254]	; 0230E238
	ldr r1,[r0,#0x0]	; 0230E23A
	ldr r0,[pool_0230E268]	; 0230E23C
	ldrh r0,[r1,r0]	; 0230E23E
	cmp r0,#0x0	; 0230E240
	beq loc_0230E24C	; 0230E242
	mov r0,#0x1	; 0230E244
	mov r1,#0x7	; 0230E246
	bl loc_02304B68	; 0230E248
loc_0230E24C:
	add sp,#0x4	; 0230E24C
	pop {r4,r5,r6,r7}	; 0230E24E
	pop {r3}	; 0230E250
	bx r3	; 0230E252
pool_0230E254:
loc_0230E254:
	.word FirmwareWlWorkPointerSlot	; 0230E254
pool_0230E258:
loc_0230E258:
	.word 0x000004F4	; 0230E258
pool_0230E25C:
loc_0230E25C:
	.word 0x000001A0	; 0230E25C
pool_0230E260:
loc_0230E260:
	.word 0x00000314	; 0230E260
pool_0230E264:
loc_0230E264:
	.word 0x000002E0	; 0230E264
pool_0230E268:
loc_0230E268:
	.word 0x000001A8	; 0230E268

; ===== function loc_0230E26C =====
loc_0230E26C:
	bx pc	; 0230E26C
	.byte 0xC0, 0x46	; 0230E270
.arm

; ===== function loc_0230E270 =====
loc_0230E270:
	ldr pc,[pool_0230E274]	; 0230E270
pool_0230E274:
loc_0230E274:
	.word loc_03802514	; 0230E274
.thumb

; ===== function loc_0230E278 =====
loc_0230E278:
	push {r4,r5,r6,r7,lr}	; 0230E278
	sub sp,#0x4	; 0230E27A
	add r4,r0,#0x0	; 0230E27C
	ldr r5,[r4,#0x0]	; 0230E27E
	ldr r0,[pool_0230E4E8]	; 0230E280
	ldr r1,[r0,#0x0]	; 0230E282
	ldr r0,[pool_0230E4EC]	; 0230E284
	ldrh r0,[r1,r0]	; 0230E286
	strh r0,[r4,#0x12]	; 0230E288
	ldrh r1,[r4,#0xc]	; 0230E28A
	ldr r0,[pool_0230E4F0]	; 0230E28C
	and r1,r0	; 0230E28E
	cmp r1,#0x0	; 0230E290
	beq loc_0230E2A0	; 0230E292
	add r2,r4,#0x0	; 0230E294
	add r2,#0xa	; 0230E296
	ldrh r1,[r2,#0x0]	; 0230E298
	mov r0,#0x1	; 0230E29A
	orr r1,r0	; 0230E29C
	strh r1,[r2,#0x0]	; 0230E29E
loc_0230E2A0:
	ldrh r0,[r4,#0x8]	; 0230E2A0
	str r0,[sp,#0x0]	; 0230E2A2
	b loc_0230E460	; 0230E2A4
loc_0230E2A6:
	add r0,r5,#0x0	; 0230E2A6
	bl loc_023053B4	; 0230E2A8
	add r7,r0,#0x0	; 0230E2AC
	add r0,r5,#0x1	; 0230E2AE
	add r5,r5,#0x2	; 0230E2B0
	bl loc_023053B4	; 0230E2B2
	add r6,r0,#0x0	; 0230E2B6
	cmp r7,#0x5	; 0230E2B8
	bhi loc_0230E2D6	; 0230E2BA
	add r0,r7,r7	; 0230E2BC
P4_SwitchIndexPC_0230E2BC:
	add r0,pc	; 0230E2BE
	ldrh r0,[r0,#(P4_SwitchTable_0230E2BC - (P4_SwitchIndexPC_0230E2BC + 4))]	; 0230E2C0
	lsl r0,r0,#0x10	; 0230E2C2
	asr r0,r0,#0x10	; 0230E2C4
P4_SwitchTargetPC_0230E2BC:
	add r0,pc	; 0230E2C6
	bx r0	; 0230E2C8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230E2BC:
	.halfword (loc_0230E2DE + 1) - (P4_SwitchTargetPC_0230E2BC + 4)
	.halfword (loc_0230E392 + 1) - (P4_SwitchTargetPC_0230E2BC + 4)
	.halfword (loc_0230E456 + 1) - (P4_SwitchTargetPC_0230E2BC + 4)
	.halfword (loc_0230E34A + 1) - (P4_SwitchTargetPC_0230E2BC + 4)
	.halfword (loc_0230E404 + 1) - (P4_SwitchTargetPC_0230E2BC + 4)
	.halfword (loc_0230E3EE + 1) - (P4_SwitchTargetPC_0230E2BC + 4)
P4_SwitchTable_0230E2BCEnd:
loc_0230E2D6:
	cmp r7,#0xdd	; 0230E2D6
	bne loc_0230E2DC	; 0230E2D8
	b loc_0230E41A	; 0230E2DA
loc_0230E2DC:
	b loc_0230E456	; 0230E2DC
loc_0230E2DE:
	cmp r6,#0x20	; 0230E2DE
	bhi loc_0230E338	; 0230E2E0
	add r2,r4,#0x0	; 0230E2E2
	add r2,#0xc	; 0230E2E4
	ldrh r1,[r2,#0x0]	; 0230E2E6
	mov r0,#0x1	; 0230E2E8
	orr r1,r0	; 0230E2EA
	strh r1,[r2,#0x0]	; 0230E2EC
	sub r0,r5,#0x2	; 0230E2EE
	str r0,[r4,#0x18]	; 0230E2F0
	cmp r6,#0x0	; 0230E2F2
	bne loc_0230E30E	; 0230E2F4
	ldrh r1,[r4,#0xc]	; 0230E2F6
	ldr r0,[pool_0230E4F0]	; 0230E2F8
	and r1,r0	; 0230E2FA
	cmp r1,#0x0	; 0230E2FC
	beq loc_0230E30E	; 0230E2FE
	add r2,r4,#0x0	; 0230E300
	add r2,#0xa	; 0230E302
	ldrh r1,[r2,#0x0]	; 0230E304
	mov r0,#0x1	; 0230E306
	orr r1,r0	; 0230E308
	strh r1,[r2,#0x0]	; 0230E30A
	b loc_0230E456	; 0230E30C
loc_0230E30E:
	add r2,r4,#0x0	; 0230E30E
	add r2,#0xa	; 0230E310
	ldrh r1,[r2,#0x0]	; 0230E312
	mov r0,#0x1	; 0230E314
	bic r1,r0	; 0230E316
	strh r1,[r2,#0x0]	; 0230E318
	lsl r0,r6,#0x10	; 0230E31A
	lsr r0,r0,#0x10	; 0230E31C
	add r1,r5,#0x0	; 0230E31E
	bl loc_023060E4	; 0230E320
	cmp r0,#0x0	; 0230E324
	bne loc_0230E32A	; 0230E326
	b loc_0230E456	; 0230E328
loc_0230E32A:
	add r2,r4,#0x0	; 0230E32A
	add r2,#0xa	; 0230E32C
	ldrh r1,[r2,#0x0]	; 0230E32E
	mov r0,#0x1	; 0230E330
	orr r1,r0	; 0230E332
	strh r1,[r2,#0x0]	; 0230E334
	b loc_0230E456	; 0230E336
loc_0230E338:
	add r2,r4,#0x0	; 0230E338
	add r2,#0xc	; 0230E33A
	ldrh r1,[r2,#0x0]	; 0230E33C
	mov r0,#0x1	; 0230E33E
	bic r1,r0	; 0230E340
	strh r1,[r2,#0x0]	; 0230E342
	mov r0,#0x0	; 0230E344
	str r0,[r4,#0x18]	; 0230E346
	b loc_0230E456	; 0230E348
loc_0230E34A:
	cmp r6,#0x1	; 0230E34A
	bcs loc_0230E350	; 0230E34C
	b loc_0230E456	; 0230E34E
loc_0230E350:
	add r2,r4,#0x0	; 0230E350
	add r2,#0xc	; 0230E352
	ldrh r1,[r2,#0x0]	; 0230E354
	mov r0,#0x2	; 0230E356
	orr r1,r0	; 0230E358
	strh r1,[r2,#0x0]	; 0230E35A
	add r0,r5,#0x0	; 0230E35C
	bl loc_023053B4	; 0230E35E
	strh r0,[r4,#0x12]	; 0230E362
	ldrh r0,[r4,#0x12]	; 0230E364
	ldr r1,[pool_0230E4E8]	; 0230E366
	ldr r2,[r1,#0x0]	; 0230E368
	ldr r1,[pool_0230E4F4]	; 0230E36A
	ldr r1,[r2,r1]	; 0230E36C
	add r1,#0x4a	; 0230E36E
	ldrh r1,[r1,#0x0]	; 0230E370
	cmp r0,r1	; 0230E372
	bne loc_0230E384	; 0230E374
	add r2,r4,#0x0	; 0230E376
	add r2,#0xa	; 0230E378
	ldrh r1,[r2,#0x0]	; 0230E37A
	mov r0,#0x2	; 0230E37C
	orr r1,r0	; 0230E37E
	strh r1,[r2,#0x0]	; 0230E380
	b loc_0230E456	; 0230E382
loc_0230E384:
	add r2,r4,#0x0	; 0230E384
	add r2,#0xa	; 0230E386
	ldrh r1,[r2,#0x0]	; 0230E388
	mov r0,#0x2	; 0230E38A
	bic r1,r0	; 0230E38C
	strh r1,[r2,#0x0]	; 0230E38E
	b loc_0230E456	; 0230E390
loc_0230E392:
	cmp r6,#0x1	; 0230E392
	bcc loc_0230E456	; 0230E394
	add r2,r4,#0x0	; 0230E396
	add r2,#0xc	; 0230E398
	ldrh r1,[r2,#0x0]	; 0230E39A
	mov r0,#0x4	; 0230E39C
	orr r1,r0	; 0230E39E
	strh r1,[r2,#0x0]	; 0230E3A0
	sub r0,r5,#0x2	; 0230E3A2
	add r1,r4,#0x0	; 0230E3A4
	add r1,#0x14	; 0230E3A6
	bl loc_02306060	; 0230E3A8
	ldr r0,[pool_0230E4E8]	; 0230E3AC
	ldr r3,[r0,#0x0]	; 0230E3AE
	ldrh r2,[r4,#0x14]	; 0230E3B0
	ldr r0,[pool_0230E4F8]	; 0230E3B2
	ldrh r1,[r3,r0]	; 0230E3B4
	ldr r0,[pool_0230E4FC]	; 0230E3B6
	ldrh r0,[r3,r0]	; 0230E3B8
	add r3,r1,#0x0	; 0230E3BA
	orr r3,r0	; 0230E3BC
	add r0,r2,#0x0	; 0230E3BE
	bic r0,r3	; 0230E3C0
	cmp r0,#0x0	; 0230E3C2
	bne loc_0230E3E0	; 0230E3C4
	ldrh r0,[r4,#0x16]	; 0230E3C6
	orr r2,r0	; 0230E3C8
	add r0,r1,#0x0	; 0230E3CA
	and r0,r2	; 0230E3CC
	cmp r1,r0	; 0230E3CE
	bne loc_0230E3E0	; 0230E3D0
	add r2,r4,#0x0	; 0230E3D2
	add r2,#0xa	; 0230E3D4
	ldrh r1,[r2,#0x0]	; 0230E3D6
	mov r0,#0x4	; 0230E3D8
	orr r1,r0	; 0230E3DA
	strh r1,[r2,#0x0]	; 0230E3DC
	b loc_0230E456	; 0230E3DE
loc_0230E3E0:
	add r2,r4,#0x0	; 0230E3E0
	add r2,#0xa	; 0230E3E2
	ldrh r1,[r2,#0x0]	; 0230E3E4
	mov r0,#0x4	; 0230E3E6
	bic r1,r0	; 0230E3E8
	strh r1,[r2,#0x0]	; 0230E3EA
	b loc_0230E456	; 0230E3EC
loc_0230E3EE:
	cmp r6,#0x3	; 0230E3EE
	bcc loc_0230E456	; 0230E3F0
	add r2,r4,#0x0	; 0230E3F2
	add r2,#0xc	; 0230E3F4
	ldrh r1,[r2,#0x0]	; 0230E3F6
	ldr r0,[pool_0230E500]	; 0230E3F8
	orr r1,r0	; 0230E3FA
	strh r1,[r2,#0x0]	; 0230E3FC
	sub r0,r5,#0x2	; 0230E3FE
	str r0,[r4,#0x20]	; 0230E400
	b loc_0230E456	; 0230E402
loc_0230E404:
	cmp r6,#0x6	; 0230E404
	bcc loc_0230E456	; 0230E406
	add r2,r4,#0x0	; 0230E408
	add r2,#0xc	; 0230E40A
	ldrh r1,[r2,#0x0]	; 0230E40C
	ldr r0,[pool_0230E504]	; 0230E40E
	orr r1,r0	; 0230E410
	strh r1,[r2,#0x0]	; 0230E412
	sub r0,r5,#0x2	; 0230E414
	str r0,[r4,#0x1c]	; 0230E416
	b loc_0230E456	; 0230E418
loc_0230E41A:
	cmp r6,#0x8	; 0230E41A
	bcc loc_0230E456	; 0230E41C
	add r0,r5,#0x0	; 0230E41E
	bl loc_023053B4	; 0230E420
	cmp r0,#0x0	; 0230E424
	bne loc_0230E456	; 0230E426
	add r0,r5,#0x1	; 0230E428
	bl loc_023053B4	; 0230E42A
	cmp r0,#0x9	; 0230E42E
	bne loc_0230E456	; 0230E430
	add r0,r5,#0x2	; 0230E432
	bl loc_023053B4	; 0230E434
	cmp r0,#0xbf	; 0230E438
	bne loc_0230E456	; 0230E43A
	add r0,r5,#0x3	; 0230E43C
	bl loc_023053B4	; 0230E43E
	cmp r0,#0x0	; 0230E442
	bne loc_0230E456	; 0230E444
	add r2,r4,#0x0	; 0230E446
	add r2,#0xc	; 0230E448
	ldrh r1,[r2,#0x0]	; 0230E44A
	ldr r0,[pool_0230E508]	; 0230E44C
	orr r1,r0	; 0230E44E
	strh r1,[r2,#0x0]	; 0230E450
	sub r0,r5,#0x2	; 0230E452
	str r0,[r4,#0x24]	; 0230E454
loc_0230E456:
	add r5,r5,r6	; 0230E456
	add r1,r6,#0x2	; 0230E458
	ldr r0,[sp,#0x0]	; 0230E45A
	sub r0,r0,r1	; 0230E45C
	str r0,[sp,#0x0]	; 0230E45E
loc_0230E460:
	ldr r0,[sp,#0x0]	; 0230E460
	cmp r0,#0x0	; 0230E462
	ble loc_0230E468	; 0230E464
	b loc_0230E2A6	; 0230E466
loc_0230E468:
	ldrh r1,[r4,#0xc]	; 0230E468
	mov r0,#0x8	; 0230E46A
	and r1,r0	; 0230E46C
	cmp r1,#0x0	; 0230E46E
	beq loc_0230E498	; 0230E470
	ldr r0,[pool_0230E4E8]	; 0230E472
	ldr r1,[r0,#0x0]	; 0230E474
	ldr r0,[pool_0230E50C]	; 0230E476
	ldrh r1,[r1,r0]	; 0230E478
	mov r0,#0x1	; 0230E47A
	and r1,r0	; 0230E47C
	cmp r1,#0x0	; 0230E47E
	bne loc_0230E48C	; 0230E480
	ldrh r1,[r4,#0x4]	; 0230E482
	ldr r0,[pool_0230E510]	; 0230E484
	and r1,r0	; 0230E486
	cmp r1,#0x0	; 0230E488
	beq loc_0230E498	; 0230E48A
loc_0230E48C:
	add r2,r4,#0x0	; 0230E48C
	add r2,#0xa	; 0230E48E
	ldrh r1,[r2,#0x0]	; 0230E490
	mov r0,#0x8	; 0230E492
	orr r1,r0	; 0230E494
	strh r1,[r2,#0x0]	; 0230E496
loc_0230E498:
	ldrh r1,[r4,#0xc]	; 0230E498
	mov r0,#0x30	; 0230E49A
	and r1,r0	; 0230E49C
	cmp r1,#0x0	; 0230E49E
	beq loc_0230E4E0	; 0230E4A0
	ldrh r3,[r4,#0x6]	; 0230E4A2
	mov r1,#0x3	; 0230E4A4
	and r3,r1	; 0230E4A6
	ldr r0,[pool_0230E4E8]	; 0230E4A8
	ldr r2,[r0,#0x0]	; 0230E4AA
	ldr r0,[pool_0230E514]	; 0230E4AC
	ldrh r0,[r2,r0]	; 0230E4AE
	and r0,r1	; 0230E4B0
	cmp r3,r0	; 0230E4B2
	bne loc_0230E4C2	; 0230E4B4
	add r2,r4,#0x0	; 0230E4B6
	add r2,#0xa	; 0230E4B8
	ldrh r1,[r2,#0x0]	; 0230E4BA
	mov r0,#0x10	; 0230E4BC
	orr r1,r0	; 0230E4BE
	strh r1,[r2,#0x0]	; 0230E4C0
loc_0230E4C2:
	ldrh r3,[r4,#0x6]	; 0230E4C2
	mov r1,#0x10	; 0230E4C4
	and r3,r1	; 0230E4C6
	ldr r0,[pool_0230E4E8]	; 0230E4C8
	ldr r2,[r0,#0x0]	; 0230E4CA
	ldr r0,[pool_0230E514]	; 0230E4CC
	ldrh r0,[r2,r0]	; 0230E4CE
	and r0,r1	; 0230E4D0
	cmp r3,r0	; 0230E4D2
	bne loc_0230E4E0	; 0230E4D4
	add r4,#0xa	; 0230E4D6
	ldrh r1,[r4,#0x0]	; 0230E4D8
	mov r0,#0x20	; 0230E4DA
	orr r1,r0	; 0230E4DC
	strh r1,[r4,#0x0]	; 0230E4DE
loc_0230E4E0:
	add sp,#0x4	; 0230E4E0
	pop {r4,r5,r6,r7}	; 0230E4E2
	pop {r3}	; 0230E4E4
	bx r3	; 0230E4E6
pool_0230E4E8:
loc_0230E4E8:
	.word FirmwareWlWorkPointerSlot	; 0230E4E8
pool_0230E4EC:
loc_0230E4EC:
	.word 0x00000376	; 0230E4EC
pool_0230E4F0:
loc_0230E4F0:
	.word 0x00000800	; 0230E4F0
pool_0230E4F4:
loc_0230E4F4:
	.word 0x000003D4	; 0230E4F4
pool_0230E4F8:
loc_0230E4F8:
	.word 0x0000035C	; 0230E4F8
pool_0230E4FC:
loc_0230E4FC:
	.word 0x0000035E	; 0230E4FC
pool_0230E500:
loc_0230E500:
	.word 0x00000100	; 0230E500
pool_0230E504:
loc_0230E504:
	.word 0x00000200	; 0230E504
pool_0230E508:
loc_0230E508:
	.word 0x00000400	; 0230E508
pool_0230E50C:
loc_0230E50C:
	.word 0x00000360	; 0230E50C
pool_0230E510:
loc_0230E510:
	.word 0x00008000	; 0230E510
pool_0230E514:
loc_0230E514:
	.word 0x00000378	; 0230E514

; ===== function loc_0230E518 =====
loc_0230E518:
	bx lr	; 0230E518
	.byte 0x00, 0x00	; 0230E51C

; ===== function loc_0230E51C =====
loc_0230E51C:
	push {r4,r5,lr}	; 0230E51C
	sub sp,#0x4	; 0230E51E
	ldrh r2,[r0,#0x2]	; 0230E520
	ldr r1,[pool_0230E570]	; 0230E522
	ldr r0,[r1,#0x0]	; 0230E524
	ldr r3,[pool_0230E574]	; 0230E526
	ldr r5,[r0,r3]	; 0230E528
	mov r3,#0x1c	; 0230E52A
	add r4,r2,#0x0	; 0230E52C
	mul r4,r3	; 0230E52E
	ldrh r3,[r5,r4]	; 0230E530
	cmp r3,#0x40	; 0230E532
	bne loc_0230E566	; 0230E534
	ldr r3,[pool_0230E578]	; 0230E536
	add r5,r0,r3	; 0230E538
	ldrh r4,[r5,#0x0]	; 0230E53A
	mov r0,#0x1	; 0230E53C
	add r3,r0,#0x0	; 0230E53E
	lsl r3,r2	; 0230E540
	orr r4,r3	; 0230E542
	strh r4,[r5,#0x0]	; 0230E544
	ldr r2,[r1,#0x0]	; 0230E546
	ldr r1,[pool_0230E57C]	; 0230E548
	ldrh r1,[r2,r1]	; 0230E54A
	cmp r1,#0x0	; 0230E54C
	beq loc_0230E554	; 0230E54E
	bl loc_0230D670	; 0230E550
loc_0230E554:
	ldr r0,[pool_0230E570]	; 0230E554
	ldr r1,[r0,#0x0]	; 0230E556
	ldr r0,[pool_0230E580]	; 0230E558
	ldrh r0,[r1,r0]	; 0230E55A
	cmp r0,#0x0	; 0230E55C
	beq loc_0230E566	; 0230E55E
	mov r0,#0x0	; 0230E560
	bl loc_0230D670	; 0230E562
loc_0230E566:
	add sp,#0x4	; 0230E566
	pop {r4,r5}	; 0230E568
	pop {r3}	; 0230E56A
	bx r3	; 0230E56C
	.byte 0xC0, 0x46	; 0230E570
pool_0230E570:
loc_0230E570:
	.word FirmwareWlWorkPointerSlot	; 0230E570
pool_0230E574:
loc_0230E574:
	.word 0x000002E0	; 0230E574
pool_0230E578:
loc_0230E578:
	.word 0x000004EC	; 0230E578
pool_0230E57C:
loc_0230E57C:
	.word 0x0000016C	; 0230E57C
pool_0230E580:
loc_0230E580:
	.word 0x00000160	; 0230E580

; ===== function loc_0230E584 =====
loc_0230E584:
	push {r4,r5,lr}	; 0230E584
	sub sp,#0x4	; 0230E586
	add r5,r0,#0x0	; 0230E588
	ldrh r4,[r5,#0x2]	; 0230E58A
	ldr r0,[pool_0230E610]	; 0230E58C
	ldr r0,[r0,#0x0]	; 0230E58E
	ldr r1,[pool_0230E614]	; 0230E590
	ldrh r1,[r0,r1]	; 0230E592
	cmp r1,#0x1	; 0230E594
	beq loc_0230E5A2	; 0230E596
	cmp r1,#0x2	; 0230E598
	beq loc_0230E5CE	; 0230E59A
	cmp r1,#0x3	; 0230E59C
	beq loc_0230E5CE	; 0230E59E
	b loc_0230E608	; 0230E5A0
loc_0230E5A2:
	ldr r1,[pool_0230E618]	; 0230E5A2
	ldr r2,[r0,r1]	; 0230E5A4
	mov r0,#0x1c	; 0230E5A6
	add r1,r4,#0x0	; 0230E5A8
	mul r1,r0	; 0230E5AA
	ldrh r0,[r2,r1]	; 0230E5AC
	cmp r0,#0x20	; 0230E5AE
	bls loc_0230E608	; 0230E5B0
	lsl r0,r4,#0x10	; 0230E5B2
	lsr r0,r0,#0x10	; 0230E5B4
	mov r1,#0x20	; 0230E5B6
	bl loc_023091EC	; 0230E5B8
	add r0,r5,#0x0	; 0230E5BC
	add r0,#0x1e	; 0230E5BE
	ldrh r1,[r5,#0x2c]	; 0230E5C0
	bl loc_02309B68	; 0230E5C2
	add r0,r4,#0x0	; 0230E5C6
	bl loc_0230CC7C	; 0230E5C8
	b loc_0230E608	; 0230E5CC
loc_0230E5CE:
	ldr r1,[pool_0230E61C]	; 0230E5CE
	ldrh r1,[r0,r1]	; 0230E5D0
	cmp r1,#0x20	; 0230E5D2
	bls loc_0230E608	; 0230E5D4
	ldrh r2,[r5,#0x22]	; 0230E5D6
	ldr r1,[pool_0230E620]	; 0230E5D8
	ldrh r1,[r0,r1]	; 0230E5DA
	cmp r2,r1	; 0230E5DC
	bne loc_0230E608	; 0230E5DE
	ldrh r2,[r5,#0x20]	; 0230E5E0
	ldr r1,[pool_0230E624]	; 0230E5E2
	ldrh r1,[r0,r1]	; 0230E5E4
	cmp r2,r1	; 0230E5E6
	bne loc_0230E608	; 0230E5E8
	ldrh r2,[r5,#0x1e]	; 0230E5EA
	ldr r1,[pool_0230E628]	; 0230E5EC
	ldrh r0,[r0,r1]	; 0230E5EE
	cmp r2,r0	; 0230E5F0
	bne loc_0230E608	; 0230E5F2
	mov r0,#0x20	; 0230E5F4
	bl loc_02306468	; 0230E5F6
	bl loc_023064D4	; 0230E5FA
	add r0,r5,#0x0	; 0230E5FE
	add r0,#0x1e	; 0230E600
	ldrh r1,[r5,#0x2c]	; 0230E602
	bl loc_02309B68	; 0230E604
loc_0230E608:
	add sp,#0x4	; 0230E608
	pop {r4,r5}	; 0230E60A
	pop {r3}	; 0230E60C
	bx r3	; 0230E60E
pool_0230E610:
loc_0230E610:
	.word FirmwareWlWorkPointerSlot	; 0230E610
pool_0230E614:
loc_0230E614:
	.word 0x00000314	; 0230E614
pool_0230E618:
loc_0230E618:
	.word 0x000002E0	; 0230E618
pool_0230E61C:
loc_0230E61C:
	.word 0x00000310	; 0230E61C
pool_0230E620:
loc_0230E620:
	.word 0x00000382	; 0230E620
pool_0230E624:
loc_0230E624:
	.word 0x00000380	; 0230E624
pool_0230E628:
loc_0230E628:
	.word 0x0000037E	; 0230E628

; ===== function loc_0230E62C =====
loc_0230E62C:
	push {r4,r5,r6,r7,lr}	; 0230E62C
	sub sp,#0x14	; 0230E62E
	add r5,r0,#0x0	; 0230E630
	add r4,r5,#0x0	; 0230E632
	add r4,#0x2c	; 0230E634
	ldr r0,[pool_0230E97C]	; 0230E636
	ldr r0,[r0,#0x0]	; 0230E638
	ldr r1,[pool_0230E980]	; 0230E63A
	ldrh r2,[r0,r1]	; 0230E63C
	mov r1,#0x8	; 0230E63E
	and r2,r1	; 0230E640
	cmp r2,#0x0	; 0230E642
	beq loc_0230E69A	; 0230E644
	ldr r1,[pool_0230E984]	; 0230E646
	add r1,r0,r1	; 0230E648
	ldr r0,[pool_0230E988]	; 0230E64A
	ldrh r0,[r0,#0x0]	; 0230E64C
	mov r2,#0x1	; 0230E64E
	add r3,r0,#0x0	; 0230E650
	and r3,r2	; 0230E652
	cmp r3,#0x0	; 0230E654
	beq loc_0230E65E	; 0230E656
	ldrh r2,[r1,#0x0]	; 0230E658
	cmp r2,#0x0	; 0230E65A
	bne loc_0230E69A	; 0230E65C
loc_0230E65E:
	mov r2,#0x4	; 0230E65E
	add r3,r0,#0x0	; 0230E660
	and r3,r2	; 0230E662
	cmp r3,#0x0	; 0230E664
	beq loc_0230E66E	; 0230E666
	ldrh r2,[r1,#0x14]	; 0230E668
	cmp r2,#0x0	; 0230E66A
	bne loc_0230E69A	; 0230E66C
loc_0230E66E:
	mov r2,#0x8	; 0230E66E
	and r0,r2	; 0230E670
	cmp r0,#0x0	; 0230E672
	beq loc_0230E67C	; 0230E674
	ldrh r0,[r1,#0x28]	; 0230E676
	cmp r0,#0x0	; 0230E678
	bne loc_0230E69A	; 0230E67A
loc_0230E67C:
	ldr r0,[pool_0230E98C]	; 0230E67C
	ldrh r1,[r0,#0x0]	; 0230E67E
	mov r0,#0x1	; 0230E680
	and r1,r0	; 0230E682
	cmp r1,#0x0	; 0230E684
	bne loc_0230E69A	; 0230E686
	mov r0,#0x0	; 0230E688
	ldr r2,[pool_0230E990]	; 0230E68A
	strh r0,[r2,#0x0]	; 0230E68C
	ldr r1,[pool_0230E994]	; 0230E68E
	strh r1,[r2,#0x0]	; 0230E690
	ldr r1,[pool_0230E97C]	; 0230E692
	ldr r2,[r1,#0x0]	; 0230E694
	ldr r1,[pool_0230E998]	; 0230E696
	strh r0,[r2,r1]	; 0230E698
loc_0230E69A:
	mov r0,#0x0	; 0230E69A
	str r0,[sp,#0x0]	; 0230E69C
	ldrh r0,[r4,#0x2]	; 0230E69E
	add r0,r0,#0x1	; 0230E6A0
	lsl r0,r0,#0x10	; 0230E6A2
	lsr r0,r0,#0x10	; 0230E6A4
	str r0,[sp,#0x4]	; 0230E6A6
	ldrh r6,[r5,#0x2]	; 0230E6A8
	cmp r6,#0x0	; 0230E6AA
	bne loc_0230E6B6	; 0230E6AC
	mov r7,#0x13	; 0230E6AE
	mov r0,#0x1	; 0230E6B0
	str r0,[sp,#0x0]	; 0230E6B2
	b loc_0230EA26	; 0230E6B4
loc_0230E6B6:
	ldr r0,[pool_0230E97C]	; 0230E6B6
	ldr r0,[r0,#0x0]	; 0230E6B8
	ldr r1,[pool_0230E99C]	; 0230E6BA
	ldrh r1,[r0,r1]	; 0230E6BC
	cmp r1,#0x1	; 0230E6BE
	bne loc_0230E722	; 0230E6C0
	mov r2,#0x1c	; 0230E6C2
	add r1,r6,#0x0	; 0230E6C4
	str r1,[sp,#0x8]	; 0230E6C6
	mul r1,r2	; 0230E6C8
	str r1,[sp,#0x8]	; 0230E6CA
	ldr r1,[pool_0230E9A0]	; 0230E6CC
	ldr r1,[r0,r1]	; 0230E6CE
	ldr r0,[sp,#0x8]	; 0230E6D0
	ldrh r0,[r1,r0]	; 0230E6D2
	cmp r0,#0x20	; 0230E6D4
	bls loc_0230E6EC	; 0230E6D6
	lsl r0,r6,#0x10	; 0230E6D8
	lsr r0,r0,#0x10	; 0230E6DA
	mov r1,#0x20	; 0230E6DC
	bl loc_023091EC	; 0230E6DE
	add r0,r5,#0x0	; 0230E6E2
	add r0,#0x1e	; 0230E6E4
	mov r1,#0x1	; 0230E6E6
	bl loc_02309B68	; 0230E6E8
loc_0230E6EC:
	ldrh r1,[r5,#0x8]	; 0230E6EC
	ldr r0,[pool_0230E9A4]	; 0230E6EE
	and r1,r0	; 0230E6F0
	cmp r1,#0x0	; 0230E6F2
	beq loc_0230E722	; 0230E6F4
	ldr r2,[pool_0230E97C]	; 0230E6F6
	ldr r0,[r2,#0x0]	; 0230E6F8
	ldr r3,[pool_0230E9A0]	; 0230E6FA
	ldr r1,[r0,r3]	; 0230E6FC
	ldr r0,[sp,#0x8]	; 0230E6FE
	add r0,r1,r0	; 0230E700
	ldrh r0,[r0,#0xe]	; 0230E702
	cmp r0,#0x0	; 0230E704
	beq loc_0230E722	; 0230E706
	mov r0,#0x1	; 0230E708
	str r0,[sp,#0x0]	; 0230E70A
	strh r0,[r4,#0x0]	; 0230E70C
	mov r7,#0xf	; 0230E70E
	mov r0,#0x4	; 0230E710
	str r0,[sp,#0x4]	; 0230E712
	mov r0,#0x0	; 0230E714
	ldr r1,[r2,#0x0]	; 0230E716
	ldr r2,[r1,r3]	; 0230E718
	ldr r1,[sp,#0x8]	; 0230E71A
	add r1,r2,r1	; 0230E71C
	strh r0,[r1,#0xe]	; 0230E71E
	b loc_0230EA26	; 0230E720
loc_0230E722:
	ldrh r0,[r4,#0x0]	; 0230E722
	cmp r0,#0x0	; 0230E724
	beq loc_0230E72E	; 0230E726
	cmp r0,#0x1	; 0230E728
	beq loc_0230E7F6	; 0230E72A
	b loc_0230EA14	; 0230E72C
loc_0230E72E:
	ldr r0,[pool_0230E97C]	; 0230E72E
	ldr r1,[r0,#0x0]	; 0230E730
	ldr r0,[pool_0230E99C]	; 0230E732
	ldrh r2,[r1,r0]	; 0230E734
	cmp r2,#0x1	; 0230E736
	bne loc_0230E74A	; 0230E738
	ldr r0,[pool_0230E9A8]	; 0230E73A
	ldrh r0,[r1,r0]	; 0230E73C
	cmp r0,#0x1	; 0230E73E
	bne loc_0230E74A	; 0230E740
	mov r7,#0xd	; 0230E742
	mov r0,#0x1	; 0230E744
	str r0,[sp,#0x0]	; 0230E746
	b loc_0230EA26	; 0230E748
loc_0230E74A:
	cmp r2,#0x1	; 0230E74A
	bne loc_0230E768	; 0230E74C
	ldrh r0,[r4,#0x2]	; 0230E74E
	cmp r0,#0x1	; 0230E750
	bne loc_0230E75C	; 0230E752
	mov r7,#0x0	; 0230E754
	mov r0,#0x1	; 0230E756
	str r0,[sp,#0x0]	; 0230E758
	b loc_0230EA26	; 0230E75A
loc_0230E75C:
	mov r7,#0xe	; 0230E75C
	mov r0,#0x2	; 0230E75E
	str r0,[sp,#0x4]	; 0230E760
	mov r0,#0x1	; 0230E762
	str r0,[sp,#0x0]	; 0230E764
	b loc_0230EA26	; 0230E766
loc_0230E768:
	cmp r2,#0x1	; 0230E768
	bne loc_0230E76E	; 0230E76A
	b loc_0230EA26	; 0230E76C
loc_0230E76E:
	ldrh r0,[r4,#0x2]	; 0230E76E
	cmp r0,#0x2	; 0230E770
	beq loc_0230E776	; 0230E772
	b loc_0230EA26	; 0230E774
loc_0230E776:
	ldr r0,[pool_0230E9AC]	; 0230E776
	ldr r0,[r1,r0]	; 0230E778
	ldrh r2,[r0,#0x16]	; 0230E77A
	cmp r2,#0x0	; 0230E77C
	beq loc_0230E782	; 0230E77E
	b loc_0230EA26	; 0230E780
loc_0230E782:
	ldrh r3,[r0,#0x14]	; 0230E782
	ldrh r2,[r5,#0x22]	; 0230E784
	cmp r3,r2	; 0230E786
	beq loc_0230E78C	; 0230E788
	b loc_0230EA26	; 0230E78A
loc_0230E78C:
	ldrh r3,[r0,#0x12]	; 0230E78C
	ldrh r2,[r5,#0x20]	; 0230E78E
	cmp r3,r2	; 0230E790
	beq loc_0230E796	; 0230E792
	b loc_0230EA26	; 0230E794
loc_0230E796:
	ldrh r2,[r0,#0x10]	; 0230E796
	ldrh r0,[r5,#0x1e]	; 0230E798
	cmp r2,r0	; 0230E79A
	beq loc_0230E7A0	; 0230E79C
	b loc_0230EA26	; 0230E79E
loc_0230E7A0:
	ldr r0,[pool_0230E9B0]	; 0230E7A0
	ldrh r0,[r1,r0]	; 0230E7A2
	cmp r0,#0x31	; 0230E7A4
	beq loc_0230E7AA	; 0230E7A6
	b loc_0230EA26	; 0230E7A8
loc_0230E7AA:
	bl loc_0230558C	; 0230E7AA
	ldrh r0,[r4,#0x4]	; 0230E7AE
	cmp r0,#0x0	; 0230E7B0
	bne loc_0230E7CE	; 0230E7B2
	mov r0,#0x30	; 0230E7B4
	bl loc_02306468	; 0230E7B6
	mov r1,#0x0	; 0230E7BA
	ldr r0,[pool_0230E97C]	; 0230E7BC
	ldr r3,[r0,#0x0]	; 0230E7BE
	ldr r2,[pool_0230E9B4]	; 0230E7C0
	ldr r3,[r3,r2]	; 0230E7C2
	strh r1,[r3,#0x4]	; 0230E7C4
	ldr r0,[r0,#0x0]	; 0230E7C6
	ldr r0,[r0,r2]	; 0230E7C8
	strh r1,[r0,#0x6]	; 0230E7CA
	b loc_0230E7E2	; 0230E7CC
loc_0230E7CE:
	mov r0,#0xc	; 0230E7CE
	ldr r1,[pool_0230E97C]	; 0230E7D0
	ldr r3,[r1,#0x0]	; 0230E7D2
	ldr r2,[pool_0230E9B4]	; 0230E7D4
	ldr r3,[r3,r2]	; 0230E7D6
	strh r0,[r3,#0x4]	; 0230E7D8
	ldrh r0,[r4,#0x4]	; 0230E7DA
	ldr r1,[r1,#0x0]	; 0230E7DC
	ldr r1,[r1,r2]	; 0230E7DE
	strh r0,[r1,#0x6]	; 0230E7E0
loc_0230E7E2:
	mov r2,#0x35	; 0230E7E2
	ldr r0,[pool_0230E97C]	; 0230E7E4
	ldr r1,[r0,#0x0]	; 0230E7E6
	ldr r0,[pool_0230E9B0]	; 0230E7E8
	strh r2,[r1,r0]	; 0230E7EA
	mov r0,#0x2	; 0230E7EC
	add r1,r0,#0x0	; 0230E7EE
	bl loc_02304B68	; 0230E7F0
	b loc_0230EA26	; 0230E7F4
loc_0230E7F6:
	ldr r0,[pool_0230E97C]	; 0230E7F6
	ldr r1,[r0,#0x0]	; 0230E7F8
	ldr r0,[pool_0230E99C]	; 0230E7FA
	ldrh r0,[r1,r0]	; 0230E7FC
	cmp r0,#0x1	; 0230E7FE
	bne loc_0230E8B6	; 0230E800
	lsl r0,r6,#0x10	; 0230E802
	lsr r0,r0,#0x10	; 0230E804
	mov r1,#0x20	; 0230E806
	bl loc_023091EC	; 0230E808
	ldrh r0,[r4,#0x2]	; 0230E80C
	cmp r0,#0x1	; 0230E80E
	bne loc_0230E840	; 0230E810
	add r0,r5,#0x0	; 0230E812
	add r0,#0x1e	; 0230E814
	mov r1,#0x80	; 0230E816
	bl loc_0230C0D0	; 0230E818
	str r0,[sp,#0xc]	; 0230E81C
	cmp r0,#0x0	; 0230E81E
	bne loc_0230E824	; 0230E820
	b loc_0230EA26	; 0230E822
loc_0230E824:
	ldrh r1,[r4,#0x0]	; 0230E824
	strh r1,[r0,#0x2c]	; 0230E826
	ldr r1,[sp,#0x4]	; 0230E828
	strh r1,[r0,#0x2e]	; 0230E82A
	mov r1,#0x0	; 0230E82C
	strh r1,[r0,#0x30]	; 0230E82E
	add r0,r6,#0x0	; 0230E830
	ldr r1,[sp,#0xc]	; 0230E832
	bl loc_0230DF70	; 0230E834
	ldr r0,[sp,#0xc]	; 0230E838
	bl loc_0230CAEC	; 0230E83A
	b loc_0230EA26	; 0230E83E
loc_0230E840:
	cmp r0,#0x3	; 0230E840
	bne loc_0230E898	; 0230E842
	mov r0,#0x1c	; 0230E844
	mul r6,r0	; 0230E846
	ldr r0,[pool_0230E97C]	; 0230E848
	ldr r1,[r0,#0x0]	; 0230E84A
	ldr r0,[pool_0230E9A0]	; 0230E84C
	ldr r1,[r1,r0]	; 0230E84E
	ldrh r0,[r1,r6]	; 0230E850
	cmp r0,#0x20	; 0230E852
	bne loc_0230E85E	; 0230E854
	add r0,r1,r6	; 0230E856
	ldrh r0,[r0,#0xe]	; 0230E858
	cmp r0,#0x0	; 0230E85A
	bne loc_0230E864	; 0230E85C
loc_0230E85E:
	mov r7,#0x1	; 0230E85E
	str r7,[sp,#0x0]	; 0230E860
	b loc_0230EA26	; 0230E862
loc_0230E864:
	add r0,r5,#0x0	; 0230E864
	bl loc_0230DEFC	; 0230E866
	cmp r0,#0x0	; 0230E86A
	bne loc_0230E884	; 0230E86C
	mov r7,#0xf	; 0230E86E
	mov r0,#0x1	; 0230E870
	str r0,[sp,#0x0]	; 0230E872
	mov r0,#0x0	; 0230E874
	ldr r1,[pool_0230E97C]	; 0230E876
	ldr r2,[r1,#0x0]	; 0230E878
	ldr r1,[pool_0230E9A0]	; 0230E87A
	ldr r1,[r2,r1]	; 0230E87C
	add r1,r1,r6	; 0230E87E
	strh r0,[r1,#0xe]	; 0230E880
	b loc_0230EA26	; 0230E882
loc_0230E884:
	mov r7,#0x0	; 0230E884
	ldr r0,[pool_0230E97C]	; 0230E886
	ldr r1,[r0,#0x0]	; 0230E888
	ldr r0,[pool_0230E9A0]	; 0230E88A
	ldr r0,[r1,r0]	; 0230E88C
	add r0,r0,r6	; 0230E88E
	strh r7,[r0,#0xe]	; 0230E890
	mov r0,#0x1	; 0230E892
	str r0,[sp,#0x0]	; 0230E894
	b loc_0230EA26	; 0230E896
loc_0230E898:
	mov r0,#0x0	; 0230E898
	ldr r1,[pool_0230E97C]	; 0230E89A
	ldr r2,[r1,#0x0]	; 0230E89C
	ldr r1,[pool_0230E9A0]	; 0230E89E
	ldr r2,[r2,r1]	; 0230E8A0
	mov r1,#0x1c	; 0230E8A2
	mul r6,r1	; 0230E8A4
	add r1,r2,r6	; 0230E8A6
	strh r0,[r1,#0xe]	; 0230E8A8
	mov r7,#0xe	; 0230E8AA
	mov r0,#0x2	; 0230E8AC
	str r0,[sp,#0x4]	; 0230E8AE
	mov r0,#0x1	; 0230E8B0
	str r0,[sp,#0x0]	; 0230E8B2
	b loc_0230EA26	; 0230E8B4
loc_0230E8B6:
	ldr r0,[pool_0230E9AC]	; 0230E8B6
	ldr r0,[r1,r0]	; 0230E8B8
	ldrh r2,[r0,#0x16]	; 0230E8BA
	cmp r2,#0x1	; 0230E8BC
	beq loc_0230E8C2	; 0230E8BE
	b loc_0230EA26	; 0230E8C0
loc_0230E8C2:
	ldrh r3,[r0,#0x14]	; 0230E8C2
	ldrh r2,[r5,#0x22]	; 0230E8C4
	cmp r3,r2	; 0230E8C6
	bne loc_0230E8DE	; 0230E8C8
	ldrh r3,[r0,#0x12]	; 0230E8CA
	ldrh r2,[r5,#0x20]	; 0230E8CC
	cmp r3,r2	; 0230E8CE
	bne loc_0230E8DE	; 0230E8D0
	ldrh r2,[r0,#0x10]	; 0230E8D2
	ldrh r0,[r5,#0x1e]	; 0230E8D4
	cmp r2,r0	; 0230E8D6
	bne loc_0230E8DE	; 0230E8D8
	mov r0,#0x1	; 0230E8DA
	b loc_0230E8E0	; 0230E8DC
loc_0230E8DE:
	mov r0,#0x0	; 0230E8DE
loc_0230E8E0:
	cmp r0,#0x0	; 0230E8E0
	bne loc_0230E8E6	; 0230E8E2
	b loc_0230EA26	; 0230E8E4
loc_0230E8E6:
	ldrh r0,[r4,#0x2]	; 0230E8E6
	cmp r0,#0x2	; 0230E8E8
	bne loc_0230E9BC	; 0230E8EA
	ldr r0,[pool_0230E9B0]	; 0230E8EC
	add r0,r1,r0	; 0230E8EE
	ldrh r1,[r0,#0x0]	; 0230E8F0
	cmp r1,#0x31	; 0230E8F2
	beq loc_0230E8F8	; 0230E8F4
	b loc_0230EA26	; 0230E8F6
loc_0230E8F8:
	ldrh r1,[r4,#0x4]	; 0230E8F8
	cmp r1,#0x0	; 0230E8FA
	beq loc_0230E92E	; 0230E8FC
	bl loc_0230558C	; 0230E8FE
	mov r3,#0x35	; 0230E902
	ldr r1,[pool_0230E97C]	; 0230E904
	ldr r2,[r1,#0x0]	; 0230E906
	ldr r0,[pool_0230E9B0]	; 0230E908
	strh r3,[r2,r0]	; 0230E90A
	mov r0,#0xc	; 0230E90C
	ldr r3,[r1,#0x0]	; 0230E90E
	ldr r2,[pool_0230E9B4]	; 0230E910
	ldr r3,[r3,r2]	; 0230E912
	strh r0,[r3,#0x4]	; 0230E914
	ldrh r0,[r4,#0x4]	; 0230E916
	ldr r1,[r1,#0x0]	; 0230E918
	ldr r1,[r1,r2]	; 0230E91A
	strh r0,[r1,#0x6]	; 0230E91C
	mov r0,#0x2	; 0230E91E
	add r1,r0,#0x0	; 0230E920
	bl loc_02304B68	; 0230E922
	mov r0,#0x20	; 0230E926
	bl loc_02306468	; 0230E928
	b loc_0230EA26	; 0230E92C
loc_0230E92E:
	mov r1,#0x33	; 0230E92E
	strh r1,[r0,#0x0]	; 0230E930
	add r0,r5,#0x0	; 0230E932
	add r0,#0x33	; 0230E934
	bl loc_023053B4	; 0230E936
	add r1,r0,#0x0	; 0230E93A
	add r0,r5,#0x0	; 0230E93C
	add r0,#0x1e	; 0230E93E
	bl loc_0230C0D0	; 0230E940
	add r6,r0,#0x0	; 0230E944
	cmp r6,#0x0	; 0230E946
	beq loc_0230EA26	; 0230E948
	add r2,r6,#0x0	; 0230E94A
	add r2,#0x14	; 0230E94C
	ldrh r1,[r2,#0x0]	; 0230E94E
	ldr r0,[pool_0230E9B8]	; 0230E950
	orr r1,r0	; 0230E952
	strh r1,[r2,#0x0]	; 0230E954
	add r0,r5,#0x0	; 0230E956
	add r0,#0x2c	; 0230E958
	add r1,r6,#0x0	; 0230E95A
	add r1,#0x2c	; 0230E95C
	ldrh r2,[r5,#0x6]	; 0230E95E
	add r2,r2,#0x1	; 0230E960
	bl loc_0230EA60	; 0230E962
	ldrh r0,[r4,#0x0]	; 0230E966
	strh r0,[r6,#0x2c]	; 0230E968
	mov r0,#0x3	; 0230E96A
	strh r0,[r6,#0x2e]	; 0230E96C
	mov r0,#0x0	; 0230E96E
	strh r0,[r6,#0x30]	; 0230E970
	add r0,r6,#0x0	; 0230E972
	bl loc_0230CAEC	; 0230E974
	b loc_0230EA26	; 0230E978
	.byte 0xC0, 0x46	; 0230E97C
pool_0230E97C:
loc_0230E97C:
	.word FirmwareWlWorkPointerSlot	; 0230E97C
pool_0230E980:
loc_0230E980:
	.word 0x0000061C	; 0230E980
pool_0230E984:
loc_0230E984:
	.word 0x000003E4	; 0230E984
pool_0230E988:
loc_0230E988:
	.word REG_WIFI_TXREQ_READ	; 0230E988
pool_0230E98C:
loc_0230E98C:
	.word REG_WIFI_RF_PINS	; 0230E98C
pool_0230E990:
loc_0230E990:
	.word REG_WIFI_WEP_CNT	; 0230E990
pool_0230E994:
loc_0230E994:
	.word 0x00008000	; 0230E994
pool_0230E998:
loc_0230E998:
	.word 0x0000049A	; 0230E998
pool_0230E99C:
loc_0230E99C:
	.word 0x00000314	; 0230E99C
pool_0230E9A0:
loc_0230E9A0:
	.word 0x000002E0	; 0230E9A0
pool_0230E9A4:
loc_0230E9A4:
	.word 0x00000400	; 0230E9A4
pool_0230E9A8:
loc_0230E9A8:
	.word 0x000002F6	; 0230E9A8
pool_0230E9AC:
loc_0230E9AC:
	.word 0x000003D4	; 0230E9AC
pool_0230E9B0:
loc_0230E9B0:
	.word 0x000003BC	; 0230E9B0
pool_0230E9B4:
loc_0230E9B4:
	.word 0x000003D8	; 0230E9B4
pool_0230E9B8:
loc_0230E9B8:
	.word 0x00004000	; 0230E9B8
loc_0230E9BC:
	cmp r0,#0x4	; 0230E9BC
	bne loc_0230EA26	; 0230E9BE
	ldr r0,[pool_0230EA50]	; 0230E9C0
	ldrh r0,[r1,r0]	; 0230E9C2
	cmp r0,#0x33	; 0230E9C4
	bne loc_0230EA26	; 0230E9C6
	bl loc_0230558C	; 0230E9C8
	ldrh r0,[r4,#0x4]	; 0230E9CC
	cmp r0,#0x0	; 0230E9CE
	bne loc_0230E9EC	; 0230E9D0
	mov r0,#0x30	; 0230E9D2
	bl loc_02306468	; 0230E9D4
	mov r1,#0x0	; 0230E9D8
	ldr r0,[pool_0230EA54]	; 0230E9DA
	ldr r3,[r0,#0x0]	; 0230E9DC
	ldr r2,[pool_0230EA58]	; 0230E9DE
	ldr r3,[r3,r2]	; 0230E9E0
	strh r1,[r3,#0x4]	; 0230E9E2
	ldr r0,[r0,#0x0]	; 0230E9E4
	ldr r0,[r0,r2]	; 0230E9E6
	strh r1,[r0,#0x6]	; 0230E9E8
	b loc_0230EA00	; 0230E9EA
loc_0230E9EC:
	mov r0,#0xc	; 0230E9EC
	ldr r1,[pool_0230EA54]	; 0230E9EE
	ldr r3,[r1,#0x0]	; 0230E9F0
	ldr r2,[pool_0230EA58]	; 0230E9F2
	ldr r3,[r3,r2]	; 0230E9F4
	strh r0,[r3,#0x4]	; 0230E9F6
	ldrh r0,[r4,#0x4]	; 0230E9F8
	ldr r1,[r1,#0x0]	; 0230E9FA
	ldr r1,[r1,r2]	; 0230E9FC
	strh r0,[r1,#0x6]	; 0230E9FE
loc_0230EA00:
	mov r2,#0x35	; 0230EA00
	ldr r0,[pool_0230EA54]	; 0230EA02
	ldr r1,[r0,#0x0]	; 0230EA04
	ldr r0,[pool_0230EA50]	; 0230EA06
	strh r2,[r1,r0]	; 0230EA08
	mov r0,#0x2	; 0230EA0A
	add r1,r0,#0x0	; 0230EA0C
	bl loc_02304B68	; 0230EA0E
	b loc_0230EA26	; 0230EA12
loc_0230EA14:
	ldr r0,[pool_0230EA54]	; 0230EA14
	ldr r1,[r0,#0x0]	; 0230EA16
	ldr r0,[pool_0230EA5C]	; 0230EA18
	ldrh r0,[r1,r0]	; 0230EA1A
	cmp r0,#0x1	; 0230EA1C
	bne loc_0230EA26	; 0230EA1E
	mov r7,#0xd	; 0230EA20
	mov r0,#0x1	; 0230EA22
	str r0,[sp,#0x0]	; 0230EA24
loc_0230EA26:
	ldr r0,[sp,#0x0]	; 0230EA26
	cmp r0,#0x0	; 0230EA28
	beq loc_0230EA48	; 0230EA2A
	add r5,#0x1e	; 0230EA2C
	add r0,r5,#0x0	; 0230EA2E
	mov r1,#0x0	; 0230EA30
	bl loc_0230C0D0	; 0230EA32
	cmp r0,#0x0	; 0230EA36
	beq loc_0230EA48	; 0230EA38
	ldrh r1,[r4,#0x0]	; 0230EA3A
	strh r1,[r0,#0x2c]	; 0230EA3C
	ldr r1,[sp,#0x4]	; 0230EA3E
	strh r1,[r0,#0x2e]	; 0230EA40
	strh r7,[r0,#0x30]	; 0230EA42
	bl loc_0230CAEC	; 0230EA44
loc_0230EA48:
	add sp,#0x14	; 0230EA48
	pop {r4,r5,r6,r7}	; 0230EA4A
	pop {r3}	; 0230EA4C
	bx r3	; 0230EA4E
pool_0230EA50:
loc_0230EA50:
	.word 0x000003BC	; 0230EA50
pool_0230EA54:
loc_0230EA54:
	.word FirmwareWlWorkPointerSlot	; 0230EA54
pool_0230EA58:
loc_0230EA58:
	.word 0x000003D8	; 0230EA58
pool_0230EA5C:
loc_0230EA5C:
	.word 0x00000314	; 0230EA5C

; ===== function loc_0230EA60 =====
loc_0230EA60:
	bx pc	; 0230EA60
	.byte 0xC0, 0x46	; 0230EA64
.arm

; ===== function loc_0230EA64 =====
loc_0230EA64:
	ldr pc,[pool_0230EA68]	; 0230EA64
pool_0230EA68:
loc_0230EA68:
	.word P2_Entry_037FCE1C	; 0230EA68
.thumb

; ===== function loc_0230EA6C =====
loc_0230EA6C:
	push {r4,r5,r6,r7,lr}	; 0230EA6C
	sub sp,#0x44	; 0230EA6E
	add r6,r0,#0x0	; 0230EA70
	add r5,r1,#0x0	; 0230EA72
	ldr r0,[pool_0230ECA0]	; 0230EA74
	ldr r1,[r0,#0x0]	; 0230EA76
	ldr r0,[pool_0230ECA4]	; 0230EA78
	add r4,r1,r0	; 0230EA7A
	ldrh r0,[r4,#0x0]	; 0230EA7C
	cmp r0,#0x13	; 0230EA7E
	beq loc_0230EA84	; 0230EA80
	b loc_0230EC98	; 0230EA82
loc_0230EA84:
	ldr r0,[pool_0230ECA8]	; 0230EA84
	ldr r7,[r1,r0]	; 0230EA86
	add r0,r6,#0x0	; 0230EA88
	str r0,[sp,#0x0]	; 0230EA8A
	add r0,#0x2c	; 0230EA8C
	str r0,[sp,#0x0]	; 0230EA8E
	ldr r2,[r4,#0x18]	; 0230EA90
	add r0,r2,#0x0	; 0230EA92
	add r0,#0x4e	; 0230EA94
	mov r1,#0x0	; 0230EA96
	add r2,#0x4c	; 0230EA98
	ldrh r2,[r2,#0x0]	; 0230EA9A
	str r2,[sp,#0x8]	; 0230EA9C
	b loc_0230EACC	; 0230EA9E
loc_0230EAA0:
	ldrh r3,[r0,#0x4]	; 0230EAA0
	ldrh r2,[r6,#0x28]	; 0230EAA2
	cmp r3,r2	; 0230EAA4
	bne loc_0230EAC8	; 0230EAA6
	ldrh r3,[r0,#0x2]	; 0230EAA8
	ldrh r2,[r6,#0x26]	; 0230EAAA
	cmp r3,r2	; 0230EAAC
	bne loc_0230EAC8	; 0230EAAE
	ldrh r3,[r0,#0x0]	; 0230EAB0
	ldrh r2,[r6,#0x24]	; 0230EAB2
	cmp r3,r2	; 0230EAB4
	bne loc_0230EAC8	; 0230EAB6
	ldr r0,[r4,#0x1c]	; 0230EAB8
	add r3,r0,#0x6	; 0230EABA
	ldrh r2,[r3,#0x0]	; 0230EABC
	mov r0,#0x1	; 0230EABE
	lsl r0,r1	; 0230EAC0
	orr r2,r0	; 0230EAC2
	strh r2,[r3,#0x0]	; 0230EAC4
	b loc_0230EC98	; 0230EAC6
loc_0230EAC8:
	add r0,r0,#0x6	; 0230EAC8
	add r1,r1,#0x1	; 0230EACA
loc_0230EACC:
	ldr r2,[sp,#0x8]	; 0230EACC
	cmp r1,r2	; 0230EACE
	bcc loc_0230EAA0	; 0230EAD0
	add r4,r7,#0x0	; 0230EAD2
	add r4,#0xa	; 0230EAD4
	mov r0,#0x0	; 0230EAD6
	ldrh r3,[r7,#0x8]	; 0230EAD8
	b loc_0230EAFE	; 0230EADA
loc_0230EADC:
	ldrh r2,[r6,#0x28]	; 0230EADC
	ldrh r1,[r4,#0x8]	; 0230EADE
	cmp r2,r1	; 0230EAE0
	bne loc_0230EAF6	; 0230EAE2
	ldrh r2,[r6,#0x26]	; 0230EAE4
	ldrh r1,[r4,#0x6]	; 0230EAE6
	cmp r2,r1	; 0230EAE8
	bne loc_0230EAF6	; 0230EAEA
	ldrh r2,[r6,#0x24]	; 0230EAEC
	ldrh r1,[r4,#0x4]	; 0230EAEE
	cmp r2,r1	; 0230EAF0
	bne loc_0230EAF6	; 0230EAF2
	b loc_0230EC98	; 0230EAF4
loc_0230EAF6:
	ldrh r1,[r4,#0x0]	; 0230EAF6
	lsl r1,r1,#0x1	; 0230EAF8
	add r4,r4,r1	; 0230EAFA
	add r0,r0,#0x1	; 0230EAFC
loc_0230EAFE:
	cmp r0,r3	; 0230EAFE
	bcc loc_0230EADC	; 0230EB00
	mov r1,#0x0	; 0230EB02
	add r0,sp,#0x14	; 0230EB04
	strh r1,[r0,#0x0]	; 0230EB06
	ldrh r0,[r0,#0x0]	; 0230EB08
	add r1,r4,#0x0	; 0230EB0A
	mov r2,#0x44	; 0230EB0C
	bl loc_0230ECB4	; 0230EB0E
	ldrh r0,[r6,#0x6]	; 0230EB12
	str r0,[sp,#0x4]	; 0230EB14
	cmp r0,#0xc	; 0230EB16
	bhi loc_0230EB1C	; 0230EB18
	b loc_0230EC98	; 0230EB1A
loc_0230EB1C:
	cmp r5,#0x0	; 0230EB1C
	bne loc_0230EB58	; 0230EB1E
	mov r0,#0x0	; 0230EB20
	str r0,[sp,#0x18]	; 0230EB22
	ldr r0,[sp,#0x18]	; 0230EB24
	add r1,sp,#0x1c	; 0230EB26
	mov r2,#0x28	; 0230EB28
	bl loc_0230ECC0	; 0230EB2A
	ldr r0,[sp,#0x0]	; 0230EB2E
	add r0,#0xc	; 0230EB30
	str r0,[sp,#0x1c]	; 0230EB32
	ldr r0,[sp,#0x4]	; 0230EB34
	sub r0,#0xc	; 0230EB36
	str r0,[sp,#0x4]	; 0230EB38
	add r1,sp,#0x14	; 0230EB3A
	strh r0,[r1,#0x10]	; 0230EB3C
	mov r0,#0x3	; 0230EB3E
	strh r0,[r1,#0x12]	; 0230EB40
	mov r0,#0x38	; 0230EB42
	strh r0,[r1,#0x14]	; 0230EB44
	ldrh r0,[r6,#0x8]	; 0230EB46
	strh r0,[r1,#0xc]	; 0230EB48
	ldr r0,[sp,#0x0]	; 0230EB4A
	ldrh r0,[r0,#0xa]	; 0230EB4C
	strh r0,[r1,#0xe]	; 0230EB4E
	add r0,sp,#0x1c	; 0230EB50
	bl loc_0230E278	; 0230EB52
	add r5,sp,#0x1c	; 0230EB56
loc_0230EB58:
	ldr r0,[r5,#0x24]	; 0230EB58
	cmp r0,#0x0	; 0230EB5A
	beq loc_0230EB68	; 0230EB5C
	add r0,r0,#0x1	; 0230EB5E
	bl loc_023053B4	; 0230EB60
	sub r0,#0x8	; 0230EB64
	strh r0,[r4,#0x3c]	; 0230EB66
loc_0230EB68:
	ldrh r1,[r5,#0xa]	; 0230EB68
	mov r0,#0x1	; 0230EB6A
	and r1,r0	; 0230EB6C
	cmp r1,#0x1	; 0230EB6E
	beq loc_0230EB74	; 0230EB70
	b loc_0230EC90	; 0230EB72
loc_0230EB74:
	ldr r0,[pool_0230ECA0]	; 0230EB74
	ldr r1,[r0,#0x0]	; 0230EB76
	ldr r0,[pool_0230ECAC]	; 0230EB78
	ldrh r1,[r1,r0]	; 0230EB7A
	ldrh r0,[r4,#0x3c]	; 0230EB7C
	add r0,#0x41	; 0230EB7E
	lsr r0,r0,#0x1	; 0230EB80
	cmp r1,r0	; 0230EB82
	bcs loc_0230EB88	; 0230EB84
	b loc_0230EC90	; 0230EB86
loc_0230EB88:
	ldr r0,[sp,#0x0]	; 0230EB88
	ldrh r0,[r0,#0xa]	; 0230EB8A
	strh r0,[r4,#0x2c]	; 0230EB8C
	add r0,r4,#0x4	; 0230EB8E
	add r1,r6,#0x0	; 0230EB90
	add r1,#0x24	; 0230EB92
	bl loc_02306458	; 0230EB94
	ldr r0,[sp,#0x0]	; 0230EB98
	ldrh r0,[r0,#0x8]	; 0230EB9A
	strh r0,[r4,#0x32]	; 0230EB9C
	ldrh r1,[r6,#0x12]	; 0230EB9E
	mov r0,#0xff	; 0230EBA0
	and r1,r0	; 0230EBA2
	strh r1,[r4,#0x2]	; 0230EBA4
	ldr r0,[r5,#0x24]	; 0230EBA6
	cmp r0,#0x0	; 0230EBA8
	beq loc_0230EBCE	; 0230EBAA
	mov r6,#0x0	; 0230EBAC
	b loc_0230EBC8	; 0230EBAE
loc_0230EBB0:
	ldr r0,[r5,#0x24]	; 0230EBB0
	add r0,#0xa	; 0230EBB2
	add r0,r0,r6	; 0230EBB4
	bl loc_023053B4	; 0230EBB6
	add r1,r0,#0x0	; 0230EBBA
	add r0,r4,#0x0	; 0230EBBC
	add r0,#0x40	; 0230EBBE
	add r0,r0,r6	; 0230EBC0
	bl loc_023053D8	; 0230EBC2
	add r6,r6,#0x1	; 0230EBC6
loc_0230EBC8:
	ldrh r0,[r4,#0x3c]	; 0230EBC8
	cmp r6,r0	; 0230EBCA
	bcc loc_0230EBB0	; 0230EBCC
loc_0230EBCE:
	ldr r0,[r5,#0x18]	; 0230EBCE
	cmp r0,#0x0	; 0230EBD0
	beq loc_0230EC00	; 0230EBD2
	add r0,r0,#0x1	; 0230EBD4
	bl loc_023053B4	; 0230EBD6
	strh r0,[r4,#0xa]	; 0230EBDA
	mov r6,#0x0	; 0230EBDC
	b loc_0230EBF8	; 0230EBDE
loc_0230EBE0:
	ldr r0,[r5,#0x18]	; 0230EBE0
	add r0,r0,#0x2	; 0230EBE2
	add r0,r0,r6	; 0230EBE4
	bl loc_023053B4	; 0230EBE6
	add r1,r0,#0x0	; 0230EBEA
	add r0,r4,#0x0	; 0230EBEC
	add r0,#0xc	; 0230EBEE
	add r0,r0,r6	; 0230EBF0
	bl loc_023053D8	; 0230EBF2
	add r6,r6,#0x1	; 0230EBF6
loc_0230EBF8:
	ldrh r0,[r4,#0xa]	; 0230EBF8
	cmp r6,r0	; 0230EBFA
	bcc loc_0230EBE0	; 0230EBFC
	b loc_0230EC1E	; 0230EBFE
loc_0230EC00:
	mov r6,#0x0	; 0230EC00
	strh r6,[r4,#0xa]	; 0230EC02
	add r0,r4,#0x0	; 0230EC04
	str r0,[sp,#0xc]	; 0230EC06
	add r0,#0xc	; 0230EC08
	str r0,[sp,#0xc]	; 0230EC0A
	str r6,[sp,#0x10]	; 0230EC0C
loc_0230EC0E:
	ldr r0,[sp,#0xc]	; 0230EC0E
	add r0,r0,r6	; 0230EC10
	ldr r1,[sp,#0x10]	; 0230EC12
	bl loc_023053D8	; 0230EC14
	add r6,r6,#0x1	; 0230EC18
	cmp r6,#0x20	; 0230EC1A
	bcc loc_0230EC0E	; 0230EC1C
loc_0230EC1E:
	ldrh r0,[r5,#0x14]	; 0230EC1E
	strh r0,[r4,#0x2e]	; 0230EC20
	ldrh r0,[r5,#0x16]	; 0230EC22
	strh r0,[r4,#0x30]	; 0230EC24
	ldrh r0,[r5,#0x12]	; 0230EC26
	strh r0,[r4,#0x36]	; 0230EC28
	ldr r0,[r5,#0x1c]	; 0230EC2A
	cmp r0,#0x0	; 0230EC2C
	beq loc_0230EC38	; 0230EC2E
	add r0,r0,#0x3	; 0230EC30
	bl loc_023053B4	; 0230EC32
	strh r0,[r4,#0x38]	; 0230EC36
loc_0230EC38:
	ldr r0,[r5,#0x20]	; 0230EC38
	cmp r0,#0x0	; 0230EC3A
	beq loc_0230EC46	; 0230EC3C
	add r0,r0,#0x3	; 0230EC3E
	bl loc_023053B4	; 0230EC40
	strh r0,[r4,#0x34]	; 0230EC44
loc_0230EC46:
	ldrh r0,[r4,#0x3c]	; 0230EC46
	add r0,#0x41	; 0230EC48
	lsr r0,r0,#0x1	; 0230EC4A
	strh r0,[r4,#0x0]	; 0230EC4C
	add r2,r7,#0x2	; 0230EC4E
	ldrh r1,[r2,#0x0]	; 0230EC50
	ldrh r0,[r4,#0x0]	; 0230EC52
	add r0,r1,r0	; 0230EC54
	strh r0,[r2,#0x0]	; 0230EC56
	add r7,#0x8	; 0230EC58
	ldrh r0,[r7,#0x0]	; 0230EC5A
	add r0,r0,#0x1	; 0230EC5C
	strh r0,[r7,#0x0]	; 0230EC5E
	ldr r3,[pool_0230ECA0]	; 0230EC60
	ldr r1,[r3,#0x0]	; 0230EC62
	ldr r0,[pool_0230ECAC]	; 0230EC64
	add r5,r1,r0	; 0230EC66
	ldrh r2,[r5,#0x0]	; 0230EC68
	ldrh r1,[r4,#0x0]	; 0230EC6A
	sub r1,r2,r1	; 0230EC6C
	strh r1,[r5,#0x0]	; 0230EC6E
	ldr r1,[r3,#0x0]	; 0230EC70
	ldrh r0,[r1,r0]	; 0230EC72
	cmp r0,#0x20	; 0230EC74
	bcs loc_0230EC98	; 0230EC76
	bl loc_0230558C	; 0230EC78
	mov r2,#0x15	; 0230EC7C
	ldr r0,[pool_0230ECA0]	; 0230EC7E
	ldr r1,[r0,#0x0]	; 0230EC80
	ldr r0,[pool_0230ECA4]	; 0230EC82
	strh r2,[r1,r0]	; 0230EC84
	mov r0,#0x2	; 0230EC86
	mov r1,#0x0	; 0230EC88
	bl loc_02304B68	; 0230EC8A
	b loc_0230EC98	; 0230EC8E
loc_0230EC90:
	add r0,r4,#0x4	; 0230EC90
	ldr r1,[pool_0230ECB0]	; 0230EC92
	bl loc_02306458	; 0230EC94
loc_0230EC98:
	add sp,#0x44	; 0230EC98
	pop {r4,r5,r6,r7}	; 0230EC9A
	pop {r3}	; 0230EC9C
	bx r3	; 0230EC9E
pool_0230ECA0:
loc_0230ECA0:
	.word FirmwareWlWorkPointerSlot	; 0230ECA0
pool_0230ECA4:
loc_0230ECA4:
	.word 0x000003BC	; 0230ECA4
pool_0230ECA8:
loc_0230ECA8:
	.word 0x000003D8	; 0230ECA8
pool_0230ECAC:
loc_0230ECAC:
	.word 0x000003C0	; 0230ECAC
pool_0230ECB0:
loc_0230ECB0:
	.word 0x02310388	; 0230ECB0

; ===== function loc_0230ECB4 =====
loc_0230ECB4:
	bx pc	; 0230ECB4
	.byte 0xC0, 0x46	; 0230ECB8
.arm

; ===== function loc_0230ECB8 =====
loc_0230ECB8:
	ldr pc,[pool_0230ECBC]	; 0230ECB8
pool_0230ECBC:
loc_0230ECBC:
	.word loc_037FCE04	; 0230ECBC
.thumb

; ===== function loc_0230ECC0 =====
loc_0230ECC0:
	bx pc	; 0230ECC0
	.byte 0xC0, 0x46	; 0230ECC4
.arm

; ===== function loc_0230ECC4 =====
loc_0230ECC4:
	ldr pc,[pool_0230ECC8]	; 0230ECC4
pool_0230ECC8:
loc_0230ECC8:
	.word loc_037FCE38	; 0230ECC8
.thumb

; ===== function loc_0230ECCC =====
loc_0230ECCC:
	push {r4,lr}	; 0230ECCC
	sub sp,#0x30	; 0230ECCE
	add r4,r0,#0x0	; 0230ECD0
	ldrh r1,[r4,#0x24]	; 0230ECD2
	mov r0,#0x1	; 0230ECD4
	and r1,r0	; 0230ECD6
	cmp r1,#0x0	; 0230ECD8
	bne loc_0230ECE6	; 0230ECDA
	ldrh r1,[r4,#0x8]	; 0230ECDC
	ldr r0,[pool_0230ED40]	; 0230ECDE
	and r1,r0	; 0230ECE0
	cmp r1,#0x0	; 0230ECE2
	beq loc_0230ED36	; 0230ECE4
loc_0230ECE6:
	mov r0,#0x0	; 0230ECE6
	str r0,[sp,#0x0]	; 0230ECE8
	ldr r0,[sp,#0x0]	; 0230ECEA
	add r1,sp,#0x4	; 0230ECEC
	mov r2,#0x28	; 0230ECEE
	bl loc_0230ED50	; 0230ECF0
	add r0,r4,#0x0	; 0230ECF4
	add r0,#0x2c	; 0230ECF6
	str r0,[sp,#0x4]	; 0230ECF8
	ldrh r0,[r4,#0x6]	; 0230ECFA
	add r1,sp,#0x0	; 0230ECFC
	strh r0,[r1,#0xc]	; 0230ECFE
	ldr r0,[pool_0230ED44]	; 0230ED00
	ldr r2,[r0,#0x0]	; 0230ED02
	ldr r0,[pool_0230ED48]	; 0230ED04
	ldrh r0,[r2,r0]	; 0230ED06
	lsl r0,r0,#0x1e	; 0230ED08
	lsr r0,r0,#0x1f	; 0230ED0A
	cmp r0,#0x0	; 0230ED0C
	bne loc_0230ED14	; 0230ED0E
	ldr r0,[pool_0230ED4C]	; 0230ED10
	strh r0,[r1,#0x10]	; 0230ED12
loc_0230ED14:
	add r0,sp,#0x4	; 0230ED14
	bl loc_0230E278	; 0230ED16
	add r0,sp,#0x0	; 0230ED1A
	ldrh r1,[r0,#0xe]	; 0230ED1C
	mov r0,#0x1	; 0230ED1E
	and r1,r0	; 0230ED20
	cmp r1,#0x1	; 0230ED22
	bne loc_0230ED36	; 0230ED24
	add r4,#0x1e	; 0230ED26
	add r0,r4,#0x0	; 0230ED28
	bl loc_0230C16C	; 0230ED2A
	cmp r0,#0x0	; 0230ED2E
	beq loc_0230ED36	; 0230ED30
	bl loc_0230CAEC	; 0230ED32
loc_0230ED36:
	add sp,#0x30	; 0230ED36
	pop {r4}	; 0230ED38
	pop {r3}	; 0230ED3A
	bx r3	; 0230ED3C
	.byte 0xC0, 0x46	; 0230ED40
pool_0230ED40:
loc_0230ED40:
	.word 0x00008000	; 0230ED40
pool_0230ED44:
loc_0230ED44:
	.word FirmwareWlWorkPointerSlot	; 0230ED44
pool_0230ED48:
loc_0230ED48:
	.word 0x000002FE	; 0230ED48
pool_0230ED4C:
loc_0230ED4C:
	.word 0x00000800	; 0230ED4C

; ===== function loc_0230ED50 =====
loc_0230ED50:
	bx pc	; 0230ED50
	.byte 0xC0, 0x46	; 0230ED54
.arm

; ===== function loc_0230ED54 =====
loc_0230ED54:
	ldr pc,[pool_0230ED58]	; 0230ED54
pool_0230ED58:
loc_0230ED58:
	.word loc_037FCE38	; 0230ED58
.thumb

; ===== function loc_0230ED5C =====
loc_0230ED5C:
	push {r4,r5,lr}	; 0230ED5C
	sub sp,#0x4	; 0230ED5E
	add r5,r0,#0x0	; 0230ED60
	add r4,r5,#0x0	; 0230ED62
	add r4,#0x2c	; 0230ED64
	ldr r0,[pool_0230EE58]	; 0230ED66
	ldr r0,[r0,#0x0]	; 0230ED68
	ldr r1,[pool_0230EE5C]	; 0230ED6A
	ldrh r1,[r0,r1]	; 0230ED6C
	cmp r1,#0x2	; 0230ED6E
	beq loc_0230ED76	; 0230ED70
	cmp r1,#0x3	; 0230ED72
	bne loc_0230EE4E	; 0230ED74
loc_0230ED76:
	ldr r1,[pool_0230EE60]	; 0230ED76
	ldrh r1,[r0,r1]	; 0230ED78
	cmp r1,#0x61	; 0230ED7A
	bne loc_0230EE4E	; 0230ED7C
	ldr r1,[pool_0230EE64]	; 0230ED7E
	ldr r2,[r0,r1]	; 0230ED80
	ldrh r1,[r2,#0x14]	; 0230ED82
	ldrh r0,[r5,#0x22]	; 0230ED84
	cmp r1,r0	; 0230ED86
	bne loc_0230EE4E	; 0230ED88
	ldrh r1,[r2,#0x12]	; 0230ED8A
	ldrh r0,[r5,#0x20]	; 0230ED8C
	cmp r1,r0	; 0230ED8E
	bne loc_0230EE4E	; 0230ED90
	ldrh r1,[r2,#0x10]	; 0230ED92
	ldrh r0,[r5,#0x1e]	; 0230ED94
	cmp r1,r0	; 0230ED96
	bne loc_0230EE4E	; 0230ED98
	bl loc_0230558C	; 0230ED9A
	ldrh r0,[r4,#0x2]	; 0230ED9E
	cmp r0,#0x0	; 0230EDA0
	bne loc_0230EDFC	; 0230EDA2
	ldrh r1,[r4,#0x4]	; 0230EDA4
	ldr r0,[pool_0230EE68]	; 0230EDA6
	and r1,r0	; 0230EDA8
	lsl r0,r1,#0x10	; 0230EDAA
	lsr r0,r0,#0x10	; 0230EDAC
	bl loc_0230655C	; 0230EDAE
	ldr r0,[pool_0230EE58]	; 0230EDB2
	ldr r1,[r0,#0x0]	; 0230EDB4
	ldr r0,[pool_0230EE6C]	; 0230EDB6
	ldrh r0,[r1,r0]	; 0230EDB8
	bl loc_0230C010	; 0230EDBA
	ldr r0,[pool_0230EE58]	; 0230EDBE
	ldr r1,[r0,#0x0]	; 0230EDC0
	ldr r0,[pool_0230EE70]	; 0230EDC2
	add r0,r1,r0	; 0230EDC4
	add r1,r5,#0x0	; 0230EDC6
	add r1,#0x1e	; 0230EDC8
	bl loc_02306458	; 0230EDCA
	add r5,#0x1e	; 0230EDCE
	add r0,r5,#0x0	; 0230EDD0
	bl loc_0230949C	; 0230EDD2
	ldr r3,[pool_0230EE58]	; 0230EDD6
	ldr r2,[r3,#0x0]	; 0230EDD8
	ldr r1,[pool_0230EE74]	; 0230EDDA
	strh r0,[r2,r1]	; 0230EDDC
	ldr r0,[r3,#0x0]	; 0230EDDE
	ldrh r0,[r0,r1]	; 0230EDE0
	mov r1,#0x40	; 0230EDE2
	bl loc_023091EC	; 0230EDE4
	ldr r0,[pool_0230EE58]	; 0230EDE8
	ldr r1,[r0,#0x0]	; 0230EDEA
	ldr r0,[pool_0230EE74]	; 0230EDEC
	ldrh r0,[r1,r0]	; 0230EDEE
	mov r1,#0x40	; 0230EDF0
	bl loc_023091EC	; 0230EDF2
	mov r0,#0x40	; 0230EDF6
	bl loc_02306468	; 0230EDF8
loc_0230EDFC:
	ldrh r0,[r4,#0x2]	; 0230EDFC
	cmp r0,#0x0	; 0230EDFE
	bne loc_0230EE1C	; 0230EE00
	mov r3,#0x0	; 0230EE02
	ldr r2,[pool_0230EE58]	; 0230EE04
	ldr r1,[r2,#0x0]	; 0230EE06
	ldr r0,[pool_0230EE78]	; 0230EE08
	ldr r1,[r1,r0]	; 0230EE0A
	strh r3,[r1,#0x4]	; 0230EE0C
	ldr r1,[r2,#0x0]	; 0230EE0E
	ldr r0,[r1,r0]	; 0230EE10
	strh r3,[r0,#0x6]	; 0230EE12
	mov r0,#0x40	; 0230EE14
	bl loc_02306468	; 0230EE16
	b loc_0230EE30	; 0230EE1A
loc_0230EE1C:
	mov r2,#0xc	; 0230EE1C
	ldr r3,[pool_0230EE58]	; 0230EE1E
	ldr r1,[r3,#0x0]	; 0230EE20
	ldr r0,[pool_0230EE78]	; 0230EE22
	ldr r1,[r1,r0]	; 0230EE24
	strh r2,[r1,#0x4]	; 0230EE26
	ldrh r2,[r4,#0x2]	; 0230EE28
	ldr r1,[r3,#0x0]	; 0230EE2A
	ldr r0,[r1,r0]	; 0230EE2C
	strh r2,[r0,#0x6]	; 0230EE2E
loc_0230EE30:
	ldr r3,[pool_0230EE58]	; 0230EE30
	ldr r2,[r3,#0x0]	; 0230EE32
	ldr r0,[pool_0230EE6C]	; 0230EE34
	ldrh r1,[r2,r0]	; 0230EE36
	ldr r0,[pool_0230EE78]	; 0230EE38
	ldr r0,[r2,r0]	; 0230EE3A
	strh r1,[r0,#0x8]	; 0230EE3C
	mov r2,#0x63	; 0230EE3E
	ldr r1,[r3,#0x0]	; 0230EE40
	ldr r0,[pool_0230EE60]	; 0230EE42
	strh r2,[r1,r0]	; 0230EE44
	mov r0,#0x2	; 0230EE46
	mov r1,#0x4	; 0230EE48
	bl loc_02304B68	; 0230EE4A
loc_0230EE4E:
	add sp,#0x4	; 0230EE4E
	pop {r4,r5}	; 0230EE50
	pop {r3}	; 0230EE52
	bx r3	; 0230EE54
	.byte 0xC0, 0x46	; 0230EE58
pool_0230EE58:
loc_0230EE58:
	.word FirmwareWlWorkPointerSlot	; 0230EE58
pool_0230EE5C:
loc_0230EE5C:
	.word 0x00000314	; 0230EE5C
pool_0230EE60:
loc_0230EE60:
	.word 0x000003BC	; 0230EE60
pool_0230EE64:
loc_0230EE64:
	.word 0x000003D4	; 0230EE64
pool_0230EE68:
loc_0230EE68:
	.word 0x00000FFF	; 0230EE68
pool_0230EE6C:
loc_0230EE6C:
	.word 0x00000366	; 0230EE6C
pool_0230EE70:
loc_0230EE70:
	.word 0x0000037E	; 0230EE70
pool_0230EE74:
loc_0230EE74:
	.word 0x00000384	; 0230EE74
pool_0230EE78:
loc_0230EE78:
	.word 0x000003D8	; 0230EE78

; ===== function loc_0230EE7C =====
loc_0230EE7C:
	push {r4,r5,r6,r7,lr}	; 0230EE7C
	sub sp,#0x34	; 0230EE7E
	add r7,r0,#0x0	; 0230EE80
	ldrh r6,[r7,#0x6]	; 0230EE82
	add r5,r7,#0x0	; 0230EE84
	add r5,#0x2c	; 0230EE86
	cmp r6,#0xa	; 0230EE88
	bls loc_0230EF6C	; 0230EE8A
	ldr r0,[pool_0230EF74]	; 0230EE8C
	ldr r0,[r0,#0x0]	; 0230EE8E
	ldr r1,[pool_0230EF78]	; 0230EE90
	ldrh r1,[r0,r1]	; 0230EE92
	cmp r1,#0x1	; 0230EE94
	bne loc_0230EF6C	; 0230EE96
	ldrh r1,[r7,#0x2]	; 0230EE98
	str r1,[sp,#0x0]	; 0230EE9A
	mov r1,#0x1c	; 0230EE9C
	ldr r4,[sp,#0x0]	; 0230EE9E
	mul r4,r1	; 0230EEA0
	ldr r1,[pool_0230EF7C]	; 0230EEA2
	ldr r0,[r0,r1]	; 0230EEA4
	ldrh r0,[r0,r4]	; 0230EEA6
	cmp r0,#0x30	; 0230EEA8
	bcs loc_0230EEC0	; 0230EEAA
	add r7,#0x1e	; 0230EEAC
	add r0,r7,#0x0	; 0230EEAE
	mov r1,#0x6	; 0230EEB0
	bl loc_0230C058	; 0230EEB2
	cmp r0,#0x0	; 0230EEB6
	beq loc_0230EF6C	; 0230EEB8
	bl loc_0230CAEC	; 0230EEBA
	b loc_0230EF6C	; 0230EEBE
loc_0230EEC0:
	cmp r0,#0x40	; 0230EEC0
	bne loc_0230EED6	; 0230EEC2
	ldr r0,[sp,#0x0]	; 0230EEC4
	mov r1,#0x30	; 0230EEC6
	bl loc_023091EC	; 0230EEC8
	add r7,#0x1e	; 0230EECC
	add r0,r7,#0x0	; 0230EECE
	mov r1,#0x1	; 0230EED0
	bl loc_023099D0	; 0230EED2
loc_0230EED6:
	mov r0,#0x0	; 0230EED6
	str r0,[sp,#0x4]	; 0230EED8
	ldr r0,[sp,#0x4]	; 0230EEDA
	add r1,sp,#0x8	; 0230EEDC
	mov r2,#0x28	; 0230EEDE
	bl loc_0230EF8C	; 0230EEE0
	add r0,r5,#0x0	; 0230EEE4
	add r0,#0xa	; 0230EEE6
	str r0,[sp,#0x8]	; 0230EEE8
	sub r6,#0xa	; 0230EEEA
	add r0,sp,#0x4	; 0230EEEC
	strh r6,[r0,#0xc]	; 0230EEEE
	ldr r1,[pool_0230EF80]	; 0230EEF0
	strh r1,[r0,#0x10]	; 0230EEF2
	add r0,sp,#0x8	; 0230EEF4
	bl loc_0230E278	; 0230EEF6
	ldrh r0,[r5,#0x0]	; 0230EEFA
	ldr r1,[pool_0230EF84]	; 0230EEFC
	add r2,r0,#0x0	; 0230EEFE
	and r2,r1	; 0230EF00
	cmp r2,#0x0	; 0230EF02
	bne loc_0230EF28	; 0230EF04
	ldr r1,[pool_0230EF74]	; 0230EF06
	ldr r1,[r1,#0x0]	; 0230EF08
	ldr r2,[pool_0230EF88]	; 0230EF0A
	ldrh r3,[r1,r2]	; 0230EF0C
	cmp r3,#0x0	; 0230EF0E
	bne loc_0230EF1A	; 0230EF10
	lsl r2,r0,#0x1b	; 0230EF12
	lsr r2,r2,#0x1f	; 0230EF14
	cmp r2,#0x1	; 0230EF16
	beq loc_0230EF28	; 0230EF18
loc_0230EF1A:
	cmp r3,#0x0	; 0230EF1A
	beq loc_0230EF2C	; 0230EF1C
	ldrh r2,[r5,#0x0]	; 0230EF1E
	lsl r2,r2,#0x1b	; 0230EF20
	lsr r2,r2,#0x1f	; 0230EF22
	cmp r2,#0x0	; 0230EF24
	bne loc_0230EF2C	; 0230EF26
loc_0230EF28:
	mov r1,#0xa	; 0230EF28
	b loc_0230EF5C	; 0230EF2A
loc_0230EF2C:
	ldr r2,[pool_0230EF7C]	; 0230EF2C
	ldr r1,[r1,r2]	; 0230EF2E
	add r1,r1,r4	; 0230EF30
	strh r0,[r1,#0xc]	; 0230EF32
	add r3,sp,#0x4	; 0230EF34
	ldrh r5,[r3,#0xe]	; 0230EF36
	mov r1,#0x1	; 0230EF38
	add r0,r5,#0x0	; 0230EF3A
	and r0,r1	; 0230EF3C
	cmp r0,#0x0	; 0230EF3E
	beq loc_0230EF5C	; 0230EF40
	mov r0,#0x4	; 0230EF42
	and r5,r0	; 0230EF44
	cmp r5,#0x0	; 0230EF46
	bne loc_0230EF4E	; 0230EF48
	mov r1,#0x12	; 0230EF4A
	b loc_0230EF5C	; 0230EF4C
loc_0230EF4E:
	ldrh r1,[r3,#0x1a]	; 0230EF4E
	ldr r0,[pool_0230EF74]	; 0230EF50
	ldr r0,[r0,#0x0]	; 0230EF52
	ldr r0,[r0,r2]	; 0230EF54
	add r0,r0,r4	; 0230EF56
	strh r1,[r0,#0x10]	; 0230EF58
	mov r1,#0x0	; 0230EF5A
loc_0230EF5C:
	ldr r0,[sp,#0x0]	; 0230EF5C
	ldr r2,[sp,#0x20]	; 0230EF5E
	bl loc_0230C2B8	; 0230EF60
	cmp r0,#0x0	; 0230EF64
	beq loc_0230EF6C	; 0230EF66
	bl loc_0230CAEC	; 0230EF68
loc_0230EF6C:
	add sp,#0x34	; 0230EF6C
	pop {r4,r5,r6,r7}	; 0230EF6E
	pop {r3}	; 0230EF70
	bx r3	; 0230EF72
pool_0230EF74:
loc_0230EF74:
	.word FirmwareWlWorkPointerSlot	; 0230EF74
pool_0230EF78:
loc_0230EF78:
	.word 0x00000314	; 0230EF78
pool_0230EF7C:
loc_0230EF7C:
	.word 0x000002E0	; 0230EF7C
pool_0230EF80:
loc_0230EF80:
	.word 0x00000800	; 0230EF80
pool_0230EF84:
loc_0230EF84:
	.word 0x0000FFC2	; 0230EF84
pool_0230EF88:
loc_0230EF88:
	.word 0x000002F8	; 0230EF88

; ===== function loc_0230EF8C =====
loc_0230EF8C:
	bx pc	; 0230EF8C
	.byte 0xC0, 0x46	; 0230EF90
.arm

; ===== function loc_0230EF90 =====
loc_0230EF90:
	ldr pc,[pool_0230EF94]	; 0230EF90
pool_0230EF94:
loc_0230EF94:
	.word loc_037FCE38	; 0230EF94
.thumb

; ===== function loc_0230EF98 =====
loc_0230EF98:
	push {r4,r5,lr}	; 0230EF98
	sub sp,#0x4	; 0230EF9A
	add r5,r0,#0x0	; 0230EF9C
	add r4,r5,#0x0	; 0230EF9E
	add r4,#0x2c	; 0230EFA0
	ldr r0,[pool_0230F080]	; 0230EFA2
	ldr r0,[r0,#0x0]	; 0230EFA4
	ldr r1,[pool_0230F084]	; 0230EFA6
	ldrh r1,[r0,r1]	; 0230EFA8
	cmp r1,#0x2	; 0230EFAA
	beq loc_0230EFB2	; 0230EFAC
	cmp r1,#0x3	; 0230EFAE
	bne loc_0230F076	; 0230EFB0
loc_0230EFB2:
	ldr r1,[pool_0230F088]	; 0230EFB2
	ldrh r1,[r0,r1]	; 0230EFB4
	cmp r1,#0x51	; 0230EFB6
	bne loc_0230F076	; 0230EFB8
	ldr r1,[pool_0230F08C]	; 0230EFBA
	ldr r2,[r0,r1]	; 0230EFBC
	ldrh r1,[r2,#0x14]	; 0230EFBE
	ldrh r0,[r5,#0x22]	; 0230EFC0
	cmp r1,r0	; 0230EFC2
	bne loc_0230F076	; 0230EFC4
	ldrh r1,[r2,#0x12]	; 0230EFC6
	ldrh r0,[r5,#0x20]	; 0230EFC8
	cmp r1,r0	; 0230EFCA
	bne loc_0230F076	; 0230EFCC
	ldrh r1,[r2,#0x10]	; 0230EFCE
	ldrh r0,[r5,#0x1e]	; 0230EFD0
	cmp r1,r0	; 0230EFD2
	bne loc_0230F076	; 0230EFD4
	bl loc_0230558C	; 0230EFD6
	ldrh r0,[r4,#0x2]	; 0230EFDA
	cmp r0,#0x0	; 0230EFDC
	bne loc_0230F024	; 0230EFDE
	ldrh r1,[r4,#0x4]	; 0230EFE0
	ldr r0,[pool_0230F090]	; 0230EFE2
	and r1,r0	; 0230EFE4
	lsl r0,r1,#0x10	; 0230EFE6
	lsr r0,r0,#0x10	; 0230EFE8
	bl loc_0230655C	; 0230EFEA
	ldr r0,[pool_0230F080]	; 0230EFEE
	ldr r1,[r0,#0x0]	; 0230EFF0
	ldr r0,[pool_0230F094]	; 0230EFF2
	ldrh r0,[r1,r0]	; 0230EFF4
	bl loc_0230C010	; 0230EFF6
	ldr r0,[pool_0230F080]	; 0230EFFA
	ldr r1,[r0,#0x0]	; 0230EFFC
	ldr r0,[pool_0230F098]	; 0230EFFE
	add r0,r1,r0	; 0230F000
	add r1,r5,#0x0	; 0230F002
	add r1,#0x1e	; 0230F004
	bl loc_02306458	; 0230F006
	add r5,#0x1e	; 0230F00A
	add r0,r5,#0x0	; 0230F00C
	bl loc_0230949C	; 0230F00E
	ldr r3,[pool_0230F080]	; 0230F012
	ldr r2,[r3,#0x0]	; 0230F014
	ldr r1,[pool_0230F09C]	; 0230F016
	strh r0,[r2,r1]	; 0230F018
	ldr r0,[r3,#0x0]	; 0230F01A
	ldrh r0,[r0,r1]	; 0230F01C
	mov r1,#0x40	; 0230F01E
	bl loc_023091EC	; 0230F020
loc_0230F024:
	ldrh r0,[r4,#0x2]	; 0230F024
	cmp r0,#0x0	; 0230F026
	bne loc_0230F044	; 0230F028
	mov r3,#0x0	; 0230F02A
	ldr r2,[pool_0230F080]	; 0230F02C
	ldr r1,[r2,#0x0]	; 0230F02E
	ldr r0,[pool_0230F0A0]	; 0230F030
	ldr r1,[r1,r0]	; 0230F032
	strh r3,[r1,#0x4]	; 0230F034
	ldr r1,[r2,#0x0]	; 0230F036
	ldr r0,[r1,r0]	; 0230F038
	strh r3,[r0,#0x6]	; 0230F03A
	mov r0,#0x40	; 0230F03C
	bl loc_02306468	; 0230F03E
	b loc_0230F058	; 0230F042
loc_0230F044:
	mov r2,#0xc	; 0230F044
	ldr r3,[pool_0230F080]	; 0230F046
	ldr r1,[r3,#0x0]	; 0230F048
	ldr r0,[pool_0230F0A0]	; 0230F04A
	ldr r1,[r1,r0]	; 0230F04C
	strh r2,[r1,#0x4]	; 0230F04E
	ldrh r2,[r4,#0x2]	; 0230F050
	ldr r1,[r3,#0x0]	; 0230F052
	ldr r0,[r1,r0]	; 0230F054
	strh r2,[r0,#0x6]	; 0230F056
loc_0230F058:
	ldr r3,[pool_0230F080]	; 0230F058
	ldr r2,[r3,#0x0]	; 0230F05A
	ldr r0,[pool_0230F094]	; 0230F05C
	ldrh r1,[r2,r0]	; 0230F05E
	ldr r0,[pool_0230F0A0]	; 0230F060
	ldr r0,[r2,r0]	; 0230F062
	strh r1,[r0,#0x8]	; 0230F064
	mov r2,#0x53	; 0230F066
	ldr r1,[r3,#0x0]	; 0230F068
	ldr r0,[pool_0230F088]	; 0230F06A
	strh r2,[r1,r0]	; 0230F06C
	mov r0,#0x2	; 0230F06E
	mov r1,#0x3	; 0230F070
	bl loc_02304B68	; 0230F072
loc_0230F076:
	add sp,#0x4	; 0230F076
	pop {r4,r5}	; 0230F078
	pop {r3}	; 0230F07A
	bx r3	; 0230F07C
	.byte 0xC0, 0x46	; 0230F080
pool_0230F080:
loc_0230F080:
	.word FirmwareWlWorkPointerSlot	; 0230F080
pool_0230F084:
loc_0230F084:
	.word 0x00000314	; 0230F084
pool_0230F088:
loc_0230F088:
	.word 0x000003BC	; 0230F088
pool_0230F08C:
loc_0230F08C:
	.word 0x000003D4	; 0230F08C
pool_0230F090:
loc_0230F090:
	.word 0x00000FFF	; 0230F090
pool_0230F094:
loc_0230F094:
	.word 0x00000366	; 0230F094
pool_0230F098:
loc_0230F098:
	.word 0x0000037E	; 0230F098
pool_0230F09C:
loc_0230F09C:
	.word 0x00000384	; 0230F09C
pool_0230F0A0:
loc_0230F0A0:
	.word 0x000003D8	; 0230F0A0

; ===== function loc_0230F0A4 =====
loc_0230F0A4:
	push {r4,r5,r6,r7,lr}	; 0230F0A4
	sub sp,#0x34	; 0230F0A6
	add r6,r0,#0x0	; 0230F0A8
	ldrh r7,[r6,#0x6]	; 0230F0AA
	add r5,r6,#0x0	; 0230F0AC
	add r5,#0x2c	; 0230F0AE
	cmp r7,#0x4	; 0230F0B0
	bls loc_0230F1B0	; 0230F0B2
	ldr r0,[pool_0230F1B8]	; 0230F0B4
	ldr r0,[r0,#0x0]	; 0230F0B6
	ldr r1,[pool_0230F1BC]	; 0230F0B8
	ldrh r1,[r0,r1]	; 0230F0BA
	cmp r1,#0x1	; 0230F0BC
	bne loc_0230F1B0	; 0230F0BE
	ldrh r1,[r6,#0x2]	; 0230F0C0
	str r1,[sp,#0x0]	; 0230F0C2
	cmp r1,#0x0	; 0230F0C4
	beq loc_0230F0D8	; 0230F0C6
	mov r1,#0x1c	; 0230F0C8
	ldr r4,[sp,#0x0]	; 0230F0CA
	mul r4,r1	; 0230F0CC
	ldr r1,[pool_0230F1C0]	; 0230F0CE
	ldr r0,[r0,r1]	; 0230F0D0
	ldrh r0,[r0,r4]	; 0230F0D2
	cmp r0,#0x30	; 0230F0D4
	bcs loc_0230F0EC	; 0230F0D6
loc_0230F0D8:
	add r6,#0x1e	; 0230F0D8
	add r0,r6,#0x0	; 0230F0DA
	mov r1,#0x6	; 0230F0DC
	bl loc_0230C058	; 0230F0DE
	cmp r0,#0x0	; 0230F0E2
	beq loc_0230F1B0	; 0230F0E4
	bl loc_0230CAEC	; 0230F0E6
	b loc_0230F1B0	; 0230F0EA
loc_0230F0EC:
	cmp r0,#0x40	; 0230F0EC
	bne loc_0230F102	; 0230F0EE
	ldr r0,[sp,#0x0]	; 0230F0F0
	mov r1,#0x30	; 0230F0F2
	bl loc_023091EC	; 0230F0F4
	add r6,#0x1e	; 0230F0F8
	add r0,r6,#0x0	; 0230F0FA
	mov r1,#0x1	; 0230F0FC
	bl loc_023099D0	; 0230F0FE
loc_0230F102:
	mov r0,#0x0	; 0230F102
	str r0,[sp,#0x4]	; 0230F104
	ldr r0,[sp,#0x4]	; 0230F106
	add r1,sp,#0x8	; 0230F108
	mov r2,#0x28	; 0230F10A
	bl loc_0230F1D0	; 0230F10C
	add r0,r5,#0x4	; 0230F110
	str r0,[sp,#0x8]	; 0230F112
	sub r1,r7,#0x4	; 0230F114
	add r0,sp,#0x4	; 0230F116
	strh r1,[r0,#0xc]	; 0230F118
	add r0,sp,#0x8	; 0230F11A
	bl loc_0230E278	; 0230F11C
	ldrh r0,[r5,#0x0]	; 0230F120
	ldr r1,[pool_0230F1C4]	; 0230F122
	add r2,r0,#0x0	; 0230F124
	and r2,r1	; 0230F126
	cmp r2,#0x0	; 0230F128
	bne loc_0230F16C	; 0230F12A
	lsl r1,r0,#0x1f	; 0230F12C
	lsr r1,r1,#0x1f	; 0230F12E
	cmp r1,#0x0	; 0230F130
	beq loc_0230F16C	; 0230F132
	ldr r1,[pool_0230F1B8]	; 0230F134
	ldr r1,[r1,#0x0]	; 0230F136
	ldr r2,[pool_0230F1C8]	; 0230F138
	ldrh r3,[r1,r2]	; 0230F13A
	cmp r3,#0x0	; 0230F13C
	bne loc_0230F148	; 0230F13E
	lsl r2,r0,#0x1b	; 0230F140
	lsr r2,r2,#0x1f	; 0230F142
	cmp r2,#0x1	; 0230F144
	beq loc_0230F16C	; 0230F146
loc_0230F148:
	cmp r3,#0x0	; 0230F148
	beq loc_0230F156	; 0230F14A
	ldrh r2,[r5,#0x0]	; 0230F14C
	lsl r2,r2,#0x1b	; 0230F14E
	lsr r2,r2,#0x1f	; 0230F150
	cmp r2,#0x0	; 0230F152
	beq loc_0230F16C	; 0230F154
loc_0230F156:
	ldr r2,[pool_0230F1CC]	; 0230F156
	ldrh r2,[r1,r2]	; 0230F158
	lsl r2,r2,#0x1d	; 0230F15A
	lsr r2,r2,#0x1f	; 0230F15C
	cmp r2,#0x1	; 0230F15E
	bne loc_0230F170	; 0230F160
	ldrh r2,[r5,#0x0]	; 0230F162
	lsl r2,r2,#0x1a	; 0230F164
	lsr r2,r2,#0x1f	; 0230F166
	cmp r2,#0x0	; 0230F168
	bne loc_0230F170	; 0230F16A
loc_0230F16C:
	mov r1,#0xa	; 0230F16C
	b loc_0230F1A0	; 0230F16E
loc_0230F170:
	ldr r2,[pool_0230F1C0]	; 0230F170
	ldr r1,[r1,r2]	; 0230F172
	add r1,r1,r4	; 0230F174
	strh r0,[r1,#0xc]	; 0230F176
	add r3,sp,#0x4	; 0230F178
	ldrh r5,[r3,#0xe]	; 0230F17A
	mov r1,#0x1	; 0230F17C
	add r0,r5,#0x0	; 0230F17E
	and r0,r1	; 0230F180
	cmp r0,#0x0	; 0230F182
	beq loc_0230F1A0	; 0230F184
	mov r0,#0x4	; 0230F186
	and r5,r0	; 0230F188
	cmp r5,#0x0	; 0230F18A
	bne loc_0230F192	; 0230F18C
	mov r1,#0x12	; 0230F18E
	b loc_0230F1A0	; 0230F190
loc_0230F192:
	ldrh r1,[r3,#0x1a]	; 0230F192
	ldr r0,[pool_0230F1B8]	; 0230F194
	ldr r0,[r0,#0x0]	; 0230F196
	ldr r0,[r0,r2]	; 0230F198
	add r0,r0,r4	; 0230F19A
	strh r1,[r0,#0x10]	; 0230F19C
	mov r1,#0x0	; 0230F19E
loc_0230F1A0:
	ldr r0,[sp,#0x0]	; 0230F1A0
	ldr r2,[sp,#0x20]	; 0230F1A2
	bl loc_0230C3E4	; 0230F1A4
	cmp r0,#0x0	; 0230F1A8
	beq loc_0230F1B0	; 0230F1AA
	bl loc_0230CAEC	; 0230F1AC
loc_0230F1B0:
	add sp,#0x34	; 0230F1B0
	pop {r4,r5,r6,r7}	; 0230F1B2
	pop {r3}	; 0230F1B4
	bx r3	; 0230F1B6
pool_0230F1B8:
loc_0230F1B8:
	.word FirmwareWlWorkPointerSlot	; 0230F1B8
pool_0230F1BC:
loc_0230F1BC:
	.word 0x00000314	; 0230F1BC
pool_0230F1C0:
loc_0230F1C0:
	.word 0x000002E0	; 0230F1C0
pool_0230F1C4:
loc_0230F1C4:
	.word 0x0000FFC2	; 0230F1C4
pool_0230F1C8:
loc_0230F1C8:
	.word 0x000002F8	; 0230F1C8
pool_0230F1CC:
loc_0230F1CC:
	.word 0x000002FE	; 0230F1CC

; ===== function loc_0230F1D0 =====
loc_0230F1D0:
	bx pc	; 0230F1D0
	.byte 0xC0, 0x46	; 0230F1D4
.arm

; ===== function loc_0230F1D4 =====
loc_0230F1D4:
	ldr pc,[pool_0230F1D8]	; 0230F1D4
pool_0230F1D8:
loc_0230F1D8:
	.word loc_037FCE38	; 0230F1D8
.thumb

; ===== function loc_0230F1DC =====
loc_0230F1DC:
	push {r4,r5,lr}	; 0230F1DC
	sub sp,#0x4	; 0230F1DE
	add r5,r0,#0x0	; 0230F1E0
	ldrh r4,[r5,#0x2]	; 0230F1E2
	ldr r0,[pool_0230F28C]	; 0230F1E4
	ldr r0,[r0,#0x0]	; 0230F1E6
	ldr r1,[pool_0230F290]	; 0230F1E8
	ldrh r1,[r0,r1]	; 0230F1EA
	cmp r1,#0x1	; 0230F1EC
	beq loc_0230F1FA	; 0230F1EE
	cmp r1,#0x2	; 0230F1F0
	beq loc_0230F24A	; 0230F1F2
	cmp r1,#0x3	; 0230F1F4
	beq loc_0230F24A	; 0230F1F6
	b loc_0230F284	; 0230F1F8
loc_0230F1FA:
	ldr r1,[pool_0230F294]	; 0230F1FA
	ldr r2,[r0,r1]	; 0230F1FC
	mov r0,#0x1c	; 0230F1FE
	add r1,r4,#0x0	; 0230F200
	mul r1,r0	; 0230F202
	ldrh r0,[r2,r1]	; 0230F204
	cmp r0,#0x40	; 0230F206
	bne loc_0230F226	; 0230F208
	lsl r0,r4,#0x10	; 0230F20A
	lsr r0,r0,#0x10	; 0230F20C
	mov r1,#0x30	; 0230F20E
	bl loc_023091EC	; 0230F210
	add r0,r5,#0x0	; 0230F214
	add r0,#0x1e	; 0230F216
	ldrh r1,[r5,#0x2c]	; 0230F218
	bl loc_023099D0	; 0230F21A
	add r0,r4,#0x0	; 0230F21E
	bl loc_0230CC7C	; 0230F220
	b loc_0230F284	; 0230F224
loc_0230F226:
	cmp r0,#0x30	; 0230F226
	bne loc_0230F236	; 0230F228
	add r5,#0x1e	; 0230F22A
	add r0,r5,#0x0	; 0230F22C
	mov r1,#0x7	; 0230F22E
	bl loc_0230C5C0	; 0230F230
	b loc_0230F240	; 0230F234
loc_0230F236:
	add r5,#0x1e	; 0230F236
	add r0,r5,#0x0	; 0230F238
	mov r1,#0x7	; 0230F23A
	bl loc_0230C058	; 0230F23C
loc_0230F240:
	cmp r0,#0x0	; 0230F240
	beq loc_0230F284	; 0230F242
	bl loc_0230CAEC	; 0230F244
	b loc_0230F284	; 0230F248
loc_0230F24A:
	ldr r1,[pool_0230F298]	; 0230F24A
	ldrh r1,[r0,r1]	; 0230F24C
	cmp r1,#0x40	; 0230F24E
	bne loc_0230F284	; 0230F250
	ldrh r2,[r5,#0x22]	; 0230F252
	ldr r1,[pool_0230F29C]	; 0230F254
	ldrh r1,[r0,r1]	; 0230F256
	cmp r2,r1	; 0230F258
	bne loc_0230F284	; 0230F25A
	ldrh r2,[r5,#0x20]	; 0230F25C
	ldr r1,[pool_0230F2A0]	; 0230F25E
	ldrh r1,[r0,r1]	; 0230F260
	cmp r2,r1	; 0230F262
	bne loc_0230F284	; 0230F264
	ldrh r2,[r5,#0x1e]	; 0230F266
	ldr r1,[pool_0230F2A4]	; 0230F268
	ldrh r0,[r0,r1]	; 0230F26A
	cmp r2,r0	; 0230F26C
	bne loc_0230F284	; 0230F26E
	mov r0,#0x30	; 0230F270
	bl loc_02306468	; 0230F272
	bl loc_023064D4	; 0230F276
	add r0,r5,#0x0	; 0230F27A
	add r0,#0x1e	; 0230F27C
	ldrh r1,[r5,#0x2c]	; 0230F27E
	bl loc_023099D0	; 0230F280
loc_0230F284:
	add sp,#0x4	; 0230F284
	pop {r4,r5}	; 0230F286
	pop {r3}	; 0230F288
	bx r3	; 0230F28A
pool_0230F28C:
loc_0230F28C:
	.word FirmwareWlWorkPointerSlot	; 0230F28C
pool_0230F290:
loc_0230F290:
	.word 0x00000314	; 0230F290
pool_0230F294:
loc_0230F294:
	.word 0x000002E0	; 0230F294
pool_0230F298:
loc_0230F298:
	.word 0x00000310	; 0230F298
pool_0230F29C:
loc_0230F29C:
	.word 0x00000382	; 0230F29C
pool_0230F2A0:
loc_0230F2A0:
	.word 0x00000380	; 0230F2A0
pool_0230F2A4:
loc_0230F2A4:
	.word 0x0000037E	; 0230F2A4

; ===== function loc_0230F2A8 =====
loc_0230F2A8:
	push {r4,r5,r6,r7,lr}	; 0230F2A8
	sub sp,#0x4c	; 0230F2AA
	add r5,r0,#0x0	; 0230F2AC
	ldr r0,[pool_0230F638]	; 0230F2AE
	ldr r1,[r0,#0x0]	; 0230F2B0
	ldr r0,[pool_0230F63C]	; 0230F2B2
	add r1,r1,r0	; 0230F2B4
	ldr r0,[r1,#0x0]	; 0230F2B6
	add r0,r0,#0x1	; 0230F2B8
	str r0,[r1,#0x0]	; 0230F2BA
	add r0,r5,#0x0	; 0230F2BC
	add r0,#0x1e	; 0230F2BE
	bl loc_023093BC	; 0230F2C0
	add r6,r0,#0x0	; 0230F2C4
	lsl r0,r6,#0x10	; 0230F2C6
	lsr r0,r0,#0x10	; 0230F2C8
	strh r0,[r5,#0x2]	; 0230F2CA
	cmp r6,#0xff	; 0230F2CC
	bne loc_0230F2D2	; 0230F2CE
	b loc_0230F7FE	; 0230F2D0
loc_0230F2D2:
	ldrh r1,[r5,#0x12]	; 0230F2D2
	bl loc_023091D0	; 0230F2D4
	add r4,r5,#0x0	; 0230F2D8
	add r4,#0x2c	; 0230F2DA
	ldrh r7,[r5,#0x6]	; 0230F2DC
	cmp r7,#0xc	; 0230F2DE
	bhi loc_0230F2E4	; 0230F2E0
	b loc_0230F7FE	; 0230F2E2
loc_0230F2E4:
	mov r0,#0x0	; 0230F2E4
	str r0,[sp,#0x20]	; 0230F2E6
	ldr r0,[sp,#0x20]	; 0230F2E8
	add r1,sp,#0x24	; 0230F2EA
	mov r2,#0x28	; 0230F2EC
	bl loc_0230F82C	; 0230F2EE
	add r0,r4,#0x0	; 0230F2F2
	add r0,#0xc	; 0230F2F4
	str r0,[sp,#0x24]	; 0230F2F6
	sub r7,#0xc	; 0230F2F8
	add r1,sp,#0x8	; 0230F2FA
	strh r7,[r1,#0x24]	; 0230F2FC
	mov r0,#0x2	; 0230F2FE
	strh r0,[r1,#0x26]	; 0230F300
	ldr r0,[pool_0230F638]	; 0230F302
	ldr r2,[r0,#0x0]	; 0230F304
	ldr r0,[pool_0230F640]	; 0230F306
	ldrh r0,[r2,r0]	; 0230F308
	cmp r0,#0x0	; 0230F30A
	bne loc_0230F316	; 0230F30C
	ldrh r2,[r1,#0x26]	; 0230F30E
	mov r0,#0x1	; 0230F310
	orr r2,r0	; 0230F312
	strh r2,[r1,#0x26]	; 0230F314
loc_0230F316:
	mov r1,#0x38	; 0230F316
	add r0,sp,#0x8	; 0230F318
	strh r1,[r0,#0x28]	; 0230F31A
	ldrh r1,[r5,#0x8]	; 0230F31C
	strh r1,[r0,#0x20]	; 0230F31E
	ldrh r1,[r4,#0xa]	; 0230F320
	strh r1,[r0,#0x22]	; 0230F322
	add r0,sp,#0x24	; 0230F324
	bl loc_0230E278	; 0230F326
	ldr r4,[sp,#0x40]	; 0230F32A
	cmp r4,#0x0	; 0230F32C
	beq loc_0230F350	; 0230F32E
	ldrh r1,[r5,#0x16]	; 0230F330
	ldr r0,[pool_0230F644]	; 0230F332
	and r1,r0	; 0230F334
	cmp r1,#0x0	; 0230F336
	beq loc_0230F350	; 0230F338
	add r0,r4,#0x6	; 0230F33A
	bl loc_023053B4	; 0230F33C
	add r7,r0,#0x0	; 0230F340
	add r0,r4,#0x7	; 0230F342
	bl loc_023053B4	; 0230F344
	lsl r0,r0,#0x8	; 0230F348
	add r1,r7,r0	; 0230F34A
	ldr r0,[pool_0230F648]	; 0230F34C
	strh r1,[r0,#0x0]	; 0230F34E
loc_0230F350:
	ldr r0,[pool_0230F638]	; 0230F350
	ldr r0,[r0,#0x0]	; 0230F352
	ldr r1,[pool_0230F64C]	; 0230F354
	add r4,r0,r1	; 0230F356
	ldr r1,[pool_0230F650]	; 0230F358
	ldrh r3,[r0,r1]	; 0230F35A
	cmp r3,#0x13	; 0230F35C
	bne loc_0230F382	; 0230F35E
	ldr r1,[pool_0230F654]	; 0230F360
	ldr r0,[r0,r1]	; 0230F362
	ldrh r0,[r0,#0x38]	; 0230F364
	cmp r0,#0x1	; 0230F366
	bne loc_0230F382	; 0230F368
	add r0,sp,#0x8	; 0230F36A
	ldrh r1,[r0,#0x26]	; 0230F36C
	mov r0,#0x9	; 0230F36E
	and r1,r0	; 0230F370
	cmp r1,#0x9	; 0230F372
	beq loc_0230F378	; 0230F374
	b loc_0230F7EE	; 0230F376
loc_0230F378:
	add r0,r5,#0x0	; 0230F378
	add r1,sp,#0x24	; 0230F37A
	bl loc_0230EA6C	; 0230F37C
	b loc_0230F7EE	; 0230F380
loc_0230F382:
	add r7,sp,#0x8	; 0230F382
	ldrh r2,[r7,#0x26]	; 0230F384
	mov r0,#0x8	; 0230F386
	add r1,r2,#0x0	; 0230F388
	and r1,r0	; 0230F38A
	cmp r1,#0x0	; 0230F38C
	bne loc_0230F392	; 0230F38E
	b loc_0230F7EE	; 0230F390
loc_0230F392:
	ldrh r1,[r7,#0x28]	; 0230F392
	mov r0,#0x1	; 0230F394
	and r1,r0	; 0230F396
	cmp r1,#0x0	; 0230F398
	beq loc_0230F3AA	; 0230F39A
	cmp r1,#0x0	; 0230F39C
	bne loc_0230F3A2	; 0230F39E
	b loc_0230F7EE	; 0230F3A0
loc_0230F3A2:
	and r2,r0	; 0230F3A2
	cmp r2,#0x0	; 0230F3A4
	bne loc_0230F3AA	; 0230F3A6
	b loc_0230F7EE	; 0230F3A8
loc_0230F3AA:
	cmp r3,#0x21	; 0230F3AA
	beq loc_0230F3B0	; 0230F3AC
	b loc_0230F4F2	; 0230F3AE
loc_0230F3B0:
	bl loc_0230558C	; 0230F3B0
	add r0,sp,#0x8	; 0230F3B4
	ldrh r1,[r0,#0x26]	; 0230F3B6
	mov r2,#0x30	; 0230F3B8
	add r3,r1,#0x0	; 0230F3BA
	and r3,r2	; 0230F3BC
	cmp r3,#0x30	; 0230F3BE
	beq loc_0230F3D6	; 0230F3C0
	mov r2,#0xc	; 0230F3C2
	ldr r3,[pool_0230F638]	; 0230F3C4
	ldr r1,[r3,#0x0]	; 0230F3C6
	ldr r0,[pool_0230F658]	; 0230F3C8
	strh r2,[r1,r0]	; 0230F3CA
	mov r2,#0xa	; 0230F3CC
	ldr r1,[r3,#0x0]	; 0230F3CE
	ldr r0,[pool_0230F65C]	; 0230F3D0
	strh r2,[r1,r0]	; 0230F3D2
	b loc_0230F4CE	; 0230F3D4
loc_0230F3D6:
	mov r2,#0x4	; 0230F3D6
	and r1,r2	; 0230F3D8
	cmp r1,#0x0	; 0230F3DA
	bne loc_0230F3F2	; 0230F3DC
	mov r2,#0xc	; 0230F3DE
	ldr r3,[pool_0230F638]	; 0230F3E0
	ldr r1,[r3,#0x0]	; 0230F3E2
	ldr r0,[pool_0230F658]	; 0230F3E4
	strh r2,[r1,r0]	; 0230F3E6
	mov r2,#0x12	; 0230F3E8
	ldr r1,[r3,#0x0]	; 0230F3EA
	ldr r0,[pool_0230F65C]	; 0230F3EC
	strh r2,[r1,r0]	; 0230F3EE
	b loc_0230F4CE	; 0230F3F0
loc_0230F3F2:
	ldrh r2,[r5,#0x34]	; 0230F3F2
	ldr r1,[pool_0230F660]	; 0230F3F4
	cmp r2,r1	; 0230F3F6
	bls loc_0230F40E	; 0230F3F8
	mov r2,#0xc	; 0230F3FA
	ldr r3,[pool_0230F638]	; 0230F3FC
	ldr r1,[r3,#0x0]	; 0230F3FE
	ldr r0,[pool_0230F658]	; 0230F400
	strh r2,[r1,r0]	; 0230F402
	mov r2,#0x1	; 0230F404
	ldr r1,[r3,#0x0]	; 0230F406
	ldr r0,[pool_0230F65C]	; 0230F408
	strh r2,[r1,r0]	; 0230F40A
	b loc_0230F4CE	; 0230F40C
loc_0230F40E:
	mov r1,#0x0	; 0230F40E
	ldr r2,[pool_0230F638]	; 0230F410
	ldr r3,[r2,#0x0]	; 0230F412
	ldr r2,[pool_0230F658]	; 0230F414
	strh r1,[r3,r2]	; 0230F416
	ldrh r3,[r0,#0x28]	; 0230F418
	mov r2,#0x2	; 0230F41A
	and r3,r2	; 0230F41C
	cmp r3,#0x0	; 0230F41E
	beq loc_0230F430	; 0230F420
	ldrh r3,[r0,#0x26]	; 0230F422
	and r3,r2	; 0230F424
	cmp r3,#0x0	; 0230F426
	bne loc_0230F430	; 0230F428
	ldrh r0,[r0,#0x2e]	; 0230F42A
	bl loc_02306944	; 0230F42C
loc_0230F430:
	ldrh r0,[r4,#0xc]	; 0230F430
	cmp r0,#0x2	; 0230F432
	bne loc_0230F484	; 0230F434
	ldr r7,[sp,#0x48]	; 0230F436
	cmp r7,#0x0	; 0230F438
	beq loc_0230F476	; 0230F43A
	add r0,r7,#0x6	; 0230F43C
	bl loc_023053B4	; 0230F43E
	str r0,[sp,#0x0]	; 0230F442
	add r0,r7,#0x7	; 0230F444
	bl loc_023053B4	; 0230F446
	lsl r1,r0,#0x8	; 0230F44A
	ldr r0,[sp,#0x0]	; 0230F44C
	add r0,r0,r1	; 0230F44E
	lsl r0,r0,#0x10	; 0230F450
	lsr r0,r0,#0x10	; 0230F452
	mov r1,#0x1	; 0230F454
	bl loc_02306FC8	; 0230F456
	ldr r0,[sp,#0x48]	; 0230F45A
	add r0,#0x8	; 0230F45C
	bl loc_023053B4	; 0230F45E
	add r7,r0,#0x0	; 0230F462
	ldr r0,[sp,#0x48]	; 0230F464
	add r0,#0x9	; 0230F466
	bl loc_023053B4	; 0230F468
	lsl r0,r0,#0x8	; 0230F46C
	add r1,r7,r0	; 0230F46E
	ldr r0,[pool_0230F664]	; 0230F470
	strh r1,[r0,#0x0]	; 0230F472
	b loc_0230F484	; 0230F474
loc_0230F476:
	ldr r0,[pool_0230F668]	; 0230F476
	mov r1,#0x1	; 0230F478
	bl loc_02306FC8	; 0230F47A
	mov r1,#0x0	; 0230F47E
	ldr r0,[pool_0230F664]	; 0230F480
	strh r1,[r0,#0x0]	; 0230F482
loc_0230F484:
	ldr r0,[sp,#0x44]	; 0230F484
	add r0,r0,#0x3	; 0230F486
	bl loc_023053B4	; 0230F488
	bl loc_02306BF0	; 0230F48C
	ldr r0,[sp,#0x44]	; 0230F490
	add r0,r0,#0x2	; 0230F492
	bl loc_023053B4	; 0230F494
	add r1,r4,#0x0	; 0230F498
	add r1,#0x6a	; 0230F49A
	strh r0,[r1,#0x0]	; 0230F49C
	ldrh r0,[r5,#0x34]	; 0230F49E
	bl loc_02306C18	; 0230F4A0
	add r0,r4,#0x0	; 0230F4A4
	add r0,#0xe	; 0230F4A6
	ldrh r2,[r0,#0x0]	; 0230F4A8
	mov r1,#0x4	; 0230F4AA
	orr r2,r1	; 0230F4AC
	strh r2,[r0,#0x0]	; 0230F4AE
	ldrh r2,[r0,#0x0]	; 0230F4B0
	mov r1,#0x40	; 0230F4B2
	orr r2,r1	; 0230F4B4
	strh r2,[r0,#0x0]	; 0230F4B6
	ldrh r0,[r4,#0xc]	; 0230F4B8
	cmp r0,#0x2	; 0230F4BA
	bne loc_0230F4C4	; 0230F4BC
	mov r1,#0x3	; 0230F4BE
	ldr r0,[pool_0230F66C]	; 0230F4C0
	strh r1,[r0,#0x0]	; 0230F4C2
loc_0230F4C4:
	ldr r2,[pool_0230F670]	; 0230F4C4
	ldrh r1,[r2,#0x0]	; 0230F4C6
	mov r0,#0x1	; 0230F4C8
	orr r1,r0	; 0230F4CA
	strh r1,[r2,#0x0]	; 0230F4CC
loc_0230F4CE:
	ldr r0,[pool_0230F638]	; 0230F4CE
	ldr r1,[r0,#0x0]	; 0230F4D0
	ldr r0,[pool_0230F674]	; 0230F4D2
	ldr r0,[r1,r0]	; 0230F4D4
	add r0,#0x8	; 0230F4D6
	add r1,r5,#0x0	; 0230F4D8
	add r1,#0x1e	; 0230F4DA
	bl loc_02306458	; 0230F4DC
	mov r2,#0x25	; 0230F4E0
	ldr r0,[pool_0230F638]	; 0230F4E2
	ldr r1,[r0,#0x0]	; 0230F4E4
	ldr r0,[pool_0230F650]	; 0230F4E6
	strh r2,[r1,r0]	; 0230F4E8
	mov r0,#0x2	; 0230F4EA
	mov r1,#0x1	; 0230F4EC
	bl loc_02304B68	; 0230F4EE
loc_0230F4F2:
	ldrh r0,[r4,#0xc]	; 0230F4F2
	cmp r0,#0x1	; 0230F4F4
	bne loc_0230F4FA	; 0230F4F6
	b loc_0230F7D8	; 0230F4F8
loc_0230F4FA:
	cmp r0,#0x2	; 0230F4FA
	beq loc_0230F504	; 0230F4FC
	cmp r0,#0x3	; 0230F4FE
	beq loc_0230F596	; 0230F500
	b loc_0230F7D8	; 0230F502
loc_0230F504:
	ldr r7,[sp,#0x48]	; 0230F504
	cmp r7,#0x0	; 0230F506
	beq loc_0230F596	; 0230F508
	add r0,r7,#0x6	; 0230F50A
	bl loc_023053B4	; 0230F50C
	str r0,[sp,#0x4]	; 0230F510
	add r0,r7,#0x7	; 0230F512
	bl loc_023053B4	; 0230F514
	lsl r1,r0,#0x8	; 0230F518
	ldr r0,[sp,#0x4]	; 0230F51A
	add r0,r0,r1	; 0230F51C
	lsl r0,r0,#0x10	; 0230F51E
	lsr r0,r0,#0x10	; 0230F520
	mov r1,#0x0	; 0230F522
	bl loc_02306FC8	; 0230F524
	ldr r0,[sp,#0x48]	; 0230F528
	add r0,#0x8	; 0230F52A
	bl loc_023053B4	; 0230F52C
	add r7,r0,#0x0	; 0230F530
	ldr r0,[sp,#0x48]	; 0230F532
	add r0,#0x9	; 0230F534
	bl loc_023053B4	; 0230F536
	lsl r0,r0,#0x8	; 0230F53A
	add r1,r7,r0	; 0230F53C
	ldr r0,[pool_0230F664]	; 0230F53E
	strh r1,[r0,#0x0]	; 0230F540
	ldr r0,[sp,#0x48]	; 0230F542
	add r0,r0,#0x1	; 0230F544
	bl loc_023053B4	; 0230F546
	sub r0,#0x8	; 0230F54A
	add r1,r4,#0x0	; 0230F54C
	add r1,#0x94	; 0230F54E
	strh r0,[r1,#0x0]	; 0230F550
	add r0,r4,#0x0	; 0230F552
	add r0,#0x94	; 0230F554
	ldrh r2,[r0,#0x0]	; 0230F556
	cmp r2,#0x0	; 0230F558
	beq loc_0230F596	; 0230F55A
	ldr r0,[sp,#0x48]	; 0230F55C
	mov r1,#0x1	; 0230F55E
	add r3,r0,#0x0	; 0230F560
	and r3,r1	; 0230F562
	cmp r3,#0x0	; 0230F564
	beq loc_0230F580	; 0230F566
	add r0,#0x9	; 0230F568
	add r1,r4,#0x0	; 0230F56A
	add r1,#0x90	; 0230F56C
	ldr r1,[r1,#0x0]	; 0230F56E
	add r2,r2,#0x2	; 0230F570
	bl loc_0230F838	; 0230F572
	mov r1,#0x1	; 0230F576
	add r0,r4,#0x0	; 0230F578
	add r0,#0x96	; 0230F57A
	strh r1,[r0,#0x0]	; 0230F57C
	b loc_0230F596	; 0230F57E
loc_0230F580:
	add r0,#0xa	; 0230F580
	add r1,r4,#0x0	; 0230F582
	add r1,#0x90	; 0230F584
	ldr r1,[r1,#0x0]	; 0230F586
	add r2,r2,#0x1	; 0230F588
	bl loc_0230F844	; 0230F58A
	mov r1,#0x0	; 0230F58E
	add r0,r4,#0x0	; 0230F590
	add r0,#0x96	; 0230F592
	strh r1,[r0,#0x0]	; 0230F594
loc_0230F596:
	mov r7,#0x0	; 0230F596
	add r0,r4,#0x0	; 0230F598
	add r0,#0x74	; 0230F59A
	strh r7,[r0,#0x0]	; 0230F59C
	mov r0,#0x1c	; 0230F59E
	mul r6,r0	; 0230F5A0
	ldr r0,[pool_0230F638]	; 0230F5A2
	ldr r2,[r0,#0x0]	; 0230F5A4
	ldr r1,[pool_0230F678]	; 0230F5A6
	ldr r1,[r2,r1]	; 0230F5A8
	add r2,r1,r6	; 0230F5AA
	ldrh r1,[r2,#0x1a]	; 0230F5AC
	strh r1,[r2,#0x18]	; 0230F5AE
	add r1,r5,#0x0	; 0230F5B0
	add r1,#0x2c	; 0230F5B2
	ldmia r1!,{r2,r3}	; 0230F5B4
	add r1,sp,#0x8	; 0230F5B6
	stmia r1!,{r2,r3}	; 0230F5B8
	ldr r1,[r0,#0x0]	; 0230F5BA
	ldr r0,[pool_0230F67C]	; 0230F5BC
	ldrh r0,[r1,r0]	; 0230F5BE
	lsl r6,r0,#0xa	; 0230F5C0
	ldr r0,[sp,#0x8]	; 0230F5C2
	ldr r1,[sp,#0xc]	; 0230F5C4
	add r2,r6,#0x0	; 0230F5C6
	add r3,r7,#0x0	; 0230F5C8
	bl loc_0230F850	; 0230F5CA
	str r0,[sp,#0x8]	; 0230F5CE
	str r1,[sp,#0xc]	; 0230F5D0
	lsl r3,r7,#0	; 0230F5D2
	mov r2,#0x1	; 0230F5D4
	add r0,r0,r2	; 0230F5D6
	adc r1,r3	; 0230F5D8
	str r0,[sp,#0x8]	; 0230F5DA
	str r1,[sp,#0xc]	; 0230F5DC
	add r2,r6,#0x0	; 0230F5DE
	bl loc_0230F85C	; 0230F5E0
	str r0,[sp,#0x8]	; 0230F5E4
	str r1,[sp,#0xc]	; 0230F5E6
	add r0,sp,#0x8	; 0230F5E8
	ldrh r2,[r0,#0x6]	; 0230F5EA
	ldr r1,[pool_0230F680]	; 0230F5EC
	strh r2,[r1,#0x0]	; 0230F5EE
	ldrh r2,[r0,#0x4]	; 0230F5F0
	ldr r1,[pool_0230F684]	; 0230F5F2
	strh r2,[r1,#0x0]	; 0230F5F4
	ldrh r2,[r0,#0x2]	; 0230F5F6
	ldr r1,[pool_0230F688]	; 0230F5F8
	strh r2,[r1,#0x0]	; 0230F5FA
	ldrh r1,[r0,#0x0]	; 0230F5FC
	mov r0,#0x1	; 0230F5FE
	orr r1,r0	; 0230F600
	ldr r0,[pool_0230F68C]	; 0230F602
	strh r1,[r0,#0x0]	; 0230F604
	ldrh r0,[r4,#0xe]	; 0230F606
	lsl r0,r0,#0x19	; 0230F608
	lsr r0,r0,#0x1f	; 0230F60A
	cmp r0,#0x0	; 0230F60C
	beq loc_0230F704	; 0230F60E
	ldr r0,[sp,#0x8]	; 0230F610
	ldr r1,[sp,#0xc]	; 0230F612
	sub r0,r0,r6	; 0230F614
	sbc r1,r7	; 0230F616
	str r0,[sp,#0x8]	; 0230F618
	str r1,[sp,#0xc]	; 0230F61A
	bl loc_0230F868	; 0230F61C
	ldr r2,[pool_0230F690]	; 0230F620
	ldrh r1,[r2,#0x0]	; 0230F622
	add r6,sp,#0x8	; 0230F624
	strh r1,[r6,#0x8]	; 0230F626
	ldr r1,[pool_0230F694]	; 0230F628
	ldrh r3,[r1,#0x0]	; 0230F62A
	strh r3,[r6,#0xa]	; 0230F62C
	ldr r7,[pool_0230F698]	; 0230F62E
	ldrh r3,[r7,#0x0]	; 0230F630
	strh r3,[r6,#0xc]	; 0230F632
	ldr r3,[pool_0230F69C]	; 0230F634
	b loc_0230F6A0	; 0230F636
pool_0230F638:
loc_0230F638:
	.word FirmwareWlWorkPointerSlot	; 0230F638
pool_0230F63C:
loc_0230F63C:
	.word 0x00000528	; 0230F63C
pool_0230F640:
loc_0230F640:
	.word 0x0000031A	; 0230F640
pool_0230F644:
loc_0230F644:
	.word 0x00008000	; 0230F644
pool_0230F648:
loc_0230F648:
	.word REG_WIFI_CONTENTFREE	; 0230F648
pool_0230F64C:
loc_0230F64C:
	.word 0x00000308	; 0230F64C
pool_0230F650:
loc_0230F650:
	.word 0x000003BC	; 0230F650
pool_0230F654:
loc_0230F654:
	.word 0x000003D4	; 0230F654
pool_0230F658:
loc_0230F658:
	.word 0x000003C0	; 0230F658
pool_0230F65C:
loc_0230F65C:
	.word 0x000003C2	; 0230F65C
pool_0230F660:
loc_0230F660:
	.word 0x000003E8	; 0230F660
pool_0230F664:
loc_0230F664:
	.word FirmwareWlAdjustedTimeSlot	; 0230F664
pool_0230F668:
loc_0230F668:
	.word 0x0000FFFF	; 0230F668
pool_0230F66C:
loc_0230F66C:
	.word REG_WIFI_UNKNOWN_048	; 0230F66C
pool_0230F670:
loc_0230F670:
	.word REG_WIFI_POWER_TX	; 0230F670
pool_0230F674:
loc_0230F674:
	.word 0x000003D8	; 0230F674
pool_0230F678:
loc_0230F678:
	.word 0x000002E0	; 0230F678
pool_0230F67C:
loc_0230F67C:
	.word 0x0000036A	; 0230F67C
pool_0230F680:
loc_0230F680:
	.word REG_WIFI_US_COMPARE3	; 0230F680
pool_0230F684:
loc_0230F684:
	.word REG_WIFI_US_COMPARE2	; 0230F684
pool_0230F688:
loc_0230F688:
	.word REG_WIFI_US_COMPARE1	; 0230F688
pool_0230F68C:
loc_0230F68C:
	.word REG_WIFI_US_COMPARE0	; 0230F68C
pool_0230F690:
loc_0230F690:
	.word REG_WIFI_US_COUNT0	; 0230F690
pool_0230F694:
loc_0230F694:
	.word REG_WIFI_US_COUNT1	; 0230F694
pool_0230F698:
loc_0230F698:
	.word REG_WIFI_US_COUNT2	; 0230F698
pool_0230F69C:
loc_0230F69C:
	.word REG_WIFI_US_COUNT3	; 0230F69C
loc_0230F6A0:
	ldrh r3,[r3,#0x0]	; 0230F6A0
	strh r3,[r6,#0xe]	; 0230F6A2
	ldrh r2,[r2,#0x0]	; 0230F6A4
	strh r2,[r6,#0x10]	; 0230F6A6
	ldrh r1,[r1,#0x0]	; 0230F6A8
	strh r1,[r6,#0x12]	; 0230F6AA
	ldrh r1,[r7,#0x0]	; 0230F6AC
	strh r1,[r6,#0x14]	; 0230F6AE
	ldr r1,[pool_0230F808]	; 0230F6B0
	ldrh r1,[r1,#0x0]	; 0230F6B2
	strh r1,[r6,#0x16]	; 0230F6B4
	bl loc_0230F874	; 0230F6B6
	lsl r0,r6,#0	; 0230F6BA
	ldrh r1,[r0,#0x8]	; 0230F6BC
	ldrh r0,[r0,#0x10]	; 0230F6BE
	cmp r1,r0	; 0230F6C0
	bcs loc_0230F6D8	; 0230F6C2
	ldr r2,[sp,#0x10]	; 0230F6C4
	ldr r3,[sp,#0x14]	; 0230F6C6
	ldr r1,[sp,#0x8]	; 0230F6C8
	ldr r0,[sp,#0xc]	; 0230F6CA
	sub r2,r2,r1	; 0230F6CC
	sbc r3,r0	; 0230F6CE
	lsl r1,r3,#0x16	; 0230F6D0
	lsr r0,r2,#0xa	; 0230F6D2
	orr r0,r1	; 0230F6D4
	b loc_0230F6EA	; 0230F6D6
loc_0230F6D8:
	ldr r2,[sp,#0x18]	; 0230F6D8
	ldr r3,[sp,#0x1c]	; 0230F6DA
	ldr r1,[sp,#0x8]	; 0230F6DC
	ldr r0,[sp,#0xc]	; 0230F6DE
	sub r2,r2,r1	; 0230F6E0
	sbc r3,r0	; 0230F6E2
	lsl r1,r3,#0x16	; 0230F6E4
	lsr r0,r2,#0xa	; 0230F6E6
	orr r0,r1	; 0230F6E8
loc_0230F6EA:
	ldr r1,[pool_0230F80C]	; 0230F6EA
	ldr r2,[r1,#0x0]	; 0230F6EC
	ldr r1,[pool_0230F810]	; 0230F6EE
	ldrh r1,[r2,r1]	; 0230F6F0
	cmp r0,r1	; 0230F6F2
	bcs loc_0230F6FE	; 0230F6F4
	sub r1,r1,r0	; 0230F6F6
	ldr r0,[pool_0230F814]	; 0230F6F8
	strh r1,[r0,#0x0]	; 0230F6FA
	b loc_0230F704	; 0230F6FC
loc_0230F6FE:
	mov r1,#0x0	; 0230F6FE
	ldr r0,[pool_0230F814]	; 0230F700
	strh r1,[r0,#0x0]	; 0230F702
loc_0230F704:
	ldr r0,[pool_0230F80C]	; 0230F704
	ldr r2,[r0,#0x0]	; 0230F706
	ldr r0,[pool_0230F818]	; 0230F708
	ldrh r0,[r2,r0]	; 0230F70A
	cmp r0,#0x40	; 0230F70C
	bne loc_0230F7D8	; 0230F70E
	ldr r1,[sp,#0x44]	; 0230F710
	cmp r1,#0x0	; 0230F712
	beq loc_0230F7D8	; 0230F714
	ldr r0,[pool_0230F81C]	; 0230F716
	ldrh r0,[r2,r0]	; 0230F718
	lsl r0,r0,#0x1f	; 0230F71A
	lsr r0,r0,#0x1f	; 0230F71C
	cmp r0,#0x1	; 0230F71E
	bne loc_0230F7D8	; 0230F720
	add r0,r1,#0x2	; 0230F722
	bl loc_023053B4	; 0230F724
	add r1,r4,#0x0	; 0230F728
	add r1,#0x6a	; 0230F72A
	ldrh r1,[r1,#0x0]	; 0230F72C
	cmp r1,r0	; 0230F72E
	beq loc_0230F738	; 0230F730
	add r1,r4,#0x0	; 0230F732
	add r1,#0x6a	; 0230F734
	strh r0,[r1,#0x0]	; 0230F736
loc_0230F738:
	mov r2,#0x0	; 0230F738
	add r1,r4,#0x0	; 0230F73A
	add r1,#0x82	; 0230F73C
	strh r2,[r1,#0x0]	; 0230F73E
	cmp r0,#0x0	; 0230F740
	bne loc_0230F75E	; 0230F742
	ldr r0,[sp,#0x44]	; 0230F744
	add r0,r0,#0x4	; 0230F746
	bl loc_023053B4	; 0230F748
	mov r1,#0x1	; 0230F74C
	and r0,r1	; 0230F74E
	cmp r0,#0x0	; 0230F750
	beq loc_0230F75E	; 0230F752
	add r2,r4,#0x0	; 0230F754
	add r2,#0x82	; 0230F756
	ldrh r0,[r2,#0x0]	; 0230F758
	orr r0,r1	; 0230F75A
	strh r0,[r2,#0x0]	; 0230F75C
loc_0230F75E:
	ldr r0,[sp,#0x44]	; 0230F75E
	add r0,r0,#0x4	; 0230F760
	bl loc_023053B4	; 0230F762
	mov r1,#0xfe	; 0230F766
	add r7,r0,#0x0	; 0230F768
	and r7,r1	; 0230F76A
	lsl r6,r7,#0x3	; 0230F76C
	ldr r0,[sp,#0x44]	; 0230F76E
	add r0,r0,#0x1	; 0230F770
	bl loc_023053B4	; 0230F772
	add r0,r7,r0	; 0230F776
	sub r0,r0,#0x3	; 0230F778
	lsl r1,r0,#0x3	; 0230F77A
	add r0,r4,#0x0	; 0230F77C
	add r0,#0x5e	; 0230F77E
	ldrh r0,[r0,#0x0]	; 0230F780
	cmp r6,r0	; 0230F782
	bhi loc_0230F7B6	; 0230F784
	cmp r0,r1	; 0230F786
	bhi loc_0230F7B6	; 0230F788
	sub r6,r0,r6	; 0230F78A
	ldr r0,[sp,#0x44]	; 0230F78C
	add r1,r0,#0x5	; 0230F78E
	lsr r0,r6,#0x3	; 0230F790
	add r0,r1,r0	; 0230F792
	bl loc_023053B4	; 0230F794
	mov r2,#0x1	; 0230F798
	mov r1,#0x7	; 0230F79A
	and r6,r1	; 0230F79C
	lsl r2,r6	; 0230F79E
	and r2,r0	; 0230F7A0
	cmp r2,#0x0	; 0230F7A2
	beq loc_0230F7B6	; 0230F7A4
	add r2,r4,#0x0	; 0230F7A6
	add r2,#0x82	; 0230F7A8
	ldrh r1,[r2,#0x0]	; 0230F7AA
	mov r0,#0x2	; 0230F7AC
	orr r1,r0	; 0230F7AE
	strh r1,[r2,#0x0]	; 0230F7B0
	bl loc_0230CA84	; 0230F7B2
loc_0230F7B6:
	ldr r0,[pool_0230F80C]	; 0230F7B6
	ldr r1,[r0,#0x0]	; 0230F7B8
	ldr r0,[pool_0230F820]	; 0230F7BA
	ldrh r0,[r1,r0]	; 0230F7BC
	cmp r0,#0x0	; 0230F7BE
	bne loc_0230F7D8	; 0230F7C0
	ldr r0,[pool_0230F824]	; 0230F7C2
	ldrh r0,[r1,r0]	; 0230F7C4
	cmp r0,#0x0	; 0230F7C6
	bne loc_0230F7D8	; 0230F7C8
	add r4,#0x82	; 0230F7CA
	ldrh r0,[r4,#0x0]	; 0230F7CC
	cmp r0,#0x0	; 0230F7CE
	bne loc_0230F7D8	; 0230F7D0
	mov r0,#0x1	; 0230F7D2
	bl loc_02306810	; 0230F7D4
loc_0230F7D8:
	ldr r0,[pool_0230F80C]	; 0230F7D8
	ldr r1,[r0,#0x0]	; 0230F7DA
	ldr r0,[pool_0230F828]	; 0230F7DC
	ldrh r0,[r1,r0]	; 0230F7DE
	lsl r0,r0,#0x19	; 0230F7E0
	lsr r0,r0,#0x1f	; 0230F7E2
	cmp r0,#0x0	; 0230F7E4
	beq loc_0230F7EE	; 0230F7E6
	add r0,r5,#0x0	; 0230F7E8
	bl loc_0230982C	; 0230F7EA
loc_0230F7EE:
	ldr r2,[sp,#0x3c]	; 0230F7EE
	cmp r2,#0x0	; 0230F7F0
	beq loc_0230F7FE	; 0230F7F2
	add r0,sp,#0x8	; 0230F7F4
	ldrh r0,[r0,#0x2e]	; 0230F7F6
	add r1,r5,#0x0	; 0230F7F8
	bl loc_0230FFC0	; 0230F7FA
loc_0230F7FE:
	add sp,#0x4c	; 0230F7FE
	pop {r4,r5,r6,r7}	; 0230F800
	pop {r3}	; 0230F802
	bx r3	; 0230F804
	.byte 0xC0, 0x46	; 0230F808
pool_0230F808:
loc_0230F808:
	.word REG_WIFI_US_COUNT3	; 0230F808
pool_0230F80C:
loc_0230F80C:
	.word FirmwareWlWorkPointerSlot	; 0230F80C
pool_0230F810:
loc_0230F810:
	.word 0x00000300	; 0230F810
pool_0230F814:
loc_0230F814:
	.word REG_WIFI_POST_BEACON	; 0230F814
pool_0230F818:
loc_0230F818:
	.word 0x00000310	; 0230F818
pool_0230F81C:
loc_0230F81C:
	.word 0x00000316	; 0230F81C
pool_0230F820:
loc_0230F820:
	.word 0x00000160	; 0230F820
pool_0230F824:
loc_0230F824:
	.word 0x0000016C	; 0230F824
pool_0230F828:
loc_0230F828:
	.word 0x000002FE	; 0230F828

; ===== function loc_0230F82C =====
loc_0230F82C:
	bx pc	; 0230F82C
	.byte 0xC0, 0x46	; 0230F830
.arm

; ===== function loc_0230F830 =====
loc_0230F830:
	ldr pc,[pool_0230F834]	; 0230F830
pool_0230F834:
loc_0230F834:
	.word loc_037FCE38	; 0230F834
.thumb

; ===== function loc_0230F838 =====
loc_0230F838:
	bx pc	; 0230F838
	.byte 0xC0, 0x46	; 0230F83C
.arm

; ===== function loc_0230F83C =====
loc_0230F83C:
	ldr pc,[pool_0230F840]	; 0230F83C
pool_0230F840:
loc_0230F840:
	.word P2_Entry_037FCE1C	; 0230F840
.thumb

; ===== function loc_0230F844 =====
loc_0230F844:
	bx pc	; 0230F844
	.byte 0xC0, 0x46	; 0230F848
.arm

; ===== function loc_0230F848 =====
loc_0230F848:
	ldr pc,[pool_0230F84C]	; 0230F848
pool_0230F84C:
loc_0230F84C:
	.word P2_Entry_037FCE1C	; 0230F84C
.thumb

; ===== function loc_0230F850 =====
loc_0230F850:
	bx pc	; 0230F850
	.byte 0xC0, 0x46	; 0230F854
.arm

; ===== function loc_0230F854 =====
loc_0230F854:
	ldr pc,[pool_0230F858]	; 0230F854
pool_0230F858:
loc_0230F858:
	.word loc_038022BC	; 0230F858
.thumb

; ===== function loc_0230F85C =====
loc_0230F85C:
	bx pc	; 0230F85C
	.byte 0xC0, 0x46	; 0230F860
.arm

; ===== function loc_0230F860 =====
loc_0230F860:
	ldr pc,[pool_0230F864]	; 0230F860
pool_0230F864:
loc_0230F864:
	.word loc_038024C4	; 0230F864
.thumb

; ===== function loc_0230F868 =====
loc_0230F868:
	bx pc	; 0230F868
	.byte 0xC0, 0x46	; 0230F86C
.arm

; ===== function loc_0230F86C =====
loc_0230F86C:
	ldr pc,[pool_0230F870]	; 0230F86C
pool_0230F870:
loc_0230F870:
	.word loc_037FCBF0	; 0230F870
.thumb

; ===== function loc_0230F874 =====
loc_0230F874:
	bx pc	; 0230F874
	.byte 0xC0, 0x46	; 0230F878
.arm

; ===== function loc_0230F878 =====
loc_0230F878:
	ldr pc,[pool_0230F87C]	; 0230F878
pool_0230F87C:
loc_0230F87C:
	.word loc_037FCC04	; 0230F87C
.thumb

; ===== function loc_0230F880 =====
loc_0230F880:
	push {r4,r5,r6,r7,lr}	; 0230F880
	sub sp,#0x4	; 0230F882
	ldr r1,[pool_0230F948]	; 0230F884
	ldr r3,[r1,#0x0]	; 0230F886
	ldr r1,[pool_0230F94C]	; 0230F888
	add r1,r3,r1	; 0230F88A
	ldr r2,[pool_0230F950]	; 0230F88C
	ldrh r2,[r3,r2]	; 0230F88E
	cmp r2,#0x40	; 0230F890
	beq loc_0230F898	; 0230F892
	mov r0,#0x1	; 0230F894
	b loc_0230F93E	; 0230F896
loc_0230F898:
	ldrh r3,[r0,#0x22]	; 0230F898
	add r2,r1,#0x0	; 0230F89A
	add r2,#0x5c	; 0230F89C
	ldrh r2,[r2,#0x0]	; 0230F89E
	cmp r3,r2	; 0230F8A0
	bne loc_0230F8C0	; 0230F8A2
	ldrh r3,[r0,#0x20]	; 0230F8A4
	add r2,r1,#0x0	; 0230F8A6
	add r2,#0x5a	; 0230F8A8
	ldrh r2,[r2,#0x0]	; 0230F8AA
	cmp r3,r2	; 0230F8AC
	bne loc_0230F8C0	; 0230F8AE
	ldrh r3,[r0,#0x1e]	; 0230F8B0
	add r2,r1,#0x0	; 0230F8B2
	add r2,#0x58	; 0230F8B4
	ldrh r2,[r2,#0x0]	; 0230F8B6
	cmp r3,r2	; 0230F8B8
	bne loc_0230F8C0	; 0230F8BA
	mov r2,#0x1	; 0230F8BC
	b loc_0230F8C2	; 0230F8BE
loc_0230F8C0:
	mov r2,#0x0	; 0230F8C0
loc_0230F8C2:
	cmp r2,#0x0	; 0230F8C2
	beq loc_0230F8F2	; 0230F8C4
	ldrh r3,[r0,#0x28]	; 0230F8C6
	add r2,r1,#0x0	; 0230F8C8
	add r2,#0x7a	; 0230F8CA
	ldrh r2,[r2,#0x0]	; 0230F8CC
	cmp r3,r2	; 0230F8CE
	bne loc_0230F8EC	; 0230F8D0
	ldrh r3,[r0,#0x26]	; 0230F8D2
	add r2,r1,#0x0	; 0230F8D4
	add r2,#0x78	; 0230F8D6
	ldrh r2,[r2,#0x0]	; 0230F8D8
	cmp r3,r2	; 0230F8DA
	bne loc_0230F8EC	; 0230F8DC
	ldrh r2,[r0,#0x24]	; 0230F8DE
	add r1,#0x76	; 0230F8E0
	ldrh r1,[r1,#0x0]	; 0230F8E2
	cmp r2,r1	; 0230F8E4
	bne loc_0230F8EC	; 0230F8E6
	mov r1,#0x1	; 0230F8E8
	b loc_0230F8EE	; 0230F8EA
loc_0230F8EC:
	mov r1,#0x0	; 0230F8EC
loc_0230F8EE:
	cmp r1,#0x0	; 0230F8EE
	bne loc_0230F8F6	; 0230F8F0
loc_0230F8F2:
	mov r0,#0x1	; 0230F8F2
	b loc_0230F93E	; 0230F8F4
loc_0230F8F6:
	ldrh r1,[r0,#0x10]	; 0230F8F6
	sub r1,#0x1c	; 0230F8F8
	strh r1,[r0,#0x6]	; 0230F8FA
	add r5,r0,#0x0	; 0230F8FC
	sub r5,#0x10	; 0230F8FE
	ldr r0,[pool_0230F954]	; 0230F900
	strh r0,[r5,#0xc]	; 0230F902
	mov r0,#0x18	; 0230F904
	strh r0,[r5,#0xe]	; 0230F906
	add r4,r5,#0x0	; 0230F908
	add r4,#0x18	; 0230F90A
	ldrh r3,[r4,#0x0]	; 0230F90C
	ldr r0,[pool_0230F958]	; 0230F90E
	ldrh r0,[r0,#0x0]	; 0230F910
	ldr r7,[pool_0230F95C]	; 0230F912
	and r0,r7	; 0230F914
	asr r2,r0,#0x3	; 0230F916
	ldr r0,[pool_0230F948]	; 0230F918
	ldr r6,[r0,#0x0]	; 0230F91A
	ldr r1,[pool_0230F960]	; 0230F91C
	ldrh r1,[r6,r1]	; 0230F91E
	ldr r6,[pool_0230F964]	; 0230F920
	ldrh r6,[r6,#0x0]	; 0230F922
	and r6,r7	; 0230F924
	asr r6,r6,#0x4	; 0230F926
	orr r1,r6	; 0230F928
	orr r2,r1	; 0230F92A
	orr r3,r2	; 0230F92C
	strh r3,[r4,#0x0]	; 0230F92E
	ldr r1,[r0,#0x0]	; 0230F930
	ldr r0,[pool_0230F968]	; 0230F932
	add r0,r1,r0	; 0230F934
	add r1,r5,#0x0	; 0230F936
	bl loc_02309574	; 0230F938
	mov r0,#0x0	; 0230F93C
loc_0230F93E:
	add sp,#0x4	; 0230F93E
	pop {r4,r5,r6,r7}	; 0230F940
	pop {r3}	; 0230F942
	bx r3	; 0230F944
	.byte 0xC0, 0x46	; 0230F948
pool_0230F948:
loc_0230F948:
	.word FirmwareWlWorkPointerSlot	; 0230F948
pool_0230F94C:
loc_0230F94C:
	.word 0x00000308	; 0230F94C
pool_0230F950:
loc_0230F950:
	.word 0x00000310	; 0230F950
pool_0230F954:
loc_0230F954:
	.word 0x00000185	; 0230F954
pool_0230F958:
loc_0230F958:
	.word REG_WIFI_TXBUF_REPLY1	; 0230F958
pool_0230F95C:
loc_0230F95C:
	.word 0x00008000	; 0230F95C
pool_0230F960:
loc_0230F960:
	.word 0x0000049E	; 0230F960
pool_0230F964:
loc_0230F964:
	.word REG_WIFI_TXBUF_REPLY2	; 0230F964
pool_0230F968:
loc_0230F968:
	.word 0x0000014C	; 0230F968

; ===== function loc_0230F96C =====
loc_0230F96C:
	push {r4,r5,r6,r7,lr}	; 0230F96C
	sub sp,#0x4	; 0230F96E
	add r5,r0,#0x0	; 0230F970
	ldr r0,[pool_0230FAB8]	; 0230F972
	ldr r0,[r0,#0x0]	; 0230F974
	ldr r1,[pool_0230FABC]	; 0230F976
	add r7,r0,r1	; 0230F978
	ldr r1,[pool_0230FAC0]	; 0230F97A
	ldr r6,[r0,r1]	; 0230F97C
	add r6,#0x10	; 0230F97E
	ldrh r1,[r7,#0x3c]	; 0230F980
	cmp r1,#0x0	; 0230F982
	bne loc_0230F988	; 0230F984
	b loc_0230FAAE	; 0230F986
loc_0230F988:
	ldrh r2,[r5,#0x1c]	; 0230F988
	ldr r1,[pool_0230FAC4]	; 0230F98A
	ldrh r1,[r0,r1]	; 0230F98C
	cmp r2,r1	; 0230F98E
	beq loc_0230F994	; 0230F990
	b loc_0230FAAE	; 0230F992
loc_0230F994:
	ldrh r2,[r5,#0x1a]	; 0230F994
	ldr r1,[pool_0230FAC8]	; 0230F996
	ldrh r1,[r0,r1]	; 0230F998
	cmp r2,r1	; 0230F99A
	beq loc_0230F9A0	; 0230F99C
	b loc_0230FAAE	; 0230F99E
loc_0230F9A0:
	ldrh r2,[r5,#0x18]	; 0230F9A0
	ldr r1,[pool_0230FACC]	; 0230F9A2
	ldrh r0,[r0,r1]	; 0230F9A4
	cmp r2,r0	; 0230F9A6
	beq loc_0230F9AC	; 0230F9A8
	b loc_0230FAAE	; 0230F9AA
loc_0230F9AC:
	ldrh r1,[r5,#0x10]	; 0230F9AC
	sub r1,#0x18	; 0230F9AE
	ldrh r0,[r6,#0x6]	; 0230F9B0
	sub r0,#0x8	; 0230F9B2
	cmp r1,r0	; 0230F9B4
	bgt loc_0230FAAE	; 0230F9B6
	add r0,r5,#0x0	; 0230F9B8
	add r0,#0x1e	; 0230F9BA
	bl loc_0230949C	; 0230F9BC
	cmp r0,#0xff	; 0230F9C0
	beq loc_0230FAAE	; 0230F9C2
	cmp r0,#0x0	; 0230F9C4
	beq loc_0230FAAE	; 0230F9C6
	mov r1,#0x1c	; 0230F9C8
	add r4,r0,#0x0	; 0230F9CA
	mul r4,r1	; 0230F9CC
	ldr r1,[pool_0230FAB8]	; 0230F9CE
	ldr r2,[r1,#0x0]	; 0230F9D0
	ldr r1,[pool_0230FAD0]	; 0230F9D2
	ldr r1,[r2,r1]	; 0230F9D4
	ldrh r1,[r1,r4]	; 0230F9D6
	cmp r1,#0x40	; 0230F9D8
	beq loc_0230F9F0	; 0230F9DA
	add r5,#0x1e	; 0230F9DC
	add r0,r5,#0x0	; 0230F9DE
	mov r1,#0x7	; 0230F9E0
	bl loc_0230C058	; 0230F9E2
	cmp r0,#0x0	; 0230F9E6
	beq loc_0230FAAE	; 0230F9E8
	bl loc_0230CAEC	; 0230F9EA
	b loc_0230FAAE	; 0230F9EE
loc_0230F9F0:
	lsl r0,r0,#0x10	; 0230F9F0
	lsr r0,r0,#0x10	; 0230F9F2
	ldrh r1,[r5,#0x14]	; 0230F9F4
	lsl r1,r1,#0x13	; 0230F9F6
	lsr r1,r1,#0x1f	; 0230F9F8
	bl loc_02309180	; 0230F9FA
	ldr r2,[pool_0230FAB8]	; 0230F9FE
	ldr r0,[r2,#0x0]	; 0230FA00
	ldr r3,[pool_0230FAD0]	; 0230FA02
	ldr r0,[r0,r3]	; 0230FA04
	add r1,r0,r4	; 0230FA06
	ldrh r0,[r1,#0x1a]	; 0230FA08
	strh r0,[r1,#0x18]	; 0230FA0A
	mov r0,#0x1	; 0230FA0C
	ldr r1,[r2,#0x0]	; 0230FA0E
	ldr r1,[r1,r3]	; 0230FA10
	add r1,r1,r4	; 0230FA12
	ldrh r1,[r1,#0x2]	; 0230FA14
	lsl r0,r1	; 0230FA16
	lsl r0,r0,#0x10	; 0230FA18
	lsr r0,r0,#0x10	; 0230FA1A
	add r1,r7,#0x0	; 0230FA1C
	add r1,#0x9a	; 0230FA1E
	ldrh r1,[r1,#0x0]	; 0230FA20
	add r2,r0,#0x0	; 0230FA22
	and r2,r1	; 0230FA24
	cmp r2,#0x0	; 0230FA26
	bne loc_0230FAAE	; 0230FA28
	add r1,r7,#0x0	; 0230FA2A
	add r1,#0x98	; 0230FA2C
	ldrh r1,[r1,#0x0]	; 0230FA2E
	add r2,r0,#0x0	; 0230FA30
	and r2,r1	; 0230FA32
	cmp r2,#0x0	; 0230FA34
	beq loc_0230FAAE	; 0230FA36
	add r2,r7,#0x0	; 0230FA38
	add r2,#0x9a	; 0230FA3A
	ldrh r1,[r2,#0x0]	; 0230FA3C
	orr r1,r0	; 0230FA3E
	strh r1,[r2,#0x0]	; 0230FA40
	ldrh r1,[r6,#0x0]	; 0230FA42
	bic r1,r0	; 0230FA44
	strh r1,[r6,#0x0]	; 0230FA46
	add r4,r6,#0x0	; 0230FA48
	add r4,#0xa	; 0230FA4A
	lsl r0,r0,#0xf	; 0230FA4C
	lsr r0,r0,#0x10	; 0230FA4E
	b loc_0230FA68	; 0230FA50
loc_0230FA52:
	add r1,r7,#0x0	; 0230FA52
	add r1,#0x98	; 0230FA54
	ldrh r1,[r1,#0x0]	; 0230FA56
	add r2,r0,#0x0	; 0230FA58
	and r2,r1	; 0230FA5A
	cmp r2,#0x0	; 0230FA5C
	beq loc_0230FA64	; 0230FA5E
	ldrh r1,[r6,#0x6]	; 0230FA60
	add r4,r4,r1	; 0230FA62
loc_0230FA64:
	lsl r0,r0,#0xf	; 0230FA64
	lsr r0,r0,#0x10	; 0230FA66
loc_0230FA68:
	cmp r0,#0x1	; 0230FA68
	bne loc_0230FA52	; 0230FA6A
	ldrh r0,[r5,#0x10]	; 0230FA6C
	sub r0,#0x18	; 0230FA6E
	strh r0,[r4,#0x0]	; 0230FA70
	add r0,r4,#0x3	; 0230FA72
	ldrh r2,[r5,#0x12]	; 0230FA74
	mov r1,#0xff	; 0230FA76
	and r2,r1	; 0230FA78
	lsl r1,r2,#0x10	; 0230FA7A
	lsr r1,r1,#0x10	; 0230FA7C
	lsl r1,r1,#0x18	; 0230FA7E
	lsr r1,r1,#0x18	; 0230FA80
	bl loc_023053D8	; 0230FA82
	add r0,r4,#0x2	; 0230FA86
	ldrh r2,[r5,#0xe]	; 0230FA88
	mov r1,#0xff	; 0230FA8A
	and r2,r1	; 0230FA8C
	lsl r1,r2,#0x10	; 0230FA8E
	lsr r1,r1,#0x10	; 0230FA90
	lsl r1,r1,#0x18	; 0230FA92
	lsr r1,r1,#0x18	; 0230FA94
	bl loc_023053D8	; 0230FA96
	ldrh r2,[r4,#0x0]	; 0230FA9A
	cmp r2,#0x0	; 0230FA9C
	beq loc_0230FAAE	; 0230FA9E
	add r5,#0x2c	; 0230FAA0
	add r0,r5,#0x0	; 0230FAA2
	add r4,#0x8	; 0230FAA4
	add r1,r4,#0x0	; 0230FAA6
	add r2,r2,#0x1	; 0230FAA8
	bl loc_0230FAD4	; 0230FAAA
loc_0230FAAE:
	add sp,#0x4	; 0230FAAE
	pop {r4,r5,r6,r7}	; 0230FAB0
	pop {r3}	; 0230FAB2
	bx r3	; 0230FAB4
	.byte 0xC0, 0x46	; 0230FAB8
pool_0230FAB8:
loc_0230FAB8:
	.word FirmwareWlWorkPointerSlot	; 0230FAB8
pool_0230FABC:
loc_0230FABC:
	.word 0x000003E4	; 0230FABC
pool_0230FAC0:
loc_0230FAC0:
	.word 0x00000474	; 0230FAC0
pool_0230FAC4:
loc_0230FAC4:
	.word 0x00000364	; 0230FAC4
pool_0230FAC8:
loc_0230FAC8:
	.word 0x00000362	; 0230FAC8
pool_0230FACC:
loc_0230FACC:
	.word 0x00000360	; 0230FACC
pool_0230FAD0:
loc_0230FAD0:
	.word 0x000002E0	; 0230FAD0

; ===== function loc_0230FAD4 =====
loc_0230FAD4:
	bx pc	; 0230FAD4
	.byte 0xC0, 0x46	; 0230FAD8
.arm

; ===== function loc_0230FAD8 =====
loc_0230FAD8:
	ldr pc,[pool_0230FADC]	; 0230FAD8
pool_0230FADC:
loc_0230FADC:
	.word P2_Entry_037FCE1C	; 0230FADC
.thumb

; ===== function loc_0230FAE0 =====
loc_0230FAE0:
	push {r4,r5,r6,r7,lr}	; 0230FAE0
	sub sp,#0x4	; 0230FAE2
	ldr r1,[pool_0230FC5C]	; 0230FAE4
	ldr r1,[r1,#0x0]	; 0230FAE6
	ldr r2,[pool_0230FC60]	; 0230FAE8
	add r2,r1,r2	; 0230FAEA
	ldr r3,[pool_0230FC64]	; 0230FAEC
	ldrh r3,[r1,r3]	; 0230FAEE
	cmp r3,#0x40	; 0230FAF0
	beq loc_0230FAF8	; 0230FAF2
	mov r0,#0x1	; 0230FAF4
	b loc_0230FC52	; 0230FAF6
loc_0230FAF8:
	ldrh r5,[r0,#0x2a]	; 0230FAF8
	ldr r3,[pool_0230FC68]	; 0230FAFA
	add r3,r1,r3	; 0230FAFC
	ldrh r4,[r3,#0x0]	; 0230FAFE
	cmp r4,r5	; 0230FB00
	bne loc_0230FB12	; 0230FB02
	ldr r0,[pool_0230FC6C]	; 0230FB04
	add r1,r1,r0	; 0230FB06
	ldr r0,[r1,#0x0]	; 0230FB08
	add r0,r0,#0x1	; 0230FB0A
	str r0,[r1,#0x0]	; 0230FB0C
	mov r0,#0x1	; 0230FB0E
	b loc_0230FC52	; 0230FB10
loc_0230FB12:
	strh r5,[r3,#0x0]	; 0230FB12
	ldrh r3,[r0,#0x22]	; 0230FB14
	add r1,r2,#0x0	; 0230FB16
	add r1,#0x5c	; 0230FB18
	ldrh r1,[r1,#0x0]	; 0230FB1A
	cmp r3,r1	; 0230FB1C
	bne loc_0230FB3C	; 0230FB1E
	ldrh r3,[r0,#0x20]	; 0230FB20
	add r1,r2,#0x0	; 0230FB22
	add r1,#0x5a	; 0230FB24
	ldrh r1,[r1,#0x0]	; 0230FB26
	cmp r3,r1	; 0230FB28
	bne loc_0230FB3C	; 0230FB2A
	ldrh r3,[r0,#0x1e]	; 0230FB2C
	add r1,r2,#0x0	; 0230FB2E
	add r1,#0x58	; 0230FB30
	ldrh r1,[r1,#0x0]	; 0230FB32
	cmp r3,r1	; 0230FB34
	bne loc_0230FB3C	; 0230FB36
	mov r1,#0x1	; 0230FB38
	b loc_0230FB3E	; 0230FB3A
loc_0230FB3C:
	mov r1,#0x0	; 0230FB3C
loc_0230FB3E:
	cmp r1,#0x0	; 0230FB3E
	beq loc_0230FB6E	; 0230FB40
	ldrh r3,[r0,#0x28]	; 0230FB42
	add r1,r2,#0x0	; 0230FB44
	add r1,#0x7a	; 0230FB46
	ldrh r1,[r1,#0x0]	; 0230FB48
	cmp r3,r1	; 0230FB4A
	bne loc_0230FB68	; 0230FB4C
	ldrh r3,[r0,#0x26]	; 0230FB4E
	add r1,r2,#0x0	; 0230FB50
	add r1,#0x78	; 0230FB52
	ldrh r1,[r1,#0x0]	; 0230FB54
	cmp r3,r1	; 0230FB56
	bne loc_0230FB68	; 0230FB58
	ldrh r3,[r0,#0x24]	; 0230FB5A
	add r2,#0x76	; 0230FB5C
	ldrh r1,[r2,#0x0]	; 0230FB5E
	cmp r3,r1	; 0230FB60
	bne loc_0230FB68	; 0230FB62
	mov r1,#0x1	; 0230FB64
	b loc_0230FB6A	; 0230FB66
loc_0230FB68:
	mov r1,#0x0	; 0230FB68
loc_0230FB6A:
	cmp r1,#0x0	; 0230FB6A
	bne loc_0230FB72	; 0230FB6C
loc_0230FB6E:
	mov r0,#0x1	; 0230FB6E
	b loc_0230FC52	; 0230FB70
loc_0230FB72:
	ldr r1,[pool_0230FC5C]	; 0230FB72
	ldr r1,[r1,#0x0]	; 0230FB74
	mov r3,#0x1	; 0230FB76
	ldr r2,[pool_0230FC70]	; 0230FB78
	ldrh r2,[r1,r2]	; 0230FB7A
	lsl r3,r2	; 0230FB7C
	lsl r2,r3,#0x10	; 0230FB7E
	lsr r3,r2,#0x10	; 0230FB80
	ldrh r2,[r0,#0x2e]	; 0230FB82
	and r3,r2	; 0230FB84
	cmp r3,#0x0	; 0230FB86
	bne loc_0230FB92	; 0230FB88
	mov r3,#0x0	; 0230FB8A
	ldr r2,[pool_0230FC74]	; 0230FB8C
	strh r3,[r1,r2]	; 0230FB8E
	b loc_0230FB98	; 0230FB90
loc_0230FB92:
	ldr r3,[pool_0230FC78]	; 0230FB92
	ldr r2,[pool_0230FC74]	; 0230FB94
	strh r3,[r1,r2]	; 0230FB96
loc_0230FB98:
	ldr r1,[pool_0230FC7C]	; 0230FB98
	ldrh r3,[r1,#0x0]	; 0230FB9A
	ldr r1,[pool_0230FC80]	; 0230FB9C
	add r2,r3,#0x0	; 0230FB9E
	and r2,r1	; 0230FBA0
	cmp r2,#0x0	; 0230FBA2
	beq loc_0230FBC4	; 0230FBA4
	ldr r1,[pool_0230FC84]	; 0230FBA6
	and r3,r1	; 0230FBA8
	lsl r2,r3,#0x1	; 0230FBAA
	ldr r1,[pool_0230FC88]	; 0230FBAC
	ldrh r1,[r2,r1]	; 0230FBAE
	cmp r1,#0x0	; 0230FBB0
	beq loc_0230FBC4	; 0230FBB2
	ldr r1,[pool_0230FC5C]	; 0230FBB4
	ldr r2,[r1,#0x0]	; 0230FBB6
	ldr r1,[pool_0230FC74]	; 0230FBB8
	add r3,r2,r1	; 0230FBBA
	ldrh r2,[r3,#0x0]	; 0230FBBC
	ldr r1,[pool_0230FC8C]	; 0230FBBE
	orr r2,r1	; 0230FBC0
	strh r2,[r3,#0x0]	; 0230FBC2
loc_0230FBC4:
	ldr r1,[pool_0230FC5C]	; 0230FBC4
	ldr r3,[r1,#0x0]	; 0230FBC6
	ldr r1,[pool_0230FC90]	; 0230FBC8
	ldrh r2,[r3,r1]	; 0230FBCA
	mov r1,#0x1c	; 0230FBCC
	mul r2,r1	; 0230FBCE
	ldr r1,[pool_0230FC94]	; 0230FBD0
	ldr r1,[r3,r1]	; 0230FBD2
	add r2,r1,r2	; 0230FBD4
	ldrh r1,[r2,#0x1a]	; 0230FBD6
	strh r1,[r2,#0x18]	; 0230FBD8
	ldrh r1,[r0,#0x10]	; 0230FBDA
	sub r1,#0x1c	; 0230FBDC
	strh r1,[r0,#0x6]	; 0230FBDE
	add r1,r0,#0x0	; 0230FBE0
	sub r1,#0x10	; 0230FBE2
	ldr r2,[pool_0230FC98]	; 0230FBE4
	strh r2,[r1,#0xc]	; 0230FBE6
	ldrh r0,[r0,#0x6]	; 0230FBE8
	add r0,#0x31	; 0230FBEA
	lsr r0,r0,#0x1	; 0230FBEC
	strh r0,[r1,#0xe]	; 0230FBEE
	ldrh r3,[r1,#0x3e]	; 0230FBF0
	mov r6,#0x0	; 0230FBF2
	mov r2,#0x1	; 0230FBF4
	b loc_0230FC06	; 0230FBF6
loc_0230FBF8:
	add r0,r3,#0x0	; 0230FBF8
	and r0,r2	; 0230FBFA
	cmp r0,#0x0	; 0230FBFC
	beq loc_0230FC02	; 0230FBFE
	add r6,r6,#0x1	; 0230FC00
loc_0230FC02:
	lsl r0,r3,#0xf	; 0230FC02
	lsr r3,r0,#0x10	; 0230FC04
loc_0230FC06:
	cmp r3,#0x0	; 0230FC06
	bne loc_0230FBF8	; 0230FC08
	add r5,r1,#0x0	; 0230FC0A
	add r5,#0x18	; 0230FC0C
	ldrh r4,[r5,#0x0]	; 0230FC0E
	ldr r0,[pool_0230FC9C]	; 0230FC10
	ldrh r2,[r0,#0x0]	; 0230FC12
	ldr r0,[pool_0230FC80]	; 0230FC14
	and r2,r0	; 0230FC16
	asr r3,r2,#0x3	; 0230FC18
	ldr r0,[pool_0230FC5C]	; 0230FC1A
	ldr r2,[r0,#0x0]	; 0230FC1C
	ldr r0,[pool_0230FC74]	; 0230FC1E
	ldrh r2,[r2,r0]	; 0230FC20
	ldr r0,[pool_0230FC7C]	; 0230FC22
	ldrh r7,[r0,#0x0]	; 0230FC24
	ldr r0,[pool_0230FC80]	; 0230FC26
	and r7,r0	; 0230FC28
	asr r0,r7,#0x4	; 0230FC2A
	orr r2,r0	; 0230FC2C
	orr r3,r2	; 0230FC2E
	orr r4,r3	; 0230FC30
	strh r4,[r5,#0x0]	; 0230FC32
	ldrh r2,[r1,#0x1c]	; 0230FC34
	ldrh r0,[r1,#0x3c]	; 0230FC36
	add r0,#0xa	; 0230FC38
	mul r6,r0	; 0230FC3A
	add r6,#0xfc	; 0230FC3C
	lsr r0,r6,#0x4	; 0230FC3E
	add r0,r2,r0	; 0230FC40
	strh r0,[r1,#0x1a]	; 0230FC42
	ldr r0,[pool_0230FC5C]	; 0230FC44
	ldr r2,[r0,#0x0]	; 0230FC46
	ldr r0,[pool_0230FCA0]	; 0230FC48
	add r0,r2,r0	; 0230FC4A
	bl loc_02309574	; 0230FC4C
	mov r0,#0x0	; 0230FC50
loc_0230FC52:
	add sp,#0x4	; 0230FC52
	pop {r4,r5,r6,r7}	; 0230FC54
	pop {r3}	; 0230FC56
	bx r3	; 0230FC58
	.byte 0xC0, 0x46	; 0230FC5C
pool_0230FC5C:
loc_0230FC5C:
	.word FirmwareWlWorkPointerSlot	; 0230FC5C
pool_0230FC60:
loc_0230FC60:
	.word 0x00000308	; 0230FC60
pool_0230FC64:
loc_0230FC64:
	.word 0x00000310	; 0230FC64
pool_0230FC68:
loc_0230FC68:
	.word 0x00000498	; 0230FC68
pool_0230FC6C:
loc_0230FC6C:
	.word 0x00000534	; 0230FC6C
pool_0230FC70:
loc_0230FC70:
	.word 0x00000366	; 0230FC70
pool_0230FC74:
loc_0230FC74:
	.word 0x0000049E	; 0230FC74
pool_0230FC78:
loc_0230FC78:
	.word 0x00002000	; 0230FC78
pool_0230FC7C:
loc_0230FC7C:
	.word REG_WIFI_TXBUF_REPLY2	; 0230FC7C
pool_0230FC80:
loc_0230FC80:
	.word 0x00008000	; 0230FC80
pool_0230FC84:
loc_0230FC84:
	.word 0x00007FFF	; 0230FC84
pool_0230FC88:
loc_0230FC88:
	.word 0x04804004	; 0230FC88
pool_0230FC8C:
loc_0230FC8C:
	.word 0x00004000	; 0230FC8C
pool_0230FC90:
loc_0230FC90:
	.word 0x00000384	; 0230FC90
pool_0230FC94:
loc_0230FC94:
	.word 0x000002E0	; 0230FC94
pool_0230FC98:
loc_0230FC98:
	.word 0x00000182	; 0230FC98
pool_0230FC9C:
loc_0230FC9C:
	.word REG_WIFI_TXBUF_REPLY1	; 0230FC9C
pool_0230FCA0:
loc_0230FCA0:
	.word 0x0000014C	; 0230FCA0

; ===== function loc_0230FCA4 =====
	push {r4,r5,r6,r7,lr}	; 0230FCA4
	sub sp,#0xc	; 0230FCA6
	ldr r0,[pool_0230FF14]	; 0230FCA8
	ldr r1,[r0,#0x0]	; 0230FCAA
	ldr r0,[pool_0230FF18]	; 0230FCAC
	add r4,r1,r0	; 0230FCAE
	ldr r0,[pool_0230FF1C]	; 0230FCB0
	add r0,r1,r0	; 0230FCB2
	ldr r7,[r0,#0x0]	; 0230FCB4
	mov r2,#0x0	; 0230FCB6
	mvn r2,r2	; 0230FCB8
	cmp r7,r2	; 0230FCBA
	bne loc_0230FCC0	; 0230FCBC
	b loc_0230FF0C	; 0230FCBE
loc_0230FCC0:
	ldr r2,[pool_0230FF20]	; 0230FCC0
	ldrh r1,[r1,r2]	; 0230FCC2
	cmp r1,#0x40	; 0230FCC4
	beq loc_0230FCD0	; 0230FCC6
	add r1,r7,#0x0	; 0230FCC8
	bl loc_02304FF8	; 0230FCCA
	b loc_0230FF0C	; 0230FCCE
loc_0230FCD0:
	add r5,r7,#0x0	; 0230FCD0
	add r5,#0x10	; 0230FCD2
	ldrh r0,[r5,#0x14]	; 0230FCD4
	lsl r0,r0,#0x17	; 0230FCD6
	lsr r0,r0,#0x1f	; 0230FCD8
	cmp r0,#0x0	; 0230FCDA
	beq loc_0230FD00	; 0230FCDC
	ldrh r1,[r5,#0x24]	; 0230FCDE
	mov r0,#0x1	; 0230FCE0
	and r1,r0	; 0230FCE2
	cmp r1,#0x0	; 0230FCE4
	beq loc_0230FCF4	; 0230FCE6
	add r1,r4,#0x0	; 0230FCE8
	add r1,#0x2c	; 0230FCEA
	ldr r0,[r1,#0x0]	; 0230FCEC
	add r0,r0,#0x1	; 0230FCEE
	str r0,[r1,#0x0]	; 0230FCF0
	b loc_0230FD20	; 0230FCF2
loc_0230FCF4:
	add r1,r4,#0x0	; 0230FCF4
	add r1,#0x28	; 0230FCF6
	ldr r0,[r1,#0x0]	; 0230FCF8
	add r0,r0,#0x1	; 0230FCFA
	str r0,[r1,#0x0]	; 0230FCFC
	b loc_0230FD20	; 0230FCFE
loc_0230FD00:
	ldrh r1,[r5,#0x18]	; 0230FD00
	mov r0,#0x1	; 0230FD02
	and r1,r0	; 0230FD04
	cmp r1,#0x0	; 0230FD06
	beq loc_0230FD16	; 0230FD08
	add r1,r4,#0x0	; 0230FD0A
	add r1,#0x2c	; 0230FD0C
	ldr r0,[r1,#0x0]	; 0230FD0E
	add r0,r0,#0x1	; 0230FD10
	str r0,[r1,#0x0]	; 0230FD12
	b loc_0230FD20	; 0230FD14
loc_0230FD16:
	add r1,r4,#0x0	; 0230FD16
	add r1,#0x28	; 0230FD18
	ldr r0,[r1,#0x0]	; 0230FD1A
	add r0,r0,#0x1	; 0230FD1C
	str r0,[r1,#0x0]	; 0230FD1E
loc_0230FD20:
	add r0,r4,#0x0	; 0230FD20
	str r0,[sp,#0x0]	; 0230FD22
	add r0,#0x24	; 0230FD24
	str r0,[sp,#0x0]	; 0230FD26
	ldrh r0,[r5,#0x8]	; 0230FD28
	mov r1,#0xf0	; 0230FD2A
	and r0,r1	; 0230FD2C
	mov r1,#0x10	; 0230FD2E
	bl loc_0230FF44	; 0230FD30
	ldr r1,[sp,#0x0]	; 0230FD34
	ldr r1,[r1,#0x0]	; 0230FD36
	sub r0,r0,#0x1	; 0230FD38
	add r1,r1,r0	; 0230FD3A
	ldr r0,[sp,#0x0]	; 0230FD3C
	str r1,[r0,#0x0]	; 0230FD3E
	mov r0,#0x1	; 0230FD40
	str r0,[sp,#0x4]	; 0230FD42
	ldr r0,[pool_0230FF14]	; 0230FD44
	ldr r2,[r0,#0x0]	; 0230FD46
	ldr r0,[pool_0230FF24]	; 0230FD48
	ldrh r0,[r2,r0]	; 0230FD4A
	cmp r0,#0x1	; 0230FD4C
	beq loc_0230FD5A	; 0230FD4E
	cmp r0,#0x2	; 0230FD50
	beq loc_0230FDFE	; 0230FD52
	cmp r0,#0x3	; 0230FD54
	beq loc_0230FDFE	; 0230FD56
	b loc_0230FE94	; 0230FD58
loc_0230FD5A:
	ldrh r1,[r5,#0x14]	; 0230FD5A
	ldr r0,[sp,#0x4]	; 0230FD5C
	and r1,r0	; 0230FD5E
	cmp r1,#0x0	; 0230FD60
	beq loc_0230FD66	; 0230FD62
	b loc_0230FE94	; 0230FD64
loc_0230FD66:
	add r0,r5,#0x0	; 0230FD66
	add r0,#0x1e	; 0230FD68
	bl loc_0230949C	; 0230FD6A
	add r6,r0,#0x0	; 0230FD6E
	cmp r6,#0xff	; 0230FD70
	beq loc_0230FD8C	; 0230FD72
	mov r1,#0x1c	; 0230FD74
	str r0,[sp,#0x8]	; 0230FD76
	mul r0,r1	; 0230FD78
	str r0,[sp,#0x8]	; 0230FD7A
	ldr r0,[pool_0230FF14]	; 0230FD7C
	ldr r1,[r0,#0x0]	; 0230FD7E
	ldr r0,[pool_0230FF28]	; 0230FD80
	ldr r1,[r1,r0]	; 0230FD82
	ldr r0,[sp,#0x8]	; 0230FD84
	ldrh r0,[r1,r0]	; 0230FD86
	cmp r0,#0x40	; 0230FD88
	beq loc_0230FDC0	; 0230FD8A
loc_0230FD8C:
	ldr r0,[pool_0230FF14]	; 0230FD8C
	ldr r1,[r0,#0x0]	; 0230FD8E
	ldr r0,[pool_0230FF28]	; 0230FD90
	ldr r2,[r1,r0]	; 0230FD92
	mov r0,#0x1c	; 0230FD94
	add r1,r6,#0x0	; 0230FD96
	mul r1,r0	; 0230FD98
	ldrh r0,[r2,r1]	; 0230FD9A
	cmp r0,#0x30	; 0230FD9C
	bne loc_0230FDAC	; 0230FD9E
	add r0,r5,#0x0	; 0230FDA0
	add r0,#0x1e	; 0230FDA2
	mov r1,#0x7	; 0230FDA4
	bl loc_0230C5C0	; 0230FDA6
	b loc_0230FDB6	; 0230FDAA
loc_0230FDAC:
	add r0,r5,#0x0	; 0230FDAC
	add r0,#0x1e	; 0230FDAE
	mov r1,#0x7	; 0230FDB0
	bl loc_0230C058	; 0230FDB2
loc_0230FDB6:
	cmp r0,#0x0	; 0230FDB6
	beq loc_0230FE94	; 0230FDB8
	bl loc_0230CAEC	; 0230FDBA
	b loc_0230FE94	; 0230FDBE
loc_0230FDC0:
	lsl r0,r6,#0x10	; 0230FDC0
	lsr r0,r0,#0x10	; 0230FDC2
	ldrh r1,[r5,#0x14]	; 0230FDC4
	lsl r1,r1,#0x13	; 0230FDC6
	lsr r1,r1,#0x1f	; 0230FDC8
	bl loc_02309180	; 0230FDCA
	ldrh r0,[r5,#0x2a]	; 0230FDCE
	ldr r1,[pool_0230FF14]	; 0230FDD0
	ldr r2,[r1,#0x0]	; 0230FDD2
	ldr r1,[pool_0230FF28]	; 0230FDD4
	ldr r2,[r2,r1]	; 0230FDD6
	ldr r1,[sp,#0x8]	; 0230FDD8
	add r1,r2,r1	; 0230FDDA
	ldrh r1,[r1,#0x14]	; 0230FDDC
	cmp r0,r1	; 0230FDDE
	bne loc_0230FDEC	; 0230FDE0
	add r4,#0x3c	; 0230FDE2
	ldr r0,[r4,#0x0]	; 0230FDE4
	add r0,r0,#0x1	; 0230FDE6
	str r0,[r4,#0x0]	; 0230FDE8
	b loc_0230FE94	; 0230FDEA
loc_0230FDEC:
	add r0,r5,#0x0	; 0230FDEC
	add r0,#0x18	; 0230FDEE
	add r1,r5,#0x0	; 0230FDF0
	add r1,#0x24	; 0230FDF2
	bl loc_02306458	; 0230FDF4
	mov r0,#0x0	; 0230FDF8
	str r0,[sp,#0x4]	; 0230FDFA
	b loc_0230FE94	; 0230FDFC
loc_0230FDFE:
	ldrh r1,[r5,#0x14]	; 0230FDFE
	mov r3,#0x1	; 0230FE00
	add r0,r1,#0x0	; 0230FE02
	and r0,r3	; 0230FE04
	cmp r0,#0x0	; 0230FE06
	bne loc_0230FE94	; 0230FE08
	ldr r0,[pool_0230FF2C]	; 0230FE0A
	ldrh r0,[r2,r0]	; 0230FE0C
	lsl r0,r0,#0x1f	; 0230FE0E
	lsr r0,r0,#0x1f	; 0230FE10
	cmp r0,#0x0	; 0230FE12
	beq loc_0230FE5E	; 0230FE14
	ldr r0,[pool_0230FF30]	; 0230FE16
	and r1,r0	; 0230FE18
	cmp r1,#0x0	; 0230FE1A
	bne loc_0230FE5E	; 0230FE1C
	ldrh r0,[r5,#0x18]	; 0230FE1E
	and r0,r3	; 0230FE20
	cmp r0,#0x0	; 0230FE22
	beq loc_0230FE32	; 0230FE24
	ldr r0,[pool_0230FF34]	; 0230FE26
	add r1,r2,r0	; 0230FE28
	ldrh r0,[r1,#0x0]	; 0230FE2A
	bic r0,r3	; 0230FE2C
	strh r0,[r1,#0x0]	; 0230FE2E
	b loc_0230FE38	; 0230FE30
loc_0230FE32:
	mov r1,#0x0	; 0230FE32
	ldr r0,[pool_0230FF34]	; 0230FE34
	strh r1,[r2,r0]	; 0230FE36
loc_0230FE38:
	ldr r0,[pool_0230FF14]	; 0230FE38
	ldr r1,[r0,#0x0]	; 0230FE3A
	ldr r0,[pool_0230FF34]	; 0230FE3C
	ldrh r0,[r1,r0]	; 0230FE3E
	cmp r0,#0x0	; 0230FE40
	bne loc_0230FE5E	; 0230FE42
	ldr r0,[pool_0230FF28]	; 0230FE44
	ldr r0,[r1,r0]	; 0230FE46
	ldr r2,[pool_0230FF38]	; 0230FE48
	ldrh r2,[r1,r2]	; 0230FE4A
	mov r1,#0x1c	; 0230FE4C
	mul r2,r1	; 0230FE4E
	add r0,r0,r2	; 0230FE50
	ldrh r0,[r0,#0x16]	; 0230FE52
	cmp r0,#0x0	; 0230FE54
	bne loc_0230FE5E	; 0230FE56
	mov r0,#0x1	; 0230FE58
	bl loc_02306810	; 0230FE5A
loc_0230FE5E:
	ldr r0,[pool_0230FF14]	; 0230FE5E
	ldr r0,[r0,#0x0]	; 0230FE60
	ldr r1,[pool_0230FF38]	; 0230FE62
	ldrh r6,[r0,r1]	; 0230FE64
	ldrh r2,[r5,#0x2a]	; 0230FE66
	ldr r1,[pool_0230FF28]	; 0230FE68
	ldr r1,[r0,r1]	; 0230FE6A
	mov r0,#0x1c	; 0230FE6C
	add r3,r6,#0x0	; 0230FE6E
	mul r3,r0	; 0230FE70
	add r0,r1,r3	; 0230FE72
	ldrh r0,[r0,#0x14]	; 0230FE74
	cmp r2,r0	; 0230FE76
	bne loc_0230FE84	; 0230FE78
	add r4,#0x3c	; 0230FE7A
	ldr r0,[r4,#0x0]	; 0230FE7C
	add r0,r0,#0x1	; 0230FE7E
	str r0,[r4,#0x0]	; 0230FE80
	b loc_0230FE94	; 0230FE82
loc_0230FE84:
	add r0,r5,#0x0	; 0230FE84
	add r0,#0x1e	; 0230FE86
	add r1,r5,#0x0	; 0230FE88
	add r1,#0x24	; 0230FE8A
	bl loc_02306458	; 0230FE8C
	mov r0,#0x0	; 0230FE90
	str r0,[sp,#0x4]	; 0230FE92
loc_0230FE94:
	ldr r0,[sp,#0x4]	; 0230FE94
	cmp r0,#0x0	; 0230FE96
	bne loc_0230FEEA	; 0230FE98
	lsl r0,r6,#0x10	; 0230FE9A
	lsr r0,r0,#0x10	; 0230FE9C
	strh r0,[r5,#0x2]	; 0230FE9E
	ldrh r2,[r5,#0x12]	; 0230FEA0
	mov r1,#0xff	; 0230FEA2
	and r2,r1	; 0230FEA4
	lsl r1,r2,#0x10	; 0230FEA6
	lsr r1,r1,#0x10	; 0230FEA8
	bl loc_023091D0	; 0230FEAA
	mov r0,#0x1c	; 0230FEAE
	mul r6,r0	; 0230FEB0
	ldrh r1,[r5,#0x2a]	; 0230FEB2
	ldr r0,[pool_0230FF14]	; 0230FEB4
	ldr r3,[r0,#0x0]	; 0230FEB6
	ldr r2,[pool_0230FF28]	; 0230FEB8
	ldr r3,[r3,r2]	; 0230FEBA
	add r3,r3,r6	; 0230FEBC
	strh r1,[r3,#0x14]	; 0230FEBE
	ldr r1,[r0,#0x0]	; 0230FEC0
	ldr r1,[r1,r2]	; 0230FEC2
	add r2,r1,r6	; 0230FEC4
	ldrh r1,[r2,#0x1a]	; 0230FEC6
	strh r1,[r2,#0x18]	; 0230FEC8
	ldrh r1,[r5,#0x10]	; 0230FECA
	sub r1,#0x18	; 0230FECC
	strh r1,[r5,#0x6]	; 0230FECE
	ldr r1,[pool_0230FF3C]	; 0230FED0
	strh r1,[r7,#0xc]	; 0230FED2
	ldrh r1,[r5,#0x6]	; 0230FED4
	add r1,#0x2d	; 0230FED6
	lsr r1,r1,#0x1	; 0230FED8
	strh r1,[r7,#0xe]	; 0230FEDA
	ldr r1,[r0,#0x0]	; 0230FEDC
	ldr r0,[pool_0230FF1C]	; 0230FEDE
	add r0,r1,r0	; 0230FEE0
	add r1,r7,#0x0	; 0230FEE2
	bl loc_02309574	; 0230FEE4
	b loc_0230FEF8	; 0230FEE8
loc_0230FEEA:
	ldr r0,[pool_0230FF14]	; 0230FEEA
	ldr r1,[r0,#0x0]	; 0230FEEC
	ldr r0,[pool_0230FF1C]	; 0230FEEE
	add r0,r1,r0	; 0230FEF0
	add r1,r7,#0x0	; 0230FEF2
	bl loc_02304FF8	; 0230FEF4
loc_0230FEF8:
	ldr r0,[pool_0230FF14]	; 0230FEF8
	ldr r1,[r0,#0x0]	; 0230FEFA
	ldr r0,[pool_0230FF40]	; 0230FEFC
	ldrh r0,[r1,r0]	; 0230FEFE
	cmp r0,#0x0	; 0230FF00
	beq loc_0230FF0C	; 0230FF02
	mov r0,#0x2	; 0230FF04
	mov r1,#0x6	; 0230FF06
	bl loc_02304B68	; 0230FF08
loc_0230FF0C:
	add sp,#0xc	; 0230FF0C
	pop {r4,r5,r6,r7}	; 0230FF0E
	pop {r3}	; 0230FF10
	bx r3	; 0230FF12
pool_0230FF14:
loc_0230FF14:
	.word FirmwareWlWorkPointerSlot	; 0230FF14
pool_0230FF18:
loc_0230FF18:
	.word 0x000004F4	; 0230FF18
pool_0230FF1C:
loc_0230FF1C:
	.word 0x00000188	; 0230FF1C
pool_0230FF20:
loc_0230FF20:
	.word 0x00000310	; 0230FF20
pool_0230FF24:
loc_0230FF24:
	.word 0x00000314	; 0230FF24
pool_0230FF28:
loc_0230FF28:
	.word 0x000002E0	; 0230FF28
pool_0230FF2C:
loc_0230FF2C:
	.word 0x00000316	; 0230FF2C
pool_0230FF30:
loc_0230FF30:
	.word 0x00002000	; 0230FF30
pool_0230FF34:
loc_0230FF34:
	.word 0x0000038A	; 0230FF34
pool_0230FF38:
loc_0230FF38:
	.word 0x00000384	; 0230FF38
pool_0230FF3C:
loc_0230FF3C:
	.word 0x00000180	; 0230FF3C
pool_0230FF40:
loc_0230FF40:
	.word 0x00000190	; 0230FF40

; ===== function loc_0230FF44 =====
loc_0230FF44:
	bx pc	; 0230FF44
	.byte 0xC0, 0x46	; 0230FF48
.arm

; ===== function loc_0230FF48 =====
loc_0230FF48:
	ldr pc,[pool_0230FF4C]	; 0230FF48
pool_0230FF4C:
loc_0230FF4C:
	.word loc_03802514	; 0230FF4C
.thumb

; ===== function loc_0230FF50 =====
	push {r4,lr}	; 0230FF50
	ldr r0,[pool_0230FF84]	; 0230FF52
	ldr r1,[r0,#0x0]	; 0230FF54
	ldr r0,[pool_0230FF88]	; 0230FF56
	add r4,r1,r0	; 0230FF58
	mov r3,#0x0	; 0230FF5A
	add r0,r3,#0x0	; 0230FF5C
	add r2,r4,#0x0	; 0230FF5E
	add r2,#0x30	; 0230FF60
loc_0230FF62:
	ldrh r1,[r4,#0x30]	; 0230FF62
	cmp r1,#0x0	; 0230FF64
	beq loc_0230FF76	; 0230FF66
	ldrh r1,[r2,#0x0]	; 0230FF68
	sub r1,r1,#0x1	; 0230FF6A
	strh r1,[r2,#0x0]	; 0230FF6C
	ldrh r1,[r4,#0x30]	; 0230FF6E
	cmp r1,#0x0	; 0230FF70
	bne loc_0230FF76	; 0230FF72
	strh r0,[r4,#0x0]	; 0230FF74
loc_0230FF76:
	add r3,r3,#0x1	; 0230FF76
	cmp r3,#0x4	; 0230FF78
	bcc loc_0230FF62	; 0230FF7A
	pop {r4}	; 0230FF7C
	pop {r3}	; 0230FF7E
	bx r3	; 0230FF80
	.byte 0xC0, 0x46	; 0230FF84
pool_0230FF84:
loc_0230FF84:
	.word FirmwareWlWorkPointerSlot	; 0230FF84
pool_0230FF88:
loc_0230FF88:
	.word 0x00000200	; 0230FF88

; ===== function loc_0230FF8C =====
loc_0230FF8C:
	push {lr}	; 0230FF8C
	sub sp,#0x4	; 0230FF8E
	mov r1,#0x0	; 0230FF90
	add r0,sp,#0x0	; 0230FF92
	strh r1,[r0,#0x0]	; 0230FF94
	ldrh r0,[r0,#0x0]	; 0230FF96
	ldr r1,[pool_0230FFAC]	; 0230FF98
	ldr r2,[r1,#0x0]	; 0230FF9A
	ldr r1,[pool_0230FFB0]	; 0230FF9C
	add r1,r2,r1	; 0230FF9E
	mov r2,#0xc8	; 0230FFA0
	bl loc_0230FFB4	; 0230FFA2
	add sp,#0x4	; 0230FFA6
	pop {r3}	; 0230FFA8
	bx r3	; 0230FFAA
pool_0230FFAC:
loc_0230FFAC:
	.word FirmwareWlWorkPointerSlot	; 0230FFAC
pool_0230FFB0:
loc_0230FFB0:
	.word 0x00000200	; 0230FFB0

; ===== function loc_0230FFB4 =====
loc_0230FFB4:
	bx pc	; 0230FFB4
	.byte 0xC0, 0x46	; 0230FFB8
.arm

; ===== function loc_0230FFB8 =====
loc_0230FFB8:
	ldr pc,[pool_0230FFBC]	; 0230FFB8
pool_0230FFBC:
loc_0230FFBC:
	.word loc_037FCE04	; 0230FFBC
.thumb

; ===== function loc_0230FFC0 =====
loc_0230FFC0:
	push {r4,r5,r6,r7,lr}	; 0230FFC0
	sub sp,#0x14	; 0230FFC2
	str r0,[sp,#0x0]	; 0230FFC4
	add r4,r1,#0x0	; 0230FFC6
	add r7,r2,#0x0	; 0230FFC8
	ldr r0,[pool_023100A0]	; 0230FFCA
	ldr r1,[r0,#0x0]	; 0230FFCC
	ldr r0,[pool_023100A4]	; 0230FFCE
	add r5,r1,r0	; 0230FFD0
	add r0,r7,#0x1	; 0230FFD2
	bl loc_023053B4	; 0230FFD4
	cmp r0,#0x20	; 0230FFD8
	bhi loc_02310096	; 0230FFDA
	mov r0,#0x4	; 0230FFDC
	add r3,r0,#0x0	; 0230FFDE
	ldr r1,[pool_023100A8]	; 0230FFE0
	str r1,[sp,#0x4]	; 0230FFE2
	mov r6,#0x0	; 0230FFE4
	b loc_0231001A	; 0230FFE6
loc_0230FFE8:
	ldrh r1,[r5,#0x0]	; 0230FFE8
	cmp r1,#0x0	; 0230FFEA
	beq loc_02310014	; 0230FFEC
	ldrh r2,[r5,#0xa]	; 0230FFEE
	ldrh r1,[r4,#0x28]	; 0230FFF0
	cmp r2,r1	; 0230FFF2
	bne loc_02310006	; 0230FFF4
	ldrh r2,[r5,#0x8]	; 0230FFF6
	ldrh r1,[r4,#0x26]	; 0230FFF8
	cmp r2,r1	; 0230FFFA
	bne loc_02310006	; 0230FFFC
	ldrh r2,[r5,#0x6]	; 0230FFFE
	ldrh r1,[r4,#0x24]	; 02310000
	cmp r2,r1	; 02310002
	beq loc_0231002C	; 02310004
loc_02310006:
	ldrh r2,[r5,#0x30]	; 02310006
	ldr r1,[sp,#0x4]	; 02310008
	cmp r2,r1	; 0231000A
	bcs loc_02310016	; 0231000C
	str r2,[sp,#0x4]	; 0231000E
	add r3,r6,#0x0	; 02310010
	b loc_02310016	; 02310012
loc_02310014:
	add r0,r6,#0x0	; 02310014
loc_02310016:
	add r6,r6,#0x1	; 02310016
	add r5,#0x32	; 02310018
loc_0231001A:
	cmp r6,#0x4	; 0231001A
	bcc loc_0230FFE8	; 0231001C
	cmp r0,#0x4	; 0231001E
	beq loc_02310026	; 02310020
	add r6,r0,#0x0	; 02310022
	b loc_0231002C	; 02310024
loc_02310026:
	cmp r3,#0x4	; 02310026
	beq loc_02310096	; 02310028
	add r6,r3,#0x0	; 0231002A
loc_0231002C:
	ldr r0,[pool_023100A0]	; 0231002C
	ldr r1,[r0,#0x0]	; 0231002E
	ldr r0,[pool_023100A4]	; 02310030
	add r0,r1,r0	; 02310032
	str r0,[sp,#0x8]	; 02310034
	mov r2,#0x32	; 02310036
	mul r6,r2	; 02310038
	add r5,r0,r6	; 0231003A
	mov r1,#0x0	; 0231003C
	add r0,sp,#0xc	; 0231003E
	strh r1,[r0,#0x0]	; 02310040
	ldrh r0,[r0,#0x0]	; 02310042
	add r1,r5,#0x0	; 02310044
	bl loc_023100AC	; 02310046
	ldr r0,[pool_023100A8]	; 0231004A
	strh r0,[r5,#0x30]	; 0231004C
	ldrh r1,[r4,#0x12]	; 0231004E
	mov r0,#0xff	; 02310050
	and r1,r0	; 02310052
	ldr r0,[sp,#0x8]	; 02310054
	strh r1,[r0,r6]	; 02310056
	ldr r0,[sp,#0x0]	; 02310058
	strh r0,[r5,#0x2]	; 0231005A
	add r0,r5,#0x6	; 0231005C
	add r1,r4,#0x0	; 0231005E
	add r1,#0x24	; 02310060
	bl loc_02306458	; 02310062
	add r0,r7,#0x1	; 02310066
	bl loc_023053B4	; 02310068
	strh r0,[r5,#0xc]	; 0231006C
	mov r6,#0x0	; 0231006E
	add r7,r7,#0x2	; 02310070
	b loc_02310088	; 02310072
loc_02310074:
	add r0,r7,r6	; 02310074
	bl loc_023053B4	; 02310076
	add r1,r0,#0x0	; 0231007A
	add r0,r5,#0x0	; 0231007C
	add r0,#0xe	; 0231007E
	add r0,r0,r6	; 02310080
	bl loc_023053D8	; 02310082
	add r6,r6,#0x1	; 02310086
loc_02310088:
	ldrh r0,[r5,#0xc]	; 02310088
	cmp r6,r0	; 0231008A
	bcc loc_02310074	; 0231008C
	ldrh r0,[r4,#0x34]	; 0231008E
	strh r0,[r5,#0x2e]	; 02310090
	ldrh r0,[r4,#0x36]	; 02310092
	strh r0,[r5,#0x4]	; 02310094
loc_02310096:
	add sp,#0x14	; 02310096
	pop {r4,r5,r6,r7}	; 02310098
	pop {r3}	; 0231009A
	bx r3	; 0231009C
	.byte 0xC0, 0x46	; 023100A0
pool_023100A0:
loc_023100A0:
	.word FirmwareWlWorkPointerSlot	; 023100A0
pool_023100A4:
loc_023100A4:
	.word 0x00000200	; 023100A4
pool_023100A8:
loc_023100A8:
	.word 0x00000400	; 023100A8

; ===== function loc_023100AC =====
loc_023100AC:
	bx pc	; 023100AC
	.byte 0xC0, 0x46	; 023100B0
.arm

; ===== function loc_023100B0 =====
loc_023100B0:
	ldr pc,[pool_023100B4]	; 023100B0
pool_023100B4:
loc_023100B4:
	.word loc_037FCE04	; 023100B4
.thumb

; ===== function loc_023100B8 =====
loc_023100B8:
	push {lr}	; 023100B8
	sub sp,#0x4	; 023100BA
	ldr r0,[pool_02310154]	; 023100BC
	ldr r1,[r0,#0x0]	; 023100BE
	ldr r0,[pool_02310158]	; 023100C0
	ldr r0,[r1,r0]	; 023100C2
	bl loc_02310168	; 023100C4
	bl loc_023101D8	; 023100C8
	mov r0,#0x0	; 023100CC
	str r0,[sp,#0x0]	; 023100CE
	mov r0,#0x2c	; 023100D0
	mov r1,#0x2	; 023100D2
	add r2,sp,#0x0	; 023100D4
	bl loc_02310178	; 023100D6
	ldr r0,[pool_02310154]	; 023100DA
	ldr r1,[r0,#0x0]	; 023100DC
	ldr r0,[pool_02310158]	; 023100DE
	ldr r0,[r1,r0]	; 023100E0
	bl loc_02310188	; 023100E2
	ldr r1,[sp,#0x0]	; 023100E6
	cmp r1,#0xa4	; 023100E8
	bcc loc_023100F2	; 023100EA
	ldr r0,[pool_0231015C]	; 023100EC
	cmp r1,r0	; 023100EE
	bls loc_023100F6	; 023100F0
loc_023100F2:
	mov r0,#0x0	; 023100F2
	b loc_0231014C	; 023100F4
loc_023100F6:
	add r1,r1,#0x2	; 023100F6
	str r1,[sp,#0x0]	; 023100F8
	ldr r0,[pool_02310154]	; 023100FA
	ldr r2,[r0,#0x0]	; 023100FC
	ldr r0,[pool_02310160]	; 023100FE
	add r0,r2,r0	; 02310100
	bl loc_02305050	; 02310102
	ldr r3,[pool_02310154]	; 02310106
	ldr r2,[r3,#0x0]	; 02310108
	ldr r1,[pool_02310164]	; 0231010A
	str r0,[r2,r1]	; 0231010C
	ldr r0,[r3,#0x0]	; 0231010E
	add r0,r0,r1	; 02310110
	ldr r1,[r0,#0x0]	; 02310112
	cmp r1,#0x0	; 02310114
	bne loc_0231011C	; 02310116
	mov r0,#0x0	; 02310118
	b loc_0231014C	; 0231011A
loc_0231011C:
	add r1,#0xc	; 0231011C
	str r1,[r0,#0x0]	; 0231011E
	ldr r1,[r3,#0x0]	; 02310120
	ldr r0,[pool_02310158]	; 02310122
	ldr r0,[r1,r0]	; 02310124
	bl loc_02310168	; 02310126
	bl loc_023101D8	; 0231012A
	mov r0,#0x2a	; 0231012E
	ldr r1,[sp,#0x0]	; 02310130
	ldr r2,[pool_02310154]	; 02310132
	ldr r3,[r2,#0x0]	; 02310134
	ldr r2,[pool_02310164]	; 02310136
	ldr r2,[r3,r2]	; 02310138
	bl loc_02310178	; 0231013A
	ldr r0,[pool_02310154]	; 0231013E
	ldr r1,[r0,#0x0]	; 02310140
	ldr r0,[pool_02310158]	; 02310142
	ldr r0,[r1,r0]	; 02310144
	bl loc_02310188	; 02310146
	mov r0,#0x1	; 0231014A
loc_0231014C:
	add sp,#0x4	; 0231014C
	pop {r3}	; 0231014E
	bx r3	; 02310150
	.byte 0xC0, 0x46	; 02310154
pool_02310154:
loc_02310154:
	.word FirmwareWlWorkPointerSlot	; 02310154
pool_02310158:
loc_02310158:
	.word 0x000002D8	; 02310158
pool_0231015C:
loc_0231015C:
	.word 0x000001D6	; 0231015C
pool_02310160:
loc_02310160:
	.word 0x0000014C	; 02310160
pool_02310164:
loc_02310164:
	.word 0x000002DC	; 02310164

; ===== function loc_02310168 =====
loc_02310168:
	bx pc	; 02310168
	.byte 0xC0, 0x46	; 0231016C
.arm

; ===== function loc_0231016C =====
loc_0231016C:
	ldr r12,[pool_02310174]	; 0231016C
	bx r12	; 02310170
pool_02310174:
loc_02310174:
	.word loc_03800A20 + 1	; 02310174
.thumb

; ===== function loc_02310178 =====
loc_02310178:
	bx pc	; 02310178
	.byte 0xC0, 0x46	; 0231017C
.arm

; ===== function loc_0231017C =====
loc_0231017C:
	ldr r12,[pool_02310184]	; 0231017C
	bx r12	; 02310180
pool_02310184:
loc_02310184:
	.word loc_038018B8 + 1	; 02310184
.thumb

; ===== function loc_02310188 =====
loc_02310188:
	bx pc	; 02310188
	.byte 0xC0, 0x46	; 0231018C
.arm

; ===== function loc_0231018C =====
loc_0231018C:
	ldr r12,[pool_02310194]	; 0231018C
	bx r12	; 02310190
pool_02310194:
loc_02310194:
	.word loc_038009D8 + 1	; 02310194
.thumb

; ===== function loc_02310198 =====
loc_02310198:
	push {r4,r5,r6,lr}	; 02310198
	add r5,r1,#0x0	; 0231019A
	add r6,r2,#0x0	; 0231019C
	ldr r1,[pool_023101D0]	; 0231019E
	ldr r2,[r1,#0x0]	; 023101A0
	ldr r1,[pool_023101D4]	; 023101A2
	ldr r1,[r2,r1]	; 023101A4
	cmp r1,#0x0	; 023101A6
	beq loc_023101C8	; 023101A8
	add r4,r1,r0	; 023101AA
	sub r4,#0x2a	; 023101AC
	b loc_023101C4	; 023101AE
loc_023101B0:
	add r0,r4,#0x0	; 023101B0
	bl loc_023053B4	; 023101B2
	add r4,r4,#0x1	; 023101B6
	add r1,r0,#0x0	; 023101B8
	add r0,r6,#0x0	; 023101BA
	bl loc_023053D8	; 023101BC
	add r6,r6,#0x1	; 023101C0
	sub r5,r5,#0x1	; 023101C2
loc_023101C4:
	cmp r5,#0x0	; 023101C4
	bne loc_023101B0	; 023101C6
loc_023101C8:
	pop {r4,r5,r6}	; 023101C8
	pop {r3}	; 023101CA
	bx r3	; 023101CC
	.byte 0xC0, 0x46	; 023101D0
pool_023101D0:
loc_023101D0:
	.word FirmwareWlWorkPointerSlot	; 023101D0
pool_023101D4:
loc_023101D4:
	.word 0x000002DC	; 023101D4

; ===== function loc_023101D8 =====
loc_023101D8:
	push {r4,r5,lr}	; 023101D8
	sub sp,#0x4	; 023101DA
	mov r5,#0x2	; 023101DC
	str r5,[sp,#0x0]	; 023101DE
	add r4,sp,#0x0	; 023101E0
	b loc_023101EA	; 023101E2
loc_023101E4:
	add r0,r4,#0x0	; 023101E4
	bl loc_023101FC	; 023101E6
loc_023101EA:
	ldr r0,[sp,#0x0]	; 023101EA
	and r0,r5	; 023101EC
	cmp r0,#0x0	; 023101EE
	bne loc_023101E4	; 023101F0
	add sp,#0x4	; 023101F2
	pop {r4,r5}	; 023101F4
	pop {r3}	; 023101F6
	bx r3	; 023101F8
	.byte 0xC0, 0x46	; 023101FC

; ===== function loc_023101FC =====
loc_023101FC:
	bx pc	; 023101FC
	.byte 0xC0, 0x46	; 02310200
.arm

; ===== function loc_02310200 =====
loc_02310200:
	ldr r12,[pool_02310208]	; 02310200
	bx r12	; 02310204
pool_02310208:
loc_02310208:
	.word loc_038019B4 + 1	; 02310208
.thumb

; ===== function loc_0231020C =====
loc_0231020C:
	push {r4,r5,r6,r7,lr}	; 0231020C
	sub sp,#0x4	; 0231020E
	add r7,r0,#0x0	; 02310210
	ldr r0,[pool_02310274]	; 02310212
	ldr r1,[r0,#0x0]	; 02310214
	ldr r0,[pool_02310278]	; 02310216
	ldr r1,[r1,r0]	; 02310218
	ldrh r4,[r1,#0x2]	; 0231021A
	cmp r4,#0xa4	; 0231021C
	bcc loc_02310226	; 0231021E
	ldr r0,[pool_0231027C]	; 02310220
	cmp r4,r0	; 02310222
	bls loc_0231022A	; 02310224
loc_02310226:
	mov r0,#0x2	; 02310226
	b loc_0231026A	; 02310228
loc_0231022A:
	add r6,r1,#0x2	; 0231022A
	mov r5,#0x0	; 0231022C
	b loc_02310248	; 0231022E
loc_02310230:
	add r0,r6,#0x0	; 02310230
	bl loc_023053B4	; 02310232
	add r6,r6,#0x1	; 02310236
	lsl r0,r0,#0x18	; 02310238
	lsr r0,r0,#0x18	; 0231023A
	lsl r1,r5,#0x10	; 0231023C
	lsr r1,r1,#0x10	; 0231023E
	bl loc_023052E4	; 02310240
	add r5,r0,#0x0	; 02310244
	sub r4,r4,#0x1	; 02310246
loc_02310248:
	cmp r4,#0x0	; 02310248
	bne loc_02310230	; 0231024A
	ldr r0,[pool_02310274]	; 0231024C
	ldr r1,[r0,#0x0]	; 0231024E
	ldr r0,[pool_02310278]	; 02310250
	ldr r0,[r1,r0]	; 02310252
	ldrh r1,[r0,#0x0]	; 02310254
	cmp r7,#0x0	; 02310256
	beq loc_02310260	; 02310258
	lsl r0,r5,#0x10	; 0231025A
	orr r0,r1	; 0231025C
	str r0,[r7,#0x0]	; 0231025E
loc_02310260:
	cmp r5,r1	; 02310260
	beq loc_02310268	; 02310262
	mov r0,#0x1	; 02310264
	b loc_0231026A	; 02310266
loc_02310268:
	mov r0,#0x0	; 02310268
loc_0231026A:
	add sp,#0x4	; 0231026A
	pop {r4,r5,r6,r7}	; 0231026C
	pop {r3}	; 0231026E
	bx r3	; 02310270
	.byte 0xC0, 0x46	; 02310274
pool_02310274:
loc_02310274:
	.word FirmwareWlWorkPointerSlot	; 02310274
pool_02310278:
loc_02310278:
	.word 0x000002DC	; 02310278
pool_0231027C:
loc_0231027C:
	.word 0x000001D6	; 0231027C
	.byte 0x19, 0x1F, 0x30, 0x02, 0xC5, 0x1F, 0x30, 0x02, 0x0D, 0x21, 0x30, 0x02, 0x49, 0x45, 0x30, 0x02	; 02310290
	.byte 0x91, 0x45, 0x30, 0x02, 0x59, 0x47, 0x30, 0x02, 0xCD, 0x47, 0x30, 0x02, 0xA1, 0x21, 0x30, 0x02	; 023102A0
	.byte 0x59, 0x22, 0x30, 0x02, 0xD9, 0x23, 0x30, 0x02, 0xC9, 0x24, 0x30, 0x02, 0x51, 0x27, 0x30, 0x02	; 023102B0
	.byte 0xDD, 0x27, 0x30, 0x02, 0x15, 0x2D, 0x30, 0x02, 0x4D, 0x2D, 0x30, 0x02, 0x61, 0x2E, 0x30, 0x02	; 023102C0
	.byte 0xF1, 0x2E, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02	; 023102D0
	.byte 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02	; 023102E0
	.byte 0x31, 0x2F, 0x30, 0x02, 0x41, 0x30, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02, 0x21, 0x18, 0x30, 0x02	; 023102F0
	.byte 0xAD, 0x37, 0x30, 0x02, 0xA9, 0x30, 0x30, 0x02, 0x1D, 0x31, 0x30, 0x02, 0x4D, 0x32, 0x30, 0x02	; 02310300
	.byte 0xAD, 0x32, 0x30, 0x02, 0xE1, 0x43, 0x30, 0x02, 0x51, 0x44, 0x30, 0x02, 0x45, 0x48, 0x30, 0x02	; 02310310
	.byte 0xA9, 0x48, 0x30, 0x02, 0x85, 0x37, 0x30, 0x02, 0x61, 0x37, 0x30, 0x02	; 02310310
P4_Data_0231031C:
	.byte 0xB9, 0xA0, 0x30, 0x02	; 0231031C
	.byte 0x11, 0xA0, 0x30, 0x02, 0x59, 0x9F, 0x30, 0x02, 0xB1, 0x9E, 0x30, 0x02, 0x81, 0x9E, 0x30, 0x02	; 02310330
	.byte 0xA1, 0x9C, 0x30, 0x02, 0xA5, 0xFC, 0x30, 0x02, 0xD5, 0xDF, 0x30, 0x02, 0x95, 0x8C, 0x30, 0x02	; 02310340
	.byte 0x0D, 0xDE, 0x30, 0x02, 0xB9, 0x8E, 0x30, 0x02, 0xE1, 0x95, 0x30, 0x02, 0xC5, 0x4A, 0x30, 0x02	; 02310350
	.byte 0x69, 0x9C, 0x30, 0x02, 0x25, 0x8B, 0x30, 0x02, 0x61, 0x88, 0x30, 0x02, 0xAD, 0x87, 0x30, 0x02	; 02310360
	.byte 0xC5, 0xD9, 0x30, 0x02, 0x51, 0xFF, 0x30, 0x02, 0x2D, 0x95, 0x30, 0x02, 0x11, 0x87, 0x30, 0x02	; 02310370
	.byte 0xBD, 0x50, 0x30, 0x02, 0x03, 0x00, 0x03, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 02310380
	.byte 0x03, 0x09, 0xBF, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310390
	.byte 0x03, 0x09, 0xBF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00, 0x0B, 0x00, 0x0C, 0x00	; 023103A0
	.byte 0x12, 0x00, 0x16, 0x00, 0x18, 0x00, 0x24, 0x00, 0x30, 0x00, 0x48, 0x00, 0x60, 0x00, 0x6C, 0x00	; 023103B0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023103C0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023103D0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023103D0
P4_Data_023103D8:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14	; 023103D8
	.byte 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4, 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4	; 023103F0
	.byte 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44, 0x46, 0x01, 0x48, 0x01, 0x4A, 0x01, 0x4C, 0x01	; 02310400
	.byte 0x20, 0x01, 0x22, 0x01, 0x54, 0x01, 0x44, 0x01, 0x30, 0x01, 0x32, 0x01, 0x40, 0x01, 0x42, 0x01	; 02310410
	.byte 0x38, 0x00, 0x24, 0x01, 0x28, 0x01, 0x50, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310420
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310430
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310440
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310450
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310460
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02310460
P4_Data_02310468:
	.byte 0x04, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00	; 02310468
	.byte 0x0A, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0xFF, 0xFF, 0x54, 0x02, 0x00, 0x00	; 02310480
	.byte 0xB4, 0x00, 0xFF, 0xFF, 0x80, 0x00, 0x00, 0x00, 0x2A, 0x00, 0x00, 0x00, 0x28, 0x00, 0x00, 0x00	; 02310490
	.byte 0xE8, 0x00, 0x00, 0x00, 0xEA, 0x00, 0x00, 0x00, 0xEE, 0x00, 0x01, 0x00, 0xEC, 0x00, 0x03, 0x3F	; 023104A0
	.byte 0xA2, 0x01, 0x01, 0x00, 0xA0, 0x01, 0x00, 0x00, 0x10, 0x01, 0x00, 0x08, 0xBC, 0x00, 0x01, 0x00	; 023104B0
	.byte 0xD4, 0x00, 0x03, 0x00, 0xD8, 0x00, 0x04, 0x00, 0xDA, 0x00, 0x02, 0x06, 0x76, 0x00, 0x00, 0x00	; 023104C0
P4_Data_023104C0:
	.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x01, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023104C0
	.byte 0xFF, 0x00, 0xFF, 0x00, 0x02, 0x00, 0x03, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023104E0
	.byte 0xFF, 0x00, 0x04, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x05, 0x00, 0xFF, 0x00, 0x06, 0x00	; 023104F0
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310500
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x07, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310510
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x08, 0x00	; 02310520
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310530
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310540
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x09, 0x00	; 02310550
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310560
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310570
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0A, 0x00	; 02310580
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 02310590
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0B, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023105A0
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 023105B0
P4_Data_023105B0:
	.byte 0x18, 0x00, 0xFF, 0xFF, 0x1A, 0x00, 0xFF, 0xFF, 0x1C, 0x00, 0xFF, 0xFF, 0x22, 0x01, 0xFF, 0xFF	; 023105B0
	.byte 0x24, 0x01, 0xFF, 0xFF, 0x02, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x1C, 0x00	; 023105D0
	.byte 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x26, 0x00, 0x29, 0x00, 0x2C, 0x00	; 023105E0
	.byte 0x2D, 0x00, 0x2E, 0x00, 0x2F, 0x00, 0x30, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00	; 023105F0
	.byte 0x37, 0x00, 0x65, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 02310600
	.byte 0x0C, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x11, 0x00, 0x12, 0x00, 0x14, 0x00	; 02310610
	.byte 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x19, 0x00, 0x1A, 0x00, 0x27, 0x00, 0x4D, 0x00	; 02310620
	.byte 0x5D, 0x00, 0x5E, 0x00, 0x5F, 0x00, 0x60, 0x00, 0x61, 0x00, 0x64, 0x00, 0x66, 0x00, 0x00, 0x00	; 02310630
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x18, 0x00, 0x02, 0x00, 0xC5, 0xB7, 0x30, 0x02	; 02310640
	.byte 0x04, 0x00, 0x01, 0x00, 0x95, 0xB6, 0x30, 0x02, 0x0A, 0x00, 0x01, 0x00, 0x51, 0xB2, 0x30, 0x02	; 02310650
	.byte 0x0C, 0x00, 0x01, 0x00, 0x05, 0xB2, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0xCD, 0xB1, 0x30, 0x02	; 02310660
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310670
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310680
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x31, 0xAA, 0x30, 0x02	; 02310690
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x7D, 0xB1, 0x30, 0x02	; 023106A0
	.byte 0x00, 0x00, 0x01, 0x00, 0x35, 0xB1, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xF1, 0xB0, 0x30, 0x02	; 023106B0
	.byte 0x00, 0x00, 0x01, 0x00, 0xC5, 0xB0, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x99, 0xB0, 0x30, 0x02	; 023106C0
	.byte 0x00, 0x00, 0x09, 0x00, 0x45, 0xB0, 0x30, 0x02, 0x00, 0x00, 0x5C, 0x00, 0xF5, 0xAF, 0x30, 0x02	; 023106D0
	.byte 0x00, 0x00, 0x02, 0x00, 0xD9, 0xAF, 0x30, 0x02, 0x04, 0x00, 0x01, 0x00, 0x29, 0xAE, 0x30, 0x02	; 023106E0
	.byte 0x01, 0x00, 0x01, 0x00, 0x81, 0xA9, 0x30, 0x02, 0x03, 0x00, 0x01, 0x00, 0xFD, 0xA8, 0x30, 0x02	; 023106F0
	.byte 0x1F, 0x00, 0x23, 0x00, 0xDD, 0xA7, 0x30, 0x02, 0x22, 0x00, 0x05, 0x00, 0x51, 0xA6, 0x30, 0x02	; 02310700
	.byte 0x05, 0x00, 0x06, 0x00, 0x9D, 0xA5, 0x30, 0x02, 0x04, 0x00, 0x04, 0x00, 0xF1, 0xA4, 0x30, 0x02	; 02310710
	.byte 0x05, 0x00, 0x03, 0x00, 0x2D, 0xA4, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310720
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x17, 0x00, 0x01, 0x00, 0xDD, 0xA2, 0x30, 0x02	; 02310730
	.byte 0x0C, 0x00, 0x12, 0x00, 0x11, 0xA2, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310740
	.byte 0x00, 0x00, 0x04, 0x00, 0x09, 0xAA, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310750
	.byte 0x00, 0x00, 0x03, 0x00, 0xE1, 0xA9, 0x30, 0x02, 0x00, 0x00, 0x02, 0x00, 0xC5, 0xA9, 0x30, 0x02	; 02310760
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x02, 0x00, 0xA9, 0xA9, 0x30, 0x02	; 02310770
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310780
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310790
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 023107A0
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 023107B0
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 023107C0
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 023107D0
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 023107E0
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x48, 0x00, 0x01, 0x00, 0xF1, 0xAB, 0x30, 0x02	; 023107F0
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310800
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0xAD, 0xAB, 0x30, 0x02	; 02310810
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310820
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310830
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310840
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310850
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310860
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310870
	.byte 0x03, 0x00, 0x01, 0x00, 0x01, 0xAB, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0xB5, 0xAA, 0x30, 0x02	; 02310880
	.byte 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02	; 02310890
	.byte 0x01, 0x00, 0x01, 0x00, 0x89, 0xAA, 0x30, 0x02, 0x32, 0x2E, 0x31, 0x30, 0x2E, 0x30, 0x30, 0x00	; 023108A0
P4_Data_023108A0:
	.byte 0x01, 0x00, 0x04, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023108A0
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
