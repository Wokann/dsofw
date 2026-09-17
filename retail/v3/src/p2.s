; official_v3_p2
; Readable armips reconstruction exported from Ghidra.
; Recognised code is assembly; data is retained only where Ghidra has no instruction.
.nds
.create "build/p2.bin", 0x037FA800
.arm
; ARM7 入口：关中断、清理 ARM7 WRAM、建立各模式栈后转入服务代码。
; ARM7 entry: masks IRQs, clears ARM7 WRAM, sets mode stacks, then enters services.
.func P2_Arm7ResetBootstrap
loc_037FA800:
	mov r12,#0x4000000	; 037FA800
	str r12,[r12,#0x208]	; 037FA804
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
	bl loc_03804F80	; 037FA870
	bl P2_NoOperation	; 037FA874
	bl loc_037FA8AC	; 037FA878
	ldr r1,[pool_037FA8A4]	; 037FA87C
	ldr lr,[pool_037FA8A8]	; 037FA880
	bx r1	; 037FA884
.endfunc
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
	.word loc_03805058 + 1	; 037FA8B4

; ===== function loc_037FA8B8 =====
; 执行复制表并将 BSS 清零，结构与标准 CRT 初始化相符。
; Applies the copy table and clears BSS, matching standard CRT initialization.
.func P2_InitializeDataAndBss
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
.endfunc

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
	.word P2_Data_03805094	; 037FA988
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
	bl loc_037FDA78	; 037FA9F0
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
	bl loc_037FF1A0	; 037FAA12
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
	bl loc_037FD9FC	; 037FAA58
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
	.word 0x03807A4C	; 037FAA68
pool_037FAA6C:
loc_037FAA6C:
	.word 0x0380F600	; 037FAA6C
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
	.word 0x022C0000	; 037FAAF0
pool_037FAAF4:
loc_037FAAF4:
	.word 0x02300200	; 037FAAF4
pool_037FAAF8:
loc_037FAAF8:
	.word FirmwareBootSharedAddress + BootSharedP3StagingOffset	; 037FAAF8
pool_037FAAFC:
loc_037FAAFC:
	.word P2_BssStart + 0x18	; 037FAAFC
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
	.word 0x022C0000	; 037FAB38
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
	bl loc_0380286C	; 037FABDE
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
	bl loc_0380284C	; 037FABFA
	ldr r0,[pool_037FAC28]	; 037FABFE
	bl loc_03802934	; 037FAC00
	ldr r0,[pool_037FAC28]	; 037FAC04
	bl loc_038028CC	; 037FAC06
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
	bl loc_0380284C	; 037FAC1E
	add sp,#0x4	; 037FAC22
	pop {r3}	; 037FAC24
	bx r3	; 037FAC26
pool_037FAC28:
loc_037FAC28:
	.word 0x03805358	; 037FAC28

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
	bl loc_037FDE9C	; 037FAC3A
	pop {r4}	; 037FAC3E
	pop {r3}	; 037FAC40
	bx r3	; 037FAC42
.endfunc
pool_037FAC44:
loc_037FAC44:
	.word P2_BssStart + 0x18	; 037FAC44
pool_037FAC48:
loc_037FAC48:
	.word 0x038053A4	; 037FAC48

; ===== function P2_RunTransferRequestServiceLoop =====
; Continuously services the four-field transfer descriptor submitted above.
; 持续处理上方提交的四字段传输描述符。
.func P2_RunTransferRequestServiceLoop
loc_037FAC4C:
	push {r4,r5,r6,r7,lr}	; 037FAC4C
	sub sp,#0x4	; 037FAC4E
	mov r6,#0x0	; 037FAC50
	mov r7,#0x3	; 037FAC52
	ldr r4,[pool_037FAC98]	; 037FAC54
	ldr r5,[pool_037FAC9C]	; 037FAC56
loc_037FAC58:
	ldr r0,[r5,#0x0]	; 037FAC58
	bl loc_03802EF4	; 037FAC5A
	ldr r0,[r4,#0x0]	; 037FAC5E
	cmp r0,#0x0	; 037FAC60
	beq loc_037FAC80	; 037FAC62
	str r6,[r4,#0xc]	; 037FAC64
	ldr r0,[r4,#0x4]	; 037FAC66
	add r1,r7,#0x0	; 037FAC68
	ldr r2,[pool_037FACA0]	; 037FAC6A
	bl loc_03803F10	; 037FAC6C
	ldr r0,[r4,#0xc]	; 037FAC70
	lsr r1,r0,#0x2	; 037FAC72
	str r1,[r4,#0xc]	; 037FAC74
	ldr r0,[r4,#0x4]	; 037FAC76
	ldr r2,[r4,#0x8]	; 037FAC78
	bl loc_03803F10	; 037FAC7A
	b loc_037FAC8A	; 037FAC7E
loc_037FAC80:
	ldr r0,[r4,#0x4]	; 037FAC80
	ldr r1,[r4,#0xc]	; 037FAC82
	ldr r2,[r4,#0x8]	; 037FAC84
	bl loc_03803F10	; 037FAC86
loc_037FAC8A:
	ldr r0,[r5,#0x0]	; 037FAC8A
	bl loc_03802EAC	; 037FAC8C
	add r0,r6,#0x0	; 037FAC90
	bl loc_037FDF08	; 037FAC92
	b loc_037FAC58	; 037FAC96
.endfunc
pool_037FAC98:
loc_037FAC98:
	.word 0x0380536C	; 037FAC98
pool_037FAC9C:
loc_037FAC9C:
	.word P2_BssStart + 0x14	; 037FAC9C
pool_037FACA0:
loc_037FACA0:
	.word 0x03805378	; 037FACA0

; ===== function loc_037FACA4 =====
P2_IrqHandler_037FACA4:
	push {lr}	; 037FACA4
	sub sp,#0x4	; 037FACA6
	ldr r0,[pool_037FACC4]	; 037FACA8
	ldr r0,[r0,#0x0]	; 037FACAA
	cmp r0,#0x0	; 037FACAC
	beq loc_037FACB4	; 037FACAE
	bl loc_03804790	; 037FACB0
loc_037FACB4:
	ldr r2,[pool_037FACC8]	; 037FACB4
	ldr r1,[r2,#0x0]	; 037FACB6
	mov r0,#0x1	; 037FACB8
	orr r1,r0	; 037FACBA
	str r1,[r2,#0x0]	; 037FACBC
	add sp,#0x4	; 037FACBE
	pop {r3}	; 037FACC0
	bx r3	; 037FACC2
pool_037FACC4:
loc_037FACC4:
	.word P2_BssStart + 0x269C	; 037FACC4
pool_037FACC8:
loc_037FACC8:
	.word Bios7IrqFlagsAddress	; 037FACC8
; 通道 1 的用户回调：将主工作区的首字写为 6。
; Channel 1 user callback: write 6 to the first main-work word.
.func P2_PxiChannel1UserCallback
	mov r1,#0x6	; 037FACCC
	ldr r0,[pool_037FACD4]	; 037FACCE
	str r1,[r0,#0x0]	; 037FACD0
	bx lr	; 037FACD2
.endfunc
pool_037FACD4:
loc_037FACD4:
	.word P2_BssStart	; 037FACD4
P2_PxiCallback_037FACD8:
	cmp r1,#0x3	; 037FACD8
	bne loc_037FACE4	; 037FACDA
	mov r1,#0x6	; 037FACDC
	ldr r0,[pool_037FAD08]	; 037FACDE
	str r1,[r0,#0x0]	; 037FACE0
	bx lr	; 037FACE2
loc_037FACE4:
	cmp r1,#0x6	; 037FACE4
	bne loc_037FACF0	; 037FACE6
	mov r1,#0x5	; 037FACE8
	ldr r0,[pool_037FAD08]	; 037FACEA
	str r1,[r0,#0x0]	; 037FACEC
	bx lr	; 037FACEE
loc_037FACF0:
	cmp r1,#0x4	; 037FACF0
	bne loc_037FACFC	; 037FACF2
	mov r1,#0x9	; 037FACF4
	ldr r0,[pool_037FAD08]	; 037FACF6
	str r1,[r0,#0x0]	; 037FACF8
	bx lr	; 037FACFA
loc_037FACFC:
	cmp r1,#0x7	; 037FACFC
	bne loc_037FAD06	; 037FACFE
	mov r1,#0x8	; 037FAD00
	ldr r0,[pool_037FAD08]	; 037FAD02
	str r1,[r0,#0x0]	; 037FAD04
loc_037FAD06:
	bx lr	; 037FAD06
pool_037FAD08:
loc_037FAD08:
	.word P2_BssStart	; 037FAD08

; ===== function P2_OrSharedEventFlags =====
; ORs caller-supplied flags into the guarded shared event field.
; 在受保护的共享事件字段中合并调用方提供的标志位。
.func P2_OrSharedEventFlags
loc_037FAD0C:
	push {r4,lr}	; 037FAD0C
	add r4,r0,#0x0	; 037FAD0E
	mov r0,#0xae	; 037FAD10
	ldr r1,[pool_037FAD30]	; 037FAD12
	mov r2,#0x0	; 037FAD14
	bl loc_037FDD40	; 037FAD16
	ldr r1,[pool_037FAD30]	; 037FAD1A
	ldr r0,[r1,#0x8]	; 037FAD1C
	orr r0,r4	; 037FAD1E
	str r0,[r1,#0x8]	; 037FAD20
	mov r0,#0xae	; 037FAD22
	mov r2,#0x0	; 037FAD24
	bl loc_037FDCCC	; 037FAD26
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
	ldr r1,[pool_037FAF18]	; 037FAD3E
	ldr r2,[pool_037FAF1C]	; 037FAD40
	bl P2_SwiCpuFastSet	; 037FAD42
	ldr r1,[pool_037FAF20]	; 037FAD46
; 锁定 Lite 扩展寄存器；写入值保持 FFFF。
; Lock the Lite extension registers; retain the original FFFF write.
	ldr r0,[pool_037FAF24]	; 037FAD48
	strh r1,[r0,#0x0]	; 037FAD4A
	ldr r0,[pool_037FAF28]	; 037FAD4C
	ldr r2,[pool_037FAF2C]	; 037FAD4E
	strh r0,[r2,#0x0]	; 037FAD50
	mov r1,#0x0	; 037FAD52
	ldr r0,[pool_037FAF30]	; 037FAD54
	str r1,[r0,#0x0]	; 037FAD56
	str r1,[r2,#0x0]	; 037FAD58
	mov r0,#0xd	; 037FAD5A
	bl loc_038043F0	; 037FAD5C
	mov r1,#0x1	; 037FAD60
	ldr r0,[pool_037FAF34]	; 037FAD62
	strh r1,[r0,#0x0]	; 037FAD64
	mov r0,#0x10	; 037FAD66
	bl P2_SwiSoundBiasIncrease	; 037FAD68
	bl loc_037FABD8	; 037FAD6C
	bl loc_037FE440	; 037FAD70
	ldr r0,[pool_037FAF38]	; 037FAD74
	bl P2_InitPxiChannel1Callback	; 037FAD76
	bl loc_037FAFCC	; 037FAD7A
	mov r0,#0x8	; 037FAD7E
	ldr r1,[pool_037FAF3C]	; 037FAD80
	bl loc_037FE46C	; 037FAD82
	mov r0,#0x8	; 037FAD86
	ldr r1,[pool_037FAF40]	; 037FAD88
	bl loc_037FE478	; 037FAD8A
	bl loc_03802098	; 037FAD8E
	mov r0,#0x2	; 037FAD92
	bl loc_03802F3C	; 037FAD94
	mov r0,#0x3	; 037FAD98
	bl loc_037FFA58	; 037FAD9A
	mov r0,#0x8	; 037FAD9E
	bl loc_038024F4	; 037FADA0
	bl loc_037FAFA8	; 037FADA4
	ldr r1,[pool_037FAF44]	; 037FADA8
	str r0,[r1,#0x0]	; 037FADAA
	mov r0,#0x2	; 037FADAC
	ldr r1,[pool_037FAF48]	; 037FADAE
	bl P2_SetPxiReceiveCallback	; 037FADB0
	ldr r0,[pool_037FAF4C]	; 037FADB4
	str r0,[sp,#0x0]	; 037FADB6
	mov r0,#0xe	; 037FADB8
	str r0,[sp,#0x4]	; 037FADBA
	ldr r0,[pool_037FAF50]	; 037FADBC
	ldr r1,[pool_037FAF54]	; 037FADBE
	mov r2,#0x0	; 037FADC0
	ldr r3,[pool_037FAF58]	; 037FADC2
	bl P2_CreateThread	; 037FADC4
	bl P2_InitializeBootProcedureCallbacks	; 037FADC8
	ldr r0,[pool_037FAF5C]	; 037FADCC
	ldr r1,[pool_037FAF60]	; 037FADCE
	ldr r1,[r1,#0x0]	; 037FADD0
	bl loc_037FDAD0	; 037FADD2
	mov r0,#0x1	; 037FADD6
	ldr r1,[pool_037FAF64]	; 037FADD8
	bl loc_037FDAD0	; 037FADDA
	mov r0,#0x1	; 037FADDE
	bl loc_037FDA4C	; 037FADE0
	bl loc_037FAFB4	; 037FADE4
	ldr r2,[pool_037FAF68]	; 037FADE8
	ldrh r0,[r2,#0x0]	; 037FADEA
	ldrh r1,[r2,#0x0]	; 037FADEC
	mov r0,#0x8	; 037FADEE
	orr r1,r0	; 037FADF0
	strh r1,[r2,#0x0]	; 037FADF2
	ldr r1,[pool_037FAF6C]	; 037FADF4
	ldrh r0,[r1,#0x0]	; 037FADF6
	mov r0,#0x1	; 037FADF8
	strh r0,[r1,#0x0]	; 037FADFA
	bl P2_LoadFirmwareHeaderAndSettingsOffset	; 037FADFC
	bl P2_LoadFirmwarePart5ToStaging	; 037FAE00
	mov r0,#0x3	; 037FAE04
	ldr r5,[pool_037FAF70]	; 037FAE06
	str r0,[r5,#0x0]	; 037FAE08
	ldr r7,[pool_037FAF74]	; 037FAE0A
	mov r6,#0x2	; 037FAE0C
	ldr r4,[pool_037FAF78]	; 037FAE0E
loc_037FAE10:
	mov r0,#0x1	; 037FAE10
	lsl r1,r0,#0	; 037FAE12
	bl loc_037FF124	; 037FAE14
	ldr r0,[r4,#0x24]	; 037FAE18
	cmp r0,#0x3	; 037FAE1A
	bne loc_037FAE4E	; 037FAE1C
	ldr r1,[r7,#0x0]	; 037FAE1E
	ldr r0,[pool_037FAF7C]	; 037FAE20
	and r1,r0	; 037FAE22
	cmp r1,#0x0	; 037FAE24
	beq loc_037FAE10	; 037FAE26
	ldr r0,[r7,#0x0]	; 037FAE28
	and r0,r6	; 037FAE2A
	cmp r0,#0x0	; 037FAE2C
	beq loc_037FAE4A	; 037FAE2E
	ldr r1,[r7,#0x0]	; 037FAE30
	mov r0,#0x4	; 037FAE32
	and r1,r0	; 037FAE34
	cmp r1,#0x0	; 037FAE36
	bne loc_037FAE4A	; 037FAE38
	bl P2_ClearMainRamOutsideArm9Image	; 037FAE3A
	mov r0,#0xac	; 037FAE3E
	bl loc_037FDC28	; 037FAE40
	mov r0,#0x4	; 037FAE44
	str r0,[r5,#0x0]	; 037FAE46
	b loc_037FAE10	; 037FAE48
loc_037FAE4A:
	str r6,[r5,#0x0]	; 037FAE4A
	b loc_037FAE10	; 037FAE4C
loc_037FAE4E:
	ldr r0,[r4,#0x24]	; 037FAE4E
	cmp r0,#0x4	; 037FAE50
	bne loc_037FAE74	; 037FAE52
	ldr r0,[pool_037FAF80]	; 037FAE54
	ldr r0,[r0,#0x0]	; 037FAE56
	bl loc_03805040	; 037FAE58
	mov r1,#0x1	; 037FAE5C
	mvn r1,r1	; 037FAE5E
	cmp r0,r1	; 037FAE60
	bne loc_037FAE10	; 037FAE62
	mov r0,#0xac	; 037FAE64
	bl loc_037FDB5C	; 037FAE66
	ldr r0,[pool_037FAF84]	; 037FAE6A
	bl P2_OrSharedEventFlags	; 037FAE6C
	str r6,[r5,#0x0]	; 037FAE70
	b loc_037FAE10	; 037FAE72
loc_037FAE74:
	ldr r0,[r4,#0x24]	; 037FAE74
	cmp r0,#0x2	; 037FAE76
	beq loc_037FAE80	; 037FAE78
	ldr r0,[r4,#0x24]	; 037FAE7A
	cmp r0,#0x7	; 037FAE7C
	bne loc_037FAE92	; 037FAE7E
loc_037FAE80:
	ldr r0,[pool_037FAF88]	; 037FAE80
	ldr r0,[r0,#0x0]	; 037FAE82
	cmp r0,#0x0	; 037FAE84
	beq loc_037FAE10	; 037FAE86
	str r0,[r5,#0x0]	; 037FAE88
	mov r1,#0x0	; 037FAE8A
	ldr r0,[pool_037FAF88]	; 037FAE8C
	str r1,[r0,#0x0]	; 037FAE8E
	b loc_037FAE10	; 037FAE90
loc_037FAE92:
	ldr r0,[r4,#0x24]	; 037FAE92
	cmp r0,#0x6	; 037FAE94
	bne loc_037FAEAC	; 037FAE96
	ldr r0,[pool_037FAF8C]	; 037FAE98
	ldr r0,[r0,#0x0]	; 037FAE9A
	cmp r0,#0x7	; 037FAE9C
	bne loc_037FAE10	; 037FAE9E
	bl P2_ResetArm7Peripherals	; 037FAEA0
	ldr r1,[pool_037FAF90]	; 037FAEA4
	ldr r0,[pool_037FAF94]	; 037FAEA6
	strh r1,[r0,#0x0]	; 037FAEA8
	b loc_037FAF0E	; 037FAEAA
loc_037FAEAC:
	ldr r0,[r4,#0x24]	; 037FAEAC
	cmp r0,#0x5	; 037FAEAE
	bne loc_037FAEBC	; 037FAEB0
	bl P2_LoadSecondaryFirmwarePartsToStaging	; 037FAEB2
	mov r0,#0x7	; 037FAEB6
	str r0,[r5,#0x0]	; 037FAEB8
	b loc_037FAE10	; 037FAEBA
loc_037FAEBC:
	ldr r0,[r4,#0x24]	; 037FAEBC
	cmp r0,#0x8	; 037FAEBE
	bne loc_037FAED8	; 037FAEC0
	mov r1,#0x6	; 037FAEC2
; 启动状态 8 路径在私有源区写入 6；发布时此字段会被另行覆盖。
; Boot state 8 writes 6 to this private slot; publication later replaces the field.
	ldr r0,[pool_037FAF98]	; 037FAEC4
	strh r1,[r0,#0x0]	; 037FAEC6
	ldr r0,[pool_037FAF80]	; 037FAEC8
	ldr r0,[r0,#0x0]	; 037FAECA
	bl loc_03805040	; 037FAECC
	bl loc_037FAFC0	; 037FAED0
	str r6,[r5,#0x0]	; 037FAED4
	b loc_037FAE10	; 037FAED6
loc_037FAED8:
	ldr r0,[r4,#0x24]	; 037FAED8
	cmp r0,#0x9	; 037FAEDA
	bne loc_037FAE10	; 037FAEDC
	ldr r0,[pool_037FAF8C]	; 037FAEDE
	ldr r0,[r0,#0x0]	; 037FAEE0
	cmp r0,#0x9	; 037FAEE2
	bne loc_037FAE10	; 037FAEE4
	ldr r0,[pool_037FAF6C]	; 037FAEE6
	ldrh r0,[r0,#0x0]	; 037FAEE8
	mov r1,#0x0	; 037FAEEA
	ldr r0,[pool_037FAF6C]	; 037FAEEC
	strh r1,[r0,#0x0]	; 037FAEEE
	ldr r0,[pool_037FAF9C]	; 037FAEF0
	ldr r1,[pool_037FAFA0]	; 037FAEF2
	ldr r2,[pool_037FAFA4]	; 037FAEF4
	bl P2_SwiCpuFastSet	; 037FAEF6
	mov r0,#0x10	; 037FAEFA
	bl P2_SwiSoundBiasDecrease	; 037FAEFC
	ldr r0,[pool_037FAF28]	; 037FAF00
	bl loc_03804890	; 037FAF02
	ldr r0,[pool_037FAFA0]	; 037FAF06
	bl loc_03805040	; 037FAF08
	b loc_037FAE10	; 037FAF0C
loc_037FAF0E:
	add sp,#0xc	; 037FAF0E
	pop {r4,r5,r6,r7}	; 037FAF10
	pop {r3}	; 037FAF12
	bx r3	; 037FAF14
	.byte 0xC0, 0x46	; 037FAF18
pool_037FAF18:
loc_037FAF18:
	.word 0x023FE800	; 037FAF18
pool_037FAF1C:
loc_037FAF1C:
	.word 0x01000200	; 037FAF1C
pool_037FAF20:
loc_037FAF20:
	.word 0x0000FFFF	; 037FAF20
pool_037FAF24:
loc_037FAF24:
	.word REG_NITRO2_REGCNT	; 037FAF24
pool_037FAF28:
loc_037FAF28:
	.word 0x00001000	; 037FAF28
pool_037FAF2C:
loc_037FAF2C:
	.word REG_SIOCNT_ARM7	; 037FAF2C
pool_037FAF30:
loc_037FAF30:
	.word REG_SIODATA32_ARM7	; 037FAF30
pool_037FAF34:
loc_037FAF34:
	.word REG_POWERCNT	; 037FAF34
pool_037FAF38:
loc_037FAF38:
	.word P2_PxiChannel1UserCallback + 1	; 037FAF38
pool_037FAF3C:
loc_037FAF3C:
	.word 0x03807A4C	; 037FAF3C
pool_037FAF40:
loc_037FAF40:
	.word 0x0380F600	; 037FAF40
pool_037FAF44:
loc_037FAF44:
	.word P2_BssStart + 0x14	; 037FAF44
pool_037FAF48:
loc_037FAF48:
	.word P2_PxiCallback_037FACD8 + 1	; 037FAF48
pool_037FAF4C:
loc_037FAF4C:
	.word 0x00000400	; 037FAF4C
pool_037FAF50:
loc_037FAF50:
	.word 0x038053A4	; 037FAF50
pool_037FAF54:
loc_037FAF54:
	.word P2_RunTransferRequestServiceLoop + 1	; 037FAF54
pool_037FAF58:
loc_037FAF58:
	.word 0x0380581C	; 037FAF58
pool_037FAF5C:
loc_037FAF5C:
	.word 0x00080000	; 037FAF5C
pool_037FAF60:
loc_037FAF60:
	.word P2_BssStart + 0x10	; 037FAF60
pool_037FAF64:
loc_037FAF64:
	.word P2_IrqHandler_037FACA4 + 1	; 037FAF64
pool_037FAF68:
loc_037FAF68:
	.word REG_DISPSTAT	; 037FAF68
pool_037FAF6C:
loc_037FAF6C:
	.word REG_IME	; 037FAF6C
pool_037FAF70:
loc_037FAF70:
	.word FirmwareBootSharedAddress + BootSharedArm7StateOffset	; 037FAF70
pool_037FAF74:
loc_037FAF74:
	.word 0x027FF890	; 037FAF74
pool_037FAF78:
loc_037FAF78:
	.word 0x027FF860	; 037FAF78
pool_037FAF7C:
loc_037FAF7C:
	.word 0x20000000	; 037FAF7C
pool_037FAF80:
loc_037FAF80:
	.word P2_BssStart + 0xC	; 037FAF80
pool_037FAF84:
loc_037FAF84:
	.word 0x00000200	; 037FAF84
pool_037FAF88:
loc_037FAF88:
	.word P2_BssStart	; 037FAF88
pool_037FAF8C:
loc_037FAF8C:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 037FAF8C
pool_037FAF90:
loc_037FAF90:
	.word 0x00002100	; 037FAF90
pool_037FAF94:
loc_037FAF94:
	.word REG_IPC_SYNC	; 037FAF94
pool_037FAF98:
loc_037FAF98:
	.word FirmwareBootInfoScratchAddress + 0x10	; 037FAF98
pool_037FAF9C:
loc_037FAF9C:
	.word P2_WaitVCount200ThenEnterAgbMode	; 037FAF9C
pool_037FAFA0:
loc_037FAFA0:
	.word 0x037F8000	; 037FAFA0
pool_037FAFA4:
loc_037FAFA4:
	.word 0x00000100	; 037FAFA4

; ===== function loc_037FAFA8 =====
loc_037FAFA8:
	bx pc	; 037FAFA8
	.byte 0xC0, 0x46	; 037FAFAC
.arm

; ===== function loc_037FAFAC =====
loc_037FAFAC:
	ldr pc,[pool_037FAFB0]	; 037FAFAC
pool_037FAFB0:
loc_037FAFB0:
	.word loc_037FDB64	; 037FAFB0
.thumb

; ===== function loc_037FAFB4 =====
loc_037FAFB4:
	bx pc	; 037FAFB4
	.byte 0xC0, 0x46	; 037FAFB8
.arm

; ===== function loc_037FAFB8 =====
loc_037FAFB8:
	ldr pc,[pool_037FAFBC]	; 037FAFB8
pool_037FAFBC:
loc_037FAFBC:
	.word loc_037FF0AC	; 037FAFBC
.thumb

; ===== function loc_037FAFC0 =====
loc_037FAFC0:
	bx pc	; 037FAFC0
	.byte 0xC0, 0x46	; 037FAFC4
.arm

; ===== function loc_037FAFC4 =====
loc_037FAFC4:
	ldr pc,[pool_037FAFC8]	; 037FAFC4
pool_037FAFC8:
loc_037FAFC8:
	.word P4_InitializeRuntimeContext	; 037FAFC8
.thumb

; ===== function loc_037FAFCC =====
loc_037FAFCC:
	push {lr}	; 037FAFCC
	sub sp,#0xc	; 037FAFCE
	bl loc_037FB230	; 037FAFD0
	cmp r0,#0x0	; 037FAFD4
	bne loc_037FAFDC	; 037FAFD6
	mov r0,#0x0	; 037FAFD8
	b loc_037FB014	; 037FAFDA
loc_037FAFDC:
	ldr r2,[pool_037FB01C]	; 037FAFDC
	ldrh r1,[r2,#0x0]	; 037FAFDE
	mov r0,#0x2	; 037FAFE0
	orr r1,r0	; 037FAFE2
	strh r1,[r2,#0x0]	; 037FAFE4
	mov r1,#0x30	; 037FAFE6
	ldr r0,[pool_037FB020]	; 037FAFE8
	strh r1,[r0,#0x0]	; 037FAFEA
	add r0,sp,#0x0	; 037FAFEC
	bl loc_037FB184	; 037FAFEE
	bl loc_037FB2E0	; 037FAFF2
	bl loc_037FB144	; 037FAFF6
	add r0,sp,#0x0	; 037FAFFA
	bl loc_037FB128	; 037FAFFC
	add r0,sp,#0x0	; 037FB000
	ldrh r0,[r0,#0x0]	; 037FB002
	bl loc_037FB298	; 037FB004
	ldr r2,[pool_037FB01C]	; 037FB008
	ldrh r1,[r2,#0x0]	; 037FB00A
	mov r0,#0x2	; 037FB00C
	bic r1,r0	; 037FB00E
	strh r1,[r2,#0x0]	; 037FB010
	mov r0,#0x1	; 037FB012
loc_037FB014:
	add sp,#0xc	; 037FB014
	pop {r3}	; 037FB016
	bx r3	; 037FB018
	.byte 0xC0, 0x46	; 037FB01C
pool_037FB01C:
loc_037FB01C:
	.word REG_POWERCNT	; 037FB01C
pool_037FB020:
loc_037FB020:
	.word REG_WIFIWAITCNT_ARM7	; 037FB020

; ===== function loc_037FB024 =====
loc_037FB024:
	push {r4,r5,lr}	; 037FB024
	sub sp,#0x4	; 037FB026
	mov r5,#0x2	; 037FB028
	str r5,[sp,#0x0]	; 037FB02A
	add r4,sp,#0x0	; 037FB02C
	b loc_037FB036	; 037FB02E
loc_037FB030:
	add r0,r4,#0x0	; 037FB030
	bl loc_0380400C	; 037FB032
loc_037FB036:
	ldr r0,[sp,#0x0]	; 037FB036
	and r0,r5	; 037FB038
	cmp r0,#0x0	; 037FB03A
	bne loc_037FB030	; 037FB03C
	add sp,#0x4	; 037FB03E
	pop {r4,r5}	; 037FB040
	pop {r3}	; 037FB042
	bx r3	; 037FB044
	.byte 0x00, 0x00	; 037FB048

; ===== function loc_037FB048 =====
loc_037FB048:
	push {r4,r5,r6,lr}	; 037FB048
	add r5,r0,#0x0	; 037FB04A
	add r4,r1,#0x0	; 037FB04C
	add r6,r2,#0x0	; 037FB04E
	bl loc_037FB024	; 037FB050
	add r0,r5,#0x0	; 037FB054
	add r1,r4,#0x0	; 037FB056
	add r2,r6,#0x0	; 037FB058
	bl loc_03803F10	; 037FB05A
	pop {r4,r5,r6}	; 037FB05E
	pop {r3}	; 037FB060
	bx r3	; 037FB062

; ===== function loc_037FB064 =====
loc_037FB064:
	ldr r0,[pool_037FB07C]	; 037FB064
	ldr r2,[pool_037FB080]	; 037FB066
	mov r1,#0x1	; 037FB068
	b loc_037FB076	; 037FB06A
loc_037FB06C:
	ldrh r3,[r2,#0x0]	; 037FB06C
	and r3,r1	; 037FB06E
	cmp r3,#0x0	; 037FB070
	beq loc_037FB07A	; 037FB072
	sub r0,r0,#0x1	; 037FB074
loc_037FB076:
	cmp r0,#0x0	; 037FB076
	bne loc_037FB06C	; 037FB078
loc_037FB07A:
	bx lr	; 037FB07A
pool_037FB07C:
loc_037FB07C:
	.word 0x00002000	; 037FB07C
pool_037FB080:
loc_037FB080:
	.word 0x04808180	; 037FB080

; ===== function loc_037FB084 =====
loc_037FB084:
	push {r4,lr}	; 037FB084
	add r4,r0,#0x0	; 037FB086
	bl loc_037FB064	; 037FB088
	ldr r0,[pool_037FB0A0]	; 037FB08C
	strh r4,[r0,#0x0]	; 037FB08E
	lsr r1,r4,#0x10	; 037FB090
	ldr r0,[pool_037FB0A4]	; 037FB092
	strh r1,[r0,#0x0]	; 037FB094
	bl loc_037FB064	; 037FB096
	pop {r4}	; 037FB09A
	pop {r3}	; 037FB09C
	bx r3	; 037FB09E
pool_037FB0A0:
loc_037FB0A0:
	.word REG_WIFI_RF_DATA1	; 037FB0A0
pool_037FB0A4:
loc_037FB0A4:
	.word REG_WIFI_RF_DATA2	; 037FB0A4

; ===== function loc_037FB0A8 =====
loc_037FB0A8:
	ldr r0,[pool_037FB0C0]	; 037FB0A8
	ldr r2,[pool_037FB0C4]	; 037FB0AA
	mov r1,#0x1	; 037FB0AC
	b loc_037FB0BA	; 037FB0AE
loc_037FB0B0:
	ldrh r3,[r2,#0x0]	; 037FB0B0
	and r3,r1	; 037FB0B2
	cmp r3,#0x0	; 037FB0B4
	beq loc_037FB0BE	; 037FB0B6
	sub r0,r0,#0x1	; 037FB0B8
loc_037FB0BA:
	cmp r0,#0x0	; 037FB0BA
	bne loc_037FB0B0	; 037FB0BC
loc_037FB0BE:
	bx lr	; 037FB0BE
pool_037FB0C0:
loc_037FB0C0:
	.word 0x00002000	; 037FB0C0
pool_037FB0C4:
loc_037FB0C4:
	.word 0x0480815E	; 037FB0C4

; ===== function loc_037FB0C8 =====
loc_037FB0C8:
	push {r4,r5,lr}	; 037FB0C8
	sub sp,#0x4	; 037FB0CA
	add r5,r0,#0x0	; 037FB0CC
	add r4,r1,#0x0	; 037FB0CE
	bl loc_037FB0A8	; 037FB0D0
	ldr r0,[pool_037FB0F0]	; 037FB0D4
	strh r4,[r0,#0x0]	; 037FB0D6
	ldr r0,[pool_037FB0F4]	; 037FB0D8
	orr r5,r0	; 037FB0DA
	ldr r0,[pool_037FB0F8]	; 037FB0DC
	strh r5,[r0,#0x0]	; 037FB0DE
	bl loc_037FB0A8	; 037FB0E0
	mov r0,#0x0	; 037FB0E4
	add sp,#0x4	; 037FB0E6
	pop {r4,r5}	; 037FB0E8
	pop {r3}	; 037FB0EA
	bx r3	; 037FB0EC
	.byte 0xC0, 0x46	; 037FB0F0
pool_037FB0F0:
loc_037FB0F0:
	.word REG_WIFI_BB_WRITE	; 037FB0F0
pool_037FB0F4:
loc_037FB0F4:
	.word 0x00005000	; 037FB0F4
pool_037FB0F8:
loc_037FB0F8:
	.word REG_WIFI_BB_CNT	; 037FB0F8

; ===== function loc_037FB0FC =====
loc_037FB0FC:
	push {r4,lr}	; 037FB0FC
	add r4,r0,#0x0	; 037FB0FE
	bl loc_037FB0A8	; 037FB100
	ldr r0,[pool_037FB11C]	; 037FB104
	orr r4,r0	; 037FB106
	ldr r0,[pool_037FB120]	; 037FB108
	strh r4,[r0,#0x0]	; 037FB10A
	bl loc_037FB0A8	; 037FB10C
	ldr r0,[pool_037FB124]	; 037FB110
	ldrh r0,[r0,#0x0]	; 037FB112
	pop {r4}	; 037FB114
	pop {r3}	; 037FB116
	bx r3	; 037FB118
	.byte 0xC0, 0x46	; 037FB11C
pool_037FB11C:
loc_037FB11C:
	.word 0x00006000	; 037FB11C
pool_037FB120:
loc_037FB120:
	.word REG_WIFI_BB_CNT	; 037FB120
pool_037FB124:
loc_037FB124:
	.word REG_WIFI_BB_READ	; 037FB124

; ===== function loc_037FB128 =====
loc_037FB128:
	ldrh r2,[r0,#0x2]	; 037FB128
	lsr r1,r2,#0x7	; 037FB12A
	lsl r3,r1,#0x8	; 037FB12C
	mov r1,#0x7f	; 037FB12E
	and r2,r1	; 037FB130
	strh r2,[r0,#0x2]	; 037FB132
	ldrh r0,[r0,#0x2]	; 037FB134
	orr r3,r0	; 037FB136
	ldr r0,[pool_037FB140]	; 037FB138
	strh r3,[r0,#0x0]	; 037FB13A
	bx lr	; 037FB13C
	.byte 0xC0, 0x46	; 037FB140
pool_037FB140:
loc_037FB140:
	.word REG_WIFI_RF_CNT	; 037FB140

; ===== function loc_037FB144 =====
loc_037FB144:
	push {r4,r5,r6,r7,lr}	; 037FB144
	sub sp,#0x4	; 037FB146
	ldr r1,[pool_037FB17C]	; 037FB148
	ldr r0,[pool_037FB180]	; 037FB14A
	strh r1,[r0,#0x0]	; 037FB14C
	mov r4,#0x64	; 037FB14E
	mov r5,#0x0	; 037FB150
	str r5,[sp,#0x0]	; 037FB152
	mov r6,#0x1	; 037FB154
	add r7,sp,#0x0	; 037FB156
loc_037FB158:
	add r0,r4,#0x0	; 037FB158
	add r1,r6,#0x0	; 037FB15A
	add r2,r7,#0x0	; 037FB15C
	bl loc_037FB048	; 037FB15E
	add r0,r5,#0x0	; 037FB162
	ldr r1,[sp,#0x0]	; 037FB164
	bl loc_037FB0C8	; 037FB166
	add r4,r4,#0x1	; 037FB16A
	add r5,r5,#0x1	; 037FB16C
	cmp r5,#0x69	; 037FB16E
	bcc loc_037FB158	; 037FB170
	add sp,#0x4	; 037FB172
	pop {r4,r5,r6,r7}	; 037FB174
	pop {r3}	; 037FB176
	bx r3	; 037FB178
	.byte 0xC0, 0x46	; 037FB17C
pool_037FB17C:
loc_037FB17C:
	.word 0x00000100	; 037FB17C
pool_037FB180:
loc_037FB180:
	.word REG_WIFI_BB_MODE	; 037FB180

; ===== function loc_037FB184 =====
loc_037FB184:
	push {r4,lr}	; 037FB184
	sub sp,#0x8	; 037FB186
	add r4,r0,#0x0	; 037FB188
	mov r1,#0x0	; 037FB18A
	add r0,sp,#0x0	; 037FB18C
	strh r1,[r0,#0x0]	; 037FB18E
	ldrh r0,[r0,#0x0]	; 037FB190
	add r1,r4,#0x0	; 037FB192
	mov r2,#0x8	; 037FB194
	bl loc_037FB1CC	; 037FB196
	mov r0,#0x40	; 037FB19A
	mov r1,#0x1	; 037FB19C
	add r2,r4,#0x0	; 037FB19E
	bl loc_037FB048	; 037FB1A0
	mov r0,#0x41	; 037FB1A4
	mov r1,#0x1	; 037FB1A6
	add r2,r4,#0x2	; 037FB1A8
	bl loc_037FB048	; 037FB1AA
	mov r0,#0x42	; 037FB1AE
	mov r1,#0x1	; 037FB1B0
	add r2,r4,#0x4	; 037FB1B2
	bl loc_037FB048	; 037FB1B4
	mov r0,#0x43	; 037FB1B8
	mov r1,#0x1	; 037FB1BA
	add r2,r4,#0x6	; 037FB1BC
	bl loc_037FB048	; 037FB1BE
	add sp,#0x8	; 037FB1C2
	pop {r4}	; 037FB1C4
	pop {r3}	; 037FB1C6
	bx r3	; 037FB1C8
	.byte 0xC0, 0x46	; 037FB1CC

; ===== function loc_037FB1CC =====
loc_037FB1CC:
	bx pc	; 037FB1CC
	.byte 0xC0, 0x46	; 037FB1D0
.arm

; ===== function loc_037FB1D0 =====
loc_037FB1D0:
	ldr pc,[pool_037FB1D4]	; 037FB1D0
pool_037FB1D4:
loc_037FB1D4:
	.word loc_037FF2D8	; 037FB1D4
.thumb

; ===== function loc_037FB1D8 =====
loc_037FB1D8:
	push {r4,r5,lr}	; 037FB1D8
	sub sp,#0x4	; 037FB1DA
	mov r2,#0xf	; 037FB1DC
	add r3,r1,#0x0	; 037FB1DE
	and r3,r2	; 037FB1E0
	lsl r3,r3,#0x1	; 037FB1E2
	ldr r4,[pool_037FB228]	; 037FB1E4
	ldrh r3,[r4,r3]	; 037FB1E6
	asr r1,r1,#0x4	; 037FB1E8
	ldr r5,[pool_037FB22C]	; 037FB1EA
	and r1,r5	; 037FB1EC
	lsl r1,r1,#0x10	; 037FB1EE
	lsr r1,r1,#0x10	; 037FB1F0
	eor r1,r3	; 037FB1F2
	add r3,r0,#0x0	; 037FB1F4
	and r3,r2	; 037FB1F6
	lsl r3,r3,#0x1	; 037FB1F8
	ldrh r3,[r4,r3]	; 037FB1FA
	eor r1,r3	; 037FB1FC
	lsl r1,r1,#0x10	; 037FB1FE
	lsr r3,r1,#0x10	; 037FB200
	asr r1,r3,#0x4	; 037FB202
	and r1,r5	; 037FB204
	lsl r1,r1,#0x10	; 037FB206
	lsr r1,r1,#0x10	; 037FB208
	and r3,r2	; 037FB20A
	lsl r3,r3,#0x1	; 037FB20C
	ldrh r3,[r4,r3]	; 037FB20E
	eor r1,r3	; 037FB210
	asr r0,r0,#0x4	; 037FB212
	and r0,r2	; 037FB214
	lsl r0,r0,#0x1	; 037FB216
	ldrh r0,[r4,r0]	; 037FB218
	eor r1,r0	; 037FB21A
	lsl r0,r1,#0x10	; 037FB21C
	lsr r0,r0,#0x10	; 037FB21E
	add sp,#0x4	; 037FB220
	pop {r4,r5}	; 037FB222
	pop {r3}	; 037FB224
	bx r3	; 037FB226
pool_037FB228:
loc_037FB228:
	.word P2_Data_03805098	; 037FB228
pool_037FB22C:
loc_037FB22C:
	.word 0x00000FFF	; 037FB22C

; ===== function loc_037FB230 =====
loc_037FB230:
	push {r4,r5,r6,r7,lr}	; 037FB230
	sub sp,#0xc	; 037FB232
	mov r5,#0x2a	; 037FB234
	add r0,r5,#0x0	; 037FB236
	mov r1,#0x2	; 037FB238
	add r2,sp,#0x0	; 037FB23A
	add r2,#0x2	; 037FB23C
	bl loc_037FB048	; 037FB23E
	add r5,r5,#0x2	; 037FB242
	add r0,r5,#0x0	; 037FB244
	mov r1,#0x2	; 037FB246
	add r2,sp,#0x4	; 037FB248
	bl loc_037FB048	; 037FB24A
	add r7,sp,#0x0	; 037FB24E
	ldrh r1,[r7,#0x4]	; 037FB250
	ldr r0,[pool_037FB294]	; 037FB252
	cmp r1,r0	; 037FB254
	bcs loc_037FB28A	; 037FB256
	mov r6,#0x0	; 037FB258
	add r4,r6,#0x0	; 037FB25A
	b loc_037FB276	; 037FB25C
loc_037FB25E:
	add r0,r5,#0x0	; 037FB25E
	mov r1,#0x1	; 037FB260
	add r2,sp,#0x0	; 037FB262
	bl loc_037FB048	; 037FB264
	add r5,r5,#0x1	; 037FB268
	ldrb r0,[r7,#0x0]	; 037FB26A
	add r1,r6,#0x0	; 037FB26C
	bl loc_037FB1D8	; 037FB26E
	add r6,r0,#0x0	; 037FB272
	add r4,r4,#0x1	; 037FB274
loc_037FB276:
	ldrh r0,[r7,#0x4]	; 037FB276
	cmp r4,r0	; 037FB278
	bcc loc_037FB25E	; 037FB27A
	ldrh r0,[r7,#0x2]	; 037FB27C
	cmp r6,r0	; 037FB27E
	bne loc_037FB286	; 037FB280
	mov r0,#0x1	; 037FB282
	b loc_037FB28C	; 037FB284
loc_037FB286:
	mov r0,#0x0	; 037FB286
	b loc_037FB28C	; 037FB288
loc_037FB28A:
	mov r0,#0x0	; 037FB28A
loc_037FB28C:
	add sp,#0xc	; 037FB28C
	pop {r4,r5,r6,r7}	; 037FB28E
	pop {r3}	; 037FB290
	bx r3	; 037FB292
pool_037FB294:
loc_037FB294:
	.word 0x000001D6	; 037FB294

; ===== function loc_037FB298 =====
loc_037FB298:
	push {lr}	; 037FB298
	sub sp,#0x4	; 037FB29A
	cmp r0,#0x2	; 037FB29C
	beq loc_037FB2A4	; 037FB29E
	cmp r0,#0x3	; 037FB2A0
	b loc_037FB2AA	; 037FB2A2
loc_037FB2A4:
	ldr r0,[pool_037FB2D0]	; 037FB2A4
	bl loc_037FB084	; 037FB2A6
loc_037FB2AA:
	mov r0,#0x1e	; 037FB2AA
	bl loc_037FB0FC	; 037FB2AC
	mov r2,#0x3f	; 037FB2B0
	add r1,r0,#0x0	; 037FB2B2
	orr r1,r2	; 037FB2B4
	mov r0,#0x1e	; 037FB2B6
	bl loc_037FB0C8	; 037FB2B8
	ldr r1,[pool_037FB2D4]	; 037FB2BC
	ldr r0,[pool_037FB2D8]	; 037FB2BE
	strh r1,[r0,#0x0]	; 037FB2C0
	mov r1,#0x1	; 037FB2C2
	ldr r0,[pool_037FB2DC]	; 037FB2C4
	strh r1,[r0,#0x0]	; 037FB2C6
	add sp,#0x4	; 037FB2C8
	pop {r3}	; 037FB2CA
	bx r3	; 037FB2CC
	.byte 0xC0, 0x46	; 037FB2D0
pool_037FB2D0:
loc_037FB2D0:
	.word 0x0000C008	; 037FB2D0
pool_037FB2D4:
loc_037FB2D4:
	.word 0x0000800D	; 037FB2D4
pool_037FB2D8:
loc_037FB2D8:
	.word REG_WIFI_BB_POWER	; 037FB2D8
pool_037FB2DC:
loc_037FB2DC:
	.word REG_WIFI_POWER_US	; 037FB2DC

; ===== function loc_037FB2E0 =====
loc_037FB2E0:
	push {lr}	; 037FB2E0
	sub sp,#0x4	; 037FB2E2
	mov r1,#0x0	; 037FB2E4
	ldr r0,[pool_037FB2FC]	; 037FB2E6
	strh r1,[r0,#0x0]	; 037FB2E8
	ldr r0,[pool_037FB300]	; 037FB2EA
	bl loc_037FF184	; 037FB2EC
	mov r1,#0x0	; 037FB2F0
	ldr r0,[pool_037FB304]	; 037FB2F2
	strh r1,[r0,#0x0]	; 037FB2F4
	add sp,#0x4	; 037FB2F6
	pop {r3}	; 037FB2F8
	bx r3	; 037FB2FA
pool_037FB2FC:
loc_037FB2FC:
	.word REG_WIFI_POWER_US	; 037FB2FC
pool_037FB300:
loc_037FB300:
	.word 0x00051D23	; 037FB300
pool_037FB304:
loc_037FB304:
	.word REG_WIFI_BB_POWER	; 037FB304

; ===== function loc_037FB308 =====
P2_ThreadEntry_037FB308:
	push {r4,r5,r6,r7,lr}	; 037FB308
	sub sp,#0x4	; 037FB30A
	ldr r6,[pool_037FB370]	; 037FB30C
	ldr r5,[r6,#0x0]	; 037FB30E
	mov r0,#0x0	; 037FB310
	strh r0,[r5,#0x10]	; 037FB312
	strh r0,[r5,#0x14]	; 037FB314
	ldr r4,[pool_037FB374]	; 037FB316
	ldr r7,[pool_037FB378]	; 037FB318
loc_037FB31A:
	ldr r0,[r6,#0x0]	; 037FB31A
	ldr r0,[r0,r7]	; 037FB31C
	add r1,sp,#0x0	; 037FB31E
	mov r2,#0x0	; 037FB320
	bl loc_037FE244	; 037FB322
	cmp r0,#0x0	; 037FB326
	beq loc_037FB330	; 037FB328
	add r0,sp,#0x0	; 037FB32A
	bl loc_037FB490	; 037FB32C
loc_037FB330:
	ldr r0,[pool_037FB37C]	; 037FB330
	bl loc_037FDA20	; 037FB332
	ldrh r1,[r5,#0x10]	; 037FB336
	strh r1,[r5,#0x12]	; 037FB338
	ldrh r1,[r5,#0x12]	; 037FB33A
	lsl r1,r1,#0x1	; 037FB33C
	ldrh r1,[r5,r1]	; 037FB33E
	cmp r1,r4	; 037FB340
	bne loc_037FB350	; 037FB342
	ldrh r1,[r5,#0x10]	; 037FB344
	add r1,r1,#0x1	; 037FB346
	strh r1,[r5,#0x10]	; 037FB348
	bl loc_037FDA4C	; 037FB34A
	b loc_037FB31A	; 037FB34E
loc_037FB350:
	bl loc_037FDA4C	; 037FB350
	ldrh r0,[r5,#0x12]	; 037FB354
	bl loc_037FB40C	; 037FB356
	strh r0,[r5,#0x14]	; 037FB35A
	ldrh r0,[r5,#0x14]	; 037FB35C
	lsl r0,r0,#0x3	; 037FB35E
	add r0,r5,r0	; 037FB360
	add r0,#0x94	; 037FB362
	ldr r0,[r0,#0x0]	; 037FB364
	bl loc_03805040	; 037FB366
	strh r4,[r5,#0x14]	; 037FB36A
	b loc_037FB31A	; 037FB36C
	.byte 0xC0, 0x46	; 037FB370
pool_037FB370:
loc_037FB370:
	.word FirmwareWlWorkPointerSlot	; 037FB370
pool_037FB374:
loc_037FB374:
	.word 0x0000FFFF	; 037FB374
pool_037FB378:
loc_037FB378:
	.word 0x000002DC	; 037FB378
pool_037FB37C:
loc_037FB37C:
	.word 0x01000010	; 037FB37C

; ===== function loc_037FB380 =====
loc_037FB380:
	push {r4,r5,r6,r7,lr}	; 037FB380
	sub sp,#0x4	; 037FB382
	add r5,r0,#0x0	; 037FB384
	add r6,r1,#0x0	; 037FB386
	ldr r0,[pool_037FB3FC]	; 037FB388
	ldr r4,[r0,#0x0]	; 037FB38A
	add r7,r4,#0x0	; 037FB38C
	add r7,#0x90	; 037FB38E
	ldr r0,[pool_037FB400]	; 037FB390
	bl loc_037FDA20	; 037FB392
	str r0,[sp,#0x0]	; 037FB396
	lsl r1,r6,#0x3	; 037FB398
	add r2,r7,#0x2	; 037FB39A
	add r0,r2,r1	; 037FB39C
	ldrh r2,[r2,r1]	; 037FB39E
	cmp r2,#0x0	; 037FB3A0
	bne loc_037FB3D2	; 037FB3A2
	mov r2,#0x1	; 037FB3A4
	strh r2,[r0,#0x0]	; 037FB3A6
	ldr r0,[pool_037FB404]	; 037FB3A8
	strh r0,[r7,r1]	; 037FB3AA
	lsl r0,r5,#0x1	; 037FB3AC
	add r2,r4,#0x0	; 037FB3AE
	add r2,#0x8	; 037FB3B0
	add r1,r2,r0	; 037FB3B2
	ldrh r3,[r2,r0]	; 037FB3B4
	ldr r2,[pool_037FB404]	; 037FB3B6
	cmp r3,r2	; 037FB3B8
	bne loc_037FB3C0	; 037FB3BA
	strh r6,[r4,r0]	; 037FB3BC
	b loc_037FB3C8	; 037FB3BE
loc_037FB3C0:
	lsl r0,r3,#0x3	; 037FB3C0
	add r0,r4,r0	; 037FB3C2
	add r0,#0x90	; 037FB3C4
	strh r6,[r0,#0x0]	; 037FB3C6
loc_037FB3C8:
	strh r6,[r1,#0x0]	; 037FB3C8
	ldrh r0,[r4,#0x10]	; 037FB3CA
	cmp r5,r0	; 037FB3CC
	bge loc_037FB3D2	; 037FB3CE
	strh r5,[r4,#0x10]	; 037FB3D0
loc_037FB3D2:
	ldr r0,[sp,#0x0]	; 037FB3D2
	bl loc_037FDA4C	; 037FB3D4
	cmp r5,#0x3	; 037FB3D8
	beq loc_037FB3F2	; 037FB3DA
	ldrh r0,[r4,#0x12]	; 037FB3DC
	cmp r0,#0x3	; 037FB3DE
	bne loc_037FB3F2	; 037FB3E0
	ldr r0,[pool_037FB3FC]	; 037FB3E2
	ldr r1,[r0,#0x0]	; 037FB3E4
	ldr r0,[pool_037FB408]	; 037FB3E6
	ldr r0,[r1,r0]	; 037FB3E8
	mov r1,#0x0	; 037FB3EA
	add r2,r1,#0x0	; 037FB3EC
	bl loc_037FE2BC	; 037FB3EE
loc_037FB3F2:
	add sp,#0x4	; 037FB3F2
	pop {r4,r5,r6,r7}	; 037FB3F4
	pop {r3}	; 037FB3F6
	bx r3	; 037FB3F8
	.byte 0xC0, 0x46	; 037FB3FC
pool_037FB3FC:
loc_037FB3FC:
	.word FirmwareWlWorkPointerSlot	; 037FB3FC
pool_037FB400:
loc_037FB400:
	.word 0x01000010	; 037FB400
pool_037FB404:
loc_037FB404:
	.word 0x0000FFFF	; 037FB404
pool_037FB408:
loc_037FB408:
	.word 0x000002DC	; 037FB408

; ===== function loc_037FB40C =====
loc_037FB40C:
	push {r4,r5,r6,r7,lr}	; 037FB40C
	sub sp,#0x4	; 037FB40E
	add r4,r0,#0x0	; 037FB410
	ldr r0,[pool_037FB454]	; 037FB412
	ldr r5,[r0,#0x0]	; 037FB414
	ldr r0,[pool_037FB458]	; 037FB416
	bl loc_037FDA20	; 037FB418
	add r7,r0,#0x0	; 037FB41C
	lsl r0,r4,#0x1	; 037FB41E
	add r6,r5,r0	; 037FB420
	ldrh r4,[r5,r0]	; 037FB422
	ldr r0,[pool_037FB45C]	; 037FB424
	cmp r4,r0	; 037FB426
	beq loc_037FB444	; 037FB428
	add r5,#0x90	; 037FB42A
	lsl r3,r4,#0x3	; 037FB42C
	mov r2,#0x0	; 037FB42E
	add r1,r5,r3	; 037FB430
	strh r2,[r1,#0x2]	; 037FB432
	ldrh r1,[r5,r3]	; 037FB434
	cmp r1,r0	; 037FB436
	bne loc_037FB440	; 037FB438
	strh r0,[r6,#0x0]	; 037FB43A
	strh r0,[r6,#0x8]	; 037FB43C
	b loc_037FB444	; 037FB43E
loc_037FB440:
	strh r1,[r6,#0x0]	; 037FB440
	strh r0,[r5,r3]	; 037FB442
loc_037FB444:
	add r0,r7,#0x0	; 037FB444
	bl loc_037FDA4C	; 037FB446
	add r0,r4,#0x0	; 037FB44A
	add sp,#0x4	; 037FB44C
	pop {r4,r5,r6,r7}	; 037FB44E
	pop {r3}	; 037FB450
	bx r3	; 037FB452
pool_037FB454:
loc_037FB454:
	.word FirmwareWlWorkPointerSlot	; 037FB454
pool_037FB458:
loc_037FB458:
	.word 0x01000010	; 037FB458
pool_037FB45C:
loc_037FB45C:
	.word 0x0000FFFF	; 037FB45C
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x58, 0x00, 0xA9, 0x01, 0x22	; 037FB470
	.byte 0x02, 0xF0, 0xE8, 0xFE, 0x00, 0xA8, 0x00, 0xF0, 0x0B, 0xF8, 0x03, 0x20, 0x0C, 0x21, 0xFF, 0xF7	; 037FB480
	.byte 0x7F, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xDC, 0x02, 0x00, 0x00	; 037FB490

; ===== function loc_037FB490 =====
loc_037FB490:
	push {lr}	; 037FB490
	sub sp,#0x4	; 037FB492
	ldr r1,[r0,#0x0]	; 037FB494
	cmp r1,#0x0	; 037FB496
	beq loc_037FB4AE	; 037FB498
	ldr r0,[pool_037FB4B4]	; 037FB49A
	ldr r2,[r0,#0x0]	; 037FB49C
	ldr r0,[pool_037FB4B8]	; 037FB49E
	add r0,r2,r0	; 037FB4A0
	bl loc_037FB4BC	; 037FB4A2
	mov r0,#0x2	; 037FB4A6
	mov r1,#0xb	; 037FB4A8
	bl loc_037FB380	; 037FB4AA
loc_037FB4AE:
	add sp,#0x4	; 037FB4AE
	pop {r3}	; 037FB4B0
	bx r3	; 037FB4B2
pool_037FB4B4:
loc_037FB4B4:
	.word FirmwareWlWorkPointerSlot	; 037FB4B4
pool_037FB4B8:
loc_037FB4B8:
	.word 0x000001D4	; 037FB4B8

; ===== function loc_037FB4BC =====
loc_037FB4BC:
	push {r4,r5,lr}	; 037FB4BC
	sub sp,#0x4	; 037FB4BE
	add r5,r0,#0x0	; 037FB4C0
	add r4,r1,#0x0	; 037FB4C2
	ldr r0,[pool_037FB504]	; 037FB4C4
	bl loc_037FDA20	; 037FB4C6
	ldrh r1,[r5,#0x8]	; 037FB4CA
	cmp r1,#0x0	; 037FB4CC
	bne loc_037FB4DA	; 037FB4CE
	mov r1,#0x0	; 037FB4D0
	mvn r1,r1	; 037FB4D2
	str r1,[r4,#0x0]	; 037FB4D4
	str r4,[r5,#0x0]	; 037FB4D6
	b loc_037FB4E0	; 037FB4D8
loc_037FB4DA:
	ldr r1,[r5,#0x4]	; 037FB4DA
	str r1,[r4,#0x0]	; 037FB4DC
	str r4,[r1,#0x4]	; 037FB4DE
loc_037FB4E0:
	mov r1,#0x0	; 037FB4E0
	mvn r1,r1	; 037FB4E2
	str r1,[r4,#0x4]	; 037FB4E4
	ldrh r1,[r5,#0xa]	; 037FB4E6
	strh r1,[r4,#0x8]	; 037FB4E8
	ldr r1,[pool_037FB508]	; 037FB4EA
	strh r1,[r4,#0xa]	; 037FB4EC
	str r4,[r5,#0x4]	; 037FB4EE
	ldrh r1,[r5,#0x8]	; 037FB4F0
	add r1,r1,#0x1	; 037FB4F2
	strh r1,[r5,#0x8]	; 037FB4F4
	bl loc_037FDA4C	; 037FB4F6
	mov r0,#0x0	; 037FB4FA
	add sp,#0x4	; 037FB4FC
	pop {r4,r5}	; 037FB4FE
	pop {r3}	; 037FB500
	bx r3	; 037FB502
pool_037FB504:
loc_037FB504:
	.word 0x01000000	; 037FB504
pool_037FB508:
loc_037FB508:
	.word 0x0000BF1D	; 037FB508

; ===== function loc_037FB50C =====
loc_037FB50C:
	push {r4,r5,lr}	; 037FB50C
	sub sp,#0x4	; 037FB50E
	add r5,r0,#0x0	; 037FB510
	add r4,r1,#0x0	; 037FB512
	ldrh r1,[r4,#0xa]	; 037FB514
	ldr r0,[pool_037FB590]	; 037FB516
	cmp r1,r0	; 037FB518
	beq loc_037FB520	; 037FB51A
	mov r0,#0x1	; 037FB51C
	b loc_037FB586	; 037FB51E
loc_037FB520:
	ldrh r1,[r4,#0x8]	; 037FB520
	ldrh r0,[r5,#0xa]	; 037FB522
	cmp r1,r0	; 037FB524
	beq loc_037FB52C	; 037FB526
	mov r0,#0x2	; 037FB528
	b loc_037FB586	; 037FB52A
loc_037FB52C:
	ldr r0,[pool_037FB594]	; 037FB52C
	bl loc_037FDA20	; 037FB52E
	ldrh r1,[r5,#0x8]	; 037FB532
	sub r1,r1,#0x1	; 037FB534
	strh r1,[r5,#0x8]	; 037FB536
	ldrh r1,[r5,#0x8]	; 037FB538
	cmp r1,#0x0	; 037FB53A
	bne loc_037FB548	; 037FB53C
	mov r1,#0x0	; 037FB53E
	mvn r1,r1	; 037FB540
	str r1,[r5,#0x0]	; 037FB542
	str r1,[r5,#0x4]	; 037FB544
	b loc_037FB57C	; 037FB546
loc_037FB548:
	ldr r1,[r5,#0x0]	; 037FB548
	cmp r4,r1	; 037FB54A
	bne loc_037FB55C	; 037FB54C
	ldr r1,[r4,#0x4]	; 037FB54E
	str r1,[r5,#0x0]	; 037FB550
	mov r1,#0x0	; 037FB552
	mvn r2,r1	; 037FB554
	ldr r1,[r5,#0x0]	; 037FB556
	str r2,[r1,#0x0]	; 037FB558
	b loc_037FB57C	; 037FB55A
loc_037FB55C:
	ldr r1,[r5,#0x4]	; 037FB55C
	cmp r4,r1	; 037FB55E
	bne loc_037FB570	; 037FB560
	ldr r1,[r4,#0x0]	; 037FB562
	str r1,[r5,#0x4]	; 037FB564
	mov r1,#0x0	; 037FB566
	mvn r2,r1	; 037FB568
	ldr r1,[r5,#0x4]	; 037FB56A
	str r2,[r1,#0x4]	; 037FB56C
	b loc_037FB57C	; 037FB56E
loc_037FB570:
	ldr r2,[r4,#0x0]	; 037FB570
	ldr r1,[r4,#0x4]	; 037FB572
	str r2,[r1,#0x0]	; 037FB574
	ldr r2,[r4,#0x4]	; 037FB576
	ldr r1,[r4,#0x0]	; 037FB578
	str r2,[r1,#0x4]	; 037FB57A
loc_037FB57C:
	mov r1,#0x0	; 037FB57C
	strh r1,[r4,#0x8]	; 037FB57E
	bl loc_037FDA4C	; 037FB580
	mov r0,#0x0	; 037FB584
loc_037FB586:
	add sp,#0x4	; 037FB586
	pop {r4,r5}	; 037FB588
	pop {r3}	; 037FB58A
	bx r3	; 037FB58C
	.byte 0xC0, 0x46	; 037FB590
pool_037FB590:
loc_037FB590:
	.word 0x0000BF1D	; 037FB590
pool_037FB594:
loc_037FB594:
	.word 0x01000000	; 037FB594

; ===== function loc_037FB598 =====
P2_Entry_037FB598:
	push {r4,r5,lr}	; 037FB598
	sub sp,#0x4	; 037FB59A
	add r5,r0,#0x0	; 037FB59C
	ldr r0,[pool_037FB5F8]	; 037FB59E
	ldr r2,[r0,#0x0]	; 037FB5A0
	ldr r0,[pool_037FB5FC]	; 037FB5A2
	add r3,r2,r0	; 037FB5A4
	cmp r1,#0x0	; 037FB5A6
	bne loc_037FB5AE	; 037FB5A8
	mov r0,#0x0	; 037FB5AA
	b loc_037FB5EE	; 037FB5AC
loc_037FB5AE:
	add r2,r1,#0x0	; 037FB5AE
	add r2,#0xc	; 037FB5B0
	ldr r0,[r3,#0x0]	; 037FB5B2
	cmp r0,#0x0	; 037FB5B4
	beq loc_037FB5BE	; 037FB5B6
	cmp r0,#0x1	; 037FB5B8
	beq loc_037FB5CA	; 037FB5BA
	b loc_037FB5D4	; 037FB5BC
loc_037FB5BE:
	ldr r0,[r3,#0x4]	; 037FB5BE
	ldr r1,[r3,#0x8]	; 037FB5C0
	bl loc_037FE6D8	; 037FB5C2
	add r4,r0,#0x0	; 037FB5C6
	b loc_037FB5D4	; 037FB5C8
loc_037FB5CA:
	add r0,r2,#0x0	; 037FB5CA
	ldr r1,[r3,#0x4]	; 037FB5CC
	bl loc_03805044	; 037FB5CE
	add r4,r0,#0x0	; 037FB5D2
loc_037FB5D4:
	cmp r4,#0x0	; 037FB5D4
	beq loc_037FB5EC	; 037FB5D6
	ldr r0,[pool_037FB600]	; 037FB5D8
	strh r0,[r4,#0xa]	; 037FB5DA
	mov r0,#0x0	; 037FB5DC
	strh r0,[r4,#0x8]	; 037FB5DE
	add r0,r5,#0x0	; 037FB5E0
	add r1,r4,#0x0	; 037FB5E2
	bl loc_037FB6AC	; 037FB5E4
	add r0,r4,#0x0	; 037FB5E8
	b loc_037FB5EE	; 037FB5EA
loc_037FB5EC:
	mov r0,#0x0	; 037FB5EC
loc_037FB5EE:
	add sp,#0x4	; 037FB5EE
	pop {r4,r5}	; 037FB5F0
	pop {r3}	; 037FB5F2
	bx r3	; 037FB5F4
	.byte 0xC0, 0x46	; 037FB5F8
pool_037FB5F8:
loc_037FB5F8:
	.word FirmwareWlWorkPointerSlot	; 037FB5F8
pool_037FB5FC:
loc_037FB5FC:
	.word 0x00000150	; 037FB5FC
pool_037FB600:
loc_037FB600:
	.word 0x0000BF1D	; 037FB600
P2_Entry_037FB604:
	push {r4,r5,r6,lr}	; 037FB604
	add r5,r1,#0x0	; 037FB606
	ldr r2,[pool_037FB650]	; 037FB608
	ldr r3,[r2,#0x0]	; 037FB60A
	ldr r2,[pool_037FB654]	; 037FB60C
	add r4,r3,r2	; 037FB60E
	ldrh r3,[r5,#0xa]	; 037FB610
	ldr r2,[pool_037FB658]	; 037FB612
	cmp r3,r2	; 037FB614
	beq P2_Entry_037FB61C	; 037FB616
	mov r0,#0x1	; 037FB618
	b P2_Entry_037FB648	; 037FB61A
P2_Entry_037FB61C:
	bl loc_037FB50C	; 037FB61C
	add r6,r0,#0x0	; 037FB620
	cmp r6,#0x0	; 037FB622
	bne P2_Entry_037FB646	; 037FB624
	ldr r0,[r4,#0x0]	; 037FB626
	cmp r0,#0x0	; 037FB628
	beq P2_Entry_037FB632	; 037FB62A
	cmp r0,#0x1	; 037FB62C
	beq P2_Entry_037FB63E	; 037FB62E
	b P2_Entry_037FB646	; 037FB630
P2_Entry_037FB632:
	ldr r0,[r4,#0x4]	; 037FB632
	ldr r1,[r4,#0x8]	; 037FB634
	add r2,r5,#0x0	; 037FB636
	bl P2_Entry_037FE68C	; 037FB638
	b P2_Entry_037FB646	; 037FB63C
P2_Entry_037FB63E:
	add r0,r5,#0x0	; 037FB63E
	ldr r1,[r4,#0x8]	; 037FB640
	bl loc_03805044	; 037FB642
P2_Entry_037FB646:
	add r0,r6,#0x0	; 037FB646
P2_Entry_037FB648:
	pop {r4,r5,r6}	; 037FB648
	pop {r3}	; 037FB64A
	bx r3	; 037FB64C
	.byte 0xC0, 0x46	; 037FB64E
pool_037FB650:
	.word FirmwareWlWorkPointerSlot	; 037FB650
pool_037FB654:
	.word 0x00000150	; 037FB654
pool_037FB658:
	.word 0x0000BF1D	; 037FB658

; ===== function loc_037FB65C =====
loc_037FB65C:
	push {r4,r5,r6,r7,lr}	; 037FB65C
	sub sp,#0x4	; 037FB65E
	add r4,r0,#0x0	; 037FB660
	add r6,r1,#0x0	; 037FB662
	add r5,r2,#0x0	; 037FB664
	ldrh r1,[r5,#0xa]	; 037FB666
	ldr r0,[pool_037FB6A4]	; 037FB668
	cmp r1,r0	; 037FB66A
	beq loc_037FB672	; 037FB66C
	mov r0,#0x1	; 037FB66E
	b loc_037FB69A	; 037FB670
loc_037FB672:
	ldr r0,[pool_037FB6A8]	; 037FB672
	bl loc_037FDA20	; 037FB674
	add r7,r0,#0x0	; 037FB678
	add r0,r4,#0x0	; 037FB67A
	add r1,r5,#0x0	; 037FB67C
	bl loc_037FB50C	; 037FB67E
	add r4,r0,#0x0	; 037FB682
	cmp r4,#0x0	; 037FB684
	bne loc_037FB692	; 037FB686
	add r0,r6,#0x0	; 037FB688
	add r1,r5,#0x0	; 037FB68A
	bl loc_037FB6AC	; 037FB68C
	add r4,r0,#0x0	; 037FB690
loc_037FB692:
	add r0,r7,#0x0	; 037FB692
	bl loc_037FDA4C	; 037FB694
	add r0,r4,#0x0	; 037FB698
loc_037FB69A:
	add sp,#0x4	; 037FB69A
	pop {r4,r5,r6,r7}	; 037FB69C
	pop {r3}	; 037FB69E
	bx r3	; 037FB6A0
	.byte 0xC0, 0x46	; 037FB6A4
pool_037FB6A4:
loc_037FB6A4:
	.word 0x0000BF1D	; 037FB6A4
pool_037FB6A8:
loc_037FB6A8:
	.word 0x01000000	; 037FB6A8

; ===== function loc_037FB6AC =====
loc_037FB6AC:
	push {r4,r5,lr}	; 037FB6AC
	sub sp,#0x4	; 037FB6AE
	add r5,r0,#0x0	; 037FB6B0
	add r4,r1,#0x0	; 037FB6B2
	ldrh r1,[r4,#0xa]	; 037FB6B4
	ldr r0,[pool_037FB708]	; 037FB6B6
	cmp r1,r0	; 037FB6B8
	beq loc_037FB6C0	; 037FB6BA
	mov r0,#0x1	; 037FB6BC
	b loc_037FB6FE	; 037FB6BE
loc_037FB6C0:
	ldrh r0,[r4,#0x8]	; 037FB6C0
	cmp r0,#0x0	; 037FB6C2
	beq loc_037FB6CA	; 037FB6C4
	mov r0,#0x2	; 037FB6C6
	b loc_037FB6FE	; 037FB6C8
loc_037FB6CA:
	ldr r0,[pool_037FB70C]	; 037FB6CA
	bl loc_037FDA20	; 037FB6CC
	ldrh r1,[r5,#0x8]	; 037FB6D0
	cmp r1,#0x0	; 037FB6D2
	bne loc_037FB6E0	; 037FB6D4
	mov r1,#0x0	; 037FB6D6
	mvn r1,r1	; 037FB6D8
	str r1,[r4,#0x0]	; 037FB6DA
	str r4,[r5,#0x0]	; 037FB6DC
	b loc_037FB6E6	; 037FB6DE
loc_037FB6E0:
	ldr r1,[r5,#0x4]	; 037FB6E0
	str r1,[r4,#0x0]	; 037FB6E2
	str r4,[r1,#0x4]	; 037FB6E4
loc_037FB6E6:
	mov r1,#0x0	; 037FB6E6
	mvn r1,r1	; 037FB6E8
	str r1,[r4,#0x4]	; 037FB6EA
	ldrh r1,[r5,#0xa]	; 037FB6EC
	strh r1,[r4,#0x8]	; 037FB6EE
	str r4,[r5,#0x4]	; 037FB6F0
	ldrh r1,[r5,#0x8]	; 037FB6F2
	add r1,r1,#0x1	; 037FB6F4
	strh r1,[r5,#0x8]	; 037FB6F6
	bl loc_037FDA4C	; 037FB6F8
	mov r0,#0x0	; 037FB6FC
loc_037FB6FE:
	add sp,#0x4	; 037FB6FE
	pop {r4,r5}	; 037FB700
	pop {r3}	; 037FB702
	bx r3	; 037FB704
	.byte 0xC0, 0x46	; 037FB708
pool_037FB708:
loc_037FB708:
	.word 0x0000BF1D	; 037FB708
pool_037FB70C:
loc_037FB70C:
	.word 0x01000000	; 037FB70C
P2_Entry_037FB710:
	ldr r0,[r0,#0x4]	; 037FB710
	bx lr	; 037FB712

; ===== function loc_037FB714 =====
	push {r4,r5,r6,r7,lr}	; 037FB714
	sub sp,#0xc	; 037FB716
	ldr r2,[pool_037FB8DC]	; 037FB718
	ldr r0,[r2,#0x0]	; 037FB71A
	ldr r1,[pool_037FB8E0]	; 037FB71C
	add r5,r0,r1	; 037FB71E
	mov r1,#0x0	; 037FB720
	add r7,r1,#0x0	; 037FB722
	ldrh r3,[r5,#0x4]	; 037FB724
	cmp r3,#0x0	; 037FB726
	beq loc_037FB72C	; 037FB728
	b loc_037FB8D4	; 037FB72A
loc_037FB72C:
	ldr r3,[pool_037FB8E4]	; 037FB72C
	ldr r0,[r0,r3]	; 037FB72E
	str r0,[r5,#0x0]	; 037FB730
	ldr r0,[r5,#0x0]	; 037FB732
	str r0,[sp,#0x0]	; 037FB734
	mvn r3,r1	; 037FB736
	cmp r0,r3	; 037FB738
	bne loc_037FB73E	; 037FB73A
	b loc_037FB8D4	; 037FB73C
loc_037FB73E:
	ldrh r0,[r0,#0xe]	; 037FB73E
	lsl r3,r0,#0x1	; 037FB740
	ldr r0,[sp,#0x0]	; 037FB742
	add r4,r0,r3	; 037FB744
	add r4,#0x10	; 037FB746
	ldr r0,[r2,#0x0]	; 037FB748
	ldr r2,[pool_037FB8E8]	; 037FB74A
	ldrh r2,[r0,r2]	; 037FB74C
	cmp r2,#0x0	; 037FB74E
	beq loc_037FB75C	; 037FB750
	mov r0,#0x1	; 037FB752
	strh r0,[r4,#0x2]	; 037FB754
	mov r0,#0x6	; 037FB756
	strh r0,[r4,#0x4]	; 037FB758
	b loc_037FB8AC	; 037FB75A
loc_037FB75C:
	ldr r2,[sp,#0x0]	; 037FB75C
	ldrh r6,[r2,#0xc]	; 037FB75E
	ldrh r2,[r4,#0x0]	; 037FB760
	cmp r6,r2	; 037FB762
	beq loc_037FB76C	; 037FB764
	mov r0,#0xd	; 037FB766
	strh r0,[r4,#0x4]	; 037FB768
	b loc_037FB8AC	; 037FB76A
loc_037FB76C:
	ldr r2,[pool_037FB8EC]	; 037FB76C
	add r3,r6,#0x0	; 037FB76E
	and r3,r2	; 037FB770
	ldr r2,[pool_037FB8F0]	; 037FB772
	cmp r3,r2	; 037FB774
	bgt loc_037FB782	; 037FB776
	cmp r3,r2	; 037FB778
	bge loc_037FB7BE	; 037FB77A
	cmp r3,#0x0	; 037FB77C
	beq loc_037FB796	; 037FB77E
	b loc_037FB84E	; 037FB780
loc_037FB782:
	ldr r2,[pool_037FB8F4]	; 037FB782
	cmp r3,r2	; 037FB784
	bgt loc_037FB78E	; 037FB786
	cmp r3,r2	; 037FB788
	beq loc_037FB7DA	; 037FB78A
	b loc_037FB84E	; 037FB78C
loc_037FB78E:
	ldr r0,[pool_037FB8F8]	; 037FB78E
	cmp r3,r0	; 037FB790
	beq loc_037FB83C	; 037FB792
	b loc_037FB84E	; 037FB794
loc_037FB796:
	mov r7,#0x1	; 037FB796
	ldr r2,[pool_037FB8FC]	; 037FB798
	str r2,[sp,#0x4]	; 037FB79A
	mov r2,#0xff	; 037FB79C
	and r6,r2	; 037FB79E
	lsl r2,r6,#0x10	; 037FB7A0
	lsr r2,r2,#0x10	; 037FB7A2
	mov r3,#0xb	; 037FB7A4
	ldrh r6,[r5,#0x4]	; 037FB7A6
	and r6,r7	; 037FB7A8
	cmp r6,#0x0	; 037FB7AA
	beq loc_037FB7B2	; 037FB7AC
	mov r1,#0x2	; 037FB7AE
	b loc_037FB852	; 037FB7B0
loc_037FB7B2:
	ldr r6,[pool_037FB900]	; 037FB7B2
	ldrh r0,[r0,r6]	; 037FB7B4
	cmp r0,#0x20	; 037FB7B6
	bcs loc_037FB852	; 037FB7B8
	add r1,r7,#0x0	; 037FB7BA
	b loc_037FB852	; 037FB7BC
loc_037FB7BE:
	mov r7,#0x2	; 037FB7BE
	ldr r2,[pool_037FB904]	; 037FB7C0
	str r2,[sp,#0x4]	; 037FB7C2
	mov r2,#0xff	; 037FB7C4
	and r6,r2	; 037FB7C6
	lsl r2,r6,#0x10	; 037FB7C8
	lsr r2,r2,#0x10	; 037FB7CA
	mov r3,#0x5	; 037FB7CC
	ldr r6,[pool_037FB900]	; 037FB7CE
	ldrh r0,[r0,r6]	; 037FB7D0
	cmp r0,#0x40	; 037FB7D2
	beq loc_037FB852	; 037FB7D4
	mov r1,#0x1	; 037FB7D6
	b loc_037FB852	; 037FB7D8
loc_037FB7DA:
	mov r2,#0xff	; 037FB7DA
	and r6,r2	; 037FB7DC
	lsl r2,r6,#0x10	; 037FB7DE
	lsr r2,r2,#0x10	; 037FB7E0
	cmp r2,#0x40	; 037FB7E2
	bcs loc_037FB7FA	; 037FB7E4
	ldr r3,[pool_037FB900]	; 037FB7E6
	ldrh r0,[r0,r3]	; 037FB7E8
	cmp r0,#0x10	; 037FB7EA
	bcs loc_037FB7F0	; 037FB7EC
	mov r1,#0x1	; 037FB7EE
loc_037FB7F0:
	mov r7,#0x4	; 037FB7F0
	ldr r0,[pool_037FB908]	; 037FB7F2
	str r0,[sp,#0x4]	; 037FB7F4
	mov r3,#0x16	; 037FB7F6
	b loc_037FB852	; 037FB7F8
loc_037FB7FA:
	cmp r2,#0x80	; 037FB7FA
	bcs loc_037FB818	; 037FB7FC
	ldr r3,[pool_037FB900]	; 037FB7FE
	ldrh r0,[r0,r3]	; 037FB800
	cmp r0,#0x40	; 037FB802
	beq loc_037FB808	; 037FB804
	mov r1,#0x1	; 037FB806
loc_037FB808:
	mov r7,#0x8	; 037FB808
	ldr r0,[pool_037FB90C]	; 037FB80A
	str r0,[sp,#0x4]	; 037FB80C
	sub r2,#0x40	; 037FB80E
	lsl r0,r2,#0x10	; 037FB810
	lsr r2,r0,#0x10	; 037FB812
	mov r3,#0x6	; 037FB814
	b loc_037FB852	; 037FB816
loc_037FB818:
	cmp r2,#0xc0	; 037FB818
	bcs loc_037FB836	; 037FB81A
	ldr r3,[pool_037FB900]	; 037FB81C
	ldrh r0,[r0,r3]	; 037FB81E
	cmp r0,#0x10	; 037FB820
	bcs loc_037FB826	; 037FB822
	mov r1,#0x1	; 037FB824
loc_037FB826:
	mov r7,#0x10	; 037FB826
	ldr r0,[pool_037FB910]	; 037FB828
	str r0,[sp,#0x4]	; 037FB82A
	sub r2,#0x80	; 037FB82C
	lsl r0,r2,#0x10	; 037FB82E
	lsr r2,r0,#0x10	; 037FB830
	mov r3,#0x16	; 037FB832
	b loc_037FB852	; 037FB834
loc_037FB836:
	mov r2,#0x1	; 037FB836
	add r3,r1,#0x0	; 037FB838
	b loc_037FB852	; 037FB83A
loc_037FB83C:
	mov r7,#0x40	; 037FB83C
	ldr r0,[pool_037FB914]	; 037FB83E
	str r0,[sp,#0x4]	; 037FB840
	mov r0,#0xff	; 037FB842
	and r6,r0	; 037FB844
	lsl r0,r6,#0x10	; 037FB846
	lsr r2,r0,#0x10	; 037FB848
	mov r3,#0xa	; 037FB84A
	b loc_037FB852	; 037FB84C
loc_037FB84E:
	mov r2,#0x1	; 037FB84E
	mov r3,#0x0	; 037FB850
loc_037FB852:
	cmp r2,r3	; 037FB852
	bls loc_037FB85A	; 037FB854
	mov r1,#0x3	; 037FB856
	b loc_037FB876	; 037FB858
loc_037FB85A:
	lsl r3,r2,#0x3	; 037FB85A
	ldr r0,[sp,#0x0]	; 037FB85C
	ldrh r6,[r0,#0xe]	; 037FB85E
	ldr r0,[sp,#0x4]	; 037FB860
	ldrh r0,[r0,r3]	; 037FB862
	cmp r6,r0	; 037FB864
	bcc loc_037FB874	; 037FB866
	ldrh r6,[r4,#0x2]	; 037FB868
	ldr r0,[sp,#0x4]	; 037FB86A
	add r0,r0,r3	; 037FB86C
	ldrh r0,[r0,#0x2]	; 037FB86E
	cmp r6,r0	; 037FB870
	bcs loc_037FB876	; 037FB872
loc_037FB874:
	mov r1,#0x4	; 037FB874
loc_037FB876:
	cmp r1,#0x0	; 037FB876
	beq loc_037FB882	; 037FB878
	mov r0,#0x1	; 037FB87A
	strh r0,[r4,#0x2]	; 037FB87C
	strh r1,[r4,#0x4]	; 037FB87E
	b loc_037FB8AC	; 037FB880
loc_037FB882:
	ldrh r0,[r5,#0x4]	; 037FB882
	orr r0,r7	; 037FB884
	strh r0,[r5,#0x4]	; 037FB886
	ldr r0,[sp,#0x0]	; 037FB888
	add r1,r4,#0x0	; 037FB88A
	lsl r3,r2,#0x3	; 037FB88C
	ldr r2,[sp,#0x4]	; 037FB88E
	add r2,r2,r3	; 037FB890
	ldr r2,[r2,#0x4]	; 037FB892
	bl loc_03805048	; 037FB894
	strh r0,[r4,#0x4]	; 037FB898
	ldrh r0,[r4,#0x4]	; 037FB89A
	cmp r0,#0x80	; 037FB89C
	beq loc_037FB8D4	; 037FB89E
	cmp r0,#0x81	; 037FB8A0
	bne loc_037FB8AC	; 037FB8A2
	ldrh r0,[r5,#0x4]	; 037FB8A4
	bic r0,r7	; 037FB8A6
	strh r0,[r5,#0x4]	; 037FB8A8
	b loc_037FB8C0	; 037FB8AA
loc_037FB8AC:
	ldrh r0,[r5,#0x4]	; 037FB8AC
	bic r0,r7	; 037FB8AE
	strh r0,[r5,#0x4]	; 037FB8B0
	ldr r0,[pool_037FB8DC]	; 037FB8B2
	ldr r1,[r0,#0x0]	; 037FB8B4
	ldr r0,[pool_037FB8E4]	; 037FB8B6
	add r0,r1,r0	; 037FB8B8
	ldr r1,[r5,#0x0]	; 037FB8BA
	bl loc_037FB91C	; 037FB8BC
loc_037FB8C0:
	ldr r0,[pool_037FB8DC]	; 037FB8C0
	ldr r1,[r0,#0x0]	; 037FB8C2
	ldr r0,[pool_037FB918]	; 037FB8C4
	ldrh r0,[r1,r0]	; 037FB8C6
	cmp r0,#0x0	; 037FB8C8
	beq loc_037FB8D4	; 037FB8CA
	mov r0,#0x2	; 037FB8CC
	mov r1,#0xb	; 037FB8CE
	bl loc_037FB380	; 037FB8D0
loc_037FB8D4:
	add sp,#0xc	; 037FB8D4
	pop {r4,r5,r6,r7}	; 037FB8D6
	pop {r3}	; 037FB8D8
	bx r3	; 037FB8DA
pool_037FB8DC:
loc_037FB8DC:
	.word FirmwareWlWorkPointerSlot	; 037FB8DC
pool_037FB8E0:
loc_037FB8E0:
	.word 0x000003F8	; 037FB8E0
pool_037FB8E4:
loc_037FB8E4:
	.word 0x000001D4	; 037FB8E4
pool_037FB8E8:
loc_037FB8E8:
	.word 0x00000312	; 037FB8E8
pool_037FB8EC:
loc_037FB8EC:
	.word 0x0000FF00	; 037FB8EC
pool_037FB8F0:
loc_037FB8F0:
	.word 0x00000100	; 037FB8F0
pool_037FB8F4:
loc_037FB8F4:
	.word 0x00000200	; 037FB8F4
pool_037FB8F8:
loc_037FB8F8:
	.word 0x00000300	; 037FB8F8
pool_037FB8FC:
loc_037FB8FC:
	.word 0x0230D974	; 037FB8FC
pool_037FB900:
loc_037FB900:
	.word 0x00000320	; 037FB900
pool_037FB904:
loc_037FB904:
	.word 0x0230D8CC	; 037FB904
pool_037FB908:
loc_037FB908:
	.word 0x0230DA7C	; 037FB908
pool_037FB90C:
loc_037FB90C:
	.word 0x0230D8F4	; 037FB90C
pool_037FB910:
loc_037FB910:
	.word 0x0230D9CC	; 037FB910
pool_037FB914:
loc_037FB914:
	.word 0x0230D924	; 037FB914
pool_037FB918:
loc_037FB918:
	.word 0x000001DC	; 037FB918

; ===== function loc_037FB91C =====
loc_037FB91C:
	push {r4,r5,lr}	; 037FB91C
	sub sp,#0x4	; 037FB91E
	add r5,r0,#0x0	; 037FB920
	add r4,r1,#0x0	; 037FB922
	ldr r2,[pool_037FB974]	; 037FB924
	ldr r2,[r2,#0x0]	; 037FB926
	ldr r3,[pool_037FB978]	; 037FB928
	ldrh r3,[r2,r3]	; 037FB92A
	cmp r3,#0x0	; 037FB92C
	beq loc_037FB944	; 037FB92E
	ldr r1,[pool_037FB97C]	; 037FB930
	add r1,r2,r1	; 037FB932
	add r2,r4,#0x0	; 037FB934
	bl loc_037FB65C	; 037FB936
	mov r0,#0x2	; 037FB93A
	mov r1,#0x13	; 037FB93C
	bl loc_037FB380	; 037FB93E
	b loc_037FB96C	; 037FB942
loc_037FB944:
	ldr r0,[pool_037FB980]	; 037FB944
	ldr r0,[r2,r0]	; 037FB946
	mov r2,#0x0	; 037FB948
	bl loc_037FE2BC	; 037FB94A
	cmp r0,#0x0	; 037FB94E
	beq loc_037FB95C	; 037FB950
	add r0,r5,#0x0	; 037FB952
	add r1,r4,#0x0	; 037FB954
	bl loc_037FB50C	; 037FB956
	b loc_037FB96C	; 037FB95A
loc_037FB95C:
	add r0,r5,#0x0	; 037FB95C
	ldr r1,[pool_037FB974]	; 037FB95E
	ldr r2,[r1,#0x0]	; 037FB960
	ldr r1,[pool_037FB97C]	; 037FB962
	add r1,r2,r1	; 037FB964
	add r2,r4,#0x0	; 037FB966
	bl loc_037FB65C	; 037FB968
loc_037FB96C:
	add sp,#0x4	; 037FB96C
	pop {r4,r5}	; 037FB96E
	pop {r3}	; 037FB970
	bx r3	; 037FB972
pool_037FB974:
loc_037FB974:
	.word FirmwareWlWorkPointerSlot	; 037FB974
pool_037FB978:
loc_037FB978:
	.word 0x000001D0	; 037FB978
pool_037FB97C:
loc_037FB97C:
	.word 0x000001C8	; 037FB97C
pool_037FB980:
loc_037FB980:
	.word 0x000002D8	; 037FB980

; ===== function loc_037FB984 =====
P2_Entry_037FB984:
	push {r4,r5,r6,r7,lr}	; 037FB984
	sub sp,#0xc	; 037FB986
	ldr r0,[pool_037FBC24]	; 037FB988
	ldr r1,[r0,#0x0]	; 037FB98A
	ldr r0,[pool_037FBC28]	; 037FB98C
	add r4,r1,r0	; 037FB98E
	ldr r0,[pool_037FBC2C]	; 037FB990
	add r5,r1,r0	; 037FB992
	bl loc_037FBD5C	; 037FB994
	ldr r1,[pool_037FBC30]	; 037FB998
	ldrh r2,[r1,#0x0]	; 037FB99A
	ldrh r0,[r1,#0x0]	; 037FB99C
	lsl r0,r0,#0x8	; 037FB99E
	add r0,r2,r0	; 037FB9A0
	ldrh r1,[r1,#0x0]	; 037FB9A2
	bl loc_037FBCD4	; 037FB9A4
	mov r1,#0x1	; 037FB9A8
	add r0,r4,#0x0	; 037FB9AA
	add r0,#0x7c	; 037FB9AC
	strh r1,[r0,#0x0]	; 037FB9AE
	ldrh r0,[r5,#0x1e]	; 037FB9B0
	lsl r0,r0,#0x1d	; 037FB9B2
	lsr r0,r0,#0x1f	; 037FB9B4
	cmp r0,#0x1	; 037FB9B6
	bne loc_037FB9CA	; 037FB9B8
	add r0,r4,#0x0	; 037FB9BA
	add r0,#0x7c	; 037FB9BC
	ldrh r1,[r0,#0x0]	; 037FB9BE
	mov r0,#0x20	; 037FB9C0
	orr r1,r0	; 037FB9C2
	add r0,r4,#0x0	; 037FB9C4
	add r0,#0x7c	; 037FB9C6
	strh r1,[r0,#0x0]	; 037FB9C8
loc_037FB9CA:
	ldrh r0,[r5,#0x18]	; 037FB9CA
	cmp r0,#0x0	; 037FB9CC
	beq loc_037FB9E0	; 037FB9CE
	add r0,r4,#0x0	; 037FB9D0
	add r0,#0x7c	; 037FB9D2
	ldrh r1,[r0,#0x0]	; 037FB9D4
	mov r0,#0x10	; 037FB9D6
	orr r1,r0	; 037FB9D8
	add r0,r4,#0x0	; 037FB9DA
	add r0,#0x7c	; 037FB9DC
	strh r1,[r0,#0x0]	; 037FB9DE
loc_037FB9E0:
	mov r0,#0x0	; 037FB9E0
	strh r0,[r4,#0x12]	; 037FB9E2
	ldr r2,[pool_037FBC34]	; 037FB9E4
	ldr r1,[pool_037FBC38]	; 037FB9E6
	strh r2,[r1,#0x0]	; 037FB9E8
	ldr r2,[pool_037FBC3C]	; 037FB9EA
	ldr r1,[pool_037FBC40]	; 037FB9EC
	strh r2,[r1,#0x0]	; 037FB9EE
	ldr r1,[pool_037FBC44]	; 037FB9F0
	strh r0,[r1,#0x0]	; 037FB9F2
	ldr r1,[pool_037FBC48]	; 037FB9F4
	strh r0,[r1,#0x0]	; 037FB9F6
	mov r1,#0xf	; 037FB9F8
	ldr r0,[pool_037FBC4C]	; 037FB9FA
	strh r1,[r0,#0x0]	; 037FB9FC
	bl loc_037FBCE4	; 037FB9FE
	bl loc_037FBCF4	; 037FBA02
	bl loc_037FD404	; 037FBA06
	bl loc_037FD6AC	; 037FBA0A
	ldr r1,[pool_037FBC34]	; 037FBA0E
	ldr r0,[pool_037FBC50]	; 037FBA10
	strh r1,[r0,#0x0]	; 037FBA12
	ldr r1,[pool_037FBC3C]	; 037FBA14
	ldr r0,[pool_037FBC54]	; 037FBA16
	strh r1,[r0,#0x0]	; 037FBA18
	ldr r1,[pool_037FBC58]	; 037FBA1A
	ldr r0,[pool_037FBC5C]	; 037FBA1C
	strh r1,[r0,#0x0]	; 037FBA1E
	ldr r0,[pool_037FBC24]	; 037FBA20
	ldr r1,[r0,#0x0]	; 037FBA22
	ldr r0,[pool_037FBC60]	; 037FBA24
	ldrh r1,[r1,r0]	; 037FBA26
	mov r0,#0x8	; 037FBA28
	and r1,r0	; 037FBA2A
	cmp r1,#0x0	; 037FBA2C
	beq loc_037FBA38	; 037FBA2E
	ldr r1,[pool_037FBC64]	; 037FBA30
	ldr r0,[pool_037FBC68]	; 037FBA32
	strh r1,[r0,#0x0]	; 037FBA34
	b loc_037FBA3E	; 037FBA36
loc_037FBA38:
	mov r1,#0x0	; 037FBA38
	ldr r0,[pool_037FBC68]	; 037FBA3A
	strh r1,[r0,#0x0]	; 037FBA3C
loc_037FBA3E:
	mov r6,#0x0	; 037FBA3E
	ldr r1,[pool_037FBC6C]	; 037FBA40
	strh r6,[r1,#0x0]	; 037FBA42
	ldr r0,[pool_037FBC70]	; 037FBA44
	strh r6,[r0,#0x0]	; 037FBA46
	ldrh r2,[r4,#0xc]	; 037FBA48
	cmp r2,#0x4	; 037FBA4A
	bls loc_037FBA50	; 037FBA4C
	b loc_037FBBFC	; 037FBA4E
loc_037FBA50:
	add r2,r2,r2	; 037FBA50
P2_SwitchIndexPC_037FBA50:
	add r2,pc	; 037FBA52
	ldrh r2,[r2,#(P2_SwitchTable_037FBA50 - (P2_SwitchIndexPC_037FBA50 + 4))]	; 037FBA54
	lsl r2,r2,#0x10	; 037FBA56
	asr r2,r2,#0x10	; 037FBA58
P2_SwitchTargetPC_037FBA50:
	add r2,pc	; 037FBA5A
	bx r2	; 037FBA5C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FBA50:
	.halfword (loc_037FBA68 + 1) - (P2_SwitchTargetPC_037FBA50 + 4)
	.halfword (loc_037FBA90 + 1) - (P2_SwitchTargetPC_037FBA50 + 4)
	.halfword (loc_037FBB30 + 1) - (P2_SwitchTargetPC_037FBA50 + 4)
	.halfword (loc_037FBBA0 + 1) - (P2_SwitchTargetPC_037FBA50 + 4)
	.halfword (loc_037FBBE8 + 1) - (P2_SwitchTargetPC_037FBA50 + 4)
P2_SwitchTable_037FBA50End:
loc_037FBA68:
	mov r3,#0x3f	; 037FBA68
	ldr r2,[pool_037FBC74]	; 037FBA6A
	strh r3,[r2,#0x0]	; 037FBA6C
	ldr r3,[pool_037FBC3C]	; 037FBA6E
	ldr r2,[pool_037FBC78]	; 037FBA70
	strh r3,[r2,#0x0]	; 037FBA72
	mov r3,#0x8	; 037FBA74
	ldr r2,[pool_037FBC7C]	; 037FBA76
	strh r3,[r2,#0x0]	; 037FBA78
	strh r6,[r1,#0x0]	; 037FBA7A
	strh r6,[r0,#0x0]	; 037FBA7C
	ldr r0,[pool_037FBC80]	; 037FBA7E
	strh r6,[r0,#0x0]	; 037FBA80
	mov r1,#0x1	; 037FBA82
	ldr r0,[pool_037FBC84]	; 037FBA84
	strh r1,[r0,#0x0]	; 037FBA86
	mov r0,#0x40	; 037FBA88
	bl loc_037FBE34	; 037FBA8A
	b loc_037FBBFC	; 037FBA8E
loc_037FBA90:
	ldr r2,[pool_037FBC88]	; 037FBA90
	ldr r0,[pool_037FBC74]	; 037FBA92
	strh r2,[r0,#0x0]	; 037FBA94
	ldr r2,[pool_037FBC58]	; 037FBA96
	ldr r0,[pool_037FBC5C]	; 037FBA98
	strh r2,[r0,#0x0]	; 037FBA9A
	ldr r2,[pool_037FBC8C]	; 037FBA9C
	ldr r0,[pool_037FBC78]	; 037FBA9E
	strh r2,[r0,#0x0]	; 037FBAA0
	mov r2,#0xd	; 037FBAA2
	ldr r0,[pool_037FBC7C]	; 037FBAA4
	strh r2,[r0,#0x0]	; 037FBAA6
	ldr r0,[pool_037FBC90]	; 037FBAA8
	strh r0,[r1,#0x0]	; 037FBAAA
	mov r1,#0x1	; 037FBAAC
	ldr r0,[pool_037FBC84]	; 037FBAAE
	strh r1,[r0,#0x0]	; 037FBAB0
	add r5,sp,#0x0	; 037FBAB2
	ldr r0,[pool_037FBC94]	; 037FBAB4
	ldrh r0,[r0,#0x0]	; 037FBAB6
	strh r0,[r5,#0x0]	; 037FBAB8
	ldr r0,[pool_037FBC98]	; 037FBABA
	ldrh r0,[r0,#0x0]	; 037FBABC
	strh r0,[r5,#0x2]	; 037FBABE
	ldr r0,[pool_037FBC9C]	; 037FBAC0
	ldrh r0,[r0,#0x0]	; 037FBAC2
	strh r0,[r5,#0x4]	; 037FBAC4
	ldr r0,[pool_037FBCA0]	; 037FBAC6
	ldrh r0,[r0,#0x0]	; 037FBAC8
	strh r0,[r5,#0x6]	; 037FBACA
	add r0,r4,#0x0	; 037FBACC
	add r0,#0x6e	; 037FBACE
	ldrh r0,[r0,#0x0]	; 037FBAD0
	lsl r7,r0,#0xa	; 037FBAD2
	ldr r0,[sp,#0x0]	; 037FBAD4
	ldr r1,[sp,#0x4]	; 037FBAD6
	add r2,r7,#0x0	; 037FBAD8
	add r3,r6,#0x0	; 037FBADA
	bl loc_037FBD04	; 037FBADC
	str r0,[sp,#0x0]	; 037FBAE0
	str r1,[sp,#0x4]	; 037FBAE2
	lsl r3,r6,#0	; 037FBAE4
	mov r2,#0x1	; 037FBAE6
	add r0,r0,r2	; 037FBAE8
	adc r1,r3	; 037FBAEA
	str r0,[sp,#0x0]	; 037FBAEC
	str r1,[sp,#0x4]	; 037FBAEE
	add r2,r7,#0x0	; 037FBAF0
	bl loc_037FBD10	; 037FBAF2
	str r0,[sp,#0x0]	; 037FBAF6
	str r1,[sp,#0x4]	; 037FBAF8
	ldrh r1,[r5,#0x6]	; 037FBAFA
	ldr r0,[pool_037FBCA4]	; 037FBAFC
	strh r1,[r0,#0x0]	; 037FBAFE
	ldrh r1,[r5,#0x4]	; 037FBB00
	ldr r0,[pool_037FBCA8]	; 037FBB02
	strh r1,[r0,#0x0]	; 037FBB04
	ldrh r1,[r5,#0x2]	; 037FBB06
	ldr r0,[pool_037FBCAC]	; 037FBB08
	strh r1,[r0,#0x0]	; 037FBB0A
	ldrh r2,[r5,#0x0]	; 037FBB0C
	mov r1,#0x1	; 037FBB0E
	orr r2,r1	; 037FBB10
	ldr r0,[pool_037FBCB0]	; 037FBB12
	strh r2,[r0,#0x0]	; 037FBB14
	ldr r0,[pool_037FBC80]	; 037FBB16
	strh r1,[r0,#0x0]	; 037FBB18
	ldr r0,[pool_037FBCB4]	; 037FBB1A
	strh r1,[r0,#0x0]	; 037FBB1C
	mov r0,#0x40	; 037FBB1E
	bl loc_037FBE34	; 037FBB20
	bl loc_037FBD1C	; 037FBB24
	mov r1,#0x2	; 037FBB28
	ldr r0,[pool_037FBCB8]	; 037FBB2A
	strh r1,[r0,#0x0]	; 037FBB2C
	b loc_037FBBFC	; 037FBB2E
loc_037FBB30:
	ldr r1,[pool_037FBCBC]	; 037FBB30
	ldr r0,[pool_037FBC74]	; 037FBB32
	strh r1,[r0,#0x0]	; 037FBB34
	ldr r1,[pool_037FBC24]	; 037FBB36
	ldr r2,[r1,#0x0]	; 037FBB38
	ldr r1,[pool_037FBC60]	; 037FBB3A
	ldrh r2,[r2,r1]	; 037FBB3C
	mov r1,#0x20	; 037FBB3E
	and r2,r1	; 037FBB40
	cmp r2,#0x0	; 037FBB42
	beq loc_037FBB4E	; 037FBB44
	ldrh r2,[r0,#0x0]	; 037FBB46
	mov r1,#0xc0	; 037FBB48
	orr r2,r1	; 037FBB4A
	strh r2,[r0,#0x0]	; 037FBB4C
loc_037FBB4E:
	ldr r0,[pool_037FBC24]	; 037FBB4E
	ldr r1,[r0,#0x0]	; 037FBB50
	ldr r0,[pool_037FBC60]	; 037FBB52
	ldrh r1,[r1,r0]	; 037FBB54
	mov r0,#0x20	; 037FBB56
	and r1,r0	; 037FBB58
	cmp r1,#0x0	; 037FBB5A
	beq loc_037FBB68	; 037FBB5C
	ldr r2,[pool_037FBC68]	; 037FBB5E
	ldrh r1,[r2,#0x0]	; 037FBB60
	mov r0,#0x68	; 037FBB62
	orr r1,r0	; 037FBB64
	strh r1,[r2,#0x0]	; 037FBB66
loc_037FBB68:
	add r0,r4,#0x0	; 037FBB68
	add r0,#0x64	; 037FBB6A
	ldrh r1,[r0,#0x0]	; 037FBB6C
	mov r0,#0x1	; 037FBB6E
	and r1,r0	; 037FBB70
	cmp r1,#0x0	; 037FBB72
	beq loc_037FBB7E	; 037FBB74
	ldr r1,[pool_037FBCC0]	; 037FBB76
	ldr r0,[pool_037FBC78]	; 037FBB78
	strh r1,[r0,#0x0]	; 037FBB7A
	b loc_037FBB84	; 037FBB7C
loc_037FBB7E:
	ldr r1,[pool_037FBCC4]	; 037FBB7E
	ldr r0,[pool_037FBC78]	; 037FBB80
	strh r1,[r0,#0x0]	; 037FBB82
loc_037FBB84:
	mov r1,#0xb	; 037FBB84
	ldr r0,[pool_037FBC7C]	; 037FBB86
	strh r1,[r0,#0x0]	; 037FBB88
	mov r1,#0x1	; 037FBB8A
	ldr r0,[pool_037FBC84]	; 037FBB8C
	strh r1,[r0,#0x0]	; 037FBB8E
	ldr r0,[pool_037FBC80]	; 037FBB90
	strh r1,[r0,#0x0]	; 037FBB92
	ldr r0,[pool_037FBCB4]	; 037FBB94
	strh r1,[r0,#0x0]	; 037FBB96
	mov r0,#0x20	; 037FBB98
	bl loc_037FBE34	; 037FBB9A
	b loc_037FBBFC	; 037FBB9E
loc_037FBBA0:
	ldr r1,[pool_037FBC3C]	; 037FBBA0
	ldr r0,[pool_037FBC54]	; 037FBBA2
	strh r1,[r0,#0x0]	; 037FBBA4
	ldr r1,[pool_037FBCC8]	; 037FBBA6
	ldr r0,[pool_037FBC74]	; 037FBBA8
	strh r1,[r0,#0x0]	; 037FBBAA
	add r0,r4,#0x0	; 037FBBAC
	add r0,#0x64	; 037FBBAE
	ldrh r0,[r0,#0x0]	; 037FBBB0
	mov r1,#0x1	; 037FBBB2
	and r0,r1	; 037FBBB4
	cmp r0,#0x0	; 037FBBB6
	beq loc_037FBBC2	; 037FBBB8
	ldr r1,[pool_037FBCCC]	; 037FBBBA
	ldr r0,[pool_037FBC78]	; 037FBBBC
	strh r1,[r0,#0x0]	; 037FBBBE
	b loc_037FBBC6	; 037FBBC0
loc_037FBBC2:
	ldr r0,[pool_037FBC78]	; 037FBBC2
	strh r1,[r0,#0x0]	; 037FBBC4
loc_037FBBC6:
	mov r1,#0xb	; 037FBBC6
	ldr r0,[pool_037FBC7C]	; 037FBBC8
	strh r1,[r0,#0x0]	; 037FBBCA
	mov r1,#0x1	; 037FBBCC
	ldr r0,[pool_037FBC84]	; 037FBBCE
	strh r1,[r0,#0x0]	; 037FBBD0
	ldr r0,[pool_037FBC80]	; 037FBBD2
	strh r1,[r0,#0x0]	; 037FBBD4
	ldr r0,[pool_037FBCB4]	; 037FBBD6
	strh r1,[r0,#0x0]	; 037FBBD8
	mov r1,#0x0	; 037FBBDA
	ldr r0,[pool_037FBCD0]	; 037FBBDC
	strh r1,[r0,#0x0]	; 037FBBDE
	mov r0,#0x20	; 037FBBE0
	bl loc_037FBE34	; 037FBBE2
	b loc_037FBBFC	; 037FBBE6
loc_037FBBE8:
	ldr r0,[pool_037FBC74]	; 037FBBE8
	strh r6,[r0,#0x0]	; 037FBBEA
	ldr r0,[pool_037FBC5C]	; 037FBBEC
	strh r6,[r0,#0x0]	; 037FBBEE
	mov r1,#0x1	; 037FBBF0
	ldr r0,[pool_037FBC84]	; 037FBBF2
	strh r1,[r0,#0x0]	; 037FBBF4
	mov r0,#0x20	; 037FBBF6
	bl loc_037FBE34	; 037FBBF8
loc_037FBBFC:
	mov r1,#0x0	; 037FBBFC
	ldr r0,[pool_037FBCD0]	; 037FBBFE
	strh r1,[r0,#0x0]	; 037FBC00
	bl loc_037FBD2C	; 037FBC02
	mov r0,#0x2	; 037FBC06
	ldr r1,[pool_037FBCB8]	; 037FBC08
	strh r0,[r1,#0x0]	; 037FBC0A
	ldrh r1,[r4,#0xe]	; 037FBC0C
	cmp r1,#0x1	; 037FBC0E
	bne loc_037FBC16	; 037FBC10
	bl loc_037FBD3C	; 037FBC12
loc_037FBC16:
	bl loc_037FBD4C	; 037FBC16
	add sp,#0xc	; 037FBC1A
	pop {r4,r5,r6,r7}	; 037FBC1C
	pop {r3}	; 037FBC1E
	bx r3	; 037FBC20
	.byte 0xC0, 0x46	; 037FBC24
pool_037FBC24:
loc_037FBC24:
	.word FirmwareWlWorkPointerSlot	; 037FBC24
pool_037FBC28:
loc_037FBC28:
	.word 0x00000318	; 037FBC28
pool_037FBC2C:
loc_037FBC2C:
	.word 0x000002F0	; 037FBC2C
pool_037FBC30:
loc_037FBC30:
	.word REG_WIFI_RANDOM	; 037FBC30
pool_037FBC34:
loc_037FBC34:
	.word 0x00008000	; 037FBC34
pool_037FBC38:
loc_037FBC38:
	.word REG_WIFI_WEP_CNT	; 037FBC38
pool_037FBC3C:
loc_037FBC3C:
	.word 0x0000FFFF	; 037FBC3C
pool_037FBC40:
loc_037FBC40:
	.word REG_WIFI_POST_BEACON	; 037FBC40
pool_037FBC44:
loc_037FBC44:
	.word REG_WIFI_AID_FULL	; 037FBC44
pool_037FBC48:
loc_037FBC48:
	.word REG_WIFI_AID_LOW	; 037FBC48
pool_037FBC4C:
loc_037FBC4C:
	.word REG_WIFI_POWER_TX	; 037FBC4C
pool_037FBC50:
loc_037FBC50:
	.word REG_WIFI_RXCNT	; 037FBC50
pool_037FBC54:
loc_037FBC54:
	.word REG_WIFI_IF	; 037FBC54
pool_037FBC58:
loc_037FBC58:
	.word 0x00001FFF	; 037FBC58
pool_037FBC5C:
loc_037FBC5C:
	.word REG_WIFI_RXSTAT_OVF_IE	; 037FBC5C
pool_037FBC60:
loc_037FBC60:
	.word 0x00000638	; 037FBC60
pool_037FBC64:
loc_037FBC64:
	.word 0x00000400	; 037FBC64
pool_037FBC68:
loc_037FBC68:
	.word REG_WIFI_RXSTAT_INC_IE	; 037FBC68
pool_037FBC6C:
loc_037FBC6C:
	.word REG_WIFI_TXSTATCNT	; 037FBC6C
pool_037FBC70:
loc_037FBC70:
	.word REG_WIFI_UNKNOWN_00A	; 037FBC70
pool_037FBC74:
loc_037FBC74:
	.word REG_WIFI_IE	; 037FBC74
pool_037FBC78:
loc_037FBC78:
	.word REG_WIFI_RXFILTER	; 037FBC78
pool_037FBC7C:
loc_037FBC7C:
	.word REG_WIFI_RXFILTER2	; 037FBC7C
pool_037FBC80:
loc_037FBC80:
	.word REG_WIFI_US_COUNTCNT	; 037FBC80
pool_037FBC84:
loc_037FBC84:
	.word REG_WIFI_MODE_RST	; 037FBC84
pool_037FBC88:
loc_037FBC88:
	.word 0x0000703F	; 037FBC88
pool_037FBC8C:
loc_037FBC8C:
	.word 0x00000301	; 037FBC8C
pool_037FBC90:
loc_037FBC90:
	.word 0x0000E000	; 037FBC90
pool_037FBC94:
loc_037FBC94:
	.word REG_WIFI_US_COUNT0	; 037FBC94
pool_037FBC98:
loc_037FBC98:
	.word REG_WIFI_US_COUNT1	; 037FBC98
pool_037FBC9C:
loc_037FBC9C:
	.word REG_WIFI_US_COUNT2	; 037FBC9C
pool_037FBCA0:
loc_037FBCA0:
	.word REG_WIFI_US_COUNT3	; 037FBCA0
pool_037FBCA4:
loc_037FBCA4:
	.word REG_WIFI_US_COMPARE3	; 037FBCA4
pool_037FBCA8:
loc_037FBCA8:
	.word REG_WIFI_US_COMPARE2	; 037FBCA8
pool_037FBCAC:
loc_037FBCAC:
	.word REG_WIFI_US_COMPARE1	; 037FBCAC
pool_037FBCB0:
loc_037FBCB0:
	.word REG_WIFI_US_COMPARE0	; 037FBCB0
pool_037FBCB4:
loc_037FBCB4:
	.word REG_WIFI_US_COMPARECNT	; 037FBCB4
pool_037FBCB8:
loc_037FBCB8:
	.word REG_WIFI_TXREQ_SET	; 037FBCB8
pool_037FBCBC:
loc_037FBCBC:
	.word 0x0000E03F	; 037FBCBC
pool_037FBCC0:
loc_037FBCC0:
	.word 0x00000581	; 037FBCC0
pool_037FBCC4:
loc_037FBCC4:
	.word 0x00000181	; 037FBCC4
pool_037FBCC8:
loc_037FBCC8:
	.word 0x0000C03F	; 037FBCC8
pool_037FBCCC:
loc_037FBCCC:
	.word 0x00000401	; 037FBCCC
pool_037FBCD0:
loc_037FBCD0:
	.word REG_WIFI_UNKNOWN_048	; 037FBCD0

; ===== function loc_037FBCD4 =====
loc_037FBCD4:
	bx pc	; 037FBCD4
	.byte 0xC0, 0x46	; 037FBCD8
.arm

; ===== function loc_037FBCD8 =====
loc_037FBCD8:
	ldr r12,[pool_037FBCE0]	; 037FBCD8
	bx r12	; 037FBCDC
pool_037FBCE0:
loc_037FBCE0:
	.word loc_0230515C + 1	; 037FBCE0
.thumb

; ===== function loc_037FBCE4 =====
loc_037FBCE4:
	bx pc	; 037FBCE4
	.byte 0xC0, 0x46	; 037FBCE8
.arm

; ===== function loc_037FBCE8 =====
loc_037FBCE8:
	ldr r12,[pool_037FBCF0]	; 037FBCE8
	bx r12	; 037FBCEC
pool_037FBCF0:
loc_037FBCF0:
	.word P4_Entry_02306EE0 + 1	; 037FBCF0
.thumb

; ===== function loc_037FBCF4 =====
loc_037FBCF4:
	bx pc	; 037FBCF4
	.byte 0xC0, 0x46	; 037FBCF8
.arm

; ===== function loc_037FBCF8 =====
loc_037FBCF8:
	ldr r12,[pool_037FBD00]	; 037FBCF8
	bx r12	; 037FBCFC
pool_037FBD00:
loc_037FBD00:
	.word P4_Entry_0230D1BC + 1	; 037FBD00
.thumb

; ===== function loc_037FBD04 =====
loc_037FBD04:
	bx pc	; 037FBD04
	.byte 0xC0, 0x46	; 037FBD08
.arm

; ===== function loc_037FBD08 =====
loc_037FBD08:
	ldr pc,[pool_037FBD0C]	; 037FBD08
pool_037FBD0C:
loc_037FBD0C:
	.word loc_03804908	; 037FBD0C
.thumb

; ===== function loc_037FBD10 =====
loc_037FBD10:
	bx pc	; 037FBD10
	.byte 0xC0, 0x46	; 037FBD14
.arm

; ===== function loc_037FBD14 =====
loc_037FBD14:
	ldr pc,[pool_037FBD18]	; 037FBD14
pool_037FBD18:
loc_037FBD18:
	.word loc_03804B10	; 037FBD18
.thumb

; ===== function loc_037FBD1C =====
loc_037FBD1C:
	bx pc	; 037FBD1C
	.byte 0xC0, 0x46	; 037FBD20
.arm

; ===== function loc_037FBD20 =====
loc_037FBD20:
	ldr r12,[pool_037FBD28]	; 037FBD20
	bx r12	; 037FBD24
pool_037FBD28:
loc_037FBD28:
	.word P4_Entry_0230A3A8 + 1	; 037FBD28
.thumb

; ===== function loc_037FBD2C =====
loc_037FBD2C:
	bx pc	; 037FBD2C
	.byte 0xC0, 0x46	; 037FBD30
.arm

; ===== function loc_037FBD30 =====
loc_037FBD30:
	ldr r12,[pool_037FBD38]	; 037FBD30
	bx r12	; 037FBD34
pool_037FBD38:
loc_037FBD38:
	.word loc_02305D24 + 1	; 037FBD38
.thumb

; ===== function loc_037FBD3C =====
loc_037FBD3C:
	bx pc	; 037FBD3C
	.byte 0xC0, 0x46	; 037FBD40
.arm

; ===== function loc_037FBD40 =====
loc_037FBD40:
	ldr r12,[pool_037FBD48]	; 037FBD40
	bx r12	; 037FBD44
pool_037FBD48:
loc_037FBD48:
	.word loc_02305E90 + 1	; 037FBD48
.thumb

; ===== function loc_037FBD4C =====
loc_037FBD4C:
	bx pc	; 037FBD4C
	.byte 0xC0, 0x46	; 037FBD50
.arm

; ===== function loc_037FBD50 =====
loc_037FBD50:
	ldr r12,[pool_037FBD58]	; 037FBD50
	bx r12	; 037FBD54
pool_037FBD58:
loc_037FBD58:
	.word P4_Entry_02307804 + 1	; 037FBD58
.thumb

; ===== function loc_037FBD5C =====
loc_037FBD5C:
	push {r4,lr}	; 037FBD5C
	ldr r0,[pool_037FBDB8]	; 037FBD5E
	ldr r1,[r0,#0x0]	; 037FBD60
	ldr r0,[pool_037FBDBC]	; 037FBD62
	add r4,r1,r0	; 037FBD64
	bl loc_037FBDE4	; 037FBD66
	bl loc_037FBDF4	; 037FBD6A
	mov r0,#0x20	; 037FBD6E
	bl loc_037FBE34	; 037FBD70
	mov r0,#0x0	; 037FBD74
	add r1,r4,#0x0	; 037FBD76
	add r1,#0xa4	; 037FBD78
	strh r0,[r1,#0x0]	; 037FBD7A
	strh r0,[r4,#0x12]	; 037FBD7C
	ldr r1,[pool_037FBDC0]	; 037FBD7E
	strh r0,[r1,#0x0]	; 037FBD80
	ldr r1,[pool_037FBDC4]	; 037FBD82
	strh r0,[r1,#0x0]	; 037FBD84
	ldr r1,[pool_037FBDC8]	; 037FBD86
	strh r0,[r1,#0x0]	; 037FBD88
	ldr r1,[pool_037FBDCC]	; 037FBD8A
	strh r0,[r1,#0x0]	; 037FBD8C
	ldr r1,[pool_037FBDD0]	; 037FBD8E
	strh r0,[r1,#0x0]	; 037FBD90
	ldr r1,[pool_037FBDD4]	; 037FBD92
	strh r0,[r1,#0x0]	; 037FBD94
	ldrh r0,[r4,#0xc]	; 037FBD96
	cmp r0,#0x1	; 037FBD98
	bne loc_037FBDA0	; 037FBD9A
	bl loc_037FBE04	; 037FBD9C
loc_037FBDA0:
	ldr r1,[pool_037FBDD8]	; 037FBDA0
	ldr r0,[pool_037FBDDC]	; 037FBDA2
	strh r1,[r0,#0x0]	; 037FBDA4
	ldr r0,[pool_037FBDE0]	; 037FBDA6
	strh r1,[r0,#0x0]	; 037FBDA8
	bl loc_037FBE14	; 037FBDAA
	bl loc_037FBE24	; 037FBDAE
	pop {r4}	; 037FBDB2
	pop {r3}	; 037FBDB4
	bx r3	; 037FBDB6
pool_037FBDB8:
loc_037FBDB8:
	.word FirmwareWlWorkPointerSlot	; 037FBDB8
pool_037FBDBC:
loc_037FBDBC:
	.word 0x00000318	; 037FBDBC
pool_037FBDC0:
loc_037FBDC0:
	.word REG_WIFI_IE	; 037FBDC0
pool_037FBDC4:
loc_037FBDC4:
	.word REG_WIFI_MODE_RST	; 037FBDC4
pool_037FBDC8:
loc_037FBDC8:
	.word REG_WIFI_US_COMPARECNT	; 037FBDC8
pool_037FBDCC:
loc_037FBDCC:
	.word REG_WIFI_US_COUNTCNT	; 037FBDCC
pool_037FBDD0:
loc_037FBDD0:
	.word REG_WIFI_TXSTATCNT	; 037FBDD0
pool_037FBDD4:
loc_037FBDD4:
	.word REG_WIFI_UNKNOWN_00A	; 037FBDD4
pool_037FBDD8:
loc_037FBDD8:
	.word 0x0000FFFF	; 037FBDD8
pool_037FBDDC:
loc_037FBDDC:
	.word REG_WIFI_TXREQ_RESET	; 037FBDDC
pool_037FBDE0:
loc_037FBDE0:
	.word REG_WIFI_TXBUF_RESET	; 037FBDE0

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
	.word P4_Entry_02305468 + 1	; 037FBDF0
.thumb

; ===== function loc_037FBDF4 =====
loc_037FBDF4:
	bx pc	; 037FBDF4
	.byte 0xC0, 0x46	; 037FBDF8
.arm

; ===== function loc_037FBDF8 =====
loc_037FBDF8:
	ldr r12,[pool_037FBE00]	; 037FBDF8
	bx r12	; 037FBDFC
pool_037FBE00:
loc_037FBE00:
	.word loc_02305358 + 1	; 037FBE00
.thumb

; ===== function loc_037FBE04 =====
loc_037FBE04:
	bx pc	; 037FBE04
	.byte 0xC0, 0x46	; 037FBE08
.arm

; ===== function loc_037FBE08 =====
loc_037FBE08:
	ldr r12,[pool_037FBE10]	; 037FBE08
	bx r12	; 037FBE0C
pool_037FBE10:
loc_037FBE10:
	.word P4_Entry_0230A38C + 1	; 037FBE10
.thumb

; ===== function loc_037FBE14 =====
loc_037FBE14:
	bx pc	; 037FBE14
	.byte 0xC0, 0x46	; 037FBE18
.arm

; ===== function loc_037FBE18 =====
loc_037FBE18:
	ldr r12,[pool_037FBE20]	; 037FBE18
	bx r12	; 037FBE1C
pool_037FBE20:
loc_037FBE20:
	.word P4_Entry_0230A514 + 1	; 037FBE20
.thumb

; ===== function loc_037FBE24 =====
loc_037FBE24:
	bx pc	; 037FBE24
	.byte 0xC0, 0x46	; 037FBE28
.arm

; ===== function loc_037FBE28 =====
loc_037FBE28:
	ldr r12,[pool_037FBE30]	; 037FBE28
	bx r12	; 037FBE2C
pool_037FBE30:
loc_037FBE30:
	.word P4_Entry_02304C4C + 1	; 037FBE30
.thumb

; ===== function loc_037FBE34 =====
loc_037FBE34:
	push {r4,r5,lr}	; 037FBE34
	sub sp,#0x4	; 037FBE36
	add r5,r0,#0x0	; 037FBE38
	ldr r0,[pool_037FBE90]	; 037FBE3A
	ldr r1,[r0,#0x0]	; 037FBE3C
	ldr r0,[pool_037FBE94]	; 037FBE3E
	add r4,r1,r0	; 037FBE40
	ldrh r0,[r4,#0x8]	; 037FBE42
	cmp r0,r5	; 037FBE44
	beq loc_037FBE88	; 037FBE46
	cmp r0,#0x40	; 037FBE48
	bne loc_037FBE50	; 037FBE4A
	bl loc_037FBDF4	; 037FBE4C
loc_037FBE50:
	cmp r5,#0x0	; 037FBE50
	beq loc_037FBE5E	; 037FBE52
	cmp r5,#0x10	; 037FBE54
	beq loc_037FBE64	; 037FBE56
	cmp r5,#0x40	; 037FBE58
	beq loc_037FBE74	; 037FBE5A
	b loc_037FBE86	; 037FBE5C
loc_037FBE5E:
	bl loc_037FBE9C	; 037FBE5E
	b loc_037FBE86	; 037FBE62
loc_037FBE64:
	mov r0,#0x0	; 037FBE64
	bl loc_037FBEAC	; 037FBE66
	bl loc_037FBD5C	; 037FBE6A
	bl loc_037FBEBC	; 037FBE6E
	b loc_037FBE86	; 037FBE72
loc_037FBE74:
	ldrh r0,[r4,#0xc]	; 037FBE74
	cmp r0,#0x2	; 037FBE76
	bne loc_037FBE7E	; 037FBE78
	bl loc_037FBECC	; 037FBE7A
loc_037FBE7E:
	mov r0,#0x64	; 037FBE7E
	ldr r1,[pool_037FBE98]	; 037FBE80
	bl loc_037FBEDC	; 037FBE82
loc_037FBE86:
	strh r5,[r4,#0x8]	; 037FBE86
loc_037FBE88:
	add sp,#0x4	; 037FBE88
	pop {r4,r5}	; 037FBE8A
	pop {r3}	; 037FBE8C
	bx r3	; 037FBE8E
pool_037FBE90:
loc_037FBE90:
	.word FirmwareWlWorkPointerSlot	; 037FBE90
pool_037FBE94:
loc_037FBE94:
	.word 0x00000318	; 037FBE94
pool_037FBE98:
loc_037FBE98:
	.word 0x02305409	; 037FBE98

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
	.word loc_02305E30 + 1	; 037FBEA8
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
	.word loc_02305E84 + 1	; 037FBEB8
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
	.word loc_02305DC8 + 1	; 037FBEC8
.thumb

; ===== function loc_037FBECC =====
loc_037FBECC:
	bx pc	; 037FBECC
	.byte 0xC0, 0x46	; 037FBED0
.arm

; ===== function loc_037FBED0 =====
loc_037FBED0:
	ldr r12,[pool_037FBED8]	; 037FBED0
	bx r12	; 037FBED4
pool_037FBED8:
loc_037FBED8:
	.word loc_02305D00 + 1	; 037FBED8
.thumb

; ===== function loc_037FBEDC =====
loc_037FBEDC:
	bx pc	; 037FBEDC
	.byte 0xC0, 0x46	; 037FBEE0
.arm

; ===== function loc_037FBEE0 =====
loc_037FBEE0:
	ldr r12,[pool_037FBEE8]	; 037FBEE0
	bx r12	; 037FBEE4
pool_037FBEE8:
loc_037FBEE8:
	.word P4_Entry_02305480 + 1	; 037FBEE8
.thumb
P2_IrqHandler_037FBEEC:
	push {r4,r5,r6,r7,lr}	; 037FBEEC
	sub sp,#0x4	; 037FBEEE
	mov r7,#0x1	; 037FBEF0
	ldr r4,[pool_037FBFBC]	; 037FBEF2
	ldr r6,[pool_037FBFC0]	; 037FBEF4
P2_Entry_037FBEF6:
	ldrh r5,[r4,#0x0]	; 037FBEF6
	ldrh r0,[r6,#0x0]	; 037FBEF8
	and r5,r0	; 037FBEFA
	cmp r5,#0x0	; 037FBEFC
	beq P2_Entry_037FBFA8	; 037FBEFE
	add r1,r5,#0x0	; 037FBF00
	mov r0,#0x80	; 037FBF02
	and r1,r0	; 037FBF04
	cmp r1,#0x0	; 037FBF06
	beq P2_Entry_037FBF0E	; 037FBF08
	bl P2_Entry_037FCA18	; 037FBF0A
P2_Entry_037FBF0E:
	add r1,r5,#0x0	; 037FBF0E
	mov r0,#0x40	; 037FBF10
	and r1,r0	; 037FBF12
	cmp r1,#0x0	; 037FBF14
	beq P2_Entry_037FBF1C	; 037FBF16
	bl P2_Entry_037FCA98	; 037FBF18
P2_Entry_037FBF1C:
	add r1,r5,#0x0	; 037FBF1C
	ldr r0,[pool_037FBFC4]	; 037FBF1E
	and r1,r0	; 037FBF20
	cmp r1,#0x0	; 037FBF22
	beq P2_Entry_037FBF2A	; 037FBF24
	bl P2_Entry_037FBFF0	; 037FBF26
P2_Entry_037FBF2A:
	add r1,r5,#0x0	; 037FBF2A
	ldr r0,[pool_037FBFC8]	; 037FBF2C
	and r1,r0	; 037FBF2E
	cmp r1,#0x0	; 037FBF30
	beq P2_Entry_037FBF38	; 037FBF32
	bl P2_Entry_037FC068	; 037FBF34
P2_Entry_037FBF38:
	add r1,r5,#0x0	; 037FBF38
	ldr r0,[pool_037FBFCC]	; 037FBF3A
	and r1,r0	; 037FBF3C
	cmp r1,#0x0	; 037FBF3E
	beq P2_Entry_037FBF46	; 037FBF40
	bl P2_Entry_037FC2B0	; 037FBF42
P2_Entry_037FBF46:
	add r1,r5,#0x0	; 037FBF46
	ldr r0,[pool_037FBFD0]	; 037FBF48
	and r1,r0	; 037FBF4A
	cmp r1,#0x0	; 037FBF4C
	beq P2_Entry_037FBF54	; 037FBF4E
	bl P2_Entry_037FBFE0	; 037FBF50
P2_Entry_037FBF54:
	add r1,r5,#0x0	; 037FBF54
	mov r0,#0x8	; 037FBF56
	and r1,r0	; 037FBF58
	cmp r1,#0x0	; 037FBF5A
	beq P2_Entry_037FBF62	; 037FBF5C
	bl P2_Entry_037FC340	; 037FBF5E
P2_Entry_037FBF62:
	add r1,r5,#0x0	; 037FBF62
	mov r0,#0x4	; 037FBF64
	and r1,r0	; 037FBF66
	cmp r1,#0x0	; 037FBF68
	beq P2_Entry_037FBF70	; 037FBF6A
	bl P2_Entry_037FC41C	; 037FBF6C
P2_Entry_037FBF70:
	add r0,r5,#0x0	; 037FBF70
	and r0,r7	; 037FBF72
	cmp r0,#0x0	; 037FBF74
	beq P2_Entry_037FBF7C	; 037FBF76
	bl P2_Entry_037FC764	; 037FBF78
P2_Entry_037FBF7C:
	add r1,r5,#0x0	; 037FBF7C
	mov r0,#0x30	; 037FBF7E
	and r1,r0	; 037FBF80
	cmp r1,#0x0	; 037FBF82
	beq P2_Entry_037FBF8A	; 037FBF84
	bl P2_Entry_037FC308	; 037FBF86
P2_Entry_037FBF8A:
	add r1,r5,#0x0	; 037FBF8A
	mov r0,#0x2	; 037FBF8C
	and r1,r0	; 037FBF8E
	cmp r1,#0x0	; 037FBF90
	beq P2_Entry_037FBF98	; 037FBF92
	bl P2_Entry_037FC58C	; 037FBF94
P2_Entry_037FBF98:
	ldr r0,[pool_037FBFD4]	; 037FBF98
	and r5,r0	; 037FBF9A
	cmp r5,#0x0	; 037FBF9C
	beq P2_Entry_037FBEF6	; 037FBF9E
	add r0,r7,#0x0	; 037FBFA0
	bl P2_Entry_037FC958	; 037FBFA2
	b P2_Entry_037FBEF6	; 037FBFA6
P2_Entry_037FBFA8:
	ldr r2,[pool_037FBFD8]	; 037FBFA8
	ldr r1,[r2,#0x0]	; 037FBFAA
	ldr r0,[pool_037FBFDC]	; 037FBFAC
	orr r1,r0	; 037FBFAE
	str r1,[r2,#0x0]	; 037FBFB0
	add sp,#0x4	; 037FBFB2
	pop {r4,r5,r6,r7}	; 037FBFB4
	pop {r3}	; 037FBFB6
	bx r3	; 037FBFB8
	.byte 0xC0, 0x46	; 037FBFBA
pool_037FBFBC:
	.word REG_WIFI_IF	; 037FBFBC
pool_037FBFC0:
	.word REG_WIFI_IE	; 037FBFC0
pool_037FBFC4:
	.word 0x00008000	; 037FBFC4
pool_037FBFC8:
	.word 0x00004000	; 037FBFC8
pool_037FBFCC:
	.word 0x00002000	; 037FBFCC
pool_037FBFD0:
	.word 0x00000800	; 037FBFD0
pool_037FBFD4:
	.word 0x00001000	; 037FBFD4
pool_037FBFD8:
	.word Bios7IrqFlagsAddress	; 037FBFD8
pool_037FBFDC:
	.word 0x01000000	; 037FBFDC
P2_Entry_037FBFE0:
	bx pc	; 037FBFE0
	.byte 0xC0, 0x46	; 037FBFE2
.arm
	ldr r12,[pool_037FBFEC]	; 037FBFE4
	bx r12	; 037FBFE8
pool_037FBFEC:
	.word P4_Entry_02306E3C + 1	; 037FBFEC
P2_Entry_037FBFF0:
.thumb
	push {r4,lr}	; 037FBFF0
	ldr r0,[pool_037FC058]	; 037FBFF2
	ldr r1,[r0,#0x0]	; 037FBFF4
	ldr r0,[pool_037FC05C]	; 037FBFF6
	add r4,r1,r0	; 037FBFF8
	ldr r1,[pool_037FC060]	; 037FBFFA
	ldr r0,[pool_037FC064]	; 037FBFFC
	strh r1,[r0,#0x0]	; 037FBFFE
	ldrh r0,[r4,#0x8]	; 037FC000
	cmp r0,#0x40	; 037FC002
	bne P2_Entry_037FC04E	; 037FC004
	add r0,r4,#0x0	; 037FC006
	add r0,#0x7e	; 037FC008
	ldrh r0,[r0,#0x0]	; 037FC00A
	cmp r0,#0x0	; 037FC00C
	beq P2_Entry_037FC04E	; 037FC00E
	add r0,r4,#0x0	; 037FC010
	add r0,#0x72	; 037FC012
	ldrh r1,[r0,#0x0]	; 037FC014
	add r0,r4,#0x0	; 037FC016
	add r0,#0x70	; 037FC018
	ldrh r0,[r0,#0x0]	; 037FC01A
	cmp r1,r0	; 037FC01C
	bne P2_Entry_037FC04E	; 037FC01E
	add r0,r4,#0x0	; 037FC020
	add r0,#0x80	; 037FC022
	ldrh r0,[r0,#0x0]	; 037FC024
	add r1,r0,#0x1	; 037FC026
	add r0,r4,#0x0	; 037FC028
	add r0,#0x80	; 037FC02A
	strh r1,[r0,#0x0]	; 037FC02C
	add r0,r4,#0x0	; 037FC02E
	add r0,#0x80	; 037FC030
	ldrh r1,[r0,#0x0]	; 037FC032
	add r0,r4,#0x0	; 037FC034
	add r0,#0x7e	; 037FC036
	ldrh r0,[r0,#0x0]	; 037FC038
	cmp r1,r0	; 037FC03A
	bls P2_Entry_037FC04E	; 037FC03C
	mov r1,#0x0	; 037FC03E
	add r0,r4,#0x0	; 037FC040
	add r0,#0x80	; 037FC042
	strh r1,[r0,#0x0]	; 037FC044
	mov r0,#0x1	; 037FC046
	mov r1,#0xd	; 037FC048
	bl loc_037FB380	; 037FC04A
P2_Entry_037FC04E:
	mov r0,#0x1	; 037FC04E
	strh r0,[r4,#0x10]	; 037FC050
	pop {r4}	; 037FC052
	pop {r3}	; 037FC054
	bx r3	; 037FC056
pool_037FC058:
	.word FirmwareWlWorkPointerSlot	; 037FC058
pool_037FC05C:
	.word 0x00000318	; 037FC05C
pool_037FC060:
	.word 0x00008000	; 037FC060
pool_037FC064:
	.word REG_WIFI_IF	; 037FC064
P2_Entry_037FC068:
	push {r4,r5,r6,r7,lr}	; 037FC068
	sub sp,#0xc	; 037FC06A
	ldr r0,[pool_037FC25C]	; 037FC06C
	ldr r1,[r0,#0x0]	; 037FC06E
	ldr r0,[pool_037FC260]	; 037FC070
	add r5,r1,r0	; 037FC072
	ldr r0,[pool_037FC264]	; 037FC074
	add r6,r1,r0	; 037FC076
	ldr r0,[pool_037FC268]	; 037FC078
	add r4,r1,r0	; 037FC07A
	ldr r1,[pool_037FC26C]	; 037FC07C
	ldr r0,[pool_037FC270]	; 037FC07E
	strh r1,[r0,#0x0]	; 037FC080
	ldrh r0,[r5,#0xc]	; 037FC082
	cmp r0,#0x1	; 037FC084
	beq P2_Entry_037FC092	; 037FC086
	cmp r0,#0x2	; 037FC088
	beq P2_Entry_037FC124	; 037FC08A
	cmp r0,#0x3	; 037FC08C
	beq P2_Entry_037FC14A	; 037FC08E
	b P2_Entry_037FC254	; 037FC090
P2_Entry_037FC092:
	add r0,r4,#0x0	; 037FC092
	add r0,#0x80	; 037FC094
	ldr r1,[r0,#0x0]	; 037FC096
	add r1,#0x24	; 037FC098
	add r0,r5,#0x0	; 037FC09A
	add r0,#0x96	; 037FC09C
	ldrh r0,[r0,#0x0]	; 037FC09E
	add r7,r1,r0	; 037FC0A0
	add r7,#0x8	; 037FC0A2
	ldr r0,[pool_037FC274]	; 037FC0A4
	ldrh r0,[r0,#0x0]	; 037FC0A6
	str r0,[sp,#0x0]	; 037FC0A8
	add r0,r7,#0x0	; 037FC0AA
	ldr r1,[sp,#0x0]	; 037FC0AC
	lsl r1,r1,#0x18	; 037FC0AE
	lsr r1,r1,#0x18	; 037FC0B0
	bl P2_Entry_037FC2A0	; 037FC0B2
	add r0,r7,#0x1	; 037FC0B6
	ldr r1,[sp,#0x0]	; 037FC0B8
	lsr r1,r1,#0x8	; 037FC0BA
	lsl r1,r1,#0x18	; 037FC0BC
	lsr r1,r1,#0x18	; 037FC0BE
	bl P2_Entry_037FC2A0	; 037FC0C0
	ldrh r0,[r5,#0xe]	; 037FC0C4
	cmp r0,#0x1	; 037FC0C6
	bne P2_Entry_037FC0D6	; 037FC0C8
	ldrh r2,[r6,#0x20]	; 037FC0CA
	ldr r1,[pool_037FC278]	; 037FC0CC
	ldrh r0,[r1,#0x0]	; 037FC0CE
	add r0,r2,r0	; 037FC0D0
	add r0,r0,#0x1	; 037FC0D2
	strh r0,[r1,#0x0]	; 037FC0D4
P2_Entry_037FC0D6:
	ldr r0,[pool_037FC25C]	; 037FC0D6
	ldr r0,[r0,#0x0]	; 037FC0D8
	ldr r1,[pool_037FC27C]	; 037FC0DA
	ldrh r1,[r0,r1]	; 037FC0DC
	mvn r2,r1	; 037FC0DE
	ldr r1,[pool_037FC280]	; 037FC0E0
	ldrh r1,[r0,r1]	; 037FC0E2
	orr r2,r1	; 037FC0E4
	ldr r1,[pool_037FC284]	; 037FC0E6
	strh r2,[r0,r1]	; 037FC0E8
	ldr r0,[pool_037FC288]	; 037FC0EA
	ldrh r2,[r0,#0x0]	; 037FC0EC
	mov r0,#0x18	; 037FC0EE
	add r1,r2,#0x0	; 037FC0F0
	and r1,r0	; 037FC0F2
	cmp r1,#0x0	; 037FC0F4
	bne P2_Entry_037FC100	; 037FC0F6
	mov r0,#0x6	; 037FC0F8
	and r2,r0	; 037FC0FA
	cmp r2,#0x2	; 037FC0FC
	bne P2_Entry_037FC114	; 037FC0FE
P2_Entry_037FC100:
	add r0,r4,#0x0	; 037FC100
	add r0,#0x8c	; 037FC102
	ldr r1,[r0,#0x0]	; 037FC104
	mov r0,#0x2	; 037FC106
	bic r1,r0	; 037FC108
	add r4,#0x8c	; 037FC10A
	str r1,[r4,#0x0]	; 037FC10C
	bl P2_Entry_037FCC7C	; 037FC10E
	b P2_Entry_037FC254	; 037FC112
P2_Entry_037FC114:
	add r0,r4,#0x0	; 037FC114
	add r0,#0x8c	; 037FC116
	ldr r1,[r0,#0x0]	; 037FC118
	mov r0,#0x2	; 037FC11A
	orr r1,r0	; 037FC11C
	add r4,#0x8c	; 037FC11E
	str r1,[r4,#0x0]	; 037FC120
	b P2_Entry_037FC254	; 037FC122
P2_Entry_037FC124:
	ldrh r0,[r5,#0x12]	; 037FC124
	cmp r0,#0x0	; 037FC126
	beq P2_Entry_037FC138	; 037FC128
	ldrh r2,[r6,#0x20]	; 037FC12A
	ldr r1,[pool_037FC278]	; 037FC12C
	ldrh r0,[r1,#0x0]	; 037FC12E
	add r0,r2,r0	; 037FC130
	add r0,r0,#0x1	; 037FC132
	strh r0,[r1,#0x0]	; 037FC134
	b P2_Entry_037FC13E	; 037FC136
P2_Entry_037FC138:
	ldr r1,[pool_037FC28C]	; 037FC138
	ldr r0,[pool_037FC278]	; 037FC13A
	strh r1,[r0,#0x0]	; 037FC13C
P2_Entry_037FC13E:
	ldrh r0,[r5,#0x1a]	; 037FC13E
	cmp r0,#0x2	; 037FC140
	bne P2_Entry_037FC14A	; 037FC142
	mov r0,#0x2	; 037FC144
	bl loc_037FBD3C	; 037FC146
P2_Entry_037FC14A:
	ldrh r0,[r5,#0x8]	; 037FC14A
	cmp r0,#0x40	; 037FC14C
	beq P2_Entry_037FC154	; 037FC14E
	mov r0,#0x1	; 037FC150
	b P2_Entry_037FC182	; 037FC152
P2_Entry_037FC154:
	mov r0,#0x0	; 037FC154
	add r1,r5,#0x0	; 037FC156
	add r1,#0x72	; 037FC158
	ldrh r1,[r1,#0x0]	; 037FC15A
	cmp r1,#0x1	; 037FC15C
	bne P2_Entry_037FC162	; 037FC15E
	mov r0,#0x1	; 037FC160
P2_Entry_037FC162:
	ldrh r1,[r5,#0x14]	; 037FC162
	cmp r1,#0x0	; 037FC164
	beq P2_Entry_037FC182	; 037FC166
	add r1,r5,#0x0	; 037FC168
	add r1,#0x76	; 037FC16A
	ldrh r1,[r1,#0x0]	; 037FC16C
	cmp r1,#0x1	; 037FC16E
	beq P2_Entry_037FC180	; 037FC170
	cmp r1,#0x0	; 037FC172
	bne P2_Entry_037FC182	; 037FC174
	add r1,r5,#0x0	; 037FC176
	add r1,#0x74	; 037FC178
	ldrh r1,[r1,#0x0]	; 037FC17A
	cmp r1,#0x1	; 037FC17C
	bne P2_Entry_037FC182	; 037FC17E
P2_Entry_037FC180:
	mov r0,#0x1	; 037FC180
P2_Entry_037FC182:
	cmp r0,#0x0	; 037FC182
	beq P2_Entry_037FC192	; 037FC184
	ldr r2,[pool_037FC290]	; 037FC186
	ldrh r1,[r2,#0x0]	; 037FC188
	mov r0,#0x1	; 037FC18A
	orr r1,r0	; 037FC18C
	strh r1,[r2,#0x0]	; 037FC18E
	b P2_Entry_037FC19C	; 037FC190
P2_Entry_037FC192:
	ldr r2,[pool_037FC290]	; 037FC192
	ldrh r1,[r2,#0x0]	; 037FC194
	mov r0,#0x1	; 037FC196
	bic r1,r0	; 037FC198
	strh r1,[r2,#0x0]	; 037FC19A
P2_Entry_037FC19C:
	ldr r0,[pool_037FC294]	; 037FC19C
	ldrh r0,[r0,#0x0]	; 037FC19E
	cmp r0,#0xa	; 037FC1A0
	bls P2_Entry_037FC1AA	; 037FC1A2
	mov r1,#0x0	; 037FC1A4
	ldr r0,[pool_037FC298]	; 037FC1A6
	strh r1,[r0,#0x0]	; 037FC1A8
P2_Entry_037FC1AA:
	add r0,r5,#0x0	; 037FC1AA
	add r0,#0x72	; 037FC1AC
	ldrh r0,[r0,#0x0]	; 037FC1AE
	sub r1,r0,#0x1	; 037FC1B0
	add r0,r5,#0x0	; 037FC1B2
	add r0,#0x72	; 037FC1B4
	strh r1,[r0,#0x0]	; 037FC1B6
	add r0,r5,#0x0	; 037FC1B8
	add r0,#0x72	; 037FC1BA
	ldrh r0,[r0,#0x0]	; 037FC1BC
	cmp r0,#0x0	; 037FC1BE
	bne P2_Entry_037FC1CE	; 037FC1C0
	add r0,r5,#0x0	; 037FC1C2
	add r0,#0x70	; 037FC1C4
	ldrh r1,[r0,#0x0]	; 037FC1C6
	add r0,r5,#0x0	; 037FC1C8
	add r0,#0x72	; 037FC1CA
	strh r1,[r0,#0x0]	; 037FC1CC
P2_Entry_037FC1CE:
	add r0,r5,#0x0	; 037FC1CE
	add r0,#0x76	; 037FC1D0
	ldrh r2,[r0,#0x0]	; 037FC1D2
	add r0,r5,#0x0	; 037FC1D4
	add r0,#0x76	; 037FC1D6
	ldrh r0,[r0,#0x0]	; 037FC1D8
	sub r1,r0,#0x1	; 037FC1DA
	add r0,r5,#0x0	; 037FC1DC
	add r0,#0x76	; 037FC1DE
	strh r1,[r0,#0x0]	; 037FC1E0
	cmp r2,#0x0	; 037FC1E2
	bne P2_Entry_037FC1F4	; 037FC1E4
	add r0,r5,#0x0	; 037FC1E6
	add r0,#0x74	; 037FC1E8
	ldrh r0,[r0,#0x0]	; 037FC1EA
	sub r1,r0,#0x1	; 037FC1EC
	add r0,r5,#0x0	; 037FC1EE
	add r0,#0x76	; 037FC1F0
	strh r1,[r0,#0x0]	; 037FC1F2
P2_Entry_037FC1F4:
	mov r6,#0x0	; 037FC1F4
	str r6,[sp,#0x4]	; 037FC1F6
P2_Entry_037FC1F8:
	add r1,r6,#0x0	; 037FC1F8
	mov r0,#0x14	; 037FC1FA
	mul r1,r0	; 037FC1FC
	add r7,r4,r1	; 037FC1FE
	ldrh r0,[r4,r1]	; 037FC200
	cmp r0,#0x0	; 037FC202
	beq P2_Entry_037FC248	; 037FC204
	ldr r0,[r7,#0xc]	; 037FC206
	ldrh r1,[r0,#0x8]	; 037FC208
	cmp r1,#0x0	; 037FC20A
	bne P2_Entry_037FC248	; 037FC20C
	add r1,r5,#0x0	; 037FC20E
	add r1,#0xa8	; 037FC210
	ldr r1,[r1,#0x0]	; 037FC212
	ldrh r0,[r0,#0x4]	; 037FC214
	sub r0,r1,r0	; 037FC216
	lsl r0,r0,#0x10	; 037FC218
	lsr r1,r0,#0x10	; 037FC21A
	add r0,r5,#0x0	; 037FC21C
	add r0,#0x8c	; 037FC21E
	ldrh r0,[r0,#0x0]	; 037FC220
	cmp r1,r0	; 037FC222
	bls P2_Entry_037FC248	; 037FC224
	add r0,r6,#0x0	; 037FC226
	bl P2_Entry_037FCCDC	; 037FC228
	ldr r1,[r7,#0x8]	; 037FC22C
	mov r0,#0x2	; 037FC22E
	strh r0,[r1,#0x0]	; 037FC230
	ldr r0,[sp,#0x4]	; 037FC232
	mov r1,#0xe	; 037FC234
	bl loc_037FB380	; 037FC236
	add r0,r4,#0x0	; 037FC23A
	add r0,#0xb0	; 037FC23C
	ldrh r0,[r0,#0x0]	; 037FC23E
	add r1,r0,#0x1	; 037FC240
	add r0,r4,#0x0	; 037FC242
	add r0,#0xb0	; 037FC244
	strh r1,[r0,#0x0]	; 037FC246
P2_Entry_037FC248:
	add r6,r6,#0x1	; 037FC248
	cmp r6,#0x2	; 037FC24A
	bcc P2_Entry_037FC1F8	; 037FC24C
	mov r1,#0xd	; 037FC24E
	ldr r0,[pool_037FC29C]	; 037FC250
	strh r1,[r0,#0x0]	; 037FC252
P2_Entry_037FC254:
	add sp,#0xc	; 037FC254
	pop {r4,r5,r6,r7}	; 037FC256
	pop {r3}	; 037FC258
	bx r3	; 037FC25A
pool_037FC25C:
	.word FirmwareWlWorkPointerSlot	; 037FC25C
pool_037FC260:
	.word 0x00000318	; 037FC260
pool_037FC264:
	.word 0x000002F0	; 037FC264
pool_037FC268:
	.word 0x00000400	; 037FC268
pool_037FC26C:
	.word 0x00004000	; 037FC26C
pool_037FC270:
	.word REG_WIFI_IF	; 037FC270
pool_037FC274:
	.word FirmwareWlAdjustedTimeSlot	; 037FC274
pool_037FC278:
	.word REG_WIFI_POST_BEACON	; 037FC278
pool_037FC27C:
	.word 0x00000506	; 037FC27C
pool_037FC280:
	.word 0x0000050A	; 037FC280
pool_037FC284:
	.word 0x00000508	; 037FC284
pool_037FC288:
	.word REG_WIFI_TXBUSY	; 037FC288
pool_037FC28C:
	.word 0x0000FFFF	; 037FC28C
pool_037FC290:
	.word REG_WIFI_POWER_TX	; 037FC290
pool_037FC294:
	.word REG_WIFI_CMD_COUNT	; 037FC294
pool_037FC298:
	.word REG_WIFI_UNKNOWN_048	; 037FC298
pool_037FC29C:
	.word REG_WIFI_TXREQ_SET	; 037FC29C
P2_Entry_037FC2A0:
	bx pc	; 037FC2A0
	.byte 0xC0, 0x46	; 037FC2A2
.arm
	ldr r12,[pool_037FC2AC]	; 037FC2A4
	bx r12	; 037FC2A8
pool_037FC2AC:
	.word loc_023051A4 + 1	; 037FC2AC
P2_Entry_037FC2B0:
.thumb
	ldr r0,[pool_037FC2F0]	; 037FC2B0
	ldr r1,[r0,#0x0]	; 037FC2B2
	ldr r0,[pool_037FC2F4]	; 037FC2B4
	add r0,r1,r0	; 037FC2B6
	ldr r2,[pool_037FC2F8]	; 037FC2B8
	ldr r1,[pool_037FC2FC]	; 037FC2BA
	strh r2,[r1,#0x0]	; 037FC2BC
	mov r2,#0xd	; 037FC2BE
	ldr r1,[pool_037FC300]	; 037FC2C0
	strh r2,[r1,#0x0]	; 037FC2C2
	ldrh r1,[r0,#0x1a]	; 037FC2C4
	cmp r1,#0x1	; 037FC2C6
	bne P2_Entry_037FC2D0	; 037FC2C8
	mov r1,#0x2	; 037FC2CA
	strh r1,[r0,#0x1a]	; 037FC2CC
	bx lr	; 037FC2CE
P2_Entry_037FC2D0:
	cmp r1,#0x2	; 037FC2D0
	bne P2_Entry_037FC2DA	; 037FC2D2
	mov r1,#0x0	; 037FC2D4
	strh r1,[r0,#0x1a]	; 037FC2D6
	bx lr	; 037FC2D8
P2_Entry_037FC2DA:
	ldrh r1,[r0,#0xc]	; 037FC2DA
	cmp r1,#0x2	; 037FC2DC
	bne P2_Entry_037FC2EC	; 037FC2DE
	ldrh r0,[r0,#0x8]	; 037FC2E0
	cmp r0,#0x40	; 037FC2E2
	beq P2_Entry_037FC2EC	; 037FC2E4
	mov r1,#0x0	; 037FC2E6
	ldr r0,[pool_037FC304]	; 037FC2E8
	strh r1,[r0,#0x0]	; 037FC2EA
P2_Entry_037FC2EC:
	bx lr	; 037FC2EC
	.byte 0xC0, 0x46	; 037FC2EE
pool_037FC2F0:
	.word FirmwareWlWorkPointerSlot	; 037FC2F0
pool_037FC2F4:
	.word 0x00000318	; 037FC2F4
pool_037FC2F8:
	.word 0x00002000	; 037FC2F8
pool_037FC2FC:
	.word REG_WIFI_IF	; 037FC2FC
pool_037FC300:
	.word REG_WIFI_TXREQ_RESET	; 037FC300
pool_037FC304:
	.word REG_WIFI_UNKNOWN_048	; 037FC304
P2_Entry_037FC308:
	push {lr}	; 037FC308
	sub sp,#0x4	; 037FC30A
	bl P2_Entry_037FC330	; 037FC30C
	ldr r1,[pool_037FC324]	; 037FC310
	ldr r0,[pool_037FC328]	; 037FC312
	strh r1,[r0,#0x0]	; 037FC314
	mov r1,#0x30	; 037FC316
	ldr r0,[pool_037FC32C]	; 037FC318
	strh r1,[r0,#0x0]	; 037FC31A
	add sp,#0x4	; 037FC31C
	pop {r3}	; 037FC31E
	bx r3	; 037FC320
	.byte 0xC0, 0x46	; 037FC322
pool_037FC324:
	.word 0x0000FFFF	; 037FC324
pool_037FC328:
	.word REG_WIFI_RXSTAT_OVF_IF	; 037FC328
pool_037FC32C:
	.word REG_WIFI_IF	; 037FC32C
P2_Entry_037FC330:
	bx pc	; 037FC330
	.byte 0xC0, 0x46	; 037FC332
.arm
	ldr r12,[pool_037FC33C]	; 037FC334
	bx r12	; 037FC338
pool_037FC33C:
	.word P4_Entry_02305958 + 1	; 037FC33C
P2_Entry_037FC340:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC340
	sub sp,#0x4	; 037FC342
	mov r1,#0x8	; 037FC344
	ldr r0,[pool_037FC3F0]	; 037FC346
	strh r1,[r0,#0x0]	; 037FC348
	ldr r0,[pool_037FC3F4]	; 037FC34A
	ldr r1,[r0,#0x0]	; 037FC34C
	ldr r0,[pool_037FC3F8]	; 037FC34E
	ldrh r0,[r1,r0]	; 037FC350
	lsl r0,r0,#0x1b	; 037FC352
	lsr r0,r0,#0x1f	; 037FC354
	cmp r0,#0x0	; 037FC356
	beq P2_Entry_037FC36E	; 037FC358
	ldr r0,[pool_037FC3FC]	; 037FC35A
	ldrh r1,[r0,#0x0]	; 037FC35C
	mov r0,#0x1	; 037FC35E
	and r1,r0	; 037FC360
	cmp r1,#0x0	; 037FC362
	bne P2_Entry_037FC36E	; 037FC364
	ldr r2,[pool_037FC400]	; 037FC366
	ldrh r1,[r2,#0x0]	; 037FC368
	eor r1,r0	; 037FC36A
	strh r1,[r2,#0x0]	; 037FC36C
P2_Entry_037FC36E:
	ldr r0,[pool_037FC3F4]	; 037FC36E
	ldr r2,[r0,#0x0]	; 037FC370
	ldr r0,[pool_037FC404]	; 037FC372
	ldrh r1,[r2,r0]	; 037FC374
	mov r0,#0x8	; 037FC376
	and r1,r0	; 037FC378
	cmp r1,#0x0	; 037FC37A
	beq P2_Entry_037FC3E6	; 037FC37C
	ldr r0,[pool_037FC408]	; 037FC37E
	add r5,r2,r0	; 037FC380
	ldr r0,[pool_037FC40C]	; 037FC382
	add r4,r2,r0	; 037FC384
	mov r6,#0x0	; 037FC386
	add r1,r6,#0x0	; 037FC388
	ldr r0,[pool_037FC410]	; 037FC38A
P2_Entry_037FC38C:
	add r3,r6,#0x0	; 037FC38C
	mov r2,#0x14	; 037FC38E
	mul r3,r2	; 037FC390
	add r7,r4,r3	; 037FC392
	ldrh r2,[r4,r3]	; 037FC394
	cmp r2,#0x0	; 037FC396
	beq P2_Entry_037FC3E0	; 037FC398
	ldr r3,[r7,#0x8]	; 037FC39A
	ldrh r7,[r3,#0xc]	; 037FC39C
	ldr r2,[pool_037FC414]	; 037FC39E
	and r7,r2	; 037FC3A0
	cmp r7,#0x0	; 037FC3A2
	beq P2_Entry_037FC3E0	; 037FC3A4
	ldrh r7,[r3,#0x4]	; 037FC3A6
	mov r2,#0xff	; 037FC3A8
	and r7,r2	; 037FC3AA
	cmp r7,#0x0	; 037FC3AC
	beq P2_Entry_037FC3E0	; 037FC3AE
	add r7,r3,#0x0	; 037FC3B0
	add r7,#0xc	; 037FC3B2
	ldrh r2,[r3,#0xa]	; 037FC3B4
	add r2,r7,r2	; 037FC3B6
	sub r2,r2,#0x7	; 037FC3B8
	mov r7,#0x1	; 037FC3BA
	bic r2,r7	; 037FC3BC
	ldrh r7,[r2,#0x0]	; 037FC3BE
	cmp r7,#0x0	; 037FC3C0
	bne P2_Entry_037FC3E0	; 037FC3C2
	ldrh r2,[r2,#0x2]	; 037FC3C4
	cmp r2,#0x0	; 037FC3C6
	bne P2_Entry_037FC3E0	; 037FC3C8
	strh r1,[r3,#0x4]	; 037FC3CA
	strh r1,[r0,#0x0]	; 037FC3CC
	ldr r2,[pool_037FC418]	; 037FC3CE
	strh r2,[r0,#0x0]	; 037FC3D0
	add r2,r5,#0x0	; 037FC3D2
	add r2,#0xba	; 037FC3D4
	ldrh r2,[r2,#0x0]	; 037FC3D6
	add r3,r2,#0x1	; 037FC3D8
	add r2,r5,#0x0	; 037FC3DA
	add r2,#0xba	; 037FC3DC
	strh r3,[r2,#0x0]	; 037FC3DE
P2_Entry_037FC3E0:
	add r6,r6,#0x1	; 037FC3E0
	cmp r6,#0x3	; 037FC3E2
	bcc P2_Entry_037FC38C	; 037FC3E4
P2_Entry_037FC3E6:
	add sp,#0x4	; 037FC3E6
	pop {r4,r5,r6,r7}	; 037FC3E8
	pop {r3}	; 037FC3EA
	bx r3	; 037FC3EC
	.byte 0xC0, 0x46	; 037FC3EE
pool_037FC3F0:
	.word REG_WIFI_IF	; 037FC3F0
pool_037FC3F4:
	.word FirmwareWlWorkPointerSlot	; 037FC3F4
pool_037FC3F8:
	.word 0x0000030E	; 037FC3F8
pool_037FC3FC:
	.word REG_WIFI_RF_PINS	; 037FC3FC
pool_037FC400:
	.word REG_WIFI_UNKNOWN_290	; 037FC400
pool_037FC404:
	.word 0x00000638	; 037FC404
pool_037FC408:
	.word 0x00000318	; 037FC408
pool_037FC40C:
	.word 0x00000400	; 037FC40C
pool_037FC410:
	.word 0x04808032	; 037FC410
pool_037FC414:
	.word 0x00004000	; 037FC414
pool_037FC418:
	.word 0x00008000	; 037FC418
P2_Entry_037FC41C:
	push {r4,r5,lr}	; 037FC41C
	sub sp,#0x4	; 037FC41E
	ldr r0,[pool_037FC518]	; 037FC420
	ldr r2,[r0,#0x0]	; 037FC422
	ldr r1,[pool_037FC51C]	; 037FC424
	add r3,r2,r1	; 037FC426
	ldr r4,[pool_037FC520]	; 037FC428
	add r2,r2,r4	; 037FC42A
	mov r5,#0x4	; 037FC42C
	ldr r1,[pool_037FC524]	; 037FC42E
	strh r5,[r1,#0x0]	; 037FC430
	ldr r1,[pool_037FC528]	; 037FC432
	ldrh r1,[r1,#0x0]	; 037FC434
	ldr r5,[r0,#0x0]	; 037FC436
	ldr r0,[pool_037FC52C]	; 037FC438
	ldrh r5,[r5,r0]	; 037FC43A
	mov r0,#0x8	; 037FC43C
	and r5,r0	; 037FC43E
	cmp r5,#0x0	; 037FC440
	beq P2_Entry_037FC4BC	; 037FC442
	add r0,r1,#0x0	; 037FC444
	and r0,r4	; 037FC446
	cmp r0,#0x0	; 037FC448
	beq P2_Entry_037FC4BC	; 037FC44A
	ldr r0,[pool_037FC530]	; 037FC44C
	ldrh r0,[r0,#0x0]	; 037FC44E
	mov r4,#0x1	; 037FC450
	add r5,r0,#0x0	; 037FC452
	and r5,r4	; 037FC454
	cmp r5,#0x0	; 037FC456
	beq P2_Entry_037FC460	; 037FC458
	ldrh r4,[r2,#0x0]	; 037FC45A
	cmp r4,#0x0	; 037FC45C
	bne P2_Entry_037FC498	; 037FC45E
P2_Entry_037FC460:
	mov r4,#0x4	; 037FC460
	add r5,r0,#0x0	; 037FC462
	and r5,r4	; 037FC464
	cmp r5,#0x0	; 037FC466
	beq P2_Entry_037FC470	; 037FC468
	ldrh r4,[r2,#0x14]	; 037FC46A
	cmp r4,#0x0	; 037FC46C
	bne P2_Entry_037FC498	; 037FC46E
P2_Entry_037FC470:
	mov r4,#0x8	; 037FC470
	and r0,r4	; 037FC472
	cmp r0,#0x0	; 037FC474
	beq P2_Entry_037FC47E	; 037FC476
	ldrh r0,[r2,#0x28]	; 037FC478
	cmp r0,#0x0	; 037FC47A
	bne P2_Entry_037FC498	; 037FC47C
P2_Entry_037FC47E:
	ldr r0,[pool_037FC534]	; 037FC47E
	ldrh r2,[r0,#0x0]	; 037FC480
	mov r0,#0x1	; 037FC482
	and r2,r0	; 037FC484
	cmp r2,#0x0	; 037FC486
	bne P2_Entry_037FC498	; 037FC488
	mov r4,#0x0	; 037FC48A
	ldr r2,[pool_037FC538]	; 037FC48C
	strh r4,[r2,#0x0]	; 037FC48E
	ldr r0,[pool_037FC53C]	; 037FC490
	strh r0,[r2,#0x0]	; 037FC492
	strh r4,[r3,#0x2]	; 037FC494
	b P2_Entry_037FC4BC	; 037FC496
P2_Entry_037FC498:
	ldrh r2,[r3,#0x2]	; 037FC498
	add r0,r2,#0x1	; 037FC49A
	strh r0,[r3,#0x2]	; 037FC49C
	cmp r2,#0xc	; 037FC49E
	bls P2_Entry_037FC4BC	; 037FC4A0
	mov r0,#0x0	; 037FC4A2
	strh r0,[r3,#0x2]	; 037FC4A4
	ldr r2,[pool_037FC538]	; 037FC4A6
	strh r0,[r2,#0x0]	; 037FC4A8
	ldr r0,[pool_037FC53C]	; 037FC4AA
	strh r0,[r2,#0x0]	; 037FC4AC
	ldr r0,[pool_037FC518]	; 037FC4AE
	ldr r2,[r0,#0x0]	; 037FC4B0
	ldr r0,[pool_037FC540]	; 037FC4B2
	add r0,r2,r0	; 037FC4B4
	ldrh r2,[r0,#0x0]	; 037FC4B6
	add r2,r2,#0x1	; 037FC4B8
	strh r2,[r0,#0x0]	; 037FC4BA
P2_Entry_037FC4BC:
	ldr r0,[pool_037FC518]	; 037FC4BC
	ldr r2,[r0,#0x0]	; 037FC4BE
	ldr r0,[pool_037FC52C]	; 037FC4C0
	ldrh r2,[r2,r0]	; 037FC4C2
	mov r0,#0x1	; 037FC4C4
	and r2,r0	; 037FC4C6
	cmp r2,#0x0	; 037FC4C8
	beq P2_Entry_037FC50E	; 037FC4CA
	mov r0,#0x60	; 037FC4CC
	and r1,r0	; 037FC4CE
	cmp r1,#0x0	; 037FC4D0
	beq P2_Entry_037FC50E	; 037FC4D2
	ldr r0,[pool_037FC544]	; 037FC4D4
	ldrh r4,[r0,#0x0]	; 037FC4D6
	ldr r0,[pool_037FC548]	; 037FC4D8
	ldrh r1,[r0,#0x0]	; 037FC4DA
	ldr r0,[pool_037FC54C]	; 037FC4DC
	sub r0,r1,r0	; 037FC4DE
	mov r1,#0x2	; 037FC4E0
	bl P2_Entry_037FC564	; 037FC4E2
	cmp r4,r0	; 037FC4E6
	bge P2_Entry_037FC4FC	; 037FC4E8
	ldr r0,[pool_037FC550]	; 037FC4EA
	ldrh r1,[r0,#0x0]	; 037FC4EC
	ldr r0,[pool_037FC54C]	; 037FC4EE
	sub r0,r1,r0	; 037FC4F0
	mov r1,#0x2	; 037FC4F2
	bl P2_Entry_037FC570	; 037FC4F4
	cmp r4,r0	; 037FC4F8
	bge P2_Entry_037FC50A	; 037FC4FA
P2_Entry_037FC4FC:
	ldr r0,[pool_037FC554]	; 037FC4FC
	ldrh r1,[r0,#0x0]	; 037FC4FE
	ldr r0,[pool_037FC558]	; 037FC500
	strh r1,[r0,#0x0]	; 037FC502
	ldr r1,[pool_037FC55C]	; 037FC504
	ldr r0,[pool_037FC560]	; 037FC506
	strh r1,[r0,#0x0]	; 037FC508
P2_Entry_037FC50A:
	bl P2_Entry_037FC57C	; 037FC50A
P2_Entry_037FC50E:
	add sp,#0x4	; 037FC50E
	pop {r4,r5}	; 037FC510
	pop {r3}	; 037FC512
	bx r3	; 037FC514
	.byte 0xC0, 0x46	; 037FC516
pool_037FC518:
	.word FirmwareWlWorkPointerSlot	; 037FC518
pool_037FC51C:
	.word 0x000004B4	; 037FC51C
pool_037FC520:
	.word 0x00000400	; 037FC520
pool_037FC524:
	.word REG_WIFI_IF	; 037FC524
pool_037FC528:
	.word REG_WIFI_RXSTAT_INC_IF	; 037FC528
pool_037FC52C:
	.word 0x00000638	; 037FC52C
pool_037FC530:
	.word REG_WIFI_TXREQ_READ	; 037FC530
pool_037FC534:
	.word REG_WIFI_RF_PINS	; 037FC534
pool_037FC538:
	.word REG_WIFI_WEP_CNT	; 037FC538
pool_037FC53C:
	.word 0x00008000	; 037FC53C
pool_037FC540:
	.word 0x000003D2	; 037FC540
pool_037FC544:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC544
pool_037FC548:
	.word REG_WIFI_RXBUF_END	; 037FC548
pool_037FC54C:
	.word 0x00004000	; 037FC54C
pool_037FC550:
	.word REG_WIFI_RXBUF_BEGIN	; 037FC550
pool_037FC554:
	.word REG_WIFI_RXBUF_READCSR	; 037FC554
pool_037FC558:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FC558
pool_037FC55C:
	.word 0x00008001	; 037FC55C
pool_037FC560:
	.word REG_WIFI_RXCNT	; 037FC560
P2_Entry_037FC564:
	bx pc	; 037FC564
	.byte 0xC0, 0x46	; 037FC566
.arm
	ldr pc,[pool_037FC56C]	; 037FC568
pool_037FC56C:
	.word P2_SignedDivMod	; 037FC56C
P2_Entry_037FC570:
.thumb
	bx pc	; 037FC570
	.byte 0xC0, 0x46	; 037FC572
.arm
	ldr pc,[pool_037FC578]	; 037FC574
pool_037FC578:
	.word P2_SignedDivMod	; 037FC578
P2_Entry_037FC57C:
.thumb
	bx pc	; 037FC57C
	.byte 0xC0, 0x46	; 037FC57E
.arm
	ldr r12,[pool_037FC588]	; 037FC580
	bx r12	; 037FC584
pool_037FC588:
	.word P4_Entry_02304F50 + 1	; 037FC588
P2_Entry_037FC58C:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC58C
	sub sp,#0x4	; 037FC58E
	ldr r2,[pool_037FC704]	; 037FC590
	ldr r1,[r2,#0x0]	; 037FC592
	ldr r0,[pool_037FC708]	; 037FC594
	add r5,r1,r0	; 037FC596
	mov r1,#0x2	; 037FC598
	ldr r0,[pool_037FC70C]	; 037FC59A
	strh r1,[r0,#0x0]	; 037FC59C
	ldr r0,[r2,#0x0]	; 037FC59E
	ldr r2,[pool_037FC710]	; 037FC5A0
	ldrh r2,[r0,r2]	; 037FC5A2
	cmp r2,#0x12	; 037FC5A4
	bne P2_Entry_037FC5AE	; 037FC5A6
	bl P2_Entry_037FC754	; 037FC5A8
	b P2_Entry_037FC6FA	; 037FC5AC
P2_Entry_037FC5AE:
	ldr r2,[pool_037FC714]	; 037FC5AE
	ldrh r4,[r2,#0x0]	; 037FC5B0
	ldr r2,[pool_037FC718]	; 037FC5B2
	and r4,r2	; 037FC5B4
	ldr r2,[pool_037FC71C]	; 037FC5B6
	cmp r4,r2	; 037FC5B8
	beq P2_Entry_037FC5CA	; 037FC5BA
	ldr r2,[pool_037FC720]	; 037FC5BC
	cmp r4,r2	; 037FC5BE
	beq P2_Entry_037FC5F2	; 037FC5C0
	ldr r1,[pool_037FC724]	; 037FC5C2
	cmp r4,r1	; 037FC5C4
	beq P2_Entry_037FC628	; 037FC5C6
	b P2_Entry_037FC69E	; 037FC5C8
P2_Entry_037FC5CA:
	add r0,r5,#0x0	; 037FC5CA
	add r0,#0x8c	; 037FC5CC
	ldr r0,[r0,#0x0]	; 037FC5CE
	and r0,r1	; 037FC5D0
	cmp r0,#0x0	; 037FC5D2
	beq P2_Entry_037FC5DA	; 037FC5D4
	bl P2_Entry_037FCC7C	; 037FC5D6
P2_Entry_037FC5DA:
	ldr r0,[pool_037FC704]	; 037FC5DA
	ldr r1,[r0,#0x0]	; 037FC5DC
	ldr r0,[pool_037FC728]	; 037FC5DE
	add r0,r1,r0	; 037FC5E0
	ldr r1,[r0,#0x0]	; 037FC5E2
	add r1,r1,#0x1	; 037FC5E4
	str r1,[r0,#0x0]	; 037FC5E6
	mov r0,#0x0	; 037FC5E8
	mov r1,#0x8	; 037FC5EA
	bl loc_037FB380	; 037FC5EC
	b P2_Entry_037FC69E	; 037FC5F0
P2_Entry_037FC5F2:
	add r0,r5,#0x0	; 037FC5F2
	add r0,#0x9e	; 037FC5F4
	ldrh r0,[r0,#0x0]	; 037FC5F6
	ldr r2,[r5,#0x44]	; 037FC5F8
	ldrh r3,[r2,#0x4]	; 037FC5FA
	mov r2,#0xff	; 037FC5FC
	and r3,r2	; 037FC5FE
	lsl r2,r3,#0x10	; 037FC600
	lsr r2,r2,#0x10	; 037FC602
	cmp r0,r2	; 037FC604
	bhi P2_Entry_037FC61A	; 037FC606
	ldr r0,[pool_037FC72C]	; 037FC608
	strh r1,[r0,#0x0]	; 037FC60A
	add r0,r5,#0x0	; 037FC60C
	add r0,#0xaa	; 037FC60E
	ldrh r0,[r0,#0x0]	; 037FC610
	add r1,r0,#0x1	; 037FC612
	add r0,r5,#0x0	; 037FC614
	add r0,#0xaa	; 037FC616
	strh r1,[r0,#0x0]	; 037FC618
P2_Entry_037FC61A:
	add r0,r5,#0x0	; 037FC61A
	add r0,#0x90	; 037FC61C
	ldr r1,[r0,#0x0]	; 037FC61E
	ldrh r0,[r1,#0x18]	; 037FC620
	add r0,r0,#0x1	; 037FC622
	strh r0,[r1,#0x18]	; 037FC624
	b P2_Entry_037FC69E	; 037FC626
P2_Entry_037FC628:
	add r1,r5,#0x0	; 037FC628
	add r1,#0x98	; 037FC62A
	ldrh r6,[r1,#0x0]	; 037FC62C
	ldr r1,[r5,#0x44]	; 037FC62E
	ldrh r3,[r1,#0x2]	; 037FC630
	add r1,r5,#0x0	; 037FC632
	add r1,#0x90	; 037FC634
	ldr r2,[r1,#0x0]	; 037FC636
	add r2,#0x1a	; 037FC638
	cmp r3,#0x1	; 037FC63A
	bls P2_Entry_037FC65E	; 037FC63C
	ldr r1,[pool_037FC730]	; 037FC63E
	ldrh r0,[r0,r1]	; 037FC640
	lsl r0,r0,#0x1b	; 037FC642
	lsr r0,r0,#0x1f	; 037FC644
	cmp r0,#0x0	; 037FC646
	beq P2_Entry_037FC65E	; 037FC648
	ldr r0,[pool_037FC734]	; 037FC64A
	ldrh r0,[r0,#0x0]	; 037FC64C
	mov r7,#0x1	; 037FC64E
	and r0,r7	; 037FC650
	cmp r0,#0x0	; 037FC652
	bne P2_Entry_037FC65E	; 037FC654
	ldr r1,[pool_037FC738]	; 037FC656
	ldrh r0,[r1,#0x0]	; 037FC658
	eor r0,r7	; 037FC65A
	strh r0,[r1,#0x0]	; 037FC65C
P2_Entry_037FC65E:
	ldr r0,[pool_037FC704]	; 037FC65E
	ldr r1,[r0,#0x0]	; 037FC660
	ldr r0,[pool_037FC73C]	; 037FC662
	ldrh r1,[r1,r0]	; 037FC664
	mov r0,#0x40	; 037FC666
	and r1,r0	; 037FC668
	cmp r1,#0x0	; 037FC66A
	beq P2_Entry_037FC69E	; 037FC66C
	mov r0,#0x1	; 037FC66E
	b P2_Entry_037FC69A	; 037FC670
P2_Entry_037FC672:
	lsl r1,r3,#0xf	; 037FC672
	lsr r3,r1,#0x10	; 037FC674
	add r1,r3,#0x0	; 037FC676
	and r1,r0	; 037FC678
	cmp r1,#0x0	; 037FC67A
	beq P2_Entry_037FC684	; 037FC67C
	ldrh r1,[r2,#0x6]	; 037FC67E
	add r1,r1,#0x1	; 037FC680
	strh r1,[r2,#0x6]	; 037FC682
P2_Entry_037FC684:
	lsl r1,r6,#0xf	; 037FC684
	lsr r6,r1,#0x10	; 037FC686
	add r1,r6,#0x0	; 037FC688
	and r1,r0	; 037FC68A
	cmp r1,#0x0	; 037FC68C
	beq P2_Entry_037FC69A	; 037FC68E
	add r1,r5,#0x0	; 037FC690
	add r1,#0x90	; 037FC692
	ldr r1,[r1,#0x0]	; 037FC694
	ldrh r1,[r1,#0x16]	; 037FC696
	add r2,r2,r1	; 037FC698
P2_Entry_037FC69A:
	cmp r3,#0x1	; 037FC69A
	bhi P2_Entry_037FC672	; 037FC69C
P2_Entry_037FC69E:
	ldr r0,[pool_037FC720]	; 037FC69E
	cmp r4,r0	; 037FC6A0
	beq P2_Entry_037FC6F2	; 037FC6A2
	ldr r0,[pool_037FC740]	; 037FC6A4
	ldrh r1,[r0,#0x0]	; 037FC6A6
	mov r0,#0x2	; 037FC6A8
	and r1,r0	; 037FC6AA
	cmp r1,#0x0	; 037FC6AC
	bne P2_Entry_037FC6F2	; 037FC6AE
	ldrh r1,[r5,#0x3c]	; 037FC6B0
	cmp r1,#0x0	; 037FC6B2
	beq P2_Entry_037FC6EC	; 037FC6B4
	ldr r1,[pool_037FC744]	; 037FC6B6
	strh r0,[r1,#0x0]	; 037FC6B8
	mov r2,#0x0	; 037FC6BA
	ldr r1,[pool_037FC748]	; 037FC6BC
	strh r2,[r1,#0x0]	; 037FC6BE
	ldr r1,[pool_037FC70C]	; 037FC6C0
	ldrh r2,[r1,#0x0]	; 037FC6C2
	ldr r1,[pool_037FC74C]	; 037FC6C4
	and r2,r1	; 037FC6C6
	cmp r2,#0x0	; 037FC6C8
	bne P2_Entry_037FC6D2	; 037FC6CA
	bl P2_Entry_037FC958	; 037FC6CC
	b P2_Entry_037FC6E0	; 037FC6D0
P2_Entry_037FC6D2:
	add r0,r5,#0x0	; 037FC6D2
	add r0,#0xae	; 037FC6D4
	ldrh r0,[r0,#0x0]	; 037FC6D6
	add r1,r0,#0x1	; 037FC6D8
	add r0,r5,#0x0	; 037FC6DA
	add r0,#0xae	; 037FC6DC
	strh r1,[r0,#0x0]	; 037FC6DE
P2_Entry_037FC6E0:
	add r0,r5,#0x0	; 037FC6E0
	add r0,#0xac	; 037FC6E2
	ldrh r0,[r0,#0x0]	; 037FC6E4
	add r0,r0,#0x1	; 037FC6E6
	add r5,#0xac	; 037FC6E8
	strh r0,[r5,#0x0]	; 037FC6EA
P2_Entry_037FC6EC:
	mov r1,#0x2	; 037FC6EC
	ldr r0,[pool_037FC750]	; 037FC6EE
	strh r1,[r0,#0x0]	; 037FC6F0
P2_Entry_037FC6F2:
	mov r0,#0x0	; 037FC6F2
	mov r1,#0xe	; 037FC6F4
	bl loc_037FB380	; 037FC6F6
P2_Entry_037FC6FA:
	add sp,#0x4	; 037FC6FA
	pop {r4,r5,r6,r7}	; 037FC6FC
	pop {r3}	; 037FC6FE
	bx r3	; 037FC700
	.byte 0xC0, 0x46	; 037FC702
pool_037FC704:
	.word FirmwareWlWorkPointerSlot	; 037FC704
pool_037FC708:
	.word 0x00000400	; 037FC708
pool_037FC70C:
	.word REG_WIFI_IF	; 037FC70C
pool_037FC710:
	.word 0x00000320	; 037FC710
pool_037FC714:
	.word REG_WIFI_TXSTAT	; 037FC714
pool_037FC718:
	.word 0x00000F00	; 037FC718
pool_037FC71C:
	.word 0x00000300	; 037FC71C
pool_037FC720:
	.word 0x00000800	; 037FC720
pool_037FC724:
	.word 0x00000B00	; 037FC724
pool_037FC728:
	.word 0x0000052C	; 037FC728
pool_037FC72C:
	.word REG_WIFI_TXREQ_RESET	; 037FC72C
pool_037FC730:
	.word 0x0000030E	; 037FC730
pool_037FC734:
	.word REG_WIFI_RF_PINS	; 037FC734
pool_037FC738:
	.word REG_WIFI_UNKNOWN_290	; 037FC738
pool_037FC73C:
	.word 0x00000638	; 037FC73C
pool_037FC740:
	.word REG_WIFI_TXREQ_READ	; 037FC740
pool_037FC744:
	.word REG_WIFI_TXBUF_RESET	; 037FC744
pool_037FC748:
	.word REG_WIFI_UNKNOWN_048	; 037FC748
pool_037FC74C:
	.word 0x00001000	; 037FC74C
pool_037FC750:
	.word REG_WIFI_TXREQ_SET	; 037FC750
P2_Entry_037FC754:
	bx pc	; 037FC754
	.byte 0xC0, 0x46	; 037FC756
.arm
	ldr r12,[pool_037FC760]	; 037FC758
	bx r12	; 037FC75C
pool_037FC760:
	.word P4_Entry_02308C44 + 1	; 037FC760
P2_Entry_037FC764:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC764
	sub sp,#0x1c	; 037FC766
	ldr r0,[pool_037FC900]	; 037FC768
	ldr r1,[r0,#0x0]	; 037FC76A
	ldr r0,[pool_037FC904]	; 037FC76C
	add r5,r1,r0	; 037FC76E
	ldr r0,[pool_037FC908]	; 037FC770
	add r0,r1,r0	; 037FC772
	str r0,[sp,#0x0]	; 037FC774
	ldr r0,[pool_037FC90C]	; 037FC776
	ldrh r6,[r1,r0]	; 037FC778
	mov r1,#0x1	; 037FC77A
	ldr r0,[pool_037FC910]	; 037FC77C
	strh r1,[r0,#0x0]	; 037FC77E
	and r6,r1	; 037FC780
P2_Entry_037FC782:
	ldr r0,[sp,#0x0]	; 037FC782
	ldrh r0,[r0,#0x4]	; 037FC784
	str r0,[sp,#0x8]	; 037FC786
	ldr r0,[pool_037FC914]	; 037FC788
	ldrh r0,[r0,#0x0]	; 037FC78A
	str r0,[sp,#0xc]	; 037FC78C
	ldr r1,[sp,#0x8]	; 037FC78E
	cmp r1,r0	; 037FC790
	bne P2_Entry_037FC796	; 037FC792
	b P2_Entry_037FC8C6	; 037FC794
P2_Entry_037FC796:
	ldr r0,[pool_037FC918]	; 037FC796
	ldrh r1,[r0,#0x0]	; 037FC798
	ldr r0,[pool_037FC91C]	; 037FC79A
	ldrh r0,[r0,#0x0]	; 037FC79C
	ldr r2,[pool_037FC918]	; 037FC79E
	ldrh r3,[r2,#0x0]	; 037FC7A0
	ldr r2,[pool_037FC91C]	; 037FC7A2
	ldrh r2,[r2,#0x0]	; 037FC7A4
	cmp r1,r3	; 037FC7A6
	bls P2_Entry_037FC7B2	; 037FC7A8
	lsr r4,r3,#0x4	; 037FC7AA
	lsl r0,r2,#0xc	; 037FC7AC
	orr r4,r0	; 037FC7AE
	b P2_Entry_037FC7B8	; 037FC7B0
P2_Entry_037FC7B2:
	lsr r4,r1,#0x4	; 037FC7B2
	lsl r0,r0,#0xc	; 037FC7B4
	orr r4,r0	; 037FC7B6
P2_Entry_037FC7B8:
	ldr r0,[sp,#0x8]	; 037FC7B8
	lsl r7,r0,#0x1	; 037FC7BA
	ldr r0,[pool_037FC920]	; 037FC7BC
	add r0,r7,r0	; 037FC7BE
	str r0,[sp,#0x4]	; 037FC7C0
	add r0,r0,#0x2	; 037FC7C2
	bl P2_Entry_037FCD38	; 037FC7C4
	str r0,[sp,#0x10]	; 037FC7C8
	add r0,r0,#0x2	; 037FC7CA
	bl P2_Entry_037FCD38	; 037FC7CC
	str r0,[sp,#0x14]	; 037FC7D0
	add r0,r0,#0x4	; 037FC7D2
	bl P2_Entry_037FCD38	; 037FC7D4
	add r2,r0,#0x0	; 037FC7D8
	ldr r0,[pool_037FC920]	; 037FC7DA
	ldrh r1,[r7,r0]	; 037FC7DC
	ldr r0,[sp,#0x10]	; 037FC7DE
	ldrh r0,[r0,#0x0]	; 037FC7E0
	lsl r3,r0,#0x1	; 037FC7E2
	ldr r0,[pool_037FC924]	; 037FC7E4
	and r3,r0	; 037FC7E6
	orr r1,r3	; 037FC7E8
	ldr r0,[pool_037FC920]	; 037FC7EA
	strh r1,[r7,r0]	; 037FC7EC
	ldr r0,[sp,#0x14]	; 037FC7EE
	strh r4,[r0,#0x0]	; 037FC7F0
	ldrh r2,[r2,#0x0]	; 037FC7F2
	ldr r0,[sp,#0x8]	; 037FC7F4
	lsl r0,r0,#0x1	; 037FC7F6
	add r0,r2,r0	; 037FC7F8
	add r0,#0xf	; 037FC7FA
	lsr r0,r0,#0x2	; 037FC7FC
	lsl r4,r0,#0x1	; 037FC7FE
	ldr r0,[pool_037FC928]	; 037FC800
	cmp r4,r0	; 037FC802
	bcc P2_Entry_037FC810	; 037FC804
	add r0,r5,#0x0	; 037FC806
	add r0,#0x9a	; 037FC808
	ldrh r0,[r0,#0x0]	; 037FC80A
	lsr r0,r0,#0x1	; 037FC80C
	sub r4,r4,r0	; 037FC80E
P2_Entry_037FC810:
	ldr r0,[pool_037FC92C]	; 037FC810
	cmp r2,r0	; 037FC812
	bls P2_Entry_037FC82E	; 037FC814
	ldr r1,[pool_037FC930]	; 037FC816
	ldr r0,[sp,#0x4]	; 037FC818
	strh r1,[r0,#0x0]	; 037FC81A
	ldr r4,[sp,#0xc]	; 037FC81C
	add r0,r5,#0x0	; 037FC81E
	add r0,#0xb4	; 037FC820
	ldrh r0,[r0,#0x0]	; 037FC822
	add r1,r0,#0x1	; 037FC824
	add r0,r5,#0x0	; 037FC826
	add r0,#0xb4	; 037FC828
	strh r1,[r0,#0x0]	; 037FC82A
	b P2_Entry_037FC896	; 037FC82C
P2_Entry_037FC82E:
	cmp r6,#0x0	; 037FC82E
	beq P2_Entry_037FC896	; 037FC830
	ldr r0,[sp,#0xc]	; 037FC832
	cmp r4,r0	; 037FC834
	beq P2_Entry_037FC896	; 037FC836
	lsl r0,r4,#0x1	; 037FC838
	ldr r1,[pool_037FC920]	; 037FC83A
	add r1,r0,r1	; 037FC83C
	ldr r3,[pool_037FC920]	; 037FC83E
	ldrh r0,[r0,r3]	; 037FC840
	ldr r3,[pool_037FC934]	; 037FC842
	cmp r1,r3	; 037FC844
	bcs P2_Entry_037FC854	; 037FC846
	ldrh r3,[r1,#0x6]	; 037FC848
	mov r1,#0xff	; 037FC84A
	and r3,r1	; 037FC84C
	lsl r1,r3,#0x10	; 037FC84E
	lsr r3,r1,#0x10	; 037FC850
	b P2_Entry_037FC85E	; 037FC852
P2_Entry_037FC854:
	add r3,r5,#0x0	; 037FC854
	add r3,#0x9a	; 037FC856
	ldrh r3,[r3,#0x0]	; 037FC858
	sub r1,r1,r3	; 037FC85A
	ldrh r3,[r1,#0x6]	; 037FC85C
P2_Entry_037FC85E:
	ldr r1,[pool_037FC938]	; 037FC85E
	and r0,r1	; 037FC860
	cmp r0,#0x0	; 037FC862
	bne P2_Entry_037FC874	; 037FC864
	cmp r3,#0xa	; 037FC866
	beq P2_Entry_037FC86E	; 037FC868
	cmp r3,#0x14	; 037FC86A
	bne P2_Entry_037FC874	; 037FC86C
P2_Entry_037FC86E:
	ldr r0,[pool_037FC93C]	; 037FC86E
	cmp r2,r0	; 037FC870
	bls P2_Entry_037FC896	; 037FC872
P2_Entry_037FC874:
	add r0,r5,#0x0	; 037FC874
	add r0,#0xb4	; 037FC876
	ldrh r0,[r0,#0x0]	; 037FC878
	add r0,r0,#0x1	; 037FC87A
	add r5,#0xb4	; 037FC87C
	strh r0,[r5,#0x0]	; 037FC87E
	ldr r1,[pool_037FC930]	; 037FC880
	ldr r0,[sp,#0x4]	; 037FC882
	strh r1,[r0,#0x0]	; 037FC884
	ldr r0,[sp,#0xc]	; 037FC886
	lsl r0,r0,#0x10	; 037FC888
	lsr r1,r0,#0x10	; 037FC88A
	ldr r0,[sp,#0x0]	; 037FC88C
	strh r1,[r0,#0x4]	; 037FC88E
	ldr r0,[sp,#0x10]	; 037FC890
	strh r1,[r0,#0x0]	; 037FC892
	b P2_Entry_037FC8C6	; 037FC894
P2_Entry_037FC896:
	ldr r0,[sp,#0x4]	; 037FC896
	ldrh r1,[r0,#0x0]	; 037FC898
	mov r0,#0xf	; 037FC89A
	and r1,r0	; 037FC89C
	cmp r1,#0xc	; 037FC89E
	bne P2_Entry_037FC8B8	; 037FC8A0
	bl P2_Entry_037FCD58	; 037FC8A2
	cmp r0,#0x0	; 037FC8A6
	bne P2_Entry_037FC8B8	; 037FC8A8
	ldr r0,[pool_037FC900]	; 037FC8AA
	ldr r0,[r0,#0x0]	; 037FC8AC
	ldr r1,[pool_037FC940]	; 037FC8AE
	ldr r1,[r0,r1]	; 037FC8B0
	add r2,r1,#0x1	; 037FC8B2
	ldr r1,[pool_037FC940]	; 037FC8B4
	str r2,[r0,r1]	; 037FC8B6
P2_Entry_037FC8B8:
	lsl r0,r4,#0x10	; 037FC8B8
	lsr r1,r0,#0x10	; 037FC8BA
	ldr r0,[sp,#0x0]	; 037FC8BC
	strh r1,[r0,#0x4]	; 037FC8BE
	ldr r0,[sp,#0x10]	; 037FC8C0
	strh r1,[r0,#0x0]	; 037FC8C2
	b P2_Entry_037FC782	; 037FC8C4
P2_Entry_037FC8C6:
	cmp r6,#0x0	; 037FC8C6
	beq P2_Entry_037FC8E4	; 037FC8C8
	ldr r0,[pool_037FC914]	; 037FC8CA
	ldrh r4,[r0,#0x0]	; 037FC8CC
	bl P2_Entry_037FCD58	; 037FC8CE
	cmp r0,#0x0	; 037FC8D2
	beq P2_Entry_037FC8E4	; 037FC8D4
	ldr r0,[pool_037FC914]	; 037FC8D6
	ldrh r0,[r0,#0x0]	; 037FC8D8
	cmp r4,r0	; 037FC8DA
	bne P2_Entry_037FC8E4	; 037FC8DC
	mov r0,#0x20	; 037FC8DE
	bl P2_Entry_037FC948	; 037FC8E0
P2_Entry_037FC8E4:
	ldr r0,[pool_037FC944]	; 037FC8E4
	ldrh r1,[r0,#0x0]	; 037FC8E6
	ldr r0,[pool_037FC914]	; 037FC8E8
	ldrh r0,[r0,#0x0]	; 037FC8EA
	cmp r1,r0	; 037FC8EC
	beq P2_Entry_037FC8F8	; 037FC8EE
	mov r0,#0x0	; 037FC8F0
	mov r1,#0xf	; 037FC8F2
	bl loc_037FB380	; 037FC8F4
P2_Entry_037FC8F8:
	add sp,#0x1c	; 037FC8F8
	pop {r4,r5,r6,r7}	; 037FC8FA
	pop {r3}	; 037FC8FC
	bx r3	; 037FC8FE
pool_037FC900:
	.word FirmwareWlWorkPointerSlot	; 037FC900
pool_037FC904:
	.word 0x00000318	; 037FC904
pool_037FC908:
	.word 0x000004B4	; 037FC908
pool_037FC90C:
	.word 0x00000638	; 037FC90C
pool_037FC910:
	.word REG_WIFI_IF	; 037FC910
pool_037FC914:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC914
pool_037FC918:
	.word REG_WIFI_US_COUNT0	; 037FC918
pool_037FC91C:
	.word REG_WIFI_US_COUNT1	; 037FC91C
pool_037FC920:
	.word 0x04804000	; 037FC920
pool_037FC924:
	.word 0x00000400	; 037FC924
pool_037FC928:
	.word 0x00000FB0	; 037FC928
pool_037FC92C:
	.word 0x0000092C	; 037FC92C
pool_037FC930:
	.word 0x0000FFFF	; 037FC930
pool_037FC934:
	.word 0x04805F5A	; 037FC934
pool_037FC938:
	.word 0x00007C00	; 037FC938
pool_037FC93C:
	.word 0x00000FFF	; 037FC93C
pool_037FC940:
	.word 0x0000057C	; 037FC940
pool_037FC944:
	.word REG_WIFI_RXBUF_READCSR	; 037FC944
.arm
P2_Entry_037FC948:
.thumb
	bx pc	; 037FC948
	.byte 0xC0, 0x46	; 037FC94A
.arm
	ldr r12,[pool_037FC954]	; 037FC94C
	bx r12	; 037FC950
pool_037FC954:
	.word loc_02304F18 + 1	; 037FC954
P2_Entry_037FC958:
.thumb
	push {r4,lr}	; 037FC958
	ldr r1,[pool_037FC9E4]	; 037FC95A
	ldr r3,[r1,#0x0]	; 037FC95C
	ldr r2,[pool_037FC9E8]	; 037FC95E
	add r2,r3,r2	; 037FC960
	ldr r4,[pool_037FC9EC]	; 037FC962
	ldr r3,[pool_037FC9F0]	; 037FC964
	strh r4,[r3,#0x0]	; 037FC966
	ldrh r3,[r2,#0x3c]	; 037FC968
	cmp r3,#0x0	; 037FC96A
	beq P2_Entry_037FC9DC	; 037FC96C
	ldr r3,[r1,#0x0]	; 037FC96E
	ldr r1,[pool_037FC9F4]	; 037FC970
	ldrh r3,[r3,r1]	; 037FC972
	mov r1,#0x10	; 037FC974
	and r3,r1	; 037FC976
	cmp r3,#0x0	; 037FC978
	beq P2_Entry_037FC9D4	; 037FC97A
	cmp r0,#0x0	; 037FC97C
	beq P2_Entry_037FC9D4	; 037FC97E
	ldr r0,[pool_037FC9F8]	; 037FC980
	ldrh r1,[r0,#0x0]	; 037FC982
	ldr r0,[pool_037FC9FC]	; 037FC984
	ldrh r0,[r0,#0x0]	; 037FC986
	cmp r0,#0x3	; 037FC988
	beq P2_Entry_037FC990	; 037FC98A
	cmp r0,#0x5	; 037FC98C
	bne P2_Entry_037FC9D4	; 037FC98E
P2_Entry_037FC990:
	cmp r1,#0x0	; 037FC990
	bne P2_Entry_037FC9D4	; 037FC992
	ldr r3,[r2,#0x44]	; 037FC994
	ldrh r4,[r3,#0x2]	; 037FC996
	mov r0,#0x0	; 037FC998
	mov r1,#0x1	; 037FC99A
	b P2_Entry_037FC9A8	; 037FC99C
P2_Entry_037FC99E:
	add r2,r4,#0x0	; 037FC99E
	and r2,r1	; 037FC9A0
	add r0,r0,r2	; 037FC9A2
	lsl r2,r4,#0xf	; 037FC9A4
	lsr r4,r2,#0x10	; 037FC9A6
P2_Entry_037FC9A8:
	cmp r4,#0x0	; 037FC9A8
	bne P2_Entry_037FC99E	; 037FC9AA
	ldrh r1,[r3,#0xa]	; 037FC9AC
	lsl r2,r1,#0x2	; 037FC9AE
	ldrh r1,[r3,#0x24]	; 037FC9B0
	add r1,#0xa	; 037FC9B2
	mul r0,r1	; 037FC9B4
	add r0,#0xc0	; 037FC9B6
	add r0,r2,r0	; 037FC9B8
	lsl r0,r0,#0x10	; 037FC9BA
	lsr r0,r0,#0x10	; 037FC9BC
	ldr r1,[pool_037FCA00]	; 037FC9BE
	bl P2_Entry_037FCA08	; 037FC9C0
	ldr r0,[pool_037FC9E4]	; 037FC9C4
	ldr r1,[r0,#0x0]	; 037FC9C6
	ldr r0,[pool_037FCA04]	; 037FC9C8
	add r0,r1,r0	; 037FC9CA
	ldrh r1,[r0,#0x0]	; 037FC9CC
	add r1,r1,#0x1	; 037FC9CE
	strh r1,[r0,#0x0]	; 037FC9D0
	b P2_Entry_037FC9DC	; 037FC9D2
P2_Entry_037FC9D4:
	mov r0,#0x0	; 037FC9D4
	mov r1,#0x10	; 037FC9D6
	bl loc_037FB380	; 037FC9D8
P2_Entry_037FC9DC:
	pop {r4}	; 037FC9DC
	pop {r3}	; 037FC9DE
	bx r3	; 037FC9E0
	.byte 0xC0, 0x46	; 037FC9E2
pool_037FC9E4:
	.word FirmwareWlWorkPointerSlot	; 037FC9E4
pool_037FC9E8:
	.word 0x00000400	; 037FC9E8
pool_037FC9EC:
	.word 0x00001000	; 037FC9EC
pool_037FC9F0:
	.word REG_WIFI_IF	; 037FC9F0
pool_037FC9F4:
	.word 0x00000638	; 037FC9F4
pool_037FC9F8:
	.word REG_WIFI_TXBUSY	; 037FC9F8
pool_037FC9FC:
	.word REG_WIFI_RF_STATUS	; 037FC9FC
pool_037FCA00:
	.word 0x037FCCED	; 037FCA00
pool_037FCA04:
	.word 0x000003D4	; 037FCA04
P2_Entry_037FCA08:
	bx pc	; 037FCA08
	.byte 0xC0, 0x46	; 037FCA0A
.arm
	ldr r12,[pool_037FCA14]	; 037FCA0C
	bx r12	; 037FCA10
pool_037FCA14:
	.word P4_Entry_02305370 + 1	; 037FCA14
P2_Entry_037FCA18:
.thumb
	push {r4,lr}	; 037FCA18
	ldr r3,[pool_037FCA78]	; 037FCA1A
	ldr r1,[r3,#0x0]	; 037FCA1C
	ldr r0,[pool_037FCA7C]	; 037FCA1E
	add r1,r1,r0	; 037FCA20
	mov r0,#0x80	; 037FCA22
	ldr r2,[pool_037FCA80]	; 037FCA24
	strh r0,[r2,#0x0]	; 037FCA26
	ldr r3,[r3,#0x0]	; 037FCA28
	ldr r2,[pool_037FCA84]	; 037FCA2A
	ldrh r3,[r3,r2]	; 037FCA2C
	mov r2,#0x20	; 037FCA2E
	and r3,r2	; 037FCA30
	cmp r3,#0x0	; 037FCA32
	beq P2_Entry_037FCA72	; 037FCA34
	ldr r2,[pool_037FCA88]	; 037FCA36
	ldrh r3,[r2,#0x0]	; 037FCA38
	mov r2,#0xff	; 037FCA3A
	and r3,r2	; 037FCA3C
	lsl r2,r3,#0x10	; 037FCA3E
	lsr r3,r2,#0x10	; 037FCA40
	ldr r2,[pool_037FCA8C]	; 037FCA42
	ldrh r4,[r2,#0x0]	; 037FCA44
	cmp r3,#0x3	; 037FCA46
	bcc P2_Entry_037FCA72	; 037FCA48
	cmp r3,#0x5	; 037FCA4A
	bhi P2_Entry_037FCA72	; 037FCA4C
	ldr r2,[r1,#0x58]	; 037FCA4E
	lsr r3,r2,#0x1	; 037FCA50
	ldr r2,[pool_037FCA90]	; 037FCA52
	and r3,r2	; 037FCA54
	cmp r4,r3	; 037FCA56
	bcc P2_Entry_037FCA72	; 037FCA58
	ldr r1,[r1,#0x30]	; 037FCA5A
	lsr r1,r1,#0x1	; 037FCA5C
	and r1,r2	; 037FCA5E
	cmp r4,r1	; 037FCA60
	bhi P2_Entry_037FCA72	; 037FCA62
	ldr r2,[pool_037FCA94]	; 037FCA64
	ldrh r1,[r2,#0x0]	; 037FCA66
	orr r1,r0	; 037FCA68
	strh r1,[r2,#0x0]	; 037FCA6A
	ldrh r1,[r2,#0x0]	; 037FCA6C
	bic r1,r0	; 037FCA6E
	strh r1,[r2,#0x0]	; 037FCA70
P2_Entry_037FCA72:
	pop {r4}	; 037FCA72
	pop {r3}	; 037FCA74
	bx r3	; 037FCA76
pool_037FCA78:
	.word FirmwareWlWorkPointerSlot	; 037FCA78
pool_037FCA7C:
	.word 0x00000400	; 037FCA7C
pool_037FCA80:
	.word REG_WIFI_IF	; 037FCA80
pool_037FCA84:
	.word 0x00000638	; 037FCA84
pool_037FCA88:
	.word REG_WIFI_RF_STATUS	; 037FCA88
pool_037FCA8C:
	.word REG_WIFI_RXTX_ADDR	; 037FCA8C
pool_037FCA90:
	.word 0x00000FFF	; 037FCA90
pool_037FCA94:
	.word REG_WIFI_UNKNOWN_244	; 037FCA94
P2_Entry_037FCA98:
	push {r4,r5,r6,r7,lr}	; 037FCA98
	sub sp,#0x4	; 037FCA9A
	ldr r0,[pool_037FCC18]	; 037FCA9C
	ldr r2,[r0,#0x0]	; 037FCA9E
	ldr r1,[pool_037FCC1C]	; 037FCAA0
	add r5,r2,r1	; 037FCAA2
	ldr r1,[pool_037FCC20]	; 037FCAA4
	add r6,r2,r1	; 037FCAA6
	mov r2,#0x40	; 037FCAA8
	ldr r1,[pool_037FCC24]	; 037FCAAA
	strh r2,[r1,#0x0]	; 037FCAAC
	ldr r1,[r0,#0x0]	; 037FCAAE
	ldr r0,[pool_037FCC28]	; 037FCAB0
	ldrh r1,[r1,r0]	; 037FCAB2
	mov r0,#0x20	; 037FCAB4
	and r1,r0	; 037FCAB6
	cmp r1,#0x0	; 037FCAB8
	bne P2_Entry_037FCABE	; 037FCABA
	b P2_Entry_037FCC0E	; 037FCABC
P2_Entry_037FCABE:
	add r0,r6,#0x0	; 037FCABE
	add r0,#0xa6	; 037FCAC0
	ldrh r1,[r0,#0x0]	; 037FCAC2
	ldr r0,[pool_037FCC2C]	; 037FCAC4
	cmp r1,r0	; 037FCAC6
	beq P2_Entry_037FCACC	; 037FCAC8
	b P2_Entry_037FCC0E	; 037FCACA
P2_Entry_037FCACC:
	ldr r0,[pool_037FCC30]	; 037FCACC
	ldrh r1,[r0,#0x0]	; 037FCACE
	mov r0,#0x3	; 037FCAD0
	and r1,r0	; 037FCAD2
	cmp r1,#0x3	; 037FCAD4
	beq P2_Entry_037FCADA	; 037FCAD6
	b P2_Entry_037FCC0E	; 037FCAD8
P2_Entry_037FCADA:
	ldr r0,[pool_037FCC34]	; 037FCADA
	ldrh r2,[r0,#0x0]	; 037FCADC
	ldr r0,[pool_037FCC38]	; 037FCADE
	ldrh r0,[r0,#0x0]	; 037FCAE0
	lsr r1,r0,#0x1	; 037FCAE2
	ldr r0,[pool_037FCC3C]	; 037FCAE4
	and r1,r0	; 037FCAE6
	cmp r2,r1	; 037FCAE8
	bge P2_Entry_037FCAEE	; 037FCAEA
	b P2_Entry_037FCC0E	; 037FCAEC
P2_Entry_037FCAEE:
	ldr r0,[pool_037FCC40]	; 037FCAEE
	ldrh r0,[r0,#0x0]	; 037FCAF0
	str r0,[sp,#0x0]	; 037FCAF2
	lsl r1,r0,#0x1	; 037FCAF4
	ldr r0,[pool_037FCC44]	; 037FCAF6
	add r0,r1,r0	; 037FCAF8
	add r0,#0x8	; 037FCAFA
	bl P2_Entry_037FCD38	; 037FCAFC
	add r0,r0,#0x4	; 037FCB00
	bl P2_Entry_037FCD38	; 037FCB02
	ldrh r2,[r0,#0x0]	; 037FCB06
	ldr r1,[pool_037FCC48]	; 037FCB08
	and r2,r1	; 037FCB0A
	ldr r1,[pool_037FCC4C]	; 037FCB0C
	cmp r2,r1	; 037FCB0E
	bne P2_Entry_037FCC0E	; 037FCB10
	add r0,r0,#0x2	; 037FCB12
	bl P2_Entry_037FCD38	; 037FCB14
	add r1,r0,#0x0	; 037FCB18
	ldr r4,[pool_037FCC50]	; 037FCB1A
	ldrh r2,[r4,#0x0]	; 037FCB1C
	ldr r0,[pool_037FCC54]	; 037FCB1E
	sub r7,r2,r0	; 037FCB20
P2_Entry_037FCB22:
	ldr r0,[pool_037FCC34]	; 037FCB22
	ldrh r2,[r0,#0x0]	; 037FCB24
	ldr r0,[sp,#0x0]	; 037FCB26
	sub r0,r2,r0	; 037FCB28
	lsl r0,r0,#0x10	; 037FCB2A
	lsr r3,r0,#0x10	; 037FCB2C
	add r2,r3,#0x0	; 037FCB2E
	ldr r0,[pool_037FCC58]	; 037FCB30
	and r2,r0	; 037FCB32
	cmp r2,#0x0	; 037FCB34
	beq P2_Entry_037FCB46	; 037FCB36
	add r0,r5,#0x0	; 037FCB38
	add r0,#0x9a	; 037FCB3A
	ldrh r0,[r0,#0x0]	; 037FCB3C
	lsr r0,r0,#0x1	; 037FCB3E
	add r0,r3,r0	; 037FCB40
	lsl r0,r0,#0x10	; 037FCB42
	lsr r3,r0,#0x10	; 037FCB44
P2_Entry_037FCB46:
	cmp r3,#0xe	; 037FCB46
	bhi P2_Entry_037FCB58	; 037FCB48
	ldrh r0,[r4,#0x0]	; 037FCB4A
	sub r0,r0,r7	; 037FCB4C
	lsl r0,r0,#0x10	; 037FCB4E
	lsr r0,r0,#0x10	; 037FCB50
	cmp r0,#0x40	; 037FCB52
	bls P2_Entry_037FCB22	; 037FCB54
	b P2_Entry_037FCC0E	; 037FCB56
P2_Entry_037FCB58:
	add r1,#0x8	; 037FCB58
	mov r4,#0x0	; 037FCB5A
	b P2_Entry_037FCB76	; 037FCB5C
P2_Entry_037FCB5E:
	add r0,r1,#0x0	; 037FCB5E
	bl P2_Entry_037FCD38	; 037FCB60
	add r1,r0,#0x2	; 037FCB64
	ldrh r0,[r0,#0x0]	; 037FCB66
	lsl r2,r4,#0x1	; 037FCB68
	add r2,r5,r2	; 037FCB6A
	add r2,#0x64	; 037FCB6C
	ldrh r2,[r2,#0x0]	; 037FCB6E
	cmp r0,r2	; 037FCB70
	bne P2_Entry_037FCC0E	; 037FCB72
	add r4,r4,#0x1	; 037FCB74
P2_Entry_037FCB76:
	cmp r4,#0x3	; 037FCB76
	bcc P2_Entry_037FCB5E	; 037FCB78
	add r1,#0xa	; 037FCB7A
	add r0,r1,#0x0	; 037FCB7C
	bl P2_Entry_037FCD38	; 037FCB7E
	add r3,r0,#0x0	; 037FCB82
	ldr r4,[pool_037FCC34]	; 037FCB84
P2_Entry_037FCB86:
	ldrh r1,[r4,#0x0]	; 037FCB86
	ldr r0,[sp,#0x0]	; 037FCB88
	sub r0,r1,r0	; 037FCB8A
	lsl r0,r0,#0x10	; 037FCB8C
	lsr r2,r0,#0x10	; 037FCB8E
	add r1,r2,#0x0	; 037FCB90
	ldr r0,[pool_037FCC58]	; 037FCB92
	and r1,r0	; 037FCB94
	cmp r1,#0x0	; 037FCB96
	beq P2_Entry_037FCBA8	; 037FCB98
	add r0,r5,#0x0	; 037FCB9A
	add r0,#0x9a	; 037FCB9C
	ldrh r0,[r0,#0x0]	; 037FCB9E
	lsr r0,r0,#0x1	; 037FCBA0
	add r0,r2,r0	; 037FCBA2
	lsl r0,r0,#0x10	; 037FCBA4
	lsr r2,r0,#0x10	; 037FCBA6
P2_Entry_037FCBA8:
	cmp r2,#0x14	; 037FCBA8
	bhi P2_Entry_037FCBBC	; 037FCBAA
	ldr r0,[pool_037FCC50]	; 037FCBAC
	ldrh r0,[r0,#0x0]	; 037FCBAE
	sub r0,r0,r7	; 037FCBB0
	lsl r0,r0,#0x10	; 037FCBB2
	lsr r0,r0,#0x10	; 037FCBB4
	cmp r0,#0x70	; 037FCBB6
	bls P2_Entry_037FCB86	; 037FCBB8
	b P2_Entry_037FCC0E	; 037FCBBA
P2_Entry_037FCBBC:
	ldrh r1,[r3,#0x0]	; 037FCBBC
	add r0,r6,#0x0	; 037FCBBE
	add r0,#0xa2	; 037FCBC0
	ldrh r0,[r0,#0x0]	; 037FCBC2
	and r1,r0	; 037FCBC4
	cmp r1,#0x0	; 037FCBC6
	bne P2_Entry_037FCC0E	; 037FCBC8
	ldr r0,[pool_037FCC5C]	; 037FCBCA
	ldrh r0,[r0,#0x0]	; 037FCBCC
	add r6,#0xa6	; 037FCBCE
	strh r0,[r6,#0x0]	; 037FCBD0
	mov r1,#0x40	; 037FCBD2
	ldr r0,[pool_037FCC60]	; 037FCBD4
	strh r1,[r0,#0x0]	; 037FCBD6
	add r0,r5,#0x0	; 037FCBD8
	add r0,#0xbe	; 037FCBDA
	ldrh r0,[r0,#0x0]	; 037FCBDC
	add r0,r0,#0x1	; 037FCBDE
	add r5,#0xbe	; 037FCBE0
	strh r0,[r5,#0x0]	; 037FCBE2
	ldr r1,[pool_037FCC30]	; 037FCBE4
	mov r0,#0x3	; 037FCBE6
P2_Entry_037FCBE8:
	ldrh r2,[r1,#0x0]	; 037FCBE8
	and r2,r0	; 037FCBEA
	cmp r2,#0x3	; 037FCBEC
	beq P2_Entry_037FCBE8	; 037FCBEE
	ldr r2,[pool_037FCC64]	; 037FCBF0
	ldrh r1,[r2,#0x0]	; 037FCBF2
	mov r0,#0x40	; 037FCBF4
	orr r1,r0	; 037FCBF6
	strh r1,[r2,#0x0]	; 037FCBF8
	ldrh r1,[r2,#0x0]	; 037FCBFA
	bic r1,r0	; 037FCBFC
	strh r1,[r2,#0x0]	; 037FCBFE
	mov r0,#0x8	; 037FCC00
	ldr r1,[pool_037FCC68]	; 037FCC02
	strh r0,[r1,#0x0]	; 037FCC04
	mov r0,#0x0	; 037FCC06
	strh r0,[r1,#0x0]	; 037FCC08
	bl P2_Entry_037FCC6C	; 037FCC0A
P2_Entry_037FCC0E:
	add sp,#0x4	; 037FCC0E
	pop {r4,r5,r6,r7}	; 037FCC10
	pop {r3}	; 037FCC12
	bx r3	; 037FCC14
	.byte 0xC0, 0x46	; 037FCC16
pool_037FCC18:
	.word FirmwareWlWorkPointerSlot	; 037FCC18
pool_037FCC1C:
	.word 0x00000318	; 037FCC1C
pool_037FCC20:
	.word 0x00000400	; 037FCC20
pool_037FCC24:
	.word REG_WIFI_IF	; 037FCC24
pool_037FCC28:
	.word 0x00000638	; 037FCC28
pool_037FCC2C:
	.word 0x0000FFFF	; 037FCC2C
pool_037FCC30:
	.word REG_WIFI_RF_PINS	; 037FCC30
pool_037FCC34:
	.word REG_WIFI_RXTX_ADDR	; 037FCC34
pool_037FCC38:
	.word REG_WIFI_RXBUF_BEGIN	; 037FCC38
pool_037FCC3C:
	.word 0x00000FFF	; 037FCC3C
pool_037FCC40:
	.word REG_WIFI_RXBUF_WRCSR	; 037FCC40
pool_037FCC44:
	.word 0x04804000	; 037FCC44
pool_037FCC48:
	.word 0x0000E7FF	; 037FCC48
pool_037FCC4C:
	.word 0x00000228	; 037FCC4C
pool_037FCC50:
	.word REG_WIFI_US_COUNT0	; 037FCC50
pool_037FCC54:
	.word 0x00010000	; 037FCC54
pool_037FCC58:
	.word 0x00008000	; 037FCC58
pool_037FCC5C:
	.word REG_WIFI_TXBUF_REPLY2	; 037FCC5C
pool_037FCC60:
	.word REG_WIFI_TXBUF_RESET	; 037FCC60
pool_037FCC64:
	.word REG_WIFI_UNKNOWN_244	; 037FCC64
pool_037FCC68:
	.word REG_WIFI_UNKNOWN_228	; 037FCC68
P2_Entry_037FCC6C:
	bx pc	; 037FCC6C
	.byte 0xC0, 0x46	; 037FCC6E
.arm
	ldr r12,[pool_037FCC78]	; 037FCC70
	bx r12	; 037FCC74
pool_037FCC78:
	.word P4_Entry_02306DF4 + 1	; 037FCC78
P2_Entry_037FCC7C:
.thumb
	push {r4,r5,lr}	; 037FCC7C
	sub sp,#0x4	; 037FCC7E
	ldr r0,[pool_037FCCD4]	; 037FCC80
	ldr r1,[r0,#0x0]	; 037FCC82
	ldr r0,[pool_037FCCD8]	; 037FCC84
	add r5,r1,r0	; 037FCC86
	mov r4,#0x0	; 037FCC88
	mov r0,#0x1	; 037FCC8A
	bl P2_Entry_037FCCDC	; 037FCC8C
	lsl r0,r4,#0	; 037FCC90
	bl P2_Entry_037FCCDC	; 037FCC92
	ldr r0,[r5,#0x1c]	; 037FCC96
	ldrh r0,[r0,#0x0]	; 037FCC98
	cmp r0,#0x0	; 037FCC9A
	beq P2_Entry_037FCCA2	; 037FCC9C
	mov r4,#0x1	; 037FCC9E
	b P2_Entry_037FCCA6	; 037FCCA0
P2_Entry_037FCCA2:
	lsl r0,r4,#0	; 037FCCA2
	strh r0,[r5,#0x14]	; 037FCCA4
P2_Entry_037FCCA6:
	ldr r0,[r5,#0x8]	; 037FCCA6
	ldrh r0,[r0,#0x0]	; 037FCCA8
	cmp r0,#0x0	; 037FCCAA
	beq P2_Entry_037FCCB2	; 037FCCAC
	mov r4,#0x1	; 037FCCAE
	b P2_Entry_037FCCB6	; 037FCCB0
P2_Entry_037FCCB2:
	mov r0,#0x0	; 037FCCB2
	strh r0,[r5,#0x0]	; 037FCCB4
P2_Entry_037FCCB6:
	cmp r4,#0x0	; 037FCCB6
	beq P2_Entry_037FCCC2	; 037FCCB8
	mov r0,#0x0	; 037FCCBA
	mov r1,#0xe	; 037FCCBC
	bl loc_037FB380	; 037FCCBE
P2_Entry_037FCCC2:
	mov r0,#0x0	; 037FCCC2
	mov r1,#0x14	; 037FCCC4
	bl loc_037FB380	; 037FCCC6
	add sp,#0x4	; 037FCCCA
	pop {r4,r5}	; 037FCCCC
	pop {r3}	; 037FCCCE
	bx r3	; 037FCCD0
	.byte 0xC0, 0x46	; 037FCCD2
pool_037FCCD4:
	.word FirmwareWlWorkPointerSlot	; 037FCCD4
pool_037FCCD8:
	.word 0x00000400	; 037FCCD8
P2_Entry_037FCCDC:
	bx pc	; 037FCCDC
	.byte 0xC0, 0x46	; 037FCCDE
.arm
	ldr r12,[pool_037FCCE8]	; 037FCCE0
	bx r12	; 037FCCE4
pool_037FCCE8:
	.word loc_0230A698 + 1	; 037FCCE8
	.byte 0x10, 0xB5, 0x0E, 0x48, 0x00, 0xF0, 0x96, 0xFE, 0x04, 0x1C, 0x0D, 0x4A, 0x13, 0x88, 0x0D, 0x49	; 037FCCEC
	.byte 0x0D, 0x48, 0x01, 0x80, 0x64, 0x21, 0x03, 0xE0, 0x10, 0x88, 0x83, 0x42, 0x02, 0xD1, 0x49, 0x1E	; 037FCCFC
	.byte 0x00, 0x29, 0xF9, 0xD1, 0x00, 0x20, 0x08, 0x49, 0x08, 0x80, 0xFF, 0xF7, 0x1F, 0xFE, 0x20, 0x1C	; 037FCD0C
	.byte 0x00, 0xF0, 0x96, 0xFE, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x00, 0x00, 0x00, 0x01	; 037FCD1C
	.byte 0x10, 0x82, 0x80, 0x04, 0x00, 0x10, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04	; 037FCD2C
P2_Entry_037FCD38:
.thumb
	ldr r1,[pool_037FCD4C]	; 037FCD38
	cmp r0,r1	; 037FCD3A
	bcc P2_Entry_037FCD48	; 037FCD3C
	ldr r1,[pool_037FCD50]	; 037FCD3E
	ldr r2,[r1,#0x0]	; 037FCD40
	ldr r1,[pool_037FCD54]	; 037FCD42
	ldrh r1,[r2,r1]	; 037FCD44
	sub r0,r0,r1	; 037FCD46
P2_Entry_037FCD48:
	bx lr	; 037FCD48
	.byte 0xC0, 0x46	; 037FCD4A
pool_037FCD4C:
	.word 0x04805F60	; 037FCD4C
pool_037FCD50:
	.word FirmwareWlWorkPointerSlot	; 037FCD50
pool_037FCD54:
	.word 0x000003B2	; 037FCD54
P2_Entry_037FCD58:
	push {r4,lr}	; 037FCD58
	ldr r0,[pool_037FCD8C]	; 037FCD5A
	ldr r1,[r0,#0x0]	; 037FCD5C
	ldr r0,[pool_037FCD90]	; 037FCD5E
	add r4,r1,r0	; 037FCD60
	add r0,r4,#0x0	; 037FCD62
	add r0,#0x50	; 037FCD64
	bl P2_Entry_037FCD94	; 037FCD66
	cmp r0,#0x0	; 037FCD6A
	beq P2_Entry_037FCD72	; 037FCD6C
	mov r0,#0x1	; 037FCD6E
	b P2_Entry_037FCD84	; 037FCD70
P2_Entry_037FCD72:
	add r4,#0x64	; 037FCD72
	add r0,r4,#0x0	; 037FCD74
	bl P2_Entry_037FCD94	; 037FCD76
	cmp r0,#0x0	; 037FCD7A
	beq P2_Entry_037FCD82	; 037FCD7C
	mov r0,#0x1	; 037FCD7E
	b P2_Entry_037FCD84	; 037FCD80
P2_Entry_037FCD82:
	mov r0,#0x0	; 037FCD82
P2_Entry_037FCD84:
	pop {r4}	; 037FCD84
	pop {r3}	; 037FCD86
	bx r3	; 037FCD88
	.byte 0xC0, 0x46	; 037FCD8A
pool_037FCD8C:
	.word FirmwareWlWorkPointerSlot	; 037FCD8C
pool_037FCD90:
	.word 0x00000400	; 037FCD90
P2_Entry_037FCD94:
	bx pc	; 037FCD94
	.byte 0xC0, 0x46	; 037FCD96
.arm
	ldr r12,[pool_037FCDA0]	; 037FCD98
	bx r12	; 037FCD9C
pool_037FCDA0:
	.word P4_Entry_02306DB0 + 1	; 037FCDA0
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0A, 0x48, 0x01, 0x68, 0x0A, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD0	; 037FCDA4
	.byte 0x00, 0xF0, 0x14, 0xF8, 0x06, 0x48, 0x01, 0x68, 0x07, 0x48, 0x08, 0x5A, 0x40, 0x06, 0xC0, 0x0F	; 037FCDB4
	.byte 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x12, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCDC4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xBC, 0x03, 0x00, 0x00, 0x0E, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 037FCDD4
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xC5, 0x9F, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46	; 037FCDE4
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xC9, 0x79, 0x30, 0x02, 0xF0, 0xB5, 0x83, 0xB0	; 037FCDF4
	.byte 0x4B, 0x48, 0x01, 0x68, 0x4B, 0x48, 0x0D, 0x18, 0x4B, 0x48, 0x0F, 0x18, 0x02, 0x24, 0x01, 0x94	; 037FCE04
	.byte 0x00, 0x94, 0x21, 0x1C, 0x14, 0x20, 0x41, 0x43, 0x7A, 0x18, 0xA0, 0x00, 0x47, 0x49, 0x43, 0x18	; 037FCE14
	.byte 0x41, 0x5A, 0x47, 0x48, 0x01, 0x40, 0x00, 0x29, 0x79, 0xD1, 0x10, 0x88, 0x00, 0x28, 0x76, 0xD0	; 037FCE24
	.byte 0xD0, 0x68, 0x00, 0x28, 0x6B, 0xD0, 0x91, 0x68, 0x09, 0x88, 0x01, 0x81, 0x90, 0x68, 0x81, 0x89	; 037FCE34
	.byte 0xD0, 0x68, 0x81, 0x82, 0x90, 0x68, 0x86, 0x89, 0x3E, 0x49, 0x0E, 0x40, 0x00, 0x2E, 0x50, 0xD0	; 037FCE44
	.byte 0x37, 0x49, 0x0E, 0x68, 0x3C, 0x49, 0x76, 0x5A, 0x08, 0x21, 0x0E, 0x40, 0x00, 0x2E, 0x40, 0xD0	; 037FCE54
	.byte 0x06, 0x1C, 0x0C, 0x36, 0x41, 0x89, 0x71, 0x18, 0xC9, 0x1F, 0x01, 0x26, 0xB1, 0x43, 0x0E, 0x88	; 037FCE64
	.byte 0x00, 0x2E, 0x36, 0xD1, 0x49, 0x88, 0x00, 0x29, 0x33, 0xD1, 0x28, 0x1C, 0xA8, 0x30, 0x00, 0x68	; 037FCE74
	.byte 0xD1, 0x68, 0x89, 0x88, 0x40, 0x1A, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x26, 0x2F, 0x49, 0x0E, 0x80	; 037FCE84
	.byte 0x2B, 0x4E, 0x0E, 0x80, 0x29, 0x1C, 0xBA, 0x31, 0x09, 0x88, 0x49, 0x1C, 0x2E, 0x1C, 0xBA, 0x36	; 037FCE94
	.byte 0x31, 0x80, 0x29, 0x1C, 0x8C, 0x31, 0x09, 0x88, 0x88, 0x42, 0x12, 0xD9, 0xD1, 0x68, 0x00, 0x98	; 037FCEA4
	.byte 0x08, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0x38, 0x1C, 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C	; 037FCEB4
	.byte 0x38, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0xD0, 0x68, 0x01, 0x21, 0x12, 0x69, 0x08, 0xF0, 0xBA, 0xF8	; 037FCEC4
	.byte 0x25, 0xE0, 0xD1, 0x68, 0x00, 0x20, 0x88, 0x81, 0x19, 0x88, 0x19, 0x48, 0x01, 0x43, 0x19, 0x80	; 037FCED4
	.byte 0x1D, 0xE0, 0xD3, 0x68, 0x99, 0x89, 0x86, 0x88, 0xFF, 0x20, 0x06, 0x40, 0x88, 0x19, 0x98, 0x81	; 037FCEE4
	.byte 0x04, 0xE0, 0x81, 0x88, 0xFF, 0x20, 0x01, 0x40, 0xD0, 0x68, 0x81, 0x81, 0x90, 0x88, 0x40, 0x1C	; 037FCEF4
	.byte 0x90, 0x80, 0xD0, 0x68, 0x01, 0x99, 0x12, 0x69, 0x08, 0xF0, 0x9C, 0xF8, 0x07, 0xE0, 0x90, 0x88	; 037FCF04
	.byte 0x40, 0x1C, 0x90, 0x80, 0x90, 0x68, 0x03, 0x21, 0x12, 0x69, 0x08, 0xF0, 0x93, 0xF8, 0x64, 0x1E	; 037FCF14
	.byte 0x00, 0x2C, 0x00, 0xDB, 0x75, 0xE7, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCF24
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04	; 037FCF34
	.byte 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x38, 0x06, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04	; 037FCF44
.thumb
P2_Entry_037FCF54:
	push {r4,r5,r6,r7,lr}	; 037FCF54
	sub sp,#0x24	; 037FCF56
	ldr r0,[pool_037FD1B4]	; 037FCF58
	ldr r1,[r0,#0x0]	; 037FCF5A
	ldr r0,[pool_037FD1B8]	; 037FCF5C
	add r7,r1,r0	; 037FCF5E
	ldr r0,[pool_037FD1BC]	; 037FCF60
	add r6,r1,r0	; 037FCF62
	mov r0,#0x0	; 037FCF64
	str r0,[sp,#0x0]	; 037FCF66
	str r0,[sp,#0xc]	; 037FCF68
	str r0,[sp,#0x1c]	; 037FCF6A
	str r0,[sp,#0x18]	; 037FCF6C
	str r0,[sp,#0x14]	; 037FCF6E
	str r0,[sp,#0x10]	; 037FCF70
	str r0,[sp,#0x20]	; 037FCF72
P2_Entry_037FCF74:
	ldr r0,[pool_037FD1C0]	; 037FCF74
	ldrh r1,[r0,#0x0]	; 037FCF76
	ldrh r0,[r7,#0x4]	; 037FCF78
	cmp r1,r0	; 037FCF7A
	bne P2_Entry_037FCF80	; 037FCF7C
	b P2_Entry_037FD1AC	; 037FCF7E
P2_Entry_037FCF80:
	lsl r4,r1,#0x1	; 037FCF80
	ldr r0,[pool_037FD1C4]	; 037FCF82
	add r5,r4,r0	; 037FCF84
	add r0,r5,#0x2	; 037FCF86
	bl P2_Entry_037FCD38	; 037FCF88
	ldrh r0,[r0,#0x0]	; 037FCF8C
	str r0,[sp,#0x8]	; 037FCF8E
	ldr r0,[pool_037FD1C4]	; 037FCF90
	ldrh r1,[r4,r0]	; 037FCF92
	ldr r0,[pool_037FD1C8]	; 037FCF94
	cmp r1,r0	; 037FCF96
	bne P2_Entry_037FCFA2	; 037FCF98
	ldr r1,[sp,#0x8]	; 037FCF9A
	ldr r0,[pool_037FD1C0]	; 037FCF9C
	strh r1,[r0,#0x0]	; 037FCF9E
	b P2_Entry_037FD1A4	; 037FCFA0
P2_Entry_037FCFA2:
	add r0,r5,#0x0	; 037FCFA2
	add r0,#0x8	; 037FCFA4
	bl P2_Entry_037FCD38	; 037FCFA6
	ldrh r1,[r0,#0x0]	; 037FCFAA
	add r0,r5,#0x0	; 037FCFAC
	bl P2_Entry_037FD39C	; 037FCFAE
	add r4,r0,#0x0	; 037FCFB2
	ldr r1,[sp,#0x8]	; 037FCFB4
	ldr r0,[pool_037FD1C0]	; 037FCFB6
	strh r1,[r0,#0x0]	; 037FCFB8
	cmp r4,#0x0	; 037FCFBA
	bne P2_Entry_037FCFD8	; 037FCFBC
	ldrh r1,[r5,#0x0]	; 037FCFBE
	mov r0,#0xf	; 037FCFC0
	and r1,r0	; 037FCFC2
	cmp r1,#0xc	; 037FCFC4
	bne P2_Entry_037FCFD0	; 037FCFC6
	mov r0,#0x10	; 037FCFC8
	bl P2_Entry_037FC948	; 037FCFCA
	b P2_Entry_037FD1A4	; 037FCFCE
P2_Entry_037FCFD0:
	mov r0,#0x8	; 037FCFD0
	bl P2_Entry_037FC948	; 037FCFD2
	b P2_Entry_037FD1A4	; 037FCFD6
P2_Entry_037FCFD8:
	ldr r0,[pool_037FD1B4]	; 037FCFD8
	ldr r1,[r0,#0x0]	; 037FCFDA
	ldr r0,[pool_037FD1CC]	; 037FCFDC
	ldrh r1,[r1,r0]	; 037FCFDE
	mov r0,#0x8	; 037FCFE0
	and r1,r0	; 037FCFE2
	cmp r1,#0x0	; 037FCFE4
	beq P2_Entry_037FCFF6	; 037FCFE6
	ldrh r1,[r4,#0x14]	; 037FCFE8
	ldr r0,[pool_037FD1D0]	; 037FCFEA
	and r1,r0	; 037FCFEC
	cmp r1,#0x0	; 037FCFEE
	beq P2_Entry_037FCFF6	; 037FCFF0
	ldr r0,[sp,#0xc]	; 037FCFF2
	strh r0,[r7,#0x2]	; 037FCFF4
P2_Entry_037FCFF6:
	ldrh r1,[r4,#0x8]	; 037FCFF6
	mov r0,#0x1	; 037FCFF8
	str r0,[sp,#0x4]	; 037FCFFA
	add r2,r1,#0x0	; 037FCFFC
	ldr r0,[pool_037FD1D4]	; 037FCFFE
	and r2,r0	; 037FD000
	cmp r2,#0x0	; 037FD002
	beq P2_Entry_037FD03A	; 037FD004
	ldrh r0,[r4,#0x14]	; 037FD006
	lsl r0,r0,#0x15	; 037FD008
	lsr r0,r0,#0x1f	; 037FD00A
	cmp r0,#0x1	; 037FD00C
	beq P2_Entry_037FD01C	; 037FD00E
	ldrh r0,[r4,#0x2a]	; 037FD010
	lsl r0,r0,#0x1c	; 037FD012
	lsr r0,r0,#0x1c	; 037FD014
	cmp r0,#0x0	; 037FD016
	bne P2_Entry_037FD01C	; 037FD018
	b P2_Entry_037FD164	; 037FD01A
P2_Entry_037FD01C:
	ldr r0,[sp,#0x10]	; 037FD01C
	str r0,[sp,#0x4]	; 037FD01E
	add r0,r6,#0x0	; 037FD020
	add r0,#0xc	; 037FD022
	add r1,r6,#0x0	; 037FD024
	add r1,#0x6c	; 037FD026
	add r2,r4,#0x0	; 037FD028
	sub r2,#0x10	; 037FD02A
	bl loc_037FB65C	; 037FD02C
	mov r0,#0x2	; 037FD030
	mov r1,#0x9	; 037FD032
	bl loc_037FB380	; 037FD034
	b P2_Entry_037FD164	; 037FD038
P2_Entry_037FD03A:
	mov r0,#0xf	; 037FD03A
	and r1,r0	; 037FD03C
	cmp r1,#0xf	; 037FD03E
	bls P2_Entry_037FD044	; 037FD040
	b P2_Entry_037FD164	; 037FD042
P2_Entry_037FD044:
	add r0,r1,r1	; 037FD044
P2_SwitchIndexPC_037FD044:
	add r0,pc	; 037FD046
	ldrh r0,[r0,#(P2_SwitchTable_037FD044 - (P2_SwitchIndexPC_037FD044 + 4))]	; 037FD048
	lsl r0,r0,#0x10	; 037FD04A
	asr r0,r0,#0x10	; 037FD04C
P2_SwitchTargetPC_037FD044:
	add r0,pc	; 037FD04E
	bx r0	; 037FD050
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD044:
	.halfword (P2_Case_037FD0A8 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD09A + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD0D0 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD072 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Entry_037FD164 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD10C + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD142 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD0F8 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
	.halfword (P2_Case_037FD0F8 + 1) - (P2_SwitchTargetPC_037FD044 + 4)
P2_SwitchTable_037FD044End:
P2_Case_037FD072:
	ldrh r1,[r4,#0x14]	; 037FD072
	mov r0,#0xf	; 037FD074
	and r1,r0	; 037FD076
	cmp r1,#0x8	; 037FD078
	bne P2_Entry_037FD164	; 037FD07A
	ldr r0,[sp,#0x14]	; 037FD07C
	str r0,[sp,#0x4]	; 037FD07E
	add r0,r6,#0x0	; 037FD080
	add r0,#0xc	; 037FD082
	add r1,r6,#0x0	; 037FD084
	add r1,#0x48	; 037FD086
	add r2,r4,#0x0	; 037FD088
	sub r2,#0x10	; 037FD08A
	bl loc_037FB65C	; 037FD08C
	mov r0,#0x2	; 037FD090
	mov r1,#0x6	; 037FD092
	bl loc_037FB380	; 037FD094
	b P2_Entry_037FD164	; 037FD098
P2_Case_037FD09A:
	ldrh r0,[r4,#0x14]	; 037FD09A
	cmp r0,#0x80	; 037FD09C
	bne P2_Entry_037FD164	; 037FD09E
	add r0,r4,#0x0	; 037FD0A0
	bl P2_Entry_037FD204	; 037FD0A2
	b P2_Entry_037FD164	; 037FD0A6
P2_Case_037FD0A8:
	ldrh r1,[r4,#0x14]	; 037FD0A8
	mov r0,#0xf	; 037FD0AA
	and r1,r0	; 037FD0AC
	cmp r1,#0x0	; 037FD0AE
	bne P2_Entry_037FD164	; 037FD0B0
	ldr r0,[sp,#0x18]	; 037FD0B2
	str r0,[sp,#0x4]	; 037FD0B4
	add r0,r6,#0x0	; 037FD0B6
	add r0,#0xc	; 037FD0B8
	add r1,r6,#0x0	; 037FD0BA
	add r1,#0x60	; 037FD0BC
	add r2,r4,#0x0	; 037FD0BE
	sub r2,#0x10	; 037FD0C0
	bl loc_037FB65C	; 037FD0C2
	mov r0,#0x1	; 037FD0C6
	mov r1,#0x7	; 037FD0C8
	bl loc_037FB380	; 037FD0CA
	b P2_Entry_037FD164	; 037FD0CE
P2_Case_037FD0D0:
	ldrh r1,[r4,#0x14]	; 037FD0D0
	ldr r0,[pool_037FD1D8]	; 037FD0D2
	and r1,r0	; 037FD0D4
	cmp r1,#0xa4	; 037FD0D6
	bne P2_Entry_037FD164	; 037FD0D8
	ldr r0,[sp,#0x1c]	; 037FD0DA
	str r0,[sp,#0x4]	; 037FD0DC
	add r0,r6,#0x0	; 037FD0DE
	add r0,#0xc	; 037FD0E0
	add r1,r6,#0x0	; 037FD0E2
	add r1,#0x60	; 037FD0E4
	add r2,r4,#0x0	; 037FD0E6
	sub r2,#0x10	; 037FD0E8
	bl loc_037FB65C	; 037FD0EA
	mov r0,#0x1	; 037FD0EE
	mov r1,#0x7	; 037FD0F0
	bl loc_037FB380	; 037FD0F2
	b P2_Entry_037FD164	; 037FD0F6
P2_Case_037FD0F8:
	ldrh r0,[r4,#0x14]	; 037FD0F8
	ldr r1,[pool_037FD1DC]	; 037FD0FA
	and r0,r1	; 037FD0FC
	ldr r1,[pool_037FD1E0]	; 037FD0FE
	cmp r0,r1	; 037FD100
	bne P2_Entry_037FD164	; 037FD102
	add r0,r4,#0x0	; 037FD104
	bl P2_Entry_037FD214	; 037FD106
	b P2_Entry_037FD164	; 037FD10A
P2_Case_037FD10C:
	ldrh r0,[r4,#0x14]	; 037FD10C
	ldr r1,[pool_037FD1D8]	; 037FD10E
	and r0,r1	; 037FD110
	ldr r1,[pool_037FD1E4]	; 037FD112
	cmp r0,r1	; 037FD114
	bne P2_Entry_037FD164	; 037FD116
	ldr r0,[pool_037FD1B4]	; 037FD118
	ldr r1,[r0,#0x0]	; 037FD11A
	ldr r0,[pool_037FD1E8]	; 037FD11C
	ldrh r0,[r1,r0]	; 037FD11E
	cmp r0,#0x0	; 037FD120
	bne P2_Entry_037FD12A	; 037FD122
	mov r1,#0x1	; 037FD124
	ldr r0,[pool_037FD1EC]	; 037FD126
	strh r1,[r0,#0x0]	; 037FD128
P2_Entry_037FD12A:
	ldr r0,[pool_037FD1B4]	; 037FD12A
	ldr r2,[r0,#0x0]	; 037FD12C
	ldr r0,[pool_037FD1F0]	; 037FD12E
	ldr r0,[r2,r0]	; 037FD130
	add r1,r0,#0x1	; 037FD132
	ldr r0,[pool_037FD1F0]	; 037FD134
	str r1,[r2,r0]	; 037FD136
	add r0,r4,#0x0	; 037FD138
	bl P2_Entry_037FD224	; 037FD13A
	str r0,[sp,#0x4]	; 037FD13E
	b P2_Entry_037FD164	; 037FD140
P2_Case_037FD142:
	ldrh r0,[r4,#0x14]	; 037FD142
	ldr r1,[pool_037FD1D8]	; 037FD144
	and r0,r1	; 037FD146
	ldr r1,[pool_037FD1F4]	; 037FD148
	cmp r0,r1	; 037FD14A
	bne P2_Entry_037FD164	; 037FD14C
	ldr r0,[pool_037FD1B4]	; 037FD14E
	ldr r2,[r0,#0x0]	; 037FD150
	ldr r0,[pool_037FD1F8]	; 037FD152
	ldr r0,[r2,r0]	; 037FD154
	add r1,r0,#0x1	; 037FD156
	ldr r0,[pool_037FD1F8]	; 037FD158
	str r1,[r2,r0]	; 037FD15A
	add r0,r4,#0x0	; 037FD15C
	bl P2_Entry_037FD234	; 037FD15E
	str r0,[sp,#0x4]	; 037FD162
P2_Entry_037FD164:
	ldr r0,[sp,#0x4]	; 037FD164
	cmp r0,#0x0	; 037FD166
	beq P2_Entry_037FD176	; 037FD168
	add r0,r6,#0x0	; 037FD16A
	add r0,#0xc	; 037FD16C
	sub r4,#0x10	; 037FD16E
	add r1,r4,#0x0	; 037FD170
	bl P2_Entry_037FB604	; 037FD172
P2_Entry_037FD176:
	ldr r0,[pool_037FD1B4]	; 037FD176
	ldr r1,[r0,#0x0]	; 037FD178
	ldr r0,[pool_037FD1CC]	; 037FD17A
	ldrh r1,[r1,r0]	; 037FD17C
	mov r0,#0x1	; 037FD17E
	and r1,r0	; 037FD180
	cmp r1,#0x0	; 037FD182
	beq P2_Entry_037FD1A4	; 037FD184
	ldr r0,[sp,#0x20]	; 037FD186
P2_Entry_037FD188:
	ldr r1,[pool_037FD1FC]	; 037FD188
	cmp r5,r1	; 037FD18A
	bcc P2_Entry_037FD198	; 037FD18C
	ldr r1,[pool_037FD1B4]	; 037FD18E
	ldr r2,[r1,#0x0]	; 037FD190
	ldr r1,[pool_037FD200]	; 037FD192
	ldrh r1,[r2,r1]	; 037FD194
	sub r5,r5,r1	; 037FD196
P2_Entry_037FD198:
	ldr r1,[pool_037FD1C8]	; 037FD198
	strh r1,[r5,#0x0]	; 037FD19A
	add r5,r5,#0x2	; 037FD19C
	add r0,r0,#0x1	; 037FD19E
	cmp r0,#0x7	; 037FD1A0
	bcc P2_Entry_037FD188	; 037FD1A2
P2_Entry_037FD1A4:
	ldr r0,[sp,#0x0]	; 037FD1A4
	add r0,r0,#0x1	; 037FD1A6
	str r0,[sp,#0x0]	; 037FD1A8
	b P2_Entry_037FCF74	; 037FD1AA
P2_Entry_037FD1AC:
	add sp,#0x24	; 037FD1AC
	pop {r4,r5,r6,r7}	; 037FD1AE
	pop {r3}	; 037FD1B0
	bx r3	; 037FD1B2
pool_037FD1B4:
	.word FirmwareWlWorkPointerSlot	; 037FD1B4
pool_037FD1B8:
	.word 0x000004B4	; 037FD1B8
pool_037FD1BC:
	.word 0x00000150	; 037FD1BC
pool_037FD1C0:
	.word REG_WIFI_RXBUF_READCSR	; 037FD1C0
pool_037FD1C4:
	.word 0x04804000	; 037FD1C4
pool_037FD1C8:
	.word 0x0000FFFF	; 037FD1C8
pool_037FD1CC:
	.word 0x00000638	; 037FD1CC
pool_037FD1D0:
	.word 0x00004000	; 037FD1D0
pool_037FD1D4:
	.word 0x00000200	; 037FD1D4
pool_037FD1D8:
	.word 0x0000E7FF	; 037FD1D8
pool_037FD1DC:
	.word 0x0000E7BF	; 037FD1DC
pool_037FD1E0:
	.word 0x00000118	; 037FD1E0
pool_037FD1E4:
	.word 0x00000228	; 037FD1E4
pool_037FD1E8:
	.word 0x00000328	; 037FD1E8
pool_037FD1EC:
	.word REG_WIFI_POWERSTATE	; 037FD1EC
pool_037FD1F0:
	.word 0x00000580	; 037FD1F0
pool_037FD1F4:
	.word 0x00000218	; 037FD1F4
pool_037FD1F8:
	.word 0x00000584	; 037FD1F8
pool_037FD1FC:
	.word 0x04805F60	; 037FD1FC
pool_037FD200:
	.word 0x000003B2	; 037FD200
P2_Entry_037FD204:
	bx pc	; 037FD204
	.byte 0xC0, 0x46	; 037FD206
.arm
	ldr r12,[pool_037FD210]	; 037FD208
	bx r12	; 037FD20C
pool_037FD210:
	.word loc_0230C6C4 + 1	; 037FD210
P2_Entry_037FD214:
.thumb
	bx pc	; 037FD214
	.byte 0xC0, 0x46	; 037FD216
.arm
	ldr r12,[pool_037FD220]	; 037FD218
	bx r12	; 037FD21C
pool_037FD220:
	.word P4_Entry_0230CCC8 + 1	; 037FD220
P2_Entry_037FD224:
.thumb
	bx pc	; 037FD224
	.byte 0xC0, 0x46	; 037FD226
.arm
	ldr r12,[pool_037FD230]	; 037FD228
	bx r12	; 037FD22C
pool_037FD230:
	.word P4_Entry_0230CE00 + 1	; 037FD230
P2_Entry_037FD234:
.thumb
	bx pc	; 037FD234
	.byte 0xC0, 0x46	; 037FD236
.arm
	ldr r12,[pool_037FD240]	; 037FD238
	bx r12	; 037FD23C
pool_037FD240:
	.word P4_Entry_0230CC20 + 1	; 037FD240
.thumb
P2_Entry_037FD244:
	push {r4,lr}	; 037FD244
	ldr r0,[pool_037FD2E8]	; 037FD246
	ldr r1,[r0,#0x0]	; 037FD248
	ldr r0,[pool_037FD2EC]	; 037FD24A
	add r4,r1,r0	; 037FD24C
	ldrh r0,[r4,#0x3c]	; 037FD24E
	cmp r0,#0x0	; 037FD250
	beq P2_Entry_037FD2E2	; 037FD252
	add r0,r4,#0x0	; 037FD254
	add r0,#0x90	; 037FD256
	ldr r0,[r0,#0x0]	; 037FD258
	ldrh r1,[r0,#0x10]	; 037FD25A
	ldr r0,[r4,#0x44]	; 037FD25C
	ldrh r0,[r0,#0x2]	; 037FD25E
	cmp r1,r0	; 037FD260
	beq P2_Entry_037FD268	; 037FD262
	bl P2_Entry_037FCF54	; 037FD264
P2_Entry_037FD268:
	ldr r0,[r4,#0x44]	; 037FD268
	ldrh r0,[r0,#0x4]	; 037FD26A
	mov r1,#0xff	; 037FD26C
	and r0,r1	; 037FD26E
	cmp r0,#0x0	; 037FD270
	beq P2_Entry_037FD284	; 037FD272
	ldr r1,[pool_037FD2E8]	; 037FD274
	ldr r2,[r1,#0x0]	; 037FD276
	ldr r1,[pool_037FD2F0]	; 037FD278
	add r1,r2,r1	; 037FD27A
	ldr r2,[r1,#0x0]	; 037FD27C
	add r0,r2,r0	; 037FD27E
	str r0,[r1,#0x0]	; 037FD280
	b P2_Entry_037FD292	; 037FD282
P2_Entry_037FD284:
	ldr r0,[pool_037FD2E8]	; 037FD284
	ldr r1,[r0,#0x0]	; 037FD286
	ldr r0,[pool_037FD2F0]	; 037FD288
	add r0,r1,r0	; 037FD28A
	ldr r1,[r0,#0x0]	; 037FD28C
	add r1,r1,#0x1	; 037FD28E
	str r1,[r0,#0x0]	; 037FD290
P2_Entry_037FD292:
	add r0,r4,#0x0	; 037FD292
	add r0,#0x40	; 037FD294
	ldrh r0,[r0,#0x0]	; 037FD296
	add r1,r0,#0x1	; 037FD298
	add r0,r4,#0x0	; 037FD29A
	add r0,#0x40	; 037FD29C
	strh r1,[r0,#0x0]	; 037FD29E
	add r0,r4,#0x0	; 037FD2A0
	add r0,#0x90	; 037FD2A2
	ldr r2,[r0,#0x0]	; 037FD2A4
	ldrh r1,[r2,#0x10]	; 037FD2A6
	ldr r0,[r4,#0x44]	; 037FD2A8
	ldrh r0,[r0,#0x2]	; 037FD2AA
	eor r1,r0	; 037FD2AC
	strh r1,[r2,#0x12]	; 037FD2AE
	add r0,r4,#0x0	; 037FD2B0
	add r0,#0x90	; 037FD2B2
	ldr r0,[r0,#0x0]	; 037FD2B4
	ldrh r1,[r0,#0x10]	; 037FD2B6
	add r0,r4,#0x0	; 037FD2B8
	add r0,#0xa0	; 037FD2BA
	strh r1,[r0,#0x0]	; 037FD2BC
	mov r0,#0x0	; 037FD2BE
	strh r0,[r4,#0x3c]	; 037FD2C0
	ldr r0,[pool_037FD2E8]	; 037FD2C2
	ldr r1,[r0,#0x0]	; 037FD2C4
	ldr r0,[pool_037FD2F4]	; 037FD2C6
	ldrh r0,[r1,r0]	; 037FD2C8
	cmp r0,#0x0	; 037FD2CA
	beq P2_Entry_037FD2D2	; 037FD2CC
	bl loc_037FBD2C	; 037FD2CE
P2_Entry_037FD2D2:
	ldr r0,[pool_037FD2E8]	; 037FD2D2
	ldr r1,[r0,#0x0]	; 037FD2D4
	ldr r0,[pool_037FD2F8]	; 037FD2D6
	add r0,r1,r0	; 037FD2D8
	add r4,#0x90	; 037FD2DA
	ldr r1,[r4,#0x0]	; 037FD2DC
	bl loc_037FB91C	; 037FD2DE
P2_Entry_037FD2E2:
	pop {r4}	; 037FD2E2
	pop {r3}	; 037FD2E4
	bx r3	; 037FD2E6
pool_037FD2E8:
	.word FirmwareWlWorkPointerSlot	; 037FD2E8
pool_037FD2EC:
	.word 0x00000400	; 037FD2EC
pool_037FD2F0:
	.word 0x00000574	; 037FD2F0
pool_037FD2F4:
	.word 0x000003BE	; 037FD2F4
pool_037FD2F8:
	.word 0x0000015C	; 037FD2F8
	.byte 0x10, 0xB5, 0x19, 0x48, 0x00, 0x68, 0x19, 0x49, 0x44, 0x18, 0x19, 0x49, 0x09, 0x88, 0x00, 0x29	; 037FD2FC
	.byte 0x08, 0xD1, 0x21, 0x8F, 0x00, 0x29, 0x05, 0xD0, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FD30C
	.byte 0x2F, 0xF8, 0x1D, 0xE0, 0x14, 0x49, 0x42, 0x5A, 0x14, 0x49, 0x40, 0x5A, 0x82, 0x43, 0x00, 0x2A	; 037FD31C
	.byte 0x07, 0xD1, 0x08, 0x21, 0x0F, 0x48, 0x01, 0x80, 0x20, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0	; 037FD32C
	.byte 0x1F, 0xF8, 0x05, 0x21, 0x0B, 0x48, 0x01, 0x80, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 037FD33C
	.byte 0x00, 0xF0, 0x1E, 0xF8, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0x18, 0xF8	; 037FD34C
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00	; 037FD35C
	.byte 0x88, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 037FD36C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x75, 0xAE, 0x30, 0x02	; 037FD37C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x01, 0xAF, 0x30, 0x02	; 037FD38C
P2_Entry_037FD39C:
	push {r4,r5,r6,lr}	; 037FD39C
	add r6,r0,#0x0	; 037FD39E
	add r5,r1,#0x0	; 037FD3A0
	ldr r0,[pool_037FD3EC]	; 037FD3A2
	ldr r1,[r0,#0x0]	; 037FD3A4
	ldr r0,[pool_037FD3F0]	; 037FD3A6
	add r0,r1,r0	; 037FD3A8
	add r1,r5,#0x0	; 037FD3AA
	add r1,#0x22	; 037FD3AC
	bl P2_Entry_037FB598	; 037FD3AE
	cmp r0,#0x0	; 037FD3B2
	bne P2_Entry_037FD3BA	; 037FD3B4
	mov r0,#0x0	; 037FD3B6
	b P2_Entry_037FD3E4	; 037FD3B8
P2_Entry_037FD3BA:
	add r4,r0,#0x0	; 037FD3BA
	add r4,#0x10	; 037FD3BC
	add r0,r4,#0x0	; 037FD3BE
	add r0,#0x8	; 037FD3C0
	add r1,r6,#0x0	; 037FD3C2
	add r2,r5,#0x0	; 037FD3C4
	add r2,#0xc	; 037FD3C6
	bl P2_Entry_037FD3F4	; 037FD3C8
	sub r5,#0x18	; 037FD3CC
	strh r5,[r4,#0x6]	; 037FD3CE
	ldrh r2,[r4,#0xe]	; 037FD3D0
	mov r0,#0xff	; 037FD3D2
	and r2,r0	; 037FD3D4
	ldrh r1,[r4,#0x12]	; 037FD3D6
	and r1,r0	; 037FD3D8
	lsl r0,r1,#0x10	; 037FD3DA
	lsr r0,r0,#0x8	; 037FD3DC
	orr r2,r0	; 037FD3DE
	strh r2,[r4,#0xe]	; 037FD3E0
	add r0,r4,#0x0	; 037FD3E2
P2_Entry_037FD3E4:
	pop {r4,r5,r6}	; 037FD3E4
	pop {r3}	; 037FD3E6
	bx r3	; 037FD3E8
	.byte 0xC0, 0x46	; 037FD3EA
pool_037FD3EC:
	.word FirmwareWlWorkPointerSlot	; 037FD3EC
pool_037FD3F0:
	.word 0x0000015C	; 037FD3F0
P2_Entry_037FD3F4:
	bx pc	; 037FD3F4
	.byte 0xC0, 0x46	; 037FD3F6
.arm
	ldr r12,[pool_037FD400]	; 037FD3F8
	bx r12	; 037FD3FC
pool_037FD400:
	.word loc_023052B4 + 1	; 037FD400
.thumb

; ===== function loc_037FD404 =====
loc_037FD404:
	push {r4,r5,r6,r7,lr}	; 037FD404
	sub sp,#0x4	; 037FD406
	ldr r0,[pool_037FD5C4]	; 037FD408
	ldr r6,[r0,#0x0]	; 037FD40A
	ldr r0,[pool_037FD5C8]	; 037FD40C
	add r4,r6,r0	; 037FD40E
	ldr r0,[pool_037FD5CC]	; 037FD410
	add r5,r6,r0	; 037FD412
	ldr r0,[pool_037FD5D0]	; 037FD414
	add r7,r6,r0	; 037FD416
	mov r0,#0x0	; 037FD418
	str r0,[sp,#0x0]	; 037FD41A
	ldr r0,[sp,#0x0]	; 037FD41C
	add r1,r4,#0x0	; 037FD41E
	mov r2,#0xb4	; 037FD420
	bl loc_037FD690	; 037FD422
	mov r1,#0x0	; 037FD426
	ldr r0,[pool_037FD5C8]	; 037FD428
	strh r1,[r6,r0]	; 037FD42A
	str r1,[r4,#0xc]	; 037FD42C
	strh r1,[r4,#0x14]	; 037FD42E
	str r1,[r4,#0x20]	; 037FD430
	strh r1,[r4,#0x28]	; 037FD432
	str r1,[r4,#0x34]	; 037FD434
	ldr r1,[pool_037FD5D4]	; 037FD436
	add r0,r4,#0x0	; 037FD438
	add r0,#0xa4	; 037FD43A
	strh r1,[r0,#0x0]	; 037FD43C
	add r0,r4,#0x0	; 037FD43E
	add r0,#0xa6	; 037FD440
	strh r1,[r0,#0x0]	; 037FD442
	ldrh r0,[r5,#0xc]	; 037FD444
	cmp r0,#0x3	; 037FD446
	bls loc_037FD44C	; 037FD448
	b loc_037FD5A6	; 037FD44A
loc_037FD44C:
	add r0,r0,r0	; 037FD44C
P2_SwitchIndexPC_037FD44C:
	add r0,pc	; 037FD44E
	ldrh r0,[r0,#(P2_SwitchTable_037FD44C - (P2_SwitchIndexPC_037FD44C + 4))]	; 037FD450
	lsl r0,r0,#0x10	; 037FD452
	asr r0,r0,#0x10	; 037FD454
P2_SwitchTargetPC_037FD44C:
	add r0,pc	; 037FD456
	bx r0	; 037FD458
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD44C:
	.halfword (loc_037FD462 + 1) - (P2_SwitchTargetPC_037FD44C + 4)
	.halfword (loc_037FD4A6 + 1) - (P2_SwitchTargetPC_037FD44C + 4)
	.halfword (loc_037FD508 + 1) - (P2_SwitchTargetPC_037FD44C + 4)
	.halfword (loc_037FD564 + 1) - (P2_SwitchTargetPC_037FD44C + 4)
P2_SwitchTable_037FD44CEnd:
loc_037FD462:
	ldr r0,[pool_037FD5D8]	; 037FD462
	str r0,[r4,#0x8]	; 037FD464
	ldr r0,[pool_037FD5DC]	; 037FD466
	str r0,[r4,#0x1c]	; 037FD468
	ldr r0,[pool_037FD5E0]	; 037FD46A
	str r0,[r4,#0x30]	; 037FD46C
	ldr r0,[pool_037FD5E4]	; 037FD46E
	str r0,[r4,#0x10]	; 037FD470
	ldr r0,[pool_037FD5E8]	; 037FD472
	str r0,[r4,#0x24]	; 037FD474
	ldr r0,[pool_037FD5EC]	; 037FD476
	str r0,[r4,#0x38]	; 037FD478
	ldr r1,[pool_037FD5F0]	; 037FD47A
	ldr r0,[pool_037FD5F4]	; 037FD47C
	strh r1,[r0,#0x0]	; 037FD47E
	ldr r0,[pool_037FD5F8]	; 037FD480
	ldr r2,[pool_037FD5FC]	; 037FD482
	strh r0,[r2,#0x0]	; 037FD484
	ldr r2,[pool_037FD600]	; 037FD486
	strh r1,[r2,#0x0]	; 037FD488
	ldr r2,[pool_037FD604]	; 037FD48A
	strh r0,[r2,#0x0]	; 037FD48C
	ldr r2,[pool_037FD608]	; 037FD48E
	strh r1,[r2,#0x0]	; 037FD490
	ldr r1,[pool_037FD60C]	; 037FD492
	strh r0,[r1,#0x0]	; 037FD494
	mov r1,#0x8	; 037FD496
	add r0,r5,#0x0	; 037FD498
	add r0,#0x8a	; 037FD49A
	strh r1,[r0,#0x0]	; 037FD49C
	mov r1,#0x1	; 037FD49E
	ldr r0,[pool_037FD610]	; 037FD4A0
	strh r1,[r0,#0x0]	; 037FD4A2
	b loc_037FD5A6	; 037FD4A4
loc_037FD4A6:
	ldr r0,[pool_037FD614]	; 037FD4A6
	str r0,[r4,#0x8]	; 037FD4A8
	ldr r0,[pool_037FD618]	; 037FD4AA
	str r0,[r4,#0x1c]	; 037FD4AC
	ldr r0,[pool_037FD61C]	; 037FD4AE
	str r0,[r4,#0x30]	; 037FD4B0
	ldr r0,[pool_037FD5E4]	; 037FD4B2
	str r0,[r4,#0x10]	; 037FD4B4
	ldr r0,[pool_037FD5E8]	; 037FD4B6
	str r0,[r4,#0x24]	; 037FD4B8
	ldr r0,[pool_037FD620]	; 037FD4BA
	str r0,[r4,#0x38]	; 037FD4BC
	ldr r2,[pool_037FD624]	; 037FD4BE
	add r0,r4,#0x0	; 037FD4C0
	add r0,#0x80	; 037FD4C2
	str r2,[r0,#0x0]	; 037FD4C4
	ldr r0,[pool_037FD5E0]	; 037FD4C6
	str r0,[r4,#0x44]	; 037FD4C8
	ldr r1,[pool_037FD5F0]	; 037FD4CA
	ldr r0,[pool_037FD628]	; 037FD4CC
	strh r1,[r0,#0x0]	; 037FD4CE
	ldr r0,[pool_037FD5F8]	; 037FD4D0
	ldr r3,[pool_037FD62C]	; 037FD4D2
	strh r0,[r3,#0x0]	; 037FD4D4
	ldr r3,[pool_037FD630]	; 037FD4D6
	strh r1,[r3,#0x0]	; 037FD4D8
	ldr r3,[pool_037FD634]	; 037FD4DA
	strh r0,[r3,#0x0]	; 037FD4DC
	ldr r3,[pool_037FD638]	; 037FD4DE
	strh r1,[r3,#0x0]	; 037FD4E0
	ldr r3,[pool_037FD63C]	; 037FD4E2
	strh r0,[r3,#0x0]	; 037FD4E4
	ldr r3,[pool_037FD640]	; 037FD4E6
	strh r1,[r3,#0x0]	; 037FD4E8
	ldr r3,[pool_037FD644]	; 037FD4EA
	strh r0,[r3,#0x0]	; 037FD4EC
	ldr r3,[pool_037FD648]	; 037FD4EE
	strh r1,[r3,#0x0]	; 037FD4F0
	ldr r1,[pool_037FD64C]	; 037FD4F2
	strh r0,[r1,#0x0]	; 037FD4F4
	ldr r1,[pool_037FD650]	; 037FD4F6
	add r0,r5,#0x0	; 037FD4F8
	add r0,#0x8a	; 037FD4FA
	strh r1,[r0,#0x0]	; 037FD4FC
	add r4,#0x80	; 037FD4FE
	str r2,[r4,#0x0]	; 037FD500
	bl loc_037FD69C	; 037FD502
	b loc_037FD5A6	; 037FD506
loc_037FD508:
	ldr r0,[pool_037FD654]	; 037FD508
	str r0,[r4,#0x8]	; 037FD50A
	ldr r0,[pool_037FD658]	; 037FD50C
	str r0,[r4,#0x1c]	; 037FD50E
	ldr r0,[pool_037FD65C]	; 037FD510
	str r0,[r4,#0x30]	; 037FD512
	ldr r0,[pool_037FD5E4]	; 037FD514
	str r0,[r4,#0x10]	; 037FD516
	ldr r0,[pool_037FD5E8]	; 037FD518
	str r0,[r4,#0x24]	; 037FD51A
	ldr r0,[pool_037FD5EC]	; 037FD51C
	str r0,[r4,#0x38]	; 037FD51E
	ldr r0,[pool_037FD5E0]	; 037FD520
	str r0,[r4,#0x58]	; 037FD522
	ldr r0,[pool_037FD628]	; 037FD524
	str r0,[r4,#0x6c]	; 037FD526
	ldr r1,[pool_037FD5F0]	; 037FD528
	ldr r0,[pool_037FD660]	; 037FD52A
	strh r1,[r0,#0x0]	; 037FD52C
	ldr r0,[pool_037FD5F8]	; 037FD52E
	ldr r2,[pool_037FD664]	; 037FD530
	strh r0,[r2,#0x0]	; 037FD532
	ldr r2,[pool_037FD668]	; 037FD534
	strh r1,[r2,#0x0]	; 037FD536
	ldr r2,[pool_037FD66C]	; 037FD538
	strh r0,[r2,#0x0]	; 037FD53A
	ldr r2,[pool_037FD670]	; 037FD53C
	strh r1,[r2,#0x0]	; 037FD53E
	ldr r2,[pool_037FD674]	; 037FD540
	strh r0,[r2,#0x0]	; 037FD542
	ldr r2,[pool_037FD678]	; 037FD544
	strh r1,[r2,#0x0]	; 037FD546
	ldr r2,[pool_037FD67C]	; 037FD548
	strh r0,[r2,#0x0]	; 037FD54A
	ldr r2,[pool_037FD680]	; 037FD54C
	strh r1,[r2,#0x0]	; 037FD54E
	ldr r1,[pool_037FD684]	; 037FD550
	strh r0,[r1,#0x0]	; 037FD552
	ldr r1,[pool_037FD688]	; 037FD554
	add r0,r5,#0x0	; 037FD556
	add r0,#0x8a	; 037FD558
	strh r1,[r0,#0x0]	; 037FD55A
	mov r1,#0xd	; 037FD55C
	ldr r0,[pool_037FD610]	; 037FD55E
	strh r1,[r0,#0x0]	; 037FD560
	b loc_037FD5A6	; 037FD562
loc_037FD564:
	ldr r0,[pool_037FD5D8]	; 037FD564
	str r0,[r4,#0x8]	; 037FD566
	ldr r0,[pool_037FD5DC]	; 037FD568
	str r0,[r4,#0x1c]	; 037FD56A
	ldr r0,[pool_037FD5E0]	; 037FD56C
	str r0,[r4,#0x30]	; 037FD56E
	ldr r0,[pool_037FD5E4]	; 037FD570
	str r0,[r4,#0x10]	; 037FD572
	ldr r0,[pool_037FD5E8]	; 037FD574
	str r0,[r4,#0x24]	; 037FD576
	ldr r0,[pool_037FD5EC]	; 037FD578
	str r0,[r4,#0x38]	; 037FD57A
	ldr r1,[pool_037FD5F0]	; 037FD57C
	ldr r0,[pool_037FD5F4]	; 037FD57E
	strh r1,[r0,#0x0]	; 037FD580
	ldr r0,[pool_037FD5F8]	; 037FD582
	ldr r2,[pool_037FD5FC]	; 037FD584
	strh r0,[r2,#0x0]	; 037FD586
	ldr r2,[pool_037FD600]	; 037FD588
	strh r1,[r2,#0x0]	; 037FD58A
	ldr r2,[pool_037FD604]	; 037FD58C
	strh r0,[r2,#0x0]	; 037FD58E
	ldr r2,[pool_037FD608]	; 037FD590
	strh r1,[r2,#0x0]	; 037FD592
	ldr r1,[pool_037FD60C]	; 037FD594
	strh r0,[r1,#0x0]	; 037FD596
	ldr r1,[pool_037FD688]	; 037FD598
	add r0,r5,#0x0	; 037FD59A
	add r0,#0x8a	; 037FD59C
	strh r1,[r0,#0x0]	; 037FD59E
	mov r1,#0xd	; 037FD5A0
	ldr r0,[pool_037FD610]	; 037FD5A2
	strh r1,[r0,#0x0]	; 037FD5A4
loc_037FD5A6:
	ldrh r0,[r7,#0x18]	; 037FD5A6
	cmp r0,#0x0	; 037FD5A8
	beq loc_037FD5BA	; 037FD5AA
	add r0,r5,#0x0	; 037FD5AC
	add r0,#0x8a	; 037FD5AE
	ldrh r1,[r0,#0x0]	; 037FD5B0
	ldr r0,[pool_037FD68C]	; 037FD5B2
	orr r1,r0	; 037FD5B4
	add r5,#0x8a	; 037FD5B6
	strh r1,[r5,#0x0]	; 037FD5B8
loc_037FD5BA:
	add sp,#0x4	; 037FD5BA
	pop {r4,r5,r6,r7}	; 037FD5BC
	pop {r3}	; 037FD5BE
	bx r3	; 037FD5C0
	.byte 0xC0, 0x46	; 037FD5C4
pool_037FD5C4:
loc_037FD5C4:
	.word FirmwareWlWorkPointerSlot	; 037FD5C4
pool_037FD5C8:
loc_037FD5C8:
	.word 0x00000400	; 037FD5C8
pool_037FD5CC:
loc_037FD5CC:
	.word 0x00000318	; 037FD5CC
pool_037FD5D0:
loc_037FD5D0:
	.word 0x000002F0	; 037FD5D0
pool_037FD5D4:
loc_037FD5D4:
	.word 0x0000FFFF	; 037FD5D4
pool_037FD5D8:
loc_037FD5D8:
	.word 0x04804170	; 037FD5D8
pool_037FD5DC:
loc_037FD5DC:
	.word 0x04804028	; 037FD5DC
pool_037FD5E0:
loc_037FD5E0:
	.word 0x04804000	; 037FD5E0
pool_037FD5E4:
loc_037FD5E4:
	.word 0x0230AC65	; 037FD5E4
pool_037FD5E8:
loc_037FD5E8:
	.word 0x0230A9B5	; 037FD5E8
pool_037FD5EC:
loc_037FD5EC:
	.word 0x0230A965	; 037FD5EC
pool_037FD5F0:
loc_037FD5F0:
	.word 0x0000B6B8	; 037FD5F0
pool_037FD5F4:
loc_037FD5F4:
	.word WifiRamBase + 0x24	; 037FD5F4
pool_037FD5F8:
loc_037FD5F8:
	.word 0x00001D46	; 037FD5F8
pool_037FD5FC:
loc_037FD5FC:
	.word WifiRamBase + 0x26	; 037FD5FC
pool_037FD600:
loc_037FD600:
	.word WifiRamBase + 0x16C	; 037FD600
pool_037FD604:
loc_037FD604:
	.word WifiRamBase + 0x16E	; 037FD604
pool_037FD608:
loc_037FD608:
	.word WifiRamBase + 0x790	; 037FD608
pool_037FD60C:
loc_037FD60C:
	.word WifiRamBase + 0x792	; 037FD60C
pool_037FD610:
loc_037FD610:
	.word REG_WIFI_TXREQ_SET	; 037FD610
pool_037FD614:
loc_037FD614:
	.word 0x04804AA0	; 037FD614
pool_037FD618:
loc_037FD618:
	.word 0x04804958	; 037FD618
pool_037FD61C:
loc_037FD61C:
	.word 0x04804334	; 037FD61C
pool_037FD620:
loc_037FD620:
	.word 0x0230A899	; 037FD620
pool_037FD624:
loc_037FD624:
	.word 0x04804238	; 037FD624
pool_037FD628:
loc_037FD628:
	.word WifiRamBase + 0x234	; 037FD628
pool_037FD62C:
loc_037FD62C:
	.word WifiRamBase + 0x236	; 037FD62C
pool_037FD630:
loc_037FD630:
	.word WifiRamBase + 0x330	; 037FD630
pool_037FD634:
loc_037FD634:
	.word WifiRamBase + 0x332	; 037FD634
pool_037FD638:
loc_037FD638:
	.word WifiRamBase + 0x954	; 037FD638
pool_037FD63C:
loc_037FD63C:
	.word WifiRamBase + 0x956	; 037FD63C
pool_037FD640:
loc_037FD640:
	.word WifiRamBase + 0xA9C	; 037FD640
pool_037FD644:
loc_037FD644:
	.word WifiRamBase + 0xA9E	; 037FD644
pool_037FD648:
loc_037FD648:
	.word WifiRamBase + 0x10C0	; 037FD648
pool_037FD64C:
loc_037FD64C:
	.word WifiRamBase + 0x10C2	; 037FD64C
pool_037FD650:
loc_037FD650:
	.word 0x00000208	; 037FD650
pool_037FD654:
loc_037FD654:
	.word 0x048045D8	; 037FD654
pool_037FD658:
loc_037FD658:
	.word 0x04804490	; 037FD658
pool_037FD65C:
loc_037FD65C:
	.word 0x04804468	; 037FD65C
pool_037FD660:
loc_037FD660:
	.word WifiRamBase + 0x230	; 037FD660
pool_037FD664:
loc_037FD664:
	.word WifiRamBase + 0x232	; 037FD664
pool_037FD668:
loc_037FD668:
	.word WifiRamBase + 0x464	; 037FD668
pool_037FD66C:
loc_037FD66C:
	.word WifiRamBase + 0x466	; 037FD66C
pool_037FD670:
loc_037FD670:
	.word WifiRamBase + 0x48C	; 037FD670
pool_037FD674:
loc_037FD674:
	.word WifiRamBase + 0x48E	; 037FD674
pool_037FD678:
loc_037FD678:
	.word WifiRamBase + 0x5D4	; 037FD678
pool_037FD67C:
loc_037FD67C:
	.word WifiRamBase + 0x5D6	; 037FD67C
pool_037FD680:
loc_037FD680:
	.word WifiRamBase + 0xBF8	; 037FD680
pool_037FD684:
loc_037FD684:
	.word WifiRamBase + 0xBFA	; 037FD684
pool_037FD688:
loc_037FD688:
	.word 0x00000108	; 037FD688
pool_037FD68C:
loc_037FD68C:
	.word 0x00004000	; 037FD68C

; ===== function loc_037FD690 =====
loc_037FD690:
	bx pc	; 037FD690
	.byte 0xC0, 0x46	; 037FD694
.arm

; ===== function loc_037FD694 =====
loc_037FD694:
	ldr pc,[pool_037FD698]	; 037FD694
pool_037FD698:
loc_037FD698:
	.word loc_037FF30C	; 037FD698
.thumb

; ===== function loc_037FD69C =====
loc_037FD69C:
	bx pc	; 037FD69C
	.byte 0xC0, 0x46	; 037FD6A0
.arm

; ===== function loc_037FD6A0 =====
loc_037FD6A0:
	ldr r12,[pool_037FD6A8]	; 037FD6A0
	bx r12	; 037FD6A4
pool_037FD6A8:
loc_037FD6A8:
	.word P4_Entry_0230A0A8 + 1	; 037FD6A8
.thumb

; ===== function loc_037FD6AC =====
loc_037FD6AC:
	push {r4,r5,r6,lr}	; 037FD6AC
	sub sp,#0x8	; 037FD6AE
	ldr r0,[pool_037FD73C]	; 037FD6B0
	ldr r1,[r0,#0x0]	; 037FD6B2
	ldr r0,[pool_037FD740]	; 037FD6B4
	add r6,r1,r0	; 037FD6B6
	ldr r0,[pool_037FD744]	; 037FD6B8
	add r4,r1,r0	; 037FD6BA
	mov r0,#0x0	; 037FD6BC
	str r0,[sp,#0x0]	; 037FD6BE
	ldr r0,[sp,#0x0]	; 037FD6C0
	add r1,r4,#0x0	; 037FD6C2
	mov r2,#0x50	; 037FD6C4
	bl loc_037FD78C	; 037FD6C6
	ldr r1,[pool_037FD748]	; 037FD6CA
	ldr r0,[pool_037FD74C]	; 037FD6CC
	strh r1,[r0,#0x0]	; 037FD6CE
	ldr r0,[pool_037FD73C]	; 037FD6D0
	ldr r1,[r0,#0x0]	; 037FD6D2
	ldr r0,[pool_037FD750]	; 037FD6D4
	ldrh r0,[r1,r0]	; 037FD6D6
	cmp r0,#0x3	; 037FD6D8
	bhi loc_037FD700	; 037FD6DA
	add r0,r0,r0	; 037FD6DC
P2_SwitchIndexPC_037FD6DC:
	add r0,pc	; 037FD6DE
	ldrh r0,[r0,#(P2_SwitchTable_037FD6DC - (P2_SwitchIndexPC_037FD6DC + 4))]	; 037FD6E0
	lsl r0,r0,#0x10	; 037FD6E2
	asr r0,r0,#0x10	; 037FD6E4
P2_SwitchTargetPC_037FD6DC:
	add r0,pc	; 037FD6E6
	bx r0	; 037FD6E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD6DC:
	.halfword (loc_037FD6F2 + 1) - (P2_SwitchTargetPC_037FD6DC + 4)
	.halfword (loc_037FD6F6 + 1) - (P2_SwitchTargetPC_037FD6DC + 4)
	.halfword (loc_037FD6FA + 1) - (P2_SwitchTargetPC_037FD6DC + 4)
	.halfword (loc_037FD6FE + 1) - (P2_SwitchTargetPC_037FD6DC + 4)
P2_SwitchTable_037FD6DCEnd:
loc_037FD6F2:
	ldr r5,[pool_037FD754]	; 037FD6F2
	b loc_037FD700	; 037FD6F4
loc_037FD6F6:
	ldr r5,[pool_037FD758]	; 037FD6F6
	b loc_037FD700	; 037FD6F8
loc_037FD6FA:
	ldr r5,[pool_037FD75C]	; 037FD6FA
	b loc_037FD700	; 037FD6FC
loc_037FD6FE:
	ldr r5,[pool_037FD754]	; 037FD6FE
loc_037FD700:
	ldr r0,[pool_037FD760]	; 037FD700
	add r1,r5,r0	; 037FD702
	ldr r0,[pool_037FD764]	; 037FD704
	strh r1,[r0,#0x0]	; 037FD706
	lsl r0,r5,#0xf	; 037FD708
	lsr r2,r0,#0x10	; 037FD70A
	ldr r0,[pool_037FD768]	; 037FD70C
	strh r2,[r0,#0x0]	; 037FD70E
	ldr r1,[pool_037FD76C]	; 037FD710
	ldr r0,[pool_037FD770]	; 037FD712
	strh r1,[r0,#0x0]	; 037FD714
	ldr r0,[pool_037FD774]	; 037FD716
	strh r2,[r0,#0x0]	; 037FD718
	strh r2,[r4,#0x4]	; 037FD71A
	ldr r0,[pool_037FD778]	; 037FD71C
	strh r0,[r4,#0x0]	; 037FD71E
	ldr r0,[pool_037FD77C]	; 037FD720
	sub r0,r0,r5	; 037FD722
	add r6,#0x9a	; 037FD724
	strh r0,[r6,#0x0]	; 037FD726
	ldr r1,[pool_037FD780]	; 037FD728
	ldr r0,[pool_037FD784]	; 037FD72A
	strh r1,[r0,#0x0]	; 037FD72C
	ldr r1,[pool_037FD788]	; 037FD72E
	ldr r0,[pool_037FD74C]	; 037FD730
	strh r1,[r0,#0x0]	; 037FD732
	add sp,#0x8	; 037FD734
	pop {r4,r5,r6}	; 037FD736
	pop {r3}	; 037FD738
	bx r3	; 037FD73A
pool_037FD73C:
loc_037FD73C:
	.word FirmwareWlWorkPointerSlot	; 037FD73C
pool_037FD740:
loc_037FD740:
	.word 0x00000318	; 037FD740
pool_037FD744:
loc_037FD744:
	.word 0x000004B4	; 037FD744
pool_037FD748:
loc_037FD748:
	.word 0x00008000	; 037FD748
pool_037FD74C:
loc_037FD74C:
	.word REG_WIFI_RXCNT	; 037FD74C
pool_037FD750:
loc_037FD750:
	.word 0x00000324	; 037FD750
pool_037FD754:
loc_037FD754:
	.word 0x00000794	; 037FD754
pool_037FD758:
loc_037FD758:
	.word 0x000010C4	; 037FD758
pool_037FD75C:
loc_037FD75C:
	.word 0x00000BFC	; 037FD75C
pool_037FD760:
loc_037FD760:
	.word 0x04804000	; 037FD760
pool_037FD764:
loc_037FD764:
	.word REG_WIFI_RXBUF_BEGIN	; 037FD764
pool_037FD768:
loc_037FD768:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FD768
pool_037FD76C:
loc_037FD76C:
	.word 0x00005F60	; 037FD76C
pool_037FD770:
loc_037FD770:
	.word REG_WIFI_RXBUF_END	; 037FD770
pool_037FD774:
loc_037FD774:
	.word REG_WIFI_RXBUF_READCSR	; 037FD774
pool_037FD778:
loc_037FD778:
	.word 0x0000FFFF	; 037FD778
pool_037FD77C:
loc_037FD77C:
	.word 0x00001F60	; 037FD77C
pool_037FD780:
loc_037FD780:
	.word 0x00005F5E	; 037FD780
pool_037FD784:
loc_037FD784:
	.word REG_WIFI_RXBUF_GAP	; 037FD784
pool_037FD788:
loc_037FD788:
	.word 0x00008001	; 037FD788

; ===== function loc_037FD78C =====
loc_037FD78C:
	bx pc	; 037FD78C
	.byte 0xC0, 0x46	; 037FD790
.arm

; ===== function loc_037FD790 =====
loc_037FD790:
	ldr pc,[pool_037FD794]	; 037FD790
pool_037FD794:
loc_037FD794:
	.word loc_037FF30C	; 037FD794

; ===== function loc_037FD798 =====
; 取已启用的待处理中断，清除请求并调用对应回调。
; Select an enabled pending IRQ, acknowledge it and call its registered handler.
.func P2_DispatchIrq
	stmdb sp!,{lr}	; 037FD798
	mov r12,#0x4000000	; 037FD79C
	add r12,r12,#0x210	; 037FD7A0
	ldr r1,[r12,#-0x8]	; 037FD7A4
	cmp r1,#0x0	; 037FD7A8
	ldmeqia sp!,{pc}	; 037FD7AC
	ldmia r12,{r1,r2}	; 037FD7B0
	ands r1,r1,r2	; 037FD7B4
	ldmeqia sp!,{pc}	; 037FD7B8
	mov r3,#0x1	; 037FD7BC
	mov r0,#0x0	; 037FD7C0
loc_037FD7C4:
	ands r2,r1,r3, lsl r0	; 037FD7C4
	addeq r0,r0,#0x1	; 037FD7C8
	beq loc_037FD7C4	; 037FD7CC
	str r2,[r12,#0x4]	; 037FD7D0
	ldr r1,[pool_037FD7E4]	; 037FD7D4
	ldr r0,[r1,r0,lsl #0x2]	; 037FD7D8
	ldr lr,[pool_037FD7E8]	; 037FD7DC
	bx r0	; 037FD7E0
.endfunc
pool_037FD7E4:
loc_037FD7E4:
	.word P2_IrqHandlers	; 037FD7E4
pool_037FD7E8:
loc_037FD7E8:
	.word P2_IrqReturnContinuation	; 037FD7E8
; 中断回调返回后处理待执行状态，必要时保存并切换执行上下文。
; After the IRQ callback, process pending state and save/switch context when needed.
.func P2_IrqReturnContinuation
	ldr r12,[pool_037FD900]	; 037FD7EC
	ldrh r3,[r12,#0x0]	; 037FD7F0
	mov r0,#0x0	; 037FD7F4
	cmp r3,#0x0	; 037FD7F8
	beq P2_Entry_037FD834	; 037FD7FC
	strh r0,[r12,#0x0]	; 037FD800
	ldr r12,[pool_037FD904]	; 037FD804
	mov r1,#0x1	; 037FD808
	strh r1,[r12,#0x0]	; 037FD80C
	ldr r12,[r12,#0xc]	; 037FD810
	mov r2,#0x1	; 037FD814
P2_Entry_037FD818:
	cmp r12,#0x0	; 037FD818
	beq P2_Entry_037FD834	; 037FD81C
	ldr r0,[r12,#0x50]	; 037FD820
	tst r3,r1, lsl r0	; 037FD824
	strne r2,[r12,#0x48]	; 037FD828
	ldr r12,[r12,#0x4c]	; 037FD82C
	b P2_Entry_037FD818	; 037FD830
P2_Entry_037FD834:
	ldr r12,[pool_037FD904]	; 037FD834
	ldrh r1,[r12,#0x0]	; 037FD838
	cmp r1,#0x0	; 037FD83C
	ldreq pc,[sp],#0x4	; 037FD840
	mov r1,#0x0	; 037FD844
	strh r1,[r12,#0x0]	; 037FD848
	mov r3,#0xd2	; 037FD84C
	msr cpsr_c,r3	; 037FD850
	add r2,r12,#0xc	; 037FD854
	ldr r1,[r2,#0x0]	; 037FD858
P2_Entry_037FD85C:
	cmp r1,#0x0	; 037FD85C
	ldrneh r0,[r1,#0x48]	; 037FD860
	cmpne r0,#0x1	; 037FD864
	ldrne r1,[r1,#0x4c]	; 037FD868
	bne P2_Entry_037FD85C	; 037FD86C
	cmp r1,#0x0	; 037FD870
	bne P2_Entry_037FD884	; 037FD874
P2_Entry_037FD878:
	mov r3,#0x92	; 037FD878
	msr cpsr_c,r3	; 037FD87C
	ldr pc,[sp],#0x4	; 037FD880
P2_Entry_037FD884:
	ldr r0,[r12,#0x8]	; 037FD884
	cmp r1,r0	; 037FD888
	beq P2_Entry_037FD878	; 037FD88C
	ldr r3,[r12,#0x10]	; 037FD890
	cmp r3,#0x0	; 037FD894
	beq P2_Entry_037FD8AC	; 037FD898
	stmdb sp!,{r0,r1,r12}	; 037FD89C
	mov lr,pc	; 037FD8A0
	bx r3	; 037FD8A4
	ldmia sp!,{r0,r1,r12}	; 037FD8A8
P2_Entry_037FD8AC:
	str r1,[r12,#0x8]	; 037FD8AC
	mrs r2,spsr	; 037FD8B0
	str r2,[r0,#0x0]!	; 037FD8B4
	ldmib sp!,{r2,r3}	; 037FD8B8
	stmib r0!,{r2,r3}	; 037FD8BC
	ldmib sp!,{r2,r3,r12,lr}	; 037FD8C0
	stmib r0!,{r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FD8C4
	stmib r0!,{lr}	; 037FD8C8
	mov r3,#0xd3	; 037FD8CC
	msr cpsr_c,r3	; 037FD8D0
	stmib r0!,{sp}	; 037FD8D4
	ldr sp,[r1,#0x44]	; 037FD8D8
	mov r3,#0xd2	; 037FD8DC
	msr cpsr_c,r3	; 037FD8E0
	ldr r2,[r1,#0x0]!	; 037FD8E4
	msr spsr_cf,r2	; 037FD8E8
	ldr lr,[r1,#0x40]	; 037FD8EC
	ldmib r1!,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FD8F0
	mov r0,r0	; 037FD8F4
	stmda sp!,{r0,r1,r2,r3,r12,lr}	; 037FD8F8
	ldmia sp!,{pc}	; 037FD8FC
.endfunc
pool_037FD900:
	.word P2_BssStart + 0x4C8	; 037FD900
pool_037FD904:
	.word P2_BssStart + 0x548	; 037FD904
.thumb
P2_IrqHandler_037FD908:
	push {lr}	; 037FD908
	sub sp,#0x4	; 037FD90A
	ldr r0,[pool_037FD930]	; 037FD90C
	ldr r2,[r0,#0x60]	; 037FD90E
	ldr r1,[pool_037FD934]	; 037FD910
	ldr r0,[r1,#0x0]	; 037FD912
	add r0,r0,#0x1	; 037FD914
	str r0,[r1,#0x0]	; 037FD916
	cmp r2,#0x0	; 037FD918
	beq P2_Entry_037FD920	; 037FD91A
	bl loc_03805048	; 037FD91C
P2_Entry_037FD920:
	ldr r2,[pool_037FD938]	; 037FD920
	ldr r1,[r2,#0x0]	; 037FD922
	mov r0,#0x1	; 037FD924
	orr r1,r0	; 037FD926
	str r1,[r2,#0x0]	; 037FD928
	add sp,#0x4	; 037FD92A
	pop {r3}	; 037FD92C
	bx r3	; 037FD92E
pool_037FD930:
	.word P2_BssStart + 0x4CC	; 037FD930
pool_037FD934:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FD934
pool_037FD938:
	.word Bios7IrqFlagsAddress	; 037FD938
.arm
.thumb
P2_IrqHandler_037FD93C:
	mov r0,#0x7	; 037FD93C
	ldr r3,[pool_037FD944]	; 037FD93E
	bx r3	; 037FD940
	.byte 0xC0, 0x46	; 037FD944
pool_037FD944:
loc_037FD944:
	.word loc_037FD99C + 1	; 037FD944
P2_IrqHandler_037FD948:
	mov r0,#0x6	; 037FD948
	ldr r3,[pool_037FD950]	; 037FD94A
	bx r3	; 037FD94C
	.byte 0xC0, 0x46	; 037FD950
pool_037FD950:
loc_037FD950:
	.word loc_037FD99C + 1	; 037FD950
P2_IrqHandler_037FD954:
	mov r0,#0x5	; 037FD954
	ldr r3,[pool_037FD95C]	; 037FD956
	bx r3	; 037FD958
	.byte 0xC0, 0x46	; 037FD95C
pool_037FD95C:
loc_037FD95C:
	.word loc_037FD99C + 1	; 037FD95C
P2_IrqHandler_037FD960:
	mov r0,#0x4	; 037FD960
	ldr r3,[pool_037FD968]	; 037FD962
	bx r3	; 037FD964
	.byte 0xC0, 0x46	; 037FD968
pool_037FD968:
loc_037FD968:
	.word loc_037FD99C + 1	; 037FD968
P2_IrqHandler_037FD96C:
	mov r0,#0x3	; 037FD96C
	ldr r3,[pool_037FD974]	; 037FD96E
	bx r3	; 037FD970
	.byte 0xC0, 0x46	; 037FD974
pool_037FD974:
loc_037FD974:
	.word loc_037FD99C + 1	; 037FD974
P2_IrqHandler_037FD978:
	mov r0,#0x2	; 037FD978
	ldr r3,[pool_037FD980]	; 037FD97A
	bx r3	; 037FD97C
	.byte 0xC0, 0x46	; 037FD980
pool_037FD980:
loc_037FD980:
	.word loc_037FD99C + 1	; 037FD980
P2_IrqHandler_037FD984:
	mov r0,#0x1	; 037FD984
	ldr r3,[pool_037FD98C]	; 037FD986
	bx r3	; 037FD988
	.byte 0xC0, 0x46	; 037FD98C
pool_037FD98C:
loc_037FD98C:
	.word loc_037FD99C + 1	; 037FD98C
P2_IrqHandler_037FD990:
	mov r0,#0x0	; 037FD990
	ldr r3,[pool_037FD998]	; 037FD992
	bx r3	; 037FD994
	.byte 0xC0, 0x46	; 037FD998
pool_037FD998:
loc_037FD998:
	.word loc_037FD99C + 1	; 037FD998
loc_037FD99C:
	push {r4,r5,lr}	; 037FD99C
	sub sp,#0x4	; 037FD99E
	mov r5,#0x1	; 037FD9A0
	lsl r2,r0,#0x1	; 037FD9A2
	ldr r1,[pool_037FD9E4]	; 037FD9A4
	ldrh r1,[r1,r2]	; 037FD9A6
	lsl r5,r1	; 037FD9A8
	mov r1,#0xc	; 037FD9AA
	add r4,r0,#0x0	; 037FD9AC
	mul r4,r1	; 037FD9AE
	ldr r2,[pool_037FD9E8]	; 037FD9B0
	ldr r1,[r2,r4]	; 037FD9B2
	mov r0,#0x0	; 037FD9B4
	str r0,[r2,r4]	; 037FD9B6
	cmp r1,#0x0	; 037FD9B8
	beq loc_037FD9C4	; 037FD9BA
	ldr r0,[pool_037FD9EC]	; 037FD9BC
	ldr r0,[r0,r4]	; 037FD9BE
	bl loc_03805044	; 037FD9C0
loc_037FD9C4:
	ldr r1,[pool_037FD9F0]	; 037FD9C4
	ldr r0,[r1,#0x0]	; 037FD9C6
	orr r0,r5	; 037FD9C8
	str r0,[r1,#0x0]	; 037FD9CA
	ldr r0,[pool_037FD9F4]	; 037FD9CC
	ldr r0,[r0,r4]	; 037FD9CE
	cmp r0,#0x0	; 037FD9D0
	bne loc_037FD9DA	; 037FD9D2
	add r0,r5,#0x0	; 037FD9D4
	bl loc_037FDA20	; 037FD9D6
loc_037FD9DA:
	add sp,#0x4	; 037FD9DA
	pop {r4,r5}	; 037FD9DC
	pop {r3}	; 037FD9DE
	bx r3	; 037FD9E0
	.byte 0xC0, 0x46	; 037FD9E4
pool_037FD9E4:
loc_037FD9E4:
	.word P2_Data_0380521C	; 037FD9E4
pool_037FD9E8:
loc_037FD9E8:
	.word P2_BssStart + 0x4CC	; 037FD9E8
pool_037FD9EC:
loc_037FD9EC:
	.word P2_BssStart + 0x4D4	; 037FD9EC
pool_037FD9F0:
loc_037FD9F0:
	.word Bios7IrqFlagsAddress	; 037FD9F0
pool_037FD9F4:
loc_037FD9F4:
	.word P2_BssStart + 0x4D0	; 037FD9F4
loc_037FD9F8:
	bx lr	; 037FD9F8
	.byte 0x00, 0x00	; 037FD9FC

; ===== function loc_037FD9FC =====
loc_037FD9FC:
	push {r4,lr}	; 037FD9FC
	ldr r4,[pool_037FDA18]	; 037FD9FE
	ldrh r3,[r4,#0x0]	; 037FDA00
	mov r1,#0x0	; 037FDA02
	strh r1,[r4,#0x0]	; 037FDA04
	ldr r2,[pool_037FDA1C]	; 037FDA06
	ldr r1,[r2,#0x0]	; 037FDA08
	str r0,[r2,#0x0]	; 037FDA0A
	ldrh r0,[r4,#0x0]	; 037FDA0C
	strh r3,[r4,#0x0]	; 037FDA0E
	add r0,r1,#0x0	; 037FDA10
	pop {r4}	; 037FDA12
	pop {r3}	; 037FDA14
	bx r3	; 037FDA16
pool_037FDA18:
loc_037FDA18:
	.word REG_IME	; 037FDA18
pool_037FDA1C:
loc_037FDA1C:
	.word REG_IF	; 037FDA1C

; ===== function loc_037FDA20 =====
loc_037FDA20:
	push {r4,r5,lr}	; 037FDA20
	sub sp,#0x4	; 037FDA22
	ldr r5,[pool_037FDA44]	; 037FDA24
	ldrh r4,[r5,#0x0]	; 037FDA26
	mov r1,#0x0	; 037FDA28
	strh r1,[r5,#0x0]	; 037FDA2A
	ldr r3,[pool_037FDA48]	; 037FDA2C
	ldr r2,[r3,#0x0]	; 037FDA2E
	add r1,r2,#0x0	; 037FDA30
	bic r1,r0	; 037FDA32
	str r1,[r3,#0x0]	; 037FDA34
	ldrh r0,[r5,#0x0]	; 037FDA36
	strh r4,[r5,#0x0]	; 037FDA38
	add r0,r2,#0x0	; 037FDA3A
	add sp,#0x4	; 037FDA3C
	pop {r4,r5}	; 037FDA3E
	pop {r3}	; 037FDA40
	bx r3	; 037FDA42
pool_037FDA44:
loc_037FDA44:
	.word REG_IME	; 037FDA44
pool_037FDA48:
loc_037FDA48:
	.word REG_IE	; 037FDA48

; ===== function loc_037FDA4C =====
loc_037FDA4C:
	push {r4,r5,lr}	; 037FDA4C
	sub sp,#0x4	; 037FDA4E
	ldr r5,[pool_037FDA70]	; 037FDA50
	ldrh r4,[r5,#0x0]	; 037FDA52
	mov r1,#0x0	; 037FDA54
	strh r1,[r5,#0x0]	; 037FDA56
	ldr r3,[pool_037FDA74]	; 037FDA58
	ldr r2,[r3,#0x0]	; 037FDA5A
	add r1,r2,#0x0	; 037FDA5C
	orr r1,r0	; 037FDA5E
	str r1,[r3,#0x0]	; 037FDA60
	ldrh r0,[r5,#0x0]	; 037FDA62
	strh r4,[r5,#0x0]	; 037FDA64
	add r0,r2,#0x0	; 037FDA66
	add sp,#0x4	; 037FDA68
	pop {r4,r5}	; 037FDA6A
	pop {r3}	; 037FDA6C
	bx r3	; 037FDA6E
pool_037FDA70:
loc_037FDA70:
	.word REG_IME	; 037FDA70
pool_037FDA74:
loc_037FDA74:
	.word REG_IE	; 037FDA74

; ===== function loc_037FDA78 =====
loc_037FDA78:
	push {r4,lr}	; 037FDA78
	ldr r4,[pool_037FDA94]	; 037FDA7A
	ldrh r3,[r4,#0x0]	; 037FDA7C
	mov r1,#0x0	; 037FDA7E
	strh r1,[r4,#0x0]	; 037FDA80
	ldr r2,[pool_037FDA98]	; 037FDA82
	ldr r1,[r2,#0x0]	; 037FDA84
	str r0,[r2,#0x0]	; 037FDA86
	ldrh r0,[r4,#0x0]	; 037FDA88
	strh r3,[r4,#0x0]	; 037FDA8A
	add r0,r1,#0x0	; 037FDA8C
	pop {r4}	; 037FDA8E
	pop {r3}	; 037FDA90
	bx r3	; 037FDA92
pool_037FDA94:
loc_037FDA94:
	.word REG_IME	; 037FDA94
pool_037FDA98:
loc_037FDA98:
	.word REG_IE	; 037FDA98

; ===== function loc_037FDA9C =====
loc_037FDA9C:
	push {r4,lr}	; 037FDA9C
	mov r3,#0xc	; 037FDA9E
	add r4,r0,#0x0	; 037FDAA0
	mul r4,r3	; 037FDAA2
	ldr r3,[pool_037FDAC4]	; 037FDAA4
	str r1,[r3,r4]	; 037FDAA6
	ldr r1,[pool_037FDAC8]	; 037FDAA8
	str r2,[r1,r4]	; 037FDAAA
	mov r1,#0x1	; 037FDAAC
	add r0,r0,#0x3	; 037FDAAE
	lsl r1,r0	; 037FDAB0
	add r0,r1,#0x0	; 037FDAB2
	bl loc_037FDA4C	; 037FDAB4
	mov r1,#0x1	; 037FDAB8
	ldr r0,[pool_037FDACC]	; 037FDABA
	str r1,[r0,r4]	; 037FDABC
	pop {r4}	; 037FDABE
	pop {r3}	; 037FDAC0
	bx r3	; 037FDAC2
pool_037FDAC4:
loc_037FDAC4:
	.word P2_BssStart + 0x4FC	; 037FDAC4
pool_037FDAC8:
loc_037FDAC8:
	.word P2_BssStart + 0x504	; 037FDAC8
pool_037FDACC:
loc_037FDACC:
	.word P2_BssStart + 0x500	; 037FDACC

; ===== function loc_037FDAD0 =====
loc_037FDAD0:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P2_SetIrqHandlers
	push {r4,r5,r6,r7,lr}	; 037FDAD0
	sub sp,#0x4	; 037FDAD2
	mov r5,#0x0	; 037FDAD4
	add r3,r5,#0x0	; 037FDAD6
	add r2,r5,#0x0	; 037FDAD8
loc_037FDADA:
	add r6,r0,#0x0	; 037FDADA
	mov r4,#0x1	; 037FDADC
	and r6,r4	; 037FDADE
	cmp r6,#0x0	; 037FDAE0
	beq loc_037FDB2A	; 037FDAE2
	add r4,r3,#0x0	; 037FDAE4
	cmp r5,#0x8	; 037FDAE6
	blt loc_037FDAFC	; 037FDAE8
	cmp r5,#0xb	; 037FDAEA
	bgt loc_037FDAFC	; 037FDAEC
	add r6,r5,#0x0	; 037FDAEE
	sub r6,#0x8	; 037FDAF0
	mov r4,#0xc	; 037FDAF2
	mul r6,r4	; 037FDAF4
	ldr r4,[pool_037FDB3C]	; 037FDAF6
	add r4,r4,r6	; 037FDAF8
	b loc_037FDB1E	; 037FDAFA
loc_037FDAFC:
	cmp r5,#0x3	; 037FDAFC
	blt loc_037FDB10	; 037FDAFE
	cmp r5,#0x6	; 037FDB00
	bgt loc_037FDB10	; 037FDB02
	add r6,r5,#0x1	; 037FDB04
	mov r4,#0xc	; 037FDB06
	mul r6,r4	; 037FDB08
	ldr r4,[pool_037FDB3C]	; 037FDB0A
	add r4,r4,r6	; 037FDB0C
	b loc_037FDB1E	; 037FDB0E
loc_037FDB10:
	cmp r5,#0x0	; 037FDB10
	bne loc_037FDB18	; 037FDB12
	ldr r4,[pool_037FDB40]	; 037FDB14
	b loc_037FDB1E	; 037FDB16
loc_037FDB18:
	lsl r7,r5,#0x2	; 037FDB18
	ldr r6,[pool_037FDB44]	; 037FDB1A
	str r1,[r6,r7]	; 037FDB1C
loc_037FDB1E:
	cmp r4,#0x0	; 037FDB1E
	beq loc_037FDB2A	; 037FDB20
	str r1,[r4,#0x0]	; 037FDB22
	str r2,[r4,#0x8]	; 037FDB24
	mov r6,#0x1	; 037FDB26
	str r6,[r4,#0x4]	; 037FDB28
loc_037FDB2A:
	lsr r0,r0,#0x1	; 037FDB2A
	add r5,r5,#0x1	; 037FDB2C
	cmp r5,#0x19	; 037FDB2E
	blt loc_037FDADA	; 037FDB30
	add sp,#0x4	; 037FDB32
	pop {r4,r5,r6,r7}	; 037FDB34
	pop {r3}	; 037FDB36
	bx r3	; 037FDB38
.endfunc
	.byte 0xC0, 0x46	; 037FDB3C
pool_037FDB3C:
loc_037FDB3C:
	.word 0x03805820	; 037FDB3C
pool_037FDB40:
loc_037FDB40:
	.word 0x03805880	; 037FDB40
pool_037FDB44:
loc_037FDB44:
	.word P2_IrqHandlers	; 037FDB44

; ===== function loc_037FDB48 =====
loc_037FDB48:
	mov r1,#0x0	; 037FDB48
	ldr r0,[pool_037FDB54]	; 037FDB4A
	strh r1,[r0,#0x0]	; 037FDB4C
	ldr r0,[pool_037FDB58]	; 037FDB4E
	str r1,[r0,#0x0]	; 037FDB50
	bx lr	; 037FDB52
pool_037FDB54:
loc_037FDB54:
	.word P2_BssStart + 0x4C8	; 037FDB54
pool_037FDB58:
loc_037FDB58:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FDB58

; ===== function loc_037FDB5C =====
loc_037FDB5C:
	ldr r1,[pool_037FDB60]	; 037FDB5C
	bx r1	; 037FDB5E
pool_037FDB60:
loc_037FDB60:
	.word loc_037FDC14 + 1	; 037FDB60
.arm

; ===== function loc_037FDB64 =====
loc_037FDB64:
	ldr r3,[pool_037FDBF4]	; 037FDB64
	ldr r1,[r3,#0x0]	; 037FDB68
	mov r2,#0x0	; 037FDB6C
	mov r0,#0x80000000	; 037FDB70
loc_037FDB74:
	tst r1,r0	; 037FDB74
	bne loc_037FDB90	; 037FDB78
	add r2,r2,#0x1	; 037FDB7C
	cmp r2,#0x20	; 037FDB80
	beq loc_037FDB90	; 037FDB84
	mov r0,r0, lsr #0x1	; 037FDB88
	b loc_037FDB74	; 037FDB8C
loc_037FDB90:
	cmp r2,#0x20	; 037FDB90
	movne r0,#0x80	; 037FDB94
	bne loc_037FDBD8	; 037FDB98
	add r3,r3,#0x4	; 037FDB9C
	ldr r1,[r3,#0x0]	; 037FDBA0
	mov r2,#0x0	; 037FDBA4
	mov r0,#0x80000000	; 037FDBA8
loc_037FDBAC:
	tst r1,r0	; 037FDBAC
	bne loc_037FDBC8	; 037FDBB0
	add r2,r2,#0x1	; 037FDBB4
	cmp r2,#0x20	; 037FDBB8
	beq loc_037FDBC8	; 037FDBBC
	mov r0,r0, lsr #0x1	; 037FDBC0
	b loc_037FDBAC	; 037FDBC4
loc_037FDBC8:
	cmp r2,#0x20	; 037FDBC8
	ldr r0,[pool_037FDBF8]	; 037FDBCC
	bxeq lr	; 037FDBD0
	mov r0,#0xa0	; 037FDBD4
loc_037FDBD8:
	add r0,r0,r2	; 037FDBD8
	mov r1,#0x80000000	; 037FDBDC
	mov r1,r1, lsr r2	; 037FDBE0
	ldr r2,[r3,#0x0]	; 037FDBE4
	bic r2,r2,r1	; 037FDBE8
	str r2,[r3,#0x0]	; 037FDBEC
	bx lr	; 037FDBF0
pool_037FDBF4:
loc_037FDBF4:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FDBF4
pool_037FDBF8:
loc_037FDBF8:
	.word 0xFFFFFFFD	; 037FDBF8
.thumb

; ===== function loc_037FDBFC =====
loc_037FDBFC:
	ldr r0,[pool_037FDC04]	; 037FDBFC
	ldr r3,[pool_037FDC08]	; 037FDBFE
	bx r3	; 037FDC00
	.byte 0xC0, 0x46	; 037FDC04
pool_037FDC04:
loc_037FDC04:
	.word 0x00001000	; 037FDC04
pool_037FDC08:
loc_037FDC08:
	.word loc_037FF184 + 1	; 037FDC08
	.byte 0x70, 0x47, 0x00, 0x00, 0x70, 0x47, 0x00, 0x00	; 037FDC14

; ===== function loc_037FDC14 =====
loc_037FDC14:
	ldr r1,[pool_037FDC1C]	; 037FDC14
	ldr r2,[pool_037FDC20]	; 037FDC16
	ldr r3,[pool_037FDC24]	; 037FDC18
	bx r3	; 037FDC1A
pool_037FDC1C:
loc_037FDC1C:
	.word 0x027FFFE0	; 037FDC1C
pool_037FDC20:
loc_037FDC20:
	.word 0x037FDC0D	; 037FDC20
pool_037FDC24:
loc_037FDC24:
	.word loc_037FDCDC + 1	; 037FDC24

; ===== function loc_037FDC28 =====
loc_037FDC28:
	ldr r1,[pool_037FDC30]	; 037FDC28
	ldr r2,[pool_037FDC34]	; 037FDC2A
	ldr r3,[pool_037FDC38]	; 037FDC2C
	bx r3	; 037FDC2E
pool_037FDC30:
loc_037FDC30:
	.word 0x027FFFE0	; 037FDC30
pool_037FDC34:
loc_037FDC34:
	.word 0x037FDC11	; 037FDC34
pool_037FDC38:
loc_037FDC38:
	.word loc_037FDD40 + 1	; 037FDC38

; ===== function loc_037FDC3C =====
loc_037FDC3C:
	push {r4,r5,r6,r7,lr}	; 037FDC3C
	sub sp,#0xc	; 037FDC3E
	add r5,r0,#0x0	; 037FDC40
	add r6,r1,#0x0	; 037FDC42
	add r4,r2,#0x0	; 037FDC44
	add r7,r3,#0x0	; 037FDC46
	cmp r7,#0x0	; 037FDC48
	beq loc_037FDC54	; 037FDC4A
	bl loc_037FDC90	; 037FDC4C
	str r0,[sp,#0x0]	; 037FDC50
	b loc_037FDC5A	; 037FDC52
loc_037FDC54:
	bl loc_037FDC9C	; 037FDC54
	str r0,[sp,#0x0]	; 037FDC58
loc_037FDC5A:
	add r0,r5,#0x0	; 037FDC5A
	add r1,r6,#0x0	; 037FDC5C
	bl loc_037FDCA8	; 037FDC5E
	str r0,[sp,#0x4]	; 037FDC62
	cmp r0,#0x0	; 037FDC64
	bne loc_037FDC72	; 037FDC66
	cmp r4,#0x0	; 037FDC68
	beq loc_037FDC70	; 037FDC6A
	bl loc_03805050	; 037FDC6C
loc_037FDC70:
	strh r5,[r6,#0x4]	; 037FDC70
loc_037FDC72:
	cmp r7,#0x0	; 037FDC72
	beq loc_037FDC7E	; 037FDC74
	ldr r0,[sp,#0x0]	; 037FDC76
	bl loc_037FDCB4	; 037FDC78
	b loc_037FDC84	; 037FDC7C
loc_037FDC7E:
	ldr r0,[sp,#0x0]	; 037FDC7E
	bl loc_037FDCC0	; 037FDC80
loc_037FDC84:
	ldr r0,[sp,#0x4]	; 037FDC84
	add sp,#0xc	; 037FDC86
	pop {r4,r5,r6,r7}	; 037FDC88
	pop {r3}	; 037FDC8A
	bx r3	; 037FDC8C
	.byte 0xC0, 0x46	; 037FDC90

; ===== function loc_037FDC90 =====
loc_037FDC90:
	bx pc	; 037FDC90
	.byte 0xC0, 0x46	; 037FDC94
.arm

; ===== function loc_037FDC94 =====
loc_037FDC94:
	ldr pc,[pool_037FDC98]	; 037FDC94
pool_037FDC98:
loc_037FDC98:
	.word loc_037FF0EC	; 037FDC98
.thumb

; ===== function loc_037FDC9C =====
loc_037FDC9C:
	bx pc	; 037FDC9C
	.byte 0xC0, 0x46	; 037FDCA0
.arm

; ===== function loc_037FDCA0 =====
loc_037FDCA0:
	ldr pc,[pool_037FDCA4]	; 037FDCA0
pool_037FDCA4:
loc_037FDCA4:
	.word loc_037FF0C0	; 037FDCA4
.thumb

; ===== function loc_037FDCA8 =====
loc_037FDCA8:
	bx pc	; 037FDCA8
	.byte 0xC0, 0x46	; 037FDCAC
.arm

; ===== function loc_037FDCAC =====
loc_037FDCAC:
	ldr pc,[pool_037FDCB0]	; 037FDCAC
pool_037FDCB0:
loc_037FDCB0:
	.word loc_037FF3B8	; 037FDCB0
.thumb

; ===== function loc_037FDCB4 =====
loc_037FDCB4:
	bx pc	; 037FDCB4
	.byte 0xC0, 0x46	; 037FDCB8
.arm

; ===== function loc_037FDCB8 =====
loc_037FDCB8:
	ldr pc,[pool_037FDCBC]	; 037FDCB8
pool_037FDCBC:
loc_037FDCBC:
	.word loc_037FF100	; 037FDCBC
.thumb

; ===== function loc_037FDCC0 =====
loc_037FDCC0:
	bx pc	; 037FDCC0
	.byte 0xC0, 0x46	; 037FDCC4
.arm

; ===== function loc_037FDCC4 =====
loc_037FDCC4:
	ldr pc,[pool_037FDCC8]	; 037FDCC4
pool_037FDCC8:
loc_037FDCC8:
	.word loc_037FF0D4	; 037FDCC8
.thumb

; ===== function loc_037FDCCC =====
loc_037FDCCC:
	push {lr}	; 037FDCCC
	sub sp,#0x4	; 037FDCCE
	mov r3,#0x0	; 037FDCD0
	bl loc_037FDCEC	; 037FDCD2
	add sp,#0x4	; 037FDCD6
	pop {r3}	; 037FDCD8
	bx r3	; 037FDCDA
loc_037FDCDC:
	push {lr}	; 037FDCDC
	sub sp,#0x4	; 037FDCDE
	mov r3,#0x0	; 037FDCE0
	bl loc_037FDCEC	; 037FDCE2
	add sp,#0x4	; 037FDCE6
	pop {r3}	; 037FDCE8
	bx r3	; 037FDCEA

; ===== function loc_037FDCEC =====
loc_037FDCEC:
	push {r4,r5,r6,r7,lr}	; 037FDCEC
	sub sp,#0x4	; 037FDCEE
	add r5,r1,#0x0	; 037FDCF0
	add r4,r2,#0x0	; 037FDCF2
	add r6,r3,#0x0	; 037FDCF4
	ldrh r1,[r5,#0x4]	; 037FDCF6
	cmp r0,r1	; 037FDCF8
	beq loc_037FDD02	; 037FDCFA
	mov r0,#0x1	; 037FDCFC
	mvn r0,r0	; 037FDCFE
	b loc_037FDD38	; 037FDD00
loc_037FDD02:
	cmp r6,#0x0	; 037FDD02
	beq loc_037FDD0E	; 037FDD04
	bl loc_037FDC90	; 037FDD06
	add r7,r0,#0x0	; 037FDD0A
	b loc_037FDD14	; 037FDD0C
loc_037FDD0E:
	bl loc_037FDC9C	; 037FDD0E
	add r7,r0,#0x0	; 037FDD12
loc_037FDD14:
	mov r0,#0x0	; 037FDD14
	strh r0,[r5,#0x4]	; 037FDD16
	cmp r4,#0x0	; 037FDD18
	beq loc_037FDD20	; 037FDD1A
	bl loc_03805050	; 037FDD1C
loc_037FDD20:
	mov r0,#0x0	; 037FDD20
	str r0,[r5,#0x0]	; 037FDD22
	cmp r6,#0x0	; 037FDD24
	beq loc_037FDD30	; 037FDD26
	add r0,r7,#0x0	; 037FDD28
	bl loc_037FDCB4	; 037FDD2A
	b loc_037FDD36	; 037FDD2E
loc_037FDD30:
	add r0,r7,#0x0	; 037FDD30
	bl loc_037FDCC0	; 037FDD32
loc_037FDD36:
	mov r0,#0x0	; 037FDD36
loc_037FDD38:
	add sp,#0x4	; 037FDD38
	pop {r4,r5,r6,r7}	; 037FDD3A
	pop {r3}	; 037FDD3C
	bx r3	; 037FDD3E

; ===== function loc_037FDD40 =====
loc_037FDD40:
	push {lr}	; 037FDD40
	sub sp,#0x4	; 037FDD42
	mov r3,#0x0	; 037FDD44
	bl loc_037FDD50	; 037FDD46
	add sp,#0x4	; 037FDD4A
	pop {r3}	; 037FDD4C
	bx r3	; 037FDD4E

; ===== function loc_037FDD50 =====
loc_037FDD50:
	push {r4,r5,r6,r7,lr}	; 037FDD50
	sub sp,#0x4	; 037FDD52
	add r5,r0,#0x0	; 037FDD54
	add r4,r1,#0x0	; 037FDD56
	add r6,r2,#0x0	; 037FDD58
	add r7,r3,#0x0	; 037FDD5A
	b loc_037FDD62	; 037FDD5C
loc_037FDD5E:
	bl loc_037FDBFC	; 037FDD5E
loc_037FDD62:
	add r0,r5,#0x0	; 037FDD62
	add r1,r4,#0x0	; 037FDD64
	add r2,r6,#0x0	; 037FDD66
	add r3,r7,#0x0	; 037FDD68
	bl loc_037FDC3C	; 037FDD6A
	cmp r0,#0x0	; 037FDD6E
	bgt loc_037FDD5E	; 037FDD70
	add sp,#0x4	; 037FDD72
	pop {r4,r5,r6,r7}	; 037FDD74
	pop {r3}	; 037FDD76
	bx r3	; 037FDD78
	.byte 0x00, 0x00	; 037FDD7C

; ===== function loc_037FDD7C =====
loc_037FDD7C:
	push {r4,lr}	; 037FDD7C
	ldr r0,[pool_037FDDB4]	; 037FDD7E
	ldr r1,[r0,#0x0]	; 037FDD80
	cmp r1,#0x0	; 037FDD82
	bne loc_037FDDAE	; 037FDD84
	mov r1,#0x1	; 037FDD86
	str r1,[r0,#0x0]	; 037FDD88
	mov r0,#0x0	; 037FDD8A
	ldr r4,[pool_037FDDB8]	; 037FDD8C
	strh r0,[r4,#0x6]	; 037FDD8E
	b loc_037FDD96	; 037FDD90
loc_037FDD92:
	bl loc_037FDBFC	; 037FDD92
loc_037FDD96:
	ldrh r0,[r4,#0x4]	; 037FDD96
	cmp r0,#0x7f	; 037FDD98
	bne loc_037FDD92	; 037FDD9A
	mov r0,#0x0	; 037FDD9C
	mvn r1,r0	; 037FDD9E
	ldr r0,[pool_037FDDBC]	; 037FDDA0
	str r1,[r0,#0x0]	; 037FDDA2
	ldr r1,[pool_037FDDC0]	; 037FDDA4
	ldr r0,[pool_037FDDC4]	; 037FDDA6
	str r1,[r0,#0x0]	; 037FDDA8
	mov r0,#0xbf	; 037FDDAA
	strh r0,[r4,#0x6]	; 037FDDAC
loc_037FDDAE:
	pop {r4}	; 037FDDAE
	pop {r3}	; 037FDDB0
	bx r3	; 037FDDB2
pool_037FDDB4:
loc_037FDDB4:
	.word P2_BssStart + 0x538	; 037FDDB4
pool_037FDDB8:
loc_037FDDB8:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 037FDDB8
pool_037FDDBC:
loc_037FDDBC:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FDDBC
pool_037FDDC0:
loc_037FDDC0:
	.word 0xFFFF0000	; 037FDDC0
pool_037FDDC4:
loc_037FDDC4:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset + 0x4	; 037FDDC4
	.byte 0x70, 0x47, 0x00, 0x00	; 037FDDCC

; ===== function loc_037FDDCC =====
loc_037FDDCC:
	push {r4,r5,lr}	; 037FDDCC
	sub sp,#0x4	; 037FDDCE
	add r5,r0,#0x0	; 037FDDD0
	bl loc_037FDC9C	; 037FDDD2
	ldr r1,[pool_037FDDEC]	; 037FDDD6
	ldr r4,[r1,#0x10]	; 037FDDD8
	str r5,[r1,#0x10]	; 037FDDDA
	bl loc_037FDCC0	; 037FDDDC
	add r0,r4,#0x0	; 037FDDE0
	add sp,#0x4	; 037FDDE2
	pop {r4,r5}	; 037FDDE4
	pop {r3}	; 037FDDE6
	bx r3	; 037FDDE8
	.byte 0xC0, 0x46	; 037FDDEC
pool_037FDDEC:
loc_037FDDEC:
	.word P2_BssStart + 0x548	; 037FDDEC

; ===== function loc_037FDDF0 =====
loc_037FDDF0:
	push {r4,r5,r6,lr}	; 037FDDF0
	ldr r6,[pool_037FDE54]	; 037FDDF2
	ldrh r0,[r6,#0x4]	; 037FDDF4
	cmp r0,#0x0	; 037FDDF6
	bne loc_037FDE02	; 037FDDF8
	bl loc_037FDE60	; 037FDDFA
	cmp r0,#0x12	; 037FDDFE
	bne loc_037FDE08	; 037FDE00
loc_037FDE02:
	mov r0,#0x1	; 037FDE02
	strh r0,[r6,#0x0]	; 037FDE04
	b loc_037FDE4E	; 037FDE06
loc_037FDE08:
	ldr r0,[pool_037FDE58]	; 037FDE08
	ldr r0,[r0,#0x0]	; 037FDE0A
	ldr r5,[r0,#0x0]	; 037FDE0C
	bl loc_037FDE84	; 037FDE0E
	add r4,r0,#0x0	; 037FDE12
	cmp r5,r4	; 037FDE14
	beq loc_037FDE4E	; 037FDE16
	cmp r4,#0x0	; 037FDE18
	beq loc_037FDE4E	; 037FDE1A
	add r0,r5,#0x0	; 037FDE1C
	bl loc_037FDE6C	; 037FDE1E
	cmp r0,#0x0	; 037FDE22
	bne loc_037FDE4E	; 037FDE24
	ldr r0,[pool_037FDE5C]	; 037FDE26
	ldr r2,[r0,#0x0]	; 037FDE28
	cmp r2,#0x0	; 037FDE2A
	beq loc_037FDE36	; 037FDE2C
	add r0,r5,#0x0	; 037FDE2E
	add r1,r4,#0x0	; 037FDE30
	bl loc_03805048	; 037FDE32
loc_037FDE36:
	ldr r2,[r6,#0x10]	; 037FDE36
	cmp r2,#0x0	; 037FDE38
	beq loc_037FDE44	; 037FDE3A
	add r0,r5,#0x0	; 037FDE3C
	add r1,r4,#0x0	; 037FDE3E
	bl loc_03805048	; 037FDE40
loc_037FDE44:
	ldr r0,[pool_037FDE54]	; 037FDE44
	str r4,[r0,#0x8]	; 037FDE46
	add r0,r4,#0x0	; 037FDE48
	bl loc_037FDE78	; 037FDE4A
loc_037FDE4E:
	pop {r4,r5,r6}	; 037FDE4E
	pop {r3}	; 037FDE50
	bx r3	; 037FDE52
pool_037FDE54:
loc_037FDE54:
	.word P2_BssStart + 0x548	; 037FDE54
pool_037FDE58:
loc_037FDE58:
	.word P2_BssStart + 0x540	; 037FDE58
pool_037FDE5C:
loc_037FDE5C:
	.word P2_BssStart + 0x53C	; 037FDE5C

; ===== function loc_037FDE60 =====
loc_037FDE60:
	bx pc	; 037FDE60
	.byte 0xC0, 0x46	; 037FDE64
.arm

; ===== function loc_037FDE64 =====
loc_037FDE64:
	ldr pc,[pool_037FDE68]	; 037FDE64
pool_037FDE68:
loc_037FDE68:
	.word loc_037FF118	; 037FDE68
.thumb

; ===== function loc_037FDE6C =====
loc_037FDE6C:
	bx pc	; 037FDE6C
	.byte 0xC0, 0x46	; 037FDE70
.arm

; ===== function loc_037FDE70 =====
loc_037FDE70:
	ldr pc,[pool_037FDE74]	; 037FDE70
pool_037FDE74:
loc_037FDE74:
	.word P2_SaveThreadContext	; 037FDE74
.thumb

; ===== function loc_037FDE78 =====
loc_037FDE78:
	bx pc	; 037FDE78
	.byte 0xC0, 0x46	; 037FDE7C
.arm

; ===== function loc_037FDE7C =====
loc_037FDE7C:
	ldr pc,[pool_037FDE80]	; 037FDE7C
pool_037FDE80:
loc_037FDE80:
	.word P2_LoadThreadContext	; 037FDE80
.thumb

; ===== function loc_037FDE84 =====
loc_037FDE84:
	ldr r0,[pool_037FDE98]	; 037FDE84
	ldr r0,[r0,#0xc]	; 037FDE86
	b loc_037FDE8C	; 037FDE88
loc_037FDE8A:
	ldr r0,[r0,#0x4c]	; 037FDE8A
loc_037FDE8C:
	cmp r0,#0x0	; 037FDE8C
	beq loc_037FDE96	; 037FDE8E
	ldr r1,[r0,#0x48]	; 037FDE90
	cmp r1,#0x1	; 037FDE92
	bne loc_037FDE8A	; 037FDE94
loc_037FDE96:
	bx lr	; 037FDE96
pool_037FDE98:
loc_037FDE98:
	.word P2_BssStart + 0x548	; 037FDE98

; ===== function loc_037FDE9C =====
loc_037FDE9C:
	push {r4,r5,lr}	; 037FDE9C
	sub sp,#0x4	; 037FDE9E
	add r5,r0,#0x0	; 037FDEA0
	bl loc_037FDC9C	; 037FDEA2
	add r4,r0,#0x0	; 037FDEA6
	mov r0,#0x1	; 037FDEA8
	str r0,[r5,#0x48]	; 037FDEAA
	bl loc_037FDDF0	; 037FDEAC
	add r0,r4,#0x0	; 037FDEB0
	bl loc_037FDCC0	; 037FDEB2
	add sp,#0x4	; 037FDEB6
	pop {r4,r5}	; 037FDEB8
	pop {r3}	; 037FDEBA
	bx r3	; 037FDEBC
	.byte 0x00, 0x00	; 037FDEC0

; ===== function loc_037FDEC0 =====
loc_037FDEC0:
	push {r4,r5,r6,lr}	; 037FDEC0
	add r5,r0,#0x0	; 037FDEC2
	bl loc_037FDC9C	; 037FDEC4
	add r4,r0,#0x0	; 037FDEC8
	ldrh r1,[r5,#0x0]	; 037FDECA
	cmp r1,#0x0	; 037FDECC
	beq loc_037FDEF6	; 037FDECE
	ldr r0,[pool_037FDF04]	; 037FDED0
	ldr r0,[r0,#0xc]	; 037FDED2
	mov r3,#0x1	; 037FDED4
	b loc_037FDEEA	; 037FDED6
loc_037FDED8:
	ldr r2,[r0,#0x50]	; 037FDED8
	add r6,r3,#0x0	; 037FDEDA
	lsl r6,r2	; 037FDEDC
	add r2,r1,#0x0	; 037FDEDE
	and r2,r6	; 037FDEE0
	cmp r2,#0x0	; 037FDEE2
	beq loc_037FDEE8	; 037FDEE4
	str r3,[r0,#0x48]	; 037FDEE6
loc_037FDEE8:
	ldr r0,[r0,#0x4c]	; 037FDEE8
loc_037FDEEA:
	cmp r0,#0x0	; 037FDEEA
	bne loc_037FDED8	; 037FDEEC
	mov r0,#0x0	; 037FDEEE
	strh r0,[r5,#0x0]	; 037FDEF0
	bl loc_037FDDF0	; 037FDEF2
loc_037FDEF6:
	add r0,r4,#0x0	; 037FDEF6
	bl loc_037FDCC0	; 037FDEF8
	pop {r4,r5,r6}	; 037FDEFC
	pop {r3}	; 037FDEFE
	bx r3	; 037FDF00
	.byte 0xC0, 0x46	; 037FDF04
pool_037FDF04:
loc_037FDF04:
	.word P2_BssStart + 0x548	; 037FDF04

; ===== function loc_037FDF08 =====
loc_037FDF08:
	push {r4,r5,lr}	; 037FDF08
	sub sp,#0x4	; 037FDF0A
	add r5,r0,#0x0	; 037FDF0C
	bl loc_037FDC9C	; 037FDF0E
	add r4,r0,#0x0	; 037FDF12
	ldr r0,[pool_037FDF44]	; 037FDF14
	ldr r0,[r0,#0x0]	; 037FDF16
	ldr r1,[r0,#0x0]	; 037FDF18
	cmp r5,#0x0	; 037FDF1A
	beq loc_037FDF2E	; 037FDF1C
	ldrh r0,[r5,#0x0]	; 037FDF1E
	mov r3,#0x1	; 037FDF20
	ldr r2,[r1,#0x50]	; 037FDF22
	lsl r3,r2	; 037FDF24
	lsl r2,r3,#0x10	; 037FDF26
	lsr r2,r2,#0x10	; 037FDF28
	orr r0,r2	; 037FDF2A
	strh r0,[r5,#0x0]	; 037FDF2C
loc_037FDF2E:
	mov r0,#0x0	; 037FDF2E
	str r0,[r1,#0x48]	; 037FDF30
	bl loc_037FDDF0	; 037FDF32
	add r0,r4,#0x0	; 037FDF36
	bl loc_037FDCC0	; 037FDF38
	add sp,#0x4	; 037FDF3C
	pop {r4,r5}	; 037FDF3E
	pop {r3}	; 037FDF40
	bx r3	; 037FDF42
pool_037FDF44:
loc_037FDF44:
	.word P2_BssStart + 0x540	; 037FDF44
P2_Entry_037FDF48:
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P2_ExitThread
	push {r4,lr}	; 037FDF48
	bl loc_037FDC9C	; 037FDF4A
	ldr r0,[pool_037FDF80]	; 037FDF4E
	ldr r0,[r0,#0x0]	; 037FDF50
	ldr r4,[r0,#0x0]	; 037FDF52
	add r0,r4,#0x0	; 037FDF54
	bl loc_037FE374	; 037FDF56
	add r0,r4,#0x0	; 037FDF5A
	bl loc_037FE0F8	; 037FDF5C
	mov r2,#0x0	; 037FDF60
	ldr r0,[r4,#0x50]	; 037FDF62
	lsl r1,r0,#0x2	; 037FDF64
	ldr r0,[pool_037FDF84]	; 037FDF66
	str r2,[r0,r1]	; 037FDF68
	mov r0,#0x2	; 037FDF6A
	str r0,[r4,#0x48]	; 037FDF6C
	add r4,#0x74	; 037FDF6E
	add r0,r4,#0x0	; 037FDF70
	bl loc_037FDEC0	; 037FDF72
	bl loc_037FDDF0	; 037FDF76
	pop {r4}	; 037FDF7A
	pop {r3}	; 037FDF7C
	bx r3	; 037FDF7E
.endfunc
pool_037FDF80:
loc_037FDF80:
	.word P2_BssStart + 0x540	; 037FDF80
pool_037FDF84:
loc_037FDF84:
	.word P2_BssStart + 0x55C	; 037FDF84

; ===== function loc_037FDF88 =====
loc_037FDF88:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P2_CreateThread
	push {r4,r5,r6,r7,lr}	; 037FDF88
	sub sp,#0xc	; 037FDF8A
	add r5,r0,#0x0	; 037FDF8C
	str r1,[sp,#0x0]	; 037FDF8E
	add r7,r2,#0x0	; 037FDF90
	add r4,r3,#0x0	; 037FDF92
	bl loc_037FDC9C	; 037FDF94
	str r0,[sp,#0x4]	; 037FDF98
	bl loc_037FE160	; 037FDF9A
	cmp r0,#0x0	; 037FDF9E
	bge loc_037FDFAA	; 037FDFA0
	ldr r0,[sp,#0x4]	; 037FDFA2
	bl loc_037FDCC0	; 037FDFA4
	b loc_037FE008	; 037FDFA8
loc_037FDFAA:
	ldr r1,[sp,#0x24]	; 037FDFAA
	str r1,[r5,#0x54]	; 037FDFAC
	str r0,[r5,#0x50]	; 037FDFAE
	mov r1,#0x0	; 037FDFB0
	str r1,[r5,#0x48]	; 037FDFB2
	lsl r1,r0,#0x2	; 037FDFB4
	ldr r0,[pool_037FE010]	; 037FDFB6
	str r5,[r0,r1]	; 037FDFB8
	add r0,r5,#0x0	; 037FDFBA
	bl loc_037FE124	; 037FDFBC
	str r4,[r5,#0x6c]	; 037FDFC0
	ldr r0,[sp,#0x20]	; 037FDFC2
	sub r6,r4,r0	; 037FDFC4
	str r6,[r5,#0x68]	; 037FDFC6
	mov r0,#0x0	; 037FDFC8
	str r0,[r5,#0x70]	; 037FDFCA
	ldr r1,[pool_037FE014]	; 037FDFCC
	ldr r0,[r5,#0x6c]	; 037FDFCE
	sub r0,r0,#0x4	; 037FDFD0
	str r1,[r0,#0x0]	; 037FDFD2
	ldr r1,[pool_037FE018]	; 037FDFD4
	ldr r0,[r5,#0x68]	; 037FDFD6
	str r1,[r0,#0x0]	; 037FDFD8
	add r0,r5,#0x0	; 037FDFDA
	ldr r1,[sp,#0x0]	; 037FDFDC
	sub r2,r4,#0x4	; 037FDFDE
	bl loc_037FE020	; 037FDFE0
	str r7,[r5,#ThreadContextR0Offset]	; 037FDFE4
	ldr r0,[pool_037FE01C]	; 037FDFE6
	str r0,[r5,#ThreadContextLrOffset]	; 037FDFE8
	mov r0,#0x0	; 037FDFEA
	str r0,[sp,#0x8]	; 037FDFEC
	ldr r0,[sp,#0x8]	; 037FDFEE
	add r1,r6,#0x4	; 037FDFF0
	ldr r2,[sp,#0x20]	; 037FDFF2
	sub r2,#0x8	; 037FDFF4
	bl loc_037FE02C	; 037FDFF6
	mov r0,#0x0	; 037FDFFA
	str r0,[r5,#0x5c]	; 037FDFFC
	str r0,[r5,#0x60]	; 037FDFFE
	str r0,[r5,#0x64]	; 037FE000
	ldr r0,[sp,#0x4]	; 037FE002
	bl loc_037FDCC0	; 037FE004
loc_037FE008:
	add sp,#0xc	; 037FE008
	pop {r4,r5,r6,r7}	; 037FE00A
	pop {r3}	; 037FE00C
	bx r3	; 037FE00E
.endfunc
pool_037FE010:
loc_037FE010:
	.word P2_BssStart + 0x55C	; 037FE010
pool_037FE014:
loc_037FE014:
	.word 0xD73BFDF7	; 037FE014
pool_037FE018:
loc_037FE018:
	.word 0xFBDD37BB	; 037FE018
pool_037FE01C:
loc_037FE01C:
	.word P2_ExitThread + 1	; 037FE01C

; ===== function loc_037FE020 =====
loc_037FE020:
	bx pc	; 037FE020
	.byte 0xC0, 0x46	; 037FE024
.arm

; ===== function loc_037FE024 =====
loc_037FE024:
	ldr pc,[pool_037FE028]	; 037FE024
pool_037FE028:
loc_037FE028:
	.word P2_InitThreadContext	; 037FE028
.thumb

; ===== function loc_037FE02C =====
loc_037FE02C:
	bx pc	; 037FE02C
	.byte 0xC0, 0x46	; 037FE030
.arm

; ===== function loc_037FE030 =====
loc_037FE030:
	ldr pc,[pool_037FE034]	; 037FE030
pool_037FE034:
loc_037FE034:
	.word loc_037FF30C	; 037FE034
.thumb

; ===== function loc_037FE038 =====
loc_037FE038:
	push {lr}	; 037FE038
	sub sp,#0x4	; 037FE03A
	ldr r0,[pool_037FE0C4]	; 037FE03C
	ldr r1,[r0,#0x0]	; 037FE03E
	cmp r1,#0x0	; 037FE040
	bne loc_037FE0BC	; 037FE042
	mov r1,#0x1	; 037FE044
	str r1,[r0,#0x0]	; 037FE046
	mov r3,#0x0	; 037FE048
	add r1,r3,#0x0	; 037FE04A
	ldr r0,[pool_037FE0C8]	; 037FE04C
loc_037FE04E:
	lsl r2,r3,#0x2	; 037FE04E
	add r2,r0,r2	; 037FE050
	str r1,[r2,#0x14]	; 037FE052
	add r3,r3,#0x1	; 037FE054
	cmp r3,#0x10	; 037FE056
	blt loc_037FE04E	; 037FE058
	ldr r3,[pool_037FE0CC]	; 037FE05A
	ldr r2,[pool_037FE0D0]	; 037FE05C
	str r3,[r2,#0x0]	; 037FE05E
	mov r3,#0x10	; 037FE060
	ldr r2,[pool_037FE0D4]	; 037FE062
	str r3,[r2,#0x54]	; 037FE064
	str r1,[r2,#0x50]	; 037FE066
	mov r3,#0x1	; 037FE068
	str r3,[r2,#0x48]	; 037FE06A
	str r1,[r2,#0x4c]	; 037FE06C
	str r1,[r2,#0x58]	; 037FE06E
	str r2,[r0,#0x14]	; 037FE070
	str r2,[r0,#0xc]	; 037FE072
	str r2,[r0,#0x8]	; 037FE074
	ldr r2,[pool_037FE0D8]	; 037FE076
	cmp r2,#0x0	; 037FE078
	bne loc_037FE082	; 037FE07A
	ldr r0,[pool_037FE0DC]	; 037FE07C
	sub r3,r0,r2	; 037FE07E
	b loc_037FE08A	; 037FE080
loc_037FE082:
	ldr r1,[pool_037FE0E0]	; 037FE082
	ldr r0,[pool_037FE0E4]	; 037FE084
	sub r0,r0,r1	; 037FE086
	sub r3,r0,r2	; 037FE088
loc_037FE08A:
	ldr r1,[pool_037FE0E0]	; 037FE08A
	ldr r0,[pool_037FE0E4]	; 037FE08C
	sub r1,r0,r1	; 037FE08E
	ldr r2,[pool_037FE0D4]	; 037FE090
	str r1,[r2,#0x6c]	; 037FE092
	str r3,[r2,#0x68]	; 037FE094
	mov r0,#0x0	; 037FE096
	str r0,[r2,#0x70]	; 037FE098
	ldr r3,[pool_037FE0E8]	; 037FE09A
	sub r1,r1,#0x4	; 037FE09C
	str r3,[r1,#0x0]	; 037FE09E
	ldr r3,[pool_037FE0EC]	; 037FE0A0
	ldr r1,[r2,#0x68]	; 037FE0A2
	str r3,[r1,#0x0]	; 037FE0A4
	ldr r1,[pool_037FE0F0]	; 037FE0A6
	strh r0,[r1,#0x34]	; 037FE0A8
	mov r2,#0x10	; 037FE0AA
	ldr r1,[pool_037FE0C8]	; 037FE0AC
	strh r2,[r1,#0x2]	; 037FE0AE
	strh r0,[r1,#0x0]	; 037FE0B0
	strh r0,[r1,#0x4]	; 037FE0B2
	ldr r2,[pool_037FE0F4]	; 037FE0B4
	str r1,[r2,#0x0]	; 037FE0B6
	bl loc_037FDDCC	; 037FE0B8
loc_037FE0BC:
	add sp,#0x4	; 037FE0BC
	pop {r3}	; 037FE0BE
	bx r3	; 037FE0C0
	.byte 0xC0, 0x46	; 037FE0C4
pool_037FE0C4:
loc_037FE0C4:
	.word P2_BssStart + 0x544	; 037FE0C4
pool_037FE0C8:
loc_037FE0C8:
	.word P2_BssStart + 0x548	; 037FE0C8
pool_037FE0CC:
loc_037FE0CC:
	.word 0x038058A4	; 037FE0CC
pool_037FE0D0:
loc_037FE0D0:
	.word P2_BssStart + 0x540	; 037FE0D0
pool_037FE0D4:
loc_037FE0D4:
	.word P2_BssStart + 0x59C	; 037FE0D4
pool_037FE0D8:
loc_037FE0D8:
	.word 0x00000400	; 037FE0D8
pool_037FE0DC:
loc_037FE0DC:
	.word 0x037F8000	; 037FE0DC
pool_037FE0E0:
loc_037FE0E0:
	.word 0x00000200	; 037FE0E0
pool_037FE0E4:
loc_037FE0E4:
	.word 0x0380FF80	; 037FE0E4
pool_037FE0E8:
loc_037FE0E8:
	.word 0xD73BFDF7	; 037FE0E8
pool_037FE0EC:
loc_037FE0EC:
	.word 0xFBDD37BB	; 037FE0EC
pool_037FE0F0:
loc_037FE0F0:
	.word P2_BssStart + 0x5DC	; 037FE0F0
pool_037FE0F4:
loc_037FE0F4:
	.word FirmwareSystemWorkAddress + SystemWorkArm7ThreadInfoOffset	; 037FE0F4

; ===== function loc_037FE0F8 =====
loc_037FE0F8:
	ldr r1,[pool_037FE120]	; 037FE0F8
	ldr r2,[r1,#0xc]	; 037FE0FA
	mov r1,#0x0	; 037FE0FC
	b loc_037FE104	; 037FE0FE
loc_037FE100:
	add r1,r2,#0x0	; 037FE100
	ldr r2,[r2,#0x4c]	; 037FE102
loc_037FE104:
	cmp r2,#0x0	; 037FE104
	beq loc_037FE10C	; 037FE106
	cmp r2,r0	; 037FE108
	bne loc_037FE100	; 037FE10A
loc_037FE10C:
	cmp r1,#0x0	; 037FE10C
	bne loc_037FE118	; 037FE10E
	ldr r1,[r0,#0x4c]	; 037FE110
	ldr r0,[pool_037FE120]	; 037FE112
	str r1,[r0,#0xc]	; 037FE114
	bx lr	; 037FE116
loc_037FE118:
	ldr r0,[r0,#0x4c]	; 037FE118
	str r0,[r1,#0x4c]	; 037FE11A
	bx lr	; 037FE11C
	.byte 0xC0, 0x46	; 037FE120
pool_037FE120:
loc_037FE120:
	.word P2_BssStart + 0x548	; 037FE120

; ===== function loc_037FE124 =====
loc_037FE124:
	push {r4,r5,lr}	; 037FE124
	sub sp,#0x4	; 037FE126
	ldr r1,[pool_037FE15C]	; 037FE128
	ldr r3,[r1,#0xc]	; 037FE12A
	add r5,r3,#0x0	; 037FE12C
	mov r4,#0x0	; 037FE12E
	b loc_037FE136	; 037FE130
loc_037FE132:
	add r4,r5,#0x0	; 037FE132
	ldr r5,[r5,#0x4c]	; 037FE134
loc_037FE136:
	cmp r5,#0x0	; 037FE136
	beq loc_037FE142	; 037FE138
	ldr r2,[r5,#0x54]	; 037FE13A
	ldr r1,[r0,#0x54]	; 037FE13C
	cmp r2,r1	; 037FE13E
	bcc loc_037FE132	; 037FE140
loc_037FE142:
	cmp r4,#0x0	; 037FE142
	bne loc_037FE14E	; 037FE144
	str r3,[r0,#0x4c]	; 037FE146
	ldr r1,[pool_037FE15C]	; 037FE148
	str r0,[r1,#0xc]	; 037FE14A
	b loc_037FE154	; 037FE14C
loc_037FE14E:
	ldr r1,[r4,#0x4c]	; 037FE14E
	str r1,[r0,#0x4c]	; 037FE150
	str r0,[r4,#0x4c]	; 037FE152
loc_037FE154:
	add sp,#0x4	; 037FE154
	pop {r4,r5}	; 037FE156
	pop {r3}	; 037FE158
	bx r3	; 037FE15A
pool_037FE15C:
loc_037FE15C:
	.word P2_BssStart + 0x548	; 037FE15C

; ===== function loc_037FE160 =====
loc_037FE160:
	mov r0,#0x0	; 037FE160
	ldr r2,[pool_037FE17C]	; 037FE162
	b loc_037FE172	; 037FE164
loc_037FE166:
	lsl r1,r0,#0x2	; 037FE166
	add r1,r2,r1	; 037FE168
	ldr r1,[r1,#0x14]	; 037FE16A
	cmp r1,#0x0	; 037FE16C
	beq loc_037FE17A	; 037FE16E
	add r0,r0,#0x1	; 037FE170
loc_037FE172:
	cmp r0,#0x10	; 037FE172
	blt loc_037FE166	; 037FE174
	mov r0,#0x0	; 037FE176
	mvn r0,r0	; 037FE178
loc_037FE17A:
	bx lr	; 037FE17A
pool_037FE17C:
loc_037FE17C:
	.word 0x0380589C	; 037FE17C
.arm

; ===== function loc_037FE180 =====
loc_037FE180:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P2_InitThreadContext
	add r1,r1,#0x4	; 037FE180
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 037FE184
	str r2,[r0,#ThreadContextSvcSpOffset]	; 037FE188
	sub r2,r2,#ThreadContextSvcStackBytes	; 037FE18C
	str r2,[r0,#ThreadContextSpOffset]	; 037FE190
	ands r1,r1,#0x1	; 037FE194
	movne r1,#0x3f	; 037FE198
	moveq r1,#0x1f	; 037FE19C
	str r1,[r0,#ThreadContextCpsrOffset]	; 037FE1A0
	mov r1,#0x0	; 037FE1A4
	str r1,[r0,#ThreadContextR0Offset]	; 037FE1A8
	str r1,[r0,#0x8]	; 037FE1AC
	str r1,[r0,#0xc]	; 037FE1B0
	str r1,[r0,#0x10]	; 037FE1B4
	str r1,[r0,#0x14]	; 037FE1B8
	str r1,[r0,#0x18]	; 037FE1BC
	str r1,[r0,#0x1c]	; 037FE1C0
	str r1,[r0,#0x20]	; 037FE1C4
	str r1,[r0,#0x24]	; 037FE1C8
	str r1,[r0,#0x28]	; 037FE1CC
	str r1,[r0,#0x2c]	; 037FE1D0
	str r1,[r0,#0x30]	; 037FE1D4
	str r1,[r0,#0x34]	; 037FE1D8
	str r1,[r0,#ThreadContextLrOffset]	; 037FE1DC
	bx lr	; 037FE1E0
.endfunc

; ===== function loc_037FE1E4 =====
loc_037FE1E4:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P2_SaveThreadContext
	add r1,r0,#0x0	; 037FE1E4
	mrs r2,cpsr	; 037FE1E8
	str r2,[r1],#0x4	; 037FE1EC
	mov r0,#0xd3	; 037FE1F0
	msr cpsr_c,r0	; 037FE1F4
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE1F8
	msr cpsr_c,r2	; 037FE1FC
	mov r0,#0x1	; 037FE200
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FE204
	adr r0,P2_SaveThreadContextReturn + 4	; 037FE208
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE20C
	mov r0,#0x0	; 037FE210
P2_SaveThreadContextReturn:
	bx lr	; 037FE214
.endfunc

; ===== function loc_037FE218 =====
loc_037FE218:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P2_LoadThreadContext
	mrs r1,cpsr	; 037FE218
	bic r1,r1,#0x1f	; 037FE21C
	orr r1,r1,#0xd3	; 037FE220
	msr cpsr_c,r1	; 037FE224
	ldr r1,[r0],#0x4	; 037FE228
	msr spsr_cxsf,r1	; 037FE22C
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE230
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE234
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FE238
	mov r0,r0	; 037FE23C
	subs pc,lr,#0x4	; 037FE240
.endfunc
.thumb

; ===== function loc_037FE244 =====
loc_037FE244:
	push {r4,r5,r6,r7,lr}	; 037FE244
	sub sp,#0x4	; 037FE246
	add r5,r0,#0x0	; 037FE248
	add r6,r1,#0x0	; 037FE24A
	add r4,r2,#0x0	; 037FE24C
	bl loc_037FDC9C	; 037FE24E
	add r7,r0,#0x0	; 037FE252
	mov r0,#0x1	; 037FE254
	and r4,r0	; 037FE256
	add r0,r5,#0x2	; 037FE258
	str r0,[sp,#0x0]	; 037FE25A
	b loc_037FE272	; 037FE25C
loc_037FE25E:
	cmp r4,#0x0	; 037FE25E
	bne loc_037FE26C	; 037FE260
	add r0,r7,#0x0	; 037FE262
	bl loc_037FDCC0	; 037FE264
	mov r0,#0x0	; 037FE268
	b loc_037FE2A6	; 037FE26A
loc_037FE26C:
	ldr r0,[sp,#0x0]	; 037FE26C
	bl loc_037FDF08	; 037FE26E
loc_037FE272:
	ldr r0,[r5,#0x10]	; 037FE272
	cmp r0,#0x0	; 037FE274
	beq loc_037FE25E	; 037FE276
	cmp r6,#0x0	; 037FE278
	beq loc_037FE286	; 037FE27A
	ldr r1,[r5,#0x4]	; 037FE27C
	ldr r0,[r5,#0xc]	; 037FE27E
	lsl r0,r0,#0x2	; 037FE280
	ldr r0,[r1,r0]	; 037FE282
	str r0,[r6,#0x0]	; 037FE284
loc_037FE286:
	ldr r0,[r5,#0xc]	; 037FE286
	add r0,r0,#0x1	; 037FE288
	ldr r1,[r5,#0x8]	; 037FE28A
	bl loc_037FE2B0	; 037FE28C
	str r1,[r5,#0xc]	; 037FE290
	ldr r0,[r5,#0x10]	; 037FE292
	sub r0,r0,#0x1	; 037FE294
	str r0,[r5,#0x10]	; 037FE296
	add r0,r5,#0x0	; 037FE298
	bl loc_037FDEC0	; 037FE29A
	add r0,r7,#0x0	; 037FE29E
	bl loc_037FDCC0	; 037FE2A0
	mov r0,#0x1	; 037FE2A4
loc_037FE2A6:
	add sp,#0x4	; 037FE2A6
	pop {r4,r5,r6,r7}	; 037FE2A8
	pop {r3}	; 037FE2AA
	bx r3	; 037FE2AC
	.byte 0xC0, 0x46	; 037FE2B0

; ===== function loc_037FE2B0 =====
loc_037FE2B0:
	bx pc	; 037FE2B0
	.byte 0xC0, 0x46	; 037FE2B4
.arm

; ===== function loc_037FE2B4 =====
loc_037FE2B4:
	ldr pc,[pool_037FE2B8]	; 037FE2B4
pool_037FE2B8:
loc_037FE2B8:
	.word P2_SignedDivMod	; 037FE2B8
.thumb

; ===== function loc_037FE2BC =====
loc_037FE2BC:
	push {r4,r5,r6,r7,lr}	; 037FE2BC
	sub sp,#0x4	; 037FE2BE
	add r5,r0,#0x0	; 037FE2C0
	add r6,r1,#0x0	; 037FE2C2
	add r4,r2,#0x0	; 037FE2C4
	bl loc_037FDC9C	; 037FE2C6
	add r7,r0,#0x0	; 037FE2CA
	mov r0,#0x1	; 037FE2CC
	and r4,r0	; 037FE2CE
	b loc_037FE2E6	; 037FE2D0
loc_037FE2D2:
	cmp r4,#0x0	; 037FE2D2
	bne loc_037FE2E0	; 037FE2D4
	add r0,r7,#0x0	; 037FE2D6
	bl loc_037FDCC0	; 037FE2D8
	mov r0,#0x0	; 037FE2DC
	b loc_037FE310	; 037FE2DE
loc_037FE2E0:
	add r0,r5,#0x0	; 037FE2E0
	bl loc_037FDF08	; 037FE2E2
loc_037FE2E6:
	ldr r2,[r5,#0x10]	; 037FE2E6
	ldr r1,[r5,#0x8]	; 037FE2E8
	cmp r1,r2	; 037FE2EA
	ble loc_037FE2D2	; 037FE2EC
	ldr r0,[r5,#0xc]	; 037FE2EE
	add r0,r0,r2	; 037FE2F0
	bl loc_037FE2B0	; 037FE2F2
	ldr r2,[r5,#0x4]	; 037FE2F6
	lsl r0,r1,#0x2	; 037FE2F8
	str r6,[r2,r0]	; 037FE2FA
	ldr r0,[r5,#0x10]	; 037FE2FC
	add r0,r0,#0x1	; 037FE2FE
	str r0,[r5,#0x10]	; 037FE300
	add r0,r5,#0x2	; 037FE302
	bl loc_037FDEC0	; 037FE304
	add r0,r7,#0x0	; 037FE308
	bl loc_037FDCC0	; 037FE30A
	mov r0,#0x1	; 037FE30E
loc_037FE310:
	add sp,#0x4	; 037FE310
	pop {r4,r5,r6,r7}	; 037FE312
	pop {r3}	; 037FE314
	bx r3	; 037FE316

; ===== function loc_037FE318 =====
loc_037FE318:
	mov r3,#0x0	; 037FE318
	strh r3,[r0,#0x0]	; 037FE31A
	strh r3,[r0,#0x2]	; 037FE31C
	str r1,[r0,#0x4]	; 037FE31E
	str r2,[r0,#0x8]	; 037FE320
	str r3,[r0,#0xc]	; 037FE322
	str r3,[r0,#0x10]	; 037FE324
	bx lr	; 037FE326

; ===== function loc_037FE328 =====
loc_037FE328:
	ldr r3,[r0,#0x60]	; 037FE328
	ldr r2,[r3,#0x10]	; 037FE32A
	cmp r2,#0x0	; 037FE32C
	bne loc_037FE336	; 037FE32E
	mov r1,#0x0	; 037FE330
	str r1,[r0,#0x64]	; 037FE332
	b loc_037FE33A	; 037FE334
loc_037FE336:
	mov r1,#0x0	; 037FE336
	str r1,[r2,#0xc]	; 037FE338
loc_037FE33A:
	str r2,[r0,#0x60]	; 037FE33A
	add r0,r3,#0x0	; 037FE33C
	bx lr	; 037FE33E
P2_Entry_037FE340:
	ldr r2,[r1,#0x10]	; 037FE340
	ldr r1,[r1,#0xc]	; 037FE342
	cmp r2,#0x0	; 037FE344
	bne P2_Entry_037FE34C	; 037FE346
	str r1,[r0,#0x64]	; 037FE348
	b P2_Entry_037FE34E	; 037FE34A
P2_Entry_037FE34C:
	str r1,[r2,#0xc]	; 037FE34C
P2_Entry_037FE34E:
	cmp r1,#0x0	; 037FE34E
	bne P2_Entry_037FE356	; 037FE350
	str r2,[r0,#0x60]	; 037FE352
	bx lr	; 037FE354
P2_Entry_037FE356:
	str r2,[r1,#0x10]	; 037FE356
	bx lr	; 037FE358
	.byte 0x00, 0x00	; 037FE35A
P2_Entry_037FE35C:
	ldr r3,[r0,#0x64]	; 037FE35C
	cmp r3,#0x0	; 037FE35E
	bne P2_Entry_037FE366	; 037FE360
	str r1,[r0,#0x60]	; 037FE362
	b P2_Entry_037FE36A	; 037FE364
P2_Entry_037FE366:
	ldr r2,[r0,#0x60]	; 037FE366
	str r1,[r2,#0x10]	; 037FE368
P2_Entry_037FE36A:
	str r3,[r1,#0xc]	; 037FE36A
	mov r2,#0x0	; 037FE36C
	str r2,[r1,#0x10]	; 037FE36E
	str r1,[r0,#0x64]	; 037FE370
	bx lr	; 037FE372

; ===== function loc_037FE374 =====
loc_037FE374:
	push {r4,r5,lr}	; 037FE374
	sub sp,#0x4	; 037FE376
	add r5,r0,#0x0	; 037FE378
	mov r4,#0x0	; 037FE37A
	b loc_037FE38C	; 037FE37C
loc_037FE37E:
	add r0,r5,#0x0	; 037FE37E
	bl loc_037FE328	; 037FE380
	str r4,[r0,#0x8]	; 037FE384
	str r4,[r0,#0x4]	; 037FE386
	bl loc_037FDEC0	; 037FE388
loc_037FE38C:
	ldr r0,[r5,#0x60]	; 037FE38C
	cmp r0,#0x0	; 037FE38E
	bne loc_037FE37E	; 037FE390
	add sp,#0x4	; 037FE392
	pop {r4,r5}	; 037FE394
	pop {r3}	; 037FE396
	bx r3	; 037FE398
	.byte 0x00, 0x00	; 037FE39A
P2_Entry_037FE39C:
	push {r4,r5,lr}	; 037FE39C
	sub sp,#0x4	; 037FE39E
	add r5,r0,#0x0	; 037FE3A0
	bl loc_037FDC9C	; 037FE3A2
	add r4,r0,#0x0	; 037FE3A6
	ldr r0,[pool_037FE3DC]	; 037FE3A8
	ldr r0,[r0,#0x8]	; 037FE3AA
	ldr r1,[r5,#0x4]	; 037FE3AC
	cmp r1,r0	; 037FE3AE
	bne P2_Entry_037FE3CE	; 037FE3B0
	ldr r1,[r5,#0x8]	; 037FE3B2
	sub r1,r1,#0x1	; 037FE3B4
	str r1,[r5,#0x8]	; 037FE3B6
	ldr r1,[r5,#0x8]	; 037FE3B8
	cmp r1,#0x0	; 037FE3BA
	bne P2_Entry_037FE3CE	; 037FE3BC
	add r1,r5,#0x0	; 037FE3BE
	bl P2_Entry_037FE340	; 037FE3C0
	mov r0,#0x0	; 037FE3C4
	str r0,[r5,#0x4]	; 037FE3C6
	add r0,r5,#0x0	; 037FE3C8
	bl loc_037FDEC0	; 037FE3CA
P2_Entry_037FE3CE:
	add r0,r4,#0x0	; 037FE3CE
	bl loc_037FDCC0	; 037FE3D0
	add sp,#0x4	; 037FE3D4
	pop {r4,r5}	; 037FE3D6
	pop {r3}	; 037FE3D8
	bx r3	; 037FE3DA
pool_037FE3DC:
	.word P2_BssStart + 0x548	; 037FE3DC
P2_Entry_037FE3E0:
	push {r4,r5,r6,r7,lr}	; 037FE3E0
	sub sp,#0x4	; 037FE3E2
	add r5,r0,#0x0	; 037FE3E4
	bl loc_037FDC9C	; 037FE3E6
	add r6,r0,#0x0	; 037FE3EA
	ldr r0,[pool_037FE430]	; 037FE3EC
	ldr r4,[r0,#0x8]	; 037FE3EE
	mov r7,#0x0	; 037FE3F0
P2_Entry_037FE3F2:
	ldr r0,[r5,#0x4]	; 037FE3F2
	cmp r0,#0x0	; 037FE3F4
	bne P2_Entry_037FE40A	; 037FE3F6
	str r4,[r5,#0x4]	; 037FE3F8
	ldr r0,[r5,#0x8]	; 037FE3FA
	add r0,r0,#0x1	; 037FE3FC
	str r0,[r5,#0x8]	; 037FE3FE
	add r0,r4,#0x0	; 037FE400
	add r1,r5,#0x0	; 037FE402
	bl P2_Entry_037FE35C	; 037FE404
	b P2_Entry_037FE422	; 037FE408
P2_Entry_037FE40A:
	cmp r0,r4	; 037FE40A
	bne P2_Entry_037FE416	; 037FE40C
	ldr r0,[r5,#0x8]	; 037FE40E
	add r0,r0,#0x1	; 037FE410
	str r0,[r5,#0x8]	; 037FE412
	b P2_Entry_037FE422	; 037FE414
P2_Entry_037FE416:
	str r5,[r4,#0x5c]	; 037FE416
	add r0,r5,#0x0	; 037FE418
	bl loc_037FDF08	; 037FE41A
	str r7,[r4,#0x5c]	; 037FE41E
	b P2_Entry_037FE3F2	; 037FE420
P2_Entry_037FE422:
	add r0,r6,#0x0	; 037FE422
	bl loc_037FDCC0	; 037FE424
	add sp,#0x4	; 037FE428
	pop {r4,r5,r6,r7}	; 037FE42A
	pop {r3}	; 037FE42C
	bx r3	; 037FE42E
pool_037FE430:
	.word P2_BssStart + 0x548	; 037FE430
P2_Entry_037FE434:
	mov r1,#0x0	; 037FE434
	strh r1,[r0,#0x0]	; 037FE436
	str r1,[r0,#0x4]	; 037FE438
	str r1,[r0,#0x8]	; 037FE43A
	bx lr	; 037FE43C
	.byte 0x00, 0x00	; 037FE43E

; ===== function loc_037FE440 =====
loc_037FE440:
	push {lr}	; 037FE440
	sub sp,#0x4	; 037FE442
	bl loc_037FE524	; 037FE444
	bl loc_03801E0C	; 037FE448
	bl loc_037FDD7C	; 037FE44C
	bl loc_037FDB48	; 037FE450
	bl loc_037FE8FC	; 037FE454
	bl loc_037FEC04	; 037FE458
	bl loc_037FE038	; 037FE45C
	bl loc_0380486C	; 037FE460
	add sp,#0x4	; 037FE464
	pop {r3}	; 037FE466
	bx r3	; 037FE468
	.byte 0x00, 0x00	; 037FE46C

; ===== function loc_037FE46C =====
loc_037FE46C:
	lsl r2,r0,#0x2	; 037FE46C
	ldr r0,[pool_037FE474]	; 037FE46E
	str r1,[r2,r0]	; 037FE470
	bx lr	; 037FE472
pool_037FE474:
loc_037FE474:
	.word 0x027FFDA0	; 037FE474

; ===== function loc_037FE478 =====
loc_037FE478:
	lsl r2,r0,#0x2	; 037FE478
	ldr r0,[pool_037FE480]	; 037FE47A
	str r1,[r2,r0]	; 037FE47C
	bx lr	; 037FE47E
pool_037FE480:
loc_037FE480:
	.word 0x027FFDC4	; 037FE480

; ===== function loc_037FE484 =====
loc_037FE484:
	cmp r0,#0x1	; 037FE484
	beq loc_037FE492	; 037FE486
	cmp r0,#0x7	; 037FE488
	beq loc_037FE496	; 037FE48A
	cmp r0,#0x8	; 037FE48C
	beq loc_037FE4A2	; 037FE48E
	b loc_037FE4AE	; 037FE490
loc_037FE492:
	ldr r0,[pool_037FE4B4]	; 037FE492
	bx lr	; 037FE494
loc_037FE496:
	ldr r0,[pool_037FE4B8]	; 037FE496
	ldr r1,[pool_037FE4BC]	; 037FE498
	cmp r0,r1	; 037FE49A
	bls loc_037FE4B0	; 037FE49C
	add r0,r1,#0x0	; 037FE49E
	bx lr	; 037FE4A0
loc_037FE4A2:
	ldr r0,[pool_037FE4BC]	; 037FE4A2
	ldr r1,[pool_037FE4B8]	; 037FE4A4
	cmp r1,r0	; 037FE4A6
	bls loc_037FE4B0	; 037FE4A8
	add r0,r1,#0x0	; 037FE4AA
	bx lr	; 037FE4AC
loc_037FE4AE:
	mov r0,#0x0	; 037FE4AE
loc_037FE4B0:
	bx lr	; 037FE4B0
	.byte 0xC0, 0x46	; 037FE4B4
pool_037FE4B4:
loc_037FE4B4:
	.word 0x027C0000	; 037FE4B4
pool_037FE4B8:
loc_037FE4B8:
	.word 0x037F81A4	; 037FE4B8
pool_037FE4BC:
loc_037FE4BC:
	.word 0x03800000	; 037FE4BC

; ===== function loc_037FE4C0 =====
loc_037FE4C0:
	cmp r0,#0x1	; 037FE4C0
	beq loc_037FE4CE	; 037FE4C2
	cmp r0,#0x7	; 037FE4C4
	beq loc_037FE4D2	; 037FE4C6
	cmp r0,#0x8	; 037FE4C8
	beq loc_037FE4D6	; 037FE4CA
	b loc_037FE4F4	; 037FE4CC
loc_037FE4CE:
	ldr r0,[pool_037FE4F8]	; 037FE4CE
	bx lr	; 037FE4D0
loc_037FE4D2:
	ldr r0,[pool_037FE4FC]	; 037FE4D2
	bx lr	; 037FE4D4
loc_037FE4D6:
	ldr r1,[pool_037FE500]	; 037FE4D6
	ldr r0,[pool_037FE504]	; 037FE4D8
	sub r0,r0,r1	; 037FE4DA
	ldr r1,[pool_037FE508]	; 037FE4DC
	cmp r1,#0x0	; 037FE4DE
	bne loc_037FE4E6	; 037FE4E0
	ldr r0,[pool_037FE4FC]	; 037FE4E2
	bx lr	; 037FE4E4
loc_037FE4E6:
	cmp r1,#0x0	; 037FE4E6
	bge loc_037FE4F0	; 037FE4E8
	ldr r0,[pool_037FE4FC]	; 037FE4EA
	sub r0,r0,r1	; 037FE4EC
	bx lr	; 037FE4EE
loc_037FE4F0:
	sub r0,r0,r1	; 037FE4F0
	bx lr	; 037FE4F2
loc_037FE4F4:
	mov r0,#0x0	; 037FE4F4
	bx lr	; 037FE4F6
pool_037FE4F8:
loc_037FE4F8:
	.word 0x027FF000	; 037FE4F8
pool_037FE4FC:
loc_037FE4FC:
	.word 0x03800000	; 037FE4FC
pool_037FE500:
loc_037FE500:
	.word 0x00000200	; 037FE500
pool_037FE504:
loc_037FE504:
	.word 0x0380FF80	; 037FE504
pool_037FE508:
loc_037FE508:
	.word 0x00000400	; 037FE508
P2_Entry_037FE50C:
	lsl r1,r0,#0x2	; 037FE50C
	ldr r0,[pool_037FE514]	; 037FE50E
	ldr r0,[r1,r0]	; 037FE510
	bx lr	; 037FE512
pool_037FE514:
	.word 0x027FFDA0	; 037FE514
P2_Entry_037FE518:
	lsl r1,r0,#0x2	; 037FE518
	ldr r0,[pool_037FE520]	; 037FE51A
	ldr r0,[r1,r0]	; 037FE51C
	bx lr	; 037FE51E
pool_037FE520:
	.word 0x027FFDC4	; 037FE520

; ===== function loc_037FE524 =====
loc_037FE524:
	push {lr}	; 037FE524
	sub sp,#0x4	; 037FE526
	ldr r1,[pool_037FE54C]	; 037FE528
	ldr r0,[r1,#0x0]	; 037FE52A
	cmp r0,#0x0	; 037FE52C
	bne loc_037FE544	; 037FE52E
	mov r0,#0x1	; 037FE530
	str r0,[r1,#0x0]	; 037FE532
	bl loc_037FE550	; 037FE534
	mov r0,#0x7	; 037FE538
	bl loc_037FE550	; 037FE53A
	mov r0,#0x8	; 037FE53E
	bl loc_037FE550	; 037FE540
loc_037FE544:
	add sp,#0x4	; 037FE544
	pop {r3}	; 037FE546
	bx r3	; 037FE548
	.byte 0xC0, 0x46	; 037FE54C
pool_037FE54C:
loc_037FE54C:
	.word P2_BssStart + 0x614	; 037FE54C

; ===== function loc_037FE550 =====
loc_037FE550:
	push {r4,lr}	; 037FE550
	add r4,r0,#0x0	; 037FE552
	bl loc_037FE4C0	; 037FE554
	add r1,r0,#0x0	; 037FE558
	add r0,r4,#0x0	; 037FE55A
	bl loc_037FE478	; 037FE55C
	add r0,r4,#0x0	; 037FE560
	bl loc_037FE484	; 037FE562
	add r1,r0,#0x0	; 037FE566
	add r0,r4,#0x0	; 037FE568
	bl loc_037FE46C	; 037FE56A
	pop {r4}	; 037FE56E
	pop {r3}	; 037FE570
	bx r3	; 037FE572

; ===== function loc_037FE574 =====
P2_Entry_037FE574:
	push {r4,r5,r6,r7,lr}	; 037FE574
	sub sp,#0xc	; 037FE576
	add r4,r0,#0x0	; 037FE578
	add r5,r1,#0x0	; 037FE57A
	add r6,r2,#0x0	; 037FE57C
	bl loc_037FDC9C	; 037FE57E
	str r0,[sp,#0x4]	; 037FE582
	lsl r1,r4,#0x2	; 037FE584
	ldr r0,[pool_037FE5E4]	; 037FE586
	ldr r1,[r0,r1]	; 037FE588
	add r5,#0x1f	; 037FE58A
	mov r0,#0x1f	; 037FE58C
	bic r5,r0	; 037FE58E
	bic r6,r0	; 037FE590
	mov r4,#0x0	; 037FE592
	ldr r7,[r1,#0x4]	; 037FE594
	b loc_037FE5CC	; 037FE596
loc_037FE598:
	ldr r0,[r1,#0x10]	; 037FE598
	add r3,r4,#0x0	; 037FE59A
	str r3,[sp,#0x0]	; 037FE59C
	mov r2,#0xc	; 037FE59E
	mul r3,r2	; 037FE5A0
	str r3,[sp,#0x0]	; 037FE5A2
	add r3,r0,r3	; 037FE5A4
	ldr r2,[sp,#0x0]	; 037FE5A6
	ldr r0,[r0,r2]	; 037FE5A8
	cmp r0,#0x0	; 037FE5AA
	bge loc_037FE5CA	; 037FE5AC
	sub r0,r6,r5	; 037FE5AE
	str r0,[r3,#0x0]	; 037FE5B0
	mov r1,#0x0	; 037FE5B2
	str r1,[r5,#0x0]	; 037FE5B4
	str r1,[r5,#0x4]	; 037FE5B6
	ldr r0,[r3,#0x0]	; 037FE5B8
	str r0,[r5,#0x8]	; 037FE5BA
	str r5,[r3,#0x4]	; 037FE5BC
	str r1,[r3,#0x8]	; 037FE5BE
	ldr r0,[sp,#0x4]	; 037FE5C0
	bl loc_037FDCC0	; 037FE5C2
	add r0,r4,#0x0	; 037FE5C6
	b loc_037FE5DA	; 037FE5C8
loc_037FE5CA:
	add r4,r4,#0x1	; 037FE5CA
loc_037FE5CC:
	cmp r4,r7	; 037FE5CC
	blt loc_037FE598	; 037FE5CE
	ldr r0,[sp,#0x4]	; 037FE5D0
	bl loc_037FDCC0	; 037FE5D2
	mov r0,#0x0	; 037FE5D6
	mvn r0,r0	; 037FE5D8
loc_037FE5DA:
	add sp,#0xc	; 037FE5DA
	pop {r4,r5,r6,r7}	; 037FE5DC
	pop {r3}	; 037FE5DE
	bx r3	; 037FE5E0
	.byte 0xC0, 0x46	; 037FE5E4
pool_037FE5E4:
loc_037FE5E4:
	.word P2_BssStart + 0x618	; 037FE5E4
P2_Entry_037FE5E8:
	push {r4,r5,r6,r7,lr}	; 037FE5E8
	sub sp,#0xc	; 037FE5EA
	add r6,r0,#0x0	; 037FE5EC
	add r5,r1,#0x0	; 037FE5EE
	str r2,[sp,#0x8]	; 037FE5F0
	add r4,r3,#0x0	; 037FE5F2
	bl loc_037FDC9C	; 037FE5F4
	str r0,[sp,#0x0]	; 037FE5F8
	lsl r1,r6,#0x2	; 037FE5FA
	ldr r0,[pool_037FE660]	; 037FE5FC
	str r5,[r0,r1]	; 037FE5FE
	add r3,r4,#0x0	; 037FE600
	mov r0,#0xc	; 037FE602
	mul r3,r0	; 037FE604
	add r0,r5,#0x0	; 037FE606
	add r0,#0x14	; 037FE608
	str r0,[r5,#0x10]	; 037FE60A
	str r4,[r5,#0x4]	; 037FE60C
	mov r2,#0x0	; 037FE60E
	mvn r0,r2	; 037FE610
	add r7,r2,#0x0	; 037FE612
	b P2_Entry_037FE630	; 037FE614
P2_Entry_037FE616:
	ldr r1,[r5,#0x10]	; 037FE616
	add r6,r2,#0x0	; 037FE618
	str r6,[sp,#0x4]	; 037FE61A
	mov r4,#0xc	; 037FE61C
	mul r6,r4	; 037FE61E
	str r6,[sp,#0x4]	; 037FE620
	add r6,r1,r6	; 037FE622
	ldr r4,[sp,#0x4]	; 037FE624
	str r0,[r1,r4]	; 037FE626
	str r7,[r6,#0x8]	; 037FE628
	ldr r1,[r6,#0x8]	; 037FE62A
	str r1,[r6,#0x4]	; 037FE62C
	add r2,r2,#0x1	; 037FE62E
P2_Entry_037FE630:
	ldr r1,[r5,#0x4]	; 037FE630
	cmp r2,r1	; 037FE632
	blt P2_Entry_037FE616	; 037FE634
	mov r0,#0x0	; 037FE636
	mvn r0,r0	; 037FE638
	str r0,[r5,#0x0]	; 037FE63A
	ldr r0,[r5,#0x10]	; 037FE63C
	add r0,r0,r3	; 037FE63E
	add r0,#0x1f	; 037FE640
	mov r1,#0x1f	; 037FE642
	bic r0,r1	; 037FE644
	str r0,[r5,#0x8]	; 037FE646
	ldr r0,[sp,#0x8]	; 037FE648
	bic r0,r1	; 037FE64A
	str r0,[sp,#0x8]	; 037FE64C
	str r0,[r5,#0xc]	; 037FE64E
	ldr r0,[sp,#0x0]	; 037FE650
	bl loc_037FDCC0	; 037FE652
	ldr r0,[r5,#0x8]	; 037FE656
	add sp,#0xc	; 037FE658
	pop {r4,r5,r6,r7}	; 037FE65A
	pop {r3}	; 037FE65C
	bx r3	; 037FE65E
pool_037FE660:
	.word P2_BssStart + 0x618	; 037FE660
P2_Entry_037FE664:
	push {r4,r5,lr}	; 037FE664
	sub sp,#0x4	; 037FE666
	add r5,r0,#0x0	; 037FE668
	add r4,r1,#0x0	; 037FE66A
	bl loc_037FDC9C	; 037FE66C
	lsl r2,r5,#0x2	; 037FE670
	ldr r1,[pool_037FE688]	; 037FE672
	ldr r1,[r1,r2]	; 037FE674
	ldr r5,[r1,#0x0]	; 037FE676
	str r4,[r1,#0x0]	; 037FE678
	bl loc_037FDCC0	; 037FE67A
	add r0,r5,#0x0	; 037FE67E
	add sp,#0x4	; 037FE680
	pop {r4,r5}	; 037FE682
	pop {r3}	; 037FE684
	bx r3	; 037FE686
pool_037FE688:
	.word P2_BssStart + 0x618	; 037FE688
P2_Entry_037FE68C:
	push {r4,r5,r6,r7,lr}	; 037FE68C
	sub sp,#0x4	; 037FE68E
	add r6,r0,#0x0	; 037FE690
	add r5,r1,#0x0	; 037FE692
	add r4,r2,#0x0	; 037FE694
	bl loc_037FDC9C	; 037FE696
	add r7,r0,#0x0	; 037FE69A
	lsl r1,r6,#0x2	; 037FE69C
	ldr r0,[pool_037FE6D4]	; 037FE69E
	ldr r0,[r0,r1]	; 037FE6A0
	cmp r5,#0x0	; 037FE6A2
	bge P2_Entry_037FE6A8	; 037FE6A4
	ldr r5,[r0,#0x0]	; 037FE6A6
P2_Entry_037FE6A8:
	sub r4,#0x20	; 037FE6A8
	ldr r1,[r0,#0x10]	; 037FE6AA
	mov r0,#0xc	; 037FE6AC
	mul r5,r0	; 037FE6AE
	add r5,r1,r5	; 037FE6B0
	ldr r0,[r5,#0x8]	; 037FE6B2
	add r1,r4,#0x0	; 037FE6B4
	bl loc_037FE7E4	; 037FE6B6
	str r0,[r5,#0x8]	; 037FE6BA
	ldr r0,[r5,#0x4]	; 037FE6BC
	add r1,r4,#0x0	; 037FE6BE
	bl P2_Entry_037FE784	; 037FE6C0
	str r0,[r5,#0x4]	; 037FE6C4
	add r0,r7,#0x0	; 037FE6C6
	bl loc_037FDCC0	; 037FE6C8
	add sp,#0x4	; 037FE6CC
	pop {r4,r5,r6,r7}	; 037FE6CE
	pop {r3}	; 037FE6D0
	bx r3	; 037FE6D2
pool_037FE6D4:
	.word P2_BssStart + 0x618	; 037FE6D4

; ===== function loc_037FE6D8 =====
loc_037FE6D8:
	push {r4,r5,r6,r7,lr}	; 037FE6D8
	sub sp,#0x4	; 037FE6DA
	add r6,r0,#0x0	; 037FE6DC
	add r4,r1,#0x0	; 037FE6DE
	add r5,r2,#0x0	; 037FE6E0
	bl loc_037FDC9C	; 037FE6E2
	add r7,r0,#0x0	; 037FE6E6
	lsl r2,r6,#0x2	; 037FE6E8
	ldr r1,[pool_037FE780]	; 037FE6EA
	ldr r1,[r1,r2]	; 037FE6EC
	cmp r1,#0x0	; 037FE6EE
	bne loc_037FE6FA	; 037FE6F0
	bl loc_037FDCC0	; 037FE6F2
	mov r0,#0x0	; 037FE6F6
	b loc_037FE778	; 037FE6F8
loc_037FE6FA:
	cmp r4,#0x0	; 037FE6FA
	bge loc_037FE700	; 037FE6FC
	ldr r4,[r1,#0x0]	; 037FE6FE
loc_037FE700:
	ldr r1,[r1,#0x10]	; 037FE700
	mov r0,#0xc	; 037FE702
	mul r4,r0	; 037FE704
	add r6,r1,r4	; 037FE706
	add r5,#0x20	; 037FE708
	add r5,#0x1f	; 037FE70A
	mov r0,#0x1f	; 037FE70C
	bic r5,r0	; 037FE70E
	ldr r0,[r6,#0x4]	; 037FE710
	add r4,r0,#0x0	; 037FE712
	b loc_037FE71E	; 037FE714
loc_037FE716:
	ldr r1,[r4,#0x8]	; 037FE716
	cmp r5,r1	; 037FE718
	ble loc_037FE722	; 037FE71A
	ldr r4,[r4,#0x4]	; 037FE71C
loc_037FE71E:
	cmp r4,#0x0	; 037FE71E
	bne loc_037FE716	; 037FE720
loc_037FE722:
	cmp r4,#0x0	; 037FE722
	bne loc_037FE730	; 037FE724
	add r0,r7,#0x0	; 037FE726
	bl loc_037FDCC0	; 037FE728
	mov r0,#0x0	; 037FE72C
	b loc_037FE778	; 037FE72E
loc_037FE730:
	ldr r1,[r4,#0x8]	; 037FE730
	sub r1,r1,r5	; 037FE732
	cmp r1,#0x40	; 037FE734
	bcs loc_037FE742	; 037FE736
	add r1,r4,#0x0	; 037FE738
	bl loc_037FE7E4	; 037FE73A
	str r0,[r6,#0x4]	; 037FE73E
	b loc_037FE764	; 037FE740
loc_037FE742:
	str r5,[r4,#0x8]	; 037FE742
	add r0,r4,r5	; 037FE744
	str r1,[r0,#0x8]	; 037FE746
	ldr r1,[r4,#0x0]	; 037FE748
	str r1,[r4,r5]	; 037FE74A
	ldr r1,[r4,#0x4]	; 037FE74C
	str r1,[r0,#0x4]	; 037FE74E
	ldr r1,[r0,#0x4]	; 037FE750
	cmp r1,#0x0	; 037FE752
	beq loc_037FE758	; 037FE754
	str r0,[r1,#0x0]	; 037FE756
loc_037FE758:
	ldr r1,[r0,#0x0]	; 037FE758
	cmp r1,#0x0	; 037FE75A
	beq loc_037FE762	; 037FE75C
	str r0,[r1,#0x4]	; 037FE75E
	b loc_037FE764	; 037FE760
loc_037FE762:
	str r0,[r6,#0x4]	; 037FE762
loc_037FE764:
	ldr r0,[r6,#0x8]	; 037FE764
	add r1,r4,#0x0	; 037FE766
	bl loc_037FE800	; 037FE768
	str r0,[r6,#0x8]	; 037FE76C
	add r0,r7,#0x0	; 037FE76E
	bl loc_037FDCC0	; 037FE770
	add r4,#0x20	; 037FE774
	add r0,r4,#0x0	; 037FE776
loc_037FE778:
	add sp,#0x4	; 037FE778
	pop {r4,r5,r6,r7}	; 037FE77A
	pop {r3}	; 037FE77C
	bx r3	; 037FE77E
pool_037FE780:
loc_037FE780:
	.word P2_BssStart + 0x618	; 037FE780
P2_Entry_037FE784:
	push {r4,r5,lr}	; 037FE784
	sub sp,#0x4	; 037FE786
	add r2,r0,#0x0	; 037FE788
	mov r3,#0x0	; 037FE78A
	b P2_Entry_037FE796	; 037FE78C
P2_Entry_037FE78E:
	cmp r1,r2	; 037FE78E
	bls P2_Entry_037FE79A	; 037FE790
	add r3,r2,#0x0	; 037FE792
	ldr r2,[r2,#0x4]	; 037FE794
P2_Entry_037FE796:
	cmp r2,#0x0	; 037FE796
	bne P2_Entry_037FE78E	; 037FE798
P2_Entry_037FE79A:
	str r2,[r1,#0x4]	; 037FE79A
	str r3,[r1,#0x0]	; 037FE79C
	cmp r2,#0x0	; 037FE79E
	beq P2_Entry_037FE7BC	; 037FE7A0
	str r1,[r2,#0x0]	; 037FE7A2
	ldr r5,[r1,#0x8]	; 037FE7A4
	add r4,r1,r5	; 037FE7A6
	cmp r4,r2	; 037FE7A8
	bne P2_Entry_037FE7BC	; 037FE7AA
	ldr r4,[r2,#0x8]	; 037FE7AC
	add r4,r5,r4	; 037FE7AE
	str r4,[r1,#0x8]	; 037FE7B0
	ldr r2,[r2,#0x4]	; 037FE7B2
	str r2,[r1,#0x4]	; 037FE7B4
	cmp r2,#0x0	; 037FE7B6
	beq P2_Entry_037FE7BC	; 037FE7B8
	str r1,[r2,#0x0]	; 037FE7BA
P2_Entry_037FE7BC:
	cmp r3,#0x0	; 037FE7BC
	beq P2_Entry_037FE7DA	; 037FE7BE
	str r1,[r3,#0x4]	; 037FE7C0
	ldr r4,[r3,#0x8]	; 037FE7C2
	add r5,r3,r4	; 037FE7C4
	cmp r5,r1	; 037FE7C6
	bne P2_Entry_037FE7DC	; 037FE7C8
	ldr r1,[r1,#0x8]	; 037FE7CA
	add r1,r4,r1	; 037FE7CC
	str r1,[r3,#0x8]	; 037FE7CE
	str r2,[r3,#0x4]	; 037FE7D0
	cmp r2,#0x0	; 037FE7D2
	beq P2_Entry_037FE7DC	; 037FE7D4
	str r3,[r2,#0x0]	; 037FE7D6
	b P2_Entry_037FE7DC	; 037FE7D8
P2_Entry_037FE7DA:
	add r0,r1,#0x0	; 037FE7DA
P2_Entry_037FE7DC:
	add sp,#0x4	; 037FE7DC
	pop {r4,r5}	; 037FE7DE
	pop {r3}	; 037FE7E0
	bx r3	; 037FE7E2

; ===== function loc_037FE7E4 =====
loc_037FE7E4:
	ldr r3,[r1,#0x4]	; 037FE7E4
	cmp r3,#0x0	; 037FE7E6
	beq loc_037FE7EE	; 037FE7E8
	ldr r2,[r1,#0x0]	; 037FE7EA
	str r2,[r3,#0x0]	; 037FE7EC
loc_037FE7EE:
	ldr r2,[r1,#0x0]	; 037FE7EE
	cmp r2,#0x0	; 037FE7F0
	bne loc_037FE7F8	; 037FE7F2
	ldr r0,[r1,#0x4]	; 037FE7F4
	bx lr	; 037FE7F6
loc_037FE7F8:
	ldr r1,[r1,#0x4]	; 037FE7F8
	str r1,[r2,#0x4]	; 037FE7FA
	bx lr	; 037FE7FC
	.byte 0x00, 0x00	; 037FE800

; ===== function loc_037FE800 =====
loc_037FE800:
	str r0,[r1,#0x4]	; 037FE800
	mov r2,#0x0	; 037FE802
	str r2,[r1,#0x0]	; 037FE804
	cmp r0,#0x0	; 037FE806
	beq loc_037FE80C	; 037FE808
	str r1,[r0,#0x0]	; 037FE80A
loc_037FE80C:
	add r0,r1,#0x0	; 037FE80C
	bx lr	; 037FE80E

; ===== function loc_037FE810 =====
loc_037FE810:
	ldr r1,[pool_037FE820]	; 037FE810
	ldrh r3,[r1,#0x0]	; 037FE812
	mov r2,#0x1	; 037FE814
	lsl r2,r0	; 037FE816
	orr r3,r2	; 037FE818
	strh r3,[r1,#0x0]	; 037FE81A
	bx lr	; 037FE81C
	.byte 0xC0, 0x46	; 037FE820
pool_037FE820:
loc_037FE820:
	.word P2_BssStart + 0x63C	; 037FE820

; ===== function loc_037FE824 =====
loc_037FE824:
	push {r4,r5,lr}	; 037FE824
	sub sp,#0xc	; 037FE826
	bl loc_037FDC9C	; 037FE828
	ldr r1,[pool_037FE88C]	; 037FE82C
	ldrh r1,[r1,#0x0]	; 037FE82E
	add r3,sp,#0x0	; 037FE830
	strh r1,[r3,#0x0]	; 037FE832
	ldr r1,[pool_037FE890]	; 037FE834
	ldr r5,[r1,#0x0]	; 037FE836
	ldr r4,[r1,#0x4]	; 037FE838
	ldr r1,[pool_037FE894]	; 037FE83A
	mov r2,#0x0	; 037FE83C
	and r4,r1	; 037FE83E
	bic r5,r2	; 037FE840
	str r5,[sp,#0x4]	; 037FE842
	str r4,[sp,#0x8]	; 037FE844
	ldr r1,[pool_037FE898]	; 037FE846
	ldr r4,[r1,#0x0]	; 037FE848
	mov r1,#0x8	; 037FE84A
	and r4,r1	; 037FE84C
	cmp r4,#0x0	; 037FE84E
	beq loc_037FE86A	; 037FE850
	ldrh r3,[r3,#0x0]	; 037FE852
	ldr r1,[pool_037FE89C]	; 037FE854
	and r3,r1	; 037FE856
	cmp r3,#0x0	; 037FE858
	bne loc_037FE86A	; 037FE85A
	ldr r3,[sp,#0x4]	; 037FE85C
	ldr r4,[sp,#0x8]	; 037FE85E
	mov r1,#0x1	; 037FE860
	add r1,r3,r1	; 037FE862
	adc r4,r2	; 037FE864
	str r1,[sp,#0x4]	; 037FE866
	str r4,[sp,#0x8]	; 037FE868
loc_037FE86A:
	bl loc_037FDCC0	; 037FE86A
	ldr r2,[sp,#0x4]	; 037FE86E
	ldr r1,[sp,#0x8]	; 037FE870
	lsr r0,r2,#0x10	; 037FE872
	lsl r1,r1,#0x10	; 037FE874
	orr r1,r0	; 037FE876
	lsl r0,r2,#0x10	; 037FE878
	add r2,sp,#0x0	; 037FE87A
	ldrh r3,[r2,#0x0]	; 037FE87C
	asr r2,r3,#0x1f	; 037FE87E
	orr r1,r2	; 037FE880
	orr r0,r3	; 037FE882
	add sp,#0xc	; 037FE884
	pop {r4,r5}	; 037FE886
	pop {r3}	; 037FE888
	bx r3	; 037FE88A
pool_037FE88C:
loc_037FE88C:
	.word TIMER0_DATA	; 037FE88C
pool_037FE890:
loc_037FE890:
	.word P2_BssStart + 0x648	; 037FE890
pool_037FE894:
loc_037FE894:
	.word 0x0000FFFF	; 037FE894
pool_037FE898:
loc_037FE898:
	.word REG_IF	; 037FE898
pool_037FE89C:
loc_037FE89C:
	.word 0x00008000	; 037FE89C

; ===== function loc_037FE8A0 =====
P2_IrqHandler_037FE8A0:
	push {r4,lr}	; 037FE8A0
	ldr r1,[pool_037FE8DC]	; 037FE8A2
	ldr r2,[r1,#0x0]	; 037FE8A4
	ldr r4,[r1,#0x4]	; 037FE8A6
	mov r3,#0x0	; 037FE8A8
	mov r0,#0x1	; 037FE8AA
	add r0,r2,r0	; 037FE8AC
	adc r4,r3	; 037FE8AE
	str r0,[r1,#0x0]	; 037FE8B0
	str r4,[r1,#0x4]	; 037FE8B2
	ldr r0,[pool_037FE8E0]	; 037FE8B4
	ldr r1,[r0,#0x0]	; 037FE8B6
	cmp r1,#0x0	; 037FE8B8
	beq loc_037FE8CA	; 037FE8BA
	ldr r2,[pool_037FE8E4]	; 037FE8BC
	strh r3,[r2,#0x0]	; 037FE8BE
	ldr r1,[pool_037FE8E8]	; 037FE8C0
	strh r3,[r1,#0x0]	; 037FE8C2
	mov r1,#0xc1	; 037FE8C4
	strh r1,[r2,#0x0]	; 037FE8C6
	str r3,[r0,#0x0]	; 037FE8C8
loc_037FE8CA:
	mov r0,#0x0	; 037FE8CA
	ldr r1,[pool_037FE8EC]	; 037FE8CC
	add r2,r0,#0x0	; 037FE8CE
	bl loc_037FDA9C	; 037FE8D0
	pop {r4}	; 037FE8D4
	pop {r3}	; 037FE8D6
	bx r3	; 037FE8D8
	.byte 0xC0, 0x46	; 037FE8DC
pool_037FE8DC:
loc_037FE8DC:
	.word P2_BssStart + 0x648	; 037FE8DC
pool_037FE8E0:
loc_037FE8E0:
	.word P2_BssStart + 0x644	; 037FE8E0
pool_037FE8E4:
loc_037FE8E4:
	.word TIMER0_CR	; 037FE8E4
pool_037FE8E8:
loc_037FE8E8:
	.word TIMER0_DATA	; 037FE8E8
pool_037FE8EC:
loc_037FE8EC:
	.word 0x037FE8A1	; 037FE8EC

; ===== function loc_037FE8F0 =====
loc_037FE8F0:
	ldr r0,[pool_037FE8F8]	; 037FE8F0
	ldrh r0,[r0,#0x0]	; 037FE8F2
	bx lr	; 037FE8F4
	.byte 0xC0, 0x46	; 037FE8F8
pool_037FE8F8:
loc_037FE8F8:
	.word P2_BssStart + 0x640	; 037FE8F8

; ===== function loc_037FE8FC =====
loc_037FE8FC:
	push {lr}	; 037FE8FC
	sub sp,#0x4	; 037FE8FE
	ldr r0,[pool_037FE940]	; 037FE900
	ldrh r1,[r0,#0x0]	; 037FE902
	cmp r1,#0x0	; 037FE904
	bne loc_037FE93A	; 037FE906
	mov r1,#0x1	; 037FE908
	strh r1,[r0,#0x0]	; 037FE90A
	mov r0,#0x0	; 037FE90C
	bl loc_037FE810	; 037FE90E
	mov r2,#0x0	; 037FE912
	ldr r0,[pool_037FE944]	; 037FE914
	str r2,[r0,#0x0]	; 037FE916
	str r2,[r0,#0x4]	; 037FE918
	ldr r1,[pool_037FE948]	; 037FE91A
	strh r2,[r1,#0x0]	; 037FE91C
	ldr r0,[pool_037FE94C]	; 037FE91E
	strh r2,[r0,#0x0]	; 037FE920
	mov r0,#0xc1	; 037FE922
	strh r0,[r1,#0x0]	; 037FE924
	mov r0,#0x8	; 037FE926
	ldr r1,[pool_037FE950]	; 037FE928
	bl loc_037FDAD0	; 037FE92A
	mov r0,#0x8	; 037FE92E
	bl loc_037FDA4C	; 037FE930
	mov r1,#0x0	; 037FE934
	ldr r0,[pool_037FE954]	; 037FE936
	str r1,[r0,#0x0]	; 037FE938
loc_037FE93A:
	add sp,#0x4	; 037FE93A
	pop {r3}	; 037FE93C
	bx r3	; 037FE93E
pool_037FE940:
loc_037FE940:
	.word P2_BssStart + 0x640	; 037FE940
pool_037FE944:
loc_037FE944:
	.word P2_BssStart + 0x648	; 037FE944
pool_037FE948:
loc_037FE948:
	.word TIMER0_CR	; 037FE948
pool_037FE94C:
loc_037FE94C:
	.word TIMER0_DATA	; 037FE94C
pool_037FE950:
loc_037FE950:
	.word P2_IrqHandler_037FE8A0 + 1	; 037FE950
pool_037FE954:
loc_037FE954:
	.word P2_BssStart + 0x644	; 037FE954
.arm
	stmdb sp!,{lr}	; 037FE958
	bl loc_037FE968	; 037FE95C
	ldmia sp!,{lr}	; 037FE960
	bx lr	; 037FE964

; ===== function loc_037FE968 =====
loc_037FE968:
	ldr r12,[pool_037FE970]	; 037FE968
	bx r12	; 037FE96C
pool_037FE970:
loc_037FE970:
	.word loc_037FE974 + 1	; 037FE970
.thumb
loc_037FE974:
	push {r4,r5,lr}	; 037FE974
	sub sp,#0x4	; 037FE976
	mov r1,#0x0	; 037FE978
	ldr r0,[pool_037FEA0C]	; 037FE97A
	strh r1,[r0,#0x0]	; 037FE97C
	mov r0,#0x10	; 037FE97E
	bl loc_037FDA20	; 037FE980
	ldr r2,[pool_037FEA10]	; 037FE984
	ldr r1,[r2,#0x0]	; 037FE986
	mov r0,#0x10	; 037FE988
	orr r1,r0	; 037FE98A
	str r1,[r2,#0x0]	; 037FE98C
	bl loc_037FE824	; 037FE98E
	ldr r2,[pool_037FEA14]	; 037FE992
	ldr r4,[r2,#0x0]	; 037FE994
	cmp r4,#0x0	; 037FE996
	beq loc_037FEA02	; 037FE998
	ldr r5,[r4,#0xc]	; 037FE99A
	ldr r3,[r4,#0x10]	; 037FE99C
	sub r0,r0,r5	; 037FE99E
	sbc r1,r3	; 037FE9A0
	bcs loc_037FE9AC	; 037FE9A2
	add r0,r4,#0x0	; 037FE9A4
	bl loc_037FEC34	; 037FE9A6
	b loc_037FEA02	; 037FE9AA
loc_037FE9AC:
	ldr r1,[r4,#0x18]	; 037FE9AC
	str r1,[r2,#0x0]	; 037FE9AE
	cmp r1,#0x0	; 037FE9B0
	bne loc_037FE9BA	; 037FE9B2
	mov r0,#0x0	; 037FE9B4
	str r0,[r2,#0x4]	; 037FE9B6
	b loc_037FE9BE	; 037FE9B8
loc_037FE9BA:
	mov r0,#0x0	; 037FE9BA
	str r0,[r1,#0x14]	; 037FE9BC
loc_037FE9BE:
	ldr r5,[r4,#0x0]	; 037FE9BE
	ldr r2,[r4,#0x1c]	; 037FE9C0
	ldr r1,[r4,#0x20]	; 037FE9C2
	mov r0,#0x0	; 037FE9C4
	eor r1,r0	; 037FE9C6
	eor r2,r0	; 037FE9C8
	orr r1,r2	; 037FE9CA
	bne loc_037FE9D2	; 037FE9CC
	mov r0,#0x0	; 037FE9CE
	str r0,[r4,#0x0]	; 037FE9D0
loc_037FE9D2:
	cmp r5,#0x0	; 037FE9D2
	beq loc_037FE9DC	; 037FE9D4
	ldr r0,[r4,#0x4]	; 037FE9D6
	bl loc_03805054	; 037FE9D8
loc_037FE9DC:
	ldr r2,[r4,#0x1c]	; 037FE9DC
	ldr r1,[r4,#0x20]	; 037FE9DE
	mov r0,#0x0	; 037FE9E0
	eor r1,r0	; 037FE9E2
	eor r2,r0	; 037FE9E4
	orr r1,r2	; 037FE9E6
	beq loc_037FE9F6	; 037FE9E8
	str r5,[r4,#0x0]	; 037FE9EA
	add r0,r4,#0x0	; 037FE9EC
	mov r1,#0x0	; 037FE9EE
	add r2,r1,#0x0	; 037FE9F0
	bl loc_037FEB14	; 037FE9F2
loc_037FE9F6:
	ldr r0,[pool_037FEA14]	; 037FE9F6
	ldr r0,[r0,#0x0]	; 037FE9F8
	cmp r0,#0x0	; 037FE9FA
	beq loc_037FEA02	; 037FE9FC
	bl loc_037FEC34	; 037FE9FE
loc_037FEA02:
	add sp,#0x4	; 037FEA02
	pop {r4,r5}	; 037FEA04
	pop {r3}	; 037FEA06
	bx r3	; 037FEA08
	.byte 0xC0, 0x46	; 037FEA0C
pool_037FEA0C:
loc_037FEA0C:
	.word TIMER1_CR	; 037FEA0C
pool_037FEA10:
loc_037FEA10:
	.word Bios7IrqFlagsAddress	; 037FEA10
pool_037FEA14:
loc_037FEA14:
	.word P2_BssStart + 0x654	; 037FEA14

; ===== function loc_037FEA18 =====
loc_037FEA18:
	push {r4,r5,lr}	; 037FEA18
	sub sp,#0x4	; 037FEA1A
	add r5,r0,#0x0	; 037FEA1C
	bl loc_037FDC9C	; 037FEA1E
	add r4,r0,#0x0	; 037FEA22
	ldr r1,[r5,#0x0]	; 037FEA24
	cmp r1,#0x0	; 037FEA26
	bne loc_037FEA30	; 037FEA28
	bl loc_037FDCC0	; 037FEA2A
	b loc_037FEA66	; 037FEA2E
loc_037FEA30:
	ldr r0,[r5,#0x18]	; 037FEA30
	cmp r0,#0x0	; 037FEA32
	bne loc_037FEA3E	; 037FEA34
	ldr r2,[r5,#0x14]	; 037FEA36
	ldr r1,[pool_037FEA70]	; 037FEA38
	str r2,[r1,#0x4]	; 037FEA3A
	b loc_037FEA42	; 037FEA3C
loc_037FEA3E:
	ldr r1,[r5,#0x14]	; 037FEA3E
	str r1,[r0,#0x14]	; 037FEA40
loc_037FEA42:
	ldr r1,[r5,#0x14]	; 037FEA42
	cmp r1,#0x0	; 037FEA44
	beq loc_037FEA4C	; 037FEA46
	str r0,[r1,#0x18]	; 037FEA48
	b loc_037FEA58	; 037FEA4A
loc_037FEA4C:
	ldr r1,[pool_037FEA70]	; 037FEA4C
	str r0,[r1,#0x0]	; 037FEA4E
	cmp r0,#0x0	; 037FEA50
	beq loc_037FEA58	; 037FEA52
	bl loc_037FEC34	; 037FEA54
loc_037FEA58:
	mov r0,#0x0	; 037FEA58
	str r0,[r5,#0x0]	; 037FEA5A
	str r0,[r5,#0x1c]	; 037FEA5C
	str r0,[r5,#0x20]	; 037FEA5E
	add r0,r4,#0x0	; 037FEA60
	bl loc_037FDCC0	; 037FEA62
loc_037FEA66:
	add sp,#0x4	; 037FEA66
	pop {r4,r5}	; 037FEA68
	pop {r3}	; 037FEA6A
	bx r3	; 037FEA6C
	.byte 0xC0, 0x46	; 037FEA70
pool_037FEA70:
loc_037FEA70:
	.word P2_BssStart + 0x654	; 037FEA70

; ===== function loc_037FEA74 =====
loc_037FEA74:
	push {r4,r5,r6,lr}	; 037FEA74
	sub sp,#0x10	; 037FEA76
	add r5,r0,#0x0	; 037FEA78
	add r4,r1,#0x0	; 037FEA7A
	add r6,r2,#0x0	; 037FEA7C
	str r3,[sp,#0x0]	; 037FEA7E
	ldr r0,[sp,#0x20]	; 037FEA80
	str r0,[sp,#0x4]	; 037FEA82
	cmp r5,#0x0	; 037FEA84
	beq loc_037FEA8E	; 037FEA86
	ldr r0,[r5,#0x0]	; 037FEA88
	cmp r0,#0x0	; 037FEA8A
	beq loc_037FEA92	; 037FEA8C
loc_037FEA8E:
	bl loc_037FF190	; 037FEA8E
loc_037FEA92:
	bl loc_037FDC9C	; 037FEA92
	str r0,[sp,#0x8]	; 037FEA96
	ldr r0,[sp,#0x0]	; 037FEA98
	str r0,[r5,#0x1c]	; 037FEA9A
	ldr r0,[sp,#0x4]	; 037FEA9C
	str r0,[r5,#0x20]	; 037FEA9E
	str r4,[r5,#0x24]	; 037FEAA0
	str r6,[r5,#0x28]	; 037FEAA2
	ldr r0,[sp,#0x24]	; 037FEAA4
	str r0,[r5,#0x0]	; 037FEAA6
	ldr r0,[sp,#0x28]	; 037FEAA8
	str r0,[r5,#0x4]	; 037FEAAA
	add r0,r5,#0x0	; 037FEAAC
	mov r1,#0x0	; 037FEAAE
	add r2,r1,#0x0	; 037FEAB0
	bl loc_037FEB14	; 037FEAB2
	ldr r0,[sp,#0x8]	; 037FEAB6
	bl loc_037FDCC0	; 037FEAB8
	add sp,#0x10	; 037FEABC
	pop {r4,r5,r6}	; 037FEABE
	pop {r3}	; 037FEAC0
	bx r3	; 037FEAC2

; ===== function loc_037FEAC4 =====
loc_037FEAC4:
	push {r4,r5,r6,r7,lr}	; 037FEAC4
	sub sp,#0x4	; 037FEAC6
	add r5,r0,#0x0	; 037FEAC8
	add r6,r1,#0x0	; 037FEACA
	add r4,r2,#0x0	; 037FEACC
	add r7,r3,#0x0	; 037FEACE
	cmp r5,#0x0	; 037FEAD0
	beq loc_037FEADA	; 037FEAD2
	ldr r0,[r5,#0x0]	; 037FEAD4
	cmp r0,#0x0	; 037FEAD6
	beq loc_037FEADE	; 037FEAD8
loc_037FEADA:
	bl loc_037FF190	; 037FEADA
loc_037FEADE:
	bl loc_037FDC9C	; 037FEADE
	str r0,[sp,#0x0]	; 037FEAE2
	mov r0,#0x0	; 037FEAE4
	str r0,[r5,#0x1c]	; 037FEAE6
	str r0,[r5,#0x20]	; 037FEAE8
	str r7,[r5,#0x0]	; 037FEAEA
	ldr r0,[sp,#0x18]	; 037FEAEC
	str r0,[r5,#0x4]	; 037FEAEE
	bl loc_037FE824	; 037FEAF0
	add r2,r0,#0x0	; 037FEAF4
	add r0,r5,#0x0	; 037FEAF6
	add r2,r6,r2	; 037FEAF8
	adc r4,r1	; 037FEAFA
	add r1,r2,#0x0	; 037FEAFC
	add r2,r4,#0x0	; 037FEAFE
	bl loc_037FEB14	; 037FEB00
	ldr r0,[sp,#0x0]	; 037FEB04
	bl loc_037FDCC0	; 037FEB06
	add sp,#0x4	; 037FEB0A
	pop {r4,r5,r6,r7}	; 037FEB0C
	pop {r3}	; 037FEB0E
	bx r3	; 037FEB10
	.byte 0x00, 0x00	; 037FEB14

; ===== function loc_037FEB14 =====
loc_037FEB14:
	push {r4,r5,r6,r7,lr}	; 037FEB14
	sub sp,#0xc	; 037FEB16
	add r5,r0,#0x0	; 037FEB18
	add r4,r1,#0x0	; 037FEB1A
	add r6,r2,#0x0	; 037FEB1C
	ldr r2,[r5,#0x1c]	; 037FEB1E
	ldr r1,[r5,#0x20]	; 037FEB20
	mov r0,#0x0	; 037FEB22
	eor r1,r0	; 037FEB24
	eor r2,r0	; 037FEB26
	orr r1,r2	; 037FEB28
	beq loc_037FEB6E	; 037FEB2A
	bl loc_037FE824	; 037FEB2C
	ldr r4,[r5,#0x24]	; 037FEB30
	ldr r6,[r5,#0x28]	; 037FEB32
	sub r2,r4,r0	; 037FEB34
	lsl r2,r6,#0	; 037FEB36
	sbc r2,r1	; 037FEB38
	bcs loc_037FEB6E	; 037FEB3A
	ldr r2,[r5,#0x1c]	; 037FEB3C
	str r2,[sp,#0x0]	; 037FEB3E
	ldr r2,[r5,#0x20]	; 037FEB40
	str r2,[sp,#0x4]	; 037FEB42
	sub r0,r0,r4	; 037FEB44
	sbc r1,r6	; 037FEB46
	ldr r2,[sp,#0x0]	; 037FEB48
	ldr r3,[sp,#0x4]	; 037FEB4A
	bl loc_037FEBD8	; 037FEB4C
	str r0,[sp,#0x8]	; 037FEB50
	add r7,r1,#0x0	; 037FEB52
	ldr r0,[sp,#0x0]	; 037FEB54
	ldr r1,[sp,#0x4]	; 037FEB56
	mov r3,#0x1	; 037FEB58
	ldr r2,[sp,#0x8]	; 037FEB5A
	add r3,r2,r3	; 037FEB5C
	mov r2,#0x0	; 037FEB5E
	adc r7,r2	; 037FEB60
	add r2,r3,#0x0	; 037FEB62
	add r3,r7,#0x0	; 037FEB64
	bl loc_037FEBE4	; 037FEB66
	add r4,r4,r0	; 037FEB6A
	adc r6,r1	; 037FEB6C
loc_037FEB6E:
	str r4,[r5,#0xc]	; 037FEB6E
	str r6,[r5,#0x10]	; 037FEB70
	ldr r0,[pool_037FEBD4]	; 037FEB72
	ldr r3,[r0,#0x0]	; 037FEB74
	b loc_037FEBAA	; 037FEB76
loc_037FEB78:
	ldr r1,[r3,#0xc]	; 037FEB78
	ldr r0,[r3,#0x10]	; 037FEB7A
	sub r2,r4,r1	; 037FEB7C
	lsl r1,r6,#0	; 037FEB7E
	sbc r1,r0	; 037FEB80
	mov r0,#0x0	; 037FEB82
	sub r2,r2,r0	; 037FEB84
	sbc r1,r0	; 037FEB86
	bge loc_037FEBA8	; 037FEB88
	ldr r0,[r3,#0x14]	; 037FEB8A
	str r0,[r5,#0x14]	; 037FEB8C
	str r5,[r3,#0x14]	; 037FEB8E
	str r3,[r5,#0x18]	; 037FEB90
	ldr r0,[r5,#0x14]	; 037FEB92
	cmp r0,#0x0	; 037FEB94
	beq loc_037FEB9C	; 037FEB96
	str r5,[r0,#0x18]	; 037FEB98
	b loc_037FEBCC	; 037FEB9A
loc_037FEB9C:
	ldr r0,[pool_037FEBD4]	; 037FEB9C
	str r5,[r0,#0x0]	; 037FEB9E
	add r0,r5,#0x0	; 037FEBA0
	bl loc_037FEC34	; 037FEBA2
	b loc_037FEBCC	; 037FEBA6
loc_037FEBA8:
	ldr r3,[r3,#0x18]	; 037FEBA8
loc_037FEBAA:
	cmp r3,#0x0	; 037FEBAA
	bne loc_037FEB78	; 037FEBAC
	mov r0,#0x0	; 037FEBAE
	str r0,[r5,#0x18]	; 037FEBB0
	ldr r0,[pool_037FEBD4]	; 037FEBB2
	ldr r1,[r0,#0x4]	; 037FEBB4
	str r5,[r0,#0x4]	; 037FEBB6
	str r1,[r5,#0x14]	; 037FEBB8
	cmp r1,#0x0	; 037FEBBA
	beq loc_037FEBC2	; 037FEBBC
	str r5,[r1,#0x18]	; 037FEBBE
	b loc_037FEBCC	; 037FEBC0
loc_037FEBC2:
	str r5,[r0,#0x4]	; 037FEBC2
	str r5,[r0,#0x0]	; 037FEBC4
	add r0,r5,#0x0	; 037FEBC6
	bl loc_037FEC34	; 037FEBC8
loc_037FEBCC:
	add sp,#0xc	; 037FEBCC
	pop {r4,r5,r6,r7}	; 037FEBCE
	pop {r3}	; 037FEBD0
	bx r3	; 037FEBD2
pool_037FEBD4:
loc_037FEBD4:
	.word P2_BssStart + 0x654	; 037FEBD4

; ===== function loc_037FEBD8 =====
loc_037FEBD8:
	bx pc	; 037FEBD8
	.byte 0xC0, 0x46	; 037FEBDC
.arm

; ===== function loc_037FEBDC =====
loc_037FEBDC:
	ldr pc,[pool_037FEBE0]	; 037FEBDC
pool_037FEBE0:
loc_037FEBE0:
	.word loc_03804908	; 037FEBE0
.thumb

; ===== function loc_037FEBE4 =====
loc_037FEBE4:
	bx pc	; 037FEBE4
	.byte 0xC0, 0x46	; 037FEBE8
.arm

; ===== function loc_037FEBE8 =====
loc_037FEBE8:
	ldr pc,[pool_037FEBEC]	; 037FEBE8
pool_037FEBEC:
loc_037FEBEC:
	.word loc_03804B10	; 037FEBEC
.thumb

; ===== function loc_037FEBF0 =====
loc_037FEBF0:
	mov r1,#0x0	; 037FEBF0
	str r1,[r0,#0x0]	; 037FEBF2
	str r1,[r0,#0x8]	; 037FEBF4
	bx lr	; 037FEBF6

; ===== function loc_037FEBF8 =====
loc_037FEBF8:
	ldr r0,[pool_037FEC00]	; 037FEBF8
	ldrh r0,[r0,#0x0]	; 037FEBFA
	bx lr	; 037FEBFC
	.byte 0xC0, 0x46	; 037FEC00
pool_037FEC00:
loc_037FEC00:
	.word P2_BssStart + 0x650	; 037FEC00

; ===== function loc_037FEC04 =====
loc_037FEC04:
	push {lr}	; 037FEC04
	sub sp,#0x4	; 037FEC06
	ldr r1,[pool_037FEC2C]	; 037FEC08
	ldrh r0,[r1,#0x0]	; 037FEC0A
	cmp r0,#0x0	; 037FEC0C
	bne loc_037FEC26	; 037FEC0E
	mov r0,#0x1	; 037FEC10
	strh r0,[r1,#0x0]	; 037FEC12
	bl loc_037FE810	; 037FEC14
	mov r1,#0x0	; 037FEC18
	ldr r0,[pool_037FEC30]	; 037FEC1A
	str r1,[r0,#0x0]	; 037FEC1C
	str r1,[r0,#0x4]	; 037FEC1E
	mov r0,#0x10	; 037FEC20
	bl loc_037FDA20	; 037FEC22
loc_037FEC26:
	add sp,#0x4	; 037FEC26
	pop {r3}	; 037FEC28
	bx r3	; 037FEC2A
pool_037FEC2C:
loc_037FEC2C:
	.word P2_BssStart + 0x650	; 037FEC2C
pool_037FEC30:
loc_037FEC30:
	.word P2_BssStart + 0x654	; 037FEC30

; ===== function loc_037FEC34 =====
loc_037FEC34:
	push {r4,r5,lr}	; 037FEC34
	sub sp,#0x4	; 037FEC36
	add r4,r0,#0x0	; 037FEC38
	bl loc_037FE824	; 037FEC3A
	mov r2,#0x0	; 037FEC3E
	ldr r3,[pool_037FEC8C]	; 037FEC40
	strh r2,[r3,#0x0]	; 037FEC42
	ldr r3,[r4,#0xc]	; 037FEC44
	ldr r4,[r4,#0x10]	; 037FEC46
	sub r5,r3,r0	; 037FEC48
	sbc r4,r1	; 037FEC4A
	mov r0,#0x1	; 037FEC4C
	ldr r1,[pool_037FEC90]	; 037FEC4E
	bl loc_037FDA9C	; 037FEC50
	mov r1,#0x0	; 037FEC54
	sub r0,r5,r1	; 037FEC56
	lsl r0,r4,#0	; 037FEC58
	sbc r0,r1	; 037FEC5A
	bge loc_037FEC62	; 037FEC5C
	ldr r1,[pool_037FEC94]	; 037FEC5E
	b loc_037FEC74	; 037FEC60
loc_037FEC62:
	ldr r0,[pool_037FEC98]	; 037FEC62
	sub r0,r5,r0	; 037FEC64
	sbc r4,r1	; 037FEC66
	bge loc_037FEC72	; 037FEC68
	mvn r0,r5	; 037FEC6A
	lsl r0,r0,#0x10	; 037FEC6C
	lsr r1,r0,#0x10	; 037FEC6E
	b loc_037FEC74	; 037FEC70
loc_037FEC72:
	mov r1,#0x0	; 037FEC72
loc_037FEC74:
	ldr r0,[pool_037FEC9C]	; 037FEC74
	strh r1,[r0,#0x0]	; 037FEC76
	mov r1,#0xc1	; 037FEC78
	ldr r0,[pool_037FEC8C]	; 037FEC7A
	strh r1,[r0,#0x0]	; 037FEC7C
	mov r0,#0x10	; 037FEC7E
	bl loc_037FDA4C	; 037FEC80
	add sp,#0x4	; 037FEC84
	pop {r4,r5}	; 037FEC86
	pop {r3}	; 037FEC88
	bx r3	; 037FEC8A
pool_037FEC8C:
loc_037FEC8C:
	.word TIMER1_CR	; 037FEC8C
pool_037FEC90:
loc_037FEC90:
	.word 0x037FE958	; 037FEC90
pool_037FEC94:
loc_037FEC94:
	.word 0x0000FFFE	; 037FEC94
pool_037FEC98:
loc_037FEC98:
	.word 0x00010000	; 037FEC98
pool_037FEC9C:
loc_037FEC9C:
	.word TIMER1_DATA	; 037FEC9C

; ===== function loc_037FECA0 =====
P2_Entry_037FECA0:
	push {r4,lr}	; 037FECA0
	add r4,r0,#0x0	; 037FECA2
	bl loc_037FDC9C	; 037FECA4
	ldr r1,[pool_037FECCC]	; 037FECA8
	ldr r1,[r1,#0x0]	; 037FECAA
	cmp r4,r1	; 037FECAC
	bcs loc_037FECB8	; 037FECAE
	ldr r1,[pool_037FECD0]	; 037FECB0
	ldr r2,[r1,#0x0]	; 037FECB2
	add r2,r2,#0x1	; 037FECB4
	str r2,[r1,#0x0]	; 037FECB6
loc_037FECB8:
	ldr r1,[pool_037FECCC]	; 037FECB8
	str r4,[r1,#0x0]	; 037FECBA
	bl loc_037FDCC0	; 037FECBC
	ldr r0,[pool_037FECD0]	; 037FECC0
	ldr r0,[r0,#0x0]	; 037FECC2
	pop {r4}	; 037FECC4
	pop {r3}	; 037FECC6
	bx r3	; 037FECC8
	.byte 0xC0, 0x46	; 037FECCC
pool_037FECCC:
loc_037FECCC:
	.word P2_BssStart + 0x660	; 037FECCC
pool_037FECD0:
loc_037FECD0:
	.word P2_BssStart + 0x664	; 037FECD0
P2_Entry_037FECD4:
	ldr r3,[r0,#0xc]	; 037FECD4
	sub r3,r1,r3	; 037FECD6
	mov r1,#0x10	; 037FECD8
	ldrsh r1,[r0,r1]	; 037FECDA
	sub r2,r2,r1	; 037FECDC
	cmp r3,#0x0	; 037FECDE
	blt P2_Entry_037FECEA	; 037FECE0
	cmp r3,#0x0	; 037FECE2
	bne P2_Entry_037FECEE	; 037FECE4
	cmp r2,#0x0	; 037FECE6
	bge P2_Entry_037FECEE	; 037FECE8
P2_Entry_037FECEA:
	mov r0,#0x0	; 037FECEA
	bx lr	; 037FECEC
P2_Entry_037FECEE:
	cmp r2,#0x0	; 037FECEE
	bge P2_Entry_037FECF6	; 037FECF0
	ldr r1,[pool_037FED08]	; 037FECF2
	add r2,r2,r1	; 037FECF4
P2_Entry_037FECF6:
	mov r1,#0x12	; 037FECF6
	ldrsh r0,[r0,r1]	; 037FECF8
	cmp r2,r0	; 037FECFA
	bgt P2_Entry_037FED02	; 037FECFC
	mov r0,#0x1	; 037FECFE
	bx lr	; 037FED00
P2_Entry_037FED02:
	mov r0,#0x2	; 037FED02
	bx lr	; 037FED04
	.byte 0xC0, 0x46	; 037FED06
pool_037FED08:
	.word 0x00000107	; 037FED08
P2_IrqHandler_037FED0C:
	push {r4,r5,r6,r7,lr}	; 037FED0C
	sub sp,#0x4	; 037FED0E
	mov r0,#0x4	; 037FED10
	bl loc_037FDA20	; 037FED12
	ldr r3,[pool_037FEDEC]	; 037FED16
	ldrh r1,[r3,#0x0]	; 037FED18
	mov r0,#0x20	; 037FED1A
	bic r1,r0	; 037FED1C
	strh r1,[r3,#0x0]	; 037FED1E
	ldr r2,[pool_037FEDF0]	; 037FED20
	ldr r1,[r2,#0x0]	; 037FED22
	mov r0,#0x4	; 037FED24
	orr r1,r0	; 037FED26
	str r1,[r2,#0x0]	; 037FED28
	ldrh r1,[r3,#0x0]	; 037FED2A
	asr r2,r1,#0x8	; 037FED2C
	mov r0,#0xff	; 037FED2E
	and r2,r0	; 037FED30
	lsl r1,r1,#0x1	; 037FED32
	ldr r0,[pool_037FEDF4]	; 037FED34
	and r1,r0	; 037FED36
	orr r2,r1	; 037FED38
	sub r0,r2,#0x1	; 037FED3A
	bl P2_Entry_037FECA0	; 037FED3C
	ldr r7,[pool_037FEDF8]	; 037FED40
	b P2_Entry_037FEDDC	; 037FED42
P2_Entry_037FED44:
	ldrh r4,[r7,#0x0]	; 037FED44
	add r0,r4,#0x0	; 037FED46
	bl P2_Entry_037FECA0	; 037FED48
	add r6,r0,#0x0	; 037FED4C
	add r0,r5,#0x0	; 037FED4E
	add r1,r6,#0x0	; 037FED50
	add r2,r4,#0x0	; 037FED52
	bl P2_Entry_037FECD4	; 037FED54
	cmp r0,#0x0	; 037FED58
	beq P2_Entry_037FED66	; 037FED5A
	cmp r0,#0x1	; 037FED5C
	beq P2_Entry_037FED94	; 037FED5E
	cmp r0,#0x2	; 037FED60
	beq P2_Entry_037FEDC8	; 037FED62
	b P2_Entry_037FEDDC	; 037FED64
P2_Entry_037FED66:
	add r0,r5,#0x0	; 037FED66
	bl P2_Entry_037FEEAC	; 037FED68
	ldrh r1,[r7,#0x0]	; 037FED6C
	mov r0,#0x10	; 037FED6E
	ldrsh r0,[r5,r0]	; 037FED70
	cmp r0,r1	; 037FED72
	bne P2_Entry_037FEDE4	; 037FED74
	ldr r0,[r5,#0xc]	; 037FED76
	cmp r0,r6	; 037FED78
	bne P2_Entry_037FEDE4	; 037FED7A
	mov r0,#0x4	; 037FED7C
	bl loc_037FDA20	; 037FED7E
	ldr r0,[pool_037FEDEC]	; 037FED82
	ldrh r1,[r0,#0x0]	; 037FED84
	mov r0,#0x20	; 037FED86
	bic r1,r0	; 037FED88
	ldr r0,[pool_037FEDEC]	; 037FED8A
	strh r1,[r0,#0x0]	; 037FED8C
	mov r0,#0x4	; 037FED8E
	bl loc_037FD9FC	; 037FED90
P2_Entry_037FED94:
	ldr r4,[r5,#0x0]	; 037FED94
	add r0,r5,#0x0	; 037FED96
	bl P2_Entry_037FEFC4	; 037FED98
	mov r0,#0x0	; 037FED9C
	str r0,[r5,#0x0]	; 037FED9E
	cmp r4,#0x0	; 037FEDA0
	beq P2_Entry_037FEDAA	; 037FEDA2
	ldr r0,[r5,#0x4]	; 037FEDA4
	bl loc_03805050	; 037FEDA6
P2_Entry_037FEDAA:
	ldr r0,[r5,#0x1c]	; 037FEDAA
	cmp r0,#0x0	; 037FEDAC
	beq P2_Entry_037FEDDC	; 037FEDAE
	ldr r0,[r5,#0x24]	; 037FEDB0
	cmp r0,#0x0	; 037FEDB2
	bne P2_Entry_037FEDDC	; 037FEDB4
	str r4,[r5,#0x0]	; 037FEDB6
	ldr r0,[pool_037FEDFC]	; 037FEDB8
	ldr r0,[r0,#0x0]	; 037FEDBA
	add r0,r0,#0x1	; 037FEDBC
	str r0,[r5,#0xc]	; 037FEDBE
	add r0,r5,#0x0	; 037FEDC0
	bl P2_Entry_037FEFEC	; 037FEDC2
	b P2_Entry_037FEDDC	; 037FEDC6
P2_Entry_037FEDC8:
	add r0,r5,#0x0	; 037FEDC8
	bl P2_Entry_037FEFC4	; 037FEDCA
	add r0,r5,#0x0	; 037FEDCE
	bl P2_Entry_037FEFEC	; 037FEDD0
	ldr r0,[pool_037FEDFC]	; 037FEDD4
	ldr r0,[r0,#0x0]	; 037FEDD6
	add r0,r0,#0x1	; 037FEDD8
	str r0,[r5,#0xc]	; 037FEDDA
P2_Entry_037FEDDC:
	ldr r0,[pool_037FEE00]	; 037FEDDC
	ldr r5,[r0,#0x0]	; 037FEDDE
	cmp r5,#0x0	; 037FEDE0
	bne P2_Entry_037FED44	; 037FEDE2
P2_Entry_037FEDE4:
	add sp,#0x4	; 037FEDE4
	pop {r4,r5,r6,r7}	; 037FEDE6
	pop {r3}	; 037FEDE8
	bx r3	; 037FEDEA
pool_037FEDEC:
	.word REG_DISPSTAT	; 037FEDEC
pool_037FEDF0:
	.word Bios7IrqFlagsAddress	; 037FEDF0
pool_037FEDF4:
	.word 0x00000100	; 037FEDF4
pool_037FEDF8:
	.word 0x04000006	; 037FEDF8
pool_037FEDFC:
	.word P2_BssStart + 0x664	; 037FEDFC
pool_037FEE00:
	.word P2_BssStart + 0x668	; 037FEE00
P2_Entry_037FEE04:
	push {r4,r5,r6,r7,lr}	; 037FEE04
	sub sp,#0x4	; 037FEE06
	add r5,r0,#0x0	; 037FEE08
	bl loc_037FDC9C	; 037FEE0A
	add r6,r0,#0x0	; 037FEE0E
	cmp r5,#0x0	; 037FEE10
	bne P2_Entry_037FEE18	; 037FEE12
	bl loc_037FF190	; 037FEE14
P2_Entry_037FEE18:
	ldr r0,[pool_037FEE54]	; 037FEE18
	ldr r0,[r0,#0x0]	; 037FEE1A
	cmp r0,#0x0	; 037FEE1C
	beq P2_Entry_037FEE24	; 037FEE1E
	ldr r4,[r0,#0x18]	; 037FEE20
	b P2_Entry_037FEE26	; 037FEE22
P2_Entry_037FEE24:
	mov r4,#0x0	; 037FEE24
P2_Entry_037FEE26:
	mov r7,#0x0	; 037FEE26
	b P2_Entry_037FEE40	; 037FEE28
P2_Entry_037FEE2A:
	ldr r1,[r0,#0x8]	; 037FEE2A
	cmp r1,r5	; 037FEE2C
	bne P2_Entry_037FEE34	; 037FEE2E
	bl P2_Entry_037FEE58	; 037FEE30
P2_Entry_037FEE34:
	add r0,r4,#0x0	; 037FEE34
	cmp r4,#0x0	; 037FEE36
	beq P2_Entry_037FEE3E	; 037FEE38
	ldr r4,[r4,#0x18]	; 037FEE3A
	b P2_Entry_037FEE40	; 037FEE3C
P2_Entry_037FEE3E:
	add r4,r7,#0x0	; 037FEE3E
P2_Entry_037FEE40:
	cmp r0,#0x0	; 037FEE40
	bne P2_Entry_037FEE2A	; 037FEE42
	add r0,r6,#0x0	; 037FEE44
	bl loc_037FDCC0	; 037FEE46
	add sp,#0x4	; 037FEE4A
	pop {r4,r5,r6,r7}	; 037FEE4C
	pop {r3}	; 037FEE4E
	bx r3	; 037FEE50
	.byte 0xC0, 0x46	; 037FEE52
pool_037FEE54:
	.word P2_BssStart + 0x668	; 037FEE54
P2_Entry_037FEE58:
	push {r4,r5,lr}	; 037FEE58
	sub sp,#0x4	; 037FEE5A
	add r5,r0,#0x0	; 037FEE5C
	bl loc_037FDC9C	; 037FEE5E
	add r4,r0,#0x0	; 037FEE62
	mov r1,#0x1	; 037FEE64
	str r1,[r5,#0x24]	; 037FEE66
	ldr r1,[r5,#0x0]	; 037FEE68
	cmp r1,#0x0	; 037FEE6A
	bne P2_Entry_037FEE74	; 037FEE6C
	bl loc_037FDCC0	; 037FEE6E
	b P2_Entry_037FEE84	; 037FEE72
P2_Entry_037FEE74:
	add r0,r5,#0x0	; 037FEE74
	bl P2_Entry_037FEFC4	; 037FEE76
	mov r0,#0x0	; 037FEE7A
	str r0,[r5,#0x0]	; 037FEE7C
	add r0,r4,#0x0	; 037FEE7E
	bl loc_037FDCC0	; 037FEE80
P2_Entry_037FEE84:
	add sp,#0x4	; 037FEE84
	pop {r4,r5}	; 037FEE86
	pop {r3}	; 037FEE88
	bx r3	; 037FEE8A

; ===== function loc_037FEE8C =====
loc_037FEE8C:
	push {r4,r5,lr}	; 037FEE8C
	sub sp,#0x4	; 037FEE8E
	add r5,r0,#0x0	; 037FEE90
	add r4,r1,#0x0	; 037FEE92
	cmp r4,#0x0	; 037FEE94
	bne loc_037FEE9C	; 037FEE96
	bl loc_037FF190	; 037FEE98
loc_037FEE9C:
	cmp r5,#0x0	; 037FEE9C
	beq loc_037FEEA2	; 037FEE9E
	str r4,[r5,#0x8]	; 037FEEA0
loc_037FEEA2:
	add sp,#0x4	; 037FEEA2
	pop {r4,r5}	; 037FEEA4
	pop {r3}	; 037FEEA6
	bx r3	; 037FEEA8
	.byte 0x00, 0x00	; 037FEEAA
P2_Entry_037FEEAC:
	push {r4,lr}	; 037FEEAC
	add r4,r0,#0x0	; 037FEEAE
	mov r0,#0x4	; 037FEEB0
	ldr r1,[pool_037FEEEC]	; 037FEEB2
	bl loc_037FDAD0	; 037FEEB4
	mov r0,#0x10	; 037FEEB8
	ldrsh r0,[r4,r0]	; 037FEEBA
	ldr r1,[pool_037FEEF0]	; 037FEEBC
	add r2,r0,#0x0	; 037FEEBE
	and r2,r1	; 037FEEC0
	asr r4,r2,#0x1	; 037FEEC2
	ldr r2,[pool_037FEEF4]	; 037FEEC4
	ldrh r3,[r2,#0x0]	; 037FEEC6
	mov r1,#0x3f	; 037FEEC8
	and r3,r1	; 037FEECA
	mov r1,#0xff	; 037FEECC
	and r0,r1	; 037FEECE
	lsl r0,r0,#0x8	; 037FEED0
	orr r3,r0	; 037FEED2
	orr r4,r3	; 037FEED4
	strh r4,[r2,#0x0]	; 037FEED6
	ldrh r1,[r2,#0x0]	; 037FEED8
	mov r0,#0x20	; 037FEEDA
	orr r1,r0	; 037FEEDC
	strh r1,[r2,#0x0]	; 037FEEDE
	mov r0,#0x4	; 037FEEE0
	bl loc_037FDA4C	; 037FEEE2
	pop {r4}	; 037FEEE6
	pop {r3}	; 037FEEE8
	bx r3	; 037FEEEA
pool_037FEEEC:
	.word P2_IrqHandler_037FED0C + 1	; 037FEEEC
pool_037FEEF0:
	.word 0x00000100	; 037FEEF0
pool_037FEEF4:
	.word REG_DISPSTAT	; 037FEEF4
P2_Entry_037FEEF8:
	push {r4,r5,r6,r7,lr}	; 037FEEF8
	sub sp,#0xc	; 037FEEFA
	add r5,r0,#0x0	; 037FEEFC
	add r4,r1,#0x0	; 037FEEFE
	add r6,r2,#0x0	; 037FEF00
	add r7,r3,#0x0	; 037FEF02
	bl loc_037FDC9C	; 037FEF04
	str r0,[sp,#0x0]	; 037FEF08
	cmp r5,#0x0	; 037FEF0A
	beq P2_Entry_037FEF14	; 037FEF0C
	ldr r0,[r5,#0x0]	; 037FEF0E
	cmp r0,#0x0	; 037FEF10
	beq P2_Entry_037FEF18	; 037FEF12
P2_Entry_037FEF14:
	bl loc_037FF190	; 037FEF14
P2_Entry_037FEF18:
	ldr r0,[pool_037FEF54]	; 037FEF18
	ldrh r0,[r0,#0x0]	; 037FEF1A
	str r0,[sp,#0x4]	; 037FEF1C
	bl P2_Entry_037FECA0	; 037FEF1E
	mov r1,#0x1	; 037FEF22
	str r1,[r5,#0x1c]	; 037FEF24
	strh r4,[r5,#0x10]	; 037FEF26
	ldr r1,[sp,#0x4]	; 037FEF28
	cmp r4,r1	; 037FEF2A
	bgt P2_Entry_037FEF30	; 037FEF2C
	add r0,r0,#0x1	; 037FEF2E
P2_Entry_037FEF30:
	str r0,[r5,#0xc]	; 037FEF30
	strh r6,[r5,#0x12]	; 037FEF32
	str r7,[r5,#0x0]	; 037FEF34
	ldr r0,[sp,#0x20]	; 037FEF36
	str r0,[r5,#0x4]	; 037FEF38
	mov r0,#0x0	; 037FEF3A
	str r0,[r5,#0x24]	; 037FEF3C
	add r0,r5,#0x0	; 037FEF3E
	bl P2_Entry_037FF014	; 037FEF40
	ldr r0,[sp,#0x0]	; 037FEF44
	bl loc_037FDCC0	; 037FEF46
	add sp,#0xc	; 037FEF4A
	pop {r4,r5,r6,r7}	; 037FEF4C
	pop {r3}	; 037FEF4E
	bx r3	; 037FEF50
	.byte 0xC0, 0x46	; 037FEF52
pool_037FEF54:
	.word REG_VCOUNT	; 037FEF54
P2_Entry_037FEF58:
	push {r4,r5,r6,r7,lr}	; 037FEF58
	sub sp,#0xc	; 037FEF5A
	add r5,r0,#0x0	; 037FEF5C
	add r4,r1,#0x0	; 037FEF5E
	add r6,r2,#0x0	; 037FEF60
	add r7,r3,#0x0	; 037FEF62
	bl loc_037FDC9C	; 037FEF64
	str r0,[sp,#0x0]	; 037FEF68
	cmp r5,#0x0	; 037FEF6A
	beq P2_Entry_037FEF74	; 037FEF6C
	ldr r0,[r5,#0x0]	; 037FEF6E
	cmp r0,#0x0	; 037FEF70
	beq P2_Entry_037FEF78	; 037FEF72
P2_Entry_037FEF74:
	bl loc_037FF190	; 037FEF74
P2_Entry_037FEF78:
	ldr r0,[pool_037FEFB4]	; 037FEF78
	ldrh r0,[r0,#0x0]	; 037FEF7A
	str r0,[sp,#0x4]	; 037FEF7C
	bl P2_Entry_037FECA0	; 037FEF7E
	mov r1,#0x0	; 037FEF82
	str r1,[r5,#0x1c]	; 037FEF84
	strh r4,[r5,#0x10]	; 037FEF86
	ldr r1,[sp,#0x4]	; 037FEF88
	cmp r4,r1	; 037FEF8A
	bgt P2_Entry_037FEF90	; 037FEF8C
	add r0,r0,#0x1	; 037FEF8E
P2_Entry_037FEF90:
	str r0,[r5,#0xc]	; 037FEF90
	strh r6,[r5,#0x12]	; 037FEF92
	str r7,[r5,#0x0]	; 037FEF94
	ldr r0,[sp,#0x20]	; 037FEF96
	str r0,[r5,#0x4]	; 037FEF98
	mov r0,#0x0	; 037FEF9A
	str r0,[r5,#0x24]	; 037FEF9C
	add r0,r5,#0x0	; 037FEF9E
	bl P2_Entry_037FF014	; 037FEFA0
	ldr r0,[sp,#0x0]	; 037FEFA4
	bl loc_037FDCC0	; 037FEFA6
	add sp,#0xc	; 037FEFAA
	pop {r4,r5,r6,r7}	; 037FEFAC
	pop {r3}	; 037FEFAE
	bx r3	; 037FEFB0
	.byte 0xC0, 0x46	; 037FEFB2
pool_037FEFB4:
	.word REG_VCOUNT	; 037FEFB4

; ===== function loc_037FEFB8 =====
loc_037FEFB8:
	mov r1,#0x0	; 037FEFB8
	str r1,[r0,#0x0]	; 037FEFBA
	str r1,[r0,#0x8]	; 037FEFBC
	str r1,[r0,#0x20]	; 037FEFBE
	bx lr	; 037FEFC0
	.byte 0x00, 0x00	; 037FEFC2
P2_Entry_037FEFC4:
	cmp r0,#0x0	; 037FEFC4
	beq P2_Entry_037FEFE4	; 037FEFC6
	ldr r2,[r0,#0x14]	; 037FEFC8
	ldr r1,[r0,#0x18]	; 037FEFCA
	cmp r1,#0x0	; 037FEFCC
	beq P2_Entry_037FEFD4	; 037FEFCE
	str r2,[r1,#0x14]	; 037FEFD0
	b P2_Entry_037FEFD8	; 037FEFD2
P2_Entry_037FEFD4:
	ldr r0,[pool_037FEFE8]	; 037FEFD4
	str r2,[r0,#0x4]	; 037FEFD6
P2_Entry_037FEFD8:
	cmp r2,#0x0	; 037FEFD8
	beq P2_Entry_037FEFE0	; 037FEFDA
	str r1,[r2,#0x18]	; 037FEFDC
	bx lr	; 037FEFDE
P2_Entry_037FEFE0:
	ldr r0,[pool_037FEFE8]	; 037FEFE0
	str r1,[r0,#0x0]	; 037FEFE2
P2_Entry_037FEFE4:
	bx lr	; 037FEFE4
	.byte 0xC0, 0x46	; 037FEFE6
pool_037FEFE8:
	.word P2_BssStart + 0x668	; 037FEFE8
P2_Entry_037FEFEC:
	push {lr}	; 037FEFEC
	sub sp,#0x4	; 037FEFEE
	ldr r1,[pool_037FF010]	; 037FEFF0
	ldr r3,[r1,#0x4]	; 037FEFF2
	str r3,[r0,#0x14]	; 037FEFF4
	mov r2,#0x0	; 037FEFF6
	str r2,[r0,#0x18]	; 037FEFF8
	str r0,[r1,#0x4]	; 037FEFFA
	cmp r3,#0x0	; 037FEFFC
	beq P2_Entry_037FF004	; 037FEFFE
	str r0,[r3,#0x18]	; 037FF000
	b P2_Entry_037FF00A	; 037FF002
P2_Entry_037FF004:
	str r0,[r1,#0x0]	; 037FF004
	bl P2_Entry_037FEEAC	; 037FF006
P2_Entry_037FF00A:
	add sp,#0x4	; 037FF00A
	pop {r3}	; 037FF00C
	bx r3	; 037FF00E
pool_037FF010:
	.word P2_BssStart + 0x668	; 037FF010
P2_Entry_037FF014:
	push {r4,lr}	; 037FF014
	ldr r1,[pool_037FF05C]	; 037FF016
	ldr r1,[r1,#0x0]	; 037FF018
	mov r2,#0x10	; 037FF01A
	b P2_Entry_037FF04E	; 037FF01C
P2_Entry_037FF01E:
	ldr r4,[r0,#0xc]	; 037FF01E
	ldr r3,[r1,#0xc]	; 037FF020
	cmp r3,r4	; 037FF022
	bcc P2_Entry_037FF04C	; 037FF024
	cmp r3,r4	; 037FF026
	bne P2_Entry_037FF032	; 037FF028
	ldrsh r4,[r1,r2]	; 037FF02A
	ldrsh r3,[r0,r2]	; 037FF02C
	cmp r4,r3	; 037FF02E
	ble P2_Entry_037FF04C	; 037FF030
P2_Entry_037FF032:
	ldr r2,[r1,#0x14]	; 037FF032
	str r2,[r0,#0x14]	; 037FF034
	str r1,[r0,#0x18]	; 037FF036
	str r0,[r1,#0x14]	; 037FF038
	cmp r2,#0x0	; 037FF03A
	beq P2_Entry_037FF042	; 037FF03C
	str r0,[r2,#0x18]	; 037FF03E
	b P2_Entry_037FF056	; 037FF040
P2_Entry_037FF042:
	ldr r1,[pool_037FF05C]	; 037FF042
	str r0,[r1,#0x0]	; 037FF044
	bl P2_Entry_037FEEAC	; 037FF046
	b P2_Entry_037FF056	; 037FF04A
P2_Entry_037FF04C:
	ldr r1,[r1,#0x18]	; 037FF04C
P2_Entry_037FF04E:
	cmp r1,#0x0	; 037FF04E
	bne P2_Entry_037FF01E	; 037FF050
	bl P2_Entry_037FEFEC	; 037FF052
P2_Entry_037FF056:
	pop {r4}	; 037FF056
	pop {r3}	; 037FF058
	bx r3	; 037FF05A
pool_037FF05C:
	.word P2_BssStart + 0x668	; 037FF05C

; ===== function loc_037FF060 =====
loc_037FF060:
	ldr r0,[pool_037FF068]	; 037FF060
	ldrh r0,[r0,#0x0]	; 037FF062
	bx lr	; 037FF064
	.byte 0xC0, 0x46	; 037FF068
pool_037FF068:
loc_037FF068:
	.word P2_BssStart + 0x65C	; 037FF068

; ===== function loc_037FF06C =====
loc_037FF06C:
	push {lr}	; 037FF06C
	sub sp,#0x4	; 037FF06E
	ldr r0,[pool_037FF09C]	; 037FF070
	ldrh r1,[r0,#0x0]	; 037FF072
	cmp r1,#0x0	; 037FF074
	bne loc_037FF094	; 037FF076
	mov r1,#0x1	; 037FF078
	strh r1,[r0,#0x0]	; 037FF07A
	mov r1,#0x0	; 037FF07C
	ldr r0,[pool_037FF0A0]	; 037FF07E
	str r1,[r0,#0x0]	; 037FF080
	str r1,[r0,#0x4]	; 037FF082
	mov r0,#0x4	; 037FF084
	bl loc_037FDA20	; 037FF086
	mov r1,#0x0	; 037FF08A
	ldr r0,[pool_037FF0A4]	; 037FF08C
	str r1,[r0,#0x0]	; 037FF08E
	ldr r0,[pool_037FF0A8]	; 037FF090
	str r1,[r0,#0x0]	; 037FF092
loc_037FF094:
	add sp,#0x4	; 037FF094
	pop {r3}	; 037FF096
	bx r3	; 037FF098
	.byte 0xC0, 0x46	; 037FF09C
pool_037FF09C:
loc_037FF09C:
	.word P2_BssStart + 0x65C	; 037FF09C
pool_037FF0A0:
loc_037FF0A0:
	.word P2_BssStart + 0x668	; 037FF0A0
pool_037FF0A4:
loc_037FF0A4:
	.word P2_BssStart + 0x664	; 037FF0A4
pool_037FF0A8:
loc_037FF0A8:
	.word P2_BssStart + 0x660	; 037FF0A8
.arm

; ===== function loc_037FF0AC =====
loc_037FF0AC:
	mrs r0,cpsr	; 037FF0AC
	bic r1,r0,#0x80	; 037FF0B0
	msr cpsr_c,r1	; 037FF0B4
	and r0,r0,#0x80	; 037FF0B8
	bx lr	; 037FF0BC

; ===== function loc_037FF0C0 =====
loc_037FF0C0:
	mrs r0,cpsr	; 037FF0C0
	orr r1,r0,#0x80	; 037FF0C4
	msr cpsr_c,r1	; 037FF0C8
	and r0,r0,#0x80	; 037FF0CC
	bx lr	; 037FF0D0

; ===== function loc_037FF0D4 =====
loc_037FF0D4:
	mrs r1,cpsr	; 037FF0D4
	bic r2,r1,#0x80	; 037FF0D8
	orr r2,r2,r0	; 037FF0DC
	msr cpsr_c,r2	; 037FF0E0
	and r0,r1,#0x80	; 037FF0E4
	bx lr	; 037FF0E8

; ===== function loc_037FF0EC =====
loc_037FF0EC:
	mrs r0,cpsr	; 037FF0EC
	orr r1,r0,#0xc0	; 037FF0F0
	msr cpsr_c,r1	; 037FF0F4
	and r0,r0,#0xc0	; 037FF0F8
	bx lr	; 037FF0FC

; ===== function loc_037FF100 =====
loc_037FF100:
	mrs r1,cpsr	; 037FF100
	bic r2,r1,#0xc0	; 037FF104
	orr r2,r2,r0	; 037FF108
	msr cpsr_c,r2	; 037FF10C
	and r0,r1,#0xc0	; 037FF110
	bx lr	; 037FF114

; ===== function loc_037FF118 =====
loc_037FF118:
	mrs r0,cpsr	; 037FF118
	and r0,r0,#0x1f	; 037FF11C
	bx lr	; 037FF120
.thumb

; ===== function loc_037FF124 =====
loc_037FF124:
	push {r4,r5,r6,r7,lr}	; 037FF124
	sub sp,#0x4	; 037FF126
	add r6,r0,#0x0	; 037FF128
	add r5,r1,#0x0	; 037FF12A
	bl loc_037FDC9C	; 037FF12C
	add r7,r0,#0x0	; 037FF130
	ldr r1,[pool_037FF17C]	; 037FF132
	ldrh r4,[r1,#0x0]	; 037FF134
	mov r0,#0x1	; 037FF136
	strh r0,[r1,#0x0]	; 037FF138
	cmp r6,#0x0	; 037FF13A
	beq loc_037FF154	; 037FF13C
	ldr r1,[pool_037FF180]	; 037FF13E
	ldr r0,[r1,#0x0]	; 037FF140
	bic r0,r5	; 037FF142
	str r0,[r1,#0x0]	; 037FF144
	b loc_037FF154	; 037FF146
loc_037FF148:
	bl P2_SwiHalt	; 037FF148
	bl loc_037FAFB4	; 037FF14C
	bl loc_037FDC9C	; 037FF150
loc_037FF154:
	ldr r1,[pool_037FF180]	; 037FF154
	ldr r0,[r1,#0x0]	; 037FF156
	add r2,r5,#0x0	; 037FF158
	and r2,r0	; 037FF15A
	cmp r2,#0x0	; 037FF15C
	beq loc_037FF148	; 037FF15E
	ldr r0,[r1,#0x0]	; 037FF160
	bic r0,r5	; 037FF162
	str r0,[r1,#0x0]	; 037FF164
	ldr r1,[pool_037FF17C]	; 037FF166
	ldrh r0,[r1,#0x0]	; 037FF168
	strh r4,[r1,#0x0]	; 037FF16A
	add r0,r7,#0x0	; 037FF16C
	bl loc_037FDCC0	; 037FF16E
	add sp,#0x4	; 037FF172
	pop {r4,r5,r6,r7}	; 037FF174
	pop {r3}	; 037FF176
	bx r3	; 037FF178
	.byte 0xC0, 0x46	; 037FF17C
pool_037FF17C:
loc_037FF17C:
	.word REG_IME	; 037FF17C
pool_037FF180:
loc_037FF180:
	.word Bios7IrqFlagsAddress	; 037FF180

; ===== function loc_037FF184 =====
loc_037FF184:
	lsr r0,r0,#0x2	; 037FF184
	ldr r3,[pool_037FF18C]	; 037FF186
	bx r3	; 037FF188
	.byte 0xC0, 0x46	; 037FF18C
pool_037FF18C:
loc_037FF18C:
	.word P2_SwiWaitByLoop + 1	; 037FF18C

; ===== function loc_037FF190 =====
loc_037FF190:
	push {lr}	; 037FF190
	sub sp,#0x4	; 037FF192
loc_037FF194:
	bl loc_037FDC9C	; 037FF194
	bl P2_SwiHalt	; 037FF198
	b loc_037FF194	; 037FF19C
	.byte 0x00, 0x00	; 037FF1A0

; ===== function loc_037FF1A0 =====
loc_037FF1A0:
	push {r4,lr}	; 037FF1A0
	add r4,r0,#0x0	; 037FF1A2
	bl loc_037FDC9C	; 037FF1A4
	mov r1,#0x6	; 037FF1A8
	mul r4,r1	; 037FF1AA
	add r1,r4,#0x5	; 037FF1AC
	lsl r2,r1,#0x1	; 037FF1AE
	ldr r1,[pool_037FF1D4]	; 037FF1B0
	add r2,r2,r1	; 037FF1B2
	ldrh r3,[r2,#0x0]	; 037FF1B4
	ldr r1,[pool_037FF1D8]	; 037FF1B6
	and r3,r1	; 037FF1B8
	strh r3,[r2,#0x0]	; 037FF1BA
	ldrh r3,[r2,#0x0]	; 037FF1BC
	ldr r1,[pool_037FF1DC]	; 037FF1BE
	and r3,r1	; 037FF1C0
	strh r3,[r2,#0x0]	; 037FF1C2
	ldrh r1,[r2,#0x0]	; 037FF1C4
	ldrh r1,[r2,#0x0]	; 037FF1C6
	bl loc_037FDCC0	; 037FF1C8
	pop {r4}	; 037FF1CC
	pop {r3}	; 037FF1CE
	bx r3	; 037FF1D0
	.byte 0xC0, 0x46	; 037FF1D4
pool_037FF1D4:
loc_037FF1D4:
	.word REG_DMA0SAD	; 037FF1D4
pool_037FF1D8:
loc_037FF1D8:
	.word 0xFFFFCDFF	; 037FF1D8
pool_037FF1DC:
loc_037FF1DC:
	.word 0xFFFF7FFF	; 037FF1DC
P2_Entry_037FF1E0:
	mov r1,#0x3	; 037FF1E0
	mul r0,r1	; 037FF1E2
	add r0,r0,#0x2	; 037FF1E4
	lsl r1,r0,#0x2	; 037FF1E6
	ldr r0,[pool_037FF1F8]	; 037FF1E8
	add r2,r1,r0	; 037FF1EA
	ldr r0,[pool_037FF1FC]	; 037FF1EC
P2_Entry_037FF1EE:
	ldr r1,[r2,#0x0]	; 037FF1EE
	and r1,r0	; 037FF1F0
	cmp r1,#0x0	; 037FF1F2
	bne P2_Entry_037FF1EE	; 037FF1F4
	bx lr	; 037FF1F6
pool_037FF1F8:
	.word 0x040000B0	; 037FF1F8
pool_037FF1FC:
	.word 0x80000000	; 037FF1FC
P2_Entry_037FF200:
	push {r4,r5,r6,r7,lr}	; 037FF200
	sub sp,#0x4	; 037FF202
	add r5,r0,#0x0	; 037FF204
	add r6,r1,#0x0	; 037FF206
	add r7,r2,#0x0	; 037FF208
	str r3,[sp,#0x0]	; 037FF20A
	cmp r3,#0x0	; 037FF20C
	beq P2_Entry_037FF252	; 037FF20E
	mov r0,#0x3	; 037FF210
	add r1,r5,#0x0	; 037FF212
	mul r1,r0	; 037FF214
	add r0,r1,#0x2	; 037FF216
	lsl r1,r0,#0x2	; 037FF218
	ldr r0,[pool_037FF25C]	; 037FF21A
	add r4,r1,r0	; 037FF21C
	ldr r0,[pool_037FF260]	; 037FF21E
P2_Entry_037FF220:
	ldr r1,[r4,#0x0]	; 037FF220
	and r1,r0	; 037FF222
	cmp r1,#0x0	; 037FF224
	bne P2_Entry_037FF220	; 037FF226
	bl loc_037FDC9C	; 037FF228
	mov r1,#0xc	; 037FF22C
	mul r5,r1	; 037FF22E
	ldr r1,[pool_037FF25C]	; 037FF230
	add r2,r5,r1	; 037FF232
	str r6,[r2,#0x0]	; 037FF234
	str r7,[r2,#0x4]	; 037FF236
	ldr r3,[sp,#0x0]	; 037FF238
	lsr r5,r3,#0x1	; 037FF23A
	ldr r3,[pool_037FF260]	; 037FF23C
	orr r5,r3	; 037FF23E
	str r5,[r2,#0x8]	; 037FF240
	ldr r1,[r1,#0x0]	; 037FF242
	bl loc_037FDCC0	; 037FF244
	ldr r0,[pool_037FF260]	; 037FF248
P2_Entry_037FF24A:
	ldr r1,[r4,#0x0]	; 037FF24A
	and r1,r0	; 037FF24C
	cmp r1,#0x0	; 037FF24E
	bne P2_Entry_037FF24A	; 037FF250
P2_Entry_037FF252:
	add sp,#0x4	; 037FF252
	pop {r4,r5,r6,r7}	; 037FF254
	pop {r3}	; 037FF256
	bx r3	; 037FF258
	.byte 0xC0, 0x46	; 037FF25A
pool_037FF25C:
	.word REG_DMA0SAD	; 037FF25C
pool_037FF260:
	.word 0x80000000	; 037FF260
P2_Entry_037FF264:
	push {r4,r5,r6,r7,lr}	; 037FF264
	sub sp,#0x4	; 037FF266
	add r5,r0,#0x0	; 037FF268
	add r6,r1,#0x0	; 037FF26A
	add r7,r2,#0x0	; 037FF26C
	str r3,[sp,#0x0]	; 037FF26E
	cmp r3,#0x0	; 037FF270
	beq P2_Entry_037FF2BE	; 037FF272
	mov r0,#0x3	; 037FF274
	add r1,r5,#0x0	; 037FF276
	mul r1,r0	; 037FF278
	add r0,r1,#0x2	; 037FF27A
	lsl r1,r0,#0x2	; 037FF27C
	ldr r0,[pool_037FF2C8]	; 037FF27E
	add r4,r1,r0	; 037FF280
	ldr r0,[pool_037FF2CC]	; 037FF282
P2_Entry_037FF284:
	ldr r1,[r4,#0x0]	; 037FF284
	and r1,r0	; 037FF286
	cmp r1,#0x0	; 037FF288
	bne P2_Entry_037FF284	; 037FF28A
	bl loc_037FDC9C	; 037FF28C
	lsl r2,r5,#0x2	; 037FF290
	ldr r1,[pool_037FF2D0]	; 037FF292
	add r1,r2,r1	; 037FF294
	str r7,[r1,#0x0]	; 037FF296
	mov r2,#0xc	; 037FF298
	mul r5,r2	; 037FF29A
	ldr r2,[pool_037FF2C8]	; 037FF29C
	add r3,r5,r2	; 037FF29E
	str r1,[r3,#0x0]	; 037FF2A0
	str r6,[r3,#0x4]	; 037FF2A2
	ldr r1,[sp,#0x0]	; 037FF2A4
	lsr r5,r1,#0x1	; 037FF2A6
	ldr r1,[pool_037FF2D4]	; 037FF2A8
	orr r5,r1	; 037FF2AA
	str r5,[r3,#0x8]	; 037FF2AC
	ldr r1,[r2,#0x0]	; 037FF2AE
	bl loc_037FDCC0	; 037FF2B0
	ldr r0,[pool_037FF2CC]	; 037FF2B4
P2_Entry_037FF2B6:
	ldr r1,[r4,#0x0]	; 037FF2B6
	and r1,r0	; 037FF2B8
	cmp r1,#0x0	; 037FF2BA
	bne P2_Entry_037FF2B6	; 037FF2BC
P2_Entry_037FF2BE:
	add sp,#0x4	; 037FF2BE
	pop {r4,r5,r6,r7}	; 037FF2C0
	pop {r3}	; 037FF2C2
	bx r3	; 037FF2C4
	.byte 0xC0, 0x46	; 037FF2C6
pool_037FF2C8:
	.word REG_DMA0SAD	; 037FF2C8
pool_037FF2CC:
	.word 0x80000000	; 037FF2CC
pool_037FF2D0:
	.word 0x0380FFE0	; 037FF2D0
pool_037FF2D4:
	.word 0x81000000	; 037FF2D4
.arm

; ===== function loc_037FF2D8 =====
loc_037FF2D8:
	mov r3,#0x0	; 037FF2D8
loc_037FF2DC:
	cmp r3,r2	; 037FF2DC
	strlth r0,[r1,r3]	; 037FF2E0
	addlt r3,r3,#0x2	; 037FF2E4
	blt loc_037FF2DC	; 037FF2E8
	bx lr	; 037FF2EC
P2_Entry_037FF2F0:
	mov r12,#0x0	; 037FF2F0
P2_Entry_037FF2F4:
	cmp r12,r2	; 037FF2F4
	ldrlth r3,[r0,r12]	; 037FF2F8
	strlth r3,[r1,r12]	; 037FF2FC
	addlt r12,r12,#0x2	; 037FF300
	blt P2_Entry_037FF2F4	; 037FF304
	bx lr	; 037FF308

; ===== function loc_037FF30C =====
loc_037FF30C:
	add r12,r1,r2	; 037FF30C
loc_037FF310:
	cmp r1,r12	; 037FF310
	stmltia r1!,{r0}	; 037FF314
	blt loc_037FF310	; 037FF318
	bx lr	; 037FF31C

; ===== function loc_037FF320 =====
loc_037FF320:
	add r12,r1,r2	; 037FF320
loc_037FF324:
	cmp r1,r12	; 037FF324
	ldmltia r0!,{r2}	; 037FF328
	stmltia r1!,{r2}	; 037FF32C
	blt loc_037FF324	; 037FF330
	bx lr	; 037FF334
P2_Entry_037FF338:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 037FF338
	add r9,r1,r2	; 037FF33C
	mov r12,r2, lsr #0x5	; 037FF340
	add r12,r1,r12, lsl #0x5	; 037FF344
	mov r2,r0	; 037FF348
	mov r3,r2	; 037FF34C
	mov r4,r2	; 037FF350
	mov r5,r2	; 037FF354
	mov r6,r2	; 037FF358
	mov r7,r2	; 037FF35C
	mov r8,r2	; 037FF360
P2_Entry_037FF364:
	cmp r1,r12	; 037FF364
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 037FF368
	blt P2_Entry_037FF364	; 037FF36C
P2_Entry_037FF370:
	cmp r1,r9	; 037FF370
	stmltia r1!,{r0}	; 037FF374
	blt P2_Entry_037FF370	; 037FF378
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 037FF37C
	bx lr	; 037FF380

; ===== function loc_037FF384 =====
loc_037FF384:
	mov r12,#0x0	; 037FF384
loc_037FF388:
	cmp r12,r2	; 037FF388
	strltb r1,[r0,r12]	; 037FF38C
	addlt r12,r12,#0x1	; 037FF390
	blt loc_037FF388	; 037FF394
	bx lr	; 037FF398
P2_Entry_037FF39C:
	mov r12,#0x0	; 037FF39C
P2_Entry_037FF3A0:
	cmp r12,r2	; 037FF3A0
	ldrltb r3,[r0,r12]	; 037FF3A4
	strltb r3,[r1,r12]	; 037FF3A8
	addlt r12,r12,#0x1	; 037FF3AC
	blt P2_Entry_037FF3A0	; 037FF3B0
	bx lr	; 037FF3B4

; ===== function loc_037FF3B8 =====
loc_037FF3B8:
	swp r0,r0,[r1]	; 037FF3B8
	bx lr	; 037FF3BC
.thumb

; ===== function loc_037FF3C0 =====
loc_037FF3C0:
	push {r4,r5,r6,lr}	; 037FF3C0
	ldr r4,[pool_037FF3F0]	; 037FF3C2
	ldrb r5,[r4,#0x0]	; 037FF3C4
	mov r4,#0x80	; 037FF3C6
	and r5,r4	; 037FF3C8
	cmp r5,#0x0	; 037FF3CA
	beq loc_037FF3D2	; 037FF3CC
	mov r6,#0x1	; 037FF3CE
	b loc_037FF3D4	; 037FF3D0
loc_037FF3D2:
	mov r6,#0x0	; 037FF3D2
loc_037FF3D4:
	lsl r5,r1,#0x2	; 037FF3D4
	lsl r4,r2,#0x4	; 037FF3D6
	lsl r2,r6,#0x7	; 037FF3D8
	lsl r1,r3,#0x5	; 037FF3DA
	orr r2,r1	; 037FF3DC
	orr r4,r2	; 037FF3DE
	orr r5,r4	; 037FF3E0
	orr r0,r5	; 037FF3E2
	ldr r1,[pool_037FF3F0]	; 037FF3E4
	strb r0,[r1,#0x0]	; 037FF3E6
	pop {r4,r5,r6}	; 037FF3E8
	pop {r3}	; 037FF3EA
	bx r3	; 037FF3EC
	.byte 0xC0, 0x46	; 037FF3F0
pool_037FF3F0:
loc_037FF3F0:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF3F0

; ===== function loc_037FF3F4 =====
loc_037FF3F4:
	ldr r1,[pool_037FF3FC]	; 037FF3F4
	strb r0,[r1,#0x0]	; 037FF3F6
	bx lr	; 037FF3F8
	.byte 0xC0, 0x46	; 037FF3FC
pool_037FF3FC:
loc_037FF3FC:
	.word REG_SOUNDCNT_ARM7	; 037FF3FC
P2_Entry_037FF400:
	push {lr}	; 037FF400
	sub sp,#0x4	; 037FF402
	ldr r2,[pool_037FF428]	; 037FF404
	ldrh r1,[r2,#0x0]	; 037FF406
	mov r0,#0x1	; 037FF408
	orr r1,r0	; 037FF40A
	strh r1,[r2,#0x0]	; 037FF40C
	bl loc_038043F0	; 037FF40E
	ldr r0,[pool_037FF42C]	; 037FF412
	bl P2_SwiSoundBiasIncrease	; 037FF414
	ldr r0,[pool_037FF430]	; 037FF418
	bl loc_037FF184	; 037FF41A
	bl P2_Entry_037FF478	; 037FF41E
	add sp,#0x4	; 037FF422
	pop {r3}	; 037FF424
	bx r3	; 037FF426
pool_037FF428:
	.word REG_POWERCNT_ARM7	; 037FF428
pool_037FF42C:
	.word 0x00000100	; 037FF42C
pool_037FF430:
	.word 0x0007AB80	; 037FF430
P2_Entry_037FF434:
	push {lr}	; 037FF434
	sub sp,#0x4	; 037FF436
	bl P2_Entry_037FF468	; 037FF438
	mov r0,#0x80	; 037FF43C
	bl P2_SwiSoundBiasDecrease	; 037FF43E
	ldr r0,[pool_037FF460]	; 037FF442
	bl loc_037FF184	; 037FF444
	mov r0,#0x1	; 037FF448
	bl loc_038043D4	; 037FF44A
	ldr r2,[pool_037FF464]	; 037FF44E
	ldrh r1,[r2,#0x0]	; 037FF450
	mov r0,#0x1	; 037FF452
	bic r1,r0	; 037FF454
	strh r1,[r2,#0x0]	; 037FF456
	add sp,#0x4	; 037FF458
	pop {r3}	; 037FF45A
	bx r3	; 037FF45C
	.byte 0xC0, 0x46	; 037FF45E
pool_037FF460:
	.word 0x00040000	; 037FF460
pool_037FF464:
	.word REG_POWERCNT_ARM7	; 037FF464
P2_Entry_037FF468:
	ldr r2,[pool_037FF474]	; 037FF468
	ldrb r1,[r2,#0x0]	; 037FF46A
	mov r0,#0x80	; 037FF46C
	bic r1,r0	; 037FF46E
	strb r1,[r2,#0x0]	; 037FF470
	bx lr	; 037FF472
pool_037FF474:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF474
P2_Entry_037FF478:
	ldr r2,[pool_037FF484]	; 037FF478
	ldrb r1,[r2,#0x0]	; 037FF47A
	mov r0,#0x80	; 037FF47C
	orr r1,r0	; 037FF47E
	strb r1,[r2,#0x0]	; 037FF480
	bx lr	; 037FF482
pool_037FF484:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF484

; ===== function loc_037FF488 =====
loc_037FF488:
	push {r4,lr}	; 037FF488
	cmp r1,#0x18	; 037FF48A
	bge loc_037FF4A4	; 037FF48C
	ldr r2,[pool_037FF4C4]	; 037FF48E
	ldr r3,[r2,#0x0]	; 037FF490
	ldr r2,[pool_037FF4C8]	; 037FF492
	sub r2,r2,r3	; 037FF494
	lsl r2,r2,#0x6	; 037FF496
	add r1,#0x28	; 037FF498
	mul r3,r1	; 037FF49A
	add r1,r2,r3	; 037FF49C
	mul r0,r1	; 037FF49E
	asr r0,r0,#0x15	; 037FF4A0
	b loc_037FF4BE	; 037FF4A2
loc_037FF4A4:
	cmp r1,#0x68	; 037FF4A4
	ble loc_037FF4BE	; 037FF4A6
	ldr r2,[pool_037FF4C4]	; 037FF4A8
	ldr r4,[r2,#0x0]	; 037FF4AA
	ldr r2,[pool_037FF4C8]	; 037FF4AC
	add r2,r4,r2	; 037FF4AE
	lsl r3,r2,#0x6	; 037FF4B0
	neg r2,r4	; 037FF4B2
	sub r1,#0x28	; 037FF4B4
	mul r2,r1	; 037FF4B6
	add r1,r3,r2	; 037FF4B8
	mul r0,r1	; 037FF4BA
	asr r0,r0,#0x15	; 037FF4BC
loc_037FF4BE:
	pop {r4}	; 037FF4BE
	pop {r3}	; 037FF4C0
	bx r3	; 037FF4C2
pool_037FF4C4:
loc_037FF4C4:
	.word P2_BssStart + 0x670	; 037FF4C4
pool_037FF4C8:
loc_037FF4C8:
	.word 0x00007FFF	; 037FF4C8

; ===== function loc_037FF4CC =====
loc_037FF4CC:
	push {r4,r5,r6,r7,lr}	; 037FF4CC
	sub sp,#0x4	; 037FF4CE
	ldr r1,[pool_037FF504]	; 037FF4D0
	str r0,[r1,#0x0]	; 037FF4D2
	mov r5,#0x0	; 037FF4D4
	ldr r6,[pool_037FF508]	; 037FF4D6
	ldr r7,[pool_037FF50C]	; 037FF4D8
loc_037FF4DA:
	mov r0,#0x1	; 037FF4DA
	lsl r0,r5	; 037FF4DC
	and r0,r7	; 037FF4DE
	cmp r0,#0x0	; 037FF4E0
	beq loc_037FF4F4	; 037FF4E2
	lsl r4,r5,#0x4	; 037FF4E4
	ldr r0,[pool_037FF510]	; 037FF4E6
	ldrb r1,[r4,r0]	; 037FF4E8
	ldrb r0,[r6,r5]	; 037FF4EA
	bl loc_037FF488	; 037FF4EC
	ldr r1,[pool_037FF514]	; 037FF4F0
	strb r0,[r4,r1]	; 037FF4F2
loc_037FF4F4:
	add r5,r5,#0x1	; 037FF4F4
	cmp r5,#0x10	; 037FF4F6
	blt loc_037FF4DA	; 037FF4F8
	add sp,#0x4	; 037FF4FA
	pop {r4,r5,r6,r7}	; 037FF4FC
	pop {r3}	; 037FF4FE
	bx r3	; 037FF500
	.byte 0xC0, 0x46	; 037FF504
pool_037FF504:
loc_037FF504:
	.word P2_BssStart + 0x670	; 037FF504
pool_037FF508:
loc_037FF508:
	.word 0x038059C8	; 037FF508
pool_037FF50C:
loc_037FF50C:
	.word 0x0000FFF5	; 037FF50C
pool_037FF510:
loc_037FF510:
	.word SCHANNEL0_PAN	; 037FF510
pool_037FF514:
loc_037FF514:
	.word SCHANNEL0_CR	; 037FF514

; ===== function loc_037FF518 =====
loc_037FF518:
	lsl r1,r0,#0x4	; 037FF518
	ldr r0,[pool_037FF530]	; 037FF51A
	ldrb r1,[r1,r0]	; 037FF51C
	mov r0,#0x80	; 037FF51E
	and r1,r0	; 037FF520
	cmp r1,#0x0	; 037FF522
	beq loc_037FF52A	; 037FF524
	mov r0,#0x1	; 037FF526
	bx lr	; 037FF528
loc_037FF52A:
	mov r0,#0x0	; 037FF52A
	bx lr	; 037FF52C
	.byte 0xC0, 0x46	; 037FF530
pool_037FF530:
loc_037FF530:
	.word 0x04000403	; 037FF530

; ===== function loc_037FF534 =====
loc_037FF534:
	push {r4,lr}	; 037FF534
	lsl r4,r0,#0x4	; 037FF536
	ldr r2,[pool_037FF564]	; 037FF538
	strb r1,[r4,r2]	; 037FF53A
	ldr r2,[pool_037FF568]	; 037FF53C
	ldr r2,[r2,#0x0]	; 037FF53E
	cmp r2,#0x0	; 037FF540
	ble loc_037FF55C	; 037FF542
	mov r3,#0x1	; 037FF544
	lsl r3,r0	; 037FF546
	ldr r2,[pool_037FF56C]	; 037FF548
	and r3,r2	; 037FF54A
	cmp r3,#0x0	; 037FF54C
	beq loc_037FF55C	; 037FF54E
	ldr r2,[pool_037FF570]	; 037FF550
	ldrb r0,[r2,r0]	; 037FF552
	bl loc_037FF488	; 037FF554
	ldr r1,[pool_037FF574]	; 037FF558
	strb r0,[r4,r1]	; 037FF55A
loc_037FF55C:
	pop {r4}	; 037FF55C
	pop {r3}	; 037FF55E
	bx r3	; 037FF560
	.byte 0xC0, 0x46	; 037FF564
pool_037FF564:
loc_037FF564:
	.word SCHANNEL0_PAN	; 037FF564
pool_037FF568:
loc_037FF568:
	.word P2_BssStart + 0x670	; 037FF568
pool_037FF56C:
loc_037FF56C:
	.word 0x0000FFF5	; 037FF56C
pool_037FF570:
loc_037FF570:
	.word P2_BssStart + 0x674	; 037FF570
pool_037FF574:
loc_037FF574:
	.word SCHANNEL0_CR	; 037FF574

; ===== function loc_037FF578 =====
loc_037FF578:
	ldr r2,[pool_037FF584]	; 037FF578
	sub r2,r2,r1	; 037FF57A
	lsl r1,r0,#0x4	; 037FF57C
	ldr r0,[pool_037FF588]	; 037FF57E
	strh r2,[r1,r0]	; 037FF580
	bx lr	; 037FF582
pool_037FF584:
loc_037FF584:
	.word 0x00010000	; 037FF584
pool_037FF588:
loc_037FF588:
	.word SCHANNEL0_TIMER	; 037FF588

; ===== function loc_037FF58C =====
loc_037FF58C:
	push {r4,r5,lr}	; 037FF58C
	sub sp,#0x4	; 037FF58E
	add r5,r0,#0x0	; 037FF590
	add r4,r2,#0x0	; 037FF592
	ldr r0,[pool_037FF5D0]	; 037FF594
	strb r1,[r0,r5]	; 037FF596
	ldr r0,[pool_037FF5D4]	; 037FF598
	ldr r0,[r0,#0x0]	; 037FF59A
	cmp r0,#0x0	; 037FF59C
	ble loc_037FF5BC	; 037FF59E
	mov r2,#0x1	; 037FF5A0
	lsl r2,r5	; 037FF5A2
	ldr r0,[pool_037FF5D8]	; 037FF5A4
	and r2,r0	; 037FF5A6
	cmp r2,#0x0	; 037FF5A8
	beq loc_037FF5BC	; 037FF5AA
	lsl r2,r5,#0x4	; 037FF5AC
	ldr r0,[pool_037FF5DC]	; 037FF5AE
	ldrb r2,[r2,r0]	; 037FF5B0
	add r0,r1,#0x0	; 037FF5B2
	add r1,r2,#0x0	; 037FF5B4
	bl loc_037FF488	; 037FF5B6
	add r1,r0,#0x0	; 037FF5BA
loc_037FF5BC:
	lsl r2,r4,#0x8	; 037FF5BC
	orr r2,r1	; 037FF5BE
	lsl r1,r5,#0x4	; 037FF5C0
	ldr r0,[pool_037FF5E0]	; 037FF5C2
	strh r2,[r1,r0]	; 037FF5C4
	add sp,#0x4	; 037FF5C6
	pop {r4,r5}	; 037FF5C8
	pop {r3}	; 037FF5CA
	bx r3	; 037FF5CC
	.byte 0xC0, 0x46	; 037FF5D0
pool_037FF5D0:
loc_037FF5D0:
	.word P2_BssStart + 0x674	; 037FF5D0
pool_037FF5D4:
loc_037FF5D4:
	.word P2_BssStart + 0x670	; 037FF5D4
pool_037FF5D8:
loc_037FF5D8:
	.word 0x0000FFF5	; 037FF5D8
pool_037FF5DC:
loc_037FF5DC:
	.word SCHANNEL0_PAN	; 037FF5DC
pool_037FF5E0:
loc_037FF5E0:
	.word SCHANNEL0_CR	; 037FF5E0

; ===== function loc_037FF5E4 =====
loc_037FF5E4:
	lsl r2,r0,#0x4	; 037FF5E4
	ldr r0,[pool_037FF600]	; 037FF5E6
	add r3,r2,r0	; 037FF5E8
	ldr r2,[r3,#0x0]	; 037FF5EA
	ldr r0,[pool_037FF604]	; 037FF5EC
	and r2,r0	; 037FF5EE
	mov r0,#0x1	; 037FF5F0
	and r1,r0	; 037FF5F2
	cmp r1,#0x0	; 037FF5F4
	beq loc_037FF5FC	; 037FF5F6
	ldr r0,[pool_037FF608]	; 037FF5F8
	orr r2,r0	; 037FF5FA
loc_037FF5FC:
	str r2,[r3,#0x0]	; 037FF5FC
	bx lr	; 037FF5FE
pool_037FF600:
loc_037FF600:
	.word SCHANNEL0_CR	; 037FF600
pool_037FF604:
loc_037FF604:
	.word 0x7FFFFFFF	; 037FF604
pool_037FF608:
loc_037FF608:
	.word 0x00008000	; 037FF608

; ===== function loc_037FF60C =====
loc_037FF60C:
	push {r4,r5,r6,lr}	; 037FF60C
	add r5,r2,#0x0	; 037FF60E
	add r6,r3,#0x0	; 037FF610
	lsl r4,r0,#0x4	; 037FF612
	ldr r2,[pool_037FF658]	; 037FF614
	strb r1,[r2,r0]	; 037FF616
	ldr r2,[pool_037FF65C]	; 037FF618
	ldr r2,[r2,#0x0]	; 037FF61A
	cmp r2,#0x0	; 037FF61C
	ble loc_037FF636	; 037FF61E
	mov r2,#0x1	; 037FF620
	lsl r2,r0	; 037FF622
	ldr r0,[pool_037FF660]	; 037FF624
	and r2,r0	; 037FF626
	cmp r2,#0x0	; 037FF628
	beq loc_037FF636	; 037FF62A
	add r0,r1,#0x0	; 037FF62C
	ldr r1,[sp,#0x10]	; 037FF62E
	bl loc_037FF488	; 037FF630
	add r1,r0,#0x0	; 037FF634
loc_037FF636:
	ldr r0,[sp,#0x10]	; 037FF636
	lsl r2,r0,#0x10	; 037FF638
	ldr r0,[pool_037FF664]	; 037FF63A
	orr r2,r0	; 037FF63C
	lsl r0,r5,#0x8	; 037FF63E
	orr r2,r0	; 037FF640
	orr r1,r2	; 037FF642
	ldr r0,[pool_037FF668]	; 037FF644
	str r1,[r4,r0]	; 037FF646
	ldr r0,[pool_037FF66C]	; 037FF648
	sub r1,r0,r6	; 037FF64A
	ldr r0,[pool_037FF670]	; 037FF64C
	strh r1,[r4,r0]	; 037FF64E
	pop {r4,r5,r6}	; 037FF650
	pop {r3}	; 037FF652
	bx r3	; 037FF654
	.byte 0xC0, 0x46	; 037FF658
pool_037FF658:
loc_037FF658:
	.word P2_BssStart + 0x674	; 037FF658
pool_037FF65C:
loc_037FF65C:
	.word P2_BssStart + 0x670	; 037FF65C
pool_037FF660:
loc_037FF660:
	.word 0x0000FFF5	; 037FF660
pool_037FF664:
loc_037FF664:
	.word 0x60000000	; 037FF664
pool_037FF668:
loc_037FF668:
	.word SCHANNEL0_CR	; 037FF668
pool_037FF66C:
loc_037FF66C:
	.word 0x00010000	; 037FF66C
pool_037FF670:
loc_037FF670:
	.word SCHANNEL0_TIMER	; 037FF670

; ===== function loc_037FF674 =====
loc_037FF674:
	push {r4,r5,r6,lr}	; 037FF674
	add r5,r1,#0x0	; 037FF676
	add r6,r3,#0x0	; 037FF678
	lsl r4,r0,#0x4	; 037FF67A
	ldr r1,[pool_037FF6C4]	; 037FF67C
	strb r2,[r1,r0]	; 037FF67E
	ldr r1,[pool_037FF6C8]	; 037FF680
	ldr r1,[r1,#0x0]	; 037FF682
	cmp r1,#0x0	; 037FF684
	ble loc_037FF69E	; 037FF686
	mov r1,#0x1	; 037FF688
	lsl r1,r0	; 037FF68A
	ldr r0,[pool_037FF6CC]	; 037FF68C
	and r1,r0	; 037FF68E
	cmp r1,#0x0	; 037FF690
	beq loc_037FF69E	; 037FF692
	add r0,r2,#0x0	; 037FF694
	ldr r1,[sp,#0x14]	; 037FF696
	bl loc_037FF488	; 037FF698
	add r2,r0,#0x0	; 037FF69C
loc_037FF69E:
	lsl r0,r6,#0x8	; 037FF69E
	lsl r3,r5,#0x18	; 037FF6A0
	ldr r1,[pool_037FF6D0]	; 037FF6A2
	orr r3,r1	; 037FF6A4
	ldr r1,[sp,#0x14]	; 037FF6A6
	lsl r1,r1,#0x10	; 037FF6A8
	orr r3,r1	; 037FF6AA
	orr r0,r3	; 037FF6AC
	orr r2,r0	; 037FF6AE
	ldr r0,[pool_037FF6D4]	; 037FF6B0
	str r2,[r4,r0]	; 037FF6B2
	ldr r1,[sp,#0x10]	; 037FF6B4
	ldr r0,[pool_037FF6D8]	; 037FF6B6
	sub r1,r0,r1	; 037FF6B8
	ldr r0,[pool_037FF6DC]	; 037FF6BA
	strh r1,[r4,r0]	; 037FF6BC
	pop {r4,r5,r6}	; 037FF6BE
	pop {r3}	; 037FF6C0
	bx r3	; 037FF6C2
pool_037FF6C4:
loc_037FF6C4:
	.word P2_BssStart + 0x674	; 037FF6C4
pool_037FF6C8:
loc_037FF6C8:
	.word P2_BssStart + 0x670	; 037FF6C8
pool_037FF6CC:
loc_037FF6CC:
	.word 0x0000FFF5	; 037FF6CC
pool_037FF6D0:
loc_037FF6D0:
	.word 0x60000000	; 037FF6D0
pool_037FF6D4:
loc_037FF6D4:
	.word SCHANNEL0_CR	; 037FF6D4
pool_037FF6D8:
loc_037FF6D8:
	.word 0x00010000	; 037FF6D8
pool_037FF6DC:
loc_037FF6DC:
	.word SCHANNEL0_TIMER	; 037FF6DC

; ===== function loc_037FF6E0 =====
loc_037FF6E0:
	push {r4,r5,r6,r7,lr}	; 037FF6E0
	sub sp,#0x4	; 037FF6E2
	add r5,r1,#0x0	; 037FF6E4
	add r6,r2,#0x0	; 037FF6E6
	add r7,r3,#0x0	; 037FF6E8
	ldr r1,[sp,#0x20]	; 037FF6EA
	lsl r4,r0,#0x4	; 037FF6EC
	ldr r2,[pool_037FF74C]	; 037FF6EE
	strb r1,[r2,r0]	; 037FF6F0
	ldr r2,[pool_037FF750]	; 037FF6F2
	ldr r2,[r2,#0x0]	; 037FF6F4
	cmp r2,#0x0	; 037FF6F6
	ble loc_037FF710	; 037FF6F8
	mov r2,#0x1	; 037FF6FA
	lsl r2,r0	; 037FF6FC
	ldr r0,[pool_037FF754]	; 037FF6FE
	and r2,r0	; 037FF700
	cmp r2,#0x0	; 037FF702
	beq loc_037FF710	; 037FF704
	add r0,r1,#0x0	; 037FF706
	ldr r1,[sp,#0x2c]	; 037FF708
	bl loc_037FF488	; 037FF70A
	add r1,r0,#0x0	; 037FF70E
loc_037FF710:
	ldr r0,[sp,#0x24]	; 037FF710
	lsl r2,r0,#0x8	; 037FF712
	ldr r0,[sp,#0x2c]	; 037FF714
	lsl r0,r0,#0x10	; 037FF716
	lsl r3,r6,#0x1d	; 037FF718
	lsl r6,r7,#0x1b	; 037FF71A
	orr r3,r6	; 037FF71C
	orr r0,r3	; 037FF71E
	orr r2,r0	; 037FF720
	orr r1,r2	; 037FF722
	ldr r0,[pool_037FF758]	; 037FF724
	str r1,[r4,r0]	; 037FF726
	ldr r1,[sp,#0x28]	; 037FF728
	ldr r0,[pool_037FF75C]	; 037FF72A
	sub r1,r0,r1	; 037FF72C
	ldr r0,[pool_037FF760]	; 037FF72E
	strh r1,[r4,r0]	; 037FF730
	ldr r1,[sp,#0x18]	; 037FF732
	ldr r0,[pool_037FF764]	; 037FF734
	strh r1,[r4,r0]	; 037FF736
	ldr r1,[sp,#0x1c]	; 037FF738
	ldr r0,[pool_037FF768]	; 037FF73A
	str r1,[r4,r0]	; 037FF73C
	ldr r0,[pool_037FF76C]	; 037FF73E
	str r5,[r4,r0]	; 037FF740
	add sp,#0x4	; 037FF742
	pop {r4,r5,r6,r7}	; 037FF744
	pop {r3}	; 037FF746
	bx r3	; 037FF748
	.byte 0xC0, 0x46	; 037FF74C
pool_037FF74C:
loc_037FF74C:
	.word P2_BssStart + 0x674	; 037FF74C
pool_037FF750:
loc_037FF750:
	.word P2_BssStart + 0x670	; 037FF750
pool_037FF754:
loc_037FF754:
	.word 0x0000FFF5	; 037FF754
pool_037FF758:
loc_037FF758:
	.word SCHANNEL0_CR	; 037FF758
pool_037FF75C:
loc_037FF75C:
	.word 0x00010000	; 037FF75C
pool_037FF760:
loc_037FF760:
	.word SCHANNEL0_TIMER	; 037FF760
pool_037FF764:
loc_037FF764:
	.word 0x0400040A	; 037FF764
pool_037FF768:
loc_037FF768:
	.word 0x0400040C	; 037FF768
pool_037FF76C:
loc_037FF76C:
	.word 0x04000404	; 037FF76C

; ===== function loc_037FF770 =====
loc_037FF770:
	ldr r1,[pool_037FF788]	; 037FF770
	ldr r2,[r1,#0x0]	; 037FF772
	ldr r0,[pool_037FF78C]	; 037FF774
	mul r2,r0	; 037FF776
	ldr r0,[pool_037FF790]	; 037FF778
	add r0,r2,r0	; 037FF77A
	str r0,[r1,#0x0]	; 037FF77C
	lsr r0,r0,#0x10	; 037FF77E
	lsl r0,r0,#0x10	; 037FF780
	lsr r0,r0,#0x10	; 037FF782
	bx lr	; 037FF784
	.byte 0xC0, 0x46	; 037FF788
pool_037FF788:
loc_037FF788:
	.word P2_Data_03805298	; 037FF788
pool_037FF78C:
loc_037FF78C:
	.word 0x0019660D	; 037FF78C
pool_037FF790:
loc_037FF790:
	.word 0x3C6EF35F	; 037FF790

; ===== function loc_037FF794 =====
loc_037FF794:
	cmp r0,#0x20	; 037FF794
	bge loc_037FF79E	; 037FF796
	ldr r1,[pool_037FF7D0]	; 037FF798
	ldrsb r0,[r1,r0]	; 037FF79A
	bx lr	; 037FF79C
loc_037FF79E:
	cmp r0,#0x40	; 037FF79E
	bge loc_037FF7AC	; 037FF7A0
	mov r1,#0x40	; 037FF7A2
	sub r1,r1,r0	; 037FF7A4
	ldr r0,[pool_037FF7D0]	; 037FF7A6
	ldrsb r0,[r0,r1]	; 037FF7A8
	bx lr	; 037FF7AA
loc_037FF7AC:
	cmp r0,#0x60	; 037FF7AC
	bge loc_037FF7BE	; 037FF7AE
	sub r0,#0x40	; 037FF7B0
	ldr r1,[pool_037FF7D0]	; 037FF7B2
	ldrsb r0,[r1,r0]	; 037FF7B4
	neg r0,r0	; 037FF7B6
	lsl r0,r0,#0x18	; 037FF7B8
	asr r0,r0,#0x18	; 037FF7BA
	bx lr	; 037FF7BC
loc_037FF7BE:
	sub r0,#0x60	; 037FF7BE
	mov r1,#0x20	; 037FF7C0
	sub r1,r1,r0	; 037FF7C2
	ldr r0,[pool_037FF7D0]	; 037FF7C4
	ldrsb r0,[r0,r1]	; 037FF7C6
	neg r0,r0	; 037FF7C8
	lsl r0,r0,#0x18	; 037FF7CA
	asr r0,r0,#0x18	; 037FF7CC
	bx lr	; 037FF7CE
pool_037FF7D0:
loc_037FF7D0:
	.word P2_Data_038050B8	; 037FF7D0

; ===== function loc_037FF7D4 =====
loc_037FF7D4:
	push {r4,lr}	; 037FF7D4
	add r4,r0,#0x0	; 037FF7D6
	ldr r0,[pool_037FF824]	; 037FF7D8
	cmp r4,r0	; 037FF7DA
	bge loc_037FF7E2	; 037FF7DC
	add r4,r0,#0x0	; 037FF7DE
	b loc_037FF7E8	; 037FF7E0
loc_037FF7E2:
	cmp r4,#0x0	; 037FF7E2
	ble loc_037FF7E8	; 037FF7E4
	mov r4,#0x0	; 037FF7E6
loc_037FF7E8:
	ldr r0,[pool_037FF828]	; 037FF7E8
	add r0,r4,r0	; 037FF7EA
	bl loc_03804904	; 037FF7EC
	mov r1,#0xef	; 037FF7F0
	mvn r1,r1	; 037FF7F2
	cmp r4,r1	; 037FF7F4
	bge loc_037FF7FC	; 037FF7F6
	mov r1,#0x3	; 037FF7F8
	b loc_037FF816	; 037FF7FA
loc_037FF7FC:
	mov r1,#0x77	; 037FF7FC
	mvn r1,r1	; 037FF7FE
	cmp r4,r1	; 037FF800
	bge loc_037FF808	; 037FF802
	mov r1,#0x2	; 037FF804
	b loc_037FF816	; 037FF806
loc_037FF808:
	mov r1,#0x3b	; 037FF808
	mvn r1,r1	; 037FF80A
	cmp r4,r1	; 037FF80C
	bge loc_037FF814	; 037FF80E
	mov r1,#0x1	; 037FF810
	b loc_037FF816	; 037FF812
loc_037FF814:
	mov r1,#0x0	; 037FF814
loc_037FF816:
	lsl r1,r1,#0x8	; 037FF816
	orr r1,r0	; 037FF818
	lsl r0,r1,#0x10	; 037FF81A
	lsr r0,r0,#0x10	; 037FF81C
	pop {r4}	; 037FF81E
	pop {r3}	; 037FF820
	bx r3	; 037FF822
pool_037FF824:
loc_037FF824:
	.word 0xFFFFFD2D	; 037FF824
pool_037FF828:
loc_037FF828:
	.word 0x000002D3	; 037FF828

; ===== function loc_037FF82C =====
loc_037FF82C:
	push {r4,r5,r6,lr}	; 037FF82C
	add r5,r0,#0x0	; 037FF82E
	mov r4,#0x0	; 037FF830
	neg r0,r1	; 037FF832
	ldr r1,[pool_037FF8D8]	; 037FF834
	b loc_037FF83C	; 037FF836
loc_037FF838:
	sub r4,r4,#0x1	; 037FF838
	add r0,r0,r1	; 037FF83A
loc_037FF83C:
	cmp r0,#0x0	; 037FF83C
	blt loc_037FF838	; 037FF83E
	ldr r1,[pool_037FF8D8]	; 037FF840
	b loc_037FF848	; 037FF842
loc_037FF844:
	add r4,r4,#0x1	; 037FF844
	sub r0,r0,r1	; 037FF846
loc_037FF848:
	cmp r0,r1	; 037FF848
	bge loc_037FF844	; 037FF84A
	bl loc_03804900	; 037FF84C
	mov r1,#0x0	; 037FF850
	ldr r2,[pool_037FF8DC]	; 037FF852
	add r0,r0,r2	; 037FF854
	adc r1,r1	; 037FF856
	asr r3,r5,#0x1f	; 037FF858
	add r2,r5,#0x0	; 037FF85A
	bl loc_037FEBE4	; 037FF85C
	add r6,r0,#0x0	; 037FF860
	add r5,r1,#0x0	; 037FF862
	add r2,r4,#0x0	; 037FF864
	sub r2,#0x10	; 037FF866
	cmp r2,#0x0	; 037FF868
	bgt loc_037FF876	; 037FF86A
	neg r2,r2	; 037FF86C
	bl loc_037FF8E4	; 037FF86E
	add r5,r1,#0x0	; 037FF872
	b loc_037FF8B2	; 037FF874
loc_037FF876:
	cmp r2,#0x20	; 037FF876
	bge loc_037FF8AE	; 037FF878
	mov r0,#0x0	; 037FF87A
	mvn r0,r0	; 037FF87C
	add r1,r0,#0x0	; 037FF87E
	mov r3,#0x20	; 037FF880
	sub r2,r3,r2	; 037FF882
	bl loc_037FF8F0	; 037FF884
	add r2,r5,#0x0	; 037FF888
	and r2,r1	; 037FF88A
	add r1,r6,#0x0	; 037FF88C
	and r1,r0	; 037FF88E
	mov r0,#0x0	; 037FF890
	eor r2,r0	; 037FF892
	eor r1,r0	; 037FF894
	orr r2,r1	; 037FF896
	beq loc_037FF89E	; 037FF898
	ldr r0,[pool_037FF8E0]	; 037FF89A
	b loc_037FF8D0	; 037FF89C
loc_037FF89E:
	add r0,r6,#0x0	; 037FF89E
	add r1,r5,#0x0	; 037FF8A0
	sub r4,#0x10	; 037FF8A2
	add r2,r4,#0x0	; 037FF8A4
	bl loc_037FF8F0	; 037FF8A6
	add r5,r1,#0x0	; 037FF8AA
	b loc_037FF8B2	; 037FF8AC
loc_037FF8AE:
	ldr r0,[pool_037FF8E0]	; 037FF8AE
	b loc_037FF8D0	; 037FF8B0
loc_037FF8B2:
	mov r2,#0x0	; 037FF8B2
	mov r1,#0x10	; 037FF8B4
	sub r1,r0,r1	; 037FF8B6
	lsl r1,r5,#0	; 037FF8B8
	sbc r1,r2	; 037FF8BA
	bcs loc_037FF8C2	; 037FF8BC
	mov r0,#0x10	; 037FF8BE
	b loc_037FF8CC	; 037FF8C0
loc_037FF8C2:
	ldr r1,[pool_037FF8E0]	; 037FF8C2
	sub r1,r1,r0	; 037FF8C4
	sbc r2,r5	; 037FF8C6
	bcs loc_037FF8CC	; 037FF8C8
	ldr r0,[pool_037FF8E0]	; 037FF8CA
loc_037FF8CC:
	lsl r0,r0,#0x10	; 037FF8CC
	lsr r0,r0,#0x10	; 037FF8CE
loc_037FF8D0:
	pop {r4,r5,r6}	; 037FF8D0
	pop {r3}	; 037FF8D2
	bx r3	; 037FF8D4
	.byte 0xC0, 0x46	; 037FF8D8
pool_037FF8D8:
loc_037FF8D8:
	.word 0x00000300	; 037FF8D8
pool_037FF8DC:
loc_037FF8DC:
	.word 0x00010000	; 037FF8DC
pool_037FF8E0:
loc_037FF8E0:
	.word 0x0000FFFF	; 037FF8E0

; ===== function loc_037FF8E4 =====
loc_037FF8E4:
	bx pc	; 037FF8E4
	.byte 0xC0, 0x46	; 037FF8E8
.arm

; ===== function loc_037FF8E8 =====
loc_037FF8E8:
	ldr pc,[pool_037FF8EC]	; 037FF8E8
pool_037FF8EC:
loc_037FF8EC:
	.word loc_03804F50	; 037FF8EC
.thumb

; ===== function loc_037FF8F0 =====
loc_037FF8F0:
	bx pc	; 037FF8F0
	.byte 0xC0, 0x46	; 037FF8F4
.arm

; ===== function loc_037FF8F4 =====
loc_037FF8F4:
	ldr pc,[pool_037FF8F8]	; 037FF8F4
pool_037FF8F8:
loc_037FF8F8:
	.word loc_03804B30	; 037FF8F8
.thumb
P2_ThreadEntry_037FF8FC:
	push {r4,r5,r6,lr}	; 037FF8FC
	bl P2_Entry_037FF9FC	; 037FF8FE
	bl P2_Entry_03800440	; 037FF902
	bl P2_Entry_03801518	; 037FF906
	bl P2_Entry_038018C8	; 037FF90A
	bl P2_Entry_037FF478	; 037FF90E
	mov r0,#0x0	; 037FF912
	add r1,r0,#0x0	; 037FF914
	add r2,r0,#0x0	; 037FF916
	add r3,r0,#0x0	; 037FF918
	bl loc_037FF3C0	; 037FF91A
	mov r0,#0x7f	; 037FF91E
	bl loc_037FF3F4	; 037FF920
	bl P2_Entry_037FF9BC	; 037FF924
	mov r6,#0x1	; 037FF928
	mov r4,#0x0	; 037FF92A
P2_Entry_037FF92C:
	add r5,r4,#0x0	; 037FF92C
	bl P2_Entry_037FF9A0	; 037FF92E
	cmp r0,#0x1	; 037FF932
	beq P2_Entry_037FF93A	; 037FF934
	cmp r0,#0x2	; 037FF936
	b P2_Entry_037FF93C	; 037FF938
P2_Entry_037FF93A:
	add r5,r6,#0x0	; 037FF93A
P2_Entry_037FF93C:
	bl P2_Entry_03800300	; 037FF93C
	bl P2_Entry_03801B28	; 037FF940
	add r0,r5,#0x0	; 037FF944
	bl P2_Entry_038014BC	; 037FF946
	add r0,r5,#0x0	; 037FF94A
	bl P2_Entry_03800110	; 037FF94C
	bl loc_0380170C	; 037FF950
	bl loc_037FF770	; 037FF954
	b P2_Entry_037FF92C	; 037FF958
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xA9, 0xFC	; 037FF95A
	.byte 0x00, 0x28, 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0x66, 0xFB, 0x01, 0xB0	; 037FF96A
	.byte 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xD8, 0x59, 0x80, 0x03, 0x9C, 0x52, 0x80, 0x03, 0x94, 0x52	; 037FF97A
	.byte 0x80, 0x03	; 037FF98A
.arm
.thumb

; ===== function loc_037FF98C =====
loc_037FF98C:
	ldr r0,[pool_037FF998]	; 037FF98C
	mov r1,#0x2	; 037FF98E
	mov r2,#0x0	; 037FF990
	ldr r3,[pool_037FF99C]	; 037FF992
	bx r3	; 037FF994
	.byte 0xC0, 0x46	; 037FF998
pool_037FF998:
loc_037FF998:
	.word 0x038059D8	; 037FF998
pool_037FF99C:
loc_037FF99C:
	.word loc_037FE2BC + 1	; 037FF99C

; ===== function loc_037FF9A0 =====
P2_Entry_037FF9A0:
	push {lr}	; 037FF9A0
	sub sp,#0x4	; 037FF9A2
	ldr r0,[pool_037FF9B8]	; 037FF9A4
	add r1,sp,#0x0	; 037FF9A6
	mov r2,#0x1	; 037FF9A8
	bl loc_037FE244	; 037FF9AA
	ldr r0,[sp,#0x0]	; 037FF9AE
	add sp,#0x4	; 037FF9B0
	pop {r3}	; 037FF9B2
	bx r3	; 037FF9B4
	.byte 0xC0, 0x46	; 037FF9B8
pool_037FF9B8:
loc_037FF9B8:
	.word 0x038059D8	; 037FF9B8
P2_Entry_037FF9BC:
	push {r4,r5,lr}	; 037FF9BC
	sub sp,#0xc	; 037FF9BE
	bl loc_037FE824	; 037FF9C0
	add r4,r0,#0x0	; 037FF9C4
	ldr r0,[pool_037FF9EC]	; 037FF9C6
	str r0,[sp,#0x4]	; 037FF9C8
	mov r5,#0x0	; 037FF9CA
	str r5,[sp,#0x8]	; 037FF9CC
	ldr r3,[pool_037FF9F0]	; 037FF9CE
	str r5,[sp,#0x0]	; 037FF9D0
	ldr r0,[pool_037FF9F4]	; 037FF9D2
	ldr r2,[pool_037FF9F8]	; 037FF9D4
	add r4,r4,r2	; 037FF9D6
	lsl r2,r1,#0	; 037FF9D8
	adc r2,r5	; 037FF9DA
	add r1,r4,#0x0	; 037FF9DC
	bl loc_037FEA74	; 037FF9DE
	add sp,#0xc	; 037FF9E2
	pop {r4,r5}	; 037FF9E4
	pop {r3}	; 037FF9E6
	bx r3	; 037FF9E8
	.byte 0xC0, 0x46	; 037FF9EA
pool_037FF9EC:
	.word 0x037FF95D	; 037FF9EC
pool_037FF9F0:
	.word 0x00000AA8	; 037FF9F0
pool_037FF9F4:
	.word 0x03805A0C	; 037FF9F4
pool_037FF9F8:
	.word 0x00010000	; 037FF9F8
P2_Entry_037FF9FC:
	push {lr}	; 037FF9FC
	sub sp,#0x4	; 037FF9FE
	ldr r0,[pool_037FFA18]	; 037FFA00
	ldr r1,[pool_037FFA1C]	; 037FFA02
	mov r2,#0x8	; 037FFA04
	bl loc_037FE318	; 037FFA06
	ldr r0,[pool_037FFA20]	; 037FFA0A
	bl loc_037FEBF0	; 037FFA0C
	add sp,#0x4	; 037FFA10
	pop {r3}	; 037FFA12
	bx r3	; 037FFA14
	.byte 0xC0, 0x46	; 037FFA16
pool_037FFA18:
	.word 0x038059D8	; 037FFA18
pool_037FFA1C:
	.word 0x038059EC	; 037FFA1C
pool_037FFA20:
	.word 0x03805A0C	; 037FFA20

; ===== function loc_037FFA24 =====
loc_037FFA24:
	push {lr}	; 037FFA24
	sub sp,#0xc	; 037FFA26
	ldr r1,[pool_037FFA48]	; 037FFA28
	str r1,[sp,#0x0]	; 037FFA2A
	str r0,[sp,#0x4]	; 037FFA2C
	ldr r0,[pool_037FFA4C]	; 037FFA2E
	ldr r1,[pool_037FFA50]	; 037FFA30
	mov r2,#0x0	; 037FFA32
	ldr r3,[pool_037FFA54]	; 037FFA34
	bl P2_CreateThread	; 037FFA36
	ldr r0,[pool_037FFA4C]	; 037FFA3A
	bl loc_037FDE9C	; 037FFA3C
	add sp,#0xc	; 037FFA40
	pop {r3}	; 037FFA42
	bx r3	; 037FFA44
	.byte 0xC0, 0x46	; 037FFA48
pool_037FFA48:
loc_037FFA48:
	.word 0x00000400	; 037FFA48
pool_037FFA4C:
loc_037FFA4C:
	.word 0x03805A38	; 037FFA4C
pool_037FFA50:
loc_037FFA50:
	.word P2_ThreadEntry_037FF8FC + 1	; 037FFA50
pool_037FFA54:
loc_037FFA54:
	.word 0x03805EB0	; 037FFA54

; ===== function loc_037FFA58 =====
loc_037FFA58:
	push {r4,lr}	; 037FFA58
	add r4,r0,#0x0	; 037FFA5A
	bl loc_03801DE0	; 037FFA5C
	add r0,r4,#0x0	; 037FFA60
	bl loc_037FFA24	; 037FFA62
	pop {r4}	; 037FFA66
	pop {r3}	; 037FFA68
	bx r3	; 037FFA6A

; ===== function loc_037FFA6C =====
loc_037FFA6C:
	ldr r1,[pool_037FFA80]	; 037FFA6C
	ldrb r1,[r0,r1]	; 037FFA6E
	mov r0,#0x80	; 037FFA70
	and r1,r0	; 037FFA72
	cmp r1,#0x0	; 037FFA74
	beq loc_037FFA7C	; 037FFA76
	mov r0,#0x1	; 037FFA78
	bx lr	; 037FFA7A
loc_037FFA7C:
	mov r0,#0x0	; 037FFA7C
	bx lr	; 037FFA7E
pool_037FFA80:
loc_037FFA80:
	.word REG_SNDCAP0CNT	; 037FFA80

; ===== function loc_037FFA84 =====
loc_037FFA84:
	push {r4,r5,r6,r7,lr}	; 037FFA84
	sub sp,#0x4	; 037FFA86
	add r4,r0,#0x0	; 037FFA88
	add r0,r2,#0x0	; 037FFA8A
	add r6,r3,#0x0	; 037FFA8C
	lsl r3,r4,#0x3	; 037FFA8E
	ldr r2,[sp,#0x18]	; 037FFA90
	cmp r2,#0x0	; 037FFA92
	beq loc_037FFA9A	; 037FFA94
	mov r5,#0x0	; 037FFA96
	b loc_037FFA9C	; 037FFA98
loc_037FFA9A:
	mov r5,#0x1	; 037FFA9A
loc_037FFA9C:
	ldr r2,[sp,#0x20]	; 037FFA9C
	ldr r7,[sp,#0x1c]	; 037FFA9E
	lsl r7,r7,#0x1	; 037FFAA0
	lsl r1,r1,#0x3	; 037FFAA2
	lsl r5,r5,#0x2	; 037FFAA4
	orr r1,r5	; 037FFAA6
	orr r7,r1	; 037FFAA8
	orr r2,r7	; 037FFAAA
	ldr r1,[pool_037FFAC0]	; 037FFAAC
	strb r2,[r4,r1]	; 037FFAAE
	ldr r1,[pool_037FFAC4]	; 037FFAB0
	str r0,[r3,r1]	; 037FFAB2
	ldr r0,[pool_037FFAC8]	; 037FFAB4
	strh r6,[r3,r0]	; 037FFAB6
	add sp,#0x4	; 037FFAB8
	pop {r4,r5,r6,r7}	; 037FFABA
	pop {r3}	; 037FFABC
	bx r3	; 037FFABE
pool_037FFAC0:
loc_037FFAC0:
	.word REG_SNDCAP0CNT	; 037FFAC0
pool_037FFAC4:
loc_037FFAC4:
	.word REG_SNDCAP0DAD	; 037FFAC4
pool_037FFAC8:
loc_037FFAC8:
	.word REG_SNDCAP0LEN	; 037FFAC8

; ===== function loc_037FFACC =====
loc_037FFACC:
	push {r4,r5,r6,r7,lr}	; 037FFACC
	sub sp,#0x4	; 037FFACE
	add r5,r0,#0x0	; 037FFAD0
	add r6,r1,#0x0	; 037FFAD2
	add r0,#0x28	; 037FFAD4
	bl loc_037FFD24	; 037FFAD6
	add r4,r0,#0x0	; 037FFADA
	asr r3,r4,#0x1f	; 037FFADC
	mov r2,#0x0	; 037FFADE
	add r1,r3,#0x0	; 037FFAE0
	eor r1,r2	; 037FFAE2
	add r7,r4,#0x0	; 037FFAE4
	eor r7,r2	; 037FFAE6
	orr r1,r7	; 037FFAE8
	beq loc_037FFB28	; 037FFAEA
	add r1,r5,#0x0	; 037FFAEC
	add r1,#0x28	; 037FFAEE
	ldrb r1,[r1,#0x0]	; 037FFAF0
	cmp r1,#0x0	; 037FFAF2
	beq loc_037FFB10	; 037FFAF4
	cmp r1,#0x1	; 037FFAF6
	beq loc_037FFB00	; 037FFAF8
	cmp r1,#0x2	; 037FFAFA
	beq loc_037FFB1A	; 037FFAFC
	b loc_037FFB22	; 037FFAFE
loc_037FFB00:
	add r1,r3,#0x0	; 037FFB00
	mov r2,#0x3c	; 037FFB02
	mov r3,#0x0	; 037FFB04
	bl loc_037FFB40	; 037FFB06
	add r4,r0,#0x0	; 037FFB0A
	add r3,r1,#0x0	; 037FFB0C
	b loc_037FFB22	; 037FFB0E
loc_037FFB10:
	lsr r0,r4,#0x1a	; 037FFB10
	lsl r3,r3,#0x6	; 037FFB12
	orr r3,r0	; 037FFB14
	lsl r4,r4,#0x6	; 037FFB16
	b loc_037FFB22	; 037FFB18
loc_037FFB1A:
	lsr r0,r4,#0x1a	; 037FFB1A
	lsl r3,r3,#0x6	; 037FFB1C
	orr r3,r0	; 037FFB1E
	lsl r4,r4,#0x6	; 037FFB20
loc_037FFB22:
	lsl r0,r3,#0x12	; 037FFB22
	lsr r4,r4,#0xe	; 037FFB24
	orr r4,r0	; 037FFB26
loc_037FFB28:
	cmp r6,#0x0	; 037FFB28
	beq loc_037FFB34	; 037FFB2A
	add r5,#0x28	; 037FFB2C
	add r0,r5,#0x0	; 037FFB2E
	bl loc_037FFD58	; 037FFB30
loc_037FFB34:
	add r0,r4,#0x0	; 037FFB34
	add sp,#0x4	; 037FFB36
	pop {r4,r5,r6,r7}	; 037FFB38
	pop {r3}	; 037FFB3A
	bx r3	; 037FFB3C
	.byte 0xC0, 0x46	; 037FFB40

; ===== function loc_037FFB40 =====
loc_037FFB40:
	bx pc	; 037FFB40
	.byte 0xC0, 0x46	; 037FFB44
.arm

; ===== function loc_037FFB44 =====
loc_037FFB44:
	ldr pc,[pool_037FFB48]	; 037FFB44
pool_037FFB48:
loc_037FFB48:
	.word loc_03804B10	; 037FFB48
.thumb

; ===== function loc_037FFB4C =====
loc_037FFB4C:
	push {r4,r5,r6,lr}	; 037FFB4C
	add r5,r0,#0x0	; 037FFB4E
	add r6,r1,#0x0	; 037FFB50
	mov r0,#0x32	; 037FFB52
	ldrsh r0,[r5,r0]	; 037FFB54
	cmp r0,#0x0	; 037FFB56
	bne loc_037FFB5E	; 037FFB58
	mov r0,#0x0	; 037FFB5A
	b loc_037FFB88	; 037FFB5C
loc_037FFB5E:
	ldr r2,[r5,#0x14]	; 037FFB5E
	ldr r4,[r5,#0x18]	; 037FFB60
	cmp r2,r4	; 037FFB62
	blt loc_037FFB6A	; 037FFB64
	mov r0,#0x0	; 037FFB66
	b loc_037FFB88	; 037FFB68
loc_037FFB6A:
	asr r1,r0,#0x1f	; 037FFB6A
	sub r2,r4,r2	; 037FFB6C
	asr r3,r2,#0x1f	; 037FFB6E
	bl loc_037FFB40	; 037FFB70
	asr r3,r4,#0x1f	; 037FFB74
	add r2,r4,#0x0	; 037FFB76
	bl loc_037FFB90	; 037FFB78
	cmp r6,#0x0	; 037FFB7C
	beq loc_037FFB88	; 037FFB7E
	add r5,#0x14	; 037FFB80
	ldr r1,[r5,#0x0]	; 037FFB82
	add r1,r1,#0x1	; 037FFB84
	str r1,[r5,#0x0]	; 037FFB86
loc_037FFB88:
	pop {r4,r5,r6}	; 037FFB88
	pop {r3}	; 037FFB8A
	bx r3	; 037FFB8C
	.byte 0xC0, 0x46	; 037FFB90

; ===== function loc_037FFB90 =====
loc_037FFB90:
	bx pc	; 037FFB90
	.byte 0xC0, 0x46	; 037FFB94
.arm

; ===== function loc_037FFB94 =====
loc_037FFB94:
	ldr pc,[pool_037FFB98]	; 037FFB94
pool_037FFB98:
loc_037FFB98:
	.word loc_03804960	; 037FFB98
.thumb

; ===== function loc_037FFB9C =====
loc_037FFB9C:
	push {r4,lr}	; 037FFB9C
	cmp r1,#0x0	; 037FFB9E
	beq loc_037FFC08	; 037FFBA0
	ldrb r1,[r0,#0x2]	; 037FFBA2
	cmp r1,#0x3	; 037FFBA4
	bhi loc_037FFC08	; 037FFBA6
	add r1,r1,r1	; 037FFBA8
P2_SwitchIndexPC_037FFBA8:
	add r1,pc	; 037FFBAA
	ldrh r1,[r1,#(P2_SwitchTable_037FFBA8 - (P2_SwitchIndexPC_037FFBA8 + 4))]	; 037FFBAC
	lsl r1,r1,#0x10	; 037FFBAE
	asr r1,r1,#0x10	; 037FFBB0
P2_SwitchTargetPC_037FFBA8:
	add r1,pc	; 037FFBB2
	bx r1	; 037FFBB4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FFBA8:
	.halfword (loc_037FFBBE + 1) - (P2_SwitchTargetPC_037FFBA8 + 4)
	.halfword (loc_037FFBD8 + 1) - (P2_SwitchTargetPC_037FFBA8 + 4)
	.halfword (loc_037FFC08 + 1) - (P2_SwitchTargetPC_037FFBA8 + 4)
	.halfword (loc_037FFBFC + 1) - (P2_SwitchTargetPC_037FFBA8 + 4)
P2_SwitchTable_037FFBA8End:
loc_037FFBBE:
	ldr r1,[r0,#0x10]	; 037FFBBE
	neg r2,r1	; 037FFBC0
	ldrb r1,[r0,#0x1c]	; 037FFBC2
	mul r2,r1	; 037FFBC4
	asr r1,r2,#0x8	; 037FFBC6
	neg r1,r1	; 037FFBC8
	str r1,[r0,#0x10]	; 037FFBCA
	ldr r1,[r0,#0x10]	; 037FFBCC
	cmp r1,#0x0	; 037FFBCE
	bne loc_037FFC08	; 037FFBD0
	mov r1,#0x1	; 037FFBD2
	strb r1,[r0,#0x2]	; 037FFBD4
	b loc_037FFC08	; 037FFBD6
loc_037FFBD8:
	ldrb r1,[r0,#0x1d]	; 037FFBD8
	lsl r2,r1,#0x1	; 037FFBDA
	ldr r1,[pool_037FFC14]	; 037FFBDC
	ldrsh r1,[r1,r2]	; 037FFBDE
	lsl r4,r1,#0x7	; 037FFBE0
	add r3,r0,#0x0	; 037FFBE2
	add r3,#0x10	; 037FFBE4
	ldr r2,[r3,#0x0]	; 037FFBE6
	ldrh r1,[r0,#0x1e]	; 037FFBE8
	sub r1,r2,r1	; 037FFBEA
	str r1,[r3,#0x0]	; 037FFBEC
	ldr r1,[r0,#0x10]	; 037FFBEE
	cmp r1,r4	; 037FFBF0
	bgt loc_037FFC08	; 037FFBF2
	str r4,[r0,#0x10]	; 037FFBF4
	mov r1,#0x2	; 037FFBF6
	strb r1,[r0,#0x2]	; 037FFBF8
	b loc_037FFC08	; 037FFBFA
loc_037FFBFC:
	add r3,r0,#0x0	; 037FFBFC
	add r3,#0x10	; 037FFBFE
	ldr r2,[r3,#0x0]	; 037FFC00
	ldrh r1,[r0,#0x20]	; 037FFC02
	sub r1,r2,r1	; 037FFC04
	str r1,[r3,#0x0]	; 037FFC06
loc_037FFC08:
	ldr r0,[r0,#0x10]	; 037FFC08
	asr r0,r0,#0x7	; 037FFC0A
	pop {r4}	; 037FFC0C
	pop {r3}	; 037FFC0E
	bx r3	; 037FFC10
	.byte 0xC0, 0x46	; 037FFC14
pool_037FFC14:
loc_037FFC14:
	.word P2_Data_038050DC	; 037FFC14

; ===== function loc_037FFC18 =====
loc_037FFC18:
	push {r4,r5,lr}	; 037FFC18
	sub sp,#0x4	; 037FFC1A
	ldrh r5,[r0,#0x24]	; 037FFC1C
	mov r0,#0xff	; 037FFC1E
	add r2,r5,#0x0	; 037FFC20
	and r2,r0	; 037FFC22
	ldrh r4,[r1,#0x24]	; 037FFC24
	add r1,r4,#0x0	; 037FFC26
	and r1,r0	; 037FFC28
	lsl r3,r2,#0x4	; 037FFC2A
	lsl r2,r1,#0x4	; 037FFC2C
	asr r0,r5,#0x8	; 037FFC2E
	ldr r1,[pool_037FFC58]	; 037FFC30
	ldrb r0,[r1,r0]	; 037FFC32
	asr r3,r0	; 037FFC34
	asr r0,r4,#0x8	; 037FFC36
	ldrb r0,[r1,r0]	; 037FFC38
	asr r2,r0	; 037FFC3A
	cmp r3,r2	; 037FFC3C
	beq loc_037FFC4E	; 037FFC3E
	cmp r3,r2	; 037FFC40
	bge loc_037FFC48	; 037FFC42
	mov r0,#0x1	; 037FFC44
	b loc_037FFC50	; 037FFC46
loc_037FFC48:
	mov r0,#0x0	; 037FFC48
	mvn r0,r0	; 037FFC4A
	b loc_037FFC50	; 037FFC4C
loc_037FFC4E:
	mov r0,#0x0	; 037FFC4E
loc_037FFC50:
	add sp,#0x4	; 037FFC50
	pop {r4,r5}	; 037FFC52
	pop {r3}	; 037FFC54
	bx r3	; 037FFC56
pool_037FFC58:
loc_037FFC58:
	.word P2_Data_038051DC	; 037FFC58

; ===== function loc_037FFC5C =====
loc_037FFC5C:
	push {lr}	; 037FFC5C
	sub sp,#0x4	; 037FFC5E
	add r2,r0,#0x0	; 037FFC60
	cmp r2,#0x7f	; 037FFC62
	bne loc_037FFC6A	; 037FFC64
	ldr r0,[pool_037FFC94]	; 037FFC66
	b loc_037FFC8E	; 037FFC68
loc_037FFC6A:
	cmp r2,#0x7e	; 037FFC6A
	bne loc_037FFC72	; 037FFC6C
	ldr r0,[pool_037FFC98]	; 037FFC6E
	b loc_037FFC8E	; 037FFC70
loc_037FFC72:
	cmp r2,#0x32	; 037FFC72
	bge loc_037FFC80	; 037FFC74
	lsl r0,r2,#0x1	; 037FFC76
	add r0,r0,#0x1	; 037FFC78
	lsl r0,r0,#0x10	; 037FFC7A
	lsr r0,r0,#0x10	; 037FFC7C
	b loc_037FFC8E	; 037FFC7E
loc_037FFC80:
	ldr r0,[pool_037FFC9C]	; 037FFC80
	mov r1,#0x7e	; 037FFC82
	sub r1,r1,r2	; 037FFC84
	bl loc_037FE2B0	; 037FFC86
	lsl r0,r0,#0x10	; 037FFC8A
	lsr r0,r0,#0x10	; 037FFC8C
loc_037FFC8E:
	add sp,#0x4	; 037FFC8E
	pop {r3}	; 037FFC90
	bx r3	; 037FFC92
pool_037FFC94:
loc_037FFC94:
	.word 0x0000FFFF	; 037FFC94
pool_037FFC98:
loc_037FFC98:
	.word 0x00003C00	; 037FFC98
pool_037FFC9C:
loc_037FFC9C:
	.word 0x00001E00	; 037FFC9C

; ===== function loc_037FFCA0 =====
loc_037FFCA0:
	push {r4,lr}	; 037FFCA0
	add r4,r0,#0x0	; 037FFCA2
	ldr r0,[pool_037FFCD0]	; 037FFCA4
	str r0,[r4,#0x10]	; 037FFCA6
	mov r0,#0x0	; 037FFCA8
	strb r0,[r4,#0x2]	; 037FFCAA
	str r1,[r4,#0x34]	; 037FFCAC
	add r0,r4,#0x0	; 037FFCAE
	add r0,#0x28	; 037FFCB0
	bl loc_037FFD9C	; 037FFCB2
	add r2,r4,#0x3	; 037FFCB6
	ldrb r1,[r2,#0x0]	; 037FFCB8
	mov r0,#0x2	; 037FFCBA
	orr r1,r0	; 037FFCBC
	strb r1,[r2,#0x0]	; 037FFCBE
	ldrb r1,[r2,#0x0]	; 037FFCC0
	mov r0,#0x1	; 037FFCC2
	bic r1,r0	; 037FFCC4
	orr r1,r0	; 037FFCC6
	strb r1,[r2,#0x0]	; 037FFCC8
	pop {r4}	; 037FFCCA
	pop {r3}	; 037FFCCC
	bx r3	; 037FFCCE
pool_037FFCD0:
loc_037FFCD0:
	.word 0xFFFE9680	; 037FFCD0

; ===== function loc_037FFCD4 =====
loc_037FFCD4:
	push {r4,r5,lr}	; 037FFCD4
	sub sp,#0x4	; 037FFCD6
	mov r4,#0x0	; 037FFCD8
	str r4,[r0,#0x50]	; 037FFCDA
	str r1,[r0,#0x48]	; 037FFCDC
	str r2,[r0,#0x4c]	; 037FFCDE
	str r4,[r0,#0x34]	; 037FFCE0
	add r1,r0,#0x0	; 037FFCE2
	add r1,#0x22	; 037FFCE4
	strb r3,[r1,#0x0]	; 037FFCE6
	mov r5,#0x7f	; 037FFCE8
	strh r5,[r0,#0x24]	; 037FFCEA
	add r3,r0,#0x3	; 037FFCEC
	ldrb r2,[r3,#0x0]	; 037FFCEE
	mov r1,#0x2	; 037FFCF0
	bic r2,r1	; 037FFCF2
	strb r2,[r3,#0x0]	; 037FFCF4
	mov r1,#0x3c	; 037FFCF6
	strb r1,[r0,#0x8]	; 037FFCF8
	strb r1,[r0,#0x5]	; 037FFCFA
	strb r5,[r0,#0x9]	; 037FFCFC
	strb r4,[r0,#0xa]	; 037FFCFE
	strh r4,[r0,#0xc]	; 037FFD00
	strh r4,[r0,#0xe]	; 037FFD02
	strb r4,[r0,#0xb]	; 037FFD04
	strh r4,[r0,#0x32]	; 037FFD06
	str r4,[r0,#0x18]	; 037FFD08
	str r4,[r0,#0x14]	; 037FFD0A
	strb r5,[r0,#0x1c]	; 037FFD0C
	strh r5,[r0,#0x1e]	; 037FFD0E
	strb r5,[r0,#0x1d]	; 037FFD10
	strh r5,[r0,#0x20]	; 037FFD12
	add r0,#0x28	; 037FFD14
	bl loc_037FFDA4	; 037FFD16
	add sp,#0x4	; 037FFD1A
	pop {r4,r5}	; 037FFD1C
	pop {r3}	; 037FFD1E
	bx r3	; 037FFD20
	.byte 0x00, 0x00	; 037FFD24

; ===== function loc_037FFD24 =====
loc_037FFD24:
	push {r4,lr}	; 037FFD24
	add r4,r0,#0x0	; 037FFD26
	ldrb r0,[r4,#0x2]	; 037FFD28
	cmp r0,#0x0	; 037FFD2A
	bne loc_037FFD32	; 037FFD2C
	mov r0,#0x0	; 037FFD2E
	b loc_037FFD50	; 037FFD30
loc_037FFD32:
	ldrh r1,[r4,#0x6]	; 037FFD32
	ldrh r0,[r4,#0x4]	; 037FFD34
	cmp r1,r0	; 037FFD36
	bcs loc_037FFD3E	; 037FFD38
	mov r2,#0x0	; 037FFD3A
	b loc_037FFD4E	; 037FFD3C
loc_037FFD3E:
	ldrh r0,[r4,#0x8]	; 037FFD3E
	lsr r0,r0,#0x8	; 037FFD40
	bl loc_037FF794	; 037FFD42
	ldrb r2,[r4,#0x3]	; 037FFD46
	ldrb r1,[r4,#0x2]	; 037FFD48
	mul r1,r0	; 037FFD4A
	mul r2,r1	; 037FFD4C
loc_037FFD4E:
	add r0,r2,#0x0	; 037FFD4E
loc_037FFD50:
	pop {r4}	; 037FFD50
	pop {r3}	; 037FFD52
	bx r3	; 037FFD54
	.byte 0x00, 0x00	; 037FFD58

; ===== function loc_037FFD58 =====
loc_037FFD58:
	push {r4,lr}	; 037FFD58
	ldrh r2,[r0,#0x6]	; 037FFD5A
	ldrh r1,[r0,#0x4]	; 037FFD5C
	cmp r2,r1	; 037FFD5E
	bcs loc_037FFD6C	; 037FFD60
	add r1,r0,#0x6	; 037FFD62
	ldrh r0,[r1,#0x0]	; 037FFD64
	add r0,r0,#0x1	; 037FFD66
	strh r0,[r1,#0x0]	; 037FFD68
	b loc_037FFD96	; 037FFD6A
loc_037FFD6C:
	ldrh r2,[r0,#0x8]	; 037FFD6C
	ldrb r1,[r0,#0x1]	; 037FFD6E
	lsl r3,r1,#0x6	; 037FFD70
	add r1,r2,r3	; 037FFD72
	lsr r4,r1,#0x8	; 037FFD74
	b loc_037FFD7A	; 037FFD76
loc_037FFD78:
	sub r4,#0x80	; 037FFD78
loc_037FFD7A:
	cmp r4,#0x80	; 037FFD7A
	bcs loc_037FFD78	; 037FFD7C
	add r0,#0x8	; 037FFD7E
	ldrh r1,[r0,#0x0]	; 037FFD80
	add r1,r1,r3	; 037FFD82
	strh r1,[r0,#0x0]	; 037FFD84
	ldrh r2,[r0,#0x0]	; 037FFD86
	mov r1,#0xff	; 037FFD88
	and r2,r1	; 037FFD8A
	strh r2,[r0,#0x0]	; 037FFD8C
	ldrh r2,[r0,#0x0]	; 037FFD8E
	lsl r1,r4,#0x8	; 037FFD90
	orr r2,r1	; 037FFD92
	strh r2,[r0,#0x0]	; 037FFD94
loc_037FFD96:
	pop {r4}	; 037FFD96
	pop {r3}	; 037FFD98
	bx r3	; 037FFD9A

; ===== function loc_037FFD9C =====
loc_037FFD9C:
	mov r1,#0x0	; 037FFD9C
	strh r1,[r0,#0x8]	; 037FFD9E
	strh r1,[r0,#0x6]	; 037FFDA0
	bx lr	; 037FFDA2

; ===== function loc_037FFDA4 =====
loc_037FFDA4:
	mov r2,#0x0	; 037FFDA4
	strb r2,[r0,#0x0]	; 037FFDA6
	strb r2,[r0,#0x2]	; 037FFDA8
	mov r1,#0x1	; 037FFDAA
	strb r1,[r0,#0x3]	; 037FFDAC
	mov r1,#0x10	; 037FFDAE
	strb r1,[r0,#0x1]	; 037FFDB0
	strh r2,[r0,#0x4]	; 037FFDB2
	bx lr	; 037FFDB4
	.byte 0x00, 0x00	; 037FFDB8

; ===== function loc_037FFDB8 =====
loc_037FFDB8:
	push {r4,r5,r6,r7,lr}	; 037FFDB8
	sub sp,#0x4	; 037FFDBA
	add r5,r0,#0x0	; 037FFDBC
	add r6,r1,#0x0	; 037FFDBE
	mov r4,#0x0	; 037FFDC0
	add r7,r4,#0x0	; 037FFDC2
loc_037FFDC4:
	add r1,r4,#0x0	; 037FFDC4
	mov r0,#0x54	; 037FFDC6
	mul r1,r0	; 037FFDC8
	ldr r0,[pool_037FFE04]	; 037FFDCA
	add r1,r0,r1	; 037FFDCC
	ldrb r0,[r1,#0x1]	; 037FFDCE
	cmp r0,#0x0	; 037FFDD0
	bne loc_037FFDF0	; 037FFDD2
	ldr r0,[r1,#0x44]	; 037FFDD4
	cmp r5,r0	; 037FFDD6
	bhi loc_037FFDF0	; 037FFDD8
	cmp r0,r6	; 037FFDDA
	bhi loc_037FFDF0	; 037FFDDC
	add r2,r1,#0x3	; 037FFDDE
	ldrb r1,[r2,#0x0]	; 037FFDE0
	mov r0,#0x2	; 037FFDE2
	bic r1,r0	; 037FFDE4
	strb r1,[r2,#0x0]	; 037FFDE6
	add r0,r4,#0x0	; 037FFDE8
	add r1,r7,#0x0	; 037FFDEA
	bl loc_037FF5E4	; 037FFDEC
loc_037FFDF0:
	add r0,r4,#0x1	; 037FFDF0
	lsl r0,r0,#0x18	; 037FFDF2
	lsr r4,r0,#0x18	; 037FFDF4
	cmp r4,#0x10	; 037FFDF6
	bcc loc_037FFDC4	; 037FFDF8
	add sp,#0x4	; 037FFDFA
	pop {r4,r5,r6,r7}	; 037FFDFC
	pop {r3}	; 037FFDFE
	bx r3	; 037FFE00
	.byte 0xC0, 0x46	; 037FFE04
pool_037FFE04:
loc_037FFE04:
	.word 0x03805ED4	; 037FFE04

; ===== function loc_037FFE08 =====
loc_037FFE08:
	mov r2,#0x1	; 037FFE08
	and r1,r2	; 037FFE0A
	cmp r1,#0x0	; 037FFE0C
	beq loc_037FFE1A	; 037FFE0E
	ldr r1,[pool_037FFE24]	; 037FFE10
	ldr r2,[r1,#0x0]	; 037FFE12
	bic r2,r0	; 037FFE14
	str r2,[r1,#0x0]	; 037FFE16
	bx lr	; 037FFE18
loc_037FFE1A:
	ldr r1,[pool_037FFE28]	; 037FFE1A
	ldr r2,[r1,#0x0]	; 037FFE1C
	bic r2,r0	; 037FFE1E
	str r2,[r1,#0x0]	; 037FFE20
	bx lr	; 037FFE22
pool_037FFE24:
loc_037FFE24:
	.word P2_BssStart + 0xB5C	; 037FFE24
pool_037FFE28:
loc_037FFE28:
	.word P2_BssStart + 0xB60	; 037FFE28

; ===== function loc_037FFE2C =====
loc_037FFE2C:
	push {r4,r5,r6,r7,lr}	; 037FFE2C
	sub sp,#0x14	; 037FFE2E
	add r7,r0,#0x0	; 037FFE30
	str r1,[sp,#0x0]	; 037FFE32
	add r6,r7,#0x0	; 037FFE34
	mov r4,#0x0	; 037FFE36
	str r4,[sp,#0x4]	; 037FFE38
	str r4,[sp,#0x8]	; 037FFE3A
	str r4,[sp,#0xc]	; 037FFE3C
	str r4,[sp,#0x10]	; 037FFE3E
	b loc_037FFE9C	; 037FFE40
loc_037FFE42:
	add r1,r6,#0x0	; 037FFE42
	mov r0,#0x1	; 037FFE44
	and r1,r0	; 037FFE46
	cmp r1,#0x0	; 037FFE48
	beq loc_037FFE98	; 037FFE4A
	add r1,r4,#0x0	; 037FFE4C
	mov r0,#0x54	; 037FFE4E
	mul r1,r0	; 037FFE50
	ldr r0,[pool_037FFECC]	; 037FFE52
	add r5,r0,r1	; 037FFE54
	ldr r0,[pool_037FFED0]	; 037FFE56
	ldr r1,[r0,#0x0]	; 037FFE58
	mov r0,#0x1	; 037FFE5A
	lsl r0,r4	; 037FFE5C
	and r1,r0	; 037FFE5E
	cmp r1,#0x0	; 037FFE60
	bne loc_037FFE98	; 037FFE62
	ldr r3,[r5,#0x48]	; 037FFE64
	cmp r3,#0x0	; 037FFE66
	beq loc_037FFE74	; 037FFE68
	add r0,r5,#0x0	; 037FFE6A
	ldr r1,[sp,#0x4]	; 037FFE6C
	ldr r2,[r5,#0x4c]	; 037FFE6E
	bl loc_0380504C	; 037FFE70
loc_037FFE74:
	add r0,r4,#0x0	; 037FFE74
	ldr r1,[sp,#0x8]	; 037FFE76
	bl loc_037FF5E4	; 037FFE78
	add r1,r5,#0x0	; 037FFE7C
	add r1,#0x22	; 037FFE7E
	ldr r0,[sp,#0xc]	; 037FFE80
	strb r0,[r1,#0x0]	; 037FFE82
	add r0,r5,#0x0	; 037FFE84
	bl loc_037FFF5C	; 037FFE86
	ldr r0,[sp,#0x10]	; 037FFE8A
	strb r0,[r5,#0x4]	; 037FFE8C
	add r2,r5,#0x3	; 037FFE8E
	ldrb r1,[r2,#0x0]	; 037FFE90
	mov r0,#0x1	; 037FFE92
	bic r1,r0	; 037FFE94
	strb r1,[r2,#0x0]	; 037FFE96
loc_037FFE98:
	add r4,r4,#0x1	; 037FFE98
	lsr r6,r6,#0x1	; 037FFE9A
loc_037FFE9C:
	cmp r4,#0x10	; 037FFE9C
	bge loc_037FFEA4	; 037FFE9E
	cmp r6,#0x0	; 037FFEA0
	bne loc_037FFE42	; 037FFEA2
loc_037FFEA4:
	mov r1,#0x1	; 037FFEA4
	ldr r0,[sp,#0x0]	; 037FFEA6
	and r0,r1	; 037FFEA8
	str r0,[sp,#0x0]	; 037FFEAA
	cmp r0,#0x0	; 037FFEAC
	beq loc_037FFEBA	; 037FFEAE
	ldr r0,[pool_037FFED4]	; 037FFEB0
	ldr r1,[r0,#0x0]	; 037FFEB2
	orr r1,r7	; 037FFEB4
	str r1,[r0,#0x0]	; 037FFEB6
	b loc_037FFEC2	; 037FFEB8
loc_037FFEBA:
	ldr r0,[pool_037FFED0]	; 037FFEBA
	ldr r1,[r0,#0x0]	; 037FFEBC
	orr r1,r7	; 037FFEBE
	str r1,[r0,#0x0]	; 037FFEC0
loc_037FFEC2:
	add sp,#0x14	; 037FFEC2
	pop {r4,r5,r6,r7}	; 037FFEC4
	pop {r3}	; 037FFEC6
	bx r3	; 037FFEC8
	.byte 0xC0, 0x46	; 037FFECC
pool_037FFECC:
loc_037FFECC:
	.word 0x03805ED4	; 037FFECC
pool_037FFED0:
loc_037FFED0:
	.word P2_BssStart + 0xB60	; 037FFED0
pool_037FFED4:
loc_037FFED4:
	.word P2_BssStart + 0xB5C	; 037FFED4

; ===== function loc_037FFED8 =====
loc_037FFED8:
	push {r4,r5,r6,r7,lr}	; 037FFED8
	sub sp,#0xc	; 037FFEDA
	add r6,r0,#0x0	; 037FFEDC
	mov r4,#0x0	; 037FFEDE
	str r4,[sp,#0x0]	; 037FFEE0
	str r4,[sp,#0x4]	; 037FFEE2
	add r7,r4,#0x0	; 037FFEE4
	str r4,[sp,#0x8]	; 037FFEE6
	b loc_037FFF42	; 037FFEE8
loc_037FFEEA:
	add r1,r6,#0x0	; 037FFEEA
	mov r0,#0x1	; 037FFEEC
	and r1,r0	; 037FFEEE
	cmp r1,#0x0	; 037FFEF0
	beq loc_037FFF3E	; 037FFEF2
	add r1,r4,#0x0	; 037FFEF4
	mov r0,#0x54	; 037FFEF6
	mul r1,r0	; 037FFEF8
	ldr r0,[pool_037FFF54]	; 037FFEFA
	add r5,r0,r1	; 037FFEFC
	ldr r0,[pool_037FFF58]	; 037FFEFE
	ldr r1,[r0,#0x0]	; 037FFF00
	mov r0,#0x1	; 037FFF02
	lsl r0,r4	; 037FFF04
	and r1,r0	; 037FFF06
	cmp r1,#0x0	; 037FFF08
	bne loc_037FFF3E	; 037FFF0A
	ldr r3,[r5,#0x48]	; 037FFF0C
	cmp r3,#0x0	; 037FFF0E
	beq loc_037FFF1C	; 037FFF10
	add r0,r5,#0x0	; 037FFF12
	ldr r1,[sp,#0x0]	; 037FFF14
	ldr r2,[r5,#0x4c]	; 037FFF16
	bl loc_0380504C	; 037FFF18
loc_037FFF1C:
	add r0,r4,#0x0	; 037FFF1C
	ldr r1,[sp,#0x4]	; 037FFF1E
	bl loc_037FF5E4	; 037FFF20
	add r0,r5,#0x0	; 037FFF24
	add r0,#0x22	; 037FFF26
	strb r7,[r0,#0x0]	; 037FFF28
	add r0,r5,#0x0	; 037FFF2A
	bl loc_037FFF5C	; 037FFF2C
	ldr r0,[sp,#0x8]	; 037FFF30
	strb r0,[r5,#0x4]	; 037FFF32
	add r2,r5,#0x3	; 037FFF34
	ldrb r1,[r2,#0x0]	; 037FFF36
	mov r0,#0x1	; 037FFF38
	bic r1,r0	; 037FFF3A
	strb r1,[r2,#0x0]	; 037FFF3C
loc_037FFF3E:
	add r4,r4,#0x1	; 037FFF3E
	lsr r6,r6,#0x1	; 037FFF40
loc_037FFF42:
	cmp r4,#0x10	; 037FFF42
	bge loc_037FFF4A	; 037FFF44
	cmp r6,#0x0	; 037FFF46
	bne loc_037FFEEA	; 037FFF48
loc_037FFF4A:
	add sp,#0xc	; 037FFF4A
	pop {r4,r5,r6,r7}	; 037FFF4C
	pop {r3}	; 037FFF4E
	bx r3	; 037FFF50
	.byte 0xC0, 0x46	; 037FFF54
pool_037FFF54:
loc_037FFF54:
	.word 0x03805ED4	; 037FFF54
pool_037FFF58:
loc_037FFF58:
	.word P2_BssStart + 0xB60	; 037FFF58

; ===== function loc_037FFF5C =====
loc_037FFF5C:
	cmp r0,#0x0	; 037FFF5C
	beq loc_037FFF66	; 037FFF5E
	mov r1,#0x0	; 037FFF60
	str r1,[r0,#0x48]	; 037FFF62
	str r1,[r0,#0x4c]	; 037FFF64
loc_037FFF66:
	bx lr	; 037FFF66

; ===== function loc_037FFF68 =====
P2_Entry_037FFF68:
	push {r4,r5,r6,r7,lr}	; 037FFF68
	sub sp,#0xc	; 037FFF6A
	add r5,r0,#0x0	; 037FFF6C
	str r1,[sp,#0x0]	; 037FFF6E
	str r3,[sp,#0x4]	; 037FFF70
	ldr r0,[pool_0380001C]	; 037FFF72
	ldr r0,[r0,#0x0]	; 037FFF74
	bic r5,r0	; 037FFF76
	cmp r2,#0x0	; 037FFF78
	bne loc_037FFF82	; 037FFF7A
	ldr r0,[pool_03800020]	; 037FFF7C
	ldr r0,[r0,#0x0]	; 037FFF7E
	bic r5,r0	; 037FFF80
loc_037FFF82:
	mov r4,#0x0	; 037FFF82
	add r6,r4,#0x0	; 037FFF84
loc_037FFF86:
	ldr r0,[pool_03800024]	; 037FFF86
	ldrb r0,[r0,r6]	; 037FFF88
	mov r1,#0x1	; 037FFF8A
	lsl r1,r0	; 037FFF8C
	add r2,r5,#0x0	; 037FFF8E
	and r2,r1	; 037FFF90
	cmp r2,#0x0	; 037FFF92
	beq loc_037FFFC8	; 037FFF94
	mov r1,#0x54	; 037FFF96
	mul r0,r1	; 037FFF98
	ldr r1,[pool_03800028]	; 037FFF9A
	add r7,r1,r0	; 037FFF9C
	cmp r4,#0x0	; 037FFF9E
	bne loc_037FFFA6	; 037FFFA0
	add r4,r7,#0x0	; 037FFFA2
	b loc_037FFFC8	; 037FFFA4
loc_037FFFA6:
	add r0,r4,#0x0	; 037FFFA6
	add r0,#0x22	; 037FFFA8
	ldrb r1,[r0,#0x0]	; 037FFFAA
	add r0,r7,#0x0	; 037FFFAC
	add r0,#0x22	; 037FFFAE
	ldrb r0,[r0,#0x0]	; 037FFFB0
	cmp r0,r1	; 037FFFB2
	bhi loc_037FFFC8	; 037FFFB4
	cmp r0,r1	; 037FFFB6
	bne loc_037FFFC6	; 037FFFB8
	add r0,r4,#0x0	; 037FFFBA
	add r1,r7,#0x0	; 037FFFBC
	bl loc_037FFC18	; 037FFFBE
	cmp r0,#0x0	; 037FFFC2
	bge loc_037FFFC8	; 037FFFC4
loc_037FFFC6:
	add r4,r7,#0x0	; 037FFFC6
loc_037FFFC8:
	add r6,r6,#0x1	; 037FFFC8
	cmp r6,#0x10	; 037FFFCA
	blt loc_037FFF86	; 037FFFCC
	cmp r4,#0x0	; 037FFFCE
	bne loc_037FFFD6	; 037FFFD0
	mov r0,#0x0	; 037FFFD2
	b loc_03800012	; 037FFFD4
loc_037FFFD6:
	add r0,r4,#0x0	; 037FFFD6
	add r0,#0x22	; 037FFFD8
	ldrb r1,[r0,#0x0]	; 037FFFDA
	ldr r0,[sp,#0x0]	; 037FFFDC
	cmp r0,r1	; 037FFFDE
	bge loc_037FFFE6	; 037FFFE0
	mov r0,#0x0	; 037FFFE2
	b loc_03800012	; 037FFFE4
loc_037FFFE6:
	ldr r3,[r4,#0x48]	; 037FFFE6
	cmp r3,#0x0	; 037FFFE8
	beq loc_037FFFF6	; 037FFFEA
	add r0,r4,#0x0	; 037FFFEC
	mov r1,#0x0	; 037FFFEE
	ldr r2,[r4,#0x4c]	; 037FFFF0
	bl loc_0380504C	; 037FFFF2
loc_037FFFF6:
	mov r0,#0x2	; 037FFFF6
	strb r0,[r4,#0x4]	; 037FFFF8
	add r2,r4,#0x3	; 037FFFFA
	ldrb r1,[r2,#0x0]	; 037FFFFC
	mov r0,#0x1	; 037FFFFE
	bic r1,r0	; 03800000
	strb r1,[r2,#0x0]	; 03800002
	add r0,r4,#0x0	; 03800004
	ldr r1,[sp,#0x4]	; 03800006
	ldr r2,[sp,#0x20]	; 03800008
	ldr r3,[sp,#0x0]	; 0380000A
	bl loc_037FFCD4	; 0380000C
	add r0,r4,#0x0	; 03800010
loc_03800012:
	add sp,#0xc	; 03800012
	pop {r4,r5,r6,r7}	; 03800014
	pop {r3}	; 03800016
	bx r3	; 03800018
	.byte 0xC0, 0x46	; 0380001C
pool_0380001C:
loc_0380001C:
	.word P2_BssStart + 0xB60	; 0380001C
pool_03800020:
loc_03800020:
	.word P2_BssStart + 0xB5C	; 03800020
pool_03800024:
loc_03800024:
	.word P2_Data_038051E0	; 03800024
pool_03800028:
loc_03800028:
	.word 0x03805ED4	; 03800028

; ===== function loc_0380002C =====
loc_0380002C:
	ldrb r0,[r0,#0x3]	; 0380002C
	lsl r0,r0,#0x1f	; 0380002E
	lsr r0,r0,#0x1f	; 03800030
	bx lr	; 03800032

; ===== function loc_03800034 =====
loc_03800034:
	mov r1,#0x3	; 03800034
	strb r1,[r0,#0x2]	; 03800036
	bx lr	; 03800038
	.byte 0x00, 0x00	; 0380003C

; ===== function loc_0380003C =====
loc_0380003C:
	push {r4,lr}	; 0380003C
	add r4,r0,#0x0	; 0380003E
	add r0,r1,#0x0	; 03800040
	bl loc_037FFC5C	; 03800042
	strh r0,[r4,#0x20]	; 03800046
	pop {r4}	; 03800048
	pop {r3}	; 0380004A
	bx r3	; 0380004C
	.byte 0x00, 0x00	; 03800050

; ===== function loc_03800050 =====
loc_03800050:
	strb r1,[r0,#0x1d]	; 03800050
	bx lr	; 03800052

; ===== function loc_03800054 =====
loc_03800054:
	push {r4,lr}	; 03800054
	add r4,r0,#0x0	; 03800056
	add r0,r1,#0x0	; 03800058
	bl loc_037FFC5C	; 0380005A
	strh r0,[r4,#0x1e]	; 0380005E
	pop {r4}	; 03800060
	pop {r3}	; 03800062
	bx r3	; 03800064
	.byte 0x00, 0x00	; 03800068

; ===== function loc_03800068 =====
loc_03800068:
	cmp r1,#0x6d	; 03800068
	bge loc_03800074	; 0380006A
	mov r2,#0xff	; 0380006C
	sub r1,r2,r1	; 0380006E
	strb r1,[r0,#0x1c]	; 03800070
	bx lr	; 03800072
loc_03800074:
	mov r2,#0x7f	; 03800074
	sub r2,r2,r1	; 03800076
	ldr r1,[pool_03800080]	; 03800078
	ldrb r1,[r1,r2]	; 0380007A
	strb r1,[r0,#0x1c]	; 0380007C
	bx lr	; 0380007E
pool_03800080:
loc_03800080:
	.word P2_Data_038051F0	; 03800080

; ===== function loc_03800084 =====
loc_03800084:
	push {lr}	; 03800084
	sub sp,#0x4	; 03800086
	ldrb r2,[r0,#0x0]	; 03800088
	cmp r2,#0xe	; 0380008A
	bcs loc_03800092	; 0380008C
	mov r0,#0x0	; 0380008E
	b loc_038000A8	; 03800090
loc_03800092:
	cmp r2,#0xf	; 03800092
	bls loc_0380009A	; 03800094
	mov r0,#0x0	; 03800096
	b loc_038000A8	; 03800098
loc_0380009A:
	mov r2,#0x2	; 0380009A
	strb r2,[r0,#0x1]	; 0380009C
	ldr r2,[pool_038000B0]	; 0380009E
	strh r2,[r0,#0x3c]	; 038000A0
	bl loc_037FFCA0	; 038000A2
	mov r0,#0x1	; 038000A6
loc_038000A8:
	add sp,#0x4	; 038000A8
	pop {r3}	; 038000AA
	bx r3	; 038000AC
	.byte 0xC0, 0x46	; 038000B0
pool_038000B0:
loc_038000B0:
	.word 0x00001F46	; 038000B0

; ===== function loc_038000B4 =====
loc_038000B4:
	push {lr}	; 038000B4
	sub sp,#0x4	; 038000B6
	ldrb r3,[r0,#0x0]	; 038000B8
	cmp r3,#0x8	; 038000BA
	bcs loc_038000C2	; 038000BC
	mov r0,#0x0	; 038000BE
	b loc_038000DC	; 038000C0
loc_038000C2:
	cmp r3,#0xd	; 038000C2
	bls loc_038000CA	; 038000C4
	mov r0,#0x0	; 038000C6
	b loc_038000DC	; 038000C8
loc_038000CA:
	mov r3,#0x1	; 038000CA
	strb r3,[r0,#0x1]	; 038000CC
	str r1,[r0,#0x44]	; 038000CE
	ldr r1,[pool_038000E4]	; 038000D0
	strh r1,[r0,#0x3c]	; 038000D2
	add r1,r2,#0x0	; 038000D4
	bl loc_037FFCA0	; 038000D6
	mov r0,#0x1	; 038000DA
loc_038000DC:
	add sp,#0x4	; 038000DC
	pop {r3}	; 038000DE
	bx r3	; 038000E0
	.byte 0xC0, 0x46	; 038000E4
pool_038000E4:
loc_038000E4:
	.word 0x00001F46	; 038000E4

; ===== function loc_038000E8 =====
loc_038000E8:
	push {r4,r5,r6,lr}	; 038000E8
	add r6,r0,#0x0	; 038000EA
	add r5,r1,#0x0	; 038000EC
	mov r0,#0x0	; 038000EE
	strb r0,[r6,#0x1]	; 038000F0
	add r4,r6,#0x0	; 038000F2
	add r4,#0x38	; 038000F4
	ldmia r5!,{r0,r1}	; 038000F6
	stmia r4!,{r0,r1}	; 038000F8
	ldr r0,[r5,#0x0]	; 038000FA
	str r0,[r4,#0x0]	; 038000FC
	str r2,[r6,#0x44]	; 038000FE
	add r0,r6,#0x0	; 03800100
	add r1,r3,#0x0	; 03800102
	bl loc_037FFCA0	; 03800104
	mov r0,#0x1	; 03800108
	pop {r4,r5,r6}	; 0380010A
	pop {r3}	; 0380010C
	bx r3	; 0380010E

; ===== function loc_03800110 =====
P2_Entry_03800110:
	push {r4,r5,r6,r7,lr}	; 03800110
	sub sp,#0x24	; 03800112
	str r0,[sp,#0x0]	; 03800114
	mov r0,#0x0	; 03800116
	str r0,[sp,#0x4]	; 03800118
	str r0,[sp,#0xc]	; 0380011A
	str r0,[sp,#0x14]	; 0380011C
	str r0,[sp,#0x1c]	; 0380011E
	str r0,[sp,#0x18]	; 03800120
	str r0,[sp,#0x10]	; 03800122
	str r0,[sp,#0x8]	; 03800124
loc_03800126:
	ldr r6,[sp,#0x8]	; 03800126
	lsl r7,r6,#0	; 03800128
	lsl r4,r6,#0	; 0380012A
	ldr r1,[sp,#0x4]	; 0380012C
	mov r0,#0x54	; 0380012E
	mul r1,r0	; 03800130
	ldr r0,[pool_038002F0]	; 03800132
	add r5,r0,r1	; 03800134
	ldrb r0,[r5,#0x3]	; 03800136
	lsl r1,r0,#0x1f	; 03800138
	lsr r1,r1,#0x1f	; 0380013A
	cmp r1,#0x0	; 0380013C
	bne loc_03800142	; 0380013E
	b loc_038002DC	; 03800140
loc_03800142:
	lsl r0,r0,#0x1e	; 03800142
	lsr r0,r0,#0x1f	; 03800144
	cmp r0,#0x0	; 03800146
	beq loc_03800160	; 03800148
	add r2,r5,#0x4	; 0380014A
	ldrb r1,[r2,#0x0]	; 0380014C
	mov r0,#0x1	; 0380014E
	orr r1,r0	; 03800150
	strb r1,[r2,#0x0]	; 03800152
	add r2,r5,#0x3	; 03800154
	ldrb r1,[r2,#0x0]	; 03800156
	mov r0,#0x2	; 03800158
	bic r1,r0	; 0380015A
	strb r1,[r2,#0x0]	; 0380015C
	b loc_03800194	; 0380015E
loc_03800160:
	ldr r0,[sp,#0x4]	; 03800160
	bl loc_037FF518	; 03800162
	cmp r0,#0x0	; 03800166
	bne loc_03800194	; 03800168
	ldr r3,[r5,#0x48]	; 0380016A
	cmp r3,#0x0	; 0380016C
	beq loc_0380017C	; 0380016E
	add r0,r5,#0x0	; 03800170
	mov r1,#0x2	; 03800172
	ldr r2,[r5,#0x4c]	; 03800174
	bl loc_0380504C	; 03800176
	b loc_03800184	; 0380017A
loc_0380017C:
	add r1,r5,#0x0	; 0380017C
	add r1,#0x22	; 0380017E
	ldr r0,[sp,#0xc]	; 03800180
	strb r0,[r1,#0x0]	; 03800182
loc_03800184:
	ldr r0,[sp,#0x10]	; 03800184
	strh r0,[r5,#0x24]	; 03800186
	add r2,r5,#0x3	; 03800188
	ldrb r1,[r2,#0x0]	; 0380018A
	mov r0,#0x1	; 0380018C
	bic r1,r0	; 0380018E
	strb r1,[r2,#0x0]	; 03800190
	b loc_038002DC	; 03800192
loc_03800194:
	ldrb r0,[r5,#0x9]	; 03800194
	lsl r1,r0,#0x1	; 03800196
	ldr r0,[pool_038002F4]	; 03800198
	ldrsh r0,[r0,r1]	; 0380019A
	add r6,r6,r0	; 0380019C
	ldrb r1,[r5,#0x8]	; 0380019E
	ldrb r0,[r5,#0x5]	; 038001A0
	sub r0,r1,r0	; 038001A2
	lsl r0,r0,#0x6	; 038001A4
	add r7,r7,r0	; 038001A6
	add r0,r5,#0x0	; 038001A8
	ldr r1,[sp,#0x0]	; 038001AA
	bl loc_037FFB9C	; 038001AC
	add r6,r6,r0	; 038001B0
	add r0,r5,#0x0	; 038001B2
	ldr r1,[sp,#0x0]	; 038001B4
	bl loc_037FFB4C	; 038001B6
	add r7,r7,r0	; 038001BA
	add r0,r5,#0x0	; 038001BC
	ldr r1,[sp,#0x0]	; 038001BE
	bl loc_037FFACC	; 038001C0
	add r1,r5,#0x0	; 038001C4
	add r1,#0x28	; 038001C6
	ldrb r1,[r1,#0x0]	; 038001C8
	cmp r1,#0x0	; 038001CA
	beq loc_038001DC	; 038001CC
	cmp r1,#0x1	; 038001CE
	beq loc_038001D8	; 038001D0
	cmp r1,#0x2	; 038001D2
	beq loc_038001E0	; 038001D4
	b loc_038001E2	; 038001D6
loc_038001D8:
	add r6,r6,r0	; 038001D8
	b loc_038001E2	; 038001DA
loc_038001DC:
	add r7,r7,r0	; 038001DC
	b loc_038001E2	; 038001DE
loc_038001E0:
	add r4,r4,r0	; 038001E0
loc_038001E2:
	mov r0,#0xc	; 038001E2
	ldrsh r0,[r5,r0]	; 038001E4
	add r6,r6,r0	; 038001E6
	mov r0,#0xe	; 038001E8
	ldrsh r0,[r5,r0]	; 038001EA
	add r7,r7,r0	; 038001EC
	mov r0,#0xb	; 038001EE
	ldrsb r0,[r5,r0]	; 038001F0
	add r1,r4,r0	; 038001F2
	mov r0,#0xa	; 038001F4
	ldrsb r0,[r5,r0]	; 038001F6
	add r4,r1,r0	; 038001F8
	ldrb r0,[r5,#0x2]	; 038001FA
	cmp r0,#0x3	; 038001FC
	bne loc_03800234	; 038001FE
	ldr r0,[pool_038002F8]	; 03800200
	cmp r6,r0	; 03800202
	bgt loc_03800234	; 03800204
	mov r0,#0x2	; 03800206
	strb r0,[r5,#0x4]	; 03800208
	ldr r3,[r5,#0x48]	; 0380020A
	cmp r3,#0x0	; 0380020C
	beq loc_0380021C	; 0380020E
	add r0,r5,#0x0	; 03800210
	mov r1,#0x2	; 03800212
	ldr r2,[r5,#0x4c]	; 03800214
	bl loc_0380504C	; 03800216
	b loc_03800224	; 0380021A
loc_0380021C:
	add r1,r5,#0x0	; 0380021C
	add r1,#0x22	; 0380021E
	ldr r0,[sp,#0x14]	; 03800220
	strb r0,[r1,#0x0]	; 03800222
loc_03800224:
	ldr r0,[sp,#0x18]	; 03800224
	strh r0,[r5,#0x24]	; 03800226
	add r2,r5,#0x3	; 03800228
	ldrb r1,[r2,#0x0]	; 0380022A
	mov r0,#0x1	; 0380022C
	bic r1,r0	; 0380022E
	strb r1,[r2,#0x0]	; 03800230
	b loc_038002DC	; 03800232
loc_03800234:
	add r0,r6,#0x0	; 03800234
	bl loc_037FF7D4	; 03800236
	add r6,r0,#0x0	; 0380023A
	ldrh r0,[r5,#0x3c]	; 0380023C
	add r1,r7,#0x0	; 0380023E
	bl loc_037FF82C	; 03800240
	ldrb r1,[r5,#0x1]	; 03800244
	cmp r1,#0x1	; 03800246
	bne loc_03800252	; 03800248
	ldr r1,[pool_038002FC]	; 0380024A
	and r0,r1	; 0380024C
	lsl r0,r0,#0x10	; 0380024E
	lsr r0,r0,#0x10	; 03800250
loc_03800252:
	add r4,#0x40	; 03800252
	cmp r4,#0x0	; 03800254
	bge loc_0380025C	; 03800256
	ldr r4,[sp,#0x1c]	; 03800258
	b loc_03800262	; 0380025A
loc_0380025C:
	cmp r4,#0x7f	; 0380025C
	ble loc_03800262	; 0380025E
	mov r4,#0x7f	; 03800260
loc_03800262:
	ldrh r1,[r5,#0x24]	; 03800262
	cmp r6,r1	; 03800264
	beq loc_03800274	; 03800266
	strh r6,[r5,#0x24]	; 03800268
	add r3,r5,#0x4	; 0380026A
	ldrb r2,[r3,#0x0]	; 0380026C
	mov r1,#0x8	; 0380026E
	orr r2,r1	; 03800270
	strb r2,[r3,#0x0]	; 03800272
loc_03800274:
	ldrh r1,[r5,#0x26]	; 03800274
	cmp r0,r1	; 03800276
	beq loc_03800286	; 03800278
	strh r0,[r5,#0x26]	; 0380027A
	add r2,r5,#0x4	; 0380027C
	ldrb r1,[r2,#0x0]	; 0380027E
	mov r0,#0x4	; 03800280
	orr r1,r0	; 03800282
	strb r1,[r2,#0x0]	; 03800284
loc_03800286:
	add r0,r5,#0x0	; 03800286
	add r0,#0x23	; 03800288
	ldrb r0,[r0,#0x0]	; 0380028A
	cmp r4,r0	; 0380028C
	beq loc_038002A0	; 0380028E
	add r0,r5,#0x0	; 03800290
	add r0,#0x23	; 03800292
	strb r4,[r0,#0x0]	; 03800294
	add r2,r5,#0x4	; 03800296
	ldrb r1,[r2,#0x0]	; 03800298
	mov r0,#0x10	; 0380029A
	orr r1,r0	; 0380029C
	strb r1,[r2,#0x0]	; 0380029E
loc_038002A0:
	ldr r0,[sp,#0x0]	; 038002A0
	cmp r0,#0x0	; 038002A2
	beq loc_038002DC	; 038002A4
	ldr r0,[r5,#0x34]	; 038002A6
	cmp r0,#0x0	; 038002A8
	ble loc_038002DC	; 038002AA
	add r1,r5,#0x0	; 038002AC
	add r1,#0x34	; 038002AE
	ldr r0,[r1,#0x0]	; 038002B0
	sub r0,r0,#0x1	; 038002B2
	str r0,[r1,#0x0]	; 038002B4
	ldr r0,[r5,#0x34]	; 038002B6
	cmp r0,#0x0	; 038002B8
	bne loc_038002DC	; 038002BA
	ldr r3,[r5,#0x48]	; 038002BC
	cmp r3,#0x0	; 038002BE
	beq loc_038002CE	; 038002C0
	add r0,r5,#0x0	; 038002C2
	mov r1,#0x1	; 038002C4
	ldr r2,[r5,#0x4c]	; 038002C6
	bl loc_0380504C	; 038002C8
	b loc_038002D6	; 038002CC
loc_038002CE:
	add r1,r5,#0x0	; 038002CE
	add r1,#0x22	; 038002D0
	mov r0,#0x1	; 038002D2
	strb r0,[r1,#0x0]	; 038002D4
loc_038002D6:
	add r0,r5,#0x0	; 038002D6
	bl loc_03800034	; 038002D8
loc_038002DC:
	ldr r0,[sp,#0x4]	; 038002DC
	add r0,r0,#0x1	; 038002DE
	str r0,[sp,#0x4]	; 038002E0
	cmp r0,#0x10	; 038002E2
	bge loc_038002E8	; 038002E4
	b loc_03800126	; 038002E6
loc_038002E8:
	add sp,#0x24	; 038002E8
	pop {r4,r5,r6,r7}	; 038002EA
	pop {r3}	; 038002EC
	bx r3	; 038002EE
pool_038002F0:
loc_038002F0:
	.word 0x03805ED4	; 038002F0
pool_038002F4:
loc_038002F4:
	.word P2_Data_038050DC	; 038002F4
pool_038002F8:
loc_038002F8:
	.word 0xFFFFFD2D	; 038002F8
pool_038002FC:
loc_038002FC:
	.word 0x0000FFFC	; 038002FC
P2_Entry_03800300:
	push {r4,r5,r6,r7,lr}	; 03800300
	sub sp,#0x1c	; 03800302
	mov r4,#0x0	; 03800304
	add r7,r4,#0x0	; 03800306
	mov r6,#0xff	; 03800308
P2_Entry_0380030A:
	add r1,r4,#0x0	; 0380030A
	mov r0,#0x54	; 0380030C
	mul r1,r0	; 0380030E
	ldr r0,[pool_03800438]	; 03800310
	add r5,r0,r1	; 03800312
	ldrb r1,[r5,#0x4]	; 03800314
	cmp r1,#0x0	; 03800316
	beq P2_Entry_038003F8	; 03800318
	mov r0,#0x2	; 0380031A
	and r1,r0	; 0380031C
	cmp r1,#0x0	; 0380031E
	beq P2_Entry_0380032A	; 03800320
	add r0,r4,#0x0	; 03800322
	add r1,r7,#0x0	; 03800324
	bl loc_037FF5E4	; 03800326
P2_Entry_0380032A:
	ldrb r0,[r5,#0x4]	; 0380032A
	add r2,r0,#0x0	; 0380032C
	mov r1,#0x1	; 0380032E
	and r2,r1	; 03800330
	cmp r2,#0x0	; 03800332
	beq P2_Entry_038003BC	; 03800334
	ldrb r0,[r5,#0x1]	; 03800336
	cmp r0,#0x0	; 03800338
	beq P2_Entry_03800346	; 0380033A
	cmp r0,#0x1	; 0380033C
	beq P2_Entry_03800384	; 0380033E
	cmp r0,#0x2	; 03800340
	beq P2_Entry_038003A2	; 03800342
	b P2_Entry_038003F8	; 03800344
P2_Entry_03800346:
	add r0,r5,#0x0	; 03800346
	add r0,#0x39	; 03800348
	ldrb r0,[r0,#0x0]	; 0380034A
	cmp r0,#0x0	; 0380034C
	beq P2_Entry_03800354	; 0380034E
	lsl r3,r1,#0	; 03800350
	b P2_Entry_03800356	; 03800352
P2_Entry_03800354:
	mov r3,#0x2	; 03800354
P2_Entry_03800356:
	ldrh r0,[r5,#0x24]	; 03800356
	ldrh r1,[r5,#0x3e]	; 03800358
	str r1,[sp,#0x0]	; 0380035A
	ldr r1,[r5,#0x40]	; 0380035C
	str r1,[sp,#0x4]	; 0380035E
	add r1,r0,#0x0	; 03800360
	and r1,r6	; 03800362
	str r1,[sp,#0x8]	; 03800364
	asr r0,r0,#0x8	; 03800366
	str r0,[sp,#0xc]	; 03800368
	ldrh r0,[r5,#0x26]	; 0380036A
	str r0,[sp,#0x10]	; 0380036C
	add r0,r5,#0x0	; 0380036E
	add r0,#0x23	; 03800370
	ldrb r0,[r0,#0x0]	; 03800372
	str r0,[sp,#0x14]	; 03800374
	add r0,r4,#0x0	; 03800376
	ldr r1,[r5,#0x44]	; 03800378
	add r5,#0x38	; 0380037A
	ldrb r2,[r5,#0x0]	; 0380037C
	bl loc_037FF6E0	; 0380037E
	b P2_Entry_038003F8	; 03800382
P2_Entry_03800384:
	ldrh r3,[r5,#0x24]	; 03800384
	ldrh r0,[r5,#0x26]	; 03800386
	str r0,[sp,#0x0]	; 03800388
	add r0,r5,#0x0	; 0380038A
	add r0,#0x23	; 0380038C
	ldrb r0,[r0,#0x0]	; 0380038E
	str r0,[sp,#0x4]	; 03800390
	add r0,r4,#0x0	; 03800392
	ldr r1,[r5,#0x44]	; 03800394
	add r2,r3,#0x0	; 03800396
	and r2,r6	; 03800398
	asr r3,r3,#0x8	; 0380039A
	bl loc_037FF674	; 0380039C
	b P2_Entry_038003F8	; 038003A0
P2_Entry_038003A2:
	ldrh r2,[r5,#0x24]	; 038003A2
	add r0,r5,#0x0	; 038003A4
	add r0,#0x23	; 038003A6
	ldrb r0,[r0,#0x0]	; 038003A8
	str r0,[sp,#0x0]	; 038003AA
	add r0,r4,#0x0	; 038003AC
	add r1,r2,#0x0	; 038003AE
	and r1,r6	; 038003B0
	asr r2,r2,#0x8	; 038003B2
	ldrh r3,[r5,#0x26]	; 038003B4
	bl loc_037FF60C	; 038003B6
	b P2_Entry_038003F8	; 038003BA
P2_Entry_038003BC:
	mov r1,#0x4	; 038003BC
	and r0,r1	; 038003BE
	cmp r0,#0x0	; 038003C0
	beq P2_Entry_038003CC	; 038003C2
	add r0,r4,#0x0	; 038003C4
	ldrh r1,[r5,#0x26]	; 038003C6
	bl loc_037FF578	; 038003C8
P2_Entry_038003CC:
	ldrb r1,[r5,#0x4]	; 038003CC
	mov r0,#0x8	; 038003CE
	and r1,r0	; 038003D0
	cmp r1,#0x0	; 038003D2
	beq P2_Entry_038003E4	; 038003D4
	ldrh r2,[r5,#0x24]	; 038003D6
	add r0,r4,#0x0	; 038003D8
	add r1,r2,#0x0	; 038003DA
	and r1,r6	; 038003DC
	asr r2,r2,#0x8	; 038003DE
	bl loc_037FF58C	; 038003E0
P2_Entry_038003E4:
	ldrb r1,[r5,#0x4]	; 038003E4
	mov r0,#0x10	; 038003E6
	and r1,r0	; 038003E8
	cmp r1,#0x0	; 038003EA
	beq P2_Entry_038003F8	; 038003EC
	add r0,r4,#0x0	; 038003EE
	add r5,#0x23	; 038003F0
	ldrb r1,[r5,#0x0]	; 038003F2
	bl loc_037FF534	; 038003F4
P2_Entry_038003F8:
	add r4,r4,#0x1	; 038003F8
	cmp r4,#0x10	; 038003FA
	blt P2_Entry_0380030A	; 038003FC
	mov r2,#0x0	; 038003FE
	add r5,r2,#0x0	; 03800400
	ldr r0,[pool_03800438]	; 03800402
	mov r4,#0x54	; 03800404
P2_Entry_03800406:
	add r1,r2,#0x0	; 03800406
	mul r1,r4	; 03800408
	add r1,r0,r1	; 0380040A
	ldrb r6,[r1,#0x4]	; 0380040C
	cmp r6,#0x0	; 0380040E
	beq P2_Entry_0380042A	; 03800410
	mov r3,#0x1	; 03800412
	and r6,r3	; 03800414
	cmp r6,#0x0	; 03800416
	beq P2_Entry_03800428	; 03800418
	lsl r6,r2,#0x4	; 0380041A
	ldr r3,[pool_0380043C]	; 0380041C
	add r7,r6,r3	; 0380041E
	ldrb r6,[r7,#0x0]	; 03800420
	mov r3,#0x80	; 03800422
	orr r6,r3	; 03800424
	strb r6,[r7,#0x0]	; 03800426
P2_Entry_03800428:
	strb r5,[r1,#0x4]	; 03800428
P2_Entry_0380042A:
	add r2,r2,#0x1	; 0380042A
	cmp r2,#0x10	; 0380042C
	blt P2_Entry_03800406	; 0380042E
	add sp,#0x1c	; 03800430
	pop {r4,r5,r6,r7}	; 03800432
	pop {r3}	; 03800434
	bx r3	; 03800436
pool_03800438:
	.word 0x03805ED4	; 03800438
pool_0380043C:
	.word 0x04000403	; 0380043C
P2_Entry_03800440:
	push {r4,r5,r6,lr}	; 03800440
	mov r0,#0x0	; 03800442
	ldr r6,[pool_03800474]	; 03800444
	add r5,r0,#0x0	; 03800446
	mov r1,#0x54	; 03800448
	mov r2,#0x1	; 0380044A
P2_Entry_0380044C:
	add r3,r0,#0x0	; 0380044C
	mul r3,r1	; 0380044E
	add r4,r6,r3	; 03800450
	strb r0,[r6,r3]	; 03800452
	strb r5,[r4,#0x4]	; 03800454
	add r4,r4,#0x3	; 03800456
	ldrb r3,[r4,#0x0]	; 03800458
	bic r3,r2	; 0380045A
	strb r3,[r4,#0x0]	; 0380045C
	add r0,r0,#0x1	; 0380045E
	cmp r0,#0x10	; 03800460
	blt P2_Entry_0380044C	; 03800462
	ldr r0,[pool_03800478]	; 03800464
	str r5,[r0,#0x0]	; 03800466
	ldr r0,[pool_0380047C]	; 03800468
	str r5,[r0,#0x0]	; 0380046A
	pop {r4,r5,r6}	; 0380046C
	pop {r3}	; 0380046E
	bx r3	; 03800470
	.byte 0xC0, 0x46	; 03800472
pool_03800474:
	.word P2_BssStart + 0xB80	; 03800474
pool_03800478:
	.word P2_BssStart + 0xB60	; 03800478
pool_0380047C:
	.word P2_BssStart + 0xB5C	; 0380047C

; ===== function loc_03800480 =====
loc_03800480:
	push {r4,lr}	; 03800480
	mov r0,#0x0	; 03800482
	ldr r3,[pool_038004B0]	; 03800484
	b loc_038004A2	; 03800486
loc_03800488:
	lsl r1,r0,#0x6	; 03800488
	add r4,r3,r1	; 0380048A
	ldrb r2,[r3,r1]	; 0380048C
	lsl r1,r2,#0x1f	; 0380048E
	lsr r1,r1,#0x1f	; 03800490
	cmp r1,#0x0	; 03800492
	bne loc_038004A0	; 03800494
	mov r1,#0x1	; 03800496
	bic r2,r1	; 03800498
	orr r2,r1	; 0380049A
	strb r2,[r4,#0x0]	; 0380049C
	b loc_038004AA	; 0380049E
loc_038004A0:
	add r0,r0,#0x1	; 038004A0
loc_038004A2:
	cmp r0,#0x20	; 038004A2
	blt loc_03800488	; 038004A4
	mov r0,#0x0	; 038004A6
	mvn r0,r0	; 038004A8
loc_038004AA:
	pop {r4}	; 038004AA
	pop {r3}	; 038004AC
	bx r3	; 038004AE
pool_038004B0:
loc_038004B0:
	.word 0x03806654	; 038004B0

; ===== function loc_038004B4 =====
loc_038004B4:
	ldr r2,[pool_038004E0]	; 038004B4
	ldr r3,[r2,#0x0]	; 038004B6
	cmp r3,#0x0	; 038004B8
	bne loc_038004C0	; 038004BA
	mov r0,#0x0	; 038004BC
	bx lr	; 038004BE
loc_038004C0:
	cmp r1,#0x10	; 038004C0
	bge loc_038004D4	; 038004C2
	add r3,#0x20	; 038004C4
	ldrb r2,[r0,#0x2]	; 038004C6
	mov r0,#0x24	; 038004C8
	mul r2,r0	; 038004CA
	add r2,r3,r2	; 038004CC
	lsl r0,r1,#0x1	; 038004CE
	add r0,r2,r0	; 038004D0
	bx lr	; 038004D2
loc_038004D4:
	ldr r0,[pool_038004E4]	; 038004D4
	add r2,r3,r0	; 038004D6
	sub r1,#0x10	; 038004D8
	lsl r0,r1,#0x1	; 038004DA
	add r0,r2,r0	; 038004DC
	bx lr	; 038004DE
pool_038004E0:
loc_038004E0:
	.word P2_BssStart + 0xB7C	; 038004E0
pool_038004E4:
loc_038004E4:
	.word 0x00000260	; 038004E4
P2_Entry_038004E8:
	push {r4,r5,r6,r7,lr}	; 038004E8
	sub sp,#0x4	; 038004EA
	add r5,r0,#0x0	; 038004EC
	mov r6,#0x0	; 038004EE
	add r4,r6,#0x0	; 038004F0
	mov r7,#0x1	; 038004F2
P2_Entry_038004F4:
	add r0,r5,#0x0	; 038004F4
	add r1,r4,#0x0	; 038004F6
	bl loc_03800E2C	; 038004F8
	cmp r0,#0x0	; 038004FC
	beq P2_Entry_0380051C	; 038004FE
	ldr r1,[r0,#0x28]	; 03800500
	cmp r1,#0x0	; 03800502
	beq P2_Entry_0380051C	; 03800504
	add r1,r5,#0x0	; 03800506
	bl P2_Entry_03800534	; 03800508
	cmp r0,#0x0	; 0380050C
	bne P2_Entry_03800514	; 0380050E
	add r6,r7,#0x0	; 03800510
	b P2_Entry_0380051C	; 03800512
P2_Entry_03800514:
	add r0,r5,#0x0	; 03800514
	add r1,r4,#0x0	; 03800516
	bl loc_03800DE8	; 03800518
P2_Entry_0380051C:
	add r4,r4,#0x1	; 0380051C
	cmp r4,#0x10	; 0380051E
	blt P2_Entry_038004F4	; 03800520
	cmp r6,#0x0	; 03800522
	bne P2_Entry_0380052A	; 03800524
	mov r0,#0x1	; 03800526
	b P2_Entry_0380052C	; 03800528
P2_Entry_0380052A:
	mov r0,#0x0	; 0380052A
P2_Entry_0380052C:
	add sp,#0x4	; 0380052C
	pop {r4,r5,r6,r7}	; 0380052E
	pop {r3}	; 03800530
	bx r3	; 03800532
P2_Entry_03800534:
	push {r4,r5,r6,r7,lr}	; 03800534
	sub sp,#0x24	; 03800536
	add r4,r0,#0x0	; 03800538
	str r1,[sp,#0x4]	; 0380053A
	ldrb r1,[r4,#0x0]	; 0380053C
	lsl r0,r1,#0x1b	; 0380053E
	lsr r0,r0,#0x1f	; 03800540
	cmp r0,#0x0	; 03800542
	beq P2_Entry_03800556	; 03800544
	ldr r0,[r4,#0x3c]	; 03800546
	cmp r0,#0x0	; 03800548
	beq P2_Entry_03800550	; 0380054A
	mov r0,#0x0	; 0380054C
	b P2_Entry_03800B58	; 0380054E
P2_Entry_03800550:
	mov r0,#0x10	; 03800550
	bic r1,r0	; 03800552
	strb r1,[r4,#0x0]	; 03800554
P2_Entry_03800556:
	ldr r0,[r4,#0x20]	; 03800556
	cmp r0,#0x0	; 03800558
	ble P2_Entry_03800570	; 0380055A
	add r1,r4,#0x0	; 0380055C
	add r1,#0x20	; 0380055E
	ldr r0,[r1,#0x0]	; 03800560
	sub r0,r0,#0x1	; 03800562
	str r0,[r1,#0x0]	; 03800564
	ldr r0,[r4,#0x20]	; 03800566
	cmp r0,#0x0	; 03800568
	ble P2_Entry_03800570	; 0380056A
	mov r0,#0x0	; 0380056C
	b P2_Entry_03800B58	; 0380056E
P2_Entry_03800570:
	ldr r0,[r4,#0x28]	; 03800570
	bl loc_0380117C	; 03800572
	mov r0,#0x0	; 03800576
	mvn r0,r0	; 03800578
	str r0,[sp,#0x18]	; 0380057A
	b P2_Entry_03800B44	; 0380057C
P2_Entry_0380057E:
	mov r5,#0x0	; 0380057E
	mov r0,#0x1	; 03800580
	str r0,[sp,#0xc]	; 03800582
	add r0,r4,#0x0	; 03800584
	bl loc_03801134	; 03800586
	add r6,r0,#0x0	; 0380058A
	cmp r6,#0xa2	; 0380058C
	bne P2_Entry_038005A0	; 0380058E
	add r0,r4,#0x0	; 03800590
	bl loc_03801134	; 03800592
	add r6,r0,#0x0	; 03800596
	ldrb r0,[r4,#0x0]	; 03800598
	lsl r0,r0,#0x19	; 0380059A
	lsr r0,r0,#0x1f	; 0380059C
	str r0,[sp,#0xc]	; 0380059E
P2_Entry_038005A0:
	cmp r6,#0xa0	; 038005A0
	bne P2_Entry_038005B2	; 038005A2
	add r0,r4,#0x0	; 038005A4
	bl loc_03801134	; 038005A6
	add r6,r0,#0x0	; 038005AA
	mov r0,#0x3	; 038005AC
	str r0,[sp,#0x8]	; 038005AE
	mov r5,#0x1	; 038005B0
P2_Entry_038005B2:
	cmp r6,#0xa1	; 038005B2
	bne P2_Entry_038005C4	; 038005B4
	add r0,r4,#0x0	; 038005B6
	bl loc_03801134	; 038005B8
	add r6,r0,#0x0	; 038005BC
	mov r0,#0x4	; 038005BE
	str r0,[sp,#0x8]	; 038005C0
	mov r5,#0x1	; 038005C2
P2_Entry_038005C4:
	add r1,r6,#0x0	; 038005C4
	mov r0,#0x80	; 038005C6
	and r1,r0	; 038005C8
	cmp r1,#0x0	; 038005CA
	bne P2_Entry_0380063E	; 038005CC
	add r0,r4,#0x0	; 038005CE
	bl loc_03801134	; 038005D0
	str r0,[sp,#0x10]	; 038005D4
	cmp r5,#0x0	; 038005D6
	beq P2_Entry_038005DE	; 038005D8
	ldr r2,[sp,#0x8]	; 038005DA
	b P2_Entry_038005E0	; 038005DC
P2_Entry_038005DE:
	mov r2,#0x2	; 038005DE
P2_Entry_038005E0:
	add r0,r4,#0x0	; 038005E0
	ldr r1,[sp,#0x4]	; 038005E2
	bl P2_Entry_03801008	; 038005E4
	add r7,r0,#0x0	; 038005E8
	mov r0,#0x13	; 038005EA
	ldrsb r0,[r4,r0]	; 038005EC
	add r5,r6,r0	; 038005EE
	ldr r0,[sp,#0xc]	; 038005F0
	cmp r0,#0x0	; 038005F2
	bne P2_Entry_038005F8	; 038005F4
	b P2_Entry_03800B44	; 038005F6
P2_Entry_038005F8:
	cmp r5,#0x0	; 038005F8
	bge P2_Entry_03800600	; 038005FA
	mov r5,#0x0	; 038005FC
	b P2_Entry_03800606	; 038005FE
P2_Entry_03800600:
	cmp r5,#0x7f	; 03800600
	ble P2_Entry_03800606	; 03800602
	mov r5,#0x7f	; 03800604
P2_Entry_03800606:
	ldrb r0,[r4,#0x0]	; 03800606
	lsl r0,r0,#0x1d	; 03800608
	lsr r0,r0,#0x1f	; 0380060A
	cmp r0,#0x0	; 0380060C
	bne P2_Entry_0380061E	; 0380060E
	str r7,[sp,#0x0]	; 03800610
	add r0,r4,#0x0	; 03800612
	ldr r1,[sp,#0x4]	; 03800614
	add r2,r5,#0x0	; 03800616
	ldr r3,[sp,#0x10]	; 03800618
	bl P2_Entry_03800B60	; 0380061A
P2_Entry_0380061E:
	strb r5,[r4,#0x14]	; 0380061E
	ldrb r0,[r4,#0x0]	; 03800620
	lsl r0,r0,#0x1e	; 03800622
	lsr r0,r0,#0x1f	; 03800624
	cmp r0,#0x0	; 03800626
	bne P2_Entry_0380062C	; 03800628
	b P2_Entry_03800B44	; 0380062A
P2_Entry_0380062C:
	str r7,[r4,#0x20]	; 0380062C
	cmp r7,#0x0	; 0380062E
	beq P2_Entry_03800634	; 03800630
	b P2_Entry_03800B44	; 03800632
P2_Entry_03800634:
	ldrb r1,[r4,#0x0]	; 03800634
	mov r0,#0x10	; 03800636
	orr r1,r0	; 03800638
	strb r1,[r4,#0x0]	; 0380063A
	b P2_Entry_03800B44	; 0380063C
P2_Entry_0380063E:
	add r1,r6,#0x0	; 0380063E
	mov r0,#0xf0	; 03800640
	and r1,r0	; 03800642
	cmp r1,#0xc0	; 03800644
	bgt P2_Entry_03800662	; 03800646
	cmp r1,#0xc0	; 03800648
	bge P2_Entry_03800746	; 0380064A
	cmp r1,#0x90	; 0380064C
	bgt P2_Entry_0380065A	; 0380064E
	cmp r1,#0x90	; 03800650
	bge P2_Entry_038006AE	; 03800652
	cmp r1,#0x80	; 03800654
	beq P2_Entry_0380067A	; 03800656
	b P2_Entry_03800B44	; 03800658
P2_Entry_0380065A:
	cmp r1,#0xb0	; 0380065A
	bne P2_Entry_03800660	; 0380065C
	b P2_Entry_03800912	; 0380065E
P2_Entry_03800660:
	b P2_Entry_03800B44	; 03800660
P2_Entry_03800662:
	cmp r1,#0xe0	; 03800662
	bgt P2_Entry_03800672	; 03800664
	cmp r1,#0xe0	; 03800666
	blt P2_Entry_0380066C	; 03800668
	b P2_Entry_038008D8	; 0380066A
P2_Entry_0380066C:
	cmp r1,#0xd0	; 0380066C
	beq P2_Entry_03800746	; 0380066E
	b P2_Entry_03800B44	; 03800670
P2_Entry_03800672:
	cmp r1,#0xf0	; 03800672
	bne P2_Entry_03800678	; 03800674
	b P2_Entry_03800AB4	; 03800676
P2_Entry_03800678:
	b P2_Entry_03800B44	; 03800678
P2_Entry_0380067A:
	cmp r5,#0x0	; 0380067A
	beq P2_Entry_03800682	; 0380067C
	ldr r2,[sp,#0x8]	; 0380067E
	b P2_Entry_03800684	; 03800680
P2_Entry_03800682:
	mov r2,#0x2	; 03800682
P2_Entry_03800684:
	add r0,r4,#0x0	; 03800684
	ldr r1,[sp,#0x4]	; 03800686
	bl P2_Entry_03801008	; 03800688
	ldr r1,[sp,#0xc]	; 0380068C
	cmp r1,#0x0	; 0380068E
	bne P2_Entry_03800694	; 03800690
	b P2_Entry_03800B44	; 03800692
P2_Entry_03800694:
	cmp r6,#0x80	; 03800694
	beq P2_Entry_0380069E	; 03800696
	cmp r6,#0x81	; 03800698
	beq P2_Entry_038006A2	; 0380069A
	b P2_Entry_03800B44	; 0380069C
P2_Entry_0380069E:
	str r0,[r4,#0x20]	; 0380069E
	b P2_Entry_03800B44	; 038006A0
P2_Entry_038006A2:
	ldr r1,[pool_038009E4]	; 038006A2
	cmp r0,r1	; 038006A4
	blt P2_Entry_038006AA	; 038006A6
	b P2_Entry_03800B44	; 038006A8
P2_Entry_038006AA:
	strh r0,[r4,#0x2]	; 038006AA
	b P2_Entry_03800B44	; 038006AC
P2_Entry_038006AE:
	cmp r6,#0x93	; 038006AE
	beq P2_Entry_038006BC	; 038006B0
	cmp r6,#0x94	; 038006B2
	beq P2_Entry_038006FC	; 038006B4
	cmp r6,#0x95	; 038006B6
	beq P2_Entry_03800712	; 038006B8
	b P2_Entry_03800B44	; 038006BA
P2_Entry_038006BC:
	add r0,r4,#0x0	; 038006BC
	bl loc_03801134	; 038006BE
	add r5,r0,#0x0	; 038006C2
	add r0,r4,#0x0	; 038006C4
	bl P2_Entry_038010B4	; 038006C6
	add r6,r0,#0x0	; 038006CA
	ldr r0,[sp,#0xc]	; 038006CC
	cmp r0,#0x0	; 038006CE
	bne P2_Entry_038006D4	; 038006D0
	b P2_Entry_03800B44	; 038006D2
P2_Entry_038006D4:
	ldr r0,[sp,#0x4]	; 038006D4
	add r1,r5,#0x0	; 038006D6
	bl loc_03800E2C	; 038006D8
	add r5,r0,#0x0	; 038006DC
	cmp r5,#0x0	; 038006DE
	bne P2_Entry_038006E4	; 038006E0
	b P2_Entry_03800B44	; 038006E2
P2_Entry_038006E4:
	cmp r5,r4	; 038006E4
	bne P2_Entry_038006EA	; 038006E6
	b P2_Entry_03800B44	; 038006E8
P2_Entry_038006EA:
	ldr r1,[sp,#0x4]	; 038006EA
	bl loc_03800E20	; 038006EC
	add r0,r5,#0x0	; 038006F0
	ldr r1,[r4,#0x24]	; 038006F2
	add r2,r6,#0x0	; 038006F4
	bl loc_03800F68	; 038006F6
	b P2_Entry_03800B44	; 038006FA
P2_Entry_038006FC:
	add r0,r4,#0x0	; 038006FC
	bl P2_Entry_038010B4	; 038006FE
	ldr r1,[sp,#0xc]	; 03800702
	cmp r1,#0x0	; 03800704
	bne P2_Entry_0380070A	; 03800706
	b P2_Entry_03800B44	; 03800708
P2_Entry_0380070A:
	ldr r1,[r4,#0x24]	; 0380070A
	add r0,r1,r0	; 0380070C
	str r0,[r4,#0x28]	; 0380070E
	b P2_Entry_03800B44	; 03800710
P2_Entry_03800712:
	add r0,r4,#0x0	; 03800712
	bl P2_Entry_038010B4	; 03800714
	ldr r1,[sp,#0xc]	; 03800718
	cmp r1,#0x0	; 0380071A
	bne P2_Entry_03800720	; 0380071C
	b P2_Entry_03800B44	; 0380071E
P2_Entry_03800720:
	add r1,r4,#0x0	; 03800720
	add r1,#0x3b	; 03800722
	ldrb r1,[r1,#0x0]	; 03800724
	cmp r1,#0x3	; 03800726
	bcc P2_Entry_0380072C	; 03800728
	b P2_Entry_03800B44	; 0380072A
P2_Entry_0380072C:
	ldr r2,[r4,#0x28]	; 0380072C
	lsl r1,r1,#0x2	; 0380072E
	add r1,r4,r1	; 03800730
	str r2,[r1,#0x2c]	; 03800732
	add r2,r4,#0x0	; 03800734
	add r2,#0x3b	; 03800736
	ldrb r1,[r2,#0x0]	; 03800738
	add r1,r1,#0x1	; 0380073A
	strb r1,[r2,#0x0]	; 0380073C
	ldr r1,[r4,#0x24]	; 0380073E
	add r0,r1,r0	; 03800740
	str r0,[r4,#0x28]	; 03800742
	b P2_Entry_03800B44	; 03800744
P2_Entry_03800746:
	cmp r5,#0x0	; 03800746
	beq P2_Entry_0380074E	; 03800748
	ldr r2,[sp,#0x8]	; 0380074A
	b P2_Entry_03800750	; 0380074C
P2_Entry_0380074E:
	mov r2,#0x0	; 0380074E
P2_Entry_03800750:
	add r0,r4,#0x0	; 03800750
	ldr r1,[sp,#0x4]	; 03800752
	bl P2_Entry_03801008	; 03800754
	add r1,sp,#0x1c	; 03800758
	strb r0,[r1,#0x0]	; 0380075A
	ldr r0,[sp,#0xc]	; 0380075C
	cmp r0,#0x0	; 0380075E
	bne P2_Entry_03800764	; 03800760
	b P2_Entry_03800B44	; 03800762
P2_Entry_03800764:
	sub r6,#0xc0	; 03800764
	cmp r6,#0x15	; 03800766
	bls P2_Entry_0380076C	; 03800768
	b P2_Entry_03800B44	; 0380076A
P2_Entry_0380076C:
	add r0,r6,r6	; 0380076C
P2_SwitchIndexPC_0380076C:
	add r0,pc	; 0380076E
	ldrh r0,[r0,#(P2_SwitchTable_0380076C - (P2_SwitchIndexPC_0380076C + 4))]	; 03800770
	lsl r0,r0,#0x10	; 03800772
	asr r0,r0,#0x10	; 03800774
P2_SwitchTargetPC_0380076C:
	add r0,pc	; 03800776
	bx r0	; 03800778
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380076C:
	.halfword (P2_Case_038008CE + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007A6 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007B6 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038008BE + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038008C6 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007C0 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007C8 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007D0 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_0380085E + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_0380087E + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007EE + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007F6 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007FE + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_03800806 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_0380089E + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007E6 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_0380080E + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_03800816 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_0380081E + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_03800826 + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_0380082E + 1) - (P2_SwitchTargetPC_0380076C + 4)
	.halfword (P2_Case_038007AE + 1) - (P2_SwitchTargetPC_0380076C + 4)
P2_SwitchTable_0380076CEnd:
P2_Case_038007A6:
	lsl r0,r1,#0	; 038007A6
	ldrb r0,[r0,#0x0]	; 038007A8
	strb r0,[r4,#0x4]	; 038007AA
	b P2_Entry_03800B44	; 038007AC
P2_Case_038007AE:
	lsl r0,r1,#0	; 038007AE
	ldrb r0,[r0,#0x0]	; 038007B0
	strb r0,[r4,#0x5]	; 038007B2
	b P2_Entry_03800B44	; 038007B4
P2_Case_038007B6:
	lsl r0,r1,#0	; 038007B6
	ldrb r1,[r0,#0x0]	; 038007B8
	ldr r0,[sp,#0x4]	; 038007BA
	strb r1,[r0,#0x5]	; 038007BC
	b P2_Entry_03800B44	; 038007BE
P2_Case_038007C0:
	lsl r0,r1,#0	; 038007C0
	ldrb r0,[r0,#0x0]	; 038007C2
	strb r0,[r4,#0x7]	; 038007C4
	b P2_Entry_03800B44	; 038007C6
P2_Case_038007C8:
	lsl r0,r1,#0	; 038007C8
	ldrb r0,[r0,#0x0]	; 038007CA
	strb r0,[r4,#0x12]	; 038007CC
	b P2_Entry_03800B44	; 038007CE
P2_Case_038007D0:
	ldrb r0,[r4,#0x0]	; 038007D0
	mov r1,#0x2	; 038007D2
	bic r0,r1	; 038007D4
	add r1,sp,#0x1c	; 038007D6
	ldrb r2,[r1,#0x0]	; 038007D8
	mov r1,#0x1	; 038007DA
	and r2,r1	; 038007DC
	lsl r1,r2,#0x1	; 038007DE
	orr r0,r1	; 038007E0
	strb r0,[r4,#0x0]	; 038007E2
	b P2_Entry_03800B44	; 038007E4
P2_Case_038007E6:
	lsl r0,r1,#0	; 038007E6
	ldrb r0,[r0,#0x0]	; 038007E8
	strb r0,[r4,#0x15]	; 038007EA
	b P2_Entry_03800B44	; 038007EC
P2_Case_038007EE:
	lsl r0,r1,#0	; 038007EE
	ldrb r0,[r0,#0x0]	; 038007F0
	strb r0,[r4,#0x1a]	; 038007F2
	b P2_Entry_03800B44	; 038007F4
P2_Case_038007F6:
	lsl r0,r1,#0	; 038007F6
	ldrb r0,[r0,#0x0]	; 038007F8
	strb r0,[r4,#0x19]	; 038007FA
	b P2_Entry_03800B44	; 038007FC
P2_Case_038007FE:
	lsl r0,r1,#0	; 038007FE
	ldrb r0,[r0,#0x0]	; 03800800
	strb r0,[r4,#0x18]	; 03800802
	b P2_Entry_03800B44	; 03800804
P2_Case_03800806:
	lsl r0,r1,#0	; 03800806
	ldrb r0,[r0,#0x0]	; 03800808
	strb r0,[r4,#0x1b]	; 0380080A
	b P2_Entry_03800B44	; 0380080C
P2_Case_0380080E:
	lsl r0,r1,#0	; 0380080E
	ldrb r0,[r0,#0x0]	; 03800810
	strb r0,[r4,#0xe]	; 03800812
	b P2_Entry_03800B44	; 03800814
P2_Case_03800816:
	lsl r0,r1,#0	; 03800816
	ldrb r0,[r0,#0x0]	; 03800818
	strb r0,[r4,#0xf]	; 0380081A
	b P2_Entry_03800B44	; 0380081C
P2_Case_0380081E:
	lsl r0,r1,#0	; 0380081E
	ldrb r0,[r0,#0x0]	; 03800820
	strb r0,[r4,#0x10]	; 03800822
	b P2_Entry_03800B44	; 03800824
P2_Case_03800826:
	lsl r0,r1,#0	; 03800826
	ldrb r0,[r0,#0x0]	; 03800828
	strb r0,[r4,#0x11]	; 0380082A
	b P2_Entry_03800B44	; 0380082C
P2_Case_0380082E:
	add r0,r4,#0x0	; 0380082E
	add r0,#0x3b	; 03800830
	ldrb r0,[r0,#0x0]	; 03800832
	cmp r0,#0x3	; 03800834
	bcc P2_Entry_0380083A	; 03800836
	b P2_Entry_03800B44	; 03800838
P2_Entry_0380083A:
	ldr r1,[r4,#0x28]	; 0380083A
	lsl r0,r0,#0x2	; 0380083C
	add r0,r4,r0	; 0380083E
	str r1,[r0,#0x2c]	; 03800840
	add r0,sp,#0x1c	; 03800842
	ldrb r1,[r0,#0x0]	; 03800844
	add r0,r4,#0x0	; 03800846
	add r0,#0x3b	; 03800848
	ldrb r0,[r0,#0x0]	; 0380084A
	add r0,r4,r0	; 0380084C
	add r0,#0x38	; 0380084E
	strb r1,[r0,#0x0]	; 03800850
	add r1,r4,#0x0	; 03800852
	add r1,#0x3b	; 03800854
	ldrb r0,[r1,#0x0]	; 03800856
	add r0,r0,#0x1	; 03800858
	strb r0,[r1,#0x0]	; 0380085A
	b P2_Entry_03800B44	; 0380085C
P2_Case_0380085E:
	ldrb r0,[r4,#0x0]	; 0380085E
	mov r1,#0x8	; 03800860
	bic r0,r1	; 03800862
	add r1,sp,#0x1c	; 03800864
	ldrb r2,[r1,#0x0]	; 03800866
	mov r1,#0x1	; 03800868
	and r2,r1	; 0380086A
	lsl r1,r2,#0x3	; 0380086C
	orr r0,r1	; 0380086E
	strb r0,[r4,#0x0]	; 03800870
	add r0,r4,#0x0	; 03800872
	ldr r1,[sp,#0x4]	; 03800874
	ldr r2,[sp,#0x18]	; 03800876
	bl loc_03800EB4	; 03800878
	b P2_Entry_03800B44	; 0380087C
P2_Case_0380087E:
	lsl r0,r1,#0	; 0380087E
	ldrb r1,[r0,#0x0]	; 03800880
	mov r0,#0x13	; 03800882
	ldrsb r0,[r4,r0]	; 03800884
	add r0,r1,r0	; 03800886
	strb r0,[r4,#0x14]	; 03800888
	ldrb r1,[r4,#0x0]	; 0380088A
	mov r0,#0x20	; 0380088C
	orr r1,r0	; 0380088E
	strb r1,[r4,#0x0]	; 03800890
	add r0,r4,#0x0	; 03800892
	ldr r1,[sp,#0x4]	; 03800894
	ldr r2,[sp,#0x18]	; 03800896
	bl loc_03800EB4	; 03800898
	b P2_Entry_03800B44	; 0380089C
P2_Case_0380089E:
	ldrb r0,[r4,#0x0]	; 0380089E
	mov r1,#0x20	; 038008A0
	bic r0,r1	; 038008A2
	add r1,sp,#0x1c	; 038008A4
	ldrb r2,[r1,#0x0]	; 038008A6
	mov r1,#0x1	; 038008A8
	and r2,r1	; 038008AA
	lsl r1,r2,#0x5	; 038008AC
	orr r0,r1	; 038008AE
	strb r0,[r4,#0x0]	; 038008B0
	add r0,r4,#0x0	; 038008B2
	ldr r1,[sp,#0x4]	; 038008B4
	ldr r2,[sp,#0x18]	; 038008B6
	bl loc_03800EB4	; 038008B8
	b P2_Entry_03800B44	; 038008BC
P2_Case_038008BE:
	mov r0,#0x0	; 038008BE
	ldrsb r0,[r1,r0]	; 038008C0
	strb r0,[r4,#0x13]	; 038008C2
	b P2_Entry_03800B44	; 038008C4
P2_Case_038008C6:
	mov r0,#0x0	; 038008C6
	ldrsb r0,[r1,r0]	; 038008C8
	strb r0,[r4,#0x6]	; 038008CA
	b P2_Entry_03800B44	; 038008CC
P2_Case_038008CE:
	lsl r0,r1,#0	; 038008CE
	ldrb r0,[r0,#0x0]	; 038008D0
	sub r0,#0x40	; 038008D2
	strb r0,[r4,#0x8]	; 038008D4
	b P2_Entry_03800B44	; 038008D6
P2_Entry_038008D8:
	cmp r5,#0x0	; 038008D8
	beq P2_Entry_038008E0	; 038008DA
	ldr r2,[sp,#0x8]	; 038008DC
	b P2_Entry_038008E2	; 038008DE
P2_Entry_038008E0:
	mov r2,#0x1	; 038008E0
P2_Entry_038008E2:
	add r0,r4,#0x0	; 038008E2
	ldr r1,[sp,#0x4]	; 038008E4
	bl P2_Entry_03801008	; 038008E6
	lsl r0,r0,#0x10	; 038008EA
	asr r1,r0,#0x10	; 038008EC
	ldr r0,[sp,#0xc]	; 038008EE
	cmp r0,#0x0	; 038008F0
	bne P2_Entry_038008F6	; 038008F2
	b P2_Entry_03800B44	; 038008F4
P2_Entry_038008F6:
	cmp r6,#0xe0	; 038008F6
	beq P2_Entry_0380090A	; 038008F8
	cmp r6,#0xe1	; 038008FA
	beq P2_Entry_03800904	; 038008FC
	cmp r6,#0xe3	; 038008FE
	beq P2_Entry_0380090E	; 03800900
	b P2_Entry_03800B44	; 03800902
P2_Entry_03800904:
	ldr r0,[sp,#0x4]	; 03800904
	strh r1,[r0,#0x18]	; 03800906
	b P2_Entry_03800B44	; 03800908
P2_Entry_0380090A:
	strh r1,[r4,#0x1c]	; 0380090A
	b P2_Entry_03800B44	; 0380090C
P2_Entry_0380090E:
	strh r1,[r4,#0x16]	; 0380090E
	b P2_Entry_03800B44	; 03800910
P2_Entry_03800912:
	add r0,r4,#0x0	; 03800912
	bl loc_03801134	; 03800914
	str r0,[sp,#0x14]	; 03800918
	cmp r5,#0x0	; 0380091A
	beq P2_Entry_03800922	; 0380091C
	ldr r2,[sp,#0x8]	; 0380091E
	b P2_Entry_03800924	; 03800920
P2_Entry_03800922:
	mov r2,#0x1	; 03800922
P2_Entry_03800924:
	add r0,r4,#0x0	; 03800924
	ldr r1,[sp,#0x4]	; 03800926
	bl P2_Entry_03801008	; 03800928
	lsl r0,r0,#0x10	; 0380092C
	asr r7,r0,#0x10	; 0380092E
	ldr r0,[sp,#0x4]	; 03800930
	ldr r1,[sp,#0x14]	; 03800932
	bl loc_038004B4	; 03800934
	add r5,r0,#0x0	; 03800938
	ldr r0,[sp,#0xc]	; 0380093A
	cmp r0,#0x0	; 0380093C
	bne P2_Entry_03800942	; 0380093E
	b P2_Entry_03800B44	; 03800940
P2_Entry_03800942:
	cmp r5,#0x0	; 03800942
	bne P2_Entry_03800948	; 03800944
	b P2_Entry_03800B44	; 03800946
P2_Entry_03800948:
	sub r6,#0xb0	; 03800948
	cmp r6,#0xd	; 0380094A
	bls P2_Entry_03800950	; 0380094C
	b P2_Entry_03800B44	; 0380094E
P2_Entry_03800950:
	add r0,r6,r6	; 03800950
P2_SwitchIndexPC_03800950:
	add r0,pc	; 03800952
	ldrh r0,[r0,#(P2_SwitchTable_03800950 - (P2_SwitchIndexPC_03800950 + 4))]	; 03800954
	lsl r0,r0,#0x10	; 03800956
	asr r0,r0,#0x10	; 03800958
P2_SwitchTargetPC_03800950:
	add r0,pc	; 0380095A
	bx r0	; 0380095C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800950:
	.halfword (P2_Case_0380097A + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_0380097E + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800988 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800992 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_0380099C + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_038009B0 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_038009CA + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Entry_03800B44 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_038009D8 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800A00 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800A24 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800A48 + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800A6C + 1) - (P2_SwitchTargetPC_03800950 + 4)
	.halfword (P2_Case_03800A90 + 1) - (P2_SwitchTargetPC_03800950 + 4)
P2_SwitchTable_03800950End:
P2_Case_0380097A:
	strh r7,[r5,#0x0]	; 0380097A
	b P2_Entry_03800B44	; 0380097C
P2_Case_0380097E:
	mov r0,#0x0	; 0380097E
	ldrsh r0,[r5,r0]	; 03800980
	add r0,r0,r7	; 03800982
	strh r0,[r5,#0x0]	; 03800984
	b P2_Entry_03800B44	; 03800986
P2_Case_03800988:
	mov r0,#0x0	; 03800988
	ldrsh r0,[r5,r0]	; 0380098A
	sub r0,r0,r7	; 0380098C
	strh r0,[r5,#0x0]	; 0380098E
	b P2_Entry_03800B44	; 03800990
P2_Case_03800992:
	mov r0,#0x0	; 03800992
	ldrsh r0,[r5,r0]	; 03800994
	mul r0,r7	; 03800996
	strh r0,[r5,#0x0]	; 03800998
	b P2_Entry_03800B44	; 0380099A
P2_Case_0380099C:
	cmp r7,#0x0	; 0380099C
	bne P2_Entry_038009A2	; 0380099E
	b P2_Entry_03800B44	; 038009A0
P2_Entry_038009A2:
	mov r0,#0x0	; 038009A2
	ldrsh r0,[r5,r0]	; 038009A4
	add r1,r7,#0x0	; 038009A6
	bl loc_037FE2B0	; 038009A8
	strh r0,[r5,#0x0]	; 038009AC
	b P2_Entry_03800B44	; 038009AE
P2_Case_038009B0:
	cmp r7,#0x0	; 038009B0
	blt P2_Entry_038009BE	; 038009B2
	mov r0,#0x0	; 038009B4
	ldrsh r0,[r5,r0]	; 038009B6
	lsl r0,r7	; 038009B8
	strh r0,[r5,#0x0]	; 038009BA
	b P2_Entry_03800B44	; 038009BC
P2_Entry_038009BE:
	mov r0,#0x0	; 038009BE
	ldrsh r1,[r5,r0]	; 038009C0
	neg r0,r7	; 038009C2
	asr r1,r0	; 038009C4
	strh r1,[r5,#0x0]	; 038009C6
	b P2_Entry_03800B44	; 038009C8
P2_Case_038009CA:
	bl loc_037FF770	; 038009CA
	add r1,r7,#0x1	; 038009CE
	mul r0,r1	; 038009D0
	asr r0,r0,#0x10	; 038009D2
	strh r0,[r5,#0x0]	; 038009D4
	b P2_Entry_03800B44	; 038009D6
P2_Case_038009D8:
	mov r0,#0x0	; 038009D8
	ldrsh r0,[r5,r0]	; 038009DA
	cmp r0,r7	; 038009DC
	bne P2_Entry_038009E8	; 038009DE
	mov r2,#0x1	; 038009E0
	b P2_Entry_038009EA	; 038009E2
pool_038009E4:
	.word 0x00010000	; 038009E4
P2_Entry_038009E8:
	mov r2,#0x0	; 038009E8
P2_Entry_038009EA:
	ldrb r0,[r4,#0x0]	; 038009EA
	mov r1,#0x40	; 038009EC
	bic r0,r1	; 038009EE
	lsl r1,r2,#0x18	; 038009F0
	lsr r2,r1,#0x18	; 038009F2
	mov r1,#0x1	; 038009F4
	and r2,r1	; 038009F6
	lsl r1,r2,#0x6	; 038009F8
	orr r0,r1	; 038009FA
	strb r0,[r4,#0x0]	; 038009FC
	b P2_Entry_03800B44	; 038009FE
P2_Case_03800A00:
	mov r0,#0x0	; 03800A00
	ldrsh r0,[r5,r0]	; 03800A02
	cmp r0,r7	; 03800A04
	blt P2_Entry_03800A0C	; 03800A06
	mov r2,#0x1	; 03800A08
	b P2_Entry_03800A0E	; 03800A0A
P2_Entry_03800A0C:
	mov r2,#0x0	; 03800A0C
P2_Entry_03800A0E:
	ldrb r0,[r4,#0x0]	; 03800A0E
	mov r1,#0x40	; 03800A10
	bic r0,r1	; 03800A12
	lsl r1,r2,#0x18	; 03800A14
	lsr r2,r1,#0x18	; 03800A16
	mov r1,#0x1	; 03800A18
	and r2,r1	; 03800A1A
	lsl r1,r2,#0x6	; 03800A1C
	orr r0,r1	; 03800A1E
	strb r0,[r4,#0x0]	; 03800A20
	b P2_Entry_03800B44	; 03800A22
P2_Case_03800A24:
	mov r0,#0x0	; 03800A24
	ldrsh r0,[r5,r0]	; 03800A26
	cmp r0,r7	; 03800A28
	ble P2_Entry_03800A30	; 03800A2A
	mov r2,#0x1	; 03800A2C
	b P2_Entry_03800A32	; 03800A2E
P2_Entry_03800A30:
	mov r2,#0x0	; 03800A30
P2_Entry_03800A32:
	ldrb r0,[r4,#0x0]	; 03800A32
	mov r1,#0x40	; 03800A34
	bic r0,r1	; 03800A36
	lsl r1,r2,#0x18	; 03800A38
	lsr r2,r1,#0x18	; 03800A3A
	mov r1,#0x1	; 03800A3C
	and r2,r1	; 03800A3E
	lsl r1,r2,#0x6	; 03800A40
	orr r0,r1	; 03800A42
	strb r0,[r4,#0x0]	; 03800A44
	b P2_Entry_03800B44	; 03800A46
P2_Case_03800A48:
	mov r0,#0x0	; 03800A48
	ldrsh r0,[r5,r0]	; 03800A4A
	cmp r0,r7	; 03800A4C
	bgt P2_Entry_03800A54	; 03800A4E
	mov r2,#0x1	; 03800A50
	b P2_Entry_03800A56	; 03800A52
P2_Entry_03800A54:
	mov r2,#0x0	; 03800A54
P2_Entry_03800A56:
	ldrb r0,[r4,#0x0]	; 03800A56
	mov r1,#0x40	; 03800A58
	bic r0,r1	; 03800A5A
	lsl r1,r2,#0x18	; 03800A5C
	lsr r2,r1,#0x18	; 03800A5E
	mov r1,#0x1	; 03800A60
	and r2,r1	; 03800A62
	lsl r1,r2,#0x6	; 03800A64
	orr r0,r1	; 03800A66
	strb r0,[r4,#0x0]	; 03800A68
	b P2_Entry_03800B44	; 03800A6A
P2_Case_03800A6C:
	mov r0,#0x0	; 03800A6C
	ldrsh r0,[r5,r0]	; 03800A6E
	cmp r0,r7	; 03800A70
	bge P2_Entry_03800A78	; 03800A72
	mov r2,#0x1	; 03800A74
	b P2_Entry_03800A7A	; 03800A76
P2_Entry_03800A78:
	mov r2,#0x0	; 03800A78
P2_Entry_03800A7A:
	ldrb r0,[r4,#0x0]	; 03800A7A
	mov r1,#0x40	; 03800A7C
	bic r0,r1	; 03800A7E
	lsl r1,r2,#0x18	; 03800A80
	lsr r2,r1,#0x18	; 03800A82
	mov r1,#0x1	; 03800A84
	and r2,r1	; 03800A86
	lsl r1,r2,#0x6	; 03800A88
	orr r0,r1	; 03800A8A
	strb r0,[r4,#0x0]	; 03800A8C
	b P2_Entry_03800B44	; 03800A8E
P2_Case_03800A90:
	mov r0,#0x0	; 03800A90
	ldrsh r0,[r5,r0]	; 03800A92
	cmp r0,r7	; 03800A94
	beq P2_Entry_03800A9C	; 03800A96
	mov r2,#0x1	; 03800A98
	b P2_Entry_03800A9E	; 03800A9A
P2_Entry_03800A9C:
	mov r2,#0x0	; 03800A9C
P2_Entry_03800A9E:
	ldrb r0,[r4,#0x0]	; 03800A9E
	mov r1,#0x40	; 03800AA0
	bic r0,r1	; 03800AA2
	lsl r1,r2,#0x18	; 03800AA4
	lsr r2,r1,#0x18	; 03800AA6
	mov r1,#0x1	; 03800AA8
	and r2,r1	; 03800AAA
	lsl r1,r2,#0x6	; 03800AAC
	orr r0,r1	; 03800AAE
	strb r0,[r4,#0x0]	; 03800AB0
	b P2_Entry_03800B44	; 03800AB2
P2_Entry_03800AB4:
	ldr r0,[sp,#0xc]	; 03800AB4
	cmp r0,#0x0	; 03800AB6
	beq P2_Entry_03800B44	; 03800AB8
	sub r6,#0xfc	; 03800ABA
	cmp r6,#0x3	; 03800ABC
	bhi P2_Entry_03800B44	; 03800ABE
	add r0,r6,r6	; 03800AC0
P2_SwitchIndexPC_03800AC0:
	add r0,pc	; 03800AC2
	ldrh r0,[r0,#(P2_SwitchTable_03800AC0 - (P2_SwitchIndexPC_03800AC0 + 4))]	; 03800AC4
	lsl r0,r0,#0x10	; 03800AC6
	asr r0,r0,#0x10	; 03800AC8
P2_SwitchTargetPC_03800AC0:
	add r0,pc	; 03800ACA
	bx r0	; 03800ACC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800AC0:
	.halfword (P2_Case_03800AFA + 1) - (P2_SwitchTargetPC_03800AC0 + 4)
	.halfword (P2_Case_03800AD6 + 1) - (P2_SwitchTargetPC_03800AC0 + 4)
	.halfword (P2_Entry_03800B44 + 1) - (P2_SwitchTargetPC_03800AC0 + 4)
	.halfword (P2_Case_03800B3E + 1) - (P2_SwitchTargetPC_03800AC0 + 4)
P2_SwitchTable_03800AC0End:
P2_Case_03800AD6:
	add r0,r4,#0x0	; 03800AD6
	add r0,#0x3b	; 03800AD8
	ldrb r0,[r0,#0x0]	; 03800ADA
	cmp r0,#0x0	; 03800ADC
	beq P2_Entry_03800B44	; 03800ADE
	add r1,r4,#0x0	; 03800AE0
	add r1,#0x3b	; 03800AE2
	ldrb r0,[r1,#0x0]	; 03800AE4
	sub r0,r0,#0x1	; 03800AE6
	strb r0,[r1,#0x0]	; 03800AE8
	add r0,r4,#0x0	; 03800AEA
	add r0,#0x3b	; 03800AEC
	ldrb r0,[r0,#0x0]	; 03800AEE
	lsl r0,r0,#0x2	; 03800AF0
	add r0,r4,r0	; 03800AF2
	ldr r0,[r0,#0x2c]	; 03800AF4
	str r0,[r4,#0x28]	; 03800AF6
	b P2_Entry_03800B44	; 03800AF8
P2_Case_03800AFA:
	add r0,r4,#0x0	; 03800AFA
	add r0,#0x3b	; 03800AFC
	ldrb r0,[r0,#0x0]	; 03800AFE
	cmp r0,#0x0	; 03800B00
	beq P2_Entry_03800B44	; 03800B02
	sub r0,r0,#0x1	; 03800B04
	add r1,r4,r0	; 03800B06
	add r0,r1,#0x0	; 03800B08
	add r0,#0x38	; 03800B0A
	ldrb r0,[r0,#0x0]	; 03800B0C
	cmp r0,#0x0	; 03800B0E
	beq P2_Entry_03800B28	; 03800B10
	sub r0,r0,#0x1	; 03800B12
	lsl r0,r0,#0x18	; 03800B14
	lsr r0,r0,#0x18	; 03800B16
	cmp r0,#0x0	; 03800B18
	bne P2_Entry_03800B28	; 03800B1A
	add r1,r4,#0x0	; 03800B1C
	add r1,#0x3b	; 03800B1E
	ldrb r0,[r1,#0x0]	; 03800B20
	sub r0,r0,#0x1	; 03800B22
	strb r0,[r1,#0x0]	; 03800B24
	b P2_Entry_03800B44	; 03800B26
P2_Entry_03800B28:
	add r1,#0x38	; 03800B28
	strb r0,[r1,#0x0]	; 03800B2A
	add r0,r4,#0x0	; 03800B2C
	add r0,#0x3b	; 03800B2E
	ldrb r0,[r0,#0x0]	; 03800B30
	sub r0,r0,#0x1	; 03800B32
	lsl r0,r0,#0x2	; 03800B34
	add r0,r4,r0	; 03800B36
	ldr r0,[r0,#0x2c]	; 03800B38
	str r0,[r4,#0x28]	; 03800B3A
	b P2_Entry_03800B44	; 03800B3C
P2_Case_03800B3E:
	mov r0,#0x0	; 03800B3E
	mvn r0,r0	; 03800B40
	b P2_Entry_03800B58	; 03800B42
P2_Entry_03800B44:
	ldr r0,[r4,#0x20]	; 03800B44
	cmp r0,#0x0	; 03800B46
	bne P2_Entry_03800B56	; 03800B48
	ldrb r0,[r4,#0x0]	; 03800B4A
	lsl r0,r0,#0x1b	; 03800B4C
	lsr r0,r0,#0x1f	; 03800B4E
	cmp r0,#0x0	; 03800B50
	bne P2_Entry_03800B56	; 03800B52
	b P2_Entry_0380057E	; 03800B54
P2_Entry_03800B56:
	mov r0,#0x0	; 03800B56
P2_Entry_03800B58:
	add sp,#0x24	; 03800B58
	pop {r4,r5,r6,r7}	; 03800B5A
	pop {r3}	; 03800B5C
	bx r3	; 03800B5E
P2_Entry_03800B60:
	push {r4,r5,r6,r7,lr}	; 03800B60
	sub sp,#0x1c	; 03800B62
	add r4,r0,#0x0	; 03800B64
	add r6,r1,#0x0	; 03800B66
	add r7,r2,#0x0	; 03800B68
	str r3,[sp,#0x8]	; 03800B6A
	mov r5,#0x0	; 03800B6C
	ldr r1,[sp,#0x30]	; 03800B6E
	ldrh r0,[r6,#0x18]	; 03800B70
	ldrh r2,[r6,#0x1a]	; 03800B72
	mul r0,r2	; 03800B74
	mov r2,#0xf0	; 03800B76
	mul r1,r2	; 03800B78
	asr r2,r0,#0x8	; 03800B7A
	sub r0,r2,#0x1	; 03800B7C
	add r0,r1,r0	; 03800B7E
	add r1,r2,#0x0	; 03800B80
	bl loc_037FE2B0	; 03800B82
	str r0,[sp,#0xc]	; 03800B86
	ldrb r0,[r4,#0x0]	; 03800B88
	lsl r0,r0,#0x1c	; 03800B8A
	lsr r0,r0,#0x1f	; 03800B8C
	cmp r0,#0x0	; 03800B8E
	beq P2_Entry_03800B9E	; 03800B90
	ldr r5,[r4,#0x3c]	; 03800B92
	cmp r5,#0x0	; 03800B94
	beq P2_Entry_03800B9E	; 03800B96
	strb r7,[r5,#0x8]	; 03800B98
	ldr r0,[sp,#0x8]	; 03800B9A
	strb r0,[r5,#0x9]	; 03800B9C
P2_Entry_03800B9E:
	cmp r5,#0x0	; 03800B9E
	bne P2_Entry_03800C3A	; 03800BA0
	ldr r0,[r6,#0x20]	; 03800BA2
	ldrh r1,[r4,#0x2]	; 03800BA4
	add r2,r7,#0x0	; 03800BA6
	add r3,sp,#0x10	; 03800BA8
	bl P2_Entry_03801630	; 03800BAA
	cmp r0,#0x0	; 03800BAE
	beq P2_Entry_03800CB2	; 03800BB0
	add r0,sp,#0x10	; 03800BB2
	ldrb r0,[r0,#0x0]	; 03800BB4
	cmp r0,#0x4	; 03800BB6
	bhi P2_Entry_03800CB2	; 03800BB8
	add r0,r0,r0	; 03800BBA
P2_SwitchIndexPC_03800BBA:
	add r0,pc	; 03800BBC
	ldrh r0,[r0,#(P2_SwitchTable_03800BBA - (P2_SwitchIndexPC_03800BBA + 4))]	; 03800BBE
	lsl r0,r0,#0x10	; 03800BC0
	asr r0,r0,#0x10	; 03800BC2
P2_SwitchTargetPC_03800BBA:
	add r0,pc	; 03800BC4
	bx r0	; 03800BC6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800BBA:
	.halfword (P2_Case_03800BDE + 1) - (P2_SwitchTargetPC_03800BBA + 4)
	.halfword (P2_Case_03800BD2 + 1) - (P2_SwitchTargetPC_03800BBA + 4)
	.halfword (P2_Case_03800BD6 + 1) - (P2_SwitchTargetPC_03800BBA + 4)
	.halfword (P2_Case_03800BDA + 1) - (P2_SwitchTargetPC_03800BBA + 4)
	.halfword (P2_Case_03800BD2 + 1) - (P2_SwitchTargetPC_03800BBA + 4)
P2_SwitchTable_03800BBAEnd:
P2_Case_03800BD2:
	ldr r0,[pool_03800CBC]	; 03800BD2
	b P2_Entry_03800BE0	; 03800BD4
P2_Case_03800BD6:
	ldr r0,[pool_03800CC0]	; 03800BD6
	b P2_Entry_03800BE0	; 03800BD8
P2_Case_03800BDA:
	ldr r0,[pool_03800CC4]	; 03800BDA
	b P2_Entry_03800BE0	; 03800BDC
P2_Case_03800BDE:
	b P2_Entry_03800CB2	; 03800BDE
P2_Entry_03800BE0:
	ldrh r1,[r4,#0x1e]	; 03800BE0
	and r0,r1	; 03800BE2
	str r4,[sp,#0x0]	; 03800BE4
	ldrb r2,[r6,#0x4]	; 03800BE6
	ldrb r1,[r4,#0x12]	; 03800BE8
	add r1,r2,r1	; 03800BEA
	ldrb r2,[r4,#0x0]	; 03800BEC
	lsl r2,r2,#0x18	; 03800BEE
	lsr r2,r2,#0x1f	; 03800BF0
	ldr r3,[pool_03800CC8]	; 03800BF2
	bl P2_Entry_037FFF68	; 03800BF4
	add r5,r0,#0x0	; 03800BF8
	cmp r5,#0x0	; 03800BFA
	beq P2_Entry_03800CB2	; 03800BFC
	ldrb r0,[r4,#0x0]	; 03800BFE
	lsl r0,r0,#0x1c	; 03800C00
	lsr r0,r0,#0x1f	; 03800C02
	cmp r0,#0x0	; 03800C04
	beq P2_Entry_03800C0C	; 03800C06
	mov r3,#0x0	; 03800C08
	b P2_Entry_03800C0E	; 03800C0A
P2_Entry_03800C0C:
	ldr r3,[sp,#0xc]	; 03800C0C
P2_Entry_03800C0E:
	ldr r0,[r6,#0x20]	; 03800C0E
	str r0,[sp,#0x0]	; 03800C10
	add r0,sp,#0x10	; 03800C12
	str r0,[sp,#0x4]	; 03800C14
	add r0,r5,#0x0	; 03800C16
	add r1,r7,#0x0	; 03800C18
	ldr r2,[sp,#0x8]	; 03800C1A
	bl P2_Entry_0380157C	; 03800C1C
	cmp r0,#0x0	; 03800C20
	bne P2_Entry_03800C34	; 03800C22
	mov r1,#0x0	; 03800C24
	add r0,r5,#0x0	; 03800C26
	add r0,#0x22	; 03800C28
	strb r1,[r0,#0x0]	; 03800C2A
	add r0,r5,#0x0	; 03800C2C
	bl loc_037FFF5C	; 03800C2E
	b P2_Entry_03800CB2	; 03800C32
P2_Entry_03800C34:
	ldr r0,[r4,#0x3c]	; 03800C34
	str r0,[r5,#0x50]	; 03800C36
	str r5,[r4,#0x3c]	; 03800C38
P2_Entry_03800C3A:
	ldrb r1,[r4,#0xe]	; 03800C3A
	cmp r1,#0xff	; 03800C3C
	beq P2_Entry_03800C46	; 03800C3E
	add r0,r5,#0x0	; 03800C40
	bl loc_03800068	; 03800C42
P2_Entry_03800C46:
	ldrb r1,[r4,#0xf]	; 03800C46
	cmp r1,#0xff	; 03800C48
	beq P2_Entry_03800C52	; 03800C4A
	add r0,r5,#0x0	; 03800C4C
	bl loc_03800054	; 03800C4E
P2_Entry_03800C52:
	ldrb r1,[r4,#0x10]	; 03800C52
	cmp r1,#0xff	; 03800C54
	beq P2_Entry_03800C5E	; 03800C56
	add r0,r5,#0x0	; 03800C58
	bl loc_03800050	; 03800C5A
P2_Entry_03800C5E:
	ldrb r1,[r4,#0x11]	; 03800C5E
	cmp r1,#0xff	; 03800C60
	beq P2_Entry_03800C6A	; 03800C62
	add r0,r5,#0x0	; 03800C64
	bl loc_0380003C	; 03800C66
P2_Entry_03800C6A:
	mov r0,#0x16	; 03800C6A
	ldrsh r0,[r4,r0]	; 03800C6C
	strh r0,[r5,#0x32]	; 03800C6E
	ldrb r0,[r4,#0x0]	; 03800C70
	lsl r0,r0,#0x1a	; 03800C72
	lsr r0,r0,#0x1f	; 03800C74
	cmp r0,#0x0	; 03800C76
	beq P2_Entry_03800C8E	; 03800C78
	add r1,r5,#0x0	; 03800C7A
	add r1,#0x32	; 03800C7C
	mov r0,#0x0	; 03800C7E
	ldrsh r0,[r1,r0]	; 03800C80
	ldrb r2,[r4,#0x14]	; 03800C82
	sub r2,r2,r7	; 03800C84
	lsl r2,r2,#0x16	; 03800C86
	asr r2,r2,#0x10	; 03800C88
	add r0,r0,r2	; 03800C8A
	strh r0,[r1,#0x0]	; 03800C8C
P2_Entry_03800C8E:
	ldrb r0,[r4,#0x15]	; 03800C8E
	cmp r0,#0x0	; 03800C90
	bne P2_Entry_03800C9A	; 03800C92
	ldr r0,[sp,#0xc]	; 03800C94
	str r0,[r5,#0x18]	; 03800C96
	b P2_Entry_03800CAE	; 03800C98
P2_Entry_03800C9A:
	add r1,r0,#0x0	; 03800C9A
	mul r1,r0	; 03800C9C
	mov r0,#0x32	; 03800C9E
	ldrsh r0,[r5,r0]	; 03800CA0
	cmp r0,#0x0	; 03800CA2
	bge P2_Entry_03800CA8	; 03800CA4
	neg r0,r0	; 03800CA6
P2_Entry_03800CA8:
	mul r1,r0	; 03800CA8
	asr r0,r1,#0xb	; 03800CAA
	str r0,[r5,#0x18]	; 03800CAC
P2_Entry_03800CAE:
	mov r0,#0x0	; 03800CAE
	str r0,[r5,#0x14]	; 03800CB0
P2_Entry_03800CB2:
	add sp,#0x1c	; 03800CB2
	pop {r4,r5,r6,r7}	; 03800CB4
	pop {r3}	; 03800CB6
	bx r3	; 03800CB8
	.byte 0xC0, 0x46	; 03800CBA
pool_03800CBC:
	.word 0x0000FFFF	; 03800CBC
pool_03800CC0:
	.word 0x00003F00	; 03800CC0
pool_03800CC4:
	.word 0x0000C000	; 03800CC4
pool_03800CC8:
	.word 0x03800D75	; 03800CC8
P2_Entry_03800CCC:
	push {r4,r5,lr}	; 03800CCC
	sub sp,#0x4	; 03800CCE
	add r5,r0,#0x0	; 03800CD0
	mov r4,#0x0	; 03800CD2
P2_Entry_03800CD4:
	add r0,r5,#0x0	; 03800CD4
	add r1,r4,#0x0	; 03800CD6
	bl loc_03800E2C	; 03800CD8
	cmp r0,#0x0	; 03800CDC
	beq P2_Entry_03800CE6	; 03800CDE
	add r1,r5,#0x0	; 03800CE0
	bl loc_03800CF4	; 03800CE2
P2_Entry_03800CE6:
	add r4,r4,#0x1	; 03800CE6
	cmp r4,#0x10	; 03800CE8
	blt P2_Entry_03800CD4	; 03800CEA
	add sp,#0x4	; 03800CEC
	pop {r4,r5}	; 03800CEE
	pop {r3}	; 03800CF0
	bx r3	; 03800CF2

; ===== function loc_03800CF4 =====
loc_03800CF4:
	push {r4,r5,r6,r7,lr}	; 03800CF4
	sub sp,#0x4	; 03800CF6
	add r2,r0,#0x0	; 03800CF8
	ldr r0,[r2,#0x3c]	; 03800CFA
	mov r3,#0x6	; 03800CFC
	ldrsh r6,[r1,r3]	; 03800CFE
	mov r3,#0xa	; 03800D00
	ldrsh r5,[r2,r3]	; 03800D02
	ldrb r1,[r1,#0x5]	; 03800D04
	lsl r1,r1,#0x1	; 03800D06
	ldr r4,[pool_03800D70]	; 03800D08
	ldrsh r3,[r4,r1]	; 03800D0A
	ldrb r1,[r2,#0x4]	; 03800D0C
	lsl r1,r1,#0x1	; 03800D0E
	ldrsh r1,[r4,r1]	; 03800D10
	ldrb r7,[r2,#0x5]	; 03800D12
	lsl r7,r7,#0x1	; 03800D14
	ldrsh r4,[r4,r7]	; 03800D16
	add r1,r1,r4	; 03800D18
	add r1,r3,r1	; 03800D1A
	add r1,r5,r1	; 03800D1C
	add r4,r6,r1	; 03800D1E
	mov r1,#0x8	; 03800D20
	ldrsb r3,[r2,r1]	; 03800D22
	mov r1,#0x9	; 03800D24
	ldrsb r1,[r2,r1]	; 03800D26
	add r3,r3,r1	; 03800D28
	mov r1,#0x6	; 03800D2A
	ldrsb r5,[r2,r1]	; 03800D2C
	ldrb r1,[r2,#0x7]	; 03800D2E
	lsl r1,r1,#0x6	; 03800D30
	mul r5,r1	; 03800D32
	asr r5,r5,#0x7	; 03800D34
	mov r1,#0xc	; 03800D36
	ldrsh r1,[r2,r1]	; 03800D38
	add r1,r5,r1	; 03800D3A
	mov r5,#0x7f	; 03800D3C
	mvn r6,r5	; 03800D3E
	cmp r3,r6	; 03800D40
	bge loc_03800D48	; 03800D42
	add r3,r6,#0x0	; 03800D44
	b loc_03800D64	; 03800D46
loc_03800D48:
	cmp r3,#0x7f	; 03800D48
	ble loc_03800D64	; 03800D4A
	add r3,r5,#0x0	; 03800D4C
	b loc_03800D64	; 03800D4E
loc_03800D50:
	strh r4,[r0,#0xc]	; 03800D50
	strh r1,[r0,#0xe]	; 03800D52
	strb r3,[r0,#0xb]	; 03800D54
	ldrh r5,[r2,#0x18]	; 03800D56
	strh r5,[r0,#0x28]	; 03800D58
	ldrh r5,[r2,#0x1a]	; 03800D5A
	strh r5,[r0,#0x2a]	; 03800D5C
	ldrh r5,[r2,#0x1c]	; 03800D5E
	strh r5,[r0,#0x2c]	; 03800D60
	ldr r0,[r0,#0x50]	; 03800D62
loc_03800D64:
	cmp r0,#0x0	; 03800D64
	bne loc_03800D50	; 03800D66
	add sp,#0x4	; 03800D68
	pop {r4,r5,r6,r7}	; 03800D6A
	pop {r3}	; 03800D6C
	bx r3	; 03800D6E
pool_03800D70:
loc_03800D70:
	.word P2_Data_038050DC	; 03800D70
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x14, 0x1C, 0x01, 0x29, 0x06, 0xD1, 0x01, 0x22, 0x29, 0x1C	; 03800D84
	.byte 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xE8, 0xF8, 0x07, 0xE0, 0x02, 0x29, 0x05, 0xD1, 0x00, 0x22	; 03800D94
	.byte 0x29, 0x1C, 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xDF, 0xF8, 0xE1, 0x6B, 0xA9, 0x42, 0x08, 0xD1	; 03800DA4
	.byte 0x28, 0x6D, 0xE0, 0x63, 0x08, 0xE0, 0xA8, 0x42, 0x02, 0xD1, 0x28, 0x6D, 0x08, 0x65, 0x03, 0xE0	; 03800DB4
	.byte 0x01, 0x1C, 0x08, 0x6D, 0x00, 0x28, 0xF6, 0xD1, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03800DC4

; ===== function loc_03800DC4 =====
loc_03800DC4:
	push {r4,r5,lr}	; 03800DC4
	sub sp,#0x4	; 03800DC6
	add r4,r0,#0x0	; 03800DC8
	mov r5,#0x0	; 03800DCA
loc_03800DCC:
	add r0,r4,#0x0	; 03800DCC
	add r1,r5,#0x0	; 03800DCE
	bl loc_03800DE8	; 03800DD0
	add r5,r5,#0x1	; 03800DD4
	cmp r5,#0x10	; 03800DD6
	blt loc_03800DCC	; 03800DD8
	mov r0,#0x0	; 03800DDA
	strb r0,[r4,#0x0]	; 03800DDC
	add sp,#0x4	; 03800DDE
	pop {r4,r5}	; 03800DE0
	pop {r3}	; 03800DE2
	bx r3	; 03800DE4
	.byte 0x00, 0x00	; 03800DE8

; ===== function loc_03800DE8 =====
loc_03800DE8:
	push {r4,r5,lr}	; 03800DE8
	sub sp,#0x4	; 03800DEA
	add r5,r0,#0x0	; 03800DEC
	add r4,r1,#0x0	; 03800DEE
	bl loc_03800E2C	; 03800DF0
	cmp r0,#0x0	; 03800DF4
	beq loc_03800E12	; 03800DF6
	add r1,r5,#0x0	; 03800DF8
	bl loc_03800E20	; 03800DFA
	add r5,#0x8	; 03800DFE
	ldr r3,[pool_03800E1C]	; 03800E00
	ldrb r0,[r5,r4]	; 03800E02
	lsl r2,r0,#0x6	; 03800E04
	ldrb r1,[r3,r2]	; 03800E06
	mov r0,#0x1	; 03800E08
	bic r1,r0	; 03800E0A
	strb r1,[r3,r2]	; 03800E0C
	mov r0,#0xff	; 03800E0E
	strb r0,[r5,r4]	; 03800E10
loc_03800E12:
	add sp,#0x4	; 03800E12
	pop {r4,r5}	; 03800E14
	pop {r3}	; 03800E16
	bx r3	; 03800E18
	.byte 0xC0, 0x46	; 03800E1C
pool_03800E1C:
loc_03800E1C:
	.word P2_BssStart + 0x1300	; 03800E1C

; ===== function loc_03800E20 =====
loc_03800E20:
	mov r2,#0x0	; 03800E20
	mvn r2,r2	; 03800E22
	ldr r3,[pool_03800E28]	; 03800E24
	bx r3	; 03800E26
pool_03800E28:
loc_03800E28:
	.word loc_03800EB4 + 1	; 03800E28

; ===== function loc_03800E2C =====
loc_03800E2C:
	cmp r1,#0xf	; 03800E2C
	ble loc_03800E34	; 03800E2E
	mov r0,#0x0	; 03800E30
	bx lr	; 03800E32
loc_03800E34:
	add r0,r0,r1	; 03800E34
	ldrb r0,[r0,#0x8]	; 03800E36
	cmp r0,#0xff	; 03800E38
	bne loc_03800E40	; 03800E3A
	mov r0,#0x0	; 03800E3C
	bx lr	; 03800E3E
loc_03800E40:
	ldr r1,[pool_03800E48]	; 03800E40
	lsl r0,r0,#0x6	; 03800E42
	add r0,r1,r0	; 03800E44
	bx lr	; 03800E46
pool_03800E48:
loc_03800E48:
	.word 0x03806654	; 03800E48
P2_Entry_03800E4C:
	push {r4,r5,lr}	; 03800E4C
	sub sp,#0x4	; 03800E4E
	add r5,r0,#0x0	; 03800E50
	mov r4,#0x0	; 03800E52
	add r1,r5,#0x0	; 03800E54
	add r1,#0x1c	; 03800E56
	b P2_Entry_03800E62	; 03800E58
P2_Entry_03800E5A:
	ldrh r0,[r1,#0x0]	; 03800E5A
	sub r0,#0xf0	; 03800E5C
	strh r0,[r1,#0x0]	; 03800E5E
	add r4,r4,#0x1	; 03800E60
P2_Entry_03800E62:
	ldrh r0,[r5,#0x1c]	; 03800E62
	cmp r0,#0xf0	; 03800E64
	bcs P2_Entry_03800E5A	; 03800E66
	ldr r0,[pool_03800EB0]	; 03800E68
	ldr r2,[r0,#0x0]	; 03800E6A
	cmp r2,#0x0	; 03800E6C
	beq P2_Entry_03800E94	; 03800E6E
	add r2,#0x40	; 03800E70
	ldrb r1,[r5,#0x2]	; 03800E72
	mov r0,#0x24	; 03800E74
	mul r1,r0	; 03800E76
	ldr r0,[r2,r1]	; 03800E78
	add r0,r0,r4	; 03800E7A
	str r0,[r2,r1]	; 03800E7C
	b P2_Entry_03800E94	; 03800E7E
P2_Entry_03800E80:
	add r0,r5,#0x0	; 03800E80
	bl P2_Entry_038004E8	; 03800E82
	cmp r0,#0x0	; 03800E86
	beq P2_Entry_03800E92	; 03800E88
	add r0,r5,#0x0	; 03800E8A
	bl loc_03800DC4	; 03800E8C
	b P2_Entry_03800E98	; 03800E90
P2_Entry_03800E92:
	sub r4,r4,#0x1	; 03800E92
P2_Entry_03800E94:
	cmp r4,#0x0	; 03800E94
	bgt P2_Entry_03800E80	; 03800E96
P2_Entry_03800E98:
	ldrh r2,[r5,#0x18]	; 03800E98
	ldrh r0,[r5,#0x1a]	; 03800E9A
	mul r2,r0	; 03800E9C
	add r5,#0x1c	; 03800E9E
	ldrh r1,[r5,#0x0]	; 03800EA0
	asr r0,r2,#0x8	; 03800EA2
	add r0,r1,r0	; 03800EA4
	strh r0,[r5,#0x0]	; 03800EA6
	add sp,#0x4	; 03800EA8
	pop {r4,r5}	; 03800EAA
	pop {r3}	; 03800EAC
	bx r3	; 03800EAE
pool_03800EB0:
	.word P2_BssStart + 0xB7C	; 03800EB0

; ===== function loc_03800EB4 =====
loc_03800EB4:
	push {r4,r5,r6,r7,lr}	; 03800EB4
	sub sp,#0x4	; 03800EB6
	add r5,r0,#0x0	; 03800EB8
	add r6,r2,#0x0	; 03800EBA
	ldr r4,[r5,#0x3c]	; 03800EBC
	bl loc_03800CF4	; 03800EBE
	lsl r0,r6,#0x18	; 03800EC2
	lsr r7,r0,#0x18	; 03800EC4
	b loc_03800EF4	; 03800EC6
loc_03800EC8:
	add r0,r4,#0x0	; 03800EC8
	bl loc_0380002C	; 03800ECA
	cmp r0,#0x0	; 03800ECE
	beq loc_03800EEC	; 03800ED0
	cmp r6,#0x0	; 03800ED2
	blt loc_03800EDE	; 03800ED4
	add r0,r4,#0x0	; 03800ED6
	add r1,r7,#0x0	; 03800ED8
	bl loc_0380003C	; 03800EDA
loc_03800EDE:
	add r1,r4,#0x0	; 03800EDE
	add r1,#0x22	; 03800EE0
	mov r0,#0x1	; 03800EE2
	strb r0,[r1,#0x0]	; 03800EE4
	add r0,r4,#0x0	; 03800EE6
	bl loc_03800034	; 03800EE8
loc_03800EEC:
	add r0,r4,#0x0	; 03800EEC
	bl loc_037FFF5C	; 03800EEE
	ldr r4,[r4,#0x50]	; 03800EF2
loc_03800EF4:
	cmp r4,#0x0	; 03800EF4
	bne loc_03800EC8	; 03800EF6
	mov r0,#0x0	; 03800EF8
	str r0,[r5,#0x3c]	; 03800EFA
	add sp,#0x4	; 03800EFC
	pop {r4,r5,r6,r7}	; 03800EFE
	pop {r3}	; 03800F00
	bx r3	; 03800F02

; ===== function loc_03800F04 =====
loc_03800F04:
	push {r4,r5,r6,r7,lr}	; 03800F04
	sub sp,#0x4	; 03800F06
	mov r2,#0x0	; 03800F08
	strb r2,[r0,#0x1]	; 03800F0A
	str r1,[r0,#0x20]	; 03800F0C
	mov r1,#0x78	; 03800F0E
	strh r1,[r0,#0x18]	; 03800F10
	ldr r1,[pool_03800F60]	; 03800F12
	strh r1,[r0,#0x1a]	; 03800F14
	strh r2,[r0,#0x1c]	; 03800F16
	mov r1,#0x7f	; 03800F18
	strb r1,[r0,#0x5]	; 03800F1A
	strh r2,[r0,#0x6]	; 03800F1C
	mov r1,#0x40	; 03800F1E
	strb r1,[r0,#0x4]	; 03800F20
	mov r3,#0xff	; 03800F22
loc_03800F24:
	add r1,r0,r2	; 03800F24
	strb r3,[r1,#0x8]	; 03800F26
	add r2,r2,#0x1	; 03800F28
	cmp r2,#0x10	; 03800F2A
	blt loc_03800F24	; 03800F2C
	ldr r4,[pool_03800F64]	; 03800F2E
	ldr r5,[r4,#0x0]	; 03800F30
	cmp r5,#0x0	; 03800F32
	beq loc_03800F58	; 03800F34
	mov r2,#0x0	; 03800F36
	ldrb r1,[r0,#0x2]	; 03800F38
	mov r3,#0x24	; 03800F3A
	mul r1,r3	; 03800F3C
	add r1,r5,r1	; 03800F3E
	str r2,[r1,#0x40]	; 03800F40
	mvn r1,r2	; 03800F42
loc_03800F44:
	ldr r7,[r4,#0x0]	; 03800F44
	ldrb r5,[r0,#0x2]	; 03800F46
	mul r5,r3	; 03800F48
	lsl r6,r2,#0x1	; 03800F4A
	add r5,r7,r5	; 03800F4C
	add r5,r6,r5	; 03800F4E
	strh r1,[r5,#0x20]	; 03800F50
	add r2,r2,#0x1	; 03800F52
	cmp r2,#0x10	; 03800F54
	blt loc_03800F44	; 03800F56
loc_03800F58:
	add sp,#0x4	; 03800F58
	pop {r4,r5,r6,r7}	; 03800F5A
	pop {r3}	; 03800F5C
	bx r3	; 03800F5E
pool_03800F60:
loc_03800F60:
	.word 0x00000100	; 03800F60
pool_03800F64:
loc_03800F64:
	.word P2_BssStart + 0xB7C	; 03800F64

; ===== function loc_03800F68 =====
loc_03800F68:
	str r1,[r0,#0x24]	; 03800F68
	ldr r1,[r0,#0x24]	; 03800F6A
	add r1,r1,r2	; 03800F6C
	str r1,[r0,#0x28]	; 03800F6E
	bx lr	; 03800F70
	.byte 0x00, 0x00	; 03800F74

; ===== function loc_03800F74 =====
loc_03800F74:
	push {r4,r5,lr}	; 03800F74
	sub sp,#0x4	; 03800F76
	add r4,r0,#0x0	; 03800F78
	mov r1,#0x0	; 03800F7A
	str r1,[r4,#0x24]	; 03800F7C
	str r1,[r4,#0x28]	; 03800F7E
	ldrb r2,[r4,#0x0]	; 03800F80
	mov r0,#0x2	; 03800F82
	orr r2,r0	; 03800F84
	strb r2,[r4,#0x0]	; 03800F86
	ldrb r3,[r4,#0x0]	; 03800F88
	mov r2,#0x4	; 03800F8A
	bic r3,r2	; 03800F8C
	strb r3,[r4,#0x0]	; 03800F8E
	ldrb r3,[r4,#0x0]	; 03800F90
	mov r2,#0x8	; 03800F92
	bic r3,r2	; 03800F94
	strb r3,[r4,#0x0]	; 03800F96
	ldrb r3,[r4,#0x0]	; 03800F98
	mov r2,#0x10	; 03800F9A
	bic r3,r2	; 03800F9C
	strb r3,[r4,#0x0]	; 03800F9E
	ldrb r3,[r4,#0x0]	; 03800FA0
	mov r2,#0x20	; 03800FA2
	bic r3,r2	; 03800FA4
	strb r3,[r4,#0x0]	; 03800FA6
	ldrb r2,[r4,#0x0]	; 03800FA8
	mov r3,#0x40	; 03800FAA
	orr r2,r3	; 03800FAC
	strb r2,[r4,#0x0]	; 03800FAE
	ldrb r5,[r4,#0x0]	; 03800FB0
	mov r2,#0x80	; 03800FB2
	bic r5,r2	; 03800FB4
	strb r5,[r4,#0x0]	; 03800FB6
	add r2,r4,#0x0	; 03800FB8
	add r2,#0x3b	; 03800FBA
	strb r1,[r2,#0x0]	; 03800FBC
	strh r1,[r4,#0x2]	; 03800FBE
	strb r3,[r4,#0x12]	; 03800FC0
	mov r2,#0x7f	; 03800FC2
	strb r2,[r4,#0x4]	; 03800FC4
	strb r2,[r4,#0x5]	; 03800FC6
	strh r1,[r4,#0xa]	; 03800FC8
	strb r1,[r4,#0x8]	; 03800FCA
	strb r1,[r4,#0x9]	; 03800FCC
	strb r1,[r4,#0x6]	; 03800FCE
	strh r1,[r4,#0xc]	; 03800FD0
	mov r2,#0xff	; 03800FD2
	strb r2,[r4,#0xe]	; 03800FD4
	strb r2,[r4,#0xf]	; 03800FD6
	strb r2,[r4,#0x10]	; 03800FD8
	strb r2,[r4,#0x11]	; 03800FDA
	strb r0,[r4,#0x7]	; 03800FDC
	mov r0,#0x3c	; 03800FDE
	strb r0,[r4,#0x14]	; 03800FE0
	strb r1,[r4,#0x15]	; 03800FE2
	strh r1,[r4,#0x16]	; 03800FE4
	strb r1,[r4,#0x13]	; 03800FE6
	ldr r0,[pool_03801004]	; 03800FE8
	strh r0,[r4,#0x1e]	; 03800FEA
	add r0,r4,#0x0	; 03800FEC
	add r0,#0x18	; 03800FEE
	bl loc_037FFDA4	; 03800FF0
	mov r0,#0x0	; 03800FF4
	str r0,[r4,#0x20]	; 03800FF6
	str r0,[r4,#0x3c]	; 03800FF8
	add sp,#0x4	; 03800FFA
	pop {r4,r5}	; 03800FFC
	pop {r3}	; 03800FFE
	bx r3	; 03801000
	.byte 0xC0, 0x46	; 03801004
pool_03801004:
loc_03801004:
	.word 0x0000FFFF	; 03801004

; ===== function loc_03801008 =====
P2_Entry_03801008:
	push {r4,r5,r6,lr}	; 03801008
	add r4,r0,#0x0	; 0380100A
	add r6,r1,#0x0	; 0380100C
	cmp r2,#0x4	; 0380100E
	bhi loc_03801078	; 03801010
	add r1,r2,r2	; 03801012
P2_SwitchIndexPC_03801012:
	add r1,pc	; 03801014
	ldrh r1,[r1,#(P2_SwitchTable_03801012 - (P2_SwitchIndexPC_03801012 + 4))]	; 03801016
	lsl r1,r1,#0x10	; 03801018
	asr r1,r1,#0x10	; 0380101A
P2_SwitchTargetPC_03801012:
	add r1,pc	; 0380101C
	bx r1	; 0380101E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801012:
	.halfword (loc_0380102A + 1) - (P2_SwitchTargetPC_03801012 + 4)
	.halfword (loc_03801032 + 1) - (P2_SwitchTargetPC_03801012 + 4)
	.halfword (loc_0380103A + 1) - (P2_SwitchTargetPC_03801012 + 4)
	.halfword (loc_03801058 + 1) - (P2_SwitchTargetPC_03801012 + 4)
	.halfword (loc_03801042 + 1) - (P2_SwitchTargetPC_03801012 + 4)
P2_SwitchTable_03801012End:
loc_0380102A:
	bl loc_03801134	; 0380102A
	add r5,r0,#0x0	; 0380102E
	b loc_03801078	; 03801030
loc_03801032:
	bl loc_038010FC	; 03801032
	add r5,r0,#0x0	; 03801036
	b loc_03801078	; 03801038
loc_0380103A:
	bl loc_03801080	; 0380103A
	add r5,r0,#0x0	; 0380103E
	b loc_03801078	; 03801040
loc_03801042:
	bl loc_03801134	; 03801042
	add r1,r0,#0x0	; 03801046
	add r0,r6,#0x0	; 03801048
	bl loc_038004B4	; 0380104A
	cmp r0,#0x0	; 0380104E
	beq loc_03801078	; 03801050
	mov r1,#0x0	; 03801052
	ldrsh r5,[r0,r1]	; 03801054
	b loc_03801078	; 03801056
loc_03801058:
	bl loc_038010FC	; 03801058
	lsl r0,r0,#0x10	; 0380105C
	asr r5,r0,#0x10	; 0380105E
	add r0,r4,#0x0	; 03801060
	bl loc_038010FC	; 03801062
	lsl r0,r0,#0x10	; 03801066
	asr r4,r0,#0x10	; 03801068
	bl loc_037FF770	; 0380106A
	sub r1,r4,r5	; 0380106E
	add r1,r1,#0x1	; 03801070
	mul r0,r1	; 03801072
	asr r0,r0,#0x10	; 03801074
	add r5,r0,r5	; 03801076
loc_03801078:
	add r0,r5,#0x0	; 03801078
	pop {r4,r5,r6}	; 0380107A
	pop {r3}	; 0380107C
	bx r3	; 0380107E

; ===== function loc_03801080 =====
loc_03801080:
	push {r4,r5,r6,r7,lr}	; 03801080
	sub sp,#0x4	; 03801082
	add r6,r0,#0x0	; 03801084
	mov r5,#0x0	; 03801086
	add r4,r6,#0x0	; 03801088
	add r4,#0x28	; 0380108A
	mov r7,#0x80	; 0380108C
loc_0380108E:
	ldr r0,[r6,#0x28]	; 0380108E
	bl loc_0380114C	; 03801090
	ldr r1,[r4,#0x0]	; 03801094
	add r1,r1,#0x1	; 03801096
	str r1,[r4,#0x0]	; 03801098
	lsl r5,r5,#0x7	; 0380109A
	add r2,r0,#0x0	; 0380109C
	mov r1,#0x7f	; 0380109E
	and r2,r1	; 038010A0
	orr r5,r2	; 038010A2
	and r0,r7	; 038010A4
	cmp r0,#0x0	; 038010A6
	bne loc_0380108E	; 038010A8
	add r0,r5,#0x0	; 038010AA
	add sp,#0x4	; 038010AC
	pop {r4,r5,r6,r7}	; 038010AE
	pop {r3}	; 038010B0
	bx r3	; 038010B2
P2_Entry_038010B4:
	push {r4,r5,lr}	; 038010B4
	sub sp,#0x4	; 038010B6
	add r5,r0,#0x0	; 038010B8
	ldr r0,[r5,#0x28]	; 038010BA
	bl loc_0380114C	; 038010BC
	add r4,r0,#0x0	; 038010C0
	add r1,r5,#0x0	; 038010C2
	add r1,#0x28	; 038010C4
	ldr r0,[r1,#0x0]	; 038010C6
	add r0,r0,#0x1	; 038010C8
	str r0,[r1,#0x0]	; 038010CA
	ldr r0,[r5,#0x28]	; 038010CC
	bl loc_0380114C	; 038010CE
	lsl r0,r0,#0x8	; 038010D2
	orr r4,r0	; 038010D4
	add r1,r5,#0x0	; 038010D6
	add r1,#0x28	; 038010D8
	ldr r0,[r1,#0x0]	; 038010DA
	add r0,r0,#0x1	; 038010DC
	str r0,[r1,#0x0]	; 038010DE
	ldr r0,[r5,#0x28]	; 038010E0
	bl loc_0380114C	; 038010E2
	lsl r0,r0,#0x10	; 038010E6
	orr r4,r0	; 038010E8
	add r5,#0x28	; 038010EA
	ldr r0,[r5,#0x0]	; 038010EC
	add r0,r0,#0x1	; 038010EE
	str r0,[r5,#0x0]	; 038010F0
	add r0,r4,#0x0	; 038010F2
	add sp,#0x4	; 038010F4
	pop {r4,r5}	; 038010F6
	pop {r3}	; 038010F8
	bx r3	; 038010FA

; ===== function loc_038010FC =====
loc_038010FC:
	push {r4,r5,lr}	; 038010FC
	sub sp,#0x4	; 038010FE
	add r5,r0,#0x0	; 03801100
	ldr r0,[r5,#0x28]	; 03801102
	bl loc_0380114C	; 03801104
	add r4,r0,#0x0	; 03801108
	add r1,r5,#0x0	; 0380110A
	add r1,#0x28	; 0380110C
	ldr r0,[r1,#0x0]	; 0380110E
	add r0,r0,#0x1	; 03801110
	str r0,[r1,#0x0]	; 03801112
	ldr r0,[r5,#0x28]	; 03801114
	bl loc_0380114C	; 03801116
	lsl r0,r0,#0x8	; 0380111A
	orr r4,r0	; 0380111C
	lsl r0,r4,#0x10	; 0380111E
	lsr r0,r0,#0x10	; 03801120
	add r5,#0x28	; 03801122
	ldr r1,[r5,#0x0]	; 03801124
	add r1,r1,#0x1	; 03801126
	str r1,[r5,#0x0]	; 03801128
	add sp,#0x4	; 0380112A
	pop {r4,r5}	; 0380112C
	pop {r3}	; 0380112E
	bx r3	; 03801130
	.byte 0x00, 0x00	; 03801134

; ===== function loc_03801134 =====
loc_03801134:
	push {r4,lr}	; 03801134
	add r4,r0,#0x0	; 03801136
	ldr r0,[r4,#0x28]	; 03801138
	bl loc_0380114C	; 0380113A
	add r4,#0x28	; 0380113E
	ldr r1,[r4,#0x0]	; 03801140
	add r1,r1,#0x1	; 03801142
	str r1,[r4,#0x0]	; 03801144
	pop {r4}	; 03801146
	pop {r3}	; 03801148
	bx r3	; 0380114A

; ===== function loc_0380114C =====
loc_0380114C:
	push {r4,lr}	; 0380114C
	add r4,r0,#0x0	; 0380114E
	ldr r0,[pool_03801174]	; 03801150
	ldr r1,[r0,#0x0]	; 03801152
	cmp r4,r1	; 03801154
	bcc loc_0380115E	; 03801156
	ldr r0,[r0,#0x4]	; 03801158
	cmp r4,r0	; 0380115A
	bcc loc_03801164	; 0380115C
loc_0380115E:
	add r0,r4,#0x0	; 0380115E
	bl loc_0380117C	; 03801160
loc_03801164:
	ldr r0,[pool_03801174]	; 03801164
	ldr r0,[r0,#0x0]	; 03801166
	sub r1,r4,r0	; 03801168
	ldr r0,[pool_03801178]	; 0380116A
	ldrb r0,[r0,r1]	; 0380116C
	pop {r4}	; 0380116E
	pop {r3}	; 03801170
	bx r3	; 03801172
pool_03801174:
loc_03801174:
	.word P2_BssStart + 0xB64	; 03801174
pool_03801178:
loc_03801178:
	.word P2_BssStart + 0xB6C	; 03801178

; ===== function loc_0380117C =====
loc_0380117C:
	mov r1,#0x3	; 0380117C
	bic r0,r1	; 0380117E
	ldr r1,[pool_0380119C]	; 03801180
	str r0,[r1,#0x0]	; 03801182
	add r2,r0,#0x0	; 03801184
	add r2,#0x10	; 03801186
	str r2,[r1,#0x4]	; 03801188
	ldr r2,[r0,#0x0]	; 0380118A
	str r2,[r1,#0x8]	; 0380118C
	ldr r2,[r0,#0x4]	; 0380118E
	str r2,[r1,#0xc]	; 03801190
	ldr r2,[r0,#0x8]	; 03801192
	str r2,[r1,#0x10]	; 03801194
	ldr r0,[r0,#0xc]	; 03801196
	str r0,[r1,#0x14]	; 03801198
	bx lr	; 0380119A
pool_0380119C:
loc_0380119C:
	.word P2_BssStart + 0xB64	; 0380119C

; ===== function loc_038011A0 =====
loc_038011A0:
	push {r4,r5,r6,r7,lr}	; 038011A0
	sub sp,#0x4	; 038011A2
	add r6,r1,#0x0	; 038011A4
	add r5,r3,#0x0	; 038011A6
	ldr r4,[sp,#0x18]	; 038011A8
	ldr r3,[pool_038011F8]	; 038011AA
	mov r1,#0x24	; 038011AC
	mul r0,r1	; 038011AE
	add r7,r3,r0	; 038011B0
	mov r3,#0x0	; 038011B2
	b loc_038011E8	; 038011B4
loc_038011B6:
	add r1,r6,#0x0	; 038011B6
	mov r0,#0x1	; 038011B8
	and r1,r0	; 038011BA
	cmp r1,#0x0	; 038011BC
	beq loc_038011E4	; 038011BE
	add r0,r7,#0x0	; 038011C0
	add r1,r3,#0x0	; 038011C2
	bl loc_03800E2C	; 038011C4
	cmp r0,#0x0	; 038011C8
	beq loc_038011E4	; 038011CA
	cmp r4,#0x1	; 038011CC
	beq loc_038011DA	; 038011CE
	cmp r4,#0x2	; 038011D0
	beq loc_038011DE	; 038011D2
	cmp r4,#0x4	; 038011D4
	beq loc_038011E2	; 038011D6
	b loc_038011E4	; 038011D8
loc_038011DA:
	strb r5,[r0,r2]	; 038011DA
	b loc_038011E4	; 038011DC
loc_038011DE:
	strh r5,[r0,r2]	; 038011DE
	b loc_038011E4	; 038011E0
loc_038011E2:
	str r5,[r0,r2]	; 038011E2
loc_038011E4:
	add r3,r3,#0x1	; 038011E4
	lsr r6,r6,#0x1	; 038011E6
loc_038011E8:
	cmp r3,#0x10	; 038011E8
	bge loc_038011F0	; 038011EA
	cmp r6,#0x0	; 038011EC
	bne loc_038011B6	; 038011EE
loc_038011F0:
	add sp,#0x4	; 038011F0
	pop {r4,r5,r6,r7}	; 038011F2
	pop {r3}	; 038011F4
	bx r3	; 038011F6
pool_038011F8:
loc_038011F8:
	.word 0x03806414	; 038011F8

; ===== function loc_038011FC =====
loc_038011FC:
	push {r4,r5,lr}	; 038011FC
	sub sp,#0x4	; 038011FE
	ldr r5,[pool_03801228]	; 03801200
	mov r4,#0x24	; 03801202
	mul r0,r4	; 03801204
	add r0,r5,r0	; 03801206
	cmp r3,#0x1	; 03801208
	beq loc_03801216	; 0380120A
	cmp r3,#0x2	; 0380120C
	beq loc_0380121A	; 0380120E
	cmp r3,#0x4	; 03801210
	beq loc_0380121E	; 03801212
	b loc_03801220	; 03801214
loc_03801216:
	strb r2,[r0,r1]	; 03801216
	b loc_03801220	; 03801218
loc_0380121A:
	strh r2,[r0,r1]	; 0380121A
	b loc_03801220	; 0380121C
loc_0380121E:
	str r2,[r0,r1]	; 0380121E
loc_03801220:
	add sp,#0x4	; 03801220
	pop {r4,r5}	; 03801222
	pop {r3}	; 03801224
	bx r3	; 03801226
pool_03801228:
loc_03801228:
	.word 0x03806414	; 03801228

; ===== function loc_0380122C =====
loc_0380122C:
	push {r4,r5,r6,r7,lr}	; 0380122C
	sub sp,#0x4	; 0380122E
	add r5,r0,#0x0	; 03801230
	add r6,r1,#0x0	; 03801232
	mov r4,#0x0	; 03801234
	ldr r7,[pool_03801264]	; 03801236
loc_03801238:
	add r1,r4,#0x0	; 03801238
	mov r0,#0x24	; 0380123A
	mul r1,r0	; 0380123C
	add r0,r7,r1	; 0380123E
	ldrb r1,[r7,r1]	; 03801240
	cmp r1,#0x0	; 03801242
	beq loc_03801254	; 03801244
	ldr r1,[r0,#0x20]	; 03801246
	cmp r5,r1	; 03801248
	bhi loc_03801254	; 0380124A
	cmp r1,r6	; 0380124C
	bhi loc_03801254	; 0380124E
	bl loc_03800DC4	; 03801250
loc_03801254:
	add r4,r4,#0x1	; 03801254
	cmp r4,#0x10	; 03801256
	blt loc_03801238	; 03801258
	add sp,#0x4	; 0380125A
	pop {r4,r5,r6,r7}	; 0380125C
	pop {r3}	; 0380125E
	bx r3	; 03801260
	.byte 0xC0, 0x46	; 03801264
pool_03801264:
loc_03801264:
	.word P2_BssStart + 0x10C0	; 03801264

; ===== function loc_03801268 =====
loc_03801268:
	push {r4,r5,r6,r7,lr}	; 03801268
	sub sp,#0x4	; 0380126A
	add r5,r0,#0x0	; 0380126C
	add r6,r1,#0x0	; 0380126E
	mov r4,#0x0	; 03801270
	add r7,r4,#0x0	; 03801272
loc_03801274:
	add r0,r4,#0x0	; 03801274
	mov r1,#0x24	; 03801276
	mul r0,r1	; 03801278
	ldr r1,[pool_038012BC]	; 0380127A
	add r3,r1,r0	; 0380127C
	ldrb r0,[r1,r0]	; 0380127E
	cmp r0,#0x0	; 03801280
	beq loc_038012AC	; 03801282
	add r2,r7,#0x0	; 03801284
	b loc_038012A8	; 03801286
loc_03801288:
	add r0,r3,#0x0	; 03801288
	add r1,r2,#0x0	; 0380128A
	bl loc_03800E2C	; 0380128C
	cmp r0,#0x0	; 03801290
	beq loc_038012A6	; 03801292
	ldr r0,[r0,#0x28]	; 03801294
	cmp r5,r0	; 03801296
	bhi loc_038012A6	; 03801298
	cmp r0,r6	; 0380129A
	bhi loc_038012A6	; 0380129C
	add r0,r3,#0x0	; 0380129E
	bl loc_03800DC4	; 038012A0
	b loc_038012AC	; 038012A4
loc_038012A6:
	add r2,r2,#0x1	; 038012A6
loc_038012A8:
	cmp r2,#0x10	; 038012A8
	blt loc_03801288	; 038012AA
loc_038012AC:
	add r4,r4,#0x1	; 038012AC
	cmp r4,#0x10	; 038012AE
	blt loc_03801274	; 038012B0
	add sp,#0x4	; 038012B2
	pop {r4,r5,r6,r7}	; 038012B4
	pop {r3}	; 038012B6
	bx r3	; 038012B8
	.byte 0xC0, 0x46	; 038012BC
pool_038012BC:
loc_038012BC:
	.word P2_BssStart + 0x10C0	; 038012BC

; ===== function loc_038012C0 =====
loc_038012C0:
	push {r4,r5,r6,r7,lr}	; 038012C0
	sub sp,#0x4	; 038012C2
	add r5,r1,#0x0	; 038012C4
	ldr r3,[pool_0380130C]	; 038012C6
	mov r1,#0x24	; 038012C8
	mul r0,r1	; 038012CA
	add r4,r3,r0	; 038012CC
	mov r3,#0x0	; 038012CE
	lsl r0,r2,#0x10	; 038012D0
	lsr r2,r0,#0x10	; 038012D2
	mov r7,#0x80	; 038012D4
	mov r6,#0x1	; 038012D6
	b loc_038012FC	; 038012D8
loc_038012DA:
	add r0,r5,#0x0	; 038012DA
	and r0,r6	; 038012DC
	cmp r0,#0x0	; 038012DE
	beq loc_038012F8	; 038012E0
	add r0,r4,#0x0	; 038012E2
	add r1,r3,#0x0	; 038012E4
	bl loc_03800E2C	; 038012E6
	add r1,r0,#0x0	; 038012EA
	cmp r1,#0x0	; 038012EC
	beq loc_038012F8	; 038012EE
	strh r2,[r1,#0x1e]	; 038012F0
	ldrb r0,[r1,#0x0]	; 038012F2
	orr r0,r7	; 038012F4
	strb r0,[r1,#0x0]	; 038012F6
loc_038012F8:
	add r3,r3,#0x1	; 038012F8
	lsr r5,r5,#0x1	; 038012FA
loc_038012FC:
	cmp r3,#0x10	; 038012FC
	bge loc_03801304	; 038012FE
	cmp r5,#0x0	; 03801300
	bne loc_038012DA	; 03801302
loc_03801304:
	add sp,#0x4	; 03801304
	pop {r4,r5,r6,r7}	; 03801306
	pop {r3}	; 03801308
	bx r3	; 0380130A
pool_0380130C:
loc_0380130C:
	.word 0x03806414	; 0380130C

; ===== function loc_03801310 =====
loc_03801310:
	push {r4,r5,r6,r7,lr}	; 03801310
	sub sp,#0x4	; 03801312
	add r5,r1,#0x0	; 03801314
	add r6,r2,#0x0	; 03801316
	ldr r2,[pool_03801374]	; 03801318
	mov r1,#0x24	; 0380131A
	mul r0,r1	; 0380131C
	add r0,r2,r0	; 0380131E
	str r0,[sp,#0x0]	; 03801320
	mov r4,#0x0	; 03801322
	b loc_03801362	; 03801324
loc_03801326:
	add r1,r5,#0x0	; 03801326
	mov r0,#0x1	; 03801328
	and r1,r0	; 0380132A
	cmp r1,#0x0	; 0380132C
	beq loc_0380135E	; 0380132E
	ldr r0,[sp,#0x0]	; 03801330
	add r1,r4,#0x0	; 03801332
	bl loc_03800E2C	; 03801334
	add r7,r0,#0x0	; 03801338
	cmp r7,#0x0	; 0380133A
	beq loc_0380135E	; 0380133C
	cmp r6,#0x0	; 0380133E
	beq loc_0380134A	; 03801340
	ldr r1,[sp,#0x0]	; 03801342
	mov r2,#0x7f	; 03801344
	bl loc_03800EB4	; 03801346
loc_0380134A:
	ldrb r0,[r7,#0x0]	; 0380134A
	mov r1,#0x4	; 0380134C
	bic r0,r1	; 0380134E
	lsl r1,r6,#0x18	; 03801350
	lsr r2,r1,#0x18	; 03801352
	mov r1,#0x1	; 03801354
	and r2,r1	; 03801356
	lsl r1,r2,#0x2	; 03801358
	orr r0,r1	; 0380135A
	strb r0,[r7,#0x0]	; 0380135C
loc_0380135E:
	add r4,r4,#0x1	; 0380135E
	lsr r5,r5,#0x1	; 03801360
loc_03801362:
	cmp r4,#0x10	; 03801362
	bge loc_0380136A	; 03801364
	cmp r5,#0x0	; 03801366
	bne loc_03801326	; 03801368
loc_0380136A:
	add sp,#0x4	; 0380136A
	pop {r4,r5,r6,r7}	; 0380136C
	pop {r3}	; 0380136E
	bx r3	; 03801370
	.byte 0xC0, 0x46	; 03801374
pool_03801374:
loc_03801374:
	.word 0x03806414	; 03801374

; ===== function loc_03801378 =====
loc_03801378:
	push {r4,r5,r6,lr}	; 03801378
	ldr r3,[pool_038013AC]	; 0380137A
	mov r2,#0x24	; 0380137C
	mul r0,r2	; 0380137E
	add r5,r3,r0	; 03801380
	strb r1,[r5,#0x1]	; 03801382
	cmp r1,#0x0	; 03801384
	beq loc_038013A6	; 03801386
	mov r4,#0x0	; 03801388
	mov r6,#0x7f	; 0380138A
loc_0380138C:
	add r0,r5,#0x0	; 0380138C
	add r1,r4,#0x0	; 0380138E
	bl loc_03800E2C	; 03801390
	cmp r0,#0x0	; 03801394
	beq loc_038013A0	; 03801396
	add r1,r5,#0x0	; 03801398
	add r2,r6,#0x0	; 0380139A
	bl loc_03800EB4	; 0380139C
loc_038013A0:
	add r4,r4,#0x1	; 038013A0
	cmp r4,#0x10	; 038013A2
	blt loc_0380138C	; 038013A4
loc_038013A6:
	pop {r4,r5,r6}	; 038013A6
	pop {r3}	; 038013A8
	bx r3	; 038013AA
pool_038013AC:
loc_038013AC:
	.word 0x03806414	; 038013AC

; ===== function loc_038013B0 =====
loc_038013B0:
	push {r4,lr}	; 038013B0
	add r4,r0,#0x0	; 038013B2
	ldr r2,[pool_038013E4]	; 038013B4
	mov r0,#0x24	; 038013B6
	add r1,r4,#0x0	; 038013B8
	mul r1,r0	; 038013BA
	add r0,r2,r1	; 038013BC
	ldrb r1,[r2,r1]	; 038013BE
	cmp r1,#0x0	; 038013C0
	beq loc_038013DC	; 038013C2
	bl loc_03800DC4	; 038013C4
	ldr r0,[pool_038013E8]	; 038013C8
	ldr r0,[r0,#0x0]	; 038013CA
	cmp r0,#0x0	; 038013CC
	beq loc_038013DC	; 038013CE
	add r2,r0,#0x4	; 038013D0
	ldr r1,[r2,#0x0]	; 038013D2
	mov r0,#0x1	; 038013D4
	lsl r0,r4	; 038013D6
	bic r1,r0	; 038013D8
	str r1,[r2,#0x0]	; 038013DA
loc_038013DC:
	pop {r4}	; 038013DC
	pop {r3}	; 038013DE
	bx r3	; 038013E0
	.byte 0xC0, 0x46	; 038013E4
pool_038013E4:
loc_038013E4:
	.word P2_BssStart + 0x10C0	; 038013E4
pool_038013E8:
loc_038013E8:
	.word P2_BssStart + 0xB7C	; 038013E8

; ===== function loc_038013EC =====
loc_038013EC:
	push {r4,r5,r6,r7,lr}	; 038013EC
	sub sp,#0xc	; 038013EE
	str r0,[sp,#0x0]	; 038013F0
	add r7,r1,#0x0	; 038013F2
	str r2,[sp,#0x4]	; 038013F4
	add r4,r3,#0x0	; 038013F6
	ldr r2,[pool_038014B0]	; 038013F8
	mov r0,#0x24	; 038013FA
	ldr r1,[sp,#0x0]	; 038013FC
	mul r1,r0	; 038013FE
	add r5,r2,r1	; 03801400
	ldrb r0,[r2,r1]	; 03801402
	cmp r0,#0x0	; 03801404
	beq loc_0380140E	; 03801406
	add r0,r5,#0x0	; 03801408
	bl loc_03800DC4	; 0380140A
loc_0380140E:
	add r0,r5,#0x0	; 0380140E
	add r1,r4,#0x0	; 03801410
	bl loc_03800F04	; 03801412
	bl loc_03800480	; 03801416
	add r6,r0,#0x0	; 0380141A
	cmp r6,#0x0	; 0380141C
	blt loc_038014A6	; 0380141E
	ldr r1,[pool_038014B4]	; 03801420
	lsl r0,r6,#0x6	; 03801422
	add r4,r1,r0	; 03801424
	add r0,r4,#0x0	; 03801426
	bl loc_03800F74	; 03801428
	add r0,r4,#0x0	; 0380142C
	add r1,r7,#0x0	; 0380142E
	ldr r2,[sp,#0x4]	; 03801430
	bl loc_03800F68	; 03801432
	strb r6,[r5,#0x8]	; 03801436
	ldr r0,[r4,#0x28]	; 03801438
	bl loc_0380117C	; 0380143A
	add r0,r4,#0x0	; 0380143E
	bl loc_03801134	; 03801440
	cmp r0,#0xfe	; 03801444
	beq loc_03801452	; 03801446
	add r4,#0x28	; 03801448
	ldr r0,[r4,#0x0]	; 0380144A
	sub r0,r0,#0x1	; 0380144C
	str r0,[r4,#0x0]	; 0380144E
	b loc_0380148E	; 03801450
loc_03801452:
	add r0,r4,#0x0	; 03801452
	bl loc_038010FC	; 03801454
	lsl r0,r0,#0xf	; 03801458
	lsr r4,r0,#0x10	; 0380145A
	mov r6,#0x1	; 0380145C
	str r6,[sp,#0x8]	; 0380145E
	b loc_0380148A	; 03801460
loc_03801462:
	add r1,r4,#0x0	; 03801462
	ldr r0,[sp,#0x8]	; 03801464
	and r1,r0	; 03801466
	cmp r1,#0x0	; 03801468
	beq loc_03801484	; 0380146A
	bl loc_03800480	; 0380146C
	add r7,r0,#0x0	; 03801470
	cmp r7,#0x0	; 03801472
	blt loc_0380148E	; 03801474
	lsl r1,r7,#0x6	; 03801476
	ldr r0,[pool_038014B4]	; 03801478
	add r0,r0,r1	; 0380147A
	bl loc_03800F74	; 0380147C
	add r0,r5,r6	; 03801480
	strb r7,[r0,#0x8]	; 03801482
loc_03801484:
	add r6,r6,#0x1	; 03801484
	lsl r0,r4,#0xf	; 03801486
	lsr r4,r0,#0x10	; 03801488
loc_0380148A:
	cmp r4,#0x0	; 0380148A
	bne loc_03801462	; 0380148C
loc_0380148E:
	mov r3,#0x1	; 0380148E
	strb r3,[r5,#0x0]	; 03801490
	ldr r0,[pool_038014B8]	; 03801492
	ldr r0,[r0,#0x0]	; 03801494
	cmp r0,#0x0	; 03801496
	beq loc_038014A6	; 03801498
	add r2,r0,#0x4	; 0380149A
	ldr r1,[r2,#0x0]	; 0380149C
	ldr r0,[sp,#0x0]	; 0380149E
	lsl r3,r0	; 038014A0
	orr r1,r3	; 038014A2
	str r1,[r2,#0x0]	; 038014A4
loc_038014A6:
	add sp,#0xc	; 038014A6
	pop {r4,r5,r6,r7}	; 038014A8
	pop {r3}	; 038014AA
	bx r3	; 038014AC
	.byte 0xC0, 0x46	; 038014B0
pool_038014B0:
loc_038014B0:
	.word P2_BssStart + 0x10C0	; 038014B0
pool_038014B4:
loc_038014B4:
	.word 0x03806654	; 038014B4
pool_038014B8:
loc_038014B8:
	.word P2_BssStart + 0xB7C	; 038014B8
P2_Entry_038014BC:
	push {r4,r5,r6,r7,lr}	; 038014BC
	sub sp,#0x4	; 038014BE
	add r7,r0,#0x0	; 038014C0
	mov r6,#0x0	; 038014C2
	add r4,r6,#0x0	; 038014C4
P2_Entry_038014C6:
	add r0,r4,#0x0	; 038014C6
	mov r1,#0x24	; 038014C8
	mul r0,r1	; 038014CA
	ldr r1,[pool_03801510]	; 038014CC
	add r5,r1,r0	; 038014CE
	ldrb r0,[r1,r0]	; 038014D0
	cmp r0,#0x0	; 038014D2
	beq P2_Entry_038014F8	; 038014D4
	cmp r7,#0x0	; 038014D6
	beq P2_Entry_038014E6	; 038014D8
	ldrb r0,[r5,#0x1]	; 038014DA
	cmp r0,#0x0	; 038014DC
	bne P2_Entry_038014E6	; 038014DE
	add r0,r5,#0x0	; 038014E0
	bl P2_Entry_03800E4C	; 038014E2
P2_Entry_038014E6:
	add r0,r5,#0x0	; 038014E6
	bl P2_Entry_03800CCC	; 038014E8
	ldrb r0,[r5,#0x0]	; 038014EC
	cmp r0,#0x0	; 038014EE
	beq P2_Entry_038014F8	; 038014F0
	mov r0,#0x1	; 038014F2
	lsl r0,r4	; 038014F4
	orr r6,r0	; 038014F6
P2_Entry_038014F8:
	add r4,r4,#0x1	; 038014F8
	cmp r4,#0x10	; 038014FA
	blt P2_Entry_038014C6	; 038014FC
	ldr r0,[pool_03801514]	; 038014FE
	ldr r0,[r0,#0x0]	; 03801500
	cmp r0,#0x0	; 03801502
	beq P2_Entry_03801508	; 03801504
	str r6,[r0,#0x4]	; 03801506
P2_Entry_03801508:
	add sp,#0x4	; 03801508
	pop {r4,r5,r6,r7}	; 0380150A
	pop {r3}	; 0380150C
	bx r3	; 0380150E
pool_03801510:
	.word P2_BssStart + 0x10C0	; 03801510
pool_03801514:
	.word P2_BssStart + 0xB7C	; 03801514
P2_Entry_03801518:
	push {r4,r5,lr}	; 03801518
	sub sp,#0x4	; 0380151A
	mov r5,#0x0	; 0380151C
	ldr r3,[pool_03801550]	; 0380151E
	add r0,r5,#0x0	; 03801520
	mov r1,#0x24	; 03801522
P2_Entry_03801524:
	add r2,r5,#0x0	; 03801524
	mul r2,r1	; 03801526
	add r4,r3,r2	; 03801528
	strb r0,[r3,r2]	; 0380152A
	strb r5,[r4,#0x2]	; 0380152C
	add r5,r5,#0x1	; 0380152E
	cmp r5,#0x10	; 03801530
	blt P2_Entry_03801524	; 03801532
	ldr r4,[pool_03801554]	; 03801534
	mov r1,#0x1	; 03801536
P2_Entry_03801538:
	lsl r3,r0,#0x6	; 03801538
	ldrb r2,[r4,r3]	; 0380153A
	bic r2,r1	; 0380153C
	strb r2,[r4,r3]	; 0380153E
	add r0,r0,#0x1	; 03801540
	cmp r0,#0x20	; 03801542
	blt P2_Entry_03801538	; 03801544
	add sp,#0x4	; 03801546
	pop {r4,r5}	; 03801548
	pop {r3}	; 0380154A
	bx r3	; 0380154C
	.byte 0xC0, 0x46	; 0380154E
pool_03801550:
	.word P2_BssStart + 0x10C0	; 03801550
pool_03801554:
	.word P2_BssStart + 0x1300	; 03801554

; ===== function loc_03801558 =====
loc_03801558:
	lsl r1,r1,#0x3	; 03801558
	add r0,r0,r1	; 0380155A
	ldr r1,[r0,#0x18]	; 0380155C
	cmp r1,#0x0	; 0380155E
	bne loc_03801566	; 03801560
	mov r0,#0x0	; 03801562
	bx lr	; 03801564
loc_03801566:
	ldr r0,[r1,#0x38]	; 03801566
	cmp r2,r0	; 03801568
	bcc loc_03801570	; 0380156A
	mov r0,#0x0	; 0380156C
	bx lr	; 0380156E
loc_03801570:
	lsl r0,r2,#0x2	; 03801570
	add r0,r1,r0	; 03801572
	ldr r0,[r0,#0x3c]	; 03801574
	add r0,r1,r0	; 03801576
	bx lr	; 03801578
	.byte 0x00, 0x00	; 0380157C

; ===== function loc_0380157C =====
P2_Entry_0380157C:
	push {r4,r5,r6,r7,lr}	; 0380157C
	sub sp,#0x4	; 0380157E
	add r5,r0,#0x0	; 03801580
	add r7,r1,#0x0	; 03801582
	str r2,[sp,#0x0]	; 03801584
	add r6,r3,#0x0	; 03801586
	ldr r4,[sp,#0x1c]	; 03801588
	ldrb r1,[r4,#0x0]	; 0380158A
	cmp r1,#0x4	; 0380158C
	bhi loc_038015EA	; 0380158E
	add r2,r1,r1	; 03801590
P2_SwitchIndexPC_03801590:
	add r2,pc	; 03801592
	ldrh r2,[r2,#(P2_SwitchTable_03801590 - (P2_SwitchIndexPC_03801590 + 4))]	; 03801594
	lsl r2,r2,#0x10	; 03801596
	asr r2,r2,#0x10	; 03801598
P2_SwitchTargetPC_03801590:
	add r2,pc	; 0380159A
	bx r2	; 0380159C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801590:
	.halfword (loc_038015EA + 1) - (P2_SwitchTargetPC_03801590 + 4)
	.halfword (loc_038015A8 + 1) - (P2_SwitchTargetPC_03801590 + 4)
	.halfword (loc_038015D8 + 1) - (P2_SwitchTargetPC_03801590 + 4)
	.halfword (loc_038015E2 + 1) - (P2_SwitchTargetPC_03801590 + 4)
	.halfword (loc_038015A8 + 1) - (P2_SwitchTargetPC_03801590 + 4)
P2_SwitchTable_03801590End:
loc_038015A8:
	cmp r1,#0x1	; 038015A8
	bne loc_038015BA	; 038015AA
	ldr r0,[sp,#0x18]	; 038015AC
	ldrh r1,[r4,#0x4]	; 038015AE
	ldrh r2,[r4,#0x2]	; 038015B0
	bl loc_03801558	; 038015B2
	add r2,r0,#0x0	; 038015B6
	b loc_038015C2	; 038015B8
loc_038015BA:
	ldrh r0,[r4,#0x4]	; 038015BA
	lsl r2,r0,#0x10	; 038015BC
	ldrh r0,[r4,#0x2]	; 038015BE
	orr r2,r0	; 038015C0
loc_038015C2:
	cmp r2,#0x0	; 038015C2
	beq loc_038015D4	; 038015C4
	add r0,r5,#0x0	; 038015C6
	add r1,r2,#0x0	; 038015C8
	add r2,#0xc	; 038015CA
	add r3,r6,#0x0	; 038015CC
	bl loc_038000E8	; 038015CE
	b loc_038015EC	; 038015D2
loc_038015D4:
	mov r0,#0x0	; 038015D4
	b loc_038015EC	; 038015D6
loc_038015D8:
	ldrh r1,[r4,#0x2]	; 038015D8
	add r2,r6,#0x0	; 038015DA
	bl loc_038000B4	; 038015DC
	b loc_038015EC	; 038015E0
loc_038015E2:
	add r1,r6,#0x0	; 038015E2
	bl loc_03800084	; 038015E4
	b loc_038015EC	; 038015E8
loc_038015EA:
	mov r0,#0x0	; 038015EA
loc_038015EC:
	cmp r0,#0x0	; 038015EC
	bne loc_038015F4	; 038015EE
	mov r0,#0x0	; 038015F0
	b loc_03801626	; 038015F2
loc_038015F4:
	strb r7,[r5,#0x8]	; 038015F4
	ldrb r0,[r4,#0x6]	; 038015F6
	strb r0,[r5,#0x5]	; 038015F8
	ldr r0,[sp,#0x0]	; 038015FA
	strb r0,[r5,#0x9]	; 038015FC
	add r0,r5,#0x0	; 038015FE
	ldrb r1,[r4,#0x7]	; 03801600
	bl loc_03800068	; 03801602
	add r0,r5,#0x0	; 03801606
	ldrb r1,[r4,#0x8]	; 03801608
	bl loc_03800054	; 0380160A
	add r0,r5,#0x0	; 0380160E
	ldrb r1,[r4,#0x9]	; 03801610
	bl loc_03800050	; 03801612
	add r0,r5,#0x0	; 03801616
	ldrb r1,[r4,#0xa]	; 03801618
	bl loc_0380003C	; 0380161A
	ldrb r0,[r4,#0xb]	; 0380161E
	sub r0,#0x40	; 03801620
	strb r0,[r5,#0xa]	; 03801622
	mov r0,#0x1	; 03801624
loc_03801626:
	add sp,#0x4	; 03801626
	pop {r4,r5,r6,r7}	; 03801628
	pop {r3}	; 0380162A
	bx r3	; 0380162C
	.byte 0x00, 0x00	; 0380162E
P2_Entry_03801630:
	push {r4,r5,lr}	; 03801630
	sub sp,#0x4	; 03801632
	add r4,r0,#0x0	; 03801634
	add r0,r3,#0x0	; 03801636
	cmp r1,#0x0	; 03801638
	bge P2_Entry_03801640	; 0380163A
	mov r0,#0x0	; 0380163C
	b P2_Entry_03801702	; 0380163E
P2_Entry_03801640:
	ldr r3,[r4,#0x38]	; 03801640
	cmp r1,r3	; 03801642
	bcc P2_Entry_0380164A	; 03801644
	mov r0,#0x0	; 03801646
	b P2_Entry_03801702	; 03801648
P2_Entry_0380164A:
	lsl r1,r1,#0x2	; 0380164A
	add r1,r4,r1	; 0380164C
	ldr r3,[r1,#0x3c]	; 0380164E
	strb r3,[r0,#0x0]	; 03801650
	ldrb r1,[r0,#0x0]	; 03801652
	cmp r1,#0x10	; 03801654
	bgt P2_Entry_03801678	; 03801656
	cmp r1,#0x10	; 03801658
	bge P2_Entry_03801696	; 0380165A
	cmp r1,#0x4	; 0380165C
	bhi P2_Entry_038016FC	; 0380165E
	add r5,r1,r1	; 03801660
P2_SwitchIndexPC_03801660:
	add r5,pc	; 03801662
	ldrh r5,[r5,#(P2_SwitchTable_03801660 - (P2_SwitchIndexPC_03801660 + 4))]	; 03801664
	lsl r5,r5,#0x10	; 03801666
	asr r5,r5,#0x10	; 03801668
P2_SwitchTargetPC_03801660:
	add r5,pc	; 0380166A
	bx r5	; 0380166C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801660:
	.halfword (P2_Entry_038016FC + 1) - (P2_SwitchTargetPC_03801660 + 4)
	.halfword (P2_Case_0380167E + 1) - (P2_SwitchTargetPC_03801660 + 4)
	.halfword (P2_Case_0380167E + 1) - (P2_SwitchTargetPC_03801660 + 4)
	.halfword (P2_Case_0380167E + 1) - (P2_SwitchTargetPC_03801660 + 4)
	.halfword (P2_Case_0380167E + 1) - (P2_SwitchTargetPC_03801660 + 4)
P2_SwitchTable_03801660End:
P2_Entry_03801678:
	cmp r1,#0x11	; 03801678
	beq P2_Entry_038016CA	; 0380167A
	b P2_Entry_038016FC	; 0380167C
P2_Case_0380167E:
	lsr r1,r3,#0x8	; 0380167E
	add r3,r4,r1	; 03801680
	add r2,r0,#0x2	; 03801682
	mov r1,#0x5	; 03801684
P2_Entry_03801686:
	ldrh r0,[r3,#0x0]	; 03801686
	add r3,r3,#0x2	; 03801688
	strh r0,[r2,#0x0]	; 0380168A
	add r2,r2,#0x2	; 0380168C
	sub r1,r1,#0x1	; 0380168E
	cmp r1,#0x0	; 03801690
	bne P2_Entry_03801686	; 03801692
	b P2_Entry_03801700	; 03801694
P2_Entry_03801696:
	lsr r3,r3,#0x8	; 03801696
	add r1,r4,r3	; 03801698
	ldrb r5,[r1,#0x1]	; 0380169A
	ldrb r3,[r4,r3]	; 0380169C
	cmp r2,r3	; 0380169E
	bge P2_Entry_038016A6	; 038016A0
	mov r0,#0x0	; 038016A2
	b P2_Entry_03801702	; 038016A4
P2_Entry_038016A6:
	cmp r2,r5	; 038016A6
	ble P2_Entry_038016AE	; 038016A8
	mov r0,#0x0	; 038016AA
	b P2_Entry_03801702	; 038016AC
P2_Entry_038016AE:
	sub r3,r2,r3	; 038016AE
	mov r2,#0xc	; 038016B0
	mul r3,r2	; 038016B2
	add r1,r1,r3	; 038016B4
	add r3,r1,#0x2	; 038016B6
	mov r2,#0x6	; 038016B8
P2_Entry_038016BA:
	ldrh r1,[r3,#0x0]	; 038016BA
	add r3,r3,#0x2	; 038016BC
	strh r1,[r0,#0x0]	; 038016BE
	add r0,r0,#0x2	; 038016C0
	sub r2,r2,#0x1	; 038016C2
	cmp r2,#0x0	; 038016C4
	bne P2_Entry_038016BA	; 038016C6
	b P2_Entry_03801700	; 038016C8
P2_Entry_038016CA:
	mov r1,#0x0	; 038016CA
	lsr r3,r3,#0x8	; 038016CC
	add r4,r4,r3	; 038016CE
	b P2_Entry_038016DC	; 038016D0
P2_Entry_038016D2:
	add r1,r1,#0x1	; 038016D2
	cmp r1,#0x8	; 038016D4
	blt P2_Entry_038016DC	; 038016D6
	mov r0,#0x0	; 038016D8
	b P2_Entry_03801702	; 038016DA
P2_Entry_038016DC:
	ldrb r3,[r4,r1]	; 038016DC
	cmp r2,r3	; 038016DE
	bgt P2_Entry_038016D2	; 038016E0
	mov r2,#0xc	; 038016E2
	mul r1,r2	; 038016E4
	add r3,r4,r1	; 038016E6
	add r3,#0x8	; 038016E8
	mov r2,#0x6	; 038016EA
P2_Entry_038016EC:
	ldrh r1,[r3,#0x0]	; 038016EC
	add r3,r3,#0x2	; 038016EE
	strh r1,[r0,#0x0]	; 038016F0
	add r0,r0,#0x2	; 038016F2
	sub r2,r2,#0x1	; 038016F4
	cmp r2,#0x0	; 038016F6
	bne P2_Entry_038016EC	; 038016F8
	b P2_Entry_03801700	; 038016FA
P2_Entry_038016FC:
	mov r0,#0x0	; 038016FC
	b P2_Entry_03801702	; 038016FE
P2_Entry_03801700:
	mov r0,#0x1	; 03801700
P2_Entry_03801702:
	add sp,#0x4	; 03801702
	pop {r4,r5}	; 03801704
	pop {r3}	; 03801706
	bx r3	; 03801708
	.byte 0x00, 0x00	; 0380170A

; ===== function loc_0380170C =====
loc_0380170C:
	push {r4,r5,r6,r7,lr}	; 0380170C
	sub sp,#0x4	; 0380170E
	mov r5,#0x0	; 03801710
	add r4,r5,#0x0	; 03801712
	ldr r0,[pool_03801770]	; 03801714
	ldr r0,[r0,#0x0]	; 03801716
	cmp r0,#0x0	; 03801718
	beq loc_03801768	; 0380171A
	add r6,r5,#0x0	; 0380171C
	mov r7,#0x1	; 0380171E
loc_03801720:
	add r0,r6,#0x0	; 03801720
	bl loc_037FF518	; 03801722
	cmp r0,#0x0	; 03801726
	beq loc_03801734	; 03801728
	add r0,r7,#0x0	; 0380172A
	lsl r0,r6	; 0380172C
	orr r5,r0	; 0380172E
	lsl r0,r5,#0x10	; 03801730
	lsr r5,r0,#0x10	; 03801732
loc_03801734:
	add r6,r6,#0x1	; 03801734
	cmp r6,#0x10	; 03801736
	blt loc_03801720	; 03801738
	mov r0,#0x0	; 0380173A
	bl loc_037FFA6C	; 0380173C
	cmp r0,#0x0	; 03801740
	beq loc_0380174C	; 03801742
	mov r0,#0x1	; 03801744
	orr r4,r0	; 03801746
	lsl r0,r4,#0x10	; 03801748
	lsr r4,r0,#0x10	; 0380174A
loc_0380174C:
	mov r0,#0x1	; 0380174C
	bl loc_037FFA6C	; 0380174E
	cmp r0,#0x0	; 03801752
	beq loc_0380175E	; 03801754
	mov r0,#0x2	; 03801756
	orr r4,r0	; 03801758
	lsl r0,r4,#0x10	; 0380175A
	lsr r4,r0,#0x10	; 0380175C
loc_0380175E:
	ldr r0,[pool_03801770]	; 0380175E
	ldr r1,[r0,#0x0]	; 03801760
	strh r5,[r1,#0x8]	; 03801762
	ldr r0,[r0,#0x0]	; 03801764
	strh r4,[r0,#0xa]	; 03801766
loc_03801768:
	add sp,#0x4	; 03801768
	pop {r4,r5,r6,r7}	; 0380176A
	pop {r3}	; 0380176C
	bx r3	; 0380176E
pool_03801770:
loc_03801770:
	.word P2_BssStart + 0xB7C	; 03801770

; ===== function loc_03801774 =====
loc_03801774:
	ldr r2,[pool_03801784]	; 03801774
	ldr r2,[r2,#0x0]	; 03801776
	lsl r0,r0,#0x1	; 03801778
	add r2,r2,r0	; 0380177A
	ldr r0,[pool_03801788]	; 0380177C
	strh r1,[r2,r0]	; 0380177E
	bx lr	; 03801780
	.byte 0xC0, 0x46	; 03801784
pool_03801784:
loc_03801784:
	.word P2_BssStart + 0xB7C	; 03801784
pool_03801788:
loc_03801788:
	.word 0x00000260	; 03801788

; ===== function loc_0380178C =====
loc_0380178C:
	push {r4,lr}	; 0380178C
	ldr r3,[pool_038017A4]	; 0380178E
	ldr r4,[r3,#0x0]	; 03801790
	mov r3,#0x24	; 03801792
	mul r0,r3	; 03801794
	add r3,r4,r0	; 03801796
	lsl r0,r1,#0x1	; 03801798
	add r0,r3,r0	; 0380179A
	strh r2,[r0,#0x20]	; 0380179C
	pop {r4}	; 0380179E
	pop {r3}	; 038017A0
	bx r3	; 038017A2
pool_038017A4:
loc_038017A4:
	.word P2_BssStart + 0xB7C	; 038017A4

; ===== function loc_038017A8 =====
	push {r4,r5,r6,lr}	; 038017A8
	add r5,r0,#0x0	; 038017AA
	mov r4,#0x7	; 038017AC
	mov r6,#0x0	; 038017AE
loc_038017B0:
	add r0,r4,#0x0	; 038017B0
	add r1,r5,#0x0	; 038017B2
	add r2,r6,#0x0	; 038017B4
	bl loc_03801EEC	; 038017B6
	cmp r0,#0x0	; 038017BA
	blt loc_038017B0	; 038017BC
	pop {r4,r5,r6}	; 038017BE
	pop {r3}	; 038017C0
	bx r3	; 038017C2

; ===== function loc_038017C4 =====
loc_038017C4:
	push {r4,lr}	; 038017C4
	ldr r1,[pool_038017EC]	; 038017C6
	lsl r0,r0,#0x6	; 038017C8
	add r4,r1,r0	; 038017CA
	ldrb r0,[r1,r0]	; 038017CC
	cmp r0,#0x0	; 038017CE
	beq loc_038017E6	; 038017D0
	add r0,r4,#0x0	; 038017D2
	add r0,#0x14	; 038017D4
	bl loc_037FEA18	; 038017D6
	add r1,r4,#0x1	; 038017DA
	ldrb r0,[r1,#0x0]	; 038017DC
	add r0,r0,#0x1	; 038017DE
	strb r0,[r1,#0x0]	; 038017E0
	mov r0,#0x0	; 038017E2
	strb r0,[r4,#0x0]	; 038017E4
loc_038017E6:
	pop {r4}	; 038017E6
	pop {r3}	; 038017E8
	bx r3	; 038017EA
pool_038017EC:
loc_038017EC:
	.word P2_BssStart + 0x1B00	; 038017EC

; ===== function loc_038017F0 =====
loc_038017F0:
	push {r4,r5,r6,r7,lr}	; 038017F0
	sub sp,#0x1c	; 038017F2
	str r0,[sp,#0xc]	; 038017F4
	ldr r1,[pool_0380187C]	; 038017F6
	lsl r0,r0,#0x6	; 038017F8
	add r5,r1,r0	; 038017FA
	ldrb r0,[r1,r0]	; 038017FC
	cmp r0,#0x0	; 038017FE
	beq loc_0380180E	; 03801800
	add r0,r5,#0x0	; 03801802
	add r0,#0x14	; 03801804
	bl loc_037FEA18	; 03801806
	mov r0,#0x0	; 0380180A
	strb r0,[r5,#0x0]	; 0380180C
loc_0380180E:
	ldr r6,[r5,#0x4]	; 0380180E
	ldr r7,[r5,#0x8]	; 03801810
	ldr r0,[r5,#0xc]	; 03801812
	str r0,[sp,#0x10]	; 03801814
	ldr r0,[r5,#0x10]	; 03801816
	str r0,[sp,#0x14]	; 03801818
	ldrb r0,[r5,#0x1]	; 0380181A
	lsl r4,r0,#0x8	; 0380181C
	ldr r0,[sp,#0xc]	; 0380181E
	orr r4,r0	; 03801820
	add r0,r5,#0x0	; 03801822
	add r0,#0x14	; 03801824
	bl loc_037FEBF0	; 03801826
	mov r2,#0x0	; 0380182A
	ldr r1,[sp,#0x14]	; 0380182C
	eor r1,r2	; 0380182E
	ldr r0,[sp,#0x10]	; 03801830
	eor r0,r2	; 03801832
	orr r1,r0	; 03801834
	bne loc_0380184A	; 03801836
	str r4,[sp,#0x0]	; 03801838
	add r0,r5,#0x0	; 0380183A
	add r0,#0x14	; 0380183C
	add r1,r6,#0x0	; 0380183E
	add r2,r7,#0x0	; 03801840
	ldr r3,[pool_03801880]	; 03801842
	bl loc_037FEAC4	; 03801844
	b loc_0380186E	; 03801848
loc_0380184A:
	bl loc_037FE824	; 0380184A
	str r0,[sp,#0x18]	; 0380184E
	add r2,r1,#0x0	; 03801850
	ldr r0,[pool_03801880]	; 03801852
	str r0,[sp,#0x4]	; 03801854
	str r4,[sp,#0x8]	; 03801856
	ldr r3,[sp,#0x10]	; 03801858
	ldr r0,[sp,#0x14]	; 0380185A
	str r0,[sp,#0x0]	; 0380185C
	add r0,r5,#0x0	; 0380185E
	add r0,#0x14	; 03801860
	ldr r1,[sp,#0x18]	; 03801862
	add r1,r6,r1	; 03801864
	adc r7,r2	; 03801866
	add r2,r7,#0x0	; 03801868
	bl loc_037FEA74	; 0380186A
loc_0380186E:
	mov r0,#0x1	; 0380186E
	strb r0,[r5,#0x0]	; 03801870
	add sp,#0x1c	; 03801872
	pop {r4,r5,r6,r7}	; 03801874
	pop {r3}	; 03801876
	bx r3	; 03801878
	.byte 0xC0, 0x46	; 0380187C
pool_0380187C:
loc_0380187C:
	.word P2_BssStart + 0x1B00	; 0380187C
pool_03801880:
loc_03801880:
	.word 0x038017A9	; 03801880

; ===== function loc_03801884 =====
loc_03801884:
	push {r4,r5,r6,lr}	; 03801884
	sub sp,#0x8	; 03801886
	add r5,r1,#0x0	; 03801888
	add r6,r2,#0x0	; 0380188A
	str r3,[sp,#0x0]	; 0380188C
	ldr r1,[sp,#0x18]	; 0380188E
	str r1,[sp,#0x4]	; 03801890
	ldr r1,[pool_038018C4]	; 03801892
	lsl r0,r0,#0x6	; 03801894
	add r4,r1,r0	; 03801896
	ldrb r0,[r1,r0]	; 03801898
	cmp r0,#0x0	; 0380189A
	beq loc_038018AA	; 0380189C
	add r0,r4,#0x0	; 0380189E
	add r0,#0x14	; 038018A0
	bl loc_037FEA18	; 038018A2
	mov r0,#0x0	; 038018A6
	strb r0,[r4,#0x0]	; 038018A8
loc_038018AA:
	str r5,[r4,#0x4]	; 038018AA
	str r6,[r4,#0x8]	; 038018AC
	ldr r0,[sp,#0x0]	; 038018AE
	str r0,[r4,#0xc]	; 038018B0
	ldr r0,[sp,#0x4]	; 038018B2
	str r0,[r4,#0x10]	; 038018B4
	ldr r0,[sp,#0x1c]	; 038018B6
	strb r0,[r4,#0x1]	; 038018B8
	add sp,#0x8	; 038018BA
	pop {r4,r5,r6}	; 038018BC
	pop {r3}	; 038018BE
	bx r3	; 038018C0
	.byte 0xC0, 0x46	; 038018C4
pool_038018C4:
loc_038018C4:
	.word P2_BssStart + 0x1B00	; 038018C4
P2_Entry_038018C8:
	push {r4,r5,lr}	; 038018C8
	sub sp,#0x4	; 038018CA
	mov r5,#0x0	; 038018CC
	ldr r4,[pool_038018EC]	; 038018CE
	add r2,r5,#0x0	; 038018D0
	ldr r0,[pool_038018F0]	; 038018D2
	ldr r1,[pool_038018F4]	; 038018D4
P2_Entry_038018D6:
	lsl r3,r5,#0x6	; 038018D6
	add r3,r4,r3	; 038018D8
	strb r2,[r3,r0]	; 038018DA
	strb r2,[r3,r1]	; 038018DC
	add r5,r5,#0x1	; 038018DE
	cmp r5,#0x8	; 038018E0
	blt P2_Entry_038018D6	; 038018E2
	add sp,#0x4	; 038018E4
	pop {r4,r5}	; 038018E6
	pop {r3}	; 038018E8
	bx r3	; 038018EA
pool_038018EC:
	.word 0x03805ED4	; 038018EC
pool_038018F0:
	.word 0x00000F80	; 038018F0
pool_038018F4:
	.word 0x00000F81	; 038018F4

; ===== function loc_038018F8 =====
loc_038018F8:
	push {r4,r5,r6,r7,lr}	; 038018F8
	sub sp,#0xc	; 038018FA
	add r5,r0,#0x0	; 038018FC
	add r7,r1,#0x0	; 038018FE
	add r6,r2,#0x0	; 03801900
	str r3,[sp,#0x0]	; 03801902
	bl loc_037FDC9C	; 03801904
	str r0,[sp,#0x4]	; 03801908
	mov r4,#0x0	; 0380190A
	b loc_03801922	; 0380190C
loc_0380190E:
	add r1,r6,#0x0	; 0380190E
	mov r0,#0x1	; 03801910
	and r1,r0	; 03801912
	cmp r1,#0x0	; 03801914
	beq loc_0380191E	; 03801916
	add r0,r4,#0x0	; 03801918
	bl loc_038017C4	; 0380191A
loc_0380191E:
	add r4,r4,#0x1	; 0380191E
	lsr r6,r6,#0x1	; 03801920
loc_03801922:
	cmp r4,#0x8	; 03801922
	bge loc_0380192A	; 03801924
	cmp r6,#0x0	; 03801926
	bne loc_0380190E	; 03801928
loc_0380192A:
	mov r4,#0x0	; 0380192A
	mov r6,#0x1	; 0380192C
	b loc_03801944	; 0380192E
loc_03801930:
	add r0,r5,#0x0	; 03801930
	and r0,r6	; 03801932
	cmp r0,#0x0	; 03801934
	beq loc_03801940	; 03801936
	add r0,r4,#0x0	; 03801938
	ldr r1,[sp,#0x0]	; 0380193A
	bl loc_037FF5E4	; 0380193C
loc_03801940:
	add r4,r4,#0x1	; 03801940
	lsr r5,r5,#0x1	; 03801942
loc_03801944:
	cmp r4,#0x10	; 03801944
	bge loc_0380194C	; 03801946
	cmp r5,#0x0	; 03801948
	bne loc_03801930	; 0380194A
loc_0380194C:
	mov r0,#0x1	; 0380194C
	add r1,r7,#0x0	; 0380194E
	and r1,r0	; 03801950
	cmp r1,#0x0	; 03801952
	beq loc_0380195C	; 03801954
	mov r1,#0x0	; 03801956
	ldr r0,[pool_0380197C]	; 03801958
	strb r1,[r0,#0x0]	; 0380195A
loc_0380195C:
	mov r0,#0x2	; 0380195C
	and r7,r0	; 0380195E
	cmp r7,#0x0	; 03801960
	beq loc_0380196A	; 03801962
	mov r1,#0x0	; 03801964
	ldr r0,[pool_03801980]	; 03801966
	strb r1,[r0,#0x0]	; 03801968
loc_0380196A:
	ldr r0,[sp,#0x4]	; 0380196A
	bl loc_037FDCC0	; 0380196C
	bl loc_0380170C	; 03801970
	add sp,#0xc	; 03801974
	pop {r4,r5,r6,r7}	; 03801976
	pop {r3}	; 03801978
	bx r3	; 0380197A
pool_0380197C:
loc_0380197C:
	.word REG_SNDCAP0CNT	; 0380197C
pool_03801980:
loc_03801980:
	.word REG_SNDCAP1CNT	; 03801980

; ===== function loc_03801984 =====
loc_03801984:
	push {r4,r5,r6,r7,lr}	; 03801984
	sub sp,#0x4	; 03801986
	add r5,r0,#0x0	; 03801988
	add r4,r1,#0x0	; 0380198A
	add r6,r2,#0x0	; 0380198C
	bl loc_037FDC9C	; 0380198E
	add r7,r0,#0x0	; 03801992
	mov r3,#0x0	; 03801994
	b loc_038019B4	; 03801996
loc_03801998:
	add r1,r5,#0x0	; 03801998
	mov r0,#0x1	; 0380199A
	and r1,r0	; 0380199C
	cmp r1,#0x0	; 0380199E
	beq loc_038019B0	; 038019A0
	lsl r1,r3,#0x4	; 038019A2
	ldr r0,[pool_03801A2C]	; 038019A4
	add r2,r1,r0	; 038019A6
	ldrb r1,[r2,#0x0]	; 038019A8
	mov r0,#0x80	; 038019AA
	orr r1,r0	; 038019AC
	strb r1,[r2,#0x0]	; 038019AE
loc_038019B0:
	add r3,r3,#0x1	; 038019B0
	lsr r5,r5,#0x1	; 038019B2
loc_038019B4:
	cmp r3,#0x10	; 038019B4
	bge loc_038019BC	; 038019B6
	cmp r5,#0x0	; 038019B8
	bne loc_03801998	; 038019BA
loc_038019BC:
	mov r0,#0x1	; 038019BC
	add r1,r4,#0x0	; 038019BE
	and r1,r0	; 038019C0
	cmp r1,#0x0	; 038019C2
	beq loc_038019E6	; 038019C4
	mov r0,#0x2	; 038019C6
	and r4,r0	; 038019C8
	cmp r4,#0x0	; 038019CA
	beq loc_038019DA	; 038019CC
	ldr r2,[pool_03801A30]	; 038019CE
	ldrh r1,[r2,#0x0]	; 038019D0
	ldr r0,[pool_03801A34]	; 038019D2
	orr r1,r0	; 038019D4
	strh r1,[r2,#0x0]	; 038019D6
	b loc_038019F8	; 038019D8
loc_038019DA:
	ldr r2,[pool_03801A30]	; 038019DA
	ldrb r1,[r2,#0x0]	; 038019DC
	mov r0,#0x80	; 038019DE
	orr r1,r0	; 038019E0
	strb r1,[r2,#0x0]	; 038019E2
	b loc_038019F8	; 038019E4
loc_038019E6:
	mov r0,#0x2	; 038019E6
	and r4,r0	; 038019E8
	cmp r4,#0x0	; 038019EA
	beq loc_038019F8	; 038019EC
	ldr r2,[pool_03801A38]	; 038019EE
	ldrb r1,[r2,#0x0]	; 038019F0
	mov r0,#0x80	; 038019F2
	orr r1,r0	; 038019F4
	strb r1,[r2,#0x0]	; 038019F6
loc_038019F8:
	mov r4,#0x0	; 038019F8
	mov r5,#0x1	; 038019FA
	b loc_03801A10	; 038019FC
loc_038019FE:
	add r0,r6,#0x0	; 038019FE
	and r0,r5	; 03801A00
	cmp r0,#0x0	; 03801A02
	beq loc_03801A0C	; 03801A04
	add r0,r4,#0x0	; 03801A06
	bl loc_038017F0	; 03801A08
loc_03801A0C:
	add r4,r4,#0x1	; 03801A0C
	lsr r6,r6,#0x1	; 03801A0E
loc_03801A10:
	cmp r4,#0x8	; 03801A10
	bge loc_03801A18	; 03801A12
	cmp r6,#0x0	; 03801A14
	bne loc_038019FE	; 03801A16
loc_03801A18:
	add r0,r7,#0x0	; 03801A18
	bl loc_037FDCC0	; 03801A1A
	bl loc_0380170C	; 03801A1E
	add sp,#0x4	; 03801A22
	pop {r4,r5,r6,r7}	; 03801A24
	pop {r3}	; 03801A26
	bx r3	; 03801A28
	.byte 0xC0, 0x46	; 03801A2C
pool_03801A2C:
loc_03801A2C:
	.word 0x04000403	; 03801A2C
pool_03801A30:
loc_03801A30:
	.word REG_SNDCAP0CNT	; 03801A30
pool_03801A34:
loc_03801A34:
	.word 0x00008080	; 03801A34
pool_03801A38:
loc_03801A38:
	.word REG_SNDCAP1CNT	; 03801A38

; ===== function loc_03801A3C =====
loc_03801A3C:
	push {r4,r5,r6,r7,lr}	; 03801A3C
	sub sp,#0x4	; 03801A3E
	add r5,r0,#0x0	; 03801A40
	add r6,r1,#0x0	; 03801A42
	mov r4,#0x0	; 03801A44
	mov r7,#0x1	; 03801A46
	b loc_03801A5E	; 03801A48
loc_03801A4A:
	add r0,r5,#0x0	; 03801A4A
	and r0,r7	; 03801A4C
	cmp r0,#0x0	; 03801A4E
	beq loc_03801A5A	; 03801A50
	add r0,r4,#0x0	; 03801A52
	add r1,r6,#0x0	; 03801A54
	bl loc_037FF534	; 03801A56
loc_03801A5A:
	add r4,r4,#0x1	; 03801A5A
	lsr r5,r5,#0x1	; 03801A5C
loc_03801A5E:
	cmp r4,#0x10	; 03801A5E
	bge loc_03801A66	; 03801A60
	cmp r5,#0x0	; 03801A62
	bne loc_03801A4A	; 03801A64
loc_03801A66:
	add sp,#0x4	; 03801A66
	pop {r4,r5,r6,r7}	; 03801A68
	pop {r3}	; 03801A6A
	bx r3	; 03801A6C
	.byte 0x00, 0x00	; 03801A70

; ===== function loc_03801A70 =====
loc_03801A70:
	push {r4,r5,r6,r7,lr}	; 03801A70
	sub sp,#0x4	; 03801A72
	add r5,r0,#0x0	; 03801A74
	add r6,r1,#0x0	; 03801A76
	add r7,r2,#0x0	; 03801A78
	mov r4,#0x0	; 03801A7A
	b loc_03801A96	; 03801A7C
loc_03801A7E:
	add r1,r5,#0x0	; 03801A7E
	mov r0,#0x1	; 03801A80
	and r1,r0	; 03801A82
	cmp r1,#0x0	; 03801A84
	beq loc_03801A92	; 03801A86
	add r0,r4,#0x0	; 03801A88
	add r1,r6,#0x0	; 03801A8A
	add r2,r7,#0x0	; 03801A8C
	bl loc_037FF58C	; 03801A8E
loc_03801A92:
	add r4,r4,#0x1	; 03801A92
	lsr r5,r5,#0x1	; 03801A94
loc_03801A96:
	cmp r4,#0x10	; 03801A96
	bge loc_03801A9E	; 03801A98
	cmp r5,#0x0	; 03801A9A
	bne loc_03801A7E	; 03801A9C
loc_03801A9E:
	add sp,#0x4	; 03801A9E
	pop {r4,r5,r6,r7}	; 03801AA0
	pop {r3}	; 03801AA2
	bx r3	; 03801AA4
	.byte 0x00, 0x00	; 03801AA8

; ===== function loc_03801AA8 =====
loc_03801AA8:
	push {r4,r5,r6,r7,lr}	; 03801AA8
	sub sp,#0x4	; 03801AAA
	add r5,r0,#0x0	; 03801AAC
	add r6,r1,#0x0	; 03801AAE
	mov r4,#0x0	; 03801AB0
	mov r7,#0x1	; 03801AB2
	b loc_03801ACA	; 03801AB4
loc_03801AB6:
	add r0,r5,#0x0	; 03801AB6
	and r0,r7	; 03801AB8
	cmp r0,#0x0	; 03801ABA
	beq loc_03801AC6	; 03801ABC
	add r0,r4,#0x0	; 03801ABE
	add r1,r6,#0x0	; 03801AC0
	bl loc_037FF578	; 03801AC2
loc_03801AC6:
	add r4,r4,#0x1	; 03801AC6
	lsr r5,r5,#0x1	; 03801AC8
loc_03801ACA:
	cmp r4,#0x10	; 03801ACA
	bge loc_03801AD2	; 03801ACC
	cmp r5,#0x0	; 03801ACE
	bne loc_03801AB6	; 03801AD0
loc_03801AD2:
	add sp,#0x4	; 03801AD2
	pop {r4,r5,r6,r7}	; 03801AD4
	pop {r3}	; 03801AD6
	bx r3	; 03801AD8
	.byte 0x00, 0x00	; 03801ADC

; ===== function loc_03801ADC =====
loc_03801ADC:
	mov r0,#0x7	; 03801ADC
	ldr r1,[pool_03801AE4]	; 03801ADE
	ldr r3,[pool_03801AE8]	; 03801AE0
	bx r3	; 03801AE2
pool_03801AE4:
loc_03801AE4:
	.word 0x03801AED	; 03801AE4
pool_03801AE8:
loc_03801AE8:
	.word P2_SetPxiReceiveCallback + 1	; 03801AE8

; ===== function loc_03801AEC =====
	push {r4,r5,lr}	; 03801AEC
	sub sp,#0x4	; 03801AEE
	add r5,r1,#0x0	; 03801AF0
	bl loc_037FDC9C	; 03801AF2
	add r4,r0,#0x0	; 03801AF6
	ldr r0,[pool_03801B20]	; 03801AF8
	cmp r5,r0	; 03801AFA
	bcc loc_03801B0A	; 03801AFC
	ldr r0,[pool_03801B24]	; 03801AFE
	add r1,r5,#0x0	; 03801B00
	mov r2,#0x0	; 03801B02
	bl loc_037FE2BC	; 03801B04
	b loc_03801B12	; 03801B08
loc_03801B0A:
	cmp r5,#0x0	; 03801B0A
	bne loc_03801B12	; 03801B0C
	bl loc_037FF98C	; 03801B0E
loc_03801B12:
	add r0,r4,#0x0	; 03801B12
	bl loc_037FDCC0	; 03801B14
	add sp,#0x4	; 03801B18
	pop {r4,r5}	; 03801B1A
	pop {r3}	; 03801B1C
	bx r3	; 03801B1E
pool_03801B20:
loc_03801B20:
	.word 0x02000000	; 03801B20
pool_03801B24:
loc_03801B24:
	.word 0x03807054	; 03801B24

; ===== function loc_03801B28 =====
P2_Entry_03801B28:
	push {r4,r5,r6,r7,lr}	; 03801B28
	sub sp,#0x34	; 03801B2A
	mov r4,#0x7f	; 03801B2C
	mov r7,#0x3	; 03801B2E
	mov r6,#0x1	; 03801B30
	b loc_03801D9C	; 03801B32
loc_03801B34:
	ldr r5,[sp,#0x18]	; 03801B34
	b loc_03801D8C	; 03801B36
loc_03801B38:
	add r3,sp,#0x1c	; 03801B38
	mov r2,#0x3	; 03801B3A
loc_03801B3C:
	ldmia r5!,{r0,r1}	; 03801B3C
	stmia r3!,{r0,r1}	; 03801B3E
	sub r2,r2,#0x1	; 03801B40
	cmp r2,#0x0	; 03801B42
	bne loc_03801B3C	; 03801B44
	ldr r0,[sp,#0x20]	; 03801B46
	cmp r0,#0x1d	; 03801B48
	bls loc_03801B4E	; 03801B4A
	b loc_03801D8A	; 03801B4C
loc_03801B4E:
	add r0,r0,r0	; 03801B4E
P2_SwitchIndexPC_03801B4E:
	add r0,pc	; 03801B50
	ldrh r0,[r0,#(P2_SwitchTable_03801B4E - (P2_SwitchIndexPC_03801B4E + 4))]	; 03801B52
	lsl r0,r0,#0x10	; 03801B54
	asr r0,r0,#0x10	; 03801B56
P2_SwitchTargetPC_03801B4E:
	add r0,pc	; 03801B58
	bx r0	; 03801B5A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801B4E:
	.halfword (loc_03801B98 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BA6 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BAE + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BB8 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BC6 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BE0 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BEC + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801BF8 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C08 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C16 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C24 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C8E + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801CDA + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801CFC + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C32 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C58 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C6E + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C78 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801C84 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D1E + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D26 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D2E + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D3C + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D46 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D50 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D78 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D80 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D5A + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D64 + 1) - (P2_SwitchTargetPC_03801B4E + 4)
	.halfword (loc_03801D6E + 1) - (P2_SwitchTargetPC_03801B4E + 4)
P2_SwitchTable_03801B4EEnd:
loc_03801B98:
	ldr r0,[sp,#0x24]	; 03801B98
	ldr r1,[sp,#0x28]	; 03801B9A
	ldr r2,[sp,#0x2c]	; 03801B9C
	ldr r3,[sp,#0x30]	; 03801B9E
	bl loc_038013EC	; 03801BA0
	b loc_03801D8A	; 03801BA4
loc_03801BA6:
	ldr r0,[sp,#0x24]	; 03801BA6
	bl loc_038013B0	; 03801BA8
	b loc_03801D8A	; 03801BAC
loc_03801BAE:
	ldr r0,[sp,#0x24]	; 03801BAE
	ldr r1,[sp,#0x28]	; 03801BB0
	bl loc_03801378	; 03801BB2
	b loc_03801D8A	; 03801BB6
loc_03801BB8:
	ldr r0,[sp,#0x24]	; 03801BB8
	ldr r1,[sp,#0x28]	; 03801BBA
	ldr r2,[sp,#0x2c]	; 03801BBC
	ldr r3,[sp,#0x30]	; 03801BBE
	bl loc_038011FC	; 03801BC0
	b loc_03801D8A	; 03801BC4
loc_03801BC6:
	ldr r0,[sp,#0x24]	; 03801BC6
	lsr r2,r0,#0x18	; 03801BC8
	mov r1,#0xff	; 03801BCA
	and r2,r1	; 03801BCC
	str r2,[sp,#0x0]	; 03801BCE
	ldr r1,[pool_03801DB4]	; 03801BD0
	and r0,r1	; 03801BD2
	ldr r1,[sp,#0x28]	; 03801BD4
	ldr r2,[sp,#0x2c]	; 03801BD6
	ldr r3,[sp,#0x30]	; 03801BD8
	bl loc_038011A0	; 03801BDA
	b loc_03801D8A	; 03801BDE
loc_03801BE0:
	ldr r0,[sp,#0x24]	; 03801BE0
	ldr r1,[sp,#0x28]	; 03801BE2
	ldr r2,[sp,#0x2c]	; 03801BE4
	bl loc_03801310	; 03801BE6
	b loc_03801D8A	; 03801BEA
loc_03801BEC:
	ldr r0,[sp,#0x24]	; 03801BEC
	ldr r1,[sp,#0x28]	; 03801BEE
	ldr r2,[sp,#0x2c]	; 03801BF0
	bl loc_038012C0	; 03801BF2
	b loc_03801D8A	; 03801BF6
loc_03801BF8:
	ldr r0,[sp,#0x24]	; 03801BF8
	ldr r1,[sp,#0x28]	; 03801BFA
	ldr r2,[sp,#0x2c]	; 03801BFC
	lsl r2,r2,#0x10	; 03801BFE
	asr r2,r2,#0x10	; 03801C00
	bl loc_0380178C	; 03801C02
	b loc_03801D8A	; 03801C06
loc_03801C08:
	ldr r0,[sp,#0x24]	; 03801C08
	ldr r1,[sp,#0x28]	; 03801C0A
	lsl r1,r1,#0x10	; 03801C0C
	asr r1,r1,#0x10	; 03801C0E
	bl loc_03801774	; 03801C10
	b loc_03801D8A	; 03801C14
loc_03801C16:
	ldr r0,[sp,#0x24]	; 03801C16
	ldr r1,[sp,#0x28]	; 03801C18
	ldr r2,[sp,#0x2c]	; 03801C1A
	ldr r3,[sp,#0x30]	; 03801C1C
	bl loc_03801984	; 03801C1E
	b loc_03801D8A	; 03801C22
loc_03801C24:
	ldr r0,[sp,#0x24]	; 03801C24
	ldr r1,[sp,#0x28]	; 03801C26
	ldr r2,[sp,#0x2c]	; 03801C28
	ldr r3,[sp,#0x30]	; 03801C2A
	bl loc_038018F8	; 03801C2C
	b loc_03801D8A	; 03801C30
loc_03801C32:
	ldr r1,[sp,#0x2c]	; 03801C32
	lsr r0,r1,#0x1d	; 03801C34
	and r0,r6	; 03801C36
	str r0,[sp,#0x0]	; 03801C38
	lsr r0,r1,#0x1c	; 03801C3A
	and r0,r6	; 03801C3C
	str r0,[sp,#0x4]	; 03801C3E
	lsr r0,r1,#0x1b	; 03801C40
	and r0,r6	; 03801C42
	str r0,[sp,#0x8]	; 03801C44
	lsr r0,r1,#0x1f	; 03801C46
	and r0,r6	; 03801C48
	lsr r1,r1,#0x1e	; 03801C4A
	and r1,r6	; 03801C4C
	ldr r2,[sp,#0x24]	; 03801C4E
	ldr r3,[sp,#0x28]	; 03801C50
	bl loc_037FFA84	; 03801C52
	b loc_03801D8A	; 03801C56
loc_03801C58:
	ldr r0,[sp,#0x30]	; 03801C58
	str r0,[sp,#0x4]	; 03801C5A
	ldr r3,[sp,#0x2c]	; 03801C5C
	mov r0,#0x0	; 03801C5E
	str r0,[sp,#0x0]	; 03801C60
	ldr r0,[sp,#0x24]	; 03801C62
	ldr r1,[sp,#0x28]	; 03801C64
	mov r2,#0x0	; 03801C66
	bl loc_03801884	; 03801C68
	b loc_03801D8A	; 03801C6C
loc_03801C6E:
	ldr r0,[sp,#0x24]	; 03801C6E
	ldr r1,[sp,#0x28]	; 03801C70
	bl loc_03801AA8	; 03801C72
	b loc_03801D8A	; 03801C76
loc_03801C78:
	ldr r0,[sp,#0x24]	; 03801C78
	ldr r1,[sp,#0x28]	; 03801C7A
	ldr r2,[sp,#0x2c]	; 03801C7C
	bl loc_03801A70	; 03801C7E
	b loc_03801D8A	; 03801C82
loc_03801C84:
	ldr r0,[sp,#0x24]	; 03801C84
	ldr r1,[sp,#0x28]	; 03801C86
	bl loc_03801A3C	; 03801C88
	b loc_03801D8A	; 03801C8C
loc_03801C8E:
	ldr r3,[sp,#0x30]	; 03801C8E
	ldr r2,[sp,#0x24]	; 03801C90
	ldr r1,[sp,#0x2c]	; 03801C92
	add r5,r3,#0x0	; 03801C94
	ldr r0,[pool_03801DB8]	; 03801C96
	and r5,r0	; 03801C98
	str r5,[sp,#0x0]	; 03801C9A
	add r5,r1,#0x0	; 03801C9C
	ldr r0,[pool_03801DBC]	; 03801C9E
	and r5,r0	; 03801CA0
	str r5,[sp,#0x4]	; 03801CA2
	lsr r0,r1,#0x18	; 03801CA4
	and r0,r4	; 03801CA6
	str r0,[sp,#0x8]	; 03801CA8
	lsr r0,r1,#0x16	; 03801CAA
	and r0,r7	; 03801CAC
	str r0,[sp,#0xc]	; 03801CAE
	lsr r1,r2,#0x10	; 03801CB0
	ldr r0,[pool_03801DB8]	; 03801CB2
	and r1,r0	; 03801CB4
	str r1,[sp,#0x10]	; 03801CB6
	lsr r0,r3,#0x10	; 03801CB8
	and r0,r4	; 03801CBA
	str r0,[sp,#0x14]	; 03801CBC
	ldr r0,[pool_03801DB8]	; 03801CBE
	and r2,r0	; 03801CC0
	add r0,r2,#0x0	; 03801CC2
	ldr r2,[sp,#0x28]	; 03801CC4
	ldr r1,[pool_03801DC0]	; 03801CC6
	and r2,r1	; 03801CC8
	add r1,r2,#0x0	; 03801CCA
	lsr r2,r3,#0x18	; 03801CCC
	and r2,r7	; 03801CCE
	lsr r3,r3,#0x1a	; 03801CD0
	and r3,r7	; 03801CD2
	bl loc_037FF6E0	; 03801CD4
	b loc_03801D8A	; 03801CD8
loc_03801CDA:
	ldr r2,[sp,#0x2c]	; 03801CDA
	ldr r3,[sp,#0x28]	; 03801CDC
	lsr r1,r2,#0x8	; 03801CDE
	ldr r0,[pool_03801DB8]	; 03801CE0
	and r1,r0	; 03801CE2
	str r1,[sp,#0x0]	; 03801CE4
	and r2,r4	; 03801CE6
	str r2,[sp,#0x4]	; 03801CE8
	ldr r0,[sp,#0x24]	; 03801CEA
	ldr r1,[sp,#0x30]	; 03801CEC
	add r2,r3,#0x0	; 03801CEE
	and r2,r4	; 03801CF0
	lsr r3,r3,#0x8	; 03801CF2
	and r3,r7	; 03801CF4
	bl loc_037FF674	; 03801CF6
	b loc_03801D8A	; 03801CFA
loc_03801CFC:
	ldr r3,[sp,#0x2c]	; 03801CFC
	ldr r2,[sp,#0x28]	; 03801CFE
	add r0,r3,#0x0	; 03801D00
	and r0,r4	; 03801D02
	str r0,[sp,#0x0]	; 03801D04
	ldr r0,[sp,#0x24]	; 03801D06
	add r1,r2,#0x0	; 03801D08
	and r1,r4	; 03801D0A
	lsr r2,r2,#0x8	; 03801D0C
	and r2,r7	; 03801D0E
	lsr r5,r3,#0x8	; 03801D10
	ldr r3,[pool_03801DB8]	; 03801D12
	and r5,r3	; 03801D14
	add r3,r5,#0x0	; 03801D16
	bl loc_037FF60C	; 03801D18
	b loc_03801D8A	; 03801D1C
loc_03801D1E:
	ldr r0,[sp,#0x24]	; 03801D1E
	bl loc_037FF4CC	; 03801D20
	b loc_03801D8A	; 03801D24
loc_03801D26:
	ldr r0,[sp,#0x24]	; 03801D26
	bl loc_037FF3F4	; 03801D28
	b loc_03801D8A	; 03801D2C
loc_03801D2E:
	ldr r0,[sp,#0x24]	; 03801D2E
	ldr r1,[sp,#0x28]	; 03801D30
	ldr r2,[sp,#0x2c]	; 03801D32
	ldr r3,[sp,#0x30]	; 03801D34
	bl loc_037FF3C0	; 03801D36
	b loc_03801D8A	; 03801D3A
loc_03801D3C:
	ldr r0,[sp,#0x24]	; 03801D3C
	ldr r1,[sp,#0x28]	; 03801D3E
	bl loc_037FFE2C	; 03801D40
	b loc_03801D8A	; 03801D44
loc_03801D46:
	ldr r0,[sp,#0x24]	; 03801D46
	ldr r1,[sp,#0x28]	; 03801D48
	bl loc_037FFE08	; 03801D4A
	b loc_03801D8A	; 03801D4E
loc_03801D50:
	ldr r0,[sp,#0x24]	; 03801D50
	ldr r1,[sp,#0x28]	; 03801D52
	bl loc_037FFED8	; 03801D54
	b loc_03801D8A	; 03801D58
loc_03801D5A:
	ldr r0,[sp,#0x24]	; 03801D5A
	ldr r1,[sp,#0x28]	; 03801D5C
	bl loc_03801268	; 03801D5E
	b loc_03801D8A	; 03801D62
loc_03801D64:
	ldr r0,[sp,#0x24]	; 03801D64
	ldr r1,[sp,#0x28]	; 03801D66
	bl loc_0380122C	; 03801D68
	b loc_03801D8A	; 03801D6C
loc_03801D6E:
	ldr r0,[sp,#0x24]	; 03801D6E
	ldr r1,[sp,#0x28]	; 03801D70
	bl loc_037FFDB8	; 03801D72
	b loc_03801D8A	; 03801D76
loc_03801D78:
	ldr r1,[sp,#0x24]	; 03801D78
	ldr r0,[pool_03801DC4]	; 03801D7A
	str r1,[r0,#0x0]	; 03801D7C
	b loc_03801D8A	; 03801D7E
loc_03801D80:
	ldr r0,[pool_03801DC8]	; 03801D80
	ldr r1,[sp,#0x24]	; 03801D82
	ldr r2,[pool_03801DCC]	; 03801D84
	bl loc_03801DD4	; 03801D86
loc_03801D8A:
	ldr r5,[sp,#0x1c]	; 03801D8A
loc_03801D8C:
	cmp r5,#0x0	; 03801D8C
	beq loc_03801D92	; 03801D8E
	b loc_03801B38	; 03801D90
loc_03801D92:
	ldr r0,[pool_03801DC4]	; 03801D92
	ldr r1,[r0,#0x0]	; 03801D94
	ldr r0,[r1,#0x0]	; 03801D96
	add r0,r0,#0x1	; 03801D98
	str r0,[r1,#0x0]	; 03801D9A
loc_03801D9C:
	ldr r0,[pool_03801DD0]	; 03801D9C
	add r1,sp,#0x18	; 03801D9E
	mov r2,#0x0	; 03801DA0
	bl loc_037FE244	; 03801DA2
	cmp r0,#0x0	; 03801DA6
	beq loc_03801DAC	; 03801DA8
	b loc_03801B34	; 03801DAA
loc_03801DAC:
	add sp,#0x34	; 03801DAC
	pop {r4,r5,r6,r7}	; 03801DAE
	pop {r3}	; 03801DB0
	bx r3	; 03801DB2
pool_03801DB4:
loc_03801DB4:
	.word 0x00FFFFFF	; 03801DB4
pool_03801DB8:
loc_03801DB8:
	.word 0x0000FFFF	; 03801DB8
pool_03801DBC:
loc_03801DBC:
	.word 0x003FFFFF	; 03801DBC
pool_03801DC0:
loc_03801DC0:
	.word 0x07FFFFFF	; 03801DC0
pool_03801DC4:
loc_03801DC4:
	.word P2_BssStart + 0xB7C	; 03801DC4
pool_03801DC8:
loc_03801DC8:
	.word 0x03805ED4	; 03801DC8
pool_03801DCC:
loc_03801DCC:
	.word 0x00001180	; 03801DCC
pool_03801DD0:
loc_03801DD0:
	.word 0x03807054	; 03801DD0

; ===== function loc_03801DD4 =====
loc_03801DD4:
	bx pc	; 03801DD4
	.byte 0xC0, 0x46	; 03801DD8
.arm

; ===== function loc_03801DD8 =====
loc_03801DD8:
	ldr pc,[pool_03801DDC]	; 03801DD8
pool_03801DDC:
loc_03801DDC:
	.word loc_037FF320	; 03801DDC
.thumb

; ===== function loc_03801DE0 =====
loc_03801DE0:
	push {lr}	; 03801DE0
	sub sp,#0x4	; 03801DE2
	ldr r0,[pool_03801E00]	; 03801DE4
	ldr r1,[pool_03801E04]	; 03801DE6
	mov r2,#0x8	; 03801DE8
	bl loc_037FE318	; 03801DEA
	bl loc_03801ADC	; 03801DEE
	mov r1,#0x0	; 03801DF2
	ldr r0,[pool_03801E08]	; 03801DF4
	str r1,[r0,#0x0]	; 03801DF6
	add sp,#0x4	; 03801DF8
	pop {r3}	; 03801DFA
	bx r3	; 03801DFC
	.byte 0xC0, 0x46	; 03801E00
pool_03801E00:
loc_03801E00:
	.word 0x03807054	; 03801E00
pool_03801E04:
loc_03801E04:
	.word 0x03807068	; 03801E04
pool_03801E08:
loc_03801E08:
	.word P2_BssStart + 0xB7C	; 03801E08

; ===== function loc_03801E0C =====
loc_03801E0C:
	ldr r3,[pool_03801E10]	; 03801E0C
	bx r3	; 03801E0E
pool_03801E10:
loc_03801E10:
	.word loc_03801FC4 + 1	; 03801E10

; ===== function loc_03801E14 =====
P2_IrqHandler_03801E14:
	push {r4,r5,r6,r7,lr}	; 03801E14
	sub sp,#0x4	; 03801E16
	ldr r5,[pool_03801ED0]	; 03801E18
	mov r0,#0x3	; 03801E1A
	mvn r6,r0	; 03801E1C
	mov r7,#0x2	; 03801E1E
	mvn r4,r7	; 03801E20
loc_03801E22:
	ldrh r1,[r5,#0x0]	; 03801E22
	ldr r0,[pool_03801ED4]	; 03801E24
	and r1,r0	; 03801E26
	cmp r1,#0x0	; 03801E28
	beq loc_03801E38	; 03801E2A
	ldrh r1,[r5,#0x0]	; 03801E2C
	ldr r0,[pool_03801ED8]	; 03801E2E
	orr r1,r0	; 03801E30
	strh r1,[r5,#0x0]	; 03801E32
	add r0,r4,#0x0	; 03801E34
	b loc_03801E5A	; 03801E36
loc_03801E38:
	bl loc_037FDC9C	; 03801E38
	ldrh r2,[r5,#0x0]	; 03801E3C
	ldr r1,[pool_03801EDC]	; 03801E3E
	and r2,r1	; 03801E40
	cmp r2,#0x0	; 03801E42
	beq loc_03801E4E	; 03801E44
	bl loc_037FDCC0	; 03801E46
	add r0,r6,#0x0	; 03801E4A
	b loc_03801E5A	; 03801E4C
loc_03801E4E:
	ldr r1,[pool_03801EE0]	; 03801E4E
	ldr r1,[r1,#0x0]	; 03801E50
	str r1,[sp,#0x0]	; 03801E52
	bl loc_037FDCC0	; 03801E54
	mov r0,#0x0	; 03801E58
loc_03801E5A:
	mov r1,#0x3	; 03801E5A
	mvn r1,r1	; 03801E5C
	cmp r0,r1	; 03801E5E
	beq loc_03801EC8	; 03801E60
	mvn r1,r7	; 03801E62
	cmp r0,r1	; 03801E64
	beq loc_03801E22	; 03801E66
	ldr r2,[sp,#0x0]	; 03801E68
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 03801E6A
	lsr r0,r0,#0x1b	; 03801E6C
	cmp r0,#0x0	; 03801E6E
	beq loc_03801E22	; 03801E70
	lsl r3,r0,#0x2	; 03801E72
	ldr r1,[pool_03801EE4]	; 03801E74
	ldr r3,[r1,r3]	; 03801E76
	cmp r3,#0x0	; 03801E78
	beq loc_03801E88	; 03801E7A
	lsr r1,r2,#0x6	; 03801E7C
	lsl r2,r2,#0x1a	; 03801E7E
	lsr r2,r2,#0x1f	; 03801E80
	bl loc_0380504C	; 03801E82
	b loc_03801E22	; 03801E86
loc_03801E88:
	lsl r0,r2,#0x1a	; 03801E88
	lsr r0,r0,#0x1f	; 03801E8A
	cmp r0,#0x0	; 03801E8C
	bne loc_03801E22	; 03801E8E
	mov r0,#0x20	; 03801E90
	orr r2,r0	; 03801E92
	str r2,[sp,#0x0]	; 03801E94
	ldrh r1,[r5,#0x0]	; 03801E96
	ldr r0,[pool_03801ED4]	; 03801E98
	and r1,r0	; 03801E9A
	cmp r1,#0x0	; 03801E9C
	beq loc_03801EAA	; 03801E9E
	ldrh r1,[r5,#0x0]	; 03801EA0
	ldr r0,[pool_03801ED8]	; 03801EA2
	orr r1,r0	; 03801EA4
	strh r1,[r5,#0x0]	; 03801EA6
	b loc_03801E22	; 03801EA8
loc_03801EAA:
	bl loc_037FDC9C	; 03801EAA
	ldrh r1,[r5,#0x0]	; 03801EAE
	and r1,r7	; 03801EB0
	cmp r1,#0x0	; 03801EB2
	beq loc_03801EBC	; 03801EB4
	bl loc_037FDCC0	; 03801EB6
	b loc_03801E22	; 03801EBA
loc_03801EBC:
	ldr r2,[sp,#0x0]	; 03801EBC
	ldr r1,[pool_03801EE8]	; 03801EBE
	str r2,[r1,#0x0]	; 03801EC0
	bl loc_037FDCC0	; 03801EC2
	b loc_03801E22	; 03801EC6
loc_03801EC8:
	add sp,#0x4	; 03801EC8
	pop {r4,r5,r6,r7}	; 03801ECA
	pop {r3}	; 03801ECC
	bx r3	; 03801ECE
pool_03801ED0:
loc_03801ED0:
	.word REG_IPC_FIFO_CR	; 03801ED0
pool_03801ED4:
loc_03801ED4:
	.word 0x00004000	; 03801ED4
pool_03801ED8:
loc_03801ED8:
	.word 0x0000C000	; 03801ED8
pool_03801EDC:
loc_03801EDC:
	.word 0x00000100	; 03801EDC
pool_03801EE0:
loc_03801EE0:
	.word REG_IPC_FIFO_RX	; 03801EE0
pool_03801EE4:
loc_03801EE4:
	.word P2_PxiReceiveCallbacks	; 03801EE4
pool_03801EE8:
loc_03801EE8:
	.word REG_IPC_FIFO_TX	; 03801EE8

; ===== function loc_03801EEC =====
loc_03801EEC:
	push {r4,lr}	; 03801EEC
	sub sp,#0x8	; 03801EEE
	ldr r3,[sp,#0x0]	; 03801EF0
	mov r4,#0x1f	; 03801EF2
	bic r3,r4	; 03801EF4
	and r0,r4	; 03801EF6
	orr r3,r0	; 03801EF8
	str r3,[sp,#0x0]	; 03801EFA
	mov r0,#0x20	; 03801EFC
	bic r3,r0	; 03801EFE
	mov r0,#0x1	; 03801F00
	and r2,r0	; 03801F02
	lsl r0,r2,#0x5	; 03801F04
	orr r3,r0	; 03801F06
	str r3,[sp,#0x0]	; 03801F08
	mov r0,#0x3f	; 03801F0A
	and r3,r0	; 03801F0C
	ldr r0,[pool_03801F60]	; 03801F0E
	and r1,r0	; 03801F10
	lsl r0,r1,#0x6	; 03801F12
	orr r3,r0	; 03801F14
	str r3,[sp,#0x0]	; 03801F16
	ldr r2,[pool_03801F64]	; 03801F18
	ldrh r1,[r2,#0x0]	; 03801F1A
	ldr r0,[pool_03801F68]	; 03801F1C
	and r1,r0	; 03801F1E
	cmp r1,#0x0	; 03801F20
	beq loc_03801F32	; 03801F22
	ldrh r1,[r2,#0x0]	; 03801F24
	ldr r0,[pool_03801F6C]	; 03801F26
	orr r1,r0	; 03801F28
	strh r1,[r2,#0x0]	; 03801F2A
	mov r0,#0x0	; 03801F2C
	mvn r0,r0	; 03801F2E
	b loc_03801F58	; 03801F30
loc_03801F32:
	bl loc_037FDC9C	; 03801F32
	ldr r1,[pool_03801F64]	; 03801F36
	ldrh r2,[r1,#0x0]	; 03801F38
	mov r1,#0x2	; 03801F3A
	and r2,r1	; 03801F3C
	cmp r2,#0x0	; 03801F3E
	beq loc_03801F4C	; 03801F40
	bl loc_037FDCC0	; 03801F42
	mov r0,#0x1	; 03801F46
	mvn r0,r0	; 03801F48
	b loc_03801F58	; 03801F4A
loc_03801F4C:
	ldr r2,[sp,#0x0]	; 03801F4C
	ldr r1,[pool_03801F70]	; 03801F4E
	str r2,[r1,#0x0]	; 03801F50
	bl loc_037FDCC0	; 03801F52
	mov r0,#0x0	; 03801F56
loc_03801F58:
	add sp,#0x8	; 03801F58
	pop {r4}	; 03801F5A
	pop {r3}	; 03801F5C
	bx r3	; 03801F5E
pool_03801F60:
loc_03801F60:
	.word 0x03FFFFFF	; 03801F60
pool_03801F64:
loc_03801F64:
	.word REG_IPC_FIFO_CR	; 03801F64
pool_03801F68:
loc_03801F68:
	.word 0x00004000	; 03801F68
pool_03801F6C:
loc_03801F6C:
	.word 0x0000C000	; 03801F6C
pool_03801F70:
loc_03801F70:
	.word REG_IPC_FIFO_TX	; 03801F70

; ===== function loc_03801F74 =====
loc_03801F74:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P2_SetPxiReceiveCallback
	push {r4,r5,lr}	; 03801F74
	sub sp,#0x4	; 03801F76
	add r5,r0,#0x0	; 03801F78
	add r4,r1,#0x0	; 03801F7A
	bl loc_037FDC9C	; 03801F7C
	lsl r2,r5,#0x2	; 03801F80
	ldr r1,[pool_03801FB8]	; 03801F82
	str r4,[r1,r2]	; 03801F84
	cmp r4,#0x0	; 03801F86
	beq loc_03801F9C	; 03801F88
	ldr r2,[pool_03801FBC]	; 03801F8A
	ldr r1,[pool_03801FC0]	; 03801F8C
	add r1,r2,r1	; 03801F8E
	ldr r3,[r1,#0x0]	; 03801F90
	mov r2,#0x1	; 03801F92
	lsl r2,r5	; 03801F94
	orr r3,r2	; 03801F96
	str r3,[r1,#0x0]	; 03801F98
	b loc_03801FAC	; 03801F9A
loc_03801F9C:
	ldr r2,[pool_03801FBC]	; 03801F9C
	ldr r1,[pool_03801FC0]	; 03801F9E
	add r1,r2,r1	; 03801FA0
	ldr r3,[r1,#0x0]	; 03801FA2
	mov r2,#0x1	; 03801FA4
	lsl r2,r5	; 03801FA6
	bic r3,r2	; 03801FA8
	str r3,[r1,#0x0]	; 03801FAA
loc_03801FAC:
	bl loc_037FDCC0	; 03801FAC
	add sp,#0x4	; 03801FB0
	pop {r4,r5}	; 03801FB2
	pop {r3}	; 03801FB4
	bx r3	; 03801FB6
.endfunc
pool_03801FB8:
loc_03801FB8:
	.word P2_PxiReceiveCallbacks	; 03801FB8
pool_03801FBC:
loc_03801FBC:
	.word FirmwareSystemWorkAddress	; 03801FBC
pool_03801FC0:
loc_03801FC0:
	.word SystemWorkPxiArm7AvailableOffset	; 03801FC0

; ===== function loc_03801FC4 =====
loc_03801FC4:
	push {r4,r5,r6,r7,lr}	; 03801FC4
	sub sp,#0x4	; 03801FC6
	bl loc_037FDC9C	; 03801FC8
	add r5,r0,#0x0	; 03801FCC
	ldr r0,[pool_03802038]	; 03801FCE
	ldrh r1,[r0,#0x0]	; 03801FD0
	cmp r1,#0x0	; 03801FD2
	bne loc_03802028	; 03801FD4
	mov r1,#0x1	; 03801FD6
	strh r1,[r0,#0x0]	; 03801FD8
	mov r3,#0x0	; 03801FDA
	ldr r1,[pool_0380203C]	; 03801FDC
	ldr r0,[pool_03802040]	; 03801FDE
	str r3,[r1,r0]	; 03801FE0
	add r2,r3,#0x0	; 03801FE2
	ldr r0,[pool_03802044]	; 03801FE4
loc_03801FE6:
	lsl r1,r3,#0x2	; 03801FE6
	str r2,[r0,r1]	; 03801FE8
	add r3,r3,#0x1	; 03801FEA
	cmp r3,#PxiFifoChannelCount	; 03801FEC
	blt loc_03801FE6	; 03801FEE
	ldr r0,[pool_03802048]	; 03801FF0
	ldr r1,[pool_0380204C]	; 03801FF2
	bl loc_037FDAD0	; 03801FF4
	ldr r0,[pool_03802048]	; 03801FF8
	bl loc_037FDA4C	; 03801FFA
	ldr r1,[pool_03802050]	; 03801FFE
	ldr r0,[pool_03802054]	; 03802000
	strh r1,[r0,#0x0]	; 03802002
	mov r4,#0x8	; 03802004
	add r7,r4,#0x0	; 03802006
	ldr r6,[pool_03802058]	; 03802008
	b loc_03802024	; 0380200A
loc_0380200C:
	lsl r0,r4,#0x8	; 0380200C
	strh r0,[r6,#0x0]	; 0380200E
	ldr r0,[pool_0380205C]	; 03802010
	bl loc_037FF184	; 03802012
	ldrh r1,[r6,#0x0]	; 03802016
	mov r0,#0xf	; 03802018
	and r1,r0	; 0380201A
	cmp r1,r4	; 0380201C
	beq loc_03802022	; 0380201E
	add r4,r7,#0x0	; 03802020
loc_03802022:
	sub r4,r4,#0x1	; 03802022
loc_03802024:
	cmp r4,#0x0	; 03802024
	bge loc_0380200C	; 03802026
loc_03802028:
	add r0,r5,#0x0	; 03802028
	bl loc_037FDCC0	; 0380202A
	add sp,#0x4	; 0380202E
	pop {r4,r5,r6,r7}	; 03802030
	pop {r3}	; 03802032
	bx r3	; 03802034
	.byte 0xC0, 0x46	; 03802038
pool_03802038:
loc_03802038:
	.word P2_BssStart + 0x1D34	; 03802038
pool_0380203C:
loc_0380203C:
	.word FirmwareSystemWorkAddress	; 0380203C
pool_03802040:
loc_03802040:
	.word SystemWorkPxiArm7AvailableOffset	; 03802040
pool_03802044:
loc_03802044:
	.word P2_PxiReceiveCallbacks	; 03802044
pool_03802048:
loc_03802048:
	.word 0x00040000	; 03802048
pool_0380204C:
loc_0380204C:
	.word P2_IrqHandler_03801E14 + 1	; 0380204C
pool_03802050:
loc_03802050:
	.word 0x0000C408	; 03802050
pool_03802054:
loc_03802054:
	.word REG_IPC_FIFO_CR	; 03802054
pool_03802058:
loc_03802058:
	.word REG_IPC_SYNC	; 03802058
pool_0380205C:
loc_0380205C:
	.word 0x000003E8	; 0380205C
	push {r4,lr}	; 03802060
	mov r4,#0x0	; 03802062
	ldr r0,[pool_0380208C]	; 03802064
	bl loc_03802100	; 03802066
	ldr r0,[pool_03802090]	; 0380206A
	ldrh r2,[r0,#0x0]	; 0380206C
	mov r0,#0x80	; 0380206E
	add r1,r2,#0x0	; 03802070
	and r1,r0	; 03802072
	cmp r1,#0x0	; 03802074
	beq loc_0380207A	; 03802076
	ldr r4,[pool_0380208C]	; 03802078
loc_0380207A:
	mov r0,#0xb	; 0380207A
	and r2,r0	; 0380207C
	lsl r1,r2,#0xa	; 0380207E
	orr r1,r4	; 03802080
	ldr r0,[pool_03802094]	; 03802082
	strh r1,[r0,#0x0]	; 03802084
	pop {r4}	; 03802086
	pop {r3}	; 03802088
	bx r3	; 0380208A
pool_0380208C:
loc_0380208C:
	.word 0x00008000	; 0380208C
pool_03802090:
loc_03802090:
	.word REG_KEYXY	; 03802090
pool_03802094:
loc_03802094:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 03802094

; ===== function loc_03802098 =====
loc_03802098:
	push {r4,r5,lr}	; 03802098
	sub sp,#0xc	; 0380209A
	bl loc_037FE8F0	; 0380209C
	cmp r0,#0x0	; 038020A0
	beq loc_038020AC	; 038020A2
	bl loc_037FEBF8	; 038020A4
	cmp r0,#0x0	; 038020A8
	bne loc_038020B0	; 038020AA
loc_038020AC:
	mov r0,#0x0	; 038020AC
	b loc_038020E8	; 038020AE
loc_038020B0:
	ldr r0,[pool_038020F0]	; 038020B0
	ldr r0,[r0,#0x0]	; 038020B2
	cmp r0,#0x0	; 038020B4
	beq loc_038020BC	; 038020B6
	mov r0,#0x0	; 038020B8
	b loc_038020E8	; 038020BA
loc_038020BC:
	ldr r0,[pool_038020F4]	; 038020BC
	bl loc_037FEBF0	; 038020BE
	bl loc_037FE824	; 038020C2
	add r2,r0,#0x0	; 038020C6
	ldr r0,[pool_038020F8]	; 038020C8
	str r0,[sp,#0x4]	; 038020CA
	mov r5,#0x0	; 038020CC
	str r5,[sp,#0x8]	; 038020CE
	ldr r3,[pool_038020FC]	; 038020D0
	str r5,[sp,#0x0]	; 038020D2
	ldr r0,[pool_038020F4]	; 038020D4
	add r4,r2,r3	; 038020D6
	lsl r2,r1,#0	; 038020D8
	adc r2,r5	; 038020DA
	add r1,r4,#0x0	; 038020DC
	bl loc_037FEA74	; 038020DE
	mov r0,#0x1	; 038020E2
	ldr r1,[pool_038020F0]	; 038020E4
	str r0,[r1,#0x0]	; 038020E6
loc_038020E8:
	add sp,#0xc	; 038020E8
	pop {r4,r5}	; 038020EA
	pop {r3}	; 038020EC
	bx r3	; 038020EE
pool_038020F0:
loc_038020F0:
	.word P2_BssStart + 0x1DB8	; 038020F0
pool_038020F4:
loc_038020F4:
	.word 0x03807110	; 038020F4
pool_038020F8:
loc_038020F8:
	.word 0x03802061	; 038020F8
pool_038020FC:
loc_038020FC:
	.word 0x0000082E	; 038020FC

; ===== function loc_03802100 =====
loc_03802100:
	add r1,r0,#0x0	; 03802100
	ldr r0,[pool_0380210C]	; 03802102
	lsl r1,r1,#0x10	; 03802104
	lsr r1,r1,#0x10	; 03802106
	ldr r3,[pool_03802110]	; 03802108
	bx r3	; 0380210A
pool_0380210C:
loc_0380210C:
	.word 0x0000C000	; 0380210C
pool_03802110:
loc_03802110:
	.word loc_03802114 + 1	; 03802110
loc_03802114:
	mvn r3,r0	; 03802114
	ldr r2,[pool_03802124]	; 03802116
	ldrh r0,[r2,#0x0]	; 03802118
	and r3,r0	; 0380211A
	orr r1,r3	; 0380211C
	strh r1,[r2,#0x0]	; 0380211E
	bx lr	; 03802120
	.byte 0xC0, 0x46	; 03802124
pool_03802124:
loc_03802124:
	.word REG_RCNT_ARM7	; 03802124

; ===== function loc_03802128 =====
loc_03802128:
	push {lr}	; 03802128
	sub sp,#0x4	; 0380212A
	add r0,sp,#0x0	; 0380212C
	bl loc_038028AC	; 0380212E
	add r0,sp,#0x0	; 03802132
	add r0,#0x2	; 03802134
	bl loc_0380286C	; 03802136
	add r0,sp,#0x0	; 0380213A
	ldrh r1,[r0,#0x0]	; 0380213C
	lsl r2,r1,#0x18	; 0380213E
	lsr r2,r2,#0x1f	; 03802140
	cmp r2,#0x0	; 03802142
	bne loc_03802158	; 03802144
	lsl r1,r1,#0x19	; 03802146
	lsr r1,r1,#0x1f	; 03802148
	cmp r1,#0x0	; 0380214A
	bne loc_03802158	; 0380214C
	ldrh r0,[r0,#0x2]	; 0380214E
	lsl r0,r0,#0x18	; 03802150
	lsr r0,r0,#0x1f	; 03802152
	cmp r0,#0x0	; 03802154
	beq loc_0380216A	; 03802156
loc_03802158:
	add r1,sp,#0x0	; 03802158
	ldrh r2,[r1,#0x0]	; 0380215A
	mov r0,#0x1	; 0380215C
	bic r2,r0	; 0380215E
	orr r2,r0	; 03802160
	strh r2,[r1,#0x0]	; 03802162
	add r0,sp,#0x0	; 03802164
	bl loc_0380288C	; 03802166
loc_0380216A:
	mov r0,#0x1	; 0380216A
	bl loc_038029DC	; 0380216C
	add sp,#0x4	; 03802170
	pop {r3}	; 03802172
	bx r3	; 03802174
	.byte 0x00, 0x00	; 03802178
	ldr r0,[pool_03802180]	; 03802178
	ldr r3,[pool_03802184]	; 0380217A
	bx r3	; 0380217C
	.byte 0xC0, 0x46	; 03802180
pool_03802180:
loc_03802180:
	.word 0x0380735C	; 03802180
pool_03802184:
loc_03802184:
	.word loc_037FDEC0 + 1	; 03802184

; ===== function loc_03802188 =====
P2_ThreadEntry_03802188:
	push {r4,r5,r6,r7,lr}	; 03802188
	sub sp,#0xc	; 0380218A
	add r4,sp,#0x0	; 0380218C
	ldrh r1,[r4,#0x2]	; 0380218E
	mov r0,#0x10	; 03802190
	bic r1,r0	; 03802192
	strh r1,[r4,#0x2]	; 03802194
	ldrh r1,[r4,#0x2]	; 03802196
	mov r0,#0x20	; 03802198
	bic r1,r0	; 0380219A
	strh r1,[r4,#0x2]	; 0380219C
	ldr r6,[pool_0380221C]	; 0380219E
	mov r7,#0xf	; 038021A0
loc_038021A2:
	ldr r0,[pool_03802220]	; 038021A2
	bl loc_037FDF08	; 038021A4
	ldr r0,[r6,#0x1c]	; 038021A8
	cmp r0,#0x0	; 038021AA
	bne loc_038021A2	; 038021AC
	add r0,sp,#0x0	; 038021AE
	bl loc_038028AC	; 038021B0
	ldrh r1,[r4,#0x0]	; 038021B4
	lsl r0,r1,#0x1b	; 038021B6
	lsr r2,r0,#0x1f	; 038021B8
	ldrh r0,[r4,#0x2]	; 038021BA
	lsl r3,r0,#0x1b	; 038021BC
	lsr r3,r3,#0x1f	; 038021BE
	sub r2,r2,r3	; 038021C0
	cmp r2,#0x1	; 038021C2
	beq loc_038021D4	; 038021C4
	lsl r1,r1,#0x1a	; 038021C6
	lsr r1,r1,#0x1f	; 038021C8
	lsl r0,r0,#0x1a	; 038021CA
	lsr r0,r0,#0x1f	; 038021CC
	sub r0,r1,r0	; 038021CE
	cmp r0,#0x1	; 038021D0
	bne loc_03802214	; 038021D2
loc_038021D4:
	add r0,sp,#0x4	; 038021D4
	bl loc_0380286C	; 038021D6
	mov r5,#0x0	; 038021DA
	ldrh r0,[r4,#0x0]	; 038021DC
	lsl r0,r0,#0x1b	; 038021DE
	lsr r0,r0,#0x1f	; 038021E0
	cmp r0,#0x0	; 038021E2
	beq loc_038021F0	; 038021E4
	mov r0,#0x1	; 038021E6
	orr r5,r0	; 038021E8
	ldrh r0,[r4,#0x4]	; 038021EA
	bic r0,r7	; 038021EC
	strh r0,[r4,#0x4]	; 038021EE
loc_038021F0:
	ldrh r0,[r4,#0x0]	; 038021F0
	lsl r0,r0,#0x1a	; 038021F2
	lsr r0,r0,#0x1f	; 038021F4
	cmp r0,#0x0	; 038021F6
	beq loc_03802206	; 038021F8
	mov r0,#0x2	; 038021FA
	orr r5,r0	; 038021FC
	ldrh r1,[r4,#0x4]	; 038021FE
	mov r0,#0x40	; 03802200
	bic r1,r0	; 03802202
	strh r1,[r4,#0x4]	; 03802204
loc_03802206:
	add r0,sp,#0x4	; 03802206
	bl loc_0380284C	; 03802208
	mov r0,#0x30	; 0380220C
	add r1,r5,#0x0	; 0380220E
	bl loc_03802418	; 03802210
loc_03802214:
	ldrh r0,[r4,#0x0]	; 03802214
	strh r0,[r4,#0x2]	; 03802216
	b loc_038021A2	; 03802218
	.byte 0xC0, 0x46	; 0380221C
pool_0380221C:
loc_0380221C:
	.word 0x038072C0	; 0380221C
pool_03802220:
loc_03802220:
	.word 0x0380735C	; 03802220

; ===== function loc_03802224 =====
P2_ThreadEntry_03802224:
	push {r4,r5,r6,r7,lr}	; 03802224
	sub sp,#0x4	; 03802226
	ldr r5,[pool_0380240C]	; 03802228
	add r6,r5,#0x4	; 0380222A
	mov r7,#0x0	; 0380222C
	ldr r4,[pool_03802410]	; 0380222E
loc_03802230:
	ldr r0,[pool_03802414]	; 03802230
	add r1,sp,#0x0	; 03802232
	mov r2,#0x1	; 03802234
	bl loc_037FE244	; 03802236
	ldrh r0,[r4,#0x20]	; 0380223A
	cmp r0,#0x10	; 0380223C
	bgt loc_0380225A	; 0380223E
	cmp r0,#0x10	; 03802240
	bge loc_038022C4	; 03802242
	cmp r0,#0x1	; 03802244
	ble loc_0380224A	; 03802246
	b loc_03802400	; 03802248
loc_0380224A:
	cmp r0,#0x0	; 0380224A
	bge loc_03802250	; 0380224C
	b loc_03802400	; 0380224E
loc_03802250:
	cmp r0,#0x0	; 03802250
	beq loc_0380229E	; 03802252
	cmp r0,#0x1	; 03802254
	beq loc_038022AE	; 03802256
	b loc_03802400	; 03802258
loc_0380225A:
	add r1,r0,#0x0	; 0380225A
	sub r1,#0x14	; 0380225C
	cmp r1,#0x15	; 0380225E
	bls loc_03802264	; 03802260
	b loc_03802400	; 03802262
loc_03802264:
	add r1,r1,r1	; 03802264
P2_SwitchIndexPC_03802264:
	add r1,pc	; 03802266
	ldrh r1,[r1,#(P2_SwitchTable_03802264 - (P2_SwitchIndexPC_03802264 + 4))]	; 03802268
	lsl r1,r1,#0x10	; 0380226A
	asr r1,r1,#0x10	; 0380226C
P2_SwitchTargetPC_03802264:
	add r1,pc	; 0380226E
	bx r1	; 03802270
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802264:
	.halfword (loc_038022D6 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_038022F8 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_0380231A + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_0380232C + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_0380233E + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802350 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802362 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802400 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802374 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_03802396 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_038023B8 + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_038023CA + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_038023DC + 1) - (P2_SwitchTargetPC_03802264 + 4)
	.halfword (loc_038023EE + 1) - (P2_SwitchTargetPC_03802264 + 4)
P2_SwitchTable_03802264End:
loc_0380229E:
	bl loc_03802A84	; 0380229E
	str r7,[r4,#0x1c]	; 038022A2
	add r0,r7,#0x0	; 038022A4
	add r1,r7,#0x0	; 038022A6
	bl loc_03802418	; 038022A8
	b loc_03802230	; 038022AC
loc_038022AE:
	ldrh r0,[r5,#0x0]	; 038022AE
	lsl r0,r0,#0x1e	; 038022B0
	lsr r0,r0,#0x1f	; 038022B2
	bl loc_038029DC	; 038022B4
	str r7,[r4,#0x1c]	; 038022B8
	mov r0,#0x1	; 038022BA
	add r1,r7,#0x0	; 038022BC
	bl loc_03802418	; 038022BE
	b loc_03802230	; 038022C2
loc_038022C4:
	add r0,r5,#0x0	; 038022C4
	bl loc_038029BC	; 038022C6
	str r7,[r4,#0x1c]	; 038022CA
	mov r0,#0x10	; 038022CC
	add r1,r7,#0x0	; 038022CE
	bl loc_03802418	; 038022D0
	b loc_03802230	; 038022D4
loc_038022D6:
	add r0,r5,#0x4	; 038022D6
	bl loc_03802968	; 038022D8
	cmp r0,#0x0	; 038022DC
	bne loc_038022EC	; 038022DE
	str r7,[r4,#0x1c]	; 038022E0
	mov r0,#0x14	; 038022E2
	mov r1,#0x2	; 038022E4
	bl loc_03802418	; 038022E6
	b loc_03802230	; 038022EA
loc_038022EC:
	str r7,[r4,#0x1c]	; 038022EC
	mov r0,#0x14	; 038022EE
	add r1,r7,#0x0	; 038022F0
	bl loc_03802418	; 038022F2
	b loc_03802230	; 038022F6
loc_038022F8:
	add r0,r6,#0x0	; 038022F8
	bl loc_03802900	; 038022FA
	cmp r0,#0x0	; 038022FE
	bne loc_0380230E	; 03802300
	str r7,[r4,#0x1c]	; 03802302
	mov r0,#0x15	; 03802304
	mov r1,#0x2	; 03802306
	bl loc_03802418	; 03802308
	b loc_03802230	; 0380230C
loc_0380230E:
	str r7,[r4,#0x1c]	; 0380230E
	mov r0,#0x15	; 03802310
	add r1,r7,#0x0	; 03802312
	bl loc_03802418	; 03802314
	b loc_03802230	; 03802318
loc_0380231A:
	add r0,r5,#0x0	; 0380231A
	bl loc_038028AC	; 0380231C
	str r7,[r4,#0x1c]	; 03802320
	mov r0,#0x16	; 03802322
	add r1,r7,#0x0	; 03802324
	bl loc_03802418	; 03802326
	b loc_03802230	; 0380232A
loc_0380232C:
	add r0,r5,#0x2	; 0380232C
	bl loc_0380286C	; 0380232E
	str r7,[r4,#0x1c]	; 03802332
	mov r0,#0x17	; 03802334
	add r1,r7,#0x0	; 03802336
	bl loc_03802418	; 03802338
	b loc_03802230	; 0380233C
loc_0380233E:
	add r0,r5,#0x4	; 0380233E
	bl loc_0380282C	; 03802340
	str r7,[r4,#0x1c]	; 03802344
	mov r0,#0x18	; 03802346
	add r1,r7,#0x0	; 03802348
	bl loc_03802418	; 0380234A
	b loc_03802230	; 0380234E
loc_03802350:
	add r0,r5,#0x4	; 03802350
	bl loc_038027EC	; 03802352
	str r7,[r4,#0x1c]	; 03802356
	mov r0,#0x19	; 03802358
	add r1,r7,#0x0	; 0380235A
	bl loc_03802418	; 0380235C
	b loc_03802230	; 03802360
loc_03802362:
	add r0,r5,#0x0	; 03802362
	bl loc_0380299C	; 03802364
	str r7,[r4,#0x1c]	; 03802368
	mov r0,#0x20	; 0380236A
	add r1,r7,#0x0	; 0380236C
	bl loc_03802418	; 0380236E
	b loc_03802230	; 03802372
loc_03802374:
	add r0,r6,#0x0	; 03802374
	bl loc_03802934	; 03802376
	cmp r0,#0x0	; 0380237A
	bne loc_0380238A	; 0380237C
	str r7,[r4,#0x1c]	; 0380237E
	mov r0,#0x24	; 03802380
	mov r1,#0x2	; 03802382
	bl loc_03802418	; 03802384
	b loc_03802230	; 03802388
loc_0380238A:
	str r7,[r4,#0x1c]	; 0380238A
	mov r0,#0x24	; 0380238C
	add r1,r7,#0x0	; 0380238E
	bl loc_03802418	; 03802390
	b loc_03802230	; 03802394
loc_03802396:
	add r0,r6,#0x0	; 03802396
	bl loc_038028CC	; 03802398
	cmp r0,#0x0	; 0380239C
	bne loc_038023AC	; 0380239E
	str r7,[r4,#0x1c]	; 038023A0
	mov r0,#0x25	; 038023A2
	mov r1,#0x2	; 038023A4
	bl loc_03802418	; 038023A6
	b loc_03802230	; 038023AA
loc_038023AC:
	str r7,[r4,#0x1c]	; 038023AC
	mov r0,#0x25	; 038023AE
	add r1,r7,#0x0	; 038023B0
	bl loc_03802418	; 038023B2
	b loc_03802230	; 038023B6
loc_038023B8:
	add r0,r5,#0x0	; 038023B8
	bl loc_0380288C	; 038023BA
	str r7,[r4,#0x1c]	; 038023BE
	mov r0,#0x26	; 038023C0
	add r1,r7,#0x0	; 038023C2
	bl loc_03802418	; 038023C4
	b loc_03802230	; 038023C8
loc_038023CA:
	add r0,r5,#0x2	; 038023CA
	bl loc_0380284C	; 038023CC
	str r7,[r4,#0x1c]	; 038023D0
	mov r0,#0x27	; 038023D2
	add r1,r7,#0x0	; 038023D4
	bl loc_03802418	; 038023D6
	b loc_03802230	; 038023DA
loc_038023DC:
	add r0,r5,#0x4	; 038023DC
	bl loc_0380280C	; 038023DE
	str r7,[r4,#0x1c]	; 038023E2
	mov r0,#0x28	; 038023E4
	add r1,r7,#0x0	; 038023E6
	bl loc_03802418	; 038023E8
	b loc_03802230	; 038023EC
loc_038023EE:
	add r0,r5,#0x4	; 038023EE
	bl loc_038027CC	; 038023F0
	str r7,[r4,#0x1c]	; 038023F4
	mov r0,#0x29	; 038023F6
	add r1,r7,#0x0	; 038023F8
	bl loc_03802418	; 038023FA
	b loc_03802230	; 038023FE
loc_03802400:
	str r7,[r4,#0x1c]	; 03802400
	mov r1,#0x1	; 03802402
	bl loc_03802418	; 03802404
	b loc_03802230	; 03802408
	.byte 0xC0, 0x46	; 0380240C
pool_0380240C:
loc_0380240C:
	.word 0x027FFDE8	; 0380240C
pool_03802410:
loc_03802410:
	.word 0x038072C0	; 03802410
pool_03802414:
loc_03802414:
	.word 0x03807140	; 03802414

; ===== function loc_03802418 =====
loc_03802418:
	add r2,r0,#0x0	; 03802418
	mov r0,#0x5	; 0380241A
	lsl r3,r2,#0x8	; 0380241C
	ldr r2,[pool_03802434]	; 0380241E
	and r3,r2	; 03802420
	ldr r2,[pool_03802438]	; 03802422
	orr r3,r2	; 03802424
	mov r2,#0xff	; 03802426
	and r1,r2	; 03802428
	orr r3,r1	; 0380242A
	add r1,r3,#0x0	; 0380242C
	mov r2,#0x0	; 0380242E
	ldr r3,[pool_0380243C]	; 03802430
	bx r3	; 03802432
pool_03802434:
loc_03802434:
	.word 0x00007F00	; 03802434
pool_03802438:
loc_03802438:
	.word 0x00008000	; 03802438
pool_0380243C:
loc_0380243C:
	.word loc_03801EEC + 1	; 0380243C
P2_PxiCallback_03802440:
	push {r4,lr}	; 03802440
	cmp r2,#0x0	; 03802442
	bne loc_038024E2	; 03802444
	ldr r0,[pool_038024E8]	; 03802446
	and r1,r0	; 03802448
	lsl r0,r1,#0x8	; 0380244A
	lsr r4,r0,#0x10	; 0380244C
	cmp r4,#0x10	; 0380244E
	bgt loc_03802468	; 03802450
	cmp r4,#0x10	; 03802452
	bge loc_038024AA	; 03802454
	cmp r4,#0x1	; 03802456
	bgt loc_038024DA	; 03802458
	cmp r4,#0x0	; 0380245A
	blt loc_038024DA	; 0380245C
	cmp r4,#0x0	; 0380245E
	beq loc_038024AA	; 03802460
	cmp r4,#0x1	; 03802462
	beq loc_038024AA	; 03802464
	b loc_038024DA	; 03802466
loc_03802468:
	add r0,r4,#0x0	; 03802468
	sub r0,#0x14	; 0380246A
	cmp r0,#0x15	; 0380246C
	bhi loc_038024DA	; 0380246E
	add r0,r0,r0	; 03802470
P2_SwitchIndexPC_03802470:
	add r0,pc	; 03802472
	ldrh r0,[r0,#(P2_SwitchTable_03802470 - (P2_SwitchIndexPC_03802470 + 4))]	; 03802474
	lsl r0,r0,#0x10	; 03802476
	asr r0,r0,#0x10	; 03802478
P2_SwitchTargetPC_03802470:
	add r0,pc	; 0380247A
	bx r0	; 0380247C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802470:
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024DA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
	.halfword (loc_038024AA + 1) - (P2_SwitchTargetPC_03802470 + 4)
P2_SwitchTable_03802470End:
loc_038024AA:
	ldr r0,[pool_038024EC]	; 038024AA
	ldr r1,[r0,#0x1c]	; 038024AC
	cmp r1,#0x0	; 038024AE
	beq loc_038024BC	; 038024B0
	add r0,r4,#0x0	; 038024B2
	mov r1,#0x3	; 038024B4
	bl loc_03802418	; 038024B6
	b loc_038024E2	; 038024BA
loc_038024BC:
	mov r1,#0x1	; 038024BC
	str r1,[r0,#0x1c]	; 038024BE
	strh r4,[r0,#0x20]	; 038024C0
	ldr r0,[pool_038024F0]	; 038024C2
	mov r1,#0x0	; 038024C4
	add r2,r1,#0x0	; 038024C6
	bl loc_037FE2BC	; 038024C8
	cmp r0,#0x0	; 038024CC
	bne loc_038024E2	; 038024CE
	add r0,r4,#0x0	; 038024D0
	mov r1,#0x4	; 038024D2
	bl loc_03802418	; 038024D4
	b loc_038024E2	; 038024D8
loc_038024DA:
	add r0,r4,#0x0	; 038024DA
	mov r1,#0x1	; 038024DC
	bl loc_03802418	; 038024DE
loc_038024E2:
	pop {r4}	; 038024E2
	pop {r3}	; 038024E4
	bx r3	; 038024E6
pool_038024E8:
loc_038024E8:
	.word 0x00007F00	; 038024E8
pool_038024EC:
loc_038024EC:
	.word P2_BssStart + 0x1F6C	; 038024EC
pool_038024F0:
loc_038024F0:
	.word 0x03807140	; 038024F0

; ===== function loc_038024F4 =====
loc_038024F4:
	push {r4,lr}	; 038024F4
	sub sp,#0x10	; 038024F6
	add r4,r0,#0x0	; 038024F8
	mov r1,#0x1	; 038024FA
	ldr r0,[pool_03802590]	; 038024FC
	strh r1,[r0,#0x0]	; 038024FE
	ldr r0,[pool_03802594]	; 03802500
	str r1,[r0,#0x1c]	; 03802502
	bl loc_03802128	; 03802504
	mov r1,#0x0	; 03802508
	ldr r0,[pool_03802594]	; 0380250A
	str r1,[r0,#0x1c]	; 0380250C
	bl loc_03801E0C	; 0380250E
	mov r0,#0x5	; 03802512
	ldr r1,[pool_03802598]	; 03802514
	bl P2_SetPxiReceiveCallback	; 03802516
	ldr r0,[pool_0380259C]	; 0380251A
	ldr r1,[pool_038025A0]	; 0380251C
	mov r2,#0x4	; 0380251E
	bl loc_037FE318	; 03802520
	ldr r0,[pool_038025A4]	; 03802524
	str r0,[sp,#0x0]	; 03802526
	str r4,[sp,#0x4]	; 03802528
	ldr r0,[pool_038025A8]	; 0380252A
	ldr r1,[pool_038025AC]	; 0380252C
	mov r2,#0x0	; 0380252E
	ldr r3,[pool_038025B0]	; 03802530
	bl P2_CreateThread	; 03802532
	ldr r0,[pool_038025A8]	; 03802536
	bl loc_037FDE9C	; 03802538
	mov r2,#0x0	; 0380253C
	ldr r0,[pool_038025B4]	; 0380253E
	strh r2,[r0,#0x1c]	; 03802540
	ldr r0,[pool_038025A4]	; 03802542
	str r0,[sp,#0x0]	; 03802544
	sub r0,r4,#0x1	; 03802546
	str r0,[sp,#0x4]	; 03802548
	ldr r0,[pool_038025B8]	; 0380254A
	ldr r1,[pool_038025BC]	; 0380254C
	ldr r3,[pool_038025C0]	; 0380254E
	bl P2_CreateThread	; 03802550
	ldr r0,[pool_038025B8]	; 03802554
	bl loc_037FDE9C	; 03802556
	bl loc_037FEBF8	; 0380255A
	cmp r0,#0x0	; 0380255E
	bne loc_03802566	; 03802560
	bl loc_037FEC04	; 03802562
loc_03802566:
	ldr r0,[pool_038025C0]	; 03802566
	bl loc_037FEBF0	; 03802568
	bl loc_037FE824	; 0380256C
	add r4,r0,#0x0	; 03802570
	add r2,r1,#0x0	; 03802572
	ldr r0,[pool_038025C4]	; 03802574
	str r0,[sp,#0x4]	; 03802576
	mov r0,#0x0	; 03802578
	str r0,[sp,#0x8]	; 0380257A
	ldr r3,[pool_038025C8]	; 0380257C
	str r0,[sp,#0x0]	; 0380257E
	ldr r0,[pool_038025C0]	; 03802580
	add r1,r4,#0x0	; 03802582
	bl loc_037FEA74	; 03802584
	add sp,#0x10	; 03802588
	pop {r4}	; 0380258A
	pop {r3}	; 0380258C
	bx r3	; 0380258E
pool_03802590:
loc_03802590:
	.word P2_BssStart + 0x1DE8	; 03802590
pool_03802594:
loc_03802594:
	.word P2_BssStart + 0x1F6C	; 03802594
pool_03802598:
loc_03802598:
	.word P2_PxiCallback_03802440 + 1	; 03802598
pool_0380259C:
loc_0380259C:
	.word 0x03807140	; 0380259C
pool_038025A0:
loc_038025A0:
	.word 0x03807154	; 038025A0
pool_038025A4:
loc_038025A4:
	.word 0x00000100	; 038025A4
pool_038025A8:
loc_038025A8:
	.word 0x03807164	; 038025A8
pool_038025AC:
loc_038025AC:
	.word P2_ThreadEntry_03802224 + 1	; 038025AC
pool_038025B0:
loc_038025B0:
	.word 0x038072DC	; 038025B0
pool_038025B4:
loc_038025B4:
	.word P2_BssStart + 0x1FEC	; 038025B4
pool_038025B8:
loc_038025B8:
	.word 0x038072E4	; 038025B8
pool_038025BC:
loc_038025BC:
	.word P2_ThreadEntry_03802188 + 1	; 038025BC
pool_038025C0:
loc_038025C0:
	.word 0x03807460	; 038025C0
pool_038025C4:
loc_038025C4:
	.word 0x03802179	; 038025C4
pool_038025C8:
loc_038025C8:
	.word 0x00001388	; 038025C8

; ===== function loc_038025CC =====
loc_038025CC:
	push {r4,r5,r6,r7,lr}	; 038025CC
	sub sp,#0x4	; 038025CE
	add r5,r0,#0x0	; 038025D0
	add r7,r1,#0x0	; 038025D2
	add r4,r2,#0x0	; 038025D4
	add r6,r3,#0x0	; 038025D6
	bl loc_0380260C	; 038025D8
	add r0,r5,#0x0	; 038025DC
	add r1,r7,#0x0	; 038025DE
	bl loc_03802618	; 038025E0
	cmp r5,#0x6	; 038025E4
	beq loc_038025F6	; 038025E6
	cmp r5,#0x86	; 038025E8
	bne loc_038025FE	; 038025EA
	add r0,r4,#0x0	; 038025EC
	add r1,r6,#0x0	; 038025EE
	bl loc_03802624	; 038025F0
	b loc_038025FE	; 038025F4
loc_038025F6:
	add r0,r4,#0x0	; 038025F6
	add r1,r6,#0x0	; 038025F8
	bl loc_03802630	; 038025FA
loc_038025FE:
	bl loc_0380263C	; 038025FE
	add sp,#0x4	; 03802602
	pop {r4,r5,r6,r7}	; 03802604
	pop {r3}	; 03802606
	bx r3	; 03802608
	.byte 0xC0, 0x46	; 0380260C

; ===== function loc_0380260C =====
loc_0380260C:
	bx pc	; 0380260C
	.byte 0xC0, 0x46	; 03802610
.arm

; ===== function loc_03802610 =====
loc_03802610:
	ldr pc,[pool_03802614]	; 03802610
pool_03802614:
loc_03802614:
	.word loc_03802AB0	; 03802614
.thumb

; ===== function loc_03802618 =====
loc_03802618:
	bx pc	; 03802618
	.byte 0xC0, 0x46	; 0380261C
.arm

; ===== function loc_0380261C =====
loc_0380261C:
	ldr pc,[pool_03802620]	; 0380261C
pool_03802620:
loc_03802620:
	.word loc_03802B24	; 03802620
.thumb

; ===== function loc_03802624 =====
loc_03802624:
	bx pc	; 03802624
	.byte 0xC0, 0x46	; 03802628
.arm

; ===== function loc_03802628 =====
loc_03802628:
	ldr pc,[pool_0380262C]	; 03802628
pool_0380262C:
loc_0380262C:
	.word loc_03802C24	; 0380262C
.thumb

; ===== function loc_03802630 =====
loc_03802630:
	bx pc	; 03802630
	.byte 0xC0, 0x46	; 03802634
.arm

; ===== function loc_03802634 =====
loc_03802634:
	ldr pc,[pool_03802638]	; 03802634
pool_03802638:
loc_03802638:
	.word loc_03802B94	; 03802638
.thumb

; ===== function loc_0380263C =====
loc_0380263C:
	bx pc	; 0380263C
	.byte 0xC0, 0x46	; 03802640
.arm

; ===== function loc_03802640 =====
loc_03802640:
	ldr pc,[pool_03802644]	; 03802640
pool_03802644:
loc_03802644:
	.word loc_03802AF0	; 03802644
.thumb

; ===== function loc_03802648 =====
loc_03802648:
	ldr r1,[r0,#0x0]	; 03802648
	lsl r2,r1,#0x12	; 0380264A
	lsr r2,r2,#0x1a	; 0380264C
	cmp r2,#0x23	; 0380264E
	bhi loc_038026E4	; 03802650
	add r3,r2,r2	; 03802652
P2_SwitchIndexPC_03802652:
	add r3,pc	; 03802654
	ldrh r3,[r3,#(P2_SwitchTable_03802652 - (P2_SwitchIndexPC_03802652 + 4))]	; 03802656
	lsl r3,r3,#0x10	; 03802658
	asr r3,r3,#0x10	; 0380265A
P2_SwitchTargetPC_03802652:
	add r3,pc	; 0380265C
	bx r3	; 0380265E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802652:
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026C2 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026C2 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026A8 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026E4 + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
	.halfword (loc_038026DC + 1) - (P2_SwitchTargetPC_03802652 + 4)
P2_SwitchTable_03802652End:
loc_038026A8:
	lsl r3,r1,#0x11	; 038026A8
	lsr r3,r3,#0x1f	; 038026AA
	cmp r3,#0x0	; 038026AC
	beq loc_038026F4	; 038026AE
	ldr r3,[pool_038026F8]	; 038026B0
	and r1,r3	; 038026B2
	add r2,#0x12	; 038026B4
	mov r3,#0x3f	; 038026B6
	and r2,r3	; 038026B8
	lsl r2,r2,#0x8	; 038026BA
	orr r1,r2	; 038026BC
	str r1,[r0,#0x0]	; 038026BE
	bx lr	; 038026C0
loc_038026C2:
	lsl r3,r1,#0x11	; 038026C2
	lsr r3,r3,#0x1f	; 038026C4
	cmp r3,#0x0	; 038026C6
	beq loc_038026F4	; 038026C8
	ldr r3,[pool_038026F8]	; 038026CA
	and r1,r3	; 038026CC
	add r2,#0x18	; 038026CE
	mov r3,#0x3f	; 038026D0
	and r2,r3	; 038026D2
	lsl r2,r2,#0x8	; 038026D4
	orr r1,r2	; 038026D6
	str r1,[r0,#0x0]	; 038026D8
	bx lr	; 038026DA
loc_038026DC:
	ldr r2,[pool_038026FC]	; 038026DC
	orr r1,r2	; 038026DE
	str r1,[r0,#0x0]	; 038026E0
	bx lr	; 038026E2
loc_038026E4:
	ldr r2,[r0,#0x0]	; 038026E4
	ldr r1,[pool_03802700]	; 038026E6
	and r2,r1	; 038026E8
	str r2,[r0,#0x0]	; 038026EA
	ldr r2,[r0,#0x0]	; 038026EC
	ldr r1,[pool_038026F8]	; 038026EE
	and r2,r1	; 038026F0
	str r2,[r0,#0x0]	; 038026F2
loc_038026F4:
	bx lr	; 038026F4
	.byte 0xC0, 0x46	; 038026F8
pool_038026F8:
loc_038026F8:
	.word 0xFFFFC0FF	; 038026F8
pool_038026FC:
loc_038026FC:
	.word 0x00004000	; 038026FC
pool_03802700:
loc_03802700:
	.word 0xFFFFBFFF	; 03802700

; ===== function loc_03802704 =====
loc_03802704:
	ldr r1,[r0,#0x0]	; 03802704
	lsl r2,r1,#0x12	; 03802706
	lsr r2,r2,#0x1a	; 03802708
	cmp r2,#0x23	; 0380270A
	bhi loc_038027AC	; 0380270C
	add r2,r2,r2	; 0380270E
P2_SwitchIndexPC_0380270E:
	add r2,pc	; 03802710
	ldrh r2,[r2,#(P2_SwitchTable_0380270E - (P2_SwitchIndexPC_0380270E + 4))]	; 03802712
	lsl r2,r2,#0x10	; 03802714
	asr r2,r2,#0x10	; 03802716
P2_SwitchTargetPC_0380270E:
	add r2,pc	; 03802718
	bx r2	; 0380271A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380270E:
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_03802764 + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_038027AC + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380278C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380278C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
	.halfword (loc_0380276C + 1) - (P2_SwitchTargetPC_0380270E + 4)
P2_SwitchTable_0380270EEnd:
loc_03802764:
	ldr r2,[pool_038027C0]	; 03802764
	and r1,r2	; 03802766
	str r1,[r0,#0x0]	; 03802768
	bx lr	; 0380276A
loc_0380276C:
	ldr r2,[pool_038027C4]	; 0380276C
	orr r1,r2	; 0380276E
	str r1,[r0,#0x0]	; 03802770
	ldr r2,[r0,#0x0]	; 03802772
	ldr r1,[pool_038027C8]	; 03802774
	add r3,r2,#0x0	; 03802776
	and r3,r1	; 03802778
	lsl r1,r2,#0x12	; 0380277A
	lsr r2,r1,#0x1a	; 0380277C
	sub r2,#0x12	; 0380277E
	mov r1,#0x3f	; 03802780
	and r2,r1	; 03802782
	lsl r1,r2,#0x8	; 03802784
	orr r3,r1	; 03802786
	str r3,[r0,#0x0]	; 03802788
	bx lr	; 0380278A
loc_0380278C:
	ldr r2,[pool_038027C4]	; 0380278C
	orr r1,r2	; 0380278E
	str r1,[r0,#0x0]	; 03802790
	ldr r2,[r0,#0x0]	; 03802792
	ldr r1,[pool_038027C8]	; 03802794
	add r3,r2,#0x0	; 03802796
	and r3,r1	; 03802798
	lsl r1,r2,#0x12	; 0380279A
	lsr r2,r1,#0x1a	; 0380279C
	sub r2,#0x18	; 0380279E
	mov r1,#0x3f	; 038027A0
	and r2,r1	; 038027A2
	lsl r1,r2,#0x8	; 038027A4
	orr r3,r1	; 038027A6
	str r3,[r0,#0x0]	; 038027A8
	bx lr	; 038027AA
loc_038027AC:
	ldr r2,[r0,#0x0]	; 038027AC
	ldr r1,[pool_038027C0]	; 038027AE
	and r2,r1	; 038027B0
	str r2,[r0,#0x0]	; 038027B2
	ldr r2,[r0,#0x0]	; 038027B4
	ldr r1,[pool_038027C8]	; 038027B6
	and r2,r1	; 038027B8
	str r2,[r0,#0x0]	; 038027BA
	bx lr	; 038027BC
	.byte 0xC0, 0x46	; 038027C0
pool_038027C0:
loc_038027C0:
	.word 0xFFFFBFFF	; 038027C0
pool_038027C4:
loc_038027C4:
	.word 0x00004000	; 038027C4
pool_038027C8:
loc_038027C8:
	.word 0xFFFFC0FF	; 038027C8

; ===== function loc_038027CC =====
loc_038027CC:
	push {r4,lr}	; 038027CC
	add r4,r0,#0x0	; 038027CE
	ldr r0,[pool_038027E8]	; 038027D0
	bl loc_03802100	; 038027D2
	mov r0,#0x6	; 038027D6
	mov r1,#0x70	; 038027D8
	add r2,r4,#0x0	; 038027DA
	mov r3,#0x1	; 038027DC
	bl loc_038025CC	; 038027DE
	pop {r4}	; 038027E2
	pop {r3}	; 038027E4
	bx r3	; 038027E6
pool_038027E8:
loc_038027E8:
	.word 0x00008000	; 038027E8

; ===== function loc_038027EC =====
loc_038027EC:
	push {r4,lr}	; 038027EC
	add r4,r0,#0x0	; 038027EE
	ldr r0,[pool_03802808]	; 038027F0
	bl loc_03802100	; 038027F2
	mov r0,#0x86	; 038027F6
	mov r1,#0x70	; 038027F8
	add r2,r4,#0x0	; 038027FA
	mov r3,#0x1	; 038027FC
	bl loc_038025CC	; 038027FE
	pop {r4}	; 03802802
	pop {r3}	; 03802804
	bx r3	; 03802806
pool_03802808:
loc_03802808:
	.word 0x00008000	; 03802808

; ===== function loc_0380280C =====
loc_0380280C:
	push {r4,lr}	; 0380280C
	add r4,r0,#0x0	; 0380280E
	ldr r0,[pool_03802828]	; 03802810
	bl loc_03802100	; 03802812
	mov r0,#0x6	; 03802816
	mov r1,#0x30	; 03802818
	add r2,r4,#0x0	; 0380281A
	mov r3,#0x1	; 0380281C
	bl loc_038025CC	; 0380281E
	pop {r4}	; 03802822
	pop {r3}	; 03802824
	bx r3	; 03802826
pool_03802828:
loc_03802828:
	.word 0x00008000	; 03802828

; ===== function loc_0380282C =====
loc_0380282C:
	push {r4,lr}	; 0380282C
	add r4,r0,#0x0	; 0380282E
	ldr r0,[pool_03802848]	; 03802830
	bl loc_03802100	; 03802832
	mov r0,#0x86	; 03802836
	mov r1,#0x30	; 03802838
	add r2,r4,#0x0	; 0380283A
	mov r3,#0x1	; 0380283C
	bl loc_038025CC	; 0380283E
	pop {r4}	; 03802842
	pop {r3}	; 03802844
	bx r3	; 03802846
pool_03802848:
loc_03802848:
	.word 0x00008000	; 03802848

; ===== function loc_0380284C =====
loc_0380284C:
	push {r4,lr}	; 0380284C
	add r4,r0,#0x0	; 0380284E
	ldr r0,[pool_03802868]	; 03802850
	bl loc_03802100	; 03802852
	mov r0,#0x6	; 03802856
	mov r1,#0x40	; 03802858
	add r2,r4,#0x0	; 0380285A
	mov r3,#0x1	; 0380285C
	bl loc_038025CC	; 0380285E
	pop {r4}	; 03802862
	pop {r3}	; 03802864
	bx r3	; 03802866
pool_03802868:
loc_03802868:
	.word 0x00008000	; 03802868

; ===== function loc_0380286C =====
loc_0380286C:
	push {r4,lr}	; 0380286C
	add r4,r0,#0x0	; 0380286E
	ldr r0,[pool_03802888]	; 03802870
	bl loc_03802100	; 03802872
	mov r0,#0x86	; 03802876
	mov r1,#0x40	; 03802878
	add r2,r4,#0x0	; 0380287A
	mov r3,#0x1	; 0380287C
	bl loc_038025CC	; 0380287E
	pop {r4}	; 03802882
	pop {r3}	; 03802884
	bx r3	; 03802886
pool_03802888:
loc_03802888:
	.word 0x00008000	; 03802888

; ===== function loc_0380288C =====
loc_0380288C:
	push {r4,lr}	; 0380288C
	add r4,r0,#0x0	; 0380288E
	ldr r0,[pool_038028A8]	; 03802890
	bl loc_03802100	; 03802892
	mov r0,#0x6	; 03802896
	mov r1,#0x0	; 03802898
	add r2,r4,#0x0	; 0380289A
	mov r3,#0x1	; 0380289C
	bl loc_038025CC	; 0380289E
	pop {r4}	; 038028A2
	pop {r3}	; 038028A4
	bx r3	; 038028A6
pool_038028A8:
loc_038028A8:
	.word 0x00008000	; 038028A8

; ===== function loc_038028AC =====
loc_038028AC:
	push {r4,lr}	; 038028AC
	add r4,r0,#0x0	; 038028AE
	ldr r0,[pool_038028C8]	; 038028B0
	bl loc_03802100	; 038028B2
	mov r0,#0x86	; 038028B6
	mov r1,#0x0	; 038028B8
	add r2,r4,#0x0	; 038028BA
	mov r3,#0x1	; 038028BC
	bl loc_038025CC	; 038028BE
	pop {r4}	; 038028C2
	pop {r3}	; 038028C4
	bx r3	; 038028C6
pool_038028C8:
loc_038028C8:
	.word 0x00008000	; 038028C8

; ===== function loc_038028CC =====
loc_038028CC:
	push {r4,lr}	; 038028CC
	sub sp,#0x8	; 038028CE
	add r4,r0,#0x0	; 038028D0
	add r0,sp,#0x0	; 038028D2
	bl loc_0380286C	; 038028D4
	add r0,sp,#0x0	; 038028D8
	ldrh r0,[r0,#0x0]	; 038028DA
	lsl r0,r0,#0x19	; 038028DC
	lsr r0,r0,#0x1f	; 038028DE
	cmp r0,#0x0	; 038028E0
	beq loc_038028F4	; 038028E2
	mov r0,#0x6	; 038028E4
	mov r1,#0x50	; 038028E6
	add r2,r4,#0x0	; 038028E8
	mov r3,#0x3	; 038028EA
	bl loc_038025CC	; 038028EC
	mov r0,#0x1	; 038028F0
	b loc_038028F6	; 038028F2
loc_038028F4:
	mov r0,#0x0	; 038028F4
loc_038028F6:
	add sp,#0x8	; 038028F6
	pop {r4}	; 038028F8
	pop {r3}	; 038028FA
	bx r3	; 038028FC
	.byte 0x00, 0x00	; 03802900

; ===== function loc_03802900 =====
loc_03802900:
	push {r4,lr}	; 03802900
	sub sp,#0x8	; 03802902
	add r4,r0,#0x0	; 03802904
	add r0,sp,#0x0	; 03802906
	bl loc_0380286C	; 03802908
	add r0,sp,#0x0	; 0380290C
	ldrh r0,[r0,#0x0]	; 0380290E
	lsl r0,r0,#0x19	; 03802910
	lsr r0,r0,#0x1f	; 03802912
	cmp r0,#0x0	; 03802914
	beq loc_03802928	; 03802916
	mov r0,#0x86	; 03802918
	mov r1,#0x50	; 0380291A
	add r2,r4,#0x0	; 0380291C
	mov r3,#0x3	; 0380291E
	bl loc_038025CC	; 03802920
	mov r0,#0x1	; 03802924
	b loc_0380292A	; 03802926
loc_03802928:
	mov r0,#0x0	; 03802928
loc_0380292A:
	add sp,#0x8	; 0380292A
	pop {r4}	; 0380292C
	pop {r3}	; 0380292E
	bx r3	; 03802930
	.byte 0x00, 0x00	; 03802934

; ===== function loc_03802934 =====
loc_03802934:
	push {r4,lr}	; 03802934
	sub sp,#0x8	; 03802936
	add r4,r0,#0x0	; 03802938
	add r0,sp,#0x0	; 0380293A
	bl loc_0380286C	; 0380293C
	add r0,sp,#0x0	; 03802940
	ldrh r0,[r0,#0x0]	; 03802942
	lsl r0,r0,#0x1c	; 03802944
	lsr r0,r0,#0x1c	; 03802946
	cmp r0,#0x4	; 03802948
	bne loc_0380295C	; 0380294A
	mov r0,#0x6	; 0380294C
	mov r1,#0x10	; 0380294E
	add r2,r4,#0x0	; 03802950
	mov r3,#0x3	; 03802952
	bl loc_038025CC	; 03802954
	mov r0,#0x1	; 03802958
	b loc_0380295E	; 0380295A
loc_0380295C:
	mov r0,#0x0	; 0380295C
loc_0380295E:
	add sp,#0x8	; 0380295E
	pop {r4}	; 03802960
	pop {r3}	; 03802962
	bx r3	; 03802964
	.byte 0x00, 0x00	; 03802968

; ===== function loc_03802968 =====
loc_03802968:
	push {r4,lr}	; 03802968
	sub sp,#0x8	; 0380296A
	add r4,r0,#0x0	; 0380296C
	add r0,sp,#0x0	; 0380296E
	bl loc_0380286C	; 03802970
	add r0,sp,#0x0	; 03802974
	ldrh r0,[r0,#0x0]	; 03802976
	lsl r0,r0,#0x1c	; 03802978
	lsr r0,r0,#0x1c	; 0380297A
	cmp r0,#0x4	; 0380297C
	bne loc_03802990	; 0380297E
	mov r0,#0x86	; 03802980
	mov r1,#0x10	; 03802982
	add r2,r4,#0x0	; 03802984
	mov r3,#0x3	; 03802986
	bl loc_038025CC	; 03802988
	mov r0,#0x1	; 0380298C
	b loc_03802992	; 0380298E
loc_03802990:
	mov r0,#0x0	; 03802990
loc_03802992:
	add sp,#0x8	; 03802992
	pop {r4}	; 03802994
	pop {r3}	; 03802996
	bx r3	; 03802998
	.byte 0x00, 0x00	; 0380299C

; ===== function loc_0380299C =====
loc_0380299C:
	push {r4,lr}	; 0380299C
	add r4,r0,#0x0	; 0380299E
	ldr r0,[pool_038029B8]	; 038029A0
	bl loc_03802100	; 038029A2
	mov r0,#0x6	; 038029A6
	mov r1,#0x20	; 038029A8
	add r2,r4,#0x0	; 038029AA
	mov r3,#0x7	; 038029AC
	bl loc_038025CC	; 038029AE
	pop {r4}	; 038029B2
	pop {r3}	; 038029B4
	bx r3	; 038029B6
pool_038029B8:
loc_038029B8:
	.word 0x00008000	; 038029B8

; ===== function loc_038029BC =====
loc_038029BC:
	push {r4,lr}	; 038029BC
	add r4,r0,#0x0	; 038029BE
	ldr r0,[pool_038029D8]	; 038029C0
	bl loc_03802100	; 038029C2
	mov r0,#0x86	; 038029C6
	mov r1,#0x20	; 038029C8
	add r2,r4,#0x0	; 038029CA
	mov r3,#0x7	; 038029CC
	bl loc_038025CC	; 038029CE
	pop {r4}	; 038029D2
	pop {r3}	; 038029D4
	bx r3	; 038029D6
pool_038029D8:
loc_038029D8:
	.word 0x00008000	; 038029D8

; ===== function loc_038029DC =====
loc_038029DC:
	push {r4,r5,lr}	; 038029DC
	sub sp,#0xc	; 038029DE
	add r5,r0,#0x0	; 038029E0
	mov r0,#0x1	; 038029E2
	add r4,r5,#0x0	; 038029E4
	and r4,r0	; 038029E6
	lsl r0,r4,#0x10	; 038029E8
	lsr r0,r0,#0x10	; 038029EA
	cmp r0,#0x1	; 038029EC
	bne loc_03802A7C	; 038029EE
	add r0,sp,#0x0	; 038029F0
	bl loc_038028AC	; 038029F2
	add r0,sp,#0x0	; 038029F6
	ldrh r1,[r0,#0x0]	; 038029F8
	lsl r2,r1,#0x1e	; 038029FA
	lsr r3,r2,#0x1f	; 038029FC
	lsl r2,r4,#0x10	; 038029FE
	lsr r2,r2,#0x10	; 03802A00
	cmp r3,r2	; 03802A02
	beq loc_03802A7C	; 03802A04
	mov r3,#0x1	; 03802A06
	and r5,r3	; 03802A08
	mov r2,#0x2	; 03802A0A
	bic r1,r2	; 03802A0C
	lsl r2,r5,#0x10	; 03802A0E
	lsr r2,r2,#0x10	; 03802A10
	and r2,r3	; 03802A12
	lsl r2,r2,#0x1	; 03802A14
	orr r1,r2	; 03802A16
	strh r1,[r0,#0x0]	; 03802A18
	add r0,sp,#0x0	; 03802A1A
	bl loc_0380288C	; 03802A1C
	mov r0,#0x86	; 03802A20
	mov r1,#0x10	; 03802A22
	add r2,sp,#0x4	; 03802A24
	mov r3,#0x3	; 03802A26
	bl loc_038025CC	; 03802A28
	lsl r0,r5,#0x10	; 03802A2C
	lsr r0,r0,#0x10	; 03802A2E
	cmp r0,#0x0	; 03802A30
	bne loc_03802A3C	; 03802A32
	add r0,sp,#0x4	; 03802A34
	bl loc_03802704	; 03802A36
	b loc_03802A42	; 03802A3A
loc_03802A3C:
	add r0,sp,#0x4	; 03802A3C
	bl loc_03802648	; 03802A3E
loc_03802A42:
	mov r0,#0x6	; 03802A42
	mov r1,#0x10	; 03802A44
	add r2,sp,#0x4	; 03802A46
	mov r3,#0x3	; 03802A48
	bl loc_038025CC	; 03802A4A
	mov r0,#0x86	; 03802A4E
	mov r1,#0x50	; 03802A50
	add r2,sp,#0x4	; 03802A52
	mov r3,#0x3	; 03802A54
	bl loc_038025CC	; 03802A56
	lsl r0,r4,#0x10	; 03802A5A
	lsr r0,r0,#0x10	; 03802A5C
	cmp r0,#0x0	; 03802A5E
	bne loc_03802A6A	; 03802A60
	add r0,sp,#0x4	; 03802A62
	bl loc_03802704	; 03802A64
	b loc_03802A70	; 03802A68
loc_03802A6A:
	add r0,sp,#0x4	; 03802A6A
	bl loc_03802648	; 03802A6C
loc_03802A70:
	mov r0,#0x6	; 03802A70
	mov r1,#0x50	; 03802A72
	add r2,sp,#0x4	; 03802A74
	mov r3,#0x3	; 03802A76
	bl loc_038025CC	; 03802A78
loc_03802A7C:
	add sp,#0xc	; 03802A7C
	pop {r4,r5}	; 03802A7E
	pop {r3}	; 03802A80
	bx r3	; 03802A82

; ===== function loc_03802A84 =====
loc_03802A84:
	push {lr}	; 03802A84
	sub sp,#0x4	; 03802A86
	ldr r0,[pool_03802AAC]	; 03802A88
	bl loc_03802100	; 03802A8A
	add r0,sp,#0x0	; 03802A8E
	ldrh r1,[r0,#0x0]	; 03802A90
	mov r3,#0x1	; 03802A92
	bic r1,r3	; 03802A94
	orr r1,r3	; 03802A96
	strh r1,[r0,#0x0]	; 03802A98
	mov r0,#0x6	; 03802A9A
	mov r1,#0x0	; 03802A9C
	add r2,sp,#0x0	; 03802A9E
	bl loc_038025CC	; 03802AA0
	add sp,#0x4	; 03802AA4
	pop {r3}	; 03802AA6
	bx r3	; 03802AA8
	.byte 0xC0, 0x46	; 03802AAC
pool_03802AAC:
loc_03802AAC:
	.word 0x00008000	; 03802AAC
.arm

; ===== function loc_03802AB0 =====
loc_03802AB0:
	mov r12,#0x4000000	; 03802AB0
	add r12,r12,#0x138	; 03802AB4
	ldrh r0,[r12,#0x0]	; 03802AB8
	bic r0,r0,#0x77	; 03802ABC
	orr r0,r0,#0x72	; 03802AC0
	strh r0,[r12,#0x0]	; 03802AC4
	mov r3,#0x2	; 03802AC8
loc_03802ACC:
	subs r3,r3,#0x1	; 03802ACC
	bne loc_03802ACC	; 03802AD0
	bic r0,r0,#0x4	; 03802AD4
	orr r0,r0,#0x4	; 03802AD8
	strh r0,[r12,#0x0]	; 03802ADC
	mov r3,#0x2	; 03802AE0
loc_03802AE4:
	subs r3,r3,#0x1	; 03802AE4
	bne loc_03802AE4	; 03802AE8
	bx lr	; 03802AEC

; ===== function loc_03802AF0 =====
loc_03802AF0:
	mov r12,#0x4000000	; 03802AF0
	add r12,r12,#0x138	; 03802AF4
	mov r3,#0x2	; 03802AF8
loc_03802AFC:
	subs r3,r3,#0x1	; 03802AFC
	bne loc_03802AFC	; 03802B00
	ldrh r0,[r12,#0x0]	; 03802B04
	bic r0,r0,#0x4	; 03802B08
	orr r0,r0,#0x0	; 03802B0C
	strh r0,[r12,#0x0]	; 03802B10
	mov r3,#0x2	; 03802B14
loc_03802B18:
	subs r3,r3,#0x1	; 03802B18
	bne loc_03802B18	; 03802B1C
	bx lr	; 03802B20

; ===== function loc_03802B24 =====
loc_03802B24:
	mov r12,#0x4000000	; 03802B24
	add r12,r12,#0x138	; 03802B28
	orr r1,r0,r1	; 03802B2C
	ldrh r0,[r12,#0x0]	; 03802B30
	bic r0,r0,#0x77	; 03802B34
	orr r0,r0,#0x74	; 03802B38
	mov r2,#0x0	; 03802B3C
loc_03802B40:
	bic r0,r0,#0x3	; 03802B40
	orr r0,r0,#0x0	; 03802B44
	mov r3,#0x1	; 03802B48
	tst r3,r1, lsr r2	; 03802B4C
	movne r3,#0x1	; 03802B50
	moveq r3,#0x0	; 03802B54
	orr r0,r0,r3	; 03802B58
	strh r0,[r12,#0x0]	; 03802B5C
	mov r3,#0x9	; 03802B60
loc_03802B64:
	subs r3,r3,#0x1	; 03802B64
	bne loc_03802B64	; 03802B68
	bic r0,r0,#0x2	; 03802B6C
	orr r0,r0,#0x2	; 03802B70
	strh r0,[r12,#0x0]	; 03802B74
	mov r3,#0x9	; 03802B78
loc_03802B7C:
	subs r3,r3,#0x1	; 03802B7C
	bne loc_03802B7C	; 03802B80
	add r2,r2,#0x1	; 03802B84
	cmp r2,#0x8	; 03802B88
	bne loc_03802B40	; 03802B8C
	bx lr	; 03802B90

; ===== function loc_03802B94 =====
loc_03802B94:
	mov r12,#0x4000000	; 03802B94
	add r12,r12,#0x138	; 03802B98
loc_03802B9C:
	stmdb sp!,{r0,r1}	; 03802B9C
	tst r0,#0x1	; 03802BA0
	ldreqh r1,[r0,#0x0]	; 03802BA4
	ldrneh r1,[r0,#-0x1]	; 03802BA8
	movne r1,r1, lsr #0x8	; 03802BAC
	ldrh r0,[r12,#0x0]	; 03802BB0
	bic r0,r0,#0x77	; 03802BB4
	orr r0,r0,#0x74	; 03802BB8
	mov r2,#0x0	; 03802BBC
loc_03802BC0:
	bic r0,r0,#0x3	; 03802BC0
	orr r0,r0,#0x0	; 03802BC4
	mov r3,#0x1	; 03802BC8
	tst r3,r1, lsr r2	; 03802BCC
	movne r3,#0x1	; 03802BD0
	moveq r3,#0x0	; 03802BD4
	orr r0,r0,r3	; 03802BD8
	strh r0,[r12,#0x0]	; 03802BDC
	mov r3,#0x9	; 03802BE0
loc_03802BE4:
	subs r3,r3,#0x1	; 03802BE4
	bne loc_03802BE4	; 03802BE8
	bic r0,r0,#0x2	; 03802BEC
	orr r0,r0,#0x2	; 03802BF0
	strh r0,[r12,#0x0]	; 03802BF4
	mov r3,#0x9	; 03802BF8
loc_03802BFC:
	subs r3,r3,#0x1	; 03802BFC
	bne loc_03802BFC	; 03802C00
	add r2,r2,#0x1	; 03802C04
	cmp r2,#0x8	; 03802C08
	bne loc_03802BC0	; 03802C0C
	ldmia sp!,{r0,r1}	; 03802C10
	add r0,r0,#0x1	; 03802C14
	subs r1,r1,#0x1	; 03802C18
	bne loc_03802B9C	; 03802C1C
	bx lr	; 03802C20

; ===== function loc_03802C24 =====
loc_03802C24:
	mov r12,#0x4000000	; 03802C24
	add r12,r12,#0x138	; 03802C28
loc_03802C2C:
	stmdb sp!,{r0,r1}	; 03802C2C
	ldrh r0,[r12,#0x0]	; 03802C30
	bic r0,r0,#0x77	; 03802C34
	orr r0,r0,#0x64	; 03802C38
	mov r2,#0x0	; 03802C3C
	mov r1,#0x0	; 03802C40
loc_03802C44:
	bic r0,r0,#0x3	; 03802C44
	orr r0,r0,#0x0	; 03802C48
	strh r0,[r12,#0x0]	; 03802C4C
	mov r3,#0x9	; 03802C50
loc_03802C54:
	subs r3,r3,#0x1	; 03802C54
	bne loc_03802C54	; 03802C58
	ldrh r0,[r12,#0x0]	; 03802C5C
	and r3,r0,#0x1	; 03802C60
	cmp r3,#0x1	; 03802C64
	moveq r3,#0x80	; 03802C68
	movne r3,#0x0	; 03802C6C
	orr r2,r3,r2, lsr #0x1	; 03802C70
	bic r0,r0,#0x2	; 03802C74
	orr r0,r0,#0x2	; 03802C78
	strh r0,[r12,#0x0]	; 03802C7C
	mov r3,#0x9	; 03802C80
loc_03802C84:
	subs r3,r3,#0x1	; 03802C84
	bne loc_03802C84	; 03802C88
	add r1,r1,#0x1	; 03802C8C
	cmp r1,#0x8	; 03802C90
	bne loc_03802C44	; 03802C94
	ldmia sp!,{r0,r1}	; 03802C98
	tst r0,#0x1	; 03802C9C
	beq loc_03802CBC	; 03802CA0
	ldrh r3,[r0,#-0x1]	; 03802CA4
	bic r3,r3,#0xff00	; 03802CA8
	mov r2,r2, lsl #0x8	; 03802CAC
	orr r3,r2,r3	; 03802CB0
	strh r3,[r0,#-0x1]	; 03802CB4
	b loc_03802CCC	; 03802CB8
loc_03802CBC:
	ldrh r3,[r0,#0x0]	; 03802CBC
	bic r3,r3,#0xff	; 03802CC0
	orr r3,r3,r2	; 03802CC4
	strh r3,[r0,#0x0]	; 03802CC8
loc_03802CCC:
	add r0,r0,#0x1	; 03802CCC
	subs r1,r1,#0x1	; 03802CD0
	bne loc_03802C2C	; 03802CD4
	bx lr	; 03802CD8
.thumb

; ===== function loc_03802CDC =====
P2_PxiCallback_03802CDC:
	push {lr}	; 03802CDC
	sub sp,#0x4	; 03802CDE
	cmp r2,#0x0	; 03802CE0
	bne loc_03802D08	; 03802CE2
	cmp r0,#0x4	; 03802CE4
	beq loc_03802D02	; 03802CE6
	cmp r0,#0x6	; 03802CE8
	beq loc_03802CF2	; 03802CEA
	cmp r0,#0x8	; 03802CEC
	beq loc_03802CFA	; 03802CEE
	b loc_03802D08	; 03802CF0
loc_03802CF2:
	add r0,r1,#0x0	; 03802CF2
	bl loc_03803204	; 03802CF4
	b loc_03802D08	; 03802CF8
loc_03802CFA:
	add r0,r1,#0x0	; 03802CFA
	bl loc_03804220	; 03802CFC
	b loc_03802D08	; 03802D00
loc_03802D02:
	add r0,r1,#0x0	; 03802D02
	bl loc_03803AA8	; 03802D04
loc_03802D08:
	add sp,#0x4	; 03802D08
	pop {r3}	; 03802D0A
	bx r3	; 03802D0C
	.byte 0x00, 0x00	; 03802D0E
P2_ThreadEntry_03802D10:
	push {r4,r5,r6,lr}	; 03802D10
	sub sp,#0x8	; 03802D12
	ldr r5,[pool_03802D48]	; 03802D14
	add r4,sp,#0x0	; 03802D16
	mov r6,#0x1	; 03802D18
P2_Entry_03802D1A:
	add r0,r5,#0x0	; 03802D1A
	add r1,r4,#0x0	; 03802D1C
	add r2,r6,#0x0	; 03802D1E
	bl loc_037FE244	; 03802D20
	ldr r0,[sp,#0x0]	; 03802D24
	ldr r1,[r0,#0x0]	; 03802D26
	cmp r1,#0x0	; 03802D28
	beq P2_Entry_03802D36	; 03802D2A
	cmp r1,#0x1	; 03802D2C
	beq P2_Entry_03802D42	; 03802D2E
	cmp r1,#0x3	; 03802D30
	beq P2_Entry_03802D3C	; 03802D32
	b P2_Entry_03802D1A	; 03802D34
P2_Entry_03802D36:
	bl P2_Entry_03803098	; 03802D36
	b P2_Entry_03802D1A	; 03802D3A
P2_Entry_03802D3C:
	bl P2_Entry_03804124	; 03802D3C
	b P2_Entry_03802D1A	; 03802D40
P2_Entry_03802D42:
	bl P2_Entry_03803954	; 03802D42
	b P2_Entry_03802D1A	; 03802D46
pool_03802D48:
	.word 0x03807710	; 03802D48

; ===== function loc_03802D4C =====
loc_03802D4C:
	push {r0,r1,r2,r3}	; 03802D4C
	push {r4,r5,r6,r7,lr}	; 03802D4E
	sub sp,#0x4	; 03802D50
	add r5,r0,#0x0	; 03802D52
	add r4,r1,#0x0	; 03802D54
	add r0,sp,#0x18	; 03802D56
	ldrh r0,[r0,#0x8]	; 03802D58
	cmp r0,#0x4	; 03802D5A
	bls loc_03802D62	; 03802D5C
	mov r0,#0x0	; 03802D5E
	b loc_03802DD2	; 03802D60
loc_03802D62:
	bl loc_037FDC9C	; 03802D62
	add r7,r0,#0x0	; 03802D66
	ldr r0,[pool_03802DDC]	; 03802D68
	ldr r1,[r0,#0x54]	; 03802D6A
	mov r0,#0x18	; 03802D6C
	mul r1,r0	; 03802D6E
	ldr r0,[pool_03802DE0]	; 03802D70
	str r5,[r0,r1]	; 03802D72
	ldr r0,[pool_03802DDC]	; 03802D74
	ldr r1,[r0,#0x54]	; 03802D76
	mov r0,#0x18	; 03802D78
	mul r1,r0	; 03802D7A
	ldr r0,[pool_03802DE4]	; 03802D7C
	str r4,[r0,r1]	; 03802D7E
	add r1,sp,#0x20	; 03802D80
	mov r0,#0x3	; 03802D82
	bic r1,r0	; 03802D84
	add r6,r1,#0x4	; 03802D86
	mov r5,#0x0	; 03802D88
	add r0,sp,#0x18	; 03802D8A
	ldrh r4,[r0,#0x8]	; 03802D8C
	b loc_03802DAC	; 03802D8E
loc_03802D90:
	add r6,r6,#0x4	; 03802D90
	sub r0,r6,#0x4	; 03802D92
	ldr r3,[r0,#0x0]	; 03802D94
	ldr r0,[pool_03802DDC]	; 03802D96
	ldr r2,[r0,#0x54]	; 03802D98
	mov r0,#0x18	; 03802D9A
	mul r2,r0	; 03802D9C
	lsl r1,r5,#0x2	; 03802D9E
	ldr r0,[pool_03802DE8]	; 03802DA0
	add r0,r0,r2	; 03802DA2
	add r1,r1,r0	; 03802DA4
	ldr r0,[pool_03802DEC]	; 03802DA6
	str r3,[r1,r0]	; 03802DA8
	add r5,r5,#0x1	; 03802DAA
loc_03802DAC:
	cmp r5,r4	; 03802DAC
	blt loc_03802D90	; 03802DAE
	ldr r1,[pool_03802DDC]	; 03802DB0
	ldr r4,[r1,#0x54]	; 03802DB2
	add r2,r4,#0x1	; 03802DB4
	mov r0,#0xf	; 03802DB6
	and r2,r0	; 03802DB8
	str r2,[r1,#0x54]	; 03802DBA
	add r0,r7,#0x0	; 03802DBC
	bl loc_037FDCC0	; 03802DBE
	ldr r0,[pool_03802DF0]	; 03802DC2
	ldr r2,[pool_03802DE0]	; 03802DC4
	mov r1,#0x18	; 03802DC6
	mul r4,r1	; 03802DC8
	add r1,r2,r4	; 03802DCA
	mov r2,#0x0	; 03802DCC
	bl loc_037FE2BC	; 03802DCE
loc_03802DD2:
	add sp,#0x4	; 03802DD2
	pop {r4,r5,r6,r7}	; 03802DD4
	pop {r3}	; 03802DD6
	add sp,#0x10	; 03802DD8
	bx r3	; 03802DDA
pool_03802DDC:
loc_03802DDC:
	.word P2_BssStart + 0x253C	; 03802DDC
pool_03802DE0:
loc_03802DE0:
	.word P2_BssStart + 0x2410	; 03802DE0
pool_03802DE4:
loc_03802DE4:
	.word P2_BssStart + 0x2414	; 03802DE4
pool_03802DE8:
loc_03802DE8:
	.word 0x03807490	; 03802DE8
pool_03802DEC:
loc_03802DEC:
	.word 0x000002DC	; 03802DEC
pool_03802DF0:
loc_03802DF0:
	.word 0x03807710	; 03802DF0

; ===== function loc_03802DF4 =====
P2_Entry_03802DF4:
	push {lr}	; 03802DF4
	sub sp,#0x4	; 03802DF6
	ldr r1,[pool_03802E14]	; 03802DF8
	ldr r2,[r1,#0x4]	; 03802DFA
	cmp r2,r0	; 03802DFC
	bne loc_03802E0E	; 03802DFE
	mov r0,#0x5	; 03802E00
	str r0,[r1,#0x4]	; 03802E02
	mov r0,#0x0	; 03802E04
	str r0,[r1,#0x0]	; 03802E06
	ldr r0,[pool_03802E18]	; 03802E08
	bl loc_037FDEC0	; 03802E0A
loc_03802E0E:
	add sp,#0x4	; 03802E0E
	pop {r3}	; 03802E10
	bx r3	; 03802E12
pool_03802E14:
loc_03802E14:
	.word P2_BssStart + 0x213C	; 03802E14
pool_03802E18:
loc_03802E18:
	.word 0x038078E8	; 03802E18

; ===== function loc_03802E1C =====
loc_03802E1C:
	mov r2,#0x1	; 03802E1C
	ldr r1,[pool_03802E28]	; 03802E1E
	str r2,[r1,#0x0]	; 03802E20
	str r0,[r1,#0x4]	; 03802E22
	bx lr	; 03802E24
	.byte 0xC0, 0x46	; 03802E28
pool_03802E28:
loc_03802E28:
	.word P2_BssStart + 0x213C	; 03802E28
P2_Entry_03802E2C:
	ldr r0,[pool_03802E3C]	; 03802E2C
	ldr r0,[r0,#0x0]	; 03802E2E
	cmp r0,#0x0	; 03802E30
	bne P2_Entry_03802E38	; 03802E32
	mov r0,#0x1	; 03802E34
	bx lr	; 03802E36
P2_Entry_03802E38:
	mov r0,#0x0	; 03802E38
	bx lr	; 03802E3A
pool_03802E3C:
	.word P2_BssStart + 0x213C	; 03802E3C

; ===== function loc_03802E40 =====
loc_03802E40:
	push {r4,r5,r6,lr}	; 03802E40
	mov r2,#0x70	; 03802E42
	add r3,r0,#0x0	; 03802E44
	and r3,r2	; 03802E46
	cmp r3,#0x20	; 03802E48
	bgt loc_03802E60	; 03802E4A
	cmp r3,#0x20	; 03802E4C
	bge loc_03802E7C	; 03802E4E
	cmp r3,#0x0	; 03802E50
	bgt loc_03802E5A	; 03802E52
	cmp r3,#0x0	; 03802E54
	beq loc_03802E74	; 03802E56
	b loc_03802E7E	; 03802E58
loc_03802E5A:
	cmp r3,#0x10	; 03802E5A
	beq loc_03802E74	; 03802E5C
	b loc_03802E7E	; 03802E5E
loc_03802E60:
	cmp r3,#0x60	; 03802E60
	bgt loc_03802E6E	; 03802E62
	cmp r3,#0x60	; 03802E64
	bge loc_03802E78	; 03802E66
	cmp r3,#0x30	; 03802E68
	beq loc_03802E7C	; 03802E6A
	b loc_03802E7E	; 03802E6C
loc_03802E6E:
	cmp r3,#0x70	; 03802E6E
	beq loc_03802E78	; 03802E70
	b loc_03802E7E	; 03802E72
loc_03802E74:
	mov r5,#0x6	; 03802E74
	b loc_03802E7E	; 03802E76
loc_03802E78:
	mov r5,#0x8	; 03802E78
	b loc_03802E7E	; 03802E7A
loc_03802E7C:
	mov r5,#0x4	; 03802E7C
loc_03802E7E:
	mov r3,#0xff	; 03802E7E
	and r0,r3	; 03802E80
	mov r2,#0x80	; 03802E82
	orr r0,r2	; 03802E84
	lsl r4,r0,#0x8	; 03802E86
	ldr r0,[pool_03802EA8]	; 03802E88
	orr r4,r0	; 03802E8A
	and r1,r3	; 03802E8C
	orr r4,r1	; 03802E8E
	mov r6,#0x0	; 03802E90
loc_03802E92:
	add r0,r5,#0x0	; 03802E92
	add r1,r4,#0x0	; 03802E94
	add r2,r6,#0x0	; 03802E96
	bl loc_03801EEC	; 03802E98
	cmp r0,#0x0	; 03802E9C
	blt loc_03802E92	; 03802E9E
	pop {r4,r5,r6}	; 03802EA0
	pop {r3}	; 03802EA2
	bx r3	; 03802EA4
	.byte 0xC0, 0x46	; 03802EA8
pool_03802EA8:
loc_03802EA8:
	.word 0x03000000	; 03802EA8

; ===== function loc_03802EAC =====
loc_03802EAC:
	push {lr}	; 03802EAC
	sub sp,#0x4	; 03802EAE
	ldr r1,[pool_03802EE8]	; 03802EB0
	ldr r2,[r1,#0x0]	; 03802EB2
	cmp r2,#0x0	; 03802EB4
	beq loc_03802EE2	; 03802EB6
	ldr r1,[r1,#0x4]	; 03802EB8
	cmp r1,#0x4	; 03802EBA
	bne loc_03802EE2	; 03802EBC
	ldr r1,[pool_03802EEC]	; 03802EBE
	ldr r1,[r1,#0x5c]	; 03802EC0
	cmp r1,r0	; 03802EC2
	bne loc_03802EE2	; 03802EC4
	bl loc_037FDC9C	; 03802EC6
	mov r2,#0x5	; 03802ECA
	ldr r1,[pool_03802EE8]	; 03802ECC
	str r2,[r1,#0x4]	; 03802ECE
	mov r2,#0x0	; 03802ED0
	str r2,[r1,#0x0]	; 03802ED2
	ldr r1,[pool_03802EEC]	; 03802ED4
	str r2,[r1,#0x5c]	; 03802ED6
	bl loc_037FDCC0	; 03802ED8
	ldr r0,[pool_03802EF0]	; 03802EDC
	bl loc_037FDEC0	; 03802EDE
loc_03802EE2:
	add sp,#0x4	; 03802EE2
	pop {r3}	; 03802EE4
	bx r3	; 03802EE6
pool_03802EE8:
loc_03802EE8:
	.word P2_BssStart + 0x213C	; 03802EE8
pool_03802EEC:
loc_03802EEC:
	.word P2_BssStart + 0x253C	; 03802EEC
pool_03802EF0:
loc_03802EF0:
	.word 0x038078E8	; 03802EF0

; ===== function loc_03802EF4 =====
loc_03802EF4:
	push {r4,r5,r6,r7,lr}	; 03802EF4
	sub sp,#0x4	; 03802EF6
	add r5,r0,#0x0	; 03802EF8
	ldr r7,[pool_03802F30]	; 03802EFA
	ldr r6,[pool_03802F34]	; 03802EFC
loc_03802EFE:
	bl loc_037FDC9C	; 03802EFE
	add r4,r0,#0x0	; 03802F02
	ldr r1,[r6,#0x0]	; 03802F04
	cmp r1,#0x0	; 03802F06
	beq loc_03802F16	; 03802F08
	bl loc_037FDCC0	; 03802F0A
	add r0,r7,#0x0	; 03802F0E
	bl loc_037FDF08	; 03802F10
	b loc_03802EFE	; 03802F14
loc_03802F16:
	mov r0,#0x4	; 03802F16
	bl loc_03802E1C	; 03802F18
	ldr r0,[pool_03802F38]	; 03802F1C
	str r5,[r0,#0x5c]	; 03802F1E
	add r0,r4,#0x0	; 03802F20
	bl loc_037FDCC0	; 03802F22
	add sp,#0x4	; 03802F26
	pop {r4,r5,r6,r7}	; 03802F28
	pop {r3}	; 03802F2A
	bx r3	; 03802F2C
	.byte 0xC0, 0x46	; 03802F30
pool_03802F30:
loc_03802F30:
	.word 0x038078E8	; 03802F30
pool_03802F34:
loc_03802F34:
	.word 0x03807490	; 03802F34
pool_03802F38:
loc_03802F38:
	.word P2_BssStart + 0x253C	; 03802F38

; ===== function loc_03802F3C =====
loc_03802F3C:
	push {r4,r5,r6,r7,lr}	; 03802F3C
	sub sp,#0xc	; 03802F3E
	add r5,r0,#0x0	; 03802F40
	ldr r0,[pool_03802FD0]	; 03802F42
	ldrh r1,[r0,#0x0]	; 03802F44
	cmp r1,#0x0	; 03802F46
	bne loc_03802FC6	; 03802F48
	mov r1,#0x1	; 03802F4A
	strh r1,[r0,#0x0]	; 03802F4C
	mov r1,#0x0	; 03802F4E
	ldr r0,[pool_03802FD4]	; 03802F50
	str r1,[r0,#0x0]	; 03802F52
	mov r1,#0x5	; 03802F54
	str r1,[r0,#0x4]	; 03802F56
	bl loc_0380333C	; 03802F58
	bl loc_03803BE0	; 03802F5C
	bl loc_03804368	; 03802F60
	bl loc_03801E0C	; 03802F64
	mov r0,#0x6	; 03802F68
	ldr r1,[pool_03802FD8]	; 03802F6A
	bl P2_SetPxiReceiveCallback	; 03802F6C
	mov r0,#0x8	; 03802F70
	ldr r1,[pool_03802FD8]	; 03802F72
	bl P2_SetPxiReceiveCallback	; 03802F74
	mov r0,#0x4	; 03802F78
	ldr r1,[pool_03802FD8]	; 03802F7A
	bl P2_SetPxiReceiveCallback	; 03802F7C
	ldr r0,[pool_03802FDC]	; 03802F80
	ldr r1,[pool_03802FE0]	; 03802F82
	mov r2,#0x10	; 03802F84
	bl loc_037FE318	; 03802F86
	mov r4,#0x0	; 03802F8A
	ldr r7,[pool_03802FE4]	; 03802F8C
	add r6,r4,#0x0	; 03802F8E
loc_03802F90:
	add r1,r4,#0x0	; 03802F90
	mov r0,#0x18	; 03802F92
	mul r1,r0	; 03802F94
	add r0,r7,r1	; 03802F96
	add r1,r6,#0x0	; 03802F98
	mov r2,#0x18	; 03802F9A
	bl loc_03802FFC	; 03802F9C
	add r4,r4,#0x1	; 03802FA0
	cmp r4,#0x10	; 03802FA2
	blt loc_03802F90	; 03802FA4
	mov r2,#0x0	; 03802FA6
	ldr r0,[pool_03802FE8]	; 03802FA8
	str r2,[r0,#0x54]	; 03802FAA
	ldr r0,[pool_03802FEC]	; 03802FAC
	strh r2,[r0,#0x18]	; 03802FAE
	ldr r0,[pool_03802FF0]	; 03802FB0
	str r0,[sp,#0x0]	; 03802FB2
	str r5,[sp,#0x4]	; 03802FB4
	ldr r0,[pool_03802FF4]	; 03802FB6
	ldr r1,[pool_03802FF8]	; 03802FB8
	ldr r3,[pool_03802FDC]	; 03802FBA
	bl P2_CreateThread	; 03802FBC
	ldr r0,[pool_03802FF4]	; 03802FC0
	bl loc_037FDE9C	; 03802FC2
loc_03802FC6:
	add sp,#0xc	; 03802FC6
	pop {r4,r5,r6,r7}	; 03802FC8
	pop {r3}	; 03802FCA
	bx r3	; 03802FCC
	.byte 0xC0, 0x46	; 03802FD0
pool_03802FD0:
loc_03802FD0:
	.word P2_BssStart + 0x2138	; 03802FD0
pool_03802FD4:
loc_03802FD4:
	.word P2_BssStart + 0x213C	; 03802FD4
pool_03802FD8:
loc_03802FD8:
	.word P2_PxiCallback_03802CDC + 1	; 03802FD8
pool_03802FDC:
loc_03802FDC:
	.word 0x03807710	; 03802FDC
pool_03802FE0:
loc_03802FE0:
	.word 0x03807724	; 03802FE0
pool_03802FE4:
loc_03802FE4:
	.word 0x03807764	; 03802FE4
pool_03802FE8:
loc_03802FE8:
	.word P2_BssStart + 0x253C	; 03802FE8
pool_03802FEC:
loc_03802FEC:
	.word P2_BssStart + 0x257C	; 03802FEC
pool_03802FF0:
loc_03802FF0:
	.word 0x00000200	; 03802FF0
pool_03802FF4:
loc_03802FF4:
	.word 0x03807498	; 03802FF4
pool_03802FF8:
loc_03802FF8:
	.word P2_ThreadEntry_03802D10 + 1	; 03802FF8

; ===== function loc_03802FFC =====
loc_03802FFC:
	bx pc	; 03802FFC
	.byte 0xC0, 0x46	; 03803000
.arm

; ===== function loc_03803000 =====
loc_03803000:
	ldr pc,[pool_03803004]	; 03803000
pool_03803004:
loc_03803004:
	.word loc_037FF384	; 03803004
.thumb

; ===== function loc_03803008 =====
loc_03803008:
	push {lr}	; 03803008
	sub sp,#0x4	; 0380300A
	cmp r0,#0x0	; 0380300C
	bne loc_0380301A	; 0380300E
	mov r0,#0x3	; 03803010
	mov r1,#0x2	; 03803012
	bl loc_03802E40	; 03803014
	b loc_03803036	; 03803018
loc_0380301A:
	cmp r1,#0x0	; 0380301A
	bne loc_03803028	; 0380301C
	mov r0,#0x3	; 0380301E
	mov r1,#0x2	; 03803020
	bl loc_03802E40	; 03803022
	b loc_03803036	; 03803026
loc_03803028:
	ldr r2,[pool_0380303C]	; 03803028
	str r0,[r2,#0x24]	; 0380302A
	str r1,[r2,#0x28]	; 0380302C
	mov r0,#0x3	; 0380302E
	mov r1,#0x0	; 03803030
	bl loc_03802E40	; 03803032
loc_03803036:
	add sp,#0x4	; 03803036
	pop {r3}	; 03803038
	bx r3	; 0380303A
pool_0380303C:
loc_0380303C:
	.word P2_BssStart + 0x259C	; 0380303C

; ===== function loc_03803040 =====
	push {r4,lr}	; 03803040
	sub sp,#0x8	; 03803042
	add r4,r0,#0x0	; 03803044
	mov r0,#0x0	; 03803046
	mov r1,#0x10	; 03803048
	mov r2,#0x1	; 0380304A
	add r3,r4,#0x0	; 0380304C
	bl loc_03802D4C	; 0380304E
	cmp r0,#0x0	; 03803052
	bne loc_0380307E	; 03803054
	ldr r1,[sp,#0x0]	; 03803056
	ldr r0,[pool_03803088]	; 03803058
	and r1,r0	; 0380305A
	ldr r0,[pool_0380308C]	; 0380305C
	orr r1,r0	; 0380305E
	str r1,[sp,#0x0]	; 03803060
	add r0,sp,#0x0	; 03803062
	ldrh r2,[r0,#0x0]	; 03803064
	ldr r1,[pool_03803090]	; 03803066
	strh r2,[r1,#0x0]	; 03803068
	ldrh r1,[r0,#0x2]	; 0380306A
	ldr r0,[pool_03803094]	; 0380306C
	strh r1,[r0,#0x0]	; 0380306E
	mov r0,#0x10	; 03803070
	mov r1,#0xff	; 03803072
	and r4,r1	; 03803074
	lsl r1,r4,#0x10	; 03803076
	lsr r1,r1,#0x10	; 03803078
	bl loc_03802E40	; 0380307A
loc_0380307E:
	add sp,#0x8	; 0380307E
	pop {r4}	; 03803080
	pop {r3}	; 03803082
	bx r3	; 03803084
	.byte 0xC0, 0x46	; 03803088
pool_03803088:
loc_03803088:
	.word 0xF9FFFFFF	; 03803088
pool_0380308C:
loc_0380308C:
	.word 0x06000000	; 0380308C
pool_03803090:
loc_03803090:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 03803090
pool_03803094:
loc_03803094:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 03803094
P2_Entry_03803098:
	push {r4,r5,r6,r7,lr}	; 03803098
	sub sp,#0xc	; 0380309A
	add r5,r0,#0x0	; 0380309C
	ldr r1,[r5,#0x4]	; 0380309E
	cmp r1,#0x2	; 038030A0
	bhi P2_Entry_038030B2	; 038030A2
	cmp r1,#0x0	; 038030A4
	beq P2_Entry_038030C2	; 038030A6
	cmp r1,#0x1	; 038030A8
	beq P2_Entry_03803138	; 038030AA
	cmp r1,#0x2	; 038030AC
	beq P2_Entry_038031A6	; 038030AE
	b P2_Entry_038031D2	; 038030B0
P2_Entry_038030B2:
	cmp r1,#0x10	; 038030B2
	beq P2_Entry_038030B8	; 038030B4
	b P2_Entry_038031D2	; 038030B6
P2_Entry_038030B8:
	ldr r0,[pool_038031DC]	; 038030B8
	ldr r0,[r0,#0x20]	; 038030BA
	cmp r0,#0x2	; 038030BC
	beq P2_Entry_038030C2	; 038030BE
	b P2_Entry_038031D2	; 038030C0
P2_Entry_038030C2:
	bl loc_037FDC9C	; 038030C2
	add r4,r0,#0x0	; 038030C6
	mov r0,#0x0	; 038030C8
	bl P2_Entry_03802E2C	; 038030CA
	cmp r0,#0x0	; 038030CE
	bne P2_Entry_038030E6	; 038030D0
	add r0,r4,#0x0	; 038030D2
	bl loc_037FDCC0	; 038030D4
	ldr r0,[r5,#0x4]	; 038030D8
	lsl r0,r0,#0x10	; 038030DA
	lsr r0,r0,#0x10	; 038030DC
	mov r1,#0x4	; 038030DE
	bl loc_03802E40	; 038030E0
	b P2_Entry_038031D2	; 038030E4
P2_Entry_038030E6:
	mov r0,#0x0	; 038030E6
	bl loc_03802E1C	; 038030E8
	add r0,r4,#0x0	; 038030EC
	bl loc_037FDCC0	; 038030EE
	add r0,sp,#0x4	; 038030F2
	ldr r2,[pool_038031DC]	; 038030F4
	ldr r1,[r2,#0x28]	; 038030F6
	ldr r2,[r2,#0x24]	; 038030F8
	bl P2_Entry_0380341C	; 038030FA
	add r0,sp,#0x4	; 038030FE
	ldrh r2,[r0,#0x0]	; 03803100
	ldr r1,[pool_038031E0]	; 03803102
	strh r2,[r1,#0x0]	; 03803104
	ldrh r1,[r0,#0x2]	; 03803106
	ldr r0,[pool_038031E4]	; 03803108
	strh r1,[r0,#0x0]	; 0380310A
	ldr r0,[r5,#0x4]	; 0380310C
	cmp r0,#0x0	; 0380310E
	bne P2_Entry_0380311E	; 03803110
	lsl r0,r0,#0x10	; 03803112
	lsr r0,r0,#0x10	; 03803114
	mov r1,#0x0	; 03803116
	bl loc_03802E40	; 03803118
	b P2_Entry_03803130	; 0380311C
P2_Entry_0380311E:
	lsl r0,r0,#0x10	; 0380311E
	lsr r0,r0,#0x10	; 03803120
	ldr r2,[r5,#0x8]	; 03803122
	mov r1,#0xff	; 03803124
	and r2,r1	; 03803126
	lsl r1,r2,#0x10	; 03803128
	lsr r1,r1,#0x10	; 0380312A
	bl loc_03802E40	; 0380312C
P2_Entry_03803130:
	mov r0,#0x0	; 03803130
	bl P2_Entry_03802DF4	; 03803132
	b P2_Entry_038031D2	; 03803136
P2_Entry_03803138:
	ldr r0,[pool_038031DC]	; 03803138
	ldr r0,[r0,#0x20]	; 0380313A
	cmp r0,#0x1	; 0380313C
	bne P2_Entry_0380319A	; 0380313E
	mov r4,#0x0	; 03803140
	add r7,r4,#0x0	; 03803142
	b P2_Entry_03803180	; 03803144
P2_Entry_03803146:
	lsl r2,r4,#0x1	; 03803146
	ldr r0,[pool_038031DC]	; 03803148
	add r6,r0,r2	; 0380314A
	add r0,r4,#0x0	; 0380314C
	ldr r2,[pool_038031E8]	; 0380314E
	mul r0,r2	; 03803150
	bl loc_038031F8	; 03803152
	ldr r1,[r5,#0xc]	; 03803156
	add r0,r1,r0	; 03803158
	ldr r1,[pool_038031E8]	; 0380315A
	bl loc_038031F8	; 0380315C
	add r0,r6,#0x0	; 03803160
	add r0,#0xcc	; 03803162
	strh r1,[r0,#0x0]	; 03803164
	str r4,[sp,#0x0]	; 03803166
	add r1,r4,#0x0	; 03803168
	mov r0,#0x28	; 0380316A
	mul r1,r0	; 0380316C
	ldr r0,[pool_038031EC]	; 0380316E
	add r0,r0,r1	; 03803170
	mov r1,#0xcc	; 03803172
	ldrsh r1,[r6,r1]	; 03803174
	add r2,r7,#0x0	; 03803176
	ldr r3,[pool_038031F0]	; 03803178
	bl P2_Entry_037FEEF8	; 0380317A
	add r4,r4,#0x1	; 0380317E
P2_Entry_03803180:
	ldr r1,[r5,#0x8]	; 03803180
	cmp r4,r1	; 03803182
	bcc P2_Entry_03803146	; 03803184
	ldr r0,[r5,#0x4]	; 03803186
	lsl r0,r0,#0x10	; 03803188
	lsr r0,r0,#0x10	; 0380318A
	mov r1,#0x0	; 0380318C
	bl loc_03802E40	; 0380318E
	mov r1,#0x2	; 03803192
	ldr r0,[pool_038031DC]	; 03803194
	str r1,[r0,#0x20]	; 03803196
	b P2_Entry_038031D2	; 03803198
P2_Entry_0380319A:
	lsl r0,r1,#0x10	; 0380319A
	lsr r0,r0,#0x10	; 0380319C
	mov r1,#0x3	; 0380319E
	bl loc_03802E40	; 038031A0
	b P2_Entry_038031D2	; 038031A4
P2_Entry_038031A6:
	ldr r0,[pool_038031DC]	; 038031A6
	ldr r0,[r0,#0x20]	; 038031A8
	cmp r0,#0x3	; 038031AA
	bne P2_Entry_038031C8	; 038031AC
	ldr r0,[pool_038031F4]	; 038031AE
	bl P2_Entry_037FEE04	; 038031B0
	ldr r0,[r5,#0x4]	; 038031B4
	lsl r0,r0,#0x10	; 038031B6
	lsr r0,r0,#0x10	; 038031B8
	mov r1,#0x0	; 038031BA
	bl loc_03802E40	; 038031BC
	mov r1,#0x0	; 038031C0
	ldr r0,[pool_038031DC]	; 038031C2
	str r1,[r0,#0x20]	; 038031C4
	b P2_Entry_038031D2	; 038031C6
P2_Entry_038031C8:
	lsl r0,r1,#0x10	; 038031C8
	lsr r0,r0,#0x10	; 038031CA
	mov r1,#0x3	; 038031CC
	bl loc_03802E40	; 038031CE
P2_Entry_038031D2:
	add sp,#0xc	; 038031D2
	pop {r4,r5,r6,r7}	; 038031D4
	pop {r3}	; 038031D6
	bx r3	; 038031D8
	.byte 0xC0, 0x46	; 038031DA
pool_038031DC:
	.word P2_BssStart + 0x259C	; 038031DC
pool_038031E0:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 038031E0
pool_038031E4:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 2	; 038031E4
pool_038031E8:
	.word 0x00000107	; 038031E8
pool_038031EC:
	.word 0x0380791C	; 038031EC
pool_038031F0:
	.word 0x03803041	; 038031F0
pool_038031F4:
	.word 0x54505641	; 038031F4

; ===== function loc_038031F8 =====
loc_038031F8:
	bx pc	; 038031F8
	.byte 0xC0, 0x46	; 038031FC
.arm

; ===== function loc_038031FC =====
loc_038031FC:
	ldr pc,[pool_03803200]	; 038031FC
pool_03803200:
loc_03803200:
	.word loc_03804D6C	; 03803200
.thumb

; ===== function loc_03803204 =====
loc_03803204:
	push {r4,lr}	; 03803204
	sub sp,#0x8	; 03803206
	ldr r1,[pool_03803324]	; 03803208
	add r2,r0,#0x0	; 0380320A
	and r2,r1	; 0380320C
	cmp r2,#0x0	; 0380320E
	beq loc_03803222	; 03803210
	mov r4,#0x0	; 03803212
	add r3,r4,#0x0	; 03803214
	ldr r1,[pool_03803328]	; 03803216
loc_03803218:
	lsl r2,r4,#0x1	; 03803218
	strh r3,[r1,r2]	; 0380321A
	add r4,r4,#0x1	; 0380321C
	cmp r4,#0x10	; 0380321E
	blt loc_03803218	; 03803220
loc_03803222:
	ldr r1,[pool_0380332C]	; 03803222
	add r2,r0,#0x0	; 03803224
	and r2,r1	; 03803226
	lsr r1,r2,#0x10	; 03803228
	lsl r2,r1,#0x1	; 0380322A
	ldr r1,[pool_03803328]	; 0380322C
	strh r0,[r1,r2]	; 0380322E
	ldr r2,[pool_03803330]	; 03803230
	and r0,r2	; 03803232
	cmp r0,#0x0	; 03803234
	beq loc_0380331C	; 03803236
	ldrh r0,[r1,#0x0]	; 03803238
	ldr r2,[pool_03803334]	; 0380323A
	add r3,r0,#0x0	; 0380323C
	and r3,r2	; 0380323E
	lsl r2,r3,#0x8	; 03803240
	lsr r4,r2,#0x10	; 03803242
	cmp r4,#0x3	; 03803244
	bhi loc_03803314	; 03803246
	add r2,r4,r4	; 03803248
P2_SwitchIndexPC_03803248:
	add r2,pc	; 0380324A
	ldrh r2,[r2,#(P2_SwitchTable_03803248 - (P2_SwitchIndexPC_03803248 + 4))]	; 0380324C
	lsl r2,r2,#0x10	; 0380324E
	asr r2,r2,#0x10	; 03803250
P2_SwitchTargetPC_03803248:
	add r2,pc	; 03803252
	bx r2	; 03803254
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803248:
	.halfword (loc_0380326E + 1) - (P2_SwitchTargetPC_03803248 + 4)
	.halfword (loc_03803286 + 1) - (P2_SwitchTargetPC_03803248 + 4)
	.halfword (loc_038032E4 + 1) - (P2_SwitchTargetPC_03803248 + 4)
	.halfword (loc_0380325E + 1) - (P2_SwitchTargetPC_03803248 + 4)
P2_SwitchTable_03803248End:
loc_0380325E:
	mov r2,#0xff	; 0380325E
	and r0,r2	; 03803260
	lsl r0,r0,#0x10	; 03803262
	lsr r0,r0,#0x10	; 03803264
	ldrh r1,[r1,#0x2]	; 03803266
	bl loc_03803008	; 03803268
	b loc_0380331C	; 0380326C
loc_0380326E:
	mov r0,#0x0	; 0380326E
	add r1,r4,#0x0	; 03803270
	add r2,r0,#0x0	; 03803272
	bl loc_03802D4C	; 03803274
	cmp r0,#0x0	; 03803278
	bne loc_0380331C	; 0380327A
	add r0,r4,#0x0	; 0380327C
	mov r1,#0x4	; 0380327E
	bl loc_03802E40	; 03803280
	b loc_0380331C	; 03803284
loc_03803286:
	ldr r2,[r1,#0x20]	; 03803286
	cmp r2,#0x0	; 03803288
	beq loc_03803296	; 0380328A
	add r0,r4,#0x0	; 0380328C
	mov r1,#0x3	; 0380328E
	bl loc_03802E40	; 03803290
	b loc_0380331C	; 03803294
loc_03803296:
	mov r2,#0xff	; 03803296
	and r0,r2	; 03803298
	lsl r0,r0,#0x10	; 0380329A
	lsr r3,r0,#0x10	; 0380329C
	cmp r3,#0x0	; 0380329E
	beq loc_038032A6	; 038032A0
	cmp r3,#0x4	; 038032A2
	bls loc_038032B0	; 038032A4
loc_038032A6:
	add r0,r4,#0x0	; 038032A6
	mov r1,#0x2	; 038032A8
	bl loc_03802E40	; 038032AA
	b loc_0380331C	; 038032AE
loc_038032B0:
	ldrh r1,[r1,#0x2]	; 038032B0
	ldr r0,[pool_03803338]	; 038032B2
	cmp r1,r0	; 038032B4
	bcc loc_038032C2	; 038032B6
	add r0,r4,#0x0	; 038032B8
	mov r1,#0x2	; 038032BA
	bl loc_03802E40	; 038032BC
	b loc_0380331C	; 038032C0
loc_038032C2:
	str r1,[sp,#0x0]	; 038032C2
	mov r0,#0x0	; 038032C4
	add r1,r4,#0x0	; 038032C6
	mov r2,#0x2	; 038032C8
	bl loc_03802D4C	; 038032CA
	cmp r0,#0x0	; 038032CE
	bne loc_038032DC	; 038032D0
	add r0,r4,#0x0	; 038032D2
	mov r1,#0x4	; 038032D4
	bl loc_03802E40	; 038032D6
	b loc_0380331C	; 038032DA
loc_038032DC:
	mov r1,#0x1	; 038032DC
	ldr r0,[pool_03803328]	; 038032DE
	str r1,[r0,#0x20]	; 038032E0
	b loc_0380331C	; 038032E2
loc_038032E4:
	ldr r0,[r1,#0x20]	; 038032E4
	cmp r0,#0x2	; 038032E6
	beq loc_038032F4	; 038032E8
	add r0,r4,#0x0	; 038032EA
	mov r1,#0x3	; 038032EC
	bl loc_03802E40	; 038032EE
	b loc_0380331C	; 038032F2
loc_038032F4:
	mov r0,#0x0	; 038032F4
	add r1,r4,#0x0	; 038032F6
	add r2,r0,#0x0	; 038032F8
	bl loc_03802D4C	; 038032FA
	cmp r0,#0x0	; 038032FE
	bne loc_0380330C	; 03803300
	add r0,r4,#0x0	; 03803302
	mov r1,#0x4	; 03803304
	bl loc_03802E40	; 03803306
	b loc_0380331C	; 0380330A
loc_0380330C:
	mov r1,#0x3	; 0380330C
	ldr r0,[pool_03803328]	; 0380330E
	str r1,[r0,#0x20]	; 03803310
	b loc_0380331C	; 03803312
loc_03803314:
	add r0,r4,#0x0	; 03803314
	mov r1,#0x1	; 03803316
	bl loc_03802E40	; 03803318
loc_0380331C:
	add sp,#0x8	; 0380331C
	pop {r4}	; 0380331E
	pop {r3}	; 03803320
	bx r3	; 03803322
pool_03803324:
loc_03803324:
	.word 0x02000000	; 03803324
pool_03803328:
loc_03803328:
	.word P2_BssStart + 0x259C	; 03803328
pool_0380332C:
loc_0380332C:
	.word 0x000F0000	; 0380332C
pool_03803330:
loc_03803330:
	.word 0x01000000	; 03803330
pool_03803334:
loc_03803334:
	.word 0x0000FF00	; 03803334
pool_03803338:
loc_03803338:
	.word 0x00000107	; 03803338

; ===== function loc_0380333C =====
loc_0380333C:
	push {r4,r5,r6,r7,lr}	; 0380333C
	sub sp,#0x4	; 0380333E
	mov r3,#0x0	; 03803340
	ldr r0,[pool_03803400]	; 03803342
	str r3,[r0,#0x20]	; 03803344
	mov r1,#0x1e	; 03803346
	str r1,[r0,#0x28]	; 03803348
	mov r1,#0x5	; 0380334A
	str r1,[r0,#0x24]	; 0380334C
	add r2,r3,#0x0	; 0380334E
loc_03803350:
	lsl r1,r3,#0x1	; 03803350
	strh r2,[r0,r1]	; 03803352
	add r3,r3,#0x1	; 03803354
	cmp r3,#0x10	; 03803356
	blt loc_03803350	; 03803358
	bl loc_037FF060	; 0380335A
	cmp r0,#0x0	; 0380335E
	bne loc_03803366	; 03803360
	bl loc_037FF06C	; 03803362
loc_03803366:
	mov r4,#0x0	; 03803366
	ldr r6,[pool_03803404]	; 03803368
	mov r7,#0x28	; 0380336A
loc_0380336C:
	add r0,r4,#0x0	; 0380336C
	mul r0,r7	; 0380336E
	add r5,r6,r0	; 03803370
	add r0,r5,#0x0	; 03803372
	bl loc_037FEFB8	; 03803374
	add r0,r5,#0x0	; 03803378
	ldr r1,[pool_03803408]	; 0380337A
	bl loc_037FEE8C	; 0380337C
	add r4,r4,#0x1	; 03803380
	cmp r4,#0x4	; 03803382
	blt loc_0380336C	; 03803384
	mov r6,#0x1	; 03803386
	ldr r5,[pool_0380340C]	; 03803388
	mov r4,#0x80	; 0380338A
	b loc_03803394	; 0380338C
loc_0380338E:
	add r0,r6,#0x0	; 0380338E
	bl loc_03804890	; 03803390
loc_03803394:
	ldrh r0,[r5,#0x0]	; 03803394
	and r0,r4	; 03803396
	cmp r0,#0x0	; 03803398
	bne loc_0380338E	; 0380339A
	ldr r0,[pool_03803410]	; 0380339C
	strh r0,[r5,#0x0]	; 0380339E
	mov r1,#0x84	; 038033A0
	ldr r0,[pool_03803414]	; 038033A2
	strh r1,[r0,#0x0]	; 038033A4
	mov r6,#0x1	; 038033A6
	ldr r5,[pool_0380340C]	; 038033A8
	mov r4,#0x80	; 038033AA
	b loc_038033B4	; 038033AC
loc_038033AE:
	add r0,r6,#0x0	; 038033AE
	bl loc_03804890	; 038033B0
loc_038033B4:
	ldrh r0,[r5,#0x0]	; 038033B4
	and r0,r4	; 038033B6
	cmp r0,#0x0	; 038033B8
	bne loc_038033AE	; 038033BA
	mov r1,#0x0	; 038033BC
	ldr r0,[pool_03803414]	; 038033BE
	strh r1,[r0,#0x0]	; 038033C0
	mov r6,#0x1	; 038033C2
	ldr r5,[pool_0380340C]	; 038033C4
	mov r4,#0x80	; 038033C6
	b loc_038033D0	; 038033C8
loc_038033CA:
	add r0,r6,#0x0	; 038033CA
	bl loc_03804890	; 038033CC
loc_038033D0:
	ldrh r0,[r5,#0x0]	; 038033D0
	and r0,r4	; 038033D2
	cmp r0,#0x0	; 038033D4
	bne loc_038033CA	; 038033D6
	ldr r0,[pool_03803418]	; 038033D8
	strh r0,[r5,#0x0]	; 038033DA
	mov r1,#0x0	; 038033DC
	ldr r0,[pool_03803414]	; 038033DE
	strh r1,[r0,#0x0]	; 038033E0
	mov r6,#0x1	; 038033E2
	ldr r5,[pool_0380340C]	; 038033E4
	mov r4,#0x80	; 038033E6
	b loc_038033F0	; 038033E8
loc_038033EA:
	add r0,r6,#0x0	; 038033EA
	bl loc_03804890	; 038033EC
loc_038033F0:
	ldrh r0,[r5,#0x0]	; 038033F0
	and r0,r4	; 038033F2
	cmp r0,#0x0	; 038033F4
	bne loc_038033EA	; 038033F6
	add sp,#0x4	; 038033F8
	pop {r4,r5,r6,r7}	; 038033FA
	pop {r3}	; 038033FC
	bx r3	; 038033FE
pool_03803400:
loc_03803400:
	.word P2_BssStart + 0x259C	; 03803400
pool_03803404:
loc_03803404:
	.word 0x0380791C	; 03803404
pool_03803408:
loc_03803408:
	.word 0x54505641	; 03803408
pool_0380340C:
loc_0380340C:
	.word REG_SPICNT	; 0380340C
pool_03803410:
loc_03803410:
	.word 0x00008A01	; 03803410
pool_03803414:
loc_03803414:
	.word REG_SPIDATA	; 03803414
pool_03803418:
loc_03803418:
	.word 0x00008201	; 03803418

; ===== function loc_0380341C =====
P2_Entry_0380341C:
	push {r4,r5,r6,r7,lr}	; 0380341C
	sub sp,#0x4	; 0380341E
	add r5,r0,#0x0	; 03803420
	add r4,r1,#0x0	; 03803422
	add r6,r2,#0x0	; 03803424
	cmp r4,#0x0	; 03803426
	bge loc_0380342C	; 03803428
	neg r4,r4	; 0380342A
loc_0380342C:
	bl loc_038037D0	; 0380342C
	add r7,r0,#0x0	; 03803430
	cmp r7,#0x0	; 03803432
	bne loc_03803462	; 03803434
	ldr r1,[r5,#0x0]	; 03803436
	ldr r0,[pool_03803584]	; 03803438
	and r1,r0	; 0380343A
	str r1,[r5,#0x0]	; 0380343C
	ldr r1,[r5,#0x0]	; 0380343E
	ldr r0,[pool_03803588]	; 03803440
	and r1,r0	; 03803442
	str r1,[r5,#0x0]	; 03803444
	ldr r1,[r5,#0x0]	; 03803446
	ldr r0,[pool_0380358C]	; 03803448
	and r1,r0	; 0380344A
	str r1,[r5,#0x0]	; 0380344C
	ldr r1,[r5,#0x0]	; 0380344E
	ldr r0,[pool_03803590]	; 03803450
	and r1,r0	; 03803452
	ldr r0,[pool_03803594]	; 03803454
	orr r1,r0	; 03803456
	str r1,[r5,#0x0]	; 03803458
	mov r1,#0x0	; 0380345A
	ldr r0,[pool_03803598]	; 0380345C
	strh r1,[r0,#0x0]	; 0380345E
	b loc_0380357C	; 03803460
loc_03803462:
	add r0,sp,#0x0	; 03803462
	add r1,r4,#0x0	; 03803464
	add r2,r6,#0x0	; 03803466
	mov r3,#0x0	; 03803468
	bl loc_038035B8	; 0380346A
	ldr r1,[r5,#0x0]	; 0380346E
	ldr r2,[pool_03803590]	; 03803470
	and r1,r2	; 03803472
	mov r2,#0x3	; 03803474
	and r0,r2	; 03803476
	lsl r0,r0,#0x19	; 03803478
	orr r1,r0	; 0380347A
	str r1,[r5,#0x0]	; 0380347C
	ldr r0,[r5,#0x0]	; 0380347E
	ldr r1,[pool_03803584]	; 03803480
	and r0,r1	; 03803482
	add r1,sp,#0x0	; 03803484
	ldrh r2,[r1,#0x0]	; 03803486
	ldr r1,[pool_0380359C]	; 03803488
	and r2,r1	; 0380348A
	orr r0,r2	; 0380348C
	str r0,[r5,#0x0]	; 0380348E
	add r0,sp,#0x0	; 03803490
	add r1,r4,#0x0	; 03803492
	add r2,r6,#0x0	; 03803494
	mov r3,#0x1	; 03803496
	bl loc_038035B8	; 03803498
	cmp r0,#0x2	; 0380349C
	bne loc_038034C0	; 0380349E
	ldr r1,[r5,#0x0]	; 038034A0
	lsl r0,r1,#0x5	; 038034A2
	lsr r0,r0,#0x1e	; 038034A4
	cmp r0,#0x1	; 038034A6
	bne loc_038034B6	; 038034A8
	ldr r0,[pool_03803590]	; 038034AA
	and r1,r0	; 038034AC
	ldr r0,[pool_03803594]	; 038034AE
	orr r1,r0	; 038034B0
	str r1,[r5,#0x0]	; 038034B2
	b loc_038034C0	; 038034B4
loc_038034B6:
	ldr r0,[pool_03803590]	; 038034B6
	and r1,r0	; 038034B8
	ldr r0,[pool_038035A0]	; 038034BA
	orr r1,r0	; 038034BC
	str r1,[r5,#0x0]	; 038034BE
loc_038034C0:
	ldr r0,[r5,#0x0]	; 038034C0
	ldr r1,[pool_03803588]	; 038034C2
	and r0,r1	; 038034C4
	add r1,sp,#0x0	; 038034C6
	ldrh r2,[r1,#0x0]	; 038034C8
	ldr r1,[pool_0380359C]	; 038034CA
	and r2,r1	; 038034CC
	lsl r1,r2,#0xc	; 038034CE
	orr r0,r1	; 038034D0
	str r0,[r5,#0x0]	; 038034D2
	ldr r1,[pool_038035A4]	; 038034D4
	ldr r0,[pool_038035A8]	; 038034D6
	strh r1,[r0,#0x0]	; 038034D8
	mov r4,#0x0	; 038034DA
	add r6,r4,#0x0	; 038034DC
loc_038034DE:
	ldr r0,[pool_038035AC]	; 038034DE
	strh r6,[r0,#0x0]	; 038034E0
	b loc_038034EA	; 038034E2
loc_038034E4:
	mov r0,#0x1	; 038034E4
	bl loc_03804890	; 038034E6
loc_038034EA:
	ldr r0,[pool_038035A8]	; 038034EA
	ldrh r1,[r0,#0x0]	; 038034EC
	mov r0,#0x80	; 038034EE
	and r1,r0	; 038034F0
	cmp r1,#0x0	; 038034F2
	bne loc_038034E4	; 038034F4
	add r4,r4,#0x1	; 038034F6
	cmp r4,#0xc	; 038034F8
	blt loc_038034DE	; 038034FA
	ldr r1,[pool_038035B0]	; 038034FC
	ldr r0,[pool_038035A8]	; 038034FE
	strh r1,[r0,#0x0]	; 03803500
	mov r1,#0x0	; 03803502
	ldr r0,[pool_038035AC]	; 03803504
	strh r1,[r0,#0x0]	; 03803506
	ldr r4,[pool_038035A8]	; 03803508
	mov r6,#0x80	; 0380350A
	b loc_03803514	; 0380350C
loc_0380350E:
	mov r0,#0x1	; 0380350E
	bl loc_03804890	; 03803510
loc_03803514:
	ldrh r0,[r4,#0x0]	; 03803514
	and r0,r6	; 03803516
	cmp r0,#0x0	; 03803518
	bne loc_0380350E	; 0380351A
	cmp r7,#0x2	; 0380351C
	bne loc_0380352C	; 0380351E
	ldr r1,[r5,#0x0]	; 03803520
	ldr r0,[pool_03803590]	; 03803522
	and r1,r0	; 03803524
	ldr r0,[pool_03803594]	; 03803526
	orr r1,r0	; 03803528
	str r1,[r5,#0x0]	; 0380352A
loc_0380352C:
	bl loc_038037D0	; 0380352C
	cmp r0,#0x0	; 03803530
	beq loc_03803568	; 03803532
	cmp r0,#0x1	; 03803534
	beq loc_03803558	; 03803536
	cmp r0,#0x2	; 03803538
	bne loc_03803578	; 0380353A
	ldr r1,[r5,#0x0]	; 0380353C
	ldr r0,[pool_038035B4]	; 0380353E
	orr r1,r0	; 03803540
	str r1,[r5,#0x0]	; 03803542
	ldr r1,[r5,#0x0]	; 03803544
	ldr r0,[pool_03803590]	; 03803546
	and r1,r0	; 03803548
	ldr r0,[pool_03803594]	; 0380354A
	orr r1,r0	; 0380354C
	str r1,[r5,#0x0]	; 0380354E
	mov r1,#0x0	; 03803550
	ldr r0,[pool_03803598]	; 03803552
	strh r1,[r0,#0x0]	; 03803554
	b loc_0380357C	; 03803556
loc_03803558:
	ldr r1,[r5,#0x0]	; 03803558
	ldr r0,[pool_038035B4]	; 0380355A
	orr r1,r0	; 0380355C
	str r1,[r5,#0x0]	; 0380355E
	mov r1,#0x1	; 03803560
	ldr r0,[pool_03803598]	; 03803562
	strh r1,[r0,#0x0]	; 03803564
	b loc_0380357C	; 03803566
loc_03803568:
	ldr r1,[r5,#0x0]	; 03803568
	ldr r0,[pool_0380358C]	; 0380356A
	and r1,r0	; 0380356C
	str r1,[r5,#0x0]	; 0380356E
	mov r1,#0x0	; 03803570
	ldr r0,[pool_03803598]	; 03803572
	strh r1,[r0,#0x0]	; 03803574
	b loc_0380357C	; 03803576
loc_03803578:
	bl loc_037FF190	; 03803578
loc_0380357C:
	add sp,#0x4	; 0380357C
	pop {r4,r5,r6,r7}	; 0380357E
	pop {r3}	; 03803580
	bx r3	; 03803582
pool_03803584:
loc_03803584:
	.word 0xFFFFF000	; 03803584
pool_03803588:
loc_03803588:
	.word 0xFF000FFF	; 03803588
pool_0380358C:
loc_0380358C:
	.word 0xFEFFFFFF	; 0380358C
pool_03803590:
loc_03803590:
	.word 0xF9FFFFFF	; 03803590
pool_03803594:
loc_03803594:
	.word 0x06000000	; 03803594
pool_03803598:
loc_03803598:
	.word P2_BssStart + 0x2670	; 03803598
pool_0380359C:
loc_0380359C:
	.word 0x00000FFF	; 0380359C
pool_038035A0:
loc_038035A0:
	.word REG_DISPCNT_A	; 038035A0
pool_038035A4:
loc_038035A4:
	.word 0x00008A01	; 038035A4
pool_038035A8:
loc_038035A8:
	.word REG_SPICNT	; 038035A8
pool_038035AC:
loc_038035AC:
	.word REG_SPIDATA	; 038035AC
pool_038035B0:
loc_038035B0:
	.word 0x00008201	; 038035B0
pool_038035B4:
loc_038035B4:
	.word 0x01000000	; 038035B4

; ===== function loc_038035B8 =====
loc_038035B8:
	push {r4,r5,r6,r7,lr}	; 038035B8
	sub sp,#0x24	; 038035BA
	add r6,r0,#0x0	; 038035BC
	str r1,[sp,#0x0]	; 038035BE
	str r2,[sp,#0x4]	; 038035C0
	cmp r3,#0x0	; 038035C2
	bne loc_038035CC	; 038035C4
	mov r4,#0xd1	; 038035C6
	mov r7,#0x1	; 038035C8
	b loc_038035D8	; 038035CA
loc_038035CC:
	mov r4,#0x91	; 038035CC
	mov r7,#0x2	; 038035CE
	b loc_038035D8	; 038035D0
loc_038035D2:
	mov r0,#0x1	; 038035D2
	bl loc_03804890	; 038035D4
loc_038035D8:
	ldr r5,[pool_038037BC]	; 038035D8
	ldrh r1,[r5,#0x0]	; 038035DA
	mov r0,#0x80	; 038035DC
	and r1,r0	; 038035DE
	cmp r1,#0x0	; 038035E0
	bne loc_038035D2	; 038035E2
	ldr r0,[pool_038037C0]	; 038035E4
	strh r0,[r5,#0x0]	; 038035E6
	mov r0,#0xff	; 038035E8
	and r4,r0	; 038035EA
	ldr r0,[pool_038037C4]	; 038035EC
	strh r4,[r0,#0x0]	; 038035EE
	b loc_038035F8	; 038035F0
loc_038035F2:
	mov r0,#0x1	; 038035F2
	bl loc_03804890	; 038035F4
loc_038035F8:
	ldrh r1,[r5,#0x0]	; 038035F8
	mov r0,#0x80	; 038035FA
	and r1,r0	; 038035FC
	cmp r1,#0x0	; 038035FE
	bne loc_038035F2	; 03803600
	mov r1,#0x0	; 03803602
	ldr r0,[pool_038037C4]	; 03803604
	strh r1,[r0,#0x0]	; 03803606
	ldr r5,[pool_038037BC]	; 03803608
	b loc_03803612	; 0380360A
loc_0380360C:
	mov r0,#0x1	; 0380360C
	bl loc_03804890	; 0380360E
loc_03803612:
	ldrh r1,[r5,#0x0]	; 03803612
	mov r0,#0x80	; 03803614
	and r1,r0	; 03803616
	cmp r1,#0x0	; 03803618
	bne loc_0380360C	; 0380361A
	ldr r1,[pool_038037C4]	; 0380361C
	ldrh r2,[r1,#0x0]	; 0380361E
	mov r0,#0xff	; 03803620
	and r2,r0	; 03803622
	lsl r0,r2,#0x10	; 03803624
	lsr r0,r0,#0x8	; 03803626
	str r0,[sp,#0x18]	; 03803628
	strh r4,[r1,#0x0]	; 0380362A
	ldr r5,[pool_038037BC]	; 0380362C
	b loc_03803636	; 0380362E
loc_03803630:
	mov r0,#0x1	; 03803630
	bl loc_03804890	; 03803632
loc_03803636:
	ldrh r1,[r5,#0x0]	; 03803636
	mov r0,#0x80	; 03803638
	and r1,r0	; 0380363A
	cmp r1,#0x0	; 0380363C
	bne loc_03803630	; 0380363E
	ldr r0,[pool_038037C4]	; 03803640
	ldrh r2,[r0,#0x0]	; 03803642
	mov r1,#0xff	; 03803644
	and r2,r1	; 03803646
	lsl r1,r2,#0x10	; 03803648
	lsr r1,r1,#0x10	; 0380364A
	ldr r2,[sp,#0x18]	; 0380364C
	orr r2,r1	; 0380364E
	str r2,[sp,#0x18]	; 03803650
	ldr r1,[pool_038037C8]	; 03803652
	and r2,r1	; 03803654
	asr r1,r2,#0x3	; 03803656
	str r1,[sp,#0x18]	; 03803658
	mov r1,#0x0	; 0380365A
	strh r1,[r0,#0x0]	; 0380365C
	ldr r5,[pool_038037BC]	; 0380365E
	b loc_03803668	; 03803660
loc_03803662:
	mov r0,#0x1	; 03803662
	bl loc_03804890	; 03803664
loc_03803668:
	ldrh r1,[r5,#0x0]	; 03803668
	mov r0,#0x80	; 0380366A
	and r1,r0	; 0380366C
	cmp r1,#0x0	; 0380366E
	bne loc_03803662	; 03803670
	ldr r1,[pool_038037C4]	; 03803672
	ldrh r2,[r1,#0x0]	; 03803674
	mov r0,#0xff	; 03803676
	and r2,r0	; 03803678
	lsl r0,r2,#0x10	; 0380367A
	lsr r0,r0,#0x8	; 0380367C
	str r0,[sp,#0x1c]	; 0380367E
	strh r4,[r1,#0x0]	; 03803680
	ldr r5,[pool_038037BC]	; 03803682
	b loc_0380368C	; 03803684
loc_03803686:
	mov r0,#0x1	; 03803686
	bl loc_03804890	; 03803688
loc_0380368C:
	ldrh r1,[r5,#0x0]	; 0380368C
	mov r0,#0x80	; 0380368E
	and r1,r0	; 03803690
	cmp r1,#0x0	; 03803692
	bne loc_03803686	; 03803694
	ldr r0,[pool_038037C4]	; 03803696
	ldrh r1,[r0,#0x0]	; 03803698
	mov r0,#0xff	; 0380369A
	and r1,r0	; 0380369C
	lsl r0,r1,#0x10	; 0380369E
	lsr r0,r0,#0x10	; 038036A0
	ldr r1,[sp,#0x1c]	; 038036A2
	orr r1,r0	; 038036A4
	str r1,[sp,#0x1c]	; 038036A6
	ldr r0,[pool_038037C8]	; 038036A8
	and r1,r0	; 038036AA
	asr r1,r1,#0x3	; 038036AC
	str r1,[sp,#0x1c]	; 038036AE
	ldr r0,[sp,#0x4]	; 038036B0
	cmp r0,#0x0	; 038036B2
	bne loc_038036C0	; 038036B4
	ldr r0,[sp,#0x18]	; 038036B6
	add r0,r0,r1	; 038036B8
	asr r0,r0,#0x1	; 038036BA
	strh r0,[r6,#0x0]	; 038036BC
	mov r7,#0x0	; 038036BE
loc_038036C0:
	mov r5,#0x0	; 038036C0
	ldr r0,[sp,#0x0]	; 038036C2
	neg r0,r0	; 038036C4
	str r0,[sp,#0xc]	; 038036C6
	str r5,[sp,#0x14]	; 038036C8
	b loc_03803776	; 038036CA
loc_038036CC:
	ldr r1,[sp,#0x14]	; 038036CC
	ldr r0,[pool_038037C4]	; 038036CE
	strh r1,[r0,#0x0]	; 038036D0
	b loc_038036DA	; 038036D2
loc_038036D4:
	mov r0,#0x1	; 038036D4
	bl loc_03804890	; 038036D6
loc_038036DA:
	ldr r0,[pool_038037BC]	; 038036DA
	ldrh r1,[r0,#0x0]	; 038036DC
	mov r0,#0x80	; 038036DE
	and r1,r0	; 038036E0
	cmp r1,#0x0	; 038036E2
	bne loc_038036D4	; 038036E4
	ldr r0,[pool_038037C4]	; 038036E6
	ldrh r1,[r0,#0x0]	; 038036E8
	mov r0,#0xff	; 038036EA
	and r1,r0	; 038036EC
	lsl r0,r1,#0x10	; 038036EE
	lsr r0,r0,#0x8	; 038036F0
	str r0,[sp,#0x8]	; 038036F2
	ldr r0,[pool_038037C4]	; 038036F4
	strh r4,[r0,#0x0]	; 038036F6
	b loc_03803700	; 038036F8
loc_038036FA:
	mov r0,#0x1	; 038036FA
	bl loc_03804890	; 038036FC
loc_03803700:
	ldr r0,[pool_038037BC]	; 03803700
	ldrh r1,[r0,#0x0]	; 03803702
	mov r0,#0x80	; 03803704
	and r1,r0	; 03803706
	cmp r1,#0x0	; 03803708
	bne loc_038036FA	; 0380370A
	ldr r0,[pool_038037C4]	; 0380370C
	ldrh r1,[r0,#0x0]	; 0380370E
	mov r0,#0xff	; 03803710
	and r1,r0	; 03803712
	lsl r0,r1,#0x10	; 03803714
	lsr r0,r0,#0x10	; 03803716
	ldr r1,[sp,#0x8]	; 03803718
	orr r1,r0	; 0380371A
	str r1,[sp,#0x8]	; 0380371C
	ldr r0,[pool_038037C8]	; 0380371E
	and r1,r0	; 03803720
	str r1,[sp,#0x8]	; 03803722
	asr r0,r1,#0x3	; 03803724
	str r0,[sp,#0x10]	; 03803726
	ldr r1,[sp,#0x18]	; 03803728
	sub r1,r1,r0	; 0380372A
	ldr r0,[sp,#0xc]	; 0380372C
	cmp r1,r0	; 0380372E
	blt loc_03803764	; 03803730
	ldr r0,[sp,#0x0]	; 03803732
	cmp r1,r0	; 03803734
	bgt loc_03803764	; 03803736
	ldr r1,[sp,#0x1c]	; 03803738
	ldr r0,[sp,#0x10]	; 0380373A
	sub r1,r1,r0	; 0380373C
	ldr r0,[sp,#0xc]	; 0380373E
	cmp r1,r0	; 03803740
	blt loc_03803764	; 03803742
	ldr r0,[sp,#0x0]	; 03803744
	cmp r1,r0	; 03803746
	bgt loc_03803764	; 03803748
	add r0,r5,#0x1	; 0380374A
	mov r1,#0x2	; 0380374C
	bl loc_037FE2B0	; 0380374E
	lsl r1,r1,#0x2	; 03803752
	add r0,sp,#0x18	; 03803754
	ldr r1,[r0,r1]	; 03803756
	ldr r0,[sp,#0x10]	; 03803758
	add r0,r0,r1	; 0380375A
	asr r0,r0,#0x1	; 0380375C
	strh r0,[r6,#0x0]	; 0380375E
	mov r7,#0x0	; 03803760
	b loc_0380377C	; 03803762
loc_03803764:
	add r0,r5,#0x0	; 03803764
	mov r1,#0x2	; 03803766
	bl loc_037FE2B0	; 03803768
	lsl r2,r1,#0x2	; 0380376C
	ldr r1,[sp,#0x10]	; 0380376E
	add r0,sp,#0x18	; 03803770
	str r1,[r0,r2]	; 03803772
	add r5,r5,#0x1	; 03803774
loc_03803776:
	ldr r0,[sp,#0x4]	; 03803776
	cmp r5,r0	; 03803778
	blt loc_038036CC	; 0380377A
loc_0380377C:
	cmp r7,#0x0	; 0380377C
	beq loc_0380378A	; 0380377E
	ldr r1,[sp,#0x18]	; 03803780
	ldr r0,[sp,#0x1c]	; 03803782
	add r0,r1,r0	; 03803784
	asr r0,r0,#0x1	; 03803786
	strh r0,[r6,#0x0]	; 03803788
loc_0380378A:
	ldr r0,[pool_038037CC]	; 0380378A
	ldr r4,[pool_038037BC]	; 0380378C
	strh r0,[r4,#0x0]	; 0380378E
	mov r1,#0x0	; 03803790
	ldr r0,[pool_038037C4]	; 03803792
	strh r1,[r0,#0x0]	; 03803794
	mov r5,#0x80	; 03803796
	b loc_038037A0	; 03803798
loc_0380379A:
	mov r0,#0x1	; 0380379A
	bl loc_03804890	; 0380379C
loc_038037A0:
	ldrh r0,[r4,#0x0]	; 038037A0
	and r0,r5	; 038037A2
	cmp r0,#0x0	; 038037A4
	bne loc_0380379A	; 038037A6
	ldrh r1,[r6,#0x0]	; 038037A8
	mov r0,#0x7	; 038037AA
	bic r1,r0	; 038037AC
	strh r1,[r6,#0x0]	; 038037AE
	add r0,r7,#0x0	; 038037B0
	add sp,#0x24	; 038037B2
	pop {r4,r5,r6,r7}	; 038037B4
	pop {r3}	; 038037B6
	bx r3	; 038037B8
	.byte 0xC0, 0x46	; 038037BC
pool_038037BC:
loc_038037BC:
	.word REG_SPICNT	; 038037BC
pool_038037C0:
loc_038037C0:
	.word 0x00008A01	; 038037C0
pool_038037C4:
loc_038037C4:
	.word REG_SPIDATA	; 038037C4
pool_038037C8:
loc_038037C8:
	.word 0x00007FF8	; 038037C8
pool_038037CC:
loc_038037CC:
	.word 0x00008201	; 038037CC

; ===== function loc_038037D0 =====
loc_038037D0:
	push {r4,r5,r6,lr}	; 038037D0
	ldr r0,[pool_038038EC]	; 038037D2
	bl loc_03802100	; 038037D4
	mov r6,#0x1	; 038037D8
	ldr r5,[pool_038038F0]	; 038037DA
	mov r4,#0x80	; 038037DC
	b loc_038037E6	; 038037DE
loc_038037E0:
	add r0,r6,#0x0	; 038037E0
	bl loc_03804890	; 038037E2
loc_038037E6:
	ldrh r0,[r5,#0x0]	; 038037E6
	and r0,r4	; 038037E8
	cmp r0,#0x0	; 038037EA
	bne loc_038037E0	; 038037EC
	ldr r0,[pool_038038F4]	; 038037EE
	strh r0,[r5,#0x0]	; 038037F0
	mov r1,#0x84	; 038037F2
	ldr r0,[pool_038038F8]	; 038037F4
	strh r1,[r0,#0x0]	; 038037F6
	mov r6,#0x1	; 038037F8
	ldr r5,[pool_038038F0]	; 038037FA
	mov r4,#0x80	; 038037FC
	b loc_03803806	; 038037FE
loc_03803800:
	add r0,r6,#0x0	; 03803800
	bl loc_03804890	; 03803802
loc_03803806:
	ldrh r0,[r5,#0x0]	; 03803806
	and r0,r4	; 03803808
	cmp r0,#0x0	; 0380380A
	bne loc_03803800	; 0380380C
	mov r1,#0x0	; 0380380E
	ldr r0,[pool_038038F8]	; 03803810
	strh r1,[r0,#0x0]	; 03803812
	mov r6,#0x1	; 03803814
	ldr r5,[pool_038038F0]	; 03803816
	mov r4,#0x80	; 03803818
	b loc_03803822	; 0380381A
loc_0380381C:
	add r0,r6,#0x0	; 0380381C
	bl loc_03804890	; 0380381E
loc_03803822:
	ldrh r0,[r5,#0x0]	; 03803822
	and r0,r4	; 03803824
	cmp r0,#0x0	; 03803826
	bne loc_0380381C	; 03803828
	ldr r0,[pool_038038FC]	; 0380382A
	strh r0,[r5,#0x0]	; 0380382C
	mov r1,#0x0	; 0380382E
	ldr r0,[pool_038038F8]	; 03803830
	strh r1,[r0,#0x0]	; 03803832
	mov r6,#0x1	; 03803834
	ldr r5,[pool_038038F0]	; 03803836
	mov r4,#0x80	; 03803838
	b loc_03803842	; 0380383A
loc_0380383C:
	add r0,r6,#0x0	; 0380383C
	bl loc_03804890	; 0380383E
loc_03803842:
	ldrh r0,[r5,#0x0]	; 03803842
	and r0,r4	; 03803844
	cmp r0,#0x0	; 03803846
	bne loc_0380383C	; 03803848
	ldr r0,[pool_03803900]	; 0380384A
	ldrh r0,[r0,#0x0]	; 0380384C
	cmp r0,#0x0	; 0380384E
	bne loc_03803866	; 03803850
	ldr r0,[pool_03803904]	; 03803852
	ldrh r1,[r0,#0x0]	; 03803854
	mov r0,#0x40	; 03803856
	and r1,r0	; 03803858
	cmp r1,#0x0	; 0380385A
	bne loc_03803862	; 0380385C
	mov r0,#0x1	; 0380385E
	b loc_038038E4	; 03803860
loc_03803862:
	mov r0,#0x0	; 03803862
	b loc_038038E4	; 03803864
loc_03803866:
	ldr r0,[pool_03803904]	; 03803866
	ldrh r1,[r0,#0x0]	; 03803868
	mov r0,#0x40	; 0380386A
	and r1,r0	; 0380386C
	cmp r1,#0x0	; 0380386E
	bne loc_03803876	; 03803870
	mov r0,#0x1	; 03803872
	b loc_038038E4	; 03803874
loc_03803876:
	ldr r0,[pool_038038F4]	; 03803876
	strh r0,[r5,#0x0]	; 03803878
	mov r1,#0x84	; 0380387A
	ldr r0,[pool_038038F8]	; 0380387C
	strh r1,[r0,#0x0]	; 0380387E
	mov r6,#0x1	; 03803880
	ldr r5,[pool_038038F0]	; 03803882
	mov r4,#0x80	; 03803884
	b loc_0380388E	; 03803886
loc_03803888:
	add r0,r6,#0x0	; 03803888
	bl loc_03804890	; 0380388A
loc_0380388E:
	ldrh r0,[r5,#0x0]	; 0380388E
	and r0,r4	; 03803890
	cmp r0,#0x0	; 03803892
	bne loc_03803888	; 03803894
	mov r1,#0x0	; 03803896
	ldr r0,[pool_038038F8]	; 03803898
	strh r1,[r0,#0x0]	; 0380389A
	mov r6,#0x1	; 0380389C
	ldr r5,[pool_038038F0]	; 0380389E
	mov r4,#0x80	; 038038A0
	b loc_038038AA	; 038038A2
loc_038038A4:
	add r0,r6,#0x0	; 038038A4
	bl loc_03804890	; 038038A6
loc_038038AA:
	ldrh r0,[r5,#0x0]	; 038038AA
	and r0,r4	; 038038AC
	cmp r0,#0x0	; 038038AE
	bne loc_038038A4	; 038038B0
	ldr r0,[pool_038038FC]	; 038038B2
	strh r0,[r5,#0x0]	; 038038B4
	mov r1,#0x0	; 038038B6
	ldr r0,[pool_038038F8]	; 038038B8
	strh r1,[r0,#0x0]	; 038038BA
	mov r6,#0x1	; 038038BC
	ldr r5,[pool_038038F0]	; 038038BE
	mov r4,#0x80	; 038038C0
	b loc_038038CA	; 038038C2
loc_038038C4:
	add r0,r6,#0x0	; 038038C4
	bl loc_03804890	; 038038C6
loc_038038CA:
	ldrh r0,[r5,#0x0]	; 038038CA
	and r0,r4	; 038038CC
	cmp r0,#0x0	; 038038CE
	bne loc_038038C4	; 038038D0
	ldr r0,[pool_03803904]	; 038038D2
	ldrh r1,[r0,#0x0]	; 038038D4
	mov r0,#0x40	; 038038D6
	and r1,r0	; 038038D8
	cmp r1,#0x0	; 038038DA
	beq loc_038038E2	; 038038DC
	mov r0,#0x0	; 038038DE
	b loc_038038E4	; 038038E0
loc_038038E2:
	mov r0,#0x2	; 038038E2
loc_038038E4:
	pop {r4,r5,r6}	; 038038E4
	pop {r3}	; 038038E6
	bx r3	; 038038E8
	.byte 0xC0, 0x46	; 038038EC
pool_038038EC:
loc_038038EC:
	.word 0x00008000	; 038038EC
pool_038038F0:
loc_038038F0:
	.word REG_SPICNT	; 038038F0
pool_038038F4:
loc_038038F4:
	.word 0x00008A01	; 038038F4
pool_038038F8:
loc_038038F8:
	.word REG_SPIDATA	; 038038F8
pool_038038FC:
loc_038038FC:
	.word 0x00008201	; 038038FC
pool_03803900:
loc_03803900:
	.word P2_BssStart + 0x2670	; 03803900
pool_03803904:
loc_03803904:
	.word REG_KEYXY	; 03803904
P2_Entry_03803908:
	push {lr}	; 03803908
	sub sp,#0x4	; 0380390A
	add r0,sp,#0x0	; 0380390C
	bl loc_0380400C	; 0380390E
	add r0,sp,#0x0	; 03803912
	ldrh r2,[r0,#0x0]	; 03803914
	mov r0,#0x1	; 03803916
	add r1,r2,#0x0	; 03803918
	and r1,r0	; 0380391A
	cmp r1,#0x0	; 0380391C
	beq P2_Entry_03803924	; 0380391E
	mov r0,#0x0	; 03803920
	b P2_Entry_0380392E	; 03803922
P2_Entry_03803924:
	mov r1,#0x2	; 03803924
	and r2,r1	; 03803926
	cmp r2,#0x0	; 03803928
	bne P2_Entry_0380392E	; 0380392A
	mov r0,#0x0	; 0380392C
P2_Entry_0380392E:
	add sp,#0x4	; 0380392E
	pop {r3}	; 03803930
	bx r3	; 03803932
P2_Entry_03803934:
	push {lr}	; 03803934
	sub sp,#0x4	; 03803936
	add r0,sp,#0x0	; 03803938
	bl loc_0380400C	; 0380393A
	add r0,sp,#0x0	; 0380393E
	ldrh r1,[r0,#0x0]	; 03803940
	mov r0,#0x1	; 03803942
	and r1,r0	; 03803944
	cmp r1,#0x0	; 03803946
	beq P2_Entry_0380394C	; 03803948
	mov r0,#0x0	; 0380394A
P2_Entry_0380394C:
	add sp,#0x4	; 0380394C
	pop {r3}	; 0380394E
	bx r3	; 03803950
	.byte 0x00, 0x00	; 03803952
P2_Entry_03803954:
	push {r4,r5,lr}	; 03803954
	sub sp,#0x4	; 03803956
	add r4,r0,#0x0	; 03803958
	bl loc_037FDC9C	; 0380395A
	add r5,r0,#0x0	; 0380395E
	mov r0,#0x1	; 03803960
	bl P2_Entry_03802E2C	; 03803962
	cmp r0,#0x0	; 03803966
	bne P2_Entry_0380397E	; 03803968
	add r0,r5,#0x0	; 0380396A
	bl loc_037FDCC0	; 0380396C
	ldr r0,[r4,#0x4]	; 03803970
	lsl r0,r0,#0x10	; 03803972
	lsr r0,r0,#0x10	; 03803974
	mov r1,#0x4	; 03803976
	bl loc_03802E40	; 03803978
	b P2_Entry_03803A9E	; 0380397C
P2_Entry_0380397E:
	mov r0,#0x1	; 0380397E
	bl loc_03802E1C	; 03803980
	add r0,r5,#0x0	; 03803984
	bl loc_037FDCC0	; 03803986
	ldr r0,[r4,#0x4]	; 0380398A
	sub r0,#0x20	; 0380398C
	cmp r0,#0xd	; 0380398E
	bhi P2_Entry_03803A78	; 03803990
	add r0,r0,r0	; 03803992
P2_SwitchIndexPC_03803992:
	add r0,pc	; 03803994
	ldrh r0,[r0,#(P2_SwitchTable_03803992 - (P2_SwitchIndexPC_03803992 + 4))]	; 03803996
	lsl r0,r0,#0x10	; 03803998
	asr r0,r0,#0x10	; 0380399A
P2_SwitchTargetPC_03803992:
	add r0,pc	; 0380399C
	bx r0	; 0380399E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803992:
	.halfword (P2_Case_038039BC + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_038039C2 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_038039C8 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_038039D0 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Entry_03803A78 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_038039F8 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Entry_03803A78 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_03803A24 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Entry_03803A78 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Entry_03803A78 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Entry_03803A78 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_03803A48 + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_03803A6A + 1) - (P2_SwitchTargetPC_03803992 + 4)
	.halfword (P2_Case_03803A72 + 1) - (P2_SwitchTargetPC_03803992 + 4)
P2_SwitchTable_03803992End:
P2_Case_038039BC:
	bl P2_Entry_038040D8	; 038039BC
	b P2_Entry_03803A8C	; 038039C0
P2_Case_038039C2:
	bl P2_Entry_0380408C	; 038039C2
	b P2_Entry_03803A8C	; 038039C6
P2_Case_038039C8:
	ldr r0,[r4,#0x10]	; 038039C8
	bl loc_0380400C	; 038039CA
	b P2_Entry_03803A8C	; 038039CE
P2_Case_038039D0:
	bl P2_Entry_03803934	; 038039D0
	cmp r0,#0x0	; 038039D4
	bne P2_Entry_038039EC	; 038039D6
	ldr r0,[r4,#0x4]	; 038039D8
	lsl r0,r0,#0x10	; 038039DA
	lsr r0,r0,#0x10	; 038039DC
	mov r1,#0x3	; 038039DE
	bl loc_03802E40	; 038039E0
	mov r0,#0x1	; 038039E4
	bl P2_Entry_03802DF4	; 038039E6
	b P2_Entry_03803A9E	; 038039EA
P2_Entry_038039EC:
	ldr r0,[r4,#0x8]	; 038039EC
	ldr r1,[r4,#0xc]	; 038039EE
	ldr r2,[r4,#0x10]	; 038039F0
	bl loc_03803F10	; 038039F2
	b P2_Entry_03803A8C	; 038039F6
P2_Case_038039F8:
	bl P2_Entry_03803908	; 038039F8
	cmp r0,#0x0	; 038039FC
	bne P2_Entry_03803A14	; 038039FE
	ldr r0,[r4,#0x4]	; 03803A00
	lsl r0,r0,#0x10	; 03803A02
	lsr r0,r0,#0x10	; 03803A04
	mov r1,#0x3	; 03803A06
	bl loc_03802E40	; 03803A08
	mov r0,#0x1	; 03803A0C
	bl P2_Entry_03802DF4	; 03803A0E
	b P2_Entry_03803A9E	; 03803A12
P2_Entry_03803A14:
	ldr r0,[r4,#0x8]	; 03803A14
	ldr r1,[r4,#0xc]	; 03803A16
	lsl r1,r1,#0x10	; 03803A18
	lsr r1,r1,#0x10	; 03803A1A
	ldr r2,[r4,#0x10]	; 03803A1C
	bl P2_Entry_03803E04	; 03803A1E
	b P2_Entry_03803A8C	; 03803A22
P2_Case_03803A24:
	bl P2_Entry_03803908	; 03803A24
	cmp r0,#0x0	; 03803A28
	bne P2_Entry_03803A40	; 03803A2A
	ldr r0,[r4,#0x4]	; 03803A2C
	lsl r0,r0,#0x10	; 03803A2E
	lsr r0,r0,#0x10	; 03803A30
	mov r1,#0x3	; 03803A32
	bl loc_03802E40	; 03803A34
	mov r0,#0x1	; 03803A38
	bl P2_Entry_03802DF4	; 03803A3A
	b P2_Entry_03803A9E	; 03803A3E
P2_Entry_03803A40:
	ldr r0,[r4,#0x8]	; 03803A40
	bl P2_Entry_03803D34	; 03803A42
	b P2_Entry_03803A8C	; 03803A46
P2_Case_03803A48:
	bl P2_Entry_03803908	; 03803A48
	cmp r0,#0x0	; 03803A4C
	bne P2_Entry_03803A64	; 03803A4E
	ldr r0,[r4,#0x4]	; 03803A50
	lsl r0,r0,#0x10	; 03803A52
	lsr r0,r0,#0x10	; 03803A54
	mov r1,#0x3	; 03803A56
	bl loc_03802E40	; 03803A58
	mov r0,#0x1	; 03803A5C
	bl P2_Entry_03802DF4	; 03803A5E
	b P2_Entry_03803A9E	; 03803A62
P2_Entry_03803A64:
	bl P2_Entry_03803CE8	; 03803A64
	b P2_Entry_03803A8C	; 03803A68
P2_Case_03803A6A:
	ldr r0,[r4,#0x10]	; 03803A6A
	bl P2_Entry_03803C44	; 03803A6C
	b P2_Entry_03803A8C	; 03803A70
P2_Case_03803A72:
	bl P2_Entry_03803BF8	; 03803A72
	b P2_Entry_03803A8C	; 03803A76
P2_Entry_03803A78:
	mov r0,#0x1	; 03803A78
	bl P2_Entry_03802DF4	; 03803A7A
	ldr r0,[r4,#0x4]	; 03803A7E
	lsl r0,r0,#0x10	; 03803A80
	lsr r0,r0,#0x10	; 03803A82
	mov r1,#0x1	; 03803A84
	bl loc_03802E40	; 03803A86
	b P2_Entry_03803A9E	; 03803A8A
P2_Entry_03803A8C:
	ldr r0,[r4,#0x4]	; 03803A8C
	lsl r0,r0,#0x10	; 03803A8E
	lsr r0,r0,#0x10	; 03803A90
	mov r1,#0x0	; 03803A92
	bl loc_03802E40	; 03803A94
	mov r0,#0x1	; 03803A98
	bl P2_Entry_03802DF4	; 03803A9A
P2_Entry_03803A9E:
	add sp,#0x4	; 03803A9E
	pop {r4,r5}	; 03803AA0
	pop {r3}	; 03803AA2
	bx r3	; 03803AA4
	.byte 0x00, 0x00	; 03803AA6

; ===== function loc_03803AA8 =====
loc_03803AA8:
	push {r4,r5,r6,r7,lr}	; 03803AA8
	sub sp,#0xc	; 03803AAA
	ldr r1,[pool_03803BC8]	; 03803AAC
	add r5,r0,#0x0	; 03803AAE
	and r5,r1	; 03803AB0
	cmp r5,#0x0	; 03803AB2
	beq loc_03803AC6	; 03803AB4
	mov r5,#0x0	; 03803AB6
	add r6,r5,#0x0	; 03803AB8
	ldr r7,[pool_03803BCC]	; 03803ABA
loc_03803ABC:
	lsl r1,r5,#0x1	; 03803ABC
	strh r6,[r7,r1]	; 03803ABE
	add r5,r5,#0x1	; 03803AC0
	cmp r5,#0x10	; 03803AC2
	blt loc_03803ABC	; 03803AC4
loc_03803AC6:
	ldr r1,[pool_03803BD0]	; 03803AC6
	add r5,r0,#0x0	; 03803AC8
	and r5,r1	; 03803ACA
	lsr r1,r5,#0x10	; 03803ACC
	lsl r5,r1,#0x1	; 03803ACE
	ldr r1,[pool_03803BCC]	; 03803AD0
	strh r0,[r1,r5]	; 03803AD2
	ldr r5,[pool_03803BD4]	; 03803AD4
	and r0,r5	; 03803AD6
	cmp r0,#0x0	; 03803AD8
	beq loc_03803BC0	; 03803ADA
	ldrh r0,[r1,#0x0]	; 03803ADC
	ldr r7,[pool_03803BD8]	; 03803ADE
	add r5,r0,#0x0	; 03803AE0
	and r5,r7	; 03803AE2
	lsl r5,r5,#0x8	; 03803AE4
	lsr r6,r5,#0x10	; 03803AE6
	add r5,r6,#0x0	; 03803AE8
	sub r5,#0x22	; 03803AEA
	cmp r5,#0xa	; 03803AEC
	bhi loc_03803BA6	; 03803AEE
	add r5,r5,r5	; 03803AF0
P2_SwitchIndexPC_03803AF0:
	add r5,pc	; 03803AF2
	ldrh r5,[r5,#(P2_SwitchTable_03803AF0 - (P2_SwitchIndexPC_03803AF0 + 4))]	; 03803AF4
	lsl r5,r5,#0x10	; 03803AF6
	asr r5,r5,#0x10	; 03803AF8
P2_SwitchTargetPC_03803AF0:
	add r5,pc	; 03803AFA
	bx r5	; 03803AFC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803AF0:
	.halfword (loc_03803B14 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803B3E + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803BA6 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803B70 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803BA6 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803B9C + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803BA6 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803BA6 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803BA6 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803BA6 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
	.halfword (loc_03803B14 + 1) - (P2_SwitchTargetPC_03803AF0 + 4)
P2_SwitchTable_03803AF0End:
loc_03803B14:
	ldrh r4,[r1,#0x4]	; 03803B14
	and r4,r7	; 03803B16
	lsr r4,r4,#0x8	; 03803B18
	mov r5,#0xff	; 03803B1A
	and r0,r5	; 03803B1C
	lsl r0,r0,#0x18	; 03803B1E
	ldrh r1,[r1,#0x2]	; 03803B20
	lsl r1,r1,#0x8	; 03803B22
	orr r0,r1	; 03803B24
	orr r4,r0	; 03803B26
	ldr r0,[pool_03803BC8]	; 03803B28
	cmp r4,r0	; 03803B2A
	bcc loc_03803B34	; 03803B2C
	ldr r0,[pool_03803BDC]	; 03803B2E
	cmp r4,r0	; 03803B30
	bcc loc_03803BA6	; 03803B32
loc_03803B34:
	add r0,r6,#0x0	; 03803B34
	mov r1,#0x2	; 03803B36
	bl loc_03802E40	; 03803B38
	b loc_03803BC0	; 03803B3C
loc_03803B3E:
	ldrh r2,[r1,#0x8]	; 03803B3E
	lsl r4,r2,#0x10	; 03803B40
	ldrh r2,[r1,#0xa]	; 03803B42
	orr r4,r2	; 03803B44
	ldr r2,[pool_03803BC8]	; 03803B46
	cmp r4,r2	; 03803B48
	bcc loc_03803B52	; 03803B4A
	ldr r2,[pool_03803BDC]	; 03803B4C
	cmp r4,r2	; 03803B4E
	bcc loc_03803B5C	; 03803B50
loc_03803B52:
	add r0,r6,#0x0	; 03803B52
	mov r1,#0x2	; 03803B54
	bl loc_03802E40	; 03803B56
	b loc_03803BC0	; 03803B5A
loc_03803B5C:
	mov r2,#0xff	; 03803B5C
	and r0,r2	; 03803B5E
	lsl r3,r0,#0x10	; 03803B60
	ldrh r0,[r1,#0x2]	; 03803B62
	orr r3,r0	; 03803B64
	ldrh r0,[r1,#0x4]	; 03803B66
	lsl r2,r0,#0x10	; 03803B68
	ldrh r0,[r1,#0x6]	; 03803B6A
	orr r2,r0	; 03803B6C
	b loc_03803BA6	; 03803B6E
loc_03803B70:
	ldrh r2,[r1,#0x6]	; 03803B70
	lsl r4,r2,#0x10	; 03803B72
	ldrh r2,[r1,#0x8]	; 03803B74
	orr r4,r2	; 03803B76
	ldr r2,[pool_03803BC8]	; 03803B78
	cmp r4,r2	; 03803B7A
	bcc loc_03803B84	; 03803B7C
	ldr r2,[pool_03803BDC]	; 03803B7E
	cmp r4,r2	; 03803B80
	bcc loc_03803B8E	; 03803B82
loc_03803B84:
	add r0,r6,#0x0	; 03803B84
	mov r1,#0x2	; 03803B86
	bl loc_03802E40	; 03803B88
	b loc_03803BC0	; 03803B8C
loc_03803B8E:
	mov r2,#0xff	; 03803B8E
	and r0,r2	; 03803B90
	lsl r3,r0,#0x10	; 03803B92
	ldrh r0,[r1,#0x2]	; 03803B94
	orr r3,r0	; 03803B96
	ldrh r2,[r1,#0x4]	; 03803B98
	b loc_03803BA6	; 03803B9A
loc_03803B9C:
	mov r3,#0xff	; 03803B9C
	and r0,r3	; 03803B9E
	lsl r3,r0,#0x10	; 03803BA0
	ldrh r0,[r1,#0x2]	; 03803BA2
	orr r3,r0	; 03803BA4
loc_03803BA6:
	str r2,[sp,#0x0]	; 03803BA6
	str r4,[sp,#0x4]	; 03803BA8
	mov r0,#0x1	; 03803BAA
	add r1,r6,#0x0	; 03803BAC
	mov r2,#0x3	; 03803BAE
	bl loc_03802D4C	; 03803BB0
	cmp r0,#0x0	; 03803BB4
	bne loc_03803BC0	; 03803BB6
	add r0,r6,#0x0	; 03803BB8
	mov r1,#0x4	; 03803BBA
	bl loc_03802E40	; 03803BBC
loc_03803BC0:
	add sp,#0xc	; 03803BC0
	pop {r4,r5,r6,r7}	; 03803BC2
	pop {r3}	; 03803BC4
	bx r3	; 03803BC6
pool_03803BC8:
loc_03803BC8:
	.word 0x02000000	; 03803BC8
pool_03803BCC:
loc_03803BCC:
	.word P2_BssStart + 0x2674	; 03803BCC
pool_03803BD0:
loc_03803BD0:
	.word 0x000F0000	; 03803BD0
pool_03803BD4:
loc_03803BD4:
	.word 0x01000000	; 03803BD4
pool_03803BD8:
loc_03803BD8:
	.word 0x0000FF00	; 03803BD8
pool_03803BDC:
loc_03803BDC:
	.word 0x02400000	; 03803BDC

; ===== function loc_03803BE0 =====
loc_03803BE0:
	mov r3,#0x0	; 03803BE0
	add r2,r3,#0x0	; 03803BE2
	ldr r0,[pool_03803BF4]	; 03803BE4
loc_03803BE6:
	lsl r1,r3,#0x1	; 03803BE6
	strh r2,[r0,r1]	; 03803BE8
	add r3,r3,#0x1	; 03803BEA
	cmp r3,#0x10	; 03803BEC
	blt loc_03803BE6	; 03803BEE
	bx lr	; 03803BF0
	.byte 0xC0, 0x46	; 03803BF4
pool_03803BF4:
loc_03803BF4:
	.word P2_BssStart + 0x2674	; 03803BF4
P2_Entry_03803BF8:
	push {r4,r5,r6,lr}	; 03803BF8
	mov r6,#0x1	; 03803BFA
	ldr r5,[pool_03803C38]	; 03803BFC
	mov r4,#0x80	; 03803BFE
	b P2_Entry_03803C08	; 03803C00
P2_Entry_03803C02:
	add r0,r6,#0x0	; 03803C02
	bl P2_SwiWaitByLoop	; 03803C04
P2_Entry_03803C08:
	ldrh r0,[r5,#0x0]	; 03803C08
	and r0,r4	; 03803C0A
	cmp r0,#0x0	; 03803C0C
	bne P2_Entry_03803C02	; 03803C0E
	ldr r0,[pool_03803C3C]	; 03803C10
	strh r0,[r5,#0x0]	; 03803C12
	mov r1,#0xff	; 03803C14
	ldr r0,[pool_03803C40]	; 03803C16
	strh r1,[r0,#0x0]	; 03803C18
	mov r6,#0x1	; 03803C1A
	ldr r5,[pool_03803C38]	; 03803C1C
	mov r4,#0x80	; 03803C1E
	b P2_Entry_03803C28	; 03803C20
P2_Entry_03803C22:
	add r0,r6,#0x0	; 03803C22
	bl P2_SwiWaitByLoop	; 03803C24
P2_Entry_03803C28:
	ldrh r0,[r5,#0x0]	; 03803C28
	and r0,r4	; 03803C2A
	cmp r0,#0x0	; 03803C2C
	bne P2_Entry_03803C22	; 03803C2E
	pop {r4,r5,r6}	; 03803C30
	pop {r3}	; 03803C32
	bx r3	; 03803C34
	.byte 0xC0, 0x46	; 03803C36
pool_03803C38:
	.word 0x040001C0	; 03803C38
pool_03803C3C:
	.word 0x00008100	; 03803C3C
pool_03803C40:
	.word REG_SPIDATA	; 03803C40
P2_Entry_03803C44:
	push {r4,r5,r6,r7,lr}	; 03803C44
	sub sp,#0x4	; 03803C46
	add r5,r0,#0x0	; 03803C48
	mov r7,#0x1	; 03803C4A
	ldr r4,[pool_03803CD8]	; 03803C4C
	mov r6,#0x80	; 03803C4E
	b P2_Entry_03803C58	; 03803C50
P2_Entry_03803C52:
	add r0,r7,#0x0	; 03803C52
	bl P2_SwiWaitByLoop	; 03803C54
P2_Entry_03803C58:
	ldrh r0,[r4,#0x0]	; 03803C58
	and r0,r6	; 03803C5A
	cmp r0,#0x0	; 03803C5C
	bne P2_Entry_03803C52	; 03803C5E
	ldr r0,[pool_03803CDC]	; 03803C60
	strh r0,[r4,#0x0]	; 03803C62
	mov r1,#0x9f	; 03803C64
	ldr r0,[pool_03803CE0]	; 03803C66
	strh r1,[r0,#0x0]	; 03803C68
	mov r7,#0x1	; 03803C6A
	ldr r4,[pool_03803CD8]	; 03803C6C
	mov r6,#0x80	; 03803C6E
	b P2_Entry_03803C78	; 03803C70
P2_Entry_03803C72:
	add r0,r7,#0x0	; 03803C72
	bl P2_SwiWaitByLoop	; 03803C74
P2_Entry_03803C78:
	ldrh r0,[r4,#0x0]	; 03803C78
	and r0,r6	; 03803C7A
	cmp r0,#0x0	; 03803C7C
	bne P2_Entry_03803C72	; 03803C7E
	mov r1,#0x0	; 03803C80
	ldr r0,[pool_03803CE0]	; 03803C82
	strh r1,[r0,#0x0]	; 03803C84
	mov r7,#0x1	; 03803C86
	ldr r4,[pool_03803CD8]	; 03803C88
	mov r6,#0x80	; 03803C8A
	b P2_Entry_03803C94	; 03803C8C
P2_Entry_03803C8E:
	add r0,r7,#0x0	; 03803C8E
	bl P2_SwiWaitByLoop	; 03803C90
P2_Entry_03803C94:
	ldrh r0,[r4,#0x0]	; 03803C94
	and r0,r6	; 03803C96
	cmp r0,#0x0	; 03803C98
	bne P2_Entry_03803C8E	; 03803C9A
	ldr r1,[pool_03803CE0]	; 03803C9C
	ldrh r2,[r1,#0x0]	; 03803C9E
	mov r0,#0xff	; 03803CA0
	and r2,r0	; 03803CA2
	strb r2,[r5,#0x0]	; 03803CA4
	ldr r0,[pool_03803CE4]	; 03803CA6
	strh r0,[r4,#0x0]	; 03803CA8
	mov r0,#0x0	; 03803CAA
	strh r0,[r1,#0x0]	; 03803CAC
	mov r7,#0x1	; 03803CAE
	ldr r4,[pool_03803CD8]	; 03803CB0
	mov r6,#0x80	; 03803CB2
	b P2_Entry_03803CBC	; 03803CB4
P2_Entry_03803CB6:
	add r0,r7,#0x0	; 03803CB6
	bl P2_SwiWaitByLoop	; 03803CB8
P2_Entry_03803CBC:
	ldrh r0,[r4,#0x0]	; 03803CBC
	and r0,r6	; 03803CBE
	cmp r0,#0x0	; 03803CC0
	bne P2_Entry_03803CB6	; 03803CC2
	ldr r0,[pool_03803CE0]	; 03803CC4
	ldrh r1,[r0,#0x0]	; 03803CC6
	mov r0,#0xff	; 03803CC8
	and r1,r0	; 03803CCA
	strb r1,[r5,#0x1]	; 03803CCC
	add sp,#0x4	; 03803CCE
	pop {r4,r5,r6,r7}	; 03803CD0
	pop {r3}	; 03803CD2
	bx r3	; 03803CD4
	.byte 0xC0, 0x46	; 03803CD6
pool_03803CD8:
	.word 0x040001C0	; 03803CD8
pool_03803CDC:
	.word 0x00008900	; 03803CDC
pool_03803CE0:
	.word REG_SPIDATA	; 03803CE0
pool_03803CE4:
	.word 0x00008100	; 03803CE4
P2_Entry_03803CE8:
	push {r4,r5,r6,lr}	; 03803CE8
	mov r6,#0x1	; 03803CEA
	ldr r5,[pool_03803D28]	; 03803CEC
	mov r4,#0x80	; 03803CEE
	b P2_Entry_03803CF8	; 03803CF0
P2_Entry_03803CF2:
	add r0,r6,#0x0	; 03803CF2
	bl P2_SwiWaitByLoop	; 03803CF4
P2_Entry_03803CF8:
	ldrh r0,[r5,#0x0]	; 03803CF8
	and r0,r4	; 03803CFA
	cmp r0,#0x0	; 03803CFC
	bne P2_Entry_03803CF2	; 03803CFE
	ldr r0,[pool_03803D2C]	; 03803D00
	strh r0,[r5,#0x0]	; 03803D02
	mov r1,#0xc7	; 03803D04
	ldr r0,[pool_03803D30]	; 03803D06
	strh r1,[r0,#0x0]	; 03803D08
	mov r6,#0x1	; 03803D0A
	ldr r5,[pool_03803D28]	; 03803D0C
	mov r4,#0x80	; 03803D0E
	b P2_Entry_03803D18	; 03803D10
P2_Entry_03803D12:
	add r0,r6,#0x0	; 03803D12
	bl P2_SwiWaitByLoop	; 03803D14
P2_Entry_03803D18:
	ldrh r0,[r5,#0x0]	; 03803D18
	and r0,r4	; 03803D1A
	cmp r0,#0x0	; 03803D1C
	bne P2_Entry_03803D12	; 03803D1E
	pop {r4,r5,r6}	; 03803D20
	pop {r3}	; 03803D22
	bx r3	; 03803D24
	.byte 0xC0, 0x46	; 03803D26
pool_03803D28:
	.word 0x040001C0	; 03803D28
pool_03803D2C:
	.word 0x00008100	; 03803D2C
pool_03803D30:
	.word REG_SPIDATA	; 03803D30
P2_Entry_03803D34:
	push {r4,r5,r6,r7,lr}	; 03803D34
	sub sp,#0x4	; 03803D36
	ldr r1,[pool_03803DEC]	; 03803D38
	add r2,r0,#0x0	; 03803D3A
	and r2,r1	; 03803D3C
	lsr r1,r2,#0x10	; 03803D3E
	lsl r1,r1,#0x10	; 03803D40
	lsr r5,r1,#0x10	; 03803D42
	ldr r1,[pool_03803DF0]	; 03803D44
	add r2,r0,#0x0	; 03803D46
	and r2,r1	; 03803D48
	lsl r1,r2,#0x8	; 03803D4A
	lsr r4,r1,#0x10	; 03803D4C
	mov r1,#0xff	; 03803D4E
	and r0,r1	; 03803D50
	lsl r0,r0,#0x10	; 03803D52
	lsr r6,r0,#0x10	; 03803D54
	ldr r7,[pool_03803DF4]	; 03803D56
	b P2_Entry_03803D60	; 03803D58
P2_Entry_03803D5A:
	mov r0,#0x1	; 03803D5A
	bl P2_SwiWaitByLoop	; 03803D5C
P2_Entry_03803D60:
	ldrh r1,[r7,#0x0]	; 03803D60
	mov r0,#0x80	; 03803D62
	and r1,r0	; 03803D64
	cmp r1,#0x0	; 03803D66
	bne P2_Entry_03803D5A	; 03803D68
	ldr r0,[pool_03803DF8]	; 03803D6A
	strh r0,[r7,#0x0]	; 03803D6C
	mov r1,#0xdb	; 03803D6E
	ldr r0,[pool_03803DFC]	; 03803D70
	strh r1,[r0,#0x0]	; 03803D72
	ldr r7,[pool_03803DF4]	; 03803D74
	b P2_Entry_03803D7E	; 03803D76
P2_Entry_03803D78:
	mov r0,#0x1	; 03803D78
	bl P2_SwiWaitByLoop	; 03803D7A
P2_Entry_03803D7E:
	ldrh r1,[r7,#0x0]	; 03803D7E
	mov r0,#0x80	; 03803D80
	and r1,r0	; 03803D82
	cmp r1,#0x0	; 03803D84
	bne P2_Entry_03803D78	; 03803D86
	mov r0,#0xff	; 03803D88
	and r5,r0	; 03803D8A
	ldr r0,[pool_03803DFC]	; 03803D8C
	strh r5,[r0,#0x0]	; 03803D8E
	ldr r5,[pool_03803DF4]	; 03803D90
	mov r7,#0x80	; 03803D92
	b P2_Entry_03803D9C	; 03803D94
P2_Entry_03803D96:
	mov r0,#0x1	; 03803D96
	bl P2_SwiWaitByLoop	; 03803D98
P2_Entry_03803D9C:
	ldrh r0,[r5,#0x0]	; 03803D9C
	and r0,r7	; 03803D9E
	cmp r0,#0x0	; 03803DA0
	bne P2_Entry_03803D96	; 03803DA2
	mov r0,#0xff	; 03803DA4
	and r4,r0	; 03803DA6
	ldr r0,[pool_03803DFC]	; 03803DA8
	strh r4,[r0,#0x0]	; 03803DAA
	mov r7,#0x1	; 03803DAC
	ldr r4,[pool_03803DF4]	; 03803DAE
	mov r5,#0x80	; 03803DB0
	b P2_Entry_03803DBA	; 03803DB2
P2_Entry_03803DB4:
	add r0,r7,#0x0	; 03803DB4
	bl P2_SwiWaitByLoop	; 03803DB6
P2_Entry_03803DBA:
	ldrh r0,[r4,#0x0]	; 03803DBA
	and r0,r5	; 03803DBC
	cmp r0,#0x0	; 03803DBE
	bne P2_Entry_03803DB4	; 03803DC0
	ldr r0,[pool_03803E00]	; 03803DC2
	strh r0,[r4,#0x0]	; 03803DC4
	mov r0,#0xff	; 03803DC6
	and r6,r0	; 03803DC8
	ldr r0,[pool_03803DFC]	; 03803DCA
	strh r6,[r0,#0x0]	; 03803DCC
	mov r6,#0x1	; 03803DCE
	ldr r5,[pool_03803DF4]	; 03803DD0
	mov r4,#0x80	; 03803DD2
	b P2_Entry_03803DDC	; 03803DD4
P2_Entry_03803DD6:
	add r0,r6,#0x0	; 03803DD6
	bl P2_SwiWaitByLoop	; 03803DD8
P2_Entry_03803DDC:
	ldrh r0,[r5,#0x0]	; 03803DDC
	and r0,r4	; 03803DDE
	cmp r0,#0x0	; 03803DE0
	bne P2_Entry_03803DD6	; 03803DE2
	add sp,#0x4	; 03803DE4
	pop {r4,r5,r6,r7}	; 03803DE6
	pop {r3}	; 03803DE8
	bx r3	; 03803DEA
pool_03803DEC:
	.word 0x00FF0000	; 03803DEC
pool_03803DF0:
	.word 0x0000FF00	; 03803DF0
pool_03803DF4:
	.word 0x040001C0	; 03803DF4
pool_03803DF8:
	.word 0x00008900	; 03803DF8
pool_03803DFC:
	.word REG_SPIDATA	; 03803DFC
pool_03803E00:
	.word 0x00008100	; 03803E00
P2_Entry_03803E04:
	push {r4,r5,r6,r7,lr}	; 03803E04
	sub sp,#0xc	; 03803E06
	add r4,r1,#0x0	; 03803E08
	add r6,r2,#0x0	; 03803E0A
	cmp r4,#0x1	; 03803E0C
	bcc P2_Entry_03803EEC	; 03803E0E
	add r1,r0,r4	; 03803E10
	sub r1,r1,#0x1	; 03803E12
	lsr r2,r1,#0x8	; 03803E14
	lsr r1,r0,#0x8	; 03803E16
	cmp r2,r1	; 03803E18
	bls P2_Entry_03803E2A	; 03803E1A
	mov r1,#0xff	; 03803E1C
	add r2,r0,#0x0	; 03803E1E
	and r2,r1	; 03803E20
	ldr r1,[pool_03803EF4]	; 03803E22
	sub r1,r1,r2	; 03803E24
	lsl r1,r1,#0x10	; 03803E26
	lsr r4,r1,#0x10	; 03803E28
P2_Entry_03803E2A:
	ldr r1,[pool_03803EF8]	; 03803E2A
	add r2,r0,#0x0	; 03803E2C
	and r2,r1	; 03803E2E
	lsr r1,r2,#0x10	; 03803E30
	add r2,sp,#0x0	; 03803E32
	strh r1,[r2,#0x0]	; 03803E34
	ldr r1,[pool_03803EFC]	; 03803E36
	add r3,r0,#0x0	; 03803E38
	and r3,r1	; 03803E3A
	lsr r1,r3,#0x8	; 03803E3C
	strh r1,[r2,#0x2]	; 03803E3E
	mov r1,#0xff	; 03803E40
	and r0,r1	; 03803E42
	strh r0,[r2,#0x4]	; 03803E44
	ldr r5,[pool_03803F00]	; 03803E46
	mov r7,#0x80	; 03803E48
	b P2_Entry_03803E52	; 03803E4A
P2_Entry_03803E4C:
	mov r0,#0x1	; 03803E4C
	bl P2_SwiWaitByLoop	; 03803E4E
P2_Entry_03803E52:
	ldrh r0,[r5,#0x0]	; 03803E52
	and r0,r7	; 03803E54
	cmp r0,#0x0	; 03803E56
	bne P2_Entry_03803E4C	; 03803E58
	ldr r0,[pool_03803F04]	; 03803E5A
	strh r0,[r5,#0x0]	; 03803E5C
	mov r0,#0xa	; 03803E5E
	ldr r7,[pool_03803F08]	; 03803E60
	strh r0,[r7,#0x0]	; 03803E62
	mov r5,#0x0	; 03803E64
	b P2_Entry_03803E88	; 03803E66
P2_Entry_03803E68:
	mov r0,#0x1	; 03803E68
	bl P2_SwiWaitByLoop	; 03803E6A
P2_Entry_03803E6E:
	ldr r0,[pool_03803F00]	; 03803E6E
	ldrh r1,[r0,#0x0]	; 03803E70
	mov r0,#0x80	; 03803E72
	and r1,r0	; 03803E74
	cmp r1,#0x0	; 03803E76
	bne P2_Entry_03803E68	; 03803E78
	lsl r1,r5,#0x1	; 03803E7A
	add r0,sp,#0x0	; 03803E7C
	ldrh r1,[r0,r1]	; 03803E7E
	mov r0,#0xff	; 03803E80
	and r1,r0	; 03803E82
	strh r1,[r7,#0x0]	; 03803E84
	add r5,r5,#0x1	; 03803E86
P2_Entry_03803E88:
	cmp r5,#0x3	; 03803E88
	blt P2_Entry_03803E6E	; 03803E8A
	mov r5,#0x0	; 03803E8C
	sub r4,r4,#0x1	; 03803E8E
	ldr r7,[pool_03803F00]	; 03803E90
	b P2_Entry_03803EB0	; 03803E92
P2_Entry_03803E94:
	mov r0,#0x1	; 03803E94
	bl P2_SwiWaitByLoop	; 03803E96
P2_Entry_03803E9A:
	ldrh r1,[r7,#0x0]	; 03803E9A
	mov r0,#0x80	; 03803E9C
	and r1,r0	; 03803E9E
	cmp r1,#0x0	; 03803EA0
	bne P2_Entry_03803E94	; 03803EA2
	ldrb r1,[r6,r5]	; 03803EA4
	mov r0,#0xff	; 03803EA6
	and r1,r0	; 03803EA8
	ldr r0,[pool_03803F08]	; 03803EAA
	strh r1,[r0,#0x0]	; 03803EAC
	add r5,r5,#0x1	; 03803EAE
P2_Entry_03803EB0:
	cmp r5,r4	; 03803EB0
	blt P2_Entry_03803E9A	; 03803EB2
	ldr r4,[pool_03803F00]	; 03803EB4
	mov r7,#0x80	; 03803EB6
	b P2_Entry_03803EC0	; 03803EB8
P2_Entry_03803EBA:
	mov r0,#0x1	; 03803EBA
	bl P2_SwiWaitByLoop	; 03803EBC
P2_Entry_03803EC0:
	ldrh r0,[r4,#0x0]	; 03803EC0
	and r0,r7	; 03803EC2
	cmp r0,#0x0	; 03803EC4
	bne P2_Entry_03803EBA	; 03803EC6
	ldr r0,[pool_03803F0C]	; 03803EC8
	strh r0,[r4,#0x0]	; 03803ECA
	ldrb r1,[r6,r5]	; 03803ECC
	mov r0,#0xff	; 03803ECE
	and r1,r0	; 03803ED0
	ldr r0,[pool_03803F08]	; 03803ED2
	strh r1,[r0,#0x0]	; 03803ED4
	mov r6,#0x1	; 03803ED6
	ldr r5,[pool_03803F00]	; 03803ED8
	mov r4,#0x80	; 03803EDA
	b P2_Entry_03803EE4	; 03803EDC
P2_Entry_03803EDE:
	add r0,r6,#0x0	; 03803EDE
	bl P2_SwiWaitByLoop	; 03803EE0
P2_Entry_03803EE4:
	ldrh r0,[r5,#0x0]	; 03803EE4
	and r0,r4	; 03803EE6
	cmp r0,#0x0	; 03803EE8
	bne P2_Entry_03803EDE	; 03803EEA
P2_Entry_03803EEC:
	add sp,#0xc	; 03803EEC
	pop {r4,r5,r6,r7}	; 03803EEE
	pop {r3}	; 03803EF0
	bx r3	; 03803EF2
pool_03803EF4:
	.word 0x00000100	; 03803EF4
pool_03803EF8:
	.word 0x00FF0000	; 03803EF8
pool_03803EFC:
	.word 0x0000FF00	; 03803EFC
pool_03803F00:
	.word REG_SPICNT	; 03803F00
pool_03803F04:
	.word 0x00008900	; 03803F04
pool_03803F08:
	.word REG_SPIDATA	; 03803F08
pool_03803F0C:
	.word 0x00008100	; 03803F0C

; ===== function loc_03803F10 =====
loc_03803F10:
	push {r4,r5,r6,r7,lr}	; 03803F10
	sub sp,#0xc	; 03803F12
	add r4,r1,#0x0	; 03803F14
	add r6,r2,#0x0	; 03803F16
	cmp r4,#0x1	; 03803F18
	bcc loc_03803FEA	; 03803F1A
	ldr r1,[pool_03803FF4]	; 03803F1C
	add r2,r0,#0x0	; 03803F1E
	and r2,r1	; 03803F20
	lsr r1,r2,#0x10	; 03803F22
	add r2,sp,#0x0	; 03803F24
	strh r1,[r2,#0x0]	; 03803F26
	ldr r1,[pool_03803FF8]	; 03803F28
	add r3,r0,#0x0	; 03803F2A
	and r3,r1	; 03803F2C
	lsr r1,r3,#0x8	; 03803F2E
	strh r1,[r2,#0x2]	; 03803F30
	mov r1,#0xff	; 03803F32
	and r0,r1	; 03803F34
	strh r0,[r2,#0x4]	; 03803F36
	ldr r5,[pool_03803FFC]	; 03803F38
	mov r7,#0x80	; 03803F3A
	b loc_03803F44	; 03803F3C
loc_03803F3E:
	mov r0,#0x1	; 03803F3E
	bl loc_03804890	; 03803F40
loc_03803F44:
	ldrh r0,[r5,#0x0]	; 03803F44
	and r0,r7	; 03803F46
	cmp r0,#0x0	; 03803F48
	bne loc_03803F3E	; 03803F4A
	ldr r0,[pool_03804000]	; 03803F4C
	strh r0,[r5,#0x0]	; 03803F4E
	mov r0,#0x3	; 03803F50
	ldr r7,[pool_03804004]	; 03803F52
	strh r0,[r7,#0x0]	; 03803F54
	mov r5,#0x0	; 03803F56
	b loc_03803F7A	; 03803F58
loc_03803F5A:
	mov r0,#0x1	; 03803F5A
	bl loc_03804890	; 03803F5C
loc_03803F60:
	ldr r0,[pool_03803FFC]	; 03803F60
	ldrh r1,[r0,#0x0]	; 03803F62
	mov r0,#0x80	; 03803F64
	and r1,r0	; 03803F66
	cmp r1,#0x0	; 03803F68
	bne loc_03803F5A	; 03803F6A
	lsl r1,r5,#0x1	; 03803F6C
	add r0,sp,#0x0	; 03803F6E
	ldrh r1,[r0,r1]	; 03803F70
	mov r0,#0xff	; 03803F72
	and r1,r0	; 03803F74
	strh r1,[r7,#0x0]	; 03803F76
	add r5,r5,#0x1	; 03803F78
loc_03803F7A:
	cmp r5,#0x3	; 03803F7A
	blt loc_03803F60	; 03803F7C
	ldr r5,[pool_03803FFC]	; 03803F7E
	mov r7,#0x80	; 03803F80
	b loc_03803F8A	; 03803F82
loc_03803F84:
	mov r0,#0x1	; 03803F84
	bl loc_03804890	; 03803F86
loc_03803F8A:
	ldrh r0,[r5,#0x0]	; 03803F8A
	and r0,r7	; 03803F8C
	cmp r0,#0x0	; 03803F8E
	bne loc_03803F84	; 03803F90
	mov r5,#0x0	; 03803F92
	add r7,r5,#0x0	; 03803F94
	b loc_03803FBC	; 03803F96
loc_03803F98:
	ldr r0,[pool_03804004]	; 03803F98
	strh r7,[r0,#0x0]	; 03803F9A
	b loc_03803FA4	; 03803F9C
loc_03803F9E:
	mov r0,#0x1	; 03803F9E
	bl loc_03804890	; 03803FA0
loc_03803FA4:
	ldr r0,[pool_03803FFC]	; 03803FA4
	ldrh r1,[r0,#0x0]	; 03803FA6
	mov r0,#0x80	; 03803FA8
	and r1,r0	; 03803FAA
	cmp r1,#0x0	; 03803FAC
	bne loc_03803F9E	; 03803FAE
	ldr r0,[pool_03804004]	; 03803FB0
	ldrh r1,[r0,#0x0]	; 03803FB2
	mov r0,#0xff	; 03803FB4
	and r1,r0	; 03803FB6
	strb r1,[r6,r5]	; 03803FB8
	add r5,r5,#0x1	; 03803FBA
loc_03803FBC:
	sub r0,r4,#0x1	; 03803FBC
	cmp r5,r0	; 03803FBE
	bcc loc_03803F98	; 03803FC0
	ldr r0,[pool_03804008]	; 03803FC2
	ldr r4,[pool_03803FFC]	; 03803FC4
	strh r0,[r4,#0x0]	; 03803FC6
	mov r1,#0x0	; 03803FC8
	ldr r0,[pool_03804004]	; 03803FCA
	strh r1,[r0,#0x0]	; 03803FCC
	mov r7,#0x80	; 03803FCE
	b loc_03803FD8	; 03803FD0
loc_03803FD2:
	mov r0,#0x1	; 03803FD2
	bl loc_03804890	; 03803FD4
loc_03803FD8:
	ldrh r0,[r4,#0x0]	; 03803FD8
	and r0,r7	; 03803FDA
	cmp r0,#0x0	; 03803FDC
	bne loc_03803FD2	; 03803FDE
	ldr r0,[pool_03804004]	; 03803FE0
	ldrh r1,[r0,#0x0]	; 03803FE2
	mov r0,#0xff	; 03803FE4
	and r1,r0	; 03803FE6
	strb r1,[r6,r5]	; 03803FE8
loc_03803FEA:
	add sp,#0xc	; 03803FEA
	pop {r4,r5,r6,r7}	; 03803FEC
	pop {r3}	; 03803FEE
	bx r3	; 03803FF0
	.byte 0xC0, 0x46	; 03803FF4
pool_03803FF4:
loc_03803FF4:
	.word 0x00FF0000	; 03803FF4
pool_03803FF8:
loc_03803FF8:
	.word 0x0000FF00	; 03803FF8
pool_03803FFC:
loc_03803FFC:
	.word REG_SPICNT	; 03803FFC
pool_03804000:
loc_03804000:
	.word 0x00008900	; 03804000
pool_03804004:
loc_03804004:
	.word REG_SPIDATA	; 03804004
pool_03804008:
loc_03804008:
	.word 0x00008100	; 03804008

; ===== function loc_0380400C =====
loc_0380400C:
	push {r4,r5,r6,r7,lr}	; 0380400C
	sub sp,#0x4	; 0380400E
	add r5,r0,#0x0	; 03804010
	mov r7,#0x1	; 03804012
	ldr r4,[pool_0380407C]	; 03804014
	mov r6,#0x80	; 03804016
	b loc_03804020	; 03804018
loc_0380401A:
	add r0,r7,#0x0	; 0380401A
	bl loc_03804890	; 0380401C
loc_03804020:
	ldrh r0,[r4,#0x0]	; 03804020
	and r0,r6	; 03804022
	cmp r0,#0x0	; 03804024
	bne loc_0380401A	; 03804026
	ldr r0,[pool_03804080]	; 03804028
	strh r0,[r4,#0x0]	; 0380402A
	mov r1,#0x5	; 0380402C
	ldr r0,[pool_03804084]	; 0380402E
	strh r1,[r0,#0x0]	; 03804030
	mov r7,#0x1	; 03804032
	ldr r4,[pool_0380407C]	; 03804034
	mov r6,#0x80	; 03804036
	b loc_03804040	; 03804038
loc_0380403A:
	add r0,r7,#0x0	; 0380403A
	bl loc_03804890	; 0380403C
loc_03804040:
	ldrh r0,[r4,#0x0]	; 03804040
	and r0,r6	; 03804042
	cmp r0,#0x0	; 03804044
	bne loc_0380403A	; 03804046
	ldr r0,[pool_03804088]	; 03804048
	strh r0,[r4,#0x0]	; 0380404A
	mov r1,#0x0	; 0380404C
	ldr r0,[pool_03804084]	; 0380404E
	strh r1,[r0,#0x0]	; 03804050
	mov r7,#0x1	; 03804052
	ldr r4,[pool_0380407C]	; 03804054
	mov r6,#0x80	; 03804056
	b loc_03804060	; 03804058
loc_0380405A:
	add r0,r7,#0x0	; 0380405A
	bl loc_03804890	; 0380405C
loc_03804060:
	ldrh r0,[r4,#0x0]	; 03804060
	and r0,r6	; 03804062
	cmp r0,#0x0	; 03804064
	bne loc_0380405A	; 03804066
	ldr r0,[pool_03804084]	; 03804068
	ldrh r1,[r0,#0x0]	; 0380406A
	mov r0,#0xff	; 0380406C
	and r1,r0	; 0380406E
	strb r1,[r5,#0x0]	; 03804070
	add sp,#0x4	; 03804072
	pop {r4,r5,r6,r7}	; 03804074
	pop {r3}	; 03804076
	bx r3	; 03804078
	.byte 0xC0, 0x46	; 0380407C
pool_0380407C:
loc_0380407C:
	.word REG_SPICNT	; 0380407C
pool_03804080:
loc_03804080:
	.word 0x00008900	; 03804080
pool_03804084:
loc_03804084:
	.word REG_SPIDATA	; 03804084
pool_03804088:
loc_03804088:
	.word 0x00008100	; 03804088
P2_Entry_0380408C:
	push {r4,r5,r6,lr}	; 0380408C
	mov r6,#0x1	; 0380408E
	ldr r5,[pool_038040CC]	; 03804090
	mov r4,#0x80	; 03804092
	b P2_Entry_0380409C	; 03804094
P2_Entry_03804096:
	add r0,r6,#0x0	; 03804096
	bl P2_SwiWaitByLoop	; 03804098
P2_Entry_0380409C:
	ldrh r0,[r5,#0x0]	; 0380409C
	and r0,r4	; 0380409E
	cmp r0,#0x0	; 038040A0
	bne P2_Entry_03804096	; 038040A2
	ldr r0,[pool_038040D0]	; 038040A4
	strh r0,[r5,#0x0]	; 038040A6
	mov r1,#0x4	; 038040A8
	ldr r0,[pool_038040D4]	; 038040AA
	strh r1,[r0,#0x0]	; 038040AC
	mov r6,#0x1	; 038040AE
	ldr r5,[pool_038040CC]	; 038040B0
	mov r4,#0x80	; 038040B2
	b P2_Entry_038040BC	; 038040B4
P2_Entry_038040B6:
	add r0,r6,#0x0	; 038040B6
	.byte 0x00, 0xF0	; 038040B8
loc_038040BA:
	.byte 0xEA, 0xFB	; 038040BA
P2_Entry_038040BC:
	ldrh r0,[r5,#0x0]	; 038040BC
	and r0,r4	; 038040BE
	cmp r0,#0x0	; 038040C0
	bne P2_Entry_038040B6	; 038040C2
	pop {r4,r5,r6}	; 038040C4
	pop {r3}	; 038040C6
	bx r3	; 038040C8
	.byte 0xC0, 0x46	; 038040CA
pool_038040CC:
	.word 0x040001C0	; 038040CC
pool_038040D0:
	.word 0x00008100	; 038040D0
pool_038040D4:
	.word REG_SPIDATA	; 038040D4
P2_Entry_038040D8:
	push {r4,r5,r6,lr}	; 038040D8
	mov r6,#0x1	; 038040DA
	ldr r5,[pool_03804118]	; 038040DC
	mov r4,#0x80	; 038040DE
	b P2_Entry_038040E8	; 038040E0
P2_Entry_038040E2:
	add r0,r6,#0x0	; 038040E2
	bl P2_SwiWaitByLoop	; 038040E4
P2_Entry_038040E8:
	ldrh r0,[r5,#0x0]	; 038040E8
	and r0,r4	; 038040EA
	cmp r0,#0x0	; 038040EC
	bne P2_Entry_038040E2	; 038040EE
	ldr r0,[pool_0380411C]	; 038040F0
	strh r0,[r5,#0x0]	; 038040F2
	mov r1,#0x6	; 038040F4
	ldr r0,[pool_03804120]	; 038040F6
	strh r1,[r0,#0x0]	; 038040F8
	mov r6,#0x1	; 038040FA
	ldr r5,[pool_03804118]	; 038040FC
	mov r4,#0x80	; 038040FE
	b P2_Entry_03804108	; 03804100
P2_Entry_03804102:
	add r0,r6,#0x0	; 03804102
	bl P2_SwiWaitByLoop	; 03804104
P2_Entry_03804108:
	ldrh r0,[r5,#0x0]	; 03804108
	and r0,r4	; 0380410A
	cmp r0,#0x0	; 0380410C
	bne P2_Entry_03804102	; 0380410E
	pop {r4,r5,r6}	; 03804110
	pop {r3}	; 03804112
	bx r3	; 03804114
	.byte 0xC0, 0x46	; 03804116
pool_03804118:
	.word 0x040001C0	; 03804118
pool_0380411C:
	.word 0x00008100	; 0380411C
pool_03804120:
	.word REG_SPIDATA	; 03804120
P2_Entry_03804124:
	push {r4,r5,lr}	; 03804124
	sub sp,#0x4	; 03804126
	add r4,r0,#0x0	; 03804128
	bl loc_037FDC9C	; 0380412A
	add r5,r0,#0x0	; 0380412E
	mov r0,#0x3	; 03804130
	bl P2_Entry_03802E2C	; 03804132
	cmp r0,#0x0	; 03804136
	bne P2_Entry_0380414E	; 03804138
	add r0,r5,#0x0	; 0380413A
	bl loc_037FDCC0	; 0380413C
	ldr r0,[r4,#0x4]	; 03804140
	lsl r0,r0,#0x10	; 03804142
	lsr r0,r0,#0x10	; 03804144
	mov r1,#0x4	; 03804146
	bl loc_03802E40	; 03804148
	b P2_Entry_0380420C	; 0380414C
P2_Entry_0380414E:
	mov r0,#0x3	; 0380414E
	bl loc_03802E1C	; 03804150
	add r0,r5,#0x0	; 03804154
	bl loc_037FDCC0	; 03804156
	ldr r0,[r4,#0x4]	; 0380415A
	add r1,r0,#0x0	; 0380415C
	sub r1,#0x61	; 0380415E
	cmp r1,#0x5	; 03804160
	bhi P2_Entry_038041FC	; 03804162
	add r1,r1,r1	; 03804164
P2_SwitchIndexPC_03804164:
	add r1,pc	; 03804166
	ldrh r1,[r1,#(P2_SwitchTable_03804164 - (P2_SwitchIndexPC_03804164 + 4))]	; 03804168
	lsl r1,r1,#0x10	; 0380416A
	asr r1,r1,#0x10	; 0380416C
P2_SwitchTargetPC_03804164:
	add r1,pc	; 0380416E
	bx r1	; 03804170
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03804164:
	.halfword (P2_Case_0380417E + 1) - (P2_SwitchTargetPC_03804164 + 4)
	.halfword (P2_Entry_038041FC + 1) - (P2_SwitchTargetPC_03804164 + 4)
	.halfword (P2_Case_038041DC + 1) - (P2_SwitchTargetPC_03804164 + 4)
	.halfword (P2_Case_03804196 + 1) - (P2_SwitchTargetPC_03804164 + 4)
	.halfword (P2_Case_038041BA + 1) - (P2_SwitchTargetPC_03804164 + 4)
	.halfword (P2_Case_038041F4 + 1) - (P2_SwitchTargetPC_03804164 + 4)
P2_SwitchTable_03804164End:
P2_Case_0380417E:
	mov r1,#0x1	; 0380417E
	ldr r0,[pool_03804214]	; 03804180
	str r1,[r0,#0x20]	; 03804182
	ldr r1,[r4,#0x8]	; 03804184
	ldr r0,[pool_03804218]	; 03804186
	strh r1,[r0,#0x0]	; 03804188
	ldr r1,[r4,#0xc]	; 0380418A
	ldr r0,[pool_0380421C]	; 0380418C
	strh r1,[r0,#0x0]	; 0380418E
	bl P2_Entry_03804620	; 03804190
	b P2_Entry_03804206	; 03804194
P2_Case_03804196:
	mov r1,#0x4	; 03804196
	ldr r0,[pool_03804214]	; 03804198
	str r1,[r0,#0x20]	; 0380419A
	ldr r2,[r4,#0x8]	; 0380419C
	str r2,[r0,#0x28]	; 0380419E
	ldr r1,[r4,#0xc]	; 038041A0
	str r1,[r0,#0x24]	; 038041A2
	lsl r0,r2,#0x10	; 038041A4
	lsr r0,r0,#0x10	; 038041A6
	lsl r1,r1,#0x18	; 038041A8
	lsr r1,r1,#0x18	; 038041AA
	bl loc_03804494	; 038041AC
	mov r0,#0x64	; 038041B0
	mov r1,#0x0	; 038041B2
	bl loc_03802E40	; 038041B4
	b P2_Entry_03804206	; 038041B8
P2_Case_038041BA:
	mov r1,#0x3	; 038041BA
	ldr r0,[pool_03804214]	; 038041BC
	str r1,[r0,#0x20]	; 038041BE
	ldr r1,[r4,#0x8]	; 038041C0
	str r1,[r0,#0x28]	; 038041C2
	lsl r0,r1,#0x10	; 038041C4
	lsr r4,r0,#0x10	; 038041C6
	add r0,r4,#0x0	; 038041C8
	bl P2_ReadPmicRegister	; 038041CA
	add r1,r0,#0x0	; 038041CE
	add r4,#0x70	; 038041D0
	lsl r0,r4,#0x10	; 038041D2
	lsr r0,r0,#0x10	; 038041D4
	bl loc_03802E40	; 038041D6
	b P2_Entry_03804206	; 038041DA
P2_Case_038041DC:
	mov r0,#0x2	; 038041DC
	ldr r1,[pool_03804214]	; 038041DE
	str r0,[r1,#0x20]	; 038041E0
	ldr r0,[r4,#0x8]	; 038041E2
	str r0,[r1,#0x24]	; 038041E4
	bl P2_Entry_03804550	; 038041E6
	mov r0,#0x63	; 038041EA
	mov r1,#0x0	; 038041EC
	bl loc_03802E40	; 038041EE
	b P2_Entry_03804206	; 038041F2
P2_Case_038041F4:
	ldr r0,[r4,#0x8]	; 038041F4
	bl P2_Entry_0380450C	; 038041F6
	b P2_Entry_03804206	; 038041FA
P2_Entry_038041FC:
	lsl r0,r0,#0x10	; 038041FC
	lsr r0,r0,#0x10	; 038041FE
	mov r1,#0x1	; 03804200
	bl loc_03802E40	; 03804202
P2_Entry_03804206:
	mov r0,#0x3	; 03804206
	bl P2_Entry_03802DF4	; 03804208
P2_Entry_0380420C:
	add sp,#0x4	; 0380420C
	pop {r4,r5}	; 0380420E
	pop {r3}	; 03804210
	bx r3	; 03804212
pool_03804214:
	.word P2_BssStart + 0x26A0	; 03804214
pool_03804218:
	.word P2_BssStart + 0x2698	; 03804218
pool_0380421C:
	.word P2_BssStart + 0x2694	; 0380421C

; ===== function loc_03804220 =====
loc_03804220:
	push {r4,r5,r6,lr}	; 03804220
	sub sp,#0x8	; 03804222
	ldr r1,[pool_03804350]	; 03804224
	add r2,r0,#0x0	; 03804226
	and r2,r1	; 03804228
	cmp r2,#0x0	; 0380422A
	beq loc_0380423E	; 0380422C
	mov r4,#0x0	; 0380422E
	add r3,r4,#0x0	; 03804230
	ldr r1,[pool_03804354]	; 03804232
loc_03804234:
	lsl r2,r4,#0x1	; 03804234
	strh r3,[r1,r2]	; 03804236
	add r4,r4,#0x1	; 03804238
	cmp r4,#0x10	; 0380423A
	blt loc_03804234	; 0380423C
loc_0380423E:
	ldr r1,[pool_03804358]	; 0380423E
	add r2,r0,#0x0	; 03804240
	and r2,r1	; 03804242
	lsr r1,r2,#0x10	; 03804244
	lsl r1,r1,#0x1	; 03804246
	ldr r5,[pool_03804354]	; 03804248
	strh r0,[r5,r1]	; 0380424A
	ldr r1,[pool_0380435C]	; 0380424C
	and r0,r1	; 0380424E
	cmp r0,#0x0	; 03804250
	beq loc_03804348	; 03804252
	ldrh r3,[r5,#0x0]	; 03804254
	ldr r0,[pool_03804360]	; 03804256
	add r1,r3,#0x0	; 03804258
	and r1,r0	; 0380425A
	lsl r0,r1,#0x8	; 0380425C
	lsr r4,r0,#0x10	; 0380425E
	add r0,r4,#0x0	; 03804260
	sub r0,#0x60	; 03804262
	cmp r0,#0x7	; 03804264
	bhi loc_03804340	; 03804266
	add r0,r0,r0	; 03804268
P2_SwitchIndexPC_03804268:
	add r0,pc	; 0380426A
	ldrh r0,[r0,#(P2_SwitchTable_03804268 - (P2_SwitchIndexPC_03804268 + 4))]	; 0380426C
	lsl r0,r0,#0x10	; 0380426E
	asr r0,r0,#0x10	; 03804270
P2_SwitchTargetPC_03804268:
	add r0,pc	; 03804272
	bx r0	; 03804274
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03804268:
	.halfword (loc_03804286 + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_03804290 + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_03804340 + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_038042F4 + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_038042B4 + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_038042D8 + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_0380431A + 1) - (P2_SwitchTargetPC_03804268 + 4)
	.halfword (loc_0380432E + 1) - (P2_SwitchTargetPC_03804268 + 4)
P2_SwitchTable_03804268End:
loc_03804286:
	mov r0,#0x60	; 03804286
	mov r1,#0x0	; 03804288
	bl loc_03802E40	; 0380428A
	b loc_03804348	; 0380428E
loc_03804290:
	ldrh r1,[r5,#0x2]	; 03804290
	ldr r0,[pool_03804364]	; 03804292
	and r1,r0	; 03804294
	str r1,[sp,#0x0]	; 03804296
	mov r0,#0x3	; 03804298
	add r1,r4,#0x0	; 0380429A
	mov r2,#0x2	; 0380429C
	mov r5,#0xff	; 0380429E
	and r3,r5	; 038042A0
	bl loc_03802D4C	; 038042A2
	cmp r0,#0x0	; 038042A6
	bne loc_03804348	; 038042A8
	add r0,r4,#0x0	; 038042AA
	mov r1,#0x4	; 038042AC
	bl loc_03802E40	; 038042AE
	b loc_03804348	; 038042B2
loc_038042B4:
	ldrh r1,[r5,#0x2]	; 038042B4
	ldr r0,[pool_03804364]	; 038042B6
	and r1,r0	; 038042B8
	str r1,[sp,#0x0]	; 038042BA
	mov r0,#0x3	; 038042BC
	add r1,r4,#0x0	; 038042BE
	mov r2,#0x2	; 038042C0
	mov r5,#0xff	; 038042C2
	and r3,r5	; 038042C4
	bl loc_03802D4C	; 038042C6
	cmp r0,#0x0	; 038042CA
	bne loc_03804348	; 038042CC
	add r0,r4,#0x0	; 038042CE
	mov r1,#0x4	; 038042D0
	bl loc_03802E40	; 038042D2
	b loc_03804348	; 038042D6
loc_038042D8:
	mov r0,#0x3	; 038042D8
	add r1,r4,#0x0	; 038042DA
	mov r2,#0x1	; 038042DC
	ldr r5,[pool_03804364]	; 038042DE
	and r3,r5	; 038042E0
	bl loc_03802D4C	; 038042E2
	cmp r0,#0x0	; 038042E6
	bne loc_03804348	; 038042E8
	add r0,r4,#0x0	; 038042EA
	mov r1,#0x4	; 038042EC
	bl loc_03802E40	; 038042EE
	b loc_03804348	; 038042F2
loc_038042F4:
	mov r0,#0x3	; 038042F4
	add r1,r4,#0x0	; 038042F6
	mov r2,#0x1	; 038042F8
	mov r6,#0xff	; 038042FA
	and r3,r6	; 038042FC
	lsl r3,r3,#0x10	; 038042FE
	ldrh r6,[r5,#0x2]	; 03804300
	ldr r5,[pool_03804364]	; 03804302
	and r6,r5	; 03804304
	orr r3,r6	; 03804306
	bl loc_03802D4C	; 03804308
	cmp r0,#0x0	; 0380430C
	bne loc_03804348	; 0380430E
	add r0,r4,#0x0	; 03804310
	mov r1,#0x4	; 03804312
	bl loc_03802E40	; 03804314
	b loc_03804348	; 03804318
loc_0380431A:
	mov r0,#0xff	; 0380431A
	and r3,r0	; 0380431C
	add r0,r3,#0x0	; 0380431E
	bl loc_03804778	; 03804320
	mov r0,#0x66	; 03804324
	mov r1,#0x0	; 03804326
	bl loc_03802E40	; 03804328
	b loc_03804348	; 0380432C
loc_0380432E:
	bl loc_0380476C	; 0380432E
	add r1,r0,#0x0	; 03804332
	mov r0,#0x67	; 03804334
	lsl r1,r1,#0x10	; 03804336
	lsr r1,r1,#0x10	; 03804338
	bl loc_03802E40	; 0380433A
	b loc_03804348	; 0380433E
loc_03804340:
	add r0,r4,#0x0	; 03804340
	mov r1,#0x1	; 03804342
	bl loc_03802E40	; 03804344
loc_03804348:
	add sp,#0x8	; 03804348
	pop {r4,r5,r6}	; 0380434A
	pop {r3}	; 0380434C
	bx r3	; 0380434E
pool_03804350:
loc_03804350:
	.word 0x02000000	; 03804350
pool_03804354:
loc_03804354:
	.word P2_BssStart + 0x26A0	; 03804354
pool_03804358:
loc_03804358:
	.word 0x000F0000	; 03804358
pool_0380435C:
loc_0380435C:
	.word 0x01000000	; 0380435C
pool_03804360:
loc_03804360:
	.word 0x0000FF00	; 03804360
pool_03804364:
loc_03804364:
	.word 0x0000FFFF	; 03804364

; ===== function loc_03804368 =====
loc_03804368:
	mov r1,#0x1	; 03804368
	ldr r0,[pool_03804384]	; 0380436A
	str r1,[r0,#0x0]	; 0380436C
	mov r3,#0x0	; 0380436E
	ldr r0,[pool_03804388]	; 03804370
	str r3,[r0,#0x20]	; 03804372
	add r2,r3,#0x0	; 03804374
loc_03804376:
	lsl r1,r3,#0x1	; 03804376
	strh r2,[r0,r1]	; 03804378
	add r3,r3,#0x1	; 0380437A
	cmp r3,#0x10	; 0380437C
	blt loc_03804376	; 0380437E
	bx lr	; 03804380
	.byte 0xC0, 0x46	; 03804384
pool_03804384:
loc_03804384:
	.word P2_BssStart + 0x269C	; 03804384
pool_03804388:
loc_03804388:
	.word P2_BssStart + 0x26A0	; 03804388
P2_Entry_0380438C:
	ldr r3,[pool_038043A8]	; 0380438C
	and r2,r3	; 0380438E
	ldr r3,[pool_038043AC]	; 03804390
	and r0,r3	; 03804392
	lsl r3,r0,#0x16	; 03804394
	ldr r0,[pool_038043B0]	; 03804396
	and r1,r0	; 03804398
	lsl r0,r1,#0x10	; 0380439A
	orr r3,r0	; 0380439C
	orr r2,r3	; 0380439E
	add r0,r2,#0x0	; 038043A0
	ldr r3,[pool_038043B4]	; 038043A2
	bx r3	; 038043A4
	.byte 0xC0, 0x46	; 038043A6
pool_038043A8:
	.word 0x0000FFFF	; 038043A8
pool_038043AC:
	.word 0x03C00000	; 038043AC
pool_038043B0:
	.word 0x003F0000	; 038043B0
pool_038043B4:
	.word P2_Entry_038043B8 + 1	; 038043B4
P2_Entry_038043B8:
	push {r4,r5,r6,lr}	; 038043B8
	add r5,r0,#0x0	; 038043BA
	mov r4,#0x8	; 038043BC
	mov r6,#0x0	; 038043BE
P2_Entry_038043C0:
	add r0,r4,#0x0	; 038043C0
	add r1,r5,#0x0	; 038043C2
	add r2,r6,#0x0	; 038043C4
	bl loc_03801EEC	; 038043C6
	cmp r0,#0x0	; 038043CA
	bne P2_Entry_038043C0	; 038043CC
	pop {r4,r5,r6}	; 038043CE
	pop {r3}	; 038043D0
	bx r3	; 038043D2

; ===== function loc_038043D4 =====
loc_038043D4:
	push {r4,lr}	; 038043D4
	add r4,r0,#0x0	; 038043D6
	mov r0,#0x0	; 038043D8
	bl P2_ReadPmicRegister	; 038043DA
	bic r0,r4	; 038043DE
	lsl r0,r0,#0x18	; 038043E0
	lsr r1,r0,#0x18	; 038043E2
	mov r0,#0x0	; 038043E4
	bl loc_03804494	; 038043E6
	pop {r4}	; 038043EA
	pop {r3}	; 038043EC
	bx r3	; 038043EE

; ===== function loc_038043F0 =====
loc_038043F0:
	push {r4,lr}	; 038043F0
	add r4,r0,#0x0	; 038043F2
	mov r0,#0x0	; 038043F4
	bl P2_ReadPmicRegister	; 038043F6
	add r1,r0,#0x0	; 038043FA
	orr r1,r4	; 038043FC
	mov r0,#0x0	; 038043FE
	bl loc_03804494	; 03804400
	pop {r4}	; 03804404
	pop {r3}	; 03804406
	bx r3	; 03804408
	.byte 0x00, 0x00	; 0380440C

; ===== function loc_0380440C =====
loc_0380440C:
; 通过 SPI 读取 r0 指定的电源管理寄存器，返回低 8 位。
; Read the PMIC register selected by r0 over SPI; return its low byte.
.func P2_ReadPmicRegister
	push {r4,r5,r6,r7,lr}	; 0380440C
	sub sp,#0x4	; 0380440E
	add r5,r0,#0x0	; 03804410
	mov r7,#0x1	; 03804412
	ldr r4,[pool_0380448C]	; 03804414
	mov r6,#0x80	; 03804416
	b loc_03804420	; 03804418
loc_0380441A:
	add r0,r7,#0x0	; 0380441A
	bl loc_03804890	; 0380441C
loc_03804420:
	ldrh r0,[r4,#0x0]	; 03804420
	and r0,r6	; 03804422
	cmp r0,#0x0	; 03804424
	bne loc_0380441A	; 03804426
	mov r0,#0x1	; 03804428
	bl P2_SetPmicSpiHold	; 0380442A
	mov r4,#0x80	; 0380442E
	orr r5,r4	; 03804430
	lsl r0,r5,#0x18	; 03804432
	lsr r1,r0,#0x18	; 03804434
	mov r0,#0xff	; 03804436
	and r1,r0	; 03804438
	ldr r0,[pool_03804490]	; 0380443A
	strh r1,[r0,#0x0]	; 0380443C
	mov r6,#0x1	; 0380443E
	ldr r5,[pool_0380448C]	; 03804440
	b loc_0380444A	; 03804442
loc_03804444:
	add r0,r6,#0x0	; 03804444
	bl loc_03804890	; 03804446
loc_0380444A:
	ldrh r0,[r5,#0x0]	; 0380444A
	and r0,r4	; 0380444C
	cmp r0,#0x0	; 0380444E
	bne loc_03804444	; 03804450
	mov r0,#0x0	; 03804452
	bl P2_SetPmicSpiHold	; 03804454
	mov r1,#0x0	; 03804458
	ldr r0,[pool_03804490]	; 0380445A
	strh r1,[r0,#0x0]	; 0380445C
	mov r6,#0x1	; 0380445E
	ldr r5,[pool_0380448C]	; 03804460
	mov r4,#0x80	; 03804462
	b loc_0380446C	; 03804464
loc_03804466:
	add r0,r6,#0x0	; 03804466
	bl loc_03804890	; 03804468
loc_0380446C:
	ldrh r0,[r5,#0x0]	; 0380446C
	and r0,r4	; 0380446E
	cmp r0,#0x0	; 03804470
	bne loc_03804466	; 03804472
	ldr r0,[pool_03804490]	; 03804474
	ldrh r1,[r0,#0x0]	; 03804476
	mov r0,#0xff	; 03804478
	and r1,r0	; 0380447A
	lsl r0,r1,#0x10	; 0380447C
	lsr r0,r0,#0x10	; 0380447E
	lsl r0,r0,#0x18	; 03804480
	lsr r0,r0,#0x18	; 03804482
	add sp,#0x4	; 03804484
	pop {r4,r5,r6,r7}	; 03804486
	pop {r3}	; 03804488
	bx r3	; 0380448A
.endfunc
pool_0380448C:
loc_0380448C:
	.word REG_SPICNT	; 0380448C
pool_03804490:
loc_03804490:
	.word REG_SPIDATA	; 03804490

; ===== function loc_03804494 =====
loc_03804494:
	push {r4,r5,r6,r7,lr}	; 03804494
	sub sp,#0x4	; 03804496
	add r5,r0,#0x0	; 03804498
	add r4,r1,#0x0	; 0380449A
	ldr r6,[pool_038044F0]	; 0380449C
	mov r7,#0x80	; 0380449E
	b loc_038044A8	; 038044A0
loc_038044A2:
	mov r0,#0x1	; 038044A2
	bl loc_03804890	; 038044A4
loc_038044A8:
	ldrh r0,[r6,#0x0]	; 038044A8
	and r0,r7	; 038044AA
	cmp r0,#0x0	; 038044AC
	bne loc_038044A2	; 038044AE
	mov r0,#0x1	; 038044B0
	bl P2_SetPmicSpiHold	; 038044B2
	lsl r0,r5,#0x18	; 038044B6
	lsr r1,r0,#0x18	; 038044B8
	mov r0,#0xff	; 038044BA
	and r1,r0	; 038044BC
	ldr r0,[pool_038044F4]	; 038044BE
	strh r1,[r0,#0x0]	; 038044C0
	mov r7,#0x1	; 038044C2
	ldr r5,[pool_038044F0]	; 038044C4
	mov r6,#0x80	; 038044C6
	b loc_038044D0	; 038044C8
loc_038044CA:
	add r0,r7,#0x0	; 038044CA
	bl loc_03804890	; 038044CC
loc_038044D0:
	ldrh r0,[r5,#0x0]	; 038044D0
	and r0,r6	; 038044D2
	cmp r0,#0x0	; 038044D4
	bne loc_038044CA	; 038044D6
	mov r0,#0x0	; 038044D8
	bl P2_SetPmicSpiHold	; 038044DA
	mov r0,#0xff	; 038044DE
	and r4,r0	; 038044E0
	ldr r0,[pool_038044F4]	; 038044E2
	strh r4,[r0,#0x0]	; 038044E4
	add sp,#0x4	; 038044E6
	pop {r4,r5,r6,r7}	; 038044E8
	pop {r3}	; 038044EA
	bx r3	; 038044EC
	.byte 0xC0, 0x46	; 038044F0
pool_038044F0:
loc_038044F0:
	.word REG_SPICNT	; 038044F0
pool_038044F4:
loc_038044F4:
	.word REG_SPIDATA	; 038044F4

; ===== function loc_038044F8 =====
loc_038044F8:
; 选择 PMIC 的 SPI 通道；r0 控制两次传输之间是否保持片选。
; Select the PMIC SPI device; r0 controls chip-select hold between transfers.
.func P2_SetPmicSpiHold
	lsl r1,r0,#0xb	; 038044F8
	ldr r0,[pool_03804504]	; 038044FA
	orr r1,r0	; 038044FC
	ldr r0,[pool_03804508]	; 038044FE
	strh r1,[r0,#0x0]	; 03804500
	bx lr	; 03804502
.endfunc
pool_03804504:
loc_03804504:
	.word 0x00008002	; 03804504
pool_03804508:
loc_03804508:
	.word REG_SPICNT	; 03804508

; ===== function loc_0380450C =====
P2_Entry_0380450C:
	push {r4,lr}	; 0380450C
	add r4,r0,#0x0	; 0380450E
	cmp r4,#0x1	; 03804510
	beq loc_0380451E	; 03804512
	cmp r4,#0x2	; 03804514
	beq loc_0380452E	; 03804516
	cmp r4,#0x3	; 03804518
	beq loc_03804526	; 0380451A
	b loc_0380453C	; 0380451C
loc_0380451E:
	mov r0,#0x10	; 0380451E
	bl loc_038043D4	; 03804520
	b loc_03804540	; 03804524
loc_03804526:
	mov r0,#0x30	; 03804526
	bl loc_038043F0	; 03804528
	b loc_03804540	; 0380452C
loc_0380452E:
	mov r0,#0x20	; 0380452E
	bl loc_038043D4	; 03804530
	mov r0,#0x10	; 03804534
	bl loc_038043F0	; 03804536
	b loc_03804540	; 0380453A
loc_0380453C:
	bl loc_037FF190	; 0380453C
loc_03804540:
	ldr r0,[pool_0380454C]	; 03804540
	str r4,[r0,#0x0]	; 03804542
	pop {r4}	; 03804544
	pop {r3}	; 03804546
	bx r3	; 03804548
	.byte 0xC0, 0x46	; 0380454C
pool_0380454C:
loc_0380454C:
	.word P2_Data_038052C0	; 0380454C
P2_Entry_03804550:
	push {lr}	; 03804550
	sub sp,#0x4	; 03804552
	cmp r0,#0xf	; 03804554
	bhi P2_Entry_03804618	; 03804556
	add r0,r0,r0	; 03804558
P2_SwitchIndexPC_03804558:
	add r0,pc	; 0380455A
	ldrh r0,[r0,#(P2_SwitchTable_03804558 - (P2_SwitchIndexPC_03804558 + 4))]	; 0380455C
	lsl r0,r0,#0x10	; 0380455E
	asr r0,r0,#0x10	; 03804560
P2_SwitchTargetPC_03804558:
	add r0,pc	; 03804562
	bx r0	; 03804564
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03804558:
	.halfword (P2_Entry_03804618 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_03804586 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_03804594 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045A2 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045B0 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045B8 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045C0 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045C8 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045D0 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045D8 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045E0 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045E8 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045F0 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_038045F8 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_03804608 + 1) - (P2_SwitchTargetPC_03804558 + 4)
	.halfword (P2_Case_03804600 + 1) - (P2_SwitchTargetPC_03804558 + 4)
P2_SwitchTable_03804558End:
P2_Case_03804586:
	mov r0,#0x1	; 03804586
	bl loc_03804778	; 03804588
	mov r0,#0x1	; 0380458C
	bl P2_Entry_0380450C	; 0380458E
	b P2_Entry_03804618	; 03804592
P2_Case_03804594:
	mov r0,#0x3	; 03804594
	bl loc_03804778	; 03804596
	mov r0,#0x3	; 0380459A
	bl P2_Entry_0380450C	; 0380459C
	b P2_Entry_03804618	; 038045A0
P2_Case_038045A2:
	mov r0,#0x2	; 038045A2
	bl loc_03804778	; 038045A4
	mov r0,#0x2	; 038045A8
	bl P2_Entry_0380450C	; 038045AA
	b P2_Entry_03804618	; 038045AE
P2_Case_038045B0:
	mov r0,#0x4	; 038045B0
	bl loc_038043F0	; 038045B2
	b P2_Entry_03804618	; 038045B6
P2_Case_038045B8:
	mov r0,#0x4	; 038045B8
	bl loc_038043D4	; 038045BA
	b P2_Entry_03804618	; 038045BE
P2_Case_038045C0:
	mov r0,#0x8	; 038045C0
	bl loc_038043F0	; 038045C2
	b P2_Entry_03804618	; 038045C6
P2_Case_038045C8:
	mov r0,#0x8	; 038045C8
	bl loc_038043D4	; 038045CA
	b P2_Entry_03804618	; 038045CE
P2_Case_038045D0:
	mov r0,#0xc	; 038045D0
	bl loc_038043F0	; 038045D2
	b P2_Entry_03804618	; 038045D6
P2_Case_038045D8:
	mov r0,#0xc	; 038045D8
	bl loc_038043D4	; 038045DA
	b P2_Entry_03804618	; 038045DE
P2_Case_038045E0:
	mov r0,#0x1	; 038045E0
	bl loc_038043F0	; 038045E2
	b P2_Entry_03804618	; 038045E6
P2_Case_038045E8:
	mov r0,#0x1	; 038045E8
	bl loc_038043D4	; 038045EA
	b P2_Entry_03804618	; 038045EE
P2_Case_038045F0:
	mov r0,#0x2	; 038045F0
	bl loc_038043F0	; 038045F2
	b P2_Entry_03804618	; 038045F6
P2_Case_038045F8:
	mov r0,#0x2	; 038045F8
	bl loc_038043D4	; 038045FA
	b P2_Entry_03804618	; 038045FE
P2_Case_03804600:
	mov r0,#0x40	; 03804600
	bl loc_038043D4	; 03804602
	b P2_Entry_03804618	; 03804606
P2_Case_03804608:
	bl P2_Entry_037FF434	; 03804608
	mov r0,#0x1	; 0380460C
	bl loc_038043D4	; 0380460E
	mov r0,#0x40	; 03804612
	bl loc_038043F0	; 03804614
P2_Entry_03804618:
	add sp,#0x4	; 03804618
	pop {r3}	; 0380461A
	bx r3	; 0380461C
	.byte 0x00, 0x00	; 0380461E
P2_Entry_03804620:
	push {r4,r5,r6,r7,lr}	; 03804620
	sub sp,#0x4	; 03804622
	ldr r1,[pool_03804734]	; 03804624
	ldrh r4,[r1,#0x0]	; 03804626
	mov r0,#0x0	; 03804628
	strh r0,[r1,#0x0]	; 0380462A
	bl loc_037FDC9C	; 0380462C
	add r6,r0,#0x0	; 03804630
	ldr r0,[pool_03804738]	; 03804632
	bl loc_037FDA20	; 03804634
	add r7,r0,#0x0	; 03804638
	mov r0,#0x0	; 0380463A
	bl P2_ReadPmicRegister	; 0380463C
	str r0,[sp,#0x0]	; 03804640
	mov r0,#0x2	; 03804642
	bl loc_03804778	; 03804644
	mov r0,#0x2	; 03804648
	bl P2_Entry_0380450C	; 0380464A
	mov r0,#0x2	; 0380464E
	bl P2_Entry_0380450C	; 03804650
	bl P2_Entry_037FF434	; 03804654
	mov r0,#0x1	; 03804658
	bl loc_038043D4	; 0380465A
	ldr r0,[pool_0380473C]	; 0380465E
	ldrh r1,[r0,#0x0]	; 03804660
	mov r0,#0x1	; 03804662
	and r1,r0	; 03804664
	cmp r1,#0x0	; 03804666
	beq P2_Entry_0380467C	; 03804668
	ldr r0,[pool_03804740]	; 0380466A
	ldrh r1,[r0,#0x0]	; 0380466C
	ldr r0,[pool_03804744]	; 0380466E
	orr r1,r0	; 03804670
	ldr r0,[pool_03804748]	; 03804672
	strh r1,[r0,#0x0]	; 03804674
	ldr r0,[pool_0380474C]	; 03804676
	bl loc_037FDA4C	; 03804678
P2_Entry_0380467C:
	ldr r0,[pool_0380473C]	; 0380467C
	ldrh r1,[r0,#0x0]	; 0380467E
	mov r0,#0x4	; 03804680
	and r1,r0	; 03804682
	cmp r1,#0x0	; 03804684
	beq P2_Entry_0380468E	; 03804686
	ldr r0,[pool_03804750]	; 03804688
	bl loc_037FDA4C	; 0380468A
P2_Entry_0380468E:
	ldr r0,[pool_0380473C]	; 0380468E
	ldrh r1,[r0,#0x0]	; 03804690
	mov r0,#0x2	; 03804692
	and r1,r0	; 03804694
	cmp r1,#0x0	; 03804696
	beq P2_Entry_038046BA	; 03804698
	ldr r0,[pool_03804754]	; 0380469A
	ldrh r5,[r0,#0x0]	; 0380469C
	ldr r0,[pool_03804758]	; 0380469E
	bl loc_03802100	; 038046A0
	mov r0,#0x40	; 038046A4
	add r1,r0,#0x0	; 038046A6
	bl loc_03802114	; 038046A8
	ldr r0,[pool_0380475C]	; 038046AC
	add r1,r0,#0x0	; 038046AE
	bl loc_03802114	; 038046B0
	mov r0,#0x80	; 038046B4
	bl loc_037FDA4C	; 038046B6
P2_Entry_038046BA:
	ldr r0,[pool_0380473C]	; 038046BA
	ldrh r1,[r0,#0x0]	; 038046BC
	mov r0,#0x8	; 038046BE
	and r1,r0	; 038046C0
	cmp r1,#0x0	; 038046C2
	beq P2_Entry_038046CC	; 038046C4
	ldr r0,[pool_03804760]	; 038046C6
	bl loc_037FDA4C	; 038046C8
P2_Entry_038046CC:
	ldr r0,[pool_0380473C]	; 038046CC
	ldrh r1,[r0,#0x0]	; 038046CE
	mov r0,#0x10	; 038046D0
	and r1,r0	; 038046D2
	cmp r1,#0x0	; 038046D4
	beq P2_Entry_038046DE	; 038046D6
	ldr r0,[pool_03804764]	; 038046D8
	bl loc_037FDA4C	; 038046DA
P2_Entry_038046DE:
	add r0,r6,#0x0	; 038046DE
	bl loc_037FDCC0	; 038046E0
	ldr r1,[pool_03804734]	; 038046E4
	ldrh r0,[r1,#0x0]	; 038046E6
	mov r0,#0x1	; 038046E8
	strh r0,[r1,#0x0]	; 038046EA
	bl P2_SwiStop	; 038046EC
	mov r0,#0x0	; 038046F0
	ldr r1,[sp,#0x0]	; 038046F2
	bl loc_03804494	; 038046F4
	ldr r0,[pool_03804754]	; 038046F8
	strh r5,[r0,#0x0]	; 038046FA
	mov r0,#0x1	; 038046FC
	bl loc_038043F0	; 038046FE
	bl P2_Entry_037FF400	; 03804702
	mov r1,#0x0	; 03804706
	ldr r0,[pool_03804768]	; 03804708
	str r1,[r0,#0x20]	; 0380470A
	mov r0,#0x62	; 0380470C
	add r2,r1,#0x0	; 0380470E
	bl P2_Entry_0380438C	; 03804710
	bl loc_037FDC9C	; 03804714
	add r0,r7,#0x0	; 03804718
	bl loc_037FDA4C	; 0380471A
	add r0,r6,#0x0	; 0380471E
	bl loc_037FDCC0	; 03804720
	ldr r1,[pool_03804734]	; 03804724
	ldrh r0,[r1,#0x0]	; 03804726
	strh r4,[r1,#0x0]	; 03804728
	add sp,#0x4	; 0380472A
	pop {r4,r5,r6,r7}	; 0380472C
	pop {r3}	; 0380472E
	bx r3	; 03804730
	.byte 0xC0, 0x46	; 03804732
pool_03804734:
	.word REG_IME	; 03804734
pool_03804738:
	.word 0x01FFFFFF	; 03804738
pool_0380473C:
	.word P2_BssStart + 0x2698	; 0380473C
pool_03804740:
	.word P2_BssStart + 0x2694	; 03804740
pool_03804744:
	.word 0x00004000	; 03804744
pool_03804748:
	.word REG_KEYCNT	; 03804748
pool_0380474C:
	.word 0x00001000	; 0380474C
pool_03804750:
	.word 0x00400000	; 03804750
pool_03804754:
	.word REG_RCNT_ARM7	; 03804754
pool_03804758:
	.word 0x00008000	; 03804758
pool_0380475C:
	.word 0x00000100	; 0380475C
pool_03804760:
	.word 0x00100000	; 03804760
pool_03804764:
	.word 0x00002000	; 03804764
pool_03804768:
	.word P2_BssStart + 0x26A0	; 03804768

; ===== function loc_0380476C =====
loc_0380476C:
	ldr r0,[pool_03804774]	; 0380476C
	ldr r0,[r0,#0x0]	; 0380476E
	bx lr	; 03804770
	.byte 0xC0, 0x46	; 03804774
pool_03804774:
loc_03804774:
	.word P2_BssStart + 0x26D0	; 03804774

; ===== function loc_03804778 =====
loc_03804778:
	cmp r0,#0xf	; 03804778
	bgt loc_03804786	; 0380477A
	ldr r1,[pool_03804788]	; 0380477C
	str r0,[r1,#0x0]	; 0380477E
	mov r1,#0x0	; 03804780
	ldr r0,[pool_0380478C]	; 03804782
	str r1,[r0,#0x0]	; 03804784
loc_03804786:
	bx lr	; 03804786
pool_03804788:
loc_03804788:
	.word P2_BssStart + 0x26D0	; 03804788
pool_0380478C:
loc_0380478C:
	.word P2_BssStart + 0x26CC	; 0380478C

; ===== function loc_03804790 =====
loc_03804790:
	push {r4,r5,r6,lr}	; 03804790
	ldr r0,[pool_03804830]	; 03804792
	ldr r3,[r0,#0x0]	; 03804794
	cmp r3,#0x0	; 03804796
	bne loc_038047B2	; 03804798
	mov r0,#0x3	; 0380479A
	mov r1,#0x66	; 0380479C
	mov r2,#0x1	; 0380479E
	add r3,r2,#0x0	; 038047A0
	bl loc_03802D4C	; 038047A2
	cmp r0,#0x0	; 038047A6
	beq loc_03804828	; 038047A8
	mov r0,#0x1	; 038047AA
	bl loc_03804778	; 038047AC
	b loc_03804828	; 038047B0
loc_038047B2:
	cmp r3,#0x4	; 038047B2
	bge loc_038047CA	; 038047B4
	ldr r0,[pool_03804834]	; 038047B6
	ldr r0,[r0,#0x0]	; 038047B8
	cmp r3,r0	; 038047BA
	beq loc_03804828	; 038047BC
	mov r0,#0x3	; 038047BE
	mov r1,#0x66	; 038047C0
	mov r2,#0x1	; 038047C2
	bl loc_03802D4C	; 038047C4
	b loc_03804828	; 038047C8
loc_038047CA:
	ldr r6,[pool_03804838]	; 038047CA
	sub r4,r3,#0x4	; 038047CC
	mov r0,#0xc	; 038047CE
	mul r4,r0	; 038047D0
	add r5,r6,r4	; 038047D2
	ldr r0,[pool_0380483C]	; 038047D4
	ldr r0,[r0,#0x0]	; 038047D6
	ldrh r1,[r5,#0xa]	; 038047D8
	bl loc_038031F8	; 038047DA
	add r2,r0,#0x0	; 038047DE
	mov r0,#0x0	; 038047E0
	ldr r1,[pool_03804840]	; 038047E2
	bl loc_037FF8E4	; 038047E4
	ldr r3,[r6,r4]	; 038047E8
	ldr r2,[r5,#0x4]	; 038047EA
	and r2,r1	; 038047EC
	and r3,r0	; 038047EE
	mov r0,#0x0	; 038047F0
	eor r2,r0	; 038047F2
	eor r3,r0	; 038047F4
	orr r2,r3	; 038047F6
	beq loc_038047FE	; 038047F8
	mov r3,#0x1	; 038047FA
	b loc_03804800	; 038047FC
loc_038047FE:
	mov r3,#0x2	; 038047FE
loc_03804800:
	ldr r0,[pool_0380483C]	; 03804800
	ldr r1,[r0,#0x0]	; 03804802
	add r4,r1,#0x1	; 03804804
	str r4,[r0,#0x0]	; 03804806
	ldrh r2,[r5,#0x8]	; 03804808
	ldrh r1,[r5,#0xa]	; 0380480A
	mul r2,r1	; 0380480C
	cmp r4,r2	; 0380480E
	bcc loc_03804816	; 03804810
	mov r1,#0x0	; 03804812
	str r1,[r0,#0x0]	; 03804814
loc_03804816:
	ldr r0,[pool_03804834]	; 03804816
	ldr r0,[r0,#0x0]	; 03804818
	cmp r3,r0	; 0380481A
	beq loc_03804828	; 0380481C
	mov r0,#0x3	; 0380481E
	mov r1,#0x66	; 03804820
	mov r2,#0x1	; 03804822
	bl loc_03802D4C	; 03804824
loc_03804828:
	pop {r4,r5,r6}	; 03804828
	pop {r3}	; 0380482A
	bx r3	; 0380482C
	.byte 0xC0, 0x46	; 03804830
pool_03804830:
loc_03804830:
	.word P2_BssStart + 0x26D0	; 03804830
pool_03804834:
loc_03804834:
	.word P2_Data_038052C0	; 03804834
pool_03804838:
loc_03804838:
	.word 0x038052C4	; 03804838
pool_0380483C:
loc_0380483C:
	.word P2_BssStart + 0x26CC	; 0380483C
pool_03804840:
loc_03804840:
	.word 0x80000000	; 03804840

; ===== function loc_03804844 =====
loc_03804844:
	push {lr}	; 03804844
	sub sp,#0x4	; 03804846
	mov r0,#0x0	; 03804848
	str r0,[sp,#0x0]	; 0380484A
	add r0,sp,#0x0	; 0380484C
	ldr r1,[pool_03804864]	; 0380484E
	ldr r2,[pool_03804868]	; 03804850
	bl P2_SwiCpuSet	; 03804852
	bl loc_037FAFA8	; 03804856
	ldr r1,[pool_03804864]	; 0380485A
	strh r0,[r1,#0x2]	; 0380485C
	add sp,#0x4	; 0380485E
	pop {r3}	; 03804860
	bx r3	; 03804862
pool_03804864:
loc_03804864:
	.word P2_BssStart + 0x26D4	; 03804864
pool_03804868:
loc_03804868:
	.word 0x05000001	; 03804868

; ===== function loc_0380486C =====
loc_0380486C:
	push {lr}	; 0380486C
	sub sp,#0x4	; 0380486E
	ldr r0,[pool_03804888]	; 03804870
	ldr r1,[r0,#0x0]	; 03804872
	cmp r1,#0x0	; 03804874
	bne loc_03804880	; 03804876
	mov r1,#0x1	; 03804878
	str r1,[r0,#0x0]	; 0380487A
	bl loc_03804844	; 0380487C
loc_03804880:
	add sp,#0x4	; 03804880
	pop {r3}	; 03804882
	bx r3	; 03804884
	.byte 0xC0, 0x46	; 03804888
pool_03804888:
loc_03804888:
	.word P2_BssStart + 0x26D8	; 03804888
	.byte 0x00, 0xDF, 0x70, 0x47	; 03804890

.func P2_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_03804890:
	swi 0x3	; 03804890
	bx lr	; 03804892
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
	.word 0x04000000	; ARM7 I/O register base / ARM7 I/O 寄存器基址。
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
P2_SwiVBlankIntrWait:
	mov r2,#0x0
	swi 0x5
	bx lr

.func P2_SwiHalt
; BIOS SWI #06: halt ARM7 until an interrupt. / BIOS SWI #06：使 ARM7 停止至中断发生。
; ===== function loc_038048AA =====
loc_038048AA:
	swi 0x6	; 038048AA
	bx lr	; 038048AC

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

.func P2_SwiSoundBiasIncrease
; BIOS SWI #08 wrapper: request sound-bias increase. / BIOS SWI #08 封装：请求提高声音偏置。
; ===== function loc_038048B6 =====
loc_038048B6:
	add r1,r0,#0x0	; 038048B6
	mov r0,#0x1	; 038048B8
	swi 0x8	; 038048BA
	bx lr	; 038048BC

.endfunc

.func P2_SwiSoundBiasDecrease
; BIOS SWI #08 wrapper: request sound-bias decrease. / BIOS SWI #08 封装：请求降低声音偏置。
; ===== function loc_038048BE =====
loc_038048BE:
	add r1,r0,#0x0	; 038048BE
	mov r0,#0x0	; 038048C0
	swi 0x8	; 038048C2
	bx lr	; 038048C4

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
	bx lr	; 038048D0
.endfunc

.func P2_SwiCpuSet
; BIOS SWI #0B: configurable memory copy/fill. / BIOS SWI #0B：可配置的内存复制/填充。
; ===== function loc_038048D0 =====
loc_038048D0:
	swi 0xb	; 038048D0
	bx lr	; 038048D2

.endfunc

.func P2_SwiCpuFastSet
; BIOS SWI #0C: fast 32-byte memory copy/fill. / BIOS SWI #0C：快速 32 字节内存复制/填充。
; ===== function loc_038048D4 =====
loc_038048D4:
	swi 0xc	; 038048D4
	bx lr	; 038048D6

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

; ===== function loc_03804900 =====
.func P2_SwiGetPitchTable
; BIOS SWI #1B: obtain pitch-table entry. / BIOS SWI #1B：取得音高表项。
loc_03804900:
	swi 0x1b	; 03804900
	bx lr	; 03804902
.endfunc

; ===== function loc_03804904 =====
.func P2_SwiGetVolumeTable
; BIOS SWI #1C: obtain volume-table entry. / BIOS SWI #1C：取得音量表项。
loc_03804904:
	swi 0x1c	; 03804904
	bx lr	; 03804906
.endfunc
.arm

; ===== function loc_03804908 =====
loc_03804908:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804908
	mov r4,#0x0	; 0380490C
	b loc_0380491C	; 03804910
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0380491C
loc_0380491C:
	orrs r5,r3,r2	; 0380491C
	bne loc_0380492C	; 03804920
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804924
	bx lr	; 03804928
loc_0380492C:
	orrs r5,r1,r3	; 0380492C
	bne loc_038049D4	; 03804930
	mov r1,r2	; 03804934
	bl loc_03804D74	; 03804938
	cmp r4,#0x0	; 0380493C
	movne r0,r1	; 03804940
	mov r1,#0x0	; 03804944
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804948
	bx lr	; 0380494C
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 03804960

; ===== function loc_03804960 =====
loc_03804960:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804960
	eor r4,r1,r3	; 03804964
	mov r4,r4, asr #0x1	; 03804968
	mov r4,r4, lsl #0x1	; 0380496C
	orrs r5,r3,r2	; 03804970
	bne loc_03804980	; 03804974
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804978
	bx lr	; 0380497C
loc_03804980:
	mov r5,r0, lsr #0x1f	; 03804980
	add r5,r5,r1	; 03804984
	mov r6,r2, lsr #0x1f	; 03804988
	add r6,r6,r3	; 0380498C
	orrs r6,r5,r6	; 03804990
	bne loc_038049B4	; 03804994
	mov r1,r2	; 03804998
	bl loc_03804B60	; 0380499C
	ands r4,r4,#0x1	; 038049A0
	movne r0,r1	; 038049A4
	mov r1,r0, asr #0x1f	; 038049A8
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049AC
	bx lr	; 038049B0
loc_038049B4:
	cmp r1,#0x0	; 038049B4
	bge loc_038049C4	; 038049B8
	rsbs r0,r0,#0x0	; 038049BC
	rsc r1,r1,#0x0	; 038049C0
loc_038049C4:
	cmp r3,#0x0	; 038049C4
	bge loc_038049D4	; 038049C8
	rsbs r2,r2,#0x0	; 038049CC
	rsc r3,r3,#0x0	; 038049D0
loc_038049D4:
	orrs r5,r1,r0	; 038049D4
	beq loc_03804AF8	; 038049D8
	mov r5,#0x0	; 038049DC
	mov r6,#0x1	; 038049E0
	cmp r3,#0x0	; 038049E4
	bmi loc_03804A00	; 038049E8
loc_038049EC:
	add r5,r5,#0x1	; 038049EC
	adds r2,r2,r2	; 038049F0
	adcs r3,r3,r3	; 038049F4
	bpl loc_038049EC	; 038049F8
	add r6,r6,r5	; 038049FC
loc_03804A00:
	cmp r1,#0x0	; 03804A00
	blt loc_03804A20	; 03804A04
loc_03804A08:
	cmp r6,#0x1	; 03804A08
	beq loc_03804A20	; 03804A0C
	sub r6,r6,#0x1	; 03804A10
	adds r0,r0,r0	; 03804A14
	adcs r1,r1,r1	; 03804A18
	bpl loc_03804A08	; 03804A1C
loc_03804A20:
	mov r7,#0x0	; 03804A20
	mov r12,#0x0	; 03804A24
	mov r11,#0x0	; 03804A28
	b loc_03804A48	; 03804A2C
loc_03804A30:
	orr r12,r12,#0x1	; 03804A30
	subs r6,r6,#0x1	; 03804A34
	beq loc_03804AA0	; 03804A38
	adds r0,r0,r0	; 03804A3C
	adcs r1,r1,r1	; 03804A40
	adcs r7,r7,r7	; 03804A44
loc_03804A48:
	subs r0,r0,r2	; 03804A48
	sbcs r1,r1,r3	; 03804A4C
	sbcs r7,r7,#0x0	; 03804A50
	adds r12,r12,r12	; 03804A54
	adc r11,r11,r11	; 03804A58
	cmp r7,#0x0	; 03804A5C
	bge loc_03804A30	; 03804A60
loc_03804A64:
	subs r6,r6,#0x1	; 03804A64
	beq loc_03804A98	; 03804A68
	adds r0,r0,r0	; 03804A6C
	adcs r1,r1,r1	; 03804A70
	adc r7,r7,r7	; 03804A74
	adds r0,r0,r2	; 03804A78
	adcs r1,r1,r3	; 03804A7C
	adc r7,r7,#0x0	; 03804A80
	adds r12,r12,r12	; 03804A84
	adc r11,r11,r11	; 03804A88
	cmp r7,#0x0	; 03804A8C
	bge loc_03804A30	; 03804A90
	b loc_03804A64	; 03804A94
loc_03804A98:
	adds r0,r0,r2	; 03804A98
	adc r1,r1,r3	; 03804A9C
loc_03804AA0:
	ands r7,r4,#0x1	; 03804AA0
	moveq r0,r12	; 03804AA4
	moveq r1,r11	; 03804AA8
	beq loc_03804AD8	; 03804AAC
	subs r7,r5,#0x20	; 03804AB0
	movge r0,r1, lsr r7	; 03804AB4
	bge loc_03804AFC	; 03804AB8
	rsb r7,r5,#0x20	; 03804ABC
	mov r0,r0, lsr r5	; 03804AC0
	orr r0,r0,r1, lsl r7	; 03804AC4
	mov r1,r1, lsr r5	; 03804AC8
	b loc_03804AD8	; 03804ACC
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 03804AD8
loc_03804AD8:
	cmp r4,#0x0	; 03804AD8
	blt loc_03804AE8	; 03804ADC
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804AE0
	bx lr	; 03804AE4
loc_03804AE8:
	rsbs r0,r0,#0x0	; 03804AE8
	rsc r1,r1,#0x0	; 03804AEC
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804AF0
	bx lr	; 03804AF4
loc_03804AF8:
	mov r0,#0x0	; 03804AF8
loc_03804AFC:
	mov r1,#0x0	; 03804AFC
	cmp r4,#0x0	; 03804B00
	blt loc_03804AE8	; 03804B04
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B08
	bx lr	; 03804B0C

; ===== function loc_03804B10 =====
loc_03804B10:
	stmdb sp!,{r4,r5,lr}	; 03804B10
	umull r5,r4,r0,r2	; 03804B14
	mla r4,r0,r3,r4	; 03804B18
	mla r4,r2,r1,r4	; 03804B1C
	mov r1,r4	; 03804B20
	mov r0,r5	; 03804B24
	ldmia sp!,{r4,r5,lr}	; 03804B28
	bx lr	; 03804B2C

; ===== function loc_03804B30 =====
loc_03804B30:
	ands r2,r2,#0x3f	; 03804B30
	bxeq lr	; 03804B34
	subs r3,r2,#0x20	; 03804B38
	bge loc_03804B54	; 03804B3C
	rsb r3,r2,#0x20	; 03804B40
	mov r1,r1, lsl r2	; 03804B44
	orr r1,r1,r0, lsr r3	; 03804B48
	mov r0,r0, lsl r2	; 03804B4C
	bx lr	; 03804B50
loc_03804B54:
	mov r1,r0, lsl r3	; 03804B54
	mov r0,#0x0	; 03804B58
	bx lr	; 03804B5C

; Signed integer division: quotient in r0, remainder in r1.
; 有符号整数除法：商返回于 r0，余数返回于 r1。
P2_SignedDivMod:
loc_03804B60:
	eor r12,r0,r1	; 03804B60
	and r12,r12,#0x80000000	; 03804B64
	cmp r0,#0x0	; 03804B68
	rsblt r0,r0,#0x0	; 03804B6C
	addlt r12,r12,#0x1	; 03804B70
	cmp r1,#0x0	; 03804B74
	rsblt r1,r1,#0x0	; 03804B78
	beq loc_03804D58	; 03804B7C
	cmp r0,r1	; 03804B80
	movcc r1,r0	; 03804B84
	movcc r0,#0x0	; 03804B88
	bcc loc_03804D58	; 03804B8C
	mov r2,#0x1c	; 03804B90
	mov r3,r0, lsr #0x4	; 03804B94
	cmp r1,r3, lsr #0xc	; 03804B98
	suble r2,r2,#0x10	; 03804B9C
	movle r3,r3, lsr #0x10	; 03804BA0
	cmp r1,r3, lsr #0x4	; 03804BA4
	suble r2,r2,#0x8	; 03804BA8
	movle r3,r3, lsr #0x8	; 03804BAC
	cmp r1,r3	; 03804BB0
	suble r2,r2,#0x4	; 03804BB4
	movle r3,r3, lsr #0x4	; 03804BB8
	mov r0,r0, lsl r2	; 03804BBC
	rsb r1,r1,#0x0	; 03804BC0
	adds r0,r0,r0	; 03804BC4
	add r2,r2,r2, lsl #0x1	; 03804BC8
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804BCCPC:
	add pc,pc,r2, lsl #0x2	; 03804BCC
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804BD4
loc_03804BD4:
P2_DivisionDispatch_03804BCCSteps:
	adcs r3,r1,r3, lsl #0x1	; 03804BD4
	subcc r3,r3,r1	; 03804BD8
	adcs r0,r0,r0	; 03804BDC
	adcs r3,r1,r3, lsl #0x1	; 03804BE0
	subcc r3,r3,r1	; 03804BE4
	adcs r0,r0,r0	; 03804BE8
	adcs r3,r1,r3, lsl #0x1	; 03804BEC
	subcc r3,r3,r1	; 03804BF0
	adcs r0,r0,r0	; 03804BF4
	adcs r3,r1,r3, lsl #0x1	; 03804BF8
	subcc r3,r3,r1	; 03804BFC
	adcs r0,r0,r0	; 03804C00
loc_03804C04:
	adcs r3,r1,r3, lsl #0x1	; 03804C04
	subcc r3,r3,r1	; 03804C08
	adcs r0,r0,r0	; 03804C0C
	adcs r3,r1,r3, lsl #0x1	; 03804C10
	subcc r3,r3,r1	; 03804C14
	adcs r0,r0,r0	; 03804C18
	adcs r3,r1,r3, lsl #0x1	; 03804C1C
	subcc r3,r3,r1	; 03804C20
	adcs r0,r0,r0	; 03804C24
	adcs r3,r1,r3, lsl #0x1	; 03804C28
	subcc r3,r3,r1	; 03804C2C
	adcs r0,r0,r0	; 03804C30
loc_03804C34:
	adcs r3,r1,r3, lsl #0x1	; 03804C34
	subcc r3,r3,r1	; 03804C38
	adcs r0,r0,r0	; 03804C3C
	adcs r3,r1,r3, lsl #0x1	; 03804C40
	subcc r3,r3,r1	; 03804C44
	adcs r0,r0,r0	; 03804C48
	adcs r3,r1,r3, lsl #0x1	; 03804C4C
	subcc r3,r3,r1	; 03804C50
	adcs r0,r0,r0	; 03804C54
	adcs r3,r1,r3, lsl #0x1	; 03804C58
	subcc r3,r3,r1	; 03804C5C
	adcs r0,r0,r0	; 03804C60
	adcs r3,r1,r3, lsl #0x1	; 03804C64
	subcc r3,r3,r1	; 03804C68
	adcs r0,r0,r0	; 03804C6C
	adcs r3,r1,r3, lsl #0x1	; 03804C70
	subcc r3,r3,r1	; 03804C74
	adcs r0,r0,r0	; 03804C78
	adcs r3,r1,r3, lsl #0x1	; 03804C7C
	subcc r3,r3,r1	; 03804C80
	adcs r0,r0,r0	; 03804C84
	adcs r3,r1,r3, lsl #0x1	; 03804C88
	subcc r3,r3,r1	; 03804C8C
	adcs r0,r0,r0	; 03804C90
loc_03804C94:
	adcs r3,r1,r3, lsl #0x1	; 03804C94
	subcc r3,r3,r1	; 03804C98
	adcs r0,r0,r0	; 03804C9C
	adcs r3,r1,r3, lsl #0x1	; 03804CA0
	subcc r3,r3,r1	; 03804CA4
	adcs r0,r0,r0	; 03804CA8
	adcs r3,r1,r3, lsl #0x1	; 03804CAC
	subcc r3,r3,r1	; 03804CB0
	adcs r0,r0,r0	; 03804CB4
	adcs r3,r1,r3, lsl #0x1	; 03804CB8
	subcc r3,r3,r1	; 03804CBC
	adcs r0,r0,r0	; 03804CC0
	adcs r3,r1,r3, lsl #0x1	; 03804CC4
	subcc r3,r3,r1	; 03804CC8
	adcs r0,r0,r0	; 03804CCC
	adcs r3,r1,r3, lsl #0x1	; 03804CD0
	subcc r3,r3,r1	; 03804CD4
	adcs r0,r0,r0	; 03804CD8
	adcs r3,r1,r3, lsl #0x1	; 03804CDC
	subcc r3,r3,r1	; 03804CE0
	adcs r0,r0,r0	; 03804CE4
	adcs r3,r1,r3, lsl #0x1	; 03804CE8
	subcc r3,r3,r1	; 03804CEC
	adcs r0,r0,r0	; 03804CF0
	adcs r3,r1,r3, lsl #0x1	; 03804CF4
	subcc r3,r3,r1	; 03804CF8
	adcs r0,r0,r0	; 03804CFC
	adcs r3,r1,r3, lsl #0x1	; 03804D00
	subcc r3,r3,r1	; 03804D04
	adcs r0,r0,r0	; 03804D08
	adcs r3,r1,r3, lsl #0x1	; 03804D0C
	subcc r3,r3,r1	; 03804D10
	adcs r0,r0,r0	; 03804D14
	adcs r3,r1,r3, lsl #0x1	; 03804D18
	subcc r3,r3,r1	; 03804D1C
	adcs r0,r0,r0	; 03804D20
	adcs r3,r1,r3, lsl #0x1	; 03804D24
	subcc r3,r3,r1	; 03804D28
	adcs r0,r0,r0	; 03804D2C
	adcs r3,r1,r3, lsl #0x1	; 03804D30
	subcc r3,r3,r1	; 03804D34
	adcs r0,r0,r0	; 03804D38
	adcs r3,r1,r3, lsl #0x1	; 03804D3C
	subcc r3,r3,r1	; 03804D40
	adcs r0,r0,r0	; 03804D44
	adcs r3,r1,r3, lsl #0x1	; 03804D48
	subcc r3,r3,r1	; 03804D4C
	adcs r0,r0,r0	; 03804D50
P2_DivisionDispatch_03804BCCEnd:
.if (P2_DivisionDispatch_03804BCCSteps != P2_DivisionDispatch_03804BCCPC + 8) || (P2_DivisionDispatch_03804BCCEnd - P2_DivisionDispatch_03804BCCSteps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03804D54
loc_03804D58:
	ands r3,r12,#0x80000000	; 03804D58
	rsbne r0,r0,#0x0	; 03804D5C
	ands r3,r12,#0x1	; 03804D60
	rsbne r1,r1,#0x0	; 03804D64
	bx lr	; 03804D68

; ===== function loc_03804D6C =====
loc_03804D6C:
	cmp r1,#0x0	; 03804D6C
	bxeq lr	; 03804D70

; ===== function loc_03804D74 =====
loc_03804D74:
	cmp r0,r1	; 03804D74
	movcc r1,r0	; 03804D78
	movcc r0,#0x0	; 03804D7C
	bxcc lr	; 03804D80
	mov r2,#0x1c	; 03804D84
	mov r3,r0, lsr #0x4	; 03804D88
	cmp r1,r3, lsr #0xc	; 03804D8C
	suble r2,r2,#0x10	; 03804D90
	movle r3,r3, lsr #0x10	; 03804D94
	cmp r1,r3, lsr #0x4	; 03804D98
	suble r2,r2,#0x8	; 03804D9C
	movle r3,r3, lsr #0x8	; 03804DA0
	cmp r1,r3	; 03804DA4
	suble r2,r2,#0x4	; 03804DA8
	movle r3,r3, lsr #0x4	; 03804DAC
	mov r0,r0, lsl r2	; 03804DB0
	rsb r1,r1,#0x0	; 03804DB4
	adds r0,r0,r0	; 03804DB8
	add r2,r2,r2, lsl #0x1	; 03804DBC
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804DC0PC:
	add pc,pc,r2, lsl #0x2	; 03804DC0
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804DC8
loc_03804DC8:
P2_DivisionDispatch_03804DC0Steps:
	adcs r3,r1,r3, lsl #0x1	; 03804DC8
	subcc r3,r3,r1	; 03804DCC
	adcs r0,r0,r0	; 03804DD0
	adcs r3,r1,r3, lsl #0x1	; 03804DD4
	subcc r3,r3,r1	; 03804DD8
	adcs r0,r0,r0	; 03804DDC
	adcs r3,r1,r3, lsl #0x1	; 03804DE0
	subcc r3,r3,r1	; 03804DE4
	adcs r0,r0,r0	; 03804DE8
	adcs r3,r1,r3, lsl #0x1	; 03804DEC
	subcc r3,r3,r1	; 03804DF0
	adcs r0,r0,r0	; 03804DF4
loc_03804DF8:
	adcs r3,r1,r3, lsl #0x1	; 03804DF8
	subcc r3,r3,r1	; 03804DFC
	adcs r0,r0,r0	; 03804E00
	adcs r3,r1,r3, lsl #0x1	; 03804E04
	subcc r3,r3,r1	; 03804E08
	adcs r0,r0,r0	; 03804E0C
	adcs r3,r1,r3, lsl #0x1	; 03804E10
	subcc r3,r3,r1	; 03804E14
	adcs r0,r0,r0	; 03804E18
	adcs r3,r1,r3, lsl #0x1	; 03804E1C
	subcc r3,r3,r1	; 03804E20
	adcs r0,r0,r0	; 03804E24
loc_03804E28:
	adcs r3,r1,r3, lsl #0x1	; 03804E28
	subcc r3,r3,r1	; 03804E2C
	adcs r0,r0,r0	; 03804E30
	adcs r3,r1,r3, lsl #0x1	; 03804E34
	subcc r3,r3,r1	; 03804E38
	adcs r0,r0,r0	; 03804E3C
	adcs r3,r1,r3, lsl #0x1	; 03804E40
	subcc r3,r3,r1	; 03804E44
	adcs r0,r0,r0	; 03804E48
	adcs r3,r1,r3, lsl #0x1	; 03804E4C
	subcc r3,r3,r1	; 03804E50
	adcs r0,r0,r0	; 03804E54
	adcs r3,r1,r3, lsl #0x1	; 03804E58
	subcc r3,r3,r1	; 03804E5C
	adcs r0,r0,r0	; 03804E60
	adcs r3,r1,r3, lsl #0x1	; 03804E64
	subcc r3,r3,r1	; 03804E68
	adcs r0,r0,r0	; 03804E6C
	adcs r3,r1,r3, lsl #0x1	; 03804E70
	subcc r3,r3,r1	; 03804E74
	adcs r0,r0,r0	; 03804E78
	adcs r3,r1,r3, lsl #0x1	; 03804E7C
	subcc r3,r3,r1	; 03804E80
	adcs r0,r0,r0	; 03804E84
loc_03804E88:
	adcs r3,r1,r3, lsl #0x1	; 03804E88
	subcc r3,r3,r1	; 03804E8C
	adcs r0,r0,r0	; 03804E90
	adcs r3,r1,r3, lsl #0x1	; 03804E94
	subcc r3,r3,r1	; 03804E98
	adcs r0,r0,r0	; 03804E9C
	adcs r3,r1,r3, lsl #0x1	; 03804EA0
	subcc r3,r3,r1	; 03804EA4
	adcs r0,r0,r0	; 03804EA8
	adcs r3,r1,r3, lsl #0x1	; 03804EAC
	subcc r3,r3,r1	; 03804EB0
	adcs r0,r0,r0	; 03804EB4
	adcs r3,r1,r3, lsl #0x1	; 03804EB8
	subcc r3,r3,r1	; 03804EBC
	adcs r0,r0,r0	; 03804EC0
	adcs r3,r1,r3, lsl #0x1	; 03804EC4
	subcc r3,r3,r1	; 03804EC8
	adcs r0,r0,r0	; 03804ECC
	adcs r3,r1,r3, lsl #0x1	; 03804ED0
	subcc r3,r3,r1	; 03804ED4
	adcs r0,r0,r0	; 03804ED8
	adcs r3,r1,r3, lsl #0x1	; 03804EDC
	subcc r3,r3,r1	; 03804EE0
	adcs r0,r0,r0	; 03804EE4
	adcs r3,r1,r3, lsl #0x1	; 03804EE8
	subcc r3,r3,r1	; 03804EEC
	adcs r0,r0,r0	; 03804EF0
	adcs r3,r1,r3, lsl #0x1	; 03804EF4
	subcc r3,r3,r1	; 03804EF8
	adcs r0,r0,r0	; 03804EFC
	adcs r3,r1,r3, lsl #0x1	; 03804F00
	subcc r3,r3,r1	; 03804F04
	adcs r0,r0,r0	; 03804F08
	adcs r3,r1,r3, lsl #0x1	; 03804F0C
	subcc r3,r3,r1	; 03804F10
	adcs r0,r0,r0	; 03804F14
	adcs r3,r1,r3, lsl #0x1	; 03804F18
	subcc r3,r3,r1	; 03804F1C
	adcs r0,r0,r0	; 03804F20
	adcs r3,r1,r3, lsl #0x1	; 03804F24
	subcc r3,r3,r1	; 03804F28
	adcs r0,r0,r0	; 03804F2C
	adcs r3,r1,r3, lsl #0x1	; 03804F30
	subcc r3,r3,r1	; 03804F34
	adcs r0,r0,r0	; 03804F38
	adcs r3,r1,r3, lsl #0x1	; 03804F3C
	subcc r3,r3,r1	; 03804F40
	adcs r0,r0,r0	; 03804F44
P2_DivisionDispatch_03804DC0End:
.if (P2_DivisionDispatch_03804DC0Steps != P2_DivisionDispatch_03804DC0PC + 8) || (P2_DivisionDispatch_03804DC0End - P2_DivisionDispatch_03804DC0Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03804F48
	bx lr	; 03804F4C

; ===== function loc_03804F50 =====
loc_03804F50:
	ands r2,r2,#0x3f	; 03804F50
	bxeq lr	; 03804F54
	subs r3,r2,#0x20	; 03804F58
	bge loc_03804F74	; 03804F5C
	rsb r3,r2,#0x20	; 03804F60
	mov r0,r0, lsr r2	; 03804F64
	orr r0,r0,r1, lsl r3	; 03804F68
	mov r1,r1, lsr r2	; 03804F6C
	bx lr	; 03804F70
loc_03804F74:
	mov r0,r1, lsr r3	; 03804F74
	mov r1,#0x0	; 03804F78
	bx lr	; 03804F7C

; ===== function loc_03804F80 =====
loc_03804F80:
	stmdb sp!,{lr}	; 03804F80
	bl loc_03805028	; 03804F84
	mov r1,#0x0	; 03804F88
	str r1,[r0,#0x0]	; 03804F8C
	bl loc_03805034	; 03804F90
	mov r1,#0x0	; 03804F94
	str r1,[r0,#0x4]	; 03804F98
	str r1,[r0,#0x8]	; 03804F9C
	str r1,[r0,#0xc]	; 03804FA0
	str r1,[r0,#0x10]	; 03804FA4
	str r1,[r0,#0x14]	; 03804FA8
	ldmia sp!,{lr}	; 03804FAC
	bx lr	; 03804FB0
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x1A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03804FC4
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03804FD4
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 03804FE4
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 03804FF4
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x0A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805004
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03805014
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 03805024
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 03805028

; ===== function loc_03805028 =====
loc_03805028:
	ldr r12,[pool_03805030]	; 03805028
	bx r12	; 0380502C
pool_03805030:
loc_03805030:
	.word loc_03805078 + 1	; 03805030

; ===== function loc_03805034 =====
loc_03805034:
	ldr r12,[pool_0380503C]	; 03805034
	bx r12	; 03805038
pool_0380503C:
loc_0380503C:
	.word loc_03805080 + 1	; 0380503C
.thumb

; ===== function loc_03805040 =====
loc_03805040:
	bx r0	; 03805040
	.byte 0x00, 0x00	; 03805044

; ===== function loc_03805044 =====
loc_03805044:
	bx r1	; 03805044
	.byte 0x00, 0x00	; 03805048

; ===== function loc_03805048 =====
loc_03805048:
	bx r2	; 03805048
	.byte 0x00, 0x00	; 0380504C

; ===== function loc_0380504C =====
loc_0380504C:
	bx r3	; 0380504C
	.byte 0x00, 0x00	; 03805050

; ===== function loc_03805050 =====
loc_03805050:
	bx r4	; 03805050
	.byte 0x00, 0x00	; 03805054

; ===== function loc_03805054 =====
loc_03805054:
	bx r5	; 03805054
	.byte 0x00, 0x00	; 03805058

; ===== function loc_03805058 =====
loc_03805058:
	push {r4,lr}	; 03805058
	ldr r4,[pool_03805074]	; 0380505A
	b loc_03805062	; 0380505C
loc_0380505E:
	.byte 0x80, 0x47, 0x24, 0x1D	; 03805062
loc_03805062:
	cmp r4,#0x0	; 03805062
	beq loc_0380506C	; 03805064
	ldr r0,[r4,#0x0]	; 03805066
	cmp r0,#0x0	; 03805068
	bne loc_0380505E	; 0380506A
loc_0380506C:
	pop {r4}	; 0380506C
	pop {r3}	; 0380506E
	bx r3	; 03805070
	.byte 0xC0, 0x46	; 03805074
pool_03805074:
loc_03805074:
	.word 0x03805204	; 03805074

; ===== function loc_03805078 =====
loc_03805078:
	ldr r0,[pool_0380507C]	; 03805078
	bx lr	; 0380507A
pool_0380507C:
loc_0380507C:
	.word 0x03807A30	; 0380507C

; ===== function loc_03805080 =====
loc_03805080:
	ldr r0,[pool_03805084]	; 03805080
	bx lr	; 03805082
pool_03805084:
loc_03805084:
	.word 0x03807A34	; 03805084
	.byte 0x59, 0x50, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00	; 03805088
P2_Data_03805094:
	.byte 0x49, 0x32, 0x00, 0x00	; 03805094
P2_Data_03805098:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 03805098
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 038050A8
P2_Data_038050B8:
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 038050B8
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 038050C8
	.byte 0x7F, 0x00, 0x00, 0x00	; 038050D8
P2_Data_038050DC:
	.byte 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 038050DC
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 038050E8
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 038050F8
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 03805108
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 03805118
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 03805128
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 03805138
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 03805148
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 03805158
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 03805168
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 03805178
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 03805188
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 03805198
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 038051A8
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 038051B8
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 038051C8
	.byte 0xFF, 0xFF, 0x00, 0x00	; 038051D8
P2_Data_038051DC:
	.byte 0x00, 0x01, 0x02, 0x04	; 038051DC
P2_Data_038051E0:
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 038051E0
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D	; 038051E8
P2_Data_038051F0:
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 038051F0
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 038051F8
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P2_CrtDataInitTable:
	.word P2_CopyDescriptors, P2_CopyDescriptorsEnd
	.word P2_WramCopy0LoadStart
	.word P2_BssStart, P2_BssEnd
P2_Data_0380521C:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 0380521C
	.byte 0x00, 0x00, 0x00, 0x00	; 0380522C
P2_Data_03805230:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P2_IrqHandlers:
	.word P2_IrqHandler_037FD908 + 1	; IRQ 0
	.word loc_037FD9F8 + 1	; IRQ 1
	.word loc_037FD9F8 + 1	; IRQ 2
	.word P2_IrqHandler_037FD960 + 1	; IRQ 3
	.word P2_IrqHandler_037FD954 + 1	; IRQ 4
	.word P2_IrqHandler_037FD948 + 1	; IRQ 5
	.word P2_IrqHandler_037FD93C + 1	; IRQ 6
	.word loc_037FD9F8 + 1	; IRQ 7
	.word P2_IrqHandler_037FD990 + 1	; IRQ 8
	.word P2_IrqHandler_037FD984 + 1	; IRQ 9
	.word P2_IrqHandler_037FD978 + 1	; IRQ 10
	.word P2_IrqHandler_037FD96C + 1	; IRQ 11
	.word loc_037FD9F8 + 1	; IRQ 12
	.word loc_037FD9F8 + 1	; IRQ 13
	.word loc_037FD9F8 + 1	; IRQ 14
	.word loc_037FD9F8 + 1	; IRQ 15
	.word loc_037FD9F8 + 1	; IRQ 16
	.word loc_037FD9F8 + 1	; IRQ 17
	.word loc_037FD9F8 + 1	; IRQ 18
	.word loc_037FD9F8 + 1	; IRQ 19
	.word loc_037FD9F8 + 1	; IRQ 20
	.word loc_037FD9F8 + 1	; IRQ 21
	.word loc_037FD9F8 + 1	; IRQ 22
	.word loc_037FD9F8 + 1	; IRQ 23
	.word loc_037FD9F8 + 1	; IRQ 24
P2_IrqHandlersEnd:
	.byte 0xC9, 0xDD, 0x7F, 0x03	; 03805294
.thumb
P2_Data_03805298:
	.word 0x12345678	; 038052A8
; ARM7 sound-alarm diagnostic string. / ARM7 声音告警诊断字符串。
P2_SoundAlarmDiagnosticText:
	.ascii "Failed sound alarm OS_SendMessage"
	.byte 0x0A, 0x00, 0x00	; 038052BD
P2_Data_038052C0:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x08	; 038052C0
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC, 0x08, 0x00, 0x01, 0x00, 0x00	; 038052CD
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038052DD
	.byte 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0xF8, 0x14	; 038052ED
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x0C, 0x00, 0x01, 0x00, 0x00	; 038052FD
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380530D
	.byte 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x20	; 0380531D
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00	; 0380532D
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380533D
	.byte 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00	; 0380534D
; CRT 复制后，此保存区复用为主 BSS；下游偏移仍保留原内存布局。
; After CRT copying, reuse this load area as BSS; keep the original field offsets.
P2_BssStart:
; 本 CPU 的 32 项 FIFO 回调表，按通道索引；位于 CRT 清零的 BSS。
; This CPU's 32 FIFO callback slots, indexed by channel, live in CRT-cleared BSS.
.definelabel P2_PxiReceiveCallbacks, P2_BssStart + 0x1D38
.definelabel P2_PxiReceiveCallbacksEnd, P2_PxiReceiveCallbacks + PxiFifoChannelCount * 4
.definelabel P2_CachedFirmwareHeader, P2_BssStart + 0x28
.definelabel P2_BssEnd, P2_BssStart + 0x26F8

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
	bl P2_Entry_037FE3E0	; 037F80F4
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
	.word 0x0230FEF8	; 037F8124
pool_037F8128:
	.word 0x00000100	; 037F8128
pool_037F812C:
	.word 0x027FFF96	; 037F812C
pool_037F8130:
	.word P4_BssStart + 0x23C0	; 037F8130
P2_Runtime_037F8134:
	push {r4,r5,r6,lr}	; 037F8134
	ldr r0,[pool_037F8160]	; 037F8136
	bl P2_Entry_037FE3E0	; 037F8138
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
	bl P2_Entry_037FE39C	; 037F8154
	pop {r4,r5,r6}	; 037F8158
	pop {r3}	; 037F815A
	bx r3	; 037F815C
	.byte 0xC0, 0x46	; 037F815E
pool_037F8160:
	.word 0x0230FEF8	; 037F8160
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
	bl loc_03801EEC	; 037F8186
	cmp r0,#0x0	; 037F818A
	blt P2_Runtime_037F817A	; 037F818C
	ldr r0,[pool_037F81A0]	; 037F818E
	bl P2_Entry_037FE39C	; 037F8190
	add sp,#0x4	; 037F8194
	pop {r4,r5,r6,r7}	; 037F8196
	pop {r3}	; 037F8198
	bx r3	; 037F819A
pool_037F819C:
	.word 0x00000100	; 037F819C
pool_037F81A0:
	.word 0x0230FEF8	; 037F81A0
P2_WramCopy0RuntimeEnd:
.definelabel P2_WramCopy0ZeroBytes, 0x0
.definelabel P2_WramCopy0BssStart, P2_WramCopy0RuntimeEnd
.definelabel P2_WramCopy0BssEnd, P2_WramCopy0BssStart + P2_WramCopy0ZeroBytes
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
	bl loc_03801E0C	; 0380F61C
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
	.byte 0x00, 0x4B, 0x18, 0x47, 0x79, 0xF6, 0x80, 0x03	; 0380F64C
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
	bl loc_03805040	; 0380F668
P2_Entry_0380F66C:
	add sp,#0x4	; 0380F66C
	pop {r3}	; 0380F66E
	bx r3	; 0380F670
.endfunc
	.byte 0xC0, 0x46	; 0380F672
pool_0380F674:
	.word P2_PxiChannel1UserCallbackSlot	; 0380F674
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
	.word 0x037F8000	; 0380F760
pool_0380F764:
	.word 0x0380F600	; 0380F764
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
	.word 0x0380F6F8	; 0380F810
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
	.word 0x0380F64D	; 0380F898
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
