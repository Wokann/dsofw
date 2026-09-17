; official_v2_p2
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
	bl loc_03802934	; 037FA870
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
	.word P2_RunFunctionPointerList + 1	; 037FA8B4

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
	.word P2_Data_03802A48	; 037FA988
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
	ldr r1,[pool_037FAA64]	; 037FA9E8
	ldrh r0,[r1,#0x0]	; 037FA9EA
	mov r0,#0x0	; 037FA9EC
	strh r0,[r1,#0x0]	; 037FA9EE
	bl loc_037FB5C8	; 037FA9F0
	mov r0,#0x0	; 037FA9F4
	str r0,[sp,#0x0]	; 037FA9F6
	ldr r1,[pool_037FAA68]	; 037FA9F8
	add r0,sp,#0x0	; 037FA9FA
	ldr r2,[pool_037FAA6C]	; 037FA9FC
	sub r2,r2,r1	; 037FA9FE
	lsr r2,r2,#0x2	; 037FAA00
	ldr r3,[pool_037FAA70]	; 037FAA02
	and r2,r3	; 037FAA04
	ldr r3,[pool_037FAA74]	; 037FAA06
	orr r2,r3	; 037FAA08
	bl P2_SwiCpuFastSet	; 037FAA0A
	mov r4,#0x0	; 037FAA0E
loc_037FAA10:
	add r0,r4,#0x0	; 037FAA10
	bl loc_037FCCD0	; 037FAA12
	add r4,r4,#0x1	; 037FAA16
	cmp r4,#0x3	; 037FAA18
	ble loc_037FAA10	; 037FAA1A
	mov r0,#0x0	; 037FAA1C
	str r0,[sp,#0x4]	; 037FAA1E
	add r0,sp,#0x4	; 037FAA20
	ldr r1,[pool_037FAA78]	; 037FAA22
	ldr r2,[pool_037FAA7C]	; 037FAA24
	bl P2_SwiCpuFastSet	; 037FAA26
	mov r0,#0x0	; 037FAA2A
	str r0,[sp,#0x8]	; 037FAA2C
	add r0,sp,#0x8	; 037FAA2E
	ldr r1,[pool_037FAA80]	; 037FAA30
	ldr r2,[pool_037FAA84]	; 037FAA32
	bl P2_SwiCpuFastSet	; 037FAA34
	mov r0,#0x0	; 037FAA38
	str r0,[sp,#0xc]	; 037FAA3A
	add r0,sp,#0xc	; 037FAA3C
	ldr r1,[pool_037FAA88]	; 037FAA3E
	ldr r2,[pool_037FAA8C]	; 037FAA40
	bl P2_SwiCpuFastSet	; 037FAA42
	mov r2,#0x0	; 037FAA46
	ldr r0,[pool_037FAA90]	; 037FAA48
	strh r2,[r0,#0x0]	; 037FAA4A
	ldr r0,[pool_037FAA94]	; 037FAA4C
	strh r2,[r0,#0x0]	; 037FAA4E
	ldr r1,[pool_037FAA98]	; 037FAA50
	ldr r0,[pool_037FAA9C]	; 037FAA52
	strh r1,[r0,#0x0]	; 037FAA54
	mvn r0,r2	; 037FAA56
	bl loc_037FB54C	; 037FAA58
	add sp,#0x10	; 037FAA5C
	pop {r4}	; 037FAA5E
	pop {r3}	; 037FAA60
	bx r3	; 037FAA62
.endfunc
pool_037FAA64:
loc_037FAA64:
	.word REG_IME	; 037FAA64
pool_037FAA68:
loc_037FAA68:
	.word 0x038053D4	; 037FAA68
pool_037FAA6C:
loc_037FAA6C:
	.word P2_WramCopy1RuntimeStart	; 037FAA6C
pool_037FAA70:
loc_037FAA70:
	.word 0x001FFFFF	; 037FAA70
pool_037FAA74:
loc_037FAA74:
	.word 0x01000000	; 037FAA74
pool_037FAA78:
loc_037FAA78:
	.word REG_DMA0SAD	; 037FAA78
pool_037FAA7C:
loc_037FAA7C:
	.word 0x01000023	; 037FAA7C
pool_037FAA80:
loc_037FAA80:
	.word SCHANNEL0_CR	; 037FAA80
pool_037FAA84:
loc_037FAA84:
	.word 0x01000041	; 037FAA84
pool_037FAA88:
loc_037FAA88:
	.word REG_SNDCAP0CNT	; 037FAA88
pool_037FAA8C:
loc_037FAA8C:
	.word 0x01000005	; 037FAA8C
pool_037FAA90:
loc_037FAA90:
	.word REG_DISPSTAT	; 037FAA90
pool_037FAA94:
loc_037FAA94:
	.word REG_SPICNT	; 037FAA94
pool_037FAA98:
loc_037FAA98:
	.word 0x00004008	; 037FAA98
pool_037FAA9C:
loc_037FAA9C:
	.word REG_IPC_FIFO_CR	; 037FAA9C

; Stages header-described firmware P3 and P4 consecutively for ARM9 boot.
; 将头部描述的固件 P3、P4 连续暂存，供 ARM9 启动使用。
.func P2_LoadSecondaryFirmwarePartsToStaging
loc_037FAAA0:
	push {r4,lr}	; 037FAAA0
	ldr r1,[pool_037FAAE8]	; 037FAAA2
	ldrh r0,[r1,#0x0]	; 037FAAA4
	lsl r0,r0,#0x3	; 037FAAA6
	ldrh r2,[r1,#0x2]	; 037FAAA8
	lsl r4,r2,#0x3	; 037FAAAA
	ldrh r2,[r1,#0x4]	; 037FAAAC
	ldr r1,[pool_037FAAEC]	; 037FAAAE
	strh r2,[r1,#0x0]	; 037FAAB0
	ldr r1,[pool_037FAAF0]	; 037FAAB2
	mov r2,#0x0	; 037FAAB4
	mov r3,#0x1	; 037FAAB6
	bl P2_SubmitTransferRequest	; 037FAAB8
	ldr r1,[pool_037FAAF4]	; 037FAABC
	ldr r0,[pool_037FAAF8]	; 037FAABE
	str r1,[r0,#0x0]	; 037FAAC0
	ldr r0,[pool_037FAAFC]	; 037FAAC2
	ldr r1,[r0,#0xc]	; 037FAAC4
	ldr r0,[pool_037FAAF0]	; 037FAAC6
	add r0,r1,r0	; 037FAAC8
	ldr r1,[pool_037FAB00]	; 037FAACA
	str r0,[r1,#0x0]	; 037FAACC
	add r0,r4,#0x0	; 037FAACE
	ldr r1,[r1,#0x0]	; 037FAAD0
	mov r2,#0x0	; 037FAAD2
	mov r3,#0x1	; 037FAAD4
	bl P2_SubmitTransferRequest	; 037FAAD6
	ldr r0,[pool_037FAB04]	; 037FAADA
	bl P2_OrSharedEventFlags	; 037FAADC
	pop {r4}	; 037FAAE0
	pop {r3}	; 037FAAE2
	bx r3	; 037FAAE4
.endfunc
	.byte 0xC0, 0x46	; 037FAAE8
pool_037FAAE8:
loc_037FAAE8:
	.word P2_CachedFirmwareHeader	; 037FAAE8
pool_037FAAEC:
loc_037FAAEC:
	.word FirmwareBootSharedAddress + BootSharedP3P4Crc16Offset	; 037FAAEC
pool_037FAAF0:
loc_037FAAF0:
	.word FirmwareComponentStagingAddress	; 037FAAF0
pool_037FAAF4:
loc_037FAAF4:
	.word P4_FirmwareServiceEntry	; 037FAAF4
pool_037FAAF8:
loc_037FAAF8:
	.word FirmwareBootSharedAddress + BootSharedP4DestinationOffset	; 037FAAF8
pool_037FAAFC:
loc_037FAAFC:
	.word P2_BssStart + 0x14	; 037FAAFC
pool_037FAB00:
loc_037FAB00:
	.word FirmwareBootSharedAddress + BootSharedP4StagingOffset	; 037FAB00
pool_037FAB04:
loc_037FAB04:
	.word 0x00001000	; 037FAB04

; Stages header-described firmware P5 for the next ARM9 boot stage.
; 将头部描述的固件 P5 暂存，供下一 ARM9 启动阶段使用。
.func P2_LoadFirmwarePart5ToStaging
loc_037FAB08:
	push {lr}	; 037FAB08
	sub sp,#0x4	; 037FAB0A
	ldr r1,[pool_037FAB30]	; 037FAB0C
	ldrh r0,[r1,#0x16]	; 037FAB0E
	lsl r0,r0,#0x3	; 037FAB10
	ldrh r2,[r1,#0x26]	; 037FAB12
	ldr r1,[pool_037FAB34]	; 037FAB14
	strh r2,[r1,#0x0]	; 037FAB16
	ldr r1,[pool_037FAB38]	; 037FAB18
	mov r2,#0x0	; 037FAB1A
	mov r3,#0x1	; 037FAB1C
	bl P2_SubmitTransferRequest	; 037FAB1E
	ldr r0,[pool_037FAB3C]	; 037FAB22
	bl P2_OrSharedEventFlags	; 037FAB24
	add sp,#0x4	; 037FAB28
	pop {r3}	; 037FAB2A
	bx r3	; 037FAB2C
.endfunc
	.byte 0xC0, 0x46	; 037FAB30
pool_037FAB30:
loc_037FAB30:
	.word P2_CachedFirmwareHeader	; 037FAB30
pool_037FAB34:
loc_037FAB34:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 037FAB34
pool_037FAB38:
loc_037FAB38:
	.word FirmwareComponentStagingAddress	; 037FAB38
pool_037FAB3C:
loc_037FAB3C:
	.word 0x00002000	; 037FAB3C

; Cache the SPI firmware header and publish header[0x20] * 8 as the settings address.
; 缓存 SPI 固件头，将头部 [0x20] * 8 发布为用户设置地址。
.func P2_LoadFirmwareHeaderAndSettingsOffset
loc_037FAB40:
	push {lr}	; 037FAB40
	sub sp,#0x4	; 037FAB42
	mov r0,#0x0	; 037FAB44
	ldr r1,[pool_037FAB60]	; 037FAB46
	mov r2,#0x2c	; 037FAB48
	add r3,r0,#0x0	; 037FAB4A
	bl P2_SubmitTransferRequest	; 037FAB4C
	ldr r0,[pool_037FAB60]	; 037FAB50
	ldrh r0,[r0,#0x20]	; 037FAB52
	lsl r1,r0,#0x3	; 037FAB54
	ldr r0,[pool_037FAB64]	; 037FAB56
	str r1,[r0,#0x0]	; 037FAB58
	add sp,#0x4	; 037FAB5A
	pop {r3}	; 037FAB5C
	bx r3	; 037FAB5E
.endfunc
pool_037FAB60:
loc_037FAB60:
	.word P2_CachedFirmwareHeader	; 037FAB60
pool_037FAB64:
loc_037FAB64:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 037FAB64

; ===== function P2_ClearMainRamOutsideArm9Image =====
; Clears the main-RAM ranges before and after the ARM9 image described by NDS header +0x28/+0x2C.
; 按 NDS 头 +0x28/+0x2C 所述 ARM9 映像，清零其前后两段主 RAM。
.func P2_ClearMainRamOutsideArm9Image
loc_037FAB68:
	push {lr}	; 037FAB68
	sub sp,#0xc	; 037FAB6A
	ldr r1,[pool_037FABC0]	; 037FAB6C
	ldr r0,[pool_037FABC4]	; 037FAB6E
	ldr r0,[r0,#0x0]	; 037FAB70
	cmp r0,r1	; 037FAB72
	bls loc_037FAB90	; 037FAB74
	sub r2,r0,r1	; 037FAB76
	cmp r2,#0x0	; 037FAB78
	beq loc_037FAB90	; 037FAB7A
	mov r0,#0x0	; 037FAB7C
	str r0,[sp,#0x0]	; 037FAB7E
	add r0,sp,#0x0	; 037FAB80
	lsr r2,r2,#0x2	; 037FAB82
	ldr r3,[pool_037FABC8]	; 037FAB84
	and r2,r3	; 037FAB86
	ldr r3,[pool_037FABCC]	; 037FAB88
	orr r2,r3	; 037FAB8A
	bl P2_SwiCpuFastSet	; 037FAB8C
loc_037FAB90:
	ldr r0,[pool_037FABC4]	; 037FAB90
	ldr r1,[r0,#0x0]	; 037FAB92
	ldr r0,[pool_037FABD0]	; 037FAB94
	ldr r0,[r0,#0x0]	; 037FAB96
	add r1,r1,r0	; 037FAB98
	ldr r0,[pool_037FABD4]	; 037FAB9A
	cmp r1,r0	; 037FAB9C
	bcs loc_037FABBA	; 037FAB9E
	sub r2,r0,r1	; 037FABA0
	cmp r2,#0x0	; 037FABA2
	beq loc_037FABBA	; 037FABA4
	mov r0,#0x0	; 037FABA6
	str r0,[sp,#0x4]	; 037FABA8
	add r0,sp,#0x4	; 037FABAA
	lsr r2,r2,#0x2	; 037FABAC
	ldr r3,[pool_037FABC8]	; 037FABAE
	and r2,r3	; 037FABB0
	ldr r3,[pool_037FABCC]	; 037FABB2
	orr r2,r3	; 037FABB4
	bl P2_SwiCpuFastSet	; 037FABB6
loc_037FABBA:
	add sp,#0xc	; 037FABBA
	pop {r3}	; 037FABBC
	bx r3	; 037FABBE
.endfunc
pool_037FABC0:
loc_037FABC0:
	.word 0x02010000	; 037FABC0
pool_037FABC4:
loc_037FABC4:
	.word NdsCartHeaderArm9RamAddress	; 037FABC4
pool_037FABC8:
loc_037FABC8:
	.word 0x001FFFFF	; 037FABC8
pool_037FABCC:
loc_037FABCC:
	.word 0x01000000	; 037FABCC
pool_037FABD0:
loc_037FABD0:
	.word NdsCartHeaderArm9SizeAddress	; 037FABD0
pool_037FABD4:
loc_037FABD4:
	.word 0x02300000	; 037FABD4

; ===== function loc_037FABD8 =====
loc_037FABD8:
	push {lr}	; 037FABD8
	sub sp,#0x4	; 037FABDA
	add r0,sp,#0x0	; 037FABDC
	bl loc_03800398	; 037FABDE
	add r1,sp,#0x0	; 037FABE2
	ldrh r2,[r1,#0x0]	; 037FABE4
	mov r0,#0xf	; 037FABE6
	bic r2,r0	; 037FABE8
	mov r0,#0x4	; 037FABEA
	orr r2,r0	; 037FABEC
	strh r2,[r1,#0x0]	; 037FABEE
	ldrh r2,[r1,#0x0]	; 037FABF0
	mov r0,#0x40	; 037FABF2
	orr r2,r0	; 037FABF4
	strh r2,[r1,#0x0]	; 037FABF6
	add r0,sp,#0x0	; 037FABF8
	bl loc_03800378	; 037FABFA
	ldr r0,[pool_037FAC28]	; 037FABFE
	bl loc_03800460	; 037FAC00
	ldr r0,[pool_037FAC28]	; 037FAC04
	bl loc_038003F8	; 037FAC06
	add r1,sp,#0x0	; 037FAC0A
	ldrh r2,[r1,#0x0]	; 037FAC0C
	mov r0,#0xf	; 037FAC0E
	bic r2,r0	; 037FAC10
	strh r2,[r1,#0x0]	; 037FAC12
	ldrh r2,[r1,#0x0]	; 037FAC14
	mov r0,#0x40	; 037FAC16
	bic r2,r0	; 037FAC18
	strh r2,[r1,#0x0]	; 037FAC1A
	add r0,sp,#0x0	; 037FAC1C
	bl loc_03800378	; 037FAC1E
	add sp,#0x4	; 037FAC22
	pop {r3}	; 037FAC24
	bx r3	; 037FAC26
pool_037FAC28:
loc_037FAC28:
	.word 0x03802D0C	; 037FAC28

; ===== function P2_SubmitTransferRequest =====
; Copies four transfer arguments into the shared descriptor, then dispatches the request.
; 将四个传输参数写入共享描述符，再调度该请求。
.func P2_SubmitTransferRequest
loc_037FAC2C:
	push {r4,lr}	; 037FAC2C
	ldr r4,[pool_037FAC44]	; 037FAC2E
	str r3,[r4,#0x0]	; 037FAC30
	str r0,[r4,#0x4]	; 037FAC32
	str r1,[r4,#0x8]	; 037FAC34
	str r2,[r4,#0xc]	; 037FAC36
	ldr r0,[pool_037FAC48]	; 037FAC38
	bl loc_037FB9EC	; 037FAC3A
	pop {r4}	; 037FAC3E
	pop {r3}	; 037FAC40
	bx r3	; 037FAC42
.endfunc
pool_037FAC44:
loc_037FAC44:
	.word P2_BssStart + 0x14	; 037FAC44
pool_037FAC48:
loc_037FAC48:
	.word 0x03802D54	; 037FAC48

; ===== function P2_RunTransferRequestServiceLoop =====
; Continuously services the four-field transfer descriptor submitted above.
; 持续处理上方提交的四字段传输描述符。
.func P2_RunTransferRequestServiceLoop
loc_037FAC4C:
	push {r4,r5,r6,r7,lr}	; 037FAC4C
	sub sp,#0x4	; 037FAC4E
	mov r5,#0x0	; 037FAC50
	mov r7,#0x3	; 037FAC52
	ldr r4,[pool_037FAC98]	; 037FAC54
	mov r6,#0xab	; 037FAC56
loc_037FAC58:
	add r0,r6,#0x0	; 037FAC58
	bl loc_03800A20	; 037FAC5A
	ldr r0,[r4,#0x0]	; 037FAC5E
	cmp r0,#0x0	; 037FAC60
	beq loc_037FAC80	; 037FAC62
	str r5,[r4,#0xc]	; 037FAC64
	ldr r0,[r4,#0x4]	; 037FAC66
	add r1,r7,#0x0	; 037FAC68
	ldr r2,[pool_037FAC9C]	; 037FAC6A
	bl loc_038018B8	; 037FAC6C
	ldr r0,[r4,#0xc]	; 037FAC70
	lsr r1,r0,#0x2	; 037FAC72
	str r1,[r4,#0xc]	; 037FAC74
	ldr r0,[r4,#0x4]	; 037FAC76
	ldr r2,[r4,#0x8]	; 037FAC78
	bl loc_038018B8	; 037FAC7A
	b loc_037FAC8A	; 037FAC7E
loc_037FAC80:
	ldr r0,[r4,#0x4]	; 037FAC80
	ldr r1,[r4,#0xc]	; 037FAC82
	ldr r2,[r4,#0x8]	; 037FAC84
	bl loc_038018B8	; 037FAC86
loc_037FAC8A:
	add r0,r6,#0x0	; 037FAC8A
	bl loc_038009D8	; 037FAC8C
	add r0,r5,#0x0	; 037FAC90
	bl loc_037FBA58	; 037FAC92
	b loc_037FAC58	; 037FAC96
.endfunc
pool_037FAC98:
loc_037FAC98:
	.word 0x03802D1C	; 037FAC98
pool_037FAC9C:
loc_037FAC9C:
	.word 0x03802D28	; 037FAC9C

; ===== function loc_037FACA0 =====
P2_IrqHandler_037FACA0:
	push {lr}	; 037FACA0
	sub sp,#0x4	; 037FACA2
	ldr r0,[pool_037FACC0]	; 037FACA4
	ldr r0,[r0,#0x0]	; 037FACA6
	cmp r0,#0x0	; 037FACA8
	beq loc_037FACB0	; 037FACAA
	bl loc_03802138	; 037FACAC
loc_037FACB0:
	ldr r2,[pool_037FACC4]	; 037FACB0
	ldr r1,[r2,#0x0]	; 037FACB2
	mov r0,#0x1	; 037FACB4
	orr r1,r0	; 037FACB6
	str r1,[r2,#0x0]	; 037FACB8
	add sp,#0x4	; 037FACBA
	pop {r3}	; 037FACBC
	bx r3	; 037FACBE
pool_037FACC0:
loc_037FACC0:
	.word P2_BssStart + 0x2670	; 037FACC0
pool_037FACC4:
loc_037FACC4:
	.word Bios7IrqFlagsAddress	; 037FACC4
; 通道 1 的用户回调：将主工作区的首字写为 6。
; Channel 1 user callback: write 6 to the first main-work word.
.func P2_PxiChannel1UserCallback
	mov r1,#0x6	; 037FACC8
	ldr r0,[pool_037FACD0]	; 037FACCA
	str r1,[r0,#0x0]	; 037FACCC
	bx lr	; 037FACCE
.endfunc
pool_037FACD0:
loc_037FACD0:
	.word P2_BssStart	; 037FACD0
P2_PxiCallback_037FACD4:
	cmp r1,#0x3	; 037FACD4
	bne loc_037FACE0	; 037FACD6
	mov r1,#0x6	; 037FACD8
	ldr r0,[pool_037FAD04]	; 037FACDA
	str r1,[r0,#0x0]	; 037FACDC
	bx lr	; 037FACDE
loc_037FACE0:
	cmp r1,#0x6	; 037FACE0
	bne loc_037FACEC	; 037FACE2
	mov r1,#0x5	; 037FACE4
	ldr r0,[pool_037FAD04]	; 037FACE6
	str r1,[r0,#0x0]	; 037FACE8
	bx lr	; 037FACEA
loc_037FACEC:
	cmp r1,#0x4	; 037FACEC
	bne loc_037FACF8	; 037FACEE
	mov r1,#0x9	; 037FACF0
	ldr r0,[pool_037FAD04]	; 037FACF2
	str r1,[r0,#0x0]	; 037FACF4
	bx lr	; 037FACF6
loc_037FACF8:
	cmp r1,#0x7	; 037FACF8
	bne loc_037FAD02	; 037FACFA
	mov r1,#0x8	; 037FACFC
	ldr r0,[pool_037FAD04]	; 037FACFE
	str r1,[r0,#0x0]	; 037FAD00
loc_037FAD02:
	bx lr	; 037FAD02
pool_037FAD04:
loc_037FAD04:
	.word P2_BssStart	; 037FAD04

; ===== function P2_OrSharedEventFlags =====
; ORs caller-supplied flags into the guarded shared event field.
; 在受保护的共享事件字段中合并调用方提供的标志位。
.func P2_OrSharedEventFlags
loc_037FAD08:
	push {r4,lr}	; 037FAD08
	add r4,r0,#0x0	; 037FAD0A
	mov r0,#0xae	; 037FAD0C
	ldr r1,[pool_037FAD30]	; 037FAD0E
	mov r2,#0x0	; 037FAD10
	bl loc_037FB890	; 037FAD12
	ldr r1,[pool_037FAD30]	; 037FAD16
	add r2,r1,#0x0	; 037FAD18
	add r2,#0x8	; 037FAD1A
	ldr r0,[r2,#0x0]	; 037FAD1C
	orr r0,r4	; 037FAD1E
	str r0,[r2,#0x0]	; 037FAD20
	mov r0,#0xae	; 037FAD22
	mov r2,#0x0	; 037FAD24
	bl loc_037FB81C	; 037FAD26
	pop {r4}	; 037FAD2A
	pop {r3}	; 037FAD2C
	bx r3	; 037FAD2E
.endfunc
pool_037FAD30:
loc_037FAD30:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 037FAD30
; Initializes hardware and drives the cartridge/firmware boot transfer states.
; 初始化硬件，并驱动卡带／固件启动传输状态。
P2_RunBootTransferStateMachine:
loc_037FAD34:
	push {r4,r5,r6,r7,lr}	; 037FAD34
	sub sp,#0xc	; 037FAD36
	mov r0,#0x0	; 037FAD38
	str r0,[sp,#0x8]	; 037FAD3A
	add r0,sp,#0x8	; 037FAD3C
	ldr r1,[pool_037FAF08]	; 037FAD3E
	ldr r2,[pool_037FAF0C]	; 037FAD40
	bl P2_SwiCpuFastSet	; 037FAD42
	ldr r0,[pool_037FAF10]	; 037FAD46
	ldr r2,[pool_037FAF14]	; 037FAD48
	strh r0,[r2,#0x0]	; 037FAD4A
	mov r1,#0x0	; 037FAD4C
	ldr r0,[pool_037FAF18]	; 037FAD4E
	str r1,[r0,#0x0]	; 037FAD50
	str r1,[r2,#0x0]	; 037FAD52
	mov r0,#0xd	; 037FAD54
	bl loc_03801D98	; 037FAD56
	mov r1,#0x1	; 037FAD5A
	ldr r0,[pool_037FAF1C]	; 037FAD5C
	strh r1,[r0,#0x0]	; 037FAD5E
	mov r0,#0x10	; 037FAD60
	bl loc_0380226A	; 037FAD62
	bl loc_037FABD8	; 037FAD66
	bl loc_037FBFA4	; 037FAD6A
	ldr r0,[pool_037FAF20]	; 037FAD6E
	bl P2_InitPxiChannel1Callback	; 037FAD70
	bl loc_037FAFA4	; 037FAD74
	mov r0,#0x8	; 037FAD78
	ldr r1,[pool_037FAF24]	; 037FAD7A
	bl loc_037FBFD0	; 037FAD7C
	mov r0,#0x8	; 037FAD80
	ldr r1,[pool_037FAF28]	; 037FAD82
	bl loc_037FBFDC	; 037FAD84
	bl loc_037FFBC4	; 037FAD88
	mov r0,#0x2	; 037FAD8C
	bl loc_03800A68	; 037FAD8E
	mov r0,#0x3	; 037FAD92
	bl loc_037FD584	; 037FAD94
	mov r0,#0x8	; 037FAD98
	bl loc_03800020	; 037FAD9A
	mov r0,#0x2	; 037FAD9E
	ldr r1,[pool_037FAF2C]	; 037FADA0
	bl P2_SetPxiReceiveCallback	; 037FADA2
	ldr r0,[pool_037FAF30]	; 037FADA6
	str r0,[sp,#0x0]	; 037FADA8
	mov r0,#0xe	; 037FADAA
	str r0,[sp,#0x4]	; 037FADAC
	ldr r0,[pool_037FAF34]	; 037FADAE
	ldr r1,[pool_037FAF38]	; 037FADB0
	mov r2,#0x0	; 037FADB2
	ldr r3,[pool_037FAF3C]	; 037FADB4
	bl P2_CreateThread	; 037FADB6
	bl P2_InitializeBootProcedureCallbacks	; 037FADBA
	ldr r0,[pool_037FAF40]	; 037FADBE
	ldr r1,[pool_037FAF44]	; 037FADC0
	ldr r1,[r1,#0x0]	; 037FADC2
	bl loc_037FB620	; 037FADC4
	mov r0,#0x1	; 037FADC8
	ldr r1,[pool_037FAF48]	; 037FADCA
	bl loc_037FB620	; 037FADCC
	mov r0,#0x1	; 037FADD0
	bl loc_037FB59C	; 037FADD2
	bl loc_037FAF8C	; 037FADD6
	ldr r2,[pool_037FAF4C]	; 037FADDA
	ldrh r0,[r2,#0x0]	; 037FADDC
	ldrh r1,[r2,#0x0]	; 037FADDE
	mov r0,#0x8	; 037FADE0
	orr r1,r0	; 037FADE2
	strh r1,[r2,#0x0]	; 037FADE4
	ldr r1,[pool_037FAF50]	; 037FADE6
	ldrh r0,[r1,#0x0]	; 037FADE8
	mov r0,#0x1	; 037FADEA
	strh r0,[r1,#0x0]	; 037FADEC
	bl P2_LoadFirmwareHeaderAndSettingsOffset	; 037FADEE
	bl P2_LoadFirmwarePart5ToStaging	; 037FADF2
	mov r0,#0x3	; 037FADF6
	ldr r5,[pool_037FAF54]	; 037FADF8
	str r0,[r5,#0x0]	; 037FADFA
	ldr r7,[pool_037FAF58]	; 037FADFC
	mov r6,#0x2	; 037FADFE
	ldr r4,[pool_037FAF5C]	; 037FAE00
loc_037FAE02:
	mov r0,#0x1	; 037FAE02
	lsl r1,r0,#0	; 037FAE04
	bl loc_037FCC54	; 037FAE06
	ldr r0,[r4,#0x24]	; 037FAE0A
	cmp r0,#0x3	; 037FAE0C
	bne loc_037FAE40	; 037FAE0E
	ldr r1,[r7,#0x0]	; 037FAE10
	ldr r0,[pool_037FAF60]	; 037FAE12
	and r1,r0	; 037FAE14
	cmp r1,#0x0	; 037FAE16
	beq loc_037FAE02	; 037FAE18
	ldr r0,[r7,#0x0]	; 037FAE1A
	and r0,r6	; 037FAE1C
	cmp r0,#0x0	; 037FAE1E
	beq loc_037FAE3C	; 037FAE20
	ldr r1,[r7,#0x0]	; 037FAE22
	mov r0,#0x4	; 037FAE24
	and r1,r0	; 037FAE26
	cmp r1,#0x0	; 037FAE28
	bne loc_037FAE3C	; 037FAE2A
	bl P2_ClearMainRamOutsideArm9Image	; 037FAE2C
	mov r0,#0xac	; 037FAE30
	bl loc_037FB778	; 037FAE32
	mov r0,#0x4	; 037FAE36
	str r0,[r5,#0x0]	; 037FAE38
	b loc_037FAE02	; 037FAE3A
loc_037FAE3C:
	str r6,[r5,#0x0]	; 037FAE3C
	b loc_037FAE02	; 037FAE3E
loc_037FAE40:
	ldr r0,[r4,#0x24]	; 037FAE40
	cmp r0,#0x4	; 037FAE42
	bne loc_037FAE66	; 037FAE44
	ldr r0,[pool_037FAF64]	; 037FAE46
	ldr r0,[r0,#0x0]	; 037FAE48
	bl loc_038029F4	; 037FAE4A
	mov r1,#0x1	; 037FAE4E
	mvn r1,r1	; 037FAE50
	cmp r0,r1	; 037FAE52
	bne loc_037FAE02	; 037FAE54
	mov r0,#0xac	; 037FAE56
	bl loc_037FB6AC	; 037FAE58
	ldr r0,[pool_037FAF68]	; 037FAE5C
	bl P2_OrSharedEventFlags	; 037FAE5E
	str r6,[r5,#0x0]	; 037FAE62
	b loc_037FAE02	; 037FAE64
loc_037FAE66:
	ldr r0,[r4,#0x24]	; 037FAE66
	cmp r0,#0x2	; 037FAE68
	beq loc_037FAE72	; 037FAE6A
	ldr r0,[r4,#0x24]	; 037FAE6C
	cmp r0,#0x7	; 037FAE6E
	bne loc_037FAE84	; 037FAE70
loc_037FAE72:
	ldr r0,[pool_037FAF6C]	; 037FAE72
	ldr r0,[r0,#0x0]	; 037FAE74
	cmp r0,#0x0	; 037FAE76
	beq loc_037FAE02	; 037FAE78
	str r0,[r5,#0x0]	; 037FAE7A
	mov r1,#0x0	; 037FAE7C
	ldr r0,[pool_037FAF6C]	; 037FAE7E
	str r1,[r0,#0x0]	; 037FAE80
	b loc_037FAE02	; 037FAE82
loc_037FAE84:
	ldr r0,[r4,#0x24]	; 037FAE84
	cmp r0,#0x6	; 037FAE86
	bne loc_037FAE9E	; 037FAE88
	ldr r0,[pool_037FAF70]	; 037FAE8A
	ldr r0,[r0,#0x0]	; 037FAE8C
	cmp r0,#0x7	; 037FAE8E
	bne loc_037FAE02	; 037FAE90
	bl P2_ResetArm7Peripherals	; 037FAE92
	ldr r1,[pool_037FAF74]	; 037FAE96
	ldr r0,[pool_037FAF78]	; 037FAE98
	strh r1,[r0,#0x0]	; 037FAE9A
	b loc_037FAF00	; 037FAE9C
loc_037FAE9E:
	ldr r0,[r4,#0x24]	; 037FAE9E
	cmp r0,#0x5	; 037FAEA0
	bne loc_037FAEAE	; 037FAEA2
	bl P2_LoadSecondaryFirmwarePartsToStaging	; 037FAEA4
	mov r0,#0x7	; 037FAEA8
	str r0,[r5,#0x0]	; 037FAEAA
	b loc_037FAE02	; 037FAEAC
loc_037FAEAE:
	ldr r0,[r4,#0x24]	; 037FAEAE
	cmp r0,#0x8	; 037FAEB0
	bne loc_037FAECA	; 037FAEB2
	mov r1,#0x6	; 037FAEB4
; 启动状态 8 路径在私有源区写入 6；发布时此字段会被另行覆盖。
; Boot state 8 writes 6 to this private slot; publication later replaces the field.
	ldr r0,[pool_037FAF7C]	; 037FAEB6
	strh r1,[r0,#0x0]	; 037FAEB8
	ldr r0,[pool_037FAF64]	; 037FAEBA
	ldr r0,[r0,#0x0]	; 037FAEBC
	bl loc_038029F4	; 037FAEBE
	bl loc_037FAF98	; 037FAEC2
	str r6,[r5,#0x0]	; 037FAEC6
	b loc_037FAE02	; 037FAEC8
loc_037FAECA:
	ldr r0,[r4,#0x24]	; 037FAECA
	cmp r0,#0x9	; 037FAECC
	bne loc_037FAE02	; 037FAECE
	ldr r0,[pool_037FAF70]	; 037FAED0
	ldr r0,[r0,#0x0]	; 037FAED2
	cmp r0,#0x9	; 037FAED4
	bne loc_037FAE02	; 037FAED6
	ldr r0,[pool_037FAF50]	; 037FAED8
	ldrh r0,[r0,#0x0]	; 037FAEDA
	mov r1,#0x0	; 037FAEDC
	ldr r0,[pool_037FAF50]	; 037FAEDE
	strh r1,[r0,#0x0]	; 037FAEE0
	ldr r0,[pool_037FAF80]	; 037FAEE2
	ldr r1,[pool_037FAF84]	; 037FAEE4
	ldr r2,[pool_037FAF88]	; 037FAEE6
	bl P2_SwiCpuFastSet	; 037FAEE8
	mov r0,#0x10	; 037FAEEC
	bl loc_03802272	; 037FAEEE
	ldr r0,[pool_037FAF10]	; 037FAEF2
	bl loc_03802244	; 037FAEF4
	ldr r0,[pool_037FAF84]	; 037FAEF8
	bl loc_038029F4	; 037FAEFA
	b loc_037FAE02	; 037FAEFE
loc_037FAF00:
	add sp,#0xc	; 037FAF00
	pop {r4,r5,r6,r7}	; 037FAF02
	pop {r3}	; 037FAF04
	bx r3	; 037FAF06
pool_037FAF08:
loc_037FAF08:
	.word 0x023FE800	; 037FAF08
pool_037FAF0C:
loc_037FAF0C:
	.word 0x01000200	; 037FAF0C
pool_037FAF10:
loc_037FAF10:
	.word 0x00001000	; 037FAF10
pool_037FAF14:
loc_037FAF14:
	.word REG_SIOCNT_ARM7	; 037FAF14
pool_037FAF18:
loc_037FAF18:
	.word REG_SIODATA32_ARM7	; 037FAF18
pool_037FAF1C:
loc_037FAF1C:
	.word REG_POWERCNT	; 037FAF1C
pool_037FAF20:
loc_037FAF20:
	.word P2_PxiChannel1UserCallback + 1	; 037FAF20
pool_037FAF24:
loc_037FAF24:
	.word 0x038053D4	; 037FAF24
pool_037FAF28:
loc_037FAF28:
	.word P2_WramCopy1RuntimeStart	; 037FAF28
pool_037FAF2C:
loc_037FAF2C:
	.word P2_PxiCallback_037FACD4 + 1	; 037FAF2C
pool_037FAF30:
loc_037FAF30:
	.word 0x00000400	; 037FAF30
pool_037FAF34:
loc_037FAF34:
	.word 0x03802D54	; 037FAF34
pool_037FAF38:
loc_037FAF38:
	.word P2_RunTransferRequestServiceLoop + 1	; 037FAF38
pool_037FAF3C:
loc_037FAF3C:
	.word 0x038031CC	; 037FAF3C
pool_037FAF40:
loc_037FAF40:
	.word 0x00080000	; 037FAF40
pool_037FAF44:
loc_037FAF44:
	.word P2_BssStart + 0x10	; 037FAF44
pool_037FAF48:
loc_037FAF48:
	.word P2_IrqHandler_037FACA0 + 1	; 037FAF48
pool_037FAF4C:
loc_037FAF4C:
	.word REG_DISPSTAT	; 037FAF4C
pool_037FAF50:
loc_037FAF50:
	.word REG_IME	; 037FAF50
pool_037FAF54:
loc_037FAF54:
	.word FirmwareBootSharedAddress + BootSharedArm7StateOffset	; 037FAF54
pool_037FAF58:
loc_037FAF58:
	.word 0x027FF890	; 037FAF58
pool_037FAF5C:
loc_037FAF5C:
	.word 0x027FF860	; 037FAF5C
pool_037FAF60:
loc_037FAF60:
	.word 0x20000000	; 037FAF60
pool_037FAF64:
loc_037FAF64:
	.word P2_BssStart + 0xC	; 037FAF64
pool_037FAF68:
loc_037FAF68:
	.word 0x00000200	; 037FAF68
pool_037FAF6C:
loc_037FAF6C:
	.word P2_BssStart	; 037FAF6C
pool_037FAF70:
loc_037FAF70:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 037FAF70
pool_037FAF74:
loc_037FAF74:
	.word 0x00002100	; 037FAF74
pool_037FAF78:
loc_037FAF78:
	.word REG_IPC_SYNC	; 037FAF78
pool_037FAF7C:
loc_037FAF7C:
	.word FirmwareBootInfoScratchAddress + 0x10	; 037FAF7C
pool_037FAF80:
loc_037FAF80:
	.word P2_WaitVCount200ThenEnterAgbMode	; 037FAF80
pool_037FAF84:
loc_037FAF84:
	.word P2_WramCopy0RuntimeStart	; 037FAF84
pool_037FAF88:
loc_037FAF88:
	.word 0x00000100	; 037FAF88

; ===== function loc_037FAF8C =====
loc_037FAF8C:
	bx pc	; 037FAF8C
	.byte 0xC0, 0x46	; 037FAF90
.arm

; ===== function loc_037FAF90 =====
loc_037FAF90:
	ldr pc,[pool_037FAF94]	; 037FAF90
pool_037FAF94:
loc_037FAF94:
	.word loc_037FCBDC	; 037FAF94
.thumb

; ===== function loc_037FAF98 =====
loc_037FAF98:
	bx pc	; 037FAF98
	.byte 0xC0, 0x46	; 037FAF9C
.arm

; ===== function loc_037FAF9C =====
loc_037FAF9C:
	ldr pc,[pool_037FAFA0]	; 037FAF9C
pool_037FAFA0:
loc_037FAFA0:
	.word P4_InitializeRuntimeContext	; 037FAFA0
.thumb

; ===== function loc_037FAFA4 =====
loc_037FAFA4:
	push {lr}	; 037FAFA4
	sub sp,#0xc	; 037FAFA6
	bl loc_037FB210	; 037FAFA8
	cmp r0,#0x0	; 037FAFAC
	bne loc_037FAFB4	; 037FAFAE
	mov r0,#0x0	; 037FAFB0
	b loc_037FAFEC	; 037FAFB2
loc_037FAFB4:
	ldr r2,[pool_037FAFF4]	; 037FAFB4
	ldrh r1,[r2,#0x0]	; 037FAFB6
	mov r0,#0x2	; 037FAFB8
	orr r1,r0	; 037FAFBA
	strh r1,[r2,#0x0]	; 037FAFBC
	mov r1,#0x30	; 037FAFBE
	ldr r0,[pool_037FAFF8]	; 037FAFC0
	strh r1,[r0,#0x0]	; 037FAFC2
	add r0,sp,#0x0	; 037FAFC4
	bl loc_037FB164	; 037FAFC6
	bl loc_037FB2C0	; 037FAFCA
	bl loc_037FB124	; 037FAFCE
	add r0,sp,#0x0	; 037FAFD2
	bl loc_037FB100	; 037FAFD4
	add r0,sp,#0x0	; 037FAFD8
	ldrh r0,[r0,#0x0]	; 037FAFDA
	bl loc_037FB278	; 037FAFDC
	ldr r2,[pool_037FAFF4]	; 037FAFE0
	ldrh r1,[r2,#0x0]	; 037FAFE2
	mov r0,#0x2	; 037FAFE4
	bic r1,r0	; 037FAFE6
	strh r1,[r2,#0x0]	; 037FAFE8
	mov r0,#0x1	; 037FAFEA
loc_037FAFEC:
	add sp,#0xc	; 037FAFEC
	pop {r3}	; 037FAFEE
	bx r3	; 037FAFF0
	.byte 0xC0, 0x46	; 037FAFF4
pool_037FAFF4:
loc_037FAFF4:
	.word REG_POWERCNT	; 037FAFF4
pool_037FAFF8:
loc_037FAFF8:
	.word REG_WIFIWAITCNT_ARM7	; 037FAFF8

; ===== function loc_037FAFFC =====
loc_037FAFFC:
	push {r4,r5,lr}	; 037FAFFC
	sub sp,#0x4	; 037FAFFE
	mov r5,#0x2	; 037FB000
	str r5,[sp,#0x0]	; 037FB002
	add r4,sp,#0x0	; 037FB004
	b loc_037FB00E	; 037FB006
loc_037FB008:
	add r0,r4,#0x0	; 037FB008
	bl loc_038019B4	; 037FB00A
loc_037FB00E:
	ldr r0,[sp,#0x0]	; 037FB00E
	and r0,r5	; 037FB010
	cmp r0,#0x0	; 037FB012
	bne loc_037FB008	; 037FB014
	add sp,#0x4	; 037FB016
	pop {r4,r5}	; 037FB018
	pop {r3}	; 037FB01A
	bx r3	; 037FB01C
	.byte 0x00, 0x00	; 037FB020

; ===== function loc_037FB020 =====
loc_037FB020:
	push {r4,r5,r6,lr}	; 037FB020
	add r5,r0,#0x0	; 037FB022
	add r4,r1,#0x0	; 037FB024
	add r6,r2,#0x0	; 037FB026
	bl loc_037FAFFC	; 037FB028
	add r0,r5,#0x0	; 037FB02C
	add r1,r4,#0x0	; 037FB02E
	add r2,r6,#0x0	; 037FB030
	bl loc_038018B8	; 037FB032
	pop {r4,r5,r6}	; 037FB036
	pop {r3}	; 037FB038
	bx r3	; 037FB03A

; ===== function loc_037FB03C =====
loc_037FB03C:
	ldr r0,[pool_037FB054]	; 037FB03C
	ldr r2,[pool_037FB058]	; 037FB03E
	mov r1,#0x1	; 037FB040
	b loc_037FB04E	; 037FB042
loc_037FB044:
	ldrh r3,[r2,#0x0]	; 037FB044
	and r3,r1	; 037FB046
	cmp r3,#0x0	; 037FB048
	beq loc_037FB052	; 037FB04A
	sub r0,r0,#0x1	; 037FB04C
loc_037FB04E:
	cmp r0,#0x0	; 037FB04E
	bne loc_037FB044	; 037FB050
loc_037FB052:
	bx lr	; 037FB052
pool_037FB054:
loc_037FB054:
	.word 0x00002000	; 037FB054
pool_037FB058:
loc_037FB058:
	.word REG_WIFI_RF_BUSY	; 037FB058

; ===== function loc_037FB05C =====
loc_037FB05C:
	push {r4,lr}	; 037FB05C
	add r4,r0,#0x0	; 037FB05E
	bl loc_037FB03C	; 037FB060
	ldr r0,[pool_037FB078]	; 037FB064
	strh r4,[r0,#0x0]	; 037FB066
	lsr r1,r4,#0x10	; 037FB068
	ldr r0,[pool_037FB07C]	; 037FB06A
	strh r1,[r0,#0x0]	; 037FB06C
	bl loc_037FB03C	; 037FB06E
	pop {r4}	; 037FB072
	pop {r3}	; 037FB074
	bx r3	; 037FB076
pool_037FB078:
loc_037FB078:
	.word REG_WIFI_RF_DATA1	; 037FB078
pool_037FB07C:
loc_037FB07C:
	.word REG_WIFI_RF_DATA2	; 037FB07C

; ===== function loc_037FB080 =====
loc_037FB080:
	ldr r0,[pool_037FB098]	; 037FB080
	ldr r2,[pool_037FB09C]	; 037FB082
	mov r1,#0x1	; 037FB084
	b loc_037FB092	; 037FB086
loc_037FB088:
	ldrh r3,[r2,#0x0]	; 037FB088
	and r3,r1	; 037FB08A
	cmp r3,#0x0	; 037FB08C
	beq loc_037FB096	; 037FB08E
	sub r0,r0,#0x1	; 037FB090
loc_037FB092:
	cmp r0,#0x0	; 037FB092
	bne loc_037FB088	; 037FB094
loc_037FB096:
	bx lr	; 037FB096
pool_037FB098:
loc_037FB098:
	.word 0x00002000	; 037FB098
pool_037FB09C:
loc_037FB09C:
	.word REG_WIFI_BB_BUSY	; 037FB09C

; ===== function loc_037FB0A0 =====
loc_037FB0A0:
	push {r4,r5,lr}	; 037FB0A0
	sub sp,#0x4	; 037FB0A2
	add r5,r0,#0x0	; 037FB0A4
	add r4,r1,#0x0	; 037FB0A6
	bl loc_037FB080	; 037FB0A8
	ldr r0,[pool_037FB0C8]	; 037FB0AC
	strh r4,[r0,#0x0]	; 037FB0AE
	ldr r0,[pool_037FB0CC]	; 037FB0B0
	orr r5,r0	; 037FB0B2
	ldr r0,[pool_037FB0D0]	; 037FB0B4
	strh r5,[r0,#0x0]	; 037FB0B6
	bl loc_037FB080	; 037FB0B8
	mov r0,#0x0	; 037FB0BC
	add sp,#0x4	; 037FB0BE
	pop {r4,r5}	; 037FB0C0
	pop {r3}	; 037FB0C2
	bx r3	; 037FB0C4
	.byte 0xC0, 0x46	; 037FB0C8
pool_037FB0C8:
loc_037FB0C8:
	.word REG_WIFI_BB_WRITE	; 037FB0C8
pool_037FB0CC:
loc_037FB0CC:
	.word 0x00005000	; 037FB0CC
pool_037FB0D0:
loc_037FB0D0:
	.word REG_WIFI_BB_CNT	; 037FB0D0

; ===== function loc_037FB0D4 =====
loc_037FB0D4:
	push {r4,lr}	; 037FB0D4
	add r4,r0,#0x0	; 037FB0D6
	bl loc_037FB080	; 037FB0D8
	ldr r0,[pool_037FB0F4]	; 037FB0DC
	orr r4,r0	; 037FB0DE
	ldr r0,[pool_037FB0F8]	; 037FB0E0
	strh r4,[r0,#0x0]	; 037FB0E2
	bl loc_037FB080	; 037FB0E4
	ldr r0,[pool_037FB0FC]	; 037FB0E8
	ldrh r0,[r0,#0x0]	; 037FB0EA
	pop {r4}	; 037FB0EC
	pop {r3}	; 037FB0EE
	bx r3	; 037FB0F0
	.byte 0xC0, 0x46	; 037FB0F4
pool_037FB0F4:
loc_037FB0F4:
	.word 0x00006000	; 037FB0F4
pool_037FB0F8:
loc_037FB0F8:
	.word REG_WIFI_BB_CNT	; 037FB0F8
pool_037FB0FC:
loc_037FB0FC:
	.word REG_WIFI_BB_READ	; 037FB0FC

; ===== function loc_037FB100 =====
loc_037FB100:
	push {r4,lr}	; 037FB100
	ldrh r1,[r0,#0x2]	; 037FB102
	lsr r1,r1,#0x7	; 037FB104
	lsl r4,r1,#0x8	; 037FB106
	add r3,r0,#0x2	; 037FB108
	ldrh r2,[r3,#0x0]	; 037FB10A
	mov r1,#0x7f	; 037FB10C
	and r2,r1	; 037FB10E
	strh r2,[r3,#0x0]	; 037FB110
	ldrh r0,[r0,#0x2]	; 037FB112
	orr r4,r0	; 037FB114
	ldr r0,[pool_037FB120]	; 037FB116
	strh r4,[r0,#0x0]	; 037FB118
	pop {r4}	; 037FB11A
	pop {r3}	; 037FB11C
	bx r3	; 037FB11E
pool_037FB120:
loc_037FB120:
	.word REG_WIFI_RF_CNT	; 037FB120

; ===== function loc_037FB124 =====
loc_037FB124:
	push {r4,r5,r6,r7,lr}	; 037FB124
	sub sp,#0x4	; 037FB126
	ldr r1,[pool_037FB15C]	; 037FB128
	ldr r0,[pool_037FB160]	; 037FB12A
	strh r1,[r0,#0x0]	; 037FB12C
	mov r4,#0x64	; 037FB12E
	mov r5,#0x0	; 037FB130
	str r5,[sp,#0x0]	; 037FB132
	mov r6,#0x1	; 037FB134
	add r7,sp,#0x0	; 037FB136
loc_037FB138:
	add r0,r4,#0x0	; 037FB138
	add r1,r6,#0x0	; 037FB13A
	add r2,r7,#0x0	; 037FB13C
	bl loc_037FB020	; 037FB13E
	add r0,r5,#0x0	; 037FB142
	ldr r1,[sp,#0x0]	; 037FB144
	bl loc_037FB0A0	; 037FB146
	add r4,r4,#0x1	; 037FB14A
	add r5,r5,#0x1	; 037FB14C
	cmp r5,#0x69	; 037FB14E
	bcc loc_037FB138	; 037FB150
	add sp,#0x4	; 037FB152
	pop {r4,r5,r6,r7}	; 037FB154
	pop {r3}	; 037FB156
	bx r3	; 037FB158
	.byte 0xC0, 0x46	; 037FB15C
pool_037FB15C:
loc_037FB15C:
	.word 0x00000100	; 037FB15C
pool_037FB160:
loc_037FB160:
	.word REG_WIFI_BB_MODE	; 037FB160

; ===== function loc_037FB164 =====
loc_037FB164:
	push {r4,lr}	; 037FB164
	sub sp,#0x8	; 037FB166
	add r4,r0,#0x0	; 037FB168
	mov r1,#0x0	; 037FB16A
	add r0,sp,#0x0	; 037FB16C
	strh r1,[r0,#0x0]	; 037FB16E
	ldrh r0,[r0,#0x0]	; 037FB170
	add r1,r4,#0x0	; 037FB172
	mov r2,#0x8	; 037FB174
	bl loc_037FB1AC	; 037FB176
	mov r0,#0x40	; 037FB17A
	mov r1,#0x1	; 037FB17C
	add r2,r4,#0x0	; 037FB17E
	bl loc_037FB020	; 037FB180
	mov r0,#0x41	; 037FB184
	mov r1,#0x1	; 037FB186
	add r2,r4,#0x2	; 037FB188
	bl loc_037FB020	; 037FB18A
	mov r0,#0x42	; 037FB18E
	mov r1,#0x1	; 037FB190
	add r2,r4,#0x4	; 037FB192
	bl loc_037FB020	; 037FB194
	mov r0,#0x43	; 037FB198
	mov r1,#0x1	; 037FB19A
	add r2,r4,#0x6	; 037FB19C
	bl loc_037FB020	; 037FB19E
	add sp,#0x8	; 037FB1A2
	pop {r4}	; 037FB1A4
	pop {r3}	; 037FB1A6
	bx r3	; 037FB1A8
	.byte 0xC0, 0x46	; 037FB1AC

; ===== function loc_037FB1AC =====
loc_037FB1AC:
	bx pc	; 037FB1AC
	.byte 0xC0, 0x46	; 037FB1B0
.arm

; ===== function loc_037FB1B0 =====
loc_037FB1B0:
	ldr pc,[pool_037FB1B4]	; 037FB1B0
pool_037FB1B4:
loc_037FB1B4:
	.word loc_037FCE04	; 037FB1B4
.thumb

; ===== function loc_037FB1B8 =====
loc_037FB1B8:
	push {r4,r5,lr}	; 037FB1B8
	sub sp,#0x4	; 037FB1BA
	mov r2,#0xf	; 037FB1BC
	add r3,r1,#0x0	; 037FB1BE
	and r3,r2	; 037FB1C0
	lsl r3,r3,#0x1	; 037FB1C2
	ldr r4,[pool_037FB208]	; 037FB1C4
	ldrh r3,[r4,r3]	; 037FB1C6
	asr r1,r1,#0x4	; 037FB1C8
	ldr r5,[pool_037FB20C]	; 037FB1CA
	and r1,r5	; 037FB1CC
	lsl r1,r1,#0x10	; 037FB1CE
	lsr r1,r1,#0x10	; 037FB1D0
	eor r1,r3	; 037FB1D2
	add r3,r0,#0x0	; 037FB1D4
	and r3,r2	; 037FB1D6
	lsl r3,r3,#0x1	; 037FB1D8
	ldrh r3,[r4,r3]	; 037FB1DA
	eor r1,r3	; 037FB1DC
	lsl r1,r1,#0x10	; 037FB1DE
	lsr r3,r1,#0x10	; 037FB1E0
	asr r1,r3,#0x4	; 037FB1E2
	and r1,r5	; 037FB1E4
	lsl r1,r1,#0x10	; 037FB1E6
	lsr r1,r1,#0x10	; 037FB1E8
	and r3,r2	; 037FB1EA
	lsl r3,r3,#0x1	; 037FB1EC
	ldrh r3,[r4,r3]	; 037FB1EE
	eor r1,r3	; 037FB1F0
	asr r0,r0,#0x4	; 037FB1F2
	and r0,r2	; 037FB1F4
	lsl r0,r0,#0x1	; 037FB1F6
	ldrh r0,[r4,r0]	; 037FB1F8
	eor r1,r0	; 037FB1FA
	lsl r0,r1,#0x10	; 037FB1FC
	lsr r0,r0,#0x10	; 037FB1FE
	add sp,#0x4	; 037FB200
	pop {r4,r5}	; 037FB202
	pop {r3}	; 037FB204
	bx r3	; 037FB206
pool_037FB208:
loc_037FB208:
	.word P2_Data_03802A4C	; 037FB208
pool_037FB20C:
loc_037FB20C:
	.word 0x00000FFF	; 037FB20C

; ===== function loc_037FB210 =====
loc_037FB210:
	push {r4,r5,r6,r7,lr}	; 037FB210
	sub sp,#0xc	; 037FB212
	mov r5,#0x2a	; 037FB214
	add r0,r5,#0x0	; 037FB216
	mov r1,#0x2	; 037FB218
	add r2,sp,#0x0	; 037FB21A
	add r2,#0x2	; 037FB21C
	bl loc_037FB020	; 037FB21E
	add r5,r5,#0x2	; 037FB222
	add r0,r5,#0x0	; 037FB224
	mov r1,#0x2	; 037FB226
	add r2,sp,#0x4	; 037FB228
	bl loc_037FB020	; 037FB22A
	add r7,sp,#0x0	; 037FB22E
	ldrh r1,[r7,#0x4]	; 037FB230
	ldr r0,[pool_037FB274]	; 037FB232
	cmp r1,r0	; 037FB234
	bcs loc_037FB26A	; 037FB236
	mov r6,#0x0	; 037FB238
	add r4,r6,#0x0	; 037FB23A
	b loc_037FB256	; 037FB23C
loc_037FB23E:
	add r0,r5,#0x0	; 037FB23E
	mov r1,#0x1	; 037FB240
	add r2,sp,#0x0	; 037FB242
	bl loc_037FB020	; 037FB244
	add r5,r5,#0x1	; 037FB248
	ldrb r0,[r7,#0x0]	; 037FB24A
	add r1,r6,#0x0	; 037FB24C
	bl loc_037FB1B8	; 037FB24E
	add r6,r0,#0x0	; 037FB252
	add r4,r4,#0x1	; 037FB254
loc_037FB256:
	ldrh r0,[r7,#0x4]	; 037FB256
	cmp r4,r0	; 037FB258
	bcc loc_037FB23E	; 037FB25A
	ldrh r0,[r7,#0x2]	; 037FB25C
	cmp r6,r0	; 037FB25E
	bne loc_037FB266	; 037FB260
	mov r0,#0x1	; 037FB262
	b loc_037FB26C	; 037FB264
loc_037FB266:
	mov r0,#0x0	; 037FB266
	b loc_037FB26C	; 037FB268
loc_037FB26A:
	mov r0,#0x0	; 037FB26A
loc_037FB26C:
	add sp,#0xc	; 037FB26C
	pop {r4,r5,r6,r7}	; 037FB26E
	pop {r3}	; 037FB270
	bx r3	; 037FB272
pool_037FB274:
loc_037FB274:
	.word 0x000001D6	; 037FB274

; ===== function loc_037FB278 =====
loc_037FB278:
	push {lr}	; 037FB278
	sub sp,#0x4	; 037FB27A
	cmp r0,#0x2	; 037FB27C
	beq loc_037FB284	; 037FB27E
	cmp r0,#0x3	; 037FB280
	b loc_037FB28A	; 037FB282
loc_037FB284:
	ldr r0,[pool_037FB2B0]	; 037FB284
	bl loc_037FB05C	; 037FB286
loc_037FB28A:
	mov r0,#0x1e	; 037FB28A
	bl loc_037FB0D4	; 037FB28C
	mov r2,#0x3f	; 037FB290
	add r1,r0,#0x0	; 037FB292
	orr r1,r2	; 037FB294
	mov r0,#0x1e	; 037FB296
	bl loc_037FB0A0	; 037FB298
	ldr r1,[pool_037FB2B4]	; 037FB29C
	ldr r0,[pool_037FB2B8]	; 037FB29E
	strh r1,[r0,#0x0]	; 037FB2A0
	mov r1,#0x1	; 037FB2A2
	ldr r0,[pool_037FB2BC]	; 037FB2A4
	strh r1,[r0,#0x0]	; 037FB2A6
	add sp,#0x4	; 037FB2A8
	pop {r3}	; 037FB2AA
	bx r3	; 037FB2AC
	.byte 0xC0, 0x46	; 037FB2B0
pool_037FB2B0:
loc_037FB2B0:
	.word 0x0000C008	; 037FB2B0
pool_037FB2B4:
loc_037FB2B4:
	.word 0x0000800D	; 037FB2B4
pool_037FB2B8:
loc_037FB2B8:
	.word REG_WIFI_BB_POWER	; 037FB2B8
pool_037FB2BC:
loc_037FB2BC:
	.word REG_WIFI_POWER_US	; 037FB2BC

; ===== function loc_037FB2C0 =====
loc_037FB2C0:
	push {lr}	; 037FB2C0
	sub sp,#0x4	; 037FB2C2
	mov r1,#0x0	; 037FB2C4
	ldr r0,[pool_037FB2DC]	; 037FB2C6
	strh r1,[r0,#0x0]	; 037FB2C8
	ldr r0,[pool_037FB2E0]	; 037FB2CA
	bl loc_037FCCB4	; 037FB2CC
	mov r1,#0x0	; 037FB2D0
	ldr r0,[pool_037FB2E4]	; 037FB2D2
	strh r1,[r0,#0x0]	; 037FB2D4
	add sp,#0x4	; 037FB2D6
	pop {r3}	; 037FB2D8
	bx r3	; 037FB2DA
pool_037FB2DC:
loc_037FB2DC:
	.word REG_WIFI_POWER_US	; 037FB2DC
pool_037FB2E0:
loc_037FB2E0:
	.word 0x00051D23	; 037FB2E0
pool_037FB2E4:
loc_037FB2E4:
	.word REG_WIFI_BB_POWER	; 037FB2E4
.arm

; ===== function loc_037FB2E8 =====
; 取已启用的待处理中断，清除请求并调用对应回调。
; Select an enabled pending IRQ, acknowledge it and call its registered handler.
.func P2_DispatchIrq
	stmdb sp!,{lr}	; 037FB2E8
	mov r12,#0x4000000	; 037FB2EC
	add r12,r12,#0x210	; 037FB2F0
	ldr r1,[r12,#-0x8]	; 037FB2F4
	cmp r1,#0x0	; 037FB2F8
	ldmeqia sp!,{pc}	; 037FB2FC
	ldmia r12,{r1,r2}	; 037FB300
	ands r1,r1,r2	; 037FB304
	ldmeqia sp!,{pc}	; 037FB308
	mov r3,#0x1	; 037FB30C
	mov r0,#0x0	; 037FB310
loc_037FB314:
	ands r2,r1,r3, lsl r0	; 037FB314
	addeq r0,r0,#0x1	; 037FB318
	beq loc_037FB314	; 037FB31C
	str r2,[r12,#0x4]	; 037FB320
	ldr r1,[pool_037FB334]	; 037FB324
	ldr r0,[r1,r0,lsl #0x2]	; 037FB328
	ldr lr,[pool_037FB338]	; 037FB32C
	bx r0	; 037FB330
.endfunc
pool_037FB334:
loc_037FB334:
	.word P2_IrqHandlers	; 037FB334
pool_037FB338:
loc_037FB338:
	.word P2_IrqReturnContinuation	; 037FB338
; 中断回调返回后处理待执行状态，必要时保存并切换执行上下文。
; After the IRQ callback, process pending state and save/switch context when needed.
.func P2_IrqReturnContinuation
	ldr r12,[pool_037FB450]	; 037FB33C
	ldrh r3,[r12,#0x0]	; 037FB340
	mov r0,#0x0	; 037FB344
	cmp r3,#0x0	; 037FB348
	beq P2_Entry_037FB384	; 037FB34C
	strh r0,[r12,#0x0]	; 037FB350
	ldr r12,[pool_037FB454]	; 037FB354
	mov r1,#0x1	; 037FB358
	strh r1,[r12,#0x0]	; 037FB35C
	ldr r12,[r12,#0xc]	; 037FB360
	mov r2,#0x1	; 037FB364
P2_Entry_037FB368:
	cmp r12,#0x0	; 037FB368
	beq P2_Entry_037FB384	; 037FB36C
	ldr r0,[r12,#0x50]	; 037FB370
	tst r3,r1, lsl r0	; 037FB374
	strne r2,[r12,#0x48]	; 037FB378
	ldr r12,[r12,#0x4c]	; 037FB37C
	b P2_Entry_037FB368	; 037FB380
P2_Entry_037FB384:
	ldr r12,[pool_037FB454]	; 037FB384
	ldrh r1,[r12,#0x0]	; 037FB388
	cmp r1,#0x0	; 037FB38C
	ldreq pc,[sp],#0x4	; 037FB390
	mov r1,#0x0	; 037FB394
	strh r1,[r12,#0x0]	; 037FB398
	mov r3,#0xd2	; 037FB39C
	msr cpsr_c,r3	; 037FB3A0
	add r2,r12,#0xc	; 037FB3A4
	ldr r1,[r2,#0x0]	; 037FB3A8
P2_Entry_037FB3AC:
	cmp r1,#0x0	; 037FB3AC
	ldrneh r0,[r1,#0x48]	; 037FB3B0
	cmpne r0,#0x1	; 037FB3B4
	ldrne r1,[r1,#0x4c]	; 037FB3B8
	bne P2_Entry_037FB3AC	; 037FB3BC
	cmp r1,#0x0	; 037FB3C0
	bne P2_Entry_037FB3D4	; 037FB3C4
P2_Entry_037FB3C8:
	mov r3,#0x92	; 037FB3C8
	msr cpsr_c,r3	; 037FB3CC
	ldr pc,[sp],#0x4	; 037FB3D0
P2_Entry_037FB3D4:
	ldr r0,[r12,#0x8]	; 037FB3D4
	cmp r1,r0	; 037FB3D8
	beq P2_Entry_037FB3C8	; 037FB3DC
	ldr r3,[r12,#0x10]	; 037FB3E0
	cmp r3,#0x0	; 037FB3E4
	beq P2_Entry_037FB3FC	; 037FB3E8
	stmdb sp!,{r0,r1,r12}	; 037FB3EC
	mov lr,pc	; 037FB3F0
	bx r3	; 037FB3F4
	ldmia sp!,{r0,r1,r12}	; 037FB3F8
P2_Entry_037FB3FC:
	str r1,[r12,#0x8]	; 037FB3FC
	mrs r2,spsr	; 037FB400
	str r2,[r0,#0x0]!	; 037FB404
	ldmib sp!,{r2,r3}	; 037FB408
	stmib r0!,{r2,r3}	; 037FB40C
	ldmib sp!,{r2,r3,r12,lr}	; 037FB410
	stmib r0!,{r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FB414
	stmib r0!,{lr}	; 037FB418
	mov r3,#0xd3	; 037FB41C
	msr cpsr_c,r3	; 037FB420
	stmib r0!,{sp}	; 037FB424
	ldr sp,[r1,#0x44]	; 037FB428
	mov r3,#0xd2	; 037FB42C
	msr cpsr_c,r3	; 037FB430
	ldr r2,[r1,#0x0]!	; 037FB434
	msr spsr_cf,r2	; 037FB438
	ldr lr,[r1,#0x40]	; 037FB43C
	ldmib r1!,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FB440
	mov r0,r0	; 037FB444
	stmda sp!,{r0,r1,r2,r3,r12,lr}	; 037FB448
	ldmia sp!,{pc}	; 037FB44C
.endfunc
pool_037FB450:
	.word P2_BssStart + 0x4C4	; 037FB450
pool_037FB454:
	.word P2_BssStart + 0x544	; 037FB454
.thumb
P2_IrqHandler_037FB458:
	push {lr}	; 037FB458
	sub sp,#0x4	; 037FB45A
	ldr r0,[pool_037FB480]	; 037FB45C
	ldr r2,[r0,#0x60]	; 037FB45E
	ldr r1,[pool_037FB484]	; 037FB460
	ldr r0,[r1,#0x0]	; 037FB462
	add r0,r0,#0x1	; 037FB464
	str r0,[r1,#0x0]	; 037FB466
	cmp r2,#0x0	; 037FB468
	beq P2_Entry_037FB470	; 037FB46A
	bl loc_038029FC	; 037FB46C
P2_Entry_037FB470:
	ldr r2,[pool_037FB488]	; 037FB470
	ldr r1,[r2,#0x0]	; 037FB472
	mov r0,#0x1	; 037FB474
	orr r1,r0	; 037FB476
	str r1,[r2,#0x0]	; 037FB478
	add sp,#0x4	; 037FB47A
	pop {r3}	; 037FB47C
	bx r3	; 037FB47E
pool_037FB480:
	.word P2_BssStart + 0x4C8	; 037FB480
pool_037FB484:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FB484
pool_037FB488:
	.word Bios7IrqFlagsAddress	; 037FB488
.arm
.thumb
P2_IrqHandler_037FB48C:
	mov r0,#0x7	; 037FB48C
	ldr r3,[pool_037FB494]	; 037FB48E
	bx r3	; 037FB490
	.byte 0xC0, 0x46	; 037FB494
pool_037FB494:
loc_037FB494:
	.word loc_037FB4EC + 1	; 037FB494
P2_IrqHandler_037FB498:
	mov r0,#0x6	; 037FB498
	ldr r3,[pool_037FB4A0]	; 037FB49A
	bx r3	; 037FB49C
	.byte 0xC0, 0x46	; 037FB4A0
pool_037FB4A0:
loc_037FB4A0:
	.word loc_037FB4EC + 1	; 037FB4A0
P2_IrqHandler_037FB4A4:
	mov r0,#0x5	; 037FB4A4
	ldr r3,[pool_037FB4AC]	; 037FB4A6
	bx r3	; 037FB4A8
	.byte 0xC0, 0x46	; 037FB4AC
pool_037FB4AC:
loc_037FB4AC:
	.word loc_037FB4EC + 1	; 037FB4AC
P2_IrqHandler_037FB4B0:
	mov r0,#0x4	; 037FB4B0
	ldr r3,[pool_037FB4B8]	; 037FB4B2
	bx r3	; 037FB4B4
	.byte 0xC0, 0x46	; 037FB4B8
pool_037FB4B8:
loc_037FB4B8:
	.word loc_037FB4EC + 1	; 037FB4B8
P2_IrqHandler_037FB4BC:
	mov r0,#0x3	; 037FB4BC
	ldr r3,[pool_037FB4C4]	; 037FB4BE
	bx r3	; 037FB4C0
	.byte 0xC0, 0x46	; 037FB4C4
pool_037FB4C4:
loc_037FB4C4:
	.word loc_037FB4EC + 1	; 037FB4C4
P2_IrqHandler_037FB4C8:
	mov r0,#0x2	; 037FB4C8
	ldr r3,[pool_037FB4D0]	; 037FB4CA
	bx r3	; 037FB4CC
	.byte 0xC0, 0x46	; 037FB4D0
pool_037FB4D0:
loc_037FB4D0:
	.word loc_037FB4EC + 1	; 037FB4D0
P2_IrqHandler_037FB4D4:
	mov r0,#0x1	; 037FB4D4
	ldr r3,[pool_037FB4DC]	; 037FB4D6
	bx r3	; 037FB4D8
	.byte 0xC0, 0x46	; 037FB4DC
pool_037FB4DC:
loc_037FB4DC:
	.word loc_037FB4EC + 1	; 037FB4DC
P2_IrqHandler_037FB4E0:
	mov r0,#0x0	; 037FB4E0
	ldr r3,[pool_037FB4E8]	; 037FB4E2
	bx r3	; 037FB4E4
	.byte 0xC0, 0x46	; 037FB4E8
pool_037FB4E8:
loc_037FB4E8:
	.word loc_037FB4EC + 1	; 037FB4E8
loc_037FB4EC:
	push {r4,r5,lr}	; 037FB4EC
	sub sp,#0x4	; 037FB4EE
	mov r5,#0x1	; 037FB4F0
	lsl r2,r0,#0x1	; 037FB4F2
	ldr r1,[pool_037FB534]	; 037FB4F4
	ldrh r1,[r1,r2]	; 037FB4F6
	lsl r5,r1	; 037FB4F8
	mov r1,#0xc	; 037FB4FA
	add r4,r0,#0x0	; 037FB4FC
	mul r4,r1	; 037FB4FE
	ldr r2,[pool_037FB538]	; 037FB500
	ldr r1,[r2,r4]	; 037FB502
	mov r0,#0x0	; 037FB504
	str r0,[r2,r4]	; 037FB506
	cmp r1,#0x0	; 037FB508
	beq loc_037FB514	; 037FB50A
	ldr r0,[pool_037FB53C]	; 037FB50C
	ldr r0,[r0,r4]	; 037FB50E
	bl loc_038029F8	; 037FB510
loc_037FB514:
	ldr r1,[pool_037FB540]	; 037FB514
	ldr r0,[r1,#0x0]	; 037FB516
	orr r0,r5	; 037FB518
	str r0,[r1,#0x0]	; 037FB51A
	ldr r0,[pool_037FB544]	; 037FB51C
	ldr r0,[r0,r4]	; 037FB51E
	cmp r0,#0x0	; 037FB520
	bne loc_037FB52A	; 037FB522
	add r0,r5,#0x0	; 037FB524
	bl loc_037FB570	; 037FB526
loc_037FB52A:
	add sp,#0x4	; 037FB52A
	pop {r4,r5}	; 037FB52C
	pop {r3}	; 037FB52E
	bx r3	; 037FB530
	.byte 0xC0, 0x46	; 037FB534
pool_037FB534:
loc_037FB534:
	.word P2_Data_03802BD0	; 037FB534
pool_037FB538:
loc_037FB538:
	.word P2_BssStart + 0x4C8	; 037FB538
pool_037FB53C:
loc_037FB53C:
	.word P2_BssStart + 0x4D0	; 037FB53C
pool_037FB540:
loc_037FB540:
	.word Bios7IrqFlagsAddress	; 037FB540
pool_037FB544:
loc_037FB544:
	.word P2_BssStart + 0x4CC	; 037FB544
loc_037FB548:
	bx lr	; 037FB548
	.byte 0x00, 0x00	; 037FB54C

; ===== function loc_037FB54C =====
loc_037FB54C:
	push {r4,lr}	; 037FB54C
	ldr r4,[pool_037FB568]	; 037FB54E
	ldrh r3,[r4,#0x0]	; 037FB550
	mov r1,#0x0	; 037FB552
	strh r1,[r4,#0x0]	; 037FB554
	ldr r2,[pool_037FB56C]	; 037FB556
	ldr r1,[r2,#0x0]	; 037FB558
	str r0,[r2,#0x0]	; 037FB55A
	ldrh r0,[r4,#0x0]	; 037FB55C
	strh r3,[r4,#0x0]	; 037FB55E
	add r0,r1,#0x0	; 037FB560
	pop {r4}	; 037FB562
	pop {r3}	; 037FB564
	bx r3	; 037FB566
pool_037FB568:
loc_037FB568:
	.word REG_IME	; 037FB568
pool_037FB56C:
loc_037FB56C:
	.word REG_IF	; 037FB56C

; ===== function loc_037FB570 =====
loc_037FB570:
	push {r4,r5,lr}	; 037FB570
	sub sp,#0x4	; 037FB572
	ldr r5,[pool_037FB594]	; 037FB574
	ldrh r4,[r5,#0x0]	; 037FB576
	mov r1,#0x0	; 037FB578
	strh r1,[r5,#0x0]	; 037FB57A
	ldr r3,[pool_037FB598]	; 037FB57C
	ldr r2,[r3,#0x0]	; 037FB57E
	add r1,r2,#0x0	; 037FB580
	bic r1,r0	; 037FB582
	str r1,[r3,#0x0]	; 037FB584
	ldrh r0,[r5,#0x0]	; 037FB586
	strh r4,[r5,#0x0]	; 037FB588
	add r0,r2,#0x0	; 037FB58A
	add sp,#0x4	; 037FB58C
	pop {r4,r5}	; 037FB58E
	pop {r3}	; 037FB590
	bx r3	; 037FB592
pool_037FB594:
loc_037FB594:
	.word REG_IME	; 037FB594
pool_037FB598:
loc_037FB598:
	.word REG_IE	; 037FB598

; ===== function loc_037FB59C =====
loc_037FB59C:
	push {r4,r5,lr}	; 037FB59C
	sub sp,#0x4	; 037FB59E
	ldr r5,[pool_037FB5C0]	; 037FB5A0
	ldrh r4,[r5,#0x0]	; 037FB5A2
	mov r1,#0x0	; 037FB5A4
	strh r1,[r5,#0x0]	; 037FB5A6
	ldr r3,[pool_037FB5C4]	; 037FB5A8
	ldr r2,[r3,#0x0]	; 037FB5AA
	add r1,r2,#0x0	; 037FB5AC
	orr r1,r0	; 037FB5AE
	str r1,[r3,#0x0]	; 037FB5B0
	ldrh r0,[r5,#0x0]	; 037FB5B2
	strh r4,[r5,#0x0]	; 037FB5B4
	add r0,r2,#0x0	; 037FB5B6
	add sp,#0x4	; 037FB5B8
	pop {r4,r5}	; 037FB5BA
	pop {r3}	; 037FB5BC
	bx r3	; 037FB5BE
pool_037FB5C0:
loc_037FB5C0:
	.word REG_IME	; 037FB5C0
pool_037FB5C4:
loc_037FB5C4:
	.word REG_IE	; 037FB5C4

; ===== function loc_037FB5C8 =====
loc_037FB5C8:
	push {r4,lr}	; 037FB5C8
	ldr r4,[pool_037FB5E4]	; 037FB5CA
	ldrh r3,[r4,#0x0]	; 037FB5CC
	mov r1,#0x0	; 037FB5CE
	strh r1,[r4,#0x0]	; 037FB5D0
	ldr r2,[pool_037FB5E8]	; 037FB5D2
	ldr r1,[r2,#0x0]	; 037FB5D4
	str r0,[r2,#0x0]	; 037FB5D6
	ldrh r0,[r4,#0x0]	; 037FB5D8
	strh r3,[r4,#0x0]	; 037FB5DA
	add r0,r1,#0x0	; 037FB5DC
	pop {r4}	; 037FB5DE
	pop {r3}	; 037FB5E0
	bx r3	; 037FB5E2
pool_037FB5E4:
loc_037FB5E4:
	.word REG_IME	; 037FB5E4
pool_037FB5E8:
loc_037FB5E8:
	.word REG_IE	; 037FB5E8

; ===== function loc_037FB5EC =====
loc_037FB5EC:
	push {r4,lr}	; 037FB5EC
	mov r3,#0xc	; 037FB5EE
	add r4,r0,#0x0	; 037FB5F0
	mul r4,r3	; 037FB5F2
	ldr r3,[pool_037FB614]	; 037FB5F4
	str r1,[r3,r4]	; 037FB5F6
	ldr r1,[pool_037FB618]	; 037FB5F8
	str r2,[r1,r4]	; 037FB5FA
	mov r1,#0x1	; 037FB5FC
	add r0,r0,#0x3	; 037FB5FE
	lsl r1,r0	; 037FB600
	add r0,r1,#0x0	; 037FB602
	bl loc_037FB59C	; 037FB604
	mov r1,#0x1	; 037FB608
	ldr r0,[pool_037FB61C]	; 037FB60A
	str r1,[r0,r4]	; 037FB60C
	pop {r4}	; 037FB60E
	pop {r3}	; 037FB610
	bx r3	; 037FB612
pool_037FB614:
loc_037FB614:
	.word P2_BssStart + 0x4F8	; 037FB614
pool_037FB618:
loc_037FB618:
	.word P2_BssStart + 0x500	; 037FB618
pool_037FB61C:
loc_037FB61C:
	.word P2_BssStart + 0x4FC	; 037FB61C

; ===== function loc_037FB620 =====
loc_037FB620:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P2_SetIrqHandlers
	push {r4,r5,r6,r7,lr}	; 037FB620
	sub sp,#0x4	; 037FB622
	mov r5,#0x0	; 037FB624
	add r3,r5,#0x0	; 037FB626
	add r2,r5,#0x0	; 037FB628
loc_037FB62A:
	add r6,r0,#0x0	; 037FB62A
	mov r4,#0x1	; 037FB62C
	and r6,r4	; 037FB62E
	cmp r6,#0x0	; 037FB630
	beq loc_037FB67A	; 037FB632
	add r4,r3,#0x0	; 037FB634
	cmp r5,#0x8	; 037FB636
	blt loc_037FB64C	; 037FB638
	cmp r5,#0xb	; 037FB63A
	bgt loc_037FB64C	; 037FB63C
	add r6,r5,#0x0	; 037FB63E
	sub r6,#0x8	; 037FB640
	mov r4,#0xc	; 037FB642
	mul r6,r4	; 037FB644
	ldr r4,[pool_037FB68C]	; 037FB646
	add r4,r4,r6	; 037FB648
	b loc_037FB66E	; 037FB64A
loc_037FB64C:
	cmp r5,#0x3	; 037FB64C
	blt loc_037FB660	; 037FB64E
	cmp r5,#0x6	; 037FB650
	bgt loc_037FB660	; 037FB652
	add r6,r5,#0x1	; 037FB654
	mov r4,#0xc	; 037FB656
	mul r6,r4	; 037FB658
	ldr r4,[pool_037FB68C]	; 037FB65A
	add r4,r4,r6	; 037FB65C
	b loc_037FB66E	; 037FB65E
loc_037FB660:
	cmp r5,#0x0	; 037FB660
	bne loc_037FB668	; 037FB662
	ldr r4,[pool_037FB690]	; 037FB664
	b loc_037FB66E	; 037FB666
loc_037FB668:
	lsl r7,r5,#0x2	; 037FB668
	ldr r6,[pool_037FB694]	; 037FB66A
	str r1,[r6,r7]	; 037FB66C
loc_037FB66E:
	cmp r4,#0x0	; 037FB66E
	beq loc_037FB67A	; 037FB670
	str r1,[r4,#0x0]	; 037FB672
	str r2,[r4,#0x8]	; 037FB674
	mov r6,#0x1	; 037FB676
	str r6,[r4,#0x4]	; 037FB678
loc_037FB67A:
	lsr r0,r0,#0x1	; 037FB67A
	add r5,r5,#0x1	; 037FB67C
	cmp r5,#0x19	; 037FB67E
	blt loc_037FB62A	; 037FB680
	add sp,#0x4	; 037FB682
	pop {r4,r5,r6,r7}	; 037FB684
	pop {r3}	; 037FB686
	bx r3	; 037FB688
.endfunc
	.byte 0xC0, 0x46	; 037FB68C
pool_037FB68C:
loc_037FB68C:
	.word 0x038031D0	; 037FB68C
pool_037FB690:
loc_037FB690:
	.word 0x03803230	; 037FB690
pool_037FB694:
loc_037FB694:
	.word P2_IrqHandlers	; 037FB694

; ===== function loc_037FB698 =====
loc_037FB698:
	mov r1,#0x0	; 037FB698
	ldr r0,[pool_037FB6A4]	; 037FB69A
	strh r1,[r0,#0x0]	; 037FB69C
	ldr r0,[pool_037FB6A8]	; 037FB69E
	str r1,[r0,#0x0]	; 037FB6A0
	bx lr	; 037FB6A2
pool_037FB6A4:
loc_037FB6A4:
	.word P2_BssStart + 0x4C4	; 037FB6A4
pool_037FB6A8:
loc_037FB6A8:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FB6A8

; ===== function loc_037FB6AC =====
loc_037FB6AC:
	ldr r1,[pool_037FB6B0]	; 037FB6AC
	bx r1	; 037FB6AE
pool_037FB6B0:
loc_037FB6B0:
	.word loc_037FB764 + 1	; 037FB6B0
.arm

; ===== function loc_037FB6B4 =====
loc_037FB6B4:
	ldr r3,[pool_037FB744]	; 037FB6B4
	ldr r1,[r3,#0x0]	; 037FB6B8
	mov r2,#0x0	; 037FB6BC
	mov r0,#0x80000000	; 037FB6C0
loc_037FB6C4:
	tst r1,r0	; 037FB6C4
	bne loc_037FB6E0	; 037FB6C8
	add r2,r2,#0x1	; 037FB6CC
	cmp r2,#0x20	; 037FB6D0
	beq loc_037FB6E0	; 037FB6D4
	mov r0,r0, lsr #0x1	; 037FB6D8
	b loc_037FB6C4	; 037FB6DC
loc_037FB6E0:
	cmp r2,#0x20	; 037FB6E0
	movne r0,#0x80	; 037FB6E4
	bne loc_037FB728	; 037FB6E8
	add r3,r3,#0x4	; 037FB6EC
	ldr r1,[r3,#0x0]	; 037FB6F0
	mov r2,#0x0	; 037FB6F4
	mov r0,#0x80000000	; 037FB6F8
loc_037FB6FC:
	tst r1,r0	; 037FB6FC
	bne loc_037FB718	; 037FB700
	add r2,r2,#0x1	; 037FB704
	cmp r2,#0x20	; 037FB708
	beq loc_037FB718	; 037FB70C
	mov r0,r0, lsr #0x1	; 037FB710
	b loc_037FB6FC	; 037FB714
loc_037FB718:
	cmp r2,#0x20	; 037FB718
	ldr r0,[pool_037FB748]	; 037FB71C
	bxeq lr	; 037FB720
	mov r0,#0xa0	; 037FB724
loc_037FB728:
	add r0,r0,r2	; 037FB728
	mov r1,#0x80000000	; 037FB72C
	mov r1,r1, lsr r2	; 037FB730
	ldr r2,[r3,#0x0]	; 037FB734
	bic r2,r2,r1	; 037FB738
	str r2,[r3,#0x0]	; 037FB73C
	bx lr	; 037FB740
pool_037FB744:
loc_037FB744:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FB744
pool_037FB748:
loc_037FB748:
	.word 0xFFFFFFFD	; 037FB748
.thumb

; ===== function loc_037FB74C =====
loc_037FB74C:
	ldr r0,[pool_037FB754]	; 037FB74C
	ldr r3,[pool_037FB758]	; 037FB74E
	bx r3	; 037FB750
	.byte 0xC0, 0x46	; 037FB754
pool_037FB754:
loc_037FB754:
	.word 0x00001000	; 037FB754
pool_037FB758:
loc_037FB758:
	.word loc_037FCCB4 + 1	; 037FB758
	.byte 0x70, 0x47, 0x00, 0x00, 0x70, 0x47, 0x00, 0x00	; 037FB764

; ===== function loc_037FB764 =====
loc_037FB764:
	ldr r1,[pool_037FB76C]	; 037FB764
	ldr r2,[pool_037FB770]	; 037FB766
	ldr r3,[pool_037FB774]	; 037FB768
	bx r3	; 037FB76A
pool_037FB76C:
loc_037FB76C:
	.word 0x027FFFE0	; 037FB76C
pool_037FB770:
loc_037FB770:
	.word 0x037FB75D	; 037FB770
pool_037FB774:
loc_037FB774:
	.word loc_037FB82C + 1	; 037FB774

; ===== function loc_037FB778 =====
loc_037FB778:
	ldr r1,[pool_037FB780]	; 037FB778
	ldr r2,[pool_037FB784]	; 037FB77A
	ldr r3,[pool_037FB788]	; 037FB77C
	bx r3	; 037FB77E
pool_037FB780:
loc_037FB780:
	.word 0x027FFFE0	; 037FB780
pool_037FB784:
loc_037FB784:
	.word 0x037FB761	; 037FB784
pool_037FB788:
loc_037FB788:
	.word loc_037FB890 + 1	; 037FB788

; ===== function loc_037FB78C =====
loc_037FB78C:
	push {r4,r5,r6,r7,lr}	; 037FB78C
	sub sp,#0xc	; 037FB78E
	add r5,r0,#0x0	; 037FB790
	add r6,r1,#0x0	; 037FB792
	add r4,r2,#0x0	; 037FB794
	add r7,r3,#0x0	; 037FB796
	cmp r7,#0x0	; 037FB798
	beq loc_037FB7A4	; 037FB79A
	bl loc_037FB7E0	; 037FB79C
	str r0,[sp,#0x0]	; 037FB7A0
	b loc_037FB7AA	; 037FB7A2
loc_037FB7A4:
	bl loc_037FB7EC	; 037FB7A4
	str r0,[sp,#0x0]	; 037FB7A8
loc_037FB7AA:
	add r0,r5,#0x0	; 037FB7AA
	add r1,r6,#0x0	; 037FB7AC
	bl loc_037FB7F8	; 037FB7AE
	str r0,[sp,#0x4]	; 037FB7B2
	cmp r0,#0x0	; 037FB7B4
	bne loc_037FB7C2	; 037FB7B6
	cmp r4,#0x0	; 037FB7B8
	beq loc_037FB7C0	; 037FB7BA
	bl loc_03802A04	; 037FB7BC
loc_037FB7C0:
	strh r5,[r6,#0x4]	; 037FB7C0
loc_037FB7C2:
	cmp r7,#0x0	; 037FB7C2
	beq loc_037FB7CE	; 037FB7C4
	ldr r0,[sp,#0x0]	; 037FB7C6
	bl loc_037FB804	; 037FB7C8
	b loc_037FB7D4	; 037FB7CC
loc_037FB7CE:
	ldr r0,[sp,#0x0]	; 037FB7CE
	bl loc_037FB810	; 037FB7D0
loc_037FB7D4:
	ldr r0,[sp,#0x4]	; 037FB7D4
	add sp,#0xc	; 037FB7D6
	pop {r4,r5,r6,r7}	; 037FB7D8
	pop {r3}	; 037FB7DA
	bx r3	; 037FB7DC
	.byte 0xC0, 0x46	; 037FB7E0

; ===== function loc_037FB7E0 =====
loc_037FB7E0:
	bx pc	; 037FB7E0
	.byte 0xC0, 0x46	; 037FB7E4
.arm

; ===== function loc_037FB7E4 =====
loc_037FB7E4:
	ldr pc,[pool_037FB7E8]	; 037FB7E4
pool_037FB7E8:
loc_037FB7E8:
	.word loc_037FCC1C	; 037FB7E8
.thumb

; ===== function loc_037FB7EC =====
loc_037FB7EC:
	bx pc	; 037FB7EC
	.byte 0xC0, 0x46	; 037FB7F0
.arm

; ===== function loc_037FB7F0 =====
loc_037FB7F0:
	ldr pc,[pool_037FB7F4]	; 037FB7F0
pool_037FB7F4:
loc_037FB7F4:
	.word loc_037FCBF0	; 037FB7F4
.thumb

; ===== function loc_037FB7F8 =====
loc_037FB7F8:
	bx pc	; 037FB7F8
	.byte 0xC0, 0x46	; 037FB7FC
.arm

; ===== function loc_037FB7FC =====
loc_037FB7FC:
	ldr pc,[pool_037FB800]	; 037FB7FC
pool_037FB800:
loc_037FB800:
	.word loc_037FCEE4	; 037FB800
.thumb

; ===== function loc_037FB804 =====
loc_037FB804:
	bx pc	; 037FB804
	.byte 0xC0, 0x46	; 037FB808
.arm

; ===== function loc_037FB808 =====
loc_037FB808:
	ldr pc,[pool_037FB80C]	; 037FB808
pool_037FB80C:
loc_037FB80C:
	.word loc_037FCC30	; 037FB80C
.thumb

; ===== function loc_037FB810 =====
loc_037FB810:
	bx pc	; 037FB810
	.byte 0xC0, 0x46	; 037FB814
.arm

; ===== function loc_037FB814 =====
loc_037FB814:
	ldr pc,[pool_037FB818]	; 037FB814
pool_037FB818:
loc_037FB818:
	.word loc_037FCC04	; 037FB818
.thumb

; ===== function loc_037FB81C =====
loc_037FB81C:
	push {lr}	; 037FB81C
	sub sp,#0x4	; 037FB81E
	mov r3,#0x0	; 037FB820
	bl loc_037FB83C	; 037FB822
	add sp,#0x4	; 037FB826
	pop {r3}	; 037FB828
	bx r3	; 037FB82A
loc_037FB82C:
	push {lr}	; 037FB82C
	sub sp,#0x4	; 037FB82E
	mov r3,#0x0	; 037FB830
	bl loc_037FB83C	; 037FB832
	add sp,#0x4	; 037FB836
	pop {r3}	; 037FB838
	bx r3	; 037FB83A

; ===== function loc_037FB83C =====
loc_037FB83C:
	push {r4,r5,r6,r7,lr}	; 037FB83C
	sub sp,#0x4	; 037FB83E
	add r5,r1,#0x0	; 037FB840
	add r4,r2,#0x0	; 037FB842
	add r6,r3,#0x0	; 037FB844
	ldrh r1,[r5,#0x4]	; 037FB846
	cmp r0,r1	; 037FB848
	beq loc_037FB852	; 037FB84A
	mov r0,#0x1	; 037FB84C
	mvn r0,r0	; 037FB84E
	b loc_037FB888	; 037FB850
loc_037FB852:
	cmp r6,#0x0	; 037FB852
	beq loc_037FB85E	; 037FB854
	bl loc_037FB7E0	; 037FB856
	add r7,r0,#0x0	; 037FB85A
	b loc_037FB864	; 037FB85C
loc_037FB85E:
	bl loc_037FB7EC	; 037FB85E
	add r7,r0,#0x0	; 037FB862
loc_037FB864:
	mov r0,#0x0	; 037FB864
	strh r0,[r5,#0x4]	; 037FB866
	cmp r4,#0x0	; 037FB868
	beq loc_037FB870	; 037FB86A
	bl loc_03802A04	; 037FB86C
loc_037FB870:
	mov r0,#0x0	; 037FB870
	str r0,[r5,#0x0]	; 037FB872
	cmp r6,#0x0	; 037FB874
	beq loc_037FB880	; 037FB876
	add r0,r7,#0x0	; 037FB878
	bl loc_037FB804	; 037FB87A
	b loc_037FB886	; 037FB87E
loc_037FB880:
	add r0,r7,#0x0	; 037FB880
	bl loc_037FB810	; 037FB882
loc_037FB886:
	mov r0,#0x0	; 037FB886
loc_037FB888:
	add sp,#0x4	; 037FB888
	pop {r4,r5,r6,r7}	; 037FB88A
	pop {r3}	; 037FB88C
	bx r3	; 037FB88E

; ===== function loc_037FB890 =====
loc_037FB890:
	push {lr}	; 037FB890
	sub sp,#0x4	; 037FB892
	mov r3,#0x0	; 037FB894
	bl loc_037FB8A0	; 037FB896
	add sp,#0x4	; 037FB89A
	pop {r3}	; 037FB89C
	bx r3	; 037FB89E

; ===== function loc_037FB8A0 =====
loc_037FB8A0:
	push {r4,r5,r6,r7,lr}	; 037FB8A0
	sub sp,#0x4	; 037FB8A2
	add r5,r0,#0x0	; 037FB8A4
	add r4,r1,#0x0	; 037FB8A6
	add r6,r2,#0x0	; 037FB8A8
	add r7,r3,#0x0	; 037FB8AA
	b loc_037FB8B2	; 037FB8AC
loc_037FB8AE:
	bl loc_037FB74C	; 037FB8AE
loc_037FB8B2:
	add r0,r5,#0x0	; 037FB8B2
	add r1,r4,#0x0	; 037FB8B4
	add r2,r6,#0x0	; 037FB8B6
	add r3,r7,#0x0	; 037FB8B8
	bl loc_037FB78C	; 037FB8BA
	cmp r0,#0x0	; 037FB8BE
	bgt loc_037FB8AE	; 037FB8C0
	add sp,#0x4	; 037FB8C2
	pop {r4,r5,r6,r7}	; 037FB8C4
	pop {r3}	; 037FB8C6
	bx r3	; 037FB8C8
	.byte 0x00, 0x00	; 037FB8CC

; ===== function loc_037FB8CC =====
loc_037FB8CC:
	push {r4,lr}	; 037FB8CC
	ldr r0,[pool_037FB904]	; 037FB8CE
	ldr r1,[r0,#0x0]	; 037FB8D0
	cmp r1,#0x0	; 037FB8D2
	bne loc_037FB8FE	; 037FB8D4
	mov r1,#0x1	; 037FB8D6
	str r1,[r0,#0x0]	; 037FB8D8
	mov r0,#0x0	; 037FB8DA
	ldr r4,[pool_037FB908]	; 037FB8DC
	strh r0,[r4,#0x6]	; 037FB8DE
	b loc_037FB8E6	; 037FB8E0
loc_037FB8E2:
	bl loc_037FB74C	; 037FB8E2
loc_037FB8E6:
	ldrh r0,[r4,#0x4]	; 037FB8E6
	cmp r0,#0x7f	; 037FB8E8
	bne loc_037FB8E2	; 037FB8EA
	mov r0,#0x0	; 037FB8EC
	mvn r1,r0	; 037FB8EE
	ldr r0,[pool_037FB90C]	; 037FB8F0
	str r1,[r0,#0x0]	; 037FB8F2
	ldr r1,[pool_037FB910]	; 037FB8F4
	ldr r0,[pool_037FB914]	; 037FB8F6
	str r1,[r0,#0x0]	; 037FB8F8
	mov r0,#0xbf	; 037FB8FA
	strh r0,[r4,#0x6]	; 037FB8FC
loc_037FB8FE:
	pop {r4}	; 037FB8FE
	pop {r3}	; 037FB900
	bx r3	; 037FB902
pool_037FB904:
loc_037FB904:
	.word P2_BssStart + 0x534	; 037FB904
pool_037FB908:
loc_037FB908:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 037FB908
pool_037FB90C:
loc_037FB90C:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FB90C
pool_037FB910:
loc_037FB910:
	.word 0xFFFF0000	; 037FB910
pool_037FB914:
loc_037FB914:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset + 0x4	; 037FB914
	.byte 0x70, 0x47, 0x00, 0x00	; 037FB91C

; ===== function loc_037FB91C =====
loc_037FB91C:
	push {r4,r5,lr}	; 037FB91C
	sub sp,#0x4	; 037FB91E
	add r5,r0,#0x0	; 037FB920
	bl loc_037FB7EC	; 037FB922
	ldr r1,[pool_037FB93C]	; 037FB926
	ldr r4,[r1,#0x10]	; 037FB928
	str r5,[r1,#0x10]	; 037FB92A
	bl loc_037FB810	; 037FB92C
	add r0,r4,#0x0	; 037FB930
	add sp,#0x4	; 037FB932
	pop {r4,r5}	; 037FB934
	pop {r3}	; 037FB936
	bx r3	; 037FB938
	.byte 0xC0, 0x46	; 037FB93C
pool_037FB93C:
loc_037FB93C:
	.word P2_BssStart + 0x544	; 037FB93C

; ===== function loc_037FB940 =====
loc_037FB940:
	push {r4,r5,r6,lr}	; 037FB940
	ldr r6,[pool_037FB9A4]	; 037FB942
	ldrh r0,[r6,#0x4]	; 037FB944
	cmp r0,#0x0	; 037FB946
	bne loc_037FB952	; 037FB948
	bl loc_037FB9B0	; 037FB94A
	cmp r0,#0x12	; 037FB94E
	bne loc_037FB958	; 037FB950
loc_037FB952:
	mov r0,#0x1	; 037FB952
	strh r0,[r6,#0x0]	; 037FB954
	b loc_037FB99E	; 037FB956
loc_037FB958:
	ldr r0,[pool_037FB9A8]	; 037FB958
	ldr r0,[r0,#0x0]	; 037FB95A
	ldr r5,[r0,#0x0]	; 037FB95C
	bl loc_037FB9D4	; 037FB95E
	add r4,r0,#0x0	; 037FB962
	cmp r5,r4	; 037FB964
	beq loc_037FB99E	; 037FB966
	cmp r4,#0x0	; 037FB968
	beq loc_037FB99E	; 037FB96A
	add r0,r5,#0x0	; 037FB96C
	bl loc_037FB9BC	; 037FB96E
	cmp r0,#0x0	; 037FB972
	bne loc_037FB99E	; 037FB974
	ldr r0,[pool_037FB9AC]	; 037FB976
	ldr r2,[r0,#0x0]	; 037FB978
	cmp r2,#0x0	; 037FB97A
	beq loc_037FB986	; 037FB97C
	add r0,r5,#0x0	; 037FB97E
	add r1,r4,#0x0	; 037FB980
	bl loc_038029FC	; 037FB982
loc_037FB986:
	ldr r2,[r6,#0x10]	; 037FB986
	cmp r2,#0x0	; 037FB988
	beq loc_037FB994	; 037FB98A
	add r0,r5,#0x0	; 037FB98C
	add r1,r4,#0x0	; 037FB98E
	bl loc_038029FC	; 037FB990
loc_037FB994:
	ldr r0,[pool_037FB9A4]	; 037FB994
	str r4,[r0,#0x8]	; 037FB996
	add r0,r4,#0x0	; 037FB998
	bl loc_037FB9C8	; 037FB99A
loc_037FB99E:
	pop {r4,r5,r6}	; 037FB99E
	pop {r3}	; 037FB9A0
	bx r3	; 037FB9A2
pool_037FB9A4:
loc_037FB9A4:
	.word P2_BssStart + 0x544	; 037FB9A4
pool_037FB9A8:
loc_037FB9A8:
	.word P2_BssStart + 0x53C	; 037FB9A8
pool_037FB9AC:
loc_037FB9AC:
	.word P2_BssStart + 0x538	; 037FB9AC

; ===== function loc_037FB9B0 =====
loc_037FB9B0:
	bx pc	; 037FB9B0
	.byte 0xC0, 0x46	; 037FB9B4
.arm

; ===== function loc_037FB9B4 =====
loc_037FB9B4:
	ldr pc,[pool_037FB9B8]	; 037FB9B4
pool_037FB9B8:
loc_037FB9B8:
	.word loc_037FCC48	; 037FB9B8
.thumb

; ===== function loc_037FB9BC =====
loc_037FB9BC:
	bx pc	; 037FB9BC
	.byte 0xC0, 0x46	; 037FB9C0
.arm

; ===== function loc_037FB9C0 =====
loc_037FB9C0:
	ldr pc,[pool_037FB9C4]	; 037FB9C0
pool_037FB9C4:
loc_037FB9C4:
	.word P2_SaveThreadContext	; 037FB9C4
.thumb

; ===== function loc_037FB9C8 =====
loc_037FB9C8:
	bx pc	; 037FB9C8
	.byte 0xC0, 0x46	; 037FB9CC
.arm

; ===== function loc_037FB9CC =====
loc_037FB9CC:
	ldr pc,[pool_037FB9D0]	; 037FB9CC
pool_037FB9D0:
loc_037FB9D0:
	.word P2_LoadThreadContext	; 037FB9D0
.thumb

; ===== function loc_037FB9D4 =====
loc_037FB9D4:
	ldr r0,[pool_037FB9E8]	; 037FB9D4
	ldr r0,[r0,#0xc]	; 037FB9D6
	b loc_037FB9DC	; 037FB9D8
loc_037FB9DA:
	ldr r0,[r0,#0x4c]	; 037FB9DA
loc_037FB9DC:
	cmp r0,#0x0	; 037FB9DC
	beq loc_037FB9E6	; 037FB9DE
	ldr r1,[r0,#0x48]	; 037FB9E0
	cmp r1,#0x1	; 037FB9E2
	bne loc_037FB9DA	; 037FB9E4
loc_037FB9E6:
	bx lr	; 037FB9E6
pool_037FB9E8:
loc_037FB9E8:
	.word P2_BssStart + 0x544	; 037FB9E8

; ===== function loc_037FB9EC =====
loc_037FB9EC:
	push {r4,r5,lr}	; 037FB9EC
	sub sp,#0x4	; 037FB9EE
	add r5,r0,#0x0	; 037FB9F0
	bl loc_037FB7EC	; 037FB9F2
	add r4,r0,#0x0	; 037FB9F6
	mov r0,#0x1	; 037FB9F8
	str r0,[r5,#0x48]	; 037FB9FA
	bl loc_037FB940	; 037FB9FC
	add r0,r4,#0x0	; 037FBA00
	bl loc_037FB810	; 037FBA02
	add sp,#0x4	; 037FBA06
	pop {r4,r5}	; 037FBA08
	pop {r3}	; 037FBA0A
	bx r3	; 037FBA0C
	.byte 0x00, 0x00	; 037FBA10

; ===== function loc_037FBA10 =====
loc_037FBA10:
	push {r4,r5,r6,lr}	; 037FBA10
	add r5,r0,#0x0	; 037FBA12
	bl loc_037FB7EC	; 037FBA14
	add r4,r0,#0x0	; 037FBA18
	ldrh r1,[r5,#0x0]	; 037FBA1A
	cmp r1,#0x0	; 037FBA1C
	beq loc_037FBA46	; 037FBA1E
	ldr r0,[pool_037FBA54]	; 037FBA20
	ldr r0,[r0,#0xc]	; 037FBA22
	mov r3,#0x1	; 037FBA24
	b loc_037FBA3A	; 037FBA26
loc_037FBA28:
	ldr r2,[r0,#0x50]	; 037FBA28
	add r6,r3,#0x0	; 037FBA2A
	lsl r6,r2	; 037FBA2C
	add r2,r1,#0x0	; 037FBA2E
	and r2,r6	; 037FBA30
	cmp r2,#0x0	; 037FBA32
	beq loc_037FBA38	; 037FBA34
	str r3,[r0,#0x48]	; 037FBA36
loc_037FBA38:
	ldr r0,[r0,#0x4c]	; 037FBA38
loc_037FBA3A:
	cmp r0,#0x0	; 037FBA3A
	bne loc_037FBA28	; 037FBA3C
	mov r0,#0x0	; 037FBA3E
	strh r0,[r5,#0x0]	; 037FBA40
	bl loc_037FB940	; 037FBA42
loc_037FBA46:
	add r0,r4,#0x0	; 037FBA46
	bl loc_037FB810	; 037FBA48
	pop {r4,r5,r6}	; 037FBA4C
	pop {r3}	; 037FBA4E
	bx r3	; 037FBA50
	.byte 0xC0, 0x46	; 037FBA54
pool_037FBA54:
loc_037FBA54:
	.word P2_BssStart + 0x544	; 037FBA54

; ===== function loc_037FBA58 =====
loc_037FBA58:
	push {r4,r5,lr}	; 037FBA58
	sub sp,#0x4	; 037FBA5A
	add r5,r0,#0x0	; 037FBA5C
	bl loc_037FB7EC	; 037FBA5E
	add r4,r0,#0x0	; 037FBA62
	ldr r0,[pool_037FBA94]	; 037FBA64
	ldr r0,[r0,#0x0]	; 037FBA66
	ldr r1,[r0,#0x0]	; 037FBA68
	cmp r5,#0x0	; 037FBA6A
	beq loc_037FBA7E	; 037FBA6C
	ldrh r0,[r5,#0x0]	; 037FBA6E
	mov r3,#0x1	; 037FBA70
	ldr r2,[r1,#0x50]	; 037FBA72
	lsl r3,r2	; 037FBA74
	lsl r2,r3,#0x10	; 037FBA76
	lsr r2,r2,#0x10	; 037FBA78
	orr r0,r2	; 037FBA7A
	strh r0,[r5,#0x0]	; 037FBA7C
loc_037FBA7E:
	mov r0,#0x0	; 037FBA7E
	str r0,[r1,#0x48]	; 037FBA80
	bl loc_037FB940	; 037FBA82
	add r0,r4,#0x0	; 037FBA86
	bl loc_037FB810	; 037FBA88
	add sp,#0x4	; 037FBA8C
	pop {r4,r5}	; 037FBA8E
	pop {r3}	; 037FBA90
	bx r3	; 037FBA92
pool_037FBA94:
loc_037FBA94:
	.word P2_BssStart + 0x53C	; 037FBA94
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P2_ExitThread
	push {r4,lr}	; 037FBA98
	bl loc_037FB7EC	; 037FBA9A
	ldr r0,[pool_037FBAD0]	; 037FBA9E
	ldr r0,[r0,#0x0]	; 037FBAA0
	ldr r4,[r0,#0x0]	; 037FBAA2
	add r0,r4,#0x0	; 037FBAA4
	bl loc_037FBECC	; 037FBAA6
	add r0,r4,#0x0	; 037FBAAA
	bl loc_037FBC48	; 037FBAAC
	mov r2,#0x0	; 037FBAB0
	ldr r0,[r4,#0x50]	; 037FBAB2
	lsl r1,r0,#0x2	; 037FBAB4
	ldr r0,[pool_037FBAD4]	; 037FBAB6
	str r2,[r0,r1]	; 037FBAB8
	mov r0,#0x2	; 037FBABA
	str r0,[r4,#0x48]	; 037FBABC
	add r4,#0x74	; 037FBABE
	add r0,r4,#0x0	; 037FBAC0
	bl loc_037FBA10	; 037FBAC2
	bl loc_037FB940	; 037FBAC6
	pop {r4}	; 037FBACA
	pop {r3}	; 037FBACC
	bx r3	; 037FBACE
.endfunc
pool_037FBAD0:
loc_037FBAD0:
	.word P2_BssStart + 0x53C	; 037FBAD0
pool_037FBAD4:
loc_037FBAD4:
	.word P2_BssStart + 0x558	; 037FBAD4

; ===== function loc_037FBAD8 =====
loc_037FBAD8:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P2_CreateThread
	push {r4,r5,r6,r7,lr}	; 037FBAD8
	sub sp,#0xc	; 037FBADA
	add r5,r0,#0x0	; 037FBADC
	str r1,[sp,#0x0]	; 037FBADE
	add r7,r2,#0x0	; 037FBAE0
	add r4,r3,#0x0	; 037FBAE2
	bl loc_037FB7EC	; 037FBAE4
	str r0,[sp,#0x4]	; 037FBAE8
	bl loc_037FBCB0	; 037FBAEA
	cmp r0,#0x0	; 037FBAEE
	bge loc_037FBAFA	; 037FBAF0
	ldr r0,[sp,#0x4]	; 037FBAF2
	bl loc_037FB810	; 037FBAF4
	b loc_037FBB58	; 037FBAF8
loc_037FBAFA:
	ldr r1,[sp,#0x24]	; 037FBAFA
	str r1,[r5,#0x54]	; 037FBAFC
	str r0,[r5,#0x50]	; 037FBAFE
	mov r1,#0x0	; 037FBB00
	str r1,[r5,#0x48]	; 037FBB02
	lsl r1,r0,#0x2	; 037FBB04
	ldr r0,[pool_037FBB60]	; 037FBB06
	str r5,[r0,r1]	; 037FBB08
	add r0,r5,#0x0	; 037FBB0A
	bl loc_037FBC74	; 037FBB0C
	str r4,[r5,#0x6c]	; 037FBB10
	ldr r0,[sp,#0x20]	; 037FBB12
	sub r6,r4,r0	; 037FBB14
	str r6,[r5,#0x68]	; 037FBB16
	mov r0,#0x0	; 037FBB18
	str r0,[r5,#0x70]	; 037FBB1A
	ldr r1,[pool_037FBB64]	; 037FBB1C
	ldr r0,[r5,#0x6c]	; 037FBB1E
	sub r0,r0,#0x4	; 037FBB20
	str r1,[r0,#0x0]	; 037FBB22
	ldr r1,[pool_037FBB68]	; 037FBB24
	ldr r0,[r5,#0x68]	; 037FBB26
	str r1,[r0,#0x0]	; 037FBB28
	add r0,r5,#0x0	; 037FBB2A
	ldr r1,[sp,#0x0]	; 037FBB2C
	sub r2,r4,#0x4	; 037FBB2E
	bl loc_037FBB70	; 037FBB30
	str r7,[r5,#ThreadContextR0Offset]	; 037FBB34
	ldr r0,[pool_037FBB6C]	; 037FBB36
	str r0,[r5,#ThreadContextLrOffset]	; 037FBB38
	mov r0,#0x0	; 037FBB3A
	str r0,[sp,#0x8]	; 037FBB3C
	ldr r0,[sp,#0x8]	; 037FBB3E
	add r1,r6,#0x4	; 037FBB40
	ldr r2,[sp,#0x20]	; 037FBB42
	sub r2,#0x8	; 037FBB44
	bl loc_037FBB7C	; 037FBB46
	mov r0,#0x0	; 037FBB4A
	str r0,[r5,#0x5c]	; 037FBB4C
	str r0,[r5,#0x60]	; 037FBB4E
	str r0,[r5,#0x64]	; 037FBB50
	ldr r0,[sp,#0x4]	; 037FBB52
	bl loc_037FB810	; 037FBB54
loc_037FBB58:
	add sp,#0xc	; 037FBB58
	pop {r4,r5,r6,r7}	; 037FBB5A
	pop {r3}	; 037FBB5C
	bx r3	; 037FBB5E
.endfunc
pool_037FBB60:
loc_037FBB60:
	.word P2_BssStart + 0x558	; 037FBB60
pool_037FBB64:
loc_037FBB64:
	.word 0xD73BFDF7	; 037FBB64
pool_037FBB68:
loc_037FBB68:
	.word 0xFBDD37BB	; 037FBB68
pool_037FBB6C:
loc_037FBB6C:
	.word P2_ExitThread + 1	; 037FBB6C

; ===== function loc_037FBB70 =====
loc_037FBB70:
	bx pc	; 037FBB70
	.byte 0xC0, 0x46	; 037FBB74
.arm

; ===== function loc_037FBB74 =====
loc_037FBB74:
	ldr pc,[pool_037FBB78]	; 037FBB74
pool_037FBB78:
loc_037FBB78:
	.word P2_InitThreadContext	; 037FBB78
.thumb

; ===== function loc_037FBB7C =====
loc_037FBB7C:
	bx pc	; 037FBB7C
	.byte 0xC0, 0x46	; 037FBB80
.arm

; ===== function loc_037FBB80 =====
loc_037FBB80:
	ldr pc,[pool_037FBB84]	; 037FBB80
pool_037FBB84:
loc_037FBB84:
	.word loc_037FCE38	; 037FBB84
.thumb

; ===== function loc_037FBB88 =====
loc_037FBB88:
	push {lr}	; 037FBB88
	sub sp,#0x4	; 037FBB8A
	ldr r0,[pool_037FBC14]	; 037FBB8C
	ldr r1,[r0,#0x0]	; 037FBB8E
	cmp r1,#0x0	; 037FBB90
	bne loc_037FBC0C	; 037FBB92
	mov r1,#0x1	; 037FBB94
	str r1,[r0,#0x0]	; 037FBB96
	mov r3,#0x0	; 037FBB98
	add r1,r3,#0x0	; 037FBB9A
	ldr r0,[pool_037FBC18]	; 037FBB9C
loc_037FBB9E:
	lsl r2,r3,#0x2	; 037FBB9E
	add r2,r0,r2	; 037FBBA0
	str r1,[r2,#0x14]	; 037FBBA2
	add r3,r3,#0x1	; 037FBBA4
	cmp r3,#0x10	; 037FBBA6
	blt loc_037FBB9E	; 037FBBA8
	ldr r3,[pool_037FBC1C]	; 037FBBAA
	ldr r2,[pool_037FBC20]	; 037FBBAC
	str r3,[r2,#0x0]	; 037FBBAE
	mov r3,#0x10	; 037FBBB0
	ldr r2,[pool_037FBC24]	; 037FBBB2
	str r3,[r2,#0x54]	; 037FBBB4
	str r1,[r2,#0x50]	; 037FBBB6
	mov r3,#0x1	; 037FBBB8
	str r3,[r2,#0x48]	; 037FBBBA
	str r1,[r2,#0x4c]	; 037FBBBC
	str r1,[r2,#0x58]	; 037FBBBE
	str r2,[r0,#0x14]	; 037FBBC0
	str r2,[r0,#0xc]	; 037FBBC2
	str r2,[r0,#0x8]	; 037FBBC4
	ldr r2,[pool_037FBC28]	; 037FBBC6
	cmp r2,#0x0	; 037FBBC8
	bne loc_037FBBD2	; 037FBBCA
	ldr r0,[pool_037FBC2C]	; 037FBBCC
	sub r3,r0,r2	; 037FBBCE
	b loc_037FBBDA	; 037FBBD0
loc_037FBBD2:
	ldr r1,[pool_037FBC30]	; 037FBBD2
	ldr r0,[pool_037FBC34]	; 037FBBD4
	sub r0,r0,r1	; 037FBBD6
	sub r3,r0,r2	; 037FBBD8
loc_037FBBDA:
	ldr r1,[pool_037FBC30]	; 037FBBDA
	ldr r0,[pool_037FBC34]	; 037FBBDC
	sub r1,r0,r1	; 037FBBDE
	ldr r2,[pool_037FBC24]	; 037FBBE0
	str r1,[r2,#0x6c]	; 037FBBE2
	str r3,[r2,#0x68]	; 037FBBE4
	mov r0,#0x0	; 037FBBE6
	str r0,[r2,#0x70]	; 037FBBE8
	ldr r3,[pool_037FBC38]	; 037FBBEA
	sub r1,r1,#0x4	; 037FBBEC
	str r3,[r1,#0x0]	; 037FBBEE
	ldr r3,[pool_037FBC3C]	; 037FBBF0
	ldr r1,[r2,#0x68]	; 037FBBF2
	str r3,[r1,#0x0]	; 037FBBF4
	ldr r1,[pool_037FBC40]	; 037FBBF6
	strh r0,[r1,#0x34]	; 037FBBF8
	mov r2,#0x10	; 037FBBFA
	ldr r1,[pool_037FBC18]	; 037FBBFC
	strh r2,[r1,#0x2]	; 037FBBFE
	strh r0,[r1,#0x0]	; 037FBC00
	strh r0,[r1,#0x4]	; 037FBC02
	ldr r2,[pool_037FBC44]	; 037FBC04
	str r1,[r2,#0x0]	; 037FBC06
	bl loc_037FB91C	; 037FBC08
loc_037FBC0C:
	add sp,#0x4	; 037FBC0C
	pop {r3}	; 037FBC0E
	bx r3	; 037FBC10
	.byte 0xC0, 0x46	; 037FBC14
pool_037FBC14:
loc_037FBC14:
	.word P2_BssStart + 0x540	; 037FBC14
pool_037FBC18:
loc_037FBC18:
	.word P2_BssStart + 0x544	; 037FBC18
pool_037FBC1C:
loc_037FBC1C:
	.word 0x03803254	; 037FBC1C
pool_037FBC20:
loc_037FBC20:
	.word P2_BssStart + 0x53C	; 037FBC20
pool_037FBC24:
loc_037FBC24:
	.word P2_BssStart + 0x598	; 037FBC24
pool_037FBC28:
loc_037FBC28:
	.word 0x00000400	; 037FBC28
pool_037FBC2C:
loc_037FBC2C:
	.word P2_WramCopy0RuntimeStart	; 037FBC2C
pool_037FBC30:
loc_037FBC30:
	.word 0x00000200	; 037FBC30
pool_037FBC34:
loc_037FBC34:
	.word 0x0380FF80	; 037FBC34
pool_037FBC38:
loc_037FBC38:
	.word 0xD73BFDF7	; 037FBC38
pool_037FBC3C:
loc_037FBC3C:
	.word 0xFBDD37BB	; 037FBC3C
pool_037FBC40:
loc_037FBC40:
	.word P2_BssStart + 0x5D8	; 037FBC40
pool_037FBC44:
loc_037FBC44:
	.word FirmwareSystemWorkAddress + SystemWorkArm7ThreadInfoOffset	; 037FBC44

; ===== function loc_037FBC48 =====
loc_037FBC48:
	ldr r1,[pool_037FBC70]	; 037FBC48
	ldr r2,[r1,#0xc]	; 037FBC4A
	mov r1,#0x0	; 037FBC4C
	b loc_037FBC54	; 037FBC4E
loc_037FBC50:
	add r1,r2,#0x0	; 037FBC50
	ldr r2,[r2,#0x4c]	; 037FBC52
loc_037FBC54:
	cmp r2,#0x0	; 037FBC54
	beq loc_037FBC5C	; 037FBC56
	cmp r2,r0	; 037FBC58
	bne loc_037FBC50	; 037FBC5A
loc_037FBC5C:
	cmp r1,#0x0	; 037FBC5C
	bne loc_037FBC68	; 037FBC5E
	ldr r1,[r0,#0x4c]	; 037FBC60
	ldr r0,[pool_037FBC70]	; 037FBC62
	str r1,[r0,#0xc]	; 037FBC64
	bx lr	; 037FBC66
loc_037FBC68:
	ldr r0,[r0,#0x4c]	; 037FBC68
	str r0,[r1,#0x4c]	; 037FBC6A
	bx lr	; 037FBC6C
	.byte 0xC0, 0x46	; 037FBC70
pool_037FBC70:
loc_037FBC70:
	.word P2_BssStart + 0x544	; 037FBC70

; ===== function loc_037FBC74 =====
loc_037FBC74:
	push {r4,r5,lr}	; 037FBC74
	sub sp,#0x4	; 037FBC76
	ldr r1,[pool_037FBCAC]	; 037FBC78
	ldr r3,[r1,#0xc]	; 037FBC7A
	add r5,r3,#0x0	; 037FBC7C
	mov r4,#0x0	; 037FBC7E
	b loc_037FBC86	; 037FBC80
loc_037FBC82:
	add r4,r5,#0x0	; 037FBC82
	ldr r5,[r5,#0x4c]	; 037FBC84
loc_037FBC86:
	cmp r5,#0x0	; 037FBC86
	beq loc_037FBC92	; 037FBC88
	ldr r2,[r5,#0x54]	; 037FBC8A
	ldr r1,[r0,#0x54]	; 037FBC8C
	cmp r2,r1	; 037FBC8E
	bcc loc_037FBC82	; 037FBC90
loc_037FBC92:
	cmp r4,#0x0	; 037FBC92
	bne loc_037FBC9E	; 037FBC94
	str r3,[r0,#0x4c]	; 037FBC96
	ldr r1,[pool_037FBCAC]	; 037FBC98
	str r0,[r1,#0xc]	; 037FBC9A
	b loc_037FBCA4	; 037FBC9C
loc_037FBC9E:
	ldr r1,[r4,#0x4c]	; 037FBC9E
	str r1,[r0,#0x4c]	; 037FBCA0
	str r0,[r4,#0x4c]	; 037FBCA2
loc_037FBCA4:
	add sp,#0x4	; 037FBCA4
	pop {r4,r5}	; 037FBCA6
	pop {r3}	; 037FBCA8
	bx r3	; 037FBCAA
pool_037FBCAC:
loc_037FBCAC:
	.word P2_BssStart + 0x544	; 037FBCAC

; ===== function loc_037FBCB0 =====
loc_037FBCB0:
	mov r0,#0x0	; 037FBCB0
	ldr r2,[pool_037FBCCC]	; 037FBCB2
	b loc_037FBCC2	; 037FBCB4
loc_037FBCB6:
	lsl r1,r0,#0x2	; 037FBCB6
	add r1,r2,r1	; 037FBCB8
	ldr r1,[r1,#0x14]	; 037FBCBA
	cmp r1,#0x0	; 037FBCBC
	beq loc_037FBCCA	; 037FBCBE
	add r0,r0,#0x1	; 037FBCC0
loc_037FBCC2:
	cmp r0,#0x10	; 037FBCC2
	blt loc_037FBCB6	; 037FBCC4
	mov r0,#0x0	; 037FBCC6
	mvn r0,r0	; 037FBCC8
loc_037FBCCA:
	bx lr	; 037FBCCA
pool_037FBCCC:
loc_037FBCCC:
	.word 0x0380324C	; 037FBCCC
.arm

; ===== function loc_037FBCD0 =====
loc_037FBCD0:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P2_InitThreadContext
	add r1,r1,#0x4	; 037FBCD0
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 037FBCD4
	str r2,[r0,#ThreadContextSvcSpOffset]	; 037FBCD8
	sub r2,r2,#ThreadContextSvcStackBytes	; 037FBCDC
	str r2,[r0,#ThreadContextSpOffset]	; 037FBCE0
	ands r1,r1,#0x1	; 037FBCE4
	movne r1,#0x3f	; 037FBCE8
	moveq r1,#0x1f	; 037FBCEC
	str r1,[r0,#ThreadContextCpsrOffset]	; 037FBCF0
	mov r1,#0x0	; 037FBCF4
	str r1,[r0,#ThreadContextR0Offset]	; 037FBCF8
	str r1,[r0,#0x8]	; 037FBCFC
	str r1,[r0,#0xc]	; 037FBD00
	str r1,[r0,#0x10]	; 037FBD04
	str r1,[r0,#0x14]	; 037FBD08
	str r1,[r0,#0x18]	; 037FBD0C
	str r1,[r0,#0x1c]	; 037FBD10
	str r1,[r0,#0x20]	; 037FBD14
	str r1,[r0,#0x24]	; 037FBD18
	str r1,[r0,#0x28]	; 037FBD1C
	str r1,[r0,#0x2c]	; 037FBD20
	str r1,[r0,#0x30]	; 037FBD24
	str r1,[r0,#0x34]	; 037FBD28
	str r1,[r0,#ThreadContextLrOffset]	; 037FBD2C
	bx lr	; 037FBD30
.endfunc

; ===== function loc_037FBD34 =====
loc_037FBD34:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P2_SaveThreadContext
	add r1,r0,#0x0	; 037FBD34
	mrs r2,cpsr	; 037FBD38
	str r2,[r1],#0x4	; 037FBD3C
	mov r0,#0xd3	; 037FBD40
	msr cpsr_c,r0	; 037FBD44
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FBD48
	msr cpsr_c,r2	; 037FBD4C
	mov r0,#0x1	; 037FBD50
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FBD54
	adr r0,P2_SaveThreadContextReturn + 4	; 037FBD58
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FBD5C
	mov r0,#0x0	; 037FBD60
P2_SaveThreadContextReturn:
	bx lr	; 037FBD64
.endfunc

; ===== function loc_037FBD68 =====
loc_037FBD68:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P2_LoadThreadContext
	mrs r1,cpsr	; 037FBD68
	bic r1,r1,#0x1f	; 037FBD6C
	orr r1,r1,#0xd3	; 037FBD70
	msr cpsr_c,r1	; 037FBD74
	ldr r1,[r0],#0x4	; 037FBD78
	msr spsr_cxsf,r1	; 037FBD7C
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FBD80
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FBD84
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FBD88
	mov r0,r0	; 037FBD8C
	subs pc,lr,#0x4	; 037FBD90
.endfunc
.thumb

; ===== function loc_037FBD94 =====
loc_037FBD94:
	push {r4,r5,r6,r7,lr}	; 037FBD94
	sub sp,#0x4	; 037FBD96
	add r5,r0,#0x0	; 037FBD98
	add r6,r1,#0x0	; 037FBD9A
	add r4,r2,#0x0	; 037FBD9C
	bl loc_037FB7EC	; 037FBD9E
	add r7,r0,#0x0	; 037FBDA2
	mov r0,#0x1	; 037FBDA4
	and r4,r0	; 037FBDA6
	add r0,r5,#0x2	; 037FBDA8
	str r0,[sp,#0x0]	; 037FBDAA
	b loc_037FBDC2	; 037FBDAC
loc_037FBDAE:
	cmp r4,#0x0	; 037FBDAE
	bne loc_037FBDBC	; 037FBDB0
	add r0,r7,#0x0	; 037FBDB2
	bl loc_037FB810	; 037FBDB4
	mov r0,#0x0	; 037FBDB8
	b loc_037FBDFA	; 037FBDBA
loc_037FBDBC:
	ldr r0,[sp,#0x0]	; 037FBDBC
	bl loc_037FBA58	; 037FBDBE
loc_037FBDC2:
	ldr r0,[r5,#0x10]	; 037FBDC2
	cmp r0,#0x0	; 037FBDC4
	beq loc_037FBDAE	; 037FBDC6
	cmp r6,#0x0	; 037FBDC8
	beq loc_037FBDD6	; 037FBDCA
	ldr r1,[r5,#0x4]	; 037FBDCC
	ldr r0,[r5,#0xc]	; 037FBDCE
	lsl r0,r0,#0x2	; 037FBDD0
	ldr r0,[r1,r0]	; 037FBDD2
	str r0,[r6,#0x0]	; 037FBDD4
loc_037FBDD6:
	ldr r0,[r5,#0xc]	; 037FBDD6
	add r0,r0,#0x1	; 037FBDD8
	ldr r1,[r5,#0x8]	; 037FBDDA
	bl loc_037FBE04	; 037FBDDC
	str r1,[r5,#0xc]	; 037FBDE0
	add r1,r5,#0x0	; 037FBDE2
	add r1,#0x10	; 037FBDE4
	ldr r0,[r1,#0x0]	; 037FBDE6
	sub r0,r0,#0x1	; 037FBDE8
	str r0,[r1,#0x0]	; 037FBDEA
	add r0,r5,#0x0	; 037FBDEC
	bl loc_037FBA10	; 037FBDEE
	add r0,r7,#0x0	; 037FBDF2
	bl loc_037FB810	; 037FBDF4
	mov r0,#0x1	; 037FBDF8
loc_037FBDFA:
	add sp,#0x4	; 037FBDFA
	pop {r4,r5,r6,r7}	; 037FBDFC
	pop {r3}	; 037FBDFE
	bx r3	; 037FBE00
	.byte 0xC0, 0x46	; 037FBE04

; ===== function loc_037FBE04 =====
loc_037FBE04:
	bx pc	; 037FBE04
	.byte 0xC0, 0x46	; 037FBE08
.arm

; ===== function loc_037FBE08 =====
loc_037FBE08:
	ldr pc,[pool_037FBE0C]	; 037FBE08
pool_037FBE0C:
loc_037FBE0C:
	.word loc_03802514	; 037FBE0C
.thumb

; ===== function loc_037FBE10 =====
loc_037FBE10:
	push {r4,r5,r6,r7,lr}	; 037FBE10
	sub sp,#0x4	; 037FBE12
	add r5,r0,#0x0	; 037FBE14
	add r6,r1,#0x0	; 037FBE16
	add r4,r2,#0x0	; 037FBE18
	bl loc_037FB7EC	; 037FBE1A
	add r7,r0,#0x0	; 037FBE1E
	mov r0,#0x1	; 037FBE20
	and r4,r0	; 037FBE22
	b loc_037FBE3A	; 037FBE24
loc_037FBE26:
	cmp r4,#0x0	; 037FBE26
	bne loc_037FBE34	; 037FBE28
	add r0,r7,#0x0	; 037FBE2A
	bl loc_037FB810	; 037FBE2C
	mov r0,#0x0	; 037FBE30
	b loc_037FBE68	; 037FBE32
loc_037FBE34:
	add r0,r5,#0x0	; 037FBE34
	bl loc_037FBA58	; 037FBE36
loc_037FBE3A:
	ldr r2,[r5,#0x10]	; 037FBE3A
	ldr r1,[r5,#0x8]	; 037FBE3C
	cmp r1,r2	; 037FBE3E
	ble loc_037FBE26	; 037FBE40
	ldr r0,[r5,#0xc]	; 037FBE42
	add r0,r0,r2	; 037FBE44
	bl loc_037FBE04	; 037FBE46
	ldr r2,[r5,#0x4]	; 037FBE4A
	lsl r0,r1,#0x2	; 037FBE4C
	str r6,[r2,r0]	; 037FBE4E
	add r1,r5,#0x0	; 037FBE50
	add r1,#0x10	; 037FBE52
	ldr r0,[r1,#0x0]	; 037FBE54
	add r0,r0,#0x1	; 037FBE56
	str r0,[r1,#0x0]	; 037FBE58
	add r0,r5,#0x2	; 037FBE5A
	bl loc_037FBA10	; 037FBE5C
	add r0,r7,#0x0	; 037FBE60
	bl loc_037FB810	; 037FBE62
	mov r0,#0x1	; 037FBE66
loc_037FBE68:
	add sp,#0x4	; 037FBE68
	pop {r4,r5,r6,r7}	; 037FBE6A
	pop {r3}	; 037FBE6C
	bx r3	; 037FBE6E

; ===== function loc_037FBE70 =====
loc_037FBE70:
	mov r3,#0x0	; 037FBE70
	strh r3,[r0,#0x0]	; 037FBE72
	strh r3,[r0,#0x2]	; 037FBE74
	str r1,[r0,#0x4]	; 037FBE76
	str r2,[r0,#0x8]	; 037FBE78
	str r3,[r0,#0xc]	; 037FBE7A
	str r3,[r0,#0x10]	; 037FBE7C
	bx lr	; 037FBE7E

; ===== function loc_037FBE80 =====
loc_037FBE80:
	ldr r3,[r0,#0x60]	; 037FBE80
	ldr r2,[r3,#0x10]	; 037FBE82
	cmp r2,#0x0	; 037FBE84
	bne loc_037FBE8E	; 037FBE86
	mov r1,#0x0	; 037FBE88
	str r1,[r0,#0x64]	; 037FBE8A
	b loc_037FBE92	; 037FBE8C
loc_037FBE8E:
	mov r1,#0x0	; 037FBE8E
	str r1,[r2,#0xc]	; 037FBE90
loc_037FBE92:
	str r2,[r0,#0x60]	; 037FBE92
	add r0,r3,#0x0	; 037FBE94
	bx lr	; 037FBE96
P2_Entry_037FBE98:
	ldr r2,[r1,#0x10]	; 037FBE98
	ldr r1,[r1,#0xc]	; 037FBE9A
	cmp r2,#0x0	; 037FBE9C
	bne P2_Entry_037FBEA4	; 037FBE9E
	str r1,[r0,#0x64]	; 037FBEA0
	b P2_Entry_037FBEA6	; 037FBEA2
P2_Entry_037FBEA4:
	str r1,[r2,#0xc]	; 037FBEA4
P2_Entry_037FBEA6:
	cmp r1,#0x0	; 037FBEA6
	bne P2_Entry_037FBEAE	; 037FBEA8
	str r2,[r0,#0x60]	; 037FBEAA
	bx lr	; 037FBEAC
P2_Entry_037FBEAE:
	str r2,[r1,#0x10]	; 037FBEAE
	bx lr	; 037FBEB0
	.byte 0x00, 0x00	; 037FBEB2
P2_Entry_037FBEB4:
	ldr r3,[r0,#0x64]	; 037FBEB4
	cmp r3,#0x0	; 037FBEB6
	bne P2_Entry_037FBEBE	; 037FBEB8
	str r1,[r0,#0x60]	; 037FBEBA
	b P2_Entry_037FBEC2	; 037FBEBC
P2_Entry_037FBEBE:
	ldr r2,[r0,#0x60]	; 037FBEBE
	str r1,[r2,#0x10]	; 037FBEC0
P2_Entry_037FBEC2:
	str r3,[r1,#0xc]	; 037FBEC2
	mov r2,#0x0	; 037FBEC4
	str r2,[r1,#0x10]	; 037FBEC6
	str r1,[r0,#0x64]	; 037FBEC8
	bx lr	; 037FBECA

; ===== function loc_037FBECC =====
loc_037FBECC:
	push {r4,r5,lr}	; 037FBECC
	sub sp,#0x4	; 037FBECE
	add r5,r0,#0x0	; 037FBED0
	mov r4,#0x0	; 037FBED2
	b loc_037FBEE4	; 037FBED4
loc_037FBED6:
	add r0,r5,#0x0	; 037FBED6
	bl loc_037FBE80	; 037FBED8
	str r4,[r0,#0x8]	; 037FBEDC
	str r4,[r0,#0x4]	; 037FBEDE
	bl loc_037FBA10	; 037FBEE0
loc_037FBEE4:
	ldr r0,[r5,#0x60]	; 037FBEE4
	cmp r0,#0x0	; 037FBEE6
	bne loc_037FBED6	; 037FBEE8
	add sp,#0x4	; 037FBEEA
	pop {r4,r5}	; 037FBEEC
	pop {r3}	; 037FBEEE
	bx r3	; 037FBEF0
	.byte 0x00, 0x00	; 037FBEF2
P2_Entry_037FBEF4:
	push {r4,r5,lr}	; 037FBEF4
	sub sp,#0x4	; 037FBEF6
	add r5,r0,#0x0	; 037FBEF8
	bl loc_037FB7EC	; 037FBEFA
	add r4,r0,#0x0	; 037FBEFE
	ldr r0,[pool_037FBF38]	; 037FBF00
	ldr r0,[r0,#0x8]	; 037FBF02
	ldr r1,[r5,#0x4]	; 037FBF04
	cmp r1,r0	; 037FBF06
	bne P2_Entry_037FBF2A	; 037FBF08
	add r2,r5,#0x0	; 037FBF0A
	add r2,#0x8	; 037FBF0C
	ldr r1,[r2,#0x0]	; 037FBF0E
	sub r1,r1,#0x1	; 037FBF10
	str r1,[r2,#0x0]	; 037FBF12
	ldr r1,[r5,#0x8]	; 037FBF14
	cmp r1,#0x0	; 037FBF16
	bne P2_Entry_037FBF2A	; 037FBF18
	add r1,r5,#0x0	; 037FBF1A
	bl P2_Entry_037FBE98	; 037FBF1C
	mov r0,#0x0	; 037FBF20
	str r0,[r5,#0x4]	; 037FBF22
	add r0,r5,#0x0	; 037FBF24
	bl loc_037FBA10	; 037FBF26
P2_Entry_037FBF2A:
	add r0,r4,#0x0	; 037FBF2A
	bl loc_037FB810	; 037FBF2C
	add sp,#0x4	; 037FBF30
	pop {r4,r5}	; 037FBF32
	pop {r3}	; 037FBF34
	bx r3	; 037FBF36
pool_037FBF38:
	.word P2_BssStart + 0x544	; 037FBF38
P2_Entry_037FBF3C:
	push {r4,r5,r6,r7,lr}	; 037FBF3C
	sub sp,#0x4	; 037FBF3E
	add r5,r0,#0x0	; 037FBF40
	bl loc_037FB7EC	; 037FBF42
	add r6,r0,#0x0	; 037FBF46
	ldr r0,[pool_037FBF94]	; 037FBF48
	ldr r4,[r0,#0x8]	; 037FBF4A
	mov r7,#0x0	; 037FBF4C
P2_Entry_037FBF4E:
	ldr r0,[r5,#0x4]	; 037FBF4E
	cmp r0,#0x0	; 037FBF50
	bne P2_Entry_037FBF6A	; 037FBF52
	str r4,[r5,#0x4]	; 037FBF54
	add r1,r5,#0x0	; 037FBF56
	add r1,#0x8	; 037FBF58
	ldr r0,[r1,#0x0]	; 037FBF5A
	add r0,r0,#0x1	; 037FBF5C
	str r0,[r1,#0x0]	; 037FBF5E
	add r0,r4,#0x0	; 037FBF60
	add r1,r5,#0x0	; 037FBF62
	bl P2_Entry_037FBEB4	; 037FBF64
	b P2_Entry_037FBF84	; 037FBF68
P2_Entry_037FBF6A:
	cmp r0,r4	; 037FBF6A
	bne P2_Entry_037FBF78	; 037FBF6C
	add r5,#0x8	; 037FBF6E
	ldr r0,[r5,#0x0]	; 037FBF70
	add r0,r0,#0x1	; 037FBF72
	str r0,[r5,#0x0]	; 037FBF74
	b P2_Entry_037FBF84	; 037FBF76
P2_Entry_037FBF78:
	str r5,[r4,#0x5c]	; 037FBF78
	add r0,r5,#0x0	; 037FBF7A
	bl loc_037FBA58	; 037FBF7C
	str r7,[r4,#0x5c]	; 037FBF80
	b P2_Entry_037FBF4E	; 037FBF82
P2_Entry_037FBF84:
	add r0,r6,#0x0	; 037FBF84
	bl loc_037FB810	; 037FBF86
	add sp,#0x4	; 037FBF8A
	pop {r4,r5,r6,r7}	; 037FBF8C
	pop {r3}	; 037FBF8E
	bx r3	; 037FBF90
	.byte 0xC0, 0x46	; 037FBF92
pool_037FBF94:
	.word P2_BssStart + 0x544	; 037FBF94
P2_Entry_037FBF98:
	mov r1,#0x0	; 037FBF98
	strh r1,[r0,#0x0]	; 037FBF9A
	str r1,[r0,#0x4]	; 037FBF9C
	str r1,[r0,#0x8]	; 037FBF9E
	bx lr	; 037FBFA0
	.byte 0x00, 0x00	; 037FBFA2

; ===== function loc_037FBFA4 =====
loc_037FBFA4:
	push {lr}	; 037FBFA4
	sub sp,#0x4	; 037FBFA6
	bl loc_037FC088	; 037FBFA8
	bl loc_037FF938	; 037FBFAC
	bl loc_037FB8CC	; 037FBFB0
	bl loc_037FB698	; 037FBFB4
	bl loc_037FC484	; 037FBFB8
	bl loc_037FC78C	; 037FBFBC
	bl loc_037FBB88	; 037FBFC0
	bl loc_03802220	; 037FBFC4
	add sp,#0x4	; 037FBFC8
	pop {r3}	; 037FBFCA
	bx r3	; 037FBFCC
	.byte 0x00, 0x00	; 037FBFD0

; ===== function loc_037FBFD0 =====
loc_037FBFD0:
	lsl r2,r0,#0x2	; 037FBFD0
	ldr r0,[pool_037FBFD8]	; 037FBFD2
	str r1,[r2,r0]	; 037FBFD4
	bx lr	; 037FBFD6
pool_037FBFD8:
loc_037FBFD8:
	.word 0x027FFDA0	; 037FBFD8

; ===== function loc_037FBFDC =====
loc_037FBFDC:
	lsl r2,r0,#0x2	; 037FBFDC
	ldr r0,[pool_037FBFE4]	; 037FBFDE
	str r1,[r2,r0]	; 037FBFE0
	bx lr	; 037FBFE2
pool_037FBFE4:
loc_037FBFE4:
	.word 0x027FFDC4	; 037FBFE4

; ===== function loc_037FBFE8 =====
loc_037FBFE8:
	cmp r0,#0x1	; 037FBFE8
	beq loc_037FBFF6	; 037FBFEA
	cmp r0,#0x7	; 037FBFEC
	beq loc_037FBFFA	; 037FBFEE
	cmp r0,#0x8	; 037FBFF0
	beq loc_037FC006	; 037FBFF2
	b loc_037FC012	; 037FBFF4
loc_037FBFF6:
	ldr r0,[pool_037FC018]	; 037FBFF6
	bx lr	; 037FBFF8
loc_037FBFFA:
	ldr r0,[pool_037FC01C]	; 037FBFFA
	ldr r1,[pool_037FC020]	; 037FBFFC
	cmp r0,r1	; 037FBFFE
	bls loc_037FC014	; 037FC000
	add r0,r1,#0x0	; 037FC002
	bx lr	; 037FC004
loc_037FC006:
	ldr r0,[pool_037FC020]	; 037FC006
	ldr r1,[pool_037FC01C]	; 037FC008
	cmp r1,r0	; 037FC00A
	bls loc_037FC014	; 037FC00C
	add r0,r1,#0x0	; 037FC00E
	bx lr	; 037FC010
loc_037FC012:
	mov r0,#0x0	; 037FC012
loc_037FC014:
	bx lr	; 037FC014
	.byte 0xC0, 0x46	; 037FC018
pool_037FC018:
loc_037FC018:
	.word 0x027C0000	; 037FC018
pool_037FC01C:
loc_037FC01C:
	.word P2_WramCopy0RuntimeEnd	; 037FC01C
pool_037FC020:
loc_037FC020:
	.word Arm7WramBase	; 037FC020

; ===== function loc_037FC024 =====
loc_037FC024:
	cmp r0,#0x1	; 037FC024
	beq loc_037FC032	; 037FC026
	cmp r0,#0x7	; 037FC028
	beq loc_037FC036	; 037FC02A
	cmp r0,#0x8	; 037FC02C
	beq loc_037FC03A	; 037FC02E
	b loc_037FC058	; 037FC030
loc_037FC032:
	ldr r0,[pool_037FC05C]	; 037FC032
	bx lr	; 037FC034
loc_037FC036:
	ldr r0,[pool_037FC060]	; 037FC036
	bx lr	; 037FC038
loc_037FC03A:
	ldr r1,[pool_037FC064]	; 037FC03A
	ldr r0,[pool_037FC068]	; 037FC03C
	sub r0,r0,r1	; 037FC03E
	ldr r1,[pool_037FC06C]	; 037FC040
	cmp r1,#0x0	; 037FC042
	bne loc_037FC04A	; 037FC044
	ldr r0,[pool_037FC060]	; 037FC046
	bx lr	; 037FC048
loc_037FC04A:
	cmp r1,#0x0	; 037FC04A
	bge loc_037FC054	; 037FC04C
	ldr r0,[pool_037FC060]	; 037FC04E
	sub r0,r0,r1	; 037FC050
	bx lr	; 037FC052
loc_037FC054:
	sub r0,r0,r1	; 037FC054
	bx lr	; 037FC056
loc_037FC058:
	mov r0,#0x0	; 037FC058
	bx lr	; 037FC05A
pool_037FC05C:
loc_037FC05C:
	.word 0x027FF000	; 037FC05C
pool_037FC060:
loc_037FC060:
	.word Arm7WramBase	; 037FC060
pool_037FC064:
loc_037FC064:
	.word 0x00000200	; 037FC064
pool_037FC068:
loc_037FC068:
	.word 0x0380FF80	; 037FC068
pool_037FC06C:
loc_037FC06C:
	.word 0x00000400	; 037FC06C
P2_Entry_037FC070:
	lsl r1,r0,#0x2	; 037FC070
	ldr r0,[pool_037FC078]	; 037FC072
	ldr r0,[r1,r0]	; 037FC074
	bx lr	; 037FC076
pool_037FC078:
	.word 0x027FFDA0	; 037FC078
P2_Entry_037FC07C:
	lsl r1,r0,#0x2	; 037FC07C
	ldr r0,[pool_037FC084]	; 037FC07E
	ldr r0,[r1,r0]	; 037FC080
	bx lr	; 037FC082
pool_037FC084:
	.word 0x027FFDC4	; 037FC084

; ===== function loc_037FC088 =====
loc_037FC088:
	push {lr}	; 037FC088
	sub sp,#0x4	; 037FC08A
	ldr r1,[pool_037FC0F0]	; 037FC08C
	ldr r0,[r1,#0x0]	; 037FC08E
	cmp r0,#0x0	; 037FC090
	bne loc_037FC0EA	; 037FC092
	mov r0,#0x1	; 037FC094
	str r0,[r1,#0x0]	; 037FC096
	bl loc_037FC024	; 037FC098
	add r1,r0,#0x0	; 037FC09C
	mov r0,#0x1	; 037FC09E
	bl loc_037FBFDC	; 037FC0A0
	mov r0,#0x1	; 037FC0A4
	bl loc_037FBFE8	; 037FC0A6
	add r1,r0,#0x0	; 037FC0AA
	mov r0,#0x1	; 037FC0AC
	bl loc_037FBFD0	; 037FC0AE
	mov r0,#0x7	; 037FC0B2
	bl loc_037FC024	; 037FC0B4
	add r1,r0,#0x0	; 037FC0B8
	mov r0,#0x7	; 037FC0BA
	bl loc_037FBFDC	; 037FC0BC
	mov r0,#0x7	; 037FC0C0
	bl loc_037FBFE8	; 037FC0C2
	add r1,r0,#0x0	; 037FC0C6
	mov r0,#0x7	; 037FC0C8
	bl loc_037FBFD0	; 037FC0CA
	mov r0,#0x8	; 037FC0CE
	bl loc_037FC024	; 037FC0D0
	add r1,r0,#0x0	; 037FC0D4
	mov r0,#0x8	; 037FC0D6
	bl loc_037FBFDC	; 037FC0D8
	mov r0,#0x8	; 037FC0DC
	bl loc_037FBFE8	; 037FC0DE
	add r1,r0,#0x0	; 037FC0E2
	mov r0,#0x8	; 037FC0E4
	bl loc_037FBFD0	; 037FC0E6
loc_037FC0EA:
	add sp,#0x4	; 037FC0EA
	pop {r3}	; 037FC0EC
	bx r3	; 037FC0EE
pool_037FC0F0:
loc_037FC0F0:
	.word P2_BssStart + 0x610	; 037FC0F0

; ===== function loc_037FC0F4 =====
P2_Entry_037FC0F4:
	push {r4,r5,r6,r7,lr}	; 037FC0F4
	sub sp,#0xc	; 037FC0F6
	add r4,r0,#0x0	; 037FC0F8
	add r5,r1,#0x0	; 037FC0FA
	add r6,r2,#0x0	; 037FC0FC
	bl loc_037FB7EC	; 037FC0FE
	str r0,[sp,#0x4]	; 037FC102
	lsl r1,r4,#0x2	; 037FC104
	ldr r0,[pool_037FC164]	; 037FC106
	ldr r1,[r0,r1]	; 037FC108
	add r5,#0x1f	; 037FC10A
	mov r0,#0x1f	; 037FC10C
	bic r5,r0	; 037FC10E
	bic r6,r0	; 037FC110
	mov r4,#0x0	; 037FC112
	ldr r7,[r1,#0x4]	; 037FC114
	b loc_037FC14C	; 037FC116
loc_037FC118:
	ldr r0,[r1,#0x10]	; 037FC118
	add r3,r4,#0x0	; 037FC11A
	str r3,[sp,#0x0]	; 037FC11C
	mov r2,#0xc	; 037FC11E
	mul r3,r2	; 037FC120
	str r3,[sp,#0x0]	; 037FC122
	add r3,r0,r3	; 037FC124
	ldr r2,[sp,#0x0]	; 037FC126
	ldr r0,[r0,r2]	; 037FC128
	cmp r0,#0x0	; 037FC12A
	bge loc_037FC14A	; 037FC12C
	sub r0,r6,r5	; 037FC12E
	str r0,[r3,#0x0]	; 037FC130
	mov r1,#0x0	; 037FC132
	str r1,[r5,#0x0]	; 037FC134
	str r1,[r5,#0x4]	; 037FC136
	ldr r0,[r3,#0x0]	; 037FC138
	str r0,[r5,#0x8]	; 037FC13A
	str r5,[r3,#0x4]	; 037FC13C
	str r1,[r3,#0x8]	; 037FC13E
	ldr r0,[sp,#0x4]	; 037FC140
	bl loc_037FB810	; 037FC142
	add r0,r4,#0x0	; 037FC146
	b loc_037FC15A	; 037FC148
loc_037FC14A:
	add r4,r4,#0x1	; 037FC14A
loc_037FC14C:
	cmp r4,r7	; 037FC14C
	blt loc_037FC118	; 037FC14E
	ldr r0,[sp,#0x4]	; 037FC150
	bl loc_037FB810	; 037FC152
	mov r0,#0x0	; 037FC156
	mvn r0,r0	; 037FC158
loc_037FC15A:
	add sp,#0xc	; 037FC15A
	pop {r4,r5,r6,r7}	; 037FC15C
	pop {r3}	; 037FC15E
	bx r3	; 037FC160
	.byte 0xC0, 0x46	; 037FC164
pool_037FC164:
loc_037FC164:
	.word P2_BssStart + 0x614	; 037FC164
P2_Entry_037FC168:
	push {r4,r5,r6,r7,lr}	; 037FC168
	sub sp,#0xc	; 037FC16A
	add r6,r0,#0x0	; 037FC16C
	add r5,r1,#0x0	; 037FC16E
	str r2,[sp,#0x8]	; 037FC170
	add r4,r3,#0x0	; 037FC172
	bl loc_037FB7EC	; 037FC174
	str r0,[sp,#0x0]	; 037FC178
	lsl r1,r6,#0x2	; 037FC17A
	ldr r0,[pool_037FC1E0]	; 037FC17C
	str r5,[r0,r1]	; 037FC17E
	add r3,r4,#0x0	; 037FC180
	mov r0,#0xc	; 037FC182
	mul r3,r0	; 037FC184
	add r0,r5,#0x0	; 037FC186
	add r0,#0x14	; 037FC188
	str r0,[r5,#0x10]	; 037FC18A
	str r4,[r5,#0x4]	; 037FC18C
	mov r2,#0x0	; 037FC18E
	mvn r0,r2	; 037FC190
	add r7,r2,#0x0	; 037FC192
	b P2_Entry_037FC1B0	; 037FC194
P2_Entry_037FC196:
	ldr r1,[r5,#0x10]	; 037FC196
	add r6,r2,#0x0	; 037FC198
	str r6,[sp,#0x4]	; 037FC19A
	mov r4,#0xc	; 037FC19C
	mul r6,r4	; 037FC19E
	str r6,[sp,#0x4]	; 037FC1A0
	add r6,r1,r6	; 037FC1A2
	ldr r4,[sp,#0x4]	; 037FC1A4
	str r0,[r1,r4]	; 037FC1A6
	str r7,[r6,#0x8]	; 037FC1A8
	ldr r1,[r6,#0x8]	; 037FC1AA
	str r1,[r6,#0x4]	; 037FC1AC
	add r2,r2,#0x1	; 037FC1AE
P2_Entry_037FC1B0:
	ldr r1,[r5,#0x4]	; 037FC1B0
	cmp r2,r1	; 037FC1B2
	blt P2_Entry_037FC196	; 037FC1B4
	mov r0,#0x0	; 037FC1B6
	mvn r0,r0	; 037FC1B8
	str r0,[r5,#0x0]	; 037FC1BA
	ldr r0,[r5,#0x10]	; 037FC1BC
	add r0,r0,r3	; 037FC1BE
	add r0,#0x1f	; 037FC1C0
	mov r1,#0x1f	; 037FC1C2
	bic r0,r1	; 037FC1C4
	str r0,[r5,#0x8]	; 037FC1C6
	ldr r0,[sp,#0x8]	; 037FC1C8
	bic r0,r1	; 037FC1CA
	str r0,[sp,#0x8]	; 037FC1CC
	str r0,[r5,#0xc]	; 037FC1CE
	ldr r0,[sp,#0x0]	; 037FC1D0
	bl loc_037FB810	; 037FC1D2
	ldr r0,[r5,#0x8]	; 037FC1D6
	add sp,#0xc	; 037FC1D8
	pop {r4,r5,r6,r7}	; 037FC1DA
	pop {r3}	; 037FC1DC
	bx r3	; 037FC1DE
pool_037FC1E0:
	.word P2_BssStart + 0x614	; 037FC1E0
P2_Entry_037FC1E4:
	push {r4,r5,lr}	; 037FC1E4
	sub sp,#0x4	; 037FC1E6
	add r5,r0,#0x0	; 037FC1E8
	add r4,r1,#0x0	; 037FC1EA
	bl loc_037FB7EC	; 037FC1EC
	lsl r2,r5,#0x2	; 037FC1F0
	ldr r1,[pool_037FC208]	; 037FC1F2
	ldr r1,[r1,r2]	; 037FC1F4
	ldr r5,[r1,#0x0]	; 037FC1F6
	str r4,[r1,#0x0]	; 037FC1F8
	bl loc_037FB810	; 037FC1FA
	add r0,r5,#0x0	; 037FC1FE
	add sp,#0x4	; 037FC200
	pop {r4,r5}	; 037FC202
	pop {r3}	; 037FC204
	bx r3	; 037FC206
pool_037FC208:
	.word P2_BssStart + 0x614	; 037FC208
P2_Entry_037FC20C:
	push {r4,r5,r6,r7,lr}	; 037FC20C
	sub sp,#0x4	; 037FC20E
	add r6,r0,#0x0	; 037FC210
	add r5,r1,#0x0	; 037FC212
	add r4,r2,#0x0	; 037FC214
	bl loc_037FB7EC	; 037FC216
	add r7,r0,#0x0	; 037FC21A
	lsl r1,r6,#0x2	; 037FC21C
	ldr r0,[pool_037FC254]	; 037FC21E
	ldr r0,[r0,r1]	; 037FC220
	cmp r5,#0x0	; 037FC222
	bge P2_Entry_037FC228	; 037FC224
	ldr r5,[r0,#0x0]	; 037FC226
P2_Entry_037FC228:
	sub r4,#0x20	; 037FC228
	ldr r1,[r0,#0x10]	; 037FC22A
	mov r0,#0xc	; 037FC22C
	mul r5,r0	; 037FC22E
	add r5,r1,r5	; 037FC230
	ldr r0,[r5,#0x8]	; 037FC232
	add r1,r4,#0x0	; 037FC234
	bl P2_Entry_037FC36C	; 037FC236
	str r0,[r5,#0x8]	; 037FC23A
	ldr r0,[r5,#0x4]	; 037FC23C
	add r1,r4,#0x0	; 037FC23E
	bl P2_Entry_037FC304	; 037FC240
	str r0,[r5,#0x4]	; 037FC244
	add r0,r7,#0x0	; 037FC246
	bl loc_037FB810	; 037FC248
	add sp,#0x4	; 037FC24C
	pop {r4,r5,r6,r7}	; 037FC24E
	pop {r3}	; 037FC250
	bx r3	; 037FC252
pool_037FC254:
	.word P2_BssStart + 0x614	; 037FC254
P2_Entry_037FC258:
	push {r4,r5,r6,r7,lr}	; 037FC258
	sub sp,#0x4	; 037FC25A
	add r6,r0,#0x0	; 037FC25C
	add r4,r1,#0x0	; 037FC25E
	add r5,r2,#0x0	; 037FC260
	bl loc_037FB7EC	; 037FC262
	add r7,r0,#0x0	; 037FC266
	lsl r2,r6,#0x2	; 037FC268
	ldr r1,[pool_037FC300]	; 037FC26A
	ldr r1,[r1,r2]	; 037FC26C
	cmp r1,#0x0	; 037FC26E
	bne P2_Entry_037FC27A	; 037FC270
	bl loc_037FB810	; 037FC272
	mov r0,#0x0	; 037FC276
	b P2_Entry_037FC2F8	; 037FC278
P2_Entry_037FC27A:
	cmp r4,#0x0	; 037FC27A
	bge P2_Entry_037FC280	; 037FC27C
	ldr r4,[r1,#0x0]	; 037FC27E
P2_Entry_037FC280:
	ldr r1,[r1,#0x10]	; 037FC280
	mov r0,#0xc	; 037FC282
	mul r4,r0	; 037FC284
	add r6,r1,r4	; 037FC286
	add r5,#0x20	; 037FC288
	add r5,#0x1f	; 037FC28A
	mov r0,#0x1f	; 037FC28C
	bic r5,r0	; 037FC28E
	ldr r0,[r6,#0x4]	; 037FC290
	add r4,r0,#0x0	; 037FC292
	b P2_Entry_037FC29E	; 037FC294
P2_Entry_037FC296:
	ldr r1,[r4,#0x8]	; 037FC296
	cmp r5,r1	; 037FC298
	ble P2_Entry_037FC2A2	; 037FC29A
	ldr r4,[r4,#0x4]	; 037FC29C
P2_Entry_037FC29E:
	cmp r4,#0x0	; 037FC29E
	bne P2_Entry_037FC296	; 037FC2A0
P2_Entry_037FC2A2:
	cmp r4,#0x0	; 037FC2A2
	bne P2_Entry_037FC2B0	; 037FC2A4
	add r0,r7,#0x0	; 037FC2A6
	bl loc_037FB810	; 037FC2A8
	mov r0,#0x0	; 037FC2AC
	b P2_Entry_037FC2F8	; 037FC2AE
P2_Entry_037FC2B0:
	ldr r1,[r4,#0x8]	; 037FC2B0
	sub r1,r1,r5	; 037FC2B2
	cmp r1,#0x40	; 037FC2B4
	bcs P2_Entry_037FC2C2	; 037FC2B6
	add r1,r4,#0x0	; 037FC2B8
	bl P2_Entry_037FC36C	; 037FC2BA
	str r0,[r6,#0x4]	; 037FC2BE
	b P2_Entry_037FC2E4	; 037FC2C0
P2_Entry_037FC2C2:
	str r5,[r4,#0x8]	; 037FC2C2
	add r0,r4,r5	; 037FC2C4
	str r1,[r0,#0x8]	; 037FC2C6
	ldr r1,[r4,#0x0]	; 037FC2C8
	str r1,[r4,r5]	; 037FC2CA
	ldr r1,[r4,#0x4]	; 037FC2CC
	str r1,[r0,#0x4]	; 037FC2CE
	ldr r1,[r0,#0x4]	; 037FC2D0
	cmp r1,#0x0	; 037FC2D2
	beq P2_Entry_037FC2D8	; 037FC2D4
	str r0,[r1,#0x0]	; 037FC2D6
P2_Entry_037FC2D8:
	ldr r1,[r0,#0x0]	; 037FC2D8
	cmp r1,#0x0	; 037FC2DA
	beq P2_Entry_037FC2E2	; 037FC2DC
	str r0,[r1,#0x4]	; 037FC2DE
	b P2_Entry_037FC2E4	; 037FC2E0
P2_Entry_037FC2E2:
	str r0,[r6,#0x4]	; 037FC2E2
P2_Entry_037FC2E4:
	ldr r0,[r6,#0x8]	; 037FC2E4
	add r1,r4,#0x0	; 037FC2E6
	bl P2_Entry_037FC388	; 037FC2E8
	str r0,[r6,#0x8]	; 037FC2EC
	add r0,r7,#0x0	; 037FC2EE
	bl loc_037FB810	; 037FC2F0
	add r4,#0x20	; 037FC2F4
	add r0,r4,#0x0	; 037FC2F6
P2_Entry_037FC2F8:
	add sp,#0x4	; 037FC2F8
	pop {r4,r5,r6,r7}	; 037FC2FA
	pop {r3}	; 037FC2FC
	bx r3	; 037FC2FE
pool_037FC300:
	.word P2_BssStart + 0x614	; 037FC300
P2_Entry_037FC304:
	push {r4,r5,r6,lr}	; 037FC304
	add r2,r0,#0x0	; 037FC306
	mov r3,#0x0	; 037FC308
	b P2_Entry_037FC314	; 037FC30A
P2_Entry_037FC30C:
	cmp r1,r2	; 037FC30C
	bls P2_Entry_037FC318	; 037FC30E
	add r3,r2,#0x0	; 037FC310
	ldr r2,[r2,#0x4]	; 037FC312
P2_Entry_037FC314:
	cmp r2,#0x0	; 037FC314
	bne P2_Entry_037FC30C	; 037FC316
P2_Entry_037FC318:
	str r2,[r1,#0x4]	; 037FC318
	str r3,[r1,#0x0]	; 037FC31A
	cmp r2,#0x0	; 037FC31C
	beq P2_Entry_037FC340	; 037FC31E
	str r1,[r2,#0x0]	; 037FC320
	ldr r4,[r1,#0x8]	; 037FC322
	add r4,r1,r4	; 037FC324
	cmp r4,r2	; 037FC326
	bne P2_Entry_037FC340	; 037FC328
	add r6,r1,#0x0	; 037FC32A
	add r6,#0x8	; 037FC32C
	ldr r5,[r6,#0x0]	; 037FC32E
	ldr r4,[r2,#0x8]	; 037FC330
	add r4,r5,r4	; 037FC332
	str r4,[r6,#0x0]	; 037FC334
	ldr r2,[r2,#0x4]	; 037FC336
	str r2,[r1,#0x4]	; 037FC338
	cmp r2,#0x0	; 037FC33A
	beq P2_Entry_037FC340	; 037FC33C
	str r1,[r2,#0x0]	; 037FC33E
P2_Entry_037FC340:
	cmp r3,#0x0	; 037FC340
	beq P2_Entry_037FC364	; 037FC342
	str r1,[r3,#0x4]	; 037FC344
	ldr r4,[r3,#0x8]	; 037FC346
	add r4,r3,r4	; 037FC348
	cmp r4,r1	; 037FC34A
	bne P2_Entry_037FC366	; 037FC34C
	add r5,r3,#0x0	; 037FC34E
	add r5,#0x8	; 037FC350
	ldr r4,[r5,#0x0]	; 037FC352
	ldr r1,[r1,#0x8]	; 037FC354
	add r1,r4,r1	; 037FC356
	str r1,[r5,#0x0]	; 037FC358
	str r2,[r3,#0x4]	; 037FC35A
	cmp r2,#0x0	; 037FC35C
	beq P2_Entry_037FC366	; 037FC35E
	str r3,[r2,#0x0]	; 037FC360
	b P2_Entry_037FC366	; 037FC362
P2_Entry_037FC364:
	add r0,r1,#0x0	; 037FC364
P2_Entry_037FC366:
	pop {r4,r5,r6}	; 037FC366
	pop {r3}	; 037FC368
	bx r3	; 037FC36A
P2_Entry_037FC36C:
	ldr r3,[r1,#0x4]	; 037FC36C
	cmp r3,#0x0	; 037FC36E
	beq P2_Entry_037FC376	; 037FC370
	ldr r2,[r1,#0x0]	; 037FC372
	str r2,[r3,#0x0]	; 037FC374
P2_Entry_037FC376:
	ldr r2,[r1,#0x0]	; 037FC376
	cmp r2,#0x0	; 037FC378
	bne P2_Entry_037FC380	; 037FC37A
	ldr r0,[r1,#0x4]	; 037FC37C
	bx lr	; 037FC37E
P2_Entry_037FC380:
	ldr r1,[r1,#0x4]	; 037FC380
	str r1,[r2,#0x4]	; 037FC382
	bx lr	; 037FC384
	.byte 0x00, 0x00	; 037FC386
P2_Entry_037FC388:
	str r0,[r1,#0x4]	; 037FC388
	mov r2,#0x0	; 037FC38A
	str r2,[r1,#0x0]	; 037FC38C
	cmp r0,#0x0	; 037FC38E
	beq P2_Entry_037FC394	; 037FC390
	str r1,[r0,#0x0]	; 037FC392
P2_Entry_037FC394:
	add r0,r1,#0x0	; 037FC394
	bx lr	; 037FC396

; ===== function loc_037FC398 =====
loc_037FC398:
	ldr r1,[pool_037FC3A8]	; 037FC398
	ldrh r3,[r1,#0x0]	; 037FC39A
	mov r2,#0x1	; 037FC39C
	lsl r2,r0	; 037FC39E
	orr r3,r2	; 037FC3A0
	strh r3,[r1,#0x0]	; 037FC3A2
	bx lr	; 037FC3A4
	.byte 0xC0, 0x46	; 037FC3A8
pool_037FC3A8:
loc_037FC3A8:
	.word P2_BssStart + 0x638	; 037FC3A8

; ===== function loc_037FC3AC =====
loc_037FC3AC:
	push {r4,r5,lr}	; 037FC3AC
	sub sp,#0xc	; 037FC3AE
	bl loc_037FB7EC	; 037FC3B0
	ldr r1,[pool_037FC414]	; 037FC3B4
	ldrh r1,[r1,#0x0]	; 037FC3B6
	add r3,sp,#0x0	; 037FC3B8
	strh r1,[r3,#0x0]	; 037FC3BA
	ldr r1,[pool_037FC418]	; 037FC3BC
	ldr r5,[r1,#0x0]	; 037FC3BE
	ldr r4,[r1,#0x4]	; 037FC3C0
	ldr r1,[pool_037FC41C]	; 037FC3C2
	mov r2,#0x0	; 037FC3C4
	and r4,r1	; 037FC3C6
	bic r5,r2	; 037FC3C8
	str r5,[sp,#0x4]	; 037FC3CA
	str r4,[sp,#0x8]	; 037FC3CC
	ldr r1,[pool_037FC420]	; 037FC3CE
	ldr r4,[r1,#0x0]	; 037FC3D0
	mov r1,#0x8	; 037FC3D2
	and r4,r1	; 037FC3D4
	cmp r4,#0x0	; 037FC3D6
	beq loc_037FC3F2	; 037FC3D8
	ldrh r3,[r3,#0x0]	; 037FC3DA
	ldr r1,[pool_037FC424]	; 037FC3DC
	and r3,r1	; 037FC3DE
	cmp r3,#0x0	; 037FC3E0
	bne loc_037FC3F2	; 037FC3E2
	ldr r3,[sp,#0x4]	; 037FC3E4
	ldr r4,[sp,#0x8]	; 037FC3E6
	mov r1,#0x1	; 037FC3E8
	add r1,r3,r1	; 037FC3EA
	adc r4,r2	; 037FC3EC
	str r1,[sp,#0x4]	; 037FC3EE
	str r4,[sp,#0x8]	; 037FC3F0
loc_037FC3F2:
	bl loc_037FB810	; 037FC3F2
	ldr r2,[sp,#0x4]	; 037FC3F6
	ldr r1,[sp,#0x8]	; 037FC3F8
	lsr r0,r2,#0x10	; 037FC3FA
	lsl r1,r1,#0x10	; 037FC3FC
	orr r1,r0	; 037FC3FE
	lsl r0,r2,#0x10	; 037FC400
	add r2,sp,#0x0	; 037FC402
	ldrh r3,[r2,#0x0]	; 037FC404
	asr r2,r3,#0x1f	; 037FC406
	orr r1,r2	; 037FC408
	orr r0,r3	; 037FC40A
	add sp,#0xc	; 037FC40C
	pop {r4,r5}	; 037FC40E
	pop {r3}	; 037FC410
	bx r3	; 037FC412
pool_037FC414:
loc_037FC414:
	.word TIMER0_DATA	; 037FC414
pool_037FC418:
loc_037FC418:
	.word P2_BssStart + 0x644	; 037FC418
pool_037FC41C:
loc_037FC41C:
	.word 0x0000FFFF	; 037FC41C
pool_037FC420:
loc_037FC420:
	.word REG_IF	; 037FC420
pool_037FC424:
loc_037FC424:
	.word 0x00008000	; 037FC424

; ===== function loc_037FC428 =====
P2_IrqHandler_037FC428:
	push {r4,lr}	; 037FC428
	ldr r1,[pool_037FC464]	; 037FC42A
	ldr r2,[r1,#0x0]	; 037FC42C
	ldr r4,[r1,#0x4]	; 037FC42E
	mov r3,#0x0	; 037FC430
	mov r0,#0x1	; 037FC432
	add r0,r2,r0	; 037FC434
	adc r4,r3	; 037FC436
	str r0,[r1,#0x0]	; 037FC438
	str r4,[r1,#0x4]	; 037FC43A
	ldr r0,[pool_037FC468]	; 037FC43C
	ldr r1,[r0,#0x0]	; 037FC43E
	cmp r1,#0x0	; 037FC440
	beq loc_037FC452	; 037FC442
	ldr r2,[pool_037FC46C]	; 037FC444
	strh r3,[r2,#0x0]	; 037FC446
	ldr r1,[pool_037FC470]	; 037FC448
	strh r3,[r1,#0x0]	; 037FC44A
	mov r1,#0xc1	; 037FC44C
	strh r1,[r2,#0x0]	; 037FC44E
	str r3,[r0,#0x0]	; 037FC450
loc_037FC452:
	mov r0,#0x0	; 037FC452
	ldr r1,[pool_037FC474]	; 037FC454
	add r2,r0,#0x0	; 037FC456
	bl loc_037FB5EC	; 037FC458
	pop {r4}	; 037FC45C
	pop {r3}	; 037FC45E
	bx r3	; 037FC460
	.byte 0xC0, 0x46	; 037FC464
pool_037FC464:
loc_037FC464:
	.word P2_BssStart + 0x644	; 037FC464
pool_037FC468:
loc_037FC468:
	.word P2_BssStart + 0x640	; 037FC468
pool_037FC46C:
loc_037FC46C:
	.word TIMER0_CR	; 037FC46C
pool_037FC470:
loc_037FC470:
	.word TIMER0_DATA	; 037FC470
pool_037FC474:
loc_037FC474:
	.word P2_IrqHandler_037FC428 + 1	; 037FC474

; ===== function loc_037FC478 =====
loc_037FC478:
	ldr r0,[pool_037FC480]	; 037FC478
	ldrh r0,[r0,#0x0]	; 037FC47A
	bx lr	; 037FC47C
	.byte 0xC0, 0x46	; 037FC480
pool_037FC480:
loc_037FC480:
	.word P2_BssStart + 0x63C	; 037FC480

; ===== function loc_037FC484 =====
loc_037FC484:
	push {lr}	; 037FC484
	sub sp,#0x4	; 037FC486
	ldr r0,[pool_037FC4C8]	; 037FC488
	ldrh r1,[r0,#0x0]	; 037FC48A
	cmp r1,#0x0	; 037FC48C
	bne loc_037FC4C2	; 037FC48E
	mov r1,#0x1	; 037FC490
	strh r1,[r0,#0x0]	; 037FC492
	mov r0,#0x0	; 037FC494
	bl loc_037FC398	; 037FC496
	mov r2,#0x0	; 037FC49A
	ldr r0,[pool_037FC4CC]	; 037FC49C
	str r2,[r0,#0x0]	; 037FC49E
	str r2,[r0,#0x4]	; 037FC4A0
	ldr r1,[pool_037FC4D0]	; 037FC4A2
	strh r2,[r1,#0x0]	; 037FC4A4
	ldr r0,[pool_037FC4D4]	; 037FC4A6
	strh r2,[r0,#0x0]	; 037FC4A8
	mov r0,#0xc1	; 037FC4AA
	strh r0,[r1,#0x0]	; 037FC4AC
	mov r0,#0x8	; 037FC4AE
	ldr r1,[pool_037FC4D8]	; 037FC4B0
	bl loc_037FB620	; 037FC4B2
	mov r0,#0x8	; 037FC4B6
	bl loc_037FB59C	; 037FC4B8
	mov r1,#0x0	; 037FC4BC
	ldr r0,[pool_037FC4DC]	; 037FC4BE
	str r1,[r0,#0x0]	; 037FC4C0
loc_037FC4C2:
	add sp,#0x4	; 037FC4C2
	pop {r3}	; 037FC4C4
	bx r3	; 037FC4C6
pool_037FC4C8:
loc_037FC4C8:
	.word P2_BssStart + 0x63C	; 037FC4C8
pool_037FC4CC:
loc_037FC4CC:
	.word P2_BssStart + 0x644	; 037FC4CC
pool_037FC4D0:
loc_037FC4D0:
	.word TIMER0_CR	; 037FC4D0
pool_037FC4D4:
loc_037FC4D4:
	.word TIMER0_DATA	; 037FC4D4
pool_037FC4D8:
loc_037FC4D8:
	.word P2_IrqHandler_037FC428 + 1	; 037FC4D8
pool_037FC4DC:
loc_037FC4DC:
	.word P2_BssStart + 0x640	; 037FC4DC
.arm
P2_Code_037FC4E0:
	stmdb sp!,{lr}	; 037FC4E0
	bl loc_037FC4F0	; 037FC4E4
	ldmia sp!,{lr}	; 037FC4E8
	bx lr	; 037FC4EC

; ===== function loc_037FC4F0 =====
loc_037FC4F0:
	ldr r12,[pool_037FC4F8]	; 037FC4F0
	bx r12	; 037FC4F4
pool_037FC4F8:
loc_037FC4F8:
	.word loc_037FC4FC + 1	; 037FC4F8
.thumb
loc_037FC4FC:
	push {r4,r5,lr}	; 037FC4FC
	sub sp,#0x4	; 037FC4FE
	mov r1,#0x0	; 037FC500
	ldr r0,[pool_037FC594]	; 037FC502
	strh r1,[r0,#0x0]	; 037FC504
	mov r0,#0x10	; 037FC506
	bl loc_037FB570	; 037FC508
	ldr r2,[pool_037FC598]	; 037FC50C
	ldr r1,[r2,#0x0]	; 037FC50E
	mov r0,#0x10	; 037FC510
	orr r1,r0	; 037FC512
	str r1,[r2,#0x0]	; 037FC514
	bl loc_037FC3AC	; 037FC516
	ldr r2,[pool_037FC59C]	; 037FC51A
	ldr r4,[r2,#0x0]	; 037FC51C
	cmp r4,#0x0	; 037FC51E
	beq loc_037FC58A	; 037FC520
	ldr r5,[r4,#0xc]	; 037FC522
	ldr r3,[r4,#0x10]	; 037FC524
	sub r0,r0,r5	; 037FC526
	sbc r1,r3	; 037FC528
	bcs loc_037FC534	; 037FC52A
	add r0,r4,#0x0	; 037FC52C
	bl loc_037FC7BC	; 037FC52E
	b loc_037FC58A	; 037FC532
loc_037FC534:
	ldr r1,[r4,#0x18]	; 037FC534
	str r1,[r2,#0x0]	; 037FC536
	cmp r1,#0x0	; 037FC538
	bne loc_037FC542	; 037FC53A
	mov r0,#0x0	; 037FC53C
	str r0,[r2,#0x4]	; 037FC53E
	b loc_037FC546	; 037FC540
loc_037FC542:
	mov r0,#0x0	; 037FC542
	str r0,[r1,#0x14]	; 037FC544
loc_037FC546:
	ldr r5,[r4,#0x0]	; 037FC546
	ldr r2,[r4,#0x1c]	; 037FC548
	ldr r1,[r4,#0x20]	; 037FC54A
	mov r0,#0x0	; 037FC54C
	eor r1,r0	; 037FC54E
	eor r2,r0	; 037FC550
	orr r1,r2	; 037FC552
	bne loc_037FC55A	; 037FC554
	mov r0,#0x0	; 037FC556
	str r0,[r4,#0x0]	; 037FC558
loc_037FC55A:
	cmp r5,#0x0	; 037FC55A
	beq loc_037FC564	; 037FC55C
	ldr r0,[r4,#0x4]	; 037FC55E
	bl loc_03802A08	; 037FC560
loc_037FC564:
	ldr r2,[r4,#0x1c]	; 037FC564
	ldr r1,[r4,#0x20]	; 037FC566
	mov r0,#0x0	; 037FC568
	eor r1,r0	; 037FC56A
	eor r2,r0	; 037FC56C
	orr r1,r2	; 037FC56E
	beq loc_037FC57E	; 037FC570
	str r5,[r4,#0x0]	; 037FC572
	add r0,r4,#0x0	; 037FC574
	mov r1,#0x0	; 037FC576
	add r2,r1,#0x0	; 037FC578
	bl loc_037FC69C	; 037FC57A
loc_037FC57E:
	ldr r0,[pool_037FC59C]	; 037FC57E
	ldr r0,[r0,#0x0]	; 037FC580
	cmp r0,#0x0	; 037FC582
	beq loc_037FC58A	; 037FC584
	bl loc_037FC7BC	; 037FC586
loc_037FC58A:
	add sp,#0x4	; 037FC58A
	pop {r4,r5}	; 037FC58C
	pop {r3}	; 037FC58E
	bx r3	; 037FC590
	.byte 0xC0, 0x46	; 037FC594
pool_037FC594:
loc_037FC594:
	.word TIMER1_CR	; 037FC594
pool_037FC598:
loc_037FC598:
	.word Bios7IrqFlagsAddress	; 037FC598
pool_037FC59C:
loc_037FC59C:
	.word P2_BssStart + 0x650	; 037FC59C

; ===== function loc_037FC5A0 =====
loc_037FC5A0:
	push {r4,r5,lr}	; 037FC5A0
	sub sp,#0x4	; 037FC5A2
	add r5,r0,#0x0	; 037FC5A4
	bl loc_037FB7EC	; 037FC5A6
	add r4,r0,#0x0	; 037FC5AA
	ldr r1,[r5,#0x0]	; 037FC5AC
	cmp r1,#0x0	; 037FC5AE
	bne loc_037FC5B8	; 037FC5B0
	bl loc_037FB810	; 037FC5B2
	b loc_037FC5EE	; 037FC5B6
loc_037FC5B8:
	ldr r0,[r5,#0x18]	; 037FC5B8
	cmp r0,#0x0	; 037FC5BA
	bne loc_037FC5C6	; 037FC5BC
	ldr r2,[r5,#0x14]	; 037FC5BE
	ldr r1,[pool_037FC5F8]	; 037FC5C0
	str r2,[r1,#0x4]	; 037FC5C2
	b loc_037FC5CA	; 037FC5C4
loc_037FC5C6:
	ldr r1,[r5,#0x14]	; 037FC5C6
	str r1,[r0,#0x14]	; 037FC5C8
loc_037FC5CA:
	ldr r1,[r5,#0x14]	; 037FC5CA
	cmp r1,#0x0	; 037FC5CC
	beq loc_037FC5D4	; 037FC5CE
	str r0,[r1,#0x18]	; 037FC5D0
	b loc_037FC5E0	; 037FC5D2
loc_037FC5D4:
	ldr r1,[pool_037FC5F8]	; 037FC5D4
	str r0,[r1,#0x0]	; 037FC5D6
	cmp r0,#0x0	; 037FC5D8
	beq loc_037FC5E0	; 037FC5DA
	bl loc_037FC7BC	; 037FC5DC
loc_037FC5E0:
	mov r0,#0x0	; 037FC5E0
	str r0,[r5,#0x0]	; 037FC5E2
	str r0,[r5,#0x1c]	; 037FC5E4
	str r0,[r5,#0x20]	; 037FC5E6
	add r0,r4,#0x0	; 037FC5E8
	bl loc_037FB810	; 037FC5EA
loc_037FC5EE:
	add sp,#0x4	; 037FC5EE
	pop {r4,r5}	; 037FC5F0
	pop {r3}	; 037FC5F2
	bx r3	; 037FC5F4
	.byte 0xC0, 0x46	; 037FC5F8
pool_037FC5F8:
loc_037FC5F8:
	.word P2_BssStart + 0x650	; 037FC5F8

; ===== function loc_037FC5FC =====
loc_037FC5FC:
	push {r4,r5,r6,lr}	; 037FC5FC
	sub sp,#0x10	; 037FC5FE
	add r5,r0,#0x0	; 037FC600
	add r4,r1,#0x0	; 037FC602
	add r6,r2,#0x0	; 037FC604
	str r3,[sp,#0x0]	; 037FC606
	ldr r0,[sp,#0x20]	; 037FC608
	str r0,[sp,#0x4]	; 037FC60A
	cmp r5,#0x0	; 037FC60C
	beq loc_037FC616	; 037FC60E
	ldr r0,[r5,#0x0]	; 037FC610
	cmp r0,#0x0	; 037FC612
	beq loc_037FC61A	; 037FC614
loc_037FC616:
	bl loc_037FCCC0	; 037FC616
loc_037FC61A:
	bl loc_037FB7EC	; 037FC61A
	str r0,[sp,#0x8]	; 037FC61E
	ldr r0,[sp,#0x0]	; 037FC620
	str r0,[r5,#0x1c]	; 037FC622
	ldr r0,[sp,#0x4]	; 037FC624
	str r0,[r5,#0x20]	; 037FC626
	str r4,[r5,#0x24]	; 037FC628
	str r6,[r5,#0x28]	; 037FC62A
	ldr r0,[sp,#0x24]	; 037FC62C
	str r0,[r5,#0x0]	; 037FC62E
	ldr r0,[sp,#0x28]	; 037FC630
	str r0,[r5,#0x4]	; 037FC632
	add r0,r5,#0x0	; 037FC634
	mov r1,#0x0	; 037FC636
	add r2,r1,#0x0	; 037FC638
	bl loc_037FC69C	; 037FC63A
	ldr r0,[sp,#0x8]	; 037FC63E
	bl loc_037FB810	; 037FC640
	add sp,#0x10	; 037FC644
	pop {r4,r5,r6}	; 037FC646
	pop {r3}	; 037FC648
	bx r3	; 037FC64A

; ===== function loc_037FC64C =====
loc_037FC64C:
	push {r4,r5,r6,r7,lr}	; 037FC64C
	sub sp,#0x4	; 037FC64E
	add r5,r0,#0x0	; 037FC650
	add r6,r1,#0x0	; 037FC652
	add r4,r2,#0x0	; 037FC654
	add r7,r3,#0x0	; 037FC656
	cmp r5,#0x0	; 037FC658
	beq loc_037FC662	; 037FC65A
	ldr r0,[r5,#0x0]	; 037FC65C
	cmp r0,#0x0	; 037FC65E
	beq loc_037FC666	; 037FC660
loc_037FC662:
	bl loc_037FCCC0	; 037FC662
loc_037FC666:
	bl loc_037FB7EC	; 037FC666
	str r0,[sp,#0x0]	; 037FC66A
	mov r0,#0x0	; 037FC66C
	str r0,[r5,#0x1c]	; 037FC66E
	str r0,[r5,#0x20]	; 037FC670
	str r7,[r5,#0x0]	; 037FC672
	ldr r0,[sp,#0x18]	; 037FC674
	str r0,[r5,#0x4]	; 037FC676
	bl loc_037FC3AC	; 037FC678
	add r2,r0,#0x0	; 037FC67C
	add r0,r5,#0x0	; 037FC67E
	add r2,r6,r2	; 037FC680
	adc r4,r1	; 037FC682
	add r1,r2,#0x0	; 037FC684
	add r2,r4,#0x0	; 037FC686
	bl loc_037FC69C	; 037FC688
	ldr r0,[sp,#0x0]	; 037FC68C
	bl loc_037FB810	; 037FC68E
	add sp,#0x4	; 037FC692
	pop {r4,r5,r6,r7}	; 037FC694
	pop {r3}	; 037FC696
	bx r3	; 037FC698
	.byte 0x00, 0x00	; 037FC69C

; ===== function loc_037FC69C =====
loc_037FC69C:
	push {r4,r5,r6,r7,lr}	; 037FC69C
	sub sp,#0xc	; 037FC69E
	add r5,r0,#0x0	; 037FC6A0
	add r4,r1,#0x0	; 037FC6A2
	add r6,r2,#0x0	; 037FC6A4
	ldr r2,[r5,#0x1c]	; 037FC6A6
	ldr r1,[r5,#0x20]	; 037FC6A8
	mov r0,#0x0	; 037FC6AA
	eor r1,r0	; 037FC6AC
	eor r2,r0	; 037FC6AE
	orr r1,r2	; 037FC6B0
	beq loc_037FC6F6	; 037FC6B2
	bl loc_037FC3AC	; 037FC6B4
	ldr r4,[r5,#0x24]	; 037FC6B8
	ldr r6,[r5,#0x28]	; 037FC6BA
	sub r2,r4,r0	; 037FC6BC
	lsl r2,r6,#0	; 037FC6BE
	sbc r2,r1	; 037FC6C0
	bcs loc_037FC6F6	; 037FC6C2
	ldr r2,[r5,#0x1c]	; 037FC6C4
	str r2,[sp,#0x0]	; 037FC6C6
	ldr r2,[r5,#0x20]	; 037FC6C8
	str r2,[sp,#0x4]	; 037FC6CA
	sub r0,r0,r4	; 037FC6CC
	sbc r1,r6	; 037FC6CE
	ldr r2,[sp,#0x0]	; 037FC6D0
	ldr r3,[sp,#0x4]	; 037FC6D2
	bl loc_037FC760	; 037FC6D4
	str r0,[sp,#0x8]	; 037FC6D8
	add r7,r1,#0x0	; 037FC6DA
	ldr r0,[sp,#0x0]	; 037FC6DC
	ldr r1,[sp,#0x4]	; 037FC6DE
	mov r3,#0x1	; 037FC6E0
	ldr r2,[sp,#0x8]	; 037FC6E2
	add r3,r2,r3	; 037FC6E4
	mov r2,#0x0	; 037FC6E6
	adc r7,r2	; 037FC6E8
	add r2,r3,#0x0	; 037FC6EA
	add r3,r7,#0x0	; 037FC6EC
	bl loc_037FC76C	; 037FC6EE
	add r4,r4,r0	; 037FC6F2
	adc r6,r1	; 037FC6F4
loc_037FC6F6:
	str r4,[r5,#0xc]	; 037FC6F6
	str r6,[r5,#0x10]	; 037FC6F8
	ldr r0,[pool_037FC75C]	; 037FC6FA
	ldr r3,[r0,#0x0]	; 037FC6FC
	b loc_037FC732	; 037FC6FE
loc_037FC700:
	ldr r1,[r3,#0xc]	; 037FC700
	ldr r0,[r3,#0x10]	; 037FC702
	sub r2,r4,r1	; 037FC704
	lsl r1,r6,#0	; 037FC706
	sbc r1,r0	; 037FC708
	mov r0,#0x0	; 037FC70A
	sub r2,r2,r0	; 037FC70C
	sbc r1,r0	; 037FC70E
	bge loc_037FC730	; 037FC710
	ldr r0,[r3,#0x14]	; 037FC712
	str r0,[r5,#0x14]	; 037FC714
	str r5,[r3,#0x14]	; 037FC716
	str r3,[r5,#0x18]	; 037FC718
	ldr r0,[r5,#0x14]	; 037FC71A
	cmp r0,#0x0	; 037FC71C
	beq loc_037FC724	; 037FC71E
	str r5,[r0,#0x18]	; 037FC720
	b loc_037FC754	; 037FC722
loc_037FC724:
	ldr r0,[pool_037FC75C]	; 037FC724
	str r5,[r0,#0x0]	; 037FC726
	add r0,r5,#0x0	; 037FC728
	bl loc_037FC7BC	; 037FC72A
	b loc_037FC754	; 037FC72E
loc_037FC730:
	ldr r3,[r3,#0x18]	; 037FC730
loc_037FC732:
	cmp r3,#0x0	; 037FC732
	bne loc_037FC700	; 037FC734
	mov r0,#0x0	; 037FC736
	str r0,[r5,#0x18]	; 037FC738
	ldr r0,[pool_037FC75C]	; 037FC73A
	ldr r1,[r0,#0x4]	; 037FC73C
	str r5,[r0,#0x4]	; 037FC73E
	str r1,[r5,#0x14]	; 037FC740
	cmp r1,#0x0	; 037FC742
	beq loc_037FC74A	; 037FC744
	str r5,[r1,#0x18]	; 037FC746
	b loc_037FC754	; 037FC748
loc_037FC74A:
	str r5,[r0,#0x4]	; 037FC74A
	str r5,[r0,#0x0]	; 037FC74C
	add r0,r5,#0x0	; 037FC74E
	bl loc_037FC7BC	; 037FC750
loc_037FC754:
	add sp,#0xc	; 037FC754
	pop {r4,r5,r6,r7}	; 037FC756
	pop {r3}	; 037FC758
	bx r3	; 037FC75A
pool_037FC75C:
loc_037FC75C:
	.word P2_BssStart + 0x650	; 037FC75C

; ===== function loc_037FC760 =====
loc_037FC760:
	bx pc	; 037FC760
	.byte 0xC0, 0x46	; 037FC764
.arm

; ===== function loc_037FC764 =====
loc_037FC764:
	ldr pc,[pool_037FC768]	; 037FC764
pool_037FC768:
loc_037FC768:
	.word loc_038022BC	; 037FC768
.thumb

; ===== function loc_037FC76C =====
loc_037FC76C:
	bx pc	; 037FC76C
	.byte 0xC0, 0x46	; 037FC770
.arm

; ===== function loc_037FC770 =====
loc_037FC770:
	ldr pc,[pool_037FC774]	; 037FC770
pool_037FC774:
loc_037FC774:
	.word loc_038024C4	; 037FC774
.thumb

; ===== function loc_037FC778 =====
loc_037FC778:
	mov r1,#0x0	; 037FC778
	str r1,[r0,#0x0]	; 037FC77A
	str r1,[r0,#0x8]	; 037FC77C
	bx lr	; 037FC77E

; ===== function loc_037FC780 =====
loc_037FC780:
	ldr r0,[pool_037FC788]	; 037FC780
	ldrh r0,[r0,#0x0]	; 037FC782
	bx lr	; 037FC784
	.byte 0xC0, 0x46	; 037FC788
pool_037FC788:
loc_037FC788:
	.word P2_BssStart + 0x64C	; 037FC788

; ===== function loc_037FC78C =====
loc_037FC78C:
	push {lr}	; 037FC78C
	sub sp,#0x4	; 037FC78E
	ldr r1,[pool_037FC7B4]	; 037FC790
	ldrh r0,[r1,#0x0]	; 037FC792
	cmp r0,#0x0	; 037FC794
	bne loc_037FC7AE	; 037FC796
	mov r0,#0x1	; 037FC798
	strh r0,[r1,#0x0]	; 037FC79A
	bl loc_037FC398	; 037FC79C
	mov r1,#0x0	; 037FC7A0
	ldr r0,[pool_037FC7B8]	; 037FC7A2
	str r1,[r0,#0x0]	; 037FC7A4
	str r1,[r0,#0x4]	; 037FC7A6
	mov r0,#0x10	; 037FC7A8
	bl loc_037FB570	; 037FC7AA
loc_037FC7AE:
	add sp,#0x4	; 037FC7AE
	pop {r3}	; 037FC7B0
	bx r3	; 037FC7B2
pool_037FC7B4:
loc_037FC7B4:
	.word P2_BssStart + 0x64C	; 037FC7B4
pool_037FC7B8:
loc_037FC7B8:
	.word P2_BssStart + 0x650	; 037FC7B8

; ===== function loc_037FC7BC =====
loc_037FC7BC:
	push {r4,r5,lr}	; 037FC7BC
	sub sp,#0x4	; 037FC7BE
	add r4,r0,#0x0	; 037FC7C0
	bl loc_037FC3AC	; 037FC7C2
	mov r2,#0x0	; 037FC7C6
	ldr r3,[pool_037FC814]	; 037FC7C8
	strh r2,[r3,#0x0]	; 037FC7CA
	ldr r3,[r4,#0xc]	; 037FC7CC
	ldr r4,[r4,#0x10]	; 037FC7CE
	sub r5,r3,r0	; 037FC7D0
	sbc r4,r1	; 037FC7D2
	mov r0,#0x1	; 037FC7D4
	ldr r1,[pool_037FC818]	; 037FC7D6
	bl loc_037FB5EC	; 037FC7D8
	mov r1,#0x0	; 037FC7DC
	sub r0,r5,r1	; 037FC7DE
	lsl r0,r4,#0	; 037FC7E0
	sbc r0,r1	; 037FC7E2
	bge loc_037FC7EA	; 037FC7E4
	ldr r1,[pool_037FC81C]	; 037FC7E6
	b loc_037FC7FC	; 037FC7E8
loc_037FC7EA:
	ldr r0,[pool_037FC820]	; 037FC7EA
	sub r0,r5,r0	; 037FC7EC
	sbc r4,r1	; 037FC7EE
	bge loc_037FC7FA	; 037FC7F0
	mvn r0,r5	; 037FC7F2
	lsl r0,r0,#0x10	; 037FC7F4
	lsr r1,r0,#0x10	; 037FC7F6
	b loc_037FC7FC	; 037FC7F8
loc_037FC7FA:
	mov r1,#0x0	; 037FC7FA
loc_037FC7FC:
	ldr r0,[pool_037FC824]	; 037FC7FC
	strh r1,[r0,#0x0]	; 037FC7FE
	mov r1,#0xc1	; 037FC800
	ldr r0,[pool_037FC814]	; 037FC802
	strh r1,[r0,#0x0]	; 037FC804
	mov r0,#0x10	; 037FC806
	bl loc_037FB59C	; 037FC808
	add sp,#0x4	; 037FC80C
	pop {r4,r5}	; 037FC80E
	pop {r3}	; 037FC810
	bx r3	; 037FC812
pool_037FC814:
loc_037FC814:
	.word TIMER1_CR	; 037FC814
pool_037FC818:
loc_037FC818:
	.word P2_Code_037FC4E0	; 037FC818
pool_037FC81C:
loc_037FC81C:
	.word 0x0000FFFE	; 037FC81C
pool_037FC820:
loc_037FC820:
	.word 0x00010000	; 037FC820
pool_037FC824:
loc_037FC824:
	.word TIMER1_DATA	; 037FC824
.arm
P2_IrqHandler_037FC828:
	stmdb sp!,{lr}	; 037FC828
	bl loc_037FC838	; 037FC82C
	ldmia sp!,{lr}	; 037FC830
	bx lr	; 037FC834

; ===== function loc_037FC838 =====
loc_037FC838:
	ldr r12,[pool_037FC840]	; 037FC838
	bx r12	; 037FC83C
pool_037FC840:
loc_037FC840:
	.word loc_037FC898 + 1	; 037FC840
.thumb

; ===== function loc_037FC844 =====
P2_Entry_037FC844:
	push {r4,r5,r6,r7,lr}	; 037FC844
	sub sp,#0x4	; 037FC846
	add r5,r0,#0x0	; 037FC848
	cmp r5,#0x0	; 037FC84A
	beq loc_037FC886	; 037FC84C
	bl loc_037FB7EC	; 037FC84E
	add r6,r0,#0x0	; 037FC852
	ldr r0,[pool_037FC890]	; 037FC854
	ldr r0,[r0,#0x0]	; 037FC856
	cmp r0,#0x0	; 037FC858
	beq loc_037FC860	; 037FC85A
	ldr r4,[r0,#0x14]	; 037FC85C
	b loc_037FC862	; 037FC85E
loc_037FC860:
	mov r4,#0x0	; 037FC860
loc_037FC862:
	mov r7,#0x0	; 037FC862
	b loc_037FC87C	; 037FC864
loc_037FC866:
	ldr r1,[r0,#0x8]	; 037FC866
	cmp r1,r5	; 037FC868
	bne loc_037FC870	; 037FC86A
	bl loc_037FC988	; 037FC86C
loc_037FC870:
	add r0,r4,#0x0	; 037FC870
	cmp r4,#0x0	; 037FC872
	beq loc_037FC87A	; 037FC874
	ldr r4,[r4,#0x14]	; 037FC876
	b loc_037FC87C	; 037FC878
loc_037FC87A:
	add r4,r7,#0x0	; 037FC87A
loc_037FC87C:
	cmp r0,#0x0	; 037FC87C
	bne loc_037FC866	; 037FC87E
	add r0,r6,#0x0	; 037FC880
	bl loc_037FB810	; 037FC882
loc_037FC886:
	add sp,#0x4	; 037FC886
	pop {r4,r5,r6,r7}	; 037FC888
	pop {r3}	; 037FC88A
	bx r3	; 037FC88C
	.byte 0xC0, 0x46	; 037FC890
pool_037FC890:
loc_037FC890:
	.word P2_BssStart + 0x65C	; 037FC890

; ===== function loc_037FC894 =====
loc_037FC894:
	str r1,[r0,#0x8]	; 037FC894
	bx lr	; 037FC896

; ===== function loc_037FC898 =====
loc_037FC898:
	push {r4,r5,lr}	; 037FC898
	sub sp,#0x4	; 037FC89A
	mov r0,#0x4	; 037FC89C
	bl loc_037FB570	; 037FC89E
	ldr r2,[pool_037FC978]	; 037FC8A2
	ldrh r1,[r2,#0x0]	; 037FC8A4
	mov r0,#0x20	; 037FC8A6
	bic r1,r0	; 037FC8A8
	strh r1,[r2,#0x0]	; 037FC8AA
	ldr r2,[pool_037FC97C]	; 037FC8AC
	ldr r1,[r2,#0x0]	; 037FC8AE
	mov r0,#0x4	; 037FC8B0
	orr r1,r0	; 037FC8B2
	str r1,[r2,#0x0]	; 037FC8B4
	ldr r1,[pool_037FC980]	; 037FC8B6
	mov r0,#0x0	; 037FC8B8
	ldrsh r1,[r1,r0]	; 037FC8BA
	ldr r0,[pool_037FC984]	; 037FC8BC
	ldr r4,[r0,#0x0]	; 037FC8BE
	cmp r4,#0x0	; 037FC8C0
	beq loc_037FC96E	; 037FC8C2
	mov r0,#0xc	; 037FC8C4
	ldrsh r0,[r4,r0]	; 037FC8C6
	sub r0,r1,r0	; 037FC8C8
	bl loc_037FCBC0	; 037FC8CA
	cmp r0,#0x0	; 037FC8CE
	ble loc_037FC8DE	; 037FC8D0
	cmp r0,#0xfd	; 037FC8D2
	bge loc_037FC8DE	; 037FC8D4
	add r0,r4,#0x0	; 037FC8D6
	bl loc_037FCB60	; 037FC8D8
	b loc_037FC96E	; 037FC8DC
loc_037FC8DE:
	ldr r1,[r4,#0x14]	; 037FC8DE
	ldr r0,[pool_037FC984]	; 037FC8E0
	str r1,[r0,#0x0]	; 037FC8E2
	cmp r1,#0x0	; 037FC8E4
	bne loc_037FC8EE	; 037FC8E6
	mov r1,#0x0	; 037FC8E8
	str r1,[r0,#0x4]	; 037FC8EA
	b loc_037FC8F2	; 037FC8EC
loc_037FC8EE:
	mov r0,#0x0	; 037FC8EE
	str r0,[r1,#0x10]	; 037FC8F0
loc_037FC8F2:
	ldr r5,[r4,#0x0]	; 037FC8F2
	mov r0,#0x0	; 037FC8F4
	str r0,[r4,#0x0]	; 037FC8F6
	cmp r5,#0x0	; 037FC8F8
	beq loc_037FC902	; 037FC8FA
	ldr r0,[r4,#0x4]	; 037FC8FC
	bl loc_03802A08	; 037FC8FE
loc_037FC902:
	mov r0,#0x1	; 037FC902
	str r0,[r4,#0x1c]	; 037FC904
	ldr r0,[r4,#0x18]	; 037FC906
	cmp r0,#0x0	; 037FC908
	beq loc_037FC914	; 037FC90A
	str r5,[r4,#0x0]	; 037FC90C
	add r0,r4,#0x0	; 037FC90E
	bl loc_037FCA68	; 037FC910
loc_037FC914:
	ldr r0,[pool_037FC984]	; 037FC914
	ldr r5,[r0,#0x0]	; 037FC916
	cmp r5,#0x0	; 037FC918
	beq loc_037FC954	; 037FC91A
	ldr r0,[r5,#0x1c]	; 037FC91C
	cmp r0,#0x0	; 037FC91E
	bne loc_037FC954	; 037FC920
	ldr r0,[pool_037FC980]	; 037FC922
	ldrh r1,[r0,#0x0]	; 037FC924
	mov r0,#0xc	; 037FC926
	ldrsh r0,[r5,r0]	; 037FC928
	sub r0,r1,r0	; 037FC92A
	bl loc_037FCBC0	; 037FC92C
	ldr r1,[pool_037FC984]	; 037FC930
	ldr r5,[r1,#0x0]	; 037FC932
	mov r1,#0xe	; 037FC934
	ldrsh r1,[r5,r1]	; 037FC936
	cmp r0,r1	; 037FC938
	bge loc_037FC954	; 037FC93A
	mov r0,#0xc	; 037FC93C
	ldrsh r1,[r5,r0]	; 037FC93E
	ldrsh r0,[r4,r0]	; 037FC940
	sub r0,r1,r0	; 037FC942
	bl loc_037FCBC0	; 037FC944
	mov r1,#0xe	; 037FC948
	ldrsh r1,[r5,r1]	; 037FC94A
	cmp r0,r1	; 037FC94C
	bgt loc_037FC954	; 037FC94E
	add r4,r5,#0x0	; 037FC950
	b loc_037FC8DE	; 037FC952
loc_037FC954:
	cmp r5,#0x0	; 037FC954
	beq loc_037FC95E	; 037FC956
	add r0,r5,#0x0	; 037FC958
	bl loc_037FCB60	; 037FC95A
loc_037FC95E:
	ldr r0,[pool_037FC984]	; 037FC95E
	ldr r1,[r0,#0x0]	; 037FC960
	mov r0,#0x0	; 037FC962
	b loc_037FC96A	; 037FC964
loc_037FC966:
	str r0,[r1,#0x1c]	; 037FC966
	ldr r1,[r1,#0x14]	; 037FC968
loc_037FC96A:
	cmp r1,#0x0	; 037FC96A
	bne loc_037FC966	; 037FC96C
loc_037FC96E:
	add sp,#0x4	; 037FC96E
	pop {r4,r5}	; 037FC970
	pop {r3}	; 037FC972
	bx r3	; 037FC974
	.byte 0xC0, 0x46	; 037FC978
pool_037FC978:
loc_037FC978:
	.word REG_DISPSTAT	; 037FC978
pool_037FC97C:
loc_037FC97C:
	.word Bios7IrqFlagsAddress	; 037FC97C
pool_037FC980:
loc_037FC980:
	.word REG_VCOUNT	; 037FC980
pool_037FC984:
loc_037FC984:
	.word P2_BssStart + 0x65C	; 037FC984

; ===== function loc_037FC988 =====
loc_037FC988:
	push {r4,r5,lr}	; 037FC988
	sub sp,#0x4	; 037FC98A
	add r5,r0,#0x0	; 037FC98C
	bl loc_037FB7EC	; 037FC98E
	add r4,r0,#0x0	; 037FC992
	ldr r1,[r5,#0x0]	; 037FC994
	cmp r1,#0x0	; 037FC996
	bne loc_037FC9A0	; 037FC998
	bl loc_037FB810	; 037FC99A
	b loc_037FC9D2	; 037FC99E
loc_037FC9A0:
	ldr r0,[r5,#0x14]	; 037FC9A0
	cmp r0,#0x0	; 037FC9A2
	bne loc_037FC9AE	; 037FC9A4
	ldr r2,[r5,#0x10]	; 037FC9A6
	ldr r1,[pool_037FC9DC]	; 037FC9A8
	str r2,[r1,#0x4]	; 037FC9AA
	b loc_037FC9B2	; 037FC9AC
loc_037FC9AE:
	ldr r1,[r5,#0x10]	; 037FC9AE
	str r1,[r0,#0x10]	; 037FC9B0
loc_037FC9B2:
	ldr r1,[r5,#0x10]	; 037FC9B2
	cmp r1,#0x0	; 037FC9B4
	beq loc_037FC9BC	; 037FC9B6
	str r0,[r1,#0x14]	; 037FC9B8
	b loc_037FC9C8	; 037FC9BA
loc_037FC9BC:
	ldr r1,[pool_037FC9DC]	; 037FC9BC
	str r0,[r1,#0x0]	; 037FC9BE
	cmp r0,#0x0	; 037FC9C0
	beq loc_037FC9C8	; 037FC9C2
	bl loc_037FCB60	; 037FC9C4
loc_037FC9C8:
	mov r0,#0x0	; 037FC9C8
	str r0,[r5,#0x0]	; 037FC9CA
	add r0,r4,#0x0	; 037FC9CC
	bl loc_037FB810	; 037FC9CE
loc_037FC9D2:
	add sp,#0x4	; 037FC9D2
	pop {r4,r5}	; 037FC9D4
	pop {r3}	; 037FC9D6
	bx r3	; 037FC9D8
	.byte 0xC0, 0x46	; 037FC9DC
pool_037FC9DC:
loc_037FC9DC:
	.word P2_BssStart + 0x65C	; 037FC9DC
P2_Entry_037FC9E0:
	push {r4,r5,r6,r7,lr}	; 037FC9E0
	sub sp,#0x4	; 037FC9E2
	add r5,r0,#0x0	; 037FC9E4
	add r4,r1,#0x0	; 037FC9E6
	add r6,r2,#0x0	; 037FC9E8
	add r7,r3,#0x0	; 037FC9EA
	cmp r5,#0x0	; 037FC9EC
	beq P2_Entry_037FC9F6	; 037FC9EE
	ldr r0,[r5,#0x0]	; 037FC9F0
	cmp r0,#0x0	; 037FC9F2
	beq P2_Entry_037FC9FA	; 037FC9F4
P2_Entry_037FC9F6:
	bl loc_037FCCC0	; 037FC9F6
P2_Entry_037FC9FA:
	bl loc_037FB7EC	; 037FC9FA
	str r0,[sp,#0x0]	; 037FC9FE
	mov r0,#0x1	; 037FCA00
	str r0,[r5,#0x18]	; 037FCA02
	strh r4,[r5,#0xc]	; 037FCA04
	strh r6,[r5,#0xe]	; 037FCA06
	str r7,[r5,#0x0]	; 037FCA08
	ldr r0,[sp,#0x18]	; 037FCA0A
	str r0,[r5,#0x4]	; 037FCA0C
	add r0,r5,#0x0	; 037FCA0E
	bl P2_Entry_037FCA94	; 037FCA10
	ldr r0,[sp,#0x0]	; 037FCA14
	bl loc_037FB810	; 037FCA16
	add sp,#0x4	; 037FCA1A
	pop {r4,r5,r6,r7}	; 037FCA1C
	pop {r3}	; 037FCA1E
	bx r3	; 037FCA20
	.byte 0x00, 0x00	; 037FCA22
P2_Entry_037FCA24:
	push {r4,r5,r6,r7,lr}	; 037FCA24
	sub sp,#0x4	; 037FCA26
	add r5,r0,#0x0	; 037FCA28
	add r4,r1,#0x0	; 037FCA2A
	add r6,r2,#0x0	; 037FCA2C
	add r7,r3,#0x0	; 037FCA2E
	cmp r5,#0x0	; 037FCA30
	beq P2_Entry_037FCA3A	; 037FCA32
	ldr r0,[r5,#0x0]	; 037FCA34
	cmp r0,#0x0	; 037FCA36
	beq P2_Entry_037FCA3E	; 037FCA38
P2_Entry_037FCA3A:
	bl loc_037FCCC0	; 037FCA3A
P2_Entry_037FCA3E:
	bl loc_037FB7EC	; 037FCA3E
	str r0,[sp,#0x0]	; 037FCA42
	mov r0,#0x0	; 037FCA44
	str r0,[r5,#0x18]	; 037FCA46
	strh r4,[r5,#0xc]	; 037FCA48
	mov r0,#0xa	; 037FCA4A
	strh r0,[r5,#0xe]	; 037FCA4C
	str r6,[r5,#0x0]	; 037FCA4E
	str r7,[r5,#0x4]	; 037FCA50
	add r0,r5,#0x0	; 037FCA52
	bl P2_Entry_037FCA94	; 037FCA54
	ldr r0,[sp,#0x0]	; 037FCA58
	bl loc_037FB810	; 037FCA5A
	add sp,#0x4	; 037FCA5E
	pop {r4,r5,r6,r7}	; 037FCA60
	pop {r3}	; 037FCA62
	bx r3	; 037FCA64
	.byte 0x00, 0x00	; 037FCA66

; ===== function loc_037FCA68 =====
loc_037FCA68:
	push {lr}	; 037FCA68
	sub sp,#0x4	; 037FCA6A
	mov r1,#0x0	; 037FCA6C
	str r1,[r0,#0x14]	; 037FCA6E
	ldr r1,[pool_037FCA90]	; 037FCA70
	ldr r2,[r1,#0x4]	; 037FCA72
	str r0,[r1,#0x4]	; 037FCA74
	str r2,[r0,#0x10]	; 037FCA76
	cmp r2,#0x0	; 037FCA78
	beq loc_037FCA80	; 037FCA7A
	str r0,[r2,#0x14]	; 037FCA7C
	b loc_037FCA88	; 037FCA7E
loc_037FCA80:
	str r0,[r1,#0x4]	; 037FCA80
	str r0,[r1,#0x0]	; 037FCA82
	bl loc_037FCB60	; 037FCA84
loc_037FCA88:
	add sp,#0x4	; 037FCA88
	pop {r3}	; 037FCA8A
	bx r3	; 037FCA8C
	.byte 0xC0, 0x46	; 037FCA90
pool_037FCA90:
loc_037FCA90:
	.word P2_BssStart + 0x65C	; 037FCA90

; ===== function loc_037FCA94 =====
P2_Entry_037FCA94:
	push {r4,r5,r6,r7,lr}	; 037FCA94
	sub sp,#0x4	; 037FCA96
	add r5,r0,#0x0	; 037FCA98
	ldr r0,[pool_037FCB14]	; 037FCA9A
	ldrh r6,[r0,#0x0]	; 037FCA9C
	ldr r0,[pool_037FCB18]	; 037FCA9E
	ldr r4,[r0,#0x0]	; 037FCAA0
	b loc_037FCAE8	; 037FCAA2
loc_037FCAA4:
	mov r0,#0xc	; 037FCAA4
	ldrsh r0,[r5,r0]	; 037FCAA6
	sub r0,r0,r6	; 037FCAA8
	bl loc_037FCBC0	; 037FCAAA
	add r7,r0,#0x0	; 037FCAAE
	mov r0,#0xc	; 037FCAB0
	ldrsh r0,[r4,r0]	; 037FCAB2
	sub r0,r0,r6	; 037FCAB4
	bl loc_037FCBC0	; 037FCAB6
	cmp r7,r0	; 037FCABA
	bge loc_037FCAC2	; 037FCABC
	mov r0,#0x1	; 037FCABE
	b loc_037FCAC4	; 037FCAC0
loc_037FCAC2:
	mov r0,#0x0	; 037FCAC2
loc_037FCAC4:
	cmp r0,#0x0	; 037FCAC4
	beq loc_037FCAE6	; 037FCAC6
	ldr r0,[r4,#0x10]	; 037FCAC8
	str r0,[r5,#0x10]	; 037FCACA
	str r5,[r4,#0x10]	; 037FCACC
	str r4,[r5,#0x14]	; 037FCACE
	ldr r0,[r5,#0x10]	; 037FCAD0
	cmp r0,#0x0	; 037FCAD2
	beq loc_037FCADA	; 037FCAD4
	str r5,[r0,#0x14]	; 037FCAD6
	b loc_037FCB0A	; 037FCAD8
loc_037FCADA:
	ldr r0,[pool_037FCB18]	; 037FCADA
	str r5,[r0,#0x0]	; 037FCADC
	add r0,r5,#0x0	; 037FCADE
	bl loc_037FCB60	; 037FCAE0
	b loc_037FCB0A	; 037FCAE4
loc_037FCAE6:
	ldr r4,[r4,#0x14]	; 037FCAE6
loc_037FCAE8:
	cmp r4,#0x0	; 037FCAE8
	bne loc_037FCAA4	; 037FCAEA
	mov r0,#0x0	; 037FCAEC
	str r0,[r5,#0x14]	; 037FCAEE
	ldr r0,[pool_037FCB18]	; 037FCAF0
	ldr r1,[r0,#0x4]	; 037FCAF2
	str r5,[r0,#0x4]	; 037FCAF4
	str r1,[r5,#0x10]	; 037FCAF6
	cmp r1,#0x0	; 037FCAF8
	beq loc_037FCB00	; 037FCAFA
	str r5,[r1,#0x14]	; 037FCAFC
	b loc_037FCB0A	; 037FCAFE
loc_037FCB00:
	str r5,[r0,#0x4]	; 037FCB00
	str r5,[r0,#0x0]	; 037FCB02
	add r0,r5,#0x0	; 037FCB04
	bl loc_037FCB60	; 037FCB06
loc_037FCB0A:
	add sp,#0x4	; 037FCB0A
	pop {r4,r5,r6,r7}	; 037FCB0C
	pop {r3}	; 037FCB0E
	bx r3	; 037FCB10
	.byte 0xC0, 0x46	; 037FCB14
pool_037FCB14:
loc_037FCB14:
	.word REG_VCOUNT	; 037FCB14
pool_037FCB18:
loc_037FCB18:
	.word P2_BssStart + 0x65C	; 037FCB18

; ===== function loc_037FCB1C =====
loc_037FCB1C:
	mov r1,#0x0	; 037FCB1C
	str r1,[r0,#0x0]	; 037FCB1E
	str r1,[r0,#0x8]	; 037FCB20
	str r1,[r0,#0x1c]	; 037FCB22
	bx lr	; 037FCB24
	.byte 0x00, 0x00	; 037FCB28

; ===== function loc_037FCB28 =====
loc_037FCB28:
	ldr r0,[pool_037FCB30]	; 037FCB28
	ldrh r0,[r0,#0x0]	; 037FCB2A
	bx lr	; 037FCB2C
	.byte 0xC0, 0x46	; 037FCB30
pool_037FCB30:
loc_037FCB30:
	.word P2_BssStart + 0x658	; 037FCB30

; ===== function loc_037FCB34 =====
loc_037FCB34:
	push {lr}	; 037FCB34
	sub sp,#0x4	; 037FCB36
	ldr r0,[pool_037FCB58]	; 037FCB38
	ldrh r1,[r0,#0x0]	; 037FCB3A
	cmp r1,#0x0	; 037FCB3C
	bne loc_037FCB52	; 037FCB3E
	mov r1,#0x1	; 037FCB40
	strh r1,[r0,#0x0]	; 037FCB42
	mov r1,#0x0	; 037FCB44
	ldr r0,[pool_037FCB5C]	; 037FCB46
	str r1,[r0,#0x0]	; 037FCB48
	str r1,[r0,#0x4]	; 037FCB4A
	mov r0,#0x4	; 037FCB4C
	bl loc_037FB570	; 037FCB4E
loc_037FCB52:
	add sp,#0x4	; 037FCB52
	pop {r3}	; 037FCB54
	bx r3	; 037FCB56
pool_037FCB58:
loc_037FCB58:
	.word P2_BssStart + 0x658	; 037FCB58
pool_037FCB5C:
loc_037FCB5C:
	.word P2_BssStart + 0x65C	; 037FCB5C

; ===== function loc_037FCB60 =====
loc_037FCB60:
	push {r4,lr}	; 037FCB60
	add r4,r0,#0x0	; 037FCB62
	ldr r1,[pool_037FCBB0]	; 037FCB64
	mov r0,#0x0	; 037FCB66
	ldrsh r1,[r1,r0]	; 037FCB68
	mov r0,#0xc	; 037FCB6A
	ldrsh r0,[r4,r0]	; 037FCB6C
	sub r0,r0,r1	; 037FCB6E
	bl loc_037FCBC0	; 037FCB70
	mov r0,#0x4	; 037FCB74
	ldr r1,[pool_037FCBB4]	; 037FCB76
	bl loc_037FB620	; 037FCB78
	mov r0,#0xc	; 037FCB7C
	ldrsh r0,[r4,r0]	; 037FCB7E
	ldr r1,[pool_037FCBB8]	; 037FCB80
	add r2,r0,#0x0	; 037FCB82
	and r2,r1	; 037FCB84
	asr r4,r2,#0x1	; 037FCB86
	ldr r2,[pool_037FCBBC]	; 037FCB88
	ldrh r3,[r2,#0x0]	; 037FCB8A
	mov r1,#0x3f	; 037FCB8C
	and r3,r1	; 037FCB8E
	mov r1,#0xff	; 037FCB90
	and r0,r1	; 037FCB92
	lsl r0,r0,#0x8	; 037FCB94
	orr r3,r0	; 037FCB96
	orr r4,r3	; 037FCB98
	strh r4,[r2,#0x0]	; 037FCB9A
	ldrh r1,[r2,#0x0]	; 037FCB9C
	mov r0,#0x20	; 037FCB9E
	orr r1,r0	; 037FCBA0
	strh r1,[r2,#0x0]	; 037FCBA2
	mov r0,#0x4	; 037FCBA4
	bl loc_037FB59C	; 037FCBA6
	pop {r4}	; 037FCBAA
	pop {r3}	; 037FCBAC
	bx r3	; 037FCBAE
pool_037FCBB0:
loc_037FCBB0:
	.word REG_VCOUNT	; 037FCBB0
pool_037FCBB4:
loc_037FCBB4:
	.word P2_IrqHandler_037FC828	; 037FCBB4
pool_037FCBB8:
loc_037FCBB8:
	.word 0x00000100	; 037FCBB8
pool_037FCBBC:
loc_037FCBBC:
	.word REG_DISPSTAT	; 037FCBBC

; ===== function loc_037FCBC0 =====
loc_037FCBC0:
	ldr r1,[pool_037FCBD8]	; 037FCBC0
	b loc_037FCBC6	; 037FCBC2
loc_037FCBC4:
	add r0,r0,r1	; 037FCBC4
loc_037FCBC6:
	cmp r0,#0x0	; 037FCBC6
	blt loc_037FCBC4	; 037FCBC8
	ldr r1,[pool_037FCBD8]	; 037FCBCA
	b loc_037FCBD0	; 037FCBCC
loc_037FCBCE:
	sub r0,r0,r1	; 037FCBCE
loc_037FCBD0:
	cmp r0,r1	; 037FCBD0
	bge loc_037FCBCE	; 037FCBD2
	bx lr	; 037FCBD4
	.byte 0xC0, 0x46	; 037FCBD8
pool_037FCBD8:
loc_037FCBD8:
	.word 0x00000107	; 037FCBD8
.arm

; ===== function loc_037FCBDC =====
loc_037FCBDC:
	mrs r0,cpsr	; 037FCBDC
	bic r1,r0,#0x80	; 037FCBE0
	msr cpsr_c,r1	; 037FCBE4
	and r0,r0,#0x80	; 037FCBE8
	bx lr	; 037FCBEC

; ===== function loc_037FCBF0 =====
loc_037FCBF0:
	mrs r0,cpsr	; 037FCBF0
	orr r1,r0,#0x80	; 037FCBF4
	msr cpsr_c,r1	; 037FCBF8
	and r0,r0,#0x80	; 037FCBFC
	bx lr	; 037FCC00

; ===== function loc_037FCC04 =====
loc_037FCC04:
	mrs r1,cpsr	; 037FCC04
	bic r2,r1,#0x80	; 037FCC08
	orr r2,r2,r0	; 037FCC0C
	msr cpsr_c,r2	; 037FCC10
	and r0,r1,#0x80	; 037FCC14
	bx lr	; 037FCC18

; ===== function loc_037FCC1C =====
loc_037FCC1C:
	mrs r0,cpsr	; 037FCC1C
	orr r1,r0,#0xc0	; 037FCC20
	msr cpsr_c,r1	; 037FCC24
	and r0,r0,#0xc0	; 037FCC28
	bx lr	; 037FCC2C

; ===== function loc_037FCC30 =====
loc_037FCC30:
	mrs r1,cpsr	; 037FCC30
	bic r2,r1,#0xc0	; 037FCC34
	orr r2,r2,r0	; 037FCC38
	msr cpsr_c,r2	; 037FCC3C
	and r0,r1,#0xc0	; 037FCC40
	bx lr	; 037FCC44

; ===== function loc_037FCC48 =====
loc_037FCC48:
	mrs r0,cpsr	; 037FCC48
	and r0,r0,#0x1f	; 037FCC4C
	bx lr	; 037FCC50
.thumb

; ===== function loc_037FCC54 =====
loc_037FCC54:
	push {r4,r5,r6,r7,lr}	; 037FCC54
	sub sp,#0x4	; 037FCC56
	add r6,r0,#0x0	; 037FCC58
	add r5,r1,#0x0	; 037FCC5A
	bl loc_037FB7EC	; 037FCC5C
	add r7,r0,#0x0	; 037FCC60
	ldr r1,[pool_037FCCAC]	; 037FCC62
	ldrh r4,[r1,#0x0]	; 037FCC64
	mov r0,#0x1	; 037FCC66
	strh r0,[r1,#0x0]	; 037FCC68
	cmp r6,#0x0	; 037FCC6A
	beq loc_037FCC84	; 037FCC6C
	ldr r1,[pool_037FCCB0]	; 037FCC6E
	ldr r0,[r1,#0x0]	; 037FCC70
	bic r0,r5	; 037FCC72
	str r0,[r1,#0x0]	; 037FCC74
	b loc_037FCC84	; 037FCC76
loc_037FCC78:
	bl loc_0380225E	; 037FCC78
	bl loc_037FAF8C	; 037FCC7C
	bl loc_037FB7EC	; 037FCC80
loc_037FCC84:
	ldr r1,[pool_037FCCB0]	; 037FCC84
	ldr r0,[r1,#0x0]	; 037FCC86
	add r2,r5,#0x0	; 037FCC88
	and r2,r0	; 037FCC8A
	cmp r2,#0x0	; 037FCC8C
	beq loc_037FCC78	; 037FCC8E
	ldr r0,[r1,#0x0]	; 037FCC90
	bic r0,r5	; 037FCC92
	str r0,[r1,#0x0]	; 037FCC94
	ldr r1,[pool_037FCCAC]	; 037FCC96
	ldrh r0,[r1,#0x0]	; 037FCC98
	strh r4,[r1,#0x0]	; 037FCC9A
	add r0,r7,#0x0	; 037FCC9C
	bl loc_037FB810	; 037FCC9E
	add sp,#0x4	; 037FCCA2
	pop {r4,r5,r6,r7}	; 037FCCA4
	pop {r3}	; 037FCCA6
	bx r3	; 037FCCA8
	.byte 0xC0, 0x46	; 037FCCAC
pool_037FCCAC:
loc_037FCCAC:
	.word REG_IME	; 037FCCAC
pool_037FCCB0:
loc_037FCCB0:
	.word Bios7IrqFlagsAddress	; 037FCCB0

; ===== function loc_037FCCB4 =====
loc_037FCCB4:
	lsr r0,r0,#0x2	; 037FCCB4
	ldr r3,[pool_037FCCBC]	; 037FCCB6
	bx r3	; 037FCCB8
	.byte 0xC0, 0x46	; 037FCCBC
pool_037FCCBC:
loc_037FCCBC:
	.word P2_SwiWaitByLoop + 1	; 037FCCBC

; ===== function loc_037FCCC0 =====
loc_037FCCC0:
	push {lr}	; 037FCCC0
	sub sp,#0x4	; 037FCCC2
loc_037FCCC4:
	bl loc_037FB7EC	; 037FCCC4
	bl loc_0380225E	; 037FCCC8
	b loc_037FCCC4	; 037FCCCC
	.byte 0x00, 0x00	; 037FCCD0

; ===== function loc_037FCCD0 =====
loc_037FCCD0:
	push {r4,lr}	; 037FCCD0
	add r4,r0,#0x0	; 037FCCD2
	bl loc_037FB7EC	; 037FCCD4
	mov r1,#0x6	; 037FCCD8
	mul r4,r1	; 037FCCDA
	add r1,r4,#0x5	; 037FCCDC
	lsl r2,r1,#0x1	; 037FCCDE
	ldr r1,[pool_037FCD04]	; 037FCCE0
	add r3,r2,r1	; 037FCCE2
	ldrh r2,[r3,#0x0]	; 037FCCE4
	ldr r1,[pool_037FCD08]	; 037FCCE6
	and r2,r1	; 037FCCE8
	strh r2,[r3,#0x0]	; 037FCCEA
	ldrh r2,[r3,#0x0]	; 037FCCEC
	ldr r1,[pool_037FCD0C]	; 037FCCEE
	and r2,r1	; 037FCCF0
	strh r2,[r3,#0x0]	; 037FCCF2
	ldrh r1,[r3,#0x0]	; 037FCCF4
	ldrh r1,[r3,#0x0]	; 037FCCF6
	bl loc_037FB810	; 037FCCF8
	pop {r4}	; 037FCCFC
	pop {r3}	; 037FCCFE
	bx r3	; 037FCD00
	.byte 0xC0, 0x46	; 037FCD04
pool_037FCD04:
loc_037FCD04:
	.word REG_DMA0SAD	; 037FCD04
pool_037FCD08:
loc_037FCD08:
	.word 0xFFFFCDFF	; 037FCD08
pool_037FCD0C:
loc_037FCD0C:
	.word 0xFFFF7FFF	; 037FCD0C
P2_Entry_037FCD10:
	mov r1,#0x3	; 037FCD10
	mul r0,r1	; 037FCD12
	add r0,r0,#0x2	; 037FCD14
	lsl r1,r0,#0x2	; 037FCD16
	ldr r0,[pool_037FCD28]	; 037FCD18
	add r2,r1,r0	; 037FCD1A
	ldr r0,[pool_037FCD2C]	; 037FCD1C
P2_Entry_037FCD1E:
	ldr r1,[r2,#0x0]	; 037FCD1E
	and r1,r0	; 037FCD20
	cmp r1,#0x0	; 037FCD22
	bne P2_Entry_037FCD1E	; 037FCD24
	bx lr	; 037FCD26
pool_037FCD28:
	.word REG_DMA0SAD	; 037FCD28
pool_037FCD2C:
	.word 0x80000000	; 037FCD2C
P2_Entry_037FCD30:
	push {r4,r5,r6,r7,lr}	; 037FCD30
	sub sp,#0x4	; 037FCD32
	add r5,r0,#0x0	; 037FCD34
	add r6,r1,#0x0	; 037FCD36
	add r7,r2,#0x0	; 037FCD38
	str r3,[sp,#0x0]	; 037FCD3A
	cmp r3,#0x0	; 037FCD3C
	beq P2_Entry_037FCD82	; 037FCD3E
	mov r0,#0x3	; 037FCD40
	add r1,r5,#0x0	; 037FCD42
	mul r1,r0	; 037FCD44
	add r0,r1,#0x2	; 037FCD46
	lsl r1,r0,#0x2	; 037FCD48
	ldr r0,[pool_037FCD8C]	; 037FCD4A
	add r4,r1,r0	; 037FCD4C
	ldr r0,[pool_037FCD90]	; 037FCD4E
P2_Entry_037FCD50:
	ldr r1,[r4,#0x0]	; 037FCD50
	and r1,r0	; 037FCD52
	cmp r1,#0x0	; 037FCD54
	bne P2_Entry_037FCD50	; 037FCD56
	bl loc_037FB7EC	; 037FCD58
	mov r1,#0xc	; 037FCD5C
	mul r5,r1	; 037FCD5E
	ldr r1,[pool_037FCD8C]	; 037FCD60
	add r2,r5,r1	; 037FCD62
	str r6,[r2,#0x0]	; 037FCD64
	str r7,[r2,#0x4]	; 037FCD66
	ldr r3,[sp,#0x0]	; 037FCD68
	lsr r5,r3,#0x1	; 037FCD6A
	ldr r3,[pool_037FCD90]	; 037FCD6C
	orr r5,r3	; 037FCD6E
	str r5,[r2,#0x8]	; 037FCD70
	ldr r1,[r1,#0x0]	; 037FCD72
	bl loc_037FB810	; 037FCD74
	ldr r0,[pool_037FCD90]	; 037FCD78
P2_Entry_037FCD7A:
	ldr r1,[r4,#0x0]	; 037FCD7A
	and r1,r0	; 037FCD7C
	cmp r1,#0x0	; 037FCD7E
	bne P2_Entry_037FCD7A	; 037FCD80
P2_Entry_037FCD82:
	add sp,#0x4	; 037FCD82
	pop {r4,r5,r6,r7}	; 037FCD84
	pop {r3}	; 037FCD86
	bx r3	; 037FCD88
	.byte 0xC0, 0x46	; 037FCD8A
pool_037FCD8C:
	.word REG_DMA0SAD	; 037FCD8C
pool_037FCD90:
	.word 0x80000000	; 037FCD90
P2_Entry_037FCD94:
	push {r4,r5,r6,r7,lr}	; 037FCD94
	sub sp,#0x4	; 037FCD96
	add r5,r0,#0x0	; 037FCD98
	add r7,r1,#0x0	; 037FCD9A
	str r3,[sp,#0x0]	; 037FCD9C
	cmp r3,#0x0	; 037FCD9E
	beq P2_Entry_037FCDEC	; 037FCDA0
	mov r0,#0x3	; 037FCDA2
	add r1,r5,#0x0	; 037FCDA4
	mul r1,r0	; 037FCDA6
	add r0,r1,#0x2	; 037FCDA8
	lsl r1,r0,#0x2	; 037FCDAA
	ldr r0,[pool_037FCDF4]	; 037FCDAC
	add r4,r1,r0	; 037FCDAE
	ldr r0,[pool_037FCDF8]	; 037FCDB0
P2_Entry_037FCDB2:
	ldr r1,[r4,#0x0]	; 037FCDB2
	and r1,r0	; 037FCDB4
	cmp r1,#0x0	; 037FCDB6
	bne P2_Entry_037FCDB2	; 037FCDB8
	lsl r1,r5,#0x2	; 037FCDBA
	ldr r0,[pool_037FCDFC]	; 037FCDBC
	add r6,r1,r0	; 037FCDBE
	str r2,[r6,#0x0]	; 037FCDC0
	bl loc_037FB7EC	; 037FCDC2
	mov r1,#0xc	; 037FCDC6
	mul r5,r1	; 037FCDC8
	ldr r1,[pool_037FCDF4]	; 037FCDCA
	add r2,r5,r1	; 037FCDCC
	str r6,[r2,#0x0]	; 037FCDCE
	str r7,[r2,#0x4]	; 037FCDD0
	ldr r3,[sp,#0x0]	; 037FCDD2
	lsr r5,r3,#0x1	; 037FCDD4
	ldr r3,[pool_037FCE00]	; 037FCDD6
	orr r5,r3	; 037FCDD8
	str r5,[r2,#0x8]	; 037FCDDA
	ldr r1,[r1,#0x0]	; 037FCDDC
	bl loc_037FB810	; 037FCDDE
	ldr r0,[pool_037FCDF8]	; 037FCDE2
P2_Entry_037FCDE4:
	ldr r1,[r4,#0x0]	; 037FCDE4
	and r1,r0	; 037FCDE6
	cmp r1,#0x0	; 037FCDE8
	bne P2_Entry_037FCDE4	; 037FCDEA
P2_Entry_037FCDEC:
	add sp,#0x4	; 037FCDEC
	pop {r4,r5,r6,r7}	; 037FCDEE
	pop {r3}	; 037FCDF0
	bx r3	; 037FCDF2
pool_037FCDF4:
	.word REG_DMA0SAD	; 037FCDF4
pool_037FCDF8:
	.word 0x80000000	; 037FCDF8
pool_037FCDFC:
	.word 0x0380FFE0	; 037FCDFC
pool_037FCE00:
	.word 0x81000000	; 037FCE00
.arm

; ===== function loc_037FCE04 =====
loc_037FCE04:
	mov r3,#0x0	; 037FCE04
loc_037FCE08:
	cmp r3,r2	; 037FCE08
	strlth r0,[r1,r3]	; 037FCE0C
	addlt r3,r3,#0x2	; 037FCE10
	blt loc_037FCE08	; 037FCE14
	bx lr	; 037FCE18
P2_Entry_037FCE1C:
	mov r12,#0x0	; 037FCE1C
P2_Entry_037FCE20:
	cmp r12,r2	; 037FCE20
	ldrlth r3,[r0,r12]	; 037FCE24
	strlth r3,[r1,r12]	; 037FCE28
	addlt r12,r12,#0x2	; 037FCE2C
	blt P2_Entry_037FCE20	; 037FCE30
	bx lr	; 037FCE34

; ===== function loc_037FCE38 =====
loc_037FCE38:
	add r12,r1,r2	; 037FCE38
loc_037FCE3C:
	cmp r1,r12	; 037FCE3C
	stmltia r1!,{r0}	; 037FCE40
	blt loc_037FCE3C	; 037FCE44
	bx lr	; 037FCE48

; ===== function loc_037FCE4C =====
loc_037FCE4C:
	add r12,r1,r2	; 037FCE4C
loc_037FCE50:
	cmp r1,r12	; 037FCE50
	ldmltia r0!,{r2}	; 037FCE54
	stmltia r1!,{r2}	; 037FCE58
	blt loc_037FCE50	; 037FCE5C
	bx lr	; 037FCE60
P2_Entry_037FCE64:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 037FCE64
	add r9,r1,r2	; 037FCE68
	mov r12,r2, lsr #0x5	; 037FCE6C
	add r12,r1,r12, lsl #0x5	; 037FCE70
	mov r2,r0	; 037FCE74
	mov r3,r2	; 037FCE78
	mov r4,r2	; 037FCE7C
	mov r5,r2	; 037FCE80
	mov r6,r2	; 037FCE84
	mov r7,r2	; 037FCE88
	mov r8,r2	; 037FCE8C
P2_Entry_037FCE90:
	cmp r1,r12	; 037FCE90
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 037FCE94
	blt P2_Entry_037FCE90	; 037FCE98
P2_Entry_037FCE9C:
	cmp r1,r9	; 037FCE9C
	stmltia r1!,{r0}	; 037FCEA0
	blt P2_Entry_037FCE9C	; 037FCEA4
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 037FCEA8
	bx lr	; 037FCEAC

; ===== function loc_037FCEB0 =====
loc_037FCEB0:
	mov r12,#0x0	; 037FCEB0
loc_037FCEB4:
	cmp r12,r2	; 037FCEB4
	strltb r1,[r0,r12]	; 037FCEB8
	addlt r12,r12,#0x1	; 037FCEBC
	blt loc_037FCEB4	; 037FCEC0
	bx lr	; 037FCEC4
P2_Entry_037FCEC8:
	mov r12,#0x0	; 037FCEC8
P2_Entry_037FCECC:
	cmp r12,r2	; 037FCECC
	ldrltb r3,[r0,r12]	; 037FCED0
	strltb r3,[r1,r12]	; 037FCED4
	addlt r12,r12,#0x1	; 037FCED8
	blt P2_Entry_037FCECC	; 037FCEDC
	bx lr	; 037FCEE0

; ===== function loc_037FCEE4 =====
loc_037FCEE4:
	swp r0,r0,[r1]	; 037FCEE4
	bx lr	; 037FCEE8
.thumb

; ===== function loc_037FCEEC =====
loc_037FCEEC:
	push {r4,r5,r6,lr}	; 037FCEEC
	ldr r4,[pool_037FCF1C]	; 037FCEEE
	ldrb r5,[r4,#0x0]	; 037FCEF0
	mov r4,#0x80	; 037FCEF2
	and r5,r4	; 037FCEF4
	cmp r5,#0x0	; 037FCEF6
	beq loc_037FCEFE	; 037FCEF8
	mov r6,#0x1	; 037FCEFA
	b loc_037FCF00	; 037FCEFC
loc_037FCEFE:
	mov r6,#0x0	; 037FCEFE
loc_037FCF00:
	lsl r5,r1,#0x2	; 037FCF00
	lsl r4,r2,#0x4	; 037FCF02
	lsl r2,r6,#0x7	; 037FCF04
	lsl r1,r3,#0x5	; 037FCF06
	orr r2,r1	; 037FCF08
	orr r4,r2	; 037FCF0A
	orr r5,r4	; 037FCF0C
	orr r0,r5	; 037FCF0E
	ldr r1,[pool_037FCF1C]	; 037FCF10
	strb r0,[r1,#0x0]	; 037FCF12
	pop {r4,r5,r6}	; 037FCF14
	pop {r3}	; 037FCF16
	bx r3	; 037FCF18
	.byte 0xC0, 0x46	; 037FCF1C
pool_037FCF1C:
loc_037FCF1C:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FCF1C

; ===== function loc_037FCF20 =====
loc_037FCF20:
	ldr r1,[pool_037FCF28]	; 037FCF20
	strb r0,[r1,#0x0]	; 037FCF22
	bx lr	; 037FCF24
	.byte 0xC0, 0x46	; 037FCF28
pool_037FCF28:
loc_037FCF28:
	.word REG_SOUNDCNT_ARM7	; 037FCF28
P2_Entry_037FCF2C:
	push {lr}	; 037FCF2C
	sub sp,#0x4	; 037FCF2E
	ldr r2,[pool_037FCF54]	; 037FCF30
	ldrh r1,[r2,#0x0]	; 037FCF32
	mov r0,#0x1	; 037FCF34
	orr r1,r0	; 037FCF36
	strh r1,[r2,#0x0]	; 037FCF38
	bl loc_03801D98	; 037FCF3A
	ldr r0,[pool_037FCF58]	; 037FCF3E
	bl P2_SwiSoundBiasIncrease	; 037FCF40
	ldr r0,[pool_037FCF5C]	; 037FCF44
	bl loc_037FCCB4	; 037FCF46
	bl P2_Entry_037FCFA4	; 037FCF4A
	add sp,#0x4	; 037FCF4E
	pop {r3}	; 037FCF50
	bx r3	; 037FCF52
pool_037FCF54:
	.word REG_POWERCNT_ARM7	; 037FCF54
pool_037FCF58:
	.word 0x00000100	; 037FCF58
pool_037FCF5C:
	.word 0x0007AB80	; 037FCF5C
P2_Entry_037FCF60:
	push {lr}	; 037FCF60
	sub sp,#0x4	; 037FCF62
	bl P2_Entry_037FCF94	; 037FCF64
	mov r0,#0x80	; 037FCF68
	bl P2_SwiSoundBiasDecrease	; 037FCF6A
	ldr r0,[pool_037FCF8C]	; 037FCF6E
	bl loc_037FCCB4	; 037FCF70
	mov r0,#0x1	; 037FCF74
	bl loc_03801D7C	; 037FCF76
	ldr r2,[pool_037FCF90]	; 037FCF7A
	ldrh r1,[r2,#0x0]	; 037FCF7C
	mov r0,#0x1	; 037FCF7E
	bic r1,r0	; 037FCF80
	strh r1,[r2,#0x0]	; 037FCF82
	add sp,#0x4	; 037FCF84
	pop {r3}	; 037FCF86
	bx r3	; 037FCF88
	.byte 0xC0, 0x46	; 037FCF8A
pool_037FCF8C:
	.word 0x00040000	; 037FCF8C
pool_037FCF90:
	.word REG_POWERCNT_ARM7	; 037FCF90
P2_Entry_037FCF94:
	ldr r2,[pool_037FCFA0]	; 037FCF94
	ldrb r1,[r2,#0x0]	; 037FCF96
	mov r0,#0x80	; 037FCF98
	bic r1,r0	; 037FCF9A
	strb r1,[r2,#0x0]	; 037FCF9C
	bx lr	; 037FCF9E
pool_037FCFA0:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FCFA0
P2_Entry_037FCFA4:
	ldr r2,[pool_037FCFB0]	; 037FCFA4
	ldrb r1,[r2,#0x0]	; 037FCFA6
	mov r0,#0x80	; 037FCFA8
	orr r1,r0	; 037FCFAA
	strb r1,[r2,#0x0]	; 037FCFAC
	bx lr	; 037FCFAE
pool_037FCFB0:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FCFB0

; ===== function loc_037FCFB4 =====
loc_037FCFB4:
	push {r4,lr}	; 037FCFB4
	cmp r1,#0x18	; 037FCFB6
	bge loc_037FCFD0	; 037FCFB8
	ldr r2,[pool_037FCFF0]	; 037FCFBA
	ldr r3,[r2,#0x0]	; 037FCFBC
	ldr r2,[pool_037FCFF4]	; 037FCFBE
	sub r2,r2,r3	; 037FCFC0
	lsl r2,r2,#0x6	; 037FCFC2
	add r1,#0x28	; 037FCFC4
	mul r3,r1	; 037FCFC6
	add r1,r2,r3	; 037FCFC8
	mul r0,r1	; 037FCFCA
	asr r0,r0,#0x15	; 037FCFCC
	b loc_037FCFEA	; 037FCFCE
loc_037FCFD0:
	cmp r1,#0x68	; 037FCFD0
	ble loc_037FCFEA	; 037FCFD2
	ldr r2,[pool_037FCFF0]	; 037FCFD4
	ldr r4,[r2,#0x0]	; 037FCFD6
	ldr r2,[pool_037FCFF4]	; 037FCFD8
	add r2,r4,r2	; 037FCFDA
	lsl r3,r2,#0x6	; 037FCFDC
	neg r2,r4	; 037FCFDE
	sub r1,#0x28	; 037FCFE0
	mul r2,r1	; 037FCFE2
	add r1,r3,r2	; 037FCFE4
	mul r0,r1	; 037FCFE6
	asr r0,r0,#0x15	; 037FCFE8
loc_037FCFEA:
	pop {r4}	; 037FCFEA
	pop {r3}	; 037FCFEC
	bx r3	; 037FCFEE
pool_037FCFF0:
loc_037FCFF0:
	.word P2_BssStart + 0x664	; 037FCFF0
pool_037FCFF4:
loc_037FCFF4:
	.word 0x00007FFF	; 037FCFF4

; ===== function loc_037FCFF8 =====
loc_037FCFF8:
	push {r4,r5,r6,r7,lr}	; 037FCFF8
	sub sp,#0x4	; 037FCFFA
	ldr r1,[pool_037FD030]	; 037FCFFC
	str r0,[r1,#0x0]	; 037FCFFE
	mov r5,#0x0	; 037FD000
	ldr r6,[pool_037FD034]	; 037FD002
	ldr r7,[pool_037FD038]	; 037FD004
loc_037FD006:
	mov r0,#0x1	; 037FD006
	lsl r0,r5	; 037FD008
	and r0,r7	; 037FD00A
	cmp r0,#0x0	; 037FD00C
	beq loc_037FD020	; 037FD00E
	lsl r4,r5,#0x4	; 037FD010
	ldr r0,[pool_037FD03C]	; 037FD012
	ldrb r1,[r4,r0]	; 037FD014
	ldrb r0,[r6,r5]	; 037FD016
	bl loc_037FCFB4	; 037FD018
	ldr r1,[pool_037FD040]	; 037FD01C
	strb r0,[r4,r1]	; 037FD01E
loc_037FD020:
	add r5,r5,#0x1	; 037FD020
	cmp r5,#0x10	; 037FD022
	blt loc_037FD006	; 037FD024
	add sp,#0x4	; 037FD026
	pop {r4,r5,r6,r7}	; 037FD028
	pop {r3}	; 037FD02A
	bx r3	; 037FD02C
	.byte 0xC0, 0x46	; 037FD030
pool_037FD030:
loc_037FD030:
	.word P2_BssStart + 0x664	; 037FD030
pool_037FD034:
loc_037FD034:
	.word 0x03803370	; 037FD034
pool_037FD038:
loc_037FD038:
	.word 0x0000FFF5	; 037FD038
pool_037FD03C:
loc_037FD03C:
	.word SCHANNEL0_PAN	; 037FD03C
pool_037FD040:
loc_037FD040:
	.word SCHANNEL0_CR	; 037FD040

; ===== function loc_037FD044 =====
loc_037FD044:
	lsl r1,r0,#0x4	; 037FD044
	ldr r0,[pool_037FD05C]	; 037FD046
	ldrb r1,[r1,r0]	; 037FD048
	mov r0,#0x80	; 037FD04A
	and r1,r0	; 037FD04C
	cmp r1,#0x0	; 037FD04E
	beq loc_037FD056	; 037FD050
	mov r0,#0x1	; 037FD052
	bx lr	; 037FD054
loc_037FD056:
	mov r0,#0x0	; 037FD056
	bx lr	; 037FD058
	.byte 0xC0, 0x46	; 037FD05C
pool_037FD05C:
loc_037FD05C:
	.word SCHANNEL0_CR + 3	; 037FD05C

; ===== function loc_037FD060 =====
loc_037FD060:
	push {r4,lr}	; 037FD060
	lsl r4,r0,#0x4	; 037FD062
	ldr r2,[pool_037FD090]	; 037FD064
	strb r1,[r4,r2]	; 037FD066
	ldr r2,[pool_037FD094]	; 037FD068
	ldr r2,[r2,#0x0]	; 037FD06A
	cmp r2,#0x0	; 037FD06C
	ble loc_037FD088	; 037FD06E
	mov r3,#0x1	; 037FD070
	lsl r3,r0	; 037FD072
	ldr r2,[pool_037FD098]	; 037FD074
	and r3,r2	; 037FD076
	cmp r3,#0x0	; 037FD078
	beq loc_037FD088	; 037FD07A
	ldr r2,[pool_037FD09C]	; 037FD07C
	ldrb r0,[r2,r0]	; 037FD07E
	bl loc_037FCFB4	; 037FD080
	ldr r1,[pool_037FD0A0]	; 037FD084
	strb r0,[r4,r1]	; 037FD086
loc_037FD088:
	pop {r4}	; 037FD088
	pop {r3}	; 037FD08A
	bx r3	; 037FD08C
	.byte 0xC0, 0x46	; 037FD090
pool_037FD090:
loc_037FD090:
	.word SCHANNEL0_PAN	; 037FD090
pool_037FD094:
loc_037FD094:
	.word P2_BssStart + 0x664	; 037FD094
pool_037FD098:
loc_037FD098:
	.word 0x0000FFF5	; 037FD098
pool_037FD09C:
loc_037FD09C:
	.word P2_BssStart + 0x668	; 037FD09C
pool_037FD0A0:
loc_037FD0A0:
	.word SCHANNEL0_CR	; 037FD0A0

; ===== function loc_037FD0A4 =====
loc_037FD0A4:
	ldr r2,[pool_037FD0B0]	; 037FD0A4
	sub r2,r2,r1	; 037FD0A6
	lsl r1,r0,#0x4	; 037FD0A8
	ldr r0,[pool_037FD0B4]	; 037FD0AA
	strh r2,[r1,r0]	; 037FD0AC
	bx lr	; 037FD0AE
pool_037FD0B0:
loc_037FD0B0:
	.word 0x00010000	; 037FD0B0
pool_037FD0B4:
loc_037FD0B4:
	.word SCHANNEL0_TIMER	; 037FD0B4

; ===== function loc_037FD0B8 =====
loc_037FD0B8:
	push {r4,r5,lr}	; 037FD0B8
	sub sp,#0x4	; 037FD0BA
	add r5,r0,#0x0	; 037FD0BC
	add r4,r2,#0x0	; 037FD0BE
	ldr r0,[pool_037FD0FC]	; 037FD0C0
	strb r1,[r0,r5]	; 037FD0C2
	ldr r0,[pool_037FD100]	; 037FD0C4
	ldr r0,[r0,#0x0]	; 037FD0C6
	cmp r0,#0x0	; 037FD0C8
	ble loc_037FD0E8	; 037FD0CA
	mov r2,#0x1	; 037FD0CC
	lsl r2,r5	; 037FD0CE
	ldr r0,[pool_037FD104]	; 037FD0D0
	and r2,r0	; 037FD0D2
	cmp r2,#0x0	; 037FD0D4
	beq loc_037FD0E8	; 037FD0D6
	lsl r2,r5,#0x4	; 037FD0D8
	ldr r0,[pool_037FD108]	; 037FD0DA
	ldrb r2,[r2,r0]	; 037FD0DC
	add r0,r1,#0x0	; 037FD0DE
	add r1,r2,#0x0	; 037FD0E0
	bl loc_037FCFB4	; 037FD0E2
	add r1,r0,#0x0	; 037FD0E6
loc_037FD0E8:
	lsl r2,r4,#0x8	; 037FD0E8
	orr r2,r1	; 037FD0EA
	lsl r1,r5,#0x4	; 037FD0EC
	ldr r0,[pool_037FD10C]	; 037FD0EE
	strh r2,[r1,r0]	; 037FD0F0
	add sp,#0x4	; 037FD0F2
	pop {r4,r5}	; 037FD0F4
	pop {r3}	; 037FD0F6
	bx r3	; 037FD0F8
	.byte 0xC0, 0x46	; 037FD0FC
pool_037FD0FC:
loc_037FD0FC:
	.word P2_BssStart + 0x668	; 037FD0FC
pool_037FD100:
loc_037FD100:
	.word P2_BssStart + 0x664	; 037FD100
pool_037FD104:
loc_037FD104:
	.word 0x0000FFF5	; 037FD104
pool_037FD108:
loc_037FD108:
	.word SCHANNEL0_PAN	; 037FD108
pool_037FD10C:
loc_037FD10C:
	.word SCHANNEL0_CR	; 037FD10C

; ===== function loc_037FD110 =====
loc_037FD110:
	lsl r2,r0,#0x4	; 037FD110
	ldr r0,[pool_037FD12C]	; 037FD112
	add r3,r2,r0	; 037FD114
	ldr r2,[r3,#0x0]	; 037FD116
	ldr r0,[pool_037FD130]	; 037FD118
	and r2,r0	; 037FD11A
	mov r0,#0x1	; 037FD11C
	and r1,r0	; 037FD11E
	cmp r1,#0x0	; 037FD120
	beq loc_037FD128	; 037FD122
	ldr r0,[pool_037FD134]	; 037FD124
	orr r2,r0	; 037FD126
loc_037FD128:
	str r2,[r3,#0x0]	; 037FD128
	bx lr	; 037FD12A
pool_037FD12C:
loc_037FD12C:
	.word SCHANNEL0_CR	; 037FD12C
pool_037FD130:
loc_037FD130:
	.word 0x7FFFFFFF	; 037FD130
pool_037FD134:
loc_037FD134:
	.word 0x00008000	; 037FD134

; ===== function loc_037FD138 =====
loc_037FD138:
	push {r4,r5,r6,lr}	; 037FD138
	add r5,r2,#0x0	; 037FD13A
	add r6,r3,#0x0	; 037FD13C
	lsl r4,r0,#0x4	; 037FD13E
	ldr r2,[pool_037FD184]	; 037FD140
	strb r1,[r2,r0]	; 037FD142
	ldr r2,[pool_037FD188]	; 037FD144
	ldr r2,[r2,#0x0]	; 037FD146
	cmp r2,#0x0	; 037FD148
	ble loc_037FD162	; 037FD14A
	mov r2,#0x1	; 037FD14C
	lsl r2,r0	; 037FD14E
	ldr r0,[pool_037FD18C]	; 037FD150
	and r2,r0	; 037FD152
	cmp r2,#0x0	; 037FD154
	beq loc_037FD162	; 037FD156
	add r0,r1,#0x0	; 037FD158
	ldr r1,[sp,#0x10]	; 037FD15A
	bl loc_037FCFB4	; 037FD15C
	add r1,r0,#0x0	; 037FD160
loc_037FD162:
	ldr r0,[sp,#0x10]	; 037FD162
	lsl r2,r0,#0x10	; 037FD164
	ldr r0,[pool_037FD190]	; 037FD166
	orr r2,r0	; 037FD168
	lsl r0,r5,#0x8	; 037FD16A
	orr r2,r0	; 037FD16C
	orr r1,r2	; 037FD16E
	ldr r0,[pool_037FD194]	; 037FD170
	str r1,[r4,r0]	; 037FD172
	ldr r0,[pool_037FD198]	; 037FD174
	sub r1,r0,r6	; 037FD176
	ldr r0,[pool_037FD19C]	; 037FD178
	strh r1,[r4,r0]	; 037FD17A
	pop {r4,r5,r6}	; 037FD17C
	pop {r3}	; 037FD17E
	bx r3	; 037FD180
	.byte 0xC0, 0x46	; 037FD184
pool_037FD184:
loc_037FD184:
	.word P2_BssStart + 0x668	; 037FD184
pool_037FD188:
loc_037FD188:
	.word P2_BssStart + 0x664	; 037FD188
pool_037FD18C:
loc_037FD18C:
	.word 0x0000FFF5	; 037FD18C
pool_037FD190:
loc_037FD190:
	.word 0x60000000	; 037FD190
pool_037FD194:
loc_037FD194:
	.word SCHANNEL0_CR	; 037FD194
pool_037FD198:
loc_037FD198:
	.word 0x00010000	; 037FD198
pool_037FD19C:
loc_037FD19C:
	.word SCHANNEL0_TIMER	; 037FD19C

; ===== function loc_037FD1A0 =====
loc_037FD1A0:
	push {r4,r5,r6,lr}	; 037FD1A0
	add r5,r1,#0x0	; 037FD1A2
	add r6,r3,#0x0	; 037FD1A4
	lsl r4,r0,#0x4	; 037FD1A6
	ldr r1,[pool_037FD1F0]	; 037FD1A8
	strb r2,[r1,r0]	; 037FD1AA
	ldr r1,[pool_037FD1F4]	; 037FD1AC
	ldr r1,[r1,#0x0]	; 037FD1AE
	cmp r1,#0x0	; 037FD1B0
	ble loc_037FD1CA	; 037FD1B2
	mov r1,#0x1	; 037FD1B4
	lsl r1,r0	; 037FD1B6
	ldr r0,[pool_037FD1F8]	; 037FD1B8
	and r1,r0	; 037FD1BA
	cmp r1,#0x0	; 037FD1BC
	beq loc_037FD1CA	; 037FD1BE
	add r0,r2,#0x0	; 037FD1C0
	ldr r1,[sp,#0x14]	; 037FD1C2
	bl loc_037FCFB4	; 037FD1C4
	add r2,r0,#0x0	; 037FD1C8
loc_037FD1CA:
	lsl r0,r6,#0x8	; 037FD1CA
	lsl r3,r5,#0x18	; 037FD1CC
	ldr r1,[pool_037FD1FC]	; 037FD1CE
	orr r3,r1	; 037FD1D0
	ldr r1,[sp,#0x14]	; 037FD1D2
	lsl r1,r1,#0x10	; 037FD1D4
	orr r3,r1	; 037FD1D6
	orr r0,r3	; 037FD1D8
	orr r2,r0	; 037FD1DA
	ldr r0,[pool_037FD200]	; 037FD1DC
	str r2,[r4,r0]	; 037FD1DE
	ldr r1,[sp,#0x10]	; 037FD1E0
	ldr r0,[pool_037FD204]	; 037FD1E2
	sub r1,r0,r1	; 037FD1E4
	ldr r0,[pool_037FD208]	; 037FD1E6
	strh r1,[r4,r0]	; 037FD1E8
	pop {r4,r5,r6}	; 037FD1EA
	pop {r3}	; 037FD1EC
	bx r3	; 037FD1EE
pool_037FD1F0:
loc_037FD1F0:
	.word P2_BssStart + 0x668	; 037FD1F0
pool_037FD1F4:
loc_037FD1F4:
	.word P2_BssStart + 0x664	; 037FD1F4
pool_037FD1F8:
loc_037FD1F8:
	.word 0x0000FFF5	; 037FD1F8
pool_037FD1FC:
loc_037FD1FC:
	.word 0x60000000	; 037FD1FC
pool_037FD200:
loc_037FD200:
	.word SCHANNEL0_CR	; 037FD200
pool_037FD204:
loc_037FD204:
	.word 0x00010000	; 037FD204
pool_037FD208:
loc_037FD208:
	.word SCHANNEL0_TIMER	; 037FD208

; ===== function loc_037FD20C =====
loc_037FD20C:
	push {r4,r5,r6,r7,lr}	; 037FD20C
	sub sp,#0x4	; 037FD20E
	add r5,r1,#0x0	; 037FD210
	add r6,r2,#0x0	; 037FD212
	add r7,r3,#0x0	; 037FD214
	ldr r1,[sp,#0x20]	; 037FD216
	lsl r4,r0,#0x4	; 037FD218
	ldr r2,[pool_037FD278]	; 037FD21A
	strb r1,[r2,r0]	; 037FD21C
	ldr r2,[pool_037FD27C]	; 037FD21E
	ldr r2,[r2,#0x0]	; 037FD220
	cmp r2,#0x0	; 037FD222
	ble loc_037FD23C	; 037FD224
	mov r2,#0x1	; 037FD226
	lsl r2,r0	; 037FD228
	ldr r0,[pool_037FD280]	; 037FD22A
	and r2,r0	; 037FD22C
	cmp r2,#0x0	; 037FD22E
	beq loc_037FD23C	; 037FD230
	add r0,r1,#0x0	; 037FD232
	ldr r1,[sp,#0x2c]	; 037FD234
	bl loc_037FCFB4	; 037FD236
	add r1,r0,#0x0	; 037FD23A
loc_037FD23C:
	ldr r0,[sp,#0x24]	; 037FD23C
	lsl r2,r0,#0x8	; 037FD23E
	ldr r0,[sp,#0x2c]	; 037FD240
	lsl r0,r0,#0x10	; 037FD242
	lsl r3,r6,#0x1d	; 037FD244
	lsl r6,r7,#0x1b	; 037FD246
	orr r3,r6	; 037FD248
	orr r0,r3	; 037FD24A
	orr r2,r0	; 037FD24C
	orr r1,r2	; 037FD24E
	ldr r0,[pool_037FD284]	; 037FD250
	str r1,[r4,r0]	; 037FD252
	ldr r1,[sp,#0x28]	; 037FD254
	ldr r0,[pool_037FD288]	; 037FD256
	sub r1,r0,r1	; 037FD258
	ldr r0,[pool_037FD28C]	; 037FD25A
	strh r1,[r4,r0]	; 037FD25C
	ldr r1,[sp,#0x18]	; 037FD25E
	ldr r0,[pool_037FD290]	; 037FD260
	strh r1,[r4,r0]	; 037FD262
	ldr r1,[sp,#0x1c]	; 037FD264
	ldr r0,[pool_037FD294]	; 037FD266
	str r1,[r4,r0]	; 037FD268
	ldr r0,[pool_037FD298]	; 037FD26A
	str r5,[r4,r0]	; 037FD26C
	add sp,#0x4	; 037FD26E
	pop {r4,r5,r6,r7}	; 037FD270
	pop {r3}	; 037FD272
	bx r3	; 037FD274
	.byte 0xC0, 0x46	; 037FD278
pool_037FD278:
loc_037FD278:
	.word P2_BssStart + 0x668	; 037FD278
pool_037FD27C:
loc_037FD27C:
	.word P2_BssStart + 0x664	; 037FD27C
pool_037FD280:
loc_037FD280:
	.word 0x0000FFF5	; 037FD280
pool_037FD284:
loc_037FD284:
	.word SCHANNEL0_CR	; 037FD284
pool_037FD288:
loc_037FD288:
	.word 0x00010000	; 037FD288
pool_037FD28C:
loc_037FD28C:
	.word SCHANNEL0_TIMER	; 037FD28C
pool_037FD290:
loc_037FD290:
	.word SCHANNEL0_PNT	; 037FD290
pool_037FD294:
loc_037FD294:
	.word SCHANNEL0_LEN	; 037FD294
pool_037FD298:
loc_037FD298:
	.word SCHANNEL0_SAD	; 037FD298

; ===== function loc_037FD29C =====
loc_037FD29C:
	ldr r1,[pool_037FD2B4]	; 037FD29C
	ldr r2,[r1,#0x0]	; 037FD29E
	ldr r0,[pool_037FD2B8]	; 037FD2A0
	mul r2,r0	; 037FD2A2
	ldr r0,[pool_037FD2BC]	; 037FD2A4
	add r0,r2,r0	; 037FD2A6
	str r0,[r1,#0x0]	; 037FD2A8
	lsr r0,r0,#0x10	; 037FD2AA
	lsl r0,r0,#0x10	; 037FD2AC
	lsr r0,r0,#0x10	; 037FD2AE
	bx lr	; 037FD2B0
	.byte 0xC0, 0x46	; 037FD2B4
pool_037FD2B4:
loc_037FD2B4:
	.word P2_Data_03802C4C	; 037FD2B4
pool_037FD2B8:
loc_037FD2B8:
	.word 0x0019660D	; 037FD2B8
pool_037FD2BC:
loc_037FD2BC:
	.word 0x3C6EF35F	; 037FD2BC

; ===== function loc_037FD2C0 =====
loc_037FD2C0:
	cmp r0,#0x20	; 037FD2C0
	bge loc_037FD2CA	; 037FD2C2
	ldr r1,[pool_037FD2FC]	; 037FD2C4
	ldrsb r0,[r1,r0]	; 037FD2C6
	bx lr	; 037FD2C8
loc_037FD2CA:
	cmp r0,#0x40	; 037FD2CA
	bge loc_037FD2D8	; 037FD2CC
	mov r1,#0x40	; 037FD2CE
	sub r1,r1,r0	; 037FD2D0
	ldr r0,[pool_037FD2FC]	; 037FD2D2
	ldrsb r0,[r0,r1]	; 037FD2D4
	bx lr	; 037FD2D6
loc_037FD2D8:
	cmp r0,#0x60	; 037FD2D8
	bge loc_037FD2EA	; 037FD2DA
	sub r0,#0x40	; 037FD2DC
	ldr r1,[pool_037FD2FC]	; 037FD2DE
	ldrsb r0,[r1,r0]	; 037FD2E0
	neg r0,r0	; 037FD2E2
	lsl r0,r0,#0x18	; 037FD2E4
	asr r0,r0,#0x18	; 037FD2E6
	bx lr	; 037FD2E8
loc_037FD2EA:
	sub r0,#0x60	; 037FD2EA
	mov r1,#0x20	; 037FD2EC
	sub r1,r1,r0	; 037FD2EE
	ldr r0,[pool_037FD2FC]	; 037FD2F0
	ldrsb r0,[r0,r1]	; 037FD2F2
	neg r0,r0	; 037FD2F4
	lsl r0,r0,#0x18	; 037FD2F6
	asr r0,r0,#0x18	; 037FD2F8
	bx lr	; 037FD2FA
pool_037FD2FC:
loc_037FD2FC:
	.word P2_Data_03802A6C	; 037FD2FC

; ===== function loc_037FD300 =====
loc_037FD300:
	push {r4,lr}	; 037FD300
	add r4,r0,#0x0	; 037FD302
	ldr r0,[pool_037FD350]	; 037FD304
	cmp r4,r0	; 037FD306
	bge loc_037FD30E	; 037FD308
	add r4,r0,#0x0	; 037FD30A
	b loc_037FD314	; 037FD30C
loc_037FD30E:
	cmp r4,#0x0	; 037FD30E
	ble loc_037FD314	; 037FD310
	mov r4,#0x0	; 037FD312
loc_037FD314:
	ldr r0,[pool_037FD354]	; 037FD314
	add r0,r4,r0	; 037FD316
	bl loc_038022B8	; 037FD318
	mov r1,#0xef	; 037FD31C
	mvn r1,r1	; 037FD31E
	cmp r4,r1	; 037FD320
	bge loc_037FD328	; 037FD322
	mov r1,#0x3	; 037FD324
	b loc_037FD342	; 037FD326
loc_037FD328:
	mov r1,#0x77	; 037FD328
	mvn r1,r1	; 037FD32A
	cmp r4,r1	; 037FD32C
	bge loc_037FD334	; 037FD32E
	mov r1,#0x2	; 037FD330
	b loc_037FD342	; 037FD332
loc_037FD334:
	mov r1,#0x3b	; 037FD334
	mvn r1,r1	; 037FD336
	cmp r4,r1	; 037FD338
	bge loc_037FD340	; 037FD33A
	mov r1,#0x1	; 037FD33C
	b loc_037FD342	; 037FD33E
loc_037FD340:
	mov r1,#0x0	; 037FD340
loc_037FD342:
	lsl r1,r1,#0x8	; 037FD342
	orr r1,r0	; 037FD344
	lsl r0,r1,#0x10	; 037FD346
	lsr r0,r0,#0x10	; 037FD348
	pop {r4}	; 037FD34A
	pop {r3}	; 037FD34C
	bx r3	; 037FD34E
pool_037FD350:
loc_037FD350:
	.word 0xFFFFFD2D	; 037FD350
pool_037FD354:
loc_037FD354:
	.word 0x000002D3	; 037FD354

; ===== function loc_037FD358 =====
loc_037FD358:
	push {r4,r5,r6,lr}	; 037FD358
	add r5,r0,#0x0	; 037FD35A
	mov r4,#0x0	; 037FD35C
	neg r0,r1	; 037FD35E
	ldr r1,[pool_037FD404]	; 037FD360
	b loc_037FD368	; 037FD362
loc_037FD364:
	sub r4,r4,#0x1	; 037FD364
	add r0,r0,r1	; 037FD366
loc_037FD368:
	cmp r0,#0x0	; 037FD368
	blt loc_037FD364	; 037FD36A
	ldr r1,[pool_037FD404]	; 037FD36C
	b loc_037FD374	; 037FD36E
loc_037FD370:
	add r4,r4,#0x1	; 037FD370
	sub r0,r0,r1	; 037FD372
loc_037FD374:
	cmp r0,r1	; 037FD374
	bge loc_037FD370	; 037FD376
	bl loc_038022B4	; 037FD378
	mov r1,#0x0	; 037FD37C
	ldr r2,[pool_037FD408]	; 037FD37E
	add r0,r0,r2	; 037FD380
	adc r1,r1	; 037FD382
	asr r3,r5,#0x1f	; 037FD384
	add r2,r5,#0x0	; 037FD386
	bl loc_037FC76C	; 037FD388
	add r6,r0,#0x0	; 037FD38C
	add r5,r1,#0x0	; 037FD38E
	add r2,r4,#0x0	; 037FD390
	sub r2,#0x10	; 037FD392
	cmp r2,#0x0	; 037FD394
	bgt loc_037FD3A2	; 037FD396
	neg r2,r2	; 037FD398
	bl loc_037FD410	; 037FD39A
	add r5,r1,#0x0	; 037FD39E
	b loc_037FD3DE	; 037FD3A0
loc_037FD3A2:
	cmp r2,#0x20	; 037FD3A2
	bge loc_037FD3DA	; 037FD3A4
	mov r0,#0x0	; 037FD3A6
	mvn r0,r0	; 037FD3A8
	add r1,r0,#0x0	; 037FD3AA
	mov r3,#0x20	; 037FD3AC
	sub r2,r3,r2	; 037FD3AE
	bl loc_037FD41C	; 037FD3B0
	add r2,r5,#0x0	; 037FD3B4
	and r2,r1	; 037FD3B6
	add r1,r6,#0x0	; 037FD3B8
	and r1,r0	; 037FD3BA
	mov r0,#0x0	; 037FD3BC
	eor r2,r0	; 037FD3BE
	eor r1,r0	; 037FD3C0
	orr r2,r1	; 037FD3C2
	beq loc_037FD3CA	; 037FD3C4
	ldr r0,[pool_037FD40C]	; 037FD3C6
	b loc_037FD3FC	; 037FD3C8
loc_037FD3CA:
	add r0,r6,#0x0	; 037FD3CA
	add r1,r5,#0x0	; 037FD3CC
	sub r4,#0x10	; 037FD3CE
	add r2,r4,#0x0	; 037FD3D0
	bl loc_037FD41C	; 037FD3D2
	add r5,r1,#0x0	; 037FD3D6
	b loc_037FD3DE	; 037FD3D8
loc_037FD3DA:
	ldr r0,[pool_037FD40C]	; 037FD3DA
	b loc_037FD3FC	; 037FD3DC
loc_037FD3DE:
	mov r2,#0x0	; 037FD3DE
	mov r1,#0x10	; 037FD3E0
	sub r1,r0,r1	; 037FD3E2
	lsl r1,r5,#0	; 037FD3E4
	sbc r1,r2	; 037FD3E6
	bcs loc_037FD3EE	; 037FD3E8
	mov r0,#0x10	; 037FD3EA
	b loc_037FD3F8	; 037FD3EC
loc_037FD3EE:
	ldr r1,[pool_037FD40C]	; 037FD3EE
	sub r1,r1,r0	; 037FD3F0
	sbc r2,r5	; 037FD3F2
	bcs loc_037FD3F8	; 037FD3F4
	ldr r0,[pool_037FD40C]	; 037FD3F6
loc_037FD3F8:
	lsl r0,r0,#0x10	; 037FD3F8
	lsr r0,r0,#0x10	; 037FD3FA
loc_037FD3FC:
	pop {r4,r5,r6}	; 037FD3FC
	pop {r3}	; 037FD3FE
	bx r3	; 037FD400
	.byte 0xC0, 0x46	; 037FD404
pool_037FD404:
loc_037FD404:
	.word 0x00000300	; 037FD404
pool_037FD408:
loc_037FD408:
	.word 0x00010000	; 037FD408
pool_037FD40C:
loc_037FD40C:
	.word 0x0000FFFF	; 037FD40C

; ===== function loc_037FD410 =====
loc_037FD410:
	bx pc	; 037FD410
	.byte 0xC0, 0x46	; 037FD414
.arm

; ===== function loc_037FD414 =====
loc_037FD414:
	ldr pc,[pool_037FD418]	; 037FD414
pool_037FD418:
loc_037FD418:
	.word loc_03802904	; 037FD418
.thumb

; ===== function loc_037FD41C =====
loc_037FD41C:
	bx pc	; 037FD41C
	.byte 0xC0, 0x46	; 037FD420
.arm

; ===== function loc_037FD420 =====
loc_037FD420:
	ldr pc,[pool_037FD424]	; 037FD420
pool_037FD424:
loc_037FD424:
	.word loc_038024E4	; 037FD424
.thumb
P2_ThreadEntry_037FD428:
	push {r4,r5,r6,lr}	; 037FD428
	bl P2_Entry_037FD528	; 037FD42A
	bl P2_Entry_037FDF6C	; 037FD42E
	bl P2_Entry_037FF044	; 037FD432
	bl P2_Entry_037FF3F4	; 037FD436
	bl P2_Entry_037FCFA4	; 037FD43A
	mov r0,#0x0	; 037FD43E
	add r1,r0,#0x0	; 037FD440
	add r2,r0,#0x0	; 037FD442
	add r3,r0,#0x0	; 037FD444
	bl loc_037FCEEC	; 037FD446
	mov r0,#0x7f	; 037FD44A
	bl loc_037FCF20	; 037FD44C
	bl P2_Entry_037FD4E8	; 037FD450
	mov r6,#0x1	; 037FD454
	mov r4,#0x0	; 037FD456
P2_Entry_037FD458:
	add r5,r4,#0x0	; 037FD458
	bl P2_Entry_037FD4CC	; 037FD45A
	cmp r0,#0x1	; 037FD45E
	beq P2_Entry_037FD466	; 037FD460
	cmp r0,#0x2	; 037FD462
	b P2_Entry_037FD468	; 037FD464
P2_Entry_037FD466:
	add r5,r6,#0x0	; 037FD466
P2_Entry_037FD468:
	bl P2_Entry_037FDE2C	; 037FD468
	bl P2_Entry_037FF654	; 037FD46C
	add r0,r5,#0x0	; 037FD470
	bl P2_Entry_037FEFE8	; 037FD472
	add r0,r5,#0x0	; 037FD476
	bl P2_Entry_037FDC3C	; 037FD478
	bl loc_037FF238	; 037FD47C
	bl loc_037FD29C	; 037FD480
	b P2_Entry_037FD458	; 037FD484
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xBD, 0xFC	; 037FD486
	.byte 0x00, 0x28, 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0xAA, 0xFA, 0x01, 0xB0	; 037FD496
	.byte 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x80, 0x33, 0x80, 0x03, 0x50, 0x2C, 0x80, 0x03, 0x48, 0x2C	; 037FD4A6
	.byte 0x80, 0x03	; 037FD4B6
.arm
.thumb

; ===== function loc_037FD4B8 =====
loc_037FD4B8:
	ldr r0,[pool_037FD4C4]	; 037FD4B8
	mov r1,#0x2	; 037FD4BA
	mov r2,#0x0	; 037FD4BC
	ldr r3,[pool_037FD4C8]	; 037FD4BE
	bx r3	; 037FD4C0
	.byte 0xC0, 0x46	; 037FD4C4
pool_037FD4C4:
loc_037FD4C4:
	.word 0x03803380	; 037FD4C4
pool_037FD4C8:
loc_037FD4C8:
	.word loc_037FBE10 + 1	; 037FD4C8

; ===== function loc_037FD4CC =====
P2_Entry_037FD4CC:
	push {lr}	; 037FD4CC
	sub sp,#0x4	; 037FD4CE
	ldr r0,[pool_037FD4E4]	; 037FD4D0
	add r1,sp,#0x0	; 037FD4D2
	mov r2,#0x1	; 037FD4D4
	bl loc_037FBD94	; 037FD4D6
	ldr r0,[sp,#0x0]	; 037FD4DA
	add sp,#0x4	; 037FD4DC
	pop {r3}	; 037FD4DE
	bx r3	; 037FD4E0
	.byte 0xC0, 0x46	; 037FD4E4
pool_037FD4E4:
loc_037FD4E4:
	.word 0x03803380	; 037FD4E4
P2_Entry_037FD4E8:
	push {r4,r5,lr}	; 037FD4E8
	sub sp,#0xc	; 037FD4EA
	bl loc_037FC3AC	; 037FD4EC
	add r4,r0,#0x0	; 037FD4F0
	ldr r0,[pool_037FD518]	; 037FD4F2
	str r0,[sp,#0x4]	; 037FD4F4
	mov r5,#0x0	; 037FD4F6
	str r5,[sp,#0x8]	; 037FD4F8
	ldr r3,[pool_037FD51C]	; 037FD4FA
	str r5,[sp,#0x0]	; 037FD4FC
	ldr r0,[pool_037FD520]	; 037FD4FE
	ldr r2,[pool_037FD524]	; 037FD500
	add r4,r4,r2	; 037FD502
	lsl r2,r1,#0	; 037FD504
	adc r2,r5	; 037FD506
	add r1,r4,#0x0	; 037FD508
	bl loc_037FC5FC	; 037FD50A
	add sp,#0xc	; 037FD50E
	pop {r4,r5}	; 037FD510
	pop {r3}	; 037FD512
	bx r3	; 037FD514
	.byte 0xC0, 0x46	; 037FD516
pool_037FD518:
	.word 0x037FD489	; 037FD518
pool_037FD51C:
	.word 0x00000AA8	; 037FD51C
pool_037FD520:
	.word 0x038033B4	; 037FD520
pool_037FD524:
	.word 0x00010000	; 037FD524
P2_Entry_037FD528:
	push {lr}	; 037FD528
	sub sp,#0x4	; 037FD52A
	ldr r0,[pool_037FD544]	; 037FD52C
	ldr r1,[pool_037FD548]	; 037FD52E
	mov r2,#0x8	; 037FD530
	bl loc_037FBE70	; 037FD532
	ldr r0,[pool_037FD54C]	; 037FD536
	bl loc_037FC778	; 037FD538
	add sp,#0x4	; 037FD53C
	pop {r3}	; 037FD53E
	bx r3	; 037FD540
	.byte 0xC0, 0x46	; 037FD542
pool_037FD544:
	.word 0x03803380	; 037FD544
pool_037FD548:
	.word 0x03803394	; 037FD548
pool_037FD54C:
	.word 0x038033B4	; 037FD54C

; ===== function loc_037FD550 =====
loc_037FD550:
	push {lr}	; 037FD550
	sub sp,#0xc	; 037FD552
	ldr r1,[pool_037FD574]	; 037FD554
	str r1,[sp,#0x0]	; 037FD556
	str r0,[sp,#0x4]	; 037FD558
	ldr r0,[pool_037FD578]	; 037FD55A
	ldr r1,[pool_037FD57C]	; 037FD55C
	mov r2,#0x0	; 037FD55E
	ldr r3,[pool_037FD580]	; 037FD560
	bl P2_CreateThread	; 037FD562
	ldr r0,[pool_037FD578]	; 037FD566
	bl loc_037FB9EC	; 037FD568
	add sp,#0xc	; 037FD56C
	pop {r3}	; 037FD56E
	bx r3	; 037FD570
	.byte 0xC0, 0x46	; 037FD574
pool_037FD574:
loc_037FD574:
	.word 0x00000400	; 037FD574
pool_037FD578:
loc_037FD578:
	.word 0x038033E0	; 037FD578
pool_037FD57C:
loc_037FD57C:
	.word P2_ThreadEntry_037FD428 + 1	; 037FD57C
pool_037FD580:
loc_037FD580:
	.word 0x03803858	; 037FD580

; ===== function loc_037FD584 =====
loc_037FD584:
	push {r4,lr}	; 037FD584
	add r4,r0,#0x0	; 037FD586
	bl loc_037FF90C	; 037FD588
	add r0,r4,#0x0	; 037FD58C
	bl loc_037FD550	; 037FD58E
	pop {r4}	; 037FD592
	pop {r3}	; 037FD594
	bx r3	; 037FD596

; ===== function loc_037FD598 =====
loc_037FD598:
	ldr r1,[pool_037FD5AC]	; 037FD598
	ldrb r1,[r0,r1]	; 037FD59A
	mov r0,#0x80	; 037FD59C
	and r1,r0	; 037FD59E
	cmp r1,#0x0	; 037FD5A0
	beq loc_037FD5A8	; 037FD5A2
	mov r0,#0x1	; 037FD5A4
	bx lr	; 037FD5A6
loc_037FD5A8:
	mov r0,#0x0	; 037FD5A8
	bx lr	; 037FD5AA
pool_037FD5AC:
loc_037FD5AC:
	.word REG_SNDCAP0CNT	; 037FD5AC

; ===== function loc_037FD5B0 =====
loc_037FD5B0:
	push {r4,r5,r6,r7,lr}	; 037FD5B0
	sub sp,#0x4	; 037FD5B2
	add r4,r0,#0x0	; 037FD5B4
	add r0,r2,#0x0	; 037FD5B6
	add r6,r3,#0x0	; 037FD5B8
	lsl r3,r4,#0x3	; 037FD5BA
	ldr r2,[sp,#0x18]	; 037FD5BC
	cmp r2,#0x0	; 037FD5BE
	beq loc_037FD5C6	; 037FD5C0
	mov r5,#0x0	; 037FD5C2
	b loc_037FD5C8	; 037FD5C4
loc_037FD5C6:
	mov r5,#0x1	; 037FD5C6
loc_037FD5C8:
	ldr r2,[sp,#0x20]	; 037FD5C8
	ldr r7,[sp,#0x1c]	; 037FD5CA
	lsl r7,r7,#0x1	; 037FD5CC
	lsl r1,r1,#0x3	; 037FD5CE
	lsl r5,r5,#0x2	; 037FD5D0
	orr r1,r5	; 037FD5D2
	orr r7,r1	; 037FD5D4
	orr r2,r7	; 037FD5D6
	ldr r1,[pool_037FD5EC]	; 037FD5D8
	strb r2,[r4,r1]	; 037FD5DA
	ldr r1,[pool_037FD5F0]	; 037FD5DC
	str r0,[r3,r1]	; 037FD5DE
	ldr r0,[pool_037FD5F4]	; 037FD5E0
	strh r6,[r3,r0]	; 037FD5E2
	add sp,#0x4	; 037FD5E4
	pop {r4,r5,r6,r7}	; 037FD5E6
	pop {r3}	; 037FD5E8
	bx r3	; 037FD5EA
pool_037FD5EC:
loc_037FD5EC:
	.word REG_SNDCAP0CNT	; 037FD5EC
pool_037FD5F0:
loc_037FD5F0:
	.word REG_SNDCAP0DAD	; 037FD5F0
pool_037FD5F4:
loc_037FD5F4:
	.word REG_SNDCAP0LEN	; 037FD5F4

; ===== function loc_037FD5F8 =====
loc_037FD5F8:
	push {r4,r5,r6,r7,lr}	; 037FD5F8
	sub sp,#0x4	; 037FD5FA
	add r5,r0,#0x0	; 037FD5FC
	add r6,r1,#0x0	; 037FD5FE
	add r0,#0x28	; 037FD600
	bl loc_037FD850	; 037FD602
	add r4,r0,#0x0	; 037FD606
	asr r3,r4,#0x1f	; 037FD608
	mov r2,#0x0	; 037FD60A
	add r1,r3,#0x0	; 037FD60C
	eor r1,r2	; 037FD60E
	add r7,r4,#0x0	; 037FD610
	eor r7,r2	; 037FD612
	orr r1,r7	; 037FD614
	beq loc_037FD654	; 037FD616
	add r1,r5,#0x0	; 037FD618
	add r1,#0x28	; 037FD61A
	ldrb r1,[r1,#0x0]	; 037FD61C
	cmp r1,#0x0	; 037FD61E
	beq loc_037FD63C	; 037FD620
	cmp r1,#0x1	; 037FD622
	beq loc_037FD62C	; 037FD624
	cmp r1,#0x2	; 037FD626
	beq loc_037FD646	; 037FD628
	b loc_037FD64E	; 037FD62A
loc_037FD62C:
	add r1,r3,#0x0	; 037FD62C
	mov r2,#0x3c	; 037FD62E
	mov r3,#0x0	; 037FD630
	bl loc_037FD66C	; 037FD632
	add r4,r0,#0x0	; 037FD636
	add r3,r1,#0x0	; 037FD638
	b loc_037FD64E	; 037FD63A
loc_037FD63C:
	lsr r0,r4,#0x1a	; 037FD63C
	lsl r3,r3,#0x6	; 037FD63E
	orr r3,r0	; 037FD640
	lsl r4,r4,#0x6	; 037FD642
	b loc_037FD64E	; 037FD644
loc_037FD646:
	lsr r0,r4,#0x1a	; 037FD646
	lsl r3,r3,#0x6	; 037FD648
	orr r3,r0	; 037FD64A
	lsl r4,r4,#0x6	; 037FD64C
loc_037FD64E:
	lsl r0,r3,#0x12	; 037FD64E
	lsr r4,r4,#0xe	; 037FD650
	orr r4,r0	; 037FD652
loc_037FD654:
	cmp r6,#0x0	; 037FD654
	beq loc_037FD660	; 037FD656
	add r5,#0x28	; 037FD658
	add r0,r5,#0x0	; 037FD65A
	bl loc_037FD884	; 037FD65C
loc_037FD660:
	add r0,r4,#0x0	; 037FD660
	add sp,#0x4	; 037FD662
	pop {r4,r5,r6,r7}	; 037FD664
	pop {r3}	; 037FD666
	bx r3	; 037FD668
	.byte 0xC0, 0x46	; 037FD66C

; ===== function loc_037FD66C =====
loc_037FD66C:
	bx pc	; 037FD66C
	.byte 0xC0, 0x46	; 037FD670
.arm

; ===== function loc_037FD670 =====
loc_037FD670:
	ldr pc,[pool_037FD674]	; 037FD670
pool_037FD674:
loc_037FD674:
	.word loc_038024C4	; 037FD674
.thumb

; ===== function loc_037FD678 =====
loc_037FD678:
	push {r4,r5,r6,lr}	; 037FD678
	add r5,r0,#0x0	; 037FD67A
	add r6,r1,#0x0	; 037FD67C
	mov r0,#0x32	; 037FD67E
	ldrsh r0,[r5,r0]	; 037FD680
	cmp r0,#0x0	; 037FD682
	bne loc_037FD68A	; 037FD684
	mov r0,#0x0	; 037FD686
	b loc_037FD6B4	; 037FD688
loc_037FD68A:
	ldr r2,[r5,#0x14]	; 037FD68A
	ldr r4,[r5,#0x18]	; 037FD68C
	cmp r2,r4	; 037FD68E
	blt loc_037FD696	; 037FD690
	mov r0,#0x0	; 037FD692
	b loc_037FD6B4	; 037FD694
loc_037FD696:
	asr r1,r0,#0x1f	; 037FD696
	sub r2,r4,r2	; 037FD698
	asr r3,r2,#0x1f	; 037FD69A
	bl loc_037FD66C	; 037FD69C
	asr r3,r4,#0x1f	; 037FD6A0
	add r2,r4,#0x0	; 037FD6A2
	bl loc_037FD6BC	; 037FD6A4
	cmp r6,#0x0	; 037FD6A8
	beq loc_037FD6B4	; 037FD6AA
	add r5,#0x14	; 037FD6AC
	ldr r1,[r5,#0x0]	; 037FD6AE
	add r1,r1,#0x1	; 037FD6B0
	str r1,[r5,#0x0]	; 037FD6B2
loc_037FD6B4:
	pop {r4,r5,r6}	; 037FD6B4
	pop {r3}	; 037FD6B6
	bx r3	; 037FD6B8
	.byte 0xC0, 0x46	; 037FD6BC

; ===== function loc_037FD6BC =====
loc_037FD6BC:
	bx pc	; 037FD6BC
	.byte 0xC0, 0x46	; 037FD6C0
.arm

; ===== function loc_037FD6C0 =====
loc_037FD6C0:
	ldr pc,[pool_037FD6C4]	; 037FD6C0
pool_037FD6C4:
loc_037FD6C4:
	.word loc_03802314	; 037FD6C4
.thumb

; ===== function loc_037FD6C8 =====
loc_037FD6C8:
	push {r4,lr}	; 037FD6C8
	cmp r1,#0x0	; 037FD6CA
	beq loc_037FD734	; 037FD6CC
	ldrb r1,[r0,#0x2]	; 037FD6CE
	cmp r1,#0x3	; 037FD6D0
	bhi loc_037FD734	; 037FD6D2
	add r1,r1,r1	; 037FD6D4
P2_SwitchIndexPC_037FD6D4:
	add r1,pc	; 037FD6D6
	ldrh r1,[r1,#(P2_SwitchTable_037FD6D4 - (P2_SwitchIndexPC_037FD6D4 + 4))]	; 037FD6D8
	lsl r1,r1,#0x10	; 037FD6DA
	asr r1,r1,#0x10	; 037FD6DC
P2_SwitchTargetPC_037FD6D4:
	add r1,pc	; 037FD6DE
	bx r1	; 037FD6E0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD6D4:
	.halfword (loc_037FD6EA + 1) - (P2_SwitchTargetPC_037FD6D4 + 4)
	.halfword (loc_037FD704 + 1) - (P2_SwitchTargetPC_037FD6D4 + 4)
	.halfword (loc_037FD734 + 1) - (P2_SwitchTargetPC_037FD6D4 + 4)
	.halfword (loc_037FD728 + 1) - (P2_SwitchTargetPC_037FD6D4 + 4)
P2_SwitchTable_037FD6D4End:
loc_037FD6EA:
	ldr r1,[r0,#0x10]	; 037FD6EA
	neg r2,r1	; 037FD6EC
	ldrb r1,[r0,#0x1c]	; 037FD6EE
	mul r2,r1	; 037FD6F0
	asr r1,r2,#0x8	; 037FD6F2
	neg r1,r1	; 037FD6F4
	str r1,[r0,#0x10]	; 037FD6F6
	ldr r1,[r0,#0x10]	; 037FD6F8
	cmp r1,#0x0	; 037FD6FA
	bne loc_037FD734	; 037FD6FC
	mov r1,#0x1	; 037FD6FE
	strb r1,[r0,#0x2]	; 037FD700
	b loc_037FD734	; 037FD702
loc_037FD704:
	ldrb r1,[r0,#0x1d]	; 037FD704
	lsl r2,r1,#0x1	; 037FD706
	ldr r1,[pool_037FD740]	; 037FD708
	ldrsh r1,[r1,r2]	; 037FD70A
	lsl r4,r1,#0x7	; 037FD70C
	add r3,r0,#0x0	; 037FD70E
	add r3,#0x10	; 037FD710
	ldr r2,[r3,#0x0]	; 037FD712
	ldrh r1,[r0,#0x1e]	; 037FD714
	sub r1,r2,r1	; 037FD716
	str r1,[r3,#0x0]	; 037FD718
	ldr r1,[r0,#0x10]	; 037FD71A
	cmp r1,r4	; 037FD71C
	bgt loc_037FD734	; 037FD71E
	str r4,[r0,#0x10]	; 037FD720
	mov r1,#0x2	; 037FD722
	strb r1,[r0,#0x2]	; 037FD724
	b loc_037FD734	; 037FD726
loc_037FD728:
	add r3,r0,#0x0	; 037FD728
	add r3,#0x10	; 037FD72A
	ldr r2,[r3,#0x0]	; 037FD72C
	ldrh r1,[r0,#0x20]	; 037FD72E
	sub r1,r2,r1	; 037FD730
	str r1,[r3,#0x0]	; 037FD732
loc_037FD734:
	ldr r0,[r0,#0x10]	; 037FD734
	asr r0,r0,#0x7	; 037FD736
	pop {r4}	; 037FD738
	pop {r3}	; 037FD73A
	bx r3	; 037FD73C
	.byte 0xC0, 0x46	; 037FD740
pool_037FD740:
loc_037FD740:
	.word P2_Data_03802A90	; 037FD740

; ===== function loc_037FD744 =====
loc_037FD744:
	push {r4,r5,lr}	; 037FD744
	sub sp,#0x4	; 037FD746
	ldrh r5,[r0,#0x24]	; 037FD748
	mov r0,#0xff	; 037FD74A
	add r2,r5,#0x0	; 037FD74C
	and r2,r0	; 037FD74E
	ldrh r4,[r1,#0x24]	; 037FD750
	add r1,r4,#0x0	; 037FD752
	and r1,r0	; 037FD754
	lsl r3,r2,#0x4	; 037FD756
	lsl r2,r1,#0x4	; 037FD758
	asr r0,r5,#0x8	; 037FD75A
	ldr r1,[pool_037FD784]	; 037FD75C
	ldrb r0,[r1,r0]	; 037FD75E
	asr r3,r0	; 037FD760
	asr r0,r4,#0x8	; 037FD762
	ldrb r0,[r1,r0]	; 037FD764
	asr r2,r0	; 037FD766
	cmp r3,r2	; 037FD768
	beq loc_037FD77A	; 037FD76A
	cmp r3,r2	; 037FD76C
	bge loc_037FD774	; 037FD76E
	mov r0,#0x1	; 037FD770
	b loc_037FD77C	; 037FD772
loc_037FD774:
	mov r0,#0x0	; 037FD774
	mvn r0,r0	; 037FD776
	b loc_037FD77C	; 037FD778
loc_037FD77A:
	mov r0,#0x0	; 037FD77A
loc_037FD77C:
	add sp,#0x4	; 037FD77C
	pop {r4,r5}	; 037FD77E
	pop {r3}	; 037FD780
	bx r3	; 037FD782
pool_037FD784:
loc_037FD784:
	.word P2_Data_03802B90	; 037FD784

; ===== function loc_037FD788 =====
loc_037FD788:
	push {lr}	; 037FD788
	sub sp,#0x4	; 037FD78A
	add r2,r0,#0x0	; 037FD78C
	cmp r2,#0x7f	; 037FD78E
	bne loc_037FD796	; 037FD790
	ldr r0,[pool_037FD7C0]	; 037FD792
	b loc_037FD7BA	; 037FD794
loc_037FD796:
	cmp r2,#0x7e	; 037FD796
	bne loc_037FD79E	; 037FD798
	ldr r0,[pool_037FD7C4]	; 037FD79A
	b loc_037FD7BA	; 037FD79C
loc_037FD79E:
	cmp r2,#0x32	; 037FD79E
	bge loc_037FD7AC	; 037FD7A0
	lsl r0,r2,#0x1	; 037FD7A2
	add r0,r0,#0x1	; 037FD7A4
	lsl r0,r0,#0x10	; 037FD7A6
	lsr r0,r0,#0x10	; 037FD7A8
	b loc_037FD7BA	; 037FD7AA
loc_037FD7AC:
	ldr r0,[pool_037FD7C8]	; 037FD7AC
	mov r1,#0x7e	; 037FD7AE
	sub r1,r1,r2	; 037FD7B0
	bl loc_037FBE04	; 037FD7B2
	lsl r0,r0,#0x10	; 037FD7B6
	lsr r0,r0,#0x10	; 037FD7B8
loc_037FD7BA:
	add sp,#0x4	; 037FD7BA
	pop {r3}	; 037FD7BC
	bx r3	; 037FD7BE
pool_037FD7C0:
loc_037FD7C0:
	.word 0x0000FFFF	; 037FD7C0
pool_037FD7C4:
loc_037FD7C4:
	.word 0x00003C00	; 037FD7C4
pool_037FD7C8:
loc_037FD7C8:
	.word 0x00001E00	; 037FD7C8

; ===== function loc_037FD7CC =====
loc_037FD7CC:
	push {r4,lr}	; 037FD7CC
	add r4,r0,#0x0	; 037FD7CE
	ldr r0,[pool_037FD7FC]	; 037FD7D0
	str r0,[r4,#0x10]	; 037FD7D2
	mov r0,#0x0	; 037FD7D4
	strb r0,[r4,#0x2]	; 037FD7D6
	str r1,[r4,#0x34]	; 037FD7D8
	add r0,r4,#0x0	; 037FD7DA
	add r0,#0x28	; 037FD7DC
	bl loc_037FD8C8	; 037FD7DE
	add r2,r4,#0x3	; 037FD7E2
	ldrb r1,[r2,#0x0]	; 037FD7E4
	mov r0,#0x2	; 037FD7E6
	orr r1,r0	; 037FD7E8
	strb r1,[r2,#0x0]	; 037FD7EA
	ldrb r1,[r2,#0x0]	; 037FD7EC
	mov r0,#0x1	; 037FD7EE
	bic r1,r0	; 037FD7F0
	orr r1,r0	; 037FD7F2
	strb r1,[r2,#0x0]	; 037FD7F4
	pop {r4}	; 037FD7F6
	pop {r3}	; 037FD7F8
	bx r3	; 037FD7FA
pool_037FD7FC:
loc_037FD7FC:
	.word 0xFFFE9680	; 037FD7FC

; ===== function loc_037FD800 =====
loc_037FD800:
	push {r4,r5,lr}	; 037FD800
	sub sp,#0x4	; 037FD802
	mov r4,#0x0	; 037FD804
	str r4,[r0,#0x50]	; 037FD806
	str r1,[r0,#0x48]	; 037FD808
	str r2,[r0,#0x4c]	; 037FD80A
	str r4,[r0,#0x34]	; 037FD80C
	add r1,r0,#0x0	; 037FD80E
	add r1,#0x22	; 037FD810
	strb r3,[r1,#0x0]	; 037FD812
	mov r5,#0x7f	; 037FD814
	strh r5,[r0,#0x24]	; 037FD816
	add r3,r0,#0x3	; 037FD818
	ldrb r2,[r3,#0x0]	; 037FD81A
	mov r1,#0x2	; 037FD81C
	bic r2,r1	; 037FD81E
	strb r2,[r3,#0x0]	; 037FD820
	mov r1,#0x3c	; 037FD822
	strb r1,[r0,#0x8]	; 037FD824
	strb r1,[r0,#0x5]	; 037FD826
	strb r5,[r0,#0x9]	; 037FD828
	strb r4,[r0,#0xa]	; 037FD82A
	strh r4,[r0,#0xc]	; 037FD82C
	strh r4,[r0,#0xe]	; 037FD82E
	strb r4,[r0,#0xb]	; 037FD830
	strh r4,[r0,#0x32]	; 037FD832
	str r4,[r0,#0x18]	; 037FD834
	str r4,[r0,#0x14]	; 037FD836
	strb r5,[r0,#0x1c]	; 037FD838
	strh r5,[r0,#0x1e]	; 037FD83A
	strb r5,[r0,#0x1d]	; 037FD83C
	strh r5,[r0,#0x20]	; 037FD83E
	add r0,#0x28	; 037FD840
	bl loc_037FD8D0	; 037FD842
	add sp,#0x4	; 037FD846
	pop {r4,r5}	; 037FD848
	pop {r3}	; 037FD84A
	bx r3	; 037FD84C
	.byte 0x00, 0x00	; 037FD850

; ===== function loc_037FD850 =====
loc_037FD850:
	push {r4,lr}	; 037FD850
	add r4,r0,#0x0	; 037FD852
	ldrb r0,[r4,#0x2]	; 037FD854
	cmp r0,#0x0	; 037FD856
	bne loc_037FD85E	; 037FD858
	mov r0,#0x0	; 037FD85A
	b loc_037FD87C	; 037FD85C
loc_037FD85E:
	ldrh r1,[r4,#0x6]	; 037FD85E
	ldrh r0,[r4,#0x4]	; 037FD860
	cmp r1,r0	; 037FD862
	bcs loc_037FD86A	; 037FD864
	mov r2,#0x0	; 037FD866
	b loc_037FD87A	; 037FD868
loc_037FD86A:
	ldrh r0,[r4,#0x8]	; 037FD86A
	lsr r0,r0,#0x8	; 037FD86C
	bl loc_037FD2C0	; 037FD86E
	ldrb r2,[r4,#0x3]	; 037FD872
	ldrb r1,[r4,#0x2]	; 037FD874
	mul r1,r0	; 037FD876
	mul r2,r1	; 037FD878
loc_037FD87A:
	add r0,r2,#0x0	; 037FD87A
loc_037FD87C:
	pop {r4}	; 037FD87C
	pop {r3}	; 037FD87E
	bx r3	; 037FD880
	.byte 0x00, 0x00	; 037FD884

; ===== function loc_037FD884 =====
loc_037FD884:
	push {r4,lr}	; 037FD884
	ldrh r2,[r0,#0x6]	; 037FD886
	ldrh r1,[r0,#0x4]	; 037FD888
	cmp r2,r1	; 037FD88A
	bcs loc_037FD898	; 037FD88C
	add r1,r0,#0x6	; 037FD88E
	ldrh r0,[r1,#0x0]	; 037FD890
	add r0,r0,#0x1	; 037FD892
	strh r0,[r1,#0x0]	; 037FD894
	b loc_037FD8C2	; 037FD896
loc_037FD898:
	ldrh r2,[r0,#0x8]	; 037FD898
	ldrb r1,[r0,#0x1]	; 037FD89A
	lsl r3,r1,#0x6	; 037FD89C
	add r1,r2,r3	; 037FD89E
	lsr r4,r1,#0x8	; 037FD8A0
	b loc_037FD8A6	; 037FD8A2
loc_037FD8A4:
	sub r4,#0x80	; 037FD8A4
loc_037FD8A6:
	cmp r4,#0x80	; 037FD8A6
	bcs loc_037FD8A4	; 037FD8A8
	add r0,#0x8	; 037FD8AA
	ldrh r1,[r0,#0x0]	; 037FD8AC
	add r1,r1,r3	; 037FD8AE
	strh r1,[r0,#0x0]	; 037FD8B0
	ldrh r2,[r0,#0x0]	; 037FD8B2
	mov r1,#0xff	; 037FD8B4
	and r2,r1	; 037FD8B6
	strh r2,[r0,#0x0]	; 037FD8B8
	ldrh r2,[r0,#0x0]	; 037FD8BA
	lsl r1,r4,#0x8	; 037FD8BC
	orr r2,r1	; 037FD8BE
	strh r2,[r0,#0x0]	; 037FD8C0
loc_037FD8C2:
	pop {r4}	; 037FD8C2
	pop {r3}	; 037FD8C4
	bx r3	; 037FD8C6

; ===== function loc_037FD8C8 =====
loc_037FD8C8:
	mov r1,#0x0	; 037FD8C8
	strh r1,[r0,#0x8]	; 037FD8CA
	strh r1,[r0,#0x6]	; 037FD8CC
	bx lr	; 037FD8CE

; ===== function loc_037FD8D0 =====
loc_037FD8D0:
	mov r2,#0x0	; 037FD8D0
	strb r2,[r0,#0x0]	; 037FD8D2
	strb r2,[r0,#0x2]	; 037FD8D4
	mov r1,#0x1	; 037FD8D6
	strb r1,[r0,#0x3]	; 037FD8D8
	mov r1,#0x10	; 037FD8DA
	strb r1,[r0,#0x1]	; 037FD8DC
	strh r2,[r0,#0x4]	; 037FD8DE
	bx lr	; 037FD8E0
	.byte 0x00, 0x00	; 037FD8E4

; ===== function loc_037FD8E4 =====
loc_037FD8E4:
	push {r4,r5,r6,r7,lr}	; 037FD8E4
	sub sp,#0x4	; 037FD8E6
	add r5,r0,#0x0	; 037FD8E8
	add r6,r1,#0x0	; 037FD8EA
	mov r4,#0x0	; 037FD8EC
	add r7,r4,#0x0	; 037FD8EE
loc_037FD8F0:
	add r1,r4,#0x0	; 037FD8F0
	mov r0,#0x54	; 037FD8F2
	mul r1,r0	; 037FD8F4
	ldr r0,[pool_037FD930]	; 037FD8F6
	add r1,r0,r1	; 037FD8F8
	ldrb r0,[r1,#0x1]	; 037FD8FA
	cmp r0,#0x0	; 037FD8FC
	bne loc_037FD91C	; 037FD8FE
	ldr r0,[r1,#0x44]	; 037FD900
	cmp r5,r0	; 037FD902
	bhi loc_037FD91C	; 037FD904
	cmp r0,r6	; 037FD906
	bhi loc_037FD91C	; 037FD908
	add r2,r1,#0x3	; 037FD90A
	ldrb r1,[r2,#0x0]	; 037FD90C
	mov r0,#0x2	; 037FD90E
	bic r1,r0	; 037FD910
	strb r1,[r2,#0x0]	; 037FD912
	add r0,r4,#0x0	; 037FD914
	add r1,r7,#0x0	; 037FD916
	bl loc_037FD110	; 037FD918
loc_037FD91C:
	add r0,r4,#0x1	; 037FD91C
	lsl r0,r0,#0x18	; 037FD91E
	lsr r4,r0,#0x18	; 037FD920
	cmp r4,#0x10	; 037FD922
	bcc loc_037FD8F0	; 037FD924
	add sp,#0x4	; 037FD926
	pop {r4,r5,r6,r7}	; 037FD928
	pop {r3}	; 037FD92A
	bx r3	; 037FD92C
	.byte 0xC0, 0x46	; 037FD930
pool_037FD930:
loc_037FD930:
	.word 0x0380387C	; 037FD930

; ===== function loc_037FD934 =====
loc_037FD934:
	mov r2,#0x1	; 037FD934
	and r1,r2	; 037FD936
	cmp r1,#0x0	; 037FD938
	beq loc_037FD946	; 037FD93A
	ldr r1,[pool_037FD950]	; 037FD93C
	ldr r2,[r1,#0x0]	; 037FD93E
	bic r2,r0	; 037FD940
	str r2,[r1,#0x0]	; 037FD942
	bx lr	; 037FD944
loc_037FD946:
	ldr r1,[pool_037FD954]	; 037FD946
	ldr r2,[r1,#0x0]	; 037FD948
	bic r2,r0	; 037FD94A
	str r2,[r1,#0x0]	; 037FD94C
	bx lr	; 037FD94E
pool_037FD950:
loc_037FD950:
	.word P2_BssStart + 0xB50	; 037FD950
pool_037FD954:
loc_037FD954:
	.word P2_BssStart + 0xB54	; 037FD954

; ===== function loc_037FD958 =====
loc_037FD958:
	push {r4,r5,r6,r7,lr}	; 037FD958
	sub sp,#0x14	; 037FD95A
	add r7,r0,#0x0	; 037FD95C
	str r1,[sp,#0x0]	; 037FD95E
	add r6,r7,#0x0	; 037FD960
	mov r4,#0x0	; 037FD962
	str r4,[sp,#0x4]	; 037FD964
	str r4,[sp,#0x8]	; 037FD966
	str r4,[sp,#0xc]	; 037FD968
	str r4,[sp,#0x10]	; 037FD96A
	b loc_037FD9C8	; 037FD96C
loc_037FD96E:
	add r1,r6,#0x0	; 037FD96E
	mov r0,#0x1	; 037FD970
	and r1,r0	; 037FD972
	cmp r1,#0x0	; 037FD974
	beq loc_037FD9C4	; 037FD976
	add r1,r4,#0x0	; 037FD978
	mov r0,#0x54	; 037FD97A
	mul r1,r0	; 037FD97C
	ldr r0,[pool_037FD9F8]	; 037FD97E
	add r5,r0,r1	; 037FD980
	ldr r0,[pool_037FD9FC]	; 037FD982
	ldr r1,[r0,#0x0]	; 037FD984
	mov r0,#0x1	; 037FD986
	lsl r0,r4	; 037FD988
	and r1,r0	; 037FD98A
	cmp r1,#0x0	; 037FD98C
	bne loc_037FD9C4	; 037FD98E
	ldr r3,[r5,#0x48]	; 037FD990
	cmp r3,#0x0	; 037FD992
	beq loc_037FD9A0	; 037FD994
	add r0,r5,#0x0	; 037FD996
	ldr r1,[sp,#0x4]	; 037FD998
	ldr r2,[r5,#0x4c]	; 037FD99A
	bl loc_03802A00	; 037FD99C
loc_037FD9A0:
	add r0,r4,#0x0	; 037FD9A0
	ldr r1,[sp,#0x8]	; 037FD9A2
	bl loc_037FD110	; 037FD9A4
	add r1,r5,#0x0	; 037FD9A8
	add r1,#0x22	; 037FD9AA
	ldr r0,[sp,#0xc]	; 037FD9AC
	strb r0,[r1,#0x0]	; 037FD9AE
	add r0,r5,#0x0	; 037FD9B0
	bl loc_037FDA88	; 037FD9B2
	ldr r0,[sp,#0x10]	; 037FD9B6
	strb r0,[r5,#0x4]	; 037FD9B8
	add r2,r5,#0x3	; 037FD9BA
	ldrb r1,[r2,#0x0]	; 037FD9BC
	mov r0,#0x1	; 037FD9BE
	bic r1,r0	; 037FD9C0
	strb r1,[r2,#0x0]	; 037FD9C2
loc_037FD9C4:
	add r4,r4,#0x1	; 037FD9C4
	lsr r6,r6,#0x1	; 037FD9C6
loc_037FD9C8:
	cmp r4,#0x10	; 037FD9C8
	bge loc_037FD9D0	; 037FD9CA
	cmp r6,#0x0	; 037FD9CC
	bne loc_037FD96E	; 037FD9CE
loc_037FD9D0:
	mov r1,#0x1	; 037FD9D0
	ldr r0,[sp,#0x0]	; 037FD9D2
	and r0,r1	; 037FD9D4
	str r0,[sp,#0x0]	; 037FD9D6
	cmp r0,#0x0	; 037FD9D8
	beq loc_037FD9E6	; 037FD9DA
	ldr r0,[pool_037FDA00]	; 037FD9DC
	ldr r1,[r0,#0x0]	; 037FD9DE
	orr r1,r7	; 037FD9E0
	str r1,[r0,#0x0]	; 037FD9E2
	b loc_037FD9EE	; 037FD9E4
loc_037FD9E6:
	ldr r0,[pool_037FD9FC]	; 037FD9E6
	ldr r1,[r0,#0x0]	; 037FD9E8
	orr r1,r7	; 037FD9EA
	str r1,[r0,#0x0]	; 037FD9EC
loc_037FD9EE:
	add sp,#0x14	; 037FD9EE
	pop {r4,r5,r6,r7}	; 037FD9F0
	pop {r3}	; 037FD9F2
	bx r3	; 037FD9F4
	.byte 0xC0, 0x46	; 037FD9F8
pool_037FD9F8:
loc_037FD9F8:
	.word 0x0380387C	; 037FD9F8
pool_037FD9FC:
loc_037FD9FC:
	.word P2_BssStart + 0xB54	; 037FD9FC
pool_037FDA00:
loc_037FDA00:
	.word P2_BssStart + 0xB50	; 037FDA00

; ===== function loc_037FDA04 =====
loc_037FDA04:
	push {r4,r5,r6,r7,lr}	; 037FDA04
	sub sp,#0xc	; 037FDA06
	add r6,r0,#0x0	; 037FDA08
	mov r4,#0x0	; 037FDA0A
	str r4,[sp,#0x0]	; 037FDA0C
	str r4,[sp,#0x4]	; 037FDA0E
	add r7,r4,#0x0	; 037FDA10
	str r4,[sp,#0x8]	; 037FDA12
	b loc_037FDA6E	; 037FDA14
loc_037FDA16:
	add r1,r6,#0x0	; 037FDA16
	mov r0,#0x1	; 037FDA18
	and r1,r0	; 037FDA1A
	cmp r1,#0x0	; 037FDA1C
	beq loc_037FDA6A	; 037FDA1E
	add r1,r4,#0x0	; 037FDA20
	mov r0,#0x54	; 037FDA22
	mul r1,r0	; 037FDA24
	ldr r0,[pool_037FDA80]	; 037FDA26
	add r5,r0,r1	; 037FDA28
	ldr r0,[pool_037FDA84]	; 037FDA2A
	ldr r1,[r0,#0x0]	; 037FDA2C
	mov r0,#0x1	; 037FDA2E
	lsl r0,r4	; 037FDA30
	and r1,r0	; 037FDA32
	cmp r1,#0x0	; 037FDA34
	bne loc_037FDA6A	; 037FDA36
	ldr r3,[r5,#0x48]	; 037FDA38
	cmp r3,#0x0	; 037FDA3A
	beq loc_037FDA48	; 037FDA3C
	add r0,r5,#0x0	; 037FDA3E
	ldr r1,[sp,#0x0]	; 037FDA40
	ldr r2,[r5,#0x4c]	; 037FDA42
	bl loc_03802A00	; 037FDA44
loc_037FDA48:
	add r0,r4,#0x0	; 037FDA48
	ldr r1,[sp,#0x4]	; 037FDA4A
	bl loc_037FD110	; 037FDA4C
	add r0,r5,#0x0	; 037FDA50
	add r0,#0x22	; 037FDA52
	strb r7,[r0,#0x0]	; 037FDA54
	add r0,r5,#0x0	; 037FDA56
	bl loc_037FDA88	; 037FDA58
	ldr r0,[sp,#0x8]	; 037FDA5C
	strb r0,[r5,#0x4]	; 037FDA5E
	add r2,r5,#0x3	; 037FDA60
	ldrb r1,[r2,#0x0]	; 037FDA62
	mov r0,#0x1	; 037FDA64
	bic r1,r0	; 037FDA66
	strb r1,[r2,#0x0]	; 037FDA68
loc_037FDA6A:
	add r4,r4,#0x1	; 037FDA6A
	lsr r6,r6,#0x1	; 037FDA6C
loc_037FDA6E:
	cmp r4,#0x10	; 037FDA6E
	bge loc_037FDA76	; 037FDA70
	cmp r6,#0x0	; 037FDA72
	bne loc_037FDA16	; 037FDA74
loc_037FDA76:
	add sp,#0xc	; 037FDA76
	pop {r4,r5,r6,r7}	; 037FDA78
	pop {r3}	; 037FDA7A
	bx r3	; 037FDA7C
	.byte 0xC0, 0x46	; 037FDA80
pool_037FDA80:
loc_037FDA80:
	.word 0x0380387C	; 037FDA80
pool_037FDA84:
loc_037FDA84:
	.word P2_BssStart + 0xB54	; 037FDA84

; ===== function loc_037FDA88 =====
loc_037FDA88:
	cmp r0,#0x0	; 037FDA88
	beq loc_037FDA92	; 037FDA8A
	mov r1,#0x0	; 037FDA8C
	str r1,[r0,#0x48]	; 037FDA8E
	str r1,[r0,#0x4c]	; 037FDA90
loc_037FDA92:
	bx lr	; 037FDA92

; ===== function loc_037FDA94 =====
P2_Entry_037FDA94:
	push {r4,r5,r6,r7,lr}	; 037FDA94
	sub sp,#0xc	; 037FDA96
	add r5,r0,#0x0	; 037FDA98
	str r1,[sp,#0x0]	; 037FDA9A
	str r3,[sp,#0x4]	; 037FDA9C
	ldr r0,[pool_037FDB48]	; 037FDA9E
	ldr r0,[r0,#0x0]	; 037FDAA0
	bic r5,r0	; 037FDAA2
	cmp r2,#0x0	; 037FDAA4
	bne loc_037FDAAE	; 037FDAA6
	ldr r0,[pool_037FDB4C]	; 037FDAA8
	ldr r0,[r0,#0x0]	; 037FDAAA
	bic r5,r0	; 037FDAAC
loc_037FDAAE:
	mov r4,#0x0	; 037FDAAE
	add r6,r4,#0x0	; 037FDAB0
loc_037FDAB2:
	ldr r0,[pool_037FDB50]	; 037FDAB2
	ldrb r0,[r0,r6]	; 037FDAB4
	mov r1,#0x1	; 037FDAB6
	lsl r1,r0	; 037FDAB8
	add r2,r5,#0x0	; 037FDABA
	and r2,r1	; 037FDABC
	cmp r2,#0x0	; 037FDABE
	beq loc_037FDAF4	; 037FDAC0
	mov r1,#0x54	; 037FDAC2
	mul r0,r1	; 037FDAC4
	ldr r1,[pool_037FDB54]	; 037FDAC6
	add r7,r1,r0	; 037FDAC8
	cmp r4,#0x0	; 037FDACA
	bne loc_037FDAD2	; 037FDACC
	add r4,r7,#0x0	; 037FDACE
	b loc_037FDAF4	; 037FDAD0
loc_037FDAD2:
	add r0,r4,#0x0	; 037FDAD2
	add r0,#0x22	; 037FDAD4
	ldrb r1,[r0,#0x0]	; 037FDAD6
	add r0,r7,#0x0	; 037FDAD8
	add r0,#0x22	; 037FDADA
	ldrb r0,[r0,#0x0]	; 037FDADC
	cmp r0,r1	; 037FDADE
	bhi loc_037FDAF4	; 037FDAE0
	cmp r0,r1	; 037FDAE2
	bne loc_037FDAF2	; 037FDAE4
	add r0,r4,#0x0	; 037FDAE6
	add r1,r7,#0x0	; 037FDAE8
	bl loc_037FD744	; 037FDAEA
	cmp r0,#0x0	; 037FDAEE
	bge loc_037FDAF4	; 037FDAF0
loc_037FDAF2:
	add r4,r7,#0x0	; 037FDAF2
loc_037FDAF4:
	add r6,r6,#0x1	; 037FDAF4
	cmp r6,#0x10	; 037FDAF6
	blt loc_037FDAB2	; 037FDAF8
	cmp r4,#0x0	; 037FDAFA
	bne loc_037FDB02	; 037FDAFC
	mov r0,#0x0	; 037FDAFE
	b loc_037FDB3E	; 037FDB00
loc_037FDB02:
	add r0,r4,#0x0	; 037FDB02
	add r0,#0x22	; 037FDB04
	ldrb r1,[r0,#0x0]	; 037FDB06
	ldr r0,[sp,#0x0]	; 037FDB08
	cmp r0,r1	; 037FDB0A
	bge loc_037FDB12	; 037FDB0C
	mov r0,#0x0	; 037FDB0E
	b loc_037FDB3E	; 037FDB10
loc_037FDB12:
	ldr r3,[r4,#0x48]	; 037FDB12
	cmp r3,#0x0	; 037FDB14
	beq loc_037FDB22	; 037FDB16
	add r0,r4,#0x0	; 037FDB18
	mov r1,#0x0	; 037FDB1A
	ldr r2,[r4,#0x4c]	; 037FDB1C
	bl loc_03802A00	; 037FDB1E
loc_037FDB22:
	mov r0,#0x2	; 037FDB22
	strb r0,[r4,#0x4]	; 037FDB24
	add r2,r4,#0x3	; 037FDB26
	ldrb r1,[r2,#0x0]	; 037FDB28
	mov r0,#0x1	; 037FDB2A
	bic r1,r0	; 037FDB2C
	strb r1,[r2,#0x0]	; 037FDB2E
	add r0,r4,#0x0	; 037FDB30
	ldr r1,[sp,#0x4]	; 037FDB32
	ldr r2,[sp,#0x20]	; 037FDB34
	ldr r3,[sp,#0x0]	; 037FDB36
	bl loc_037FD800	; 037FDB38
	add r0,r4,#0x0	; 037FDB3C
loc_037FDB3E:
	add sp,#0xc	; 037FDB3E
	pop {r4,r5,r6,r7}	; 037FDB40
	pop {r3}	; 037FDB42
	bx r3	; 037FDB44
	.byte 0xC0, 0x46	; 037FDB48
pool_037FDB48:
loc_037FDB48:
	.word P2_BssStart + 0xB54	; 037FDB48
pool_037FDB4C:
loc_037FDB4C:
	.word P2_BssStart + 0xB50	; 037FDB4C
pool_037FDB50:
loc_037FDB50:
	.word P2_Data_03802B94	; 037FDB50
pool_037FDB54:
loc_037FDB54:
	.word 0x0380387C	; 037FDB54

; ===== function loc_037FDB58 =====
loc_037FDB58:
	ldrb r0,[r0,#0x3]	; 037FDB58
	lsl r0,r0,#0x1f	; 037FDB5A
	lsr r0,r0,#0x1f	; 037FDB5C
	bx lr	; 037FDB5E

; ===== function loc_037FDB60 =====
loc_037FDB60:
	mov r1,#0x3	; 037FDB60
	strb r1,[r0,#0x2]	; 037FDB62
	bx lr	; 037FDB64
	.byte 0x00, 0x00	; 037FDB68

; ===== function loc_037FDB68 =====
loc_037FDB68:
	push {r4,lr}	; 037FDB68
	add r4,r0,#0x0	; 037FDB6A
	add r0,r1,#0x0	; 037FDB6C
	bl loc_037FD788	; 037FDB6E
	strh r0,[r4,#0x20]	; 037FDB72
	pop {r4}	; 037FDB74
	pop {r3}	; 037FDB76
	bx r3	; 037FDB78
	.byte 0x00, 0x00	; 037FDB7C

; ===== function loc_037FDB7C =====
loc_037FDB7C:
	strb r1,[r0,#0x1d]	; 037FDB7C
	bx lr	; 037FDB7E

; ===== function loc_037FDB80 =====
loc_037FDB80:
	push {r4,lr}	; 037FDB80
	add r4,r0,#0x0	; 037FDB82
	add r0,r1,#0x0	; 037FDB84
	bl loc_037FD788	; 037FDB86
	strh r0,[r4,#0x1e]	; 037FDB8A
	pop {r4}	; 037FDB8C
	pop {r3}	; 037FDB8E
	bx r3	; 037FDB90
	.byte 0x00, 0x00	; 037FDB94

; ===== function loc_037FDB94 =====
loc_037FDB94:
	cmp r1,#0x6d	; 037FDB94
	bge loc_037FDBA0	; 037FDB96
	mov r2,#0xff	; 037FDB98
	sub r1,r2,r1	; 037FDB9A
	strb r1,[r0,#0x1c]	; 037FDB9C
	bx lr	; 037FDB9E
loc_037FDBA0:
	mov r2,#0x7f	; 037FDBA0
	sub r2,r2,r1	; 037FDBA2
	ldr r1,[pool_037FDBAC]	; 037FDBA4
	ldrb r1,[r1,r2]	; 037FDBA6
	strb r1,[r0,#0x1c]	; 037FDBA8
	bx lr	; 037FDBAA
pool_037FDBAC:
loc_037FDBAC:
	.word P2_Data_03802BA4	; 037FDBAC

; ===== function loc_037FDBB0 =====
loc_037FDBB0:
	push {lr}	; 037FDBB0
	sub sp,#0x4	; 037FDBB2
	ldrb r2,[r0,#0x0]	; 037FDBB4
	cmp r2,#0xe	; 037FDBB6
	bcs loc_037FDBBE	; 037FDBB8
	mov r0,#0x0	; 037FDBBA
	b loc_037FDBD4	; 037FDBBC
loc_037FDBBE:
	cmp r2,#0xf	; 037FDBBE
	bls loc_037FDBC6	; 037FDBC0
	mov r0,#0x0	; 037FDBC2
	b loc_037FDBD4	; 037FDBC4
loc_037FDBC6:
	mov r2,#0x2	; 037FDBC6
	strb r2,[r0,#0x1]	; 037FDBC8
	ldr r2,[pool_037FDBDC]	; 037FDBCA
	strh r2,[r0,#0x3c]	; 037FDBCC
	bl loc_037FD7CC	; 037FDBCE
	mov r0,#0x1	; 037FDBD2
loc_037FDBD4:
	add sp,#0x4	; 037FDBD4
	pop {r3}	; 037FDBD6
	bx r3	; 037FDBD8
	.byte 0xC0, 0x46	; 037FDBDC
pool_037FDBDC:
loc_037FDBDC:
	.word 0x00001F46	; 037FDBDC

; ===== function loc_037FDBE0 =====
loc_037FDBE0:
	push {lr}	; 037FDBE0
	sub sp,#0x4	; 037FDBE2
	ldrb r3,[r0,#0x0]	; 037FDBE4
	cmp r3,#0x8	; 037FDBE6
	bcs loc_037FDBEE	; 037FDBE8
	mov r0,#0x0	; 037FDBEA
	b loc_037FDC08	; 037FDBEC
loc_037FDBEE:
	cmp r3,#0xd	; 037FDBEE
	bls loc_037FDBF6	; 037FDBF0
	mov r0,#0x0	; 037FDBF2
	b loc_037FDC08	; 037FDBF4
loc_037FDBF6:
	mov r3,#0x1	; 037FDBF6
	strb r3,[r0,#0x1]	; 037FDBF8
	str r1,[r0,#0x44]	; 037FDBFA
	ldr r1,[pool_037FDC10]	; 037FDBFC
	strh r1,[r0,#0x3c]	; 037FDBFE
	add r1,r2,#0x0	; 037FDC00
	bl loc_037FD7CC	; 037FDC02
	mov r0,#0x1	; 037FDC06
loc_037FDC08:
	add sp,#0x4	; 037FDC08
	pop {r3}	; 037FDC0A
	bx r3	; 037FDC0C
	.byte 0xC0, 0x46	; 037FDC10
pool_037FDC10:
loc_037FDC10:
	.word 0x00001F46	; 037FDC10

; ===== function loc_037FDC14 =====
loc_037FDC14:
	push {r4,r5,r6,lr}	; 037FDC14
	add r6,r0,#0x0	; 037FDC16
	add r5,r1,#0x0	; 037FDC18
	mov r0,#0x0	; 037FDC1A
	strb r0,[r6,#0x1]	; 037FDC1C
	add r4,r6,#0x0	; 037FDC1E
	add r4,#0x38	; 037FDC20
	ldmia r5!,{r0,r1}	; 037FDC22
	stmia r4!,{r0,r1}	; 037FDC24
	ldr r0,[r5,#0x0]	; 037FDC26
	str r0,[r4,#0x0]	; 037FDC28
	str r2,[r6,#0x44]	; 037FDC2A
	add r0,r6,#0x0	; 037FDC2C
	add r1,r3,#0x0	; 037FDC2E
	bl loc_037FD7CC	; 037FDC30
	mov r0,#0x1	; 037FDC34
	pop {r4,r5,r6}	; 037FDC36
	pop {r3}	; 037FDC38
	bx r3	; 037FDC3A

; ===== function loc_037FDC3C =====
P2_Entry_037FDC3C:
	push {r4,r5,r6,r7,lr}	; 037FDC3C
	sub sp,#0x24	; 037FDC3E
	str r0,[sp,#0x0]	; 037FDC40
	mov r0,#0x0	; 037FDC42
	str r0,[sp,#0x4]	; 037FDC44
	str r0,[sp,#0xc]	; 037FDC46
	str r0,[sp,#0x14]	; 037FDC48
	str r0,[sp,#0x1c]	; 037FDC4A
	str r0,[sp,#0x18]	; 037FDC4C
	str r0,[sp,#0x10]	; 037FDC4E
	str r0,[sp,#0x8]	; 037FDC50
loc_037FDC52:
	ldr r6,[sp,#0x8]	; 037FDC52
	lsl r7,r6,#0	; 037FDC54
	lsl r4,r6,#0	; 037FDC56
	ldr r1,[sp,#0x4]	; 037FDC58
	mov r0,#0x54	; 037FDC5A
	mul r1,r0	; 037FDC5C
	ldr r0,[pool_037FDE1C]	; 037FDC5E
	add r5,r0,r1	; 037FDC60
	ldrb r0,[r5,#0x3]	; 037FDC62
	lsl r1,r0,#0x1f	; 037FDC64
	lsr r1,r1,#0x1f	; 037FDC66
	cmp r1,#0x0	; 037FDC68
	bne loc_037FDC6E	; 037FDC6A
	b loc_037FDE08	; 037FDC6C
loc_037FDC6E:
	lsl r0,r0,#0x1e	; 037FDC6E
	lsr r0,r0,#0x1f	; 037FDC70
	cmp r0,#0x0	; 037FDC72
	beq loc_037FDC8C	; 037FDC74
	add r2,r5,#0x4	; 037FDC76
	ldrb r1,[r2,#0x0]	; 037FDC78
	mov r0,#0x1	; 037FDC7A
	orr r1,r0	; 037FDC7C
	strb r1,[r2,#0x0]	; 037FDC7E
	add r2,r5,#0x3	; 037FDC80
	ldrb r1,[r2,#0x0]	; 037FDC82
	mov r0,#0x2	; 037FDC84
	bic r1,r0	; 037FDC86
	strb r1,[r2,#0x0]	; 037FDC88
	b loc_037FDCC0	; 037FDC8A
loc_037FDC8C:
	ldr r0,[sp,#0x4]	; 037FDC8C
	bl loc_037FD044	; 037FDC8E
	cmp r0,#0x0	; 037FDC92
	bne loc_037FDCC0	; 037FDC94
	ldr r3,[r5,#0x48]	; 037FDC96
	cmp r3,#0x0	; 037FDC98
	beq loc_037FDCA8	; 037FDC9A
	add r0,r5,#0x0	; 037FDC9C
	mov r1,#0x2	; 037FDC9E
	ldr r2,[r5,#0x4c]	; 037FDCA0
	bl loc_03802A00	; 037FDCA2
	b loc_037FDCB0	; 037FDCA6
loc_037FDCA8:
	add r1,r5,#0x0	; 037FDCA8
	add r1,#0x22	; 037FDCAA
	ldr r0,[sp,#0xc]	; 037FDCAC
	strb r0,[r1,#0x0]	; 037FDCAE
loc_037FDCB0:
	ldr r0,[sp,#0x10]	; 037FDCB0
	strh r0,[r5,#0x24]	; 037FDCB2
	add r2,r5,#0x3	; 037FDCB4
	ldrb r1,[r2,#0x0]	; 037FDCB6
	mov r0,#0x1	; 037FDCB8
	bic r1,r0	; 037FDCBA
	strb r1,[r2,#0x0]	; 037FDCBC
	b loc_037FDE08	; 037FDCBE
loc_037FDCC0:
	ldrb r0,[r5,#0x9]	; 037FDCC0
	lsl r1,r0,#0x1	; 037FDCC2
	ldr r0,[pool_037FDE20]	; 037FDCC4
	ldrsh r0,[r0,r1]	; 037FDCC6
	add r6,r6,r0	; 037FDCC8
	ldrb r1,[r5,#0x8]	; 037FDCCA
	ldrb r0,[r5,#0x5]	; 037FDCCC
	sub r0,r1,r0	; 037FDCCE
	lsl r0,r0,#0x6	; 037FDCD0
	add r7,r7,r0	; 037FDCD2
	add r0,r5,#0x0	; 037FDCD4
	ldr r1,[sp,#0x0]	; 037FDCD6
	bl loc_037FD6C8	; 037FDCD8
	add r6,r6,r0	; 037FDCDC
	add r0,r5,#0x0	; 037FDCDE
	ldr r1,[sp,#0x0]	; 037FDCE0
	bl loc_037FD678	; 037FDCE2
	add r7,r7,r0	; 037FDCE6
	add r0,r5,#0x0	; 037FDCE8
	ldr r1,[sp,#0x0]	; 037FDCEA
	bl loc_037FD5F8	; 037FDCEC
	add r1,r5,#0x0	; 037FDCF0
	add r1,#0x28	; 037FDCF2
	ldrb r1,[r1,#0x0]	; 037FDCF4
	cmp r1,#0x0	; 037FDCF6
	beq loc_037FDD08	; 037FDCF8
	cmp r1,#0x1	; 037FDCFA
	beq loc_037FDD04	; 037FDCFC
	cmp r1,#0x2	; 037FDCFE
	beq loc_037FDD0C	; 037FDD00
	b loc_037FDD0E	; 037FDD02
loc_037FDD04:
	add r6,r6,r0	; 037FDD04
	b loc_037FDD0E	; 037FDD06
loc_037FDD08:
	add r7,r7,r0	; 037FDD08
	b loc_037FDD0E	; 037FDD0A
loc_037FDD0C:
	add r4,r4,r0	; 037FDD0C
loc_037FDD0E:
	mov r0,#0xc	; 037FDD0E
	ldrsh r0,[r5,r0]	; 037FDD10
	add r6,r6,r0	; 037FDD12
	mov r0,#0xe	; 037FDD14
	ldrsh r0,[r5,r0]	; 037FDD16
	add r7,r7,r0	; 037FDD18
	mov r0,#0xb	; 037FDD1A
	ldrsb r0,[r5,r0]	; 037FDD1C
	add r1,r4,r0	; 037FDD1E
	mov r0,#0xa	; 037FDD20
	ldrsb r0,[r5,r0]	; 037FDD22
	add r4,r1,r0	; 037FDD24
	ldrb r0,[r5,#0x2]	; 037FDD26
	cmp r0,#0x3	; 037FDD28
	bne loc_037FDD60	; 037FDD2A
	ldr r0,[pool_037FDE24]	; 037FDD2C
	cmp r6,r0	; 037FDD2E
	bgt loc_037FDD60	; 037FDD30
	mov r0,#0x2	; 037FDD32
	strb r0,[r5,#0x4]	; 037FDD34
	ldr r3,[r5,#0x48]	; 037FDD36
	cmp r3,#0x0	; 037FDD38
	beq loc_037FDD48	; 037FDD3A
	add r0,r5,#0x0	; 037FDD3C
	mov r1,#0x2	; 037FDD3E
	ldr r2,[r5,#0x4c]	; 037FDD40
	bl loc_03802A00	; 037FDD42
	b loc_037FDD50	; 037FDD46
loc_037FDD48:
	add r1,r5,#0x0	; 037FDD48
	add r1,#0x22	; 037FDD4A
	ldr r0,[sp,#0x14]	; 037FDD4C
	strb r0,[r1,#0x0]	; 037FDD4E
loc_037FDD50:
	ldr r0,[sp,#0x18]	; 037FDD50
	strh r0,[r5,#0x24]	; 037FDD52
	add r2,r5,#0x3	; 037FDD54
	ldrb r1,[r2,#0x0]	; 037FDD56
	mov r0,#0x1	; 037FDD58
	bic r1,r0	; 037FDD5A
	strb r1,[r2,#0x0]	; 037FDD5C
	b loc_037FDE08	; 037FDD5E
loc_037FDD60:
	add r0,r6,#0x0	; 037FDD60
	bl loc_037FD300	; 037FDD62
	add r6,r0,#0x0	; 037FDD66
	ldrh r0,[r5,#0x3c]	; 037FDD68
	add r1,r7,#0x0	; 037FDD6A
	bl loc_037FD358	; 037FDD6C
	ldrb r1,[r5,#0x1]	; 037FDD70
	cmp r1,#0x1	; 037FDD72
	bne loc_037FDD7E	; 037FDD74
	ldr r1,[pool_037FDE28]	; 037FDD76
	and r0,r1	; 037FDD78
	lsl r0,r0,#0x10	; 037FDD7A
	lsr r0,r0,#0x10	; 037FDD7C
loc_037FDD7E:
	add r4,#0x40	; 037FDD7E
	cmp r4,#0x0	; 037FDD80
	bge loc_037FDD88	; 037FDD82
	ldr r4,[sp,#0x1c]	; 037FDD84
	b loc_037FDD8E	; 037FDD86
loc_037FDD88:
	cmp r4,#0x7f	; 037FDD88
	ble loc_037FDD8E	; 037FDD8A
	mov r4,#0x7f	; 037FDD8C
loc_037FDD8E:
	ldrh r1,[r5,#0x24]	; 037FDD8E
	cmp r6,r1	; 037FDD90
	beq loc_037FDDA0	; 037FDD92
	strh r6,[r5,#0x24]	; 037FDD94
	add r3,r5,#0x4	; 037FDD96
	ldrb r2,[r3,#0x0]	; 037FDD98
	mov r1,#0x8	; 037FDD9A
	orr r2,r1	; 037FDD9C
	strb r2,[r3,#0x0]	; 037FDD9E
loc_037FDDA0:
	ldrh r1,[r5,#0x26]	; 037FDDA0
	cmp r0,r1	; 037FDDA2
	beq loc_037FDDB2	; 037FDDA4
	strh r0,[r5,#0x26]	; 037FDDA6
	add r2,r5,#0x4	; 037FDDA8
	ldrb r1,[r2,#0x0]	; 037FDDAA
	mov r0,#0x4	; 037FDDAC
	orr r1,r0	; 037FDDAE
	strb r1,[r2,#0x0]	; 037FDDB0
loc_037FDDB2:
	add r0,r5,#0x0	; 037FDDB2
	add r0,#0x23	; 037FDDB4
	ldrb r0,[r0,#0x0]	; 037FDDB6
	cmp r4,r0	; 037FDDB8
	beq loc_037FDDCC	; 037FDDBA
	add r0,r5,#0x0	; 037FDDBC
	add r0,#0x23	; 037FDDBE
	strb r4,[r0,#0x0]	; 037FDDC0
	add r2,r5,#0x4	; 037FDDC2
	ldrb r1,[r2,#0x0]	; 037FDDC4
	mov r0,#0x10	; 037FDDC6
	orr r1,r0	; 037FDDC8
	strb r1,[r2,#0x0]	; 037FDDCA
loc_037FDDCC:
	ldr r0,[sp,#0x0]	; 037FDDCC
	cmp r0,#0x0	; 037FDDCE
	beq loc_037FDE08	; 037FDDD0
	ldr r0,[r5,#0x34]	; 037FDDD2
	cmp r0,#0x0	; 037FDDD4
	ble loc_037FDE08	; 037FDDD6
	add r1,r5,#0x0	; 037FDDD8
	add r1,#0x34	; 037FDDDA
	ldr r0,[r1,#0x0]	; 037FDDDC
	sub r0,r0,#0x1	; 037FDDDE
	str r0,[r1,#0x0]	; 037FDDE0
	ldr r0,[r5,#0x34]	; 037FDDE2
	cmp r0,#0x0	; 037FDDE4
	bne loc_037FDE08	; 037FDDE6
	ldr r3,[r5,#0x48]	; 037FDDE8
	cmp r3,#0x0	; 037FDDEA
	beq loc_037FDDFA	; 037FDDEC
	add r0,r5,#0x0	; 037FDDEE
	mov r1,#0x1	; 037FDDF0
	ldr r2,[r5,#0x4c]	; 037FDDF2
	bl loc_03802A00	; 037FDDF4
	b loc_037FDE02	; 037FDDF8
loc_037FDDFA:
	add r1,r5,#0x0	; 037FDDFA
	add r1,#0x22	; 037FDDFC
	mov r0,#0x1	; 037FDDFE
	strb r0,[r1,#0x0]	; 037FDE00
loc_037FDE02:
	add r0,r5,#0x0	; 037FDE02
	bl loc_037FDB60	; 037FDE04
loc_037FDE08:
	ldr r0,[sp,#0x4]	; 037FDE08
	add r0,r0,#0x1	; 037FDE0A
	str r0,[sp,#0x4]	; 037FDE0C
	cmp r0,#0x10	; 037FDE0E
	bge loc_037FDE14	; 037FDE10
	b loc_037FDC52	; 037FDE12
loc_037FDE14:
	add sp,#0x24	; 037FDE14
	pop {r4,r5,r6,r7}	; 037FDE16
	pop {r3}	; 037FDE18
	bx r3	; 037FDE1A
pool_037FDE1C:
loc_037FDE1C:
	.word 0x0380387C	; 037FDE1C
pool_037FDE20:
loc_037FDE20:
	.word P2_Data_03802A90	; 037FDE20
pool_037FDE24:
loc_037FDE24:
	.word 0xFFFFFD2D	; 037FDE24
pool_037FDE28:
loc_037FDE28:
	.word 0x0000FFFC	; 037FDE28
P2_Entry_037FDE2C:
	push {r4,r5,r6,r7,lr}	; 037FDE2C
	sub sp,#0x1c	; 037FDE2E
	mov r4,#0x0	; 037FDE30
	add r7,r4,#0x0	; 037FDE32
	mov r6,#0xff	; 037FDE34
P2_Entry_037FDE36:
	add r1,r4,#0x0	; 037FDE36
	mov r0,#0x54	; 037FDE38
	mul r1,r0	; 037FDE3A
	ldr r0,[pool_037FDF64]	; 037FDE3C
	add r5,r0,r1	; 037FDE3E
	ldrb r1,[r5,#0x4]	; 037FDE40
	cmp r1,#0x0	; 037FDE42
	beq P2_Entry_037FDF24	; 037FDE44
	mov r0,#0x2	; 037FDE46
	and r1,r0	; 037FDE48
	cmp r1,#0x0	; 037FDE4A
	beq P2_Entry_037FDE56	; 037FDE4C
	add r0,r4,#0x0	; 037FDE4E
	add r1,r7,#0x0	; 037FDE50
	bl loc_037FD110	; 037FDE52
P2_Entry_037FDE56:
	ldrb r0,[r5,#0x4]	; 037FDE56
	add r2,r0,#0x0	; 037FDE58
	mov r1,#0x1	; 037FDE5A
	and r2,r1	; 037FDE5C
	cmp r2,#0x0	; 037FDE5E
	beq P2_Entry_037FDEE8	; 037FDE60
	ldrb r0,[r5,#0x1]	; 037FDE62
	cmp r0,#0x0	; 037FDE64
	beq P2_Entry_037FDE72	; 037FDE66
	cmp r0,#0x1	; 037FDE68
	beq P2_Entry_037FDEB0	; 037FDE6A
	cmp r0,#0x2	; 037FDE6C
	beq P2_Entry_037FDECE	; 037FDE6E
	b P2_Entry_037FDF24	; 037FDE70
P2_Entry_037FDE72:
	add r0,r5,#0x0	; 037FDE72
	add r0,#0x39	; 037FDE74
	ldrb r0,[r0,#0x0]	; 037FDE76
	cmp r0,#0x0	; 037FDE78
	beq P2_Entry_037FDE80	; 037FDE7A
	lsl r3,r1,#0	; 037FDE7C
	b P2_Entry_037FDE82	; 037FDE7E
P2_Entry_037FDE80:
	mov r3,#0x2	; 037FDE80
P2_Entry_037FDE82:
	ldrh r0,[r5,#0x24]	; 037FDE82
	ldrh r1,[r5,#0x3e]	; 037FDE84
	str r1,[sp,#0x0]	; 037FDE86
	ldr r1,[r5,#0x40]	; 037FDE88
	str r1,[sp,#0x4]	; 037FDE8A
	add r1,r0,#0x0	; 037FDE8C
	and r1,r6	; 037FDE8E
	str r1,[sp,#0x8]	; 037FDE90
	asr r0,r0,#0x8	; 037FDE92
	str r0,[sp,#0xc]	; 037FDE94
	ldrh r0,[r5,#0x26]	; 037FDE96
	str r0,[sp,#0x10]	; 037FDE98
	add r0,r5,#0x0	; 037FDE9A
	add r0,#0x23	; 037FDE9C
	ldrb r0,[r0,#0x0]	; 037FDE9E
	str r0,[sp,#0x14]	; 037FDEA0
	add r0,r4,#0x0	; 037FDEA2
	ldr r1,[r5,#0x44]	; 037FDEA4
	add r5,#0x38	; 037FDEA6
	ldrb r2,[r5,#0x0]	; 037FDEA8
	bl loc_037FD20C	; 037FDEAA
	b P2_Entry_037FDF24	; 037FDEAE
P2_Entry_037FDEB0:
	ldrh r3,[r5,#0x24]	; 037FDEB0
	ldrh r0,[r5,#0x26]	; 037FDEB2
	str r0,[sp,#0x0]	; 037FDEB4
	add r0,r5,#0x0	; 037FDEB6
	add r0,#0x23	; 037FDEB8
	ldrb r0,[r0,#0x0]	; 037FDEBA
	str r0,[sp,#0x4]	; 037FDEBC
	add r0,r4,#0x0	; 037FDEBE
	ldr r1,[r5,#0x44]	; 037FDEC0
	add r2,r3,#0x0	; 037FDEC2
	and r2,r6	; 037FDEC4
	asr r3,r3,#0x8	; 037FDEC6
	bl loc_037FD1A0	; 037FDEC8
	b P2_Entry_037FDF24	; 037FDECC
P2_Entry_037FDECE:
	ldrh r2,[r5,#0x24]	; 037FDECE
	add r0,r5,#0x0	; 037FDED0
	add r0,#0x23	; 037FDED2
	ldrb r0,[r0,#0x0]	; 037FDED4
	str r0,[sp,#0x0]	; 037FDED6
	add r0,r4,#0x0	; 037FDED8
	add r1,r2,#0x0	; 037FDEDA
	and r1,r6	; 037FDEDC
	asr r2,r2,#0x8	; 037FDEDE
	ldrh r3,[r5,#0x26]	; 037FDEE0
	bl loc_037FD138	; 037FDEE2
	b P2_Entry_037FDF24	; 037FDEE6
P2_Entry_037FDEE8:
	mov r1,#0x4	; 037FDEE8
	and r0,r1	; 037FDEEA
	cmp r0,#0x0	; 037FDEEC
	beq P2_Entry_037FDEF8	; 037FDEEE
	add r0,r4,#0x0	; 037FDEF0
	ldrh r1,[r5,#0x26]	; 037FDEF2
	bl loc_037FD0A4	; 037FDEF4
P2_Entry_037FDEF8:
	ldrb r1,[r5,#0x4]	; 037FDEF8
	mov r0,#0x8	; 037FDEFA
	and r1,r0	; 037FDEFC
	cmp r1,#0x0	; 037FDEFE
	beq P2_Entry_037FDF10	; 037FDF00
	ldrh r2,[r5,#0x24]	; 037FDF02
	add r0,r4,#0x0	; 037FDF04
	add r1,r2,#0x0	; 037FDF06
	and r1,r6	; 037FDF08
	asr r2,r2,#0x8	; 037FDF0A
	bl loc_037FD0B8	; 037FDF0C
P2_Entry_037FDF10:
	ldrb r1,[r5,#0x4]	; 037FDF10
	mov r0,#0x10	; 037FDF12
	and r1,r0	; 037FDF14
	cmp r1,#0x0	; 037FDF16
	beq P2_Entry_037FDF24	; 037FDF18
	add r0,r4,#0x0	; 037FDF1A
	add r5,#0x23	; 037FDF1C
	ldrb r1,[r5,#0x0]	; 037FDF1E
	bl loc_037FD060	; 037FDF20
P2_Entry_037FDF24:
	add r4,r4,#0x1	; 037FDF24
	cmp r4,#0x10	; 037FDF26
	blt P2_Entry_037FDE36	; 037FDF28
	mov r2,#0x0	; 037FDF2A
	add r5,r2,#0x0	; 037FDF2C
	ldr r0,[pool_037FDF64]	; 037FDF2E
	mov r4,#0x54	; 037FDF30
P2_Entry_037FDF32:
	add r1,r2,#0x0	; 037FDF32
	mul r1,r4	; 037FDF34
	add r1,r0,r1	; 037FDF36
	ldrb r6,[r1,#0x4]	; 037FDF38
	cmp r6,#0x0	; 037FDF3A
	beq P2_Entry_037FDF56	; 037FDF3C
	mov r3,#0x1	; 037FDF3E
	and r6,r3	; 037FDF40
	cmp r6,#0x0	; 037FDF42
	beq P2_Entry_037FDF54	; 037FDF44
	lsl r6,r2,#0x4	; 037FDF46
	ldr r3,[pool_037FDF68]	; 037FDF48
	add r7,r6,r3	; 037FDF4A
	ldrb r6,[r7,#0x0]	; 037FDF4C
	mov r3,#0x80	; 037FDF4E
	orr r6,r3	; 037FDF50
	strb r6,[r7,#0x0]	; 037FDF52
P2_Entry_037FDF54:
	strb r5,[r1,#0x4]	; 037FDF54
P2_Entry_037FDF56:
	add r2,r2,#0x1	; 037FDF56
	cmp r2,#0x10	; 037FDF58
	blt P2_Entry_037FDF32	; 037FDF5A
	add sp,#0x1c	; 037FDF5C
	pop {r4,r5,r6,r7}	; 037FDF5E
	pop {r3}	; 037FDF60
	bx r3	; 037FDF62
pool_037FDF64:
	.word 0x0380387C	; 037FDF64
pool_037FDF68:
	.word SCHANNEL0_CR + 3	; 037FDF68
P2_Entry_037FDF6C:
	push {r4,r5,r6,lr}	; 037FDF6C
	mov r0,#0x0	; 037FDF6E
	ldr r6,[pool_037FDFA0]	; 037FDF70
	add r5,r0,#0x0	; 037FDF72
	mov r1,#0x54	; 037FDF74
	mov r2,#0x1	; 037FDF76
P2_Entry_037FDF78:
	add r3,r0,#0x0	; 037FDF78
	mul r3,r1	; 037FDF7A
	add r4,r6,r3	; 037FDF7C
	strb r0,[r6,r3]	; 037FDF7E
	strb r5,[r4,#0x4]	; 037FDF80
	add r4,r4,#0x3	; 037FDF82
	ldrb r3,[r4,#0x0]	; 037FDF84
	bic r3,r2	; 037FDF86
	strb r3,[r4,#0x0]	; 037FDF88
	add r0,r0,#0x1	; 037FDF8A
	cmp r0,#0x10	; 037FDF8C
	blt P2_Entry_037FDF78	; 037FDF8E
	ldr r0,[pool_037FDFA4]	; 037FDF90
	str r5,[r0,#0x0]	; 037FDF92
	ldr r0,[pool_037FDFA8]	; 037FDF94
	str r5,[r0,#0x0]	; 037FDF96
	pop {r4,r5,r6}	; 037FDF98
	pop {r3}	; 037FDF9A
	bx r3	; 037FDF9C
	.byte 0xC0, 0x46	; 037FDF9E
pool_037FDFA0:
	.word P2_BssStart + 0xB74	; 037FDFA0
pool_037FDFA4:
	.word P2_BssStart + 0xB54	; 037FDFA4
pool_037FDFA8:
	.word P2_BssStart + 0xB50	; 037FDFA8

; ===== function loc_037FDFAC =====
loc_037FDFAC:
	push {r4,lr}	; 037FDFAC
	mov r0,#0x0	; 037FDFAE
	ldr r3,[pool_037FDFDC]	; 037FDFB0
	b loc_037FDFCE	; 037FDFB2
loc_037FDFB4:
	lsl r1,r0,#0x6	; 037FDFB4
	add r4,r3,r1	; 037FDFB6
	ldrb r2,[r3,r1]	; 037FDFB8
	lsl r1,r2,#0x1f	; 037FDFBA
	lsr r1,r1,#0x1f	; 037FDFBC
	cmp r1,#0x0	; 037FDFBE
	bne loc_037FDFCC	; 037FDFC0
	mov r1,#0x1	; 037FDFC2
	bic r2,r1	; 037FDFC4
	orr r2,r1	; 037FDFC6
	strb r2,[r4,#0x0]	; 037FDFC8
	b loc_037FDFD6	; 037FDFCA
loc_037FDFCC:
	add r0,r0,#0x1	; 037FDFCC
loc_037FDFCE:
	cmp r0,#0x20	; 037FDFCE
	blt loc_037FDFB4	; 037FDFD0
	mov r0,#0x0	; 037FDFD2
	mvn r0,r0	; 037FDFD4
loc_037FDFD6:
	pop {r4}	; 037FDFD6
	pop {r3}	; 037FDFD8
	bx r3	; 037FDFDA
pool_037FDFDC:
loc_037FDFDC:
	.word 0x03803FFC	; 037FDFDC

; ===== function loc_037FDFE0 =====
loc_037FDFE0:
	ldr r2,[pool_037FE00C]	; 037FDFE0
	ldr r3,[r2,#0x0]	; 037FDFE2
	cmp r3,#0x0	; 037FDFE4
	bne loc_037FDFEC	; 037FDFE6
	mov r0,#0x0	; 037FDFE8
	bx lr	; 037FDFEA
loc_037FDFEC:
	cmp r1,#0x10	; 037FDFEC
	bge loc_037FE000	; 037FDFEE
	add r3,#0x20	; 037FDFF0
	ldrb r2,[r0,#0x2]	; 037FDFF2
	mov r0,#0x24	; 037FDFF4
	mul r2,r0	; 037FDFF6
	add r2,r3,r2	; 037FDFF8
	lsl r0,r1,#0x1	; 037FDFFA
	add r0,r2,r0	; 037FDFFC
	bx lr	; 037FDFFE
loc_037FE000:
	ldr r0,[pool_037FE010]	; 037FE000
	add r2,r3,r0	; 037FE002
	sub r1,#0x10	; 037FE004
	lsl r0,r1,#0x1	; 037FE006
	add r0,r2,r0	; 037FE008
	bx lr	; 037FE00A
pool_037FE00C:
loc_037FE00C:
	.word P2_BssStart + 0xB70	; 037FE00C
pool_037FE010:
loc_037FE010:
	.word 0x00000260	; 037FE010
P2_Entry_037FE014:
	push {r4,r5,r6,r7,lr}	; 037FE014
	sub sp,#0x4	; 037FE016
	add r5,r0,#0x0	; 037FE018
	mov r6,#0x0	; 037FE01A
	add r4,r6,#0x0	; 037FE01C
	mov r7,#0x1	; 037FE01E
P2_Entry_037FE020:
	add r0,r5,#0x0	; 037FE020
	add r1,r4,#0x0	; 037FE022
	bl loc_037FE958	; 037FE024
	cmp r0,#0x0	; 037FE028
	beq P2_Entry_037FE048	; 037FE02A
	ldr r1,[r0,#0x28]	; 037FE02C
	cmp r1,#0x0	; 037FE02E
	beq P2_Entry_037FE048	; 037FE030
	add r1,r5,#0x0	; 037FE032
	bl P2_Entry_037FE060	; 037FE034
	cmp r0,#0x0	; 037FE038
	bne P2_Entry_037FE040	; 037FE03A
	add r6,r7,#0x0	; 037FE03C
	b P2_Entry_037FE048	; 037FE03E
P2_Entry_037FE040:
	add r0,r5,#0x0	; 037FE040
	add r1,r4,#0x0	; 037FE042
	bl loc_037FE914	; 037FE044
P2_Entry_037FE048:
	add r4,r4,#0x1	; 037FE048
	cmp r4,#0x10	; 037FE04A
	blt P2_Entry_037FE020	; 037FE04C
	cmp r6,#0x0	; 037FE04E
	bne P2_Entry_037FE056	; 037FE050
	mov r0,#0x1	; 037FE052
	b P2_Entry_037FE058	; 037FE054
P2_Entry_037FE056:
	mov r0,#0x0	; 037FE056
P2_Entry_037FE058:
	add sp,#0x4	; 037FE058
	pop {r4,r5,r6,r7}	; 037FE05A
	pop {r3}	; 037FE05C
	bx r3	; 037FE05E
P2_Entry_037FE060:
	push {r4,r5,r6,r7,lr}	; 037FE060
	sub sp,#0x24	; 037FE062
	add r4,r0,#0x0	; 037FE064
	str r1,[sp,#0x4]	; 037FE066
	ldrb r1,[r4,#0x0]	; 037FE068
	lsl r0,r1,#0x1b	; 037FE06A
	lsr r0,r0,#0x1f	; 037FE06C
	cmp r0,#0x0	; 037FE06E
	beq P2_Entry_037FE082	; 037FE070
	ldr r0,[r4,#0x3c]	; 037FE072
	cmp r0,#0x0	; 037FE074
	beq P2_Entry_037FE07C	; 037FE076
	mov r0,#0x0	; 037FE078
	b P2_Entry_037FE684	; 037FE07A
P2_Entry_037FE07C:
	mov r0,#0x10	; 037FE07C
	bic r1,r0	; 037FE07E
	strb r1,[r4,#0x0]	; 037FE080
P2_Entry_037FE082:
	ldr r0,[r4,#0x20]	; 037FE082
	cmp r0,#0x0	; 037FE084
	ble P2_Entry_037FE09C	; 037FE086
	add r1,r4,#0x0	; 037FE088
	add r1,#0x20	; 037FE08A
	ldr r0,[r1,#0x0]	; 037FE08C
	sub r0,r0,#0x1	; 037FE08E
	str r0,[r1,#0x0]	; 037FE090
	ldr r0,[r4,#0x20]	; 037FE092
	cmp r0,#0x0	; 037FE094
	ble P2_Entry_037FE09C	; 037FE096
	mov r0,#0x0	; 037FE098
	b P2_Entry_037FE684	; 037FE09A
P2_Entry_037FE09C:
	ldr r0,[r4,#0x28]	; 037FE09C
	bl loc_037FECA8	; 037FE09E
	mov r0,#0x0	; 037FE0A2
	mvn r0,r0	; 037FE0A4
	str r0,[sp,#0x18]	; 037FE0A6
	b P2_Entry_037FE670	; 037FE0A8
P2_Entry_037FE0AA:
	mov r5,#0x0	; 037FE0AA
	mov r0,#0x1	; 037FE0AC
	str r0,[sp,#0xc]	; 037FE0AE
	add r0,r4,#0x0	; 037FE0B0
	bl loc_037FEC60	; 037FE0B2
	add r6,r0,#0x0	; 037FE0B6
	cmp r6,#0xa2	; 037FE0B8
	bne P2_Entry_037FE0CC	; 037FE0BA
	add r0,r4,#0x0	; 037FE0BC
	bl loc_037FEC60	; 037FE0BE
	add r6,r0,#0x0	; 037FE0C2
	ldrb r0,[r4,#0x0]	; 037FE0C4
	lsl r0,r0,#0x19	; 037FE0C6
	lsr r0,r0,#0x1f	; 037FE0C8
	str r0,[sp,#0xc]	; 037FE0CA
P2_Entry_037FE0CC:
	cmp r6,#0xa0	; 037FE0CC
	bne P2_Entry_037FE0DE	; 037FE0CE
	add r0,r4,#0x0	; 037FE0D0
	bl loc_037FEC60	; 037FE0D2
	add r6,r0,#0x0	; 037FE0D6
	mov r0,#0x3	; 037FE0D8
	str r0,[sp,#0x8]	; 037FE0DA
	mov r5,#0x1	; 037FE0DC
P2_Entry_037FE0DE:
	cmp r6,#0xa1	; 037FE0DE
	bne P2_Entry_037FE0F0	; 037FE0E0
	add r0,r4,#0x0	; 037FE0E2
	bl loc_037FEC60	; 037FE0E4
	add r6,r0,#0x0	; 037FE0E8
	mov r0,#0x4	; 037FE0EA
	str r0,[sp,#0x8]	; 037FE0EC
	mov r5,#0x1	; 037FE0EE
P2_Entry_037FE0F0:
	add r1,r6,#0x0	; 037FE0F0
	mov r0,#0x80	; 037FE0F2
	and r1,r0	; 037FE0F4
	cmp r1,#0x0	; 037FE0F6
	bne P2_Entry_037FE16A	; 037FE0F8
	add r0,r4,#0x0	; 037FE0FA
	bl loc_037FEC60	; 037FE0FC
	str r0,[sp,#0x10]	; 037FE100
	cmp r5,#0x0	; 037FE102
	beq P2_Entry_037FE10A	; 037FE104
	ldr r2,[sp,#0x8]	; 037FE106
	b P2_Entry_037FE10C	; 037FE108
P2_Entry_037FE10A:
	mov r2,#0x2	; 037FE10A
P2_Entry_037FE10C:
	add r0,r4,#0x0	; 037FE10C
	ldr r1,[sp,#0x4]	; 037FE10E
	bl P2_Entry_037FEB34	; 037FE110
	add r7,r0,#0x0	; 037FE114
	mov r0,#0x13	; 037FE116
	ldrsb r0,[r4,r0]	; 037FE118
	add r5,r6,r0	; 037FE11A
	ldr r0,[sp,#0xc]	; 037FE11C
	cmp r0,#0x0	; 037FE11E
	bne P2_Entry_037FE124	; 037FE120
	b P2_Entry_037FE670	; 037FE122
P2_Entry_037FE124:
	cmp r5,#0x0	; 037FE124
	bge P2_Entry_037FE12C	; 037FE126
	mov r5,#0x0	; 037FE128
	b P2_Entry_037FE132	; 037FE12A
P2_Entry_037FE12C:
	cmp r5,#0x7f	; 037FE12C
	ble P2_Entry_037FE132	; 037FE12E
	mov r5,#0x7f	; 037FE130
P2_Entry_037FE132:
	ldrb r0,[r4,#0x0]	; 037FE132
	lsl r0,r0,#0x1d	; 037FE134
	lsr r0,r0,#0x1f	; 037FE136
	cmp r0,#0x0	; 037FE138
	bne P2_Entry_037FE14A	; 037FE13A
	str r7,[sp,#0x0]	; 037FE13C
	add r0,r4,#0x0	; 037FE13E
	ldr r1,[sp,#0x4]	; 037FE140
	add r2,r5,#0x0	; 037FE142
	ldr r3,[sp,#0x10]	; 037FE144
	bl P2_Entry_037FE68C	; 037FE146
P2_Entry_037FE14A:
	strb r5,[r4,#0x14]	; 037FE14A
	ldrb r0,[r4,#0x0]	; 037FE14C
	lsl r0,r0,#0x1e	; 037FE14E
	lsr r0,r0,#0x1f	; 037FE150
	cmp r0,#0x0	; 037FE152
	bne P2_Entry_037FE158	; 037FE154
	b P2_Entry_037FE670	; 037FE156
P2_Entry_037FE158:
	str r7,[r4,#0x20]	; 037FE158
	cmp r7,#0x0	; 037FE15A
	beq P2_Entry_037FE160	; 037FE15C
	b P2_Entry_037FE670	; 037FE15E
P2_Entry_037FE160:
	ldrb r1,[r4,#0x0]	; 037FE160
	mov r0,#0x10	; 037FE162
	orr r1,r0	; 037FE164
	strb r1,[r4,#0x0]	; 037FE166
	b P2_Entry_037FE670	; 037FE168
P2_Entry_037FE16A:
	add r1,r6,#0x0	; 037FE16A
	mov r0,#0xf0	; 037FE16C
	and r1,r0	; 037FE16E
	cmp r1,#0xc0	; 037FE170
	bgt P2_Entry_037FE18E	; 037FE172
	cmp r1,#0xc0	; 037FE174
	bge P2_Entry_037FE272	; 037FE176
	cmp r1,#0x90	; 037FE178
	bgt P2_Entry_037FE186	; 037FE17A
	cmp r1,#0x90	; 037FE17C
	bge P2_Entry_037FE1DA	; 037FE17E
	cmp r1,#0x80	; 037FE180
	beq P2_Entry_037FE1A6	; 037FE182
	b P2_Entry_037FE670	; 037FE184
P2_Entry_037FE186:
	cmp r1,#0xb0	; 037FE186
	bne P2_Entry_037FE18C	; 037FE188
	b P2_Entry_037FE43E	; 037FE18A
P2_Entry_037FE18C:
	b P2_Entry_037FE670	; 037FE18C
P2_Entry_037FE18E:
	cmp r1,#0xe0	; 037FE18E
	bgt P2_Entry_037FE19E	; 037FE190
	cmp r1,#0xe0	; 037FE192
	blt P2_Entry_037FE198	; 037FE194
	b P2_Entry_037FE404	; 037FE196
P2_Entry_037FE198:
	cmp r1,#0xd0	; 037FE198
	beq P2_Entry_037FE272	; 037FE19A
	b P2_Entry_037FE670	; 037FE19C
P2_Entry_037FE19E:
	cmp r1,#0xf0	; 037FE19E
	bne P2_Entry_037FE1A4	; 037FE1A0
	b P2_Entry_037FE5E0	; 037FE1A2
P2_Entry_037FE1A4:
	b P2_Entry_037FE670	; 037FE1A4
P2_Entry_037FE1A6:
	cmp r5,#0x0	; 037FE1A6
	beq P2_Entry_037FE1AE	; 037FE1A8
	ldr r2,[sp,#0x8]	; 037FE1AA
	b P2_Entry_037FE1B0	; 037FE1AC
P2_Entry_037FE1AE:
	mov r2,#0x2	; 037FE1AE
P2_Entry_037FE1B0:
	add r0,r4,#0x0	; 037FE1B0
	ldr r1,[sp,#0x4]	; 037FE1B2
	bl P2_Entry_037FEB34	; 037FE1B4
	ldr r1,[sp,#0xc]	; 037FE1B8
	cmp r1,#0x0	; 037FE1BA
	bne P2_Entry_037FE1C0	; 037FE1BC
	b P2_Entry_037FE670	; 037FE1BE
P2_Entry_037FE1C0:
	cmp r6,#0x80	; 037FE1C0
	beq P2_Entry_037FE1CA	; 037FE1C2
	cmp r6,#0x81	; 037FE1C4
	beq P2_Entry_037FE1CE	; 037FE1C6
	b P2_Entry_037FE670	; 037FE1C8
P2_Entry_037FE1CA:
	str r0,[r4,#0x20]	; 037FE1CA
	b P2_Entry_037FE670	; 037FE1CC
P2_Entry_037FE1CE:
	ldr r1,[pool_037FE510]	; 037FE1CE
	cmp r0,r1	; 037FE1D0
	blt P2_Entry_037FE1D6	; 037FE1D2
	b P2_Entry_037FE670	; 037FE1D4
P2_Entry_037FE1D6:
	strh r0,[r4,#0x2]	; 037FE1D6
	b P2_Entry_037FE670	; 037FE1D8
P2_Entry_037FE1DA:
	cmp r6,#0x93	; 037FE1DA
	beq P2_Entry_037FE1E8	; 037FE1DC
	cmp r6,#0x94	; 037FE1DE
	beq P2_Entry_037FE228	; 037FE1E0
	cmp r6,#0x95	; 037FE1E2
	beq P2_Entry_037FE23E	; 037FE1E4
	b P2_Entry_037FE670	; 037FE1E6
P2_Entry_037FE1E8:
	add r0,r4,#0x0	; 037FE1E8
	bl loc_037FEC60	; 037FE1EA
	add r5,r0,#0x0	; 037FE1EE
	add r0,r4,#0x0	; 037FE1F0
	bl P2_Entry_037FEBE0	; 037FE1F2
	add r6,r0,#0x0	; 037FE1F6
	ldr r0,[sp,#0xc]	; 037FE1F8
	cmp r0,#0x0	; 037FE1FA
	bne P2_Entry_037FE200	; 037FE1FC
	b P2_Entry_037FE670	; 037FE1FE
P2_Entry_037FE200:
	ldr r0,[sp,#0x4]	; 037FE200
	add r1,r5,#0x0	; 037FE202
	bl loc_037FE958	; 037FE204
	add r5,r0,#0x0	; 037FE208
	cmp r5,#0x0	; 037FE20A
	bne P2_Entry_037FE210	; 037FE20C
	b P2_Entry_037FE670	; 037FE20E
P2_Entry_037FE210:
	cmp r5,r4	; 037FE210
	bne P2_Entry_037FE216	; 037FE212
	b P2_Entry_037FE670	; 037FE214
P2_Entry_037FE216:
	ldr r1,[sp,#0x4]	; 037FE216
	bl loc_037FE94C	; 037FE218
	add r0,r5,#0x0	; 037FE21C
	ldr r1,[r4,#0x24]	; 037FE21E
	add r2,r6,#0x0	; 037FE220
	bl loc_037FEA94	; 037FE222
	b P2_Entry_037FE670	; 037FE226
P2_Entry_037FE228:
	add r0,r4,#0x0	; 037FE228
	bl P2_Entry_037FEBE0	; 037FE22A
	ldr r1,[sp,#0xc]	; 037FE22E
	cmp r1,#0x0	; 037FE230
	bne P2_Entry_037FE236	; 037FE232
	b P2_Entry_037FE670	; 037FE234
P2_Entry_037FE236:
	ldr r1,[r4,#0x24]	; 037FE236
	add r0,r1,r0	; 037FE238
	str r0,[r4,#0x28]	; 037FE23A
	b P2_Entry_037FE670	; 037FE23C
P2_Entry_037FE23E:
	add r0,r4,#0x0	; 037FE23E
	bl P2_Entry_037FEBE0	; 037FE240
	ldr r1,[sp,#0xc]	; 037FE244
	cmp r1,#0x0	; 037FE246
	bne P2_Entry_037FE24C	; 037FE248
	b P2_Entry_037FE670	; 037FE24A
P2_Entry_037FE24C:
	add r1,r4,#0x0	; 037FE24C
	add r1,#0x3b	; 037FE24E
	ldrb r1,[r1,#0x0]	; 037FE250
	cmp r1,#0x3	; 037FE252
	bcc P2_Entry_037FE258	; 037FE254
	b P2_Entry_037FE670	; 037FE256
P2_Entry_037FE258:
	ldr r2,[r4,#0x28]	; 037FE258
	lsl r1,r1,#0x2	; 037FE25A
	add r1,r4,r1	; 037FE25C
	str r2,[r1,#0x2c]	; 037FE25E
	add r2,r4,#0x0	; 037FE260
	add r2,#0x3b	; 037FE262
	ldrb r1,[r2,#0x0]	; 037FE264
	add r1,r1,#0x1	; 037FE266
	strb r1,[r2,#0x0]	; 037FE268
	ldr r1,[r4,#0x24]	; 037FE26A
	add r0,r1,r0	; 037FE26C
	str r0,[r4,#0x28]	; 037FE26E
	b P2_Entry_037FE670	; 037FE270
P2_Entry_037FE272:
	cmp r5,#0x0	; 037FE272
	beq P2_Entry_037FE27A	; 037FE274
	ldr r2,[sp,#0x8]	; 037FE276
	b P2_Entry_037FE27C	; 037FE278
P2_Entry_037FE27A:
	mov r2,#0x0	; 037FE27A
P2_Entry_037FE27C:
	add r0,r4,#0x0	; 037FE27C
	ldr r1,[sp,#0x4]	; 037FE27E
	bl P2_Entry_037FEB34	; 037FE280
	add r1,sp,#0x1c	; 037FE284
	strb r0,[r1,#0x0]	; 037FE286
	ldr r0,[sp,#0xc]	; 037FE288
	cmp r0,#0x0	; 037FE28A
	bne P2_Entry_037FE290	; 037FE28C
	b P2_Entry_037FE670	; 037FE28E
P2_Entry_037FE290:
	sub r6,#0xc0	; 037FE290
	cmp r6,#0x15	; 037FE292
	bls P2_Entry_037FE298	; 037FE294
	b P2_Entry_037FE670	; 037FE296
P2_Entry_037FE298:
	add r0,r6,r6	; 037FE298
P2_SwitchIndexPC_037FE298:
	add r0,pc	; 037FE29A
	ldrh r0,[r0,#(P2_SwitchTable_037FE298 - (P2_SwitchIndexPC_037FE298 + 4))]	; 037FE29C
	lsl r0,r0,#0x10	; 037FE29E
	asr r0,r0,#0x10	; 037FE2A0
P2_SwitchTargetPC_037FE298:
	add r0,pc	; 037FE2A2
	bx r0	; 037FE2A4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FE298:
	.halfword (P2_Case_037FE3FA + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE2D2 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE2E2 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE3EA + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE3F2 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE2EC + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE2F4 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE2FC + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE38A + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE3AA + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE31A + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE322 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE32A + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE332 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE3CA + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE312 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE33A + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE342 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE34A + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE352 + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE35A + 1) - (P2_SwitchTargetPC_037FE298 + 4)
	.halfword (P2_Case_037FE2DA + 1) - (P2_SwitchTargetPC_037FE298 + 4)
P2_SwitchTable_037FE298End:
P2_Case_037FE2D2:
	lsl r0,r1,#0	; 037FE2D2
	ldrb r0,[r0,#0x0]	; 037FE2D4
	strb r0,[r4,#0x4]	; 037FE2D6
	b P2_Entry_037FE670	; 037FE2D8
P2_Case_037FE2DA:
	lsl r0,r1,#0	; 037FE2DA
	ldrb r0,[r0,#0x0]	; 037FE2DC
	strb r0,[r4,#0x5]	; 037FE2DE
	b P2_Entry_037FE670	; 037FE2E0
P2_Case_037FE2E2:
	lsl r0,r1,#0	; 037FE2E2
	ldrb r1,[r0,#0x0]	; 037FE2E4
	ldr r0,[sp,#0x4]	; 037FE2E6
	strb r1,[r0,#0x5]	; 037FE2E8
	b P2_Entry_037FE670	; 037FE2EA
P2_Case_037FE2EC:
	lsl r0,r1,#0	; 037FE2EC
	ldrb r0,[r0,#0x0]	; 037FE2EE
	strb r0,[r4,#0x7]	; 037FE2F0
	b P2_Entry_037FE670	; 037FE2F2
P2_Case_037FE2F4:
	lsl r0,r1,#0	; 037FE2F4
	ldrb r0,[r0,#0x0]	; 037FE2F6
	strb r0,[r4,#0x12]	; 037FE2F8
	b P2_Entry_037FE670	; 037FE2FA
P2_Case_037FE2FC:
	ldrb r0,[r4,#0x0]	; 037FE2FC
	mov r1,#0x2	; 037FE2FE
	bic r0,r1	; 037FE300
	add r1,sp,#0x1c	; 037FE302
	ldrb r2,[r1,#0x0]	; 037FE304
	mov r1,#0x1	; 037FE306
	and r2,r1	; 037FE308
	lsl r1,r2,#0x1	; 037FE30A
	orr r0,r1	; 037FE30C
	strb r0,[r4,#0x0]	; 037FE30E
	b P2_Entry_037FE670	; 037FE310
P2_Case_037FE312:
	lsl r0,r1,#0	; 037FE312
	ldrb r0,[r0,#0x0]	; 037FE314
	strb r0,[r4,#0x15]	; 037FE316
	b P2_Entry_037FE670	; 037FE318
P2_Case_037FE31A:
	lsl r0,r1,#0	; 037FE31A
	ldrb r0,[r0,#0x0]	; 037FE31C
	strb r0,[r4,#0x1a]	; 037FE31E
	b P2_Entry_037FE670	; 037FE320
P2_Case_037FE322:
	lsl r0,r1,#0	; 037FE322
	ldrb r0,[r0,#0x0]	; 037FE324
	strb r0,[r4,#0x19]	; 037FE326
	b P2_Entry_037FE670	; 037FE328
P2_Case_037FE32A:
	lsl r0,r1,#0	; 037FE32A
	ldrb r0,[r0,#0x0]	; 037FE32C
	strb r0,[r4,#0x18]	; 037FE32E
	b P2_Entry_037FE670	; 037FE330
P2_Case_037FE332:
	lsl r0,r1,#0	; 037FE332
	ldrb r0,[r0,#0x0]	; 037FE334
	strb r0,[r4,#0x1b]	; 037FE336
	b P2_Entry_037FE670	; 037FE338
P2_Case_037FE33A:
	lsl r0,r1,#0	; 037FE33A
	ldrb r0,[r0,#0x0]	; 037FE33C
	strb r0,[r4,#0xe]	; 037FE33E
	b P2_Entry_037FE670	; 037FE340
P2_Case_037FE342:
	lsl r0,r1,#0	; 037FE342
	ldrb r0,[r0,#0x0]	; 037FE344
	strb r0,[r4,#0xf]	; 037FE346
	b P2_Entry_037FE670	; 037FE348
P2_Case_037FE34A:
	lsl r0,r1,#0	; 037FE34A
	ldrb r0,[r0,#0x0]	; 037FE34C
	strb r0,[r4,#0x10]	; 037FE34E
	b P2_Entry_037FE670	; 037FE350
P2_Case_037FE352:
	lsl r0,r1,#0	; 037FE352
	ldrb r0,[r0,#0x0]	; 037FE354
	strb r0,[r4,#0x11]	; 037FE356
	b P2_Entry_037FE670	; 037FE358
P2_Case_037FE35A:
	add r0,r4,#0x0	; 037FE35A
	add r0,#0x3b	; 037FE35C
	ldrb r0,[r0,#0x0]	; 037FE35E
	cmp r0,#0x3	; 037FE360
	bcc P2_Entry_037FE366	; 037FE362
	b P2_Entry_037FE670	; 037FE364
P2_Entry_037FE366:
	ldr r1,[r4,#0x28]	; 037FE366
	lsl r0,r0,#0x2	; 037FE368
	add r0,r4,r0	; 037FE36A
	str r1,[r0,#0x2c]	; 037FE36C
	add r0,sp,#0x1c	; 037FE36E
	ldrb r1,[r0,#0x0]	; 037FE370
	add r0,r4,#0x0	; 037FE372
	add r0,#0x3b	; 037FE374
	ldrb r0,[r0,#0x0]	; 037FE376
	add r0,r4,r0	; 037FE378
	add r0,#0x38	; 037FE37A
	strb r1,[r0,#0x0]	; 037FE37C
	add r1,r4,#0x0	; 037FE37E
	add r1,#0x3b	; 037FE380
	ldrb r0,[r1,#0x0]	; 037FE382
	add r0,r0,#0x1	; 037FE384
	strb r0,[r1,#0x0]	; 037FE386
	b P2_Entry_037FE670	; 037FE388
P2_Case_037FE38A:
	ldrb r0,[r4,#0x0]	; 037FE38A
	mov r1,#0x8	; 037FE38C
	bic r0,r1	; 037FE38E
	add r1,sp,#0x1c	; 037FE390
	ldrb r2,[r1,#0x0]	; 037FE392
	mov r1,#0x1	; 037FE394
	and r2,r1	; 037FE396
	lsl r1,r2,#0x3	; 037FE398
	orr r0,r1	; 037FE39A
	strb r0,[r4,#0x0]	; 037FE39C
	add r0,r4,#0x0	; 037FE39E
	ldr r1,[sp,#0x4]	; 037FE3A0
	ldr r2,[sp,#0x18]	; 037FE3A2
	bl loc_037FE9E0	; 037FE3A4
	b P2_Entry_037FE670	; 037FE3A8
P2_Case_037FE3AA:
	lsl r0,r1,#0	; 037FE3AA
	ldrb r1,[r0,#0x0]	; 037FE3AC
	mov r0,#0x13	; 037FE3AE
	ldrsb r0,[r4,r0]	; 037FE3B0
	add r0,r1,r0	; 037FE3B2
	strb r0,[r4,#0x14]	; 037FE3B4
	ldrb r1,[r4,#0x0]	; 037FE3B6
	mov r0,#0x20	; 037FE3B8
	orr r1,r0	; 037FE3BA
	strb r1,[r4,#0x0]	; 037FE3BC
	add r0,r4,#0x0	; 037FE3BE
	ldr r1,[sp,#0x4]	; 037FE3C0
	ldr r2,[sp,#0x18]	; 037FE3C2
	bl loc_037FE9E0	; 037FE3C4
	b P2_Entry_037FE670	; 037FE3C8
P2_Case_037FE3CA:
	ldrb r0,[r4,#0x0]	; 037FE3CA
	mov r1,#0x20	; 037FE3CC
	bic r0,r1	; 037FE3CE
	add r1,sp,#0x1c	; 037FE3D0
	ldrb r2,[r1,#0x0]	; 037FE3D2
	mov r1,#0x1	; 037FE3D4
	and r2,r1	; 037FE3D6
	lsl r1,r2,#0x5	; 037FE3D8
	orr r0,r1	; 037FE3DA
	strb r0,[r4,#0x0]	; 037FE3DC
	add r0,r4,#0x0	; 037FE3DE
	ldr r1,[sp,#0x4]	; 037FE3E0
	ldr r2,[sp,#0x18]	; 037FE3E2
	bl loc_037FE9E0	; 037FE3E4
	b P2_Entry_037FE670	; 037FE3E8
P2_Case_037FE3EA:
	mov r0,#0x0	; 037FE3EA
	ldrsb r0,[r1,r0]	; 037FE3EC
	strb r0,[r4,#0x13]	; 037FE3EE
	b P2_Entry_037FE670	; 037FE3F0
P2_Case_037FE3F2:
	mov r0,#0x0	; 037FE3F2
	ldrsb r0,[r1,r0]	; 037FE3F4
	strb r0,[r4,#0x6]	; 037FE3F6
	b P2_Entry_037FE670	; 037FE3F8
P2_Case_037FE3FA:
	lsl r0,r1,#0	; 037FE3FA
	ldrb r0,[r0,#0x0]	; 037FE3FC
	sub r0,#0x40	; 037FE3FE
	strb r0,[r4,#0x8]	; 037FE400
	b P2_Entry_037FE670	; 037FE402
P2_Entry_037FE404:
	cmp r5,#0x0	; 037FE404
	beq P2_Entry_037FE40C	; 037FE406
	ldr r2,[sp,#0x8]	; 037FE408
	b P2_Entry_037FE40E	; 037FE40A
P2_Entry_037FE40C:
	mov r2,#0x1	; 037FE40C
P2_Entry_037FE40E:
	add r0,r4,#0x0	; 037FE40E
	ldr r1,[sp,#0x4]	; 037FE410
	bl P2_Entry_037FEB34	; 037FE412
	lsl r0,r0,#0x10	; 037FE416
	asr r1,r0,#0x10	; 037FE418
	ldr r0,[sp,#0xc]	; 037FE41A
	cmp r0,#0x0	; 037FE41C
	bne P2_Entry_037FE422	; 037FE41E
	b P2_Entry_037FE670	; 037FE420
P2_Entry_037FE422:
	cmp r6,#0xe0	; 037FE422
	beq P2_Entry_037FE436	; 037FE424
	cmp r6,#0xe1	; 037FE426
	beq P2_Entry_037FE430	; 037FE428
	cmp r6,#0xe3	; 037FE42A
	beq P2_Entry_037FE43A	; 037FE42C
	b P2_Entry_037FE670	; 037FE42E
P2_Entry_037FE430:
	ldr r0,[sp,#0x4]	; 037FE430
	strh r1,[r0,#0x18]	; 037FE432
	b P2_Entry_037FE670	; 037FE434
P2_Entry_037FE436:
	strh r1,[r4,#0x1c]	; 037FE436
	b P2_Entry_037FE670	; 037FE438
P2_Entry_037FE43A:
	strh r1,[r4,#0x16]	; 037FE43A
	b P2_Entry_037FE670	; 037FE43C
P2_Entry_037FE43E:
	add r0,r4,#0x0	; 037FE43E
	bl loc_037FEC60	; 037FE440
	str r0,[sp,#0x14]	; 037FE444
	cmp r5,#0x0	; 037FE446
	beq P2_Entry_037FE44E	; 037FE448
	ldr r2,[sp,#0x8]	; 037FE44A
	b P2_Entry_037FE450	; 037FE44C
P2_Entry_037FE44E:
	mov r2,#0x1	; 037FE44E
P2_Entry_037FE450:
	add r0,r4,#0x0	; 037FE450
	ldr r1,[sp,#0x4]	; 037FE452
	bl P2_Entry_037FEB34	; 037FE454
	lsl r0,r0,#0x10	; 037FE458
	asr r7,r0,#0x10	; 037FE45A
	ldr r0,[sp,#0x4]	; 037FE45C
	ldr r1,[sp,#0x14]	; 037FE45E
	bl loc_037FDFE0	; 037FE460
	add r5,r0,#0x0	; 037FE464
	ldr r0,[sp,#0xc]	; 037FE466
	cmp r0,#0x0	; 037FE468
	bne P2_Entry_037FE46E	; 037FE46A
	b P2_Entry_037FE670	; 037FE46C
P2_Entry_037FE46E:
	cmp r5,#0x0	; 037FE46E
	bne P2_Entry_037FE474	; 037FE470
	b P2_Entry_037FE670	; 037FE472
P2_Entry_037FE474:
	sub r6,#0xb0	; 037FE474
	cmp r6,#0xd	; 037FE476
	bls P2_Entry_037FE47C	; 037FE478
	b P2_Entry_037FE670	; 037FE47A
P2_Entry_037FE47C:
	add r0,r6,r6	; 037FE47C
P2_SwitchIndexPC_037FE47C:
	add r0,pc	; 037FE47E
	ldrh r0,[r0,#(P2_SwitchTable_037FE47C - (P2_SwitchIndexPC_037FE47C + 4))]	; 037FE480
	lsl r0,r0,#0x10	; 037FE482
	asr r0,r0,#0x10	; 037FE484
P2_SwitchTargetPC_037FE47C:
	add r0,pc	; 037FE486
	bx r0	; 037FE488
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FE47C:
	.halfword (P2_Case_037FE4A6 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE4AA + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE4B4 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE4BE + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE4C8 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE4DC + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE4F6 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Entry_037FE670 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE504 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE52C + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE550 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE574 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE598 + 1) - (P2_SwitchTargetPC_037FE47C + 4)
	.halfword (P2_Case_037FE5BC + 1) - (P2_SwitchTargetPC_037FE47C + 4)
P2_SwitchTable_037FE47CEnd:
P2_Case_037FE4A6:
	strh r7,[r5,#0x0]	; 037FE4A6
	b P2_Entry_037FE670	; 037FE4A8
P2_Case_037FE4AA:
	mov r0,#0x0	; 037FE4AA
	ldrsh r0,[r5,r0]	; 037FE4AC
	add r0,r0,r7	; 037FE4AE
	strh r0,[r5,#0x0]	; 037FE4B0
	b P2_Entry_037FE670	; 037FE4B2
P2_Case_037FE4B4:
	mov r0,#0x0	; 037FE4B4
	ldrsh r0,[r5,r0]	; 037FE4B6
	sub r0,r0,r7	; 037FE4B8
	strh r0,[r5,#0x0]	; 037FE4BA
	b P2_Entry_037FE670	; 037FE4BC
P2_Case_037FE4BE:
	mov r0,#0x0	; 037FE4BE
	ldrsh r0,[r5,r0]	; 037FE4C0
	mul r0,r7	; 037FE4C2
	strh r0,[r5,#0x0]	; 037FE4C4
	b P2_Entry_037FE670	; 037FE4C6
P2_Case_037FE4C8:
	cmp r7,#0x0	; 037FE4C8
	bne P2_Entry_037FE4CE	; 037FE4CA
	b P2_Entry_037FE670	; 037FE4CC
P2_Entry_037FE4CE:
	mov r0,#0x0	; 037FE4CE
	ldrsh r0,[r5,r0]	; 037FE4D0
	add r1,r7,#0x0	; 037FE4D2
	bl loc_037FBE04	; 037FE4D4
	strh r0,[r5,#0x0]	; 037FE4D8
	b P2_Entry_037FE670	; 037FE4DA
P2_Case_037FE4DC:
	cmp r7,#0x0	; 037FE4DC
	blt P2_Entry_037FE4EA	; 037FE4DE
	mov r0,#0x0	; 037FE4E0
	ldrsh r0,[r5,r0]	; 037FE4E2
	lsl r0,r7	; 037FE4E4
	strh r0,[r5,#0x0]	; 037FE4E6
	b P2_Entry_037FE670	; 037FE4E8
P2_Entry_037FE4EA:
	mov r0,#0x0	; 037FE4EA
	ldrsh r1,[r5,r0]	; 037FE4EC
	neg r0,r7	; 037FE4EE
	asr r1,r0	; 037FE4F0
	strh r1,[r5,#0x0]	; 037FE4F2
	b P2_Entry_037FE670	; 037FE4F4
P2_Case_037FE4F6:
	bl loc_037FD29C	; 037FE4F6
	add r1,r7,#0x1	; 037FE4FA
	mul r0,r1	; 037FE4FC
	asr r0,r0,#0x10	; 037FE4FE
	strh r0,[r5,#0x0]	; 037FE500
	b P2_Entry_037FE670	; 037FE502
P2_Case_037FE504:
	mov r0,#0x0	; 037FE504
	ldrsh r0,[r5,r0]	; 037FE506
	cmp r0,r7	; 037FE508
	bne P2_Entry_037FE514	; 037FE50A
	mov r2,#0x1	; 037FE50C
	b P2_Entry_037FE516	; 037FE50E
pool_037FE510:
	.word 0x00010000	; 037FE510
P2_Entry_037FE514:
	mov r2,#0x0	; 037FE514
P2_Entry_037FE516:
	ldrb r0,[r4,#0x0]	; 037FE516
	mov r1,#0x40	; 037FE518
	bic r0,r1	; 037FE51A
	lsl r1,r2,#0x18	; 037FE51C
	lsr r2,r1,#0x18	; 037FE51E
	mov r1,#0x1	; 037FE520
	and r2,r1	; 037FE522
	lsl r1,r2,#0x6	; 037FE524
	orr r0,r1	; 037FE526
	strb r0,[r4,#0x0]	; 037FE528
	b P2_Entry_037FE670	; 037FE52A
P2_Case_037FE52C:
	mov r0,#0x0	; 037FE52C
	ldrsh r0,[r5,r0]	; 037FE52E
	cmp r0,r7	; 037FE530
	blt P2_Entry_037FE538	; 037FE532
	mov r2,#0x1	; 037FE534
	b P2_Entry_037FE53A	; 037FE536
P2_Entry_037FE538:
	mov r2,#0x0	; 037FE538
P2_Entry_037FE53A:
	ldrb r0,[r4,#0x0]	; 037FE53A
	mov r1,#0x40	; 037FE53C
	bic r0,r1	; 037FE53E
	lsl r1,r2,#0x18	; 037FE540
	lsr r2,r1,#0x18	; 037FE542
	mov r1,#0x1	; 037FE544
	and r2,r1	; 037FE546
	lsl r1,r2,#0x6	; 037FE548
	orr r0,r1	; 037FE54A
	strb r0,[r4,#0x0]	; 037FE54C
	b P2_Entry_037FE670	; 037FE54E
P2_Case_037FE550:
	mov r0,#0x0	; 037FE550
	ldrsh r0,[r5,r0]	; 037FE552
	cmp r0,r7	; 037FE554
	ble P2_Entry_037FE55C	; 037FE556
	mov r2,#0x1	; 037FE558
	b P2_Entry_037FE55E	; 037FE55A
P2_Entry_037FE55C:
	mov r2,#0x0	; 037FE55C
P2_Entry_037FE55E:
	ldrb r0,[r4,#0x0]	; 037FE55E
	mov r1,#0x40	; 037FE560
	bic r0,r1	; 037FE562
	lsl r1,r2,#0x18	; 037FE564
	lsr r2,r1,#0x18	; 037FE566
	mov r1,#0x1	; 037FE568
	and r2,r1	; 037FE56A
	lsl r1,r2,#0x6	; 037FE56C
	orr r0,r1	; 037FE56E
	strb r0,[r4,#0x0]	; 037FE570
	b P2_Entry_037FE670	; 037FE572
P2_Case_037FE574:
	mov r0,#0x0	; 037FE574
	ldrsh r0,[r5,r0]	; 037FE576
	cmp r0,r7	; 037FE578
	bgt P2_Entry_037FE580	; 037FE57A
	mov r2,#0x1	; 037FE57C
	b P2_Entry_037FE582	; 037FE57E
P2_Entry_037FE580:
	mov r2,#0x0	; 037FE580
P2_Entry_037FE582:
	ldrb r0,[r4,#0x0]	; 037FE582
	mov r1,#0x40	; 037FE584
	bic r0,r1	; 037FE586
	lsl r1,r2,#0x18	; 037FE588
	lsr r2,r1,#0x18	; 037FE58A
	mov r1,#0x1	; 037FE58C
	and r2,r1	; 037FE58E
	lsl r1,r2,#0x6	; 037FE590
	orr r0,r1	; 037FE592
	strb r0,[r4,#0x0]	; 037FE594
	b P2_Entry_037FE670	; 037FE596
P2_Case_037FE598:
	mov r0,#0x0	; 037FE598
	ldrsh r0,[r5,r0]	; 037FE59A
	cmp r0,r7	; 037FE59C
	bge P2_Entry_037FE5A4	; 037FE59E
	mov r2,#0x1	; 037FE5A0
	b P2_Entry_037FE5A6	; 037FE5A2
P2_Entry_037FE5A4:
	mov r2,#0x0	; 037FE5A4
P2_Entry_037FE5A6:
	ldrb r0,[r4,#0x0]	; 037FE5A6
	mov r1,#0x40	; 037FE5A8
	bic r0,r1	; 037FE5AA
	lsl r1,r2,#0x18	; 037FE5AC
	lsr r2,r1,#0x18	; 037FE5AE
	mov r1,#0x1	; 037FE5B0
	and r2,r1	; 037FE5B2
	lsl r1,r2,#0x6	; 037FE5B4
	orr r0,r1	; 037FE5B6
	strb r0,[r4,#0x0]	; 037FE5B8
	b P2_Entry_037FE670	; 037FE5BA
P2_Case_037FE5BC:
	mov r0,#0x0	; 037FE5BC
	ldrsh r0,[r5,r0]	; 037FE5BE
	cmp r0,r7	; 037FE5C0
	beq P2_Entry_037FE5C8	; 037FE5C2
	mov r2,#0x1	; 037FE5C4
	b P2_Entry_037FE5CA	; 037FE5C6
P2_Entry_037FE5C8:
	mov r2,#0x0	; 037FE5C8
P2_Entry_037FE5CA:
	ldrb r0,[r4,#0x0]	; 037FE5CA
	mov r1,#0x40	; 037FE5CC
	bic r0,r1	; 037FE5CE
	lsl r1,r2,#0x18	; 037FE5D0
	lsr r2,r1,#0x18	; 037FE5D2
	mov r1,#0x1	; 037FE5D4
	and r2,r1	; 037FE5D6
	lsl r1,r2,#0x6	; 037FE5D8
	orr r0,r1	; 037FE5DA
	strb r0,[r4,#0x0]	; 037FE5DC
	b P2_Entry_037FE670	; 037FE5DE
P2_Entry_037FE5E0:
	ldr r0,[sp,#0xc]	; 037FE5E0
	cmp r0,#0x0	; 037FE5E2
	beq P2_Entry_037FE670	; 037FE5E4
	sub r6,#0xfc	; 037FE5E6
	cmp r6,#0x3	; 037FE5E8
	bhi P2_Entry_037FE670	; 037FE5EA
	add r0,r6,r6	; 037FE5EC
P2_SwitchIndexPC_037FE5EC:
	add r0,pc	; 037FE5EE
	ldrh r0,[r0,#(P2_SwitchTable_037FE5EC - (P2_SwitchIndexPC_037FE5EC + 4))]	; 037FE5F0
	lsl r0,r0,#0x10	; 037FE5F2
	asr r0,r0,#0x10	; 037FE5F4
P2_SwitchTargetPC_037FE5EC:
	add r0,pc	; 037FE5F6
	bx r0	; 037FE5F8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FE5EC:
	.halfword (P2_Case_037FE626 + 1) - (P2_SwitchTargetPC_037FE5EC + 4)
	.halfword (P2_Case_037FE602 + 1) - (P2_SwitchTargetPC_037FE5EC + 4)
	.halfword (P2_Entry_037FE670 + 1) - (P2_SwitchTargetPC_037FE5EC + 4)
	.halfword (P2_Case_037FE66A + 1) - (P2_SwitchTargetPC_037FE5EC + 4)
P2_SwitchTable_037FE5ECEnd:
P2_Case_037FE602:
	add r0,r4,#0x0	; 037FE602
	add r0,#0x3b	; 037FE604
	ldrb r0,[r0,#0x0]	; 037FE606
	cmp r0,#0x0	; 037FE608
	beq P2_Entry_037FE670	; 037FE60A
	add r1,r4,#0x0	; 037FE60C
	add r1,#0x3b	; 037FE60E
	ldrb r0,[r1,#0x0]	; 037FE610
	sub r0,r0,#0x1	; 037FE612
	strb r0,[r1,#0x0]	; 037FE614
	add r0,r4,#0x0	; 037FE616
	add r0,#0x3b	; 037FE618
	ldrb r0,[r0,#0x0]	; 037FE61A
	lsl r0,r0,#0x2	; 037FE61C
	add r0,r4,r0	; 037FE61E
	ldr r0,[r0,#0x2c]	; 037FE620
	str r0,[r4,#0x28]	; 037FE622
	b P2_Entry_037FE670	; 037FE624
P2_Case_037FE626:
	add r0,r4,#0x0	; 037FE626
	add r0,#0x3b	; 037FE628
	ldrb r0,[r0,#0x0]	; 037FE62A
	cmp r0,#0x0	; 037FE62C
	beq P2_Entry_037FE670	; 037FE62E
	sub r0,r0,#0x1	; 037FE630
	add r1,r4,r0	; 037FE632
	add r0,r1,#0x0	; 037FE634
	add r0,#0x38	; 037FE636
	ldrb r0,[r0,#0x0]	; 037FE638
	cmp r0,#0x0	; 037FE63A
	beq P2_Entry_037FE654	; 037FE63C
	sub r0,r0,#0x1	; 037FE63E
	lsl r0,r0,#0x18	; 037FE640
	lsr r0,r0,#0x18	; 037FE642
	cmp r0,#0x0	; 037FE644
	bne P2_Entry_037FE654	; 037FE646
	add r1,r4,#0x0	; 037FE648
	add r1,#0x3b	; 037FE64A
	ldrb r0,[r1,#0x0]	; 037FE64C
	sub r0,r0,#0x1	; 037FE64E
	strb r0,[r1,#0x0]	; 037FE650
	b P2_Entry_037FE670	; 037FE652
P2_Entry_037FE654:
	add r1,#0x38	; 037FE654
	strb r0,[r1,#0x0]	; 037FE656
	add r0,r4,#0x0	; 037FE658
	add r0,#0x3b	; 037FE65A
	ldrb r0,[r0,#0x0]	; 037FE65C
	sub r0,r0,#0x1	; 037FE65E
	lsl r0,r0,#0x2	; 037FE660
	add r0,r4,r0	; 037FE662
	ldr r0,[r0,#0x2c]	; 037FE664
	str r0,[r4,#0x28]	; 037FE666
	b P2_Entry_037FE670	; 037FE668
P2_Case_037FE66A:
	mov r0,#0x0	; 037FE66A
	mvn r0,r0	; 037FE66C
	b P2_Entry_037FE684	; 037FE66E
P2_Entry_037FE670:
	ldr r0,[r4,#0x20]	; 037FE670
	cmp r0,#0x0	; 037FE672
	bne P2_Entry_037FE682	; 037FE674
	ldrb r0,[r4,#0x0]	; 037FE676
	lsl r0,r0,#0x1b	; 037FE678
	lsr r0,r0,#0x1f	; 037FE67A
	cmp r0,#0x0	; 037FE67C
	bne P2_Entry_037FE682	; 037FE67E
	b P2_Entry_037FE0AA	; 037FE680
P2_Entry_037FE682:
	mov r0,#0x0	; 037FE682
P2_Entry_037FE684:
	add sp,#0x24	; 037FE684
	pop {r4,r5,r6,r7}	; 037FE686
	pop {r3}	; 037FE688
	bx r3	; 037FE68A
P2_Entry_037FE68C:
	push {r4,r5,r6,r7,lr}	; 037FE68C
	sub sp,#0x1c	; 037FE68E
	add r4,r0,#0x0	; 037FE690
	add r6,r1,#0x0	; 037FE692
	add r7,r2,#0x0	; 037FE694
	str r3,[sp,#0x8]	; 037FE696
	mov r5,#0x0	; 037FE698
	ldr r1,[sp,#0x30]	; 037FE69A
	ldrh r0,[r6,#0x18]	; 037FE69C
	ldrh r2,[r6,#0x1a]	; 037FE69E
	mul r0,r2	; 037FE6A0
	mov r2,#0xf0	; 037FE6A2
	mul r1,r2	; 037FE6A4
	asr r2,r0,#0x8	; 037FE6A6
	sub r0,r2,#0x1	; 037FE6A8
	add r0,r1,r0	; 037FE6AA
	add r1,r2,#0x0	; 037FE6AC
	bl loc_037FBE04	; 037FE6AE
	str r0,[sp,#0xc]	; 037FE6B2
	ldrb r0,[r4,#0x0]	; 037FE6B4
	lsl r0,r0,#0x1c	; 037FE6B6
	lsr r0,r0,#0x1f	; 037FE6B8
	cmp r0,#0x0	; 037FE6BA
	beq P2_Entry_037FE6CA	; 037FE6BC
	ldr r5,[r4,#0x3c]	; 037FE6BE
	cmp r5,#0x0	; 037FE6C0
	beq P2_Entry_037FE6CA	; 037FE6C2
	strb r7,[r5,#0x8]	; 037FE6C4
	ldr r0,[sp,#0x8]	; 037FE6C6
	strb r0,[r5,#0x9]	; 037FE6C8
P2_Entry_037FE6CA:
	cmp r5,#0x0	; 037FE6CA
	bne P2_Entry_037FE766	; 037FE6CC
	ldr r0,[r6,#0x20]	; 037FE6CE
	ldrh r1,[r4,#0x2]	; 037FE6D0
	add r2,r7,#0x0	; 037FE6D2
	add r3,sp,#0x10	; 037FE6D4
	bl P2_Entry_037FF15C	; 037FE6D6
	cmp r0,#0x0	; 037FE6DA
	beq P2_Entry_037FE7DE	; 037FE6DC
	add r0,sp,#0x10	; 037FE6DE
	ldrb r0,[r0,#0x0]	; 037FE6E0
	cmp r0,#0x4	; 037FE6E2
	bhi P2_Entry_037FE7DE	; 037FE6E4
	add r0,r0,r0	; 037FE6E6
P2_SwitchIndexPC_037FE6E6:
	add r0,pc	; 037FE6E8
	ldrh r0,[r0,#(P2_SwitchTable_037FE6E6 - (P2_SwitchIndexPC_037FE6E6 + 4))]	; 037FE6EA
	lsl r0,r0,#0x10	; 037FE6EC
	asr r0,r0,#0x10	; 037FE6EE
P2_SwitchTargetPC_037FE6E6:
	add r0,pc	; 037FE6F0
	bx r0	; 037FE6F2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FE6E6:
	.halfword (P2_Case_037FE70A + 1) - (P2_SwitchTargetPC_037FE6E6 + 4)
	.halfword (P2_Case_037FE6FE + 1) - (P2_SwitchTargetPC_037FE6E6 + 4)
	.halfword (P2_Case_037FE702 + 1) - (P2_SwitchTargetPC_037FE6E6 + 4)
	.halfword (P2_Case_037FE706 + 1) - (P2_SwitchTargetPC_037FE6E6 + 4)
	.halfword (P2_Case_037FE6FE + 1) - (P2_SwitchTargetPC_037FE6E6 + 4)
P2_SwitchTable_037FE6E6End:
P2_Case_037FE6FE:
	ldr r0,[pool_037FE7E8]	; 037FE6FE
	b P2_Entry_037FE70C	; 037FE700
P2_Case_037FE702:
	ldr r0,[pool_037FE7EC]	; 037FE702
	b P2_Entry_037FE70C	; 037FE704
P2_Case_037FE706:
	ldr r0,[pool_037FE7F0]	; 037FE706
	b P2_Entry_037FE70C	; 037FE708
P2_Case_037FE70A:
	b P2_Entry_037FE7DE	; 037FE70A
P2_Entry_037FE70C:
	ldrh r1,[r4,#0x1e]	; 037FE70C
	and r0,r1	; 037FE70E
	str r4,[sp,#0x0]	; 037FE710
	ldrb r2,[r6,#0x4]	; 037FE712
	ldrb r1,[r4,#0x12]	; 037FE714
	add r1,r2,r1	; 037FE716
	ldrb r2,[r4,#0x0]	; 037FE718
	lsl r2,r2,#0x18	; 037FE71A
	lsr r2,r2,#0x1f	; 037FE71C
	ldr r3,[pool_037FE7F4]	; 037FE71E
	bl P2_Entry_037FDA94	; 037FE720
	add r5,r0,#0x0	; 037FE724
	cmp r5,#0x0	; 037FE726
	beq P2_Entry_037FE7DE	; 037FE728
	ldrb r0,[r4,#0x0]	; 037FE72A
	lsl r0,r0,#0x1c	; 037FE72C
	lsr r0,r0,#0x1f	; 037FE72E
	cmp r0,#0x0	; 037FE730
	beq P2_Entry_037FE738	; 037FE732
	mov r3,#0x0	; 037FE734
	b P2_Entry_037FE73A	; 037FE736
P2_Entry_037FE738:
	ldr r3,[sp,#0xc]	; 037FE738
P2_Entry_037FE73A:
	ldr r0,[r6,#0x20]	; 037FE73A
	str r0,[sp,#0x0]	; 037FE73C
	add r0,sp,#0x10	; 037FE73E
	str r0,[sp,#0x4]	; 037FE740
	add r0,r5,#0x0	; 037FE742
	add r1,r7,#0x0	; 037FE744
	ldr r2,[sp,#0x8]	; 037FE746
	bl P2_Entry_037FF0A8	; 037FE748
	cmp r0,#0x0	; 037FE74C
	bne P2_Entry_037FE760	; 037FE74E
	mov r1,#0x0	; 037FE750
	add r0,r5,#0x0	; 037FE752
	add r0,#0x22	; 037FE754
	strb r1,[r0,#0x0]	; 037FE756
	add r0,r5,#0x0	; 037FE758
	bl loc_037FDA88	; 037FE75A
	b P2_Entry_037FE7DE	; 037FE75E
P2_Entry_037FE760:
	ldr r0,[r4,#0x3c]	; 037FE760
	str r0,[r5,#0x50]	; 037FE762
	str r5,[r4,#0x3c]	; 037FE764
P2_Entry_037FE766:
	ldrb r1,[r4,#0xe]	; 037FE766
	cmp r1,#0xff	; 037FE768
	beq P2_Entry_037FE772	; 037FE76A
	add r0,r5,#0x0	; 037FE76C
	bl loc_037FDB94	; 037FE76E
P2_Entry_037FE772:
	ldrb r1,[r4,#0xf]	; 037FE772
	cmp r1,#0xff	; 037FE774
	beq P2_Entry_037FE77E	; 037FE776
	add r0,r5,#0x0	; 037FE778
	bl loc_037FDB80	; 037FE77A
P2_Entry_037FE77E:
	ldrb r1,[r4,#0x10]	; 037FE77E
	cmp r1,#0xff	; 037FE780
	beq P2_Entry_037FE78A	; 037FE782
	add r0,r5,#0x0	; 037FE784
	bl loc_037FDB7C	; 037FE786
P2_Entry_037FE78A:
	ldrb r1,[r4,#0x11]	; 037FE78A
	cmp r1,#0xff	; 037FE78C
	beq P2_Entry_037FE796	; 037FE78E
	add r0,r5,#0x0	; 037FE790
	bl loc_037FDB68	; 037FE792
P2_Entry_037FE796:
	mov r0,#0x16	; 037FE796
	ldrsh r0,[r4,r0]	; 037FE798
	strh r0,[r5,#0x32]	; 037FE79A
	ldrb r0,[r4,#0x0]	; 037FE79C
	lsl r0,r0,#0x1a	; 037FE79E
	lsr r0,r0,#0x1f	; 037FE7A0
	cmp r0,#0x0	; 037FE7A2
	beq P2_Entry_037FE7BA	; 037FE7A4
	add r1,r5,#0x0	; 037FE7A6
	add r1,#0x32	; 037FE7A8
	mov r0,#0x0	; 037FE7AA
	ldrsh r0,[r1,r0]	; 037FE7AC
	ldrb r2,[r4,#0x14]	; 037FE7AE
	sub r2,r2,r7	; 037FE7B0
	lsl r2,r2,#0x16	; 037FE7B2
	asr r2,r2,#0x10	; 037FE7B4
	add r0,r0,r2	; 037FE7B6
	strh r0,[r1,#0x0]	; 037FE7B8
P2_Entry_037FE7BA:
	ldrb r0,[r4,#0x15]	; 037FE7BA
	cmp r0,#0x0	; 037FE7BC
	bne P2_Entry_037FE7C6	; 037FE7BE
	ldr r0,[sp,#0xc]	; 037FE7C0
	str r0,[r5,#0x18]	; 037FE7C2
	b P2_Entry_037FE7DA	; 037FE7C4
P2_Entry_037FE7C6:
	add r1,r0,#0x0	; 037FE7C6
	mul r1,r0	; 037FE7C8
	mov r0,#0x32	; 037FE7CA
	ldrsh r0,[r5,r0]	; 037FE7CC
	cmp r0,#0x0	; 037FE7CE
	bge P2_Entry_037FE7D4	; 037FE7D0
	neg r0,r0	; 037FE7D2
P2_Entry_037FE7D4:
	mul r1,r0	; 037FE7D4
	asr r0,r1,#0xb	; 037FE7D6
	str r0,[r5,#0x18]	; 037FE7D8
P2_Entry_037FE7DA:
	mov r0,#0x0	; 037FE7DA
	str r0,[r5,#0x14]	; 037FE7DC
P2_Entry_037FE7DE:
	add sp,#0x1c	; 037FE7DE
	pop {r4,r5,r6,r7}	; 037FE7E0
	pop {r3}	; 037FE7E2
	bx r3	; 037FE7E4
	.byte 0xC0, 0x46	; 037FE7E6
pool_037FE7E8:
	.word 0x0000FFFF	; 037FE7E8
pool_037FE7EC:
	.word 0x00003F00	; 037FE7EC
pool_037FE7F0:
	.word 0x0000C000	; 037FE7F0
pool_037FE7F4:
	.word 0x037FE8A1	; 037FE7F4
P2_Entry_037FE7F8:
	push {r4,r5,lr}	; 037FE7F8
	sub sp,#0x4	; 037FE7FA
	add r5,r0,#0x0	; 037FE7FC
	mov r4,#0x0	; 037FE7FE
P2_Entry_037FE800:
	add r0,r5,#0x0	; 037FE800
	add r1,r4,#0x0	; 037FE802
	bl loc_037FE958	; 037FE804
	cmp r0,#0x0	; 037FE808
	beq P2_Entry_037FE812	; 037FE80A
	add r1,r5,#0x0	; 037FE80C
	bl loc_037FE820	; 037FE80E
P2_Entry_037FE812:
	add r4,r4,#0x1	; 037FE812
	cmp r4,#0x10	; 037FE814
	blt P2_Entry_037FE800	; 037FE816
	add sp,#0x4	; 037FE818
	pop {r4,r5}	; 037FE81A
	pop {r3}	; 037FE81C
	bx r3	; 037FE81E

; ===== function loc_037FE820 =====
loc_037FE820:
	push {r4,r5,r6,r7,lr}	; 037FE820
	sub sp,#0x4	; 037FE822
	add r2,r0,#0x0	; 037FE824
	ldr r0,[r2,#0x3c]	; 037FE826
	mov r3,#0x6	; 037FE828
	ldrsh r6,[r1,r3]	; 037FE82A
	mov r3,#0xa	; 037FE82C
	ldrsh r5,[r2,r3]	; 037FE82E
	ldrb r1,[r1,#0x5]	; 037FE830
	lsl r1,r1,#0x1	; 037FE832
	ldr r4,[pool_037FE89C]	; 037FE834
	ldrsh r3,[r4,r1]	; 037FE836
	ldrb r1,[r2,#0x4]	; 037FE838
	lsl r1,r1,#0x1	; 037FE83A
	ldrsh r1,[r4,r1]	; 037FE83C
	ldrb r7,[r2,#0x5]	; 037FE83E
	lsl r7,r7,#0x1	; 037FE840
	ldrsh r4,[r4,r7]	; 037FE842
	add r1,r1,r4	; 037FE844
	add r1,r3,r1	; 037FE846
	add r1,r5,r1	; 037FE848
	add r4,r6,r1	; 037FE84A
	mov r1,#0x8	; 037FE84C
	ldrsb r3,[r2,r1]	; 037FE84E
	mov r1,#0x9	; 037FE850
	ldrsb r1,[r2,r1]	; 037FE852
	add r3,r3,r1	; 037FE854
	mov r1,#0x6	; 037FE856
	ldrsb r5,[r2,r1]	; 037FE858
	ldrb r1,[r2,#0x7]	; 037FE85A
	lsl r1,r1,#0x6	; 037FE85C
	mul r5,r1	; 037FE85E
	asr r5,r5,#0x7	; 037FE860
	mov r1,#0xc	; 037FE862
	ldrsh r1,[r2,r1]	; 037FE864
	add r1,r5,r1	; 037FE866
	mov r5,#0x7f	; 037FE868
	mvn r6,r5	; 037FE86A
	cmp r3,r6	; 037FE86C
	bge loc_037FE874	; 037FE86E
	add r3,r6,#0x0	; 037FE870
	b loc_037FE890	; 037FE872
loc_037FE874:
	cmp r3,#0x7f	; 037FE874
	ble loc_037FE890	; 037FE876
	add r3,r5,#0x0	; 037FE878
	b loc_037FE890	; 037FE87A
loc_037FE87C:
	strh r4,[r0,#0xc]	; 037FE87C
	strh r1,[r0,#0xe]	; 037FE87E
	strb r3,[r0,#0xb]	; 037FE880
	ldrh r5,[r2,#0x18]	; 037FE882
	strh r5,[r0,#0x28]	; 037FE884
	ldrh r5,[r2,#0x1a]	; 037FE886
	strh r5,[r0,#0x2a]	; 037FE888
	ldrh r5,[r2,#0x1c]	; 037FE88A
	strh r5,[r0,#0x2c]	; 037FE88C
	ldr r0,[r0,#0x50]	; 037FE88E
loc_037FE890:
	cmp r0,#0x0	; 037FE890
	bne loc_037FE87C	; 037FE892
	add sp,#0x4	; 037FE894
	pop {r4,r5,r6,r7}	; 037FE896
	pop {r3}	; 037FE898
	bx r3	; 037FE89A
pool_037FE89C:
loc_037FE89C:
	.word P2_Data_03802A90	; 037FE89C
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x14, 0x1C, 0x01, 0x29, 0x06, 0xD1, 0x01, 0x22, 0x29, 0x1C	; 037FE8B0
	.byte 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xE8, 0xF8, 0x07, 0xE0, 0x02, 0x29, 0x05, 0xD1, 0x00, 0x22	; 037FE8C0
	.byte 0x29, 0x1C, 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xDF, 0xF8, 0xE1, 0x6B, 0xA9, 0x42, 0x08, 0xD1	; 037FE8D0
	.byte 0x28, 0x6D, 0xE0, 0x63, 0x08, 0xE0, 0xA8, 0x42, 0x02, 0xD1, 0x28, 0x6D, 0x08, 0x65, 0x03, 0xE0	; 037FE8E0
	.byte 0x01, 0x1C, 0x08, 0x6D, 0x00, 0x28, 0xF6, 0xD1, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FE8F0

; ===== function loc_037FE8F0 =====
loc_037FE8F0:
	push {r4,r5,lr}	; 037FE8F0
	sub sp,#0x4	; 037FE8F2
	add r4,r0,#0x0	; 037FE8F4
	mov r5,#0x0	; 037FE8F6
loc_037FE8F8:
	add r0,r4,#0x0	; 037FE8F8
	add r1,r5,#0x0	; 037FE8FA
	bl loc_037FE914	; 037FE8FC
	add r5,r5,#0x1	; 037FE900
	cmp r5,#0x10	; 037FE902
	blt loc_037FE8F8	; 037FE904
	mov r0,#0x0	; 037FE906
	strb r0,[r4,#0x0]	; 037FE908
	add sp,#0x4	; 037FE90A
	pop {r4,r5}	; 037FE90C
	pop {r3}	; 037FE90E
	bx r3	; 037FE910
	.byte 0x00, 0x00	; 037FE914

; ===== function loc_037FE914 =====
loc_037FE914:
	push {r4,r5,lr}	; 037FE914
	sub sp,#0x4	; 037FE916
	add r5,r0,#0x0	; 037FE918
	add r4,r1,#0x0	; 037FE91A
	bl loc_037FE958	; 037FE91C
	cmp r0,#0x0	; 037FE920
	beq loc_037FE93E	; 037FE922
	add r1,r5,#0x0	; 037FE924
	bl loc_037FE94C	; 037FE926
	add r5,#0x8	; 037FE92A
	ldr r3,[pool_037FE948]	; 037FE92C
	ldrb r0,[r5,r4]	; 037FE92E
	lsl r2,r0,#0x6	; 037FE930
	ldrb r1,[r3,r2]	; 037FE932
	mov r0,#0x1	; 037FE934
	bic r1,r0	; 037FE936
	strb r1,[r3,r2]	; 037FE938
	mov r0,#0xff	; 037FE93A
	strb r0,[r5,r4]	; 037FE93C
loc_037FE93E:
	add sp,#0x4	; 037FE93E
	pop {r4,r5}	; 037FE940
	pop {r3}	; 037FE942
	bx r3	; 037FE944
	.byte 0xC0, 0x46	; 037FE948
pool_037FE948:
loc_037FE948:
	.word P2_BssStart + 0x12F4	; 037FE948

; ===== function loc_037FE94C =====
loc_037FE94C:
	mov r2,#0x0	; 037FE94C
	mvn r2,r2	; 037FE94E
	ldr r3,[pool_037FE954]	; 037FE950
	bx r3	; 037FE952
pool_037FE954:
loc_037FE954:
	.word loc_037FE9E0 + 1	; 037FE954

; ===== function loc_037FE958 =====
loc_037FE958:
	cmp r1,#0xf	; 037FE958
	ble loc_037FE960	; 037FE95A
	mov r0,#0x0	; 037FE95C
	bx lr	; 037FE95E
loc_037FE960:
	add r0,r0,r1	; 037FE960
	ldrb r0,[r0,#0x8]	; 037FE962
	cmp r0,#0xff	; 037FE964
	bne loc_037FE96C	; 037FE966
	mov r0,#0x0	; 037FE968
	bx lr	; 037FE96A
loc_037FE96C:
	ldr r1,[pool_037FE974]	; 037FE96C
	lsl r0,r0,#0x6	; 037FE96E
	add r0,r1,r0	; 037FE970
	bx lr	; 037FE972
pool_037FE974:
loc_037FE974:
	.word 0x03803FFC	; 037FE974
P2_Entry_037FE978:
	push {r4,r5,lr}	; 037FE978
	sub sp,#0x4	; 037FE97A
	add r5,r0,#0x0	; 037FE97C
	mov r4,#0x0	; 037FE97E
	add r1,r5,#0x0	; 037FE980
	add r1,#0x1c	; 037FE982
	b P2_Entry_037FE98E	; 037FE984
P2_Entry_037FE986:
	ldrh r0,[r1,#0x0]	; 037FE986
	sub r0,#0xf0	; 037FE988
	strh r0,[r1,#0x0]	; 037FE98A
	add r4,r4,#0x1	; 037FE98C
P2_Entry_037FE98E:
	ldrh r0,[r5,#0x1c]	; 037FE98E
	cmp r0,#0xf0	; 037FE990
	bcs P2_Entry_037FE986	; 037FE992
	ldr r0,[pool_037FE9DC]	; 037FE994
	ldr r2,[r0,#0x0]	; 037FE996
	cmp r2,#0x0	; 037FE998
	beq P2_Entry_037FE9C0	; 037FE99A
	add r2,#0x40	; 037FE99C
	ldrb r1,[r5,#0x2]	; 037FE99E
	mov r0,#0x24	; 037FE9A0
	mul r1,r0	; 037FE9A2
	ldr r0,[r2,r1]	; 037FE9A4
	add r0,r0,r4	; 037FE9A6
	str r0,[r2,r1]	; 037FE9A8
	b P2_Entry_037FE9C0	; 037FE9AA
P2_Entry_037FE9AC:
	add r0,r5,#0x0	; 037FE9AC
	bl P2_Entry_037FE014	; 037FE9AE
	cmp r0,#0x0	; 037FE9B2
	beq P2_Entry_037FE9BE	; 037FE9B4
	add r0,r5,#0x0	; 037FE9B6
	bl loc_037FE8F0	; 037FE9B8
	b P2_Entry_037FE9C4	; 037FE9BC
P2_Entry_037FE9BE:
	sub r4,r4,#0x1	; 037FE9BE
P2_Entry_037FE9C0:
	cmp r4,#0x0	; 037FE9C0
	bgt P2_Entry_037FE9AC	; 037FE9C2
P2_Entry_037FE9C4:
	ldrh r2,[r5,#0x18]	; 037FE9C4
	ldrh r0,[r5,#0x1a]	; 037FE9C6
	mul r2,r0	; 037FE9C8
	add r5,#0x1c	; 037FE9CA
	ldrh r1,[r5,#0x0]	; 037FE9CC
	asr r0,r2,#0x8	; 037FE9CE
	add r0,r1,r0	; 037FE9D0
	strh r0,[r5,#0x0]	; 037FE9D2
	add sp,#0x4	; 037FE9D4
	pop {r4,r5}	; 037FE9D6
	pop {r3}	; 037FE9D8
	bx r3	; 037FE9DA
pool_037FE9DC:
	.word P2_BssStart + 0xB70	; 037FE9DC

; ===== function loc_037FE9E0 =====
loc_037FE9E0:
	push {r4,r5,r6,r7,lr}	; 037FE9E0
	sub sp,#0x4	; 037FE9E2
	add r5,r0,#0x0	; 037FE9E4
	add r6,r2,#0x0	; 037FE9E6
	ldr r4,[r5,#0x3c]	; 037FE9E8
	bl loc_037FE820	; 037FE9EA
	lsl r0,r6,#0x18	; 037FE9EE
	lsr r7,r0,#0x18	; 037FE9F0
	b loc_037FEA20	; 037FE9F2
loc_037FE9F4:
	add r0,r4,#0x0	; 037FE9F4
	bl loc_037FDB58	; 037FE9F6
	cmp r0,#0x0	; 037FE9FA
	beq loc_037FEA18	; 037FE9FC
	cmp r6,#0x0	; 037FE9FE
	blt loc_037FEA0A	; 037FEA00
	add r0,r4,#0x0	; 037FEA02
	add r1,r7,#0x0	; 037FEA04
	bl loc_037FDB68	; 037FEA06
loc_037FEA0A:
	add r1,r4,#0x0	; 037FEA0A
	add r1,#0x22	; 037FEA0C
	mov r0,#0x1	; 037FEA0E
	strb r0,[r1,#0x0]	; 037FEA10
	add r0,r4,#0x0	; 037FEA12
	bl loc_037FDB60	; 037FEA14
loc_037FEA18:
	add r0,r4,#0x0	; 037FEA18
	bl loc_037FDA88	; 037FEA1A
	ldr r4,[r4,#0x50]	; 037FEA1E
loc_037FEA20:
	cmp r4,#0x0	; 037FEA20
	bne loc_037FE9F4	; 037FEA22
	mov r0,#0x0	; 037FEA24
	str r0,[r5,#0x3c]	; 037FEA26
	add sp,#0x4	; 037FEA28
	pop {r4,r5,r6,r7}	; 037FEA2A
	pop {r3}	; 037FEA2C
	bx r3	; 037FEA2E

; ===== function loc_037FEA30 =====
loc_037FEA30:
	push {r4,r5,r6,r7,lr}	; 037FEA30
	sub sp,#0x4	; 037FEA32
	mov r2,#0x0	; 037FEA34
	strb r2,[r0,#0x1]	; 037FEA36
	str r1,[r0,#0x20]	; 037FEA38
	mov r1,#0x78	; 037FEA3A
	strh r1,[r0,#0x18]	; 037FEA3C
	ldr r1,[pool_037FEA8C]	; 037FEA3E
	strh r1,[r0,#0x1a]	; 037FEA40
	strh r2,[r0,#0x1c]	; 037FEA42
	mov r1,#0x7f	; 037FEA44
	strb r1,[r0,#0x5]	; 037FEA46
	strh r2,[r0,#0x6]	; 037FEA48
	mov r1,#0x40	; 037FEA4A
	strb r1,[r0,#0x4]	; 037FEA4C
	mov r3,#0xff	; 037FEA4E
loc_037FEA50:
	add r1,r0,r2	; 037FEA50
	strb r3,[r1,#0x8]	; 037FEA52
	add r2,r2,#0x1	; 037FEA54
	cmp r2,#0x10	; 037FEA56
	blt loc_037FEA50	; 037FEA58
	ldr r4,[pool_037FEA90]	; 037FEA5A
	ldr r5,[r4,#0x0]	; 037FEA5C
	cmp r5,#0x0	; 037FEA5E
	beq loc_037FEA84	; 037FEA60
	mov r2,#0x0	; 037FEA62
	ldrb r1,[r0,#0x2]	; 037FEA64
	mov r3,#0x24	; 037FEA66
	mul r1,r3	; 037FEA68
	add r1,r5,r1	; 037FEA6A
	str r2,[r1,#0x40]	; 037FEA6C
	mvn r1,r2	; 037FEA6E
loc_037FEA70:
	ldr r7,[r4,#0x0]	; 037FEA70
	ldrb r5,[r0,#0x2]	; 037FEA72
	mul r5,r3	; 037FEA74
	lsl r6,r2,#0x1	; 037FEA76
	add r5,r7,r5	; 037FEA78
	add r5,r6,r5	; 037FEA7A
	strh r1,[r5,#0x20]	; 037FEA7C
	add r2,r2,#0x1	; 037FEA7E
	cmp r2,#0x10	; 037FEA80
	blt loc_037FEA70	; 037FEA82
loc_037FEA84:
	add sp,#0x4	; 037FEA84
	pop {r4,r5,r6,r7}	; 037FEA86
	pop {r3}	; 037FEA88
	bx r3	; 037FEA8A
pool_037FEA8C:
loc_037FEA8C:
	.word 0x00000100	; 037FEA8C
pool_037FEA90:
loc_037FEA90:
	.word P2_BssStart + 0xB70	; 037FEA90

; ===== function loc_037FEA94 =====
loc_037FEA94:
	str r1,[r0,#0x24]	; 037FEA94
	ldr r1,[r0,#0x24]	; 037FEA96
	add r1,r1,r2	; 037FEA98
	str r1,[r0,#0x28]	; 037FEA9A
	bx lr	; 037FEA9C
	.byte 0x00, 0x00	; 037FEAA0

; ===== function loc_037FEAA0 =====
loc_037FEAA0:
	push {r4,r5,lr}	; 037FEAA0
	sub sp,#0x4	; 037FEAA2
	add r4,r0,#0x0	; 037FEAA4
	mov r1,#0x0	; 037FEAA6
	str r1,[r4,#0x24]	; 037FEAA8
	str r1,[r4,#0x28]	; 037FEAAA
	ldrb r2,[r4,#0x0]	; 037FEAAC
	mov r0,#0x2	; 037FEAAE
	orr r2,r0	; 037FEAB0
	strb r2,[r4,#0x0]	; 037FEAB2
	ldrb r3,[r4,#0x0]	; 037FEAB4
	mov r2,#0x4	; 037FEAB6
	bic r3,r2	; 037FEAB8
	strb r3,[r4,#0x0]	; 037FEABA
	ldrb r3,[r4,#0x0]	; 037FEABC
	mov r2,#0x8	; 037FEABE
	bic r3,r2	; 037FEAC0
	strb r3,[r4,#0x0]	; 037FEAC2
	ldrb r3,[r4,#0x0]	; 037FEAC4
	mov r2,#0x10	; 037FEAC6
	bic r3,r2	; 037FEAC8
	strb r3,[r4,#0x0]	; 037FEACA
	ldrb r3,[r4,#0x0]	; 037FEACC
	mov r2,#0x20	; 037FEACE
	bic r3,r2	; 037FEAD0
	strb r3,[r4,#0x0]	; 037FEAD2
	ldrb r2,[r4,#0x0]	; 037FEAD4
	mov r3,#0x40	; 037FEAD6
	orr r2,r3	; 037FEAD8
	strb r2,[r4,#0x0]	; 037FEADA
	ldrb r5,[r4,#0x0]	; 037FEADC
	mov r2,#0x80	; 037FEADE
	bic r5,r2	; 037FEAE0
	strb r5,[r4,#0x0]	; 037FEAE2
	add r2,r4,#0x0	; 037FEAE4
	add r2,#0x3b	; 037FEAE6
	strb r1,[r2,#0x0]	; 037FEAE8
	strh r1,[r4,#0x2]	; 037FEAEA
	strb r3,[r4,#0x12]	; 037FEAEC
	mov r2,#0x7f	; 037FEAEE
	strb r2,[r4,#0x4]	; 037FEAF0
	strb r2,[r4,#0x5]	; 037FEAF2
	strh r1,[r4,#0xa]	; 037FEAF4
	strb r1,[r4,#0x8]	; 037FEAF6
	strb r1,[r4,#0x9]	; 037FEAF8
	strb r1,[r4,#0x6]	; 037FEAFA
	strh r1,[r4,#0xc]	; 037FEAFC
	mov r2,#0xff	; 037FEAFE
	strb r2,[r4,#0xe]	; 037FEB00
	strb r2,[r4,#0xf]	; 037FEB02
	strb r2,[r4,#0x10]	; 037FEB04
	strb r2,[r4,#0x11]	; 037FEB06
	strb r0,[r4,#0x7]	; 037FEB08
	mov r0,#0x3c	; 037FEB0A
	strb r0,[r4,#0x14]	; 037FEB0C
	strb r1,[r4,#0x15]	; 037FEB0E
	strh r1,[r4,#0x16]	; 037FEB10
	strb r1,[r4,#0x13]	; 037FEB12
	ldr r0,[pool_037FEB30]	; 037FEB14
	strh r0,[r4,#0x1e]	; 037FEB16
	add r0,r4,#0x0	; 037FEB18
	add r0,#0x18	; 037FEB1A
	bl loc_037FD8D0	; 037FEB1C
	mov r0,#0x0	; 037FEB20
	str r0,[r4,#0x20]	; 037FEB22
	str r0,[r4,#0x3c]	; 037FEB24
	add sp,#0x4	; 037FEB26
	pop {r4,r5}	; 037FEB28
	pop {r3}	; 037FEB2A
	bx r3	; 037FEB2C
	.byte 0xC0, 0x46	; 037FEB30
pool_037FEB30:
loc_037FEB30:
	.word 0x0000FFFF	; 037FEB30

; ===== function loc_037FEB34 =====
P2_Entry_037FEB34:
	push {r4,r5,r6,lr}	; 037FEB34
	add r4,r0,#0x0	; 037FEB36
	add r6,r1,#0x0	; 037FEB38
	cmp r2,#0x4	; 037FEB3A
	bhi loc_037FEBA4	; 037FEB3C
	add r1,r2,r2	; 037FEB3E
P2_SwitchIndexPC_037FEB3E:
	add r1,pc	; 037FEB40
	ldrh r1,[r1,#(P2_SwitchTable_037FEB3E - (P2_SwitchIndexPC_037FEB3E + 4))]	; 037FEB42
	lsl r1,r1,#0x10	; 037FEB44
	asr r1,r1,#0x10	; 037FEB46
P2_SwitchTargetPC_037FEB3E:
	add r1,pc	; 037FEB48
	bx r1	; 037FEB4A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FEB3E:
	.halfword (loc_037FEB56 + 1) - (P2_SwitchTargetPC_037FEB3E + 4)
	.halfword (loc_037FEB5E + 1) - (P2_SwitchTargetPC_037FEB3E + 4)
	.halfword (loc_037FEB66 + 1) - (P2_SwitchTargetPC_037FEB3E + 4)
	.halfword (loc_037FEB84 + 1) - (P2_SwitchTargetPC_037FEB3E + 4)
	.halfword (loc_037FEB6E + 1) - (P2_SwitchTargetPC_037FEB3E + 4)
P2_SwitchTable_037FEB3EEnd:
loc_037FEB56:
	bl loc_037FEC60	; 037FEB56
	add r5,r0,#0x0	; 037FEB5A
	b loc_037FEBA4	; 037FEB5C
loc_037FEB5E:
	bl loc_037FEC28	; 037FEB5E
	add r5,r0,#0x0	; 037FEB62
	b loc_037FEBA4	; 037FEB64
loc_037FEB66:
	bl loc_037FEBAC	; 037FEB66
	add r5,r0,#0x0	; 037FEB6A
	b loc_037FEBA4	; 037FEB6C
loc_037FEB6E:
	bl loc_037FEC60	; 037FEB6E
	add r1,r0,#0x0	; 037FEB72
	add r0,r6,#0x0	; 037FEB74
	bl loc_037FDFE0	; 037FEB76
	cmp r0,#0x0	; 037FEB7A
	beq loc_037FEBA4	; 037FEB7C
	mov r1,#0x0	; 037FEB7E
	ldrsh r5,[r0,r1]	; 037FEB80
	b loc_037FEBA4	; 037FEB82
loc_037FEB84:
	bl loc_037FEC28	; 037FEB84
	lsl r0,r0,#0x10	; 037FEB88
	asr r5,r0,#0x10	; 037FEB8A
	add r0,r4,#0x0	; 037FEB8C
	bl loc_037FEC28	; 037FEB8E
	lsl r0,r0,#0x10	; 037FEB92
	asr r4,r0,#0x10	; 037FEB94
	bl loc_037FD29C	; 037FEB96
	sub r1,r4,r5	; 037FEB9A
	add r1,r1,#0x1	; 037FEB9C
	mul r0,r1	; 037FEB9E
	asr r0,r0,#0x10	; 037FEBA0
	add r5,r0,r5	; 037FEBA2
loc_037FEBA4:
	add r0,r5,#0x0	; 037FEBA4
	pop {r4,r5,r6}	; 037FEBA6
	pop {r3}	; 037FEBA8
	bx r3	; 037FEBAA

; ===== function loc_037FEBAC =====
loc_037FEBAC:
	push {r4,r5,r6,r7,lr}	; 037FEBAC
	sub sp,#0x4	; 037FEBAE
	add r6,r0,#0x0	; 037FEBB0
	mov r5,#0x0	; 037FEBB2
	add r4,r6,#0x0	; 037FEBB4
	add r4,#0x28	; 037FEBB6
	mov r7,#0x80	; 037FEBB8
loc_037FEBBA:
	ldr r0,[r6,#0x28]	; 037FEBBA
	bl loc_037FEC78	; 037FEBBC
	ldr r1,[r4,#0x0]	; 037FEBC0
	add r1,r1,#0x1	; 037FEBC2
	str r1,[r4,#0x0]	; 037FEBC4
	lsl r5,r5,#0x7	; 037FEBC6
	add r2,r0,#0x0	; 037FEBC8
	mov r1,#0x7f	; 037FEBCA
	and r2,r1	; 037FEBCC
	orr r5,r2	; 037FEBCE
	and r0,r7	; 037FEBD0
	cmp r0,#0x0	; 037FEBD2
	bne loc_037FEBBA	; 037FEBD4
	add r0,r5,#0x0	; 037FEBD6
	add sp,#0x4	; 037FEBD8
	pop {r4,r5,r6,r7}	; 037FEBDA
	pop {r3}	; 037FEBDC
	bx r3	; 037FEBDE
P2_Entry_037FEBE0:
	push {r4,r5,lr}	; 037FEBE0
	sub sp,#0x4	; 037FEBE2
	add r5,r0,#0x0	; 037FEBE4
	ldr r0,[r5,#0x28]	; 037FEBE6
	bl loc_037FEC78	; 037FEBE8
	add r4,r0,#0x0	; 037FEBEC
	add r1,r5,#0x0	; 037FEBEE
	add r1,#0x28	; 037FEBF0
	ldr r0,[r1,#0x0]	; 037FEBF2
	add r0,r0,#0x1	; 037FEBF4
	str r0,[r1,#0x0]	; 037FEBF6
	ldr r0,[r5,#0x28]	; 037FEBF8
	bl loc_037FEC78	; 037FEBFA
	lsl r0,r0,#0x8	; 037FEBFE
	orr r4,r0	; 037FEC00
	add r1,r5,#0x0	; 037FEC02
	add r1,#0x28	; 037FEC04
	ldr r0,[r1,#0x0]	; 037FEC06
	add r0,r0,#0x1	; 037FEC08
	str r0,[r1,#0x0]	; 037FEC0A
	ldr r0,[r5,#0x28]	; 037FEC0C
	bl loc_037FEC78	; 037FEC0E
	lsl r0,r0,#0x10	; 037FEC12
	orr r4,r0	; 037FEC14
	add r5,#0x28	; 037FEC16
	ldr r0,[r5,#0x0]	; 037FEC18
	add r0,r0,#0x1	; 037FEC1A
	str r0,[r5,#0x0]	; 037FEC1C
	add r0,r4,#0x0	; 037FEC1E
	add sp,#0x4	; 037FEC20
	pop {r4,r5}	; 037FEC22
	pop {r3}	; 037FEC24
	bx r3	; 037FEC26

; ===== function loc_037FEC28 =====
loc_037FEC28:
	push {r4,r5,lr}	; 037FEC28
	sub sp,#0x4	; 037FEC2A
	add r5,r0,#0x0	; 037FEC2C
	ldr r0,[r5,#0x28]	; 037FEC2E
	bl loc_037FEC78	; 037FEC30
	add r4,r0,#0x0	; 037FEC34
	add r1,r5,#0x0	; 037FEC36
	add r1,#0x28	; 037FEC38
	ldr r0,[r1,#0x0]	; 037FEC3A
	add r0,r0,#0x1	; 037FEC3C
	str r0,[r1,#0x0]	; 037FEC3E
	ldr r0,[r5,#0x28]	; 037FEC40
	bl loc_037FEC78	; 037FEC42
	lsl r0,r0,#0x8	; 037FEC46
	orr r4,r0	; 037FEC48
	lsl r0,r4,#0x10	; 037FEC4A
	lsr r0,r0,#0x10	; 037FEC4C
	add r5,#0x28	; 037FEC4E
	ldr r1,[r5,#0x0]	; 037FEC50
	add r1,r1,#0x1	; 037FEC52
	str r1,[r5,#0x0]	; 037FEC54
	add sp,#0x4	; 037FEC56
	pop {r4,r5}	; 037FEC58
	pop {r3}	; 037FEC5A
	bx r3	; 037FEC5C
	.byte 0x00, 0x00	; 037FEC60

; ===== function loc_037FEC60 =====
loc_037FEC60:
	push {r4,lr}	; 037FEC60
	add r4,r0,#0x0	; 037FEC62
	ldr r0,[r4,#0x28]	; 037FEC64
	bl loc_037FEC78	; 037FEC66
	add r4,#0x28	; 037FEC6A
	ldr r1,[r4,#0x0]	; 037FEC6C
	add r1,r1,#0x1	; 037FEC6E
	str r1,[r4,#0x0]	; 037FEC70
	pop {r4}	; 037FEC72
	pop {r3}	; 037FEC74
	bx r3	; 037FEC76

; ===== function loc_037FEC78 =====
loc_037FEC78:
	push {r4,lr}	; 037FEC78
	add r4,r0,#0x0	; 037FEC7A
	ldr r0,[pool_037FECA0]	; 037FEC7C
	ldr r1,[r0,#0x0]	; 037FEC7E
	cmp r4,r1	; 037FEC80
	bcc loc_037FEC8A	; 037FEC82
	ldr r0,[r0,#0x4]	; 037FEC84
	cmp r4,r0	; 037FEC86
	bcc loc_037FEC90	; 037FEC88
loc_037FEC8A:
	add r0,r4,#0x0	; 037FEC8A
	bl loc_037FECA8	; 037FEC8C
loc_037FEC90:
	ldr r0,[pool_037FECA0]	; 037FEC90
	ldr r0,[r0,#0x0]	; 037FEC92
	sub r1,r4,r0	; 037FEC94
	ldr r0,[pool_037FECA4]	; 037FEC96
	ldrb r0,[r0,r1]	; 037FEC98
	pop {r4}	; 037FEC9A
	pop {r3}	; 037FEC9C
	bx r3	; 037FEC9E
pool_037FECA0:
loc_037FECA0:
	.word P2_BssStart + 0xB58	; 037FECA0
pool_037FECA4:
loc_037FECA4:
	.word P2_BssStart + 0xB60	; 037FECA4

; ===== function loc_037FECA8 =====
loc_037FECA8:
	mov r1,#0x3	; 037FECA8
	bic r0,r1	; 037FECAA
	ldr r1,[pool_037FECC8]	; 037FECAC
	str r0,[r1,#0x0]	; 037FECAE
	add r2,r0,#0x0	; 037FECB0
	add r2,#0x10	; 037FECB2
	str r2,[r1,#0x4]	; 037FECB4
	ldr r2,[r0,#0x0]	; 037FECB6
	str r2,[r1,#0x8]	; 037FECB8
	ldr r2,[r0,#0x4]	; 037FECBA
	str r2,[r1,#0xc]	; 037FECBC
	ldr r2,[r0,#0x8]	; 037FECBE
	str r2,[r1,#0x10]	; 037FECC0
	ldr r0,[r0,#0xc]	; 037FECC2
	str r0,[r1,#0x14]	; 037FECC4
	bx lr	; 037FECC6
pool_037FECC8:
loc_037FECC8:
	.word P2_BssStart + 0xB58	; 037FECC8

; ===== function loc_037FECCC =====
loc_037FECCC:
	push {r4,r5,r6,r7,lr}	; 037FECCC
	sub sp,#0x4	; 037FECCE
	add r6,r1,#0x0	; 037FECD0
	add r5,r3,#0x0	; 037FECD2
	ldr r4,[sp,#0x18]	; 037FECD4
	ldr r3,[pool_037FED24]	; 037FECD6
	mov r1,#0x24	; 037FECD8
	mul r0,r1	; 037FECDA
	add r7,r3,r0	; 037FECDC
	mov r3,#0x0	; 037FECDE
	b loc_037FED14	; 037FECE0
loc_037FECE2:
	add r1,r6,#0x0	; 037FECE2
	mov r0,#0x1	; 037FECE4
	and r1,r0	; 037FECE6
	cmp r1,#0x0	; 037FECE8
	beq loc_037FED10	; 037FECEA
	add r0,r7,#0x0	; 037FECEC
	add r1,r3,#0x0	; 037FECEE
	bl loc_037FE958	; 037FECF0
	cmp r0,#0x0	; 037FECF4
	beq loc_037FED10	; 037FECF6
	cmp r4,#0x1	; 037FECF8
	beq loc_037FED06	; 037FECFA
	cmp r4,#0x2	; 037FECFC
	beq loc_037FED0A	; 037FECFE
	cmp r4,#0x4	; 037FED00
	beq loc_037FED0E	; 037FED02
	b loc_037FED10	; 037FED04
loc_037FED06:
	strb r5,[r0,r2]	; 037FED06
	b loc_037FED10	; 037FED08
loc_037FED0A:
	strh r5,[r0,r2]	; 037FED0A
	b loc_037FED10	; 037FED0C
loc_037FED0E:
	str r5,[r0,r2]	; 037FED0E
loc_037FED10:
	add r3,r3,#0x1	; 037FED10
	lsr r6,r6,#0x1	; 037FED12
loc_037FED14:
	cmp r3,#0x10	; 037FED14
	bge loc_037FED1C	; 037FED16
	cmp r6,#0x0	; 037FED18
	bne loc_037FECE2	; 037FED1A
loc_037FED1C:
	add sp,#0x4	; 037FED1C
	pop {r4,r5,r6,r7}	; 037FED1E
	pop {r3}	; 037FED20
	bx r3	; 037FED22
pool_037FED24:
loc_037FED24:
	.word 0x03803DBC	; 037FED24

; ===== function loc_037FED28 =====
loc_037FED28:
	push {r4,r5,lr}	; 037FED28
	sub sp,#0x4	; 037FED2A
	ldr r5,[pool_037FED54]	; 037FED2C
	mov r4,#0x24	; 037FED2E
	mul r0,r4	; 037FED30
	add r0,r5,r0	; 037FED32
	cmp r3,#0x1	; 037FED34
	beq loc_037FED42	; 037FED36
	cmp r3,#0x2	; 037FED38
	beq loc_037FED46	; 037FED3A
	cmp r3,#0x4	; 037FED3C
	beq loc_037FED4A	; 037FED3E
	b loc_037FED4C	; 037FED40
loc_037FED42:
	strb r2,[r0,r1]	; 037FED42
	b loc_037FED4C	; 037FED44
loc_037FED46:
	strh r2,[r0,r1]	; 037FED46
	b loc_037FED4C	; 037FED48
loc_037FED4A:
	str r2,[r0,r1]	; 037FED4A
loc_037FED4C:
	add sp,#0x4	; 037FED4C
	pop {r4,r5}	; 037FED4E
	pop {r3}	; 037FED50
	bx r3	; 037FED52
pool_037FED54:
loc_037FED54:
	.word 0x03803DBC	; 037FED54

; ===== function loc_037FED58 =====
loc_037FED58:
	push {r4,r5,r6,r7,lr}	; 037FED58
	sub sp,#0x4	; 037FED5A
	add r5,r0,#0x0	; 037FED5C
	add r6,r1,#0x0	; 037FED5E
	mov r4,#0x0	; 037FED60
	ldr r7,[pool_037FED90]	; 037FED62
loc_037FED64:
	add r1,r4,#0x0	; 037FED64
	mov r0,#0x24	; 037FED66
	mul r1,r0	; 037FED68
	add r0,r7,r1	; 037FED6A
	ldrb r1,[r7,r1]	; 037FED6C
	cmp r1,#0x0	; 037FED6E
	beq loc_037FED80	; 037FED70
	ldr r1,[r0,#0x20]	; 037FED72
	cmp r5,r1	; 037FED74
	bhi loc_037FED80	; 037FED76
	cmp r1,r6	; 037FED78
	bhi loc_037FED80	; 037FED7A
	bl loc_037FE8F0	; 037FED7C
loc_037FED80:
	add r4,r4,#0x1	; 037FED80
	cmp r4,#0x10	; 037FED82
	blt loc_037FED64	; 037FED84
	add sp,#0x4	; 037FED86
	pop {r4,r5,r6,r7}	; 037FED88
	pop {r3}	; 037FED8A
	bx r3	; 037FED8C
	.byte 0xC0, 0x46	; 037FED90
pool_037FED90:
loc_037FED90:
	.word P2_BssStart + 0x10B4	; 037FED90

; ===== function loc_037FED94 =====
loc_037FED94:
	push {r4,r5,r6,r7,lr}	; 037FED94
	sub sp,#0x4	; 037FED96
	add r5,r0,#0x0	; 037FED98
	add r6,r1,#0x0	; 037FED9A
	mov r4,#0x0	; 037FED9C
	add r7,r4,#0x0	; 037FED9E
loc_037FEDA0:
	add r0,r4,#0x0	; 037FEDA0
	mov r1,#0x24	; 037FEDA2
	mul r0,r1	; 037FEDA4
	ldr r1,[pool_037FEDE8]	; 037FEDA6
	add r3,r1,r0	; 037FEDA8
	ldrb r0,[r1,r0]	; 037FEDAA
	cmp r0,#0x0	; 037FEDAC
	beq loc_037FEDD8	; 037FEDAE
	add r2,r7,#0x0	; 037FEDB0
	b loc_037FEDD4	; 037FEDB2
loc_037FEDB4:
	add r0,r3,#0x0	; 037FEDB4
	add r1,r2,#0x0	; 037FEDB6
	bl loc_037FE958	; 037FEDB8
	cmp r0,#0x0	; 037FEDBC
	beq loc_037FEDD2	; 037FEDBE
	ldr r0,[r0,#0x28]	; 037FEDC0
	cmp r5,r0	; 037FEDC2
	bhi loc_037FEDD2	; 037FEDC4
	cmp r0,r6	; 037FEDC6
	bhi loc_037FEDD2	; 037FEDC8
	add r0,r3,#0x0	; 037FEDCA
	bl loc_037FE8F0	; 037FEDCC
	b loc_037FEDD8	; 037FEDD0
loc_037FEDD2:
	add r2,r2,#0x1	; 037FEDD2
loc_037FEDD4:
	cmp r2,#0x10	; 037FEDD4
	blt loc_037FEDB4	; 037FEDD6
loc_037FEDD8:
	add r4,r4,#0x1	; 037FEDD8
	cmp r4,#0x10	; 037FEDDA
	blt loc_037FEDA0	; 037FEDDC
	add sp,#0x4	; 037FEDDE
	pop {r4,r5,r6,r7}	; 037FEDE0
	pop {r3}	; 037FEDE2
	bx r3	; 037FEDE4
	.byte 0xC0, 0x46	; 037FEDE8
pool_037FEDE8:
loc_037FEDE8:
	.word P2_BssStart + 0x10B4	; 037FEDE8

; ===== function loc_037FEDEC =====
loc_037FEDEC:
	push {r4,r5,r6,r7,lr}	; 037FEDEC
	sub sp,#0x4	; 037FEDEE
	add r5,r1,#0x0	; 037FEDF0
	ldr r3,[pool_037FEE38]	; 037FEDF2
	mov r1,#0x24	; 037FEDF4
	mul r0,r1	; 037FEDF6
	add r4,r3,r0	; 037FEDF8
	mov r3,#0x0	; 037FEDFA
	lsl r0,r2,#0x10	; 037FEDFC
	lsr r2,r0,#0x10	; 037FEDFE
	mov r7,#0x80	; 037FEE00
	mov r6,#0x1	; 037FEE02
	b loc_037FEE28	; 037FEE04
loc_037FEE06:
	add r0,r5,#0x0	; 037FEE06
	and r0,r6	; 037FEE08
	cmp r0,#0x0	; 037FEE0A
	beq loc_037FEE24	; 037FEE0C
	add r0,r4,#0x0	; 037FEE0E
	add r1,r3,#0x0	; 037FEE10
	bl loc_037FE958	; 037FEE12
	add r1,r0,#0x0	; 037FEE16
	cmp r1,#0x0	; 037FEE18
	beq loc_037FEE24	; 037FEE1A
	strh r2,[r1,#0x1e]	; 037FEE1C
	ldrb r0,[r1,#0x0]	; 037FEE1E
	orr r0,r7	; 037FEE20
	strb r0,[r1,#0x0]	; 037FEE22
loc_037FEE24:
	add r3,r3,#0x1	; 037FEE24
	lsr r5,r5,#0x1	; 037FEE26
loc_037FEE28:
	cmp r3,#0x10	; 037FEE28
	bge loc_037FEE30	; 037FEE2A
	cmp r5,#0x0	; 037FEE2C
	bne loc_037FEE06	; 037FEE2E
loc_037FEE30:
	add sp,#0x4	; 037FEE30
	pop {r4,r5,r6,r7}	; 037FEE32
	pop {r3}	; 037FEE34
	bx r3	; 037FEE36
pool_037FEE38:
loc_037FEE38:
	.word 0x03803DBC	; 037FEE38

; ===== function loc_037FEE3C =====
loc_037FEE3C:
	push {r4,r5,r6,r7,lr}	; 037FEE3C
	sub sp,#0x4	; 037FEE3E
	add r5,r1,#0x0	; 037FEE40
	add r6,r2,#0x0	; 037FEE42
	ldr r2,[pool_037FEEA0]	; 037FEE44
	mov r1,#0x24	; 037FEE46
	mul r0,r1	; 037FEE48
	add r0,r2,r0	; 037FEE4A
	str r0,[sp,#0x0]	; 037FEE4C
	mov r4,#0x0	; 037FEE4E
	b loc_037FEE8E	; 037FEE50
loc_037FEE52:
	add r1,r5,#0x0	; 037FEE52
	mov r0,#0x1	; 037FEE54
	and r1,r0	; 037FEE56
	cmp r1,#0x0	; 037FEE58
	beq loc_037FEE8A	; 037FEE5A
	ldr r0,[sp,#0x0]	; 037FEE5C
	add r1,r4,#0x0	; 037FEE5E
	bl loc_037FE958	; 037FEE60
	add r7,r0,#0x0	; 037FEE64
	cmp r7,#0x0	; 037FEE66
	beq loc_037FEE8A	; 037FEE68
	cmp r6,#0x0	; 037FEE6A
	beq loc_037FEE76	; 037FEE6C
	ldr r1,[sp,#0x0]	; 037FEE6E
	mov r2,#0x7f	; 037FEE70
	bl loc_037FE9E0	; 037FEE72
loc_037FEE76:
	ldrb r0,[r7,#0x0]	; 037FEE76
	mov r1,#0x4	; 037FEE78
	bic r0,r1	; 037FEE7A
	lsl r1,r6,#0x18	; 037FEE7C
	lsr r2,r1,#0x18	; 037FEE7E
	mov r1,#0x1	; 037FEE80
	and r2,r1	; 037FEE82
	lsl r1,r2,#0x2	; 037FEE84
	orr r0,r1	; 037FEE86
	strb r0,[r7,#0x0]	; 037FEE88
loc_037FEE8A:
	add r4,r4,#0x1	; 037FEE8A
	lsr r5,r5,#0x1	; 037FEE8C
loc_037FEE8E:
	cmp r4,#0x10	; 037FEE8E
	bge loc_037FEE96	; 037FEE90
	cmp r5,#0x0	; 037FEE92
	bne loc_037FEE52	; 037FEE94
loc_037FEE96:
	add sp,#0x4	; 037FEE96
	pop {r4,r5,r6,r7}	; 037FEE98
	pop {r3}	; 037FEE9A
	bx r3	; 037FEE9C
	.byte 0xC0, 0x46	; 037FEEA0
pool_037FEEA0:
loc_037FEEA0:
	.word 0x03803DBC	; 037FEEA0

; ===== function loc_037FEEA4 =====
loc_037FEEA4:
	push {r4,r5,r6,lr}	; 037FEEA4
	ldr r3,[pool_037FEED8]	; 037FEEA6
	mov r2,#0x24	; 037FEEA8
	mul r0,r2	; 037FEEAA
	add r5,r3,r0	; 037FEEAC
	strb r1,[r5,#0x1]	; 037FEEAE
	cmp r1,#0x0	; 037FEEB0
	beq loc_037FEED2	; 037FEEB2
	mov r4,#0x0	; 037FEEB4
	mov r6,#0x7f	; 037FEEB6
loc_037FEEB8:
	add r0,r5,#0x0	; 037FEEB8
	add r1,r4,#0x0	; 037FEEBA
	bl loc_037FE958	; 037FEEBC
	cmp r0,#0x0	; 037FEEC0
	beq loc_037FEECC	; 037FEEC2
	add r1,r5,#0x0	; 037FEEC4
	add r2,r6,#0x0	; 037FEEC6
	bl loc_037FE9E0	; 037FEEC8
loc_037FEECC:
	add r4,r4,#0x1	; 037FEECC
	cmp r4,#0x10	; 037FEECE
	blt loc_037FEEB8	; 037FEED0
loc_037FEED2:
	pop {r4,r5,r6}	; 037FEED2
	pop {r3}	; 037FEED4
	bx r3	; 037FEED6
pool_037FEED8:
loc_037FEED8:
	.word 0x03803DBC	; 037FEED8

; ===== function loc_037FEEDC =====
loc_037FEEDC:
	push {r4,lr}	; 037FEEDC
	add r4,r0,#0x0	; 037FEEDE
	ldr r2,[pool_037FEF10]	; 037FEEE0
	mov r0,#0x24	; 037FEEE2
	add r1,r4,#0x0	; 037FEEE4
	mul r1,r0	; 037FEEE6
	add r0,r2,r1	; 037FEEE8
	ldrb r1,[r2,r1]	; 037FEEEA
	cmp r1,#0x0	; 037FEEEC
	beq loc_037FEF08	; 037FEEEE
	bl loc_037FE8F0	; 037FEEF0
	ldr r0,[pool_037FEF14]	; 037FEEF4
	ldr r0,[r0,#0x0]	; 037FEEF6
	cmp r0,#0x0	; 037FEEF8
	beq loc_037FEF08	; 037FEEFA
	add r2,r0,#0x4	; 037FEEFC
	ldr r1,[r2,#0x0]	; 037FEEFE
	mov r0,#0x1	; 037FEF00
	lsl r0,r4	; 037FEF02
	bic r1,r0	; 037FEF04
	str r1,[r2,#0x0]	; 037FEF06
loc_037FEF08:
	pop {r4}	; 037FEF08
	pop {r3}	; 037FEF0A
	bx r3	; 037FEF0C
	.byte 0xC0, 0x46	; 037FEF10
pool_037FEF10:
loc_037FEF10:
	.word P2_BssStart + 0x10B4	; 037FEF10
pool_037FEF14:
loc_037FEF14:
	.word P2_BssStart + 0xB70	; 037FEF14

; ===== function loc_037FEF18 =====
loc_037FEF18:
	push {r4,r5,r6,r7,lr}	; 037FEF18
	sub sp,#0xc	; 037FEF1A
	str r0,[sp,#0x0]	; 037FEF1C
	add r7,r1,#0x0	; 037FEF1E
	str r2,[sp,#0x4]	; 037FEF20
	add r4,r3,#0x0	; 037FEF22
	ldr r2,[pool_037FEFDC]	; 037FEF24
	mov r0,#0x24	; 037FEF26
	ldr r1,[sp,#0x0]	; 037FEF28
	mul r1,r0	; 037FEF2A
	add r5,r2,r1	; 037FEF2C
	ldrb r0,[r2,r1]	; 037FEF2E
	cmp r0,#0x0	; 037FEF30
	beq loc_037FEF3A	; 037FEF32
	add r0,r5,#0x0	; 037FEF34
	bl loc_037FE8F0	; 037FEF36
loc_037FEF3A:
	add r0,r5,#0x0	; 037FEF3A
	add r1,r4,#0x0	; 037FEF3C
	bl loc_037FEA30	; 037FEF3E
	bl loc_037FDFAC	; 037FEF42
	add r6,r0,#0x0	; 037FEF46
	cmp r6,#0x0	; 037FEF48
	blt loc_037FEFD2	; 037FEF4A
	ldr r1,[pool_037FEFE0]	; 037FEF4C
	lsl r0,r6,#0x6	; 037FEF4E
	add r4,r1,r0	; 037FEF50
	add r0,r4,#0x0	; 037FEF52
	bl loc_037FEAA0	; 037FEF54
	add r0,r4,#0x0	; 037FEF58
	add r1,r7,#0x0	; 037FEF5A
	ldr r2,[sp,#0x4]	; 037FEF5C
	bl loc_037FEA94	; 037FEF5E
	strb r6,[r5,#0x8]	; 037FEF62
	ldr r0,[r4,#0x28]	; 037FEF64
	bl loc_037FECA8	; 037FEF66
	add r0,r4,#0x0	; 037FEF6A
	bl loc_037FEC60	; 037FEF6C
	cmp r0,#0xfe	; 037FEF70
	beq loc_037FEF7E	; 037FEF72
	add r4,#0x28	; 037FEF74
	ldr r0,[r4,#0x0]	; 037FEF76
	sub r0,r0,#0x1	; 037FEF78
	str r0,[r4,#0x0]	; 037FEF7A
	b loc_037FEFBA	; 037FEF7C
loc_037FEF7E:
	add r0,r4,#0x0	; 037FEF7E
	bl loc_037FEC28	; 037FEF80
	lsl r0,r0,#0xf	; 037FEF84
	lsr r4,r0,#0x10	; 037FEF86
	mov r6,#0x1	; 037FEF88
	str r6,[sp,#0x8]	; 037FEF8A
	b loc_037FEFB6	; 037FEF8C
loc_037FEF8E:
	add r1,r4,#0x0	; 037FEF8E
	ldr r0,[sp,#0x8]	; 037FEF90
	and r1,r0	; 037FEF92
	cmp r1,#0x0	; 037FEF94
	beq loc_037FEFB0	; 037FEF96
	bl loc_037FDFAC	; 037FEF98
	add r7,r0,#0x0	; 037FEF9C
	cmp r7,#0x0	; 037FEF9E
	blt loc_037FEFBA	; 037FEFA0
	lsl r1,r7,#0x6	; 037FEFA2
	ldr r0,[pool_037FEFE0]	; 037FEFA4
	add r0,r0,r1	; 037FEFA6
	bl loc_037FEAA0	; 037FEFA8
	add r0,r5,r6	; 037FEFAC
	strb r7,[r0,#0x8]	; 037FEFAE
loc_037FEFB0:
	add r6,r6,#0x1	; 037FEFB0
	lsl r0,r4,#0xf	; 037FEFB2
	lsr r4,r0,#0x10	; 037FEFB4
loc_037FEFB6:
	cmp r4,#0x0	; 037FEFB6
	bne loc_037FEF8E	; 037FEFB8
loc_037FEFBA:
	mov r3,#0x1	; 037FEFBA
	strb r3,[r5,#0x0]	; 037FEFBC
	ldr r0,[pool_037FEFE4]	; 037FEFBE
	ldr r0,[r0,#0x0]	; 037FEFC0
	cmp r0,#0x0	; 037FEFC2
	beq loc_037FEFD2	; 037FEFC4
	add r2,r0,#0x4	; 037FEFC6
	ldr r1,[r2,#0x0]	; 037FEFC8
	ldr r0,[sp,#0x0]	; 037FEFCA
	lsl r3,r0	; 037FEFCC
	orr r1,r3	; 037FEFCE
	str r1,[r2,#0x0]	; 037FEFD0
loc_037FEFD2:
	add sp,#0xc	; 037FEFD2
	pop {r4,r5,r6,r7}	; 037FEFD4
	pop {r3}	; 037FEFD6
	bx r3	; 037FEFD8
	.byte 0xC0, 0x46	; 037FEFDC
pool_037FEFDC:
loc_037FEFDC:
	.word P2_BssStart + 0x10B4	; 037FEFDC
pool_037FEFE0:
loc_037FEFE0:
	.word 0x03803FFC	; 037FEFE0
pool_037FEFE4:
loc_037FEFE4:
	.word P2_BssStart + 0xB70	; 037FEFE4
P2_Entry_037FEFE8:
	push {r4,r5,r6,r7,lr}	; 037FEFE8
	sub sp,#0x4	; 037FEFEA
	add r7,r0,#0x0	; 037FEFEC
	mov r6,#0x0	; 037FEFEE
	add r4,r6,#0x0	; 037FEFF0
P2_Entry_037FEFF2:
	add r0,r4,#0x0	; 037FEFF2
	mov r1,#0x24	; 037FEFF4
	mul r0,r1	; 037FEFF6
	ldr r1,[pool_037FF03C]	; 037FEFF8
	add r5,r1,r0	; 037FEFFA
	ldrb r0,[r1,r0]	; 037FEFFC
	cmp r0,#0x0	; 037FEFFE
	beq P2_Entry_037FF024	; 037FF000
	cmp r7,#0x0	; 037FF002
	beq P2_Entry_037FF012	; 037FF004
	ldrb r0,[r5,#0x1]	; 037FF006
	cmp r0,#0x0	; 037FF008
	bne P2_Entry_037FF012	; 037FF00A
	add r0,r5,#0x0	; 037FF00C
	bl P2_Entry_037FE978	; 037FF00E
P2_Entry_037FF012:
	add r0,r5,#0x0	; 037FF012
	bl P2_Entry_037FE7F8	; 037FF014
	ldrb r0,[r5,#0x0]	; 037FF018
	cmp r0,#0x0	; 037FF01A
	beq P2_Entry_037FF024	; 037FF01C
	mov r0,#0x1	; 037FF01E
	lsl r0,r4	; 037FF020
	orr r6,r0	; 037FF022
P2_Entry_037FF024:
	add r4,r4,#0x1	; 037FF024
	cmp r4,#0x10	; 037FF026
	blt P2_Entry_037FEFF2	; 037FF028
	ldr r0,[pool_037FF040]	; 037FF02A
	ldr r0,[r0,#0x0]	; 037FF02C
	cmp r0,#0x0	; 037FF02E
	beq P2_Entry_037FF034	; 037FF030
	str r6,[r0,#0x4]	; 037FF032
P2_Entry_037FF034:
	add sp,#0x4	; 037FF034
	pop {r4,r5,r6,r7}	; 037FF036
	pop {r3}	; 037FF038
	bx r3	; 037FF03A
pool_037FF03C:
	.word P2_BssStart + 0x10B4	; 037FF03C
pool_037FF040:
	.word P2_BssStart + 0xB70	; 037FF040
P2_Entry_037FF044:
	push {r4,r5,lr}	; 037FF044
	sub sp,#0x4	; 037FF046
	mov r5,#0x0	; 037FF048
	ldr r3,[pool_037FF07C]	; 037FF04A
	add r0,r5,#0x0	; 037FF04C
	mov r1,#0x24	; 037FF04E
P2_Entry_037FF050:
	add r2,r5,#0x0	; 037FF050
	mul r2,r1	; 037FF052
	add r4,r3,r2	; 037FF054
	strb r0,[r3,r2]	; 037FF056
	strb r5,[r4,#0x2]	; 037FF058
	add r5,r5,#0x1	; 037FF05A
	cmp r5,#0x10	; 037FF05C
	blt P2_Entry_037FF050	; 037FF05E
	ldr r4,[pool_037FF080]	; 037FF060
	mov r1,#0x1	; 037FF062
P2_Entry_037FF064:
	lsl r3,r0,#0x6	; 037FF064
	ldrb r2,[r4,r3]	; 037FF066
	bic r2,r1	; 037FF068
	strb r2,[r4,r3]	; 037FF06A
	add r0,r0,#0x1	; 037FF06C
	cmp r0,#0x20	; 037FF06E
	blt P2_Entry_037FF064	; 037FF070
	add sp,#0x4	; 037FF072
	pop {r4,r5}	; 037FF074
	pop {r3}	; 037FF076
	bx r3	; 037FF078
	.byte 0xC0, 0x46	; 037FF07A
pool_037FF07C:
	.word P2_BssStart + 0x10B4	; 037FF07C
pool_037FF080:
	.word P2_BssStart + 0x12F4	; 037FF080

; ===== function loc_037FF084 =====
loc_037FF084:
	lsl r1,r1,#0x3	; 037FF084
	add r0,r0,r1	; 037FF086
	ldr r1,[r0,#0x18]	; 037FF088
	cmp r1,#0x0	; 037FF08A
	bne loc_037FF092	; 037FF08C
	mov r0,#0x0	; 037FF08E
	bx lr	; 037FF090
loc_037FF092:
	ldr r0,[r1,#0x38]	; 037FF092
	cmp r2,r0	; 037FF094
	bcc loc_037FF09C	; 037FF096
	mov r0,#0x0	; 037FF098
	bx lr	; 037FF09A
loc_037FF09C:
	lsl r0,r2,#0x2	; 037FF09C
	add r0,r1,r0	; 037FF09E
	ldr r0,[r0,#0x3c]	; 037FF0A0
	add r0,r1,r0	; 037FF0A2
	bx lr	; 037FF0A4
	.byte 0x00, 0x00	; 037FF0A8

; ===== function loc_037FF0A8 =====
P2_Entry_037FF0A8:
	push {r4,r5,r6,r7,lr}	; 037FF0A8
	sub sp,#0x4	; 037FF0AA
	add r5,r0,#0x0	; 037FF0AC
	add r7,r1,#0x0	; 037FF0AE
	str r2,[sp,#0x0]	; 037FF0B0
	add r6,r3,#0x0	; 037FF0B2
	ldr r4,[sp,#0x1c]	; 037FF0B4
	ldrb r1,[r4,#0x0]	; 037FF0B6
	cmp r1,#0x4	; 037FF0B8
	bhi loc_037FF116	; 037FF0BA
	add r2,r1,r1	; 037FF0BC
P2_SwitchIndexPC_037FF0BC:
	add r2,pc	; 037FF0BE
	ldrh r2,[r2,#(P2_SwitchTable_037FF0BC - (P2_SwitchIndexPC_037FF0BC + 4))]	; 037FF0C0
	lsl r2,r2,#0x10	; 037FF0C2
	asr r2,r2,#0x10	; 037FF0C4
P2_SwitchTargetPC_037FF0BC:
	add r2,pc	; 037FF0C6
	bx r2	; 037FF0C8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FF0BC:
	.halfword (loc_037FF116 + 1) - (P2_SwitchTargetPC_037FF0BC + 4)
	.halfword (loc_037FF0D4 + 1) - (P2_SwitchTargetPC_037FF0BC + 4)
	.halfword (loc_037FF104 + 1) - (P2_SwitchTargetPC_037FF0BC + 4)
	.halfword (loc_037FF10E + 1) - (P2_SwitchTargetPC_037FF0BC + 4)
	.halfword (loc_037FF0D4 + 1) - (P2_SwitchTargetPC_037FF0BC + 4)
P2_SwitchTable_037FF0BCEnd:
loc_037FF0D4:
	cmp r1,#0x1	; 037FF0D4
	bne loc_037FF0E6	; 037FF0D6
	ldr r0,[sp,#0x18]	; 037FF0D8
	ldrh r1,[r4,#0x4]	; 037FF0DA
	ldrh r2,[r4,#0x2]	; 037FF0DC
	bl loc_037FF084	; 037FF0DE
	add r2,r0,#0x0	; 037FF0E2
	b loc_037FF0EE	; 037FF0E4
loc_037FF0E6:
	ldrh r0,[r4,#0x4]	; 037FF0E6
	lsl r2,r0,#0x10	; 037FF0E8
	ldrh r0,[r4,#0x2]	; 037FF0EA
	orr r2,r0	; 037FF0EC
loc_037FF0EE:
	cmp r2,#0x0	; 037FF0EE
	beq loc_037FF100	; 037FF0F0
	add r0,r5,#0x0	; 037FF0F2
	add r1,r2,#0x0	; 037FF0F4
	add r2,#0xc	; 037FF0F6
	add r3,r6,#0x0	; 037FF0F8
	bl loc_037FDC14	; 037FF0FA
	b loc_037FF118	; 037FF0FE
loc_037FF100:
	mov r0,#0x0	; 037FF100
	b loc_037FF118	; 037FF102
loc_037FF104:
	ldrh r1,[r4,#0x2]	; 037FF104
	add r2,r6,#0x0	; 037FF106
	bl loc_037FDBE0	; 037FF108
	b loc_037FF118	; 037FF10C
loc_037FF10E:
	add r1,r6,#0x0	; 037FF10E
	bl loc_037FDBB0	; 037FF110
	b loc_037FF118	; 037FF114
loc_037FF116:
	mov r0,#0x0	; 037FF116
loc_037FF118:
	cmp r0,#0x0	; 037FF118
	bne loc_037FF120	; 037FF11A
	mov r0,#0x0	; 037FF11C
	b loc_037FF152	; 037FF11E
loc_037FF120:
	strb r7,[r5,#0x8]	; 037FF120
	ldrb r0,[r4,#0x6]	; 037FF122
	strb r0,[r5,#0x5]	; 037FF124
	ldr r0,[sp,#0x0]	; 037FF126
	strb r0,[r5,#0x9]	; 037FF128
	add r0,r5,#0x0	; 037FF12A
	ldrb r1,[r4,#0x7]	; 037FF12C
	bl loc_037FDB94	; 037FF12E
	add r0,r5,#0x0	; 037FF132
	ldrb r1,[r4,#0x8]	; 037FF134
	bl loc_037FDB80	; 037FF136
	add r0,r5,#0x0	; 037FF13A
	ldrb r1,[r4,#0x9]	; 037FF13C
	bl loc_037FDB7C	; 037FF13E
	add r0,r5,#0x0	; 037FF142
	ldrb r1,[r4,#0xa]	; 037FF144
	bl loc_037FDB68	; 037FF146
	ldrb r0,[r4,#0xb]	; 037FF14A
	sub r0,#0x40	; 037FF14C
	strb r0,[r5,#0xa]	; 037FF14E
	mov r0,#0x1	; 037FF150
loc_037FF152:
	add sp,#0x4	; 037FF152
	pop {r4,r5,r6,r7}	; 037FF154
	pop {r3}	; 037FF156
	bx r3	; 037FF158
	.byte 0x00, 0x00	; 037FF15A
P2_Entry_037FF15C:
	push {r4,r5,lr}	; 037FF15C
	sub sp,#0x4	; 037FF15E
	add r4,r0,#0x0	; 037FF160
	add r0,r3,#0x0	; 037FF162
	cmp r1,#0x0	; 037FF164
	bge P2_Entry_037FF16C	; 037FF166
	mov r0,#0x0	; 037FF168
	b P2_Entry_037FF22E	; 037FF16A
P2_Entry_037FF16C:
	ldr r3,[r4,#0x38]	; 037FF16C
	cmp r1,r3	; 037FF16E
	bcc P2_Entry_037FF176	; 037FF170
	mov r0,#0x0	; 037FF172
	b P2_Entry_037FF22E	; 037FF174
P2_Entry_037FF176:
	lsl r1,r1,#0x2	; 037FF176
	add r1,r4,r1	; 037FF178
	ldr r3,[r1,#0x3c]	; 037FF17A
	strb r3,[r0,#0x0]	; 037FF17C
	ldrb r1,[r0,#0x0]	; 037FF17E
	cmp r1,#0x10	; 037FF180
	bgt P2_Entry_037FF1A4	; 037FF182
	cmp r1,#0x10	; 037FF184
	bge P2_Entry_037FF1C2	; 037FF186
	cmp r1,#0x4	; 037FF188
	bhi P2_Entry_037FF228	; 037FF18A
	add r5,r1,r1	; 037FF18C
P2_SwitchIndexPC_037FF18C:
	add r5,pc	; 037FF18E
	ldrh r5,[r5,#(P2_SwitchTable_037FF18C - (P2_SwitchIndexPC_037FF18C + 4))]	; 037FF190
	lsl r5,r5,#0x10	; 037FF192
	asr r5,r5,#0x10	; 037FF194
P2_SwitchTargetPC_037FF18C:
	add r5,pc	; 037FF196
	bx r5	; 037FF198
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FF18C:
	.halfword (P2_Entry_037FF228 + 1) - (P2_SwitchTargetPC_037FF18C + 4)
	.halfword (P2_Case_037FF1AA + 1) - (P2_SwitchTargetPC_037FF18C + 4)
	.halfword (P2_Case_037FF1AA + 1) - (P2_SwitchTargetPC_037FF18C + 4)
	.halfword (P2_Case_037FF1AA + 1) - (P2_SwitchTargetPC_037FF18C + 4)
	.halfword (P2_Case_037FF1AA + 1) - (P2_SwitchTargetPC_037FF18C + 4)
P2_SwitchTable_037FF18CEnd:
P2_Entry_037FF1A4:
	cmp r1,#0x11	; 037FF1A4
	beq P2_Entry_037FF1F6	; 037FF1A6
	b P2_Entry_037FF228	; 037FF1A8
P2_Case_037FF1AA:
	lsr r1,r3,#0x8	; 037FF1AA
	add r3,r4,r1	; 037FF1AC
	add r2,r0,#0x2	; 037FF1AE
	mov r1,#0x5	; 037FF1B0
P2_Entry_037FF1B2:
	ldrh r0,[r3,#0x0]	; 037FF1B2
	add r3,r3,#0x2	; 037FF1B4
	strh r0,[r2,#0x0]	; 037FF1B6
	add r2,r2,#0x2	; 037FF1B8
	sub r1,r1,#0x1	; 037FF1BA
	cmp r1,#0x0	; 037FF1BC
	bne P2_Entry_037FF1B2	; 037FF1BE
	b P2_Entry_037FF22C	; 037FF1C0
P2_Entry_037FF1C2:
	lsr r3,r3,#0x8	; 037FF1C2
	add r1,r4,r3	; 037FF1C4
	ldrb r5,[r1,#0x1]	; 037FF1C6
	ldrb r3,[r4,r3]	; 037FF1C8
	cmp r2,r3	; 037FF1CA
	bge P2_Entry_037FF1D2	; 037FF1CC
	mov r0,#0x0	; 037FF1CE
	b P2_Entry_037FF22E	; 037FF1D0
P2_Entry_037FF1D2:
	cmp r2,r5	; 037FF1D2
	ble P2_Entry_037FF1DA	; 037FF1D4
	mov r0,#0x0	; 037FF1D6
	b P2_Entry_037FF22E	; 037FF1D8
P2_Entry_037FF1DA:
	sub r3,r2,r3	; 037FF1DA
	mov r2,#0xc	; 037FF1DC
	mul r3,r2	; 037FF1DE
	add r1,r1,r3	; 037FF1E0
	add r3,r1,#0x2	; 037FF1E2
	mov r2,#0x6	; 037FF1E4
P2_Entry_037FF1E6:
	ldrh r1,[r3,#0x0]	; 037FF1E6
	add r3,r3,#0x2	; 037FF1E8
	strh r1,[r0,#0x0]	; 037FF1EA
	add r0,r0,#0x2	; 037FF1EC
	sub r2,r2,#0x1	; 037FF1EE
	cmp r2,#0x0	; 037FF1F0
	bne P2_Entry_037FF1E6	; 037FF1F2
	b P2_Entry_037FF22C	; 037FF1F4
P2_Entry_037FF1F6:
	mov r1,#0x0	; 037FF1F6
	lsr r3,r3,#0x8	; 037FF1F8
	add r4,r4,r3	; 037FF1FA
	b P2_Entry_037FF208	; 037FF1FC
P2_Entry_037FF1FE:
	add r1,r1,#0x1	; 037FF1FE
	cmp r1,#0x8	; 037FF200
	blt P2_Entry_037FF208	; 037FF202
	mov r0,#0x0	; 037FF204
	b P2_Entry_037FF22E	; 037FF206
P2_Entry_037FF208:
	ldrb r3,[r4,r1]	; 037FF208
	cmp r2,r3	; 037FF20A
	bgt P2_Entry_037FF1FE	; 037FF20C
	mov r2,#0xc	; 037FF20E
	mul r1,r2	; 037FF210
	add r3,r4,r1	; 037FF212
	add r3,#0x8	; 037FF214
	mov r2,#0x6	; 037FF216
P2_Entry_037FF218:
	ldrh r1,[r3,#0x0]	; 037FF218
	add r3,r3,#0x2	; 037FF21A
	strh r1,[r0,#0x0]	; 037FF21C
	add r0,r0,#0x2	; 037FF21E
	sub r2,r2,#0x1	; 037FF220
	cmp r2,#0x0	; 037FF222
	bne P2_Entry_037FF218	; 037FF224
	b P2_Entry_037FF22C	; 037FF226
P2_Entry_037FF228:
	mov r0,#0x0	; 037FF228
	b P2_Entry_037FF22E	; 037FF22A
P2_Entry_037FF22C:
	mov r0,#0x1	; 037FF22C
P2_Entry_037FF22E:
	add sp,#0x4	; 037FF22E
	pop {r4,r5}	; 037FF230
	pop {r3}	; 037FF232
	bx r3	; 037FF234
	.byte 0x00, 0x00	; 037FF236

; ===== function loc_037FF238 =====
loc_037FF238:
	push {r4,r5,r6,r7,lr}	; 037FF238
	sub sp,#0x4	; 037FF23A
	mov r5,#0x0	; 037FF23C
	add r4,r5,#0x0	; 037FF23E
	ldr r0,[pool_037FF29C]	; 037FF240
	ldr r0,[r0,#0x0]	; 037FF242
	cmp r0,#0x0	; 037FF244
	beq loc_037FF294	; 037FF246
	add r6,r5,#0x0	; 037FF248
	mov r7,#0x1	; 037FF24A
loc_037FF24C:
	add r0,r6,#0x0	; 037FF24C
	bl loc_037FD044	; 037FF24E
	cmp r0,#0x0	; 037FF252
	beq loc_037FF260	; 037FF254
	add r0,r7,#0x0	; 037FF256
	lsl r0,r6	; 037FF258
	orr r5,r0	; 037FF25A
	lsl r0,r5,#0x10	; 037FF25C
	lsr r5,r0,#0x10	; 037FF25E
loc_037FF260:
	add r6,r6,#0x1	; 037FF260
	cmp r6,#0x10	; 037FF262
	blt loc_037FF24C	; 037FF264
	mov r0,#0x0	; 037FF266
	bl loc_037FD598	; 037FF268
	cmp r0,#0x0	; 037FF26C
	beq loc_037FF278	; 037FF26E
	mov r0,#0x1	; 037FF270
	orr r4,r0	; 037FF272
	lsl r0,r4,#0x10	; 037FF274
	lsr r4,r0,#0x10	; 037FF276
loc_037FF278:
	mov r0,#0x1	; 037FF278
	bl loc_037FD598	; 037FF27A
	cmp r0,#0x0	; 037FF27E
	beq loc_037FF28A	; 037FF280
	mov r0,#0x2	; 037FF282
	orr r4,r0	; 037FF284
	lsl r0,r4,#0x10	; 037FF286
	lsr r4,r0,#0x10	; 037FF288
loc_037FF28A:
	ldr r0,[pool_037FF29C]	; 037FF28A
	ldr r1,[r0,#0x0]	; 037FF28C
	strh r5,[r1,#0x8]	; 037FF28E
	ldr r0,[r0,#0x0]	; 037FF290
	strh r4,[r0,#0xa]	; 037FF292
loc_037FF294:
	add sp,#0x4	; 037FF294
	pop {r4,r5,r6,r7}	; 037FF296
	pop {r3}	; 037FF298
	bx r3	; 037FF29A
pool_037FF29C:
loc_037FF29C:
	.word P2_BssStart + 0xB70	; 037FF29C

; ===== function loc_037FF2A0 =====
loc_037FF2A0:
	ldr r2,[pool_037FF2B0]	; 037FF2A0
	ldr r2,[r2,#0x0]	; 037FF2A2
	lsl r0,r0,#0x1	; 037FF2A4
	add r2,r2,r0	; 037FF2A6
	ldr r0,[pool_037FF2B4]	; 037FF2A8
	strh r1,[r2,r0]	; 037FF2AA
	bx lr	; 037FF2AC
	.byte 0xC0, 0x46	; 037FF2B0
pool_037FF2B0:
loc_037FF2B0:
	.word P2_BssStart + 0xB70	; 037FF2B0
pool_037FF2B4:
loc_037FF2B4:
	.word 0x00000260	; 037FF2B4

; ===== function loc_037FF2B8 =====
loc_037FF2B8:
	push {r4,lr}	; 037FF2B8
	ldr r3,[pool_037FF2D0]	; 037FF2BA
	ldr r4,[r3,#0x0]	; 037FF2BC
	mov r3,#0x24	; 037FF2BE
	mul r0,r3	; 037FF2C0
	add r3,r4,r0	; 037FF2C2
	lsl r0,r1,#0x1	; 037FF2C4
	add r0,r3,r0	; 037FF2C6
	strh r2,[r0,#0x20]	; 037FF2C8
	pop {r4}	; 037FF2CA
	pop {r3}	; 037FF2CC
	bx r3	; 037FF2CE
pool_037FF2D0:
loc_037FF2D0:
	.word P2_BssStart + 0xB70	; 037FF2D0

; ===== function loc_037FF2D4 =====
P2_Code_037FF2D4:
	push {r4,r5,r6,lr}	; 037FF2D4
	add r5,r0,#0x0	; 037FF2D6
	mov r4,#0x7	; 037FF2D8
	mov r6,#0x0	; 037FF2DA
loc_037FF2DC:
	add r0,r4,#0x0	; 037FF2DC
	add r1,r5,#0x0	; 037FF2DE
	add r2,r6,#0x0	; 037FF2E0
	bl loc_037FFA18	; 037FF2E2
	cmp r0,#0x0	; 037FF2E6
	blt loc_037FF2DC	; 037FF2E8
	pop {r4,r5,r6}	; 037FF2EA
	pop {r3}	; 037FF2EC
	bx r3	; 037FF2EE

; ===== function loc_037FF2F0 =====
loc_037FF2F0:
	push {r4,lr}	; 037FF2F0
	ldr r1,[pool_037FF318]	; 037FF2F2
	lsl r0,r0,#0x6	; 037FF2F4
	add r4,r1,r0	; 037FF2F6
	ldrb r0,[r1,r0]	; 037FF2F8
	cmp r0,#0x0	; 037FF2FA
	beq loc_037FF312	; 037FF2FC
	add r0,r4,#0x0	; 037FF2FE
	add r0,#0x14	; 037FF300
	bl loc_037FC5A0	; 037FF302
	add r1,r4,#0x1	; 037FF306
	ldrb r0,[r1,#0x0]	; 037FF308
	add r0,r0,#0x1	; 037FF30A
	strb r0,[r1,#0x0]	; 037FF30C
	mov r0,#0x0	; 037FF30E
	strb r0,[r4,#0x0]	; 037FF310
loc_037FF312:
	pop {r4}	; 037FF312
	pop {r3}	; 037FF314
	bx r3	; 037FF316
pool_037FF318:
loc_037FF318:
	.word P2_BssStart + 0x1AF4	; 037FF318

; ===== function loc_037FF31C =====
loc_037FF31C:
	push {r4,r5,r6,r7,lr}	; 037FF31C
	sub sp,#0x1c	; 037FF31E
	str r0,[sp,#0xc]	; 037FF320
	ldr r1,[pool_037FF3A8]	; 037FF322
	lsl r0,r0,#0x6	; 037FF324
	add r5,r1,r0	; 037FF326
	ldrb r0,[r1,r0]	; 037FF328
	cmp r0,#0x0	; 037FF32A
	beq loc_037FF33A	; 037FF32C
	add r0,r5,#0x0	; 037FF32E
	add r0,#0x14	; 037FF330
	bl loc_037FC5A0	; 037FF332
	mov r0,#0x0	; 037FF336
	strb r0,[r5,#0x0]	; 037FF338
loc_037FF33A:
	ldr r6,[r5,#0x4]	; 037FF33A
	ldr r7,[r5,#0x8]	; 037FF33C
	ldr r0,[r5,#0xc]	; 037FF33E
	str r0,[sp,#0x10]	; 037FF340
	ldr r0,[r5,#0x10]	; 037FF342
	str r0,[sp,#0x14]	; 037FF344
	ldrb r0,[r5,#0x1]	; 037FF346
	lsl r4,r0,#0x8	; 037FF348
	ldr r0,[sp,#0xc]	; 037FF34A
	orr r4,r0	; 037FF34C
	add r0,r5,#0x0	; 037FF34E
	add r0,#0x14	; 037FF350
	bl loc_037FC778	; 037FF352
	mov r2,#0x0	; 037FF356
	ldr r1,[sp,#0x14]	; 037FF358
	eor r1,r2	; 037FF35A
	ldr r0,[sp,#0x10]	; 037FF35C
	eor r0,r2	; 037FF35E
	orr r1,r0	; 037FF360
	bne loc_037FF376	; 037FF362
	str r4,[sp,#0x0]	; 037FF364
	add r0,r5,#0x0	; 037FF366
	add r0,#0x14	; 037FF368
	add r1,r6,#0x0	; 037FF36A
	add r2,r7,#0x0	; 037FF36C
	ldr r3,[pool_037FF3AC]	; 037FF36E
	bl loc_037FC64C	; 037FF370
	b loc_037FF39A	; 037FF374
loc_037FF376:
	bl loc_037FC3AC	; 037FF376
	str r0,[sp,#0x18]	; 037FF37A
	add r2,r1,#0x0	; 037FF37C
	ldr r0,[pool_037FF3AC]	; 037FF37E
	str r0,[sp,#0x4]	; 037FF380
	str r4,[sp,#0x8]	; 037FF382
	ldr r3,[sp,#0x10]	; 037FF384
	ldr r0,[sp,#0x14]	; 037FF386
	str r0,[sp,#0x0]	; 037FF388
	add r0,r5,#0x0	; 037FF38A
	add r0,#0x14	; 037FF38C
	ldr r1,[sp,#0x18]	; 037FF38E
	add r1,r6,r1	; 037FF390
	adc r7,r2	; 037FF392
	add r2,r7,#0x0	; 037FF394
	bl loc_037FC5FC	; 037FF396
loc_037FF39A:
	mov r0,#0x1	; 037FF39A
	strb r0,[r5,#0x0]	; 037FF39C
	add sp,#0x1c	; 037FF39E
	pop {r4,r5,r6,r7}	; 037FF3A0
	pop {r3}	; 037FF3A2
	bx r3	; 037FF3A4
	.byte 0xC0, 0x46	; 037FF3A8
pool_037FF3A8:
loc_037FF3A8:
	.word P2_BssStart + 0x1AF4	; 037FF3A8
pool_037FF3AC:
loc_037FF3AC:
	.word P2_Code_037FF2D4 + 1	; 037FF3AC

; ===== function loc_037FF3B0 =====
loc_037FF3B0:
	push {r4,r5,r6,lr}	; 037FF3B0
	sub sp,#0x8	; 037FF3B2
	add r5,r1,#0x0	; 037FF3B4
	add r6,r2,#0x0	; 037FF3B6
	str r3,[sp,#0x0]	; 037FF3B8
	ldr r1,[sp,#0x18]	; 037FF3BA
	str r1,[sp,#0x4]	; 037FF3BC
	ldr r1,[pool_037FF3F0]	; 037FF3BE
	lsl r0,r0,#0x6	; 037FF3C0
	add r4,r1,r0	; 037FF3C2
	ldrb r0,[r1,r0]	; 037FF3C4
	cmp r0,#0x0	; 037FF3C6
	beq loc_037FF3D6	; 037FF3C8
	add r0,r4,#0x0	; 037FF3CA
	add r0,#0x14	; 037FF3CC
	bl loc_037FC5A0	; 037FF3CE
	mov r0,#0x0	; 037FF3D2
	strb r0,[r4,#0x0]	; 037FF3D4
loc_037FF3D6:
	str r5,[r4,#0x4]	; 037FF3D6
	str r6,[r4,#0x8]	; 037FF3D8
	ldr r0,[sp,#0x0]	; 037FF3DA
	str r0,[r4,#0xc]	; 037FF3DC
	ldr r0,[sp,#0x4]	; 037FF3DE
	str r0,[r4,#0x10]	; 037FF3E0
	ldr r0,[sp,#0x1c]	; 037FF3E2
	strb r0,[r4,#0x1]	; 037FF3E4
	add sp,#0x8	; 037FF3E6
	pop {r4,r5,r6}	; 037FF3E8
	pop {r3}	; 037FF3EA
	bx r3	; 037FF3EC
	.byte 0xC0, 0x46	; 037FF3F0
pool_037FF3F0:
loc_037FF3F0:
	.word P2_BssStart + 0x1AF4	; 037FF3F0
P2_Entry_037FF3F4:
	push {r4,r5,lr}	; 037FF3F4
	sub sp,#0x4	; 037FF3F6
	mov r5,#0x0	; 037FF3F8
	ldr r4,[pool_037FF418]	; 037FF3FA
	add r2,r5,#0x0	; 037FF3FC
	ldr r0,[pool_037FF41C]	; 037FF3FE
	ldr r1,[pool_037FF420]	; 037FF400
P2_Entry_037FF402:
	lsl r3,r5,#0x6	; 037FF402
	add r3,r4,r3	; 037FF404
	strb r2,[r3,r0]	; 037FF406
	strb r2,[r3,r1]	; 037FF408
	add r5,r5,#0x1	; 037FF40A
	cmp r5,#0x8	; 037FF40C
	blt P2_Entry_037FF402	; 037FF40E
	add sp,#0x4	; 037FF410
	pop {r4,r5}	; 037FF412
	pop {r3}	; 037FF414
	bx r3	; 037FF416
pool_037FF418:
	.word 0x0380387C	; 037FF418
pool_037FF41C:
	.word 0x00000F80	; 037FF41C
pool_037FF420:
	.word 0x00000F81	; 037FF420

; ===== function loc_037FF424 =====
loc_037FF424:
	push {r4,r5,r6,r7,lr}	; 037FF424
	sub sp,#0xc	; 037FF426
	add r5,r0,#0x0	; 037FF428
	add r7,r1,#0x0	; 037FF42A
	add r6,r2,#0x0	; 037FF42C
	str r3,[sp,#0x0]	; 037FF42E
	bl loc_037FB7EC	; 037FF430
	str r0,[sp,#0x4]	; 037FF434
	mov r4,#0x0	; 037FF436
	b loc_037FF44E	; 037FF438
loc_037FF43A:
	add r1,r6,#0x0	; 037FF43A
	mov r0,#0x1	; 037FF43C
	and r1,r0	; 037FF43E
	cmp r1,#0x0	; 037FF440
	beq loc_037FF44A	; 037FF442
	add r0,r4,#0x0	; 037FF444
	bl loc_037FF2F0	; 037FF446
loc_037FF44A:
	add r4,r4,#0x1	; 037FF44A
	lsr r6,r6,#0x1	; 037FF44C
loc_037FF44E:
	cmp r4,#0x8	; 037FF44E
	bge loc_037FF456	; 037FF450
	cmp r6,#0x0	; 037FF452
	bne loc_037FF43A	; 037FF454
loc_037FF456:
	mov r4,#0x0	; 037FF456
	mov r6,#0x1	; 037FF458
	b loc_037FF470	; 037FF45A
loc_037FF45C:
	add r0,r5,#0x0	; 037FF45C
	and r0,r6	; 037FF45E
	cmp r0,#0x0	; 037FF460
	beq loc_037FF46C	; 037FF462
	add r0,r4,#0x0	; 037FF464
	ldr r1,[sp,#0x0]	; 037FF466
	bl loc_037FD110	; 037FF468
loc_037FF46C:
	add r4,r4,#0x1	; 037FF46C
	lsr r5,r5,#0x1	; 037FF46E
loc_037FF470:
	cmp r4,#0x10	; 037FF470
	bge loc_037FF478	; 037FF472
	cmp r5,#0x0	; 037FF474
	bne loc_037FF45C	; 037FF476
loc_037FF478:
	mov r0,#0x1	; 037FF478
	add r1,r7,#0x0	; 037FF47A
	and r1,r0	; 037FF47C
	cmp r1,#0x0	; 037FF47E
	beq loc_037FF488	; 037FF480
	mov r1,#0x0	; 037FF482
	ldr r0,[pool_037FF4A8]	; 037FF484
	strb r1,[r0,#0x0]	; 037FF486
loc_037FF488:
	mov r0,#0x2	; 037FF488
	and r7,r0	; 037FF48A
	cmp r7,#0x0	; 037FF48C
	beq loc_037FF496	; 037FF48E
	mov r1,#0x0	; 037FF490
	ldr r0,[pool_037FF4AC]	; 037FF492
	strb r1,[r0,#0x0]	; 037FF494
loc_037FF496:
	ldr r0,[sp,#0x4]	; 037FF496
	bl loc_037FB810	; 037FF498
	bl loc_037FF238	; 037FF49C
	add sp,#0xc	; 037FF4A0
	pop {r4,r5,r6,r7}	; 037FF4A2
	pop {r3}	; 037FF4A4
	bx r3	; 037FF4A6
pool_037FF4A8:
loc_037FF4A8:
	.word REG_SNDCAP0CNT	; 037FF4A8
pool_037FF4AC:
loc_037FF4AC:
	.word REG_SNDCAP1CNT	; 037FF4AC

; ===== function loc_037FF4B0 =====
loc_037FF4B0:
	push {r4,r5,r6,r7,lr}	; 037FF4B0
	sub sp,#0x4	; 037FF4B2
	add r5,r0,#0x0	; 037FF4B4
	add r4,r1,#0x0	; 037FF4B6
	add r6,r2,#0x0	; 037FF4B8
	bl loc_037FB7EC	; 037FF4BA
	add r7,r0,#0x0	; 037FF4BE
	mov r3,#0x0	; 037FF4C0
	b loc_037FF4E0	; 037FF4C2
loc_037FF4C4:
	add r1,r5,#0x0	; 037FF4C4
	mov r0,#0x1	; 037FF4C6
	and r1,r0	; 037FF4C8
	cmp r1,#0x0	; 037FF4CA
	beq loc_037FF4DC	; 037FF4CC
	lsl r1,r3,#0x4	; 037FF4CE
	ldr r0,[pool_037FF558]	; 037FF4D0
	add r2,r1,r0	; 037FF4D2
	ldrb r1,[r2,#0x0]	; 037FF4D4
	mov r0,#0x80	; 037FF4D6
	orr r1,r0	; 037FF4D8
	strb r1,[r2,#0x0]	; 037FF4DA
loc_037FF4DC:
	add r3,r3,#0x1	; 037FF4DC
	lsr r5,r5,#0x1	; 037FF4DE
loc_037FF4E0:
	cmp r3,#0x10	; 037FF4E0
	bge loc_037FF4E8	; 037FF4E2
	cmp r5,#0x0	; 037FF4E4
	bne loc_037FF4C4	; 037FF4E6
loc_037FF4E8:
	mov r0,#0x1	; 037FF4E8
	add r1,r4,#0x0	; 037FF4EA
	and r1,r0	; 037FF4EC
	cmp r1,#0x0	; 037FF4EE
	beq loc_037FF512	; 037FF4F0
	mov r0,#0x2	; 037FF4F2
	and r4,r0	; 037FF4F4
	cmp r4,#0x0	; 037FF4F6
	beq loc_037FF506	; 037FF4F8
	ldr r2,[pool_037FF55C]	; 037FF4FA
	ldrh r1,[r2,#0x0]	; 037FF4FC
	ldr r0,[pool_037FF560]	; 037FF4FE
	orr r1,r0	; 037FF500
	strh r1,[r2,#0x0]	; 037FF502
	b loc_037FF524	; 037FF504
loc_037FF506:
	ldr r2,[pool_037FF55C]	; 037FF506
	ldrb r1,[r2,#0x0]	; 037FF508
	mov r0,#0x80	; 037FF50A
	orr r1,r0	; 037FF50C
	strb r1,[r2,#0x0]	; 037FF50E
	b loc_037FF524	; 037FF510
loc_037FF512:
	mov r0,#0x2	; 037FF512
	and r4,r0	; 037FF514
	cmp r4,#0x0	; 037FF516
	beq loc_037FF524	; 037FF518
	ldr r2,[pool_037FF564]	; 037FF51A
	ldrb r1,[r2,#0x0]	; 037FF51C
	mov r0,#0x80	; 037FF51E
	orr r1,r0	; 037FF520
	strb r1,[r2,#0x0]	; 037FF522
loc_037FF524:
	mov r4,#0x0	; 037FF524
	mov r5,#0x1	; 037FF526
	b loc_037FF53C	; 037FF528
loc_037FF52A:
	add r0,r6,#0x0	; 037FF52A
	and r0,r5	; 037FF52C
	cmp r0,#0x0	; 037FF52E
	beq loc_037FF538	; 037FF530
	add r0,r4,#0x0	; 037FF532
	bl loc_037FF31C	; 037FF534
loc_037FF538:
	add r4,r4,#0x1	; 037FF538
	lsr r6,r6,#0x1	; 037FF53A
loc_037FF53C:
	cmp r4,#0x8	; 037FF53C
	bge loc_037FF544	; 037FF53E
	cmp r6,#0x0	; 037FF540
	bne loc_037FF52A	; 037FF542
loc_037FF544:
	add r0,r7,#0x0	; 037FF544
	bl loc_037FB810	; 037FF546
	bl loc_037FF238	; 037FF54A
	add sp,#0x4	; 037FF54E
	pop {r4,r5,r6,r7}	; 037FF550
	pop {r3}	; 037FF552
	bx r3	; 037FF554
	.byte 0xC0, 0x46	; 037FF558
pool_037FF558:
loc_037FF558:
	.word SCHANNEL0_CR + 3	; 037FF558
pool_037FF55C:
loc_037FF55C:
	.word REG_SNDCAP0CNT	; 037FF55C
pool_037FF560:
loc_037FF560:
	.word 0x00008080	; 037FF560
pool_037FF564:
loc_037FF564:
	.word REG_SNDCAP1CNT	; 037FF564

; ===== function loc_037FF568 =====
loc_037FF568:
	push {r4,r5,r6,r7,lr}	; 037FF568
	sub sp,#0x4	; 037FF56A
	add r5,r0,#0x0	; 037FF56C
	add r6,r1,#0x0	; 037FF56E
	mov r4,#0x0	; 037FF570
	mov r7,#0x1	; 037FF572
	b loc_037FF58A	; 037FF574
loc_037FF576:
	add r0,r5,#0x0	; 037FF576
	and r0,r7	; 037FF578
	cmp r0,#0x0	; 037FF57A
	beq loc_037FF586	; 037FF57C
	add r0,r4,#0x0	; 037FF57E
	add r1,r6,#0x0	; 037FF580
	bl loc_037FD060	; 037FF582
loc_037FF586:
	add r4,r4,#0x1	; 037FF586
	lsr r5,r5,#0x1	; 037FF588
loc_037FF58A:
	cmp r4,#0x10	; 037FF58A
	bge loc_037FF592	; 037FF58C
	cmp r5,#0x0	; 037FF58E
	bne loc_037FF576	; 037FF590
loc_037FF592:
	add sp,#0x4	; 037FF592
	pop {r4,r5,r6,r7}	; 037FF594
	pop {r3}	; 037FF596
	bx r3	; 037FF598
	.byte 0x00, 0x00	; 037FF59C

; ===== function loc_037FF59C =====
loc_037FF59C:
	push {r4,r5,r6,r7,lr}	; 037FF59C
	sub sp,#0x4	; 037FF59E
	add r5,r0,#0x0	; 037FF5A0
	add r6,r1,#0x0	; 037FF5A2
	add r7,r2,#0x0	; 037FF5A4
	mov r4,#0x0	; 037FF5A6
	b loc_037FF5C2	; 037FF5A8
loc_037FF5AA:
	add r1,r5,#0x0	; 037FF5AA
	mov r0,#0x1	; 037FF5AC
	and r1,r0	; 037FF5AE
	cmp r1,#0x0	; 037FF5B0
	beq loc_037FF5BE	; 037FF5B2
	add r0,r4,#0x0	; 037FF5B4
	add r1,r6,#0x0	; 037FF5B6
	add r2,r7,#0x0	; 037FF5B8
	bl loc_037FD0B8	; 037FF5BA
loc_037FF5BE:
	add r4,r4,#0x1	; 037FF5BE
	lsr r5,r5,#0x1	; 037FF5C0
loc_037FF5C2:
	cmp r4,#0x10	; 037FF5C2
	bge loc_037FF5CA	; 037FF5C4
	cmp r5,#0x0	; 037FF5C6
	bne loc_037FF5AA	; 037FF5C8
loc_037FF5CA:
	add sp,#0x4	; 037FF5CA
	pop {r4,r5,r6,r7}	; 037FF5CC
	pop {r3}	; 037FF5CE
	bx r3	; 037FF5D0
	.byte 0x00, 0x00	; 037FF5D4

; ===== function loc_037FF5D4 =====
loc_037FF5D4:
	push {r4,r5,r6,r7,lr}	; 037FF5D4
	sub sp,#0x4	; 037FF5D6
	add r5,r0,#0x0	; 037FF5D8
	add r6,r1,#0x0	; 037FF5DA
	mov r4,#0x0	; 037FF5DC
	mov r7,#0x1	; 037FF5DE
	b loc_037FF5F6	; 037FF5E0
loc_037FF5E2:
	add r0,r5,#0x0	; 037FF5E2
	and r0,r7	; 037FF5E4
	cmp r0,#0x0	; 037FF5E6
	beq loc_037FF5F2	; 037FF5E8
	add r0,r4,#0x0	; 037FF5EA
	add r1,r6,#0x0	; 037FF5EC
	bl loc_037FD0A4	; 037FF5EE
loc_037FF5F2:
	add r4,r4,#0x1	; 037FF5F2
	lsr r5,r5,#0x1	; 037FF5F4
loc_037FF5F6:
	cmp r4,#0x10	; 037FF5F6
	bge loc_037FF5FE	; 037FF5F8
	cmp r5,#0x0	; 037FF5FA
	bne loc_037FF5E2	; 037FF5FC
loc_037FF5FE:
	add sp,#0x4	; 037FF5FE
	pop {r4,r5,r6,r7}	; 037FF600
	pop {r3}	; 037FF602
	bx r3	; 037FF604
	.byte 0x00, 0x00	; 037FF608

; ===== function loc_037FF608 =====
loc_037FF608:
	mov r0,#0x7	; 037FF608
	ldr r1,[pool_037FF610]	; 037FF60A
	ldr r3,[pool_037FF614]	; 037FF60C
	bx r3	; 037FF60E
pool_037FF610:
loc_037FF610:
	.word P2_Code_037FF618 + 1	; 037FF610
pool_037FF614:
loc_037FF614:
	.word P2_SetPxiReceiveCallback + 1	; 037FF614

; ===== function loc_037FF618 =====
P2_Code_037FF618:
	push {r4,r5,lr}	; 037FF618
	sub sp,#0x4	; 037FF61A
	add r5,r1,#0x0	; 037FF61C
	bl loc_037FB7EC	; 037FF61E
	add r4,r0,#0x0	; 037FF622
	ldr r0,[pool_037FF64C]	; 037FF624
	cmp r5,r0	; 037FF626
	bcc loc_037FF636	; 037FF628
	ldr r0,[pool_037FF650]	; 037FF62A
	add r1,r5,#0x0	; 037FF62C
	mov r2,#0x0	; 037FF62E
	bl loc_037FBE10	; 037FF630
	b loc_037FF63E	; 037FF634
loc_037FF636:
	cmp r5,#0x0	; 037FF636
	bne loc_037FF63E	; 037FF638
	bl loc_037FD4B8	; 037FF63A
loc_037FF63E:
	add r0,r4,#0x0	; 037FF63E
	bl loc_037FB810	; 037FF640
	add sp,#0x4	; 037FF644
	pop {r4,r5}	; 037FF646
	pop {r3}	; 037FF648
	bx r3	; 037FF64A
pool_037FF64C:
loc_037FF64C:
	.word 0x02000000	; 037FF64C
pool_037FF650:
loc_037FF650:
	.word 0x038049FC	; 037FF650

; ===== function loc_037FF654 =====
P2_Entry_037FF654:
	push {r4,r5,r6,r7,lr}	; 037FF654
	sub sp,#0x34	; 037FF656
	mov r4,#0x7f	; 037FF658
	mov r7,#0x3	; 037FF65A
	mov r6,#0x1	; 037FF65C
	b loc_037FF8C8	; 037FF65E
loc_037FF660:
	ldr r5,[sp,#0x18]	; 037FF660
	b loc_037FF8B8	; 037FF662
loc_037FF664:
	add r3,sp,#0x1c	; 037FF664
	mov r2,#0x3	; 037FF666
loc_037FF668:
	ldmia r5!,{r0,r1}	; 037FF668
	stmia r3!,{r0,r1}	; 037FF66A
	sub r2,r2,#0x1	; 037FF66C
	cmp r2,#0x0	; 037FF66E
	bne loc_037FF668	; 037FF670
	ldr r0,[sp,#0x20]	; 037FF672
	cmp r0,#0x1d	; 037FF674
	bls loc_037FF67A	; 037FF676
	b loc_037FF8B6	; 037FF678
loc_037FF67A:
	add r0,r0,r0	; 037FF67A
P2_SwitchIndexPC_037FF67A:
	add r0,pc	; 037FF67C
	ldrh r0,[r0,#(P2_SwitchTable_037FF67A - (P2_SwitchIndexPC_037FF67A + 4))]	; 037FF67E
	lsl r0,r0,#0x10	; 037FF680
	asr r0,r0,#0x10	; 037FF682
P2_SwitchTargetPC_037FF67A:
	add r0,pc	; 037FF684
	bx r0	; 037FF686
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FF67A:
	.halfword (loc_037FF6C4 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF6D2 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF6DA + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF6E4 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF6F2 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF70C + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF718 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF724 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF734 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF742 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF750 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF7BA + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF806 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF828 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF75E + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF784 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF79A + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF7A4 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF7B0 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF84A + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF852 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF85A + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF868 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF872 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF87C + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF8A4 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF8AC + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF886 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF890 + 1) - (P2_SwitchTargetPC_037FF67A + 4)
	.halfword (loc_037FF89A + 1) - (P2_SwitchTargetPC_037FF67A + 4)
P2_SwitchTable_037FF67AEnd:
loc_037FF6C4:
	ldr r0,[sp,#0x24]	; 037FF6C4
	ldr r1,[sp,#0x28]	; 037FF6C6
	ldr r2,[sp,#0x2c]	; 037FF6C8
	ldr r3,[sp,#0x30]	; 037FF6CA
	bl loc_037FEF18	; 037FF6CC
	b loc_037FF8B6	; 037FF6D0
loc_037FF6D2:
	ldr r0,[sp,#0x24]	; 037FF6D2
	bl loc_037FEEDC	; 037FF6D4
	b loc_037FF8B6	; 037FF6D8
loc_037FF6DA:
	ldr r0,[sp,#0x24]	; 037FF6DA
	ldr r1,[sp,#0x28]	; 037FF6DC
	bl loc_037FEEA4	; 037FF6DE
	b loc_037FF8B6	; 037FF6E2
loc_037FF6E4:
	ldr r0,[sp,#0x24]	; 037FF6E4
	ldr r1,[sp,#0x28]	; 037FF6E6
	ldr r2,[sp,#0x2c]	; 037FF6E8
	ldr r3,[sp,#0x30]	; 037FF6EA
	bl loc_037FED28	; 037FF6EC
	b loc_037FF8B6	; 037FF6F0
loc_037FF6F2:
	ldr r0,[sp,#0x24]	; 037FF6F2
	lsr r2,r0,#0x18	; 037FF6F4
	mov r1,#0xff	; 037FF6F6
	and r2,r1	; 037FF6F8
	str r2,[sp,#0x0]	; 037FF6FA
	ldr r1,[pool_037FF8E0]	; 037FF6FC
	and r0,r1	; 037FF6FE
	ldr r1,[sp,#0x28]	; 037FF700
	ldr r2,[sp,#0x2c]	; 037FF702
	ldr r3,[sp,#0x30]	; 037FF704
	bl loc_037FECCC	; 037FF706
	b loc_037FF8B6	; 037FF70A
loc_037FF70C:
	ldr r0,[sp,#0x24]	; 037FF70C
	ldr r1,[sp,#0x28]	; 037FF70E
	ldr r2,[sp,#0x2c]	; 037FF710
	bl loc_037FEE3C	; 037FF712
	b loc_037FF8B6	; 037FF716
loc_037FF718:
	ldr r0,[sp,#0x24]	; 037FF718
	ldr r1,[sp,#0x28]	; 037FF71A
	ldr r2,[sp,#0x2c]	; 037FF71C
	bl loc_037FEDEC	; 037FF71E
	b loc_037FF8B6	; 037FF722
loc_037FF724:
	ldr r0,[sp,#0x24]	; 037FF724
	ldr r1,[sp,#0x28]	; 037FF726
	ldr r2,[sp,#0x2c]	; 037FF728
	lsl r2,r2,#0x10	; 037FF72A
	asr r2,r2,#0x10	; 037FF72C
	bl loc_037FF2B8	; 037FF72E
	b loc_037FF8B6	; 037FF732
loc_037FF734:
	ldr r0,[sp,#0x24]	; 037FF734
	ldr r1,[sp,#0x28]	; 037FF736
	lsl r1,r1,#0x10	; 037FF738
	asr r1,r1,#0x10	; 037FF73A
	bl loc_037FF2A0	; 037FF73C
	b loc_037FF8B6	; 037FF740
loc_037FF742:
	ldr r0,[sp,#0x24]	; 037FF742
	ldr r1,[sp,#0x28]	; 037FF744
	ldr r2,[sp,#0x2c]	; 037FF746
	ldr r3,[sp,#0x30]	; 037FF748
	bl loc_037FF4B0	; 037FF74A
	b loc_037FF8B6	; 037FF74E
loc_037FF750:
	ldr r0,[sp,#0x24]	; 037FF750
	ldr r1,[sp,#0x28]	; 037FF752
	ldr r2,[sp,#0x2c]	; 037FF754
	ldr r3,[sp,#0x30]	; 037FF756
	bl loc_037FF424	; 037FF758
	b loc_037FF8B6	; 037FF75C
loc_037FF75E:
	ldr r1,[sp,#0x2c]	; 037FF75E
	lsr r0,r1,#0x1d	; 037FF760
	and r0,r6	; 037FF762
	str r0,[sp,#0x0]	; 037FF764
	lsr r0,r1,#0x1c	; 037FF766
	and r0,r6	; 037FF768
	str r0,[sp,#0x4]	; 037FF76A
	lsr r0,r1,#0x1b	; 037FF76C
	and r0,r6	; 037FF76E
	str r0,[sp,#0x8]	; 037FF770
	lsr r0,r1,#0x1f	; 037FF772
	and r0,r6	; 037FF774
	lsr r1,r1,#0x1e	; 037FF776
	and r1,r6	; 037FF778
	ldr r2,[sp,#0x24]	; 037FF77A
	ldr r3,[sp,#0x28]	; 037FF77C
	bl loc_037FD5B0	; 037FF77E
	b loc_037FF8B6	; 037FF782
loc_037FF784:
	ldr r0,[sp,#0x30]	; 037FF784
	str r0,[sp,#0x4]	; 037FF786
	ldr r3,[sp,#0x2c]	; 037FF788
	mov r0,#0x0	; 037FF78A
	str r0,[sp,#0x0]	; 037FF78C
	ldr r0,[sp,#0x24]	; 037FF78E
	ldr r1,[sp,#0x28]	; 037FF790
	mov r2,#0x0	; 037FF792
	bl loc_037FF3B0	; 037FF794
	b loc_037FF8B6	; 037FF798
loc_037FF79A:
	ldr r0,[sp,#0x24]	; 037FF79A
	ldr r1,[sp,#0x28]	; 037FF79C
	bl loc_037FF5D4	; 037FF79E
	b loc_037FF8B6	; 037FF7A2
loc_037FF7A4:
	ldr r0,[sp,#0x24]	; 037FF7A4
	ldr r1,[sp,#0x28]	; 037FF7A6
	ldr r2,[sp,#0x2c]	; 037FF7A8
	bl loc_037FF59C	; 037FF7AA
	b loc_037FF8B6	; 037FF7AE
loc_037FF7B0:
	ldr r0,[sp,#0x24]	; 037FF7B0
	ldr r1,[sp,#0x28]	; 037FF7B2
	bl loc_037FF568	; 037FF7B4
	b loc_037FF8B6	; 037FF7B8
loc_037FF7BA:
	ldr r3,[sp,#0x30]	; 037FF7BA
	ldr r2,[sp,#0x24]	; 037FF7BC
	ldr r1,[sp,#0x2c]	; 037FF7BE
	add r5,r3,#0x0	; 037FF7C0
	ldr r0,[pool_037FF8E4]	; 037FF7C2
	and r5,r0	; 037FF7C4
	str r5,[sp,#0x0]	; 037FF7C6
	add r5,r1,#0x0	; 037FF7C8
	ldr r0,[pool_037FF8E8]	; 037FF7CA
	and r5,r0	; 037FF7CC
	str r5,[sp,#0x4]	; 037FF7CE
	lsr r0,r1,#0x18	; 037FF7D0
	and r0,r4	; 037FF7D2
	str r0,[sp,#0x8]	; 037FF7D4
	lsr r0,r1,#0x16	; 037FF7D6
	and r0,r7	; 037FF7D8
	str r0,[sp,#0xc]	; 037FF7DA
	lsr r1,r2,#0x10	; 037FF7DC
	ldr r0,[pool_037FF8E4]	; 037FF7DE
	and r1,r0	; 037FF7E0
	str r1,[sp,#0x10]	; 037FF7E2
	lsr r0,r3,#0x10	; 037FF7E4
	and r0,r4	; 037FF7E6
	str r0,[sp,#0x14]	; 037FF7E8
	ldr r0,[pool_037FF8E4]	; 037FF7EA
	and r2,r0	; 037FF7EC
	add r0,r2,#0x0	; 037FF7EE
	ldr r2,[sp,#0x28]	; 037FF7F0
	ldr r1,[pool_037FF8EC]	; 037FF7F2
	and r2,r1	; 037FF7F4
	add r1,r2,#0x0	; 037FF7F6
	lsr r2,r3,#0x18	; 037FF7F8
	and r2,r7	; 037FF7FA
	lsr r3,r3,#0x1a	; 037FF7FC
	and r3,r7	; 037FF7FE
	bl loc_037FD20C	; 037FF800
	b loc_037FF8B6	; 037FF804
loc_037FF806:
	ldr r2,[sp,#0x2c]	; 037FF806
	ldr r3,[sp,#0x28]	; 037FF808
	lsr r1,r2,#0x8	; 037FF80A
	ldr r0,[pool_037FF8E4]	; 037FF80C
	and r1,r0	; 037FF80E
	str r1,[sp,#0x0]	; 037FF810
	and r2,r4	; 037FF812
	str r2,[sp,#0x4]	; 037FF814
	ldr r0,[sp,#0x24]	; 037FF816
	ldr r1,[sp,#0x30]	; 037FF818
	add r2,r3,#0x0	; 037FF81A
	and r2,r4	; 037FF81C
	lsr r3,r3,#0x8	; 037FF81E
	and r3,r7	; 037FF820
	bl loc_037FD1A0	; 037FF822
	b loc_037FF8B6	; 037FF826
loc_037FF828:
	ldr r3,[sp,#0x2c]	; 037FF828
	ldr r2,[sp,#0x28]	; 037FF82A
	add r0,r3,#0x0	; 037FF82C
	and r0,r4	; 037FF82E
	str r0,[sp,#0x0]	; 037FF830
	ldr r0,[sp,#0x24]	; 037FF832
	add r1,r2,#0x0	; 037FF834
	and r1,r4	; 037FF836
	lsr r2,r2,#0x8	; 037FF838
	and r2,r7	; 037FF83A
	lsr r5,r3,#0x8	; 037FF83C
	ldr r3,[pool_037FF8E4]	; 037FF83E
	and r5,r3	; 037FF840
	add r3,r5,#0x0	; 037FF842
	bl loc_037FD138	; 037FF844
	b loc_037FF8B6	; 037FF848
loc_037FF84A:
	ldr r0,[sp,#0x24]	; 037FF84A
	bl loc_037FCFF8	; 037FF84C
	b loc_037FF8B6	; 037FF850
loc_037FF852:
	ldr r0,[sp,#0x24]	; 037FF852
	bl loc_037FCF20	; 037FF854
	b loc_037FF8B6	; 037FF858
loc_037FF85A:
	ldr r0,[sp,#0x24]	; 037FF85A
	ldr r1,[sp,#0x28]	; 037FF85C
	ldr r2,[sp,#0x2c]	; 037FF85E
	ldr r3,[sp,#0x30]	; 037FF860
	bl loc_037FCEEC	; 037FF862
	b loc_037FF8B6	; 037FF866
loc_037FF868:
	ldr r0,[sp,#0x24]	; 037FF868
	ldr r1,[sp,#0x28]	; 037FF86A
	bl loc_037FD958	; 037FF86C
	b loc_037FF8B6	; 037FF870
loc_037FF872:
	ldr r0,[sp,#0x24]	; 037FF872
	ldr r1,[sp,#0x28]	; 037FF874
	bl loc_037FD934	; 037FF876
	b loc_037FF8B6	; 037FF87A
loc_037FF87C:
	ldr r0,[sp,#0x24]	; 037FF87C
	ldr r1,[sp,#0x28]	; 037FF87E
	bl loc_037FDA04	; 037FF880
	b loc_037FF8B6	; 037FF884
loc_037FF886:
	ldr r0,[sp,#0x24]	; 037FF886
	ldr r1,[sp,#0x28]	; 037FF888
	bl loc_037FED94	; 037FF88A
	b loc_037FF8B6	; 037FF88E
loc_037FF890:
	ldr r0,[sp,#0x24]	; 037FF890
	ldr r1,[sp,#0x28]	; 037FF892
	bl loc_037FED58	; 037FF894
	b loc_037FF8B6	; 037FF898
loc_037FF89A:
	ldr r0,[sp,#0x24]	; 037FF89A
	ldr r1,[sp,#0x28]	; 037FF89C
	bl loc_037FD8E4	; 037FF89E
	b loc_037FF8B6	; 037FF8A2
loc_037FF8A4:
	ldr r1,[sp,#0x24]	; 037FF8A4
	ldr r0,[pool_037FF8F0]	; 037FF8A6
	str r1,[r0,#0x0]	; 037FF8A8
	b loc_037FF8B6	; 037FF8AA
loc_037FF8AC:
	ldr r0,[pool_037FF8F4]	; 037FF8AC
	ldr r1,[sp,#0x24]	; 037FF8AE
	ldr r2,[pool_037FF8F8]	; 037FF8B0
	bl loc_037FF900	; 037FF8B2
loc_037FF8B6:
	ldr r5,[sp,#0x1c]	; 037FF8B6
loc_037FF8B8:
	cmp r5,#0x0	; 037FF8B8
	beq loc_037FF8BE	; 037FF8BA
	b loc_037FF664	; 037FF8BC
loc_037FF8BE:
	ldr r0,[pool_037FF8F0]	; 037FF8BE
	ldr r1,[r0,#0x0]	; 037FF8C0
	ldr r0,[r1,#0x0]	; 037FF8C2
	add r0,r0,#0x1	; 037FF8C4
	str r0,[r1,#0x0]	; 037FF8C6
loc_037FF8C8:
	ldr r0,[pool_037FF8FC]	; 037FF8C8
	add r1,sp,#0x18	; 037FF8CA
	mov r2,#0x0	; 037FF8CC
	bl loc_037FBD94	; 037FF8CE
	cmp r0,#0x0	; 037FF8D2
	beq loc_037FF8D8	; 037FF8D4
	b loc_037FF660	; 037FF8D6
loc_037FF8D8:
	add sp,#0x34	; 037FF8D8
	pop {r4,r5,r6,r7}	; 037FF8DA
	pop {r3}	; 037FF8DC
	bx r3	; 037FF8DE
pool_037FF8E0:
loc_037FF8E0:
	.word 0x00FFFFFF	; 037FF8E0
pool_037FF8E4:
loc_037FF8E4:
	.word 0x0000FFFF	; 037FF8E4
pool_037FF8E8:
loc_037FF8E8:
	.word 0x003FFFFF	; 037FF8E8
pool_037FF8EC:
loc_037FF8EC:
	.word 0x07FFFFFF	; 037FF8EC
pool_037FF8F0:
loc_037FF8F0:
	.word P2_BssStart + 0xB70	; 037FF8F0
pool_037FF8F4:
loc_037FF8F4:
	.word 0x0380387C	; 037FF8F4
pool_037FF8F8:
loc_037FF8F8:
	.word 0x00001180	; 037FF8F8
pool_037FF8FC:
loc_037FF8FC:
	.word 0x038049FC	; 037FF8FC

; ===== function loc_037FF900 =====
loc_037FF900:
	bx pc	; 037FF900
	.byte 0xC0, 0x46	; 037FF904
.arm

; ===== function loc_037FF904 =====
loc_037FF904:
	ldr pc,[pool_037FF908]	; 037FF904
pool_037FF908:
loc_037FF908:
	.word loc_037FCE4C	; 037FF908
.thumb

; ===== function loc_037FF90C =====
loc_037FF90C:
	push {lr}	; 037FF90C
	sub sp,#0x4	; 037FF90E
	ldr r0,[pool_037FF92C]	; 037FF910
	ldr r1,[pool_037FF930]	; 037FF912
	mov r2,#0x8	; 037FF914
	bl loc_037FBE70	; 037FF916
	bl loc_037FF608	; 037FF91A
	mov r1,#0x0	; 037FF91E
	ldr r0,[pool_037FF934]	; 037FF920
	str r1,[r0,#0x0]	; 037FF922
	add sp,#0x4	; 037FF924
	pop {r3}	; 037FF926
	bx r3	; 037FF928
	.byte 0xC0, 0x46	; 037FF92C
pool_037FF92C:
loc_037FF92C:
	.word 0x038049FC	; 037FF92C
pool_037FF930:
loc_037FF930:
	.word 0x03804A10	; 037FF930
pool_037FF934:
loc_037FF934:
	.word P2_BssStart + 0xB70	; 037FF934

; ===== function loc_037FF938 =====
loc_037FF938:
	ldr r3,[pool_037FF93C]	; 037FF938
	bx r3	; 037FF93A
pool_037FF93C:
loc_037FF93C:
	.word loc_037FFAF0 + 1	; 037FF93C

; ===== function loc_037FF940 =====
P2_IrqHandler_037FF940:
	push {r4,r5,r6,r7,lr}	; 037FF940
	sub sp,#0x4	; 037FF942
	ldr r5,[pool_037FF9FC]	; 037FF944
	mov r0,#0x3	; 037FF946
	mvn r6,r0	; 037FF948
	mov r7,#0x2	; 037FF94A
	mvn r4,r7	; 037FF94C
loc_037FF94E:
	ldrh r1,[r5,#0x0]	; 037FF94E
	ldr r0,[pool_037FFA00]	; 037FF950
	and r1,r0	; 037FF952
	cmp r1,#0x0	; 037FF954
	beq loc_037FF964	; 037FF956
	ldrh r1,[r5,#0x0]	; 037FF958
	ldr r0,[pool_037FFA04]	; 037FF95A
	orr r1,r0	; 037FF95C
	strh r1,[r5,#0x0]	; 037FF95E
	add r0,r4,#0x0	; 037FF960
	b loc_037FF986	; 037FF962
loc_037FF964:
	bl loc_037FB7EC	; 037FF964
	ldrh r2,[r5,#0x0]	; 037FF968
	ldr r1,[pool_037FFA08]	; 037FF96A
	and r2,r1	; 037FF96C
	cmp r2,#0x0	; 037FF96E
	beq loc_037FF97A	; 037FF970
	bl loc_037FB810	; 037FF972
	add r0,r6,#0x0	; 037FF976
	b loc_037FF986	; 037FF978
loc_037FF97A:
	ldr r1,[pool_037FFA0C]	; 037FF97A
	ldr r1,[r1,#0x0]	; 037FF97C
	str r1,[sp,#0x0]	; 037FF97E
	bl loc_037FB810	; 037FF980
	mov r0,#0x0	; 037FF984
loc_037FF986:
	mov r1,#0x3	; 037FF986
	mvn r1,r1	; 037FF988
	cmp r0,r1	; 037FF98A
	beq loc_037FF9F4	; 037FF98C
	mvn r1,r7	; 037FF98E
	cmp r0,r1	; 037FF990
	beq loc_037FF94E	; 037FF992
	ldr r2,[sp,#0x0]	; 037FF994
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 037FF996
	lsr r0,r0,#0x1b	; 037FF998
	cmp r0,#0x0	; 037FF99A
	beq loc_037FF94E	; 037FF99C
	lsl r3,r0,#0x2	; 037FF99E
	ldr r1,[pool_037FFA10]	; 037FF9A0
	ldr r3,[r1,r3]	; 037FF9A2
	cmp r3,#0x0	; 037FF9A4
	beq loc_037FF9B4	; 037FF9A6
	lsr r1,r2,#0x6	; 037FF9A8
	lsl r2,r2,#0x1a	; 037FF9AA
	lsr r2,r2,#0x1f	; 037FF9AC
	bl loc_03802A00	; 037FF9AE
	b loc_037FF94E	; 037FF9B2
loc_037FF9B4:
	lsl r0,r2,#0x1a	; 037FF9B4
	lsr r0,r0,#0x1f	; 037FF9B6
	cmp r0,#0x0	; 037FF9B8
	bne loc_037FF94E	; 037FF9BA
	mov r0,#0x20	; 037FF9BC
	orr r2,r0	; 037FF9BE
	str r2,[sp,#0x0]	; 037FF9C0
	ldrh r1,[r5,#0x0]	; 037FF9C2
	ldr r0,[pool_037FFA00]	; 037FF9C4
	and r1,r0	; 037FF9C6
	cmp r1,#0x0	; 037FF9C8
	beq loc_037FF9D6	; 037FF9CA
	ldrh r1,[r5,#0x0]	; 037FF9CC
	ldr r0,[pool_037FFA04]	; 037FF9CE
	orr r1,r0	; 037FF9D0
	strh r1,[r5,#0x0]	; 037FF9D2
	b loc_037FF94E	; 037FF9D4
loc_037FF9D6:
	bl loc_037FB7EC	; 037FF9D6
	ldrh r1,[r5,#0x0]	; 037FF9DA
	and r1,r7	; 037FF9DC
	cmp r1,#0x0	; 037FF9DE
	beq loc_037FF9E8	; 037FF9E0
	bl loc_037FB810	; 037FF9E2
	b loc_037FF94E	; 037FF9E6
loc_037FF9E8:
	ldr r2,[sp,#0x0]	; 037FF9E8
	ldr r1,[pool_037FFA14]	; 037FF9EA
	str r2,[r1,#0x0]	; 037FF9EC
	bl loc_037FB810	; 037FF9EE
	b loc_037FF94E	; 037FF9F2
loc_037FF9F4:
	add sp,#0x4	; 037FF9F4
	pop {r4,r5,r6,r7}	; 037FF9F6
	pop {r3}	; 037FF9F8
	bx r3	; 037FF9FA
pool_037FF9FC:
loc_037FF9FC:
	.word REG_IPC_FIFO_CR	; 037FF9FC
pool_037FFA00:
loc_037FFA00:
	.word 0x00004000	; 037FFA00
pool_037FFA04:
loc_037FFA04:
	.word 0x0000C000	; 037FFA04
pool_037FFA08:
loc_037FFA08:
	.word 0x00000100	; 037FFA08
pool_037FFA0C:
loc_037FFA0C:
	.word REG_IPC_FIFO_RX	; 037FFA0C
pool_037FFA10:
loc_037FFA10:
	.word P2_PxiReceiveCallbacks	; 037FFA10
pool_037FFA14:
loc_037FFA14:
	.word REG_IPC_FIFO_TX	; 037FFA14

; ===== function loc_037FFA18 =====
loc_037FFA18:
	push {r4,lr}	; 037FFA18
	sub sp,#0x8	; 037FFA1A
	ldr r3,[sp,#0x0]	; 037FFA1C
	mov r4,#0x1f	; 037FFA1E
	bic r3,r4	; 037FFA20
	and r0,r4	; 037FFA22
	orr r3,r0	; 037FFA24
	str r3,[sp,#0x0]	; 037FFA26
	mov r0,#0x20	; 037FFA28
	bic r3,r0	; 037FFA2A
	mov r0,#0x1	; 037FFA2C
	and r2,r0	; 037FFA2E
	lsl r0,r2,#0x5	; 037FFA30
	orr r3,r0	; 037FFA32
	str r3,[sp,#0x0]	; 037FFA34
	mov r0,#0x3f	; 037FFA36
	and r3,r0	; 037FFA38
	ldr r0,[pool_037FFA8C]	; 037FFA3A
	and r1,r0	; 037FFA3C
	lsl r0,r1,#0x6	; 037FFA3E
	orr r3,r0	; 037FFA40
	str r3,[sp,#0x0]	; 037FFA42
	ldr r2,[pool_037FFA90]	; 037FFA44
	ldrh r1,[r2,#0x0]	; 037FFA46
	ldr r0,[pool_037FFA94]	; 037FFA48
	and r1,r0	; 037FFA4A
	cmp r1,#0x0	; 037FFA4C
	beq loc_037FFA5E	; 037FFA4E
	ldrh r1,[r2,#0x0]	; 037FFA50
	ldr r0,[pool_037FFA98]	; 037FFA52
	orr r1,r0	; 037FFA54
	strh r1,[r2,#0x0]	; 037FFA56
	mov r0,#0x0	; 037FFA58
	mvn r0,r0	; 037FFA5A
	b loc_037FFA84	; 037FFA5C
loc_037FFA5E:
	bl loc_037FB7EC	; 037FFA5E
	ldr r1,[pool_037FFA90]	; 037FFA62
	ldrh r2,[r1,#0x0]	; 037FFA64
	mov r1,#0x2	; 037FFA66
	and r2,r1	; 037FFA68
	cmp r2,#0x0	; 037FFA6A
	beq loc_037FFA78	; 037FFA6C
	bl loc_037FB810	; 037FFA6E
	mov r0,#0x1	; 037FFA72
	mvn r0,r0	; 037FFA74
	b loc_037FFA84	; 037FFA76
loc_037FFA78:
	ldr r2,[sp,#0x0]	; 037FFA78
	ldr r1,[pool_037FFA9C]	; 037FFA7A
	str r2,[r1,#0x0]	; 037FFA7C
	bl loc_037FB810	; 037FFA7E
	mov r0,#0x0	; 037FFA82
loc_037FFA84:
	add sp,#0x8	; 037FFA84
	pop {r4}	; 037FFA86
	pop {r3}	; 037FFA88
	bx r3	; 037FFA8A
pool_037FFA8C:
loc_037FFA8C:
	.word 0x03FFFFFF	; 037FFA8C
pool_037FFA90:
loc_037FFA90:
	.word REG_IPC_FIFO_CR	; 037FFA90
pool_037FFA94:
loc_037FFA94:
	.word 0x00004000	; 037FFA94
pool_037FFA98:
loc_037FFA98:
	.word 0x0000C000	; 037FFA98
pool_037FFA9C:
loc_037FFA9C:
	.word REG_IPC_FIFO_TX	; 037FFA9C

; ===== function loc_037FFAA0 =====
loc_037FFAA0:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P2_SetPxiReceiveCallback
	push {r4,r5,lr}	; 037FFAA0
	sub sp,#0x4	; 037FFAA2
	add r5,r0,#0x0	; 037FFAA4
	add r4,r1,#0x0	; 037FFAA6
	bl loc_037FB7EC	; 037FFAA8
	lsl r2,r5,#0x2	; 037FFAAC
	ldr r1,[pool_037FFAE4]	; 037FFAAE
	str r4,[r1,r2]	; 037FFAB0
	cmp r4,#0x0	; 037FFAB2
	beq loc_037FFAC8	; 037FFAB4
	ldr r2,[pool_037FFAE8]	; 037FFAB6
	ldr r1,[pool_037FFAEC]	; 037FFAB8
	add r3,r2,r1	; 037FFABA
	ldr r2,[r3,#0x0]	; 037FFABC
	mov r1,#0x1	; 037FFABE
	lsl r1,r5	; 037FFAC0
	orr r2,r1	; 037FFAC2
	str r2,[r3,#0x0]	; 037FFAC4
	b loc_037FFAD8	; 037FFAC6
loc_037FFAC8:
	ldr r2,[pool_037FFAE8]	; 037FFAC8
	ldr r1,[pool_037FFAEC]	; 037FFACA
	add r3,r2,r1	; 037FFACC
	ldr r2,[r3,#0x0]	; 037FFACE
	mov r1,#0x1	; 037FFAD0
	lsl r1,r5	; 037FFAD2
	bic r2,r1	; 037FFAD4
	str r2,[r3,#0x0]	; 037FFAD6
loc_037FFAD8:
	bl loc_037FB810	; 037FFAD8
	add sp,#0x4	; 037FFADC
	pop {r4,r5}	; 037FFADE
	pop {r3}	; 037FFAE0
	bx r3	; 037FFAE2
.endfunc
pool_037FFAE4:
loc_037FFAE4:
	.word P2_PxiReceiveCallbacks	; 037FFAE4
pool_037FFAE8:
loc_037FFAE8:
	.word FirmwareSystemWorkAddress	; 037FFAE8
pool_037FFAEC:
loc_037FFAEC:
	.word SystemWorkPxiArm7AvailableOffset	; 037FFAEC

; ===== function loc_037FFAF0 =====
loc_037FFAF0:
	push {r4,r5,r6,r7,lr}	; 037FFAF0
	sub sp,#0x4	; 037FFAF2
	bl loc_037FB7EC	; 037FFAF4
	add r5,r0,#0x0	; 037FFAF8
	ldr r0,[pool_037FFB64]	; 037FFAFA
	ldrh r1,[r0,#0x0]	; 037FFAFC
	cmp r1,#0x0	; 037FFAFE
	bne loc_037FFB54	; 037FFB00
	mov r1,#0x1	; 037FFB02
	strh r1,[r0,#0x0]	; 037FFB04
	mov r3,#0x0	; 037FFB06
	ldr r1,[pool_037FFB68]	; 037FFB08
	ldr r0,[pool_037FFB6C]	; 037FFB0A
	str r3,[r1,r0]	; 037FFB0C
	add r2,r3,#0x0	; 037FFB0E
	ldr r0,[pool_037FFB70]	; 037FFB10
loc_037FFB12:
	lsl r1,r3,#0x2	; 037FFB12
	str r2,[r0,r1]	; 037FFB14
	add r3,r3,#0x1	; 037FFB16
	cmp r3,#PxiFifoChannelCount	; 037FFB18
	blt loc_037FFB12	; 037FFB1A
	ldr r0,[pool_037FFB74]	; 037FFB1C
	ldr r1,[pool_037FFB78]	; 037FFB1E
	bl loc_037FB620	; 037FFB20
	ldr r0,[pool_037FFB74]	; 037FFB24
	bl loc_037FB59C	; 037FFB26
	ldr r1,[pool_037FFB7C]	; 037FFB2A
	ldr r0,[pool_037FFB80]	; 037FFB2C
	strh r1,[r0,#0x0]	; 037FFB2E
	mov r4,#0x8	; 037FFB30
	add r7,r4,#0x0	; 037FFB32
	ldr r6,[pool_037FFB84]	; 037FFB34
	b loc_037FFB50	; 037FFB36
loc_037FFB38:
	lsl r0,r4,#0x8	; 037FFB38
	strh r0,[r6,#0x0]	; 037FFB3A
	ldr r0,[pool_037FFB88]	; 037FFB3C
	bl loc_037FCCB4	; 037FFB3E
	ldrh r1,[r6,#0x0]	; 037FFB42
	mov r0,#0xf	; 037FFB44
	and r1,r0	; 037FFB46
	cmp r1,r4	; 037FFB48
	beq loc_037FFB4E	; 037FFB4A
	add r4,r7,#0x0	; 037FFB4C
loc_037FFB4E:
	sub r4,r4,#0x1	; 037FFB4E
loc_037FFB50:
	cmp r4,#0x0	; 037FFB50
	bge loc_037FFB38	; 037FFB52
loc_037FFB54:
	add r0,r5,#0x0	; 037FFB54
	bl loc_037FB810	; 037FFB56
	add sp,#0x4	; 037FFB5A
	pop {r4,r5,r6,r7}	; 037FFB5C
	pop {r3}	; 037FFB5E
	bx r3	; 037FFB60
	.byte 0xC0, 0x46	; 037FFB64
pool_037FFB64:
loc_037FFB64:
	.word P2_BssStart + 0x1D28	; 037FFB64
pool_037FFB68:
loc_037FFB68:
	.word FirmwareSystemWorkAddress	; 037FFB68
pool_037FFB6C:
loc_037FFB6C:
	.word SystemWorkPxiArm7AvailableOffset	; 037FFB6C
pool_037FFB70:
loc_037FFB70:
	.word P2_PxiReceiveCallbacks	; 037FFB70
pool_037FFB74:
loc_037FFB74:
	.word 0x00040000	; 037FFB74
pool_037FFB78:
loc_037FFB78:
	.word P2_IrqHandler_037FF940 + 1	; 037FFB78
pool_037FFB7C:
loc_037FFB7C:
	.word 0x0000C408	; 037FFB7C
pool_037FFB80:
loc_037FFB80:
	.word REG_IPC_FIFO_CR	; 037FFB80
pool_037FFB84:
loc_037FFB84:
	.word REG_IPC_SYNC	; 037FFB84
pool_037FFB88:
loc_037FFB88:
	.word 0x000003E8	; 037FFB88
; 采样 X/Y、调试键与合盖输入；将合盖位转换为共享状态 bit15。
; Sample X/Y, debug and hinge inputs; publish the hinge bit as shared bit15.
.func P2_PublishExtendedKeyState
	push {r4,lr}	; 037FFB8C
	mov r4,#0x0	; 037FFB8E
	ldr r0,[pool_037FFBB8]	; 037FFB90
	bl loc_037FFC2C	; 037FFB92
	ldr r0,[pool_037FFBBC]	; 037FFB96
	ldrh r2,[r0,#0x0]	; 037FFB98
	mov r0,#KEYXY_LID_CLOSED	; 037FFB9A
	add r1,r2,#0x0	; 037FFB9C
	and r1,r0	; 037FFB9E
	cmp r1,#0x0	; 037FFBA0
	beq loc_037FFBA6	; 037FFBA2
	ldr r4,[pool_037FFBB8]	; 037FFBA4
loc_037FFBA6:
	mov r0,#0xb	; 037FFBA6
	and r2,r0	; 037FFBA8
	lsl r1,r2,#0xa	; 037FFBAA
	orr r1,r4	; 037FFBAC
	ldr r0,[pool_037FFBC0]	; 037FFBAE
	strh r1,[r0,#0x0]	; 037FFBB0
	pop {r4}	; 037FFBB2
	pop {r3}	; 037FFBB4
	bx r3	; 037FFBB6
.endfunc
pool_037FFBB8:
loc_037FFBB8:
; 此 0x8000 常量也传给 RCNT 模式设置；原代码共用同一槽。
; The same 0x8000 literal also selects RCNT GPIO mode in the original code.
	.word SystemWorkLidClosedMask	; 037FFBB8
pool_037FFBBC:
loc_037FFBBC:
	.word REG_KEYXY	; 037FFBBC
pool_037FFBC0:
loc_037FFBC0:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 037FFBC0

; ===== function loc_037FFBC4 =====
loc_037FFBC4:
	push {r4,r5,lr}	; 037FFBC4
	sub sp,#0xc	; 037FFBC6
	bl loc_037FC478	; 037FFBC8
	cmp r0,#0x0	; 037FFBCC
	beq loc_037FFBD8	; 037FFBCE
	bl loc_037FC780	; 037FFBD0
	cmp r0,#0x0	; 037FFBD4
	bne loc_037FFBDC	; 037FFBD6
loc_037FFBD8:
	mov r0,#0x0	; 037FFBD8
	b loc_037FFC14	; 037FFBDA
loc_037FFBDC:
	ldr r0,[pool_037FFC1C]	; 037FFBDC
	ldr r0,[r0,#0x0]	; 037FFBDE
	cmp r0,#0x0	; 037FFBE0
	beq loc_037FFBE8	; 037FFBE2
	mov r0,#0x0	; 037FFBE4
	b loc_037FFC14	; 037FFBE6
loc_037FFBE8:
	ldr r0,[pool_037FFC20]	; 037FFBE8
	bl loc_037FC778	; 037FFBEA
	bl loc_037FC3AC	; 037FFBEE
	add r2,r0,#0x0	; 037FFBF2
	ldr r0,[pool_037FFC24]	; 037FFBF4
	str r0,[sp,#0x4]	; 037FFBF6
	mov r5,#0x0	; 037FFBF8
	str r5,[sp,#0x8]	; 037FFBFA
	ldr r3,[pool_037FFC28]	; 037FFBFC
	str r5,[sp,#0x0]	; 037FFBFE
	ldr r0,[pool_037FFC20]	; 037FFC00
	add r4,r2,r3	; 037FFC02
	lsl r2,r1,#0	; 037FFC04
	adc r2,r5	; 037FFC06
	add r1,r4,#0x0	; 037FFC08
	bl loc_037FC5FC	; 037FFC0A
	mov r0,#0x1	; 037FFC0E
	ldr r1,[pool_037FFC1C]	; 037FFC10
	str r0,[r1,#0x0]	; 037FFC12
loc_037FFC14:
	add sp,#0xc	; 037FFC14
	pop {r4,r5}	; 037FFC16
	pop {r3}	; 037FFC18
	bx r3	; 037FFC1A
pool_037FFC1C:
loc_037FFC1C:
	.word P2_BssStart + 0x1DAC	; 037FFC1C
pool_037FFC20:
loc_037FFC20:
	.word 0x03804AB8	; 037FFC20
pool_037FFC24:
loc_037FFC24:
	.word P2_PublishExtendedKeyState + 1	; 037FFC24
pool_037FFC28:
loc_037FFC28:
	.word 0x0000082E	; 037FFC28

; ===== function loc_037FFC2C =====
loc_037FFC2C:
	add r1,r0,#0x0	; 037FFC2C
	ldr r0,[pool_037FFC38]	; 037FFC2E
	lsl r1,r1,#0x10	; 037FFC30
	lsr r1,r1,#0x10	; 037FFC32
	ldr r3,[pool_037FFC3C]	; 037FFC34
	bx r3	; 037FFC36
pool_037FFC38:
loc_037FFC38:
	.word 0x0000C000	; 037FFC38
pool_037FFC3C:
loc_037FFC3C:
	.word loc_037FFC40 + 1	; 037FFC3C
loc_037FFC40:
	mvn r3,r0	; 037FFC40
	ldr r2,[pool_037FFC50]	; 037FFC42
	ldrh r0,[r2,#0x0]	; 037FFC44
	and r3,r0	; 037FFC46
	orr r1,r3	; 037FFC48
	strh r1,[r2,#0x0]	; 037FFC4A
	bx lr	; 037FFC4C
	.byte 0xC0, 0x46	; 037FFC50
pool_037FFC50:
loc_037FFC50:
	.word REG_RCNT_ARM7	; 037FFC50

; ===== function loc_037FFC54 =====
loc_037FFC54:
	push {lr}	; 037FFC54
	sub sp,#0x4	; 037FFC56
	add r0,sp,#0x0	; 037FFC58
	bl loc_038003D8	; 037FFC5A
	add r0,sp,#0x0	; 037FFC5E
	add r0,#0x2	; 037FFC60
	bl loc_03800398	; 037FFC62
	add r0,sp,#0x0	; 037FFC66
	ldrh r1,[r0,#0x0]	; 037FFC68
	lsl r2,r1,#0x18	; 037FFC6A
	lsr r2,r2,#0x1f	; 037FFC6C
	cmp r2,#0x0	; 037FFC6E
	bne loc_037FFC84	; 037FFC70
	lsl r1,r1,#0x19	; 037FFC72
	lsr r1,r1,#0x1f	; 037FFC74
	cmp r1,#0x0	; 037FFC76
	bne loc_037FFC84	; 037FFC78
	ldrh r0,[r0,#0x2]	; 037FFC7A
	lsl r0,r0,#0x18	; 037FFC7C
	lsr r0,r0,#0x1f	; 037FFC7E
	cmp r0,#0x0	; 037FFC80
	beq loc_037FFC96	; 037FFC82
loc_037FFC84:
	add r1,sp,#0x0	; 037FFC84
	ldrh r2,[r1,#0x0]	; 037FFC86
	mov r0,#0x1	; 037FFC88
	bic r2,r0	; 037FFC8A
	orr r2,r0	; 037FFC8C
	strh r2,[r1,#0x0]	; 037FFC8E
	add r0,sp,#0x0	; 037FFC90
	bl loc_038003B8	; 037FFC92
loc_037FFC96:
	mov r0,#0x1	; 037FFC96
	bl loc_03800508	; 037FFC98
	add sp,#0x4	; 037FFC9C
	pop {r3}	; 037FFC9E
	bx r3	; 037FFCA0
	.byte 0x00, 0x00	; 037FFCA4
P2_Code_037FFCA4:
	ldr r0,[pool_037FFCAC]	; 037FFCA4
	ldr r3,[pool_037FFCB0]	; 037FFCA6
	bx r3	; 037FFCA8
	.byte 0xC0, 0x46	; 037FFCAC
pool_037FFCAC:
loc_037FFCAC:
	.word 0x03804D04	; 037FFCAC
pool_037FFCB0:
loc_037FFCB0:
	.word loc_037FBA10 + 1	; 037FFCB0

; ===== function loc_037FFCB4 =====
P2_ThreadEntry_037FFCB4:
	push {r4,r5,r6,r7,lr}	; 037FFCB4
	sub sp,#0xc	; 037FFCB6
	add r4,sp,#0x0	; 037FFCB8
	ldrh r1,[r4,#0x2]	; 037FFCBA
	mov r0,#0x10	; 037FFCBC
	bic r1,r0	; 037FFCBE
	strh r1,[r4,#0x2]	; 037FFCC0
	ldrh r1,[r4,#0x2]	; 037FFCC2
	mov r0,#0x20	; 037FFCC4
	bic r1,r0	; 037FFCC6
	strh r1,[r4,#0x2]	; 037FFCC8
	ldr r6,[pool_037FFD48]	; 037FFCCA
	mov r7,#0xf	; 037FFCCC
loc_037FFCCE:
	ldr r0,[pool_037FFD4C]	; 037FFCCE
	bl loc_037FBA58	; 037FFCD0
	ldr r0,[r6,#0x1c]	; 037FFCD4
	cmp r0,#0x0	; 037FFCD6
	bne loc_037FFCCE	; 037FFCD8
	add r0,sp,#0x0	; 037FFCDA
	bl loc_038003D8	; 037FFCDC
	ldrh r1,[r4,#0x0]	; 037FFCE0
	lsl r0,r1,#0x1b	; 037FFCE2
	lsr r2,r0,#0x1f	; 037FFCE4
	ldrh r0,[r4,#0x2]	; 037FFCE6
	lsl r3,r0,#0x1b	; 037FFCE8
	lsr r3,r3,#0x1f	; 037FFCEA
	sub r2,r2,r3	; 037FFCEC
	cmp r2,#0x1	; 037FFCEE
	beq loc_037FFD00	; 037FFCF0
	lsl r1,r1,#0x1a	; 037FFCF2
	lsr r1,r1,#0x1f	; 037FFCF4
	lsl r0,r0,#0x1a	; 037FFCF6
	lsr r0,r0,#0x1f	; 037FFCF8
	sub r0,r1,r0	; 037FFCFA
	cmp r0,#0x1	; 037FFCFC
	bne loc_037FFD40	; 037FFCFE
loc_037FFD00:
	add r0,sp,#0x4	; 037FFD00
	bl loc_03800398	; 037FFD02
	mov r5,#0x0	; 037FFD06
	ldrh r0,[r4,#0x0]	; 037FFD08
	lsl r0,r0,#0x1b	; 037FFD0A
	lsr r0,r0,#0x1f	; 037FFD0C
	cmp r0,#0x0	; 037FFD0E
	beq loc_037FFD1C	; 037FFD10
	mov r0,#0x1	; 037FFD12
	orr r5,r0	; 037FFD14
	ldrh r0,[r4,#0x4]	; 037FFD16
	bic r0,r7	; 037FFD18
	strh r0,[r4,#0x4]	; 037FFD1A
loc_037FFD1C:
	ldrh r0,[r4,#0x0]	; 037FFD1C
	lsl r0,r0,#0x1a	; 037FFD1E
	lsr r0,r0,#0x1f	; 037FFD20
	cmp r0,#0x0	; 037FFD22
	beq loc_037FFD32	; 037FFD24
	mov r0,#0x2	; 037FFD26
	orr r5,r0	; 037FFD28
	ldrh r1,[r4,#0x4]	; 037FFD2A
	mov r0,#0x40	; 037FFD2C
	bic r1,r0	; 037FFD2E
	strh r1,[r4,#0x4]	; 037FFD30
loc_037FFD32:
	add r0,sp,#0x4	; 037FFD32
	bl loc_03800378	; 037FFD34
	mov r0,#0x30	; 037FFD38
	add r1,r5,#0x0	; 037FFD3A
	bl loc_037FFF44	; 037FFD3C
loc_037FFD40:
	ldrh r0,[r4,#0x0]	; 037FFD40
	strh r0,[r4,#0x2]	; 037FFD42
	b loc_037FFCCE	; 037FFD44
	.byte 0xC0, 0x46	; 037FFD48
pool_037FFD48:
loc_037FFD48:
	.word 0x03804C68	; 037FFD48
pool_037FFD4C:
loc_037FFD4C:
	.word 0x03804D04	; 037FFD4C

; ===== function loc_037FFD50 =====
P2_ThreadEntry_037FFD50:
	push {r4,r5,r6,r7,lr}	; 037FFD50
	sub sp,#0x4	; 037FFD52
	ldr r5,[pool_037FFF38]	; 037FFD54
	add r6,r5,#0x4	; 037FFD56
	mov r7,#0x0	; 037FFD58
	ldr r4,[pool_037FFF3C]	; 037FFD5A
loc_037FFD5C:
	ldr r0,[pool_037FFF40]	; 037FFD5C
	add r1,sp,#0x0	; 037FFD5E
	mov r2,#0x1	; 037FFD60
	bl loc_037FBD94	; 037FFD62
	ldrh r0,[r4,#0x20]	; 037FFD66
	cmp r0,#0x10	; 037FFD68
	bgt loc_037FFD86	; 037FFD6A
	cmp r0,#0x10	; 037FFD6C
	bge loc_037FFDF0	; 037FFD6E
	cmp r0,#0x1	; 037FFD70
	ble loc_037FFD76	; 037FFD72
	b loc_037FFF2C	; 037FFD74
loc_037FFD76:
	cmp r0,#0x0	; 037FFD76
	bge loc_037FFD7C	; 037FFD78
	b loc_037FFF2C	; 037FFD7A
loc_037FFD7C:
	cmp r0,#0x0	; 037FFD7C
	beq loc_037FFDCA	; 037FFD7E
	cmp r0,#0x1	; 037FFD80
	beq loc_037FFDDA	; 037FFD82
	b loc_037FFF2C	; 037FFD84
loc_037FFD86:
	add r1,r0,#0x0	; 037FFD86
	sub r1,#0x14	; 037FFD88
	cmp r1,#0x15	; 037FFD8A
	bls loc_037FFD90	; 037FFD8C
	b loc_037FFF2C	; 037FFD8E
loc_037FFD90:
	add r1,r1,r1	; 037FFD90
P2_SwitchIndexPC_037FFD90:
	add r1,pc	; 037FFD92
	ldrh r1,[r1,#(P2_SwitchTable_037FFD90 - (P2_SwitchIndexPC_037FFD90 + 4))]	; 037FFD94
	lsl r1,r1,#0x10	; 037FFD96
	asr r1,r1,#0x10	; 037FFD98
P2_SwitchTargetPC_037FFD90:
	add r1,pc	; 037FFD9A
	bx r1	; 037FFD9C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FFD90:
	.halfword (loc_037FFE02 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFE24 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFE46 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFE58 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFE6A + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFE7C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFE8E + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF2C + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFEA0 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFEC2 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFEE4 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFEF6 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF08 + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
	.halfword (loc_037FFF1A + 1) - (P2_SwitchTargetPC_037FFD90 + 4)
P2_SwitchTable_037FFD90End:
loc_037FFDCA:
	bl loc_038005B0	; 037FFDCA
	str r7,[r4,#0x1c]	; 037FFDCE
	add r0,r7,#0x0	; 037FFDD0
	add r1,r7,#0x0	; 037FFDD2
	bl loc_037FFF44	; 037FFDD4
	b loc_037FFD5C	; 037FFDD8
loc_037FFDDA:
	ldrh r0,[r5,#0x0]	; 037FFDDA
	lsl r0,r0,#0x1e	; 037FFDDC
	lsr r0,r0,#0x1f	; 037FFDDE
	bl loc_03800508	; 037FFDE0
	str r7,[r4,#0x1c]	; 037FFDE4
	mov r0,#0x1	; 037FFDE6
	add r1,r7,#0x0	; 037FFDE8
	bl loc_037FFF44	; 037FFDEA
	b loc_037FFD5C	; 037FFDEE
loc_037FFDF0:
	add r0,r5,#0x0	; 037FFDF0
	bl loc_038004E8	; 037FFDF2
	str r7,[r4,#0x1c]	; 037FFDF6
	mov r0,#0x10	; 037FFDF8
	add r1,r7,#0x0	; 037FFDFA
	bl loc_037FFF44	; 037FFDFC
	b loc_037FFD5C	; 037FFE00
loc_037FFE02:
	add r0,r5,#0x4	; 037FFE02
	bl loc_03800494	; 037FFE04
	cmp r0,#0x0	; 037FFE08
	bne loc_037FFE18	; 037FFE0A
	str r7,[r4,#0x1c]	; 037FFE0C
	mov r0,#0x14	; 037FFE0E
	mov r1,#0x2	; 037FFE10
	bl loc_037FFF44	; 037FFE12
	b loc_037FFD5C	; 037FFE16
loc_037FFE18:
	str r7,[r4,#0x1c]	; 037FFE18
	mov r0,#0x14	; 037FFE1A
	add r1,r7,#0x0	; 037FFE1C
	bl loc_037FFF44	; 037FFE1E
	b loc_037FFD5C	; 037FFE22
loc_037FFE24:
	add r0,r6,#0x0	; 037FFE24
	bl loc_0380042C	; 037FFE26
	cmp r0,#0x0	; 037FFE2A
	bne loc_037FFE3A	; 037FFE2C
	str r7,[r4,#0x1c]	; 037FFE2E
	mov r0,#0x15	; 037FFE30
	mov r1,#0x2	; 037FFE32
	bl loc_037FFF44	; 037FFE34
	b loc_037FFD5C	; 037FFE38
loc_037FFE3A:
	str r7,[r4,#0x1c]	; 037FFE3A
	mov r0,#0x15	; 037FFE3C
	add r1,r7,#0x0	; 037FFE3E
	bl loc_037FFF44	; 037FFE40
	b loc_037FFD5C	; 037FFE44
loc_037FFE46:
	add r0,r5,#0x0	; 037FFE46
	bl loc_038003D8	; 037FFE48
	str r7,[r4,#0x1c]	; 037FFE4C
	mov r0,#0x16	; 037FFE4E
	add r1,r7,#0x0	; 037FFE50
	bl loc_037FFF44	; 037FFE52
	b loc_037FFD5C	; 037FFE56
loc_037FFE58:
	add r0,r5,#0x2	; 037FFE58
	bl loc_03800398	; 037FFE5A
	str r7,[r4,#0x1c]	; 037FFE5E
	mov r0,#0x17	; 037FFE60
	add r1,r7,#0x0	; 037FFE62
	bl loc_037FFF44	; 037FFE64
	b loc_037FFD5C	; 037FFE68
loc_037FFE6A:
	add r0,r5,#0x4	; 037FFE6A
	bl loc_03800358	; 037FFE6C
	str r7,[r4,#0x1c]	; 037FFE70
	mov r0,#0x18	; 037FFE72
	add r1,r7,#0x0	; 037FFE74
	bl loc_037FFF44	; 037FFE76
	b loc_037FFD5C	; 037FFE7A
loc_037FFE7C:
	add r0,r5,#0x4	; 037FFE7C
	bl loc_03800318	; 037FFE7E
	str r7,[r4,#0x1c]	; 037FFE82
	mov r0,#0x19	; 037FFE84
	add r1,r7,#0x0	; 037FFE86
	bl loc_037FFF44	; 037FFE88
	b loc_037FFD5C	; 037FFE8C
loc_037FFE8E:
	add r0,r5,#0x0	; 037FFE8E
	bl loc_038004C8	; 037FFE90
	str r7,[r4,#0x1c]	; 037FFE94
	mov r0,#0x20	; 037FFE96
	add r1,r7,#0x0	; 037FFE98
	bl loc_037FFF44	; 037FFE9A
	b loc_037FFD5C	; 037FFE9E
loc_037FFEA0:
	add r0,r6,#0x0	; 037FFEA0
	bl loc_03800460	; 037FFEA2
	cmp r0,#0x0	; 037FFEA6
	bne loc_037FFEB6	; 037FFEA8
	str r7,[r4,#0x1c]	; 037FFEAA
	mov r0,#0x24	; 037FFEAC
	mov r1,#0x2	; 037FFEAE
	bl loc_037FFF44	; 037FFEB0
	b loc_037FFD5C	; 037FFEB4
loc_037FFEB6:
	str r7,[r4,#0x1c]	; 037FFEB6
	mov r0,#0x24	; 037FFEB8
	add r1,r7,#0x0	; 037FFEBA
	bl loc_037FFF44	; 037FFEBC
	b loc_037FFD5C	; 037FFEC0
loc_037FFEC2:
	add r0,r6,#0x0	; 037FFEC2
	bl loc_038003F8	; 037FFEC4
	cmp r0,#0x0	; 037FFEC8
	bne loc_037FFED8	; 037FFECA
	str r7,[r4,#0x1c]	; 037FFECC
	mov r0,#0x25	; 037FFECE
	mov r1,#0x2	; 037FFED0
	bl loc_037FFF44	; 037FFED2
	b loc_037FFD5C	; 037FFED6
loc_037FFED8:
	str r7,[r4,#0x1c]	; 037FFED8
	mov r0,#0x25	; 037FFEDA
	add r1,r7,#0x0	; 037FFEDC
	bl loc_037FFF44	; 037FFEDE
	b loc_037FFD5C	; 037FFEE2
loc_037FFEE4:
	add r0,r5,#0x0	; 037FFEE4
	bl loc_038003B8	; 037FFEE6
	str r7,[r4,#0x1c]	; 037FFEEA
	mov r0,#0x26	; 037FFEEC
	add r1,r7,#0x0	; 037FFEEE
	bl loc_037FFF44	; 037FFEF0
	b loc_037FFD5C	; 037FFEF4
loc_037FFEF6:
	add r0,r5,#0x2	; 037FFEF6
	bl loc_03800378	; 037FFEF8
	str r7,[r4,#0x1c]	; 037FFEFC
	mov r0,#0x27	; 037FFEFE
	add r1,r7,#0x0	; 037FFF00
	bl loc_037FFF44	; 037FFF02
	b loc_037FFD5C	; 037FFF06
loc_037FFF08:
	add r0,r5,#0x4	; 037FFF08
	bl loc_03800338	; 037FFF0A
	str r7,[r4,#0x1c]	; 037FFF0E
	mov r0,#0x28	; 037FFF10
	add r1,r7,#0x0	; 037FFF12
	bl loc_037FFF44	; 037FFF14
	b loc_037FFD5C	; 037FFF18
loc_037FFF1A:
	add r0,r5,#0x4	; 037FFF1A
	bl loc_038002F8	; 037FFF1C
	str r7,[r4,#0x1c]	; 037FFF20
	mov r0,#0x29	; 037FFF22
	add r1,r7,#0x0	; 037FFF24
	bl loc_037FFF44	; 037FFF26
	b loc_037FFD5C	; 037FFF2A
loc_037FFF2C:
	str r7,[r4,#0x1c]	; 037FFF2C
	mov r1,#0x1	; 037FFF2E
	bl loc_037FFF44	; 037FFF30
	b loc_037FFD5C	; 037FFF34
	.byte 0xC0, 0x46	; 037FFF38
pool_037FFF38:
loc_037FFF38:
	.word 0x027FFDE8	; 037FFF38
pool_037FFF3C:
loc_037FFF3C:
	.word 0x03804C68	; 037FFF3C
pool_037FFF40:
loc_037FFF40:
	.word 0x03804AE8	; 037FFF40

; ===== function loc_037FFF44 =====
loc_037FFF44:
	add r2,r0,#0x0	; 037FFF44
	mov r0,#0x5	; 037FFF46
	lsl r3,r2,#0x8	; 037FFF48
	ldr r2,[pool_037FFF60]	; 037FFF4A
	and r3,r2	; 037FFF4C
	ldr r2,[pool_037FFF64]	; 037FFF4E
	orr r3,r2	; 037FFF50
	mov r2,#0xff	; 037FFF52
	and r1,r2	; 037FFF54
	orr r3,r1	; 037FFF56
	add r1,r3,#0x0	; 037FFF58
	mov r2,#0x0	; 037FFF5A
	ldr r3,[pool_037FFF68]	; 037FFF5C
	bx r3	; 037FFF5E
pool_037FFF60:
loc_037FFF60:
	.word 0x00007F00	; 037FFF60
pool_037FFF64:
loc_037FFF64:
	.word 0x00008000	; 037FFF64
pool_037FFF68:
loc_037FFF68:
	.word loc_037FFA18 + 1	; 037FFF68
P2_PxiCallback_037FFF6C:
	push {r4,lr}	; 037FFF6C
	cmp r2,#0x0	; 037FFF6E
	bne P2_Entry_0380000E	; 037FFF70
	ldr r0,[pool_03800014]	; 037FFF72
	and r1,r0	; 037FFF74
	lsl r0,r1,#0x8	; 037FFF76
	lsr r4,r0,#0x10	; 037FFF78
	cmp r4,#0x10	; 037FFF7A
	bgt P2_Entry_037FFF94	; 037FFF7C
	cmp r4,#0x10	; 037FFF7E
	bge P2_Entry_037FFFD6	; 037FFF80
	cmp r4,#0x1	; 037FFF82
	bgt P2_Entry_03800006	; 037FFF84
	cmp r4,#0x0	; 037FFF86
	blt P2_Entry_03800006	; 037FFF88
	cmp r4,#0x0	; 037FFF8A
	beq P2_Entry_037FFFD6	; 037FFF8C
	cmp r4,#0x1	; 037FFF8E
	beq P2_Entry_037FFFD6	; 037FFF90
	b P2_Entry_03800006	; 037FFF92
P2_Entry_037FFF94:
	add r0,r4,#0x0	; 037FFF94
	sub r0,#0x14	; 037FFF96
	cmp r0,#0x15	; 037FFF98
	bhi P2_Entry_03800006	; 037FFF9A
	add r0,r0,r0	; 037FFF9C
P2_SwitchIndexPC_037FFF9C:
	add r0,pc	; 037FFF9E
	ldrh r0,[r0,#(P2_SwitchTable_037FFF9C - (P2_SwitchIndexPC_037FFF9C + 4))]	; 037FFFA0
	lsl r0,r0,#0x10	; 037FFFA2
	asr r0,r0,#0x10	; 037FFFA4
P2_SwitchTargetPC_037FFF9C:
	add r0,pc	; 037FFFA6
	bx r0	; 037FFFA8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FFF9C:
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_03800006 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
	.halfword (P2_Entry_037FFFD6 + 1) - (P2_SwitchTargetPC_037FFF9C + 4)
P2_SwitchTable_037FFF9CEnd:
P2_Entry_037FFFD6:
	ldr r0,[pool_03800018]	; 037FFFD6
	ldr r1,[r0,#0x1c]	; 037FFFD8
	cmp r1,#0x0	; 037FFFDA
	beq P2_Entry_037FFFE8	; 037FFFDC
	add r0,r4,#0x0	; 037FFFDE
	mov r1,#0x3	; 037FFFE0
	bl loc_037FFF44	; 037FFFE2
	b P2_Entry_0380000E	; 037FFFE6
P2_Entry_037FFFE8:
	mov r1,#0x1	; 037FFFE8
	str r1,[r0,#0x1c]	; 037FFFEA
	strh r4,[r0,#0x20]	; 037FFFEC
	ldr r0,[pool_0380001C]	; 037FFFEE
	mov r1,#0x0	; 037FFFF0
	add r2,r1,#0x0	; 037FFFF2
	bl loc_037FBE10	; 037FFFF4
	cmp r0,#0x0	; 037FFFF8
	bne P2_Entry_0380000E	; 037FFFFA
	add r0,r4,#0x0	; 037FFFFC
	mov r1,#0x4	; 037FFFFE
	bl loc_037FFF44	; 03800000
	b P2_Entry_0380000E	; 03800004
P2_Entry_03800006:
	add r0,r4,#0x0	; 03800006
	mov r1,#0x1	; 03800008
	bl loc_037FFF44	; 0380000A
P2_Entry_0380000E:
	pop {r4}	; 0380000E
	pop {r3}	; 03800010
	bx r3	; 03800012
pool_03800014:
	.word 0x00007F00	; 03800014
pool_03800018:
	.word P2_BssStart + 0x1F60	; 03800018
pool_0380001C:
	.word 0x03804AE8	; 0380001C

; ===== function loc_03800020 =====
loc_03800020:
	push {r4,lr}	; 03800020
	sub sp,#0x10	; 03800022
	add r4,r0,#0x0	; 03800024
	mov r1,#0x1	; 03800026
	ldr r0,[pool_038000BC]	; 03800028
	strh r1,[r0,#0x0]	; 0380002A
	ldr r0,[pool_038000C0]	; 0380002C
	str r1,[r0,#0x1c]	; 0380002E
	bl loc_037FFC54	; 03800030
	mov r1,#0x0	; 03800034
	ldr r0,[pool_038000C0]	; 03800036
	str r1,[r0,#0x1c]	; 03800038
	bl loc_037FF938	; 0380003A
	mov r0,#0x5	; 0380003E
	ldr r1,[pool_038000C4]	; 03800040
	bl P2_SetPxiReceiveCallback	; 03800042
	ldr r0,[pool_038000C8]	; 03800046
	ldr r1,[pool_038000CC]	; 03800048
	mov r2,#0x4	; 0380004A
	bl loc_037FBE70	; 0380004C
	ldr r0,[pool_038000D0]	; 03800050
	str r0,[sp,#0x0]	; 03800052
	str r4,[sp,#0x4]	; 03800054
	ldr r0,[pool_038000D4]	; 03800056
	ldr r1,[pool_038000D8]	; 03800058
	mov r2,#0x0	; 0380005A
	ldr r3,[pool_038000DC]	; 0380005C
	bl P2_CreateThread	; 0380005E
	ldr r0,[pool_038000D4]	; 03800062
	bl loc_037FB9EC	; 03800064
	mov r2,#0x0	; 03800068
	ldr r0,[pool_038000E0]	; 0380006A
	strh r2,[r0,#0x1c]	; 0380006C
	ldr r0,[pool_038000D0]	; 0380006E
	str r0,[sp,#0x0]	; 03800070
	sub r0,r4,#0x1	; 03800072
	str r0,[sp,#0x4]	; 03800074
	ldr r0,[pool_038000E4]	; 03800076
	ldr r1,[pool_038000E8]	; 03800078
	ldr r3,[pool_038000EC]	; 0380007A
	bl P2_CreateThread	; 0380007C
	ldr r0,[pool_038000E4]	; 03800080
	bl loc_037FB9EC	; 03800082
	bl loc_037FC780	; 03800086
	cmp r0,#0x0	; 0380008A
	bne loc_03800092	; 0380008C
	bl loc_037FC78C	; 0380008E
loc_03800092:
	ldr r0,[pool_038000EC]	; 03800092
	bl loc_037FC778	; 03800094
	bl loc_037FC3AC	; 03800098
	add r4,r0,#0x0	; 0380009C
	add r2,r1,#0x0	; 0380009E
	ldr r0,[pool_038000F0]	; 038000A0
	str r0,[sp,#0x4]	; 038000A2
	mov r0,#0x0	; 038000A4
	str r0,[sp,#0x8]	; 038000A6
	ldr r3,[pool_038000F4]	; 038000A8
	str r0,[sp,#0x0]	; 038000AA
	ldr r0,[pool_038000EC]	; 038000AC
	add r1,r4,#0x0	; 038000AE
	bl loc_037FC5FC	; 038000B0
	add sp,#0x10	; 038000B4
	pop {r4}	; 038000B6
	pop {r3}	; 038000B8
	bx r3	; 038000BA
pool_038000BC:
loc_038000BC:
	.word P2_BssStart + 0x1DDC	; 038000BC
pool_038000C0:
loc_038000C0:
	.word P2_BssStart + 0x1F60	; 038000C0
pool_038000C4:
loc_038000C4:
	.word P2_PxiCallback_037FFF6C + 1	; 038000C4
pool_038000C8:
loc_038000C8:
	.word 0x03804AE8	; 038000C8
pool_038000CC:
loc_038000CC:
	.word 0x03804AFC	; 038000CC
pool_038000D0:
loc_038000D0:
	.word 0x00000100	; 038000D0
pool_038000D4:
loc_038000D4:
	.word 0x03804B0C	; 038000D4
pool_038000D8:
loc_038000D8:
	.word P2_ThreadEntry_037FFD50 + 1	; 038000D8
pool_038000DC:
loc_038000DC:
	.word 0x03804C84	; 038000DC
pool_038000E0:
loc_038000E0:
	.word P2_BssStart + 0x1FE0	; 038000E0
pool_038000E4:
loc_038000E4:
	.word 0x03804C8C	; 038000E4
pool_038000E8:
loc_038000E8:
	.word P2_ThreadEntry_037FFCB4 + 1	; 038000E8
pool_038000EC:
loc_038000EC:
	.word 0x03804E08	; 038000EC
pool_038000F0:
loc_038000F0:
	.word P2_Code_037FFCA4 + 1	; 038000F0
pool_038000F4:
loc_038000F4:
	.word 0x00001388	; 038000F4

; ===== function loc_038000F8 =====
loc_038000F8:
	push {r4,r5,r6,r7,lr}	; 038000F8
	sub sp,#0x4	; 038000FA
	add r5,r0,#0x0	; 038000FC
	add r7,r1,#0x0	; 038000FE
	add r4,r2,#0x0	; 03800100
	add r6,r3,#0x0	; 03800102
	bl loc_03800138	; 03800104
	add r0,r5,#0x0	; 03800108
	add r1,r7,#0x0	; 0380010A
	bl loc_03800144	; 0380010C
	cmp r5,#0x6	; 03800110
	beq loc_03800122	; 03800112
	cmp r5,#0x86	; 03800114
	bne loc_0380012A	; 03800116
	add r0,r4,#0x0	; 03800118
	add r1,r6,#0x0	; 0380011A
	bl loc_03800150	; 0380011C
	b loc_0380012A	; 03800120
loc_03800122:
	add r0,r4,#0x0	; 03800122
	add r1,r6,#0x0	; 03800124
	bl loc_0380015C	; 03800126
loc_0380012A:
	bl loc_03800168	; 0380012A
	add sp,#0x4	; 0380012E
	pop {r4,r5,r6,r7}	; 03800130
	pop {r3}	; 03800132
	bx r3	; 03800134
	.byte 0xC0, 0x46	; 03800138

; ===== function loc_03800138 =====
loc_03800138:
	bx pc	; 03800138
	.byte 0xC0, 0x46	; 0380013C
.arm

; ===== function loc_0380013C =====
loc_0380013C:
	ldr pc,[pool_03800140]	; 0380013C
pool_03800140:
loc_03800140:
	.word loc_038005DC	; 03800140
.thumb

; ===== function loc_03800144 =====
loc_03800144:
	bx pc	; 03800144
	.byte 0xC0, 0x46	; 03800148
.arm

; ===== function loc_03800148 =====
loc_03800148:
	ldr pc,[pool_0380014C]	; 03800148
pool_0380014C:
loc_0380014C:
	.word loc_03800650	; 0380014C
.thumb

; ===== function loc_03800150 =====
loc_03800150:
	bx pc	; 03800150
	.byte 0xC0, 0x46	; 03800154
.arm

; ===== function loc_03800154 =====
loc_03800154:
	ldr pc,[pool_03800158]	; 03800154
pool_03800158:
loc_03800158:
	.word loc_03800750	; 03800158
.thumb

; ===== function loc_0380015C =====
loc_0380015C:
	bx pc	; 0380015C
	.byte 0xC0, 0x46	; 03800160
.arm

; ===== function loc_03800160 =====
loc_03800160:
	ldr pc,[pool_03800164]	; 03800160
pool_03800164:
loc_03800164:
	.word loc_038006C0	; 03800164
.thumb

; ===== function loc_03800168 =====
loc_03800168:
	bx pc	; 03800168
	.byte 0xC0, 0x46	; 0380016C
.arm

; ===== function loc_0380016C =====
loc_0380016C:
	ldr pc,[pool_03800170]	; 0380016C
pool_03800170:
loc_03800170:
	.word loc_0380061C	; 03800170
.thumb

; ===== function loc_03800174 =====
loc_03800174:
	ldr r1,[r0,#0x0]	; 03800174
	lsl r2,r1,#0x12	; 03800176
	lsr r2,r2,#0x1a	; 03800178
	cmp r2,#0x23	; 0380017A
	bhi loc_03800210	; 0380017C
	add r3,r2,r2	; 0380017E
P2_SwitchIndexPC_0380017E:
	add r3,pc	; 03800180
	ldrh r3,[r3,#(P2_SwitchTable_0380017E - (P2_SwitchIndexPC_0380017E + 4))]	; 03800182
	lsl r3,r3,#0x10	; 03800184
	asr r3,r3,#0x10	; 03800186
P2_SwitchTargetPC_0380017E:
	add r3,pc	; 03800188
	bx r3	; 0380018A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380017E:
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001EE + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001EE + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_038001D4 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800210 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
	.halfword (loc_03800208 + 1) - (P2_SwitchTargetPC_0380017E + 4)
P2_SwitchTable_0380017EEnd:
loc_038001D4:
	lsl r3,r1,#0x11	; 038001D4
	lsr r3,r3,#0x1f	; 038001D6
	cmp r3,#0x0	; 038001D8
	beq loc_03800220	; 038001DA
	ldr r3,[pool_03800224]	; 038001DC
	and r1,r3	; 038001DE
	add r2,#0x12	; 038001E0
	mov r3,#0x3f	; 038001E2
	and r2,r3	; 038001E4
	lsl r2,r2,#0x8	; 038001E6
	orr r1,r2	; 038001E8
	str r1,[r0,#0x0]	; 038001EA
	bx lr	; 038001EC
loc_038001EE:
	lsl r3,r1,#0x11	; 038001EE
	lsr r3,r3,#0x1f	; 038001F0
	cmp r3,#0x0	; 038001F2
	beq loc_03800220	; 038001F4
	ldr r3,[pool_03800224]	; 038001F6
	and r1,r3	; 038001F8
	add r2,#0x18	; 038001FA
	mov r3,#0x3f	; 038001FC
	and r2,r3	; 038001FE
	lsl r2,r2,#0x8	; 03800200
	orr r1,r2	; 03800202
	str r1,[r0,#0x0]	; 03800204
	bx lr	; 03800206
loc_03800208:
	ldr r2,[pool_03800228]	; 03800208
	orr r1,r2	; 0380020A
	str r1,[r0,#0x0]	; 0380020C
	bx lr	; 0380020E
loc_03800210:
	ldr r2,[r0,#0x0]	; 03800210
	ldr r1,[pool_0380022C]	; 03800212
	and r2,r1	; 03800214
	str r2,[r0,#0x0]	; 03800216
	ldr r2,[r0,#0x0]	; 03800218
	ldr r1,[pool_03800224]	; 0380021A
	and r2,r1	; 0380021C
	str r2,[r0,#0x0]	; 0380021E
loc_03800220:
	bx lr	; 03800220
	.byte 0xC0, 0x46	; 03800224
pool_03800224:
loc_03800224:
	.word 0xFFFFC0FF	; 03800224
pool_03800228:
loc_03800228:
	.word 0x00004000	; 03800228
pool_0380022C:
loc_0380022C:
	.word 0xFFFFBFFF	; 0380022C

; ===== function loc_03800230 =====
loc_03800230:
	ldr r1,[r0,#0x0]	; 03800230
	lsl r2,r1,#0x12	; 03800232
	lsr r2,r2,#0x1a	; 03800234
	cmp r2,#0x23	; 03800236
	bhi loc_038002D8	; 03800238
	add r2,r2,r2	; 0380023A
P2_SwitchIndexPC_0380023A:
	add r2,pc	; 0380023C
	ldrh r2,[r2,#(P2_SwitchTable_0380023A - (P2_SwitchIndexPC_0380023A + 4))]	; 0380023E
	lsl r2,r2,#0x10	; 03800240
	asr r2,r2,#0x10	; 03800242
P2_SwitchTargetPC_0380023A:
	add r2,pc	; 03800244
	bx r2	; 03800246
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380023A:
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800290 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002D8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002B8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_038002B8 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
	.halfword (loc_03800298 + 1) - (P2_SwitchTargetPC_0380023A + 4)
P2_SwitchTable_0380023AEnd:
loc_03800290:
	ldr r2,[pool_038002EC]	; 03800290
	and r1,r2	; 03800292
	str r1,[r0,#0x0]	; 03800294
	bx lr	; 03800296
loc_03800298:
	ldr r2,[pool_038002F0]	; 03800298
	orr r1,r2	; 0380029A
	str r1,[r0,#0x0]	; 0380029C
	ldr r2,[r0,#0x0]	; 0380029E
	ldr r1,[pool_038002F4]	; 038002A0
	add r3,r2,#0x0	; 038002A2
	and r3,r1	; 038002A4
	lsl r1,r2,#0x12	; 038002A6
	lsr r2,r1,#0x1a	; 038002A8
	sub r2,#0x12	; 038002AA
	mov r1,#0x3f	; 038002AC
	and r2,r1	; 038002AE
	lsl r1,r2,#0x8	; 038002B0
	orr r3,r1	; 038002B2
	str r3,[r0,#0x0]	; 038002B4
	bx lr	; 038002B6
loc_038002B8:
	ldr r2,[pool_038002F0]	; 038002B8
	orr r1,r2	; 038002BA
	str r1,[r0,#0x0]	; 038002BC
	ldr r2,[r0,#0x0]	; 038002BE
	ldr r1,[pool_038002F4]	; 038002C0
	add r3,r2,#0x0	; 038002C2
	and r3,r1	; 038002C4
	lsl r1,r2,#0x12	; 038002C6
	lsr r2,r1,#0x1a	; 038002C8
	sub r2,#0x18	; 038002CA
	mov r1,#0x3f	; 038002CC
	and r2,r1	; 038002CE
	lsl r1,r2,#0x8	; 038002D0
	orr r3,r1	; 038002D2
	str r3,[r0,#0x0]	; 038002D4
	bx lr	; 038002D6
loc_038002D8:
	ldr r2,[r0,#0x0]	; 038002D8
	ldr r1,[pool_038002EC]	; 038002DA
	and r2,r1	; 038002DC
	str r2,[r0,#0x0]	; 038002DE
	ldr r2,[r0,#0x0]	; 038002E0
	ldr r1,[pool_038002F4]	; 038002E2
	and r2,r1	; 038002E4
	str r2,[r0,#0x0]	; 038002E6
	bx lr	; 038002E8
	.byte 0xC0, 0x46	; 038002EC
pool_038002EC:
loc_038002EC:
	.word 0xFFFFBFFF	; 038002EC
pool_038002F0:
loc_038002F0:
	.word 0x00004000	; 038002F0
pool_038002F4:
loc_038002F4:
	.word 0xFFFFC0FF	; 038002F4

; ===== function loc_038002F8 =====
loc_038002F8:
	push {r4,lr}	; 038002F8
	add r4,r0,#0x0	; 038002FA
	ldr r0,[pool_03800314]	; 038002FC
	bl loc_037FFC2C	; 038002FE
	mov r0,#0x6	; 03800302
	mov r1,#0x70	; 03800304
	add r2,r4,#0x0	; 03800306
	mov r3,#0x1	; 03800308
	bl loc_038000F8	; 0380030A
	pop {r4}	; 0380030E
	pop {r3}	; 03800310
	bx r3	; 03800312
pool_03800314:
loc_03800314:
	.word 0x00008000	; 03800314

; ===== function loc_03800318 =====
loc_03800318:
	push {r4,lr}	; 03800318
	add r4,r0,#0x0	; 0380031A
	ldr r0,[pool_03800334]	; 0380031C
	bl loc_037FFC2C	; 0380031E
	mov r0,#0x86	; 03800322
	mov r1,#0x70	; 03800324
	add r2,r4,#0x0	; 03800326
	mov r3,#0x1	; 03800328
	bl loc_038000F8	; 0380032A
	pop {r4}	; 0380032E
	pop {r3}	; 03800330
	bx r3	; 03800332
pool_03800334:
loc_03800334:
	.word 0x00008000	; 03800334

; ===== function loc_03800338 =====
loc_03800338:
	push {r4,lr}	; 03800338
	add r4,r0,#0x0	; 0380033A
	ldr r0,[pool_03800354]	; 0380033C
	bl loc_037FFC2C	; 0380033E
	mov r0,#0x6	; 03800342
	mov r1,#0x30	; 03800344
	add r2,r4,#0x0	; 03800346
	mov r3,#0x1	; 03800348
	bl loc_038000F8	; 0380034A
	pop {r4}	; 0380034E
	pop {r3}	; 03800350
	bx r3	; 03800352
pool_03800354:
loc_03800354:
	.word 0x00008000	; 03800354

; ===== function loc_03800358 =====
loc_03800358:
	push {r4,lr}	; 03800358
	add r4,r0,#0x0	; 0380035A
	ldr r0,[pool_03800374]	; 0380035C
	bl loc_037FFC2C	; 0380035E
	mov r0,#0x86	; 03800362
	mov r1,#0x30	; 03800364
	add r2,r4,#0x0	; 03800366
	mov r3,#0x1	; 03800368
	bl loc_038000F8	; 0380036A
	pop {r4}	; 0380036E
	pop {r3}	; 03800370
	bx r3	; 03800372
pool_03800374:
loc_03800374:
	.word 0x00008000	; 03800374

; ===== function loc_03800378 =====
loc_03800378:
	push {r4,lr}	; 03800378
	add r4,r0,#0x0	; 0380037A
	ldr r0,[pool_03800394]	; 0380037C
	bl loc_037FFC2C	; 0380037E
	mov r0,#0x6	; 03800382
	mov r1,#0x40	; 03800384
	add r2,r4,#0x0	; 03800386
	mov r3,#0x1	; 03800388
	bl loc_038000F8	; 0380038A
	pop {r4}	; 0380038E
	pop {r3}	; 03800390
	bx r3	; 03800392
pool_03800394:
loc_03800394:
	.word 0x00008000	; 03800394

; ===== function loc_03800398 =====
loc_03800398:
	push {r4,lr}	; 03800398
	add r4,r0,#0x0	; 0380039A
	ldr r0,[pool_038003B4]	; 0380039C
	bl loc_037FFC2C	; 0380039E
	mov r0,#0x86	; 038003A2
	mov r1,#0x40	; 038003A4
	add r2,r4,#0x0	; 038003A6
	mov r3,#0x1	; 038003A8
	bl loc_038000F8	; 038003AA
	pop {r4}	; 038003AE
	pop {r3}	; 038003B0
	bx r3	; 038003B2
pool_038003B4:
loc_038003B4:
	.word 0x00008000	; 038003B4

; ===== function loc_038003B8 =====
loc_038003B8:
	push {r4,lr}	; 038003B8
	add r4,r0,#0x0	; 038003BA
	ldr r0,[pool_038003D4]	; 038003BC
	bl loc_037FFC2C	; 038003BE
	mov r0,#0x6	; 038003C2
	mov r1,#0x0	; 038003C4
	add r2,r4,#0x0	; 038003C6
	mov r3,#0x1	; 038003C8
	bl loc_038000F8	; 038003CA
	pop {r4}	; 038003CE
	pop {r3}	; 038003D0
	bx r3	; 038003D2
pool_038003D4:
loc_038003D4:
	.word 0x00008000	; 038003D4

; ===== function loc_038003D8 =====
loc_038003D8:
	push {r4,lr}	; 038003D8
	add r4,r0,#0x0	; 038003DA
	ldr r0,[pool_038003F4]	; 038003DC
	bl loc_037FFC2C	; 038003DE
	mov r0,#0x86	; 038003E2
	mov r1,#0x0	; 038003E4
	add r2,r4,#0x0	; 038003E6
	mov r3,#0x1	; 038003E8
	bl loc_038000F8	; 038003EA
	pop {r4}	; 038003EE
	pop {r3}	; 038003F0
	bx r3	; 038003F2
pool_038003F4:
loc_038003F4:
	.word 0x00008000	; 038003F4

; ===== function loc_038003F8 =====
loc_038003F8:
	push {r4,lr}	; 038003F8
	sub sp,#0x8	; 038003FA
	add r4,r0,#0x0	; 038003FC
	add r0,sp,#0x0	; 038003FE
	bl loc_03800398	; 03800400
	add r0,sp,#0x0	; 03800404
	ldrh r0,[r0,#0x0]	; 03800406
	lsl r0,r0,#0x19	; 03800408
	lsr r0,r0,#0x1f	; 0380040A
	cmp r0,#0x0	; 0380040C
	beq loc_03800420	; 0380040E
	mov r0,#0x6	; 03800410
	mov r1,#0x50	; 03800412
	add r2,r4,#0x0	; 03800414
	mov r3,#0x3	; 03800416
	bl loc_038000F8	; 03800418
	mov r0,#0x1	; 0380041C
	b loc_03800422	; 0380041E
loc_03800420:
	mov r0,#0x0	; 03800420
loc_03800422:
	add sp,#0x8	; 03800422
	pop {r4}	; 03800424
	pop {r3}	; 03800426
	bx r3	; 03800428
	.byte 0x00, 0x00	; 0380042C

; ===== function loc_0380042C =====
loc_0380042C:
	push {r4,lr}	; 0380042C
	sub sp,#0x8	; 0380042E
	add r4,r0,#0x0	; 03800430
	add r0,sp,#0x0	; 03800432
	bl loc_03800398	; 03800434
	add r0,sp,#0x0	; 03800438
	ldrh r0,[r0,#0x0]	; 0380043A
	lsl r0,r0,#0x19	; 0380043C
	lsr r0,r0,#0x1f	; 0380043E
	cmp r0,#0x0	; 03800440
	beq loc_03800454	; 03800442
	mov r0,#0x86	; 03800444
	mov r1,#0x50	; 03800446
	add r2,r4,#0x0	; 03800448
	mov r3,#0x3	; 0380044A
	bl loc_038000F8	; 0380044C
	mov r0,#0x1	; 03800450
	b loc_03800456	; 03800452
loc_03800454:
	mov r0,#0x0	; 03800454
loc_03800456:
	add sp,#0x8	; 03800456
	pop {r4}	; 03800458
	pop {r3}	; 0380045A
	bx r3	; 0380045C
	.byte 0x00, 0x00	; 03800460

; ===== function loc_03800460 =====
loc_03800460:
	push {r4,lr}	; 03800460
	sub sp,#0x8	; 03800462
	add r4,r0,#0x0	; 03800464
	add r0,sp,#0x0	; 03800466
	bl loc_03800398	; 03800468
	add r0,sp,#0x0	; 0380046C
	ldrh r0,[r0,#0x0]	; 0380046E
	lsl r0,r0,#0x1c	; 03800470
	lsr r0,r0,#0x1c	; 03800472
	cmp r0,#0x4	; 03800474
	bne loc_03800488	; 03800476
	mov r0,#0x6	; 03800478
	mov r1,#0x10	; 0380047A
	add r2,r4,#0x0	; 0380047C
	mov r3,#0x3	; 0380047E
	bl loc_038000F8	; 03800480
	mov r0,#0x1	; 03800484
	b loc_0380048A	; 03800486
loc_03800488:
	mov r0,#0x0	; 03800488
loc_0380048A:
	add sp,#0x8	; 0380048A
	pop {r4}	; 0380048C
	pop {r3}	; 0380048E
	bx r3	; 03800490
	.byte 0x00, 0x00	; 03800494

; ===== function loc_03800494 =====
loc_03800494:
	push {r4,lr}	; 03800494
	sub sp,#0x8	; 03800496
	add r4,r0,#0x0	; 03800498
	add r0,sp,#0x0	; 0380049A
	bl loc_03800398	; 0380049C
	add r0,sp,#0x0	; 038004A0
	ldrh r0,[r0,#0x0]	; 038004A2
	lsl r0,r0,#0x1c	; 038004A4
	lsr r0,r0,#0x1c	; 038004A6
	cmp r0,#0x4	; 038004A8
	bne loc_038004BC	; 038004AA
	mov r0,#0x86	; 038004AC
	mov r1,#0x10	; 038004AE
	add r2,r4,#0x0	; 038004B0
	mov r3,#0x3	; 038004B2
	bl loc_038000F8	; 038004B4
	mov r0,#0x1	; 038004B8
	b loc_038004BE	; 038004BA
loc_038004BC:
	mov r0,#0x0	; 038004BC
loc_038004BE:
	add sp,#0x8	; 038004BE
	pop {r4}	; 038004C0
	pop {r3}	; 038004C2
	bx r3	; 038004C4
	.byte 0x00, 0x00	; 038004C8

; ===== function loc_038004C8 =====
loc_038004C8:
	push {r4,lr}	; 038004C8
	add r4,r0,#0x0	; 038004CA
	ldr r0,[pool_038004E4]	; 038004CC
	bl loc_037FFC2C	; 038004CE
	mov r0,#0x6	; 038004D2
	mov r1,#0x20	; 038004D4
	add r2,r4,#0x0	; 038004D6
	mov r3,#0x7	; 038004D8
	bl loc_038000F8	; 038004DA
	pop {r4}	; 038004DE
	pop {r3}	; 038004E0
	bx r3	; 038004E2
pool_038004E4:
loc_038004E4:
	.word 0x00008000	; 038004E4

; ===== function loc_038004E8 =====
loc_038004E8:
	push {r4,lr}	; 038004E8
	add r4,r0,#0x0	; 038004EA
	ldr r0,[pool_03800504]	; 038004EC
	bl loc_037FFC2C	; 038004EE
	mov r0,#0x86	; 038004F2
	mov r1,#0x20	; 038004F4
	add r2,r4,#0x0	; 038004F6
	mov r3,#0x7	; 038004F8
	bl loc_038000F8	; 038004FA
	pop {r4}	; 038004FE
	pop {r3}	; 03800500
	bx r3	; 03800502
pool_03800504:
loc_03800504:
	.word 0x00008000	; 03800504

; ===== function loc_03800508 =====
loc_03800508:
	push {r4,r5,lr}	; 03800508
	sub sp,#0xc	; 0380050A
	add r5,r0,#0x0	; 0380050C
	mov r0,#0x1	; 0380050E
	add r4,r5,#0x0	; 03800510
	and r4,r0	; 03800512
	lsl r0,r4,#0x10	; 03800514
	lsr r0,r0,#0x10	; 03800516
	cmp r0,#0x1	; 03800518
	bne loc_038005A8	; 0380051A
	add r0,sp,#0x0	; 0380051C
	bl loc_038003D8	; 0380051E
	add r0,sp,#0x0	; 03800522
	ldrh r1,[r0,#0x0]	; 03800524
	lsl r2,r1,#0x1e	; 03800526
	lsr r3,r2,#0x1f	; 03800528
	lsl r2,r4,#0x10	; 0380052A
	lsr r2,r2,#0x10	; 0380052C
	cmp r3,r2	; 0380052E
	beq loc_038005A8	; 03800530
	mov r3,#0x1	; 03800532
	and r5,r3	; 03800534
	mov r2,#0x2	; 03800536
	bic r1,r2	; 03800538
	lsl r2,r5,#0x10	; 0380053A
	lsr r2,r2,#0x10	; 0380053C
	and r2,r3	; 0380053E
	lsl r2,r2,#0x1	; 03800540
	orr r1,r2	; 03800542
	strh r1,[r0,#0x0]	; 03800544
	add r0,sp,#0x0	; 03800546
	bl loc_038003B8	; 03800548
	mov r0,#0x86	; 0380054C
	mov r1,#0x10	; 0380054E
	add r2,sp,#0x4	; 03800550
	mov r3,#0x3	; 03800552
	bl loc_038000F8	; 03800554
	lsl r0,r5,#0x10	; 03800558
	lsr r0,r0,#0x10	; 0380055A
	cmp r0,#0x0	; 0380055C
	bne loc_03800568	; 0380055E
	add r0,sp,#0x4	; 03800560
	bl loc_03800230	; 03800562
	b loc_0380056E	; 03800566
loc_03800568:
	add r0,sp,#0x4	; 03800568
	bl loc_03800174	; 0380056A
loc_0380056E:
	mov r0,#0x6	; 0380056E
	mov r1,#0x10	; 03800570
	add r2,sp,#0x4	; 03800572
	mov r3,#0x3	; 03800574
	bl loc_038000F8	; 03800576
	mov r0,#0x86	; 0380057A
	mov r1,#0x50	; 0380057C
	add r2,sp,#0x4	; 0380057E
	mov r3,#0x3	; 03800580
	bl loc_038000F8	; 03800582
	lsl r0,r4,#0x10	; 03800586
	lsr r0,r0,#0x10	; 03800588
	cmp r0,#0x0	; 0380058A
	bne loc_03800596	; 0380058C
	add r0,sp,#0x4	; 0380058E
	bl loc_03800230	; 03800590
	b loc_0380059C	; 03800594
loc_03800596:
	add r0,sp,#0x4	; 03800596
	bl loc_03800174	; 03800598
loc_0380059C:
	mov r0,#0x6	; 0380059C
	mov r1,#0x50	; 0380059E
	add r2,sp,#0x4	; 038005A0
	mov r3,#0x3	; 038005A2
	bl loc_038000F8	; 038005A4
loc_038005A8:
	add sp,#0xc	; 038005A8
	pop {r4,r5}	; 038005AA
	pop {r3}	; 038005AC
	bx r3	; 038005AE

; ===== function loc_038005B0 =====
loc_038005B0:
	push {lr}	; 038005B0
	sub sp,#0x4	; 038005B2
	ldr r0,[pool_038005D8]	; 038005B4
	bl loc_037FFC2C	; 038005B6
	add r0,sp,#0x0	; 038005BA
	ldrh r1,[r0,#0x0]	; 038005BC
	mov r3,#0x1	; 038005BE
	bic r1,r3	; 038005C0
	orr r1,r3	; 038005C2
	strh r1,[r0,#0x0]	; 038005C4
	mov r0,#0x6	; 038005C6
	mov r1,#0x0	; 038005C8
	add r2,sp,#0x0	; 038005CA
	bl loc_038000F8	; 038005CC
	add sp,#0x4	; 038005D0
	pop {r3}	; 038005D2
	bx r3	; 038005D4
	.byte 0xC0, 0x46	; 038005D8
pool_038005D8:
loc_038005D8:
	.word 0x00008000	; 038005D8
.arm

; ===== function loc_038005DC =====
loc_038005DC:
	mov r12,#0x4000000	; 038005DC
	add r12,r12,#0x138	; 038005E0
	ldrh r0,[r12,#0x0]	; 038005E4
	bic r0,r0,#0x77	; 038005E8
	orr r0,r0,#0x72	; 038005EC
	strh r0,[r12,#0x0]	; 038005F0
	mov r3,#0x2	; 038005F4
loc_038005F8:
	subs r3,r3,#0x1	; 038005F8
	bne loc_038005F8	; 038005FC
	bic r0,r0,#0x4	; 03800600
	orr r0,r0,#0x4	; 03800604
	strh r0,[r12,#0x0]	; 03800608
	mov r3,#0x2	; 0380060C
loc_03800610:
	subs r3,r3,#0x1	; 03800610
	bne loc_03800610	; 03800614
	bx lr	; 03800618

; ===== function loc_0380061C =====
loc_0380061C:
	mov r12,#0x4000000	; 0380061C
	add r12,r12,#0x138	; 03800620
	mov r3,#0x2	; 03800624
loc_03800628:
	subs r3,r3,#0x1	; 03800628
	bne loc_03800628	; 0380062C
	ldrh r0,[r12,#0x0]	; 03800630
	bic r0,r0,#0x4	; 03800634
	orr r0,r0,#0x0	; 03800638
	strh r0,[r12,#0x0]	; 0380063C
	mov r3,#0x2	; 03800640
loc_03800644:
	subs r3,r3,#0x1	; 03800644
	bne loc_03800644	; 03800648
	bx lr	; 0380064C

; ===== function loc_03800650 =====
loc_03800650:
	mov r12,#0x4000000	; 03800650
	add r12,r12,#0x138	; 03800654
	orr r1,r0,r1	; 03800658
	ldrh r0,[r12,#0x0]	; 0380065C
	bic r0,r0,#0x77	; 03800660
	orr r0,r0,#0x74	; 03800664
	mov r2,#0x0	; 03800668
loc_0380066C:
	bic r0,r0,#0x3	; 0380066C
	orr r0,r0,#0x0	; 03800670
	mov r3,#0x1	; 03800674
	tst r3,r1, lsr r2	; 03800678
	movne r3,#0x1	; 0380067C
	moveq r3,#0x0	; 03800680
	orr r0,r0,r3	; 03800684
	strh r0,[r12,#0x0]	; 03800688
	mov r3,#0x9	; 0380068C
loc_03800690:
	subs r3,r3,#0x1	; 03800690
	bne loc_03800690	; 03800694
	bic r0,r0,#0x2	; 03800698
	orr r0,r0,#0x2	; 0380069C
	strh r0,[r12,#0x0]	; 038006A0
	mov r3,#0x9	; 038006A4
loc_038006A8:
	subs r3,r3,#0x1	; 038006A8
	bne loc_038006A8	; 038006AC
	add r2,r2,#0x1	; 038006B0
	cmp r2,#0x8	; 038006B4
	bne loc_0380066C	; 038006B8
	bx lr	; 038006BC

; ===== function loc_038006C0 =====
loc_038006C0:
	mov r12,#0x4000000	; 038006C0
	add r12,r12,#0x138	; 038006C4
loc_038006C8:
	stmdb sp!,{r0,r1}	; 038006C8
	tst r0,#0x1	; 038006CC
	ldreqh r1,[r0,#0x0]	; 038006D0
	ldrneh r1,[r0,#-0x1]	; 038006D4
	movne r1,r1, lsr #0x8	; 038006D8
	ldrh r0,[r12,#0x0]	; 038006DC
	bic r0,r0,#0x77	; 038006E0
	orr r0,r0,#0x74	; 038006E4
	mov r2,#0x0	; 038006E8
loc_038006EC:
	bic r0,r0,#0x3	; 038006EC
	orr r0,r0,#0x0	; 038006F0
	mov r3,#0x1	; 038006F4
	tst r3,r1, lsr r2	; 038006F8
	movne r3,#0x1	; 038006FC
	moveq r3,#0x0	; 03800700
	orr r0,r0,r3	; 03800704
	strh r0,[r12,#0x0]	; 03800708
	mov r3,#0x9	; 0380070C
loc_03800710:
	subs r3,r3,#0x1	; 03800710
	bne loc_03800710	; 03800714
	bic r0,r0,#0x2	; 03800718
	orr r0,r0,#0x2	; 0380071C
	strh r0,[r12,#0x0]	; 03800720
	mov r3,#0x9	; 03800724
loc_03800728:
	subs r3,r3,#0x1	; 03800728
	bne loc_03800728	; 0380072C
	add r2,r2,#0x1	; 03800730
	cmp r2,#0x8	; 03800734
	bne loc_038006EC	; 03800738
	ldmia sp!,{r0,r1}	; 0380073C
	add r0,r0,#0x1	; 03800740
	subs r1,r1,#0x1	; 03800744
	bne loc_038006C8	; 03800748
	bx lr	; 0380074C

; ===== function loc_03800750 =====
loc_03800750:
	mov r12,#0x4000000	; 03800750
	add r12,r12,#0x138	; 03800754
loc_03800758:
	stmdb sp!,{r0,r1}	; 03800758
	ldrh r0,[r12,#0x0]	; 0380075C
	bic r0,r0,#0x77	; 03800760
	orr r0,r0,#0x64	; 03800764
	mov r2,#0x0	; 03800768
	mov r1,#0x0	; 0380076C
loc_03800770:
	bic r0,r0,#0x3	; 03800770
	orr r0,r0,#0x0	; 03800774
	strh r0,[r12,#0x0]	; 03800778
	mov r3,#0x9	; 0380077C
loc_03800780:
	subs r3,r3,#0x1	; 03800780
	bne loc_03800780	; 03800784
	ldrh r0,[r12,#0x0]	; 03800788
	and r3,r0,#0x1	; 0380078C
	cmp r3,#0x1	; 03800790
	moveq r3,#0x80	; 03800794
	movne r3,#0x0	; 03800798
	orr r2,r3,r2, lsr #0x1	; 0380079C
	bic r0,r0,#0x2	; 038007A0
	orr r0,r0,#0x2	; 038007A4
	strh r0,[r12,#0x0]	; 038007A8
	mov r3,#0x9	; 038007AC
loc_038007B0:
	subs r3,r3,#0x1	; 038007B0
	bne loc_038007B0	; 038007B4
	add r1,r1,#0x1	; 038007B8
	cmp r1,#0x8	; 038007BC
	bne loc_03800770	; 038007C0
	ldmia sp!,{r0,r1}	; 038007C4
	tst r0,#0x1	; 038007C8
	beq loc_038007E8	; 038007CC
	ldrh r3,[r0,#-0x1]	; 038007D0
	bic r3,r3,#0xff00	; 038007D4
	mov r2,r2, lsl #0x8	; 038007D8
	orr r3,r2,r3	; 038007DC
	strh r3,[r0,#-0x1]	; 038007E0
	b loc_038007F8	; 038007E4
loc_038007E8:
	ldrh r3,[r0,#0x0]	; 038007E8
	bic r3,r3,#0xff	; 038007EC
	orr r3,r3,r2	; 038007F0
	strh r3,[r0,#0x0]	; 038007F4
loc_038007F8:
	add r0,r0,#0x1	; 038007F8
	subs r1,r1,#0x1	; 038007FC
	bne loc_03800758	; 03800800
	bx lr	; 03800804
.thumb

; ===== function loc_03800808 =====
P2_PxiCallback_03800808:
	push {lr}	; 03800808
	sub sp,#0x4	; 0380080A
	cmp r2,#0x0	; 0380080C
	bne loc_03800834	; 0380080E
	cmp r0,#0x4	; 03800810
	beq loc_0380082E	; 03800812
	cmp r0,#0x6	; 03800814
	beq loc_0380081E	; 03800816
	cmp r0,#0x8	; 03800818
	beq loc_03800826	; 0380081A
	b loc_03800834	; 0380081C
loc_0380081E:
	add r0,r1,#0x0	; 0380081E
	bl loc_03800D2C	; 03800820
	b loc_03800834	; 03800824
loc_03800826:
	add r0,r1,#0x0	; 03800826
	bl loc_03801BC8	; 03800828
	b loc_03800834	; 0380082C
loc_0380082E:
	add r0,r1,#0x0	; 0380082E
	bl loc_03801594	; 03800830
loc_03800834:
	add sp,#0x4	; 03800834
	pop {r3}	; 03800836
	bx r3	; 03800838
	.byte 0x00, 0x00	; 0380083A
P2_ThreadEntry_0380083C:
	push {r4,r5,r6,lr}	; 0380083C
	sub sp,#0x8	; 0380083E
	ldr r5,[pool_03800874]	; 03800840
	add r4,sp,#0x0	; 03800842
	mov r6,#0x1	; 03800844
P2_Entry_03800846:
	add r0,r5,#0x0	; 03800846
	add r1,r4,#0x0	; 03800848
	add r2,r6,#0x0	; 0380084A
	bl loc_037FBD94	; 0380084C
	ldr r0,[sp,#0x0]	; 03800850
	ldr r1,[r0,#0x0]	; 03800852
	cmp r1,#0x0	; 03800854
	beq P2_Entry_03800862	; 03800856
	cmp r1,#0x1	; 03800858
	beq P2_Entry_0380086E	; 0380085A
	cmp r1,#0x3	; 0380085C
	beq P2_Entry_03800868	; 0380085E
	b P2_Entry_03800846	; 03800860
P2_Entry_03800862:
	bl P2_Entry_03800BC4	; 03800862
	b P2_Entry_03800846	; 03800866
P2_Entry_03800868:
	bl P2_Entry_03801ACC	; 03800868
	b P2_Entry_03800846	; 0380086C
P2_Entry_0380086E:
	bl P2_Entry_0380147C	; 0380086E
	b P2_Entry_03800846	; 03800872
pool_03800874:
	.word 0x038050B8	; 03800874

; ===== function loc_03800878 =====
loc_03800878:
	push {r0,r1,r2,r3}	; 03800878
	push {r4,r5,r6,r7,lr}	; 0380087A
	sub sp,#0x4	; 0380087C
	add r5,r0,#0x0	; 0380087E
	add r4,r1,#0x0	; 03800880
	add r0,sp,#0x18	; 03800882
	ldrh r0,[r0,#0x8]	; 03800884
	cmp r0,#0x4	; 03800886
	bls loc_0380088E	; 03800888
	mov r0,#0x0	; 0380088A
	b loc_038008FE	; 0380088C
loc_0380088E:
	bl loc_037FB7EC	; 0380088E
	add r7,r0,#0x0	; 03800892
	ldr r0,[pool_03800908]	; 03800894
	ldr r1,[r0,#0x54]	; 03800896
	mov r0,#0x18	; 03800898
	mul r1,r0	; 0380089A
	ldr r0,[pool_0380090C]	; 0380089C
	str r5,[r0,r1]	; 0380089E
	ldr r0,[pool_03800908]	; 038008A0
	ldr r1,[r0,#0x54]	; 038008A2
	mov r0,#0x18	; 038008A4
	mul r1,r0	; 038008A6
	ldr r0,[pool_03800910]	; 038008A8
	str r4,[r0,r1]	; 038008AA
	add r1,sp,#0x20	; 038008AC
	mov r0,#0x3	; 038008AE
	bic r1,r0	; 038008B0
	add r6,r1,#0x4	; 038008B2
	mov r5,#0x0	; 038008B4
	add r0,sp,#0x18	; 038008B6
	ldrh r4,[r0,#0x8]	; 038008B8
	b loc_038008D8	; 038008BA
loc_038008BC:
	add r6,r6,#0x4	; 038008BC
	sub r0,r6,#0x4	; 038008BE
	ldr r3,[r0,#0x0]	; 038008C0
	ldr r0,[pool_03800908]	; 038008C2
	ldr r2,[r0,#0x54]	; 038008C4
	mov r0,#0x18	; 038008C6
	mul r2,r0	; 038008C8
	lsl r1,r5,#0x2	; 038008CA
	ldr r0,[pool_03800914]	; 038008CC
	add r0,r0,r2	; 038008CE
	add r1,r1,r0	; 038008D0
	ldr r0,[pool_03800918]	; 038008D2
	str r3,[r1,r0]	; 038008D4
	add r5,r5,#0x1	; 038008D6
loc_038008D8:
	cmp r5,r4	; 038008D8
	blt loc_038008BC	; 038008DA
	ldr r1,[pool_03800908]	; 038008DC
	ldr r4,[r1,#0x54]	; 038008DE
	add r2,r4,#0x1	; 038008E0
	mov r0,#0xf	; 038008E2
	and r2,r0	; 038008E4
	str r2,[r1,#0x54]	; 038008E6
	add r0,r7,#0x0	; 038008E8
	bl loc_037FB810	; 038008EA
	ldr r0,[pool_0380091C]	; 038008EE
	ldr r2,[pool_0380090C]	; 038008F0
	mov r1,#0x18	; 038008F2
	mul r4,r1	; 038008F4
	add r1,r2,r4	; 038008F6
	mov r2,#0x0	; 038008F8
	bl loc_037FBE10	; 038008FA
loc_038008FE:
	add sp,#0x4	; 038008FE
	pop {r4,r5,r6,r7}	; 03800900
	pop {r3}	; 03800902
	add sp,#0x10	; 03800904
	bx r3	; 03800906
pool_03800908:
loc_03800908:
	.word P2_BssStart + 0x2530	; 03800908
pool_0380090C:
loc_0380090C:
	.word P2_BssStart + 0x2404	; 0380090C
pool_03800910:
loc_03800910:
	.word P2_BssStart + 0x2408	; 03800910
pool_03800914:
loc_03800914:
	.word 0x03804E38	; 03800914
pool_03800918:
loc_03800918:
	.word 0x000002DC	; 03800918
pool_0380091C:
loc_0380091C:
	.word 0x038050B8	; 0380091C

; ===== function loc_03800920 =====
P2_Entry_03800920:
	push {lr}	; 03800920
	sub sp,#0x4	; 03800922
	ldr r1,[pool_03800940]	; 03800924
	ldr r2,[r1,#0x4]	; 03800926
	cmp r2,r0	; 03800928
	bne loc_0380093A	; 0380092A
	mov r0,#0x5	; 0380092C
	str r0,[r1,#0x4]	; 0380092E
	mov r0,#0x0	; 03800930
	str r0,[r1,#0x0]	; 03800932
	ldr r0,[pool_03800944]	; 03800934
	bl loc_037FBA10	; 03800936
loc_0380093A:
	add sp,#0x4	; 0380093A
	pop {r3}	; 0380093C
	bx r3	; 0380093E
pool_03800940:
loc_03800940:
	.word P2_BssStart + 0x2130	; 03800940
pool_03800944:
loc_03800944:
	.word 0x03805290	; 03800944

; ===== function loc_03800948 =====
loc_03800948:
	mov r2,#0x1	; 03800948
	ldr r1,[pool_03800954]	; 0380094A
	str r2,[r1,#0x0]	; 0380094C
	str r0,[r1,#0x4]	; 0380094E
	bx lr	; 03800950
	.byte 0xC0, 0x46	; 03800954
pool_03800954:
loc_03800954:
	.word P2_BssStart + 0x2130	; 03800954
P2_Entry_03800958:
	ldr r0,[pool_03800968]	; 03800958
	ldr r0,[r0,#0x0]	; 0380095A
	cmp r0,#0x0	; 0380095C
	bne P2_Entry_03800964	; 0380095E
	mov r0,#0x1	; 03800960
	bx lr	; 03800962
P2_Entry_03800964:
	mov r0,#0x0	; 03800964
	bx lr	; 03800966
pool_03800968:
	.word P2_BssStart + 0x2130	; 03800968

; ===== function loc_0380096C =====
loc_0380096C:
	push {r4,r5,r6,lr}	; 0380096C
	mov r2,#0x70	; 0380096E
	add r3,r0,#0x0	; 03800970
	and r3,r2	; 03800972
	cmp r3,#0x20	; 03800974
	bgt loc_0380098C	; 03800976
	cmp r3,#0x20	; 03800978
	bge loc_038009A8	; 0380097A
	cmp r3,#0x0	; 0380097C
	bgt loc_03800986	; 0380097E
	cmp r3,#0x0	; 03800980
	beq loc_038009A0	; 03800982
	b loc_038009AA	; 03800984
loc_03800986:
	cmp r3,#0x10	; 03800986
	beq loc_038009A0	; 03800988
	b loc_038009AA	; 0380098A
loc_0380098C:
	cmp r3,#0x60	; 0380098C
	bgt loc_0380099A	; 0380098E
	cmp r3,#0x60	; 03800990
	bge loc_038009A4	; 03800992
	cmp r3,#0x30	; 03800994
	beq loc_038009A8	; 03800996
	b loc_038009AA	; 03800998
loc_0380099A:
	cmp r3,#0x70	; 0380099A
	beq loc_038009A4	; 0380099C
	b loc_038009AA	; 0380099E
loc_038009A0:
	mov r5,#0x6	; 038009A0
	b loc_038009AA	; 038009A2
loc_038009A4:
	mov r5,#0x8	; 038009A4
	b loc_038009AA	; 038009A6
loc_038009A8:
	mov r5,#0x4	; 038009A8
loc_038009AA:
	mov r3,#0xff	; 038009AA
	and r0,r3	; 038009AC
	mov r2,#0x80	; 038009AE
	orr r0,r2	; 038009B0
	lsl r4,r0,#0x8	; 038009B2
	ldr r0,[pool_038009D4]	; 038009B4
	orr r4,r0	; 038009B6
	and r1,r3	; 038009B8
	orr r4,r1	; 038009BA
	mov r6,#0x0	; 038009BC
loc_038009BE:
	add r0,r5,#0x0	; 038009BE
	add r1,r4,#0x0	; 038009C0
	add r2,r6,#0x0	; 038009C2
	bl loc_037FFA18	; 038009C4
	cmp r0,#0x0	; 038009C8
	blt loc_038009BE	; 038009CA
	pop {r4,r5,r6}	; 038009CC
	pop {r3}	; 038009CE
	bx r3	; 038009D0
	.byte 0xC0, 0x46	; 038009D4
pool_038009D4:
loc_038009D4:
	.word 0x03000000	; 038009D4

; ===== function loc_038009D8 =====
loc_038009D8:
	push {lr}	; 038009D8
	sub sp,#0x4	; 038009DA
	ldr r1,[pool_03800A14]	; 038009DC
	ldr r2,[r1,#0x0]	; 038009DE
	cmp r2,#0x0	; 038009E0
	beq loc_03800A0E	; 038009E2
	ldr r1,[r1,#0x4]	; 038009E4
	cmp r1,#0x4	; 038009E6
	bne loc_03800A0E	; 038009E8
	ldr r1,[pool_03800A18]	; 038009EA
	ldr r1,[r1,#0x5c]	; 038009EC
	cmp r1,r0	; 038009EE
	bne loc_03800A0E	; 038009F0
	bl loc_037FB7EC	; 038009F2
	mov r2,#0x5	; 038009F6
	ldr r1,[pool_03800A14]	; 038009F8
	str r2,[r1,#0x4]	; 038009FA
	mov r2,#0x0	; 038009FC
	str r2,[r1,#0x0]	; 038009FE
	ldr r1,[pool_03800A18]	; 03800A00
	str r2,[r1,#0x5c]	; 03800A02
	bl loc_037FB810	; 03800A04
	ldr r0,[pool_03800A1C]	; 03800A08
	bl loc_037FBA10	; 03800A0A
loc_03800A0E:
	add sp,#0x4	; 03800A0E
	pop {r3}	; 03800A10
	bx r3	; 03800A12
pool_03800A14:
loc_03800A14:
	.word P2_BssStart + 0x2130	; 03800A14
pool_03800A18:
loc_03800A18:
	.word P2_BssStart + 0x2530	; 03800A18
pool_03800A1C:
loc_03800A1C:
	.word 0x03805290	; 03800A1C

; ===== function loc_03800A20 =====
loc_03800A20:
	push {r4,r5,r6,r7,lr}	; 03800A20
	sub sp,#0x4	; 03800A22
	add r5,r0,#0x0	; 03800A24
	ldr r7,[pool_03800A5C]	; 03800A26
	ldr r6,[pool_03800A60]	; 03800A28
loc_03800A2A:
	bl loc_037FB7EC	; 03800A2A
	add r4,r0,#0x0	; 03800A2E
	ldr r1,[r6,#0x0]	; 03800A30
	cmp r1,#0x0	; 03800A32
	beq loc_03800A42	; 03800A34
	bl loc_037FB810	; 03800A36
	add r0,r7,#0x0	; 03800A3A
	bl loc_037FBA58	; 03800A3C
	b loc_03800A2A	; 03800A40
loc_03800A42:
	mov r0,#0x4	; 03800A42
	bl loc_03800948	; 03800A44
	ldr r0,[pool_03800A64]	; 03800A48
	str r5,[r0,#0x5c]	; 03800A4A
	add r0,r4,#0x0	; 03800A4C
	bl loc_037FB810	; 03800A4E
	add sp,#0x4	; 03800A52
	pop {r4,r5,r6,r7}	; 03800A54
	pop {r3}	; 03800A56
	bx r3	; 03800A58
	.byte 0xC0, 0x46	; 03800A5C
pool_03800A5C:
loc_03800A5C:
	.word 0x03805290	; 03800A5C
pool_03800A60:
loc_03800A60:
	.word 0x03804E38	; 03800A60
pool_03800A64:
loc_03800A64:
	.word P2_BssStart + 0x2530	; 03800A64

; ===== function loc_03800A68 =====
loc_03800A68:
	push {r4,r5,r6,r7,lr}	; 03800A68
	sub sp,#0xc	; 03800A6A
	add r5,r0,#0x0	; 03800A6C
	ldr r0,[pool_03800AFC]	; 03800A6E
	ldrh r1,[r0,#0x0]	; 03800A70
	cmp r1,#0x0	; 03800A72
	bne loc_03800AF2	; 03800A74
	mov r1,#0x1	; 03800A76
	strh r1,[r0,#0x0]	; 03800A78
	mov r1,#0x0	; 03800A7A
	ldr r0,[pool_03800B00]	; 03800A7C
	str r1,[r0,#0x0]	; 03800A7E
	mov r1,#0x5	; 03800A80
	str r1,[r0,#0x4]	; 03800A82
	bl loc_03800E64	; 03800A84
	bl loc_038016C4	; 03800A88
	bl loc_03801D10	; 03800A8C
	bl loc_037FF938	; 03800A90
	mov r0,#0x6	; 03800A94
	ldr r1,[pool_03800B04]	; 03800A96
	bl P2_SetPxiReceiveCallback	; 03800A98
	mov r0,#0x8	; 03800A9C
	ldr r1,[pool_03800B04]	; 03800A9E
	bl P2_SetPxiReceiveCallback	; 03800AA0
	mov r0,#0x4	; 03800AA4
	ldr r1,[pool_03800B04]	; 03800AA6
	bl P2_SetPxiReceiveCallback	; 03800AA8
	ldr r0,[pool_03800B08]	; 03800AAC
	ldr r1,[pool_03800B0C]	; 03800AAE
	mov r2,#0x10	; 03800AB0
	bl loc_037FBE70	; 03800AB2
	mov r4,#0x0	; 03800AB6
	ldr r7,[pool_03800B10]	; 03800AB8
	add r6,r4,#0x0	; 03800ABA
loc_03800ABC:
	add r1,r4,#0x0	; 03800ABC
	mov r0,#0x18	; 03800ABE
	mul r1,r0	; 03800AC0
	add r0,r7,r1	; 03800AC2
	add r1,r6,#0x0	; 03800AC4
	mov r2,#0x18	; 03800AC6
	bl loc_03800B28	; 03800AC8
	add r4,r4,#0x1	; 03800ACC
	cmp r4,#0x10	; 03800ACE
	blt loc_03800ABC	; 03800AD0
	mov r2,#0x0	; 03800AD2
	ldr r0,[pool_03800B14]	; 03800AD4
	str r2,[r0,#0x54]	; 03800AD6
	ldr r0,[pool_03800B18]	; 03800AD8
	strh r2,[r0,#0x18]	; 03800ADA
	ldr r0,[pool_03800B1C]	; 03800ADC
	str r0,[sp,#0x0]	; 03800ADE
	str r5,[sp,#0x4]	; 03800AE0
	ldr r0,[pool_03800B20]	; 03800AE2
	ldr r1,[pool_03800B24]	; 03800AE4
	ldr r3,[pool_03800B08]	; 03800AE6
	bl P2_CreateThread	; 03800AE8
	ldr r0,[pool_03800B20]	; 03800AEC
	bl loc_037FB9EC	; 03800AEE
loc_03800AF2:
	add sp,#0xc	; 03800AF2
	pop {r4,r5,r6,r7}	; 03800AF4
	pop {r3}	; 03800AF6
	bx r3	; 03800AF8
	.byte 0xC0, 0x46	; 03800AFC
pool_03800AFC:
loc_03800AFC:
	.word P2_BssStart + 0x212C	; 03800AFC
pool_03800B00:
loc_03800B00:
	.word P2_BssStart + 0x2130	; 03800B00
pool_03800B04:
loc_03800B04:
	.word P2_PxiCallback_03800808 + 1	; 03800B04
pool_03800B08:
loc_03800B08:
	.word 0x038050B8	; 03800B08
pool_03800B0C:
loc_03800B0C:
	.word 0x038050CC	; 03800B0C
pool_03800B10:
loc_03800B10:
	.word 0x0380510C	; 03800B10
pool_03800B14:
loc_03800B14:
	.word P2_BssStart + 0x2530	; 03800B14
pool_03800B18:
loc_03800B18:
	.word P2_BssStart + 0x2570	; 03800B18
pool_03800B1C:
loc_03800B1C:
	.word 0x00000200	; 03800B1C
pool_03800B20:
loc_03800B20:
	.word 0x03804E40	; 03800B20
pool_03800B24:
loc_03800B24:
	.word P2_ThreadEntry_0380083C + 1	; 03800B24

; ===== function loc_03800B28 =====
loc_03800B28:
	bx pc	; 03800B28
	.byte 0xC0, 0x46	; 03800B2C
.arm

; ===== function loc_03800B2C =====
loc_03800B2C:
	ldr pc,[pool_03800B30]	; 03800B2C
pool_03800B30:
loc_03800B30:
	.word loc_037FCEB0	; 03800B30
.thumb

; ===== function loc_03800B34 =====
loc_03800B34:
	push {lr}	; 03800B34
	sub sp,#0x4	; 03800B36
	cmp r0,#0x0	; 03800B38
	bne loc_03800B46	; 03800B3A
	mov r0,#0x3	; 03800B3C
	mov r1,#0x2	; 03800B3E
	bl loc_0380096C	; 03800B40
	b loc_03800B62	; 03800B44
loc_03800B46:
	cmp r1,#0x0	; 03800B46
	bne loc_03800B54	; 03800B48
	mov r0,#0x3	; 03800B4A
	mov r1,#0x2	; 03800B4C
	bl loc_0380096C	; 03800B4E
	b loc_03800B62	; 03800B52
loc_03800B54:
	ldr r2,[pool_03800B68]	; 03800B54
	str r0,[r2,#0x24]	; 03800B56
	str r1,[r2,#0x28]	; 03800B58
	mov r0,#0x3	; 03800B5A
	mov r1,#0x0	; 03800B5C
	bl loc_0380096C	; 03800B5E
loc_03800B62:
	add sp,#0x4	; 03800B62
	pop {r3}	; 03800B64
	bx r3	; 03800B66
pool_03800B68:
loc_03800B68:
	.word P2_BssStart + 0x2590	; 03800B68

; ===== function loc_03800B6C =====
P2_Code_03800B6C:
	push {r4,lr}	; 03800B6C
	sub sp,#0x8	; 03800B6E
	add r4,r0,#0x0	; 03800B70
	mov r0,#0x0	; 03800B72
	mov r1,#0x10	; 03800B74
	mov r2,#0x1	; 03800B76
	add r3,r4,#0x0	; 03800B78
	bl loc_03800878	; 03800B7A
	cmp r0,#0x0	; 03800B7E
	bne loc_03800BAA	; 03800B80
	ldr r1,[sp,#0x0]	; 03800B82
	ldr r0,[pool_03800BB4]	; 03800B84
	and r1,r0	; 03800B86
	ldr r0,[pool_03800BB8]	; 03800B88
	orr r1,r0	; 03800B8A
	str r1,[sp,#0x0]	; 03800B8C
	add r0,sp,#0x0	; 03800B8E
	ldrh r2,[r0,#0x0]	; 03800B90
	ldr r1,[pool_03800BBC]	; 03800B92
	strh r2,[r1,#0x0]	; 03800B94
	ldrh r1,[r0,#0x2]	; 03800B96
	ldr r0,[pool_03800BC0]	; 03800B98
	strh r1,[r0,#0x0]	; 03800B9A
	mov r0,#0x10	; 03800B9C
	mov r1,#0xff	; 03800B9E
	and r4,r1	; 03800BA0
	lsl r1,r4,#0x10	; 03800BA2
	lsr r1,r1,#0x10	; 03800BA4
	bl loc_0380096C	; 03800BA6
loc_03800BAA:
	add sp,#0x8	; 03800BAA
	pop {r4}	; 03800BAC
	pop {r3}	; 03800BAE
	bx r3	; 03800BB0
	.byte 0xC0, 0x46	; 03800BB4
pool_03800BB4:
loc_03800BB4:
	.word 0xF9FFFFFF	; 03800BB4
pool_03800BB8:
loc_03800BB8:
	.word 0x06000000	; 03800BB8
pool_03800BBC:
loc_03800BBC:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 03800BBC
pool_03800BC0:
loc_03800BC0:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 03800BC0
P2_Entry_03800BC4:
	push {r4,r5,r6,r7,lr}	; 03800BC4
	sub sp,#0xc	; 03800BC6
	add r5,r0,#0x0	; 03800BC8
	ldr r1,[r5,#0x4]	; 03800BCA
	cmp r1,#0x2	; 03800BCC
	bhi P2_Entry_03800BDE	; 03800BCE
	cmp r1,#0x0	; 03800BD0
	beq P2_Entry_03800BEE	; 03800BD2
	cmp r1,#0x1	; 03800BD4
	beq P2_Entry_03800C64	; 03800BD6
	cmp r1,#0x2	; 03800BD8
	beq P2_Entry_03800CCE	; 03800BDA
	b P2_Entry_03800CFA	; 03800BDC
P2_Entry_03800BDE:
	cmp r1,#0x10	; 03800BDE
	beq P2_Entry_03800BE4	; 03800BE0
	b P2_Entry_03800CFA	; 03800BE2
P2_Entry_03800BE4:
	ldr r0,[pool_03800D04]	; 03800BE4
	ldr r0,[r0,#0x20]	; 03800BE6
	cmp r0,#0x2	; 03800BE8
	beq P2_Entry_03800BEE	; 03800BEA
	b P2_Entry_03800CFA	; 03800BEC
P2_Entry_03800BEE:
	bl loc_037FB7EC	; 03800BEE
	add r4,r0,#0x0	; 03800BF2
	mov r0,#0x0	; 03800BF4
	bl P2_Entry_03800958	; 03800BF6
	cmp r0,#0x0	; 03800BFA
	bne P2_Entry_03800C12	; 03800BFC
	add r0,r4,#0x0	; 03800BFE
	bl loc_037FB810	; 03800C00
	ldr r0,[r5,#0x4]	; 03800C04
	lsl r0,r0,#0x10	; 03800C06
	lsr r0,r0,#0x10	; 03800C08
	mov r1,#0x4	; 03800C0A
	bl loc_0380096C	; 03800C0C
	b P2_Entry_03800CFA	; 03800C10
P2_Entry_03800C12:
	mov r0,#0x0	; 03800C12
	bl loc_03800948	; 03800C14
	add r0,r4,#0x0	; 03800C18
	bl loc_037FB810	; 03800C1A
	add r0,sp,#0x4	; 03800C1E
	ldr r2,[pool_03800D04]	; 03800C20
	ldr r1,[r2,#0x28]	; 03800C22
	ldr r2,[r2,#0x24]	; 03800C24
	bl P2_Entry_03800F44	; 03800C26
	add r0,sp,#0x4	; 03800C2A
	ldrh r2,[r0,#0x0]	; 03800C2C
	ldr r1,[pool_03800D08]	; 03800C2E
	strh r2,[r1,#0x0]	; 03800C30
	ldrh r1,[r0,#0x2]	; 03800C32
	ldr r0,[pool_03800D0C]	; 03800C34
	strh r1,[r0,#0x0]	; 03800C36
	ldr r0,[r5,#0x4]	; 03800C38
	cmp r0,#0x0	; 03800C3A
	bne P2_Entry_03800C4A	; 03800C3C
	lsl r0,r0,#0x10	; 03800C3E
	lsr r0,r0,#0x10	; 03800C40
	mov r1,#0x0	; 03800C42
	bl loc_0380096C	; 03800C44
	b P2_Entry_03800C5C	; 03800C48
P2_Entry_03800C4A:
	lsl r0,r0,#0x10	; 03800C4A
	lsr r0,r0,#0x10	; 03800C4C
	ldr r2,[r5,#0x8]	; 03800C4E
	mov r1,#0xff	; 03800C50
	and r2,r1	; 03800C52
	lsl r1,r2,#0x10	; 03800C54
	lsr r1,r1,#0x10	; 03800C56
	bl loc_0380096C	; 03800C58
P2_Entry_03800C5C:
	mov r0,#0x0	; 03800C5C
	bl P2_Entry_03800920	; 03800C5E
	b P2_Entry_03800CFA	; 03800C62
P2_Entry_03800C64:
	ldr r0,[pool_03800D04]	; 03800C64
	ldr r0,[r0,#0x20]	; 03800C66
	cmp r0,#0x1	; 03800C68
	bne P2_Entry_03800CC2	; 03800C6A
	mov r4,#0x0	; 03800C6C
	add r7,r4,#0x0	; 03800C6E
	b P2_Entry_03800CA8	; 03800C70
P2_Entry_03800C72:
	lsl r2,r4,#0x1	; 03800C72
	ldr r0,[pool_03800D04]	; 03800C74
	add r6,r0,r2	; 03800C76
	add r0,r4,#0x0	; 03800C78
	ldr r2,[pool_03800D10]	; 03800C7A
	mul r0,r2	; 03800C7C
	bl loc_03800D20	; 03800C7E
	ldr r1,[r5,#0xc]	; 03800C82
	add r0,r1,r0	; 03800C84
	ldr r1,[pool_03800D10]	; 03800C86
	bl loc_03800D20	; 03800C88
	add r0,r6,#0x0	; 03800C8C
	add r0,#0xac	; 03800C8E
	strh r1,[r0,#0x0]	; 03800C90
	str r4,[sp,#0x0]	; 03800C92
	lsl r1,r4,#0x5	; 03800C94
	ldr r0,[pool_03800D14]	; 03800C96
	add r0,r0,r1	; 03800C98
	mov r1,#0xac	; 03800C9A
	ldrsh r1,[r6,r1]	; 03800C9C
	add r2,r7,#0x0	; 03800C9E
	ldr r3,[pool_03800D18]	; 03800CA0
	bl P2_Entry_037FC9E0	; 03800CA2
	add r4,r4,#0x1	; 03800CA6
P2_Entry_03800CA8:
	ldr r1,[r5,#0x8]	; 03800CA8
	cmp r4,r1	; 03800CAA
	bcc P2_Entry_03800C72	; 03800CAC
	ldr r0,[r5,#0x4]	; 03800CAE
	lsl r0,r0,#0x10	; 03800CB0
	lsr r0,r0,#0x10	; 03800CB2
	mov r1,#0x0	; 03800CB4
	bl loc_0380096C	; 03800CB6
	mov r1,#0x2	; 03800CBA
	ldr r0,[pool_03800D04]	; 03800CBC
	str r1,[r0,#0x20]	; 03800CBE
	b P2_Entry_03800CFA	; 03800CC0
P2_Entry_03800CC2:
	lsl r0,r1,#0x10	; 03800CC2
	lsr r0,r0,#0x10	; 03800CC4
	mov r1,#0x3	; 03800CC6
	bl loc_0380096C	; 03800CC8
	b P2_Entry_03800CFA	; 03800CCC
P2_Entry_03800CCE:
	ldr r0,[pool_03800D04]	; 03800CCE
	ldr r0,[r0,#0x20]	; 03800CD0
	cmp r0,#0x3	; 03800CD2
	bne P2_Entry_03800CF0	; 03800CD4
	ldr r0,[pool_03800D1C]	; 03800CD6
	bl P2_Entry_037FC844	; 03800CD8
	ldr r0,[r5,#0x4]	; 03800CDC
	lsl r0,r0,#0x10	; 03800CDE
	lsr r0,r0,#0x10	; 03800CE0
	mov r1,#0x0	; 03800CE2
	bl loc_0380096C	; 03800CE4
	mov r1,#0x0	; 03800CE8
	ldr r0,[pool_03800D04]	; 03800CEA
	str r1,[r0,#0x20]	; 03800CEC
	b P2_Entry_03800CFA	; 03800CEE
P2_Entry_03800CF0:
	lsl r0,r1,#0x10	; 03800CF0
	lsr r0,r0,#0x10	; 03800CF2
	mov r1,#0x3	; 03800CF4
	bl loc_0380096C	; 03800CF6
P2_Entry_03800CFA:
	add sp,#0xc	; 03800CFA
	pop {r4,r5,r6,r7}	; 03800CFC
	pop {r3}	; 03800CFE
	bx r3	; 03800D00
	.byte 0xC0, 0x46	; 03800D02
pool_03800D04:
	.word P2_BssStart + 0x2590	; 03800D04
pool_03800D08:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 03800D08
pool_03800D0C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 2	; 03800D0C
pool_03800D10:
	.word 0x00000107	; 03800D10
pool_03800D14:
	.word 0x038052C4	; 03800D14
pool_03800D18:
	.word P2_Code_03800B6C + 1	; 03800D18
pool_03800D1C:
	.word 0x54505641	; 03800D1C

; ===== function loc_03800D20 =====
loc_03800D20:
	bx pc	; 03800D20
	.byte 0xC0, 0x46	; 03800D24
.arm

; ===== function loc_03800D24 =====
loc_03800D24:
	ldr pc,[pool_03800D28]	; 03800D24
pool_03800D28:
loc_03800D28:
	.word loc_03802720	; 03800D28
.thumb

; ===== function loc_03800D2C =====
loc_03800D2C:
	push {r4,lr}	; 03800D2C
	sub sp,#0x8	; 03800D2E
	ldr r1,[pool_03800E4C]	; 03800D30
	add r2,r0,#0x0	; 03800D32
	and r2,r1	; 03800D34
	cmp r2,#0x0	; 03800D36
	beq loc_03800D4A	; 03800D38
	mov r4,#0x0	; 03800D3A
	add r3,r4,#0x0	; 03800D3C
	ldr r1,[pool_03800E50]	; 03800D3E
loc_03800D40:
	lsl r2,r4,#0x1	; 03800D40
	strh r3,[r1,r2]	; 03800D42
	add r4,r4,#0x1	; 03800D44
	cmp r4,#0x10	; 03800D46
	blt loc_03800D40	; 03800D48
loc_03800D4A:
	ldr r1,[pool_03800E54]	; 03800D4A
	add r2,r0,#0x0	; 03800D4C
	and r2,r1	; 03800D4E
	lsr r1,r2,#0x10	; 03800D50
	lsl r2,r1,#0x1	; 03800D52
	ldr r1,[pool_03800E50]	; 03800D54
	strh r0,[r1,r2]	; 03800D56
	ldr r2,[pool_03800E58]	; 03800D58
	and r0,r2	; 03800D5A
	cmp r0,#0x0	; 03800D5C
	beq loc_03800E44	; 03800D5E
	ldrh r0,[r1,#0x0]	; 03800D60
	ldr r2,[pool_03800E5C]	; 03800D62
	add r3,r0,#0x0	; 03800D64
	and r3,r2	; 03800D66
	lsl r2,r3,#0x8	; 03800D68
	lsr r4,r2,#0x10	; 03800D6A
	cmp r4,#0x3	; 03800D6C
	bhi loc_03800E3C	; 03800D6E
	add r2,r4,r4	; 03800D70
P2_SwitchIndexPC_03800D70:
	add r2,pc	; 03800D72
	ldrh r2,[r2,#(P2_SwitchTable_03800D70 - (P2_SwitchIndexPC_03800D70 + 4))]	; 03800D74
	lsl r2,r2,#0x10	; 03800D76
	asr r2,r2,#0x10	; 03800D78
P2_SwitchTargetPC_03800D70:
	add r2,pc	; 03800D7A
	bx r2	; 03800D7C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800D70:
	.halfword (loc_03800D96 + 1) - (P2_SwitchTargetPC_03800D70 + 4)
	.halfword (loc_03800DAE + 1) - (P2_SwitchTargetPC_03800D70 + 4)
	.halfword (loc_03800E0C + 1) - (P2_SwitchTargetPC_03800D70 + 4)
	.halfword (loc_03800D86 + 1) - (P2_SwitchTargetPC_03800D70 + 4)
P2_SwitchTable_03800D70End:
loc_03800D86:
	mov r2,#0xff	; 03800D86
	and r0,r2	; 03800D88
	lsl r0,r0,#0x10	; 03800D8A
	lsr r0,r0,#0x10	; 03800D8C
	ldrh r1,[r1,#0x2]	; 03800D8E
	bl loc_03800B34	; 03800D90
	b loc_03800E44	; 03800D94
loc_03800D96:
	mov r0,#0x0	; 03800D96
	add r1,r4,#0x0	; 03800D98
	add r2,r0,#0x0	; 03800D9A
	bl loc_03800878	; 03800D9C
	cmp r0,#0x0	; 03800DA0
	bne loc_03800E44	; 03800DA2
	add r0,r4,#0x0	; 03800DA4
	mov r1,#0x4	; 03800DA6
	bl loc_0380096C	; 03800DA8
	b loc_03800E44	; 03800DAC
loc_03800DAE:
	ldr r2,[r1,#0x20]	; 03800DAE
	cmp r2,#0x0	; 03800DB0
	beq loc_03800DBE	; 03800DB2
	add r0,r4,#0x0	; 03800DB4
	mov r1,#0x3	; 03800DB6
	bl loc_0380096C	; 03800DB8
	b loc_03800E44	; 03800DBC
loc_03800DBE:
	mov r2,#0xff	; 03800DBE
	and r0,r2	; 03800DC0
	lsl r0,r0,#0x10	; 03800DC2
	lsr r3,r0,#0x10	; 03800DC4
	cmp r3,#0x0	; 03800DC6
	beq loc_03800DCE	; 03800DC8
	cmp r3,#0x4	; 03800DCA
	bls loc_03800DD8	; 03800DCC
loc_03800DCE:
	add r0,r4,#0x0	; 03800DCE
	mov r1,#0x2	; 03800DD0
	bl loc_0380096C	; 03800DD2
	b loc_03800E44	; 03800DD6
loc_03800DD8:
	ldrh r1,[r1,#0x2]	; 03800DD8
	ldr r0,[pool_03800E60]	; 03800DDA
	cmp r1,r0	; 03800DDC
	bcc loc_03800DEA	; 03800DDE
	add r0,r4,#0x0	; 03800DE0
	mov r1,#0x2	; 03800DE2
	bl loc_0380096C	; 03800DE4
	b loc_03800E44	; 03800DE8
loc_03800DEA:
	str r1,[sp,#0x0]	; 03800DEA
	mov r0,#0x0	; 03800DEC
	add r1,r4,#0x0	; 03800DEE
	mov r2,#0x2	; 03800DF0
	bl loc_03800878	; 03800DF2
	cmp r0,#0x0	; 03800DF6
	bne loc_03800E04	; 03800DF8
	add r0,r4,#0x0	; 03800DFA
	mov r1,#0x4	; 03800DFC
	bl loc_0380096C	; 03800DFE
	b loc_03800E44	; 03800E02
loc_03800E04:
	mov r1,#0x1	; 03800E04
	ldr r0,[pool_03800E50]	; 03800E06
	str r1,[r0,#0x20]	; 03800E08
	b loc_03800E44	; 03800E0A
loc_03800E0C:
	ldr r0,[r1,#0x20]	; 03800E0C
	cmp r0,#0x2	; 03800E0E
	beq loc_03800E1C	; 03800E10
	add r0,r4,#0x0	; 03800E12
	mov r1,#0x3	; 03800E14
	bl loc_0380096C	; 03800E16
	b loc_03800E44	; 03800E1A
loc_03800E1C:
	mov r0,#0x0	; 03800E1C
	add r1,r4,#0x0	; 03800E1E
	add r2,r0,#0x0	; 03800E20
	bl loc_03800878	; 03800E22
	cmp r0,#0x0	; 03800E26
	bne loc_03800E34	; 03800E28
	add r0,r4,#0x0	; 03800E2A
	mov r1,#0x4	; 03800E2C
	bl loc_0380096C	; 03800E2E
	b loc_03800E44	; 03800E32
loc_03800E34:
	mov r1,#0x3	; 03800E34
	ldr r0,[pool_03800E50]	; 03800E36
	str r1,[r0,#0x20]	; 03800E38
	b loc_03800E44	; 03800E3A
loc_03800E3C:
	add r0,r4,#0x0	; 03800E3C
	mov r1,#0x1	; 03800E3E
	bl loc_0380096C	; 03800E40
loc_03800E44:
	add sp,#0x8	; 03800E44
	pop {r4}	; 03800E46
	pop {r3}	; 03800E48
	bx r3	; 03800E4A
pool_03800E4C:
loc_03800E4C:
	.word 0x02000000	; 03800E4C
pool_03800E50:
loc_03800E50:
	.word P2_BssStart + 0x2590	; 03800E50
pool_03800E54:
loc_03800E54:
	.word 0x000F0000	; 03800E54
pool_03800E58:
loc_03800E58:
	.word 0x01000000	; 03800E58
pool_03800E5C:
loc_03800E5C:
	.word 0x0000FF00	; 03800E5C
pool_03800E60:
loc_03800E60:
	.word 0x00000107	; 03800E60

; ===== function loc_03800E64 =====
loc_03800E64:
	push {r4,r5,r6,r7,lr}	; 03800E64
	sub sp,#0x4	; 03800E66
	mov r3,#0x0	; 03800E68
	ldr r0,[pool_03800F28]	; 03800E6A
	str r3,[r0,#0x20]	; 03800E6C
	mov r1,#0x1e	; 03800E6E
	str r1,[r0,#0x28]	; 03800E70
	mov r1,#0x5	; 03800E72
	str r1,[r0,#0x24]	; 03800E74
	add r2,r3,#0x0	; 03800E76
loc_03800E78:
	lsl r1,r3,#0x1	; 03800E78
	strh r2,[r0,r1]	; 03800E7A
	add r3,r3,#0x1	; 03800E7C
	cmp r3,#0x10	; 03800E7E
	blt loc_03800E78	; 03800E80
	bl loc_037FCB28	; 03800E82
	cmp r0,#0x0	; 03800E86
	bne loc_03800E8E	; 03800E88
	bl loc_037FCB34	; 03800E8A
loc_03800E8E:
	mov r4,#0x0	; 03800E8E
	ldr r6,[pool_03800F2C]	; 03800E90
	ldr r7,[pool_03800F30]	; 03800E92
loc_03800E94:
	lsl r0,r4,#0x5	; 03800E94
	add r5,r6,r0	; 03800E96
	add r0,r5,#0x0	; 03800E98
	bl loc_037FCB1C	; 03800E9A
	add r0,r5,#0x0	; 03800E9E
	add r1,r7,#0x0	; 03800EA0
	bl loc_037FC894	; 03800EA2
	add r4,r4,#0x1	; 03800EA6
	cmp r4,#0x4	; 03800EA8
	blt loc_03800E94	; 03800EAA
	mov r6,#0x1	; 03800EAC
	ldr r5,[pool_03800F34]	; 03800EAE
	mov r4,#0x80	; 03800EB0
	b loc_03800EBA	; 03800EB2
loc_03800EB4:
	add r0,r6,#0x0	; 03800EB4
	bl loc_03802244	; 03800EB6
loc_03800EBA:
	ldrh r0,[r5,#0x0]	; 03800EBA
	and r0,r4	; 03800EBC
	cmp r0,#0x0	; 03800EBE
	bne loc_03800EB4	; 03800EC0
	ldr r0,[pool_03800F38]	; 03800EC2
	strh r0,[r5,#0x0]	; 03800EC4
	mov r1,#0x84	; 03800EC6
	ldr r0,[pool_03800F3C]	; 03800EC8
	strh r1,[r0,#0x0]	; 03800ECA
	mov r6,#0x1	; 03800ECC
	ldr r5,[pool_03800F34]	; 03800ECE
	mov r4,#0x80	; 03800ED0
	b loc_03800EDA	; 03800ED2
loc_03800ED4:
	add r0,r6,#0x0	; 03800ED4
	bl loc_03802244	; 03800ED6
loc_03800EDA:
	ldrh r0,[r5,#0x0]	; 03800EDA
	and r0,r4	; 03800EDC
	cmp r0,#0x0	; 03800EDE
	bne loc_03800ED4	; 03800EE0
	mov r1,#0x0	; 03800EE2
	ldr r0,[pool_03800F3C]	; 03800EE4
	strh r1,[r0,#0x0]	; 03800EE6
	mov r6,#0x1	; 03800EE8
	ldr r5,[pool_03800F34]	; 03800EEA
	mov r4,#0x80	; 03800EEC
	b loc_03800EF6	; 03800EEE
loc_03800EF0:
	add r0,r6,#0x0	; 03800EF0
	bl loc_03802244	; 03800EF2
loc_03800EF6:
	ldrh r0,[r5,#0x0]	; 03800EF6
	and r0,r4	; 03800EF8
	cmp r0,#0x0	; 03800EFA
	bne loc_03800EF0	; 03800EFC
	ldr r0,[pool_03800F40]	; 03800EFE
	strh r0,[r5,#0x0]	; 03800F00
	mov r1,#0x0	; 03800F02
	ldr r0,[pool_03800F3C]	; 03800F04
	strh r1,[r0,#0x0]	; 03800F06
	mov r6,#0x1	; 03800F08
	ldr r5,[pool_03800F34]	; 03800F0A
	mov r4,#0x80	; 03800F0C
	b loc_03800F16	; 03800F0E
loc_03800F10:
	add r0,r6,#0x0	; 03800F10
	bl loc_03802244	; 03800F12
loc_03800F16:
	ldrh r0,[r5,#0x0]	; 03800F16
	and r0,r4	; 03800F18
	cmp r0,#0x0	; 03800F1A
	bne loc_03800F10	; 03800F1C
	add sp,#0x4	; 03800F1E
	pop {r4,r5,r6,r7}	; 03800F20
	pop {r3}	; 03800F22
	bx r3	; 03800F24
	.byte 0xC0, 0x46	; 03800F28
pool_03800F28:
loc_03800F28:
	.word P2_BssStart + 0x2590	; 03800F28
pool_03800F2C:
loc_03800F2C:
	.word 0x038052C4	; 03800F2C
pool_03800F30:
loc_03800F30:
	.word 0x54505641	; 03800F30
pool_03800F34:
loc_03800F34:
	.word REG_SPICNT	; 03800F34
pool_03800F38:
loc_03800F38:
	.word 0x00008A01	; 03800F38
pool_03800F3C:
loc_03800F3C:
	.word REG_SPIDATA	; 03800F3C
pool_03800F40:
loc_03800F40:
	.word 0x00008201	; 03800F40

; ===== function loc_03800F44 =====
P2_Entry_03800F44:
	push {r4,r5,r6,r7,lr}	; 03800F44
	sub sp,#0x4	; 03800F46
	add r5,r0,#0x0	; 03800F48
	add r4,r1,#0x0	; 03800F4A
	add r6,r2,#0x0	; 03800F4C
	cmp r4,#0x0	; 03800F4E
	bge loc_03800F54	; 03800F50
	neg r4,r4	; 03800F52
loc_03800F54:
	bl loc_038012F8	; 03800F54
	add r7,r0,#0x0	; 03800F58
	cmp r7,#0x0	; 03800F5A
	bne loc_03800F8A	; 03800F5C
	ldr r1,[r5,#0x0]	; 03800F5E
	ldr r0,[pool_038010AC]	; 03800F60
	and r1,r0	; 03800F62
	str r1,[r5,#0x0]	; 03800F64
	ldr r1,[r5,#0x0]	; 03800F66
	ldr r0,[pool_038010B0]	; 03800F68
	and r1,r0	; 03800F6A
	str r1,[r5,#0x0]	; 03800F6C
	ldr r1,[r5,#0x0]	; 03800F6E
	ldr r0,[pool_038010B4]	; 03800F70
	and r1,r0	; 03800F72
	str r1,[r5,#0x0]	; 03800F74
	ldr r1,[r5,#0x0]	; 03800F76
	ldr r0,[pool_038010B8]	; 03800F78
	and r1,r0	; 03800F7A
	ldr r0,[pool_038010BC]	; 03800F7C
	orr r1,r0	; 03800F7E
	str r1,[r5,#0x0]	; 03800F80
	mov r1,#0x0	; 03800F82
	ldr r0,[pool_038010C0]	; 03800F84
	strh r1,[r0,#0x0]	; 03800F86
	b loc_038010A4	; 03800F88
loc_03800F8A:
	add r0,sp,#0x0	; 03800F8A
	add r1,r4,#0x0	; 03800F8C
	add r2,r6,#0x0	; 03800F8E
	mov r3,#0x0	; 03800F90
	bl loc_038010E0	; 03800F92
	ldr r1,[r5,#0x0]	; 03800F96
	ldr r2,[pool_038010B8]	; 03800F98
	and r1,r2	; 03800F9A
	mov r2,#0x3	; 03800F9C
	and r0,r2	; 03800F9E
	lsl r0,r0,#0x19	; 03800FA0
	orr r1,r0	; 03800FA2
	str r1,[r5,#0x0]	; 03800FA4
	ldr r0,[r5,#0x0]	; 03800FA6
	ldr r1,[pool_038010AC]	; 03800FA8
	and r0,r1	; 03800FAA
	add r1,sp,#0x0	; 03800FAC
	ldrh r2,[r1,#0x0]	; 03800FAE
	ldr r1,[pool_038010C4]	; 03800FB0
	and r2,r1	; 03800FB2
	orr r0,r2	; 03800FB4
	str r0,[r5,#0x0]	; 03800FB6
	add r0,sp,#0x0	; 03800FB8
	add r1,r4,#0x0	; 03800FBA
	add r2,r6,#0x0	; 03800FBC
	mov r3,#0x1	; 03800FBE
	bl loc_038010E0	; 03800FC0
	cmp r0,#0x2	; 03800FC4
	bne loc_03800FE8	; 03800FC6
	ldr r1,[r5,#0x0]	; 03800FC8
	lsl r0,r1,#0x5	; 03800FCA
	lsr r0,r0,#0x1e	; 03800FCC
	cmp r0,#0x1	; 03800FCE
	bne loc_03800FDE	; 03800FD0
	ldr r0,[pool_038010B8]	; 03800FD2
	and r1,r0	; 03800FD4
	ldr r0,[pool_038010BC]	; 03800FD6
	orr r1,r0	; 03800FD8
	str r1,[r5,#0x0]	; 03800FDA
	b loc_03800FE8	; 03800FDC
loc_03800FDE:
	ldr r0,[pool_038010B8]	; 03800FDE
	and r1,r0	; 03800FE0
	ldr r0,[pool_038010C8]	; 03800FE2
	orr r1,r0	; 03800FE4
	str r1,[r5,#0x0]	; 03800FE6
loc_03800FE8:
	ldr r0,[r5,#0x0]	; 03800FE8
	ldr r1,[pool_038010B0]	; 03800FEA
	and r0,r1	; 03800FEC
	add r1,sp,#0x0	; 03800FEE
	ldrh r2,[r1,#0x0]	; 03800FF0
	ldr r1,[pool_038010C4]	; 03800FF2
	and r2,r1	; 03800FF4
	lsl r1,r2,#0xc	; 03800FF6
	orr r0,r1	; 03800FF8
	str r0,[r5,#0x0]	; 03800FFA
	ldr r1,[pool_038010CC]	; 03800FFC
	ldr r0,[pool_038010D0]	; 03800FFE
	strh r1,[r0,#0x0]	; 03801000
	mov r4,#0x0	; 03801002
	add r6,r4,#0x0	; 03801004
loc_03801006:
	ldr r0,[pool_038010D4]	; 03801006
	strh r6,[r0,#0x0]	; 03801008
	b loc_03801012	; 0380100A
loc_0380100C:
	mov r0,#0x1	; 0380100C
	bl loc_03802244	; 0380100E
loc_03801012:
	ldr r0,[pool_038010D0]	; 03801012
	ldrh r1,[r0,#0x0]	; 03801014
	mov r0,#0x80	; 03801016
	and r1,r0	; 03801018
	cmp r1,#0x0	; 0380101A
	bne loc_0380100C	; 0380101C
	add r4,r4,#0x1	; 0380101E
	cmp r4,#0xc	; 03801020
	blt loc_03801006	; 03801022
	ldr r1,[pool_038010D8]	; 03801024
	ldr r0,[pool_038010D0]	; 03801026
	strh r1,[r0,#0x0]	; 03801028
	mov r1,#0x0	; 0380102A
	ldr r0,[pool_038010D4]	; 0380102C
	strh r1,[r0,#0x0]	; 0380102E
	ldr r4,[pool_038010D0]	; 03801030
	mov r6,#0x80	; 03801032
	b loc_0380103C	; 03801034
loc_03801036:
	mov r0,#0x1	; 03801036
	bl loc_03802244	; 03801038
loc_0380103C:
	ldrh r0,[r4,#0x0]	; 0380103C
	and r0,r6	; 0380103E
	cmp r0,#0x0	; 03801040
	bne loc_03801036	; 03801042
	cmp r7,#0x2	; 03801044
	bne loc_03801054	; 03801046
	ldr r1,[r5,#0x0]	; 03801048
	ldr r0,[pool_038010B8]	; 0380104A
	and r1,r0	; 0380104C
	ldr r0,[pool_038010BC]	; 0380104E
	orr r1,r0	; 03801050
	str r1,[r5,#0x0]	; 03801052
loc_03801054:
	bl loc_038012F8	; 03801054
	cmp r0,#0x0	; 03801058
	beq loc_03801090	; 0380105A
	cmp r0,#0x1	; 0380105C
	beq loc_03801080	; 0380105E
	cmp r0,#0x2	; 03801060
	bne loc_038010A0	; 03801062
	ldr r1,[r5,#0x0]	; 03801064
	ldr r0,[pool_038010DC]	; 03801066
	orr r1,r0	; 03801068
	str r1,[r5,#0x0]	; 0380106A
	ldr r1,[r5,#0x0]	; 0380106C
	ldr r0,[pool_038010B8]	; 0380106E
	and r1,r0	; 03801070
	ldr r0,[pool_038010BC]	; 03801072
	orr r1,r0	; 03801074
	str r1,[r5,#0x0]	; 03801076
	mov r1,#0x0	; 03801078
	ldr r0,[pool_038010C0]	; 0380107A
	strh r1,[r0,#0x0]	; 0380107C
	b loc_038010A4	; 0380107E
loc_03801080:
	ldr r1,[r5,#0x0]	; 03801080
	ldr r0,[pool_038010DC]	; 03801082
	orr r1,r0	; 03801084
	str r1,[r5,#0x0]	; 03801086
	mov r1,#0x1	; 03801088
	ldr r0,[pool_038010C0]	; 0380108A
	strh r1,[r0,#0x0]	; 0380108C
	b loc_038010A4	; 0380108E
loc_03801090:
	ldr r1,[r5,#0x0]	; 03801090
	ldr r0,[pool_038010B4]	; 03801092
	and r1,r0	; 03801094
	str r1,[r5,#0x0]	; 03801096
	mov r1,#0x0	; 03801098
	ldr r0,[pool_038010C0]	; 0380109A
	strh r1,[r0,#0x0]	; 0380109C
	b loc_038010A4	; 0380109E
loc_038010A0:
	bl loc_037FCCC0	; 038010A0
loc_038010A4:
	add sp,#0x4	; 038010A4
	pop {r4,r5,r6,r7}	; 038010A6
	pop {r3}	; 038010A8
	bx r3	; 038010AA
pool_038010AC:
loc_038010AC:
	.word 0xFFFFF000	; 038010AC
pool_038010B0:
loc_038010B0:
	.word 0xFF000FFF	; 038010B0
pool_038010B4:
loc_038010B4:
	.word 0xFEFFFFFF	; 038010B4
pool_038010B8:
loc_038010B8:
	.word 0xF9FFFFFF	; 038010B8
pool_038010BC:
loc_038010BC:
	.word 0x06000000	; 038010BC
pool_038010C0:
loc_038010C0:
	.word P2_BssStart + 0x2644	; 038010C0
pool_038010C4:
loc_038010C4:
	.word 0x00000FFF	; 038010C4
pool_038010C8:
loc_038010C8:
	.word REG_DISPCNT_A	; 038010C8
pool_038010CC:
loc_038010CC:
	.word 0x00008A01	; 038010CC
pool_038010D0:
loc_038010D0:
	.word REG_SPICNT	; 038010D0
pool_038010D4:
loc_038010D4:
	.word REG_SPIDATA	; 038010D4
pool_038010D8:
loc_038010D8:
	.word 0x00008201	; 038010D8
pool_038010DC:
loc_038010DC:
	.word 0x01000000	; 038010DC

; ===== function loc_038010E0 =====
loc_038010E0:
	push {r4,r5,r6,r7,lr}	; 038010E0
	sub sp,#0x24	; 038010E2
	add r6,r0,#0x0	; 038010E4
	str r1,[sp,#0x0]	; 038010E6
	str r2,[sp,#0x4]	; 038010E8
	cmp r3,#0x0	; 038010EA
	bne loc_038010F4	; 038010EC
	mov r4,#0xd1	; 038010EE
	mov r7,#0x1	; 038010F0
	b loc_03801100	; 038010F2
loc_038010F4:
	mov r4,#0x91	; 038010F4
	mov r7,#0x2	; 038010F6
	b loc_03801100	; 038010F8
loc_038010FA:
	mov r0,#0x1	; 038010FA
	bl loc_03802244	; 038010FC
loc_03801100:
	ldr r5,[pool_038012E4]	; 03801100
	ldrh r1,[r5,#0x0]	; 03801102
	mov r0,#0x80	; 03801104
	and r1,r0	; 03801106
	cmp r1,#0x0	; 03801108
	bne loc_038010FA	; 0380110A
	ldr r0,[pool_038012E8]	; 0380110C
	strh r0,[r5,#0x0]	; 0380110E
	mov r0,#0xff	; 03801110
	and r4,r0	; 03801112
	ldr r0,[pool_038012EC]	; 03801114
	strh r4,[r0,#0x0]	; 03801116
	b loc_03801120	; 03801118
loc_0380111A:
	mov r0,#0x1	; 0380111A
	bl loc_03802244	; 0380111C
loc_03801120:
	ldrh r1,[r5,#0x0]	; 03801120
	mov r0,#0x80	; 03801122
	and r1,r0	; 03801124
	cmp r1,#0x0	; 03801126
	bne loc_0380111A	; 03801128
	mov r1,#0x0	; 0380112A
	ldr r0,[pool_038012EC]	; 0380112C
	strh r1,[r0,#0x0]	; 0380112E
	ldr r5,[pool_038012E4]	; 03801130
	b loc_0380113A	; 03801132
loc_03801134:
	mov r0,#0x1	; 03801134
	bl loc_03802244	; 03801136
loc_0380113A:
	ldrh r1,[r5,#0x0]	; 0380113A
	mov r0,#0x80	; 0380113C
	and r1,r0	; 0380113E
	cmp r1,#0x0	; 03801140
	bne loc_03801134	; 03801142
	ldr r1,[pool_038012EC]	; 03801144
	ldrh r2,[r1,#0x0]	; 03801146
	mov r0,#0xff	; 03801148
	and r2,r0	; 0380114A
	lsl r0,r2,#0x10	; 0380114C
	lsr r0,r0,#0x8	; 0380114E
	str r0,[sp,#0x18]	; 03801150
	strh r4,[r1,#0x0]	; 03801152
	ldr r5,[pool_038012E4]	; 03801154
	b loc_0380115E	; 03801156
loc_03801158:
	mov r0,#0x1	; 03801158
	bl loc_03802244	; 0380115A
loc_0380115E:
	ldrh r1,[r5,#0x0]	; 0380115E
	mov r0,#0x80	; 03801160
	and r1,r0	; 03801162
	cmp r1,#0x0	; 03801164
	bne loc_03801158	; 03801166
	ldr r0,[pool_038012EC]	; 03801168
	ldrh r2,[r0,#0x0]	; 0380116A
	mov r1,#0xff	; 0380116C
	and r2,r1	; 0380116E
	lsl r1,r2,#0x10	; 03801170
	lsr r1,r1,#0x10	; 03801172
	ldr r2,[sp,#0x18]	; 03801174
	orr r2,r1	; 03801176
	str r2,[sp,#0x18]	; 03801178
	ldr r1,[pool_038012F0]	; 0380117A
	and r2,r1	; 0380117C
	asr r1,r2,#0x3	; 0380117E
	str r1,[sp,#0x18]	; 03801180
	mov r1,#0x0	; 03801182
	strh r1,[r0,#0x0]	; 03801184
	ldr r5,[pool_038012E4]	; 03801186
	b loc_03801190	; 03801188
loc_0380118A:
	mov r0,#0x1	; 0380118A
	bl loc_03802244	; 0380118C
loc_03801190:
	ldrh r1,[r5,#0x0]	; 03801190
	mov r0,#0x80	; 03801192
	and r1,r0	; 03801194
	cmp r1,#0x0	; 03801196
	bne loc_0380118A	; 03801198
	ldr r1,[pool_038012EC]	; 0380119A
	ldrh r2,[r1,#0x0]	; 0380119C
	mov r0,#0xff	; 0380119E
	and r2,r0	; 038011A0
	lsl r0,r2,#0x10	; 038011A2
	lsr r0,r0,#0x8	; 038011A4
	str r0,[sp,#0x1c]	; 038011A6
	strh r4,[r1,#0x0]	; 038011A8
	ldr r5,[pool_038012E4]	; 038011AA
	b loc_038011B4	; 038011AC
loc_038011AE:
	mov r0,#0x1	; 038011AE
	bl loc_03802244	; 038011B0
loc_038011B4:
	ldrh r1,[r5,#0x0]	; 038011B4
	mov r0,#0x80	; 038011B6
	and r1,r0	; 038011B8
	cmp r1,#0x0	; 038011BA
	bne loc_038011AE	; 038011BC
	ldr r0,[pool_038012EC]	; 038011BE
	ldrh r1,[r0,#0x0]	; 038011C0
	mov r0,#0xff	; 038011C2
	and r1,r0	; 038011C4
	lsl r0,r1,#0x10	; 038011C6
	lsr r0,r0,#0x10	; 038011C8
	ldr r1,[sp,#0x1c]	; 038011CA
	orr r1,r0	; 038011CC
	str r1,[sp,#0x1c]	; 038011CE
	ldr r0,[pool_038012F0]	; 038011D0
	and r1,r0	; 038011D2
	asr r1,r1,#0x3	; 038011D4
	str r1,[sp,#0x1c]	; 038011D6
	ldr r0,[sp,#0x4]	; 038011D8
	cmp r0,#0x0	; 038011DA
	bne loc_038011E8	; 038011DC
	ldr r0,[sp,#0x18]	; 038011DE
	add r0,r0,r1	; 038011E0
	asr r0,r0,#0x1	; 038011E2
	strh r0,[r6,#0x0]	; 038011E4
	mov r7,#0x0	; 038011E6
loc_038011E8:
	mov r5,#0x0	; 038011E8
	ldr r0,[sp,#0x0]	; 038011EA
	neg r0,r0	; 038011EC
	str r0,[sp,#0xc]	; 038011EE
	str r5,[sp,#0x14]	; 038011F0
	b loc_0380129E	; 038011F2
loc_038011F4:
	ldr r1,[sp,#0x14]	; 038011F4
	ldr r0,[pool_038012EC]	; 038011F6
	strh r1,[r0,#0x0]	; 038011F8
	b loc_03801202	; 038011FA
loc_038011FC:
	mov r0,#0x1	; 038011FC
	bl loc_03802244	; 038011FE
loc_03801202:
	ldr r0,[pool_038012E4]	; 03801202
	ldrh r1,[r0,#0x0]	; 03801204
	mov r0,#0x80	; 03801206
	and r1,r0	; 03801208
	cmp r1,#0x0	; 0380120A
	bne loc_038011FC	; 0380120C
	ldr r0,[pool_038012EC]	; 0380120E
	ldrh r1,[r0,#0x0]	; 03801210
	mov r0,#0xff	; 03801212
	and r1,r0	; 03801214
	lsl r0,r1,#0x10	; 03801216
	lsr r0,r0,#0x8	; 03801218
	str r0,[sp,#0x8]	; 0380121A
	ldr r0,[pool_038012EC]	; 0380121C
	strh r4,[r0,#0x0]	; 0380121E
	b loc_03801228	; 03801220
loc_03801222:
	mov r0,#0x1	; 03801222
	bl loc_03802244	; 03801224
loc_03801228:
	ldr r0,[pool_038012E4]	; 03801228
	ldrh r1,[r0,#0x0]	; 0380122A
	mov r0,#0x80	; 0380122C
	and r1,r0	; 0380122E
	cmp r1,#0x0	; 03801230
	bne loc_03801222	; 03801232
	ldr r0,[pool_038012EC]	; 03801234
	ldrh r1,[r0,#0x0]	; 03801236
	mov r0,#0xff	; 03801238
	and r1,r0	; 0380123A
	lsl r0,r1,#0x10	; 0380123C
	lsr r0,r0,#0x10	; 0380123E
	ldr r1,[sp,#0x8]	; 03801240
	orr r1,r0	; 03801242
	str r1,[sp,#0x8]	; 03801244
	ldr r0,[pool_038012F0]	; 03801246
	and r1,r0	; 03801248
	str r1,[sp,#0x8]	; 0380124A
	asr r0,r1,#0x3	; 0380124C
	str r0,[sp,#0x10]	; 0380124E
	ldr r1,[sp,#0x18]	; 03801250
	sub r1,r1,r0	; 03801252
	ldr r0,[sp,#0xc]	; 03801254
	cmp r1,r0	; 03801256
	blt loc_0380128C	; 03801258
	ldr r0,[sp,#0x0]	; 0380125A
	cmp r1,r0	; 0380125C
	bgt loc_0380128C	; 0380125E
	ldr r1,[sp,#0x1c]	; 03801260
	ldr r0,[sp,#0x10]	; 03801262
	sub r1,r1,r0	; 03801264
	ldr r0,[sp,#0xc]	; 03801266
	cmp r1,r0	; 03801268
	blt loc_0380128C	; 0380126A
	ldr r0,[sp,#0x0]	; 0380126C
	cmp r1,r0	; 0380126E
	bgt loc_0380128C	; 03801270
	add r0,r5,#0x1	; 03801272
	mov r1,#0x2	; 03801274
	bl loc_037FBE04	; 03801276
	lsl r1,r1,#0x2	; 0380127A
	add r0,sp,#0x18	; 0380127C
	ldr r1,[r0,r1]	; 0380127E
	ldr r0,[sp,#0x10]	; 03801280
	add r0,r0,r1	; 03801282
	asr r0,r0,#0x1	; 03801284
	strh r0,[r6,#0x0]	; 03801286
	mov r7,#0x0	; 03801288
	b loc_038012A4	; 0380128A
loc_0380128C:
	add r0,r5,#0x0	; 0380128C
	mov r1,#0x2	; 0380128E
	bl loc_037FBE04	; 03801290
	lsl r2,r1,#0x2	; 03801294
	ldr r1,[sp,#0x10]	; 03801296
	add r0,sp,#0x18	; 03801298
	str r1,[r0,r2]	; 0380129A
	add r5,r5,#0x1	; 0380129C
loc_0380129E:
	ldr r0,[sp,#0x4]	; 0380129E
	cmp r5,r0	; 038012A0
	blt loc_038011F4	; 038012A2
loc_038012A4:
	cmp r7,#0x0	; 038012A4
	beq loc_038012B2	; 038012A6
	ldr r1,[sp,#0x18]	; 038012A8
	ldr r0,[sp,#0x1c]	; 038012AA
	add r0,r1,r0	; 038012AC
	asr r0,r0,#0x1	; 038012AE
	strh r0,[r6,#0x0]	; 038012B0
loc_038012B2:
	ldr r0,[pool_038012F4]	; 038012B2
	ldr r4,[pool_038012E4]	; 038012B4
	strh r0,[r4,#0x0]	; 038012B6
	mov r1,#0x0	; 038012B8
	ldr r0,[pool_038012EC]	; 038012BA
	strh r1,[r0,#0x0]	; 038012BC
	mov r5,#0x80	; 038012BE
	b loc_038012C8	; 038012C0
loc_038012C2:
	mov r0,#0x1	; 038012C2
	bl loc_03802244	; 038012C4
loc_038012C8:
	ldrh r0,[r4,#0x0]	; 038012C8
	and r0,r5	; 038012CA
	cmp r0,#0x0	; 038012CC
	bne loc_038012C2	; 038012CE
	ldrh r1,[r6,#0x0]	; 038012D0
	mov r0,#0x7	; 038012D2
	bic r1,r0	; 038012D4
	strh r1,[r6,#0x0]	; 038012D6
	add r0,r7,#0x0	; 038012D8
	add sp,#0x24	; 038012DA
	pop {r4,r5,r6,r7}	; 038012DC
	pop {r3}	; 038012DE
	bx r3	; 038012E0
	.byte 0xC0, 0x46	; 038012E4
pool_038012E4:
loc_038012E4:
	.word REG_SPICNT	; 038012E4
pool_038012E8:
loc_038012E8:
	.word 0x00008A01	; 038012E8
pool_038012EC:
loc_038012EC:
	.word REG_SPIDATA	; 038012EC
pool_038012F0:
loc_038012F0:
	.word 0x00007FF8	; 038012F0
pool_038012F4:
loc_038012F4:
	.word 0x00008201	; 038012F4

; ===== function loc_038012F8 =====
loc_038012F8:
	push {r4,r5,r6,lr}	; 038012F8
	ldr r0,[pool_03801414]	; 038012FA
	bl loc_037FFC2C	; 038012FC
	mov r6,#0x1	; 03801300
	ldr r5,[pool_03801418]	; 03801302
	mov r4,#0x80	; 03801304
	b loc_0380130E	; 03801306
loc_03801308:
	add r0,r6,#0x0	; 03801308
	bl loc_03802244	; 0380130A
loc_0380130E:
	ldrh r0,[r5,#0x0]	; 0380130E
	and r0,r4	; 03801310
	cmp r0,#0x0	; 03801312
	bne loc_03801308	; 03801314
	ldr r0,[pool_0380141C]	; 03801316
	strh r0,[r5,#0x0]	; 03801318
	mov r1,#0x84	; 0380131A
	ldr r0,[pool_03801420]	; 0380131C
	strh r1,[r0,#0x0]	; 0380131E
	mov r6,#0x1	; 03801320
	ldr r5,[pool_03801418]	; 03801322
	mov r4,#0x80	; 03801324
	b loc_0380132E	; 03801326
loc_03801328:
	add r0,r6,#0x0	; 03801328
	bl loc_03802244	; 0380132A
loc_0380132E:
	ldrh r0,[r5,#0x0]	; 0380132E
	and r0,r4	; 03801330
	cmp r0,#0x0	; 03801332
	bne loc_03801328	; 03801334
	mov r1,#0x0	; 03801336
	ldr r0,[pool_03801420]	; 03801338
	strh r1,[r0,#0x0]	; 0380133A
	mov r6,#0x1	; 0380133C
	ldr r5,[pool_03801418]	; 0380133E
	mov r4,#0x80	; 03801340
	b loc_0380134A	; 03801342
loc_03801344:
	add r0,r6,#0x0	; 03801344
	bl loc_03802244	; 03801346
loc_0380134A:
	ldrh r0,[r5,#0x0]	; 0380134A
	and r0,r4	; 0380134C
	cmp r0,#0x0	; 0380134E
	bne loc_03801344	; 03801350
	ldr r0,[pool_03801424]	; 03801352
	strh r0,[r5,#0x0]	; 03801354
	mov r1,#0x0	; 03801356
	ldr r0,[pool_03801420]	; 03801358
	strh r1,[r0,#0x0]	; 0380135A
	mov r6,#0x1	; 0380135C
	ldr r5,[pool_03801418]	; 0380135E
	mov r4,#0x80	; 03801360
	b loc_0380136A	; 03801362
loc_03801364:
	add r0,r6,#0x0	; 03801364
	bl loc_03802244	; 03801366
loc_0380136A:
	ldrh r0,[r5,#0x0]	; 0380136A
	and r0,r4	; 0380136C
	cmp r0,#0x0	; 0380136E
	bne loc_03801364	; 03801370
	ldr r0,[pool_03801428]	; 03801372
	ldrh r0,[r0,#0x0]	; 03801374
	cmp r0,#0x0	; 03801376
	bne loc_0380138E	; 03801378
	ldr r0,[pool_0380142C]	; 0380137A
	ldrh r1,[r0,#0x0]	; 0380137C
	mov r0,#0x40	; 0380137E
	and r1,r0	; 03801380
	cmp r1,#0x0	; 03801382
	bne loc_0380138A	; 03801384
	mov r0,#0x1	; 03801386
	b loc_0380140C	; 03801388
loc_0380138A:
	mov r0,#0x0	; 0380138A
	b loc_0380140C	; 0380138C
loc_0380138E:
	ldr r0,[pool_0380142C]	; 0380138E
	ldrh r1,[r0,#0x0]	; 03801390
	mov r0,#0x40	; 03801392
	and r1,r0	; 03801394
	cmp r1,#0x0	; 03801396
	bne loc_0380139E	; 03801398
	mov r0,#0x1	; 0380139A
	b loc_0380140C	; 0380139C
loc_0380139E:
	ldr r0,[pool_0380141C]	; 0380139E
	strh r0,[r5,#0x0]	; 038013A0
	mov r1,#0x84	; 038013A2
	ldr r0,[pool_03801420]	; 038013A4
	strh r1,[r0,#0x0]	; 038013A6
	mov r6,#0x1	; 038013A8
	ldr r5,[pool_03801418]	; 038013AA
	mov r4,#0x80	; 038013AC
	b loc_038013B6	; 038013AE
loc_038013B0:
	add r0,r6,#0x0	; 038013B0
	bl loc_03802244	; 038013B2
loc_038013B6:
	ldrh r0,[r5,#0x0]	; 038013B6
	and r0,r4	; 038013B8
	cmp r0,#0x0	; 038013BA
	bne loc_038013B0	; 038013BC
	mov r1,#0x0	; 038013BE
	ldr r0,[pool_03801420]	; 038013C0
	strh r1,[r0,#0x0]	; 038013C2
	mov r6,#0x1	; 038013C4
	ldr r5,[pool_03801418]	; 038013C6
	mov r4,#0x80	; 038013C8
	b loc_038013D2	; 038013CA
loc_038013CC:
	add r0,r6,#0x0	; 038013CC
	bl loc_03802244	; 038013CE
loc_038013D2:
	ldrh r0,[r5,#0x0]	; 038013D2
	and r0,r4	; 038013D4
	cmp r0,#0x0	; 038013D6
	bne loc_038013CC	; 038013D8
	ldr r0,[pool_03801424]	; 038013DA
	strh r0,[r5,#0x0]	; 038013DC
	mov r1,#0x0	; 038013DE
	ldr r0,[pool_03801420]	; 038013E0
	strh r1,[r0,#0x0]	; 038013E2
	mov r6,#0x1	; 038013E4
	ldr r5,[pool_03801418]	; 038013E6
	mov r4,#0x80	; 038013E8
	b loc_038013F2	; 038013EA
loc_038013EC:
	add r0,r6,#0x0	; 038013EC
	bl loc_03802244	; 038013EE
loc_038013F2:
	ldrh r0,[r5,#0x0]	; 038013F2
	and r0,r4	; 038013F4
	cmp r0,#0x0	; 038013F6
	bne loc_038013EC	; 038013F8
	ldr r0,[pool_0380142C]	; 038013FA
	ldrh r1,[r0,#0x0]	; 038013FC
	mov r0,#0x40	; 038013FE
	and r1,r0	; 03801400
	cmp r1,#0x0	; 03801402
	beq loc_0380140A	; 03801404
	mov r0,#0x0	; 03801406
	b loc_0380140C	; 03801408
loc_0380140A:
	mov r0,#0x2	; 0380140A
loc_0380140C:
	pop {r4,r5,r6}	; 0380140C
	pop {r3}	; 0380140E
	bx r3	; 03801410
	.byte 0xC0, 0x46	; 03801414
pool_03801414:
loc_03801414:
	.word 0x00008000	; 03801414
pool_03801418:
loc_03801418:
	.word REG_SPICNT	; 03801418
pool_0380141C:
loc_0380141C:
	.word 0x00008A01	; 0380141C
pool_03801420:
loc_03801420:
	.word REG_SPIDATA	; 03801420
pool_03801424:
loc_03801424:
	.word 0x00008201	; 03801424
pool_03801428:
loc_03801428:
	.word P2_BssStart + 0x2644	; 03801428
pool_0380142C:
loc_0380142C:
	.word REG_KEYXY	; 0380142C
P2_Entry_03801430:
	push {lr}	; 03801430
	sub sp,#0x4	; 03801432
	add r0,sp,#0x0	; 03801434
	bl loc_038019B4	; 03801436
	add r0,sp,#0x0	; 0380143A
	ldrh r2,[r0,#0x0]	; 0380143C
	mov r0,#0x1	; 0380143E
	add r1,r2,#0x0	; 03801440
	and r1,r0	; 03801442
	cmp r1,#0x0	; 03801444
	beq P2_Entry_0380144C	; 03801446
	mov r0,#0x0	; 03801448
	b P2_Entry_03801456	; 0380144A
P2_Entry_0380144C:
	mov r1,#0x2	; 0380144C
	and r2,r1	; 0380144E
	cmp r2,#0x0	; 03801450
	bne P2_Entry_03801456	; 03801452
	mov r0,#0x0	; 03801454
P2_Entry_03801456:
	add sp,#0x4	; 03801456
	pop {r3}	; 03801458
	bx r3	; 0380145A
P2_Entry_0380145C:
	push {lr}	; 0380145C
	sub sp,#0x4	; 0380145E
	add r0,sp,#0x0	; 03801460
	bl loc_038019B4	; 03801462
	add r0,sp,#0x0	; 03801466
	ldrh r1,[r0,#0x0]	; 03801468
	mov r0,#0x1	; 0380146A
	and r1,r0	; 0380146C
	cmp r1,#0x0	; 0380146E
	beq P2_Entry_03801474	; 03801470
	mov r0,#0x0	; 03801472
P2_Entry_03801474:
	add sp,#0x4	; 03801474
	pop {r3}	; 03801476
	bx r3	; 03801478
	.byte 0x00, 0x00	; 0380147A
P2_Entry_0380147C:
	push {r4,r5,lr}	; 0380147C
	sub sp,#0x4	; 0380147E
	add r4,r0,#0x0	; 03801480
	bl loc_037FB7EC	; 03801482
	add r5,r0,#0x0	; 03801486
	mov r0,#0x1	; 03801488
	bl P2_Entry_03800958	; 0380148A
	cmp r0,#0x0	; 0380148E
	bne P2_Entry_038014A6	; 03801490
	add r0,r5,#0x0	; 03801492
	bl loc_037FB810	; 03801494
	ldr r0,[r4,#0x4]	; 03801498
	lsl r0,r0,#0x10	; 0380149A
	lsr r0,r0,#0x10	; 0380149C
	mov r1,#0x4	; 0380149E
	bl loc_0380096C	; 038014A0
	b P2_Entry_0380158A	; 038014A4
P2_Entry_038014A6:
	mov r0,#0x1	; 038014A6
	bl loc_03800948	; 038014A8
	add r0,r5,#0x0	; 038014AC
	bl loc_037FB810	; 038014AE
	ldr r0,[r4,#0x4]	; 038014B2
	sub r0,#0x20	; 038014B4
	cmp r0,#0x7	; 038014B6
	bhi P2_Entry_03801564	; 038014B8
	add r0,r0,r0	; 038014BA
P2_SwitchIndexPC_038014BA:
	add r0,pc	; 038014BC
	ldrh r0,[r0,#(P2_SwitchTable_038014BA - (P2_SwitchIndexPC_038014BA + 4))]	; 038014BE
	lsl r0,r0,#0x10	; 038014C0
	asr r0,r0,#0x10	; 038014C2
P2_SwitchTargetPC_038014BA:
	add r0,pc	; 038014C4
	bx r0	; 038014C6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038014BA:
	.halfword (P2_Case_038014D8 + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Case_038014DE + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Case_038014E4 + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Case_038014EC + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Entry_03801564 + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Case_03801514 + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Entry_03801564 + 1) - (P2_SwitchTargetPC_038014BA + 4)
	.halfword (P2_Case_03801540 + 1) - (P2_SwitchTargetPC_038014BA + 4)
P2_SwitchTable_038014BAEnd:
P2_Case_038014D8:
	bl P2_Entry_03801A80	; 038014D8
	b P2_Entry_03801578	; 038014DC
P2_Case_038014DE:
	bl P2_Entry_03801A34	; 038014DE
	b P2_Entry_03801578	; 038014E2
P2_Case_038014E4:
	ldr r0,[r4,#0x10]	; 038014E4
	bl loc_038019B4	; 038014E6
	b P2_Entry_03801578	; 038014EA
P2_Case_038014EC:
	bl P2_Entry_0380145C	; 038014EC
	cmp r0,#0x0	; 038014F0
	bne P2_Entry_03801508	; 038014F2
	ldr r0,[r4,#0x4]	; 038014F4
	lsl r0,r0,#0x10	; 038014F6
	lsr r0,r0,#0x10	; 038014F8
	mov r1,#0x3	; 038014FA
	bl loc_0380096C	; 038014FC
	mov r0,#0x1	; 03801500
	bl P2_Entry_03800920	; 03801502
	b P2_Entry_0380158A	; 03801506
P2_Entry_03801508:
	ldr r0,[r4,#0x8]	; 03801508
	ldr r1,[r4,#0xc]	; 0380150A
	ldr r2,[r4,#0x10]	; 0380150C
	bl loc_038018B8	; 0380150E
	b P2_Entry_03801578	; 03801512
P2_Case_03801514:
	bl P2_Entry_03801430	; 03801514
	cmp r0,#0x0	; 03801518
	bne P2_Entry_03801530	; 0380151A
	ldr r0,[r4,#0x4]	; 0380151C
	lsl r0,r0,#0x10	; 0380151E
	lsr r0,r0,#0x10	; 03801520
	mov r1,#0x3	; 03801522
	bl loc_0380096C	; 03801524
	mov r0,#0x1	; 03801528
	bl P2_Entry_03800920	; 0380152A
	b P2_Entry_0380158A	; 0380152E
P2_Entry_03801530:
	ldr r0,[r4,#0x8]	; 03801530
	ldr r1,[r4,#0xc]	; 03801532
	lsl r1,r1,#0x10	; 03801534
	lsr r1,r1,#0x10	; 03801536
	ldr r2,[r4,#0x10]	; 03801538
	bl P2_Entry_038017AC	; 0380153A
	b P2_Entry_03801578	; 0380153E
P2_Case_03801540:
	bl P2_Entry_03801430	; 03801540
	cmp r0,#0x0	; 03801544
	bne P2_Entry_0380155C	; 03801546
	ldr r0,[r4,#0x4]	; 03801548
	lsl r0,r0,#0x10	; 0380154A
	lsr r0,r0,#0x10	; 0380154C
	mov r1,#0x3	; 0380154E
	bl loc_0380096C	; 03801550
	mov r0,#0x1	; 03801554
	bl P2_Entry_03800920	; 03801556
	b P2_Entry_0380158A	; 0380155A
P2_Entry_0380155C:
	ldr r0,[r4,#0x8]	; 0380155C
	bl P2_Entry_038016DC	; 0380155E
	b P2_Entry_03801578	; 03801562
P2_Entry_03801564:
	mov r0,#0x1	; 03801564
	bl P2_Entry_03800920	; 03801566
	ldr r0,[r4,#0x4]	; 0380156A
	lsl r0,r0,#0x10	; 0380156C
	lsr r0,r0,#0x10	; 0380156E
	mov r1,#0x1	; 03801570
	bl loc_0380096C	; 03801572
	b P2_Entry_0380158A	; 03801576
P2_Entry_03801578:
	ldr r0,[r4,#0x4]	; 03801578
	lsl r0,r0,#0x10	; 0380157A
	lsr r0,r0,#0x10	; 0380157C
	mov r1,#0x0	; 0380157E
	bl loc_0380096C	; 03801580
	mov r0,#0x1	; 03801584
	bl P2_Entry_03800920	; 03801586
P2_Entry_0380158A:
	add sp,#0x4	; 0380158A
	pop {r4,r5}	; 0380158C
	pop {r3}	; 0380158E
	bx r3	; 03801590
	.byte 0x00, 0x00	; 03801592

; ===== function loc_03801594 =====
loc_03801594:
	push {r4,r5,r6,r7,lr}	; 03801594
	sub sp,#0xc	; 03801596
	ldr r1,[pool_038016AC]	; 03801598
	add r5,r0,#0x0	; 0380159A
	and r5,r1	; 0380159C
	cmp r5,#0x0	; 0380159E
	beq loc_038015B2	; 038015A0
	mov r5,#0x0	; 038015A2
	add r6,r5,#0x0	; 038015A4
	ldr r7,[pool_038016B0]	; 038015A6
loc_038015A8:
	lsl r1,r5,#0x1	; 038015A8
	strh r6,[r7,r1]	; 038015AA
	add r5,r5,#0x1	; 038015AC
	cmp r5,#0x10	; 038015AE
	blt loc_038015A8	; 038015B0
loc_038015B2:
	ldr r1,[pool_038016B4]	; 038015B2
	add r5,r0,#0x0	; 038015B4
	and r5,r1	; 038015B6
	lsr r1,r5,#0x10	; 038015B8
	lsl r5,r1,#0x1	; 038015BA
	ldr r1,[pool_038016B0]	; 038015BC
	strh r0,[r1,r5]	; 038015BE
	ldr r5,[pool_038016B8]	; 038015C0
	and r0,r5	; 038015C2
	cmp r0,#0x0	; 038015C4
	beq loc_038016A2	; 038015C6
	ldrh r0,[r1,#0x0]	; 038015C8
	ldr r7,[pool_038016BC]	; 038015CA
	add r5,r0,#0x0	; 038015CC
	and r5,r7	; 038015CE
	lsl r5,r5,#0x8	; 038015D0
	lsr r6,r5,#0x10	; 038015D2
	add r5,r6,#0x0	; 038015D4
	sub r5,#0x22	; 038015D6
	cmp r5,#0x5	; 038015D8
	bhi loc_03801688	; 038015DA
	add r5,r5,r5	; 038015DC
P2_SwitchIndexPC_038015DC:
	add r5,pc	; 038015DE
	ldrh r5,[r5,#(P2_SwitchTable_038015DC - (P2_SwitchIndexPC_038015DC + 4))]	; 038015E0
	lsl r5,r5,#0x10	; 038015E2
	asr r5,r5,#0x10	; 038015E4
P2_SwitchTargetPC_038015DC:
	add r5,pc	; 038015E6
	bx r5	; 038015E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038015DC:
	.halfword (loc_038015F6 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_03801620 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_03801688 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_03801652 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_03801688 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_0380167E + 1) - (P2_SwitchTargetPC_038015DC + 4)
P2_SwitchTable_038015DCEnd:
loc_038015F6:
	ldrh r4,[r1,#0x4]	; 038015F6
	and r4,r7	; 038015F8
	lsr r4,r4,#0x8	; 038015FA
	mov r5,#0xff	; 038015FC
	and r0,r5	; 038015FE
	lsl r0,r0,#0x18	; 03801600
	ldrh r1,[r1,#0x2]	; 03801602
	lsl r1,r1,#0x8	; 03801604
	orr r0,r1	; 03801606
	orr r4,r0	; 03801608
	ldr r0,[pool_038016AC]	; 0380160A
	cmp r4,r0	; 0380160C
	bcc loc_03801616	; 0380160E
	ldr r0,[pool_038016C0]	; 03801610
	cmp r4,r0	; 03801612
	bcc loc_03801688	; 03801614
loc_03801616:
	add r0,r6,#0x0	; 03801616
	mov r1,#0x2	; 03801618
	bl loc_0380096C	; 0380161A
	b loc_038016A2	; 0380161E
loc_03801620:
	ldrh r2,[r1,#0x8]	; 03801620
	lsl r4,r2,#0x10	; 03801622
	ldrh r2,[r1,#0xa]	; 03801624
	orr r4,r2	; 03801626
	ldr r2,[pool_038016AC]	; 03801628
	cmp r4,r2	; 0380162A
	bcc loc_03801634	; 0380162C
	ldr r2,[pool_038016C0]	; 0380162E
	cmp r4,r2	; 03801630
	bcc loc_0380163E	; 03801632
loc_03801634:
	add r0,r6,#0x0	; 03801634
	mov r1,#0x2	; 03801636
	bl loc_0380096C	; 03801638
	b loc_038016A2	; 0380163C
loc_0380163E:
	mov r2,#0xff	; 0380163E
	and r0,r2	; 03801640
	lsl r3,r0,#0x10	; 03801642
	ldrh r0,[r1,#0x2]	; 03801644
	orr r3,r0	; 03801646
	ldrh r0,[r1,#0x4]	; 03801648
	lsl r2,r0,#0x10	; 0380164A
	ldrh r0,[r1,#0x6]	; 0380164C
	orr r2,r0	; 0380164E
	b loc_03801688	; 03801650
loc_03801652:
	ldrh r2,[r1,#0x6]	; 03801652
	lsl r4,r2,#0x10	; 03801654
	ldrh r2,[r1,#0x8]	; 03801656
	orr r4,r2	; 03801658
	ldr r2,[pool_038016AC]	; 0380165A
	cmp r4,r2	; 0380165C
	bcc loc_03801666	; 0380165E
	ldr r2,[pool_038016C0]	; 03801660
	cmp r4,r2	; 03801662
	bcc loc_03801670	; 03801664
loc_03801666:
	add r0,r6,#0x0	; 03801666
	mov r1,#0x2	; 03801668
	bl loc_0380096C	; 0380166A
	b loc_038016A2	; 0380166E
loc_03801670:
	mov r2,#0xff	; 03801670
	and r0,r2	; 03801672
	lsl r3,r0,#0x10	; 03801674
	ldrh r0,[r1,#0x2]	; 03801676
	orr r3,r0	; 03801678
	ldrh r2,[r1,#0x4]	; 0380167A
	b loc_03801688	; 0380167C
loc_0380167E:
	mov r3,#0xff	; 0380167E
	and r0,r3	; 03801680
	lsl r3,r0,#0x10	; 03801682
	ldrh r0,[r1,#0x2]	; 03801684
	orr r3,r0	; 03801686
loc_03801688:
	str r2,[sp,#0x0]	; 03801688
	str r4,[sp,#0x4]	; 0380168A
	mov r0,#0x1	; 0380168C
	add r1,r6,#0x0	; 0380168E
	mov r2,#0x3	; 03801690
	bl loc_03800878	; 03801692
	cmp r0,#0x0	; 03801696
	bne loc_038016A2	; 03801698
	add r0,r6,#0x0	; 0380169A
	mov r1,#0x4	; 0380169C
	bl loc_0380096C	; 0380169E
loc_038016A2:
	add sp,#0xc	; 038016A2
	pop {r4,r5,r6,r7}	; 038016A4
	pop {r3}	; 038016A6
	bx r3	; 038016A8
	.byte 0xC0, 0x46	; 038016AC
pool_038016AC:
loc_038016AC:
	.word 0x02000000	; 038016AC
pool_038016B0:
loc_038016B0:
	.word P2_BssStart + 0x2648	; 038016B0
pool_038016B4:
loc_038016B4:
	.word 0x000F0000	; 038016B4
pool_038016B8:
loc_038016B8:
	.word 0x01000000	; 038016B8
pool_038016BC:
loc_038016BC:
	.word 0x0000FF00	; 038016BC
pool_038016C0:
loc_038016C0:
	.word 0x02400000	; 038016C0

; ===== function loc_038016C4 =====
loc_038016C4:
	mov r3,#0x0	; 038016C4
	add r2,r3,#0x0	; 038016C6
	ldr r0,[pool_038016D8]	; 038016C8
loc_038016CA:
	lsl r1,r3,#0x1	; 038016CA
	strh r2,[r0,r1]	; 038016CC
	add r3,r3,#0x1	; 038016CE
	cmp r3,#0x10	; 038016D0
	blt loc_038016CA	; 038016D2
	bx lr	; 038016D4
	.byte 0xC0, 0x46	; 038016D8
pool_038016D8:
loc_038016D8:
	.word P2_BssStart + 0x2648	; 038016D8

; ===== function loc_038016DC =====
P2_Entry_038016DC:
	push {r4,r5,r6,r7,lr}	; 038016DC
	sub sp,#0x4	; 038016DE
	ldr r1,[pool_03801794]	; 038016E0
	add r2,r0,#0x0	; 038016E2
	and r2,r1	; 038016E4
	lsr r1,r2,#0x10	; 038016E6
	lsl r1,r1,#0x10	; 038016E8
	lsr r5,r1,#0x10	; 038016EA
	ldr r1,[pool_03801798]	; 038016EC
	add r2,r0,#0x0	; 038016EE
	and r2,r1	; 038016F0
	lsl r1,r2,#0x8	; 038016F2
	lsr r4,r1,#0x10	; 038016F4
	mov r1,#0xff	; 038016F6
	and r0,r1	; 038016F8
	lsl r0,r0,#0x10	; 038016FA
	lsr r6,r0,#0x10	; 038016FC
	ldr r7,[pool_0380179C]	; 038016FE
	b loc_03801708	; 03801700
loc_03801702:
	mov r0,#0x1	; 03801702
	bl loc_03802244	; 03801704
loc_03801708:
	ldrh r1,[r7,#0x0]	; 03801708
	mov r0,#0x80	; 0380170A
	and r1,r0	; 0380170C
	cmp r1,#0x0	; 0380170E
	bne loc_03801702	; 03801710
	ldr r0,[pool_038017A0]	; 03801712
	strh r0,[r7,#0x0]	; 03801714
	mov r1,#0xdb	; 03801716
	ldr r0,[pool_038017A4]	; 03801718
	strh r1,[r0,#0x0]	; 0380171A
	ldr r7,[pool_0380179C]	; 0380171C
	b loc_03801726	; 0380171E
loc_03801720:
	mov r0,#0x1	; 03801720
	bl loc_03802244	; 03801722
loc_03801726:
	ldrh r1,[r7,#0x0]	; 03801726
	mov r0,#0x80	; 03801728
	and r1,r0	; 0380172A
	cmp r1,#0x0	; 0380172C
	bne loc_03801720	; 0380172E
	mov r0,#0xff	; 03801730
	and r5,r0	; 03801732
	ldr r0,[pool_038017A4]	; 03801734
	strh r5,[r0,#0x0]	; 03801736
	ldr r5,[pool_0380179C]	; 03801738
	mov r7,#0x80	; 0380173A
	b loc_03801744	; 0380173C
loc_0380173E:
	mov r0,#0x1	; 0380173E
	bl loc_03802244	; 03801740
loc_03801744:
	ldrh r0,[r5,#0x0]	; 03801744
	and r0,r7	; 03801746
	cmp r0,#0x0	; 03801748
	bne loc_0380173E	; 0380174A
	mov r0,#0xff	; 0380174C
	and r4,r0	; 0380174E
	ldr r0,[pool_038017A4]	; 03801750
	strh r4,[r0,#0x0]	; 03801752
	mov r7,#0x1	; 03801754
	ldr r4,[pool_0380179C]	; 03801756
	mov r5,#0x80	; 03801758
	b loc_03801762	; 0380175A
loc_0380175C:
	add r0,r7,#0x0	; 0380175C
	bl loc_03802244	; 0380175E
loc_03801762:
	ldrh r0,[r4,#0x0]	; 03801762
	and r0,r5	; 03801764
	cmp r0,#0x0	; 03801766
	bne loc_0380175C	; 03801768
	ldr r0,[pool_038017A8]	; 0380176A
	strh r0,[r4,#0x0]	; 0380176C
	mov r0,#0xff	; 0380176E
	and r6,r0	; 03801770
	ldr r0,[pool_038017A4]	; 03801772
	strh r6,[r0,#0x0]	; 03801774
	mov r6,#0x1	; 03801776
	ldr r5,[pool_0380179C]	; 03801778
	mov r4,#0x80	; 0380177A
	b loc_03801784	; 0380177C
loc_0380177E:
	add r0,r6,#0x0	; 0380177E
	bl loc_03802244	; 03801780
loc_03801784:
	ldrh r0,[r5,#0x0]	; 03801784
	and r0,r4	; 03801786
	cmp r0,#0x0	; 03801788
	bne loc_0380177E	; 0380178A
	add sp,#0x4	; 0380178C
	pop {r4,r5,r6,r7}	; 0380178E
	pop {r3}	; 03801790
	bx r3	; 03801792
pool_03801794:
loc_03801794:
	.word 0x00FF0000	; 03801794
pool_03801798:
loc_03801798:
	.word 0x0000FF00	; 03801798
pool_0380179C:
loc_0380179C:
	.word REG_SPICNT	; 0380179C
pool_038017A0:
loc_038017A0:
	.word 0x00008900	; 038017A0
pool_038017A4:
loc_038017A4:
	.word REG_SPIDATA	; 038017A4
pool_038017A8:
loc_038017A8:
	.word 0x00008100	; 038017A8
P2_Entry_038017AC:
	push {r4,r5,r6,r7,lr}	; 038017AC
	sub sp,#0xc	; 038017AE
	add r4,r1,#0x0	; 038017B0
	add r6,r2,#0x0	; 038017B2
	cmp r4,#0x1	; 038017B4
	bcc P2_Entry_03801894	; 038017B6
	add r1,r0,r4	; 038017B8
	sub r1,r1,#0x1	; 038017BA
	lsr r2,r1,#0x8	; 038017BC
	lsr r1,r0,#0x8	; 038017BE
	cmp r2,r1	; 038017C0
	bls P2_Entry_038017D2	; 038017C2
	mov r1,#0xff	; 038017C4
	add r2,r0,#0x0	; 038017C6
	and r2,r1	; 038017C8
	ldr r1,[pool_0380189C]	; 038017CA
	sub r1,r1,r2	; 038017CC
	lsl r1,r1,#0x10	; 038017CE
	lsr r4,r1,#0x10	; 038017D0
P2_Entry_038017D2:
	ldr r1,[pool_038018A0]	; 038017D2
	add r2,r0,#0x0	; 038017D4
	and r2,r1	; 038017D6
	lsr r1,r2,#0x10	; 038017D8
	add r2,sp,#0x0	; 038017DA
	strh r1,[r2,#0x0]	; 038017DC
	ldr r1,[pool_038018A4]	; 038017DE
	add r3,r0,#0x0	; 038017E0
	and r3,r1	; 038017E2
	lsr r1,r3,#0x8	; 038017E4
	strh r1,[r2,#0x2]	; 038017E6
	mov r1,#0xff	; 038017E8
	and r0,r1	; 038017EA
	strh r0,[r2,#0x4]	; 038017EC
	ldr r5,[pool_038018A8]	; 038017EE
	mov r7,#0x80	; 038017F0
	b P2_Entry_038017FA	; 038017F2
P2_Entry_038017F4:
	mov r0,#0x1	; 038017F4
	bl P2_SwiWaitByLoop	; 038017F6
P2_Entry_038017FA:
	ldrh r0,[r5,#0x0]	; 038017FA
	and r0,r7	; 038017FC
	cmp r0,#0x0	; 038017FE
	bne P2_Entry_038017F4	; 03801800
	ldr r0,[pool_038018AC]	; 03801802
	strh r0,[r5,#0x0]	; 03801804
	mov r0,#0xa	; 03801806
	ldr r7,[pool_038018B0]	; 03801808
	strh r0,[r7,#0x0]	; 0380180A
	mov r5,#0x0	; 0380180C
	b P2_Entry_03801830	; 0380180E
P2_Entry_03801810:
	mov r0,#0x1	; 03801810
	bl P2_SwiWaitByLoop	; 03801812
P2_Entry_03801816:
	ldr r0,[pool_038018A8]	; 03801816
	ldrh r1,[r0,#0x0]	; 03801818
	mov r0,#0x80	; 0380181A
	and r1,r0	; 0380181C
	cmp r1,#0x0	; 0380181E
	bne P2_Entry_03801810	; 03801820
	lsl r1,r5,#0x1	; 03801822
	add r0,sp,#0x0	; 03801824
	ldrh r1,[r0,r1]	; 03801826
	mov r0,#0xff	; 03801828
	and r1,r0	; 0380182A
	strh r1,[r7,#0x0]	; 0380182C
	add r5,r5,#0x1	; 0380182E
P2_Entry_03801830:
	cmp r5,#0x3	; 03801830
	blt P2_Entry_03801816	; 03801832
	mov r5,#0x0	; 03801834
	sub r4,r4,#0x1	; 03801836
	ldr r7,[pool_038018A8]	; 03801838
	b P2_Entry_03801858	; 0380183A
P2_Entry_0380183C:
	mov r0,#0x1	; 0380183C
	bl P2_SwiWaitByLoop	; 0380183E
P2_Entry_03801842:
	ldrh r1,[r7,#0x0]	; 03801842
	mov r0,#0x80	; 03801844
	and r1,r0	; 03801846
	cmp r1,#0x0	; 03801848
	bne P2_Entry_0380183C	; 0380184A
	ldrb r1,[r6,r5]	; 0380184C
	mov r0,#0xff	; 0380184E
	and r1,r0	; 03801850
	ldr r0,[pool_038018B0]	; 03801852
	strh r1,[r0,#0x0]	; 03801854
	add r5,r5,#0x1	; 03801856
P2_Entry_03801858:
	cmp r5,r4	; 03801858
	blt P2_Entry_03801842	; 0380185A
	ldr r4,[pool_038018A8]	; 0380185C
	mov r7,#0x80	; 0380185E
	b P2_Entry_03801868	; 03801860
P2_Entry_03801862:
	mov r0,#0x1	; 03801862
	bl P2_SwiWaitByLoop	; 03801864
P2_Entry_03801868:
	ldrh r0,[r4,#0x0]	; 03801868
	and r0,r7	; 0380186A
	cmp r0,#0x0	; 0380186C
	bne P2_Entry_03801862	; 0380186E
	ldr r0,[pool_038018B4]	; 03801870
	strh r0,[r4,#0x0]	; 03801872
	ldrb r1,[r6,r5]	; 03801874
	mov r0,#0xff	; 03801876
	and r1,r0	; 03801878
	ldr r0,[pool_038018B0]	; 0380187A
	strh r1,[r0,#0x0]	; 0380187C
	mov r6,#0x1	; 0380187E
	ldr r5,[pool_038018A8]	; 03801880
	mov r4,#0x80	; 03801882
	b P2_Entry_0380188C	; 03801884
P2_Entry_03801886:
	add r0,r6,#0x0	; 03801886
	bl P2_SwiWaitByLoop	; 03801888
P2_Entry_0380188C:
	ldrh r0,[r5,#0x0]	; 0380188C
	and r0,r4	; 0380188E
	cmp r0,#0x0	; 03801890
	bne P2_Entry_03801886	; 03801892
P2_Entry_03801894:
	add sp,#0xc	; 03801894
	pop {r4,r5,r6,r7}	; 03801896
	pop {r3}	; 03801898
	bx r3	; 0380189A
pool_0380189C:
	.word 0x00000100	; 0380189C
pool_038018A0:
	.word 0x00FF0000	; 038018A0
pool_038018A4:
	.word 0x0000FF00	; 038018A4
pool_038018A8:
	.word REG_SPICNT	; 038018A8
pool_038018AC:
	.word 0x00008900	; 038018AC
pool_038018B0:
	.word REG_SPIDATA	; 038018B0
pool_038018B4:
	.word 0x00008100	; 038018B4

; ===== function loc_038018B8 =====
loc_038018B8:
	push {r4,r5,r6,r7,lr}	; 038018B8
	sub sp,#0xc	; 038018BA
	add r4,r1,#0x0	; 038018BC
	add r6,r2,#0x0	; 038018BE
	cmp r4,#0x1	; 038018C0
	bcc loc_03801992	; 038018C2
	ldr r1,[pool_0380199C]	; 038018C4
	add r2,r0,#0x0	; 038018C6
	and r2,r1	; 038018C8
	lsr r1,r2,#0x10	; 038018CA
	add r2,sp,#0x0	; 038018CC
	strh r1,[r2,#0x0]	; 038018CE
	ldr r1,[pool_038019A0]	; 038018D0
	add r3,r0,#0x0	; 038018D2
	and r3,r1	; 038018D4
	lsr r1,r3,#0x8	; 038018D6
	strh r1,[r2,#0x2]	; 038018D8
	mov r1,#0xff	; 038018DA
	and r0,r1	; 038018DC
	strh r0,[r2,#0x4]	; 038018DE
	ldr r5,[pool_038019A4]	; 038018E0
	mov r7,#0x80	; 038018E2
	b loc_038018EC	; 038018E4
loc_038018E6:
	mov r0,#0x1	; 038018E6
	bl loc_03802244	; 038018E8
loc_038018EC:
	ldrh r0,[r5,#0x0]	; 038018EC
	and r0,r7	; 038018EE
	cmp r0,#0x0	; 038018F0
	bne loc_038018E6	; 038018F2
	ldr r0,[pool_038019A8]	; 038018F4
	strh r0,[r5,#0x0]	; 038018F6
	mov r0,#0x3	; 038018F8
	ldr r7,[pool_038019AC]	; 038018FA
	strh r0,[r7,#0x0]	; 038018FC
	mov r5,#0x0	; 038018FE
	b loc_03801922	; 03801900
loc_03801902:
	mov r0,#0x1	; 03801902
	bl loc_03802244	; 03801904
loc_03801908:
	ldr r0,[pool_038019A4]	; 03801908
	ldrh r1,[r0,#0x0]	; 0380190A
	mov r0,#0x80	; 0380190C
	and r1,r0	; 0380190E
	cmp r1,#0x0	; 03801910
	bne loc_03801902	; 03801912
	lsl r1,r5,#0x1	; 03801914
	add r0,sp,#0x0	; 03801916
	ldrh r1,[r0,r1]	; 03801918
	mov r0,#0xff	; 0380191A
	and r1,r0	; 0380191C
	strh r1,[r7,#0x0]	; 0380191E
	add r5,r5,#0x1	; 03801920
loc_03801922:
	cmp r5,#0x3	; 03801922
	blt loc_03801908	; 03801924
	ldr r5,[pool_038019A4]	; 03801926
	mov r7,#0x80	; 03801928
	b loc_03801932	; 0380192A
loc_0380192C:
	mov r0,#0x1	; 0380192C
	bl loc_03802244	; 0380192E
loc_03801932:
	ldrh r0,[r5,#0x0]	; 03801932
	and r0,r7	; 03801934
	cmp r0,#0x0	; 03801936
	bne loc_0380192C	; 03801938
	mov r5,#0x0	; 0380193A
	add r7,r5,#0x0	; 0380193C
	b loc_03801964	; 0380193E
loc_03801940:
	ldr r0,[pool_038019AC]	; 03801940
	strh r7,[r0,#0x0]	; 03801942
	b loc_0380194C	; 03801944
loc_03801946:
	mov r0,#0x1	; 03801946
	bl loc_03802244	; 03801948
loc_0380194C:
	ldr r0,[pool_038019A4]	; 0380194C
	ldrh r1,[r0,#0x0]	; 0380194E
	mov r0,#0x80	; 03801950
	and r1,r0	; 03801952
	cmp r1,#0x0	; 03801954
	bne loc_03801946	; 03801956
	ldr r0,[pool_038019AC]	; 03801958
	ldrh r1,[r0,#0x0]	; 0380195A
	mov r0,#0xff	; 0380195C
	and r1,r0	; 0380195E
	strb r1,[r6,r5]	; 03801960
	add r5,r5,#0x1	; 03801962
loc_03801964:
	sub r0,r4,#0x1	; 03801964
	cmp r5,r0	; 03801966
	bcc loc_03801940	; 03801968
	ldr r0,[pool_038019B0]	; 0380196A
	ldr r4,[pool_038019A4]	; 0380196C
	strh r0,[r4,#0x0]	; 0380196E
	mov r1,#0x0	; 03801970
	ldr r0,[pool_038019AC]	; 03801972
	strh r1,[r0,#0x0]	; 03801974
	mov r7,#0x80	; 03801976
	b loc_03801980	; 03801978
loc_0380197A:
	mov r0,#0x1	; 0380197A
	bl loc_03802244	; 0380197C
loc_03801980:
	ldrh r0,[r4,#0x0]	; 03801980
	and r0,r7	; 03801982
	cmp r0,#0x0	; 03801984
	bne loc_0380197A	; 03801986
	ldr r0,[pool_038019AC]	; 03801988
	ldrh r1,[r0,#0x0]	; 0380198A
	mov r0,#0xff	; 0380198C
	and r1,r0	; 0380198E
	strb r1,[r6,r5]	; 03801990
loc_03801992:
	add sp,#0xc	; 03801992
	pop {r4,r5,r6,r7}	; 03801994
	pop {r3}	; 03801996
	bx r3	; 03801998
	.byte 0xC0, 0x46	; 0380199C
pool_0380199C:
loc_0380199C:
	.word 0x00FF0000	; 0380199C
pool_038019A0:
loc_038019A0:
	.word 0x0000FF00	; 038019A0
pool_038019A4:
loc_038019A4:
	.word REG_SPICNT	; 038019A4
pool_038019A8:
loc_038019A8:
	.word 0x00008900	; 038019A8
pool_038019AC:
loc_038019AC:
	.word REG_SPIDATA	; 038019AC
pool_038019B0:
loc_038019B0:
	.word 0x00008100	; 038019B0

; ===== function loc_038019B4 =====
loc_038019B4:
	push {r4,r5,r6,r7,lr}	; 038019B4
	sub sp,#0x4	; 038019B6
	add r5,r0,#0x0	; 038019B8
	mov r7,#0x1	; 038019BA
	ldr r4,[pool_03801A24]	; 038019BC
	mov r6,#0x80	; 038019BE
	b loc_038019C8	; 038019C0
loc_038019C2:
	add r0,r7,#0x0	; 038019C2
	bl loc_03802244	; 038019C4
loc_038019C8:
	ldrh r0,[r4,#0x0]	; 038019C8
	and r0,r6	; 038019CA
	cmp r0,#0x0	; 038019CC
	bne loc_038019C2	; 038019CE
	ldr r0,[pool_03801A28]	; 038019D0
	strh r0,[r4,#0x0]	; 038019D2
	mov r1,#0x5	; 038019D4
	ldr r0,[pool_03801A2C]	; 038019D6
	strh r1,[r0,#0x0]	; 038019D8
	mov r7,#0x1	; 038019DA
	ldr r4,[pool_03801A24]	; 038019DC
	mov r6,#0x80	; 038019DE
	b loc_038019E8	; 038019E0
loc_038019E2:
	add r0,r7,#0x0	; 038019E2
	bl loc_03802244	; 038019E4
loc_038019E8:
	ldrh r0,[r4,#0x0]	; 038019E8
	and r0,r6	; 038019EA
	cmp r0,#0x0	; 038019EC
	bne loc_038019E2	; 038019EE
	ldr r0,[pool_03801A30]	; 038019F0
	strh r0,[r4,#0x0]	; 038019F2
	mov r1,#0x0	; 038019F4
	ldr r0,[pool_03801A2C]	; 038019F6
	strh r1,[r0,#0x0]	; 038019F8
	mov r7,#0x1	; 038019FA
	ldr r4,[pool_03801A24]	; 038019FC
	mov r6,#0x80	; 038019FE
	b loc_03801A08	; 03801A00
loc_03801A02:
	add r0,r7,#0x0	; 03801A02
	bl loc_03802244	; 03801A04
loc_03801A08:
	ldrh r0,[r4,#0x0]	; 03801A08
	and r0,r6	; 03801A0A
	cmp r0,#0x0	; 03801A0C
	bne loc_03801A02	; 03801A0E
	ldr r0,[pool_03801A2C]	; 03801A10
	ldrh r1,[r0,#0x0]	; 03801A12
	mov r0,#0xff	; 03801A14
	and r1,r0	; 03801A16
	strb r1,[r5,#0x0]	; 03801A18
	add sp,#0x4	; 03801A1A
	pop {r4,r5,r6,r7}	; 03801A1C
	pop {r3}	; 03801A1E
	bx r3	; 03801A20
	.byte 0xC0, 0x46	; 03801A24
pool_03801A24:
loc_03801A24:
	.word REG_SPICNT	; 03801A24
pool_03801A28:
loc_03801A28:
	.word 0x00008900	; 03801A28
pool_03801A2C:
loc_03801A2C:
	.word REG_SPIDATA	; 03801A2C
pool_03801A30:
loc_03801A30:
	.word 0x00008100	; 03801A30
P2_Entry_03801A34:
	push {r4,r5,r6,lr}	; 03801A34
	mov r6,#0x1	; 03801A36
	ldr r5,[pool_03801A74]	; 03801A38
	mov r4,#0x80	; 03801A3A
	b P2_Entry_03801A44	; 03801A3C
P2_Entry_03801A3E:
	add r0,r6,#0x0	; 03801A3E
	bl P2_SwiWaitByLoop	; 03801A40
P2_Entry_03801A44:
	ldrh r0,[r5,#0x0]	; 03801A44
	and r0,r4	; 03801A46
	cmp r0,#0x0	; 03801A48
	bne P2_Entry_03801A3E	; 03801A4A
	ldr r0,[pool_03801A78]	; 03801A4C
	strh r0,[r5,#0x0]	; 03801A4E
	mov r1,#0x4	; 03801A50
	ldr r0,[pool_03801A7C]	; 03801A52
	strh r1,[r0,#0x0]	; 03801A54
	mov r6,#0x1	; 03801A56
	ldr r5,[pool_03801A74]	; 03801A58
	mov r4,#0x80	; 03801A5A
	b P2_Entry_03801A64	; 03801A5C
P2_Entry_03801A5E:
	add r0,r6,#0x0	; 03801A5E
	bl P2_SwiWaitByLoop	; 03801A60
P2_Entry_03801A64:
	ldrh r0,[r5,#0x0]	; 03801A64
	and r0,r4	; 03801A66
	cmp r0,#0x0	; 03801A68
	bne P2_Entry_03801A5E	; 03801A6A
	pop {r4,r5,r6}	; 03801A6C
	pop {r3}	; 03801A6E
	bx r3	; 03801A70
	.byte 0xC0, 0x46	; 03801A72
pool_03801A74:
	.word REG_SPICNT	; 03801A74
pool_03801A78:
	.word 0x00008100	; 03801A78
pool_03801A7C:
	.word REG_SPIDATA	; 03801A7C
P2_Entry_03801A80:
	push {r4,r5,r6,lr}	; 03801A80
	mov r6,#0x1	; 03801A82
	ldr r5,[pool_03801AC0]	; 03801A84
	mov r4,#0x80	; 03801A86
	b P2_Entry_03801A90	; 03801A88
P2_Entry_03801A8A:
	add r0,r6,#0x0	; 03801A8A
	bl P2_SwiWaitByLoop	; 03801A8C
P2_Entry_03801A90:
	ldrh r0,[r5,#0x0]	; 03801A90
	and r0,r4	; 03801A92
	cmp r0,#0x0	; 03801A94
	bne P2_Entry_03801A8A	; 03801A96
	ldr r0,[pool_03801AC4]	; 03801A98
	strh r0,[r5,#0x0]	; 03801A9A
	mov r1,#0x6	; 03801A9C
	ldr r0,[pool_03801AC8]	; 03801A9E
	strh r1,[r0,#0x0]	; 03801AA0
	mov r6,#0x1	; 03801AA2
	ldr r5,[pool_03801AC0]	; 03801AA4
	mov r4,#0x80	; 03801AA6
	b P2_Entry_03801AB0	; 03801AA8
P2_Entry_03801AAA:
	add r0,r6,#0x0	; 03801AAA
	bl P2_SwiWaitByLoop	; 03801AAC
P2_Entry_03801AB0:
	ldrh r0,[r5,#0x0]	; 03801AB0
	and r0,r4	; 03801AB2
	cmp r0,#0x0	; 03801AB4
	bne P2_Entry_03801AAA	; 03801AB6
	pop {r4,r5,r6}	; 03801AB8
	pop {r3}	; 03801ABA
	bx r3	; 03801ABC
	.byte 0xC0, 0x46	; 03801ABE
pool_03801AC0:
	.word REG_SPICNT	; 03801AC0
pool_03801AC4:
	.word 0x00008100	; 03801AC4
pool_03801AC8:
	.word REG_SPIDATA	; 03801AC8
P2_Entry_03801ACC:
	push {r4,r5,lr}	; 03801ACC
	sub sp,#0x4	; 03801ACE
	add r4,r0,#0x0	; 03801AD0
	bl loc_037FB7EC	; 03801AD2
	add r5,r0,#0x0	; 03801AD6
	mov r0,#0x3	; 03801AD8
	bl P2_Entry_03800958	; 03801ADA
	cmp r0,#0x0	; 03801ADE
	bne P2_Entry_03801AF6	; 03801AE0
	add r0,r5,#0x0	; 03801AE2
	bl loc_037FB810	; 03801AE4
	ldr r0,[r4,#0x4]	; 03801AE8
	lsl r0,r0,#0x10	; 03801AEA
	lsr r0,r0,#0x10	; 03801AEC
	mov r1,#0x4	; 03801AEE
	bl loc_0380096C	; 03801AF0
	b P2_Entry_03801BB4	; 03801AF4
P2_Entry_03801AF6:
	mov r0,#0x3	; 03801AF6
	bl loc_03800948	; 03801AF8
	add r0,r5,#0x0	; 03801AFC
	bl loc_037FB810	; 03801AFE
	ldr r0,[r4,#0x4]	; 03801B02
	add r1,r0,#0x0	; 03801B04
	sub r1,#0x61	; 03801B06
	cmp r1,#0x5	; 03801B08
	bhi P2_Entry_03801BA4	; 03801B0A
	add r1,r1,r1	; 03801B0C
P2_SwitchIndexPC_03801B0C:
	add r1,pc	; 03801B0E
	ldrh r1,[r1,#(P2_SwitchTable_03801B0C - (P2_SwitchIndexPC_03801B0C + 4))]	; 03801B10
	lsl r1,r1,#0x10	; 03801B12
	asr r1,r1,#0x10	; 03801B14
P2_SwitchTargetPC_03801B0C:
	add r1,pc	; 03801B16
	bx r1	; 03801B18
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801B0C:
	.halfword (P2_Case_03801B26 + 1) - (P2_SwitchTargetPC_03801B0C + 4)
	.halfword (P2_Entry_03801BA4 + 1) - (P2_SwitchTargetPC_03801B0C + 4)
	.halfword (P2_Case_03801B84 + 1) - (P2_SwitchTargetPC_03801B0C + 4)
	.halfword (P2_Case_03801B3E + 1) - (P2_SwitchTargetPC_03801B0C + 4)
	.halfword (P2_Case_03801B62 + 1) - (P2_SwitchTargetPC_03801B0C + 4)
loc_03801B24:
	.halfword (P2_Case_03801B9C + 1) - (P2_SwitchTargetPC_03801B0C + 4)
P2_SwitchTable_03801B0CEnd:
P2_Case_03801B26:
	mov r1,#0x1	; 03801B26
	ldr r0,[pool_03801BBC]	; 03801B28
	str r1,[r0,#0x20]	; 03801B2A
	ldr r1,[r4,#0x8]	; 03801B2C
	ldr r0,[pool_03801BC0]	; 03801B2E
	strh r1,[r0,#0x0]	; 03801B30
	ldr r1,[r4,#0xc]	; 03801B32
	ldr r0,[pool_03801BC4]	; 03801B34
	strh r1,[r0,#0x0]	; 03801B36
	bl P2_Entry_03801FC8	; 03801B38
	b P2_Entry_03801BAE	; 03801B3C
P2_Case_03801B3E:
	mov r1,#0x4	; 03801B3E
	ldr r0,[pool_03801BBC]	; 03801B40
	str r1,[r0,#0x20]	; 03801B42
	ldr r2,[r4,#0x8]	; 03801B44
	str r2,[r0,#0x28]	; 03801B46
	ldr r1,[r4,#0xc]	; 03801B48
	str r1,[r0,#0x24]	; 03801B4A
	lsl r0,r2,#0x10	; 03801B4C
	lsr r0,r0,#0x10	; 03801B4E
	lsl r1,r1,#0x18	; 03801B50
	lsr r1,r1,#0x18	; 03801B52
	bl loc_03801E3C	; 03801B54
	mov r0,#0x64	; 03801B58
	mov r1,#0x0	; 03801B5A
	bl loc_0380096C	; 03801B5C
	b P2_Entry_03801BAE	; 03801B60
P2_Case_03801B62:
	mov r1,#0x3	; 03801B62
	ldr r0,[pool_03801BBC]	; 03801B64
	str r1,[r0,#0x20]	; 03801B66
	ldr r1,[r4,#0x8]	; 03801B68
	str r1,[r0,#0x28]	; 03801B6A
	lsl r0,r1,#0x10	; 03801B6C
	lsr r4,r0,#0x10	; 03801B6E
	add r0,r4,#0x0	; 03801B70
	bl P2_ReadPmicRegister	; 03801B72
	add r1,r0,#0x0	; 03801B76
	add r4,#0x70	; 03801B78
	lsl r0,r4,#0x10	; 03801B7A
	lsr r0,r0,#0x10	; 03801B7C
	bl loc_0380096C	; 03801B7E
	b P2_Entry_03801BAE	; 03801B82
P2_Case_03801B84:
	mov r0,#0x2	; 03801B84
	ldr r1,[pool_03801BBC]	; 03801B86
	str r0,[r1,#0x20]	; 03801B88
	ldr r0,[r4,#0x8]	; 03801B8A
	str r0,[r1,#0x24]	; 03801B8C
	bl P2_Entry_03801EF8	; 03801B8E
	mov r0,#0x63	; 03801B92
	mov r1,#0x0	; 03801B94
	bl loc_0380096C	; 03801B96
	b P2_Entry_03801BAE	; 03801B9A
P2_Case_03801B9C:
	ldr r0,[r4,#0x8]	; 03801B9C
	bl P2_Entry_03801EB4	; 03801B9E
	b P2_Entry_03801BAE	; 03801BA2
P2_Entry_03801BA4:
	lsl r0,r0,#0x10	; 03801BA4
	lsr r0,r0,#0x10	; 03801BA6
	mov r1,#0x1	; 03801BA8
	bl loc_0380096C	; 03801BAA
P2_Entry_03801BAE:
	mov r0,#0x3	; 03801BAE
	bl P2_Entry_03800920	; 03801BB0
P2_Entry_03801BB4:
	add sp,#0x4	; 03801BB4
	pop {r4,r5}	; 03801BB6
	pop {r3}	; 03801BB8
	bx r3	; 03801BBA
pool_03801BBC:
	.word P2_BssStart + 0x2674	; 03801BBC
pool_03801BC0:
	.word P2_BssStart + 0x266C	; 03801BC0
pool_03801BC4:
	.word P2_BssStart + 0x2668	; 03801BC4

; ===== function loc_03801BC8 =====
loc_03801BC8:
	push {r4,r5,r6,lr}	; 03801BC8
	sub sp,#0x8	; 03801BCA
	ldr r1,[pool_03801CF8]	; 03801BCC
	add r2,r0,#0x0	; 03801BCE
	and r2,r1	; 03801BD0
	cmp r2,#0x0	; 03801BD2
	beq loc_03801BE6	; 03801BD4
	mov r4,#0x0	; 03801BD6
	add r3,r4,#0x0	; 03801BD8
	ldr r1,[pool_03801CFC]	; 03801BDA
loc_03801BDC:
	lsl r2,r4,#0x1	; 03801BDC
	strh r3,[r1,r2]	; 03801BDE
	add r4,r4,#0x1	; 03801BE0
	cmp r4,#0x10	; 03801BE2
	blt loc_03801BDC	; 03801BE4
loc_03801BE6:
	ldr r1,[pool_03801D00]	; 03801BE6
	add r2,r0,#0x0	; 03801BE8
	and r2,r1	; 03801BEA
	lsr r1,r2,#0x10	; 03801BEC
	lsl r1,r1,#0x1	; 03801BEE
	ldr r5,[pool_03801CFC]	; 03801BF0
	strh r0,[r5,r1]	; 03801BF2
	ldr r1,[pool_03801D04]	; 03801BF4
	and r0,r1	; 03801BF6
	cmp r0,#0x0	; 03801BF8
	beq loc_03801CF0	; 03801BFA
	ldrh r3,[r5,#0x0]	; 03801BFC
	ldr r0,[pool_03801D08]	; 03801BFE
	add r1,r3,#0x0	; 03801C00
	and r1,r0	; 03801C02
	lsl r0,r1,#0x8	; 03801C04
	lsr r4,r0,#0x10	; 03801C06
	add r0,r4,#0x0	; 03801C08
	sub r0,#0x60	; 03801C0A
	cmp r0,#0x7	; 03801C0C
	bhi loc_03801CE8	; 03801C0E
	add r0,r0,r0	; 03801C10
P2_SwitchIndexPC_03801C10:
	add r0,pc	; 03801C12
	ldrh r0,[r0,#(P2_SwitchTable_03801C10 - (P2_SwitchIndexPC_03801C10 + 4))]	; 03801C14
	lsl r0,r0,#0x10	; 03801C16
	asr r0,r0,#0x10	; 03801C18
P2_SwitchTargetPC_03801C10:
	add r0,pc	; 03801C1A
	bx r0	; 03801C1C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801C10:
	.halfword (loc_03801C2E + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801C38 + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801CE8 + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801C9C + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801C5C + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801C80 + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801CC2 + 1) - (P2_SwitchTargetPC_03801C10 + 4)
	.halfword (loc_03801CD6 + 1) - (P2_SwitchTargetPC_03801C10 + 4)
P2_SwitchTable_03801C10End:
loc_03801C2E:
	mov r0,#0x60	; 03801C2E
	mov r1,#0x0	; 03801C30
	bl loc_0380096C	; 03801C32
	b loc_03801CF0	; 03801C36
loc_03801C38:
	ldrh r1,[r5,#0x2]	; 03801C38
	ldr r0,[pool_03801D0C]	; 03801C3A
	and r1,r0	; 03801C3C
	str r1,[sp,#0x0]	; 03801C3E
	mov r0,#0x3	; 03801C40
	add r1,r4,#0x0	; 03801C42
	mov r2,#0x2	; 03801C44
	mov r5,#0xff	; 03801C46
	and r3,r5	; 03801C48
	bl loc_03800878	; 03801C4A
	cmp r0,#0x0	; 03801C4E
	bne loc_03801CF0	; 03801C50
	add r0,r4,#0x0	; 03801C52
	mov r1,#0x4	; 03801C54
	bl loc_0380096C	; 03801C56
	b loc_03801CF0	; 03801C5A
loc_03801C5C:
	ldrh r1,[r5,#0x2]	; 03801C5C
	ldr r0,[pool_03801D0C]	; 03801C5E
	and r1,r0	; 03801C60
	str r1,[sp,#0x0]	; 03801C62
	mov r0,#0x3	; 03801C64
	add r1,r4,#0x0	; 03801C66
	mov r2,#0x2	; 03801C68
	mov r5,#0xff	; 03801C6A
	and r3,r5	; 03801C6C
	bl loc_03800878	; 03801C6E
	cmp r0,#0x0	; 03801C72
	bne loc_03801CF0	; 03801C74
	add r0,r4,#0x0	; 03801C76
	mov r1,#0x4	; 03801C78
	bl loc_0380096C	; 03801C7A
	b loc_03801CF0	; 03801C7E
loc_03801C80:
	mov r0,#0x3	; 03801C80
	add r1,r4,#0x0	; 03801C82
	mov r2,#0x1	; 03801C84
	ldr r5,[pool_03801D0C]	; 03801C86
	and r3,r5	; 03801C88
	bl loc_03800878	; 03801C8A
	cmp r0,#0x0	; 03801C8E
	bne loc_03801CF0	; 03801C90
	add r0,r4,#0x0	; 03801C92
	mov r1,#0x4	; 03801C94
	bl loc_0380096C	; 03801C96
	b loc_03801CF0	; 03801C9A
loc_03801C9C:
	mov r0,#0x3	; 03801C9C
	add r1,r4,#0x0	; 03801C9E
	mov r2,#0x1	; 03801CA0
	mov r6,#0xff	; 03801CA2
	and r3,r6	; 03801CA4
	lsl r3,r3,#0x10	; 03801CA6
	ldrh r6,[r5,#0x2]	; 03801CA8
	ldr r5,[pool_03801D0C]	; 03801CAA
	and r6,r5	; 03801CAC
	orr r3,r6	; 03801CAE
	bl loc_03800878	; 03801CB0
	cmp r0,#0x0	; 03801CB4
	bne loc_03801CF0	; 03801CB6
	add r0,r4,#0x0	; 03801CB8
	mov r1,#0x4	; 03801CBA
	bl loc_0380096C	; 03801CBC
	b loc_03801CF0	; 03801CC0
loc_03801CC2:
	mov r0,#0xff	; 03801CC2
	and r3,r0	; 03801CC4
	add r0,r3,#0x0	; 03801CC6
	bl loc_03802120	; 03801CC8
	mov r0,#0x66	; 03801CCC
	mov r1,#0x0	; 03801CCE
	bl loc_0380096C	; 03801CD0
	b loc_03801CF0	; 03801CD4
loc_03801CD6:
	bl loc_03802114	; 03801CD6
	add r1,r0,#0x0	; 03801CDA
	mov r0,#0x67	; 03801CDC
	lsl r1,r1,#0x10	; 03801CDE
	lsr r1,r1,#0x10	; 03801CE0
	bl loc_0380096C	; 03801CE2
	b loc_03801CF0	; 03801CE6
loc_03801CE8:
	add r0,r4,#0x0	; 03801CE8
	mov r1,#0x1	; 03801CEA
	bl loc_0380096C	; 03801CEC
loc_03801CF0:
	add sp,#0x8	; 03801CF0
	pop {r4,r5,r6}	; 03801CF2
	pop {r3}	; 03801CF4
	bx r3	; 03801CF6
pool_03801CF8:
loc_03801CF8:
	.word 0x02000000	; 03801CF8
pool_03801CFC:
loc_03801CFC:
	.word P2_BssStart + 0x2674	; 03801CFC
pool_03801D00:
loc_03801D00:
	.word 0x000F0000	; 03801D00
pool_03801D04:
loc_03801D04:
	.word 0x01000000	; 03801D04
pool_03801D08:
loc_03801D08:
	.word 0x0000FF00	; 03801D08
pool_03801D0C:
loc_03801D0C:
	.word 0x0000FFFF	; 03801D0C

; ===== function loc_03801D10 =====
loc_03801D10:
	mov r1,#0x1	; 03801D10
	ldr r0,[pool_03801D2C]	; 03801D12
	str r1,[r0,#0x0]	; 03801D14
	mov r3,#0x0	; 03801D16
	ldr r0,[pool_03801D30]	; 03801D18
	str r3,[r0,#0x20]	; 03801D1A
	add r2,r3,#0x0	; 03801D1C
loc_03801D1E:
	lsl r1,r3,#0x1	; 03801D1E
	strh r2,[r0,r1]	; 03801D20
	add r3,r3,#0x1	; 03801D22
	cmp r3,#0x10	; 03801D24
	blt loc_03801D1E	; 03801D26
	bx lr	; 03801D28
	.byte 0xC0, 0x46	; 03801D2C
pool_03801D2C:
loc_03801D2C:
	.word P2_BssStart + 0x2670	; 03801D2C
pool_03801D30:
loc_03801D30:
	.word P2_BssStart + 0x2674	; 03801D30
P2_Entry_03801D34:
	ldr r3,[pool_03801D50]	; 03801D34
	and r2,r3	; 03801D36
	ldr r3,[pool_03801D54]	; 03801D38
	and r0,r3	; 03801D3A
	lsl r3,r0,#0x16	; 03801D3C
	ldr r0,[pool_03801D58]	; 03801D3E
	and r1,r0	; 03801D40
	lsl r0,r1,#0x10	; 03801D42
	orr r3,r0	; 03801D44
	orr r2,r3	; 03801D46
	add r0,r2,#0x0	; 03801D48
	ldr r3,[pool_03801D5C]	; 03801D4A
	bx r3	; 03801D4C
	.byte 0xC0, 0x46	; 03801D4E
pool_03801D50:
	.word 0x0000FFFF	; 03801D50
pool_03801D54:
	.word 0x03C00000	; 03801D54
pool_03801D58:
	.word 0x003F0000	; 03801D58
pool_03801D5C:
	.word P2_Entry_03801D60 + 1	; 03801D5C
P2_Entry_03801D60:
	push {r4,r5,r6,lr}	; 03801D60
	add r5,r0,#0x0	; 03801D62
	mov r4,#0x8	; 03801D64
	mov r6,#0x0	; 03801D66
P2_Entry_03801D68:
	add r0,r4,#0x0	; 03801D68
	add r1,r5,#0x0	; 03801D6A
	add r2,r6,#0x0	; 03801D6C
	bl loc_037FFA18	; 03801D6E
	cmp r0,#0x0	; 03801D72
	bne P2_Entry_03801D68	; 03801D74
	pop {r4,r5,r6}	; 03801D76
	pop {r3}	; 03801D78
	bx r3	; 03801D7A

; ===== function loc_03801D7C =====
loc_03801D7C:
	push {r4,lr}	; 03801D7C
	add r4,r0,#0x0	; 03801D7E
	mov r0,#0x0	; 03801D80
	bl P2_ReadPmicRegister	; 03801D82
	bic r0,r4	; 03801D86
	lsl r0,r0,#0x18	; 03801D88
	lsr r1,r0,#0x18	; 03801D8A
	mov r0,#0x0	; 03801D8C
	bl loc_03801E3C	; 03801D8E
	pop {r4}	; 03801D92
	pop {r3}	; 03801D94
	bx r3	; 03801D96

; ===== function loc_03801D98 =====
loc_03801D98:
	push {r4,lr}	; 03801D98
	add r4,r0,#0x0	; 03801D9A
	mov r0,#0x0	; 03801D9C
	bl P2_ReadPmicRegister	; 03801D9E
	add r1,r0,#0x0	; 03801DA2
	orr r1,r4	; 03801DA4
	mov r0,#0x0	; 03801DA6
	bl loc_03801E3C	; 03801DA8
	pop {r4}	; 03801DAC
	pop {r3}	; 03801DAE
	bx r3	; 03801DB0
	.byte 0x00, 0x00	; 03801DB4

; ===== function loc_03801DB4 =====
loc_03801DB4:
; 通过 SPI 读取 r0 指定的电源管理寄存器，返回低 8 位。
; Read the PMIC register selected by r0 over SPI; return its low byte.
.func P2_ReadPmicRegister
	push {r4,r5,r6,r7,lr}	; 03801DB4
	sub sp,#0x4	; 03801DB6
	add r5,r0,#0x0	; 03801DB8
	mov r7,#0x1	; 03801DBA
	ldr r4,[pool_03801E34]	; 03801DBC
	mov r6,#0x80	; 03801DBE
	b loc_03801DC8	; 03801DC0
loc_03801DC2:
	add r0,r7,#0x0	; 03801DC2
	bl loc_03802244	; 03801DC4
loc_03801DC8:
	ldrh r0,[r4,#0x0]	; 03801DC8
	and r0,r6	; 03801DCA
	cmp r0,#0x0	; 03801DCC
	bne loc_03801DC2	; 03801DCE
	mov r0,#0x1	; 03801DD0
	bl P2_SetPmicSpiHold	; 03801DD2
	mov r4,#0x80	; 03801DD6
	orr r5,r4	; 03801DD8
	lsl r0,r5,#0x18	; 03801DDA
	lsr r1,r0,#0x18	; 03801DDC
	mov r0,#0xff	; 03801DDE
	and r1,r0	; 03801DE0
	ldr r0,[pool_03801E38]	; 03801DE2
	strh r1,[r0,#0x0]	; 03801DE4
	mov r6,#0x1	; 03801DE6
	ldr r5,[pool_03801E34]	; 03801DE8
	b loc_03801DF2	; 03801DEA
loc_03801DEC:
	add r0,r6,#0x0	; 03801DEC
	bl loc_03802244	; 03801DEE
loc_03801DF2:
	ldrh r0,[r5,#0x0]	; 03801DF2
	and r0,r4	; 03801DF4
	cmp r0,#0x0	; 03801DF6
	bne loc_03801DEC	; 03801DF8
	mov r0,#0x0	; 03801DFA
	bl P2_SetPmicSpiHold	; 03801DFC
	mov r1,#0x0	; 03801E00
	ldr r0,[pool_03801E38]	; 03801E02
	strh r1,[r0,#0x0]	; 03801E04
	mov r6,#0x1	; 03801E06
	ldr r5,[pool_03801E34]	; 03801E08
	mov r4,#0x80	; 03801E0A
	b loc_03801E14	; 03801E0C
loc_03801E0E:
	add r0,r6,#0x0	; 03801E0E
	bl loc_03802244	; 03801E10
loc_03801E14:
	ldrh r0,[r5,#0x0]	; 03801E14
	and r0,r4	; 03801E16
	cmp r0,#0x0	; 03801E18
	bne loc_03801E0E	; 03801E1A
	ldr r0,[pool_03801E38]	; 03801E1C
	ldrh r1,[r0,#0x0]	; 03801E1E
	mov r0,#0xff	; 03801E20
	and r1,r0	; 03801E22
	lsl r0,r1,#0x10	; 03801E24
	lsr r0,r0,#0x10	; 03801E26
	lsl r0,r0,#0x18	; 03801E28
	lsr r0,r0,#0x18	; 03801E2A
	add sp,#0x4	; 03801E2C
	pop {r4,r5,r6,r7}	; 03801E2E
	pop {r3}	; 03801E30
	bx r3	; 03801E32
.endfunc
pool_03801E34:
loc_03801E34:
	.word REG_SPICNT	; 03801E34
pool_03801E38:
loc_03801E38:
	.word REG_SPIDATA	; 03801E38

; ===== function loc_03801E3C =====
loc_03801E3C:
	push {r4,r5,r6,r7,lr}	; 03801E3C
	sub sp,#0x4	; 03801E3E
	add r5,r0,#0x0	; 03801E40
	add r4,r1,#0x0	; 03801E42
	ldr r6,[pool_03801E98]	; 03801E44
	mov r7,#0x80	; 03801E46
	b loc_03801E50	; 03801E48
loc_03801E4A:
	mov r0,#0x1	; 03801E4A
	bl loc_03802244	; 03801E4C
loc_03801E50:
	ldrh r0,[r6,#0x0]	; 03801E50
	and r0,r7	; 03801E52
	cmp r0,#0x0	; 03801E54
	bne loc_03801E4A	; 03801E56
	mov r0,#0x1	; 03801E58
	bl P2_SetPmicSpiHold	; 03801E5A
	lsl r0,r5,#0x18	; 03801E5E
	lsr r1,r0,#0x18	; 03801E60
	mov r0,#0xff	; 03801E62
	and r1,r0	; 03801E64
	ldr r0,[pool_03801E9C]	; 03801E66
	strh r1,[r0,#0x0]	; 03801E68
	mov r7,#0x1	; 03801E6A
	ldr r5,[pool_03801E98]	; 03801E6C
	mov r6,#0x80	; 03801E6E
	b loc_03801E78	; 03801E70
loc_03801E72:
	add r0,r7,#0x0	; 03801E72
	bl loc_03802244	; 03801E74
loc_03801E78:
	ldrh r0,[r5,#0x0]	; 03801E78
	and r0,r6	; 03801E7A
	cmp r0,#0x0	; 03801E7C
	bne loc_03801E72	; 03801E7E
	mov r0,#0x0	; 03801E80
	bl P2_SetPmicSpiHold	; 03801E82
	mov r0,#0xff	; 03801E86
	and r4,r0	; 03801E88
	ldr r0,[pool_03801E9C]	; 03801E8A
	strh r4,[r0,#0x0]	; 03801E8C
	add sp,#0x4	; 03801E8E
	pop {r4,r5,r6,r7}	; 03801E90
	pop {r3}	; 03801E92
	bx r3	; 03801E94
	.byte 0xC0, 0x46	; 03801E98
pool_03801E98:
loc_03801E98:
	.word REG_SPICNT	; 03801E98
pool_03801E9C:
loc_03801E9C:
	.word REG_SPIDATA	; 03801E9C

; ===== function loc_03801EA0 =====
loc_03801EA0:
; 选择 PMIC 的 SPI 通道；r0 控制两次传输之间是否保持片选。
; Select the PMIC SPI device; r0 controls chip-select hold between transfers.
.func P2_SetPmicSpiHold
	lsl r1,r0,#0xb	; 03801EA0
	ldr r0,[pool_03801EAC]	; 03801EA2
	orr r1,r0	; 03801EA4
	ldr r0,[pool_03801EB0]	; 03801EA6
	strh r1,[r0,#0x0]	; 03801EA8
	bx lr	; 03801EAA
.endfunc
pool_03801EAC:
loc_03801EAC:
	.word 0x00008002	; 03801EAC
pool_03801EB0:
loc_03801EB0:
	.word REG_SPICNT	; 03801EB0

; ===== function loc_03801EB4 =====
P2_Entry_03801EB4:
	push {r4,lr}	; 03801EB4
	add r4,r0,#0x0	; 03801EB6
	cmp r4,#0x1	; 03801EB8
	beq loc_03801EC6	; 03801EBA
	cmp r4,#0x2	; 03801EBC
	beq loc_03801ED6	; 03801EBE
	cmp r4,#0x3	; 03801EC0
	beq loc_03801ECE	; 03801EC2
	b loc_03801EE4	; 03801EC4
loc_03801EC6:
	mov r0,#0x10	; 03801EC6
	bl loc_03801D7C	; 03801EC8
	b loc_03801EE8	; 03801ECC
loc_03801ECE:
	mov r0,#0x30	; 03801ECE
	bl loc_03801D98	; 03801ED0
	b loc_03801EE8	; 03801ED4
loc_03801ED6:
	mov r0,#0x20	; 03801ED6
	bl loc_03801D7C	; 03801ED8
	mov r0,#0x10	; 03801EDC
	bl loc_03801D98	; 03801EDE
	b loc_03801EE8	; 03801EE2
loc_03801EE4:
	bl loc_037FCCC0	; 03801EE4
loc_03801EE8:
	ldr r0,[pool_03801EF4]	; 03801EE8
	str r4,[r0,#0x0]	; 03801EEA
	pop {r4}	; 03801EEC
	pop {r3}	; 03801EEE
	bx r3	; 03801EF0
	.byte 0xC0, 0x46	; 03801EF4
pool_03801EF4:
loc_03801EF4:
	.word P2_Data_03802C74	; 03801EF4
P2_Entry_03801EF8:
	push {lr}	; 03801EF8
	sub sp,#0x4	; 03801EFA
	cmp r0,#0xf	; 03801EFC
	bhi P2_Entry_03801FC0	; 03801EFE
	add r0,r0,r0	; 03801F00
P2_SwitchIndexPC_03801F00:
	add r0,pc	; 03801F02
	ldrh r0,[r0,#(P2_SwitchTable_03801F00 - (P2_SwitchIndexPC_03801F00 + 4))]	; 03801F04
	lsl r0,r0,#0x10	; 03801F06
	asr r0,r0,#0x10	; 03801F08
P2_SwitchTargetPC_03801F00:
	add r0,pc	; 03801F0A
	bx r0	; 03801F0C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801F00:
	.halfword (P2_Entry_03801FC0 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F2E + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F3C + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F4A + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F58 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F60 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F68 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F70 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F78 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F80 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F88 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F90 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801F98 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801FA0 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801FB0 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
	.halfword (P2_Case_03801FA8 + 1) - (P2_SwitchTargetPC_03801F00 + 4)
P2_SwitchTable_03801F00End:
P2_Case_03801F2E:
	mov r0,#0x1	; 03801F2E
	bl loc_03802120	; 03801F30
	mov r0,#0x1	; 03801F34
	bl P2_Entry_03801EB4	; 03801F36
	b P2_Entry_03801FC0	; 03801F3A
P2_Case_03801F3C:
	mov r0,#0x3	; 03801F3C
	bl loc_03802120	; 03801F3E
	mov r0,#0x3	; 03801F42
	bl P2_Entry_03801EB4	; 03801F44
	b P2_Entry_03801FC0	; 03801F48
P2_Case_03801F4A:
	mov r0,#0x2	; 03801F4A
	bl loc_03802120	; 03801F4C
	mov r0,#0x2	; 03801F50
	bl P2_Entry_03801EB4	; 03801F52
	b P2_Entry_03801FC0	; 03801F56
P2_Case_03801F58:
	mov r0,#0x4	; 03801F58
	bl loc_03801D98	; 03801F5A
	b P2_Entry_03801FC0	; 03801F5E
P2_Case_03801F60:
	mov r0,#0x4	; 03801F60
	bl loc_03801D7C	; 03801F62
	b P2_Entry_03801FC0	; 03801F66
P2_Case_03801F68:
	mov r0,#0x8	; 03801F68
	bl loc_03801D98	; 03801F6A
	b P2_Entry_03801FC0	; 03801F6E
P2_Case_03801F70:
	mov r0,#0x8	; 03801F70
	bl loc_03801D7C	; 03801F72
	b P2_Entry_03801FC0	; 03801F76
P2_Case_03801F78:
	mov r0,#0xc	; 03801F78
	bl loc_03801D98	; 03801F7A
	b P2_Entry_03801FC0	; 03801F7E
P2_Case_03801F80:
	mov r0,#0xc	; 03801F80
	bl loc_03801D7C	; 03801F82
	b P2_Entry_03801FC0	; 03801F86
P2_Case_03801F88:
	mov r0,#0x1	; 03801F88
	bl loc_03801D98	; 03801F8A
	b P2_Entry_03801FC0	; 03801F8E
P2_Case_03801F90:
	mov r0,#0x1	; 03801F90
	bl loc_03801D7C	; 03801F92
	b P2_Entry_03801FC0	; 03801F96
P2_Case_03801F98:
	mov r0,#0x2	; 03801F98
	bl loc_03801D98	; 03801F9A
	b P2_Entry_03801FC0	; 03801F9E
P2_Case_03801FA0:
	mov r0,#0x2	; 03801FA0
	bl loc_03801D7C	; 03801FA2
	b P2_Entry_03801FC0	; 03801FA6
P2_Case_03801FA8:
	mov r0,#0x40	; 03801FA8
	bl loc_03801D7C	; 03801FAA
	b P2_Entry_03801FC0	; 03801FAE
P2_Case_03801FB0:
	bl P2_Entry_037FCF60	; 03801FB0
	mov r0,#0x1	; 03801FB4
	bl loc_03801D7C	; 03801FB6
	mov r0,#0x40	; 03801FBA
	bl loc_03801D98	; 03801FBC
P2_Entry_03801FC0:
	add sp,#0x4	; 03801FC0
	pop {r3}	; 03801FC2
	bx r3	; 03801FC4
	.byte 0x00, 0x00	; 03801FC6
P2_Entry_03801FC8:
	push {r4,r5,r6,r7,lr}	; 03801FC8
	sub sp,#0x4	; 03801FCA
	ldr r1,[pool_038020DC]	; 03801FCC
	ldrh r4,[r1,#0x0]	; 03801FCE
	mov r0,#0x0	; 03801FD0
	strh r0,[r1,#0x0]	; 03801FD2
	bl loc_037FB7EC	; 03801FD4
	add r6,r0,#0x0	; 03801FD8
	ldr r0,[pool_038020E0]	; 03801FDA
	bl loc_037FB570	; 03801FDC
	add r7,r0,#0x0	; 03801FE0
	mov r0,#0x0	; 03801FE2
	bl P2_ReadPmicRegister	; 03801FE4
	str r0,[sp,#0x0]	; 03801FE8
	mov r0,#0x2	; 03801FEA
	bl loc_03802120	; 03801FEC
	mov r0,#0x2	; 03801FF0
	bl P2_Entry_03801EB4	; 03801FF2
	mov r0,#0x2	; 03801FF6
	bl P2_Entry_03801EB4	; 03801FF8
	bl P2_Entry_037FCF60	; 03801FFC
	mov r0,#0x1	; 03802000
	bl loc_03801D7C	; 03802002
	ldr r0,[pool_038020E4]	; 03802006
	ldrh r1,[r0,#0x0]	; 03802008
	mov r0,#0x1	; 0380200A
	and r1,r0	; 0380200C
	cmp r1,#0x0	; 0380200E
	beq P2_Entry_03802024	; 03802010
	ldr r0,[pool_038020E8]	; 03802012
	ldrh r1,[r0,#0x0]	; 03802014
	ldr r0,[pool_038020EC]	; 03802016
	orr r1,r0	; 03802018
	ldr r0,[pool_038020F0]	; 0380201A
	strh r1,[r0,#0x0]	; 0380201C
	ldr r0,[pool_038020F4]	; 0380201E
	bl loc_037FB59C	; 03802020
P2_Entry_03802024:
	ldr r0,[pool_038020E4]	; 03802024
	ldrh r1,[r0,#0x0]	; 03802026
	mov r0,#0x4	; 03802028
	and r1,r0	; 0380202A
	cmp r1,#0x0	; 0380202C
	beq P2_Entry_03802036	; 0380202E
	ldr r0,[pool_038020F8]	; 03802030
	bl loc_037FB59C	; 03802032
P2_Entry_03802036:
	ldr r0,[pool_038020E4]	; 03802036
	ldrh r1,[r0,#0x0]	; 03802038
	mov r0,#0x2	; 0380203A
	and r1,r0	; 0380203C
	cmp r1,#0x0	; 0380203E
	beq P2_Entry_03802062	; 03802040
	ldr r0,[pool_038020FC]	; 03802042
	ldrh r5,[r0,#0x0]	; 03802044
	ldr r0,[pool_03802100]	; 03802046
	bl loc_037FFC2C	; 03802048
	mov r0,#0x40	; 0380204C
	add r1,r0,#0x0	; 0380204E
	bl loc_037FFC40	; 03802050
	ldr r0,[pool_03802104]	; 03802054
	add r1,r0,#0x0	; 03802056
	bl loc_037FFC40	; 03802058
	mov r0,#0x80	; 0380205C
	bl loc_037FB59C	; 0380205E
P2_Entry_03802062:
	ldr r0,[pool_038020E4]	; 03802062
	ldrh r1,[r0,#0x0]	; 03802064
	mov r0,#0x8	; 03802066
	and r1,r0	; 03802068
	cmp r1,#0x0	; 0380206A
	beq P2_Entry_03802074	; 0380206C
	ldr r0,[pool_03802108]	; 0380206E
	bl loc_037FB59C	; 03802070
P2_Entry_03802074:
	ldr r0,[pool_038020E4]	; 03802074
	ldrh r1,[r0,#0x0]	; 03802076
	mov r0,#0x10	; 03802078
	and r1,r0	; 0380207A
	cmp r1,#0x0	; 0380207C
	beq P2_Entry_03802086	; 0380207E
	ldr r0,[pool_0380210C]	; 03802080
	bl loc_037FB59C	; 03802082
P2_Entry_03802086:
	add r0,r6,#0x0	; 03802086
	bl loc_037FB810	; 03802088
	ldr r1,[pool_038020DC]	; 0380208C
	ldrh r0,[r1,#0x0]	; 0380208E
	mov r0,#0x1	; 03802090
	strh r0,[r1,#0x0]	; 03802092
	bl P2_SwiStop	; 03802094
	mov r0,#0x0	; 03802098
	ldr r1,[sp,#0x0]	; 0380209A
	bl loc_03801E3C	; 0380209C
	ldr r0,[pool_038020FC]	; 038020A0
	strh r5,[r0,#0x0]	; 038020A2
	mov r0,#0x1	; 038020A4
	bl loc_03801D98	; 038020A6
	bl P2_Entry_037FCF2C	; 038020AA
	mov r1,#0x0	; 038020AE
	ldr r0,[pool_03802110]	; 038020B0
	str r1,[r0,#0x20]	; 038020B2
	mov r0,#0x62	; 038020B4
	add r2,r1,#0x0	; 038020B6
	bl P2_Entry_03801D34	; 038020B8
	bl loc_037FB7EC	; 038020BC
	add r0,r7,#0x0	; 038020C0
	bl loc_037FB59C	; 038020C2
	add r0,r6,#0x0	; 038020C6
	bl loc_037FB810	; 038020C8
	ldr r1,[pool_038020DC]	; 038020CC
	ldrh r0,[r1,#0x0]	; 038020CE
	strh r4,[r1,#0x0]	; 038020D0
	add sp,#0x4	; 038020D2
	pop {r4,r5,r6,r7}	; 038020D4
	pop {r3}	; 038020D6
	bx r3	; 038020D8
	.byte 0xC0, 0x46	; 038020DA
pool_038020DC:
	.word REG_IME	; 038020DC
pool_038020E0:
	.word 0x01FFFFFF	; 038020E0
pool_038020E4:
	.word P2_BssStart + 0x266C	; 038020E4
pool_038020E8:
	.word P2_BssStart + 0x2668	; 038020E8
pool_038020EC:
	.word 0x00004000	; 038020EC
pool_038020F0:
	.word REG_KEYCNT	; 038020F0
pool_038020F4:
	.word 0x00001000	; 038020F4
pool_038020F8:
	.word 0x00400000	; 038020F8
pool_038020FC:
	.word REG_RCNT_ARM7	; 038020FC
pool_03802100:
	.word 0x00008000	; 03802100
pool_03802104:
	.word 0x00000100	; 03802104
pool_03802108:
	.word 0x00100000	; 03802108
pool_0380210C:
	.word 0x00002000	; 0380210C
pool_03802110:
	.word P2_BssStart + 0x2674	; 03802110

; ===== function loc_03802114 =====
loc_03802114:
	ldr r0,[pool_0380211C]	; 03802114
	ldr r0,[r0,#0x0]	; 03802116
	bx lr	; 03802118
	.byte 0xC0, 0x46	; 0380211C
pool_0380211C:
loc_0380211C:
	.word P2_BssStart + 0x26A4	; 0380211C

; ===== function loc_03802120 =====
loc_03802120:
	cmp r0,#0xf	; 03802120
	bgt loc_0380212E	; 03802122
	ldr r1,[pool_03802130]	; 03802124
	str r0,[r1,#0x0]	; 03802126
	mov r1,#0x0	; 03802128
	ldr r0,[pool_03802134]	; 0380212A
	str r1,[r0,#0x0]	; 0380212C
loc_0380212E:
	bx lr	; 0380212E
pool_03802130:
loc_03802130:
	.word P2_BssStart + 0x26A4	; 03802130
pool_03802134:
loc_03802134:
	.word P2_BssStart + 0x26A0	; 03802134

; ===== function loc_03802138 =====
loc_03802138:
	push {r4,r5,r6,lr}	; 03802138
	ldr r0,[pool_038021D8]	; 0380213A
	ldr r3,[r0,#0x0]	; 0380213C
	cmp r3,#0x0	; 0380213E
	bne loc_0380215A	; 03802140
	mov r0,#0x3	; 03802142
	mov r1,#0x66	; 03802144
	mov r2,#0x1	; 03802146
	add r3,r2,#0x0	; 03802148
	bl loc_03800878	; 0380214A
	cmp r0,#0x0	; 0380214E
	beq loc_038021D0	; 03802150
	mov r0,#0x1	; 03802152
	bl loc_03802120	; 03802154
	b loc_038021D0	; 03802158
loc_0380215A:
	cmp r3,#0x4	; 0380215A
	bge loc_03802172	; 0380215C
	ldr r0,[pool_038021DC]	; 0380215E
	ldr r0,[r0,#0x0]	; 03802160
	cmp r3,r0	; 03802162
	beq loc_038021D0	; 03802164
	mov r0,#0x3	; 03802166
	mov r1,#0x66	; 03802168
	mov r2,#0x1	; 0380216A
	bl loc_03800878	; 0380216C
	b loc_038021D0	; 03802170
loc_03802172:
	ldr r6,[pool_038021E0]	; 03802172
	sub r4,r3,#0x4	; 03802174
	mov r0,#0xc	; 03802176
	mul r4,r0	; 03802178
	add r5,r6,r4	; 0380217A
	ldr r0,[pool_038021E4]	; 0380217C
	ldr r0,[r0,#0x0]	; 0380217E
	ldrh r1,[r5,#0xa]	; 03802180
	bl loc_03800D20	; 03802182
	add r2,r0,#0x0	; 03802186
	mov r0,#0x0	; 03802188
	ldr r1,[pool_038021E8]	; 0380218A
	bl loc_037FD410	; 0380218C
	ldr r3,[r6,r4]	; 03802190
	ldr r2,[r5,#0x4]	; 03802192
	and r2,r1	; 03802194
	and r3,r0	; 03802196
	mov r0,#0x0	; 03802198
	eor r2,r0	; 0380219A
	eor r3,r0	; 0380219C
	orr r2,r3	; 0380219E
	beq loc_038021A6	; 038021A0
	mov r3,#0x1	; 038021A2
	b loc_038021A8	; 038021A4
loc_038021A6:
	mov r3,#0x2	; 038021A6
loc_038021A8:
	ldr r0,[pool_038021E4]	; 038021A8
	ldr r1,[r0,#0x0]	; 038021AA
	add r4,r1,#0x1	; 038021AC
	str r4,[r0,#0x0]	; 038021AE
	ldrh r2,[r5,#0x8]	; 038021B0
	ldrh r1,[r5,#0xa]	; 038021B2
	mul r2,r1	; 038021B4
	cmp r4,r2	; 038021B6
	bcc loc_038021BE	; 038021B8
	mov r1,#0x0	; 038021BA
	str r1,[r0,#0x0]	; 038021BC
loc_038021BE:
	ldr r0,[pool_038021DC]	; 038021BE
	ldr r0,[r0,#0x0]	; 038021C0
	cmp r3,r0	; 038021C2
	beq loc_038021D0	; 038021C4
	mov r0,#0x3	; 038021C6
	mov r1,#0x66	; 038021C8
	mov r2,#0x1	; 038021CA
	bl loc_03800878	; 038021CC
loc_038021D0:
	pop {r4,r5,r6}	; 038021D0
	pop {r3}	; 038021D2
	bx r3	; 038021D4
	.byte 0xC0, 0x46	; 038021D8
pool_038021D8:
loc_038021D8:
	.word P2_BssStart + 0x26A4	; 038021D8
pool_038021DC:
loc_038021DC:
	.word P2_Data_03802C74	; 038021DC
pool_038021E0:
loc_038021E0:
	.word 0x03802C78	; 038021E0
pool_038021E4:
loc_038021E4:
	.word P2_BssStart + 0x26A0	; 038021E4
pool_038021E8:
loc_038021E8:
	.word 0x80000000	; 038021E8

; ===== function loc_038021EC =====
loc_038021EC:
	push {lr}	; 038021EC
	sub sp,#0x4	; 038021EE
	mov r0,#0x0	; 038021F0
	str r0,[sp,#0x0]	; 038021F2
	add r0,sp,#0x0	; 038021F4
	ldr r1,[pool_0380220C]	; 038021F6
	ldr r2,[pool_03802210]	; 038021F8
	bl loc_03802284	; 038021FA
	bl loc_03802214	; 038021FE
	ldr r1,[pool_0380220C]	; 03802202
	strh r0,[r1,#0x2]	; 03802204
	add sp,#0x4	; 03802206
	pop {r3}	; 03802208
	bx r3	; 0380220A
pool_0380220C:
loc_0380220C:
	.word P2_BssStart + 0x26A8	; 0380220C
pool_03802210:
loc_03802210:
	.word 0x05000001	; 03802210

; ===== function loc_03802214 =====
loc_03802214:
	bx pc	; 03802214
	.byte 0xC0, 0x46	; 03802218
.arm

; ===== function loc_03802218 =====
loc_03802218:
	ldr pc,[pool_0380221C]	; 03802218
pool_0380221C:
loc_0380221C:
	.word loc_037FB6B4	; 0380221C
.thumb

; ===== function loc_03802220 =====
loc_03802220:
	push {lr}	; 03802220
	sub sp,#0x4	; 03802222
	ldr r0,[pool_0380223C]	; 03802224
	ldr r1,[r0,#0x0]	; 03802226
	cmp r1,#0x0	; 03802228
	bne loc_03802234	; 0380222A
	mov r1,#0x1	; 0380222C
	str r1,[r0,#0x0]	; 0380222E
	bl loc_038021EC	; 03802230
loc_03802234:
	add sp,#0x4	; 03802234
	pop {r3}	; 03802236
	bx r3	; 03802238
	.byte 0xC0, 0x46	; 0380223C
pool_0380223C:
loc_0380223C:
	.word P2_BssStart + 0x26AC	; 0380223C
	.byte 0x00, 0xDF, 0x70, 0x47	; 03802244

; ===== function loc_03802244 =====
.func P2_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_03802244:
	swi 0x3	; 03802244
	bx lr	; 03802246
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

; ===== function loc_0380225E =====
.func P2_SwiHalt
; BIOS SWI #06: halt ARM7 until an interrupt. / BIOS SWI #06：使 ARM7 停止至中断发生。
loc_0380225E:
	swi 0x6	; 0380225E
	bx lr	; 03802260
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

; ===== function loc_0380226A =====
.func P2_SwiSoundBiasIncrease
; BIOS SWI #08 wrapper: request sound-bias increase. / BIOS SWI #08 封装：请求提高声音偏置。
loc_0380226A:
	add r1,r0,#0x0	; 0380226A
	mov r0,#0x1	; 0380226C
	swi 0x8	; 0380226E
	bx lr	; 03802270
.endfunc

; ===== function loc_03802272 =====
.func P2_SwiSoundBiasDecrease
; BIOS SWI #08 wrapper: request sound-bias decrease. / BIOS SWI #08 封装：请求降低声音偏置。
loc_03802272:
	add r1,r0,#0x0	; 03802272
	mov r0,#0x0	; 03802274
	swi 0x8	; 03802276
	bx lr	; 03802278
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
.endfunc	; 03802284

; ===== function loc_03802284 =====
.func P2_SwiCpuSet
; BIOS SWI #0B: configurable memory copy/fill. / BIOS SWI #0B：可配置的内存复制/填充。
loc_03802284:
	swi 0xb	; 03802284
	bx lr	; 03802286
.endfunc

; ===== function loc_03802288 =====
.func P2_SwiCpuFastSet
; BIOS SWI #0C: fast 32-byte memory copy/fill. / BIOS SWI #0C：快速 32 字节内存复制/填充。
loc_03802288:
	swi 0xc	; 03802288
	bx lr	; 0380228A
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

; ===== function loc_038022B4 =====
.func P2_SwiGetPitchTable
; BIOS SWI #1B: obtain pitch-table entry. / BIOS SWI #1B：取得音高表项。
loc_038022B4:
	swi 0x1b	; 038022B4
	bx lr	; 038022B6
.endfunc

; ===== function loc_038022B8 =====
.func P2_SwiGetVolumeTable
; BIOS SWI #1C: obtain volume-table entry. / BIOS SWI #1C：取得音量表项。
loc_038022B8:
	swi 0x1c	; 038022B8
	bx lr	; 038022BA
.endfunc
.arm

; ===== function loc_038022BC =====
loc_038022BC:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038022BC
	mov r4,#0x0	; 038022C0
	b loc_038022D0	; 038022C4
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 038022D0
loc_038022D0:
	orrs r5,r3,r2	; 038022D0
	bne loc_038022E0	; 038022D4
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038022D8
	bx lr	; 038022DC
loc_038022E0:
	orrs r5,r1,r3	; 038022E0
	bne loc_03802388	; 038022E4
	mov r1,r2	; 038022E8
	bl loc_03802728	; 038022EC
	cmp r4,#0x0	; 038022F0
	movne r0,r1	; 038022F4
	mov r1,#0x0	; 038022F8
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038022FC
	bx lr	; 03802300
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 03802314

; ===== function loc_03802314 =====
loc_03802314:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03802314
	eor r4,r1,r3	; 03802318
	mov r4,r4, asr #0x1	; 0380231C
	mov r4,r4, lsl #0x1	; 03802320
	orrs r5,r3,r2	; 03802324
	bne loc_03802334	; 03802328
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0380232C
	bx lr	; 03802330
loc_03802334:
	mov r5,r0, lsr #0x1f	; 03802334
	add r5,r5,r1	; 03802338
	mov r6,r2, lsr #0x1f	; 0380233C
	add r6,r6,r3	; 03802340
	orrs r6,r5,r6	; 03802344
	bne loc_03802368	; 03802348
	mov r1,r2	; 0380234C
	bl loc_03802514	; 03802350
	ands r4,r4,#0x1	; 03802354
	movne r0,r1	; 03802358
	mov r1,r0, asr #0x1f	; 0380235C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03802360
	bx lr	; 03802364
loc_03802368:
	cmp r1,#0x0	; 03802368
	bge loc_03802378	; 0380236C
	rsbs r0,r0,#0x0	; 03802370
	rsc r1,r1,#0x0	; 03802374
loc_03802378:
	cmp r3,#0x0	; 03802378
	bge loc_03802388	; 0380237C
	rsbs r2,r2,#0x0	; 03802380
	rsc r3,r3,#0x0	; 03802384
loc_03802388:
	orrs r5,r1,r0	; 03802388
	beq loc_038024AC	; 0380238C
	mov r5,#0x0	; 03802390
	mov r6,#0x1	; 03802394
	cmp r3,#0x0	; 03802398
	bmi loc_038023B4	; 0380239C
loc_038023A0:
	add r5,r5,#0x1	; 038023A0
	adds r2,r2,r2	; 038023A4
	adcs r3,r3,r3	; 038023A8
	bpl loc_038023A0	; 038023AC
	add r6,r6,r5	; 038023B0
loc_038023B4:
	cmp r1,#0x0	; 038023B4
	blt loc_038023D4	; 038023B8
loc_038023BC:
	cmp r6,#0x1	; 038023BC
	beq loc_038023D4	; 038023C0
	sub r6,r6,#0x1	; 038023C4
	adds r0,r0,r0	; 038023C8
	adcs r1,r1,r1	; 038023CC
	bpl loc_038023BC	; 038023D0
loc_038023D4:
	mov r7,#0x0	; 038023D4
	mov r12,#0x0	; 038023D8
	mov r11,#0x0	; 038023DC
	b loc_038023FC	; 038023E0
loc_038023E4:
	orr r12,r12,#0x1	; 038023E4
	subs r6,r6,#0x1	; 038023E8
	beq loc_03802454	; 038023EC
	adds r0,r0,r0	; 038023F0
	adcs r1,r1,r1	; 038023F4
	adcs r7,r7,r7	; 038023F8
loc_038023FC:
	subs r0,r0,r2	; 038023FC
	sbcs r1,r1,r3	; 03802400
	sbcs r7,r7,#0x0	; 03802404
	adds r12,r12,r12	; 03802408
	adc r11,r11,r11	; 0380240C
	cmp r7,#0x0	; 03802410
	bge loc_038023E4	; 03802414
loc_03802418:
	subs r6,r6,#0x1	; 03802418
	beq loc_0380244C	; 0380241C
	adds r0,r0,r0	; 03802420
	adcs r1,r1,r1	; 03802424
	adc r7,r7,r7	; 03802428
	adds r0,r0,r2	; 0380242C
	adcs r1,r1,r3	; 03802430
	adc r7,r7,#0x0	; 03802434
	adds r12,r12,r12	; 03802438
	adc r11,r11,r11	; 0380243C
	cmp r7,#0x0	; 03802440
	bge loc_038023E4	; 03802444
	b loc_03802418	; 03802448
loc_0380244C:
	adds r0,r0,r2	; 0380244C
	adc r1,r1,r3	; 03802450
loc_03802454:
	ands r7,r4,#0x1	; 03802454
	moveq r0,r12	; 03802458
	moveq r1,r11	; 0380245C
	beq loc_0380248C	; 03802460
	subs r7,r5,#0x20	; 03802464
	movge r0,r1, lsr r7	; 03802468
	bge loc_038024B0	; 0380246C
	rsb r7,r5,#0x20	; 03802470
	mov r0,r0, lsr r5	; 03802474
	orr r0,r0,r1, lsl r7	; 03802478
	mov r1,r1, lsr r5	; 0380247C
	b loc_0380248C	; 03802480
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0380248C
loc_0380248C:
	cmp r4,#0x0	; 0380248C
	blt loc_0380249C	; 03802490
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03802494
	bx lr	; 03802498
loc_0380249C:
	rsbs r0,r0,#0x0	; 0380249C
	rsc r1,r1,#0x0	; 038024A0
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038024A4
	bx lr	; 038024A8
loc_038024AC:
	mov r0,#0x0	; 038024AC
loc_038024B0:
	mov r1,#0x0	; 038024B0
	cmp r4,#0x0	; 038024B4
	blt loc_0380249C	; 038024B8
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038024BC
	bx lr	; 038024C0

; ===== function loc_038024C4 =====
loc_038024C4:
	stmdb sp!,{r4,r5,lr}	; 038024C4
	umull r5,r4,r0,r2	; 038024C8
	mla r4,r0,r3,r4	; 038024CC
	mla r4,r2,r1,r4	; 038024D0
	mov r1,r4	; 038024D4
	mov r0,r5	; 038024D8
	ldmia sp!,{r4,r5,lr}	; 038024DC
	bx lr	; 038024E0

; ===== function loc_038024E4 =====
loc_038024E4:
	ands r2,r2,#0x3f	; 038024E4
	bxeq lr	; 038024E8
	subs r3,r2,#0x20	; 038024EC
	bge loc_03802508	; 038024F0
	rsb r3,r2,#0x20	; 038024F4
	mov r1,r1, lsl r2	; 038024F8
	orr r1,r1,r0, lsr r3	; 038024FC
	mov r0,r0, lsl r2	; 03802500
	bx lr	; 03802504
loc_03802508:
	mov r1,r0, lsl r3	; 03802508
	mov r0,#0x0	; 0380250C
	bx lr	; 03802510

; ===== function loc_03802514 =====
loc_03802514:
	eor r12,r0,r1	; 03802514
	and r12,r12,#0x80000000	; 03802518
	cmp r0,#0x0	; 0380251C
	rsblt r0,r0,#0x0	; 03802520
	addlt r12,r12,#0x1	; 03802524
	cmp r1,#0x0	; 03802528
	rsblt r1,r1,#0x0	; 0380252C
	beq loc_0380270C	; 03802530
	cmp r0,r1	; 03802534
	movcc r1,r0	; 03802538
	movcc r0,#0x0	; 0380253C
	bcc loc_0380270C	; 03802540
	mov r2,#0x1c	; 03802544
	mov r3,r0, lsr #0x4	; 03802548
	cmp r1,r3, lsr #0xc	; 0380254C
	suble r2,r2,#0x10	; 03802550
	movle r3,r3, lsr #0x10	; 03802554
	cmp r1,r3, lsr #0x4	; 03802558
	suble r2,r2,#0x8	; 0380255C
	movle r3,r3, lsr #0x8	; 03802560
	cmp r1,r3	; 03802564
	suble r2,r2,#0x4	; 03802568
	movle r3,r3, lsr #0x4	; 0380256C
	mov r0,r0, lsl r2	; 03802570
	rsb r1,r1,#0x0	; 03802574
	adds r0,r0,r0	; 03802578
	add r2,r2,r2, lsl #0x1	; 0380257C
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03802580PC:
	add pc,pc,r2, lsl #0x2	; 03802580
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03802588
loc_03802588:
P2_DivisionDispatch_03802580Steps:
	adcs r3,r1,r3, lsl #0x1	; 03802588
	subcc r3,r3,r1	; 0380258C
	adcs r0,r0,r0	; 03802590
	adcs r3,r1,r3, lsl #0x1	; 03802594
	subcc r3,r3,r1	; 03802598
	adcs r0,r0,r0	; 0380259C
	adcs r3,r1,r3, lsl #0x1	; 038025A0
	subcc r3,r3,r1	; 038025A4
	adcs r0,r0,r0	; 038025A8
	adcs r3,r1,r3, lsl #0x1	; 038025AC
	subcc r3,r3,r1	; 038025B0
	adcs r0,r0,r0	; 038025B4
loc_038025B8:
	adcs r3,r1,r3, lsl #0x1	; 038025B8
	subcc r3,r3,r1	; 038025BC
	adcs r0,r0,r0	; 038025C0
	adcs r3,r1,r3, lsl #0x1	; 038025C4
	subcc r3,r3,r1	; 038025C8
	adcs r0,r0,r0	; 038025CC
	adcs r3,r1,r3, lsl #0x1	; 038025D0
	subcc r3,r3,r1	; 038025D4
	adcs r0,r0,r0	; 038025D8
	adcs r3,r1,r3, lsl #0x1	; 038025DC
	subcc r3,r3,r1	; 038025E0
	adcs r0,r0,r0	; 038025E4
loc_038025E8:
	adcs r3,r1,r3, lsl #0x1	; 038025E8
	subcc r3,r3,r1	; 038025EC
	adcs r0,r0,r0	; 038025F0
	adcs r3,r1,r3, lsl #0x1	; 038025F4
	subcc r3,r3,r1	; 038025F8
	adcs r0,r0,r0	; 038025FC
	adcs r3,r1,r3, lsl #0x1	; 03802600
	subcc r3,r3,r1	; 03802604
	adcs r0,r0,r0	; 03802608
	adcs r3,r1,r3, lsl #0x1	; 0380260C
	subcc r3,r3,r1	; 03802610
	adcs r0,r0,r0	; 03802614
	adcs r3,r1,r3, lsl #0x1	; 03802618
	subcc r3,r3,r1	; 0380261C
	adcs r0,r0,r0	; 03802620
	adcs r3,r1,r3, lsl #0x1	; 03802624
	subcc r3,r3,r1	; 03802628
	adcs r0,r0,r0	; 0380262C
	adcs r3,r1,r3, lsl #0x1	; 03802630
	subcc r3,r3,r1	; 03802634
	adcs r0,r0,r0	; 03802638
	adcs r3,r1,r3, lsl #0x1	; 0380263C
	subcc r3,r3,r1	; 03802640
	adcs r0,r0,r0	; 03802644
loc_03802648:
	adcs r3,r1,r3, lsl #0x1	; 03802648
	subcc r3,r3,r1	; 0380264C
	adcs r0,r0,r0	; 03802650
	adcs r3,r1,r3, lsl #0x1	; 03802654
	subcc r3,r3,r1	; 03802658
	adcs r0,r0,r0	; 0380265C
	adcs r3,r1,r3, lsl #0x1	; 03802660
	subcc r3,r3,r1	; 03802664
	adcs r0,r0,r0	; 03802668
	adcs r3,r1,r3, lsl #0x1	; 0380266C
	subcc r3,r3,r1	; 03802670
	adcs r0,r0,r0	; 03802674
	adcs r3,r1,r3, lsl #0x1	; 03802678
	subcc r3,r3,r1	; 0380267C
	adcs r0,r0,r0	; 03802680
	adcs r3,r1,r3, lsl #0x1	; 03802684
	subcc r3,r3,r1	; 03802688
	adcs r0,r0,r0	; 0380268C
	adcs r3,r1,r3, lsl #0x1	; 03802690
	subcc r3,r3,r1	; 03802694
	adcs r0,r0,r0	; 03802698
	adcs r3,r1,r3, lsl #0x1	; 0380269C
	subcc r3,r3,r1	; 038026A0
	adcs r0,r0,r0	; 038026A4
	adcs r3,r1,r3, lsl #0x1	; 038026A8
	subcc r3,r3,r1	; 038026AC
	adcs r0,r0,r0	; 038026B0
	adcs r3,r1,r3, lsl #0x1	; 038026B4
	subcc r3,r3,r1	; 038026B8
	adcs r0,r0,r0	; 038026BC
	adcs r3,r1,r3, lsl #0x1	; 038026C0
	subcc r3,r3,r1	; 038026C4
	adcs r0,r0,r0	; 038026C8
	adcs r3,r1,r3, lsl #0x1	; 038026CC
	subcc r3,r3,r1	; 038026D0
	adcs r0,r0,r0	; 038026D4
	adcs r3,r1,r3, lsl #0x1	; 038026D8
	subcc r3,r3,r1	; 038026DC
	adcs r0,r0,r0	; 038026E0
	adcs r3,r1,r3, lsl #0x1	; 038026E4
	subcc r3,r3,r1	; 038026E8
	adcs r0,r0,r0	; 038026EC
	adcs r3,r1,r3, lsl #0x1	; 038026F0
	subcc r3,r3,r1	; 038026F4
	adcs r0,r0,r0	; 038026F8
	adcs r3,r1,r3, lsl #0x1	; 038026FC
	subcc r3,r3,r1	; 03802700
	adcs r0,r0,r0	; 03802704
P2_DivisionDispatch_03802580End:
.if (P2_DivisionDispatch_03802580Steps != P2_DivisionDispatch_03802580PC + 8) || (P2_DivisionDispatch_03802580End - P2_DivisionDispatch_03802580Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03802708
loc_0380270C:
	ands r3,r12,#0x80000000	; 0380270C
	rsbne r0,r0,#0x0	; 03802710
	ands r3,r12,#0x1	; 03802714
	rsbne r1,r1,#0x0	; 03802718
	bx lr	; 0380271C

; ===== function loc_03802720 =====
loc_03802720:
	cmp r1,#0x0	; 03802720
	bxeq lr	; 03802724

; ===== function loc_03802728 =====
loc_03802728:
	cmp r0,r1	; 03802728
	movcc r1,r0	; 0380272C
	movcc r0,#0x0	; 03802730
	bxcc lr	; 03802734
	mov r2,#0x1c	; 03802738
	mov r3,r0, lsr #0x4	; 0380273C
	cmp r1,r3, lsr #0xc	; 03802740
	suble r2,r2,#0x10	; 03802744
	movle r3,r3, lsr #0x10	; 03802748
	cmp r1,r3, lsr #0x4	; 0380274C
	suble r2,r2,#0x8	; 03802750
	movle r3,r3, lsr #0x8	; 03802754
	cmp r1,r3	; 03802758
	suble r2,r2,#0x4	; 0380275C
	movle r3,r3, lsr #0x4	; 03802760
	mov r0,r0, lsl r2	; 03802764
	rsb r1,r1,#0x0	; 03802768
	adds r0,r0,r0	; 0380276C
	add r2,r2,r2, lsl #0x1	; 03802770
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03802774PC:
	add pc,pc,r2, lsl #0x2	; 03802774
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0380277C
loc_0380277C:
P2_DivisionDispatch_03802774Steps:
	adcs r3,r1,r3, lsl #0x1	; 0380277C
	subcc r3,r3,r1	; 03802780
	adcs r0,r0,r0	; 03802784
	adcs r3,r1,r3, lsl #0x1	; 03802788
	subcc r3,r3,r1	; 0380278C
	adcs r0,r0,r0	; 03802790
	adcs r3,r1,r3, lsl #0x1	; 03802794
	subcc r3,r3,r1	; 03802798
	adcs r0,r0,r0	; 0380279C
	adcs r3,r1,r3, lsl #0x1	; 038027A0
	subcc r3,r3,r1	; 038027A4
	adcs r0,r0,r0	; 038027A8
loc_038027AC:
	adcs r3,r1,r3, lsl #0x1	; 038027AC
	subcc r3,r3,r1	; 038027B0
	adcs r0,r0,r0	; 038027B4
	adcs r3,r1,r3, lsl #0x1	; 038027B8
	subcc r3,r3,r1	; 038027BC
	adcs r0,r0,r0	; 038027C0
	adcs r3,r1,r3, lsl #0x1	; 038027C4
	subcc r3,r3,r1	; 038027C8
	adcs r0,r0,r0	; 038027CC
	adcs r3,r1,r3, lsl #0x1	; 038027D0
	subcc r3,r3,r1	; 038027D4
	adcs r0,r0,r0	; 038027D8
loc_038027DC:
	adcs r3,r1,r3, lsl #0x1	; 038027DC
	subcc r3,r3,r1	; 038027E0
	adcs r0,r0,r0	; 038027E4
	adcs r3,r1,r3, lsl #0x1	; 038027E8
	subcc r3,r3,r1	; 038027EC
	adcs r0,r0,r0	; 038027F0
	adcs r3,r1,r3, lsl #0x1	; 038027F4
	subcc r3,r3,r1	; 038027F8
	adcs r0,r0,r0	; 038027FC
	adcs r3,r1,r3, lsl #0x1	; 03802800
	subcc r3,r3,r1	; 03802804
	adcs r0,r0,r0	; 03802808
	adcs r3,r1,r3, lsl #0x1	; 0380280C
	subcc r3,r3,r1	; 03802810
	adcs r0,r0,r0	; 03802814
	adcs r3,r1,r3, lsl #0x1	; 03802818
	subcc r3,r3,r1	; 0380281C
	adcs r0,r0,r0	; 03802820
	adcs r3,r1,r3, lsl #0x1	; 03802824
	subcc r3,r3,r1	; 03802828
	adcs r0,r0,r0	; 0380282C
	adcs r3,r1,r3, lsl #0x1	; 03802830
	subcc r3,r3,r1	; 03802834
	adcs r0,r0,r0	; 03802838
loc_0380283C:
	adcs r3,r1,r3, lsl #0x1	; 0380283C
	subcc r3,r3,r1	; 03802840
	adcs r0,r0,r0	; 03802844
	adcs r3,r1,r3, lsl #0x1	; 03802848
	subcc r3,r3,r1	; 0380284C
	adcs r0,r0,r0	; 03802850
	adcs r3,r1,r3, lsl #0x1	; 03802854
	subcc r3,r3,r1	; 03802858
	adcs r0,r0,r0	; 0380285C
	adcs r3,r1,r3, lsl #0x1	; 03802860
	subcc r3,r3,r1	; 03802864
	adcs r0,r0,r0	; 03802868
	adcs r3,r1,r3, lsl #0x1	; 0380286C
	subcc r3,r3,r1	; 03802870
	adcs r0,r0,r0	; 03802874
	adcs r3,r1,r3, lsl #0x1	; 03802878
	subcc r3,r3,r1	; 0380287C
	adcs r0,r0,r0	; 03802880
	adcs r3,r1,r3, lsl #0x1	; 03802884
	subcc r3,r3,r1	; 03802888
	adcs r0,r0,r0	; 0380288C
	adcs r3,r1,r3, lsl #0x1	; 03802890
	subcc r3,r3,r1	; 03802894
	adcs r0,r0,r0	; 03802898
	adcs r3,r1,r3, lsl #0x1	; 0380289C
	subcc r3,r3,r1	; 038028A0
	adcs r0,r0,r0	; 038028A4
	adcs r3,r1,r3, lsl #0x1	; 038028A8
	subcc r3,r3,r1	; 038028AC
	adcs r0,r0,r0	; 038028B0
	adcs r3,r1,r3, lsl #0x1	; 038028B4
	subcc r3,r3,r1	; 038028B8
	adcs r0,r0,r0	; 038028BC
	adcs r3,r1,r3, lsl #0x1	; 038028C0
	subcc r3,r3,r1	; 038028C4
	adcs r0,r0,r0	; 038028C8
	adcs r3,r1,r3, lsl #0x1	; 038028CC
	subcc r3,r3,r1	; 038028D0
	adcs r0,r0,r0	; 038028D4
	adcs r3,r1,r3, lsl #0x1	; 038028D8
	subcc r3,r3,r1	; 038028DC
	adcs r0,r0,r0	; 038028E0
	adcs r3,r1,r3, lsl #0x1	; 038028E4
	subcc r3,r3,r1	; 038028E8
	adcs r0,r0,r0	; 038028EC
	adcs r3,r1,r3, lsl #0x1	; 038028F0
	subcc r3,r3,r1	; 038028F4
	adcs r0,r0,r0	; 038028F8
P2_DivisionDispatch_03802774End:
.if (P2_DivisionDispatch_03802774Steps != P2_DivisionDispatch_03802774PC + 8) || (P2_DivisionDispatch_03802774End - P2_DivisionDispatch_03802774Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 038028FC
	bx lr	; 03802900

; ===== function loc_03802904 =====
loc_03802904:
	ands r2,r2,#0x3f	; 03802904
	bxeq lr	; 03802908
	subs r3,r2,#0x20	; 0380290C
	bge loc_03802928	; 03802910
	rsb r3,r2,#0x20	; 03802914
	mov r0,r0, lsr r2	; 03802918
	orr r0,r0,r1, lsl r3	; 0380291C
	mov r1,r1, lsr r2	; 03802920
	bx lr	; 03802924
loc_03802928:
	mov r0,r1, lsr r3	; 03802928
	mov r1,#0x0	; 0380292C
	bx lr	; 03802930

; ===== function loc_03802934 =====
loc_03802934:
	stmdb sp!,{lr}	; 03802934
	bl loc_038029DC	; 03802938
	mov r1,#0x0	; 0380293C
	str r1,[r0,#0x0]	; 03802940
	bl loc_038029E8	; 03802944
	mov r1,#0x0	; 03802948
	str r1,[r0,#0x4]	; 0380294C
	str r1,[r0,#0x8]	; 03802950
	str r1,[r0,#0xc]	; 03802954
	str r1,[r0,#0x10]	; 03802958
	str r1,[r0,#0x14]	; 0380295C
	ldmia sp!,{lr}	; 03802960
	bx lr	; 03802964
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x1A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03802978
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03802988
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 03802998
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 038029A8
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x0A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 038029B8
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 038029C8
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 038029D8
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 038029DC

; ===== function loc_038029DC =====
loc_038029DC:
	ldr r12,[pool_038029E4]	; 038029DC
	bx r12	; 038029E0
pool_038029E4:
loc_038029E4:
	.word loc_03802A2C + 1	; 038029E4

; ===== function loc_038029E8 =====
loc_038029E8:
	ldr r12,[pool_038029F0]	; 038029E8
	bx r12	; 038029EC
pool_038029F0:
loc_038029F0:
	.word loc_03802A34 + 1	; 038029F0
.thumb

; ===== function loc_038029F4 =====
loc_038029F4:
	bx r0	; 038029F4
	.byte 0x00, 0x00	; 038029F8

; ===== function loc_038029F8 =====
loc_038029F8:
	bx r1	; 038029F8
	.byte 0x00, 0x00	; 038029FC

; ===== function loc_038029FC =====
loc_038029FC:
	bx r2	; 038029FC
	.byte 0x00, 0x00	; 03802A00

; ===== function loc_03802A00 =====
loc_03802A00:
	bx r3	; 03802A00
	.byte 0x00, 0x00	; 03802A04

; ===== function loc_03802A04 =====
loc_03802A04:
	bx r4	; 03802A04
	.byte 0x00, 0x00	; 03802A08

; ===== function loc_03802A08 =====
loc_03802A08:
	bx r5	; 03802A08
	.byte 0x00, 0x00	; 03802A0C

; Calls a null-terminated function-pointer list in ascending address order.
; 按地址递增顺序调用以空指针终止的函数指针表。
.func P2_RunFunctionPointerList
loc_03802A0C:
	push {r4,lr}	; 03802A0C
	ldr r4,[pool_03802A28]	; 03802A0E
	b loc_03802A16	; 03802A10
loc_03802A12:
	blx r0	; 03802A12
	add r4,r4,#0x4	; 03802A14
loc_03802A16:
	cmp r4,#0x0	; 03802A16
	beq loc_03802A20	; 03802A18
	ldr r0,[r4,#0x0]	; 03802A1A
	cmp r0,#0x0	; 03802A1C
	bne loc_03802A12	; 03802A1E
loc_03802A20:
	pop {r4}	; 03802A20
	pop {r3}	; 03802A22
	bx r3	; 03802A24
.endfunc
	.byte 0xC0, 0x46	; 03802A28
pool_03802A28:
loc_03802A28:
	.word 0x03802BB8	; 03802A28

; ===== function loc_03802A2C =====
loc_03802A2C:
	ldr r0,[pool_03802A30]	; 03802A2C
	bx lr	; 03802A2E
pool_03802A30:
loc_03802A30:
	.word 0x038053B8	; 03802A30

; ===== function loc_03802A34 =====
loc_03802A34:
	ldr r0,[pool_03802A38]	; 03802A34
	bx lr	; 03802A36
pool_03802A38:
loc_03802A38:
	.word 0x038053BC	; 03802A38
	.byte 0x0D, 0x2A, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00	; 03802A3C
P2_Data_03802A48:
	.byte 0x49, 0x32, 0x00, 0x00	; 03802A48
P2_Data_03802A4C:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 03802A4C
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 03802A5C
P2_Data_03802A6C:
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 03802A6C
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 03802A7C
	.byte 0x7F, 0x00, 0x00, 0x00	; 03802A8C
P2_Data_03802A90:
	.byte 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 03802A90
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 03802A9C
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 03802AAC
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 03802ABC
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 03802ACC
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 03802ADC
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 03802AEC
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 03802AFC
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 03802B0C
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 03802B1C
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 03802B2C
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 03802B3C
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 03802B4C
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 03802B5C
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 03802B6C
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 03802B7C
	.byte 0xFF, 0xFF, 0x00, 0x00	; 03802B8C
P2_Data_03802B90:
	.byte 0x00, 0x01, 0x02, 0x04	; 03802B90
P2_Data_03802B94:
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 03802B94
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D	; 03802B9C
P2_Data_03802BA4:
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 03802BA4
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 03802BAC
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P2_CrtDataInitTable:
	.word P2_CopyDescriptors, P2_CopyDescriptorsEnd
	.word P2_WramCopy0LoadStart
	.word P2_BssStart, P2_BssEnd
P2_Data_03802BD0:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 03802BD0
	.byte 0x00, 0x00, 0x00, 0x00	; 03802BE0
P2_Data_03802BE4:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P2_IrqHandlers:
	.word P2_IrqHandler_037FB458 + 1	; IRQ 0
	.word loc_037FB548 + 1	; IRQ 1
	.word loc_037FB548 + 1	; IRQ 2
	.word P2_IrqHandler_037FB4B0 + 1	; IRQ 3
	.word P2_IrqHandler_037FB4A4 + 1	; IRQ 4
	.word P2_IrqHandler_037FB498 + 1	; IRQ 5
	.word P2_IrqHandler_037FB48C + 1	; IRQ 6
	.word loc_037FB548 + 1	; IRQ 7
	.word P2_IrqHandler_037FB4E0 + 1	; IRQ 8
	.word P2_IrqHandler_037FB4D4 + 1	; IRQ 9
	.word P2_IrqHandler_037FB4C8 + 1	; IRQ 10
	.word P2_IrqHandler_037FB4BC + 1	; IRQ 11
	.word loc_037FB548 + 1	; IRQ 12
	.word loc_037FB548 + 1	; IRQ 13
	.word loc_037FB548 + 1	; IRQ 14
	.word loc_037FB548 + 1	; IRQ 15
	.word loc_037FB548 + 1	; IRQ 16
	.word loc_037FB548 + 1	; IRQ 17
	.word loc_037FB548 + 1	; IRQ 18
	.word loc_037FB548 + 1	; IRQ 19
	.word loc_037FB548 + 1	; IRQ 20
	.word loc_037FB548 + 1	; IRQ 21
	.word loc_037FB548 + 1	; IRQ 22
	.word loc_037FB548 + 1	; IRQ 23
	.word loc_037FB548 + 1	; IRQ 24
P2_IrqHandlersEnd:
	.byte 0x19, 0xB9, 0x7F, 0x03	; 03802C48
.thumb
P2_Data_03802C4C:
	.word 0x12345678	; 03802C5C
; ARM7 sound-alarm diagnostic string. / ARM7 声音告警诊断字符串。
P2_SoundAlarmDiagnosticText:
	.ascii "Failed sound alarm OS_SendMessage"
	.byte 0x0A, 0x00, 0x00	; 03802C71
P2_Data_03802C74:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x08	; 03802C74
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC, 0x08, 0x00, 0x01, 0x00, 0x00	; 03802C81
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03802C91
	.byte 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0xF8, 0x14	; 03802CA1
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x0C, 0x00, 0x01, 0x00, 0x00	; 03802CB1
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03802CC1
	.byte 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x20	; 03802CD1
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00	; 03802CE1
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03802CF1
	.byte 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00	; 03802D01
; CRT 复制后，此保存区复用为主 BSS；下游偏移仍保留原内存布局。
; After CRT copying, reuse this load area as BSS; keep the original field offsets.
P2_BssStart:
; 本 CPU 的 32 项 FIFO 回调表，按通道索引；位于 CRT 清零的 BSS。
; This CPU's 32 FIFO callback slots, indexed by channel, live in CRT-cleared BSS.
.definelabel P2_PxiReceiveCallbacks, P2_BssStart + 0x1D2C
.definelabel P2_PxiReceiveCallbacksEnd, P2_PxiReceiveCallbacks + PxiFifoChannelCount * 4
.definelabel P2_CachedFirmwareHeader, P2_BssStart + 0x24
.definelabel P2_BssEnd, P2_BssStart + 0x26CC

; 按运行地址汇编；物理字节仍保留在组件的初始化数据区。
; Assemble at the copied execution address; keep bytes in the load image.
P2_WramCopy0LoadStart:
.headersize 0x037F8000 - orga()
P2_WramCopy0RuntimeStart:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8000
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8010
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8020
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8030
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8040
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8050
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8060
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8070
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8080
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8090
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F80A0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F80B0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F80C0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F80D0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F80E0
P2_Runtime_037F80F0:
.thumb
	push {r4,r5,r6,lr}	; 037F80F0
	ldr r0,[pool_037F8124]	; 037F80F2
	bl P2_Entry_037FBF3C	; 037F80F4
	ldr r6,[pool_037F8128]	; 037F80F8
	ldr r5,[pool_037F812C]	; 037F80FA
	mov r4,#0x1	; 037F80FC
	b P2_Entry_037F8106	; 037F80FE
P2_Runtime_037F8100:
	add r0,r6,#0x0	; 037F8100
	bl P2_SwiWaitByLoop	; 037F8102
P2_Entry_037F8106:
	ldrh r1,[r5,#0x0]	; 037F8106
	add r0,r1,#0x0	; 037F8108
	and r0,r4	; 037F810A
	cmp r0,#0x0	; 037F810C
	bne P2_Runtime_037F8100	; 037F810E
	mov r0,#0x1	; 037F8110
	orr r1,r0	; 037F8112
	strh r1,[r5,#0x0]	; 037F8114
	ldr r0,[pool_037F8130]	; 037F8116
	ldr r0,[r0,#0x18]	; 037F8118
	ldr r0,[r0,#0x8]	; 037F811A
	pop {r4,r5,r6}	; 037F811C
	pop {r3}	; 037F811E
	bx r3	; 037F8120
	.byte 0xC0, 0x46	; 037F8122
pool_037F8124:
	.word P4_ServicePrimaryThreadRecord	; 037F8124
pool_037F8128:
	.word 0x00000100	; 037F8128
pool_037F812C:
	.word 0x027FFF96	; 037F812C
pool_037F8130:
	.word P4_ServicePrimaryThreadRecord + 0x8	; 037F8130
P2_Runtime_037F8134:
	push {r4,r5,r6,lr}	; 037F8134
	ldr r0,[pool_037F8160]	; 037F8136
	bl P2_Entry_037FBF3C	; 037F8138
	ldr r6,[pool_037F8164]	; 037F813C
	ldr r5,[pool_037F8168]	; 037F813E
	mov r4,#0x1	; 037F8140
	b P2_Entry_037F814A	; 037F8142
P2_Runtime_037F8144:
	add r0,r6,#0x0	; 037F8144
	bl P2_SwiWaitByLoop	; 037F8146
P2_Entry_037F814A:
	ldrh r0,[r5,#0x0]	; 037F814A
	and r0,r4	; 037F814C
	cmp r0,#0x0	; 037F814E
	bne P2_Runtime_037F8144	; 037F8150
	ldr r0,[pool_037F8160]	; 037F8152
	bl P2_Entry_037FBEF4	; 037F8154
	pop {r4,r5,r6}	; 037F8158
	pop {r3}	; 037F815A
	bx r3	; 037F815C
	.byte 0xC0, 0x46	; 037F815E
pool_037F8160:
	.word P4_ServicePrimaryThreadRecord	; 037F8160
pool_037F8164:
	.word 0x00000100	; 037F8164
pool_037F8168:
	.word 0x027FFF96	; 037F8168
P2_Runtime_037F816C:
	push {r4,r5,r6,r7,lr}	; 037F816C
	sub sp,#0x4	; 037F816E
	add r5,r0,#0x0	; 037F8170
	ldr r4,[pool_037F819C]	; 037F8172
	mov r6,#0xa	; 037F8174
	mov r7,#0x0	; 037F8176
	b P2_Entry_037F8180	; 037F8178
P2_Runtime_037F817A:
	add r0,r4,#0x0	; 037F817A
	bl P2_SwiWaitByLoop	; 037F817C
P2_Entry_037F8180:
	add r0,r6,#0x0	; 037F8180
	add r1,r5,#0x0	; 037F8182
	add r2,r7,#0x0	; 037F8184
	bl loc_037FFA18	; 037F8186
	cmp r0,#0x0	; 037F818A
	blt P2_Runtime_037F817A	; 037F818C
	ldr r0,[pool_037F81A0]	; 037F818E
	bl P2_Entry_037FBEF4	; 037F8190
	add sp,#0x4	; 037F8194
	pop {r4,r5,r6,r7}	; 037F8196
	pop {r3}	; 037F8198
	bx r3	; 037F819A
pool_037F819C:
	.word 0x00000100	; 037F819C
pool_037F81A0:
	.word P4_ServicePrimaryThreadRecord	; 037F81A0
P2_WramCopy0RuntimeEnd:
.definelabel P2_WramCopy0ZeroBytes, 0x0
.definelabel P2_WramCopy0BssStart, P2_WramCopy0RuntimeEnd
.definelabel P2_WramCopy0BssEnd, P2_WramCopy0BssStart + P2_WramCopy0ZeroBytes
; P4 服务线程使用的两个栈顶 / Stack tops used by P4 service threads.
.definelabel P2_P4ServicePrimaryThreadStackTop, P2_WramCopy0RuntimeStart + 0x78
.definelabel P2_P4ServiceSecondaryThreadStackTop, P2_WramCopy0RuntimeStart
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
	bl loc_037FF938	; 0380F61C
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
	bl loc_038029F4	; 0380F668
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
	ldr r0,[pool_0380F758]	; 0380F6FC
	ldr r1,[pool_0380F75C]	; 0380F700
	bl P2_Runtime_0380F8A4	; 0380F704
	ldr r0,[pool_0380F760]	; 0380F708
	ldr r1,[pool_0380F764]	; 0380F70C
	bl P2_Runtime_0380F8A4	; 0380F710
	ldr r3,[pool_0380F768]	; 0380F714
	ldrh r1,[r3,#0x0]	; 0380F718
	cmp r1,#0x2	; 0380F71C
	beq P2_Runtime_0380F754	; 0380F720
	ldr r3,[pool_0380F76C]	; 0380F724
	ldr r1,[r3,#0x0]	; 0380F728
	cmp r1,#0x0	; 0380F72C
	beq P2_Runtime_0380F754	; 0380F730
	ldr r3,[pool_0380F770]	; 0380F734
	ldr r0,[r3,#0x38]	; 0380F738
	ldr r2,[r3,#0x3c]	; 0380F73C
	str r1,[r3,#0x38]	; 0380F740
	bl P2_WramCopy1RuntimeStart	; 0380F744
	ldr r0,[pool_0380F774]	; 0380F748
	add r1,r0,#0x40000	; 0380F74C
	bl P2_Runtime_0380F8A4	; 0380F750
P2_Runtime_0380F754:
	bx r11	; 0380F754
pool_0380F758:
	.word 0x02300000	; 0380F758
pool_0380F75C:
	.word 0x023FE800	; 0380F75C
pool_0380F760:
	.word P2_WramCopy0RuntimeStart	; 0380F760
pool_0380F764:
	.word P2_WramCopy1RuntimeStart	; 0380F764
pool_0380F768:
	.word FirmwareBootParamAddress	; 0380F768
pool_0380F76C:
	.word FirmwareBootSharedAddress	; 0380F76C
pool_0380F770:
	.word NdsCartHeaderRamAddress	; 0380F770
pool_0380F774:
	.word 0x022C0000	; 0380F774
P2_Runtime_0380F778:
	mov r12,lr	; 0380F778
	mov r0,#0xd3	; 0380F77C
	msr cpsr_cxsf,r0	; 0380F780
	ldr sp,[pool_0380F804]	; 0380F784
	mov lr,#0x0	; 0380F788
	msr spsr_cxsf,lr	; 0380F78C
	mov r0,#0xd2	; 0380F790
	msr cpsr_cxsf,r0	; 0380F794
	ldr r2,[pool_0380F808]	; 0380F798
	mov sp,r2	; 0380F79C
	mov lr,#0x0	; 0380F7A0
	msr spsr_cxsf,lr	; 0380F7A4
	mov r0,#0xdf	; 0380F7A8
	msr cpsr_cxsf,r0	; 0380F7AC
	mov r1,#0x200	; 0380F7B0
	sub r1,r2,r1	; 0380F7B4
	mov sp,r1	; 0380F7B8
	ldr r2,[pool_0380F80C]	; 0380F7BC
	sub r0,r2,#0x600	; 0380F7C0
	mov r1,r2	; 0380F7C4
	bl P2_Runtime_0380F8A4	; 0380F7C8
	sub r0,r2,#0xa00	; 0380F7CC
	ldr r1,[pool_0380F810]	; 0380F7D0
	bl P2_Runtime_0380F8A4	; 0380F7D4
	ldr r2,[pool_0380F814]	; 0380F7D8
	mov r0,r2	; 0380F7DC
	add r1,r2,#0x800	; 0380F7E0
	bl P2_Runtime_0380F8A4	; 0380F7E4
	add r0,r2,#0xd80	; 0380F7E8
	add r1,r0,#0x80	; 0380F7EC
	bl P2_Runtime_0380F8A4	; 0380F7F0
	add r0,r2,#0xf80	; 0380F7F4
	add r1,r0,#0x80	; 0380F7F8
	bl P2_Runtime_0380F8A4	; 0380F7FC
	bx r12	; 0380F800
pool_0380F804:
	.word 0x0380FFC0	; 0380F804
pool_0380F808:
	.word 0x0380FF80	; 0380F808
pool_0380F80C:
	.word 0x03810000	; 0380F80C
pool_0380F810:
	.word P2_WramCopy2RuntimeStart	; 0380F810
pool_0380F814:
	.word 0x027FF000	; 0380F814

; 与 ARM9 完成 IPC 握手和内存准备，再跳至 NDS 头指定的 ARM7 入口。
; Finish IPC handshaking and memory setup, then enter the NDS header's ARM7 entry.
.func P2_SyncAndEnterArm7Program
	ldr r1,[pool_0380F894]	; 0380F818
	mov r0,#0x200	; 0380F81C
	strh r0,[r1,#0x0]	; 0380F820
P2_Runtime_0380F824:
	ldrh r0,[r1,#0x0]	; 0380F824
	and r0,r0,#0xf	; 0380F828
	cmp r0,#0x2	; 0380F82C
	bne P2_Runtime_0380F824	; 0380F830
	bl P2_Runtime_0380F6F8	; 0380F834
	ldr r1,[pool_0380F898]	; 0380F838
	bl P2_Runtime_0380F8A0	; 0380F83C
	ldr r1,[pool_0380F894]	; 0380F840
	mov r0,#0x100	; 0380F844
	strh r0,[r1,#0x0]	; 0380F848
P2_Runtime_0380F84C:
	ldrh r0,[r1,#0x0]	; 0380F84C
	and r0,r0,#0xf	; 0380F850
	cmp r0,#0x1	; 0380F854
	bne P2_Runtime_0380F84C	; 0380F858
	bl P2_Runtime_0380F778	; 0380F85C
	ldr r1,[pool_0380F894]	; 0380F860
	mov r0,#0x0	; 0380F864
	strh r0,[r1,#0x0]	; 0380F868
P2_Runtime_0380F86C:
	ldrh r0,[r1,#0x0]	; 0380F86C
	cmp r0,#0x1	; 0380F870
	beq P2_Runtime_0380F86C	; 0380F874
	ldr r3,[pool_0380F89C]	; 0380F878
	ldr r12,[r3,#-0x1cc]	; 0380F87C
	mov lr,r12	; 0380F880
	mov r11,#0x4000000	; 0380F884
	ldmdb r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 0380F888
	mov r11,#0x0	; 0380F88C
	bx r12	; 0380F890
.endfunc
pool_0380F894:
	.word REG_IPC_SYNC	; 0380F894
pool_0380F898:
	.word P2_RuntimeThumbVeneer_0380F64C + 1	; 0380F898
pool_0380F89C:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 0380F89C
P2_Runtime_0380F8A0:
	bx r1	; 0380F8A0
P2_Runtime_0380F8A4:
	mov r3,#0x0	; 0380F8A4
	mov r4,r3	; 0380F8A8
	mov r5,r3	; 0380F8AC
	mov r6,r3	; 0380F8B0
	mov r7,r3	; 0380F8B4
	mov r8,r3	; 0380F8B8
	mov r9,r3	; 0380F8BC
	mov r10,r3	; 0380F8C0
P2_Runtime_0380F8C4:
	cmp r0,r1	; 0380F8C4
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 0380F8C8
	blt P2_Runtime_0380F8C4	; 0380F8CC
	bx lr	; 0380F8D0
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
.thumb
.close
