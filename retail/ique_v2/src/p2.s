; official_ique_v2_p2
; Readable armips reconstruction exported from Ghidra.
; Recognised code is assembly; data is retained only where Ghidra has no instruction.
.nds
.create "build/p2.bin", 0x037FA800
.arm
; ARM7 入口：关中断、清理 ARM7 WRAM、建立各模式栈后转入服务代码。
; ARM7 entry: masks IRQs, clears ARM7 WRAM, sets mode stacks, then enters services.
P2_Arm7ResetBootstrap:
loc_037FA800:
	mov r12,#0x4000000	; 037FA800
	str r12,[r12,#0x208]	; 037FA804 ; REG_IME = 0
	ldr r1,[pool_037FA888]	; 037FA808
	mov r0,#0x3800000	; 037FA80C
	cmp r0,r1	; 037FA810
	movpl r1,r0	; 037FA814
	ldr r2,[pool_037FA88C]	; 037FA818
	mov r0,#0x0	; 037FA81C
loc_037FA820:
	cmp r1,r2	; 037FA820
	stmltia r1!,{r0}	; 037FA824
	blt loc_037FA820	; 037FA828
	mov r0,#0x13	; 037FA82C
	msr cpsr_c,r0	; 037FA830
	ldr sp,[pool_037FA890]	; 037FA834
	mov r0,#0x12	; 037FA838
	msr cpsr_c,r0	; 037FA83C
	ldr r0,[pool_037FA894]	; 037FA840
	mov sp,r0	; 037FA844
	ldr r1,[pool_037FA898]	; 037FA848
	sub r1,r0,r1	; 037FA84C
	mov r0,#0x1f	; 037FA850
	msr cpsr_cxsf,r0	; 037FA854
	sub sp,r1,#0x4	; 037FA858
	bl P2_InitializeDataAndBss	; 037FA85C
	bl P2_TestMainRamMirror	; 037FA860
	ldr r1,[pool_037FA89C]	; 037FA864
	ldr r0,[pool_037FA8A0]	; 037FA868
	str r0,[r1,#0x0]	; 037FA86C
	bl loc_0380500C	; 037FA870
	bl P2_NoOperation	; 037FA874
	bl loc_037FA8AC	; 037FA878
	ldr r1,[pool_037FA8A4]	; 037FA87C
	ldr lr,[pool_037FA8A8]	; 037FA880
	bx r1	; 037FA884
pool_037FA888:
loc_037FA888:
	.word P2_BssEnd	; 037FA888
pool_037FA88C:
loc_037FA88C:
	.word 0x0380FF00	; 037FA88C
pool_037FA890:
loc_037FA890:
	.word 0x0380FFC0	; 037FA890
pool_037FA894:
loc_037FA894:
	.word 0x0380FF80	; 037FA894
pool_037FA898:
loc_037FA898:
	.word 0x00000200	; 037FA898
pool_037FA89C:
loc_037FA89C:
	.word Bios7IrqHandlerSlot	; 037FA89C
pool_037FA8A0:
loc_037FA8A0:
	.word P2_DispatchIrq	; 037FA8A0
pool_037FA8A4:
loc_037FA8A4:
	.word P2_RunBootTransferStateMachine + 1	; 037FA8A4
pool_037FA8A8:
loc_037FA8A8:
	.word P2_SyncAndEnterArm7Program	; 037FA8A8

; ===== function loc_037FA8AC =====
loc_037FA8AC:
	ldr r12,[pool_037FA8B4]	; 037FA8AC
	bx r12	; 037FA8B0
pool_037FA8B4:
loc_037FA8B4:
	.word loc_038050E4 + 1	; 037FA8B4

; ===== function loc_037FA8B8 =====
; 执行复制表并将 BSS 清零，结构与标准 CRT 初始化相符。
; Applies the copy table and clears BSS, matching standard CRT initialization.
P2_InitializeDataAndBss:
loc_037FA8B8:
	ldr r0,[pool_037FA924]	; 037FA8B8
	ldr r1,[r0,#0x0]	; 037FA8BC
	ldr r2,[r0,#0x4]	; 037FA8C0
	ldr r3,[r0,#0x8]	; 037FA8C4
loc_037FA8C8:
	cmp r1,r2	; 037FA8C8
	beq loc_037FA908	; 037FA8CC
	ldr r4,[r1],#0x4	; 037FA8D0
	ldr r5,[r1],#0x4	; 037FA8D4
	add r6,r4,r5	; 037FA8D8
loc_037FA8DC:
	cmp r4,r6	; 037FA8DC
	ldrmi r7,[r3],#0x4	; 037FA8E0
	strmi r7,[r4],#0x4	; 037FA8E4
	bmi loc_037FA8DC	; 037FA8E8
	ldr r5,[r1],#0x4	; 037FA8EC
	add r6,r4,r5	; 037FA8F0
	mov r7,#0x0	; 037FA8F4
loc_037FA8F8:
	cmp r4,r6	; 037FA8F8
	strcc r7,[r4],#0x4	; 037FA8FC
	bcc loc_037FA8F8	; 037FA900
	beq loc_037FA8C8	; 037FA904
loc_037FA908:
	ldr r4,[r0,#0xc]	; 037FA908
	ldr r6,[r0,#0x10]	; 037FA90C
	mov r7,#0x0	; 037FA910
loc_037FA914:
	cmp r4,r6	; 037FA914
	strcc r7,[r4],#0x4	; 037FA918
	bcc loc_037FA914	; 037FA91C
	b loc_037FA928	; 037FA920
pool_037FA924:
loc_037FA924:
	.word P2_CrtDataInitTable	; 037FA924
loc_037FA928:
	bx lr	; 037FA928

; ===== function loc_037FA92C =====
; Writes test values at 0x027FFFFA and reads 0x023FFFFA to distinguish the main-RAM mirror.
; 向 0x027FFFFA 写测试值并从 0x023FFFFA 回读，以区分主 RAM 镜像。
.func P2_TestMainRamMirror
loc_037FA92C:
	mov r0,#0x1	; 037FA92C
	mov r1,#0x0	; 037FA930
	ldr r2,[pool_037FA964]	; 037FA934
	sub r3,r2,#0x400000	; 037FA938
loc_037FA93C:
	strh r1,[r2,#0x0]	; 037FA93C
	ldrh r12,[r3,#0x0]	; 037FA940
	cmp r1,r12	; 037FA944
	movne r0,#0x2	; 037FA948
	bne loc_037FA95C	; 037FA94C
	add r1,r1,#0x1	; 037FA950
	cmp r1,#0x2	; 037FA954
	bne loc_037FA93C	; 037FA958
loc_037FA95C:
	strh r0,[r2,#0x0]	; 037FA95C
	bx lr	; 037FA960
.endfunc
pool_037FA964:
loc_037FA964:
	.word FirmwareSystemWorkAddress + SystemWorkArm7MemorySizeCheckOffset	; 037FA964

; Explicit ARM7 no-op retained in the bootstrap sequence.
; 启动序列中保留的显式 ARM7 空操作。
.func P2_NoOperation
loc_037FA968:
	bx lr	; 037FA968
.endfunc
.thumb

; ===== function loc_037FA96C =====
.func P2_InitializeBootProcedureCallbacks
; Fetch BIOS boot procedures, derive and store firmware callback pointers.
; 取得 BIOS 启动过程，推导并保存固件回调指针。
loc_037FA96C:
	swi 0x1d	; 037FA96C
	mov r8,r8	; 037FA96E
	ldr r2,[pool_037FA988]	; 037FA970
	ldr r2,[r2,#0x0]	; 037FA972
	eor r1,r2	; 037FA974
	ldr r2,[pool_037FA98C]	; 037FA976
	str r1,[r2,#0x0]	; 037FA978
	eor r1,r0	; 037FA97A
	ldr r2,[pool_037FA990]	; 037FA97C
	str r1,[r2,#0x0]	; 037FA97E
	eor r1,r3	; 037FA980
	ldr r2,[pool_037FA994]	; 037FA982
	str r1,[r2,#0x0]	; 037FA984
	bx lr	; 037FA986
.endfunc
pool_037FA988:
loc_037FA988:
	.word P2_Data_03805120	; 037FA988
pool_037FA98C:
loc_037FA98C:
	.word P2_BssStart + 0x10	; 037FA98C
pool_037FA990:
loc_037FA990:
	.word P2_BssStart + 0xC	; 037FA990
pool_037FA994:
loc_037FA994:
	.word P2_BssStart + 0x8	; 037FA994
.arm

; Waits for scanline 200, then enters the ARM7 BIOS AGB-mode procedure recovered via SVC_GetBootProcs.
; 等待扫描线 200 后，转入经 SVC_GetBootProcs 取得的 ARM7 BIOS AGB 模式过程。
.func P2_WaitVCount200ThenEnterAgbMode
	stmdb sp!,{lr}	; 037FA998
	sub sp,sp,#0x4	; 037FA99C
	ldr r0,[pool_037FA9D8]	; 037FA9A0
	ldr r2,[r0,#0x0]	; 037FA9A4
	mov r1,#0xa	; 037FA9A8
	ldr r0,[pool_037FA9DC]	; 037FA9AC
	str r1,[r0,#0x0]	; 037FA9B0
	ldr r1,[pool_037FA9E0]	; 037FA9B4
loc_037FA9B8:
	ldrh r0,[r1,#0x0]	; 037FA9B8
	cmp r0,#0xc8	; 037FA9BC
	bne loc_037FA9B8	; 037FA9C0
	mov lr,pc	; 037FA9C4
	bx r2	; 037FA9C8
	add sp,sp,#0x4	; 037FA9CC
	ldmia sp!,{lr}	; 037FA9D0
	bx lr	; 037FA9D4
.endfunc
pool_037FA9D8:
loc_037FA9D8:
	.word P2_BssStart + 0x8	; 037FA9D8
pool_037FA9DC:
loc_037FA9DC:
	.word FirmwareBootSharedAddress + BootSharedArm7StateOffset	; 037FA9DC
pool_037FA9E0:
loc_037FA9E0:
	.word REG_VCOUNT	; 037FA9E0
.thumb

; Resets ARM7 DMA, audio, display, SPI and IPC peripheral state before later boot work.
; 在后续启动工作前复位 ARM7 的 DMA、音频、显示、SPI 与 IPC 外设状态。
.func P2_ResetArm7Peripherals
loc_037FA9E4:
	push {r4,lr}	; 037FA9E4
	sub sp,#0x10	; 037FA9E6
	mov r0,#0x0	; 037FA9E8
	str r0,[sp,#0x0]	; 037FA9EA
	ldr r1,[pool_037FAA58]	; 037FA9EC
	add r0,sp,#0x0	; 037FA9EE
	ldr r2,[pool_037FAA5C]	; 037FA9F0
	sub r2,r2,r1	; 037FA9F2
	lsr r2,r2,#0x2	; 037FA9F4
	ldr r3,[pool_037FAA60]	; 037FA9F6
	and r2,r3	; 037FA9F8
	ldr r3,[pool_037FAA64]	; 037FA9FA
	orr r2,r3	; 037FA9FC
	bl P2_SwiCpuFastSet	; 037FA9FE
	mov r4,#0x0	; 037FAA02
loc_037FAA04:
	add r0,r4,#0x0	; 037FAA04
	bl loc_037FF238	; 037FAA06
	add r4,r4,#0x1	; 037FAA0A
	cmp r4,#0x3	; 037FAA0C
	ble loc_037FAA04	; 037FAA0E
	mov r0,#0x0	; 037FAA10
	str r0,[sp,#0x4]	; 037FAA12
	add r0,sp,#0x4	; 037FAA14
	ldr r1,[pool_037FAA68]	; 037FAA16
	ldr r2,[pool_037FAA6C]	; 037FAA18
	bl P2_SwiCpuFastSet	; 037FAA1A
	mov r0,#0x0	; 037FAA1E
	str r0,[sp,#0x8]	; 037FAA20
	add r0,sp,#0x8	; 037FAA22
	ldr r1,[pool_037FAA70]	; 037FAA24
	ldr r2,[pool_037FAA74]	; 037FAA26
	bl P2_SwiCpuFastSet	; 037FAA28
	mov r0,#0x0	; 037FAA2C
	str r0,[sp,#0xc]	; 037FAA2E
	add r0,sp,#0xc	; 037FAA30
	ldr r1,[pool_037FAA78]	; 037FAA32
	ldr r2,[pool_037FAA7C]	; 037FAA34
	bl P2_SwiCpuFastSet	; 037FAA36
	mov r2,#0x0	; 037FAA3A
	ldr r0,[pool_037FAA80]	; 037FAA3C
	strh r2,[r0,#0x0]	; 037FAA3E
	ldr r0,[pool_037FAA84]	; 037FAA40
	strh r2,[r0,#0x0]	; 037FAA42
	ldr r1,[pool_037FAA88]	; 037FAA44
	ldr r0,[pool_037FAA8C]	; 037FAA46
	strh r1,[r0,#0x0]	; 037FAA48
	mvn r0,r2	; 037FAA4A
	bl loc_037FDA94	; 037FAA4C
	add sp,#0x10	; 037FAA50
	pop {r4}	; 037FAA52
	pop {r3}	; 037FAA54
	bx r3	; 037FAA56
.endfunc
pool_037FAA58:
loc_037FAA58:
	.word 0x03807ADC	; 037FAA58
pool_037FAA5C:
loc_037FAA5C:
	.word P2_WramCopy1RuntimeStart	; 037FAA5C
pool_037FAA60:
loc_037FAA60:
	.word 0x001FFFFF	; 037FAA60
pool_037FAA64:
loc_037FAA64:
	.word 0x01000000	; 037FAA64
pool_037FAA68:
loc_037FAA68:
	.word REG_DMA0SAD	; 037FAA68
pool_037FAA6C:
loc_037FAA6C:
	.word 0x01000023	; 037FAA6C
pool_037FAA70:
loc_037FAA70:
	.word SCHANNEL0_CR	; 037FAA70
pool_037FAA74:
loc_037FAA74:
	.word 0x01000041	; 037FAA74
pool_037FAA78:
loc_037FAA78:
	.word REG_SNDCAP0CNT	; 037FAA78
pool_037FAA7C:
loc_037FAA7C:
	.word 0x01000005	; 037FAA7C
pool_037FAA80:
loc_037FAA80:
	.word REG_DISPSTAT	; 037FAA80
pool_037FAA84:
loc_037FAA84:
	.word REG_SPICNT	; 037FAA84
pool_037FAA88:
loc_037FAA88:
	.word 0x00004008	; 037FAA88
pool_037FAA8C:
loc_037FAA8C:
	.word REG_IPC_FIFO_CR	; 037FAA8C

; Pads a staged component with zeroes to the required 8-byte boundary.
; 以零填充暂存组件，使其满足所需的 8 字节边界。
.func P2_AlignStagingPointerTo8
loc_037FAA90:
	push {r4,r5,lr}	; 037FAA90
	sub sp,#0x4	; 037FAA92
	add r5,r0,#0x0	; 037FAA94
	ldr r0,[r5,#0x0]	; 037FAA96
	mov r1,#0x7	; 037FAA98
	add r2,r0,#0x0	; 037FAA9A
	and r2,r1	; 037FAA9C
	cmp r2,#0x0	; 037FAA9E
	beq loc_037FAAB4	; 037FAAA0
	mov r1,#0x8	; 037FAAA2
	sub r4,r1,r2	; 037FAAA4
	mov r1,#0x0	; 037FAAA6
	add r2,r4,#0x0	; 037FAAA8
	bl loc_037FAABC	; 037FAAAA
	ldr r0,[r5,#0x0]	; 037FAAAE
	add r0,r0,r4	; 037FAAB0
	str r0,[r5,#0x0]	; 037FAAB2
loc_037FAAB4:
	add sp,#0x4	; 037FAAB4
	pop {r4,r5}	; 037FAAB6
	pop {r3}	; 037FAAB8
	bx r3	; 037FAABA
.endfunc

; ===== function loc_037FAABC =====
loc_037FAABC:
	bx pc	; 037FAABC
	.byte 0xC0, 0x46	; 037FAAC0
.arm

; ===== function loc_037FAAC0 =====
loc_037FAAC0:
	ldr pc,[pool_037FAAC4]	; 037FAAC0
pool_037FAAC4:
loc_037FAAC4:
	.word loc_037FF41C	; 037FAAC4
.thumb

; Stages header-described firmware P3 and P4 consecutively for ARM9 boot.
; 将头部描述的固件 P3、P4 连续暂存，供 ARM9 启动使用。
.func P2_LoadSecondaryFirmwarePartsToStaging
loc_037FAAC8:
	push {r4,lr}	; 037FAAC8
	sub sp,#0x8	; 037FAACA
	ldr r1,[pool_037FAB40]	; 037FAACC
	ldrh r0,[r1,#0x0]	; 037FAACE
	lsl r0,r0,#0x3	; 037FAAD0
	ldrh r2,[r1,#0x2]	; 037FAAD2
	lsl r4,r2,#0x3	; 037FAAD4
	ldrh r2,[r1,#0x4]	; 037FAAD6
	ldr r1,[pool_037FAB44]	; 037FAAD8
	strh r2,[r1,#0x0]	; 037FAADA
	ldr r2,[pool_037FAB48]	; 037FAADC
	ldr r1,[pool_037FAB4C]	; 037FAADE
	str r2,[r1,#0x0]	; 037FAAE0
	mov r1,#0x1	; 037FAAE2
	str r1,[sp,#0x0]	; 037FAAE4
	ldr r1,[pool_037FAB50]	; 037FAAE6
	mov r2,#0x0	; 037FAAE8
	ldr r3,[pool_037FAB54]	; 037FAAEA
	bl P2_SubmitTransferRequest	; 037FAAEC
	ldr r0,[pool_037FAB58]	; 037FAAF0
	ldr r1,[r0,#0xc]	; 037FAAF2
	ldr r0,[pool_037FAB50]	; 037FAAF4
	add r1,r1,r0	; 037FAAF6
	ldr r0,[pool_037FAB5C]	; 037FAAF8
	str r1,[r0,#0x0]	; 037FAAFA
	bl P2_AlignStagingPointerTo8	; 037FAAFC
	ldr r0,[pool_037FAB5C]	; 037FAB00
	ldr r1,[r0,#0x0]	; 037FAB02
	mov r0,#0x1	; 037FAB04
	str r0,[sp,#0x0]	; 037FAB06
	add r0,r4,#0x0	; 037FAB08
	mov r2,#0x0	; 037FAB0A
	ldr r3,[pool_037FAB60]	; 037FAB0C
	sub r3,r3,r1	; 037FAB0E
	bl P2_SubmitTransferRequest	; 037FAB10
	ldr r0,[pool_037FAB5C]	; 037FAB14
	ldr r1,[r0,#0x0]	; 037FAB16
	ldr r0,[pool_037FAB58]	; 037FAB18
	ldr r0,[r0,#0xc]	; 037FAB1A
	add r1,r1,r0	; 037FAB1C
	ldr r0,[pool_037FAB64]	; 037FAB1E
	str r1,[r0,#0x0]	; 037FAB20
	bl P2_AlignStagingPointerTo8	; 037FAB22
	ldr r2,[pool_037FAB64]	; 037FAB26
	ldr r1,[r2,#0x0]	; 037FAB28
	ldr r0,[pool_037FAB5C]	; 037FAB2A
	ldr r0,[r0,#0x0]	; 037FAB2C
	sub r0,r1,r0	; 037FAB2E
	str r0,[r2,#0x0]	; 037FAB30
	ldr r0,[pool_037FAB68]	; 037FAB32
	bl P2_OrSharedEventFlags	; 037FAB34
	add sp,#0x8	; 037FAB38
	pop {r4}	; 037FAB3A
	pop {r3}	; 037FAB3C
	bx r3	; 037FAB3E
.endfunc
pool_037FAB40:
loc_037FAB40:
	.word P2_CachedFirmwareHeader	; 037FAB40
pool_037FAB44:
loc_037FAB44:
	.word FirmwareBootSharedAddress + BootSharedP3P4Crc16Offset	; 037FAB44
pool_037FAB48:
loc_037FAB48:
	.word P4_FirmwareServiceEntry	; 037FAB48
pool_037FAB4C:
loc_037FAB4C:
	.word FirmwareBootSharedAddress + BootSharedP4DestinationOffset	; 037FAB4C
pool_037FAB50:
loc_037FAB50:
	.word FirmwareComponentStagingAddress	; 037FAB50
pool_037FAB54:
loc_037FAB54:
	.word 0x00040000	; 037FAB54
pool_037FAB58:
loc_037FAB58:
	.word P2_BssStart + 0x18	; 037FAB58
pool_037FAB5C:
loc_037FAB5C:
	.word FirmwareBootSharedAddress + BootSharedP4StagingOffset	; 037FAB5C
pool_037FAB60:
loc_037FAB60:
	.word FirmwareComponentStagingLimit	; 037FAB60
pool_037FAB64:
loc_037FAB64:
	.word FirmwareBootSharedAddress + BootSharedP4StagedBytesOffset	; 037FAB64
pool_037FAB68:
loc_037FAB68:
	.word 0x00001000	; 037FAB68

; Stages header-described firmware P5 for the next ARM9 boot stage.
; 将头部描述的固件 P5 暂存，供下一 ARM9 启动阶段使用。
.func P2_LoadFirmwarePart5ToStaging
loc_037FAB6C:
	push {lr}	; 037FAB6C
	sub sp,#0x4	; 037FAB6E
	ldr r1,[pool_037FAB98]	; 037FAB70
	ldrh r0,[r1,#0x16]	; 037FAB72
	lsl r0,r0,#0x3	; 037FAB74
	ldrh r2,[r1,#0x26]	; 037FAB76
	ldr r1,[pool_037FAB9C]	; 037FAB78
	strh r2,[r1,#0x0]	; 037FAB7A
	mov r1,#0x1	; 037FAB7C
	str r1,[sp,#0x0]	; 037FAB7E
	ldr r1,[pool_037FABA0]	; 037FAB80
	mov r2,#0x0	; 037FAB82
	ldr r3,[pool_037FABA4]	; 037FAB84
	bl P2_SubmitTransferRequest	; 037FAB86
	ldr r0,[pool_037FABA8]	; 037FAB8A
	bl P2_OrSharedEventFlags	; 037FAB8C
	add sp,#0x4	; 037FAB90
	pop {r3}	; 037FAB92
	bx r3	; 037FAB94
.endfunc
	.byte 0xC0, 0x46	; 037FAB98
pool_037FAB98:
loc_037FAB98:
	.word P2_CachedFirmwareHeader	; 037FAB98
pool_037FAB9C:
loc_037FAB9C:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 037FAB9C
pool_037FABA0:
loc_037FABA0:
	.word FirmwareComponentStagingAddress	; 037FABA0
pool_037FABA4:
loc_037FABA4:
	.word 0x00040000	; 037FABA4
pool_037FABA8:
loc_037FABA8:
	.word 0x00002000	; 037FABA8

; Cache the SPI firmware header and publish header[0x20] * 8 as the settings address.
; 缓存 SPI 固件头，将头部 [0x20] * 8 发布为用户设置地址。
.func P2_LoadFirmwareHeaderAndSettingsOffset
loc_037FABAC:
	push {lr}	; 037FABAC
	sub sp,#0x4	; 037FABAE
	mov r0,#0x0	; 037FABB0
	str r0,[sp,#0x0]	; 037FABB2
	ldr r1,[pool_037FABD4]	; 037FABB4
	mov r2,#0x2c	; 037FABB6
	add r3,r2,#0x0	; 037FABB8
	bl P2_SubmitTransferRequest	; 037FABBA
	ldr r0,[pool_037FABD4]	; 037FABBE
	ldrh r1,[r0,#0x20]	; 037FABC0
	lsl r2,r1,#0x3	; 037FABC2
	ldr r1,[pool_037FABD8]	; 037FABC4
	str r2,[r1,#0x0]	; 037FABC6
	ldrb r1,[r0,#0x1d]	; 037FABC8
	ldr r0,[pool_037FABDC]	; 037FABCA
	strb r1,[r0,#0x0]	; 037FABCC
	add sp,#0x4	; 037FABCE
	pop {r3}	; 037FABD0
	bx r3	; 037FABD2
.endfunc
pool_037FABD4:
loc_037FABD4:
	.word P2_CachedFirmwareHeader	; 037FABD4
pool_037FABD8:
loc_037FABD8:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 037FABD8
pool_037FABDC:
loc_037FABDC:
	.word FirmwareBootSharedAddress + BootSharedConsoleTypeOffset	; 037FABDC

; ===== function P2_ClearMainRamOutsideArm9Image =====
; Clears the main-RAM ranges before and after the ARM9 image described by NDS header +0x28/+0x2C.
; 按 NDS 头 +0x28/+0x2C 所述 ARM9 映像，清零其前后两段主 RAM。
.func P2_ClearMainRamOutsideArm9Image
loc_037FABE0:
	push {lr}	; 037FABE0
	sub sp,#0xc	; 037FABE2
	ldr r1,[pool_037FAC38]	; 037FABE4
	ldr r0,[pool_037FAC3C]	; 037FABE6
	ldr r0,[r0,#0x0]	; 037FABE8
	cmp r0,r1	; 037FABEA
	bls loc_037FAC08	; 037FABEC
	sub r2,r0,r1	; 037FABEE
	cmp r2,#0x0	; 037FABF0
	beq loc_037FAC08	; 037FABF2
	mov r0,#0x0	; 037FABF4
	str r0,[sp,#0x0]	; 037FABF6
	add r0,sp,#0x0	; 037FABF8
	lsr r2,r2,#0x2	; 037FABFA
	ldr r3,[pool_037FAC40]	; 037FABFC
	and r2,r3	; 037FABFE
	ldr r3,[pool_037FAC44]	; 037FAC00
	orr r2,r3	; 037FAC02
	bl P2_SwiCpuFastSet	; 037FAC04
loc_037FAC08:
	ldr r0,[pool_037FAC3C]	; 037FAC08
	ldr r1,[r0,#0x0]	; 037FAC0A
	ldr r0,[pool_037FAC48]	; 037FAC0C
	ldr r0,[r0,#0x0]	; 037FAC0E
	add r1,r1,r0	; 037FAC10
	ldr r0,[pool_037FAC4C]	; 037FAC12
	cmp r1,r0	; 037FAC14
	bcs loc_037FAC32	; 037FAC16
	sub r2,r0,r1	; 037FAC18
	cmp r2,#0x0	; 037FAC1A
	beq loc_037FAC32	; 037FAC1C
	mov r0,#0x0	; 037FAC1E
	str r0,[sp,#0x4]	; 037FAC20
	add r0,sp,#0x4	; 037FAC22
	lsr r2,r2,#0x2	; 037FAC24
	ldr r3,[pool_037FAC40]	; 037FAC26
	and r2,r3	; 037FAC28
	ldr r3,[pool_037FAC44]	; 037FAC2A
	orr r2,r3	; 037FAC2C
	bl P2_SwiCpuFastSet	; 037FAC2E
loc_037FAC32:
	add sp,#0xc	; 037FAC32
	pop {r3}	; 037FAC34
	bx r3	; 037FAC36
.endfunc
pool_037FAC38:
loc_037FAC38:
	.word 0x02010000	; 037FAC38
pool_037FAC3C:
loc_037FAC3C:
	.word NdsCartHeaderArm9RamAddress	; 037FAC3C
pool_037FAC40:
loc_037FAC40:
	.word 0x001FFFFF	; 037FAC40
pool_037FAC44:
loc_037FAC44:
	.word 0x01000000	; 037FAC44
pool_037FAC48:
loc_037FAC48:
	.word NdsCartHeaderArm9SizeAddress	; 037FAC48
pool_037FAC4C:
loc_037FAC4C:
	.word 0x02300000	; 037FAC4C

; ===== function loc_037FAC50 =====
loc_037FAC50:
	push {lr}	; 037FAC50
	sub sp,#0x4	; 037FAC52
	add r0,sp,#0x0	; 037FAC54
	bl loc_03802904	; 037FAC56
	add r1,sp,#0x0	; 037FAC5A
	ldrh r2,[r1,#0x0]	; 037FAC5C
	mov r0,#0xf	; 037FAC5E
	bic r2,r0	; 037FAC60
	mov r0,#0x4	; 037FAC62
	orr r2,r0	; 037FAC64
	strh r2,[r1,#0x0]	; 037FAC66
	ldrh r2,[r1,#0x0]	; 037FAC68
	mov r0,#0x40	; 037FAC6A
	orr r2,r0	; 037FAC6C
	strh r2,[r1,#0x0]	; 037FAC6E
	add r0,sp,#0x0	; 037FAC70
	bl loc_038028E4	; 037FAC72
	ldr r0,[pool_037FACA0]	; 037FAC76
	bl loc_038029CC	; 037FAC78
	ldr r0,[pool_037FACA0]	; 037FAC7C
	bl loc_03802964	; 037FAC7E
	add r1,sp,#0x0	; 037FAC82
	ldrh r2,[r1,#0x0]	; 037FAC84
	mov r0,#0xf	; 037FAC86
	bic r2,r0	; 037FAC88
	strh r2,[r1,#0x0]	; 037FAC8A
	ldrh r2,[r1,#0x0]	; 037FAC8C
	mov r0,#0x40	; 037FAC8E
	bic r2,r0	; 037FAC90
	strh r2,[r1,#0x0]	; 037FAC92
	add r0,sp,#0x0	; 037FAC94
	bl loc_038028E4	; 037FAC96
	add sp,#0x4	; 037FAC9A
	pop {r3}	; 037FAC9C
	bx r3	; 037FAC9E
pool_037FACA0:
loc_037FACA0:
	.word 0x038053E4	; 037FACA0

; ===== function P2_SubmitTransferRequest =====
; Copies five transfer arguments into the shared descriptor, then dispatches the request to the transfer service.
; 将五个传输参数写入共享描述符，再把请求交给传输服务调度。
.func P2_SubmitTransferRequest
loc_037FACA4:
	push {r4,r5,lr}	; 037FACA4
	sub sp,#0x4	; 037FACA6
	ldr r5,[sp,#0x10]	; 037FACA8
	ldr r4,[pool_037FACC4]	; 037FACAA
	str r5,[r4,#0x0]	; 037FACAC
	str r0,[r4,#0x4]	; 037FACAE
	str r1,[r4,#0x8]	; 037FACB0
	str r2,[r4,#0xc]	; 037FACB2
	str r3,[r4,#0x10]	; 037FACB4
	ldr r0,[pool_037FACC8]	; 037FACB6
	bl loc_037FDF34	; 037FACB8
	add sp,#0x4	; 037FACBC
	pop {r4,r5}	; 037FACBE
	pop {r3}	; 037FACC0
	bx r3	; 037FACC2
.endfunc
pool_037FACC4:
loc_037FACC4:
	.word P2_BssStart + 0x18	; 037FACC4
pool_037FACC8:
loc_037FACC8:
	.word 0x03805434	; 037FACC8

; ===== function P2_RunTransferRequestServiceLoop =====
; Continuously services the transfer descriptor filled by P2_SubmitTransferRequest.
; 持续处理由 P2_SubmitTransferRequest 填入的传输描述符。
.func P2_RunTransferRequestServiceLoop
loc_037FACCC:
	push {r4,r5,r6,r7,lr}	; 037FACCC
	sub sp,#0x4	; 037FACCE
	mov r6,#0x0	; 037FACD0
	mov r7,#0x3	; 037FACD2
	ldr r4,[pool_037FAD20]	; 037FACD4
	ldr r5,[pool_037FAD24]	; 037FACD6
loc_037FACD8:
	ldr r0,[r5,#0x0]	; 037FACD8
	bl loc_03802F8C	; 037FACDA
	ldr r0,[r4,#0x0]	; 037FACDE
	cmp r0,#0x0	; 037FACE0
	beq loc_037FAD08	; 037FACE2
	str r6,[r4,#0xc]	; 037FACE4
	ldr r0,[r4,#0x4]	; 037FACE6
	add r1,r7,#0x0	; 037FACE8
	ldr r2,[pool_037FAD28]	; 037FACEA
	bl loc_03803F9C	; 037FACEC
	ldr r0,[r4,#0xc]	; 037FACF0
	lsr r1,r0,#0x2	; 037FACF2
	str r1,[r4,#0xc]	; 037FACF4
	ldr r0,[r4,#0x10]	; 037FACF6
	cmp r1,r0	; 037FACF8
	bls loc_037FACFE	; 037FACFA
loc_037FACFC:
	b loc_037FACFC	; 037FACFC
loc_037FACFE:
	ldr r0,[r4,#0x4]	; 037FACFE
	ldr r2,[r4,#0x8]	; 037FAD00
	bl loc_03803F9C	; 037FAD02
	b loc_037FAD12	; 037FAD06
loc_037FAD08:
	ldr r0,[r4,#0x4]	; 037FAD08
	ldr r1,[r4,#0xc]	; 037FAD0A
	ldr r2,[r4,#0x8]	; 037FAD0C
	bl loc_03803F9C	; 037FAD0E
loc_037FAD12:
	ldr r0,[r5,#0x0]	; 037FAD12
	bl loc_03802F44	; 037FAD14
	add r0,r6,#0x0	; 037FAD18
	bl loc_037FDFA0	; 037FAD1A
	b loc_037FACD8	; 037FAD1E
.endfunc
pool_037FAD20:
loc_037FAD20:
	.word 0x038053F8	; 037FAD20
pool_037FAD24:
loc_037FAD24:
	.word P2_BssStart + 0x14	; 037FAD24
pool_037FAD28:
loc_037FAD28:
	.word 0x03805404	; 037FAD28

; ===== function loc_037FAD2C =====
P2_IrqHandler_037FAD2C:
	push {lr}	; 037FAD2C
	sub sp,#0x4	; 037FAD2E
	ldr r0,[pool_037FAD4C]	; 037FAD30
	ldr r0,[r0,#0x0]	; 037FAD32
	cmp r0,#0x0	; 037FAD34
	beq loc_037FAD3C	; 037FAD36
	bl loc_0380481C	; 037FAD38
loc_037FAD3C:
	ldr r2,[pool_037FAD50]	; 037FAD3C
	ldr r1,[r2,#0x0]	; 037FAD3E
	mov r0,#0x1	; 037FAD40
	orr r1,r0	; 037FAD42
	str r1,[r2,#0x0]	; 037FAD44
	add sp,#0x4	; 037FAD46
	pop {r3}	; 037FAD48
	bx r3	; 037FAD4A
pool_037FAD4C:
loc_037FAD4C:
	.word P2_BssStart + 0x26A0	; 037FAD4C
pool_037FAD50:
loc_037FAD50:
	.word Bios7IrqFlagsAddress	; 037FAD50
; 通道 1 的用户回调：将主工作区的首字写为 6。
; Channel 1 user callback: write 6 to the first main-work word.
.func P2_PxiChannel1UserCallback
	mov r1,#0x6	; 037FAD54
	ldr r0,[pool_037FAD5C]	; 037FAD56
	str r1,[r0,#0x0]	; 037FAD58
	bx lr	; 037FAD5A
.endfunc
pool_037FAD5C:
loc_037FAD5C:
	.word P2_BssStart	; 037FAD5C
P2_PxiCallback_037FAD60:
	cmp r1,#0x3	; 037FAD60
	bne loc_037FAD6C	; 037FAD62
	mov r1,#0x6	; 037FAD64
	ldr r0,[pool_037FAD90]	; 037FAD66
	str r1,[r0,#0x0]	; 037FAD68
	bx lr	; 037FAD6A
loc_037FAD6C:
	cmp r1,#0x6	; 037FAD6C
	bne loc_037FAD78	; 037FAD6E
	mov r1,#0x5	; 037FAD70
	ldr r0,[pool_037FAD90]	; 037FAD72
	str r1,[r0,#0x0]	; 037FAD74
	bx lr	; 037FAD76
loc_037FAD78:
	cmp r1,#0x4	; 037FAD78
	bne loc_037FAD84	; 037FAD7A
	mov r1,#0x9	; 037FAD7C
	ldr r0,[pool_037FAD90]	; 037FAD7E
	str r1,[r0,#0x0]	; 037FAD80
	bx lr	; 037FAD82
loc_037FAD84:
	cmp r1,#0x7	; 037FAD84
	bne loc_037FAD8E	; 037FAD86
	mov r1,#0x8	; 037FAD88
	ldr r0,[pool_037FAD90]	; 037FAD8A
	str r1,[r0,#0x0]	; 037FAD8C
loc_037FAD8E:
	bx lr	; 037FAD8E
pool_037FAD90:
loc_037FAD90:
	.word P2_BssStart	; 037FAD90

; ===== function P2_OrSharedEventFlags =====
; ORs caller-supplied flags into the guarded shared event field.
; 在受保护的共享事件字段中合并调用方提供的标志位。
.func P2_OrSharedEventFlags
loc_037FAD94:
	push {r4,lr}	; 037FAD94
	add r4,r0,#0x0	; 037FAD96
	mov r0,#0xae	; 037FAD98
	ldr r1,[pool_037FADB8]	; 037FAD9A
	mov r2,#0x0	; 037FAD9C
	bl loc_037FDDD8	; 037FAD9E
	ldr r1,[pool_037FADB8]	; 037FADA2
	ldr r0,[r1,#0x8]	; 037FADA4
	orr r0,r4	; 037FADA6
	str r0,[r1,#0x8]	; 037FADA8
	mov r0,#0xae	; 037FADAA
	mov r2,#0x0	; 037FADAC
	bl loc_037FDD64	; 037FADAE
	pop {r4}	; 037FADB2
	pop {r3}	; 037FADB4
	bx r3	; 037FADB6
.endfunc
pool_037FADB8:
loc_037FADB8:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 037FADB8
; Initializes hardware and drives the cartridge/firmware boot transfer states.
; 初始化硬件，并驱动卡带／固件启动传输状态。
P2_RunBootTransferStateMachine:
loc_037FADBC:
	push {r4,r5,r6,r7,lr}	; 037FADBC
	sub sp,#0xc	; 037FADBE
	mov r0,#0x0	; 037FADC0
	str r0,[sp,#0x8]	; 037FADC2
	add r0,sp,#0x8	; 037FADC4
	ldr r1,[pool_037FAFB0]	; 037FADC6
	ldr r2,[pool_037FAFB4]	; 037FADC8
	bl P2_SwiCpuFastSet	; 037FADCA
	ldr r1,[pool_037FAFB8]	; 037FADCE
; 锁定 Lite 扩展寄存器；写入值保持 FFFF。
; Lock the Lite extension registers; retain the original FFFF write.
	ldr r0,[pool_037FAFBC]	; 037FADD0
	strh r1,[r0,#0x0]	; 037FADD2
	ldr r0,[pool_037FAFC0]	; 037FADD4
	ldr r2,[pool_037FAFC4]	; 037FADD6
	strh r0,[r2,#0x0]	; 037FADD8
	mov r1,#0x0	; 037FADDA
	ldr r0,[pool_037FAFC8]	; 037FADDC
	str r1,[r0,#0x0]	; 037FADDE
	str r1,[r2,#0x0]	; 037FADE0
	mov r0,#0x1	; 037FADE2
	bl loc_0380447C	; 037FADE4
	mov r1,#0x1	; 037FADE8
	ldr r0,[pool_037FAFCC]	; 037FADEA
	strh r1,[r0,#0x0]	; 037FADEC
	mov r0,#0x10	; 037FADEE
	bl loc_03804942	; 037FADF0
	bl loc_037FAC50	; 037FADF4
	bl loc_037FE4D8	; 037FADF8
	ldr r0,[pool_037FAFD0]	; 037FADFC
	bl P2_InitPxiChannel1Callback	; 037FADFE
	bl loc_037FB064	; 037FAE02
	mov r0,#0x8	; 037FAE06
	ldr r1,[pool_037FAFD4]	; 037FAE08
	bl loc_037FE504	; 037FAE0A
	mov r0,#0x8	; 037FAE0E
	ldr r1,[pool_037FAFD8]	; 037FAE10
	bl loc_037FE510	; 037FAE12
	bl loc_03802130	; 037FAE16
	mov r0,#0x2	; 037FAE1A
	bl loc_03802FD4	; 037FAE1C
	mov r0,#0x3	; 037FAE20
	bl loc_037FFAF0	; 037FAE22
	mov r0,#0x8	; 037FAE26
	bl loc_0380258C	; 037FAE28
	bl loc_037FB040	; 037FAE2C
	ldr r1,[pool_037FAFDC]	; 037FAE30
	str r0,[r1,#0x0]	; 037FAE32
	mov r0,#0x2	; 037FAE34
	ldr r1,[pool_037FAFE0]	; 037FAE36
	bl P2_SetPxiReceiveCallback	; 037FAE38
	ldr r0,[pool_037FAFE4]	; 037FAE3C
	str r0,[sp,#0x0]	; 037FAE3E
	mov r0,#0xe	; 037FAE40
	str r0,[sp,#0x4]	; 037FAE42
	ldr r0,[pool_037FAFE8]	; 037FAE44
	ldr r1,[pool_037FAFEC]	; 037FAE46
	mov r2,#0x0	; 037FAE48
	ldr r3,[pool_037FAFF0]	; 037FAE4A
	bl P2_CreateThread	; 037FAE4C
	bl P2_InitializeBootProcedureCallbacks	; 037FAE50
	ldr r0,[pool_037FAFF4]	; 037FAE54
	ldr r1,[pool_037FAFF8]	; 037FAE56
	ldr r1,[r1,#0x0]	; 037FAE58
	bl loc_037FDB68	; 037FAE5A
	mov r0,#0x1	; 037FAE5E
	ldr r1,[pool_037FAFFC]	; 037FAE60
	bl loc_037FDB68	; 037FAE62
	mov r0,#0x1	; 037FAE66
	bl loc_037FDAE4	; 037FAE68
	bl loc_037FB04C	; 037FAE6C
	ldr r2,[pool_037FB000]	; 037FAE70
	ldrh r0,[r2,#0x0]	; 037FAE72
	ldrh r1,[r2,#0x0]	; 037FAE74
	mov r0,#0x8	; 037FAE76
	orr r1,r0	; 037FAE78
	strh r1,[r2,#0x0]	; 037FAE7A
	ldr r1,[pool_037FB004]	; 037FAE7C
	ldrh r0,[r1,#0x0]	; 037FAE7E
	mov r0,#0x1	; 037FAE80
	strh r0,[r1,#0x0]	; 037FAE82
	bl P2_LoadFirmwareHeaderAndSettingsOffset	; 037FAE84
	bl P2_LoadFirmwarePart5ToStaging	; 037FAE88
	mov r0,#0x3	; 037FAE8C
	ldr r5,[pool_037FB008]	; 037FAE8E
	str r0,[r5,#0x0]	; 037FAE90
	ldr r7,[pool_037FB00C]	; 037FAE92
	mov r6,#0x2	; 037FAE94
	ldr r4,[pool_037FB010]	; 037FAE96
loc_037FAE98:
	mov r0,#0x1	; 037FAE98
	lsl r1,r0,#0	; 037FAE9A
	bl loc_037FF1BC	; 037FAE9C
	ldr r0,[r4,#0x24]	; 037FAEA0
	cmp r0,#0x3	; 037FAEA2
	bne loc_037FAED6	; 037FAEA4
	ldr r1,[r7,#0x0]	; 037FAEA6
	ldr r0,[pool_037FB014]	; 037FAEA8
	and r1,r0	; 037FAEAA
	cmp r1,#0x0	; 037FAEAC
	beq loc_037FAE98	; 037FAEAE
	ldr r0,[r7,#0x0]	; 037FAEB0
	and r0,r6	; 037FAEB2
	cmp r0,#0x0	; 037FAEB4
	beq loc_037FAED2	; 037FAEB6
	ldr r1,[r7,#0x0]	; 037FAEB8
	mov r0,#0x4	; 037FAEBA
	and r1,r0	; 037FAEBC
	cmp r1,#0x0	; 037FAEBE
	bne loc_037FAED2	; 037FAEC0
	bl P2_ClearMainRamOutsideArm9Image	; 037FAEC2
	mov r0,#0xac	; 037FAEC6
	bl loc_037FDCC0	; 037FAEC8
	mov r0,#0x4	; 037FAECC
	str r0,[r5,#0x0]	; 037FAECE
	b loc_037FAE98	; 037FAED0
loc_037FAED2:
	str r6,[r5,#0x0]	; 037FAED2
	b loc_037FAE98	; 037FAED4
loc_037FAED6:
	ldr r0,[r4,#0x24]	; 037FAED6
	cmp r0,#0x4	; 037FAED8
	bne loc_037FAEFC	; 037FAEDA
	ldr r0,[pool_037FB018]	; 037FAEDC
	ldr r0,[r0,#0x0]	; 037FAEDE
	bl loc_038050CC	; 037FAEE0
	mov r1,#0x1	; 037FAEE4
	mvn r1,r1	; 037FAEE6
	cmp r0,r1	; 037FAEE8
	bne loc_037FAE98	; 037FAEEA
	mov r0,#0xac	; 037FAEEC
	bl loc_037FDBF4	; 037FAEEE
	ldr r0,[pool_037FB01C]	; 037FAEF2
	bl P2_OrSharedEventFlags	; 037FAEF4
	str r6,[r5,#0x0]	; 037FAEF8
	b loc_037FAE98	; 037FAEFA
loc_037FAEFC:
	ldr r0,[r4,#0x24]	; 037FAEFC
	cmp r0,#0x2	; 037FAEFE
	beq loc_037FAF08	; 037FAF00
	ldr r0,[r4,#0x24]	; 037FAF02
	cmp r0,#0x7	; 037FAF04
	bne loc_037FAF1A	; 037FAF06
loc_037FAF08:
	ldr r0,[pool_037FB020]	; 037FAF08
	ldr r0,[r0,#0x0]	; 037FAF0A
	cmp r0,#0x0	; 037FAF0C
	beq loc_037FAE98	; 037FAF0E
	str r0,[r5,#0x0]	; 037FAF10
	mov r1,#0x0	; 037FAF12
	ldr r0,[pool_037FB020]	; 037FAF14
	str r1,[r0,#0x0]	; 037FAF16
	b loc_037FAE98	; 037FAF18
loc_037FAF1A:
	ldr r0,[r4,#0x24]	; 037FAF1A
	cmp r0,#0x6	; 037FAF1C
	bne loc_037FAF44	; 037FAF1E
	ldr r0,[pool_037FB024]	; 037FAF20
	ldr r0,[r0,#0x0]	; 037FAF22
	cmp r0,#0x7	; 037FAF24
	bne loc_037FAE98	; 037FAF26
	ldr r1,[pool_037FB004]	; 037FAF28
	ldrh r0,[r1,#0x0]	; 037FAF2A
	mov r0,#0x0	; 037FAF2C
	strh r0,[r1,#0x0]	; 037FAF2E
	bl loc_037FDB10	; 037FAF30
	bl P2_ApplyPatternSelectedRuntimePatch	; 037FAF34
	bl P2_ResetArm7Peripherals	; 037FAF38
	ldr r1,[pool_037FB028]	; 037FAF3C
	ldr r0,[pool_037FB02C]	; 037FAF3E
	strh r1,[r0,#0x0]	; 037FAF40
	b loc_037FAFA6	; 037FAF42
loc_037FAF44:
	ldr r0,[r4,#0x24]	; 037FAF44
	cmp r0,#0x5	; 037FAF46
	bne loc_037FAF54	; 037FAF48
	bl P2_LoadSecondaryFirmwarePartsToStaging	; 037FAF4A
	mov r0,#0x7	; 037FAF4E
	str r0,[r5,#0x0]	; 037FAF50
	b loc_037FAE98	; 037FAF52
loc_037FAF54:
	ldr r0,[r4,#0x24]	; 037FAF54
	cmp r0,#0x8	; 037FAF56
	bne loc_037FAF70	; 037FAF58
	mov r1,#0x6	; 037FAF5A
; 启动状态 8 路径在私有源区写入 6；发布时此字段会被另行覆盖。
; Boot state 8 writes 6 to this private slot; publication later replaces the field.
	ldr r0,[pool_037FB030]	; 037FAF5C
	strh r1,[r0,#0x0]	; 037FAF5E
	ldr r0,[pool_037FB018]	; 037FAF60
	ldr r0,[r0,#0x0]	; 037FAF62
	bl loc_038050CC	; 037FAF64
	bl loc_037FB058	; 037FAF68
	str r6,[r5,#0x0]	; 037FAF6C
	b loc_037FAE98	; 037FAF6E
loc_037FAF70:
	ldr r0,[r4,#0x24]	; 037FAF70
	cmp r0,#0x9	; 037FAF72
	bne loc_037FAE98	; 037FAF74
	ldr r0,[pool_037FB024]	; 037FAF76
	ldr r0,[r0,#0x0]	; 037FAF78
	cmp r0,#0x9	; 037FAF7A
	bne loc_037FAE98	; 037FAF7C
	ldr r0,[pool_037FB004]	; 037FAF7E
	ldrh r0,[r0,#0x0]	; 037FAF80
	mov r1,#0x0	; 037FAF82
	ldr r0,[pool_037FB004]	; 037FAF84
	strh r1,[r0,#0x0]	; 037FAF86
	ldr r0,[pool_037FB034]	; 037FAF88
	ldr r1,[pool_037FB038]	; 037FAF8A
	ldr r2,[pool_037FB03C]	; 037FAF8C
	bl P2_SwiCpuFastSet	; 037FAF8E
	mov r0,#0x10	; 037FAF92
	bl loc_0380494A	; 037FAF94
	ldr r0,[pool_037FAFC0]	; 037FAF98
	bl loc_0380491C	; 037FAF9A
	ldr r0,[pool_037FB038]	; 037FAF9E
	bl loc_038050CC	; 037FAFA0
	b loc_037FAE98	; 037FAFA4
loc_037FAFA6:
	add sp,#0xc	; 037FAFA6
	pop {r4,r5,r6,r7}	; 037FAFA8
	pop {r3}	; 037FAFAA
	bx r3	; 037FAFAC
	.byte 0xC0, 0x46	; 037FAFB0
pool_037FAFB0:
loc_037FAFB0:
	.word 0x023FE800	; 037FAFB0
pool_037FAFB4:
loc_037FAFB4:
	.word 0x01000200	; 037FAFB4
pool_037FAFB8:
loc_037FAFB8:
	.word 0x0000FFFF	; 037FAFB8
pool_037FAFBC:
loc_037FAFBC:
	.word REG_NITRO2_REGCNT	; 037FAFBC
pool_037FAFC0:
loc_037FAFC0:
	.word 0x00001000	; 037FAFC0
pool_037FAFC4:
loc_037FAFC4:
	.word REG_SIOCNT_ARM7	; 037FAFC4
pool_037FAFC8:
loc_037FAFC8:
	.word REG_SIODATA32_ARM7	; 037FAFC8
pool_037FAFCC:
loc_037FAFCC:
	.word REG_POWERCNT	; 037FAFCC
pool_037FAFD0:
loc_037FAFD0:
	.word P2_PxiChannel1UserCallback + 1	; 037FAFD0
pool_037FAFD4:
loc_037FAFD4:
	.word 0x03807ADC	; 037FAFD4
pool_037FAFD8:
loc_037FAFD8:
	.word P2_WramCopy1RuntimeStart	; 037FAFD8
pool_037FAFDC:
loc_037FAFDC:
	.word P2_BssStart + 0x14	; 037FAFDC
pool_037FAFE0:
loc_037FAFE0:
	.word P2_PxiCallback_037FAD60 + 1	; 037FAFE0
pool_037FAFE4:
loc_037FAFE4:
	.word 0x00000400	; 037FAFE4
pool_037FAFE8:
loc_037FAFE8:
	.word 0x03805434	; 037FAFE8
pool_037FAFEC:
loc_037FAFEC:
	.word P2_RunTransferRequestServiceLoop + 1	; 037FAFEC
pool_037FAFF0:
loc_037FAFF0:
	.word 0x038058AC	; 037FAFF0
pool_037FAFF4:
loc_037FAFF4:
	.word 0x00080000	; 037FAFF4
pool_037FAFF8:
loc_037FAFF8:
	.word P2_BssStart + 0x10	; 037FAFF8
pool_037FAFFC:
loc_037FAFFC:
	.word P2_IrqHandler_037FAD2C + 1	; 037FAFFC
pool_037FB000:
loc_037FB000:
	.word REG_DISPSTAT	; 037FB000
pool_037FB004:
loc_037FB004:
	.word REG_IME	; 037FB004
pool_037FB008:
loc_037FB008:
	.word FirmwareBootSharedAddress + BootSharedArm7StateOffset	; 037FB008
pool_037FB00C:
loc_037FB00C:
	.word 0x027FF890	; 037FB00C
pool_037FB010:
loc_037FB010:
	.word 0x027FF860	; 037FB010
pool_037FB014:
loc_037FB014:
	.word 0x20000000	; 037FB014
pool_037FB018:
loc_037FB018:
	.word P2_BssStart + 0xC	; 037FB018
pool_037FB01C:
loc_037FB01C:
	.word 0x00000200	; 037FB01C
pool_037FB020:
loc_037FB020:
	.word P2_BssStart	; 037FB020
pool_037FB024:
loc_037FB024:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 037FB024
pool_037FB028:
loc_037FB028:
	.word 0x00002100	; 037FB028
pool_037FB02C:
loc_037FB02C:
	.word REG_IPC_SYNC	; 037FB02C
pool_037FB030:
loc_037FB030:
	.word FirmwareBootInfoScratchAddress + 0x10	; 037FB030
pool_037FB034:
loc_037FB034:
	.word P2_WaitVCount200ThenEnterAgbMode	; 037FB034
pool_037FB038:
loc_037FB038:
	.word P2_WramCopy0RuntimeStart	; 037FB038
pool_037FB03C:
loc_037FB03C:
	.word 0x00000100	; 037FB03C

; ===== function loc_037FB040 =====
loc_037FB040:
	bx pc	; 037FB040
	.byte 0xC0, 0x46	; 037FB044
.arm

; ===== function loc_037FB044 =====
loc_037FB044:
	ldr pc,[pool_037FB048]	; 037FB044
pool_037FB048:
loc_037FB048:
	.word loc_037FDBFC	; 037FB048
.thumb

; ===== function loc_037FB04C =====
loc_037FB04C:
	bx pc	; 037FB04C
	.byte 0xC0, 0x46	; 037FB050
.arm

; ===== function loc_037FB050 =====
loc_037FB050:
	ldr pc,[pool_037FB054]	; 037FB050
pool_037FB054:
loc_037FB054:
	.word loc_037FF144	; 037FB054
.thumb

; ===== function loc_037FB058 =====
loc_037FB058:
	bx pc	; 037FB058
	.byte 0xC0, 0x46	; 037FB05C
.arm

; ===== function loc_037FB05C =====
loc_037FB05C:
	ldr pc,[pool_037FB060]	; 037FB05C
pool_037FB060:
loc_037FB060:
	.word P4_InitializeRuntimeContext	; 037FB060
.thumb

; ===== function loc_037FB064 =====
loc_037FB064:
	push {lr}	; 037FB064
	sub sp,#0xc	; 037FB066
	bl loc_037FB2C8	; 037FB068
	cmp r0,#0x0	; 037FB06C
	bne loc_037FB074	; 037FB06E
	mov r0,#0x0	; 037FB070
	b loc_037FB0AC	; 037FB072
loc_037FB074:
	ldr r2,[pool_037FB0B4]	; 037FB074
	ldrh r1,[r2,#0x0]	; 037FB076
	mov r0,#0x2	; 037FB078
	orr r1,r0	; 037FB07A
	strh r1,[r2,#0x0]	; 037FB07C
	mov r1,#0x30	; 037FB07E
	ldr r0,[pool_037FB0B8]	; 037FB080
	strh r1,[r0,#0x0]	; 037FB082
	add r0,sp,#0x0	; 037FB084
	bl loc_037FB21C	; 037FB086
	bl loc_037FB378	; 037FB08A
	bl loc_037FB1DC	; 037FB08E
	add r0,sp,#0x0	; 037FB092
	bl loc_037FB1C0	; 037FB094
	add r0,sp,#0x0	; 037FB098
	ldrh r0,[r0,#0x0]	; 037FB09A
	bl loc_037FB330	; 037FB09C
	ldr r2,[pool_037FB0B4]	; 037FB0A0
	ldrh r1,[r2,#0x0]	; 037FB0A2
	mov r0,#0x2	; 037FB0A4
	bic r1,r0	; 037FB0A6
	strh r1,[r2,#0x0]	; 037FB0A8
	mov r0,#0x1	; 037FB0AA
loc_037FB0AC:
	add sp,#0xc	; 037FB0AC
	pop {r3}	; 037FB0AE
	bx r3	; 037FB0B0
	.byte 0xC0, 0x46	; 037FB0B4
pool_037FB0B4:
loc_037FB0B4:
	.word REG_POWERCNT	; 037FB0B4
pool_037FB0B8:
loc_037FB0B8:
	.word REG_WIFIWAITCNT_ARM7	; 037FB0B8

; ===== function loc_037FB0BC =====
loc_037FB0BC:
	push {r4,r5,lr}	; 037FB0BC
	sub sp,#0x4	; 037FB0BE
	mov r5,#0x2	; 037FB0C0
	str r5,[sp,#0x0]	; 037FB0C2
	add r4,sp,#0x0	; 037FB0C4
	b loc_037FB0CE	; 037FB0C6
loc_037FB0C8:
	add r0,r4,#0x0	; 037FB0C8
	bl loc_03804098	; 037FB0CA
loc_037FB0CE:
	ldr r0,[sp,#0x0]	; 037FB0CE
	and r0,r5	; 037FB0D0
	cmp r0,#0x0	; 037FB0D2
	bne loc_037FB0C8	; 037FB0D4
	add sp,#0x4	; 037FB0D6
	pop {r4,r5}	; 037FB0D8
	pop {r3}	; 037FB0DA
	bx r3	; 037FB0DC
	.byte 0x00, 0x00	; 037FB0E0

; ===== function loc_037FB0E0 =====
loc_037FB0E0:
	push {r4,r5,r6,lr}	; 037FB0E0
	add r5,r0,#0x0	; 037FB0E2
	add r4,r1,#0x0	; 037FB0E4
	add r6,r2,#0x0	; 037FB0E6
	bl loc_037FB0BC	; 037FB0E8
	add r0,r5,#0x0	; 037FB0EC
	add r1,r4,#0x0	; 037FB0EE
	add r2,r6,#0x0	; 037FB0F0
	bl loc_03803F9C	; 037FB0F2
	pop {r4,r5,r6}	; 037FB0F6
	pop {r3}	; 037FB0F8
	bx r3	; 037FB0FA

; ===== function loc_037FB0FC =====
loc_037FB0FC:
	ldr r0,[pool_037FB114]	; 037FB0FC
	ldr r2,[pool_037FB118]	; 037FB0FE
	mov r1,#0x1	; 037FB100
	b loc_037FB10E	; 037FB102
loc_037FB104:
	ldrh r3,[r2,#0x0]	; 037FB104
	and r3,r1	; 037FB106
	cmp r3,#0x0	; 037FB108
	beq loc_037FB112	; 037FB10A
	sub r0,r0,#0x1	; 037FB10C
loc_037FB10E:
	cmp r0,#0x0	; 037FB10E
	bne loc_037FB104	; 037FB110
loc_037FB112:
	bx lr	; 037FB112
pool_037FB114:
loc_037FB114:
	.word 0x00002000	; 037FB114
pool_037FB118:
loc_037FB118:
	.word REG_WIFI_RF_BUSY	; 037FB118

; ===== function loc_037FB11C =====
loc_037FB11C:
	push {r4,lr}	; 037FB11C
	add r4,r0,#0x0	; 037FB11E
	bl loc_037FB0FC	; 037FB120
	ldr r0,[pool_037FB138]	; 037FB124
	strh r4,[r0,#0x0]	; 037FB126
	lsr r1,r4,#0x10	; 037FB128
	ldr r0,[pool_037FB13C]	; 037FB12A
	strh r1,[r0,#0x0]	; 037FB12C
	bl loc_037FB0FC	; 037FB12E
	pop {r4}	; 037FB132
	pop {r3}	; 037FB134
	bx r3	; 037FB136
pool_037FB138:
loc_037FB138:
	.word REG_WIFI_RF_DATA1	; 037FB138
pool_037FB13C:
loc_037FB13C:
	.word REG_WIFI_RF_DATA2	; 037FB13C

; ===== function loc_037FB140 =====
loc_037FB140:
	ldr r0,[pool_037FB158]	; 037FB140
	ldr r2,[pool_037FB15C]	; 037FB142
	mov r1,#0x1	; 037FB144
	b loc_037FB152	; 037FB146
loc_037FB148:
	ldrh r3,[r2,#0x0]	; 037FB148
	and r3,r1	; 037FB14A
	cmp r3,#0x0	; 037FB14C
	beq loc_037FB156	; 037FB14E
	sub r0,r0,#0x1	; 037FB150
loc_037FB152:
	cmp r0,#0x0	; 037FB152
	bne loc_037FB148	; 037FB154
loc_037FB156:
	bx lr	; 037FB156
pool_037FB158:
loc_037FB158:
	.word 0x00002000	; 037FB158
pool_037FB15C:
loc_037FB15C:
	.word REG_WIFI_BB_BUSY	; 037FB15C

; ===== function loc_037FB160 =====
loc_037FB160:
	push {r4,r5,lr}	; 037FB160
	sub sp,#0x4	; 037FB162
	add r5,r0,#0x0	; 037FB164
	add r4,r1,#0x0	; 037FB166
	bl loc_037FB140	; 037FB168
	ldr r0,[pool_037FB188]	; 037FB16C
	strh r4,[r0,#0x0]	; 037FB16E
	ldr r0,[pool_037FB18C]	; 037FB170
	orr r5,r0	; 037FB172
	ldr r0,[pool_037FB190]	; 037FB174
	strh r5,[r0,#0x0]	; 037FB176
	bl loc_037FB140	; 037FB178
	mov r0,#0x0	; 037FB17C
	add sp,#0x4	; 037FB17E
	pop {r4,r5}	; 037FB180
	pop {r3}	; 037FB182
	bx r3	; 037FB184
	.byte 0xC0, 0x46	; 037FB188
pool_037FB188:
loc_037FB188:
	.word REG_WIFI_BB_WRITE	; 037FB188
pool_037FB18C:
loc_037FB18C:
	.word 0x00005000	; 037FB18C
pool_037FB190:
loc_037FB190:
	.word REG_WIFI_BB_CNT	; 037FB190

; ===== function loc_037FB194 =====
loc_037FB194:
	push {r4,lr}	; 037FB194
	add r4,r0,#0x0	; 037FB196
	bl loc_037FB140	; 037FB198
	ldr r0,[pool_037FB1B4]	; 037FB19C
	orr r4,r0	; 037FB19E
	ldr r0,[pool_037FB1B8]	; 037FB1A0
	strh r4,[r0,#0x0]	; 037FB1A2
	bl loc_037FB140	; 037FB1A4
	ldr r0,[pool_037FB1BC]	; 037FB1A8
	ldrh r0,[r0,#0x0]	; 037FB1AA
	pop {r4}	; 037FB1AC
	pop {r3}	; 037FB1AE
	bx r3	; 037FB1B0
	.byte 0xC0, 0x46	; 037FB1B4
pool_037FB1B4:
loc_037FB1B4:
	.word 0x00006000	; 037FB1B4
pool_037FB1B8:
loc_037FB1B8:
	.word REG_WIFI_BB_CNT	; 037FB1B8
pool_037FB1BC:
loc_037FB1BC:
	.word REG_WIFI_BB_READ	; 037FB1BC

; ===== function loc_037FB1C0 =====
loc_037FB1C0:
	ldrh r2,[r0,#0x2]	; 037FB1C0
	lsr r1,r2,#0x7	; 037FB1C2
	lsl r3,r1,#0x8	; 037FB1C4
	mov r1,#0x7f	; 037FB1C6
	and r2,r1	; 037FB1C8
	strh r2,[r0,#0x2]	; 037FB1CA
	ldrh r0,[r0,#0x2]	; 037FB1CC
	orr r3,r0	; 037FB1CE
	ldr r0,[pool_037FB1D8]	; 037FB1D0
	strh r3,[r0,#0x0]	; 037FB1D2
	bx lr	; 037FB1D4
	.byte 0xC0, 0x46	; 037FB1D8
pool_037FB1D8:
loc_037FB1D8:
	.word REG_WIFI_RF_CNT	; 037FB1D8

; ===== function loc_037FB1DC =====
loc_037FB1DC:
	push {r4,r5,r6,r7,lr}	; 037FB1DC
	sub sp,#0x4	; 037FB1DE
	ldr r1,[pool_037FB214]	; 037FB1E0
	ldr r0,[pool_037FB218]	; 037FB1E2
	strh r1,[r0,#0x0]	; 037FB1E4
	mov r4,#0x64	; 037FB1E6
	mov r5,#0x0	; 037FB1E8
	str r5,[sp,#0x0]	; 037FB1EA
	mov r6,#0x1	; 037FB1EC
	add r7,sp,#0x0	; 037FB1EE
loc_037FB1F0:
	add r0,r4,#0x0	; 037FB1F0
	add r1,r6,#0x0	; 037FB1F2
	add r2,r7,#0x0	; 037FB1F4
	bl loc_037FB0E0	; 037FB1F6
	add r0,r5,#0x0	; 037FB1FA
	ldr r1,[sp,#0x0]	; 037FB1FC
	bl loc_037FB160	; 037FB1FE
	add r4,r4,#0x1	; 037FB202
	add r5,r5,#0x1	; 037FB204
	cmp r5,#0x69	; 037FB206
	bcc loc_037FB1F0	; 037FB208
	add sp,#0x4	; 037FB20A
	pop {r4,r5,r6,r7}	; 037FB20C
	pop {r3}	; 037FB20E
	bx r3	; 037FB210
	.byte 0xC0, 0x46	; 037FB214
pool_037FB214:
loc_037FB214:
	.word 0x00000100	; 037FB214
pool_037FB218:
loc_037FB218:
	.word REG_WIFI_BB_MODE	; 037FB218

; ===== function loc_037FB21C =====
loc_037FB21C:
	push {r4,lr}	; 037FB21C
	sub sp,#0x8	; 037FB21E
	add r4,r0,#0x0	; 037FB220
	mov r1,#0x0	; 037FB222
	add r0,sp,#0x0	; 037FB224
	strh r1,[r0,#0x0]	; 037FB226
	ldrh r0,[r0,#0x0]	; 037FB228
	add r1,r4,#0x0	; 037FB22A
	mov r2,#0x8	; 037FB22C
	bl loc_037FB264	; 037FB22E
	mov r0,#0x40	; 037FB232
	mov r1,#0x1	; 037FB234
	add r2,r4,#0x0	; 037FB236
	bl loc_037FB0E0	; 037FB238
	mov r0,#0x41	; 037FB23C
	mov r1,#0x1	; 037FB23E
	add r2,r4,#0x2	; 037FB240
	bl loc_037FB0E0	; 037FB242
	mov r0,#0x42	; 037FB246
	mov r1,#0x1	; 037FB248
	add r2,r4,#0x4	; 037FB24A
	bl loc_037FB0E0	; 037FB24C
	mov r0,#0x43	; 037FB250
	mov r1,#0x1	; 037FB252
	add r2,r4,#0x6	; 037FB254
	bl loc_037FB0E0	; 037FB256
	add sp,#0x8	; 037FB25A
	pop {r4}	; 037FB25C
	pop {r3}	; 037FB25E
	bx r3	; 037FB260
	.byte 0xC0, 0x46	; 037FB264

; ===== function loc_037FB264 =====
loc_037FB264:
	bx pc	; 037FB264
	.byte 0xC0, 0x46	; 037FB268
.arm

; ===== function loc_037FB268 =====
loc_037FB268:
	ldr pc,[pool_037FB26C]	; 037FB268
pool_037FB26C:
loc_037FB26C:
	.word loc_037FF370	; 037FB26C
.thumb

; ===== function loc_037FB270 =====
loc_037FB270:
	push {r4,r5,lr}	; 037FB270
	sub sp,#0x4	; 037FB272
	mov r2,#0xf	; 037FB274
	add r3,r1,#0x0	; 037FB276
	and r3,r2	; 037FB278
	lsl r3,r3,#0x1	; 037FB27A
	ldr r4,[pool_037FB2C0]	; 037FB27C
	ldrh r3,[r4,r3]	; 037FB27E
	asr r1,r1,#0x4	; 037FB280
	ldr r5,[pool_037FB2C4]	; 037FB282
	and r1,r5	; 037FB284
	lsl r1,r1,#0x10	; 037FB286
	lsr r1,r1,#0x10	; 037FB288
	eor r1,r3	; 037FB28A
	add r3,r0,#0x0	; 037FB28C
	and r3,r2	; 037FB28E
	lsl r3,r3,#0x1	; 037FB290
	ldrh r3,[r4,r3]	; 037FB292
	eor r1,r3	; 037FB294
	lsl r1,r1,#0x10	; 037FB296
	lsr r3,r1,#0x10	; 037FB298
	asr r1,r3,#0x4	; 037FB29A
	and r1,r5	; 037FB29C
	lsl r1,r1,#0x10	; 037FB29E
	lsr r1,r1,#0x10	; 037FB2A0
	and r3,r2	; 037FB2A2
	lsl r3,r3,#0x1	; 037FB2A4
	ldrh r3,[r4,r3]	; 037FB2A6
	eor r1,r3	; 037FB2A8
	asr r0,r0,#0x4	; 037FB2AA
	and r0,r2	; 037FB2AC
	lsl r0,r0,#0x1	; 037FB2AE
	ldrh r0,[r4,r0]	; 037FB2B0
	eor r1,r0	; 037FB2B2
	lsl r0,r1,#0x10	; 037FB2B4
	lsr r0,r0,#0x10	; 037FB2B6
	add sp,#0x4	; 037FB2B8
	pop {r4,r5}	; 037FB2BA
	pop {r3}	; 037FB2BC
	bx r3	; 037FB2BE
pool_037FB2C0:
loc_037FB2C0:
	.word P2_Data_03805124	; 037FB2C0
pool_037FB2C4:
loc_037FB2C4:
	.word 0x00000FFF	; 037FB2C4

; ===== function loc_037FB2C8 =====
loc_037FB2C8:
	push {r4,r5,r6,r7,lr}	; 037FB2C8
	sub sp,#0xc	; 037FB2CA
	mov r5,#0x2a	; 037FB2CC
	add r0,r5,#0x0	; 037FB2CE
	mov r1,#0x2	; 037FB2D0
	add r2,sp,#0x0	; 037FB2D2
	add r2,#0x2	; 037FB2D4
	bl loc_037FB0E0	; 037FB2D6
	add r5,r5,#0x2	; 037FB2DA
	add r0,r5,#0x0	; 037FB2DC
	mov r1,#0x2	; 037FB2DE
	add r2,sp,#0x4	; 037FB2E0
	bl loc_037FB0E0	; 037FB2E2
	add r7,sp,#0x0	; 037FB2E6
	ldrh r1,[r7,#0x4]	; 037FB2E8
	ldr r0,[pool_037FB32C]	; 037FB2EA
	cmp r1,r0	; 037FB2EC
	bcs loc_037FB322	; 037FB2EE
	mov r6,#0x0	; 037FB2F0
	add r4,r6,#0x0	; 037FB2F2
	b loc_037FB30E	; 037FB2F4
loc_037FB2F6:
	add r0,r5,#0x0	; 037FB2F6
	mov r1,#0x1	; 037FB2F8
	add r2,sp,#0x0	; 037FB2FA
	bl loc_037FB0E0	; 037FB2FC
	add r5,r5,#0x1	; 037FB300
	ldrb r0,[r7,#0x0]	; 037FB302
	add r1,r6,#0x0	; 037FB304
	bl loc_037FB270	; 037FB306
	add r6,r0,#0x0	; 037FB30A
	add r4,r4,#0x1	; 037FB30C
loc_037FB30E:
	ldrh r0,[r7,#0x4]	; 037FB30E
	cmp r4,r0	; 037FB310
	bcc loc_037FB2F6	; 037FB312
	ldrh r0,[r7,#0x2]	; 037FB314
	cmp r6,r0	; 037FB316
	bne loc_037FB31E	; 037FB318
	mov r0,#0x1	; 037FB31A
	b loc_037FB324	; 037FB31C
loc_037FB31E:
	mov r0,#0x0	; 037FB31E
	b loc_037FB324	; 037FB320
loc_037FB322:
	mov r0,#0x0	; 037FB322
loc_037FB324:
	add sp,#0xc	; 037FB324
	pop {r4,r5,r6,r7}	; 037FB326
	pop {r3}	; 037FB328
	bx r3	; 037FB32A
pool_037FB32C:
loc_037FB32C:
	.word 0x000001D6	; 037FB32C

; ===== function loc_037FB330 =====
loc_037FB330:
	push {lr}	; 037FB330
	sub sp,#0x4	; 037FB332
	cmp r0,#0x2	; 037FB334
	beq loc_037FB33C	; 037FB336
	cmp r0,#0x3	; 037FB338
	b loc_037FB342	; 037FB33A
loc_037FB33C:
	ldr r0,[pool_037FB368]	; 037FB33C
	bl loc_037FB11C	; 037FB33E
loc_037FB342:
	mov r0,#0x1e	; 037FB342
	bl loc_037FB194	; 037FB344
	mov r2,#0x3f	; 037FB348
	add r1,r0,#0x0	; 037FB34A
	orr r1,r2	; 037FB34C
	mov r0,#0x1e	; 037FB34E
	bl loc_037FB160	; 037FB350
	ldr r1,[pool_037FB36C]	; 037FB354
	ldr r0,[pool_037FB370]	; 037FB356
	strh r1,[r0,#0x0]	; 037FB358
	mov r1,#0x1	; 037FB35A
	ldr r0,[pool_037FB374]	; 037FB35C
	strh r1,[r0,#0x0]	; 037FB35E
	add sp,#0x4	; 037FB360
	pop {r3}	; 037FB362
	bx r3	; 037FB364
	.byte 0xC0, 0x46	; 037FB368
pool_037FB368:
loc_037FB368:
	.word 0x0000C008	; 037FB368
pool_037FB36C:
loc_037FB36C:
	.word 0x0000800D	; 037FB36C
pool_037FB370:
loc_037FB370:
	.word REG_WIFI_BB_POWER	; 037FB370
pool_037FB374:
loc_037FB374:
	.word REG_WIFI_POWER_US	; 037FB374

; ===== function loc_037FB378 =====
loc_037FB378:
	push {lr}	; 037FB378
	sub sp,#0x4	; 037FB37A
	mov r1,#0x0	; 037FB37C
	ldr r0,[pool_037FB394]	; 037FB37E
	strh r1,[r0,#0x0]	; 037FB380
	ldr r0,[pool_037FB398]	; 037FB382
	bl loc_037FF21C	; 037FB384
	mov r1,#0x0	; 037FB388
	ldr r0,[pool_037FB39C]	; 037FB38A
	strh r1,[r0,#0x0]	; 037FB38C
	add sp,#0x4	; 037FB38E
	pop {r3}	; 037FB390
	bx r3	; 037FB392
pool_037FB394:
loc_037FB394:
	.word REG_WIFI_POWER_US	; 037FB394
pool_037FB398:
loc_037FB398:
	.word 0x00051D23	; 037FB398
pool_037FB39C:
loc_037FB39C:
	.word REG_WIFI_BB_POWER	; 037FB39C

; ===== function loc_037FB3A0 =====
P2_ThreadEntry_037FB3A0:
	push {r4,r5,r6,r7,lr}	; 037FB3A0
	sub sp,#0x4	; 037FB3A2
	ldr r6,[pool_037FB408]	; 037FB3A4
	ldr r5,[r6,#0x0]	; 037FB3A6
	mov r0,#0x0	; 037FB3A8
	strh r0,[r5,#0x10]	; 037FB3AA
	strh r0,[r5,#0x14]	; 037FB3AC
	ldr r4,[pool_037FB40C]	; 037FB3AE
	ldr r7,[pool_037FB410]	; 037FB3B0
loc_037FB3B2:
	ldr r0,[r6,#0x0]	; 037FB3B2
	ldr r0,[r0,r7]	; 037FB3B4
	add r1,sp,#0x0	; 037FB3B6
	mov r2,#0x0	; 037FB3B8
	bl loc_037FE2DC	; 037FB3BA
	cmp r0,#0x0	; 037FB3BE
	beq loc_037FB3C8	; 037FB3C0
	add r0,sp,#0x0	; 037FB3C2
	bl loc_037FB528	; 037FB3C4
loc_037FB3C8:
	ldr r0,[pool_037FB414]	; 037FB3C8
	bl loc_037FDAB8	; 037FB3CA
	ldrh r1,[r5,#0x10]	; 037FB3CE
	strh r1,[r5,#0x12]	; 037FB3D0
	ldrh r1,[r5,#0x12]	; 037FB3D2
	lsl r1,r1,#0x1	; 037FB3D4
	ldrh r1,[r5,r1]	; 037FB3D6
	cmp r1,r4	; 037FB3D8
	bne loc_037FB3E8	; 037FB3DA
	ldrh r1,[r5,#0x10]	; 037FB3DC
	add r1,r1,#0x1	; 037FB3DE
	strh r1,[r5,#0x10]	; 037FB3E0
	bl loc_037FDAE4	; 037FB3E2
	b loc_037FB3B2	; 037FB3E6
loc_037FB3E8:
	bl loc_037FDAE4	; 037FB3E8
	ldrh r0,[r5,#0x12]	; 037FB3EC
	bl loc_037FB4A4	; 037FB3EE
	strh r0,[r5,#0x14]	; 037FB3F2
	ldrh r0,[r5,#0x14]	; 037FB3F4
	lsl r0,r0,#0x3	; 037FB3F6
	add r0,r5,r0	; 037FB3F8
	add r0,#0x94	; 037FB3FA
	ldr r0,[r0,#0x0]	; 037FB3FC
	bl loc_038050CC	; 037FB3FE
	strh r4,[r5,#0x14]	; 037FB402
	b loc_037FB3B2	; 037FB404
	.byte 0xC0, 0x46	; 037FB408
pool_037FB408:
loc_037FB408:
	.word FirmwareWlWorkPointerSlot	; 037FB408
pool_037FB40C:
loc_037FB40C:
	.word 0x0000FFFF	; 037FB40C
pool_037FB410:
loc_037FB410:
	.word 0x000002DC	; 037FB410
pool_037FB414:
loc_037FB414:
	.word 0x01000010	; 037FB414

; ===== function loc_037FB418 =====
loc_037FB418:
	push {r4,r5,r6,r7,lr}	; 037FB418
	sub sp,#0x4	; 037FB41A
	add r5,r0,#0x0	; 037FB41C
	add r6,r1,#0x0	; 037FB41E
	ldr r0,[pool_037FB494]	; 037FB420
	ldr r4,[r0,#0x0]	; 037FB422
	add r7,r4,#0x0	; 037FB424
	add r7,#0x90	; 037FB426
	ldr r0,[pool_037FB498]	; 037FB428
	bl loc_037FDAB8	; 037FB42A
	str r0,[sp,#0x0]	; 037FB42E
	lsl r1,r6,#0x3	; 037FB430
	add r2,r7,#0x2	; 037FB432
	add r0,r2,r1	; 037FB434
	ldrh r2,[r2,r1]	; 037FB436
	cmp r2,#0x0	; 037FB438
	bne loc_037FB46A	; 037FB43A
	mov r2,#0x1	; 037FB43C
	strh r2,[r0,#0x0]	; 037FB43E
	ldr r0,[pool_037FB49C]	; 037FB440
	strh r0,[r7,r1]	; 037FB442
	lsl r0,r5,#0x1	; 037FB444
	add r2,r4,#0x0	; 037FB446
	add r2,#0x8	; 037FB448
	add r1,r2,r0	; 037FB44A
	ldrh r3,[r2,r0]	; 037FB44C
	ldr r2,[pool_037FB49C]	; 037FB44E
	cmp r3,r2	; 037FB450
	bne loc_037FB458	; 037FB452
	strh r6,[r4,r0]	; 037FB454
	b loc_037FB460	; 037FB456
loc_037FB458:
	lsl r0,r3,#0x3	; 037FB458
	add r0,r4,r0	; 037FB45A
	add r0,#0x90	; 037FB45C
	strh r6,[r0,#0x0]	; 037FB45E
loc_037FB460:
	strh r6,[r1,#0x0]	; 037FB460
	ldrh r0,[r4,#0x10]	; 037FB462
	cmp r5,r0	; 037FB464
	bge loc_037FB46A	; 037FB466
	strh r5,[r4,#0x10]	; 037FB468
loc_037FB46A:
	ldr r0,[sp,#0x0]	; 037FB46A
	bl loc_037FDAE4	; 037FB46C
	cmp r5,#0x3	; 037FB470
	beq loc_037FB48A	; 037FB472
	ldrh r0,[r4,#0x12]	; 037FB474
	cmp r0,#0x3	; 037FB476
	bne loc_037FB48A	; 037FB478
	ldr r0,[pool_037FB494]	; 037FB47A
	ldr r1,[r0,#0x0]	; 037FB47C
	ldr r0,[pool_037FB4A0]	; 037FB47E
	ldr r0,[r1,r0]	; 037FB480
	mov r1,#0x0	; 037FB482
	add r2,r1,#0x0	; 037FB484
	bl loc_037FE354	; 037FB486
loc_037FB48A:
	add sp,#0x4	; 037FB48A
	pop {r4,r5,r6,r7}	; 037FB48C
	pop {r3}	; 037FB48E
	bx r3	; 037FB490
	.byte 0xC0, 0x46	; 037FB494
pool_037FB494:
loc_037FB494:
	.word FirmwareWlWorkPointerSlot	; 037FB494
pool_037FB498:
loc_037FB498:
	.word 0x01000010	; 037FB498
pool_037FB49C:
loc_037FB49C:
	.word 0x0000FFFF	; 037FB49C
pool_037FB4A0:
loc_037FB4A0:
	.word 0x000002DC	; 037FB4A0

; ===== function loc_037FB4A4 =====
loc_037FB4A4:
	push {r4,r5,r6,r7,lr}	; 037FB4A4
	sub sp,#0x4	; 037FB4A6
	add r4,r0,#0x0	; 037FB4A8
	ldr r0,[pool_037FB4EC]	; 037FB4AA
	ldr r5,[r0,#0x0]	; 037FB4AC
	ldr r0,[pool_037FB4F0]	; 037FB4AE
	bl loc_037FDAB8	; 037FB4B0
	add r7,r0,#0x0	; 037FB4B4
	lsl r0,r4,#0x1	; 037FB4B6
	add r6,r5,r0	; 037FB4B8
	ldrh r4,[r5,r0]	; 037FB4BA
	ldr r0,[pool_037FB4F4]	; 037FB4BC
	cmp r4,r0	; 037FB4BE
	beq loc_037FB4DC	; 037FB4C0
	add r5,#0x90	; 037FB4C2
	lsl r3,r4,#0x3	; 037FB4C4
	mov r2,#0x0	; 037FB4C6
	add r1,r5,r3	; 037FB4C8
	strh r2,[r1,#0x2]	; 037FB4CA
	ldrh r1,[r5,r3]	; 037FB4CC
	cmp r1,r0	; 037FB4CE
	bne loc_037FB4D8	; 037FB4D0
	strh r0,[r6,#0x0]	; 037FB4D2
	strh r0,[r6,#0x8]	; 037FB4D4
	b loc_037FB4DC	; 037FB4D6
loc_037FB4D8:
	strh r1,[r6,#0x0]	; 037FB4D8
	strh r0,[r5,r3]	; 037FB4DA
loc_037FB4DC:
	add r0,r7,#0x0	; 037FB4DC
	bl loc_037FDAE4	; 037FB4DE
	add r0,r4,#0x0	; 037FB4E2
	add sp,#0x4	; 037FB4E4
	pop {r4,r5,r6,r7}	; 037FB4E6
	pop {r3}	; 037FB4E8
	bx r3	; 037FB4EA
pool_037FB4EC:
loc_037FB4EC:
	.word FirmwareWlWorkPointerSlot	; 037FB4EC
pool_037FB4F0:
loc_037FB4F0:
	.word 0x01000010	; 037FB4F0
pool_037FB4F4:
loc_037FB4F4:
	.word 0x0000FFFF	; 037FB4F4
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x58, 0x00, 0xA9, 0x01, 0x22	; 037FB508
	.byte 0x02, 0xF0, 0xE8, 0xFE, 0x00, 0xA8, 0x00, 0xF0, 0x0B, 0xF8, 0x03, 0x20, 0x0C, 0x21, 0xFF, 0xF7	; 037FB518
	.byte 0x7F, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xDC, 0x02, 0x00, 0x00	; 037FB528

; ===== function loc_037FB528 =====
loc_037FB528:
	push {lr}	; 037FB528
	sub sp,#0x4	; 037FB52A
	ldr r1,[r0,#0x0]	; 037FB52C
	cmp r1,#0x0	; 037FB52E
	beq loc_037FB546	; 037FB530
	ldr r0,[pool_037FB54C]	; 037FB532
	ldr r2,[r0,#0x0]	; 037FB534
	ldr r0,[pool_037FB550]	; 037FB536
	add r0,r2,r0	; 037FB538
	bl loc_037FB554	; 037FB53A
	mov r0,#0x2	; 037FB53E
	mov r1,#0xb	; 037FB540
	bl loc_037FB418	; 037FB542
loc_037FB546:
	add sp,#0x4	; 037FB546
	pop {r3}	; 037FB548
	bx r3	; 037FB54A
pool_037FB54C:
loc_037FB54C:
	.word FirmwareWlWorkPointerSlot	; 037FB54C
pool_037FB550:
loc_037FB550:
	.word 0x000001D4	; 037FB550

; ===== function loc_037FB554 =====
loc_037FB554:
	push {r4,r5,lr}	; 037FB554
	sub sp,#0x4	; 037FB556
	add r5,r0,#0x0	; 037FB558
	add r4,r1,#0x0	; 037FB55A
	ldr r0,[pool_037FB59C]	; 037FB55C
	bl loc_037FDAB8	; 037FB55E
	ldrh r1,[r5,#0x8]	; 037FB562
	cmp r1,#0x0	; 037FB564
	bne loc_037FB572	; 037FB566
	mov r1,#0x0	; 037FB568
	mvn r1,r1	; 037FB56A
	str r1,[r4,#0x0]	; 037FB56C
	str r4,[r5,#0x0]	; 037FB56E
	b loc_037FB578	; 037FB570
loc_037FB572:
	ldr r1,[r5,#0x4]	; 037FB572
	str r1,[r4,#0x0]	; 037FB574
	str r4,[r1,#0x4]	; 037FB576
loc_037FB578:
	mov r1,#0x0	; 037FB578
	mvn r1,r1	; 037FB57A
	str r1,[r4,#0x4]	; 037FB57C
	ldrh r1,[r5,#0xa]	; 037FB57E
	strh r1,[r4,#0x8]	; 037FB580
	ldr r1,[pool_037FB5A0]	; 037FB582
	strh r1,[r4,#0xa]	; 037FB584
	str r4,[r5,#0x4]	; 037FB586
	ldrh r1,[r5,#0x8]	; 037FB588
	add r1,r1,#0x1	; 037FB58A
	strh r1,[r5,#0x8]	; 037FB58C
	bl loc_037FDAE4	; 037FB58E
	mov r0,#0x0	; 037FB592
	add sp,#0x4	; 037FB594
	pop {r4,r5}	; 037FB596
	pop {r3}	; 037FB598
	bx r3	; 037FB59A
pool_037FB59C:
loc_037FB59C:
	.word 0x01000000	; 037FB59C
pool_037FB5A0:
loc_037FB5A0:
	.word 0x0000BF1D	; 037FB5A0

; ===== function loc_037FB5A4 =====
loc_037FB5A4:
	push {r4,r5,lr}	; 037FB5A4
	sub sp,#0x4	; 037FB5A6
	add r5,r0,#0x0	; 037FB5A8
	add r4,r1,#0x0	; 037FB5AA
	ldrh r1,[r4,#0xa]	; 037FB5AC
	ldr r0,[pool_037FB628]	; 037FB5AE
	cmp r1,r0	; 037FB5B0
	beq loc_037FB5B8	; 037FB5B2
	mov r0,#0x1	; 037FB5B4
	b loc_037FB61E	; 037FB5B6
loc_037FB5B8:
	ldrh r1,[r4,#0x8]	; 037FB5B8
	ldrh r0,[r5,#0xa]	; 037FB5BA
	cmp r1,r0	; 037FB5BC
	beq loc_037FB5C4	; 037FB5BE
	mov r0,#0x2	; 037FB5C0
	b loc_037FB61E	; 037FB5C2
loc_037FB5C4:
	ldr r0,[pool_037FB62C]	; 037FB5C4
	bl loc_037FDAB8	; 037FB5C6
	ldrh r1,[r5,#0x8]	; 037FB5CA
	sub r1,r1,#0x1	; 037FB5CC
	strh r1,[r5,#0x8]	; 037FB5CE
	ldrh r1,[r5,#0x8]	; 037FB5D0
	cmp r1,#0x0	; 037FB5D2
	bne loc_037FB5E0	; 037FB5D4
	mov r1,#0x0	; 037FB5D6
	mvn r1,r1	; 037FB5D8
	str r1,[r5,#0x0]	; 037FB5DA
	str r1,[r5,#0x4]	; 037FB5DC
	b loc_037FB614	; 037FB5DE
loc_037FB5E0:
	ldr r1,[r5,#0x0]	; 037FB5E0
	cmp r4,r1	; 037FB5E2
	bne loc_037FB5F4	; 037FB5E4
	ldr r1,[r4,#0x4]	; 037FB5E6
	str r1,[r5,#0x0]	; 037FB5E8
	mov r1,#0x0	; 037FB5EA
	mvn r2,r1	; 037FB5EC
	ldr r1,[r5,#0x0]	; 037FB5EE
	str r2,[r1,#0x0]	; 037FB5F0
	b loc_037FB614	; 037FB5F2
loc_037FB5F4:
	ldr r1,[r5,#0x4]	; 037FB5F4
	cmp r4,r1	; 037FB5F6
	bne loc_037FB608	; 037FB5F8
	ldr r1,[r4,#0x0]	; 037FB5FA
	str r1,[r5,#0x4]	; 037FB5FC
	mov r1,#0x0	; 037FB5FE
	mvn r2,r1	; 037FB600
	ldr r1,[r5,#0x4]	; 037FB602
	str r2,[r1,#0x4]	; 037FB604
	b loc_037FB614	; 037FB606
loc_037FB608:
	ldr r2,[r4,#0x0]	; 037FB608
	ldr r1,[r4,#0x4]	; 037FB60A
	str r2,[r1,#0x0]	; 037FB60C
	ldr r2,[r4,#0x4]	; 037FB60E
	ldr r1,[r4,#0x0]	; 037FB610
	str r2,[r1,#0x4]	; 037FB612
loc_037FB614:
	mov r1,#0x0	; 037FB614
	strh r1,[r4,#0x8]	; 037FB616
	bl loc_037FDAE4	; 037FB618
	mov r0,#0x0	; 037FB61C
loc_037FB61E:
	add sp,#0x4	; 037FB61E
	pop {r4,r5}	; 037FB620
	pop {r3}	; 037FB622
	bx r3	; 037FB624
	.byte 0xC0, 0x46	; 037FB628
pool_037FB628:
loc_037FB628:
	.word 0x0000BF1D	; 037FB628
pool_037FB62C:
loc_037FB62C:
	.word 0x01000000	; 037FB62C

; ===== function loc_037FB630 =====
P2_Entry_037FB630:
	push {r4,r5,lr}	; 037FB630
	sub sp,#0x4	; 037FB632
	add r5,r0,#0x0	; 037FB634
	ldr r0,[pool_037FB690]	; 037FB636
	ldr r2,[r0,#0x0]	; 037FB638
	ldr r0,[pool_037FB694]	; 037FB63A
	add r3,r2,r0	; 037FB63C
	cmp r1,#0x0	; 037FB63E
	bne loc_037FB646	; 037FB640
	mov r0,#0x0	; 037FB642
	b loc_037FB686	; 037FB644
loc_037FB646:
	add r2,r1,#0x0	; 037FB646
	add r2,#0xc	; 037FB648
	ldr r0,[r3,#0x0]	; 037FB64A
	cmp r0,#0x0	; 037FB64C
	beq loc_037FB656	; 037FB64E
	cmp r0,#0x1	; 037FB650
	beq loc_037FB662	; 037FB652
	b loc_037FB66C	; 037FB654
loc_037FB656:
	ldr r0,[r3,#0x4]	; 037FB656
	ldr r1,[r3,#0x8]	; 037FB658
	bl loc_037FE770	; 037FB65A
	add r4,r0,#0x0	; 037FB65E
	b loc_037FB66C	; 037FB660
loc_037FB662:
	add r0,r2,#0x0	; 037FB662
	ldr r1,[r3,#0x4]	; 037FB664
	bl loc_038050D0	; 037FB666
	add r4,r0,#0x0	; 037FB66A
loc_037FB66C:
	cmp r4,#0x0	; 037FB66C
	beq loc_037FB684	; 037FB66E
	ldr r0,[pool_037FB698]	; 037FB670
	strh r0,[r4,#0xa]	; 037FB672
	mov r0,#0x0	; 037FB674
	strh r0,[r4,#0x8]	; 037FB676
	add r0,r5,#0x0	; 037FB678
	add r1,r4,#0x0	; 037FB67A
	bl loc_037FB744	; 037FB67C
	add r0,r4,#0x0	; 037FB680
	b loc_037FB686	; 037FB682
loc_037FB684:
	mov r0,#0x0	; 037FB684
loc_037FB686:
	add sp,#0x4	; 037FB686
	pop {r4,r5}	; 037FB688
	pop {r3}	; 037FB68A
	bx r3	; 037FB68C
	.byte 0xC0, 0x46	; 037FB690
pool_037FB690:
loc_037FB690:
	.word FirmwareWlWorkPointerSlot	; 037FB690
pool_037FB694:
loc_037FB694:
	.word 0x00000150	; 037FB694
pool_037FB698:
loc_037FB698:
	.word 0x0000BF1D	; 037FB698
P2_Entry_037FB69C:
	push {r4,r5,r6,lr}	; 037FB69C
	add r5,r1,#0x0	; 037FB69E
	ldr r2,[pool_037FB6E8]	; 037FB6A0
	ldr r3,[r2,#0x0]	; 037FB6A2
	ldr r2,[pool_037FB6EC]	; 037FB6A4
	add r4,r3,r2	; 037FB6A6
	ldrh r3,[r5,#0xa]	; 037FB6A8
	ldr r2,[pool_037FB6F0]	; 037FB6AA
	cmp r3,r2	; 037FB6AC
	beq P2_Entry_037FB6B4	; 037FB6AE
	mov r0,#0x1	; 037FB6B0
	b P2_Entry_037FB6E0	; 037FB6B2
P2_Entry_037FB6B4:
	bl loc_037FB5A4	; 037FB6B4
	add r6,r0,#0x0	; 037FB6B8
	cmp r6,#0x0	; 037FB6BA
	bne P2_Entry_037FB6DE	; 037FB6BC
	ldr r0,[r4,#0x0]	; 037FB6BE
	cmp r0,#0x0	; 037FB6C0
	beq P2_Entry_037FB6CA	; 037FB6C2
	cmp r0,#0x1	; 037FB6C4
	beq P2_Entry_037FB6D6	; 037FB6C6
	b P2_Entry_037FB6DE	; 037FB6C8
P2_Entry_037FB6CA:
	ldr r0,[r4,#0x4]	; 037FB6CA
	ldr r1,[r4,#0x8]	; 037FB6CC
	add r2,r5,#0x0	; 037FB6CE
	bl P2_Entry_037FE724	; 037FB6D0
	b P2_Entry_037FB6DE	; 037FB6D4
P2_Entry_037FB6D6:
	add r0,r5,#0x0	; 037FB6D6
	ldr r1,[r4,#0x8]	; 037FB6D8
	bl loc_038050D0	; 037FB6DA
P2_Entry_037FB6DE:
	add r0,r6,#0x0	; 037FB6DE
P2_Entry_037FB6E0:
	pop {r4,r5,r6}	; 037FB6E0
	pop {r3}	; 037FB6E2
	bx r3	; 037FB6E4
	.byte 0xC0, 0x46	; 037FB6E6
pool_037FB6E8:
	.word FirmwareWlWorkPointerSlot	; 037FB6E8
pool_037FB6EC:
	.word 0x00000150	; 037FB6EC
pool_037FB6F0:
	.word 0x0000BF1D	; 037FB6F0

; ===== function loc_037FB6F4 =====
loc_037FB6F4:
	push {r4,r5,r6,r7,lr}	; 037FB6F4
	sub sp,#0x4	; 037FB6F6
	add r4,r0,#0x0	; 037FB6F8
	add r6,r1,#0x0	; 037FB6FA
	add r5,r2,#0x0	; 037FB6FC
	ldrh r1,[r5,#0xa]	; 037FB6FE
	ldr r0,[pool_037FB73C]	; 037FB700
	cmp r1,r0	; 037FB702
	beq loc_037FB70A	; 037FB704
	mov r0,#0x1	; 037FB706
	b loc_037FB732	; 037FB708
loc_037FB70A:
	ldr r0,[pool_037FB740]	; 037FB70A
	bl loc_037FDAB8	; 037FB70C
	add r7,r0,#0x0	; 037FB710
	add r0,r4,#0x0	; 037FB712
	add r1,r5,#0x0	; 037FB714
	bl loc_037FB5A4	; 037FB716
	add r4,r0,#0x0	; 037FB71A
	cmp r4,#0x0	; 037FB71C
	bne loc_037FB72A	; 037FB71E
	add r0,r6,#0x0	; 037FB720
	add r1,r5,#0x0	; 037FB722
	bl loc_037FB744	; 037FB724
	add r4,r0,#0x0	; 037FB728
loc_037FB72A:
	add r0,r7,#0x0	; 037FB72A
	bl loc_037FDAE4	; 037FB72C
	add r0,r4,#0x0	; 037FB730
loc_037FB732:
	add sp,#0x4	; 037FB732
	pop {r4,r5,r6,r7}	; 037FB734
	pop {r3}	; 037FB736
	bx r3	; 037FB738
	.byte 0xC0, 0x46	; 037FB73C
pool_037FB73C:
loc_037FB73C:
	.word 0x0000BF1D	; 037FB73C
pool_037FB740:
loc_037FB740:
	.word 0x01000000	; 037FB740

; ===== function loc_037FB744 =====
loc_037FB744:
	push {r4,r5,lr}	; 037FB744
	sub sp,#0x4	; 037FB746
	add r5,r0,#0x0	; 037FB748
	add r4,r1,#0x0	; 037FB74A
	ldrh r1,[r4,#0xa]	; 037FB74C
	ldr r0,[pool_037FB7A0]	; 037FB74E
	cmp r1,r0	; 037FB750
	beq loc_037FB758	; 037FB752
	mov r0,#0x1	; 037FB754
	b loc_037FB796	; 037FB756
loc_037FB758:
	ldrh r0,[r4,#0x8]	; 037FB758
	cmp r0,#0x0	; 037FB75A
	beq loc_037FB762	; 037FB75C
	mov r0,#0x2	; 037FB75E
	b loc_037FB796	; 037FB760
loc_037FB762:
	ldr r0,[pool_037FB7A4]	; 037FB762
	bl loc_037FDAB8	; 037FB764
	ldrh r1,[r5,#0x8]	; 037FB768
	cmp r1,#0x0	; 037FB76A
	bne loc_037FB778	; 037FB76C
	mov r1,#0x0	; 037FB76E
	mvn r1,r1	; 037FB770
	str r1,[r4,#0x0]	; 037FB772
	str r4,[r5,#0x0]	; 037FB774
	b loc_037FB77E	; 037FB776
loc_037FB778:
	ldr r1,[r5,#0x4]	; 037FB778
	str r1,[r4,#0x0]	; 037FB77A
	str r4,[r1,#0x4]	; 037FB77C
loc_037FB77E:
	mov r1,#0x0	; 037FB77E
	mvn r1,r1	; 037FB780
	str r1,[r4,#0x4]	; 037FB782
	ldrh r1,[r5,#0xa]	; 037FB784
	strh r1,[r4,#0x8]	; 037FB786
	str r4,[r5,#0x4]	; 037FB788
	ldrh r1,[r5,#0x8]	; 037FB78A
	add r1,r1,#0x1	; 037FB78C
	strh r1,[r5,#0x8]	; 037FB78E
	bl loc_037FDAE4	; 037FB790
	mov r0,#0x0	; 037FB794
loc_037FB796:
	add sp,#0x4	; 037FB796
	pop {r4,r5}	; 037FB798
	pop {r3}	; 037FB79A
	bx r3	; 037FB79C
	.byte 0xC0, 0x46	; 037FB7A0
pool_037FB7A0:
loc_037FB7A0:
	.word 0x0000BF1D	; 037FB7A0
pool_037FB7A4:
loc_037FB7A4:
	.word 0x01000000	; 037FB7A4
P2_Entry_037FB7A8:
	ldr r0,[r0,#0x4]	; 037FB7A8
	bx lr	; 037FB7AA

; ===== function loc_037FB7AC =====
	push {r4,r5,r6,r7,lr}	; 037FB7AC
	sub sp,#0xc	; 037FB7AE
	ldr r2,[pool_037FB974]	; 037FB7B0
	ldr r0,[r2,#0x0]	; 037FB7B2
	ldr r1,[pool_037FB978]	; 037FB7B4
	add r5,r0,r1	; 037FB7B6
	mov r1,#0x0	; 037FB7B8
	add r7,r1,#0x0	; 037FB7BA
	ldrh r3,[r5,#0x4]	; 037FB7BC
	cmp r3,#0x0	; 037FB7BE
	beq loc_037FB7C4	; 037FB7C0
	b loc_037FB96C	; 037FB7C2
loc_037FB7C4:
	ldr r3,[pool_037FB97C]	; 037FB7C4
	ldr r0,[r0,r3]	; 037FB7C6
	str r0,[r5,#0x0]	; 037FB7C8
	ldr r0,[r5,#0x0]	; 037FB7CA
	str r0,[sp,#0x0]	; 037FB7CC
	mvn r3,r1	; 037FB7CE
	cmp r0,r3	; 037FB7D0
	bne loc_037FB7D6	; 037FB7D2
	b loc_037FB96C	; 037FB7D4
loc_037FB7D6:
	ldrh r0,[r0,#0xe]	; 037FB7D6
	lsl r3,r0,#0x1	; 037FB7D8
	ldr r0,[sp,#0x0]	; 037FB7DA
	add r4,r0,r3	; 037FB7DC
	add r4,#0x10	; 037FB7DE
	ldr r0,[r2,#0x0]	; 037FB7E0
	ldr r2,[pool_037FB980]	; 037FB7E2
	ldrh r2,[r0,r2]	; 037FB7E4
	cmp r2,#0x0	; 037FB7E6
	beq loc_037FB7F4	; 037FB7E8
	mov r0,#0x1	; 037FB7EA
	strh r0,[r4,#0x2]	; 037FB7EC
	mov r0,#0x6	; 037FB7EE
	strh r0,[r4,#0x4]	; 037FB7F0
	b loc_037FB944	; 037FB7F2
loc_037FB7F4:
	ldr r2,[sp,#0x0]	; 037FB7F4
	ldrh r6,[r2,#0xc]	; 037FB7F6
	ldrh r2,[r4,#0x0]	; 037FB7F8
	cmp r6,r2	; 037FB7FA
	beq loc_037FB804	; 037FB7FC
	mov r0,#0xd	; 037FB7FE
	strh r0,[r4,#0x4]	; 037FB800
	b loc_037FB944	; 037FB802
loc_037FB804:
	ldr r2,[pool_037FB984]	; 037FB804
	add r3,r6,#0x0	; 037FB806
	and r3,r2	; 037FB808
	ldr r2,[pool_037FB988]	; 037FB80A
	cmp r3,r2	; 037FB80C
	bgt loc_037FB81A	; 037FB80E
	cmp r3,r2	; 037FB810
	bge loc_037FB856	; 037FB812
	cmp r3,#0x0	; 037FB814
	beq loc_037FB82E	; 037FB816
	b loc_037FB8E6	; 037FB818
loc_037FB81A:
	ldr r2,[pool_037FB98C]	; 037FB81A
	cmp r3,r2	; 037FB81C
	bgt loc_037FB826	; 037FB81E
	cmp r3,r2	; 037FB820
	beq loc_037FB872	; 037FB822
	b loc_037FB8E6	; 037FB824
loc_037FB826:
	ldr r0,[pool_037FB990]	; 037FB826
	cmp r3,r0	; 037FB828
	beq loc_037FB8D4	; 037FB82A
	b loc_037FB8E6	; 037FB82C
loc_037FB82E:
	mov r7,#0x1	; 037FB82E
	ldr r2,[pool_037FB994]	; 037FB830
	str r2,[sp,#0x4]	; 037FB832
	mov r2,#0xff	; 037FB834
	and r6,r2	; 037FB836
	lsl r2,r6,#0x10	; 037FB838
	lsr r2,r2,#0x10	; 037FB83A
	mov r3,#0xb	; 037FB83C
	ldrh r6,[r5,#0x4]	; 037FB83E
	and r6,r7	; 037FB840
	cmp r6,#0x0	; 037FB842
	beq loc_037FB84A	; 037FB844
	mov r1,#0x2	; 037FB846
	b loc_037FB8EA	; 037FB848
loc_037FB84A:
	ldr r6,[pool_037FB998]	; 037FB84A
	ldrh r0,[r0,r6]	; 037FB84C
	cmp r0,#0x20	; 037FB84E
	bcs loc_037FB8EA	; 037FB850
	add r1,r7,#0x0	; 037FB852
	b loc_037FB8EA	; 037FB854
loc_037FB856:
	mov r7,#0x2	; 037FB856
	ldr r2,[pool_037FB99C]	; 037FB858
	str r2,[sp,#0x4]	; 037FB85A
	mov r2,#0xff	; 037FB85C
	and r6,r2	; 037FB85E
	lsl r2,r6,#0x10	; 037FB860
	lsr r2,r2,#0x10	; 037FB862
	mov r3,#0x5	; 037FB864
	ldr r6,[pool_037FB998]	; 037FB866
	ldrh r0,[r0,r6]	; 037FB868
	cmp r0,#0x40	; 037FB86A
	beq loc_037FB8EA	; 037FB86C
	mov r1,#0x1	; 037FB86E
	b loc_037FB8EA	; 037FB870
loc_037FB872:
	mov r2,#0xff	; 037FB872
	and r6,r2	; 037FB874
	lsl r2,r6,#0x10	; 037FB876
	lsr r2,r2,#0x10	; 037FB878
	cmp r2,#0x40	; 037FB87A
	bcs loc_037FB892	; 037FB87C
	ldr r3,[pool_037FB998]	; 037FB87E
	ldrh r0,[r0,r3]	; 037FB880
	cmp r0,#0x10	; 037FB882
	bcs loc_037FB888	; 037FB884
	mov r1,#0x1	; 037FB886
loc_037FB888:
	mov r7,#0x4	; 037FB888
	ldr r0,[pool_037FB9A0]	; 037FB88A
	str r0,[sp,#0x4]	; 037FB88C
	mov r3,#0x16	; 037FB88E
	b loc_037FB8EA	; 037FB890
loc_037FB892:
	cmp r2,#0x80	; 037FB892
	bcs loc_037FB8B0	; 037FB894
	ldr r3,[pool_037FB998]	; 037FB896
	ldrh r0,[r0,r3]	; 037FB898
	cmp r0,#0x40	; 037FB89A
	beq loc_037FB8A0	; 037FB89C
	mov r1,#0x1	; 037FB89E
loc_037FB8A0:
	mov r7,#0x8	; 037FB8A0
	ldr r0,[pool_037FB9A4]	; 037FB8A2
	str r0,[sp,#0x4]	; 037FB8A4
	sub r2,#0x40	; 037FB8A6
	lsl r0,r2,#0x10	; 037FB8A8
	lsr r2,r0,#0x10	; 037FB8AA
	mov r3,#0x6	; 037FB8AC
	b loc_037FB8EA	; 037FB8AE
loc_037FB8B0:
	cmp r2,#0xc0	; 037FB8B0
	bcs loc_037FB8CE	; 037FB8B2
	ldr r3,[pool_037FB998]	; 037FB8B4
	ldrh r0,[r0,r3]	; 037FB8B6
	cmp r0,#0x10	; 037FB8B8
	bcs loc_037FB8BE	; 037FB8BA
	mov r1,#0x1	; 037FB8BC
loc_037FB8BE:
	mov r7,#0x10	; 037FB8BE
	ldr r0,[pool_037FB9A8]	; 037FB8C0
	str r0,[sp,#0x4]	; 037FB8C2
	sub r2,#0x80	; 037FB8C4
	lsl r0,r2,#0x10	; 037FB8C6
	lsr r2,r0,#0x10	; 037FB8C8
	mov r3,#0x16	; 037FB8CA
	b loc_037FB8EA	; 037FB8CC
loc_037FB8CE:
	mov r2,#0x1	; 037FB8CE
	add r3,r1,#0x0	; 037FB8D0
	b loc_037FB8EA	; 037FB8D2
loc_037FB8D4:
	mov r7,#0x40	; 037FB8D4
	ldr r0,[pool_037FB9AC]	; 037FB8D6
	str r0,[sp,#0x4]	; 037FB8D8
	mov r0,#0xff	; 037FB8DA
	and r6,r0	; 037FB8DC
	lsl r0,r6,#0x10	; 037FB8DE
	lsr r2,r0,#0x10	; 037FB8E0
	mov r3,#0xa	; 037FB8E2
	b loc_037FB8EA	; 037FB8E4
loc_037FB8E6:
	mov r2,#0x1	; 037FB8E6
	mov r3,#0x0	; 037FB8E8
loc_037FB8EA:
	cmp r2,r3	; 037FB8EA
	bls loc_037FB8F2	; 037FB8EC
	mov r1,#0x3	; 037FB8EE
	b loc_037FB90E	; 037FB8F0
loc_037FB8F2:
	lsl r3,r2,#0x3	; 037FB8F2
	ldr r0,[sp,#0x0]	; 037FB8F4
	ldrh r6,[r0,#0xe]	; 037FB8F6
	ldr r0,[sp,#0x4]	; 037FB8F8
	ldrh r0,[r0,r3]	; 037FB8FA
	cmp r6,r0	; 037FB8FC
	bcc loc_037FB90C	; 037FB8FE
	ldrh r6,[r4,#0x2]	; 037FB900
	ldr r0,[sp,#0x4]	; 037FB902
	add r0,r0,r3	; 037FB904
	ldrh r0,[r0,#0x2]	; 037FB906
	cmp r6,r0	; 037FB908
	bcs loc_037FB90E	; 037FB90A
loc_037FB90C:
	mov r1,#0x4	; 037FB90C
loc_037FB90E:
	cmp r1,#0x0	; 037FB90E
	beq loc_037FB91A	; 037FB910
	mov r0,#0x1	; 037FB912
	strh r0,[r4,#0x2]	; 037FB914
	strh r1,[r4,#0x4]	; 037FB916
	b loc_037FB944	; 037FB918
loc_037FB91A:
	ldrh r0,[r5,#0x4]	; 037FB91A
	orr r0,r7	; 037FB91C
	strh r0,[r5,#0x4]	; 037FB91E
	ldr r0,[sp,#0x0]	; 037FB920
	add r1,r4,#0x0	; 037FB922
	lsl r3,r2,#0x3	; 037FB924
	ldr r2,[sp,#0x4]	; 037FB926
	add r2,r2,r3	; 037FB928
	ldr r2,[r2,#0x4]	; 037FB92A
	bl loc_038050D4	; 037FB92C
	strh r0,[r4,#0x4]	; 037FB930
	ldrh r0,[r4,#0x4]	; 037FB932
	cmp r0,#0x80	; 037FB934
	beq loc_037FB96C	; 037FB936
	cmp r0,#0x81	; 037FB938
	bne loc_037FB944	; 037FB93A
	ldrh r0,[r5,#0x4]	; 037FB93C
	bic r0,r7	; 037FB93E
	strh r0,[r5,#0x4]	; 037FB940
	b loc_037FB958	; 037FB942
loc_037FB944:
	ldrh r0,[r5,#0x4]	; 037FB944
	bic r0,r7	; 037FB946
	strh r0,[r5,#0x4]	; 037FB948
	ldr r0,[pool_037FB974]	; 037FB94A
	ldr r1,[r0,#0x0]	; 037FB94C
	ldr r0,[pool_037FB97C]	; 037FB94E
	add r0,r1,r0	; 037FB950
	ldr r1,[r5,#0x0]	; 037FB952
	bl loc_037FB9B4	; 037FB954
loc_037FB958:
	ldr r0,[pool_037FB974]	; 037FB958
	ldr r1,[r0,#0x0]	; 037FB95A
	ldr r0,[pool_037FB9B0]	; 037FB95C
	ldrh r0,[r1,r0]	; 037FB95E
	cmp r0,#0x0	; 037FB960
	beq loc_037FB96C	; 037FB962
	mov r0,#0x2	; 037FB964
	mov r1,#0xb	; 037FB966
	bl loc_037FB418	; 037FB968
loc_037FB96C:
	add sp,#0xc	; 037FB96C
	pop {r4,r5,r6,r7}	; 037FB96E
	pop {r3}	; 037FB970
	bx r3	; 037FB972
pool_037FB974:
loc_037FB974:
	.word FirmwareWlWorkPointerSlot	; 037FB974
pool_037FB978:
loc_037FB978:
	.word 0x000003F8	; 037FB978
pool_037FB97C:
loc_037FB97C:
	.word 0x000001D4	; 037FB97C
pool_037FB980:
loc_037FB980:
	.word 0x00000312	; 037FB980
pool_037FB984:
loc_037FB984:
	.word 0x0000FF00	; 037FB984
pool_037FB988:
loc_037FB988:
	.word 0x00000100	; 037FB988
pool_037FB98C:
loc_037FB98C:
	.word 0x00000200	; 037FB98C
pool_037FB990:
loc_037FB990:
	.word 0x00000300	; 037FB990
pool_037FB994:
loc_037FB994:
	.word 0x0230D980	; 037FB994
pool_037FB998:
loc_037FB998:
	.word 0x00000320	; 037FB998
pool_037FB99C:
loc_037FB99C:
	.word 0x0230D8D8	; 037FB99C
pool_037FB9A0:
loc_037FB9A0:
	.word 0x0230DA88	; 037FB9A0
pool_037FB9A4:
loc_037FB9A4:
	.word 0x0230D900	; 037FB9A4
pool_037FB9A8:
loc_037FB9A8:
	.word 0x0230D9D8	; 037FB9A8
pool_037FB9AC:
loc_037FB9AC:
	.word 0x0230D930	; 037FB9AC
pool_037FB9B0:
loc_037FB9B0:
	.word 0x000001DC	; 037FB9B0

; ===== function loc_037FB9B4 =====
loc_037FB9B4:
	push {r4,r5,lr}	; 037FB9B4
	sub sp,#0x4	; 037FB9B6
	add r5,r0,#0x0	; 037FB9B8
	add r4,r1,#0x0	; 037FB9BA
	ldr r2,[pool_037FBA0C]	; 037FB9BC
	ldr r2,[r2,#0x0]	; 037FB9BE
	ldr r3,[pool_037FBA10]	; 037FB9C0
	ldrh r3,[r2,r3]	; 037FB9C2
	cmp r3,#0x0	; 037FB9C4
	beq loc_037FB9DC	; 037FB9C6
	ldr r1,[pool_037FBA14]	; 037FB9C8
	add r1,r2,r1	; 037FB9CA
	add r2,r4,#0x0	; 037FB9CC
	bl loc_037FB6F4	; 037FB9CE
	mov r0,#0x2	; 037FB9D2
	mov r1,#0x13	; 037FB9D4
	bl loc_037FB418	; 037FB9D6
	b loc_037FBA04	; 037FB9DA
loc_037FB9DC:
	ldr r0,[pool_037FBA18]	; 037FB9DC
	ldr r0,[r2,r0]	; 037FB9DE
	mov r2,#0x0	; 037FB9E0
	bl loc_037FE354	; 037FB9E2
	cmp r0,#0x0	; 037FB9E6
	beq loc_037FB9F4	; 037FB9E8
	add r0,r5,#0x0	; 037FB9EA
	add r1,r4,#0x0	; 037FB9EC
	bl loc_037FB5A4	; 037FB9EE
	b loc_037FBA04	; 037FB9F2
loc_037FB9F4:
	add r0,r5,#0x0	; 037FB9F4
	ldr r1,[pool_037FBA0C]	; 037FB9F6
	ldr r2,[r1,#0x0]	; 037FB9F8
	ldr r1,[pool_037FBA14]	; 037FB9FA
	add r1,r2,r1	; 037FB9FC
	add r2,r4,#0x0	; 037FB9FE
	bl loc_037FB6F4	; 037FBA00
loc_037FBA04:
	add sp,#0x4	; 037FBA04
	pop {r4,r5}	; 037FBA06
	pop {r3}	; 037FBA08
	bx r3	; 037FBA0A
pool_037FBA0C:
loc_037FBA0C:
	.word FirmwareWlWorkPointerSlot	; 037FBA0C
pool_037FBA10:
loc_037FBA10:
	.word 0x000001D0	; 037FBA10
pool_037FBA14:
loc_037FBA14:
	.word 0x000001C8	; 037FBA14
pool_037FBA18:
loc_037FBA18:
	.word 0x000002D8	; 037FBA18

; ===== function loc_037FBA1C =====
P2_Entry_037FBA1C:
	push {r4,r5,r6,r7,lr}	; 037FBA1C
	sub sp,#0xc	; 037FBA1E
	ldr r0,[pool_037FBCBC]	; 037FBA20
	ldr r1,[r0,#0x0]	; 037FBA22
	ldr r0,[pool_037FBCC0]	; 037FBA24
	add r4,r1,r0	; 037FBA26
	ldr r0,[pool_037FBCC4]	; 037FBA28
	add r5,r1,r0	; 037FBA2A
	bl loc_037FBDF4	; 037FBA2C
	ldr r1,[pool_037FBCC8]	; 037FBA30
	ldrh r2,[r1,#0x0]	; 037FBA32
	ldrh r0,[r1,#0x0]	; 037FBA34
	lsl r0,r0,#0x8	; 037FBA36
	add r0,r2,r0	; 037FBA38
	ldrh r1,[r1,#0x0]	; 037FBA3A
	bl loc_037FBD6C	; 037FBA3C
	mov r1,#0x1	; 037FBA40
	add r0,r4,#0x0	; 037FBA42
	add r0,#0x7c	; 037FBA44
	strh r1,[r0,#0x0]	; 037FBA46
	ldrh r0,[r5,#0x1e]	; 037FBA48
	lsl r0,r0,#0x1d	; 037FBA4A
	lsr r0,r0,#0x1f	; 037FBA4C
	cmp r0,#0x1	; 037FBA4E
	bne loc_037FBA62	; 037FBA50
	add r0,r4,#0x0	; 037FBA52
	add r0,#0x7c	; 037FBA54
	ldrh r1,[r0,#0x0]	; 037FBA56
	mov r0,#0x20	; 037FBA58
	orr r1,r0	; 037FBA5A
	add r0,r4,#0x0	; 037FBA5C
	add r0,#0x7c	; 037FBA5E
	strh r1,[r0,#0x0]	; 037FBA60
loc_037FBA62:
	ldrh r0,[r5,#0x18]	; 037FBA62
	cmp r0,#0x0	; 037FBA64
	beq loc_037FBA78	; 037FBA66
	add r0,r4,#0x0	; 037FBA68
	add r0,#0x7c	; 037FBA6A
	ldrh r1,[r0,#0x0]	; 037FBA6C
	mov r0,#0x10	; 037FBA6E
	orr r1,r0	; 037FBA70
	add r0,r4,#0x0	; 037FBA72
	add r0,#0x7c	; 037FBA74
	strh r1,[r0,#0x0]	; 037FBA76
loc_037FBA78:
	mov r0,#0x0	; 037FBA78
	strh r0,[r4,#0x12]	; 037FBA7A
	ldr r2,[pool_037FBCCC]	; 037FBA7C
	ldr r1,[pool_037FBCD0]	; 037FBA7E
	strh r2,[r1,#0x0]	; 037FBA80
	ldr r2,[pool_037FBCD4]	; 037FBA82
	ldr r1,[pool_037FBCD8]	; 037FBA84
	strh r2,[r1,#0x0]	; 037FBA86
	ldr r1,[pool_037FBCDC]	; 037FBA88
	strh r0,[r1,#0x0]	; 037FBA8A
	ldr r1,[pool_037FBCE0]	; 037FBA8C
	strh r0,[r1,#0x0]	; 037FBA8E
	mov r1,#0xf	; 037FBA90
	ldr r0,[pool_037FBCE4]	; 037FBA92
	strh r1,[r0,#0x0]	; 037FBA94
	bl loc_037FBD7C	; 037FBA96
	bl loc_037FBD8C	; 037FBA9A
	bl loc_037FD49C	; 037FBA9E
	bl loc_037FD744	; 037FBAA2
	ldr r1,[pool_037FBCCC]	; 037FBAA6
	ldr r0,[pool_037FBCE8]	; 037FBAA8
	strh r1,[r0,#0x0]	; 037FBAAA
	ldr r1,[pool_037FBCD4]	; 037FBAAC
	ldr r0,[pool_037FBCEC]	; 037FBAAE
	strh r1,[r0,#0x0]	; 037FBAB0
	ldr r1,[pool_037FBCF0]	; 037FBAB2
	ldr r0,[pool_037FBCF4]	; 037FBAB4
	strh r1,[r0,#0x0]	; 037FBAB6
	ldr r0,[pool_037FBCBC]	; 037FBAB8
	ldr r1,[r0,#0x0]	; 037FBABA
	ldr r0,[pool_037FBCF8]	; 037FBABC
	ldrh r1,[r1,r0]	; 037FBABE
	mov r0,#0x8	; 037FBAC0
	and r1,r0	; 037FBAC2
	cmp r1,#0x0	; 037FBAC4
	beq loc_037FBAD0	; 037FBAC6
	ldr r1,[pool_037FBCFC]	; 037FBAC8
	ldr r0,[pool_037FBD00]	; 037FBACA
	strh r1,[r0,#0x0]	; 037FBACC
	b loc_037FBAD6	; 037FBACE
loc_037FBAD0:
	mov r1,#0x0	; 037FBAD0
	ldr r0,[pool_037FBD00]	; 037FBAD2
	strh r1,[r0,#0x0]	; 037FBAD4
loc_037FBAD6:
	mov r6,#0x0	; 037FBAD6
	ldr r1,[pool_037FBD04]	; 037FBAD8
	strh r6,[r1,#0x0]	; 037FBADA
	ldr r0,[pool_037FBD08]	; 037FBADC
	strh r6,[r0,#0x0]	; 037FBADE
	ldrh r2,[r4,#0xc]	; 037FBAE0
	cmp r2,#0x4	; 037FBAE2
	bls loc_037FBAE8	; 037FBAE4
	b loc_037FBC94	; 037FBAE6
loc_037FBAE8:
	add r2,r2,r2	; 037FBAE8
P2_SwitchIndexPC_037FBAE8:
	add r2,pc	; 037FBAEA
	ldrh r2,[r2,#(P2_SwitchTable_037FBAE8 - (P2_SwitchIndexPC_037FBAE8 + 4))]	; 037FBAEC
	lsl r2,r2,#0x10	; 037FBAEE
	asr r2,r2,#0x10	; 037FBAF0
P2_SwitchTargetPC_037FBAE8:
	add r2,pc	; 037FBAF2
	bx r2	; 037FBAF4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FBAE8:
	.halfword (loc_037FBB00 + 1) - (P2_SwitchTargetPC_037FBAE8 + 4)
	.halfword (loc_037FBB28 + 1) - (P2_SwitchTargetPC_037FBAE8 + 4)
	.halfword (loc_037FBBC8 + 1) - (P2_SwitchTargetPC_037FBAE8 + 4)
	.halfword (loc_037FBC38 + 1) - (P2_SwitchTargetPC_037FBAE8 + 4)
	.halfword (loc_037FBC80 + 1) - (P2_SwitchTargetPC_037FBAE8 + 4)
P2_SwitchTable_037FBAE8End:
loc_037FBB00:
	mov r3,#0x3f	; 037FBB00
	ldr r2,[pool_037FBD0C]	; 037FBB02
	strh r3,[r2,#0x0]	; 037FBB04
	ldr r3,[pool_037FBCD4]	; 037FBB06
	ldr r2,[pool_037FBD10]	; 037FBB08
	strh r3,[r2,#0x0]	; 037FBB0A
	mov r3,#0x8	; 037FBB0C
	ldr r2,[pool_037FBD14]	; 037FBB0E
	strh r3,[r2,#0x0]	; 037FBB10
	strh r6,[r1,#0x0]	; 037FBB12
	strh r6,[r0,#0x0]	; 037FBB14
	ldr r0,[pool_037FBD18]	; 037FBB16
	strh r6,[r0,#0x0]	; 037FBB18
	mov r1,#0x1	; 037FBB1A
	ldr r0,[pool_037FBD1C]	; 037FBB1C
	strh r1,[r0,#0x0]	; 037FBB1E
	mov r0,#0x40	; 037FBB20
	bl loc_037FBECC	; 037FBB22
	b loc_037FBC94	; 037FBB26
loc_037FBB28:
	ldr r2,[pool_037FBD20]	; 037FBB28
	ldr r0,[pool_037FBD0C]	; 037FBB2A
	strh r2,[r0,#0x0]	; 037FBB2C
	ldr r2,[pool_037FBCF0]	; 037FBB2E
	ldr r0,[pool_037FBCF4]	; 037FBB30
	strh r2,[r0,#0x0]	; 037FBB32
	ldr r2,[pool_037FBD24]	; 037FBB34
	ldr r0,[pool_037FBD10]	; 037FBB36
	strh r2,[r0,#0x0]	; 037FBB38
	mov r2,#0xd	; 037FBB3A
	ldr r0,[pool_037FBD14]	; 037FBB3C
	strh r2,[r0,#0x0]	; 037FBB3E
	ldr r0,[pool_037FBD28]	; 037FBB40
	strh r0,[r1,#0x0]	; 037FBB42
	mov r1,#0x1	; 037FBB44
	ldr r0,[pool_037FBD1C]	; 037FBB46
	strh r1,[r0,#0x0]	; 037FBB48
	add r5,sp,#0x0	; 037FBB4A
	ldr r0,[pool_037FBD2C]	; 037FBB4C
	ldrh r0,[r0,#0x0]	; 037FBB4E
	strh r0,[r5,#0x0]	; 037FBB50
	ldr r0,[pool_037FBD30]	; 037FBB52
	ldrh r0,[r0,#0x0]	; 037FBB54
	strh r0,[r5,#0x2]	; 037FBB56
	ldr r0,[pool_037FBD34]	; 037FBB58
	ldrh r0,[r0,#0x0]	; 037FBB5A
	strh r0,[r5,#0x4]	; 037FBB5C
	ldr r0,[pool_037FBD38]	; 037FBB5E
	ldrh r0,[r0,#0x0]	; 037FBB60
	strh r0,[r5,#0x6]	; 037FBB62
	add r0,r4,#0x0	; 037FBB64
	add r0,#0x6e	; 037FBB66
	ldrh r0,[r0,#0x0]	; 037FBB68
	lsl r7,r0,#0xa	; 037FBB6A
	ldr r0,[sp,#0x0]	; 037FBB6C
	ldr r1,[sp,#0x4]	; 037FBB6E
	add r2,r7,#0x0	; 037FBB70
	add r3,r6,#0x0	; 037FBB72
	bl loc_037FBD9C	; 037FBB74
	str r0,[sp,#0x0]	; 037FBB78
	str r1,[sp,#0x4]	; 037FBB7A
	lsl r3,r6,#0	; 037FBB7C
	mov r2,#0x1	; 037FBB7E
	add r0,r0,r2	; 037FBB80
	adc r1,r3	; 037FBB82
	str r0,[sp,#0x0]	; 037FBB84
	str r1,[sp,#0x4]	; 037FBB86
	add r2,r7,#0x0	; 037FBB88
	bl loc_037FBDA8	; 037FBB8A
	str r0,[sp,#0x0]	; 037FBB8E
	str r1,[sp,#0x4]	; 037FBB90
	ldrh r1,[r5,#0x6]	; 037FBB92
	ldr r0,[pool_037FBD3C]	; 037FBB94
	strh r1,[r0,#0x0]	; 037FBB96
	ldrh r1,[r5,#0x4]	; 037FBB98
	ldr r0,[pool_037FBD40]	; 037FBB9A
	strh r1,[r0,#0x0]	; 037FBB9C
	ldrh r1,[r5,#0x2]	; 037FBB9E
	ldr r0,[pool_037FBD44]	; 037FBBA0
	strh r1,[r0,#0x0]	; 037FBBA2
	ldrh r2,[r5,#0x0]	; 037FBBA4
	mov r1,#0x1	; 037FBBA6
	orr r2,r1	; 037FBBA8
	ldr r0,[pool_037FBD48]	; 037FBBAA
	strh r2,[r0,#0x0]	; 037FBBAC
	ldr r0,[pool_037FBD18]	; 037FBBAE
	strh r1,[r0,#0x0]	; 037FBBB0
	ldr r0,[pool_037FBD4C]	; 037FBBB2
	strh r1,[r0,#0x0]	; 037FBBB4
	mov r0,#0x40	; 037FBBB6
	bl loc_037FBECC	; 037FBBB8
	bl loc_037FBDB4	; 037FBBBC
	mov r1,#0x2	; 037FBBC0
	ldr r0,[pool_037FBD50]	; 037FBBC2
	strh r1,[r0,#0x0]	; 037FBBC4
	b loc_037FBC94	; 037FBBC6
loc_037FBBC8:
	ldr r1,[pool_037FBD54]	; 037FBBC8
	ldr r0,[pool_037FBD0C]	; 037FBBCA
	strh r1,[r0,#0x0]	; 037FBBCC
	ldr r1,[pool_037FBCBC]	; 037FBBCE
	ldr r2,[r1,#0x0]	; 037FBBD0
	ldr r1,[pool_037FBCF8]	; 037FBBD2
	ldrh r2,[r2,r1]	; 037FBBD4
	mov r1,#0x20	; 037FBBD6
	and r2,r1	; 037FBBD8
	cmp r2,#0x0	; 037FBBDA
	beq loc_037FBBE6	; 037FBBDC
	ldrh r2,[r0,#0x0]	; 037FBBDE
	mov r1,#0xc0	; 037FBBE0
	orr r2,r1	; 037FBBE2
	strh r2,[r0,#0x0]	; 037FBBE4
loc_037FBBE6:
	ldr r0,[pool_037FBCBC]	; 037FBBE6
	ldr r1,[r0,#0x0]	; 037FBBE8
	ldr r0,[pool_037FBCF8]	; 037FBBEA
	ldrh r1,[r1,r0]	; 037FBBEC
	mov r0,#0x20	; 037FBBEE
	and r1,r0	; 037FBBF0
	cmp r1,#0x0	; 037FBBF2
	beq loc_037FBC00	; 037FBBF4
	ldr r2,[pool_037FBD00]	; 037FBBF6
	ldrh r1,[r2,#0x0]	; 037FBBF8
	mov r0,#0x68	; 037FBBFA
	orr r1,r0	; 037FBBFC
	strh r1,[r2,#0x0]	; 037FBBFE
loc_037FBC00:
	add r0,r4,#0x0	; 037FBC00
	add r0,#0x64	; 037FBC02
	ldrh r1,[r0,#0x0]	; 037FBC04
	mov r0,#0x1	; 037FBC06
	and r1,r0	; 037FBC08
	cmp r1,#0x0	; 037FBC0A
	beq loc_037FBC16	; 037FBC0C
	ldr r1,[pool_037FBD58]	; 037FBC0E
	ldr r0,[pool_037FBD10]	; 037FBC10
	strh r1,[r0,#0x0]	; 037FBC12
	b loc_037FBC1C	; 037FBC14
loc_037FBC16:
	ldr r1,[pool_037FBD5C]	; 037FBC16
	ldr r0,[pool_037FBD10]	; 037FBC18
	strh r1,[r0,#0x0]	; 037FBC1A
loc_037FBC1C:
	mov r1,#0xb	; 037FBC1C
	ldr r0,[pool_037FBD14]	; 037FBC1E
	strh r1,[r0,#0x0]	; 037FBC20
	mov r1,#0x1	; 037FBC22
	ldr r0,[pool_037FBD1C]	; 037FBC24
	strh r1,[r0,#0x0]	; 037FBC26
	ldr r0,[pool_037FBD18]	; 037FBC28
	strh r1,[r0,#0x0]	; 037FBC2A
	ldr r0,[pool_037FBD4C]	; 037FBC2C
	strh r1,[r0,#0x0]	; 037FBC2E
	mov r0,#0x20	; 037FBC30
	bl loc_037FBECC	; 037FBC32
	b loc_037FBC94	; 037FBC36
loc_037FBC38:
	ldr r1,[pool_037FBCD4]	; 037FBC38
	ldr r0,[pool_037FBCEC]	; 037FBC3A
	strh r1,[r0,#0x0]	; 037FBC3C
	ldr r1,[pool_037FBD60]	; 037FBC3E
	ldr r0,[pool_037FBD0C]	; 037FBC40
	strh r1,[r0,#0x0]	; 037FBC42
	add r0,r4,#0x0	; 037FBC44
	add r0,#0x64	; 037FBC46
	ldrh r0,[r0,#0x0]	; 037FBC48
	mov r1,#0x1	; 037FBC4A
	and r0,r1	; 037FBC4C
	cmp r0,#0x0	; 037FBC4E
	beq loc_037FBC5A	; 037FBC50
	ldr r1,[pool_037FBD64]	; 037FBC52
	ldr r0,[pool_037FBD10]	; 037FBC54
	strh r1,[r0,#0x0]	; 037FBC56
	b loc_037FBC5E	; 037FBC58
loc_037FBC5A:
	ldr r0,[pool_037FBD10]	; 037FBC5A
	strh r1,[r0,#0x0]	; 037FBC5C
loc_037FBC5E:
	mov r1,#0xb	; 037FBC5E
	ldr r0,[pool_037FBD14]	; 037FBC60
	strh r1,[r0,#0x0]	; 037FBC62
	mov r1,#0x1	; 037FBC64
	ldr r0,[pool_037FBD1C]	; 037FBC66
	strh r1,[r0,#0x0]	; 037FBC68
	ldr r0,[pool_037FBD18]	; 037FBC6A
	strh r1,[r0,#0x0]	; 037FBC6C
	ldr r0,[pool_037FBD4C]	; 037FBC6E
	strh r1,[r0,#0x0]	; 037FBC70
	mov r1,#0x0	; 037FBC72
	ldr r0,[pool_037FBD68]	; 037FBC74
	strh r1,[r0,#0x0]	; 037FBC76
	mov r0,#0x20	; 037FBC78
	bl loc_037FBECC	; 037FBC7A
	b loc_037FBC94	; 037FBC7E
loc_037FBC80:
	ldr r0,[pool_037FBD0C]	; 037FBC80
	strh r6,[r0,#0x0]	; 037FBC82
	ldr r0,[pool_037FBCF4]	; 037FBC84
	strh r6,[r0,#0x0]	; 037FBC86
	mov r1,#0x1	; 037FBC88
	ldr r0,[pool_037FBD1C]	; 037FBC8A
	strh r1,[r0,#0x0]	; 037FBC8C
	mov r0,#0x20	; 037FBC8E
	bl loc_037FBECC	; 037FBC90
loc_037FBC94:
	mov r1,#0x0	; 037FBC94
	ldr r0,[pool_037FBD68]	; 037FBC96
	strh r1,[r0,#0x0]	; 037FBC98
	bl loc_037FBDC4	; 037FBC9A
	mov r0,#0x2	; 037FBC9E
	ldr r1,[pool_037FBD50]	; 037FBCA0
	strh r0,[r1,#0x0]	; 037FBCA2
	ldrh r1,[r4,#0xe]	; 037FBCA4
	cmp r1,#0x1	; 037FBCA6
	bne loc_037FBCAE	; 037FBCA8
	bl loc_037FBDD4	; 037FBCAA
loc_037FBCAE:
	bl loc_037FBDE4	; 037FBCAE
	add sp,#0xc	; 037FBCB2
	pop {r4,r5,r6,r7}	; 037FBCB4
	pop {r3}	; 037FBCB6
	bx r3	; 037FBCB8
	.byte 0xC0, 0x46	; 037FBCBC
pool_037FBCBC:
loc_037FBCBC:
	.word FirmwareWlWorkPointerSlot	; 037FBCBC
pool_037FBCC0:
loc_037FBCC0:
	.word 0x00000318	; 037FBCC0
pool_037FBCC4:
loc_037FBCC4:
	.word 0x000002F0	; 037FBCC4
pool_037FBCC8:
loc_037FBCC8:
	.word REG_WIFI_RANDOM	; 037FBCC8
pool_037FBCCC:
loc_037FBCCC:
	.word 0x00008000	; 037FBCCC
pool_037FBCD0:
loc_037FBCD0:
	.word REG_WIFI_WEP_CNT	; 037FBCD0
pool_037FBCD4:
loc_037FBCD4:
	.word 0x0000FFFF	; 037FBCD4
pool_037FBCD8:
loc_037FBCD8:
	.word REG_WIFI_POST_BEACON	; 037FBCD8
pool_037FBCDC:
loc_037FBCDC:
	.word REG_WIFI_AID_FULL	; 037FBCDC
pool_037FBCE0:
loc_037FBCE0:
	.word REG_WIFI_AID_LOW	; 037FBCE0
pool_037FBCE4:
loc_037FBCE4:
	.word REG_WIFI_POWER_TX	; 037FBCE4
pool_037FBCE8:
loc_037FBCE8:
	.word REG_WIFI_RXCNT	; 037FBCE8
pool_037FBCEC:
loc_037FBCEC:
	.word REG_WIFI_IF	; 037FBCEC
pool_037FBCF0:
loc_037FBCF0:
	.word 0x00001FFF	; 037FBCF0
pool_037FBCF4:
loc_037FBCF4:
	.word REG_WIFI_RXSTAT_OVF_IE	; 037FBCF4
pool_037FBCF8:
loc_037FBCF8:
	.word 0x00000638	; 037FBCF8
pool_037FBCFC:
loc_037FBCFC:
	.word 0x00000400	; 037FBCFC
pool_037FBD00:
loc_037FBD00:
	.word REG_WIFI_RXSTAT_INC_IE	; 037FBD00
pool_037FBD04:
loc_037FBD04:
	.word REG_WIFI_TXSTATCNT	; 037FBD04
pool_037FBD08:
loc_037FBD08:
	.word REG_WIFI_UNKNOWN_00A	; 037FBD08
pool_037FBD0C:
loc_037FBD0C:
	.word REG_WIFI_IE	; 037FBD0C
pool_037FBD10:
loc_037FBD10:
	.word REG_WIFI_RXFILTER	; 037FBD10
pool_037FBD14:
loc_037FBD14:
	.word REG_WIFI_RXFILTER2	; 037FBD14
pool_037FBD18:
loc_037FBD18:
	.word REG_WIFI_US_COUNTCNT	; 037FBD18
pool_037FBD1C:
loc_037FBD1C:
	.word REG_WIFI_MODE_RST	; 037FBD1C
pool_037FBD20:
loc_037FBD20:
	.word 0x0000703F	; 037FBD20
pool_037FBD24:
loc_037FBD24:
	.word 0x00000301	; 037FBD24
pool_037FBD28:
loc_037FBD28:
	.word 0x0000E000	; 037FBD28
pool_037FBD2C:
loc_037FBD2C:
	.word REG_WIFI_US_COUNT0	; 037FBD2C
pool_037FBD30:
loc_037FBD30:
	.word REG_WIFI_US_COUNT1	; 037FBD30
pool_037FBD34:
loc_037FBD34:
	.word REG_WIFI_US_COUNT2	; 037FBD34
pool_037FBD38:
loc_037FBD38:
	.word REG_WIFI_US_COUNT3	; 037FBD38
pool_037FBD3C:
loc_037FBD3C:
	.word REG_WIFI_US_COMPARE3	; 037FBD3C
pool_037FBD40:
loc_037FBD40:
	.word REG_WIFI_US_COMPARE2	; 037FBD40
pool_037FBD44:
loc_037FBD44:
	.word REG_WIFI_US_COMPARE1	; 037FBD44
pool_037FBD48:
loc_037FBD48:
	.word REG_WIFI_US_COMPARE0	; 037FBD48
pool_037FBD4C:
loc_037FBD4C:
	.word REG_WIFI_US_COMPARECNT	; 037FBD4C
pool_037FBD50:
loc_037FBD50:
	.word REG_WIFI_TXREQ_SET	; 037FBD50
pool_037FBD54:
loc_037FBD54:
	.word 0x0000E03F	; 037FBD54
pool_037FBD58:
loc_037FBD58:
	.word 0x00000581	; 037FBD58
pool_037FBD5C:
loc_037FBD5C:
	.word 0x00000181	; 037FBD5C
pool_037FBD60:
loc_037FBD60:
	.word 0x0000C03F	; 037FBD60
pool_037FBD64:
loc_037FBD64:
	.word 0x00000401	; 037FBD64
pool_037FBD68:
loc_037FBD68:
	.word REG_WIFI_UNKNOWN_048	; 037FBD68

; ===== function loc_037FBD6C =====
loc_037FBD6C:
	bx pc	; 037FBD6C
	.byte 0xC0, 0x46	; 037FBD70
.arm

; ===== function loc_037FBD70 =====
loc_037FBD70:
	ldr r12,[pool_037FBD78]	; 037FBD70
	bx r12	; 037FBD74
pool_037FBD78:
loc_037FBD78:
	.word loc_0230515C + 1	; 037FBD78
.thumb

; ===== function loc_037FBD7C =====
loc_037FBD7C:
	bx pc	; 037FBD7C
	.byte 0xC0, 0x46	; 037FBD80
.arm

; ===== function loc_037FBD80 =====
loc_037FBD80:
	ldr r12,[pool_037FBD88]	; 037FBD80
	bx r12	; 037FBD84
pool_037FBD88:
loc_037FBD88:
	.word P4_Entry_02306EE0 + 1	; 037FBD88
.thumb

; ===== function loc_037FBD8C =====
loc_037FBD8C:
	bx pc	; 037FBD8C
	.byte 0xC0, 0x46	; 037FBD90
.arm

; ===== function loc_037FBD90 =====
loc_037FBD90:
	ldr r12,[pool_037FBD98]	; 037FBD90
	bx r12	; 037FBD94
pool_037FBD98:
loc_037FBD98:
	.word P4_Entry_0230D1C8 + 1	; 037FBD98
.thumb

; ===== function loc_037FBD9C =====
loc_037FBD9C:
	bx pc	; 037FBD9C
	.byte 0xC0, 0x46	; 037FBDA0
.arm

; ===== function loc_037FBDA0 =====
loc_037FBDA0:
	ldr pc,[pool_037FBDA4]	; 037FBDA0
pool_037FBDA4:
loc_037FBDA4:
	.word loc_03804994	; 037FBDA4
.thumb

; ===== function loc_037FBDA8 =====
loc_037FBDA8:
	bx pc	; 037FBDA8
	.byte 0xC0, 0x46	; 037FBDAC
.arm

; ===== function loc_037FBDAC =====
loc_037FBDAC:
	ldr pc,[pool_037FBDB0]	; 037FBDAC
pool_037FBDB0:
loc_037FBDB0:
	.word loc_03804B9C	; 037FBDB0
.thumb

; ===== function loc_037FBDB4 =====
loc_037FBDB4:
	bx pc	; 037FBDB4
	.byte 0xC0, 0x46	; 037FBDB8
.arm

; ===== function loc_037FBDB8 =====
loc_037FBDB8:
	ldr r12,[pool_037FBDC0]	; 037FBDB8
	bx r12	; 037FBDBC
pool_037FBDC0:
loc_037FBDC0:
	.word P4_Entry_0230A3B4 + 1	; 037FBDC0
.thumb

; ===== function loc_037FBDC4 =====
loc_037FBDC4:
	bx pc	; 037FBDC4
	.byte 0xC0, 0x46	; 037FBDC8
.arm

; ===== function loc_037FBDC8 =====
loc_037FBDC8:
	ldr r12,[pool_037FBDD0]	; 037FBDC8
	bx r12	; 037FBDCC
pool_037FBDD0:
loc_037FBDD0:
	.word loc_02305D24 + 1	; 037FBDD0
.thumb

; ===== function loc_037FBDD4 =====
loc_037FBDD4:
	bx pc	; 037FBDD4
	.byte 0xC0, 0x46	; 037FBDD8
.arm

; ===== function loc_037FBDD8 =====
loc_037FBDD8:
	ldr r12,[pool_037FBDE0]	; 037FBDD8
	bx r12	; 037FBDDC
pool_037FBDE0:
loc_037FBDE0:
	.word loc_02305E90 + 1	; 037FBDE0
.thumb

; ===== function loc_037FBDE4 =====
loc_037FBDE4:
	bx pc	; 037FBDE4
	.byte 0xC0, 0x46	; 037FBDE8
.arm

; ===== function loc_037FBDE8 =====
loc_037FBDE8:
	ldr r12,[pool_037FBDF0]	; 037FBDE8
	bx r12	; 037FBDEC
pool_037FBDF0:
loc_037FBDF0:
	.word P4_Entry_02307810 + 1	; 037FBDF0
.thumb

; ===== function loc_037FBDF4 =====
loc_037FBDF4:
	push {r4,lr}	; 037FBDF4
	ldr r0,[pool_037FBE50]	; 037FBDF6
	ldr r1,[r0,#0x0]	; 037FBDF8
	ldr r0,[pool_037FBE54]	; 037FBDFA
	add r4,r1,r0	; 037FBDFC
	bl loc_037FBE7C	; 037FBDFE
	bl loc_037FBE8C	; 037FBE02
	mov r0,#0x20	; 037FBE06
	bl loc_037FBECC	; 037FBE08
	mov r0,#0x0	; 037FBE0C
	add r1,r4,#0x0	; 037FBE0E
	add r1,#0xa4	; 037FBE10
	strh r0,[r1,#0x0]	; 037FBE12
	strh r0,[r4,#0x12]	; 037FBE14
	ldr r1,[pool_037FBE58]	; 037FBE16
	strh r0,[r1,#0x0]	; 037FBE18
	ldr r1,[pool_037FBE5C]	; 037FBE1A
	strh r0,[r1,#0x0]	; 037FBE1C
	ldr r1,[pool_037FBE60]	; 037FBE1E
	strh r0,[r1,#0x0]	; 037FBE20
	ldr r1,[pool_037FBE64]	; 037FBE22
	strh r0,[r1,#0x0]	; 037FBE24
	ldr r1,[pool_037FBE68]	; 037FBE26
	strh r0,[r1,#0x0]	; 037FBE28
	ldr r1,[pool_037FBE6C]	; 037FBE2A
	strh r0,[r1,#0x0]	; 037FBE2C
	ldrh r0,[r4,#0xc]	; 037FBE2E
	cmp r0,#0x1	; 037FBE30
	bne loc_037FBE38	; 037FBE32
	bl loc_037FBE9C	; 037FBE34
loc_037FBE38:
	ldr r1,[pool_037FBE70]	; 037FBE38
	ldr r0,[pool_037FBE74]	; 037FBE3A
	strh r1,[r0,#0x0]	; 037FBE3C
	ldr r0,[pool_037FBE78]	; 037FBE3E
	strh r1,[r0,#0x0]	; 037FBE40
	bl loc_037FBEAC	; 037FBE42
	bl loc_037FBEBC	; 037FBE46
	pop {r4}	; 037FBE4A
	pop {r3}	; 037FBE4C
	bx r3	; 037FBE4E
pool_037FBE50:
loc_037FBE50:
	.word FirmwareWlWorkPointerSlot	; 037FBE50
pool_037FBE54:
loc_037FBE54:
	.word 0x00000318	; 037FBE54
pool_037FBE58:
loc_037FBE58:
	.word REG_WIFI_IE	; 037FBE58
pool_037FBE5C:
loc_037FBE5C:
	.word REG_WIFI_MODE_RST	; 037FBE5C
pool_037FBE60:
loc_037FBE60:
	.word REG_WIFI_US_COMPARECNT	; 037FBE60
pool_037FBE64:
loc_037FBE64:
	.word REG_WIFI_US_COUNTCNT	; 037FBE64
pool_037FBE68:
loc_037FBE68:
	.word REG_WIFI_TXSTATCNT	; 037FBE68
pool_037FBE6C:
loc_037FBE6C:
	.word REG_WIFI_UNKNOWN_00A	; 037FBE6C
pool_037FBE70:
loc_037FBE70:
	.word 0x0000FFFF	; 037FBE70
pool_037FBE74:
loc_037FBE74:
	.word REG_WIFI_TXREQ_RESET	; 037FBE74
pool_037FBE78:
loc_037FBE78:
	.word REG_WIFI_TXBUF_RESET	; 037FBE78

; ===== function loc_037FBE7C =====
loc_037FBE7C:
	bx pc	; 037FBE7C
	.byte 0xC0, 0x46	; 037FBE80
.arm

; ===== function loc_037FBE80 =====
loc_037FBE80:
	ldr r12,[pool_037FBE88]	; 037FBE80
	bx r12	; 037FBE84
pool_037FBE88:
loc_037FBE88:
	.word P4_Entry_02305468 + 1	; 037FBE88
.thumb

; ===== function loc_037FBE8C =====
loc_037FBE8C:
	bx pc	; 037FBE8C
	.byte 0xC0, 0x46	; 037FBE90
.arm

; ===== function loc_037FBE90 =====
loc_037FBE90:
	ldr r12,[pool_037FBE98]	; 037FBE90
	bx r12	; 037FBE94
pool_037FBE98:
loc_037FBE98:
	.word loc_02305358 + 1	; 037FBE98
.thumb

; ===== function loc_037FBE9C =====
loc_037FBE9C:
	bx pc	; 037FBE9C
	.byte 0xC0, 0x46	; 037FBEA0
.arm

; ===== function loc_037FBEA0 =====
loc_037FBEA0:
	ldr r12,[pool_037FBEA8]	; 037FBEA0
	bx r12	; 037FBEA4
pool_037FBEA8:
loc_037FBEA8:
	.word P4_Entry_0230A398 + 1	; 037FBEA8
.thumb

; ===== function loc_037FBEAC =====
loc_037FBEAC:
	bx pc	; 037FBEAC
	.byte 0xC0, 0x46	; 037FBEB0
.arm

; ===== function loc_037FBEB0 =====
loc_037FBEB0:
	ldr r12,[pool_037FBEB8]	; 037FBEB0
	bx r12	; 037FBEB4
pool_037FBEB8:
loc_037FBEB8:
	.word P4_Entry_0230A520 + 1	; 037FBEB8
.thumb

; ===== function loc_037FBEBC =====
loc_037FBEBC:
	bx pc	; 037FBEBC
	.byte 0xC0, 0x46	; 037FBEC0
.arm

; ===== function loc_037FBEC0 =====
loc_037FBEC0:
	ldr r12,[pool_037FBEC8]	; 037FBEC0
	bx r12	; 037FBEC4
pool_037FBEC8:
loc_037FBEC8:
	.word P4_Entry_02304C4C + 1	; 037FBEC8
.thumb

; ===== function loc_037FBECC =====
loc_037FBECC:
	push {r4,r5,lr}	; 037FBECC
	sub sp,#0x4	; 037FBECE
	add r5,r0,#0x0	; 037FBED0
	ldr r0,[pool_037FBF28]	; 037FBED2
	ldr r1,[r0,#0x0]	; 037FBED4
	ldr r0,[pool_037FBF2C]	; 037FBED6
	add r4,r1,r0	; 037FBED8
	ldrh r0,[r4,#0x8]	; 037FBEDA
	cmp r0,r5	; 037FBEDC
	beq loc_037FBF20	; 037FBEDE
	cmp r0,#0x40	; 037FBEE0
	bne loc_037FBEE8	; 037FBEE2
	bl loc_037FBE8C	; 037FBEE4
loc_037FBEE8:
	cmp r5,#0x0	; 037FBEE8
	beq loc_037FBEF6	; 037FBEEA
	cmp r5,#0x10	; 037FBEEC
	beq loc_037FBEFC	; 037FBEEE
	cmp r5,#0x40	; 037FBEF0
	beq loc_037FBF0C	; 037FBEF2
	b loc_037FBF1E	; 037FBEF4
loc_037FBEF6:
	bl loc_037FBF34	; 037FBEF6
	b loc_037FBF1E	; 037FBEFA
loc_037FBEFC:
	mov r0,#0x0	; 037FBEFC
	bl loc_037FBF44	; 037FBEFE
	bl loc_037FBDF4	; 037FBF02
	bl loc_037FBF54	; 037FBF06
	b loc_037FBF1E	; 037FBF0A
loc_037FBF0C:
	ldrh r0,[r4,#0xc]	; 037FBF0C
	cmp r0,#0x2	; 037FBF0E
	bne loc_037FBF16	; 037FBF10
	bl loc_037FBF64	; 037FBF12
loc_037FBF16:
	mov r0,#0x64	; 037FBF16
	ldr r1,[pool_037FBF30]	; 037FBF18
	bl loc_037FBF74	; 037FBF1A
loc_037FBF1E:
	strh r5,[r4,#0x8]	; 037FBF1E
loc_037FBF20:
	add sp,#0x4	; 037FBF20
	pop {r4,r5}	; 037FBF22
	pop {r3}	; 037FBF24
	bx r3	; 037FBF26
pool_037FBF28:
loc_037FBF28:
	.word FirmwareWlWorkPointerSlot	; 037FBF28
pool_037FBF2C:
loc_037FBF2C:
	.word 0x00000318	; 037FBF2C
pool_037FBF30:
loc_037FBF30:
	.word P4_Entry_02305408 + 1	; 037FBF30

; ===== function loc_037FBF34 =====
loc_037FBF34:
	bx pc	; 037FBF34
	.byte 0xC0, 0x46	; 037FBF38
.arm

; ===== function loc_037FBF38 =====
loc_037FBF38:
	ldr r12,[pool_037FBF40]	; 037FBF38
	bx r12	; 037FBF3C
pool_037FBF40:
loc_037FBF40:
	.word loc_02305E30 + 1	; 037FBF40
.thumb

; ===== function loc_037FBF44 =====
loc_037FBF44:
	bx pc	; 037FBF44
	.byte 0xC0, 0x46	; 037FBF48
.arm

; ===== function loc_037FBF48 =====
loc_037FBF48:
	ldr r12,[pool_037FBF50]	; 037FBF48
	bx r12	; 037FBF4C
pool_037FBF50:
loc_037FBF50:
	.word loc_02305E84 + 1	; 037FBF50
.thumb

; ===== function loc_037FBF54 =====
loc_037FBF54:
	bx pc	; 037FBF54
	.byte 0xC0, 0x46	; 037FBF58
.arm

; ===== function loc_037FBF58 =====
loc_037FBF58:
	ldr r12,[pool_037FBF60]	; 037FBF58
	bx r12	; 037FBF5C
pool_037FBF60:
loc_037FBF60:
	.word loc_02305DC8 + 1	; 037FBF60
.thumb

; ===== function loc_037FBF64 =====
loc_037FBF64:
	bx pc	; 037FBF64
	.byte 0xC0, 0x46	; 037FBF68
.arm

; ===== function loc_037FBF68 =====
loc_037FBF68:
	ldr r12,[pool_037FBF70]	; 037FBF68
	bx r12	; 037FBF6C
pool_037FBF70:
loc_037FBF70:
	.word loc_02305D00 + 1	; 037FBF70
.thumb

; ===== function loc_037FBF74 =====
loc_037FBF74:
	bx pc	; 037FBF74
	.byte 0xC0, 0x46	; 037FBF78
.arm

; ===== function loc_037FBF78 =====
loc_037FBF78:
	ldr r12,[pool_037FBF80]	; 037FBF78
	bx r12	; 037FBF7C
pool_037FBF80:
loc_037FBF80:
	.word P4_Entry_02305480 + 1	; 037FBF80
.thumb
P2_IrqHandler_037FBF84:
	push {r4,r5,r6,r7,lr}	; 037FBF84
	sub sp,#0x4	; 037FBF86
	mov r7,#0x1	; 037FBF88
	ldr r4,[pool_037FC054]	; 037FBF8A
	ldr r6,[pool_037FC058]	; 037FBF8C
P2_Entry_037FBF8E:
	ldrh r5,[r4,#0x0]	; 037FBF8E
	ldrh r0,[r6,#0x0]	; 037FBF90
	and r5,r0	; 037FBF92
	cmp r5,#0x0	; 037FBF94
	beq P2_Entry_037FC040	; 037FBF96
	add r1,r5,#0x0	; 037FBF98
	mov r0,#0x80	; 037FBF9A
	and r1,r0	; 037FBF9C
	cmp r1,#0x0	; 037FBF9E
	beq P2_Entry_037FBFA6	; 037FBFA0
	bl P2_Entry_037FCAB0	; 037FBFA2
P2_Entry_037FBFA6:
	add r1,r5,#0x0	; 037FBFA6
	mov r0,#0x40	; 037FBFA8
	and r1,r0	; 037FBFAA
	cmp r1,#0x0	; 037FBFAC
	beq P2_Entry_037FBFB4	; 037FBFAE
	bl P2_Entry_037FCB30	; 037FBFB0
P2_Entry_037FBFB4:
	add r1,r5,#0x0	; 037FBFB4
	ldr r0,[pool_037FC05C]	; 037FBFB6
	and r1,r0	; 037FBFB8
	cmp r1,#0x0	; 037FBFBA
	beq P2_Entry_037FBFC2	; 037FBFBC
	bl P2_Entry_037FC088	; 037FBFBE
P2_Entry_037FBFC2:
	add r1,r5,#0x0	; 037FBFC2
	ldr r0,[pool_037FC060]	; 037FBFC4
	and r1,r0	; 037FBFC6
	cmp r1,#0x0	; 037FBFC8
	beq P2_Entry_037FBFD0	; 037FBFCA
	bl P2_Entry_037FC100	; 037FBFCC
P2_Entry_037FBFD0:
	add r1,r5,#0x0	; 037FBFD0
	ldr r0,[pool_037FC064]	; 037FBFD2
	and r1,r0	; 037FBFD4
	cmp r1,#0x0	; 037FBFD6
	beq P2_Entry_037FBFDE	; 037FBFD8
	bl P2_Entry_037FC348	; 037FBFDA
P2_Entry_037FBFDE:
	add r1,r5,#0x0	; 037FBFDE
	ldr r0,[pool_037FC068]	; 037FBFE0
	and r1,r0	; 037FBFE2
	cmp r1,#0x0	; 037FBFE4
	beq P2_Entry_037FBFEC	; 037FBFE6
	bl P2_Entry_037FC078	; 037FBFE8
P2_Entry_037FBFEC:
	add r1,r5,#0x0	; 037FBFEC
	mov r0,#0x8	; 037FBFEE
	and r1,r0	; 037FBFF0
	cmp r1,#0x0	; 037FBFF2
	beq P2_Entry_037FBFFA	; 037FBFF4
	bl P2_Entry_037FC3D8	; 037FBFF6
P2_Entry_037FBFFA:
	add r1,r5,#0x0	; 037FBFFA
	mov r0,#0x4	; 037FBFFC
	and r1,r0	; 037FBFFE
	cmp r1,#0x0	; 037FC000
	beq P2_Entry_037FC008	; 037FC002
	bl P2_Entry_037FC4B4	; 037FC004
P2_Entry_037FC008:
	add r0,r5,#0x0	; 037FC008
	and r0,r7	; 037FC00A
	cmp r0,#0x0	; 037FC00C
	beq P2_Entry_037FC014	; 037FC00E
	bl P2_Entry_037FC7FC	; 037FC010
P2_Entry_037FC014:
	add r1,r5,#0x0	; 037FC014
	mov r0,#0x30	; 037FC016
	and r1,r0	; 037FC018
	cmp r1,#0x0	; 037FC01A
	beq P2_Entry_037FC022	; 037FC01C
	bl P2_Entry_037FC3A0	; 037FC01E
P2_Entry_037FC022:
	add r1,r5,#0x0	; 037FC022
	mov r0,#0x2	; 037FC024
	and r1,r0	; 037FC026
	cmp r1,#0x0	; 037FC028
	beq P2_Entry_037FC030	; 037FC02A
	bl P2_Entry_037FC624	; 037FC02C
P2_Entry_037FC030:
	ldr r0,[pool_037FC06C]	; 037FC030
	and r5,r0	; 037FC032
	cmp r5,#0x0	; 037FC034
	beq P2_Entry_037FBF8E	; 037FC036
	add r0,r7,#0x0	; 037FC038
	bl P2_Entry_037FC9F0	; 037FC03A
	b P2_Entry_037FBF8E	; 037FC03E
P2_Entry_037FC040:
	ldr r2,[pool_037FC070]	; 037FC040
	ldr r1,[r2,#0x0]	; 037FC042
	ldr r0,[pool_037FC074]	; 037FC044
	orr r1,r0	; 037FC046
	str r1,[r2,#0x0]	; 037FC048
	add sp,#0x4	; 037FC04A
	pop {r4,r5,r6,r7}	; 037FC04C
	pop {r3}	; 037FC04E
	bx r3	; 037FC050
	.byte 0xC0, 0x46	; 037FC052
pool_037FC054:
	.word REG_WIFI_IF	; 037FC054
pool_037FC058:
	.word REG_WIFI_IE	; 037FC058
pool_037FC05C:
	.word 0x00008000	; 037FC05C
pool_037FC060:
	.word 0x00004000	; 037FC060
pool_037FC064:
	.word 0x00002000	; 037FC064
pool_037FC068:
	.word 0x00000800	; 037FC068
pool_037FC06C:
	.word 0x00001000	; 037FC06C
pool_037FC070:
	.word Bios7IrqFlagsAddress	; 037FC070
pool_037FC074:
	.word 0x01000000	; 037FC074
P2_Entry_037FC078:
	bx pc	; 037FC078
	.byte 0xC0, 0x46	; 037FC07A
.arm
	ldr r12,[pool_037FC084]	; 037FC07C
	bx r12	; 037FC080
pool_037FC084:
	.word P4_Entry_02306E3C + 1	; 037FC084
P2_Entry_037FC088:
.thumb
	push {r4,lr}	; 037FC088
	ldr r0,[pool_037FC0F0]	; 037FC08A
	ldr r1,[r0,#0x0]	; 037FC08C
	ldr r0,[pool_037FC0F4]	; 037FC08E
	add r4,r1,r0	; 037FC090
	ldr r1,[pool_037FC0F8]	; 037FC092
	ldr r0,[pool_037FC0FC]	; 037FC094
	strh r1,[r0,#0x0]	; 037FC096
	ldrh r0,[r4,#0x8]	; 037FC098
	cmp r0,#0x40	; 037FC09A
	bne P2_Entry_037FC0E6	; 037FC09C
	add r0,r4,#0x0	; 037FC09E
	add r0,#0x7e	; 037FC0A0
	ldrh r0,[r0,#0x0]	; 037FC0A2
	cmp r0,#0x0	; 037FC0A4
	beq P2_Entry_037FC0E6	; 037FC0A6
	add r0,r4,#0x0	; 037FC0A8
	add r0,#0x72	; 037FC0AA
	ldrh r1,[r0,#0x0]	; 037FC0AC
	add r0,r4,#0x0	; 037FC0AE
	add r0,#0x70	; 037FC0B0
	ldrh r0,[r0,#0x0]	; 037FC0B2
	cmp r1,r0	; 037FC0B4
	bne P2_Entry_037FC0E6	; 037FC0B6
	add r0,r4,#0x0	; 037FC0B8
	add r0,#0x80	; 037FC0BA
	ldrh r0,[r0,#0x0]	; 037FC0BC
	add r1,r0,#0x1	; 037FC0BE
	add r0,r4,#0x0	; 037FC0C0
	add r0,#0x80	; 037FC0C2
	strh r1,[r0,#0x0]	; 037FC0C4
	add r0,r4,#0x0	; 037FC0C6
	add r0,#0x80	; 037FC0C8
	ldrh r1,[r0,#0x0]	; 037FC0CA
	add r0,r4,#0x0	; 037FC0CC
	add r0,#0x7e	; 037FC0CE
	ldrh r0,[r0,#0x0]	; 037FC0D0
	cmp r1,r0	; 037FC0D2
	bls P2_Entry_037FC0E6	; 037FC0D4
	mov r1,#0x0	; 037FC0D6
	add r0,r4,#0x0	; 037FC0D8
	add r0,#0x80	; 037FC0DA
	strh r1,[r0,#0x0]	; 037FC0DC
	mov r0,#0x1	; 037FC0DE
	mov r1,#0xd	; 037FC0E0
	bl loc_037FB418	; 037FC0E2
P2_Entry_037FC0E6:
	mov r0,#0x1	; 037FC0E6
	strh r0,[r4,#0x10]	; 037FC0E8
	pop {r4}	; 037FC0EA
	pop {r3}	; 037FC0EC
	bx r3	; 037FC0EE
pool_037FC0F0:
	.word FirmwareWlWorkPointerSlot	; 037FC0F0
pool_037FC0F4:
	.word 0x00000318	; 037FC0F4
pool_037FC0F8:
	.word 0x00008000	; 037FC0F8
pool_037FC0FC:
	.word REG_WIFI_IF	; 037FC0FC
P2_Entry_037FC100:
	push {r4,r5,r6,r7,lr}	; 037FC100
	sub sp,#0xc	; 037FC102
	ldr r0,[pool_037FC2F4]	; 037FC104
	ldr r1,[r0,#0x0]	; 037FC106
	ldr r0,[pool_037FC2F8]	; 037FC108
	add r5,r1,r0	; 037FC10A
	ldr r0,[pool_037FC2FC]	; 037FC10C
	add r6,r1,r0	; 037FC10E
	ldr r0,[pool_037FC300]	; 037FC110
	add r4,r1,r0	; 037FC112
	ldr r1,[pool_037FC304]	; 037FC114
	ldr r0,[pool_037FC308]	; 037FC116
	strh r1,[r0,#0x0]	; 037FC118
	ldrh r0,[r5,#0xc]	; 037FC11A
	cmp r0,#0x1	; 037FC11C
	beq P2_Entry_037FC12A	; 037FC11E
	cmp r0,#0x2	; 037FC120
	beq P2_Entry_037FC1BC	; 037FC122
	cmp r0,#0x3	; 037FC124
	beq P2_Entry_037FC1E2	; 037FC126
	b P2_Entry_037FC2EC	; 037FC128
P2_Entry_037FC12A:
	add r0,r4,#0x0	; 037FC12A
	add r0,#0x80	; 037FC12C
	ldr r1,[r0,#0x0]	; 037FC12E
	add r1,#0x24	; 037FC130
	add r0,r5,#0x0	; 037FC132
	add r0,#0x96	; 037FC134
	ldrh r0,[r0,#0x0]	; 037FC136
	add r7,r1,r0	; 037FC138
	add r7,#0x8	; 037FC13A
	ldr r0,[pool_037FC30C]	; 037FC13C
	ldrh r0,[r0,#0x0]	; 037FC13E
	str r0,[sp,#0x0]	; 037FC140
	add r0,r7,#0x0	; 037FC142
	ldr r1,[sp,#0x0]	; 037FC144
	lsl r1,r1,#0x18	; 037FC146
	lsr r1,r1,#0x18	; 037FC148
	bl P2_Entry_037FC338	; 037FC14A
	add r0,r7,#0x1	; 037FC14E
	ldr r1,[sp,#0x0]	; 037FC150
	lsr r1,r1,#0x8	; 037FC152
	lsl r1,r1,#0x18	; 037FC154
	lsr r1,r1,#0x18	; 037FC156
	bl P2_Entry_037FC338	; 037FC158
	ldrh r0,[r5,#0xe]	; 037FC15C
	cmp r0,#0x1	; 037FC15E
	bne P2_Entry_037FC16E	; 037FC160
	ldrh r2,[r6,#0x20]	; 037FC162
	ldr r1,[pool_037FC310]	; 037FC164
	ldrh r0,[r1,#0x0]	; 037FC166
	add r0,r2,r0	; 037FC168
	add r0,r0,#0x1	; 037FC16A
	strh r0,[r1,#0x0]	; 037FC16C
P2_Entry_037FC16E:
	ldr r0,[pool_037FC2F4]	; 037FC16E
	ldr r0,[r0,#0x0]	; 037FC170
	ldr r1,[pool_037FC314]	; 037FC172
	ldrh r1,[r0,r1]	; 037FC174
	mvn r2,r1	; 037FC176
	ldr r1,[pool_037FC318]	; 037FC178
	ldrh r1,[r0,r1]	; 037FC17A
	orr r2,r1	; 037FC17C
	ldr r1,[pool_037FC31C]	; 037FC17E
	strh r2,[r0,r1]	; 037FC180
	ldr r0,[pool_037FC320]	; 037FC182
	ldrh r2,[r0,#0x0]	; 037FC184
	mov r0,#0x18	; 037FC186
	add r1,r2,#0x0	; 037FC188
	and r1,r0	; 037FC18A
	cmp r1,#0x0	; 037FC18C
	bne P2_Entry_037FC198	; 037FC18E
	mov r0,#0x6	; 037FC190
	and r2,r0	; 037FC192
	cmp r2,#0x2	; 037FC194
	bne P2_Entry_037FC1AC	; 037FC196
P2_Entry_037FC198:
	add r0,r4,#0x0	; 037FC198
	add r0,#0x8c	; 037FC19A
	ldr r1,[r0,#0x0]	; 037FC19C
	mov r0,#0x2	; 037FC19E
	bic r1,r0	; 037FC1A0
	add r4,#0x8c	; 037FC1A2
	str r1,[r4,#0x0]	; 037FC1A4
	bl P2_Entry_037FCD14	; 037FC1A6
	b P2_Entry_037FC2EC	; 037FC1AA
P2_Entry_037FC1AC:
	add r0,r4,#0x0	; 037FC1AC
	add r0,#0x8c	; 037FC1AE
	ldr r1,[r0,#0x0]	; 037FC1B0
	mov r0,#0x2	; 037FC1B2
	orr r1,r0	; 037FC1B4
	add r4,#0x8c	; 037FC1B6
	str r1,[r4,#0x0]	; 037FC1B8
	b P2_Entry_037FC2EC	; 037FC1BA
P2_Entry_037FC1BC:
	ldrh r0,[r5,#0x12]	; 037FC1BC
	cmp r0,#0x0	; 037FC1BE
	beq P2_Entry_037FC1D0	; 037FC1C0
	ldrh r2,[r6,#0x20]	; 037FC1C2
	ldr r1,[pool_037FC310]	; 037FC1C4
	ldrh r0,[r1,#0x0]	; 037FC1C6
	add r0,r2,r0	; 037FC1C8
	add r0,r0,#0x1	; 037FC1CA
	strh r0,[r1,#0x0]	; 037FC1CC
	b P2_Entry_037FC1D6	; 037FC1CE
P2_Entry_037FC1D0:
	ldr r1,[pool_037FC324]	; 037FC1D0
	ldr r0,[pool_037FC310]	; 037FC1D2
	strh r1,[r0,#0x0]	; 037FC1D4
P2_Entry_037FC1D6:
	ldrh r0,[r5,#0x1a]	; 037FC1D6
	cmp r0,#0x2	; 037FC1D8
	bne P2_Entry_037FC1E2	; 037FC1DA
	mov r0,#0x2	; 037FC1DC
	bl loc_037FBDD4	; 037FC1DE
P2_Entry_037FC1E2:
	ldrh r0,[r5,#0x8]	; 037FC1E2
	cmp r0,#0x40	; 037FC1E4
	beq P2_Entry_037FC1EC	; 037FC1E6
	mov r0,#0x1	; 037FC1E8
	b P2_Entry_037FC21A	; 037FC1EA
P2_Entry_037FC1EC:
	mov r0,#0x0	; 037FC1EC
	add r1,r5,#0x0	; 037FC1EE
	add r1,#0x72	; 037FC1F0
	ldrh r1,[r1,#0x0]	; 037FC1F2
	cmp r1,#0x1	; 037FC1F4
	bne P2_Entry_037FC1FA	; 037FC1F6
	mov r0,#0x1	; 037FC1F8
P2_Entry_037FC1FA:
	ldrh r1,[r5,#0x14]	; 037FC1FA
	cmp r1,#0x0	; 037FC1FC
	beq P2_Entry_037FC21A	; 037FC1FE
	add r1,r5,#0x0	; 037FC200
	add r1,#0x76	; 037FC202
	ldrh r1,[r1,#0x0]	; 037FC204
	cmp r1,#0x1	; 037FC206
	beq P2_Entry_037FC218	; 037FC208
	cmp r1,#0x0	; 037FC20A
	bne P2_Entry_037FC21A	; 037FC20C
	add r1,r5,#0x0	; 037FC20E
	add r1,#0x74	; 037FC210
	ldrh r1,[r1,#0x0]	; 037FC212
	cmp r1,#0x1	; 037FC214
	bne P2_Entry_037FC21A	; 037FC216
P2_Entry_037FC218:
	mov r0,#0x1	; 037FC218
P2_Entry_037FC21A:
	cmp r0,#0x0	; 037FC21A
	beq P2_Entry_037FC22A	; 037FC21C
	ldr r2,[pool_037FC328]	; 037FC21E
	ldrh r1,[r2,#0x0]	; 037FC220
	mov r0,#0x1	; 037FC222
	orr r1,r0	; 037FC224
	strh r1,[r2,#0x0]	; 037FC226
	b P2_Entry_037FC234	; 037FC228
P2_Entry_037FC22A:
	ldr r2,[pool_037FC328]	; 037FC22A
	ldrh r1,[r2,#0x0]	; 037FC22C
	mov r0,#0x1	; 037FC22E
	bic r1,r0	; 037FC230
	strh r1,[r2,#0x0]	; 037FC232
P2_Entry_037FC234:
	ldr r0,[pool_037FC32C]	; 037FC234
	ldrh r0,[r0,#0x0]	; 037FC236
	cmp r0,#0xa	; 037FC238
	bls P2_Entry_037FC242	; 037FC23A
	mov r1,#0x0	; 037FC23C
	ldr r0,[pool_037FC330]	; 037FC23E
	strh r1,[r0,#0x0]	; 037FC240
P2_Entry_037FC242:
	add r0,r5,#0x0	; 037FC242
	add r0,#0x72	; 037FC244
	ldrh r0,[r0,#0x0]	; 037FC246
	sub r1,r0,#0x1	; 037FC248
	add r0,r5,#0x0	; 037FC24A
	add r0,#0x72	; 037FC24C
	strh r1,[r0,#0x0]	; 037FC24E
	add r0,r5,#0x0	; 037FC250
	add r0,#0x72	; 037FC252
	ldrh r0,[r0,#0x0]	; 037FC254
	cmp r0,#0x0	; 037FC256
	bne P2_Entry_037FC266	; 037FC258
	add r0,r5,#0x0	; 037FC25A
	add r0,#0x70	; 037FC25C
	ldrh r1,[r0,#0x0]	; 037FC25E
	add r0,r5,#0x0	; 037FC260
	add r0,#0x72	; 037FC262
	strh r1,[r0,#0x0]	; 037FC264
P2_Entry_037FC266:
	add r0,r5,#0x0	; 037FC266
	add r0,#0x76	; 037FC268
	ldrh r2,[r0,#0x0]	; 037FC26A
	add r0,r5,#0x0	; 037FC26C
	add r0,#0x76	; 037FC26E
	ldrh r0,[r0,#0x0]	; 037FC270
	sub r1,r0,#0x1	; 037FC272
	add r0,r5,#0x0	; 037FC274
	add r0,#0x76	; 037FC276
	strh r1,[r0,#0x0]	; 037FC278
	cmp r2,#0x0	; 037FC27A
	bne P2_Entry_037FC28C	; 037FC27C
	add r0,r5,#0x0	; 037FC27E
	add r0,#0x74	; 037FC280
	ldrh r0,[r0,#0x0]	; 037FC282
	sub r1,r0,#0x1	; 037FC284
	add r0,r5,#0x0	; 037FC286
	add r0,#0x76	; 037FC288
	strh r1,[r0,#0x0]	; 037FC28A
P2_Entry_037FC28C:
	mov r6,#0x0	; 037FC28C
	str r6,[sp,#0x4]	; 037FC28E
P2_Entry_037FC290:
	add r1,r6,#0x0	; 037FC290
	mov r0,#0x14	; 037FC292
	mul r1,r0	; 037FC294
	add r7,r4,r1	; 037FC296
	ldrh r0,[r4,r1]	; 037FC298
	cmp r0,#0x0	; 037FC29A
	beq P2_Entry_037FC2E0	; 037FC29C
	ldr r0,[r7,#0xc]	; 037FC29E
	ldrh r1,[r0,#0x8]	; 037FC2A0
	cmp r1,#0x0	; 037FC2A2
	bne P2_Entry_037FC2E0	; 037FC2A4
	add r1,r5,#0x0	; 037FC2A6
	add r1,#0xa8	; 037FC2A8
	ldr r1,[r1,#0x0]	; 037FC2AA
	ldrh r0,[r0,#0x4]	; 037FC2AC
	sub r0,r1,r0	; 037FC2AE
	lsl r0,r0,#0x10	; 037FC2B0
	lsr r1,r0,#0x10	; 037FC2B2
	add r0,r5,#0x0	; 037FC2B4
	add r0,#0x8c	; 037FC2B6
	ldrh r0,[r0,#0x0]	; 037FC2B8
	cmp r1,r0	; 037FC2BA
	bls P2_Entry_037FC2E0	; 037FC2BC
	add r0,r6,#0x0	; 037FC2BE
	bl P2_Entry_037FCD74	; 037FC2C0
	ldr r1,[r7,#0x8]	; 037FC2C4
	mov r0,#0x2	; 037FC2C6
	strh r0,[r1,#0x0]	; 037FC2C8
	ldr r0,[sp,#0x4]	; 037FC2CA
	mov r1,#0xe	; 037FC2CC
	bl loc_037FB418	; 037FC2CE
	add r0,r4,#0x0	; 037FC2D2
	add r0,#0xb0	; 037FC2D4
	ldrh r0,[r0,#0x0]	; 037FC2D6
	add r1,r0,#0x1	; 037FC2D8
	add r0,r4,#0x0	; 037FC2DA
	add r0,#0xb0	; 037FC2DC
	strh r1,[r0,#0x0]	; 037FC2DE
P2_Entry_037FC2E0:
	add r6,r6,#0x1	; 037FC2E0
	cmp r6,#0x2	; 037FC2E2
	bcc P2_Entry_037FC290	; 037FC2E4
	mov r1,#0xd	; 037FC2E6
	ldr r0,[pool_037FC334]	; 037FC2E8
	strh r1,[r0,#0x0]	; 037FC2EA
P2_Entry_037FC2EC:
	add sp,#0xc	; 037FC2EC
	pop {r4,r5,r6,r7}	; 037FC2EE
	pop {r3}	; 037FC2F0
	bx r3	; 037FC2F2
pool_037FC2F4:
	.word FirmwareWlWorkPointerSlot	; 037FC2F4
pool_037FC2F8:
	.word 0x00000318	; 037FC2F8
pool_037FC2FC:
	.word 0x000002F0	; 037FC2FC
pool_037FC300:
	.word 0x00000400	; 037FC300
pool_037FC304:
	.word 0x00004000	; 037FC304
pool_037FC308:
	.word REG_WIFI_IF	; 037FC308
pool_037FC30C:
	.word FirmwareWlAdjustedTimeSlot	; 037FC30C
pool_037FC310:
	.word REG_WIFI_POST_BEACON	; 037FC310
pool_037FC314:
	.word 0x00000506	; 037FC314
pool_037FC318:
	.word 0x0000050A	; 037FC318
pool_037FC31C:
	.word 0x00000508	; 037FC31C
pool_037FC320:
	.word REG_WIFI_TXBUSY	; 037FC320
pool_037FC324:
	.word 0x0000FFFF	; 037FC324
pool_037FC328:
	.word REG_WIFI_POWER_TX	; 037FC328
pool_037FC32C:
	.word REG_WIFI_CMD_COUNT	; 037FC32C
pool_037FC330:
	.word REG_WIFI_UNKNOWN_048	; 037FC330
pool_037FC334:
	.word REG_WIFI_TXREQ_SET	; 037FC334
P2_Entry_037FC338:
	bx pc	; 037FC338
	.byte 0xC0, 0x46	; 037FC33A
.arm
	ldr r12,[pool_037FC344]	; 037FC33C
	bx r12	; 037FC340
pool_037FC344:
	.word loc_023051A4 + 1	; 037FC344
P2_Entry_037FC348:
.thumb
	ldr r0,[pool_037FC388]	; 037FC348
	ldr r1,[r0,#0x0]	; 037FC34A
	ldr r0,[pool_037FC38C]	; 037FC34C
	add r0,r1,r0	; 037FC34E
	ldr r2,[pool_037FC390]	; 037FC350
	ldr r1,[pool_037FC394]	; 037FC352
	strh r2,[r1,#0x0]	; 037FC354
	mov r2,#0xd	; 037FC356
	ldr r1,[pool_037FC398]	; 037FC358
	strh r2,[r1,#0x0]	; 037FC35A
	ldrh r1,[r0,#0x1a]	; 037FC35C
	cmp r1,#0x1	; 037FC35E
	bne P2_Entry_037FC368	; 037FC360
	mov r1,#0x2	; 037FC362
	strh r1,[r0,#0x1a]	; 037FC364
	bx lr	; 037FC366
P2_Entry_037FC368:
	cmp r1,#0x2	; 037FC368
	bne P2_Entry_037FC372	; 037FC36A
	mov r1,#0x0	; 037FC36C
	strh r1,[r0,#0x1a]	; 037FC36E
	bx lr	; 037FC370
P2_Entry_037FC372:
	ldrh r1,[r0,#0xc]	; 037FC372
	cmp r1,#0x2	; 037FC374
	bne P2_Entry_037FC384	; 037FC376
	ldrh r0,[r0,#0x8]	; 037FC378
	cmp r0,#0x40	; 037FC37A
	beq P2_Entry_037FC384	; 037FC37C
	mov r1,#0x0	; 037FC37E
	ldr r0,[pool_037FC39C]	; 037FC380
	strh r1,[r0,#0x0]	; 037FC382
P2_Entry_037FC384:
	bx lr	; 037FC384
	.byte 0xC0, 0x46	; 037FC386
pool_037FC388:
	.word FirmwareWlWorkPointerSlot	; 037FC388
pool_037FC38C:
	.word 0x00000318	; 037FC38C
pool_037FC390:
	.word 0x00002000	; 037FC390
pool_037FC394:
	.word REG_WIFI_IF	; 037FC394
pool_037FC398:
	.word REG_WIFI_TXREQ_RESET	; 037FC398
pool_037FC39C:
	.word REG_WIFI_UNKNOWN_048	; 037FC39C
P2_Entry_037FC3A0:
	push {lr}	; 037FC3A0
	sub sp,#0x4	; 037FC3A2
	bl P2_Entry_037FC3C8	; 037FC3A4
	ldr r1,[pool_037FC3BC]	; 037FC3A8
	ldr r0,[pool_037FC3C0]	; 037FC3AA
	strh r1,[r0,#0x0]	; 037FC3AC
	mov r1,#0x30	; 037FC3AE
	ldr r0,[pool_037FC3C4]	; 037FC3B0
	strh r1,[r0,#0x0]	; 037FC3B2
	add sp,#0x4	; 037FC3B4
	pop {r3}	; 037FC3B6
	bx r3	; 037FC3B8
	.byte 0xC0, 0x46	; 037FC3BA
pool_037FC3BC:
	.word 0x0000FFFF	; 037FC3BC
pool_037FC3C0:
	.word REG_WIFI_RXSTAT_OVF_IF	; 037FC3C0
pool_037FC3C4:
	.word REG_WIFI_IF	; 037FC3C4
P2_Entry_037FC3C8:
	bx pc	; 037FC3C8
	.byte 0xC0, 0x46	; 037FC3CA
.arm
	ldr r12,[pool_037FC3D4]	; 037FC3CC
	bx r12	; 037FC3D0
pool_037FC3D4:
	.word P4_Entry_02305958 + 1	; 037FC3D4
P2_Entry_037FC3D8:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC3D8
	sub sp,#0x4	; 037FC3DA
	mov r1,#0x8	; 037FC3DC
	ldr r0,[pool_037FC488]	; 037FC3DE
	strh r1,[r0,#0x0]	; 037FC3E0
	ldr r0,[pool_037FC48C]	; 037FC3E2
	ldr r1,[r0,#0x0]	; 037FC3E4
	ldr r0,[pool_037FC490]	; 037FC3E6
	ldrh r0,[r1,r0]	; 037FC3E8
	lsl r0,r0,#0x1b	; 037FC3EA
	lsr r0,r0,#0x1f	; 037FC3EC
	cmp r0,#0x0	; 037FC3EE
	beq P2_Entry_037FC406	; 037FC3F0
	ldr r0,[pool_037FC494]	; 037FC3F2
	ldrh r1,[r0,#0x0]	; 037FC3F4
	mov r0,#0x1	; 037FC3F6
	and r1,r0	; 037FC3F8
	cmp r1,#0x0	; 037FC3FA
	bne P2_Entry_037FC406	; 037FC3FC
	ldr r2,[pool_037FC498]	; 037FC3FE
	ldrh r1,[r2,#0x0]	; 037FC400
	eor r1,r0	; 037FC402
	strh r1,[r2,#0x0]	; 037FC404
P2_Entry_037FC406:
	ldr r0,[pool_037FC48C]	; 037FC406
	ldr r2,[r0,#0x0]	; 037FC408
	ldr r0,[pool_037FC49C]	; 037FC40A
	ldrh r1,[r2,r0]	; 037FC40C
	mov r0,#0x8	; 037FC40E
	and r1,r0	; 037FC410
	cmp r1,#0x0	; 037FC412
	beq P2_Entry_037FC47E	; 037FC414
	ldr r0,[pool_037FC4A0]	; 037FC416
	add r5,r2,r0	; 037FC418
	ldr r0,[pool_037FC4A4]	; 037FC41A
	add r4,r2,r0	; 037FC41C
	mov r6,#0x0	; 037FC41E
	add r1,r6,#0x0	; 037FC420
	ldr r0,[pool_037FC4A8]	; 037FC422
P2_Entry_037FC424:
	add r3,r6,#0x0	; 037FC424
	mov r2,#0x14	; 037FC426
	mul r3,r2	; 037FC428
	add r7,r4,r3	; 037FC42A
	ldrh r2,[r4,r3]	; 037FC42C
	cmp r2,#0x0	; 037FC42E
	beq P2_Entry_037FC478	; 037FC430
	ldr r3,[r7,#0x8]	; 037FC432
	ldrh r7,[r3,#0xc]	; 037FC434
	ldr r2,[pool_037FC4AC]	; 037FC436
	and r7,r2	; 037FC438
	cmp r7,#0x0	; 037FC43A
	beq P2_Entry_037FC478	; 037FC43C
	ldrh r7,[r3,#0x4]	; 037FC43E
	mov r2,#0xff	; 037FC440
	and r7,r2	; 037FC442
	cmp r7,#0x0	; 037FC444
	beq P2_Entry_037FC478	; 037FC446
	add r7,r3,#0x0	; 037FC448
	add r7,#0xc	; 037FC44A
	ldrh r2,[r3,#0xa]	; 037FC44C
	add r2,r7,r2	; 037FC44E
	sub r2,r2,#0x7	; 037FC450
	mov r7,#0x1	; 037FC452
	bic r2,r7	; 037FC454
	ldrh r7,[r2,#0x0]	; 037FC456
	cmp r7,#0x0	; 037FC458
	bne P2_Entry_037FC478	; 037FC45A
	ldrh r2,[r2,#0x2]	; 037FC45C
	cmp r2,#0x0	; 037FC45E
	bne P2_Entry_037FC478	; 037FC460
	strh r1,[r3,#0x4]	; 037FC462
	strh r1,[r0,#0x0]	; 037FC464
	ldr r2,[pool_037FC4B0]	; 037FC466
	strh r2,[r0,#0x0]	; 037FC468
	add r2,r5,#0x0	; 037FC46A
	add r2,#0xba	; 037FC46C
	ldrh r2,[r2,#0x0]	; 037FC46E
	add r3,r2,#0x1	; 037FC470
	add r2,r5,#0x0	; 037FC472
	add r2,#0xba	; 037FC474
	strh r3,[r2,#0x0]	; 037FC476
P2_Entry_037FC478:
	add r6,r6,#0x1	; 037FC478
	cmp r6,#0x3	; 037FC47A
	bcc P2_Entry_037FC424	; 037FC47C
P2_Entry_037FC47E:
	add sp,#0x4	; 037FC47E
	pop {r4,r5,r6,r7}	; 037FC480
	pop {r3}	; 037FC482
	bx r3	; 037FC484
	.byte 0xC0, 0x46	; 037FC486
pool_037FC488:
	.word REG_WIFI_IF	; 037FC488
pool_037FC48C:
	.word FirmwareWlWorkPointerSlot	; 037FC48C
pool_037FC490:
	.word 0x0000030E	; 037FC490
pool_037FC494:
	.word REG_WIFI_RF_PINS	; 037FC494
pool_037FC498:
	.word REG_WIFI_UNKNOWN_290	; 037FC498
pool_037FC49C:
	.word 0x00000638	; 037FC49C
pool_037FC4A0:
	.word 0x00000318	; 037FC4A0
pool_037FC4A4:
	.word 0x00000400	; 037FC4A4
pool_037FC4A8:
	.word REG_WIFI_WEP_CNT	; 037FC4A8
pool_037FC4AC:
	.word 0x00004000	; 037FC4AC
pool_037FC4B0:
	.word 0x00008000	; 037FC4B0
P2_Entry_037FC4B4:
	push {r4,r5,lr}	; 037FC4B4
	sub sp,#0x4	; 037FC4B6
	ldr r0,[pool_037FC5B0]	; 037FC4B8
	ldr r2,[r0,#0x0]	; 037FC4BA
	ldr r1,[pool_037FC5B4]	; 037FC4BC
	add r3,r2,r1	; 037FC4BE
	ldr r4,[pool_037FC5B8]	; 037FC4C0
	add r2,r2,r4	; 037FC4C2
	mov r5,#0x4	; 037FC4C4
	ldr r1,[pool_037FC5BC]	; 037FC4C6
	strh r5,[r1,#0x0]	; 037FC4C8
	ldr r1,[pool_037FC5C0]	; 037FC4CA
	ldrh r1,[r1,#0x0]	; 037FC4CC
	ldr r5,[r0,#0x0]	; 037FC4CE
	ldr r0,[pool_037FC5C4]	; 037FC4D0
	ldrh r5,[r5,r0]	; 037FC4D2
	mov r0,#0x8	; 037FC4D4
	and r5,r0	; 037FC4D6
	cmp r5,#0x0	; 037FC4D8
	beq P2_Entry_037FC554	; 037FC4DA
	add r0,r1,#0x0	; 037FC4DC
	and r0,r4	; 037FC4DE
	cmp r0,#0x0	; 037FC4E0
	beq P2_Entry_037FC554	; 037FC4E2
	ldr r0,[pool_037FC5C8]	; 037FC4E4
	ldrh r0,[r0,#0x0]	; 037FC4E6
	mov r4,#0x1	; 037FC4E8
	add r5,r0,#0x0	; 037FC4EA
	and r5,r4	; 037FC4EC
	cmp r5,#0x0	; 037FC4EE
	beq P2_Entry_037FC4F8	; 037FC4F0
	ldrh r4,[r2,#0x0]	; 037FC4F2
	cmp r4,#0x0	; 037FC4F4
	bne P2_Entry_037FC530	; 037FC4F6
P2_Entry_037FC4F8:
	mov r4,#0x4	; 037FC4F8
	add r5,r0,#0x0	; 037FC4FA
	and r5,r4	; 037FC4FC
	cmp r5,#0x0	; 037FC4FE
	beq P2_Entry_037FC508	; 037FC500
	ldrh r4,[r2,#0x14]	; 037FC502
	cmp r4,#0x0	; 037FC504
	bne P2_Entry_037FC530	; 037FC506
P2_Entry_037FC508:
	mov r4,#0x8	; 037FC508
	and r0,r4	; 037FC50A
	cmp r0,#0x0	; 037FC50C
	beq P2_Entry_037FC516	; 037FC50E
	ldrh r0,[r2,#0x28]	; 037FC510
	cmp r0,#0x0	; 037FC512
	bne P2_Entry_037FC530	; 037FC514
P2_Entry_037FC516:
	ldr r0,[pool_037FC5CC]	; 037FC516
	ldrh r2,[r0,#0x0]	; 037FC518
	mov r0,#0x1	; 037FC51A
	and r2,r0	; 037FC51C
	cmp r2,#0x0	; 037FC51E
	bne P2_Entry_037FC530	; 037FC520
	mov r4,#0x0	; 037FC522
	ldr r2,[pool_037FC5D0]	; 037FC524
	strh r4,[r2,#0x0]	; 037FC526
	ldr r0,[pool_037FC5D4]	; 037FC528
	strh r0,[r2,#0x0]	; 037FC52A
	strh r4,[r3,#0x2]	; 037FC52C
	b P2_Entry_037FC554	; 037FC52E
P2_Entry_037FC530:
	ldrh r2,[r3,#0x2]	; 037FC530
	add r0,r2,#0x1	; 037FC532
	strh r0,[r3,#0x2]	; 037FC534
	cmp r2,#0xc	; 037FC536
	bls P2_Entry_037FC554	; 037FC538
	mov r0,#0x0	; 037FC53A
	strh r0,[r3,#0x2]	; 037FC53C
	ldr r2,[pool_037FC5D0]	; 037FC53E
	strh r0,[r2,#0x0]	; 037FC540
	ldr r0,[pool_037FC5D4]	; 037FC542
	strh r0,[r2,#0x0]	; 037FC544
	ldr r0,[pool_037FC5B0]	; 037FC546
	ldr r2,[r0,#0x0]	; 037FC548
	ldr r0,[pool_037FC5D8]	; 037FC54A
	add r0,r2,r0	; 037FC54C
	ldrh r2,[r0,#0x0]	; 037FC54E
	add r2,r2,#0x1	; 037FC550
	strh r2,[r0,#0x0]	; 037FC552
P2_Entry_037FC554:
	ldr r0,[pool_037FC5B0]	; 037FC554
	ldr r2,[r0,#0x0]	; 037FC556
	ldr r0,[pool_037FC5C4]	; 037FC558
	ldrh r2,[r2,r0]	; 037FC55A
	mov r0,#0x1	; 037FC55C
	and r2,r0	; 037FC55E
	cmp r2,#0x0	; 037FC560
	beq P2_Entry_037FC5A6	; 037FC562
	mov r0,#0x60	; 037FC564
	and r1,r0	; 037FC566
	cmp r1,#0x0	; 037FC568
	beq P2_Entry_037FC5A6	; 037FC56A
	ldr r0,[pool_037FC5DC]	; 037FC56C
	ldrh r4,[r0,#0x0]	; 037FC56E
	ldr r0,[pool_037FC5E0]	; 037FC570
	ldrh r1,[r0,#0x0]	; 037FC572
	ldr r0,[pool_037FC5E4]	; 037FC574
	sub r0,r1,r0	; 037FC576
	mov r1,#0x2	; 037FC578
	bl P2_Entry_037FC5FC	; 037FC57A
	cmp r4,r0	; 037FC57E
	bge P2_Entry_037FC594	; 037FC580
	ldr r0,[pool_037FC5E8]	; 037FC582
	ldrh r1,[r0,#0x0]	; 037FC584
	ldr r0,[pool_037FC5E4]	; 037FC586
	sub r0,r1,r0	; 037FC588
	mov r1,#0x2	; 037FC58A
	bl P2_Entry_037FC608	; 037FC58C
	cmp r4,r0	; 037FC590
	bge P2_Entry_037FC5A2	; 037FC592
P2_Entry_037FC594:
	ldr r0,[pool_037FC5EC]	; 037FC594
	ldrh r1,[r0,#0x0]	; 037FC596
	ldr r0,[pool_037FC5F0]	; 037FC598
	strh r1,[r0,#0x0]	; 037FC59A
	ldr r1,[pool_037FC5F4]	; 037FC59C
	ldr r0,[pool_037FC5F8]	; 037FC59E
	strh r1,[r0,#0x0]	; 037FC5A0
P2_Entry_037FC5A2:
	bl P2_Entry_037FC614	; 037FC5A2
P2_Entry_037FC5A6:
	add sp,#0x4	; 037FC5A6
	pop {r4,r5}	; 037FC5A8
	pop {r3}	; 037FC5AA
	bx r3	; 037FC5AC
	.byte 0xC0, 0x46	; 037FC5AE
pool_037FC5B0:
	.word FirmwareWlWorkPointerSlot	; 037FC5B0
pool_037FC5B4:
	.word 0x000004B4	; 037FC5B4
pool_037FC5B8:
	.word 0x00000400	; 037FC5B8
pool_037FC5BC:
	.word REG_WIFI_IF	; 037FC5BC
pool_037FC5C0:
	.word REG_WIFI_RXSTAT_INC_IF	; 037FC5C0
pool_037FC5C4:
	.word 0x00000638	; 037FC5C4
pool_037FC5C8:
	.word REG_WIFI_TXREQ_READ	; 037FC5C8
pool_037FC5CC:
	.word REG_WIFI_RF_PINS	; 037FC5CC
pool_037FC5D0:
	.word REG_WIFI_WEP_CNT	; 037FC5D0
pool_037FC5D4:
	.word 0x00008000	; 037FC5D4
pool_037FC5D8:
	.word 0x000003D2	; 037FC5D8
pool_037FC5DC:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC5DC
pool_037FC5E0:
	.word REG_WIFI_RXBUF_END	; 037FC5E0
pool_037FC5E4:
	.word 0x00004000	; 037FC5E4
pool_037FC5E8:
	.word REG_WIFI_RXBUF_BEGIN	; 037FC5E8
pool_037FC5EC:
	.word REG_WIFI_RXBUF_READCSR	; 037FC5EC
pool_037FC5F0:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FC5F0
pool_037FC5F4:
	.word 0x00008001	; 037FC5F4
pool_037FC5F8:
	.word REG_WIFI_RXCNT	; 037FC5F8
P2_Entry_037FC5FC:
	bx pc	; 037FC5FC
	.byte 0xC0, 0x46	; 037FC5FE
.arm
	ldr pc,[pool_037FC604]	; 037FC600
pool_037FC604:
	.word P2_SignedDivMod	; 037FC604
P2_Entry_037FC608:
.thumb
	bx pc	; 037FC608
	.byte 0xC0, 0x46	; 037FC60A
.arm
	ldr pc,[pool_037FC610]	; 037FC60C
pool_037FC610:
	.word P2_SignedDivMod	; 037FC610
P2_Entry_037FC614:
.thumb
	bx pc	; 037FC614
	.byte 0xC0, 0x46	; 037FC616
.arm
	ldr r12,[pool_037FC620]	; 037FC618
	bx r12	; 037FC61C
pool_037FC620:
	.word P4_Entry_02304F50 + 1	; 037FC620
P2_Entry_037FC624:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC624
	sub sp,#0x4	; 037FC626
	ldr r2,[pool_037FC79C]	; 037FC628
	ldr r1,[r2,#0x0]	; 037FC62A
	ldr r0,[pool_037FC7A0]	; 037FC62C
	add r5,r1,r0	; 037FC62E
	mov r1,#0x2	; 037FC630
	ldr r0,[pool_037FC7A4]	; 037FC632
	strh r1,[r0,#0x0]	; 037FC634
	ldr r0,[r2,#0x0]	; 037FC636
	ldr r2,[pool_037FC7A8]	; 037FC638
	ldrh r2,[r0,r2]	; 037FC63A
	cmp r2,#0x12	; 037FC63C
	bne P2_Entry_037FC646	; 037FC63E
	bl P2_Entry_037FC7EC	; 037FC640
	b P2_Entry_037FC792	; 037FC644
P2_Entry_037FC646:
	ldr r2,[pool_037FC7AC]	; 037FC646
	ldrh r4,[r2,#0x0]	; 037FC648
	ldr r2,[pool_037FC7B0]	; 037FC64A
	and r4,r2	; 037FC64C
	ldr r2,[pool_037FC7B4]	; 037FC64E
	cmp r4,r2	; 037FC650
	beq P2_Entry_037FC662	; 037FC652
	ldr r2,[pool_037FC7B8]	; 037FC654
	cmp r4,r2	; 037FC656
	beq P2_Entry_037FC68A	; 037FC658
	ldr r1,[pool_037FC7BC]	; 037FC65A
	cmp r4,r1	; 037FC65C
	beq P2_Entry_037FC6C0	; 037FC65E
	b P2_Entry_037FC736	; 037FC660
P2_Entry_037FC662:
	add r0,r5,#0x0	; 037FC662
	add r0,#0x8c	; 037FC664
	ldr r0,[r0,#0x0]	; 037FC666
	and r0,r1	; 037FC668
	cmp r0,#0x0	; 037FC66A
	beq P2_Entry_037FC672	; 037FC66C
	bl P2_Entry_037FCD14	; 037FC66E
P2_Entry_037FC672:
	ldr r0,[pool_037FC79C]	; 037FC672
	ldr r1,[r0,#0x0]	; 037FC674
	ldr r0,[pool_037FC7C0]	; 037FC676
	add r0,r1,r0	; 037FC678
	ldr r1,[r0,#0x0]	; 037FC67A
	add r1,r1,#0x1	; 037FC67C
	str r1,[r0,#0x0]	; 037FC67E
	mov r0,#0x0	; 037FC680
	mov r1,#0x8	; 037FC682
	bl loc_037FB418	; 037FC684
	b P2_Entry_037FC736	; 037FC688
P2_Entry_037FC68A:
	add r0,r5,#0x0	; 037FC68A
	add r0,#0x9e	; 037FC68C
	ldrh r0,[r0,#0x0]	; 037FC68E
	ldr r2,[r5,#0x44]	; 037FC690
	ldrh r3,[r2,#0x4]	; 037FC692
	mov r2,#0xff	; 037FC694
	and r3,r2	; 037FC696
	lsl r2,r3,#0x10	; 037FC698
	lsr r2,r2,#0x10	; 037FC69A
	cmp r0,r2	; 037FC69C
	bhi P2_Entry_037FC6B2	; 037FC69E
	ldr r0,[pool_037FC7C4]	; 037FC6A0
	strh r1,[r0,#0x0]	; 037FC6A2
	add r0,r5,#0x0	; 037FC6A4
	add r0,#0xaa	; 037FC6A6
	ldrh r0,[r0,#0x0]	; 037FC6A8
	add r1,r0,#0x1	; 037FC6AA
	add r0,r5,#0x0	; 037FC6AC
	add r0,#0xaa	; 037FC6AE
	strh r1,[r0,#0x0]	; 037FC6B0
P2_Entry_037FC6B2:
	add r0,r5,#0x0	; 037FC6B2
	add r0,#0x90	; 037FC6B4
	ldr r1,[r0,#0x0]	; 037FC6B6
	ldrh r0,[r1,#0x18]	; 037FC6B8
	add r0,r0,#0x1	; 037FC6BA
	strh r0,[r1,#0x18]	; 037FC6BC
	b P2_Entry_037FC736	; 037FC6BE
P2_Entry_037FC6C0:
	add r1,r5,#0x0	; 037FC6C0
	add r1,#0x98	; 037FC6C2
	ldrh r6,[r1,#0x0]	; 037FC6C4
	ldr r1,[r5,#0x44]	; 037FC6C6
	ldrh r3,[r1,#0x2]	; 037FC6C8
	add r1,r5,#0x0	; 037FC6CA
	add r1,#0x90	; 037FC6CC
	ldr r2,[r1,#0x0]	; 037FC6CE
	add r2,#0x1a	; 037FC6D0
	cmp r3,#0x1	; 037FC6D2
	bls P2_Entry_037FC6F6	; 037FC6D4
	ldr r1,[pool_037FC7C8]	; 037FC6D6
	ldrh r0,[r0,r1]	; 037FC6D8
	lsl r0,r0,#0x1b	; 037FC6DA
	lsr r0,r0,#0x1f	; 037FC6DC
	cmp r0,#0x0	; 037FC6DE
	beq P2_Entry_037FC6F6	; 037FC6E0
	ldr r0,[pool_037FC7CC]	; 037FC6E2
	ldrh r0,[r0,#0x0]	; 037FC6E4
	mov r7,#0x1	; 037FC6E6
	and r0,r7	; 037FC6E8
	cmp r0,#0x0	; 037FC6EA
	bne P2_Entry_037FC6F6	; 037FC6EC
	ldr r1,[pool_037FC7D0]	; 037FC6EE
	ldrh r0,[r1,#0x0]	; 037FC6F0
	eor r0,r7	; 037FC6F2
	strh r0,[r1,#0x0]	; 037FC6F4
P2_Entry_037FC6F6:
	ldr r0,[pool_037FC79C]	; 037FC6F6
	ldr r1,[r0,#0x0]	; 037FC6F8
	ldr r0,[pool_037FC7D4]	; 037FC6FA
	ldrh r1,[r1,r0]	; 037FC6FC
	mov r0,#0x40	; 037FC6FE
	and r1,r0	; 037FC700
	cmp r1,#0x0	; 037FC702
	beq P2_Entry_037FC736	; 037FC704
	mov r0,#0x1	; 037FC706
	b P2_Entry_037FC732	; 037FC708
P2_Entry_037FC70A:
	lsl r1,r3,#0xf	; 037FC70A
	lsr r3,r1,#0x10	; 037FC70C
	add r1,r3,#0x0	; 037FC70E
	and r1,r0	; 037FC710
	cmp r1,#0x0	; 037FC712
	beq P2_Entry_037FC71C	; 037FC714
	ldrh r1,[r2,#0x6]	; 037FC716
	add r1,r1,#0x1	; 037FC718
	strh r1,[r2,#0x6]	; 037FC71A
P2_Entry_037FC71C:
	lsl r1,r6,#0xf	; 037FC71C
	lsr r6,r1,#0x10	; 037FC71E
	add r1,r6,#0x0	; 037FC720
	and r1,r0	; 037FC722
	cmp r1,#0x0	; 037FC724
	beq P2_Entry_037FC732	; 037FC726
	add r1,r5,#0x0	; 037FC728
	add r1,#0x90	; 037FC72A
	ldr r1,[r1,#0x0]	; 037FC72C
	ldrh r1,[r1,#0x16]	; 037FC72E
	add r2,r2,r1	; 037FC730
P2_Entry_037FC732:
	cmp r3,#0x1	; 037FC732
	bhi P2_Entry_037FC70A	; 037FC734
P2_Entry_037FC736:
	ldr r0,[pool_037FC7B8]	; 037FC736
	cmp r4,r0	; 037FC738
	beq P2_Entry_037FC78A	; 037FC73A
	ldr r0,[pool_037FC7D8]	; 037FC73C
	ldrh r1,[r0,#0x0]	; 037FC73E
	mov r0,#0x2	; 037FC740
	and r1,r0	; 037FC742
	cmp r1,#0x0	; 037FC744
	bne P2_Entry_037FC78A	; 037FC746
	ldrh r1,[r5,#0x3c]	; 037FC748
	cmp r1,#0x0	; 037FC74A
	beq P2_Entry_037FC784	; 037FC74C
	ldr r1,[pool_037FC7DC]	; 037FC74E
	strh r0,[r1,#0x0]	; 037FC750
	mov r2,#0x0	; 037FC752
	ldr r1,[pool_037FC7E0]	; 037FC754
	strh r2,[r1,#0x0]	; 037FC756
	ldr r1,[pool_037FC7A4]	; 037FC758
	ldrh r2,[r1,#0x0]	; 037FC75A
	ldr r1,[pool_037FC7E4]	; 037FC75C
	and r2,r1	; 037FC75E
	cmp r2,#0x0	; 037FC760
	bne P2_Entry_037FC76A	; 037FC762
	bl P2_Entry_037FC9F0	; 037FC764
	b P2_Entry_037FC778	; 037FC768
P2_Entry_037FC76A:
	add r0,r5,#0x0	; 037FC76A
	add r0,#0xae	; 037FC76C
	ldrh r0,[r0,#0x0]	; 037FC76E
	add r1,r0,#0x1	; 037FC770
	add r0,r5,#0x0	; 037FC772
	add r0,#0xae	; 037FC774
	strh r1,[r0,#0x0]	; 037FC776
P2_Entry_037FC778:
	add r0,r5,#0x0	; 037FC778
	add r0,#0xac	; 037FC77A
	ldrh r0,[r0,#0x0]	; 037FC77C
	add r0,r0,#0x1	; 037FC77E
	add r5,#0xac	; 037FC780
	strh r0,[r5,#0x0]	; 037FC782
P2_Entry_037FC784:
	mov r1,#0x2	; 037FC784
	ldr r0,[pool_037FC7E8]	; 037FC786
	strh r1,[r0,#0x0]	; 037FC788
P2_Entry_037FC78A:
	mov r0,#0x0	; 037FC78A
	mov r1,#0xe	; 037FC78C
	bl loc_037FB418	; 037FC78E
P2_Entry_037FC792:
	add sp,#0x4	; 037FC792
	pop {r4,r5,r6,r7}	; 037FC794
	pop {r3}	; 037FC796
	bx r3	; 037FC798
	.byte 0xC0, 0x46	; 037FC79A
pool_037FC79C:
	.word FirmwareWlWorkPointerSlot	; 037FC79C
pool_037FC7A0:
	.word 0x00000400	; 037FC7A0
pool_037FC7A4:
	.word REG_WIFI_IF	; 037FC7A4
pool_037FC7A8:
	.word 0x00000320	; 037FC7A8
pool_037FC7AC:
	.word REG_WIFI_TXSTAT	; 037FC7AC
pool_037FC7B0:
	.word 0x00000F00	; 037FC7B0
pool_037FC7B4:
	.word 0x00000300	; 037FC7B4
pool_037FC7B8:
	.word 0x00000800	; 037FC7B8
pool_037FC7BC:
	.word 0x00000B00	; 037FC7BC
pool_037FC7C0:
	.word 0x0000052C	; 037FC7C0
pool_037FC7C4:
	.word REG_WIFI_TXREQ_RESET	; 037FC7C4
pool_037FC7C8:
	.word 0x0000030E	; 037FC7C8
pool_037FC7CC:
	.word REG_WIFI_RF_PINS	; 037FC7CC
pool_037FC7D0:
	.word REG_WIFI_UNKNOWN_290	; 037FC7D0
pool_037FC7D4:
	.word 0x00000638	; 037FC7D4
pool_037FC7D8:
	.word REG_WIFI_TXREQ_READ	; 037FC7D8
pool_037FC7DC:
	.word REG_WIFI_TXBUF_RESET	; 037FC7DC
pool_037FC7E0:
	.word REG_WIFI_UNKNOWN_048	; 037FC7E0
pool_037FC7E4:
	.word 0x00001000	; 037FC7E4
pool_037FC7E8:
	.word REG_WIFI_TXREQ_SET	; 037FC7E8
P2_Entry_037FC7EC:
	bx pc	; 037FC7EC
	.byte 0xC0, 0x46	; 037FC7EE
.arm
	ldr r12,[pool_037FC7F8]	; 037FC7F0
	bx r12	; 037FC7F4
pool_037FC7F8:
	.word P4_Entry_02308C50 + 1	; 037FC7F8
P2_Entry_037FC7FC:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC7FC
	sub sp,#0x1c	; 037FC7FE
	ldr r0,[pool_037FC998]	; 037FC800
	ldr r1,[r0,#0x0]	; 037FC802
	ldr r0,[pool_037FC99C]	; 037FC804
	add r5,r1,r0	; 037FC806
	ldr r0,[pool_037FC9A0]	; 037FC808
	add r0,r1,r0	; 037FC80A
	str r0,[sp,#0x0]	; 037FC80C
	ldr r0,[pool_037FC9A4]	; 037FC80E
	ldrh r6,[r1,r0]	; 037FC810
	mov r1,#0x1	; 037FC812
	ldr r0,[pool_037FC9A8]	; 037FC814
	strh r1,[r0,#0x0]	; 037FC816
	and r6,r1	; 037FC818
P2_Entry_037FC81A:
	ldr r0,[sp,#0x0]	; 037FC81A
	ldrh r0,[r0,#0x4]	; 037FC81C
	str r0,[sp,#0x8]	; 037FC81E
	ldr r0,[pool_037FC9AC]	; 037FC820
	ldrh r0,[r0,#0x0]	; 037FC822
	str r0,[sp,#0xc]	; 037FC824
	ldr r1,[sp,#0x8]	; 037FC826
	cmp r1,r0	; 037FC828
	bne P2_Entry_037FC82E	; 037FC82A
	b P2_Entry_037FC95E	; 037FC82C
P2_Entry_037FC82E:
	ldr r0,[pool_037FC9B0]	; 037FC82E
	ldrh r1,[r0,#0x0]	; 037FC830
	ldr r0,[pool_037FC9B4]	; 037FC832
	ldrh r0,[r0,#0x0]	; 037FC834
	ldr r2,[pool_037FC9B0]	; 037FC836
	ldrh r3,[r2,#0x0]	; 037FC838
	ldr r2,[pool_037FC9B4]	; 037FC83A
	ldrh r2,[r2,#0x0]	; 037FC83C
	cmp r1,r3	; 037FC83E
	bls P2_Entry_037FC84A	; 037FC840
	lsr r4,r3,#0x4	; 037FC842
	lsl r0,r2,#0xc	; 037FC844
	orr r4,r0	; 037FC846
	b P2_Entry_037FC850	; 037FC848
P2_Entry_037FC84A:
	lsr r4,r1,#0x4	; 037FC84A
	lsl r0,r0,#0xc	; 037FC84C
	orr r4,r0	; 037FC84E
P2_Entry_037FC850:
	ldr r0,[sp,#0x8]	; 037FC850
	lsl r7,r0,#0x1	; 037FC852
	ldr r0,[pool_037FC9B8]	; 037FC854
	add r0,r7,r0	; 037FC856
	str r0,[sp,#0x4]	; 037FC858
	add r0,r0,#0x2	; 037FC85A
	bl P2_Entry_037FCDD0	; 037FC85C
	str r0,[sp,#0x10]	; 037FC860
	add r0,r0,#0x2	; 037FC862
	bl P2_Entry_037FCDD0	; 037FC864
	str r0,[sp,#0x14]	; 037FC868
	add r0,r0,#0x4	; 037FC86A
	bl P2_Entry_037FCDD0	; 037FC86C
	add r2,r0,#0x0	; 037FC870
	ldr r0,[pool_037FC9B8]	; 037FC872
	ldrh r1,[r7,r0]	; 037FC874
	ldr r0,[sp,#0x10]	; 037FC876
	ldrh r0,[r0,#0x0]	; 037FC878
	lsl r3,r0,#0x1	; 037FC87A
	ldr r0,[pool_037FC9BC]	; 037FC87C
	and r3,r0	; 037FC87E
	orr r1,r3	; 037FC880
	ldr r0,[pool_037FC9B8]	; 037FC882
	strh r1,[r7,r0]	; 037FC884
	ldr r0,[sp,#0x14]	; 037FC886
	strh r4,[r0,#0x0]	; 037FC888
	ldrh r2,[r2,#0x0]	; 037FC88A
	ldr r0,[sp,#0x8]	; 037FC88C
	lsl r0,r0,#0x1	; 037FC88E
	add r0,r2,r0	; 037FC890
	add r0,#0xf	; 037FC892
	lsr r0,r0,#0x2	; 037FC894
	lsl r4,r0,#0x1	; 037FC896
	ldr r0,[pool_037FC9C0]	; 037FC898
	cmp r4,r0	; 037FC89A
	bcc P2_Entry_037FC8A8	; 037FC89C
	add r0,r5,#0x0	; 037FC89E
	add r0,#0x9a	; 037FC8A0
	ldrh r0,[r0,#0x0]	; 037FC8A2
	lsr r0,r0,#0x1	; 037FC8A4
	sub r4,r4,r0	; 037FC8A6
P2_Entry_037FC8A8:
	ldr r0,[pool_037FC9C4]	; 037FC8A8
	cmp r2,r0	; 037FC8AA
	bls P2_Entry_037FC8C6	; 037FC8AC
	ldr r1,[pool_037FC9C8]	; 037FC8AE
	ldr r0,[sp,#0x4]	; 037FC8B0
	strh r1,[r0,#0x0]	; 037FC8B2
	ldr r4,[sp,#0xc]	; 037FC8B4
	add r0,r5,#0x0	; 037FC8B6
	add r0,#0xb4	; 037FC8B8
	ldrh r0,[r0,#0x0]	; 037FC8BA
	add r1,r0,#0x1	; 037FC8BC
	add r0,r5,#0x0	; 037FC8BE
	add r0,#0xb4	; 037FC8C0
	strh r1,[r0,#0x0]	; 037FC8C2
	b P2_Entry_037FC92E	; 037FC8C4
P2_Entry_037FC8C6:
	cmp r6,#0x0	; 037FC8C6
	beq P2_Entry_037FC92E	; 037FC8C8
	ldr r0,[sp,#0xc]	; 037FC8CA
	cmp r4,r0	; 037FC8CC
	beq P2_Entry_037FC92E	; 037FC8CE
	lsl r0,r4,#0x1	; 037FC8D0
	ldr r1,[pool_037FC9B8]	; 037FC8D2
	add r1,r0,r1	; 037FC8D4
	ldr r3,[pool_037FC9B8]	; 037FC8D6
	ldrh r0,[r0,r3]	; 037FC8D8
	ldr r3,[pool_037FC9CC]	; 037FC8DA
	cmp r1,r3	; 037FC8DC
	bcs P2_Entry_037FC8EC	; 037FC8DE
	ldrh r3,[r1,#0x6]	; 037FC8E0
	mov r1,#0xff	; 037FC8E2
	and r3,r1	; 037FC8E4
	lsl r1,r3,#0x10	; 037FC8E6
	lsr r3,r1,#0x10	; 037FC8E8
	b P2_Entry_037FC8F6	; 037FC8EA
P2_Entry_037FC8EC:
	add r3,r5,#0x0	; 037FC8EC
	add r3,#0x9a	; 037FC8EE
	ldrh r3,[r3,#0x0]	; 037FC8F0
	sub r1,r1,r3	; 037FC8F2
	ldrh r3,[r1,#0x6]	; 037FC8F4
P2_Entry_037FC8F6:
	ldr r1,[pool_037FC9D0]	; 037FC8F6
	and r0,r1	; 037FC8F8
	cmp r0,#0x0	; 037FC8FA
	bne P2_Entry_037FC90C	; 037FC8FC
	cmp r3,#0xa	; 037FC8FE
	beq P2_Entry_037FC906	; 037FC900
	cmp r3,#0x14	; 037FC902
	bne P2_Entry_037FC90C	; 037FC904
P2_Entry_037FC906:
	ldr r0,[pool_037FC9D4]	; 037FC906
	cmp r2,r0	; 037FC908
	bls P2_Entry_037FC92E	; 037FC90A
P2_Entry_037FC90C:
	add r0,r5,#0x0	; 037FC90C
	add r0,#0xb4	; 037FC90E
	ldrh r0,[r0,#0x0]	; 037FC910
	add r0,r0,#0x1	; 037FC912
	add r5,#0xb4	; 037FC914
	strh r0,[r5,#0x0]	; 037FC916
	ldr r1,[pool_037FC9C8]	; 037FC918
	ldr r0,[sp,#0x4]	; 037FC91A
	strh r1,[r0,#0x0]	; 037FC91C
	ldr r0,[sp,#0xc]	; 037FC91E
	lsl r0,r0,#0x10	; 037FC920
	lsr r1,r0,#0x10	; 037FC922
	ldr r0,[sp,#0x0]	; 037FC924
	strh r1,[r0,#0x4]	; 037FC926
	ldr r0,[sp,#0x10]	; 037FC928
	strh r1,[r0,#0x0]	; 037FC92A
	b P2_Entry_037FC95E	; 037FC92C
P2_Entry_037FC92E:
	ldr r0,[sp,#0x4]	; 037FC92E
	ldrh r1,[r0,#0x0]	; 037FC930
	mov r0,#0xf	; 037FC932
	and r1,r0	; 037FC934
	cmp r1,#0xc	; 037FC936
	bne P2_Entry_037FC950	; 037FC938
	bl P2_Entry_037FCDF0	; 037FC93A
	cmp r0,#0x0	; 037FC93E
	bne P2_Entry_037FC950	; 037FC940
	ldr r0,[pool_037FC998]	; 037FC942
	ldr r0,[r0,#0x0]	; 037FC944
	ldr r1,[pool_037FC9D8]	; 037FC946
	ldr r1,[r0,r1]	; 037FC948
	add r2,r1,#0x1	; 037FC94A
	ldr r1,[pool_037FC9D8]	; 037FC94C
	str r2,[r0,r1]	; 037FC94E
P2_Entry_037FC950:
	lsl r0,r4,#0x10	; 037FC950
	lsr r1,r0,#0x10	; 037FC952
	ldr r0,[sp,#0x0]	; 037FC954
	strh r1,[r0,#0x4]	; 037FC956
	ldr r0,[sp,#0x10]	; 037FC958
	strh r1,[r0,#0x0]	; 037FC95A
	b P2_Entry_037FC81A	; 037FC95C
P2_Entry_037FC95E:
	cmp r6,#0x0	; 037FC95E
	beq P2_Entry_037FC97C	; 037FC960
	ldr r0,[pool_037FC9AC]	; 037FC962
	ldrh r4,[r0,#0x0]	; 037FC964
	bl P2_Entry_037FCDF0	; 037FC966
	cmp r0,#0x0	; 037FC96A
	beq P2_Entry_037FC97C	; 037FC96C
	ldr r0,[pool_037FC9AC]	; 037FC96E
	ldrh r0,[r0,#0x0]	; 037FC970
	cmp r4,r0	; 037FC972
	bne P2_Entry_037FC97C	; 037FC974
	mov r0,#0x20	; 037FC976
	bl P2_Entry_037FC9E0	; 037FC978
P2_Entry_037FC97C:
	ldr r0,[pool_037FC9DC]	; 037FC97C
	ldrh r1,[r0,#0x0]	; 037FC97E
	ldr r0,[pool_037FC9AC]	; 037FC980
	ldrh r0,[r0,#0x0]	; 037FC982
	cmp r1,r0	; 037FC984
	beq P2_Entry_037FC990	; 037FC986
	mov r0,#0x0	; 037FC988
	mov r1,#0xf	; 037FC98A
	bl loc_037FB418	; 037FC98C
P2_Entry_037FC990:
	add sp,#0x1c	; 037FC990
	pop {r4,r5,r6,r7}	; 037FC992
	pop {r3}	; 037FC994
	bx r3	; 037FC996
pool_037FC998:
	.word FirmwareWlWorkPointerSlot	; 037FC998
pool_037FC99C:
	.word 0x00000318	; 037FC99C
pool_037FC9A0:
	.word 0x000004B4	; 037FC9A0
pool_037FC9A4:
	.word 0x00000638	; 037FC9A4
pool_037FC9A8:
	.word REG_WIFI_IF	; 037FC9A8
pool_037FC9AC:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC9AC
pool_037FC9B0:
	.word REG_WIFI_US_COUNT0	; 037FC9B0
pool_037FC9B4:
	.word REG_WIFI_US_COUNT1	; 037FC9B4
pool_037FC9B8:
	.word WifiRamBase	; 037FC9B8
pool_037FC9BC:
	.word 0x00000400	; 037FC9BC
pool_037FC9C0:
	.word 0x00000FB0	; 037FC9C0
pool_037FC9C4:
	.word 0x0000092C	; 037FC9C4
pool_037FC9C8:
	.word 0x0000FFFF	; 037FC9C8
pool_037FC9CC:
	.word 0x04805F5A	; 037FC9CC
pool_037FC9D0:
	.word 0x00007C00	; 037FC9D0
pool_037FC9D4:
	.word 0x00000FFF	; 037FC9D4
pool_037FC9D8:
	.word 0x0000057C	; 037FC9D8
pool_037FC9DC:
	.word REG_WIFI_RXBUF_READCSR	; 037FC9DC
.arm
P2_Entry_037FC9E0:
.thumb
	bx pc	; 037FC9E0
	.byte 0xC0, 0x46	; 037FC9E2
.arm
	ldr r12,[pool_037FC9EC]	; 037FC9E4
	bx r12	; 037FC9E8
pool_037FC9EC:
	.word loc_02304F18 + 1	; 037FC9EC
P2_Entry_037FC9F0:
.thumb
	push {r4,lr}	; 037FC9F0
	ldr r1,[pool_037FCA7C]	; 037FC9F2
	ldr r3,[r1,#0x0]	; 037FC9F4
	ldr r2,[pool_037FCA80]	; 037FC9F6
	add r2,r3,r2	; 037FC9F8
	ldr r4,[pool_037FCA84]	; 037FC9FA
	ldr r3,[pool_037FCA88]	; 037FC9FC
	strh r4,[r3,#0x0]	; 037FC9FE
	ldrh r3,[r2,#0x3c]	; 037FCA00
	cmp r3,#0x0	; 037FCA02
	beq P2_Entry_037FCA74	; 037FCA04
	ldr r3,[r1,#0x0]	; 037FCA06
	ldr r1,[pool_037FCA8C]	; 037FCA08
	ldrh r3,[r3,r1]	; 037FCA0A
	mov r1,#0x10	; 037FCA0C
	and r3,r1	; 037FCA0E
	cmp r3,#0x0	; 037FCA10
	beq P2_Entry_037FCA6C	; 037FCA12
	cmp r0,#0x0	; 037FCA14
	beq P2_Entry_037FCA6C	; 037FCA16
	ldr r0,[pool_037FCA90]	; 037FCA18
	ldrh r1,[r0,#0x0]	; 037FCA1A
	ldr r0,[pool_037FCA94]	; 037FCA1C
	ldrh r0,[r0,#0x0]	; 037FCA1E
	cmp r0,#0x3	; 037FCA20
	beq P2_Entry_037FCA28	; 037FCA22
	cmp r0,#0x5	; 037FCA24
	bne P2_Entry_037FCA6C	; 037FCA26
P2_Entry_037FCA28:
	cmp r1,#0x0	; 037FCA28
	bne P2_Entry_037FCA6C	; 037FCA2A
	ldr r3,[r2,#0x44]	; 037FCA2C
	ldrh r4,[r3,#0x2]	; 037FCA2E
	mov r0,#0x0	; 037FCA30
	mov r1,#0x1	; 037FCA32
	b P2_Entry_037FCA40	; 037FCA34
P2_Entry_037FCA36:
	add r2,r4,#0x0	; 037FCA36
	and r2,r1	; 037FCA38
	add r0,r0,r2	; 037FCA3A
	lsl r2,r4,#0xf	; 037FCA3C
	lsr r4,r2,#0x10	; 037FCA3E
P2_Entry_037FCA40:
	cmp r4,#0x0	; 037FCA40
	bne P2_Entry_037FCA36	; 037FCA42
	ldrh r1,[r3,#0xa]	; 037FCA44
	lsl r2,r1,#0x2	; 037FCA46
	ldrh r1,[r3,#0x24]	; 037FCA48
	add r1,#0xa	; 037FCA4A
	mul r0,r1	; 037FCA4C
	add r0,#0xc0	; 037FCA4E
	add r0,r2,r0	; 037FCA50
	lsl r0,r0,#0x10	; 037FCA52
	lsr r0,r0,#0x10	; 037FCA54
	ldr r1,[pool_037FCA98]	; 037FCA56
	bl P2_Entry_037FCAA0	; 037FCA58
	ldr r0,[pool_037FCA7C]	; 037FCA5C
	ldr r1,[r0,#0x0]	; 037FCA5E
	ldr r0,[pool_037FCA9C]	; 037FCA60
	add r0,r1,r0	; 037FCA62
	ldrh r1,[r0,#0x0]	; 037FCA64
	add r1,r1,#0x1	; 037FCA66
	strh r1,[r0,#0x0]	; 037FCA68
	b P2_Entry_037FCA74	; 037FCA6A
P2_Entry_037FCA6C:
	mov r0,#0x0	; 037FCA6C
	mov r1,#0x10	; 037FCA6E
	bl loc_037FB418	; 037FCA70
P2_Entry_037FCA74:
	pop {r4}	; 037FCA74
	pop {r3}	; 037FCA76
	bx r3	; 037FCA78
	.byte 0xC0, 0x46	; 037FCA7A
pool_037FCA7C:
	.word FirmwareWlWorkPointerSlot	; 037FCA7C
pool_037FCA80:
	.word 0x00000400	; 037FCA80
pool_037FCA84:
	.word 0x00001000	; 037FCA84
pool_037FCA88:
	.word REG_WIFI_IF	; 037FCA88
pool_037FCA8C:
	.word 0x00000638	; 037FCA8C
pool_037FCA90:
	.word REG_WIFI_TXBUSY	; 037FCA90
pool_037FCA94:
	.word REG_WIFI_RF_STATUS	; 037FCA94
pool_037FCA98:
	.word 0x037FCD85	; 037FCA98
pool_037FCA9C:
	.word 0x000003D4	; 037FCA9C
P2_Entry_037FCAA0:
	bx pc	; 037FCAA0
	.byte 0xC0, 0x46	; 037FCAA2
.arm
	ldr r12,[pool_037FCAAC]	; 037FCAA4
	bx r12	; 037FCAA8
pool_037FCAAC:
	.word P4_Entry_02305370 + 1	; 037FCAAC
P2_Entry_037FCAB0:
.thumb
	push {r4,lr}	; 037FCAB0
	ldr r3,[pool_037FCB10]	; 037FCAB2
	ldr r1,[r3,#0x0]	; 037FCAB4
	ldr r0,[pool_037FCB14]	; 037FCAB6
	add r1,r1,r0	; 037FCAB8
	mov r0,#0x80	; 037FCABA
	ldr r2,[pool_037FCB18]	; 037FCABC
	strh r0,[r2,#0x0]	; 037FCABE
	ldr r3,[r3,#0x0]	; 037FCAC0
	ldr r2,[pool_037FCB1C]	; 037FCAC2
	ldrh r3,[r3,r2]	; 037FCAC4
	mov r2,#0x20	; 037FCAC6
	and r3,r2	; 037FCAC8
	cmp r3,#0x0	; 037FCACA
	beq P2_Entry_037FCB0A	; 037FCACC
	ldr r2,[pool_037FCB20]	; 037FCACE
	ldrh r3,[r2,#0x0]	; 037FCAD0
	mov r2,#0xff	; 037FCAD2
	and r3,r2	; 037FCAD4
	lsl r2,r3,#0x10	; 037FCAD6
	lsr r3,r2,#0x10	; 037FCAD8
	ldr r2,[pool_037FCB24]	; 037FCADA
	ldrh r4,[r2,#0x0]	; 037FCADC
	cmp r3,#0x3	; 037FCADE
	bcc P2_Entry_037FCB0A	; 037FCAE0
	cmp r3,#0x5	; 037FCAE2
	bhi P2_Entry_037FCB0A	; 037FCAE4
	ldr r2,[r1,#0x58]	; 037FCAE6
	lsr r3,r2,#0x1	; 037FCAE8
	ldr r2,[pool_037FCB28]	; 037FCAEA
	and r3,r2	; 037FCAEC
	cmp r4,r3	; 037FCAEE
	bcc P2_Entry_037FCB0A	; 037FCAF0
	ldr r1,[r1,#0x30]	; 037FCAF2
	lsr r1,r1,#0x1	; 037FCAF4
	and r1,r2	; 037FCAF6
	cmp r4,r1	; 037FCAF8
	bhi P2_Entry_037FCB0A	; 037FCAFA
	ldr r2,[pool_037FCB2C]	; 037FCAFC
	ldrh r1,[r2,#0x0]	; 037FCAFE
	orr r1,r0	; 037FCB00
	strh r1,[r2,#0x0]	; 037FCB02
	ldrh r1,[r2,#0x0]	; 037FCB04
	bic r1,r0	; 037FCB06
	strh r1,[r2,#0x0]	; 037FCB08
P2_Entry_037FCB0A:
	pop {r4}	; 037FCB0A
	pop {r3}	; 037FCB0C
	bx r3	; 037FCB0E
pool_037FCB10:
	.word FirmwareWlWorkPointerSlot	; 037FCB10
pool_037FCB14:
	.word 0x00000400	; 037FCB14
pool_037FCB18:
	.word REG_WIFI_IF	; 037FCB18
pool_037FCB1C:
	.word 0x00000638	; 037FCB1C
pool_037FCB20:
	.word REG_WIFI_RF_STATUS	; 037FCB20
pool_037FCB24:
	.word REG_WIFI_RXTX_ADDR	; 037FCB24
pool_037FCB28:
	.word 0x00000FFF	; 037FCB28
pool_037FCB2C:
	.word REG_WIFI_UNKNOWN_244	; 037FCB2C
P2_Entry_037FCB30:
	push {r4,r5,r6,r7,lr}	; 037FCB30
	sub sp,#0x4	; 037FCB32
	ldr r0,[pool_037FCCB0]	; 037FCB34
	ldr r2,[r0,#0x0]	; 037FCB36
	ldr r1,[pool_037FCCB4]	; 037FCB38
	add r5,r2,r1	; 037FCB3A
	ldr r1,[pool_037FCCB8]	; 037FCB3C
	add r6,r2,r1	; 037FCB3E
	mov r2,#0x40	; 037FCB40
	ldr r1,[pool_037FCCBC]	; 037FCB42
	strh r2,[r1,#0x0]	; 037FCB44
	ldr r1,[r0,#0x0]	; 037FCB46
	ldr r0,[pool_037FCCC0]	; 037FCB48
	ldrh r1,[r1,r0]	; 037FCB4A
	mov r0,#0x20	; 037FCB4C
	and r1,r0	; 037FCB4E
	cmp r1,#0x0	; 037FCB50
	bne P2_Entry_037FCB56	; 037FCB52
	b P2_Entry_037FCCA6	; 037FCB54
P2_Entry_037FCB56:
	add r0,r6,#0x0	; 037FCB56
	add r0,#0xa6	; 037FCB58
	ldrh r1,[r0,#0x0]	; 037FCB5A
	ldr r0,[pool_037FCCC4]	; 037FCB5C
	cmp r1,r0	; 037FCB5E
	beq P2_Entry_037FCB64	; 037FCB60
	b P2_Entry_037FCCA6	; 037FCB62
P2_Entry_037FCB64:
	ldr r0,[pool_037FCCC8]	; 037FCB64
	ldrh r1,[r0,#0x0]	; 037FCB66
	mov r0,#0x3	; 037FCB68
	and r1,r0	; 037FCB6A
	cmp r1,#0x3	; 037FCB6C
	beq P2_Entry_037FCB72	; 037FCB6E
	b P2_Entry_037FCCA6	; 037FCB70
P2_Entry_037FCB72:
	ldr r0,[pool_037FCCCC]	; 037FCB72
	ldrh r2,[r0,#0x0]	; 037FCB74
	ldr r0,[pool_037FCCD0]	; 037FCB76
	ldrh r0,[r0,#0x0]	; 037FCB78
	lsr r1,r0,#0x1	; 037FCB7A
	ldr r0,[pool_037FCCD4]	; 037FCB7C
	and r1,r0	; 037FCB7E
	cmp r2,r1	; 037FCB80
	bge P2_Entry_037FCB86	; 037FCB82
	b P2_Entry_037FCCA6	; 037FCB84
P2_Entry_037FCB86:
	ldr r0,[pool_037FCCD8]	; 037FCB86
	ldrh r0,[r0,#0x0]	; 037FCB88
	str r0,[sp,#0x0]	; 037FCB8A
	lsl r1,r0,#0x1	; 037FCB8C
	ldr r0,[pool_037FCCDC]	; 037FCB8E
	add r0,r1,r0	; 037FCB90
	add r0,#0x8	; 037FCB92
	bl P2_Entry_037FCDD0	; 037FCB94
	add r0,r0,#0x4	; 037FCB98
	bl P2_Entry_037FCDD0	; 037FCB9A
	ldrh r2,[r0,#0x0]	; 037FCB9E
	ldr r1,[pool_037FCCE0]	; 037FCBA0
	and r2,r1	; 037FCBA2
	ldr r1,[pool_037FCCE4]	; 037FCBA4
	cmp r2,r1	; 037FCBA6
	bne P2_Entry_037FCCA6	; 037FCBA8
	add r0,r0,#0x2	; 037FCBAA
	bl P2_Entry_037FCDD0	; 037FCBAC
	add r1,r0,#0x0	; 037FCBB0
	ldr r4,[pool_037FCCE8]	; 037FCBB2
	ldrh r2,[r4,#0x0]	; 037FCBB4
	ldr r0,[pool_037FCCEC]	; 037FCBB6
	sub r7,r2,r0	; 037FCBB8
P2_Entry_037FCBBA:
	ldr r0,[pool_037FCCCC]	; 037FCBBA
	ldrh r2,[r0,#0x0]	; 037FCBBC
	ldr r0,[sp,#0x0]	; 037FCBBE
	sub r0,r2,r0	; 037FCBC0
	lsl r0,r0,#0x10	; 037FCBC2
	lsr r3,r0,#0x10	; 037FCBC4
	add r2,r3,#0x0	; 037FCBC6
	ldr r0,[pool_037FCCF0]	; 037FCBC8
	and r2,r0	; 037FCBCA
	cmp r2,#0x0	; 037FCBCC
	beq P2_Entry_037FCBDE	; 037FCBCE
	add r0,r5,#0x0	; 037FCBD0
	add r0,#0x9a	; 037FCBD2
	ldrh r0,[r0,#0x0]	; 037FCBD4
	lsr r0,r0,#0x1	; 037FCBD6
	add r0,r3,r0	; 037FCBD8
	lsl r0,r0,#0x10	; 037FCBDA
	lsr r3,r0,#0x10	; 037FCBDC
P2_Entry_037FCBDE:
	cmp r3,#0xe	; 037FCBDE
	bhi P2_Entry_037FCBF0	; 037FCBE0
	ldrh r0,[r4,#0x0]	; 037FCBE2
	sub r0,r0,r7	; 037FCBE4
	lsl r0,r0,#0x10	; 037FCBE6
	lsr r0,r0,#0x10	; 037FCBE8
	cmp r0,#0x40	; 037FCBEA
	bls P2_Entry_037FCBBA	; 037FCBEC
	b P2_Entry_037FCCA6	; 037FCBEE
P2_Entry_037FCBF0:
	add r1,#0x8	; 037FCBF0
	mov r4,#0x0	; 037FCBF2
	b P2_Entry_037FCC0E	; 037FCBF4
P2_Entry_037FCBF6:
	add r0,r1,#0x0	; 037FCBF6
	bl P2_Entry_037FCDD0	; 037FCBF8
	add r1,r0,#0x2	; 037FCBFC
	ldrh r0,[r0,#0x0]	; 037FCBFE
	lsl r2,r4,#0x1	; 037FCC00
	add r2,r5,r2	; 037FCC02
	add r2,#0x64	; 037FCC04
	ldrh r2,[r2,#0x0]	; 037FCC06
	cmp r0,r2	; 037FCC08
	bne P2_Entry_037FCCA6	; 037FCC0A
	add r4,r4,#0x1	; 037FCC0C
P2_Entry_037FCC0E:
	cmp r4,#0x3	; 037FCC0E
	bcc P2_Entry_037FCBF6	; 037FCC10
	add r1,#0xa	; 037FCC12
	add r0,r1,#0x0	; 037FCC14
	bl P2_Entry_037FCDD0	; 037FCC16
	add r3,r0,#0x0	; 037FCC1A
	ldr r4,[pool_037FCCCC]	; 037FCC1C
P2_Entry_037FCC1E:
	ldrh r1,[r4,#0x0]	; 037FCC1E
	ldr r0,[sp,#0x0]	; 037FCC20
	sub r0,r1,r0	; 037FCC22
	lsl r0,r0,#0x10	; 037FCC24
	lsr r2,r0,#0x10	; 037FCC26
	add r1,r2,#0x0	; 037FCC28
	ldr r0,[pool_037FCCF0]	; 037FCC2A
	and r1,r0	; 037FCC2C
	cmp r1,#0x0	; 037FCC2E
	beq P2_Entry_037FCC40	; 037FCC30
	add r0,r5,#0x0	; 037FCC32
	add r0,#0x9a	; 037FCC34
	ldrh r0,[r0,#0x0]	; 037FCC36
	lsr r0,r0,#0x1	; 037FCC38
	add r0,r2,r0	; 037FCC3A
	lsl r0,r0,#0x10	; 037FCC3C
	lsr r2,r0,#0x10	; 037FCC3E
P2_Entry_037FCC40:
	cmp r2,#0x14	; 037FCC40
	bhi P2_Entry_037FCC54	; 037FCC42
	ldr r0,[pool_037FCCE8]	; 037FCC44
	ldrh r0,[r0,#0x0]	; 037FCC46
	sub r0,r0,r7	; 037FCC48
	lsl r0,r0,#0x10	; 037FCC4A
	lsr r0,r0,#0x10	; 037FCC4C
	cmp r0,#0x70	; 037FCC4E
	bls P2_Entry_037FCC1E	; 037FCC50
	b P2_Entry_037FCCA6	; 037FCC52
P2_Entry_037FCC54:
	ldrh r1,[r3,#0x0]	; 037FCC54
	add r0,r6,#0x0	; 037FCC56
	add r0,#0xa2	; 037FCC58
	ldrh r0,[r0,#0x0]	; 037FCC5A
	and r1,r0	; 037FCC5C
	cmp r1,#0x0	; 037FCC5E
	bne P2_Entry_037FCCA6	; 037FCC60
	ldr r0,[pool_037FCCF4]	; 037FCC62
	ldrh r0,[r0,#0x0]	; 037FCC64
	add r6,#0xa6	; 037FCC66
	strh r0,[r6,#0x0]	; 037FCC68
	mov r1,#0x40	; 037FCC6A
	ldr r0,[pool_037FCCF8]	; 037FCC6C
	strh r1,[r0,#0x0]	; 037FCC6E
	add r0,r5,#0x0	; 037FCC70
	add r0,#0xbe	; 037FCC72
	ldrh r0,[r0,#0x0]	; 037FCC74
	add r0,r0,#0x1	; 037FCC76
	add r5,#0xbe	; 037FCC78
	strh r0,[r5,#0x0]	; 037FCC7A
	ldr r1,[pool_037FCCC8]	; 037FCC7C
	mov r0,#0x3	; 037FCC7E
P2_Entry_037FCC80:
	ldrh r2,[r1,#0x0]	; 037FCC80
	and r2,r0	; 037FCC82
	cmp r2,#0x3	; 037FCC84
	beq P2_Entry_037FCC80	; 037FCC86
	ldr r2,[pool_037FCCFC]	; 037FCC88
	ldrh r1,[r2,#0x0]	; 037FCC8A
	mov r0,#0x40	; 037FCC8C
	orr r1,r0	; 037FCC8E
	strh r1,[r2,#0x0]	; 037FCC90
	ldrh r1,[r2,#0x0]	; 037FCC92
	bic r1,r0	; 037FCC94
	strh r1,[r2,#0x0]	; 037FCC96
	mov r0,#0x8	; 037FCC98
	ldr r1,[pool_037FCD00]	; 037FCC9A
	strh r0,[r1,#0x0]	; 037FCC9C
	mov r0,#0x0	; 037FCC9E
	strh r0,[r1,#0x0]	; 037FCCA0
	bl P2_Entry_037FCD04	; 037FCCA2
P2_Entry_037FCCA6:
	add sp,#0x4	; 037FCCA6
	pop {r4,r5,r6,r7}	; 037FCCA8
	pop {r3}	; 037FCCAA
	bx r3	; 037FCCAC
	.byte 0xC0, 0x46	; 037FCCAE
pool_037FCCB0:
	.word FirmwareWlWorkPointerSlot	; 037FCCB0
pool_037FCCB4:
	.word 0x00000318	; 037FCCB4
pool_037FCCB8:
	.word 0x00000400	; 037FCCB8
pool_037FCCBC:
	.word REG_WIFI_IF	; 037FCCBC
pool_037FCCC0:
	.word 0x00000638	; 037FCCC0
pool_037FCCC4:
	.word 0x0000FFFF	; 037FCCC4
pool_037FCCC8:
	.word REG_WIFI_RF_PINS	; 037FCCC8
pool_037FCCCC:
	.word REG_WIFI_RXTX_ADDR	; 037FCCCC
pool_037FCCD0:
	.word REG_WIFI_RXBUF_BEGIN	; 037FCCD0
pool_037FCCD4:
	.word 0x00000FFF	; 037FCCD4
pool_037FCCD8:
	.word REG_WIFI_RXBUF_WRCSR	; 037FCCD8
pool_037FCCDC:
	.word WifiRamBase	; 037FCCDC
pool_037FCCE0:
	.word 0x0000E7FF	; 037FCCE0
pool_037FCCE4:
	.word 0x00000228	; 037FCCE4
pool_037FCCE8:
	.word REG_WIFI_US_COUNT0	; 037FCCE8
pool_037FCCEC:
	.word 0x00010000	; 037FCCEC
pool_037FCCF0:
	.word 0x00008000	; 037FCCF0
pool_037FCCF4:
	.word REG_WIFI_TXBUF_REPLY2	; 037FCCF4
pool_037FCCF8:
	.word REG_WIFI_TXBUF_RESET	; 037FCCF8
pool_037FCCFC:
	.word REG_WIFI_UNKNOWN_244	; 037FCCFC
pool_037FCD00:
	.word REG_WIFI_UNKNOWN_228	; 037FCD00
P2_Entry_037FCD04:
	bx pc	; 037FCD04
	.byte 0xC0, 0x46	; 037FCD06
.arm
	ldr r12,[pool_037FCD10]	; 037FCD08
	bx r12	; 037FCD0C
pool_037FCD10:
	.word P4_Entry_02306DF4 + 1	; 037FCD10
P2_Entry_037FCD14:
.thumb
	push {r4,r5,lr}	; 037FCD14
	sub sp,#0x4	; 037FCD16
	ldr r0,[pool_037FCD6C]	; 037FCD18
	ldr r1,[r0,#0x0]	; 037FCD1A
	ldr r0,[pool_037FCD70]	; 037FCD1C
	add r5,r1,r0	; 037FCD1E
	mov r4,#0x0	; 037FCD20
	mov r0,#0x1	; 037FCD22
	bl P2_Entry_037FCD74	; 037FCD24
	lsl r0,r4,#0	; 037FCD28
	bl P2_Entry_037FCD74	; 037FCD2A
	ldr r0,[r5,#0x1c]	; 037FCD2E
	ldrh r0,[r0,#0x0]	; 037FCD30
	cmp r0,#0x0	; 037FCD32
	beq P2_Entry_037FCD3A	; 037FCD34
	mov r4,#0x1	; 037FCD36
	b P2_Entry_037FCD3E	; 037FCD38
P2_Entry_037FCD3A:
	lsl r0,r4,#0	; 037FCD3A
	strh r0,[r5,#0x14]	; 037FCD3C
P2_Entry_037FCD3E:
	ldr r0,[r5,#0x8]	; 037FCD3E
	ldrh r0,[r0,#0x0]	; 037FCD40
	cmp r0,#0x0	; 037FCD42
	beq P2_Entry_037FCD4A	; 037FCD44
	mov r4,#0x1	; 037FCD46
	b P2_Entry_037FCD4E	; 037FCD48
P2_Entry_037FCD4A:
	mov r0,#0x0	; 037FCD4A
	strh r0,[r5,#0x0]	; 037FCD4C
P2_Entry_037FCD4E:
	cmp r4,#0x0	; 037FCD4E
	beq P2_Entry_037FCD5A	; 037FCD50
	mov r0,#0x0	; 037FCD52
	mov r1,#0xe	; 037FCD54
	bl loc_037FB418	; 037FCD56
P2_Entry_037FCD5A:
	mov r0,#0x0	; 037FCD5A
	mov r1,#0x14	; 037FCD5C
	bl loc_037FB418	; 037FCD5E
	add sp,#0x4	; 037FCD62
	pop {r4,r5}	; 037FCD64
	pop {r3}	; 037FCD66
	bx r3	; 037FCD68
	.byte 0xC0, 0x46	; 037FCD6A
pool_037FCD6C:
	.word FirmwareWlWorkPointerSlot	; 037FCD6C
pool_037FCD70:
	.word 0x00000400	; 037FCD70
P2_Entry_037FCD74:
	bx pc	; 037FCD74
	.byte 0xC0, 0x46	; 037FCD76
.arm
	ldr r12,[pool_037FCD80]	; 037FCD78
	bx r12	; 037FCD7C
pool_037FCD80:
	.word loc_0230A6A4 + 1	; 037FCD80
	.byte 0x10, 0xB5, 0x0E, 0x48, 0x00, 0xF0, 0x96, 0xFE, 0x04, 0x1C, 0x0D, 0x4A, 0x13, 0x88, 0x0D, 0x49	; 037FCD84
	.byte 0x0D, 0x48, 0x01, 0x80, 0x64, 0x21, 0x03, 0xE0, 0x10, 0x88, 0x83, 0x42, 0x02, 0xD1, 0x49, 0x1E	; 037FCD94
	.byte 0x00, 0x29, 0xF9, 0xD1, 0x00, 0x20, 0x08, 0x49, 0x08, 0x80, 0xFF, 0xF7, 0x1F, 0xFE, 0x20, 0x1C	; 037FCDA4
	.byte 0x00, 0xF0, 0x96, 0xFE, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x00, 0x00, 0x00, 0x01	; 037FCDB4
	.byte 0x10, 0x82, 0x80, 0x04, 0x00, 0x10, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04	; 037FCDC4
P2_Entry_037FCDD0:
.thumb
	ldr r1,[pool_037FCDE4]	; 037FCDD0
	cmp r0,r1	; 037FCDD2
	bcc P2_Entry_037FCDE0	; 037FCDD4
	ldr r1,[pool_037FCDE8]	; 037FCDD6
	ldr r2,[r1,#0x0]	; 037FCDD8
	ldr r1,[pool_037FCDEC]	; 037FCDDA
	ldrh r1,[r2,r1]	; 037FCDDC
	sub r0,r0,r1	; 037FCDDE
P2_Entry_037FCDE0:
	bx lr	; 037FCDE0
	.byte 0xC0, 0x46	; 037FCDE2
pool_037FCDE4:
	.word 0x04805F60	; 037FCDE4
pool_037FCDE8:
	.word FirmwareWlWorkPointerSlot	; 037FCDE8
pool_037FCDEC:
	.word 0x000003B2	; 037FCDEC
P2_Entry_037FCDF0:
	push {r4,lr}	; 037FCDF0
	ldr r0,[pool_037FCE24]	; 037FCDF2
	ldr r1,[r0,#0x0]	; 037FCDF4
	ldr r0,[pool_037FCE28]	; 037FCDF6
	add r4,r1,r0	; 037FCDF8
	add r0,r4,#0x0	; 037FCDFA
	add r0,#0x50	; 037FCDFC
	bl P2_Entry_037FCE2C	; 037FCDFE
	cmp r0,#0x0	; 037FCE02
	beq P2_Entry_037FCE0A	; 037FCE04
	mov r0,#0x1	; 037FCE06
	b P2_Entry_037FCE1C	; 037FCE08
P2_Entry_037FCE0A:
	add r4,#0x64	; 037FCE0A
	add r0,r4,#0x0	; 037FCE0C
	bl P2_Entry_037FCE2C	; 037FCE0E
	cmp r0,#0x0	; 037FCE12
	beq P2_Entry_037FCE1A	; 037FCE14
	mov r0,#0x1	; 037FCE16
	b P2_Entry_037FCE1C	; 037FCE18
P2_Entry_037FCE1A:
	mov r0,#0x0	; 037FCE1A
P2_Entry_037FCE1C:
	pop {r4}	; 037FCE1C
	pop {r3}	; 037FCE1E
	bx r3	; 037FCE20
	.byte 0xC0, 0x46	; 037FCE22
pool_037FCE24:
	.word FirmwareWlWorkPointerSlot	; 037FCE24
pool_037FCE28:
	.word 0x00000400	; 037FCE28
P2_Entry_037FCE2C:
	bx pc	; 037FCE2C
	.byte 0xC0, 0x46	; 037FCE2E
.arm
	ldr r12,[pool_037FCE38]	; 037FCE30
	bx r12	; 037FCE34
pool_037FCE38:
	.word P4_Entry_02306DB0 + 1	; 037FCE38
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0A, 0x48, 0x01, 0x68, 0x0A, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD0	; 037FCE3C
	.byte 0x00, 0xF0, 0x14, 0xF8, 0x06, 0x48, 0x01, 0x68, 0x07, 0x48, 0x08, 0x5A, 0x40, 0x06, 0xC0, 0x0F	; 037FCE4C
	.byte 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x12, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCE5C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xBC, 0x03, 0x00, 0x00, 0x0E, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 037FCE6C
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xD1, 0x9F, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46	; 037FCE7C
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xD5, 0x79, 0x30, 0x02, 0xF0, 0xB5, 0x83, 0xB0	; 037FCE8C
	.byte 0x4B, 0x48, 0x01, 0x68, 0x4B, 0x48, 0x0D, 0x18, 0x4B, 0x48, 0x0F, 0x18, 0x02, 0x24, 0x01, 0x94	; 037FCE9C
	.byte 0x00, 0x94, 0x21, 0x1C, 0x14, 0x20, 0x41, 0x43, 0x7A, 0x18, 0xA0, 0x00, 0x47, 0x49, 0x43, 0x18	; 037FCEAC
	.byte 0x41, 0x5A, 0x47, 0x48, 0x01, 0x40, 0x00, 0x29, 0x79, 0xD1, 0x10, 0x88, 0x00, 0x28, 0x76, 0xD0	; 037FCEBC
	.byte 0xD0, 0x68, 0x00, 0x28, 0x6B, 0xD0, 0x91, 0x68, 0x09, 0x88, 0x01, 0x81, 0x90, 0x68, 0x81, 0x89	; 037FCECC
	.byte 0xD0, 0x68, 0x81, 0x82, 0x90, 0x68, 0x86, 0x89, 0x3E, 0x49, 0x0E, 0x40, 0x00, 0x2E, 0x50, 0xD0	; 037FCEDC
	.byte 0x37, 0x49, 0x0E, 0x68, 0x3C, 0x49, 0x76, 0x5A, 0x08, 0x21, 0x0E, 0x40, 0x00, 0x2E, 0x40, 0xD0	; 037FCEEC
	.byte 0x06, 0x1C, 0x0C, 0x36, 0x41, 0x89, 0x71, 0x18, 0xC9, 0x1F, 0x01, 0x26, 0xB1, 0x43, 0x0E, 0x88	; 037FCEFC
	.byte 0x00, 0x2E, 0x36, 0xD1, 0x49, 0x88, 0x00, 0x29, 0x33, 0xD1, 0x28, 0x1C, 0xA8, 0x30, 0x00, 0x68	; 037FCF0C
	.byte 0xD1, 0x68, 0x89, 0x88, 0x40, 0x1A, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x26, 0x2F, 0x49, 0x0E, 0x80	; 037FCF1C
	.byte 0x2B, 0x4E, 0x0E, 0x80, 0x29, 0x1C, 0xBA, 0x31, 0x09, 0x88, 0x49, 0x1C, 0x2E, 0x1C, 0xBA, 0x36	; 037FCF2C
	.byte 0x31, 0x80, 0x29, 0x1C, 0x8C, 0x31, 0x09, 0x88, 0x88, 0x42, 0x12, 0xD9, 0xD1, 0x68, 0x00, 0x98	; 037FCF3C
	.byte 0x08, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0x38, 0x1C, 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C	; 037FCF4C
	.byte 0x38, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0xD0, 0x68, 0x01, 0x21, 0x12, 0x69, 0x08, 0xF0, 0xB4, 0xF8	; 037FCF5C
	.byte 0x25, 0xE0, 0xD1, 0x68, 0x00, 0x20, 0x88, 0x81, 0x19, 0x88, 0x19, 0x48, 0x01, 0x43, 0x19, 0x80	; 037FCF6C
	.byte 0x1D, 0xE0, 0xD3, 0x68, 0x99, 0x89, 0x86, 0x88, 0xFF, 0x20, 0x06, 0x40, 0x88, 0x19, 0x98, 0x81	; 037FCF7C
	.byte 0x04, 0xE0, 0x81, 0x88, 0xFF, 0x20, 0x01, 0x40, 0xD0, 0x68, 0x81, 0x81, 0x90, 0x88, 0x40, 0x1C	; 037FCF8C
	.byte 0x90, 0x80, 0xD0, 0x68, 0x01, 0x99, 0x12, 0x69, 0x08, 0xF0, 0x96, 0xF8, 0x07, 0xE0, 0x90, 0x88	; 037FCF9C
	.byte 0x40, 0x1C, 0x90, 0x80, 0x90, 0x68, 0x03, 0x21, 0x12, 0x69, 0x08, 0xF0, 0x8D, 0xF8, 0x64, 0x1E	; 037FCFAC
	.byte 0x00, 0x2C, 0x00, 0xDB, 0x75, 0xE7, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCFBC
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04	; 037FCFCC
	.byte 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x38, 0x06, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04	; 037FCFDC
.thumb
P2_Entry_037FCFEC:
	push {r4,r5,r6,r7,lr}	; 037FCFEC
	sub sp,#0x24	; 037FCFEE
	ldr r0,[pool_037FD24C]	; 037FCFF0
	ldr r1,[r0,#0x0]	; 037FCFF2
	ldr r0,[pool_037FD250]	; 037FCFF4
	add r7,r1,r0	; 037FCFF6
	ldr r0,[pool_037FD254]	; 037FCFF8
	add r6,r1,r0	; 037FCFFA
	mov r0,#0x0	; 037FCFFC
	str r0,[sp,#0x0]	; 037FCFFE
	str r0,[sp,#0xc]	; 037FD000
	str r0,[sp,#0x1c]	; 037FD002
	str r0,[sp,#0x18]	; 037FD004
	str r0,[sp,#0x14]	; 037FD006
	str r0,[sp,#0x10]	; 037FD008
	str r0,[sp,#0x20]	; 037FD00A
P2_Entry_037FD00C:
	ldr r0,[pool_037FD258]	; 037FD00C
	ldrh r1,[r0,#0x0]	; 037FD00E
	ldrh r0,[r7,#0x4]	; 037FD010
	cmp r1,r0	; 037FD012
	bne P2_Entry_037FD018	; 037FD014
	b P2_Entry_037FD244	; 037FD016
P2_Entry_037FD018:
	lsl r4,r1,#0x1	; 037FD018
	ldr r0,[pool_037FD25C]	; 037FD01A
	add r5,r4,r0	; 037FD01C
	add r0,r5,#0x2	; 037FD01E
	bl P2_Entry_037FCDD0	; 037FD020
	ldrh r0,[r0,#0x0]	; 037FD024
	str r0,[sp,#0x8]	; 037FD026
	ldr r0,[pool_037FD25C]	; 037FD028
	ldrh r1,[r4,r0]	; 037FD02A
	ldr r0,[pool_037FD260]	; 037FD02C
	cmp r1,r0	; 037FD02E
	bne P2_Entry_037FD03A	; 037FD030
	ldr r1,[sp,#0x8]	; 037FD032
	ldr r0,[pool_037FD258]	; 037FD034
	strh r1,[r0,#0x0]	; 037FD036
	b P2_Entry_037FD23C	; 037FD038
P2_Entry_037FD03A:
	add r0,r5,#0x0	; 037FD03A
	add r0,#0x8	; 037FD03C
	bl P2_Entry_037FCDD0	; 037FD03E
	ldrh r1,[r0,#0x0]	; 037FD042
	add r0,r5,#0x0	; 037FD044
	bl P2_Entry_037FD434	; 037FD046
	add r4,r0,#0x0	; 037FD04A
	ldr r1,[sp,#0x8]	; 037FD04C
	ldr r0,[pool_037FD258]	; 037FD04E
	strh r1,[r0,#0x0]	; 037FD050
	cmp r4,#0x0	; 037FD052
	bne P2_Entry_037FD070	; 037FD054
	ldrh r1,[r5,#0x0]	; 037FD056
	mov r0,#0xf	; 037FD058
	and r1,r0	; 037FD05A
	cmp r1,#0xc	; 037FD05C
	bne P2_Entry_037FD068	; 037FD05E
	mov r0,#0x10	; 037FD060
	bl P2_Entry_037FC9E0	; 037FD062
	b P2_Entry_037FD23C	; 037FD066
P2_Entry_037FD068:
	mov r0,#0x8	; 037FD068
	bl P2_Entry_037FC9E0	; 037FD06A
	b P2_Entry_037FD23C	; 037FD06E
P2_Entry_037FD070:
	ldr r0,[pool_037FD24C]	; 037FD070
	ldr r1,[r0,#0x0]	; 037FD072
	ldr r0,[pool_037FD264]	; 037FD074
	ldrh r1,[r1,r0]	; 037FD076
	mov r0,#0x8	; 037FD078
	and r1,r0	; 037FD07A
	cmp r1,#0x0	; 037FD07C
	beq P2_Entry_037FD08E	; 037FD07E
	ldrh r1,[r4,#0x14]	; 037FD080
	ldr r0,[pool_037FD268]	; 037FD082
	and r1,r0	; 037FD084
	cmp r1,#0x0	; 037FD086
	beq P2_Entry_037FD08E	; 037FD088
	ldr r0,[sp,#0xc]	; 037FD08A
	strh r0,[r7,#0x2]	; 037FD08C
P2_Entry_037FD08E:
	ldrh r1,[r4,#0x8]	; 037FD08E
	mov r0,#0x1	; 037FD090
	str r0,[sp,#0x4]	; 037FD092
	add r2,r1,#0x0	; 037FD094
	ldr r0,[pool_037FD26C]	; 037FD096
	and r2,r0	; 037FD098
	cmp r2,#0x0	; 037FD09A
	beq P2_Entry_037FD0D2	; 037FD09C
	ldrh r0,[r4,#0x14]	; 037FD09E
	lsl r0,r0,#0x15	; 037FD0A0
	lsr r0,r0,#0x1f	; 037FD0A2
	cmp r0,#0x1	; 037FD0A4
	beq P2_Entry_037FD0B4	; 037FD0A6
	ldrh r0,[r4,#0x2a]	; 037FD0A8
	lsl r0,r0,#0x1c	; 037FD0AA
	lsr r0,r0,#0x1c	; 037FD0AC
	cmp r0,#0x0	; 037FD0AE
	bne P2_Entry_037FD0B4	; 037FD0B0
	b P2_Entry_037FD1FC	; 037FD0B2
P2_Entry_037FD0B4:
	ldr r0,[sp,#0x10]	; 037FD0B4
	str r0,[sp,#0x4]	; 037FD0B6
	add r0,r6,#0x0	; 037FD0B8
	add r0,#0xc	; 037FD0BA
	add r1,r6,#0x0	; 037FD0BC
	add r1,#0x6c	; 037FD0BE
	add r2,r4,#0x0	; 037FD0C0
	sub r2,#0x10	; 037FD0C2
	bl loc_037FB6F4	; 037FD0C4
	mov r0,#0x2	; 037FD0C8
	mov r1,#0x9	; 037FD0CA
	bl loc_037FB418	; 037FD0CC
	b P2_Entry_037FD1FC	; 037FD0D0
P2_Entry_037FD0D2:
	mov r0,#0xf	; 037FD0D2
	and r1,r0	; 037FD0D4
	cmp r1,#0xf	; 037FD0D6
	bls P2_Entry_037FD0DC	; 037FD0D8
	b P2_Entry_037FD1FC	; 037FD0DA
P2_Entry_037FD0DC:
	add r0,r1,r1	; 037FD0DC
P2_SwitchIndexPC_037FD0DC:
	add r0,pc	; 037FD0DE
	ldrh r0,[r0,#(P2_SwitchTable_037FD0DC - (P2_SwitchIndexPC_037FD0DC + 4))]	; 037FD0E0
	lsl r0,r0,#0x10	; 037FD0E2
	asr r0,r0,#0x10	; 037FD0E4
P2_SwitchTargetPC_037FD0DC:
	add r0,pc	; 037FD0E6
	bx r0	; 037FD0E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD0DC:
	.halfword (P2_Case_037FD140 + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD132 + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD168 + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD10A + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Entry_037FD1FC + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD1A4 + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD1DA + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD190 + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
	.halfword (P2_Case_037FD190 + 1) - (P2_SwitchTargetPC_037FD0DC + 4)
P2_SwitchTable_037FD0DCEnd:
P2_Case_037FD10A:
	ldrh r1,[r4,#0x14]	; 037FD10A
	mov r0,#0xf	; 037FD10C
	and r1,r0	; 037FD10E
	cmp r1,#0x8	; 037FD110
	bne P2_Entry_037FD1FC	; 037FD112
	ldr r0,[sp,#0x14]	; 037FD114
	str r0,[sp,#0x4]	; 037FD116
	add r0,r6,#0x0	; 037FD118
	add r0,#0xc	; 037FD11A
	add r1,r6,#0x0	; 037FD11C
	add r1,#0x48	; 037FD11E
	add r2,r4,#0x0	; 037FD120
	sub r2,#0x10	; 037FD122
	bl loc_037FB6F4	; 037FD124
	mov r0,#0x2	; 037FD128
	mov r1,#0x6	; 037FD12A
	bl loc_037FB418	; 037FD12C
	b P2_Entry_037FD1FC	; 037FD130
P2_Case_037FD132:
	ldrh r0,[r4,#0x14]	; 037FD132
	cmp r0,#0x80	; 037FD134
	bne P2_Entry_037FD1FC	; 037FD136
	add r0,r4,#0x0	; 037FD138
	bl P2_Entry_037FD29C	; 037FD13A
	b P2_Entry_037FD1FC	; 037FD13E
P2_Case_037FD140:
	ldrh r1,[r4,#0x14]	; 037FD140
	mov r0,#0xf	; 037FD142
	and r1,r0	; 037FD144
	cmp r1,#0x0	; 037FD146
	bne P2_Entry_037FD1FC	; 037FD148
	ldr r0,[sp,#0x18]	; 037FD14A
	str r0,[sp,#0x4]	; 037FD14C
	add r0,r6,#0x0	; 037FD14E
	add r0,#0xc	; 037FD150
	add r1,r6,#0x0	; 037FD152
	add r1,#0x60	; 037FD154
	add r2,r4,#0x0	; 037FD156
	sub r2,#0x10	; 037FD158
	bl loc_037FB6F4	; 037FD15A
	mov r0,#0x1	; 037FD15E
	mov r1,#0x7	; 037FD160
	bl loc_037FB418	; 037FD162
	b P2_Entry_037FD1FC	; 037FD166
P2_Case_037FD168:
	ldrh r1,[r4,#0x14]	; 037FD168
	ldr r0,[pool_037FD270]	; 037FD16A
	and r1,r0	; 037FD16C
	cmp r1,#0xa4	; 037FD16E
	bne P2_Entry_037FD1FC	; 037FD170
	ldr r0,[sp,#0x1c]	; 037FD172
	str r0,[sp,#0x4]	; 037FD174
	add r0,r6,#0x0	; 037FD176
	add r0,#0xc	; 037FD178
	add r1,r6,#0x0	; 037FD17A
	add r1,#0x60	; 037FD17C
	add r2,r4,#0x0	; 037FD17E
	sub r2,#0x10	; 037FD180
	bl loc_037FB6F4	; 037FD182
	mov r0,#0x1	; 037FD186
	mov r1,#0x7	; 037FD188
	bl loc_037FB418	; 037FD18A
	b P2_Entry_037FD1FC	; 037FD18E
P2_Case_037FD190:
	ldrh r0,[r4,#0x14]	; 037FD190
	ldr r1,[pool_037FD274]	; 037FD192
	and r0,r1	; 037FD194
	ldr r1,[pool_037FD278]	; 037FD196
	cmp r0,r1	; 037FD198
	bne P2_Entry_037FD1FC	; 037FD19A
	add r0,r4,#0x0	; 037FD19C
	bl P2_Entry_037FD2AC	; 037FD19E
	b P2_Entry_037FD1FC	; 037FD1A2
P2_Case_037FD1A4:
	ldrh r0,[r4,#0x14]	; 037FD1A4
	ldr r1,[pool_037FD270]	; 037FD1A6
	and r0,r1	; 037FD1A8
	ldr r1,[pool_037FD27C]	; 037FD1AA
	cmp r0,r1	; 037FD1AC
	bne P2_Entry_037FD1FC	; 037FD1AE
	ldr r0,[pool_037FD24C]	; 037FD1B0
	ldr r1,[r0,#0x0]	; 037FD1B2
	ldr r0,[pool_037FD280]	; 037FD1B4
	ldrh r0,[r1,r0]	; 037FD1B6
	cmp r0,#0x0	; 037FD1B8
	bne P2_Entry_037FD1C2	; 037FD1BA
	mov r1,#0x1	; 037FD1BC
	ldr r0,[pool_037FD284]	; 037FD1BE
	strh r1,[r0,#0x0]	; 037FD1C0
P2_Entry_037FD1C2:
	ldr r0,[pool_037FD24C]	; 037FD1C2
	ldr r2,[r0,#0x0]	; 037FD1C4
	ldr r0,[pool_037FD288]	; 037FD1C6
	ldr r0,[r2,r0]	; 037FD1C8
	add r1,r0,#0x1	; 037FD1CA
	ldr r0,[pool_037FD288]	; 037FD1CC
	str r1,[r2,r0]	; 037FD1CE
	add r0,r4,#0x0	; 037FD1D0
	bl P2_Entry_037FD2BC	; 037FD1D2
	str r0,[sp,#0x4]	; 037FD1D6
	b P2_Entry_037FD1FC	; 037FD1D8
P2_Case_037FD1DA:
	ldrh r0,[r4,#0x14]	; 037FD1DA
	ldr r1,[pool_037FD270]	; 037FD1DC
	and r0,r1	; 037FD1DE
	ldr r1,[pool_037FD28C]	; 037FD1E0
	cmp r0,r1	; 037FD1E2
	bne P2_Entry_037FD1FC	; 037FD1E4
	ldr r0,[pool_037FD24C]	; 037FD1E6
	ldr r2,[r0,#0x0]	; 037FD1E8
	ldr r0,[pool_037FD290]	; 037FD1EA
	ldr r0,[r2,r0]	; 037FD1EC
	add r1,r0,#0x1	; 037FD1EE
	ldr r0,[pool_037FD290]	; 037FD1F0
	str r1,[r2,r0]	; 037FD1F2
	add r0,r4,#0x0	; 037FD1F4
	bl P2_Entry_037FD2CC	; 037FD1F6
	str r0,[sp,#0x4]	; 037FD1FA
P2_Entry_037FD1FC:
	ldr r0,[sp,#0x4]	; 037FD1FC
	cmp r0,#0x0	; 037FD1FE
	beq P2_Entry_037FD20E	; 037FD200
	add r0,r6,#0x0	; 037FD202
	add r0,#0xc	; 037FD204
	sub r4,#0x10	; 037FD206
	add r1,r4,#0x0	; 037FD208
	bl P2_Entry_037FB69C	; 037FD20A
P2_Entry_037FD20E:
	ldr r0,[pool_037FD24C]	; 037FD20E
	ldr r1,[r0,#0x0]	; 037FD210
	ldr r0,[pool_037FD264]	; 037FD212
	ldrh r1,[r1,r0]	; 037FD214
	mov r0,#0x1	; 037FD216
	and r1,r0	; 037FD218
	cmp r1,#0x0	; 037FD21A
	beq P2_Entry_037FD23C	; 037FD21C
	ldr r0,[sp,#0x20]	; 037FD21E
P2_Entry_037FD220:
	ldr r1,[pool_037FD294]	; 037FD220
	cmp r5,r1	; 037FD222
	bcc P2_Entry_037FD230	; 037FD224
	ldr r1,[pool_037FD24C]	; 037FD226
	ldr r2,[r1,#0x0]	; 037FD228
	ldr r1,[pool_037FD298]	; 037FD22A
	ldrh r1,[r2,r1]	; 037FD22C
	sub r5,r5,r1	; 037FD22E
P2_Entry_037FD230:
	ldr r1,[pool_037FD260]	; 037FD230
	strh r1,[r5,#0x0]	; 037FD232
	add r5,r5,#0x2	; 037FD234
	add r0,r0,#0x1	; 037FD236
	cmp r0,#0x7	; 037FD238
	bcc P2_Entry_037FD220	; 037FD23A
P2_Entry_037FD23C:
	ldr r0,[sp,#0x0]	; 037FD23C
	add r0,r0,#0x1	; 037FD23E
	str r0,[sp,#0x0]	; 037FD240
	b P2_Entry_037FD00C	; 037FD242
P2_Entry_037FD244:
	add sp,#0x24	; 037FD244
	pop {r4,r5,r6,r7}	; 037FD246
	pop {r3}	; 037FD248
	bx r3	; 037FD24A
pool_037FD24C:
	.word FirmwareWlWorkPointerSlot	; 037FD24C
pool_037FD250:
	.word 0x000004B4	; 037FD250
pool_037FD254:
	.word 0x00000150	; 037FD254
pool_037FD258:
	.word REG_WIFI_RXBUF_READCSR	; 037FD258
pool_037FD25C:
	.word WifiRamBase	; 037FD25C
pool_037FD260:
	.word 0x0000FFFF	; 037FD260
pool_037FD264:
	.word 0x00000638	; 037FD264
pool_037FD268:
	.word 0x00004000	; 037FD268
pool_037FD26C:
	.word 0x00000200	; 037FD26C
pool_037FD270:
	.word 0x0000E7FF	; 037FD270
pool_037FD274:
	.word 0x0000E7BF	; 037FD274
pool_037FD278:
	.word 0x00000118	; 037FD278
pool_037FD27C:
	.word 0x00000228	; 037FD27C
pool_037FD280:
	.word 0x00000328	; 037FD280
pool_037FD284:
	.word REG_WIFI_POWERSTATE	; 037FD284
pool_037FD288:
	.word 0x00000580	; 037FD288
pool_037FD28C:
	.word 0x00000218	; 037FD28C
pool_037FD290:
	.word 0x00000584	; 037FD290
pool_037FD294:
	.word 0x04805F60	; 037FD294
pool_037FD298:
	.word 0x000003B2	; 037FD298
P2_Entry_037FD29C:
	bx pc	; 037FD29C
	.byte 0xC0, 0x46	; 037FD29E
.arm
	ldr r12,[pool_037FD2A8]	; 037FD2A0
	bx r12	; 037FD2A4
pool_037FD2A8:
	.word loc_0230C6D0 + 1	; 037FD2A8
P2_Entry_037FD2AC:
.thumb
	bx pc	; 037FD2AC
	.byte 0xC0, 0x46	; 037FD2AE
.arm
	ldr r12,[pool_037FD2B8]	; 037FD2B0
	bx r12	; 037FD2B4
pool_037FD2B8:
	.word P4_Entry_0230CCD4 + 1	; 037FD2B8
P2_Entry_037FD2BC:
.thumb
	bx pc	; 037FD2BC
	.byte 0xC0, 0x46	; 037FD2BE
.arm
	ldr r12,[pool_037FD2C8]	; 037FD2C0
	bx r12	; 037FD2C4
pool_037FD2C8:
	.word P4_Entry_0230CE0C + 1	; 037FD2C8
P2_Entry_037FD2CC:
.thumb
	bx pc	; 037FD2CC
	.byte 0xC0, 0x46	; 037FD2CE
.arm
	ldr r12,[pool_037FD2D8]	; 037FD2D0
	bx r12	; 037FD2D4
pool_037FD2D8:
	.word P4_Entry_0230CC2C + 1	; 037FD2D8
.thumb
P2_Entry_037FD2DC:
	push {r4,lr}	; 037FD2DC
	ldr r0,[pool_037FD380]	; 037FD2DE
	ldr r1,[r0,#0x0]	; 037FD2E0
	ldr r0,[pool_037FD384]	; 037FD2E2
	add r4,r1,r0	; 037FD2E4
	ldrh r0,[r4,#0x3c]	; 037FD2E6
	cmp r0,#0x0	; 037FD2E8
	beq P2_Entry_037FD37A	; 037FD2EA
	add r0,r4,#0x0	; 037FD2EC
	add r0,#0x90	; 037FD2EE
	ldr r0,[r0,#0x0]	; 037FD2F0
	ldrh r1,[r0,#0x10]	; 037FD2F2
	ldr r0,[r4,#0x44]	; 037FD2F4
	ldrh r0,[r0,#0x2]	; 037FD2F6
	cmp r1,r0	; 037FD2F8
	beq P2_Entry_037FD300	; 037FD2FA
	bl P2_Entry_037FCFEC	; 037FD2FC
P2_Entry_037FD300:
	ldr r0,[r4,#0x44]	; 037FD300
	ldrh r0,[r0,#0x4]	; 037FD302
	mov r1,#0xff	; 037FD304
	and r0,r1	; 037FD306
	cmp r0,#0x0	; 037FD308
	beq P2_Entry_037FD31C	; 037FD30A
	ldr r1,[pool_037FD380]	; 037FD30C
	ldr r2,[r1,#0x0]	; 037FD30E
	ldr r1,[pool_037FD388]	; 037FD310
	add r1,r2,r1	; 037FD312
	ldr r2,[r1,#0x0]	; 037FD314
	add r0,r2,r0	; 037FD316
	str r0,[r1,#0x0]	; 037FD318
	b P2_Entry_037FD32A	; 037FD31A
P2_Entry_037FD31C:
	ldr r0,[pool_037FD380]	; 037FD31C
	ldr r1,[r0,#0x0]	; 037FD31E
	ldr r0,[pool_037FD388]	; 037FD320
	add r0,r1,r0	; 037FD322
	ldr r1,[r0,#0x0]	; 037FD324
	add r1,r1,#0x1	; 037FD326
	str r1,[r0,#0x0]	; 037FD328
P2_Entry_037FD32A:
	add r0,r4,#0x0	; 037FD32A
	add r0,#0x40	; 037FD32C
	ldrh r0,[r0,#0x0]	; 037FD32E
	add r1,r0,#0x1	; 037FD330
	add r0,r4,#0x0	; 037FD332
	add r0,#0x40	; 037FD334
	strh r1,[r0,#0x0]	; 037FD336
	add r0,r4,#0x0	; 037FD338
	add r0,#0x90	; 037FD33A
	ldr r2,[r0,#0x0]	; 037FD33C
	ldrh r1,[r2,#0x10]	; 037FD33E
	ldr r0,[r4,#0x44]	; 037FD340
	ldrh r0,[r0,#0x2]	; 037FD342
	eor r1,r0	; 037FD344
	strh r1,[r2,#0x12]	; 037FD346
	add r0,r4,#0x0	; 037FD348
	add r0,#0x90	; 037FD34A
	ldr r0,[r0,#0x0]	; 037FD34C
	ldrh r1,[r0,#0x10]	; 037FD34E
	add r0,r4,#0x0	; 037FD350
	add r0,#0xa0	; 037FD352
	strh r1,[r0,#0x0]	; 037FD354
	mov r0,#0x0	; 037FD356
	strh r0,[r4,#0x3c]	; 037FD358
	ldr r0,[pool_037FD380]	; 037FD35A
	ldr r1,[r0,#0x0]	; 037FD35C
	ldr r0,[pool_037FD38C]	; 037FD35E
	ldrh r0,[r1,r0]	; 037FD360
	cmp r0,#0x0	; 037FD362
	beq P2_Entry_037FD36A	; 037FD364
	bl loc_037FBDC4	; 037FD366
P2_Entry_037FD36A:
	ldr r0,[pool_037FD380]	; 037FD36A
	ldr r1,[r0,#0x0]	; 037FD36C
	ldr r0,[pool_037FD390]	; 037FD36E
	add r0,r1,r0	; 037FD370
	add r4,#0x90	; 037FD372
	ldr r1,[r4,#0x0]	; 037FD374
	bl loc_037FB9B4	; 037FD376
P2_Entry_037FD37A:
	pop {r4}	; 037FD37A
	pop {r3}	; 037FD37C
	bx r3	; 037FD37E
pool_037FD380:
	.word FirmwareWlWorkPointerSlot	; 037FD380
pool_037FD384:
	.word 0x00000400	; 037FD384
pool_037FD388:
	.word 0x00000574	; 037FD388
pool_037FD38C:
	.word 0x000003BE	; 037FD38C
pool_037FD390:
	.word 0x0000015C	; 037FD390
	.byte 0x10, 0xB5, 0x19, 0x48, 0x00, 0x68, 0x19, 0x49, 0x44, 0x18, 0x19, 0x49, 0x09, 0x88, 0x00, 0x29	; 037FD394
	.byte 0x08, 0xD1, 0x21, 0x8F, 0x00, 0x29, 0x05, 0xD0, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FD3A4
	.byte 0x2F, 0xF8, 0x1D, 0xE0, 0x14, 0x49, 0x42, 0x5A, 0x14, 0x49, 0x40, 0x5A, 0x82, 0x43, 0x00, 0x2A	; 037FD3B4
	.byte 0x07, 0xD1, 0x08, 0x21, 0x0F, 0x48, 0x01, 0x80, 0x20, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0	; 037FD3C4
	.byte 0x1F, 0xF8, 0x05, 0x21, 0x0B, 0x48, 0x01, 0x80, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 037FD3D4
	.byte 0x00, 0xF0, 0x1E, 0xF8, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0x18, 0xF8	; 037FD3E4
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00	; 037FD3F4
	.byte 0x88, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 037FD404
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x81, 0xAE, 0x30, 0x02	; 037FD414
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x0D, 0xAF, 0x30, 0x02	; 037FD424
P2_Entry_037FD434:
	push {r4,r5,r6,lr}	; 037FD434
	add r6,r0,#0x0	; 037FD436
	add r5,r1,#0x0	; 037FD438
	ldr r0,[pool_037FD484]	; 037FD43A
	ldr r1,[r0,#0x0]	; 037FD43C
	ldr r0,[pool_037FD488]	; 037FD43E
	add r0,r1,r0	; 037FD440
	add r1,r5,#0x0	; 037FD442
	add r1,#0x22	; 037FD444
	bl P2_Entry_037FB630	; 037FD446
	cmp r0,#0x0	; 037FD44A
	bne P2_Entry_037FD452	; 037FD44C
	mov r0,#0x0	; 037FD44E
	b P2_Entry_037FD47C	; 037FD450
P2_Entry_037FD452:
	add r4,r0,#0x0	; 037FD452
	add r4,#0x10	; 037FD454
	add r0,r4,#0x0	; 037FD456
	add r0,#0x8	; 037FD458
	add r1,r6,#0x0	; 037FD45A
	add r2,r5,#0x0	; 037FD45C
	add r2,#0xc	; 037FD45E
	bl P2_Entry_037FD48C	; 037FD460
	sub r5,#0x18	; 037FD464
	strh r5,[r4,#0x6]	; 037FD466
	ldrh r2,[r4,#0xe]	; 037FD468
	mov r0,#0xff	; 037FD46A
	and r2,r0	; 037FD46C
	ldrh r1,[r4,#0x12]	; 037FD46E
	and r1,r0	; 037FD470
	lsl r0,r1,#0x10	; 037FD472
	lsr r0,r0,#0x8	; 037FD474
	orr r2,r0	; 037FD476
	strh r2,[r4,#0xe]	; 037FD478
	add r0,r4,#0x0	; 037FD47A
P2_Entry_037FD47C:
	pop {r4,r5,r6}	; 037FD47C
	pop {r3}	; 037FD47E
	bx r3	; 037FD480
	.byte 0xC0, 0x46	; 037FD482
pool_037FD484:
	.word FirmwareWlWorkPointerSlot	; 037FD484
pool_037FD488:
	.word 0x0000015C	; 037FD488
P2_Entry_037FD48C:
	bx pc	; 037FD48C
	.byte 0xC0, 0x46	; 037FD48E
.arm
	ldr r12,[pool_037FD498]	; 037FD490
	bx r12	; 037FD494
pool_037FD498:
	.word loc_023052B4 + 1	; 037FD498
.thumb

; ===== function loc_037FD49C =====
loc_037FD49C:
	push {r4,r5,r6,r7,lr}	; 037FD49C
	sub sp,#0x4	; 037FD49E
	ldr r0,[pool_037FD65C]	; 037FD4A0
	ldr r6,[r0,#0x0]	; 037FD4A2
	ldr r0,[pool_037FD660]	; 037FD4A4
	add r4,r6,r0	; 037FD4A6
	ldr r0,[pool_037FD664]	; 037FD4A8
	add r5,r6,r0	; 037FD4AA
	ldr r0,[pool_037FD668]	; 037FD4AC
	add r7,r6,r0	; 037FD4AE
	mov r0,#0x0	; 037FD4B0
	str r0,[sp,#0x0]	; 037FD4B2
	ldr r0,[sp,#0x0]	; 037FD4B4
	add r1,r4,#0x0	; 037FD4B6
	mov r2,#0xb4	; 037FD4B8
	bl loc_037FD728	; 037FD4BA
	mov r1,#0x0	; 037FD4BE
	ldr r0,[pool_037FD660]	; 037FD4C0
	strh r1,[r6,r0]	; 037FD4C2
	str r1,[r4,#0xc]	; 037FD4C4
	strh r1,[r4,#0x14]	; 037FD4C6
	str r1,[r4,#0x20]	; 037FD4C8
	strh r1,[r4,#0x28]	; 037FD4CA
	str r1,[r4,#0x34]	; 037FD4CC
	ldr r1,[pool_037FD66C]	; 037FD4CE
	add r0,r4,#0x0	; 037FD4D0
	add r0,#0xa4	; 037FD4D2
	strh r1,[r0,#0x0]	; 037FD4D4
	add r0,r4,#0x0	; 037FD4D6
	add r0,#0xa6	; 037FD4D8
	strh r1,[r0,#0x0]	; 037FD4DA
	ldrh r0,[r5,#0xc]	; 037FD4DC
	cmp r0,#0x3	; 037FD4DE
	bls loc_037FD4E4	; 037FD4E0
	b loc_037FD63E	; 037FD4E2
loc_037FD4E4:
	add r0,r0,r0	; 037FD4E4
P2_SwitchIndexPC_037FD4E4:
	add r0,pc	; 037FD4E6
	ldrh r0,[r0,#(P2_SwitchTable_037FD4E4 - (P2_SwitchIndexPC_037FD4E4 + 4))]	; 037FD4E8
	lsl r0,r0,#0x10	; 037FD4EA
	asr r0,r0,#0x10	; 037FD4EC
P2_SwitchTargetPC_037FD4E4:
	add r0,pc	; 037FD4EE
	bx r0	; 037FD4F0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD4E4:
	.halfword (loc_037FD4FA + 1) - (P2_SwitchTargetPC_037FD4E4 + 4)
	.halfword (loc_037FD53E + 1) - (P2_SwitchTargetPC_037FD4E4 + 4)
	.halfword (loc_037FD5A0 + 1) - (P2_SwitchTargetPC_037FD4E4 + 4)
	.halfword (loc_037FD5FC + 1) - (P2_SwitchTargetPC_037FD4E4 + 4)
P2_SwitchTable_037FD4E4End:
loc_037FD4FA:
	ldr r0,[pool_037FD670]	; 037FD4FA
	str r0,[r4,#0x8]	; 037FD4FC
	ldr r0,[pool_037FD674]	; 037FD4FE
	str r0,[r4,#0x1c]	; 037FD500
	ldr r0,[pool_037FD678]	; 037FD502
	str r0,[r4,#0x30]	; 037FD504
	ldr r0,[pool_037FD67C]	; 037FD506
	str r0,[r4,#0x10]	; 037FD508
	ldr r0,[pool_037FD680]	; 037FD50A
	str r0,[r4,#0x24]	; 037FD50C
	ldr r0,[pool_037FD684]	; 037FD50E
	str r0,[r4,#0x38]	; 037FD510
	ldr r1,[pool_037FD688]	; 037FD512
	ldr r0,[pool_037FD68C]	; 037FD514
	strh r1,[r0,#0x0]	; 037FD516
	ldr r0,[pool_037FD690]	; 037FD518
	ldr r2,[pool_037FD694]	; 037FD51A
	strh r0,[r2,#0x0]	; 037FD51C
	ldr r2,[pool_037FD698]	; 037FD51E
	strh r1,[r2,#0x0]	; 037FD520
	ldr r2,[pool_037FD69C]	; 037FD522
	strh r0,[r2,#0x0]	; 037FD524
	ldr r2,[pool_037FD6A0]	; 037FD526
	strh r1,[r2,#0x0]	; 037FD528
	ldr r1,[pool_037FD6A4]	; 037FD52A
	strh r0,[r1,#0x0]	; 037FD52C
	mov r1,#0x8	; 037FD52E
	add r0,r5,#0x0	; 037FD530
	add r0,#0x8a	; 037FD532
	strh r1,[r0,#0x0]	; 037FD534
	mov r1,#0x1	; 037FD536
	ldr r0,[pool_037FD6A8]	; 037FD538
	strh r1,[r0,#0x0]	; 037FD53A
	b loc_037FD63E	; 037FD53C
loc_037FD53E:
	ldr r0,[pool_037FD6AC]	; 037FD53E
	str r0,[r4,#0x8]	; 037FD540
	ldr r0,[pool_037FD6B0]	; 037FD542
	str r0,[r4,#0x1c]	; 037FD544
	ldr r0,[pool_037FD6B4]	; 037FD546
	str r0,[r4,#0x30]	; 037FD548
	ldr r0,[pool_037FD67C]	; 037FD54A
	str r0,[r4,#0x10]	; 037FD54C
	ldr r0,[pool_037FD680]	; 037FD54E
	str r0,[r4,#0x24]	; 037FD550
	ldr r0,[pool_037FD6B8]	; 037FD552
	str r0,[r4,#0x38]	; 037FD554
	ldr r2,[pool_037FD6BC]	; 037FD556
	add r0,r4,#0x0	; 037FD558
	add r0,#0x80	; 037FD55A
	str r2,[r0,#0x0]	; 037FD55C
	ldr r0,[pool_037FD678]	; 037FD55E
	str r0,[r4,#0x44]	; 037FD560
	ldr r1,[pool_037FD688]	; 037FD562
	ldr r0,[pool_037FD6C0]	; 037FD564
	strh r1,[r0,#0x0]	; 037FD566
	ldr r0,[pool_037FD690]	; 037FD568
	ldr r3,[pool_037FD6C4]	; 037FD56A
	strh r0,[r3,#0x0]	; 037FD56C
	ldr r3,[pool_037FD6C8]	; 037FD56E
	strh r1,[r3,#0x0]	; 037FD570
	ldr r3,[pool_037FD6CC]	; 037FD572
	strh r0,[r3,#0x0]	; 037FD574
	ldr r3,[pool_037FD6D0]	; 037FD576
	strh r1,[r3,#0x0]	; 037FD578
	ldr r3,[pool_037FD6D4]	; 037FD57A
	strh r0,[r3,#0x0]	; 037FD57C
	ldr r3,[pool_037FD6D8]	; 037FD57E
	strh r1,[r3,#0x0]	; 037FD580
	ldr r3,[pool_037FD6DC]	; 037FD582
	strh r0,[r3,#0x0]	; 037FD584
	ldr r3,[pool_037FD6E0]	; 037FD586
	strh r1,[r3,#0x0]	; 037FD588
	ldr r1,[pool_037FD6E4]	; 037FD58A
	strh r0,[r1,#0x0]	; 037FD58C
	ldr r1,[pool_037FD6E8]	; 037FD58E
	add r0,r5,#0x0	; 037FD590
	add r0,#0x8a	; 037FD592
	strh r1,[r0,#0x0]	; 037FD594
	add r4,#0x80	; 037FD596
	str r2,[r4,#0x0]	; 037FD598
	bl loc_037FD734	; 037FD59A
	b loc_037FD63E	; 037FD59E
loc_037FD5A0:
	ldr r0,[pool_037FD6EC]	; 037FD5A0
	str r0,[r4,#0x8]	; 037FD5A2
	ldr r0,[pool_037FD6F0]	; 037FD5A4
	str r0,[r4,#0x1c]	; 037FD5A6
	ldr r0,[pool_037FD6F4]	; 037FD5A8
	str r0,[r4,#0x30]	; 037FD5AA
	ldr r0,[pool_037FD67C]	; 037FD5AC
	str r0,[r4,#0x10]	; 037FD5AE
	ldr r0,[pool_037FD680]	; 037FD5B0
	str r0,[r4,#0x24]	; 037FD5B2
	ldr r0,[pool_037FD684]	; 037FD5B4
	str r0,[r4,#0x38]	; 037FD5B6
	ldr r0,[pool_037FD678]	; 037FD5B8
	str r0,[r4,#0x58]	; 037FD5BA
	ldr r0,[pool_037FD6C0]	; 037FD5BC
	str r0,[r4,#0x6c]	; 037FD5BE
	ldr r1,[pool_037FD688]	; 037FD5C0
	ldr r0,[pool_037FD6F8]	; 037FD5C2
	strh r1,[r0,#0x0]	; 037FD5C4
	ldr r0,[pool_037FD690]	; 037FD5C6
	ldr r2,[pool_037FD6FC]	; 037FD5C8
	strh r0,[r2,#0x0]	; 037FD5CA
	ldr r2,[pool_037FD700]	; 037FD5CC
	strh r1,[r2,#0x0]	; 037FD5CE
	ldr r2,[pool_037FD704]	; 037FD5D0
	strh r0,[r2,#0x0]	; 037FD5D2
	ldr r2,[pool_037FD708]	; 037FD5D4
	strh r1,[r2,#0x0]	; 037FD5D6
	ldr r2,[pool_037FD70C]	; 037FD5D8
	strh r0,[r2,#0x0]	; 037FD5DA
	ldr r2,[pool_037FD710]	; 037FD5DC
	strh r1,[r2,#0x0]	; 037FD5DE
	ldr r2,[pool_037FD714]	; 037FD5E0
	strh r0,[r2,#0x0]	; 037FD5E2
	ldr r2,[pool_037FD718]	; 037FD5E4
	strh r1,[r2,#0x0]	; 037FD5E6
	ldr r1,[pool_037FD71C]	; 037FD5E8
	strh r0,[r1,#0x0]	; 037FD5EA
	ldr r1,[pool_037FD720]	; 037FD5EC
	add r0,r5,#0x0	; 037FD5EE
	add r0,#0x8a	; 037FD5F0
	strh r1,[r0,#0x0]	; 037FD5F2
	mov r1,#0xd	; 037FD5F4
	ldr r0,[pool_037FD6A8]	; 037FD5F6
	strh r1,[r0,#0x0]	; 037FD5F8
	b loc_037FD63E	; 037FD5FA
loc_037FD5FC:
	ldr r0,[pool_037FD670]	; 037FD5FC
	str r0,[r4,#0x8]	; 037FD5FE
	ldr r0,[pool_037FD674]	; 037FD600
	str r0,[r4,#0x1c]	; 037FD602
	ldr r0,[pool_037FD678]	; 037FD604
	str r0,[r4,#0x30]	; 037FD606
	ldr r0,[pool_037FD67C]	; 037FD608
	str r0,[r4,#0x10]	; 037FD60A
	ldr r0,[pool_037FD680]	; 037FD60C
	str r0,[r4,#0x24]	; 037FD60E
	ldr r0,[pool_037FD684]	; 037FD610
	str r0,[r4,#0x38]	; 037FD612
	ldr r1,[pool_037FD688]	; 037FD614
	ldr r0,[pool_037FD68C]	; 037FD616
	strh r1,[r0,#0x0]	; 037FD618
	ldr r0,[pool_037FD690]	; 037FD61A
	ldr r2,[pool_037FD694]	; 037FD61C
	strh r0,[r2,#0x0]	; 037FD61E
	ldr r2,[pool_037FD698]	; 037FD620
	strh r1,[r2,#0x0]	; 037FD622
	ldr r2,[pool_037FD69C]	; 037FD624
	strh r0,[r2,#0x0]	; 037FD626
	ldr r2,[pool_037FD6A0]	; 037FD628
	strh r1,[r2,#0x0]	; 037FD62A
	ldr r1,[pool_037FD6A4]	; 037FD62C
	strh r0,[r1,#0x0]	; 037FD62E
	ldr r1,[pool_037FD720]	; 037FD630
	add r0,r5,#0x0	; 037FD632
	add r0,#0x8a	; 037FD634
	strh r1,[r0,#0x0]	; 037FD636
	mov r1,#0xd	; 037FD638
	ldr r0,[pool_037FD6A8]	; 037FD63A
	strh r1,[r0,#0x0]	; 037FD63C
loc_037FD63E:
	ldrh r0,[r7,#0x18]	; 037FD63E
	cmp r0,#0x0	; 037FD640
	beq loc_037FD652	; 037FD642
	add r0,r5,#0x0	; 037FD644
	add r0,#0x8a	; 037FD646
	ldrh r1,[r0,#0x0]	; 037FD648
	ldr r0,[pool_037FD724]	; 037FD64A
	orr r1,r0	; 037FD64C
	add r5,#0x8a	; 037FD64E
	strh r1,[r5,#0x0]	; 037FD650
loc_037FD652:
	add sp,#0x4	; 037FD652
	pop {r4,r5,r6,r7}	; 037FD654
	pop {r3}	; 037FD656
	bx r3	; 037FD658
	.byte 0xC0, 0x46	; 037FD65C
pool_037FD65C:
loc_037FD65C:
	.word FirmwareWlWorkPointerSlot	; 037FD65C
pool_037FD660:
loc_037FD660:
	.word 0x00000400	; 037FD660
pool_037FD664:
loc_037FD664:
	.word 0x00000318	; 037FD664
pool_037FD668:
loc_037FD668:
	.word 0x000002F0	; 037FD668
pool_037FD66C:
loc_037FD66C:
	.word 0x0000FFFF	; 037FD66C
pool_037FD670:
loc_037FD670:
	.word 0x04804170	; 037FD670
pool_037FD674:
loc_037FD674:
	.word 0x04804028	; 037FD674
pool_037FD678:
loc_037FD678:
	.word WifiRamBase	; 037FD678
pool_037FD67C:
loc_037FD67C:
	.word 0x0230AC71	; 037FD67C
pool_037FD680:
loc_037FD680:
	.word 0x0230A9C1	; 037FD680
pool_037FD684:
loc_037FD684:
	.word 0x0230A971	; 037FD684
pool_037FD688:
loc_037FD688:
	.word 0x0000B6B8	; 037FD688
pool_037FD68C:
loc_037FD68C:
	.word WifiRamBase + 0x24	; 037FD68C
pool_037FD690:
loc_037FD690:
	.word 0x00001D46	; 037FD690
pool_037FD694:
loc_037FD694:
	.word WifiRamBase + 0x26	; 037FD694
pool_037FD698:
loc_037FD698:
	.word WifiRamBase + 0x16C	; 037FD698
pool_037FD69C:
loc_037FD69C:
	.word WifiRamBase + 0x16E	; 037FD69C
pool_037FD6A0:
loc_037FD6A0:
	.word WifiRamBase + 0x790	; 037FD6A0
pool_037FD6A4:
loc_037FD6A4:
	.word WifiRamBase + 0x792	; 037FD6A4
pool_037FD6A8:
loc_037FD6A8:
	.word REG_WIFI_TXREQ_SET	; 037FD6A8
pool_037FD6AC:
loc_037FD6AC:
	.word 0x04804AA0	; 037FD6AC
pool_037FD6B0:
loc_037FD6B0:
	.word 0x04804958	; 037FD6B0
pool_037FD6B4:
loc_037FD6B4:
	.word 0x04804334	; 037FD6B4
pool_037FD6B8:
loc_037FD6B8:
	.word 0x0230A8A5	; 037FD6B8
pool_037FD6BC:
loc_037FD6BC:
	.word 0x04804238	; 037FD6BC
pool_037FD6C0:
loc_037FD6C0:
	.word WifiRamBase + 0x234	; 037FD6C0
pool_037FD6C4:
loc_037FD6C4:
	.word WifiRamBase + 0x236	; 037FD6C4
pool_037FD6C8:
loc_037FD6C8:
	.word WifiRamBase + 0x330	; 037FD6C8
pool_037FD6CC:
loc_037FD6CC:
	.word WifiRamBase + 0x332	; 037FD6CC
pool_037FD6D0:
loc_037FD6D0:
	.word WifiRamBase + 0x954	; 037FD6D0
pool_037FD6D4:
loc_037FD6D4:
	.word WifiRamBase + 0x956	; 037FD6D4
pool_037FD6D8:
loc_037FD6D8:
	.word WifiRamBase + 0xA9C	; 037FD6D8
pool_037FD6DC:
loc_037FD6DC:
	.word WifiRamBase + 0xA9E	; 037FD6DC
pool_037FD6E0:
loc_037FD6E0:
	.word WifiRamBase + 0x10C0	; 037FD6E0
pool_037FD6E4:
loc_037FD6E4:
	.word WifiRamBase + 0x10C2	; 037FD6E4
pool_037FD6E8:
loc_037FD6E8:
	.word 0x00000208	; 037FD6E8
pool_037FD6EC:
loc_037FD6EC:
	.word 0x048045D8	; 037FD6EC
pool_037FD6F0:
loc_037FD6F0:
	.word 0x04804490	; 037FD6F0
pool_037FD6F4:
loc_037FD6F4:
	.word 0x04804468	; 037FD6F4
pool_037FD6F8:
loc_037FD6F8:
	.word WifiRamBase + 0x230	; 037FD6F8
pool_037FD6FC:
loc_037FD6FC:
	.word WifiRamBase + 0x232	; 037FD6FC
pool_037FD700:
loc_037FD700:
	.word WifiRamBase + 0x464	; 037FD700
pool_037FD704:
loc_037FD704:
	.word WifiRamBase + 0x466	; 037FD704
pool_037FD708:
loc_037FD708:
	.word WifiRamBase + 0x48C	; 037FD708
pool_037FD70C:
loc_037FD70C:
	.word WifiRamBase + 0x48E	; 037FD70C
pool_037FD710:
loc_037FD710:
	.word WifiRamBase + 0x5D4	; 037FD710
pool_037FD714:
loc_037FD714:
	.word WifiRamBase + 0x5D6	; 037FD714
pool_037FD718:
loc_037FD718:
	.word WifiRamBase + 0xBF8	; 037FD718
pool_037FD71C:
loc_037FD71C:
	.word WifiRamBase + 0xBFA	; 037FD71C
pool_037FD720:
loc_037FD720:
	.word 0x00000108	; 037FD720
pool_037FD724:
loc_037FD724:
	.word 0x00004000	; 037FD724

; ===== function loc_037FD728 =====
loc_037FD728:
	bx pc	; 037FD728
	.byte 0xC0, 0x46	; 037FD72C
.arm

; ===== function loc_037FD72C =====
loc_037FD72C:
	ldr pc,[pool_037FD730]	; 037FD72C
pool_037FD730:
loc_037FD730:
	.word loc_037FF3A4	; 037FD730
.thumb

; ===== function loc_037FD734 =====
loc_037FD734:
	bx pc	; 037FD734
	.byte 0xC0, 0x46	; 037FD738
.arm

; ===== function loc_037FD738 =====
loc_037FD738:
	ldr r12,[pool_037FD740]	; 037FD738
	bx r12	; 037FD73C
pool_037FD740:
loc_037FD740:
	.word P4_Entry_0230A0B4 + 1	; 037FD740
.thumb

; ===== function loc_037FD744 =====
loc_037FD744:
	push {r4,r5,r6,lr}	; 037FD744
	sub sp,#0x8	; 037FD746
	ldr r0,[pool_037FD7D4]	; 037FD748
	ldr r1,[r0,#0x0]	; 037FD74A
	ldr r0,[pool_037FD7D8]	; 037FD74C
	add r6,r1,r0	; 037FD74E
	ldr r0,[pool_037FD7DC]	; 037FD750
	add r4,r1,r0	; 037FD752
	mov r0,#0x0	; 037FD754
	str r0,[sp,#0x0]	; 037FD756
	ldr r0,[sp,#0x0]	; 037FD758
	add r1,r4,#0x0	; 037FD75A
	mov r2,#0x50	; 037FD75C
	bl loc_037FD824	; 037FD75E
	ldr r1,[pool_037FD7E0]	; 037FD762
	ldr r0,[pool_037FD7E4]	; 037FD764
	strh r1,[r0,#0x0]	; 037FD766
	ldr r0,[pool_037FD7D4]	; 037FD768
	ldr r1,[r0,#0x0]	; 037FD76A
	ldr r0,[pool_037FD7E8]	; 037FD76C
	ldrh r0,[r1,r0]	; 037FD76E
	cmp r0,#0x3	; 037FD770
	bhi loc_037FD798	; 037FD772
	add r0,r0,r0	; 037FD774
P2_SwitchIndexPC_037FD774:
	add r0,pc	; 037FD776
	ldrh r0,[r0,#(P2_SwitchTable_037FD774 - (P2_SwitchIndexPC_037FD774 + 4))]	; 037FD778
	lsl r0,r0,#0x10	; 037FD77A
	asr r0,r0,#0x10	; 037FD77C
P2_SwitchTargetPC_037FD774:
	add r0,pc	; 037FD77E
	bx r0	; 037FD780
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD774:
	.halfword (loc_037FD78A + 1) - (P2_SwitchTargetPC_037FD774 + 4)
	.halfword (loc_037FD78E + 1) - (P2_SwitchTargetPC_037FD774 + 4)
	.halfword (loc_037FD792 + 1) - (P2_SwitchTargetPC_037FD774 + 4)
	.halfword (loc_037FD796 + 1) - (P2_SwitchTargetPC_037FD774 + 4)
P2_SwitchTable_037FD774End:
loc_037FD78A:
	ldr r5,[pool_037FD7EC]	; 037FD78A
	b loc_037FD798	; 037FD78C
loc_037FD78E:
	ldr r5,[pool_037FD7F0]	; 037FD78E
	b loc_037FD798	; 037FD790
loc_037FD792:
	ldr r5,[pool_037FD7F4]	; 037FD792
	b loc_037FD798	; 037FD794
loc_037FD796:
	ldr r5,[pool_037FD7EC]	; 037FD796
loc_037FD798:
	ldr r0,[pool_037FD7F8]	; 037FD798
	add r1,r5,r0	; 037FD79A
	ldr r0,[pool_037FD7FC]	; 037FD79C
	strh r1,[r0,#0x0]	; 037FD79E
	lsl r0,r5,#0xf	; 037FD7A0
	lsr r2,r0,#0x10	; 037FD7A2
	ldr r0,[pool_037FD800]	; 037FD7A4
	strh r2,[r0,#0x0]	; 037FD7A6
	ldr r1,[pool_037FD804]	; 037FD7A8
	ldr r0,[pool_037FD808]	; 037FD7AA
	strh r1,[r0,#0x0]	; 037FD7AC
	ldr r0,[pool_037FD80C]	; 037FD7AE
	strh r2,[r0,#0x0]	; 037FD7B0
	strh r2,[r4,#0x4]	; 037FD7B2
	ldr r0,[pool_037FD810]	; 037FD7B4
	strh r0,[r4,#0x0]	; 037FD7B6
	ldr r0,[pool_037FD814]	; 037FD7B8
	sub r0,r0,r5	; 037FD7BA
	add r6,#0x9a	; 037FD7BC
	strh r0,[r6,#0x0]	; 037FD7BE
	ldr r1,[pool_037FD818]	; 037FD7C0
	ldr r0,[pool_037FD81C]	; 037FD7C2
	strh r1,[r0,#0x0]	; 037FD7C4
	ldr r1,[pool_037FD820]	; 037FD7C6
	ldr r0,[pool_037FD7E4]	; 037FD7C8
	strh r1,[r0,#0x0]	; 037FD7CA
	add sp,#0x8	; 037FD7CC
	pop {r4,r5,r6}	; 037FD7CE
	pop {r3}	; 037FD7D0
	bx r3	; 037FD7D2
pool_037FD7D4:
loc_037FD7D4:
	.word FirmwareWlWorkPointerSlot	; 037FD7D4
pool_037FD7D8:
loc_037FD7D8:
	.word 0x00000318	; 037FD7D8
pool_037FD7DC:
loc_037FD7DC:
	.word 0x000004B4	; 037FD7DC
pool_037FD7E0:
loc_037FD7E0:
	.word 0x00008000	; 037FD7E0
pool_037FD7E4:
loc_037FD7E4:
	.word REG_WIFI_RXCNT	; 037FD7E4
pool_037FD7E8:
loc_037FD7E8:
	.word 0x00000324	; 037FD7E8
pool_037FD7EC:
loc_037FD7EC:
	.word 0x00000794	; 037FD7EC
pool_037FD7F0:
loc_037FD7F0:
	.word 0x000010C4	; 037FD7F0
pool_037FD7F4:
loc_037FD7F4:
	.word 0x00000BFC	; 037FD7F4
pool_037FD7F8:
loc_037FD7F8:
	.word WifiRamBase	; 037FD7F8
pool_037FD7FC:
loc_037FD7FC:
	.word REG_WIFI_RXBUF_BEGIN	; 037FD7FC
pool_037FD800:
loc_037FD800:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FD800
pool_037FD804:
loc_037FD804:
	.word 0x00005F60	; 037FD804
pool_037FD808:
loc_037FD808:
	.word REG_WIFI_RXBUF_END	; 037FD808
pool_037FD80C:
loc_037FD80C:
	.word REG_WIFI_RXBUF_READCSR	; 037FD80C
pool_037FD810:
loc_037FD810:
	.word 0x0000FFFF	; 037FD810
pool_037FD814:
loc_037FD814:
	.word 0x00001F60	; 037FD814
pool_037FD818:
loc_037FD818:
	.word 0x00005F5E	; 037FD818
pool_037FD81C:
loc_037FD81C:
	.word REG_WIFI_RXBUF_GAP	; 037FD81C
pool_037FD820:
loc_037FD820:
	.word 0x00008001	; 037FD820

; ===== function loc_037FD824 =====
loc_037FD824:
	bx pc	; 037FD824
	.byte 0xC0, 0x46	; 037FD828
.arm

; ===== function loc_037FD828 =====
loc_037FD828:
	ldr pc,[pool_037FD82C]	; 037FD828
pool_037FD82C:
loc_037FD82C:
	.word loc_037FF3A4	; 037FD82C

; ===== function loc_037FD830 =====
; 取已启用的待处理中断，清除请求并调用对应回调。
; Select an enabled pending IRQ, acknowledge it and call its registered handler.
.func P2_DispatchIrq
	stmdb sp!,{lr}	; 037FD830
	mov r12,#0x4000000	; 037FD834
	add r12,r12,#0x210	; 037FD838
	ldr r1,[r12,#-0x8]	; 037FD83C
	cmp r1,#0x0	; 037FD840
	ldmeqia sp!,{pc}	; 037FD844
	ldmia r12,{r1,r2}	; 037FD848
	ands r1,r1,r2	; 037FD84C
	ldmeqia sp!,{pc}	; 037FD850
	mov r3,#0x1	; 037FD854
	mov r0,#0x0	; 037FD858
loc_037FD85C:
	ands r2,r1,r3, lsl r0	; 037FD85C
	addeq r0,r0,#0x1	; 037FD860
	beq loc_037FD85C	; 037FD864
	str r2,[r12,#0x4]	; 037FD868
	ldr r1,[pool_037FD87C]	; 037FD86C
	ldr r0,[r1,r0,lsl #0x2]	; 037FD870
	ldr lr,[pool_037FD880]	; 037FD874
	bx r0	; 037FD878
.endfunc
pool_037FD87C:
loc_037FD87C:
	.word P2_IrqHandlers	; 037FD87C
pool_037FD880:
loc_037FD880:
	.word P2_IrqReturnContinuation	; 037FD880
; 中断回调返回后处理待执行状态，必要时保存并切换执行上下文。
; After the IRQ callback, process pending state and save/switch context when needed.
.func P2_IrqReturnContinuation
	ldr r12,[pool_037FD998]	; 037FD884
	ldrh r3,[r12,#0x0]	; 037FD888
	mov r0,#0x0	; 037FD88C
	cmp r3,#0x0	; 037FD890
	beq P2_Entry_037FD8CC	; 037FD894
	strh r0,[r12,#0x0]	; 037FD898
	ldr r12,[pool_037FD99C]	; 037FD89C
	mov r1,#0x1	; 037FD8A0
	strh r1,[r12,#0x0]	; 037FD8A4
	ldr r12,[r12,#0xc]	; 037FD8A8
	mov r2,#0x1	; 037FD8AC
P2_Entry_037FD8B0:
	cmp r12,#0x0	; 037FD8B0
	beq P2_Entry_037FD8CC	; 037FD8B4
	ldr r0,[r12,#0x50]	; 037FD8B8
	tst r3,r1, lsl r0	; 037FD8BC
	strne r2,[r12,#0x48]	; 037FD8C0
	ldr r12,[r12,#0x4c]	; 037FD8C4
	b P2_Entry_037FD8B0	; 037FD8C8
P2_Entry_037FD8CC:
	ldr r12,[pool_037FD99C]	; 037FD8CC
	ldrh r1,[r12,#0x0]	; 037FD8D0
	cmp r1,#0x0	; 037FD8D4
	ldreq pc,[sp],#0x4	; 037FD8D8
	mov r1,#0x0	; 037FD8DC
	strh r1,[r12,#0x0]	; 037FD8E0
	mov r3,#0xd2	; 037FD8E4
	msr cpsr_c,r3	; 037FD8E8
	add r2,r12,#0xc	; 037FD8EC
	ldr r1,[r2,#0x0]	; 037FD8F0
P2_Entry_037FD8F4:
	cmp r1,#0x0	; 037FD8F4
	ldrneh r0,[r1,#0x48]	; 037FD8F8
	cmpne r0,#0x1	; 037FD8FC
	ldrne r1,[r1,#0x4c]	; 037FD900
	bne P2_Entry_037FD8F4	; 037FD904
	cmp r1,#0x0	; 037FD908
	bne P2_Entry_037FD91C	; 037FD90C
P2_Entry_037FD910:
	mov r3,#0x92	; 037FD910
	msr cpsr_c,r3	; 037FD914
	ldr pc,[sp],#0x4	; 037FD918
P2_Entry_037FD91C:
	ldr r0,[r12,#0x8]	; 037FD91C
	cmp r1,r0	; 037FD920
	beq P2_Entry_037FD910	; 037FD924
	ldr r3,[r12,#0x10]	; 037FD928
	cmp r3,#0x0	; 037FD92C
	beq P2_Entry_037FD944	; 037FD930
	stmdb sp!,{r0,r1,r12}	; 037FD934
	mov lr,pc	; 037FD938
	bx r3	; 037FD93C
	ldmia sp!,{r0,r1,r12}	; 037FD940
P2_Entry_037FD944:
	str r1,[r12,#0x8]	; 037FD944
	mrs r2,spsr	; 037FD948
	str r2,[r0,#0x0]!	; 037FD94C
	ldmib sp!,{r2,r3}	; 037FD950
	stmib r0!,{r2,r3}	; 037FD954
	ldmib sp!,{r2,r3,r12,lr}	; 037FD958
	stmib r0!,{r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FD95C
	stmib r0!,{lr}	; 037FD960
	mov r3,#0xd3	; 037FD964
	msr cpsr_c,r3	; 037FD968
	stmib r0!,{sp}	; 037FD96C
	ldr sp,[r1,#0x44]	; 037FD970
	mov r3,#0xd2	; 037FD974
	msr cpsr_c,r3	; 037FD978
	ldr r2,[r1,#0x0]!	; 037FD97C
	msr spsr_cf,r2	; 037FD980
	ldr lr,[r1,#0x40]	; 037FD984
	ldmib r1!,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FD988
	mov r0,r0	; 037FD98C
	stmda sp!,{r0,r1,r2,r3,r12,lr}	; 037FD990
	ldmia sp!,{pc}	; 037FD994
.endfunc
pool_037FD998:
	.word P2_BssStart + 0x4CC	; 037FD998
pool_037FD99C:
	.word P2_BssStart + 0x54C	; 037FD99C
.thumb
P2_IrqHandler_037FD9A0:
	push {lr}	; 037FD9A0
	sub sp,#0x4	; 037FD9A2
	ldr r0,[pool_037FD9C8]	; 037FD9A4
	ldr r2,[r0,#0x60]	; 037FD9A6
	ldr r1,[pool_037FD9CC]	; 037FD9A8
	ldr r0,[r1,#0x0]	; 037FD9AA
	add r0,r0,#0x1	; 037FD9AC
	str r0,[r1,#0x0]	; 037FD9AE
	cmp r2,#0x0	; 037FD9B0
	beq P2_Entry_037FD9B8	; 037FD9B2
	bl loc_038050D4	; 037FD9B4
P2_Entry_037FD9B8:
	ldr r2,[pool_037FD9D0]	; 037FD9B8
	ldr r1,[r2,#0x0]	; 037FD9BA
	mov r0,#0x1	; 037FD9BC
	orr r1,r0	; 037FD9BE
	str r1,[r2,#0x0]	; 037FD9C0
	add sp,#0x4	; 037FD9C2
	pop {r3}	; 037FD9C4
	bx r3	; 037FD9C6
pool_037FD9C8:
	.word P2_BssStart + 0x4D0	; 037FD9C8
pool_037FD9CC:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FD9CC
pool_037FD9D0:
	.word Bios7IrqFlagsAddress	; 037FD9D0
.arm
.thumb
P2_IrqHandler_037FD9D4:
	mov r0,#0x7	; 037FD9D4
	ldr r3,[pool_037FD9DC]	; 037FD9D6
	bx r3	; 037FD9D8
	.byte 0xC0, 0x46	; 037FD9DC
pool_037FD9DC:
loc_037FD9DC:
	.word loc_037FDA34 + 1	; 037FD9DC
P2_IrqHandler_037FD9E0:
	mov r0,#0x6	; 037FD9E0
	ldr r3,[pool_037FD9E8]	; 037FD9E2
	bx r3	; 037FD9E4
	.byte 0xC0, 0x46	; 037FD9E8
pool_037FD9E8:
loc_037FD9E8:
	.word loc_037FDA34 + 1	; 037FD9E8
P2_IrqHandler_037FD9EC:
	mov r0,#0x5	; 037FD9EC
	ldr r3,[pool_037FD9F4]	; 037FD9EE
	bx r3	; 037FD9F0
	.byte 0xC0, 0x46	; 037FD9F4
pool_037FD9F4:
loc_037FD9F4:
	.word loc_037FDA34 + 1	; 037FD9F4
P2_IrqHandler_037FD9F8:
	mov r0,#0x4	; 037FD9F8
	ldr r3,[pool_037FDA00]	; 037FD9FA
	bx r3	; 037FD9FC
	.byte 0xC0, 0x46	; 037FDA00
pool_037FDA00:
loc_037FDA00:
	.word loc_037FDA34 + 1	; 037FDA00
P2_IrqHandler_037FDA04:
	mov r0,#0x3	; 037FDA04
	ldr r3,[pool_037FDA0C]	; 037FDA06
	bx r3	; 037FDA08
	.byte 0xC0, 0x46	; 037FDA0C
pool_037FDA0C:
loc_037FDA0C:
	.word loc_037FDA34 + 1	; 037FDA0C
P2_IrqHandler_037FDA10:
	mov r0,#0x2	; 037FDA10
	ldr r3,[pool_037FDA18]	; 037FDA12
	bx r3	; 037FDA14
	.byte 0xC0, 0x46	; 037FDA18
pool_037FDA18:
loc_037FDA18:
	.word loc_037FDA34 + 1	; 037FDA18
P2_IrqHandler_037FDA1C:
	mov r0,#0x1	; 037FDA1C
	ldr r3,[pool_037FDA24]	; 037FDA1E
	bx r3	; 037FDA20
	.byte 0xC0, 0x46	; 037FDA24
pool_037FDA24:
loc_037FDA24:
	.word loc_037FDA34 + 1	; 037FDA24
P2_IrqHandler_037FDA28:
	mov r0,#0x0	; 037FDA28
	ldr r3,[pool_037FDA30]	; 037FDA2A
	bx r3	; 037FDA2C
	.byte 0xC0, 0x46	; 037FDA30
pool_037FDA30:
loc_037FDA30:
	.word loc_037FDA34 + 1	; 037FDA30
loc_037FDA34:
	push {r4,r5,lr}	; 037FDA34
	sub sp,#0x4	; 037FDA36
	mov r5,#0x1	; 037FDA38
	lsl r2,r0,#0x1	; 037FDA3A
	ldr r1,[pool_037FDA7C]	; 037FDA3C
	ldrh r1,[r1,r2]	; 037FDA3E
	lsl r5,r1	; 037FDA40
	mov r1,#0xc	; 037FDA42
	add r4,r0,#0x0	; 037FDA44
	mul r4,r1	; 037FDA46
	ldr r2,[pool_037FDA80]	; 037FDA48
	ldr r1,[r2,r4]	; 037FDA4A
	mov r0,#0x0	; 037FDA4C
	str r0,[r2,r4]	; 037FDA4E
	cmp r1,#0x0	; 037FDA50
	beq loc_037FDA5C	; 037FDA52
	ldr r0,[pool_037FDA84]	; 037FDA54
	ldr r0,[r0,r4]	; 037FDA56
	bl loc_038050D0	; 037FDA58
loc_037FDA5C:
	ldr r1,[pool_037FDA88]	; 037FDA5C
	ldr r0,[r1,#0x0]	; 037FDA5E
	orr r0,r5	; 037FDA60
	str r0,[r1,#0x0]	; 037FDA62
	ldr r0,[pool_037FDA8C]	; 037FDA64
	ldr r0,[r0,r4]	; 037FDA66
	cmp r0,#0x0	; 037FDA68
	bne loc_037FDA72	; 037FDA6A
	add r0,r5,#0x0	; 037FDA6C
	bl loc_037FDAB8	; 037FDA6E
loc_037FDA72:
	add sp,#0x4	; 037FDA72
	pop {r4,r5}	; 037FDA74
	pop {r3}	; 037FDA76
	bx r3	; 037FDA78
	.byte 0xC0, 0x46	; 037FDA7C
pool_037FDA7C:
loc_037FDA7C:
	.word P2_Data_038052A8	; 037FDA7C
pool_037FDA80:
loc_037FDA80:
	.word P2_BssStart + 0x4D0	; 037FDA80
pool_037FDA84:
loc_037FDA84:
	.word P2_BssStart + 0x4D8	; 037FDA84
pool_037FDA88:
loc_037FDA88:
	.word Bios7IrqFlagsAddress	; 037FDA88
pool_037FDA8C:
loc_037FDA8C:
	.word P2_BssStart + 0x4D4	; 037FDA8C
loc_037FDA90:
	bx lr	; 037FDA90
	.byte 0x00, 0x00	; 037FDA94

; ===== function loc_037FDA94 =====
loc_037FDA94:
	push {r4,lr}	; 037FDA94
	ldr r4,[pool_037FDAB0]	; 037FDA96
	ldrh r3,[r4,#0x0]	; 037FDA98
	mov r1,#0x0	; 037FDA9A
	strh r1,[r4,#0x0]	; 037FDA9C
	ldr r2,[pool_037FDAB4]	; 037FDA9E
	ldr r1,[r2,#0x0]	; 037FDAA0
	str r0,[r2,#0x0]	; 037FDAA2
	ldrh r0,[r4,#0x0]	; 037FDAA4
	strh r3,[r4,#0x0]	; 037FDAA6
	add r0,r1,#0x0	; 037FDAA8
	pop {r4}	; 037FDAAA
	pop {r3}	; 037FDAAC
	bx r3	; 037FDAAE
pool_037FDAB0:
loc_037FDAB0:
	.word REG_IME	; 037FDAB0
pool_037FDAB4:
loc_037FDAB4:
	.word REG_IF	; 037FDAB4

; ===== function loc_037FDAB8 =====
loc_037FDAB8:
	push {r4,r5,lr}	; 037FDAB8
	sub sp,#0x4	; 037FDABA
	ldr r5,[pool_037FDADC]	; 037FDABC
	ldrh r4,[r5,#0x0]	; 037FDABE
	mov r1,#0x0	; 037FDAC0
	strh r1,[r5,#0x0]	; 037FDAC2
	ldr r3,[pool_037FDAE0]	; 037FDAC4
	ldr r2,[r3,#0x0]	; 037FDAC6
	add r1,r2,#0x0	; 037FDAC8
	bic r1,r0	; 037FDACA
	str r1,[r3,#0x0]	; 037FDACC
	ldrh r0,[r5,#0x0]	; 037FDACE
	strh r4,[r5,#0x0]	; 037FDAD0
	add r0,r2,#0x0	; 037FDAD2
	add sp,#0x4	; 037FDAD4
	pop {r4,r5}	; 037FDAD6
	pop {r3}	; 037FDAD8
	bx r3	; 037FDADA
pool_037FDADC:
loc_037FDADC:
	.word REG_IME	; 037FDADC
pool_037FDAE0:
loc_037FDAE0:
	.word REG_IE	; 037FDAE0

; ===== function loc_037FDAE4 =====
loc_037FDAE4:
	push {r4,r5,lr}	; 037FDAE4
	sub sp,#0x4	; 037FDAE6
	ldr r5,[pool_037FDB08]	; 037FDAE8
	ldrh r4,[r5,#0x0]	; 037FDAEA
	mov r1,#0x0	; 037FDAEC
	strh r1,[r5,#0x0]	; 037FDAEE
	ldr r3,[pool_037FDB0C]	; 037FDAF0
	ldr r2,[r3,#0x0]	; 037FDAF2
	add r1,r2,#0x0	; 037FDAF4
	orr r1,r0	; 037FDAF6
	str r1,[r3,#0x0]	; 037FDAF8
	ldrh r0,[r5,#0x0]	; 037FDAFA
	strh r4,[r5,#0x0]	; 037FDAFC
	add r0,r2,#0x0	; 037FDAFE
	add sp,#0x4	; 037FDB00
	pop {r4,r5}	; 037FDB02
	pop {r3}	; 037FDB04
	bx r3	; 037FDB06
pool_037FDB08:
loc_037FDB08:
	.word REG_IME	; 037FDB08
pool_037FDB0C:
loc_037FDB0C:
	.word REG_IE	; 037FDB0C

; ===== function loc_037FDB10 =====
loc_037FDB10:
	push {r4,lr}	; 037FDB10
	ldr r4,[pool_037FDB2C]	; 037FDB12
	ldrh r3,[r4,#0x0]	; 037FDB14
	mov r1,#0x0	; 037FDB16
	strh r1,[r4,#0x0]	; 037FDB18
	ldr r2,[pool_037FDB30]	; 037FDB1A
	ldr r1,[r2,#0x0]	; 037FDB1C
	str r0,[r2,#0x0]	; 037FDB1E
	ldrh r0,[r4,#0x0]	; 037FDB20
	strh r3,[r4,#0x0]	; 037FDB22
	add r0,r1,#0x0	; 037FDB24
	pop {r4}	; 037FDB26
	pop {r3}	; 037FDB28
	bx r3	; 037FDB2A
pool_037FDB2C:
loc_037FDB2C:
	.word REG_IME	; 037FDB2C
pool_037FDB30:
loc_037FDB30:
	.word REG_IE	; 037FDB30

; ===== function loc_037FDB34 =====
loc_037FDB34:
	push {r4,lr}	; 037FDB34
	mov r3,#0xc	; 037FDB36
	add r4,r0,#0x0	; 037FDB38
	mul r4,r3	; 037FDB3A
	ldr r3,[pool_037FDB5C]	; 037FDB3C
	str r1,[r3,r4]	; 037FDB3E
	ldr r1,[pool_037FDB60]	; 037FDB40
	str r2,[r1,r4]	; 037FDB42
	mov r1,#0x1	; 037FDB44
	add r0,r0,#0x3	; 037FDB46
	lsl r1,r0	; 037FDB48
	add r0,r1,#0x0	; 037FDB4A
	bl loc_037FDAE4	; 037FDB4C
	mov r1,#0x1	; 037FDB50
	ldr r0,[pool_037FDB64]	; 037FDB52
	str r1,[r0,r4]	; 037FDB54
	pop {r4}	; 037FDB56
	pop {r3}	; 037FDB58
	bx r3	; 037FDB5A
pool_037FDB5C:
loc_037FDB5C:
	.word P2_BssStart + 0x500	; 037FDB5C
pool_037FDB60:
loc_037FDB60:
	.word P2_BssStart + 0x508	; 037FDB60
pool_037FDB64:
loc_037FDB64:
	.word P2_BssStart + 0x504	; 037FDB64

; ===== function loc_037FDB68 =====
loc_037FDB68:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P2_SetIrqHandlers
	push {r4,r5,r6,r7,lr}	; 037FDB68
	sub sp,#0x4	; 037FDB6A
	mov r5,#0x0	; 037FDB6C
	add r3,r5,#0x0	; 037FDB6E
	add r2,r5,#0x0	; 037FDB70
loc_037FDB72:
	add r6,r0,#0x0	; 037FDB72
	mov r4,#0x1	; 037FDB74
	and r6,r4	; 037FDB76
	cmp r6,#0x0	; 037FDB78
	beq loc_037FDBC2	; 037FDB7A
	add r4,r3,#0x0	; 037FDB7C
	cmp r5,#0x8	; 037FDB7E
	blt loc_037FDB94	; 037FDB80
	cmp r5,#0xb	; 037FDB82
	bgt loc_037FDB94	; 037FDB84
	add r6,r5,#0x0	; 037FDB86
	sub r6,#0x8	; 037FDB88
	mov r4,#0xc	; 037FDB8A
	mul r6,r4	; 037FDB8C
	ldr r4,[pool_037FDBD4]	; 037FDB8E
	add r4,r4,r6	; 037FDB90
	b loc_037FDBB6	; 037FDB92
loc_037FDB94:
	cmp r5,#0x3	; 037FDB94
	blt loc_037FDBA8	; 037FDB96
	cmp r5,#0x6	; 037FDB98
	bgt loc_037FDBA8	; 037FDB9A
	add r6,r5,#0x1	; 037FDB9C
	mov r4,#0xc	; 037FDB9E
	mul r6,r4	; 037FDBA0
	ldr r4,[pool_037FDBD4]	; 037FDBA2
	add r4,r4,r6	; 037FDBA4
	b loc_037FDBB6	; 037FDBA6
loc_037FDBA8:
	cmp r5,#0x0	; 037FDBA8
	bne loc_037FDBB0	; 037FDBAA
	ldr r4,[pool_037FDBD8]	; 037FDBAC
	b loc_037FDBB6	; 037FDBAE
loc_037FDBB0:
	lsl r7,r5,#0x2	; 037FDBB0
	ldr r6,[pool_037FDBDC]	; 037FDBB2
	str r1,[r6,r7]	; 037FDBB4
loc_037FDBB6:
	cmp r4,#0x0	; 037FDBB6
	beq loc_037FDBC2	; 037FDBB8
	str r1,[r4,#0x0]	; 037FDBBA
	str r2,[r4,#0x8]	; 037FDBBC
	mov r6,#0x1	; 037FDBBE
	str r6,[r4,#0x4]	; 037FDBC0
loc_037FDBC2:
	lsr r0,r0,#0x1	; 037FDBC2
	add r5,r5,#0x1	; 037FDBC4
	cmp r5,#0x19	; 037FDBC6
	blt loc_037FDB72	; 037FDBC8
	add sp,#0x4	; 037FDBCA
	pop {r4,r5,r6,r7}	; 037FDBCC
	pop {r3}	; 037FDBCE
	bx r3	; 037FDBD0
.endfunc
	.byte 0xC0, 0x46	; 037FDBD4
pool_037FDBD4:
loc_037FDBD4:
	.word 0x038058B0	; 037FDBD4
pool_037FDBD8:
loc_037FDBD8:
	.word 0x03805910	; 037FDBD8
pool_037FDBDC:
loc_037FDBDC:
	.word P2_IrqHandlers	; 037FDBDC

; ===== function loc_037FDBE0 =====
loc_037FDBE0:
	mov r1,#0x0	; 037FDBE0
	ldr r0,[pool_037FDBEC]	; 037FDBE2
	strh r1,[r0,#0x0]	; 037FDBE4
	ldr r0,[pool_037FDBF0]	; 037FDBE6
	str r1,[r0,#0x0]	; 037FDBE8
	bx lr	; 037FDBEA
pool_037FDBEC:
loc_037FDBEC:
	.word P2_BssStart + 0x4CC	; 037FDBEC
pool_037FDBF0:
loc_037FDBF0:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FDBF0

; ===== function loc_037FDBF4 =====
loc_037FDBF4:
	ldr r1,[pool_037FDBF8]	; 037FDBF4
	bx r1	; 037FDBF6
pool_037FDBF8:
loc_037FDBF8:
	.word loc_037FDCAC + 1	; 037FDBF8
.arm

; ===== function loc_037FDBFC =====
loc_037FDBFC:
	ldr r3,[pool_037FDC8C]	; 037FDBFC
	ldr r1,[r3,#0x0]	; 037FDC00
	mov r2,#0x0	; 037FDC04
	mov r0,#0x80000000	; 037FDC08
loc_037FDC0C:
	tst r1,r0	; 037FDC0C
	bne loc_037FDC28	; 037FDC10
	add r2,r2,#0x1	; 037FDC14
	cmp r2,#0x20	; 037FDC18
	beq loc_037FDC28	; 037FDC1C
	mov r0,r0, lsr #0x1	; 037FDC20
	b loc_037FDC0C	; 037FDC24
loc_037FDC28:
	cmp r2,#0x20	; 037FDC28
	movne r0,#0x80	; 037FDC2C
	bne loc_037FDC70	; 037FDC30
	add r3,r3,#0x4	; 037FDC34
	ldr r1,[r3,#0x0]	; 037FDC38
	mov r2,#0x0	; 037FDC3C
	mov r0,#0x80000000	; 037FDC40
loc_037FDC44:
	tst r1,r0	; 037FDC44
	bne loc_037FDC60	; 037FDC48
	add r2,r2,#0x1	; 037FDC4C
	cmp r2,#0x20	; 037FDC50
	beq loc_037FDC60	; 037FDC54
	mov r0,r0, lsr #0x1	; 037FDC58
	b loc_037FDC44	; 037FDC5C
loc_037FDC60:
	cmp r2,#0x20	; 037FDC60
	ldr r0,[pool_037FDC90]	; 037FDC64
	bxeq lr	; 037FDC68
	mov r0,#0xa0	; 037FDC6C
loc_037FDC70:
	add r0,r0,r2	; 037FDC70
	mov r1,#0x80000000	; 037FDC74
	mov r1,r1, lsr r2	; 037FDC78
	ldr r2,[r3,#0x0]	; 037FDC7C
	bic r2,r2,r1	; 037FDC80
	str r2,[r3,#0x0]	; 037FDC84
	bx lr	; 037FDC88
pool_037FDC8C:
loc_037FDC8C:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FDC8C
pool_037FDC90:
loc_037FDC90:
	.word 0xFFFFFFFD	; 037FDC90
.thumb

; ===== function loc_037FDC94 =====
loc_037FDC94:
	ldr r0,[pool_037FDC9C]	; 037FDC94
	ldr r3,[pool_037FDCA0]	; 037FDC96
	bx r3	; 037FDC98
	.byte 0xC0, 0x46	; 037FDC9C
pool_037FDC9C:
loc_037FDC9C:
	.word 0x00001000	; 037FDC9C
pool_037FDCA0:
loc_037FDCA0:
	.word loc_037FF21C + 1	; 037FDCA0
	.byte 0x70, 0x47, 0x00, 0x00, 0x70, 0x47, 0x00, 0x00	; 037FDCAC

; ===== function loc_037FDCAC =====
loc_037FDCAC:
	ldr r1,[pool_037FDCB4]	; 037FDCAC
	ldr r2,[pool_037FDCB8]	; 037FDCAE
	ldr r3,[pool_037FDCBC]	; 037FDCB0
	bx r3	; 037FDCB2
pool_037FDCB4:
loc_037FDCB4:
	.word 0x027FFFE0	; 037FDCB4
pool_037FDCB8:
loc_037FDCB8:
	.word 0x037FDCA5	; 037FDCB8
pool_037FDCBC:
loc_037FDCBC:
	.word loc_037FDD74 + 1	; 037FDCBC

; ===== function loc_037FDCC0 =====
loc_037FDCC0:
	ldr r1,[pool_037FDCC8]	; 037FDCC0
	ldr r2,[pool_037FDCCC]	; 037FDCC2
	ldr r3,[pool_037FDCD0]	; 037FDCC4
	bx r3	; 037FDCC6
pool_037FDCC8:
loc_037FDCC8:
	.word 0x027FFFE0	; 037FDCC8
pool_037FDCCC:
loc_037FDCCC:
	.word 0x037FDCA9	; 037FDCCC
pool_037FDCD0:
loc_037FDCD0:
	.word loc_037FDDD8 + 1	; 037FDCD0

; ===== function loc_037FDCD4 =====
loc_037FDCD4:
	push {r4,r5,r6,r7,lr}	; 037FDCD4
	sub sp,#0xc	; 037FDCD6
	add r5,r0,#0x0	; 037FDCD8
	add r6,r1,#0x0	; 037FDCDA
	add r4,r2,#0x0	; 037FDCDC
	add r7,r3,#0x0	; 037FDCDE
	cmp r7,#0x0	; 037FDCE0
	beq loc_037FDCEC	; 037FDCE2
	bl loc_037FDD28	; 037FDCE4
	str r0,[sp,#0x0]	; 037FDCE8
	b loc_037FDCF2	; 037FDCEA
loc_037FDCEC:
	bl loc_037FDD34	; 037FDCEC
	str r0,[sp,#0x0]	; 037FDCF0
loc_037FDCF2:
	add r0,r5,#0x0	; 037FDCF2
	add r1,r6,#0x0	; 037FDCF4
	bl loc_037FDD40	; 037FDCF6
	str r0,[sp,#0x4]	; 037FDCFA
	cmp r0,#0x0	; 037FDCFC
	bne loc_037FDD0A	; 037FDCFE
	cmp r4,#0x0	; 037FDD00
	beq loc_037FDD08	; 037FDD02
	bl loc_038050DC	; 037FDD04
loc_037FDD08:
	strh r5,[r6,#0x4]	; 037FDD08
loc_037FDD0A:
	cmp r7,#0x0	; 037FDD0A
	beq loc_037FDD16	; 037FDD0C
	ldr r0,[sp,#0x0]	; 037FDD0E
	bl loc_037FDD4C	; 037FDD10
	b loc_037FDD1C	; 037FDD14
loc_037FDD16:
	ldr r0,[sp,#0x0]	; 037FDD16
	bl loc_037FDD58	; 037FDD18
loc_037FDD1C:
	ldr r0,[sp,#0x4]	; 037FDD1C
	add sp,#0xc	; 037FDD1E
	pop {r4,r5,r6,r7}	; 037FDD20
	pop {r3}	; 037FDD22
	bx r3	; 037FDD24
	.byte 0xC0, 0x46	; 037FDD28

; ===== function loc_037FDD28 =====
loc_037FDD28:
	bx pc	; 037FDD28
	.byte 0xC0, 0x46	; 037FDD2C
.arm

; ===== function loc_037FDD2C =====
loc_037FDD2C:
	ldr pc,[pool_037FDD30]	; 037FDD2C
pool_037FDD30:
loc_037FDD30:
	.word loc_037FF184	; 037FDD30
.thumb

; ===== function loc_037FDD34 =====
loc_037FDD34:
	bx pc	; 037FDD34
	.byte 0xC0, 0x46	; 037FDD38
.arm

; ===== function loc_037FDD38 =====
loc_037FDD38:
	ldr pc,[pool_037FDD3C]	; 037FDD38
pool_037FDD3C:
loc_037FDD3C:
	.word loc_037FF158	; 037FDD3C
.thumb

; ===== function loc_037FDD40 =====
loc_037FDD40:
	bx pc	; 037FDD40
	.byte 0xC0, 0x46	; 037FDD44
.arm

; ===== function loc_037FDD44 =====
loc_037FDD44:
	ldr pc,[pool_037FDD48]	; 037FDD44
pool_037FDD48:
loc_037FDD48:
	.word loc_037FF450	; 037FDD48
.thumb

; ===== function loc_037FDD4C =====
loc_037FDD4C:
	bx pc	; 037FDD4C
	.byte 0xC0, 0x46	; 037FDD50
.arm

; ===== function loc_037FDD50 =====
loc_037FDD50:
	ldr pc,[pool_037FDD54]	; 037FDD50
pool_037FDD54:
loc_037FDD54:
	.word loc_037FF198	; 037FDD54
.thumb

; ===== function loc_037FDD58 =====
loc_037FDD58:
	bx pc	; 037FDD58
	.byte 0xC0, 0x46	; 037FDD5C
.arm

; ===== function loc_037FDD5C =====
loc_037FDD5C:
	ldr pc,[pool_037FDD60]	; 037FDD5C
pool_037FDD60:
loc_037FDD60:
	.word loc_037FF16C	; 037FDD60
.thumb

; ===== function loc_037FDD64 =====
loc_037FDD64:
	push {lr}	; 037FDD64
	sub sp,#0x4	; 037FDD66
	mov r3,#0x0	; 037FDD68
	bl loc_037FDD84	; 037FDD6A
	add sp,#0x4	; 037FDD6E
	pop {r3}	; 037FDD70
	bx r3	; 037FDD72
loc_037FDD74:
	push {lr}	; 037FDD74
	sub sp,#0x4	; 037FDD76
	mov r3,#0x0	; 037FDD78
	bl loc_037FDD84	; 037FDD7A
	add sp,#0x4	; 037FDD7E
	pop {r3}	; 037FDD80
	bx r3	; 037FDD82

; ===== function loc_037FDD84 =====
loc_037FDD84:
	push {r4,r5,r6,r7,lr}	; 037FDD84
	sub sp,#0x4	; 037FDD86
	add r5,r1,#0x0	; 037FDD88
	add r4,r2,#0x0	; 037FDD8A
	add r6,r3,#0x0	; 037FDD8C
	ldrh r1,[r5,#0x4]	; 037FDD8E
	cmp r0,r1	; 037FDD90
	beq loc_037FDD9A	; 037FDD92
	mov r0,#0x1	; 037FDD94
	mvn r0,r0	; 037FDD96
	b loc_037FDDD0	; 037FDD98
loc_037FDD9A:
	cmp r6,#0x0	; 037FDD9A
	beq loc_037FDDA6	; 037FDD9C
	bl loc_037FDD28	; 037FDD9E
	add r7,r0,#0x0	; 037FDDA2
	b loc_037FDDAC	; 037FDDA4
loc_037FDDA6:
	bl loc_037FDD34	; 037FDDA6
	add r7,r0,#0x0	; 037FDDAA
loc_037FDDAC:
	mov r0,#0x0	; 037FDDAC
	strh r0,[r5,#0x4]	; 037FDDAE
	cmp r4,#0x0	; 037FDDB0
	beq loc_037FDDB8	; 037FDDB2
	bl loc_038050DC	; 037FDDB4
loc_037FDDB8:
	mov r0,#0x0	; 037FDDB8
	str r0,[r5,#0x0]	; 037FDDBA
	cmp r6,#0x0	; 037FDDBC
	beq loc_037FDDC8	; 037FDDBE
	add r0,r7,#0x0	; 037FDDC0
	bl loc_037FDD4C	; 037FDDC2
	b loc_037FDDCE	; 037FDDC6
loc_037FDDC8:
	add r0,r7,#0x0	; 037FDDC8
	bl loc_037FDD58	; 037FDDCA
loc_037FDDCE:
	mov r0,#0x0	; 037FDDCE
loc_037FDDD0:
	add sp,#0x4	; 037FDDD0
	pop {r4,r5,r6,r7}	; 037FDDD2
	pop {r3}	; 037FDDD4
	bx r3	; 037FDDD6

; ===== function loc_037FDDD8 =====
loc_037FDDD8:
	push {lr}	; 037FDDD8
	sub sp,#0x4	; 037FDDDA
	mov r3,#0x0	; 037FDDDC
	bl loc_037FDDE8	; 037FDDDE
	add sp,#0x4	; 037FDDE2
	pop {r3}	; 037FDDE4
	bx r3	; 037FDDE6

; ===== function loc_037FDDE8 =====
loc_037FDDE8:
	push {r4,r5,r6,r7,lr}	; 037FDDE8
	sub sp,#0x4	; 037FDDEA
	add r5,r0,#0x0	; 037FDDEC
	add r4,r1,#0x0	; 037FDDEE
	add r6,r2,#0x0	; 037FDDF0
	add r7,r3,#0x0	; 037FDDF2
	b loc_037FDDFA	; 037FDDF4
loc_037FDDF6:
	bl loc_037FDC94	; 037FDDF6
loc_037FDDFA:
	add r0,r5,#0x0	; 037FDDFA
	add r1,r4,#0x0	; 037FDDFC
	add r2,r6,#0x0	; 037FDDFE
	add r3,r7,#0x0	; 037FDE00
	bl loc_037FDCD4	; 037FDE02
	cmp r0,#0x0	; 037FDE06
	bgt loc_037FDDF6	; 037FDE08
	add sp,#0x4	; 037FDE0A
	pop {r4,r5,r6,r7}	; 037FDE0C
	pop {r3}	; 037FDE0E
	bx r3	; 037FDE10
	.byte 0x00, 0x00	; 037FDE14

; ===== function loc_037FDE14 =====
loc_037FDE14:
	push {r4,lr}	; 037FDE14
	ldr r0,[pool_037FDE4C]	; 037FDE16
	ldr r1,[r0,#0x0]	; 037FDE18
	cmp r1,#0x0	; 037FDE1A
	bne loc_037FDE46	; 037FDE1C
	mov r1,#0x1	; 037FDE1E
	str r1,[r0,#0x0]	; 037FDE20
	mov r0,#0x0	; 037FDE22
	ldr r4,[pool_037FDE50]	; 037FDE24
	strh r0,[r4,#0x6]	; 037FDE26
	b loc_037FDE2E	; 037FDE28
loc_037FDE2A:
	bl loc_037FDC94	; 037FDE2A
loc_037FDE2E:
	ldrh r0,[r4,#0x4]	; 037FDE2E
	cmp r0,#0x7f	; 037FDE30
	bne loc_037FDE2A	; 037FDE32
	mov r0,#0x0	; 037FDE34
	mvn r1,r0	; 037FDE36
	ldr r0,[pool_037FDE54]	; 037FDE38
	str r1,[r0,#0x0]	; 037FDE3A
	ldr r1,[pool_037FDE58]	; 037FDE3C
	ldr r0,[pool_037FDE5C]	; 037FDE3E
	str r1,[r0,#0x0]	; 037FDE40
	mov r0,#0xbf	; 037FDE42
	strh r0,[r4,#0x6]	; 037FDE44
loc_037FDE46:
	pop {r4}	; 037FDE46
	pop {r3}	; 037FDE48
	bx r3	; 037FDE4A
pool_037FDE4C:
loc_037FDE4C:
	.word P2_BssStart + 0x53C	; 037FDE4C
pool_037FDE50:
loc_037FDE50:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 037FDE50
pool_037FDE54:
loc_037FDE54:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FDE54
pool_037FDE58:
loc_037FDE58:
	.word 0xFFFF0000	; 037FDE58
pool_037FDE5C:
loc_037FDE5C:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset + 0x4	; 037FDE5C
	.byte 0x70, 0x47, 0x00, 0x00	; 037FDE64

; ===== function loc_037FDE64 =====
loc_037FDE64:
	push {r4,r5,lr}	; 037FDE64
	sub sp,#0x4	; 037FDE66
	add r5,r0,#0x0	; 037FDE68
	bl loc_037FDD34	; 037FDE6A
	ldr r1,[pool_037FDE84]	; 037FDE6E
	ldr r4,[r1,#0x10]	; 037FDE70
	str r5,[r1,#0x10]	; 037FDE72
	bl loc_037FDD58	; 037FDE74
	add r0,r4,#0x0	; 037FDE78
	add sp,#0x4	; 037FDE7A
	pop {r4,r5}	; 037FDE7C
	pop {r3}	; 037FDE7E
	bx r3	; 037FDE80
	.byte 0xC0, 0x46	; 037FDE84
pool_037FDE84:
loc_037FDE84:
	.word P2_BssStart + 0x54C	; 037FDE84

; ===== function loc_037FDE88 =====
loc_037FDE88:
	push {r4,r5,r6,lr}	; 037FDE88
	ldr r6,[pool_037FDEEC]	; 037FDE8A
	ldrh r0,[r6,#0x4]	; 037FDE8C
	cmp r0,#0x0	; 037FDE8E
	bne loc_037FDE9A	; 037FDE90
	bl loc_037FDEF8	; 037FDE92
	cmp r0,#0x12	; 037FDE96
	bne loc_037FDEA0	; 037FDE98
loc_037FDE9A:
	mov r0,#0x1	; 037FDE9A
	strh r0,[r6,#0x0]	; 037FDE9C
	b loc_037FDEE6	; 037FDE9E
loc_037FDEA0:
	ldr r0,[pool_037FDEF0]	; 037FDEA0
	ldr r0,[r0,#0x0]	; 037FDEA2
	ldr r5,[r0,#0x0]	; 037FDEA4
	bl loc_037FDF1C	; 037FDEA6
	add r4,r0,#0x0	; 037FDEAA
	cmp r5,r4	; 037FDEAC
	beq loc_037FDEE6	; 037FDEAE
	cmp r4,#0x0	; 037FDEB0
	beq loc_037FDEE6	; 037FDEB2
	add r0,r5,#0x0	; 037FDEB4
	bl loc_037FDF04	; 037FDEB6
	cmp r0,#0x0	; 037FDEBA
	bne loc_037FDEE6	; 037FDEBC
	ldr r0,[pool_037FDEF4]	; 037FDEBE
	ldr r2,[r0,#0x0]	; 037FDEC0
	cmp r2,#0x0	; 037FDEC2
	beq loc_037FDECE	; 037FDEC4
	add r0,r5,#0x0	; 037FDEC6
	add r1,r4,#0x0	; 037FDEC8
	bl loc_038050D4	; 037FDECA
loc_037FDECE:
	ldr r2,[r6,#0x10]	; 037FDECE
	cmp r2,#0x0	; 037FDED0
	beq loc_037FDEDC	; 037FDED2
	add r0,r5,#0x0	; 037FDED4
	add r1,r4,#0x0	; 037FDED6
	bl loc_038050D4	; 037FDED8
loc_037FDEDC:
	ldr r0,[pool_037FDEEC]	; 037FDEDC
	str r4,[r0,#0x8]	; 037FDEDE
	add r0,r4,#0x0	; 037FDEE0
	bl loc_037FDF10	; 037FDEE2
loc_037FDEE6:
	pop {r4,r5,r6}	; 037FDEE6
	pop {r3}	; 037FDEE8
	bx r3	; 037FDEEA
pool_037FDEEC:
loc_037FDEEC:
	.word P2_BssStart + 0x54C	; 037FDEEC
pool_037FDEF0:
loc_037FDEF0:
	.word P2_BssStart + 0x544	; 037FDEF0
pool_037FDEF4:
loc_037FDEF4:
	.word P2_BssStart + 0x540	; 037FDEF4

; ===== function loc_037FDEF8 =====
loc_037FDEF8:
	bx pc	; 037FDEF8
	.byte 0xC0, 0x46	; 037FDEFC
.arm

; ===== function loc_037FDEFC =====
loc_037FDEFC:
	ldr pc,[pool_037FDF00]	; 037FDEFC
pool_037FDF00:
loc_037FDF00:
	.word loc_037FF1B0	; 037FDF00
.thumb

; ===== function loc_037FDF04 =====
loc_037FDF04:
	bx pc	; 037FDF04
	.byte 0xC0, 0x46	; 037FDF08
.arm

; ===== function loc_037FDF08 =====
loc_037FDF08:
	ldr pc,[pool_037FDF0C]	; 037FDF08
pool_037FDF0C:
loc_037FDF0C:
	.word P2_SaveThreadContext	; 037FDF0C
.thumb

; ===== function loc_037FDF10 =====
loc_037FDF10:
	bx pc	; 037FDF10
	.byte 0xC0, 0x46	; 037FDF14
.arm

; ===== function loc_037FDF14 =====
loc_037FDF14:
	ldr pc,[pool_037FDF18]	; 037FDF14
pool_037FDF18:
loc_037FDF18:
	.word P2_LoadThreadContext	; 037FDF18
.thumb

; ===== function loc_037FDF1C =====
loc_037FDF1C:
	ldr r0,[pool_037FDF30]	; 037FDF1C
	ldr r0,[r0,#0xc]	; 037FDF1E
	b loc_037FDF24	; 037FDF20
loc_037FDF22:
	ldr r0,[r0,#0x4c]	; 037FDF22
loc_037FDF24:
	cmp r0,#0x0	; 037FDF24
	beq loc_037FDF2E	; 037FDF26
	ldr r1,[r0,#0x48]	; 037FDF28
	cmp r1,#0x1	; 037FDF2A
	bne loc_037FDF22	; 037FDF2C
loc_037FDF2E:
	bx lr	; 037FDF2E
pool_037FDF30:
loc_037FDF30:
	.word P2_BssStart + 0x54C	; 037FDF30

; ===== function loc_037FDF34 =====
loc_037FDF34:
	push {r4,r5,lr}	; 037FDF34
	sub sp,#0x4	; 037FDF36
	add r5,r0,#0x0	; 037FDF38
	bl loc_037FDD34	; 037FDF3A
	add r4,r0,#0x0	; 037FDF3E
	mov r0,#0x1	; 037FDF40
	str r0,[r5,#0x48]	; 037FDF42
	bl loc_037FDE88	; 037FDF44
	add r0,r4,#0x0	; 037FDF48
	bl loc_037FDD58	; 037FDF4A
	add sp,#0x4	; 037FDF4E
	pop {r4,r5}	; 037FDF50
	pop {r3}	; 037FDF52
	bx r3	; 037FDF54
	.byte 0x00, 0x00	; 037FDF58

; ===== function loc_037FDF58 =====
loc_037FDF58:
	push {r4,r5,r6,lr}	; 037FDF58
	add r5,r0,#0x0	; 037FDF5A
	bl loc_037FDD34	; 037FDF5C
	add r4,r0,#0x0	; 037FDF60
	ldrh r1,[r5,#0x0]	; 037FDF62
	cmp r1,#0x0	; 037FDF64
	beq loc_037FDF8E	; 037FDF66
	ldr r0,[pool_037FDF9C]	; 037FDF68
	ldr r0,[r0,#0xc]	; 037FDF6A
	mov r3,#0x1	; 037FDF6C
	b loc_037FDF82	; 037FDF6E
loc_037FDF70:
	ldr r2,[r0,#0x50]	; 037FDF70
	add r6,r3,#0x0	; 037FDF72
	lsl r6,r2	; 037FDF74
	add r2,r1,#0x0	; 037FDF76
	and r2,r6	; 037FDF78
	cmp r2,#0x0	; 037FDF7A
	beq loc_037FDF80	; 037FDF7C
	str r3,[r0,#0x48]	; 037FDF7E
loc_037FDF80:
	ldr r0,[r0,#0x4c]	; 037FDF80
loc_037FDF82:
	cmp r0,#0x0	; 037FDF82
	bne loc_037FDF70	; 037FDF84
	mov r0,#0x0	; 037FDF86
	strh r0,[r5,#0x0]	; 037FDF88
	bl loc_037FDE88	; 037FDF8A
loc_037FDF8E:
	add r0,r4,#0x0	; 037FDF8E
	bl loc_037FDD58	; 037FDF90
	pop {r4,r5,r6}	; 037FDF94
	pop {r3}	; 037FDF96
	bx r3	; 037FDF98
	.byte 0xC0, 0x46	; 037FDF9C
pool_037FDF9C:
loc_037FDF9C:
	.word P2_BssStart + 0x54C	; 037FDF9C

; ===== function loc_037FDFA0 =====
loc_037FDFA0:
	push {r4,r5,lr}	; 037FDFA0
	sub sp,#0x4	; 037FDFA2
	add r5,r0,#0x0	; 037FDFA4
	bl loc_037FDD34	; 037FDFA6
	add r4,r0,#0x0	; 037FDFAA
	ldr r0,[pool_037FDFDC]	; 037FDFAC
	ldr r0,[r0,#0x0]	; 037FDFAE
	ldr r1,[r0,#0x0]	; 037FDFB0
	cmp r5,#0x0	; 037FDFB2
	beq loc_037FDFC6	; 037FDFB4
	ldrh r0,[r5,#0x0]	; 037FDFB6
	mov r3,#0x1	; 037FDFB8
	ldr r2,[r1,#0x50]	; 037FDFBA
	lsl r3,r2	; 037FDFBC
	lsl r2,r3,#0x10	; 037FDFBE
	lsr r2,r2,#0x10	; 037FDFC0
	orr r0,r2	; 037FDFC2
	strh r0,[r5,#0x0]	; 037FDFC4
loc_037FDFC6:
	mov r0,#0x0	; 037FDFC6
	str r0,[r1,#0x48]	; 037FDFC8
	bl loc_037FDE88	; 037FDFCA
	add r0,r4,#0x0	; 037FDFCE
	bl loc_037FDD58	; 037FDFD0
	add sp,#0x4	; 037FDFD4
	pop {r4,r5}	; 037FDFD6
	pop {r3}	; 037FDFD8
	bx r3	; 037FDFDA
pool_037FDFDC:
loc_037FDFDC:
	.word P2_BssStart + 0x544	; 037FDFDC
P2_Entry_037FDFE0:
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P2_ExitThread
	push {r4,lr}	; 037FDFE0
	bl loc_037FDD34	; 037FDFE2
	ldr r0,[pool_037FE018]	; 037FDFE6
	ldr r0,[r0,#0x0]	; 037FDFE8
	ldr r4,[r0,#0x0]	; 037FDFEA
	add r0,r4,#0x0	; 037FDFEC
	bl loc_037FE40C	; 037FDFEE
	add r0,r4,#0x0	; 037FDFF2
	bl loc_037FE190	; 037FDFF4
	mov r2,#0x0	; 037FDFF8
	ldr r0,[r4,#0x50]	; 037FDFFA
	lsl r1,r0,#0x2	; 037FDFFC
	ldr r0,[pool_037FE01C]	; 037FDFFE
	str r2,[r0,r1]	; 037FE000
	mov r0,#0x2	; 037FE002
	str r0,[r4,#0x48]	; 037FE004
	add r4,#0x74	; 037FE006
	add r0,r4,#0x0	; 037FE008
	bl loc_037FDF58	; 037FE00A
	bl loc_037FDE88	; 037FE00E
	pop {r4}	; 037FE012
	pop {r3}	; 037FE014
	bx r3	; 037FE016
.endfunc
pool_037FE018:
loc_037FE018:
	.word P2_BssStart + 0x544	; 037FE018
pool_037FE01C:
loc_037FE01C:
	.word P2_BssStart + 0x560	; 037FE01C

; ===== function loc_037FE020 =====
loc_037FE020:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P2_CreateThread
	push {r4,r5,r6,r7,lr}	; 037FE020
	sub sp,#0xc	; 037FE022
	add r5,r0,#0x0	; 037FE024
	str r1,[sp,#0x0]	; 037FE026
	add r7,r2,#0x0	; 037FE028
	add r4,r3,#0x0	; 037FE02A
	bl loc_037FDD34	; 037FE02C
	str r0,[sp,#0x4]	; 037FE030
	bl loc_037FE1F8	; 037FE032
	cmp r0,#0x0	; 037FE036
	bge loc_037FE042	; 037FE038
	ldr r0,[sp,#0x4]	; 037FE03A
	bl loc_037FDD58	; 037FE03C
	b loc_037FE0A0	; 037FE040
loc_037FE042:
	ldr r1,[sp,#0x24]	; 037FE042
	str r1,[r5,#0x54]	; 037FE044
	str r0,[r5,#0x50]	; 037FE046
	mov r1,#0x0	; 037FE048
	str r1,[r5,#0x48]	; 037FE04A
	lsl r1,r0,#0x2	; 037FE04C
	ldr r0,[pool_037FE0A8]	; 037FE04E
	str r5,[r0,r1]	; 037FE050
	add r0,r5,#0x0	; 037FE052
	bl loc_037FE1BC	; 037FE054
	str r4,[r5,#0x6c]	; 037FE058
	ldr r0,[sp,#0x20]	; 037FE05A
	sub r6,r4,r0	; 037FE05C
	str r6,[r5,#0x68]	; 037FE05E
	mov r0,#0x0	; 037FE060
	str r0,[r5,#0x70]	; 037FE062
	ldr r1,[pool_037FE0AC]	; 037FE064
	ldr r0,[r5,#0x6c]	; 037FE066
	sub r0,r0,#0x4	; 037FE068
	str r1,[r0,#0x0]	; 037FE06A
	ldr r1,[pool_037FE0B0]	; 037FE06C
	ldr r0,[r5,#0x68]	; 037FE06E
	str r1,[r0,#0x0]	; 037FE070
	add r0,r5,#0x0	; 037FE072
	ldr r1,[sp,#0x0]	; 037FE074
	sub r2,r4,#0x4	; 037FE076
	bl loc_037FE0B8	; 037FE078
	str r7,[r5,#ThreadContextR0Offset]	; 037FE07C
	ldr r0,[pool_037FE0B4]	; 037FE07E
	str r0,[r5,#ThreadContextLrOffset]	; 037FE080
	mov r0,#0x0	; 037FE082
	str r0,[sp,#0x8]	; 037FE084
	ldr r0,[sp,#0x8]	; 037FE086
	add r1,r6,#0x4	; 037FE088
	ldr r2,[sp,#0x20]	; 037FE08A
	sub r2,#0x8	; 037FE08C
	bl loc_037FE0C4	; 037FE08E
	mov r0,#0x0	; 037FE092
	str r0,[r5,#0x5c]	; 037FE094
	str r0,[r5,#0x60]	; 037FE096
	str r0,[r5,#0x64]	; 037FE098
	ldr r0,[sp,#0x4]	; 037FE09A
	bl loc_037FDD58	; 037FE09C
loc_037FE0A0:
	add sp,#0xc	; 037FE0A0
	pop {r4,r5,r6,r7}	; 037FE0A2
	pop {r3}	; 037FE0A4
	bx r3	; 037FE0A6
.endfunc
pool_037FE0A8:
loc_037FE0A8:
	.word P2_BssStart + 0x560	; 037FE0A8
pool_037FE0AC:
loc_037FE0AC:
	.word 0xD73BFDF7	; 037FE0AC
pool_037FE0B0:
loc_037FE0B0:
	.word 0xFBDD37BB	; 037FE0B0
pool_037FE0B4:
loc_037FE0B4:
	.word P2_ExitThread + 1	; 037FE0B4

; ===== function loc_037FE0B8 =====
loc_037FE0B8:
	bx pc	; 037FE0B8
	.byte 0xC0, 0x46	; 037FE0BC
.arm

; ===== function loc_037FE0BC =====
loc_037FE0BC:
	ldr pc,[pool_037FE0C0]	; 037FE0BC
pool_037FE0C0:
loc_037FE0C0:
	.word P2_InitThreadContext	; 037FE0C0
.thumb

; ===== function loc_037FE0C4 =====
loc_037FE0C4:
	bx pc	; 037FE0C4
	.byte 0xC0, 0x46	; 037FE0C8
.arm

; ===== function loc_037FE0C8 =====
loc_037FE0C8:
	ldr pc,[pool_037FE0CC]	; 037FE0C8
pool_037FE0CC:
loc_037FE0CC:
	.word loc_037FF3A4	; 037FE0CC
.thumb

; ===== function loc_037FE0D0 =====
loc_037FE0D0:
	push {lr}	; 037FE0D0
	sub sp,#0x4	; 037FE0D2
	ldr r0,[pool_037FE15C]	; 037FE0D4
	ldr r1,[r0,#0x0]	; 037FE0D6
	cmp r1,#0x0	; 037FE0D8
	bne loc_037FE154	; 037FE0DA
	mov r1,#0x1	; 037FE0DC
	str r1,[r0,#0x0]	; 037FE0DE
	mov r3,#0x0	; 037FE0E0
	add r1,r3,#0x0	; 037FE0E2
	ldr r0,[pool_037FE160]	; 037FE0E4
loc_037FE0E6:
	lsl r2,r3,#0x2	; 037FE0E6
	add r2,r0,r2	; 037FE0E8
	str r1,[r2,#0x14]	; 037FE0EA
	add r3,r3,#0x1	; 037FE0EC
	cmp r3,#0x10	; 037FE0EE
	blt loc_037FE0E6	; 037FE0F0
	ldr r3,[pool_037FE164]	; 037FE0F2
	ldr r2,[pool_037FE168]	; 037FE0F4
	str r3,[r2,#0x0]	; 037FE0F6
	mov r3,#0x10	; 037FE0F8
	ldr r2,[pool_037FE16C]	; 037FE0FA
	str r3,[r2,#0x54]	; 037FE0FC
	str r1,[r2,#0x50]	; 037FE0FE
	mov r3,#0x1	; 037FE100
	str r3,[r2,#0x48]	; 037FE102
	str r1,[r2,#0x4c]	; 037FE104
	str r1,[r2,#0x58]	; 037FE106
	str r2,[r0,#0x14]	; 037FE108
	str r2,[r0,#0xc]	; 037FE10A
	str r2,[r0,#0x8]	; 037FE10C
	ldr r2,[pool_037FE170]	; 037FE10E
	cmp r2,#0x0	; 037FE110
	bne loc_037FE11A	; 037FE112
	ldr r0,[pool_037FE174]	; 037FE114
	sub r3,r0,r2	; 037FE116
	b loc_037FE122	; 037FE118
loc_037FE11A:
	ldr r1,[pool_037FE178]	; 037FE11A
	ldr r0,[pool_037FE17C]	; 037FE11C
	sub r0,r0,r1	; 037FE11E
	sub r3,r0,r2	; 037FE120
loc_037FE122:
	ldr r1,[pool_037FE178]	; 037FE122
	ldr r0,[pool_037FE17C]	; 037FE124
	sub r1,r0,r1	; 037FE126
	ldr r2,[pool_037FE16C]	; 037FE128
	str r1,[r2,#0x6c]	; 037FE12A
	str r3,[r2,#0x68]	; 037FE12C
	mov r0,#0x0	; 037FE12E
	str r0,[r2,#0x70]	; 037FE130
	ldr r3,[pool_037FE180]	; 037FE132
	sub r1,r1,#0x4	; 037FE134
	str r3,[r1,#0x0]	; 037FE136
	ldr r3,[pool_037FE184]	; 037FE138
	ldr r1,[r2,#0x68]	; 037FE13A
	str r3,[r1,#0x0]	; 037FE13C
	ldr r1,[pool_037FE188]	; 037FE13E
	strh r0,[r1,#0x34]	; 037FE140
	mov r2,#0x10	; 037FE142
	ldr r1,[pool_037FE160]	; 037FE144
	strh r2,[r1,#0x2]	; 037FE146
	strh r0,[r1,#0x0]	; 037FE148
	strh r0,[r1,#0x4]	; 037FE14A
	ldr r2,[pool_037FE18C]	; 037FE14C
	str r1,[r2,#0x0]	; 037FE14E
	bl loc_037FDE64	; 037FE150
loc_037FE154:
	add sp,#0x4	; 037FE154
	pop {r3}	; 037FE156
	bx r3	; 037FE158
	.byte 0xC0, 0x46	; 037FE15C
pool_037FE15C:
loc_037FE15C:
	.word P2_BssStart + 0x548	; 037FE15C
pool_037FE160:
loc_037FE160:
	.word P2_BssStart + 0x54C	; 037FE160
pool_037FE164:
loc_037FE164:
	.word 0x03805934	; 037FE164
pool_037FE168:
loc_037FE168:
	.word P2_BssStart + 0x544	; 037FE168
pool_037FE16C:
loc_037FE16C:
	.word P2_BssStart + 0x5A0	; 037FE16C
pool_037FE170:
loc_037FE170:
	.word 0x00000400	; 037FE170
pool_037FE174:
loc_037FE174:
	.word P2_WramCopy0RuntimeStart	; 037FE174
pool_037FE178:
loc_037FE178:
	.word 0x00000200	; 037FE178
pool_037FE17C:
loc_037FE17C:
	.word 0x0380FF80	; 037FE17C
pool_037FE180:
loc_037FE180:
	.word 0xD73BFDF7	; 037FE180
pool_037FE184:
loc_037FE184:
	.word 0xFBDD37BB	; 037FE184
pool_037FE188:
loc_037FE188:
	.word P2_BssStart + 0x5E0	; 037FE188
pool_037FE18C:
loc_037FE18C:
	.word FirmwareSystemWorkAddress + SystemWorkArm7ThreadInfoOffset	; 037FE18C

; ===== function loc_037FE190 =====
loc_037FE190:
	ldr r1,[pool_037FE1B8]	; 037FE190
	ldr r2,[r1,#0xc]	; 037FE192
	mov r1,#0x0	; 037FE194
	b loc_037FE19C	; 037FE196
loc_037FE198:
	add r1,r2,#0x0	; 037FE198
	ldr r2,[r2,#0x4c]	; 037FE19A
loc_037FE19C:
	cmp r2,#0x0	; 037FE19C
	beq loc_037FE1A4	; 037FE19E
	cmp r2,r0	; 037FE1A0
	bne loc_037FE198	; 037FE1A2
loc_037FE1A4:
	cmp r1,#0x0	; 037FE1A4
	bne loc_037FE1B0	; 037FE1A6
	ldr r1,[r0,#0x4c]	; 037FE1A8
	ldr r0,[pool_037FE1B8]	; 037FE1AA
	str r1,[r0,#0xc]	; 037FE1AC
	bx lr	; 037FE1AE
loc_037FE1B0:
	ldr r0,[r0,#0x4c]	; 037FE1B0
	str r0,[r1,#0x4c]	; 037FE1B2
	bx lr	; 037FE1B4
	.byte 0xC0, 0x46	; 037FE1B8
pool_037FE1B8:
loc_037FE1B8:
	.word P2_BssStart + 0x54C	; 037FE1B8

; ===== function loc_037FE1BC =====
loc_037FE1BC:
	push {r4,r5,lr}	; 037FE1BC
	sub sp,#0x4	; 037FE1BE
	ldr r1,[pool_037FE1F4]	; 037FE1C0
	ldr r3,[r1,#0xc]	; 037FE1C2
	add r5,r3,#0x0	; 037FE1C4
	mov r4,#0x0	; 037FE1C6
	b loc_037FE1CE	; 037FE1C8
loc_037FE1CA:
	add r4,r5,#0x0	; 037FE1CA
	ldr r5,[r5,#0x4c]	; 037FE1CC
loc_037FE1CE:
	cmp r5,#0x0	; 037FE1CE
	beq loc_037FE1DA	; 037FE1D0
	ldr r2,[r5,#0x54]	; 037FE1D2
	ldr r1,[r0,#0x54]	; 037FE1D4
	cmp r2,r1	; 037FE1D6
	bcc loc_037FE1CA	; 037FE1D8
loc_037FE1DA:
	cmp r4,#0x0	; 037FE1DA
	bne loc_037FE1E6	; 037FE1DC
	str r3,[r0,#0x4c]	; 037FE1DE
	ldr r1,[pool_037FE1F4]	; 037FE1E0
	str r0,[r1,#0xc]	; 037FE1E2
	b loc_037FE1EC	; 037FE1E4
loc_037FE1E6:
	ldr r1,[r4,#0x4c]	; 037FE1E6
	str r1,[r0,#0x4c]	; 037FE1E8
	str r0,[r4,#0x4c]	; 037FE1EA
loc_037FE1EC:
	add sp,#0x4	; 037FE1EC
	pop {r4,r5}	; 037FE1EE
	pop {r3}	; 037FE1F0
	bx r3	; 037FE1F2
pool_037FE1F4:
loc_037FE1F4:
	.word P2_BssStart + 0x54C	; 037FE1F4

; ===== function loc_037FE1F8 =====
loc_037FE1F8:
	mov r0,#0x0	; 037FE1F8
	ldr r2,[pool_037FE214]	; 037FE1FA
	b loc_037FE20A	; 037FE1FC
loc_037FE1FE:
	lsl r1,r0,#0x2	; 037FE1FE
	add r1,r2,r1	; 037FE200
	ldr r1,[r1,#0x14]	; 037FE202
	cmp r1,#0x0	; 037FE204
	beq loc_037FE212	; 037FE206
	add r0,r0,#0x1	; 037FE208
loc_037FE20A:
	cmp r0,#0x10	; 037FE20A
	blt loc_037FE1FE	; 037FE20C
	mov r0,#0x0	; 037FE20E
	mvn r0,r0	; 037FE210
loc_037FE212:
	bx lr	; 037FE212
pool_037FE214:
loc_037FE214:
	.word 0x0380592C	; 037FE214
.arm

; ===== function loc_037FE218 =====
loc_037FE218:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P2_InitThreadContext
	add r1,r1,#0x4	; 037FE218
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 037FE21C
	str r2,[r0,#ThreadContextSvcSpOffset]	; 037FE220
	sub r2,r2,#ThreadContextSvcStackBytes	; 037FE224
	str r2,[r0,#ThreadContextSpOffset]	; 037FE228
	ands r1,r1,#0x1	; 037FE22C
	movne r1,#0x3f	; 037FE230
	moveq r1,#0x1f	; 037FE234
	str r1,[r0,#ThreadContextCpsrOffset]	; 037FE238
	mov r1,#0x0	; 037FE23C
	str r1,[r0,#ThreadContextR0Offset]	; 037FE240
	str r1,[r0,#0x8]	; 037FE244
	str r1,[r0,#0xc]	; 037FE248
	str r1,[r0,#0x10]	; 037FE24C
	str r1,[r0,#0x14]	; 037FE250
	str r1,[r0,#0x18]	; 037FE254
	str r1,[r0,#0x1c]	; 037FE258
	str r1,[r0,#0x20]	; 037FE25C
	str r1,[r0,#0x24]	; 037FE260
	str r1,[r0,#0x28]	; 037FE264
	str r1,[r0,#0x2c]	; 037FE268
	str r1,[r0,#0x30]	; 037FE26C
	str r1,[r0,#0x34]	; 037FE270
	str r1,[r0,#ThreadContextLrOffset]	; 037FE274
	bx lr	; 037FE278
.endfunc

; ===== function loc_037FE27C =====
loc_037FE27C:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P2_SaveThreadContext
	add r1,r0,#0x0	; 037FE27C
	mrs r2,cpsr	; 037FE280
	str r2,[r1],#0x4	; 037FE284
	mov r0,#0xd3	; 037FE288
	msr cpsr_c,r0	; 037FE28C
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE290
	msr cpsr_c,r2	; 037FE294
	mov r0,#0x1	; 037FE298
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FE29C
	adr r0,P2_SaveThreadContextReturn + 4	; 037FE2A0
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE2A4
	mov r0,#0x0	; 037FE2A8
P2_SaveThreadContextReturn:
	bx lr	; 037FE2AC
.endfunc

; ===== function loc_037FE2B0 =====
loc_037FE2B0:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P2_LoadThreadContext
	mrs r1,cpsr	; 037FE2B0
	bic r1,r1,#0x1f	; 037FE2B4
	orr r1,r1,#0xd3	; 037FE2B8
	msr cpsr_c,r1	; 037FE2BC
	ldr r1,[r0],#0x4	; 037FE2C0
	msr spsr_cxsf,r1	; 037FE2C4
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE2C8
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE2CC
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FE2D0
	mov r0,r0	; 037FE2D4
	subs pc,lr,#0x4	; 037FE2D8
.endfunc
.thumb

; ===== function loc_037FE2DC =====
loc_037FE2DC:
	push {r4,r5,r6,r7,lr}	; 037FE2DC
	sub sp,#0x4	; 037FE2DE
	add r5,r0,#0x0	; 037FE2E0
	add r6,r1,#0x0	; 037FE2E2
	add r4,r2,#0x0	; 037FE2E4
	bl loc_037FDD34	; 037FE2E6
	add r7,r0,#0x0	; 037FE2EA
	mov r0,#0x1	; 037FE2EC
	and r4,r0	; 037FE2EE
	add r0,r5,#0x2	; 037FE2F0
	str r0,[sp,#0x0]	; 037FE2F2
	b loc_037FE30A	; 037FE2F4
loc_037FE2F6:
	cmp r4,#0x0	; 037FE2F6
	bne loc_037FE304	; 037FE2F8
	add r0,r7,#0x0	; 037FE2FA
	bl loc_037FDD58	; 037FE2FC
	mov r0,#0x0	; 037FE300
	b loc_037FE33E	; 037FE302
loc_037FE304:
	ldr r0,[sp,#0x0]	; 037FE304
	bl loc_037FDFA0	; 037FE306
loc_037FE30A:
	ldr r0,[r5,#0x10]	; 037FE30A
	cmp r0,#0x0	; 037FE30C
	beq loc_037FE2F6	; 037FE30E
	cmp r6,#0x0	; 037FE310
	beq loc_037FE31E	; 037FE312
	ldr r1,[r5,#0x4]	; 037FE314
	ldr r0,[r5,#0xc]	; 037FE316
	lsl r0,r0,#0x2	; 037FE318
	ldr r0,[r1,r0]	; 037FE31A
	str r0,[r6,#0x0]	; 037FE31C
loc_037FE31E:
	ldr r0,[r5,#0xc]	; 037FE31E
	add r0,r0,#0x1	; 037FE320
	ldr r1,[r5,#0x8]	; 037FE322
	bl loc_037FE348	; 037FE324
	str r1,[r5,#0xc]	; 037FE328
	ldr r0,[r5,#0x10]	; 037FE32A
	sub r0,r0,#0x1	; 037FE32C
	str r0,[r5,#0x10]	; 037FE32E
	add r0,r5,#0x0	; 037FE330
	bl loc_037FDF58	; 037FE332
	add r0,r7,#0x0	; 037FE336
	bl loc_037FDD58	; 037FE338
	mov r0,#0x1	; 037FE33C
loc_037FE33E:
	add sp,#0x4	; 037FE33E
	pop {r4,r5,r6,r7}	; 037FE340
	pop {r3}	; 037FE342
	bx r3	; 037FE344
	.byte 0xC0, 0x46	; 037FE348

; ===== function loc_037FE348 =====
loc_037FE348:
	bx pc	; 037FE348
	.byte 0xC0, 0x46	; 037FE34C
.arm

; ===== function loc_037FE34C =====
loc_037FE34C:
	ldr pc,[pool_037FE350]	; 037FE34C
pool_037FE350:
loc_037FE350:
	.word P2_SignedDivMod	; 037FE350
.thumb

; ===== function loc_037FE354 =====
loc_037FE354:
	push {r4,r5,r6,r7,lr}	; 037FE354
	sub sp,#0x4	; 037FE356
	add r5,r0,#0x0	; 037FE358
	add r6,r1,#0x0	; 037FE35A
	add r4,r2,#0x0	; 037FE35C
	bl loc_037FDD34	; 037FE35E
	add r7,r0,#0x0	; 037FE362
	mov r0,#0x1	; 037FE364
	and r4,r0	; 037FE366
	b loc_037FE37E	; 037FE368
loc_037FE36A:
	cmp r4,#0x0	; 037FE36A
	bne loc_037FE378	; 037FE36C
	add r0,r7,#0x0	; 037FE36E
	bl loc_037FDD58	; 037FE370
	mov r0,#0x0	; 037FE374
	b loc_037FE3A8	; 037FE376
loc_037FE378:
	add r0,r5,#0x0	; 037FE378
	bl loc_037FDFA0	; 037FE37A
loc_037FE37E:
	ldr r2,[r5,#0x10]	; 037FE37E
	ldr r1,[r5,#0x8]	; 037FE380
	cmp r1,r2	; 037FE382
	ble loc_037FE36A	; 037FE384
	ldr r0,[r5,#0xc]	; 037FE386
	add r0,r0,r2	; 037FE388
	bl loc_037FE348	; 037FE38A
	ldr r2,[r5,#0x4]	; 037FE38E
	lsl r0,r1,#0x2	; 037FE390
	str r6,[r2,r0]	; 037FE392
	ldr r0,[r5,#0x10]	; 037FE394
	add r0,r0,#0x1	; 037FE396
	str r0,[r5,#0x10]	; 037FE398
	add r0,r5,#0x2	; 037FE39A
	bl loc_037FDF58	; 037FE39C
	add r0,r7,#0x0	; 037FE3A0
	bl loc_037FDD58	; 037FE3A2
	mov r0,#0x1	; 037FE3A6
loc_037FE3A8:
	add sp,#0x4	; 037FE3A8
	pop {r4,r5,r6,r7}	; 037FE3AA
	pop {r3}	; 037FE3AC
	bx r3	; 037FE3AE

; ===== function loc_037FE3B0 =====
loc_037FE3B0:
	mov r3,#0x0	; 037FE3B0
	strh r3,[r0,#0x0]	; 037FE3B2
	strh r3,[r0,#0x2]	; 037FE3B4
	str r1,[r0,#0x4]	; 037FE3B6
	str r2,[r0,#0x8]	; 037FE3B8
	str r3,[r0,#0xc]	; 037FE3BA
	str r3,[r0,#0x10]	; 037FE3BC
	bx lr	; 037FE3BE

; ===== function loc_037FE3C0 =====
loc_037FE3C0:
	ldr r3,[r0,#0x60]	; 037FE3C0
	ldr r2,[r3,#0x10]	; 037FE3C2
	cmp r2,#0x0	; 037FE3C4
	bne loc_037FE3CE	; 037FE3C6
	mov r1,#0x0	; 037FE3C8
	str r1,[r0,#0x64]	; 037FE3CA
	b loc_037FE3D2	; 037FE3CC
loc_037FE3CE:
	mov r1,#0x0	; 037FE3CE
	str r1,[r2,#0xc]	; 037FE3D0
loc_037FE3D2:
	str r2,[r0,#0x60]	; 037FE3D2
	add r0,r3,#0x0	; 037FE3D4
	bx lr	; 037FE3D6
P2_Entry_037FE3D8:
	ldr r2,[r1,#0x10]	; 037FE3D8
	ldr r1,[r1,#0xc]	; 037FE3DA
	cmp r2,#0x0	; 037FE3DC
	bne P2_Entry_037FE3E4	; 037FE3DE
	str r1,[r0,#0x64]	; 037FE3E0
	b P2_Entry_037FE3E6	; 037FE3E2
P2_Entry_037FE3E4:
	str r1,[r2,#0xc]	; 037FE3E4
P2_Entry_037FE3E6:
	cmp r1,#0x0	; 037FE3E6
	bne P2_Entry_037FE3EE	; 037FE3E8
	str r2,[r0,#0x60]	; 037FE3EA
	bx lr	; 037FE3EC
P2_Entry_037FE3EE:
	str r2,[r1,#0x10]	; 037FE3EE
	bx lr	; 037FE3F0
	.byte 0x00, 0x00	; 037FE3F2
P2_Entry_037FE3F4:
	ldr r3,[r0,#0x64]	; 037FE3F4
	cmp r3,#0x0	; 037FE3F6
	bne P2_Entry_037FE3FE	; 037FE3F8
	str r1,[r0,#0x60]	; 037FE3FA
	b P2_Entry_037FE402	; 037FE3FC
P2_Entry_037FE3FE:
	ldr r2,[r0,#0x60]	; 037FE3FE
	str r1,[r2,#0x10]	; 037FE400
P2_Entry_037FE402:
	str r3,[r1,#0xc]	; 037FE402
	mov r2,#0x0	; 037FE404
	str r2,[r1,#0x10]	; 037FE406
	str r1,[r0,#0x64]	; 037FE408
	bx lr	; 037FE40A

; ===== function loc_037FE40C =====
loc_037FE40C:
	push {r4,r5,lr}	; 037FE40C
	sub sp,#0x4	; 037FE40E
	add r5,r0,#0x0	; 037FE410
	mov r4,#0x0	; 037FE412
	b loc_037FE424	; 037FE414
loc_037FE416:
	add r0,r5,#0x0	; 037FE416
	bl loc_037FE3C0	; 037FE418
	str r4,[r0,#0x8]	; 037FE41C
	str r4,[r0,#0x4]	; 037FE41E
	bl loc_037FDF58	; 037FE420
loc_037FE424:
	ldr r0,[r5,#0x60]	; 037FE424
	cmp r0,#0x0	; 037FE426
	bne loc_037FE416	; 037FE428
	add sp,#0x4	; 037FE42A
	pop {r4,r5}	; 037FE42C
	pop {r3}	; 037FE42E
	bx r3	; 037FE430
	.byte 0x00, 0x00	; 037FE432
P2_Entry_037FE434:
	push {r4,r5,lr}	; 037FE434
	sub sp,#0x4	; 037FE436
	add r5,r0,#0x0	; 037FE438
	bl loc_037FDD34	; 037FE43A
	add r4,r0,#0x0	; 037FE43E
	ldr r0,[pool_037FE474]	; 037FE440
	ldr r0,[r0,#0x8]	; 037FE442
	ldr r1,[r5,#0x4]	; 037FE444
	cmp r1,r0	; 037FE446
	bne P2_Entry_037FE466	; 037FE448
	ldr r1,[r5,#0x8]	; 037FE44A
	sub r1,r1,#0x1	; 037FE44C
	str r1,[r5,#0x8]	; 037FE44E
	ldr r1,[r5,#0x8]	; 037FE450
	cmp r1,#0x0	; 037FE452
	bne P2_Entry_037FE466	; 037FE454
	add r1,r5,#0x0	; 037FE456
	bl P2_Entry_037FE3D8	; 037FE458
	mov r0,#0x0	; 037FE45C
	str r0,[r5,#0x4]	; 037FE45E
	add r0,r5,#0x0	; 037FE460
	bl loc_037FDF58	; 037FE462
P2_Entry_037FE466:
	add r0,r4,#0x0	; 037FE466
	bl loc_037FDD58	; 037FE468
	add sp,#0x4	; 037FE46C
	pop {r4,r5}	; 037FE46E
	pop {r3}	; 037FE470
	bx r3	; 037FE472
pool_037FE474:
	.word P2_BssStart + 0x54C	; 037FE474
P2_Entry_037FE478:
	push {r4,r5,r6,r7,lr}	; 037FE478
	sub sp,#0x4	; 037FE47A
	add r5,r0,#0x0	; 037FE47C
	bl loc_037FDD34	; 037FE47E
	add r6,r0,#0x0	; 037FE482
	ldr r0,[pool_037FE4C8]	; 037FE484
	ldr r4,[r0,#0x8]	; 037FE486
	mov r7,#0x0	; 037FE488
P2_Entry_037FE48A:
	ldr r0,[r5,#0x4]	; 037FE48A
	cmp r0,#0x0	; 037FE48C
	bne P2_Entry_037FE4A2	; 037FE48E
	str r4,[r5,#0x4]	; 037FE490
	ldr r0,[r5,#0x8]	; 037FE492
	add r0,r0,#0x1	; 037FE494
	str r0,[r5,#0x8]	; 037FE496
	add r0,r4,#0x0	; 037FE498
	add r1,r5,#0x0	; 037FE49A
	bl P2_Entry_037FE3F4	; 037FE49C
	b P2_Entry_037FE4BA	; 037FE4A0
P2_Entry_037FE4A2:
	cmp r0,r4	; 037FE4A2
	bne P2_Entry_037FE4AE	; 037FE4A4
	ldr r0,[r5,#0x8]	; 037FE4A6
	add r0,r0,#0x1	; 037FE4A8
	str r0,[r5,#0x8]	; 037FE4AA
	b P2_Entry_037FE4BA	; 037FE4AC
P2_Entry_037FE4AE:
	str r5,[r4,#0x5c]	; 037FE4AE
	add r0,r5,#0x0	; 037FE4B0
	bl loc_037FDFA0	; 037FE4B2
	str r7,[r4,#0x5c]	; 037FE4B6
	b P2_Entry_037FE48A	; 037FE4B8
P2_Entry_037FE4BA:
	add r0,r6,#0x0	; 037FE4BA
	bl loc_037FDD58	; 037FE4BC
	add sp,#0x4	; 037FE4C0
	pop {r4,r5,r6,r7}	; 037FE4C2
	pop {r3}	; 037FE4C4
	bx r3	; 037FE4C6
pool_037FE4C8:
	.word P2_BssStart + 0x54C	; 037FE4C8
P2_Entry_037FE4CC:
	mov r1,#0x0	; 037FE4CC
	strh r1,[r0,#0x0]	; 037FE4CE
	str r1,[r0,#0x4]	; 037FE4D0
	str r1,[r0,#0x8]	; 037FE4D2
	bx lr	; 037FE4D4
	.byte 0x00, 0x00	; 037FE4D6

; ===== function loc_037FE4D8 =====
loc_037FE4D8:
	push {lr}	; 037FE4D8
	sub sp,#0x4	; 037FE4DA
	bl loc_037FE5BC	; 037FE4DC
	bl loc_03801EA4	; 037FE4E0
	bl loc_037FDE14	; 037FE4E4
	bl loc_037FDBE0	; 037FE4E8
	bl loc_037FE994	; 037FE4EC
	bl loc_037FEC9C	; 037FE4F0
	bl loc_037FE0D0	; 037FE4F4
	bl loc_038048F8	; 037FE4F8
	add sp,#0x4	; 037FE4FC
	pop {r3}	; 037FE4FE
	bx r3	; 037FE500
	.byte 0x00, 0x00	; 037FE504

; ===== function loc_037FE504 =====
loc_037FE504:
	lsl r2,r0,#0x2	; 037FE504
	ldr r0,[pool_037FE50C]	; 037FE506
	str r1,[r2,r0]	; 037FE508
	bx lr	; 037FE50A
pool_037FE50C:
loc_037FE50C:
	.word 0x027FFDA0	; 037FE50C

; ===== function loc_037FE510 =====
loc_037FE510:
	lsl r2,r0,#0x2	; 037FE510
	ldr r0,[pool_037FE518]	; 037FE512
	str r1,[r2,r0]	; 037FE514
	bx lr	; 037FE516
pool_037FE518:
loc_037FE518:
	.word 0x027FFDC4	; 037FE518

; ===== function loc_037FE51C =====
loc_037FE51C:
	cmp r0,#0x1	; 037FE51C
	beq loc_037FE52A	; 037FE51E
	cmp r0,#0x7	; 037FE520
	beq loc_037FE52E	; 037FE522
	cmp r0,#0x8	; 037FE524
	beq loc_037FE53A	; 037FE526
	b loc_037FE546	; 037FE528
loc_037FE52A:
	ldr r0,[pool_037FE54C]	; 037FE52A
	bx lr	; 037FE52C
loc_037FE52E:
	ldr r0,[pool_037FE550]	; 037FE52E
	ldr r1,[pool_037FE554]	; 037FE530
	cmp r0,r1	; 037FE532
	bls loc_037FE548	; 037FE534
	add r0,r1,#0x0	; 037FE536
	bx lr	; 037FE538
loc_037FE53A:
	ldr r0,[pool_037FE554]	; 037FE53A
	ldr r1,[pool_037FE550]	; 037FE53C
	cmp r1,r0	; 037FE53E
	bls loc_037FE548	; 037FE540
	add r0,r1,#0x0	; 037FE542
	bx lr	; 037FE544
loc_037FE546:
	mov r0,#0x0	; 037FE546
loc_037FE548:
	bx lr	; 037FE548
	.byte 0xC0, 0x46	; 037FE54C
pool_037FE54C:
loc_037FE54C:
	.word 0x027C0000	; 037FE54C
pool_037FE550:
loc_037FE550:
	.word P2_WramCopy0RuntimeEnd	; 037FE550
pool_037FE554:
loc_037FE554:
	.word Arm7WramBase	; 037FE554

; ===== function loc_037FE558 =====
loc_037FE558:
	cmp r0,#0x1	; 037FE558
	beq loc_037FE566	; 037FE55A
	cmp r0,#0x7	; 037FE55C
	beq loc_037FE56A	; 037FE55E
	cmp r0,#0x8	; 037FE560
	beq loc_037FE56E	; 037FE562
	b loc_037FE58C	; 037FE564
loc_037FE566:
	ldr r0,[pool_037FE590]	; 037FE566
	bx lr	; 037FE568
loc_037FE56A:
	ldr r0,[pool_037FE594]	; 037FE56A
	bx lr	; 037FE56C
loc_037FE56E:
	ldr r1,[pool_037FE598]	; 037FE56E
	ldr r0,[pool_037FE59C]	; 037FE570
	sub r0,r0,r1	; 037FE572
	ldr r1,[pool_037FE5A0]	; 037FE574
	cmp r1,#0x0	; 037FE576
	bne loc_037FE57E	; 037FE578
	ldr r0,[pool_037FE594]	; 037FE57A
	bx lr	; 037FE57C
loc_037FE57E:
	cmp r1,#0x0	; 037FE57E
	bge loc_037FE588	; 037FE580
	ldr r0,[pool_037FE594]	; 037FE582
	sub r0,r0,r1	; 037FE584
	bx lr	; 037FE586
loc_037FE588:
	sub r0,r0,r1	; 037FE588
	bx lr	; 037FE58A
loc_037FE58C:
	mov r0,#0x0	; 037FE58C
	bx lr	; 037FE58E
pool_037FE590:
loc_037FE590:
	.word 0x027FF000	; 037FE590
pool_037FE594:
loc_037FE594:
	.word Arm7WramBase	; 037FE594
pool_037FE598:
loc_037FE598:
	.word 0x00000200	; 037FE598
pool_037FE59C:
loc_037FE59C:
	.word 0x0380FF80	; 037FE59C
pool_037FE5A0:
loc_037FE5A0:
	.word 0x00000400	; 037FE5A0
P2_Entry_037FE5A4:
	lsl r1,r0,#0x2	; 037FE5A4
	ldr r0,[pool_037FE5AC]	; 037FE5A6
	ldr r0,[r1,r0]	; 037FE5A8
	bx lr	; 037FE5AA
pool_037FE5AC:
	.word 0x027FFDA0	; 037FE5AC
P2_Entry_037FE5B0:
	lsl r1,r0,#0x2	; 037FE5B0
	ldr r0,[pool_037FE5B8]	; 037FE5B2
	ldr r0,[r1,r0]	; 037FE5B4
	bx lr	; 037FE5B6
pool_037FE5B8:
	.word 0x027FFDC4	; 037FE5B8

; ===== function loc_037FE5BC =====
loc_037FE5BC:
	push {lr}	; 037FE5BC
	sub sp,#0x4	; 037FE5BE
	ldr r1,[pool_037FE5E4]	; 037FE5C0
	ldr r0,[r1,#0x0]	; 037FE5C2
	cmp r0,#0x0	; 037FE5C4
	bne loc_037FE5DC	; 037FE5C6
	mov r0,#0x1	; 037FE5C8
	str r0,[r1,#0x0]	; 037FE5CA
	bl loc_037FE5E8	; 037FE5CC
	mov r0,#0x7	; 037FE5D0
	bl loc_037FE5E8	; 037FE5D2
	mov r0,#0x8	; 037FE5D6
	bl loc_037FE5E8	; 037FE5D8
loc_037FE5DC:
	add sp,#0x4	; 037FE5DC
	pop {r3}	; 037FE5DE
	bx r3	; 037FE5E0
	.byte 0xC0, 0x46	; 037FE5E4
pool_037FE5E4:
loc_037FE5E4:
	.word P2_BssStart + 0x618	; 037FE5E4

; ===== function loc_037FE5E8 =====
loc_037FE5E8:
	push {r4,lr}	; 037FE5E8
	add r4,r0,#0x0	; 037FE5EA
	bl loc_037FE558	; 037FE5EC
	add r1,r0,#0x0	; 037FE5F0
	add r0,r4,#0x0	; 037FE5F2
	bl loc_037FE510	; 037FE5F4
	add r0,r4,#0x0	; 037FE5F8
	bl loc_037FE51C	; 037FE5FA
	add r1,r0,#0x0	; 037FE5FE
	add r0,r4,#0x0	; 037FE600
	bl loc_037FE504	; 037FE602
	pop {r4}	; 037FE606
	pop {r3}	; 037FE608
	bx r3	; 037FE60A

; ===== function loc_037FE60C =====
P2_Entry_037FE60C:
	push {r4,r5,r6,r7,lr}	; 037FE60C
	sub sp,#0xc	; 037FE60E
	add r4,r0,#0x0	; 037FE610
	add r5,r1,#0x0	; 037FE612
	add r6,r2,#0x0	; 037FE614
	bl loc_037FDD34	; 037FE616
	str r0,[sp,#0x4]	; 037FE61A
	lsl r1,r4,#0x2	; 037FE61C
	ldr r0,[pool_037FE67C]	; 037FE61E
	ldr r1,[r0,r1]	; 037FE620
	add r5,#0x1f	; 037FE622
	mov r0,#0x1f	; 037FE624
	bic r5,r0	; 037FE626
	bic r6,r0	; 037FE628
	mov r4,#0x0	; 037FE62A
	ldr r7,[r1,#0x4]	; 037FE62C
	b loc_037FE664	; 037FE62E
loc_037FE630:
	ldr r0,[r1,#0x10]	; 037FE630
	add r3,r4,#0x0	; 037FE632
	str r3,[sp,#0x0]	; 037FE634
	mov r2,#0xc	; 037FE636
	mul r3,r2	; 037FE638
	str r3,[sp,#0x0]	; 037FE63A
	add r3,r0,r3	; 037FE63C
	ldr r2,[sp,#0x0]	; 037FE63E
	ldr r0,[r0,r2]	; 037FE640
	cmp r0,#0x0	; 037FE642
	bge loc_037FE662	; 037FE644
	sub r0,r6,r5	; 037FE646
	str r0,[r3,#0x0]	; 037FE648
	mov r1,#0x0	; 037FE64A
	str r1,[r5,#0x0]	; 037FE64C
	str r1,[r5,#0x4]	; 037FE64E
	ldr r0,[r3,#0x0]	; 037FE650
	str r0,[r5,#0x8]	; 037FE652
	str r5,[r3,#0x4]	; 037FE654
	str r1,[r3,#0x8]	; 037FE656
	ldr r0,[sp,#0x4]	; 037FE658
	bl loc_037FDD58	; 037FE65A
	add r0,r4,#0x0	; 037FE65E
	b loc_037FE672	; 037FE660
loc_037FE662:
	add r4,r4,#0x1	; 037FE662
loc_037FE664:
	cmp r4,r7	; 037FE664
	blt loc_037FE630	; 037FE666
	ldr r0,[sp,#0x4]	; 037FE668
	bl loc_037FDD58	; 037FE66A
	mov r0,#0x0	; 037FE66E
	mvn r0,r0	; 037FE670
loc_037FE672:
	add sp,#0xc	; 037FE672
	pop {r4,r5,r6,r7}	; 037FE674
	pop {r3}	; 037FE676
	bx r3	; 037FE678
	.byte 0xC0, 0x46	; 037FE67C
pool_037FE67C:
loc_037FE67C:
	.word P2_BssStart + 0x61C	; 037FE67C
P2_Entry_037FE680:
	push {r4,r5,r6,r7,lr}	; 037FE680
	sub sp,#0xc	; 037FE682
	add r6,r0,#0x0	; 037FE684
	add r5,r1,#0x0	; 037FE686
	str r2,[sp,#0x8]	; 037FE688
	add r4,r3,#0x0	; 037FE68A
	bl loc_037FDD34	; 037FE68C
	str r0,[sp,#0x0]	; 037FE690
	lsl r1,r6,#0x2	; 037FE692
	ldr r0,[pool_037FE6F8]	; 037FE694
	str r5,[r0,r1]	; 037FE696
	add r3,r4,#0x0	; 037FE698
	mov r0,#0xc	; 037FE69A
	mul r3,r0	; 037FE69C
	add r0,r5,#0x0	; 037FE69E
	add r0,#0x14	; 037FE6A0
	str r0,[r5,#0x10]	; 037FE6A2
	str r4,[r5,#0x4]	; 037FE6A4
	mov r2,#0x0	; 037FE6A6
	mvn r0,r2	; 037FE6A8
	add r7,r2,#0x0	; 037FE6AA
	b P2_Entry_037FE6C8	; 037FE6AC
P2_Entry_037FE6AE:
	ldr r1,[r5,#0x10]	; 037FE6AE
	add r6,r2,#0x0	; 037FE6B0
	str r6,[sp,#0x4]	; 037FE6B2
	mov r4,#0xc	; 037FE6B4
	mul r6,r4	; 037FE6B6
	str r6,[sp,#0x4]	; 037FE6B8
	add r6,r1,r6	; 037FE6BA
	ldr r4,[sp,#0x4]	; 037FE6BC
	str r0,[r1,r4]	; 037FE6BE
	str r7,[r6,#0x8]	; 037FE6C0
	ldr r1,[r6,#0x8]	; 037FE6C2
	str r1,[r6,#0x4]	; 037FE6C4
	add r2,r2,#0x1	; 037FE6C6
P2_Entry_037FE6C8:
	ldr r1,[r5,#0x4]	; 037FE6C8
	cmp r2,r1	; 037FE6CA
	blt P2_Entry_037FE6AE	; 037FE6CC
	mov r0,#0x0	; 037FE6CE
	mvn r0,r0	; 037FE6D0
	str r0,[r5,#0x0]	; 037FE6D2
	ldr r0,[r5,#0x10]	; 037FE6D4
	add r0,r0,r3	; 037FE6D6
	add r0,#0x1f	; 037FE6D8
	mov r1,#0x1f	; 037FE6DA
	bic r0,r1	; 037FE6DC
	str r0,[r5,#0x8]	; 037FE6DE
	ldr r0,[sp,#0x8]	; 037FE6E0
	bic r0,r1	; 037FE6E2
	str r0,[sp,#0x8]	; 037FE6E4
	str r0,[r5,#0xc]	; 037FE6E6
	ldr r0,[sp,#0x0]	; 037FE6E8
	bl loc_037FDD58	; 037FE6EA
	ldr r0,[r5,#0x8]	; 037FE6EE
	add sp,#0xc	; 037FE6F0
	pop {r4,r5,r6,r7}	; 037FE6F2
	pop {r3}	; 037FE6F4
	bx r3	; 037FE6F6
pool_037FE6F8:
	.word P2_BssStart + 0x61C	; 037FE6F8
P2_Entry_037FE6FC:
	push {r4,r5,lr}	; 037FE6FC
	sub sp,#0x4	; 037FE6FE
	add r5,r0,#0x0	; 037FE700
	add r4,r1,#0x0	; 037FE702
	bl loc_037FDD34	; 037FE704
	lsl r2,r5,#0x2	; 037FE708
	ldr r1,[pool_037FE720]	; 037FE70A
	ldr r1,[r1,r2]	; 037FE70C
	ldr r5,[r1,#0x0]	; 037FE70E
	str r4,[r1,#0x0]	; 037FE710
	bl loc_037FDD58	; 037FE712
	add r0,r5,#0x0	; 037FE716
	add sp,#0x4	; 037FE718
	pop {r4,r5}	; 037FE71A
	pop {r3}	; 037FE71C
	bx r3	; 037FE71E
pool_037FE720:
	.word P2_BssStart + 0x61C	; 037FE720
P2_Entry_037FE724:
	push {r4,r5,r6,r7,lr}	; 037FE724
	sub sp,#0x4	; 037FE726
	add r6,r0,#0x0	; 037FE728
	add r5,r1,#0x0	; 037FE72A
	add r4,r2,#0x0	; 037FE72C
	bl loc_037FDD34	; 037FE72E
	add r7,r0,#0x0	; 037FE732
	lsl r1,r6,#0x2	; 037FE734
	ldr r0,[pool_037FE76C]	; 037FE736
	ldr r0,[r0,r1]	; 037FE738
	cmp r5,#0x0	; 037FE73A
	bge P2_Entry_037FE740	; 037FE73C
	ldr r5,[r0,#0x0]	; 037FE73E
P2_Entry_037FE740:
	sub r4,#0x20	; 037FE740
	ldr r1,[r0,#0x10]	; 037FE742
	mov r0,#0xc	; 037FE744
	mul r5,r0	; 037FE746
	add r5,r1,r5	; 037FE748
	ldr r0,[r5,#0x8]	; 037FE74A
	add r1,r4,#0x0	; 037FE74C
	bl loc_037FE87C	; 037FE74E
	str r0,[r5,#0x8]	; 037FE752
	ldr r0,[r5,#0x4]	; 037FE754
	add r1,r4,#0x0	; 037FE756
	bl P2_Entry_037FE81C	; 037FE758
	str r0,[r5,#0x4]	; 037FE75C
	add r0,r7,#0x0	; 037FE75E
	bl loc_037FDD58	; 037FE760
	add sp,#0x4	; 037FE764
	pop {r4,r5,r6,r7}	; 037FE766
	pop {r3}	; 037FE768
	bx r3	; 037FE76A
pool_037FE76C:
	.word P2_BssStart + 0x61C	; 037FE76C

; ===== function loc_037FE770 =====
loc_037FE770:
	push {r4,r5,r6,r7,lr}	; 037FE770
	sub sp,#0x4	; 037FE772
	add r6,r0,#0x0	; 037FE774
	add r4,r1,#0x0	; 037FE776
	add r5,r2,#0x0	; 037FE778
	bl loc_037FDD34	; 037FE77A
	add r7,r0,#0x0	; 037FE77E
	lsl r2,r6,#0x2	; 037FE780
	ldr r1,[pool_037FE818]	; 037FE782
	ldr r1,[r1,r2]	; 037FE784
	cmp r1,#0x0	; 037FE786
	bne loc_037FE792	; 037FE788
	bl loc_037FDD58	; 037FE78A
	mov r0,#0x0	; 037FE78E
	b loc_037FE810	; 037FE790
loc_037FE792:
	cmp r4,#0x0	; 037FE792
	bge loc_037FE798	; 037FE794
	ldr r4,[r1,#0x0]	; 037FE796
loc_037FE798:
	ldr r1,[r1,#0x10]	; 037FE798
	mov r0,#0xc	; 037FE79A
	mul r4,r0	; 037FE79C
	add r6,r1,r4	; 037FE79E
	add r5,#0x20	; 037FE7A0
	add r5,#0x1f	; 037FE7A2
	mov r0,#0x1f	; 037FE7A4
	bic r5,r0	; 037FE7A6
	ldr r0,[r6,#0x4]	; 037FE7A8
	add r4,r0,#0x0	; 037FE7AA
	b loc_037FE7B6	; 037FE7AC
loc_037FE7AE:
	ldr r1,[r4,#0x8]	; 037FE7AE
	cmp r5,r1	; 037FE7B0
	ble loc_037FE7BA	; 037FE7B2
	ldr r4,[r4,#0x4]	; 037FE7B4
loc_037FE7B6:
	cmp r4,#0x0	; 037FE7B6
	bne loc_037FE7AE	; 037FE7B8
loc_037FE7BA:
	cmp r4,#0x0	; 037FE7BA
	bne loc_037FE7C8	; 037FE7BC
	add r0,r7,#0x0	; 037FE7BE
	bl loc_037FDD58	; 037FE7C0
	mov r0,#0x0	; 037FE7C4
	b loc_037FE810	; 037FE7C6
loc_037FE7C8:
	ldr r1,[r4,#0x8]	; 037FE7C8
	sub r1,r1,r5	; 037FE7CA
	cmp r1,#0x40	; 037FE7CC
	bcs loc_037FE7DA	; 037FE7CE
	add r1,r4,#0x0	; 037FE7D0
	bl loc_037FE87C	; 037FE7D2
	str r0,[r6,#0x4]	; 037FE7D6
	b loc_037FE7FC	; 037FE7D8
loc_037FE7DA:
	str r5,[r4,#0x8]	; 037FE7DA
	add r0,r4,r5	; 037FE7DC
	str r1,[r0,#0x8]	; 037FE7DE
	ldr r1,[r4,#0x0]	; 037FE7E0
	str r1,[r4,r5]	; 037FE7E2
	ldr r1,[r4,#0x4]	; 037FE7E4
	str r1,[r0,#0x4]	; 037FE7E6
	ldr r1,[r0,#0x4]	; 037FE7E8
	cmp r1,#0x0	; 037FE7EA
	beq loc_037FE7F0	; 037FE7EC
	str r0,[r1,#0x0]	; 037FE7EE
loc_037FE7F0:
	ldr r1,[r0,#0x0]	; 037FE7F0
	cmp r1,#0x0	; 037FE7F2
	beq loc_037FE7FA	; 037FE7F4
	str r0,[r1,#0x4]	; 037FE7F6
	b loc_037FE7FC	; 037FE7F8
loc_037FE7FA:
	str r0,[r6,#0x4]	; 037FE7FA
loc_037FE7FC:
	ldr r0,[r6,#0x8]	; 037FE7FC
	add r1,r4,#0x0	; 037FE7FE
	bl loc_037FE898	; 037FE800
	str r0,[r6,#0x8]	; 037FE804
	add r0,r7,#0x0	; 037FE806
	bl loc_037FDD58	; 037FE808
	add r4,#0x20	; 037FE80C
	add r0,r4,#0x0	; 037FE80E
loc_037FE810:
	add sp,#0x4	; 037FE810
	pop {r4,r5,r6,r7}	; 037FE812
	pop {r3}	; 037FE814
	bx r3	; 037FE816
pool_037FE818:
loc_037FE818:
	.word P2_BssStart + 0x61C	; 037FE818
P2_Entry_037FE81C:
	push {r4,r5,lr}	; 037FE81C
	sub sp,#0x4	; 037FE81E
	add r2,r0,#0x0	; 037FE820
	mov r3,#0x0	; 037FE822
	b P2_Entry_037FE82E	; 037FE824
P2_Entry_037FE826:
	cmp r1,r2	; 037FE826
	bls P2_Entry_037FE832	; 037FE828
	add r3,r2,#0x0	; 037FE82A
	ldr r2,[r2,#0x4]	; 037FE82C
P2_Entry_037FE82E:
	cmp r2,#0x0	; 037FE82E
	bne P2_Entry_037FE826	; 037FE830
P2_Entry_037FE832:
	str r2,[r1,#0x4]	; 037FE832
	str r3,[r1,#0x0]	; 037FE834
	cmp r2,#0x0	; 037FE836
	beq P2_Entry_037FE854	; 037FE838
	str r1,[r2,#0x0]	; 037FE83A
	ldr r5,[r1,#0x8]	; 037FE83C
	add r4,r1,r5	; 037FE83E
	cmp r4,r2	; 037FE840
	bne P2_Entry_037FE854	; 037FE842
	ldr r4,[r2,#0x8]	; 037FE844
	add r4,r5,r4	; 037FE846
	str r4,[r1,#0x8]	; 037FE848
	ldr r2,[r2,#0x4]	; 037FE84A
	str r2,[r1,#0x4]	; 037FE84C
	cmp r2,#0x0	; 037FE84E
	beq P2_Entry_037FE854	; 037FE850
	str r1,[r2,#0x0]	; 037FE852
P2_Entry_037FE854:
	cmp r3,#0x0	; 037FE854
	beq P2_Entry_037FE872	; 037FE856
	str r1,[r3,#0x4]	; 037FE858
	ldr r4,[r3,#0x8]	; 037FE85A
	add r5,r3,r4	; 037FE85C
	cmp r5,r1	; 037FE85E
	bne P2_Entry_037FE874	; 037FE860
	ldr r1,[r1,#0x8]	; 037FE862
	add r1,r4,r1	; 037FE864
	str r1,[r3,#0x8]	; 037FE866
	str r2,[r3,#0x4]	; 037FE868
	cmp r2,#0x0	; 037FE86A
	beq P2_Entry_037FE874	; 037FE86C
	str r3,[r2,#0x0]	; 037FE86E
	b P2_Entry_037FE874	; 037FE870
P2_Entry_037FE872:
	add r0,r1,#0x0	; 037FE872
P2_Entry_037FE874:
	add sp,#0x4	; 037FE874
	pop {r4,r5}	; 037FE876
	pop {r3}	; 037FE878
	bx r3	; 037FE87A

; ===== function loc_037FE87C =====
loc_037FE87C:
	ldr r3,[r1,#0x4]	; 037FE87C
	cmp r3,#0x0	; 037FE87E
	beq loc_037FE886	; 037FE880
	ldr r2,[r1,#0x0]	; 037FE882
	str r2,[r3,#0x0]	; 037FE884
loc_037FE886:
	ldr r2,[r1,#0x0]	; 037FE886
	cmp r2,#0x0	; 037FE888
	bne loc_037FE890	; 037FE88A
	ldr r0,[r1,#0x4]	; 037FE88C
	bx lr	; 037FE88E
loc_037FE890:
	ldr r1,[r1,#0x4]	; 037FE890
	str r1,[r2,#0x4]	; 037FE892
	bx lr	; 037FE894
	.byte 0x00, 0x00	; 037FE898

; ===== function loc_037FE898 =====
loc_037FE898:
	str r0,[r1,#0x4]	; 037FE898
	mov r2,#0x0	; 037FE89A
	str r2,[r1,#0x0]	; 037FE89C
	cmp r0,#0x0	; 037FE89E
	beq loc_037FE8A4	; 037FE8A0
	str r1,[r0,#0x0]	; 037FE8A2
loc_037FE8A4:
	add r0,r1,#0x0	; 037FE8A4
	bx lr	; 037FE8A6

; ===== function loc_037FE8A8 =====
loc_037FE8A8:
	ldr r1,[pool_037FE8B8]	; 037FE8A8
	ldrh r3,[r1,#0x0]	; 037FE8AA
	mov r2,#0x1	; 037FE8AC
	lsl r2,r0	; 037FE8AE
	orr r3,r2	; 037FE8B0
	strh r3,[r1,#0x0]	; 037FE8B2
	bx lr	; 037FE8B4
	.byte 0xC0, 0x46	; 037FE8B8
pool_037FE8B8:
loc_037FE8B8:
	.word P2_BssStart + 0x640	; 037FE8B8

; ===== function loc_037FE8BC =====
loc_037FE8BC:
	push {r4,r5,lr}	; 037FE8BC
	sub sp,#0xc	; 037FE8BE
	bl loc_037FDD34	; 037FE8C0
	ldr r1,[pool_037FE924]	; 037FE8C4
	ldrh r1,[r1,#0x0]	; 037FE8C6
	add r3,sp,#0x0	; 037FE8C8
	strh r1,[r3,#0x0]	; 037FE8CA
	ldr r1,[pool_037FE928]	; 037FE8CC
	ldr r5,[r1,#0x0]	; 037FE8CE
	ldr r4,[r1,#0x4]	; 037FE8D0
	ldr r1,[pool_037FE92C]	; 037FE8D2
	mov r2,#0x0	; 037FE8D4
	and r4,r1	; 037FE8D6
	bic r5,r2	; 037FE8D8
	str r5,[sp,#0x4]	; 037FE8DA
	str r4,[sp,#0x8]	; 037FE8DC
	ldr r1,[pool_037FE930]	; 037FE8DE
	ldr r4,[r1,#0x0]	; 037FE8E0
	mov r1,#0x8	; 037FE8E2
	and r4,r1	; 037FE8E4
	cmp r4,#0x0	; 037FE8E6
	beq loc_037FE902	; 037FE8E8
	ldrh r3,[r3,#0x0]	; 037FE8EA
	ldr r1,[pool_037FE934]	; 037FE8EC
	and r3,r1	; 037FE8EE
	cmp r3,#0x0	; 037FE8F0
	bne loc_037FE902	; 037FE8F2
	ldr r3,[sp,#0x4]	; 037FE8F4
	ldr r4,[sp,#0x8]	; 037FE8F6
	mov r1,#0x1	; 037FE8F8
	add r1,r3,r1	; 037FE8FA
	adc r4,r2	; 037FE8FC
	str r1,[sp,#0x4]	; 037FE8FE
	str r4,[sp,#0x8]	; 037FE900
loc_037FE902:
	bl loc_037FDD58	; 037FE902
	ldr r2,[sp,#0x4]	; 037FE906
	ldr r1,[sp,#0x8]	; 037FE908
	lsr r0,r2,#0x10	; 037FE90A
	lsl r1,r1,#0x10	; 037FE90C
	orr r1,r0	; 037FE90E
	lsl r0,r2,#0x10	; 037FE910
	add r2,sp,#0x0	; 037FE912
	ldrh r3,[r2,#0x0]	; 037FE914
	asr r2,r3,#0x1f	; 037FE916
	orr r1,r2	; 037FE918
	orr r0,r3	; 037FE91A
	add sp,#0xc	; 037FE91C
	pop {r4,r5}	; 037FE91E
	pop {r3}	; 037FE920
	bx r3	; 037FE922
pool_037FE924:
loc_037FE924:
	.word TIMER0_DATA	; 037FE924
pool_037FE928:
loc_037FE928:
	.word P2_BssStart + 0x64C	; 037FE928
pool_037FE92C:
loc_037FE92C:
	.word 0x0000FFFF	; 037FE92C
pool_037FE930:
loc_037FE930:
	.word REG_IF	; 037FE930
pool_037FE934:
loc_037FE934:
	.word 0x00008000	; 037FE934

; ===== function loc_037FE938 =====
P2_IrqHandler_037FE938:
	push {r4,lr}	; 037FE938
	ldr r1,[pool_037FE974]	; 037FE93A
	ldr r2,[r1,#0x0]	; 037FE93C
	ldr r4,[r1,#0x4]	; 037FE93E
	mov r3,#0x0	; 037FE940
	mov r0,#0x1	; 037FE942
	add r0,r2,r0	; 037FE944
	adc r4,r3	; 037FE946
	str r0,[r1,#0x0]	; 037FE948
	str r4,[r1,#0x4]	; 037FE94A
	ldr r0,[pool_037FE978]	; 037FE94C
	ldr r1,[r0,#0x0]	; 037FE94E
	cmp r1,#0x0	; 037FE950
	beq loc_037FE962	; 037FE952
	ldr r2,[pool_037FE97C]	; 037FE954
	strh r3,[r2,#0x0]	; 037FE956
	ldr r1,[pool_037FE980]	; 037FE958
	strh r3,[r1,#0x0]	; 037FE95A
	mov r1,#0xc1	; 037FE95C
	strh r1,[r2,#0x0]	; 037FE95E
	str r3,[r0,#0x0]	; 037FE960
loc_037FE962:
	mov r0,#0x0	; 037FE962
	ldr r1,[pool_037FE984]	; 037FE964
	add r2,r0,#0x0	; 037FE966
	bl loc_037FDB34	; 037FE968
	pop {r4}	; 037FE96C
	pop {r3}	; 037FE96E
	bx r3	; 037FE970
	.byte 0xC0, 0x46	; 037FE974
pool_037FE974:
loc_037FE974:
	.word P2_BssStart + 0x64C	; 037FE974
pool_037FE978:
loc_037FE978:
	.word P2_BssStart + 0x648	; 037FE978
pool_037FE97C:
loc_037FE97C:
	.word TIMER0_CR	; 037FE97C
pool_037FE980:
loc_037FE980:
	.word TIMER0_DATA	; 037FE980
pool_037FE984:
loc_037FE984:
	.word P2_IrqHandler_037FE938 + 1	; 037FE984

; ===== function loc_037FE988 =====
loc_037FE988:
	ldr r0,[pool_037FE990]	; 037FE988
	ldrh r0,[r0,#0x0]	; 037FE98A
	bx lr	; 037FE98C
	.byte 0xC0, 0x46	; 037FE990
pool_037FE990:
loc_037FE990:
	.word P2_BssStart + 0x644	; 037FE990

; ===== function loc_037FE994 =====
loc_037FE994:
	push {lr}	; 037FE994
	sub sp,#0x4	; 037FE996
	ldr r0,[pool_037FE9D8]	; 037FE998
	ldrh r1,[r0,#0x0]	; 037FE99A
	cmp r1,#0x0	; 037FE99C
	bne loc_037FE9D2	; 037FE99E
	mov r1,#0x1	; 037FE9A0
	strh r1,[r0,#0x0]	; 037FE9A2
	mov r0,#0x0	; 037FE9A4
	bl loc_037FE8A8	; 037FE9A6
	mov r2,#0x0	; 037FE9AA
	ldr r0,[pool_037FE9DC]	; 037FE9AC
	str r2,[r0,#0x0]	; 037FE9AE
	str r2,[r0,#0x4]	; 037FE9B0
	ldr r1,[pool_037FE9E0]	; 037FE9B2
	strh r2,[r1,#0x0]	; 037FE9B4
	ldr r0,[pool_037FE9E4]	; 037FE9B6
	strh r2,[r0,#0x0]	; 037FE9B8
	mov r0,#0xc1	; 037FE9BA
	strh r0,[r1,#0x0]	; 037FE9BC
	mov r0,#0x8	; 037FE9BE
	ldr r1,[pool_037FE9E8]	; 037FE9C0
	bl loc_037FDB68	; 037FE9C2
	mov r0,#0x8	; 037FE9C6
	bl loc_037FDAE4	; 037FE9C8
	mov r1,#0x0	; 037FE9CC
	ldr r0,[pool_037FE9EC]	; 037FE9CE
	str r1,[r0,#0x0]	; 037FE9D0
loc_037FE9D2:
	add sp,#0x4	; 037FE9D2
	pop {r3}	; 037FE9D4
	bx r3	; 037FE9D6
pool_037FE9D8:
loc_037FE9D8:
	.word P2_BssStart + 0x644	; 037FE9D8
pool_037FE9DC:
loc_037FE9DC:
	.word P2_BssStart + 0x64C	; 037FE9DC
pool_037FE9E0:
loc_037FE9E0:
	.word TIMER0_CR	; 037FE9E0
pool_037FE9E4:
loc_037FE9E4:
	.word TIMER0_DATA	; 037FE9E4
pool_037FE9E8:
loc_037FE9E8:
	.word P2_IrqHandler_037FE938 + 1	; 037FE9E8
pool_037FE9EC:
loc_037FE9EC:
	.word P2_BssStart + 0x648	; 037FE9EC
.arm
P2_Code_037FE9F0:
	stmdb sp!,{lr}	; 037FE9F0
	bl loc_037FEA00	; 037FE9F4
	ldmia sp!,{lr}	; 037FE9F8
	bx lr	; 037FE9FC

; ===== function loc_037FEA00 =====
loc_037FEA00:
	ldr r12,[pool_037FEA08]	; 037FEA00
	bx r12	; 037FEA04
pool_037FEA08:
loc_037FEA08:
	.word loc_037FEA0C + 1	; 037FEA08
.thumb
loc_037FEA0C:
	push {r4,r5,lr}	; 037FEA0C
	sub sp,#0x4	; 037FEA0E
	mov r1,#0x0	; 037FEA10
	ldr r0,[pool_037FEAA4]	; 037FEA12
	strh r1,[r0,#0x0]	; 037FEA14
	mov r0,#0x10	; 037FEA16
	bl loc_037FDAB8	; 037FEA18
	ldr r2,[pool_037FEAA8]	; 037FEA1C
	ldr r1,[r2,#0x0]	; 037FEA1E
	mov r0,#0x10	; 037FEA20
	orr r1,r0	; 037FEA22
	str r1,[r2,#0x0]	; 037FEA24
	bl loc_037FE8BC	; 037FEA26
	ldr r2,[pool_037FEAAC]	; 037FEA2A
	ldr r4,[r2,#0x0]	; 037FEA2C
	cmp r4,#0x0	; 037FEA2E
	beq loc_037FEA9A	; 037FEA30
	ldr r5,[r4,#0xc]	; 037FEA32
	ldr r3,[r4,#0x10]	; 037FEA34
	sub r0,r0,r5	; 037FEA36
	sbc r1,r3	; 037FEA38
	bcs loc_037FEA44	; 037FEA3A
	add r0,r4,#0x0	; 037FEA3C
	bl loc_037FECCC	; 037FEA3E
	b loc_037FEA9A	; 037FEA42
loc_037FEA44:
	ldr r1,[r4,#0x18]	; 037FEA44
	str r1,[r2,#0x0]	; 037FEA46
	cmp r1,#0x0	; 037FEA48
	bne loc_037FEA52	; 037FEA4A
	mov r0,#0x0	; 037FEA4C
	str r0,[r2,#0x4]	; 037FEA4E
	b loc_037FEA56	; 037FEA50
loc_037FEA52:
	mov r0,#0x0	; 037FEA52
	str r0,[r1,#0x14]	; 037FEA54
loc_037FEA56:
	ldr r5,[r4,#0x0]	; 037FEA56
	ldr r2,[r4,#0x1c]	; 037FEA58
	ldr r1,[r4,#0x20]	; 037FEA5A
	mov r0,#0x0	; 037FEA5C
	eor r1,r0	; 037FEA5E
	eor r2,r0	; 037FEA60
	orr r1,r2	; 037FEA62
	bne loc_037FEA6A	; 037FEA64
	mov r0,#0x0	; 037FEA66
	str r0,[r4,#0x0]	; 037FEA68
loc_037FEA6A:
	cmp r5,#0x0	; 037FEA6A
	beq loc_037FEA74	; 037FEA6C
	ldr r0,[r4,#0x4]	; 037FEA6E
	bl loc_038050E0	; 037FEA70
loc_037FEA74:
	ldr r2,[r4,#0x1c]	; 037FEA74
	ldr r1,[r4,#0x20]	; 037FEA76
	mov r0,#0x0	; 037FEA78
	eor r1,r0	; 037FEA7A
	eor r2,r0	; 037FEA7C
	orr r1,r2	; 037FEA7E
	beq loc_037FEA8E	; 037FEA80
	str r5,[r4,#0x0]	; 037FEA82
	add r0,r4,#0x0	; 037FEA84
	mov r1,#0x0	; 037FEA86
	add r2,r1,#0x0	; 037FEA88
	bl loc_037FEBAC	; 037FEA8A
loc_037FEA8E:
	ldr r0,[pool_037FEAAC]	; 037FEA8E
	ldr r0,[r0,#0x0]	; 037FEA90
	cmp r0,#0x0	; 037FEA92
	beq loc_037FEA9A	; 037FEA94
	bl loc_037FECCC	; 037FEA96
loc_037FEA9A:
	add sp,#0x4	; 037FEA9A
	pop {r4,r5}	; 037FEA9C
	pop {r3}	; 037FEA9E
	bx r3	; 037FEAA0
	.byte 0xC0, 0x46	; 037FEAA4
pool_037FEAA4:
loc_037FEAA4:
	.word TIMER1_CR	; 037FEAA4
pool_037FEAA8:
loc_037FEAA8:
	.word Bios7IrqFlagsAddress	; 037FEAA8
pool_037FEAAC:
loc_037FEAAC:
	.word P2_BssStart + 0x658	; 037FEAAC

; ===== function loc_037FEAB0 =====
loc_037FEAB0:
	push {r4,r5,lr}	; 037FEAB0
	sub sp,#0x4	; 037FEAB2
	add r5,r0,#0x0	; 037FEAB4
	bl loc_037FDD34	; 037FEAB6
	add r4,r0,#0x0	; 037FEABA
	ldr r1,[r5,#0x0]	; 037FEABC
	cmp r1,#0x0	; 037FEABE
	bne loc_037FEAC8	; 037FEAC0
	bl loc_037FDD58	; 037FEAC2
	b loc_037FEAFE	; 037FEAC6
loc_037FEAC8:
	ldr r0,[r5,#0x18]	; 037FEAC8
	cmp r0,#0x0	; 037FEACA
	bne loc_037FEAD6	; 037FEACC
	ldr r2,[r5,#0x14]	; 037FEACE
	ldr r1,[pool_037FEB08]	; 037FEAD0
	str r2,[r1,#0x4]	; 037FEAD2
	b loc_037FEADA	; 037FEAD4
loc_037FEAD6:
	ldr r1,[r5,#0x14]	; 037FEAD6
	str r1,[r0,#0x14]	; 037FEAD8
loc_037FEADA:
	ldr r1,[r5,#0x14]	; 037FEADA
	cmp r1,#0x0	; 037FEADC
	beq loc_037FEAE4	; 037FEADE
	str r0,[r1,#0x18]	; 037FEAE0
	b loc_037FEAF0	; 037FEAE2
loc_037FEAE4:
	ldr r1,[pool_037FEB08]	; 037FEAE4
	str r0,[r1,#0x0]	; 037FEAE6
	cmp r0,#0x0	; 037FEAE8
	beq loc_037FEAF0	; 037FEAEA
	bl loc_037FECCC	; 037FEAEC
loc_037FEAF0:
	mov r0,#0x0	; 037FEAF0
	str r0,[r5,#0x0]	; 037FEAF2
	str r0,[r5,#0x1c]	; 037FEAF4
	str r0,[r5,#0x20]	; 037FEAF6
	add r0,r4,#0x0	; 037FEAF8
	bl loc_037FDD58	; 037FEAFA
loc_037FEAFE:
	add sp,#0x4	; 037FEAFE
	pop {r4,r5}	; 037FEB00
	pop {r3}	; 037FEB02
	bx r3	; 037FEB04
	.byte 0xC0, 0x46	; 037FEB08
pool_037FEB08:
loc_037FEB08:
	.word P2_BssStart + 0x658	; 037FEB08

; ===== function loc_037FEB0C =====
loc_037FEB0C:
	push {r4,r5,r6,lr}	; 037FEB0C
	sub sp,#0x10	; 037FEB0E
	add r5,r0,#0x0	; 037FEB10
	add r4,r1,#0x0	; 037FEB12
	add r6,r2,#0x0	; 037FEB14
	str r3,[sp,#0x0]	; 037FEB16
	ldr r0,[sp,#0x20]	; 037FEB18
	str r0,[sp,#0x4]	; 037FEB1A
	cmp r5,#0x0	; 037FEB1C
	beq loc_037FEB26	; 037FEB1E
	ldr r0,[r5,#0x0]	; 037FEB20
	cmp r0,#0x0	; 037FEB22
	beq loc_037FEB2A	; 037FEB24
loc_037FEB26:
	bl loc_037FF228	; 037FEB26
loc_037FEB2A:
	bl loc_037FDD34	; 037FEB2A
	str r0,[sp,#0x8]	; 037FEB2E
	ldr r0,[sp,#0x0]	; 037FEB30
	str r0,[r5,#0x1c]	; 037FEB32
	ldr r0,[sp,#0x4]	; 037FEB34
	str r0,[r5,#0x20]	; 037FEB36
	str r4,[r5,#0x24]	; 037FEB38
	str r6,[r5,#0x28]	; 037FEB3A
	ldr r0,[sp,#0x24]	; 037FEB3C
	str r0,[r5,#0x0]	; 037FEB3E
	ldr r0,[sp,#0x28]	; 037FEB40
	str r0,[r5,#0x4]	; 037FEB42
	add r0,r5,#0x0	; 037FEB44
	mov r1,#0x0	; 037FEB46
	add r2,r1,#0x0	; 037FEB48
	bl loc_037FEBAC	; 037FEB4A
	ldr r0,[sp,#0x8]	; 037FEB4E
	bl loc_037FDD58	; 037FEB50
	add sp,#0x10	; 037FEB54
	pop {r4,r5,r6}	; 037FEB56
	pop {r3}	; 037FEB58
	bx r3	; 037FEB5A

; ===== function loc_037FEB5C =====
loc_037FEB5C:
	push {r4,r5,r6,r7,lr}	; 037FEB5C
	sub sp,#0x4	; 037FEB5E
	add r5,r0,#0x0	; 037FEB60
	add r6,r1,#0x0	; 037FEB62
	add r4,r2,#0x0	; 037FEB64
	add r7,r3,#0x0	; 037FEB66
	cmp r5,#0x0	; 037FEB68
	beq loc_037FEB72	; 037FEB6A
	ldr r0,[r5,#0x0]	; 037FEB6C
	cmp r0,#0x0	; 037FEB6E
	beq loc_037FEB76	; 037FEB70
loc_037FEB72:
	bl loc_037FF228	; 037FEB72
loc_037FEB76:
	bl loc_037FDD34	; 037FEB76
	str r0,[sp,#0x0]	; 037FEB7A
	mov r0,#0x0	; 037FEB7C
	str r0,[r5,#0x1c]	; 037FEB7E
	str r0,[r5,#0x20]	; 037FEB80
	str r7,[r5,#0x0]	; 037FEB82
	ldr r0,[sp,#0x18]	; 037FEB84
	str r0,[r5,#0x4]	; 037FEB86
	bl loc_037FE8BC	; 037FEB88
	add r2,r0,#0x0	; 037FEB8C
	add r0,r5,#0x0	; 037FEB8E
	add r2,r6,r2	; 037FEB90
	adc r4,r1	; 037FEB92
	add r1,r2,#0x0	; 037FEB94
	add r2,r4,#0x0	; 037FEB96
	bl loc_037FEBAC	; 037FEB98
	ldr r0,[sp,#0x0]	; 037FEB9C
	bl loc_037FDD58	; 037FEB9E
	add sp,#0x4	; 037FEBA2
	pop {r4,r5,r6,r7}	; 037FEBA4
	pop {r3}	; 037FEBA6
	bx r3	; 037FEBA8
	.byte 0x00, 0x00	; 037FEBAC

; ===== function loc_037FEBAC =====
loc_037FEBAC:
	push {r4,r5,r6,r7,lr}	; 037FEBAC
	sub sp,#0xc	; 037FEBAE
	add r5,r0,#0x0	; 037FEBB0
	add r4,r1,#0x0	; 037FEBB2
	add r6,r2,#0x0	; 037FEBB4
	ldr r2,[r5,#0x1c]	; 037FEBB6
	ldr r1,[r5,#0x20]	; 037FEBB8
	mov r0,#0x0	; 037FEBBA
	eor r1,r0	; 037FEBBC
	eor r2,r0	; 037FEBBE
	orr r1,r2	; 037FEBC0
	beq loc_037FEC06	; 037FEBC2
	bl loc_037FE8BC	; 037FEBC4
	ldr r4,[r5,#0x24]	; 037FEBC8
	ldr r6,[r5,#0x28]	; 037FEBCA
	sub r2,r4,r0	; 037FEBCC
	lsl r2,r6,#0	; 037FEBCE
	sbc r2,r1	; 037FEBD0
	bcs loc_037FEC06	; 037FEBD2
	ldr r2,[r5,#0x1c]	; 037FEBD4
	str r2,[sp,#0x0]	; 037FEBD6
	ldr r2,[r5,#0x20]	; 037FEBD8
	str r2,[sp,#0x4]	; 037FEBDA
	sub r0,r0,r4	; 037FEBDC
	sbc r1,r6	; 037FEBDE
	ldr r2,[sp,#0x0]	; 037FEBE0
	ldr r3,[sp,#0x4]	; 037FEBE2
	bl loc_037FEC70	; 037FEBE4
	str r0,[sp,#0x8]	; 037FEBE8
	add r7,r1,#0x0	; 037FEBEA
	ldr r0,[sp,#0x0]	; 037FEBEC
	ldr r1,[sp,#0x4]	; 037FEBEE
	mov r3,#0x1	; 037FEBF0
	ldr r2,[sp,#0x8]	; 037FEBF2
	add r3,r2,r3	; 037FEBF4
	mov r2,#0x0	; 037FEBF6
	adc r7,r2	; 037FEBF8
	add r2,r3,#0x0	; 037FEBFA
	add r3,r7,#0x0	; 037FEBFC
	bl loc_037FEC7C	; 037FEBFE
	add r4,r4,r0	; 037FEC02
	adc r6,r1	; 037FEC04
loc_037FEC06:
	str r4,[r5,#0xc]	; 037FEC06
	str r6,[r5,#0x10]	; 037FEC08
	ldr r0,[pool_037FEC6C]	; 037FEC0A
	ldr r3,[r0,#0x0]	; 037FEC0C
	b loc_037FEC42	; 037FEC0E
loc_037FEC10:
	ldr r1,[r3,#0xc]	; 037FEC10
	ldr r0,[r3,#0x10]	; 037FEC12
	sub r2,r4,r1	; 037FEC14
	lsl r1,r6,#0	; 037FEC16
	sbc r1,r0	; 037FEC18
	mov r0,#0x0	; 037FEC1A
	sub r2,r2,r0	; 037FEC1C
	sbc r1,r0	; 037FEC1E
	bge loc_037FEC40	; 037FEC20
	ldr r0,[r3,#0x14]	; 037FEC22
	str r0,[r5,#0x14]	; 037FEC24
	str r5,[r3,#0x14]	; 037FEC26
	str r3,[r5,#0x18]	; 037FEC28
	ldr r0,[r5,#0x14]	; 037FEC2A
	cmp r0,#0x0	; 037FEC2C
	beq loc_037FEC34	; 037FEC2E
	str r5,[r0,#0x18]	; 037FEC30
	b loc_037FEC64	; 037FEC32
loc_037FEC34:
	ldr r0,[pool_037FEC6C]	; 037FEC34
	str r5,[r0,#0x0]	; 037FEC36
	add r0,r5,#0x0	; 037FEC38
	bl loc_037FECCC	; 037FEC3A
	b loc_037FEC64	; 037FEC3E
loc_037FEC40:
	ldr r3,[r3,#0x18]	; 037FEC40
loc_037FEC42:
	cmp r3,#0x0	; 037FEC42
	bne loc_037FEC10	; 037FEC44
	mov r0,#0x0	; 037FEC46
	str r0,[r5,#0x18]	; 037FEC48
	ldr r0,[pool_037FEC6C]	; 037FEC4A
	ldr r1,[r0,#0x4]	; 037FEC4C
	str r5,[r0,#0x4]	; 037FEC4E
	str r1,[r5,#0x14]	; 037FEC50
	cmp r1,#0x0	; 037FEC52
	beq loc_037FEC5A	; 037FEC54
	str r5,[r1,#0x18]	; 037FEC56
	b loc_037FEC64	; 037FEC58
loc_037FEC5A:
	str r5,[r0,#0x4]	; 037FEC5A
	str r5,[r0,#0x0]	; 037FEC5C
	add r0,r5,#0x0	; 037FEC5E
	bl loc_037FECCC	; 037FEC60
loc_037FEC64:
	add sp,#0xc	; 037FEC64
	pop {r4,r5,r6,r7}	; 037FEC66
	pop {r3}	; 037FEC68
	bx r3	; 037FEC6A
pool_037FEC6C:
loc_037FEC6C:
	.word P2_BssStart + 0x658	; 037FEC6C

; ===== function loc_037FEC70 =====
loc_037FEC70:
	bx pc	; 037FEC70
	.byte 0xC0, 0x46	; 037FEC74
.arm

; ===== function loc_037FEC74 =====
loc_037FEC74:
	ldr pc,[pool_037FEC78]	; 037FEC74
pool_037FEC78:
loc_037FEC78:
	.word loc_03804994	; 037FEC78
.thumb

; ===== function loc_037FEC7C =====
loc_037FEC7C:
	bx pc	; 037FEC7C
	.byte 0xC0, 0x46	; 037FEC80
.arm

; ===== function loc_037FEC80 =====
loc_037FEC80:
	ldr pc,[pool_037FEC84]	; 037FEC80
pool_037FEC84:
loc_037FEC84:
	.word loc_03804B9C	; 037FEC84
.thumb

; ===== function loc_037FEC88 =====
loc_037FEC88:
	mov r1,#0x0	; 037FEC88
	str r1,[r0,#0x0]	; 037FEC8A
	str r1,[r0,#0x8]	; 037FEC8C
	bx lr	; 037FEC8E

; ===== function loc_037FEC90 =====
loc_037FEC90:
	ldr r0,[pool_037FEC98]	; 037FEC90
	ldrh r0,[r0,#0x0]	; 037FEC92
	bx lr	; 037FEC94
	.byte 0xC0, 0x46	; 037FEC98
pool_037FEC98:
loc_037FEC98:
	.word P2_BssStart + 0x654	; 037FEC98

; ===== function loc_037FEC9C =====
loc_037FEC9C:
	push {lr}	; 037FEC9C
	sub sp,#0x4	; 037FEC9E
	ldr r1,[pool_037FECC4]	; 037FECA0
	ldrh r0,[r1,#0x0]	; 037FECA2
	cmp r0,#0x0	; 037FECA4
	bne loc_037FECBE	; 037FECA6
	mov r0,#0x1	; 037FECA8
	strh r0,[r1,#0x0]	; 037FECAA
	bl loc_037FE8A8	; 037FECAC
	mov r1,#0x0	; 037FECB0
	ldr r0,[pool_037FECC8]	; 037FECB2
	str r1,[r0,#0x0]	; 037FECB4
	str r1,[r0,#0x4]	; 037FECB6
	mov r0,#0x10	; 037FECB8
	bl loc_037FDAB8	; 037FECBA
loc_037FECBE:
	add sp,#0x4	; 037FECBE
	pop {r3}	; 037FECC0
	bx r3	; 037FECC2
pool_037FECC4:
loc_037FECC4:
	.word P2_BssStart + 0x654	; 037FECC4
pool_037FECC8:
loc_037FECC8:
	.word P2_BssStart + 0x658	; 037FECC8

; ===== function loc_037FECCC =====
loc_037FECCC:
	push {r4,r5,lr}	; 037FECCC
	sub sp,#0x4	; 037FECCE
	add r4,r0,#0x0	; 037FECD0
	bl loc_037FE8BC	; 037FECD2
	mov r2,#0x0	; 037FECD6
	ldr r3,[pool_037FED24]	; 037FECD8
	strh r2,[r3,#0x0]	; 037FECDA
	ldr r3,[r4,#0xc]	; 037FECDC
	ldr r4,[r4,#0x10]	; 037FECDE
	sub r5,r3,r0	; 037FECE0
	sbc r4,r1	; 037FECE2
	mov r0,#0x1	; 037FECE4
	ldr r1,[pool_037FED28]	; 037FECE6
	bl loc_037FDB34	; 037FECE8
	mov r1,#0x0	; 037FECEC
	sub r0,r5,r1	; 037FECEE
	lsl r0,r4,#0	; 037FECF0
	sbc r0,r1	; 037FECF2
	bge loc_037FECFA	; 037FECF4
	ldr r1,[pool_037FED2C]	; 037FECF6
	b loc_037FED0C	; 037FECF8
loc_037FECFA:
	ldr r0,[pool_037FED30]	; 037FECFA
	sub r0,r5,r0	; 037FECFC
	sbc r4,r1	; 037FECFE
	bge loc_037FED0A	; 037FED00
	mvn r0,r5	; 037FED02
	lsl r0,r0,#0x10	; 037FED04
	lsr r1,r0,#0x10	; 037FED06
	b loc_037FED0C	; 037FED08
loc_037FED0A:
	mov r1,#0x0	; 037FED0A
loc_037FED0C:
	ldr r0,[pool_037FED34]	; 037FED0C
	strh r1,[r0,#0x0]	; 037FED0E
	mov r1,#0xc1	; 037FED10
	ldr r0,[pool_037FED24]	; 037FED12
	strh r1,[r0,#0x0]	; 037FED14
	mov r0,#0x10	; 037FED16
	bl loc_037FDAE4	; 037FED18
	add sp,#0x4	; 037FED1C
	pop {r4,r5}	; 037FED1E
	pop {r3}	; 037FED20
	bx r3	; 037FED22
pool_037FED24:
loc_037FED24:
	.word TIMER1_CR	; 037FED24
pool_037FED28:
loc_037FED28:
	.word P2_Code_037FE9F0	; 037FED28
pool_037FED2C:
loc_037FED2C:
	.word 0x0000FFFE	; 037FED2C
pool_037FED30:
loc_037FED30:
	.word 0x00010000	; 037FED30
pool_037FED34:
loc_037FED34:
	.word TIMER1_DATA	; 037FED34

; ===== function loc_037FED38 =====
P2_Entry_037FED38:
	push {r4,lr}	; 037FED38
	add r4,r0,#0x0	; 037FED3A
	bl loc_037FDD34	; 037FED3C
	ldr r1,[pool_037FED64]	; 037FED40
	ldr r1,[r1,#0x0]	; 037FED42
	cmp r4,r1	; 037FED44
	bcs loc_037FED50	; 037FED46
	ldr r1,[pool_037FED68]	; 037FED48
	ldr r2,[r1,#0x0]	; 037FED4A
	add r2,r2,#0x1	; 037FED4C
	str r2,[r1,#0x0]	; 037FED4E
loc_037FED50:
	ldr r1,[pool_037FED64]	; 037FED50
	str r4,[r1,#0x0]	; 037FED52
	bl loc_037FDD58	; 037FED54
	ldr r0,[pool_037FED68]	; 037FED58
	ldr r0,[r0,#0x0]	; 037FED5A
	pop {r4}	; 037FED5C
	pop {r3}	; 037FED5E
	bx r3	; 037FED60
	.byte 0xC0, 0x46	; 037FED64
pool_037FED64:
loc_037FED64:
	.word P2_BssStart + 0x664	; 037FED64
pool_037FED68:
loc_037FED68:
	.word P2_BssStart + 0x668	; 037FED68
P2_Entry_037FED6C:
	ldr r3,[r0,#0xc]	; 037FED6C
	sub r3,r1,r3	; 037FED6E
	mov r1,#0x10	; 037FED70
	ldrsh r1,[r0,r1]	; 037FED72
	sub r2,r2,r1	; 037FED74
	cmp r3,#0x0	; 037FED76
	blt P2_Entry_037FED82	; 037FED78
	cmp r3,#0x0	; 037FED7A
	bne P2_Entry_037FED86	; 037FED7C
	cmp r2,#0x0	; 037FED7E
	bge P2_Entry_037FED86	; 037FED80
P2_Entry_037FED82:
	mov r0,#0x0	; 037FED82
	bx lr	; 037FED84
P2_Entry_037FED86:
	cmp r2,#0x0	; 037FED86
	bge P2_Entry_037FED8E	; 037FED88
	ldr r1,[pool_037FEDA0]	; 037FED8A
	add r2,r2,r1	; 037FED8C
P2_Entry_037FED8E:
	mov r1,#0x12	; 037FED8E
	ldrsh r0,[r0,r1]	; 037FED90
	cmp r2,r0	; 037FED92
	bgt P2_Entry_037FED9A	; 037FED94
	mov r0,#0x1	; 037FED96
	bx lr	; 037FED98
P2_Entry_037FED9A:
	mov r0,#0x2	; 037FED9A
	bx lr	; 037FED9C
	.byte 0xC0, 0x46	; 037FED9E
pool_037FEDA0:
	.word 0x00000107	; 037FEDA0
P2_IrqHandler_037FEDA4:
	push {r4,r5,r6,r7,lr}	; 037FEDA4
	sub sp,#0x4	; 037FEDA6
	mov r0,#0x4	; 037FEDA8
	bl loc_037FDAB8	; 037FEDAA
	ldr r3,[pool_037FEE84]	; 037FEDAE
	ldrh r1,[r3,#0x0]	; 037FEDB0
	mov r0,#0x20	; 037FEDB2
	bic r1,r0	; 037FEDB4
	strh r1,[r3,#0x0]	; 037FEDB6
	ldr r2,[pool_037FEE88]	; 037FEDB8
	ldr r1,[r2,#0x0]	; 037FEDBA
	mov r0,#0x4	; 037FEDBC
	orr r1,r0	; 037FEDBE
	str r1,[r2,#0x0]	; 037FEDC0
	ldrh r1,[r3,#0x0]	; 037FEDC2
	asr r2,r1,#0x8	; 037FEDC4
	mov r0,#0xff	; 037FEDC6
	and r2,r0	; 037FEDC8
	lsl r1,r1,#0x1	; 037FEDCA
	ldr r0,[pool_037FEE8C]	; 037FEDCC
	and r1,r0	; 037FEDCE
	orr r2,r1	; 037FEDD0
	sub r0,r2,#0x1	; 037FEDD2
	bl P2_Entry_037FED38	; 037FEDD4
	ldr r7,[pool_037FEE90]	; 037FEDD8
	b P2_Entry_037FEE74	; 037FEDDA
P2_Entry_037FEDDC:
	ldrh r4,[r7,#0x0]	; 037FEDDC
	add r0,r4,#0x0	; 037FEDDE
	bl P2_Entry_037FED38	; 037FEDE0
	add r6,r0,#0x0	; 037FEDE4
	add r0,r5,#0x0	; 037FEDE6
	add r1,r6,#0x0	; 037FEDE8
	add r2,r4,#0x0	; 037FEDEA
	bl P2_Entry_037FED6C	; 037FEDEC
	cmp r0,#0x0	; 037FEDF0
	beq P2_Entry_037FEDFE	; 037FEDF2
	cmp r0,#0x1	; 037FEDF4
	beq P2_Entry_037FEE2C	; 037FEDF6
	cmp r0,#0x2	; 037FEDF8
	beq P2_Entry_037FEE60	; 037FEDFA
	b P2_Entry_037FEE74	; 037FEDFC
P2_Entry_037FEDFE:
	add r0,r5,#0x0	; 037FEDFE
	bl P2_Entry_037FEF44	; 037FEE00
	ldrh r1,[r7,#0x0]	; 037FEE04
	mov r0,#0x10	; 037FEE06
	ldrsh r0,[r5,r0]	; 037FEE08
	cmp r0,r1	; 037FEE0A
	bne P2_Entry_037FEE7C	; 037FEE0C
	ldr r0,[r5,#0xc]	; 037FEE0E
	cmp r0,r6	; 037FEE10
	bne P2_Entry_037FEE7C	; 037FEE12
	mov r0,#0x4	; 037FEE14
	bl loc_037FDAB8	; 037FEE16
	ldr r0,[pool_037FEE84]	; 037FEE1A
	ldrh r1,[r0,#0x0]	; 037FEE1C
	mov r0,#0x20	; 037FEE1E
	bic r1,r0	; 037FEE20
	ldr r0,[pool_037FEE84]	; 037FEE22
	strh r1,[r0,#0x0]	; 037FEE24
	mov r0,#0x4	; 037FEE26
	bl loc_037FDA94	; 037FEE28
P2_Entry_037FEE2C:
	ldr r4,[r5,#0x0]	; 037FEE2C
	add r0,r5,#0x0	; 037FEE2E
	bl P2_Entry_037FF05C	; 037FEE30
	mov r0,#0x0	; 037FEE34
	str r0,[r5,#0x0]	; 037FEE36
	cmp r4,#0x0	; 037FEE38
	beq P2_Entry_037FEE42	; 037FEE3A
	ldr r0,[r5,#0x4]	; 037FEE3C
	bl loc_038050DC	; 037FEE3E
P2_Entry_037FEE42:
	ldr r0,[r5,#0x1c]	; 037FEE42
	cmp r0,#0x0	; 037FEE44
	beq P2_Entry_037FEE74	; 037FEE46
	ldr r0,[r5,#0x24]	; 037FEE48
	cmp r0,#0x0	; 037FEE4A
	bne P2_Entry_037FEE74	; 037FEE4C
	str r4,[r5,#0x0]	; 037FEE4E
	ldr r0,[pool_037FEE94]	; 037FEE50
	ldr r0,[r0,#0x0]	; 037FEE52
	add r0,r0,#0x1	; 037FEE54
	str r0,[r5,#0xc]	; 037FEE56
	add r0,r5,#0x0	; 037FEE58
	bl P2_Entry_037FF084	; 037FEE5A
	b P2_Entry_037FEE74	; 037FEE5E
P2_Entry_037FEE60:
	add r0,r5,#0x0	; 037FEE60
	bl P2_Entry_037FF05C	; 037FEE62
	add r0,r5,#0x0	; 037FEE66
	bl P2_Entry_037FF084	; 037FEE68
	ldr r0,[pool_037FEE94]	; 037FEE6C
	ldr r0,[r0,#0x0]	; 037FEE6E
	add r0,r0,#0x1	; 037FEE70
	str r0,[r5,#0xc]	; 037FEE72
P2_Entry_037FEE74:
	ldr r0,[pool_037FEE98]	; 037FEE74
	ldr r5,[r0,#0x0]	; 037FEE76
	cmp r5,#0x0	; 037FEE78
	bne P2_Entry_037FEDDC	; 037FEE7A
P2_Entry_037FEE7C:
	add sp,#0x4	; 037FEE7C
	pop {r4,r5,r6,r7}	; 037FEE7E
	pop {r3}	; 037FEE80
	bx r3	; 037FEE82
pool_037FEE84:
	.word REG_DISPSTAT	; 037FEE84
pool_037FEE88:
	.word Bios7IrqFlagsAddress	; 037FEE88
pool_037FEE8C:
	.word 0x00000100	; 037FEE8C
pool_037FEE90:
	.word REG_VCOUNT	; 037FEE90
pool_037FEE94:
	.word P2_BssStart + 0x668	; 037FEE94
pool_037FEE98:
	.word P2_BssStart + 0x66C	; 037FEE98
P2_Entry_037FEE9C:
	push {r4,r5,r6,r7,lr}	; 037FEE9C
	sub sp,#0x4	; 037FEE9E
	add r5,r0,#0x0	; 037FEEA0
	bl loc_037FDD34	; 037FEEA2
	add r6,r0,#0x0	; 037FEEA6
	cmp r5,#0x0	; 037FEEA8
	bne P2_Entry_037FEEB0	; 037FEEAA
	bl loc_037FF228	; 037FEEAC
P2_Entry_037FEEB0:
	ldr r0,[pool_037FEEEC]	; 037FEEB0
	ldr r0,[r0,#0x0]	; 037FEEB2
	cmp r0,#0x0	; 037FEEB4
	beq P2_Entry_037FEEBC	; 037FEEB6
	ldr r4,[r0,#0x18]	; 037FEEB8
	b P2_Entry_037FEEBE	; 037FEEBA
P2_Entry_037FEEBC:
	mov r4,#0x0	; 037FEEBC
P2_Entry_037FEEBE:
	mov r7,#0x0	; 037FEEBE
	b P2_Entry_037FEED8	; 037FEEC0
P2_Entry_037FEEC2:
	ldr r1,[r0,#0x8]	; 037FEEC2
	cmp r1,r5	; 037FEEC4
	bne P2_Entry_037FEECC	; 037FEEC6
	bl P2_Entry_037FEEF0	; 037FEEC8
P2_Entry_037FEECC:
	add r0,r4,#0x0	; 037FEECC
	cmp r4,#0x0	; 037FEECE
	beq P2_Entry_037FEED6	; 037FEED0
	ldr r4,[r4,#0x18]	; 037FEED2
	b P2_Entry_037FEED8	; 037FEED4
P2_Entry_037FEED6:
	add r4,r7,#0x0	; 037FEED6
P2_Entry_037FEED8:
	cmp r0,#0x0	; 037FEED8
	bne P2_Entry_037FEEC2	; 037FEEDA
	add r0,r6,#0x0	; 037FEEDC
	bl loc_037FDD58	; 037FEEDE
	add sp,#0x4	; 037FEEE2
	pop {r4,r5,r6,r7}	; 037FEEE4
	pop {r3}	; 037FEEE6
	bx r3	; 037FEEE8
	.byte 0xC0, 0x46	; 037FEEEA
pool_037FEEEC:
	.word P2_BssStart + 0x66C	; 037FEEEC
P2_Entry_037FEEF0:
	push {r4,r5,lr}	; 037FEEF0
	sub sp,#0x4	; 037FEEF2
	add r5,r0,#0x0	; 037FEEF4
	bl loc_037FDD34	; 037FEEF6
	add r4,r0,#0x0	; 037FEEFA
	mov r1,#0x1	; 037FEEFC
	str r1,[r5,#0x24]	; 037FEEFE
	ldr r1,[r5,#0x0]	; 037FEF00
	cmp r1,#0x0	; 037FEF02
	bne P2_Entry_037FEF0C	; 037FEF04
	bl loc_037FDD58	; 037FEF06
	b P2_Entry_037FEF1C	; 037FEF0A
P2_Entry_037FEF0C:
	add r0,r5,#0x0	; 037FEF0C
	bl P2_Entry_037FF05C	; 037FEF0E
	mov r0,#0x0	; 037FEF12
	str r0,[r5,#0x0]	; 037FEF14
	add r0,r4,#0x0	; 037FEF16
	bl loc_037FDD58	; 037FEF18
P2_Entry_037FEF1C:
	add sp,#0x4	; 037FEF1C
	pop {r4,r5}	; 037FEF1E
	pop {r3}	; 037FEF20
	bx r3	; 037FEF22

; ===== function loc_037FEF24 =====
loc_037FEF24:
	push {r4,r5,lr}	; 037FEF24
	sub sp,#0x4	; 037FEF26
	add r5,r0,#0x0	; 037FEF28
	add r4,r1,#0x0	; 037FEF2A
	cmp r4,#0x0	; 037FEF2C
	bne loc_037FEF34	; 037FEF2E
	bl loc_037FF228	; 037FEF30
loc_037FEF34:
	cmp r5,#0x0	; 037FEF34
	beq loc_037FEF3A	; 037FEF36
	str r4,[r5,#0x8]	; 037FEF38
loc_037FEF3A:
	add sp,#0x4	; 037FEF3A
	pop {r4,r5}	; 037FEF3C
	pop {r3}	; 037FEF3E
	bx r3	; 037FEF40
	.byte 0x00, 0x00	; 037FEF42
P2_Entry_037FEF44:
	push {r4,lr}	; 037FEF44
	add r4,r0,#0x0	; 037FEF46
	mov r0,#0x4	; 037FEF48
	ldr r1,[pool_037FEF84]	; 037FEF4A
	bl loc_037FDB68	; 037FEF4C
	mov r0,#0x10	; 037FEF50
	ldrsh r0,[r4,r0]	; 037FEF52
	ldr r1,[pool_037FEF88]	; 037FEF54
	add r2,r0,#0x0	; 037FEF56
	and r2,r1	; 037FEF58
	asr r4,r2,#0x1	; 037FEF5A
	ldr r2,[pool_037FEF8C]	; 037FEF5C
	ldrh r3,[r2,#0x0]	; 037FEF5E
	mov r1,#0x3f	; 037FEF60
	and r3,r1	; 037FEF62
	mov r1,#0xff	; 037FEF64
	and r0,r1	; 037FEF66
	lsl r0,r0,#0x8	; 037FEF68
	orr r3,r0	; 037FEF6A
	orr r4,r3	; 037FEF6C
	strh r4,[r2,#0x0]	; 037FEF6E
	ldrh r1,[r2,#0x0]	; 037FEF70
	mov r0,#0x20	; 037FEF72
	orr r1,r0	; 037FEF74
	strh r1,[r2,#0x0]	; 037FEF76
	mov r0,#0x4	; 037FEF78
	bl loc_037FDAE4	; 037FEF7A
	pop {r4}	; 037FEF7E
	pop {r3}	; 037FEF80
	bx r3	; 037FEF82
pool_037FEF84:
	.word P2_IrqHandler_037FEDA4 + 1	; 037FEF84
pool_037FEF88:
	.word 0x00000100	; 037FEF88
pool_037FEF8C:
	.word REG_DISPSTAT	; 037FEF8C
P2_Entry_037FEF90:
	push {r4,r5,r6,r7,lr}	; 037FEF90
	sub sp,#0xc	; 037FEF92
	add r5,r0,#0x0	; 037FEF94
	add r4,r1,#0x0	; 037FEF96
	add r6,r2,#0x0	; 037FEF98
	add r7,r3,#0x0	; 037FEF9A
	bl loc_037FDD34	; 037FEF9C
	str r0,[sp,#0x0]	; 037FEFA0
	cmp r5,#0x0	; 037FEFA2
	beq P2_Entry_037FEFAC	; 037FEFA4
	ldr r0,[r5,#0x0]	; 037FEFA6
	cmp r0,#0x0	; 037FEFA8
	beq P2_Entry_037FEFB0	; 037FEFAA
P2_Entry_037FEFAC:
	bl loc_037FF228	; 037FEFAC
P2_Entry_037FEFB0:
	ldr r0,[pool_037FEFEC]	; 037FEFB0
	ldrh r0,[r0,#0x0]	; 037FEFB2
	str r0,[sp,#0x4]	; 037FEFB4
	bl P2_Entry_037FED38	; 037FEFB6
	mov r1,#0x1	; 037FEFBA
	str r1,[r5,#0x1c]	; 037FEFBC
	strh r4,[r5,#0x10]	; 037FEFBE
	ldr r1,[sp,#0x4]	; 037FEFC0
	cmp r4,r1	; 037FEFC2
	bgt P2_Entry_037FEFC8	; 037FEFC4
	add r0,r0,#0x1	; 037FEFC6
P2_Entry_037FEFC8:
	str r0,[r5,#0xc]	; 037FEFC8
	strh r6,[r5,#0x12]	; 037FEFCA
	str r7,[r5,#0x0]	; 037FEFCC
	ldr r0,[sp,#0x20]	; 037FEFCE
	str r0,[r5,#0x4]	; 037FEFD0
	mov r0,#0x0	; 037FEFD2
	str r0,[r5,#0x24]	; 037FEFD4
	add r0,r5,#0x0	; 037FEFD6
	bl P2_Entry_037FF0AC	; 037FEFD8
	ldr r0,[sp,#0x0]	; 037FEFDC
	bl loc_037FDD58	; 037FEFDE
	add sp,#0xc	; 037FEFE2
	pop {r4,r5,r6,r7}	; 037FEFE4
	pop {r3}	; 037FEFE6
	bx r3	; 037FEFE8
	.byte 0xC0, 0x46	; 037FEFEA
pool_037FEFEC:
	.word REG_VCOUNT	; 037FEFEC
P2_Entry_037FEFF0:
	push {r4,r5,r6,r7,lr}	; 037FEFF0
	sub sp,#0xc	; 037FEFF2
	add r5,r0,#0x0	; 037FEFF4
	add r4,r1,#0x0	; 037FEFF6
	add r6,r2,#0x0	; 037FEFF8
	add r7,r3,#0x0	; 037FEFFA
	bl loc_037FDD34	; 037FEFFC
	str r0,[sp,#0x0]	; 037FF000
	cmp r5,#0x0	; 037FF002
	beq P2_Entry_037FF00C	; 037FF004
	ldr r0,[r5,#0x0]	; 037FF006
	cmp r0,#0x0	; 037FF008
	beq P2_Entry_037FF010	; 037FF00A
P2_Entry_037FF00C:
	bl loc_037FF228	; 037FF00C
P2_Entry_037FF010:
	ldr r0,[pool_037FF04C]	; 037FF010
	ldrh r0,[r0,#0x0]	; 037FF012
	str r0,[sp,#0x4]	; 037FF014
	bl P2_Entry_037FED38	; 037FF016
	mov r1,#0x0	; 037FF01A
	str r1,[r5,#0x1c]	; 037FF01C
	strh r4,[r5,#0x10]	; 037FF01E
	ldr r1,[sp,#0x4]	; 037FF020
	cmp r4,r1	; 037FF022
	bgt P2_Entry_037FF028	; 037FF024
	add r0,r0,#0x1	; 037FF026
P2_Entry_037FF028:
	str r0,[r5,#0xc]	; 037FF028
	strh r6,[r5,#0x12]	; 037FF02A
	str r7,[r5,#0x0]	; 037FF02C
	ldr r0,[sp,#0x20]	; 037FF02E
	str r0,[r5,#0x4]	; 037FF030
	mov r0,#0x0	; 037FF032
	str r0,[r5,#0x24]	; 037FF034
	add r0,r5,#0x0	; 037FF036
	bl P2_Entry_037FF0AC	; 037FF038
	ldr r0,[sp,#0x0]	; 037FF03C
	bl loc_037FDD58	; 037FF03E
	add sp,#0xc	; 037FF042
	pop {r4,r5,r6,r7}	; 037FF044
	pop {r3}	; 037FF046
	bx r3	; 037FF048
	.byte 0xC0, 0x46	; 037FF04A
pool_037FF04C:
	.word REG_VCOUNT	; 037FF04C

; ===== function loc_037FF050 =====
loc_037FF050:
	mov r1,#0x0	; 037FF050
	str r1,[r0,#0x0]	; 037FF052
	str r1,[r0,#0x8]	; 037FF054
	str r1,[r0,#0x20]	; 037FF056
	bx lr	; 037FF058
	.byte 0x00, 0x00	; 037FF05A
P2_Entry_037FF05C:
	cmp r0,#0x0	; 037FF05C
	beq P2_Entry_037FF07C	; 037FF05E
	ldr r2,[r0,#0x14]	; 037FF060
	ldr r1,[r0,#0x18]	; 037FF062
	cmp r1,#0x0	; 037FF064
	beq P2_Entry_037FF06C	; 037FF066
	str r2,[r1,#0x14]	; 037FF068
	b P2_Entry_037FF070	; 037FF06A
P2_Entry_037FF06C:
	ldr r0,[pool_037FF080]	; 037FF06C
	str r2,[r0,#0x4]	; 037FF06E
P2_Entry_037FF070:
	cmp r2,#0x0	; 037FF070
	beq P2_Entry_037FF078	; 037FF072
	str r1,[r2,#0x18]	; 037FF074
	bx lr	; 037FF076
P2_Entry_037FF078:
	ldr r0,[pool_037FF080]	; 037FF078
	str r1,[r0,#0x0]	; 037FF07A
P2_Entry_037FF07C:
	bx lr	; 037FF07C
	.byte 0xC0, 0x46	; 037FF07E
pool_037FF080:
	.word P2_BssStart + 0x66C	; 037FF080
P2_Entry_037FF084:
	push {lr}	; 037FF084
	sub sp,#0x4	; 037FF086
	ldr r1,[pool_037FF0A8]	; 037FF088
	ldr r3,[r1,#0x4]	; 037FF08A
	str r3,[r0,#0x14]	; 037FF08C
	mov r2,#0x0	; 037FF08E
	str r2,[r0,#0x18]	; 037FF090
	str r0,[r1,#0x4]	; 037FF092
	cmp r3,#0x0	; 037FF094
	beq P2_Entry_037FF09C	; 037FF096
	str r0,[r3,#0x18]	; 037FF098
	b P2_Entry_037FF0A2	; 037FF09A
P2_Entry_037FF09C:
	str r0,[r1,#0x0]	; 037FF09C
	bl P2_Entry_037FEF44	; 037FF09E
P2_Entry_037FF0A2:
	add sp,#0x4	; 037FF0A2
	pop {r3}	; 037FF0A4
	bx r3	; 037FF0A6
pool_037FF0A8:
	.word P2_BssStart + 0x66C	; 037FF0A8
P2_Entry_037FF0AC:
	push {r4,lr}	; 037FF0AC
	ldr r1,[pool_037FF0F4]	; 037FF0AE
	ldr r1,[r1,#0x0]	; 037FF0B0
	mov r2,#0x10	; 037FF0B2
	b P2_Entry_037FF0E6	; 037FF0B4
P2_Entry_037FF0B6:
	ldr r4,[r0,#0xc]	; 037FF0B6
	ldr r3,[r1,#0xc]	; 037FF0B8
	cmp r3,r4	; 037FF0BA
	bcc P2_Entry_037FF0E4	; 037FF0BC
	cmp r3,r4	; 037FF0BE
	bne P2_Entry_037FF0CA	; 037FF0C0
	ldrsh r4,[r1,r2]	; 037FF0C2
	ldrsh r3,[r0,r2]	; 037FF0C4
	cmp r4,r3	; 037FF0C6
	ble P2_Entry_037FF0E4	; 037FF0C8
P2_Entry_037FF0CA:
	ldr r2,[r1,#0x14]	; 037FF0CA
	str r2,[r0,#0x14]	; 037FF0CC
	str r1,[r0,#0x18]	; 037FF0CE
	str r0,[r1,#0x14]	; 037FF0D0
	cmp r2,#0x0	; 037FF0D2
	beq P2_Entry_037FF0DA	; 037FF0D4
	str r0,[r2,#0x18]	; 037FF0D6
	b P2_Entry_037FF0EE	; 037FF0D8
P2_Entry_037FF0DA:
	ldr r1,[pool_037FF0F4]	; 037FF0DA
	str r0,[r1,#0x0]	; 037FF0DC
	bl P2_Entry_037FEF44	; 037FF0DE
	b P2_Entry_037FF0EE	; 037FF0E2
P2_Entry_037FF0E4:
	ldr r1,[r1,#0x18]	; 037FF0E4
P2_Entry_037FF0E6:
	cmp r1,#0x0	; 037FF0E6
	bne P2_Entry_037FF0B6	; 037FF0E8
	bl P2_Entry_037FF084	; 037FF0EA
P2_Entry_037FF0EE:
	pop {r4}	; 037FF0EE
	pop {r3}	; 037FF0F0
	bx r3	; 037FF0F2
pool_037FF0F4:
	.word P2_BssStart + 0x66C	; 037FF0F4

; ===== function loc_037FF0F8 =====
loc_037FF0F8:
	ldr r0,[pool_037FF100]	; 037FF0F8
	ldrh r0,[r0,#0x0]	; 037FF0FA
	bx lr	; 037FF0FC
	.byte 0xC0, 0x46	; 037FF100
pool_037FF100:
loc_037FF100:
	.word P2_BssStart + 0x660	; 037FF100

; ===== function loc_037FF104 =====
loc_037FF104:
	push {lr}	; 037FF104
	sub sp,#0x4	; 037FF106
	ldr r0,[pool_037FF134]	; 037FF108
	ldrh r1,[r0,#0x0]	; 037FF10A
	cmp r1,#0x0	; 037FF10C
	bne loc_037FF12C	; 037FF10E
	mov r1,#0x1	; 037FF110
	strh r1,[r0,#0x0]	; 037FF112
	mov r1,#0x0	; 037FF114
	ldr r0,[pool_037FF138]	; 037FF116
	str r1,[r0,#0x0]	; 037FF118
	str r1,[r0,#0x4]	; 037FF11A
	mov r0,#0x4	; 037FF11C
	bl loc_037FDAB8	; 037FF11E
	mov r1,#0x0	; 037FF122
	ldr r0,[pool_037FF13C]	; 037FF124
	str r1,[r0,#0x0]	; 037FF126
	ldr r0,[pool_037FF140]	; 037FF128
	str r1,[r0,#0x0]	; 037FF12A
loc_037FF12C:
	add sp,#0x4	; 037FF12C
	pop {r3}	; 037FF12E
	bx r3	; 037FF130
	.byte 0xC0, 0x46	; 037FF134
pool_037FF134:
loc_037FF134:
	.word P2_BssStart + 0x660	; 037FF134
pool_037FF138:
loc_037FF138:
	.word P2_BssStart + 0x66C	; 037FF138
pool_037FF13C:
loc_037FF13C:
	.word P2_BssStart + 0x668	; 037FF13C
pool_037FF140:
loc_037FF140:
	.word P2_BssStart + 0x664	; 037FF140
.arm

; ===== function loc_037FF144 =====
loc_037FF144:
	mrs r0,cpsr	; 037FF144
	bic r1,r0,#0x80	; 037FF148
	msr cpsr_c,r1	; 037FF14C
	and r0,r0,#0x80	; 037FF150
	bx lr	; 037FF154

; ===== function loc_037FF158 =====
loc_037FF158:
	mrs r0,cpsr	; 037FF158
	orr r1,r0,#0x80	; 037FF15C
	msr cpsr_c,r1	; 037FF160
	and r0,r0,#0x80	; 037FF164
	bx lr	; 037FF168

; ===== function loc_037FF16C =====
loc_037FF16C:
	mrs r1,cpsr	; 037FF16C
	bic r2,r1,#0x80	; 037FF170
	orr r2,r2,r0	; 037FF174
	msr cpsr_c,r2	; 037FF178
	and r0,r1,#0x80	; 037FF17C
	bx lr	; 037FF180

; ===== function loc_037FF184 =====
loc_037FF184:
	mrs r0,cpsr	; 037FF184
	orr r1,r0,#0xc0	; 037FF188
	msr cpsr_c,r1	; 037FF18C
	and r0,r0,#0xc0	; 037FF190
	bx lr	; 037FF194

; ===== function loc_037FF198 =====
loc_037FF198:
	mrs r1,cpsr	; 037FF198
	bic r2,r1,#0xc0	; 037FF19C
	orr r2,r2,r0	; 037FF1A0
	msr cpsr_c,r2	; 037FF1A4
	and r0,r1,#0xc0	; 037FF1A8
	bx lr	; 037FF1AC

; ===== function loc_037FF1B0 =====
loc_037FF1B0:
	mrs r0,cpsr	; 037FF1B0
	and r0,r0,#0x1f	; 037FF1B4
	bx lr	; 037FF1B8
.thumb

; ===== function loc_037FF1BC =====
loc_037FF1BC:
	push {r4,r5,r6,r7,lr}	; 037FF1BC
	sub sp,#0x4	; 037FF1BE
	add r6,r0,#0x0	; 037FF1C0
	add r5,r1,#0x0	; 037FF1C2
	bl loc_037FDD34	; 037FF1C4
	add r7,r0,#0x0	; 037FF1C8
	ldr r1,[pool_037FF214]	; 037FF1CA
	ldrh r4,[r1,#0x0]	; 037FF1CC
	mov r0,#0x1	; 037FF1CE
	strh r0,[r1,#0x0]	; 037FF1D0
	cmp r6,#0x0	; 037FF1D2
	beq loc_037FF1EC	; 037FF1D4
	ldr r1,[pool_037FF218]	; 037FF1D6
	ldr r0,[r1,#0x0]	; 037FF1D8
	bic r0,r5	; 037FF1DA
	str r0,[r1,#0x0]	; 037FF1DC
	b loc_037FF1EC	; 037FF1DE
loc_037FF1E0:
	bl loc_03804936	; 037FF1E0
	bl loc_037FB04C	; 037FF1E4
	bl loc_037FDD34	; 037FF1E8
loc_037FF1EC:
	ldr r1,[pool_037FF218]	; 037FF1EC
	ldr r0,[r1,#0x0]	; 037FF1EE
	add r2,r5,#0x0	; 037FF1F0
	and r2,r0	; 037FF1F2
	cmp r2,#0x0	; 037FF1F4
	beq loc_037FF1E0	; 037FF1F6
	ldr r0,[r1,#0x0]	; 037FF1F8
	bic r0,r5	; 037FF1FA
	str r0,[r1,#0x0]	; 037FF1FC
	ldr r1,[pool_037FF214]	; 037FF1FE
	ldrh r0,[r1,#0x0]	; 037FF200
	strh r4,[r1,#0x0]	; 037FF202
	add r0,r7,#0x0	; 037FF204
	bl loc_037FDD58	; 037FF206
	add sp,#0x4	; 037FF20A
	pop {r4,r5,r6,r7}	; 037FF20C
	pop {r3}	; 037FF20E
	bx r3	; 037FF210
	.byte 0xC0, 0x46	; 037FF214
pool_037FF214:
loc_037FF214:
	.word REG_IME	; 037FF214
pool_037FF218:
loc_037FF218:
	.word Bios7IrqFlagsAddress	; 037FF218

; ===== function loc_037FF21C =====
loc_037FF21C:
	lsr r0,r0,#0x2	; 037FF21C
	ldr r3,[pool_037FF224]	; 037FF21E
	bx r3	; 037FF220
	.byte 0xC0, 0x46	; 037FF224
pool_037FF224:
loc_037FF224:
	.word P2_SwiWaitByLoop + 1	; 037FF224

; ===== function loc_037FF228 =====
loc_037FF228:
	push {lr}	; 037FF228
	sub sp,#0x4	; 037FF22A
loc_037FF22C:
	bl loc_037FDD34	; 037FF22C
	bl loc_03804936	; 037FF230
	b loc_037FF22C	; 037FF234
	.byte 0x00, 0x00	; 037FF238

; ===== function loc_037FF238 =====
loc_037FF238:
	push {r4,lr}	; 037FF238
	add r4,r0,#0x0	; 037FF23A
	bl loc_037FDD34	; 037FF23C
	mov r1,#0x6	; 037FF240
	mul r4,r1	; 037FF242
	add r1,r4,#0x5	; 037FF244
	lsl r2,r1,#0x1	; 037FF246
	ldr r1,[pool_037FF26C]	; 037FF248
	add r2,r2,r1	; 037FF24A
	ldrh r3,[r2,#0x0]	; 037FF24C
	ldr r1,[pool_037FF270]	; 037FF24E
	and r3,r1	; 037FF250
	strh r3,[r2,#0x0]	; 037FF252
	ldrh r3,[r2,#0x0]	; 037FF254
	ldr r1,[pool_037FF274]	; 037FF256
	and r3,r1	; 037FF258
	strh r3,[r2,#0x0]	; 037FF25A
	ldrh r1,[r2,#0x0]	; 037FF25C
	ldrh r1,[r2,#0x0]	; 037FF25E
	bl loc_037FDD58	; 037FF260
	pop {r4}	; 037FF264
	pop {r3}	; 037FF266
	bx r3	; 037FF268
	.byte 0xC0, 0x46	; 037FF26C
pool_037FF26C:
loc_037FF26C:
	.word REG_DMA0SAD	; 037FF26C
pool_037FF270:
loc_037FF270:
	.word 0xFFFFCDFF	; 037FF270
pool_037FF274:
loc_037FF274:
	.word 0xFFFF7FFF	; 037FF274
P2_Entry_037FF278:
	mov r1,#0x3	; 037FF278
	mul r0,r1	; 037FF27A
	add r0,r0,#0x2	; 037FF27C
	lsl r1,r0,#0x2	; 037FF27E
	ldr r0,[pool_037FF290]	; 037FF280
	add r2,r1,r0	; 037FF282
	ldr r0,[pool_037FF294]	; 037FF284
P2_Entry_037FF286:
	ldr r1,[r2,#0x0]	; 037FF286
	and r1,r0	; 037FF288
	cmp r1,#0x0	; 037FF28A
	bne P2_Entry_037FF286	; 037FF28C
	bx lr	; 037FF28E
pool_037FF290:
	.word REG_DMA0SAD	; 037FF290
pool_037FF294:
	.word 0x80000000	; 037FF294
P2_Entry_037FF298:
	push {r4,r5,r6,r7,lr}	; 037FF298
	sub sp,#0x4	; 037FF29A
	add r5,r0,#0x0	; 037FF29C
	add r6,r1,#0x0	; 037FF29E
	add r7,r2,#0x0	; 037FF2A0
	str r3,[sp,#0x0]	; 037FF2A2
	cmp r3,#0x0	; 037FF2A4
	beq P2_Entry_037FF2EA	; 037FF2A6
	mov r0,#0x3	; 037FF2A8
	add r1,r5,#0x0	; 037FF2AA
	mul r1,r0	; 037FF2AC
	add r0,r1,#0x2	; 037FF2AE
	lsl r1,r0,#0x2	; 037FF2B0
	ldr r0,[pool_037FF2F4]	; 037FF2B2
	add r4,r1,r0	; 037FF2B4
	ldr r0,[pool_037FF2F8]	; 037FF2B6
P2_Entry_037FF2B8:
	ldr r1,[r4,#0x0]	; 037FF2B8
	and r1,r0	; 037FF2BA
	cmp r1,#0x0	; 037FF2BC
	bne P2_Entry_037FF2B8	; 037FF2BE
	bl loc_037FDD34	; 037FF2C0
	mov r1,#0xc	; 037FF2C4
	mul r5,r1	; 037FF2C6
	ldr r1,[pool_037FF2F4]	; 037FF2C8
	add r2,r5,r1	; 037FF2CA
	str r6,[r2,#0x0]	; 037FF2CC
	str r7,[r2,#0x4]	; 037FF2CE
	ldr r3,[sp,#0x0]	; 037FF2D0
	lsr r5,r3,#0x1	; 037FF2D2
	ldr r3,[pool_037FF2F8]	; 037FF2D4
	orr r5,r3	; 037FF2D6
	str r5,[r2,#0x8]	; 037FF2D8
	ldr r1,[r1,#0x0]	; 037FF2DA
	bl loc_037FDD58	; 037FF2DC
	ldr r0,[pool_037FF2F8]	; 037FF2E0
P2_Entry_037FF2E2:
	ldr r1,[r4,#0x0]	; 037FF2E2
	and r1,r0	; 037FF2E4
	cmp r1,#0x0	; 037FF2E6
	bne P2_Entry_037FF2E2	; 037FF2E8
P2_Entry_037FF2EA:
	add sp,#0x4	; 037FF2EA
	pop {r4,r5,r6,r7}	; 037FF2EC
	pop {r3}	; 037FF2EE
	bx r3	; 037FF2F0
	.byte 0xC0, 0x46	; 037FF2F2
pool_037FF2F4:
	.word REG_DMA0SAD	; 037FF2F4
pool_037FF2F8:
	.word 0x80000000	; 037FF2F8
P2_Entry_037FF2FC:
	push {r4,r5,r6,r7,lr}	; 037FF2FC
	sub sp,#0x4	; 037FF2FE
	add r5,r0,#0x0	; 037FF300
	add r6,r1,#0x0	; 037FF302
	add r7,r2,#0x0	; 037FF304
	str r3,[sp,#0x0]	; 037FF306
	cmp r3,#0x0	; 037FF308
	beq P2_Entry_037FF356	; 037FF30A
	mov r0,#0x3	; 037FF30C
	add r1,r5,#0x0	; 037FF30E
	mul r1,r0	; 037FF310
	add r0,r1,#0x2	; 037FF312
	lsl r1,r0,#0x2	; 037FF314
	ldr r0,[pool_037FF360]	; 037FF316
	add r4,r1,r0	; 037FF318
	ldr r0,[pool_037FF364]	; 037FF31A
P2_Entry_037FF31C:
	ldr r1,[r4,#0x0]	; 037FF31C
	and r1,r0	; 037FF31E
	cmp r1,#0x0	; 037FF320
	bne P2_Entry_037FF31C	; 037FF322
	bl loc_037FDD34	; 037FF324
	lsl r2,r5,#0x2	; 037FF328
	ldr r1,[pool_037FF368]	; 037FF32A
	add r1,r2,r1	; 037FF32C
	str r7,[r1,#0x0]	; 037FF32E
	mov r2,#0xc	; 037FF330
	mul r5,r2	; 037FF332
	ldr r2,[pool_037FF360]	; 037FF334
	add r3,r5,r2	; 037FF336
	str r1,[r3,#0x0]	; 037FF338
	str r6,[r3,#0x4]	; 037FF33A
	ldr r1,[sp,#0x0]	; 037FF33C
	lsr r5,r1,#0x1	; 037FF33E
	ldr r1,[pool_037FF36C]	; 037FF340
	orr r5,r1	; 037FF342
	str r5,[r3,#0x8]	; 037FF344
	ldr r1,[r2,#0x0]	; 037FF346
	bl loc_037FDD58	; 037FF348
	ldr r0,[pool_037FF364]	; 037FF34C
P2_Entry_037FF34E:
	ldr r1,[r4,#0x0]	; 037FF34E
	and r1,r0	; 037FF350
	cmp r1,#0x0	; 037FF352
	bne P2_Entry_037FF34E	; 037FF354
P2_Entry_037FF356:
	add sp,#0x4	; 037FF356
	pop {r4,r5,r6,r7}	; 037FF358
	pop {r3}	; 037FF35A
	bx r3	; 037FF35C
	.byte 0xC0, 0x46	; 037FF35E
pool_037FF360:
	.word REG_DMA0SAD	; 037FF360
pool_037FF364:
	.word 0x80000000	; 037FF364
pool_037FF368:
	.word 0x0380FFE0	; 037FF368
pool_037FF36C:
	.word 0x81000000	; 037FF36C
.arm

; ===== function loc_037FF370 =====
loc_037FF370:
	mov r3,#0x0	; 037FF370
loc_037FF374:
	cmp r3,r2	; 037FF374
	strlth r0,[r1,r3]	; 037FF378
	addlt r3,r3,#0x2	; 037FF37C
	blt loc_037FF374	; 037FF380
	bx lr	; 037FF384
P2_Entry_037FF388:
	mov r12,#0x0	; 037FF388
P2_Entry_037FF38C:
	cmp r12,r2	; 037FF38C
	ldrlth r3,[r0,r12]	; 037FF390
	strlth r3,[r1,r12]	; 037FF394
	addlt r12,r12,#0x2	; 037FF398
	blt P2_Entry_037FF38C	; 037FF39C
	bx lr	; 037FF3A0

; ===== function loc_037FF3A4 =====
loc_037FF3A4:
	add r12,r1,r2	; 037FF3A4
loc_037FF3A8:
	cmp r1,r12	; 037FF3A8
	stmltia r1!,{r0}	; 037FF3AC
	blt loc_037FF3A8	; 037FF3B0
	bx lr	; 037FF3B4

; ===== function loc_037FF3B8 =====
loc_037FF3B8:
	add r12,r1,r2	; 037FF3B8
loc_037FF3BC:
	cmp r1,r12	; 037FF3BC
	ldmltia r0!,{r2}	; 037FF3C0
	stmltia r1!,{r2}	; 037FF3C4
	blt loc_037FF3BC	; 037FF3C8
	bx lr	; 037FF3CC
P2_Entry_037FF3D0:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 037FF3D0
	add r9,r1,r2	; 037FF3D4
	mov r12,r2, lsr #0x5	; 037FF3D8
	add r12,r1,r12, lsl #0x5	; 037FF3DC
	mov r2,r0	; 037FF3E0
	mov r3,r2	; 037FF3E4
	mov r4,r2	; 037FF3E8
	mov r5,r2	; 037FF3EC
	mov r6,r2	; 037FF3F0
	mov r7,r2	; 037FF3F4
	mov r8,r2	; 037FF3F8
P2_Entry_037FF3FC:
	cmp r1,r12	; 037FF3FC
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 037FF400
	blt P2_Entry_037FF3FC	; 037FF404
P2_Entry_037FF408:
	cmp r1,r9	; 037FF408
	stmltia r1!,{r0}	; 037FF40C
	blt P2_Entry_037FF408	; 037FF410
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 037FF414
	bx lr	; 037FF418

; ===== function loc_037FF41C =====
loc_037FF41C:
	mov r12,#0x0	; 037FF41C
loc_037FF420:
	cmp r12,r2	; 037FF420
	strltb r1,[r0,r12]	; 037FF424
	addlt r12,r12,#0x1	; 037FF428
	blt loc_037FF420	; 037FF42C
	bx lr	; 037FF430
P2_Entry_037FF434:
	mov r12,#0x0	; 037FF434
P2_Entry_037FF438:
	cmp r12,r2	; 037FF438
	ldrltb r3,[r0,r12]	; 037FF43C
	strltb r3,[r1,r12]	; 037FF440
	addlt r12,r12,#0x1	; 037FF444
	blt P2_Entry_037FF438	; 037FF448
	bx lr	; 037FF44C

; ===== function loc_037FF450 =====
loc_037FF450:
	swp r0,r0,[r1]	; 037FF450
	bx lr	; 037FF454
.thumb

; ===== function loc_037FF458 =====
loc_037FF458:
	push {r4,r5,r6,lr}	; 037FF458
	ldr r4,[pool_037FF488]	; 037FF45A
	ldrb r5,[r4,#0x0]	; 037FF45C
	mov r4,#0x80	; 037FF45E
	and r5,r4	; 037FF460
	cmp r5,#0x0	; 037FF462
	beq loc_037FF46A	; 037FF464
	mov r6,#0x1	; 037FF466
	b loc_037FF46C	; 037FF468
loc_037FF46A:
	mov r6,#0x0	; 037FF46A
loc_037FF46C:
	lsl r5,r1,#0x2	; 037FF46C
	lsl r4,r2,#0x4	; 037FF46E
	lsl r2,r6,#0x7	; 037FF470
	lsl r1,r3,#0x5	; 037FF472
	orr r2,r1	; 037FF474
	orr r4,r2	; 037FF476
	orr r5,r4	; 037FF478
	orr r0,r5	; 037FF47A
	ldr r1,[pool_037FF488]	; 037FF47C
	strb r0,[r1,#0x0]	; 037FF47E
	pop {r4,r5,r6}	; 037FF480
	pop {r3}	; 037FF482
	bx r3	; 037FF484
	.byte 0xC0, 0x46	; 037FF488
pool_037FF488:
loc_037FF488:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF488

; ===== function loc_037FF48C =====
loc_037FF48C:
	ldr r1,[pool_037FF494]	; 037FF48C
	strb r0,[r1,#0x0]	; 037FF48E
	bx lr	; 037FF490
	.byte 0xC0, 0x46	; 037FF494
pool_037FF494:
loc_037FF494:
	.word REG_SOUNDCNT_ARM7	; 037FF494
P2_Entry_037FF498:
	push {lr}	; 037FF498
	sub sp,#0x4	; 037FF49A
	ldr r2,[pool_037FF4C0]	; 037FF49C
	ldrh r1,[r2,#0x0]	; 037FF49E
	mov r0,#0x1	; 037FF4A0
	orr r1,r0	; 037FF4A2
	strh r1,[r2,#0x0]	; 037FF4A4
	bl loc_0380447C	; 037FF4A6
	ldr r0,[pool_037FF4C4]	; 037FF4AA
	bl P2_SwiSoundBiasIncrease	; 037FF4AC
	ldr r0,[pool_037FF4C8]	; 037FF4B0
	bl loc_037FF21C	; 037FF4B2
	bl P2_Entry_037FF510	; 037FF4B6
	add sp,#0x4	; 037FF4BA
	pop {r3}	; 037FF4BC
	bx r3	; 037FF4BE
pool_037FF4C0:
	.word REG_POWERCNT_ARM7	; 037FF4C0
pool_037FF4C4:
	.word 0x00000100	; 037FF4C4
pool_037FF4C8:
	.word 0x0007AB80	; 037FF4C8
P2_Entry_037FF4CC:
	push {lr}	; 037FF4CC
	sub sp,#0x4	; 037FF4CE
	bl P2_Entry_037FF500	; 037FF4D0
	mov r0,#0x80	; 037FF4D4
	bl P2_SwiSoundBiasDecrease	; 037FF4D6
	ldr r0,[pool_037FF4F8]	; 037FF4DA
	bl loc_037FF21C	; 037FF4DC
	mov r0,#0x1	; 037FF4E0
	bl loc_03804460	; 037FF4E2
	ldr r2,[pool_037FF4FC]	; 037FF4E6
	ldrh r1,[r2,#0x0]	; 037FF4E8
	mov r0,#0x1	; 037FF4EA
	bic r1,r0	; 037FF4EC
	strh r1,[r2,#0x0]	; 037FF4EE
	add sp,#0x4	; 037FF4F0
	pop {r3}	; 037FF4F2
	bx r3	; 037FF4F4
	.byte 0xC0, 0x46	; 037FF4F6
pool_037FF4F8:
	.word 0x00040000	; 037FF4F8
pool_037FF4FC:
	.word REG_POWERCNT_ARM7	; 037FF4FC
P2_Entry_037FF500:
	ldr r2,[pool_037FF50C]	; 037FF500
	ldrb r1,[r2,#0x0]	; 037FF502
	mov r0,#0x80	; 037FF504
	bic r1,r0	; 037FF506
	strb r1,[r2,#0x0]	; 037FF508
	bx lr	; 037FF50A
pool_037FF50C:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF50C
P2_Entry_037FF510:
	ldr r2,[pool_037FF51C]	; 037FF510
	ldrb r1,[r2,#0x0]	; 037FF512
	mov r0,#0x80	; 037FF514
	orr r1,r0	; 037FF516
	strb r1,[r2,#0x0]	; 037FF518
	bx lr	; 037FF51A
pool_037FF51C:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF51C

; ===== function loc_037FF520 =====
loc_037FF520:
	push {r4,lr}	; 037FF520
	cmp r1,#0x18	; 037FF522
	bge loc_037FF53C	; 037FF524
	ldr r2,[pool_037FF55C]	; 037FF526
	ldr r3,[r2,#0x0]	; 037FF528
	ldr r2,[pool_037FF560]	; 037FF52A
	sub r2,r2,r3	; 037FF52C
	lsl r2,r2,#0x6	; 037FF52E
	add r1,#0x28	; 037FF530
	mul r3,r1	; 037FF532
	add r1,r2,r3	; 037FF534
	mul r0,r1	; 037FF536
	asr r0,r0,#0x15	; 037FF538
	b loc_037FF556	; 037FF53A
loc_037FF53C:
	cmp r1,#0x68	; 037FF53C
	ble loc_037FF556	; 037FF53E
	ldr r2,[pool_037FF55C]	; 037FF540
	ldr r4,[r2,#0x0]	; 037FF542
	ldr r2,[pool_037FF560]	; 037FF544
	add r2,r4,r2	; 037FF546
	lsl r3,r2,#0x6	; 037FF548
	neg r2,r4	; 037FF54A
	sub r1,#0x28	; 037FF54C
	mul r2,r1	; 037FF54E
	add r1,r3,r2	; 037FF550
	mul r0,r1	; 037FF552
	asr r0,r0,#0x15	; 037FF554
loc_037FF556:
	pop {r4}	; 037FF556
	pop {r3}	; 037FF558
	bx r3	; 037FF55A
pool_037FF55C:
loc_037FF55C:
	.word P2_BssStart + 0x674	; 037FF55C
pool_037FF560:
loc_037FF560:
	.word 0x00007FFF	; 037FF560

; ===== function loc_037FF564 =====
loc_037FF564:
	push {r4,r5,r6,r7,lr}	; 037FF564
	sub sp,#0x4	; 037FF566
	ldr r1,[pool_037FF59C]	; 037FF568
	str r0,[r1,#0x0]	; 037FF56A
	mov r5,#0x0	; 037FF56C
	ldr r6,[pool_037FF5A0]	; 037FF56E
	ldr r7,[pool_037FF5A4]	; 037FF570
loc_037FF572:
	mov r0,#0x1	; 037FF572
	lsl r0,r5	; 037FF574
	and r0,r7	; 037FF576
	cmp r0,#0x0	; 037FF578
	beq loc_037FF58C	; 037FF57A
	lsl r4,r5,#0x4	; 037FF57C
	ldr r0,[pool_037FF5A8]	; 037FF57E
	ldrb r1,[r4,r0]	; 037FF580
	ldrb r0,[r6,r5]	; 037FF582
	bl loc_037FF520	; 037FF584
	ldr r1,[pool_037FF5AC]	; 037FF588
	strb r0,[r4,r1]	; 037FF58A
loc_037FF58C:
	add r5,r5,#0x1	; 037FF58C
	cmp r5,#0x10	; 037FF58E
	blt loc_037FF572	; 037FF590
	add sp,#0x4	; 037FF592
	pop {r4,r5,r6,r7}	; 037FF594
	pop {r3}	; 037FF596
	bx r3	; 037FF598
	.byte 0xC0, 0x46	; 037FF59C
pool_037FF59C:
loc_037FF59C:
	.word P2_BssStart + 0x674	; 037FF59C
pool_037FF5A0:
loc_037FF5A0:
	.word 0x03805A58	; 037FF5A0
pool_037FF5A4:
loc_037FF5A4:
	.word 0x0000FFF5	; 037FF5A4
pool_037FF5A8:
loc_037FF5A8:
	.word SCHANNEL0_PAN	; 037FF5A8
pool_037FF5AC:
loc_037FF5AC:
	.word SCHANNEL0_CR	; 037FF5AC

; ===== function loc_037FF5B0 =====
loc_037FF5B0:
	lsl r1,r0,#0x4	; 037FF5B0
	ldr r0,[pool_037FF5C8]	; 037FF5B2
	ldrb r1,[r1,r0]	; 037FF5B4
	mov r0,#0x80	; 037FF5B6
	and r1,r0	; 037FF5B8
	cmp r1,#0x0	; 037FF5BA
	beq loc_037FF5C2	; 037FF5BC
	mov r0,#0x1	; 037FF5BE
	bx lr	; 037FF5C0
loc_037FF5C2:
	mov r0,#0x0	; 037FF5C2
	bx lr	; 037FF5C4
	.byte 0xC0, 0x46	; 037FF5C8
pool_037FF5C8:
loc_037FF5C8:
	.word SCHANNEL0_CR + 3	; 037FF5C8

; ===== function loc_037FF5CC =====
loc_037FF5CC:
	push {r4,lr}	; 037FF5CC
	lsl r4,r0,#0x4	; 037FF5CE
	ldr r2,[pool_037FF5FC]	; 037FF5D0
	strb r1,[r4,r2]	; 037FF5D2
	ldr r2,[pool_037FF600]	; 037FF5D4
	ldr r2,[r2,#0x0]	; 037FF5D6
	cmp r2,#0x0	; 037FF5D8
	ble loc_037FF5F4	; 037FF5DA
	mov r3,#0x1	; 037FF5DC
	lsl r3,r0	; 037FF5DE
	ldr r2,[pool_037FF604]	; 037FF5E0
	and r3,r2	; 037FF5E2
	cmp r3,#0x0	; 037FF5E4
	beq loc_037FF5F4	; 037FF5E6
	ldr r2,[pool_037FF608]	; 037FF5E8
	ldrb r0,[r2,r0]	; 037FF5EA
	bl loc_037FF520	; 037FF5EC
	ldr r1,[pool_037FF60C]	; 037FF5F0
	strb r0,[r4,r1]	; 037FF5F2
loc_037FF5F4:
	pop {r4}	; 037FF5F4
	pop {r3}	; 037FF5F6
	bx r3	; 037FF5F8
	.byte 0xC0, 0x46	; 037FF5FC
pool_037FF5FC:
loc_037FF5FC:
	.word SCHANNEL0_PAN	; 037FF5FC
pool_037FF600:
loc_037FF600:
	.word P2_BssStart + 0x674	; 037FF600
pool_037FF604:
loc_037FF604:
	.word 0x0000FFF5	; 037FF604
pool_037FF608:
loc_037FF608:
	.word P2_BssStart + 0x678	; 037FF608
pool_037FF60C:
loc_037FF60C:
	.word SCHANNEL0_CR	; 037FF60C

; ===== function loc_037FF610 =====
loc_037FF610:
	ldr r2,[pool_037FF61C]	; 037FF610
	sub r2,r2,r1	; 037FF612
	lsl r1,r0,#0x4	; 037FF614
	ldr r0,[pool_037FF620]	; 037FF616
	strh r2,[r1,r0]	; 037FF618
	bx lr	; 037FF61A
pool_037FF61C:
loc_037FF61C:
	.word 0x00010000	; 037FF61C
pool_037FF620:
loc_037FF620:
	.word SCHANNEL0_TIMER	; 037FF620

; ===== function loc_037FF624 =====
loc_037FF624:
	push {r4,r5,lr}	; 037FF624
	sub sp,#0x4	; 037FF626
	add r5,r0,#0x0	; 037FF628
	add r4,r2,#0x0	; 037FF62A
	ldr r0,[pool_037FF668]	; 037FF62C
	strb r1,[r0,r5]	; 037FF62E
	ldr r0,[pool_037FF66C]	; 037FF630
	ldr r0,[r0,#0x0]	; 037FF632
	cmp r0,#0x0	; 037FF634
	ble loc_037FF654	; 037FF636
	mov r2,#0x1	; 037FF638
	lsl r2,r5	; 037FF63A
	ldr r0,[pool_037FF670]	; 037FF63C
	and r2,r0	; 037FF63E
	cmp r2,#0x0	; 037FF640
	beq loc_037FF654	; 037FF642
	lsl r2,r5,#0x4	; 037FF644
	ldr r0,[pool_037FF674]	; 037FF646
	ldrb r2,[r2,r0]	; 037FF648
	add r0,r1,#0x0	; 037FF64A
	add r1,r2,#0x0	; 037FF64C
	bl loc_037FF520	; 037FF64E
	add r1,r0,#0x0	; 037FF652
loc_037FF654:
	lsl r2,r4,#0x8	; 037FF654
	orr r2,r1	; 037FF656
	lsl r1,r5,#0x4	; 037FF658
	ldr r0,[pool_037FF678]	; 037FF65A
	strh r2,[r1,r0]	; 037FF65C
	add sp,#0x4	; 037FF65E
	pop {r4,r5}	; 037FF660
	pop {r3}	; 037FF662
	bx r3	; 037FF664
	.byte 0xC0, 0x46	; 037FF668
pool_037FF668:
loc_037FF668:
	.word P2_BssStart + 0x678	; 037FF668
pool_037FF66C:
loc_037FF66C:
	.word P2_BssStart + 0x674	; 037FF66C
pool_037FF670:
loc_037FF670:
	.word 0x0000FFF5	; 037FF670
pool_037FF674:
loc_037FF674:
	.word SCHANNEL0_PAN	; 037FF674
pool_037FF678:
loc_037FF678:
	.word SCHANNEL0_CR	; 037FF678

; ===== function loc_037FF67C =====
loc_037FF67C:
	lsl r2,r0,#0x4	; 037FF67C
	ldr r0,[pool_037FF698]	; 037FF67E
	add r3,r2,r0	; 037FF680
	ldr r2,[r3,#0x0]	; 037FF682
	ldr r0,[pool_037FF69C]	; 037FF684
	and r2,r0	; 037FF686
	mov r0,#0x1	; 037FF688
	and r1,r0	; 037FF68A
	cmp r1,#0x0	; 037FF68C
	beq loc_037FF694	; 037FF68E
	ldr r0,[pool_037FF6A0]	; 037FF690
	orr r2,r0	; 037FF692
loc_037FF694:
	str r2,[r3,#0x0]	; 037FF694
	bx lr	; 037FF696
pool_037FF698:
loc_037FF698:
	.word SCHANNEL0_CR	; 037FF698
pool_037FF69C:
loc_037FF69C:
	.word 0x7FFFFFFF	; 037FF69C
pool_037FF6A0:
loc_037FF6A0:
	.word 0x00008000	; 037FF6A0

; ===== function loc_037FF6A4 =====
loc_037FF6A4:
	push {r4,r5,r6,lr}	; 037FF6A4
	add r5,r2,#0x0	; 037FF6A6
	add r6,r3,#0x0	; 037FF6A8
	lsl r4,r0,#0x4	; 037FF6AA
	ldr r2,[pool_037FF6F0]	; 037FF6AC
	strb r1,[r2,r0]	; 037FF6AE
	ldr r2,[pool_037FF6F4]	; 037FF6B0
	ldr r2,[r2,#0x0]	; 037FF6B2
	cmp r2,#0x0	; 037FF6B4
	ble loc_037FF6CE	; 037FF6B6
	mov r2,#0x1	; 037FF6B8
	lsl r2,r0	; 037FF6BA
	ldr r0,[pool_037FF6F8]	; 037FF6BC
	and r2,r0	; 037FF6BE
	cmp r2,#0x0	; 037FF6C0
	beq loc_037FF6CE	; 037FF6C2
	add r0,r1,#0x0	; 037FF6C4
	ldr r1,[sp,#0x10]	; 037FF6C6
	bl loc_037FF520	; 037FF6C8
	add r1,r0,#0x0	; 037FF6CC
loc_037FF6CE:
	ldr r0,[sp,#0x10]	; 037FF6CE
	lsl r2,r0,#0x10	; 037FF6D0
	ldr r0,[pool_037FF6FC]	; 037FF6D2
	orr r2,r0	; 037FF6D4
	lsl r0,r5,#0x8	; 037FF6D6
	orr r2,r0	; 037FF6D8
	orr r1,r2	; 037FF6DA
	ldr r0,[pool_037FF700]	; 037FF6DC
	str r1,[r4,r0]	; 037FF6DE
	ldr r0,[pool_037FF704]	; 037FF6E0
	sub r1,r0,r6	; 037FF6E2
	ldr r0,[pool_037FF708]	; 037FF6E4
	strh r1,[r4,r0]	; 037FF6E6
	pop {r4,r5,r6}	; 037FF6E8
	pop {r3}	; 037FF6EA
	bx r3	; 037FF6EC
	.byte 0xC0, 0x46	; 037FF6F0
pool_037FF6F0:
loc_037FF6F0:
	.word P2_BssStart + 0x678	; 037FF6F0
pool_037FF6F4:
loc_037FF6F4:
	.word P2_BssStart + 0x674	; 037FF6F4
pool_037FF6F8:
loc_037FF6F8:
	.word 0x0000FFF5	; 037FF6F8
pool_037FF6FC:
loc_037FF6FC:
	.word 0x60000000	; 037FF6FC
pool_037FF700:
loc_037FF700:
	.word SCHANNEL0_CR	; 037FF700
pool_037FF704:
loc_037FF704:
	.word 0x00010000	; 037FF704
pool_037FF708:
loc_037FF708:
	.word SCHANNEL0_TIMER	; 037FF708

; ===== function loc_037FF70C =====
loc_037FF70C:
	push {r4,r5,r6,lr}	; 037FF70C
	add r5,r1,#0x0	; 037FF70E
	add r6,r3,#0x0	; 037FF710
	lsl r4,r0,#0x4	; 037FF712
	ldr r1,[pool_037FF75C]	; 037FF714
	strb r2,[r1,r0]	; 037FF716
	ldr r1,[pool_037FF760]	; 037FF718
	ldr r1,[r1,#0x0]	; 037FF71A
	cmp r1,#0x0	; 037FF71C
	ble loc_037FF736	; 037FF71E
	mov r1,#0x1	; 037FF720
	lsl r1,r0	; 037FF722
	ldr r0,[pool_037FF764]	; 037FF724
	and r1,r0	; 037FF726
	cmp r1,#0x0	; 037FF728
	beq loc_037FF736	; 037FF72A
	add r0,r2,#0x0	; 037FF72C
	ldr r1,[sp,#0x14]	; 037FF72E
	bl loc_037FF520	; 037FF730
	add r2,r0,#0x0	; 037FF734
loc_037FF736:
	lsl r0,r6,#0x8	; 037FF736
	lsl r3,r5,#0x18	; 037FF738
	ldr r1,[pool_037FF768]	; 037FF73A
	orr r3,r1	; 037FF73C
	ldr r1,[sp,#0x14]	; 037FF73E
	lsl r1,r1,#0x10	; 037FF740
	orr r3,r1	; 037FF742
	orr r0,r3	; 037FF744
	orr r2,r0	; 037FF746
	ldr r0,[pool_037FF76C]	; 037FF748
	str r2,[r4,r0]	; 037FF74A
	ldr r1,[sp,#0x10]	; 037FF74C
	ldr r0,[pool_037FF770]	; 037FF74E
	sub r1,r0,r1	; 037FF750
	ldr r0,[pool_037FF774]	; 037FF752
	strh r1,[r4,r0]	; 037FF754
	pop {r4,r5,r6}	; 037FF756
	pop {r3}	; 037FF758
	bx r3	; 037FF75A
pool_037FF75C:
loc_037FF75C:
	.word P2_BssStart + 0x678	; 037FF75C
pool_037FF760:
loc_037FF760:
	.word P2_BssStart + 0x674	; 037FF760
pool_037FF764:
loc_037FF764:
	.word 0x0000FFF5	; 037FF764
pool_037FF768:
loc_037FF768:
	.word 0x60000000	; 037FF768
pool_037FF76C:
loc_037FF76C:
	.word SCHANNEL0_CR	; 037FF76C
pool_037FF770:
loc_037FF770:
	.word 0x00010000	; 037FF770
pool_037FF774:
loc_037FF774:
	.word SCHANNEL0_TIMER	; 037FF774

; ===== function loc_037FF778 =====
loc_037FF778:
	push {r4,r5,r6,r7,lr}	; 037FF778
	sub sp,#0x4	; 037FF77A
	add r5,r1,#0x0	; 037FF77C
	add r6,r2,#0x0	; 037FF77E
	add r7,r3,#0x0	; 037FF780
	ldr r1,[sp,#0x20]	; 037FF782
	lsl r4,r0,#0x4	; 037FF784
	ldr r2,[pool_037FF7E4]	; 037FF786
	strb r1,[r2,r0]	; 037FF788
	ldr r2,[pool_037FF7E8]	; 037FF78A
	ldr r2,[r2,#0x0]	; 037FF78C
	cmp r2,#0x0	; 037FF78E
	ble loc_037FF7A8	; 037FF790
	mov r2,#0x1	; 037FF792
	lsl r2,r0	; 037FF794
	ldr r0,[pool_037FF7EC]	; 037FF796
	and r2,r0	; 037FF798
	cmp r2,#0x0	; 037FF79A
	beq loc_037FF7A8	; 037FF79C
	add r0,r1,#0x0	; 037FF79E
	ldr r1,[sp,#0x2c]	; 037FF7A0
	bl loc_037FF520	; 037FF7A2
	add r1,r0,#0x0	; 037FF7A6
loc_037FF7A8:
	ldr r0,[sp,#0x24]	; 037FF7A8
	lsl r2,r0,#0x8	; 037FF7AA
	ldr r0,[sp,#0x2c]	; 037FF7AC
	lsl r0,r0,#0x10	; 037FF7AE
	lsl r3,r6,#0x1d	; 037FF7B0
	lsl r6,r7,#0x1b	; 037FF7B2
	orr r3,r6	; 037FF7B4
	orr r0,r3	; 037FF7B6
	orr r2,r0	; 037FF7B8
	orr r1,r2	; 037FF7BA
	ldr r0,[pool_037FF7F0]	; 037FF7BC
	str r1,[r4,r0]	; 037FF7BE
	ldr r1,[sp,#0x28]	; 037FF7C0
	ldr r0,[pool_037FF7F4]	; 037FF7C2
	sub r1,r0,r1	; 037FF7C4
	ldr r0,[pool_037FF7F8]	; 037FF7C6
	strh r1,[r4,r0]	; 037FF7C8
	ldr r1,[sp,#0x18]	; 037FF7CA
	ldr r0,[pool_037FF7FC]	; 037FF7CC
	strh r1,[r4,r0]	; 037FF7CE
	ldr r1,[sp,#0x1c]	; 037FF7D0
	ldr r0,[pool_037FF800]	; 037FF7D2
	str r1,[r4,r0]	; 037FF7D4
	ldr r0,[pool_037FF804]	; 037FF7D6
	str r5,[r4,r0]	; 037FF7D8
	add sp,#0x4	; 037FF7DA
	pop {r4,r5,r6,r7}	; 037FF7DC
	pop {r3}	; 037FF7DE
	bx r3	; 037FF7E0
	.byte 0xC0, 0x46	; 037FF7E4
pool_037FF7E4:
loc_037FF7E4:
	.word P2_BssStart + 0x678	; 037FF7E4
pool_037FF7E8:
loc_037FF7E8:
	.word P2_BssStart + 0x674	; 037FF7E8
pool_037FF7EC:
loc_037FF7EC:
	.word 0x0000FFF5	; 037FF7EC
pool_037FF7F0:
loc_037FF7F0:
	.word SCHANNEL0_CR	; 037FF7F0
pool_037FF7F4:
loc_037FF7F4:
	.word 0x00010000	; 037FF7F4
pool_037FF7F8:
loc_037FF7F8:
	.word SCHANNEL0_TIMER	; 037FF7F8
pool_037FF7FC:
loc_037FF7FC:
	.word SCHANNEL0_PNT	; 037FF7FC
pool_037FF800:
loc_037FF800:
	.word SCHANNEL0_LEN	; 037FF800
pool_037FF804:
loc_037FF804:
	.word SCHANNEL0_SAD	; 037FF804

; ===== function loc_037FF808 =====
loc_037FF808:
	ldr r1,[pool_037FF820]	; 037FF808
	ldr r2,[r1,#0x0]	; 037FF80A
	ldr r0,[pool_037FF824]	; 037FF80C
	mul r2,r0	; 037FF80E
	ldr r0,[pool_037FF828]	; 037FF810
	add r0,r2,r0	; 037FF812
	str r0,[r1,#0x0]	; 037FF814
	lsr r0,r0,#0x10	; 037FF816
	lsl r0,r0,#0x10	; 037FF818
	lsr r0,r0,#0x10	; 037FF81A
	bx lr	; 037FF81C
	.byte 0xC0, 0x46	; 037FF820
pool_037FF820:
loc_037FF820:
	.word P2_Data_03805324	; 037FF820
pool_037FF824:
loc_037FF824:
	.word 0x0019660D	; 037FF824
pool_037FF828:
loc_037FF828:
	.word 0x3C6EF35F	; 037FF828

; ===== function loc_037FF82C =====
loc_037FF82C:
	cmp r0,#0x20	; 037FF82C
	bge loc_037FF836	; 037FF82E
	ldr r1,[pool_037FF868]	; 037FF830
	ldrsb r0,[r1,r0]	; 037FF832
	bx lr	; 037FF834
loc_037FF836:
	cmp r0,#0x40	; 037FF836
	bge loc_037FF844	; 037FF838
	mov r1,#0x40	; 037FF83A
	sub r1,r1,r0	; 037FF83C
	ldr r0,[pool_037FF868]	; 037FF83E
	ldrsb r0,[r0,r1]	; 037FF840
	bx lr	; 037FF842
loc_037FF844:
	cmp r0,#0x60	; 037FF844
	bge loc_037FF856	; 037FF846
	sub r0,#0x40	; 037FF848
	ldr r1,[pool_037FF868]	; 037FF84A
	ldrsb r0,[r1,r0]	; 037FF84C
	neg r0,r0	; 037FF84E
	lsl r0,r0,#0x18	; 037FF850
	asr r0,r0,#0x18	; 037FF852
	bx lr	; 037FF854
loc_037FF856:
	sub r0,#0x60	; 037FF856
	mov r1,#0x20	; 037FF858
	sub r1,r1,r0	; 037FF85A
	ldr r0,[pool_037FF868]	; 037FF85C
	ldrsb r0,[r0,r1]	; 037FF85E
	neg r0,r0	; 037FF860
	lsl r0,r0,#0x18	; 037FF862
	asr r0,r0,#0x18	; 037FF864
	bx lr	; 037FF866
pool_037FF868:
loc_037FF868:
	.word P2_Data_03805144	; 037FF868

; ===== function loc_037FF86C =====
loc_037FF86C:
	push {r4,lr}	; 037FF86C
	add r4,r0,#0x0	; 037FF86E
	ldr r0,[pool_037FF8BC]	; 037FF870
	cmp r4,r0	; 037FF872
	bge loc_037FF87A	; 037FF874
	add r4,r0,#0x0	; 037FF876
	b loc_037FF880	; 037FF878
loc_037FF87A:
	cmp r4,#0x0	; 037FF87A
	ble loc_037FF880	; 037FF87C
	mov r4,#0x0	; 037FF87E
loc_037FF880:
	ldr r0,[pool_037FF8C0]	; 037FF880
	add r0,r4,r0	; 037FF882
	bl loc_03804990	; 037FF884
	mov r1,#0xef	; 037FF888
	mvn r1,r1	; 037FF88A
	cmp r4,r1	; 037FF88C
	bge loc_037FF894	; 037FF88E
	mov r1,#0x3	; 037FF890
	b loc_037FF8AE	; 037FF892
loc_037FF894:
	mov r1,#0x77	; 037FF894
	mvn r1,r1	; 037FF896
	cmp r4,r1	; 037FF898
	bge loc_037FF8A0	; 037FF89A
	mov r1,#0x2	; 037FF89C
	b loc_037FF8AE	; 037FF89E
loc_037FF8A0:
	mov r1,#0x3b	; 037FF8A0
	mvn r1,r1	; 037FF8A2
	cmp r4,r1	; 037FF8A4
	bge loc_037FF8AC	; 037FF8A6
	mov r1,#0x1	; 037FF8A8
	b loc_037FF8AE	; 037FF8AA
loc_037FF8AC:
	mov r1,#0x0	; 037FF8AC
loc_037FF8AE:
	lsl r1,r1,#0x8	; 037FF8AE
	orr r1,r0	; 037FF8B0
	lsl r0,r1,#0x10	; 037FF8B2
	lsr r0,r0,#0x10	; 037FF8B4
	pop {r4}	; 037FF8B6
	pop {r3}	; 037FF8B8
	bx r3	; 037FF8BA
pool_037FF8BC:
loc_037FF8BC:
	.word 0xFFFFFD2D	; 037FF8BC
pool_037FF8C0:
loc_037FF8C0:
	.word 0x000002D3	; 037FF8C0

; ===== function loc_037FF8C4 =====
loc_037FF8C4:
	push {r4,r5,r6,lr}	; 037FF8C4
	add r5,r0,#0x0	; 037FF8C6
	mov r4,#0x0	; 037FF8C8
	neg r0,r1	; 037FF8CA
	ldr r1,[pool_037FF970]	; 037FF8CC
	b loc_037FF8D4	; 037FF8CE
loc_037FF8D0:
	sub r4,r4,#0x1	; 037FF8D0
	add r0,r0,r1	; 037FF8D2
loc_037FF8D4:
	cmp r0,#0x0	; 037FF8D4
	blt loc_037FF8D0	; 037FF8D6
	ldr r1,[pool_037FF970]	; 037FF8D8
	b loc_037FF8E0	; 037FF8DA
loc_037FF8DC:
	add r4,r4,#0x1	; 037FF8DC
	sub r0,r0,r1	; 037FF8DE
loc_037FF8E0:
	cmp r0,r1	; 037FF8E0
	bge loc_037FF8DC	; 037FF8E2
	bl loc_0380498C	; 037FF8E4
	mov r1,#0x0	; 037FF8E8
	ldr r2,[pool_037FF974]	; 037FF8EA
	add r0,r0,r2	; 037FF8EC
	adc r1,r1	; 037FF8EE
	asr r3,r5,#0x1f	; 037FF8F0
	add r2,r5,#0x0	; 037FF8F2
	bl loc_037FEC7C	; 037FF8F4
	add r6,r0,#0x0	; 037FF8F8
	add r5,r1,#0x0	; 037FF8FA
	add r2,r4,#0x0	; 037FF8FC
	sub r2,#0x10	; 037FF8FE
	cmp r2,#0x0	; 037FF900
	bgt loc_037FF90E	; 037FF902
	neg r2,r2	; 037FF904
	bl loc_037FF97C	; 037FF906
	add r5,r1,#0x0	; 037FF90A
	b loc_037FF94A	; 037FF90C
loc_037FF90E:
	cmp r2,#0x20	; 037FF90E
	bge loc_037FF946	; 037FF910
	mov r0,#0x0	; 037FF912
	mvn r0,r0	; 037FF914
	add r1,r0,#0x0	; 037FF916
	mov r3,#0x20	; 037FF918
	sub r2,r3,r2	; 037FF91A
	bl loc_037FF988	; 037FF91C
	add r2,r5,#0x0	; 037FF920
	and r2,r1	; 037FF922
	add r1,r6,#0x0	; 037FF924
	and r1,r0	; 037FF926
	mov r0,#0x0	; 037FF928
	eor r2,r0	; 037FF92A
	eor r1,r0	; 037FF92C
	orr r2,r1	; 037FF92E
	beq loc_037FF936	; 037FF930
	ldr r0,[pool_037FF978]	; 037FF932
	b loc_037FF968	; 037FF934
loc_037FF936:
	add r0,r6,#0x0	; 037FF936
	add r1,r5,#0x0	; 037FF938
	sub r4,#0x10	; 037FF93A
	add r2,r4,#0x0	; 037FF93C
	bl loc_037FF988	; 037FF93E
	add r5,r1,#0x0	; 037FF942
	b loc_037FF94A	; 037FF944
loc_037FF946:
	ldr r0,[pool_037FF978]	; 037FF946
	b loc_037FF968	; 037FF948
loc_037FF94A:
	mov r2,#0x0	; 037FF94A
	mov r1,#0x10	; 037FF94C
	sub r1,r0,r1	; 037FF94E
	lsl r1,r5,#0	; 037FF950
	sbc r1,r2	; 037FF952
	bcs loc_037FF95A	; 037FF954
	mov r0,#0x10	; 037FF956
	b loc_037FF964	; 037FF958
loc_037FF95A:
	ldr r1,[pool_037FF978]	; 037FF95A
	sub r1,r1,r0	; 037FF95C
	sbc r2,r5	; 037FF95E
	bcs loc_037FF964	; 037FF960
	ldr r0,[pool_037FF978]	; 037FF962
loc_037FF964:
	lsl r0,r0,#0x10	; 037FF964
	lsr r0,r0,#0x10	; 037FF966
loc_037FF968:
	pop {r4,r5,r6}	; 037FF968
	pop {r3}	; 037FF96A
	bx r3	; 037FF96C
	.byte 0xC0, 0x46	; 037FF970
pool_037FF970:
loc_037FF970:
	.word 0x00000300	; 037FF970
pool_037FF974:
loc_037FF974:
	.word 0x00010000	; 037FF974
pool_037FF978:
loc_037FF978:
	.word 0x0000FFFF	; 037FF978

; ===== function loc_037FF97C =====
loc_037FF97C:
	bx pc	; 037FF97C
	.byte 0xC0, 0x46	; 037FF980
.arm

; ===== function loc_037FF980 =====
loc_037FF980:
	ldr pc,[pool_037FF984]	; 037FF980
pool_037FF984:
loc_037FF984:
	.word loc_03804FDC	; 037FF984
.thumb

; ===== function loc_037FF988 =====
loc_037FF988:
	bx pc	; 037FF988
	.byte 0xC0, 0x46	; 037FF98C
.arm

; ===== function loc_037FF98C =====
loc_037FF98C:
	ldr pc,[pool_037FF990]	; 037FF98C
pool_037FF990:
loc_037FF990:
	.word loc_03804BBC	; 037FF990
.thumb
P2_ThreadEntry_037FF994:
	push {r4,r5,r6,lr}	; 037FF994
	bl P2_Entry_037FFA94	; 037FF996
	bl P2_Entry_038004D8	; 037FF99A
	bl P2_Entry_038015B0	; 037FF99E
	bl P2_Entry_03801960	; 037FF9A2
	bl P2_Entry_037FF510	; 037FF9A6
	mov r0,#0x0	; 037FF9AA
	add r1,r0,#0x0	; 037FF9AC
	add r2,r0,#0x0	; 037FF9AE
	add r3,r0,#0x0	; 037FF9B0
	bl loc_037FF458	; 037FF9B2
	mov r0,#0x7f	; 037FF9B6
	bl loc_037FF48C	; 037FF9B8
	bl P2_Entry_037FFA54	; 037FF9BC
	mov r6,#0x1	; 037FF9C0
	mov r4,#0x0	; 037FF9C2
P2_Entry_037FF9C4:
	add r5,r4,#0x0	; 037FF9C4
	bl P2_Entry_037FFA38	; 037FF9C6
	cmp r0,#0x1	; 037FF9CA
	beq P2_Entry_037FF9D2	; 037FF9CC
	cmp r0,#0x2	; 037FF9CE
	b P2_Entry_037FF9D4	; 037FF9D0
P2_Entry_037FF9D2:
	add r5,r6,#0x0	; 037FF9D2
P2_Entry_037FF9D4:
	bl P2_Entry_03800398	; 037FF9D4
	bl P2_Entry_03801BC0	; 037FF9D8
	add r0,r5,#0x0	; 037FF9DC
	bl P2_Entry_03801554	; 037FF9DE
	add r0,r5,#0x0	; 037FF9E2
	bl P2_Entry_038001A8	; 037FF9E4
	bl loc_038017A4	; 037FF9E8
	bl loc_037FF808	; 037FF9EC
	b P2_Entry_037FF9C4	; 037FF9F0
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xA9, 0xFC	; 037FF9F2
	.byte 0x00, 0x28, 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0x60, 0xFB, 0x01, 0xB0	; 037FFA02
	.byte 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x68, 0x5A, 0x80, 0x03, 0x28, 0x53, 0x80, 0x03, 0x20, 0x53	; 037FFA12
	.byte 0x80, 0x03	; 037FFA22
.arm
.thumb

; ===== function loc_037FFA24 =====
loc_037FFA24:
	ldr r0,[pool_037FFA30]	; 037FFA24
	mov r1,#0x2	; 037FFA26
	mov r2,#0x0	; 037FFA28
	ldr r3,[pool_037FFA34]	; 037FFA2A
	bx r3	; 037FFA2C
	.byte 0xC0, 0x46	; 037FFA30
pool_037FFA30:
loc_037FFA30:
	.word 0x03805A68	; 037FFA30
pool_037FFA34:
loc_037FFA34:
	.word loc_037FE354 + 1	; 037FFA34

; ===== function loc_037FFA38 =====
P2_Entry_037FFA38:
	push {lr}	; 037FFA38
	sub sp,#0x4	; 037FFA3A
	ldr r0,[pool_037FFA50]	; 037FFA3C
	add r1,sp,#0x0	; 037FFA3E
	mov r2,#0x1	; 037FFA40
	bl loc_037FE2DC	; 037FFA42
	ldr r0,[sp,#0x0]	; 037FFA46
	add sp,#0x4	; 037FFA48
	pop {r3}	; 037FFA4A
	bx r3	; 037FFA4C
	.byte 0xC0, 0x46	; 037FFA50
pool_037FFA50:
loc_037FFA50:
	.word 0x03805A68	; 037FFA50
P2_Entry_037FFA54:
	push {r4,r5,lr}	; 037FFA54
	sub sp,#0xc	; 037FFA56
	bl loc_037FE8BC	; 037FFA58
	add r4,r0,#0x0	; 037FFA5C
	ldr r0,[pool_037FFA84]	; 037FFA5E
	str r0,[sp,#0x4]	; 037FFA60
	mov r5,#0x0	; 037FFA62
	str r5,[sp,#0x8]	; 037FFA64
	ldr r3,[pool_037FFA88]	; 037FFA66
	str r5,[sp,#0x0]	; 037FFA68
	ldr r0,[pool_037FFA8C]	; 037FFA6A
	ldr r2,[pool_037FFA90]	; 037FFA6C
	add r4,r4,r2	; 037FFA6E
	lsl r2,r1,#0	; 037FFA70
	adc r2,r5	; 037FFA72
	add r1,r4,#0x0	; 037FFA74
	bl loc_037FEB0C	; 037FFA76
	add sp,#0xc	; 037FFA7A
	pop {r4,r5}	; 037FFA7C
	pop {r3}	; 037FFA7E
	bx r3	; 037FFA80
	.byte 0xC0, 0x46	; 037FFA82
pool_037FFA84:
	.word 0x037FF9F5	; 037FFA84
pool_037FFA88:
	.word 0x00000AA8	; 037FFA88
pool_037FFA8C:
	.word 0x03805A9C	; 037FFA8C
pool_037FFA90:
	.word 0x00010000	; 037FFA90
P2_Entry_037FFA94:
	push {lr}	; 037FFA94
	sub sp,#0x4	; 037FFA96
	ldr r0,[pool_037FFAB0]	; 037FFA98
	ldr r1,[pool_037FFAB4]	; 037FFA9A
	mov r2,#0x8	; 037FFA9C
	bl loc_037FE3B0	; 037FFA9E
	ldr r0,[pool_037FFAB8]	; 037FFAA2
	bl loc_037FEC88	; 037FFAA4
	add sp,#0x4	; 037FFAA8
	pop {r3}	; 037FFAAA
	bx r3	; 037FFAAC
	.byte 0xC0, 0x46	; 037FFAAE
pool_037FFAB0:
	.word 0x03805A68	; 037FFAB0
pool_037FFAB4:
	.word 0x03805A7C	; 037FFAB4
pool_037FFAB8:
	.word 0x03805A9C	; 037FFAB8

; ===== function loc_037FFABC =====
loc_037FFABC:
	push {lr}	; 037FFABC
	sub sp,#0xc	; 037FFABE
	ldr r1,[pool_037FFAE0]	; 037FFAC0
	str r1,[sp,#0x0]	; 037FFAC2
	str r0,[sp,#0x4]	; 037FFAC4
	ldr r0,[pool_037FFAE4]	; 037FFAC6
	ldr r1,[pool_037FFAE8]	; 037FFAC8
	mov r2,#0x0	; 037FFACA
	ldr r3,[pool_037FFAEC]	; 037FFACC
	bl P2_CreateThread	; 037FFACE
	ldr r0,[pool_037FFAE4]	; 037FFAD2
	bl loc_037FDF34	; 037FFAD4
	add sp,#0xc	; 037FFAD8
	pop {r3}	; 037FFADA
	bx r3	; 037FFADC
	.byte 0xC0, 0x46	; 037FFAE0
pool_037FFAE0:
loc_037FFAE0:
	.word 0x00000400	; 037FFAE0
pool_037FFAE4:
loc_037FFAE4:
	.word 0x03805AC8	; 037FFAE4
pool_037FFAE8:
loc_037FFAE8:
	.word P2_ThreadEntry_037FF994 + 1	; 037FFAE8
pool_037FFAEC:
loc_037FFAEC:
	.word 0x03805F40	; 037FFAEC

; ===== function loc_037FFAF0 =====
loc_037FFAF0:
	push {r4,lr}	; 037FFAF0
	add r4,r0,#0x0	; 037FFAF2
	bl loc_03801E78	; 037FFAF4
	add r0,r4,#0x0	; 037FFAF8
	bl loc_037FFABC	; 037FFAFA
	pop {r4}	; 037FFAFE
	pop {r3}	; 037FFB00
	bx r3	; 037FFB02

; ===== function loc_037FFB04 =====
loc_037FFB04:
	ldr r1,[pool_037FFB18]	; 037FFB04
	ldrb r1,[r0,r1]	; 037FFB06
	mov r0,#0x80	; 037FFB08
	and r1,r0	; 037FFB0A
	cmp r1,#0x0	; 037FFB0C
	beq loc_037FFB14	; 037FFB0E
	mov r0,#0x1	; 037FFB10
	bx lr	; 037FFB12
loc_037FFB14:
	mov r0,#0x0	; 037FFB14
	bx lr	; 037FFB16
pool_037FFB18:
loc_037FFB18:
	.word REG_SNDCAP0CNT	; 037FFB18

; ===== function loc_037FFB1C =====
loc_037FFB1C:
	push {r4,r5,r6,r7,lr}	; 037FFB1C
	sub sp,#0x4	; 037FFB1E
	add r4,r0,#0x0	; 037FFB20
	add r0,r2,#0x0	; 037FFB22
	add r6,r3,#0x0	; 037FFB24
	lsl r3,r4,#0x3	; 037FFB26
	ldr r2,[sp,#0x18]	; 037FFB28
	cmp r2,#0x0	; 037FFB2A
	beq loc_037FFB32	; 037FFB2C
	mov r5,#0x0	; 037FFB2E
	b loc_037FFB34	; 037FFB30
loc_037FFB32:
	mov r5,#0x1	; 037FFB32
loc_037FFB34:
	ldr r2,[sp,#0x20]	; 037FFB34
	ldr r7,[sp,#0x1c]	; 037FFB36
	lsl r7,r7,#0x1	; 037FFB38
	lsl r1,r1,#0x3	; 037FFB3A
	lsl r5,r5,#0x2	; 037FFB3C
	orr r1,r5	; 037FFB3E
	orr r7,r1	; 037FFB40
	orr r2,r7	; 037FFB42
	ldr r1,[pool_037FFB58]	; 037FFB44
	strb r2,[r4,r1]	; 037FFB46
	ldr r1,[pool_037FFB5C]	; 037FFB48
	str r0,[r3,r1]	; 037FFB4A
	ldr r0,[pool_037FFB60]	; 037FFB4C
	strh r6,[r3,r0]	; 037FFB4E
	add sp,#0x4	; 037FFB50
	pop {r4,r5,r6,r7}	; 037FFB52
	pop {r3}	; 037FFB54
	bx r3	; 037FFB56
pool_037FFB58:
loc_037FFB58:
	.word REG_SNDCAP0CNT	; 037FFB58
pool_037FFB5C:
loc_037FFB5C:
	.word REG_SNDCAP0DAD	; 037FFB5C
pool_037FFB60:
loc_037FFB60:
	.word REG_SNDCAP0LEN	; 037FFB60

; ===== function loc_037FFB64 =====
loc_037FFB64:
	push {r4,r5,r6,r7,lr}	; 037FFB64
	sub sp,#0x4	; 037FFB66
	add r5,r0,#0x0	; 037FFB68
	add r6,r1,#0x0	; 037FFB6A
	add r0,#0x28	; 037FFB6C
	bl loc_037FFDBC	; 037FFB6E
	add r4,r0,#0x0	; 037FFB72
	asr r3,r4,#0x1f	; 037FFB74
	mov r2,#0x0	; 037FFB76
	add r1,r3,#0x0	; 037FFB78
	eor r1,r2	; 037FFB7A
	add r7,r4,#0x0	; 037FFB7C
	eor r7,r2	; 037FFB7E
	orr r1,r7	; 037FFB80
	beq loc_037FFBC0	; 037FFB82
	add r1,r5,#0x0	; 037FFB84
	add r1,#0x28	; 037FFB86
	ldrb r1,[r1,#0x0]	; 037FFB88
	cmp r1,#0x0	; 037FFB8A
	beq loc_037FFBA8	; 037FFB8C
	cmp r1,#0x1	; 037FFB8E
	beq loc_037FFB98	; 037FFB90
	cmp r1,#0x2	; 037FFB92
	beq loc_037FFBB2	; 037FFB94
	b loc_037FFBBA	; 037FFB96
loc_037FFB98:
	add r1,r3,#0x0	; 037FFB98
	mov r2,#0x3c	; 037FFB9A
	mov r3,#0x0	; 037FFB9C
	bl loc_037FFBD8	; 037FFB9E
	add r4,r0,#0x0	; 037FFBA2
	add r3,r1,#0x0	; 037FFBA4
	b loc_037FFBBA	; 037FFBA6
loc_037FFBA8:
	lsr r0,r4,#0x1a	; 037FFBA8
	lsl r3,r3,#0x6	; 037FFBAA
	orr r3,r0	; 037FFBAC
	lsl r4,r4,#0x6	; 037FFBAE
	b loc_037FFBBA	; 037FFBB0
loc_037FFBB2:
	lsr r0,r4,#0x1a	; 037FFBB2
	lsl r3,r3,#0x6	; 037FFBB4
	orr r3,r0	; 037FFBB6
	lsl r4,r4,#0x6	; 037FFBB8
loc_037FFBBA:
	lsl r0,r3,#0x12	; 037FFBBA
	lsr r4,r4,#0xe	; 037FFBBC
	orr r4,r0	; 037FFBBE
loc_037FFBC0:
	cmp r6,#0x0	; 037FFBC0
	beq loc_037FFBCC	; 037FFBC2
	add r5,#0x28	; 037FFBC4
	add r0,r5,#0x0	; 037FFBC6
	bl loc_037FFDF0	; 037FFBC8
loc_037FFBCC:
	add r0,r4,#0x0	; 037FFBCC
	add sp,#0x4	; 037FFBCE
	pop {r4,r5,r6,r7}	; 037FFBD0
	pop {r3}	; 037FFBD2
	bx r3	; 037FFBD4
	.byte 0xC0, 0x46	; 037FFBD8

; ===== function loc_037FFBD8 =====
loc_037FFBD8:
	bx pc	; 037FFBD8
	.byte 0xC0, 0x46	; 037FFBDC
.arm

; ===== function loc_037FFBDC =====
loc_037FFBDC:
	ldr pc,[pool_037FFBE0]	; 037FFBDC
pool_037FFBE0:
loc_037FFBE0:
	.word loc_03804B9C	; 037FFBE0
.thumb

; ===== function loc_037FFBE4 =====
loc_037FFBE4:
	push {r4,r5,r6,lr}	; 037FFBE4
	add r5,r0,#0x0	; 037FFBE6
	add r6,r1,#0x0	; 037FFBE8
	mov r0,#0x32	; 037FFBEA
	ldrsh r0,[r5,r0]	; 037FFBEC
	cmp r0,#0x0	; 037FFBEE
	bne loc_037FFBF6	; 037FFBF0
	mov r0,#0x0	; 037FFBF2
	b loc_037FFC20	; 037FFBF4
loc_037FFBF6:
	ldr r2,[r5,#0x14]	; 037FFBF6
	ldr r4,[r5,#0x18]	; 037FFBF8
	cmp r2,r4	; 037FFBFA
	blt loc_037FFC02	; 037FFBFC
	mov r0,#0x0	; 037FFBFE
	b loc_037FFC20	; 037FFC00
loc_037FFC02:
	asr r1,r0,#0x1f	; 037FFC02
	sub r2,r4,r2	; 037FFC04
	asr r3,r2,#0x1f	; 037FFC06
	bl loc_037FFBD8	; 037FFC08
	asr r3,r4,#0x1f	; 037FFC0C
	add r2,r4,#0x0	; 037FFC0E
	bl loc_037FFC28	; 037FFC10
	cmp r6,#0x0	; 037FFC14
	beq loc_037FFC20	; 037FFC16
	add r5,#0x14	; 037FFC18
	ldr r1,[r5,#0x0]	; 037FFC1A
	add r1,r1,#0x1	; 037FFC1C
	str r1,[r5,#0x0]	; 037FFC1E
loc_037FFC20:
	pop {r4,r5,r6}	; 037FFC20
	pop {r3}	; 037FFC22
	bx r3	; 037FFC24
	.byte 0xC0, 0x46	; 037FFC28

; ===== function loc_037FFC28 =====
loc_037FFC28:
	bx pc	; 037FFC28
	.byte 0xC0, 0x46	; 037FFC2C
.arm

; ===== function loc_037FFC2C =====
loc_037FFC2C:
	ldr pc,[pool_037FFC30]	; 037FFC2C
pool_037FFC30:
loc_037FFC30:
	.word loc_038049EC	; 037FFC30
.thumb

; ===== function loc_037FFC34 =====
loc_037FFC34:
	push {r4,lr}	; 037FFC34
	cmp r1,#0x0	; 037FFC36
	beq loc_037FFCA0	; 037FFC38
	ldrb r1,[r0,#0x2]	; 037FFC3A
	cmp r1,#0x3	; 037FFC3C
	bhi loc_037FFCA0	; 037FFC3E
	add r1,r1,r1	; 037FFC40
P2_SwitchIndexPC_037FFC40:
	add r1,pc	; 037FFC42
	ldrh r1,[r1,#(P2_SwitchTable_037FFC40 - (P2_SwitchIndexPC_037FFC40 + 4))]	; 037FFC44
	lsl r1,r1,#0x10	; 037FFC46
	asr r1,r1,#0x10	; 037FFC48
P2_SwitchTargetPC_037FFC40:
	add r1,pc	; 037FFC4A
	bx r1	; 037FFC4C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FFC40:
	.halfword (loc_037FFC56 + 1) - (P2_SwitchTargetPC_037FFC40 + 4)
	.halfword (loc_037FFC70 + 1) - (P2_SwitchTargetPC_037FFC40 + 4)
	.halfword (loc_037FFCA0 + 1) - (P2_SwitchTargetPC_037FFC40 + 4)
	.halfword (loc_037FFC94 + 1) - (P2_SwitchTargetPC_037FFC40 + 4)
P2_SwitchTable_037FFC40End:
loc_037FFC56:
	ldr r1,[r0,#0x10]	; 037FFC56
	neg r2,r1	; 037FFC58
	ldrb r1,[r0,#0x1c]	; 037FFC5A
	mul r2,r1	; 037FFC5C
	asr r1,r2,#0x8	; 037FFC5E
	neg r1,r1	; 037FFC60
	str r1,[r0,#0x10]	; 037FFC62
	ldr r1,[r0,#0x10]	; 037FFC64
	cmp r1,#0x0	; 037FFC66
	bne loc_037FFCA0	; 037FFC68
	mov r1,#0x1	; 037FFC6A
	strb r1,[r0,#0x2]	; 037FFC6C
	b loc_037FFCA0	; 037FFC6E
loc_037FFC70:
	ldrb r1,[r0,#0x1d]	; 037FFC70
	lsl r2,r1,#0x1	; 037FFC72
	ldr r1,[pool_037FFCAC]	; 037FFC74
	ldrsh r1,[r1,r2]	; 037FFC76
	lsl r4,r1,#0x7	; 037FFC78
	add r3,r0,#0x0	; 037FFC7A
	add r3,#0x10	; 037FFC7C
	ldr r2,[r3,#0x0]	; 037FFC7E
	ldrh r1,[r0,#0x1e]	; 037FFC80
	sub r1,r2,r1	; 037FFC82
	str r1,[r3,#0x0]	; 037FFC84
	ldr r1,[r0,#0x10]	; 037FFC86
	cmp r1,r4	; 037FFC88
	bgt loc_037FFCA0	; 037FFC8A
	str r4,[r0,#0x10]	; 037FFC8C
	mov r1,#0x2	; 037FFC8E
	strb r1,[r0,#0x2]	; 037FFC90
	b loc_037FFCA0	; 037FFC92
loc_037FFC94:
	add r3,r0,#0x0	; 037FFC94
	add r3,#0x10	; 037FFC96
	ldr r2,[r3,#0x0]	; 037FFC98
	ldrh r1,[r0,#0x20]	; 037FFC9A
	sub r1,r2,r1	; 037FFC9C
	str r1,[r3,#0x0]	; 037FFC9E
loc_037FFCA0:
	ldr r0,[r0,#0x10]	; 037FFCA0
	asr r0,r0,#0x7	; 037FFCA2
	pop {r4}	; 037FFCA4
	pop {r3}	; 037FFCA6
	bx r3	; 037FFCA8
	.byte 0xC0, 0x46	; 037FFCAC
pool_037FFCAC:
loc_037FFCAC:
	.word P2_Data_03805168	; 037FFCAC

; ===== function loc_037FFCB0 =====
loc_037FFCB0:
	push {r4,r5,lr}	; 037FFCB0
	sub sp,#0x4	; 037FFCB2
	ldrh r5,[r0,#0x24]	; 037FFCB4
	mov r0,#0xff	; 037FFCB6
	add r2,r5,#0x0	; 037FFCB8
	and r2,r0	; 037FFCBA
	ldrh r4,[r1,#0x24]	; 037FFCBC
	add r1,r4,#0x0	; 037FFCBE
	and r1,r0	; 037FFCC0
	lsl r3,r2,#0x4	; 037FFCC2
	lsl r2,r1,#0x4	; 037FFCC4
	asr r0,r5,#0x8	; 037FFCC6
	ldr r1,[pool_037FFCF0]	; 037FFCC8
	ldrb r0,[r1,r0]	; 037FFCCA
	asr r3,r0	; 037FFCCC
	asr r0,r4,#0x8	; 037FFCCE
	ldrb r0,[r1,r0]	; 037FFCD0
	asr r2,r0	; 037FFCD2
	cmp r3,r2	; 037FFCD4
	beq loc_037FFCE6	; 037FFCD6
	cmp r3,r2	; 037FFCD8
	bge loc_037FFCE0	; 037FFCDA
	mov r0,#0x1	; 037FFCDC
	b loc_037FFCE8	; 037FFCDE
loc_037FFCE0:
	mov r0,#0x0	; 037FFCE0
	mvn r0,r0	; 037FFCE2
	b loc_037FFCE8	; 037FFCE4
loc_037FFCE6:
	mov r0,#0x0	; 037FFCE6
loc_037FFCE8:
	add sp,#0x4	; 037FFCE8
	pop {r4,r5}	; 037FFCEA
	pop {r3}	; 037FFCEC
	bx r3	; 037FFCEE
pool_037FFCF0:
loc_037FFCF0:
	.word P2_Data_03805268	; 037FFCF0

; ===== function loc_037FFCF4 =====
loc_037FFCF4:
	push {lr}	; 037FFCF4
	sub sp,#0x4	; 037FFCF6
	add r2,r0,#0x0	; 037FFCF8
	cmp r2,#0x7f	; 037FFCFA
	bne loc_037FFD02	; 037FFCFC
	ldr r0,[pool_037FFD2C]	; 037FFCFE
	b loc_037FFD26	; 037FFD00
loc_037FFD02:
	cmp r2,#0x7e	; 037FFD02
	bne loc_037FFD0A	; 037FFD04
	ldr r0,[pool_037FFD30]	; 037FFD06
	b loc_037FFD26	; 037FFD08
loc_037FFD0A:
	cmp r2,#0x32	; 037FFD0A
	bge loc_037FFD18	; 037FFD0C
	lsl r0,r2,#0x1	; 037FFD0E
	add r0,r0,#0x1	; 037FFD10
	lsl r0,r0,#0x10	; 037FFD12
	lsr r0,r0,#0x10	; 037FFD14
	b loc_037FFD26	; 037FFD16
loc_037FFD18:
	ldr r0,[pool_037FFD34]	; 037FFD18
	mov r1,#0x7e	; 037FFD1A
	sub r1,r1,r2	; 037FFD1C
	bl loc_037FE348	; 037FFD1E
	lsl r0,r0,#0x10	; 037FFD22
	lsr r0,r0,#0x10	; 037FFD24
loc_037FFD26:
	add sp,#0x4	; 037FFD26
	pop {r3}	; 037FFD28
	bx r3	; 037FFD2A
pool_037FFD2C:
loc_037FFD2C:
	.word 0x0000FFFF	; 037FFD2C
pool_037FFD30:
loc_037FFD30:
	.word 0x00003C00	; 037FFD30
pool_037FFD34:
loc_037FFD34:
	.word 0x00001E00	; 037FFD34

; ===== function loc_037FFD38 =====
loc_037FFD38:
	push {r4,lr}	; 037FFD38
	add r4,r0,#0x0	; 037FFD3A
	ldr r0,[pool_037FFD68]	; 037FFD3C
	str r0,[r4,#0x10]	; 037FFD3E
	mov r0,#0x0	; 037FFD40
	strb r0,[r4,#0x2]	; 037FFD42
	str r1,[r4,#0x34]	; 037FFD44
	add r0,r4,#0x0	; 037FFD46
	add r0,#0x28	; 037FFD48
	bl loc_037FFE34	; 037FFD4A
	add r2,r4,#0x3	; 037FFD4E
	ldrb r1,[r2,#0x0]	; 037FFD50
	mov r0,#0x2	; 037FFD52
	orr r1,r0	; 037FFD54
	strb r1,[r2,#0x0]	; 037FFD56
	ldrb r1,[r2,#0x0]	; 037FFD58
	mov r0,#0x1	; 037FFD5A
	bic r1,r0	; 037FFD5C
	orr r1,r0	; 037FFD5E
	strb r1,[r2,#0x0]	; 037FFD60
	pop {r4}	; 037FFD62
	pop {r3}	; 037FFD64
	bx r3	; 037FFD66
pool_037FFD68:
loc_037FFD68:
	.word 0xFFFE9680	; 037FFD68

; ===== function loc_037FFD6C =====
loc_037FFD6C:
	push {r4,r5,lr}	; 037FFD6C
	sub sp,#0x4	; 037FFD6E
	mov r4,#0x0	; 037FFD70
	str r4,[r0,#0x50]	; 037FFD72
	str r1,[r0,#0x48]	; 037FFD74
	str r2,[r0,#0x4c]	; 037FFD76
	str r4,[r0,#0x34]	; 037FFD78
	add r1,r0,#0x0	; 037FFD7A
	add r1,#0x22	; 037FFD7C
	strb r3,[r1,#0x0]	; 037FFD7E
	mov r5,#0x7f	; 037FFD80
	strh r5,[r0,#0x24]	; 037FFD82
	add r3,r0,#0x3	; 037FFD84
	ldrb r2,[r3,#0x0]	; 037FFD86
	mov r1,#0x2	; 037FFD88
	bic r2,r1	; 037FFD8A
	strb r2,[r3,#0x0]	; 037FFD8C
	mov r1,#0x3c	; 037FFD8E
	strb r1,[r0,#0x8]	; 037FFD90
	strb r1,[r0,#0x5]	; 037FFD92
	strb r5,[r0,#0x9]	; 037FFD94
	strb r4,[r0,#0xa]	; 037FFD96
	strh r4,[r0,#0xc]	; 037FFD98
	strh r4,[r0,#0xe]	; 037FFD9A
	strb r4,[r0,#0xb]	; 037FFD9C
	strh r4,[r0,#0x32]	; 037FFD9E
	str r4,[r0,#0x18]	; 037FFDA0
	str r4,[r0,#0x14]	; 037FFDA2
	strb r5,[r0,#0x1c]	; 037FFDA4
	strh r5,[r0,#0x1e]	; 037FFDA6
	strb r5,[r0,#0x1d]	; 037FFDA8
	strh r5,[r0,#0x20]	; 037FFDAA
	add r0,#0x28	; 037FFDAC
	bl loc_037FFE3C	; 037FFDAE
	add sp,#0x4	; 037FFDB2
	pop {r4,r5}	; 037FFDB4
	pop {r3}	; 037FFDB6
	bx r3	; 037FFDB8
	.byte 0x00, 0x00	; 037FFDBC

; ===== function loc_037FFDBC =====
loc_037FFDBC:
	push {r4,lr}	; 037FFDBC
	add r4,r0,#0x0	; 037FFDBE
	ldrb r0,[r4,#0x2]	; 037FFDC0
	cmp r0,#0x0	; 037FFDC2
	bne loc_037FFDCA	; 037FFDC4
	mov r0,#0x0	; 037FFDC6
	b loc_037FFDE8	; 037FFDC8
loc_037FFDCA:
	ldrh r1,[r4,#0x6]	; 037FFDCA
	ldrh r0,[r4,#0x4]	; 037FFDCC
	cmp r1,r0	; 037FFDCE
	bcs loc_037FFDD6	; 037FFDD0
	mov r2,#0x0	; 037FFDD2
	b loc_037FFDE6	; 037FFDD4
loc_037FFDD6:
	ldrh r0,[r4,#0x8]	; 037FFDD6
	lsr r0,r0,#0x8	; 037FFDD8
	bl loc_037FF82C	; 037FFDDA
	ldrb r2,[r4,#0x3]	; 037FFDDE
	ldrb r1,[r4,#0x2]	; 037FFDE0
	mul r1,r0	; 037FFDE2
	mul r2,r1	; 037FFDE4
loc_037FFDE6:
	add r0,r2,#0x0	; 037FFDE6
loc_037FFDE8:
	pop {r4}	; 037FFDE8
	pop {r3}	; 037FFDEA
	bx r3	; 037FFDEC
	.byte 0x00, 0x00	; 037FFDF0

; ===== function loc_037FFDF0 =====
loc_037FFDF0:
	push {r4,lr}	; 037FFDF0
	ldrh r2,[r0,#0x6]	; 037FFDF2
	ldrh r1,[r0,#0x4]	; 037FFDF4
	cmp r2,r1	; 037FFDF6
	bcs loc_037FFE04	; 037FFDF8
	add r1,r0,#0x6	; 037FFDFA
	ldrh r0,[r1,#0x0]	; 037FFDFC
	add r0,r0,#0x1	; 037FFDFE
	strh r0,[r1,#0x0]	; 037FFE00
	b loc_037FFE2E	; 037FFE02
loc_037FFE04:
	ldrh r2,[r0,#0x8]	; 037FFE04
	ldrb r1,[r0,#0x1]	; 037FFE06
	lsl r3,r1,#0x6	; 037FFE08
	add r1,r2,r3	; 037FFE0A
	lsr r4,r1,#0x8	; 037FFE0C
	b loc_037FFE12	; 037FFE0E
loc_037FFE10:
	sub r4,#0x80	; 037FFE10
loc_037FFE12:
	cmp r4,#0x80	; 037FFE12
	bcs loc_037FFE10	; 037FFE14
	add r0,#0x8	; 037FFE16
	ldrh r1,[r0,#0x0]	; 037FFE18
	add r1,r1,r3	; 037FFE1A
	strh r1,[r0,#0x0]	; 037FFE1C
	ldrh r2,[r0,#0x0]	; 037FFE1E
	mov r1,#0xff	; 037FFE20
	and r2,r1	; 037FFE22
	strh r2,[r0,#0x0]	; 037FFE24
	ldrh r2,[r0,#0x0]	; 037FFE26
	lsl r1,r4,#0x8	; 037FFE28
	orr r2,r1	; 037FFE2A
	strh r2,[r0,#0x0]	; 037FFE2C
loc_037FFE2E:
	pop {r4}	; 037FFE2E
	pop {r3}	; 037FFE30
	bx r3	; 037FFE32

; ===== function loc_037FFE34 =====
loc_037FFE34:
	mov r1,#0x0	; 037FFE34
	strh r1,[r0,#0x8]	; 037FFE36
	strh r1,[r0,#0x6]	; 037FFE38
	bx lr	; 037FFE3A

; ===== function loc_037FFE3C =====
loc_037FFE3C:
	mov r2,#0x0	; 037FFE3C
	strb r2,[r0,#0x0]	; 037FFE3E
	strb r2,[r0,#0x2]	; 037FFE40
	mov r1,#0x1	; 037FFE42
	strb r1,[r0,#0x3]	; 037FFE44
	mov r1,#0x10	; 037FFE46
	strb r1,[r0,#0x1]	; 037FFE48
	strh r2,[r0,#0x4]	; 037FFE4A
	bx lr	; 037FFE4C
	.byte 0x00, 0x00	; 037FFE50

; ===== function loc_037FFE50 =====
loc_037FFE50:
	push {r4,r5,r6,r7,lr}	; 037FFE50
	sub sp,#0x4	; 037FFE52
	add r5,r0,#0x0	; 037FFE54
	add r6,r1,#0x0	; 037FFE56
	mov r4,#0x0	; 037FFE58
	add r7,r4,#0x0	; 037FFE5A
loc_037FFE5C:
	add r1,r4,#0x0	; 037FFE5C
	mov r0,#0x54	; 037FFE5E
	mul r1,r0	; 037FFE60
	ldr r0,[pool_037FFE9C]	; 037FFE62
	add r1,r0,r1	; 037FFE64
	ldrb r0,[r1,#0x1]	; 037FFE66
	cmp r0,#0x0	; 037FFE68
	bne loc_037FFE88	; 037FFE6A
	ldr r0,[r1,#0x44]	; 037FFE6C
	cmp r5,r0	; 037FFE6E
	bhi loc_037FFE88	; 037FFE70
	cmp r0,r6	; 037FFE72
	bhi loc_037FFE88	; 037FFE74
	add r2,r1,#0x3	; 037FFE76
	ldrb r1,[r2,#0x0]	; 037FFE78
	mov r0,#0x2	; 037FFE7A
	bic r1,r0	; 037FFE7C
	strb r1,[r2,#0x0]	; 037FFE7E
	add r0,r4,#0x0	; 037FFE80
	add r1,r7,#0x0	; 037FFE82
	bl loc_037FF67C	; 037FFE84
loc_037FFE88:
	add r0,r4,#0x1	; 037FFE88
	lsl r0,r0,#0x18	; 037FFE8A
	lsr r4,r0,#0x18	; 037FFE8C
	cmp r4,#0x10	; 037FFE8E
	bcc loc_037FFE5C	; 037FFE90
	add sp,#0x4	; 037FFE92
	pop {r4,r5,r6,r7}	; 037FFE94
	pop {r3}	; 037FFE96
	bx r3	; 037FFE98
	.byte 0xC0, 0x46	; 037FFE9C
pool_037FFE9C:
loc_037FFE9C:
	.word 0x03805F64	; 037FFE9C

; ===== function loc_037FFEA0 =====
loc_037FFEA0:
	mov r2,#0x1	; 037FFEA0
	and r1,r2	; 037FFEA2
	cmp r1,#0x0	; 037FFEA4
	beq loc_037FFEB2	; 037FFEA6
	ldr r1,[pool_037FFEBC]	; 037FFEA8
	ldr r2,[r1,#0x0]	; 037FFEAA
	bic r2,r0	; 037FFEAC
	str r2,[r1,#0x0]	; 037FFEAE
	bx lr	; 037FFEB0
loc_037FFEB2:
	ldr r1,[pool_037FFEC0]	; 037FFEB2
	ldr r2,[r1,#0x0]	; 037FFEB4
	bic r2,r0	; 037FFEB6
	str r2,[r1,#0x0]	; 037FFEB8
	bx lr	; 037FFEBA
pool_037FFEBC:
loc_037FFEBC:
	.word P2_BssStart + 0xB60	; 037FFEBC
pool_037FFEC0:
loc_037FFEC0:
	.word P2_BssStart + 0xB64	; 037FFEC0

; ===== function loc_037FFEC4 =====
loc_037FFEC4:
	push {r4,r5,r6,r7,lr}	; 037FFEC4
	sub sp,#0x14	; 037FFEC6
	add r7,r0,#0x0	; 037FFEC8
	str r1,[sp,#0x0]	; 037FFECA
	add r6,r7,#0x0	; 037FFECC
	mov r4,#0x0	; 037FFECE
	str r4,[sp,#0x4]	; 037FFED0
	str r4,[sp,#0x8]	; 037FFED2
	str r4,[sp,#0xc]	; 037FFED4
	str r4,[sp,#0x10]	; 037FFED6
	b loc_037FFF34	; 037FFED8
loc_037FFEDA:
	add r1,r6,#0x0	; 037FFEDA
	mov r0,#0x1	; 037FFEDC
	and r1,r0	; 037FFEDE
	cmp r1,#0x0	; 037FFEE0
	beq loc_037FFF30	; 037FFEE2
	add r1,r4,#0x0	; 037FFEE4
	mov r0,#0x54	; 037FFEE6
	mul r1,r0	; 037FFEE8
	ldr r0,[pool_037FFF64]	; 037FFEEA
	add r5,r0,r1	; 037FFEEC
	ldr r0,[pool_037FFF68]	; 037FFEEE
	ldr r1,[r0,#0x0]	; 037FFEF0
	mov r0,#0x1	; 037FFEF2
	lsl r0,r4	; 037FFEF4
	and r1,r0	; 037FFEF6
	cmp r1,#0x0	; 037FFEF8
	bne loc_037FFF30	; 037FFEFA
	ldr r3,[r5,#0x48]	; 037FFEFC
	cmp r3,#0x0	; 037FFEFE
	beq loc_037FFF0C	; 037FFF00
	add r0,r5,#0x0	; 037FFF02
	ldr r1,[sp,#0x4]	; 037FFF04
	ldr r2,[r5,#0x4c]	; 037FFF06
	bl loc_038050D8	; 037FFF08
loc_037FFF0C:
	add r0,r4,#0x0	; 037FFF0C
	ldr r1,[sp,#0x8]	; 037FFF0E
	bl loc_037FF67C	; 037FFF10
	add r1,r5,#0x0	; 037FFF14
	add r1,#0x22	; 037FFF16
	ldr r0,[sp,#0xc]	; 037FFF18
	strb r0,[r1,#0x0]	; 037FFF1A
	add r0,r5,#0x0	; 037FFF1C
	bl loc_037FFFF4	; 037FFF1E
	ldr r0,[sp,#0x10]	; 037FFF22
	strb r0,[r5,#0x4]	; 037FFF24
	add r2,r5,#0x3	; 037FFF26
	ldrb r1,[r2,#0x0]	; 037FFF28
	mov r0,#0x1	; 037FFF2A
	bic r1,r0	; 037FFF2C
	strb r1,[r2,#0x0]	; 037FFF2E
loc_037FFF30:
	add r4,r4,#0x1	; 037FFF30
	lsr r6,r6,#0x1	; 037FFF32
loc_037FFF34:
	cmp r4,#0x10	; 037FFF34
	bge loc_037FFF3C	; 037FFF36
	cmp r6,#0x0	; 037FFF38
	bne loc_037FFEDA	; 037FFF3A
loc_037FFF3C:
	mov r1,#0x1	; 037FFF3C
	ldr r0,[sp,#0x0]	; 037FFF3E
	and r0,r1	; 037FFF40
	str r0,[sp,#0x0]	; 037FFF42
	cmp r0,#0x0	; 037FFF44
	beq loc_037FFF52	; 037FFF46
	ldr r0,[pool_037FFF6C]	; 037FFF48
	ldr r1,[r0,#0x0]	; 037FFF4A
	orr r1,r7	; 037FFF4C
	str r1,[r0,#0x0]	; 037FFF4E
	b loc_037FFF5A	; 037FFF50
loc_037FFF52:
	ldr r0,[pool_037FFF68]	; 037FFF52
	ldr r1,[r0,#0x0]	; 037FFF54
	orr r1,r7	; 037FFF56
	str r1,[r0,#0x0]	; 037FFF58
loc_037FFF5A:
	add sp,#0x14	; 037FFF5A
	pop {r4,r5,r6,r7}	; 037FFF5C
	pop {r3}	; 037FFF5E
	bx r3	; 037FFF60
	.byte 0xC0, 0x46	; 037FFF64
pool_037FFF64:
loc_037FFF64:
	.word 0x03805F64	; 037FFF64
pool_037FFF68:
loc_037FFF68:
	.word P2_BssStart + 0xB64	; 037FFF68
pool_037FFF6C:
loc_037FFF6C:
	.word P2_BssStart + 0xB60	; 037FFF6C

; ===== function loc_037FFF70 =====
loc_037FFF70:
	push {r4,r5,r6,r7,lr}	; 037FFF70
	sub sp,#0xc	; 037FFF72
	add r6,r0,#0x0	; 037FFF74
	mov r4,#0x0	; 037FFF76
	str r4,[sp,#0x0]	; 037FFF78
	str r4,[sp,#0x4]	; 037FFF7A
	add r7,r4,#0x0	; 037FFF7C
	str r4,[sp,#0x8]	; 037FFF7E
	b loc_037FFFDA	; 037FFF80
loc_037FFF82:
	add r1,r6,#0x0	; 037FFF82
	mov r0,#0x1	; 037FFF84
	and r1,r0	; 037FFF86
	cmp r1,#0x0	; 037FFF88
	beq loc_037FFFD6	; 037FFF8A
	add r1,r4,#0x0	; 037FFF8C
	mov r0,#0x54	; 037FFF8E
	mul r1,r0	; 037FFF90
	ldr r0,[pool_037FFFEC]	; 037FFF92
	add r5,r0,r1	; 037FFF94
	ldr r0,[pool_037FFFF0]	; 037FFF96
	ldr r1,[r0,#0x0]	; 037FFF98
	mov r0,#0x1	; 037FFF9A
	lsl r0,r4	; 037FFF9C
	and r1,r0	; 037FFF9E
	cmp r1,#0x0	; 037FFFA0
	bne loc_037FFFD6	; 037FFFA2
	ldr r3,[r5,#0x48]	; 037FFFA4
	cmp r3,#0x0	; 037FFFA6
	beq loc_037FFFB4	; 037FFFA8
	add r0,r5,#0x0	; 037FFFAA
	ldr r1,[sp,#0x0]	; 037FFFAC
	ldr r2,[r5,#0x4c]	; 037FFFAE
	bl loc_038050D8	; 037FFFB0
loc_037FFFB4:
	add r0,r4,#0x0	; 037FFFB4
	ldr r1,[sp,#0x4]	; 037FFFB6
	bl loc_037FF67C	; 037FFFB8
	add r0,r5,#0x0	; 037FFFBC
	add r0,#0x22	; 037FFFBE
	strb r7,[r0,#0x0]	; 037FFFC0
	add r0,r5,#0x0	; 037FFFC2
	bl loc_037FFFF4	; 037FFFC4
	ldr r0,[sp,#0x8]	; 037FFFC8
	strb r0,[r5,#0x4]	; 037FFFCA
	add r2,r5,#0x3	; 037FFFCC
	ldrb r1,[r2,#0x0]	; 037FFFCE
	mov r0,#0x1	; 037FFFD0
	bic r1,r0	; 037FFFD2
	strb r1,[r2,#0x0]	; 037FFFD4
loc_037FFFD6:
	add r4,r4,#0x1	; 037FFFD6
	lsr r6,r6,#0x1	; 037FFFD8
loc_037FFFDA:
	cmp r4,#0x10	; 037FFFDA
	bge loc_037FFFE2	; 037FFFDC
	cmp r6,#0x0	; 037FFFDE
	bne loc_037FFF82	; 037FFFE0
loc_037FFFE2:
	add sp,#0xc	; 037FFFE2
	pop {r4,r5,r6,r7}	; 037FFFE4
	pop {r3}	; 037FFFE6
	bx r3	; 037FFFE8
	.byte 0xC0, 0x46	; 037FFFEC
pool_037FFFEC:
loc_037FFFEC:
	.word 0x03805F64	; 037FFFEC
pool_037FFFF0:
loc_037FFFF0:
	.word P2_BssStart + 0xB64	; 037FFFF0

; ===== function loc_037FFFF4 =====
loc_037FFFF4:
	cmp r0,#0x0	; 037FFFF4
	beq loc_037FFFFE	; 037FFFF6
	mov r1,#0x0	; 037FFFF8
	str r1,[r0,#0x48]	; 037FFFFA
	str r1,[r0,#0x4c]	; 037FFFFC
loc_037FFFFE:
	bx lr	; 037FFFFE

; ===== function loc_03800000 =====
P2_Entry_03800000:
	push {r4,r5,r6,r7,lr}	; 03800000
	sub sp,#0xc	; 03800002
	add r5,r0,#0x0	; 03800004
	str r1,[sp,#0x0]	; 03800006
	str r3,[sp,#0x4]	; 03800008
	ldr r0,[pool_038000B4]	; 0380000A
	ldr r0,[r0,#0x0]	; 0380000C
	bic r5,r0	; 0380000E
	cmp r2,#0x0	; 03800010
	bne loc_0380001A	; 03800012
	ldr r0,[pool_038000B8]	; 03800014
	ldr r0,[r0,#0x0]	; 03800016
	bic r5,r0	; 03800018
loc_0380001A:
	mov r4,#0x0	; 0380001A
	add r6,r4,#0x0	; 0380001C
loc_0380001E:
	ldr r0,[pool_038000BC]	; 0380001E
	ldrb r0,[r0,r6]	; 03800020
	mov r1,#0x1	; 03800022
	lsl r1,r0	; 03800024
	add r2,r5,#0x0	; 03800026
	and r2,r1	; 03800028
	cmp r2,#0x0	; 0380002A
	beq loc_03800060	; 0380002C
	mov r1,#0x54	; 0380002E
	mul r0,r1	; 03800030
	ldr r1,[pool_038000C0]	; 03800032
	add r7,r1,r0	; 03800034
	cmp r4,#0x0	; 03800036
	bne loc_0380003E	; 03800038
	add r4,r7,#0x0	; 0380003A
	b loc_03800060	; 0380003C
loc_0380003E:
	add r0,r4,#0x0	; 0380003E
	add r0,#0x22	; 03800040
	ldrb r1,[r0,#0x0]	; 03800042
	add r0,r7,#0x0	; 03800044
	add r0,#0x22	; 03800046
	ldrb r0,[r0,#0x0]	; 03800048
	cmp r0,r1	; 0380004A
	bhi loc_03800060	; 0380004C
	cmp r0,r1	; 0380004E
	bne loc_0380005E	; 03800050
	add r0,r4,#0x0	; 03800052
	add r1,r7,#0x0	; 03800054
	bl loc_037FFCB0	; 03800056
	cmp r0,#0x0	; 0380005A
	bge loc_03800060	; 0380005C
loc_0380005E:
	add r4,r7,#0x0	; 0380005E
loc_03800060:
	add r6,r6,#0x1	; 03800060
	cmp r6,#0x10	; 03800062
	blt loc_0380001E	; 03800064
	cmp r4,#0x0	; 03800066
	bne loc_0380006E	; 03800068
	mov r0,#0x0	; 0380006A
	b loc_038000AA	; 0380006C
loc_0380006E:
	add r0,r4,#0x0	; 0380006E
	add r0,#0x22	; 03800070
	ldrb r1,[r0,#0x0]	; 03800072
	ldr r0,[sp,#0x0]	; 03800074
	cmp r0,r1	; 03800076
	bge loc_0380007E	; 03800078
	mov r0,#0x0	; 0380007A
	b loc_038000AA	; 0380007C
loc_0380007E:
	ldr r3,[r4,#0x48]	; 0380007E
	cmp r3,#0x0	; 03800080
	beq loc_0380008E	; 03800082
	add r0,r4,#0x0	; 03800084
	mov r1,#0x0	; 03800086
	ldr r2,[r4,#0x4c]	; 03800088
	bl loc_038050D8	; 0380008A
loc_0380008E:
	mov r0,#0x2	; 0380008E
	strb r0,[r4,#0x4]	; 03800090
	add r2,r4,#0x3	; 03800092
	ldrb r1,[r2,#0x0]	; 03800094
	mov r0,#0x1	; 03800096
	bic r1,r0	; 03800098
	strb r1,[r2,#0x0]	; 0380009A
	add r0,r4,#0x0	; 0380009C
	ldr r1,[sp,#0x4]	; 0380009E
	ldr r2,[sp,#0x20]	; 038000A0
	ldr r3,[sp,#0x0]	; 038000A2
	bl loc_037FFD6C	; 038000A4
	add r0,r4,#0x0	; 038000A8
loc_038000AA:
	add sp,#0xc	; 038000AA
	pop {r4,r5,r6,r7}	; 038000AC
	pop {r3}	; 038000AE
	bx r3	; 038000B0
	.byte 0xC0, 0x46	; 038000B4
pool_038000B4:
loc_038000B4:
	.word P2_BssStart + 0xB64	; 038000B4
pool_038000B8:
loc_038000B8:
	.word P2_BssStart + 0xB60	; 038000B8
pool_038000BC:
loc_038000BC:
	.word P2_Data_0380526C	; 038000BC
pool_038000C0:
loc_038000C0:
	.word 0x03805F64	; 038000C0

; ===== function loc_038000C4 =====
loc_038000C4:
	ldrb r0,[r0,#0x3]	; 038000C4
	lsl r0,r0,#0x1f	; 038000C6
	lsr r0,r0,#0x1f	; 038000C8
	bx lr	; 038000CA

; ===== function loc_038000CC =====
loc_038000CC:
	mov r1,#0x3	; 038000CC
	strb r1,[r0,#0x2]	; 038000CE
	bx lr	; 038000D0
	.byte 0x00, 0x00	; 038000D4

; ===== function loc_038000D4 =====
loc_038000D4:
	push {r4,lr}	; 038000D4
	add r4,r0,#0x0	; 038000D6
	add r0,r1,#0x0	; 038000D8
	bl loc_037FFCF4	; 038000DA
	strh r0,[r4,#0x20]	; 038000DE
	pop {r4}	; 038000E0
	pop {r3}	; 038000E2
	bx r3	; 038000E4
	.byte 0x00, 0x00	; 038000E8

; ===== function loc_038000E8 =====
loc_038000E8:
	strb r1,[r0,#0x1d]	; 038000E8
	bx lr	; 038000EA

; ===== function loc_038000EC =====
loc_038000EC:
	push {r4,lr}	; 038000EC
	add r4,r0,#0x0	; 038000EE
	add r0,r1,#0x0	; 038000F0
	bl loc_037FFCF4	; 038000F2
	strh r0,[r4,#0x1e]	; 038000F6
	pop {r4}	; 038000F8
	pop {r3}	; 038000FA
	bx r3	; 038000FC
	.byte 0x00, 0x00	; 03800100

; ===== function loc_03800100 =====
loc_03800100:
	cmp r1,#0x6d	; 03800100
	bge loc_0380010C	; 03800102
	mov r2,#0xff	; 03800104
	sub r1,r2,r1	; 03800106
	strb r1,[r0,#0x1c]	; 03800108
	bx lr	; 0380010A
loc_0380010C:
	mov r2,#0x7f	; 0380010C
	sub r2,r2,r1	; 0380010E
	ldr r1,[pool_03800118]	; 03800110
	ldrb r1,[r1,r2]	; 03800112
	strb r1,[r0,#0x1c]	; 03800114
	bx lr	; 03800116
pool_03800118:
loc_03800118:
	.word P2_Data_0380527C	; 03800118

; ===== function loc_0380011C =====
loc_0380011C:
	push {lr}	; 0380011C
	sub sp,#0x4	; 0380011E
	ldrb r2,[r0,#0x0]	; 03800120
	cmp r2,#0xe	; 03800122
	bcs loc_0380012A	; 03800124
	mov r0,#0x0	; 03800126
	b loc_03800140	; 03800128
loc_0380012A:
	cmp r2,#0xf	; 0380012A
	bls loc_03800132	; 0380012C
	mov r0,#0x0	; 0380012E
	b loc_03800140	; 03800130
loc_03800132:
	mov r2,#0x2	; 03800132
	strb r2,[r0,#0x1]	; 03800134
	ldr r2,[pool_03800148]	; 03800136
	strh r2,[r0,#0x3c]	; 03800138
	bl loc_037FFD38	; 0380013A
	mov r0,#0x1	; 0380013E
loc_03800140:
	add sp,#0x4	; 03800140
	pop {r3}	; 03800142
	bx r3	; 03800144
	.byte 0xC0, 0x46	; 03800148
pool_03800148:
loc_03800148:
	.word 0x00001F46	; 03800148

; ===== function loc_0380014C =====
loc_0380014C:
	push {lr}	; 0380014C
	sub sp,#0x4	; 0380014E
	ldrb r3,[r0,#0x0]	; 03800150
	cmp r3,#0x8	; 03800152
	bcs loc_0380015A	; 03800154
	mov r0,#0x0	; 03800156
	b loc_03800174	; 03800158
loc_0380015A:
	cmp r3,#0xd	; 0380015A
	bls loc_03800162	; 0380015C
	mov r0,#0x0	; 0380015E
	b loc_03800174	; 03800160
loc_03800162:
	mov r3,#0x1	; 03800162
	strb r3,[r0,#0x1]	; 03800164
	str r1,[r0,#0x44]	; 03800166
	ldr r1,[pool_0380017C]	; 03800168
	strh r1,[r0,#0x3c]	; 0380016A
	add r1,r2,#0x0	; 0380016C
	bl loc_037FFD38	; 0380016E
	mov r0,#0x1	; 03800172
loc_03800174:
	add sp,#0x4	; 03800174
	pop {r3}	; 03800176
	bx r3	; 03800178
	.byte 0xC0, 0x46	; 0380017C
pool_0380017C:
loc_0380017C:
	.word 0x00001F46	; 0380017C

; ===== function loc_03800180 =====
loc_03800180:
	push {r4,r5,r6,lr}	; 03800180
	add r6,r0,#0x0	; 03800182
	add r5,r1,#0x0	; 03800184
	mov r0,#0x0	; 03800186
	strb r0,[r6,#0x1]	; 03800188
	add r4,r6,#0x0	; 0380018A
	add r4,#0x38	; 0380018C
	ldmia r5!,{r0,r1}	; 0380018E
	stmia r4!,{r0,r1}	; 03800190
	ldr r0,[r5,#0x0]	; 03800192
	str r0,[r4,#0x0]	; 03800194
	str r2,[r6,#0x44]	; 03800196
	add r0,r6,#0x0	; 03800198
	add r1,r3,#0x0	; 0380019A
	bl loc_037FFD38	; 0380019C
	mov r0,#0x1	; 038001A0
	pop {r4,r5,r6}	; 038001A2
	pop {r3}	; 038001A4
	bx r3	; 038001A6

; ===== function loc_038001A8 =====
P2_Entry_038001A8:
	push {r4,r5,r6,r7,lr}	; 038001A8
	sub sp,#0x24	; 038001AA
	str r0,[sp,#0x0]	; 038001AC
	mov r0,#0x0	; 038001AE
	str r0,[sp,#0x4]	; 038001B0
	str r0,[sp,#0xc]	; 038001B2
	str r0,[sp,#0x14]	; 038001B4
	str r0,[sp,#0x1c]	; 038001B6
	str r0,[sp,#0x18]	; 038001B8
	str r0,[sp,#0x10]	; 038001BA
	str r0,[sp,#0x8]	; 038001BC
loc_038001BE:
	ldr r6,[sp,#0x8]	; 038001BE
	lsl r7,r6,#0	; 038001C0
	lsl r4,r6,#0	; 038001C2
	ldr r1,[sp,#0x4]	; 038001C4
	mov r0,#0x54	; 038001C6
	mul r1,r0	; 038001C8
	ldr r0,[pool_03800388]	; 038001CA
	add r5,r0,r1	; 038001CC
	ldrb r0,[r5,#0x3]	; 038001CE
	lsl r1,r0,#0x1f	; 038001D0
	lsr r1,r1,#0x1f	; 038001D2
	cmp r1,#0x0	; 038001D4
	bne loc_038001DA	; 038001D6
	b loc_03800374	; 038001D8
loc_038001DA:
	lsl r0,r0,#0x1e	; 038001DA
	lsr r0,r0,#0x1f	; 038001DC
	cmp r0,#0x0	; 038001DE
	beq loc_038001F8	; 038001E0
	add r2,r5,#0x4	; 038001E2
	ldrb r1,[r2,#0x0]	; 038001E4
	mov r0,#0x1	; 038001E6
	orr r1,r0	; 038001E8
	strb r1,[r2,#0x0]	; 038001EA
	add r2,r5,#0x3	; 038001EC
	ldrb r1,[r2,#0x0]	; 038001EE
	mov r0,#0x2	; 038001F0
	bic r1,r0	; 038001F2
	strb r1,[r2,#0x0]	; 038001F4
	b loc_0380022C	; 038001F6
loc_038001F8:
	ldr r0,[sp,#0x4]	; 038001F8
	bl loc_037FF5B0	; 038001FA
	cmp r0,#0x0	; 038001FE
	bne loc_0380022C	; 03800200
	ldr r3,[r5,#0x48]	; 03800202
	cmp r3,#0x0	; 03800204
	beq loc_03800214	; 03800206
	add r0,r5,#0x0	; 03800208
	mov r1,#0x2	; 0380020A
	ldr r2,[r5,#0x4c]	; 0380020C
	bl loc_038050D8	; 0380020E
	b loc_0380021C	; 03800212
loc_03800214:
	add r1,r5,#0x0	; 03800214
	add r1,#0x22	; 03800216
	ldr r0,[sp,#0xc]	; 03800218
	strb r0,[r1,#0x0]	; 0380021A
loc_0380021C:
	ldr r0,[sp,#0x10]	; 0380021C
	strh r0,[r5,#0x24]	; 0380021E
	add r2,r5,#0x3	; 03800220
	ldrb r1,[r2,#0x0]	; 03800222
	mov r0,#0x1	; 03800224
	bic r1,r0	; 03800226
	strb r1,[r2,#0x0]	; 03800228
	b loc_03800374	; 0380022A
loc_0380022C:
	ldrb r0,[r5,#0x9]	; 0380022C
	lsl r1,r0,#0x1	; 0380022E
	ldr r0,[pool_0380038C]	; 03800230
	ldrsh r0,[r0,r1]	; 03800232
	add r6,r6,r0	; 03800234
	ldrb r1,[r5,#0x8]	; 03800236
	ldrb r0,[r5,#0x5]	; 03800238
	sub r0,r1,r0	; 0380023A
	lsl r0,r0,#0x6	; 0380023C
	add r7,r7,r0	; 0380023E
	add r0,r5,#0x0	; 03800240
	ldr r1,[sp,#0x0]	; 03800242
	bl loc_037FFC34	; 03800244
	add r6,r6,r0	; 03800248
	add r0,r5,#0x0	; 0380024A
	ldr r1,[sp,#0x0]	; 0380024C
	bl loc_037FFBE4	; 0380024E
	add r7,r7,r0	; 03800252
	add r0,r5,#0x0	; 03800254
	ldr r1,[sp,#0x0]	; 03800256
	bl loc_037FFB64	; 03800258
	add r1,r5,#0x0	; 0380025C
	add r1,#0x28	; 0380025E
	ldrb r1,[r1,#0x0]	; 03800260
	cmp r1,#0x0	; 03800262
	beq loc_03800274	; 03800264
	cmp r1,#0x1	; 03800266
	beq loc_03800270	; 03800268
	cmp r1,#0x2	; 0380026A
	beq loc_03800278	; 0380026C
	b loc_0380027A	; 0380026E
loc_03800270:
	add r6,r6,r0	; 03800270
	b loc_0380027A	; 03800272
loc_03800274:
	add r7,r7,r0	; 03800274
	b loc_0380027A	; 03800276
loc_03800278:
	add r4,r4,r0	; 03800278
loc_0380027A:
	mov r0,#0xc	; 0380027A
	ldrsh r0,[r5,r0]	; 0380027C
	add r6,r6,r0	; 0380027E
	mov r0,#0xe	; 03800280
	ldrsh r0,[r5,r0]	; 03800282
	add r7,r7,r0	; 03800284
	mov r0,#0xb	; 03800286
	ldrsb r0,[r5,r0]	; 03800288
	add r1,r4,r0	; 0380028A
	mov r0,#0xa	; 0380028C
	ldrsb r0,[r5,r0]	; 0380028E
	add r4,r1,r0	; 03800290
	ldrb r0,[r5,#0x2]	; 03800292
	cmp r0,#0x3	; 03800294
	bne loc_038002CC	; 03800296
	ldr r0,[pool_03800390]	; 03800298
	cmp r6,r0	; 0380029A
	bgt loc_038002CC	; 0380029C
	mov r0,#0x2	; 0380029E
	strb r0,[r5,#0x4]	; 038002A0
	ldr r3,[r5,#0x48]	; 038002A2
	cmp r3,#0x0	; 038002A4
	beq loc_038002B4	; 038002A6
	add r0,r5,#0x0	; 038002A8
	mov r1,#0x2	; 038002AA
	ldr r2,[r5,#0x4c]	; 038002AC
	bl loc_038050D8	; 038002AE
	b loc_038002BC	; 038002B2
loc_038002B4:
	add r1,r5,#0x0	; 038002B4
	add r1,#0x22	; 038002B6
	ldr r0,[sp,#0x14]	; 038002B8
	strb r0,[r1,#0x0]	; 038002BA
loc_038002BC:
	ldr r0,[sp,#0x18]	; 038002BC
	strh r0,[r5,#0x24]	; 038002BE
	add r2,r5,#0x3	; 038002C0
	ldrb r1,[r2,#0x0]	; 038002C2
	mov r0,#0x1	; 038002C4
	bic r1,r0	; 038002C6
	strb r1,[r2,#0x0]	; 038002C8
	b loc_03800374	; 038002CA
loc_038002CC:
	add r0,r6,#0x0	; 038002CC
	bl loc_037FF86C	; 038002CE
	add r6,r0,#0x0	; 038002D2
	ldrh r0,[r5,#0x3c]	; 038002D4
	add r1,r7,#0x0	; 038002D6
	bl loc_037FF8C4	; 038002D8
	ldrb r1,[r5,#0x1]	; 038002DC
	cmp r1,#0x1	; 038002DE
	bne loc_038002EA	; 038002E0
	ldr r1,[pool_03800394]	; 038002E2
	and r0,r1	; 038002E4
	lsl r0,r0,#0x10	; 038002E6
	lsr r0,r0,#0x10	; 038002E8
loc_038002EA:
	add r4,#0x40	; 038002EA
	cmp r4,#0x0	; 038002EC
	bge loc_038002F4	; 038002EE
	ldr r4,[sp,#0x1c]	; 038002F0
	b loc_038002FA	; 038002F2
loc_038002F4:
	cmp r4,#0x7f	; 038002F4
	ble loc_038002FA	; 038002F6
	mov r4,#0x7f	; 038002F8
loc_038002FA:
	ldrh r1,[r5,#0x24]	; 038002FA
	cmp r6,r1	; 038002FC
	beq loc_0380030C	; 038002FE
	strh r6,[r5,#0x24]	; 03800300
	add r3,r5,#0x4	; 03800302
	ldrb r2,[r3,#0x0]	; 03800304
	mov r1,#0x8	; 03800306
	orr r2,r1	; 03800308
	strb r2,[r3,#0x0]	; 0380030A
loc_0380030C:
	ldrh r1,[r5,#0x26]	; 0380030C
	cmp r0,r1	; 0380030E
	beq loc_0380031E	; 03800310
	strh r0,[r5,#0x26]	; 03800312
	add r2,r5,#0x4	; 03800314
	ldrb r1,[r2,#0x0]	; 03800316
	mov r0,#0x4	; 03800318
	orr r1,r0	; 0380031A
	strb r1,[r2,#0x0]	; 0380031C
loc_0380031E:
	add r0,r5,#0x0	; 0380031E
	add r0,#0x23	; 03800320
	ldrb r0,[r0,#0x0]	; 03800322
	cmp r4,r0	; 03800324
	beq loc_03800338	; 03800326
	add r0,r5,#0x0	; 03800328
	add r0,#0x23	; 0380032A
	strb r4,[r0,#0x0]	; 0380032C
	add r2,r5,#0x4	; 0380032E
	ldrb r1,[r2,#0x0]	; 03800330
	mov r0,#0x10	; 03800332
	orr r1,r0	; 03800334
	strb r1,[r2,#0x0]	; 03800336
loc_03800338:
	ldr r0,[sp,#0x0]	; 03800338
	cmp r0,#0x0	; 0380033A
	beq loc_03800374	; 0380033C
	ldr r0,[r5,#0x34]	; 0380033E
	cmp r0,#0x0	; 03800340
	ble loc_03800374	; 03800342
	add r1,r5,#0x0	; 03800344
	add r1,#0x34	; 03800346
	ldr r0,[r1,#0x0]	; 03800348
	sub r0,r0,#0x1	; 0380034A
	str r0,[r1,#0x0]	; 0380034C
	ldr r0,[r5,#0x34]	; 0380034E
	cmp r0,#0x0	; 03800350
	bne loc_03800374	; 03800352
	ldr r3,[r5,#0x48]	; 03800354
	cmp r3,#0x0	; 03800356
	beq loc_03800366	; 03800358
	add r0,r5,#0x0	; 0380035A
	mov r1,#0x1	; 0380035C
	ldr r2,[r5,#0x4c]	; 0380035E
	bl loc_038050D8	; 03800360
	b loc_0380036E	; 03800364
loc_03800366:
	add r1,r5,#0x0	; 03800366
	add r1,#0x22	; 03800368
	mov r0,#0x1	; 0380036A
	strb r0,[r1,#0x0]	; 0380036C
loc_0380036E:
	add r0,r5,#0x0	; 0380036E
	bl loc_038000CC	; 03800370
loc_03800374:
	ldr r0,[sp,#0x4]	; 03800374
	add r0,r0,#0x1	; 03800376
	str r0,[sp,#0x4]	; 03800378
	cmp r0,#0x10	; 0380037A
	bge loc_03800380	; 0380037C
	b loc_038001BE	; 0380037E
loc_03800380:
	add sp,#0x24	; 03800380
	pop {r4,r5,r6,r7}	; 03800382
	pop {r3}	; 03800384
	bx r3	; 03800386
pool_03800388:
loc_03800388:
	.word 0x03805F64	; 03800388
pool_0380038C:
loc_0380038C:
	.word P2_Data_03805168	; 0380038C
pool_03800390:
loc_03800390:
	.word 0xFFFFFD2D	; 03800390
pool_03800394:
loc_03800394:
	.word 0x0000FFFC	; 03800394
P2_Entry_03800398:
	push {r4,r5,r6,r7,lr}	; 03800398
	sub sp,#0x1c	; 0380039A
	mov r4,#0x0	; 0380039C
	add r7,r4,#0x0	; 0380039E
	mov r6,#0xff	; 038003A0
P2_Entry_038003A2:
	add r1,r4,#0x0	; 038003A2
	mov r0,#0x54	; 038003A4
	mul r1,r0	; 038003A6
	ldr r0,[pool_038004D0]	; 038003A8
	add r5,r0,r1	; 038003AA
	ldrb r1,[r5,#0x4]	; 038003AC
	cmp r1,#0x0	; 038003AE
	beq P2_Entry_03800490	; 038003B0
	mov r0,#0x2	; 038003B2
	and r1,r0	; 038003B4
	cmp r1,#0x0	; 038003B6
	beq P2_Entry_038003C2	; 038003B8
	add r0,r4,#0x0	; 038003BA
	add r1,r7,#0x0	; 038003BC
	bl loc_037FF67C	; 038003BE
P2_Entry_038003C2:
	ldrb r0,[r5,#0x4]	; 038003C2
	add r2,r0,#0x0	; 038003C4
	mov r1,#0x1	; 038003C6
	and r2,r1	; 038003C8
	cmp r2,#0x0	; 038003CA
	beq P2_Entry_03800454	; 038003CC
	ldrb r0,[r5,#0x1]	; 038003CE
	cmp r0,#0x0	; 038003D0
	beq P2_Entry_038003DE	; 038003D2
	cmp r0,#0x1	; 038003D4
	beq P2_Entry_0380041C	; 038003D6
	cmp r0,#0x2	; 038003D8
	beq P2_Entry_0380043A	; 038003DA
	b P2_Entry_03800490	; 038003DC
P2_Entry_038003DE:
	add r0,r5,#0x0	; 038003DE
	add r0,#0x39	; 038003E0
	ldrb r0,[r0,#0x0]	; 038003E2
	cmp r0,#0x0	; 038003E4
	beq P2_Entry_038003EC	; 038003E6
	lsl r3,r1,#0	; 038003E8
	b P2_Entry_038003EE	; 038003EA
P2_Entry_038003EC:
	mov r3,#0x2	; 038003EC
P2_Entry_038003EE:
	ldrh r0,[r5,#0x24]	; 038003EE
	ldrh r1,[r5,#0x3e]	; 038003F0
	str r1,[sp,#0x0]	; 038003F2
	ldr r1,[r5,#0x40]	; 038003F4
	str r1,[sp,#0x4]	; 038003F6
	add r1,r0,#0x0	; 038003F8
	and r1,r6	; 038003FA
	str r1,[sp,#0x8]	; 038003FC
	asr r0,r0,#0x8	; 038003FE
	str r0,[sp,#0xc]	; 03800400
	ldrh r0,[r5,#0x26]	; 03800402
	str r0,[sp,#0x10]	; 03800404
	add r0,r5,#0x0	; 03800406
	add r0,#0x23	; 03800408
	ldrb r0,[r0,#0x0]	; 0380040A
	str r0,[sp,#0x14]	; 0380040C
	add r0,r4,#0x0	; 0380040E
	ldr r1,[r5,#0x44]	; 03800410
	add r5,#0x38	; 03800412
	ldrb r2,[r5,#0x0]	; 03800414
	bl loc_037FF778	; 03800416
	b P2_Entry_03800490	; 0380041A
P2_Entry_0380041C:
	ldrh r3,[r5,#0x24]	; 0380041C
	ldrh r0,[r5,#0x26]	; 0380041E
	str r0,[sp,#0x0]	; 03800420
	add r0,r5,#0x0	; 03800422
	add r0,#0x23	; 03800424
	ldrb r0,[r0,#0x0]	; 03800426
	str r0,[sp,#0x4]	; 03800428
	add r0,r4,#0x0	; 0380042A
	ldr r1,[r5,#0x44]	; 0380042C
	add r2,r3,#0x0	; 0380042E
	and r2,r6	; 03800430
	asr r3,r3,#0x8	; 03800432
	bl loc_037FF70C	; 03800434
	b P2_Entry_03800490	; 03800438
P2_Entry_0380043A:
	ldrh r2,[r5,#0x24]	; 0380043A
	add r0,r5,#0x0	; 0380043C
	add r0,#0x23	; 0380043E
	ldrb r0,[r0,#0x0]	; 03800440
	str r0,[sp,#0x0]	; 03800442
	add r0,r4,#0x0	; 03800444
	add r1,r2,#0x0	; 03800446
	and r1,r6	; 03800448
	asr r2,r2,#0x8	; 0380044A
	ldrh r3,[r5,#0x26]	; 0380044C
	bl loc_037FF6A4	; 0380044E
	b P2_Entry_03800490	; 03800452
P2_Entry_03800454:
	mov r1,#0x4	; 03800454
	and r0,r1	; 03800456
	cmp r0,#0x0	; 03800458
	beq P2_Entry_03800464	; 0380045A
	add r0,r4,#0x0	; 0380045C
	ldrh r1,[r5,#0x26]	; 0380045E
	bl loc_037FF610	; 03800460
P2_Entry_03800464:
	ldrb r1,[r5,#0x4]	; 03800464
	mov r0,#0x8	; 03800466
	and r1,r0	; 03800468
	cmp r1,#0x0	; 0380046A
	beq P2_Entry_0380047C	; 0380046C
	ldrh r2,[r5,#0x24]	; 0380046E
	add r0,r4,#0x0	; 03800470
	add r1,r2,#0x0	; 03800472
	and r1,r6	; 03800474
	asr r2,r2,#0x8	; 03800476
	bl loc_037FF624	; 03800478
P2_Entry_0380047C:
	ldrb r1,[r5,#0x4]	; 0380047C
	mov r0,#0x10	; 0380047E
	and r1,r0	; 03800480
	cmp r1,#0x0	; 03800482
	beq P2_Entry_03800490	; 03800484
	add r0,r4,#0x0	; 03800486
	add r5,#0x23	; 03800488
	ldrb r1,[r5,#0x0]	; 0380048A
	bl loc_037FF5CC	; 0380048C
P2_Entry_03800490:
	add r4,r4,#0x1	; 03800490
	cmp r4,#0x10	; 03800492
	blt P2_Entry_038003A2	; 03800494
	mov r2,#0x0	; 03800496
	add r5,r2,#0x0	; 03800498
	ldr r0,[pool_038004D0]	; 0380049A
	mov r4,#0x54	; 0380049C
P2_Entry_0380049E:
	add r1,r2,#0x0	; 0380049E
	mul r1,r4	; 038004A0
	add r1,r0,r1	; 038004A2
	ldrb r6,[r1,#0x4]	; 038004A4
	cmp r6,#0x0	; 038004A6
	beq P2_Entry_038004C2	; 038004A8
	mov r3,#0x1	; 038004AA
	and r6,r3	; 038004AC
	cmp r6,#0x0	; 038004AE
	beq P2_Entry_038004C0	; 038004B0
	lsl r6,r2,#0x4	; 038004B2
	ldr r3,[pool_038004D4]	; 038004B4
	add r7,r6,r3	; 038004B6
	ldrb r6,[r7,#0x0]	; 038004B8
	mov r3,#0x80	; 038004BA
	orr r6,r3	; 038004BC
	strb r6,[r7,#0x0]	; 038004BE
P2_Entry_038004C0:
	strb r5,[r1,#0x4]	; 038004C0
P2_Entry_038004C2:
	add r2,r2,#0x1	; 038004C2
	cmp r2,#0x10	; 038004C4
	blt P2_Entry_0380049E	; 038004C6
	add sp,#0x1c	; 038004C8
	pop {r4,r5,r6,r7}	; 038004CA
	pop {r3}	; 038004CC
	bx r3	; 038004CE
pool_038004D0:
	.word 0x03805F64	; 038004D0
pool_038004D4:
	.word SCHANNEL0_CR + 3	; 038004D4
P2_Entry_038004D8:
	push {r4,r5,r6,lr}	; 038004D8
	mov r0,#0x0	; 038004DA
	ldr r6,[pool_0380050C]	; 038004DC
	add r5,r0,#0x0	; 038004DE
	mov r1,#0x54	; 038004E0
	mov r2,#0x1	; 038004E2
P2_Entry_038004E4:
	add r3,r0,#0x0	; 038004E4
	mul r3,r1	; 038004E6
	add r4,r6,r3	; 038004E8
	strb r0,[r6,r3]	; 038004EA
	strb r5,[r4,#0x4]	; 038004EC
	add r4,r4,#0x3	; 038004EE
	ldrb r3,[r4,#0x0]	; 038004F0
	bic r3,r2	; 038004F2
	strb r3,[r4,#0x0]	; 038004F4
	add r0,r0,#0x1	; 038004F6
	cmp r0,#0x10	; 038004F8
	blt P2_Entry_038004E4	; 038004FA
	ldr r0,[pool_03800510]	; 038004FC
	str r5,[r0,#0x0]	; 038004FE
	ldr r0,[pool_03800514]	; 03800500
	str r5,[r0,#0x0]	; 03800502
	pop {r4,r5,r6}	; 03800504
	pop {r3}	; 03800506
	bx r3	; 03800508
	.byte 0xC0, 0x46	; 0380050A
pool_0380050C:
	.word P2_BssStart + 0xB84	; 0380050C
pool_03800510:
	.word P2_BssStart + 0xB64	; 03800510
pool_03800514:
	.word P2_BssStart + 0xB60	; 03800514

; ===== function loc_03800518 =====
loc_03800518:
	push {r4,lr}	; 03800518
	mov r0,#0x0	; 0380051A
	ldr r3,[pool_03800548]	; 0380051C
	b loc_0380053A	; 0380051E
loc_03800520:
	lsl r1,r0,#0x6	; 03800520
	add r4,r3,r1	; 03800522
	ldrb r2,[r3,r1]	; 03800524
	lsl r1,r2,#0x1f	; 03800526
	lsr r1,r1,#0x1f	; 03800528
	cmp r1,#0x0	; 0380052A
	bne loc_03800538	; 0380052C
	mov r1,#0x1	; 0380052E
	bic r2,r1	; 03800530
	orr r2,r1	; 03800532
	strb r2,[r4,#0x0]	; 03800534
	b loc_03800542	; 03800536
loc_03800538:
	add r0,r0,#0x1	; 03800538
loc_0380053A:
	cmp r0,#0x20	; 0380053A
	blt loc_03800520	; 0380053C
	mov r0,#0x0	; 0380053E
	mvn r0,r0	; 03800540
loc_03800542:
	pop {r4}	; 03800542
	pop {r3}	; 03800544
	bx r3	; 03800546
pool_03800548:
loc_03800548:
	.word 0x038066E4	; 03800548

; ===== function loc_0380054C =====
loc_0380054C:
	ldr r2,[pool_03800578]	; 0380054C
	ldr r3,[r2,#0x0]	; 0380054E
	cmp r3,#0x0	; 03800550
	bne loc_03800558	; 03800552
	mov r0,#0x0	; 03800554
	bx lr	; 03800556
loc_03800558:
	cmp r1,#0x10	; 03800558
	bge loc_0380056C	; 0380055A
	add r3,#0x20	; 0380055C
	ldrb r2,[r0,#0x2]	; 0380055E
	mov r0,#0x24	; 03800560
	mul r2,r0	; 03800562
	add r2,r3,r2	; 03800564
	lsl r0,r1,#0x1	; 03800566
	add r0,r2,r0	; 03800568
	bx lr	; 0380056A
loc_0380056C:
	ldr r0,[pool_0380057C]	; 0380056C
	add r2,r3,r0	; 0380056E
	sub r1,#0x10	; 03800570
	lsl r0,r1,#0x1	; 03800572
	add r0,r2,r0	; 03800574
	bx lr	; 03800576
pool_03800578:
loc_03800578:
	.word P2_BssStart + 0xB80	; 03800578
pool_0380057C:
loc_0380057C:
	.word 0x00000260	; 0380057C
P2_Entry_03800580:
	push {r4,r5,r6,r7,lr}	; 03800580
	sub sp,#0x4	; 03800582
	add r5,r0,#0x0	; 03800584
	mov r6,#0x0	; 03800586
	add r4,r6,#0x0	; 03800588
	mov r7,#0x1	; 0380058A
P2_Entry_0380058C:
	add r0,r5,#0x0	; 0380058C
	add r1,r4,#0x0	; 0380058E
	bl loc_03800EC4	; 03800590
	cmp r0,#0x0	; 03800594
	beq P2_Entry_038005B4	; 03800596
	ldr r1,[r0,#0x28]	; 03800598
	cmp r1,#0x0	; 0380059A
	beq P2_Entry_038005B4	; 0380059C
	add r1,r5,#0x0	; 0380059E
	bl P2_Entry_038005CC	; 038005A0
	cmp r0,#0x0	; 038005A4
	bne P2_Entry_038005AC	; 038005A6
	add r6,r7,#0x0	; 038005A8
	b P2_Entry_038005B4	; 038005AA
P2_Entry_038005AC:
	add r0,r5,#0x0	; 038005AC
	add r1,r4,#0x0	; 038005AE
	bl loc_03800E80	; 038005B0
P2_Entry_038005B4:
	add r4,r4,#0x1	; 038005B4
	cmp r4,#0x10	; 038005B6
	blt P2_Entry_0380058C	; 038005B8
	cmp r6,#0x0	; 038005BA
	bne P2_Entry_038005C2	; 038005BC
	mov r0,#0x1	; 038005BE
	b P2_Entry_038005C4	; 038005C0
P2_Entry_038005C2:
	mov r0,#0x0	; 038005C2
P2_Entry_038005C4:
	add sp,#0x4	; 038005C4
	pop {r4,r5,r6,r7}	; 038005C6
	pop {r3}	; 038005C8
	bx r3	; 038005CA
P2_Entry_038005CC:
	push {r4,r5,r6,r7,lr}	; 038005CC
	sub sp,#0x24	; 038005CE
	add r4,r0,#0x0	; 038005D0
	str r1,[sp,#0x4]	; 038005D2
	ldrb r1,[r4,#0x0]	; 038005D4
	lsl r0,r1,#0x1b	; 038005D6
	lsr r0,r0,#0x1f	; 038005D8
	cmp r0,#0x0	; 038005DA
	beq P2_Entry_038005EE	; 038005DC
	ldr r0,[r4,#0x3c]	; 038005DE
	cmp r0,#0x0	; 038005E0
	beq P2_Entry_038005E8	; 038005E2
	mov r0,#0x0	; 038005E4
	b P2_Entry_03800BF0	; 038005E6
P2_Entry_038005E8:
	mov r0,#0x10	; 038005E8
	bic r1,r0	; 038005EA
	strb r1,[r4,#0x0]	; 038005EC
P2_Entry_038005EE:
	ldr r0,[r4,#0x20]	; 038005EE
	cmp r0,#0x0	; 038005F0
	ble P2_Entry_03800608	; 038005F2
	add r1,r4,#0x0	; 038005F4
	add r1,#0x20	; 038005F6
	ldr r0,[r1,#0x0]	; 038005F8
	sub r0,r0,#0x1	; 038005FA
	str r0,[r1,#0x0]	; 038005FC
	ldr r0,[r4,#0x20]	; 038005FE
	cmp r0,#0x0	; 03800600
	ble P2_Entry_03800608	; 03800602
	mov r0,#0x0	; 03800604
	b P2_Entry_03800BF0	; 03800606
P2_Entry_03800608:
	ldr r0,[r4,#0x28]	; 03800608
	bl loc_03801214	; 0380060A
	mov r0,#0x0	; 0380060E
	mvn r0,r0	; 03800610
	str r0,[sp,#0x18]	; 03800612
	b P2_Entry_03800BDC	; 03800614
P2_Entry_03800616:
	mov r5,#0x0	; 03800616
	mov r0,#0x1	; 03800618
	str r0,[sp,#0xc]	; 0380061A
	add r0,r4,#0x0	; 0380061C
	bl loc_038011CC	; 0380061E
	add r6,r0,#0x0	; 03800622
	cmp r6,#0xa2	; 03800624
	bne P2_Entry_03800638	; 03800626
	add r0,r4,#0x0	; 03800628
	bl loc_038011CC	; 0380062A
	add r6,r0,#0x0	; 0380062E
	ldrb r0,[r4,#0x0]	; 03800630
	lsl r0,r0,#0x19	; 03800632
	lsr r0,r0,#0x1f	; 03800634
	str r0,[sp,#0xc]	; 03800636
P2_Entry_03800638:
	cmp r6,#0xa0	; 03800638
	bne P2_Entry_0380064A	; 0380063A
	add r0,r4,#0x0	; 0380063C
	bl loc_038011CC	; 0380063E
	add r6,r0,#0x0	; 03800642
	mov r0,#0x3	; 03800644
	str r0,[sp,#0x8]	; 03800646
	mov r5,#0x1	; 03800648
P2_Entry_0380064A:
	cmp r6,#0xa1	; 0380064A
	bne P2_Entry_0380065C	; 0380064C
	add r0,r4,#0x0	; 0380064E
	bl loc_038011CC	; 03800650
	add r6,r0,#0x0	; 03800654
	mov r0,#0x4	; 03800656
	str r0,[sp,#0x8]	; 03800658
	mov r5,#0x1	; 0380065A
P2_Entry_0380065C:
	add r1,r6,#0x0	; 0380065C
	mov r0,#0x80	; 0380065E
	and r1,r0	; 03800660
	cmp r1,#0x0	; 03800662
	bne P2_Entry_038006D6	; 03800664
	add r0,r4,#0x0	; 03800666
	bl loc_038011CC	; 03800668
	str r0,[sp,#0x10]	; 0380066C
	cmp r5,#0x0	; 0380066E
	beq P2_Entry_03800676	; 03800670
	ldr r2,[sp,#0x8]	; 03800672
	b P2_Entry_03800678	; 03800674
P2_Entry_03800676:
	mov r2,#0x2	; 03800676
P2_Entry_03800678:
	add r0,r4,#0x0	; 03800678
	ldr r1,[sp,#0x4]	; 0380067A
	bl P2_Entry_038010A0	; 0380067C
	add r7,r0,#0x0	; 03800680
	mov r0,#0x13	; 03800682
	ldrsb r0,[r4,r0]	; 03800684
	add r5,r6,r0	; 03800686
	ldr r0,[sp,#0xc]	; 03800688
	cmp r0,#0x0	; 0380068A
	bne P2_Entry_03800690	; 0380068C
	b P2_Entry_03800BDC	; 0380068E
P2_Entry_03800690:
	cmp r5,#0x0	; 03800690
	bge P2_Entry_03800698	; 03800692
	mov r5,#0x0	; 03800694
	b P2_Entry_0380069E	; 03800696
P2_Entry_03800698:
	cmp r5,#0x7f	; 03800698
	ble P2_Entry_0380069E	; 0380069A
	mov r5,#0x7f	; 0380069C
P2_Entry_0380069E:
	ldrb r0,[r4,#0x0]	; 0380069E
	lsl r0,r0,#0x1d	; 038006A0
	lsr r0,r0,#0x1f	; 038006A2
	cmp r0,#0x0	; 038006A4
	bne P2_Entry_038006B6	; 038006A6
	str r7,[sp,#0x0]	; 038006A8
	add r0,r4,#0x0	; 038006AA
	ldr r1,[sp,#0x4]	; 038006AC
	add r2,r5,#0x0	; 038006AE
	ldr r3,[sp,#0x10]	; 038006B0
	bl P2_Entry_03800BF8	; 038006B2
P2_Entry_038006B6:
	strb r5,[r4,#0x14]	; 038006B6
	ldrb r0,[r4,#0x0]	; 038006B8
	lsl r0,r0,#0x1e	; 038006BA
	lsr r0,r0,#0x1f	; 038006BC
	cmp r0,#0x0	; 038006BE
	bne P2_Entry_038006C4	; 038006C0
	b P2_Entry_03800BDC	; 038006C2
P2_Entry_038006C4:
	str r7,[r4,#0x20]	; 038006C4
	cmp r7,#0x0	; 038006C6
	beq P2_Entry_038006CC	; 038006C8
	b P2_Entry_03800BDC	; 038006CA
P2_Entry_038006CC:
	ldrb r1,[r4,#0x0]	; 038006CC
	mov r0,#0x10	; 038006CE
	orr r1,r0	; 038006D0
	strb r1,[r4,#0x0]	; 038006D2
	b P2_Entry_03800BDC	; 038006D4
P2_Entry_038006D6:
	add r1,r6,#0x0	; 038006D6
	mov r0,#0xf0	; 038006D8
	and r1,r0	; 038006DA
	cmp r1,#0xc0	; 038006DC
	bgt P2_Entry_038006FA	; 038006DE
	cmp r1,#0xc0	; 038006E0
	bge P2_Entry_038007DE	; 038006E2
	cmp r1,#0x90	; 038006E4
	bgt P2_Entry_038006F2	; 038006E6
	cmp r1,#0x90	; 038006E8
	bge P2_Entry_03800746	; 038006EA
	cmp r1,#0x80	; 038006EC
	beq P2_Entry_03800712	; 038006EE
	b P2_Entry_03800BDC	; 038006F0
P2_Entry_038006F2:
	cmp r1,#0xb0	; 038006F2
	bne P2_Entry_038006F8	; 038006F4
	b P2_Entry_038009AA	; 038006F6
P2_Entry_038006F8:
	b P2_Entry_03800BDC	; 038006F8
P2_Entry_038006FA:
	cmp r1,#0xe0	; 038006FA
	bgt P2_Entry_0380070A	; 038006FC
	cmp r1,#0xe0	; 038006FE
	blt P2_Entry_03800704	; 03800700
	b P2_Entry_03800970	; 03800702
P2_Entry_03800704:
	cmp r1,#0xd0	; 03800704
	beq P2_Entry_038007DE	; 03800706
	b P2_Entry_03800BDC	; 03800708
P2_Entry_0380070A:
	cmp r1,#0xf0	; 0380070A
	bne P2_Entry_03800710	; 0380070C
	b P2_Entry_03800B4C	; 0380070E
P2_Entry_03800710:
	b P2_Entry_03800BDC	; 03800710
P2_Entry_03800712:
	cmp r5,#0x0	; 03800712
	beq P2_Entry_0380071A	; 03800714
	ldr r2,[sp,#0x8]	; 03800716
	b P2_Entry_0380071C	; 03800718
P2_Entry_0380071A:
	mov r2,#0x2	; 0380071A
P2_Entry_0380071C:
	add r0,r4,#0x0	; 0380071C
	ldr r1,[sp,#0x4]	; 0380071E
	bl P2_Entry_038010A0	; 03800720
	ldr r1,[sp,#0xc]	; 03800724
	cmp r1,#0x0	; 03800726
	bne P2_Entry_0380072C	; 03800728
	b P2_Entry_03800BDC	; 0380072A
P2_Entry_0380072C:
	cmp r6,#0x80	; 0380072C
	beq P2_Entry_03800736	; 0380072E
	cmp r6,#0x81	; 03800730
	beq P2_Entry_0380073A	; 03800732
	b P2_Entry_03800BDC	; 03800734
P2_Entry_03800736:
	str r0,[r4,#0x20]	; 03800736
	b P2_Entry_03800BDC	; 03800738
P2_Entry_0380073A:
	ldr r1,[pool_03800A7C]	; 0380073A
	cmp r0,r1	; 0380073C
	blt P2_Entry_03800742	; 0380073E
	b P2_Entry_03800BDC	; 03800740
P2_Entry_03800742:
	strh r0,[r4,#0x2]	; 03800742
	b P2_Entry_03800BDC	; 03800744
P2_Entry_03800746:
	cmp r6,#0x93	; 03800746
	beq P2_Entry_03800754	; 03800748
	cmp r6,#0x94	; 0380074A
	beq P2_Entry_03800794	; 0380074C
	cmp r6,#0x95	; 0380074E
	beq P2_Entry_038007AA	; 03800750
	b P2_Entry_03800BDC	; 03800752
P2_Entry_03800754:
	add r0,r4,#0x0	; 03800754
	bl loc_038011CC	; 03800756
	add r5,r0,#0x0	; 0380075A
	add r0,r4,#0x0	; 0380075C
	bl P2_Entry_0380114C	; 0380075E
	add r6,r0,#0x0	; 03800762
	ldr r0,[sp,#0xc]	; 03800764
	cmp r0,#0x0	; 03800766
	bne P2_Entry_0380076C	; 03800768
	b P2_Entry_03800BDC	; 0380076A
P2_Entry_0380076C:
	ldr r0,[sp,#0x4]	; 0380076C
	add r1,r5,#0x0	; 0380076E
	bl loc_03800EC4	; 03800770
	add r5,r0,#0x0	; 03800774
	cmp r5,#0x0	; 03800776
	bne P2_Entry_0380077C	; 03800778
	b P2_Entry_03800BDC	; 0380077A
P2_Entry_0380077C:
	cmp r5,r4	; 0380077C
	bne P2_Entry_03800782	; 0380077E
	b P2_Entry_03800BDC	; 03800780
P2_Entry_03800782:
	ldr r1,[sp,#0x4]	; 03800782
	bl loc_03800EB8	; 03800784
	add r0,r5,#0x0	; 03800788
	ldr r1,[r4,#0x24]	; 0380078A
	add r2,r6,#0x0	; 0380078C
	bl loc_03801000	; 0380078E
	b P2_Entry_03800BDC	; 03800792
P2_Entry_03800794:
	add r0,r4,#0x0	; 03800794
	bl P2_Entry_0380114C	; 03800796
	ldr r1,[sp,#0xc]	; 0380079A
	cmp r1,#0x0	; 0380079C
	bne P2_Entry_038007A2	; 0380079E
	b P2_Entry_03800BDC	; 038007A0
P2_Entry_038007A2:
	ldr r1,[r4,#0x24]	; 038007A2
	add r0,r1,r0	; 038007A4
	str r0,[r4,#0x28]	; 038007A6
	b P2_Entry_03800BDC	; 038007A8
P2_Entry_038007AA:
	add r0,r4,#0x0	; 038007AA
	bl P2_Entry_0380114C	; 038007AC
	ldr r1,[sp,#0xc]	; 038007B0
	cmp r1,#0x0	; 038007B2
	bne P2_Entry_038007B8	; 038007B4
	b P2_Entry_03800BDC	; 038007B6
P2_Entry_038007B8:
	add r1,r4,#0x0	; 038007B8
	add r1,#0x3b	; 038007BA
	ldrb r1,[r1,#0x0]	; 038007BC
	cmp r1,#0x3	; 038007BE
	bcc P2_Entry_038007C4	; 038007C0
	b P2_Entry_03800BDC	; 038007C2
P2_Entry_038007C4:
	ldr r2,[r4,#0x28]	; 038007C4
	lsl r1,r1,#0x2	; 038007C6
	add r1,r4,r1	; 038007C8
	str r2,[r1,#0x2c]	; 038007CA
	add r2,r4,#0x0	; 038007CC
	add r2,#0x3b	; 038007CE
	ldrb r1,[r2,#0x0]	; 038007D0
	add r1,r1,#0x1	; 038007D2
	strb r1,[r2,#0x0]	; 038007D4
	ldr r1,[r4,#0x24]	; 038007D6
	add r0,r1,r0	; 038007D8
	str r0,[r4,#0x28]	; 038007DA
	b P2_Entry_03800BDC	; 038007DC
P2_Entry_038007DE:
	cmp r5,#0x0	; 038007DE
	beq P2_Entry_038007E6	; 038007E0
	ldr r2,[sp,#0x8]	; 038007E2
	b P2_Entry_038007E8	; 038007E4
P2_Entry_038007E6:
	mov r2,#0x0	; 038007E6
P2_Entry_038007E8:
	add r0,r4,#0x0	; 038007E8
	ldr r1,[sp,#0x4]	; 038007EA
	bl P2_Entry_038010A0	; 038007EC
	add r1,sp,#0x1c	; 038007F0
	strb r0,[r1,#0x0]	; 038007F2
	ldr r0,[sp,#0xc]	; 038007F4
	cmp r0,#0x0	; 038007F6
	bne P2_Entry_038007FC	; 038007F8
	b P2_Entry_03800BDC	; 038007FA
P2_Entry_038007FC:
	sub r6,#0xc0	; 038007FC
	cmp r6,#0x15	; 038007FE
	bls P2_Entry_03800804	; 03800800
	b P2_Entry_03800BDC	; 03800802
P2_Entry_03800804:
	add r0,r6,r6	; 03800804
P2_SwitchIndexPC_03800804:
	add r0,pc	; 03800806
	ldrh r0,[r0,#(P2_SwitchTable_03800804 - (P2_SwitchIndexPC_03800804 + 4))]	; 03800808
	lsl r0,r0,#0x10	; 0380080A
	asr r0,r0,#0x10	; 0380080C
P2_SwitchTargetPC_03800804:
	add r0,pc	; 0380080E
	bx r0	; 03800810
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800804:
	.halfword (P2_Case_03800966 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_0380083E + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_0380084E + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800956 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_0380095E + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800858 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800860 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800868 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_038008F6 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800916 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800886 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_0380088E + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800896 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_0380089E + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800936 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_0380087E + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_038008A6 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_038008AE + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_038008B6 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_038008BE + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_038008C6 + 1) - (P2_SwitchTargetPC_03800804 + 4)
	.halfword (P2_Case_03800846 + 1) - (P2_SwitchTargetPC_03800804 + 4)
P2_SwitchTable_03800804End:
P2_Case_0380083E:
	lsl r0,r1,#0	; 0380083E
	ldrb r0,[r0,#0x0]	; 03800840
	strb r0,[r4,#0x4]	; 03800842
	b P2_Entry_03800BDC	; 03800844
P2_Case_03800846:
	lsl r0,r1,#0	; 03800846
	ldrb r0,[r0,#0x0]	; 03800848
	strb r0,[r4,#0x5]	; 0380084A
	b P2_Entry_03800BDC	; 0380084C
P2_Case_0380084E:
	lsl r0,r1,#0	; 0380084E
	ldrb r1,[r0,#0x0]	; 03800850
	ldr r0,[sp,#0x4]	; 03800852
	strb r1,[r0,#0x5]	; 03800854
	b P2_Entry_03800BDC	; 03800856
P2_Case_03800858:
	lsl r0,r1,#0	; 03800858
	ldrb r0,[r0,#0x0]	; 0380085A
	strb r0,[r4,#0x7]	; 0380085C
	b P2_Entry_03800BDC	; 0380085E
P2_Case_03800860:
	lsl r0,r1,#0	; 03800860
	ldrb r0,[r0,#0x0]	; 03800862
	strb r0,[r4,#0x12]	; 03800864
	b P2_Entry_03800BDC	; 03800866
P2_Case_03800868:
	ldrb r0,[r4,#0x0]	; 03800868
	mov r1,#0x2	; 0380086A
	bic r0,r1	; 0380086C
	add r1,sp,#0x1c	; 0380086E
	ldrb r2,[r1,#0x0]	; 03800870
	mov r1,#0x1	; 03800872
	and r2,r1	; 03800874
	lsl r1,r2,#0x1	; 03800876
	orr r0,r1	; 03800878
	strb r0,[r4,#0x0]	; 0380087A
	b P2_Entry_03800BDC	; 0380087C
P2_Case_0380087E:
	lsl r0,r1,#0	; 0380087E
	ldrb r0,[r0,#0x0]	; 03800880
	strb r0,[r4,#0x15]	; 03800882
	b P2_Entry_03800BDC	; 03800884
P2_Case_03800886:
	lsl r0,r1,#0	; 03800886
	ldrb r0,[r0,#0x0]	; 03800888
	strb r0,[r4,#0x1a]	; 0380088A
	b P2_Entry_03800BDC	; 0380088C
P2_Case_0380088E:
	lsl r0,r1,#0	; 0380088E
	ldrb r0,[r0,#0x0]	; 03800890
	strb r0,[r4,#0x19]	; 03800892
	b P2_Entry_03800BDC	; 03800894
P2_Case_03800896:
	lsl r0,r1,#0	; 03800896
	ldrb r0,[r0,#0x0]	; 03800898
	strb r0,[r4,#0x18]	; 0380089A
	b P2_Entry_03800BDC	; 0380089C
P2_Case_0380089E:
	lsl r0,r1,#0	; 0380089E
	ldrb r0,[r0,#0x0]	; 038008A0
	strb r0,[r4,#0x1b]	; 038008A2
	b P2_Entry_03800BDC	; 038008A4
P2_Case_038008A6:
	lsl r0,r1,#0	; 038008A6
	ldrb r0,[r0,#0x0]	; 038008A8
	strb r0,[r4,#0xe]	; 038008AA
	b P2_Entry_03800BDC	; 038008AC
P2_Case_038008AE:
	lsl r0,r1,#0	; 038008AE
	ldrb r0,[r0,#0x0]	; 038008B0
	strb r0,[r4,#0xf]	; 038008B2
	b P2_Entry_03800BDC	; 038008B4
P2_Case_038008B6:
	lsl r0,r1,#0	; 038008B6
	ldrb r0,[r0,#0x0]	; 038008B8
	strb r0,[r4,#0x10]	; 038008BA
	b P2_Entry_03800BDC	; 038008BC
P2_Case_038008BE:
	lsl r0,r1,#0	; 038008BE
	ldrb r0,[r0,#0x0]	; 038008C0
	strb r0,[r4,#0x11]	; 038008C2
	b P2_Entry_03800BDC	; 038008C4
P2_Case_038008C6:
	add r0,r4,#0x0	; 038008C6
	add r0,#0x3b	; 038008C8
	ldrb r0,[r0,#0x0]	; 038008CA
	cmp r0,#0x3	; 038008CC
	bcc P2_Entry_038008D2	; 038008CE
	b P2_Entry_03800BDC	; 038008D0
P2_Entry_038008D2:
	ldr r1,[r4,#0x28]	; 038008D2
	lsl r0,r0,#0x2	; 038008D4
	add r0,r4,r0	; 038008D6
	str r1,[r0,#0x2c]	; 038008D8
	add r0,sp,#0x1c	; 038008DA
	ldrb r1,[r0,#0x0]	; 038008DC
	add r0,r4,#0x0	; 038008DE
	add r0,#0x3b	; 038008E0
	ldrb r0,[r0,#0x0]	; 038008E2
	add r0,r4,r0	; 038008E4
	add r0,#0x38	; 038008E6
	strb r1,[r0,#0x0]	; 038008E8
	add r1,r4,#0x0	; 038008EA
	add r1,#0x3b	; 038008EC
	ldrb r0,[r1,#0x0]	; 038008EE
	add r0,r0,#0x1	; 038008F0
	strb r0,[r1,#0x0]	; 038008F2
	b P2_Entry_03800BDC	; 038008F4
P2_Case_038008F6:
	ldrb r0,[r4,#0x0]	; 038008F6
	mov r1,#0x8	; 038008F8
	bic r0,r1	; 038008FA
	add r1,sp,#0x1c	; 038008FC
	ldrb r2,[r1,#0x0]	; 038008FE
	mov r1,#0x1	; 03800900
	and r2,r1	; 03800902
	lsl r1,r2,#0x3	; 03800904
	orr r0,r1	; 03800906
	strb r0,[r4,#0x0]	; 03800908
	add r0,r4,#0x0	; 0380090A
	ldr r1,[sp,#0x4]	; 0380090C
	ldr r2,[sp,#0x18]	; 0380090E
	bl loc_03800F4C	; 03800910
	b P2_Entry_03800BDC	; 03800914
P2_Case_03800916:
	lsl r0,r1,#0	; 03800916
	ldrb r1,[r0,#0x0]	; 03800918
	mov r0,#0x13	; 0380091A
	ldrsb r0,[r4,r0]	; 0380091C
	add r0,r1,r0	; 0380091E
	strb r0,[r4,#0x14]	; 03800920
	ldrb r1,[r4,#0x0]	; 03800922
	mov r0,#0x20	; 03800924
	orr r1,r0	; 03800926
	strb r1,[r4,#0x0]	; 03800928
	add r0,r4,#0x0	; 0380092A
	ldr r1,[sp,#0x4]	; 0380092C
	ldr r2,[sp,#0x18]	; 0380092E
	bl loc_03800F4C	; 03800930
	b P2_Entry_03800BDC	; 03800934
P2_Case_03800936:
	ldrb r0,[r4,#0x0]	; 03800936
	mov r1,#0x20	; 03800938
	bic r0,r1	; 0380093A
	add r1,sp,#0x1c	; 0380093C
	ldrb r2,[r1,#0x0]	; 0380093E
	mov r1,#0x1	; 03800940
	and r2,r1	; 03800942
	lsl r1,r2,#0x5	; 03800944
	orr r0,r1	; 03800946
	strb r0,[r4,#0x0]	; 03800948
	add r0,r4,#0x0	; 0380094A
	ldr r1,[sp,#0x4]	; 0380094C
	ldr r2,[sp,#0x18]	; 0380094E
	bl loc_03800F4C	; 03800950
	b P2_Entry_03800BDC	; 03800954
P2_Case_03800956:
	mov r0,#0x0	; 03800956
	ldrsb r0,[r1,r0]	; 03800958
	strb r0,[r4,#0x13]	; 0380095A
	b P2_Entry_03800BDC	; 0380095C
P2_Case_0380095E:
	mov r0,#0x0	; 0380095E
	ldrsb r0,[r1,r0]	; 03800960
	strb r0,[r4,#0x6]	; 03800962
	b P2_Entry_03800BDC	; 03800964
P2_Case_03800966:
	lsl r0,r1,#0	; 03800966
	ldrb r0,[r0,#0x0]	; 03800968
	sub r0,#0x40	; 0380096A
	strb r0,[r4,#0x8]	; 0380096C
	b P2_Entry_03800BDC	; 0380096E
P2_Entry_03800970:
	cmp r5,#0x0	; 03800970
	beq P2_Entry_03800978	; 03800972
	ldr r2,[sp,#0x8]	; 03800974
	b P2_Entry_0380097A	; 03800976
P2_Entry_03800978:
	mov r2,#0x1	; 03800978
P2_Entry_0380097A:
	add r0,r4,#0x0	; 0380097A
	ldr r1,[sp,#0x4]	; 0380097C
	bl P2_Entry_038010A0	; 0380097E
	lsl r0,r0,#0x10	; 03800982
	asr r1,r0,#0x10	; 03800984
	ldr r0,[sp,#0xc]	; 03800986
	cmp r0,#0x0	; 03800988
	bne P2_Entry_0380098E	; 0380098A
	b P2_Entry_03800BDC	; 0380098C
P2_Entry_0380098E:
	cmp r6,#0xe0	; 0380098E
	beq P2_Entry_038009A2	; 03800990
	cmp r6,#0xe1	; 03800992
	beq P2_Entry_0380099C	; 03800994
	cmp r6,#0xe3	; 03800996
	beq P2_Entry_038009A6	; 03800998
	b P2_Entry_03800BDC	; 0380099A
P2_Entry_0380099C:
	ldr r0,[sp,#0x4]	; 0380099C
	strh r1,[r0,#0x18]	; 0380099E
	b P2_Entry_03800BDC	; 038009A0
P2_Entry_038009A2:
	strh r1,[r4,#0x1c]	; 038009A2
	b P2_Entry_03800BDC	; 038009A4
P2_Entry_038009A6:
	strh r1,[r4,#0x16]	; 038009A6
	b P2_Entry_03800BDC	; 038009A8
P2_Entry_038009AA:
	add r0,r4,#0x0	; 038009AA
	bl loc_038011CC	; 038009AC
	str r0,[sp,#0x14]	; 038009B0
	cmp r5,#0x0	; 038009B2
	beq P2_Entry_038009BA	; 038009B4
	ldr r2,[sp,#0x8]	; 038009B6
	b P2_Entry_038009BC	; 038009B8
P2_Entry_038009BA:
	mov r2,#0x1	; 038009BA
P2_Entry_038009BC:
	add r0,r4,#0x0	; 038009BC
	ldr r1,[sp,#0x4]	; 038009BE
	bl P2_Entry_038010A0	; 038009C0
	lsl r0,r0,#0x10	; 038009C4
	asr r7,r0,#0x10	; 038009C6
	ldr r0,[sp,#0x4]	; 038009C8
	ldr r1,[sp,#0x14]	; 038009CA
	bl loc_0380054C	; 038009CC
	add r5,r0,#0x0	; 038009D0
	ldr r0,[sp,#0xc]	; 038009D2
	cmp r0,#0x0	; 038009D4
	bne P2_Entry_038009DA	; 038009D6
	b P2_Entry_03800BDC	; 038009D8
P2_Entry_038009DA:
	cmp r5,#0x0	; 038009DA
	bne P2_Entry_038009E0	; 038009DC
	b P2_Entry_03800BDC	; 038009DE
P2_Entry_038009E0:
	sub r6,#0xb0	; 038009E0
	cmp r6,#0xd	; 038009E2
	bls P2_Entry_038009E8	; 038009E4
	b P2_Entry_03800BDC	; 038009E6
P2_Entry_038009E8:
	add r0,r6,r6	; 038009E8
P2_SwitchIndexPC_038009E8:
	add r0,pc	; 038009EA
	ldrh r0,[r0,#(P2_SwitchTable_038009E8 - (P2_SwitchIndexPC_038009E8 + 4))]	; 038009EC
	lsl r0,r0,#0x10	; 038009EE
	asr r0,r0,#0x10	; 038009F0
P2_SwitchTargetPC_038009E8:
	add r0,pc	; 038009F2
	bx r0	; 038009F4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038009E8:
	.halfword (P2_Case_03800A12 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A16 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A20 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A2A + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A34 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A48 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A62 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Entry_03800BDC + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A70 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800A98 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800ABC + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800AE0 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800B04 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
	.halfword (P2_Case_03800B28 + 1) - (P2_SwitchTargetPC_038009E8 + 4)
P2_SwitchTable_038009E8End:
P2_Case_03800A12:
	strh r7,[r5,#0x0]	; 03800A12
	b P2_Entry_03800BDC	; 03800A14
P2_Case_03800A16:
	mov r0,#0x0	; 03800A16
	ldrsh r0,[r5,r0]	; 03800A18
	add r0,r0,r7	; 03800A1A
	strh r0,[r5,#0x0]	; 03800A1C
	b P2_Entry_03800BDC	; 03800A1E
P2_Case_03800A20:
	mov r0,#0x0	; 03800A20
	ldrsh r0,[r5,r0]	; 03800A22
	sub r0,r0,r7	; 03800A24
	strh r0,[r5,#0x0]	; 03800A26
	b P2_Entry_03800BDC	; 03800A28
P2_Case_03800A2A:
	mov r0,#0x0	; 03800A2A
	ldrsh r0,[r5,r0]	; 03800A2C
	mul r0,r7	; 03800A2E
	strh r0,[r5,#0x0]	; 03800A30
	b P2_Entry_03800BDC	; 03800A32
P2_Case_03800A34:
	cmp r7,#0x0	; 03800A34
	bne P2_Entry_03800A3A	; 03800A36
	b P2_Entry_03800BDC	; 03800A38
P2_Entry_03800A3A:
	mov r0,#0x0	; 03800A3A
	ldrsh r0,[r5,r0]	; 03800A3C
	add r1,r7,#0x0	; 03800A3E
	bl loc_037FE348	; 03800A40
	strh r0,[r5,#0x0]	; 03800A44
	b P2_Entry_03800BDC	; 03800A46
P2_Case_03800A48:
	cmp r7,#0x0	; 03800A48
	blt P2_Entry_03800A56	; 03800A4A
	mov r0,#0x0	; 03800A4C
	ldrsh r0,[r5,r0]	; 03800A4E
	lsl r0,r7	; 03800A50
	strh r0,[r5,#0x0]	; 03800A52
	b P2_Entry_03800BDC	; 03800A54
P2_Entry_03800A56:
	mov r0,#0x0	; 03800A56
	ldrsh r1,[r5,r0]	; 03800A58
	neg r0,r7	; 03800A5A
	asr r1,r0	; 03800A5C
	strh r1,[r5,#0x0]	; 03800A5E
	b P2_Entry_03800BDC	; 03800A60
P2_Case_03800A62:
	bl loc_037FF808	; 03800A62
	add r1,r7,#0x1	; 03800A66
	mul r0,r1	; 03800A68
	asr r0,r0,#0x10	; 03800A6A
	strh r0,[r5,#0x0]	; 03800A6C
	b P2_Entry_03800BDC	; 03800A6E
P2_Case_03800A70:
	mov r0,#0x0	; 03800A70
	ldrsh r0,[r5,r0]	; 03800A72
	cmp r0,r7	; 03800A74
	bne P2_Entry_03800A80	; 03800A76
	mov r2,#0x1	; 03800A78
	b P2_Entry_03800A82	; 03800A7A
pool_03800A7C:
	.word 0x00010000	; 03800A7C
P2_Entry_03800A80:
	mov r2,#0x0	; 03800A80
P2_Entry_03800A82:
	ldrb r0,[r4,#0x0]	; 03800A82
	mov r1,#0x40	; 03800A84
	bic r0,r1	; 03800A86
	lsl r1,r2,#0x18	; 03800A88
	lsr r2,r1,#0x18	; 03800A8A
	mov r1,#0x1	; 03800A8C
	and r2,r1	; 03800A8E
	lsl r1,r2,#0x6	; 03800A90
	orr r0,r1	; 03800A92
	strb r0,[r4,#0x0]	; 03800A94
	b P2_Entry_03800BDC	; 03800A96
P2_Case_03800A98:
	mov r0,#0x0	; 03800A98
	ldrsh r0,[r5,r0]	; 03800A9A
	cmp r0,r7	; 03800A9C
	blt P2_Entry_03800AA4	; 03800A9E
	mov r2,#0x1	; 03800AA0
	b P2_Entry_03800AA6	; 03800AA2
P2_Entry_03800AA4:
	mov r2,#0x0	; 03800AA4
P2_Entry_03800AA6:
	ldrb r0,[r4,#0x0]	; 03800AA6
	mov r1,#0x40	; 03800AA8
	bic r0,r1	; 03800AAA
	lsl r1,r2,#0x18	; 03800AAC
	lsr r2,r1,#0x18	; 03800AAE
	mov r1,#0x1	; 03800AB0
	and r2,r1	; 03800AB2
	lsl r1,r2,#0x6	; 03800AB4
	orr r0,r1	; 03800AB6
	strb r0,[r4,#0x0]	; 03800AB8
	b P2_Entry_03800BDC	; 03800ABA
P2_Case_03800ABC:
	mov r0,#0x0	; 03800ABC
	ldrsh r0,[r5,r0]	; 03800ABE
	cmp r0,r7	; 03800AC0
	ble P2_Entry_03800AC8	; 03800AC2
	mov r2,#0x1	; 03800AC4
	b P2_Entry_03800ACA	; 03800AC6
P2_Entry_03800AC8:
	mov r2,#0x0	; 03800AC8
P2_Entry_03800ACA:
	ldrb r0,[r4,#0x0]	; 03800ACA
	mov r1,#0x40	; 03800ACC
	bic r0,r1	; 03800ACE
	lsl r1,r2,#0x18	; 03800AD0
	lsr r2,r1,#0x18	; 03800AD2
	mov r1,#0x1	; 03800AD4
	and r2,r1	; 03800AD6
	lsl r1,r2,#0x6	; 03800AD8
	orr r0,r1	; 03800ADA
	strb r0,[r4,#0x0]	; 03800ADC
	b P2_Entry_03800BDC	; 03800ADE
P2_Case_03800AE0:
	mov r0,#0x0	; 03800AE0
	ldrsh r0,[r5,r0]	; 03800AE2
	cmp r0,r7	; 03800AE4
	bgt P2_Entry_03800AEC	; 03800AE6
	mov r2,#0x1	; 03800AE8
	b P2_Entry_03800AEE	; 03800AEA
P2_Entry_03800AEC:
	mov r2,#0x0	; 03800AEC
P2_Entry_03800AEE:
	ldrb r0,[r4,#0x0]	; 03800AEE
	mov r1,#0x40	; 03800AF0
	bic r0,r1	; 03800AF2
	lsl r1,r2,#0x18	; 03800AF4
	lsr r2,r1,#0x18	; 03800AF6
	mov r1,#0x1	; 03800AF8
	and r2,r1	; 03800AFA
	lsl r1,r2,#0x6	; 03800AFC
	orr r0,r1	; 03800AFE
	strb r0,[r4,#0x0]	; 03800B00
	b P2_Entry_03800BDC	; 03800B02
P2_Case_03800B04:
	mov r0,#0x0	; 03800B04
	ldrsh r0,[r5,r0]	; 03800B06
	cmp r0,r7	; 03800B08
	bge P2_Entry_03800B10	; 03800B0A
	mov r2,#0x1	; 03800B0C
	b P2_Entry_03800B12	; 03800B0E
P2_Entry_03800B10:
	mov r2,#0x0	; 03800B10
P2_Entry_03800B12:
	ldrb r0,[r4,#0x0]	; 03800B12
	mov r1,#0x40	; 03800B14
	bic r0,r1	; 03800B16
	lsl r1,r2,#0x18	; 03800B18
	lsr r2,r1,#0x18	; 03800B1A
	mov r1,#0x1	; 03800B1C
	and r2,r1	; 03800B1E
	lsl r1,r2,#0x6	; 03800B20
	orr r0,r1	; 03800B22
	strb r0,[r4,#0x0]	; 03800B24
	b P2_Entry_03800BDC	; 03800B26
P2_Case_03800B28:
	mov r0,#0x0	; 03800B28
	ldrsh r0,[r5,r0]	; 03800B2A
	cmp r0,r7	; 03800B2C
	beq P2_Entry_03800B34	; 03800B2E
	mov r2,#0x1	; 03800B30
	b P2_Entry_03800B36	; 03800B32
P2_Entry_03800B34:
	mov r2,#0x0	; 03800B34
P2_Entry_03800B36:
	ldrb r0,[r4,#0x0]	; 03800B36
	mov r1,#0x40	; 03800B38
	bic r0,r1	; 03800B3A
	lsl r1,r2,#0x18	; 03800B3C
	lsr r2,r1,#0x18	; 03800B3E
	mov r1,#0x1	; 03800B40
	and r2,r1	; 03800B42
	lsl r1,r2,#0x6	; 03800B44
	orr r0,r1	; 03800B46
	strb r0,[r4,#0x0]	; 03800B48
	b P2_Entry_03800BDC	; 03800B4A
P2_Entry_03800B4C:
	ldr r0,[sp,#0xc]	; 03800B4C
	cmp r0,#0x0	; 03800B4E
	beq P2_Entry_03800BDC	; 03800B50
	sub r6,#0xfc	; 03800B52
	cmp r6,#0x3	; 03800B54
	bhi P2_Entry_03800BDC	; 03800B56
	add r0,r6,r6	; 03800B58
P2_SwitchIndexPC_03800B58:
	add r0,pc	; 03800B5A
	ldrh r0,[r0,#(P2_SwitchTable_03800B58 - (P2_SwitchIndexPC_03800B58 + 4))]	; 03800B5C
	lsl r0,r0,#0x10	; 03800B5E
	asr r0,r0,#0x10	; 03800B60
P2_SwitchTargetPC_03800B58:
	add r0,pc	; 03800B62
	bx r0	; 03800B64
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800B58:
	.halfword (P2_Case_03800B92 + 1) - (P2_SwitchTargetPC_03800B58 + 4)
	.halfword (P2_Case_03800B6E + 1) - (P2_SwitchTargetPC_03800B58 + 4)
	.halfword (P2_Entry_03800BDC + 1) - (P2_SwitchTargetPC_03800B58 + 4)
	.halfword (P2_Case_03800BD6 + 1) - (P2_SwitchTargetPC_03800B58 + 4)
P2_SwitchTable_03800B58End:
P2_Case_03800B6E:
	add r0,r4,#0x0	; 03800B6E
	add r0,#0x3b	; 03800B70
	ldrb r0,[r0,#0x0]	; 03800B72
	cmp r0,#0x0	; 03800B74
	beq P2_Entry_03800BDC	; 03800B76
	add r1,r4,#0x0	; 03800B78
	add r1,#0x3b	; 03800B7A
	ldrb r0,[r1,#0x0]	; 03800B7C
	sub r0,r0,#0x1	; 03800B7E
	strb r0,[r1,#0x0]	; 03800B80
	add r0,r4,#0x0	; 03800B82
	add r0,#0x3b	; 03800B84
	ldrb r0,[r0,#0x0]	; 03800B86
	lsl r0,r0,#0x2	; 03800B88
	add r0,r4,r0	; 03800B8A
	ldr r0,[r0,#0x2c]	; 03800B8C
	str r0,[r4,#0x28]	; 03800B8E
	b P2_Entry_03800BDC	; 03800B90
P2_Case_03800B92:
	add r0,r4,#0x0	; 03800B92
	add r0,#0x3b	; 03800B94
	ldrb r0,[r0,#0x0]	; 03800B96
	cmp r0,#0x0	; 03800B98
	beq P2_Entry_03800BDC	; 03800B9A
	sub r0,r0,#0x1	; 03800B9C
	add r1,r4,r0	; 03800B9E
	add r0,r1,#0x0	; 03800BA0
	add r0,#0x38	; 03800BA2
	ldrb r0,[r0,#0x0]	; 03800BA4
	cmp r0,#0x0	; 03800BA6
	beq P2_Entry_03800BC0	; 03800BA8
	sub r0,r0,#0x1	; 03800BAA
	lsl r0,r0,#0x18	; 03800BAC
	lsr r0,r0,#0x18	; 03800BAE
	cmp r0,#0x0	; 03800BB0
	bne P2_Entry_03800BC0	; 03800BB2
	add r1,r4,#0x0	; 03800BB4
	add r1,#0x3b	; 03800BB6
	ldrb r0,[r1,#0x0]	; 03800BB8
	sub r0,r0,#0x1	; 03800BBA
	strb r0,[r1,#0x0]	; 03800BBC
	b P2_Entry_03800BDC	; 03800BBE
P2_Entry_03800BC0:
	add r1,#0x38	; 03800BC0
	strb r0,[r1,#0x0]	; 03800BC2
	add r0,r4,#0x0	; 03800BC4
	add r0,#0x3b	; 03800BC6
	ldrb r0,[r0,#0x0]	; 03800BC8
	sub r0,r0,#0x1	; 03800BCA
	lsl r0,r0,#0x2	; 03800BCC
	add r0,r4,r0	; 03800BCE
	ldr r0,[r0,#0x2c]	; 03800BD0
	str r0,[r4,#0x28]	; 03800BD2
	b P2_Entry_03800BDC	; 03800BD4
P2_Case_03800BD6:
	mov r0,#0x0	; 03800BD6
	mvn r0,r0	; 03800BD8
	b P2_Entry_03800BF0	; 03800BDA
P2_Entry_03800BDC:
	ldr r0,[r4,#0x20]	; 03800BDC
	cmp r0,#0x0	; 03800BDE
	bne P2_Entry_03800BEE	; 03800BE0
	ldrb r0,[r4,#0x0]	; 03800BE2
	lsl r0,r0,#0x1b	; 03800BE4
	lsr r0,r0,#0x1f	; 03800BE6
	cmp r0,#0x0	; 03800BE8
	bne P2_Entry_03800BEE	; 03800BEA
	b P2_Entry_03800616	; 03800BEC
P2_Entry_03800BEE:
	mov r0,#0x0	; 03800BEE
P2_Entry_03800BF0:
	add sp,#0x24	; 03800BF0
	pop {r4,r5,r6,r7}	; 03800BF2
	pop {r3}	; 03800BF4
	bx r3	; 03800BF6
P2_Entry_03800BF8:
	push {r4,r5,r6,r7,lr}	; 03800BF8
	sub sp,#0x1c	; 03800BFA
	add r4,r0,#0x0	; 03800BFC
	add r6,r1,#0x0	; 03800BFE
	add r7,r2,#0x0	; 03800C00
	str r3,[sp,#0x8]	; 03800C02
	mov r5,#0x0	; 03800C04
	ldr r1,[sp,#0x30]	; 03800C06
	ldrh r0,[r6,#0x18]	; 03800C08
	ldrh r2,[r6,#0x1a]	; 03800C0A
	mul r0,r2	; 03800C0C
	mov r2,#0xf0	; 03800C0E
	mul r1,r2	; 03800C10
	asr r2,r0,#0x8	; 03800C12
	sub r0,r2,#0x1	; 03800C14
	add r0,r1,r0	; 03800C16
	add r1,r2,#0x0	; 03800C18
	bl loc_037FE348	; 03800C1A
	str r0,[sp,#0xc]	; 03800C1E
	ldrb r0,[r4,#0x0]	; 03800C20
	lsl r0,r0,#0x1c	; 03800C22
	lsr r0,r0,#0x1f	; 03800C24
	cmp r0,#0x0	; 03800C26
	beq P2_Entry_03800C36	; 03800C28
	ldr r5,[r4,#0x3c]	; 03800C2A
	cmp r5,#0x0	; 03800C2C
	beq P2_Entry_03800C36	; 03800C2E
	strb r7,[r5,#0x8]	; 03800C30
	ldr r0,[sp,#0x8]	; 03800C32
	strb r0,[r5,#0x9]	; 03800C34
P2_Entry_03800C36:
	cmp r5,#0x0	; 03800C36
	bne P2_Entry_03800CD2	; 03800C38
	ldr r0,[r6,#0x20]	; 03800C3A
	ldrh r1,[r4,#0x2]	; 03800C3C
	add r2,r7,#0x0	; 03800C3E
	add r3,sp,#0x10	; 03800C40
	bl P2_Entry_038016C8	; 03800C42
	cmp r0,#0x0	; 03800C46
	beq P2_Entry_03800D4A	; 03800C48
	add r0,sp,#0x10	; 03800C4A
	ldrb r0,[r0,#0x0]	; 03800C4C
	cmp r0,#0x4	; 03800C4E
	bhi P2_Entry_03800D4A	; 03800C50
	add r0,r0,r0	; 03800C52
P2_SwitchIndexPC_03800C52:
	add r0,pc	; 03800C54
	ldrh r0,[r0,#(P2_SwitchTable_03800C52 - (P2_SwitchIndexPC_03800C52 + 4))]	; 03800C56
	lsl r0,r0,#0x10	; 03800C58
	asr r0,r0,#0x10	; 03800C5A
P2_SwitchTargetPC_03800C52:
	add r0,pc	; 03800C5C
	bx r0	; 03800C5E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800C52:
	.halfword (P2_Case_03800C76 + 1) - (P2_SwitchTargetPC_03800C52 + 4)
	.halfword (P2_Case_03800C6A + 1) - (P2_SwitchTargetPC_03800C52 + 4)
	.halfword (P2_Case_03800C6E + 1) - (P2_SwitchTargetPC_03800C52 + 4)
	.halfword (P2_Case_03800C72 + 1) - (P2_SwitchTargetPC_03800C52 + 4)
	.halfword (P2_Case_03800C6A + 1) - (P2_SwitchTargetPC_03800C52 + 4)
P2_SwitchTable_03800C52End:
P2_Case_03800C6A:
	ldr r0,[pool_03800D54]	; 03800C6A
	b P2_Entry_03800C78	; 03800C6C
P2_Case_03800C6E:
	ldr r0,[pool_03800D58]	; 03800C6E
	b P2_Entry_03800C78	; 03800C70
P2_Case_03800C72:
	ldr r0,[pool_03800D5C]	; 03800C72
	b P2_Entry_03800C78	; 03800C74
P2_Case_03800C76:
	b P2_Entry_03800D4A	; 03800C76
P2_Entry_03800C78:
	ldrh r1,[r4,#0x1e]	; 03800C78
	and r0,r1	; 03800C7A
	str r4,[sp,#0x0]	; 03800C7C
	ldrb r2,[r6,#0x4]	; 03800C7E
	ldrb r1,[r4,#0x12]	; 03800C80
	add r1,r2,r1	; 03800C82
	ldrb r2,[r4,#0x0]	; 03800C84
	lsl r2,r2,#0x18	; 03800C86
	lsr r2,r2,#0x1f	; 03800C88
	ldr r3,[pool_03800D60]	; 03800C8A
	bl P2_Entry_03800000	; 03800C8C
	add r5,r0,#0x0	; 03800C90
	cmp r5,#0x0	; 03800C92
	beq P2_Entry_03800D4A	; 03800C94
	ldrb r0,[r4,#0x0]	; 03800C96
	lsl r0,r0,#0x1c	; 03800C98
	lsr r0,r0,#0x1f	; 03800C9A
	cmp r0,#0x0	; 03800C9C
	beq P2_Entry_03800CA4	; 03800C9E
	mov r3,#0x0	; 03800CA0
	b P2_Entry_03800CA6	; 03800CA2
P2_Entry_03800CA4:
	ldr r3,[sp,#0xc]	; 03800CA4
P2_Entry_03800CA6:
	ldr r0,[r6,#0x20]	; 03800CA6
	str r0,[sp,#0x0]	; 03800CA8
	add r0,sp,#0x10	; 03800CAA
	str r0,[sp,#0x4]	; 03800CAC
	add r0,r5,#0x0	; 03800CAE
	add r1,r7,#0x0	; 03800CB0
	ldr r2,[sp,#0x8]	; 03800CB2
	bl P2_Entry_03801614	; 03800CB4
	cmp r0,#0x0	; 03800CB8
	bne P2_Entry_03800CCC	; 03800CBA
	mov r1,#0x0	; 03800CBC
	add r0,r5,#0x0	; 03800CBE
	add r0,#0x22	; 03800CC0
	strb r1,[r0,#0x0]	; 03800CC2
	add r0,r5,#0x0	; 03800CC4
	bl loc_037FFFF4	; 03800CC6
	b P2_Entry_03800D4A	; 03800CCA
P2_Entry_03800CCC:
	ldr r0,[r4,#0x3c]	; 03800CCC
	str r0,[r5,#0x50]	; 03800CCE
	str r5,[r4,#0x3c]	; 03800CD0
P2_Entry_03800CD2:
	ldrb r1,[r4,#0xe]	; 03800CD2
	cmp r1,#0xff	; 03800CD4
	beq P2_Entry_03800CDE	; 03800CD6
	add r0,r5,#0x0	; 03800CD8
	bl loc_03800100	; 03800CDA
P2_Entry_03800CDE:
	ldrb r1,[r4,#0xf]	; 03800CDE
	cmp r1,#0xff	; 03800CE0
	beq P2_Entry_03800CEA	; 03800CE2
	add r0,r5,#0x0	; 03800CE4
	bl loc_038000EC	; 03800CE6
P2_Entry_03800CEA:
	ldrb r1,[r4,#0x10]	; 03800CEA
	cmp r1,#0xff	; 03800CEC
	beq P2_Entry_03800CF6	; 03800CEE
	add r0,r5,#0x0	; 03800CF0
	bl loc_038000E8	; 03800CF2
P2_Entry_03800CF6:
	ldrb r1,[r4,#0x11]	; 03800CF6
	cmp r1,#0xff	; 03800CF8
	beq P2_Entry_03800D02	; 03800CFA
	add r0,r5,#0x0	; 03800CFC
	bl loc_038000D4	; 03800CFE
P2_Entry_03800D02:
	mov r0,#0x16	; 03800D02
	ldrsh r0,[r4,r0]	; 03800D04
	strh r0,[r5,#0x32]	; 03800D06
	ldrb r0,[r4,#0x0]	; 03800D08
	lsl r0,r0,#0x1a	; 03800D0A
	lsr r0,r0,#0x1f	; 03800D0C
	cmp r0,#0x0	; 03800D0E
	beq P2_Entry_03800D26	; 03800D10
	add r1,r5,#0x0	; 03800D12
	add r1,#0x32	; 03800D14
	mov r0,#0x0	; 03800D16
	ldrsh r0,[r1,r0]	; 03800D18
	ldrb r2,[r4,#0x14]	; 03800D1A
	sub r2,r2,r7	; 03800D1C
	lsl r2,r2,#0x16	; 03800D1E
	asr r2,r2,#0x10	; 03800D20
	add r0,r0,r2	; 03800D22
	strh r0,[r1,#0x0]	; 03800D24
P2_Entry_03800D26:
	ldrb r0,[r4,#0x15]	; 03800D26
	cmp r0,#0x0	; 03800D28
	bne P2_Entry_03800D32	; 03800D2A
	ldr r0,[sp,#0xc]	; 03800D2C
	str r0,[r5,#0x18]	; 03800D2E
	b P2_Entry_03800D46	; 03800D30
P2_Entry_03800D32:
	add r1,r0,#0x0	; 03800D32
	mul r1,r0	; 03800D34
	mov r0,#0x32	; 03800D36
	ldrsh r0,[r5,r0]	; 03800D38
	cmp r0,#0x0	; 03800D3A
	bge P2_Entry_03800D40	; 03800D3C
	neg r0,r0	; 03800D3E
P2_Entry_03800D40:
	mul r1,r0	; 03800D40
	asr r0,r1,#0xb	; 03800D42
	str r0,[r5,#0x18]	; 03800D44
P2_Entry_03800D46:
	mov r0,#0x0	; 03800D46
	str r0,[r5,#0x14]	; 03800D48
P2_Entry_03800D4A:
	add sp,#0x1c	; 03800D4A
	pop {r4,r5,r6,r7}	; 03800D4C
	pop {r3}	; 03800D4E
	bx r3	; 03800D50
	.byte 0xC0, 0x46	; 03800D52
pool_03800D54:
	.word 0x0000FFFF	; 03800D54
pool_03800D58:
	.word 0x00003F00	; 03800D58
pool_03800D5C:
	.word 0x0000C000	; 03800D5C
pool_03800D60:
	.word 0x03800E0D	; 03800D60
P2_Entry_03800D64:
	push {r4,r5,lr}	; 03800D64
	sub sp,#0x4	; 03800D66
	add r5,r0,#0x0	; 03800D68
	mov r4,#0x0	; 03800D6A
P2_Entry_03800D6C:
	add r0,r5,#0x0	; 03800D6C
	add r1,r4,#0x0	; 03800D6E
	bl loc_03800EC4	; 03800D70
	cmp r0,#0x0	; 03800D74
	beq P2_Entry_03800D7E	; 03800D76
	add r1,r5,#0x0	; 03800D78
	bl loc_03800D8C	; 03800D7A
P2_Entry_03800D7E:
	add r4,r4,#0x1	; 03800D7E
	cmp r4,#0x10	; 03800D80
	blt P2_Entry_03800D6C	; 03800D82
	add sp,#0x4	; 03800D84
	pop {r4,r5}	; 03800D86
	pop {r3}	; 03800D88
	bx r3	; 03800D8A

; ===== function loc_03800D8C =====
loc_03800D8C:
	push {r4,r5,r6,r7,lr}	; 03800D8C
	sub sp,#0x4	; 03800D8E
	add r2,r0,#0x0	; 03800D90
	ldr r0,[r2,#0x3c]	; 03800D92
	mov r3,#0x6	; 03800D94
	ldrsh r6,[r1,r3]	; 03800D96
	mov r3,#0xa	; 03800D98
	ldrsh r5,[r2,r3]	; 03800D9A
	ldrb r1,[r1,#0x5]	; 03800D9C
	lsl r1,r1,#0x1	; 03800D9E
	ldr r4,[pool_03800E08]	; 03800DA0
	ldrsh r3,[r4,r1]	; 03800DA2
	ldrb r1,[r2,#0x4]	; 03800DA4
	lsl r1,r1,#0x1	; 03800DA6
	ldrsh r1,[r4,r1]	; 03800DA8
	ldrb r7,[r2,#0x5]	; 03800DAA
	lsl r7,r7,#0x1	; 03800DAC
	ldrsh r4,[r4,r7]	; 03800DAE
	add r1,r1,r4	; 03800DB0
	add r1,r3,r1	; 03800DB2
	add r1,r5,r1	; 03800DB4
	add r4,r6,r1	; 03800DB6
	mov r1,#0x8	; 03800DB8
	ldrsb r3,[r2,r1]	; 03800DBA
	mov r1,#0x9	; 03800DBC
	ldrsb r1,[r2,r1]	; 03800DBE
	add r3,r3,r1	; 03800DC0
	mov r1,#0x6	; 03800DC2
	ldrsb r5,[r2,r1]	; 03800DC4
	ldrb r1,[r2,#0x7]	; 03800DC6
	lsl r1,r1,#0x6	; 03800DC8
	mul r5,r1	; 03800DCA
	asr r5,r5,#0x7	; 03800DCC
	mov r1,#0xc	; 03800DCE
	ldrsh r1,[r2,r1]	; 03800DD0
	add r1,r5,r1	; 03800DD2
	mov r5,#0x7f	; 03800DD4
	mvn r6,r5	; 03800DD6
	cmp r3,r6	; 03800DD8
	bge loc_03800DE0	; 03800DDA
	add r3,r6,#0x0	; 03800DDC
	b loc_03800DFC	; 03800DDE
loc_03800DE0:
	cmp r3,#0x7f	; 03800DE0
	ble loc_03800DFC	; 03800DE2
	add r3,r5,#0x0	; 03800DE4
	b loc_03800DFC	; 03800DE6
loc_03800DE8:
	strh r4,[r0,#0xc]	; 03800DE8
	strh r1,[r0,#0xe]	; 03800DEA
	strb r3,[r0,#0xb]	; 03800DEC
	ldrh r5,[r2,#0x18]	; 03800DEE
	strh r5,[r0,#0x28]	; 03800DF0
	ldrh r5,[r2,#0x1a]	; 03800DF2
	strh r5,[r0,#0x2a]	; 03800DF4
	ldrh r5,[r2,#0x1c]	; 03800DF6
	strh r5,[r0,#0x2c]	; 03800DF8
	ldr r0,[r0,#0x50]	; 03800DFA
loc_03800DFC:
	cmp r0,#0x0	; 03800DFC
	bne loc_03800DE8	; 03800DFE
	add sp,#0x4	; 03800E00
	pop {r4,r5,r6,r7}	; 03800E02
	pop {r3}	; 03800E04
	bx r3	; 03800E06
pool_03800E08:
loc_03800E08:
	.word P2_Data_03805168	; 03800E08
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x14, 0x1C, 0x01, 0x29, 0x06, 0xD1, 0x01, 0x22, 0x29, 0x1C	; 03800E1C
	.byte 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xE8, 0xF8, 0x07, 0xE0, 0x02, 0x29, 0x05, 0xD1, 0x00, 0x22	; 03800E2C
	.byte 0x29, 0x1C, 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xDF, 0xF8, 0xE1, 0x6B, 0xA9, 0x42, 0x08, 0xD1	; 03800E3C
	.byte 0x28, 0x6D, 0xE0, 0x63, 0x08, 0xE0, 0xA8, 0x42, 0x02, 0xD1, 0x28, 0x6D, 0x08, 0x65, 0x03, 0xE0	; 03800E4C
	.byte 0x01, 0x1C, 0x08, 0x6D, 0x00, 0x28, 0xF6, 0xD1, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03800E5C

; ===== function loc_03800E5C =====
loc_03800E5C:
	push {r4,r5,lr}	; 03800E5C
	sub sp,#0x4	; 03800E5E
	add r4,r0,#0x0	; 03800E60
	mov r5,#0x0	; 03800E62
loc_03800E64:
	add r0,r4,#0x0	; 03800E64
	add r1,r5,#0x0	; 03800E66
	bl loc_03800E80	; 03800E68
	add r5,r5,#0x1	; 03800E6C
	cmp r5,#0x10	; 03800E6E
	blt loc_03800E64	; 03800E70
	mov r0,#0x0	; 03800E72
	strb r0,[r4,#0x0]	; 03800E74
	add sp,#0x4	; 03800E76
	pop {r4,r5}	; 03800E78
	pop {r3}	; 03800E7A
	bx r3	; 03800E7C
	.byte 0x00, 0x00	; 03800E80

; ===== function loc_03800E80 =====
loc_03800E80:
	push {r4,r5,lr}	; 03800E80
	sub sp,#0x4	; 03800E82
	add r5,r0,#0x0	; 03800E84
	add r4,r1,#0x0	; 03800E86
	bl loc_03800EC4	; 03800E88
	cmp r0,#0x0	; 03800E8C
	beq loc_03800EAA	; 03800E8E
	add r1,r5,#0x0	; 03800E90
	bl loc_03800EB8	; 03800E92
	add r5,#0x8	; 03800E96
	ldr r3,[pool_03800EB4]	; 03800E98
	ldrb r0,[r5,r4]	; 03800E9A
	lsl r2,r0,#0x6	; 03800E9C
	ldrb r1,[r3,r2]	; 03800E9E
	mov r0,#0x1	; 03800EA0
	bic r1,r0	; 03800EA2
	strb r1,[r3,r2]	; 03800EA4
	mov r0,#0xff	; 03800EA6
	strb r0,[r5,r4]	; 03800EA8
loc_03800EAA:
	add sp,#0x4	; 03800EAA
	pop {r4,r5}	; 03800EAC
	pop {r3}	; 03800EAE
	bx r3	; 03800EB0
	.byte 0xC0, 0x46	; 03800EB4
pool_03800EB4:
loc_03800EB4:
	.word P2_BssStart + 0x1304	; 03800EB4

; ===== function loc_03800EB8 =====
loc_03800EB8:
	mov r2,#0x0	; 03800EB8
	mvn r2,r2	; 03800EBA
	ldr r3,[pool_03800EC0]	; 03800EBC
	bx r3	; 03800EBE
pool_03800EC0:
loc_03800EC0:
	.word loc_03800F4C + 1	; 03800EC0

; ===== function loc_03800EC4 =====
loc_03800EC4:
	cmp r1,#0xf	; 03800EC4
	ble loc_03800ECC	; 03800EC6
	mov r0,#0x0	; 03800EC8
	bx lr	; 03800ECA
loc_03800ECC:
	add r0,r0,r1	; 03800ECC
	ldrb r0,[r0,#0x8]	; 03800ECE
	cmp r0,#0xff	; 03800ED0
	bne loc_03800ED8	; 03800ED2
	mov r0,#0x0	; 03800ED4
	bx lr	; 03800ED6
loc_03800ED8:
	ldr r1,[pool_03800EE0]	; 03800ED8
	lsl r0,r0,#0x6	; 03800EDA
	add r0,r1,r0	; 03800EDC
	bx lr	; 03800EDE
pool_03800EE0:
loc_03800EE0:
	.word 0x038066E4	; 03800EE0
P2_Entry_03800EE4:
	push {r4,r5,lr}	; 03800EE4
	sub sp,#0x4	; 03800EE6
	add r5,r0,#0x0	; 03800EE8
	mov r4,#0x0	; 03800EEA
	add r1,r5,#0x0	; 03800EEC
	add r1,#0x1c	; 03800EEE
	b P2_Entry_03800EFA	; 03800EF0
P2_Entry_03800EF2:
	ldrh r0,[r1,#0x0]	; 03800EF2
	sub r0,#0xf0	; 03800EF4
	strh r0,[r1,#0x0]	; 03800EF6
	add r4,r4,#0x1	; 03800EF8
P2_Entry_03800EFA:
	ldrh r0,[r5,#0x1c]	; 03800EFA
	cmp r0,#0xf0	; 03800EFC
	bcs P2_Entry_03800EF2	; 03800EFE
	ldr r0,[pool_03800F48]	; 03800F00
	ldr r2,[r0,#0x0]	; 03800F02
	cmp r2,#0x0	; 03800F04
	beq P2_Entry_03800F2C	; 03800F06
	add r2,#0x40	; 03800F08
	ldrb r1,[r5,#0x2]	; 03800F0A
	mov r0,#0x24	; 03800F0C
	mul r1,r0	; 03800F0E
	ldr r0,[r2,r1]	; 03800F10
	add r0,r0,r4	; 03800F12
	str r0,[r2,r1]	; 03800F14
	b P2_Entry_03800F2C	; 03800F16
P2_Entry_03800F18:
	add r0,r5,#0x0	; 03800F18
	bl P2_Entry_03800580	; 03800F1A
	cmp r0,#0x0	; 03800F1E
	beq P2_Entry_03800F2A	; 03800F20
	add r0,r5,#0x0	; 03800F22
	bl loc_03800E5C	; 03800F24
	b P2_Entry_03800F30	; 03800F28
P2_Entry_03800F2A:
	sub r4,r4,#0x1	; 03800F2A
P2_Entry_03800F2C:
	cmp r4,#0x0	; 03800F2C
	bgt P2_Entry_03800F18	; 03800F2E
P2_Entry_03800F30:
	ldrh r2,[r5,#0x18]	; 03800F30
	ldrh r0,[r5,#0x1a]	; 03800F32
	mul r2,r0	; 03800F34
	add r5,#0x1c	; 03800F36
	ldrh r1,[r5,#0x0]	; 03800F38
	asr r0,r2,#0x8	; 03800F3A
	add r0,r1,r0	; 03800F3C
	strh r0,[r5,#0x0]	; 03800F3E
	add sp,#0x4	; 03800F40
	pop {r4,r5}	; 03800F42
	pop {r3}	; 03800F44
	bx r3	; 03800F46
pool_03800F48:
	.word P2_BssStart + 0xB80	; 03800F48

; ===== function loc_03800F4C =====
loc_03800F4C:
	push {r4,r5,r6,r7,lr}	; 03800F4C
	sub sp,#0x4	; 03800F4E
	add r5,r0,#0x0	; 03800F50
	add r6,r2,#0x0	; 03800F52
	ldr r4,[r5,#0x3c]	; 03800F54
	bl loc_03800D8C	; 03800F56
	lsl r0,r6,#0x18	; 03800F5A
	lsr r7,r0,#0x18	; 03800F5C
	b loc_03800F8C	; 03800F5E
loc_03800F60:
	add r0,r4,#0x0	; 03800F60
	bl loc_038000C4	; 03800F62
	cmp r0,#0x0	; 03800F66
	beq loc_03800F84	; 03800F68
	cmp r6,#0x0	; 03800F6A
	blt loc_03800F76	; 03800F6C
	add r0,r4,#0x0	; 03800F6E
	add r1,r7,#0x0	; 03800F70
	bl loc_038000D4	; 03800F72
loc_03800F76:
	add r1,r4,#0x0	; 03800F76
	add r1,#0x22	; 03800F78
	mov r0,#0x1	; 03800F7A
	strb r0,[r1,#0x0]	; 03800F7C
	add r0,r4,#0x0	; 03800F7E
	bl loc_038000CC	; 03800F80
loc_03800F84:
	add r0,r4,#0x0	; 03800F84
	bl loc_037FFFF4	; 03800F86
	ldr r4,[r4,#0x50]	; 03800F8A
loc_03800F8C:
	cmp r4,#0x0	; 03800F8C
	bne loc_03800F60	; 03800F8E
	mov r0,#0x0	; 03800F90
	str r0,[r5,#0x3c]	; 03800F92
	add sp,#0x4	; 03800F94
	pop {r4,r5,r6,r7}	; 03800F96
	pop {r3}	; 03800F98
	bx r3	; 03800F9A

; ===== function loc_03800F9C =====
loc_03800F9C:
	push {r4,r5,r6,r7,lr}	; 03800F9C
	sub sp,#0x4	; 03800F9E
	mov r2,#0x0	; 03800FA0
	strb r2,[r0,#0x1]	; 03800FA2
	str r1,[r0,#0x20]	; 03800FA4
	mov r1,#0x78	; 03800FA6
	strh r1,[r0,#0x18]	; 03800FA8
	ldr r1,[pool_03800FF8]	; 03800FAA
	strh r1,[r0,#0x1a]	; 03800FAC
	strh r2,[r0,#0x1c]	; 03800FAE
	mov r1,#0x7f	; 03800FB0
	strb r1,[r0,#0x5]	; 03800FB2
	strh r2,[r0,#0x6]	; 03800FB4
	mov r1,#0x40	; 03800FB6
	strb r1,[r0,#0x4]	; 03800FB8
	mov r3,#0xff	; 03800FBA
loc_03800FBC:
	add r1,r0,r2	; 03800FBC
	strb r3,[r1,#0x8]	; 03800FBE
	add r2,r2,#0x1	; 03800FC0
	cmp r2,#0x10	; 03800FC2
	blt loc_03800FBC	; 03800FC4
	ldr r4,[pool_03800FFC]	; 03800FC6
	ldr r5,[r4,#0x0]	; 03800FC8
	cmp r5,#0x0	; 03800FCA
	beq loc_03800FF0	; 03800FCC
	mov r2,#0x0	; 03800FCE
	ldrb r1,[r0,#0x2]	; 03800FD0
	mov r3,#0x24	; 03800FD2
	mul r1,r3	; 03800FD4
	add r1,r5,r1	; 03800FD6
	str r2,[r1,#0x40]	; 03800FD8
	mvn r1,r2	; 03800FDA
loc_03800FDC:
	ldr r7,[r4,#0x0]	; 03800FDC
	ldrb r5,[r0,#0x2]	; 03800FDE
	mul r5,r3	; 03800FE0
	lsl r6,r2,#0x1	; 03800FE2
	add r5,r7,r5	; 03800FE4
	add r5,r6,r5	; 03800FE6
	strh r1,[r5,#0x20]	; 03800FE8
	add r2,r2,#0x1	; 03800FEA
	cmp r2,#0x10	; 03800FEC
	blt loc_03800FDC	; 03800FEE
loc_03800FF0:
	add sp,#0x4	; 03800FF0
	pop {r4,r5,r6,r7}	; 03800FF2
	pop {r3}	; 03800FF4
	bx r3	; 03800FF6
pool_03800FF8:
loc_03800FF8:
	.word 0x00000100	; 03800FF8
pool_03800FFC:
loc_03800FFC:
	.word P2_BssStart + 0xB80	; 03800FFC

; ===== function loc_03801000 =====
loc_03801000:
	str r1,[r0,#0x24]	; 03801000
	ldr r1,[r0,#0x24]	; 03801002
	add r1,r1,r2	; 03801004
	str r1,[r0,#0x28]	; 03801006
	bx lr	; 03801008
	.byte 0x00, 0x00	; 0380100C

; ===== function loc_0380100C =====
loc_0380100C:
	push {r4,r5,lr}	; 0380100C
	sub sp,#0x4	; 0380100E
	add r4,r0,#0x0	; 03801010
	mov r1,#0x0	; 03801012
	str r1,[r4,#0x24]	; 03801014
	str r1,[r4,#0x28]	; 03801016
	ldrb r2,[r4,#0x0]	; 03801018
	mov r0,#0x2	; 0380101A
	orr r2,r0	; 0380101C
	strb r2,[r4,#0x0]	; 0380101E
	ldrb r3,[r4,#0x0]	; 03801020
	mov r2,#0x4	; 03801022
	bic r3,r2	; 03801024
	strb r3,[r4,#0x0]	; 03801026
	ldrb r3,[r4,#0x0]	; 03801028
	mov r2,#0x8	; 0380102A
	bic r3,r2	; 0380102C
	strb r3,[r4,#0x0]	; 0380102E
	ldrb r3,[r4,#0x0]	; 03801030
	mov r2,#0x10	; 03801032
	bic r3,r2	; 03801034
	strb r3,[r4,#0x0]	; 03801036
	ldrb r3,[r4,#0x0]	; 03801038
	mov r2,#0x20	; 0380103A
	bic r3,r2	; 0380103C
	strb r3,[r4,#0x0]	; 0380103E
	ldrb r2,[r4,#0x0]	; 03801040
	mov r3,#0x40	; 03801042
	orr r2,r3	; 03801044
	strb r2,[r4,#0x0]	; 03801046
	ldrb r5,[r4,#0x0]	; 03801048
	mov r2,#0x80	; 0380104A
	bic r5,r2	; 0380104C
	strb r5,[r4,#0x0]	; 0380104E
	add r2,r4,#0x0	; 03801050
	add r2,#0x3b	; 03801052
	strb r1,[r2,#0x0]	; 03801054
	strh r1,[r4,#0x2]	; 03801056
	strb r3,[r4,#0x12]	; 03801058
	mov r2,#0x7f	; 0380105A
	strb r2,[r4,#0x4]	; 0380105C
	strb r2,[r4,#0x5]	; 0380105E
	strh r1,[r4,#0xa]	; 03801060
	strb r1,[r4,#0x8]	; 03801062
	strb r1,[r4,#0x9]	; 03801064
	strb r1,[r4,#0x6]	; 03801066
	strh r1,[r4,#0xc]	; 03801068
	mov r2,#0xff	; 0380106A
	strb r2,[r4,#0xe]	; 0380106C
	strb r2,[r4,#0xf]	; 0380106E
	strb r2,[r4,#0x10]	; 03801070
	strb r2,[r4,#0x11]	; 03801072
	strb r0,[r4,#0x7]	; 03801074
	mov r0,#0x3c	; 03801076
	strb r0,[r4,#0x14]	; 03801078
	strb r1,[r4,#0x15]	; 0380107A
	strh r1,[r4,#0x16]	; 0380107C
	strb r1,[r4,#0x13]	; 0380107E
	ldr r0,[pool_0380109C]	; 03801080
	strh r0,[r4,#0x1e]	; 03801082
	add r0,r4,#0x0	; 03801084
	add r0,#0x18	; 03801086
	bl loc_037FFE3C	; 03801088
	mov r0,#0x0	; 0380108C
	str r0,[r4,#0x20]	; 0380108E
	str r0,[r4,#0x3c]	; 03801090
	add sp,#0x4	; 03801092
	pop {r4,r5}	; 03801094
	pop {r3}	; 03801096
	bx r3	; 03801098
	.byte 0xC0, 0x46	; 0380109C
pool_0380109C:
loc_0380109C:
	.word 0x0000FFFF	; 0380109C

; ===== function loc_038010A0 =====
P2_Entry_038010A0:
	push {r4,r5,r6,lr}	; 038010A0
	add r4,r0,#0x0	; 038010A2
	add r6,r1,#0x0	; 038010A4
	cmp r2,#0x4	; 038010A6
	bhi loc_03801110	; 038010A8
	add r1,r2,r2	; 038010AA
P2_SwitchIndexPC_038010AA:
	add r1,pc	; 038010AC
	ldrh r1,[r1,#(P2_SwitchTable_038010AA - (P2_SwitchIndexPC_038010AA + 4))]	; 038010AE
	lsl r1,r1,#0x10	; 038010B0
	asr r1,r1,#0x10	; 038010B2
P2_SwitchTargetPC_038010AA:
	add r1,pc	; 038010B4
	bx r1	; 038010B6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038010AA:
	.halfword (loc_038010C2 + 1) - (P2_SwitchTargetPC_038010AA + 4)
	.halfword (loc_038010CA + 1) - (P2_SwitchTargetPC_038010AA + 4)
	.halfword (loc_038010D2 + 1) - (P2_SwitchTargetPC_038010AA + 4)
	.halfword (loc_038010F0 + 1) - (P2_SwitchTargetPC_038010AA + 4)
	.halfword (loc_038010DA + 1) - (P2_SwitchTargetPC_038010AA + 4)
P2_SwitchTable_038010AAEnd:
loc_038010C2:
	bl loc_038011CC	; 038010C2
	add r5,r0,#0x0	; 038010C6
	b loc_03801110	; 038010C8
loc_038010CA:
	bl loc_03801194	; 038010CA
	add r5,r0,#0x0	; 038010CE
	b loc_03801110	; 038010D0
loc_038010D2:
	bl loc_03801118	; 038010D2
	add r5,r0,#0x0	; 038010D6
	b loc_03801110	; 038010D8
loc_038010DA:
	bl loc_038011CC	; 038010DA
	add r1,r0,#0x0	; 038010DE
	add r0,r6,#0x0	; 038010E0
	bl loc_0380054C	; 038010E2
	cmp r0,#0x0	; 038010E6
	beq loc_03801110	; 038010E8
	mov r1,#0x0	; 038010EA
	ldrsh r5,[r0,r1]	; 038010EC
	b loc_03801110	; 038010EE
loc_038010F0:
	bl loc_03801194	; 038010F0
	lsl r0,r0,#0x10	; 038010F4
	asr r5,r0,#0x10	; 038010F6
	add r0,r4,#0x0	; 038010F8
	bl loc_03801194	; 038010FA
	lsl r0,r0,#0x10	; 038010FE
	asr r4,r0,#0x10	; 03801100
	bl loc_037FF808	; 03801102
	sub r1,r4,r5	; 03801106
	add r1,r1,#0x1	; 03801108
	mul r0,r1	; 0380110A
	asr r0,r0,#0x10	; 0380110C
	add r5,r0,r5	; 0380110E
loc_03801110:
	add r0,r5,#0x0	; 03801110
	pop {r4,r5,r6}	; 03801112
	pop {r3}	; 03801114
	bx r3	; 03801116

; ===== function loc_03801118 =====
loc_03801118:
	push {r4,r5,r6,r7,lr}	; 03801118
	sub sp,#0x4	; 0380111A
	add r6,r0,#0x0	; 0380111C
	mov r5,#0x0	; 0380111E
	add r4,r6,#0x0	; 03801120
	add r4,#0x28	; 03801122
	mov r7,#0x80	; 03801124
loc_03801126:
	ldr r0,[r6,#0x28]	; 03801126
	bl loc_038011E4	; 03801128
	ldr r1,[r4,#0x0]	; 0380112C
	add r1,r1,#0x1	; 0380112E
	str r1,[r4,#0x0]	; 03801130
	lsl r5,r5,#0x7	; 03801132
	add r2,r0,#0x0	; 03801134
	mov r1,#0x7f	; 03801136
	and r2,r1	; 03801138
	orr r5,r2	; 0380113A
	and r0,r7	; 0380113C
	cmp r0,#0x0	; 0380113E
	bne loc_03801126	; 03801140
	add r0,r5,#0x0	; 03801142
	add sp,#0x4	; 03801144
	pop {r4,r5,r6,r7}	; 03801146
	pop {r3}	; 03801148
	bx r3	; 0380114A
P2_Entry_0380114C:
	push {r4,r5,lr}	; 0380114C
	sub sp,#0x4	; 0380114E
	add r5,r0,#0x0	; 03801150
	ldr r0,[r5,#0x28]	; 03801152
	bl loc_038011E4	; 03801154
	add r4,r0,#0x0	; 03801158
	add r1,r5,#0x0	; 0380115A
	add r1,#0x28	; 0380115C
	ldr r0,[r1,#0x0]	; 0380115E
	add r0,r0,#0x1	; 03801160
	str r0,[r1,#0x0]	; 03801162
	ldr r0,[r5,#0x28]	; 03801164
	bl loc_038011E4	; 03801166
	lsl r0,r0,#0x8	; 0380116A
	orr r4,r0	; 0380116C
	add r1,r5,#0x0	; 0380116E
	add r1,#0x28	; 03801170
	ldr r0,[r1,#0x0]	; 03801172
	add r0,r0,#0x1	; 03801174
	str r0,[r1,#0x0]	; 03801176
	ldr r0,[r5,#0x28]	; 03801178
	bl loc_038011E4	; 0380117A
	lsl r0,r0,#0x10	; 0380117E
	orr r4,r0	; 03801180
	add r5,#0x28	; 03801182
	ldr r0,[r5,#0x0]	; 03801184
	add r0,r0,#0x1	; 03801186
	str r0,[r5,#0x0]	; 03801188
	add r0,r4,#0x0	; 0380118A
	add sp,#0x4	; 0380118C
	pop {r4,r5}	; 0380118E
	pop {r3}	; 03801190
	bx r3	; 03801192

; ===== function loc_03801194 =====
loc_03801194:
	push {r4,r5,lr}	; 03801194
	sub sp,#0x4	; 03801196
	add r5,r0,#0x0	; 03801198
	ldr r0,[r5,#0x28]	; 0380119A
	bl loc_038011E4	; 0380119C
	add r4,r0,#0x0	; 038011A0
	add r1,r5,#0x0	; 038011A2
	add r1,#0x28	; 038011A4
	ldr r0,[r1,#0x0]	; 038011A6
	add r0,r0,#0x1	; 038011A8
	str r0,[r1,#0x0]	; 038011AA
	ldr r0,[r5,#0x28]	; 038011AC
	bl loc_038011E4	; 038011AE
	lsl r0,r0,#0x8	; 038011B2
	orr r4,r0	; 038011B4
	lsl r0,r4,#0x10	; 038011B6
	lsr r0,r0,#0x10	; 038011B8
	add r5,#0x28	; 038011BA
	ldr r1,[r5,#0x0]	; 038011BC
	add r1,r1,#0x1	; 038011BE
	str r1,[r5,#0x0]	; 038011C0
	add sp,#0x4	; 038011C2
	pop {r4,r5}	; 038011C4
	pop {r3}	; 038011C6
	bx r3	; 038011C8
	.byte 0x00, 0x00	; 038011CC

; ===== function loc_038011CC =====
loc_038011CC:
	push {r4,lr}	; 038011CC
	add r4,r0,#0x0	; 038011CE
	ldr r0,[r4,#0x28]	; 038011D0
	bl loc_038011E4	; 038011D2
	add r4,#0x28	; 038011D6
	ldr r1,[r4,#0x0]	; 038011D8
	add r1,r1,#0x1	; 038011DA
	str r1,[r4,#0x0]	; 038011DC
	pop {r4}	; 038011DE
	pop {r3}	; 038011E0
	bx r3	; 038011E2

; ===== function loc_038011E4 =====
loc_038011E4:
	push {r4,lr}	; 038011E4
	add r4,r0,#0x0	; 038011E6
	ldr r0,[pool_0380120C]	; 038011E8
	ldr r1,[r0,#0x0]	; 038011EA
	cmp r4,r1	; 038011EC
	bcc loc_038011F6	; 038011EE
	ldr r0,[r0,#0x4]	; 038011F0
	cmp r4,r0	; 038011F2
	bcc loc_038011FC	; 038011F4
loc_038011F6:
	add r0,r4,#0x0	; 038011F6
	bl loc_03801214	; 038011F8
loc_038011FC:
	ldr r0,[pool_0380120C]	; 038011FC
	ldr r0,[r0,#0x0]	; 038011FE
	sub r1,r4,r0	; 03801200
	ldr r0,[pool_03801210]	; 03801202
	ldrb r0,[r0,r1]	; 03801204
	pop {r4}	; 03801206
	pop {r3}	; 03801208
	bx r3	; 0380120A
pool_0380120C:
loc_0380120C:
	.word P2_BssStart + 0xB68	; 0380120C
pool_03801210:
loc_03801210:
	.word P2_BssStart + 0xB70	; 03801210

; ===== function loc_03801214 =====
loc_03801214:
	mov r1,#0x3	; 03801214
	bic r0,r1	; 03801216
	ldr r1,[pool_03801234]	; 03801218
	str r0,[r1,#0x0]	; 0380121A
	add r2,r0,#0x0	; 0380121C
	add r2,#0x10	; 0380121E
	str r2,[r1,#0x4]	; 03801220
	ldr r2,[r0,#0x0]	; 03801222
	str r2,[r1,#0x8]	; 03801224
	ldr r2,[r0,#0x4]	; 03801226
	str r2,[r1,#0xc]	; 03801228
	ldr r2,[r0,#0x8]	; 0380122A
	str r2,[r1,#0x10]	; 0380122C
	ldr r0,[r0,#0xc]	; 0380122E
	str r0,[r1,#0x14]	; 03801230
	bx lr	; 03801232
pool_03801234:
loc_03801234:
	.word P2_BssStart + 0xB68	; 03801234

; ===== function loc_03801238 =====
loc_03801238:
	push {r4,r5,r6,r7,lr}	; 03801238
	sub sp,#0x4	; 0380123A
	add r6,r1,#0x0	; 0380123C
	add r5,r3,#0x0	; 0380123E
	ldr r4,[sp,#0x18]	; 03801240
	ldr r3,[pool_03801290]	; 03801242
	mov r1,#0x24	; 03801244
	mul r0,r1	; 03801246
	add r7,r3,r0	; 03801248
	mov r3,#0x0	; 0380124A
	b loc_03801280	; 0380124C
loc_0380124E:
	add r1,r6,#0x0	; 0380124E
	mov r0,#0x1	; 03801250
	and r1,r0	; 03801252
	cmp r1,#0x0	; 03801254
	beq loc_0380127C	; 03801256
	add r0,r7,#0x0	; 03801258
	add r1,r3,#0x0	; 0380125A
	bl loc_03800EC4	; 0380125C
	cmp r0,#0x0	; 03801260
	beq loc_0380127C	; 03801262
	cmp r4,#0x1	; 03801264
	beq loc_03801272	; 03801266
	cmp r4,#0x2	; 03801268
	beq loc_03801276	; 0380126A
	cmp r4,#0x4	; 0380126C
	beq loc_0380127A	; 0380126E
	b loc_0380127C	; 03801270
loc_03801272:
	strb r5,[r0,r2]	; 03801272
	b loc_0380127C	; 03801274
loc_03801276:
	strh r5,[r0,r2]	; 03801276
	b loc_0380127C	; 03801278
loc_0380127A:
	str r5,[r0,r2]	; 0380127A
loc_0380127C:
	add r3,r3,#0x1	; 0380127C
	lsr r6,r6,#0x1	; 0380127E
loc_03801280:
	cmp r3,#0x10	; 03801280
	bge loc_03801288	; 03801282
	cmp r6,#0x0	; 03801284
	bne loc_0380124E	; 03801286
loc_03801288:
	add sp,#0x4	; 03801288
	pop {r4,r5,r6,r7}	; 0380128A
	pop {r3}	; 0380128C
	bx r3	; 0380128E
pool_03801290:
loc_03801290:
	.word 0x038064A4	; 03801290

; ===== function loc_03801294 =====
loc_03801294:
	push {r4,r5,lr}	; 03801294
	sub sp,#0x4	; 03801296
	ldr r5,[pool_038012C0]	; 03801298
	mov r4,#0x24	; 0380129A
	mul r0,r4	; 0380129C
	add r0,r5,r0	; 0380129E
	cmp r3,#0x1	; 038012A0
	beq loc_038012AE	; 038012A2
	cmp r3,#0x2	; 038012A4
	beq loc_038012B2	; 038012A6
	cmp r3,#0x4	; 038012A8
	beq loc_038012B6	; 038012AA
	b loc_038012B8	; 038012AC
loc_038012AE:
	strb r2,[r0,r1]	; 038012AE
	b loc_038012B8	; 038012B0
loc_038012B2:
	strh r2,[r0,r1]	; 038012B2
	b loc_038012B8	; 038012B4
loc_038012B6:
	str r2,[r0,r1]	; 038012B6
loc_038012B8:
	add sp,#0x4	; 038012B8
	pop {r4,r5}	; 038012BA
	pop {r3}	; 038012BC
	bx r3	; 038012BE
pool_038012C0:
loc_038012C0:
	.word 0x038064A4	; 038012C0

; ===== function loc_038012C4 =====
loc_038012C4:
	push {r4,r5,r6,r7,lr}	; 038012C4
	sub sp,#0x4	; 038012C6
	add r5,r0,#0x0	; 038012C8
	add r6,r1,#0x0	; 038012CA
	mov r4,#0x0	; 038012CC
	ldr r7,[pool_038012FC]	; 038012CE
loc_038012D0:
	add r1,r4,#0x0	; 038012D0
	mov r0,#0x24	; 038012D2
	mul r1,r0	; 038012D4
	add r0,r7,r1	; 038012D6
	ldrb r1,[r7,r1]	; 038012D8
	cmp r1,#0x0	; 038012DA
	beq loc_038012EC	; 038012DC
	ldr r1,[r0,#0x20]	; 038012DE
	cmp r5,r1	; 038012E0
	bhi loc_038012EC	; 038012E2
	cmp r1,r6	; 038012E4
	bhi loc_038012EC	; 038012E6
	bl loc_03800E5C	; 038012E8
loc_038012EC:
	add r4,r4,#0x1	; 038012EC
	cmp r4,#0x10	; 038012EE
	blt loc_038012D0	; 038012F0
	add sp,#0x4	; 038012F2
	pop {r4,r5,r6,r7}	; 038012F4
	pop {r3}	; 038012F6
	bx r3	; 038012F8
	.byte 0xC0, 0x46	; 038012FC
pool_038012FC:
loc_038012FC:
	.word P2_BssStart + 0x10C4	; 038012FC

; ===== function loc_03801300 =====
loc_03801300:
	push {r4,r5,r6,r7,lr}	; 03801300
	sub sp,#0x4	; 03801302
	add r5,r0,#0x0	; 03801304
	add r6,r1,#0x0	; 03801306
	mov r4,#0x0	; 03801308
	add r7,r4,#0x0	; 0380130A
loc_0380130C:
	add r0,r4,#0x0	; 0380130C
	mov r1,#0x24	; 0380130E
	mul r0,r1	; 03801310
	ldr r1,[pool_03801354]	; 03801312
	add r3,r1,r0	; 03801314
	ldrb r0,[r1,r0]	; 03801316
	cmp r0,#0x0	; 03801318
	beq loc_03801344	; 0380131A
	add r2,r7,#0x0	; 0380131C
	b loc_03801340	; 0380131E
loc_03801320:
	add r0,r3,#0x0	; 03801320
	add r1,r2,#0x0	; 03801322
	bl loc_03800EC4	; 03801324
	cmp r0,#0x0	; 03801328
	beq loc_0380133E	; 0380132A
	ldr r0,[r0,#0x28]	; 0380132C
	cmp r5,r0	; 0380132E
	bhi loc_0380133E	; 03801330
	cmp r0,r6	; 03801332
	bhi loc_0380133E	; 03801334
	add r0,r3,#0x0	; 03801336
	bl loc_03800E5C	; 03801338
	b loc_03801344	; 0380133C
loc_0380133E:
	add r2,r2,#0x1	; 0380133E
loc_03801340:
	cmp r2,#0x10	; 03801340
	blt loc_03801320	; 03801342
loc_03801344:
	add r4,r4,#0x1	; 03801344
	cmp r4,#0x10	; 03801346
	blt loc_0380130C	; 03801348
	add sp,#0x4	; 0380134A
	pop {r4,r5,r6,r7}	; 0380134C
	pop {r3}	; 0380134E
	bx r3	; 03801350
	.byte 0xC0, 0x46	; 03801354
pool_03801354:
loc_03801354:
	.word P2_BssStart + 0x10C4	; 03801354

; ===== function loc_03801358 =====
loc_03801358:
	push {r4,r5,r6,r7,lr}	; 03801358
	sub sp,#0x4	; 0380135A
	add r5,r1,#0x0	; 0380135C
	ldr r3,[pool_038013A4]	; 0380135E
	mov r1,#0x24	; 03801360
	mul r0,r1	; 03801362
	add r4,r3,r0	; 03801364
	mov r3,#0x0	; 03801366
	lsl r0,r2,#0x10	; 03801368
	lsr r2,r0,#0x10	; 0380136A
	mov r7,#0x80	; 0380136C
	mov r6,#0x1	; 0380136E
	b loc_03801394	; 03801370
loc_03801372:
	add r0,r5,#0x0	; 03801372
	and r0,r6	; 03801374
	cmp r0,#0x0	; 03801376
	beq loc_03801390	; 03801378
	add r0,r4,#0x0	; 0380137A
	add r1,r3,#0x0	; 0380137C
	bl loc_03800EC4	; 0380137E
	add r1,r0,#0x0	; 03801382
	cmp r1,#0x0	; 03801384
	beq loc_03801390	; 03801386
	strh r2,[r1,#0x1e]	; 03801388
	ldrb r0,[r1,#0x0]	; 0380138A
	orr r0,r7	; 0380138C
	strb r0,[r1,#0x0]	; 0380138E
loc_03801390:
	add r3,r3,#0x1	; 03801390
	lsr r5,r5,#0x1	; 03801392
loc_03801394:
	cmp r3,#0x10	; 03801394
	bge loc_0380139C	; 03801396
	cmp r5,#0x0	; 03801398
	bne loc_03801372	; 0380139A
loc_0380139C:
	add sp,#0x4	; 0380139C
	pop {r4,r5,r6,r7}	; 0380139E
	pop {r3}	; 038013A0
	bx r3	; 038013A2
pool_038013A4:
loc_038013A4:
	.word 0x038064A4	; 038013A4

; ===== function loc_038013A8 =====
loc_038013A8:
	push {r4,r5,r6,r7,lr}	; 038013A8
	sub sp,#0x4	; 038013AA
	add r5,r1,#0x0	; 038013AC
	add r6,r2,#0x0	; 038013AE
	ldr r2,[pool_0380140C]	; 038013B0
	mov r1,#0x24	; 038013B2
	mul r0,r1	; 038013B4
	add r0,r2,r0	; 038013B6
	str r0,[sp,#0x0]	; 038013B8
	mov r4,#0x0	; 038013BA
	b loc_038013FA	; 038013BC
loc_038013BE:
	add r1,r5,#0x0	; 038013BE
	mov r0,#0x1	; 038013C0
	and r1,r0	; 038013C2
	cmp r1,#0x0	; 038013C4
	beq loc_038013F6	; 038013C6
	ldr r0,[sp,#0x0]	; 038013C8
	add r1,r4,#0x0	; 038013CA
	bl loc_03800EC4	; 038013CC
	add r7,r0,#0x0	; 038013D0
	cmp r7,#0x0	; 038013D2
	beq loc_038013F6	; 038013D4
	cmp r6,#0x0	; 038013D6
	beq loc_038013E2	; 038013D8
	ldr r1,[sp,#0x0]	; 038013DA
	mov r2,#0x7f	; 038013DC
	bl loc_03800F4C	; 038013DE
loc_038013E2:
	ldrb r0,[r7,#0x0]	; 038013E2
	mov r1,#0x4	; 038013E4
	bic r0,r1	; 038013E6
	lsl r1,r6,#0x18	; 038013E8
	lsr r2,r1,#0x18	; 038013EA
	mov r1,#0x1	; 038013EC
	and r2,r1	; 038013EE
	lsl r1,r2,#0x2	; 038013F0
	orr r0,r1	; 038013F2
	strb r0,[r7,#0x0]	; 038013F4
loc_038013F6:
	add r4,r4,#0x1	; 038013F6
	lsr r5,r5,#0x1	; 038013F8
loc_038013FA:
	cmp r4,#0x10	; 038013FA
	bge loc_03801402	; 038013FC
	cmp r5,#0x0	; 038013FE
	bne loc_038013BE	; 03801400
loc_03801402:
	add sp,#0x4	; 03801402
	pop {r4,r5,r6,r7}	; 03801404
	pop {r3}	; 03801406
	bx r3	; 03801408
	.byte 0xC0, 0x46	; 0380140C
pool_0380140C:
loc_0380140C:
	.word 0x038064A4	; 0380140C

; ===== function loc_03801410 =====
loc_03801410:
	push {r4,r5,r6,lr}	; 03801410
	ldr r3,[pool_03801444]	; 03801412
	mov r2,#0x24	; 03801414
	mul r0,r2	; 03801416
	add r5,r3,r0	; 03801418
	strb r1,[r5,#0x1]	; 0380141A
	cmp r1,#0x0	; 0380141C
	beq loc_0380143E	; 0380141E
	mov r4,#0x0	; 03801420
	mov r6,#0x7f	; 03801422
loc_03801424:
	add r0,r5,#0x0	; 03801424
	add r1,r4,#0x0	; 03801426
	bl loc_03800EC4	; 03801428
	cmp r0,#0x0	; 0380142C
	beq loc_03801438	; 0380142E
	add r1,r5,#0x0	; 03801430
	add r2,r6,#0x0	; 03801432
	bl loc_03800F4C	; 03801434
loc_03801438:
	add r4,r4,#0x1	; 03801438
	cmp r4,#0x10	; 0380143A
	blt loc_03801424	; 0380143C
loc_0380143E:
	pop {r4,r5,r6}	; 0380143E
	pop {r3}	; 03801440
	bx r3	; 03801442
pool_03801444:
loc_03801444:
	.word 0x038064A4	; 03801444

; ===== function loc_03801448 =====
loc_03801448:
	push {r4,lr}	; 03801448
	add r4,r0,#0x0	; 0380144A
	ldr r2,[pool_0380147C]	; 0380144C
	mov r0,#0x24	; 0380144E
	add r1,r4,#0x0	; 03801450
	mul r1,r0	; 03801452
	add r0,r2,r1	; 03801454
	ldrb r1,[r2,r1]	; 03801456
	cmp r1,#0x0	; 03801458
	beq loc_03801474	; 0380145A
	bl loc_03800E5C	; 0380145C
	ldr r0,[pool_03801480]	; 03801460
	ldr r0,[r0,#0x0]	; 03801462
	cmp r0,#0x0	; 03801464
	beq loc_03801474	; 03801466
	add r2,r0,#0x4	; 03801468
	ldr r1,[r2,#0x0]	; 0380146A
	mov r0,#0x1	; 0380146C
	lsl r0,r4	; 0380146E
	bic r1,r0	; 03801470
	str r1,[r2,#0x0]	; 03801472
loc_03801474:
	pop {r4}	; 03801474
	pop {r3}	; 03801476
	bx r3	; 03801478
	.byte 0xC0, 0x46	; 0380147C
pool_0380147C:
loc_0380147C:
	.word P2_BssStart + 0x10C4	; 0380147C
pool_03801480:
loc_03801480:
	.word P2_BssStart + 0xB80	; 03801480

; ===== function loc_03801484 =====
loc_03801484:
	push {r4,r5,r6,r7,lr}	; 03801484
	sub sp,#0xc	; 03801486
	str r0,[sp,#0x0]	; 03801488
	add r7,r1,#0x0	; 0380148A
	str r2,[sp,#0x4]	; 0380148C
	add r4,r3,#0x0	; 0380148E
	ldr r2,[pool_03801548]	; 03801490
	mov r0,#0x24	; 03801492
	ldr r1,[sp,#0x0]	; 03801494
	mul r1,r0	; 03801496
	add r5,r2,r1	; 03801498
	ldrb r0,[r2,r1]	; 0380149A
	cmp r0,#0x0	; 0380149C
	beq loc_038014A6	; 0380149E
	add r0,r5,#0x0	; 038014A0
	bl loc_03800E5C	; 038014A2
loc_038014A6:
	add r0,r5,#0x0	; 038014A6
	add r1,r4,#0x0	; 038014A8
	bl loc_03800F9C	; 038014AA
	bl loc_03800518	; 038014AE
	add r6,r0,#0x0	; 038014B2
	cmp r6,#0x0	; 038014B4
	blt loc_0380153E	; 038014B6
	ldr r1,[pool_0380154C]	; 038014B8
	lsl r0,r6,#0x6	; 038014BA
	add r4,r1,r0	; 038014BC
	add r0,r4,#0x0	; 038014BE
	bl loc_0380100C	; 038014C0
	add r0,r4,#0x0	; 038014C4
	add r1,r7,#0x0	; 038014C6
	ldr r2,[sp,#0x4]	; 038014C8
	bl loc_03801000	; 038014CA
	strb r6,[r5,#0x8]	; 038014CE
	ldr r0,[r4,#0x28]	; 038014D0
	bl loc_03801214	; 038014D2
	add r0,r4,#0x0	; 038014D6
	bl loc_038011CC	; 038014D8
	cmp r0,#0xfe	; 038014DC
	beq loc_038014EA	; 038014DE
	add r4,#0x28	; 038014E0
	ldr r0,[r4,#0x0]	; 038014E2
	sub r0,r0,#0x1	; 038014E4
	str r0,[r4,#0x0]	; 038014E6
	b loc_03801526	; 038014E8
loc_038014EA:
	add r0,r4,#0x0	; 038014EA
	bl loc_03801194	; 038014EC
	lsl r0,r0,#0xf	; 038014F0
	lsr r4,r0,#0x10	; 038014F2
	mov r6,#0x1	; 038014F4
	str r6,[sp,#0x8]	; 038014F6
	b loc_03801522	; 038014F8
loc_038014FA:
	add r1,r4,#0x0	; 038014FA
	ldr r0,[sp,#0x8]	; 038014FC
	and r1,r0	; 038014FE
	cmp r1,#0x0	; 03801500
	beq loc_0380151C	; 03801502
	bl loc_03800518	; 03801504
	add r7,r0,#0x0	; 03801508
	cmp r7,#0x0	; 0380150A
	blt loc_03801526	; 0380150C
	lsl r1,r7,#0x6	; 0380150E
	ldr r0,[pool_0380154C]	; 03801510
	add r0,r0,r1	; 03801512
	bl loc_0380100C	; 03801514
	add r0,r5,r6	; 03801518
	strb r7,[r0,#0x8]	; 0380151A
loc_0380151C:
	add r6,r6,#0x1	; 0380151C
	lsl r0,r4,#0xf	; 0380151E
	lsr r4,r0,#0x10	; 03801520
loc_03801522:
	cmp r4,#0x0	; 03801522
	bne loc_038014FA	; 03801524
loc_03801526:
	mov r3,#0x1	; 03801526
	strb r3,[r5,#0x0]	; 03801528
	ldr r0,[pool_03801550]	; 0380152A
	ldr r0,[r0,#0x0]	; 0380152C
	cmp r0,#0x0	; 0380152E
	beq loc_0380153E	; 03801530
	add r2,r0,#0x4	; 03801532
	ldr r1,[r2,#0x0]	; 03801534
	ldr r0,[sp,#0x0]	; 03801536
	lsl r3,r0	; 03801538
	orr r1,r3	; 0380153A
	str r1,[r2,#0x0]	; 0380153C
loc_0380153E:
	add sp,#0xc	; 0380153E
	pop {r4,r5,r6,r7}	; 03801540
	pop {r3}	; 03801542
	bx r3	; 03801544
	.byte 0xC0, 0x46	; 03801548
pool_03801548:
loc_03801548:
	.word P2_BssStart + 0x10C4	; 03801548
pool_0380154C:
loc_0380154C:
	.word 0x038066E4	; 0380154C
pool_03801550:
loc_03801550:
	.word P2_BssStart + 0xB80	; 03801550
P2_Entry_03801554:
	push {r4,r5,r6,r7,lr}	; 03801554
	sub sp,#0x4	; 03801556
	add r7,r0,#0x0	; 03801558
	mov r6,#0x0	; 0380155A
	add r4,r6,#0x0	; 0380155C
P2_Entry_0380155E:
	add r0,r4,#0x0	; 0380155E
	mov r1,#0x24	; 03801560
	mul r0,r1	; 03801562
	ldr r1,[pool_038015A8]	; 03801564
	add r5,r1,r0	; 03801566
	ldrb r0,[r1,r0]	; 03801568
	cmp r0,#0x0	; 0380156A
	beq P2_Entry_03801590	; 0380156C
	cmp r7,#0x0	; 0380156E
	beq P2_Entry_0380157E	; 03801570
	ldrb r0,[r5,#0x1]	; 03801572
	cmp r0,#0x0	; 03801574
	bne P2_Entry_0380157E	; 03801576
	add r0,r5,#0x0	; 03801578
	bl P2_Entry_03800EE4	; 0380157A
P2_Entry_0380157E:
	add r0,r5,#0x0	; 0380157E
	bl P2_Entry_03800D64	; 03801580
	ldrb r0,[r5,#0x0]	; 03801584
	cmp r0,#0x0	; 03801586
	beq P2_Entry_03801590	; 03801588
	mov r0,#0x1	; 0380158A
	lsl r0,r4	; 0380158C
	orr r6,r0	; 0380158E
P2_Entry_03801590:
	add r4,r4,#0x1	; 03801590
	cmp r4,#0x10	; 03801592
	blt P2_Entry_0380155E	; 03801594
	ldr r0,[pool_038015AC]	; 03801596
	ldr r0,[r0,#0x0]	; 03801598
	cmp r0,#0x0	; 0380159A
	beq P2_Entry_038015A0	; 0380159C
	str r6,[r0,#0x4]	; 0380159E
P2_Entry_038015A0:
	add sp,#0x4	; 038015A0
	pop {r4,r5,r6,r7}	; 038015A2
	pop {r3}	; 038015A4
	bx r3	; 038015A6
pool_038015A8:
	.word P2_BssStart + 0x10C4	; 038015A8
pool_038015AC:
	.word P2_BssStart + 0xB80	; 038015AC
P2_Entry_038015B0:
	push {r4,r5,lr}	; 038015B0
	sub sp,#0x4	; 038015B2
	mov r5,#0x0	; 038015B4
	ldr r3,[pool_038015E8]	; 038015B6
	add r0,r5,#0x0	; 038015B8
	mov r1,#0x24	; 038015BA
P2_Entry_038015BC:
	add r2,r5,#0x0	; 038015BC
	mul r2,r1	; 038015BE
	add r4,r3,r2	; 038015C0
	strb r0,[r3,r2]	; 038015C2
	strb r5,[r4,#0x2]	; 038015C4
	add r5,r5,#0x1	; 038015C6
	cmp r5,#0x10	; 038015C8
	blt P2_Entry_038015BC	; 038015CA
	ldr r4,[pool_038015EC]	; 038015CC
	mov r1,#0x1	; 038015CE
P2_Entry_038015D0:
	lsl r3,r0,#0x6	; 038015D0
	ldrb r2,[r4,r3]	; 038015D2
	bic r2,r1	; 038015D4
	strb r2,[r4,r3]	; 038015D6
	add r0,r0,#0x1	; 038015D8
	cmp r0,#0x20	; 038015DA
	blt P2_Entry_038015D0	; 038015DC
	add sp,#0x4	; 038015DE
	pop {r4,r5}	; 038015E0
	pop {r3}	; 038015E2
	bx r3	; 038015E4
	.byte 0xC0, 0x46	; 038015E6
pool_038015E8:
	.word P2_BssStart + 0x10C4	; 038015E8
pool_038015EC:
	.word P2_BssStart + 0x1304	; 038015EC

; ===== function loc_038015F0 =====
loc_038015F0:
	lsl r1,r1,#0x3	; 038015F0
	add r0,r0,r1	; 038015F2
	ldr r1,[r0,#0x18]	; 038015F4
	cmp r1,#0x0	; 038015F6
	bne loc_038015FE	; 038015F8
	mov r0,#0x0	; 038015FA
	bx lr	; 038015FC
loc_038015FE:
	ldr r0,[r1,#0x38]	; 038015FE
	cmp r2,r0	; 03801600
	bcc loc_03801608	; 03801602
	mov r0,#0x0	; 03801604
	bx lr	; 03801606
loc_03801608:
	lsl r0,r2,#0x2	; 03801608
	add r0,r1,r0	; 0380160A
	ldr r0,[r0,#0x3c]	; 0380160C
	add r0,r1,r0	; 0380160E
	bx lr	; 03801610
	.byte 0x00, 0x00	; 03801614

; ===== function loc_03801614 =====
P2_Entry_03801614:
	push {r4,r5,r6,r7,lr}	; 03801614
	sub sp,#0x4	; 03801616
	add r5,r0,#0x0	; 03801618
	add r7,r1,#0x0	; 0380161A
	str r2,[sp,#0x0]	; 0380161C
	add r6,r3,#0x0	; 0380161E
	ldr r4,[sp,#0x1c]	; 03801620
	ldrb r1,[r4,#0x0]	; 03801622
	cmp r1,#0x4	; 03801624
	bhi loc_03801682	; 03801626
	add r2,r1,r1	; 03801628
P2_SwitchIndexPC_03801628:
	add r2,pc	; 0380162A
	ldrh r2,[r2,#(P2_SwitchTable_03801628 - (P2_SwitchIndexPC_03801628 + 4))]	; 0380162C
	lsl r2,r2,#0x10	; 0380162E
	asr r2,r2,#0x10	; 03801630
P2_SwitchTargetPC_03801628:
	add r2,pc	; 03801632
	bx r2	; 03801634
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801628:
	.halfword (loc_03801682 + 1) - (P2_SwitchTargetPC_03801628 + 4)
	.halfword (loc_03801640 + 1) - (P2_SwitchTargetPC_03801628 + 4)
	.halfword (loc_03801670 + 1) - (P2_SwitchTargetPC_03801628 + 4)
	.halfword (loc_0380167A + 1) - (P2_SwitchTargetPC_03801628 + 4)
	.halfword (loc_03801640 + 1) - (P2_SwitchTargetPC_03801628 + 4)
P2_SwitchTable_03801628End:
loc_03801640:
	cmp r1,#0x1	; 03801640
	bne loc_03801652	; 03801642
	ldr r0,[sp,#0x18]	; 03801644
	ldrh r1,[r4,#0x4]	; 03801646
	ldrh r2,[r4,#0x2]	; 03801648
	bl loc_038015F0	; 0380164A
	add r2,r0,#0x0	; 0380164E
	b loc_0380165A	; 03801650
loc_03801652:
	ldrh r0,[r4,#0x4]	; 03801652
	lsl r2,r0,#0x10	; 03801654
	ldrh r0,[r4,#0x2]	; 03801656
	orr r2,r0	; 03801658
loc_0380165A:
	cmp r2,#0x0	; 0380165A
	beq loc_0380166C	; 0380165C
	add r0,r5,#0x0	; 0380165E
	add r1,r2,#0x0	; 03801660
	add r2,#0xc	; 03801662
	add r3,r6,#0x0	; 03801664
	bl loc_03800180	; 03801666
	b loc_03801684	; 0380166A
loc_0380166C:
	mov r0,#0x0	; 0380166C
	b loc_03801684	; 0380166E
loc_03801670:
	ldrh r1,[r4,#0x2]	; 03801670
	add r2,r6,#0x0	; 03801672
	bl loc_0380014C	; 03801674
	b loc_03801684	; 03801678
loc_0380167A:
	add r1,r6,#0x0	; 0380167A
	bl loc_0380011C	; 0380167C
	b loc_03801684	; 03801680
loc_03801682:
	mov r0,#0x0	; 03801682
loc_03801684:
	cmp r0,#0x0	; 03801684
	bne loc_0380168C	; 03801686
	mov r0,#0x0	; 03801688
	b loc_038016BE	; 0380168A
loc_0380168C:
	strb r7,[r5,#0x8]	; 0380168C
	ldrb r0,[r4,#0x6]	; 0380168E
	strb r0,[r5,#0x5]	; 03801690
	ldr r0,[sp,#0x0]	; 03801692
	strb r0,[r5,#0x9]	; 03801694
	add r0,r5,#0x0	; 03801696
	ldrb r1,[r4,#0x7]	; 03801698
	bl loc_03800100	; 0380169A
	add r0,r5,#0x0	; 0380169E
	ldrb r1,[r4,#0x8]	; 038016A0
	bl loc_038000EC	; 038016A2
	add r0,r5,#0x0	; 038016A6
	ldrb r1,[r4,#0x9]	; 038016A8
	bl loc_038000E8	; 038016AA
	add r0,r5,#0x0	; 038016AE
	ldrb r1,[r4,#0xa]	; 038016B0
	bl loc_038000D4	; 038016B2
	ldrb r0,[r4,#0xb]	; 038016B6
	sub r0,#0x40	; 038016B8
	strb r0,[r5,#0xa]	; 038016BA
	mov r0,#0x1	; 038016BC
loc_038016BE:
	add sp,#0x4	; 038016BE
	pop {r4,r5,r6,r7}	; 038016C0
	pop {r3}	; 038016C2
	bx r3	; 038016C4
	.byte 0x00, 0x00	; 038016C6
P2_Entry_038016C8:
	push {r4,r5,lr}	; 038016C8
	sub sp,#0x4	; 038016CA
	add r4,r0,#0x0	; 038016CC
	add r0,r3,#0x0	; 038016CE
	cmp r1,#0x0	; 038016D0
	bge P2_Entry_038016D8	; 038016D2
	mov r0,#0x0	; 038016D4
	b P2_Entry_0380179A	; 038016D6
P2_Entry_038016D8:
	ldr r3,[r4,#0x38]	; 038016D8
	cmp r1,r3	; 038016DA
	bcc P2_Entry_038016E2	; 038016DC
	mov r0,#0x0	; 038016DE
	b P2_Entry_0380179A	; 038016E0
P2_Entry_038016E2:
	lsl r1,r1,#0x2	; 038016E2
	add r1,r4,r1	; 038016E4
	ldr r3,[r1,#0x3c]	; 038016E6
	strb r3,[r0,#0x0]	; 038016E8
	ldrb r1,[r0,#0x0]	; 038016EA
	cmp r1,#0x10	; 038016EC
	bgt P2_Entry_03801710	; 038016EE
	cmp r1,#0x10	; 038016F0
	bge P2_Entry_0380172E	; 038016F2
	cmp r1,#0x4	; 038016F4
	bhi P2_Entry_03801794	; 038016F6
	add r5,r1,r1	; 038016F8
P2_SwitchIndexPC_038016F8:
	add r5,pc	; 038016FA
	ldrh r5,[r5,#(P2_SwitchTable_038016F8 - (P2_SwitchIndexPC_038016F8 + 4))]	; 038016FC
	lsl r5,r5,#0x10	; 038016FE
	asr r5,r5,#0x10	; 03801700
P2_SwitchTargetPC_038016F8:
	add r5,pc	; 03801702
	bx r5	; 03801704
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038016F8:
	.halfword (P2_Entry_03801794 + 1) - (P2_SwitchTargetPC_038016F8 + 4)
	.halfword (P2_Case_03801716 + 1) - (P2_SwitchTargetPC_038016F8 + 4)
	.halfword (P2_Case_03801716 + 1) - (P2_SwitchTargetPC_038016F8 + 4)
	.halfword (P2_Case_03801716 + 1) - (P2_SwitchTargetPC_038016F8 + 4)
	.halfword (P2_Case_03801716 + 1) - (P2_SwitchTargetPC_038016F8 + 4)
P2_SwitchTable_038016F8End:
P2_Entry_03801710:
	cmp r1,#0x11	; 03801710
	beq P2_Entry_03801762	; 03801712
	b P2_Entry_03801794	; 03801714
P2_Case_03801716:
	lsr r1,r3,#0x8	; 03801716
	add r3,r4,r1	; 03801718
	add r2,r0,#0x2	; 0380171A
	mov r1,#0x5	; 0380171C
P2_Entry_0380171E:
	ldrh r0,[r3,#0x0]	; 0380171E
	add r3,r3,#0x2	; 03801720
	strh r0,[r2,#0x0]	; 03801722
	add r2,r2,#0x2	; 03801724
	sub r1,r1,#0x1	; 03801726
	cmp r1,#0x0	; 03801728
	bne P2_Entry_0380171E	; 0380172A
	b P2_Entry_03801798	; 0380172C
P2_Entry_0380172E:
	lsr r3,r3,#0x8	; 0380172E
	add r1,r4,r3	; 03801730
	ldrb r5,[r1,#0x1]	; 03801732
	ldrb r3,[r4,r3]	; 03801734
	cmp r2,r3	; 03801736
	bge P2_Entry_0380173E	; 03801738
	mov r0,#0x0	; 0380173A
	b P2_Entry_0380179A	; 0380173C
P2_Entry_0380173E:
	cmp r2,r5	; 0380173E
	ble P2_Entry_03801746	; 03801740
	mov r0,#0x0	; 03801742
	b P2_Entry_0380179A	; 03801744
P2_Entry_03801746:
	sub r3,r2,r3	; 03801746
	mov r2,#0xc	; 03801748
	mul r3,r2	; 0380174A
	add r1,r1,r3	; 0380174C
	add r3,r1,#0x2	; 0380174E
	mov r2,#0x6	; 03801750
P2_Entry_03801752:
	ldrh r1,[r3,#0x0]	; 03801752
	add r3,r3,#0x2	; 03801754
	strh r1,[r0,#0x0]	; 03801756
	add r0,r0,#0x2	; 03801758
	sub r2,r2,#0x1	; 0380175A
	cmp r2,#0x0	; 0380175C
	bne P2_Entry_03801752	; 0380175E
	b P2_Entry_03801798	; 03801760
P2_Entry_03801762:
	mov r1,#0x0	; 03801762
	lsr r3,r3,#0x8	; 03801764
	add r4,r4,r3	; 03801766
	b P2_Entry_03801774	; 03801768
P2_Entry_0380176A:
	add r1,r1,#0x1	; 0380176A
	cmp r1,#0x8	; 0380176C
	blt P2_Entry_03801774	; 0380176E
	mov r0,#0x0	; 03801770
	b P2_Entry_0380179A	; 03801772
P2_Entry_03801774:
	ldrb r3,[r4,r1]	; 03801774
	cmp r2,r3	; 03801776
	bgt P2_Entry_0380176A	; 03801778
	mov r2,#0xc	; 0380177A
	mul r1,r2	; 0380177C
	add r3,r4,r1	; 0380177E
	add r3,#0x8	; 03801780
	mov r2,#0x6	; 03801782
P2_Entry_03801784:
	ldrh r1,[r3,#0x0]	; 03801784
	add r3,r3,#0x2	; 03801786
	strh r1,[r0,#0x0]	; 03801788
	add r0,r0,#0x2	; 0380178A
	sub r2,r2,#0x1	; 0380178C
	cmp r2,#0x0	; 0380178E
	bne P2_Entry_03801784	; 03801790
	b P2_Entry_03801798	; 03801792
P2_Entry_03801794:
	mov r0,#0x0	; 03801794
	b P2_Entry_0380179A	; 03801796
P2_Entry_03801798:
	mov r0,#0x1	; 03801798
P2_Entry_0380179A:
	add sp,#0x4	; 0380179A
	pop {r4,r5}	; 0380179C
	pop {r3}	; 0380179E
	bx r3	; 038017A0
	.byte 0x00, 0x00	; 038017A2

; ===== function loc_038017A4 =====
loc_038017A4:
	push {r4,r5,r6,r7,lr}	; 038017A4
	sub sp,#0x4	; 038017A6
	mov r5,#0x0	; 038017A8
	add r4,r5,#0x0	; 038017AA
	ldr r0,[pool_03801808]	; 038017AC
	ldr r0,[r0,#0x0]	; 038017AE
	cmp r0,#0x0	; 038017B0
	beq loc_03801800	; 038017B2
	add r6,r5,#0x0	; 038017B4
	mov r7,#0x1	; 038017B6
loc_038017B8:
	add r0,r6,#0x0	; 038017B8
	bl loc_037FF5B0	; 038017BA
	cmp r0,#0x0	; 038017BE
	beq loc_038017CC	; 038017C0
	add r0,r7,#0x0	; 038017C2
	lsl r0,r6	; 038017C4
	orr r5,r0	; 038017C6
	lsl r0,r5,#0x10	; 038017C8
	lsr r5,r0,#0x10	; 038017CA
loc_038017CC:
	add r6,r6,#0x1	; 038017CC
	cmp r6,#0x10	; 038017CE
	blt loc_038017B8	; 038017D0
	mov r0,#0x0	; 038017D2
	bl loc_037FFB04	; 038017D4
	cmp r0,#0x0	; 038017D8
	beq loc_038017E4	; 038017DA
	mov r0,#0x1	; 038017DC
	orr r4,r0	; 038017DE
	lsl r0,r4,#0x10	; 038017E0
	lsr r4,r0,#0x10	; 038017E2
loc_038017E4:
	mov r0,#0x1	; 038017E4
	bl loc_037FFB04	; 038017E6
	cmp r0,#0x0	; 038017EA
	beq loc_038017F6	; 038017EC
	mov r0,#0x2	; 038017EE
	orr r4,r0	; 038017F0
	lsl r0,r4,#0x10	; 038017F2
	lsr r4,r0,#0x10	; 038017F4
loc_038017F6:
	ldr r0,[pool_03801808]	; 038017F6
	ldr r1,[r0,#0x0]	; 038017F8
	strh r5,[r1,#0x8]	; 038017FA
	ldr r0,[r0,#0x0]	; 038017FC
	strh r4,[r0,#0xa]	; 038017FE
loc_03801800:
	add sp,#0x4	; 03801800
	pop {r4,r5,r6,r7}	; 03801802
	pop {r3}	; 03801804
	bx r3	; 03801806
pool_03801808:
loc_03801808:
	.word P2_BssStart + 0xB80	; 03801808

; ===== function loc_0380180C =====
loc_0380180C:
	ldr r2,[pool_0380181C]	; 0380180C
	ldr r2,[r2,#0x0]	; 0380180E
	lsl r0,r0,#0x1	; 03801810
	add r2,r2,r0	; 03801812
	ldr r0,[pool_03801820]	; 03801814
	strh r1,[r2,r0]	; 03801816
	bx lr	; 03801818
	.byte 0xC0, 0x46	; 0380181C
pool_0380181C:
loc_0380181C:
	.word P2_BssStart + 0xB80	; 0380181C
pool_03801820:
loc_03801820:
	.word 0x00000260	; 03801820

; ===== function loc_03801824 =====
loc_03801824:
	push {r4,lr}	; 03801824
	ldr r3,[pool_0380183C]	; 03801826
	ldr r4,[r3,#0x0]	; 03801828
	mov r3,#0x24	; 0380182A
	mul r0,r3	; 0380182C
	add r3,r4,r0	; 0380182E
	lsl r0,r1,#0x1	; 03801830
	add r0,r3,r0	; 03801832
	strh r2,[r0,#0x20]	; 03801834
	pop {r4}	; 03801836
	pop {r3}	; 03801838
	bx r3	; 0380183A
pool_0380183C:
loc_0380183C:
	.word P2_BssStart + 0xB80	; 0380183C

; ===== function loc_03801840 =====
P2_Code_03801840:
	push {r4,r5,r6,lr}	; 03801840
	add r5,r0,#0x0	; 03801842
	mov r4,#0x7	; 03801844
	mov r6,#0x0	; 03801846
loc_03801848:
	add r0,r4,#0x0	; 03801848
	add r1,r5,#0x0	; 0380184A
	add r2,r6,#0x0	; 0380184C
	bl loc_03801F84	; 0380184E
	cmp r0,#0x0	; 03801852
	blt loc_03801848	; 03801854
	pop {r4,r5,r6}	; 03801856
	pop {r3}	; 03801858
	bx r3	; 0380185A

; ===== function loc_0380185C =====
loc_0380185C:
	push {r4,lr}	; 0380185C
	ldr r1,[pool_03801884]	; 0380185E
	lsl r0,r0,#0x6	; 03801860
	add r4,r1,r0	; 03801862
	ldrb r0,[r1,r0]	; 03801864
	cmp r0,#0x0	; 03801866
	beq loc_0380187E	; 03801868
	add r0,r4,#0x0	; 0380186A
	add r0,#0x14	; 0380186C
	bl loc_037FEAB0	; 0380186E
	add r1,r4,#0x1	; 03801872
	ldrb r0,[r1,#0x0]	; 03801874
	add r0,r0,#0x1	; 03801876
	strb r0,[r1,#0x0]	; 03801878
	mov r0,#0x0	; 0380187A
	strb r0,[r4,#0x0]	; 0380187C
loc_0380187E:
	pop {r4}	; 0380187E
	pop {r3}	; 03801880
	bx r3	; 03801882
pool_03801884:
loc_03801884:
	.word P2_BssStart + 0x1B04	; 03801884

; ===== function loc_03801888 =====
loc_03801888:
	push {r4,r5,r6,r7,lr}	; 03801888
	sub sp,#0x1c	; 0380188A
	str r0,[sp,#0xc]	; 0380188C
	ldr r1,[pool_03801914]	; 0380188E
	lsl r0,r0,#0x6	; 03801890
	add r5,r1,r0	; 03801892
	ldrb r0,[r1,r0]	; 03801894
	cmp r0,#0x0	; 03801896
	beq loc_038018A6	; 03801898
	add r0,r5,#0x0	; 0380189A
	add r0,#0x14	; 0380189C
	bl loc_037FEAB0	; 0380189E
	mov r0,#0x0	; 038018A2
	strb r0,[r5,#0x0]	; 038018A4
loc_038018A6:
	ldr r6,[r5,#0x4]	; 038018A6
	ldr r7,[r5,#0x8]	; 038018A8
	ldr r0,[r5,#0xc]	; 038018AA
	str r0,[sp,#0x10]	; 038018AC
	ldr r0,[r5,#0x10]	; 038018AE
	str r0,[sp,#0x14]	; 038018B0
	ldrb r0,[r5,#0x1]	; 038018B2
	lsl r4,r0,#0x8	; 038018B4
	ldr r0,[sp,#0xc]	; 038018B6
	orr r4,r0	; 038018B8
	add r0,r5,#0x0	; 038018BA
	add r0,#0x14	; 038018BC
	bl loc_037FEC88	; 038018BE
	mov r2,#0x0	; 038018C2
	ldr r1,[sp,#0x14]	; 038018C4
	eor r1,r2	; 038018C6
	ldr r0,[sp,#0x10]	; 038018C8
	eor r0,r2	; 038018CA
	orr r1,r0	; 038018CC
	bne loc_038018E2	; 038018CE
	str r4,[sp,#0x0]	; 038018D0
	add r0,r5,#0x0	; 038018D2
	add r0,#0x14	; 038018D4
	add r1,r6,#0x0	; 038018D6
	add r2,r7,#0x0	; 038018D8
	ldr r3,[pool_03801918]	; 038018DA
	bl loc_037FEB5C	; 038018DC
	b loc_03801906	; 038018E0
loc_038018E2:
	bl loc_037FE8BC	; 038018E2
	str r0,[sp,#0x18]	; 038018E6
	add r2,r1,#0x0	; 038018E8
	ldr r0,[pool_03801918]	; 038018EA
	str r0,[sp,#0x4]	; 038018EC
	str r4,[sp,#0x8]	; 038018EE
	ldr r3,[sp,#0x10]	; 038018F0
	ldr r0,[sp,#0x14]	; 038018F2
	str r0,[sp,#0x0]	; 038018F4
	add r0,r5,#0x0	; 038018F6
	add r0,#0x14	; 038018F8
	ldr r1,[sp,#0x18]	; 038018FA
	add r1,r6,r1	; 038018FC
	adc r7,r2	; 038018FE
	add r2,r7,#0x0	; 03801900
	bl loc_037FEB0C	; 03801902
loc_03801906:
	mov r0,#0x1	; 03801906
	strb r0,[r5,#0x0]	; 03801908
	add sp,#0x1c	; 0380190A
	pop {r4,r5,r6,r7}	; 0380190C
	pop {r3}	; 0380190E
	bx r3	; 03801910
	.byte 0xC0, 0x46	; 03801914
pool_03801914:
loc_03801914:
	.word P2_BssStart + 0x1B04	; 03801914
pool_03801918:
loc_03801918:
	.word P2_Code_03801840 + 1	; 03801918

; ===== function loc_0380191C =====
loc_0380191C:
	push {r4,r5,r6,lr}	; 0380191C
	sub sp,#0x8	; 0380191E
	add r5,r1,#0x0	; 03801920
	add r6,r2,#0x0	; 03801922
	str r3,[sp,#0x0]	; 03801924
	ldr r1,[sp,#0x18]	; 03801926
	str r1,[sp,#0x4]	; 03801928
	ldr r1,[pool_0380195C]	; 0380192A
	lsl r0,r0,#0x6	; 0380192C
	add r4,r1,r0	; 0380192E
	ldrb r0,[r1,r0]	; 03801930
	cmp r0,#0x0	; 03801932
	beq loc_03801942	; 03801934
	add r0,r4,#0x0	; 03801936
	add r0,#0x14	; 03801938
	bl loc_037FEAB0	; 0380193A
	mov r0,#0x0	; 0380193E
	strb r0,[r4,#0x0]	; 03801940
loc_03801942:
	str r5,[r4,#0x4]	; 03801942
	str r6,[r4,#0x8]	; 03801944
	ldr r0,[sp,#0x0]	; 03801946
	str r0,[r4,#0xc]	; 03801948
	ldr r0,[sp,#0x4]	; 0380194A
	str r0,[r4,#0x10]	; 0380194C
	ldr r0,[sp,#0x1c]	; 0380194E
	strb r0,[r4,#0x1]	; 03801950
	add sp,#0x8	; 03801952
	pop {r4,r5,r6}	; 03801954
	pop {r3}	; 03801956
	bx r3	; 03801958
	.byte 0xC0, 0x46	; 0380195C
pool_0380195C:
loc_0380195C:
	.word P2_BssStart + 0x1B04	; 0380195C
P2_Entry_03801960:
	push {r4,r5,lr}	; 03801960
	sub sp,#0x4	; 03801962
	mov r5,#0x0	; 03801964
	ldr r4,[pool_03801984]	; 03801966
	add r2,r5,#0x0	; 03801968
	ldr r0,[pool_03801988]	; 0380196A
	ldr r1,[pool_0380198C]	; 0380196C
P2_Entry_0380196E:
	lsl r3,r5,#0x6	; 0380196E
	add r3,r4,r3	; 03801970
	strb r2,[r3,r0]	; 03801972
	strb r2,[r3,r1]	; 03801974
	add r5,r5,#0x1	; 03801976
	cmp r5,#0x8	; 03801978
	blt P2_Entry_0380196E	; 0380197A
	add sp,#0x4	; 0380197C
	pop {r4,r5}	; 0380197E
	pop {r3}	; 03801980
	bx r3	; 03801982
pool_03801984:
	.word 0x03805F64	; 03801984
pool_03801988:
	.word 0x00000F80	; 03801988
pool_0380198C:
	.word 0x00000F81	; 0380198C

; ===== function loc_03801990 =====
loc_03801990:
	push {r4,r5,r6,r7,lr}	; 03801990
	sub sp,#0xc	; 03801992
	add r5,r0,#0x0	; 03801994
	add r7,r1,#0x0	; 03801996
	add r6,r2,#0x0	; 03801998
	str r3,[sp,#0x0]	; 0380199A
	bl loc_037FDD34	; 0380199C
	str r0,[sp,#0x4]	; 038019A0
	mov r4,#0x0	; 038019A2
	b loc_038019BA	; 038019A4
loc_038019A6:
	add r1,r6,#0x0	; 038019A6
	mov r0,#0x1	; 038019A8
	and r1,r0	; 038019AA
	cmp r1,#0x0	; 038019AC
	beq loc_038019B6	; 038019AE
	add r0,r4,#0x0	; 038019B0
	bl loc_0380185C	; 038019B2
loc_038019B6:
	add r4,r4,#0x1	; 038019B6
	lsr r6,r6,#0x1	; 038019B8
loc_038019BA:
	cmp r4,#0x8	; 038019BA
	bge loc_038019C2	; 038019BC
	cmp r6,#0x0	; 038019BE
	bne loc_038019A6	; 038019C0
loc_038019C2:
	mov r4,#0x0	; 038019C2
	mov r6,#0x1	; 038019C4
	b loc_038019DC	; 038019C6
loc_038019C8:
	add r0,r5,#0x0	; 038019C8
	and r0,r6	; 038019CA
	cmp r0,#0x0	; 038019CC
	beq loc_038019D8	; 038019CE
	add r0,r4,#0x0	; 038019D0
	ldr r1,[sp,#0x0]	; 038019D2
	bl loc_037FF67C	; 038019D4
loc_038019D8:
	add r4,r4,#0x1	; 038019D8
	lsr r5,r5,#0x1	; 038019DA
loc_038019DC:
	cmp r4,#0x10	; 038019DC
	bge loc_038019E4	; 038019DE
	cmp r5,#0x0	; 038019E0
	bne loc_038019C8	; 038019E2
loc_038019E4:
	mov r0,#0x1	; 038019E4
	add r1,r7,#0x0	; 038019E6
	and r1,r0	; 038019E8
	cmp r1,#0x0	; 038019EA
	beq loc_038019F4	; 038019EC
	mov r1,#0x0	; 038019EE
	ldr r0,[pool_03801A14]	; 038019F0
	strb r1,[r0,#0x0]	; 038019F2
loc_038019F4:
	mov r0,#0x2	; 038019F4
	and r7,r0	; 038019F6
	cmp r7,#0x0	; 038019F8
	beq loc_03801A02	; 038019FA
	mov r1,#0x0	; 038019FC
	ldr r0,[pool_03801A18]	; 038019FE
	strb r1,[r0,#0x0]	; 03801A00
loc_03801A02:
	ldr r0,[sp,#0x4]	; 03801A02
	bl loc_037FDD58	; 03801A04
	bl loc_038017A4	; 03801A08
	add sp,#0xc	; 03801A0C
	pop {r4,r5,r6,r7}	; 03801A0E
	pop {r3}	; 03801A10
	bx r3	; 03801A12
pool_03801A14:
loc_03801A14:
	.word REG_SNDCAP0CNT	; 03801A14
pool_03801A18:
loc_03801A18:
	.word REG_SNDCAP1CNT	; 03801A18

; ===== function loc_03801A1C =====
loc_03801A1C:
	push {r4,r5,r6,r7,lr}	; 03801A1C
	sub sp,#0x4	; 03801A1E
	add r5,r0,#0x0	; 03801A20
	add r4,r1,#0x0	; 03801A22
	add r6,r2,#0x0	; 03801A24
	bl loc_037FDD34	; 03801A26
	add r7,r0,#0x0	; 03801A2A
	mov r3,#0x0	; 03801A2C
	b loc_03801A4C	; 03801A2E
loc_03801A30:
	add r1,r5,#0x0	; 03801A30
	mov r0,#0x1	; 03801A32
	and r1,r0	; 03801A34
	cmp r1,#0x0	; 03801A36
	beq loc_03801A48	; 03801A38
	lsl r1,r3,#0x4	; 03801A3A
	ldr r0,[pool_03801AC4]	; 03801A3C
	add r2,r1,r0	; 03801A3E
	ldrb r1,[r2,#0x0]	; 03801A40
	mov r0,#0x80	; 03801A42
	orr r1,r0	; 03801A44
	strb r1,[r2,#0x0]	; 03801A46
loc_03801A48:
	add r3,r3,#0x1	; 03801A48
	lsr r5,r5,#0x1	; 03801A4A
loc_03801A4C:
	cmp r3,#0x10	; 03801A4C
	bge loc_03801A54	; 03801A4E
	cmp r5,#0x0	; 03801A50
	bne loc_03801A30	; 03801A52
loc_03801A54:
	mov r0,#0x1	; 03801A54
	add r1,r4,#0x0	; 03801A56
	and r1,r0	; 03801A58
	cmp r1,#0x0	; 03801A5A
	beq loc_03801A7E	; 03801A5C
	mov r0,#0x2	; 03801A5E
	and r4,r0	; 03801A60
	cmp r4,#0x0	; 03801A62
	beq loc_03801A72	; 03801A64
	ldr r2,[pool_03801AC8]	; 03801A66
	ldrh r1,[r2,#0x0]	; 03801A68
	ldr r0,[pool_03801ACC]	; 03801A6A
	orr r1,r0	; 03801A6C
	strh r1,[r2,#0x0]	; 03801A6E
	b loc_03801A90	; 03801A70
loc_03801A72:
	ldr r2,[pool_03801AC8]	; 03801A72
	ldrb r1,[r2,#0x0]	; 03801A74
	mov r0,#0x80	; 03801A76
	orr r1,r0	; 03801A78
	strb r1,[r2,#0x0]	; 03801A7A
	b loc_03801A90	; 03801A7C
loc_03801A7E:
	mov r0,#0x2	; 03801A7E
	and r4,r0	; 03801A80
	cmp r4,#0x0	; 03801A82
	beq loc_03801A90	; 03801A84
	ldr r2,[pool_03801AD0]	; 03801A86
	ldrb r1,[r2,#0x0]	; 03801A88
	mov r0,#0x80	; 03801A8A
	orr r1,r0	; 03801A8C
	strb r1,[r2,#0x0]	; 03801A8E
loc_03801A90:
	mov r4,#0x0	; 03801A90
	mov r5,#0x1	; 03801A92
	b loc_03801AA8	; 03801A94
loc_03801A96:
	add r0,r6,#0x0	; 03801A96
	and r0,r5	; 03801A98
	cmp r0,#0x0	; 03801A9A
	beq loc_03801AA4	; 03801A9C
	add r0,r4,#0x0	; 03801A9E
	bl loc_03801888	; 03801AA0
loc_03801AA4:
	add r4,r4,#0x1	; 03801AA4
	lsr r6,r6,#0x1	; 03801AA6
loc_03801AA8:
	cmp r4,#0x8	; 03801AA8
	bge loc_03801AB0	; 03801AAA
	cmp r6,#0x0	; 03801AAC
	bne loc_03801A96	; 03801AAE
loc_03801AB0:
	add r0,r7,#0x0	; 03801AB0
	bl loc_037FDD58	; 03801AB2
	bl loc_038017A4	; 03801AB6
	add sp,#0x4	; 03801ABA
	pop {r4,r5,r6,r7}	; 03801ABC
	pop {r3}	; 03801ABE
	bx r3	; 03801AC0
	.byte 0xC0, 0x46	; 03801AC4
pool_03801AC4:
loc_03801AC4:
	.word SCHANNEL0_CR + 3	; 03801AC4
pool_03801AC8:
loc_03801AC8:
	.word REG_SNDCAP0CNT	; 03801AC8
pool_03801ACC:
loc_03801ACC:
	.word 0x00008080	; 03801ACC
pool_03801AD0:
loc_03801AD0:
	.word REG_SNDCAP1CNT	; 03801AD0

; ===== function loc_03801AD4 =====
loc_03801AD4:
	push {r4,r5,r6,r7,lr}	; 03801AD4
	sub sp,#0x4	; 03801AD6
	add r5,r0,#0x0	; 03801AD8
	add r6,r1,#0x0	; 03801ADA
	mov r4,#0x0	; 03801ADC
	mov r7,#0x1	; 03801ADE
	b loc_03801AF6	; 03801AE0
loc_03801AE2:
	add r0,r5,#0x0	; 03801AE2
	and r0,r7	; 03801AE4
	cmp r0,#0x0	; 03801AE6
	beq loc_03801AF2	; 03801AE8
	add r0,r4,#0x0	; 03801AEA
	add r1,r6,#0x0	; 03801AEC
	bl loc_037FF5CC	; 03801AEE
loc_03801AF2:
	add r4,r4,#0x1	; 03801AF2
	lsr r5,r5,#0x1	; 03801AF4
loc_03801AF6:
	cmp r4,#0x10	; 03801AF6
	bge loc_03801AFE	; 03801AF8
	cmp r5,#0x0	; 03801AFA
	bne loc_03801AE2	; 03801AFC
loc_03801AFE:
	add sp,#0x4	; 03801AFE
	pop {r4,r5,r6,r7}	; 03801B00
	pop {r3}	; 03801B02
	bx r3	; 03801B04
	.byte 0x00, 0x00	; 03801B08

; ===== function loc_03801B08 =====
loc_03801B08:
	push {r4,r5,r6,r7,lr}	; 03801B08
	sub sp,#0x4	; 03801B0A
	add r5,r0,#0x0	; 03801B0C
	add r6,r1,#0x0	; 03801B0E
	add r7,r2,#0x0	; 03801B10
	mov r4,#0x0	; 03801B12
	b loc_03801B2E	; 03801B14
loc_03801B16:
	add r1,r5,#0x0	; 03801B16
	mov r0,#0x1	; 03801B18
	and r1,r0	; 03801B1A
	cmp r1,#0x0	; 03801B1C
	beq loc_03801B2A	; 03801B1E
	add r0,r4,#0x0	; 03801B20
	add r1,r6,#0x0	; 03801B22
	add r2,r7,#0x0	; 03801B24
	bl loc_037FF624	; 03801B26
loc_03801B2A:
	add r4,r4,#0x1	; 03801B2A
	lsr r5,r5,#0x1	; 03801B2C
loc_03801B2E:
	cmp r4,#0x10	; 03801B2E
	bge loc_03801B36	; 03801B30
	cmp r5,#0x0	; 03801B32
	bne loc_03801B16	; 03801B34
loc_03801B36:
	add sp,#0x4	; 03801B36
	pop {r4,r5,r6,r7}	; 03801B38
	pop {r3}	; 03801B3A
	bx r3	; 03801B3C
	.byte 0x00, 0x00	; 03801B40

; ===== function loc_03801B40 =====
loc_03801B40:
	push {r4,r5,r6,r7,lr}	; 03801B40
	sub sp,#0x4	; 03801B42
	add r5,r0,#0x0	; 03801B44
	add r6,r1,#0x0	; 03801B46
	mov r4,#0x0	; 03801B48
	mov r7,#0x1	; 03801B4A
	b loc_03801B62	; 03801B4C
loc_03801B4E:
	add r0,r5,#0x0	; 03801B4E
	and r0,r7	; 03801B50
	cmp r0,#0x0	; 03801B52
	beq loc_03801B5E	; 03801B54
	add r0,r4,#0x0	; 03801B56
	add r1,r6,#0x0	; 03801B58
	bl loc_037FF610	; 03801B5A
loc_03801B5E:
	add r4,r4,#0x1	; 03801B5E
	lsr r5,r5,#0x1	; 03801B60
loc_03801B62:
	cmp r4,#0x10	; 03801B62
	bge loc_03801B6A	; 03801B64
	cmp r5,#0x0	; 03801B66
	bne loc_03801B4E	; 03801B68
loc_03801B6A:
	add sp,#0x4	; 03801B6A
	pop {r4,r5,r6,r7}	; 03801B6C
	pop {r3}	; 03801B6E
	bx r3	; 03801B70
	.byte 0x00, 0x00	; 03801B74

; ===== function loc_03801B74 =====
loc_03801B74:
	mov r0,#0x7	; 03801B74
	ldr r1,[pool_03801B7C]	; 03801B76
	ldr r3,[pool_03801B80]	; 03801B78
	bx r3	; 03801B7A
pool_03801B7C:
loc_03801B7C:
	.word P2_Code_03801B84 + 1	; 03801B7C
pool_03801B80:
loc_03801B80:
	.word P2_SetPxiReceiveCallback + 1	; 03801B80

; ===== function loc_03801B84 =====
P2_Code_03801B84:
	push {r4,r5,lr}	; 03801B84
	sub sp,#0x4	; 03801B86
	add r5,r1,#0x0	; 03801B88
	bl loc_037FDD34	; 03801B8A
	add r4,r0,#0x0	; 03801B8E
	ldr r0,[pool_03801BB8]	; 03801B90
	cmp r5,r0	; 03801B92
	bcc loc_03801BA2	; 03801B94
	ldr r0,[pool_03801BBC]	; 03801B96
	add r1,r5,#0x0	; 03801B98
	mov r2,#0x0	; 03801B9A
	bl loc_037FE354	; 03801B9C
	b loc_03801BAA	; 03801BA0
loc_03801BA2:
	cmp r5,#0x0	; 03801BA2
	bne loc_03801BAA	; 03801BA4
	bl loc_037FFA24	; 03801BA6
loc_03801BAA:
	add r0,r4,#0x0	; 03801BAA
	bl loc_037FDD58	; 03801BAC
	add sp,#0x4	; 03801BB0
	pop {r4,r5}	; 03801BB2
	pop {r3}	; 03801BB4
	bx r3	; 03801BB6
pool_03801BB8:
loc_03801BB8:
	.word 0x02000000	; 03801BB8
pool_03801BBC:
loc_03801BBC:
	.word 0x038070E4	; 03801BBC

; ===== function loc_03801BC0 =====
P2_Entry_03801BC0:
	push {r4,r5,r6,r7,lr}	; 03801BC0
	sub sp,#0x34	; 03801BC2
	mov r4,#0x7f	; 03801BC4
	mov r7,#0x3	; 03801BC6
	mov r6,#0x1	; 03801BC8
	b loc_03801E34	; 03801BCA
loc_03801BCC:
	ldr r5,[sp,#0x18]	; 03801BCC
	b loc_03801E24	; 03801BCE
loc_03801BD0:
	add r3,sp,#0x1c	; 03801BD0
	mov r2,#0x3	; 03801BD2
loc_03801BD4:
	ldmia r5!,{r0,r1}	; 03801BD4
	stmia r3!,{r0,r1}	; 03801BD6
	sub r2,r2,#0x1	; 03801BD8
	cmp r2,#0x0	; 03801BDA
	bne loc_03801BD4	; 03801BDC
	ldr r0,[sp,#0x20]	; 03801BDE
	cmp r0,#0x1d	; 03801BE0
	bls loc_03801BE6	; 03801BE2
	b loc_03801E22	; 03801BE4
loc_03801BE6:
	add r0,r0,r0	; 03801BE6
P2_SwitchIndexPC_03801BE6:
	add r0,pc	; 03801BE8
	ldrh r0,[r0,#(P2_SwitchTable_03801BE6 - (P2_SwitchIndexPC_03801BE6 + 4))]	; 03801BEA
	lsl r0,r0,#0x10	; 03801BEC
	asr r0,r0,#0x10	; 03801BEE
P2_SwitchTargetPC_03801BE6:
	add r0,pc	; 03801BF0
	bx r0	; 03801BF2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801BE6:
	.halfword (loc_03801C30 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C3E + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C46 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C50 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C5E + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C78 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C84 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801C90 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801CA0 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801CAE + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801CBC + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801D26 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801D72 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801D94 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801CCA + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801CF0 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801D06 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801D10 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801D1C + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DB6 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DBE + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DC6 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DD4 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DDE + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DE8 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801E10 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801E18 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DF2 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801DFC + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
	.halfword (loc_03801E06 + 1) - (P2_SwitchTargetPC_03801BE6 + 4)
P2_SwitchTable_03801BE6End:
loc_03801C30:
	ldr r0,[sp,#0x24]	; 03801C30
	ldr r1,[sp,#0x28]	; 03801C32
	ldr r2,[sp,#0x2c]	; 03801C34
	ldr r3,[sp,#0x30]	; 03801C36
	bl loc_03801484	; 03801C38
	b loc_03801E22	; 03801C3C
loc_03801C3E:
	ldr r0,[sp,#0x24]	; 03801C3E
	bl loc_03801448	; 03801C40
	b loc_03801E22	; 03801C44
loc_03801C46:
	ldr r0,[sp,#0x24]	; 03801C46
	ldr r1,[sp,#0x28]	; 03801C48
	bl loc_03801410	; 03801C4A
	b loc_03801E22	; 03801C4E
loc_03801C50:
	ldr r0,[sp,#0x24]	; 03801C50
	ldr r1,[sp,#0x28]	; 03801C52
	ldr r2,[sp,#0x2c]	; 03801C54
	ldr r3,[sp,#0x30]	; 03801C56
	bl loc_03801294	; 03801C58
	b loc_03801E22	; 03801C5C
loc_03801C5E:
	ldr r0,[sp,#0x24]	; 03801C5E
	lsr r2,r0,#0x18	; 03801C60
	mov r1,#0xff	; 03801C62
	and r2,r1	; 03801C64
	str r2,[sp,#0x0]	; 03801C66
	ldr r1,[pool_03801E4C]	; 03801C68
	and r0,r1	; 03801C6A
	ldr r1,[sp,#0x28]	; 03801C6C
	ldr r2,[sp,#0x2c]	; 03801C6E
	ldr r3,[sp,#0x30]	; 03801C70
	bl loc_03801238	; 03801C72
	b loc_03801E22	; 03801C76
loc_03801C78:
	ldr r0,[sp,#0x24]	; 03801C78
	ldr r1,[sp,#0x28]	; 03801C7A
	ldr r2,[sp,#0x2c]	; 03801C7C
	bl loc_038013A8	; 03801C7E
	b loc_03801E22	; 03801C82
loc_03801C84:
	ldr r0,[sp,#0x24]	; 03801C84
	ldr r1,[sp,#0x28]	; 03801C86
	ldr r2,[sp,#0x2c]	; 03801C88
	bl loc_03801358	; 03801C8A
	b loc_03801E22	; 03801C8E
loc_03801C90:
	ldr r0,[sp,#0x24]	; 03801C90
	ldr r1,[sp,#0x28]	; 03801C92
	ldr r2,[sp,#0x2c]	; 03801C94
	lsl r2,r2,#0x10	; 03801C96
	asr r2,r2,#0x10	; 03801C98
	bl loc_03801824	; 03801C9A
	b loc_03801E22	; 03801C9E
loc_03801CA0:
	ldr r0,[sp,#0x24]	; 03801CA0
	ldr r1,[sp,#0x28]	; 03801CA2
	lsl r1,r1,#0x10	; 03801CA4
	asr r1,r1,#0x10	; 03801CA6
	bl loc_0380180C	; 03801CA8
	b loc_03801E22	; 03801CAC
loc_03801CAE:
	ldr r0,[sp,#0x24]	; 03801CAE
	ldr r1,[sp,#0x28]	; 03801CB0
	ldr r2,[sp,#0x2c]	; 03801CB2
	ldr r3,[sp,#0x30]	; 03801CB4
	bl loc_03801A1C	; 03801CB6
	b loc_03801E22	; 03801CBA
loc_03801CBC:
	ldr r0,[sp,#0x24]	; 03801CBC
	ldr r1,[sp,#0x28]	; 03801CBE
	ldr r2,[sp,#0x2c]	; 03801CC0
	ldr r3,[sp,#0x30]	; 03801CC2
	bl loc_03801990	; 03801CC4
	b loc_03801E22	; 03801CC8
loc_03801CCA:
	ldr r1,[sp,#0x2c]	; 03801CCA
	lsr r0,r1,#0x1d	; 03801CCC
	and r0,r6	; 03801CCE
	str r0,[sp,#0x0]	; 03801CD0
	lsr r0,r1,#0x1c	; 03801CD2
	and r0,r6	; 03801CD4
	str r0,[sp,#0x4]	; 03801CD6
	lsr r0,r1,#0x1b	; 03801CD8
	and r0,r6	; 03801CDA
	str r0,[sp,#0x8]	; 03801CDC
	lsr r0,r1,#0x1f	; 03801CDE
	and r0,r6	; 03801CE0
	lsr r1,r1,#0x1e	; 03801CE2
	and r1,r6	; 03801CE4
	ldr r2,[sp,#0x24]	; 03801CE6
	ldr r3,[sp,#0x28]	; 03801CE8
	bl loc_037FFB1C	; 03801CEA
	b loc_03801E22	; 03801CEE
loc_03801CF0:
	ldr r0,[sp,#0x30]	; 03801CF0
	str r0,[sp,#0x4]	; 03801CF2
	ldr r3,[sp,#0x2c]	; 03801CF4
	mov r0,#0x0	; 03801CF6
	str r0,[sp,#0x0]	; 03801CF8
	ldr r0,[sp,#0x24]	; 03801CFA
	ldr r1,[sp,#0x28]	; 03801CFC
	mov r2,#0x0	; 03801CFE
	bl loc_0380191C	; 03801D00
	b loc_03801E22	; 03801D04
loc_03801D06:
	ldr r0,[sp,#0x24]	; 03801D06
	ldr r1,[sp,#0x28]	; 03801D08
	bl loc_03801B40	; 03801D0A
	b loc_03801E22	; 03801D0E
loc_03801D10:
	ldr r0,[sp,#0x24]	; 03801D10
	ldr r1,[sp,#0x28]	; 03801D12
	ldr r2,[sp,#0x2c]	; 03801D14
	bl loc_03801B08	; 03801D16
	b loc_03801E22	; 03801D1A
loc_03801D1C:
	ldr r0,[sp,#0x24]	; 03801D1C
	ldr r1,[sp,#0x28]	; 03801D1E
	bl loc_03801AD4	; 03801D20
	b loc_03801E22	; 03801D24
loc_03801D26:
	ldr r3,[sp,#0x30]	; 03801D26
	ldr r2,[sp,#0x24]	; 03801D28
	ldr r1,[sp,#0x2c]	; 03801D2A
	add r5,r3,#0x0	; 03801D2C
	ldr r0,[pool_03801E50]	; 03801D2E
	and r5,r0	; 03801D30
	str r5,[sp,#0x0]	; 03801D32
	add r5,r1,#0x0	; 03801D34
	ldr r0,[pool_03801E54]	; 03801D36
	and r5,r0	; 03801D38
	str r5,[sp,#0x4]	; 03801D3A
	lsr r0,r1,#0x18	; 03801D3C
	and r0,r4	; 03801D3E
	str r0,[sp,#0x8]	; 03801D40
	lsr r0,r1,#0x16	; 03801D42
	and r0,r7	; 03801D44
	str r0,[sp,#0xc]	; 03801D46
	lsr r1,r2,#0x10	; 03801D48
	ldr r0,[pool_03801E50]	; 03801D4A
	and r1,r0	; 03801D4C
	str r1,[sp,#0x10]	; 03801D4E
	lsr r0,r3,#0x10	; 03801D50
	and r0,r4	; 03801D52
	str r0,[sp,#0x14]	; 03801D54
	ldr r0,[pool_03801E50]	; 03801D56
	and r2,r0	; 03801D58
	add r0,r2,#0x0	; 03801D5A
	ldr r2,[sp,#0x28]	; 03801D5C
	ldr r1,[pool_03801E58]	; 03801D5E
	and r2,r1	; 03801D60
	add r1,r2,#0x0	; 03801D62
	lsr r2,r3,#0x18	; 03801D64
	and r2,r7	; 03801D66
	lsr r3,r3,#0x1a	; 03801D68
	and r3,r7	; 03801D6A
	bl loc_037FF778	; 03801D6C
	b loc_03801E22	; 03801D70
loc_03801D72:
	ldr r2,[sp,#0x2c]	; 03801D72
	ldr r3,[sp,#0x28]	; 03801D74
	lsr r1,r2,#0x8	; 03801D76
	ldr r0,[pool_03801E50]	; 03801D78
	and r1,r0	; 03801D7A
	str r1,[sp,#0x0]	; 03801D7C
	and r2,r4	; 03801D7E
	str r2,[sp,#0x4]	; 03801D80
	ldr r0,[sp,#0x24]	; 03801D82
	ldr r1,[sp,#0x30]	; 03801D84
	add r2,r3,#0x0	; 03801D86
	and r2,r4	; 03801D88
	lsr r3,r3,#0x8	; 03801D8A
	and r3,r7	; 03801D8C
	bl loc_037FF70C	; 03801D8E
	b loc_03801E22	; 03801D92
loc_03801D94:
	ldr r3,[sp,#0x2c]	; 03801D94
	ldr r2,[sp,#0x28]	; 03801D96
	add r0,r3,#0x0	; 03801D98
	and r0,r4	; 03801D9A
	str r0,[sp,#0x0]	; 03801D9C
	ldr r0,[sp,#0x24]	; 03801D9E
	add r1,r2,#0x0	; 03801DA0
	and r1,r4	; 03801DA2
	lsr r2,r2,#0x8	; 03801DA4
	and r2,r7	; 03801DA6
	lsr r5,r3,#0x8	; 03801DA8
	ldr r3,[pool_03801E50]	; 03801DAA
	and r5,r3	; 03801DAC
	add r3,r5,#0x0	; 03801DAE
	bl loc_037FF6A4	; 03801DB0
	b loc_03801E22	; 03801DB4
loc_03801DB6:
	ldr r0,[sp,#0x24]	; 03801DB6
	bl loc_037FF564	; 03801DB8
	b loc_03801E22	; 03801DBC
loc_03801DBE:
	ldr r0,[sp,#0x24]	; 03801DBE
	bl loc_037FF48C	; 03801DC0
	b loc_03801E22	; 03801DC4
loc_03801DC6:
	ldr r0,[sp,#0x24]	; 03801DC6
	ldr r1,[sp,#0x28]	; 03801DC8
	ldr r2,[sp,#0x2c]	; 03801DCA
	ldr r3,[sp,#0x30]	; 03801DCC
	bl loc_037FF458	; 03801DCE
	b loc_03801E22	; 03801DD2
loc_03801DD4:
	ldr r0,[sp,#0x24]	; 03801DD4
	ldr r1,[sp,#0x28]	; 03801DD6
	bl loc_037FFEC4	; 03801DD8
	b loc_03801E22	; 03801DDC
loc_03801DDE:
	ldr r0,[sp,#0x24]	; 03801DDE
	ldr r1,[sp,#0x28]	; 03801DE0
	bl loc_037FFEA0	; 03801DE2
	b loc_03801E22	; 03801DE6
loc_03801DE8:
	ldr r0,[sp,#0x24]	; 03801DE8
	ldr r1,[sp,#0x28]	; 03801DEA
	bl loc_037FFF70	; 03801DEC
	b loc_03801E22	; 03801DF0
loc_03801DF2:
	ldr r0,[sp,#0x24]	; 03801DF2
	ldr r1,[sp,#0x28]	; 03801DF4
	bl loc_03801300	; 03801DF6
	b loc_03801E22	; 03801DFA
loc_03801DFC:
	ldr r0,[sp,#0x24]	; 03801DFC
	ldr r1,[sp,#0x28]	; 03801DFE
	bl loc_038012C4	; 03801E00
	b loc_03801E22	; 03801E04
loc_03801E06:
	ldr r0,[sp,#0x24]	; 03801E06
	ldr r1,[sp,#0x28]	; 03801E08
	bl loc_037FFE50	; 03801E0A
	b loc_03801E22	; 03801E0E
loc_03801E10:
	ldr r1,[sp,#0x24]	; 03801E10
	ldr r0,[pool_03801E5C]	; 03801E12
	str r1,[r0,#0x0]	; 03801E14
	b loc_03801E22	; 03801E16
loc_03801E18:
	ldr r0,[pool_03801E60]	; 03801E18
	ldr r1,[sp,#0x24]	; 03801E1A
	ldr r2,[pool_03801E64]	; 03801E1C
	bl loc_03801E6C	; 03801E1E
loc_03801E22:
	ldr r5,[sp,#0x1c]	; 03801E22
loc_03801E24:
	cmp r5,#0x0	; 03801E24
	beq loc_03801E2A	; 03801E26
	b loc_03801BD0	; 03801E28
loc_03801E2A:
	ldr r0,[pool_03801E5C]	; 03801E2A
	ldr r1,[r0,#0x0]	; 03801E2C
	ldr r0,[r1,#0x0]	; 03801E2E
	add r0,r0,#0x1	; 03801E30
	str r0,[r1,#0x0]	; 03801E32
loc_03801E34:
	ldr r0,[pool_03801E68]	; 03801E34
	add r1,sp,#0x18	; 03801E36
	mov r2,#0x0	; 03801E38
	bl loc_037FE2DC	; 03801E3A
	cmp r0,#0x0	; 03801E3E
	beq loc_03801E44	; 03801E40
	b loc_03801BCC	; 03801E42
loc_03801E44:
	add sp,#0x34	; 03801E44
	pop {r4,r5,r6,r7}	; 03801E46
	pop {r3}	; 03801E48
	bx r3	; 03801E4A
pool_03801E4C:
loc_03801E4C:
	.word 0x00FFFFFF	; 03801E4C
pool_03801E50:
loc_03801E50:
	.word 0x0000FFFF	; 03801E50
pool_03801E54:
loc_03801E54:
	.word 0x003FFFFF	; 03801E54
pool_03801E58:
loc_03801E58:
	.word 0x07FFFFFF	; 03801E58
pool_03801E5C:
loc_03801E5C:
	.word P2_BssStart + 0xB80	; 03801E5C
pool_03801E60:
loc_03801E60:
	.word 0x03805F64	; 03801E60
pool_03801E64:
loc_03801E64:
	.word 0x00001180	; 03801E64
pool_03801E68:
loc_03801E68:
	.word 0x038070E4	; 03801E68

; ===== function loc_03801E6C =====
loc_03801E6C:
	bx pc	; 03801E6C
	.byte 0xC0, 0x46	; 03801E70
.arm

; ===== function loc_03801E70 =====
loc_03801E70:
	ldr pc,[pool_03801E74]	; 03801E70
pool_03801E74:
loc_03801E74:
	.word loc_037FF3B8	; 03801E74
.thumb

; ===== function loc_03801E78 =====
loc_03801E78:
	push {lr}	; 03801E78
	sub sp,#0x4	; 03801E7A
	ldr r0,[pool_03801E98]	; 03801E7C
	ldr r1,[pool_03801E9C]	; 03801E7E
	mov r2,#0x8	; 03801E80
	bl loc_037FE3B0	; 03801E82
	bl loc_03801B74	; 03801E86
	mov r1,#0x0	; 03801E8A
	ldr r0,[pool_03801EA0]	; 03801E8C
	str r1,[r0,#0x0]	; 03801E8E
	add sp,#0x4	; 03801E90
	pop {r3}	; 03801E92
	bx r3	; 03801E94
	.byte 0xC0, 0x46	; 03801E98
pool_03801E98:
loc_03801E98:
	.word 0x038070E4	; 03801E98
pool_03801E9C:
loc_03801E9C:
	.word 0x038070F8	; 03801E9C
pool_03801EA0:
loc_03801EA0:
	.word P2_BssStart + 0xB80	; 03801EA0

; ===== function loc_03801EA4 =====
loc_03801EA4:
	ldr r3,[pool_03801EA8]	; 03801EA4
	bx r3	; 03801EA6
pool_03801EA8:
loc_03801EA8:
	.word loc_0380205C + 1	; 03801EA8

; ===== function loc_03801EAC =====
P2_IrqHandler_03801EAC:
	push {r4,r5,r6,r7,lr}	; 03801EAC
	sub sp,#0x4	; 03801EAE
	ldr r5,[pool_03801F68]	; 03801EB0
	mov r0,#0x3	; 03801EB2
	mvn r6,r0	; 03801EB4
	mov r7,#0x2	; 03801EB6
	mvn r4,r7	; 03801EB8
loc_03801EBA:
	ldrh r1,[r5,#0x0]	; 03801EBA
	ldr r0,[pool_03801F6C]	; 03801EBC
	and r1,r0	; 03801EBE
	cmp r1,#0x0	; 03801EC0
	beq loc_03801ED0	; 03801EC2
	ldrh r1,[r5,#0x0]	; 03801EC4
	ldr r0,[pool_03801F70]	; 03801EC6
	orr r1,r0	; 03801EC8
	strh r1,[r5,#0x0]	; 03801ECA
	add r0,r4,#0x0	; 03801ECC
	b loc_03801EF2	; 03801ECE
loc_03801ED0:
	bl loc_037FDD34	; 03801ED0
	ldrh r2,[r5,#0x0]	; 03801ED4
	ldr r1,[pool_03801F74]	; 03801ED6
	and r2,r1	; 03801ED8
	cmp r2,#0x0	; 03801EDA
	beq loc_03801EE6	; 03801EDC
	bl loc_037FDD58	; 03801EDE
	add r0,r6,#0x0	; 03801EE2
	b loc_03801EF2	; 03801EE4
loc_03801EE6:
	ldr r1,[pool_03801F78]	; 03801EE6
	ldr r1,[r1,#0x0]	; 03801EE8
	str r1,[sp,#0x0]	; 03801EEA
	bl loc_037FDD58	; 03801EEC
	mov r0,#0x0	; 03801EF0
loc_03801EF2:
	mov r1,#0x3	; 03801EF2
	mvn r1,r1	; 03801EF4
	cmp r0,r1	; 03801EF6
	beq loc_03801F60	; 03801EF8
	mvn r1,r7	; 03801EFA
	cmp r0,r1	; 03801EFC
	beq loc_03801EBA	; 03801EFE
	ldr r2,[sp,#0x0]	; 03801F00
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 03801F02
	lsr r0,r0,#0x1b	; 03801F04
	cmp r0,#0x0	; 03801F06
	beq loc_03801EBA	; 03801F08
	lsl r3,r0,#0x2	; 03801F0A
	ldr r1,[pool_03801F7C]	; 03801F0C
	ldr r3,[r1,r3]	; 03801F0E
	cmp r3,#0x0	; 03801F10
	beq loc_03801F20	; 03801F12
	lsr r1,r2,#0x6	; 03801F14
	lsl r2,r2,#0x1a	; 03801F16
	lsr r2,r2,#0x1f	; 03801F18
	bl loc_038050D8	; 03801F1A
	b loc_03801EBA	; 03801F1E
loc_03801F20:
	lsl r0,r2,#0x1a	; 03801F20
	lsr r0,r0,#0x1f	; 03801F22
	cmp r0,#0x0	; 03801F24
	bne loc_03801EBA	; 03801F26
	mov r0,#0x20	; 03801F28
	orr r2,r0	; 03801F2A
	str r2,[sp,#0x0]	; 03801F2C
	ldrh r1,[r5,#0x0]	; 03801F2E
	ldr r0,[pool_03801F6C]	; 03801F30
	and r1,r0	; 03801F32
	cmp r1,#0x0	; 03801F34
	beq loc_03801F42	; 03801F36
	ldrh r1,[r5,#0x0]	; 03801F38
	ldr r0,[pool_03801F70]	; 03801F3A
	orr r1,r0	; 03801F3C
	strh r1,[r5,#0x0]	; 03801F3E
	b loc_03801EBA	; 03801F40
loc_03801F42:
	bl loc_037FDD34	; 03801F42
	ldrh r1,[r5,#0x0]	; 03801F46
	and r1,r7	; 03801F48
	cmp r1,#0x0	; 03801F4A
	beq loc_03801F54	; 03801F4C
	bl loc_037FDD58	; 03801F4E
	b loc_03801EBA	; 03801F52
loc_03801F54:
	ldr r2,[sp,#0x0]	; 03801F54
	ldr r1,[pool_03801F80]	; 03801F56
	str r2,[r1,#0x0]	; 03801F58
	bl loc_037FDD58	; 03801F5A
	b loc_03801EBA	; 03801F5E
loc_03801F60:
	add sp,#0x4	; 03801F60
	pop {r4,r5,r6,r7}	; 03801F62
	pop {r3}	; 03801F64
	bx r3	; 03801F66
pool_03801F68:
loc_03801F68:
	.word REG_IPC_FIFO_CR	; 03801F68
pool_03801F6C:
loc_03801F6C:
	.word 0x00004000	; 03801F6C
pool_03801F70:
loc_03801F70:
	.word 0x0000C000	; 03801F70
pool_03801F74:
loc_03801F74:
	.word 0x00000100	; 03801F74
pool_03801F78:
loc_03801F78:
	.word REG_IPC_FIFO_RX	; 03801F78
pool_03801F7C:
loc_03801F7C:
	.word P2_PxiReceiveCallbacks	; 03801F7C
pool_03801F80:
loc_03801F80:
	.word REG_IPC_FIFO_TX	; 03801F80

; ===== function loc_03801F84 =====
loc_03801F84:
	push {r4,lr}	; 03801F84
	sub sp,#0x8	; 03801F86
	ldr r3,[sp,#0x0]	; 03801F88
	mov r4,#0x1f	; 03801F8A
	bic r3,r4	; 03801F8C
	and r0,r4	; 03801F8E
	orr r3,r0	; 03801F90
	str r3,[sp,#0x0]	; 03801F92
	mov r0,#0x20	; 03801F94
	bic r3,r0	; 03801F96
	mov r0,#0x1	; 03801F98
	and r2,r0	; 03801F9A
	lsl r0,r2,#0x5	; 03801F9C
	orr r3,r0	; 03801F9E
	str r3,[sp,#0x0]	; 03801FA0
	mov r0,#0x3f	; 03801FA2
	and r3,r0	; 03801FA4
	ldr r0,[pool_03801FF8]	; 03801FA6
	and r1,r0	; 03801FA8
	lsl r0,r1,#0x6	; 03801FAA
	orr r3,r0	; 03801FAC
	str r3,[sp,#0x0]	; 03801FAE
	ldr r2,[pool_03801FFC]	; 03801FB0
	ldrh r1,[r2,#0x0]	; 03801FB2
	ldr r0,[pool_03802000]	; 03801FB4
	and r1,r0	; 03801FB6
	cmp r1,#0x0	; 03801FB8
	beq loc_03801FCA	; 03801FBA
	ldrh r1,[r2,#0x0]	; 03801FBC
	ldr r0,[pool_03802004]	; 03801FBE
	orr r1,r0	; 03801FC0
	strh r1,[r2,#0x0]	; 03801FC2
	mov r0,#0x0	; 03801FC4
	mvn r0,r0	; 03801FC6
	b loc_03801FF0	; 03801FC8
loc_03801FCA:
	bl loc_037FDD34	; 03801FCA
	ldr r1,[pool_03801FFC]	; 03801FCE
	ldrh r2,[r1,#0x0]	; 03801FD0
	mov r1,#0x2	; 03801FD2
	and r2,r1	; 03801FD4
	cmp r2,#0x0	; 03801FD6
	beq loc_03801FE4	; 03801FD8
	bl loc_037FDD58	; 03801FDA
	mov r0,#0x1	; 03801FDE
	mvn r0,r0	; 03801FE0
	b loc_03801FF0	; 03801FE2
loc_03801FE4:
	ldr r2,[sp,#0x0]	; 03801FE4
	ldr r1,[pool_03802008]	; 03801FE6
	str r2,[r1,#0x0]	; 03801FE8
	bl loc_037FDD58	; 03801FEA
	mov r0,#0x0	; 03801FEE
loc_03801FF0:
	add sp,#0x8	; 03801FF0
	pop {r4}	; 03801FF2
	pop {r3}	; 03801FF4
	bx r3	; 03801FF6
pool_03801FF8:
loc_03801FF8:
	.word 0x03FFFFFF	; 03801FF8
pool_03801FFC:
loc_03801FFC:
	.word REG_IPC_FIFO_CR	; 03801FFC
pool_03802000:
loc_03802000:
	.word 0x00004000	; 03802000
pool_03802004:
loc_03802004:
	.word 0x0000C000	; 03802004
pool_03802008:
loc_03802008:
	.word REG_IPC_FIFO_TX	; 03802008

; ===== function loc_0380200C =====
loc_0380200C:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P2_SetPxiReceiveCallback
	push {r4,r5,lr}	; 0380200C
	sub sp,#0x4	; 0380200E
	add r5,r0,#0x0	; 03802010
	add r4,r1,#0x0	; 03802012
	bl loc_037FDD34	; 03802014
	lsl r2,r5,#0x2	; 03802018
	ldr r1,[pool_03802050]	; 0380201A
	str r4,[r1,r2]	; 0380201C
	cmp r4,#0x0	; 0380201E
	beq loc_03802034	; 03802020
	ldr r2,[pool_03802054]	; 03802022
	ldr r1,[pool_03802058]	; 03802024
	add r1,r2,r1	; 03802026
	ldr r3,[r1,#0x0]	; 03802028
	mov r2,#0x1	; 0380202A
	lsl r2,r5	; 0380202C
	orr r3,r2	; 0380202E
	str r3,[r1,#0x0]	; 03802030
	b loc_03802044	; 03802032
loc_03802034:
	ldr r2,[pool_03802054]	; 03802034
	ldr r1,[pool_03802058]	; 03802036
	add r1,r2,r1	; 03802038
	ldr r3,[r1,#0x0]	; 0380203A
	mov r2,#0x1	; 0380203C
	lsl r2,r5	; 0380203E
	bic r3,r2	; 03802040
	str r3,[r1,#0x0]	; 03802042
loc_03802044:
	bl loc_037FDD58	; 03802044
	add sp,#0x4	; 03802048
	pop {r4,r5}	; 0380204A
	pop {r3}	; 0380204C
	bx r3	; 0380204E
.endfunc
pool_03802050:
loc_03802050:
	.word P2_PxiReceiveCallbacks	; 03802050
pool_03802054:
loc_03802054:
	.word FirmwareSystemWorkAddress	; 03802054
pool_03802058:
loc_03802058:
	.word SystemWorkPxiArm7AvailableOffset	; 03802058

; ===== function loc_0380205C =====
loc_0380205C:
	push {r4,r5,r6,r7,lr}	; 0380205C
	sub sp,#0x4	; 0380205E
	bl loc_037FDD34	; 03802060
	add r5,r0,#0x0	; 03802064
	ldr r0,[pool_038020D0]	; 03802066
	ldrh r1,[r0,#0x0]	; 03802068
	cmp r1,#0x0	; 0380206A
	bne loc_038020C0	; 0380206C
	mov r1,#0x1	; 0380206E
	strh r1,[r0,#0x0]	; 03802070
	mov r3,#0x0	; 03802072
	ldr r1,[pool_038020D4]	; 03802074
	ldr r0,[pool_038020D8]	; 03802076
	str r3,[r1,r0]	; 03802078
	add r2,r3,#0x0	; 0380207A
	ldr r0,[pool_038020DC]	; 0380207C
loc_0380207E:
	lsl r1,r3,#0x2	; 0380207E
	str r2,[r0,r1]	; 03802080
	add r3,r3,#0x1	; 03802082
	cmp r3,#PxiFifoChannelCount	; 03802084
	blt loc_0380207E	; 03802086
	ldr r0,[pool_038020E0]	; 03802088
	ldr r1,[pool_038020E4]	; 0380208A
	bl loc_037FDB68	; 0380208C
	ldr r0,[pool_038020E0]	; 03802090
	bl loc_037FDAE4	; 03802092
	ldr r1,[pool_038020E8]	; 03802096
	ldr r0,[pool_038020EC]	; 03802098
	strh r1,[r0,#0x0]	; 0380209A
	mov r4,#0x8	; 0380209C
	add r7,r4,#0x0	; 0380209E
	ldr r6,[pool_038020F0]	; 038020A0
	b loc_038020BC	; 038020A2
loc_038020A4:
	lsl r0,r4,#0x8	; 038020A4
	strh r0,[r6,#0x0]	; 038020A6
	ldr r0,[pool_038020F4]	; 038020A8
	bl loc_037FF21C	; 038020AA
	ldrh r1,[r6,#0x0]	; 038020AE
	mov r0,#0xf	; 038020B0
	and r1,r0	; 038020B2
	cmp r1,r4	; 038020B4
	beq loc_038020BA	; 038020B6
	add r4,r7,#0x0	; 038020B8
loc_038020BA:
	sub r4,r4,#0x1	; 038020BA
loc_038020BC:
	cmp r4,#0x0	; 038020BC
	bge loc_038020A4	; 038020BE
loc_038020C0:
	add r0,r5,#0x0	; 038020C0
	bl loc_037FDD58	; 038020C2
	add sp,#0x4	; 038020C6
	pop {r4,r5,r6,r7}	; 038020C8
	pop {r3}	; 038020CA
	bx r3	; 038020CC
	.byte 0xC0, 0x46	; 038020D0
pool_038020D0:
loc_038020D0:
	.word P2_BssStart + 0x1D38	; 038020D0
pool_038020D4:
loc_038020D4:
	.word FirmwareSystemWorkAddress	; 038020D4
pool_038020D8:
loc_038020D8:
	.word SystemWorkPxiArm7AvailableOffset	; 038020D8
pool_038020DC:
loc_038020DC:
	.word P2_PxiReceiveCallbacks	; 038020DC
pool_038020E0:
loc_038020E0:
	.word 0x00040000	; 038020E0
pool_038020E4:
loc_038020E4:
	.word P2_IrqHandler_03801EAC + 1	; 038020E4
pool_038020E8:
loc_038020E8:
	.word 0x0000C408	; 038020E8
pool_038020EC:
loc_038020EC:
	.word REG_IPC_FIFO_CR	; 038020EC
pool_038020F0:
loc_038020F0:
	.word REG_IPC_SYNC	; 038020F0
pool_038020F4:
loc_038020F4:
	.word 0x000003E8	; 038020F4
; 采样 X/Y、调试键与合盖输入；将合盖位转换为共享状态 bit15。
; Sample X/Y, debug and hinge inputs; publish the hinge bit as shared bit15.
.func P2_PublishExtendedKeyState
	push {r4,lr}	; 038020F8
	mov r4,#0x0	; 038020FA
	ldr r0,[pool_03802124]	; 038020FC
	bl loc_03802198	; 038020FE
	ldr r0,[pool_03802128]	; 03802102
	ldrh r2,[r0,#0x0]	; 03802104
	mov r0,#KEYXY_LID_CLOSED	; 03802106
	add r1,r2,#0x0	; 03802108
	and r1,r0	; 0380210A
	cmp r1,#0x0	; 0380210C
	beq loc_03802112	; 0380210E
	ldr r4,[pool_03802124]	; 03802110
loc_03802112:
	mov r0,#0xb	; 03802112
	and r2,r0	; 03802114
	lsl r1,r2,#0xa	; 03802116
	orr r1,r4	; 03802118
	ldr r0,[pool_0380212C]	; 0380211A
	strh r1,[r0,#0x0]	; 0380211C
	pop {r4}	; 0380211E
	pop {r3}	; 03802120
	bx r3	; 03802122
.endfunc
pool_03802124:
loc_03802124:
; 此 0x8000 常量也传给 RCNT 模式设置；原代码共用同一槽。
; The same 0x8000 literal also selects RCNT GPIO mode in the original code.
	.word SystemWorkLidClosedMask	; 03802124
pool_03802128:
loc_03802128:
	.word REG_KEYXY	; 03802128
pool_0380212C:
loc_0380212C:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 0380212C

; ===== function loc_03802130 =====
loc_03802130:
	push {r4,r5,lr}	; 03802130
	sub sp,#0xc	; 03802132
	bl loc_037FE988	; 03802134
	cmp r0,#0x0	; 03802138
	beq loc_03802144	; 0380213A
	bl loc_037FEC90	; 0380213C
	cmp r0,#0x0	; 03802140
	bne loc_03802148	; 03802142
loc_03802144:
	mov r0,#0x0	; 03802144
	b loc_03802180	; 03802146
loc_03802148:
	ldr r0,[pool_03802188]	; 03802148
	ldr r0,[r0,#0x0]	; 0380214A
	cmp r0,#0x0	; 0380214C
	beq loc_03802154	; 0380214E
	mov r0,#0x0	; 03802150
	b loc_03802180	; 03802152
loc_03802154:
	ldr r0,[pool_0380218C]	; 03802154
	bl loc_037FEC88	; 03802156
	bl loc_037FE8BC	; 0380215A
	add r2,r0,#0x0	; 0380215E
	ldr r0,[pool_03802190]	; 03802160
	str r0,[sp,#0x4]	; 03802162
	mov r5,#0x0	; 03802164
	str r5,[sp,#0x8]	; 03802166
	ldr r3,[pool_03802194]	; 03802168
	str r5,[sp,#0x0]	; 0380216A
	ldr r0,[pool_0380218C]	; 0380216C
	add r4,r2,r3	; 0380216E
	lsl r2,r1,#0	; 03802170
	adc r2,r5	; 03802172
	add r1,r4,#0x0	; 03802174
	bl loc_037FEB0C	; 03802176
	mov r0,#0x1	; 0380217A
	ldr r1,[pool_03802188]	; 0380217C
	str r0,[r1,#0x0]	; 0380217E
loc_03802180:
	add sp,#0xc	; 03802180
	pop {r4,r5}	; 03802182
	pop {r3}	; 03802184
	bx r3	; 03802186
pool_03802188:
loc_03802188:
	.word P2_BssStart + 0x1DBC	; 03802188
pool_0380218C:
loc_0380218C:
	.word 0x038071A0	; 0380218C
pool_03802190:
loc_03802190:
	.word P2_PublishExtendedKeyState + 1	; 03802190
pool_03802194:
loc_03802194:
	.word 0x0000082E	; 03802194

; ===== function loc_03802198 =====
loc_03802198:
	add r1,r0,#0x0	; 03802198
	ldr r0,[pool_038021A4]	; 0380219A
	lsl r1,r1,#0x10	; 0380219C
	lsr r1,r1,#0x10	; 0380219E
	ldr r3,[pool_038021A8]	; 038021A0
	bx r3	; 038021A2
pool_038021A4:
loc_038021A4:
	.word 0x0000C000	; 038021A4
pool_038021A8:
loc_038021A8:
	.word loc_038021AC + 1	; 038021A8
loc_038021AC:
	mvn r3,r0	; 038021AC
	ldr r2,[pool_038021BC]	; 038021AE
	ldrh r0,[r2,#0x0]	; 038021B0
	and r3,r0	; 038021B2
	orr r1,r3	; 038021B4
	strh r1,[r2,#0x0]	; 038021B6
	bx lr	; 038021B8
	.byte 0xC0, 0x46	; 038021BC
pool_038021BC:
loc_038021BC:
	.word REG_RCNT_ARM7	; 038021BC

; ===== function loc_038021C0 =====
loc_038021C0:
	push {lr}	; 038021C0
	sub sp,#0x4	; 038021C2
	add r0,sp,#0x0	; 038021C4
	bl loc_03802944	; 038021C6
	add r0,sp,#0x0	; 038021CA
	add r0,#0x2	; 038021CC
	bl loc_03802904	; 038021CE
	add r0,sp,#0x0	; 038021D2
	ldrh r1,[r0,#0x0]	; 038021D4
	lsl r2,r1,#0x18	; 038021D6
	lsr r2,r2,#0x1f	; 038021D8
	cmp r2,#0x0	; 038021DA
	bne loc_038021F0	; 038021DC
	lsl r1,r1,#0x19	; 038021DE
	lsr r1,r1,#0x1f	; 038021E0
	cmp r1,#0x0	; 038021E2
	bne loc_038021F0	; 038021E4
	ldrh r0,[r0,#0x2]	; 038021E6
	lsl r0,r0,#0x18	; 038021E8
	lsr r0,r0,#0x1f	; 038021EA
	cmp r0,#0x0	; 038021EC
	beq loc_03802202	; 038021EE
loc_038021F0:
	add r1,sp,#0x0	; 038021F0
	ldrh r2,[r1,#0x0]	; 038021F2
	mov r0,#0x1	; 038021F4
	bic r2,r0	; 038021F6
	orr r2,r0	; 038021F8
	strh r2,[r1,#0x0]	; 038021FA
	add r0,sp,#0x0	; 038021FC
	bl loc_03802924	; 038021FE
loc_03802202:
	mov r0,#0x1	; 03802202
	bl loc_03802A74	; 03802204
	add sp,#0x4	; 03802208
	pop {r3}	; 0380220A
	bx r3	; 0380220C
	.byte 0x00, 0x00	; 03802210
P2_Code_03802210:
	ldr r0,[pool_03802218]	; 03802210
	ldr r3,[pool_0380221C]	; 03802212
	bx r3	; 03802214
	.byte 0xC0, 0x46	; 03802218
pool_03802218:
loc_03802218:
	.word 0x038073EC	; 03802218
pool_0380221C:
loc_0380221C:
	.word loc_037FDF58 + 1	; 0380221C

; ===== function loc_03802220 =====
P2_ThreadEntry_03802220:
	push {r4,r5,r6,r7,lr}	; 03802220
	sub sp,#0xc	; 03802222
	add r4,sp,#0x0	; 03802224
	ldrh r1,[r4,#0x2]	; 03802226
	mov r0,#0x10	; 03802228
	bic r1,r0	; 0380222A
	strh r1,[r4,#0x2]	; 0380222C
	ldrh r1,[r4,#0x2]	; 0380222E
	mov r0,#0x20	; 03802230
	bic r1,r0	; 03802232
	strh r1,[r4,#0x2]	; 03802234
	ldr r6,[pool_038022B4]	; 03802236
	mov r7,#0xf	; 03802238
loc_0380223A:
	ldr r0,[pool_038022B8]	; 0380223A
	bl loc_037FDFA0	; 0380223C
	ldr r0,[r6,#0x1c]	; 03802240
	cmp r0,#0x0	; 03802242
	bne loc_0380223A	; 03802244
	add r0,sp,#0x0	; 03802246
	bl loc_03802944	; 03802248
	ldrh r1,[r4,#0x0]	; 0380224C
	lsl r0,r1,#0x1b	; 0380224E
	lsr r2,r0,#0x1f	; 03802250
	ldrh r0,[r4,#0x2]	; 03802252
	lsl r3,r0,#0x1b	; 03802254
	lsr r3,r3,#0x1f	; 03802256
	sub r2,r2,r3	; 03802258
	cmp r2,#0x1	; 0380225A
	beq loc_0380226C	; 0380225C
	lsl r1,r1,#0x1a	; 0380225E
	lsr r1,r1,#0x1f	; 03802260
	lsl r0,r0,#0x1a	; 03802262
	lsr r0,r0,#0x1f	; 03802264
	sub r0,r1,r0	; 03802266
	cmp r0,#0x1	; 03802268
	bne loc_038022AC	; 0380226A
loc_0380226C:
	add r0,sp,#0x4	; 0380226C
	bl loc_03802904	; 0380226E
	mov r5,#0x0	; 03802272
	ldrh r0,[r4,#0x0]	; 03802274
	lsl r0,r0,#0x1b	; 03802276
	lsr r0,r0,#0x1f	; 03802278
	cmp r0,#0x0	; 0380227A
	beq loc_03802288	; 0380227C
	mov r0,#0x1	; 0380227E
	orr r5,r0	; 03802280
	ldrh r0,[r4,#0x4]	; 03802282
	bic r0,r7	; 03802284
	strh r0,[r4,#0x4]	; 03802286
loc_03802288:
	ldrh r0,[r4,#0x0]	; 03802288
	lsl r0,r0,#0x1a	; 0380228A
	lsr r0,r0,#0x1f	; 0380228C
	cmp r0,#0x0	; 0380228E
	beq loc_0380229E	; 03802290
	mov r0,#0x2	; 03802292
	orr r5,r0	; 03802294
	ldrh r1,[r4,#0x4]	; 03802296
	mov r0,#0x40	; 03802298
	bic r1,r0	; 0380229A
	strh r1,[r4,#0x4]	; 0380229C
loc_0380229E:
	add r0,sp,#0x4	; 0380229E
	bl loc_038028E4	; 038022A0
	mov r0,#0x30	; 038022A4
	add r1,r5,#0x0	; 038022A6
	bl loc_038024B0	; 038022A8
loc_038022AC:
	ldrh r0,[r4,#0x0]	; 038022AC
	strh r0,[r4,#0x2]	; 038022AE
	b loc_0380223A	; 038022B0
	.byte 0xC0, 0x46	; 038022B4
pool_038022B4:
loc_038022B4:
	.word 0x03807350	; 038022B4
pool_038022B8:
loc_038022B8:
	.word 0x038073EC	; 038022B8

; ===== function loc_038022BC =====
P2_ThreadEntry_038022BC:
	push {r4,r5,r6,r7,lr}	; 038022BC
	sub sp,#0x4	; 038022BE
	ldr r5,[pool_038024A4]	; 038022C0
	add r6,r5,#0x4	; 038022C2
	mov r7,#0x0	; 038022C4
	ldr r4,[pool_038024A8]	; 038022C6
loc_038022C8:
	ldr r0,[pool_038024AC]	; 038022C8
	add r1,sp,#0x0	; 038022CA
	mov r2,#0x1	; 038022CC
	bl loc_037FE2DC	; 038022CE
	ldrh r0,[r4,#0x20]	; 038022D2
	cmp r0,#0x10	; 038022D4
	bgt loc_038022F2	; 038022D6
	cmp r0,#0x10	; 038022D8
	bge loc_0380235C	; 038022DA
	cmp r0,#0x1	; 038022DC
	ble loc_038022E2	; 038022DE
	b loc_03802498	; 038022E0
loc_038022E2:
	cmp r0,#0x0	; 038022E2
	bge loc_038022E8	; 038022E4
	b loc_03802498	; 038022E6
loc_038022E8:
	cmp r0,#0x0	; 038022E8
	beq loc_03802336	; 038022EA
	cmp r0,#0x1	; 038022EC
	beq loc_03802346	; 038022EE
	b loc_03802498	; 038022F0
loc_038022F2:
	add r1,r0,#0x0	; 038022F2
	sub r1,#0x14	; 038022F4
	cmp r1,#0x15	; 038022F6
	bls loc_038022FC	; 038022F8
	b loc_03802498	; 038022FA
loc_038022FC:
	add r1,r1,r1	; 038022FC
P2_SwitchIndexPC_038022FC:
	add r1,pc	; 038022FE
	ldrh r1,[r1,#(P2_SwitchTable_038022FC - (P2_SwitchIndexPC_038022FC + 4))]	; 03802300
	lsl r1,r1,#0x10	; 03802302
	asr r1,r1,#0x10	; 03802304
P2_SwitchTargetPC_038022FC:
	add r1,pc	; 03802306
	bx r1	; 03802308
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038022FC:
	.halfword (loc_0380236E + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802390 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_038023B2 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_038023C4 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_038023D6 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_038023E8 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_038023FA + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802498 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_0380240C + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_0380242E + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802450 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802462 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802474 + 1) - (P2_SwitchTargetPC_038022FC + 4)
	.halfword (loc_03802486 + 1) - (P2_SwitchTargetPC_038022FC + 4)
P2_SwitchTable_038022FCEnd:
loc_03802336:
	bl loc_03802B1C	; 03802336
	str r7,[r4,#0x1c]	; 0380233A
	add r0,r7,#0x0	; 0380233C
	add r1,r7,#0x0	; 0380233E
	bl loc_038024B0	; 03802340
	b loc_038022C8	; 03802344
loc_03802346:
	ldrh r0,[r5,#0x0]	; 03802346
	lsl r0,r0,#0x1e	; 03802348
	lsr r0,r0,#0x1f	; 0380234A
	bl loc_03802A74	; 0380234C
	str r7,[r4,#0x1c]	; 03802350
	mov r0,#0x1	; 03802352
	add r1,r7,#0x0	; 03802354
	bl loc_038024B0	; 03802356
	b loc_038022C8	; 0380235A
loc_0380235C:
	add r0,r5,#0x0	; 0380235C
	bl loc_03802A54	; 0380235E
	str r7,[r4,#0x1c]	; 03802362
	mov r0,#0x10	; 03802364
	add r1,r7,#0x0	; 03802366
	bl loc_038024B0	; 03802368
	b loc_038022C8	; 0380236C
loc_0380236E:
	add r0,r5,#0x4	; 0380236E
	bl loc_03802A00	; 03802370
	cmp r0,#0x0	; 03802374
	bne loc_03802384	; 03802376
	str r7,[r4,#0x1c]	; 03802378
	mov r0,#0x14	; 0380237A
	mov r1,#0x2	; 0380237C
	bl loc_038024B0	; 0380237E
	b loc_038022C8	; 03802382
loc_03802384:
	str r7,[r4,#0x1c]	; 03802384
	mov r0,#0x14	; 03802386
	add r1,r7,#0x0	; 03802388
	bl loc_038024B0	; 0380238A
	b loc_038022C8	; 0380238E
loc_03802390:
	add r0,r6,#0x0	; 03802390
	bl loc_03802998	; 03802392
	cmp r0,#0x0	; 03802396
	bne loc_038023A6	; 03802398
	str r7,[r4,#0x1c]	; 0380239A
	mov r0,#0x15	; 0380239C
	mov r1,#0x2	; 0380239E
	bl loc_038024B0	; 038023A0
	b loc_038022C8	; 038023A4
loc_038023A6:
	str r7,[r4,#0x1c]	; 038023A6
	mov r0,#0x15	; 038023A8
	add r1,r7,#0x0	; 038023AA
	bl loc_038024B0	; 038023AC
	b loc_038022C8	; 038023B0
loc_038023B2:
	add r0,r5,#0x0	; 038023B2
	bl loc_03802944	; 038023B4
	str r7,[r4,#0x1c]	; 038023B8
	mov r0,#0x16	; 038023BA
	add r1,r7,#0x0	; 038023BC
	bl loc_038024B0	; 038023BE
	b loc_038022C8	; 038023C2
loc_038023C4:
	add r0,r5,#0x2	; 038023C4
	bl loc_03802904	; 038023C6
	str r7,[r4,#0x1c]	; 038023CA
	mov r0,#0x17	; 038023CC
	add r1,r7,#0x0	; 038023CE
	bl loc_038024B0	; 038023D0
	b loc_038022C8	; 038023D4
loc_038023D6:
	add r0,r5,#0x4	; 038023D6
	bl loc_038028C4	; 038023D8
	str r7,[r4,#0x1c]	; 038023DC
	mov r0,#0x18	; 038023DE
	add r1,r7,#0x0	; 038023E0
	bl loc_038024B0	; 038023E2
	b loc_038022C8	; 038023E6
loc_038023E8:
	add r0,r5,#0x4	; 038023E8
	bl loc_03802884	; 038023EA
	str r7,[r4,#0x1c]	; 038023EE
	mov r0,#0x19	; 038023F0
	add r1,r7,#0x0	; 038023F2
	bl loc_038024B0	; 038023F4
	b loc_038022C8	; 038023F8
loc_038023FA:
	add r0,r5,#0x0	; 038023FA
	bl loc_03802A34	; 038023FC
	str r7,[r4,#0x1c]	; 03802400
	mov r0,#0x20	; 03802402
	add r1,r7,#0x0	; 03802404
	bl loc_038024B0	; 03802406
	b loc_038022C8	; 0380240A
loc_0380240C:
	add r0,r6,#0x0	; 0380240C
	bl loc_038029CC	; 0380240E
	cmp r0,#0x0	; 03802412
	bne loc_03802422	; 03802414
	str r7,[r4,#0x1c]	; 03802416
	mov r0,#0x24	; 03802418
	mov r1,#0x2	; 0380241A
	bl loc_038024B0	; 0380241C
	b loc_038022C8	; 03802420
loc_03802422:
	str r7,[r4,#0x1c]	; 03802422
	mov r0,#0x24	; 03802424
	add r1,r7,#0x0	; 03802426
	bl loc_038024B0	; 03802428
	b loc_038022C8	; 0380242C
loc_0380242E:
	add r0,r6,#0x0	; 0380242E
	bl loc_03802964	; 03802430
	cmp r0,#0x0	; 03802434
	bne loc_03802444	; 03802436
	str r7,[r4,#0x1c]	; 03802438
	mov r0,#0x25	; 0380243A
	mov r1,#0x2	; 0380243C
	bl loc_038024B0	; 0380243E
	b loc_038022C8	; 03802442
loc_03802444:
	str r7,[r4,#0x1c]	; 03802444
	mov r0,#0x25	; 03802446
	add r1,r7,#0x0	; 03802448
	bl loc_038024B0	; 0380244A
	b loc_038022C8	; 0380244E
loc_03802450:
	add r0,r5,#0x0	; 03802450
	bl loc_03802924	; 03802452
	str r7,[r4,#0x1c]	; 03802456
	mov r0,#0x26	; 03802458
	add r1,r7,#0x0	; 0380245A
	bl loc_038024B0	; 0380245C
	b loc_038022C8	; 03802460
loc_03802462:
	add r0,r5,#0x2	; 03802462
	bl loc_038028E4	; 03802464
	str r7,[r4,#0x1c]	; 03802468
	mov r0,#0x27	; 0380246A
	add r1,r7,#0x0	; 0380246C
	bl loc_038024B0	; 0380246E
	b loc_038022C8	; 03802472
loc_03802474:
	add r0,r5,#0x4	; 03802474
	bl loc_038028A4	; 03802476
	str r7,[r4,#0x1c]	; 0380247A
	mov r0,#0x28	; 0380247C
	add r1,r7,#0x0	; 0380247E
	bl loc_038024B0	; 03802480
	b loc_038022C8	; 03802484
loc_03802486:
	add r0,r5,#0x4	; 03802486
	bl loc_03802864	; 03802488
	str r7,[r4,#0x1c]	; 0380248C
	mov r0,#0x29	; 0380248E
	add r1,r7,#0x0	; 03802490
	bl loc_038024B0	; 03802492
	b loc_038022C8	; 03802496
loc_03802498:
	str r7,[r4,#0x1c]	; 03802498
	mov r1,#0x1	; 0380249A
	bl loc_038024B0	; 0380249C
	b loc_038022C8	; 038024A0
	.byte 0xC0, 0x46	; 038024A4
pool_038024A4:
loc_038024A4:
	.word 0x027FFDE8	; 038024A4
pool_038024A8:
loc_038024A8:
	.word 0x03807350	; 038024A8
pool_038024AC:
loc_038024AC:
	.word 0x038071D0	; 038024AC

; ===== function loc_038024B0 =====
loc_038024B0:
	add r2,r0,#0x0	; 038024B0
	mov r0,#0x5	; 038024B2
	lsl r3,r2,#0x8	; 038024B4
	ldr r2,[pool_038024CC]	; 038024B6
	and r3,r2	; 038024B8
	ldr r2,[pool_038024D0]	; 038024BA
	orr r3,r2	; 038024BC
	mov r2,#0xff	; 038024BE
	and r1,r2	; 038024C0
	orr r3,r1	; 038024C2
	add r1,r3,#0x0	; 038024C4
	mov r2,#0x0	; 038024C6
	ldr r3,[pool_038024D4]	; 038024C8
	bx r3	; 038024CA
pool_038024CC:
loc_038024CC:
	.word 0x00007F00	; 038024CC
pool_038024D0:
loc_038024D0:
	.word 0x00008000	; 038024D0
pool_038024D4:
loc_038024D4:
	.word loc_03801F84 + 1	; 038024D4
P2_PxiCallback_038024D8:
	push {r4,lr}	; 038024D8
	cmp r2,#0x0	; 038024DA
	bne loc_0380257A	; 038024DC
	ldr r0,[pool_03802580]	; 038024DE
	and r1,r0	; 038024E0
	lsl r0,r1,#0x8	; 038024E2
	lsr r4,r0,#0x10	; 038024E4
	cmp r4,#0x10	; 038024E6
	bgt loc_03802500	; 038024E8
	cmp r4,#0x10	; 038024EA
	bge loc_03802542	; 038024EC
	cmp r4,#0x1	; 038024EE
	bgt loc_03802572	; 038024F0
	cmp r4,#0x0	; 038024F2
	blt loc_03802572	; 038024F4
	cmp r4,#0x0	; 038024F6
	beq loc_03802542	; 038024F8
	cmp r4,#0x1	; 038024FA
	beq loc_03802542	; 038024FC
	b loc_03802572	; 038024FE
loc_03802500:
	add r0,r4,#0x0	; 03802500
	sub r0,#0x14	; 03802502
	cmp r0,#0x15	; 03802504
	bhi loc_03802572	; 03802506
	add r0,r0,r0	; 03802508
P2_SwitchIndexPC_03802508:
	add r0,pc	; 0380250A
	ldrh r0,[r0,#(P2_SwitchTable_03802508 - (P2_SwitchIndexPC_03802508 + 4))]	; 0380250C
	lsl r0,r0,#0x10	; 0380250E
	asr r0,r0,#0x10	; 03802510
P2_SwitchTargetPC_03802508:
	add r0,pc	; 03802512
	bx r0	; 03802514
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802508:
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802572 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
	.halfword (loc_03802542 + 1) - (P2_SwitchTargetPC_03802508 + 4)
P2_SwitchTable_03802508End:
loc_03802542:
	ldr r0,[pool_03802584]	; 03802542
	ldr r1,[r0,#0x1c]	; 03802544
	cmp r1,#0x0	; 03802546
	beq loc_03802554	; 03802548
	add r0,r4,#0x0	; 0380254A
	mov r1,#0x3	; 0380254C
	bl loc_038024B0	; 0380254E
	b loc_0380257A	; 03802552
loc_03802554:
	mov r1,#0x1	; 03802554
	str r1,[r0,#0x1c]	; 03802556
	strh r4,[r0,#0x20]	; 03802558
	ldr r0,[pool_03802588]	; 0380255A
	mov r1,#0x0	; 0380255C
	add r2,r1,#0x0	; 0380255E
	bl loc_037FE354	; 03802560
	cmp r0,#0x0	; 03802564
	bne loc_0380257A	; 03802566
	add r0,r4,#0x0	; 03802568
	mov r1,#0x4	; 0380256A
	bl loc_038024B0	; 0380256C
	b loc_0380257A	; 03802570
loc_03802572:
	add r0,r4,#0x0	; 03802572
	mov r1,#0x1	; 03802574
	bl loc_038024B0	; 03802576
loc_0380257A:
	pop {r4}	; 0380257A
	pop {r3}	; 0380257C
	bx r3	; 0380257E
pool_03802580:
loc_03802580:
	.word 0x00007F00	; 03802580
pool_03802584:
loc_03802584:
	.word P2_BssStart + 0x1F70	; 03802584
pool_03802588:
loc_03802588:
	.word 0x038071D0	; 03802588

; ===== function loc_0380258C =====
loc_0380258C:
	push {r4,lr}	; 0380258C
	sub sp,#0x10	; 0380258E
	add r4,r0,#0x0	; 03802590
	mov r1,#0x1	; 03802592
	ldr r0,[pool_03802628]	; 03802594
	strh r1,[r0,#0x0]	; 03802596
	ldr r0,[pool_0380262C]	; 03802598
	str r1,[r0,#0x1c]	; 0380259A
	bl loc_038021C0	; 0380259C
	mov r1,#0x0	; 038025A0
	ldr r0,[pool_0380262C]	; 038025A2
	str r1,[r0,#0x1c]	; 038025A4
	bl loc_03801EA4	; 038025A6
	mov r0,#0x5	; 038025AA
	ldr r1,[pool_03802630]	; 038025AC
	bl P2_SetPxiReceiveCallback	; 038025AE
	ldr r0,[pool_03802634]	; 038025B2
	ldr r1,[pool_03802638]	; 038025B4
	mov r2,#0x4	; 038025B6
	bl loc_037FE3B0	; 038025B8
	ldr r0,[pool_0380263C]	; 038025BC
	str r0,[sp,#0x0]	; 038025BE
	str r4,[sp,#0x4]	; 038025C0
	ldr r0,[pool_03802640]	; 038025C2
	ldr r1,[pool_03802644]	; 038025C4
	mov r2,#0x0	; 038025C6
	ldr r3,[pool_03802648]	; 038025C8
	bl P2_CreateThread	; 038025CA
	ldr r0,[pool_03802640]	; 038025CE
	bl loc_037FDF34	; 038025D0
	mov r2,#0x0	; 038025D4
	ldr r0,[pool_0380264C]	; 038025D6
	strh r2,[r0,#0x1c]	; 038025D8
	ldr r0,[pool_0380263C]	; 038025DA
	str r0,[sp,#0x0]	; 038025DC
	sub r0,r4,#0x1	; 038025DE
	str r0,[sp,#0x4]	; 038025E0
	ldr r0,[pool_03802650]	; 038025E2
	ldr r1,[pool_03802654]	; 038025E4
	ldr r3,[pool_03802658]	; 038025E6
	bl P2_CreateThread	; 038025E8
	ldr r0,[pool_03802650]	; 038025EC
	bl loc_037FDF34	; 038025EE
	bl loc_037FEC90	; 038025F2
	cmp r0,#0x0	; 038025F6
	bne loc_038025FE	; 038025F8
	bl loc_037FEC9C	; 038025FA
loc_038025FE:
	ldr r0,[pool_03802658]	; 038025FE
	bl loc_037FEC88	; 03802600
	bl loc_037FE8BC	; 03802604
	add r4,r0,#0x0	; 03802608
	add r2,r1,#0x0	; 0380260A
	ldr r0,[pool_0380265C]	; 0380260C
	str r0,[sp,#0x4]	; 0380260E
	mov r0,#0x0	; 03802610
	str r0,[sp,#0x8]	; 03802612
	ldr r3,[pool_03802660]	; 03802614
	str r0,[sp,#0x0]	; 03802616
	ldr r0,[pool_03802658]	; 03802618
	add r1,r4,#0x0	; 0380261A
	bl loc_037FEB0C	; 0380261C
	add sp,#0x10	; 03802620
	pop {r4}	; 03802622
	pop {r3}	; 03802624
	bx r3	; 03802626
pool_03802628:
loc_03802628:
	.word P2_BssStart + 0x1DEC	; 03802628
pool_0380262C:
loc_0380262C:
	.word P2_BssStart + 0x1F70	; 0380262C
pool_03802630:
loc_03802630:
	.word P2_PxiCallback_038024D8 + 1	; 03802630
pool_03802634:
loc_03802634:
	.word 0x038071D0	; 03802634
pool_03802638:
loc_03802638:
	.word 0x038071E4	; 03802638
pool_0380263C:
loc_0380263C:
	.word 0x00000100	; 0380263C
pool_03802640:
loc_03802640:
	.word 0x038071F4	; 03802640
pool_03802644:
loc_03802644:
	.word P2_ThreadEntry_038022BC + 1	; 03802644
pool_03802648:
loc_03802648:
	.word 0x0380736C	; 03802648
pool_0380264C:
loc_0380264C:
	.word P2_BssStart + 0x1FF0	; 0380264C
pool_03802650:
loc_03802650:
	.word 0x03807374	; 03802650
pool_03802654:
loc_03802654:
	.word P2_ThreadEntry_03802220 + 1	; 03802654
pool_03802658:
loc_03802658:
	.word 0x038074F0	; 03802658
pool_0380265C:
loc_0380265C:
	.word P2_Code_03802210 + 1	; 0380265C
pool_03802660:
loc_03802660:
	.word 0x00001388	; 03802660

; ===== function loc_03802664 =====
loc_03802664:
	push {r4,r5,r6,r7,lr}	; 03802664
	sub sp,#0x4	; 03802666
	add r5,r0,#0x0	; 03802668
	add r7,r1,#0x0	; 0380266A
	add r4,r2,#0x0	; 0380266C
	add r6,r3,#0x0	; 0380266E
	bl loc_038026A4	; 03802670
	add r0,r5,#0x0	; 03802674
	add r1,r7,#0x0	; 03802676
	bl loc_038026B0	; 03802678
	cmp r5,#0x6	; 0380267C
	beq loc_0380268E	; 0380267E
	cmp r5,#0x86	; 03802680
	bne loc_03802696	; 03802682
	add r0,r4,#0x0	; 03802684
	add r1,r6,#0x0	; 03802686
	bl loc_038026BC	; 03802688
	b loc_03802696	; 0380268C
loc_0380268E:
	add r0,r4,#0x0	; 0380268E
	add r1,r6,#0x0	; 03802690
	bl loc_038026C8	; 03802692
loc_03802696:
	bl loc_038026D4	; 03802696
	add sp,#0x4	; 0380269A
	pop {r4,r5,r6,r7}	; 0380269C
	pop {r3}	; 0380269E
	bx r3	; 038026A0
	.byte 0xC0, 0x46	; 038026A4

; ===== function loc_038026A4 =====
loc_038026A4:
	bx pc	; 038026A4
	.byte 0xC0, 0x46	; 038026A8
.arm

; ===== function loc_038026A8 =====
loc_038026A8:
	ldr pc,[pool_038026AC]	; 038026A8
pool_038026AC:
loc_038026AC:
	.word loc_03802B48	; 038026AC
.thumb

; ===== function loc_038026B0 =====
loc_038026B0:
	bx pc	; 038026B0
	.byte 0xC0, 0x46	; 038026B4
.arm

; ===== function loc_038026B4 =====
loc_038026B4:
	ldr pc,[pool_038026B8]	; 038026B4
pool_038026B8:
loc_038026B8:
	.word loc_03802BBC	; 038026B8
.thumb

; ===== function loc_038026BC =====
loc_038026BC:
	bx pc	; 038026BC
	.byte 0xC0, 0x46	; 038026C0
.arm

; ===== function loc_038026C0 =====
loc_038026C0:
	ldr pc,[pool_038026C4]	; 038026C0
pool_038026C4:
loc_038026C4:
	.word loc_03802CBC	; 038026C4
.thumb

; ===== function loc_038026C8 =====
loc_038026C8:
	bx pc	; 038026C8
	.byte 0xC0, 0x46	; 038026CC
.arm

; ===== function loc_038026CC =====
loc_038026CC:
	ldr pc,[pool_038026D0]	; 038026CC
pool_038026D0:
loc_038026D0:
	.word loc_03802C2C	; 038026D0
.thumb

; ===== function loc_038026D4 =====
loc_038026D4:
	bx pc	; 038026D4
	.byte 0xC0, 0x46	; 038026D8
.arm

; ===== function loc_038026D8 =====
loc_038026D8:
	ldr pc,[pool_038026DC]	; 038026D8
pool_038026DC:
loc_038026DC:
	.word loc_03802B88	; 038026DC
.thumb

; ===== function loc_038026E0 =====
loc_038026E0:
	ldr r1,[r0,#0x0]	; 038026E0
	lsl r2,r1,#0x12	; 038026E2
	lsr r2,r2,#0x1a	; 038026E4
	cmp r2,#0x23	; 038026E6
	bhi loc_0380277C	; 038026E8
	add r3,r2,r2	; 038026EA
P2_SwitchIndexPC_038026EA:
	add r3,pc	; 038026EC
	ldrh r3,[r3,#(P2_SwitchTable_038026EA - (P2_SwitchIndexPC_038026EA + 4))]	; 038026EE
	lsl r3,r3,#0x10	; 038026F0
	asr r3,r3,#0x10	; 038026F2
P2_SwitchTargetPC_038026EA:
	add r3,pc	; 038026F4
	bx r3	; 038026F6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038026EA:
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380275A + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380275A + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802740 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_0380277C + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
	.halfword (loc_03802774 + 1) - (P2_SwitchTargetPC_038026EA + 4)
P2_SwitchTable_038026EAEnd:
loc_03802740:
	lsl r3,r1,#0x11	; 03802740
	lsr r3,r3,#0x1f	; 03802742
	cmp r3,#0x0	; 03802744
	beq loc_0380278C	; 03802746
	ldr r3,[pool_03802790]	; 03802748
	and r1,r3	; 0380274A
	add r2,#0x12	; 0380274C
	mov r3,#0x3f	; 0380274E
	and r2,r3	; 03802750
	lsl r2,r2,#0x8	; 03802752
	orr r1,r2	; 03802754
	str r1,[r0,#0x0]	; 03802756
	bx lr	; 03802758
loc_0380275A:
	lsl r3,r1,#0x11	; 0380275A
	lsr r3,r3,#0x1f	; 0380275C
	cmp r3,#0x0	; 0380275E
	beq loc_0380278C	; 03802760
	ldr r3,[pool_03802790]	; 03802762
	and r1,r3	; 03802764
	add r2,#0x18	; 03802766
	mov r3,#0x3f	; 03802768
	and r2,r3	; 0380276A
	lsl r2,r2,#0x8	; 0380276C
	orr r1,r2	; 0380276E
	str r1,[r0,#0x0]	; 03802770
	bx lr	; 03802772
loc_03802774:
	ldr r2,[pool_03802794]	; 03802774
	orr r1,r2	; 03802776
	str r1,[r0,#0x0]	; 03802778
	bx lr	; 0380277A
loc_0380277C:
	ldr r2,[r0,#0x0]	; 0380277C
	ldr r1,[pool_03802798]	; 0380277E
	and r2,r1	; 03802780
	str r2,[r0,#0x0]	; 03802782
	ldr r2,[r0,#0x0]	; 03802784
	ldr r1,[pool_03802790]	; 03802786
	and r2,r1	; 03802788
	str r2,[r0,#0x0]	; 0380278A
loc_0380278C:
	bx lr	; 0380278C
	.byte 0xC0, 0x46	; 03802790
pool_03802790:
loc_03802790:
	.word 0xFFFFC0FF	; 03802790
pool_03802794:
loc_03802794:
	.word 0x00004000	; 03802794
pool_03802798:
loc_03802798:
	.word 0xFFFFBFFF	; 03802798

; ===== function loc_0380279C =====
loc_0380279C:
	ldr r1,[r0,#0x0]	; 0380279C
	lsl r2,r1,#0x12	; 0380279E
	lsr r2,r2,#0x1a	; 038027A0
	cmp r2,#0x23	; 038027A2
	bhi loc_03802844	; 038027A4
	add r2,r2,r2	; 038027A6
P2_SwitchIndexPC_038027A6:
	add r2,pc	; 038027A8
	ldrh r2,[r2,#(P2_SwitchTable_038027A6 - (P2_SwitchIndexPC_038027A6 + 4))]	; 038027AA
	lsl r2,r2,#0x10	; 038027AC
	asr r2,r2,#0x10	; 038027AE
P2_SwitchTargetPC_038027A6:
	add r2,pc	; 038027B0
	bx r2	; 038027B2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038027A6:
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_038027FC + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802844 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802824 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802824 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
	.halfword (loc_03802804 + 1) - (P2_SwitchTargetPC_038027A6 + 4)
P2_SwitchTable_038027A6End:
loc_038027FC:
	ldr r2,[pool_03802858]	; 038027FC
	and r1,r2	; 038027FE
	str r1,[r0,#0x0]	; 03802800
	bx lr	; 03802802
loc_03802804:
	ldr r2,[pool_0380285C]	; 03802804
	orr r1,r2	; 03802806
	str r1,[r0,#0x0]	; 03802808
	ldr r2,[r0,#0x0]	; 0380280A
	ldr r1,[pool_03802860]	; 0380280C
	add r3,r2,#0x0	; 0380280E
	and r3,r1	; 03802810
	lsl r1,r2,#0x12	; 03802812
	lsr r2,r1,#0x1a	; 03802814
	sub r2,#0x12	; 03802816
	mov r1,#0x3f	; 03802818
	and r2,r1	; 0380281A
	lsl r1,r2,#0x8	; 0380281C
	orr r3,r1	; 0380281E
	str r3,[r0,#0x0]	; 03802820
	bx lr	; 03802822
loc_03802824:
	ldr r2,[pool_0380285C]	; 03802824
	orr r1,r2	; 03802826
	str r1,[r0,#0x0]	; 03802828
	ldr r2,[r0,#0x0]	; 0380282A
	ldr r1,[pool_03802860]	; 0380282C
	add r3,r2,#0x0	; 0380282E
	and r3,r1	; 03802830
	lsl r1,r2,#0x12	; 03802832
	lsr r2,r1,#0x1a	; 03802834
	sub r2,#0x18	; 03802836
	mov r1,#0x3f	; 03802838
	and r2,r1	; 0380283A
	lsl r1,r2,#0x8	; 0380283C
	orr r3,r1	; 0380283E
	str r3,[r0,#0x0]	; 03802840
	bx lr	; 03802842
loc_03802844:
	ldr r2,[r0,#0x0]	; 03802844
	ldr r1,[pool_03802858]	; 03802846
	and r2,r1	; 03802848
	str r2,[r0,#0x0]	; 0380284A
	ldr r2,[r0,#0x0]	; 0380284C
	ldr r1,[pool_03802860]	; 0380284E
	and r2,r1	; 03802850
	str r2,[r0,#0x0]	; 03802852
	bx lr	; 03802854
	.byte 0xC0, 0x46	; 03802858
pool_03802858:
loc_03802858:
	.word 0xFFFFBFFF	; 03802858
pool_0380285C:
loc_0380285C:
	.word 0x00004000	; 0380285C
pool_03802860:
loc_03802860:
	.word 0xFFFFC0FF	; 03802860

; ===== function loc_03802864 =====
loc_03802864:
	push {r4,lr}	; 03802864
	add r4,r0,#0x0	; 03802866
	ldr r0,[pool_03802880]	; 03802868
	bl loc_03802198	; 0380286A
	mov r0,#0x6	; 0380286E
	mov r1,#0x70	; 03802870
	add r2,r4,#0x0	; 03802872
	mov r3,#0x1	; 03802874
	bl loc_03802664	; 03802876
	pop {r4}	; 0380287A
	pop {r3}	; 0380287C
	bx r3	; 0380287E
pool_03802880:
loc_03802880:
	.word 0x00008000	; 03802880

; ===== function loc_03802884 =====
loc_03802884:
	push {r4,lr}	; 03802884
	add r4,r0,#0x0	; 03802886
	ldr r0,[pool_038028A0]	; 03802888
	bl loc_03802198	; 0380288A
	mov r0,#0x86	; 0380288E
	mov r1,#0x70	; 03802890
	add r2,r4,#0x0	; 03802892
	mov r3,#0x1	; 03802894
	bl loc_03802664	; 03802896
	pop {r4}	; 0380289A
	pop {r3}	; 0380289C
	bx r3	; 0380289E
pool_038028A0:
loc_038028A0:
	.word 0x00008000	; 038028A0

; ===== function loc_038028A4 =====
loc_038028A4:
	push {r4,lr}	; 038028A4
	add r4,r0,#0x0	; 038028A6
	ldr r0,[pool_038028C0]	; 038028A8
	bl loc_03802198	; 038028AA
	mov r0,#0x6	; 038028AE
	mov r1,#0x30	; 038028B0
	add r2,r4,#0x0	; 038028B2
	mov r3,#0x1	; 038028B4
	bl loc_03802664	; 038028B6
	pop {r4}	; 038028BA
	pop {r3}	; 038028BC
	bx r3	; 038028BE
pool_038028C0:
loc_038028C0:
	.word 0x00008000	; 038028C0

; ===== function loc_038028C4 =====
loc_038028C4:
	push {r4,lr}	; 038028C4
	add r4,r0,#0x0	; 038028C6
	ldr r0,[pool_038028E0]	; 038028C8
	bl loc_03802198	; 038028CA
	mov r0,#0x86	; 038028CE
	mov r1,#0x30	; 038028D0
	add r2,r4,#0x0	; 038028D2
	mov r3,#0x1	; 038028D4
	bl loc_03802664	; 038028D6
	pop {r4}	; 038028DA
	pop {r3}	; 038028DC
	bx r3	; 038028DE
pool_038028E0:
loc_038028E0:
	.word 0x00008000	; 038028E0

; ===== function loc_038028E4 =====
loc_038028E4:
	push {r4,lr}	; 038028E4
	add r4,r0,#0x0	; 038028E6
	ldr r0,[pool_03802900]	; 038028E8
	bl loc_03802198	; 038028EA
	mov r0,#0x6	; 038028EE
	mov r1,#0x40	; 038028F0
	add r2,r4,#0x0	; 038028F2
	mov r3,#0x1	; 038028F4
	bl loc_03802664	; 038028F6
	pop {r4}	; 038028FA
	pop {r3}	; 038028FC
	bx r3	; 038028FE
pool_03802900:
loc_03802900:
	.word 0x00008000	; 03802900

; ===== function loc_03802904 =====
loc_03802904:
	push {r4,lr}	; 03802904
	add r4,r0,#0x0	; 03802906
	ldr r0,[pool_03802920]	; 03802908
	bl loc_03802198	; 0380290A
	mov r0,#0x86	; 0380290E
	mov r1,#0x40	; 03802910
	add r2,r4,#0x0	; 03802912
	mov r3,#0x1	; 03802914
	bl loc_03802664	; 03802916
	pop {r4}	; 0380291A
	pop {r3}	; 0380291C
	bx r3	; 0380291E
pool_03802920:
loc_03802920:
	.word 0x00008000	; 03802920

; ===== function loc_03802924 =====
loc_03802924:
	push {r4,lr}	; 03802924
	add r4,r0,#0x0	; 03802926
	ldr r0,[pool_03802940]	; 03802928
	bl loc_03802198	; 0380292A
	mov r0,#0x6	; 0380292E
	mov r1,#0x0	; 03802930
	add r2,r4,#0x0	; 03802932
	mov r3,#0x1	; 03802934
	bl loc_03802664	; 03802936
	pop {r4}	; 0380293A
	pop {r3}	; 0380293C
	bx r3	; 0380293E
pool_03802940:
loc_03802940:
	.word 0x00008000	; 03802940

; ===== function loc_03802944 =====
loc_03802944:
	push {r4,lr}	; 03802944
	add r4,r0,#0x0	; 03802946
	ldr r0,[pool_03802960]	; 03802948
	bl loc_03802198	; 0380294A
	mov r0,#0x86	; 0380294E
	mov r1,#0x0	; 03802950
	add r2,r4,#0x0	; 03802952
	mov r3,#0x1	; 03802954
	bl loc_03802664	; 03802956
	pop {r4}	; 0380295A
	pop {r3}	; 0380295C
	bx r3	; 0380295E
pool_03802960:
loc_03802960:
	.word 0x00008000	; 03802960

; ===== function loc_03802964 =====
loc_03802964:
	push {r4,lr}	; 03802964
	sub sp,#0x8	; 03802966
	add r4,r0,#0x0	; 03802968
	add r0,sp,#0x0	; 0380296A
	bl loc_03802904	; 0380296C
	add r0,sp,#0x0	; 03802970
	ldrh r0,[r0,#0x0]	; 03802972
	lsl r0,r0,#0x19	; 03802974
	lsr r0,r0,#0x1f	; 03802976
	cmp r0,#0x0	; 03802978
	beq loc_0380298C	; 0380297A
	mov r0,#0x6	; 0380297C
	mov r1,#0x50	; 0380297E
	add r2,r4,#0x0	; 03802980
	mov r3,#0x3	; 03802982
	bl loc_03802664	; 03802984
	mov r0,#0x1	; 03802988
	b loc_0380298E	; 0380298A
loc_0380298C:
	mov r0,#0x0	; 0380298C
loc_0380298E:
	add sp,#0x8	; 0380298E
	pop {r4}	; 03802990
	pop {r3}	; 03802992
	bx r3	; 03802994
	.byte 0x00, 0x00	; 03802998

; ===== function loc_03802998 =====
loc_03802998:
	push {r4,lr}	; 03802998
	sub sp,#0x8	; 0380299A
	add r4,r0,#0x0	; 0380299C
	add r0,sp,#0x0	; 0380299E
	bl loc_03802904	; 038029A0
	add r0,sp,#0x0	; 038029A4
	ldrh r0,[r0,#0x0]	; 038029A6
	lsl r0,r0,#0x19	; 038029A8
	lsr r0,r0,#0x1f	; 038029AA
	cmp r0,#0x0	; 038029AC
	beq loc_038029C0	; 038029AE
	mov r0,#0x86	; 038029B0
	mov r1,#0x50	; 038029B2
	add r2,r4,#0x0	; 038029B4
	mov r3,#0x3	; 038029B6
	bl loc_03802664	; 038029B8
	mov r0,#0x1	; 038029BC
	b loc_038029C2	; 038029BE
loc_038029C0:
	mov r0,#0x0	; 038029C0
loc_038029C2:
	add sp,#0x8	; 038029C2
	pop {r4}	; 038029C4
	pop {r3}	; 038029C6
	bx r3	; 038029C8
	.byte 0x00, 0x00	; 038029CC

; ===== function loc_038029CC =====
loc_038029CC:
	push {r4,lr}	; 038029CC
	sub sp,#0x8	; 038029CE
	add r4,r0,#0x0	; 038029D0
	add r0,sp,#0x0	; 038029D2
	bl loc_03802904	; 038029D4
	add r0,sp,#0x0	; 038029D8
	ldrh r0,[r0,#0x0]	; 038029DA
	lsl r0,r0,#0x1c	; 038029DC
	lsr r0,r0,#0x1c	; 038029DE
	cmp r0,#0x4	; 038029E0
	bne loc_038029F4	; 038029E2
	mov r0,#0x6	; 038029E4
	mov r1,#0x10	; 038029E6
	add r2,r4,#0x0	; 038029E8
	mov r3,#0x3	; 038029EA
	bl loc_03802664	; 038029EC
	mov r0,#0x1	; 038029F0
	b loc_038029F6	; 038029F2
loc_038029F4:
	mov r0,#0x0	; 038029F4
loc_038029F6:
	add sp,#0x8	; 038029F6
	pop {r4}	; 038029F8
	pop {r3}	; 038029FA
	bx r3	; 038029FC
	.byte 0x00, 0x00	; 03802A00

; ===== function loc_03802A00 =====
loc_03802A00:
	push {r4,lr}	; 03802A00
	sub sp,#0x8	; 03802A02
	add r4,r0,#0x0	; 03802A04
	add r0,sp,#0x0	; 03802A06
	bl loc_03802904	; 03802A08
	add r0,sp,#0x0	; 03802A0C
	ldrh r0,[r0,#0x0]	; 03802A0E
	lsl r0,r0,#0x1c	; 03802A10
	lsr r0,r0,#0x1c	; 03802A12
	cmp r0,#0x4	; 03802A14
	bne loc_03802A28	; 03802A16
	mov r0,#0x86	; 03802A18
	mov r1,#0x10	; 03802A1A
	add r2,r4,#0x0	; 03802A1C
	mov r3,#0x3	; 03802A1E
	bl loc_03802664	; 03802A20
	mov r0,#0x1	; 03802A24
	b loc_03802A2A	; 03802A26
loc_03802A28:
	mov r0,#0x0	; 03802A28
loc_03802A2A:
	add sp,#0x8	; 03802A2A
	pop {r4}	; 03802A2C
	pop {r3}	; 03802A2E
	bx r3	; 03802A30
	.byte 0x00, 0x00	; 03802A34

; ===== function loc_03802A34 =====
loc_03802A34:
	push {r4,lr}	; 03802A34
	add r4,r0,#0x0	; 03802A36
	ldr r0,[pool_03802A50]	; 03802A38
	bl loc_03802198	; 03802A3A
	mov r0,#0x6	; 03802A3E
	mov r1,#0x20	; 03802A40
	add r2,r4,#0x0	; 03802A42
	mov r3,#0x7	; 03802A44
	bl loc_03802664	; 03802A46
	pop {r4}	; 03802A4A
	pop {r3}	; 03802A4C
	bx r3	; 03802A4E
pool_03802A50:
loc_03802A50:
	.word 0x00008000	; 03802A50

; ===== function loc_03802A54 =====
loc_03802A54:
	push {r4,lr}	; 03802A54
	add r4,r0,#0x0	; 03802A56
	ldr r0,[pool_03802A70]	; 03802A58
	bl loc_03802198	; 03802A5A
	mov r0,#0x86	; 03802A5E
	mov r1,#0x20	; 03802A60
	add r2,r4,#0x0	; 03802A62
	mov r3,#0x7	; 03802A64
	bl loc_03802664	; 03802A66
	pop {r4}	; 03802A6A
	pop {r3}	; 03802A6C
	bx r3	; 03802A6E
pool_03802A70:
loc_03802A70:
	.word 0x00008000	; 03802A70

; ===== function loc_03802A74 =====
loc_03802A74:
	push {r4,r5,lr}	; 03802A74
	sub sp,#0xc	; 03802A76
	add r5,r0,#0x0	; 03802A78
	mov r0,#0x1	; 03802A7A
	add r4,r5,#0x0	; 03802A7C
	and r4,r0	; 03802A7E
	lsl r0,r4,#0x10	; 03802A80
	lsr r0,r0,#0x10	; 03802A82
	cmp r0,#0x1	; 03802A84
	bne loc_03802B14	; 03802A86
	add r0,sp,#0x0	; 03802A88
	bl loc_03802944	; 03802A8A
	add r0,sp,#0x0	; 03802A8E
	ldrh r1,[r0,#0x0]	; 03802A90
	lsl r2,r1,#0x1e	; 03802A92
	lsr r3,r2,#0x1f	; 03802A94
	lsl r2,r4,#0x10	; 03802A96
	lsr r2,r2,#0x10	; 03802A98
	cmp r3,r2	; 03802A9A
	beq loc_03802B14	; 03802A9C
	mov r3,#0x1	; 03802A9E
	and r5,r3	; 03802AA0
	mov r2,#0x2	; 03802AA2
	bic r1,r2	; 03802AA4
	lsl r2,r5,#0x10	; 03802AA6
	lsr r2,r2,#0x10	; 03802AA8
	and r2,r3	; 03802AAA
	lsl r2,r2,#0x1	; 03802AAC
	orr r1,r2	; 03802AAE
	strh r1,[r0,#0x0]	; 03802AB0
	add r0,sp,#0x0	; 03802AB2
	bl loc_03802924	; 03802AB4
	mov r0,#0x86	; 03802AB8
	mov r1,#0x10	; 03802ABA
	add r2,sp,#0x4	; 03802ABC
	mov r3,#0x3	; 03802ABE
	bl loc_03802664	; 03802AC0
	lsl r0,r5,#0x10	; 03802AC4
	lsr r0,r0,#0x10	; 03802AC6
	cmp r0,#0x0	; 03802AC8
	bne loc_03802AD4	; 03802ACA
	add r0,sp,#0x4	; 03802ACC
	bl loc_0380279C	; 03802ACE
	b loc_03802ADA	; 03802AD2
loc_03802AD4:
	add r0,sp,#0x4	; 03802AD4
	bl loc_038026E0	; 03802AD6
loc_03802ADA:
	mov r0,#0x6	; 03802ADA
	mov r1,#0x10	; 03802ADC
	add r2,sp,#0x4	; 03802ADE
	mov r3,#0x3	; 03802AE0
	bl loc_03802664	; 03802AE2
	mov r0,#0x86	; 03802AE6
	mov r1,#0x50	; 03802AE8
	add r2,sp,#0x4	; 03802AEA
	mov r3,#0x3	; 03802AEC
	bl loc_03802664	; 03802AEE
	lsl r0,r4,#0x10	; 03802AF2
	lsr r0,r0,#0x10	; 03802AF4
	cmp r0,#0x0	; 03802AF6
	bne loc_03802B02	; 03802AF8
	add r0,sp,#0x4	; 03802AFA
	bl loc_0380279C	; 03802AFC
	b loc_03802B08	; 03802B00
loc_03802B02:
	add r0,sp,#0x4	; 03802B02
	bl loc_038026E0	; 03802B04
loc_03802B08:
	mov r0,#0x6	; 03802B08
	mov r1,#0x50	; 03802B0A
	add r2,sp,#0x4	; 03802B0C
	mov r3,#0x3	; 03802B0E
	bl loc_03802664	; 03802B10
loc_03802B14:
	add sp,#0xc	; 03802B14
	pop {r4,r5}	; 03802B16
	pop {r3}	; 03802B18
	bx r3	; 03802B1A

; ===== function loc_03802B1C =====
loc_03802B1C:
	push {lr}	; 03802B1C
	sub sp,#0x4	; 03802B1E
	ldr r0,[pool_03802B44]	; 03802B20
	bl loc_03802198	; 03802B22
	add r0,sp,#0x0	; 03802B26
	ldrh r1,[r0,#0x0]	; 03802B28
	mov r3,#0x1	; 03802B2A
	bic r1,r3	; 03802B2C
	orr r1,r3	; 03802B2E
	strh r1,[r0,#0x0]	; 03802B30
	mov r0,#0x6	; 03802B32
	mov r1,#0x0	; 03802B34
	add r2,sp,#0x0	; 03802B36
	bl loc_03802664	; 03802B38
	add sp,#0x4	; 03802B3C
	pop {r3}	; 03802B3E
	bx r3	; 03802B40
	.byte 0xC0, 0x46	; 03802B44
pool_03802B44:
loc_03802B44:
	.word 0x00008000	; 03802B44
.arm

; ===== function loc_03802B48 =====
loc_03802B48:
	mov r12,#0x4000000	; 03802B48
	add r12,r12,#0x138	; 03802B4C
	ldrh r0,[r12,#0x0]	; 03802B50
	bic r0,r0,#0x77	; 03802B54
	orr r0,r0,#0x72	; 03802B58
	strh r0,[r12,#0x0]	; 03802B5C
	mov r3,#0x2	; 03802B60
loc_03802B64:
	subs r3,r3,#0x1	; 03802B64
	bne loc_03802B64	; 03802B68
	bic r0,r0,#0x4	; 03802B6C
	orr r0,r0,#0x4	; 03802B70
	strh r0,[r12,#0x0]	; 03802B74
	mov r3,#0x2	; 03802B78
loc_03802B7C:
	subs r3,r3,#0x1	; 03802B7C
	bne loc_03802B7C	; 03802B80
	bx lr	; 03802B84

; ===== function loc_03802B88 =====
loc_03802B88:
	mov r12,#0x4000000	; 03802B88
	add r12,r12,#0x138	; 03802B8C
	mov r3,#0x2	; 03802B90
loc_03802B94:
	subs r3,r3,#0x1	; 03802B94
	bne loc_03802B94	; 03802B98
	ldrh r0,[r12,#0x0]	; 03802B9C
	bic r0,r0,#0x4	; 03802BA0
	orr r0,r0,#0x0	; 03802BA4
	strh r0,[r12,#0x0]	; 03802BA8
	mov r3,#0x2	; 03802BAC
loc_03802BB0:
	subs r3,r3,#0x1	; 03802BB0
	bne loc_03802BB0	; 03802BB4
	bx lr	; 03802BB8

; ===== function loc_03802BBC =====
loc_03802BBC:
	mov r12,#0x4000000	; 03802BBC
	add r12,r12,#0x138	; 03802BC0
	orr r1,r0,r1	; 03802BC4
	ldrh r0,[r12,#0x0]	; 03802BC8
	bic r0,r0,#0x77	; 03802BCC
	orr r0,r0,#0x74	; 03802BD0
	mov r2,#0x0	; 03802BD4
loc_03802BD8:
	bic r0,r0,#0x3	; 03802BD8
	orr r0,r0,#0x0	; 03802BDC
	mov r3,#0x1	; 03802BE0
	tst r3,r1, lsr r2	; 03802BE4
	movne r3,#0x1	; 03802BE8
	moveq r3,#0x0	; 03802BEC
	orr r0,r0,r3	; 03802BF0
	strh r0,[r12,#0x0]	; 03802BF4
	mov r3,#0x9	; 03802BF8
loc_03802BFC:
	subs r3,r3,#0x1	; 03802BFC
	bne loc_03802BFC	; 03802C00
	bic r0,r0,#0x2	; 03802C04
	orr r0,r0,#0x2	; 03802C08
	strh r0,[r12,#0x0]	; 03802C0C
	mov r3,#0x9	; 03802C10
loc_03802C14:
	subs r3,r3,#0x1	; 03802C14
	bne loc_03802C14	; 03802C18
	add r2,r2,#0x1	; 03802C1C
	cmp r2,#0x8	; 03802C20
	bne loc_03802BD8	; 03802C24
	bx lr	; 03802C28

; ===== function loc_03802C2C =====
loc_03802C2C:
	mov r12,#0x4000000	; 03802C2C
	add r12,r12,#0x138	; 03802C30
loc_03802C34:
	stmdb sp!,{r0,r1}	; 03802C34
	tst r0,#0x1	; 03802C38
	ldreqh r1,[r0,#0x0]	; 03802C3C
	ldrneh r1,[r0,#-0x1]	; 03802C40
	movne r1,r1, lsr #0x8	; 03802C44
	ldrh r0,[r12,#0x0]	; 03802C48
	bic r0,r0,#0x77	; 03802C4C
	orr r0,r0,#0x74	; 03802C50
	mov r2,#0x0	; 03802C54
loc_03802C58:
	bic r0,r0,#0x3	; 03802C58
	orr r0,r0,#0x0	; 03802C5C
	mov r3,#0x1	; 03802C60
	tst r3,r1, lsr r2	; 03802C64
	movne r3,#0x1	; 03802C68
	moveq r3,#0x0	; 03802C6C
	orr r0,r0,r3	; 03802C70
	strh r0,[r12,#0x0]	; 03802C74
	mov r3,#0x9	; 03802C78
loc_03802C7C:
	subs r3,r3,#0x1	; 03802C7C
	bne loc_03802C7C	; 03802C80
	bic r0,r0,#0x2	; 03802C84
	orr r0,r0,#0x2	; 03802C88
	strh r0,[r12,#0x0]	; 03802C8C
	mov r3,#0x9	; 03802C90
loc_03802C94:
	subs r3,r3,#0x1	; 03802C94
	bne loc_03802C94	; 03802C98
	add r2,r2,#0x1	; 03802C9C
	cmp r2,#0x8	; 03802CA0
	bne loc_03802C58	; 03802CA4
	ldmia sp!,{r0,r1}	; 03802CA8
	add r0,r0,#0x1	; 03802CAC
	subs r1,r1,#0x1	; 03802CB0
	bne loc_03802C34	; 03802CB4
	bx lr	; 03802CB8

; ===== function loc_03802CBC =====
loc_03802CBC:
	mov r12,#0x4000000	; 03802CBC
	add r12,r12,#0x138	; 03802CC0
loc_03802CC4:
	stmdb sp!,{r0,r1}	; 03802CC4
	ldrh r0,[r12,#0x0]	; 03802CC8
	bic r0,r0,#0x77	; 03802CCC
	orr r0,r0,#0x64	; 03802CD0
	mov r2,#0x0	; 03802CD4
	mov r1,#0x0	; 03802CD8
loc_03802CDC:
	bic r0,r0,#0x3	; 03802CDC
	orr r0,r0,#0x0	; 03802CE0
	strh r0,[r12,#0x0]	; 03802CE4
	mov r3,#0x9	; 03802CE8
loc_03802CEC:
	subs r3,r3,#0x1	; 03802CEC
	bne loc_03802CEC	; 03802CF0
	ldrh r0,[r12,#0x0]	; 03802CF4
	and r3,r0,#0x1	; 03802CF8
	cmp r3,#0x1	; 03802CFC
	moveq r3,#0x80	; 03802D00
	movne r3,#0x0	; 03802D04
	orr r2,r3,r2, lsr #0x1	; 03802D08
	bic r0,r0,#0x2	; 03802D0C
	orr r0,r0,#0x2	; 03802D10
	strh r0,[r12,#0x0]	; 03802D14
	mov r3,#0x9	; 03802D18
loc_03802D1C:
	subs r3,r3,#0x1	; 03802D1C
	bne loc_03802D1C	; 03802D20
	add r1,r1,#0x1	; 03802D24
	cmp r1,#0x8	; 03802D28
	bne loc_03802CDC	; 03802D2C
	ldmia sp!,{r0,r1}	; 03802D30
	tst r0,#0x1	; 03802D34
	beq loc_03802D54	; 03802D38
	ldrh r3,[r0,#-0x1]	; 03802D3C
	bic r3,r3,#0xff00	; 03802D40
	mov r2,r2, lsl #0x8	; 03802D44
	orr r3,r2,r3	; 03802D48
	strh r3,[r0,#-0x1]	; 03802D4C
	b loc_03802D64	; 03802D50
loc_03802D54:
	ldrh r3,[r0,#0x0]	; 03802D54
	bic r3,r3,#0xff	; 03802D58
	orr r3,r3,r2	; 03802D5C
	strh r3,[r0,#0x0]	; 03802D60
loc_03802D64:
	add r0,r0,#0x1	; 03802D64
	subs r1,r1,#0x1	; 03802D68
	bne loc_03802CC4	; 03802D6C
	bx lr	; 03802D70
.thumb

; ===== function loc_03802D74 =====
P2_PxiCallback_03802D74:
	push {lr}	; 03802D74
	sub sp,#0x4	; 03802D76
	cmp r2,#0x0	; 03802D78
	bne loc_03802DA0	; 03802D7A
	cmp r0,#0x4	; 03802D7C
	beq loc_03802D9A	; 03802D7E
	cmp r0,#0x6	; 03802D80
	beq loc_03802D8A	; 03802D82
	cmp r0,#0x8	; 03802D84
	beq loc_03802D92	; 03802D86
	b loc_03802DA0	; 03802D88
loc_03802D8A:
	add r0,r1,#0x0	; 03802D8A
	bl loc_03803290	; 03802D8C
	b loc_03802DA0	; 03802D90
loc_03802D92:
	add r0,r1,#0x0	; 03802D92
	bl loc_038042AC	; 03802D94
	b loc_03802DA0	; 03802D98
loc_03802D9A:
	add r0,r1,#0x0	; 03802D9A
	bl loc_03803B34	; 03802D9C
loc_03802DA0:
	add sp,#0x4	; 03802DA0
	pop {r3}	; 03802DA2
	bx r3	; 03802DA4
	.byte 0x00, 0x00	; 03802DA6
P2_ThreadEntry_03802DA8:
	push {r4,r5,r6,lr}	; 03802DA8
	sub sp,#0x8	; 03802DAA
	ldr r5,[pool_03802DE0]	; 03802DAC
	add r4,sp,#0x0	; 03802DAE
	mov r6,#0x1	; 03802DB0
P2_Entry_03802DB2:
	add r0,r5,#0x0	; 03802DB2
	add r1,r4,#0x0	; 03802DB4
	add r2,r6,#0x0	; 03802DB6
	bl loc_037FE2DC	; 03802DB8
	ldr r0,[sp,#0x0]	; 03802DBC
	ldr r1,[r0,#0x0]	; 03802DBE
	cmp r1,#0x0	; 03802DC0
	beq P2_Entry_03802DCE	; 03802DC2
	cmp r1,#0x1	; 03802DC4
	beq P2_Entry_03802DDA	; 03802DC6
	cmp r1,#0x3	; 03802DC8
	beq P2_Entry_03802DD4	; 03802DCA
	b P2_Entry_03802DB2	; 03802DCC
P2_Entry_03802DCE:
	bl P2_Entry_03803124	; 03802DCE
	b P2_Entry_03802DB2	; 03802DD2
P2_Entry_03802DD4:
	bl P2_Entry_038041B0	; 03802DD4
	b P2_Entry_03802DB2	; 03802DD8
P2_Entry_03802DDA:
	bl P2_Entry_038039E0	; 03802DDA
	b P2_Entry_03802DB2	; 03802DDE
pool_03802DE0:
	.word 0x038077A0	; 03802DE0

; ===== function loc_03802DE4 =====
loc_03802DE4:
	push {r0,r1,r2,r3}	; 03802DE4
	push {r4,r5,r6,r7,lr}	; 03802DE6
	sub sp,#0x4	; 03802DE8
	add r5,r0,#0x0	; 03802DEA
	add r4,r1,#0x0	; 03802DEC
	add r0,sp,#0x18	; 03802DEE
	ldrh r0,[r0,#0x8]	; 03802DF0
	cmp r0,#0x4	; 03802DF2
	bls loc_03802DFA	; 03802DF4
	mov r0,#0x0	; 03802DF6
	b loc_03802E6A	; 03802DF8
loc_03802DFA:
	bl loc_037FDD34	; 03802DFA
	add r7,r0,#0x0	; 03802DFE
	ldr r0,[pool_03802E74]	; 03802E00
	ldr r1,[r0,#0x54]	; 03802E02
	mov r0,#0x18	; 03802E04
	mul r1,r0	; 03802E06
	ldr r0,[pool_03802E78]	; 03802E08
	str r5,[r0,r1]	; 03802E0A
	ldr r0,[pool_03802E74]	; 03802E0C
	ldr r1,[r0,#0x54]	; 03802E0E
	mov r0,#0x18	; 03802E10
	mul r1,r0	; 03802E12
	ldr r0,[pool_03802E7C]	; 03802E14
	str r4,[r0,r1]	; 03802E16
	add r1,sp,#0x20	; 03802E18
	mov r0,#0x3	; 03802E1A
	bic r1,r0	; 03802E1C
	add r6,r1,#0x4	; 03802E1E
	mov r5,#0x0	; 03802E20
	add r0,sp,#0x18	; 03802E22
	ldrh r4,[r0,#0x8]	; 03802E24
	b loc_03802E44	; 03802E26
loc_03802E28:
	add r6,r6,#0x4	; 03802E28
	sub r0,r6,#0x4	; 03802E2A
	ldr r3,[r0,#0x0]	; 03802E2C
	ldr r0,[pool_03802E74]	; 03802E2E
	ldr r2,[r0,#0x54]	; 03802E30
	mov r0,#0x18	; 03802E32
	mul r2,r0	; 03802E34
	lsl r1,r5,#0x2	; 03802E36
	ldr r0,[pool_03802E80]	; 03802E38
	add r0,r0,r2	; 03802E3A
	add r1,r1,r0	; 03802E3C
	ldr r0,[pool_03802E84]	; 03802E3E
	str r3,[r1,r0]	; 03802E40
	add r5,r5,#0x1	; 03802E42
loc_03802E44:
	cmp r5,r4	; 03802E44
	blt loc_03802E28	; 03802E46
	ldr r1,[pool_03802E74]	; 03802E48
	ldr r4,[r1,#0x54]	; 03802E4A
	add r2,r4,#0x1	; 03802E4C
	mov r0,#0xf	; 03802E4E
	and r2,r0	; 03802E50
	str r2,[r1,#0x54]	; 03802E52
	add r0,r7,#0x0	; 03802E54
	bl loc_037FDD58	; 03802E56
	ldr r0,[pool_03802E88]	; 03802E5A
	ldr r2,[pool_03802E78]	; 03802E5C
	mov r1,#0x18	; 03802E5E
	mul r4,r1	; 03802E60
	add r1,r2,r4	; 03802E62
	mov r2,#0x0	; 03802E64
	bl loc_037FE354	; 03802E66
loc_03802E6A:
	add sp,#0x4	; 03802E6A
	pop {r4,r5,r6,r7}	; 03802E6C
	pop {r3}	; 03802E6E
	add sp,#0x10	; 03802E70
	bx r3	; 03802E72
pool_03802E74:
loc_03802E74:
	.word P2_BssStart + 0x2540	; 03802E74
pool_03802E78:
loc_03802E78:
	.word P2_BssStart + 0x2414	; 03802E78
pool_03802E7C:
loc_03802E7C:
	.word P2_BssStart + 0x2418	; 03802E7C
pool_03802E80:
loc_03802E80:
	.word 0x03807520	; 03802E80
pool_03802E84:
loc_03802E84:
	.word 0x000002DC	; 03802E84
pool_03802E88:
loc_03802E88:
	.word 0x038077A0	; 03802E88

; ===== function loc_03802E8C =====
P2_Entry_03802E8C:
	push {lr}	; 03802E8C
	sub sp,#0x4	; 03802E8E
	ldr r1,[pool_03802EAC]	; 03802E90
	ldr r2,[r1,#0x4]	; 03802E92
	cmp r2,r0	; 03802E94
	bne loc_03802EA6	; 03802E96
	mov r0,#0x5	; 03802E98
	str r0,[r1,#0x4]	; 03802E9A
	mov r0,#0x0	; 03802E9C
	str r0,[r1,#0x0]	; 03802E9E
	ldr r0,[pool_03802EB0]	; 03802EA0
	bl loc_037FDF58	; 03802EA2
loc_03802EA6:
	add sp,#0x4	; 03802EA6
	pop {r3}	; 03802EA8
	bx r3	; 03802EAA
pool_03802EAC:
loc_03802EAC:
	.word P2_BssStart + 0x2140	; 03802EAC
pool_03802EB0:
loc_03802EB0:
	.word 0x03807978	; 03802EB0

; ===== function loc_03802EB4 =====
loc_03802EB4:
	mov r2,#0x1	; 03802EB4
	ldr r1,[pool_03802EC0]	; 03802EB6
	str r2,[r1,#0x0]	; 03802EB8
	str r0,[r1,#0x4]	; 03802EBA
	bx lr	; 03802EBC
	.byte 0xC0, 0x46	; 03802EC0
pool_03802EC0:
loc_03802EC0:
	.word P2_BssStart + 0x2140	; 03802EC0
P2_Entry_03802EC4:
	ldr r0,[pool_03802ED4]	; 03802EC4
	ldr r0,[r0,#0x0]	; 03802EC6
	cmp r0,#0x0	; 03802EC8
	bne P2_Entry_03802ED0	; 03802ECA
	mov r0,#0x1	; 03802ECC
	bx lr	; 03802ECE
P2_Entry_03802ED0:
	mov r0,#0x0	; 03802ED0
	bx lr	; 03802ED2
pool_03802ED4:
	.word P2_BssStart + 0x2140	; 03802ED4

; ===== function loc_03802ED8 =====
loc_03802ED8:
	push {r4,r5,r6,lr}	; 03802ED8
	mov r2,#0x70	; 03802EDA
	add r3,r0,#0x0	; 03802EDC
	and r3,r2	; 03802EDE
	cmp r3,#0x20	; 03802EE0
	bgt loc_03802EF8	; 03802EE2
	cmp r3,#0x20	; 03802EE4
	bge loc_03802F14	; 03802EE6
	cmp r3,#0x0	; 03802EE8
	bgt loc_03802EF2	; 03802EEA
	cmp r3,#0x0	; 03802EEC
	beq loc_03802F0C	; 03802EEE
	b loc_03802F16	; 03802EF0
loc_03802EF2:
	cmp r3,#0x10	; 03802EF2
	beq loc_03802F0C	; 03802EF4
	b loc_03802F16	; 03802EF6
loc_03802EF8:
	cmp r3,#0x60	; 03802EF8
	bgt loc_03802F06	; 03802EFA
	cmp r3,#0x60	; 03802EFC
	bge loc_03802F10	; 03802EFE
	cmp r3,#0x30	; 03802F00
	beq loc_03802F14	; 03802F02
	b loc_03802F16	; 03802F04
loc_03802F06:
	cmp r3,#0x70	; 03802F06
	beq loc_03802F10	; 03802F08
	b loc_03802F16	; 03802F0A
loc_03802F0C:
	mov r5,#0x6	; 03802F0C
	b loc_03802F16	; 03802F0E
loc_03802F10:
	mov r5,#0x8	; 03802F10
	b loc_03802F16	; 03802F12
loc_03802F14:
	mov r5,#0x4	; 03802F14
loc_03802F16:
	mov r3,#0xff	; 03802F16
	and r0,r3	; 03802F18
	mov r2,#0x80	; 03802F1A
	orr r0,r2	; 03802F1C
	lsl r4,r0,#0x8	; 03802F1E
	ldr r0,[pool_03802F40]	; 03802F20
	orr r4,r0	; 03802F22
	and r1,r3	; 03802F24
	orr r4,r1	; 03802F26
	mov r6,#0x0	; 03802F28
loc_03802F2A:
	add r0,r5,#0x0	; 03802F2A
	add r1,r4,#0x0	; 03802F2C
	add r2,r6,#0x0	; 03802F2E
	bl loc_03801F84	; 03802F30
	cmp r0,#0x0	; 03802F34
	blt loc_03802F2A	; 03802F36
	pop {r4,r5,r6}	; 03802F38
	pop {r3}	; 03802F3A
	bx r3	; 03802F3C
	.byte 0xC0, 0x46	; 03802F40
pool_03802F40:
loc_03802F40:
	.word 0x03000000	; 03802F40

; ===== function loc_03802F44 =====
loc_03802F44:
	push {lr}	; 03802F44
	sub sp,#0x4	; 03802F46
	ldr r1,[pool_03802F80]	; 03802F48
	ldr r2,[r1,#0x0]	; 03802F4A
	cmp r2,#0x0	; 03802F4C
	beq loc_03802F7A	; 03802F4E
	ldr r1,[r1,#0x4]	; 03802F50
	cmp r1,#0x4	; 03802F52
	bne loc_03802F7A	; 03802F54
	ldr r1,[pool_03802F84]	; 03802F56
	ldr r1,[r1,#0x5c]	; 03802F58
	cmp r1,r0	; 03802F5A
	bne loc_03802F7A	; 03802F5C
	bl loc_037FDD34	; 03802F5E
	mov r2,#0x5	; 03802F62
	ldr r1,[pool_03802F80]	; 03802F64
	str r2,[r1,#0x4]	; 03802F66
	mov r2,#0x0	; 03802F68
	str r2,[r1,#0x0]	; 03802F6A
	ldr r1,[pool_03802F84]	; 03802F6C
	str r2,[r1,#0x5c]	; 03802F6E
	bl loc_037FDD58	; 03802F70
	ldr r0,[pool_03802F88]	; 03802F74
	bl loc_037FDF58	; 03802F76
loc_03802F7A:
	add sp,#0x4	; 03802F7A
	pop {r3}	; 03802F7C
	bx r3	; 03802F7E
pool_03802F80:
loc_03802F80:
	.word P2_BssStart + 0x2140	; 03802F80
pool_03802F84:
loc_03802F84:
	.word P2_BssStart + 0x2540	; 03802F84
pool_03802F88:
loc_03802F88:
	.word 0x03807978	; 03802F88

; ===== function loc_03802F8C =====
loc_03802F8C:
	push {r4,r5,r6,r7,lr}	; 03802F8C
	sub sp,#0x4	; 03802F8E
	add r5,r0,#0x0	; 03802F90
	ldr r7,[pool_03802FC8]	; 03802F92
	ldr r6,[pool_03802FCC]	; 03802F94
loc_03802F96:
	bl loc_037FDD34	; 03802F96
	add r4,r0,#0x0	; 03802F9A
	ldr r1,[r6,#0x0]	; 03802F9C
	cmp r1,#0x0	; 03802F9E
	beq loc_03802FAE	; 03802FA0
	bl loc_037FDD58	; 03802FA2
	add r0,r7,#0x0	; 03802FA6
	bl loc_037FDFA0	; 03802FA8
	b loc_03802F96	; 03802FAC
loc_03802FAE:
	mov r0,#0x4	; 03802FAE
	bl loc_03802EB4	; 03802FB0
	ldr r0,[pool_03802FD0]	; 03802FB4
	str r5,[r0,#0x5c]	; 03802FB6
	add r0,r4,#0x0	; 03802FB8
	bl loc_037FDD58	; 03802FBA
	add sp,#0x4	; 03802FBE
	pop {r4,r5,r6,r7}	; 03802FC0
	pop {r3}	; 03802FC2
	bx r3	; 03802FC4
	.byte 0xC0, 0x46	; 03802FC8
pool_03802FC8:
loc_03802FC8:
	.word 0x03807978	; 03802FC8
pool_03802FCC:
loc_03802FCC:
	.word 0x03807520	; 03802FCC
pool_03802FD0:
loc_03802FD0:
	.word P2_BssStart + 0x2540	; 03802FD0

; ===== function loc_03802FD4 =====
loc_03802FD4:
	push {r4,r5,r6,r7,lr}	; 03802FD4
	sub sp,#0xc	; 03802FD6
	add r5,r0,#0x0	; 03802FD8
	ldr r0,[pool_03803068]	; 03802FDA
	ldrh r1,[r0,#0x0]	; 03802FDC
	cmp r1,#0x0	; 03802FDE
	bne loc_0380305E	; 03802FE0
	mov r1,#0x1	; 03802FE2
	strh r1,[r0,#0x0]	; 03802FE4
	mov r1,#0x0	; 03802FE6
	ldr r0,[pool_0380306C]	; 03802FE8
	str r1,[r0,#0x0]	; 03802FEA
	mov r1,#0x5	; 03802FEC
	str r1,[r0,#0x4]	; 03802FEE
	bl loc_038033C8	; 03802FF0
	bl loc_03803C6C	; 03802FF4
	bl loc_038043F4	; 03802FF8
	bl loc_03801EA4	; 03802FFC
	mov r0,#0x6	; 03803000
	ldr r1,[pool_03803070]	; 03803002
	bl P2_SetPxiReceiveCallback	; 03803004
	mov r0,#0x8	; 03803008
	ldr r1,[pool_03803070]	; 0380300A
	bl P2_SetPxiReceiveCallback	; 0380300C
	mov r0,#0x4	; 03803010
	ldr r1,[pool_03803070]	; 03803012
	bl P2_SetPxiReceiveCallback	; 03803014
	ldr r0,[pool_03803074]	; 03803018
	ldr r1,[pool_03803078]	; 0380301A
	mov r2,#0x10	; 0380301C
	bl loc_037FE3B0	; 0380301E
	mov r4,#0x0	; 03803022
	ldr r7,[pool_0380307C]	; 03803024
	add r6,r4,#0x0	; 03803026
loc_03803028:
	add r1,r4,#0x0	; 03803028
	mov r0,#0x18	; 0380302A
	mul r1,r0	; 0380302C
	add r0,r7,r1	; 0380302E
	add r1,r6,#0x0	; 03803030
	mov r2,#0x18	; 03803032
	bl loc_037FAABC	; 03803034
	add r4,r4,#0x1	; 03803038
	cmp r4,#0x10	; 0380303A
	blt loc_03803028	; 0380303C
	mov r2,#0x0	; 0380303E
	ldr r0,[pool_03803080]	; 03803040
	str r2,[r0,#0x54]	; 03803042
	ldr r0,[pool_03803084]	; 03803044
	strh r2,[r0,#0x18]	; 03803046
	ldr r0,[pool_03803088]	; 03803048
	str r0,[sp,#0x0]	; 0380304A
	str r5,[sp,#0x4]	; 0380304C
	ldr r0,[pool_0380308C]	; 0380304E
	ldr r1,[pool_03803090]	; 03803050
	ldr r3,[pool_03803074]	; 03803052
	bl P2_CreateThread	; 03803054
	ldr r0,[pool_0380308C]	; 03803058
	bl loc_037FDF34	; 0380305A
loc_0380305E:
	add sp,#0xc	; 0380305E
	pop {r4,r5,r6,r7}	; 03803060
	pop {r3}	; 03803062
	bx r3	; 03803064
	.byte 0xC0, 0x46	; 03803068
pool_03803068:
loc_03803068:
	.word P2_BssStart + 0x213C	; 03803068
pool_0380306C:
loc_0380306C:
	.word P2_BssStart + 0x2140	; 0380306C
pool_03803070:
loc_03803070:
	.word P2_PxiCallback_03802D74 + 1	; 03803070
pool_03803074:
loc_03803074:
	.word 0x038077A0	; 03803074
pool_03803078:
loc_03803078:
	.word 0x038077B4	; 03803078
pool_0380307C:
loc_0380307C:
	.word 0x038077F4	; 0380307C
pool_03803080:
loc_03803080:
	.word P2_BssStart + 0x2540	; 03803080
pool_03803084:
loc_03803084:
	.word P2_BssStart + 0x2580	; 03803084
pool_03803088:
loc_03803088:
	.word 0x00000200	; 03803088
pool_0380308C:
loc_0380308C:
	.word 0x03807528	; 0380308C
pool_03803090:
loc_03803090:
	.word P2_ThreadEntry_03802DA8 + 1	; 03803090

; ===== function loc_03803094 =====
loc_03803094:
	push {lr}	; 03803094
	sub sp,#0x4	; 03803096
	cmp r0,#0x0	; 03803098
	bne loc_038030A6	; 0380309A
	mov r0,#0x3	; 0380309C
	mov r1,#0x2	; 0380309E
	bl loc_03802ED8	; 038030A0
	b loc_038030C2	; 038030A4
loc_038030A6:
	cmp r1,#0x0	; 038030A6
	bne loc_038030B4	; 038030A8
	mov r0,#0x3	; 038030AA
	mov r1,#0x2	; 038030AC
	bl loc_03802ED8	; 038030AE
	b loc_038030C2	; 038030B2
loc_038030B4:
	ldr r2,[pool_038030C8]	; 038030B4
	str r0,[r2,#0x24]	; 038030B6
	str r1,[r2,#0x28]	; 038030B8
	mov r0,#0x3	; 038030BA
	mov r1,#0x0	; 038030BC
	bl loc_03802ED8	; 038030BE
loc_038030C2:
	add sp,#0x4	; 038030C2
	pop {r3}	; 038030C4
	bx r3	; 038030C6
pool_038030C8:
loc_038030C8:
	.word P2_BssStart + 0x25A0	; 038030C8

; ===== function loc_038030CC =====
P2_Code_038030CC:
	push {r4,lr}	; 038030CC
	sub sp,#0x8	; 038030CE
	add r4,r0,#0x0	; 038030D0
	mov r0,#0x0	; 038030D2
	mov r1,#0x10	; 038030D4
	mov r2,#0x1	; 038030D6
	add r3,r4,#0x0	; 038030D8
	bl loc_03802DE4	; 038030DA
	cmp r0,#0x0	; 038030DE
	bne loc_0380310A	; 038030E0
	ldr r1,[sp,#0x0]	; 038030E2
	ldr r0,[pool_03803114]	; 038030E4
	and r1,r0	; 038030E6
	ldr r0,[pool_03803118]	; 038030E8
	orr r1,r0	; 038030EA
	str r1,[sp,#0x0]	; 038030EC
	add r0,sp,#0x0	; 038030EE
	ldrh r2,[r0,#0x0]	; 038030F0
	ldr r1,[pool_0380311C]	; 038030F2
	strh r2,[r1,#0x0]	; 038030F4
	ldrh r1,[r0,#0x2]	; 038030F6
	ldr r0,[pool_03803120]	; 038030F8
	strh r1,[r0,#0x0]	; 038030FA
	mov r0,#0x10	; 038030FC
	mov r1,#0xff	; 038030FE
	and r4,r1	; 03803100
	lsl r1,r4,#0x10	; 03803102
	lsr r1,r1,#0x10	; 03803104
	bl loc_03802ED8	; 03803106
loc_0380310A:
	add sp,#0x8	; 0380310A
	pop {r4}	; 0380310C
	pop {r3}	; 0380310E
	bx r3	; 03803110
	.byte 0xC0, 0x46	; 03803114
pool_03803114:
loc_03803114:
	.word 0xF9FFFFFF	; 03803114
pool_03803118:
loc_03803118:
	.word 0x06000000	; 03803118
pool_0380311C:
loc_0380311C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0380311C
pool_03803120:
loc_03803120:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 03803120
P2_Entry_03803124:
	push {r4,r5,r6,r7,lr}	; 03803124
	sub sp,#0xc	; 03803126
	add r5,r0,#0x0	; 03803128
	ldr r1,[r5,#0x4]	; 0380312A
	cmp r1,#0x2	; 0380312C
	bhi P2_Entry_0380313E	; 0380312E
	cmp r1,#0x0	; 03803130
	beq P2_Entry_0380314E	; 03803132
	cmp r1,#0x1	; 03803134
	beq P2_Entry_038031C4	; 03803136
	cmp r1,#0x2	; 03803138
	beq P2_Entry_03803232	; 0380313A
	b P2_Entry_0380325E	; 0380313C
P2_Entry_0380313E:
	cmp r1,#0x10	; 0380313E
	beq P2_Entry_03803144	; 03803140
	b P2_Entry_0380325E	; 03803142
P2_Entry_03803144:
	ldr r0,[pool_03803268]	; 03803144
	ldr r0,[r0,#0x20]	; 03803146
	cmp r0,#0x2	; 03803148
	beq P2_Entry_0380314E	; 0380314A
	b P2_Entry_0380325E	; 0380314C
P2_Entry_0380314E:
	bl loc_037FDD34	; 0380314E
	add r4,r0,#0x0	; 03803152
	mov r0,#0x0	; 03803154
	bl P2_Entry_03802EC4	; 03803156
	cmp r0,#0x0	; 0380315A
	bne P2_Entry_03803172	; 0380315C
	add r0,r4,#0x0	; 0380315E
	bl loc_037FDD58	; 03803160
	ldr r0,[r5,#0x4]	; 03803164
	lsl r0,r0,#0x10	; 03803166
	lsr r0,r0,#0x10	; 03803168
	mov r1,#0x4	; 0380316A
	bl loc_03802ED8	; 0380316C
	b P2_Entry_0380325E	; 03803170
P2_Entry_03803172:
	mov r0,#0x0	; 03803172
	bl loc_03802EB4	; 03803174
	add r0,r4,#0x0	; 03803178
	bl loc_037FDD58	; 0380317A
	add r0,sp,#0x4	; 0380317E
	ldr r2,[pool_03803268]	; 03803180
	ldr r1,[r2,#0x28]	; 03803182
	ldr r2,[r2,#0x24]	; 03803184
	bl P2_Entry_038034A8	; 03803186
	add r0,sp,#0x4	; 0380318A
	ldrh r2,[r0,#0x0]	; 0380318C
	ldr r1,[pool_0380326C]	; 0380318E
	strh r2,[r1,#0x0]	; 03803190
	ldrh r1,[r0,#0x2]	; 03803192
	ldr r0,[pool_03803270]	; 03803194
	strh r1,[r0,#0x0]	; 03803196
	ldr r0,[r5,#0x4]	; 03803198
	cmp r0,#0x0	; 0380319A
	bne P2_Entry_038031AA	; 0380319C
	lsl r0,r0,#0x10	; 0380319E
	lsr r0,r0,#0x10	; 038031A0
	mov r1,#0x0	; 038031A2
	bl loc_03802ED8	; 038031A4
	b P2_Entry_038031BC	; 038031A8
P2_Entry_038031AA:
	lsl r0,r0,#0x10	; 038031AA
	lsr r0,r0,#0x10	; 038031AC
	ldr r2,[r5,#0x8]	; 038031AE
	mov r1,#0xff	; 038031B0
	and r2,r1	; 038031B2
	lsl r1,r2,#0x10	; 038031B4
	lsr r1,r1,#0x10	; 038031B6
	bl loc_03802ED8	; 038031B8
P2_Entry_038031BC:
	mov r0,#0x0	; 038031BC
	bl P2_Entry_03802E8C	; 038031BE
	b P2_Entry_0380325E	; 038031C2
P2_Entry_038031C4:
	ldr r0,[pool_03803268]	; 038031C4
	ldr r0,[r0,#0x20]	; 038031C6
	cmp r0,#0x1	; 038031C8
	bne P2_Entry_03803226	; 038031CA
	mov r4,#0x0	; 038031CC
	add r7,r4,#0x0	; 038031CE
	b P2_Entry_0380320C	; 038031D0
P2_Entry_038031D2:
	lsl r2,r4,#0x1	; 038031D2
	ldr r0,[pool_03803268]	; 038031D4
	add r6,r0,r2	; 038031D6
	add r0,r4,#0x0	; 038031D8
	ldr r2,[pool_03803274]	; 038031DA
	mul r0,r2	; 038031DC
	bl loc_03803284	; 038031DE
	ldr r1,[r5,#0xc]	; 038031E2
	add r0,r1,r0	; 038031E4
	ldr r1,[pool_03803274]	; 038031E6
	bl loc_03803284	; 038031E8
	add r0,r6,#0x0	; 038031EC
	add r0,#0xcc	; 038031EE
	strh r1,[r0,#0x0]	; 038031F0
	str r4,[sp,#0x0]	; 038031F2
	add r1,r4,#0x0	; 038031F4
	mov r0,#0x28	; 038031F6
	mul r1,r0	; 038031F8
	ldr r0,[pool_03803278]	; 038031FA
	add r0,r0,r1	; 038031FC
	mov r1,#0xcc	; 038031FE
	ldrsh r1,[r6,r1]	; 03803200
	add r2,r7,#0x0	; 03803202
	ldr r3,[pool_0380327C]	; 03803204
	bl P2_Entry_037FEF90	; 03803206
	add r4,r4,#0x1	; 0380320A
P2_Entry_0380320C:
	ldr r1,[r5,#0x8]	; 0380320C
	cmp r4,r1	; 0380320E
	bcc P2_Entry_038031D2	; 03803210
	ldr r0,[r5,#0x4]	; 03803212
	lsl r0,r0,#0x10	; 03803214
	lsr r0,r0,#0x10	; 03803216
	mov r1,#0x0	; 03803218
	bl loc_03802ED8	; 0380321A
	mov r1,#0x2	; 0380321E
	ldr r0,[pool_03803268]	; 03803220
	str r1,[r0,#0x20]	; 03803222
	b P2_Entry_0380325E	; 03803224
P2_Entry_03803226:
	lsl r0,r1,#0x10	; 03803226
	lsr r0,r0,#0x10	; 03803228
	mov r1,#0x3	; 0380322A
	bl loc_03802ED8	; 0380322C
	b P2_Entry_0380325E	; 03803230
P2_Entry_03803232:
	ldr r0,[pool_03803268]	; 03803232
	ldr r0,[r0,#0x20]	; 03803234
	cmp r0,#0x3	; 03803236
	bne P2_Entry_03803254	; 03803238
	ldr r0,[pool_03803280]	; 0380323A
	bl P2_Entry_037FEE9C	; 0380323C
	ldr r0,[r5,#0x4]	; 03803240
	lsl r0,r0,#0x10	; 03803242
	lsr r0,r0,#0x10	; 03803244
	mov r1,#0x0	; 03803246
	bl loc_03802ED8	; 03803248
	mov r1,#0x0	; 0380324C
	ldr r0,[pool_03803268]	; 0380324E
	str r1,[r0,#0x20]	; 03803250
	b P2_Entry_0380325E	; 03803252
P2_Entry_03803254:
	lsl r0,r1,#0x10	; 03803254
	lsr r0,r0,#0x10	; 03803256
	mov r1,#0x3	; 03803258
	bl loc_03802ED8	; 0380325A
P2_Entry_0380325E:
	add sp,#0xc	; 0380325E
	pop {r4,r5,r6,r7}	; 03803260
	pop {r3}	; 03803262
	bx r3	; 03803264
	.byte 0xC0, 0x46	; 03803266
pool_03803268:
	.word P2_BssStart + 0x25A0	; 03803268
pool_0380326C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0380326C
pool_03803270:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 2	; 03803270
pool_03803274:
	.word 0x00000107	; 03803274
pool_03803278:
	.word 0x038079AC	; 03803278
pool_0380327C:
	.word P2_Code_038030CC + 1	; 0380327C
pool_03803280:
	.word 0x54505641	; 03803280

; ===== function loc_03803284 =====
loc_03803284:
	bx pc	; 03803284
	.byte 0xC0, 0x46	; 03803288
.arm

; ===== function loc_03803288 =====
loc_03803288:
	ldr pc,[pool_0380328C]	; 03803288
pool_0380328C:
loc_0380328C:
	.word loc_03804DF8	; 0380328C
.thumb

; ===== function loc_03803290 =====
loc_03803290:
	push {r4,lr}	; 03803290
	sub sp,#0x8	; 03803292
	ldr r1,[pool_038033B0]	; 03803294
	add r2,r0,#0x0	; 03803296
	and r2,r1	; 03803298
	cmp r2,#0x0	; 0380329A
	beq loc_038032AE	; 0380329C
	mov r4,#0x0	; 0380329E
	add r3,r4,#0x0	; 038032A0
	ldr r1,[pool_038033B4]	; 038032A2
loc_038032A4:
	lsl r2,r4,#0x1	; 038032A4
	strh r3,[r1,r2]	; 038032A6
	add r4,r4,#0x1	; 038032A8
	cmp r4,#0x10	; 038032AA
	blt loc_038032A4	; 038032AC
loc_038032AE:
	ldr r1,[pool_038033B8]	; 038032AE
	add r2,r0,#0x0	; 038032B0
	and r2,r1	; 038032B2
	lsr r1,r2,#0x10	; 038032B4
	lsl r2,r1,#0x1	; 038032B6
	ldr r1,[pool_038033B4]	; 038032B8
	strh r0,[r1,r2]	; 038032BA
	ldr r2,[pool_038033BC]	; 038032BC
	and r0,r2	; 038032BE
	cmp r0,#0x0	; 038032C0
	beq loc_038033A8	; 038032C2
	ldrh r0,[r1,#0x0]	; 038032C4
	ldr r2,[pool_038033C0]	; 038032C6
	add r3,r0,#0x0	; 038032C8
	and r3,r2	; 038032CA
	lsl r2,r3,#0x8	; 038032CC
	lsr r4,r2,#0x10	; 038032CE
	cmp r4,#0x3	; 038032D0
	bhi loc_038033A0	; 038032D2
	add r2,r4,r4	; 038032D4
P2_SwitchIndexPC_038032D4:
	add r2,pc	; 038032D6
	ldrh r2,[r2,#(P2_SwitchTable_038032D4 - (P2_SwitchIndexPC_038032D4 + 4))]	; 038032D8
	lsl r2,r2,#0x10	; 038032DA
	asr r2,r2,#0x10	; 038032DC
P2_SwitchTargetPC_038032D4:
	add r2,pc	; 038032DE
	bx r2	; 038032E0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038032D4:
	.halfword (loc_038032FA + 1) - (P2_SwitchTargetPC_038032D4 + 4)
	.halfword (loc_03803312 + 1) - (P2_SwitchTargetPC_038032D4 + 4)
	.halfword (loc_03803370 + 1) - (P2_SwitchTargetPC_038032D4 + 4)
	.halfword (loc_038032EA + 1) - (P2_SwitchTargetPC_038032D4 + 4)
P2_SwitchTable_038032D4End:
loc_038032EA:
	mov r2,#0xff	; 038032EA
	and r0,r2	; 038032EC
	lsl r0,r0,#0x10	; 038032EE
	lsr r0,r0,#0x10	; 038032F0
	ldrh r1,[r1,#0x2]	; 038032F2
	bl loc_03803094	; 038032F4
	b loc_038033A8	; 038032F8
loc_038032FA:
	mov r0,#0x0	; 038032FA
	add r1,r4,#0x0	; 038032FC
	add r2,r0,#0x0	; 038032FE
	bl loc_03802DE4	; 03803300
	cmp r0,#0x0	; 03803304
	bne loc_038033A8	; 03803306
	add r0,r4,#0x0	; 03803308
	mov r1,#0x4	; 0380330A
	bl loc_03802ED8	; 0380330C
	b loc_038033A8	; 03803310
loc_03803312:
	ldr r2,[r1,#0x20]	; 03803312
	cmp r2,#0x0	; 03803314
	beq loc_03803322	; 03803316
	add r0,r4,#0x0	; 03803318
	mov r1,#0x3	; 0380331A
	bl loc_03802ED8	; 0380331C
	b loc_038033A8	; 03803320
loc_03803322:
	mov r2,#0xff	; 03803322
	and r0,r2	; 03803324
	lsl r0,r0,#0x10	; 03803326
	lsr r3,r0,#0x10	; 03803328
	cmp r3,#0x0	; 0380332A
	beq loc_03803332	; 0380332C
	cmp r3,#0x4	; 0380332E
	bls loc_0380333C	; 03803330
loc_03803332:
	add r0,r4,#0x0	; 03803332
	mov r1,#0x2	; 03803334
	bl loc_03802ED8	; 03803336
	b loc_038033A8	; 0380333A
loc_0380333C:
	ldrh r1,[r1,#0x2]	; 0380333C
	ldr r0,[pool_038033C4]	; 0380333E
	cmp r1,r0	; 03803340
	bcc loc_0380334E	; 03803342
	add r0,r4,#0x0	; 03803344
	mov r1,#0x2	; 03803346
	bl loc_03802ED8	; 03803348
	b loc_038033A8	; 0380334C
loc_0380334E:
	str r1,[sp,#0x0]	; 0380334E
	mov r0,#0x0	; 03803350
	add r1,r4,#0x0	; 03803352
	mov r2,#0x2	; 03803354
	bl loc_03802DE4	; 03803356
	cmp r0,#0x0	; 0380335A
	bne loc_03803368	; 0380335C
	add r0,r4,#0x0	; 0380335E
	mov r1,#0x4	; 03803360
	bl loc_03802ED8	; 03803362
	b loc_038033A8	; 03803366
loc_03803368:
	mov r1,#0x1	; 03803368
	ldr r0,[pool_038033B4]	; 0380336A
	str r1,[r0,#0x20]	; 0380336C
	b loc_038033A8	; 0380336E
loc_03803370:
	ldr r0,[r1,#0x20]	; 03803370
	cmp r0,#0x2	; 03803372
	beq loc_03803380	; 03803374
	add r0,r4,#0x0	; 03803376
	mov r1,#0x3	; 03803378
	bl loc_03802ED8	; 0380337A
	b loc_038033A8	; 0380337E
loc_03803380:
	mov r0,#0x0	; 03803380
	add r1,r4,#0x0	; 03803382
	add r2,r0,#0x0	; 03803384
	bl loc_03802DE4	; 03803386
	cmp r0,#0x0	; 0380338A
	bne loc_03803398	; 0380338C
	add r0,r4,#0x0	; 0380338E
	mov r1,#0x4	; 03803390
	bl loc_03802ED8	; 03803392
	b loc_038033A8	; 03803396
loc_03803398:
	mov r1,#0x3	; 03803398
	ldr r0,[pool_038033B4]	; 0380339A
	str r1,[r0,#0x20]	; 0380339C
	b loc_038033A8	; 0380339E
loc_038033A0:
	add r0,r4,#0x0	; 038033A0
	mov r1,#0x1	; 038033A2
	bl loc_03802ED8	; 038033A4
loc_038033A8:
	add sp,#0x8	; 038033A8
	pop {r4}	; 038033AA
	pop {r3}	; 038033AC
	bx r3	; 038033AE
pool_038033B0:
loc_038033B0:
	.word 0x02000000	; 038033B0
pool_038033B4:
loc_038033B4:
	.word P2_BssStart + 0x25A0	; 038033B4
pool_038033B8:
loc_038033B8:
	.word 0x000F0000	; 038033B8
pool_038033BC:
loc_038033BC:
	.word 0x01000000	; 038033BC
pool_038033C0:
loc_038033C0:
	.word 0x0000FF00	; 038033C0
pool_038033C4:
loc_038033C4:
	.word 0x00000107	; 038033C4

; ===== function loc_038033C8 =====
loc_038033C8:
	push {r4,r5,r6,r7,lr}	; 038033C8
	sub sp,#0x4	; 038033CA
	mov r3,#0x0	; 038033CC
	ldr r0,[pool_0380348C]	; 038033CE
	str r3,[r0,#0x20]	; 038033D0
	mov r1,#0x1e	; 038033D2
	str r1,[r0,#0x28]	; 038033D4
	mov r1,#0x5	; 038033D6
	str r1,[r0,#0x24]	; 038033D8
	add r2,r3,#0x0	; 038033DA
loc_038033DC:
	lsl r1,r3,#0x1	; 038033DC
	strh r2,[r0,r1]	; 038033DE
	add r3,r3,#0x1	; 038033E0
	cmp r3,#0x10	; 038033E2
	blt loc_038033DC	; 038033E4
	bl loc_037FF0F8	; 038033E6
	cmp r0,#0x0	; 038033EA
	bne loc_038033F2	; 038033EC
	bl loc_037FF104	; 038033EE
loc_038033F2:
	mov r4,#0x0	; 038033F2
	ldr r6,[pool_03803490]	; 038033F4
	mov r7,#0x28	; 038033F6
loc_038033F8:
	add r0,r4,#0x0	; 038033F8
	mul r0,r7	; 038033FA
	add r5,r6,r0	; 038033FC
	add r0,r5,#0x0	; 038033FE
	bl loc_037FF050	; 03803400
	add r0,r5,#0x0	; 03803404
	ldr r1,[pool_03803494]	; 03803406
	bl loc_037FEF24	; 03803408
	add r4,r4,#0x1	; 0380340C
	cmp r4,#0x4	; 0380340E
	blt loc_038033F8	; 03803410
	mov r6,#0x1	; 03803412
	ldr r5,[pool_03803498]	; 03803414
	mov r4,#0x80	; 03803416
	b loc_03803420	; 03803418
loc_0380341A:
	add r0,r6,#0x0	; 0380341A
	bl loc_0380491C	; 0380341C
loc_03803420:
	ldrh r0,[r5,#0x0]	; 03803420
	and r0,r4	; 03803422
	cmp r0,#0x0	; 03803424
	bne loc_0380341A	; 03803426
	ldr r0,[pool_0380349C]	; 03803428
	strh r0,[r5,#0x0]	; 0380342A
	mov r1,#0x84	; 0380342C
	ldr r0,[pool_038034A0]	; 0380342E
	strh r1,[r0,#0x0]	; 03803430
	mov r6,#0x1	; 03803432
	ldr r5,[pool_03803498]	; 03803434
	mov r4,#0x80	; 03803436
	b loc_03803440	; 03803438
loc_0380343A:
	add r0,r6,#0x0	; 0380343A
	bl loc_0380491C	; 0380343C
loc_03803440:
	ldrh r0,[r5,#0x0]	; 03803440
	and r0,r4	; 03803442
	cmp r0,#0x0	; 03803444
	bne loc_0380343A	; 03803446
	mov r1,#0x0	; 03803448
	ldr r0,[pool_038034A0]	; 0380344A
	strh r1,[r0,#0x0]	; 0380344C
	mov r6,#0x1	; 0380344E
	ldr r5,[pool_03803498]	; 03803450
	mov r4,#0x80	; 03803452
	b loc_0380345C	; 03803454
loc_03803456:
	add r0,r6,#0x0	; 03803456
	bl loc_0380491C	; 03803458
loc_0380345C:
	ldrh r0,[r5,#0x0]	; 0380345C
	and r0,r4	; 0380345E
	cmp r0,#0x0	; 03803460
	bne loc_03803456	; 03803462
	ldr r0,[pool_038034A4]	; 03803464
	strh r0,[r5,#0x0]	; 03803466
	mov r1,#0x0	; 03803468
	ldr r0,[pool_038034A0]	; 0380346A
	strh r1,[r0,#0x0]	; 0380346C
	mov r6,#0x1	; 0380346E
	ldr r5,[pool_03803498]	; 03803470
	mov r4,#0x80	; 03803472
	b loc_0380347C	; 03803474
loc_03803476:
	add r0,r6,#0x0	; 03803476
	bl loc_0380491C	; 03803478
loc_0380347C:
	ldrh r0,[r5,#0x0]	; 0380347C
	and r0,r4	; 0380347E
	cmp r0,#0x0	; 03803480
	bne loc_03803476	; 03803482
	add sp,#0x4	; 03803484
	pop {r4,r5,r6,r7}	; 03803486
	pop {r3}	; 03803488
	bx r3	; 0380348A
pool_0380348C:
loc_0380348C:
	.word P2_BssStart + 0x25A0	; 0380348C
pool_03803490:
loc_03803490:
	.word 0x038079AC	; 03803490
pool_03803494:
loc_03803494:
	.word 0x54505641	; 03803494
pool_03803498:
loc_03803498:
	.word REG_SPICNT	; 03803498
pool_0380349C:
loc_0380349C:
	.word 0x00008A01	; 0380349C
pool_038034A0:
loc_038034A0:
	.word REG_SPIDATA	; 038034A0
pool_038034A4:
loc_038034A4:
	.word 0x00008201	; 038034A4

; ===== function loc_038034A8 =====
P2_Entry_038034A8:
	push {r4,r5,r6,r7,lr}	; 038034A8
	sub sp,#0x4	; 038034AA
	add r5,r0,#0x0	; 038034AC
	add r4,r1,#0x0	; 038034AE
	add r6,r2,#0x0	; 038034B0
	cmp r4,#0x0	; 038034B2
	bge loc_038034B8	; 038034B4
	neg r4,r4	; 038034B6
loc_038034B8:
	bl loc_0380385C	; 038034B8
	add r7,r0,#0x0	; 038034BC
	cmp r7,#0x0	; 038034BE
	bne loc_038034EE	; 038034C0
	ldr r1,[r5,#0x0]	; 038034C2
	ldr r0,[pool_03803610]	; 038034C4
	and r1,r0	; 038034C6
	str r1,[r5,#0x0]	; 038034C8
	ldr r1,[r5,#0x0]	; 038034CA
	ldr r0,[pool_03803614]	; 038034CC
	and r1,r0	; 038034CE
	str r1,[r5,#0x0]	; 038034D0
	ldr r1,[r5,#0x0]	; 038034D2
	ldr r0,[pool_03803618]	; 038034D4
	and r1,r0	; 038034D6
	str r1,[r5,#0x0]	; 038034D8
	ldr r1,[r5,#0x0]	; 038034DA
	ldr r0,[pool_0380361C]	; 038034DC
	and r1,r0	; 038034DE
	ldr r0,[pool_03803620]	; 038034E0
	orr r1,r0	; 038034E2
	str r1,[r5,#0x0]	; 038034E4
	mov r1,#0x0	; 038034E6
	ldr r0,[pool_03803624]	; 038034E8
	strh r1,[r0,#0x0]	; 038034EA
	b loc_03803608	; 038034EC
loc_038034EE:
	add r0,sp,#0x0	; 038034EE
	add r1,r4,#0x0	; 038034F0
	add r2,r6,#0x0	; 038034F2
	mov r3,#0x0	; 038034F4
	bl loc_03803644	; 038034F6
	ldr r1,[r5,#0x0]	; 038034FA
	ldr r2,[pool_0380361C]	; 038034FC
	and r1,r2	; 038034FE
	mov r2,#0x3	; 03803500
	and r0,r2	; 03803502
	lsl r0,r0,#0x19	; 03803504
	orr r1,r0	; 03803506
	str r1,[r5,#0x0]	; 03803508
	ldr r0,[r5,#0x0]	; 0380350A
	ldr r1,[pool_03803610]	; 0380350C
	and r0,r1	; 0380350E
	add r1,sp,#0x0	; 03803510
	ldrh r2,[r1,#0x0]	; 03803512
	ldr r1,[pool_03803628]	; 03803514
	and r2,r1	; 03803516
	orr r0,r2	; 03803518
	str r0,[r5,#0x0]	; 0380351A
	add r0,sp,#0x0	; 0380351C
	add r1,r4,#0x0	; 0380351E
	add r2,r6,#0x0	; 03803520
	mov r3,#0x1	; 03803522
	bl loc_03803644	; 03803524
	cmp r0,#0x2	; 03803528
	bne loc_0380354C	; 0380352A
	ldr r1,[r5,#0x0]	; 0380352C
	lsl r0,r1,#0x5	; 0380352E
	lsr r0,r0,#0x1e	; 03803530
	cmp r0,#0x1	; 03803532
	bne loc_03803542	; 03803534
	ldr r0,[pool_0380361C]	; 03803536
	and r1,r0	; 03803538
	ldr r0,[pool_03803620]	; 0380353A
	orr r1,r0	; 0380353C
	str r1,[r5,#0x0]	; 0380353E
	b loc_0380354C	; 03803540
loc_03803542:
	ldr r0,[pool_0380361C]	; 03803542
	and r1,r0	; 03803544
	ldr r0,[pool_0380362C]	; 03803546
	orr r1,r0	; 03803548
	str r1,[r5,#0x0]	; 0380354A
loc_0380354C:
	ldr r0,[r5,#0x0]	; 0380354C
	ldr r1,[pool_03803614]	; 0380354E
	and r0,r1	; 03803550
	add r1,sp,#0x0	; 03803552
	ldrh r2,[r1,#0x0]	; 03803554
	ldr r1,[pool_03803628]	; 03803556
	and r2,r1	; 03803558
	lsl r1,r2,#0xc	; 0380355A
	orr r0,r1	; 0380355C
	str r0,[r5,#0x0]	; 0380355E
	ldr r1,[pool_03803630]	; 03803560
	ldr r0,[pool_03803634]	; 03803562
	strh r1,[r0,#0x0]	; 03803564
	mov r4,#0x0	; 03803566
	add r6,r4,#0x0	; 03803568
loc_0380356A:
	ldr r0,[pool_03803638]	; 0380356A
	strh r6,[r0,#0x0]	; 0380356C
	b loc_03803576	; 0380356E
loc_03803570:
	mov r0,#0x1	; 03803570
	bl loc_0380491C	; 03803572
loc_03803576:
	ldr r0,[pool_03803634]	; 03803576
	ldrh r1,[r0,#0x0]	; 03803578
	mov r0,#0x80	; 0380357A
	and r1,r0	; 0380357C
	cmp r1,#0x0	; 0380357E
	bne loc_03803570	; 03803580
	add r4,r4,#0x1	; 03803582
	cmp r4,#0xc	; 03803584
	blt loc_0380356A	; 03803586
	ldr r1,[pool_0380363C]	; 03803588
	ldr r0,[pool_03803634]	; 0380358A
	strh r1,[r0,#0x0]	; 0380358C
	mov r1,#0x0	; 0380358E
	ldr r0,[pool_03803638]	; 03803590
	strh r1,[r0,#0x0]	; 03803592
	ldr r4,[pool_03803634]	; 03803594
	mov r6,#0x80	; 03803596
	b loc_038035A0	; 03803598
loc_0380359A:
	mov r0,#0x1	; 0380359A
	bl loc_0380491C	; 0380359C
loc_038035A0:
	ldrh r0,[r4,#0x0]	; 038035A0
	and r0,r6	; 038035A2
	cmp r0,#0x0	; 038035A4
	bne loc_0380359A	; 038035A6
	cmp r7,#0x2	; 038035A8
	bne loc_038035B8	; 038035AA
	ldr r1,[r5,#0x0]	; 038035AC
	ldr r0,[pool_0380361C]	; 038035AE
	and r1,r0	; 038035B0
	ldr r0,[pool_03803620]	; 038035B2
	orr r1,r0	; 038035B4
	str r1,[r5,#0x0]	; 038035B6
loc_038035B8:
	bl loc_0380385C	; 038035B8
	cmp r0,#0x0	; 038035BC
	beq loc_038035F4	; 038035BE
	cmp r0,#0x1	; 038035C0
	beq loc_038035E4	; 038035C2
	cmp r0,#0x2	; 038035C4
	bne loc_03803604	; 038035C6
	ldr r1,[r5,#0x0]	; 038035C8
	ldr r0,[pool_03803640]	; 038035CA
	orr r1,r0	; 038035CC
	str r1,[r5,#0x0]	; 038035CE
	ldr r1,[r5,#0x0]	; 038035D0
	ldr r0,[pool_0380361C]	; 038035D2
	and r1,r0	; 038035D4
	ldr r0,[pool_03803620]	; 038035D6
	orr r1,r0	; 038035D8
	str r1,[r5,#0x0]	; 038035DA
	mov r1,#0x0	; 038035DC
	ldr r0,[pool_03803624]	; 038035DE
	strh r1,[r0,#0x0]	; 038035E0
	b loc_03803608	; 038035E2
loc_038035E4:
	ldr r1,[r5,#0x0]	; 038035E4
	ldr r0,[pool_03803640]	; 038035E6
	orr r1,r0	; 038035E8
	str r1,[r5,#0x0]	; 038035EA
	mov r1,#0x1	; 038035EC
	ldr r0,[pool_03803624]	; 038035EE
	strh r1,[r0,#0x0]	; 038035F0
	b loc_03803608	; 038035F2
loc_038035F4:
	ldr r1,[r5,#0x0]	; 038035F4
	ldr r0,[pool_03803618]	; 038035F6
	and r1,r0	; 038035F8
	str r1,[r5,#0x0]	; 038035FA
	mov r1,#0x0	; 038035FC
	ldr r0,[pool_03803624]	; 038035FE
	strh r1,[r0,#0x0]	; 03803600
	b loc_03803608	; 03803602
loc_03803604:
	bl loc_037FF228	; 03803604
loc_03803608:
	add sp,#0x4	; 03803608
	pop {r4,r5,r6,r7}	; 0380360A
	pop {r3}	; 0380360C
	bx r3	; 0380360E
pool_03803610:
loc_03803610:
	.word 0xFFFFF000	; 03803610
pool_03803614:
loc_03803614:
	.word 0xFF000FFF	; 03803614
pool_03803618:
loc_03803618:
	.word 0xFEFFFFFF	; 03803618
pool_0380361C:
loc_0380361C:
	.word 0xF9FFFFFF	; 0380361C
pool_03803620:
loc_03803620:
	.word 0x06000000	; 03803620
pool_03803624:
loc_03803624:
	.word P2_BssStart + 0x2674	; 03803624
pool_03803628:
loc_03803628:
	.word 0x00000FFF	; 03803628
pool_0380362C:
loc_0380362C:
	.word REG_DISPCNT_A	; 0380362C
pool_03803630:
loc_03803630:
	.word 0x00008A01	; 03803630
pool_03803634:
loc_03803634:
	.word REG_SPICNT	; 03803634
pool_03803638:
loc_03803638:
	.word REG_SPIDATA	; 03803638
pool_0380363C:
loc_0380363C:
	.word 0x00008201	; 0380363C
pool_03803640:
loc_03803640:
	.word 0x01000000	; 03803640

; ===== function loc_03803644 =====
loc_03803644:
	push {r4,r5,r6,r7,lr}	; 03803644
	sub sp,#0x24	; 03803646
	add r6,r0,#0x0	; 03803648
	str r1,[sp,#0x0]	; 0380364A
	str r2,[sp,#0x4]	; 0380364C
	cmp r3,#0x0	; 0380364E
	bne loc_03803658	; 03803650
	mov r4,#0xd1	; 03803652
	mov r7,#0x1	; 03803654
	b loc_03803664	; 03803656
loc_03803658:
	mov r4,#0x91	; 03803658
	mov r7,#0x2	; 0380365A
	b loc_03803664	; 0380365C
loc_0380365E:
	mov r0,#0x1	; 0380365E
	bl loc_0380491C	; 03803660
loc_03803664:
	ldr r5,[pool_03803848]	; 03803664
	ldrh r1,[r5,#0x0]	; 03803666
	mov r0,#0x80	; 03803668
	and r1,r0	; 0380366A
	cmp r1,#0x0	; 0380366C
	bne loc_0380365E	; 0380366E
	ldr r0,[pool_0380384C]	; 03803670
	strh r0,[r5,#0x0]	; 03803672
	mov r0,#0xff	; 03803674
	and r4,r0	; 03803676
	ldr r0,[pool_03803850]	; 03803678
	strh r4,[r0,#0x0]	; 0380367A
	b loc_03803684	; 0380367C
loc_0380367E:
	mov r0,#0x1	; 0380367E
	bl loc_0380491C	; 03803680
loc_03803684:
	ldrh r1,[r5,#0x0]	; 03803684
	mov r0,#0x80	; 03803686
	and r1,r0	; 03803688
	cmp r1,#0x0	; 0380368A
	bne loc_0380367E	; 0380368C
	mov r1,#0x0	; 0380368E
	ldr r0,[pool_03803850]	; 03803690
	strh r1,[r0,#0x0]	; 03803692
	ldr r5,[pool_03803848]	; 03803694
	b loc_0380369E	; 03803696
loc_03803698:
	mov r0,#0x1	; 03803698
	bl loc_0380491C	; 0380369A
loc_0380369E:
	ldrh r1,[r5,#0x0]	; 0380369E
	mov r0,#0x80	; 038036A0
	and r1,r0	; 038036A2
	cmp r1,#0x0	; 038036A4
	bne loc_03803698	; 038036A6
	ldr r1,[pool_03803850]	; 038036A8
	ldrh r2,[r1,#0x0]	; 038036AA
	mov r0,#0xff	; 038036AC
	and r2,r0	; 038036AE
	lsl r0,r2,#0x10	; 038036B0
	lsr r0,r0,#0x8	; 038036B2
	str r0,[sp,#0x18]	; 038036B4
	strh r4,[r1,#0x0]	; 038036B6
	ldr r5,[pool_03803848]	; 038036B8
	b loc_038036C2	; 038036BA
loc_038036BC:
	mov r0,#0x1	; 038036BC
	bl loc_0380491C	; 038036BE
loc_038036C2:
	ldrh r1,[r5,#0x0]	; 038036C2
	mov r0,#0x80	; 038036C4
	and r1,r0	; 038036C6
	cmp r1,#0x0	; 038036C8
	bne loc_038036BC	; 038036CA
	ldr r0,[pool_03803850]	; 038036CC
	ldrh r2,[r0,#0x0]	; 038036CE
	mov r1,#0xff	; 038036D0
	and r2,r1	; 038036D2
	lsl r1,r2,#0x10	; 038036D4
	lsr r1,r1,#0x10	; 038036D6
	ldr r2,[sp,#0x18]	; 038036D8
	orr r2,r1	; 038036DA
	str r2,[sp,#0x18]	; 038036DC
	ldr r1,[pool_03803854]	; 038036DE
	and r2,r1	; 038036E0
	asr r1,r2,#0x3	; 038036E2
	str r1,[sp,#0x18]	; 038036E4
	mov r1,#0x0	; 038036E6
	strh r1,[r0,#0x0]	; 038036E8
	ldr r5,[pool_03803848]	; 038036EA
	b loc_038036F4	; 038036EC
loc_038036EE:
	mov r0,#0x1	; 038036EE
	bl loc_0380491C	; 038036F0
loc_038036F4:
	ldrh r1,[r5,#0x0]	; 038036F4
	mov r0,#0x80	; 038036F6
	and r1,r0	; 038036F8
	cmp r1,#0x0	; 038036FA
	bne loc_038036EE	; 038036FC
	ldr r1,[pool_03803850]	; 038036FE
	ldrh r2,[r1,#0x0]	; 03803700
	mov r0,#0xff	; 03803702
	and r2,r0	; 03803704
	lsl r0,r2,#0x10	; 03803706
	lsr r0,r0,#0x8	; 03803708
	str r0,[sp,#0x1c]	; 0380370A
	strh r4,[r1,#0x0]	; 0380370C
	ldr r5,[pool_03803848]	; 0380370E
	b loc_03803718	; 03803710
loc_03803712:
	mov r0,#0x1	; 03803712
	bl loc_0380491C	; 03803714
loc_03803718:
	ldrh r1,[r5,#0x0]	; 03803718
	mov r0,#0x80	; 0380371A
	and r1,r0	; 0380371C
	cmp r1,#0x0	; 0380371E
	bne loc_03803712	; 03803720
	ldr r0,[pool_03803850]	; 03803722
	ldrh r1,[r0,#0x0]	; 03803724
	mov r0,#0xff	; 03803726
	and r1,r0	; 03803728
	lsl r0,r1,#0x10	; 0380372A
	lsr r0,r0,#0x10	; 0380372C
	ldr r1,[sp,#0x1c]	; 0380372E
	orr r1,r0	; 03803730
	str r1,[sp,#0x1c]	; 03803732
	ldr r0,[pool_03803854]	; 03803734
	and r1,r0	; 03803736
	asr r1,r1,#0x3	; 03803738
	str r1,[sp,#0x1c]	; 0380373A
	ldr r0,[sp,#0x4]	; 0380373C
	cmp r0,#0x0	; 0380373E
	bne loc_0380374C	; 03803740
	ldr r0,[sp,#0x18]	; 03803742
	add r0,r0,r1	; 03803744
	asr r0,r0,#0x1	; 03803746
	strh r0,[r6,#0x0]	; 03803748
	mov r7,#0x0	; 0380374A
loc_0380374C:
	mov r5,#0x0	; 0380374C
	ldr r0,[sp,#0x0]	; 0380374E
	neg r0,r0	; 03803750
	str r0,[sp,#0xc]	; 03803752
	str r5,[sp,#0x14]	; 03803754
	b loc_03803802	; 03803756
loc_03803758:
	ldr r1,[sp,#0x14]	; 03803758
	ldr r0,[pool_03803850]	; 0380375A
	strh r1,[r0,#0x0]	; 0380375C
	b loc_03803766	; 0380375E
loc_03803760:
	mov r0,#0x1	; 03803760
	bl loc_0380491C	; 03803762
loc_03803766:
	ldr r0,[pool_03803848]	; 03803766
	ldrh r1,[r0,#0x0]	; 03803768
	mov r0,#0x80	; 0380376A
	and r1,r0	; 0380376C
	cmp r1,#0x0	; 0380376E
	bne loc_03803760	; 03803770
	ldr r0,[pool_03803850]	; 03803772
	ldrh r1,[r0,#0x0]	; 03803774
	mov r0,#0xff	; 03803776
	and r1,r0	; 03803778
	lsl r0,r1,#0x10	; 0380377A
	lsr r0,r0,#0x8	; 0380377C
	str r0,[sp,#0x8]	; 0380377E
	ldr r0,[pool_03803850]	; 03803780
	strh r4,[r0,#0x0]	; 03803782
	b loc_0380378C	; 03803784
loc_03803786:
	mov r0,#0x1	; 03803786
	bl loc_0380491C	; 03803788
loc_0380378C:
	ldr r0,[pool_03803848]	; 0380378C
	ldrh r1,[r0,#0x0]	; 0380378E
	mov r0,#0x80	; 03803790
	and r1,r0	; 03803792
	cmp r1,#0x0	; 03803794
	bne loc_03803786	; 03803796
	ldr r0,[pool_03803850]	; 03803798
	ldrh r1,[r0,#0x0]	; 0380379A
	mov r0,#0xff	; 0380379C
	and r1,r0	; 0380379E
	lsl r0,r1,#0x10	; 038037A0
	lsr r0,r0,#0x10	; 038037A2
	ldr r1,[sp,#0x8]	; 038037A4
	orr r1,r0	; 038037A6
	str r1,[sp,#0x8]	; 038037A8
	ldr r0,[pool_03803854]	; 038037AA
	and r1,r0	; 038037AC
	str r1,[sp,#0x8]	; 038037AE
	asr r0,r1,#0x3	; 038037B0
	str r0,[sp,#0x10]	; 038037B2
	ldr r1,[sp,#0x18]	; 038037B4
	sub r1,r1,r0	; 038037B6
	ldr r0,[sp,#0xc]	; 038037B8
	cmp r1,r0	; 038037BA
	blt loc_038037F0	; 038037BC
	ldr r0,[sp,#0x0]	; 038037BE
	cmp r1,r0	; 038037C0
	bgt loc_038037F0	; 038037C2
	ldr r1,[sp,#0x1c]	; 038037C4
	ldr r0,[sp,#0x10]	; 038037C6
	sub r1,r1,r0	; 038037C8
	ldr r0,[sp,#0xc]	; 038037CA
	cmp r1,r0	; 038037CC
	blt loc_038037F0	; 038037CE
	ldr r0,[sp,#0x0]	; 038037D0
	cmp r1,r0	; 038037D2
	bgt loc_038037F0	; 038037D4
	add r0,r5,#0x1	; 038037D6
	mov r1,#0x2	; 038037D8
	bl loc_037FE348	; 038037DA
	lsl r1,r1,#0x2	; 038037DE
	add r0,sp,#0x18	; 038037E0
	ldr r1,[r0,r1]	; 038037E2
	ldr r0,[sp,#0x10]	; 038037E4
	add r0,r0,r1	; 038037E6
	asr r0,r0,#0x1	; 038037E8
	strh r0,[r6,#0x0]	; 038037EA
	mov r7,#0x0	; 038037EC
	b loc_03803808	; 038037EE
loc_038037F0:
	add r0,r5,#0x0	; 038037F0
	mov r1,#0x2	; 038037F2
	bl loc_037FE348	; 038037F4
	lsl r2,r1,#0x2	; 038037F8
	ldr r1,[sp,#0x10]	; 038037FA
	add r0,sp,#0x18	; 038037FC
	str r1,[r0,r2]	; 038037FE
	add r5,r5,#0x1	; 03803800
loc_03803802:
	ldr r0,[sp,#0x4]	; 03803802
	cmp r5,r0	; 03803804
	blt loc_03803758	; 03803806
loc_03803808:
	cmp r7,#0x0	; 03803808
	beq loc_03803816	; 0380380A
	ldr r1,[sp,#0x18]	; 0380380C
	ldr r0,[sp,#0x1c]	; 0380380E
	add r0,r1,r0	; 03803810
	asr r0,r0,#0x1	; 03803812
	strh r0,[r6,#0x0]	; 03803814
loc_03803816:
	ldr r0,[pool_03803858]	; 03803816
	ldr r4,[pool_03803848]	; 03803818
	strh r0,[r4,#0x0]	; 0380381A
	mov r1,#0x0	; 0380381C
	ldr r0,[pool_03803850]	; 0380381E
	strh r1,[r0,#0x0]	; 03803820
	mov r5,#0x80	; 03803822
	b loc_0380382C	; 03803824
loc_03803826:
	mov r0,#0x1	; 03803826
	bl loc_0380491C	; 03803828
loc_0380382C:
	ldrh r0,[r4,#0x0]	; 0380382C
	and r0,r5	; 0380382E
	cmp r0,#0x0	; 03803830
	bne loc_03803826	; 03803832
	ldrh r1,[r6,#0x0]	; 03803834
	mov r0,#0x7	; 03803836
	bic r1,r0	; 03803838
	strh r1,[r6,#0x0]	; 0380383A
	add r0,r7,#0x0	; 0380383C
	add sp,#0x24	; 0380383E
	pop {r4,r5,r6,r7}	; 03803840
	pop {r3}	; 03803842
	bx r3	; 03803844
	.byte 0xC0, 0x46	; 03803848
pool_03803848:
loc_03803848:
	.word REG_SPICNT	; 03803848
pool_0380384C:
loc_0380384C:
	.word 0x00008A01	; 0380384C
pool_03803850:
loc_03803850:
	.word REG_SPIDATA	; 03803850
pool_03803854:
loc_03803854:
	.word 0x00007FF8	; 03803854
pool_03803858:
loc_03803858:
	.word 0x00008201	; 03803858

; ===== function loc_0380385C =====
loc_0380385C:
	push {r4,r5,r6,lr}	; 0380385C
	ldr r0,[pool_03803978]	; 0380385E
	bl loc_03802198	; 03803860
	mov r6,#0x1	; 03803864
	ldr r5,[pool_0380397C]	; 03803866
	mov r4,#0x80	; 03803868
	b loc_03803872	; 0380386A
loc_0380386C:
	add r0,r6,#0x0	; 0380386C
	bl loc_0380491C	; 0380386E
loc_03803872:
	ldrh r0,[r5,#0x0]	; 03803872
	and r0,r4	; 03803874
	cmp r0,#0x0	; 03803876
	bne loc_0380386C	; 03803878
	ldr r0,[pool_03803980]	; 0380387A
	strh r0,[r5,#0x0]	; 0380387C
	mov r1,#0x84	; 0380387E
	ldr r0,[pool_03803984]	; 03803880
	strh r1,[r0,#0x0]	; 03803882
	mov r6,#0x1	; 03803884
	ldr r5,[pool_0380397C]	; 03803886
	mov r4,#0x80	; 03803888
	b loc_03803892	; 0380388A
loc_0380388C:
	add r0,r6,#0x0	; 0380388C
	bl loc_0380491C	; 0380388E
loc_03803892:
	ldrh r0,[r5,#0x0]	; 03803892
	and r0,r4	; 03803894
	cmp r0,#0x0	; 03803896
	bne loc_0380388C	; 03803898
	mov r1,#0x0	; 0380389A
	ldr r0,[pool_03803984]	; 0380389C
	strh r1,[r0,#0x0]	; 0380389E
	mov r6,#0x1	; 038038A0
	ldr r5,[pool_0380397C]	; 038038A2
	mov r4,#0x80	; 038038A4
	b loc_038038AE	; 038038A6
loc_038038A8:
	add r0,r6,#0x0	; 038038A8
	bl loc_0380491C	; 038038AA
loc_038038AE:
	ldrh r0,[r5,#0x0]	; 038038AE
	and r0,r4	; 038038B0
	cmp r0,#0x0	; 038038B2
	bne loc_038038A8	; 038038B4
	ldr r0,[pool_03803988]	; 038038B6
	strh r0,[r5,#0x0]	; 038038B8
	mov r1,#0x0	; 038038BA
	ldr r0,[pool_03803984]	; 038038BC
	strh r1,[r0,#0x0]	; 038038BE
	mov r6,#0x1	; 038038C0
	ldr r5,[pool_0380397C]	; 038038C2
	mov r4,#0x80	; 038038C4
	b loc_038038CE	; 038038C6
loc_038038C8:
	add r0,r6,#0x0	; 038038C8
	bl loc_0380491C	; 038038CA
loc_038038CE:
	ldrh r0,[r5,#0x0]	; 038038CE
	and r0,r4	; 038038D0
	cmp r0,#0x0	; 038038D2
	bne loc_038038C8	; 038038D4
	ldr r0,[pool_0380398C]	; 038038D6
	ldrh r0,[r0,#0x0]	; 038038D8
	cmp r0,#0x0	; 038038DA
	bne loc_038038F2	; 038038DC
	ldr r0,[pool_03803990]	; 038038DE
	ldrh r1,[r0,#0x0]	; 038038E0
	mov r0,#0x40	; 038038E2
	and r1,r0	; 038038E4
	cmp r1,#0x0	; 038038E6
	bne loc_038038EE	; 038038E8
	mov r0,#0x1	; 038038EA
	b loc_03803970	; 038038EC
loc_038038EE:
	mov r0,#0x0	; 038038EE
	b loc_03803970	; 038038F0
loc_038038F2:
	ldr r0,[pool_03803990]	; 038038F2
	ldrh r1,[r0,#0x0]	; 038038F4
	mov r0,#0x40	; 038038F6
	and r1,r0	; 038038F8
	cmp r1,#0x0	; 038038FA
	bne loc_03803902	; 038038FC
	mov r0,#0x1	; 038038FE
	b loc_03803970	; 03803900
loc_03803902:
	ldr r0,[pool_03803980]	; 03803902
	strh r0,[r5,#0x0]	; 03803904
	mov r1,#0x84	; 03803906
	ldr r0,[pool_03803984]	; 03803908
	strh r1,[r0,#0x0]	; 0380390A
	mov r6,#0x1	; 0380390C
	ldr r5,[pool_0380397C]	; 0380390E
	mov r4,#0x80	; 03803910
	b loc_0380391A	; 03803912
loc_03803914:
	add r0,r6,#0x0	; 03803914
	bl loc_0380491C	; 03803916
loc_0380391A:
	ldrh r0,[r5,#0x0]	; 0380391A
	and r0,r4	; 0380391C
	cmp r0,#0x0	; 0380391E
	bne loc_03803914	; 03803920
	mov r1,#0x0	; 03803922
	ldr r0,[pool_03803984]	; 03803924
	strh r1,[r0,#0x0]	; 03803926
	mov r6,#0x1	; 03803928
	ldr r5,[pool_0380397C]	; 0380392A
	mov r4,#0x80	; 0380392C
	b loc_03803936	; 0380392E
loc_03803930:
	add r0,r6,#0x0	; 03803930
	bl loc_0380491C	; 03803932
loc_03803936:
	ldrh r0,[r5,#0x0]	; 03803936
	and r0,r4	; 03803938
	cmp r0,#0x0	; 0380393A
	bne loc_03803930	; 0380393C
	ldr r0,[pool_03803988]	; 0380393E
	strh r0,[r5,#0x0]	; 03803940
	mov r1,#0x0	; 03803942
	ldr r0,[pool_03803984]	; 03803944
	strh r1,[r0,#0x0]	; 03803946
	mov r6,#0x1	; 03803948
	ldr r5,[pool_0380397C]	; 0380394A
	mov r4,#0x80	; 0380394C
	b loc_03803956	; 0380394E
loc_03803950:
	add r0,r6,#0x0	; 03803950
	bl loc_0380491C	; 03803952
loc_03803956:
	ldrh r0,[r5,#0x0]	; 03803956
	and r0,r4	; 03803958
	cmp r0,#0x0	; 0380395A
	bne loc_03803950	; 0380395C
	ldr r0,[pool_03803990]	; 0380395E
	ldrh r1,[r0,#0x0]	; 03803960
	mov r0,#0x40	; 03803962
	and r1,r0	; 03803964
	cmp r1,#0x0	; 03803966
	beq loc_0380396E	; 03803968
	mov r0,#0x0	; 0380396A
	b loc_03803970	; 0380396C
loc_0380396E:
	mov r0,#0x2	; 0380396E
loc_03803970:
	pop {r4,r5,r6}	; 03803970
	pop {r3}	; 03803972
	bx r3	; 03803974
	.byte 0xC0, 0x46	; 03803978
pool_03803978:
loc_03803978:
	.word 0x00008000	; 03803978
pool_0380397C:
loc_0380397C:
	.word REG_SPICNT	; 0380397C
pool_03803980:
loc_03803980:
	.word 0x00008A01	; 03803980
pool_03803984:
loc_03803984:
	.word REG_SPIDATA	; 03803984
pool_03803988:
loc_03803988:
	.word 0x00008201	; 03803988
pool_0380398C:
loc_0380398C:
	.word P2_BssStart + 0x2674	; 0380398C
pool_03803990:
loc_03803990:
	.word REG_KEYXY	; 03803990
P2_Entry_03803994:
	push {lr}	; 03803994
	sub sp,#0x4	; 03803996
	add r0,sp,#0x0	; 03803998
	bl loc_03804098	; 0380399A
	add r0,sp,#0x0	; 0380399E
	ldrh r2,[r0,#0x0]	; 038039A0
	mov r0,#0x1	; 038039A2
	add r1,r2,#0x0	; 038039A4
	and r1,r0	; 038039A6
	cmp r1,#0x0	; 038039A8
	beq P2_Entry_038039B0	; 038039AA
	mov r0,#0x0	; 038039AC
	b P2_Entry_038039BA	; 038039AE
P2_Entry_038039B0:
	mov r1,#0x2	; 038039B0
	and r2,r1	; 038039B2
	cmp r2,#0x0	; 038039B4
	bne P2_Entry_038039BA	; 038039B6
	mov r0,#0x0	; 038039B8
P2_Entry_038039BA:
	add sp,#0x4	; 038039BA
	pop {r3}	; 038039BC
	bx r3	; 038039BE
P2_Entry_038039C0:
	push {lr}	; 038039C0
	sub sp,#0x4	; 038039C2
	add r0,sp,#0x0	; 038039C4
	bl loc_03804098	; 038039C6
	add r0,sp,#0x0	; 038039CA
	ldrh r1,[r0,#0x0]	; 038039CC
	mov r0,#0x1	; 038039CE
	and r1,r0	; 038039D0
	cmp r1,#0x0	; 038039D2
	beq P2_Entry_038039D8	; 038039D4
	mov r0,#0x0	; 038039D6
P2_Entry_038039D8:
	add sp,#0x4	; 038039D8
	pop {r3}	; 038039DA
	bx r3	; 038039DC
	.byte 0x00, 0x00	; 038039DE
P2_Entry_038039E0:
	push {r4,r5,lr}	; 038039E0
	sub sp,#0x4	; 038039E2
	add r4,r0,#0x0	; 038039E4
	bl loc_037FDD34	; 038039E6
	add r5,r0,#0x0	; 038039EA
	mov r0,#0x1	; 038039EC
	bl P2_Entry_03802EC4	; 038039EE
	cmp r0,#0x0	; 038039F2
	bne P2_Entry_03803A0A	; 038039F4
	add r0,r5,#0x0	; 038039F6
	bl loc_037FDD58	; 038039F8
	ldr r0,[r4,#0x4]	; 038039FC
	lsl r0,r0,#0x10	; 038039FE
	lsr r0,r0,#0x10	; 03803A00
	mov r1,#0x4	; 03803A02
	bl loc_03802ED8	; 03803A04
	b P2_Entry_03803B2A	; 03803A08
P2_Entry_03803A0A:
	mov r0,#0x1	; 03803A0A
	bl loc_03802EB4	; 03803A0C
	add r0,r5,#0x0	; 03803A10
	bl loc_037FDD58	; 03803A12
	ldr r0,[r4,#0x4]	; 03803A16
	sub r0,#0x20	; 03803A18
	cmp r0,#0xd	; 03803A1A
	bhi P2_Entry_03803B04	; 03803A1C
	add r0,r0,r0	; 03803A1E
P2_SwitchIndexPC_03803A1E:
	add r0,pc	; 03803A20
	ldrh r0,[r0,#(P2_SwitchTable_03803A1E - (P2_SwitchIndexPC_03803A1E + 4))]	; 03803A22
	lsl r0,r0,#0x10	; 03803A24
	asr r0,r0,#0x10	; 03803A26
P2_SwitchTargetPC_03803A1E:
	add r0,pc	; 03803A28
	bx r0	; 03803A2A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803A1E:
	.halfword (P2_Case_03803A48 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803A4E + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803A54 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803A5C + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Entry_03803B04 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803A84 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Entry_03803B04 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803AB0 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Entry_03803B04 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Entry_03803B04 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Entry_03803B04 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803AD4 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803AF6 + 1) - (P2_SwitchTargetPC_03803A1E + 4)
	.halfword (P2_Case_03803AFE + 1) - (P2_SwitchTargetPC_03803A1E + 4)
P2_SwitchTable_03803A1EEnd:
P2_Case_03803A48:
	bl P2_Entry_03804164	; 03803A48
	b P2_Entry_03803B18	; 03803A4C
P2_Case_03803A4E:
	bl P2_Entry_03804118	; 03803A4E
	b P2_Entry_03803B18	; 03803A52
P2_Case_03803A54:
	ldr r0,[r4,#0x10]	; 03803A54
	bl loc_03804098	; 03803A56
	b P2_Entry_03803B18	; 03803A5A
P2_Case_03803A5C:
	bl P2_Entry_038039C0	; 03803A5C
	cmp r0,#0x0	; 03803A60
	bne P2_Entry_03803A78	; 03803A62
	ldr r0,[r4,#0x4]	; 03803A64
	lsl r0,r0,#0x10	; 03803A66
	lsr r0,r0,#0x10	; 03803A68
	mov r1,#0x3	; 03803A6A
	bl loc_03802ED8	; 03803A6C
	mov r0,#0x1	; 03803A70
	bl P2_Entry_03802E8C	; 03803A72
	b P2_Entry_03803B2A	; 03803A76
P2_Entry_03803A78:
	ldr r0,[r4,#0x8]	; 03803A78
	ldr r1,[r4,#0xc]	; 03803A7A
	ldr r2,[r4,#0x10]	; 03803A7C
	bl loc_03803F9C	; 03803A7E
	b P2_Entry_03803B18	; 03803A82
P2_Case_03803A84:
	bl P2_Entry_03803994	; 03803A84
	cmp r0,#0x0	; 03803A88
	bne P2_Entry_03803AA0	; 03803A8A
	ldr r0,[r4,#0x4]	; 03803A8C
	lsl r0,r0,#0x10	; 03803A8E
	lsr r0,r0,#0x10	; 03803A90
	mov r1,#0x3	; 03803A92
	bl loc_03802ED8	; 03803A94
	mov r0,#0x1	; 03803A98
	bl P2_Entry_03802E8C	; 03803A9A
	b P2_Entry_03803B2A	; 03803A9E
P2_Entry_03803AA0:
	ldr r0,[r4,#0x8]	; 03803AA0
	ldr r1,[r4,#0xc]	; 03803AA2
	lsl r1,r1,#0x10	; 03803AA4
	lsr r1,r1,#0x10	; 03803AA6
	ldr r2,[r4,#0x10]	; 03803AA8
	bl P2_Entry_03803E90	; 03803AAA
	b P2_Entry_03803B18	; 03803AAE
P2_Case_03803AB0:
	bl P2_Entry_03803994	; 03803AB0
	cmp r0,#0x0	; 03803AB4
	bne P2_Entry_03803ACC	; 03803AB6
	ldr r0,[r4,#0x4]	; 03803AB8
	lsl r0,r0,#0x10	; 03803ABA
	lsr r0,r0,#0x10	; 03803ABC
	mov r1,#0x3	; 03803ABE
	bl loc_03802ED8	; 03803AC0
	mov r0,#0x1	; 03803AC4
	bl P2_Entry_03802E8C	; 03803AC6
	b P2_Entry_03803B2A	; 03803ACA
P2_Entry_03803ACC:
	ldr r0,[r4,#0x8]	; 03803ACC
	bl P2_Entry_03803DC0	; 03803ACE
	b P2_Entry_03803B18	; 03803AD2
P2_Case_03803AD4:
	bl P2_Entry_03803994	; 03803AD4
	cmp r0,#0x0	; 03803AD8
	bne P2_Entry_03803AF0	; 03803ADA
	ldr r0,[r4,#0x4]	; 03803ADC
	lsl r0,r0,#0x10	; 03803ADE
	lsr r0,r0,#0x10	; 03803AE0
	mov r1,#0x3	; 03803AE2
	bl loc_03802ED8	; 03803AE4
	mov r0,#0x1	; 03803AE8
	bl P2_Entry_03802E8C	; 03803AEA
	b P2_Entry_03803B2A	; 03803AEE
P2_Entry_03803AF0:
	bl P2_Entry_03803D74	; 03803AF0
	b P2_Entry_03803B18	; 03803AF4
P2_Case_03803AF6:
	ldr r0,[r4,#0x10]	; 03803AF6
	bl P2_Entry_03803CD0	; 03803AF8
	b P2_Entry_03803B18	; 03803AFC
P2_Case_03803AFE:
	bl P2_Entry_03803C84	; 03803AFE
	b P2_Entry_03803B18	; 03803B02
P2_Entry_03803B04:
	mov r0,#0x1	; 03803B04
	bl P2_Entry_03802E8C	; 03803B06
	ldr r0,[r4,#0x4]	; 03803B0A
	lsl r0,r0,#0x10	; 03803B0C
	lsr r0,r0,#0x10	; 03803B0E
	mov r1,#0x1	; 03803B10
	bl loc_03802ED8	; 03803B12
	b P2_Entry_03803B2A	; 03803B16
P2_Entry_03803B18:
	ldr r0,[r4,#0x4]	; 03803B18
	lsl r0,r0,#0x10	; 03803B1A
	lsr r0,r0,#0x10	; 03803B1C
	mov r1,#0x0	; 03803B1E
	bl loc_03802ED8	; 03803B20
	mov r0,#0x1	; 03803B24
	bl P2_Entry_03802E8C	; 03803B26
P2_Entry_03803B2A:
	add sp,#0x4	; 03803B2A
	pop {r4,r5}	; 03803B2C
	pop {r3}	; 03803B2E
	bx r3	; 03803B30
	.byte 0x00, 0x00	; 03803B32

; ===== function loc_03803B34 =====
loc_03803B34:
	push {r4,r5,r6,r7,lr}	; 03803B34
	sub sp,#0xc	; 03803B36
	ldr r1,[pool_03803C54]	; 03803B38
	add r5,r0,#0x0	; 03803B3A
	and r5,r1	; 03803B3C
	cmp r5,#0x0	; 03803B3E
	beq loc_03803B52	; 03803B40
	mov r5,#0x0	; 03803B42
	add r6,r5,#0x0	; 03803B44
	ldr r7,[pool_03803C58]	; 03803B46
loc_03803B48:
	lsl r1,r5,#0x1	; 03803B48
	strh r6,[r7,r1]	; 03803B4A
	add r5,r5,#0x1	; 03803B4C
	cmp r5,#0x10	; 03803B4E
	blt loc_03803B48	; 03803B50
loc_03803B52:
	ldr r1,[pool_03803C5C]	; 03803B52
	add r5,r0,#0x0	; 03803B54
	and r5,r1	; 03803B56
	lsr r1,r5,#0x10	; 03803B58
	lsl r5,r1,#0x1	; 03803B5A
	ldr r1,[pool_03803C58]	; 03803B5C
	strh r0,[r1,r5]	; 03803B5E
	ldr r5,[pool_03803C60]	; 03803B60
	and r0,r5	; 03803B62
	cmp r0,#0x0	; 03803B64
	beq loc_03803C4C	; 03803B66
	ldrh r0,[r1,#0x0]	; 03803B68
	ldr r7,[pool_03803C64]	; 03803B6A
	add r5,r0,#0x0	; 03803B6C
	and r5,r7	; 03803B6E
	lsl r5,r5,#0x8	; 03803B70
	lsr r6,r5,#0x10	; 03803B72
	add r5,r6,#0x0	; 03803B74
	sub r5,#0x22	; 03803B76
	cmp r5,#0xa	; 03803B78
	bhi loc_03803C32	; 03803B7A
	add r5,r5,r5	; 03803B7C
P2_SwitchIndexPC_03803B7C:
	add r5,pc	; 03803B7E
	ldrh r5,[r5,#(P2_SwitchTable_03803B7C - (P2_SwitchIndexPC_03803B7C + 4))]	; 03803B80
	lsl r5,r5,#0x10	; 03803B82
	asr r5,r5,#0x10	; 03803B84
P2_SwitchTargetPC_03803B7C:
	add r5,pc	; 03803B86
	bx r5	; 03803B88
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803B7C:
	.halfword (loc_03803BA0 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803BCA + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C32 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803BFC + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C32 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C28 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C32 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C32 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C32 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803C32 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
	.halfword (loc_03803BA0 + 1) - (P2_SwitchTargetPC_03803B7C + 4)
P2_SwitchTable_03803B7CEnd:
loc_03803BA0:
	ldrh r4,[r1,#0x4]	; 03803BA0
	and r4,r7	; 03803BA2
	lsr r4,r4,#0x8	; 03803BA4
	mov r5,#0xff	; 03803BA6
	and r0,r5	; 03803BA8
	lsl r0,r0,#0x18	; 03803BAA
	ldrh r1,[r1,#0x2]	; 03803BAC
	lsl r1,r1,#0x8	; 03803BAE
	orr r0,r1	; 03803BB0
	orr r4,r0	; 03803BB2
	ldr r0,[pool_03803C54]	; 03803BB4
	cmp r4,r0	; 03803BB6
	bcc loc_03803BC0	; 03803BB8
	ldr r0,[pool_03803C68]	; 03803BBA
	cmp r4,r0	; 03803BBC
	bcc loc_03803C32	; 03803BBE
loc_03803BC0:
	add r0,r6,#0x0	; 03803BC0
	mov r1,#0x2	; 03803BC2
	bl loc_03802ED8	; 03803BC4
	b loc_03803C4C	; 03803BC8
loc_03803BCA:
	ldrh r2,[r1,#0x8]	; 03803BCA
	lsl r4,r2,#0x10	; 03803BCC
	ldrh r2,[r1,#0xa]	; 03803BCE
	orr r4,r2	; 03803BD0
	ldr r2,[pool_03803C54]	; 03803BD2
	cmp r4,r2	; 03803BD4
	bcc loc_03803BDE	; 03803BD6
	ldr r2,[pool_03803C68]	; 03803BD8
	cmp r4,r2	; 03803BDA
	bcc loc_03803BE8	; 03803BDC
loc_03803BDE:
	add r0,r6,#0x0	; 03803BDE
	mov r1,#0x2	; 03803BE0
	bl loc_03802ED8	; 03803BE2
	b loc_03803C4C	; 03803BE6
loc_03803BE8:
	mov r2,#0xff	; 03803BE8
	and r0,r2	; 03803BEA
	lsl r3,r0,#0x10	; 03803BEC
	ldrh r0,[r1,#0x2]	; 03803BEE
	orr r3,r0	; 03803BF0
	ldrh r0,[r1,#0x4]	; 03803BF2
	lsl r2,r0,#0x10	; 03803BF4
	ldrh r0,[r1,#0x6]	; 03803BF6
	orr r2,r0	; 03803BF8
	b loc_03803C32	; 03803BFA
loc_03803BFC:
	ldrh r2,[r1,#0x6]	; 03803BFC
	lsl r4,r2,#0x10	; 03803BFE
	ldrh r2,[r1,#0x8]	; 03803C00
	orr r4,r2	; 03803C02
	ldr r2,[pool_03803C54]	; 03803C04
	cmp r4,r2	; 03803C06
	bcc loc_03803C10	; 03803C08
	ldr r2,[pool_03803C68]	; 03803C0A
	cmp r4,r2	; 03803C0C
	bcc loc_03803C1A	; 03803C0E
loc_03803C10:
	add r0,r6,#0x0	; 03803C10
	mov r1,#0x2	; 03803C12
	bl loc_03802ED8	; 03803C14
	b loc_03803C4C	; 03803C18
loc_03803C1A:
	mov r2,#0xff	; 03803C1A
	and r0,r2	; 03803C1C
	lsl r3,r0,#0x10	; 03803C1E
	ldrh r0,[r1,#0x2]	; 03803C20
	orr r3,r0	; 03803C22
	ldrh r2,[r1,#0x4]	; 03803C24
	b loc_03803C32	; 03803C26
loc_03803C28:
	mov r3,#0xff	; 03803C28
	and r0,r3	; 03803C2A
	lsl r3,r0,#0x10	; 03803C2C
	ldrh r0,[r1,#0x2]	; 03803C2E
	orr r3,r0	; 03803C30
loc_03803C32:
	str r2,[sp,#0x0]	; 03803C32
	str r4,[sp,#0x4]	; 03803C34
	mov r0,#0x1	; 03803C36
	add r1,r6,#0x0	; 03803C38
	mov r2,#0x3	; 03803C3A
	bl loc_03802DE4	; 03803C3C
	cmp r0,#0x0	; 03803C40
	bne loc_03803C4C	; 03803C42
	add r0,r6,#0x0	; 03803C44
	mov r1,#0x4	; 03803C46
	bl loc_03802ED8	; 03803C48
loc_03803C4C:
	add sp,#0xc	; 03803C4C
	pop {r4,r5,r6,r7}	; 03803C4E
	pop {r3}	; 03803C50
	bx r3	; 03803C52
pool_03803C54:
loc_03803C54:
	.word 0x02000000	; 03803C54
pool_03803C58:
loc_03803C58:
	.word P2_BssStart + 0x2678	; 03803C58
pool_03803C5C:
loc_03803C5C:
	.word 0x000F0000	; 03803C5C
pool_03803C60:
loc_03803C60:
	.word 0x01000000	; 03803C60
pool_03803C64:
loc_03803C64:
	.word 0x0000FF00	; 03803C64
pool_03803C68:
loc_03803C68:
	.word 0x02400000	; 03803C68

; ===== function loc_03803C6C =====
loc_03803C6C:
	mov r3,#0x0	; 03803C6C
	add r2,r3,#0x0	; 03803C6E
	ldr r0,[pool_03803C80]	; 03803C70
loc_03803C72:
	lsl r1,r3,#0x1	; 03803C72
	strh r2,[r0,r1]	; 03803C74
	add r3,r3,#0x1	; 03803C76
	cmp r3,#0x10	; 03803C78
	blt loc_03803C72	; 03803C7A
	bx lr	; 03803C7C
	.byte 0xC0, 0x46	; 03803C80
pool_03803C80:
loc_03803C80:
	.word P2_BssStart + 0x2678	; 03803C80
P2_Entry_03803C84:
	push {r4,r5,r6,lr}	; 03803C84
	mov r6,#0x1	; 03803C86
	ldr r5,[pool_03803CC4]	; 03803C88
	mov r4,#0x80	; 03803C8A
	b P2_Entry_03803C94	; 03803C8C
P2_Entry_03803C8E:
	add r0,r6,#0x0	; 03803C8E
	bl P2_SwiWaitByLoop	; 03803C90
P2_Entry_03803C94:
	ldrh r0,[r5,#0x0]	; 03803C94
	and r0,r4	; 03803C96
	cmp r0,#0x0	; 03803C98
	bne P2_Entry_03803C8E	; 03803C9A
	ldr r0,[pool_03803CC8]	; 03803C9C
	strh r0,[r5,#0x0]	; 03803C9E
	mov r1,#0xff	; 03803CA0
	ldr r0,[pool_03803CCC]	; 03803CA2
	strh r1,[r0,#0x0]	; 03803CA4
	mov r6,#0x1	; 03803CA6
	ldr r5,[pool_03803CC4]	; 03803CA8
	mov r4,#0x80	; 03803CAA
	b P2_Entry_03803CB4	; 03803CAC
P2_Entry_03803CAE:
	add r0,r6,#0x0	; 03803CAE
	bl P2_SwiWaitByLoop	; 03803CB0
P2_Entry_03803CB4:
	ldrh r0,[r5,#0x0]	; 03803CB4
	and r0,r4	; 03803CB6
	cmp r0,#0x0	; 03803CB8
	bne P2_Entry_03803CAE	; 03803CBA
	pop {r4,r5,r6}	; 03803CBC
	pop {r3}	; 03803CBE
	bx r3	; 03803CC0
	.byte 0xC0, 0x46	; 03803CC2
pool_03803CC4:
	.word REG_SPICNT	; 03803CC4
pool_03803CC8:
	.word 0x00008100	; 03803CC8
pool_03803CCC:
	.word REG_SPIDATA	; 03803CCC
P2_Entry_03803CD0:
	push {r4,r5,r6,r7,lr}	; 03803CD0
	sub sp,#0x4	; 03803CD2
	add r5,r0,#0x0	; 03803CD4
	mov r7,#0x1	; 03803CD6
	ldr r4,[pool_03803D64]	; 03803CD8
	mov r6,#0x80	; 03803CDA
	b P2_Entry_03803CE4	; 03803CDC
P2_Entry_03803CDE:
	add r0,r7,#0x0	; 03803CDE
	bl P2_SwiWaitByLoop	; 03803CE0
P2_Entry_03803CE4:
	ldrh r0,[r4,#0x0]	; 03803CE4
	and r0,r6	; 03803CE6
	cmp r0,#0x0	; 03803CE8
	bne P2_Entry_03803CDE	; 03803CEA
	ldr r0,[pool_03803D68]	; 03803CEC
	strh r0,[r4,#0x0]	; 03803CEE
	mov r1,#0x9f	; 03803CF0
	ldr r0,[pool_03803D6C]	; 03803CF2
	strh r1,[r0,#0x0]	; 03803CF4
	mov r7,#0x1	; 03803CF6
	ldr r4,[pool_03803D64]	; 03803CF8
	mov r6,#0x80	; 03803CFA
	b P2_Entry_03803D04	; 03803CFC
P2_Entry_03803CFE:
	add r0,r7,#0x0	; 03803CFE
	bl P2_SwiWaitByLoop	; 03803D00
P2_Entry_03803D04:
	ldrh r0,[r4,#0x0]	; 03803D04
	and r0,r6	; 03803D06
	cmp r0,#0x0	; 03803D08
	bne P2_Entry_03803CFE	; 03803D0A
	mov r1,#0x0	; 03803D0C
	ldr r0,[pool_03803D6C]	; 03803D0E
	strh r1,[r0,#0x0]	; 03803D10
	mov r7,#0x1	; 03803D12
	ldr r4,[pool_03803D64]	; 03803D14
	mov r6,#0x80	; 03803D16
	b P2_Entry_03803D20	; 03803D18
P2_Entry_03803D1A:
	add r0,r7,#0x0	; 03803D1A
	bl P2_SwiWaitByLoop	; 03803D1C
P2_Entry_03803D20:
	ldrh r0,[r4,#0x0]	; 03803D20
	and r0,r6	; 03803D22
	cmp r0,#0x0	; 03803D24
	bne P2_Entry_03803D1A	; 03803D26
	ldr r1,[pool_03803D6C]	; 03803D28
	ldrh r2,[r1,#0x0]	; 03803D2A
	mov r0,#0xff	; 03803D2C
	and r2,r0	; 03803D2E
	strb r2,[r5,#0x0]	; 03803D30
	ldr r0,[pool_03803D70]	; 03803D32
	strh r0,[r4,#0x0]	; 03803D34
	mov r0,#0x0	; 03803D36
	strh r0,[r1,#0x0]	; 03803D38
	mov r7,#0x1	; 03803D3A
	ldr r4,[pool_03803D64]	; 03803D3C
	mov r6,#0x80	; 03803D3E
	b P2_Entry_03803D48	; 03803D40
P2_Entry_03803D42:
	add r0,r7,#0x0	; 03803D42
	bl P2_SwiWaitByLoop	; 03803D44
P2_Entry_03803D48:
	ldrh r0,[r4,#0x0]	; 03803D48
	and r0,r6	; 03803D4A
	cmp r0,#0x0	; 03803D4C
	bne P2_Entry_03803D42	; 03803D4E
	ldr r0,[pool_03803D6C]	; 03803D50
	ldrh r1,[r0,#0x0]	; 03803D52
	mov r0,#0xff	; 03803D54
	and r1,r0	; 03803D56
	strb r1,[r5,#0x1]	; 03803D58
	add sp,#0x4	; 03803D5A
	pop {r4,r5,r6,r7}	; 03803D5C
	pop {r3}	; 03803D5E
	bx r3	; 03803D60
	.byte 0xC0, 0x46	; 03803D62
pool_03803D64:
	.word REG_SPICNT	; 03803D64
pool_03803D68:
	.word 0x00008900	; 03803D68
pool_03803D6C:
	.word REG_SPIDATA	; 03803D6C
pool_03803D70:
	.word 0x00008100	; 03803D70
P2_Entry_03803D74:
	push {r4,r5,r6,lr}	; 03803D74
	mov r6,#0x1	; 03803D76
	ldr r5,[pool_03803DB4]	; 03803D78
	mov r4,#0x80	; 03803D7A
	b P2_Entry_03803D84	; 03803D7C
P2_Entry_03803D7E:
	add r0,r6,#0x0	; 03803D7E
	bl P2_SwiWaitByLoop	; 03803D80
P2_Entry_03803D84:
	ldrh r0,[r5,#0x0]	; 03803D84
	and r0,r4	; 03803D86
	cmp r0,#0x0	; 03803D88
	bne P2_Entry_03803D7E	; 03803D8A
	ldr r0,[pool_03803DB8]	; 03803D8C
	strh r0,[r5,#0x0]	; 03803D8E
	mov r1,#0xc7	; 03803D90
	ldr r0,[pool_03803DBC]	; 03803D92
	strh r1,[r0,#0x0]	; 03803D94
	mov r6,#0x1	; 03803D96
	ldr r5,[pool_03803DB4]	; 03803D98
	mov r4,#0x80	; 03803D9A
	b P2_Entry_03803DA4	; 03803D9C
P2_Entry_03803D9E:
	add r0,r6,#0x0	; 03803D9E
	bl P2_SwiWaitByLoop	; 03803DA0
P2_Entry_03803DA4:
	ldrh r0,[r5,#0x0]	; 03803DA4
	and r0,r4	; 03803DA6
	cmp r0,#0x0	; 03803DA8
	bne P2_Entry_03803D9E	; 03803DAA
	pop {r4,r5,r6}	; 03803DAC
	pop {r3}	; 03803DAE
	bx r3	; 03803DB0
	.byte 0xC0, 0x46	; 03803DB2
pool_03803DB4:
	.word REG_SPICNT	; 03803DB4
pool_03803DB8:
	.word 0x00008100	; 03803DB8
pool_03803DBC:
	.word REG_SPIDATA	; 03803DBC
P2_Entry_03803DC0:
	push {r4,r5,r6,r7,lr}	; 03803DC0
	sub sp,#0x4	; 03803DC2
	ldr r1,[pool_03803E78]	; 03803DC4
	add r2,r0,#0x0	; 03803DC6
	and r2,r1	; 03803DC8
	lsr r1,r2,#0x10	; 03803DCA
	lsl r1,r1,#0x10	; 03803DCC
	lsr r5,r1,#0x10	; 03803DCE
	ldr r1,[pool_03803E7C]	; 03803DD0
	add r2,r0,#0x0	; 03803DD2
	and r2,r1	; 03803DD4
	lsl r1,r2,#0x8	; 03803DD6
	lsr r4,r1,#0x10	; 03803DD8
	mov r1,#0xff	; 03803DDA
	and r0,r1	; 03803DDC
	lsl r0,r0,#0x10	; 03803DDE
	lsr r6,r0,#0x10	; 03803DE0
	ldr r7,[pool_03803E80]	; 03803DE2
	b P2_Entry_03803DEC	; 03803DE4
P2_Entry_03803DE6:
	mov r0,#0x1	; 03803DE6
	bl P2_SwiWaitByLoop	; 03803DE8
P2_Entry_03803DEC:
	ldrh r1,[r7,#0x0]	; 03803DEC
	mov r0,#0x80	; 03803DEE
	and r1,r0	; 03803DF0
	cmp r1,#0x0	; 03803DF2
	bne P2_Entry_03803DE6	; 03803DF4
	ldr r0,[pool_03803E84]	; 03803DF6
	strh r0,[r7,#0x0]	; 03803DF8
	mov r1,#0xdb	; 03803DFA
	ldr r0,[pool_03803E88]	; 03803DFC
	strh r1,[r0,#0x0]	; 03803DFE
	ldr r7,[pool_03803E80]	; 03803E00
	b P2_Entry_03803E0A	; 03803E02
P2_Entry_03803E04:
	mov r0,#0x1	; 03803E04
	bl P2_SwiWaitByLoop	; 03803E06
P2_Entry_03803E0A:
	ldrh r1,[r7,#0x0]	; 03803E0A
	mov r0,#0x80	; 03803E0C
	and r1,r0	; 03803E0E
	cmp r1,#0x0	; 03803E10
	bne P2_Entry_03803E04	; 03803E12
	mov r0,#0xff	; 03803E14
	and r5,r0	; 03803E16
	ldr r0,[pool_03803E88]	; 03803E18
	strh r5,[r0,#0x0]	; 03803E1A
	ldr r5,[pool_03803E80]	; 03803E1C
	mov r7,#0x80	; 03803E1E
	b P2_Entry_03803E28	; 03803E20
P2_Entry_03803E22:
	mov r0,#0x1	; 03803E22
	bl P2_SwiWaitByLoop	; 03803E24
P2_Entry_03803E28:
	ldrh r0,[r5,#0x0]	; 03803E28
	and r0,r7	; 03803E2A
	cmp r0,#0x0	; 03803E2C
	bne P2_Entry_03803E22	; 03803E2E
	mov r0,#0xff	; 03803E30
	and r4,r0	; 03803E32
	ldr r0,[pool_03803E88]	; 03803E34
	strh r4,[r0,#0x0]	; 03803E36
	mov r7,#0x1	; 03803E38
	ldr r4,[pool_03803E80]	; 03803E3A
	mov r5,#0x80	; 03803E3C
	b P2_Entry_03803E46	; 03803E3E
P2_Entry_03803E40:
	add r0,r7,#0x0	; 03803E40
	bl P2_SwiWaitByLoop	; 03803E42
P2_Entry_03803E46:
	ldrh r0,[r4,#0x0]	; 03803E46
	and r0,r5	; 03803E48
	cmp r0,#0x0	; 03803E4A
	bne P2_Entry_03803E40	; 03803E4C
	ldr r0,[pool_03803E8C]	; 03803E4E
	strh r0,[r4,#0x0]	; 03803E50
	mov r0,#0xff	; 03803E52
	and r6,r0	; 03803E54
	ldr r0,[pool_03803E88]	; 03803E56
	strh r6,[r0,#0x0]	; 03803E58
	mov r6,#0x1	; 03803E5A
	ldr r5,[pool_03803E80]	; 03803E5C
	mov r4,#0x80	; 03803E5E
	b P2_Entry_03803E68	; 03803E60
P2_Entry_03803E62:
	add r0,r6,#0x0	; 03803E62
	bl P2_SwiWaitByLoop	; 03803E64
P2_Entry_03803E68:
	ldrh r0,[r5,#0x0]	; 03803E68
	and r0,r4	; 03803E6A
	cmp r0,#0x0	; 03803E6C
	bne P2_Entry_03803E62	; 03803E6E
	add sp,#0x4	; 03803E70
	pop {r4,r5,r6,r7}	; 03803E72
	pop {r3}	; 03803E74
	bx r3	; 03803E76
pool_03803E78:
	.word 0x00FF0000	; 03803E78
pool_03803E7C:
	.word 0x0000FF00	; 03803E7C
pool_03803E80:
	.word REG_SPICNT	; 03803E80
pool_03803E84:
	.word 0x00008900	; 03803E84
pool_03803E88:
	.word REG_SPIDATA	; 03803E88
pool_03803E8C:
	.word 0x00008100	; 03803E8C
P2_Entry_03803E90:
	push {r4,r5,r6,r7,lr}	; 03803E90
	sub sp,#0xc	; 03803E92
	add r4,r1,#0x0	; 03803E94
	add r6,r2,#0x0	; 03803E96
	cmp r4,#0x1	; 03803E98
	bcc P2_Entry_03803F78	; 03803E9A
	add r1,r0,r4	; 03803E9C
	sub r1,r1,#0x1	; 03803E9E
	lsr r2,r1,#0x8	; 03803EA0
	lsr r1,r0,#0x8	; 03803EA2
	cmp r2,r1	; 03803EA4
	bls P2_Entry_03803EB6	; 03803EA6
	mov r1,#0xff	; 03803EA8
	add r2,r0,#0x0	; 03803EAA
	and r2,r1	; 03803EAC
	ldr r1,[pool_03803F80]	; 03803EAE
	sub r1,r1,r2	; 03803EB0
	lsl r1,r1,#0x10	; 03803EB2
	lsr r4,r1,#0x10	; 03803EB4
P2_Entry_03803EB6:
	ldr r1,[pool_03803F84]	; 03803EB6
	add r2,r0,#0x0	; 03803EB8
	and r2,r1	; 03803EBA
	lsr r1,r2,#0x10	; 03803EBC
	add r2,sp,#0x0	; 03803EBE
	strh r1,[r2,#0x0]	; 03803EC0
	ldr r1,[pool_03803F88]	; 03803EC2
	add r3,r0,#0x0	; 03803EC4
	and r3,r1	; 03803EC6
	lsr r1,r3,#0x8	; 03803EC8
	strh r1,[r2,#0x2]	; 03803ECA
	mov r1,#0xff	; 03803ECC
	and r0,r1	; 03803ECE
	strh r0,[r2,#0x4]	; 03803ED0
	ldr r5,[pool_03803F8C]	; 03803ED2
	mov r7,#0x80	; 03803ED4
	b P2_Entry_03803EDE	; 03803ED6
P2_Entry_03803ED8:
	mov r0,#0x1	; 03803ED8
	bl P2_SwiWaitByLoop	; 03803EDA
P2_Entry_03803EDE:
	ldrh r0,[r5,#0x0]	; 03803EDE
	and r0,r7	; 03803EE0
	cmp r0,#0x0	; 03803EE2
	bne P2_Entry_03803ED8	; 03803EE4
	ldr r0,[pool_03803F90]	; 03803EE6
	strh r0,[r5,#0x0]	; 03803EE8
	mov r0,#0xa	; 03803EEA
	ldr r7,[pool_03803F94]	; 03803EEC
	strh r0,[r7,#0x0]	; 03803EEE
	mov r5,#0x0	; 03803EF0
	b P2_Entry_03803F14	; 03803EF2
P2_Entry_03803EF4:
	mov r0,#0x1	; 03803EF4
	bl P2_SwiWaitByLoop	; 03803EF6
P2_Entry_03803EFA:
	ldr r0,[pool_03803F8C]	; 03803EFA
	ldrh r1,[r0,#0x0]	; 03803EFC
	mov r0,#0x80	; 03803EFE
	and r1,r0	; 03803F00
	cmp r1,#0x0	; 03803F02
	bne P2_Entry_03803EF4	; 03803F04
	lsl r1,r5,#0x1	; 03803F06
	add r0,sp,#0x0	; 03803F08
	ldrh r1,[r0,r1]	; 03803F0A
	mov r0,#0xff	; 03803F0C
	and r1,r0	; 03803F0E
	strh r1,[r7,#0x0]	; 03803F10
	add r5,r5,#0x1	; 03803F12
P2_Entry_03803F14:
	cmp r5,#0x3	; 03803F14
	blt P2_Entry_03803EFA	; 03803F16
	mov r5,#0x0	; 03803F18
	sub r4,r4,#0x1	; 03803F1A
	ldr r7,[pool_03803F8C]	; 03803F1C
	b P2_Entry_03803F3C	; 03803F1E
P2_Entry_03803F20:
	mov r0,#0x1	; 03803F20
	bl P2_SwiWaitByLoop	; 03803F22
P2_Entry_03803F26:
	ldrh r1,[r7,#0x0]	; 03803F26
	mov r0,#0x80	; 03803F28
	and r1,r0	; 03803F2A
	cmp r1,#0x0	; 03803F2C
	bne P2_Entry_03803F20	; 03803F2E
	ldrb r1,[r6,r5]	; 03803F30
	mov r0,#0xff	; 03803F32
	and r1,r0	; 03803F34
	ldr r0,[pool_03803F94]	; 03803F36
	strh r1,[r0,#0x0]	; 03803F38
	add r5,r5,#0x1	; 03803F3A
P2_Entry_03803F3C:
	cmp r5,r4	; 03803F3C
	blt P2_Entry_03803F26	; 03803F3E
	ldr r4,[pool_03803F8C]	; 03803F40
	mov r7,#0x80	; 03803F42
	b P2_Entry_03803F4C	; 03803F44
P2_Entry_03803F46:
	mov r0,#0x1	; 03803F46
	bl P2_SwiWaitByLoop	; 03803F48
P2_Entry_03803F4C:
	ldrh r0,[r4,#0x0]	; 03803F4C
	and r0,r7	; 03803F4E
	cmp r0,#0x0	; 03803F50
	bne P2_Entry_03803F46	; 03803F52
	ldr r0,[pool_03803F98]	; 03803F54
	strh r0,[r4,#0x0]	; 03803F56
	ldrb r1,[r6,r5]	; 03803F58
	mov r0,#0xff	; 03803F5A
	and r1,r0	; 03803F5C
	ldr r0,[pool_03803F94]	; 03803F5E
	strh r1,[r0,#0x0]	; 03803F60
	mov r6,#0x1	; 03803F62
	ldr r5,[pool_03803F8C]	; 03803F64
	mov r4,#0x80	; 03803F66
	b P2_Entry_03803F70	; 03803F68
P2_Entry_03803F6A:
	add r0,r6,#0x0	; 03803F6A
	bl P2_SwiWaitByLoop	; 03803F6C
P2_Entry_03803F70:
	ldrh r0,[r5,#0x0]	; 03803F70
	and r0,r4	; 03803F72
	cmp r0,#0x0	; 03803F74
	bne P2_Entry_03803F6A	; 03803F76
P2_Entry_03803F78:
	add sp,#0xc	; 03803F78
	pop {r4,r5,r6,r7}	; 03803F7A
	pop {r3}	; 03803F7C
	bx r3	; 03803F7E
pool_03803F80:
	.word 0x00000100	; 03803F80
pool_03803F84:
	.word 0x00FF0000	; 03803F84
pool_03803F88:
	.word 0x0000FF00	; 03803F88
pool_03803F8C:
	.word REG_SPICNT	; 03803F8C
pool_03803F90:
	.word 0x00008900	; 03803F90
pool_03803F94:
	.word REG_SPIDATA	; 03803F94
pool_03803F98:
	.word 0x00008100	; 03803F98

; ===== function loc_03803F9C =====
loc_03803F9C:
	push {r4,r5,r6,r7,lr}	; 03803F9C
	sub sp,#0xc	; 03803F9E
	add r4,r1,#0x0	; 03803FA0
	add r6,r2,#0x0	; 03803FA2
	cmp r4,#0x1	; 03803FA4
	bcc loc_03804076	; 03803FA6
	ldr r1,[pool_03804080]	; 03803FA8
	add r2,r0,#0x0	; 03803FAA
	and r2,r1	; 03803FAC
	lsr r1,r2,#0x10	; 03803FAE
	add r2,sp,#0x0	; 03803FB0
	strh r1,[r2,#0x0]	; 03803FB2
	ldr r1,[pool_03804084]	; 03803FB4
	add r3,r0,#0x0	; 03803FB6
	and r3,r1	; 03803FB8
	lsr r1,r3,#0x8	; 03803FBA
	strh r1,[r2,#0x2]	; 03803FBC
	mov r1,#0xff	; 03803FBE
	and r0,r1	; 03803FC0
	strh r0,[r2,#0x4]	; 03803FC2
	ldr r5,[pool_03804088]	; 03803FC4
	mov r7,#0x80	; 03803FC6
	b loc_03803FD0	; 03803FC8
loc_03803FCA:
	mov r0,#0x1	; 03803FCA
	bl loc_0380491C	; 03803FCC
loc_03803FD0:
	ldrh r0,[r5,#0x0]	; 03803FD0
	and r0,r7	; 03803FD2
	cmp r0,#0x0	; 03803FD4
	bne loc_03803FCA	; 03803FD6
	ldr r0,[pool_0380408C]	; 03803FD8
	strh r0,[r5,#0x0]	; 03803FDA
	mov r0,#0x3	; 03803FDC
	ldr r7,[pool_03804090]	; 03803FDE
	strh r0,[r7,#0x0]	; 03803FE0
	mov r5,#0x0	; 03803FE2
	b loc_03804006	; 03803FE4
loc_03803FE6:
	mov r0,#0x1	; 03803FE6
	bl loc_0380491C	; 03803FE8
loc_03803FEC:
	ldr r0,[pool_03804088]	; 03803FEC
	ldrh r1,[r0,#0x0]	; 03803FEE
	mov r0,#0x80	; 03803FF0
	and r1,r0	; 03803FF2
	cmp r1,#0x0	; 03803FF4
	bne loc_03803FE6	; 03803FF6
	lsl r1,r5,#0x1	; 03803FF8
	add r0,sp,#0x0	; 03803FFA
	ldrh r1,[r0,r1]	; 03803FFC
	mov r0,#0xff	; 03803FFE
	and r1,r0	; 03804000
	strh r1,[r7,#0x0]	; 03804002
	add r5,r5,#0x1	; 03804004
loc_03804006:
	cmp r5,#0x3	; 03804006
	blt loc_03803FEC	; 03804008
	ldr r5,[pool_03804088]	; 0380400A
	mov r7,#0x80	; 0380400C
	b loc_03804016	; 0380400E
loc_03804010:
	mov r0,#0x1	; 03804010
	bl loc_0380491C	; 03804012
loc_03804016:
	ldrh r0,[r5,#0x0]	; 03804016
	and r0,r7	; 03804018
	cmp r0,#0x0	; 0380401A
	bne loc_03804010	; 0380401C
	mov r5,#0x0	; 0380401E
	add r7,r5,#0x0	; 03804020
	b loc_03804048	; 03804022
loc_03804024:
	ldr r0,[pool_03804090]	; 03804024
	strh r7,[r0,#0x0]	; 03804026
	b loc_03804030	; 03804028
loc_0380402A:
	mov r0,#0x1	; 0380402A
	bl loc_0380491C	; 0380402C
loc_03804030:
	ldr r0,[pool_03804088]	; 03804030
	ldrh r1,[r0,#0x0]	; 03804032
	mov r0,#0x80	; 03804034
	and r1,r0	; 03804036
	cmp r1,#0x0	; 03804038
	bne loc_0380402A	; 0380403A
	ldr r0,[pool_03804090]	; 0380403C
	ldrh r1,[r0,#0x0]	; 0380403E
	mov r0,#0xff	; 03804040
	and r1,r0	; 03804042
	strb r1,[r6,r5]	; 03804044
	add r5,r5,#0x1	; 03804046
loc_03804048:
	sub r0,r4,#0x1	; 03804048
	cmp r5,r0	; 0380404A
	bcc loc_03804024	; 0380404C
	ldr r0,[pool_03804094]	; 0380404E
	ldr r4,[pool_03804088]	; 03804050
	strh r0,[r4,#0x0]	; 03804052
	mov r1,#0x0	; 03804054
	ldr r0,[pool_03804090]	; 03804056
	strh r1,[r0,#0x0]	; 03804058
	mov r7,#0x80	; 0380405A
	b loc_03804064	; 0380405C
loc_0380405E:
	mov r0,#0x1	; 0380405E
	bl loc_0380491C	; 03804060
loc_03804064:
	ldrh r0,[r4,#0x0]	; 03804064
	and r0,r7	; 03804066
	cmp r0,#0x0	; 03804068
	bne loc_0380405E	; 0380406A
	ldr r0,[pool_03804090]	; 0380406C
	ldrh r1,[r0,#0x0]	; 0380406E
	mov r0,#0xff	; 03804070
	and r1,r0	; 03804072
	strb r1,[r6,r5]	; 03804074
loc_03804076:
	add sp,#0xc	; 03804076
	pop {r4,r5,r6,r7}	; 03804078
	pop {r3}	; 0380407A
	bx r3	; 0380407C
	.byte 0xC0, 0x46	; 03804080
pool_03804080:
loc_03804080:
	.word 0x00FF0000	; 03804080
pool_03804084:
loc_03804084:
	.word 0x0000FF00	; 03804084
pool_03804088:
loc_03804088:
	.word REG_SPICNT	; 03804088
pool_0380408C:
loc_0380408C:
	.word 0x00008900	; 0380408C
pool_03804090:
loc_03804090:
	.word REG_SPIDATA	; 03804090
pool_03804094:
loc_03804094:
	.word 0x00008100	; 03804094

; ===== function loc_03804098 =====
loc_03804098:
	push {r4,r5,r6,r7,lr}	; 03804098
	sub sp,#0x4	; 0380409A
	add r5,r0,#0x0	; 0380409C
	mov r7,#0x1	; 0380409E
	ldr r4,[pool_03804108]	; 038040A0
	mov r6,#0x80	; 038040A2
	b loc_038040AC	; 038040A4
loc_038040A6:
	add r0,r7,#0x0	; 038040A6
	bl loc_0380491C	; 038040A8
loc_038040AC:
	ldrh r0,[r4,#0x0]	; 038040AC
	and r0,r6	; 038040AE
	cmp r0,#0x0	; 038040B0
	bne loc_038040A6	; 038040B2
	ldr r0,[pool_0380410C]	; 038040B4
	strh r0,[r4,#0x0]	; 038040B6
	mov r1,#0x5	; 038040B8
	ldr r0,[pool_03804110]	; 038040BA
	strh r1,[r0,#0x0]	; 038040BC
	mov r7,#0x1	; 038040BE
	ldr r4,[pool_03804108]	; 038040C0
	mov r6,#0x80	; 038040C2
	b loc_038040CC	; 038040C4
loc_038040C6:
	add r0,r7,#0x0	; 038040C6
	bl loc_0380491C	; 038040C8
loc_038040CC:
	ldrh r0,[r4,#0x0]	; 038040CC
	and r0,r6	; 038040CE
	cmp r0,#0x0	; 038040D0
	bne loc_038040C6	; 038040D2
	ldr r0,[pool_03804114]	; 038040D4
	strh r0,[r4,#0x0]	; 038040D6
	mov r1,#0x0	; 038040D8
	ldr r0,[pool_03804110]	; 038040DA
	strh r1,[r0,#0x0]	; 038040DC
	mov r7,#0x1	; 038040DE
	ldr r4,[pool_03804108]	; 038040E0
	mov r6,#0x80	; 038040E2
	b loc_038040EC	; 038040E4
loc_038040E6:
	add r0,r7,#0x0	; 038040E6
	bl loc_0380491C	; 038040E8
loc_038040EC:
	ldrh r0,[r4,#0x0]	; 038040EC
	and r0,r6	; 038040EE
	cmp r0,#0x0	; 038040F0
	bne loc_038040E6	; 038040F2
	ldr r0,[pool_03804110]	; 038040F4
	ldrh r1,[r0,#0x0]	; 038040F6
	mov r0,#0xff	; 038040F8
	and r1,r0	; 038040FA
	strb r1,[r5,#0x0]	; 038040FC
	add sp,#0x4	; 038040FE
	pop {r4,r5,r6,r7}	; 03804100
	pop {r3}	; 03804102
	bx r3	; 03804104
	.byte 0xC0, 0x46	; 03804108
pool_03804108:
loc_03804108:
	.word REG_SPICNT	; 03804108
pool_0380410C:
loc_0380410C:
	.word 0x00008900	; 0380410C
pool_03804110:
loc_03804110:
	.word REG_SPIDATA	; 03804110
pool_03804114:
loc_03804114:
	.word 0x00008100	; 03804114
P2_Entry_03804118:
	push {r4,r5,r6,lr}	; 03804118
	mov r6,#0x1	; 0380411A
	ldr r5,[pool_03804158]	; 0380411C
	mov r4,#0x80	; 0380411E
	b P2_Entry_03804128	; 03804120
P2_Entry_03804122:
	add r0,r6,#0x0	; 03804122
	bl P2_SwiWaitByLoop	; 03804124
P2_Entry_03804128:
	ldrh r0,[r5,#0x0]	; 03804128
	and r0,r4	; 0380412A
	cmp r0,#0x0	; 0380412C
	bne P2_Entry_03804122	; 0380412E
	ldr r0,[pool_0380415C]	; 03804130
	strh r0,[r5,#0x0]	; 03804132
	mov r1,#0x4	; 03804134
	ldr r0,[pool_03804160]	; 03804136
	strh r1,[r0,#0x0]	; 03804138
	mov r6,#0x1	; 0380413A
	ldr r5,[pool_03804158]	; 0380413C
	mov r4,#0x80	; 0380413E
	b P2_Entry_03804148	; 03804140
P2_Entry_03804142:
	add r0,r6,#0x0	; 03804142
	bl P2_SwiWaitByLoop	; 03804144
P2_Entry_03804148:
	ldrh r0,[r5,#0x0]	; 03804148
	and r0,r4	; 0380414A
loc_0380414C:
	cmp r0,#0x0	; 0380414C
	bne P2_Entry_03804142	; 0380414E
	pop {r4,r5,r6}	; 03804150
	pop {r3}	; 03804152
	bx r3	; 03804154
	.byte 0xC0, 0x46	; 03804156
pool_03804158:
	.word REG_SPICNT	; 03804158
pool_0380415C:
	.word 0x00008100	; 0380415C
pool_03804160:
	.word REG_SPIDATA	; 03804160
P2_Entry_03804164:
	push {r4,r5,r6,lr}	; 03804164
	mov r6,#0x1	; 03804166
	ldr r5,[pool_038041A4]	; 03804168
	mov r4,#0x80	; 0380416A
	b P2_Entry_03804174	; 0380416C
P2_Entry_0380416E:
	add r0,r6,#0x0	; 0380416E
	bl P2_SwiWaitByLoop	; 03804170
P2_Entry_03804174:
	ldrh r0,[r5,#0x0]	; 03804174
	and r0,r4	; 03804176
	cmp r0,#0x0	; 03804178
	bne P2_Entry_0380416E	; 0380417A
	ldr r0,[pool_038041A8]	; 0380417C
	strh r0,[r5,#0x0]	; 0380417E
	mov r1,#0x6	; 03804180
	ldr r0,[pool_038041AC]	; 03804182
	strh r1,[r0,#0x0]	; 03804184
	mov r6,#0x1	; 03804186
	ldr r5,[pool_038041A4]	; 03804188
	mov r4,#0x80	; 0380418A
	b P2_Entry_03804194	; 0380418C
P2_Entry_0380418E:
	add r0,r6,#0x0	; 0380418E
	bl P2_SwiWaitByLoop	; 03804190
P2_Entry_03804194:
	ldrh r0,[r5,#0x0]	; 03804194
	and r0,r4	; 03804196
	cmp r0,#0x0	; 03804198
	bne P2_Entry_0380418E	; 0380419A
	pop {r4,r5,r6}	; 0380419C
	pop {r3}	; 0380419E
	bx r3	; 038041A0
	.byte 0xC0, 0x46	; 038041A2
pool_038041A4:
	.word REG_SPICNT	; 038041A4
pool_038041A8:
	.word 0x00008100	; 038041A8
pool_038041AC:
	.word REG_SPIDATA	; 038041AC
P2_Entry_038041B0:
	push {r4,r5,lr}	; 038041B0
	sub sp,#0x4	; 038041B2
	add r4,r0,#0x0	; 038041B4
	bl loc_037FDD34	; 038041B6
	add r5,r0,#0x0	; 038041BA
	mov r0,#0x3	; 038041BC
	bl P2_Entry_03802EC4	; 038041BE
	cmp r0,#0x0	; 038041C2
	bne P2_Entry_038041DA	; 038041C4
	add r0,r5,#0x0	; 038041C6
	bl loc_037FDD58	; 038041C8
	ldr r0,[r4,#0x4]	; 038041CC
	lsl r0,r0,#0x10	; 038041CE
	lsr r0,r0,#0x10	; 038041D0
	mov r1,#0x4	; 038041D2
	bl loc_03802ED8	; 038041D4
	b P2_Entry_03804298	; 038041D8
P2_Entry_038041DA:
	mov r0,#0x3	; 038041DA
	bl loc_03802EB4	; 038041DC
	add r0,r5,#0x0	; 038041E0
	bl loc_037FDD58	; 038041E2
	ldr r0,[r4,#0x4]	; 038041E6
	add r1,r0,#0x0	; 038041E8
	sub r1,#0x61	; 038041EA
	cmp r1,#0x5	; 038041EC
	bhi P2_Entry_03804288	; 038041EE
	add r1,r1,r1	; 038041F0
P2_SwitchIndexPC_038041F0:
	add r1,pc	; 038041F2
	ldrh r1,[r1,#(P2_SwitchTable_038041F0 - (P2_SwitchIndexPC_038041F0 + 4))]	; 038041F4
	lsl r1,r1,#0x10	; 038041F6
	asr r1,r1,#0x10	; 038041F8
P2_SwitchTargetPC_038041F0:
	add r1,pc	; 038041FA
	bx r1	; 038041FC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038041F0:
	.halfword (P2_Case_0380420A + 1) - (P2_SwitchTargetPC_038041F0 + 4)
	.halfword (P2_Entry_03804288 + 1) - (P2_SwitchTargetPC_038041F0 + 4)
	.halfword (P2_Case_03804268 + 1) - (P2_SwitchTargetPC_038041F0 + 4)
	.halfword (P2_Case_03804222 + 1) - (P2_SwitchTargetPC_038041F0 + 4)
	.halfword (P2_Case_03804246 + 1) - (P2_SwitchTargetPC_038041F0 + 4)
	.halfword (P2_Case_03804280 + 1) - (P2_SwitchTargetPC_038041F0 + 4)
P2_SwitchTable_038041F0End:
P2_Case_0380420A:
	mov r1,#0x1	; 0380420A
	ldr r0,[pool_038042A0]	; 0380420C
	str r1,[r0,#0x20]	; 0380420E
	ldr r1,[r4,#0x8]	; 03804210
	ldr r0,[pool_038042A4]	; 03804212
	strh r1,[r0,#0x0]	; 03804214
	ldr r1,[r4,#0xc]	; 03804216
	ldr r0,[pool_038042A8]	; 03804218
	strh r1,[r0,#0x0]	; 0380421A
	bl P2_Entry_038046AC	; 0380421C
	b P2_Entry_03804292	; 03804220
P2_Case_03804222:
	mov r1,#0x4	; 03804222
	ldr r0,[pool_038042A0]	; 03804224
	str r1,[r0,#0x20]	; 03804226
	ldr r2,[r4,#0x8]	; 03804228
	str r2,[r0,#0x28]	; 0380422A
	ldr r1,[r4,#0xc]	; 0380422C
	str r1,[r0,#0x24]	; 0380422E
	lsl r0,r2,#0x10	; 03804230
	lsr r0,r0,#0x10	; 03804232
	lsl r1,r1,#0x18	; 03804234
	lsr r1,r1,#0x18	; 03804236
	bl loc_03804520	; 03804238
	mov r0,#0x64	; 0380423C
	mov r1,#0x0	; 0380423E
	bl loc_03802ED8	; 03804240
	b P2_Entry_03804292	; 03804244
P2_Case_03804246:
	mov r1,#0x3	; 03804246
	ldr r0,[pool_038042A0]	; 03804248
	str r1,[r0,#0x20]	; 0380424A
	ldr r1,[r4,#0x8]	; 0380424C
	str r1,[r0,#0x28]	; 0380424E
	lsl r0,r1,#0x10	; 03804250
	lsr r4,r0,#0x10	; 03804252
	add r0,r4,#0x0	; 03804254
	bl P2_ReadPmicRegister	; 03804256
	add r1,r0,#0x0	; 0380425A
	add r4,#0x70	; 0380425C
	lsl r0,r4,#0x10	; 0380425E
	lsr r0,r0,#0x10	; 03804260
	bl loc_03802ED8	; 03804262
	b P2_Entry_03804292	; 03804266
P2_Case_03804268:
	mov r0,#0x2	; 03804268
	ldr r1,[pool_038042A0]	; 0380426A
	str r0,[r1,#0x20]	; 0380426C
	ldr r0,[r4,#0x8]	; 0380426E
	str r0,[r1,#0x24]	; 03804270
	bl P2_Entry_038045DC	; 03804272
	mov r0,#0x63	; 03804276
	mov r1,#0x0	; 03804278
	bl loc_03802ED8	; 0380427A
	b P2_Entry_03804292	; 0380427E
P2_Case_03804280:
	ldr r0,[r4,#0x8]	; 03804280
	bl P2_Entry_03804598	; 03804282
	b P2_Entry_03804292	; 03804286
P2_Entry_03804288:
	lsl r0,r0,#0x10	; 03804288
	lsr r0,r0,#0x10	; 0380428A
	mov r1,#0x1	; 0380428C
	bl loc_03802ED8	; 0380428E
P2_Entry_03804292:
	mov r0,#0x3	; 03804292
	bl P2_Entry_03802E8C	; 03804294
P2_Entry_03804298:
	add sp,#0x4	; 03804298
	pop {r4,r5}	; 0380429A
	pop {r3}	; 0380429C
	bx r3	; 0380429E
pool_038042A0:
	.word P2_BssStart + 0x26A4	; 038042A0
pool_038042A4:
	.word P2_BssStart + 0x269C	; 038042A4
pool_038042A8:
	.word P2_BssStart + 0x2698	; 038042A8

; ===== function loc_038042AC =====
loc_038042AC:
	push {r4,r5,r6,lr}	; 038042AC
	sub sp,#0x8	; 038042AE
	ldr r1,[pool_038043DC]	; 038042B0
	add r2,r0,#0x0	; 038042B2
	and r2,r1	; 038042B4
	cmp r2,#0x0	; 038042B6
	beq loc_038042CA	; 038042B8
	mov r4,#0x0	; 038042BA
	add r3,r4,#0x0	; 038042BC
	ldr r1,[pool_038043E0]	; 038042BE
loc_038042C0:
	lsl r2,r4,#0x1	; 038042C0
	strh r3,[r1,r2]	; 038042C2
	add r4,r4,#0x1	; 038042C4
	cmp r4,#0x10	; 038042C6
	blt loc_038042C0	; 038042C8
loc_038042CA:
	ldr r1,[pool_038043E4]	; 038042CA
	add r2,r0,#0x0	; 038042CC
	and r2,r1	; 038042CE
	lsr r1,r2,#0x10	; 038042D0
	lsl r1,r1,#0x1	; 038042D2
	ldr r5,[pool_038043E0]	; 038042D4
	strh r0,[r5,r1]	; 038042D6
	ldr r1,[pool_038043E8]	; 038042D8
	and r0,r1	; 038042DA
	cmp r0,#0x0	; 038042DC
	beq loc_038043D4	; 038042DE
	ldrh r3,[r5,#0x0]	; 038042E0
	ldr r0,[pool_038043EC]	; 038042E2
	add r1,r3,#0x0	; 038042E4
	and r1,r0	; 038042E6
	lsl r0,r1,#0x8	; 038042E8
	lsr r4,r0,#0x10	; 038042EA
	add r0,r4,#0x0	; 038042EC
	sub r0,#0x60	; 038042EE
	cmp r0,#0x7	; 038042F0
	bhi loc_038043CC	; 038042F2
	add r0,r0,r0	; 038042F4
P2_SwitchIndexPC_038042F4:
	add r0,pc	; 038042F6
	ldrh r0,[r0,#(P2_SwitchTable_038042F4 - (P2_SwitchIndexPC_038042F4 + 4))]	; 038042F8
	lsl r0,r0,#0x10	; 038042FA
	asr r0,r0,#0x10	; 038042FC
P2_SwitchTargetPC_038042F4:
	add r0,pc	; 038042FE
	bx r0	; 03804300
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038042F4:
	.halfword (loc_03804312 + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_0380431C + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_038043CC + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_03804380 + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_03804340 + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_03804364 + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_038043A6 + 1) - (P2_SwitchTargetPC_038042F4 + 4)
	.halfword (loc_038043BA + 1) - (P2_SwitchTargetPC_038042F4 + 4)
P2_SwitchTable_038042F4End:
loc_03804312:
	mov r0,#0x60	; 03804312
	mov r1,#0x0	; 03804314
	bl loc_03802ED8	; 03804316
	b loc_038043D4	; 0380431A
loc_0380431C:
	ldrh r1,[r5,#0x2]	; 0380431C
	ldr r0,[pool_038043F0]	; 0380431E
	and r1,r0	; 03804320
	str r1,[sp,#0x0]	; 03804322
	mov r0,#0x3	; 03804324
	add r1,r4,#0x0	; 03804326
	mov r2,#0x2	; 03804328
	mov r5,#0xff	; 0380432A
	and r3,r5	; 0380432C
	bl loc_03802DE4	; 0380432E
	cmp r0,#0x0	; 03804332
	bne loc_038043D4	; 03804334
	add r0,r4,#0x0	; 03804336
	mov r1,#0x4	; 03804338
	bl loc_03802ED8	; 0380433A
	b loc_038043D4	; 0380433E
loc_03804340:
	ldrh r1,[r5,#0x2]	; 03804340
	ldr r0,[pool_038043F0]	; 03804342
	and r1,r0	; 03804344
	str r1,[sp,#0x0]	; 03804346
	mov r0,#0x3	; 03804348
	add r1,r4,#0x0	; 0380434A
	mov r2,#0x2	; 0380434C
	mov r5,#0xff	; 0380434E
	and r3,r5	; 03804350
	bl loc_03802DE4	; 03804352
	cmp r0,#0x0	; 03804356
	bne loc_038043D4	; 03804358
	add r0,r4,#0x0	; 0380435A
	mov r1,#0x4	; 0380435C
	bl loc_03802ED8	; 0380435E
	b loc_038043D4	; 03804362
loc_03804364:
	mov r0,#0x3	; 03804364
	add r1,r4,#0x0	; 03804366
	mov r2,#0x1	; 03804368
	ldr r5,[pool_038043F0]	; 0380436A
	and r3,r5	; 0380436C
	bl loc_03802DE4	; 0380436E
	cmp r0,#0x0	; 03804372
	bne loc_038043D4	; 03804374
	add r0,r4,#0x0	; 03804376
	mov r1,#0x4	; 03804378
	bl loc_03802ED8	; 0380437A
	b loc_038043D4	; 0380437E
loc_03804380:
	mov r0,#0x3	; 03804380
	add r1,r4,#0x0	; 03804382
	mov r2,#0x1	; 03804384
	mov r6,#0xff	; 03804386
	and r3,r6	; 03804388
	lsl r3,r3,#0x10	; 0380438A
	ldrh r6,[r5,#0x2]	; 0380438C
	ldr r5,[pool_038043F0]	; 0380438E
	and r6,r5	; 03804390
	orr r3,r6	; 03804392
	bl loc_03802DE4	; 03804394
	cmp r0,#0x0	; 03804398
	bne loc_038043D4	; 0380439A
	add r0,r4,#0x0	; 0380439C
	mov r1,#0x4	; 0380439E
	bl loc_03802ED8	; 038043A0
	b loc_038043D4	; 038043A4
loc_038043A6:
	mov r0,#0xff	; 038043A6
	and r3,r0	; 038043A8
	add r0,r3,#0x0	; 038043AA
	bl loc_03804804	; 038043AC
	mov r0,#0x66	; 038043B0
	mov r1,#0x0	; 038043B2
	bl loc_03802ED8	; 038043B4
	b loc_038043D4	; 038043B8
loc_038043BA:
	bl loc_038047F8	; 038043BA
	add r1,r0,#0x0	; 038043BE
	mov r0,#0x67	; 038043C0
	lsl r1,r1,#0x10	; 038043C2
	lsr r1,r1,#0x10	; 038043C4
	bl loc_03802ED8	; 038043C6
	b loc_038043D4	; 038043CA
loc_038043CC:
	add r0,r4,#0x0	; 038043CC
	mov r1,#0x1	; 038043CE
	bl loc_03802ED8	; 038043D0
loc_038043D4:
	add sp,#0x8	; 038043D4
	pop {r4,r5,r6}	; 038043D6
	pop {r3}	; 038043D8
	bx r3	; 038043DA
pool_038043DC:
loc_038043DC:
	.word 0x02000000	; 038043DC
pool_038043E0:
loc_038043E0:
	.word P2_BssStart + 0x26A4	; 038043E0
pool_038043E4:
loc_038043E4:
	.word 0x000F0000	; 038043E4
pool_038043E8:
loc_038043E8:
	.word 0x01000000	; 038043E8
pool_038043EC:
loc_038043EC:
	.word 0x0000FF00	; 038043EC
pool_038043F0:
loc_038043F0:
	.word 0x0000FFFF	; 038043F0

; ===== function loc_038043F4 =====
loc_038043F4:
	mov r1,#0x1	; 038043F4
	ldr r0,[pool_03804410]	; 038043F6
	str r1,[r0,#0x0]	; 038043F8
	mov r3,#0x0	; 038043FA
	ldr r0,[pool_03804414]	; 038043FC
	str r3,[r0,#0x20]	; 038043FE
	add r2,r3,#0x0	; 03804400
loc_03804402:
	lsl r1,r3,#0x1	; 03804402
	strh r2,[r0,r1]	; 03804404
	add r3,r3,#0x1	; 03804406
	cmp r3,#0x10	; 03804408
	blt loc_03804402	; 0380440A
	bx lr	; 0380440C
	.byte 0xC0, 0x46	; 03804410
pool_03804410:
loc_03804410:
	.word P2_BssStart + 0x26A0	; 03804410
pool_03804414:
loc_03804414:
	.word P2_BssStart + 0x26A4	; 03804414
P2_Entry_03804418:
	ldr r3,[pool_03804434]	; 03804418
	and r2,r3	; 0380441A
	ldr r3,[pool_03804438]	; 0380441C
	and r0,r3	; 0380441E
	lsl r3,r0,#0x16	; 03804420
	ldr r0,[pool_0380443C]	; 03804422
	and r1,r0	; 03804424
	lsl r0,r1,#0x10	; 03804426
	orr r3,r0	; 03804428
	orr r2,r3	; 0380442A
	add r0,r2,#0x0	; 0380442C
	ldr r3,[pool_03804440]	; 0380442E
	bx r3	; 03804430
	.byte 0xC0, 0x46	; 03804432
pool_03804434:
	.word 0x0000FFFF	; 03804434
pool_03804438:
	.word 0x03C00000	; 03804438
pool_0380443C:
	.word 0x003F0000	; 0380443C
pool_03804440:
	.word P2_Entry_03804444 + 1	; 03804440
P2_Entry_03804444:
	push {r4,r5,r6,lr}	; 03804444
	add r5,r0,#0x0	; 03804446
	mov r4,#0x8	; 03804448
	mov r6,#0x0	; 0380444A
P2_Entry_0380444C:
	add r0,r4,#0x0	; 0380444C
	add r1,r5,#0x0	; 0380444E
	add r2,r6,#0x0	; 03804450
	bl loc_03801F84	; 03804452
	cmp r0,#0x0	; 03804456
	bne P2_Entry_0380444C	; 03804458
	pop {r4,r5,r6}	; 0380445A
	pop {r3}	; 0380445C
	bx r3	; 0380445E

; ===== function loc_03804460 =====
loc_03804460:
	push {r4,lr}	; 03804460
	add r4,r0,#0x0	; 03804462
	mov r0,#0x0	; 03804464
	bl P2_ReadPmicRegister	; 03804466
	bic r0,r4	; 0380446A
	lsl r0,r0,#0x18	; 0380446C
	lsr r1,r0,#0x18	; 0380446E
	mov r0,#0x0	; 03804470
	bl loc_03804520	; 03804472
	pop {r4}	; 03804476
	pop {r3}	; 03804478
	bx r3	; 0380447A

; ===== function loc_0380447C =====
loc_0380447C:
	push {r4,lr}	; 0380447C
	add r4,r0,#0x0	; 0380447E
	mov r0,#0x0	; 03804480
	bl P2_ReadPmicRegister	; 03804482
	add r1,r0,#0x0	; 03804486
	orr r1,r4	; 03804488
	mov r0,#0x0	; 0380448A
	bl loc_03804520	; 0380448C
	pop {r4}	; 03804490
	pop {r3}	; 03804492
	bx r3	; 03804494
	.byte 0x00, 0x00	; 03804498

; ===== function loc_03804498 =====
loc_03804498:
; 通过 SPI 读取 r0 指定的电源管理寄存器，返回低 8 位。
; Read the PMIC register selected by r0 over SPI; return its low byte.
.func P2_ReadPmicRegister
	push {r4,r5,r6,r7,lr}	; 03804498
	sub sp,#0x4	; 0380449A
	add r5,r0,#0x0	; 0380449C
	mov r7,#0x1	; 0380449E
	ldr r4,[pool_03804518]	; 038044A0
	mov r6,#0x80	; 038044A2
	b loc_038044AC	; 038044A4
loc_038044A6:
	add r0,r7,#0x0	; 038044A6
	bl loc_0380491C	; 038044A8
loc_038044AC:
	ldrh r0,[r4,#0x0]	; 038044AC
	and r0,r6	; 038044AE
	cmp r0,#0x0	; 038044B0
	bne loc_038044A6	; 038044B2
	mov r0,#0x1	; 038044B4
	bl P2_SetPmicSpiHold	; 038044B6
	mov r4,#0x80	; 038044BA
	orr r5,r4	; 038044BC
	lsl r0,r5,#0x18	; 038044BE
	lsr r1,r0,#0x18	; 038044C0
	mov r0,#0xff	; 038044C2
	and r1,r0	; 038044C4
	ldr r0,[pool_0380451C]	; 038044C6
	strh r1,[r0,#0x0]	; 038044C8
	mov r6,#0x1	; 038044CA
	ldr r5,[pool_03804518]	; 038044CC
	b loc_038044D6	; 038044CE
loc_038044D0:
	add r0,r6,#0x0	; 038044D0
	bl loc_0380491C	; 038044D2
loc_038044D6:
	ldrh r0,[r5,#0x0]	; 038044D6
	and r0,r4	; 038044D8
	cmp r0,#0x0	; 038044DA
	bne loc_038044D0	; 038044DC
	mov r0,#0x0	; 038044DE
	bl P2_SetPmicSpiHold	; 038044E0
	mov r1,#0x0	; 038044E4
	ldr r0,[pool_0380451C]	; 038044E6
	strh r1,[r0,#0x0]	; 038044E8
	mov r6,#0x1	; 038044EA
	ldr r5,[pool_03804518]	; 038044EC
	mov r4,#0x80	; 038044EE
	b loc_038044F8	; 038044F0
loc_038044F2:
	add r0,r6,#0x0	; 038044F2
	bl loc_0380491C	; 038044F4
loc_038044F8:
	ldrh r0,[r5,#0x0]	; 038044F8
	and r0,r4	; 038044FA
	cmp r0,#0x0	; 038044FC
	bne loc_038044F2	; 038044FE
	ldr r0,[pool_0380451C]	; 03804500
	ldrh r1,[r0,#0x0]	; 03804502
	mov r0,#0xff	; 03804504
	and r1,r0	; 03804506
	lsl r0,r1,#0x10	; 03804508
	lsr r0,r0,#0x10	; 0380450A
	lsl r0,r0,#0x18	; 0380450C
	lsr r0,r0,#0x18	; 0380450E
	add sp,#0x4	; 03804510
	pop {r4,r5,r6,r7}	; 03804512
	pop {r3}	; 03804514
	bx r3	; 03804516
.endfunc
pool_03804518:
loc_03804518:
	.word REG_SPICNT	; 03804518
pool_0380451C:
loc_0380451C:
	.word REG_SPIDATA	; 0380451C

; ===== function loc_03804520 =====
loc_03804520:
	push {r4,r5,r6,r7,lr}	; 03804520
	sub sp,#0x4	; 03804522
	add r5,r0,#0x0	; 03804524
	add r4,r1,#0x0	; 03804526
	ldr r6,[pool_0380457C]	; 03804528
	mov r7,#0x80	; 0380452A
	b loc_03804534	; 0380452C
loc_0380452E:
	mov r0,#0x1	; 0380452E
	bl loc_0380491C	; 03804530
loc_03804534:
	ldrh r0,[r6,#0x0]	; 03804534
	and r0,r7	; 03804536
	cmp r0,#0x0	; 03804538
	bne loc_0380452E	; 0380453A
	mov r0,#0x1	; 0380453C
	bl P2_SetPmicSpiHold	; 0380453E
	lsl r0,r5,#0x18	; 03804542
	lsr r1,r0,#0x18	; 03804544
	mov r0,#0xff	; 03804546
	and r1,r0	; 03804548
	ldr r0,[pool_03804580]	; 0380454A
	strh r1,[r0,#0x0]	; 0380454C
	mov r7,#0x1	; 0380454E
	ldr r5,[pool_0380457C]	; 03804550
	mov r6,#0x80	; 03804552
	b loc_0380455C	; 03804554
loc_03804556:
	add r0,r7,#0x0	; 03804556
	bl loc_0380491C	; 03804558
loc_0380455C:
	ldrh r0,[r5,#0x0]	; 0380455C
	and r0,r6	; 0380455E
	cmp r0,#0x0	; 03804560
	bne loc_03804556	; 03804562
	mov r0,#0x0	; 03804564
	bl P2_SetPmicSpiHold	; 03804566
	mov r0,#0xff	; 0380456A
	and r4,r0	; 0380456C
	ldr r0,[pool_03804580]	; 0380456E
	strh r4,[r0,#0x0]	; 03804570
	add sp,#0x4	; 03804572
	pop {r4,r5,r6,r7}	; 03804574
	pop {r3}	; 03804576
	bx r3	; 03804578
	.byte 0xC0, 0x46	; 0380457C
pool_0380457C:
loc_0380457C:
	.word REG_SPICNT	; 0380457C
pool_03804580:
loc_03804580:
	.word REG_SPIDATA	; 03804580

; ===== function loc_03804584 =====
loc_03804584:
; 选择 PMIC 的 SPI 通道；r0 控制两次传输之间是否保持片选。
; Select the PMIC SPI device; r0 controls chip-select hold between transfers.
.func P2_SetPmicSpiHold
	lsl r1,r0,#0xb	; 03804584
	ldr r0,[pool_03804590]	; 03804586
	orr r1,r0	; 03804588
	ldr r0,[pool_03804594]	; 0380458A
	strh r1,[r0,#0x0]	; 0380458C
	bx lr	; 0380458E
.endfunc
pool_03804590:
loc_03804590:
	.word 0x00008002	; 03804590
pool_03804594:
loc_03804594:
	.word REG_SPICNT	; 03804594

; ===== function loc_03804598 =====
P2_Entry_03804598:
	push {r4,lr}	; 03804598
	add r4,r0,#0x0	; 0380459A
	cmp r4,#0x1	; 0380459C
	beq loc_038045AA	; 0380459E
	cmp r4,#0x2	; 038045A0
	beq loc_038045BA	; 038045A2
	cmp r4,#0x3	; 038045A4
	beq loc_038045B2	; 038045A6
	b loc_038045C8	; 038045A8
loc_038045AA:
	mov r0,#0x10	; 038045AA
	bl loc_03804460	; 038045AC
	b loc_038045CC	; 038045B0
loc_038045B2:
	mov r0,#0x30	; 038045B2
	bl loc_0380447C	; 038045B4
	b loc_038045CC	; 038045B8
loc_038045BA:
	mov r0,#0x20	; 038045BA
	bl loc_03804460	; 038045BC
	mov r0,#0x10	; 038045C0
	bl loc_0380447C	; 038045C2
	b loc_038045CC	; 038045C6
loc_038045C8:
	bl loc_037FF228	; 038045C8
loc_038045CC:
	ldr r0,[pool_038045D8]	; 038045CC
	str r4,[r0,#0x0]	; 038045CE
	pop {r4}	; 038045D0
	pop {r3}	; 038045D2
	bx r3	; 038045D4
	.byte 0xC0, 0x46	; 038045D8
pool_038045D8:
loc_038045D8:
	.word P2_Data_0380534C	; 038045D8
P2_Entry_038045DC:
	push {lr}	; 038045DC
	sub sp,#0x4	; 038045DE
	cmp r0,#0xf	; 038045E0
	bhi P2_Entry_038046A4	; 038045E2
	add r0,r0,r0	; 038045E4
P2_SwitchIndexPC_038045E4:
	add r0,pc	; 038045E6
	ldrh r0,[r0,#(P2_SwitchTable_038045E4 - (P2_SwitchIndexPC_038045E4 + 4))]	; 038045E8
	lsl r0,r0,#0x10	; 038045EA
	asr r0,r0,#0x10	; 038045EC
P2_SwitchTargetPC_038045E4:
	add r0,pc	; 038045EE
	bx r0	; 038045F0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038045E4:
	.halfword (P2_Entry_038046A4 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804612 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804620 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380462E + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380463C + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804644 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380464C + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804654 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380465C + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804664 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380466C + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804674 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380467C + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804684 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_03804694 + 1) - (P2_SwitchTargetPC_038045E4 + 4)
	.halfword (P2_Case_0380468C + 1) - (P2_SwitchTargetPC_038045E4 + 4)
P2_SwitchTable_038045E4End:
P2_Case_03804612:
	mov r0,#0x1	; 03804612
	bl loc_03804804	; 03804614
	mov r0,#0x1	; 03804618
	bl P2_Entry_03804598	; 0380461A
	b P2_Entry_038046A4	; 0380461E
P2_Case_03804620:
	mov r0,#0x3	; 03804620
	bl loc_03804804	; 03804622
	mov r0,#0x3	; 03804626
	bl P2_Entry_03804598	; 03804628
	b P2_Entry_038046A4	; 0380462C
P2_Case_0380462E:
	mov r0,#0x2	; 0380462E
	bl loc_03804804	; 03804630
	mov r0,#0x2	; 03804634
	bl P2_Entry_03804598	; 03804636
	b P2_Entry_038046A4	; 0380463A
P2_Case_0380463C:
	mov r0,#0x4	; 0380463C
	bl loc_0380447C	; 0380463E
	b P2_Entry_038046A4	; 03804642
P2_Case_03804644:
	mov r0,#0x4	; 03804644
	bl loc_03804460	; 03804646
	b P2_Entry_038046A4	; 0380464A
P2_Case_0380464C:
	mov r0,#0x8	; 0380464C
	bl loc_0380447C	; 0380464E
	b P2_Entry_038046A4	; 03804652
P2_Case_03804654:
	mov r0,#0x8	; 03804654
	bl loc_03804460	; 03804656
	b P2_Entry_038046A4	; 0380465A
P2_Case_0380465C:
	mov r0,#0xc	; 0380465C
	bl loc_0380447C	; 0380465E
	b P2_Entry_038046A4	; 03804662
P2_Case_03804664:
	mov r0,#0xc	; 03804664
	bl loc_03804460	; 03804666
	b P2_Entry_038046A4	; 0380466A
P2_Case_0380466C:
	mov r0,#0x1	; 0380466C
	bl loc_0380447C	; 0380466E
	b P2_Entry_038046A4	; 03804672
P2_Case_03804674:
	mov r0,#0x1	; 03804674
	bl loc_03804460	; 03804676
	b P2_Entry_038046A4	; 0380467A
P2_Case_0380467C:
	mov r0,#0x2	; 0380467C
	bl loc_0380447C	; 0380467E
	b P2_Entry_038046A4	; 03804682
P2_Case_03804684:
	mov r0,#0x2	; 03804684
	bl loc_03804460	; 03804686
	b P2_Entry_038046A4	; 0380468A
P2_Case_0380468C:
	mov r0,#0x40	; 0380468C
	bl loc_03804460	; 0380468E
	b P2_Entry_038046A4	; 03804692
P2_Case_03804694:
	bl P2_Entry_037FF4CC	; 03804694
	mov r0,#0x1	; 03804698
	bl loc_03804460	; 0380469A
	mov r0,#0x40	; 0380469E
	bl loc_0380447C	; 038046A0
P2_Entry_038046A4:
	add sp,#0x4	; 038046A4
	pop {r3}	; 038046A6
	bx r3	; 038046A8
	.byte 0x00, 0x00	; 038046AA
P2_Entry_038046AC:
	push {r4,r5,r6,r7,lr}	; 038046AC
	sub sp,#0x4	; 038046AE
	ldr r1,[pool_038047C0]	; 038046B0
	ldrh r4,[r1,#0x0]	; 038046B2
	mov r0,#0x0	; 038046B4
	strh r0,[r1,#0x0]	; 038046B6
	bl loc_037FDD34	; 038046B8
	add r6,r0,#0x0	; 038046BC
	ldr r0,[pool_038047C4]	; 038046BE
	bl loc_037FDAB8	; 038046C0
	add r7,r0,#0x0	; 038046C4
	mov r0,#0x0	; 038046C6
	bl P2_ReadPmicRegister	; 038046C8
	str r0,[sp,#0x0]	; 038046CC
	mov r0,#0x2	; 038046CE
	bl loc_03804804	; 038046D0
	mov r0,#0x2	; 038046D4
	bl P2_Entry_03804598	; 038046D6
	mov r0,#0x2	; 038046DA
	bl P2_Entry_03804598	; 038046DC
	bl P2_Entry_037FF4CC	; 038046E0
	mov r0,#0x1	; 038046E4
	bl loc_03804460	; 038046E6
	ldr r0,[pool_038047C8]	; 038046EA
	ldrh r1,[r0,#0x0]	; 038046EC
	mov r0,#0x1	; 038046EE
	and r1,r0	; 038046F0
	cmp r1,#0x0	; 038046F2
	beq P2_Entry_03804708	; 038046F4
	ldr r0,[pool_038047CC]	; 038046F6
	ldrh r1,[r0,#0x0]	; 038046F8
	ldr r0,[pool_038047D0]	; 038046FA
	orr r1,r0	; 038046FC
	ldr r0,[pool_038047D4]	; 038046FE
	strh r1,[r0,#0x0]	; 03804700
	ldr r0,[pool_038047D8]	; 03804702
	bl loc_037FDAE4	; 03804704
P2_Entry_03804708:
	ldr r0,[pool_038047C8]	; 03804708
	ldrh r1,[r0,#0x0]	; 0380470A
	mov r0,#0x4	; 0380470C
	and r1,r0	; 0380470E
	cmp r1,#0x0	; 03804710
	beq P2_Entry_0380471A	; 03804712
	ldr r0,[pool_038047DC]	; 03804714
	bl loc_037FDAE4	; 03804716
P2_Entry_0380471A:
	ldr r0,[pool_038047C8]	; 0380471A
	ldrh r1,[r0,#0x0]	; 0380471C
	mov r0,#0x2	; 0380471E
	and r1,r0	; 03804720
	cmp r1,#0x0	; 03804722
	beq P2_Entry_03804746	; 03804724
	ldr r0,[pool_038047E0]	; 03804726
	ldrh r5,[r0,#0x0]	; 03804728
	ldr r0,[pool_038047E4]	; 0380472A
	bl loc_03802198	; 0380472C
	mov r0,#0x40	; 03804730
	mov r1,#0x0	; 03804732
	bl loc_038021AC	; 03804734
	ldr r0,[pool_038047E8]	; 03804738
	add r1,r0,#0x0	; 0380473A
	bl loc_038021AC	; 0380473C
	mov r0,#0x80	; 03804740
	bl loc_037FDAE4	; 03804742
P2_Entry_03804746:
	ldr r0,[pool_038047C8]	; 03804746
	ldrh r1,[r0,#0x0]	; 03804748
	mov r0,#0x8	; 0380474A
	and r1,r0	; 0380474C
	cmp r1,#0x0	; 0380474E
	beq P2_Entry_03804758	; 03804750
	ldr r0,[pool_038047EC]	; 03804752
	bl loc_037FDAE4	; 03804754
P2_Entry_03804758:
	ldr r0,[pool_038047C8]	; 03804758
	ldrh r1,[r0,#0x0]	; 0380475A
	mov r0,#0x10	; 0380475C
	and r1,r0	; 0380475E
	cmp r1,#0x0	; 03804760
	beq P2_Entry_0380476A	; 03804762
	ldr r0,[pool_038047F0]	; 03804764
	bl loc_037FDAE4	; 03804766
P2_Entry_0380476A:
	add r0,r6,#0x0	; 0380476A
	bl loc_037FDD58	; 0380476C
	ldr r1,[pool_038047C0]	; 03804770
	ldrh r0,[r1,#0x0]	; 03804772
	mov r0,#0x1	; 03804774
	strh r0,[r1,#0x0]	; 03804776
	bl P2_SwiStop	; 03804778
	mov r0,#0x0	; 0380477C
	ldr r1,[sp,#0x0]	; 0380477E
	bl loc_03804520	; 03804780
	ldr r0,[pool_038047E0]	; 03804784
	strh r5,[r0,#0x0]	; 03804786
	mov r0,#0x1	; 03804788
	bl loc_0380447C	; 0380478A
	bl P2_Entry_037FF498	; 0380478E
	mov r1,#0x0	; 03804792
	ldr r0,[pool_038047F4]	; 03804794
	str r1,[r0,#0x20]	; 03804796
	mov r0,#0x62	; 03804798
	add r2,r1,#0x0	; 0380479A
	bl P2_Entry_03804418	; 0380479C
	bl loc_037FDD34	; 038047A0
	add r0,r7,#0x0	; 038047A4
	bl loc_037FDAE4	; 038047A6
	add r0,r6,#0x0	; 038047AA
	bl loc_037FDD58	; 038047AC
	ldr r1,[pool_038047C0]	; 038047B0
	ldrh r0,[r1,#0x0]	; 038047B2
	strh r4,[r1,#0x0]	; 038047B4
	add sp,#0x4	; 038047B6
	pop {r4,r5,r6,r7}	; 038047B8
	pop {r3}	; 038047BA
	bx r3	; 038047BC
	.byte 0xC0, 0x46	; 038047BE
pool_038047C0:
	.word REG_IME	; 038047C0
pool_038047C4:
	.word 0x01FFFFFF	; 038047C4
pool_038047C8:
	.word P2_BssStart + 0x269C	; 038047C8
pool_038047CC:
	.word P2_BssStart + 0x2698	; 038047CC
pool_038047D0:
	.word 0x00004000	; 038047D0
pool_038047D4:
	.word REG_KEYCNT	; 038047D4
pool_038047D8:
	.word 0x00001000	; 038047D8
pool_038047DC:
	.word 0x00400000	; 038047DC
pool_038047E0:
	.word REG_RCNT_ARM7	; 038047E0
pool_038047E4:
	.word 0x00008000	; 038047E4
pool_038047E8:
	.word 0x00000100	; 038047E8
pool_038047EC:
	.word 0x00100000	; 038047EC
pool_038047F0:
	.word 0x00002000	; 038047F0
pool_038047F4:
	.word P2_BssStart + 0x26A4	; 038047F4

; ===== function loc_038047F8 =====
loc_038047F8:
	ldr r0,[pool_03804800]	; 038047F8
	ldr r0,[r0,#0x0]	; 038047FA
	bx lr	; 038047FC
	.byte 0xC0, 0x46	; 03804800
pool_03804800:
loc_03804800:
	.word P2_BssStart + 0x26D4	; 03804800

; ===== function loc_03804804 =====
loc_03804804:
	cmp r0,#0xf	; 03804804
	bgt loc_03804812	; 03804806
	ldr r1,[pool_03804814]	; 03804808
	str r0,[r1,#0x0]	; 0380480A
	mov r1,#0x0	; 0380480C
	ldr r0,[pool_03804818]	; 0380480E
	str r1,[r0,#0x0]	; 03804810
loc_03804812:
	bx lr	; 03804812
pool_03804814:
loc_03804814:
	.word P2_BssStart + 0x26D4	; 03804814
pool_03804818:
loc_03804818:
	.word P2_BssStart + 0x26D0	; 03804818

; ===== function loc_0380481C =====
loc_0380481C:
	push {r4,r5,r6,lr}	; 0380481C
	ldr r0,[pool_038048BC]	; 0380481E
	ldr r3,[r0,#0x0]	; 03804820
	cmp r3,#0x0	; 03804822
	bne loc_0380483E	; 03804824
	mov r0,#0x3	; 03804826
	mov r1,#0x66	; 03804828
	mov r2,#0x1	; 0380482A
	add r3,r2,#0x0	; 0380482C
	bl loc_03802DE4	; 0380482E
	cmp r0,#0x0	; 03804832
	beq loc_038048B4	; 03804834
	mov r0,#0x1	; 03804836
	bl loc_03804804	; 03804838
	b loc_038048B4	; 0380483C
loc_0380483E:
	cmp r3,#0x4	; 0380483E
	bge loc_03804856	; 03804840
	ldr r0,[pool_038048C0]	; 03804842
	ldr r0,[r0,#0x0]	; 03804844
	cmp r3,r0	; 03804846
	beq loc_038048B4	; 03804848
	mov r0,#0x3	; 0380484A
	mov r1,#0x66	; 0380484C
	mov r2,#0x1	; 0380484E
	bl loc_03802DE4	; 03804850
	b loc_038048B4	; 03804854
loc_03804856:
	ldr r6,[pool_038048C4]	; 03804856
	sub r4,r3,#0x4	; 03804858
	mov r0,#0xc	; 0380485A
	mul r4,r0	; 0380485C
	add r5,r6,r4	; 0380485E
	ldr r0,[pool_038048C8]	; 03804860
	ldr r0,[r0,#0x0]	; 03804862
	ldrh r1,[r5,#0xa]	; 03804864
	bl loc_03803284	; 03804866
	add r2,r0,#0x0	; 0380486A
	mov r0,#0x0	; 0380486C
	ldr r1,[pool_038048CC]	; 0380486E
	bl loc_037FF97C	; 03804870
	ldr r3,[r6,r4]	; 03804874
	ldr r2,[r5,#0x4]	; 03804876
	and r2,r1	; 03804878
	and r3,r0	; 0380487A
	mov r0,#0x0	; 0380487C
	eor r2,r0	; 0380487E
	eor r3,r0	; 03804880
	orr r2,r3	; 03804882
	beq loc_0380488A	; 03804884
	mov r3,#0x1	; 03804886
	b loc_0380488C	; 03804888
loc_0380488A:
	mov r3,#0x2	; 0380488A
loc_0380488C:
	ldr r0,[pool_038048C8]	; 0380488C
	ldr r1,[r0,#0x0]	; 0380488E
	add r4,r1,#0x1	; 03804890
	str r4,[r0,#0x0]	; 03804892
	ldrh r2,[r5,#0x8]	; 03804894
	ldrh r1,[r5,#0xa]	; 03804896
	mul r2,r1	; 03804898
	cmp r4,r2	; 0380489A
	bcc loc_038048A2	; 0380489C
	mov r1,#0x0	; 0380489E
	str r1,[r0,#0x0]	; 038048A0
loc_038048A2:
	ldr r0,[pool_038048C0]	; 038048A2
	ldr r0,[r0,#0x0]	; 038048A4
	cmp r3,r0	; 038048A6
	beq loc_038048B4	; 038048A8
	mov r0,#0x3	; 038048AA
	mov r1,#0x66	; 038048AC
	mov r2,#0x1	; 038048AE
	bl loc_03802DE4	; 038048B0
loc_038048B4:
	pop {r4,r5,r6}	; 038048B4
	pop {r3}	; 038048B6
	bx r3	; 038048B8
	.byte 0xC0, 0x46	; 038048BC
pool_038048BC:
loc_038048BC:
	.word P2_BssStart + 0x26D4	; 038048BC
pool_038048C0:
loc_038048C0:
	.word P2_Data_0380534C	; 038048C0
pool_038048C4:
loc_038048C4:
	.word 0x03805350	; 038048C4
pool_038048C8:
loc_038048C8:
	.word P2_BssStart + 0x26D0	; 038048C8
pool_038048CC:
loc_038048CC:
	.word 0x80000000	; 038048CC

; ===== function loc_038048D0 =====
loc_038048D0:
	push {lr}	; 038048D0
	sub sp,#0x4	; 038048D2
	mov r0,#0x0	; 038048D4
	str r0,[sp,#0x0]	; 038048D6
	add r0,sp,#0x0	; 038048D8
	ldr r1,[pool_038048F0]	; 038048DA
	ldr r2,[pool_038048F4]	; 038048DC
	bl loc_0380495C	; 038048DE
	bl loc_037FB040	; 038048E2
	ldr r1,[pool_038048F0]	; 038048E6
	strh r0,[r1,#0x2]	; 038048E8
	add sp,#0x4	; 038048EA
	pop {r3}	; 038048EC
	bx r3	; 038048EE
pool_038048F0:
loc_038048F0:
	.word P2_BssStart + 0x26D8	; 038048F0
pool_038048F4:
loc_038048F4:
	.word 0x05000001	; 038048F4

; ===== function loc_038048F8 =====
loc_038048F8:
	push {lr}	; 038048F8
	sub sp,#0x4	; 038048FA
	ldr r0,[pool_03804914]	; 038048FC
	ldr r1,[r0,#0x0]	; 038048FE
	cmp r1,#0x0	; 03804900
	bne loc_0380490C	; 03804902
	mov r1,#0x1	; 03804904
	str r1,[r0,#0x0]	; 03804906
	bl loc_038048D0	; 03804908
loc_0380490C:
	add sp,#0x4	; 0380490C
	pop {r3}	; 0380490E
	bx r3	; 03804910
	.byte 0xC0, 0x46	; 03804914
pool_03804914:
loc_03804914:
	.word P2_BssStart + 0x26DC	; 03804914
	.byte 0x00, 0xDF, 0x70, 0x47	; 0380491C

; ===== function loc_0380491C =====
.func P2_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_0380491C:
	swi 0x3	; 0380491C
	bx lr	; 0380491E
.endfunc
; BIOS SWI #04 veneer: wait for selected IRQ flags; adjacent literal/setup bytes are retained.
; BIOS SWI #04 包装：等待指定 IRQ 标志；相邻字面量及设置字节保持原样。
.func P2_SwiIntrWaitVeneer
	ldr r2,[P2_SwiIntrWaitRegisterBase]
	mov r12,r2
	mov r2,#0x0
	swi 0x4
	bx lr
.endfunc
	.hword 0x0000	; literal alignment / 字面量对齐。
P2_SwiIntrWaitRegisterBase:
	.word REG_DISPCNT_A	; ARM7 I/O register base / ARM7 I/O 寄存器基址。
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
P2_SwiVBlankIntrWait:
	mov r2,#0x0
	swi 0x5
	bx lr

; ===== function loc_03804936 =====
.func P2_SwiHalt
; BIOS SWI #06: halt ARM7 until an interrupt. / BIOS SWI #06：使 ARM7 停止至中断发生。
loc_03804936:
	swi 0x6	; 03804936
	bx lr	; 03804938
.endfunc
.func P2_SwiStop
; BIOS SWI #07: enter STOP mode. / BIOS SWI #07：进入 STOP 模式。
	swi 0x7
	bx lr
.endfunc

.func P2_SwiSoundBias
; BIOS SWI #08: set the sound-bias state passed in r0. / BIOS SWI #08：按 r0 指定的状态设置声音偏置。
	swi 0x8
	bx lr
.endfunc

; ===== function loc_03804942 =====
.func P2_SwiSoundBiasIncrease
; BIOS SWI #08 wrapper: request sound-bias increase. / BIOS SWI #08 封装：请求提高声音偏置。
loc_03804942:
	add r1,r0,#0x0	; 03804942
	mov r0,#0x1	; 03804944
	swi 0x8	; 03804946
	bx lr	; 03804948
.endfunc

; ===== function loc_0380494A =====
.func P2_SwiSoundBiasDecrease
; BIOS SWI #08 wrapper: request sound-bias decrease. / BIOS SWI #08 封装：请求降低声音偏置。
loc_0380494A:
	add r1,r0,#0x0	; 0380494A
	mov r0,#0x0	; 0380494C
	swi 0x8	; 0380494E
	bx lr	; 03804950
.endfunc
.func P2_SwiDiv
; BIOS SWI #09: signed division, returning quotient. / BIOS SWI #09：有符号除法，返回商。
	swi 0x9
	bx lr
.endfunc
.func P2_SwiMod
; BIOS SWI #09 wrapper returning remainder. / BIOS SWI #09 包装：返回余数。
	swi 0x9
	add r0,r1,#0
	bx lr
.endfunc	; 0380495C

; ===== function loc_0380495C =====
.func P2_SwiCpuSet
; BIOS SWI #0B: configurable memory copy/fill. / BIOS SWI #0B：可配置的内存复制/填充。
loc_0380495C:
	swi 0xb	; 0380495C
	bx lr	; 0380495E
.endfunc

; ===== function loc_03804960 =====
.func P2_SwiCpuFastSet
; BIOS SWI #0C: fast 32-byte memory copy/fill. / BIOS SWI #0C：快速 32 字节内存复制/填充。
loc_03804960:
	swi 0xc	; 03804960
	bx lr	; 03804962
.endfunc
.func P2_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc
.func P2_SwiGetCrc16
; BIOS SWI #0E: calculate CRC-16. / BIOS SWI #0E：计算 CRC-16。
	swi 0xe
	bx lr
.endfunc
.func P2_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc
.func P2_SwiBitUnPack
; BIOS SWI #10: unpack bit fields. / BIOS SWI #10：展开位域数据。
	swi 0x10
	bx lr
.endfunc
.func P2_SwiLZ77UnCompWRAM
; BIOS SWI #11: decompress LZ77 into WRAM. / BIOS SWI #11：向 WRAM 解压 LZ77。
	swi 0x11
	bx lr
.endfunc
.func P2_SwiLZ77UnCompVRAM
; BIOS SWI #12: decompress LZ77 into VRAM. / BIOS SWI #12：向 VRAM 解压 LZ77。
	swi 0x12
	bx lr
.endfunc
.func P2_SwiHuffUnComp
; BIOS SWI #13: Huffman decompression. / BIOS SWI #13：Huffman 解压。
	swi 0x13
	bx lr
.endfunc
.func P2_SwiRLUnCompWRAM
; BIOS SWI #14: decompress run-length data into WRAM. / BIOS SWI #14：向 WRAM 解压游程编码数据。
	swi 0x14
	bx lr
.endfunc
.func P2_SwiRLUnCompVRAM
; BIOS SWI #15: decompress run-length data into VRAM. / BIOS SWI #15：向 VRAM 解压游程编码数据。
	swi 0x15
	bx lr
.endfunc
.func P2_SwiGetSineTable
; BIOS SWI #1A: obtain sine-table entry. / BIOS SWI #1A：取得正弦表项。
	swi 0x1a
	bx lr
.endfunc

; ===== function loc_0380498C =====
.func P2_SwiGetPitchTable
; BIOS SWI #1B: obtain pitch-table entry. / BIOS SWI #1B：取得音高表项。
loc_0380498C:
	swi 0x1b	; 0380498C
	bx lr	; 0380498E
.endfunc

; ===== function loc_03804990 =====
.func P2_SwiGetVolumeTable
; BIOS SWI #1C: obtain volume-table entry. / BIOS SWI #1C：取得音量表项。
loc_03804990:
	swi 0x1c	; 03804990
	bx lr	; 03804992
.endfunc
.arm

; ===== function loc_03804994 =====
loc_03804994:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804994
	mov r4,#0x0	; 03804998
	b loc_038049A8	; 0380499C
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 038049A8
loc_038049A8:
	orrs r5,r3,r2	; 038049A8
	bne loc_038049B8	; 038049AC
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049B0
	bx lr	; 038049B4
loc_038049B8:
	orrs r5,r1,r3	; 038049B8
	bne loc_03804A60	; 038049BC
	mov r1,r2	; 038049C0
	bl loc_03804E00	; 038049C4
	cmp r4,#0x0	; 038049C8
	movne r0,r1	; 038049CC
	mov r1,#0x0	; 038049D0
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049D4
	bx lr	; 038049D8
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 038049EC

; ===== function loc_038049EC =====
loc_038049EC:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049EC
	eor r4,r1,r3	; 038049F0
	mov r4,r4, asr #0x1	; 038049F4
	mov r4,r4, lsl #0x1	; 038049F8
	orrs r5,r3,r2	; 038049FC
	bne loc_03804A0C	; 03804A00
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804A04
	bx lr	; 03804A08
loc_03804A0C:
	mov r5,r0, lsr #0x1f	; 03804A0C
	add r5,r5,r1	; 03804A10
	mov r6,r2, lsr #0x1f	; 03804A14
	add r6,r6,r3	; 03804A18
	orrs r6,r5,r6	; 03804A1C
	bne loc_03804A40	; 03804A20
	mov r1,r2	; 03804A24
	bl loc_03804BEC	; 03804A28
	ands r4,r4,#0x1	; 03804A2C
	movne r0,r1	; 03804A30
	mov r1,r0, asr #0x1f	; 03804A34
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804A38
	bx lr	; 03804A3C
loc_03804A40:
	cmp r1,#0x0	; 03804A40
	bge loc_03804A50	; 03804A44
	rsbs r0,r0,#0x0	; 03804A48
	rsc r1,r1,#0x0	; 03804A4C
loc_03804A50:
	cmp r3,#0x0	; 03804A50
	bge loc_03804A60	; 03804A54
	rsbs r2,r2,#0x0	; 03804A58
	rsc r3,r3,#0x0	; 03804A5C
loc_03804A60:
	orrs r5,r1,r0	; 03804A60
	beq loc_03804B84	; 03804A64
	mov r5,#0x0	; 03804A68
	mov r6,#0x1	; 03804A6C
	cmp r3,#0x0	; 03804A70
	bmi loc_03804A8C	; 03804A74
loc_03804A78:
	add r5,r5,#0x1	; 03804A78
	adds r2,r2,r2	; 03804A7C
	adcs r3,r3,r3	; 03804A80
	bpl loc_03804A78	; 03804A84
	add r6,r6,r5	; 03804A88
loc_03804A8C:
	cmp r1,#0x0	; 03804A8C
	blt loc_03804AAC	; 03804A90
loc_03804A94:
	cmp r6,#0x1	; 03804A94
	beq loc_03804AAC	; 03804A98
	sub r6,r6,#0x1	; 03804A9C
	adds r0,r0,r0	; 03804AA0
	adcs r1,r1,r1	; 03804AA4
	bpl loc_03804A94	; 03804AA8
loc_03804AAC:
	mov r7,#0x0	; 03804AAC
	mov r12,#0x0	; 03804AB0
	mov r11,#0x0	; 03804AB4
	b loc_03804AD4	; 03804AB8
loc_03804ABC:
	orr r12,r12,#0x1	; 03804ABC
	subs r6,r6,#0x1	; 03804AC0
	beq loc_03804B2C	; 03804AC4
	adds r0,r0,r0	; 03804AC8
	adcs r1,r1,r1	; 03804ACC
	adcs r7,r7,r7	; 03804AD0
loc_03804AD4:
	subs r0,r0,r2	; 03804AD4
	sbcs r1,r1,r3	; 03804AD8
	sbcs r7,r7,#0x0	; 03804ADC
	adds r12,r12,r12	; 03804AE0
	adc r11,r11,r11	; 03804AE4
	cmp r7,#0x0	; 03804AE8
	bge loc_03804ABC	; 03804AEC
loc_03804AF0:
	subs r6,r6,#0x1	; 03804AF0
	beq loc_03804B24	; 03804AF4
	adds r0,r0,r0	; 03804AF8
	adcs r1,r1,r1	; 03804AFC
	adc r7,r7,r7	; 03804B00
	adds r0,r0,r2	; 03804B04
	adcs r1,r1,r3	; 03804B08
	adc r7,r7,#0x0	; 03804B0C
	adds r12,r12,r12	; 03804B10
	adc r11,r11,r11	; 03804B14
	cmp r7,#0x0	; 03804B18
	bge loc_03804ABC	; 03804B1C
	b loc_03804AF0	; 03804B20
loc_03804B24:
	adds r0,r0,r2	; 03804B24
	adc r1,r1,r3	; 03804B28
loc_03804B2C:
	ands r7,r4,#0x1	; 03804B2C
	moveq r0,r12	; 03804B30
	moveq r1,r11	; 03804B34
	beq loc_03804B64	; 03804B38
	subs r7,r5,#0x20	; 03804B3C
	movge r0,r1, lsr r7	; 03804B40
	bge loc_03804B88	; 03804B44
	rsb r7,r5,#0x20	; 03804B48
	mov r0,r0, lsr r5	; 03804B4C
	orr r0,r0,r1, lsl r7	; 03804B50
	mov r1,r1, lsr r5	; 03804B54
	b loc_03804B64	; 03804B58
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 03804B64
loc_03804B64:
	cmp r4,#0x0	; 03804B64
	blt loc_03804B74	; 03804B68
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B6C
	bx lr	; 03804B70
loc_03804B74:
	rsbs r0,r0,#0x0	; 03804B74
	rsc r1,r1,#0x0	; 03804B78
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B7C
	bx lr	; 03804B80
loc_03804B84:
	mov r0,#0x0	; 03804B84
loc_03804B88:
	mov r1,#0x0	; 03804B88
	cmp r4,#0x0	; 03804B8C
	blt loc_03804B74	; 03804B90
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B94
	bx lr	; 03804B98

; ===== function loc_03804B9C =====
loc_03804B9C:
	stmdb sp!,{r4,r5,lr}	; 03804B9C
	umull r5,r4,r0,r2	; 03804BA0
	mla r4,r0,r3,r4	; 03804BA4
	mla r4,r2,r1,r4	; 03804BA8
	mov r1,r4	; 03804BAC
	mov r0,r5	; 03804BB0
	ldmia sp!,{r4,r5,lr}	; 03804BB4
	bx lr	; 03804BB8

; ===== function loc_03804BBC =====
loc_03804BBC:
	ands r2,r2,#0x3f	; 03804BBC
	bxeq lr	; 03804BC0
	subs r3,r2,#0x20	; 03804BC4
	bge loc_03804BE0	; 03804BC8
	rsb r3,r2,#0x20	; 03804BCC
	mov r1,r1, lsl r2	; 03804BD0
	orr r1,r1,r0, lsr r3	; 03804BD4
	mov r0,r0, lsl r2	; 03804BD8
	bx lr	; 03804BDC
loc_03804BE0:
	mov r1,r0, lsl r3	; 03804BE0
	mov r0,#0x0	; 03804BE4
	bx lr	; 03804BE8

; Signed integer division: quotient in r0, remainder in r1.
; 有符号整数除法：商返回于 r0，余数返回于 r1。
P2_SignedDivMod:
loc_03804BEC:
	eor r12,r0,r1	; 03804BEC
	and r12,r12,#0x80000000	; 03804BF0
	cmp r0,#0x0	; 03804BF4
	rsblt r0,r0,#0x0	; 03804BF8
	addlt r12,r12,#0x1	; 03804BFC
	cmp r1,#0x0	; 03804C00
	rsblt r1,r1,#0x0	; 03804C04
	beq loc_03804DE4	; 03804C08
	cmp r0,r1	; 03804C0C
	movcc r1,r0	; 03804C10
	movcc r0,#0x0	; 03804C14
	bcc loc_03804DE4	; 03804C18
	mov r2,#0x1c	; 03804C1C
	mov r3,r0, lsr #0x4	; 03804C20
	cmp r1,r3, lsr #0xc	; 03804C24
	suble r2,r2,#0x10	; 03804C28
	movle r3,r3, lsr #0x10	; 03804C2C
	cmp r1,r3, lsr #0x4	; 03804C30
	suble r2,r2,#0x8	; 03804C34
	movle r3,r3, lsr #0x8	; 03804C38
	cmp r1,r3	; 03804C3C
	suble r2,r2,#0x4	; 03804C40
	movle r3,r3, lsr #0x4	; 03804C44
	mov r0,r0, lsl r2	; 03804C48
	rsb r1,r1,#0x0	; 03804C4C
	adds r0,r0,r0	; 03804C50
	add r2,r2,r2, lsl #0x1	; 03804C54
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804C58PC:
	add pc,pc,r2, lsl #0x2	; 03804C58
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804C60
loc_03804C60:
P2_DivisionDispatch_03804C58Steps:
	adcs r3,r1,r3, lsl #0x1	; 03804C60
	subcc r3,r3,r1	; 03804C64
	adcs r0,r0,r0	; 03804C68
	adcs r3,r1,r3, lsl #0x1	; 03804C6C
	subcc r3,r3,r1	; 03804C70
	adcs r0,r0,r0	; 03804C74
	adcs r3,r1,r3, lsl #0x1	; 03804C78
	subcc r3,r3,r1	; 03804C7C
	adcs r0,r0,r0	; 03804C80
	adcs r3,r1,r3, lsl #0x1	; 03804C84
	subcc r3,r3,r1	; 03804C88
	adcs r0,r0,r0	; 03804C8C
loc_03804C90:
	adcs r3,r1,r3, lsl #0x1	; 03804C90
	subcc r3,r3,r1	; 03804C94
	adcs r0,r0,r0	; 03804C98
	adcs r3,r1,r3, lsl #0x1	; 03804C9C
	subcc r3,r3,r1	; 03804CA0
	adcs r0,r0,r0	; 03804CA4
	adcs r3,r1,r3, lsl #0x1	; 03804CA8
	subcc r3,r3,r1	; 03804CAC
	adcs r0,r0,r0	; 03804CB0
	adcs r3,r1,r3, lsl #0x1	; 03804CB4
	subcc r3,r3,r1	; 03804CB8
	adcs r0,r0,r0	; 03804CBC
loc_03804CC0:
	adcs r3,r1,r3, lsl #0x1	; 03804CC0
	subcc r3,r3,r1	; 03804CC4
	adcs r0,r0,r0	; 03804CC8
	adcs r3,r1,r3, lsl #0x1	; 03804CCC
	subcc r3,r3,r1	; 03804CD0
	adcs r0,r0,r0	; 03804CD4
	adcs r3,r1,r3, lsl #0x1	; 03804CD8
	subcc r3,r3,r1	; 03804CDC
	adcs r0,r0,r0	; 03804CE0
	adcs r3,r1,r3, lsl #0x1	; 03804CE4
	subcc r3,r3,r1	; 03804CE8
	adcs r0,r0,r0	; 03804CEC
	adcs r3,r1,r3, lsl #0x1	; 03804CF0
	subcc r3,r3,r1	; 03804CF4
	adcs r0,r0,r0	; 03804CF8
	adcs r3,r1,r3, lsl #0x1	; 03804CFC
	subcc r3,r3,r1	; 03804D00
	adcs r0,r0,r0	; 03804D04
	adcs r3,r1,r3, lsl #0x1	; 03804D08
	subcc r3,r3,r1	; 03804D0C
	adcs r0,r0,r0	; 03804D10
	adcs r3,r1,r3, lsl #0x1	; 03804D14
	subcc r3,r3,r1	; 03804D18
	adcs r0,r0,r0	; 03804D1C
loc_03804D20:
	adcs r3,r1,r3, lsl #0x1	; 03804D20
	subcc r3,r3,r1	; 03804D24
	adcs r0,r0,r0	; 03804D28
	adcs r3,r1,r3, lsl #0x1	; 03804D2C
	subcc r3,r3,r1	; 03804D30
	adcs r0,r0,r0	; 03804D34
	adcs r3,r1,r3, lsl #0x1	; 03804D38
	subcc r3,r3,r1	; 03804D3C
	adcs r0,r0,r0	; 03804D40
	adcs r3,r1,r3, lsl #0x1	; 03804D44
	subcc r3,r3,r1	; 03804D48
	adcs r0,r0,r0	; 03804D4C
	adcs r3,r1,r3, lsl #0x1	; 03804D50
	subcc r3,r3,r1	; 03804D54
	adcs r0,r0,r0	; 03804D58
	adcs r3,r1,r3, lsl #0x1	; 03804D5C
	subcc r3,r3,r1	; 03804D60
	adcs r0,r0,r0	; 03804D64
	adcs r3,r1,r3, lsl #0x1	; 03804D68
	subcc r3,r3,r1	; 03804D6C
	adcs r0,r0,r0	; 03804D70
	adcs r3,r1,r3, lsl #0x1	; 03804D74
	subcc r3,r3,r1	; 03804D78
	adcs r0,r0,r0	; 03804D7C
	adcs r3,r1,r3, lsl #0x1	; 03804D80
	subcc r3,r3,r1	; 03804D84
	adcs r0,r0,r0	; 03804D88
	adcs r3,r1,r3, lsl #0x1	; 03804D8C
	subcc r3,r3,r1	; 03804D90
	adcs r0,r0,r0	; 03804D94
	adcs r3,r1,r3, lsl #0x1	; 03804D98
	subcc r3,r3,r1	; 03804D9C
	adcs r0,r0,r0	; 03804DA0
	adcs r3,r1,r3, lsl #0x1	; 03804DA4
	subcc r3,r3,r1	; 03804DA8
	adcs r0,r0,r0	; 03804DAC
	adcs r3,r1,r3, lsl #0x1	; 03804DB0
	subcc r3,r3,r1	; 03804DB4
	adcs r0,r0,r0	; 03804DB8
	adcs r3,r1,r3, lsl #0x1	; 03804DBC
	subcc r3,r3,r1	; 03804DC0
	adcs r0,r0,r0	; 03804DC4
	adcs r3,r1,r3, lsl #0x1	; 03804DC8
	subcc r3,r3,r1	; 03804DCC
	adcs r0,r0,r0	; 03804DD0
	adcs r3,r1,r3, lsl #0x1	; 03804DD4
	subcc r3,r3,r1	; 03804DD8
	adcs r0,r0,r0	; 03804DDC
P2_DivisionDispatch_03804C58End:
.if (P2_DivisionDispatch_03804C58Steps != P2_DivisionDispatch_03804C58PC + 8) || (P2_DivisionDispatch_03804C58End - P2_DivisionDispatch_03804C58Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03804DE0
loc_03804DE4:
	ands r3,r12,#0x80000000	; 03804DE4
	rsbne r0,r0,#0x0	; 03804DE8
	ands r3,r12,#0x1	; 03804DEC
	rsbne r1,r1,#0x0	; 03804DF0
	bx lr	; 03804DF4

; ===== function loc_03804DF8 =====
loc_03804DF8:
	cmp r1,#0x0	; 03804DF8
	bxeq lr	; 03804DFC

; ===== function loc_03804E00 =====
loc_03804E00:
	cmp r0,r1	; 03804E00
	movcc r1,r0	; 03804E04
	movcc r0,#0x0	; 03804E08
	bxcc lr	; 03804E0C
	mov r2,#0x1c	; 03804E10
	mov r3,r0, lsr #0x4	; 03804E14
	cmp r1,r3, lsr #0xc	; 03804E18
	suble r2,r2,#0x10	; 03804E1C
	movle r3,r3, lsr #0x10	; 03804E20
	cmp r1,r3, lsr #0x4	; 03804E24
	suble r2,r2,#0x8	; 03804E28
	movle r3,r3, lsr #0x8	; 03804E2C
	cmp r1,r3	; 03804E30
	suble r2,r2,#0x4	; 03804E34
	movle r3,r3, lsr #0x4	; 03804E38
	mov r0,r0, lsl r2	; 03804E3C
	rsb r1,r1,#0x0	; 03804E40
	adds r0,r0,r0	; 03804E44
	add r2,r2,r2, lsl #0x1	; 03804E48
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804E4CPC:
	add pc,pc,r2, lsl #0x2	; 03804E4C
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804E54
loc_03804E54:
P2_DivisionDispatch_03804E4CSteps:
	adcs r3,r1,r3, lsl #0x1	; 03804E54
	subcc r3,r3,r1	; 03804E58
	adcs r0,r0,r0	; 03804E5C
	adcs r3,r1,r3, lsl #0x1	; 03804E60
	subcc r3,r3,r1	; 03804E64
	adcs r0,r0,r0	; 03804E68
	adcs r3,r1,r3, lsl #0x1	; 03804E6C
	subcc r3,r3,r1	; 03804E70
	adcs r0,r0,r0	; 03804E74
	adcs r3,r1,r3, lsl #0x1	; 03804E78
	subcc r3,r3,r1	; 03804E7C
	adcs r0,r0,r0	; 03804E80
loc_03804E84:
	adcs r3,r1,r3, lsl #0x1	; 03804E84
	subcc r3,r3,r1	; 03804E88
	adcs r0,r0,r0	; 03804E8C
	adcs r3,r1,r3, lsl #0x1	; 03804E90
	subcc r3,r3,r1	; 03804E94
	adcs r0,r0,r0	; 03804E98
	adcs r3,r1,r3, lsl #0x1	; 03804E9C
	subcc r3,r3,r1	; 03804EA0
	adcs r0,r0,r0	; 03804EA4
	adcs r3,r1,r3, lsl #0x1	; 03804EA8
	subcc r3,r3,r1	; 03804EAC
	adcs r0,r0,r0	; 03804EB0
loc_03804EB4:
	adcs r3,r1,r3, lsl #0x1	; 03804EB4
	subcc r3,r3,r1	; 03804EB8
	adcs r0,r0,r0	; 03804EBC
	adcs r3,r1,r3, lsl #0x1	; 03804EC0
	subcc r3,r3,r1	; 03804EC4
	adcs r0,r0,r0	; 03804EC8
	adcs r3,r1,r3, lsl #0x1	; 03804ECC
	subcc r3,r3,r1	; 03804ED0
	adcs r0,r0,r0	; 03804ED4
	adcs r3,r1,r3, lsl #0x1	; 03804ED8
	subcc r3,r3,r1	; 03804EDC
	adcs r0,r0,r0	; 03804EE0
	adcs r3,r1,r3, lsl #0x1	; 03804EE4
	subcc r3,r3,r1	; 03804EE8
	adcs r0,r0,r0	; 03804EEC
	adcs r3,r1,r3, lsl #0x1	; 03804EF0
	subcc r3,r3,r1	; 03804EF4
	adcs r0,r0,r0	; 03804EF8
	adcs r3,r1,r3, lsl #0x1	; 03804EFC
	subcc r3,r3,r1	; 03804F00
	adcs r0,r0,r0	; 03804F04
	adcs r3,r1,r3, lsl #0x1	; 03804F08
	subcc r3,r3,r1	; 03804F0C
	adcs r0,r0,r0	; 03804F10
loc_03804F14:
	adcs r3,r1,r3, lsl #0x1	; 03804F14
	subcc r3,r3,r1	; 03804F18
	adcs r0,r0,r0	; 03804F1C
	adcs r3,r1,r3, lsl #0x1	; 03804F20
	subcc r3,r3,r1	; 03804F24
	adcs r0,r0,r0	; 03804F28
	adcs r3,r1,r3, lsl #0x1	; 03804F2C
	subcc r3,r3,r1	; 03804F30
	adcs r0,r0,r0	; 03804F34
	adcs r3,r1,r3, lsl #0x1	; 03804F38
	subcc r3,r3,r1	; 03804F3C
	adcs r0,r0,r0	; 03804F40
	adcs r3,r1,r3, lsl #0x1	; 03804F44
	subcc r3,r3,r1	; 03804F48
	adcs r0,r0,r0	; 03804F4C
	adcs r3,r1,r3, lsl #0x1	; 03804F50
	subcc r3,r3,r1	; 03804F54
	adcs r0,r0,r0	; 03804F58
	adcs r3,r1,r3, lsl #0x1	; 03804F5C
	subcc r3,r3,r1	; 03804F60
	adcs r0,r0,r0	; 03804F64
	adcs r3,r1,r3, lsl #0x1	; 03804F68
	subcc r3,r3,r1	; 03804F6C
	adcs r0,r0,r0	; 03804F70
	adcs r3,r1,r3, lsl #0x1	; 03804F74
	subcc r3,r3,r1	; 03804F78
	adcs r0,r0,r0	; 03804F7C
	adcs r3,r1,r3, lsl #0x1	; 03804F80
	subcc r3,r3,r1	; 03804F84
	adcs r0,r0,r0	; 03804F88
	adcs r3,r1,r3, lsl #0x1	; 03804F8C
	subcc r3,r3,r1	; 03804F90
	adcs r0,r0,r0	; 03804F94
	adcs r3,r1,r3, lsl #0x1	; 03804F98
	subcc r3,r3,r1	; 03804F9C
	adcs r0,r0,r0	; 03804FA0
	adcs r3,r1,r3, lsl #0x1	; 03804FA4
	subcc r3,r3,r1	; 03804FA8
	adcs r0,r0,r0	; 03804FAC
	adcs r3,r1,r3, lsl #0x1	; 03804FB0
	subcc r3,r3,r1	; 03804FB4
	adcs r0,r0,r0	; 03804FB8
	adcs r3,r1,r3, lsl #0x1	; 03804FBC
	subcc r3,r3,r1	; 03804FC0
	adcs r0,r0,r0	; 03804FC4
	adcs r3,r1,r3, lsl #0x1	; 03804FC8
	subcc r3,r3,r1	; 03804FCC
	adcs r0,r0,r0	; 03804FD0
P2_DivisionDispatch_03804E4CEnd:
.if (P2_DivisionDispatch_03804E4CSteps != P2_DivisionDispatch_03804E4CPC + 8) || (P2_DivisionDispatch_03804E4CEnd - P2_DivisionDispatch_03804E4CSteps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03804FD4
	bx lr	; 03804FD8

; ===== function loc_03804FDC =====
loc_03804FDC:
	ands r2,r2,#0x3f	; 03804FDC
	bxeq lr	; 03804FE0
	subs r3,r2,#0x20	; 03804FE4
	bge loc_03805000	; 03804FE8
	rsb r3,r2,#0x20	; 03804FEC
	mov r0,r0, lsr r2	; 03804FF0
	orr r0,r0,r1, lsl r3	; 03804FF4
	mov r1,r1, lsr r2	; 03804FF8
	bx lr	; 03804FFC
loc_03805000:
	mov r0,r1, lsr r3	; 03805000
	mov r1,#0x0	; 03805004
	bx lr	; 03805008

; ===== function loc_0380500C =====
loc_0380500C:
	stmdb sp!,{lr}	; 0380500C
	bl loc_038050B4	; 03805010
	mov r1,#0x0	; 03805014
	str r1,[r0,#0x0]	; 03805018
	bl loc_038050C0	; 0380501C
	mov r1,#0x0	; 03805020
	str r1,[r0,#0x4]	; 03805024
	str r1,[r0,#0x8]	; 03805028
	str r1,[r0,#0xc]	; 0380502C
	str r1,[r0,#0x10]	; 03805030
	str r1,[r0,#0x14]	; 03805034
	ldmia sp!,{lr}	; 03805038
	bx lr	; 0380503C
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x1A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805050
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03805060
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 03805070
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 03805080
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x0A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805090
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 038050A0
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 038050B0
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 038050B4

; ===== function loc_038050B4 =====
loc_038050B4:
	ldr r12,[pool_038050BC]	; 038050B4
	bx r12	; 038050B8
pool_038050BC:
loc_038050BC:
	.word loc_03805104 + 1	; 038050BC

; ===== function loc_038050C0 =====
loc_038050C0:
	ldr r12,[pool_038050C8]	; 038050C0
	bx r12	; 038050C4
pool_038050C8:
loc_038050C8:
	.word loc_0380510C + 1	; 038050C8
.thumb

; ===== function loc_038050CC =====
loc_038050CC:
	bx r0	; 038050CC
	.byte 0x00, 0x00	; 038050D0

; ===== function loc_038050D0 =====
loc_038050D0:
	bx r1	; 038050D0
	.byte 0x00, 0x00	; 038050D4

; ===== function loc_038050D4 =====
loc_038050D4:
	bx r2	; 038050D4
	.byte 0x00, 0x00	; 038050D8

; ===== function loc_038050D8 =====
loc_038050D8:
	bx r3	; 038050D8
	.byte 0x00, 0x00	; 038050DC

; ===== function loc_038050DC =====
loc_038050DC:
	bx r4	; 038050DC
	.byte 0x00, 0x00	; 038050E0

; ===== function loc_038050E0 =====
loc_038050E0:
	bx r5	; 038050E0
	.byte 0x00, 0x00	; 038050E4

; ===== function loc_038050E4 =====
loc_038050E4:
	push {r4,lr}	; 038050E4
	ldr r4,[pool_03805100]	; 038050E6
	b loc_038050EE	; 038050E8
loc_038050EA:
	.byte 0x80, 0x47, 0x24, 0x1D	; 038050EE
loc_038050EE:
	cmp r4,#0x0	; 038050EE
	beq loc_038050F8	; 038050F0
	ldr r0,[r4,#0x0]	; 038050F2
	cmp r0,#0x0	; 038050F4
	bne loc_038050EA	; 038050F6
loc_038050F8:
	pop {r4}	; 038050F8
	pop {r3}	; 038050FA
	bx r3	; 038050FC
	.byte 0xC0, 0x46	; 03805100
pool_03805100:
loc_03805100:
	.word 0x03805290	; 03805100

; ===== function loc_03805104 =====
loc_03805104:
	ldr r0,[pool_03805108]	; 03805104
	bx lr	; 03805106
pool_03805108:
loc_03805108:
	.word 0x03807AC0	; 03805108

; ===== function loc_0380510C =====
loc_0380510C:
	ldr r0,[pool_03805110]	; 0380510C
	bx lr	; 0380510E
pool_03805110:
loc_03805110:
	.word 0x03807AC4	; 03805110
	.byte 0xE5, 0x50, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00	; 03805114
P2_Data_03805120:
	.byte 0x49, 0x32, 0x00, 0x00	; 03805120
P2_Data_03805124:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 03805124
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 03805134
P2_Data_03805144:
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 03805144
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 03805154
	.byte 0x7F, 0x00, 0x00, 0x00	; 03805164
P2_Data_03805168:
	.byte 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 03805168
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 03805174
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 03805184
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 03805194
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 038051A4
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 038051B4
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 038051C4
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 038051D4
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 038051E4
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 038051F4
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 03805204
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 03805214
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 03805224
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 03805234
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 03805244
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 03805254
	.byte 0xFF, 0xFF, 0x00, 0x00	; 03805264
P2_Data_03805268:
	.byte 0x00, 0x01, 0x02, 0x04	; 03805268
P2_Data_0380526C:
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 0380526C
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D	; 03805274
P2_Data_0380527C:
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 0380527C
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805284
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P2_CrtDataInitTable:
	.word P2_CopyDescriptors, P2_CopyDescriptorsEnd
	.word P2_WramCopy0LoadStart
	.word P2_BssStart, P2_BssEnd
P2_Data_038052A8:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 038052A8
	.byte 0x00, 0x00, 0x00, 0x00	; 038052B8
P2_Data_038052BC:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P2_IrqHandlers:
	.word P2_IrqHandler_037FD9A0 + 1	; IRQ 0
	.word loc_037FDA90 + 1	; IRQ 1
	.word loc_037FDA90 + 1	; IRQ 2
	.word P2_IrqHandler_037FD9F8 + 1	; IRQ 3
	.word P2_IrqHandler_037FD9EC + 1	; IRQ 4
	.word P2_IrqHandler_037FD9E0 + 1	; IRQ 5
	.word P2_IrqHandler_037FD9D4 + 1	; IRQ 6
	.word loc_037FDA90 + 1	; IRQ 7
	.word P2_IrqHandler_037FDA28 + 1	; IRQ 8
	.word P2_IrqHandler_037FDA1C + 1	; IRQ 9
	.word P2_IrqHandler_037FDA10 + 1	; IRQ 10
	.word P2_IrqHandler_037FDA04 + 1	; IRQ 11
	.word loc_037FDA90 + 1	; IRQ 12
	.word loc_037FDA90 + 1	; IRQ 13
	.word loc_037FDA90 + 1	; IRQ 14
	.word loc_037FDA90 + 1	; IRQ 15
	.word loc_037FDA90 + 1	; IRQ 16
	.word loc_037FDA90 + 1	; IRQ 17
	.word loc_037FDA90 + 1	; IRQ 18
	.word loc_037FDA90 + 1	; IRQ 19
	.word loc_037FDA90 + 1	; IRQ 20
	.word loc_037FDA90 + 1	; IRQ 21
	.word loc_037FDA90 + 1	; IRQ 22
	.word loc_037FDA90 + 1	; IRQ 23
	.word loc_037FDA90 + 1	; IRQ 24
P2_IrqHandlersEnd:
	.byte 0x61, 0xDE, 0x7F, 0x03	; 03805320
.thumb
P2_Data_03805324:
	.word 0x12345678	; 03805334
; ARM7 sound-alarm diagnostic string. / ARM7 声音告警诊断字符串。
P2_SoundAlarmDiagnosticText:
	.ascii "Failed sound alarm OS_SendMessage"
	.byte 0x0A, 0x00, 0x00	; 03805349
P2_Data_0380534C:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x08	; 0380534C
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC, 0x08, 0x00, 0x01, 0x00, 0x00	; 03805359
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805369
	.byte 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0xF8, 0x14	; 03805379
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x0C, 0x00, 0x01, 0x00, 0x00	; 03805389
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805399
	.byte 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x20	; 038053A9
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00	; 038053B9
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053C9
	.byte 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00	; 038053D9
; CRT 复制后，此保存区复用为主 BSS；下游偏移仍保留原内存布局。
; After CRT copying, reuse this load area as BSS; keep the original field offsets.
P2_BssStart:
; 本 CPU 的 32 项 FIFO 回调表，按通道索引；位于 CRT 清零的 BSS。
; This CPU's 32 FIFO callback slots, indexed by channel, live in CRT-cleared BSS.
.definelabel P2_PxiReceiveCallbacks, P2_BssStart + 0x1D3C
.definelabel P2_PxiReceiveCallbacksEnd, P2_PxiReceiveCallbacks + PxiFifoChannelCount * 4
.definelabel P2_CachedFirmwareHeader, P2_BssStart + 0x2C
.definelabel P2_BssEnd, P2_BssStart + 0x26FC

; 按运行地址汇编；物理字节仍保留在组件的初始化数据区。
; Assemble at the copied execution address; keep bytes in the load image.
P2_WramCopy0LoadStart:
.headersize 0x037F8000 - orga()
P2_WramCopy0RuntimeStart:

P2_DeferredPatchEntryImage:
.definelabel P2_DeferredPatchEntryFileOffset, orga()
; 按共享 RAM 中的实际执行地址汇编；这些字节先随 P2 复制到 WRAM。
; Assemble for execution in shared RAM; these bytes first travel with P2 into WRAM.
.headersize P2_DeferredPatchOriginalEntry + 4 - orga()
.arm
; 安装 20 字节补丁，清空 r0-r2，跳回保存的 ARM7 程序入口。
; Install the 20-byte patch, clear r0-r2, then jump to the saved ARM7 program entry.
.func P2_DeferredRuntimePatchEntry
	sub r0,pc,#(P2_DeferredRuntimePatchEntry + 8 - P2_DeferredPatchPayload)
	ldr r1,[P2_DeferredPatchDestination]
	mov r2,#(P2_DeferredPatchPayloadBytes / 4)
	swi 0xc0000
	ldr r12,[P2_DeferredPatchOriginalEntry]
	mov lr,r12
	mov r0,#0x0
	mov r1,r0
	mov r2,r0
	bx r12
.endfunc
P2_DeferredRuntimePatchEntryEnd:
.headersize P2_DeferredPatchEntryImage - P2_DeferredPatchEntryFileOffset
P2_DeferredPatchEntryImageEnd:
P2_Runtime_037F8028:
.thumb
; 保存补丁、目标和原 ARM7 入口，再复制 40 字节入口代码到共享 RAM。
; Save the patch, destination and original ARM7 entry; copy a 40-byte entry stub to shared RAM.
.func P2_PrepareDeferredRuntimePatch
	push {r4,r5,lr}	; 037F8028
	sub sp,#0x4	; 037F802A
	ldr r3,[pool_037F8060]	; 037F802C
	ldr r2,[pool_037F8064]	; 037F802E
	mov r5,#0x0	; 037F8030
P2_Runtime_037F8032:
	ldr r4,[r1,#0x0]	; 037F8032
	add r1,r1,#0x4	; 037F8034
	stmia r3!,{r4}	; 037F8036
	add r5,r5,#0x1	; 037F8038
	cmp r5,#(P2_DeferredPatchPayloadBytes / 4)	; 037F803A
	blt P2_Runtime_037F8032	; 037F803C
	str r0,[r3,#0x0]	; 037F803E
	add r1,r3,#0x4	; 037F8040
	add r3,#0x8	; 037F8042
	ldr r0,[pool_037F8068]	; 037F8044
	ldr r0,[r0,#0x0]	; 037F8046
	str r0,[r1,#0x0]	; 037F8048
	mov r1,#0x0	; 037F804A
P2_Runtime_037F804C:
	ldr r0,[r2,#0x0]	; 037F804C
	add r2,r2,#0x4	; 037F804E
	stmia r3!,{r0}	; 037F8050
	add r1,r1,#0x1	; 037F8052
	cmp r1,#((P2_DeferredRuntimePatchEntryEnd - P2_DeferredRuntimePatchEntry) / 4)	; 037F8054
	blt P2_Runtime_037F804C	; 037F8056
	add sp,#0x4	; 037F8058
	pop {r4,r5}	; 037F805A
	pop {r3}	; 037F805C
	bx r3	; 037F805E
.endfunc
pool_037F8060:
	.word P2_DeferredPatchPayload	; 037F8060
pool_037F8064:
	.word P2_DeferredPatchEntryImage	; 037F8064
pool_037F8068:
	.word NdsCartHeaderArm7EntryAddress	; 037F8068
P2_Runtime_037F806C:
; r0=模式、r1=字数、r2=结果偏移；扫描 ARM9 或 ARM7 暂存代码，未命中返回 0。
; r0=pattern, r1=word count, r2=result offset; scan ARM9 or staged ARM7 code, returning 0 on miss.
.func P2_FindRuntimePatchPattern
	push {r4,r5,r6,r7,lr}	; 037F806C
	sub sp,#0xc	; 037F806E
	str r1,[sp,#0x0]	; 037F8070
	str r2,[sp,#0x4]	; 037F8072
	ldr r1,[pool_037F80E4]	; 037F8074
	cmp r0,r1	; 037F8076
	bne P2_Runtime_037F808E	; 037F8078
	ldr r1,[pool_037F80E8]	; 037F807A
	ldr r6,[r1,#0x0]	; 037F807C
	ldr r1,[pool_037F80EC]	; 037F807E
	ldr r2,[r1,#0x0]	; 037F8080
	ldr r1,[pool_037F80F0]	; 037F8082
	ldr r1,[r1,#0x0]	; 037F8084
	sub r1,r6,r1	; 037F8086
	sub r1,r2,r1	; 037F8088
	lsr r5,r1,#0x2	; 037F808A
	b P2_Runtime_037F80D0	; 037F808C
P2_Runtime_037F808E:
	ldr r6,[pool_037F80F4]	; 037F808E
	ldr r1,[pool_037F80F8]	; 037F8090
	ldr r1,[r1,#0x0]	; 037F8092
	lsr r5,r1,#0x2	; 037F8094
	b P2_Runtime_037F80D0	; 037F8096
P2_Runtime_037F8098:
	ldr r2,[r6,#0x0]	; 037F8098
	add r6,r6,#0x4	; 037F809A
	ldr r1,[r0,#0x0]	; 037F809C
	cmp r2,r1	; 037F809E
	bne P2_Runtime_037F80D0	; 037F80A0
	add r4,r0,#0x4	; 037F80A2
	add r3,r6,#0x0	; 037F80A4
	ldr r1,[sp,#0x0]	; 037F80A6
	sub r2,r1,#0x1	; 037F80A8
	cmp r5,r2	; 037F80AA
	blt P2_Runtime_037F80D8	; 037F80AC
	b P2_Entry_037F80BC	; 037F80AE
P2_Runtime_037F80B0:
	ldr r1,[r4,#0x0]	; 037F80B0
	add r4,r4,#0x4	; 037F80B2
	ldr r7,[r3,#0x0]	; 037F80B4
	add r3,r3,#0x4	; 037F80B6
	cmp r1,r7	; 037F80B8
	bne P2_Runtime_037F80C4	; 037F80BA
P2_Entry_037F80BC:
	add r1,r2,#0x0	; 037F80BC
	sub r2,r2,#0x1	; 037F80BE
	cmp r1,#0x0	; 037F80C0
	bne P2_Runtime_037F80B0	; 037F80C2
P2_Runtime_037F80C4:
	cmp r2,#0x0	; 037F80C4
	bge P2_Runtime_037F80D0	; 037F80C6
	sub r1,r6,#0x4	; 037F80C8
	ldr r0,[sp,#0x4]	; 037F80CA
	add r0,r1,r0	; 037F80CC
	b P2_Entry_037F80DA	; 037F80CE
P2_Runtime_037F80D0:
	add r1,r5,#0x0	; 037F80D0
	sub r5,r5,#0x1	; 037F80D2
	cmp r1,#0x0	; 037F80D4
	bne P2_Runtime_037F8098	; 037F80D6
P2_Runtime_037F80D8:
	mov r0,#0x0	; 037F80D8
P2_Entry_037F80DA:
	add sp,#0xc	; 037F80DA
	pop {r4,r5,r6,r7}	; 037F80DC
	pop {r3}	; 037F80DE
	bx r3	; 037F80E0
.endfunc
	.byte 0xC0, 0x46	; 037F80E2
pool_037F80E4:
	.word P2_RuntimePatchArm9Marker	; 037F80E4
pool_037F80E8:
	.word NdsCartHeaderArm9EntryAddress	; 037F80E8
pool_037F80EC:
	.word NdsCartHeaderArm9SizeAddress	; 037F80EC
pool_037F80F0:
	.word NdsCartHeaderArm9RamAddress	; 037F80F0
pool_037F80F4:
	.word 0x022C0000	; 037F80F4
pool_037F80F8:
	.word NdsCartHeaderArm7SizeAddress	; 037F80F8
P2_Runtime_037F80FC:
; 查找 ARM9 标记并检查其前一字数值，决定是否继续寻找 ARM7 补丁点。
; Find the ARM9 marker and test the preceding value before looking for an ARM7 patch site.
.func P2_CheckArm9RuntimePatchGate
	push {lr}	; 037F80FC
	sub sp,#0x4	; 037F80FE
	ldr r0,[pool_037F8138]	; 037F8100
	mov r1,#0x2	; 037F8102
	mov r2,#0x3	; 037F8104
	mvn r2,r2	; 037F8106
	bl P2_FindRuntimePatchPattern	; 037F8108
	cmp r0,#0x0	; 037F810C
	bne P2_Runtime_037F8114	; 037F810E
	mov r0,#0x0	; 037F8110
	b P2_Entry_037F8132	; 037F8112
P2_Runtime_037F8114:
	ldr r1,[r0,#0x0]	; 037F8114
	ldr r0,[pool_037F813C]	; 037F8116
	cmp r1,r0	; 037F8118
	bcc P2_Runtime_037F8126	; 037F811A
	ldr r0,[pool_037F8140]	; 037F811C
	cmp r1,r0	; 037F811E
	bcc P2_Runtime_037F8130	; 037F8120
	mov r0,#0x0	; 037F8122
	b P2_Entry_037F8132	; 037F8124
P2_Runtime_037F8126:
	ldr r0,[pool_037F8144]	; 037F8126
	cmp r1,r0	; 037F8128
	bcc P2_Runtime_037F8130	; 037F812A
	mov r0,#0x0	; 037F812C
	b P2_Entry_037F8132	; 037F812E
P2_Runtime_037F8130:
	mov r0,#0x1	; 037F8130
P2_Entry_037F8132:
	add sp,#0x4	; 037F8132
	pop {r3}	; 037F8134
	bx r3	; 037F8136
.endfunc
pool_037F8138:
	.word P2_RuntimePatchArm9Marker	; 037F8138
pool_037F813C:
	.word 0x03000000	; 037F813C
pool_037F8140:
	.word 0x03004F4C	; 037F8140
pool_037F8144:
	.word 0x02027533	; 037F8144
P2_Runtime_037F8148:
; 按指令模式定位 ARM7 补丁点；模式 1 立即覆盖，否则安排入口处延后覆盖。
; Locate an ARM7 patch by instruction patterns; mode 1 patches now, otherwise defer to entry.
.func P2_ApplyPatternSelectedRuntimePatch
	push {r4,lr}	; 037F8148
	bl P2_CheckArm9RuntimePatchGate	; 037F814A
	cmp r0,#0x0	; 037F814E
	beq P2_Runtime_037F81AC	; 037F8150
	ldr r4,[pool_037F81B4]	; 037F8152
	ldr r0,[pool_037F81B8]	; 037F8154
	mov r1,#0xe	; 037F8156
	mov r2,#0x18	; 037F8158
	bl P2_FindRuntimePatchPattern	; 037F815A
	add r1,r0,#0x0	; 037F815E
	cmp r1,#0x0	; 037F8160
	bne P2_Runtime_037F8172	; 037F8162
	ldr r4,[pool_037F81BC]	; 037F8164
	ldr r0,[pool_037F81C0]	; 037F8166
	mov r1,#0xe	; 037F8168
	mov r2,#0x4	; 037F816A
	bl P2_FindRuntimePatchPattern	; 037F816C
	add r1,r0,#0x0	; 037F8170
P2_Runtime_037F8172:
	cmp r1,#0x0	; 037F8172
	beq P2_Runtime_037F81AC	; 037F8174
	ldr r0,[pool_037F81C4]	; 037F8176
	ldrb r0,[r0,#0x0]	; 037F8178
	cmp r0,#0x1	; 037F817A
	bne P2_Runtime_037F8188	; 037F817C
	add r0,r4,#0x0	; 037F817E
	mov r2,#(P2_DeferredPatchPayloadBytes / 4)	; 037F8180
	bl P2_SwiCpuFastSet	; 037F8182
	b P2_Runtime_037F81AC	; 037F8186
P2_Runtime_037F8188:
	ldr r0,[pool_037F81C8]	; 037F8188
	ldrh r0,[r0,#0x0]	; 037F818A
	cmp r0,#0x2	; 037F818C
	bne P2_Runtime_037F8196	; 037F818E
	ldr r0,[pool_037F81CC]	; 037F8190
	ldr r2,[r0,#0x0]	; 037F8192
	b P2_Entry_037F819A	; 037F8194
P2_Runtime_037F8196:
	ldr r0,[pool_037F81D0]	; 037F8196
	ldr r2,[r0,#0x0]	; 037F8198
P2_Entry_037F819A:
	ldr r0,[pool_037F81D4]	; 037F819A
	sub r0,r1,r0	; 037F819C
	add r0,r0,r2	; 037F819E
	add r1,r4,#0x0	; 037F81A0
	bl P2_PrepareDeferredRuntimePatch	; 037F81A2
	ldr r1,[pool_037F81D8]	; 037F81A6
	ldr r0,[pool_037F81DC]	; 037F81A8
	str r1,[r0,#0x0]	; 037F81AA
P2_Runtime_037F81AC:
	pop {r4}	; 037F81AC
	pop {r3}	; 037F81AE
	bx r3	; 037F81B0
.endfunc
	.byte 0xC0, 0x46	; 037F81B2
pool_037F81B4:
	.word P2_RuntimePatchTemplateB	; 037F81B4
pool_037F81B8:
	.word P2_RuntimePatchPatternB	; 037F81B8
pool_037F81BC:
	.word P2_RuntimePatchTemplateA	; 037F81BC
pool_037F81C0:
	.word P2_RuntimePatchPatternA	; 037F81C0
pool_037F81C4:
	.word FirmwareBootSharedAddress + BootSharedRuntimePatchModeOffset	; 037F81C4
pool_037F81C8:
	.word FirmwareBootParamAddress	; 037F81C8
pool_037F81CC:
	.word NdsCartHeaderArm7RamAddress	; 037F81CC
pool_037F81D0:
	.word FirmwareBootSharedAddress	; 037F81D0
pool_037F81D4:
	.word 0x022C0000	; 037F81D4
pool_037F81D8:
	.word P2_DeferredRuntimePatchEntry	; 037F81D8
pool_037F81DC:
	.word NdsCartHeaderArm7EntryAddress	; 037F81DC

P2_RuntimePatchArm9Marker:
; 逐字匹配的数据，不作为此处的指令执行。 / Word-matching data, not instructions executed here.
	.word 0xDEC00621, 0x2106C0DE

P2_RuntimePatchTemplateA:
; 复制到外部程序的编码模板，不在此地址执行。
; Encoded template copied into an external program, not executed here.
	.word 0xE3500005, 0x3A000002, 0xE1D100B0, 0xE3500008
	.word 0x9AFFFFF6

P2_RuntimePatchTemplateB:
; 复制到外部程序的编码模板，不在此地址执行。
; Encoded template copied into an external program, not executed here.
	.word 0xE3500005, 0x312FFF1E, 0xE1D100B0, 0xE3500008
	.word 0x9AFFFFF6

P2_RuntimePatchPatternA:
; 逐字匹配的数据，不作为此处的指令执行。 / Word-matching data, not instructions executed here.
	.word 0xE1D100B0, 0xE3500006, 0x0AFFFFF9, 0xE1D100B0
	.word 0xE3500005, 0x0AFFFFF6, 0xE3A01000, 0xE59F0068
	.word 0xE1C010B0, 0xE59F0064, 0xE1C010B0, 0xE59F004C
	.word 0xE5900000, 0xE2800C03

P2_RuntimePatchPatternB:
; 逐字匹配的数据，不作为此处的指令执行。 / Word-matching data, not instructions executed here.
	.word 0xE59F1028, 0xE59F2028, 0xE1D200B0, 0xE2100001
	.word 0x1AFFFFFC, 0xE1D100B0, 0xE3500006, 0x0AFFFFF9
	.word 0xE1D100B0, 0xE3500005, 0x0AFFFFF6, 0xE12FFF1E
	.word 0x04808214, 0x0480819C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8280
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8290
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82A0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82B0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82C0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82D0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82E0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82F0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8300
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8310
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8320
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8330
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8340
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8350
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8360
P2_Runtime_037F8370:
	push {r4,r5,r6,lr}	; 037F8370
	ldr r0,[pool_037F83A4]	; 037F8372
	bl P2_Entry_037FE478	; 037F8374
	ldr r6,[pool_037F83A8]	; 037F8378
	ldr r5,[pool_037F83AC]	; 037F837A
	mov r4,#0x1	; 037F837C
	b P2_Entry_037F8386	; 037F837E
P2_Runtime_037F8380:
	add r0,r6,#0x0	; 037F8380
	bl P2_SwiWaitByLoop	; 037F8382
P2_Entry_037F8386:
	ldrh r1,[r5,#0x0]	; 037F8386
	add r0,r1,#0x0	; 037F8388
	and r0,r4	; 037F838A
	cmp r0,#0x0	; 037F838C
	bne P2_Runtime_037F8380	; 037F838E
	mov r0,#0x1	; 037F8390
	orr r1,r0	; 037F8392
	strh r1,[r5,#0x0]	; 037F8394
	ldr r0,[pool_037F83B0]	; 037F8396
	ldr r0,[r0,#0x18]	; 037F8398
	ldr r0,[r0,#0x8]	; 037F839A
	pop {r4,r5,r6}	; 037F839C
	pop {r3}	; 037F839E
	bx r3	; 037F83A0
	.byte 0xC0, 0x46	; 037F83A2
pool_037F83A4:
	.word P4_ServicePrimaryThreadRecord	; 037F83A4
pool_037F83A8:
	.word 0x00000100	; 037F83A8
pool_037F83AC:
	.word 0x027FFF96	; 037F83AC
pool_037F83B0:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 037F83B0
P2_Runtime_037F83B4:
	push {r4,r5,r6,lr}	; 037F83B4
	ldr r0,[pool_037F83E0]	; 037F83B6
	bl P2_Entry_037FE478	; 037F83B8
	ldr r6,[pool_037F83E4]	; 037F83BC
	ldr r5,[pool_037F83E8]	; 037F83BE
	mov r4,#0x1	; 037F83C0
	b P2_Entry_037F83CA	; 037F83C2
P2_Runtime_037F83C4:
	add r0,r6,#0x0	; 037F83C4
	bl P2_SwiWaitByLoop	; 037F83C6
P2_Entry_037F83CA:
	ldrh r0,[r5,#0x0]	; 037F83CA
	and r0,r4	; 037F83CC
	cmp r0,#0x0	; 037F83CE
	bne P2_Runtime_037F83C4	; 037F83D0
	ldr r0,[pool_037F83E0]	; 037F83D2
	bl P2_Entry_037FE434	; 037F83D4
	pop {r4,r5,r6}	; 037F83D8
	pop {r3}	; 037F83DA
	bx r3	; 037F83DC
	.byte 0xC0, 0x46	; 037F83DE
pool_037F83E0:
	.word P4_ServicePrimaryThreadRecord	; 037F83E0
pool_037F83E4:
	.word 0x00000100	; 037F83E4
pool_037F83E8:
	.word 0x027FFF96	; 037F83E8
P2_Runtime_037F83EC:
	push {r4,r5,r6,r7,lr}	; 037F83EC
	sub sp,#0x4	; 037F83EE
	add r5,r0,#0x0	; 037F83F0
	ldr r4,[pool_037F841C]	; 037F83F2
	mov r6,#0xa	; 037F83F4
	mov r7,#0x0	; 037F83F6
	b P2_Entry_037F8400	; 037F83F8
P2_Runtime_037F83FA:
	add r0,r4,#0x0	; 037F83FA
	bl P2_SwiWaitByLoop	; 037F83FC
P2_Entry_037F8400:
	add r0,r6,#0x0	; 037F8400
	add r1,r5,#0x0	; 037F8402
	add r2,r7,#0x0	; 037F8404
	bl loc_03801F84	; 037F8406
	cmp r0,#0x0	; 037F840A
	blt P2_Runtime_037F83FA	; 037F840C
	ldr r0,[pool_037F8420]	; 037F840E
	bl P2_Entry_037FE434	; 037F8410
	add sp,#0x4	; 037F8414
	pop {r4,r5,r6,r7}	; 037F8416
	pop {r3}	; 037F8418
	bx r3	; 037F841A
pool_037F841C:
	.word 0x00000100	; 037F841C
pool_037F8420:
	.word P4_ServicePrimaryThreadRecord	; 037F8420
P2_WramCopy0RuntimeEnd:
.definelabel P2_WramCopy0ZeroBytes, 0x0
.definelabel P2_WramCopy0BssStart, P2_WramCopy0RuntimeEnd
.definelabel P2_WramCopy0BssEnd, P2_WramCopy0BssStart + P2_WramCopy0ZeroBytes
; P4 服务线程使用的两个栈顶 / Stack tops used by P4 service threads.
.definelabel P2_P4ServicePrimaryThreadStackTop, P2_WramCopy0RuntimeStart + 0x2F8
.definelabel P2_P4ServiceSecondaryThreadStackTop, P2_WramCopy0RuntimeStart + 0x280
.headersize 0x037FA800
P2_WramCopy0LoadEnd:

; 按运行地址汇编；物理字节仍保留在组件的初始化数据区。
; Assemble at the copied execution address; keep bytes in the load image.
P2_WramCopy1LoadStart:
.headersize 0x0380F600 - orga()
P2_WramCopy1RuntimeStart:
.arm
	add r12,r1,r2	; 0380F600
P2_Entry_0380F604:
	cmp r1,r12	; 0380F604
	ldmltia r0!,{r2}	; 0380F608
	stmltia r1!,{r2}	; 0380F60C
	blt P2_Entry_0380F604	; 0380F610
	bx lr	; 0380F614
.thumb
P2_Runtime_0380F618:
.thumb
; 保存 r0 的用户回调，设置启动参数并注册通道 1 接收入口。
; Save the r0 user callback, set the boot parameter and register channel 1.
.func P2_InitPxiChannel1Callback
	push {r4,lr}	; 0380F618
	add r4,r0,#0x0	; 0380F61A
	bl loc_03801EA4	; 0380F61C
	ldr r0,[pool_0380F640]	; 0380F620
	str r4,[r0,#0x0]	; 0380F622
	ldr r1,[pool_0380F644]	; 0380F624
	ldrh r0,[r1,#0x0]	; 0380F626
	cmp r0,#0x2	; 0380F628
	beq P2_Runtime_0380F630	; 0380F62A
	mov r0,#0x1	; 0380F62C
	strh r0,[r1,#0x0]	; 0380F62E
P2_Runtime_0380F630:
	mov r0,#0x1	; 0380F630
	ldr r1,[pool_0380F648]	; 0380F632
	bl P2_SetPxiReceiveCallback	; 0380F634
	pop {r4}	; 0380F638
	pop {r3}	; 0380F63A
	bx r3	; 0380F63C
.endfunc
	.byte 0xC0, 0x46	; 0380F63E
pool_0380F640:
	.word P2_PxiChannel1UserCallbackSlot	; 0380F640
pool_0380F644:
	.word FirmwareBootParamAddress	; 0380F644
pool_0380F648:
	.word P2_PxiChannel1Callback + 1	; 0380F648
; Thumb veneer: loads the next block entry with its Thumb state bit, then branches.
; Thumb 跳板：读入带 Thumb 状态位的下一块入口后跳转。
P2_RuntimeThumbVeneer_0380F64C:
	ldr r3,[P2_RuntimeThumbVeneerTarget]	; 0380F64C
	bx r3	; 0380F64E
P2_RuntimeThumbVeneerTarget:
	.word P2_Code_0380F678 + 1	; 0380F650
; 仅在通道=1、数据=1 且用户回调非空时，间接调用该回调。
; Invoke the saved callback only for channel 1/data 1 and a non-null callback.
.func P2_PxiChannel1Callback
	push {lr}	; 0380F654
	sub sp,#0x4	; 0380F656
	cmp r0,#0x1	; 0380F658
	bne P2_Entry_0380F66C	; 0380F65A
	cmp r1,#0x1	; 0380F65C
	bne P2_Entry_0380F66C	; 0380F65E
	ldr r0,[pool_0380F674]	; 0380F660
	ldr r0,[r0,#0x0]	; 0380F662
	cmp r0,#0x0	; 0380F664
	beq P2_Entry_0380F66C	; 0380F666
	bl loc_038050CC	; 0380F668
P2_Entry_0380F66C:
	add sp,#0x4	; 0380F66C
	pop {r3}	; 0380F66E
	bx r3	; 0380F670
.endfunc
	.byte 0xC0, 0x46	; 0380F672
pool_0380F674:
	.word P2_PxiChannel1UserCallbackSlot	; 0380F674
P2_Code_0380F678:
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x04, 0x48, 0x00, 0x88, 0x02, 0x28, 0x02, 0xD1, 0x03, 0x48, 0x00, 0xF0	; 0380F678
	.byte 0x29, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x40, 0xFC, 0x7F, 0x02, 0x40, 0xE8, 0x3F, 0x02	; 0380F688
	.byte 0x70, 0xB5, 0x0E, 0x1C, 0x00, 0x28, 0x13, 0xD0, 0x00, 0x25, 0x04, 0x1C, 0x0C, 0x34, 0x28, 0x01	; 0380F698
	.byte 0x22, 0x18, 0xD0, 0x68, 0xC0, 0x07, 0xC0, 0x0F, 0xB0, 0x42, 0x06, 0xD1, 0x51, 0x68, 0x10, 0x68	; 0380F6A8
	.byte 0x88, 0x42, 0x02, 0xD0, 0x92, 0x68, 0x00, 0xF0, 0x07, 0xF8, 0x6D, 0x1C, 0x03, 0x2D, 0xEE, 0xDB	; 0380F6B8
	.byte 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 0380F6C8
	.byte 0x00, 0xF6, 0x80, 0x03, 0x10, 0xB5, 0x04, 0x1C, 0x00, 0x21, 0xFF, 0xF7, 0xD9, 0xFF, 0x20, 0x1C	; 0380F6D8
	.byte 0x01, 0x21, 0xFF, 0xF7, 0xD5, 0xFF, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0380F6E8
P2_WramCopy1RuntimeEnd:
.definelabel P2_WramCopy1ZeroBytes, 0x4
.definelabel P2_WramCopy1BssStart, P2_WramCopy1RuntimeEnd
.definelabel P2_PxiChannel1UserCallbackSlot, P2_WramCopy1BssStart
.definelabel P2_WramCopy1BssEnd, P2_WramCopy1BssStart + P2_WramCopy1ZeroBytes
.headersize 0x037FA800
P2_WramCopy1LoadEnd:

; 按运行地址汇编；物理字节仍保留在组件的初始化数据区。
; Assemble at the copied execution address; keep bytes in the load image.
P2_WramCopy2LoadStart:
.headersize 0x0380F6F8 - orga()
P2_WramCopy2RuntimeStart:
P2_Runtime_0380F6F8:
.arm
	mov r11,lr	; 0380F6F8
	ldr r0,[pool_0380F764]	; 0380F6FC
	add r1,r0,#0x40000	; 0380F700
	bl P2_Runtime_0380F8B0	; 0380F704
	add r0,r0,#0x40000	; 0380F708
	ldr r1,[pool_0380F768]	; 0380F70C
	bl P2_Runtime_0380F8B0	; 0380F710
	ldr r0,[pool_0380F76C]	; 0380F714
	ldr r1,[pool_0380F770]	; 0380F718
	bl P2_Runtime_0380F8B0	; 0380F71C
	ldr r3,[pool_0380F774]	; 0380F720
	ldrh r1,[r3,#0x0]	; 0380F724
	cmp r1,#0x2	; 0380F728
	beq P2_Runtime_0380F760	; 0380F72C
	ldr r3,[pool_0380F778]	; 0380F730
	ldr r1,[r3,#0x0]	; 0380F734
	cmp r1,#0x0	; 0380F738
	beq P2_Runtime_0380F760	; 0380F73C
	ldr r3,[pool_0380F77C]	; 0380F740
	ldr r0,[r3,#0x38]	; 0380F744
	ldr r2,[r3,#0x3c]	; 0380F748
	str r1,[r3,#0x38]	; 0380F74C
	bl P2_WramCopy1RuntimeStart	; 0380F750
	ldr r0,[pool_0380F780]	; 0380F754
	add r1,r0,#0x40000	; 0380F758
	bl P2_Runtime_0380F8B0	; 0380F75C
P2_Runtime_0380F760:
	bx r11	; 0380F760
pool_0380F764:
	.word 0x02280000	; 0380F764
pool_0380F768:
	.word 0x023FE800	; 0380F768
pool_0380F76C:
	.word P2_WramCopy0RuntimeStart	; 0380F76C
pool_0380F770:
	.word P2_WramCopy1RuntimeStart	; 0380F770
pool_0380F774:
	.word FirmwareBootParamAddress	; 0380F774
pool_0380F778:
	.word FirmwareBootSharedAddress	; 0380F778
pool_0380F77C:
	.word NdsCartHeaderRamAddress	; 0380F77C
pool_0380F780:
	.word 0x022C0000	; 0380F780
P2_Runtime_0380F784:
	mov r12,lr	; 0380F784
	mov r0,#0xd3	; 0380F788
	msr cpsr_cxsf,r0	; 0380F78C
	ldr sp,[pool_0380F810]	; 0380F790
	mov lr,#0x0	; 0380F794
	msr spsr_cxsf,lr	; 0380F798
	mov r0,#0xd2	; 0380F79C
	msr cpsr_cxsf,r0	; 0380F7A0
	ldr r2,[pool_0380F814]	; 0380F7A4
	mov sp,r2	; 0380F7A8
	mov lr,#0x0	; 0380F7AC
	msr spsr_cxsf,lr	; 0380F7B0
	mov r0,#0xdf	; 0380F7B4
	msr cpsr_cxsf,r0	; 0380F7B8
	mov r1,#0x200	; 0380F7BC
	sub r1,r2,r1	; 0380F7C0
	mov sp,r1	; 0380F7C4
	ldr r2,[pool_0380F818]	; 0380F7C8
	sub r0,r2,#0x600	; 0380F7CC
	mov r1,r2	; 0380F7D0
	bl P2_Runtime_0380F8B0	; 0380F7D4
	sub r0,r2,#0xa00	; 0380F7D8
	ldr r1,[pool_0380F81C]	; 0380F7DC
	bl P2_Runtime_0380F8B0	; 0380F7E0
	ldr r2,[pool_0380F820]	; 0380F7E4
	mov r0,r2	; 0380F7E8
	add r1,r2,#0x800	; 0380F7EC
	bl P2_Runtime_0380F8B0	; 0380F7F0
	add r0,r2,#0xd80	; 0380F7F4
	add r1,r0,#0x80	; 0380F7F8
	bl P2_Runtime_0380F8B0	; 0380F7FC
	add r0,r2,#0xf80	; 0380F800
	add r1,r0,#0x80	; 0380F804
	bl P2_Runtime_0380F8B0	; 0380F808
	bx r12	; 0380F80C
pool_0380F810:
	.word 0x0380FFC0	; 0380F810
pool_0380F814:
	.word 0x0380FF80	; 0380F814
pool_0380F818:
	.word 0x03810000	; 0380F818
pool_0380F81C:
	.word P2_WramCopy2RuntimeStart	; 0380F81C
pool_0380F820:
	.word 0x027FF000	; 0380F820

; 与 ARM9 完成 IPC 握手和内存准备，再跳至 NDS 头指定的 ARM7 入口。
; Finish IPC handshaking and memory setup, then enter the NDS header's ARM7 entry.
.func P2_SyncAndEnterArm7Program
	ldr r1,[pool_0380F8A0]	; 0380F824
	mov r0,#0x200	; 0380F828
	strh r0,[r1,#0x0]	; 0380F82C
P2_Runtime_0380F830:
	ldrh r0,[r1,#0x0]	; 0380F830
	and r0,r0,#0xf	; 0380F834
	cmp r0,#0x2	; 0380F838
	bne P2_Runtime_0380F830	; 0380F83C
	bl P2_Runtime_0380F6F8	; 0380F840
	ldr r1,[pool_0380F8A4]	; 0380F844
	bl P2_Runtime_0380F8AC	; 0380F848
	ldr r1,[pool_0380F8A0]	; 0380F84C
	mov r0,#0x100	; 0380F850
	strh r0,[r1,#0x0]	; 0380F854
P2_Runtime_0380F858:
	ldrh r0,[r1,#0x0]	; 0380F858
	and r0,r0,#0xf	; 0380F85C
	cmp r0,#0x1	; 0380F860
	bne P2_Runtime_0380F858	; 0380F864
	bl P2_Runtime_0380F784	; 0380F868
	ldr r1,[pool_0380F8A0]	; 0380F86C
	mov r0,#0x0	; 0380F870
	strh r0,[r1,#0x0]	; 0380F874
P2_Runtime_0380F878:
	ldrh r0,[r1,#0x0]	; 0380F878
	cmp r0,#0x1	; 0380F87C
	beq P2_Runtime_0380F878	; 0380F880
	ldr r3,[pool_0380F8A8]	; 0380F884
	ldr r12,[r3,#-0x1cc]	; 0380F888
	mov lr,r12	; 0380F88C
	mov r11,#0x4000000	; 0380F890
	ldmdb r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 0380F894
	mov r11,#0x0	; 0380F898
	bx r12	; 0380F89C
.endfunc
pool_0380F8A0:
	.word REG_IPC_SYNC	; 0380F8A0
pool_0380F8A4:
	.word P2_RuntimeThumbVeneer_0380F64C + 1	; 0380F8A4
pool_0380F8A8:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 0380F8A8
P2_Runtime_0380F8AC:
	bx r1	; 0380F8AC
P2_Runtime_0380F8B0:
	mov r3,#0x0	; 0380F8B0
	mov r4,r3	; 0380F8B4
	mov r5,r3	; 0380F8B8
	mov r6,r3	; 0380F8BC
	mov r7,r3	; 0380F8C0
	mov r8,r3	; 0380F8C4
	mov r9,r3	; 0380F8C8
	mov r10,r3	; 0380F8CC
P2_Runtime_0380F8D0:
	cmp r0,r1	; 0380F8D0
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 0380F8D4
	blt P2_Runtime_0380F8D0	; 0380F8D8
	bx lr	; 0380F8DC
P2_WramCopy2RuntimeEnd:
.definelabel P2_WramCopy2ZeroBytes, 0x0
.definelabel P2_WramCopy2BssStart, P2_WramCopy2RuntimeEnd
.definelabel P2_WramCopy2BssEnd, P2_WramCopy2BssStart + P2_WramCopy2ZeroBytes
.headersize 0x037FA800
P2_WramCopy2LoadEnd:
P2_CopyDescriptors:
	.word P2_WramCopy0RuntimeStart, P2_WramCopy0RuntimeEnd - P2_WramCopy0RuntimeStart, P2_WramCopy0ZeroBytes
	.word P2_WramCopy1RuntimeStart, P2_WramCopy1RuntimeEnd - P2_WramCopy1RuntimeStart, P2_WramCopy1ZeroBytes
	.word P2_WramCopy2RuntimeStart, P2_WramCopy2RuntimeEnd - P2_WramCopy2RuntimeStart, P2_WramCopy2ZeroBytes
P2_CopyDescriptorsEnd:
.arm
.close

; 延迟补丁阶段复用早期启动信息暂存区：补丁、目标地址、原入口，随后是入口代码。
; Deferred patching reuses the early boot-info scratch: payload, destination, saved entry, then code.
.definelabel P2_DeferredPatchPayload, FirmwareBootInfoScratchAddress
.definelabel P2_DeferredPatchPayloadBytes, 20
.definelabel P2_DeferredPatchDestination, P2_DeferredPatchPayload + P2_DeferredPatchPayloadBytes
.definelabel P2_DeferredPatchOriginalEntry, P2_DeferredPatchDestination + 4
