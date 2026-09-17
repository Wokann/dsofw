; official_v6_p2
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
	bl loc_03804FCC	; 037FA870
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
	.word loc_038050A4 + 1	; 037FA8B4

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
	.word P2_Data_038050E0	; 037FA988
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
	bl loc_037FDAC4	; 037FA9F0
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
	bl loc_037FF1EC	; 037FAA12
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
	bl loc_037FDA48	; 037FAA58
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
	.word 0x03807A9C	; 037FAA68
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
	sub sp,#0x8	; 037FAAA2
	ldr r1,[pool_037FAB04]	; 037FAAA4
	ldrh r0,[r1,#0x0]	; 037FAAA6
	lsl r0,r0,#0x3	; 037FAAA8
	ldrh r2,[r1,#0x2]	; 037FAAAA
	lsl r4,r2,#0x3	; 037FAAAC
	ldrh r2,[r1,#0x4]	; 037FAAAE
	ldr r1,[pool_037FAB08]	; 037FAAB0
	strh r2,[r1,#0x0]	; 037FAAB2
	ldr r2,[pool_037FAB0C]	; 037FAAB4
	ldr r1,[pool_037FAB10]	; 037FAAB6
	str r2,[r1,#0x0]	; 037FAAB8
	mov r1,#0x1	; 037FAABA
	str r1,[sp,#0x0]	; 037FAABC
	ldr r1,[pool_037FAB14]	; 037FAABE
	mov r2,#0x0	; 037FAAC0
	ldr r3,[pool_037FAB18]	; 037FAAC2
	bl P2_SubmitTransferRequest	; 037FAAC4
	ldr r0,[pool_037FAB1C]	; 037FAAC8
	ldr r1,[r0,#0xc]	; 037FAACA
	ldr r0,[pool_037FAB14]	; 037FAACC
	add r1,r1,r0	; 037FAACE
	ldr r0,[pool_037FAB20]	; 037FAAD0
	str r1,[r0,#0x0]	; 037FAAD2
	ldr r1,[r0,#0x0]	; 037FAAD4
	mov r0,#0x1	; 037FAAD6
	str r0,[sp,#0x0]	; 037FAAD8
	add r0,r4,#0x0	; 037FAADA
	mov r2,#0x0	; 037FAADC
	ldr r3,[pool_037FAB24]	; 037FAADE
	sub r3,r3,r1	; 037FAAE0
	bl P2_SubmitTransferRequest	; 037FAAE2
	ldr r0,[pool_037FAB20]	; 037FAAE6
	ldr r1,[r0,#0x0]	; 037FAAE8
	ldr r0,[pool_037FAB1C]	; 037FAAEA
	ldr r0,[r0,#0xc]	; 037FAAEC
	add r1,r1,r0	; 037FAAEE
	ldr r0,[pool_037FAB28]	; 037FAAF0
	str r1,[r0,#0x0]	; 037FAAF2
	ldr r0,[pool_037FAB2C]	; 037FAAF4
	bl P2_OrSharedEventFlags	; 037FAAF6
	add sp,#0x8	; 037FAAFA
	pop {r4}	; 037FAAFC
	pop {r3}	; 037FAAFE
	bx r3	; 037FAB00
.endfunc
	.byte 0xC0, 0x46	; 037FAB04
pool_037FAB04:
loc_037FAB04:
	.word P2_CachedFirmwareHeader	; 037FAB04
pool_037FAB08:
loc_037FAB08:
	.word FirmwareBootSharedAddress + BootSharedP3P4Crc16Offset	; 037FAB08
pool_037FAB0C:
loc_037FAB0C:
	.word P4_FirmwareServiceEntry	; 037FAB0C
pool_037FAB10:
loc_037FAB10:
	.word FirmwareBootSharedAddress + BootSharedP4DestinationOffset	; 037FAB10
pool_037FAB14:
loc_037FAB14:
	.word FirmwareComponentStagingAddress	; 037FAB14
pool_037FAB18:
loc_037FAB18:
	.word 0x00040000	; 037FAB18
pool_037FAB1C:
loc_037FAB1C:
	.word P2_BssStart + 0x18	; 037FAB1C
pool_037FAB20:
loc_037FAB20:
	.word FirmwareBootSharedAddress + BootSharedP4StagingOffset	; 037FAB20
pool_037FAB24:
loc_037FAB24:
	.word FirmwareComponentStagingLimit	; 037FAB24
pool_037FAB28:
loc_037FAB28:
	.word FirmwareBootSharedAddress + BootSharedStagingEndOffset	; 037FAB28
pool_037FAB2C:
loc_037FAB2C:
	.word 0x00001000	; 037FAB2C

; Stages header-described firmware P5 for the next ARM9 boot stage.
; 将头部描述的固件 P5 暂存，供下一 ARM9 启动阶段使用。
.func P2_LoadFirmwarePart5ToStaging
loc_037FAB30:
	push {lr}	; 037FAB30
	sub sp,#0x4	; 037FAB32
	ldr r1,[pool_037FAB5C]	; 037FAB34
	ldrh r0,[r1,#0x16]	; 037FAB36
	lsl r0,r0,#0x3	; 037FAB38
	ldrh r2,[r1,#0x26]	; 037FAB3A
	ldr r1,[pool_037FAB60]	; 037FAB3C
	strh r2,[r1,#0x0]	; 037FAB3E
	mov r1,#0x1	; 037FAB40
	str r1,[sp,#0x0]	; 037FAB42
	ldr r1,[pool_037FAB64]	; 037FAB44
	mov r2,#0x0	; 037FAB46
	ldr r3,[pool_037FAB68]	; 037FAB48
	bl P2_SubmitTransferRequest	; 037FAB4A
	ldr r0,[pool_037FAB6C]	; 037FAB4E
	bl P2_OrSharedEventFlags	; 037FAB50
	add sp,#0x4	; 037FAB54
	pop {r3}	; 037FAB56
	bx r3	; 037FAB58
.endfunc
	.byte 0xC0, 0x46	; 037FAB5C
pool_037FAB5C:
loc_037FAB5C:
	.word P2_CachedFirmwareHeader	; 037FAB5C
pool_037FAB60:
loc_037FAB60:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 037FAB60
pool_037FAB64:
loc_037FAB64:
	.word FirmwareComponentStagingAddress	; 037FAB64
pool_037FAB68:
loc_037FAB68:
	.word 0x00040000	; 037FAB68
pool_037FAB6C:
loc_037FAB6C:
	.word 0x00002000	; 037FAB6C

; Cache the SPI firmware header and publish header[0x20] * 8 as the settings address.
; 缓存 SPI 固件头，将头部 [0x20] * 8 发布为用户设置地址。
.func P2_LoadFirmwareHeaderAndSettingsOffset
loc_037FAB70:
	push {lr}	; 037FAB70
	sub sp,#0x4	; 037FAB72
	mov r0,#0x0	; 037FAB74
	str r0,[sp,#0x0]	; 037FAB76
	ldr r1,[pool_037FAB94]	; 037FAB78
	mov r2,#0x2c	; 037FAB7A
	add r3,r2,#0x0	; 037FAB7C
	bl P2_SubmitTransferRequest	; 037FAB7E
	ldr r0,[pool_037FAB94]	; 037FAB82
	ldrh r0,[r0,#0x20]	; 037FAB84
	lsl r1,r0,#0x3	; 037FAB86
	ldr r0,[pool_037FAB98]	; 037FAB88
	str r1,[r0,#0x0]	; 037FAB8A
	add sp,#0x4	; 037FAB8C
	pop {r3}	; 037FAB8E
	bx r3	; 037FAB90
.endfunc
	.byte 0xC0, 0x46	; 037FAB94
pool_037FAB94:
loc_037FAB94:
	.word P2_CachedFirmwareHeader	; 037FAB94
pool_037FAB98:
loc_037FAB98:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 037FAB98

; ===== function P2_ClearMainRamOutsideArm9Image =====
; Clears the main-RAM ranges before and after the ARM9 image described by NDS header +0x28/+0x2C.
; 按 NDS 头 +0x28/+0x2C 所述 ARM9 映像，清零其前后两段主 RAM。
.func P2_ClearMainRamOutsideArm9Image
loc_037FAB9C:
	push {lr}	; 037FAB9C
	sub sp,#0xc	; 037FAB9E
	ldr r1,[pool_037FABF4]	; 037FABA0
	ldr r0,[pool_037FABF8]	; 037FABA2
	ldr r0,[r0,#0x0]	; 037FABA4
	cmp r0,r1	; 037FABA6
	bls loc_037FABC4	; 037FABA8
	sub r2,r0,r1	; 037FABAA
	cmp r2,#0x0	; 037FABAC
	beq loc_037FABC4	; 037FABAE
	mov r0,#0x0	; 037FABB0
	str r0,[sp,#0x0]	; 037FABB2
	add r0,sp,#0x0	; 037FABB4
	lsr r2,r2,#0x2	; 037FABB6
	ldr r3,[pool_037FABFC]	; 037FABB8
	and r2,r3	; 037FABBA
	ldr r3,[pool_037FAC00]	; 037FABBC
	orr r2,r3	; 037FABBE
	bl P2_SwiCpuFastSet	; 037FABC0
loc_037FABC4:
	ldr r0,[pool_037FABF8]	; 037FABC4
	ldr r1,[r0,#0x0]	; 037FABC6
	ldr r0,[pool_037FAC04]	; 037FABC8
	ldr r0,[r0,#0x0]	; 037FABCA
	add r1,r1,r0	; 037FABCC
	ldr r0,[pool_037FAC08]	; 037FABCE
	cmp r1,r0	; 037FABD0
	bcs loc_037FABEE	; 037FABD2
	sub r2,r0,r1	; 037FABD4
	cmp r2,#0x0	; 037FABD6
	beq loc_037FABEE	; 037FABD8
	mov r0,#0x0	; 037FABDA
	str r0,[sp,#0x4]	; 037FABDC
	add r0,sp,#0x4	; 037FABDE
	lsr r2,r2,#0x2	; 037FABE0
	ldr r3,[pool_037FABFC]	; 037FABE2
	and r2,r3	; 037FABE4
	ldr r3,[pool_037FAC00]	; 037FABE6
	orr r2,r3	; 037FABE8
	bl P2_SwiCpuFastSet	; 037FABEA
loc_037FABEE:
	add sp,#0xc	; 037FABEE
	pop {r3}	; 037FABF0
	bx r3	; 037FABF2
.endfunc
pool_037FABF4:
loc_037FABF4:
	.word 0x02010000	; 037FABF4
pool_037FABF8:
loc_037FABF8:
	.word NdsCartHeaderArm9RamAddress	; 037FABF8
pool_037FABFC:
loc_037FABFC:
	.word 0x001FFFFF	; 037FABFC
pool_037FAC00:
loc_037FAC00:
	.word 0x01000000	; 037FAC00
pool_037FAC04:
loc_037FAC04:
	.word NdsCartHeaderArm9SizeAddress	; 037FAC04
pool_037FAC08:
loc_037FAC08:
	.word 0x02300000	; 037FAC08

; ===== function loc_037FAC0C =====
loc_037FAC0C:
	push {lr}	; 037FAC0C
	sub sp,#0x4	; 037FAC0E
	add r0,sp,#0x0	; 037FAC10
	bl loc_038028B8	; 037FAC12
	add r1,sp,#0x0	; 037FAC16
	ldrh r2,[r1,#0x0]	; 037FAC18
	mov r0,#0xf	; 037FAC1A
	bic r2,r0	; 037FAC1C
	mov r0,#0x4	; 037FAC1E
	orr r2,r0	; 037FAC20
	strh r2,[r1,#0x0]	; 037FAC22
	ldrh r2,[r1,#0x0]	; 037FAC24
	mov r0,#0x40	; 037FAC26
	orr r2,r0	; 037FAC28
	strh r2,[r1,#0x0]	; 037FAC2A
	add r0,sp,#0x0	; 037FAC2C
	bl loc_03802898	; 037FAC2E
	ldr r0,[pool_037FAC5C]	; 037FAC32
	bl loc_03802980	; 037FAC34
	ldr r0,[pool_037FAC5C]	; 037FAC38
	bl loc_03802918	; 037FAC3A
	add r1,sp,#0x0	; 037FAC3E
	ldrh r2,[r1,#0x0]	; 037FAC40
	mov r0,#0xf	; 037FAC42
	bic r2,r0	; 037FAC44
	strh r2,[r1,#0x0]	; 037FAC46
	ldrh r2,[r1,#0x0]	; 037FAC48
	mov r0,#0x40	; 037FAC4A
	bic r2,r0	; 037FAC4C
	strh r2,[r1,#0x0]	; 037FAC4E
	add r0,sp,#0x0	; 037FAC50
	bl loc_03802898	; 037FAC52
	add sp,#0x4	; 037FAC56
	pop {r3}	; 037FAC58
	bx r3	; 037FAC5A
pool_037FAC5C:
loc_037FAC5C:
	.word 0x038053A4	; 037FAC5C

; ===== function P2_SubmitTransferRequest =====
; Copies five transfer arguments into the shared descriptor, then dispatches the request to the transfer service.
; 将五个传输参数写入共享描述符，再把请求交给传输服务调度。
.func P2_SubmitTransferRequest
loc_037FAC60:
	push {r4,r5,lr}	; 037FAC60
	sub sp,#0x4	; 037FAC62
	ldr r5,[sp,#0x10]	; 037FAC64
	ldr r4,[pool_037FAC80]	; 037FAC66
	str r5,[r4,#0x0]	; 037FAC68
	str r0,[r4,#0x4]	; 037FAC6A
	str r1,[r4,#0x8]	; 037FAC6C
	str r2,[r4,#0xc]	; 037FAC6E
	str r3,[r4,#0x10]	; 037FAC70
	ldr r0,[pool_037FAC84]	; 037FAC72
	bl loc_037FDEE8	; 037FAC74
	add sp,#0x4	; 037FAC78
	pop {r4,r5}	; 037FAC7A
	pop {r3}	; 037FAC7C
	bx r3	; 037FAC7E
.endfunc
pool_037FAC80:
loc_037FAC80:
	.word P2_BssStart + 0x18	; 037FAC80
pool_037FAC84:
loc_037FAC84:
	.word 0x038053F4	; 037FAC84

; ===== function P2_RunTransferRequestServiceLoop =====
; Continuously services the transfer descriptor filled by P2_SubmitTransferRequest.
; 持续处理由 P2_SubmitTransferRequest 填入的传输描述符。
.func P2_RunTransferRequestServiceLoop
loc_037FAC88:
	push {r4,r5,r6,r7,lr}	; 037FAC88
	sub sp,#0x4	; 037FAC8A
	mov r6,#0x0	; 037FAC8C
	mov r7,#0x3	; 037FAC8E
	ldr r4,[pool_037FACDC]	; 037FAC90
	ldr r5,[pool_037FACE0]	; 037FAC92
loc_037FAC94:
	ldr r0,[r5,#0x0]	; 037FAC94
	bl loc_03802F40	; 037FAC96
	ldr r0,[r4,#0x0]	; 037FAC9A
	cmp r0,#0x0	; 037FAC9C
	beq loc_037FACC4	; 037FAC9E
	str r6,[r4,#0xc]	; 037FACA0
	ldr r0,[r4,#0x4]	; 037FACA2
	add r1,r7,#0x0	; 037FACA4
	ldr r2,[pool_037FACE4]	; 037FACA6
	bl loc_03803F5C	; 037FACA8
	ldr r0,[r4,#0xc]	; 037FACAC
	lsr r1,r0,#0x2	; 037FACAE
	str r1,[r4,#0xc]	; 037FACB0
	ldr r0,[r4,#0x10]	; 037FACB2
	cmp r1,r0	; 037FACB4
	bls loc_037FACBA	; 037FACB6
loc_037FACB8:
	b loc_037FACB8	; 037FACB8
loc_037FACBA:
	ldr r0,[r4,#0x4]	; 037FACBA
	ldr r2,[r4,#0x8]	; 037FACBC
	bl loc_03803F5C	; 037FACBE
	b loc_037FACCE	; 037FACC2
loc_037FACC4:
	ldr r0,[r4,#0x4]	; 037FACC4
	ldr r1,[r4,#0xc]	; 037FACC6
	ldr r2,[r4,#0x8]	; 037FACC8
	bl loc_03803F5C	; 037FACCA
loc_037FACCE:
	ldr r0,[r5,#0x0]	; 037FACCE
	bl loc_03802EF8	; 037FACD0
	add r0,r6,#0x0	; 037FACD4
	bl loc_037FDF54	; 037FACD6
	b loc_037FAC94	; 037FACDA
.endfunc
pool_037FACDC:
loc_037FACDC:
	.word 0x038053B8	; 037FACDC
pool_037FACE0:
loc_037FACE0:
	.word P2_BssStart + 0x14	; 037FACE0
pool_037FACE4:
loc_037FACE4:
	.word 0x038053C4	; 037FACE4

; ===== function loc_037FACE8 =====
P2_IrqHandler_037FACE8:
	push {lr}	; 037FACE8
	sub sp,#0x4	; 037FACEA
	ldr r0,[pool_037FAD08]	; 037FACEC
	ldr r0,[r0,#0x0]	; 037FACEE
	cmp r0,#0x0	; 037FACF0
	beq loc_037FACF8	; 037FACF2
	bl loc_038047DC	; 037FACF4
loc_037FACF8:
	ldr r2,[pool_037FAD0C]	; 037FACF8
	ldr r1,[r2,#0x0]	; 037FACFA
	mov r0,#0x1	; 037FACFC
	orr r1,r0	; 037FACFE
	str r1,[r2,#0x0]	; 037FAD00
	add sp,#0x4	; 037FAD02
	pop {r3}	; 037FAD04
	bx r3	; 037FAD06
pool_037FAD08:
loc_037FAD08:
	.word P2_BssStart + 0x26A0	; 037FAD08
pool_037FAD0C:
loc_037FAD0C:
	.word Bios7IrqFlagsAddress	; 037FAD0C
; 通道 1 的用户回调：将主工作区的首字写为 6。
; Channel 1 user callback: write 6 to the first main-work word.
.func P2_PxiChannel1UserCallback
	mov r1,#0x6	; 037FAD10
	ldr r0,[pool_037FAD18]	; 037FAD12
	str r1,[r0,#0x0]	; 037FAD14
	bx lr	; 037FAD16
.endfunc
pool_037FAD18:
loc_037FAD18:
	.word P2_BssStart	; 037FAD18
P2_PxiCallback_037FAD1C:
	cmp r1,#0x3	; 037FAD1C
	bne loc_037FAD28	; 037FAD1E
	mov r1,#0x6	; 037FAD20
	ldr r0,[pool_037FAD4C]	; 037FAD22
	str r1,[r0,#0x0]	; 037FAD24
	bx lr	; 037FAD26
loc_037FAD28:
	cmp r1,#0x6	; 037FAD28
	bne loc_037FAD34	; 037FAD2A
	mov r1,#0x5	; 037FAD2C
	ldr r0,[pool_037FAD4C]	; 037FAD2E
	str r1,[r0,#0x0]	; 037FAD30
	bx lr	; 037FAD32
loc_037FAD34:
	cmp r1,#0x4	; 037FAD34
	bne loc_037FAD40	; 037FAD36
	mov r1,#0x9	; 037FAD38
	ldr r0,[pool_037FAD4C]	; 037FAD3A
	str r1,[r0,#0x0]	; 037FAD3C
	bx lr	; 037FAD3E
loc_037FAD40:
	cmp r1,#0x7	; 037FAD40
	bne loc_037FAD4A	; 037FAD42
	mov r1,#0x8	; 037FAD44
	ldr r0,[pool_037FAD4C]	; 037FAD46
	str r1,[r0,#0x0]	; 037FAD48
loc_037FAD4A:
	bx lr	; 037FAD4A
pool_037FAD4C:
loc_037FAD4C:
	.word P2_BssStart	; 037FAD4C

; ===== function P2_OrSharedEventFlags =====
; ORs caller-supplied flags into the guarded shared event field.
; 在受保护的共享事件字段中合并调用方提供的标志位。
.func P2_OrSharedEventFlags
loc_037FAD50:
	push {r4,lr}	; 037FAD50
	add r4,r0,#0x0	; 037FAD52
	mov r0,#0xae	; 037FAD54
	ldr r1,[pool_037FAD74]	; 037FAD56
	mov r2,#0x0	; 037FAD58
	bl loc_037FDD8C	; 037FAD5A
	ldr r1,[pool_037FAD74]	; 037FAD5E
	ldr r0,[r1,#0x8]	; 037FAD60
	orr r0,r4	; 037FAD62
	str r0,[r1,#0x8]	; 037FAD64
	mov r0,#0xae	; 037FAD66
	mov r2,#0x0	; 037FAD68
	bl loc_037FDD18	; 037FAD6A
	pop {r4}	; 037FAD6E
	pop {r3}	; 037FAD70
	bx r3	; 037FAD72
.endfunc
pool_037FAD74:
loc_037FAD74:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 037FAD74
; Initializes hardware and drives the cartridge/firmware boot transfer states.
; 初始化硬件，并驱动卡带／固件启动传输状态。
P2_RunBootTransferStateMachine:
loc_037FAD78:
	push {r4,r5,r6,r7,lr}	; 037FAD78
	sub sp,#0xc	; 037FAD7A
	mov r0,#0x0	; 037FAD7C
	str r0,[sp,#0x8]	; 037FAD7E
	add r0,sp,#0x8	; 037FAD80
	ldr r1,[pool_037FAF64]	; 037FAD82
	ldr r2,[pool_037FAF68]	; 037FAD84
	bl P2_SwiCpuFastSet	; 037FAD86
	ldr r1,[pool_037FAF6C]	; 037FAD8A
; 锁定 Lite 扩展寄存器；写入值保持 FFFF。
; Lock the Lite extension registers; retain the original FFFF write.
	ldr r0,[pool_037FAF70]	; 037FAD8C
	strh r1,[r0,#0x0]	; 037FAD8E
	ldr r0,[pool_037FAF74]	; 037FAD90
	ldr r2,[pool_037FAF78]	; 037FAD92
	strh r0,[r2,#0x0]	; 037FAD94
	mov r1,#0x0	; 037FAD96
	ldr r0,[pool_037FAF7C]	; 037FAD98
	str r1,[r0,#0x0]	; 037FAD9A
	str r1,[r2,#0x0]	; 037FAD9C
	mov r0,#0x1	; 037FAD9E
	bl loc_0380443C	; 037FADA0
	mov r1,#0x1	; 037FADA4
	ldr r0,[pool_037FAF80]	; 037FADA6
	strh r1,[r0,#0x0]	; 037FADA8
	mov r0,#0x10	; 037FADAA
	bl loc_03804902	; 037FADAC
	bl loc_037FAC0C	; 037FADB0
	bl loc_037FE48C	; 037FADB4
	ldr r0,[pool_037FAF84]	; 037FADB8
	bl P2_InitPxiChannel1Callback	; 037FADBA
	bl loc_037FB018	; 037FADBE
	mov r0,#0x8	; 037FADC2
	ldr r1,[pool_037FAF88]	; 037FADC4
	bl loc_037FE4B8	; 037FADC6
	mov r0,#0x8	; 037FADCA
	ldr r1,[pool_037FAF8C]	; 037FADCC
	bl loc_037FE4C4	; 037FADCE
	bl loc_038020E4	; 037FADD2
	mov r0,#0x2	; 037FADD6
	bl loc_03802F88	; 037FADD8
	mov r0,#0x3	; 037FADDC
	bl loc_037FFAA4	; 037FADDE
	mov r0,#0x8	; 037FADE2
	bl loc_03802540	; 037FADE4
	bl loc_037FAFF4	; 037FADE8
	ldr r1,[pool_037FAF90]	; 037FADEC
	str r0,[r1,#0x0]	; 037FADEE
	mov r0,#0x2	; 037FADF0
	ldr r1,[pool_037FAF94]	; 037FADF2
	bl P2_SetPxiReceiveCallback	; 037FADF4
	ldr r0,[pool_037FAF98]	; 037FADF8
	str r0,[sp,#0x0]	; 037FADFA
	mov r0,#0xe	; 037FADFC
	str r0,[sp,#0x4]	; 037FADFE
	ldr r0,[pool_037FAF9C]	; 037FAE00
	ldr r1,[pool_037FAFA0]	; 037FAE02
	mov r2,#0x0	; 037FAE04
	ldr r3,[pool_037FAFA4]	; 037FAE06
	bl P2_CreateThread	; 037FAE08
	bl P2_InitializeBootProcedureCallbacks	; 037FAE0C
	ldr r0,[pool_037FAFA8]	; 037FAE10
	ldr r1,[pool_037FAFAC]	; 037FAE12
	ldr r1,[r1,#0x0]	; 037FAE14
	bl loc_037FDB1C	; 037FAE16
	mov r0,#0x1	; 037FAE1A
	ldr r1,[pool_037FAFB0]	; 037FAE1C
	bl loc_037FDB1C	; 037FAE1E
	mov r0,#0x1	; 037FAE22
	bl loc_037FDA98	; 037FAE24
	bl loc_037FB000	; 037FAE28
	ldr r2,[pool_037FAFB4]	; 037FAE2C
	ldrh r0,[r2,#0x0]	; 037FAE2E
	ldrh r1,[r2,#0x0]	; 037FAE30
	mov r0,#0x8	; 037FAE32
	orr r1,r0	; 037FAE34
	strh r1,[r2,#0x0]	; 037FAE36
	ldr r1,[pool_037FAFB8]	; 037FAE38
	ldrh r0,[r1,#0x0]	; 037FAE3A
	mov r0,#0x1	; 037FAE3C
	strh r0,[r1,#0x0]	; 037FAE3E
	bl P2_LoadFirmwareHeaderAndSettingsOffset	; 037FAE40
	bl P2_LoadFirmwarePart5ToStaging	; 037FAE44
	mov r0,#0x3	; 037FAE48
	ldr r5,[pool_037FAFBC]	; 037FAE4A
	str r0,[r5,#0x0]	; 037FAE4C
	ldr r7,[pool_037FAFC0]	; 037FAE4E
	mov r6,#0x2	; 037FAE50
	ldr r4,[pool_037FAFC4]	; 037FAE52
loc_037FAE54:
	mov r0,#0x1	; 037FAE54
	lsl r1,r0,#0	; 037FAE56
	bl loc_037FF170	; 037FAE58
	ldr r0,[r4,#0x24]	; 037FAE5C
	cmp r0,#0x3	; 037FAE5E
	bne loc_037FAE92	; 037FAE60
	ldr r1,[r7,#0x0]	; 037FAE62
	ldr r0,[pool_037FAFC8]	; 037FAE64
	and r1,r0	; 037FAE66
	cmp r1,#0x0	; 037FAE68
	beq loc_037FAE54	; 037FAE6A
	ldr r0,[r7,#0x0]	; 037FAE6C
	and r0,r6	; 037FAE6E
	cmp r0,#0x0	; 037FAE70
	beq loc_037FAE8E	; 037FAE72
	ldr r1,[r7,#0x0]	; 037FAE74
	mov r0,#0x4	; 037FAE76
	and r1,r0	; 037FAE78
	cmp r1,#0x0	; 037FAE7A
	bne loc_037FAE8E	; 037FAE7C
	bl P2_ClearMainRamOutsideArm9Image	; 037FAE7E
	mov r0,#0xac	; 037FAE82
	bl loc_037FDC74	; 037FAE84
	mov r0,#0x4	; 037FAE88
	str r0,[r5,#0x0]	; 037FAE8A
	b loc_037FAE54	; 037FAE8C
loc_037FAE8E:
	str r6,[r5,#0x0]	; 037FAE8E
	b loc_037FAE54	; 037FAE90
loc_037FAE92:
	ldr r0,[r4,#0x24]	; 037FAE92
	cmp r0,#0x4	; 037FAE94
	bne loc_037FAEB8	; 037FAE96
	ldr r0,[pool_037FAFCC]	; 037FAE98
	ldr r0,[r0,#0x0]	; 037FAE9A
	bl loc_0380508C	; 037FAE9C
	mov r1,#0x1	; 037FAEA0
	mvn r1,r1	; 037FAEA2
	cmp r0,r1	; 037FAEA4
	bne loc_037FAE54	; 037FAEA6
	mov r0,#0xac	; 037FAEA8
	bl loc_037FDBA8	; 037FAEAA
	ldr r0,[pool_037FAFD0]	; 037FAEAE
	bl P2_OrSharedEventFlags	; 037FAEB0
	str r6,[r5,#0x0]	; 037FAEB4
	b loc_037FAE54	; 037FAEB6
loc_037FAEB8:
	ldr r0,[r4,#0x24]	; 037FAEB8
	cmp r0,#0x2	; 037FAEBA
	beq loc_037FAEC4	; 037FAEBC
	ldr r0,[r4,#0x24]	; 037FAEBE
	cmp r0,#0x7	; 037FAEC0
	bne loc_037FAED6	; 037FAEC2
loc_037FAEC4:
	ldr r0,[pool_037FAFD4]	; 037FAEC4
	ldr r0,[r0,#0x0]	; 037FAEC6
	cmp r0,#0x0	; 037FAEC8
	beq loc_037FAE54	; 037FAECA
	str r0,[r5,#0x0]	; 037FAECC
	mov r1,#0x0	; 037FAECE
	ldr r0,[pool_037FAFD4]	; 037FAED0
	str r1,[r0,#0x0]	; 037FAED2
	b loc_037FAE54	; 037FAED4
loc_037FAED6:
	ldr r0,[r4,#0x24]	; 037FAED6
	cmp r0,#0x6	; 037FAED8
	bne loc_037FAEF8	; 037FAEDA
	ldr r0,[pool_037FAFD8]	; 037FAEDC
	ldr r0,[r0,#0x0]	; 037FAEDE
	cmp r0,#0x7	; 037FAEE0
	bne loc_037FAE54	; 037FAEE2
	bl P2_ApplyGameCodeRevisionPatch	; 037FAEE4
	bl P2_ApplyKeyedRuntimePatch	; 037FAEE8
	bl P2_ResetArm7Peripherals	; 037FAEEC
	ldr r1,[pool_037FAFDC]	; 037FAEF0
	ldr r0,[pool_037FAFE0]	; 037FAEF2
	strh r1,[r0,#0x0]	; 037FAEF4
	b loc_037FAF5A	; 037FAEF6
loc_037FAEF8:
	ldr r0,[r4,#0x24]	; 037FAEF8
	cmp r0,#0x5	; 037FAEFA
	bne loc_037FAF08	; 037FAEFC
	bl P2_LoadSecondaryFirmwarePartsToStaging	; 037FAEFE
	mov r0,#0x7	; 037FAF02
	str r0,[r5,#0x0]	; 037FAF04
	b loc_037FAE54	; 037FAF06
loc_037FAF08:
	ldr r0,[r4,#0x24]	; 037FAF08
	cmp r0,#0x8	; 037FAF0A
	bne loc_037FAF24	; 037FAF0C
	mov r1,#0x6	; 037FAF0E
; 启动状态 8 路径在私有源区写入 6；发布时此字段会被另行覆盖。
; Boot state 8 writes 6 to this private slot; publication later replaces the field.
	ldr r0,[pool_037FAFE4]	; 037FAF10
	strh r1,[r0,#0x0]	; 037FAF12
	ldr r0,[pool_037FAFCC]	; 037FAF14
	ldr r0,[r0,#0x0]	; 037FAF16
	bl loc_0380508C	; 037FAF18
	bl loc_037FB00C	; 037FAF1C
	str r6,[r5,#0x0]	; 037FAF20
	b loc_037FAE54	; 037FAF22
loc_037FAF24:
	ldr r0,[r4,#0x24]	; 037FAF24
	cmp r0,#0x9	; 037FAF26
	bne loc_037FAE54	; 037FAF28
	ldr r0,[pool_037FAFD8]	; 037FAF2A
	ldr r0,[r0,#0x0]	; 037FAF2C
	cmp r0,#0x9	; 037FAF2E
	bne loc_037FAE54	; 037FAF30
	ldr r0,[pool_037FAFB8]	; 037FAF32
	ldrh r0,[r0,#0x0]	; 037FAF34
	mov r1,#0x0	; 037FAF36
	ldr r0,[pool_037FAFB8]	; 037FAF38
	strh r1,[r0,#0x0]	; 037FAF3A
	ldr r0,[pool_037FAFE8]	; 037FAF3C
	ldr r1,[pool_037FAFEC]	; 037FAF3E
	ldr r2,[pool_037FAFF0]	; 037FAF40
	bl P2_SwiCpuFastSet	; 037FAF42
	mov r0,#0x10	; 037FAF46
	bl loc_0380490A	; 037FAF48
	ldr r0,[pool_037FAF74]	; 037FAF4C
	bl loc_038048DC	; 037FAF4E
	ldr r0,[pool_037FAFEC]	; 037FAF52
	bl loc_0380508C	; 037FAF54
	b loc_037FAE54	; 037FAF58
loc_037FAF5A:
	add sp,#0xc	; 037FAF5A
	pop {r4,r5,r6,r7}	; 037FAF5C
	pop {r3}	; 037FAF5E
	bx r3	; 037FAF60
	.byte 0xC0, 0x46	; 037FAF64
pool_037FAF64:
loc_037FAF64:
	.word 0x023FE800	; 037FAF64
pool_037FAF68:
loc_037FAF68:
	.word 0x01000200	; 037FAF68
pool_037FAF6C:
loc_037FAF6C:
	.word 0x0000FFFF	; 037FAF6C
pool_037FAF70:
loc_037FAF70:
	.word REG_NITRO2_REGCNT	; 037FAF70
pool_037FAF74:
loc_037FAF74:
	.word 0x00001000	; 037FAF74
pool_037FAF78:
loc_037FAF78:
	.word REG_SIOCNT_ARM7	; 037FAF78
pool_037FAF7C:
loc_037FAF7C:
	.word REG_SIODATA32_ARM7	; 037FAF7C
pool_037FAF80:
loc_037FAF80:
	.word REG_POWERCNT	; 037FAF80
pool_037FAF84:
loc_037FAF84:
	.word P2_PxiChannel1UserCallback + 1	; 037FAF84
pool_037FAF88:
loc_037FAF88:
	.word 0x03807A9C	; 037FAF88
pool_037FAF8C:
loc_037FAF8C:
	.word 0x0380F600	; 037FAF8C
pool_037FAF90:
loc_037FAF90:
	.word P2_BssStart + 0x14	; 037FAF90
pool_037FAF94:
loc_037FAF94:
	.word P2_PxiCallback_037FAD1C + 1	; 037FAF94
pool_037FAF98:
loc_037FAF98:
	.word 0x00000400	; 037FAF98
pool_037FAF9C:
loc_037FAF9C:
	.word 0x038053F4	; 037FAF9C
pool_037FAFA0:
loc_037FAFA0:
	.word P2_RunTransferRequestServiceLoop + 1	; 037FAFA0
pool_037FAFA4:
loc_037FAFA4:
	.word 0x0380586C	; 037FAFA4
pool_037FAFA8:
loc_037FAFA8:
	.word 0x00080000	; 037FAFA8
pool_037FAFAC:
loc_037FAFAC:
	.word P2_BssStart + 0x10	; 037FAFAC
pool_037FAFB0:
loc_037FAFB0:
	.word P2_IrqHandler_037FACE8 + 1	; 037FAFB0
pool_037FAFB4:
loc_037FAFB4:
	.word REG_DISPSTAT	; 037FAFB4
pool_037FAFB8:
loc_037FAFB8:
	.word REG_IME	; 037FAFB8
pool_037FAFBC:
loc_037FAFBC:
	.word FirmwareBootSharedAddress + BootSharedArm7StateOffset	; 037FAFBC
pool_037FAFC0:
loc_037FAFC0:
	.word 0x027FF890	; 037FAFC0
pool_037FAFC4:
loc_037FAFC4:
	.word 0x027FF860	; 037FAFC4
pool_037FAFC8:
loc_037FAFC8:
	.word 0x20000000	; 037FAFC8
pool_037FAFCC:
loc_037FAFCC:
	.word P2_BssStart + 0xC	; 037FAFCC
pool_037FAFD0:
loc_037FAFD0:
	.word 0x00000200	; 037FAFD0
pool_037FAFD4:
loc_037FAFD4:
	.word P2_BssStart	; 037FAFD4
pool_037FAFD8:
loc_037FAFD8:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 037FAFD8
pool_037FAFDC:
loc_037FAFDC:
	.word 0x00002100	; 037FAFDC
pool_037FAFE0:
loc_037FAFE0:
	.word REG_IPC_SYNC	; 037FAFE0
pool_037FAFE4:
loc_037FAFE4:
	.word FirmwareBootInfoScratchAddress + 0x10	; 037FAFE4
pool_037FAFE8:
loc_037FAFE8:
	.word P2_WaitVCount200ThenEnterAgbMode	; 037FAFE8
pool_037FAFEC:
loc_037FAFEC:
	.word 0x037F8000	; 037FAFEC
pool_037FAFF0:
loc_037FAFF0:
	.word 0x00000100	; 037FAFF0

; ===== function loc_037FAFF4 =====
loc_037FAFF4:
	bx pc	; 037FAFF4
	.byte 0xC0, 0x46	; 037FAFF8
.arm

; ===== function loc_037FAFF8 =====
loc_037FAFF8:
	ldr pc,[pool_037FAFFC]	; 037FAFF8
pool_037FAFFC:
loc_037FAFFC:
	.word loc_037FDBB0	; 037FAFFC
.thumb

; ===== function loc_037FB000 =====
loc_037FB000:
	bx pc	; 037FB000
	.byte 0xC0, 0x46	; 037FB004
.arm

; ===== function loc_037FB004 =====
loc_037FB004:
	ldr pc,[pool_037FB008]	; 037FB004
pool_037FB008:
loc_037FB008:
	.word loc_037FF0F8	; 037FB008
.thumb

; ===== function loc_037FB00C =====
loc_037FB00C:
	bx pc	; 037FB00C
	.byte 0xC0, 0x46	; 037FB010
.arm

; ===== function loc_037FB010 =====
loc_037FB010:
	ldr pc,[pool_037FB014]	; 037FB010
pool_037FB014:
loc_037FB014:
	.word P4_InitializeRuntimeContext	; 037FB014
.thumb

; ===== function loc_037FB018 =====
loc_037FB018:
	push {lr}	; 037FB018
	sub sp,#0xc	; 037FB01A
	bl loc_037FB27C	; 037FB01C
	cmp r0,#0x0	; 037FB020
	bne loc_037FB028	; 037FB022
	mov r0,#0x0	; 037FB024
	b loc_037FB060	; 037FB026
loc_037FB028:
	ldr r2,[pool_037FB068]	; 037FB028
	ldrh r1,[r2,#0x0]	; 037FB02A
	mov r0,#0x2	; 037FB02C
	orr r1,r0	; 037FB02E
	strh r1,[r2,#0x0]	; 037FB030
	mov r1,#0x30	; 037FB032
	ldr r0,[pool_037FB06C]	; 037FB034
	strh r1,[r0,#0x0]	; 037FB036
	add r0,sp,#0x0	; 037FB038
	bl loc_037FB1D0	; 037FB03A
	bl loc_037FB32C	; 037FB03E
	bl loc_037FB190	; 037FB042
	add r0,sp,#0x0	; 037FB046
	bl loc_037FB174	; 037FB048
	add r0,sp,#0x0	; 037FB04C
	ldrh r0,[r0,#0x0]	; 037FB04E
	bl loc_037FB2E4	; 037FB050
	ldr r2,[pool_037FB068]	; 037FB054
	ldrh r1,[r2,#0x0]	; 037FB056
	mov r0,#0x2	; 037FB058
	bic r1,r0	; 037FB05A
	strh r1,[r2,#0x0]	; 037FB05C
	mov r0,#0x1	; 037FB05E
loc_037FB060:
	add sp,#0xc	; 037FB060
	pop {r3}	; 037FB062
	bx r3	; 037FB064
	.byte 0xC0, 0x46	; 037FB068
pool_037FB068:
loc_037FB068:
	.word REG_POWERCNT	; 037FB068
pool_037FB06C:
loc_037FB06C:
	.word REG_WIFIWAITCNT_ARM7	; 037FB06C

; ===== function loc_037FB070 =====
loc_037FB070:
	push {r4,r5,lr}	; 037FB070
	sub sp,#0x4	; 037FB072
	mov r5,#0x2	; 037FB074
	str r5,[sp,#0x0]	; 037FB076
	add r4,sp,#0x0	; 037FB078
	b loc_037FB082	; 037FB07A
loc_037FB07C:
	add r0,r4,#0x0	; 037FB07C
	bl loc_03804058	; 037FB07E
loc_037FB082:
	ldr r0,[sp,#0x0]	; 037FB082
	and r0,r5	; 037FB084
	cmp r0,#0x0	; 037FB086
	bne loc_037FB07C	; 037FB088
	add sp,#0x4	; 037FB08A
	pop {r4,r5}	; 037FB08C
	pop {r3}	; 037FB08E
	bx r3	; 037FB090
	.byte 0x00, 0x00	; 037FB094

; ===== function loc_037FB094 =====
loc_037FB094:
	push {r4,r5,r6,lr}	; 037FB094
	add r5,r0,#0x0	; 037FB096
	add r4,r1,#0x0	; 037FB098
	add r6,r2,#0x0	; 037FB09A
	bl loc_037FB070	; 037FB09C
	add r0,r5,#0x0	; 037FB0A0
	add r1,r4,#0x0	; 037FB0A2
	add r2,r6,#0x0	; 037FB0A4
	bl loc_03803F5C	; 037FB0A6
	pop {r4,r5,r6}	; 037FB0AA
	pop {r3}	; 037FB0AC
	bx r3	; 037FB0AE

; ===== function loc_037FB0B0 =====
loc_037FB0B0:
	ldr r0,[pool_037FB0C8]	; 037FB0B0
	ldr r2,[pool_037FB0CC]	; 037FB0B2
	mov r1,#0x1	; 037FB0B4
	b loc_037FB0C2	; 037FB0B6
loc_037FB0B8:
	ldrh r3,[r2,#0x0]	; 037FB0B8
	and r3,r1	; 037FB0BA
	cmp r3,#0x0	; 037FB0BC
	beq loc_037FB0C6	; 037FB0BE
	sub r0,r0,#0x1	; 037FB0C0
loc_037FB0C2:
	cmp r0,#0x0	; 037FB0C2
	bne loc_037FB0B8	; 037FB0C4
loc_037FB0C6:
	bx lr	; 037FB0C6
pool_037FB0C8:
loc_037FB0C8:
	.word 0x00002000	; 037FB0C8
pool_037FB0CC:
loc_037FB0CC:
	.word 0x04808180	; 037FB0CC

; ===== function loc_037FB0D0 =====
loc_037FB0D0:
	push {r4,lr}	; 037FB0D0
	add r4,r0,#0x0	; 037FB0D2
	bl loc_037FB0B0	; 037FB0D4
	ldr r0,[pool_037FB0EC]	; 037FB0D8
	strh r4,[r0,#0x0]	; 037FB0DA
	lsr r1,r4,#0x10	; 037FB0DC
	ldr r0,[pool_037FB0F0]	; 037FB0DE
	strh r1,[r0,#0x0]	; 037FB0E0
	bl loc_037FB0B0	; 037FB0E2
	pop {r4}	; 037FB0E6
	pop {r3}	; 037FB0E8
	bx r3	; 037FB0EA
pool_037FB0EC:
loc_037FB0EC:
	.word REG_WIFI_RF_DATA1	; 037FB0EC
pool_037FB0F0:
loc_037FB0F0:
	.word REG_WIFI_RF_DATA2	; 037FB0F0

; ===== function loc_037FB0F4 =====
loc_037FB0F4:
	ldr r0,[pool_037FB10C]	; 037FB0F4
	ldr r2,[pool_037FB110]	; 037FB0F6
	mov r1,#0x1	; 037FB0F8
	b loc_037FB106	; 037FB0FA
loc_037FB0FC:
	ldrh r3,[r2,#0x0]	; 037FB0FC
	and r3,r1	; 037FB0FE
	cmp r3,#0x0	; 037FB100
	beq loc_037FB10A	; 037FB102
	sub r0,r0,#0x1	; 037FB104
loc_037FB106:
	cmp r0,#0x0	; 037FB106
	bne loc_037FB0FC	; 037FB108
loc_037FB10A:
	bx lr	; 037FB10A
pool_037FB10C:
loc_037FB10C:
	.word 0x00002000	; 037FB10C
pool_037FB110:
loc_037FB110:
	.word 0x0480815E	; 037FB110

; ===== function loc_037FB114 =====
loc_037FB114:
	push {r4,r5,lr}	; 037FB114
	sub sp,#0x4	; 037FB116
	add r5,r0,#0x0	; 037FB118
	add r4,r1,#0x0	; 037FB11A
	bl loc_037FB0F4	; 037FB11C
	ldr r0,[pool_037FB13C]	; 037FB120
	strh r4,[r0,#0x0]	; 037FB122
	ldr r0,[pool_037FB140]	; 037FB124
	orr r5,r0	; 037FB126
	ldr r0,[pool_037FB144]	; 037FB128
	strh r5,[r0,#0x0]	; 037FB12A
	bl loc_037FB0F4	; 037FB12C
	mov r0,#0x0	; 037FB130
	add sp,#0x4	; 037FB132
	pop {r4,r5}	; 037FB134
	pop {r3}	; 037FB136
	bx r3	; 037FB138
	.byte 0xC0, 0x46	; 037FB13C
pool_037FB13C:
loc_037FB13C:
	.word REG_WIFI_BB_WRITE	; 037FB13C
pool_037FB140:
loc_037FB140:
	.word 0x00005000	; 037FB140
pool_037FB144:
loc_037FB144:
	.word REG_WIFI_BB_CNT	; 037FB144

; ===== function loc_037FB148 =====
loc_037FB148:
	push {r4,lr}	; 037FB148
	add r4,r0,#0x0	; 037FB14A
	bl loc_037FB0F4	; 037FB14C
	ldr r0,[pool_037FB168]	; 037FB150
	orr r4,r0	; 037FB152
	ldr r0,[pool_037FB16C]	; 037FB154
	strh r4,[r0,#0x0]	; 037FB156
	bl loc_037FB0F4	; 037FB158
	ldr r0,[pool_037FB170]	; 037FB15C
	ldrh r0,[r0,#0x0]	; 037FB15E
	pop {r4}	; 037FB160
	pop {r3}	; 037FB162
	bx r3	; 037FB164
	.byte 0xC0, 0x46	; 037FB168
pool_037FB168:
loc_037FB168:
	.word 0x00006000	; 037FB168
pool_037FB16C:
loc_037FB16C:
	.word REG_WIFI_BB_CNT	; 037FB16C
pool_037FB170:
loc_037FB170:
	.word REG_WIFI_BB_READ	; 037FB170

; ===== function loc_037FB174 =====
loc_037FB174:
	ldrh r2,[r0,#0x2]	; 037FB174
	lsr r1,r2,#0x7	; 037FB176
	lsl r3,r1,#0x8	; 037FB178
	mov r1,#0x7f	; 037FB17A
	and r2,r1	; 037FB17C
	strh r2,[r0,#0x2]	; 037FB17E
	ldrh r0,[r0,#0x2]	; 037FB180
	orr r3,r0	; 037FB182
	ldr r0,[pool_037FB18C]	; 037FB184
	strh r3,[r0,#0x0]	; 037FB186
	bx lr	; 037FB188
	.byte 0xC0, 0x46	; 037FB18C
pool_037FB18C:
loc_037FB18C:
	.word REG_WIFI_RF_CNT	; 037FB18C

; ===== function loc_037FB190 =====
loc_037FB190:
	push {r4,r5,r6,r7,lr}	; 037FB190
	sub sp,#0x4	; 037FB192
	ldr r1,[pool_037FB1C8]	; 037FB194
	ldr r0,[pool_037FB1CC]	; 037FB196
	strh r1,[r0,#0x0]	; 037FB198
	mov r4,#0x64	; 037FB19A
	mov r5,#0x0	; 037FB19C
	str r5,[sp,#0x0]	; 037FB19E
	mov r6,#0x1	; 037FB1A0
	add r7,sp,#0x0	; 037FB1A2
loc_037FB1A4:
	add r0,r4,#0x0	; 037FB1A4
	add r1,r6,#0x0	; 037FB1A6
	add r2,r7,#0x0	; 037FB1A8
	bl loc_037FB094	; 037FB1AA
	add r0,r5,#0x0	; 037FB1AE
	ldr r1,[sp,#0x0]	; 037FB1B0
	bl loc_037FB114	; 037FB1B2
	add r4,r4,#0x1	; 037FB1B6
	add r5,r5,#0x1	; 037FB1B8
	cmp r5,#0x69	; 037FB1BA
	bcc loc_037FB1A4	; 037FB1BC
	add sp,#0x4	; 037FB1BE
	pop {r4,r5,r6,r7}	; 037FB1C0
	pop {r3}	; 037FB1C2
	bx r3	; 037FB1C4
	.byte 0xC0, 0x46	; 037FB1C8
pool_037FB1C8:
loc_037FB1C8:
	.word 0x00000100	; 037FB1C8
pool_037FB1CC:
loc_037FB1CC:
	.word REG_WIFI_BB_MODE	; 037FB1CC

; ===== function loc_037FB1D0 =====
loc_037FB1D0:
	push {r4,lr}	; 037FB1D0
	sub sp,#0x8	; 037FB1D2
	add r4,r0,#0x0	; 037FB1D4
	mov r1,#0x0	; 037FB1D6
	add r0,sp,#0x0	; 037FB1D8
	strh r1,[r0,#0x0]	; 037FB1DA
	ldrh r0,[r0,#0x0]	; 037FB1DC
	add r1,r4,#0x0	; 037FB1DE
	mov r2,#0x8	; 037FB1E0
	bl loc_037FB218	; 037FB1E2
	mov r0,#0x40	; 037FB1E6
	mov r1,#0x1	; 037FB1E8
	add r2,r4,#0x0	; 037FB1EA
	bl loc_037FB094	; 037FB1EC
	mov r0,#0x41	; 037FB1F0
	mov r1,#0x1	; 037FB1F2
	add r2,r4,#0x2	; 037FB1F4
	bl loc_037FB094	; 037FB1F6
	mov r0,#0x42	; 037FB1FA
	mov r1,#0x1	; 037FB1FC
	add r2,r4,#0x4	; 037FB1FE
	bl loc_037FB094	; 037FB200
	mov r0,#0x43	; 037FB204
	mov r1,#0x1	; 037FB206
	add r2,r4,#0x6	; 037FB208
	bl loc_037FB094	; 037FB20A
	add sp,#0x8	; 037FB20E
	pop {r4}	; 037FB210
	pop {r3}	; 037FB212
	bx r3	; 037FB214
	.byte 0xC0, 0x46	; 037FB218

; ===== function loc_037FB218 =====
loc_037FB218:
	bx pc	; 037FB218
	.byte 0xC0, 0x46	; 037FB21C
.arm

; ===== function loc_037FB21C =====
loc_037FB21C:
	ldr pc,[pool_037FB220]	; 037FB21C
pool_037FB220:
loc_037FB220:
	.word loc_037FF324	; 037FB220
.thumb

; ===== function loc_037FB224 =====
loc_037FB224:
	push {r4,r5,lr}	; 037FB224
	sub sp,#0x4	; 037FB226
	mov r2,#0xf	; 037FB228
	add r3,r1,#0x0	; 037FB22A
	and r3,r2	; 037FB22C
	lsl r3,r3,#0x1	; 037FB22E
	ldr r4,[pool_037FB274]	; 037FB230
	ldrh r3,[r4,r3]	; 037FB232
	asr r1,r1,#0x4	; 037FB234
	ldr r5,[pool_037FB278]	; 037FB236
	and r1,r5	; 037FB238
	lsl r1,r1,#0x10	; 037FB23A
	lsr r1,r1,#0x10	; 037FB23C
	eor r1,r3	; 037FB23E
	add r3,r0,#0x0	; 037FB240
	and r3,r2	; 037FB242
	lsl r3,r3,#0x1	; 037FB244
	ldrh r3,[r4,r3]	; 037FB246
	eor r1,r3	; 037FB248
	lsl r1,r1,#0x10	; 037FB24A
	lsr r3,r1,#0x10	; 037FB24C
	asr r1,r3,#0x4	; 037FB24E
	and r1,r5	; 037FB250
	lsl r1,r1,#0x10	; 037FB252
	lsr r1,r1,#0x10	; 037FB254
	and r3,r2	; 037FB256
	lsl r3,r3,#0x1	; 037FB258
	ldrh r3,[r4,r3]	; 037FB25A
	eor r1,r3	; 037FB25C
	asr r0,r0,#0x4	; 037FB25E
	and r0,r2	; 037FB260
	lsl r0,r0,#0x1	; 037FB262
	ldrh r0,[r4,r0]	; 037FB264
	eor r1,r0	; 037FB266
	lsl r0,r1,#0x10	; 037FB268
	lsr r0,r0,#0x10	; 037FB26A
	add sp,#0x4	; 037FB26C
	pop {r4,r5}	; 037FB26E
	pop {r3}	; 037FB270
	bx r3	; 037FB272
pool_037FB274:
loc_037FB274:
	.word P2_Data_038050E4	; 037FB274
pool_037FB278:
loc_037FB278:
	.word 0x00000FFF	; 037FB278

; ===== function loc_037FB27C =====
loc_037FB27C:
	push {r4,r5,r6,r7,lr}	; 037FB27C
	sub sp,#0xc	; 037FB27E
	mov r5,#0x2a	; 037FB280
	add r0,r5,#0x0	; 037FB282
	mov r1,#0x2	; 037FB284
	add r2,sp,#0x0	; 037FB286
	add r2,#0x2	; 037FB288
	bl loc_037FB094	; 037FB28A
	add r5,r5,#0x2	; 037FB28E
	add r0,r5,#0x0	; 037FB290
	mov r1,#0x2	; 037FB292
	add r2,sp,#0x4	; 037FB294
	bl loc_037FB094	; 037FB296
	add r7,sp,#0x0	; 037FB29A
	ldrh r1,[r7,#0x4]	; 037FB29C
	ldr r0,[pool_037FB2E0]	; 037FB29E
	cmp r1,r0	; 037FB2A0
	bcs loc_037FB2D6	; 037FB2A2
	mov r6,#0x0	; 037FB2A4
	add r4,r6,#0x0	; 037FB2A6
	b loc_037FB2C2	; 037FB2A8
loc_037FB2AA:
	add r0,r5,#0x0	; 037FB2AA
	mov r1,#0x1	; 037FB2AC
	add r2,sp,#0x0	; 037FB2AE
	bl loc_037FB094	; 037FB2B0
	add r5,r5,#0x1	; 037FB2B4
	ldrb r0,[r7,#0x0]	; 037FB2B6
	add r1,r6,#0x0	; 037FB2B8
	bl loc_037FB224	; 037FB2BA
	add r6,r0,#0x0	; 037FB2BE
	add r4,r4,#0x1	; 037FB2C0
loc_037FB2C2:
	ldrh r0,[r7,#0x4]	; 037FB2C2
	cmp r4,r0	; 037FB2C4
	bcc loc_037FB2AA	; 037FB2C6
	ldrh r0,[r7,#0x2]	; 037FB2C8
	cmp r6,r0	; 037FB2CA
	bne loc_037FB2D2	; 037FB2CC
	mov r0,#0x1	; 037FB2CE
	b loc_037FB2D8	; 037FB2D0
loc_037FB2D2:
	mov r0,#0x0	; 037FB2D2
	b loc_037FB2D8	; 037FB2D4
loc_037FB2D6:
	mov r0,#0x0	; 037FB2D6
loc_037FB2D8:
	add sp,#0xc	; 037FB2D8
	pop {r4,r5,r6,r7}	; 037FB2DA
	pop {r3}	; 037FB2DC
	bx r3	; 037FB2DE
pool_037FB2E0:
loc_037FB2E0:
	.word 0x000001D6	; 037FB2E0

; ===== function loc_037FB2E4 =====
loc_037FB2E4:
	push {lr}	; 037FB2E4
	sub sp,#0x4	; 037FB2E6
	cmp r0,#0x2	; 037FB2E8
	beq loc_037FB2F0	; 037FB2EA
	cmp r0,#0x3	; 037FB2EC
	b loc_037FB2F6	; 037FB2EE
loc_037FB2F0:
	ldr r0,[pool_037FB31C]	; 037FB2F0
	bl loc_037FB0D0	; 037FB2F2
loc_037FB2F6:
	mov r0,#0x1e	; 037FB2F6
	bl loc_037FB148	; 037FB2F8
	mov r2,#0x3f	; 037FB2FC
	add r1,r0,#0x0	; 037FB2FE
	orr r1,r2	; 037FB300
	mov r0,#0x1e	; 037FB302
	bl loc_037FB114	; 037FB304
	ldr r1,[pool_037FB320]	; 037FB308
	ldr r0,[pool_037FB324]	; 037FB30A
	strh r1,[r0,#0x0]	; 037FB30C
	mov r1,#0x1	; 037FB30E
	ldr r0,[pool_037FB328]	; 037FB310
	strh r1,[r0,#0x0]	; 037FB312
	add sp,#0x4	; 037FB314
	pop {r3}	; 037FB316
	bx r3	; 037FB318
	.byte 0xC0, 0x46	; 037FB31C
pool_037FB31C:
loc_037FB31C:
	.word 0x0000C008	; 037FB31C
pool_037FB320:
loc_037FB320:
	.word 0x0000800D	; 037FB320
pool_037FB324:
loc_037FB324:
	.word REG_WIFI_BB_POWER	; 037FB324
pool_037FB328:
loc_037FB328:
	.word REG_WIFI_POWER_US	; 037FB328

; ===== function loc_037FB32C =====
loc_037FB32C:
	push {lr}	; 037FB32C
	sub sp,#0x4	; 037FB32E
	mov r1,#0x0	; 037FB330
	ldr r0,[pool_037FB348]	; 037FB332
	strh r1,[r0,#0x0]	; 037FB334
	ldr r0,[pool_037FB34C]	; 037FB336
	bl loc_037FF1D0	; 037FB338
	mov r1,#0x0	; 037FB33C
	ldr r0,[pool_037FB350]	; 037FB33E
	strh r1,[r0,#0x0]	; 037FB340
	add sp,#0x4	; 037FB342
	pop {r3}	; 037FB344
	bx r3	; 037FB346
pool_037FB348:
loc_037FB348:
	.word REG_WIFI_POWER_US	; 037FB348
pool_037FB34C:
loc_037FB34C:
	.word 0x00051D23	; 037FB34C
pool_037FB350:
loc_037FB350:
	.word REG_WIFI_BB_POWER	; 037FB350

; ===== function loc_037FB354 =====
P2_ThreadEntry_037FB354:
	push {r4,r5,r6,r7,lr}	; 037FB354
	sub sp,#0x4	; 037FB356
	ldr r6,[pool_037FB3BC]	; 037FB358
	ldr r5,[r6,#0x0]	; 037FB35A
	mov r0,#0x0	; 037FB35C
	strh r0,[r5,#0x10]	; 037FB35E
	strh r0,[r5,#0x14]	; 037FB360
	ldr r4,[pool_037FB3C0]	; 037FB362
	ldr r7,[pool_037FB3C4]	; 037FB364
loc_037FB366:
	ldr r0,[r6,#0x0]	; 037FB366
	ldr r0,[r0,r7]	; 037FB368
	add r1,sp,#0x0	; 037FB36A
	mov r2,#0x0	; 037FB36C
	bl loc_037FE290	; 037FB36E
	cmp r0,#0x0	; 037FB372
	beq loc_037FB37C	; 037FB374
	add r0,sp,#0x0	; 037FB376
	bl loc_037FB4DC	; 037FB378
loc_037FB37C:
	ldr r0,[pool_037FB3C8]	; 037FB37C
	bl loc_037FDA6C	; 037FB37E
	ldrh r1,[r5,#0x10]	; 037FB382
	strh r1,[r5,#0x12]	; 037FB384
	ldrh r1,[r5,#0x12]	; 037FB386
	lsl r1,r1,#0x1	; 037FB388
	ldrh r1,[r5,r1]	; 037FB38A
	cmp r1,r4	; 037FB38C
	bne loc_037FB39C	; 037FB38E
	ldrh r1,[r5,#0x10]	; 037FB390
	add r1,r1,#0x1	; 037FB392
	strh r1,[r5,#0x10]	; 037FB394
	bl loc_037FDA98	; 037FB396
	b loc_037FB366	; 037FB39A
loc_037FB39C:
	bl loc_037FDA98	; 037FB39C
	ldrh r0,[r5,#0x12]	; 037FB3A0
	bl loc_037FB458	; 037FB3A2
	strh r0,[r5,#0x14]	; 037FB3A6
	ldrh r0,[r5,#0x14]	; 037FB3A8
	lsl r0,r0,#0x3	; 037FB3AA
	add r0,r5,r0	; 037FB3AC
	add r0,#0x94	; 037FB3AE
	ldr r0,[r0,#0x0]	; 037FB3B0
	bl loc_0380508C	; 037FB3B2
	strh r4,[r5,#0x14]	; 037FB3B6
	b loc_037FB366	; 037FB3B8
	.byte 0xC0, 0x46	; 037FB3BC
pool_037FB3BC:
loc_037FB3BC:
	.word FirmwareWlWorkPointerSlot	; 037FB3BC
pool_037FB3C0:
loc_037FB3C0:
	.word 0x0000FFFF	; 037FB3C0
pool_037FB3C4:
loc_037FB3C4:
	.word 0x000002DC	; 037FB3C4
pool_037FB3C8:
loc_037FB3C8:
	.word 0x01000010	; 037FB3C8

; ===== function loc_037FB3CC =====
loc_037FB3CC:
	push {r4,r5,r6,r7,lr}	; 037FB3CC
	sub sp,#0x4	; 037FB3CE
	add r5,r0,#0x0	; 037FB3D0
	add r6,r1,#0x0	; 037FB3D2
	ldr r0,[pool_037FB448]	; 037FB3D4
	ldr r4,[r0,#0x0]	; 037FB3D6
	add r7,r4,#0x0	; 037FB3D8
	add r7,#0x90	; 037FB3DA
	ldr r0,[pool_037FB44C]	; 037FB3DC
	bl loc_037FDA6C	; 037FB3DE
	str r0,[sp,#0x0]	; 037FB3E2
	lsl r1,r6,#0x3	; 037FB3E4
	add r2,r7,#0x2	; 037FB3E6
	add r0,r2,r1	; 037FB3E8
	ldrh r2,[r2,r1]	; 037FB3EA
	cmp r2,#0x0	; 037FB3EC
	bne loc_037FB41E	; 037FB3EE
	mov r2,#0x1	; 037FB3F0
	strh r2,[r0,#0x0]	; 037FB3F2
	ldr r0,[pool_037FB450]	; 037FB3F4
	strh r0,[r7,r1]	; 037FB3F6
	lsl r0,r5,#0x1	; 037FB3F8
	add r2,r4,#0x0	; 037FB3FA
	add r2,#0x8	; 037FB3FC
	add r1,r2,r0	; 037FB3FE
	ldrh r3,[r2,r0]	; 037FB400
	ldr r2,[pool_037FB450]	; 037FB402
	cmp r3,r2	; 037FB404
	bne loc_037FB40C	; 037FB406
	strh r6,[r4,r0]	; 037FB408
	b loc_037FB414	; 037FB40A
loc_037FB40C:
	lsl r0,r3,#0x3	; 037FB40C
	add r0,r4,r0	; 037FB40E
	add r0,#0x90	; 037FB410
	strh r6,[r0,#0x0]	; 037FB412
loc_037FB414:
	strh r6,[r1,#0x0]	; 037FB414
	ldrh r0,[r4,#0x10]	; 037FB416
	cmp r5,r0	; 037FB418
	bge loc_037FB41E	; 037FB41A
	strh r5,[r4,#0x10]	; 037FB41C
loc_037FB41E:
	ldr r0,[sp,#0x0]	; 037FB41E
	bl loc_037FDA98	; 037FB420
	cmp r5,#0x3	; 037FB424
	beq loc_037FB43E	; 037FB426
	ldrh r0,[r4,#0x12]	; 037FB428
	cmp r0,#0x3	; 037FB42A
	bne loc_037FB43E	; 037FB42C
	ldr r0,[pool_037FB448]	; 037FB42E
	ldr r1,[r0,#0x0]	; 037FB430
	ldr r0,[pool_037FB454]	; 037FB432
	ldr r0,[r1,r0]	; 037FB434
	mov r1,#0x0	; 037FB436
	add r2,r1,#0x0	; 037FB438
	bl loc_037FE308	; 037FB43A
loc_037FB43E:
	add sp,#0x4	; 037FB43E
	pop {r4,r5,r6,r7}	; 037FB440
	pop {r3}	; 037FB442
	bx r3	; 037FB444
	.byte 0xC0, 0x46	; 037FB448
pool_037FB448:
loc_037FB448:
	.word FirmwareWlWorkPointerSlot	; 037FB448
pool_037FB44C:
loc_037FB44C:
	.word 0x01000010	; 037FB44C
pool_037FB450:
loc_037FB450:
	.word 0x0000FFFF	; 037FB450
pool_037FB454:
loc_037FB454:
	.word 0x000002DC	; 037FB454

; ===== function loc_037FB458 =====
loc_037FB458:
	push {r4,r5,r6,r7,lr}	; 037FB458
	sub sp,#0x4	; 037FB45A
	add r4,r0,#0x0	; 037FB45C
	ldr r0,[pool_037FB4A0]	; 037FB45E
	ldr r5,[r0,#0x0]	; 037FB460
	ldr r0,[pool_037FB4A4]	; 037FB462
	bl loc_037FDA6C	; 037FB464
	add r7,r0,#0x0	; 037FB468
	lsl r0,r4,#0x1	; 037FB46A
	add r6,r5,r0	; 037FB46C
	ldrh r4,[r5,r0]	; 037FB46E
	ldr r0,[pool_037FB4A8]	; 037FB470
	cmp r4,r0	; 037FB472
	beq loc_037FB490	; 037FB474
	add r5,#0x90	; 037FB476
	lsl r3,r4,#0x3	; 037FB478
	mov r2,#0x0	; 037FB47A
	add r1,r5,r3	; 037FB47C
	strh r2,[r1,#0x2]	; 037FB47E
	ldrh r1,[r5,r3]	; 037FB480
	cmp r1,r0	; 037FB482
	bne loc_037FB48C	; 037FB484
	strh r0,[r6,#0x0]	; 037FB486
	strh r0,[r6,#0x8]	; 037FB488
	b loc_037FB490	; 037FB48A
loc_037FB48C:
	strh r1,[r6,#0x0]	; 037FB48C
	strh r0,[r5,r3]	; 037FB48E
loc_037FB490:
	add r0,r7,#0x0	; 037FB490
	bl loc_037FDA98	; 037FB492
	add r0,r4,#0x0	; 037FB496
	add sp,#0x4	; 037FB498
	pop {r4,r5,r6,r7}	; 037FB49A
	pop {r3}	; 037FB49C
	bx r3	; 037FB49E
pool_037FB4A0:
loc_037FB4A0:
	.word FirmwareWlWorkPointerSlot	; 037FB4A0
pool_037FB4A4:
loc_037FB4A4:
	.word 0x01000010	; 037FB4A4
pool_037FB4A8:
loc_037FB4A8:
	.word 0x0000FFFF	; 037FB4A8
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x58, 0x00, 0xA9, 0x01, 0x22	; 037FB4BC
	.byte 0x02, 0xF0, 0xE8, 0xFE, 0x00, 0xA8, 0x00, 0xF0, 0x0B, 0xF8, 0x03, 0x20, 0x0C, 0x21, 0xFF, 0xF7	; 037FB4CC
	.byte 0x7F, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xDC, 0x02, 0x00, 0x00	; 037FB4DC

; ===== function loc_037FB4DC =====
loc_037FB4DC:
	push {lr}	; 037FB4DC
	sub sp,#0x4	; 037FB4DE
	ldr r1,[r0,#0x0]	; 037FB4E0
	cmp r1,#0x0	; 037FB4E2
	beq loc_037FB4FA	; 037FB4E4
	ldr r0,[pool_037FB500]	; 037FB4E6
	ldr r2,[r0,#0x0]	; 037FB4E8
	ldr r0,[pool_037FB504]	; 037FB4EA
	add r0,r2,r0	; 037FB4EC
	bl loc_037FB508	; 037FB4EE
	mov r0,#0x2	; 037FB4F2
	mov r1,#0xb	; 037FB4F4
	bl loc_037FB3CC	; 037FB4F6
loc_037FB4FA:
	add sp,#0x4	; 037FB4FA
	pop {r3}	; 037FB4FC
	bx r3	; 037FB4FE
pool_037FB500:
loc_037FB500:
	.word FirmwareWlWorkPointerSlot	; 037FB500
pool_037FB504:
loc_037FB504:
	.word 0x000001D4	; 037FB504

; ===== function loc_037FB508 =====
loc_037FB508:
	push {r4,r5,lr}	; 037FB508
	sub sp,#0x4	; 037FB50A
	add r5,r0,#0x0	; 037FB50C
	add r4,r1,#0x0	; 037FB50E
	ldr r0,[pool_037FB550]	; 037FB510
	bl loc_037FDA6C	; 037FB512
	ldrh r1,[r5,#0x8]	; 037FB516
	cmp r1,#0x0	; 037FB518
	bne loc_037FB526	; 037FB51A
	mov r1,#0x0	; 037FB51C
	mvn r1,r1	; 037FB51E
	str r1,[r4,#0x0]	; 037FB520
	str r4,[r5,#0x0]	; 037FB522
	b loc_037FB52C	; 037FB524
loc_037FB526:
	ldr r1,[r5,#0x4]	; 037FB526
	str r1,[r4,#0x0]	; 037FB528
	str r4,[r1,#0x4]	; 037FB52A
loc_037FB52C:
	mov r1,#0x0	; 037FB52C
	mvn r1,r1	; 037FB52E
	str r1,[r4,#0x4]	; 037FB530
	ldrh r1,[r5,#0xa]	; 037FB532
	strh r1,[r4,#0x8]	; 037FB534
	ldr r1,[pool_037FB554]	; 037FB536
	strh r1,[r4,#0xa]	; 037FB538
	str r4,[r5,#0x4]	; 037FB53A
	ldrh r1,[r5,#0x8]	; 037FB53C
	add r1,r1,#0x1	; 037FB53E
	strh r1,[r5,#0x8]	; 037FB540
	bl loc_037FDA98	; 037FB542
	mov r0,#0x0	; 037FB546
	add sp,#0x4	; 037FB548
	pop {r4,r5}	; 037FB54A
	pop {r3}	; 037FB54C
	bx r3	; 037FB54E
pool_037FB550:
loc_037FB550:
	.word 0x01000000	; 037FB550
pool_037FB554:
loc_037FB554:
	.word 0x0000BF1D	; 037FB554

; ===== function loc_037FB558 =====
loc_037FB558:
	push {r4,r5,lr}	; 037FB558
	sub sp,#0x4	; 037FB55A
	add r5,r0,#0x0	; 037FB55C
	add r4,r1,#0x0	; 037FB55E
	ldrh r1,[r4,#0xa]	; 037FB560
	ldr r0,[pool_037FB5DC]	; 037FB562
	cmp r1,r0	; 037FB564
	beq loc_037FB56C	; 037FB566
	mov r0,#0x1	; 037FB568
	b loc_037FB5D2	; 037FB56A
loc_037FB56C:
	ldrh r1,[r4,#0x8]	; 037FB56C
	ldrh r0,[r5,#0xa]	; 037FB56E
	cmp r1,r0	; 037FB570
	beq loc_037FB578	; 037FB572
	mov r0,#0x2	; 037FB574
	b loc_037FB5D2	; 037FB576
loc_037FB578:
	ldr r0,[pool_037FB5E0]	; 037FB578
	bl loc_037FDA6C	; 037FB57A
	ldrh r1,[r5,#0x8]	; 037FB57E
	sub r1,r1,#0x1	; 037FB580
	strh r1,[r5,#0x8]	; 037FB582
	ldrh r1,[r5,#0x8]	; 037FB584
	cmp r1,#0x0	; 037FB586
	bne loc_037FB594	; 037FB588
	mov r1,#0x0	; 037FB58A
	mvn r1,r1	; 037FB58C
	str r1,[r5,#0x0]	; 037FB58E
	str r1,[r5,#0x4]	; 037FB590
	b loc_037FB5C8	; 037FB592
loc_037FB594:
	ldr r1,[r5,#0x0]	; 037FB594
	cmp r4,r1	; 037FB596
	bne loc_037FB5A8	; 037FB598
	ldr r1,[r4,#0x4]	; 037FB59A
	str r1,[r5,#0x0]	; 037FB59C
	mov r1,#0x0	; 037FB59E
	mvn r2,r1	; 037FB5A0
	ldr r1,[r5,#0x0]	; 037FB5A2
	str r2,[r1,#0x0]	; 037FB5A4
	b loc_037FB5C8	; 037FB5A6
loc_037FB5A8:
	ldr r1,[r5,#0x4]	; 037FB5A8
	cmp r4,r1	; 037FB5AA
	bne loc_037FB5BC	; 037FB5AC
	ldr r1,[r4,#0x0]	; 037FB5AE
	str r1,[r5,#0x4]	; 037FB5B0
	mov r1,#0x0	; 037FB5B2
	mvn r2,r1	; 037FB5B4
	ldr r1,[r5,#0x4]	; 037FB5B6
	str r2,[r1,#0x4]	; 037FB5B8
	b loc_037FB5C8	; 037FB5BA
loc_037FB5BC:
	ldr r2,[r4,#0x0]	; 037FB5BC
	ldr r1,[r4,#0x4]	; 037FB5BE
	str r2,[r1,#0x0]	; 037FB5C0
	ldr r2,[r4,#0x4]	; 037FB5C2
	ldr r1,[r4,#0x0]	; 037FB5C4
	str r2,[r1,#0x4]	; 037FB5C6
loc_037FB5C8:
	mov r1,#0x0	; 037FB5C8
	strh r1,[r4,#0x8]	; 037FB5CA
	bl loc_037FDA98	; 037FB5CC
	mov r0,#0x0	; 037FB5D0
loc_037FB5D2:
	add sp,#0x4	; 037FB5D2
	pop {r4,r5}	; 037FB5D4
	pop {r3}	; 037FB5D6
	bx r3	; 037FB5D8
	.byte 0xC0, 0x46	; 037FB5DC
pool_037FB5DC:
loc_037FB5DC:
	.word 0x0000BF1D	; 037FB5DC
pool_037FB5E0:
loc_037FB5E0:
	.word 0x01000000	; 037FB5E0

; ===== function loc_037FB5E4 =====
P2_Entry_037FB5E4:
	push {r4,r5,lr}	; 037FB5E4
	sub sp,#0x4	; 037FB5E6
	add r5,r0,#0x0	; 037FB5E8
	ldr r0,[pool_037FB644]	; 037FB5EA
	ldr r2,[r0,#0x0]	; 037FB5EC
	ldr r0,[pool_037FB648]	; 037FB5EE
	add r3,r2,r0	; 037FB5F0
	cmp r1,#0x0	; 037FB5F2
	bne loc_037FB5FA	; 037FB5F4
	mov r0,#0x0	; 037FB5F6
	b loc_037FB63A	; 037FB5F8
loc_037FB5FA:
	add r2,r1,#0x0	; 037FB5FA
	add r2,#0xc	; 037FB5FC
	ldr r0,[r3,#0x0]	; 037FB5FE
	cmp r0,#0x0	; 037FB600
	beq loc_037FB60A	; 037FB602
	cmp r0,#0x1	; 037FB604
	beq loc_037FB616	; 037FB606
	b loc_037FB620	; 037FB608
loc_037FB60A:
	ldr r0,[r3,#0x4]	; 037FB60A
	ldr r1,[r3,#0x8]	; 037FB60C
	bl loc_037FE724	; 037FB60E
	add r4,r0,#0x0	; 037FB612
	b loc_037FB620	; 037FB614
loc_037FB616:
	add r0,r2,#0x0	; 037FB616
	ldr r1,[r3,#0x4]	; 037FB618
	bl loc_03805090	; 037FB61A
	add r4,r0,#0x0	; 037FB61E
loc_037FB620:
	cmp r4,#0x0	; 037FB620
	beq loc_037FB638	; 037FB622
	ldr r0,[pool_037FB64C]	; 037FB624
	strh r0,[r4,#0xa]	; 037FB626
	mov r0,#0x0	; 037FB628
	strh r0,[r4,#0x8]	; 037FB62A
	add r0,r5,#0x0	; 037FB62C
	add r1,r4,#0x0	; 037FB62E
	bl loc_037FB6F8	; 037FB630
	add r0,r4,#0x0	; 037FB634
	b loc_037FB63A	; 037FB636
loc_037FB638:
	mov r0,#0x0	; 037FB638
loc_037FB63A:
	add sp,#0x4	; 037FB63A
	pop {r4,r5}	; 037FB63C
	pop {r3}	; 037FB63E
	bx r3	; 037FB640
	.byte 0xC0, 0x46	; 037FB644
pool_037FB644:
loc_037FB644:
	.word FirmwareWlWorkPointerSlot	; 037FB644
pool_037FB648:
loc_037FB648:
	.word 0x00000150	; 037FB648
pool_037FB64C:
loc_037FB64C:
	.word 0x0000BF1D	; 037FB64C
P2_Entry_037FB650:
	push {r4,r5,r6,lr}	; 037FB650
	add r5,r1,#0x0	; 037FB652
	ldr r2,[pool_037FB69C]	; 037FB654
	ldr r3,[r2,#0x0]	; 037FB656
	ldr r2,[pool_037FB6A0]	; 037FB658
	add r4,r3,r2	; 037FB65A
	ldrh r3,[r5,#0xa]	; 037FB65C
	ldr r2,[pool_037FB6A4]	; 037FB65E
	cmp r3,r2	; 037FB660
	beq P2_Entry_037FB668	; 037FB662
	mov r0,#0x1	; 037FB664
	b P2_Entry_037FB694	; 037FB666
P2_Entry_037FB668:
	bl loc_037FB558	; 037FB668
	add r6,r0,#0x0	; 037FB66C
	cmp r6,#0x0	; 037FB66E
	bne P2_Entry_037FB692	; 037FB670
	ldr r0,[r4,#0x0]	; 037FB672
	cmp r0,#0x0	; 037FB674
	beq P2_Entry_037FB67E	; 037FB676
	cmp r0,#0x1	; 037FB678
	beq P2_Entry_037FB68A	; 037FB67A
	b P2_Entry_037FB692	; 037FB67C
P2_Entry_037FB67E:
	ldr r0,[r4,#0x4]	; 037FB67E
	ldr r1,[r4,#0x8]	; 037FB680
	add r2,r5,#0x0	; 037FB682
	bl P2_Entry_037FE6D8	; 037FB684
	b P2_Entry_037FB692	; 037FB688
P2_Entry_037FB68A:
	add r0,r5,#0x0	; 037FB68A
	ldr r1,[r4,#0x8]	; 037FB68C
	bl loc_03805090	; 037FB68E
P2_Entry_037FB692:
	add r0,r6,#0x0	; 037FB692
P2_Entry_037FB694:
	pop {r4,r5,r6}	; 037FB694
	pop {r3}	; 037FB696
	bx r3	; 037FB698
	.byte 0xC0, 0x46	; 037FB69A
pool_037FB69C:
	.word FirmwareWlWorkPointerSlot	; 037FB69C
pool_037FB6A0:
	.word 0x00000150	; 037FB6A0
pool_037FB6A4:
	.word 0x0000BF1D	; 037FB6A4

; ===== function loc_037FB6A8 =====
loc_037FB6A8:
	push {r4,r5,r6,r7,lr}	; 037FB6A8
	sub sp,#0x4	; 037FB6AA
	add r4,r0,#0x0	; 037FB6AC
	add r6,r1,#0x0	; 037FB6AE
	add r5,r2,#0x0	; 037FB6B0
	ldrh r1,[r5,#0xa]	; 037FB6B2
	ldr r0,[pool_037FB6F0]	; 037FB6B4
	cmp r1,r0	; 037FB6B6
	beq loc_037FB6BE	; 037FB6B8
	mov r0,#0x1	; 037FB6BA
	b loc_037FB6E6	; 037FB6BC
loc_037FB6BE:
	ldr r0,[pool_037FB6F4]	; 037FB6BE
	bl loc_037FDA6C	; 037FB6C0
	add r7,r0,#0x0	; 037FB6C4
	add r0,r4,#0x0	; 037FB6C6
	add r1,r5,#0x0	; 037FB6C8
	bl loc_037FB558	; 037FB6CA
	add r4,r0,#0x0	; 037FB6CE
	cmp r4,#0x0	; 037FB6D0
	bne loc_037FB6DE	; 037FB6D2
	add r0,r6,#0x0	; 037FB6D4
	add r1,r5,#0x0	; 037FB6D6
	bl loc_037FB6F8	; 037FB6D8
	add r4,r0,#0x0	; 037FB6DC
loc_037FB6DE:
	add r0,r7,#0x0	; 037FB6DE
	bl loc_037FDA98	; 037FB6E0
	add r0,r4,#0x0	; 037FB6E4
loc_037FB6E6:
	add sp,#0x4	; 037FB6E6
	pop {r4,r5,r6,r7}	; 037FB6E8
	pop {r3}	; 037FB6EA
	bx r3	; 037FB6EC
	.byte 0xC0, 0x46	; 037FB6F0
pool_037FB6F0:
loc_037FB6F0:
	.word 0x0000BF1D	; 037FB6F0
pool_037FB6F4:
loc_037FB6F4:
	.word 0x01000000	; 037FB6F4

; ===== function loc_037FB6F8 =====
loc_037FB6F8:
	push {r4,r5,lr}	; 037FB6F8
	sub sp,#0x4	; 037FB6FA
	add r5,r0,#0x0	; 037FB6FC
	add r4,r1,#0x0	; 037FB6FE
	ldrh r1,[r4,#0xa]	; 037FB700
	ldr r0,[pool_037FB754]	; 037FB702
	cmp r1,r0	; 037FB704
	beq loc_037FB70C	; 037FB706
	mov r0,#0x1	; 037FB708
	b loc_037FB74A	; 037FB70A
loc_037FB70C:
	ldrh r0,[r4,#0x8]	; 037FB70C
	cmp r0,#0x0	; 037FB70E
	beq loc_037FB716	; 037FB710
	mov r0,#0x2	; 037FB712
	b loc_037FB74A	; 037FB714
loc_037FB716:
	ldr r0,[pool_037FB758]	; 037FB716
	bl loc_037FDA6C	; 037FB718
	ldrh r1,[r5,#0x8]	; 037FB71C
	cmp r1,#0x0	; 037FB71E
	bne loc_037FB72C	; 037FB720
	mov r1,#0x0	; 037FB722
	mvn r1,r1	; 037FB724
	str r1,[r4,#0x0]	; 037FB726
	str r4,[r5,#0x0]	; 037FB728
	b loc_037FB732	; 037FB72A
loc_037FB72C:
	ldr r1,[r5,#0x4]	; 037FB72C
	str r1,[r4,#0x0]	; 037FB72E
	str r4,[r1,#0x4]	; 037FB730
loc_037FB732:
	mov r1,#0x0	; 037FB732
	mvn r1,r1	; 037FB734
	str r1,[r4,#0x4]	; 037FB736
	ldrh r1,[r5,#0xa]	; 037FB738
	strh r1,[r4,#0x8]	; 037FB73A
	str r4,[r5,#0x4]	; 037FB73C
	ldrh r1,[r5,#0x8]	; 037FB73E
	add r1,r1,#0x1	; 037FB740
	strh r1,[r5,#0x8]	; 037FB742
	bl loc_037FDA98	; 037FB744
	mov r0,#0x0	; 037FB748
loc_037FB74A:
	add sp,#0x4	; 037FB74A
	pop {r4,r5}	; 037FB74C
	pop {r3}	; 037FB74E
	bx r3	; 037FB750
	.byte 0xC0, 0x46	; 037FB754
pool_037FB754:
loc_037FB754:
	.word 0x0000BF1D	; 037FB754
pool_037FB758:
loc_037FB758:
	.word 0x01000000	; 037FB758
P2_Entry_037FB75C:
	ldr r0,[r0,#0x4]	; 037FB75C
	bx lr	; 037FB75E

; ===== function loc_037FB760 =====
	push {r4,r5,r6,r7,lr}	; 037FB760
	sub sp,#0xc	; 037FB762
	ldr r2,[pool_037FB928]	; 037FB764
	ldr r0,[r2,#0x0]	; 037FB766
	ldr r1,[pool_037FB92C]	; 037FB768
	add r5,r0,r1	; 037FB76A
	mov r1,#0x0	; 037FB76C
	add r7,r1,#0x0	; 037FB76E
	ldrh r3,[r5,#0x4]	; 037FB770
	cmp r3,#0x0	; 037FB772
	beq loc_037FB778	; 037FB774
	b loc_037FB920	; 037FB776
loc_037FB778:
	ldr r3,[pool_037FB930]	; 037FB778
	ldr r0,[r0,r3]	; 037FB77A
	str r0,[r5,#0x0]	; 037FB77C
	ldr r0,[r5,#0x0]	; 037FB77E
	str r0,[sp,#0x0]	; 037FB780
	mvn r3,r1	; 037FB782
	cmp r0,r3	; 037FB784
	bne loc_037FB78A	; 037FB786
	b loc_037FB920	; 037FB788
loc_037FB78A:
	ldrh r0,[r0,#0xe]	; 037FB78A
	lsl r3,r0,#0x1	; 037FB78C
	ldr r0,[sp,#0x0]	; 037FB78E
	add r4,r0,r3	; 037FB790
	add r4,#0x10	; 037FB792
	ldr r0,[r2,#0x0]	; 037FB794
	ldr r2,[pool_037FB934]	; 037FB796
	ldrh r2,[r0,r2]	; 037FB798
	cmp r2,#0x0	; 037FB79A
	beq loc_037FB7A8	; 037FB79C
	mov r0,#0x1	; 037FB79E
	strh r0,[r4,#0x2]	; 037FB7A0
	mov r0,#0x6	; 037FB7A2
	strh r0,[r4,#0x4]	; 037FB7A4
	b loc_037FB8F8	; 037FB7A6
loc_037FB7A8:
	ldr r2,[sp,#0x0]	; 037FB7A8
	ldrh r6,[r2,#0xc]	; 037FB7AA
	ldrh r2,[r4,#0x0]	; 037FB7AC
	cmp r6,r2	; 037FB7AE
	beq loc_037FB7B8	; 037FB7B0
	mov r0,#0xd	; 037FB7B2
	strh r0,[r4,#0x4]	; 037FB7B4
	b loc_037FB8F8	; 037FB7B6
loc_037FB7B8:
	ldr r2,[pool_037FB938]	; 037FB7B8
	add r3,r6,#0x0	; 037FB7BA
	and r3,r2	; 037FB7BC
	ldr r2,[pool_037FB93C]	; 037FB7BE
	cmp r3,r2	; 037FB7C0
	bgt loc_037FB7CE	; 037FB7C2
	cmp r3,r2	; 037FB7C4
	bge loc_037FB80A	; 037FB7C6
	cmp r3,#0x0	; 037FB7C8
	beq loc_037FB7E2	; 037FB7CA
	b loc_037FB89A	; 037FB7CC
loc_037FB7CE:
	ldr r2,[pool_037FB940]	; 037FB7CE
	cmp r3,r2	; 037FB7D0
	bgt loc_037FB7DA	; 037FB7D2
	cmp r3,r2	; 037FB7D4
	beq loc_037FB826	; 037FB7D6
	b loc_037FB89A	; 037FB7D8
loc_037FB7DA:
	ldr r0,[pool_037FB944]	; 037FB7DA
	cmp r3,r0	; 037FB7DC
	beq loc_037FB888	; 037FB7DE
	b loc_037FB89A	; 037FB7E0
loc_037FB7E2:
	mov r7,#0x1	; 037FB7E2
	ldr r2,[pool_037FB948]	; 037FB7E4
	str r2,[sp,#0x4]	; 037FB7E6
	mov r2,#0xff	; 037FB7E8
	and r6,r2	; 037FB7EA
	lsl r2,r6,#0x10	; 037FB7EC
	lsr r2,r2,#0x10	; 037FB7EE
	mov r3,#0xb	; 037FB7F0
	ldrh r6,[r5,#0x4]	; 037FB7F2
	and r6,r7	; 037FB7F4
	cmp r6,#0x0	; 037FB7F6
	beq loc_037FB7FE	; 037FB7F8
	mov r1,#0x2	; 037FB7FA
	b loc_037FB89E	; 037FB7FC
loc_037FB7FE:
	ldr r6,[pool_037FB94C]	; 037FB7FE
	ldrh r0,[r0,r6]	; 037FB800
	cmp r0,#0x20	; 037FB802
	bcs loc_037FB89E	; 037FB804
	add r1,r7,#0x0	; 037FB806
	b loc_037FB89E	; 037FB808
loc_037FB80A:
	mov r7,#0x2	; 037FB80A
	ldr r2,[pool_037FB950]	; 037FB80C
	str r2,[sp,#0x4]	; 037FB80E
	mov r2,#0xff	; 037FB810
	and r6,r2	; 037FB812
	lsl r2,r6,#0x10	; 037FB814
	lsr r2,r2,#0x10	; 037FB816
	mov r3,#0x5	; 037FB818
	ldr r6,[pool_037FB94C]	; 037FB81A
	ldrh r0,[r0,r6]	; 037FB81C
	cmp r0,#0x40	; 037FB81E
	beq loc_037FB89E	; 037FB820
	mov r1,#0x1	; 037FB822
	b loc_037FB89E	; 037FB824
loc_037FB826:
	mov r2,#0xff	; 037FB826
	and r6,r2	; 037FB828
	lsl r2,r6,#0x10	; 037FB82A
	lsr r2,r2,#0x10	; 037FB82C
	cmp r2,#0x40	; 037FB82E
	bcs loc_037FB846	; 037FB830
	ldr r3,[pool_037FB94C]	; 037FB832
	ldrh r0,[r0,r3]	; 037FB834
	cmp r0,#0x10	; 037FB836
	bcs loc_037FB83C	; 037FB838
	mov r1,#0x1	; 037FB83A
loc_037FB83C:
	mov r7,#0x4	; 037FB83C
	ldr r0,[pool_037FB954]	; 037FB83E
	str r0,[sp,#0x4]	; 037FB840
	mov r3,#0x16	; 037FB842
	b loc_037FB89E	; 037FB844
loc_037FB846:
	cmp r2,#0x80	; 037FB846
	bcs loc_037FB864	; 037FB848
	ldr r3,[pool_037FB94C]	; 037FB84A
	ldrh r0,[r0,r3]	; 037FB84C
	cmp r0,#0x40	; 037FB84E
	beq loc_037FB854	; 037FB850
	mov r1,#0x1	; 037FB852
loc_037FB854:
	mov r7,#0x8	; 037FB854
	ldr r0,[pool_037FB958]	; 037FB856
	str r0,[sp,#0x4]	; 037FB858
	sub r2,#0x40	; 037FB85A
	lsl r0,r2,#0x10	; 037FB85C
	lsr r2,r0,#0x10	; 037FB85E
	mov r3,#0x6	; 037FB860
	b loc_037FB89E	; 037FB862
loc_037FB864:
	cmp r2,#0xc0	; 037FB864
	bcs loc_037FB882	; 037FB866
	ldr r3,[pool_037FB94C]	; 037FB868
	ldrh r0,[r0,r3]	; 037FB86A
	cmp r0,#0x10	; 037FB86C
	bcs loc_037FB872	; 037FB86E
	mov r1,#0x1	; 037FB870
loc_037FB872:
	mov r7,#0x10	; 037FB872
	ldr r0,[pool_037FB95C]	; 037FB874
	str r0,[sp,#0x4]	; 037FB876
	sub r2,#0x80	; 037FB878
	lsl r0,r2,#0x10	; 037FB87A
	lsr r2,r0,#0x10	; 037FB87C
	mov r3,#0x16	; 037FB87E
	b loc_037FB89E	; 037FB880
loc_037FB882:
	mov r2,#0x1	; 037FB882
	add r3,r1,#0x0	; 037FB884
	b loc_037FB89E	; 037FB886
loc_037FB888:
	mov r7,#0x40	; 037FB888
	ldr r0,[pool_037FB960]	; 037FB88A
	str r0,[sp,#0x4]	; 037FB88C
	mov r0,#0xff	; 037FB88E
	and r6,r0	; 037FB890
	lsl r0,r6,#0x10	; 037FB892
	lsr r2,r0,#0x10	; 037FB894
	mov r3,#0xa	; 037FB896
	b loc_037FB89E	; 037FB898
loc_037FB89A:
	mov r2,#0x1	; 037FB89A
	mov r3,#0x0	; 037FB89C
loc_037FB89E:
	cmp r2,r3	; 037FB89E
	bls loc_037FB8A6	; 037FB8A0
	mov r1,#0x3	; 037FB8A2
	b loc_037FB8C2	; 037FB8A4
loc_037FB8A6:
	lsl r3,r2,#0x3	; 037FB8A6
	ldr r0,[sp,#0x0]	; 037FB8A8
	ldrh r6,[r0,#0xe]	; 037FB8AA
	ldr r0,[sp,#0x4]	; 037FB8AC
	ldrh r0,[r0,r3]	; 037FB8AE
	cmp r6,r0	; 037FB8B0
	bcc loc_037FB8C0	; 037FB8B2
	ldrh r6,[r4,#0x2]	; 037FB8B4
	ldr r0,[sp,#0x4]	; 037FB8B6
	add r0,r0,r3	; 037FB8B8
	ldrh r0,[r0,#0x2]	; 037FB8BA
	cmp r6,r0	; 037FB8BC
	bcs loc_037FB8C2	; 037FB8BE
loc_037FB8C0:
	mov r1,#0x4	; 037FB8C0
loc_037FB8C2:
	cmp r1,#0x0	; 037FB8C2
	beq loc_037FB8CE	; 037FB8C4
	mov r0,#0x1	; 037FB8C6
	strh r0,[r4,#0x2]	; 037FB8C8
	strh r1,[r4,#0x4]	; 037FB8CA
	b loc_037FB8F8	; 037FB8CC
loc_037FB8CE:
	ldrh r0,[r5,#0x4]	; 037FB8CE
	orr r0,r7	; 037FB8D0
	strh r0,[r5,#0x4]	; 037FB8D2
	ldr r0,[sp,#0x0]	; 037FB8D4
	add r1,r4,#0x0	; 037FB8D6
	lsl r3,r2,#0x3	; 037FB8D8
	ldr r2,[sp,#0x4]	; 037FB8DA
	add r2,r2,r3	; 037FB8DC
	ldr r2,[r2,#0x4]	; 037FB8DE
	bl loc_03805094	; 037FB8E0
	strh r0,[r4,#0x4]	; 037FB8E4
	ldrh r0,[r4,#0x4]	; 037FB8E6
	cmp r0,#0x80	; 037FB8E8
	beq loc_037FB920	; 037FB8EA
	cmp r0,#0x81	; 037FB8EC
	bne loc_037FB8F8	; 037FB8EE
	ldrh r0,[r5,#0x4]	; 037FB8F0
	bic r0,r7	; 037FB8F2
	strh r0,[r5,#0x4]	; 037FB8F4
	b loc_037FB90C	; 037FB8F6
loc_037FB8F8:
	ldrh r0,[r5,#0x4]	; 037FB8F8
	bic r0,r7	; 037FB8FA
	strh r0,[r5,#0x4]	; 037FB8FC
	ldr r0,[pool_037FB928]	; 037FB8FE
	ldr r1,[r0,#0x0]	; 037FB900
	ldr r0,[pool_037FB930]	; 037FB902
	add r0,r1,r0	; 037FB904
	ldr r1,[r5,#0x0]	; 037FB906
	bl loc_037FB968	; 037FB908
loc_037FB90C:
	ldr r0,[pool_037FB928]	; 037FB90C
	ldr r1,[r0,#0x0]	; 037FB90E
	ldr r0,[pool_037FB964]	; 037FB910
	ldrh r0,[r1,r0]	; 037FB912
	cmp r0,#0x0	; 037FB914
	beq loc_037FB920	; 037FB916
	mov r0,#0x2	; 037FB918
	mov r1,#0xb	; 037FB91A
	bl loc_037FB3CC	; 037FB91C
loc_037FB920:
	add sp,#0xc	; 037FB920
	pop {r4,r5,r6,r7}	; 037FB922
	pop {r3}	; 037FB924
	bx r3	; 037FB926
pool_037FB928:
loc_037FB928:
	.word FirmwareWlWorkPointerSlot	; 037FB928
pool_037FB92C:
loc_037FB92C:
	.word 0x000003F8	; 037FB92C
pool_037FB930:
loc_037FB930:
	.word 0x000001D4	; 037FB930
pool_037FB934:
loc_037FB934:
	.word 0x00000312	; 037FB934
pool_037FB938:
loc_037FB938:
	.word 0x0000FF00	; 037FB938
pool_037FB93C:
loc_037FB93C:
	.word 0x00000100	; 037FB93C
pool_037FB940:
loc_037FB940:
	.word 0x00000200	; 037FB940
pool_037FB944:
loc_037FB944:
	.word 0x00000300	; 037FB944
pool_037FB948:
loc_037FB948:
	.word 0x0230D980	; 037FB948
pool_037FB94C:
loc_037FB94C:
	.word 0x00000320	; 037FB94C
pool_037FB950:
loc_037FB950:
	.word 0x0230D8D8	; 037FB950
pool_037FB954:
loc_037FB954:
	.word 0x0230DA88	; 037FB954
pool_037FB958:
loc_037FB958:
	.word 0x0230D900	; 037FB958
pool_037FB95C:
loc_037FB95C:
	.word 0x0230D9D8	; 037FB95C
pool_037FB960:
loc_037FB960:
	.word 0x0230D930	; 037FB960
pool_037FB964:
loc_037FB964:
	.word 0x000001DC	; 037FB964

; ===== function loc_037FB968 =====
loc_037FB968:
	push {r4,r5,lr}	; 037FB968
	sub sp,#0x4	; 037FB96A
	add r5,r0,#0x0	; 037FB96C
	add r4,r1,#0x0	; 037FB96E
	ldr r2,[pool_037FB9C0]	; 037FB970
	ldr r2,[r2,#0x0]	; 037FB972
	ldr r3,[pool_037FB9C4]	; 037FB974
	ldrh r3,[r2,r3]	; 037FB976
	cmp r3,#0x0	; 037FB978
	beq loc_037FB990	; 037FB97A
	ldr r1,[pool_037FB9C8]	; 037FB97C
	add r1,r2,r1	; 037FB97E
	add r2,r4,#0x0	; 037FB980
	bl loc_037FB6A8	; 037FB982
	mov r0,#0x2	; 037FB986
	mov r1,#0x13	; 037FB988
	bl loc_037FB3CC	; 037FB98A
	b loc_037FB9B8	; 037FB98E
loc_037FB990:
	ldr r0,[pool_037FB9CC]	; 037FB990
	ldr r0,[r2,r0]	; 037FB992
	mov r2,#0x0	; 037FB994
	bl loc_037FE308	; 037FB996
	cmp r0,#0x0	; 037FB99A
	beq loc_037FB9A8	; 037FB99C
	add r0,r5,#0x0	; 037FB99E
	add r1,r4,#0x0	; 037FB9A0
	bl loc_037FB558	; 037FB9A2
	b loc_037FB9B8	; 037FB9A6
loc_037FB9A8:
	add r0,r5,#0x0	; 037FB9A8
	ldr r1,[pool_037FB9C0]	; 037FB9AA
	ldr r2,[r1,#0x0]	; 037FB9AC
	ldr r1,[pool_037FB9C8]	; 037FB9AE
	add r1,r2,r1	; 037FB9B0
	add r2,r4,#0x0	; 037FB9B2
	bl loc_037FB6A8	; 037FB9B4
loc_037FB9B8:
	add sp,#0x4	; 037FB9B8
	pop {r4,r5}	; 037FB9BA
	pop {r3}	; 037FB9BC
	bx r3	; 037FB9BE
pool_037FB9C0:
loc_037FB9C0:
	.word FirmwareWlWorkPointerSlot	; 037FB9C0
pool_037FB9C4:
loc_037FB9C4:
	.word 0x000001D0	; 037FB9C4
pool_037FB9C8:
loc_037FB9C8:
	.word 0x000001C8	; 037FB9C8
pool_037FB9CC:
loc_037FB9CC:
	.word 0x000002D8	; 037FB9CC

; ===== function loc_037FB9D0 =====
P2_Entry_037FB9D0:
	push {r4,r5,r6,r7,lr}	; 037FB9D0
	sub sp,#0xc	; 037FB9D2
	ldr r0,[pool_037FBC70]	; 037FB9D4
	ldr r1,[r0,#0x0]	; 037FB9D6
	ldr r0,[pool_037FBC74]	; 037FB9D8
	add r4,r1,r0	; 037FB9DA
	ldr r0,[pool_037FBC78]	; 037FB9DC
	add r5,r1,r0	; 037FB9DE
	bl loc_037FBDA8	; 037FB9E0
	ldr r1,[pool_037FBC7C]	; 037FB9E4
	ldrh r2,[r1,#0x0]	; 037FB9E6
	ldrh r0,[r1,#0x0]	; 037FB9E8
	lsl r0,r0,#0x8	; 037FB9EA
	add r0,r2,r0	; 037FB9EC
	ldrh r1,[r1,#0x0]	; 037FB9EE
	bl loc_037FBD20	; 037FB9F0
	mov r1,#0x1	; 037FB9F4
	add r0,r4,#0x0	; 037FB9F6
	add r0,#0x7c	; 037FB9F8
	strh r1,[r0,#0x0]	; 037FB9FA
	ldrh r0,[r5,#0x1e]	; 037FB9FC
	lsl r0,r0,#0x1d	; 037FB9FE
	lsr r0,r0,#0x1f	; 037FBA00
	cmp r0,#0x1	; 037FBA02
	bne loc_037FBA16	; 037FBA04
	add r0,r4,#0x0	; 037FBA06
	add r0,#0x7c	; 037FBA08
	ldrh r1,[r0,#0x0]	; 037FBA0A
	mov r0,#0x20	; 037FBA0C
	orr r1,r0	; 037FBA0E
	add r0,r4,#0x0	; 037FBA10
	add r0,#0x7c	; 037FBA12
	strh r1,[r0,#0x0]	; 037FBA14
loc_037FBA16:
	ldrh r0,[r5,#0x18]	; 037FBA16
	cmp r0,#0x0	; 037FBA18
	beq loc_037FBA2C	; 037FBA1A
	add r0,r4,#0x0	; 037FBA1C
	add r0,#0x7c	; 037FBA1E
	ldrh r1,[r0,#0x0]	; 037FBA20
	mov r0,#0x10	; 037FBA22
	orr r1,r0	; 037FBA24
	add r0,r4,#0x0	; 037FBA26
	add r0,#0x7c	; 037FBA28
	strh r1,[r0,#0x0]	; 037FBA2A
loc_037FBA2C:
	mov r0,#0x0	; 037FBA2C
	strh r0,[r4,#0x12]	; 037FBA2E
	ldr r2,[pool_037FBC80]	; 037FBA30
	ldr r1,[pool_037FBC84]	; 037FBA32
	strh r2,[r1,#0x0]	; 037FBA34
	ldr r2,[pool_037FBC88]	; 037FBA36
	ldr r1,[pool_037FBC8C]	; 037FBA38
	strh r2,[r1,#0x0]	; 037FBA3A
	ldr r1,[pool_037FBC90]	; 037FBA3C
	strh r0,[r1,#0x0]	; 037FBA3E
	ldr r1,[pool_037FBC94]	; 037FBA40
	strh r0,[r1,#0x0]	; 037FBA42
	mov r1,#0xf	; 037FBA44
	ldr r0,[pool_037FBC98]	; 037FBA46
	strh r1,[r0,#0x0]	; 037FBA48
	bl loc_037FBD30	; 037FBA4A
	bl loc_037FBD40	; 037FBA4E
	bl loc_037FD450	; 037FBA52
	bl loc_037FD6F8	; 037FBA56
	ldr r1,[pool_037FBC80]	; 037FBA5A
	ldr r0,[pool_037FBC9C]	; 037FBA5C
	strh r1,[r0,#0x0]	; 037FBA5E
	ldr r1,[pool_037FBC88]	; 037FBA60
	ldr r0,[pool_037FBCA0]	; 037FBA62
	strh r1,[r0,#0x0]	; 037FBA64
	ldr r1,[pool_037FBCA4]	; 037FBA66
	ldr r0,[pool_037FBCA8]	; 037FBA68
	strh r1,[r0,#0x0]	; 037FBA6A
	ldr r0,[pool_037FBC70]	; 037FBA6C
	ldr r1,[r0,#0x0]	; 037FBA6E
	ldr r0,[pool_037FBCAC]	; 037FBA70
	ldrh r1,[r1,r0]	; 037FBA72
	mov r0,#0x8	; 037FBA74
	and r1,r0	; 037FBA76
	cmp r1,#0x0	; 037FBA78
	beq loc_037FBA84	; 037FBA7A
	ldr r1,[pool_037FBCB0]	; 037FBA7C
	ldr r0,[pool_037FBCB4]	; 037FBA7E
	strh r1,[r0,#0x0]	; 037FBA80
	b loc_037FBA8A	; 037FBA82
loc_037FBA84:
	mov r1,#0x0	; 037FBA84
	ldr r0,[pool_037FBCB4]	; 037FBA86
	strh r1,[r0,#0x0]	; 037FBA88
loc_037FBA8A:
	mov r6,#0x0	; 037FBA8A
	ldr r1,[pool_037FBCB8]	; 037FBA8C
	strh r6,[r1,#0x0]	; 037FBA8E
	ldr r0,[pool_037FBCBC]	; 037FBA90
	strh r6,[r0,#0x0]	; 037FBA92
	ldrh r2,[r4,#0xc]	; 037FBA94
	cmp r2,#0x4	; 037FBA96
	bls loc_037FBA9C	; 037FBA98
	b loc_037FBC48	; 037FBA9A
loc_037FBA9C:
	add r2,r2,r2	; 037FBA9C
P2_SwitchIndexPC_037FBA9C:
	add r2,pc	; 037FBA9E
	ldrh r2,[r2,#(P2_SwitchTable_037FBA9C - (P2_SwitchIndexPC_037FBA9C + 4))]	; 037FBAA0
	lsl r2,r2,#0x10	; 037FBAA2
	asr r2,r2,#0x10	; 037FBAA4
P2_SwitchTargetPC_037FBA9C:
	add r2,pc	; 037FBAA6
	bx r2	; 037FBAA8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FBA9C:
	.halfword (loc_037FBAB4 + 1) - (P2_SwitchTargetPC_037FBA9C + 4)
	.halfword (loc_037FBADC + 1) - (P2_SwitchTargetPC_037FBA9C + 4)
	.halfword (loc_037FBB7C + 1) - (P2_SwitchTargetPC_037FBA9C + 4)
	.halfword (loc_037FBBEC + 1) - (P2_SwitchTargetPC_037FBA9C + 4)
	.halfword (loc_037FBC34 + 1) - (P2_SwitchTargetPC_037FBA9C + 4)
P2_SwitchTable_037FBA9CEnd:
loc_037FBAB4:
	mov r3,#0x3f	; 037FBAB4
	ldr r2,[pool_037FBCC0]	; 037FBAB6
	strh r3,[r2,#0x0]	; 037FBAB8
	ldr r3,[pool_037FBC88]	; 037FBABA
	ldr r2,[pool_037FBCC4]	; 037FBABC
	strh r3,[r2,#0x0]	; 037FBABE
	mov r3,#0x8	; 037FBAC0
	ldr r2,[pool_037FBCC8]	; 037FBAC2
	strh r3,[r2,#0x0]	; 037FBAC4
	strh r6,[r1,#0x0]	; 037FBAC6
	strh r6,[r0,#0x0]	; 037FBAC8
	ldr r0,[pool_037FBCCC]	; 037FBACA
	strh r6,[r0,#0x0]	; 037FBACC
	mov r1,#0x1	; 037FBACE
	ldr r0,[pool_037FBCD0]	; 037FBAD0
	strh r1,[r0,#0x0]	; 037FBAD2
	mov r0,#0x40	; 037FBAD4
	bl loc_037FBE80	; 037FBAD6
	b loc_037FBC48	; 037FBADA
loc_037FBADC:
	ldr r2,[pool_037FBCD4]	; 037FBADC
	ldr r0,[pool_037FBCC0]	; 037FBADE
	strh r2,[r0,#0x0]	; 037FBAE0
	ldr r2,[pool_037FBCA4]	; 037FBAE2
	ldr r0,[pool_037FBCA8]	; 037FBAE4
	strh r2,[r0,#0x0]	; 037FBAE6
	ldr r2,[pool_037FBCD8]	; 037FBAE8
	ldr r0,[pool_037FBCC4]	; 037FBAEA
	strh r2,[r0,#0x0]	; 037FBAEC
	mov r2,#0xd	; 037FBAEE
	ldr r0,[pool_037FBCC8]	; 037FBAF0
	strh r2,[r0,#0x0]	; 037FBAF2
	ldr r0,[pool_037FBCDC]	; 037FBAF4
	strh r0,[r1,#0x0]	; 037FBAF6
	mov r1,#0x1	; 037FBAF8
	ldr r0,[pool_037FBCD0]	; 037FBAFA
	strh r1,[r0,#0x0]	; 037FBAFC
	add r5,sp,#0x0	; 037FBAFE
	ldr r0,[pool_037FBCE0]	; 037FBB00
	ldrh r0,[r0,#0x0]	; 037FBB02
	strh r0,[r5,#0x0]	; 037FBB04
	ldr r0,[pool_037FBCE4]	; 037FBB06
	ldrh r0,[r0,#0x0]	; 037FBB08
	strh r0,[r5,#0x2]	; 037FBB0A
	ldr r0,[pool_037FBCE8]	; 037FBB0C
	ldrh r0,[r0,#0x0]	; 037FBB0E
	strh r0,[r5,#0x4]	; 037FBB10
	ldr r0,[pool_037FBCEC]	; 037FBB12
	ldrh r0,[r0,#0x0]	; 037FBB14
	strh r0,[r5,#0x6]	; 037FBB16
	add r0,r4,#0x0	; 037FBB18
	add r0,#0x6e	; 037FBB1A
	ldrh r0,[r0,#0x0]	; 037FBB1C
	lsl r7,r0,#0xa	; 037FBB1E
	ldr r0,[sp,#0x0]	; 037FBB20
	ldr r1,[sp,#0x4]	; 037FBB22
	add r2,r7,#0x0	; 037FBB24
	add r3,r6,#0x0	; 037FBB26
	bl loc_037FBD50	; 037FBB28
	str r0,[sp,#0x0]	; 037FBB2C
	str r1,[sp,#0x4]	; 037FBB2E
	lsl r3,r6,#0	; 037FBB30
	mov r2,#0x1	; 037FBB32
	add r0,r0,r2	; 037FBB34
	adc r1,r3	; 037FBB36
	str r0,[sp,#0x0]	; 037FBB38
	str r1,[sp,#0x4]	; 037FBB3A
	add r2,r7,#0x0	; 037FBB3C
	bl loc_037FBD5C	; 037FBB3E
	str r0,[sp,#0x0]	; 037FBB42
	str r1,[sp,#0x4]	; 037FBB44
	ldrh r1,[r5,#0x6]	; 037FBB46
	ldr r0,[pool_037FBCF0]	; 037FBB48
	strh r1,[r0,#0x0]	; 037FBB4A
	ldrh r1,[r5,#0x4]	; 037FBB4C
	ldr r0,[pool_037FBCF4]	; 037FBB4E
	strh r1,[r0,#0x0]	; 037FBB50
	ldrh r1,[r5,#0x2]	; 037FBB52
	ldr r0,[pool_037FBCF8]	; 037FBB54
	strh r1,[r0,#0x0]	; 037FBB56
	ldrh r2,[r5,#0x0]	; 037FBB58
	mov r1,#0x1	; 037FBB5A
	orr r2,r1	; 037FBB5C
	ldr r0,[pool_037FBCFC]	; 037FBB5E
	strh r2,[r0,#0x0]	; 037FBB60
	ldr r0,[pool_037FBCCC]	; 037FBB62
	strh r1,[r0,#0x0]	; 037FBB64
	ldr r0,[pool_037FBD00]	; 037FBB66
	strh r1,[r0,#0x0]	; 037FBB68
	mov r0,#0x40	; 037FBB6A
	bl loc_037FBE80	; 037FBB6C
	bl loc_037FBD68	; 037FBB70
	mov r1,#0x2	; 037FBB74
	ldr r0,[pool_037FBD04]	; 037FBB76
	strh r1,[r0,#0x0]	; 037FBB78
	b loc_037FBC48	; 037FBB7A
loc_037FBB7C:
	ldr r1,[pool_037FBD08]	; 037FBB7C
	ldr r0,[pool_037FBCC0]	; 037FBB7E
	strh r1,[r0,#0x0]	; 037FBB80
	ldr r1,[pool_037FBC70]	; 037FBB82
	ldr r2,[r1,#0x0]	; 037FBB84
	ldr r1,[pool_037FBCAC]	; 037FBB86
	ldrh r2,[r2,r1]	; 037FBB88
	mov r1,#0x20	; 037FBB8A
	and r2,r1	; 037FBB8C
	cmp r2,#0x0	; 037FBB8E
	beq loc_037FBB9A	; 037FBB90
	ldrh r2,[r0,#0x0]	; 037FBB92
	mov r1,#0xc0	; 037FBB94
	orr r2,r1	; 037FBB96
	strh r2,[r0,#0x0]	; 037FBB98
loc_037FBB9A:
	ldr r0,[pool_037FBC70]	; 037FBB9A
	ldr r1,[r0,#0x0]	; 037FBB9C
	ldr r0,[pool_037FBCAC]	; 037FBB9E
	ldrh r1,[r1,r0]	; 037FBBA0
	mov r0,#0x20	; 037FBBA2
	and r1,r0	; 037FBBA4
	cmp r1,#0x0	; 037FBBA6
	beq loc_037FBBB4	; 037FBBA8
	ldr r2,[pool_037FBCB4]	; 037FBBAA
	ldrh r1,[r2,#0x0]	; 037FBBAC
	mov r0,#0x68	; 037FBBAE
	orr r1,r0	; 037FBBB0
	strh r1,[r2,#0x0]	; 037FBBB2
loc_037FBBB4:
	add r0,r4,#0x0	; 037FBBB4
	add r0,#0x64	; 037FBBB6
	ldrh r1,[r0,#0x0]	; 037FBBB8
	mov r0,#0x1	; 037FBBBA
	and r1,r0	; 037FBBBC
	cmp r1,#0x0	; 037FBBBE
	beq loc_037FBBCA	; 037FBBC0
	ldr r1,[pool_037FBD0C]	; 037FBBC2
	ldr r0,[pool_037FBCC4]	; 037FBBC4
	strh r1,[r0,#0x0]	; 037FBBC6
	b loc_037FBBD0	; 037FBBC8
loc_037FBBCA:
	ldr r1,[pool_037FBD10]	; 037FBBCA
	ldr r0,[pool_037FBCC4]	; 037FBBCC
	strh r1,[r0,#0x0]	; 037FBBCE
loc_037FBBD0:
	mov r1,#0xb	; 037FBBD0
	ldr r0,[pool_037FBCC8]	; 037FBBD2
	strh r1,[r0,#0x0]	; 037FBBD4
	mov r1,#0x1	; 037FBBD6
	ldr r0,[pool_037FBCD0]	; 037FBBD8
	strh r1,[r0,#0x0]	; 037FBBDA
	ldr r0,[pool_037FBCCC]	; 037FBBDC
	strh r1,[r0,#0x0]	; 037FBBDE
	ldr r0,[pool_037FBD00]	; 037FBBE0
	strh r1,[r0,#0x0]	; 037FBBE2
	mov r0,#0x20	; 037FBBE4
	bl loc_037FBE80	; 037FBBE6
	b loc_037FBC48	; 037FBBEA
loc_037FBBEC:
	ldr r1,[pool_037FBC88]	; 037FBBEC
	ldr r0,[pool_037FBCA0]	; 037FBBEE
	strh r1,[r0,#0x0]	; 037FBBF0
	ldr r1,[pool_037FBD14]	; 037FBBF2
	ldr r0,[pool_037FBCC0]	; 037FBBF4
	strh r1,[r0,#0x0]	; 037FBBF6
	add r0,r4,#0x0	; 037FBBF8
	add r0,#0x64	; 037FBBFA
	ldrh r0,[r0,#0x0]	; 037FBBFC
	mov r1,#0x1	; 037FBBFE
	and r0,r1	; 037FBC00
	cmp r0,#0x0	; 037FBC02
	beq loc_037FBC0E	; 037FBC04
	ldr r1,[pool_037FBD18]	; 037FBC06
	ldr r0,[pool_037FBCC4]	; 037FBC08
	strh r1,[r0,#0x0]	; 037FBC0A
	b loc_037FBC12	; 037FBC0C
loc_037FBC0E:
	ldr r0,[pool_037FBCC4]	; 037FBC0E
	strh r1,[r0,#0x0]	; 037FBC10
loc_037FBC12:
	mov r1,#0xb	; 037FBC12
	ldr r0,[pool_037FBCC8]	; 037FBC14
	strh r1,[r0,#0x0]	; 037FBC16
	mov r1,#0x1	; 037FBC18
	ldr r0,[pool_037FBCD0]	; 037FBC1A
	strh r1,[r0,#0x0]	; 037FBC1C
	ldr r0,[pool_037FBCCC]	; 037FBC1E
	strh r1,[r0,#0x0]	; 037FBC20
	ldr r0,[pool_037FBD00]	; 037FBC22
	strh r1,[r0,#0x0]	; 037FBC24
	mov r1,#0x0	; 037FBC26
	ldr r0,[pool_037FBD1C]	; 037FBC28
	strh r1,[r0,#0x0]	; 037FBC2A
	mov r0,#0x20	; 037FBC2C
	bl loc_037FBE80	; 037FBC2E
	b loc_037FBC48	; 037FBC32
loc_037FBC34:
	ldr r0,[pool_037FBCC0]	; 037FBC34
	strh r6,[r0,#0x0]	; 037FBC36
	ldr r0,[pool_037FBCA8]	; 037FBC38
	strh r6,[r0,#0x0]	; 037FBC3A
	mov r1,#0x1	; 037FBC3C
	ldr r0,[pool_037FBCD0]	; 037FBC3E
	strh r1,[r0,#0x0]	; 037FBC40
	mov r0,#0x20	; 037FBC42
	bl loc_037FBE80	; 037FBC44
loc_037FBC48:
	mov r1,#0x0	; 037FBC48
	ldr r0,[pool_037FBD1C]	; 037FBC4A
	strh r1,[r0,#0x0]	; 037FBC4C
	bl loc_037FBD78	; 037FBC4E
	mov r0,#0x2	; 037FBC52
	ldr r1,[pool_037FBD04]	; 037FBC54
	strh r0,[r1,#0x0]	; 037FBC56
	ldrh r1,[r4,#0xe]	; 037FBC58
	cmp r1,#0x1	; 037FBC5A
	bne loc_037FBC62	; 037FBC5C
	bl loc_037FBD88	; 037FBC5E
loc_037FBC62:
	bl loc_037FBD98	; 037FBC62
	add sp,#0xc	; 037FBC66
	pop {r4,r5,r6,r7}	; 037FBC68
	pop {r3}	; 037FBC6A
	bx r3	; 037FBC6C
	.byte 0xC0, 0x46	; 037FBC70
pool_037FBC70:
loc_037FBC70:
	.word FirmwareWlWorkPointerSlot	; 037FBC70
pool_037FBC74:
loc_037FBC74:
	.word 0x00000318	; 037FBC74
pool_037FBC78:
loc_037FBC78:
	.word 0x000002F0	; 037FBC78
pool_037FBC7C:
loc_037FBC7C:
	.word REG_WIFI_RANDOM	; 037FBC7C
pool_037FBC80:
loc_037FBC80:
	.word 0x00008000	; 037FBC80
pool_037FBC84:
loc_037FBC84:
	.word REG_WIFI_WEP_CNT	; 037FBC84
pool_037FBC88:
loc_037FBC88:
	.word 0x0000FFFF	; 037FBC88
pool_037FBC8C:
loc_037FBC8C:
	.word REG_WIFI_POST_BEACON	; 037FBC8C
pool_037FBC90:
loc_037FBC90:
	.word REG_WIFI_AID_FULL	; 037FBC90
pool_037FBC94:
loc_037FBC94:
	.word REG_WIFI_AID_LOW	; 037FBC94
pool_037FBC98:
loc_037FBC98:
	.word REG_WIFI_POWER_TX	; 037FBC98
pool_037FBC9C:
loc_037FBC9C:
	.word REG_WIFI_RXCNT	; 037FBC9C
pool_037FBCA0:
loc_037FBCA0:
	.word REG_WIFI_IF	; 037FBCA0
pool_037FBCA4:
loc_037FBCA4:
	.word 0x00001FFF	; 037FBCA4
pool_037FBCA8:
loc_037FBCA8:
	.word REG_WIFI_RXSTAT_OVF_IE	; 037FBCA8
pool_037FBCAC:
loc_037FBCAC:
	.word 0x00000638	; 037FBCAC
pool_037FBCB0:
loc_037FBCB0:
	.word 0x00000400	; 037FBCB0
pool_037FBCB4:
loc_037FBCB4:
	.word REG_WIFI_RXSTAT_INC_IE	; 037FBCB4
pool_037FBCB8:
loc_037FBCB8:
	.word REG_WIFI_TXSTATCNT	; 037FBCB8
pool_037FBCBC:
loc_037FBCBC:
	.word REG_WIFI_UNKNOWN_00A	; 037FBCBC
pool_037FBCC0:
loc_037FBCC0:
	.word REG_WIFI_IE	; 037FBCC0
pool_037FBCC4:
loc_037FBCC4:
	.word REG_WIFI_RXFILTER	; 037FBCC4
pool_037FBCC8:
loc_037FBCC8:
	.word REG_WIFI_RXFILTER2	; 037FBCC8
pool_037FBCCC:
loc_037FBCCC:
	.word REG_WIFI_US_COUNTCNT	; 037FBCCC
pool_037FBCD0:
loc_037FBCD0:
	.word REG_WIFI_MODE_RST	; 037FBCD0
pool_037FBCD4:
loc_037FBCD4:
	.word 0x0000703F	; 037FBCD4
pool_037FBCD8:
loc_037FBCD8:
	.word 0x00000301	; 037FBCD8
pool_037FBCDC:
loc_037FBCDC:
	.word 0x0000E000	; 037FBCDC
pool_037FBCE0:
loc_037FBCE0:
	.word REG_WIFI_US_COUNT0	; 037FBCE0
pool_037FBCE4:
loc_037FBCE4:
	.word REG_WIFI_US_COUNT1	; 037FBCE4
pool_037FBCE8:
loc_037FBCE8:
	.word REG_WIFI_US_COUNT2	; 037FBCE8
pool_037FBCEC:
loc_037FBCEC:
	.word REG_WIFI_US_COUNT3	; 037FBCEC
pool_037FBCF0:
loc_037FBCF0:
	.word REG_WIFI_US_COMPARE3	; 037FBCF0
pool_037FBCF4:
loc_037FBCF4:
	.word REG_WIFI_US_COMPARE2	; 037FBCF4
pool_037FBCF8:
loc_037FBCF8:
	.word REG_WIFI_US_COMPARE1	; 037FBCF8
pool_037FBCFC:
loc_037FBCFC:
	.word REG_WIFI_US_COMPARE0	; 037FBCFC
pool_037FBD00:
loc_037FBD00:
	.word REG_WIFI_US_COMPARECNT	; 037FBD00
pool_037FBD04:
loc_037FBD04:
	.word REG_WIFI_TXREQ_SET	; 037FBD04
pool_037FBD08:
loc_037FBD08:
	.word 0x0000E03F	; 037FBD08
pool_037FBD0C:
loc_037FBD0C:
	.word 0x00000581	; 037FBD0C
pool_037FBD10:
loc_037FBD10:
	.word 0x00000181	; 037FBD10
pool_037FBD14:
loc_037FBD14:
	.word 0x0000C03F	; 037FBD14
pool_037FBD18:
loc_037FBD18:
	.word 0x00000401	; 037FBD18
pool_037FBD1C:
loc_037FBD1C:
	.word REG_WIFI_UNKNOWN_048	; 037FBD1C

; ===== function loc_037FBD20 =====
loc_037FBD20:
	bx pc	; 037FBD20
	.byte 0xC0, 0x46	; 037FBD24
.arm

; ===== function loc_037FBD24 =====
loc_037FBD24:
	ldr r12,[pool_037FBD2C]	; 037FBD24
	bx r12	; 037FBD28
pool_037FBD2C:
loc_037FBD2C:
	.word loc_0230515C + 1	; 037FBD2C
.thumb

; ===== function loc_037FBD30 =====
loc_037FBD30:
	bx pc	; 037FBD30
	.byte 0xC0, 0x46	; 037FBD34
.arm

; ===== function loc_037FBD34 =====
loc_037FBD34:
	ldr r12,[pool_037FBD3C]	; 037FBD34
	bx r12	; 037FBD38
pool_037FBD3C:
loc_037FBD3C:
	.word P4_Entry_02306EE0 + 1	; 037FBD3C
.thumb

; ===== function loc_037FBD40 =====
loc_037FBD40:
	bx pc	; 037FBD40
	.byte 0xC0, 0x46	; 037FBD44
.arm

; ===== function loc_037FBD44 =====
loc_037FBD44:
	ldr r12,[pool_037FBD4C]	; 037FBD44
	bx r12	; 037FBD48
pool_037FBD4C:
loc_037FBD4C:
	.word P4_Entry_0230D1C8 + 1	; 037FBD4C
.thumb

; ===== function loc_037FBD50 =====
loc_037FBD50:
	bx pc	; 037FBD50
	.byte 0xC0, 0x46	; 037FBD54
.arm

; ===== function loc_037FBD54 =====
loc_037FBD54:
	ldr pc,[pool_037FBD58]	; 037FBD54
pool_037FBD58:
loc_037FBD58:
	.word loc_03804954	; 037FBD58
.thumb

; ===== function loc_037FBD5C =====
loc_037FBD5C:
	bx pc	; 037FBD5C
	.byte 0xC0, 0x46	; 037FBD60
.arm

; ===== function loc_037FBD60 =====
loc_037FBD60:
	ldr pc,[pool_037FBD64]	; 037FBD60
pool_037FBD64:
loc_037FBD64:
	.word loc_03804B5C	; 037FBD64
.thumb

; ===== function loc_037FBD68 =====
loc_037FBD68:
	bx pc	; 037FBD68
	.byte 0xC0, 0x46	; 037FBD6C
.arm

; ===== function loc_037FBD6C =====
loc_037FBD6C:
	ldr r12,[pool_037FBD74]	; 037FBD6C
	bx r12	; 037FBD70
pool_037FBD74:
loc_037FBD74:
	.word P4_Entry_0230A3B4 + 1	; 037FBD74
.thumb

; ===== function loc_037FBD78 =====
loc_037FBD78:
	bx pc	; 037FBD78
	.byte 0xC0, 0x46	; 037FBD7C
.arm

; ===== function loc_037FBD7C =====
loc_037FBD7C:
	ldr r12,[pool_037FBD84]	; 037FBD7C
	bx r12	; 037FBD80
pool_037FBD84:
loc_037FBD84:
	.word loc_02305D24 + 1	; 037FBD84
.thumb

; ===== function loc_037FBD88 =====
loc_037FBD88:
	bx pc	; 037FBD88
	.byte 0xC0, 0x46	; 037FBD8C
.arm

; ===== function loc_037FBD8C =====
loc_037FBD8C:
	ldr r12,[pool_037FBD94]	; 037FBD8C
	bx r12	; 037FBD90
pool_037FBD94:
loc_037FBD94:
	.word loc_02305E90 + 1	; 037FBD94
.thumb

; ===== function loc_037FBD98 =====
loc_037FBD98:
	bx pc	; 037FBD98
	.byte 0xC0, 0x46	; 037FBD9C
.arm

; ===== function loc_037FBD9C =====
loc_037FBD9C:
	ldr r12,[pool_037FBDA4]	; 037FBD9C
	bx r12	; 037FBDA0
pool_037FBDA4:
loc_037FBDA4:
	.word P4_Entry_02307810 + 1	; 037FBDA4
.thumb

; ===== function loc_037FBDA8 =====
loc_037FBDA8:
	push {r4,lr}	; 037FBDA8
	ldr r0,[pool_037FBE04]	; 037FBDAA
	ldr r1,[r0,#0x0]	; 037FBDAC
	ldr r0,[pool_037FBE08]	; 037FBDAE
	add r4,r1,r0	; 037FBDB0
	bl loc_037FBE30	; 037FBDB2
	bl loc_037FBE40	; 037FBDB6
	mov r0,#0x20	; 037FBDBA
	bl loc_037FBE80	; 037FBDBC
	mov r0,#0x0	; 037FBDC0
	add r1,r4,#0x0	; 037FBDC2
	add r1,#0xa4	; 037FBDC4
	strh r0,[r1,#0x0]	; 037FBDC6
	strh r0,[r4,#0x12]	; 037FBDC8
	ldr r1,[pool_037FBE0C]	; 037FBDCA
	strh r0,[r1,#0x0]	; 037FBDCC
	ldr r1,[pool_037FBE10]	; 037FBDCE
	strh r0,[r1,#0x0]	; 037FBDD0
	ldr r1,[pool_037FBE14]	; 037FBDD2
	strh r0,[r1,#0x0]	; 037FBDD4
	ldr r1,[pool_037FBE18]	; 037FBDD6
	strh r0,[r1,#0x0]	; 037FBDD8
	ldr r1,[pool_037FBE1C]	; 037FBDDA
	strh r0,[r1,#0x0]	; 037FBDDC
	ldr r1,[pool_037FBE20]	; 037FBDDE
	strh r0,[r1,#0x0]	; 037FBDE0
	ldrh r0,[r4,#0xc]	; 037FBDE2
	cmp r0,#0x1	; 037FBDE4
	bne loc_037FBDEC	; 037FBDE6
	bl loc_037FBE50	; 037FBDE8
loc_037FBDEC:
	ldr r1,[pool_037FBE24]	; 037FBDEC
	ldr r0,[pool_037FBE28]	; 037FBDEE
	strh r1,[r0,#0x0]	; 037FBDF0
	ldr r0,[pool_037FBE2C]	; 037FBDF2
	strh r1,[r0,#0x0]	; 037FBDF4
	bl loc_037FBE60	; 037FBDF6
	bl loc_037FBE70	; 037FBDFA
	pop {r4}	; 037FBDFE
	pop {r3}	; 037FBE00
	bx r3	; 037FBE02
pool_037FBE04:
loc_037FBE04:
	.word FirmwareWlWorkPointerSlot	; 037FBE04
pool_037FBE08:
loc_037FBE08:
	.word 0x00000318	; 037FBE08
pool_037FBE0C:
loc_037FBE0C:
	.word REG_WIFI_IE	; 037FBE0C
pool_037FBE10:
loc_037FBE10:
	.word REG_WIFI_MODE_RST	; 037FBE10
pool_037FBE14:
loc_037FBE14:
	.word REG_WIFI_US_COMPARECNT	; 037FBE14
pool_037FBE18:
loc_037FBE18:
	.word REG_WIFI_US_COUNTCNT	; 037FBE18
pool_037FBE1C:
loc_037FBE1C:
	.word REG_WIFI_TXSTATCNT	; 037FBE1C
pool_037FBE20:
loc_037FBE20:
	.word REG_WIFI_UNKNOWN_00A	; 037FBE20
pool_037FBE24:
loc_037FBE24:
	.word 0x0000FFFF	; 037FBE24
pool_037FBE28:
loc_037FBE28:
	.word REG_WIFI_TXREQ_RESET	; 037FBE28
pool_037FBE2C:
loc_037FBE2C:
	.word REG_WIFI_TXBUF_RESET	; 037FBE2C

; ===== function loc_037FBE30 =====
loc_037FBE30:
	bx pc	; 037FBE30
	.byte 0xC0, 0x46	; 037FBE34
.arm

; ===== function loc_037FBE34 =====
loc_037FBE34:
	ldr r12,[pool_037FBE3C]	; 037FBE34
	bx r12	; 037FBE38
pool_037FBE3C:
loc_037FBE3C:
	.word P4_Entry_02305468 + 1	; 037FBE3C
.thumb

; ===== function loc_037FBE40 =====
loc_037FBE40:
	bx pc	; 037FBE40
	.byte 0xC0, 0x46	; 037FBE44
.arm

; ===== function loc_037FBE44 =====
loc_037FBE44:
	ldr r12,[pool_037FBE4C]	; 037FBE44
	bx r12	; 037FBE48
pool_037FBE4C:
loc_037FBE4C:
	.word loc_02305358 + 1	; 037FBE4C
.thumb

; ===== function loc_037FBE50 =====
loc_037FBE50:
	bx pc	; 037FBE50
	.byte 0xC0, 0x46	; 037FBE54
.arm

; ===== function loc_037FBE54 =====
loc_037FBE54:
	ldr r12,[pool_037FBE5C]	; 037FBE54
	bx r12	; 037FBE58
pool_037FBE5C:
loc_037FBE5C:
	.word P4_Entry_0230A398 + 1	; 037FBE5C
.thumb

; ===== function loc_037FBE60 =====
loc_037FBE60:
	bx pc	; 037FBE60
	.byte 0xC0, 0x46	; 037FBE64
.arm

; ===== function loc_037FBE64 =====
loc_037FBE64:
	ldr r12,[pool_037FBE6C]	; 037FBE64
	bx r12	; 037FBE68
pool_037FBE6C:
loc_037FBE6C:
	.word P4_Entry_0230A520 + 1	; 037FBE6C
.thumb

; ===== function loc_037FBE70 =====
loc_037FBE70:
	bx pc	; 037FBE70
	.byte 0xC0, 0x46	; 037FBE74
.arm

; ===== function loc_037FBE74 =====
loc_037FBE74:
	ldr r12,[pool_037FBE7C]	; 037FBE74
	bx r12	; 037FBE78
pool_037FBE7C:
loc_037FBE7C:
	.word P4_Entry_02304C4C + 1	; 037FBE7C
.thumb

; ===== function loc_037FBE80 =====
loc_037FBE80:
	push {r4,r5,lr}	; 037FBE80
	sub sp,#0x4	; 037FBE82
	add r5,r0,#0x0	; 037FBE84
	ldr r0,[pool_037FBEDC]	; 037FBE86
	ldr r1,[r0,#0x0]	; 037FBE88
	ldr r0,[pool_037FBEE0]	; 037FBE8A
	add r4,r1,r0	; 037FBE8C
	ldrh r0,[r4,#0x8]	; 037FBE8E
	cmp r0,r5	; 037FBE90
	beq loc_037FBED4	; 037FBE92
	cmp r0,#0x40	; 037FBE94
	bne loc_037FBE9C	; 037FBE96
	bl loc_037FBE40	; 037FBE98
loc_037FBE9C:
	cmp r5,#0x0	; 037FBE9C
	beq loc_037FBEAA	; 037FBE9E
	cmp r5,#0x10	; 037FBEA0
	beq loc_037FBEB0	; 037FBEA2
	cmp r5,#0x40	; 037FBEA4
	beq loc_037FBEC0	; 037FBEA6
	b loc_037FBED2	; 037FBEA8
loc_037FBEAA:
	bl loc_037FBEE8	; 037FBEAA
	b loc_037FBED2	; 037FBEAE
loc_037FBEB0:
	mov r0,#0x0	; 037FBEB0
	bl loc_037FBEF8	; 037FBEB2
	bl loc_037FBDA8	; 037FBEB6
	bl loc_037FBF08	; 037FBEBA
	b loc_037FBED2	; 037FBEBE
loc_037FBEC0:
	ldrh r0,[r4,#0xc]	; 037FBEC0
	cmp r0,#0x2	; 037FBEC2
	bne loc_037FBECA	; 037FBEC4
	bl loc_037FBF18	; 037FBEC6
loc_037FBECA:
	mov r0,#0x64	; 037FBECA
	ldr r1,[pool_037FBEE4]	; 037FBECC
	bl loc_037FBF28	; 037FBECE
loc_037FBED2:
	strh r5,[r4,#0x8]	; 037FBED2
loc_037FBED4:
	add sp,#0x4	; 037FBED4
	pop {r4,r5}	; 037FBED6
	pop {r3}	; 037FBED8
	bx r3	; 037FBEDA
pool_037FBEDC:
loc_037FBEDC:
	.word FirmwareWlWorkPointerSlot	; 037FBEDC
pool_037FBEE0:
loc_037FBEE0:
	.word 0x00000318	; 037FBEE0
pool_037FBEE4:
loc_037FBEE4:
	.word 0x02305409	; 037FBEE4

; ===== function loc_037FBEE8 =====
loc_037FBEE8:
	bx pc	; 037FBEE8
	.byte 0xC0, 0x46	; 037FBEEC
.arm

; ===== function loc_037FBEEC =====
loc_037FBEEC:
	ldr r12,[pool_037FBEF4]	; 037FBEEC
	bx r12	; 037FBEF0
pool_037FBEF4:
loc_037FBEF4:
	.word loc_02305E30 + 1	; 037FBEF4
.thumb

; ===== function loc_037FBEF8 =====
loc_037FBEF8:
	bx pc	; 037FBEF8
	.byte 0xC0, 0x46	; 037FBEFC
.arm

; ===== function loc_037FBEFC =====
loc_037FBEFC:
	ldr r12,[pool_037FBF04]	; 037FBEFC
	bx r12	; 037FBF00
pool_037FBF04:
loc_037FBF04:
	.word loc_02305E84 + 1	; 037FBF04
.thumb

; ===== function loc_037FBF08 =====
loc_037FBF08:
	bx pc	; 037FBF08
	.byte 0xC0, 0x46	; 037FBF0C
.arm

; ===== function loc_037FBF0C =====
loc_037FBF0C:
	ldr r12,[pool_037FBF14]	; 037FBF0C
	bx r12	; 037FBF10
pool_037FBF14:
loc_037FBF14:
	.word loc_02305DC8 + 1	; 037FBF14
.thumb

; ===== function loc_037FBF18 =====
loc_037FBF18:
	bx pc	; 037FBF18
	.byte 0xC0, 0x46	; 037FBF1C
.arm

; ===== function loc_037FBF1C =====
loc_037FBF1C:
	ldr r12,[pool_037FBF24]	; 037FBF1C
	bx r12	; 037FBF20
pool_037FBF24:
loc_037FBF24:
	.word loc_02305D00 + 1	; 037FBF24
.thumb

; ===== function loc_037FBF28 =====
loc_037FBF28:
	bx pc	; 037FBF28
	.byte 0xC0, 0x46	; 037FBF2C
.arm

; ===== function loc_037FBF2C =====
loc_037FBF2C:
	ldr r12,[pool_037FBF34]	; 037FBF2C
	bx r12	; 037FBF30
pool_037FBF34:
loc_037FBF34:
	.word P4_Entry_02305480 + 1	; 037FBF34
.thumb
P2_IrqHandler_037FBF38:
	push {r4,r5,r6,r7,lr}	; 037FBF38
	sub sp,#0x4	; 037FBF3A
	mov r7,#0x1	; 037FBF3C
	ldr r4,[pool_037FC008]	; 037FBF3E
	ldr r6,[pool_037FC00C]	; 037FBF40
P2_Entry_037FBF42:
	ldrh r5,[r4,#0x0]	; 037FBF42
	ldrh r0,[r6,#0x0]	; 037FBF44
	and r5,r0	; 037FBF46
	cmp r5,#0x0	; 037FBF48
	beq P2_Entry_037FBFF4	; 037FBF4A
	add r1,r5,#0x0	; 037FBF4C
	mov r0,#0x80	; 037FBF4E
	and r1,r0	; 037FBF50
	cmp r1,#0x0	; 037FBF52
	beq P2_Entry_037FBF5A	; 037FBF54
	bl P2_Entry_037FCA64	; 037FBF56
P2_Entry_037FBF5A:
	add r1,r5,#0x0	; 037FBF5A
	mov r0,#0x40	; 037FBF5C
	and r1,r0	; 037FBF5E
	cmp r1,#0x0	; 037FBF60
	beq P2_Entry_037FBF68	; 037FBF62
	bl P2_Entry_037FCAE4	; 037FBF64
P2_Entry_037FBF68:
	add r1,r5,#0x0	; 037FBF68
	ldr r0,[pool_037FC010]	; 037FBF6A
	and r1,r0	; 037FBF6C
	cmp r1,#0x0	; 037FBF6E
	beq P2_Entry_037FBF76	; 037FBF70
	bl P2_Entry_037FC03C	; 037FBF72
P2_Entry_037FBF76:
	add r1,r5,#0x0	; 037FBF76
	ldr r0,[pool_037FC014]	; 037FBF78
	and r1,r0	; 037FBF7A
	cmp r1,#0x0	; 037FBF7C
	beq P2_Entry_037FBF84	; 037FBF7E
	bl P2_Entry_037FC0B4	; 037FBF80
P2_Entry_037FBF84:
	add r1,r5,#0x0	; 037FBF84
	ldr r0,[pool_037FC018]	; 037FBF86
	and r1,r0	; 037FBF88
	cmp r1,#0x0	; 037FBF8A
	beq P2_Entry_037FBF92	; 037FBF8C
	bl P2_Entry_037FC2FC	; 037FBF8E
P2_Entry_037FBF92:
	add r1,r5,#0x0	; 037FBF92
	ldr r0,[pool_037FC01C]	; 037FBF94
	and r1,r0	; 037FBF96
	cmp r1,#0x0	; 037FBF98
	beq P2_Entry_037FBFA0	; 037FBF9A
	bl P2_Entry_037FC02C	; 037FBF9C
P2_Entry_037FBFA0:
	add r1,r5,#0x0	; 037FBFA0
	mov r0,#0x8	; 037FBFA2
	and r1,r0	; 037FBFA4
	cmp r1,#0x0	; 037FBFA6
	beq P2_Entry_037FBFAE	; 037FBFA8
	bl P2_Entry_037FC38C	; 037FBFAA
P2_Entry_037FBFAE:
	add r1,r5,#0x0	; 037FBFAE
	mov r0,#0x4	; 037FBFB0
	and r1,r0	; 037FBFB2
	cmp r1,#0x0	; 037FBFB4
	beq P2_Entry_037FBFBC	; 037FBFB6
	bl P2_Entry_037FC468	; 037FBFB8
P2_Entry_037FBFBC:
	add r0,r5,#0x0	; 037FBFBC
	and r0,r7	; 037FBFBE
	cmp r0,#0x0	; 037FBFC0
	beq P2_Entry_037FBFC8	; 037FBFC2
	bl P2_Entry_037FC7B0	; 037FBFC4
P2_Entry_037FBFC8:
	add r1,r5,#0x0	; 037FBFC8
	mov r0,#0x30	; 037FBFCA
	and r1,r0	; 037FBFCC
	cmp r1,#0x0	; 037FBFCE
	beq P2_Entry_037FBFD6	; 037FBFD0
	bl P2_Entry_037FC354	; 037FBFD2
P2_Entry_037FBFD6:
	add r1,r5,#0x0	; 037FBFD6
	mov r0,#0x2	; 037FBFD8
	and r1,r0	; 037FBFDA
	cmp r1,#0x0	; 037FBFDC
	beq P2_Entry_037FBFE4	; 037FBFDE
	bl P2_Entry_037FC5D8	; 037FBFE0
P2_Entry_037FBFE4:
	ldr r0,[pool_037FC020]	; 037FBFE4
	and r5,r0	; 037FBFE6
	cmp r5,#0x0	; 037FBFE8
	beq P2_Entry_037FBF42	; 037FBFEA
	add r0,r7,#0x0	; 037FBFEC
	bl P2_Entry_037FC9A4	; 037FBFEE
	b P2_Entry_037FBF42	; 037FBFF2
P2_Entry_037FBFF4:
	ldr r2,[pool_037FC024]	; 037FBFF4
	ldr r1,[r2,#0x0]	; 037FBFF6
	ldr r0,[pool_037FC028]	; 037FBFF8
	orr r1,r0	; 037FBFFA
	str r1,[r2,#0x0]	; 037FBFFC
	add sp,#0x4	; 037FBFFE
	pop {r4,r5,r6,r7}	; 037FC000
	pop {r3}	; 037FC002
	bx r3	; 037FC004
	.byte 0xC0, 0x46	; 037FC006
pool_037FC008:
	.word REG_WIFI_IF	; 037FC008
pool_037FC00C:
	.word REG_WIFI_IE	; 037FC00C
pool_037FC010:
	.word 0x00008000	; 037FC010
pool_037FC014:
	.word 0x00004000	; 037FC014
pool_037FC018:
	.word 0x00002000	; 037FC018
pool_037FC01C:
	.word 0x00000800	; 037FC01C
pool_037FC020:
	.word 0x00001000	; 037FC020
pool_037FC024:
	.word Bios7IrqFlagsAddress	; 037FC024
pool_037FC028:
	.word 0x01000000	; 037FC028
P2_Entry_037FC02C:
	bx pc	; 037FC02C
	.byte 0xC0, 0x46	; 037FC02E
.arm
	ldr r12,[pool_037FC038]	; 037FC030
	bx r12	; 037FC034
pool_037FC038:
	.word P4_Entry_02306E3C + 1	; 037FC038
P2_Entry_037FC03C:
.thumb
	push {r4,lr}	; 037FC03C
	ldr r0,[pool_037FC0A4]	; 037FC03E
	ldr r1,[r0,#0x0]	; 037FC040
	ldr r0,[pool_037FC0A8]	; 037FC042
	add r4,r1,r0	; 037FC044
	ldr r1,[pool_037FC0AC]	; 037FC046
	ldr r0,[pool_037FC0B0]	; 037FC048
	strh r1,[r0,#0x0]	; 037FC04A
	ldrh r0,[r4,#0x8]	; 037FC04C
	cmp r0,#0x40	; 037FC04E
	bne P2_Entry_037FC09A	; 037FC050
	add r0,r4,#0x0	; 037FC052
	add r0,#0x7e	; 037FC054
	ldrh r0,[r0,#0x0]	; 037FC056
	cmp r0,#0x0	; 037FC058
	beq P2_Entry_037FC09A	; 037FC05A
	add r0,r4,#0x0	; 037FC05C
	add r0,#0x72	; 037FC05E
	ldrh r1,[r0,#0x0]	; 037FC060
	add r0,r4,#0x0	; 037FC062
	add r0,#0x70	; 037FC064
	ldrh r0,[r0,#0x0]	; 037FC066
	cmp r1,r0	; 037FC068
	bne P2_Entry_037FC09A	; 037FC06A
	add r0,r4,#0x0	; 037FC06C
	add r0,#0x80	; 037FC06E
	ldrh r0,[r0,#0x0]	; 037FC070
	add r1,r0,#0x1	; 037FC072
	add r0,r4,#0x0	; 037FC074
	add r0,#0x80	; 037FC076
	strh r1,[r0,#0x0]	; 037FC078
	add r0,r4,#0x0	; 037FC07A
	add r0,#0x80	; 037FC07C
	ldrh r1,[r0,#0x0]	; 037FC07E
	add r0,r4,#0x0	; 037FC080
	add r0,#0x7e	; 037FC082
	ldrh r0,[r0,#0x0]	; 037FC084
	cmp r1,r0	; 037FC086
	bls P2_Entry_037FC09A	; 037FC088
	mov r1,#0x0	; 037FC08A
	add r0,r4,#0x0	; 037FC08C
	add r0,#0x80	; 037FC08E
	strh r1,[r0,#0x0]	; 037FC090
	mov r0,#0x1	; 037FC092
	mov r1,#0xd	; 037FC094
	bl loc_037FB3CC	; 037FC096
P2_Entry_037FC09A:
	mov r0,#0x1	; 037FC09A
	strh r0,[r4,#0x10]	; 037FC09C
	pop {r4}	; 037FC09E
	pop {r3}	; 037FC0A0
	bx r3	; 037FC0A2
pool_037FC0A4:
	.word FirmwareWlWorkPointerSlot	; 037FC0A4
pool_037FC0A8:
	.word 0x00000318	; 037FC0A8
pool_037FC0AC:
	.word 0x00008000	; 037FC0AC
pool_037FC0B0:
	.word REG_WIFI_IF	; 037FC0B0
P2_Entry_037FC0B4:
	push {r4,r5,r6,r7,lr}	; 037FC0B4
	sub sp,#0xc	; 037FC0B6
	ldr r0,[pool_037FC2A8]	; 037FC0B8
	ldr r1,[r0,#0x0]	; 037FC0BA
	ldr r0,[pool_037FC2AC]	; 037FC0BC
	add r5,r1,r0	; 037FC0BE
	ldr r0,[pool_037FC2B0]	; 037FC0C0
	add r6,r1,r0	; 037FC0C2
	ldr r0,[pool_037FC2B4]	; 037FC0C4
	add r4,r1,r0	; 037FC0C6
	ldr r1,[pool_037FC2B8]	; 037FC0C8
	ldr r0,[pool_037FC2BC]	; 037FC0CA
	strh r1,[r0,#0x0]	; 037FC0CC
	ldrh r0,[r5,#0xc]	; 037FC0CE
	cmp r0,#0x1	; 037FC0D0
	beq P2_Entry_037FC0DE	; 037FC0D2
	cmp r0,#0x2	; 037FC0D4
	beq P2_Entry_037FC170	; 037FC0D6
	cmp r0,#0x3	; 037FC0D8
	beq P2_Entry_037FC196	; 037FC0DA
	b P2_Entry_037FC2A0	; 037FC0DC
P2_Entry_037FC0DE:
	add r0,r4,#0x0	; 037FC0DE
	add r0,#0x80	; 037FC0E0
	ldr r1,[r0,#0x0]	; 037FC0E2
	add r1,#0x24	; 037FC0E4
	add r0,r5,#0x0	; 037FC0E6
	add r0,#0x96	; 037FC0E8
	ldrh r0,[r0,#0x0]	; 037FC0EA
	add r7,r1,r0	; 037FC0EC
	add r7,#0x8	; 037FC0EE
	ldr r0,[pool_037FC2C0]	; 037FC0F0
	ldrh r0,[r0,#0x0]	; 037FC0F2
	str r0,[sp,#0x0]	; 037FC0F4
	add r0,r7,#0x0	; 037FC0F6
	ldr r1,[sp,#0x0]	; 037FC0F8
	lsl r1,r1,#0x18	; 037FC0FA
	lsr r1,r1,#0x18	; 037FC0FC
	bl P2_Entry_037FC2EC	; 037FC0FE
	add r0,r7,#0x1	; 037FC102
	ldr r1,[sp,#0x0]	; 037FC104
	lsr r1,r1,#0x8	; 037FC106
	lsl r1,r1,#0x18	; 037FC108
	lsr r1,r1,#0x18	; 037FC10A
	bl P2_Entry_037FC2EC	; 037FC10C
	ldrh r0,[r5,#0xe]	; 037FC110
	cmp r0,#0x1	; 037FC112
	bne P2_Entry_037FC122	; 037FC114
	ldrh r2,[r6,#0x20]	; 037FC116
	ldr r1,[pool_037FC2C4]	; 037FC118
	ldrh r0,[r1,#0x0]	; 037FC11A
	add r0,r2,r0	; 037FC11C
	add r0,r0,#0x1	; 037FC11E
	strh r0,[r1,#0x0]	; 037FC120
P2_Entry_037FC122:
	ldr r0,[pool_037FC2A8]	; 037FC122
	ldr r0,[r0,#0x0]	; 037FC124
	ldr r1,[pool_037FC2C8]	; 037FC126
	ldrh r1,[r0,r1]	; 037FC128
	mvn r2,r1	; 037FC12A
	ldr r1,[pool_037FC2CC]	; 037FC12C
	ldrh r1,[r0,r1]	; 037FC12E
	orr r2,r1	; 037FC130
	ldr r1,[pool_037FC2D0]	; 037FC132
	strh r2,[r0,r1]	; 037FC134
	ldr r0,[pool_037FC2D4]	; 037FC136
	ldrh r2,[r0,#0x0]	; 037FC138
	mov r0,#0x18	; 037FC13A
	add r1,r2,#0x0	; 037FC13C
	and r1,r0	; 037FC13E
	cmp r1,#0x0	; 037FC140
	bne P2_Entry_037FC14C	; 037FC142
	mov r0,#0x6	; 037FC144
	and r2,r0	; 037FC146
	cmp r2,#0x2	; 037FC148
	bne P2_Entry_037FC160	; 037FC14A
P2_Entry_037FC14C:
	add r0,r4,#0x0	; 037FC14C
	add r0,#0x8c	; 037FC14E
	ldr r1,[r0,#0x0]	; 037FC150
	mov r0,#0x2	; 037FC152
	bic r1,r0	; 037FC154
	add r4,#0x8c	; 037FC156
	str r1,[r4,#0x0]	; 037FC158
	bl P2_Entry_037FCCC8	; 037FC15A
	b P2_Entry_037FC2A0	; 037FC15E
P2_Entry_037FC160:
	add r0,r4,#0x0	; 037FC160
	add r0,#0x8c	; 037FC162
	ldr r1,[r0,#0x0]	; 037FC164
	mov r0,#0x2	; 037FC166
	orr r1,r0	; 037FC168
	add r4,#0x8c	; 037FC16A
	str r1,[r4,#0x0]	; 037FC16C
	b P2_Entry_037FC2A0	; 037FC16E
P2_Entry_037FC170:
	ldrh r0,[r5,#0x12]	; 037FC170
	cmp r0,#0x0	; 037FC172
	beq P2_Entry_037FC184	; 037FC174
	ldrh r2,[r6,#0x20]	; 037FC176
	ldr r1,[pool_037FC2C4]	; 037FC178
	ldrh r0,[r1,#0x0]	; 037FC17A
	add r0,r2,r0	; 037FC17C
	add r0,r0,#0x1	; 037FC17E
	strh r0,[r1,#0x0]	; 037FC180
	b P2_Entry_037FC18A	; 037FC182
P2_Entry_037FC184:
	ldr r1,[pool_037FC2D8]	; 037FC184
	ldr r0,[pool_037FC2C4]	; 037FC186
	strh r1,[r0,#0x0]	; 037FC188
P2_Entry_037FC18A:
	ldrh r0,[r5,#0x1a]	; 037FC18A
	cmp r0,#0x2	; 037FC18C
	bne P2_Entry_037FC196	; 037FC18E
	mov r0,#0x2	; 037FC190
	bl loc_037FBD88	; 037FC192
P2_Entry_037FC196:
	ldrh r0,[r5,#0x8]	; 037FC196
	cmp r0,#0x40	; 037FC198
	beq P2_Entry_037FC1A0	; 037FC19A
	mov r0,#0x1	; 037FC19C
	b P2_Entry_037FC1CE	; 037FC19E
P2_Entry_037FC1A0:
	mov r0,#0x0	; 037FC1A0
	add r1,r5,#0x0	; 037FC1A2
	add r1,#0x72	; 037FC1A4
	ldrh r1,[r1,#0x0]	; 037FC1A6
	cmp r1,#0x1	; 037FC1A8
	bne P2_Entry_037FC1AE	; 037FC1AA
	mov r0,#0x1	; 037FC1AC
P2_Entry_037FC1AE:
	ldrh r1,[r5,#0x14]	; 037FC1AE
	cmp r1,#0x0	; 037FC1B0
	beq P2_Entry_037FC1CE	; 037FC1B2
	add r1,r5,#0x0	; 037FC1B4
	add r1,#0x76	; 037FC1B6
	ldrh r1,[r1,#0x0]	; 037FC1B8
	cmp r1,#0x1	; 037FC1BA
	beq P2_Entry_037FC1CC	; 037FC1BC
	cmp r1,#0x0	; 037FC1BE
	bne P2_Entry_037FC1CE	; 037FC1C0
	add r1,r5,#0x0	; 037FC1C2
	add r1,#0x74	; 037FC1C4
	ldrh r1,[r1,#0x0]	; 037FC1C6
	cmp r1,#0x1	; 037FC1C8
	bne P2_Entry_037FC1CE	; 037FC1CA
P2_Entry_037FC1CC:
	mov r0,#0x1	; 037FC1CC
P2_Entry_037FC1CE:
	cmp r0,#0x0	; 037FC1CE
	beq P2_Entry_037FC1DE	; 037FC1D0
	ldr r2,[pool_037FC2DC]	; 037FC1D2
	ldrh r1,[r2,#0x0]	; 037FC1D4
	mov r0,#0x1	; 037FC1D6
	orr r1,r0	; 037FC1D8
	strh r1,[r2,#0x0]	; 037FC1DA
	b P2_Entry_037FC1E8	; 037FC1DC
P2_Entry_037FC1DE:
	ldr r2,[pool_037FC2DC]	; 037FC1DE
	ldrh r1,[r2,#0x0]	; 037FC1E0
	mov r0,#0x1	; 037FC1E2
	bic r1,r0	; 037FC1E4
	strh r1,[r2,#0x0]	; 037FC1E6
P2_Entry_037FC1E8:
	ldr r0,[pool_037FC2E0]	; 037FC1E8
	ldrh r0,[r0,#0x0]	; 037FC1EA
	cmp r0,#0xa	; 037FC1EC
	bls P2_Entry_037FC1F6	; 037FC1EE
	mov r1,#0x0	; 037FC1F0
	ldr r0,[pool_037FC2E4]	; 037FC1F2
	strh r1,[r0,#0x0]	; 037FC1F4
P2_Entry_037FC1F6:
	add r0,r5,#0x0	; 037FC1F6
	add r0,#0x72	; 037FC1F8
	ldrh r0,[r0,#0x0]	; 037FC1FA
	sub r1,r0,#0x1	; 037FC1FC
	add r0,r5,#0x0	; 037FC1FE
	add r0,#0x72	; 037FC200
	strh r1,[r0,#0x0]	; 037FC202
	add r0,r5,#0x0	; 037FC204
	add r0,#0x72	; 037FC206
	ldrh r0,[r0,#0x0]	; 037FC208
	cmp r0,#0x0	; 037FC20A
	bne P2_Entry_037FC21A	; 037FC20C
	add r0,r5,#0x0	; 037FC20E
	add r0,#0x70	; 037FC210
	ldrh r1,[r0,#0x0]	; 037FC212
	add r0,r5,#0x0	; 037FC214
	add r0,#0x72	; 037FC216
	strh r1,[r0,#0x0]	; 037FC218
P2_Entry_037FC21A:
	add r0,r5,#0x0	; 037FC21A
	add r0,#0x76	; 037FC21C
	ldrh r2,[r0,#0x0]	; 037FC21E
	add r0,r5,#0x0	; 037FC220
	add r0,#0x76	; 037FC222
	ldrh r0,[r0,#0x0]	; 037FC224
	sub r1,r0,#0x1	; 037FC226
	add r0,r5,#0x0	; 037FC228
	add r0,#0x76	; 037FC22A
	strh r1,[r0,#0x0]	; 037FC22C
	cmp r2,#0x0	; 037FC22E
	bne P2_Entry_037FC240	; 037FC230
	add r0,r5,#0x0	; 037FC232
	add r0,#0x74	; 037FC234
	ldrh r0,[r0,#0x0]	; 037FC236
	sub r1,r0,#0x1	; 037FC238
	add r0,r5,#0x0	; 037FC23A
	add r0,#0x76	; 037FC23C
	strh r1,[r0,#0x0]	; 037FC23E
P2_Entry_037FC240:
	mov r6,#0x0	; 037FC240
	str r6,[sp,#0x4]	; 037FC242
P2_Entry_037FC244:
	add r1,r6,#0x0	; 037FC244
	mov r0,#0x14	; 037FC246
	mul r1,r0	; 037FC248
	add r7,r4,r1	; 037FC24A
	ldrh r0,[r4,r1]	; 037FC24C
	cmp r0,#0x0	; 037FC24E
	beq P2_Entry_037FC294	; 037FC250
	ldr r0,[r7,#0xc]	; 037FC252
	ldrh r1,[r0,#0x8]	; 037FC254
	cmp r1,#0x0	; 037FC256
	bne P2_Entry_037FC294	; 037FC258
	add r1,r5,#0x0	; 037FC25A
	add r1,#0xa8	; 037FC25C
	ldr r1,[r1,#0x0]	; 037FC25E
	ldrh r0,[r0,#0x4]	; 037FC260
	sub r0,r1,r0	; 037FC262
	lsl r0,r0,#0x10	; 037FC264
	lsr r1,r0,#0x10	; 037FC266
	add r0,r5,#0x0	; 037FC268
	add r0,#0x8c	; 037FC26A
	ldrh r0,[r0,#0x0]	; 037FC26C
	cmp r1,r0	; 037FC26E
	bls P2_Entry_037FC294	; 037FC270
	add r0,r6,#0x0	; 037FC272
	bl P2_Entry_037FCD28	; 037FC274
	ldr r1,[r7,#0x8]	; 037FC278
	mov r0,#0x2	; 037FC27A
	strh r0,[r1,#0x0]	; 037FC27C
	ldr r0,[sp,#0x4]	; 037FC27E
	mov r1,#0xe	; 037FC280
	bl loc_037FB3CC	; 037FC282
	add r0,r4,#0x0	; 037FC286
	add r0,#0xb0	; 037FC288
	ldrh r0,[r0,#0x0]	; 037FC28A
	add r1,r0,#0x1	; 037FC28C
	add r0,r4,#0x0	; 037FC28E
	add r0,#0xb0	; 037FC290
	strh r1,[r0,#0x0]	; 037FC292
P2_Entry_037FC294:
	add r6,r6,#0x1	; 037FC294
	cmp r6,#0x2	; 037FC296
	bcc P2_Entry_037FC244	; 037FC298
	mov r1,#0xd	; 037FC29A
	ldr r0,[pool_037FC2E8]	; 037FC29C
	strh r1,[r0,#0x0]	; 037FC29E
P2_Entry_037FC2A0:
	add sp,#0xc	; 037FC2A0
	pop {r4,r5,r6,r7}	; 037FC2A2
	pop {r3}	; 037FC2A4
	bx r3	; 037FC2A6
pool_037FC2A8:
	.word FirmwareWlWorkPointerSlot	; 037FC2A8
pool_037FC2AC:
	.word 0x00000318	; 037FC2AC
pool_037FC2B0:
	.word 0x000002F0	; 037FC2B0
pool_037FC2B4:
	.word 0x00000400	; 037FC2B4
pool_037FC2B8:
	.word 0x00004000	; 037FC2B8
pool_037FC2BC:
	.word REG_WIFI_IF	; 037FC2BC
pool_037FC2C0:
	.word FirmwareWlAdjustedTimeSlot	; 037FC2C0
pool_037FC2C4:
	.word REG_WIFI_POST_BEACON	; 037FC2C4
pool_037FC2C8:
	.word 0x00000506	; 037FC2C8
pool_037FC2CC:
	.word 0x0000050A	; 037FC2CC
pool_037FC2D0:
	.word 0x00000508	; 037FC2D0
pool_037FC2D4:
	.word REG_WIFI_TXBUSY	; 037FC2D4
pool_037FC2D8:
	.word 0x0000FFFF	; 037FC2D8
pool_037FC2DC:
	.word REG_WIFI_POWER_TX	; 037FC2DC
pool_037FC2E0:
	.word REG_WIFI_CMD_COUNT	; 037FC2E0
pool_037FC2E4:
	.word REG_WIFI_UNKNOWN_048	; 037FC2E4
pool_037FC2E8:
	.word REG_WIFI_TXREQ_SET	; 037FC2E8
P2_Entry_037FC2EC:
	bx pc	; 037FC2EC
	.byte 0xC0, 0x46	; 037FC2EE
.arm
	ldr r12,[pool_037FC2F8]	; 037FC2F0
	bx r12	; 037FC2F4
pool_037FC2F8:
	.word loc_023051A4 + 1	; 037FC2F8
P2_Entry_037FC2FC:
.thumb
	ldr r0,[pool_037FC33C]	; 037FC2FC
	ldr r1,[r0,#0x0]	; 037FC2FE
	ldr r0,[pool_037FC340]	; 037FC300
	add r0,r1,r0	; 037FC302
	ldr r2,[pool_037FC344]	; 037FC304
	ldr r1,[pool_037FC348]	; 037FC306
	strh r2,[r1,#0x0]	; 037FC308
	mov r2,#0xd	; 037FC30A
	ldr r1,[pool_037FC34C]	; 037FC30C
	strh r2,[r1,#0x0]	; 037FC30E
	ldrh r1,[r0,#0x1a]	; 037FC310
	cmp r1,#0x1	; 037FC312
	bne P2_Entry_037FC31C	; 037FC314
	mov r1,#0x2	; 037FC316
	strh r1,[r0,#0x1a]	; 037FC318
	bx lr	; 037FC31A
P2_Entry_037FC31C:
	cmp r1,#0x2	; 037FC31C
	bne P2_Entry_037FC326	; 037FC31E
	mov r1,#0x0	; 037FC320
	strh r1,[r0,#0x1a]	; 037FC322
	bx lr	; 037FC324
P2_Entry_037FC326:
	ldrh r1,[r0,#0xc]	; 037FC326
	cmp r1,#0x2	; 037FC328
	bne P2_Entry_037FC338	; 037FC32A
	ldrh r0,[r0,#0x8]	; 037FC32C
	cmp r0,#0x40	; 037FC32E
	beq P2_Entry_037FC338	; 037FC330
	mov r1,#0x0	; 037FC332
	ldr r0,[pool_037FC350]	; 037FC334
	strh r1,[r0,#0x0]	; 037FC336
P2_Entry_037FC338:
	bx lr	; 037FC338
	.byte 0xC0, 0x46	; 037FC33A
pool_037FC33C:
	.word FirmwareWlWorkPointerSlot	; 037FC33C
pool_037FC340:
	.word 0x00000318	; 037FC340
pool_037FC344:
	.word 0x00002000	; 037FC344
pool_037FC348:
	.word REG_WIFI_IF	; 037FC348
pool_037FC34C:
	.word REG_WIFI_TXREQ_RESET	; 037FC34C
pool_037FC350:
	.word REG_WIFI_UNKNOWN_048	; 037FC350
P2_Entry_037FC354:
	push {lr}	; 037FC354
	sub sp,#0x4	; 037FC356
	bl P2_Entry_037FC37C	; 037FC358
	ldr r1,[pool_037FC370]	; 037FC35C
	ldr r0,[pool_037FC374]	; 037FC35E
	strh r1,[r0,#0x0]	; 037FC360
	mov r1,#0x30	; 037FC362
	ldr r0,[pool_037FC378]	; 037FC364
	strh r1,[r0,#0x0]	; 037FC366
	add sp,#0x4	; 037FC368
	pop {r3}	; 037FC36A
	bx r3	; 037FC36C
	.byte 0xC0, 0x46	; 037FC36E
pool_037FC370:
	.word 0x0000FFFF	; 037FC370
pool_037FC374:
	.word REG_WIFI_RXSTAT_OVF_IF	; 037FC374
pool_037FC378:
	.word REG_WIFI_IF	; 037FC378
P2_Entry_037FC37C:
	bx pc	; 037FC37C
	.byte 0xC0, 0x46	; 037FC37E
.arm
	ldr r12,[pool_037FC388]	; 037FC380
	bx r12	; 037FC384
pool_037FC388:
	.word P4_Entry_02305958 + 1	; 037FC388
P2_Entry_037FC38C:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC38C
	sub sp,#0x4	; 037FC38E
	mov r1,#0x8	; 037FC390
	ldr r0,[pool_037FC43C]	; 037FC392
	strh r1,[r0,#0x0]	; 037FC394
	ldr r0,[pool_037FC440]	; 037FC396
	ldr r1,[r0,#0x0]	; 037FC398
	ldr r0,[pool_037FC444]	; 037FC39A
	ldrh r0,[r1,r0]	; 037FC39C
	lsl r0,r0,#0x1b	; 037FC39E
	lsr r0,r0,#0x1f	; 037FC3A0
	cmp r0,#0x0	; 037FC3A2
	beq P2_Entry_037FC3BA	; 037FC3A4
	ldr r0,[pool_037FC448]	; 037FC3A6
	ldrh r1,[r0,#0x0]	; 037FC3A8
	mov r0,#0x1	; 037FC3AA
	and r1,r0	; 037FC3AC
	cmp r1,#0x0	; 037FC3AE
	bne P2_Entry_037FC3BA	; 037FC3B0
	ldr r2,[pool_037FC44C]	; 037FC3B2
	ldrh r1,[r2,#0x0]	; 037FC3B4
	eor r1,r0	; 037FC3B6
	strh r1,[r2,#0x0]	; 037FC3B8
P2_Entry_037FC3BA:
	ldr r0,[pool_037FC440]	; 037FC3BA
	ldr r2,[r0,#0x0]	; 037FC3BC
	ldr r0,[pool_037FC450]	; 037FC3BE
	ldrh r1,[r2,r0]	; 037FC3C0
	mov r0,#0x8	; 037FC3C2
	and r1,r0	; 037FC3C4
	cmp r1,#0x0	; 037FC3C6
	beq P2_Entry_037FC432	; 037FC3C8
	ldr r0,[pool_037FC454]	; 037FC3CA
	add r5,r2,r0	; 037FC3CC
	ldr r0,[pool_037FC458]	; 037FC3CE
	add r4,r2,r0	; 037FC3D0
	mov r6,#0x0	; 037FC3D2
	add r1,r6,#0x0	; 037FC3D4
	ldr r0,[pool_037FC45C]	; 037FC3D6
P2_Entry_037FC3D8:
	add r3,r6,#0x0	; 037FC3D8
	mov r2,#0x14	; 037FC3DA
	mul r3,r2	; 037FC3DC
	add r7,r4,r3	; 037FC3DE
	ldrh r2,[r4,r3]	; 037FC3E0
	cmp r2,#0x0	; 037FC3E2
	beq P2_Entry_037FC42C	; 037FC3E4
	ldr r3,[r7,#0x8]	; 037FC3E6
	ldrh r7,[r3,#0xc]	; 037FC3E8
	ldr r2,[pool_037FC460]	; 037FC3EA
	and r7,r2	; 037FC3EC
	cmp r7,#0x0	; 037FC3EE
	beq P2_Entry_037FC42C	; 037FC3F0
	ldrh r7,[r3,#0x4]	; 037FC3F2
	mov r2,#0xff	; 037FC3F4
	and r7,r2	; 037FC3F6
	cmp r7,#0x0	; 037FC3F8
	beq P2_Entry_037FC42C	; 037FC3FA
	add r7,r3,#0x0	; 037FC3FC
	add r7,#0xc	; 037FC3FE
	ldrh r2,[r3,#0xa]	; 037FC400
	add r2,r7,r2	; 037FC402
	sub r2,r2,#0x7	; 037FC404
	mov r7,#0x1	; 037FC406
	bic r2,r7	; 037FC408
	ldrh r7,[r2,#0x0]	; 037FC40A
	cmp r7,#0x0	; 037FC40C
	bne P2_Entry_037FC42C	; 037FC40E
	ldrh r2,[r2,#0x2]	; 037FC410
	cmp r2,#0x0	; 037FC412
	bne P2_Entry_037FC42C	; 037FC414
	strh r1,[r3,#0x4]	; 037FC416
	strh r1,[r0,#0x0]	; 037FC418
	ldr r2,[pool_037FC464]	; 037FC41A
	strh r2,[r0,#0x0]	; 037FC41C
	add r2,r5,#0x0	; 037FC41E
	add r2,#0xba	; 037FC420
	ldrh r2,[r2,#0x0]	; 037FC422
	add r3,r2,#0x1	; 037FC424
	add r2,r5,#0x0	; 037FC426
	add r2,#0xba	; 037FC428
	strh r3,[r2,#0x0]	; 037FC42A
P2_Entry_037FC42C:
	add r6,r6,#0x1	; 037FC42C
	cmp r6,#0x3	; 037FC42E
	bcc P2_Entry_037FC3D8	; 037FC430
P2_Entry_037FC432:
	add sp,#0x4	; 037FC432
	pop {r4,r5,r6,r7}	; 037FC434
	pop {r3}	; 037FC436
	bx r3	; 037FC438
	.byte 0xC0, 0x46	; 037FC43A
pool_037FC43C:
	.word REG_WIFI_IF	; 037FC43C
pool_037FC440:
	.word FirmwareWlWorkPointerSlot	; 037FC440
pool_037FC444:
	.word 0x0000030E	; 037FC444
pool_037FC448:
	.word REG_WIFI_RF_PINS	; 037FC448
pool_037FC44C:
	.word REG_WIFI_UNKNOWN_290	; 037FC44C
pool_037FC450:
	.word 0x00000638	; 037FC450
pool_037FC454:
	.word 0x00000318	; 037FC454
pool_037FC458:
	.word 0x00000400	; 037FC458
pool_037FC45C:
	.word 0x04808032	; 037FC45C
pool_037FC460:
	.word 0x00004000	; 037FC460
pool_037FC464:
	.word 0x00008000	; 037FC464
P2_Entry_037FC468:
	push {r4,r5,lr}	; 037FC468
	sub sp,#0x4	; 037FC46A
	ldr r0,[pool_037FC564]	; 037FC46C
	ldr r2,[r0,#0x0]	; 037FC46E
	ldr r1,[pool_037FC568]	; 037FC470
	add r3,r2,r1	; 037FC472
	ldr r4,[pool_037FC56C]	; 037FC474
	add r2,r2,r4	; 037FC476
	mov r5,#0x4	; 037FC478
	ldr r1,[pool_037FC570]	; 037FC47A
	strh r5,[r1,#0x0]	; 037FC47C
	ldr r1,[pool_037FC574]	; 037FC47E
	ldrh r1,[r1,#0x0]	; 037FC480
	ldr r5,[r0,#0x0]	; 037FC482
	ldr r0,[pool_037FC578]	; 037FC484
	ldrh r5,[r5,r0]	; 037FC486
	mov r0,#0x8	; 037FC488
	and r5,r0	; 037FC48A
	cmp r5,#0x0	; 037FC48C
	beq P2_Entry_037FC508	; 037FC48E
	add r0,r1,#0x0	; 037FC490
	and r0,r4	; 037FC492
	cmp r0,#0x0	; 037FC494
	beq P2_Entry_037FC508	; 037FC496
	ldr r0,[pool_037FC57C]	; 037FC498
	ldrh r0,[r0,#0x0]	; 037FC49A
	mov r4,#0x1	; 037FC49C
	add r5,r0,#0x0	; 037FC49E
	and r5,r4	; 037FC4A0
	cmp r5,#0x0	; 037FC4A2
	beq P2_Entry_037FC4AC	; 037FC4A4
	ldrh r4,[r2,#0x0]	; 037FC4A6
	cmp r4,#0x0	; 037FC4A8
	bne P2_Entry_037FC4E4	; 037FC4AA
P2_Entry_037FC4AC:
	mov r4,#0x4	; 037FC4AC
	add r5,r0,#0x0	; 037FC4AE
	and r5,r4	; 037FC4B0
	cmp r5,#0x0	; 037FC4B2
	beq P2_Entry_037FC4BC	; 037FC4B4
	ldrh r4,[r2,#0x14]	; 037FC4B6
	cmp r4,#0x0	; 037FC4B8
	bne P2_Entry_037FC4E4	; 037FC4BA
P2_Entry_037FC4BC:
	mov r4,#0x8	; 037FC4BC
	and r0,r4	; 037FC4BE
	cmp r0,#0x0	; 037FC4C0
	beq P2_Entry_037FC4CA	; 037FC4C2
	ldrh r0,[r2,#0x28]	; 037FC4C4
	cmp r0,#0x0	; 037FC4C6
	bne P2_Entry_037FC4E4	; 037FC4C8
P2_Entry_037FC4CA:
	ldr r0,[pool_037FC580]	; 037FC4CA
	ldrh r2,[r0,#0x0]	; 037FC4CC
	mov r0,#0x1	; 037FC4CE
	and r2,r0	; 037FC4D0
	cmp r2,#0x0	; 037FC4D2
	bne P2_Entry_037FC4E4	; 037FC4D4
	mov r4,#0x0	; 037FC4D6
	ldr r2,[pool_037FC584]	; 037FC4D8
	strh r4,[r2,#0x0]	; 037FC4DA
	ldr r0,[pool_037FC588]	; 037FC4DC
	strh r0,[r2,#0x0]	; 037FC4DE
	strh r4,[r3,#0x2]	; 037FC4E0
	b P2_Entry_037FC508	; 037FC4E2
P2_Entry_037FC4E4:
	ldrh r2,[r3,#0x2]	; 037FC4E4
	add r0,r2,#0x1	; 037FC4E6
	strh r0,[r3,#0x2]	; 037FC4E8
	cmp r2,#0xc	; 037FC4EA
	bls P2_Entry_037FC508	; 037FC4EC
	mov r0,#0x0	; 037FC4EE
	strh r0,[r3,#0x2]	; 037FC4F0
	ldr r2,[pool_037FC584]	; 037FC4F2
	strh r0,[r2,#0x0]	; 037FC4F4
	ldr r0,[pool_037FC588]	; 037FC4F6
	strh r0,[r2,#0x0]	; 037FC4F8
	ldr r0,[pool_037FC564]	; 037FC4FA
	ldr r2,[r0,#0x0]	; 037FC4FC
	ldr r0,[pool_037FC58C]	; 037FC4FE
	add r0,r2,r0	; 037FC500
	ldrh r2,[r0,#0x0]	; 037FC502
	add r2,r2,#0x1	; 037FC504
	strh r2,[r0,#0x0]	; 037FC506
P2_Entry_037FC508:
	ldr r0,[pool_037FC564]	; 037FC508
	ldr r2,[r0,#0x0]	; 037FC50A
	ldr r0,[pool_037FC578]	; 037FC50C
	ldrh r2,[r2,r0]	; 037FC50E
	mov r0,#0x1	; 037FC510
	and r2,r0	; 037FC512
	cmp r2,#0x0	; 037FC514
	beq P2_Entry_037FC55A	; 037FC516
	mov r0,#0x60	; 037FC518
	and r1,r0	; 037FC51A
	cmp r1,#0x0	; 037FC51C
	beq P2_Entry_037FC55A	; 037FC51E
	ldr r0,[pool_037FC590]	; 037FC520
	ldrh r4,[r0,#0x0]	; 037FC522
	ldr r0,[pool_037FC594]	; 037FC524
	ldrh r1,[r0,#0x0]	; 037FC526
	ldr r0,[pool_037FC598]	; 037FC528
	sub r0,r1,r0	; 037FC52A
	mov r1,#0x2	; 037FC52C
	bl P2_Entry_037FC5B0	; 037FC52E
	cmp r4,r0	; 037FC532
	bge P2_Entry_037FC548	; 037FC534
	ldr r0,[pool_037FC59C]	; 037FC536
	ldrh r1,[r0,#0x0]	; 037FC538
	ldr r0,[pool_037FC598]	; 037FC53A
	sub r0,r1,r0	; 037FC53C
	mov r1,#0x2	; 037FC53E
	bl P2_Entry_037FC5BC	; 037FC540
	cmp r4,r0	; 037FC544
	bge P2_Entry_037FC556	; 037FC546
P2_Entry_037FC548:
	ldr r0,[pool_037FC5A0]	; 037FC548
	ldrh r1,[r0,#0x0]	; 037FC54A
	ldr r0,[pool_037FC5A4]	; 037FC54C
	strh r1,[r0,#0x0]	; 037FC54E
	ldr r1,[pool_037FC5A8]	; 037FC550
	ldr r0,[pool_037FC5AC]	; 037FC552
	strh r1,[r0,#0x0]	; 037FC554
P2_Entry_037FC556:
	bl P2_Entry_037FC5C8	; 037FC556
P2_Entry_037FC55A:
	add sp,#0x4	; 037FC55A
	pop {r4,r5}	; 037FC55C
	pop {r3}	; 037FC55E
	bx r3	; 037FC560
	.byte 0xC0, 0x46	; 037FC562
pool_037FC564:
	.word FirmwareWlWorkPointerSlot	; 037FC564
pool_037FC568:
	.word 0x000004B4	; 037FC568
pool_037FC56C:
	.word 0x00000400	; 037FC56C
pool_037FC570:
	.word REG_WIFI_IF	; 037FC570
pool_037FC574:
	.word REG_WIFI_RXSTAT_INC_IF	; 037FC574
pool_037FC578:
	.word 0x00000638	; 037FC578
pool_037FC57C:
	.word REG_WIFI_TXREQ_READ	; 037FC57C
pool_037FC580:
	.word REG_WIFI_RF_PINS	; 037FC580
pool_037FC584:
	.word REG_WIFI_WEP_CNT	; 037FC584
pool_037FC588:
	.word 0x00008000	; 037FC588
pool_037FC58C:
	.word 0x000003D2	; 037FC58C
pool_037FC590:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC590
pool_037FC594:
	.word REG_WIFI_RXBUF_END	; 037FC594
pool_037FC598:
	.word 0x00004000	; 037FC598
pool_037FC59C:
	.word REG_WIFI_RXBUF_BEGIN	; 037FC59C
pool_037FC5A0:
	.word REG_WIFI_RXBUF_READCSR	; 037FC5A0
pool_037FC5A4:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FC5A4
pool_037FC5A8:
	.word 0x00008001	; 037FC5A8
pool_037FC5AC:
	.word REG_WIFI_RXCNT	; 037FC5AC
P2_Entry_037FC5B0:
	bx pc	; 037FC5B0
	.byte 0xC0, 0x46	; 037FC5B2
.arm
	ldr pc,[pool_037FC5B8]	; 037FC5B4
pool_037FC5B8:
	.word P2_SignedDivMod	; 037FC5B8
P2_Entry_037FC5BC:
.thumb
	bx pc	; 037FC5BC
	.byte 0xC0, 0x46	; 037FC5BE
.arm
	ldr pc,[pool_037FC5C4]	; 037FC5C0
pool_037FC5C4:
	.word P2_SignedDivMod	; 037FC5C4
P2_Entry_037FC5C8:
.thumb
	bx pc	; 037FC5C8
	.byte 0xC0, 0x46	; 037FC5CA
.arm
	ldr r12,[pool_037FC5D4]	; 037FC5CC
	bx r12	; 037FC5D0
pool_037FC5D4:
	.word P4_Entry_02304F50 + 1	; 037FC5D4
P2_Entry_037FC5D8:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC5D8
	sub sp,#0x4	; 037FC5DA
	ldr r2,[pool_037FC750]	; 037FC5DC
	ldr r1,[r2,#0x0]	; 037FC5DE
	ldr r0,[pool_037FC754]	; 037FC5E0
	add r5,r1,r0	; 037FC5E2
	mov r1,#0x2	; 037FC5E4
	ldr r0,[pool_037FC758]	; 037FC5E6
	strh r1,[r0,#0x0]	; 037FC5E8
	ldr r0,[r2,#0x0]	; 037FC5EA
	ldr r2,[pool_037FC75C]	; 037FC5EC
	ldrh r2,[r0,r2]	; 037FC5EE
	cmp r2,#0x12	; 037FC5F0
	bne P2_Entry_037FC5FA	; 037FC5F2
	bl P2_Entry_037FC7A0	; 037FC5F4
	b P2_Entry_037FC746	; 037FC5F8
P2_Entry_037FC5FA:
	ldr r2,[pool_037FC760]	; 037FC5FA
	ldrh r4,[r2,#0x0]	; 037FC5FC
	ldr r2,[pool_037FC764]	; 037FC5FE
	and r4,r2	; 037FC600
	ldr r2,[pool_037FC768]	; 037FC602
	cmp r4,r2	; 037FC604
	beq P2_Entry_037FC616	; 037FC606
	ldr r2,[pool_037FC76C]	; 037FC608
	cmp r4,r2	; 037FC60A
	beq P2_Entry_037FC63E	; 037FC60C
	ldr r1,[pool_037FC770]	; 037FC60E
	cmp r4,r1	; 037FC610
	beq P2_Entry_037FC674	; 037FC612
	b P2_Entry_037FC6EA	; 037FC614
P2_Entry_037FC616:
	add r0,r5,#0x0	; 037FC616
	add r0,#0x8c	; 037FC618
	ldr r0,[r0,#0x0]	; 037FC61A
	and r0,r1	; 037FC61C
	cmp r0,#0x0	; 037FC61E
	beq P2_Entry_037FC626	; 037FC620
	bl P2_Entry_037FCCC8	; 037FC622
P2_Entry_037FC626:
	ldr r0,[pool_037FC750]	; 037FC626
	ldr r1,[r0,#0x0]	; 037FC628
	ldr r0,[pool_037FC774]	; 037FC62A
	add r0,r1,r0	; 037FC62C
	ldr r1,[r0,#0x0]	; 037FC62E
	add r1,r1,#0x1	; 037FC630
	str r1,[r0,#0x0]	; 037FC632
	mov r0,#0x0	; 037FC634
	mov r1,#0x8	; 037FC636
	bl loc_037FB3CC	; 037FC638
	b P2_Entry_037FC6EA	; 037FC63C
P2_Entry_037FC63E:
	add r0,r5,#0x0	; 037FC63E
	add r0,#0x9e	; 037FC640
	ldrh r0,[r0,#0x0]	; 037FC642
	ldr r2,[r5,#0x44]	; 037FC644
	ldrh r3,[r2,#0x4]	; 037FC646
	mov r2,#0xff	; 037FC648
	and r3,r2	; 037FC64A
	lsl r2,r3,#0x10	; 037FC64C
	lsr r2,r2,#0x10	; 037FC64E
	cmp r0,r2	; 037FC650
	bhi P2_Entry_037FC666	; 037FC652
	ldr r0,[pool_037FC778]	; 037FC654
	strh r1,[r0,#0x0]	; 037FC656
	add r0,r5,#0x0	; 037FC658
	add r0,#0xaa	; 037FC65A
	ldrh r0,[r0,#0x0]	; 037FC65C
	add r1,r0,#0x1	; 037FC65E
	add r0,r5,#0x0	; 037FC660
	add r0,#0xaa	; 037FC662
	strh r1,[r0,#0x0]	; 037FC664
P2_Entry_037FC666:
	add r0,r5,#0x0	; 037FC666
	add r0,#0x90	; 037FC668
	ldr r1,[r0,#0x0]	; 037FC66A
	ldrh r0,[r1,#0x18]	; 037FC66C
	add r0,r0,#0x1	; 037FC66E
	strh r0,[r1,#0x18]	; 037FC670
	b P2_Entry_037FC6EA	; 037FC672
P2_Entry_037FC674:
	add r1,r5,#0x0	; 037FC674
	add r1,#0x98	; 037FC676
	ldrh r6,[r1,#0x0]	; 037FC678
	ldr r1,[r5,#0x44]	; 037FC67A
	ldrh r3,[r1,#0x2]	; 037FC67C
	add r1,r5,#0x0	; 037FC67E
	add r1,#0x90	; 037FC680
	ldr r2,[r1,#0x0]	; 037FC682
	add r2,#0x1a	; 037FC684
	cmp r3,#0x1	; 037FC686
	bls P2_Entry_037FC6AA	; 037FC688
	ldr r1,[pool_037FC77C]	; 037FC68A
	ldrh r0,[r0,r1]	; 037FC68C
	lsl r0,r0,#0x1b	; 037FC68E
	lsr r0,r0,#0x1f	; 037FC690
	cmp r0,#0x0	; 037FC692
	beq P2_Entry_037FC6AA	; 037FC694
	ldr r0,[pool_037FC780]	; 037FC696
	ldrh r0,[r0,#0x0]	; 037FC698
	mov r7,#0x1	; 037FC69A
	and r0,r7	; 037FC69C
	cmp r0,#0x0	; 037FC69E
	bne P2_Entry_037FC6AA	; 037FC6A0
	ldr r1,[pool_037FC784]	; 037FC6A2
	ldrh r0,[r1,#0x0]	; 037FC6A4
	eor r0,r7	; 037FC6A6
	strh r0,[r1,#0x0]	; 037FC6A8
P2_Entry_037FC6AA:
	ldr r0,[pool_037FC750]	; 037FC6AA
	ldr r1,[r0,#0x0]	; 037FC6AC
	ldr r0,[pool_037FC788]	; 037FC6AE
	ldrh r1,[r1,r0]	; 037FC6B0
	mov r0,#0x40	; 037FC6B2
	and r1,r0	; 037FC6B4
	cmp r1,#0x0	; 037FC6B6
	beq P2_Entry_037FC6EA	; 037FC6B8
	mov r0,#0x1	; 037FC6BA
	b P2_Entry_037FC6E6	; 037FC6BC
P2_Entry_037FC6BE:
	lsl r1,r3,#0xf	; 037FC6BE
	lsr r3,r1,#0x10	; 037FC6C0
	add r1,r3,#0x0	; 037FC6C2
	and r1,r0	; 037FC6C4
	cmp r1,#0x0	; 037FC6C6
	beq P2_Entry_037FC6D0	; 037FC6C8
	ldrh r1,[r2,#0x6]	; 037FC6CA
	add r1,r1,#0x1	; 037FC6CC
	strh r1,[r2,#0x6]	; 037FC6CE
P2_Entry_037FC6D0:
	lsl r1,r6,#0xf	; 037FC6D0
	lsr r6,r1,#0x10	; 037FC6D2
	add r1,r6,#0x0	; 037FC6D4
	and r1,r0	; 037FC6D6
	cmp r1,#0x0	; 037FC6D8
	beq P2_Entry_037FC6E6	; 037FC6DA
	add r1,r5,#0x0	; 037FC6DC
	add r1,#0x90	; 037FC6DE
	ldr r1,[r1,#0x0]	; 037FC6E0
	ldrh r1,[r1,#0x16]	; 037FC6E2
	add r2,r2,r1	; 037FC6E4
P2_Entry_037FC6E6:
	cmp r3,#0x1	; 037FC6E6
	bhi P2_Entry_037FC6BE	; 037FC6E8
P2_Entry_037FC6EA:
	ldr r0,[pool_037FC76C]	; 037FC6EA
	cmp r4,r0	; 037FC6EC
	beq P2_Entry_037FC73E	; 037FC6EE
	ldr r0,[pool_037FC78C]	; 037FC6F0
	ldrh r1,[r0,#0x0]	; 037FC6F2
	mov r0,#0x2	; 037FC6F4
	and r1,r0	; 037FC6F6
	cmp r1,#0x0	; 037FC6F8
	bne P2_Entry_037FC73E	; 037FC6FA
	ldrh r1,[r5,#0x3c]	; 037FC6FC
	cmp r1,#0x0	; 037FC6FE
	beq P2_Entry_037FC738	; 037FC700
	ldr r1,[pool_037FC790]	; 037FC702
	strh r0,[r1,#0x0]	; 037FC704
	mov r2,#0x0	; 037FC706
	ldr r1,[pool_037FC794]	; 037FC708
	strh r2,[r1,#0x0]	; 037FC70A
	ldr r1,[pool_037FC758]	; 037FC70C
	ldrh r2,[r1,#0x0]	; 037FC70E
	ldr r1,[pool_037FC798]	; 037FC710
	and r2,r1	; 037FC712
	cmp r2,#0x0	; 037FC714
	bne P2_Entry_037FC71E	; 037FC716
	bl P2_Entry_037FC9A4	; 037FC718
	b P2_Entry_037FC72C	; 037FC71C
P2_Entry_037FC71E:
	add r0,r5,#0x0	; 037FC71E
	add r0,#0xae	; 037FC720
	ldrh r0,[r0,#0x0]	; 037FC722
	add r1,r0,#0x1	; 037FC724
	add r0,r5,#0x0	; 037FC726
	add r0,#0xae	; 037FC728
	strh r1,[r0,#0x0]	; 037FC72A
P2_Entry_037FC72C:
	add r0,r5,#0x0	; 037FC72C
	add r0,#0xac	; 037FC72E
	ldrh r0,[r0,#0x0]	; 037FC730
	add r0,r0,#0x1	; 037FC732
	add r5,#0xac	; 037FC734
	strh r0,[r5,#0x0]	; 037FC736
P2_Entry_037FC738:
	mov r1,#0x2	; 037FC738
	ldr r0,[pool_037FC79C]	; 037FC73A
	strh r1,[r0,#0x0]	; 037FC73C
P2_Entry_037FC73E:
	mov r0,#0x0	; 037FC73E
	mov r1,#0xe	; 037FC740
	bl loc_037FB3CC	; 037FC742
P2_Entry_037FC746:
	add sp,#0x4	; 037FC746
	pop {r4,r5,r6,r7}	; 037FC748
	pop {r3}	; 037FC74A
	bx r3	; 037FC74C
	.byte 0xC0, 0x46	; 037FC74E
pool_037FC750:
	.word FirmwareWlWorkPointerSlot	; 037FC750
pool_037FC754:
	.word 0x00000400	; 037FC754
pool_037FC758:
	.word REG_WIFI_IF	; 037FC758
pool_037FC75C:
	.word 0x00000320	; 037FC75C
pool_037FC760:
	.word REG_WIFI_TXSTAT	; 037FC760
pool_037FC764:
	.word 0x00000F00	; 037FC764
pool_037FC768:
	.word 0x00000300	; 037FC768
pool_037FC76C:
	.word 0x00000800	; 037FC76C
pool_037FC770:
	.word 0x00000B00	; 037FC770
pool_037FC774:
	.word 0x0000052C	; 037FC774
pool_037FC778:
	.word REG_WIFI_TXREQ_RESET	; 037FC778
pool_037FC77C:
	.word 0x0000030E	; 037FC77C
pool_037FC780:
	.word REG_WIFI_RF_PINS	; 037FC780
pool_037FC784:
	.word REG_WIFI_UNKNOWN_290	; 037FC784
pool_037FC788:
	.word 0x00000638	; 037FC788
pool_037FC78C:
	.word REG_WIFI_TXREQ_READ	; 037FC78C
pool_037FC790:
	.word REG_WIFI_TXBUF_RESET	; 037FC790
pool_037FC794:
	.word REG_WIFI_UNKNOWN_048	; 037FC794
pool_037FC798:
	.word 0x00001000	; 037FC798
pool_037FC79C:
	.word REG_WIFI_TXREQ_SET	; 037FC79C
P2_Entry_037FC7A0:
	bx pc	; 037FC7A0
	.byte 0xC0, 0x46	; 037FC7A2
.arm
	ldr r12,[pool_037FC7AC]	; 037FC7A4
	bx r12	; 037FC7A8
pool_037FC7AC:
	.word P4_Entry_02308C50 + 1	; 037FC7AC
P2_Entry_037FC7B0:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC7B0
	sub sp,#0x1c	; 037FC7B2
	ldr r0,[pool_037FC94C]	; 037FC7B4
	ldr r1,[r0,#0x0]	; 037FC7B6
	ldr r0,[pool_037FC950]	; 037FC7B8
	add r5,r1,r0	; 037FC7BA
	ldr r0,[pool_037FC954]	; 037FC7BC
	add r0,r1,r0	; 037FC7BE
	str r0,[sp,#0x0]	; 037FC7C0
	ldr r0,[pool_037FC958]	; 037FC7C2
	ldrh r6,[r1,r0]	; 037FC7C4
	mov r1,#0x1	; 037FC7C6
	ldr r0,[pool_037FC95C]	; 037FC7C8
	strh r1,[r0,#0x0]	; 037FC7CA
	and r6,r1	; 037FC7CC
P2_Entry_037FC7CE:
	ldr r0,[sp,#0x0]	; 037FC7CE
	ldrh r0,[r0,#0x4]	; 037FC7D0
	str r0,[sp,#0x8]	; 037FC7D2
	ldr r0,[pool_037FC960]	; 037FC7D4
	ldrh r0,[r0,#0x0]	; 037FC7D6
	str r0,[sp,#0xc]	; 037FC7D8
	ldr r1,[sp,#0x8]	; 037FC7DA
	cmp r1,r0	; 037FC7DC
	bne P2_Entry_037FC7E2	; 037FC7DE
	b P2_Entry_037FC912	; 037FC7E0
P2_Entry_037FC7E2:
	ldr r0,[pool_037FC964]	; 037FC7E2
	ldrh r1,[r0,#0x0]	; 037FC7E4
	ldr r0,[pool_037FC968]	; 037FC7E6
	ldrh r0,[r0,#0x0]	; 037FC7E8
	ldr r2,[pool_037FC964]	; 037FC7EA
	ldrh r3,[r2,#0x0]	; 037FC7EC
	ldr r2,[pool_037FC968]	; 037FC7EE
	ldrh r2,[r2,#0x0]	; 037FC7F0
	cmp r1,r3	; 037FC7F2
	bls P2_Entry_037FC7FE	; 037FC7F4
	lsr r4,r3,#0x4	; 037FC7F6
	lsl r0,r2,#0xc	; 037FC7F8
	orr r4,r0	; 037FC7FA
	b P2_Entry_037FC804	; 037FC7FC
P2_Entry_037FC7FE:
	lsr r4,r1,#0x4	; 037FC7FE
	lsl r0,r0,#0xc	; 037FC800
	orr r4,r0	; 037FC802
P2_Entry_037FC804:
	ldr r0,[sp,#0x8]	; 037FC804
	lsl r7,r0,#0x1	; 037FC806
	ldr r0,[pool_037FC96C]	; 037FC808
	add r0,r7,r0	; 037FC80A
	str r0,[sp,#0x4]	; 037FC80C
	add r0,r0,#0x2	; 037FC80E
	bl P2_Entry_037FCD84	; 037FC810
	str r0,[sp,#0x10]	; 037FC814
	add r0,r0,#0x2	; 037FC816
	bl P2_Entry_037FCD84	; 037FC818
	str r0,[sp,#0x14]	; 037FC81C
	add r0,r0,#0x4	; 037FC81E
	bl P2_Entry_037FCD84	; 037FC820
	add r2,r0,#0x0	; 037FC824
	ldr r0,[pool_037FC96C]	; 037FC826
	ldrh r1,[r7,r0]	; 037FC828
	ldr r0,[sp,#0x10]	; 037FC82A
	ldrh r0,[r0,#0x0]	; 037FC82C
	lsl r3,r0,#0x1	; 037FC82E
	ldr r0,[pool_037FC970]	; 037FC830
	and r3,r0	; 037FC832
	orr r1,r3	; 037FC834
	ldr r0,[pool_037FC96C]	; 037FC836
	strh r1,[r7,r0]	; 037FC838
	ldr r0,[sp,#0x14]	; 037FC83A
	strh r4,[r0,#0x0]	; 037FC83C
	ldrh r2,[r2,#0x0]	; 037FC83E
	ldr r0,[sp,#0x8]	; 037FC840
	lsl r0,r0,#0x1	; 037FC842
	add r0,r2,r0	; 037FC844
	add r0,#0xf	; 037FC846
	lsr r0,r0,#0x2	; 037FC848
	lsl r4,r0,#0x1	; 037FC84A
	ldr r0,[pool_037FC974]	; 037FC84C
	cmp r4,r0	; 037FC84E
	bcc P2_Entry_037FC85C	; 037FC850
	add r0,r5,#0x0	; 037FC852
	add r0,#0x9a	; 037FC854
	ldrh r0,[r0,#0x0]	; 037FC856
	lsr r0,r0,#0x1	; 037FC858
	sub r4,r4,r0	; 037FC85A
P2_Entry_037FC85C:
	ldr r0,[pool_037FC978]	; 037FC85C
	cmp r2,r0	; 037FC85E
	bls P2_Entry_037FC87A	; 037FC860
	ldr r1,[pool_037FC97C]	; 037FC862
	ldr r0,[sp,#0x4]	; 037FC864
	strh r1,[r0,#0x0]	; 037FC866
	ldr r4,[sp,#0xc]	; 037FC868
	add r0,r5,#0x0	; 037FC86A
	add r0,#0xb4	; 037FC86C
	ldrh r0,[r0,#0x0]	; 037FC86E
	add r1,r0,#0x1	; 037FC870
	add r0,r5,#0x0	; 037FC872
	add r0,#0xb4	; 037FC874
	strh r1,[r0,#0x0]	; 037FC876
	b P2_Entry_037FC8E2	; 037FC878
P2_Entry_037FC87A:
	cmp r6,#0x0	; 037FC87A
	beq P2_Entry_037FC8E2	; 037FC87C
	ldr r0,[sp,#0xc]	; 037FC87E
	cmp r4,r0	; 037FC880
	beq P2_Entry_037FC8E2	; 037FC882
	lsl r0,r4,#0x1	; 037FC884
	ldr r1,[pool_037FC96C]	; 037FC886
	add r1,r0,r1	; 037FC888
	ldr r3,[pool_037FC96C]	; 037FC88A
	ldrh r0,[r0,r3]	; 037FC88C
	ldr r3,[pool_037FC980]	; 037FC88E
	cmp r1,r3	; 037FC890
	bcs P2_Entry_037FC8A0	; 037FC892
	ldrh r3,[r1,#0x6]	; 037FC894
	mov r1,#0xff	; 037FC896
	and r3,r1	; 037FC898
	lsl r1,r3,#0x10	; 037FC89A
	lsr r3,r1,#0x10	; 037FC89C
	b P2_Entry_037FC8AA	; 037FC89E
P2_Entry_037FC8A0:
	add r3,r5,#0x0	; 037FC8A0
	add r3,#0x9a	; 037FC8A2
	ldrh r3,[r3,#0x0]	; 037FC8A4
	sub r1,r1,r3	; 037FC8A6
	ldrh r3,[r1,#0x6]	; 037FC8A8
P2_Entry_037FC8AA:
	ldr r1,[pool_037FC984]	; 037FC8AA
	and r0,r1	; 037FC8AC
	cmp r0,#0x0	; 037FC8AE
	bne P2_Entry_037FC8C0	; 037FC8B0
	cmp r3,#0xa	; 037FC8B2
	beq P2_Entry_037FC8BA	; 037FC8B4
	cmp r3,#0x14	; 037FC8B6
	bne P2_Entry_037FC8C0	; 037FC8B8
P2_Entry_037FC8BA:
	ldr r0,[pool_037FC988]	; 037FC8BA
	cmp r2,r0	; 037FC8BC
	bls P2_Entry_037FC8E2	; 037FC8BE
P2_Entry_037FC8C0:
	add r0,r5,#0x0	; 037FC8C0
	add r0,#0xb4	; 037FC8C2
	ldrh r0,[r0,#0x0]	; 037FC8C4
	add r0,r0,#0x1	; 037FC8C6
	add r5,#0xb4	; 037FC8C8
	strh r0,[r5,#0x0]	; 037FC8CA
	ldr r1,[pool_037FC97C]	; 037FC8CC
	ldr r0,[sp,#0x4]	; 037FC8CE
	strh r1,[r0,#0x0]	; 037FC8D0
	ldr r0,[sp,#0xc]	; 037FC8D2
	lsl r0,r0,#0x10	; 037FC8D4
	lsr r1,r0,#0x10	; 037FC8D6
	ldr r0,[sp,#0x0]	; 037FC8D8
	strh r1,[r0,#0x4]	; 037FC8DA
	ldr r0,[sp,#0x10]	; 037FC8DC
	strh r1,[r0,#0x0]	; 037FC8DE
	b P2_Entry_037FC912	; 037FC8E0
P2_Entry_037FC8E2:
	ldr r0,[sp,#0x4]	; 037FC8E2
	ldrh r1,[r0,#0x0]	; 037FC8E4
	mov r0,#0xf	; 037FC8E6
	and r1,r0	; 037FC8E8
	cmp r1,#0xc	; 037FC8EA
	bne P2_Entry_037FC904	; 037FC8EC
	bl P2_Entry_037FCDA4	; 037FC8EE
	cmp r0,#0x0	; 037FC8F2
	bne P2_Entry_037FC904	; 037FC8F4
	ldr r0,[pool_037FC94C]	; 037FC8F6
	ldr r0,[r0,#0x0]	; 037FC8F8
	ldr r1,[pool_037FC98C]	; 037FC8FA
	ldr r1,[r0,r1]	; 037FC8FC
	add r2,r1,#0x1	; 037FC8FE
	ldr r1,[pool_037FC98C]	; 037FC900
	str r2,[r0,r1]	; 037FC902
P2_Entry_037FC904:
	lsl r0,r4,#0x10	; 037FC904
	lsr r1,r0,#0x10	; 037FC906
	ldr r0,[sp,#0x0]	; 037FC908
	strh r1,[r0,#0x4]	; 037FC90A
	ldr r0,[sp,#0x10]	; 037FC90C
	strh r1,[r0,#0x0]	; 037FC90E
	b P2_Entry_037FC7CE	; 037FC910
P2_Entry_037FC912:
	cmp r6,#0x0	; 037FC912
	beq P2_Entry_037FC930	; 037FC914
	ldr r0,[pool_037FC960]	; 037FC916
	ldrh r4,[r0,#0x0]	; 037FC918
	bl P2_Entry_037FCDA4	; 037FC91A
	cmp r0,#0x0	; 037FC91E
	beq P2_Entry_037FC930	; 037FC920
	ldr r0,[pool_037FC960]	; 037FC922
	ldrh r0,[r0,#0x0]	; 037FC924
	cmp r4,r0	; 037FC926
	bne P2_Entry_037FC930	; 037FC928
	mov r0,#0x20	; 037FC92A
	bl P2_Entry_037FC994	; 037FC92C
P2_Entry_037FC930:
	ldr r0,[pool_037FC990]	; 037FC930
	ldrh r1,[r0,#0x0]	; 037FC932
	ldr r0,[pool_037FC960]	; 037FC934
	ldrh r0,[r0,#0x0]	; 037FC936
	cmp r1,r0	; 037FC938
	beq P2_Entry_037FC944	; 037FC93A
	mov r0,#0x0	; 037FC93C
	mov r1,#0xf	; 037FC93E
	bl loc_037FB3CC	; 037FC940
P2_Entry_037FC944:
	add sp,#0x1c	; 037FC944
	pop {r4,r5,r6,r7}	; 037FC946
	pop {r3}	; 037FC948
	bx r3	; 037FC94A
pool_037FC94C:
	.word FirmwareWlWorkPointerSlot	; 037FC94C
pool_037FC950:
	.word 0x00000318	; 037FC950
pool_037FC954:
	.word 0x000004B4	; 037FC954
pool_037FC958:
	.word 0x00000638	; 037FC958
pool_037FC95C:
	.word REG_WIFI_IF	; 037FC95C
pool_037FC960:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC960
pool_037FC964:
	.word REG_WIFI_US_COUNT0	; 037FC964
pool_037FC968:
	.word REG_WIFI_US_COUNT1	; 037FC968
pool_037FC96C:
	.word 0x04804000	; 037FC96C
pool_037FC970:
	.word 0x00000400	; 037FC970
pool_037FC974:
	.word 0x00000FB0	; 037FC974
pool_037FC978:
	.word 0x0000092C	; 037FC978
pool_037FC97C:
	.word 0x0000FFFF	; 037FC97C
pool_037FC980:
	.word 0x04805F5A	; 037FC980
pool_037FC984:
	.word 0x00007C00	; 037FC984
pool_037FC988:
	.word 0x00000FFF	; 037FC988
pool_037FC98C:
	.word 0x0000057C	; 037FC98C
pool_037FC990:
	.word REG_WIFI_RXBUF_READCSR	; 037FC990
.arm
P2_Entry_037FC994:
.thumb
	bx pc	; 037FC994
	.byte 0xC0, 0x46	; 037FC996
.arm
	ldr r12,[pool_037FC9A0]	; 037FC998
	bx r12	; 037FC99C
pool_037FC9A0:
	.word loc_02304F18 + 1	; 037FC9A0
P2_Entry_037FC9A4:
.thumb
	push {r4,lr}	; 037FC9A4
	ldr r1,[pool_037FCA30]	; 037FC9A6
	ldr r3,[r1,#0x0]	; 037FC9A8
	ldr r2,[pool_037FCA34]	; 037FC9AA
	add r2,r3,r2	; 037FC9AC
	ldr r4,[pool_037FCA38]	; 037FC9AE
	ldr r3,[pool_037FCA3C]	; 037FC9B0
	strh r4,[r3,#0x0]	; 037FC9B2
	ldrh r3,[r2,#0x3c]	; 037FC9B4
	cmp r3,#0x0	; 037FC9B6
	beq P2_Entry_037FCA28	; 037FC9B8
	ldr r3,[r1,#0x0]	; 037FC9BA
	ldr r1,[pool_037FCA40]	; 037FC9BC
	ldrh r3,[r3,r1]	; 037FC9BE
	mov r1,#0x10	; 037FC9C0
	and r3,r1	; 037FC9C2
	cmp r3,#0x0	; 037FC9C4
	beq P2_Entry_037FCA20	; 037FC9C6
	cmp r0,#0x0	; 037FC9C8
	beq P2_Entry_037FCA20	; 037FC9CA
	ldr r0,[pool_037FCA44]	; 037FC9CC
	ldrh r1,[r0,#0x0]	; 037FC9CE
	ldr r0,[pool_037FCA48]	; 037FC9D0
	ldrh r0,[r0,#0x0]	; 037FC9D2
	cmp r0,#0x3	; 037FC9D4
	beq P2_Entry_037FC9DC	; 037FC9D6
	cmp r0,#0x5	; 037FC9D8
	bne P2_Entry_037FCA20	; 037FC9DA
P2_Entry_037FC9DC:
	cmp r1,#0x0	; 037FC9DC
	bne P2_Entry_037FCA20	; 037FC9DE
	ldr r3,[r2,#0x44]	; 037FC9E0
	ldrh r4,[r3,#0x2]	; 037FC9E2
	mov r0,#0x0	; 037FC9E4
	mov r1,#0x1	; 037FC9E6
	b P2_Entry_037FC9F4	; 037FC9E8
P2_Entry_037FC9EA:
	add r2,r4,#0x0	; 037FC9EA
	and r2,r1	; 037FC9EC
	add r0,r0,r2	; 037FC9EE
	lsl r2,r4,#0xf	; 037FC9F0
	lsr r4,r2,#0x10	; 037FC9F2
P2_Entry_037FC9F4:
	cmp r4,#0x0	; 037FC9F4
	bne P2_Entry_037FC9EA	; 037FC9F6
	ldrh r1,[r3,#0xa]	; 037FC9F8
	lsl r2,r1,#0x2	; 037FC9FA
	ldrh r1,[r3,#0x24]	; 037FC9FC
	add r1,#0xa	; 037FC9FE
	mul r0,r1	; 037FCA00
	add r0,#0xc0	; 037FCA02
	add r0,r2,r0	; 037FCA04
	lsl r0,r0,#0x10	; 037FCA06
	lsr r0,r0,#0x10	; 037FCA08
	ldr r1,[pool_037FCA4C]	; 037FCA0A
	bl P2_Entry_037FCA54	; 037FCA0C
	ldr r0,[pool_037FCA30]	; 037FCA10
	ldr r1,[r0,#0x0]	; 037FCA12
	ldr r0,[pool_037FCA50]	; 037FCA14
	add r0,r1,r0	; 037FCA16
	ldrh r1,[r0,#0x0]	; 037FCA18
	add r1,r1,#0x1	; 037FCA1A
	strh r1,[r0,#0x0]	; 037FCA1C
	b P2_Entry_037FCA28	; 037FCA1E
P2_Entry_037FCA20:
	mov r0,#0x0	; 037FCA20
	mov r1,#0x10	; 037FCA22
	bl loc_037FB3CC	; 037FCA24
P2_Entry_037FCA28:
	pop {r4}	; 037FCA28
	pop {r3}	; 037FCA2A
	bx r3	; 037FCA2C
	.byte 0xC0, 0x46	; 037FCA2E
pool_037FCA30:
	.word FirmwareWlWorkPointerSlot	; 037FCA30
pool_037FCA34:
	.word 0x00000400	; 037FCA34
pool_037FCA38:
	.word 0x00001000	; 037FCA38
pool_037FCA3C:
	.word REG_WIFI_IF	; 037FCA3C
pool_037FCA40:
	.word 0x00000638	; 037FCA40
pool_037FCA44:
	.word REG_WIFI_TXBUSY	; 037FCA44
pool_037FCA48:
	.word REG_WIFI_RF_STATUS	; 037FCA48
pool_037FCA4C:
	.word 0x037FCD39	; 037FCA4C
pool_037FCA50:
	.word 0x000003D4	; 037FCA50
P2_Entry_037FCA54:
	bx pc	; 037FCA54
	.byte 0xC0, 0x46	; 037FCA56
.arm
	ldr r12,[pool_037FCA60]	; 037FCA58
	bx r12	; 037FCA5C
pool_037FCA60:
	.word P4_Entry_02305370 + 1	; 037FCA60
P2_Entry_037FCA64:
.thumb
	push {r4,lr}	; 037FCA64
	ldr r3,[pool_037FCAC4]	; 037FCA66
	ldr r1,[r3,#0x0]	; 037FCA68
	ldr r0,[pool_037FCAC8]	; 037FCA6A
	add r1,r1,r0	; 037FCA6C
	mov r0,#0x80	; 037FCA6E
	ldr r2,[pool_037FCACC]	; 037FCA70
	strh r0,[r2,#0x0]	; 037FCA72
	ldr r3,[r3,#0x0]	; 037FCA74
	ldr r2,[pool_037FCAD0]	; 037FCA76
	ldrh r3,[r3,r2]	; 037FCA78
	mov r2,#0x20	; 037FCA7A
	and r3,r2	; 037FCA7C
	cmp r3,#0x0	; 037FCA7E
	beq P2_Entry_037FCABE	; 037FCA80
	ldr r2,[pool_037FCAD4]	; 037FCA82
	ldrh r3,[r2,#0x0]	; 037FCA84
	mov r2,#0xff	; 037FCA86
	and r3,r2	; 037FCA88
	lsl r2,r3,#0x10	; 037FCA8A
	lsr r3,r2,#0x10	; 037FCA8C
	ldr r2,[pool_037FCAD8]	; 037FCA8E
	ldrh r4,[r2,#0x0]	; 037FCA90
	cmp r3,#0x3	; 037FCA92
	bcc P2_Entry_037FCABE	; 037FCA94
	cmp r3,#0x5	; 037FCA96
	bhi P2_Entry_037FCABE	; 037FCA98
	ldr r2,[r1,#0x58]	; 037FCA9A
	lsr r3,r2,#0x1	; 037FCA9C
	ldr r2,[pool_037FCADC]	; 037FCA9E
	and r3,r2	; 037FCAA0
	cmp r4,r3	; 037FCAA2
	bcc P2_Entry_037FCABE	; 037FCAA4
	ldr r1,[r1,#0x30]	; 037FCAA6
	lsr r1,r1,#0x1	; 037FCAA8
	and r1,r2	; 037FCAAA
	cmp r4,r1	; 037FCAAC
	bhi P2_Entry_037FCABE	; 037FCAAE
	ldr r2,[pool_037FCAE0]	; 037FCAB0
	ldrh r1,[r2,#0x0]	; 037FCAB2
	orr r1,r0	; 037FCAB4
	strh r1,[r2,#0x0]	; 037FCAB6
	ldrh r1,[r2,#0x0]	; 037FCAB8
	bic r1,r0	; 037FCABA
	strh r1,[r2,#0x0]	; 037FCABC
P2_Entry_037FCABE:
	pop {r4}	; 037FCABE
	pop {r3}	; 037FCAC0
	bx r3	; 037FCAC2
pool_037FCAC4:
	.word FirmwareWlWorkPointerSlot	; 037FCAC4
pool_037FCAC8:
	.word 0x00000400	; 037FCAC8
pool_037FCACC:
	.word REG_WIFI_IF	; 037FCACC
pool_037FCAD0:
	.word 0x00000638	; 037FCAD0
pool_037FCAD4:
	.word REG_WIFI_RF_STATUS	; 037FCAD4
pool_037FCAD8:
	.word REG_WIFI_RXTX_ADDR	; 037FCAD8
pool_037FCADC:
	.word 0x00000FFF	; 037FCADC
pool_037FCAE0:
	.word REG_WIFI_UNKNOWN_244	; 037FCAE0
P2_Entry_037FCAE4:
	push {r4,r5,r6,r7,lr}	; 037FCAE4
	sub sp,#0x4	; 037FCAE6
	ldr r0,[pool_037FCC64]	; 037FCAE8
	ldr r2,[r0,#0x0]	; 037FCAEA
	ldr r1,[pool_037FCC68]	; 037FCAEC
	add r5,r2,r1	; 037FCAEE
	ldr r1,[pool_037FCC6C]	; 037FCAF0
	add r6,r2,r1	; 037FCAF2
	mov r2,#0x40	; 037FCAF4
	ldr r1,[pool_037FCC70]	; 037FCAF6
	strh r2,[r1,#0x0]	; 037FCAF8
	ldr r1,[r0,#0x0]	; 037FCAFA
	ldr r0,[pool_037FCC74]	; 037FCAFC
	ldrh r1,[r1,r0]	; 037FCAFE
	mov r0,#0x20	; 037FCB00
	and r1,r0	; 037FCB02
	cmp r1,#0x0	; 037FCB04
	bne P2_Entry_037FCB0A	; 037FCB06
	b P2_Entry_037FCC5A	; 037FCB08
P2_Entry_037FCB0A:
	add r0,r6,#0x0	; 037FCB0A
	add r0,#0xa6	; 037FCB0C
	ldrh r1,[r0,#0x0]	; 037FCB0E
	ldr r0,[pool_037FCC78]	; 037FCB10
	cmp r1,r0	; 037FCB12
	beq P2_Entry_037FCB18	; 037FCB14
	b P2_Entry_037FCC5A	; 037FCB16
P2_Entry_037FCB18:
	ldr r0,[pool_037FCC7C]	; 037FCB18
	ldrh r1,[r0,#0x0]	; 037FCB1A
	mov r0,#0x3	; 037FCB1C
	and r1,r0	; 037FCB1E
	cmp r1,#0x3	; 037FCB20
	beq P2_Entry_037FCB26	; 037FCB22
	b P2_Entry_037FCC5A	; 037FCB24
P2_Entry_037FCB26:
	ldr r0,[pool_037FCC80]	; 037FCB26
	ldrh r2,[r0,#0x0]	; 037FCB28
	ldr r0,[pool_037FCC84]	; 037FCB2A
	ldrh r0,[r0,#0x0]	; 037FCB2C
	lsr r1,r0,#0x1	; 037FCB2E
	ldr r0,[pool_037FCC88]	; 037FCB30
	and r1,r0	; 037FCB32
	cmp r2,r1	; 037FCB34
	bge P2_Entry_037FCB3A	; 037FCB36
	b P2_Entry_037FCC5A	; 037FCB38
P2_Entry_037FCB3A:
	ldr r0,[pool_037FCC8C]	; 037FCB3A
	ldrh r0,[r0,#0x0]	; 037FCB3C
	str r0,[sp,#0x0]	; 037FCB3E
	lsl r1,r0,#0x1	; 037FCB40
	ldr r0,[pool_037FCC90]	; 037FCB42
	add r0,r1,r0	; 037FCB44
	add r0,#0x8	; 037FCB46
	bl P2_Entry_037FCD84	; 037FCB48
	add r0,r0,#0x4	; 037FCB4C
	bl P2_Entry_037FCD84	; 037FCB4E
	ldrh r2,[r0,#0x0]	; 037FCB52
	ldr r1,[pool_037FCC94]	; 037FCB54
	and r2,r1	; 037FCB56
	ldr r1,[pool_037FCC98]	; 037FCB58
	cmp r2,r1	; 037FCB5A
	bne P2_Entry_037FCC5A	; 037FCB5C
	add r0,r0,#0x2	; 037FCB5E
	bl P2_Entry_037FCD84	; 037FCB60
	add r1,r0,#0x0	; 037FCB64
	ldr r4,[pool_037FCC9C]	; 037FCB66
	ldrh r2,[r4,#0x0]	; 037FCB68
	ldr r0,[pool_037FCCA0]	; 037FCB6A
	sub r7,r2,r0	; 037FCB6C
P2_Entry_037FCB6E:
	ldr r0,[pool_037FCC80]	; 037FCB6E
	ldrh r2,[r0,#0x0]	; 037FCB70
	ldr r0,[sp,#0x0]	; 037FCB72
	sub r0,r2,r0	; 037FCB74
	lsl r0,r0,#0x10	; 037FCB76
	lsr r3,r0,#0x10	; 037FCB78
	add r2,r3,#0x0	; 037FCB7A
	ldr r0,[pool_037FCCA4]	; 037FCB7C
	and r2,r0	; 037FCB7E
	cmp r2,#0x0	; 037FCB80
	beq P2_Entry_037FCB92	; 037FCB82
	add r0,r5,#0x0	; 037FCB84
	add r0,#0x9a	; 037FCB86
	ldrh r0,[r0,#0x0]	; 037FCB88
	lsr r0,r0,#0x1	; 037FCB8A
	add r0,r3,r0	; 037FCB8C
	lsl r0,r0,#0x10	; 037FCB8E
	lsr r3,r0,#0x10	; 037FCB90
P2_Entry_037FCB92:
	cmp r3,#0xe	; 037FCB92
	bhi P2_Entry_037FCBA4	; 037FCB94
	ldrh r0,[r4,#0x0]	; 037FCB96
	sub r0,r0,r7	; 037FCB98
	lsl r0,r0,#0x10	; 037FCB9A
	lsr r0,r0,#0x10	; 037FCB9C
	cmp r0,#0x40	; 037FCB9E
	bls P2_Entry_037FCB6E	; 037FCBA0
	b P2_Entry_037FCC5A	; 037FCBA2
P2_Entry_037FCBA4:
	add r1,#0x8	; 037FCBA4
	mov r4,#0x0	; 037FCBA6
	b P2_Entry_037FCBC2	; 037FCBA8
P2_Entry_037FCBAA:
	add r0,r1,#0x0	; 037FCBAA
	bl P2_Entry_037FCD84	; 037FCBAC
	add r1,r0,#0x2	; 037FCBB0
	ldrh r0,[r0,#0x0]	; 037FCBB2
	lsl r2,r4,#0x1	; 037FCBB4
	add r2,r5,r2	; 037FCBB6
	add r2,#0x64	; 037FCBB8
	ldrh r2,[r2,#0x0]	; 037FCBBA
	cmp r0,r2	; 037FCBBC
	bne P2_Entry_037FCC5A	; 037FCBBE
	add r4,r4,#0x1	; 037FCBC0
P2_Entry_037FCBC2:
	cmp r4,#0x3	; 037FCBC2
	bcc P2_Entry_037FCBAA	; 037FCBC4
	add r1,#0xa	; 037FCBC6
	add r0,r1,#0x0	; 037FCBC8
	bl P2_Entry_037FCD84	; 037FCBCA
	add r3,r0,#0x0	; 037FCBCE
	ldr r4,[pool_037FCC80]	; 037FCBD0
P2_Entry_037FCBD2:
	ldrh r1,[r4,#0x0]	; 037FCBD2
	ldr r0,[sp,#0x0]	; 037FCBD4
	sub r0,r1,r0	; 037FCBD6
	lsl r0,r0,#0x10	; 037FCBD8
	lsr r2,r0,#0x10	; 037FCBDA
	add r1,r2,#0x0	; 037FCBDC
	ldr r0,[pool_037FCCA4]	; 037FCBDE
	and r1,r0	; 037FCBE0
	cmp r1,#0x0	; 037FCBE2
	beq P2_Entry_037FCBF4	; 037FCBE4
	add r0,r5,#0x0	; 037FCBE6
	add r0,#0x9a	; 037FCBE8
	ldrh r0,[r0,#0x0]	; 037FCBEA
	lsr r0,r0,#0x1	; 037FCBEC
	add r0,r2,r0	; 037FCBEE
	lsl r0,r0,#0x10	; 037FCBF0
	lsr r2,r0,#0x10	; 037FCBF2
P2_Entry_037FCBF4:
	cmp r2,#0x14	; 037FCBF4
	bhi P2_Entry_037FCC08	; 037FCBF6
	ldr r0,[pool_037FCC9C]	; 037FCBF8
	ldrh r0,[r0,#0x0]	; 037FCBFA
	sub r0,r0,r7	; 037FCBFC
	lsl r0,r0,#0x10	; 037FCBFE
	lsr r0,r0,#0x10	; 037FCC00
	cmp r0,#0x70	; 037FCC02
	bls P2_Entry_037FCBD2	; 037FCC04
	b P2_Entry_037FCC5A	; 037FCC06
P2_Entry_037FCC08:
	ldrh r1,[r3,#0x0]	; 037FCC08
	add r0,r6,#0x0	; 037FCC0A
	add r0,#0xa2	; 037FCC0C
	ldrh r0,[r0,#0x0]	; 037FCC0E
	and r1,r0	; 037FCC10
	cmp r1,#0x0	; 037FCC12
	bne P2_Entry_037FCC5A	; 037FCC14
	ldr r0,[pool_037FCCA8]	; 037FCC16
	ldrh r0,[r0,#0x0]	; 037FCC18
	add r6,#0xa6	; 037FCC1A
	strh r0,[r6,#0x0]	; 037FCC1C
	mov r1,#0x40	; 037FCC1E
	ldr r0,[pool_037FCCAC]	; 037FCC20
	strh r1,[r0,#0x0]	; 037FCC22
	add r0,r5,#0x0	; 037FCC24
	add r0,#0xbe	; 037FCC26
	ldrh r0,[r0,#0x0]	; 037FCC28
	add r0,r0,#0x1	; 037FCC2A
	add r5,#0xbe	; 037FCC2C
	strh r0,[r5,#0x0]	; 037FCC2E
	ldr r1,[pool_037FCC7C]	; 037FCC30
	mov r0,#0x3	; 037FCC32
P2_Entry_037FCC34:
	ldrh r2,[r1,#0x0]	; 037FCC34
	and r2,r0	; 037FCC36
	cmp r2,#0x3	; 037FCC38
	beq P2_Entry_037FCC34	; 037FCC3A
	ldr r2,[pool_037FCCB0]	; 037FCC3C
	ldrh r1,[r2,#0x0]	; 037FCC3E
	mov r0,#0x40	; 037FCC40
	orr r1,r0	; 037FCC42
	strh r1,[r2,#0x0]	; 037FCC44
	ldrh r1,[r2,#0x0]	; 037FCC46
	bic r1,r0	; 037FCC48
	strh r1,[r2,#0x0]	; 037FCC4A
	mov r0,#0x8	; 037FCC4C
	ldr r1,[pool_037FCCB4]	; 037FCC4E
	strh r0,[r1,#0x0]	; 037FCC50
	mov r0,#0x0	; 037FCC52
	strh r0,[r1,#0x0]	; 037FCC54
	bl P2_Entry_037FCCB8	; 037FCC56
P2_Entry_037FCC5A:
	add sp,#0x4	; 037FCC5A
	pop {r4,r5,r6,r7}	; 037FCC5C
	pop {r3}	; 037FCC5E
	bx r3	; 037FCC60
	.byte 0xC0, 0x46	; 037FCC62
pool_037FCC64:
	.word FirmwareWlWorkPointerSlot	; 037FCC64
pool_037FCC68:
	.word 0x00000318	; 037FCC68
pool_037FCC6C:
	.word 0x00000400	; 037FCC6C
pool_037FCC70:
	.word REG_WIFI_IF	; 037FCC70
pool_037FCC74:
	.word 0x00000638	; 037FCC74
pool_037FCC78:
	.word 0x0000FFFF	; 037FCC78
pool_037FCC7C:
	.word REG_WIFI_RF_PINS	; 037FCC7C
pool_037FCC80:
	.word REG_WIFI_RXTX_ADDR	; 037FCC80
pool_037FCC84:
	.word REG_WIFI_RXBUF_BEGIN	; 037FCC84
pool_037FCC88:
	.word 0x00000FFF	; 037FCC88
pool_037FCC8C:
	.word REG_WIFI_RXBUF_WRCSR	; 037FCC8C
pool_037FCC90:
	.word 0x04804000	; 037FCC90
pool_037FCC94:
	.word 0x0000E7FF	; 037FCC94
pool_037FCC98:
	.word 0x00000228	; 037FCC98
pool_037FCC9C:
	.word REG_WIFI_US_COUNT0	; 037FCC9C
pool_037FCCA0:
	.word 0x00010000	; 037FCCA0
pool_037FCCA4:
	.word 0x00008000	; 037FCCA4
pool_037FCCA8:
	.word REG_WIFI_TXBUF_REPLY2	; 037FCCA8
pool_037FCCAC:
	.word REG_WIFI_TXBUF_RESET	; 037FCCAC
pool_037FCCB0:
	.word REG_WIFI_UNKNOWN_244	; 037FCCB0
pool_037FCCB4:
	.word REG_WIFI_UNKNOWN_228	; 037FCCB4
P2_Entry_037FCCB8:
	bx pc	; 037FCCB8
	.byte 0xC0, 0x46	; 037FCCBA
.arm
	ldr r12,[pool_037FCCC4]	; 037FCCBC
	bx r12	; 037FCCC0
pool_037FCCC4:
	.word P4_Entry_02306DF4 + 1	; 037FCCC4
P2_Entry_037FCCC8:
.thumb
	push {r4,r5,lr}	; 037FCCC8
	sub sp,#0x4	; 037FCCCA
	ldr r0,[pool_037FCD20]	; 037FCCCC
	ldr r1,[r0,#0x0]	; 037FCCCE
	ldr r0,[pool_037FCD24]	; 037FCCD0
	add r5,r1,r0	; 037FCCD2
	mov r4,#0x0	; 037FCCD4
	mov r0,#0x1	; 037FCCD6
	bl P2_Entry_037FCD28	; 037FCCD8
	lsl r0,r4,#0	; 037FCCDC
	bl P2_Entry_037FCD28	; 037FCCDE
	ldr r0,[r5,#0x1c]	; 037FCCE2
	ldrh r0,[r0,#0x0]	; 037FCCE4
	cmp r0,#0x0	; 037FCCE6
	beq P2_Entry_037FCCEE	; 037FCCE8
	mov r4,#0x1	; 037FCCEA
	b P2_Entry_037FCCF2	; 037FCCEC
P2_Entry_037FCCEE:
	lsl r0,r4,#0	; 037FCCEE
	strh r0,[r5,#0x14]	; 037FCCF0
P2_Entry_037FCCF2:
	ldr r0,[r5,#0x8]	; 037FCCF2
	ldrh r0,[r0,#0x0]	; 037FCCF4
	cmp r0,#0x0	; 037FCCF6
	beq P2_Entry_037FCCFE	; 037FCCF8
	mov r4,#0x1	; 037FCCFA
	b P2_Entry_037FCD02	; 037FCCFC
P2_Entry_037FCCFE:
	mov r0,#0x0	; 037FCCFE
	strh r0,[r5,#0x0]	; 037FCD00
P2_Entry_037FCD02:
	cmp r4,#0x0	; 037FCD02
	beq P2_Entry_037FCD0E	; 037FCD04
	mov r0,#0x0	; 037FCD06
	mov r1,#0xe	; 037FCD08
	bl loc_037FB3CC	; 037FCD0A
P2_Entry_037FCD0E:
	mov r0,#0x0	; 037FCD0E
	mov r1,#0x14	; 037FCD10
	bl loc_037FB3CC	; 037FCD12
	add sp,#0x4	; 037FCD16
	pop {r4,r5}	; 037FCD18
	pop {r3}	; 037FCD1A
	bx r3	; 037FCD1C
	.byte 0xC0, 0x46	; 037FCD1E
pool_037FCD20:
	.word FirmwareWlWorkPointerSlot	; 037FCD20
pool_037FCD24:
	.word 0x00000400	; 037FCD24
P2_Entry_037FCD28:
	bx pc	; 037FCD28
	.byte 0xC0, 0x46	; 037FCD2A
.arm
	ldr r12,[pool_037FCD34]	; 037FCD2C
	bx r12	; 037FCD30
pool_037FCD34:
	.word loc_0230A6A4 + 1	; 037FCD34
	.byte 0x10, 0xB5, 0x0E, 0x48, 0x00, 0xF0, 0x96, 0xFE, 0x04, 0x1C, 0x0D, 0x4A, 0x13, 0x88, 0x0D, 0x49	; 037FCD38
	.byte 0x0D, 0x48, 0x01, 0x80, 0x64, 0x21, 0x03, 0xE0, 0x10, 0x88, 0x83, 0x42, 0x02, 0xD1, 0x49, 0x1E	; 037FCD48
	.byte 0x00, 0x29, 0xF9, 0xD1, 0x00, 0x20, 0x08, 0x49, 0x08, 0x80, 0xFF, 0xF7, 0x1F, 0xFE, 0x20, 0x1C	; 037FCD58
	.byte 0x00, 0xF0, 0x96, 0xFE, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x00, 0x00, 0x00, 0x01	; 037FCD68
	.byte 0x10, 0x82, 0x80, 0x04, 0x00, 0x10, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04	; 037FCD78
P2_Entry_037FCD84:
.thumb
	ldr r1,[pool_037FCD98]	; 037FCD84
	cmp r0,r1	; 037FCD86
	bcc P2_Entry_037FCD94	; 037FCD88
	ldr r1,[pool_037FCD9C]	; 037FCD8A
	ldr r2,[r1,#0x0]	; 037FCD8C
	ldr r1,[pool_037FCDA0]	; 037FCD8E
	ldrh r1,[r2,r1]	; 037FCD90
	sub r0,r0,r1	; 037FCD92
P2_Entry_037FCD94:
	bx lr	; 037FCD94
	.byte 0xC0, 0x46	; 037FCD96
pool_037FCD98:
	.word 0x04805F60	; 037FCD98
pool_037FCD9C:
	.word FirmwareWlWorkPointerSlot	; 037FCD9C
pool_037FCDA0:
	.word 0x000003B2	; 037FCDA0
P2_Entry_037FCDA4:
	push {r4,lr}	; 037FCDA4
	ldr r0,[pool_037FCDD8]	; 037FCDA6
	ldr r1,[r0,#0x0]	; 037FCDA8
	ldr r0,[pool_037FCDDC]	; 037FCDAA
	add r4,r1,r0	; 037FCDAC
	add r0,r4,#0x0	; 037FCDAE
	add r0,#0x50	; 037FCDB0
	bl P2_Entry_037FCDE0	; 037FCDB2
	cmp r0,#0x0	; 037FCDB6
	beq P2_Entry_037FCDBE	; 037FCDB8
	mov r0,#0x1	; 037FCDBA
	b P2_Entry_037FCDD0	; 037FCDBC
P2_Entry_037FCDBE:
	add r4,#0x64	; 037FCDBE
	add r0,r4,#0x0	; 037FCDC0
	bl P2_Entry_037FCDE0	; 037FCDC2
	cmp r0,#0x0	; 037FCDC6
	beq P2_Entry_037FCDCE	; 037FCDC8
	mov r0,#0x1	; 037FCDCA
	b P2_Entry_037FCDD0	; 037FCDCC
P2_Entry_037FCDCE:
	mov r0,#0x0	; 037FCDCE
P2_Entry_037FCDD0:
	pop {r4}	; 037FCDD0
	pop {r3}	; 037FCDD2
	bx r3	; 037FCDD4
	.byte 0xC0, 0x46	; 037FCDD6
pool_037FCDD8:
	.word FirmwareWlWorkPointerSlot	; 037FCDD8
pool_037FCDDC:
	.word 0x00000400	; 037FCDDC
P2_Entry_037FCDE0:
	bx pc	; 037FCDE0
	.byte 0xC0, 0x46	; 037FCDE2
.arm
	ldr r12,[pool_037FCDEC]	; 037FCDE4
	bx r12	; 037FCDE8
pool_037FCDEC:
	.word P4_Entry_02306DB0 + 1	; 037FCDEC
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0A, 0x48, 0x01, 0x68, 0x0A, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD0	; 037FCDF0
	.byte 0x00, 0xF0, 0x14, 0xF8, 0x06, 0x48, 0x01, 0x68, 0x07, 0x48, 0x08, 0x5A, 0x40, 0x06, 0xC0, 0x0F	; 037FCE00
	.byte 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x12, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCE10
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xBC, 0x03, 0x00, 0x00, 0x0E, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 037FCE20
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xD1, 0x9F, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46	; 037FCE30
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xD5, 0x79, 0x30, 0x02, 0xF0, 0xB5, 0x83, 0xB0	; 037FCE40
	.byte 0x4B, 0x48, 0x01, 0x68, 0x4B, 0x48, 0x0D, 0x18, 0x4B, 0x48, 0x0F, 0x18, 0x02, 0x24, 0x01, 0x94	; 037FCE50
	.byte 0x00, 0x94, 0x21, 0x1C, 0x14, 0x20, 0x41, 0x43, 0x7A, 0x18, 0xA0, 0x00, 0x47, 0x49, 0x43, 0x18	; 037FCE60
	.byte 0x41, 0x5A, 0x47, 0x48, 0x01, 0x40, 0x00, 0x29, 0x79, 0xD1, 0x10, 0x88, 0x00, 0x28, 0x76, 0xD0	; 037FCE70
	.byte 0xD0, 0x68, 0x00, 0x28, 0x6B, 0xD0, 0x91, 0x68, 0x09, 0x88, 0x01, 0x81, 0x90, 0x68, 0x81, 0x89	; 037FCE80
	.byte 0xD0, 0x68, 0x81, 0x82, 0x90, 0x68, 0x86, 0x89, 0x3E, 0x49, 0x0E, 0x40, 0x00, 0x2E, 0x50, 0xD0	; 037FCE90
	.byte 0x37, 0x49, 0x0E, 0x68, 0x3C, 0x49, 0x76, 0x5A, 0x08, 0x21, 0x0E, 0x40, 0x00, 0x2E, 0x40, 0xD0	; 037FCEA0
	.byte 0x06, 0x1C, 0x0C, 0x36, 0x41, 0x89, 0x71, 0x18, 0xC9, 0x1F, 0x01, 0x26, 0xB1, 0x43, 0x0E, 0x88	; 037FCEB0
	.byte 0x00, 0x2E, 0x36, 0xD1, 0x49, 0x88, 0x00, 0x29, 0x33, 0xD1, 0x28, 0x1C, 0xA8, 0x30, 0x00, 0x68	; 037FCEC0
	.byte 0xD1, 0x68, 0x89, 0x88, 0x40, 0x1A, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x26, 0x2F, 0x49, 0x0E, 0x80	; 037FCED0
	.byte 0x2B, 0x4E, 0x0E, 0x80, 0x29, 0x1C, 0xBA, 0x31, 0x09, 0x88, 0x49, 0x1C, 0x2E, 0x1C, 0xBA, 0x36	; 037FCEE0
	.byte 0x31, 0x80, 0x29, 0x1C, 0x8C, 0x31, 0x09, 0x88, 0x88, 0x42, 0x12, 0xD9, 0xD1, 0x68, 0x00, 0x98	; 037FCEF0
	.byte 0x08, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0x38, 0x1C, 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C	; 037FCF00
	.byte 0x38, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0xD0, 0x68, 0x01, 0x21, 0x12, 0x69, 0x08, 0xF0, 0xBA, 0xF8	; 037FCF10
	.byte 0x25, 0xE0, 0xD1, 0x68, 0x00, 0x20, 0x88, 0x81, 0x19, 0x88, 0x19, 0x48, 0x01, 0x43, 0x19, 0x80	; 037FCF20
	.byte 0x1D, 0xE0, 0xD3, 0x68, 0x99, 0x89, 0x86, 0x88, 0xFF, 0x20, 0x06, 0x40, 0x88, 0x19, 0x98, 0x81	; 037FCF30
	.byte 0x04, 0xE0, 0x81, 0x88, 0xFF, 0x20, 0x01, 0x40, 0xD0, 0x68, 0x81, 0x81, 0x90, 0x88, 0x40, 0x1C	; 037FCF40
	.byte 0x90, 0x80, 0xD0, 0x68, 0x01, 0x99, 0x12, 0x69, 0x08, 0xF0, 0x9C, 0xF8, 0x07, 0xE0, 0x90, 0x88	; 037FCF50
	.byte 0x40, 0x1C, 0x90, 0x80, 0x90, 0x68, 0x03, 0x21, 0x12, 0x69, 0x08, 0xF0, 0x93, 0xF8, 0x64, 0x1E	; 037FCF60
	.byte 0x00, 0x2C, 0x00, 0xDB, 0x75, 0xE7, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCF70
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04	; 037FCF80
	.byte 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x38, 0x06, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04	; 037FCF90
.thumb
P2_Entry_037FCFA0:
	push {r4,r5,r6,r7,lr}	; 037FCFA0
	sub sp,#0x24	; 037FCFA2
	ldr r0,[pool_037FD200]	; 037FCFA4
	ldr r1,[r0,#0x0]	; 037FCFA6
	ldr r0,[pool_037FD204]	; 037FCFA8
	add r7,r1,r0	; 037FCFAA
	ldr r0,[pool_037FD208]	; 037FCFAC
	add r6,r1,r0	; 037FCFAE
	mov r0,#0x0	; 037FCFB0
	str r0,[sp,#0x0]	; 037FCFB2
	str r0,[sp,#0xc]	; 037FCFB4
	str r0,[sp,#0x1c]	; 037FCFB6
	str r0,[sp,#0x18]	; 037FCFB8
	str r0,[sp,#0x14]	; 037FCFBA
	str r0,[sp,#0x10]	; 037FCFBC
	str r0,[sp,#0x20]	; 037FCFBE
P2_Entry_037FCFC0:
	ldr r0,[pool_037FD20C]	; 037FCFC0
	ldrh r1,[r0,#0x0]	; 037FCFC2
	ldrh r0,[r7,#0x4]	; 037FCFC4
	cmp r1,r0	; 037FCFC6
	bne P2_Entry_037FCFCC	; 037FCFC8
	b P2_Entry_037FD1F8	; 037FCFCA
P2_Entry_037FCFCC:
	lsl r4,r1,#0x1	; 037FCFCC
	ldr r0,[pool_037FD210]	; 037FCFCE
	add r5,r4,r0	; 037FCFD0
	add r0,r5,#0x2	; 037FCFD2
	bl P2_Entry_037FCD84	; 037FCFD4
	ldrh r0,[r0,#0x0]	; 037FCFD8
	str r0,[sp,#0x8]	; 037FCFDA
	ldr r0,[pool_037FD210]	; 037FCFDC
	ldrh r1,[r4,r0]	; 037FCFDE
	ldr r0,[pool_037FD214]	; 037FCFE0
	cmp r1,r0	; 037FCFE2
	bne P2_Entry_037FCFEE	; 037FCFE4
	ldr r1,[sp,#0x8]	; 037FCFE6
	ldr r0,[pool_037FD20C]	; 037FCFE8
	strh r1,[r0,#0x0]	; 037FCFEA
	b P2_Entry_037FD1F0	; 037FCFEC
P2_Entry_037FCFEE:
	add r0,r5,#0x0	; 037FCFEE
	add r0,#0x8	; 037FCFF0
	bl P2_Entry_037FCD84	; 037FCFF2
	ldrh r1,[r0,#0x0]	; 037FCFF6
	add r0,r5,#0x0	; 037FCFF8
	bl P2_Entry_037FD3E8	; 037FCFFA
	add r4,r0,#0x0	; 037FCFFE
	ldr r1,[sp,#0x8]	; 037FD000
	ldr r0,[pool_037FD20C]	; 037FD002
	strh r1,[r0,#0x0]	; 037FD004
	cmp r4,#0x0	; 037FD006
	bne P2_Entry_037FD024	; 037FD008
	ldrh r1,[r5,#0x0]	; 037FD00A
	mov r0,#0xf	; 037FD00C
	and r1,r0	; 037FD00E
	cmp r1,#0xc	; 037FD010
	bne P2_Entry_037FD01C	; 037FD012
	mov r0,#0x10	; 037FD014
	bl P2_Entry_037FC994	; 037FD016
	b P2_Entry_037FD1F0	; 037FD01A
P2_Entry_037FD01C:
	mov r0,#0x8	; 037FD01C
	bl P2_Entry_037FC994	; 037FD01E
	b P2_Entry_037FD1F0	; 037FD022
P2_Entry_037FD024:
	ldr r0,[pool_037FD200]	; 037FD024
	ldr r1,[r0,#0x0]	; 037FD026
	ldr r0,[pool_037FD218]	; 037FD028
	ldrh r1,[r1,r0]	; 037FD02A
	mov r0,#0x8	; 037FD02C
	and r1,r0	; 037FD02E
	cmp r1,#0x0	; 037FD030
	beq P2_Entry_037FD042	; 037FD032
	ldrh r1,[r4,#0x14]	; 037FD034
	ldr r0,[pool_037FD21C]	; 037FD036
	and r1,r0	; 037FD038
	cmp r1,#0x0	; 037FD03A
	beq P2_Entry_037FD042	; 037FD03C
	ldr r0,[sp,#0xc]	; 037FD03E
	strh r0,[r7,#0x2]	; 037FD040
P2_Entry_037FD042:
	ldrh r1,[r4,#0x8]	; 037FD042
	mov r0,#0x1	; 037FD044
	str r0,[sp,#0x4]	; 037FD046
	add r2,r1,#0x0	; 037FD048
	ldr r0,[pool_037FD220]	; 037FD04A
	and r2,r0	; 037FD04C
	cmp r2,#0x0	; 037FD04E
	beq P2_Entry_037FD086	; 037FD050
	ldrh r0,[r4,#0x14]	; 037FD052
	lsl r0,r0,#0x15	; 037FD054
	lsr r0,r0,#0x1f	; 037FD056
	cmp r0,#0x1	; 037FD058
	beq P2_Entry_037FD068	; 037FD05A
	ldrh r0,[r4,#0x2a]	; 037FD05C
	lsl r0,r0,#0x1c	; 037FD05E
	lsr r0,r0,#0x1c	; 037FD060
	cmp r0,#0x0	; 037FD062
	bne P2_Entry_037FD068	; 037FD064
	b P2_Entry_037FD1B0	; 037FD066
P2_Entry_037FD068:
	ldr r0,[sp,#0x10]	; 037FD068
	str r0,[sp,#0x4]	; 037FD06A
	add r0,r6,#0x0	; 037FD06C
	add r0,#0xc	; 037FD06E
	add r1,r6,#0x0	; 037FD070
	add r1,#0x6c	; 037FD072
	add r2,r4,#0x0	; 037FD074
	sub r2,#0x10	; 037FD076
	bl loc_037FB6A8	; 037FD078
	mov r0,#0x2	; 037FD07C
	mov r1,#0x9	; 037FD07E
	bl loc_037FB3CC	; 037FD080
	b P2_Entry_037FD1B0	; 037FD084
P2_Entry_037FD086:
	mov r0,#0xf	; 037FD086
	and r1,r0	; 037FD088
	cmp r1,#0xf	; 037FD08A
	bls P2_Entry_037FD090	; 037FD08C
	b P2_Entry_037FD1B0	; 037FD08E
P2_Entry_037FD090:
	add r0,r1,r1	; 037FD090
P2_SwitchIndexPC_037FD090:
	add r0,pc	; 037FD092
	ldrh r0,[r0,#(P2_SwitchTable_037FD090 - (P2_SwitchIndexPC_037FD090 + 4))]	; 037FD094
	lsl r0,r0,#0x10	; 037FD096
	asr r0,r0,#0x10	; 037FD098
P2_SwitchTargetPC_037FD090:
	add r0,pc	; 037FD09A
	bx r0	; 037FD09C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD090:
	.halfword (P2_Case_037FD0F4 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD0E6 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD11C + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD0BE + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Entry_037FD1B0 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD158 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD18E + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD144 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
	.halfword (P2_Case_037FD144 + 1) - (P2_SwitchTargetPC_037FD090 + 4)
P2_SwitchTable_037FD090End:
P2_Case_037FD0BE:
	ldrh r1,[r4,#0x14]	; 037FD0BE
	mov r0,#0xf	; 037FD0C0
	and r1,r0	; 037FD0C2
	cmp r1,#0x8	; 037FD0C4
	bne P2_Entry_037FD1B0	; 037FD0C6
	ldr r0,[sp,#0x14]	; 037FD0C8
	str r0,[sp,#0x4]	; 037FD0CA
	add r0,r6,#0x0	; 037FD0CC
	add r0,#0xc	; 037FD0CE
	add r1,r6,#0x0	; 037FD0D0
	add r1,#0x48	; 037FD0D2
	add r2,r4,#0x0	; 037FD0D4
	sub r2,#0x10	; 037FD0D6
	bl loc_037FB6A8	; 037FD0D8
	mov r0,#0x2	; 037FD0DC
	mov r1,#0x6	; 037FD0DE
	bl loc_037FB3CC	; 037FD0E0
	b P2_Entry_037FD1B0	; 037FD0E4
P2_Case_037FD0E6:
	ldrh r0,[r4,#0x14]	; 037FD0E6
	cmp r0,#0x80	; 037FD0E8
	bne P2_Entry_037FD1B0	; 037FD0EA
	add r0,r4,#0x0	; 037FD0EC
	bl P2_Entry_037FD250	; 037FD0EE
	b P2_Entry_037FD1B0	; 037FD0F2
P2_Case_037FD0F4:
	ldrh r1,[r4,#0x14]	; 037FD0F4
	mov r0,#0xf	; 037FD0F6
	and r1,r0	; 037FD0F8
	cmp r1,#0x0	; 037FD0FA
	bne P2_Entry_037FD1B0	; 037FD0FC
	ldr r0,[sp,#0x18]	; 037FD0FE
	str r0,[sp,#0x4]	; 037FD100
	add r0,r6,#0x0	; 037FD102
	add r0,#0xc	; 037FD104
	add r1,r6,#0x0	; 037FD106
	add r1,#0x60	; 037FD108
	add r2,r4,#0x0	; 037FD10A
	sub r2,#0x10	; 037FD10C
	bl loc_037FB6A8	; 037FD10E
	mov r0,#0x1	; 037FD112
	mov r1,#0x7	; 037FD114
	bl loc_037FB3CC	; 037FD116
	b P2_Entry_037FD1B0	; 037FD11A
P2_Case_037FD11C:
	ldrh r1,[r4,#0x14]	; 037FD11C
	ldr r0,[pool_037FD224]	; 037FD11E
	and r1,r0	; 037FD120
	cmp r1,#0xa4	; 037FD122
	bne P2_Entry_037FD1B0	; 037FD124
	ldr r0,[sp,#0x1c]	; 037FD126
	str r0,[sp,#0x4]	; 037FD128
	add r0,r6,#0x0	; 037FD12A
	add r0,#0xc	; 037FD12C
	add r1,r6,#0x0	; 037FD12E
	add r1,#0x60	; 037FD130
	add r2,r4,#0x0	; 037FD132
	sub r2,#0x10	; 037FD134
	bl loc_037FB6A8	; 037FD136
	mov r0,#0x1	; 037FD13A
	mov r1,#0x7	; 037FD13C
	bl loc_037FB3CC	; 037FD13E
	b P2_Entry_037FD1B0	; 037FD142
P2_Case_037FD144:
	ldrh r0,[r4,#0x14]	; 037FD144
	ldr r1,[pool_037FD228]	; 037FD146
	and r0,r1	; 037FD148
	ldr r1,[pool_037FD22C]	; 037FD14A
	cmp r0,r1	; 037FD14C
	bne P2_Entry_037FD1B0	; 037FD14E
	add r0,r4,#0x0	; 037FD150
	bl P2_Entry_037FD260	; 037FD152
	b P2_Entry_037FD1B0	; 037FD156
P2_Case_037FD158:
	ldrh r0,[r4,#0x14]	; 037FD158
	ldr r1,[pool_037FD224]	; 037FD15A
	and r0,r1	; 037FD15C
	ldr r1,[pool_037FD230]	; 037FD15E
	cmp r0,r1	; 037FD160
	bne P2_Entry_037FD1B0	; 037FD162
	ldr r0,[pool_037FD200]	; 037FD164
	ldr r1,[r0,#0x0]	; 037FD166
	ldr r0,[pool_037FD234]	; 037FD168
	ldrh r0,[r1,r0]	; 037FD16A
	cmp r0,#0x0	; 037FD16C
	bne P2_Entry_037FD176	; 037FD16E
	mov r1,#0x1	; 037FD170
	ldr r0,[pool_037FD238]	; 037FD172
	strh r1,[r0,#0x0]	; 037FD174
P2_Entry_037FD176:
	ldr r0,[pool_037FD200]	; 037FD176
	ldr r2,[r0,#0x0]	; 037FD178
	ldr r0,[pool_037FD23C]	; 037FD17A
	ldr r0,[r2,r0]	; 037FD17C
	add r1,r0,#0x1	; 037FD17E
	ldr r0,[pool_037FD23C]	; 037FD180
	str r1,[r2,r0]	; 037FD182
	add r0,r4,#0x0	; 037FD184
	bl P2_Entry_037FD270	; 037FD186
	str r0,[sp,#0x4]	; 037FD18A
	b P2_Entry_037FD1B0	; 037FD18C
P2_Case_037FD18E:
	ldrh r0,[r4,#0x14]	; 037FD18E
	ldr r1,[pool_037FD224]	; 037FD190
	and r0,r1	; 037FD192
	ldr r1,[pool_037FD240]	; 037FD194
	cmp r0,r1	; 037FD196
	bne P2_Entry_037FD1B0	; 037FD198
	ldr r0,[pool_037FD200]	; 037FD19A
	ldr r2,[r0,#0x0]	; 037FD19C
	ldr r0,[pool_037FD244]	; 037FD19E
	ldr r0,[r2,r0]	; 037FD1A0
	add r1,r0,#0x1	; 037FD1A2
	ldr r0,[pool_037FD244]	; 037FD1A4
	str r1,[r2,r0]	; 037FD1A6
	add r0,r4,#0x0	; 037FD1A8
	bl P2_Entry_037FD280	; 037FD1AA
	str r0,[sp,#0x4]	; 037FD1AE
P2_Entry_037FD1B0:
	ldr r0,[sp,#0x4]	; 037FD1B0
	cmp r0,#0x0	; 037FD1B2
	beq P2_Entry_037FD1C2	; 037FD1B4
	add r0,r6,#0x0	; 037FD1B6
	add r0,#0xc	; 037FD1B8
	sub r4,#0x10	; 037FD1BA
	add r1,r4,#0x0	; 037FD1BC
	bl P2_Entry_037FB650	; 037FD1BE
P2_Entry_037FD1C2:
	ldr r0,[pool_037FD200]	; 037FD1C2
	ldr r1,[r0,#0x0]	; 037FD1C4
	ldr r0,[pool_037FD218]	; 037FD1C6
	ldrh r1,[r1,r0]	; 037FD1C8
	mov r0,#0x1	; 037FD1CA
	and r1,r0	; 037FD1CC
	cmp r1,#0x0	; 037FD1CE
	beq P2_Entry_037FD1F0	; 037FD1D0
	ldr r0,[sp,#0x20]	; 037FD1D2
P2_Entry_037FD1D4:
	ldr r1,[pool_037FD248]	; 037FD1D4
	cmp r5,r1	; 037FD1D6
	bcc P2_Entry_037FD1E4	; 037FD1D8
	ldr r1,[pool_037FD200]	; 037FD1DA
	ldr r2,[r1,#0x0]	; 037FD1DC
	ldr r1,[pool_037FD24C]	; 037FD1DE
	ldrh r1,[r2,r1]	; 037FD1E0
	sub r5,r5,r1	; 037FD1E2
P2_Entry_037FD1E4:
	ldr r1,[pool_037FD214]	; 037FD1E4
	strh r1,[r5,#0x0]	; 037FD1E6
	add r5,r5,#0x2	; 037FD1E8
	add r0,r0,#0x1	; 037FD1EA
	cmp r0,#0x7	; 037FD1EC
	bcc P2_Entry_037FD1D4	; 037FD1EE
P2_Entry_037FD1F0:
	ldr r0,[sp,#0x0]	; 037FD1F0
	add r0,r0,#0x1	; 037FD1F2
	str r0,[sp,#0x0]	; 037FD1F4
	b P2_Entry_037FCFC0	; 037FD1F6
P2_Entry_037FD1F8:
	add sp,#0x24	; 037FD1F8
	pop {r4,r5,r6,r7}	; 037FD1FA
	pop {r3}	; 037FD1FC
	bx r3	; 037FD1FE
pool_037FD200:
	.word FirmwareWlWorkPointerSlot	; 037FD200
pool_037FD204:
	.word 0x000004B4	; 037FD204
pool_037FD208:
	.word 0x00000150	; 037FD208
pool_037FD20C:
	.word REG_WIFI_RXBUF_READCSR	; 037FD20C
pool_037FD210:
	.word 0x04804000	; 037FD210
pool_037FD214:
	.word 0x0000FFFF	; 037FD214
pool_037FD218:
	.word 0x00000638	; 037FD218
pool_037FD21C:
	.word 0x00004000	; 037FD21C
pool_037FD220:
	.word 0x00000200	; 037FD220
pool_037FD224:
	.word 0x0000E7FF	; 037FD224
pool_037FD228:
	.word 0x0000E7BF	; 037FD228
pool_037FD22C:
	.word 0x00000118	; 037FD22C
pool_037FD230:
	.word 0x00000228	; 037FD230
pool_037FD234:
	.word 0x00000328	; 037FD234
pool_037FD238:
	.word REG_WIFI_POWERSTATE	; 037FD238
pool_037FD23C:
	.word 0x00000580	; 037FD23C
pool_037FD240:
	.word 0x00000218	; 037FD240
pool_037FD244:
	.word 0x00000584	; 037FD244
pool_037FD248:
	.word 0x04805F60	; 037FD248
pool_037FD24C:
	.word 0x000003B2	; 037FD24C
P2_Entry_037FD250:
	bx pc	; 037FD250
	.byte 0xC0, 0x46	; 037FD252
.arm
	ldr r12,[pool_037FD25C]	; 037FD254
	bx r12	; 037FD258
pool_037FD25C:
	.word loc_0230C6D0 + 1	; 037FD25C
P2_Entry_037FD260:
.thumb
	bx pc	; 037FD260
	.byte 0xC0, 0x46	; 037FD262
.arm
	ldr r12,[pool_037FD26C]	; 037FD264
	bx r12	; 037FD268
pool_037FD26C:
	.word P4_Entry_0230CCD4 + 1	; 037FD26C
P2_Entry_037FD270:
.thumb
	bx pc	; 037FD270
	.byte 0xC0, 0x46	; 037FD272
.arm
	ldr r12,[pool_037FD27C]	; 037FD274
	bx r12	; 037FD278
pool_037FD27C:
	.word P4_Entry_0230CE0C + 1	; 037FD27C
P2_Entry_037FD280:
.thumb
	bx pc	; 037FD280
	.byte 0xC0, 0x46	; 037FD282
.arm
	ldr r12,[pool_037FD28C]	; 037FD284
	bx r12	; 037FD288
pool_037FD28C:
	.word P4_Entry_0230CC2C + 1	; 037FD28C
.thumb
P2_Entry_037FD290:
	push {r4,lr}	; 037FD290
	ldr r0,[pool_037FD334]	; 037FD292
	ldr r1,[r0,#0x0]	; 037FD294
	ldr r0,[pool_037FD338]	; 037FD296
	add r4,r1,r0	; 037FD298
	ldrh r0,[r4,#0x3c]	; 037FD29A
	cmp r0,#0x0	; 037FD29C
	beq P2_Entry_037FD32E	; 037FD29E
	add r0,r4,#0x0	; 037FD2A0
	add r0,#0x90	; 037FD2A2
	ldr r0,[r0,#0x0]	; 037FD2A4
	ldrh r1,[r0,#0x10]	; 037FD2A6
	ldr r0,[r4,#0x44]	; 037FD2A8
	ldrh r0,[r0,#0x2]	; 037FD2AA
	cmp r1,r0	; 037FD2AC
	beq P2_Entry_037FD2B4	; 037FD2AE
	bl P2_Entry_037FCFA0	; 037FD2B0
P2_Entry_037FD2B4:
	ldr r0,[r4,#0x44]	; 037FD2B4
	ldrh r0,[r0,#0x4]	; 037FD2B6
	mov r1,#0xff	; 037FD2B8
	and r0,r1	; 037FD2BA
	cmp r0,#0x0	; 037FD2BC
	beq P2_Entry_037FD2D0	; 037FD2BE
	ldr r1,[pool_037FD334]	; 037FD2C0
	ldr r2,[r1,#0x0]	; 037FD2C2
	ldr r1,[pool_037FD33C]	; 037FD2C4
	add r1,r2,r1	; 037FD2C6
	ldr r2,[r1,#0x0]	; 037FD2C8
	add r0,r2,r0	; 037FD2CA
	str r0,[r1,#0x0]	; 037FD2CC
	b P2_Entry_037FD2DE	; 037FD2CE
P2_Entry_037FD2D0:
	ldr r0,[pool_037FD334]	; 037FD2D0
	ldr r1,[r0,#0x0]	; 037FD2D2
	ldr r0,[pool_037FD33C]	; 037FD2D4
	add r0,r1,r0	; 037FD2D6
	ldr r1,[r0,#0x0]	; 037FD2D8
	add r1,r1,#0x1	; 037FD2DA
	str r1,[r0,#0x0]	; 037FD2DC
P2_Entry_037FD2DE:
	add r0,r4,#0x0	; 037FD2DE
	add r0,#0x40	; 037FD2E0
	ldrh r0,[r0,#0x0]	; 037FD2E2
	add r1,r0,#0x1	; 037FD2E4
	add r0,r4,#0x0	; 037FD2E6
	add r0,#0x40	; 037FD2E8
	strh r1,[r0,#0x0]	; 037FD2EA
	add r0,r4,#0x0	; 037FD2EC
	add r0,#0x90	; 037FD2EE
	ldr r2,[r0,#0x0]	; 037FD2F0
	ldrh r1,[r2,#0x10]	; 037FD2F2
	ldr r0,[r4,#0x44]	; 037FD2F4
	ldrh r0,[r0,#0x2]	; 037FD2F6
	eor r1,r0	; 037FD2F8
	strh r1,[r2,#0x12]	; 037FD2FA
	add r0,r4,#0x0	; 037FD2FC
	add r0,#0x90	; 037FD2FE
	ldr r0,[r0,#0x0]	; 037FD300
	ldrh r1,[r0,#0x10]	; 037FD302
	add r0,r4,#0x0	; 037FD304
	add r0,#0xa0	; 037FD306
	strh r1,[r0,#0x0]	; 037FD308
	mov r0,#0x0	; 037FD30A
	strh r0,[r4,#0x3c]	; 037FD30C
	ldr r0,[pool_037FD334]	; 037FD30E
	ldr r1,[r0,#0x0]	; 037FD310
	ldr r0,[pool_037FD340]	; 037FD312
	ldrh r0,[r1,r0]	; 037FD314
	cmp r0,#0x0	; 037FD316
	beq P2_Entry_037FD31E	; 037FD318
	bl loc_037FBD78	; 037FD31A
P2_Entry_037FD31E:
	ldr r0,[pool_037FD334]	; 037FD31E
	ldr r1,[r0,#0x0]	; 037FD320
	ldr r0,[pool_037FD344]	; 037FD322
	add r0,r1,r0	; 037FD324
	add r4,#0x90	; 037FD326
	ldr r1,[r4,#0x0]	; 037FD328
	bl loc_037FB968	; 037FD32A
P2_Entry_037FD32E:
	pop {r4}	; 037FD32E
	pop {r3}	; 037FD330
	bx r3	; 037FD332
pool_037FD334:
	.word FirmwareWlWorkPointerSlot	; 037FD334
pool_037FD338:
	.word 0x00000400	; 037FD338
pool_037FD33C:
	.word 0x00000574	; 037FD33C
pool_037FD340:
	.word 0x000003BE	; 037FD340
pool_037FD344:
	.word 0x0000015C	; 037FD344
	.byte 0x10, 0xB5, 0x19, 0x48, 0x00, 0x68, 0x19, 0x49, 0x44, 0x18, 0x19, 0x49, 0x09, 0x88, 0x00, 0x29	; 037FD348
	.byte 0x08, 0xD1, 0x21, 0x8F, 0x00, 0x29, 0x05, 0xD0, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FD358
	.byte 0x2F, 0xF8, 0x1D, 0xE0, 0x14, 0x49, 0x42, 0x5A, 0x14, 0x49, 0x40, 0x5A, 0x82, 0x43, 0x00, 0x2A	; 037FD368
	.byte 0x07, 0xD1, 0x08, 0x21, 0x0F, 0x48, 0x01, 0x80, 0x20, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0	; 037FD378
	.byte 0x1F, 0xF8, 0x05, 0x21, 0x0B, 0x48, 0x01, 0x80, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 037FD388
	.byte 0x00, 0xF0, 0x1E, 0xF8, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0x18, 0xF8	; 037FD398
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00	; 037FD3A8
	.byte 0x88, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 037FD3B8
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x81, 0xAE, 0x30, 0x02	; 037FD3C8
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x0D, 0xAF, 0x30, 0x02	; 037FD3D8
P2_Entry_037FD3E8:
	push {r4,r5,r6,lr}	; 037FD3E8
	add r6,r0,#0x0	; 037FD3EA
	add r5,r1,#0x0	; 037FD3EC
	ldr r0,[pool_037FD438]	; 037FD3EE
	ldr r1,[r0,#0x0]	; 037FD3F0
	ldr r0,[pool_037FD43C]	; 037FD3F2
	add r0,r1,r0	; 037FD3F4
	add r1,r5,#0x0	; 037FD3F6
	add r1,#0x22	; 037FD3F8
	bl P2_Entry_037FB5E4	; 037FD3FA
	cmp r0,#0x0	; 037FD3FE
	bne P2_Entry_037FD406	; 037FD400
	mov r0,#0x0	; 037FD402
	b P2_Entry_037FD430	; 037FD404
P2_Entry_037FD406:
	add r4,r0,#0x0	; 037FD406
	add r4,#0x10	; 037FD408
	add r0,r4,#0x0	; 037FD40A
	add r0,#0x8	; 037FD40C
	add r1,r6,#0x0	; 037FD40E
	add r2,r5,#0x0	; 037FD410
	add r2,#0xc	; 037FD412
	bl P2_Entry_037FD440	; 037FD414
	sub r5,#0x18	; 037FD418
	strh r5,[r4,#0x6]	; 037FD41A
	ldrh r2,[r4,#0xe]	; 037FD41C
	mov r0,#0xff	; 037FD41E
	and r2,r0	; 037FD420
	ldrh r1,[r4,#0x12]	; 037FD422
	and r1,r0	; 037FD424
	lsl r0,r1,#0x10	; 037FD426
	lsr r0,r0,#0x8	; 037FD428
	orr r2,r0	; 037FD42A
	strh r2,[r4,#0xe]	; 037FD42C
	add r0,r4,#0x0	; 037FD42E
P2_Entry_037FD430:
	pop {r4,r5,r6}	; 037FD430
	pop {r3}	; 037FD432
	bx r3	; 037FD434
	.byte 0xC0, 0x46	; 037FD436
pool_037FD438:
	.word FirmwareWlWorkPointerSlot	; 037FD438
pool_037FD43C:
	.word 0x0000015C	; 037FD43C
P2_Entry_037FD440:
	bx pc	; 037FD440
	.byte 0xC0, 0x46	; 037FD442
.arm
	ldr r12,[pool_037FD44C]	; 037FD444
	bx r12	; 037FD448
pool_037FD44C:
	.word loc_023052B4 + 1	; 037FD44C
.thumb

; ===== function loc_037FD450 =====
loc_037FD450:
	push {r4,r5,r6,r7,lr}	; 037FD450
	sub sp,#0x4	; 037FD452
	ldr r0,[pool_037FD610]	; 037FD454
	ldr r6,[r0,#0x0]	; 037FD456
	ldr r0,[pool_037FD614]	; 037FD458
	add r4,r6,r0	; 037FD45A
	ldr r0,[pool_037FD618]	; 037FD45C
	add r5,r6,r0	; 037FD45E
	ldr r0,[pool_037FD61C]	; 037FD460
	add r7,r6,r0	; 037FD462
	mov r0,#0x0	; 037FD464
	str r0,[sp,#0x0]	; 037FD466
	ldr r0,[sp,#0x0]	; 037FD468
	add r1,r4,#0x0	; 037FD46A
	mov r2,#0xb4	; 037FD46C
	bl loc_037FD6DC	; 037FD46E
	mov r1,#0x0	; 037FD472
	ldr r0,[pool_037FD614]	; 037FD474
	strh r1,[r6,r0]	; 037FD476
	str r1,[r4,#0xc]	; 037FD478
	strh r1,[r4,#0x14]	; 037FD47A
	str r1,[r4,#0x20]	; 037FD47C
	strh r1,[r4,#0x28]	; 037FD47E
	str r1,[r4,#0x34]	; 037FD480
	ldr r1,[pool_037FD620]	; 037FD482
	add r0,r4,#0x0	; 037FD484
	add r0,#0xa4	; 037FD486
	strh r1,[r0,#0x0]	; 037FD488
	add r0,r4,#0x0	; 037FD48A
	add r0,#0xa6	; 037FD48C
	strh r1,[r0,#0x0]	; 037FD48E
	ldrh r0,[r5,#0xc]	; 037FD490
	cmp r0,#0x3	; 037FD492
	bls loc_037FD498	; 037FD494
	b loc_037FD5F2	; 037FD496
loc_037FD498:
	add r0,r0,r0	; 037FD498
P2_SwitchIndexPC_037FD498:
	add r0,pc	; 037FD49A
	ldrh r0,[r0,#(P2_SwitchTable_037FD498 - (P2_SwitchIndexPC_037FD498 + 4))]	; 037FD49C
	lsl r0,r0,#0x10	; 037FD49E
	asr r0,r0,#0x10	; 037FD4A0
P2_SwitchTargetPC_037FD498:
	add r0,pc	; 037FD4A2
	bx r0	; 037FD4A4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD498:
	.halfword (loc_037FD4AE + 1) - (P2_SwitchTargetPC_037FD498 + 4)
	.halfword (loc_037FD4F2 + 1) - (P2_SwitchTargetPC_037FD498 + 4)
	.halfword (loc_037FD554 + 1) - (P2_SwitchTargetPC_037FD498 + 4)
	.halfword (loc_037FD5B0 + 1) - (P2_SwitchTargetPC_037FD498 + 4)
P2_SwitchTable_037FD498End:
loc_037FD4AE:
	ldr r0,[pool_037FD624]	; 037FD4AE
	str r0,[r4,#0x8]	; 037FD4B0
	ldr r0,[pool_037FD628]	; 037FD4B2
	str r0,[r4,#0x1c]	; 037FD4B4
	ldr r0,[pool_037FD62C]	; 037FD4B6
	str r0,[r4,#0x30]	; 037FD4B8
	ldr r0,[pool_037FD630]	; 037FD4BA
	str r0,[r4,#0x10]	; 037FD4BC
	ldr r0,[pool_037FD634]	; 037FD4BE
	str r0,[r4,#0x24]	; 037FD4C0
	ldr r0,[pool_037FD638]	; 037FD4C2
	str r0,[r4,#0x38]	; 037FD4C4
	ldr r1,[pool_037FD63C]	; 037FD4C6
	ldr r0,[pool_037FD640]	; 037FD4C8
	strh r1,[r0,#0x0]	; 037FD4CA
	ldr r0,[pool_037FD644]	; 037FD4CC
	ldr r2,[pool_037FD648]	; 037FD4CE
	strh r0,[r2,#0x0]	; 037FD4D0
	ldr r2,[pool_037FD64C]	; 037FD4D2
	strh r1,[r2,#0x0]	; 037FD4D4
	ldr r2,[pool_037FD650]	; 037FD4D6
	strh r0,[r2,#0x0]	; 037FD4D8
	ldr r2,[pool_037FD654]	; 037FD4DA
	strh r1,[r2,#0x0]	; 037FD4DC
	ldr r1,[pool_037FD658]	; 037FD4DE
	strh r0,[r1,#0x0]	; 037FD4E0
	mov r1,#0x8	; 037FD4E2
	add r0,r5,#0x0	; 037FD4E4
	add r0,#0x8a	; 037FD4E6
	strh r1,[r0,#0x0]	; 037FD4E8
	mov r1,#0x1	; 037FD4EA
	ldr r0,[pool_037FD65C]	; 037FD4EC
	strh r1,[r0,#0x0]	; 037FD4EE
	b loc_037FD5F2	; 037FD4F0
loc_037FD4F2:
	ldr r0,[pool_037FD660]	; 037FD4F2
	str r0,[r4,#0x8]	; 037FD4F4
	ldr r0,[pool_037FD664]	; 037FD4F6
	str r0,[r4,#0x1c]	; 037FD4F8
	ldr r0,[pool_037FD668]	; 037FD4FA
	str r0,[r4,#0x30]	; 037FD4FC
	ldr r0,[pool_037FD630]	; 037FD4FE
	str r0,[r4,#0x10]	; 037FD500
	ldr r0,[pool_037FD634]	; 037FD502
	str r0,[r4,#0x24]	; 037FD504
	ldr r0,[pool_037FD66C]	; 037FD506
	str r0,[r4,#0x38]	; 037FD508
	ldr r2,[pool_037FD670]	; 037FD50A
	add r0,r4,#0x0	; 037FD50C
	add r0,#0x80	; 037FD50E
	str r2,[r0,#0x0]	; 037FD510
	ldr r0,[pool_037FD62C]	; 037FD512
	str r0,[r4,#0x44]	; 037FD514
	ldr r1,[pool_037FD63C]	; 037FD516
	ldr r0,[pool_037FD674]	; 037FD518
	strh r1,[r0,#0x0]	; 037FD51A
	ldr r0,[pool_037FD644]	; 037FD51C
	ldr r3,[pool_037FD678]	; 037FD51E
	strh r0,[r3,#0x0]	; 037FD520
	ldr r3,[pool_037FD67C]	; 037FD522
	strh r1,[r3,#0x0]	; 037FD524
	ldr r3,[pool_037FD680]	; 037FD526
	strh r0,[r3,#0x0]	; 037FD528
	ldr r3,[pool_037FD684]	; 037FD52A
	strh r1,[r3,#0x0]	; 037FD52C
	ldr r3,[pool_037FD688]	; 037FD52E
	strh r0,[r3,#0x0]	; 037FD530
	ldr r3,[pool_037FD68C]	; 037FD532
	strh r1,[r3,#0x0]	; 037FD534
	ldr r3,[pool_037FD690]	; 037FD536
	strh r0,[r3,#0x0]	; 037FD538
	ldr r3,[pool_037FD694]	; 037FD53A
	strh r1,[r3,#0x0]	; 037FD53C
	ldr r1,[pool_037FD698]	; 037FD53E
	strh r0,[r1,#0x0]	; 037FD540
	ldr r1,[pool_037FD69C]	; 037FD542
	add r0,r5,#0x0	; 037FD544
	add r0,#0x8a	; 037FD546
	strh r1,[r0,#0x0]	; 037FD548
	add r4,#0x80	; 037FD54A
	str r2,[r4,#0x0]	; 037FD54C
	bl loc_037FD6E8	; 037FD54E
	b loc_037FD5F2	; 037FD552
loc_037FD554:
	ldr r0,[pool_037FD6A0]	; 037FD554
	str r0,[r4,#0x8]	; 037FD556
	ldr r0,[pool_037FD6A4]	; 037FD558
	str r0,[r4,#0x1c]	; 037FD55A
	ldr r0,[pool_037FD6A8]	; 037FD55C
	str r0,[r4,#0x30]	; 037FD55E
	ldr r0,[pool_037FD630]	; 037FD560
	str r0,[r4,#0x10]	; 037FD562
	ldr r0,[pool_037FD634]	; 037FD564
	str r0,[r4,#0x24]	; 037FD566
	ldr r0,[pool_037FD638]	; 037FD568
	str r0,[r4,#0x38]	; 037FD56A
	ldr r0,[pool_037FD62C]	; 037FD56C
	str r0,[r4,#0x58]	; 037FD56E
	ldr r0,[pool_037FD674]	; 037FD570
	str r0,[r4,#0x6c]	; 037FD572
	ldr r1,[pool_037FD63C]	; 037FD574
	ldr r0,[pool_037FD6AC]	; 037FD576
	strh r1,[r0,#0x0]	; 037FD578
	ldr r0,[pool_037FD644]	; 037FD57A
	ldr r2,[pool_037FD6B0]	; 037FD57C
	strh r0,[r2,#0x0]	; 037FD57E
	ldr r2,[pool_037FD6B4]	; 037FD580
	strh r1,[r2,#0x0]	; 037FD582
	ldr r2,[pool_037FD6B8]	; 037FD584
	strh r0,[r2,#0x0]	; 037FD586
	ldr r2,[pool_037FD6BC]	; 037FD588
	strh r1,[r2,#0x0]	; 037FD58A
	ldr r2,[pool_037FD6C0]	; 037FD58C
	strh r0,[r2,#0x0]	; 037FD58E
	ldr r2,[pool_037FD6C4]	; 037FD590
	strh r1,[r2,#0x0]	; 037FD592
	ldr r2,[pool_037FD6C8]	; 037FD594
	strh r0,[r2,#0x0]	; 037FD596
	ldr r2,[pool_037FD6CC]	; 037FD598
	strh r1,[r2,#0x0]	; 037FD59A
	ldr r1,[pool_037FD6D0]	; 037FD59C
	strh r0,[r1,#0x0]	; 037FD59E
	ldr r1,[pool_037FD6D4]	; 037FD5A0
	add r0,r5,#0x0	; 037FD5A2
	add r0,#0x8a	; 037FD5A4
	strh r1,[r0,#0x0]	; 037FD5A6
	mov r1,#0xd	; 037FD5A8
	ldr r0,[pool_037FD65C]	; 037FD5AA
	strh r1,[r0,#0x0]	; 037FD5AC
	b loc_037FD5F2	; 037FD5AE
loc_037FD5B0:
	ldr r0,[pool_037FD624]	; 037FD5B0
	str r0,[r4,#0x8]	; 037FD5B2
	ldr r0,[pool_037FD628]	; 037FD5B4
	str r0,[r4,#0x1c]	; 037FD5B6
	ldr r0,[pool_037FD62C]	; 037FD5B8
	str r0,[r4,#0x30]	; 037FD5BA
	ldr r0,[pool_037FD630]	; 037FD5BC
	str r0,[r4,#0x10]	; 037FD5BE
	ldr r0,[pool_037FD634]	; 037FD5C0
	str r0,[r4,#0x24]	; 037FD5C2
	ldr r0,[pool_037FD638]	; 037FD5C4
	str r0,[r4,#0x38]	; 037FD5C6
	ldr r1,[pool_037FD63C]	; 037FD5C8
	ldr r0,[pool_037FD640]	; 037FD5CA
	strh r1,[r0,#0x0]	; 037FD5CC
	ldr r0,[pool_037FD644]	; 037FD5CE
	ldr r2,[pool_037FD648]	; 037FD5D0
	strh r0,[r2,#0x0]	; 037FD5D2
	ldr r2,[pool_037FD64C]	; 037FD5D4
	strh r1,[r2,#0x0]	; 037FD5D6
	ldr r2,[pool_037FD650]	; 037FD5D8
	strh r0,[r2,#0x0]	; 037FD5DA
	ldr r2,[pool_037FD654]	; 037FD5DC
	strh r1,[r2,#0x0]	; 037FD5DE
	ldr r1,[pool_037FD658]	; 037FD5E0
	strh r0,[r1,#0x0]	; 037FD5E2
	ldr r1,[pool_037FD6D4]	; 037FD5E4
	add r0,r5,#0x0	; 037FD5E6
	add r0,#0x8a	; 037FD5E8
	strh r1,[r0,#0x0]	; 037FD5EA
	mov r1,#0xd	; 037FD5EC
	ldr r0,[pool_037FD65C]	; 037FD5EE
	strh r1,[r0,#0x0]	; 037FD5F0
loc_037FD5F2:
	ldrh r0,[r7,#0x18]	; 037FD5F2
	cmp r0,#0x0	; 037FD5F4
	beq loc_037FD606	; 037FD5F6
	add r0,r5,#0x0	; 037FD5F8
	add r0,#0x8a	; 037FD5FA
	ldrh r1,[r0,#0x0]	; 037FD5FC
	ldr r0,[pool_037FD6D8]	; 037FD5FE
	orr r1,r0	; 037FD600
	add r5,#0x8a	; 037FD602
	strh r1,[r5,#0x0]	; 037FD604
loc_037FD606:
	add sp,#0x4	; 037FD606
	pop {r4,r5,r6,r7}	; 037FD608
	pop {r3}	; 037FD60A
	bx r3	; 037FD60C
	.byte 0xC0, 0x46	; 037FD610
pool_037FD610:
loc_037FD610:
	.word FirmwareWlWorkPointerSlot	; 037FD610
pool_037FD614:
loc_037FD614:
	.word 0x00000400	; 037FD614
pool_037FD618:
loc_037FD618:
	.word 0x00000318	; 037FD618
pool_037FD61C:
loc_037FD61C:
	.word 0x000002F0	; 037FD61C
pool_037FD620:
loc_037FD620:
	.word 0x0000FFFF	; 037FD620
pool_037FD624:
loc_037FD624:
	.word 0x04804170	; 037FD624
pool_037FD628:
loc_037FD628:
	.word 0x04804028	; 037FD628
pool_037FD62C:
loc_037FD62C:
	.word 0x04804000	; 037FD62C
pool_037FD630:
loc_037FD630:
	.word 0x0230AC71	; 037FD630
pool_037FD634:
loc_037FD634:
	.word 0x0230A9C1	; 037FD634
pool_037FD638:
loc_037FD638:
	.word 0x0230A971	; 037FD638
pool_037FD63C:
loc_037FD63C:
	.word 0x0000B6B8	; 037FD63C
pool_037FD640:
loc_037FD640:
	.word WifiRamBase + 0x24	; 037FD640
pool_037FD644:
loc_037FD644:
	.word 0x00001D46	; 037FD644
pool_037FD648:
loc_037FD648:
	.word WifiRamBase + 0x26	; 037FD648
pool_037FD64C:
loc_037FD64C:
	.word WifiRamBase + 0x16C	; 037FD64C
pool_037FD650:
loc_037FD650:
	.word WifiRamBase + 0x16E	; 037FD650
pool_037FD654:
loc_037FD654:
	.word WifiRamBase + 0x790	; 037FD654
pool_037FD658:
loc_037FD658:
	.word WifiRamBase + 0x792	; 037FD658
pool_037FD65C:
loc_037FD65C:
	.word REG_WIFI_TXREQ_SET	; 037FD65C
pool_037FD660:
loc_037FD660:
	.word 0x04804AA0	; 037FD660
pool_037FD664:
loc_037FD664:
	.word 0x04804958	; 037FD664
pool_037FD668:
loc_037FD668:
	.word 0x04804334	; 037FD668
pool_037FD66C:
loc_037FD66C:
	.word 0x0230A8A5	; 037FD66C
pool_037FD670:
loc_037FD670:
	.word 0x04804238	; 037FD670
pool_037FD674:
loc_037FD674:
	.word WifiRamBase + 0x234	; 037FD674
pool_037FD678:
loc_037FD678:
	.word WifiRamBase + 0x236	; 037FD678
pool_037FD67C:
loc_037FD67C:
	.word WifiRamBase + 0x330	; 037FD67C
pool_037FD680:
loc_037FD680:
	.word WifiRamBase + 0x332	; 037FD680
pool_037FD684:
loc_037FD684:
	.word WifiRamBase + 0x954	; 037FD684
pool_037FD688:
loc_037FD688:
	.word WifiRamBase + 0x956	; 037FD688
pool_037FD68C:
loc_037FD68C:
	.word WifiRamBase + 0xA9C	; 037FD68C
pool_037FD690:
loc_037FD690:
	.word WifiRamBase + 0xA9E	; 037FD690
pool_037FD694:
loc_037FD694:
	.word WifiRamBase + 0x10C0	; 037FD694
pool_037FD698:
loc_037FD698:
	.word WifiRamBase + 0x10C2	; 037FD698
pool_037FD69C:
loc_037FD69C:
	.word 0x00000208	; 037FD69C
pool_037FD6A0:
loc_037FD6A0:
	.word 0x048045D8	; 037FD6A0
pool_037FD6A4:
loc_037FD6A4:
	.word 0x04804490	; 037FD6A4
pool_037FD6A8:
loc_037FD6A8:
	.word 0x04804468	; 037FD6A8
pool_037FD6AC:
loc_037FD6AC:
	.word WifiRamBase + 0x230	; 037FD6AC
pool_037FD6B0:
loc_037FD6B0:
	.word WifiRamBase + 0x232	; 037FD6B0
pool_037FD6B4:
loc_037FD6B4:
	.word WifiRamBase + 0x464	; 037FD6B4
pool_037FD6B8:
loc_037FD6B8:
	.word WifiRamBase + 0x466	; 037FD6B8
pool_037FD6BC:
loc_037FD6BC:
	.word WifiRamBase + 0x48C	; 037FD6BC
pool_037FD6C0:
loc_037FD6C0:
	.word WifiRamBase + 0x48E	; 037FD6C0
pool_037FD6C4:
loc_037FD6C4:
	.word WifiRamBase + 0x5D4	; 037FD6C4
pool_037FD6C8:
loc_037FD6C8:
	.word WifiRamBase + 0x5D6	; 037FD6C8
pool_037FD6CC:
loc_037FD6CC:
	.word WifiRamBase + 0xBF8	; 037FD6CC
pool_037FD6D0:
loc_037FD6D0:
	.word WifiRamBase + 0xBFA	; 037FD6D0
pool_037FD6D4:
loc_037FD6D4:
	.word 0x00000108	; 037FD6D4
pool_037FD6D8:
loc_037FD6D8:
	.word 0x00004000	; 037FD6D8

; ===== function loc_037FD6DC =====
loc_037FD6DC:
	bx pc	; 037FD6DC
	.byte 0xC0, 0x46	; 037FD6E0
.arm

; ===== function loc_037FD6E0 =====
loc_037FD6E0:
	ldr pc,[pool_037FD6E4]	; 037FD6E0
pool_037FD6E4:
loc_037FD6E4:
	.word loc_037FF358	; 037FD6E4
.thumb

; ===== function loc_037FD6E8 =====
loc_037FD6E8:
	bx pc	; 037FD6E8
	.byte 0xC0, 0x46	; 037FD6EC
.arm

; ===== function loc_037FD6EC =====
loc_037FD6EC:
	ldr r12,[pool_037FD6F4]	; 037FD6EC
	bx r12	; 037FD6F0
pool_037FD6F4:
loc_037FD6F4:
	.word P4_Entry_0230A0B4 + 1	; 037FD6F4
.thumb

; ===== function loc_037FD6F8 =====
loc_037FD6F8:
	push {r4,r5,r6,lr}	; 037FD6F8
	sub sp,#0x8	; 037FD6FA
	ldr r0,[pool_037FD788]	; 037FD6FC
	ldr r1,[r0,#0x0]	; 037FD6FE
	ldr r0,[pool_037FD78C]	; 037FD700
	add r6,r1,r0	; 037FD702
	ldr r0,[pool_037FD790]	; 037FD704
	add r4,r1,r0	; 037FD706
	mov r0,#0x0	; 037FD708
	str r0,[sp,#0x0]	; 037FD70A
	ldr r0,[sp,#0x0]	; 037FD70C
	add r1,r4,#0x0	; 037FD70E
	mov r2,#0x50	; 037FD710
	bl loc_037FD7D8	; 037FD712
	ldr r1,[pool_037FD794]	; 037FD716
	ldr r0,[pool_037FD798]	; 037FD718
	strh r1,[r0,#0x0]	; 037FD71A
	ldr r0,[pool_037FD788]	; 037FD71C
	ldr r1,[r0,#0x0]	; 037FD71E
	ldr r0,[pool_037FD79C]	; 037FD720
	ldrh r0,[r1,r0]	; 037FD722
	cmp r0,#0x3	; 037FD724
	bhi loc_037FD74C	; 037FD726
	add r0,r0,r0	; 037FD728
P2_SwitchIndexPC_037FD728:
	add r0,pc	; 037FD72A
	ldrh r0,[r0,#(P2_SwitchTable_037FD728 - (P2_SwitchIndexPC_037FD728 + 4))]	; 037FD72C
	lsl r0,r0,#0x10	; 037FD72E
	asr r0,r0,#0x10	; 037FD730
P2_SwitchTargetPC_037FD728:
	add r0,pc	; 037FD732
	bx r0	; 037FD734
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD728:
	.halfword (loc_037FD73E + 1) - (P2_SwitchTargetPC_037FD728 + 4)
	.halfword (loc_037FD742 + 1) - (P2_SwitchTargetPC_037FD728 + 4)
	.halfword (loc_037FD746 + 1) - (P2_SwitchTargetPC_037FD728 + 4)
	.halfword (loc_037FD74A + 1) - (P2_SwitchTargetPC_037FD728 + 4)
P2_SwitchTable_037FD728End:
loc_037FD73E:
	ldr r5,[pool_037FD7A0]	; 037FD73E
	b loc_037FD74C	; 037FD740
loc_037FD742:
	ldr r5,[pool_037FD7A4]	; 037FD742
	b loc_037FD74C	; 037FD744
loc_037FD746:
	ldr r5,[pool_037FD7A8]	; 037FD746
	b loc_037FD74C	; 037FD748
loc_037FD74A:
	ldr r5,[pool_037FD7A0]	; 037FD74A
loc_037FD74C:
	ldr r0,[pool_037FD7AC]	; 037FD74C
	add r1,r5,r0	; 037FD74E
	ldr r0,[pool_037FD7B0]	; 037FD750
	strh r1,[r0,#0x0]	; 037FD752
	lsl r0,r5,#0xf	; 037FD754
	lsr r2,r0,#0x10	; 037FD756
	ldr r0,[pool_037FD7B4]	; 037FD758
	strh r2,[r0,#0x0]	; 037FD75A
	ldr r1,[pool_037FD7B8]	; 037FD75C
	ldr r0,[pool_037FD7BC]	; 037FD75E
	strh r1,[r0,#0x0]	; 037FD760
	ldr r0,[pool_037FD7C0]	; 037FD762
	strh r2,[r0,#0x0]	; 037FD764
	strh r2,[r4,#0x4]	; 037FD766
	ldr r0,[pool_037FD7C4]	; 037FD768
	strh r0,[r4,#0x0]	; 037FD76A
	ldr r0,[pool_037FD7C8]	; 037FD76C
	sub r0,r0,r5	; 037FD76E
	add r6,#0x9a	; 037FD770
	strh r0,[r6,#0x0]	; 037FD772
	ldr r1,[pool_037FD7CC]	; 037FD774
	ldr r0,[pool_037FD7D0]	; 037FD776
	strh r1,[r0,#0x0]	; 037FD778
	ldr r1,[pool_037FD7D4]	; 037FD77A
	ldr r0,[pool_037FD798]	; 037FD77C
	strh r1,[r0,#0x0]	; 037FD77E
	add sp,#0x8	; 037FD780
	pop {r4,r5,r6}	; 037FD782
	pop {r3}	; 037FD784
	bx r3	; 037FD786
pool_037FD788:
loc_037FD788:
	.word FirmwareWlWorkPointerSlot	; 037FD788
pool_037FD78C:
loc_037FD78C:
	.word 0x00000318	; 037FD78C
pool_037FD790:
loc_037FD790:
	.word 0x000004B4	; 037FD790
pool_037FD794:
loc_037FD794:
	.word 0x00008000	; 037FD794
pool_037FD798:
loc_037FD798:
	.word REG_WIFI_RXCNT	; 037FD798
pool_037FD79C:
loc_037FD79C:
	.word 0x00000324	; 037FD79C
pool_037FD7A0:
loc_037FD7A0:
	.word 0x00000794	; 037FD7A0
pool_037FD7A4:
loc_037FD7A4:
	.word 0x000010C4	; 037FD7A4
pool_037FD7A8:
loc_037FD7A8:
	.word 0x00000BFC	; 037FD7A8
pool_037FD7AC:
loc_037FD7AC:
	.word 0x04804000	; 037FD7AC
pool_037FD7B0:
loc_037FD7B0:
	.word REG_WIFI_RXBUF_BEGIN	; 037FD7B0
pool_037FD7B4:
loc_037FD7B4:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FD7B4
pool_037FD7B8:
loc_037FD7B8:
	.word 0x00005F60	; 037FD7B8
pool_037FD7BC:
loc_037FD7BC:
	.word REG_WIFI_RXBUF_END	; 037FD7BC
pool_037FD7C0:
loc_037FD7C0:
	.word REG_WIFI_RXBUF_READCSR	; 037FD7C0
pool_037FD7C4:
loc_037FD7C4:
	.word 0x0000FFFF	; 037FD7C4
pool_037FD7C8:
loc_037FD7C8:
	.word 0x00001F60	; 037FD7C8
pool_037FD7CC:
loc_037FD7CC:
	.word 0x00005F5E	; 037FD7CC
pool_037FD7D0:
loc_037FD7D0:
	.word REG_WIFI_RXBUF_GAP	; 037FD7D0
pool_037FD7D4:
loc_037FD7D4:
	.word 0x00008001	; 037FD7D4

; ===== function loc_037FD7D8 =====
loc_037FD7D8:
	bx pc	; 037FD7D8
	.byte 0xC0, 0x46	; 037FD7DC
.arm

; ===== function loc_037FD7DC =====
loc_037FD7DC:
	ldr pc,[pool_037FD7E0]	; 037FD7DC
pool_037FD7E0:
loc_037FD7E0:
	.word loc_037FF358	; 037FD7E0

; ===== function loc_037FD7E4 =====
; 取已启用的待处理中断，清除请求并调用对应回调。
; Select an enabled pending IRQ, acknowledge it and call its registered handler.
.func P2_DispatchIrq
	stmdb sp!,{lr}	; 037FD7E4
	mov r12,#0x4000000	; 037FD7E8
	add r12,r12,#0x210	; 037FD7EC
	ldr r1,[r12,#-0x8]	; 037FD7F0
	cmp r1,#0x0	; 037FD7F4
	ldmeqia sp!,{pc}	; 037FD7F8
	ldmia r12,{r1,r2}	; 037FD7FC
	ands r1,r1,r2	; 037FD800
	ldmeqia sp!,{pc}	; 037FD804
	mov r3,#0x1	; 037FD808
	mov r0,#0x0	; 037FD80C
loc_037FD810:
	ands r2,r1,r3, lsl r0	; 037FD810
	addeq r0,r0,#0x1	; 037FD814
	beq loc_037FD810	; 037FD818
	str r2,[r12,#0x4]	; 037FD81C
	ldr r1,[pool_037FD830]	; 037FD820
	ldr r0,[r1,r0,lsl #0x2]	; 037FD824
	ldr lr,[pool_037FD834]	; 037FD828
	bx r0	; 037FD82C
.endfunc
pool_037FD830:
loc_037FD830:
	.word P2_IrqHandlers	; 037FD830
pool_037FD834:
loc_037FD834:
	.word P2_IrqReturnContinuation	; 037FD834
; 中断回调返回后处理待执行状态，必要时保存并切换执行上下文。
; After the IRQ callback, process pending state and save/switch context when needed.
.func P2_IrqReturnContinuation
	ldr r12,[pool_037FD94C]	; 037FD838
	ldrh r3,[r12,#0x0]	; 037FD83C
	mov r0,#0x0	; 037FD840
	cmp r3,#0x0	; 037FD844
	beq P2_Entry_037FD880	; 037FD848
	strh r0,[r12,#0x0]	; 037FD84C
	ldr r12,[pool_037FD950]	; 037FD850
	mov r1,#0x1	; 037FD854
	strh r1,[r12,#0x0]	; 037FD858
	ldr r12,[r12,#0xc]	; 037FD85C
	mov r2,#0x1	; 037FD860
P2_Entry_037FD864:
	cmp r12,#0x0	; 037FD864
	beq P2_Entry_037FD880	; 037FD868
	ldr r0,[r12,#0x50]	; 037FD86C
	tst r3,r1, lsl r0	; 037FD870
	strne r2,[r12,#0x48]	; 037FD874
	ldr r12,[r12,#0x4c]	; 037FD878
	b P2_Entry_037FD864	; 037FD87C
P2_Entry_037FD880:
	ldr r12,[pool_037FD950]	; 037FD880
	ldrh r1,[r12,#0x0]	; 037FD884
	cmp r1,#0x0	; 037FD888
	ldreq pc,[sp],#0x4	; 037FD88C
	mov r1,#0x0	; 037FD890
	strh r1,[r12,#0x0]	; 037FD894
	mov r3,#0xd2	; 037FD898
	msr cpsr_c,r3	; 037FD89C
	add r2,r12,#0xc	; 037FD8A0
	ldr r1,[r2,#0x0]	; 037FD8A4
P2_Entry_037FD8A8:
	cmp r1,#0x0	; 037FD8A8
	ldrneh r0,[r1,#0x48]	; 037FD8AC
	cmpne r0,#0x1	; 037FD8B0
	ldrne r1,[r1,#0x4c]	; 037FD8B4
	bne P2_Entry_037FD8A8	; 037FD8B8
	cmp r1,#0x0	; 037FD8BC
	bne P2_Entry_037FD8D0	; 037FD8C0
P2_Entry_037FD8C4:
	mov r3,#0x92	; 037FD8C4
	msr cpsr_c,r3	; 037FD8C8
	ldr pc,[sp],#0x4	; 037FD8CC
P2_Entry_037FD8D0:
	ldr r0,[r12,#0x8]	; 037FD8D0
	cmp r1,r0	; 037FD8D4
	beq P2_Entry_037FD8C4	; 037FD8D8
	ldr r3,[r12,#0x10]	; 037FD8DC
	cmp r3,#0x0	; 037FD8E0
	beq P2_Entry_037FD8F8	; 037FD8E4
	stmdb sp!,{r0,r1,r12}	; 037FD8E8
	mov lr,pc	; 037FD8EC
	bx r3	; 037FD8F0
	ldmia sp!,{r0,r1,r12}	; 037FD8F4
P2_Entry_037FD8F8:
	str r1,[r12,#0x8]	; 037FD8F8
	mrs r2,spsr	; 037FD8FC
	str r2,[r0,#0x0]!	; 037FD900
	ldmib sp!,{r2,r3}	; 037FD904
	stmib r0!,{r2,r3}	; 037FD908
	ldmib sp!,{r2,r3,r12,lr}	; 037FD90C
	stmib r0!,{r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FD910
	stmib r0!,{lr}	; 037FD914
	mov r3,#0xd3	; 037FD918
	msr cpsr_c,r3	; 037FD91C
	stmib r0!,{sp}	; 037FD920
	ldr sp,[r1,#0x44]	; 037FD924
	mov r3,#0xd2	; 037FD928
	msr cpsr_c,r3	; 037FD92C
	ldr r2,[r1,#0x0]!	; 037FD930
	msr spsr_cf,r2	; 037FD934
	ldr lr,[r1,#0x40]	; 037FD938
	ldmib r1!,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FD93C
	mov r0,r0	; 037FD940
	stmda sp!,{r0,r1,r2,r3,r12,lr}	; 037FD944
	ldmia sp!,{pc}	; 037FD948
.endfunc
pool_037FD94C:
	.word P2_BssStart + 0x4CC	; 037FD94C
pool_037FD950:
	.word P2_BssStart + 0x54C	; 037FD950
.thumb
P2_IrqHandler_037FD954:
	push {lr}	; 037FD954
	sub sp,#0x4	; 037FD956
	ldr r0,[pool_037FD97C]	; 037FD958
	ldr r2,[r0,#0x60]	; 037FD95A
	ldr r1,[pool_037FD980]	; 037FD95C
	ldr r0,[r1,#0x0]	; 037FD95E
	add r0,r0,#0x1	; 037FD960
	str r0,[r1,#0x0]	; 037FD962
	cmp r2,#0x0	; 037FD964
	beq P2_Entry_037FD96C	; 037FD966
	bl loc_03805094	; 037FD968
P2_Entry_037FD96C:
	ldr r2,[pool_037FD984]	; 037FD96C
	ldr r1,[r2,#0x0]	; 037FD96E
	mov r0,#0x1	; 037FD970
	orr r1,r0	; 037FD972
	str r1,[r2,#0x0]	; 037FD974
	add sp,#0x4	; 037FD976
	pop {r3}	; 037FD978
	bx r3	; 037FD97A
pool_037FD97C:
	.word P2_BssStart + 0x4D0	; 037FD97C
pool_037FD980:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FD980
pool_037FD984:
	.word Bios7IrqFlagsAddress	; 037FD984
.arm
.thumb
P2_IrqHandler_037FD988:
	mov r0,#0x7	; 037FD988
	ldr r3,[pool_037FD990]	; 037FD98A
	bx r3	; 037FD98C
	.byte 0xC0, 0x46	; 037FD990
pool_037FD990:
loc_037FD990:
	.word loc_037FD9E8 + 1	; 037FD990
P2_IrqHandler_037FD994:
	mov r0,#0x6	; 037FD994
	ldr r3,[pool_037FD99C]	; 037FD996
	bx r3	; 037FD998
	.byte 0xC0, 0x46	; 037FD99C
pool_037FD99C:
loc_037FD99C:
	.word loc_037FD9E8 + 1	; 037FD99C
P2_IrqHandler_037FD9A0:
	mov r0,#0x5	; 037FD9A0
	ldr r3,[pool_037FD9A8]	; 037FD9A2
	bx r3	; 037FD9A4
	.byte 0xC0, 0x46	; 037FD9A8
pool_037FD9A8:
loc_037FD9A8:
	.word loc_037FD9E8 + 1	; 037FD9A8
P2_IrqHandler_037FD9AC:
	mov r0,#0x4	; 037FD9AC
	ldr r3,[pool_037FD9B4]	; 037FD9AE
	bx r3	; 037FD9B0
	.byte 0xC0, 0x46	; 037FD9B4
pool_037FD9B4:
loc_037FD9B4:
	.word loc_037FD9E8 + 1	; 037FD9B4
P2_IrqHandler_037FD9B8:
	mov r0,#0x3	; 037FD9B8
	ldr r3,[pool_037FD9C0]	; 037FD9BA
	bx r3	; 037FD9BC
	.byte 0xC0, 0x46	; 037FD9C0
pool_037FD9C0:
loc_037FD9C0:
	.word loc_037FD9E8 + 1	; 037FD9C0
P2_IrqHandler_037FD9C4:
	mov r0,#0x2	; 037FD9C4
	ldr r3,[pool_037FD9CC]	; 037FD9C6
	bx r3	; 037FD9C8
	.byte 0xC0, 0x46	; 037FD9CC
pool_037FD9CC:
loc_037FD9CC:
	.word loc_037FD9E8 + 1	; 037FD9CC
P2_IrqHandler_037FD9D0:
	mov r0,#0x1	; 037FD9D0
	ldr r3,[pool_037FD9D8]	; 037FD9D2
	bx r3	; 037FD9D4
	.byte 0xC0, 0x46	; 037FD9D8
pool_037FD9D8:
loc_037FD9D8:
	.word loc_037FD9E8 + 1	; 037FD9D8
P2_IrqHandler_037FD9DC:
	mov r0,#0x0	; 037FD9DC
	ldr r3,[pool_037FD9E4]	; 037FD9DE
	bx r3	; 037FD9E0
	.byte 0xC0, 0x46	; 037FD9E4
pool_037FD9E4:
loc_037FD9E4:
	.word loc_037FD9E8 + 1	; 037FD9E4
loc_037FD9E8:
	push {r4,r5,lr}	; 037FD9E8
	sub sp,#0x4	; 037FD9EA
	mov r5,#0x1	; 037FD9EC
	lsl r2,r0,#0x1	; 037FD9EE
	ldr r1,[pool_037FDA30]	; 037FD9F0
	ldrh r1,[r1,r2]	; 037FD9F2
	lsl r5,r1	; 037FD9F4
	mov r1,#0xc	; 037FD9F6
	add r4,r0,#0x0	; 037FD9F8
	mul r4,r1	; 037FD9FA
	ldr r2,[pool_037FDA34]	; 037FD9FC
	ldr r1,[r2,r4]	; 037FD9FE
	mov r0,#0x0	; 037FDA00
	str r0,[r2,r4]	; 037FDA02
	cmp r1,#0x0	; 037FDA04
	beq loc_037FDA10	; 037FDA06
	ldr r0,[pool_037FDA38]	; 037FDA08
	ldr r0,[r0,r4]	; 037FDA0A
	bl loc_03805090	; 037FDA0C
loc_037FDA10:
	ldr r1,[pool_037FDA3C]	; 037FDA10
	ldr r0,[r1,#0x0]	; 037FDA12
	orr r0,r5	; 037FDA14
	str r0,[r1,#0x0]	; 037FDA16
	ldr r0,[pool_037FDA40]	; 037FDA18
	ldr r0,[r0,r4]	; 037FDA1A
	cmp r0,#0x0	; 037FDA1C
	bne loc_037FDA26	; 037FDA1E
	add r0,r5,#0x0	; 037FDA20
	bl loc_037FDA6C	; 037FDA22
loc_037FDA26:
	add sp,#0x4	; 037FDA26
	pop {r4,r5}	; 037FDA28
	pop {r3}	; 037FDA2A
	bx r3	; 037FDA2C
	.byte 0xC0, 0x46	; 037FDA30
pool_037FDA30:
loc_037FDA30:
	.word P2_Data_03805268	; 037FDA30
pool_037FDA34:
loc_037FDA34:
	.word P2_BssStart + 0x4D0	; 037FDA34
pool_037FDA38:
loc_037FDA38:
	.word P2_BssStart + 0x4D8	; 037FDA38
pool_037FDA3C:
loc_037FDA3C:
	.word Bios7IrqFlagsAddress	; 037FDA3C
pool_037FDA40:
loc_037FDA40:
	.word P2_BssStart + 0x4D4	; 037FDA40
loc_037FDA44:
	bx lr	; 037FDA44
	.byte 0x00, 0x00	; 037FDA48

; ===== function loc_037FDA48 =====
loc_037FDA48:
	push {r4,lr}	; 037FDA48
	ldr r4,[pool_037FDA64]	; 037FDA4A
	ldrh r3,[r4,#0x0]	; 037FDA4C
	mov r1,#0x0	; 037FDA4E
	strh r1,[r4,#0x0]	; 037FDA50
	ldr r2,[pool_037FDA68]	; 037FDA52
	ldr r1,[r2,#0x0]	; 037FDA54
	str r0,[r2,#0x0]	; 037FDA56
	ldrh r0,[r4,#0x0]	; 037FDA58
	strh r3,[r4,#0x0]	; 037FDA5A
	add r0,r1,#0x0	; 037FDA5C
	pop {r4}	; 037FDA5E
	pop {r3}	; 037FDA60
	bx r3	; 037FDA62
pool_037FDA64:
loc_037FDA64:
	.word REG_IME	; 037FDA64
pool_037FDA68:
loc_037FDA68:
	.word REG_IF	; 037FDA68

; ===== function loc_037FDA6C =====
loc_037FDA6C:
	push {r4,r5,lr}	; 037FDA6C
	sub sp,#0x4	; 037FDA6E
	ldr r5,[pool_037FDA90]	; 037FDA70
	ldrh r4,[r5,#0x0]	; 037FDA72
	mov r1,#0x0	; 037FDA74
	strh r1,[r5,#0x0]	; 037FDA76
	ldr r3,[pool_037FDA94]	; 037FDA78
	ldr r2,[r3,#0x0]	; 037FDA7A
	add r1,r2,#0x0	; 037FDA7C
	bic r1,r0	; 037FDA7E
	str r1,[r3,#0x0]	; 037FDA80
	ldrh r0,[r5,#0x0]	; 037FDA82
	strh r4,[r5,#0x0]	; 037FDA84
	add r0,r2,#0x0	; 037FDA86
	add sp,#0x4	; 037FDA88
	pop {r4,r5}	; 037FDA8A
	pop {r3}	; 037FDA8C
	bx r3	; 037FDA8E
pool_037FDA90:
loc_037FDA90:
	.word REG_IME	; 037FDA90
pool_037FDA94:
loc_037FDA94:
	.word REG_IE	; 037FDA94

; ===== function loc_037FDA98 =====
loc_037FDA98:
	push {r4,r5,lr}	; 037FDA98
	sub sp,#0x4	; 037FDA9A
	ldr r5,[pool_037FDABC]	; 037FDA9C
	ldrh r4,[r5,#0x0]	; 037FDA9E
	mov r1,#0x0	; 037FDAA0
	strh r1,[r5,#0x0]	; 037FDAA2
	ldr r3,[pool_037FDAC0]	; 037FDAA4
	ldr r2,[r3,#0x0]	; 037FDAA6
	add r1,r2,#0x0	; 037FDAA8
	orr r1,r0	; 037FDAAA
	str r1,[r3,#0x0]	; 037FDAAC
	ldrh r0,[r5,#0x0]	; 037FDAAE
	strh r4,[r5,#0x0]	; 037FDAB0
	add r0,r2,#0x0	; 037FDAB2
	add sp,#0x4	; 037FDAB4
	pop {r4,r5}	; 037FDAB6
	pop {r3}	; 037FDAB8
	bx r3	; 037FDABA
pool_037FDABC:
loc_037FDABC:
	.word REG_IME	; 037FDABC
pool_037FDAC0:
loc_037FDAC0:
	.word REG_IE	; 037FDAC0

; ===== function loc_037FDAC4 =====
loc_037FDAC4:
	push {r4,lr}	; 037FDAC4
	ldr r4,[pool_037FDAE0]	; 037FDAC6
	ldrh r3,[r4,#0x0]	; 037FDAC8
	mov r1,#0x0	; 037FDACA
	strh r1,[r4,#0x0]	; 037FDACC
	ldr r2,[pool_037FDAE4]	; 037FDACE
	ldr r1,[r2,#0x0]	; 037FDAD0
	str r0,[r2,#0x0]	; 037FDAD2
	ldrh r0,[r4,#0x0]	; 037FDAD4
	strh r3,[r4,#0x0]	; 037FDAD6
	add r0,r1,#0x0	; 037FDAD8
	pop {r4}	; 037FDADA
	pop {r3}	; 037FDADC
	bx r3	; 037FDADE
pool_037FDAE0:
loc_037FDAE0:
	.word REG_IME	; 037FDAE0
pool_037FDAE4:
loc_037FDAE4:
	.word REG_IE	; 037FDAE4

; ===== function loc_037FDAE8 =====
loc_037FDAE8:
	push {r4,lr}	; 037FDAE8
	mov r3,#0xc	; 037FDAEA
	add r4,r0,#0x0	; 037FDAEC
	mul r4,r3	; 037FDAEE
	ldr r3,[pool_037FDB10]	; 037FDAF0
	str r1,[r3,r4]	; 037FDAF2
	ldr r1,[pool_037FDB14]	; 037FDAF4
	str r2,[r1,r4]	; 037FDAF6
	mov r1,#0x1	; 037FDAF8
	add r0,r0,#0x3	; 037FDAFA
	lsl r1,r0	; 037FDAFC
	add r0,r1,#0x0	; 037FDAFE
	bl loc_037FDA98	; 037FDB00
	mov r1,#0x1	; 037FDB04
	ldr r0,[pool_037FDB18]	; 037FDB06
	str r1,[r0,r4]	; 037FDB08
	pop {r4}	; 037FDB0A
	pop {r3}	; 037FDB0C
	bx r3	; 037FDB0E
pool_037FDB10:
loc_037FDB10:
	.word P2_BssStart + 0x500	; 037FDB10
pool_037FDB14:
loc_037FDB14:
	.word P2_BssStart + 0x508	; 037FDB14
pool_037FDB18:
loc_037FDB18:
	.word P2_BssStart + 0x504	; 037FDB18

; ===== function loc_037FDB1C =====
loc_037FDB1C:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P2_SetIrqHandlers
	push {r4,r5,r6,r7,lr}	; 037FDB1C
	sub sp,#0x4	; 037FDB1E
	mov r5,#0x0	; 037FDB20
	add r3,r5,#0x0	; 037FDB22
	add r2,r5,#0x0	; 037FDB24
loc_037FDB26:
	add r6,r0,#0x0	; 037FDB26
	mov r4,#0x1	; 037FDB28
	and r6,r4	; 037FDB2A
	cmp r6,#0x0	; 037FDB2C
	beq loc_037FDB76	; 037FDB2E
	add r4,r3,#0x0	; 037FDB30
	cmp r5,#0x8	; 037FDB32
	blt loc_037FDB48	; 037FDB34
	cmp r5,#0xb	; 037FDB36
	bgt loc_037FDB48	; 037FDB38
	add r6,r5,#0x0	; 037FDB3A
	sub r6,#0x8	; 037FDB3C
	mov r4,#0xc	; 037FDB3E
	mul r6,r4	; 037FDB40
	ldr r4,[pool_037FDB88]	; 037FDB42
	add r4,r4,r6	; 037FDB44
	b loc_037FDB6A	; 037FDB46
loc_037FDB48:
	cmp r5,#0x3	; 037FDB48
	blt loc_037FDB5C	; 037FDB4A
	cmp r5,#0x6	; 037FDB4C
	bgt loc_037FDB5C	; 037FDB4E
	add r6,r5,#0x1	; 037FDB50
	mov r4,#0xc	; 037FDB52
	mul r6,r4	; 037FDB54
	ldr r4,[pool_037FDB88]	; 037FDB56
	add r4,r4,r6	; 037FDB58
	b loc_037FDB6A	; 037FDB5A
loc_037FDB5C:
	cmp r5,#0x0	; 037FDB5C
	bne loc_037FDB64	; 037FDB5E
	ldr r4,[pool_037FDB8C]	; 037FDB60
	b loc_037FDB6A	; 037FDB62
loc_037FDB64:
	lsl r7,r5,#0x2	; 037FDB64
	ldr r6,[pool_037FDB90]	; 037FDB66
	str r1,[r6,r7]	; 037FDB68
loc_037FDB6A:
	cmp r4,#0x0	; 037FDB6A
	beq loc_037FDB76	; 037FDB6C
	str r1,[r4,#0x0]	; 037FDB6E
	str r2,[r4,#0x8]	; 037FDB70
	mov r6,#0x1	; 037FDB72
	str r6,[r4,#0x4]	; 037FDB74
loc_037FDB76:
	lsr r0,r0,#0x1	; 037FDB76
	add r5,r5,#0x1	; 037FDB78
	cmp r5,#0x19	; 037FDB7A
	blt loc_037FDB26	; 037FDB7C
	add sp,#0x4	; 037FDB7E
	pop {r4,r5,r6,r7}	; 037FDB80
	pop {r3}	; 037FDB82
	bx r3	; 037FDB84
.endfunc
	.byte 0xC0, 0x46	; 037FDB88
pool_037FDB88:
loc_037FDB88:
	.word 0x03805870	; 037FDB88
pool_037FDB8C:
loc_037FDB8C:
	.word 0x038058D0	; 037FDB8C
pool_037FDB90:
loc_037FDB90:
	.word P2_IrqHandlers	; 037FDB90

; ===== function loc_037FDB94 =====
loc_037FDB94:
	mov r1,#0x0	; 037FDB94
	ldr r0,[pool_037FDBA0]	; 037FDB96
	strh r1,[r0,#0x0]	; 037FDB98
	ldr r0,[pool_037FDBA4]	; 037FDB9A
	str r1,[r0,#0x0]	; 037FDB9C
	bx lr	; 037FDB9E
pool_037FDBA0:
loc_037FDBA0:
	.word P2_BssStart + 0x4CC	; 037FDBA0
pool_037FDBA4:
loc_037FDBA4:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FDBA4

; ===== function loc_037FDBA8 =====
loc_037FDBA8:
	ldr r1,[pool_037FDBAC]	; 037FDBA8
	bx r1	; 037FDBAA
pool_037FDBAC:
loc_037FDBAC:
	.word loc_037FDC60 + 1	; 037FDBAC
.arm

; ===== function loc_037FDBB0 =====
loc_037FDBB0:
	ldr r3,[pool_037FDC40]	; 037FDBB0
	ldr r1,[r3,#0x0]	; 037FDBB4
	mov r2,#0x0	; 037FDBB8
	mov r0,#0x80000000	; 037FDBBC
loc_037FDBC0:
	tst r1,r0	; 037FDBC0
	bne loc_037FDBDC	; 037FDBC4
	add r2,r2,#0x1	; 037FDBC8
	cmp r2,#0x20	; 037FDBCC
	beq loc_037FDBDC	; 037FDBD0
	mov r0,r0, lsr #0x1	; 037FDBD4
	b loc_037FDBC0	; 037FDBD8
loc_037FDBDC:
	cmp r2,#0x20	; 037FDBDC
	movne r0,#0x80	; 037FDBE0
	bne loc_037FDC24	; 037FDBE4
	add r3,r3,#0x4	; 037FDBE8
	ldr r1,[r3,#0x0]	; 037FDBEC
	mov r2,#0x0	; 037FDBF0
	mov r0,#0x80000000	; 037FDBF4
loc_037FDBF8:
	tst r1,r0	; 037FDBF8
	bne loc_037FDC14	; 037FDBFC
	add r2,r2,#0x1	; 037FDC00
	cmp r2,#0x20	; 037FDC04
	beq loc_037FDC14	; 037FDC08
	mov r0,r0, lsr #0x1	; 037FDC0C
	b loc_037FDBF8	; 037FDC10
loc_037FDC14:
	cmp r2,#0x20	; 037FDC14
	ldr r0,[pool_037FDC44]	; 037FDC18
	bxeq lr	; 037FDC1C
	mov r0,#0xa0	; 037FDC20
loc_037FDC24:
	add r0,r0,r2	; 037FDC24
	mov r1,#0x80000000	; 037FDC28
	mov r1,r1, lsr r2	; 037FDC2C
	ldr r2,[r3,#0x0]	; 037FDC30
	bic r2,r2,r1	; 037FDC34
	str r2,[r3,#0x0]	; 037FDC38
	bx lr	; 037FDC3C
pool_037FDC40:
loc_037FDC40:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FDC40
pool_037FDC44:
loc_037FDC44:
	.word 0xFFFFFFFD	; 037FDC44
.thumb

; ===== function loc_037FDC48 =====
loc_037FDC48:
	ldr r0,[pool_037FDC50]	; 037FDC48
	ldr r3,[pool_037FDC54]	; 037FDC4A
	bx r3	; 037FDC4C
	.byte 0xC0, 0x46	; 037FDC50
pool_037FDC50:
loc_037FDC50:
	.word 0x00001000	; 037FDC50
pool_037FDC54:
loc_037FDC54:
	.word loc_037FF1D0 + 1	; 037FDC54
	.byte 0x70, 0x47, 0x00, 0x00, 0x70, 0x47, 0x00, 0x00	; 037FDC60

; ===== function loc_037FDC60 =====
loc_037FDC60:
	ldr r1,[pool_037FDC68]	; 037FDC60
	ldr r2,[pool_037FDC6C]	; 037FDC62
	ldr r3,[pool_037FDC70]	; 037FDC64
	bx r3	; 037FDC66
pool_037FDC68:
loc_037FDC68:
	.word 0x027FFFE0	; 037FDC68
pool_037FDC6C:
loc_037FDC6C:
	.word 0x037FDC59	; 037FDC6C
pool_037FDC70:
loc_037FDC70:
	.word loc_037FDD28 + 1	; 037FDC70

; ===== function loc_037FDC74 =====
loc_037FDC74:
	ldr r1,[pool_037FDC7C]	; 037FDC74
	ldr r2,[pool_037FDC80]	; 037FDC76
	ldr r3,[pool_037FDC84]	; 037FDC78
	bx r3	; 037FDC7A
pool_037FDC7C:
loc_037FDC7C:
	.word 0x027FFFE0	; 037FDC7C
pool_037FDC80:
loc_037FDC80:
	.word 0x037FDC5D	; 037FDC80
pool_037FDC84:
loc_037FDC84:
	.word loc_037FDD8C + 1	; 037FDC84

; ===== function loc_037FDC88 =====
loc_037FDC88:
	push {r4,r5,r6,r7,lr}	; 037FDC88
	sub sp,#0xc	; 037FDC8A
	add r5,r0,#0x0	; 037FDC8C
	add r6,r1,#0x0	; 037FDC8E
	add r4,r2,#0x0	; 037FDC90
	add r7,r3,#0x0	; 037FDC92
	cmp r7,#0x0	; 037FDC94
	beq loc_037FDCA0	; 037FDC96
	bl loc_037FDCDC	; 037FDC98
	str r0,[sp,#0x0]	; 037FDC9C
	b loc_037FDCA6	; 037FDC9E
loc_037FDCA0:
	bl loc_037FDCE8	; 037FDCA0
	str r0,[sp,#0x0]	; 037FDCA4
loc_037FDCA6:
	add r0,r5,#0x0	; 037FDCA6
	add r1,r6,#0x0	; 037FDCA8
	bl loc_037FDCF4	; 037FDCAA
	str r0,[sp,#0x4]	; 037FDCAE
	cmp r0,#0x0	; 037FDCB0
	bne loc_037FDCBE	; 037FDCB2
	cmp r4,#0x0	; 037FDCB4
	beq loc_037FDCBC	; 037FDCB6
	bl loc_0380509C	; 037FDCB8
loc_037FDCBC:
	strh r5,[r6,#0x4]	; 037FDCBC
loc_037FDCBE:
	cmp r7,#0x0	; 037FDCBE
	beq loc_037FDCCA	; 037FDCC0
	ldr r0,[sp,#0x0]	; 037FDCC2
	bl loc_037FDD00	; 037FDCC4
	b loc_037FDCD0	; 037FDCC8
loc_037FDCCA:
	ldr r0,[sp,#0x0]	; 037FDCCA
	bl loc_037FDD0C	; 037FDCCC
loc_037FDCD0:
	ldr r0,[sp,#0x4]	; 037FDCD0
	add sp,#0xc	; 037FDCD2
	pop {r4,r5,r6,r7}	; 037FDCD4
	pop {r3}	; 037FDCD6
	bx r3	; 037FDCD8
	.byte 0xC0, 0x46	; 037FDCDC

; ===== function loc_037FDCDC =====
loc_037FDCDC:
	bx pc	; 037FDCDC
	.byte 0xC0, 0x46	; 037FDCE0
.arm

; ===== function loc_037FDCE0 =====
loc_037FDCE0:
	ldr pc,[pool_037FDCE4]	; 037FDCE0
pool_037FDCE4:
loc_037FDCE4:
	.word loc_037FF138	; 037FDCE4
.thumb

; ===== function loc_037FDCE8 =====
loc_037FDCE8:
	bx pc	; 037FDCE8
	.byte 0xC0, 0x46	; 037FDCEC
.arm

; ===== function loc_037FDCEC =====
loc_037FDCEC:
	ldr pc,[pool_037FDCF0]	; 037FDCEC
pool_037FDCF0:
loc_037FDCF0:
	.word loc_037FF10C	; 037FDCF0
.thumb

; ===== function loc_037FDCF4 =====
loc_037FDCF4:
	bx pc	; 037FDCF4
	.byte 0xC0, 0x46	; 037FDCF8
.arm

; ===== function loc_037FDCF8 =====
loc_037FDCF8:
	ldr pc,[pool_037FDCFC]	; 037FDCF8
pool_037FDCFC:
loc_037FDCFC:
	.word loc_037FF404	; 037FDCFC
.thumb

; ===== function loc_037FDD00 =====
loc_037FDD00:
	bx pc	; 037FDD00
	.byte 0xC0, 0x46	; 037FDD04
.arm

; ===== function loc_037FDD04 =====
loc_037FDD04:
	ldr pc,[pool_037FDD08]	; 037FDD04
pool_037FDD08:
loc_037FDD08:
	.word loc_037FF14C	; 037FDD08
.thumb

; ===== function loc_037FDD0C =====
loc_037FDD0C:
	bx pc	; 037FDD0C
	.byte 0xC0, 0x46	; 037FDD10
.arm

; ===== function loc_037FDD10 =====
loc_037FDD10:
	ldr pc,[pool_037FDD14]	; 037FDD10
pool_037FDD14:
loc_037FDD14:
	.word loc_037FF120	; 037FDD14
.thumb

; ===== function loc_037FDD18 =====
loc_037FDD18:
	push {lr}	; 037FDD18
	sub sp,#0x4	; 037FDD1A
	mov r3,#0x0	; 037FDD1C
	bl loc_037FDD38	; 037FDD1E
	add sp,#0x4	; 037FDD22
	pop {r3}	; 037FDD24
	bx r3	; 037FDD26
loc_037FDD28:
	push {lr}	; 037FDD28
	sub sp,#0x4	; 037FDD2A
	mov r3,#0x0	; 037FDD2C
	bl loc_037FDD38	; 037FDD2E
	add sp,#0x4	; 037FDD32
	pop {r3}	; 037FDD34
	bx r3	; 037FDD36

; ===== function loc_037FDD38 =====
loc_037FDD38:
	push {r4,r5,r6,r7,lr}	; 037FDD38
	sub sp,#0x4	; 037FDD3A
	add r5,r1,#0x0	; 037FDD3C
	add r4,r2,#0x0	; 037FDD3E
	add r6,r3,#0x0	; 037FDD40
	ldrh r1,[r5,#0x4]	; 037FDD42
	cmp r0,r1	; 037FDD44
	beq loc_037FDD4E	; 037FDD46
	mov r0,#0x1	; 037FDD48
	mvn r0,r0	; 037FDD4A
	b loc_037FDD84	; 037FDD4C
loc_037FDD4E:
	cmp r6,#0x0	; 037FDD4E
	beq loc_037FDD5A	; 037FDD50
	bl loc_037FDCDC	; 037FDD52
	add r7,r0,#0x0	; 037FDD56
	b loc_037FDD60	; 037FDD58
loc_037FDD5A:
	bl loc_037FDCE8	; 037FDD5A
	add r7,r0,#0x0	; 037FDD5E
loc_037FDD60:
	mov r0,#0x0	; 037FDD60
	strh r0,[r5,#0x4]	; 037FDD62
	cmp r4,#0x0	; 037FDD64
	beq loc_037FDD6C	; 037FDD66
	bl loc_0380509C	; 037FDD68
loc_037FDD6C:
	mov r0,#0x0	; 037FDD6C
	str r0,[r5,#0x0]	; 037FDD6E
	cmp r6,#0x0	; 037FDD70
	beq loc_037FDD7C	; 037FDD72
	add r0,r7,#0x0	; 037FDD74
	bl loc_037FDD00	; 037FDD76
	b loc_037FDD82	; 037FDD7A
loc_037FDD7C:
	add r0,r7,#0x0	; 037FDD7C
	bl loc_037FDD0C	; 037FDD7E
loc_037FDD82:
	mov r0,#0x0	; 037FDD82
loc_037FDD84:
	add sp,#0x4	; 037FDD84
	pop {r4,r5,r6,r7}	; 037FDD86
	pop {r3}	; 037FDD88
	bx r3	; 037FDD8A

; ===== function loc_037FDD8C =====
loc_037FDD8C:
	push {lr}	; 037FDD8C
	sub sp,#0x4	; 037FDD8E
	mov r3,#0x0	; 037FDD90
	bl loc_037FDD9C	; 037FDD92
	add sp,#0x4	; 037FDD96
	pop {r3}	; 037FDD98
	bx r3	; 037FDD9A

; ===== function loc_037FDD9C =====
loc_037FDD9C:
	push {r4,r5,r6,r7,lr}	; 037FDD9C
	sub sp,#0x4	; 037FDD9E
	add r5,r0,#0x0	; 037FDDA0
	add r4,r1,#0x0	; 037FDDA2
	add r6,r2,#0x0	; 037FDDA4
	add r7,r3,#0x0	; 037FDDA6
	b loc_037FDDAE	; 037FDDA8
loc_037FDDAA:
	bl loc_037FDC48	; 037FDDAA
loc_037FDDAE:
	add r0,r5,#0x0	; 037FDDAE
	add r1,r4,#0x0	; 037FDDB0
	add r2,r6,#0x0	; 037FDDB2
	add r3,r7,#0x0	; 037FDDB4
	bl loc_037FDC88	; 037FDDB6
	cmp r0,#0x0	; 037FDDBA
	bgt loc_037FDDAA	; 037FDDBC
	add sp,#0x4	; 037FDDBE
	pop {r4,r5,r6,r7}	; 037FDDC0
	pop {r3}	; 037FDDC2
	bx r3	; 037FDDC4
	.byte 0x00, 0x00	; 037FDDC8

; ===== function loc_037FDDC8 =====
loc_037FDDC8:
	push {r4,lr}	; 037FDDC8
	ldr r0,[pool_037FDE00]	; 037FDDCA
	ldr r1,[r0,#0x0]	; 037FDDCC
	cmp r1,#0x0	; 037FDDCE
	bne loc_037FDDFA	; 037FDDD0
	mov r1,#0x1	; 037FDDD2
	str r1,[r0,#0x0]	; 037FDDD4
	mov r0,#0x0	; 037FDDD6
	ldr r4,[pool_037FDE04]	; 037FDDD8
	strh r0,[r4,#0x6]	; 037FDDDA
	b loc_037FDDE2	; 037FDDDC
loc_037FDDDE:
	bl loc_037FDC48	; 037FDDDE
loc_037FDDE2:
	ldrh r0,[r4,#0x4]	; 037FDDE2
	cmp r0,#0x7f	; 037FDDE4
	bne loc_037FDDDE	; 037FDDE6
	mov r0,#0x0	; 037FDDE8
	mvn r1,r0	; 037FDDEA
	ldr r0,[pool_037FDE08]	; 037FDDEC
	str r1,[r0,#0x0]	; 037FDDEE
	ldr r1,[pool_037FDE0C]	; 037FDDF0
	ldr r0,[pool_037FDE10]	; 037FDDF2
	str r1,[r0,#0x0]	; 037FDDF4
	mov r0,#0xbf	; 037FDDF6
	strh r0,[r4,#0x6]	; 037FDDF8
loc_037FDDFA:
	pop {r4}	; 037FDDFA
	pop {r3}	; 037FDDFC
	bx r3	; 037FDDFE
pool_037FDE00:
loc_037FDE00:
	.word P2_BssStart + 0x53C	; 037FDE00
pool_037FDE04:
loc_037FDE04:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 037FDE04
pool_037FDE08:
loc_037FDE08:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FDE08
pool_037FDE0C:
loc_037FDE0C:
	.word 0xFFFF0000	; 037FDE0C
pool_037FDE10:
loc_037FDE10:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset + 0x4	; 037FDE10
	.byte 0x70, 0x47, 0x00, 0x00	; 037FDE18

; ===== function loc_037FDE18 =====
loc_037FDE18:
	push {r4,r5,lr}	; 037FDE18
	sub sp,#0x4	; 037FDE1A
	add r5,r0,#0x0	; 037FDE1C
	bl loc_037FDCE8	; 037FDE1E
	ldr r1,[pool_037FDE38]	; 037FDE22
	ldr r4,[r1,#0x10]	; 037FDE24
	str r5,[r1,#0x10]	; 037FDE26
	bl loc_037FDD0C	; 037FDE28
	add r0,r4,#0x0	; 037FDE2C
	add sp,#0x4	; 037FDE2E
	pop {r4,r5}	; 037FDE30
	pop {r3}	; 037FDE32
	bx r3	; 037FDE34
	.byte 0xC0, 0x46	; 037FDE38
pool_037FDE38:
loc_037FDE38:
	.word P2_BssStart + 0x54C	; 037FDE38

; ===== function loc_037FDE3C =====
loc_037FDE3C:
	push {r4,r5,r6,lr}	; 037FDE3C
	ldr r6,[pool_037FDEA0]	; 037FDE3E
	ldrh r0,[r6,#0x4]	; 037FDE40
	cmp r0,#0x0	; 037FDE42
	bne loc_037FDE4E	; 037FDE44
	bl loc_037FDEAC	; 037FDE46
	cmp r0,#0x12	; 037FDE4A
	bne loc_037FDE54	; 037FDE4C
loc_037FDE4E:
	mov r0,#0x1	; 037FDE4E
	strh r0,[r6,#0x0]	; 037FDE50
	b loc_037FDE9A	; 037FDE52
loc_037FDE54:
	ldr r0,[pool_037FDEA4]	; 037FDE54
	ldr r0,[r0,#0x0]	; 037FDE56
	ldr r5,[r0,#0x0]	; 037FDE58
	bl loc_037FDED0	; 037FDE5A
	add r4,r0,#0x0	; 037FDE5E
	cmp r5,r4	; 037FDE60
	beq loc_037FDE9A	; 037FDE62
	cmp r4,#0x0	; 037FDE64
	beq loc_037FDE9A	; 037FDE66
	add r0,r5,#0x0	; 037FDE68
	bl loc_037FDEB8	; 037FDE6A
	cmp r0,#0x0	; 037FDE6E
	bne loc_037FDE9A	; 037FDE70
	ldr r0,[pool_037FDEA8]	; 037FDE72
	ldr r2,[r0,#0x0]	; 037FDE74
	cmp r2,#0x0	; 037FDE76
	beq loc_037FDE82	; 037FDE78
	add r0,r5,#0x0	; 037FDE7A
	add r1,r4,#0x0	; 037FDE7C
	bl loc_03805094	; 037FDE7E
loc_037FDE82:
	ldr r2,[r6,#0x10]	; 037FDE82
	cmp r2,#0x0	; 037FDE84
	beq loc_037FDE90	; 037FDE86
	add r0,r5,#0x0	; 037FDE88
	add r1,r4,#0x0	; 037FDE8A
	bl loc_03805094	; 037FDE8C
loc_037FDE90:
	ldr r0,[pool_037FDEA0]	; 037FDE90
	str r4,[r0,#0x8]	; 037FDE92
	add r0,r4,#0x0	; 037FDE94
	bl loc_037FDEC4	; 037FDE96
loc_037FDE9A:
	pop {r4,r5,r6}	; 037FDE9A
	pop {r3}	; 037FDE9C
	bx r3	; 037FDE9E
pool_037FDEA0:
loc_037FDEA0:
	.word P2_BssStart + 0x54C	; 037FDEA0
pool_037FDEA4:
loc_037FDEA4:
	.word P2_BssStart + 0x544	; 037FDEA4
pool_037FDEA8:
loc_037FDEA8:
	.word P2_BssStart + 0x540	; 037FDEA8

; ===== function loc_037FDEAC =====
loc_037FDEAC:
	bx pc	; 037FDEAC
	.byte 0xC0, 0x46	; 037FDEB0
.arm

; ===== function loc_037FDEB0 =====
loc_037FDEB0:
	ldr pc,[pool_037FDEB4]	; 037FDEB0
pool_037FDEB4:
loc_037FDEB4:
	.word loc_037FF164	; 037FDEB4
.thumb

; ===== function loc_037FDEB8 =====
loc_037FDEB8:
	bx pc	; 037FDEB8
	.byte 0xC0, 0x46	; 037FDEBC
.arm

; ===== function loc_037FDEBC =====
loc_037FDEBC:
	ldr pc,[pool_037FDEC0]	; 037FDEBC
pool_037FDEC0:
loc_037FDEC0:
	.word P2_SaveThreadContext	; 037FDEC0
.thumb

; ===== function loc_037FDEC4 =====
loc_037FDEC4:
	bx pc	; 037FDEC4
	.byte 0xC0, 0x46	; 037FDEC8
.arm

; ===== function loc_037FDEC8 =====
loc_037FDEC8:
	ldr pc,[pool_037FDECC]	; 037FDEC8
pool_037FDECC:
loc_037FDECC:
	.word P2_LoadThreadContext	; 037FDECC
.thumb

; ===== function loc_037FDED0 =====
loc_037FDED0:
	ldr r0,[pool_037FDEE4]	; 037FDED0
	ldr r0,[r0,#0xc]	; 037FDED2
	b loc_037FDED8	; 037FDED4
loc_037FDED6:
	ldr r0,[r0,#0x4c]	; 037FDED6
loc_037FDED8:
	cmp r0,#0x0	; 037FDED8
	beq loc_037FDEE2	; 037FDEDA
	ldr r1,[r0,#0x48]	; 037FDEDC
	cmp r1,#0x1	; 037FDEDE
	bne loc_037FDED6	; 037FDEE0
loc_037FDEE2:
	bx lr	; 037FDEE2
pool_037FDEE4:
loc_037FDEE4:
	.word P2_BssStart + 0x54C	; 037FDEE4

; ===== function loc_037FDEE8 =====
loc_037FDEE8:
	push {r4,r5,lr}	; 037FDEE8
	sub sp,#0x4	; 037FDEEA
	add r5,r0,#0x0	; 037FDEEC
	bl loc_037FDCE8	; 037FDEEE
	add r4,r0,#0x0	; 037FDEF2
	mov r0,#0x1	; 037FDEF4
	str r0,[r5,#0x48]	; 037FDEF6
	bl loc_037FDE3C	; 037FDEF8
	add r0,r4,#0x0	; 037FDEFC
	bl loc_037FDD0C	; 037FDEFE
	add sp,#0x4	; 037FDF02
	pop {r4,r5}	; 037FDF04
	pop {r3}	; 037FDF06
	bx r3	; 037FDF08
	.byte 0x00, 0x00	; 037FDF0C

; ===== function loc_037FDF0C =====
loc_037FDF0C:
	push {r4,r5,r6,lr}	; 037FDF0C
	add r5,r0,#0x0	; 037FDF0E
	bl loc_037FDCE8	; 037FDF10
	add r4,r0,#0x0	; 037FDF14
	ldrh r1,[r5,#0x0]	; 037FDF16
	cmp r1,#0x0	; 037FDF18
	beq loc_037FDF42	; 037FDF1A
	ldr r0,[pool_037FDF50]	; 037FDF1C
	ldr r0,[r0,#0xc]	; 037FDF1E
	mov r3,#0x1	; 037FDF20
	b loc_037FDF36	; 037FDF22
loc_037FDF24:
	ldr r2,[r0,#0x50]	; 037FDF24
	add r6,r3,#0x0	; 037FDF26
	lsl r6,r2	; 037FDF28
	add r2,r1,#0x0	; 037FDF2A
	and r2,r6	; 037FDF2C
	cmp r2,#0x0	; 037FDF2E
	beq loc_037FDF34	; 037FDF30
	str r3,[r0,#0x48]	; 037FDF32
loc_037FDF34:
	ldr r0,[r0,#0x4c]	; 037FDF34
loc_037FDF36:
	cmp r0,#0x0	; 037FDF36
	bne loc_037FDF24	; 037FDF38
	mov r0,#0x0	; 037FDF3A
	strh r0,[r5,#0x0]	; 037FDF3C
	bl loc_037FDE3C	; 037FDF3E
loc_037FDF42:
	add r0,r4,#0x0	; 037FDF42
	bl loc_037FDD0C	; 037FDF44
	pop {r4,r5,r6}	; 037FDF48
	pop {r3}	; 037FDF4A
	bx r3	; 037FDF4C
	.byte 0xC0, 0x46	; 037FDF50
pool_037FDF50:
loc_037FDF50:
	.word P2_BssStart + 0x54C	; 037FDF50

; ===== function loc_037FDF54 =====
loc_037FDF54:
	push {r4,r5,lr}	; 037FDF54
	sub sp,#0x4	; 037FDF56
	add r5,r0,#0x0	; 037FDF58
	bl loc_037FDCE8	; 037FDF5A
	add r4,r0,#0x0	; 037FDF5E
	ldr r0,[pool_037FDF90]	; 037FDF60
	ldr r0,[r0,#0x0]	; 037FDF62
	ldr r1,[r0,#0x0]	; 037FDF64
	cmp r5,#0x0	; 037FDF66
	beq loc_037FDF7A	; 037FDF68
	ldrh r0,[r5,#0x0]	; 037FDF6A
	mov r3,#0x1	; 037FDF6C
	ldr r2,[r1,#0x50]	; 037FDF6E
	lsl r3,r2	; 037FDF70
	lsl r2,r3,#0x10	; 037FDF72
	lsr r2,r2,#0x10	; 037FDF74
	orr r0,r2	; 037FDF76
	strh r0,[r5,#0x0]	; 037FDF78
loc_037FDF7A:
	mov r0,#0x0	; 037FDF7A
	str r0,[r1,#0x48]	; 037FDF7C
	bl loc_037FDE3C	; 037FDF7E
	add r0,r4,#0x0	; 037FDF82
	bl loc_037FDD0C	; 037FDF84
	add sp,#0x4	; 037FDF88
	pop {r4,r5}	; 037FDF8A
	pop {r3}	; 037FDF8C
	bx r3	; 037FDF8E
pool_037FDF90:
loc_037FDF90:
	.word P2_BssStart + 0x544	; 037FDF90
P2_Entry_037FDF94:
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P2_ExitThread
	push {r4,lr}	; 037FDF94
	bl loc_037FDCE8	; 037FDF96
	ldr r0,[pool_037FDFCC]	; 037FDF9A
	ldr r0,[r0,#0x0]	; 037FDF9C
	ldr r4,[r0,#0x0]	; 037FDF9E
	add r0,r4,#0x0	; 037FDFA0
	bl loc_037FE3C0	; 037FDFA2
	add r0,r4,#0x0	; 037FDFA6
	bl loc_037FE144	; 037FDFA8
	mov r2,#0x0	; 037FDFAC
	ldr r0,[r4,#0x50]	; 037FDFAE
	lsl r1,r0,#0x2	; 037FDFB0
	ldr r0,[pool_037FDFD0]	; 037FDFB2
	str r2,[r0,r1]	; 037FDFB4
	mov r0,#0x2	; 037FDFB6
	str r0,[r4,#0x48]	; 037FDFB8
	add r4,#0x74	; 037FDFBA
	add r0,r4,#0x0	; 037FDFBC
	bl loc_037FDF0C	; 037FDFBE
	bl loc_037FDE3C	; 037FDFC2
	pop {r4}	; 037FDFC6
	pop {r3}	; 037FDFC8
	bx r3	; 037FDFCA
.endfunc
pool_037FDFCC:
loc_037FDFCC:
	.word P2_BssStart + 0x544	; 037FDFCC
pool_037FDFD0:
loc_037FDFD0:
	.word P2_BssStart + 0x560	; 037FDFD0

; ===== function loc_037FDFD4 =====
loc_037FDFD4:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P2_CreateThread
	push {r4,r5,r6,r7,lr}	; 037FDFD4
	sub sp,#0xc	; 037FDFD6
	add r5,r0,#0x0	; 037FDFD8
	str r1,[sp,#0x0]	; 037FDFDA
	add r7,r2,#0x0	; 037FDFDC
	add r4,r3,#0x0	; 037FDFDE
	bl loc_037FDCE8	; 037FDFE0
	str r0,[sp,#0x4]	; 037FDFE4
	bl loc_037FE1AC	; 037FDFE6
	cmp r0,#0x0	; 037FDFEA
	bge loc_037FDFF6	; 037FDFEC
	ldr r0,[sp,#0x4]	; 037FDFEE
	bl loc_037FDD0C	; 037FDFF0
	b loc_037FE054	; 037FDFF4
loc_037FDFF6:
	ldr r1,[sp,#0x24]	; 037FDFF6
	str r1,[r5,#0x54]	; 037FDFF8
	str r0,[r5,#0x50]	; 037FDFFA
	mov r1,#0x0	; 037FDFFC
	str r1,[r5,#0x48]	; 037FDFFE
	lsl r1,r0,#0x2	; 037FE000
	ldr r0,[pool_037FE05C]	; 037FE002
	str r5,[r0,r1]	; 037FE004
	add r0,r5,#0x0	; 037FE006
	bl loc_037FE170	; 037FE008
	str r4,[r5,#0x6c]	; 037FE00C
	ldr r0,[sp,#0x20]	; 037FE00E
	sub r6,r4,r0	; 037FE010
	str r6,[r5,#0x68]	; 037FE012
	mov r0,#0x0	; 037FE014
	str r0,[r5,#0x70]	; 037FE016
	ldr r1,[pool_037FE060]	; 037FE018
	ldr r0,[r5,#0x6c]	; 037FE01A
	sub r0,r0,#0x4	; 037FE01C
	str r1,[r0,#0x0]	; 037FE01E
	ldr r1,[pool_037FE064]	; 037FE020
	ldr r0,[r5,#0x68]	; 037FE022
	str r1,[r0,#0x0]	; 037FE024
	add r0,r5,#0x0	; 037FE026
	ldr r1,[sp,#0x0]	; 037FE028
	sub r2,r4,#0x4	; 037FE02A
	bl loc_037FE06C	; 037FE02C
	str r7,[r5,#ThreadContextR0Offset]	; 037FE030
	ldr r0,[pool_037FE068]	; 037FE032
	str r0,[r5,#ThreadContextLrOffset]	; 037FE034
	mov r0,#0x0	; 037FE036
	str r0,[sp,#0x8]	; 037FE038
	ldr r0,[sp,#0x8]	; 037FE03A
	add r1,r6,#0x4	; 037FE03C
	ldr r2,[sp,#0x20]	; 037FE03E
	sub r2,#0x8	; 037FE040
	bl loc_037FE078	; 037FE042
	mov r0,#0x0	; 037FE046
	str r0,[r5,#0x5c]	; 037FE048
	str r0,[r5,#0x60]	; 037FE04A
	str r0,[r5,#0x64]	; 037FE04C
	ldr r0,[sp,#0x4]	; 037FE04E
	bl loc_037FDD0C	; 037FE050
loc_037FE054:
	add sp,#0xc	; 037FE054
	pop {r4,r5,r6,r7}	; 037FE056
	pop {r3}	; 037FE058
	bx r3	; 037FE05A
.endfunc
pool_037FE05C:
loc_037FE05C:
	.word P2_BssStart + 0x560	; 037FE05C
pool_037FE060:
loc_037FE060:
	.word 0xD73BFDF7	; 037FE060
pool_037FE064:
loc_037FE064:
	.word 0xFBDD37BB	; 037FE064
pool_037FE068:
loc_037FE068:
	.word P2_ExitThread + 1	; 037FE068

; ===== function loc_037FE06C =====
loc_037FE06C:
	bx pc	; 037FE06C
	.byte 0xC0, 0x46	; 037FE070
.arm

; ===== function loc_037FE070 =====
loc_037FE070:
	ldr pc,[pool_037FE074]	; 037FE070
pool_037FE074:
loc_037FE074:
	.word P2_InitThreadContext	; 037FE074
.thumb

; ===== function loc_037FE078 =====
loc_037FE078:
	bx pc	; 037FE078
	.byte 0xC0, 0x46	; 037FE07C
.arm

; ===== function loc_037FE07C =====
loc_037FE07C:
	ldr pc,[pool_037FE080]	; 037FE07C
pool_037FE080:
loc_037FE080:
	.word loc_037FF358	; 037FE080
.thumb

; ===== function loc_037FE084 =====
loc_037FE084:
	push {lr}	; 037FE084
	sub sp,#0x4	; 037FE086
	ldr r0,[pool_037FE110]	; 037FE088
	ldr r1,[r0,#0x0]	; 037FE08A
	cmp r1,#0x0	; 037FE08C
	bne loc_037FE108	; 037FE08E
	mov r1,#0x1	; 037FE090
	str r1,[r0,#0x0]	; 037FE092
	mov r3,#0x0	; 037FE094
	add r1,r3,#0x0	; 037FE096
	ldr r0,[pool_037FE114]	; 037FE098
loc_037FE09A:
	lsl r2,r3,#0x2	; 037FE09A
	add r2,r0,r2	; 037FE09C
	str r1,[r2,#0x14]	; 037FE09E
	add r3,r3,#0x1	; 037FE0A0
	cmp r3,#0x10	; 037FE0A2
	blt loc_037FE09A	; 037FE0A4
	ldr r3,[pool_037FE118]	; 037FE0A6
	ldr r2,[pool_037FE11C]	; 037FE0A8
	str r3,[r2,#0x0]	; 037FE0AA
	mov r3,#0x10	; 037FE0AC
	ldr r2,[pool_037FE120]	; 037FE0AE
	str r3,[r2,#0x54]	; 037FE0B0
	str r1,[r2,#0x50]	; 037FE0B2
	mov r3,#0x1	; 037FE0B4
	str r3,[r2,#0x48]	; 037FE0B6
	str r1,[r2,#0x4c]	; 037FE0B8
	str r1,[r2,#0x58]	; 037FE0BA
	str r2,[r0,#0x14]	; 037FE0BC
	str r2,[r0,#0xc]	; 037FE0BE
	str r2,[r0,#0x8]	; 037FE0C0
	ldr r2,[pool_037FE124]	; 037FE0C2
	cmp r2,#0x0	; 037FE0C4
	bne loc_037FE0CE	; 037FE0C6
	ldr r0,[pool_037FE128]	; 037FE0C8
	sub r3,r0,r2	; 037FE0CA
	b loc_037FE0D6	; 037FE0CC
loc_037FE0CE:
	ldr r1,[pool_037FE12C]	; 037FE0CE
	ldr r0,[pool_037FE130]	; 037FE0D0
	sub r0,r0,r1	; 037FE0D2
	sub r3,r0,r2	; 037FE0D4
loc_037FE0D6:
	ldr r1,[pool_037FE12C]	; 037FE0D6
	ldr r0,[pool_037FE130]	; 037FE0D8
	sub r1,r0,r1	; 037FE0DA
	ldr r2,[pool_037FE120]	; 037FE0DC
	str r1,[r2,#0x6c]	; 037FE0DE
	str r3,[r2,#0x68]	; 037FE0E0
	mov r0,#0x0	; 037FE0E2
	str r0,[r2,#0x70]	; 037FE0E4
	ldr r3,[pool_037FE134]	; 037FE0E6
	sub r1,r1,#0x4	; 037FE0E8
	str r3,[r1,#0x0]	; 037FE0EA
	ldr r3,[pool_037FE138]	; 037FE0EC
	ldr r1,[r2,#0x68]	; 037FE0EE
	str r3,[r1,#0x0]	; 037FE0F0
	ldr r1,[pool_037FE13C]	; 037FE0F2
	strh r0,[r1,#0x34]	; 037FE0F4
	mov r2,#0x10	; 037FE0F6
	ldr r1,[pool_037FE114]	; 037FE0F8
	strh r2,[r1,#0x2]	; 037FE0FA
	strh r0,[r1,#0x0]	; 037FE0FC
	strh r0,[r1,#0x4]	; 037FE0FE
	ldr r2,[pool_037FE140]	; 037FE100
	str r1,[r2,#0x0]	; 037FE102
	bl loc_037FDE18	; 037FE104
loc_037FE108:
	add sp,#0x4	; 037FE108
	pop {r3}	; 037FE10A
	bx r3	; 037FE10C
	.byte 0xC0, 0x46	; 037FE110
pool_037FE110:
loc_037FE110:
	.word P2_BssStart + 0x548	; 037FE110
pool_037FE114:
loc_037FE114:
	.word P2_BssStart + 0x54C	; 037FE114
pool_037FE118:
loc_037FE118:
	.word 0x038058F4	; 037FE118
pool_037FE11C:
loc_037FE11C:
	.word P2_BssStart + 0x544	; 037FE11C
pool_037FE120:
loc_037FE120:
	.word P2_BssStart + 0x5A0	; 037FE120
pool_037FE124:
loc_037FE124:
	.word 0x00000400	; 037FE124
pool_037FE128:
loc_037FE128:
	.word 0x037F8000	; 037FE128
pool_037FE12C:
loc_037FE12C:
	.word 0x00000200	; 037FE12C
pool_037FE130:
loc_037FE130:
	.word 0x0380FF80	; 037FE130
pool_037FE134:
loc_037FE134:
	.word 0xD73BFDF7	; 037FE134
pool_037FE138:
loc_037FE138:
	.word 0xFBDD37BB	; 037FE138
pool_037FE13C:
loc_037FE13C:
	.word P2_BssStart + 0x5E0	; 037FE13C
pool_037FE140:
loc_037FE140:
	.word FirmwareSystemWorkAddress + SystemWorkArm7ThreadInfoOffset	; 037FE140

; ===== function loc_037FE144 =====
loc_037FE144:
	ldr r1,[pool_037FE16C]	; 037FE144
	ldr r2,[r1,#0xc]	; 037FE146
	mov r1,#0x0	; 037FE148
	b loc_037FE150	; 037FE14A
loc_037FE14C:
	add r1,r2,#0x0	; 037FE14C
	ldr r2,[r2,#0x4c]	; 037FE14E
loc_037FE150:
	cmp r2,#0x0	; 037FE150
	beq loc_037FE158	; 037FE152
	cmp r2,r0	; 037FE154
	bne loc_037FE14C	; 037FE156
loc_037FE158:
	cmp r1,#0x0	; 037FE158
	bne loc_037FE164	; 037FE15A
	ldr r1,[r0,#0x4c]	; 037FE15C
	ldr r0,[pool_037FE16C]	; 037FE15E
	str r1,[r0,#0xc]	; 037FE160
	bx lr	; 037FE162
loc_037FE164:
	ldr r0,[r0,#0x4c]	; 037FE164
	str r0,[r1,#0x4c]	; 037FE166
	bx lr	; 037FE168
	.byte 0xC0, 0x46	; 037FE16C
pool_037FE16C:
loc_037FE16C:
	.word P2_BssStart + 0x54C	; 037FE16C

; ===== function loc_037FE170 =====
loc_037FE170:
	push {r4,r5,lr}	; 037FE170
	sub sp,#0x4	; 037FE172
	ldr r1,[pool_037FE1A8]	; 037FE174
	ldr r3,[r1,#0xc]	; 037FE176
	add r5,r3,#0x0	; 037FE178
	mov r4,#0x0	; 037FE17A
	b loc_037FE182	; 037FE17C
loc_037FE17E:
	add r4,r5,#0x0	; 037FE17E
	ldr r5,[r5,#0x4c]	; 037FE180
loc_037FE182:
	cmp r5,#0x0	; 037FE182
	beq loc_037FE18E	; 037FE184
	ldr r2,[r5,#0x54]	; 037FE186
	ldr r1,[r0,#0x54]	; 037FE188
	cmp r2,r1	; 037FE18A
	bcc loc_037FE17E	; 037FE18C
loc_037FE18E:
	cmp r4,#0x0	; 037FE18E
	bne loc_037FE19A	; 037FE190
	str r3,[r0,#0x4c]	; 037FE192
	ldr r1,[pool_037FE1A8]	; 037FE194
	str r0,[r1,#0xc]	; 037FE196
	b loc_037FE1A0	; 037FE198
loc_037FE19A:
	ldr r1,[r4,#0x4c]	; 037FE19A
	str r1,[r0,#0x4c]	; 037FE19C
	str r0,[r4,#0x4c]	; 037FE19E
loc_037FE1A0:
	add sp,#0x4	; 037FE1A0
	pop {r4,r5}	; 037FE1A2
	pop {r3}	; 037FE1A4
	bx r3	; 037FE1A6
pool_037FE1A8:
loc_037FE1A8:
	.word P2_BssStart + 0x54C	; 037FE1A8

; ===== function loc_037FE1AC =====
loc_037FE1AC:
	mov r0,#0x0	; 037FE1AC
	ldr r2,[pool_037FE1C8]	; 037FE1AE
	b loc_037FE1BE	; 037FE1B0
loc_037FE1B2:
	lsl r1,r0,#0x2	; 037FE1B2
	add r1,r2,r1	; 037FE1B4
	ldr r1,[r1,#0x14]	; 037FE1B6
	cmp r1,#0x0	; 037FE1B8
	beq loc_037FE1C6	; 037FE1BA
	add r0,r0,#0x1	; 037FE1BC
loc_037FE1BE:
	cmp r0,#0x10	; 037FE1BE
	blt loc_037FE1B2	; 037FE1C0
	mov r0,#0x0	; 037FE1C2
	mvn r0,r0	; 037FE1C4
loc_037FE1C6:
	bx lr	; 037FE1C6
pool_037FE1C8:
loc_037FE1C8:
	.word 0x038058EC	; 037FE1C8
.arm

; ===== function loc_037FE1CC =====
loc_037FE1CC:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P2_InitThreadContext
	add r1,r1,#0x4	; 037FE1CC
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 037FE1D0
	str r2,[r0,#ThreadContextSvcSpOffset]	; 037FE1D4
	sub r2,r2,#ThreadContextSvcStackBytes	; 037FE1D8
	str r2,[r0,#ThreadContextSpOffset]	; 037FE1DC
	ands r1,r1,#0x1	; 037FE1E0
	movne r1,#0x3f	; 037FE1E4
	moveq r1,#0x1f	; 037FE1E8
	str r1,[r0,#ThreadContextCpsrOffset]	; 037FE1EC
	mov r1,#0x0	; 037FE1F0
	str r1,[r0,#ThreadContextR0Offset]	; 037FE1F4
	str r1,[r0,#0x8]	; 037FE1F8
	str r1,[r0,#0xc]	; 037FE1FC
	str r1,[r0,#0x10]	; 037FE200
	str r1,[r0,#0x14]	; 037FE204
	str r1,[r0,#0x18]	; 037FE208
	str r1,[r0,#0x1c]	; 037FE20C
	str r1,[r0,#0x20]	; 037FE210
	str r1,[r0,#0x24]	; 037FE214
	str r1,[r0,#0x28]	; 037FE218
	str r1,[r0,#0x2c]	; 037FE21C
	str r1,[r0,#0x30]	; 037FE220
	str r1,[r0,#0x34]	; 037FE224
	str r1,[r0,#ThreadContextLrOffset]	; 037FE228
	bx lr	; 037FE22C
.endfunc

; ===== function loc_037FE230 =====
loc_037FE230:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P2_SaveThreadContext
	add r1,r0,#0x0	; 037FE230
	mrs r2,cpsr	; 037FE234
	str r2,[r1],#0x4	; 037FE238
	mov r0,#0xd3	; 037FE23C
	msr cpsr_c,r0	; 037FE240
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE244
	msr cpsr_c,r2	; 037FE248
	mov r0,#0x1	; 037FE24C
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FE250
	adr r0,P2_SaveThreadContextReturn + 4	; 037FE254
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE258
	mov r0,#0x0	; 037FE25C
P2_SaveThreadContextReturn:
	bx lr	; 037FE260
.endfunc

; ===== function loc_037FE264 =====
loc_037FE264:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P2_LoadThreadContext
	mrs r1,cpsr	; 037FE264
	bic r1,r1,#0x1f	; 037FE268
	orr r1,r1,#0xd3	; 037FE26C
	msr cpsr_c,r1	; 037FE270
	ldr r1,[r0],#0x4	; 037FE274
	msr spsr_cxsf,r1	; 037FE278
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE27C
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE280
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FE284
	mov r0,r0	; 037FE288
	subs pc,lr,#0x4	; 037FE28C
.endfunc
.thumb

; ===== function loc_037FE290 =====
loc_037FE290:
	push {r4,r5,r6,r7,lr}	; 037FE290
	sub sp,#0x4	; 037FE292
	add r5,r0,#0x0	; 037FE294
	add r6,r1,#0x0	; 037FE296
	add r4,r2,#0x0	; 037FE298
	bl loc_037FDCE8	; 037FE29A
	add r7,r0,#0x0	; 037FE29E
	mov r0,#0x1	; 037FE2A0
	and r4,r0	; 037FE2A2
	add r0,r5,#0x2	; 037FE2A4
	str r0,[sp,#0x0]	; 037FE2A6
	b loc_037FE2BE	; 037FE2A8
loc_037FE2AA:
	cmp r4,#0x0	; 037FE2AA
	bne loc_037FE2B8	; 037FE2AC
	add r0,r7,#0x0	; 037FE2AE
	bl loc_037FDD0C	; 037FE2B0
	mov r0,#0x0	; 037FE2B4
	b loc_037FE2F2	; 037FE2B6
loc_037FE2B8:
	ldr r0,[sp,#0x0]	; 037FE2B8
	bl loc_037FDF54	; 037FE2BA
loc_037FE2BE:
	ldr r0,[r5,#0x10]	; 037FE2BE
	cmp r0,#0x0	; 037FE2C0
	beq loc_037FE2AA	; 037FE2C2
	cmp r6,#0x0	; 037FE2C4
	beq loc_037FE2D2	; 037FE2C6
	ldr r1,[r5,#0x4]	; 037FE2C8
	ldr r0,[r5,#0xc]	; 037FE2CA
	lsl r0,r0,#0x2	; 037FE2CC
	ldr r0,[r1,r0]	; 037FE2CE
	str r0,[r6,#0x0]	; 037FE2D0
loc_037FE2D2:
	ldr r0,[r5,#0xc]	; 037FE2D2
	add r0,r0,#0x1	; 037FE2D4
	ldr r1,[r5,#0x8]	; 037FE2D6
	bl loc_037FE2FC	; 037FE2D8
	str r1,[r5,#0xc]	; 037FE2DC
	ldr r0,[r5,#0x10]	; 037FE2DE
	sub r0,r0,#0x1	; 037FE2E0
	str r0,[r5,#0x10]	; 037FE2E2
	add r0,r5,#0x0	; 037FE2E4
	bl loc_037FDF0C	; 037FE2E6
	add r0,r7,#0x0	; 037FE2EA
	bl loc_037FDD0C	; 037FE2EC
	mov r0,#0x1	; 037FE2F0
loc_037FE2F2:
	add sp,#0x4	; 037FE2F2
	pop {r4,r5,r6,r7}	; 037FE2F4
	pop {r3}	; 037FE2F6
	bx r3	; 037FE2F8
	.byte 0xC0, 0x46	; 037FE2FC

; ===== function loc_037FE2FC =====
loc_037FE2FC:
	bx pc	; 037FE2FC
	.byte 0xC0, 0x46	; 037FE300
.arm

; ===== function loc_037FE300 =====
loc_037FE300:
	ldr pc,[pool_037FE304]	; 037FE300
pool_037FE304:
loc_037FE304:
	.word P2_SignedDivMod	; 037FE304
.thumb

; ===== function loc_037FE308 =====
loc_037FE308:
	push {r4,r5,r6,r7,lr}	; 037FE308
	sub sp,#0x4	; 037FE30A
	add r5,r0,#0x0	; 037FE30C
	add r6,r1,#0x0	; 037FE30E
	add r4,r2,#0x0	; 037FE310
	bl loc_037FDCE8	; 037FE312
	add r7,r0,#0x0	; 037FE316
	mov r0,#0x1	; 037FE318
	and r4,r0	; 037FE31A
	b loc_037FE332	; 037FE31C
loc_037FE31E:
	cmp r4,#0x0	; 037FE31E
	bne loc_037FE32C	; 037FE320
	add r0,r7,#0x0	; 037FE322
	bl loc_037FDD0C	; 037FE324
	mov r0,#0x0	; 037FE328
	b loc_037FE35C	; 037FE32A
loc_037FE32C:
	add r0,r5,#0x0	; 037FE32C
	bl loc_037FDF54	; 037FE32E
loc_037FE332:
	ldr r2,[r5,#0x10]	; 037FE332
	ldr r1,[r5,#0x8]	; 037FE334
	cmp r1,r2	; 037FE336
	ble loc_037FE31E	; 037FE338
	ldr r0,[r5,#0xc]	; 037FE33A
	add r0,r0,r2	; 037FE33C
	bl loc_037FE2FC	; 037FE33E
	ldr r2,[r5,#0x4]	; 037FE342
	lsl r0,r1,#0x2	; 037FE344
	str r6,[r2,r0]	; 037FE346
	ldr r0,[r5,#0x10]	; 037FE348
	add r0,r0,#0x1	; 037FE34A
	str r0,[r5,#0x10]	; 037FE34C
	add r0,r5,#0x2	; 037FE34E
	bl loc_037FDF0C	; 037FE350
	add r0,r7,#0x0	; 037FE354
	bl loc_037FDD0C	; 037FE356
	mov r0,#0x1	; 037FE35A
loc_037FE35C:
	add sp,#0x4	; 037FE35C
	pop {r4,r5,r6,r7}	; 037FE35E
	pop {r3}	; 037FE360
	bx r3	; 037FE362

; ===== function loc_037FE364 =====
loc_037FE364:
	mov r3,#0x0	; 037FE364
	strh r3,[r0,#0x0]	; 037FE366
	strh r3,[r0,#0x2]	; 037FE368
	str r1,[r0,#0x4]	; 037FE36A
	str r2,[r0,#0x8]	; 037FE36C
	str r3,[r0,#0xc]	; 037FE36E
	str r3,[r0,#0x10]	; 037FE370
	bx lr	; 037FE372

; ===== function loc_037FE374 =====
loc_037FE374:
	ldr r3,[r0,#0x60]	; 037FE374
	ldr r2,[r3,#0x10]	; 037FE376
	cmp r2,#0x0	; 037FE378
	bne loc_037FE382	; 037FE37A
	mov r1,#0x0	; 037FE37C
	str r1,[r0,#0x64]	; 037FE37E
	b loc_037FE386	; 037FE380
loc_037FE382:
	mov r1,#0x0	; 037FE382
	str r1,[r2,#0xc]	; 037FE384
loc_037FE386:
	str r2,[r0,#0x60]	; 037FE386
	add r0,r3,#0x0	; 037FE388
	bx lr	; 037FE38A
P2_Entry_037FE38C:
	ldr r2,[r1,#0x10]	; 037FE38C
	ldr r1,[r1,#0xc]	; 037FE38E
	cmp r2,#0x0	; 037FE390
	bne P2_Entry_037FE398	; 037FE392
	str r1,[r0,#0x64]	; 037FE394
	b P2_Entry_037FE39A	; 037FE396
P2_Entry_037FE398:
	str r1,[r2,#0xc]	; 037FE398
P2_Entry_037FE39A:
	cmp r1,#0x0	; 037FE39A
	bne P2_Entry_037FE3A2	; 037FE39C
	str r2,[r0,#0x60]	; 037FE39E
	bx lr	; 037FE3A0
P2_Entry_037FE3A2:
	str r2,[r1,#0x10]	; 037FE3A2
	bx lr	; 037FE3A4
	.byte 0x00, 0x00	; 037FE3A6
P2_Entry_037FE3A8:
	ldr r3,[r0,#0x64]	; 037FE3A8
	cmp r3,#0x0	; 037FE3AA
	bne P2_Entry_037FE3B2	; 037FE3AC
	str r1,[r0,#0x60]	; 037FE3AE
	b P2_Entry_037FE3B6	; 037FE3B0
P2_Entry_037FE3B2:
	ldr r2,[r0,#0x60]	; 037FE3B2
	str r1,[r2,#0x10]	; 037FE3B4
P2_Entry_037FE3B6:
	str r3,[r1,#0xc]	; 037FE3B6
	mov r2,#0x0	; 037FE3B8
	str r2,[r1,#0x10]	; 037FE3BA
	str r1,[r0,#0x64]	; 037FE3BC
	bx lr	; 037FE3BE

; ===== function loc_037FE3C0 =====
loc_037FE3C0:
	push {r4,r5,lr}	; 037FE3C0
	sub sp,#0x4	; 037FE3C2
	add r5,r0,#0x0	; 037FE3C4
	mov r4,#0x0	; 037FE3C6
	b loc_037FE3D8	; 037FE3C8
loc_037FE3CA:
	add r0,r5,#0x0	; 037FE3CA
	bl loc_037FE374	; 037FE3CC
	str r4,[r0,#0x8]	; 037FE3D0
	str r4,[r0,#0x4]	; 037FE3D2
	bl loc_037FDF0C	; 037FE3D4
loc_037FE3D8:
	ldr r0,[r5,#0x60]	; 037FE3D8
	cmp r0,#0x0	; 037FE3DA
	bne loc_037FE3CA	; 037FE3DC
	add sp,#0x4	; 037FE3DE
	pop {r4,r5}	; 037FE3E0
	pop {r3}	; 037FE3E2
	bx r3	; 037FE3E4
	.byte 0x00, 0x00	; 037FE3E6
P2_Entry_037FE3E8:
	push {r4,r5,lr}	; 037FE3E8
	sub sp,#0x4	; 037FE3EA
	add r5,r0,#0x0	; 037FE3EC
	bl loc_037FDCE8	; 037FE3EE
	add r4,r0,#0x0	; 037FE3F2
	ldr r0,[pool_037FE428]	; 037FE3F4
	ldr r0,[r0,#0x8]	; 037FE3F6
	ldr r1,[r5,#0x4]	; 037FE3F8
	cmp r1,r0	; 037FE3FA
	bne P2_Entry_037FE41A	; 037FE3FC
	ldr r1,[r5,#0x8]	; 037FE3FE
	sub r1,r1,#0x1	; 037FE400
	str r1,[r5,#0x8]	; 037FE402
	ldr r1,[r5,#0x8]	; 037FE404
	cmp r1,#0x0	; 037FE406
	bne P2_Entry_037FE41A	; 037FE408
	add r1,r5,#0x0	; 037FE40A
	bl P2_Entry_037FE38C	; 037FE40C
	mov r0,#0x0	; 037FE410
	str r0,[r5,#0x4]	; 037FE412
	add r0,r5,#0x0	; 037FE414
	bl loc_037FDF0C	; 037FE416
P2_Entry_037FE41A:
	add r0,r4,#0x0	; 037FE41A
	bl loc_037FDD0C	; 037FE41C
	add sp,#0x4	; 037FE420
	pop {r4,r5}	; 037FE422
	pop {r3}	; 037FE424
	bx r3	; 037FE426
pool_037FE428:
	.word P2_BssStart + 0x54C	; 037FE428
P2_Entry_037FE42C:
	push {r4,r5,r6,r7,lr}	; 037FE42C
	sub sp,#0x4	; 037FE42E
	add r5,r0,#0x0	; 037FE430
	bl loc_037FDCE8	; 037FE432
	add r6,r0,#0x0	; 037FE436
	ldr r0,[pool_037FE47C]	; 037FE438
	ldr r4,[r0,#0x8]	; 037FE43A
	mov r7,#0x0	; 037FE43C
P2_Entry_037FE43E:
	ldr r0,[r5,#0x4]	; 037FE43E
	cmp r0,#0x0	; 037FE440
	bne P2_Entry_037FE456	; 037FE442
	str r4,[r5,#0x4]	; 037FE444
	ldr r0,[r5,#0x8]	; 037FE446
	add r0,r0,#0x1	; 037FE448
	str r0,[r5,#0x8]	; 037FE44A
	add r0,r4,#0x0	; 037FE44C
	add r1,r5,#0x0	; 037FE44E
	bl P2_Entry_037FE3A8	; 037FE450
	b P2_Entry_037FE46E	; 037FE454
P2_Entry_037FE456:
	cmp r0,r4	; 037FE456
	bne P2_Entry_037FE462	; 037FE458
	ldr r0,[r5,#0x8]	; 037FE45A
	add r0,r0,#0x1	; 037FE45C
	str r0,[r5,#0x8]	; 037FE45E
	b P2_Entry_037FE46E	; 037FE460
P2_Entry_037FE462:
	str r5,[r4,#0x5c]	; 037FE462
	add r0,r5,#0x0	; 037FE464
	bl loc_037FDF54	; 037FE466
	str r7,[r4,#0x5c]	; 037FE46A
	b P2_Entry_037FE43E	; 037FE46C
P2_Entry_037FE46E:
	add r0,r6,#0x0	; 037FE46E
	bl loc_037FDD0C	; 037FE470
	add sp,#0x4	; 037FE474
	pop {r4,r5,r6,r7}	; 037FE476
	pop {r3}	; 037FE478
	bx r3	; 037FE47A
pool_037FE47C:
	.word P2_BssStart + 0x54C	; 037FE47C
P2_Entry_037FE480:
	mov r1,#0x0	; 037FE480
	strh r1,[r0,#0x0]	; 037FE482
	str r1,[r0,#0x4]	; 037FE484
	str r1,[r0,#0x8]	; 037FE486
	bx lr	; 037FE488
	.byte 0x00, 0x00	; 037FE48A

; ===== function loc_037FE48C =====
loc_037FE48C:
	push {lr}	; 037FE48C
	sub sp,#0x4	; 037FE48E
	bl loc_037FE570	; 037FE490
	bl loc_03801E58	; 037FE494
	bl loc_037FDDC8	; 037FE498
	bl loc_037FDB94	; 037FE49C
	bl loc_037FE948	; 037FE4A0
	bl loc_037FEC50	; 037FE4A4
	bl loc_037FE084	; 037FE4A8
	bl loc_038048B8	; 037FE4AC
	add sp,#0x4	; 037FE4B0
	pop {r3}	; 037FE4B2
	bx r3	; 037FE4B4
	.byte 0x00, 0x00	; 037FE4B8

; ===== function loc_037FE4B8 =====
loc_037FE4B8:
	lsl r2,r0,#0x2	; 037FE4B8
	ldr r0,[pool_037FE4C0]	; 037FE4BA
	str r1,[r2,r0]	; 037FE4BC
	bx lr	; 037FE4BE
pool_037FE4C0:
loc_037FE4C0:
	.word 0x027FFDA0	; 037FE4C0

; ===== function loc_037FE4C4 =====
loc_037FE4C4:
	lsl r2,r0,#0x2	; 037FE4C4
	ldr r0,[pool_037FE4CC]	; 037FE4C6
	str r1,[r2,r0]	; 037FE4C8
	bx lr	; 037FE4CA
pool_037FE4CC:
loc_037FE4CC:
	.word 0x027FFDC4	; 037FE4CC

; ===== function loc_037FE4D0 =====
loc_037FE4D0:
	cmp r0,#0x1	; 037FE4D0
	beq loc_037FE4DE	; 037FE4D2
	cmp r0,#0x7	; 037FE4D4
	beq loc_037FE4E2	; 037FE4D6
	cmp r0,#0x8	; 037FE4D8
	beq loc_037FE4EE	; 037FE4DA
	b loc_037FE4FA	; 037FE4DC
loc_037FE4DE:
	ldr r0,[pool_037FE500]	; 037FE4DE
	bx lr	; 037FE4E0
loc_037FE4E2:
	ldr r0,[pool_037FE504]	; 037FE4E2
	ldr r1,[pool_037FE508]	; 037FE4E4
	cmp r0,r1	; 037FE4E6
	bls loc_037FE4FC	; 037FE4E8
	add r0,r1,#0x0	; 037FE4EA
	bx lr	; 037FE4EC
loc_037FE4EE:
	ldr r0,[pool_037FE508]	; 037FE4EE
	ldr r1,[pool_037FE504]	; 037FE4F0
	cmp r1,r0	; 037FE4F2
	bls loc_037FE4FC	; 037FE4F4
	add r0,r1,#0x0	; 037FE4F6
	bx lr	; 037FE4F8
loc_037FE4FA:
	mov r0,#0x0	; 037FE4FA
loc_037FE4FC:
	bx lr	; 037FE4FC
	.byte 0xC0, 0x46	; 037FE500
pool_037FE500:
loc_037FE500:
	.word 0x027C0000	; 037FE500
pool_037FE504:
loc_037FE504:
	.word 0x037F8370	; 037FE504
pool_037FE508:
loc_037FE508:
	.word 0x03800000	; 037FE508

; ===== function loc_037FE50C =====
loc_037FE50C:
	cmp r0,#0x1	; 037FE50C
	beq loc_037FE51A	; 037FE50E
	cmp r0,#0x7	; 037FE510
	beq loc_037FE51E	; 037FE512
	cmp r0,#0x8	; 037FE514
	beq loc_037FE522	; 037FE516
	b loc_037FE540	; 037FE518
loc_037FE51A:
	ldr r0,[pool_037FE544]	; 037FE51A
	bx lr	; 037FE51C
loc_037FE51E:
	ldr r0,[pool_037FE548]	; 037FE51E
	bx lr	; 037FE520
loc_037FE522:
	ldr r1,[pool_037FE54C]	; 037FE522
	ldr r0,[pool_037FE550]	; 037FE524
	sub r0,r0,r1	; 037FE526
	ldr r1,[pool_037FE554]	; 037FE528
	cmp r1,#0x0	; 037FE52A
	bne loc_037FE532	; 037FE52C
	ldr r0,[pool_037FE548]	; 037FE52E
	bx lr	; 037FE530
loc_037FE532:
	cmp r1,#0x0	; 037FE532
	bge loc_037FE53C	; 037FE534
	ldr r0,[pool_037FE548]	; 037FE536
	sub r0,r0,r1	; 037FE538
	bx lr	; 037FE53A
loc_037FE53C:
	sub r0,r0,r1	; 037FE53C
	bx lr	; 037FE53E
loc_037FE540:
	mov r0,#0x0	; 037FE540
	bx lr	; 037FE542
pool_037FE544:
loc_037FE544:
	.word 0x027FF000	; 037FE544
pool_037FE548:
loc_037FE548:
	.word 0x03800000	; 037FE548
pool_037FE54C:
loc_037FE54C:
	.word 0x00000200	; 037FE54C
pool_037FE550:
loc_037FE550:
	.word 0x0380FF80	; 037FE550
pool_037FE554:
loc_037FE554:
	.word 0x00000400	; 037FE554
P2_Entry_037FE558:
	lsl r1,r0,#0x2	; 037FE558
	ldr r0,[pool_037FE560]	; 037FE55A
	ldr r0,[r1,r0]	; 037FE55C
	bx lr	; 037FE55E
pool_037FE560:
	.word 0x027FFDA0	; 037FE560
P2_Entry_037FE564:
	lsl r1,r0,#0x2	; 037FE564
	ldr r0,[pool_037FE56C]	; 037FE566
	ldr r0,[r1,r0]	; 037FE568
	bx lr	; 037FE56A
pool_037FE56C:
	.word 0x027FFDC4	; 037FE56C

; ===== function loc_037FE570 =====
loc_037FE570:
	push {lr}	; 037FE570
	sub sp,#0x4	; 037FE572
	ldr r1,[pool_037FE598]	; 037FE574
	ldr r0,[r1,#0x0]	; 037FE576
	cmp r0,#0x0	; 037FE578
	bne loc_037FE590	; 037FE57A
	mov r0,#0x1	; 037FE57C
	str r0,[r1,#0x0]	; 037FE57E
	bl loc_037FE59C	; 037FE580
	mov r0,#0x7	; 037FE584
	bl loc_037FE59C	; 037FE586
	mov r0,#0x8	; 037FE58A
	bl loc_037FE59C	; 037FE58C
loc_037FE590:
	add sp,#0x4	; 037FE590
	pop {r3}	; 037FE592
	bx r3	; 037FE594
	.byte 0xC0, 0x46	; 037FE598
pool_037FE598:
loc_037FE598:
	.word P2_BssStart + 0x618	; 037FE598

; ===== function loc_037FE59C =====
loc_037FE59C:
	push {r4,lr}	; 037FE59C
	add r4,r0,#0x0	; 037FE59E
	bl loc_037FE50C	; 037FE5A0
	add r1,r0,#0x0	; 037FE5A4
	add r0,r4,#0x0	; 037FE5A6
	bl loc_037FE4C4	; 037FE5A8
	add r0,r4,#0x0	; 037FE5AC
	bl loc_037FE4D0	; 037FE5AE
	add r1,r0,#0x0	; 037FE5B2
	add r0,r4,#0x0	; 037FE5B4
	bl loc_037FE4B8	; 037FE5B6
	pop {r4}	; 037FE5BA
	pop {r3}	; 037FE5BC
	bx r3	; 037FE5BE

; ===== function loc_037FE5C0 =====
P2_Entry_037FE5C0:
	push {r4,r5,r6,r7,lr}	; 037FE5C0
	sub sp,#0xc	; 037FE5C2
	add r4,r0,#0x0	; 037FE5C4
	add r5,r1,#0x0	; 037FE5C6
	add r6,r2,#0x0	; 037FE5C8
	bl loc_037FDCE8	; 037FE5CA
	str r0,[sp,#0x4]	; 037FE5CE
	lsl r1,r4,#0x2	; 037FE5D0
	ldr r0,[pool_037FE630]	; 037FE5D2
	ldr r1,[r0,r1]	; 037FE5D4
	add r5,#0x1f	; 037FE5D6
	mov r0,#0x1f	; 037FE5D8
	bic r5,r0	; 037FE5DA
	bic r6,r0	; 037FE5DC
	mov r4,#0x0	; 037FE5DE
	ldr r7,[r1,#0x4]	; 037FE5E0
	b loc_037FE618	; 037FE5E2
loc_037FE5E4:
	ldr r0,[r1,#0x10]	; 037FE5E4
	add r3,r4,#0x0	; 037FE5E6
	str r3,[sp,#0x0]	; 037FE5E8
	mov r2,#0xc	; 037FE5EA
	mul r3,r2	; 037FE5EC
	str r3,[sp,#0x0]	; 037FE5EE
	add r3,r0,r3	; 037FE5F0
	ldr r2,[sp,#0x0]	; 037FE5F2
	ldr r0,[r0,r2]	; 037FE5F4
	cmp r0,#0x0	; 037FE5F6
	bge loc_037FE616	; 037FE5F8
	sub r0,r6,r5	; 037FE5FA
	str r0,[r3,#0x0]	; 037FE5FC
	mov r1,#0x0	; 037FE5FE
	str r1,[r5,#0x0]	; 037FE600
	str r1,[r5,#0x4]	; 037FE602
	ldr r0,[r3,#0x0]	; 037FE604
	str r0,[r5,#0x8]	; 037FE606
	str r5,[r3,#0x4]	; 037FE608
	str r1,[r3,#0x8]	; 037FE60A
	ldr r0,[sp,#0x4]	; 037FE60C
	bl loc_037FDD0C	; 037FE60E
	add r0,r4,#0x0	; 037FE612
	b loc_037FE626	; 037FE614
loc_037FE616:
	add r4,r4,#0x1	; 037FE616
loc_037FE618:
	cmp r4,r7	; 037FE618
	blt loc_037FE5E4	; 037FE61A
	ldr r0,[sp,#0x4]	; 037FE61C
	bl loc_037FDD0C	; 037FE61E
	mov r0,#0x0	; 037FE622
	mvn r0,r0	; 037FE624
loc_037FE626:
	add sp,#0xc	; 037FE626
	pop {r4,r5,r6,r7}	; 037FE628
	pop {r3}	; 037FE62A
	bx r3	; 037FE62C
	.byte 0xC0, 0x46	; 037FE630
pool_037FE630:
loc_037FE630:
	.word P2_BssStart + 0x61C	; 037FE630
P2_Entry_037FE634:
	push {r4,r5,r6,r7,lr}	; 037FE634
	sub sp,#0xc	; 037FE636
	add r6,r0,#0x0	; 037FE638
	add r5,r1,#0x0	; 037FE63A
	str r2,[sp,#0x8]	; 037FE63C
	add r4,r3,#0x0	; 037FE63E
	bl loc_037FDCE8	; 037FE640
	str r0,[sp,#0x0]	; 037FE644
	lsl r1,r6,#0x2	; 037FE646
	ldr r0,[pool_037FE6AC]	; 037FE648
	str r5,[r0,r1]	; 037FE64A
	add r3,r4,#0x0	; 037FE64C
	mov r0,#0xc	; 037FE64E
	mul r3,r0	; 037FE650
	add r0,r5,#0x0	; 037FE652
	add r0,#0x14	; 037FE654
	str r0,[r5,#0x10]	; 037FE656
	str r4,[r5,#0x4]	; 037FE658
	mov r2,#0x0	; 037FE65A
	mvn r0,r2	; 037FE65C
	add r7,r2,#0x0	; 037FE65E
	b P2_Entry_037FE67C	; 037FE660
P2_Entry_037FE662:
	ldr r1,[r5,#0x10]	; 037FE662
	add r6,r2,#0x0	; 037FE664
	str r6,[sp,#0x4]	; 037FE666
	mov r4,#0xc	; 037FE668
	mul r6,r4	; 037FE66A
	str r6,[sp,#0x4]	; 037FE66C
	add r6,r1,r6	; 037FE66E
	ldr r4,[sp,#0x4]	; 037FE670
	str r0,[r1,r4]	; 037FE672
	str r7,[r6,#0x8]	; 037FE674
	ldr r1,[r6,#0x8]	; 037FE676
	str r1,[r6,#0x4]	; 037FE678
	add r2,r2,#0x1	; 037FE67A
P2_Entry_037FE67C:
	ldr r1,[r5,#0x4]	; 037FE67C
	cmp r2,r1	; 037FE67E
	blt P2_Entry_037FE662	; 037FE680
	mov r0,#0x0	; 037FE682
	mvn r0,r0	; 037FE684
	str r0,[r5,#0x0]	; 037FE686
	ldr r0,[r5,#0x10]	; 037FE688
	add r0,r0,r3	; 037FE68A
	add r0,#0x1f	; 037FE68C
	mov r1,#0x1f	; 037FE68E
	bic r0,r1	; 037FE690
	str r0,[r5,#0x8]	; 037FE692
	ldr r0,[sp,#0x8]	; 037FE694
	bic r0,r1	; 037FE696
	str r0,[sp,#0x8]	; 037FE698
	str r0,[r5,#0xc]	; 037FE69A
	ldr r0,[sp,#0x0]	; 037FE69C
	bl loc_037FDD0C	; 037FE69E
	ldr r0,[r5,#0x8]	; 037FE6A2
	add sp,#0xc	; 037FE6A4
	pop {r4,r5,r6,r7}	; 037FE6A6
	pop {r3}	; 037FE6A8
	bx r3	; 037FE6AA
pool_037FE6AC:
	.word P2_BssStart + 0x61C	; 037FE6AC
P2_Entry_037FE6B0:
	push {r4,r5,lr}	; 037FE6B0
	sub sp,#0x4	; 037FE6B2
	add r5,r0,#0x0	; 037FE6B4
	add r4,r1,#0x0	; 037FE6B6
	bl loc_037FDCE8	; 037FE6B8
	lsl r2,r5,#0x2	; 037FE6BC
	ldr r1,[pool_037FE6D4]	; 037FE6BE
	ldr r1,[r1,r2]	; 037FE6C0
	ldr r5,[r1,#0x0]	; 037FE6C2
	str r4,[r1,#0x0]	; 037FE6C4
	bl loc_037FDD0C	; 037FE6C6
	add r0,r5,#0x0	; 037FE6CA
	add sp,#0x4	; 037FE6CC
	pop {r4,r5}	; 037FE6CE
	pop {r3}	; 037FE6D0
	bx r3	; 037FE6D2
pool_037FE6D4:
	.word P2_BssStart + 0x61C	; 037FE6D4
P2_Entry_037FE6D8:
	push {r4,r5,r6,r7,lr}	; 037FE6D8
	sub sp,#0x4	; 037FE6DA
	add r6,r0,#0x0	; 037FE6DC
	add r5,r1,#0x0	; 037FE6DE
	add r4,r2,#0x0	; 037FE6E0
	bl loc_037FDCE8	; 037FE6E2
	add r7,r0,#0x0	; 037FE6E6
	lsl r1,r6,#0x2	; 037FE6E8
	ldr r0,[pool_037FE720]	; 037FE6EA
	ldr r0,[r0,r1]	; 037FE6EC
	cmp r5,#0x0	; 037FE6EE
	bge P2_Entry_037FE6F4	; 037FE6F0
	ldr r5,[r0,#0x0]	; 037FE6F2
P2_Entry_037FE6F4:
	sub r4,#0x20	; 037FE6F4
	ldr r1,[r0,#0x10]	; 037FE6F6
	mov r0,#0xc	; 037FE6F8
	mul r5,r0	; 037FE6FA
	add r5,r1,r5	; 037FE6FC
	ldr r0,[r5,#0x8]	; 037FE6FE
	add r1,r4,#0x0	; 037FE700
	bl loc_037FE830	; 037FE702
	str r0,[r5,#0x8]	; 037FE706
	ldr r0,[r5,#0x4]	; 037FE708
	add r1,r4,#0x0	; 037FE70A
	bl P2_Entry_037FE7D0	; 037FE70C
	str r0,[r5,#0x4]	; 037FE710
	add r0,r7,#0x0	; 037FE712
	bl loc_037FDD0C	; 037FE714
	add sp,#0x4	; 037FE718
	pop {r4,r5,r6,r7}	; 037FE71A
	pop {r3}	; 037FE71C
	bx r3	; 037FE71E
pool_037FE720:
	.word P2_BssStart + 0x61C	; 037FE720

; ===== function loc_037FE724 =====
loc_037FE724:
	push {r4,r5,r6,r7,lr}	; 037FE724
	sub sp,#0x4	; 037FE726
	add r6,r0,#0x0	; 037FE728
	add r4,r1,#0x0	; 037FE72A
	add r5,r2,#0x0	; 037FE72C
	bl loc_037FDCE8	; 037FE72E
	add r7,r0,#0x0	; 037FE732
	lsl r2,r6,#0x2	; 037FE734
	ldr r1,[pool_037FE7CC]	; 037FE736
	ldr r1,[r1,r2]	; 037FE738
	cmp r1,#0x0	; 037FE73A
	bne loc_037FE746	; 037FE73C
	bl loc_037FDD0C	; 037FE73E
	mov r0,#0x0	; 037FE742
	b loc_037FE7C4	; 037FE744
loc_037FE746:
	cmp r4,#0x0	; 037FE746
	bge loc_037FE74C	; 037FE748
	ldr r4,[r1,#0x0]	; 037FE74A
loc_037FE74C:
	ldr r1,[r1,#0x10]	; 037FE74C
	mov r0,#0xc	; 037FE74E
	mul r4,r0	; 037FE750
	add r6,r1,r4	; 037FE752
	add r5,#0x20	; 037FE754
	add r5,#0x1f	; 037FE756
	mov r0,#0x1f	; 037FE758
	bic r5,r0	; 037FE75A
	ldr r0,[r6,#0x4]	; 037FE75C
	add r4,r0,#0x0	; 037FE75E
	b loc_037FE76A	; 037FE760
loc_037FE762:
	ldr r1,[r4,#0x8]	; 037FE762
	cmp r5,r1	; 037FE764
	ble loc_037FE76E	; 037FE766
	ldr r4,[r4,#0x4]	; 037FE768
loc_037FE76A:
	cmp r4,#0x0	; 037FE76A
	bne loc_037FE762	; 037FE76C
loc_037FE76E:
	cmp r4,#0x0	; 037FE76E
	bne loc_037FE77C	; 037FE770
	add r0,r7,#0x0	; 037FE772
	bl loc_037FDD0C	; 037FE774
	mov r0,#0x0	; 037FE778
	b loc_037FE7C4	; 037FE77A
loc_037FE77C:
	ldr r1,[r4,#0x8]	; 037FE77C
	sub r1,r1,r5	; 037FE77E
	cmp r1,#0x40	; 037FE780
	bcs loc_037FE78E	; 037FE782
	add r1,r4,#0x0	; 037FE784
	bl loc_037FE830	; 037FE786
	str r0,[r6,#0x4]	; 037FE78A
	b loc_037FE7B0	; 037FE78C
loc_037FE78E:
	str r5,[r4,#0x8]	; 037FE78E
	add r0,r4,r5	; 037FE790
	str r1,[r0,#0x8]	; 037FE792
	ldr r1,[r4,#0x0]	; 037FE794
	str r1,[r4,r5]	; 037FE796
	ldr r1,[r4,#0x4]	; 037FE798
	str r1,[r0,#0x4]	; 037FE79A
	ldr r1,[r0,#0x4]	; 037FE79C
	cmp r1,#0x0	; 037FE79E
	beq loc_037FE7A4	; 037FE7A0
	str r0,[r1,#0x0]	; 037FE7A2
loc_037FE7A4:
	ldr r1,[r0,#0x0]	; 037FE7A4
	cmp r1,#0x0	; 037FE7A6
	beq loc_037FE7AE	; 037FE7A8
	str r0,[r1,#0x4]	; 037FE7AA
	b loc_037FE7B0	; 037FE7AC
loc_037FE7AE:
	str r0,[r6,#0x4]	; 037FE7AE
loc_037FE7B0:
	ldr r0,[r6,#0x8]	; 037FE7B0
	add r1,r4,#0x0	; 037FE7B2
	bl loc_037FE84C	; 037FE7B4
	str r0,[r6,#0x8]	; 037FE7B8
	add r0,r7,#0x0	; 037FE7BA
	bl loc_037FDD0C	; 037FE7BC
	add r4,#0x20	; 037FE7C0
	add r0,r4,#0x0	; 037FE7C2
loc_037FE7C4:
	add sp,#0x4	; 037FE7C4
	pop {r4,r5,r6,r7}	; 037FE7C6
	pop {r3}	; 037FE7C8
	bx r3	; 037FE7CA
pool_037FE7CC:
loc_037FE7CC:
	.word P2_BssStart + 0x61C	; 037FE7CC
P2_Entry_037FE7D0:
	push {r4,r5,lr}	; 037FE7D0
	sub sp,#0x4	; 037FE7D2
	add r2,r0,#0x0	; 037FE7D4
	mov r3,#0x0	; 037FE7D6
	b P2_Entry_037FE7E2	; 037FE7D8
P2_Entry_037FE7DA:
	cmp r1,r2	; 037FE7DA
	bls P2_Entry_037FE7E6	; 037FE7DC
	add r3,r2,#0x0	; 037FE7DE
	ldr r2,[r2,#0x4]	; 037FE7E0
P2_Entry_037FE7E2:
	cmp r2,#0x0	; 037FE7E2
	bne P2_Entry_037FE7DA	; 037FE7E4
P2_Entry_037FE7E6:
	str r2,[r1,#0x4]	; 037FE7E6
	str r3,[r1,#0x0]	; 037FE7E8
	cmp r2,#0x0	; 037FE7EA
	beq P2_Entry_037FE808	; 037FE7EC
	str r1,[r2,#0x0]	; 037FE7EE
	ldr r5,[r1,#0x8]	; 037FE7F0
	add r4,r1,r5	; 037FE7F2
	cmp r4,r2	; 037FE7F4
	bne P2_Entry_037FE808	; 037FE7F6
	ldr r4,[r2,#0x8]	; 037FE7F8
	add r4,r5,r4	; 037FE7FA
	str r4,[r1,#0x8]	; 037FE7FC
	ldr r2,[r2,#0x4]	; 037FE7FE
	str r2,[r1,#0x4]	; 037FE800
	cmp r2,#0x0	; 037FE802
	beq P2_Entry_037FE808	; 037FE804
	str r1,[r2,#0x0]	; 037FE806
P2_Entry_037FE808:
	cmp r3,#0x0	; 037FE808
	beq P2_Entry_037FE826	; 037FE80A
	str r1,[r3,#0x4]	; 037FE80C
	ldr r4,[r3,#0x8]	; 037FE80E
	add r5,r3,r4	; 037FE810
	cmp r5,r1	; 037FE812
	bne P2_Entry_037FE828	; 037FE814
	ldr r1,[r1,#0x8]	; 037FE816
	add r1,r4,r1	; 037FE818
	str r1,[r3,#0x8]	; 037FE81A
	str r2,[r3,#0x4]	; 037FE81C
	cmp r2,#0x0	; 037FE81E
	beq P2_Entry_037FE828	; 037FE820
	str r3,[r2,#0x0]	; 037FE822
	b P2_Entry_037FE828	; 037FE824
P2_Entry_037FE826:
	add r0,r1,#0x0	; 037FE826
P2_Entry_037FE828:
	add sp,#0x4	; 037FE828
	pop {r4,r5}	; 037FE82A
	pop {r3}	; 037FE82C
	bx r3	; 037FE82E

; ===== function loc_037FE830 =====
loc_037FE830:
	ldr r3,[r1,#0x4]	; 037FE830
	cmp r3,#0x0	; 037FE832
	beq loc_037FE83A	; 037FE834
	ldr r2,[r1,#0x0]	; 037FE836
	str r2,[r3,#0x0]	; 037FE838
loc_037FE83A:
	ldr r2,[r1,#0x0]	; 037FE83A
	cmp r2,#0x0	; 037FE83C
	bne loc_037FE844	; 037FE83E
	ldr r0,[r1,#0x4]	; 037FE840
	bx lr	; 037FE842
loc_037FE844:
	ldr r1,[r1,#0x4]	; 037FE844
	str r1,[r2,#0x4]	; 037FE846
	bx lr	; 037FE848
	.byte 0x00, 0x00	; 037FE84C

; ===== function loc_037FE84C =====
loc_037FE84C:
	str r0,[r1,#0x4]	; 037FE84C
	mov r2,#0x0	; 037FE84E
	str r2,[r1,#0x0]	; 037FE850
	cmp r0,#0x0	; 037FE852
	beq loc_037FE858	; 037FE854
	str r1,[r0,#0x0]	; 037FE856
loc_037FE858:
	add r0,r1,#0x0	; 037FE858
	bx lr	; 037FE85A

; ===== function loc_037FE85C =====
loc_037FE85C:
	ldr r1,[pool_037FE86C]	; 037FE85C
	ldrh r3,[r1,#0x0]	; 037FE85E
	mov r2,#0x1	; 037FE860
	lsl r2,r0	; 037FE862
	orr r3,r2	; 037FE864
	strh r3,[r1,#0x0]	; 037FE866
	bx lr	; 037FE868
	.byte 0xC0, 0x46	; 037FE86C
pool_037FE86C:
loc_037FE86C:
	.word P2_BssStart + 0x640	; 037FE86C

; ===== function loc_037FE870 =====
loc_037FE870:
	push {r4,r5,lr}	; 037FE870
	sub sp,#0xc	; 037FE872
	bl loc_037FDCE8	; 037FE874
	ldr r1,[pool_037FE8D8]	; 037FE878
	ldrh r1,[r1,#0x0]	; 037FE87A
	add r3,sp,#0x0	; 037FE87C
	strh r1,[r3,#0x0]	; 037FE87E
	ldr r1,[pool_037FE8DC]	; 037FE880
	ldr r5,[r1,#0x0]	; 037FE882
	ldr r4,[r1,#0x4]	; 037FE884
	ldr r1,[pool_037FE8E0]	; 037FE886
	mov r2,#0x0	; 037FE888
	and r4,r1	; 037FE88A
	bic r5,r2	; 037FE88C
	str r5,[sp,#0x4]	; 037FE88E
	str r4,[sp,#0x8]	; 037FE890
	ldr r1,[pool_037FE8E4]	; 037FE892
	ldr r4,[r1,#0x0]	; 037FE894
	mov r1,#0x8	; 037FE896
	and r4,r1	; 037FE898
	cmp r4,#0x0	; 037FE89A
	beq loc_037FE8B6	; 037FE89C
	ldrh r3,[r3,#0x0]	; 037FE89E
	ldr r1,[pool_037FE8E8]	; 037FE8A0
	and r3,r1	; 037FE8A2
	cmp r3,#0x0	; 037FE8A4
	bne loc_037FE8B6	; 037FE8A6
	ldr r3,[sp,#0x4]	; 037FE8A8
	ldr r4,[sp,#0x8]	; 037FE8AA
	mov r1,#0x1	; 037FE8AC
	add r1,r3,r1	; 037FE8AE
	adc r4,r2	; 037FE8B0
	str r1,[sp,#0x4]	; 037FE8B2
	str r4,[sp,#0x8]	; 037FE8B4
loc_037FE8B6:
	bl loc_037FDD0C	; 037FE8B6
	ldr r2,[sp,#0x4]	; 037FE8BA
	ldr r1,[sp,#0x8]	; 037FE8BC
	lsr r0,r2,#0x10	; 037FE8BE
	lsl r1,r1,#0x10	; 037FE8C0
	orr r1,r0	; 037FE8C2
	lsl r0,r2,#0x10	; 037FE8C4
	add r2,sp,#0x0	; 037FE8C6
	ldrh r3,[r2,#0x0]	; 037FE8C8
	asr r2,r3,#0x1f	; 037FE8CA
	orr r1,r2	; 037FE8CC
	orr r0,r3	; 037FE8CE
	add sp,#0xc	; 037FE8D0
	pop {r4,r5}	; 037FE8D2
	pop {r3}	; 037FE8D4
	bx r3	; 037FE8D6
pool_037FE8D8:
loc_037FE8D8:
	.word TIMER0_DATA	; 037FE8D8
pool_037FE8DC:
loc_037FE8DC:
	.word P2_BssStart + 0x64C	; 037FE8DC
pool_037FE8E0:
loc_037FE8E0:
	.word 0x0000FFFF	; 037FE8E0
pool_037FE8E4:
loc_037FE8E4:
	.word REG_IF	; 037FE8E4
pool_037FE8E8:
loc_037FE8E8:
	.word 0x00008000	; 037FE8E8

; ===== function loc_037FE8EC =====
P2_IrqHandler_037FE8EC:
	push {r4,lr}	; 037FE8EC
	ldr r1,[pool_037FE928]	; 037FE8EE
	ldr r2,[r1,#0x0]	; 037FE8F0
	ldr r4,[r1,#0x4]	; 037FE8F2
	mov r3,#0x0	; 037FE8F4
	mov r0,#0x1	; 037FE8F6
	add r0,r2,r0	; 037FE8F8
	adc r4,r3	; 037FE8FA
	str r0,[r1,#0x0]	; 037FE8FC
	str r4,[r1,#0x4]	; 037FE8FE
	ldr r0,[pool_037FE92C]	; 037FE900
	ldr r1,[r0,#0x0]	; 037FE902
	cmp r1,#0x0	; 037FE904
	beq loc_037FE916	; 037FE906
	ldr r2,[pool_037FE930]	; 037FE908
	strh r3,[r2,#0x0]	; 037FE90A
	ldr r1,[pool_037FE934]	; 037FE90C
	strh r3,[r1,#0x0]	; 037FE90E
	mov r1,#0xc1	; 037FE910
	strh r1,[r2,#0x0]	; 037FE912
	str r3,[r0,#0x0]	; 037FE914
loc_037FE916:
	mov r0,#0x0	; 037FE916
	ldr r1,[pool_037FE938]	; 037FE918
	add r2,r0,#0x0	; 037FE91A
	bl loc_037FDAE8	; 037FE91C
	pop {r4}	; 037FE920
	pop {r3}	; 037FE922
	bx r3	; 037FE924
	.byte 0xC0, 0x46	; 037FE928
pool_037FE928:
loc_037FE928:
	.word P2_BssStart + 0x64C	; 037FE928
pool_037FE92C:
loc_037FE92C:
	.word P2_BssStart + 0x648	; 037FE92C
pool_037FE930:
loc_037FE930:
	.word TIMER0_CR	; 037FE930
pool_037FE934:
loc_037FE934:
	.word TIMER0_DATA	; 037FE934
pool_037FE938:
loc_037FE938:
	.word 0x037FE8ED	; 037FE938

; ===== function loc_037FE93C =====
loc_037FE93C:
	ldr r0,[pool_037FE944]	; 037FE93C
	ldrh r0,[r0,#0x0]	; 037FE93E
	bx lr	; 037FE940
	.byte 0xC0, 0x46	; 037FE944
pool_037FE944:
loc_037FE944:
	.word P2_BssStart + 0x644	; 037FE944

; ===== function loc_037FE948 =====
loc_037FE948:
	push {lr}	; 037FE948
	sub sp,#0x4	; 037FE94A
	ldr r0,[pool_037FE98C]	; 037FE94C
	ldrh r1,[r0,#0x0]	; 037FE94E
	cmp r1,#0x0	; 037FE950
	bne loc_037FE986	; 037FE952
	mov r1,#0x1	; 037FE954
	strh r1,[r0,#0x0]	; 037FE956
	mov r0,#0x0	; 037FE958
	bl loc_037FE85C	; 037FE95A
	mov r2,#0x0	; 037FE95E
	ldr r0,[pool_037FE990]	; 037FE960
	str r2,[r0,#0x0]	; 037FE962
	str r2,[r0,#0x4]	; 037FE964
	ldr r1,[pool_037FE994]	; 037FE966
	strh r2,[r1,#0x0]	; 037FE968
	ldr r0,[pool_037FE998]	; 037FE96A
	strh r2,[r0,#0x0]	; 037FE96C
	mov r0,#0xc1	; 037FE96E
	strh r0,[r1,#0x0]	; 037FE970
	mov r0,#0x8	; 037FE972
	ldr r1,[pool_037FE99C]	; 037FE974
	bl loc_037FDB1C	; 037FE976
	mov r0,#0x8	; 037FE97A
	bl loc_037FDA98	; 037FE97C
	mov r1,#0x0	; 037FE980
	ldr r0,[pool_037FE9A0]	; 037FE982
	str r1,[r0,#0x0]	; 037FE984
loc_037FE986:
	add sp,#0x4	; 037FE986
	pop {r3}	; 037FE988
	bx r3	; 037FE98A
pool_037FE98C:
loc_037FE98C:
	.word P2_BssStart + 0x644	; 037FE98C
pool_037FE990:
loc_037FE990:
	.word P2_BssStart + 0x64C	; 037FE990
pool_037FE994:
loc_037FE994:
	.word TIMER0_CR	; 037FE994
pool_037FE998:
loc_037FE998:
	.word TIMER0_DATA	; 037FE998
pool_037FE99C:
loc_037FE99C:
	.word P2_IrqHandler_037FE8EC + 1	; 037FE99C
pool_037FE9A0:
loc_037FE9A0:
	.word P2_BssStart + 0x648	; 037FE9A0
.arm
	stmdb sp!,{lr}	; 037FE9A4
	bl loc_037FE9B4	; 037FE9A8
	ldmia sp!,{lr}	; 037FE9AC
	bx lr	; 037FE9B0

; ===== function loc_037FE9B4 =====
loc_037FE9B4:
	ldr r12,[pool_037FE9BC]	; 037FE9B4
	bx r12	; 037FE9B8
pool_037FE9BC:
loc_037FE9BC:
	.word loc_037FE9C0 + 1	; 037FE9BC
.thumb
loc_037FE9C0:
	push {r4,r5,lr}	; 037FE9C0
	sub sp,#0x4	; 037FE9C2
	mov r1,#0x0	; 037FE9C4
	ldr r0,[pool_037FEA58]	; 037FE9C6
	strh r1,[r0,#0x0]	; 037FE9C8
	mov r0,#0x10	; 037FE9CA
	bl loc_037FDA6C	; 037FE9CC
	ldr r2,[pool_037FEA5C]	; 037FE9D0
	ldr r1,[r2,#0x0]	; 037FE9D2
	mov r0,#0x10	; 037FE9D4
	orr r1,r0	; 037FE9D6
	str r1,[r2,#0x0]	; 037FE9D8
	bl loc_037FE870	; 037FE9DA
	ldr r2,[pool_037FEA60]	; 037FE9DE
	ldr r4,[r2,#0x0]	; 037FE9E0
	cmp r4,#0x0	; 037FE9E2
	beq loc_037FEA4E	; 037FE9E4
	ldr r5,[r4,#0xc]	; 037FE9E6
	ldr r3,[r4,#0x10]	; 037FE9E8
	sub r0,r0,r5	; 037FE9EA
	sbc r1,r3	; 037FE9EC
	bcs loc_037FE9F8	; 037FE9EE
	add r0,r4,#0x0	; 037FE9F0
	bl loc_037FEC80	; 037FE9F2
	b loc_037FEA4E	; 037FE9F6
loc_037FE9F8:
	ldr r1,[r4,#0x18]	; 037FE9F8
	str r1,[r2,#0x0]	; 037FE9FA
	cmp r1,#0x0	; 037FE9FC
	bne loc_037FEA06	; 037FE9FE
	mov r0,#0x0	; 037FEA00
	str r0,[r2,#0x4]	; 037FEA02
	b loc_037FEA0A	; 037FEA04
loc_037FEA06:
	mov r0,#0x0	; 037FEA06
	str r0,[r1,#0x14]	; 037FEA08
loc_037FEA0A:
	ldr r5,[r4,#0x0]	; 037FEA0A
	ldr r2,[r4,#0x1c]	; 037FEA0C
	ldr r1,[r4,#0x20]	; 037FEA0E
	mov r0,#0x0	; 037FEA10
	eor r1,r0	; 037FEA12
	eor r2,r0	; 037FEA14
	orr r1,r2	; 037FEA16
	bne loc_037FEA1E	; 037FEA18
	mov r0,#0x0	; 037FEA1A
	str r0,[r4,#0x0]	; 037FEA1C
loc_037FEA1E:
	cmp r5,#0x0	; 037FEA1E
	beq loc_037FEA28	; 037FEA20
	ldr r0,[r4,#0x4]	; 037FEA22
	bl loc_038050A0	; 037FEA24
loc_037FEA28:
	ldr r2,[r4,#0x1c]	; 037FEA28
	ldr r1,[r4,#0x20]	; 037FEA2A
	mov r0,#0x0	; 037FEA2C
	eor r1,r0	; 037FEA2E
	eor r2,r0	; 037FEA30
	orr r1,r2	; 037FEA32
	beq loc_037FEA42	; 037FEA34
	str r5,[r4,#0x0]	; 037FEA36
	add r0,r4,#0x0	; 037FEA38
	mov r1,#0x0	; 037FEA3A
	add r2,r1,#0x0	; 037FEA3C
	bl loc_037FEB60	; 037FEA3E
loc_037FEA42:
	ldr r0,[pool_037FEA60]	; 037FEA42
	ldr r0,[r0,#0x0]	; 037FEA44
	cmp r0,#0x0	; 037FEA46
	beq loc_037FEA4E	; 037FEA48
	bl loc_037FEC80	; 037FEA4A
loc_037FEA4E:
	add sp,#0x4	; 037FEA4E
	pop {r4,r5}	; 037FEA50
	pop {r3}	; 037FEA52
	bx r3	; 037FEA54
	.byte 0xC0, 0x46	; 037FEA58
pool_037FEA58:
loc_037FEA58:
	.word TIMER1_CR	; 037FEA58
pool_037FEA5C:
loc_037FEA5C:
	.word Bios7IrqFlagsAddress	; 037FEA5C
pool_037FEA60:
loc_037FEA60:
	.word P2_BssStart + 0x658	; 037FEA60

; ===== function loc_037FEA64 =====
loc_037FEA64:
	push {r4,r5,lr}	; 037FEA64
	sub sp,#0x4	; 037FEA66
	add r5,r0,#0x0	; 037FEA68
	bl loc_037FDCE8	; 037FEA6A
	add r4,r0,#0x0	; 037FEA6E
	ldr r1,[r5,#0x0]	; 037FEA70
	cmp r1,#0x0	; 037FEA72
	bne loc_037FEA7C	; 037FEA74
	bl loc_037FDD0C	; 037FEA76
	b loc_037FEAB2	; 037FEA7A
loc_037FEA7C:
	ldr r0,[r5,#0x18]	; 037FEA7C
	cmp r0,#0x0	; 037FEA7E
	bne loc_037FEA8A	; 037FEA80
	ldr r2,[r5,#0x14]	; 037FEA82
	ldr r1,[pool_037FEABC]	; 037FEA84
	str r2,[r1,#0x4]	; 037FEA86
	b loc_037FEA8E	; 037FEA88
loc_037FEA8A:
	ldr r1,[r5,#0x14]	; 037FEA8A
	str r1,[r0,#0x14]	; 037FEA8C
loc_037FEA8E:
	ldr r1,[r5,#0x14]	; 037FEA8E
	cmp r1,#0x0	; 037FEA90
	beq loc_037FEA98	; 037FEA92
	str r0,[r1,#0x18]	; 037FEA94
	b loc_037FEAA4	; 037FEA96
loc_037FEA98:
	ldr r1,[pool_037FEABC]	; 037FEA98
	str r0,[r1,#0x0]	; 037FEA9A
	cmp r0,#0x0	; 037FEA9C
	beq loc_037FEAA4	; 037FEA9E
	bl loc_037FEC80	; 037FEAA0
loc_037FEAA4:
	mov r0,#0x0	; 037FEAA4
	str r0,[r5,#0x0]	; 037FEAA6
	str r0,[r5,#0x1c]	; 037FEAA8
	str r0,[r5,#0x20]	; 037FEAAA
	add r0,r4,#0x0	; 037FEAAC
	bl loc_037FDD0C	; 037FEAAE
loc_037FEAB2:
	add sp,#0x4	; 037FEAB2
	pop {r4,r5}	; 037FEAB4
	pop {r3}	; 037FEAB6
	bx r3	; 037FEAB8
	.byte 0xC0, 0x46	; 037FEABC
pool_037FEABC:
loc_037FEABC:
	.word P2_BssStart + 0x658	; 037FEABC

; ===== function loc_037FEAC0 =====
loc_037FEAC0:
	push {r4,r5,r6,lr}	; 037FEAC0
	sub sp,#0x10	; 037FEAC2
	add r5,r0,#0x0	; 037FEAC4
	add r4,r1,#0x0	; 037FEAC6
	add r6,r2,#0x0	; 037FEAC8
	str r3,[sp,#0x0]	; 037FEACA
	ldr r0,[sp,#0x20]	; 037FEACC
	str r0,[sp,#0x4]	; 037FEACE
	cmp r5,#0x0	; 037FEAD0
	beq loc_037FEADA	; 037FEAD2
	ldr r0,[r5,#0x0]	; 037FEAD4
	cmp r0,#0x0	; 037FEAD6
	beq loc_037FEADE	; 037FEAD8
loc_037FEADA:
	bl loc_037FF1DC	; 037FEADA
loc_037FEADE:
	bl loc_037FDCE8	; 037FEADE
	str r0,[sp,#0x8]	; 037FEAE2
	ldr r0,[sp,#0x0]	; 037FEAE4
	str r0,[r5,#0x1c]	; 037FEAE6
	ldr r0,[sp,#0x4]	; 037FEAE8
	str r0,[r5,#0x20]	; 037FEAEA
	str r4,[r5,#0x24]	; 037FEAEC
	str r6,[r5,#0x28]	; 037FEAEE
	ldr r0,[sp,#0x24]	; 037FEAF0
	str r0,[r5,#0x0]	; 037FEAF2
	ldr r0,[sp,#0x28]	; 037FEAF4
	str r0,[r5,#0x4]	; 037FEAF6
	add r0,r5,#0x0	; 037FEAF8
	mov r1,#0x0	; 037FEAFA
	add r2,r1,#0x0	; 037FEAFC
	bl loc_037FEB60	; 037FEAFE
	ldr r0,[sp,#0x8]	; 037FEB02
	bl loc_037FDD0C	; 037FEB04
	add sp,#0x10	; 037FEB08
	pop {r4,r5,r6}	; 037FEB0A
	pop {r3}	; 037FEB0C
	bx r3	; 037FEB0E

; ===== function loc_037FEB10 =====
loc_037FEB10:
	push {r4,r5,r6,r7,lr}	; 037FEB10
	sub sp,#0x4	; 037FEB12
	add r5,r0,#0x0	; 037FEB14
	add r6,r1,#0x0	; 037FEB16
	add r4,r2,#0x0	; 037FEB18
	add r7,r3,#0x0	; 037FEB1A
	cmp r5,#0x0	; 037FEB1C
	beq loc_037FEB26	; 037FEB1E
	ldr r0,[r5,#0x0]	; 037FEB20
	cmp r0,#0x0	; 037FEB22
	beq loc_037FEB2A	; 037FEB24
loc_037FEB26:
	bl loc_037FF1DC	; 037FEB26
loc_037FEB2A:
	bl loc_037FDCE8	; 037FEB2A
	str r0,[sp,#0x0]	; 037FEB2E
	mov r0,#0x0	; 037FEB30
	str r0,[r5,#0x1c]	; 037FEB32
	str r0,[r5,#0x20]	; 037FEB34
	str r7,[r5,#0x0]	; 037FEB36
	ldr r0,[sp,#0x18]	; 037FEB38
	str r0,[r5,#0x4]	; 037FEB3A
	bl loc_037FE870	; 037FEB3C
	add r2,r0,#0x0	; 037FEB40
	add r0,r5,#0x0	; 037FEB42
	add r2,r6,r2	; 037FEB44
	adc r4,r1	; 037FEB46
	add r1,r2,#0x0	; 037FEB48
	add r2,r4,#0x0	; 037FEB4A
	bl loc_037FEB60	; 037FEB4C
	ldr r0,[sp,#0x0]	; 037FEB50
	bl loc_037FDD0C	; 037FEB52
	add sp,#0x4	; 037FEB56
	pop {r4,r5,r6,r7}	; 037FEB58
	pop {r3}	; 037FEB5A
	bx r3	; 037FEB5C
	.byte 0x00, 0x00	; 037FEB60

; ===== function loc_037FEB60 =====
loc_037FEB60:
	push {r4,r5,r6,r7,lr}	; 037FEB60
	sub sp,#0xc	; 037FEB62
	add r5,r0,#0x0	; 037FEB64
	add r4,r1,#0x0	; 037FEB66
	add r6,r2,#0x0	; 037FEB68
	ldr r2,[r5,#0x1c]	; 037FEB6A
	ldr r1,[r5,#0x20]	; 037FEB6C
	mov r0,#0x0	; 037FEB6E
	eor r1,r0	; 037FEB70
	eor r2,r0	; 037FEB72
	orr r1,r2	; 037FEB74
	beq loc_037FEBBA	; 037FEB76
	bl loc_037FE870	; 037FEB78
	ldr r4,[r5,#0x24]	; 037FEB7C
	ldr r6,[r5,#0x28]	; 037FEB7E
	sub r2,r4,r0	; 037FEB80
	lsl r2,r6,#0	; 037FEB82
	sbc r2,r1	; 037FEB84
	bcs loc_037FEBBA	; 037FEB86
	ldr r2,[r5,#0x1c]	; 037FEB88
	str r2,[sp,#0x0]	; 037FEB8A
	ldr r2,[r5,#0x20]	; 037FEB8C
	str r2,[sp,#0x4]	; 037FEB8E
	sub r0,r0,r4	; 037FEB90
	sbc r1,r6	; 037FEB92
	ldr r2,[sp,#0x0]	; 037FEB94
	ldr r3,[sp,#0x4]	; 037FEB96
	bl loc_037FEC24	; 037FEB98
	str r0,[sp,#0x8]	; 037FEB9C
	add r7,r1,#0x0	; 037FEB9E
	ldr r0,[sp,#0x0]	; 037FEBA0
	ldr r1,[sp,#0x4]	; 037FEBA2
	mov r3,#0x1	; 037FEBA4
	ldr r2,[sp,#0x8]	; 037FEBA6
	add r3,r2,r3	; 037FEBA8
	mov r2,#0x0	; 037FEBAA
	adc r7,r2	; 037FEBAC
	add r2,r3,#0x0	; 037FEBAE
	add r3,r7,#0x0	; 037FEBB0
	bl loc_037FEC30	; 037FEBB2
	add r4,r4,r0	; 037FEBB6
	adc r6,r1	; 037FEBB8
loc_037FEBBA:
	str r4,[r5,#0xc]	; 037FEBBA
	str r6,[r5,#0x10]	; 037FEBBC
	ldr r0,[pool_037FEC20]	; 037FEBBE
	ldr r3,[r0,#0x0]	; 037FEBC0
	b loc_037FEBF6	; 037FEBC2
loc_037FEBC4:
	ldr r1,[r3,#0xc]	; 037FEBC4
	ldr r0,[r3,#0x10]	; 037FEBC6
	sub r2,r4,r1	; 037FEBC8
	lsl r1,r6,#0	; 037FEBCA
	sbc r1,r0	; 037FEBCC
	mov r0,#0x0	; 037FEBCE
	sub r2,r2,r0	; 037FEBD0
	sbc r1,r0	; 037FEBD2
	bge loc_037FEBF4	; 037FEBD4
	ldr r0,[r3,#0x14]	; 037FEBD6
	str r0,[r5,#0x14]	; 037FEBD8
	str r5,[r3,#0x14]	; 037FEBDA
	str r3,[r5,#0x18]	; 037FEBDC
	ldr r0,[r5,#0x14]	; 037FEBDE
	cmp r0,#0x0	; 037FEBE0
	beq loc_037FEBE8	; 037FEBE2
	str r5,[r0,#0x18]	; 037FEBE4
	b loc_037FEC18	; 037FEBE6
loc_037FEBE8:
	ldr r0,[pool_037FEC20]	; 037FEBE8
	str r5,[r0,#0x0]	; 037FEBEA
	add r0,r5,#0x0	; 037FEBEC
	bl loc_037FEC80	; 037FEBEE
	b loc_037FEC18	; 037FEBF2
loc_037FEBF4:
	ldr r3,[r3,#0x18]	; 037FEBF4
loc_037FEBF6:
	cmp r3,#0x0	; 037FEBF6
	bne loc_037FEBC4	; 037FEBF8
	mov r0,#0x0	; 037FEBFA
	str r0,[r5,#0x18]	; 037FEBFC
	ldr r0,[pool_037FEC20]	; 037FEBFE
	ldr r1,[r0,#0x4]	; 037FEC00
	str r5,[r0,#0x4]	; 037FEC02
	str r1,[r5,#0x14]	; 037FEC04
	cmp r1,#0x0	; 037FEC06
	beq loc_037FEC0E	; 037FEC08
	str r5,[r1,#0x18]	; 037FEC0A
	b loc_037FEC18	; 037FEC0C
loc_037FEC0E:
	str r5,[r0,#0x4]	; 037FEC0E
	str r5,[r0,#0x0]	; 037FEC10
	add r0,r5,#0x0	; 037FEC12
	bl loc_037FEC80	; 037FEC14
loc_037FEC18:
	add sp,#0xc	; 037FEC18
	pop {r4,r5,r6,r7}	; 037FEC1A
	pop {r3}	; 037FEC1C
	bx r3	; 037FEC1E
pool_037FEC20:
loc_037FEC20:
	.word P2_BssStart + 0x658	; 037FEC20

; ===== function loc_037FEC24 =====
loc_037FEC24:
	bx pc	; 037FEC24
	.byte 0xC0, 0x46	; 037FEC28
.arm

; ===== function loc_037FEC28 =====
loc_037FEC28:
	ldr pc,[pool_037FEC2C]	; 037FEC28
pool_037FEC2C:
loc_037FEC2C:
	.word loc_03804954	; 037FEC2C
.thumb

; ===== function loc_037FEC30 =====
loc_037FEC30:
	bx pc	; 037FEC30
	.byte 0xC0, 0x46	; 037FEC34
.arm

; ===== function loc_037FEC34 =====
loc_037FEC34:
	ldr pc,[pool_037FEC38]	; 037FEC34
pool_037FEC38:
loc_037FEC38:
	.word loc_03804B5C	; 037FEC38
.thumb

; ===== function loc_037FEC3C =====
loc_037FEC3C:
	mov r1,#0x0	; 037FEC3C
	str r1,[r0,#0x0]	; 037FEC3E
	str r1,[r0,#0x8]	; 037FEC40
	bx lr	; 037FEC42

; ===== function loc_037FEC44 =====
loc_037FEC44:
	ldr r0,[pool_037FEC4C]	; 037FEC44
	ldrh r0,[r0,#0x0]	; 037FEC46
	bx lr	; 037FEC48
	.byte 0xC0, 0x46	; 037FEC4C
pool_037FEC4C:
loc_037FEC4C:
	.word P2_BssStart + 0x654	; 037FEC4C

; ===== function loc_037FEC50 =====
loc_037FEC50:
	push {lr}	; 037FEC50
	sub sp,#0x4	; 037FEC52
	ldr r1,[pool_037FEC78]	; 037FEC54
	ldrh r0,[r1,#0x0]	; 037FEC56
	cmp r0,#0x0	; 037FEC58
	bne loc_037FEC72	; 037FEC5A
	mov r0,#0x1	; 037FEC5C
	strh r0,[r1,#0x0]	; 037FEC5E
	bl loc_037FE85C	; 037FEC60
	mov r1,#0x0	; 037FEC64
	ldr r0,[pool_037FEC7C]	; 037FEC66
	str r1,[r0,#0x0]	; 037FEC68
	str r1,[r0,#0x4]	; 037FEC6A
	mov r0,#0x10	; 037FEC6C
	bl loc_037FDA6C	; 037FEC6E
loc_037FEC72:
	add sp,#0x4	; 037FEC72
	pop {r3}	; 037FEC74
	bx r3	; 037FEC76
pool_037FEC78:
loc_037FEC78:
	.word P2_BssStart + 0x654	; 037FEC78
pool_037FEC7C:
loc_037FEC7C:
	.word P2_BssStart + 0x658	; 037FEC7C

; ===== function loc_037FEC80 =====
loc_037FEC80:
	push {r4,r5,lr}	; 037FEC80
	sub sp,#0x4	; 037FEC82
	add r4,r0,#0x0	; 037FEC84
	bl loc_037FE870	; 037FEC86
	mov r2,#0x0	; 037FEC8A
	ldr r3,[pool_037FECD8]	; 037FEC8C
	strh r2,[r3,#0x0]	; 037FEC8E
	ldr r3,[r4,#0xc]	; 037FEC90
	ldr r4,[r4,#0x10]	; 037FEC92
	sub r5,r3,r0	; 037FEC94
	sbc r4,r1	; 037FEC96
	mov r0,#0x1	; 037FEC98
	ldr r1,[pool_037FECDC]	; 037FEC9A
	bl loc_037FDAE8	; 037FEC9C
	mov r1,#0x0	; 037FECA0
	sub r0,r5,r1	; 037FECA2
	lsl r0,r4,#0	; 037FECA4
	sbc r0,r1	; 037FECA6
	bge loc_037FECAE	; 037FECA8
	ldr r1,[pool_037FECE0]	; 037FECAA
	b loc_037FECC0	; 037FECAC
loc_037FECAE:
	ldr r0,[pool_037FECE4]	; 037FECAE
	sub r0,r5,r0	; 037FECB0
	sbc r4,r1	; 037FECB2
	bge loc_037FECBE	; 037FECB4
	mvn r0,r5	; 037FECB6
	lsl r0,r0,#0x10	; 037FECB8
	lsr r1,r0,#0x10	; 037FECBA
	b loc_037FECC0	; 037FECBC
loc_037FECBE:
	mov r1,#0x0	; 037FECBE
loc_037FECC0:
	ldr r0,[pool_037FECE8]	; 037FECC0
	strh r1,[r0,#0x0]	; 037FECC2
	mov r1,#0xc1	; 037FECC4
	ldr r0,[pool_037FECD8]	; 037FECC6
	strh r1,[r0,#0x0]	; 037FECC8
	mov r0,#0x10	; 037FECCA
	bl loc_037FDA98	; 037FECCC
	add sp,#0x4	; 037FECD0
	pop {r4,r5}	; 037FECD2
	pop {r3}	; 037FECD4
	bx r3	; 037FECD6
pool_037FECD8:
loc_037FECD8:
	.word TIMER1_CR	; 037FECD8
pool_037FECDC:
loc_037FECDC:
	.word 0x037FE9A4	; 037FECDC
pool_037FECE0:
loc_037FECE0:
	.word 0x0000FFFE	; 037FECE0
pool_037FECE4:
loc_037FECE4:
	.word 0x00010000	; 037FECE4
pool_037FECE8:
loc_037FECE8:
	.word TIMER1_DATA	; 037FECE8

; ===== function loc_037FECEC =====
P2_Entry_037FECEC:
	push {r4,lr}	; 037FECEC
	add r4,r0,#0x0	; 037FECEE
	bl loc_037FDCE8	; 037FECF0
	ldr r1,[pool_037FED18]	; 037FECF4
	ldr r1,[r1,#0x0]	; 037FECF6
	cmp r4,r1	; 037FECF8
	bcs loc_037FED04	; 037FECFA
	ldr r1,[pool_037FED1C]	; 037FECFC
	ldr r2,[r1,#0x0]	; 037FECFE
	add r2,r2,#0x1	; 037FED00
	str r2,[r1,#0x0]	; 037FED02
loc_037FED04:
	ldr r1,[pool_037FED18]	; 037FED04
	str r4,[r1,#0x0]	; 037FED06
	bl loc_037FDD0C	; 037FED08
	ldr r0,[pool_037FED1C]	; 037FED0C
	ldr r0,[r0,#0x0]	; 037FED0E
	pop {r4}	; 037FED10
	pop {r3}	; 037FED12
	bx r3	; 037FED14
	.byte 0xC0, 0x46	; 037FED18
pool_037FED18:
loc_037FED18:
	.word P2_BssStart + 0x664	; 037FED18
pool_037FED1C:
loc_037FED1C:
	.word P2_BssStart + 0x668	; 037FED1C
P2_Entry_037FED20:
	ldr r3,[r0,#0xc]	; 037FED20
	sub r3,r1,r3	; 037FED22
	mov r1,#0x10	; 037FED24
	ldrsh r1,[r0,r1]	; 037FED26
	sub r2,r2,r1	; 037FED28
	cmp r3,#0x0	; 037FED2A
	blt P2_Entry_037FED36	; 037FED2C
	cmp r3,#0x0	; 037FED2E
	bne P2_Entry_037FED3A	; 037FED30
	cmp r2,#0x0	; 037FED32
	bge P2_Entry_037FED3A	; 037FED34
P2_Entry_037FED36:
	mov r0,#0x0	; 037FED36
	bx lr	; 037FED38
P2_Entry_037FED3A:
	cmp r2,#0x0	; 037FED3A
	bge P2_Entry_037FED42	; 037FED3C
	ldr r1,[pool_037FED54]	; 037FED3E
	add r2,r2,r1	; 037FED40
P2_Entry_037FED42:
	mov r1,#0x12	; 037FED42
	ldrsh r0,[r0,r1]	; 037FED44
	cmp r2,r0	; 037FED46
	bgt P2_Entry_037FED4E	; 037FED48
	mov r0,#0x1	; 037FED4A
	bx lr	; 037FED4C
P2_Entry_037FED4E:
	mov r0,#0x2	; 037FED4E
	bx lr	; 037FED50
	.byte 0xC0, 0x46	; 037FED52
pool_037FED54:
	.word 0x00000107	; 037FED54
P2_IrqHandler_037FED58:
	push {r4,r5,r6,r7,lr}	; 037FED58
	sub sp,#0x4	; 037FED5A
	mov r0,#0x4	; 037FED5C
	bl loc_037FDA6C	; 037FED5E
	ldr r3,[pool_037FEE38]	; 037FED62
	ldrh r1,[r3,#0x0]	; 037FED64
	mov r0,#0x20	; 037FED66
	bic r1,r0	; 037FED68
	strh r1,[r3,#0x0]	; 037FED6A
	ldr r2,[pool_037FEE3C]	; 037FED6C
	ldr r1,[r2,#0x0]	; 037FED6E
	mov r0,#0x4	; 037FED70
	orr r1,r0	; 037FED72
	str r1,[r2,#0x0]	; 037FED74
	ldrh r1,[r3,#0x0]	; 037FED76
	asr r2,r1,#0x8	; 037FED78
	mov r0,#0xff	; 037FED7A
	and r2,r0	; 037FED7C
	lsl r1,r1,#0x1	; 037FED7E
	ldr r0,[pool_037FEE40]	; 037FED80
	and r1,r0	; 037FED82
	orr r2,r1	; 037FED84
	sub r0,r2,#0x1	; 037FED86
	bl P2_Entry_037FECEC	; 037FED88
	ldr r7,[pool_037FEE44]	; 037FED8C
	b P2_Entry_037FEE28	; 037FED8E
P2_Entry_037FED90:
	ldrh r4,[r7,#0x0]	; 037FED90
	add r0,r4,#0x0	; 037FED92
	bl P2_Entry_037FECEC	; 037FED94
	add r6,r0,#0x0	; 037FED98
	add r0,r5,#0x0	; 037FED9A
	add r1,r6,#0x0	; 037FED9C
	add r2,r4,#0x0	; 037FED9E
	bl P2_Entry_037FED20	; 037FEDA0
	cmp r0,#0x0	; 037FEDA4
	beq P2_Entry_037FEDB2	; 037FEDA6
	cmp r0,#0x1	; 037FEDA8
	beq P2_Entry_037FEDE0	; 037FEDAA
	cmp r0,#0x2	; 037FEDAC
	beq P2_Entry_037FEE14	; 037FEDAE
	b P2_Entry_037FEE28	; 037FEDB0
P2_Entry_037FEDB2:
	add r0,r5,#0x0	; 037FEDB2
	bl P2_Entry_037FEEF8	; 037FEDB4
	ldrh r1,[r7,#0x0]	; 037FEDB8
	mov r0,#0x10	; 037FEDBA
	ldrsh r0,[r5,r0]	; 037FEDBC
	cmp r0,r1	; 037FEDBE
	bne P2_Entry_037FEE30	; 037FEDC0
	ldr r0,[r5,#0xc]	; 037FEDC2
	cmp r0,r6	; 037FEDC4
	bne P2_Entry_037FEE30	; 037FEDC6
	mov r0,#0x4	; 037FEDC8
	bl loc_037FDA6C	; 037FEDCA
	ldr r0,[pool_037FEE38]	; 037FEDCE
	ldrh r1,[r0,#0x0]	; 037FEDD0
	mov r0,#0x20	; 037FEDD2
	bic r1,r0	; 037FEDD4
	ldr r0,[pool_037FEE38]	; 037FEDD6
	strh r1,[r0,#0x0]	; 037FEDD8
	mov r0,#0x4	; 037FEDDA
	bl loc_037FDA48	; 037FEDDC
P2_Entry_037FEDE0:
	ldr r4,[r5,#0x0]	; 037FEDE0
	add r0,r5,#0x0	; 037FEDE2
	bl P2_Entry_037FF010	; 037FEDE4
	mov r0,#0x0	; 037FEDE8
	str r0,[r5,#0x0]	; 037FEDEA
	cmp r4,#0x0	; 037FEDEC
	beq P2_Entry_037FEDF6	; 037FEDEE
	ldr r0,[r5,#0x4]	; 037FEDF0
	bl loc_0380509C	; 037FEDF2
P2_Entry_037FEDF6:
	ldr r0,[r5,#0x1c]	; 037FEDF6
	cmp r0,#0x0	; 037FEDF8
	beq P2_Entry_037FEE28	; 037FEDFA
	ldr r0,[r5,#0x24]	; 037FEDFC
	cmp r0,#0x0	; 037FEDFE
	bne P2_Entry_037FEE28	; 037FEE00
	str r4,[r5,#0x0]	; 037FEE02
	ldr r0,[pool_037FEE48]	; 037FEE04
	ldr r0,[r0,#0x0]	; 037FEE06
	add r0,r0,#0x1	; 037FEE08
	str r0,[r5,#0xc]	; 037FEE0A
	add r0,r5,#0x0	; 037FEE0C
	bl P2_Entry_037FF038	; 037FEE0E
	b P2_Entry_037FEE28	; 037FEE12
P2_Entry_037FEE14:
	add r0,r5,#0x0	; 037FEE14
	bl P2_Entry_037FF010	; 037FEE16
	add r0,r5,#0x0	; 037FEE1A
	bl P2_Entry_037FF038	; 037FEE1C
	ldr r0,[pool_037FEE48]	; 037FEE20
	ldr r0,[r0,#0x0]	; 037FEE22
	add r0,r0,#0x1	; 037FEE24
	str r0,[r5,#0xc]	; 037FEE26
P2_Entry_037FEE28:
	ldr r0,[pool_037FEE4C]	; 037FEE28
	ldr r5,[r0,#0x0]	; 037FEE2A
	cmp r5,#0x0	; 037FEE2C
	bne P2_Entry_037FED90	; 037FEE2E
P2_Entry_037FEE30:
	add sp,#0x4	; 037FEE30
	pop {r4,r5,r6,r7}	; 037FEE32
	pop {r3}	; 037FEE34
	bx r3	; 037FEE36
pool_037FEE38:
	.word REG_DISPSTAT	; 037FEE38
pool_037FEE3C:
	.word Bios7IrqFlagsAddress	; 037FEE3C
pool_037FEE40:
	.word 0x00000100	; 037FEE40
pool_037FEE44:
	.word 0x04000006	; 037FEE44
pool_037FEE48:
	.word P2_BssStart + 0x668	; 037FEE48
pool_037FEE4C:
	.word P2_BssStart + 0x66C	; 037FEE4C
P2_Entry_037FEE50:
	push {r4,r5,r6,r7,lr}	; 037FEE50
	sub sp,#0x4	; 037FEE52
	add r5,r0,#0x0	; 037FEE54
	bl loc_037FDCE8	; 037FEE56
	add r6,r0,#0x0	; 037FEE5A
	cmp r5,#0x0	; 037FEE5C
	bne P2_Entry_037FEE64	; 037FEE5E
	bl loc_037FF1DC	; 037FEE60
P2_Entry_037FEE64:
	ldr r0,[pool_037FEEA0]	; 037FEE64
	ldr r0,[r0,#0x0]	; 037FEE66
	cmp r0,#0x0	; 037FEE68
	beq P2_Entry_037FEE70	; 037FEE6A
	ldr r4,[r0,#0x18]	; 037FEE6C
	b P2_Entry_037FEE72	; 037FEE6E
P2_Entry_037FEE70:
	mov r4,#0x0	; 037FEE70
P2_Entry_037FEE72:
	mov r7,#0x0	; 037FEE72
	b P2_Entry_037FEE8C	; 037FEE74
P2_Entry_037FEE76:
	ldr r1,[r0,#0x8]	; 037FEE76
	cmp r1,r5	; 037FEE78
	bne P2_Entry_037FEE80	; 037FEE7A
	bl P2_Entry_037FEEA4	; 037FEE7C
P2_Entry_037FEE80:
	add r0,r4,#0x0	; 037FEE80
	cmp r4,#0x0	; 037FEE82
	beq P2_Entry_037FEE8A	; 037FEE84
	ldr r4,[r4,#0x18]	; 037FEE86
	b P2_Entry_037FEE8C	; 037FEE88
P2_Entry_037FEE8A:
	add r4,r7,#0x0	; 037FEE8A
P2_Entry_037FEE8C:
	cmp r0,#0x0	; 037FEE8C
	bne P2_Entry_037FEE76	; 037FEE8E
	add r0,r6,#0x0	; 037FEE90
	bl loc_037FDD0C	; 037FEE92
	add sp,#0x4	; 037FEE96
	pop {r4,r5,r6,r7}	; 037FEE98
	pop {r3}	; 037FEE9A
	bx r3	; 037FEE9C
	.byte 0xC0, 0x46	; 037FEE9E
pool_037FEEA0:
	.word P2_BssStart + 0x66C	; 037FEEA0
P2_Entry_037FEEA4:
	push {r4,r5,lr}	; 037FEEA4
	sub sp,#0x4	; 037FEEA6
	add r5,r0,#0x0	; 037FEEA8
	bl loc_037FDCE8	; 037FEEAA
	add r4,r0,#0x0	; 037FEEAE
	mov r1,#0x1	; 037FEEB0
	str r1,[r5,#0x24]	; 037FEEB2
	ldr r1,[r5,#0x0]	; 037FEEB4
	cmp r1,#0x0	; 037FEEB6
	bne P2_Entry_037FEEC0	; 037FEEB8
	bl loc_037FDD0C	; 037FEEBA
	b P2_Entry_037FEED0	; 037FEEBE
P2_Entry_037FEEC0:
	add r0,r5,#0x0	; 037FEEC0
	bl P2_Entry_037FF010	; 037FEEC2
	mov r0,#0x0	; 037FEEC6
	str r0,[r5,#0x0]	; 037FEEC8
	add r0,r4,#0x0	; 037FEECA
	bl loc_037FDD0C	; 037FEECC
P2_Entry_037FEED0:
	add sp,#0x4	; 037FEED0
	pop {r4,r5}	; 037FEED2
	pop {r3}	; 037FEED4
	bx r3	; 037FEED6

; ===== function loc_037FEED8 =====
loc_037FEED8:
	push {r4,r5,lr}	; 037FEED8
	sub sp,#0x4	; 037FEEDA
	add r5,r0,#0x0	; 037FEEDC
	add r4,r1,#0x0	; 037FEEDE
	cmp r4,#0x0	; 037FEEE0
	bne loc_037FEEE8	; 037FEEE2
	bl loc_037FF1DC	; 037FEEE4
loc_037FEEE8:
	cmp r5,#0x0	; 037FEEE8
	beq loc_037FEEEE	; 037FEEEA
	str r4,[r5,#0x8]	; 037FEEEC
loc_037FEEEE:
	add sp,#0x4	; 037FEEEE
	pop {r4,r5}	; 037FEEF0
	pop {r3}	; 037FEEF2
	bx r3	; 037FEEF4
	.byte 0x00, 0x00	; 037FEEF6
P2_Entry_037FEEF8:
	push {r4,lr}	; 037FEEF8
	add r4,r0,#0x0	; 037FEEFA
	mov r0,#0x4	; 037FEEFC
	ldr r1,[pool_037FEF38]	; 037FEEFE
	bl loc_037FDB1C	; 037FEF00
	mov r0,#0x10	; 037FEF04
	ldrsh r0,[r4,r0]	; 037FEF06
	ldr r1,[pool_037FEF3C]	; 037FEF08
	add r2,r0,#0x0	; 037FEF0A
	and r2,r1	; 037FEF0C
	asr r4,r2,#0x1	; 037FEF0E
	ldr r2,[pool_037FEF40]	; 037FEF10
	ldrh r3,[r2,#0x0]	; 037FEF12
	mov r1,#0x3f	; 037FEF14
	and r3,r1	; 037FEF16
	mov r1,#0xff	; 037FEF18
	and r0,r1	; 037FEF1A
	lsl r0,r0,#0x8	; 037FEF1C
	orr r3,r0	; 037FEF1E
	orr r4,r3	; 037FEF20
	strh r4,[r2,#0x0]	; 037FEF22
	ldrh r1,[r2,#0x0]	; 037FEF24
	mov r0,#0x20	; 037FEF26
	orr r1,r0	; 037FEF28
	strh r1,[r2,#0x0]	; 037FEF2A
	mov r0,#0x4	; 037FEF2C
	bl loc_037FDA98	; 037FEF2E
	pop {r4}	; 037FEF32
	pop {r3}	; 037FEF34
	bx r3	; 037FEF36
pool_037FEF38:
	.word P2_IrqHandler_037FED58 + 1	; 037FEF38
pool_037FEF3C:
	.word 0x00000100	; 037FEF3C
pool_037FEF40:
	.word REG_DISPSTAT	; 037FEF40
P2_Entry_037FEF44:
	push {r4,r5,r6,r7,lr}	; 037FEF44
	sub sp,#0xc	; 037FEF46
	add r5,r0,#0x0	; 037FEF48
	add r4,r1,#0x0	; 037FEF4A
	add r6,r2,#0x0	; 037FEF4C
	add r7,r3,#0x0	; 037FEF4E
	bl loc_037FDCE8	; 037FEF50
	str r0,[sp,#0x0]	; 037FEF54
	cmp r5,#0x0	; 037FEF56
	beq P2_Entry_037FEF60	; 037FEF58
	ldr r0,[r5,#0x0]	; 037FEF5A
	cmp r0,#0x0	; 037FEF5C
	beq P2_Entry_037FEF64	; 037FEF5E
P2_Entry_037FEF60:
	bl loc_037FF1DC	; 037FEF60
P2_Entry_037FEF64:
	ldr r0,[pool_037FEFA0]	; 037FEF64
	ldrh r0,[r0,#0x0]	; 037FEF66
	str r0,[sp,#0x4]	; 037FEF68
	bl P2_Entry_037FECEC	; 037FEF6A
	mov r1,#0x1	; 037FEF6E
	str r1,[r5,#0x1c]	; 037FEF70
	strh r4,[r5,#0x10]	; 037FEF72
	ldr r1,[sp,#0x4]	; 037FEF74
	cmp r4,r1	; 037FEF76
	bgt P2_Entry_037FEF7C	; 037FEF78
	add r0,r0,#0x1	; 037FEF7A
P2_Entry_037FEF7C:
	str r0,[r5,#0xc]	; 037FEF7C
	strh r6,[r5,#0x12]	; 037FEF7E
	str r7,[r5,#0x0]	; 037FEF80
	ldr r0,[sp,#0x20]	; 037FEF82
	str r0,[r5,#0x4]	; 037FEF84
	mov r0,#0x0	; 037FEF86
	str r0,[r5,#0x24]	; 037FEF88
	add r0,r5,#0x0	; 037FEF8A
	bl P2_Entry_037FF060	; 037FEF8C
	ldr r0,[sp,#0x0]	; 037FEF90
	bl loc_037FDD0C	; 037FEF92
	add sp,#0xc	; 037FEF96
	pop {r4,r5,r6,r7}	; 037FEF98
	pop {r3}	; 037FEF9A
	bx r3	; 037FEF9C
	.byte 0xC0, 0x46	; 037FEF9E
pool_037FEFA0:
	.word REG_VCOUNT	; 037FEFA0
P2_Entry_037FEFA4:
	push {r4,r5,r6,r7,lr}	; 037FEFA4
	sub sp,#0xc	; 037FEFA6
	add r5,r0,#0x0	; 037FEFA8
	add r4,r1,#0x0	; 037FEFAA
	add r6,r2,#0x0	; 037FEFAC
	add r7,r3,#0x0	; 037FEFAE
	bl loc_037FDCE8	; 037FEFB0
	str r0,[sp,#0x0]	; 037FEFB4
	cmp r5,#0x0	; 037FEFB6
	beq P2_Entry_037FEFC0	; 037FEFB8
	ldr r0,[r5,#0x0]	; 037FEFBA
	cmp r0,#0x0	; 037FEFBC
	beq P2_Entry_037FEFC4	; 037FEFBE
P2_Entry_037FEFC0:
	bl loc_037FF1DC	; 037FEFC0
P2_Entry_037FEFC4:
	ldr r0,[pool_037FF000]	; 037FEFC4
	ldrh r0,[r0,#0x0]	; 037FEFC6
	str r0,[sp,#0x4]	; 037FEFC8
	bl P2_Entry_037FECEC	; 037FEFCA
	mov r1,#0x0	; 037FEFCE
	str r1,[r5,#0x1c]	; 037FEFD0
	strh r4,[r5,#0x10]	; 037FEFD2
	ldr r1,[sp,#0x4]	; 037FEFD4
	cmp r4,r1	; 037FEFD6
	bgt P2_Entry_037FEFDC	; 037FEFD8
	add r0,r0,#0x1	; 037FEFDA
P2_Entry_037FEFDC:
	str r0,[r5,#0xc]	; 037FEFDC
	strh r6,[r5,#0x12]	; 037FEFDE
	str r7,[r5,#0x0]	; 037FEFE0
	ldr r0,[sp,#0x20]	; 037FEFE2
	str r0,[r5,#0x4]	; 037FEFE4
	mov r0,#0x0	; 037FEFE6
	str r0,[r5,#0x24]	; 037FEFE8
	add r0,r5,#0x0	; 037FEFEA
	bl P2_Entry_037FF060	; 037FEFEC
	ldr r0,[sp,#0x0]	; 037FEFF0
	bl loc_037FDD0C	; 037FEFF2
	add sp,#0xc	; 037FEFF6
	pop {r4,r5,r6,r7}	; 037FEFF8
	pop {r3}	; 037FEFFA
	bx r3	; 037FEFFC
	.byte 0xC0, 0x46	; 037FEFFE
pool_037FF000:
	.word REG_VCOUNT	; 037FF000

; ===== function loc_037FF004 =====
loc_037FF004:
	mov r1,#0x0	; 037FF004
	str r1,[r0,#0x0]	; 037FF006
	str r1,[r0,#0x8]	; 037FF008
	str r1,[r0,#0x20]	; 037FF00A
	bx lr	; 037FF00C
	.byte 0x00, 0x00	; 037FF00E
P2_Entry_037FF010:
	cmp r0,#0x0	; 037FF010
	beq P2_Entry_037FF030	; 037FF012
	ldr r2,[r0,#0x14]	; 037FF014
	ldr r1,[r0,#0x18]	; 037FF016
	cmp r1,#0x0	; 037FF018
	beq P2_Entry_037FF020	; 037FF01A
	str r2,[r1,#0x14]	; 037FF01C
	b P2_Entry_037FF024	; 037FF01E
P2_Entry_037FF020:
	ldr r0,[pool_037FF034]	; 037FF020
	str r2,[r0,#0x4]	; 037FF022
P2_Entry_037FF024:
	cmp r2,#0x0	; 037FF024
	beq P2_Entry_037FF02C	; 037FF026
	str r1,[r2,#0x18]	; 037FF028
	bx lr	; 037FF02A
P2_Entry_037FF02C:
	ldr r0,[pool_037FF034]	; 037FF02C
	str r1,[r0,#0x0]	; 037FF02E
P2_Entry_037FF030:
	bx lr	; 037FF030
	.byte 0xC0, 0x46	; 037FF032
pool_037FF034:
	.word P2_BssStart + 0x66C	; 037FF034
P2_Entry_037FF038:
	push {lr}	; 037FF038
	sub sp,#0x4	; 037FF03A
	ldr r1,[pool_037FF05C]	; 037FF03C
	ldr r3,[r1,#0x4]	; 037FF03E
	str r3,[r0,#0x14]	; 037FF040
	mov r2,#0x0	; 037FF042
	str r2,[r0,#0x18]	; 037FF044
	str r0,[r1,#0x4]	; 037FF046
	cmp r3,#0x0	; 037FF048
	beq P2_Entry_037FF050	; 037FF04A
	str r0,[r3,#0x18]	; 037FF04C
	b P2_Entry_037FF056	; 037FF04E
P2_Entry_037FF050:
	str r0,[r1,#0x0]	; 037FF050
	bl P2_Entry_037FEEF8	; 037FF052
P2_Entry_037FF056:
	add sp,#0x4	; 037FF056
	pop {r3}	; 037FF058
	bx r3	; 037FF05A
pool_037FF05C:
	.word P2_BssStart + 0x66C	; 037FF05C
P2_Entry_037FF060:
	push {r4,lr}	; 037FF060
	ldr r1,[pool_037FF0A8]	; 037FF062
	ldr r1,[r1,#0x0]	; 037FF064
	mov r2,#0x10	; 037FF066
	b P2_Entry_037FF09A	; 037FF068
P2_Entry_037FF06A:
	ldr r4,[r0,#0xc]	; 037FF06A
	ldr r3,[r1,#0xc]	; 037FF06C
	cmp r3,r4	; 037FF06E
	bcc P2_Entry_037FF098	; 037FF070
	cmp r3,r4	; 037FF072
	bne P2_Entry_037FF07E	; 037FF074
	ldrsh r4,[r1,r2]	; 037FF076
	ldrsh r3,[r0,r2]	; 037FF078
	cmp r4,r3	; 037FF07A
	ble P2_Entry_037FF098	; 037FF07C
P2_Entry_037FF07E:
	ldr r2,[r1,#0x14]	; 037FF07E
	str r2,[r0,#0x14]	; 037FF080
	str r1,[r0,#0x18]	; 037FF082
	str r0,[r1,#0x14]	; 037FF084
	cmp r2,#0x0	; 037FF086
	beq P2_Entry_037FF08E	; 037FF088
	str r0,[r2,#0x18]	; 037FF08A
	b P2_Entry_037FF0A2	; 037FF08C
P2_Entry_037FF08E:
	ldr r1,[pool_037FF0A8]	; 037FF08E
	str r0,[r1,#0x0]	; 037FF090
	bl P2_Entry_037FEEF8	; 037FF092
	b P2_Entry_037FF0A2	; 037FF096
P2_Entry_037FF098:
	ldr r1,[r1,#0x18]	; 037FF098
P2_Entry_037FF09A:
	cmp r1,#0x0	; 037FF09A
	bne P2_Entry_037FF06A	; 037FF09C
	bl P2_Entry_037FF038	; 037FF09E
P2_Entry_037FF0A2:
	pop {r4}	; 037FF0A2
	pop {r3}	; 037FF0A4
	bx r3	; 037FF0A6
pool_037FF0A8:
	.word P2_BssStart + 0x66C	; 037FF0A8

; ===== function loc_037FF0AC =====
loc_037FF0AC:
	ldr r0,[pool_037FF0B4]	; 037FF0AC
	ldrh r0,[r0,#0x0]	; 037FF0AE
	bx lr	; 037FF0B0
	.byte 0xC0, 0x46	; 037FF0B4
pool_037FF0B4:
loc_037FF0B4:
	.word P2_BssStart + 0x660	; 037FF0B4

; ===== function loc_037FF0B8 =====
loc_037FF0B8:
	push {lr}	; 037FF0B8
	sub sp,#0x4	; 037FF0BA
	ldr r0,[pool_037FF0E8]	; 037FF0BC
	ldrh r1,[r0,#0x0]	; 037FF0BE
	cmp r1,#0x0	; 037FF0C0
	bne loc_037FF0E0	; 037FF0C2
	mov r1,#0x1	; 037FF0C4
	strh r1,[r0,#0x0]	; 037FF0C6
	mov r1,#0x0	; 037FF0C8
	ldr r0,[pool_037FF0EC]	; 037FF0CA
	str r1,[r0,#0x0]	; 037FF0CC
	str r1,[r0,#0x4]	; 037FF0CE
	mov r0,#0x4	; 037FF0D0
	bl loc_037FDA6C	; 037FF0D2
	mov r1,#0x0	; 037FF0D6
	ldr r0,[pool_037FF0F0]	; 037FF0D8
	str r1,[r0,#0x0]	; 037FF0DA
	ldr r0,[pool_037FF0F4]	; 037FF0DC
	str r1,[r0,#0x0]	; 037FF0DE
loc_037FF0E0:
	add sp,#0x4	; 037FF0E0
	pop {r3}	; 037FF0E2
	bx r3	; 037FF0E4
	.byte 0xC0, 0x46	; 037FF0E8
pool_037FF0E8:
loc_037FF0E8:
	.word P2_BssStart + 0x660	; 037FF0E8
pool_037FF0EC:
loc_037FF0EC:
	.word P2_BssStart + 0x66C	; 037FF0EC
pool_037FF0F0:
loc_037FF0F0:
	.word P2_BssStart + 0x668	; 037FF0F0
pool_037FF0F4:
loc_037FF0F4:
	.word P2_BssStart + 0x664	; 037FF0F4
.arm

; ===== function loc_037FF0F8 =====
loc_037FF0F8:
	mrs r0,cpsr	; 037FF0F8
	bic r1,r0,#0x80	; 037FF0FC
	msr cpsr_c,r1	; 037FF100
	and r0,r0,#0x80	; 037FF104
	bx lr	; 037FF108

; ===== function loc_037FF10C =====
loc_037FF10C:
	mrs r0,cpsr	; 037FF10C
	orr r1,r0,#0x80	; 037FF110
	msr cpsr_c,r1	; 037FF114
	and r0,r0,#0x80	; 037FF118
	bx lr	; 037FF11C

; ===== function loc_037FF120 =====
loc_037FF120:
	mrs r1,cpsr	; 037FF120
	bic r2,r1,#0x80	; 037FF124
	orr r2,r2,r0	; 037FF128
	msr cpsr_c,r2	; 037FF12C
	and r0,r1,#0x80	; 037FF130
	bx lr	; 037FF134

; ===== function loc_037FF138 =====
loc_037FF138:
	mrs r0,cpsr	; 037FF138
	orr r1,r0,#0xc0	; 037FF13C
	msr cpsr_c,r1	; 037FF140
	and r0,r0,#0xc0	; 037FF144
	bx lr	; 037FF148

; ===== function loc_037FF14C =====
loc_037FF14C:
	mrs r1,cpsr	; 037FF14C
	bic r2,r1,#0xc0	; 037FF150
	orr r2,r2,r0	; 037FF154
	msr cpsr_c,r2	; 037FF158
	and r0,r1,#0xc0	; 037FF15C
	bx lr	; 037FF160

; ===== function loc_037FF164 =====
loc_037FF164:
	mrs r0,cpsr	; 037FF164
	and r0,r0,#0x1f	; 037FF168
	bx lr	; 037FF16C
.thumb

; ===== function loc_037FF170 =====
loc_037FF170:
	push {r4,r5,r6,r7,lr}	; 037FF170
	sub sp,#0x4	; 037FF172
	add r6,r0,#0x0	; 037FF174
	add r5,r1,#0x0	; 037FF176
	bl loc_037FDCE8	; 037FF178
	add r7,r0,#0x0	; 037FF17C
	ldr r1,[pool_037FF1C8]	; 037FF17E
	ldrh r4,[r1,#0x0]	; 037FF180
	mov r0,#0x1	; 037FF182
	strh r0,[r1,#0x0]	; 037FF184
	cmp r6,#0x0	; 037FF186
	beq loc_037FF1A0	; 037FF188
	ldr r1,[pool_037FF1CC]	; 037FF18A
	ldr r0,[r1,#0x0]	; 037FF18C
	bic r0,r5	; 037FF18E
	str r0,[r1,#0x0]	; 037FF190
	b loc_037FF1A0	; 037FF192
loc_037FF194:
	bl P2_SwiHalt	; 037FF194
	bl loc_037FB000	; 037FF198
	bl loc_037FDCE8	; 037FF19C
loc_037FF1A0:
	ldr r1,[pool_037FF1CC]	; 037FF1A0
	ldr r0,[r1,#0x0]	; 037FF1A2
	add r2,r5,#0x0	; 037FF1A4
	and r2,r0	; 037FF1A6
	cmp r2,#0x0	; 037FF1A8
	beq loc_037FF194	; 037FF1AA
	ldr r0,[r1,#0x0]	; 037FF1AC
	bic r0,r5	; 037FF1AE
	str r0,[r1,#0x0]	; 037FF1B0
	ldr r1,[pool_037FF1C8]	; 037FF1B2
	ldrh r0,[r1,#0x0]	; 037FF1B4
	strh r4,[r1,#0x0]	; 037FF1B6
	add r0,r7,#0x0	; 037FF1B8
	bl loc_037FDD0C	; 037FF1BA
	add sp,#0x4	; 037FF1BE
	pop {r4,r5,r6,r7}	; 037FF1C0
	pop {r3}	; 037FF1C2
	bx r3	; 037FF1C4
	.byte 0xC0, 0x46	; 037FF1C8
pool_037FF1C8:
loc_037FF1C8:
	.word REG_IME	; 037FF1C8
pool_037FF1CC:
loc_037FF1CC:
	.word Bios7IrqFlagsAddress	; 037FF1CC

; ===== function loc_037FF1D0 =====
loc_037FF1D0:
	lsr r0,r0,#0x2	; 037FF1D0
	ldr r3,[pool_037FF1D8]	; 037FF1D2
	bx r3	; 037FF1D4
	.byte 0xC0, 0x46	; 037FF1D8
pool_037FF1D8:
loc_037FF1D8:
	.word P2_SwiWaitByLoop + 1	; 037FF1D8

; ===== function loc_037FF1DC =====
loc_037FF1DC:
	push {lr}	; 037FF1DC
	sub sp,#0x4	; 037FF1DE
loc_037FF1E0:
	bl loc_037FDCE8	; 037FF1E0
	bl P2_SwiHalt	; 037FF1E4
	b loc_037FF1E0	; 037FF1E8
	.byte 0x00, 0x00	; 037FF1EC

; ===== function loc_037FF1EC =====
loc_037FF1EC:
	push {r4,lr}	; 037FF1EC
	add r4,r0,#0x0	; 037FF1EE
	bl loc_037FDCE8	; 037FF1F0
	mov r1,#0x6	; 037FF1F4
	mul r4,r1	; 037FF1F6
	add r1,r4,#0x5	; 037FF1F8
	lsl r2,r1,#0x1	; 037FF1FA
	ldr r1,[pool_037FF220]	; 037FF1FC
	add r2,r2,r1	; 037FF1FE
	ldrh r3,[r2,#0x0]	; 037FF200
	ldr r1,[pool_037FF224]	; 037FF202
	and r3,r1	; 037FF204
	strh r3,[r2,#0x0]	; 037FF206
	ldrh r3,[r2,#0x0]	; 037FF208
	ldr r1,[pool_037FF228]	; 037FF20A
	and r3,r1	; 037FF20C
	strh r3,[r2,#0x0]	; 037FF20E
	ldrh r1,[r2,#0x0]	; 037FF210
	ldrh r1,[r2,#0x0]	; 037FF212
	bl loc_037FDD0C	; 037FF214
	pop {r4}	; 037FF218
	pop {r3}	; 037FF21A
	bx r3	; 037FF21C
	.byte 0xC0, 0x46	; 037FF220
pool_037FF220:
loc_037FF220:
	.word REG_DMA0SAD	; 037FF220
pool_037FF224:
loc_037FF224:
	.word 0xFFFFCDFF	; 037FF224
pool_037FF228:
loc_037FF228:
	.word 0xFFFF7FFF	; 037FF228
P2_Entry_037FF22C:
	mov r1,#0x3	; 037FF22C
	mul r0,r1	; 037FF22E
	add r0,r0,#0x2	; 037FF230
	lsl r1,r0,#0x2	; 037FF232
	ldr r0,[pool_037FF244]	; 037FF234
	add r2,r1,r0	; 037FF236
	ldr r0,[pool_037FF248]	; 037FF238
P2_Entry_037FF23A:
	ldr r1,[r2,#0x0]	; 037FF23A
	and r1,r0	; 037FF23C
	cmp r1,#0x0	; 037FF23E
	bne P2_Entry_037FF23A	; 037FF240
	bx lr	; 037FF242
pool_037FF244:
	.word 0x040000B0	; 037FF244
pool_037FF248:
	.word 0x80000000	; 037FF248
P2_Entry_037FF24C:
	push {r4,r5,r6,r7,lr}	; 037FF24C
	sub sp,#0x4	; 037FF24E
	add r5,r0,#0x0	; 037FF250
	add r6,r1,#0x0	; 037FF252
	add r7,r2,#0x0	; 037FF254
	str r3,[sp,#0x0]	; 037FF256
	cmp r3,#0x0	; 037FF258
	beq P2_Entry_037FF29E	; 037FF25A
	mov r0,#0x3	; 037FF25C
	add r1,r5,#0x0	; 037FF25E
	mul r1,r0	; 037FF260
	add r0,r1,#0x2	; 037FF262
	lsl r1,r0,#0x2	; 037FF264
	ldr r0,[pool_037FF2A8]	; 037FF266
	add r4,r1,r0	; 037FF268
	ldr r0,[pool_037FF2AC]	; 037FF26A
P2_Entry_037FF26C:
	ldr r1,[r4,#0x0]	; 037FF26C
	and r1,r0	; 037FF26E
	cmp r1,#0x0	; 037FF270
	bne P2_Entry_037FF26C	; 037FF272
	bl loc_037FDCE8	; 037FF274
	mov r1,#0xc	; 037FF278
	mul r5,r1	; 037FF27A
	ldr r1,[pool_037FF2A8]	; 037FF27C
	add r2,r5,r1	; 037FF27E
	str r6,[r2,#0x0]	; 037FF280
	str r7,[r2,#0x4]	; 037FF282
	ldr r3,[sp,#0x0]	; 037FF284
	lsr r5,r3,#0x1	; 037FF286
	ldr r3,[pool_037FF2AC]	; 037FF288
	orr r5,r3	; 037FF28A
	str r5,[r2,#0x8]	; 037FF28C
	ldr r1,[r1,#0x0]	; 037FF28E
	bl loc_037FDD0C	; 037FF290
	ldr r0,[pool_037FF2AC]	; 037FF294
P2_Entry_037FF296:
	ldr r1,[r4,#0x0]	; 037FF296
	and r1,r0	; 037FF298
	cmp r1,#0x0	; 037FF29A
	bne P2_Entry_037FF296	; 037FF29C
P2_Entry_037FF29E:
	add sp,#0x4	; 037FF29E
	pop {r4,r5,r6,r7}	; 037FF2A0
	pop {r3}	; 037FF2A2
	bx r3	; 037FF2A4
	.byte 0xC0, 0x46	; 037FF2A6
pool_037FF2A8:
	.word REG_DMA0SAD	; 037FF2A8
pool_037FF2AC:
	.word 0x80000000	; 037FF2AC
P2_Entry_037FF2B0:
	push {r4,r5,r6,r7,lr}	; 037FF2B0
	sub sp,#0x4	; 037FF2B2
	add r5,r0,#0x0	; 037FF2B4
	add r6,r1,#0x0	; 037FF2B6
	add r7,r2,#0x0	; 037FF2B8
	str r3,[sp,#0x0]	; 037FF2BA
	cmp r3,#0x0	; 037FF2BC
	beq P2_Entry_037FF30A	; 037FF2BE
	mov r0,#0x3	; 037FF2C0
	add r1,r5,#0x0	; 037FF2C2
	mul r1,r0	; 037FF2C4
	add r0,r1,#0x2	; 037FF2C6
	lsl r1,r0,#0x2	; 037FF2C8
	ldr r0,[pool_037FF314]	; 037FF2CA
	add r4,r1,r0	; 037FF2CC
	ldr r0,[pool_037FF318]	; 037FF2CE
P2_Entry_037FF2D0:
	ldr r1,[r4,#0x0]	; 037FF2D0
	and r1,r0	; 037FF2D2
	cmp r1,#0x0	; 037FF2D4
	bne P2_Entry_037FF2D0	; 037FF2D6
	bl loc_037FDCE8	; 037FF2D8
	lsl r2,r5,#0x2	; 037FF2DC
	ldr r1,[pool_037FF31C]	; 037FF2DE
	add r1,r2,r1	; 037FF2E0
	str r7,[r1,#0x0]	; 037FF2E2
	mov r2,#0xc	; 037FF2E4
	mul r5,r2	; 037FF2E6
	ldr r2,[pool_037FF314]	; 037FF2E8
	add r3,r5,r2	; 037FF2EA
	str r1,[r3,#0x0]	; 037FF2EC
	str r6,[r3,#0x4]	; 037FF2EE
	ldr r1,[sp,#0x0]	; 037FF2F0
	lsr r5,r1,#0x1	; 037FF2F2
	ldr r1,[pool_037FF320]	; 037FF2F4
	orr r5,r1	; 037FF2F6
	str r5,[r3,#0x8]	; 037FF2F8
	ldr r1,[r2,#0x0]	; 037FF2FA
	bl loc_037FDD0C	; 037FF2FC
	ldr r0,[pool_037FF318]	; 037FF300
P2_Entry_037FF302:
	ldr r1,[r4,#0x0]	; 037FF302
	and r1,r0	; 037FF304
	cmp r1,#0x0	; 037FF306
	bne P2_Entry_037FF302	; 037FF308
P2_Entry_037FF30A:
	add sp,#0x4	; 037FF30A
	pop {r4,r5,r6,r7}	; 037FF30C
	pop {r3}	; 037FF30E
	bx r3	; 037FF310
	.byte 0xC0, 0x46	; 037FF312
pool_037FF314:
	.word REG_DMA0SAD	; 037FF314
pool_037FF318:
	.word 0x80000000	; 037FF318
pool_037FF31C:
	.word 0x0380FFE0	; 037FF31C
pool_037FF320:
	.word 0x81000000	; 037FF320
.arm

; ===== function loc_037FF324 =====
loc_037FF324:
	mov r3,#0x0	; 037FF324
loc_037FF328:
	cmp r3,r2	; 037FF328
	strlth r0,[r1,r3]	; 037FF32C
	addlt r3,r3,#0x2	; 037FF330
	blt loc_037FF328	; 037FF334
	bx lr	; 037FF338
P2_Entry_037FF33C:
	mov r12,#0x0	; 037FF33C
P2_Entry_037FF340:
	cmp r12,r2	; 037FF340
	ldrlth r3,[r0,r12]	; 037FF344
	strlth r3,[r1,r12]	; 037FF348
	addlt r12,r12,#0x2	; 037FF34C
	blt P2_Entry_037FF340	; 037FF350
	bx lr	; 037FF354

; ===== function loc_037FF358 =====
loc_037FF358:
	add r12,r1,r2	; 037FF358
loc_037FF35C:
	cmp r1,r12	; 037FF35C
	stmltia r1!,{r0}	; 037FF360
	blt loc_037FF35C	; 037FF364
	bx lr	; 037FF368

; ===== function loc_037FF36C =====
loc_037FF36C:
	add r12,r1,r2	; 037FF36C
loc_037FF370:
	cmp r1,r12	; 037FF370
	ldmltia r0!,{r2}	; 037FF374
	stmltia r1!,{r2}	; 037FF378
	blt loc_037FF370	; 037FF37C
	bx lr	; 037FF380
P2_Entry_037FF384:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 037FF384
	add r9,r1,r2	; 037FF388
	mov r12,r2, lsr #0x5	; 037FF38C
	add r12,r1,r12, lsl #0x5	; 037FF390
	mov r2,r0	; 037FF394
	mov r3,r2	; 037FF398
	mov r4,r2	; 037FF39C
	mov r5,r2	; 037FF3A0
	mov r6,r2	; 037FF3A4
	mov r7,r2	; 037FF3A8
	mov r8,r2	; 037FF3AC
P2_Entry_037FF3B0:
	cmp r1,r12	; 037FF3B0
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 037FF3B4
	blt P2_Entry_037FF3B0	; 037FF3B8
P2_Entry_037FF3BC:
	cmp r1,r9	; 037FF3BC
	stmltia r1!,{r0}	; 037FF3C0
	blt P2_Entry_037FF3BC	; 037FF3C4
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 037FF3C8
	bx lr	; 037FF3CC

; ===== function loc_037FF3D0 =====
loc_037FF3D0:
	mov r12,#0x0	; 037FF3D0
loc_037FF3D4:
	cmp r12,r2	; 037FF3D4
	strltb r1,[r0,r12]	; 037FF3D8
	addlt r12,r12,#0x1	; 037FF3DC
	blt loc_037FF3D4	; 037FF3E0
	bx lr	; 037FF3E4
P2_Entry_037FF3E8:
	mov r12,#0x0	; 037FF3E8
P2_Entry_037FF3EC:
	cmp r12,r2	; 037FF3EC
	ldrltb r3,[r0,r12]	; 037FF3F0
	strltb r3,[r1,r12]	; 037FF3F4
	addlt r12,r12,#0x1	; 037FF3F8
	blt P2_Entry_037FF3EC	; 037FF3FC
	bx lr	; 037FF400

; ===== function loc_037FF404 =====
loc_037FF404:
	swp r0,r0,[r1]	; 037FF404
	bx lr	; 037FF408
.thumb

; ===== function loc_037FF40C =====
loc_037FF40C:
	push {r4,r5,r6,lr}	; 037FF40C
	ldr r4,[pool_037FF43C]	; 037FF40E
	ldrb r5,[r4,#0x0]	; 037FF410
	mov r4,#0x80	; 037FF412
	and r5,r4	; 037FF414
	cmp r5,#0x0	; 037FF416
	beq loc_037FF41E	; 037FF418
	mov r6,#0x1	; 037FF41A
	b loc_037FF420	; 037FF41C
loc_037FF41E:
	mov r6,#0x0	; 037FF41E
loc_037FF420:
	lsl r5,r1,#0x2	; 037FF420
	lsl r4,r2,#0x4	; 037FF422
	lsl r2,r6,#0x7	; 037FF424
	lsl r1,r3,#0x5	; 037FF426
	orr r2,r1	; 037FF428
	orr r4,r2	; 037FF42A
	orr r5,r4	; 037FF42C
	orr r0,r5	; 037FF42E
	ldr r1,[pool_037FF43C]	; 037FF430
	strb r0,[r1,#0x0]	; 037FF432
	pop {r4,r5,r6}	; 037FF434
	pop {r3}	; 037FF436
	bx r3	; 037FF438
	.byte 0xC0, 0x46	; 037FF43C
pool_037FF43C:
loc_037FF43C:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF43C

; ===== function loc_037FF440 =====
loc_037FF440:
	ldr r1,[pool_037FF448]	; 037FF440
	strb r0,[r1,#0x0]	; 037FF442
	bx lr	; 037FF444
	.byte 0xC0, 0x46	; 037FF448
pool_037FF448:
loc_037FF448:
	.word REG_SOUNDCNT_ARM7	; 037FF448
P2_Entry_037FF44C:
	push {lr}	; 037FF44C
	sub sp,#0x4	; 037FF44E
	ldr r2,[pool_037FF474]	; 037FF450
	ldrh r1,[r2,#0x0]	; 037FF452
	mov r0,#0x1	; 037FF454
	orr r1,r0	; 037FF456
	strh r1,[r2,#0x0]	; 037FF458
	bl loc_0380443C	; 037FF45A
	ldr r0,[pool_037FF478]	; 037FF45E
	bl P2_SwiSoundBiasIncrease	; 037FF460
	ldr r0,[pool_037FF47C]	; 037FF464
	bl loc_037FF1D0	; 037FF466
	bl P2_Entry_037FF4C4	; 037FF46A
	add sp,#0x4	; 037FF46E
	pop {r3}	; 037FF470
	bx r3	; 037FF472
pool_037FF474:
	.word REG_POWERCNT_ARM7	; 037FF474
pool_037FF478:
	.word 0x00000100	; 037FF478
pool_037FF47C:
	.word 0x0007AB80	; 037FF47C
P2_Entry_037FF480:
	push {lr}	; 037FF480
	sub sp,#0x4	; 037FF482
	bl P2_Entry_037FF4B4	; 037FF484
	mov r0,#0x80	; 037FF488
	bl P2_SwiSoundBiasDecrease	; 037FF48A
	ldr r0,[pool_037FF4AC]	; 037FF48E
	bl loc_037FF1D0	; 037FF490
	mov r0,#0x1	; 037FF494
	bl loc_03804420	; 037FF496
	ldr r2,[pool_037FF4B0]	; 037FF49A
	ldrh r1,[r2,#0x0]	; 037FF49C
	mov r0,#0x1	; 037FF49E
	bic r1,r0	; 037FF4A0
	strh r1,[r2,#0x0]	; 037FF4A2
	add sp,#0x4	; 037FF4A4
	pop {r3}	; 037FF4A6
	bx r3	; 037FF4A8
	.byte 0xC0, 0x46	; 037FF4AA
pool_037FF4AC:
	.word 0x00040000	; 037FF4AC
pool_037FF4B0:
	.word REG_POWERCNT_ARM7	; 037FF4B0
P2_Entry_037FF4B4:
	ldr r2,[pool_037FF4C0]	; 037FF4B4
	ldrb r1,[r2,#0x0]	; 037FF4B6
	mov r0,#0x80	; 037FF4B8
	bic r1,r0	; 037FF4BA
	strb r1,[r2,#0x0]	; 037FF4BC
	bx lr	; 037FF4BE
pool_037FF4C0:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF4C0
P2_Entry_037FF4C4:
	ldr r2,[pool_037FF4D0]	; 037FF4C4
	ldrb r1,[r2,#0x0]	; 037FF4C6
	mov r0,#0x80	; 037FF4C8
	orr r1,r0	; 037FF4CA
	strb r1,[r2,#0x0]	; 037FF4CC
	bx lr	; 037FF4CE
pool_037FF4D0:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF4D0

; ===== function loc_037FF4D4 =====
loc_037FF4D4:
	push {r4,lr}	; 037FF4D4
	cmp r1,#0x18	; 037FF4D6
	bge loc_037FF4F0	; 037FF4D8
	ldr r2,[pool_037FF510]	; 037FF4DA
	ldr r3,[r2,#0x0]	; 037FF4DC
	ldr r2,[pool_037FF514]	; 037FF4DE
	sub r2,r2,r3	; 037FF4E0
	lsl r2,r2,#0x6	; 037FF4E2
	add r1,#0x28	; 037FF4E4
	mul r3,r1	; 037FF4E6
	add r1,r2,r3	; 037FF4E8
	mul r0,r1	; 037FF4EA
	asr r0,r0,#0x15	; 037FF4EC
	b loc_037FF50A	; 037FF4EE
loc_037FF4F0:
	cmp r1,#0x68	; 037FF4F0
	ble loc_037FF50A	; 037FF4F2
	ldr r2,[pool_037FF510]	; 037FF4F4
	ldr r4,[r2,#0x0]	; 037FF4F6
	ldr r2,[pool_037FF514]	; 037FF4F8
	add r2,r4,r2	; 037FF4FA
	lsl r3,r2,#0x6	; 037FF4FC
	neg r2,r4	; 037FF4FE
	sub r1,#0x28	; 037FF500
	mul r2,r1	; 037FF502
	add r1,r3,r2	; 037FF504
	mul r0,r1	; 037FF506
	asr r0,r0,#0x15	; 037FF508
loc_037FF50A:
	pop {r4}	; 037FF50A
	pop {r3}	; 037FF50C
	bx r3	; 037FF50E
pool_037FF510:
loc_037FF510:
	.word P2_BssStart + 0x674	; 037FF510
pool_037FF514:
loc_037FF514:
	.word 0x00007FFF	; 037FF514

; ===== function loc_037FF518 =====
loc_037FF518:
	push {r4,r5,r6,r7,lr}	; 037FF518
	sub sp,#0x4	; 037FF51A
	ldr r1,[pool_037FF550]	; 037FF51C
	str r0,[r1,#0x0]	; 037FF51E
	mov r5,#0x0	; 037FF520
	ldr r6,[pool_037FF554]	; 037FF522
	ldr r7,[pool_037FF558]	; 037FF524
loc_037FF526:
	mov r0,#0x1	; 037FF526
	lsl r0,r5	; 037FF528
	and r0,r7	; 037FF52A
	cmp r0,#0x0	; 037FF52C
	beq loc_037FF540	; 037FF52E
	lsl r4,r5,#0x4	; 037FF530
	ldr r0,[pool_037FF55C]	; 037FF532
	ldrb r1,[r4,r0]	; 037FF534
	ldrb r0,[r6,r5]	; 037FF536
	bl loc_037FF4D4	; 037FF538
	ldr r1,[pool_037FF560]	; 037FF53C
	strb r0,[r4,r1]	; 037FF53E
loc_037FF540:
	add r5,r5,#0x1	; 037FF540
	cmp r5,#0x10	; 037FF542
	blt loc_037FF526	; 037FF544
	add sp,#0x4	; 037FF546
	pop {r4,r5,r6,r7}	; 037FF548
	pop {r3}	; 037FF54A
	bx r3	; 037FF54C
	.byte 0xC0, 0x46	; 037FF550
pool_037FF550:
loc_037FF550:
	.word P2_BssStart + 0x674	; 037FF550
pool_037FF554:
loc_037FF554:
	.word 0x03805A18	; 037FF554
pool_037FF558:
loc_037FF558:
	.word 0x0000FFF5	; 037FF558
pool_037FF55C:
loc_037FF55C:
	.word SCHANNEL0_PAN	; 037FF55C
pool_037FF560:
loc_037FF560:
	.word SCHANNEL0_CR	; 037FF560

; ===== function loc_037FF564 =====
loc_037FF564:
	lsl r1,r0,#0x4	; 037FF564
	ldr r0,[pool_037FF57C]	; 037FF566
	ldrb r1,[r1,r0]	; 037FF568
	mov r0,#0x80	; 037FF56A
	and r1,r0	; 037FF56C
	cmp r1,#0x0	; 037FF56E
	beq loc_037FF576	; 037FF570
	mov r0,#0x1	; 037FF572
	bx lr	; 037FF574
loc_037FF576:
	mov r0,#0x0	; 037FF576
	bx lr	; 037FF578
	.byte 0xC0, 0x46	; 037FF57C
pool_037FF57C:
loc_037FF57C:
	.word 0x04000403	; 037FF57C

; ===== function loc_037FF580 =====
loc_037FF580:
	push {r4,lr}	; 037FF580
	lsl r4,r0,#0x4	; 037FF582
	ldr r2,[pool_037FF5B0]	; 037FF584
	strb r1,[r4,r2]	; 037FF586
	ldr r2,[pool_037FF5B4]	; 037FF588
	ldr r2,[r2,#0x0]	; 037FF58A
	cmp r2,#0x0	; 037FF58C
	ble loc_037FF5A8	; 037FF58E
	mov r3,#0x1	; 037FF590
	lsl r3,r0	; 037FF592
	ldr r2,[pool_037FF5B8]	; 037FF594
	and r3,r2	; 037FF596
	cmp r3,#0x0	; 037FF598
	beq loc_037FF5A8	; 037FF59A
	ldr r2,[pool_037FF5BC]	; 037FF59C
	ldrb r0,[r2,r0]	; 037FF59E
	bl loc_037FF4D4	; 037FF5A0
	ldr r1,[pool_037FF5C0]	; 037FF5A4
	strb r0,[r4,r1]	; 037FF5A6
loc_037FF5A8:
	pop {r4}	; 037FF5A8
	pop {r3}	; 037FF5AA
	bx r3	; 037FF5AC
	.byte 0xC0, 0x46	; 037FF5B0
pool_037FF5B0:
loc_037FF5B0:
	.word SCHANNEL0_PAN	; 037FF5B0
pool_037FF5B4:
loc_037FF5B4:
	.word P2_BssStart + 0x674	; 037FF5B4
pool_037FF5B8:
loc_037FF5B8:
	.word 0x0000FFF5	; 037FF5B8
pool_037FF5BC:
loc_037FF5BC:
	.word P2_BssStart + 0x678	; 037FF5BC
pool_037FF5C0:
loc_037FF5C0:
	.word SCHANNEL0_CR	; 037FF5C0

; ===== function loc_037FF5C4 =====
loc_037FF5C4:
	ldr r2,[pool_037FF5D0]	; 037FF5C4
	sub r2,r2,r1	; 037FF5C6
	lsl r1,r0,#0x4	; 037FF5C8
	ldr r0,[pool_037FF5D4]	; 037FF5CA
	strh r2,[r1,r0]	; 037FF5CC
	bx lr	; 037FF5CE
pool_037FF5D0:
loc_037FF5D0:
	.word 0x00010000	; 037FF5D0
pool_037FF5D4:
loc_037FF5D4:
	.word SCHANNEL0_TIMER	; 037FF5D4

; ===== function loc_037FF5D8 =====
loc_037FF5D8:
	push {r4,r5,lr}	; 037FF5D8
	sub sp,#0x4	; 037FF5DA
	add r5,r0,#0x0	; 037FF5DC
	add r4,r2,#0x0	; 037FF5DE
	ldr r0,[pool_037FF61C]	; 037FF5E0
	strb r1,[r0,r5]	; 037FF5E2
	ldr r0,[pool_037FF620]	; 037FF5E4
	ldr r0,[r0,#0x0]	; 037FF5E6
	cmp r0,#0x0	; 037FF5E8
	ble loc_037FF608	; 037FF5EA
	mov r2,#0x1	; 037FF5EC
	lsl r2,r5	; 037FF5EE
	ldr r0,[pool_037FF624]	; 037FF5F0
	and r2,r0	; 037FF5F2
	cmp r2,#0x0	; 037FF5F4
	beq loc_037FF608	; 037FF5F6
	lsl r2,r5,#0x4	; 037FF5F8
	ldr r0,[pool_037FF628]	; 037FF5FA
	ldrb r2,[r2,r0]	; 037FF5FC
	add r0,r1,#0x0	; 037FF5FE
	add r1,r2,#0x0	; 037FF600
	bl loc_037FF4D4	; 037FF602
	add r1,r0,#0x0	; 037FF606
loc_037FF608:
	lsl r2,r4,#0x8	; 037FF608
	orr r2,r1	; 037FF60A
	lsl r1,r5,#0x4	; 037FF60C
	ldr r0,[pool_037FF62C]	; 037FF60E
	strh r2,[r1,r0]	; 037FF610
	add sp,#0x4	; 037FF612
	pop {r4,r5}	; 037FF614
	pop {r3}	; 037FF616
	bx r3	; 037FF618
	.byte 0xC0, 0x46	; 037FF61C
pool_037FF61C:
loc_037FF61C:
	.word P2_BssStart + 0x678	; 037FF61C
pool_037FF620:
loc_037FF620:
	.word P2_BssStart + 0x674	; 037FF620
pool_037FF624:
loc_037FF624:
	.word 0x0000FFF5	; 037FF624
pool_037FF628:
loc_037FF628:
	.word SCHANNEL0_PAN	; 037FF628
pool_037FF62C:
loc_037FF62C:
	.word SCHANNEL0_CR	; 037FF62C

; ===== function loc_037FF630 =====
loc_037FF630:
	lsl r2,r0,#0x4	; 037FF630
	ldr r0,[pool_037FF64C]	; 037FF632
	add r3,r2,r0	; 037FF634
	ldr r2,[r3,#0x0]	; 037FF636
	ldr r0,[pool_037FF650]	; 037FF638
	and r2,r0	; 037FF63A
	mov r0,#0x1	; 037FF63C
	and r1,r0	; 037FF63E
	cmp r1,#0x0	; 037FF640
	beq loc_037FF648	; 037FF642
	ldr r0,[pool_037FF654]	; 037FF644
	orr r2,r0	; 037FF646
loc_037FF648:
	str r2,[r3,#0x0]	; 037FF648
	bx lr	; 037FF64A
pool_037FF64C:
loc_037FF64C:
	.word SCHANNEL0_CR	; 037FF64C
pool_037FF650:
loc_037FF650:
	.word 0x7FFFFFFF	; 037FF650
pool_037FF654:
loc_037FF654:
	.word 0x00008000	; 037FF654

; ===== function loc_037FF658 =====
loc_037FF658:
	push {r4,r5,r6,lr}	; 037FF658
	add r5,r2,#0x0	; 037FF65A
	add r6,r3,#0x0	; 037FF65C
	lsl r4,r0,#0x4	; 037FF65E
	ldr r2,[pool_037FF6A4]	; 037FF660
	strb r1,[r2,r0]	; 037FF662
	ldr r2,[pool_037FF6A8]	; 037FF664
	ldr r2,[r2,#0x0]	; 037FF666
	cmp r2,#0x0	; 037FF668
	ble loc_037FF682	; 037FF66A
	mov r2,#0x1	; 037FF66C
	lsl r2,r0	; 037FF66E
	ldr r0,[pool_037FF6AC]	; 037FF670
	and r2,r0	; 037FF672
	cmp r2,#0x0	; 037FF674
	beq loc_037FF682	; 037FF676
	add r0,r1,#0x0	; 037FF678
	ldr r1,[sp,#0x10]	; 037FF67A
	bl loc_037FF4D4	; 037FF67C
	add r1,r0,#0x0	; 037FF680
loc_037FF682:
	ldr r0,[sp,#0x10]	; 037FF682
	lsl r2,r0,#0x10	; 037FF684
	ldr r0,[pool_037FF6B0]	; 037FF686
	orr r2,r0	; 037FF688
	lsl r0,r5,#0x8	; 037FF68A
	orr r2,r0	; 037FF68C
	orr r1,r2	; 037FF68E
	ldr r0,[pool_037FF6B4]	; 037FF690
	str r1,[r4,r0]	; 037FF692
	ldr r0,[pool_037FF6B8]	; 037FF694
	sub r1,r0,r6	; 037FF696
	ldr r0,[pool_037FF6BC]	; 037FF698
	strh r1,[r4,r0]	; 037FF69A
	pop {r4,r5,r6}	; 037FF69C
	pop {r3}	; 037FF69E
	bx r3	; 037FF6A0
	.byte 0xC0, 0x46	; 037FF6A4
pool_037FF6A4:
loc_037FF6A4:
	.word P2_BssStart + 0x678	; 037FF6A4
pool_037FF6A8:
loc_037FF6A8:
	.word P2_BssStart + 0x674	; 037FF6A8
pool_037FF6AC:
loc_037FF6AC:
	.word 0x0000FFF5	; 037FF6AC
pool_037FF6B0:
loc_037FF6B0:
	.word 0x60000000	; 037FF6B0
pool_037FF6B4:
loc_037FF6B4:
	.word SCHANNEL0_CR	; 037FF6B4
pool_037FF6B8:
loc_037FF6B8:
	.word 0x00010000	; 037FF6B8
pool_037FF6BC:
loc_037FF6BC:
	.word SCHANNEL0_TIMER	; 037FF6BC

; ===== function loc_037FF6C0 =====
loc_037FF6C0:
	push {r4,r5,r6,lr}	; 037FF6C0
	add r5,r1,#0x0	; 037FF6C2
	add r6,r3,#0x0	; 037FF6C4
	lsl r4,r0,#0x4	; 037FF6C6
	ldr r1,[pool_037FF710]	; 037FF6C8
	strb r2,[r1,r0]	; 037FF6CA
	ldr r1,[pool_037FF714]	; 037FF6CC
	ldr r1,[r1,#0x0]	; 037FF6CE
	cmp r1,#0x0	; 037FF6D0
	ble loc_037FF6EA	; 037FF6D2
	mov r1,#0x1	; 037FF6D4
	lsl r1,r0	; 037FF6D6
	ldr r0,[pool_037FF718]	; 037FF6D8
	and r1,r0	; 037FF6DA
	cmp r1,#0x0	; 037FF6DC
	beq loc_037FF6EA	; 037FF6DE
	add r0,r2,#0x0	; 037FF6E0
	ldr r1,[sp,#0x14]	; 037FF6E2
	bl loc_037FF4D4	; 037FF6E4
	add r2,r0,#0x0	; 037FF6E8
loc_037FF6EA:
	lsl r0,r6,#0x8	; 037FF6EA
	lsl r3,r5,#0x18	; 037FF6EC
	ldr r1,[pool_037FF71C]	; 037FF6EE
	orr r3,r1	; 037FF6F0
	ldr r1,[sp,#0x14]	; 037FF6F2
	lsl r1,r1,#0x10	; 037FF6F4
	orr r3,r1	; 037FF6F6
	orr r0,r3	; 037FF6F8
	orr r2,r0	; 037FF6FA
	ldr r0,[pool_037FF720]	; 037FF6FC
	str r2,[r4,r0]	; 037FF6FE
	ldr r1,[sp,#0x10]	; 037FF700
	ldr r0,[pool_037FF724]	; 037FF702
	sub r1,r0,r1	; 037FF704
	ldr r0,[pool_037FF728]	; 037FF706
	strh r1,[r4,r0]	; 037FF708
	pop {r4,r5,r6}	; 037FF70A
	pop {r3}	; 037FF70C
	bx r3	; 037FF70E
pool_037FF710:
loc_037FF710:
	.word P2_BssStart + 0x678	; 037FF710
pool_037FF714:
loc_037FF714:
	.word P2_BssStart + 0x674	; 037FF714
pool_037FF718:
loc_037FF718:
	.word 0x0000FFF5	; 037FF718
pool_037FF71C:
loc_037FF71C:
	.word 0x60000000	; 037FF71C
pool_037FF720:
loc_037FF720:
	.word SCHANNEL0_CR	; 037FF720
pool_037FF724:
loc_037FF724:
	.word 0x00010000	; 037FF724
pool_037FF728:
loc_037FF728:
	.word SCHANNEL0_TIMER	; 037FF728

; ===== function loc_037FF72C =====
loc_037FF72C:
	push {r4,r5,r6,r7,lr}	; 037FF72C
	sub sp,#0x4	; 037FF72E
	add r5,r1,#0x0	; 037FF730
	add r6,r2,#0x0	; 037FF732
	add r7,r3,#0x0	; 037FF734
	ldr r1,[sp,#0x20]	; 037FF736
	lsl r4,r0,#0x4	; 037FF738
	ldr r2,[pool_037FF798]	; 037FF73A
	strb r1,[r2,r0]	; 037FF73C
	ldr r2,[pool_037FF79C]	; 037FF73E
	ldr r2,[r2,#0x0]	; 037FF740
	cmp r2,#0x0	; 037FF742
	ble loc_037FF75C	; 037FF744
	mov r2,#0x1	; 037FF746
	lsl r2,r0	; 037FF748
	ldr r0,[pool_037FF7A0]	; 037FF74A
	and r2,r0	; 037FF74C
	cmp r2,#0x0	; 037FF74E
	beq loc_037FF75C	; 037FF750
	add r0,r1,#0x0	; 037FF752
	ldr r1,[sp,#0x2c]	; 037FF754
	bl loc_037FF4D4	; 037FF756
	add r1,r0,#0x0	; 037FF75A
loc_037FF75C:
	ldr r0,[sp,#0x24]	; 037FF75C
	lsl r2,r0,#0x8	; 037FF75E
	ldr r0,[sp,#0x2c]	; 037FF760
	lsl r0,r0,#0x10	; 037FF762
	lsl r3,r6,#0x1d	; 037FF764
	lsl r6,r7,#0x1b	; 037FF766
	orr r3,r6	; 037FF768
	orr r0,r3	; 037FF76A
	orr r2,r0	; 037FF76C
	orr r1,r2	; 037FF76E
	ldr r0,[pool_037FF7A4]	; 037FF770
	str r1,[r4,r0]	; 037FF772
	ldr r1,[sp,#0x28]	; 037FF774
	ldr r0,[pool_037FF7A8]	; 037FF776
	sub r1,r0,r1	; 037FF778
	ldr r0,[pool_037FF7AC]	; 037FF77A
	strh r1,[r4,r0]	; 037FF77C
	ldr r1,[sp,#0x18]	; 037FF77E
	ldr r0,[pool_037FF7B0]	; 037FF780
	strh r1,[r4,r0]	; 037FF782
	ldr r1,[sp,#0x1c]	; 037FF784
	ldr r0,[pool_037FF7B4]	; 037FF786
	str r1,[r4,r0]	; 037FF788
	ldr r0,[pool_037FF7B8]	; 037FF78A
	str r5,[r4,r0]	; 037FF78C
	add sp,#0x4	; 037FF78E
	pop {r4,r5,r6,r7}	; 037FF790
	pop {r3}	; 037FF792
	bx r3	; 037FF794
	.byte 0xC0, 0x46	; 037FF798
pool_037FF798:
loc_037FF798:
	.word P2_BssStart + 0x678	; 037FF798
pool_037FF79C:
loc_037FF79C:
	.word P2_BssStart + 0x674	; 037FF79C
pool_037FF7A0:
loc_037FF7A0:
	.word 0x0000FFF5	; 037FF7A0
pool_037FF7A4:
loc_037FF7A4:
	.word SCHANNEL0_CR	; 037FF7A4
pool_037FF7A8:
loc_037FF7A8:
	.word 0x00010000	; 037FF7A8
pool_037FF7AC:
loc_037FF7AC:
	.word SCHANNEL0_TIMER	; 037FF7AC
pool_037FF7B0:
loc_037FF7B0:
	.word 0x0400040A	; 037FF7B0
pool_037FF7B4:
loc_037FF7B4:
	.word 0x0400040C	; 037FF7B4
pool_037FF7B8:
loc_037FF7B8:
	.word 0x04000404	; 037FF7B8

; ===== function loc_037FF7BC =====
loc_037FF7BC:
	ldr r1,[pool_037FF7D4]	; 037FF7BC
	ldr r2,[r1,#0x0]	; 037FF7BE
	ldr r0,[pool_037FF7D8]	; 037FF7C0
	mul r2,r0	; 037FF7C2
	ldr r0,[pool_037FF7DC]	; 037FF7C4
	add r0,r2,r0	; 037FF7C6
	str r0,[r1,#0x0]	; 037FF7C8
	lsr r0,r0,#0x10	; 037FF7CA
	lsl r0,r0,#0x10	; 037FF7CC
	lsr r0,r0,#0x10	; 037FF7CE
	bx lr	; 037FF7D0
	.byte 0xC0, 0x46	; 037FF7D4
pool_037FF7D4:
loc_037FF7D4:
	.word P2_Data_038052E4	; 037FF7D4
pool_037FF7D8:
loc_037FF7D8:
	.word 0x0019660D	; 037FF7D8
pool_037FF7DC:
loc_037FF7DC:
	.word 0x3C6EF35F	; 037FF7DC

; ===== function loc_037FF7E0 =====
loc_037FF7E0:
	cmp r0,#0x20	; 037FF7E0
	bge loc_037FF7EA	; 037FF7E2
	ldr r1,[pool_037FF81C]	; 037FF7E4
	ldrsb r0,[r1,r0]	; 037FF7E6
	bx lr	; 037FF7E8
loc_037FF7EA:
	cmp r0,#0x40	; 037FF7EA
	bge loc_037FF7F8	; 037FF7EC
	mov r1,#0x40	; 037FF7EE
	sub r1,r1,r0	; 037FF7F0
	ldr r0,[pool_037FF81C]	; 037FF7F2
	ldrsb r0,[r0,r1]	; 037FF7F4
	bx lr	; 037FF7F6
loc_037FF7F8:
	cmp r0,#0x60	; 037FF7F8
	bge loc_037FF80A	; 037FF7FA
	sub r0,#0x40	; 037FF7FC
	ldr r1,[pool_037FF81C]	; 037FF7FE
	ldrsb r0,[r1,r0]	; 037FF800
	neg r0,r0	; 037FF802
	lsl r0,r0,#0x18	; 037FF804
	asr r0,r0,#0x18	; 037FF806
	bx lr	; 037FF808
loc_037FF80A:
	sub r0,#0x60	; 037FF80A
	mov r1,#0x20	; 037FF80C
	sub r1,r1,r0	; 037FF80E
	ldr r0,[pool_037FF81C]	; 037FF810
	ldrsb r0,[r0,r1]	; 037FF812
	neg r0,r0	; 037FF814
	lsl r0,r0,#0x18	; 037FF816
	asr r0,r0,#0x18	; 037FF818
	bx lr	; 037FF81A
pool_037FF81C:
loc_037FF81C:
	.word P2_Data_03805104	; 037FF81C

; ===== function loc_037FF820 =====
loc_037FF820:
	push {r4,lr}	; 037FF820
	add r4,r0,#0x0	; 037FF822
	ldr r0,[pool_037FF870]	; 037FF824
	cmp r4,r0	; 037FF826
	bge loc_037FF82E	; 037FF828
	add r4,r0,#0x0	; 037FF82A
	b loc_037FF834	; 037FF82C
loc_037FF82E:
	cmp r4,#0x0	; 037FF82E
	ble loc_037FF834	; 037FF830
	mov r4,#0x0	; 037FF832
loc_037FF834:
	ldr r0,[pool_037FF874]	; 037FF834
	add r0,r4,r0	; 037FF836
	bl loc_03804950	; 037FF838
	mov r1,#0xef	; 037FF83C
	mvn r1,r1	; 037FF83E
	cmp r4,r1	; 037FF840
	bge loc_037FF848	; 037FF842
	mov r1,#0x3	; 037FF844
	b loc_037FF862	; 037FF846
loc_037FF848:
	mov r1,#0x77	; 037FF848
	mvn r1,r1	; 037FF84A
	cmp r4,r1	; 037FF84C
	bge loc_037FF854	; 037FF84E
	mov r1,#0x2	; 037FF850
	b loc_037FF862	; 037FF852
loc_037FF854:
	mov r1,#0x3b	; 037FF854
	mvn r1,r1	; 037FF856
	cmp r4,r1	; 037FF858
	bge loc_037FF860	; 037FF85A
	mov r1,#0x1	; 037FF85C
	b loc_037FF862	; 037FF85E
loc_037FF860:
	mov r1,#0x0	; 037FF860
loc_037FF862:
	lsl r1,r1,#0x8	; 037FF862
	orr r1,r0	; 037FF864
	lsl r0,r1,#0x10	; 037FF866
	lsr r0,r0,#0x10	; 037FF868
	pop {r4}	; 037FF86A
	pop {r3}	; 037FF86C
	bx r3	; 037FF86E
pool_037FF870:
loc_037FF870:
	.word 0xFFFFFD2D	; 037FF870
pool_037FF874:
loc_037FF874:
	.word 0x000002D3	; 037FF874

; ===== function loc_037FF878 =====
loc_037FF878:
	push {r4,r5,r6,lr}	; 037FF878
	add r5,r0,#0x0	; 037FF87A
	mov r4,#0x0	; 037FF87C
	neg r0,r1	; 037FF87E
	ldr r1,[pool_037FF924]	; 037FF880
	b loc_037FF888	; 037FF882
loc_037FF884:
	sub r4,r4,#0x1	; 037FF884
	add r0,r0,r1	; 037FF886
loc_037FF888:
	cmp r0,#0x0	; 037FF888
	blt loc_037FF884	; 037FF88A
	ldr r1,[pool_037FF924]	; 037FF88C
	b loc_037FF894	; 037FF88E
loc_037FF890:
	add r4,r4,#0x1	; 037FF890
	sub r0,r0,r1	; 037FF892
loc_037FF894:
	cmp r0,r1	; 037FF894
	bge loc_037FF890	; 037FF896
	bl loc_0380494C	; 037FF898
	mov r1,#0x0	; 037FF89C
	ldr r2,[pool_037FF928]	; 037FF89E
	add r0,r0,r2	; 037FF8A0
	adc r1,r1	; 037FF8A2
	asr r3,r5,#0x1f	; 037FF8A4
	add r2,r5,#0x0	; 037FF8A6
	bl loc_037FEC30	; 037FF8A8
	add r6,r0,#0x0	; 037FF8AC
	add r5,r1,#0x0	; 037FF8AE
	add r2,r4,#0x0	; 037FF8B0
	sub r2,#0x10	; 037FF8B2
	cmp r2,#0x0	; 037FF8B4
	bgt loc_037FF8C2	; 037FF8B6
	neg r2,r2	; 037FF8B8
	bl loc_037FF930	; 037FF8BA
	add r5,r1,#0x0	; 037FF8BE
	b loc_037FF8FE	; 037FF8C0
loc_037FF8C2:
	cmp r2,#0x20	; 037FF8C2
	bge loc_037FF8FA	; 037FF8C4
	mov r0,#0x0	; 037FF8C6
	mvn r0,r0	; 037FF8C8
	add r1,r0,#0x0	; 037FF8CA
	mov r3,#0x20	; 037FF8CC
	sub r2,r3,r2	; 037FF8CE
	bl loc_037FF93C	; 037FF8D0
	add r2,r5,#0x0	; 037FF8D4
	and r2,r1	; 037FF8D6
	add r1,r6,#0x0	; 037FF8D8
	and r1,r0	; 037FF8DA
	mov r0,#0x0	; 037FF8DC
	eor r2,r0	; 037FF8DE
	eor r1,r0	; 037FF8E0
	orr r2,r1	; 037FF8E2
	beq loc_037FF8EA	; 037FF8E4
	ldr r0,[pool_037FF92C]	; 037FF8E6
	b loc_037FF91C	; 037FF8E8
loc_037FF8EA:
	add r0,r6,#0x0	; 037FF8EA
	add r1,r5,#0x0	; 037FF8EC
	sub r4,#0x10	; 037FF8EE
	add r2,r4,#0x0	; 037FF8F0
	bl loc_037FF93C	; 037FF8F2
	add r5,r1,#0x0	; 037FF8F6
	b loc_037FF8FE	; 037FF8F8
loc_037FF8FA:
	ldr r0,[pool_037FF92C]	; 037FF8FA
	b loc_037FF91C	; 037FF8FC
loc_037FF8FE:
	mov r2,#0x0	; 037FF8FE
	mov r1,#0x10	; 037FF900
	sub r1,r0,r1	; 037FF902
	lsl r1,r5,#0	; 037FF904
	sbc r1,r2	; 037FF906
	bcs loc_037FF90E	; 037FF908
	mov r0,#0x10	; 037FF90A
	b loc_037FF918	; 037FF90C
loc_037FF90E:
	ldr r1,[pool_037FF92C]	; 037FF90E
	sub r1,r1,r0	; 037FF910
	sbc r2,r5	; 037FF912
	bcs loc_037FF918	; 037FF914
	ldr r0,[pool_037FF92C]	; 037FF916
loc_037FF918:
	lsl r0,r0,#0x10	; 037FF918
	lsr r0,r0,#0x10	; 037FF91A
loc_037FF91C:
	pop {r4,r5,r6}	; 037FF91C
	pop {r3}	; 037FF91E
	bx r3	; 037FF920
	.byte 0xC0, 0x46	; 037FF924
pool_037FF924:
loc_037FF924:
	.word 0x00000300	; 037FF924
pool_037FF928:
loc_037FF928:
	.word 0x00010000	; 037FF928
pool_037FF92C:
loc_037FF92C:
	.word 0x0000FFFF	; 037FF92C

; ===== function loc_037FF930 =====
loc_037FF930:
	bx pc	; 037FF930
	.byte 0xC0, 0x46	; 037FF934
.arm

; ===== function loc_037FF934 =====
loc_037FF934:
	ldr pc,[pool_037FF938]	; 037FF934
pool_037FF938:
loc_037FF938:
	.word loc_03804F9C	; 037FF938
.thumb

; ===== function loc_037FF93C =====
loc_037FF93C:
	bx pc	; 037FF93C
	.byte 0xC0, 0x46	; 037FF940
.arm

; ===== function loc_037FF940 =====
loc_037FF940:
	ldr pc,[pool_037FF944]	; 037FF940
pool_037FF944:
loc_037FF944:
	.word loc_03804B7C	; 037FF944
.thumb
P2_ThreadEntry_037FF948:
	push {r4,r5,r6,lr}	; 037FF948
	bl P2_Entry_037FFA48	; 037FF94A
	bl P2_Entry_0380048C	; 037FF94E
	bl P2_Entry_03801564	; 037FF952
	bl P2_Entry_03801914	; 037FF956
	bl P2_Entry_037FF4C4	; 037FF95A
	mov r0,#0x0	; 037FF95E
	add r1,r0,#0x0	; 037FF960
	add r2,r0,#0x0	; 037FF962
	add r3,r0,#0x0	; 037FF964
	bl loc_037FF40C	; 037FF966
	mov r0,#0x7f	; 037FF96A
	bl loc_037FF440	; 037FF96C
	bl P2_Entry_037FFA08	; 037FF970
	mov r6,#0x1	; 037FF974
	mov r4,#0x0	; 037FF976
P2_Entry_037FF978:
	add r5,r4,#0x0	; 037FF978
	bl P2_Entry_037FF9EC	; 037FF97A
	cmp r0,#0x1	; 037FF97E
	beq P2_Entry_037FF986	; 037FF980
	cmp r0,#0x2	; 037FF982
	b P2_Entry_037FF988	; 037FF984
P2_Entry_037FF986:
	add r5,r6,#0x0	; 037FF986
P2_Entry_037FF988:
	bl P2_Entry_0380034C	; 037FF988
	bl P2_Entry_03801B74	; 037FF98C
	add r0,r5,#0x0	; 037FF990
	bl P2_Entry_03801508	; 037FF992
	add r0,r5,#0x0	; 037FF996
	bl P2_Entry_0380015C	; 037FF998
	bl loc_03801758	; 037FF99C
	bl loc_037FF7BC	; 037FF9A0
	b P2_Entry_037FF978	; 037FF9A4
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xA9, 0xFC	; 037FF9A6
	.byte 0x00, 0x28, 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0x66, 0xFB, 0x01, 0xB0	; 037FF9B6
	.byte 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x28, 0x5A, 0x80, 0x03, 0xE8, 0x52, 0x80, 0x03, 0xE0, 0x52	; 037FF9C6
	.byte 0x80, 0x03	; 037FF9D6
.arm
.thumb

; ===== function loc_037FF9D8 =====
loc_037FF9D8:
	ldr r0,[pool_037FF9E4]	; 037FF9D8
	mov r1,#0x2	; 037FF9DA
	mov r2,#0x0	; 037FF9DC
	ldr r3,[pool_037FF9E8]	; 037FF9DE
	bx r3	; 037FF9E0
	.byte 0xC0, 0x46	; 037FF9E4
pool_037FF9E4:
loc_037FF9E4:
	.word 0x03805A28	; 037FF9E4
pool_037FF9E8:
loc_037FF9E8:
	.word loc_037FE308 + 1	; 037FF9E8

; ===== function loc_037FF9EC =====
P2_Entry_037FF9EC:
	push {lr}	; 037FF9EC
	sub sp,#0x4	; 037FF9EE
	ldr r0,[pool_037FFA04]	; 037FF9F0
	add r1,sp,#0x0	; 037FF9F2
	mov r2,#0x1	; 037FF9F4
	bl loc_037FE290	; 037FF9F6
	ldr r0,[sp,#0x0]	; 037FF9FA
	add sp,#0x4	; 037FF9FC
	pop {r3}	; 037FF9FE
	bx r3	; 037FFA00
	.byte 0xC0, 0x46	; 037FFA04
pool_037FFA04:
loc_037FFA04:
	.word 0x03805A28	; 037FFA04
P2_Entry_037FFA08:
	push {r4,r5,lr}	; 037FFA08
	sub sp,#0xc	; 037FFA0A
	bl loc_037FE870	; 037FFA0C
	add r4,r0,#0x0	; 037FFA10
	ldr r0,[pool_037FFA38]	; 037FFA12
	str r0,[sp,#0x4]	; 037FFA14
	mov r5,#0x0	; 037FFA16
	str r5,[sp,#0x8]	; 037FFA18
	ldr r3,[pool_037FFA3C]	; 037FFA1A
	str r5,[sp,#0x0]	; 037FFA1C
	ldr r0,[pool_037FFA40]	; 037FFA1E
	ldr r2,[pool_037FFA44]	; 037FFA20
	add r4,r4,r2	; 037FFA22
	lsl r2,r1,#0	; 037FFA24
	adc r2,r5	; 037FFA26
	add r1,r4,#0x0	; 037FFA28
	bl loc_037FEAC0	; 037FFA2A
	add sp,#0xc	; 037FFA2E
	pop {r4,r5}	; 037FFA30
	pop {r3}	; 037FFA32
	bx r3	; 037FFA34
	.byte 0xC0, 0x46	; 037FFA36
pool_037FFA38:
	.word 0x037FF9A9	; 037FFA38
pool_037FFA3C:
	.word 0x00000AA8	; 037FFA3C
pool_037FFA40:
	.word 0x03805A5C	; 037FFA40
pool_037FFA44:
	.word 0x00010000	; 037FFA44
P2_Entry_037FFA48:
	push {lr}	; 037FFA48
	sub sp,#0x4	; 037FFA4A
	ldr r0,[pool_037FFA64]	; 037FFA4C
	ldr r1,[pool_037FFA68]	; 037FFA4E
	mov r2,#0x8	; 037FFA50
	bl loc_037FE364	; 037FFA52
	ldr r0,[pool_037FFA6C]	; 037FFA56
	bl loc_037FEC3C	; 037FFA58
	add sp,#0x4	; 037FFA5C
	pop {r3}	; 037FFA5E
	bx r3	; 037FFA60
	.byte 0xC0, 0x46	; 037FFA62
pool_037FFA64:
	.word 0x03805A28	; 037FFA64
pool_037FFA68:
	.word 0x03805A3C	; 037FFA68
pool_037FFA6C:
	.word 0x03805A5C	; 037FFA6C

; ===== function loc_037FFA70 =====
loc_037FFA70:
	push {lr}	; 037FFA70
	sub sp,#0xc	; 037FFA72
	ldr r1,[pool_037FFA94]	; 037FFA74
	str r1,[sp,#0x0]	; 037FFA76
	str r0,[sp,#0x4]	; 037FFA78
	ldr r0,[pool_037FFA98]	; 037FFA7A
	ldr r1,[pool_037FFA9C]	; 037FFA7C
	mov r2,#0x0	; 037FFA7E
	ldr r3,[pool_037FFAA0]	; 037FFA80
	bl P2_CreateThread	; 037FFA82
	ldr r0,[pool_037FFA98]	; 037FFA86
	bl loc_037FDEE8	; 037FFA88
	add sp,#0xc	; 037FFA8C
	pop {r3}	; 037FFA8E
	bx r3	; 037FFA90
	.byte 0xC0, 0x46	; 037FFA94
pool_037FFA94:
loc_037FFA94:
	.word 0x00000400	; 037FFA94
pool_037FFA98:
loc_037FFA98:
	.word 0x03805A88	; 037FFA98
pool_037FFA9C:
loc_037FFA9C:
	.word P2_ThreadEntry_037FF948 + 1	; 037FFA9C
pool_037FFAA0:
loc_037FFAA0:
	.word 0x03805F00	; 037FFAA0

; ===== function loc_037FFAA4 =====
loc_037FFAA4:
	push {r4,lr}	; 037FFAA4
	add r4,r0,#0x0	; 037FFAA6
	bl loc_03801E2C	; 037FFAA8
	add r0,r4,#0x0	; 037FFAAC
	bl loc_037FFA70	; 037FFAAE
	pop {r4}	; 037FFAB2
	pop {r3}	; 037FFAB4
	bx r3	; 037FFAB6

; ===== function loc_037FFAB8 =====
loc_037FFAB8:
	ldr r1,[pool_037FFACC]	; 037FFAB8
	ldrb r1,[r0,r1]	; 037FFABA
	mov r0,#0x80	; 037FFABC
	and r1,r0	; 037FFABE
	cmp r1,#0x0	; 037FFAC0
	beq loc_037FFAC8	; 037FFAC2
	mov r0,#0x1	; 037FFAC4
	bx lr	; 037FFAC6
loc_037FFAC8:
	mov r0,#0x0	; 037FFAC8
	bx lr	; 037FFACA
pool_037FFACC:
loc_037FFACC:
	.word REG_SNDCAP0CNT	; 037FFACC

; ===== function loc_037FFAD0 =====
loc_037FFAD0:
	push {r4,r5,r6,r7,lr}	; 037FFAD0
	sub sp,#0x4	; 037FFAD2
	add r4,r0,#0x0	; 037FFAD4
	add r0,r2,#0x0	; 037FFAD6
	add r6,r3,#0x0	; 037FFAD8
	lsl r3,r4,#0x3	; 037FFADA
	ldr r2,[sp,#0x18]	; 037FFADC
	cmp r2,#0x0	; 037FFADE
	beq loc_037FFAE6	; 037FFAE0
	mov r5,#0x0	; 037FFAE2
	b loc_037FFAE8	; 037FFAE4
loc_037FFAE6:
	mov r5,#0x1	; 037FFAE6
loc_037FFAE8:
	ldr r2,[sp,#0x20]	; 037FFAE8
	ldr r7,[sp,#0x1c]	; 037FFAEA
	lsl r7,r7,#0x1	; 037FFAEC
	lsl r1,r1,#0x3	; 037FFAEE
	lsl r5,r5,#0x2	; 037FFAF0
	orr r1,r5	; 037FFAF2
	orr r7,r1	; 037FFAF4
	orr r2,r7	; 037FFAF6
	ldr r1,[pool_037FFB0C]	; 037FFAF8
	strb r2,[r4,r1]	; 037FFAFA
	ldr r1,[pool_037FFB10]	; 037FFAFC
	str r0,[r3,r1]	; 037FFAFE
	ldr r0,[pool_037FFB14]	; 037FFB00
	strh r6,[r3,r0]	; 037FFB02
	add sp,#0x4	; 037FFB04
	pop {r4,r5,r6,r7}	; 037FFB06
	pop {r3}	; 037FFB08
	bx r3	; 037FFB0A
pool_037FFB0C:
loc_037FFB0C:
	.word REG_SNDCAP0CNT	; 037FFB0C
pool_037FFB10:
loc_037FFB10:
	.word REG_SNDCAP0DAD	; 037FFB10
pool_037FFB14:
loc_037FFB14:
	.word REG_SNDCAP0LEN	; 037FFB14

; ===== function loc_037FFB18 =====
loc_037FFB18:
	push {r4,r5,r6,r7,lr}	; 037FFB18
	sub sp,#0x4	; 037FFB1A
	add r5,r0,#0x0	; 037FFB1C
	add r6,r1,#0x0	; 037FFB1E
	add r0,#0x28	; 037FFB20
	bl loc_037FFD70	; 037FFB22
	add r4,r0,#0x0	; 037FFB26
	asr r3,r4,#0x1f	; 037FFB28
	mov r2,#0x0	; 037FFB2A
	add r1,r3,#0x0	; 037FFB2C
	eor r1,r2	; 037FFB2E
	add r7,r4,#0x0	; 037FFB30
	eor r7,r2	; 037FFB32
	orr r1,r7	; 037FFB34
	beq loc_037FFB74	; 037FFB36
	add r1,r5,#0x0	; 037FFB38
	add r1,#0x28	; 037FFB3A
	ldrb r1,[r1,#0x0]	; 037FFB3C
	cmp r1,#0x0	; 037FFB3E
	beq loc_037FFB5C	; 037FFB40
	cmp r1,#0x1	; 037FFB42
	beq loc_037FFB4C	; 037FFB44
	cmp r1,#0x2	; 037FFB46
	beq loc_037FFB66	; 037FFB48
	b loc_037FFB6E	; 037FFB4A
loc_037FFB4C:
	add r1,r3,#0x0	; 037FFB4C
	mov r2,#0x3c	; 037FFB4E
	mov r3,#0x0	; 037FFB50
	bl loc_037FFB8C	; 037FFB52
	add r4,r0,#0x0	; 037FFB56
	add r3,r1,#0x0	; 037FFB58
	b loc_037FFB6E	; 037FFB5A
loc_037FFB5C:
	lsr r0,r4,#0x1a	; 037FFB5C
	lsl r3,r3,#0x6	; 037FFB5E
	orr r3,r0	; 037FFB60
	lsl r4,r4,#0x6	; 037FFB62
	b loc_037FFB6E	; 037FFB64
loc_037FFB66:
	lsr r0,r4,#0x1a	; 037FFB66
	lsl r3,r3,#0x6	; 037FFB68
	orr r3,r0	; 037FFB6A
	lsl r4,r4,#0x6	; 037FFB6C
loc_037FFB6E:
	lsl r0,r3,#0x12	; 037FFB6E
	lsr r4,r4,#0xe	; 037FFB70
	orr r4,r0	; 037FFB72
loc_037FFB74:
	cmp r6,#0x0	; 037FFB74
	beq loc_037FFB80	; 037FFB76
	add r5,#0x28	; 037FFB78
	add r0,r5,#0x0	; 037FFB7A
	bl loc_037FFDA4	; 037FFB7C
loc_037FFB80:
	add r0,r4,#0x0	; 037FFB80
	add sp,#0x4	; 037FFB82
	pop {r4,r5,r6,r7}	; 037FFB84
	pop {r3}	; 037FFB86
	bx r3	; 037FFB88
	.byte 0xC0, 0x46	; 037FFB8C

; ===== function loc_037FFB8C =====
loc_037FFB8C:
	bx pc	; 037FFB8C
	.byte 0xC0, 0x46	; 037FFB90
.arm

; ===== function loc_037FFB90 =====
loc_037FFB90:
	ldr pc,[pool_037FFB94]	; 037FFB90
pool_037FFB94:
loc_037FFB94:
	.word loc_03804B5C	; 037FFB94
.thumb

; ===== function loc_037FFB98 =====
loc_037FFB98:
	push {r4,r5,r6,lr}	; 037FFB98
	add r5,r0,#0x0	; 037FFB9A
	add r6,r1,#0x0	; 037FFB9C
	mov r0,#0x32	; 037FFB9E
	ldrsh r0,[r5,r0]	; 037FFBA0
	cmp r0,#0x0	; 037FFBA2
	bne loc_037FFBAA	; 037FFBA4
	mov r0,#0x0	; 037FFBA6
	b loc_037FFBD4	; 037FFBA8
loc_037FFBAA:
	ldr r2,[r5,#0x14]	; 037FFBAA
	ldr r4,[r5,#0x18]	; 037FFBAC
	cmp r2,r4	; 037FFBAE
	blt loc_037FFBB6	; 037FFBB0
	mov r0,#0x0	; 037FFBB2
	b loc_037FFBD4	; 037FFBB4
loc_037FFBB6:
	asr r1,r0,#0x1f	; 037FFBB6
	sub r2,r4,r2	; 037FFBB8
	asr r3,r2,#0x1f	; 037FFBBA
	bl loc_037FFB8C	; 037FFBBC
	asr r3,r4,#0x1f	; 037FFBC0
	add r2,r4,#0x0	; 037FFBC2
	bl loc_037FFBDC	; 037FFBC4
	cmp r6,#0x0	; 037FFBC8
	beq loc_037FFBD4	; 037FFBCA
	add r5,#0x14	; 037FFBCC
	ldr r1,[r5,#0x0]	; 037FFBCE
	add r1,r1,#0x1	; 037FFBD0
	str r1,[r5,#0x0]	; 037FFBD2
loc_037FFBD4:
	pop {r4,r5,r6}	; 037FFBD4
	pop {r3}	; 037FFBD6
	bx r3	; 037FFBD8
	.byte 0xC0, 0x46	; 037FFBDC

; ===== function loc_037FFBDC =====
loc_037FFBDC:
	bx pc	; 037FFBDC
	.byte 0xC0, 0x46	; 037FFBE0
.arm

; ===== function loc_037FFBE0 =====
loc_037FFBE0:
	ldr pc,[pool_037FFBE4]	; 037FFBE0
pool_037FFBE4:
loc_037FFBE4:
	.word loc_038049AC	; 037FFBE4
.thumb

; ===== function loc_037FFBE8 =====
loc_037FFBE8:
	push {r4,lr}	; 037FFBE8
	cmp r1,#0x0	; 037FFBEA
	beq loc_037FFC54	; 037FFBEC
	ldrb r1,[r0,#0x2]	; 037FFBEE
	cmp r1,#0x3	; 037FFBF0
	bhi loc_037FFC54	; 037FFBF2
	add r1,r1,r1	; 037FFBF4
P2_SwitchIndexPC_037FFBF4:
	add r1,pc	; 037FFBF6
	ldrh r1,[r1,#(P2_SwitchTable_037FFBF4 - (P2_SwitchIndexPC_037FFBF4 + 4))]	; 037FFBF8
	lsl r1,r1,#0x10	; 037FFBFA
	asr r1,r1,#0x10	; 037FFBFC
P2_SwitchTargetPC_037FFBF4:
	add r1,pc	; 037FFBFE
	bx r1	; 037FFC00
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FFBF4:
	.halfword (loc_037FFC0A + 1) - (P2_SwitchTargetPC_037FFBF4 + 4)
	.halfword (loc_037FFC24 + 1) - (P2_SwitchTargetPC_037FFBF4 + 4)
	.halfword (loc_037FFC54 + 1) - (P2_SwitchTargetPC_037FFBF4 + 4)
	.halfword (loc_037FFC48 + 1) - (P2_SwitchTargetPC_037FFBF4 + 4)
P2_SwitchTable_037FFBF4End:
loc_037FFC0A:
	ldr r1,[r0,#0x10]	; 037FFC0A
	neg r2,r1	; 037FFC0C
	ldrb r1,[r0,#0x1c]	; 037FFC0E
	mul r2,r1	; 037FFC10
	asr r1,r2,#0x8	; 037FFC12
	neg r1,r1	; 037FFC14
	str r1,[r0,#0x10]	; 037FFC16
	ldr r1,[r0,#0x10]	; 037FFC18
	cmp r1,#0x0	; 037FFC1A
	bne loc_037FFC54	; 037FFC1C
	mov r1,#0x1	; 037FFC1E
	strb r1,[r0,#0x2]	; 037FFC20
	b loc_037FFC54	; 037FFC22
loc_037FFC24:
	ldrb r1,[r0,#0x1d]	; 037FFC24
	lsl r2,r1,#0x1	; 037FFC26
	ldr r1,[pool_037FFC60]	; 037FFC28
	ldrsh r1,[r1,r2]	; 037FFC2A
	lsl r4,r1,#0x7	; 037FFC2C
	add r3,r0,#0x0	; 037FFC2E
	add r3,#0x10	; 037FFC30
	ldr r2,[r3,#0x0]	; 037FFC32
	ldrh r1,[r0,#0x1e]	; 037FFC34
	sub r1,r2,r1	; 037FFC36
	str r1,[r3,#0x0]	; 037FFC38
	ldr r1,[r0,#0x10]	; 037FFC3A
	cmp r1,r4	; 037FFC3C
	bgt loc_037FFC54	; 037FFC3E
	str r4,[r0,#0x10]	; 037FFC40
	mov r1,#0x2	; 037FFC42
	strb r1,[r0,#0x2]	; 037FFC44
	b loc_037FFC54	; 037FFC46
loc_037FFC48:
	add r3,r0,#0x0	; 037FFC48
	add r3,#0x10	; 037FFC4A
	ldr r2,[r3,#0x0]	; 037FFC4C
	ldrh r1,[r0,#0x20]	; 037FFC4E
	sub r1,r2,r1	; 037FFC50
	str r1,[r3,#0x0]	; 037FFC52
loc_037FFC54:
	ldr r0,[r0,#0x10]	; 037FFC54
	asr r0,r0,#0x7	; 037FFC56
	pop {r4}	; 037FFC58
	pop {r3}	; 037FFC5A
	bx r3	; 037FFC5C
	.byte 0xC0, 0x46	; 037FFC60
pool_037FFC60:
loc_037FFC60:
	.word P2_Data_03805128	; 037FFC60

; ===== function loc_037FFC64 =====
loc_037FFC64:
	push {r4,r5,lr}	; 037FFC64
	sub sp,#0x4	; 037FFC66
	ldrh r5,[r0,#0x24]	; 037FFC68
	mov r0,#0xff	; 037FFC6A
	add r2,r5,#0x0	; 037FFC6C
	and r2,r0	; 037FFC6E
	ldrh r4,[r1,#0x24]	; 037FFC70
	add r1,r4,#0x0	; 037FFC72
	and r1,r0	; 037FFC74
	lsl r3,r2,#0x4	; 037FFC76
	lsl r2,r1,#0x4	; 037FFC78
	asr r0,r5,#0x8	; 037FFC7A
	ldr r1,[pool_037FFCA4]	; 037FFC7C
	ldrb r0,[r1,r0]	; 037FFC7E
	asr r3,r0	; 037FFC80
	asr r0,r4,#0x8	; 037FFC82
	ldrb r0,[r1,r0]	; 037FFC84
	asr r2,r0	; 037FFC86
	cmp r3,r2	; 037FFC88
	beq loc_037FFC9A	; 037FFC8A
	cmp r3,r2	; 037FFC8C
	bge loc_037FFC94	; 037FFC8E
	mov r0,#0x1	; 037FFC90
	b loc_037FFC9C	; 037FFC92
loc_037FFC94:
	mov r0,#0x0	; 037FFC94
	mvn r0,r0	; 037FFC96
	b loc_037FFC9C	; 037FFC98
loc_037FFC9A:
	mov r0,#0x0	; 037FFC9A
loc_037FFC9C:
	add sp,#0x4	; 037FFC9C
	pop {r4,r5}	; 037FFC9E
	pop {r3}	; 037FFCA0
	bx r3	; 037FFCA2
pool_037FFCA4:
loc_037FFCA4:
	.word P2_Data_03805228	; 037FFCA4

; ===== function loc_037FFCA8 =====
loc_037FFCA8:
	push {lr}	; 037FFCA8
	sub sp,#0x4	; 037FFCAA
	add r2,r0,#0x0	; 037FFCAC
	cmp r2,#0x7f	; 037FFCAE
	bne loc_037FFCB6	; 037FFCB0
	ldr r0,[pool_037FFCE0]	; 037FFCB2
	b loc_037FFCDA	; 037FFCB4
loc_037FFCB6:
	cmp r2,#0x7e	; 037FFCB6
	bne loc_037FFCBE	; 037FFCB8
	ldr r0,[pool_037FFCE4]	; 037FFCBA
	b loc_037FFCDA	; 037FFCBC
loc_037FFCBE:
	cmp r2,#0x32	; 037FFCBE
	bge loc_037FFCCC	; 037FFCC0
	lsl r0,r2,#0x1	; 037FFCC2
	add r0,r0,#0x1	; 037FFCC4
	lsl r0,r0,#0x10	; 037FFCC6
	lsr r0,r0,#0x10	; 037FFCC8
	b loc_037FFCDA	; 037FFCCA
loc_037FFCCC:
	ldr r0,[pool_037FFCE8]	; 037FFCCC
	mov r1,#0x7e	; 037FFCCE
	sub r1,r1,r2	; 037FFCD0
	bl loc_037FE2FC	; 037FFCD2
	lsl r0,r0,#0x10	; 037FFCD6
	lsr r0,r0,#0x10	; 037FFCD8
loc_037FFCDA:
	add sp,#0x4	; 037FFCDA
	pop {r3}	; 037FFCDC
	bx r3	; 037FFCDE
pool_037FFCE0:
loc_037FFCE0:
	.word 0x0000FFFF	; 037FFCE0
pool_037FFCE4:
loc_037FFCE4:
	.word 0x00003C00	; 037FFCE4
pool_037FFCE8:
loc_037FFCE8:
	.word 0x00001E00	; 037FFCE8

; ===== function loc_037FFCEC =====
loc_037FFCEC:
	push {r4,lr}	; 037FFCEC
	add r4,r0,#0x0	; 037FFCEE
	ldr r0,[pool_037FFD1C]	; 037FFCF0
	str r0,[r4,#0x10]	; 037FFCF2
	mov r0,#0x0	; 037FFCF4
	strb r0,[r4,#0x2]	; 037FFCF6
	str r1,[r4,#0x34]	; 037FFCF8
	add r0,r4,#0x0	; 037FFCFA
	add r0,#0x28	; 037FFCFC
	bl loc_037FFDE8	; 037FFCFE
	add r2,r4,#0x3	; 037FFD02
	ldrb r1,[r2,#0x0]	; 037FFD04
	mov r0,#0x2	; 037FFD06
	orr r1,r0	; 037FFD08
	strb r1,[r2,#0x0]	; 037FFD0A
	ldrb r1,[r2,#0x0]	; 037FFD0C
	mov r0,#0x1	; 037FFD0E
	bic r1,r0	; 037FFD10
	orr r1,r0	; 037FFD12
	strb r1,[r2,#0x0]	; 037FFD14
	pop {r4}	; 037FFD16
	pop {r3}	; 037FFD18
	bx r3	; 037FFD1A
pool_037FFD1C:
loc_037FFD1C:
	.word 0xFFFE9680	; 037FFD1C

; ===== function loc_037FFD20 =====
loc_037FFD20:
	push {r4,r5,lr}	; 037FFD20
	sub sp,#0x4	; 037FFD22
	mov r4,#0x0	; 037FFD24
	str r4,[r0,#0x50]	; 037FFD26
	str r1,[r0,#0x48]	; 037FFD28
	str r2,[r0,#0x4c]	; 037FFD2A
	str r4,[r0,#0x34]	; 037FFD2C
	add r1,r0,#0x0	; 037FFD2E
	add r1,#0x22	; 037FFD30
	strb r3,[r1,#0x0]	; 037FFD32
	mov r5,#0x7f	; 037FFD34
	strh r5,[r0,#0x24]	; 037FFD36
	add r3,r0,#0x3	; 037FFD38
	ldrb r2,[r3,#0x0]	; 037FFD3A
	mov r1,#0x2	; 037FFD3C
	bic r2,r1	; 037FFD3E
	strb r2,[r3,#0x0]	; 037FFD40
	mov r1,#0x3c	; 037FFD42
	strb r1,[r0,#0x8]	; 037FFD44
	strb r1,[r0,#0x5]	; 037FFD46
	strb r5,[r0,#0x9]	; 037FFD48
	strb r4,[r0,#0xa]	; 037FFD4A
	strh r4,[r0,#0xc]	; 037FFD4C
	strh r4,[r0,#0xe]	; 037FFD4E
	strb r4,[r0,#0xb]	; 037FFD50
	strh r4,[r0,#0x32]	; 037FFD52
	str r4,[r0,#0x18]	; 037FFD54
	str r4,[r0,#0x14]	; 037FFD56
	strb r5,[r0,#0x1c]	; 037FFD58
	strh r5,[r0,#0x1e]	; 037FFD5A
	strb r5,[r0,#0x1d]	; 037FFD5C
	strh r5,[r0,#0x20]	; 037FFD5E
	add r0,#0x28	; 037FFD60
	bl loc_037FFDF0	; 037FFD62
	add sp,#0x4	; 037FFD66
	pop {r4,r5}	; 037FFD68
	pop {r3}	; 037FFD6A
	bx r3	; 037FFD6C
	.byte 0x00, 0x00	; 037FFD70

; ===== function loc_037FFD70 =====
loc_037FFD70:
	push {r4,lr}	; 037FFD70
	add r4,r0,#0x0	; 037FFD72
	ldrb r0,[r4,#0x2]	; 037FFD74
	cmp r0,#0x0	; 037FFD76
	bne loc_037FFD7E	; 037FFD78
	mov r0,#0x0	; 037FFD7A
	b loc_037FFD9C	; 037FFD7C
loc_037FFD7E:
	ldrh r1,[r4,#0x6]	; 037FFD7E
	ldrh r0,[r4,#0x4]	; 037FFD80
	cmp r1,r0	; 037FFD82
	bcs loc_037FFD8A	; 037FFD84
	mov r2,#0x0	; 037FFD86
	b loc_037FFD9A	; 037FFD88
loc_037FFD8A:
	ldrh r0,[r4,#0x8]	; 037FFD8A
	lsr r0,r0,#0x8	; 037FFD8C
	bl loc_037FF7E0	; 037FFD8E
	ldrb r2,[r4,#0x3]	; 037FFD92
	ldrb r1,[r4,#0x2]	; 037FFD94
	mul r1,r0	; 037FFD96
	mul r2,r1	; 037FFD98
loc_037FFD9A:
	add r0,r2,#0x0	; 037FFD9A
loc_037FFD9C:
	pop {r4}	; 037FFD9C
	pop {r3}	; 037FFD9E
	bx r3	; 037FFDA0
	.byte 0x00, 0x00	; 037FFDA4

; ===== function loc_037FFDA4 =====
loc_037FFDA4:
	push {r4,lr}	; 037FFDA4
	ldrh r2,[r0,#0x6]	; 037FFDA6
	ldrh r1,[r0,#0x4]	; 037FFDA8
	cmp r2,r1	; 037FFDAA
	bcs loc_037FFDB8	; 037FFDAC
	add r1,r0,#0x6	; 037FFDAE
	ldrh r0,[r1,#0x0]	; 037FFDB0
	add r0,r0,#0x1	; 037FFDB2
	strh r0,[r1,#0x0]	; 037FFDB4
	b loc_037FFDE2	; 037FFDB6
loc_037FFDB8:
	ldrh r2,[r0,#0x8]	; 037FFDB8
	ldrb r1,[r0,#0x1]	; 037FFDBA
	lsl r3,r1,#0x6	; 037FFDBC
	add r1,r2,r3	; 037FFDBE
	lsr r4,r1,#0x8	; 037FFDC0
	b loc_037FFDC6	; 037FFDC2
loc_037FFDC4:
	sub r4,#0x80	; 037FFDC4
loc_037FFDC6:
	cmp r4,#0x80	; 037FFDC6
	bcs loc_037FFDC4	; 037FFDC8
	add r0,#0x8	; 037FFDCA
	ldrh r1,[r0,#0x0]	; 037FFDCC
	add r1,r1,r3	; 037FFDCE
	strh r1,[r0,#0x0]	; 037FFDD0
	ldrh r2,[r0,#0x0]	; 037FFDD2
	mov r1,#0xff	; 037FFDD4
	and r2,r1	; 037FFDD6
	strh r2,[r0,#0x0]	; 037FFDD8
	ldrh r2,[r0,#0x0]	; 037FFDDA
	lsl r1,r4,#0x8	; 037FFDDC
	orr r2,r1	; 037FFDDE
	strh r2,[r0,#0x0]	; 037FFDE0
loc_037FFDE2:
	pop {r4}	; 037FFDE2
	pop {r3}	; 037FFDE4
	bx r3	; 037FFDE6

; ===== function loc_037FFDE8 =====
loc_037FFDE8:
	mov r1,#0x0	; 037FFDE8
	strh r1,[r0,#0x8]	; 037FFDEA
	strh r1,[r0,#0x6]	; 037FFDEC
	bx lr	; 037FFDEE

; ===== function loc_037FFDF0 =====
loc_037FFDF0:
	mov r2,#0x0	; 037FFDF0
	strb r2,[r0,#0x0]	; 037FFDF2
	strb r2,[r0,#0x2]	; 037FFDF4
	mov r1,#0x1	; 037FFDF6
	strb r1,[r0,#0x3]	; 037FFDF8
	mov r1,#0x10	; 037FFDFA
	strb r1,[r0,#0x1]	; 037FFDFC
	strh r2,[r0,#0x4]	; 037FFDFE
	bx lr	; 037FFE00
	.byte 0x00, 0x00	; 037FFE04

; ===== function loc_037FFE04 =====
loc_037FFE04:
	push {r4,r5,r6,r7,lr}	; 037FFE04
	sub sp,#0x4	; 037FFE06
	add r5,r0,#0x0	; 037FFE08
	add r6,r1,#0x0	; 037FFE0A
	mov r4,#0x0	; 037FFE0C
	add r7,r4,#0x0	; 037FFE0E
loc_037FFE10:
	add r1,r4,#0x0	; 037FFE10
	mov r0,#0x54	; 037FFE12
	mul r1,r0	; 037FFE14
	ldr r0,[pool_037FFE50]	; 037FFE16
	add r1,r0,r1	; 037FFE18
	ldrb r0,[r1,#0x1]	; 037FFE1A
	cmp r0,#0x0	; 037FFE1C
	bne loc_037FFE3C	; 037FFE1E
	ldr r0,[r1,#0x44]	; 037FFE20
	cmp r5,r0	; 037FFE22
	bhi loc_037FFE3C	; 037FFE24
	cmp r0,r6	; 037FFE26
	bhi loc_037FFE3C	; 037FFE28
	add r2,r1,#0x3	; 037FFE2A
	ldrb r1,[r2,#0x0]	; 037FFE2C
	mov r0,#0x2	; 037FFE2E
	bic r1,r0	; 037FFE30
	strb r1,[r2,#0x0]	; 037FFE32
	add r0,r4,#0x0	; 037FFE34
	add r1,r7,#0x0	; 037FFE36
	bl loc_037FF630	; 037FFE38
loc_037FFE3C:
	add r0,r4,#0x1	; 037FFE3C
	lsl r0,r0,#0x18	; 037FFE3E
	lsr r4,r0,#0x18	; 037FFE40
	cmp r4,#0x10	; 037FFE42
	bcc loc_037FFE10	; 037FFE44
	add sp,#0x4	; 037FFE46
	pop {r4,r5,r6,r7}	; 037FFE48
	pop {r3}	; 037FFE4A
	bx r3	; 037FFE4C
	.byte 0xC0, 0x46	; 037FFE50
pool_037FFE50:
loc_037FFE50:
	.word 0x03805F24	; 037FFE50

; ===== function loc_037FFE54 =====
loc_037FFE54:
	mov r2,#0x1	; 037FFE54
	and r1,r2	; 037FFE56
	cmp r1,#0x0	; 037FFE58
	beq loc_037FFE66	; 037FFE5A
	ldr r1,[pool_037FFE70]	; 037FFE5C
	ldr r2,[r1,#0x0]	; 037FFE5E
	bic r2,r0	; 037FFE60
	str r2,[r1,#0x0]	; 037FFE62
	bx lr	; 037FFE64
loc_037FFE66:
	ldr r1,[pool_037FFE74]	; 037FFE66
	ldr r2,[r1,#0x0]	; 037FFE68
	bic r2,r0	; 037FFE6A
	str r2,[r1,#0x0]	; 037FFE6C
	bx lr	; 037FFE6E
pool_037FFE70:
loc_037FFE70:
	.word P2_BssStart + 0xB60	; 037FFE70
pool_037FFE74:
loc_037FFE74:
	.word P2_BssStart + 0xB64	; 037FFE74

; ===== function loc_037FFE78 =====
loc_037FFE78:
	push {r4,r5,r6,r7,lr}	; 037FFE78
	sub sp,#0x14	; 037FFE7A
	add r7,r0,#0x0	; 037FFE7C
	str r1,[sp,#0x0]	; 037FFE7E
	add r6,r7,#0x0	; 037FFE80
	mov r4,#0x0	; 037FFE82
	str r4,[sp,#0x4]	; 037FFE84
	str r4,[sp,#0x8]	; 037FFE86
	str r4,[sp,#0xc]	; 037FFE88
	str r4,[sp,#0x10]	; 037FFE8A
	b loc_037FFEE8	; 037FFE8C
loc_037FFE8E:
	add r1,r6,#0x0	; 037FFE8E
	mov r0,#0x1	; 037FFE90
	and r1,r0	; 037FFE92
	cmp r1,#0x0	; 037FFE94
	beq loc_037FFEE4	; 037FFE96
	add r1,r4,#0x0	; 037FFE98
	mov r0,#0x54	; 037FFE9A
	mul r1,r0	; 037FFE9C
	ldr r0,[pool_037FFF18]	; 037FFE9E
	add r5,r0,r1	; 037FFEA0
	ldr r0,[pool_037FFF1C]	; 037FFEA2
	ldr r1,[r0,#0x0]	; 037FFEA4
	mov r0,#0x1	; 037FFEA6
	lsl r0,r4	; 037FFEA8
	and r1,r0	; 037FFEAA
	cmp r1,#0x0	; 037FFEAC
	bne loc_037FFEE4	; 037FFEAE
	ldr r3,[r5,#0x48]	; 037FFEB0
	cmp r3,#0x0	; 037FFEB2
	beq loc_037FFEC0	; 037FFEB4
	add r0,r5,#0x0	; 037FFEB6
	ldr r1,[sp,#0x4]	; 037FFEB8
	ldr r2,[r5,#0x4c]	; 037FFEBA
	bl loc_03805098	; 037FFEBC
loc_037FFEC0:
	add r0,r4,#0x0	; 037FFEC0
	ldr r1,[sp,#0x8]	; 037FFEC2
	bl loc_037FF630	; 037FFEC4
	add r1,r5,#0x0	; 037FFEC8
	add r1,#0x22	; 037FFECA
	ldr r0,[sp,#0xc]	; 037FFECC
	strb r0,[r1,#0x0]	; 037FFECE
	add r0,r5,#0x0	; 037FFED0
	bl loc_037FFFA8	; 037FFED2
	ldr r0,[sp,#0x10]	; 037FFED6
	strb r0,[r5,#0x4]	; 037FFED8
	add r2,r5,#0x3	; 037FFEDA
	ldrb r1,[r2,#0x0]	; 037FFEDC
	mov r0,#0x1	; 037FFEDE
	bic r1,r0	; 037FFEE0
	strb r1,[r2,#0x0]	; 037FFEE2
loc_037FFEE4:
	add r4,r4,#0x1	; 037FFEE4
	lsr r6,r6,#0x1	; 037FFEE6
loc_037FFEE8:
	cmp r4,#0x10	; 037FFEE8
	bge loc_037FFEF0	; 037FFEEA
	cmp r6,#0x0	; 037FFEEC
	bne loc_037FFE8E	; 037FFEEE
loc_037FFEF0:
	mov r1,#0x1	; 037FFEF0
	ldr r0,[sp,#0x0]	; 037FFEF2
	and r0,r1	; 037FFEF4
	str r0,[sp,#0x0]	; 037FFEF6
	cmp r0,#0x0	; 037FFEF8
	beq loc_037FFF06	; 037FFEFA
	ldr r0,[pool_037FFF20]	; 037FFEFC
	ldr r1,[r0,#0x0]	; 037FFEFE
	orr r1,r7	; 037FFF00
	str r1,[r0,#0x0]	; 037FFF02
	b loc_037FFF0E	; 037FFF04
loc_037FFF06:
	ldr r0,[pool_037FFF1C]	; 037FFF06
	ldr r1,[r0,#0x0]	; 037FFF08
	orr r1,r7	; 037FFF0A
	str r1,[r0,#0x0]	; 037FFF0C
loc_037FFF0E:
	add sp,#0x14	; 037FFF0E
	pop {r4,r5,r6,r7}	; 037FFF10
	pop {r3}	; 037FFF12
	bx r3	; 037FFF14
	.byte 0xC0, 0x46	; 037FFF18
pool_037FFF18:
loc_037FFF18:
	.word 0x03805F24	; 037FFF18
pool_037FFF1C:
loc_037FFF1C:
	.word P2_BssStart + 0xB64	; 037FFF1C
pool_037FFF20:
loc_037FFF20:
	.word P2_BssStart + 0xB60	; 037FFF20

; ===== function loc_037FFF24 =====
loc_037FFF24:
	push {r4,r5,r6,r7,lr}	; 037FFF24
	sub sp,#0xc	; 037FFF26
	add r6,r0,#0x0	; 037FFF28
	mov r4,#0x0	; 037FFF2A
	str r4,[sp,#0x0]	; 037FFF2C
	str r4,[sp,#0x4]	; 037FFF2E
	add r7,r4,#0x0	; 037FFF30
	str r4,[sp,#0x8]	; 037FFF32
	b loc_037FFF8E	; 037FFF34
loc_037FFF36:
	add r1,r6,#0x0	; 037FFF36
	mov r0,#0x1	; 037FFF38
	and r1,r0	; 037FFF3A
	cmp r1,#0x0	; 037FFF3C
	beq loc_037FFF8A	; 037FFF3E
	add r1,r4,#0x0	; 037FFF40
	mov r0,#0x54	; 037FFF42
	mul r1,r0	; 037FFF44
	ldr r0,[pool_037FFFA0]	; 037FFF46
	add r5,r0,r1	; 037FFF48
	ldr r0,[pool_037FFFA4]	; 037FFF4A
	ldr r1,[r0,#0x0]	; 037FFF4C
	mov r0,#0x1	; 037FFF4E
	lsl r0,r4	; 037FFF50
	and r1,r0	; 037FFF52
	cmp r1,#0x0	; 037FFF54
	bne loc_037FFF8A	; 037FFF56
	ldr r3,[r5,#0x48]	; 037FFF58
	cmp r3,#0x0	; 037FFF5A
	beq loc_037FFF68	; 037FFF5C
	add r0,r5,#0x0	; 037FFF5E
	ldr r1,[sp,#0x0]	; 037FFF60
	ldr r2,[r5,#0x4c]	; 037FFF62
	bl loc_03805098	; 037FFF64
loc_037FFF68:
	add r0,r4,#0x0	; 037FFF68
	ldr r1,[sp,#0x4]	; 037FFF6A
	bl loc_037FF630	; 037FFF6C
	add r0,r5,#0x0	; 037FFF70
	add r0,#0x22	; 037FFF72
	strb r7,[r0,#0x0]	; 037FFF74
	add r0,r5,#0x0	; 037FFF76
	bl loc_037FFFA8	; 037FFF78
	ldr r0,[sp,#0x8]	; 037FFF7C
	strb r0,[r5,#0x4]	; 037FFF7E
	add r2,r5,#0x3	; 037FFF80
	ldrb r1,[r2,#0x0]	; 037FFF82
	mov r0,#0x1	; 037FFF84
	bic r1,r0	; 037FFF86
	strb r1,[r2,#0x0]	; 037FFF88
loc_037FFF8A:
	add r4,r4,#0x1	; 037FFF8A
	lsr r6,r6,#0x1	; 037FFF8C
loc_037FFF8E:
	cmp r4,#0x10	; 037FFF8E
	bge loc_037FFF96	; 037FFF90
	cmp r6,#0x0	; 037FFF92
	bne loc_037FFF36	; 037FFF94
loc_037FFF96:
	add sp,#0xc	; 037FFF96
	pop {r4,r5,r6,r7}	; 037FFF98
	pop {r3}	; 037FFF9A
	bx r3	; 037FFF9C
	.byte 0xC0, 0x46	; 037FFFA0
pool_037FFFA0:
loc_037FFFA0:
	.word 0x03805F24	; 037FFFA0
pool_037FFFA4:
loc_037FFFA4:
	.word P2_BssStart + 0xB64	; 037FFFA4

; ===== function loc_037FFFA8 =====
loc_037FFFA8:
	cmp r0,#0x0	; 037FFFA8
	beq loc_037FFFB2	; 037FFFAA
	mov r1,#0x0	; 037FFFAC
	str r1,[r0,#0x48]	; 037FFFAE
	str r1,[r0,#0x4c]	; 037FFFB0
loc_037FFFB2:
	bx lr	; 037FFFB2

; ===== function loc_037FFFB4 =====
P2_Entry_037FFFB4:
	push {r4,r5,r6,r7,lr}	; 037FFFB4
	sub sp,#0xc	; 037FFFB6
	add r5,r0,#0x0	; 037FFFB8
	str r1,[sp,#0x0]	; 037FFFBA
	str r3,[sp,#0x4]	; 037FFFBC
	ldr r0,[pool_03800068]	; 037FFFBE
	ldr r0,[r0,#0x0]	; 037FFFC0
	bic r5,r0	; 037FFFC2
	cmp r2,#0x0	; 037FFFC4
	bne loc_037FFFCE	; 037FFFC6
	ldr r0,[pool_0380006C]	; 037FFFC8
	ldr r0,[r0,#0x0]	; 037FFFCA
	bic r5,r0	; 037FFFCC
loc_037FFFCE:
	mov r4,#0x0	; 037FFFCE
	add r6,r4,#0x0	; 037FFFD0
loc_037FFFD2:
	ldr r0,[pool_03800070]	; 037FFFD2
	ldrb r0,[r0,r6]	; 037FFFD4
	mov r1,#0x1	; 037FFFD6
	lsl r1,r0	; 037FFFD8
	add r2,r5,#0x0	; 037FFFDA
	and r2,r1	; 037FFFDC
	cmp r2,#0x0	; 037FFFDE
	beq loc_03800014	; 037FFFE0
	mov r1,#0x54	; 037FFFE2
	mul r0,r1	; 037FFFE4
	ldr r1,[pool_03800074]	; 037FFFE6
	add r7,r1,r0	; 037FFFE8
	cmp r4,#0x0	; 037FFFEA
	bne loc_037FFFF2	; 037FFFEC
	add r4,r7,#0x0	; 037FFFEE
	b loc_03800014	; 037FFFF0
loc_037FFFF2:
	add r0,r4,#0x0	; 037FFFF2
	add r0,#0x22	; 037FFFF4
	ldrb r1,[r0,#0x0]	; 037FFFF6
	add r0,r7,#0x0	; 037FFFF8
	add r0,#0x22	; 037FFFFA
	ldrb r0,[r0,#0x0]	; 037FFFFC
	cmp r0,r1	; 037FFFFE
	bhi loc_03800014	; 03800000
	cmp r0,r1	; 03800002
	bne loc_03800012	; 03800004
	add r0,r4,#0x0	; 03800006
	add r1,r7,#0x0	; 03800008
	bl loc_037FFC64	; 0380000A
	cmp r0,#0x0	; 0380000E
	bge loc_03800014	; 03800010
loc_03800012:
	add r4,r7,#0x0	; 03800012
loc_03800014:
	add r6,r6,#0x1	; 03800014
	cmp r6,#0x10	; 03800016
	blt loc_037FFFD2	; 03800018
	cmp r4,#0x0	; 0380001A
	bne loc_03800022	; 0380001C
	mov r0,#0x0	; 0380001E
	b loc_0380005E	; 03800020
loc_03800022:
	add r0,r4,#0x0	; 03800022
	add r0,#0x22	; 03800024
	ldrb r1,[r0,#0x0]	; 03800026
	ldr r0,[sp,#0x0]	; 03800028
	cmp r0,r1	; 0380002A
	bge loc_03800032	; 0380002C
	mov r0,#0x0	; 0380002E
	b loc_0380005E	; 03800030
loc_03800032:
	ldr r3,[r4,#0x48]	; 03800032
	cmp r3,#0x0	; 03800034
	beq loc_03800042	; 03800036
	add r0,r4,#0x0	; 03800038
	mov r1,#0x0	; 0380003A
	ldr r2,[r4,#0x4c]	; 0380003C
	bl loc_03805098	; 0380003E
loc_03800042:
	mov r0,#0x2	; 03800042
	strb r0,[r4,#0x4]	; 03800044
	add r2,r4,#0x3	; 03800046
	ldrb r1,[r2,#0x0]	; 03800048
	mov r0,#0x1	; 0380004A
	bic r1,r0	; 0380004C
	strb r1,[r2,#0x0]	; 0380004E
	add r0,r4,#0x0	; 03800050
	ldr r1,[sp,#0x4]	; 03800052
	ldr r2,[sp,#0x20]	; 03800054
	ldr r3,[sp,#0x0]	; 03800056
	bl loc_037FFD20	; 03800058
	add r0,r4,#0x0	; 0380005C
loc_0380005E:
	add sp,#0xc	; 0380005E
	pop {r4,r5,r6,r7}	; 03800060
	pop {r3}	; 03800062
	bx r3	; 03800064
	.byte 0xC0, 0x46	; 03800068
pool_03800068:
loc_03800068:
	.word P2_BssStart + 0xB64	; 03800068
pool_0380006C:
loc_0380006C:
	.word P2_BssStart + 0xB60	; 0380006C
pool_03800070:
loc_03800070:
	.word P2_Data_0380522C	; 03800070
pool_03800074:
loc_03800074:
	.word 0x03805F24	; 03800074

; ===== function loc_03800078 =====
loc_03800078:
	ldrb r0,[r0,#0x3]	; 03800078
	lsl r0,r0,#0x1f	; 0380007A
	lsr r0,r0,#0x1f	; 0380007C
	bx lr	; 0380007E

; ===== function loc_03800080 =====
loc_03800080:
	mov r1,#0x3	; 03800080
	strb r1,[r0,#0x2]	; 03800082
	bx lr	; 03800084
	.byte 0x00, 0x00	; 03800088

; ===== function loc_03800088 =====
loc_03800088:
	push {r4,lr}	; 03800088
	add r4,r0,#0x0	; 0380008A
	add r0,r1,#0x0	; 0380008C
	bl loc_037FFCA8	; 0380008E
	strh r0,[r4,#0x20]	; 03800092
	pop {r4}	; 03800094
	pop {r3}	; 03800096
	bx r3	; 03800098
	.byte 0x00, 0x00	; 0380009C

; ===== function loc_0380009C =====
loc_0380009C:
	strb r1,[r0,#0x1d]	; 0380009C
	bx lr	; 0380009E

; ===== function loc_038000A0 =====
loc_038000A0:
	push {r4,lr}	; 038000A0
	add r4,r0,#0x0	; 038000A2
	add r0,r1,#0x0	; 038000A4
	bl loc_037FFCA8	; 038000A6
	strh r0,[r4,#0x1e]	; 038000AA
	pop {r4}	; 038000AC
	pop {r3}	; 038000AE
	bx r3	; 038000B0
	.byte 0x00, 0x00	; 038000B4

; ===== function loc_038000B4 =====
loc_038000B4:
	cmp r1,#0x6d	; 038000B4
	bge loc_038000C0	; 038000B6
	mov r2,#0xff	; 038000B8
	sub r1,r2,r1	; 038000BA
	strb r1,[r0,#0x1c]	; 038000BC
	bx lr	; 038000BE
loc_038000C0:
	mov r2,#0x7f	; 038000C0
	sub r2,r2,r1	; 038000C2
	ldr r1,[pool_038000CC]	; 038000C4
	ldrb r1,[r1,r2]	; 038000C6
	strb r1,[r0,#0x1c]	; 038000C8
	bx lr	; 038000CA
pool_038000CC:
loc_038000CC:
	.word P2_Data_0380523C	; 038000CC

; ===== function loc_038000D0 =====
loc_038000D0:
	push {lr}	; 038000D0
	sub sp,#0x4	; 038000D2
	ldrb r2,[r0,#0x0]	; 038000D4
	cmp r2,#0xe	; 038000D6
	bcs loc_038000DE	; 038000D8
	mov r0,#0x0	; 038000DA
	b loc_038000F4	; 038000DC
loc_038000DE:
	cmp r2,#0xf	; 038000DE
	bls loc_038000E6	; 038000E0
	mov r0,#0x0	; 038000E2
	b loc_038000F4	; 038000E4
loc_038000E6:
	mov r2,#0x2	; 038000E6
	strb r2,[r0,#0x1]	; 038000E8
	ldr r2,[pool_038000FC]	; 038000EA
	strh r2,[r0,#0x3c]	; 038000EC
	bl loc_037FFCEC	; 038000EE
	mov r0,#0x1	; 038000F2
loc_038000F4:
	add sp,#0x4	; 038000F4
	pop {r3}	; 038000F6
	bx r3	; 038000F8
	.byte 0xC0, 0x46	; 038000FC
pool_038000FC:
loc_038000FC:
	.word 0x00001F46	; 038000FC

; ===== function loc_03800100 =====
loc_03800100:
	push {lr}	; 03800100
	sub sp,#0x4	; 03800102
	ldrb r3,[r0,#0x0]	; 03800104
	cmp r3,#0x8	; 03800106
	bcs loc_0380010E	; 03800108
	mov r0,#0x0	; 0380010A
	b loc_03800128	; 0380010C
loc_0380010E:
	cmp r3,#0xd	; 0380010E
	bls loc_03800116	; 03800110
	mov r0,#0x0	; 03800112
	b loc_03800128	; 03800114
loc_03800116:
	mov r3,#0x1	; 03800116
	strb r3,[r0,#0x1]	; 03800118
	str r1,[r0,#0x44]	; 0380011A
	ldr r1,[pool_03800130]	; 0380011C
	strh r1,[r0,#0x3c]	; 0380011E
	add r1,r2,#0x0	; 03800120
	bl loc_037FFCEC	; 03800122
	mov r0,#0x1	; 03800126
loc_03800128:
	add sp,#0x4	; 03800128
	pop {r3}	; 0380012A
	bx r3	; 0380012C
	.byte 0xC0, 0x46	; 03800130
pool_03800130:
loc_03800130:
	.word 0x00001F46	; 03800130

; ===== function loc_03800134 =====
loc_03800134:
	push {r4,r5,r6,lr}	; 03800134
	add r6,r0,#0x0	; 03800136
	add r5,r1,#0x0	; 03800138
	mov r0,#0x0	; 0380013A
	strb r0,[r6,#0x1]	; 0380013C
	add r4,r6,#0x0	; 0380013E
	add r4,#0x38	; 03800140
	ldmia r5!,{r0,r1}	; 03800142
	stmia r4!,{r0,r1}	; 03800144
	ldr r0,[r5,#0x0]	; 03800146
	str r0,[r4,#0x0]	; 03800148
	str r2,[r6,#0x44]	; 0380014A
	add r0,r6,#0x0	; 0380014C
	add r1,r3,#0x0	; 0380014E
	bl loc_037FFCEC	; 03800150
	mov r0,#0x1	; 03800154
	pop {r4,r5,r6}	; 03800156
	pop {r3}	; 03800158
	bx r3	; 0380015A

; ===== function loc_0380015C =====
P2_Entry_0380015C:
	push {r4,r5,r6,r7,lr}	; 0380015C
	sub sp,#0x24	; 0380015E
	str r0,[sp,#0x0]	; 03800160
	mov r0,#0x0	; 03800162
	str r0,[sp,#0x4]	; 03800164
	str r0,[sp,#0xc]	; 03800166
	str r0,[sp,#0x14]	; 03800168
	str r0,[sp,#0x1c]	; 0380016A
	str r0,[sp,#0x18]	; 0380016C
	str r0,[sp,#0x10]	; 0380016E
	str r0,[sp,#0x8]	; 03800170
loc_03800172:
	ldr r6,[sp,#0x8]	; 03800172
	lsl r7,r6,#0	; 03800174
	lsl r4,r6,#0	; 03800176
	ldr r1,[sp,#0x4]	; 03800178
	mov r0,#0x54	; 0380017A
	mul r1,r0	; 0380017C
	ldr r0,[pool_0380033C]	; 0380017E
	add r5,r0,r1	; 03800180
	ldrb r0,[r5,#0x3]	; 03800182
	lsl r1,r0,#0x1f	; 03800184
	lsr r1,r1,#0x1f	; 03800186
	cmp r1,#0x0	; 03800188
	bne loc_0380018E	; 0380018A
	b loc_03800328	; 0380018C
loc_0380018E:
	lsl r0,r0,#0x1e	; 0380018E
	lsr r0,r0,#0x1f	; 03800190
	cmp r0,#0x0	; 03800192
	beq loc_038001AC	; 03800194
	add r2,r5,#0x4	; 03800196
	ldrb r1,[r2,#0x0]	; 03800198
	mov r0,#0x1	; 0380019A
	orr r1,r0	; 0380019C
	strb r1,[r2,#0x0]	; 0380019E
	add r2,r5,#0x3	; 038001A0
	ldrb r1,[r2,#0x0]	; 038001A2
	mov r0,#0x2	; 038001A4
	bic r1,r0	; 038001A6
	strb r1,[r2,#0x0]	; 038001A8
	b loc_038001E0	; 038001AA
loc_038001AC:
	ldr r0,[sp,#0x4]	; 038001AC
	bl loc_037FF564	; 038001AE
	cmp r0,#0x0	; 038001B2
	bne loc_038001E0	; 038001B4
	ldr r3,[r5,#0x48]	; 038001B6
	cmp r3,#0x0	; 038001B8
	beq loc_038001C8	; 038001BA
	add r0,r5,#0x0	; 038001BC
	mov r1,#0x2	; 038001BE
	ldr r2,[r5,#0x4c]	; 038001C0
	bl loc_03805098	; 038001C2
	b loc_038001D0	; 038001C6
loc_038001C8:
	add r1,r5,#0x0	; 038001C8
	add r1,#0x22	; 038001CA
	ldr r0,[sp,#0xc]	; 038001CC
	strb r0,[r1,#0x0]	; 038001CE
loc_038001D0:
	ldr r0,[sp,#0x10]	; 038001D0
	strh r0,[r5,#0x24]	; 038001D2
	add r2,r5,#0x3	; 038001D4
	ldrb r1,[r2,#0x0]	; 038001D6
	mov r0,#0x1	; 038001D8
	bic r1,r0	; 038001DA
	strb r1,[r2,#0x0]	; 038001DC
	b loc_03800328	; 038001DE
loc_038001E0:
	ldrb r0,[r5,#0x9]	; 038001E0
	lsl r1,r0,#0x1	; 038001E2
	ldr r0,[pool_03800340]	; 038001E4
	ldrsh r0,[r0,r1]	; 038001E6
	add r6,r6,r0	; 038001E8
	ldrb r1,[r5,#0x8]	; 038001EA
	ldrb r0,[r5,#0x5]	; 038001EC
	sub r0,r1,r0	; 038001EE
	lsl r0,r0,#0x6	; 038001F0
	add r7,r7,r0	; 038001F2
	add r0,r5,#0x0	; 038001F4
	ldr r1,[sp,#0x0]	; 038001F6
	bl loc_037FFBE8	; 038001F8
	add r6,r6,r0	; 038001FC
	add r0,r5,#0x0	; 038001FE
	ldr r1,[sp,#0x0]	; 03800200
	bl loc_037FFB98	; 03800202
	add r7,r7,r0	; 03800206
	add r0,r5,#0x0	; 03800208
	ldr r1,[sp,#0x0]	; 0380020A
	bl loc_037FFB18	; 0380020C
	add r1,r5,#0x0	; 03800210
	add r1,#0x28	; 03800212
	ldrb r1,[r1,#0x0]	; 03800214
	cmp r1,#0x0	; 03800216
	beq loc_03800228	; 03800218
	cmp r1,#0x1	; 0380021A
	beq loc_03800224	; 0380021C
	cmp r1,#0x2	; 0380021E
	beq loc_0380022C	; 03800220
	b loc_0380022E	; 03800222
loc_03800224:
	add r6,r6,r0	; 03800224
	b loc_0380022E	; 03800226
loc_03800228:
	add r7,r7,r0	; 03800228
	b loc_0380022E	; 0380022A
loc_0380022C:
	add r4,r4,r0	; 0380022C
loc_0380022E:
	mov r0,#0xc	; 0380022E
	ldrsh r0,[r5,r0]	; 03800230
	add r6,r6,r0	; 03800232
	mov r0,#0xe	; 03800234
	ldrsh r0,[r5,r0]	; 03800236
	add r7,r7,r0	; 03800238
	mov r0,#0xb	; 0380023A
	ldrsb r0,[r5,r0]	; 0380023C
	add r1,r4,r0	; 0380023E
	mov r0,#0xa	; 03800240
	ldrsb r0,[r5,r0]	; 03800242
	add r4,r1,r0	; 03800244
	ldrb r0,[r5,#0x2]	; 03800246
	cmp r0,#0x3	; 03800248
	bne loc_03800280	; 0380024A
	ldr r0,[pool_03800344]	; 0380024C
	cmp r6,r0	; 0380024E
	bgt loc_03800280	; 03800250
	mov r0,#0x2	; 03800252
	strb r0,[r5,#0x4]	; 03800254
	ldr r3,[r5,#0x48]	; 03800256
	cmp r3,#0x0	; 03800258
	beq loc_03800268	; 0380025A
	add r0,r5,#0x0	; 0380025C
	mov r1,#0x2	; 0380025E
	ldr r2,[r5,#0x4c]	; 03800260
	bl loc_03805098	; 03800262
	b loc_03800270	; 03800266
loc_03800268:
	add r1,r5,#0x0	; 03800268
	add r1,#0x22	; 0380026A
	ldr r0,[sp,#0x14]	; 0380026C
	strb r0,[r1,#0x0]	; 0380026E
loc_03800270:
	ldr r0,[sp,#0x18]	; 03800270
	strh r0,[r5,#0x24]	; 03800272
	add r2,r5,#0x3	; 03800274
	ldrb r1,[r2,#0x0]	; 03800276
	mov r0,#0x1	; 03800278
	bic r1,r0	; 0380027A
	strb r1,[r2,#0x0]	; 0380027C
	b loc_03800328	; 0380027E
loc_03800280:
	add r0,r6,#0x0	; 03800280
	bl loc_037FF820	; 03800282
	add r6,r0,#0x0	; 03800286
	ldrh r0,[r5,#0x3c]	; 03800288
	add r1,r7,#0x0	; 0380028A
	bl loc_037FF878	; 0380028C
	ldrb r1,[r5,#0x1]	; 03800290
	cmp r1,#0x1	; 03800292
	bne loc_0380029E	; 03800294
	ldr r1,[pool_03800348]	; 03800296
	and r0,r1	; 03800298
	lsl r0,r0,#0x10	; 0380029A
	lsr r0,r0,#0x10	; 0380029C
loc_0380029E:
	add r4,#0x40	; 0380029E
	cmp r4,#0x0	; 038002A0
	bge loc_038002A8	; 038002A2
	ldr r4,[sp,#0x1c]	; 038002A4
	b loc_038002AE	; 038002A6
loc_038002A8:
	cmp r4,#0x7f	; 038002A8
	ble loc_038002AE	; 038002AA
	mov r4,#0x7f	; 038002AC
loc_038002AE:
	ldrh r1,[r5,#0x24]	; 038002AE
	cmp r6,r1	; 038002B0
	beq loc_038002C0	; 038002B2
	strh r6,[r5,#0x24]	; 038002B4
	add r3,r5,#0x4	; 038002B6
	ldrb r2,[r3,#0x0]	; 038002B8
	mov r1,#0x8	; 038002BA
	orr r2,r1	; 038002BC
	strb r2,[r3,#0x0]	; 038002BE
loc_038002C0:
	ldrh r1,[r5,#0x26]	; 038002C0
	cmp r0,r1	; 038002C2
	beq loc_038002D2	; 038002C4
	strh r0,[r5,#0x26]	; 038002C6
	add r2,r5,#0x4	; 038002C8
	ldrb r1,[r2,#0x0]	; 038002CA
	mov r0,#0x4	; 038002CC
	orr r1,r0	; 038002CE
	strb r1,[r2,#0x0]	; 038002D0
loc_038002D2:
	add r0,r5,#0x0	; 038002D2
	add r0,#0x23	; 038002D4
	ldrb r0,[r0,#0x0]	; 038002D6
	cmp r4,r0	; 038002D8
	beq loc_038002EC	; 038002DA
	add r0,r5,#0x0	; 038002DC
	add r0,#0x23	; 038002DE
	strb r4,[r0,#0x0]	; 038002E0
	add r2,r5,#0x4	; 038002E2
	ldrb r1,[r2,#0x0]	; 038002E4
	mov r0,#0x10	; 038002E6
	orr r1,r0	; 038002E8
	strb r1,[r2,#0x0]	; 038002EA
loc_038002EC:
	ldr r0,[sp,#0x0]	; 038002EC
	cmp r0,#0x0	; 038002EE
	beq loc_03800328	; 038002F0
	ldr r0,[r5,#0x34]	; 038002F2
	cmp r0,#0x0	; 038002F4
	ble loc_03800328	; 038002F6
	add r1,r5,#0x0	; 038002F8
	add r1,#0x34	; 038002FA
	ldr r0,[r1,#0x0]	; 038002FC
	sub r0,r0,#0x1	; 038002FE
	str r0,[r1,#0x0]	; 03800300
	ldr r0,[r5,#0x34]	; 03800302
	cmp r0,#0x0	; 03800304
	bne loc_03800328	; 03800306
	ldr r3,[r5,#0x48]	; 03800308
	cmp r3,#0x0	; 0380030A
	beq loc_0380031A	; 0380030C
	add r0,r5,#0x0	; 0380030E
	mov r1,#0x1	; 03800310
	ldr r2,[r5,#0x4c]	; 03800312
	bl loc_03805098	; 03800314
	b loc_03800322	; 03800318
loc_0380031A:
	add r1,r5,#0x0	; 0380031A
	add r1,#0x22	; 0380031C
	mov r0,#0x1	; 0380031E
	strb r0,[r1,#0x0]	; 03800320
loc_03800322:
	add r0,r5,#0x0	; 03800322
	bl loc_03800080	; 03800324
loc_03800328:
	ldr r0,[sp,#0x4]	; 03800328
	add r0,r0,#0x1	; 0380032A
	str r0,[sp,#0x4]	; 0380032C
	cmp r0,#0x10	; 0380032E
	bge loc_03800334	; 03800330
	b loc_03800172	; 03800332
loc_03800334:
	add sp,#0x24	; 03800334
	pop {r4,r5,r6,r7}	; 03800336
	pop {r3}	; 03800338
	bx r3	; 0380033A
pool_0380033C:
loc_0380033C:
	.word 0x03805F24	; 0380033C
pool_03800340:
loc_03800340:
	.word P2_Data_03805128	; 03800340
pool_03800344:
loc_03800344:
	.word 0xFFFFFD2D	; 03800344
pool_03800348:
loc_03800348:
	.word 0x0000FFFC	; 03800348
P2_Entry_0380034C:
	push {r4,r5,r6,r7,lr}	; 0380034C
	sub sp,#0x1c	; 0380034E
	mov r4,#0x0	; 03800350
	add r7,r4,#0x0	; 03800352
	mov r6,#0xff	; 03800354
P2_Entry_03800356:
	add r1,r4,#0x0	; 03800356
	mov r0,#0x54	; 03800358
	mul r1,r0	; 0380035A
	ldr r0,[pool_03800484]	; 0380035C
	add r5,r0,r1	; 0380035E
	ldrb r1,[r5,#0x4]	; 03800360
	cmp r1,#0x0	; 03800362
	beq P2_Entry_03800444	; 03800364
	mov r0,#0x2	; 03800366
	and r1,r0	; 03800368
	cmp r1,#0x0	; 0380036A
	beq P2_Entry_03800376	; 0380036C
	add r0,r4,#0x0	; 0380036E
	add r1,r7,#0x0	; 03800370
	bl loc_037FF630	; 03800372
P2_Entry_03800376:
	ldrb r0,[r5,#0x4]	; 03800376
	add r2,r0,#0x0	; 03800378
	mov r1,#0x1	; 0380037A
	and r2,r1	; 0380037C
	cmp r2,#0x0	; 0380037E
	beq P2_Entry_03800408	; 03800380
	ldrb r0,[r5,#0x1]	; 03800382
	cmp r0,#0x0	; 03800384
	beq P2_Entry_03800392	; 03800386
	cmp r0,#0x1	; 03800388
	beq P2_Entry_038003D0	; 0380038A
	cmp r0,#0x2	; 0380038C
	beq P2_Entry_038003EE	; 0380038E
	b P2_Entry_03800444	; 03800390
P2_Entry_03800392:
	add r0,r5,#0x0	; 03800392
	add r0,#0x39	; 03800394
	ldrb r0,[r0,#0x0]	; 03800396
	cmp r0,#0x0	; 03800398
	beq P2_Entry_038003A0	; 0380039A
	lsl r3,r1,#0	; 0380039C
	b P2_Entry_038003A2	; 0380039E
P2_Entry_038003A0:
	mov r3,#0x2	; 038003A0
P2_Entry_038003A2:
	ldrh r0,[r5,#0x24]	; 038003A2
	ldrh r1,[r5,#0x3e]	; 038003A4
	str r1,[sp,#0x0]	; 038003A6
	ldr r1,[r5,#0x40]	; 038003A8
	str r1,[sp,#0x4]	; 038003AA
	add r1,r0,#0x0	; 038003AC
	and r1,r6	; 038003AE
	str r1,[sp,#0x8]	; 038003B0
	asr r0,r0,#0x8	; 038003B2
	str r0,[sp,#0xc]	; 038003B4
	ldrh r0,[r5,#0x26]	; 038003B6
	str r0,[sp,#0x10]	; 038003B8
	add r0,r5,#0x0	; 038003BA
	add r0,#0x23	; 038003BC
	ldrb r0,[r0,#0x0]	; 038003BE
	str r0,[sp,#0x14]	; 038003C0
	add r0,r4,#0x0	; 038003C2
	ldr r1,[r5,#0x44]	; 038003C4
	add r5,#0x38	; 038003C6
	ldrb r2,[r5,#0x0]	; 038003C8
	bl loc_037FF72C	; 038003CA
	b P2_Entry_03800444	; 038003CE
P2_Entry_038003D0:
	ldrh r3,[r5,#0x24]	; 038003D0
	ldrh r0,[r5,#0x26]	; 038003D2
	str r0,[sp,#0x0]	; 038003D4
	add r0,r5,#0x0	; 038003D6
	add r0,#0x23	; 038003D8
	ldrb r0,[r0,#0x0]	; 038003DA
	str r0,[sp,#0x4]	; 038003DC
	add r0,r4,#0x0	; 038003DE
	ldr r1,[r5,#0x44]	; 038003E0
	add r2,r3,#0x0	; 038003E2
	and r2,r6	; 038003E4
	asr r3,r3,#0x8	; 038003E6
	bl loc_037FF6C0	; 038003E8
	b P2_Entry_03800444	; 038003EC
P2_Entry_038003EE:
	ldrh r2,[r5,#0x24]	; 038003EE
	add r0,r5,#0x0	; 038003F0
	add r0,#0x23	; 038003F2
	ldrb r0,[r0,#0x0]	; 038003F4
	str r0,[sp,#0x0]	; 038003F6
	add r0,r4,#0x0	; 038003F8
	add r1,r2,#0x0	; 038003FA
	and r1,r6	; 038003FC
	asr r2,r2,#0x8	; 038003FE
	ldrh r3,[r5,#0x26]	; 03800400
	bl loc_037FF658	; 03800402
	b P2_Entry_03800444	; 03800406
P2_Entry_03800408:
	mov r1,#0x4	; 03800408
	and r0,r1	; 0380040A
	cmp r0,#0x0	; 0380040C
	beq P2_Entry_03800418	; 0380040E
	add r0,r4,#0x0	; 03800410
	ldrh r1,[r5,#0x26]	; 03800412
	bl loc_037FF5C4	; 03800414
P2_Entry_03800418:
	ldrb r1,[r5,#0x4]	; 03800418
	mov r0,#0x8	; 0380041A
	and r1,r0	; 0380041C
	cmp r1,#0x0	; 0380041E
	beq P2_Entry_03800430	; 03800420
	ldrh r2,[r5,#0x24]	; 03800422
	add r0,r4,#0x0	; 03800424
	add r1,r2,#0x0	; 03800426
	and r1,r6	; 03800428
	asr r2,r2,#0x8	; 0380042A
	bl loc_037FF5D8	; 0380042C
P2_Entry_03800430:
	ldrb r1,[r5,#0x4]	; 03800430
	mov r0,#0x10	; 03800432
	and r1,r0	; 03800434
	cmp r1,#0x0	; 03800436
	beq P2_Entry_03800444	; 03800438
	add r0,r4,#0x0	; 0380043A
	add r5,#0x23	; 0380043C
	ldrb r1,[r5,#0x0]	; 0380043E
	bl loc_037FF580	; 03800440
P2_Entry_03800444:
	add r4,r4,#0x1	; 03800444
	cmp r4,#0x10	; 03800446
	blt P2_Entry_03800356	; 03800448
	mov r2,#0x0	; 0380044A
	add r5,r2,#0x0	; 0380044C
	ldr r0,[pool_03800484]	; 0380044E
	mov r4,#0x54	; 03800450
P2_Entry_03800452:
	add r1,r2,#0x0	; 03800452
	mul r1,r4	; 03800454
	add r1,r0,r1	; 03800456
	ldrb r6,[r1,#0x4]	; 03800458
	cmp r6,#0x0	; 0380045A
	beq P2_Entry_03800476	; 0380045C
	mov r3,#0x1	; 0380045E
	and r6,r3	; 03800460
	cmp r6,#0x0	; 03800462
	beq P2_Entry_03800474	; 03800464
	lsl r6,r2,#0x4	; 03800466
	ldr r3,[pool_03800488]	; 03800468
	add r7,r6,r3	; 0380046A
	ldrb r6,[r7,#0x0]	; 0380046C
	mov r3,#0x80	; 0380046E
	orr r6,r3	; 03800470
	strb r6,[r7,#0x0]	; 03800472
P2_Entry_03800474:
	strb r5,[r1,#0x4]	; 03800474
P2_Entry_03800476:
	add r2,r2,#0x1	; 03800476
	cmp r2,#0x10	; 03800478
	blt P2_Entry_03800452	; 0380047A
	add sp,#0x1c	; 0380047C
	pop {r4,r5,r6,r7}	; 0380047E
	pop {r3}	; 03800480
	bx r3	; 03800482
pool_03800484:
	.word 0x03805F24	; 03800484
pool_03800488:
	.word 0x04000403	; 03800488
P2_Entry_0380048C:
	push {r4,r5,r6,lr}	; 0380048C
	mov r0,#0x0	; 0380048E
	ldr r6,[pool_038004C0]	; 03800490
	add r5,r0,#0x0	; 03800492
	mov r1,#0x54	; 03800494
	mov r2,#0x1	; 03800496
P2_Entry_03800498:
	add r3,r0,#0x0	; 03800498
	mul r3,r1	; 0380049A
	add r4,r6,r3	; 0380049C
	strb r0,[r6,r3]	; 0380049E
	strb r5,[r4,#0x4]	; 038004A0
	add r4,r4,#0x3	; 038004A2
	ldrb r3,[r4,#0x0]	; 038004A4
	bic r3,r2	; 038004A6
	strb r3,[r4,#0x0]	; 038004A8
	add r0,r0,#0x1	; 038004AA
	cmp r0,#0x10	; 038004AC
	blt P2_Entry_03800498	; 038004AE
	ldr r0,[pool_038004C4]	; 038004B0
	str r5,[r0,#0x0]	; 038004B2
	ldr r0,[pool_038004C8]	; 038004B4
	str r5,[r0,#0x0]	; 038004B6
	pop {r4,r5,r6}	; 038004B8
	pop {r3}	; 038004BA
	bx r3	; 038004BC
	.byte 0xC0, 0x46	; 038004BE
pool_038004C0:
	.word P2_BssStart + 0xB84	; 038004C0
pool_038004C4:
	.word P2_BssStart + 0xB64	; 038004C4
pool_038004C8:
	.word P2_BssStart + 0xB60	; 038004C8

; ===== function loc_038004CC =====
loc_038004CC:
	push {r4,lr}	; 038004CC
	mov r0,#0x0	; 038004CE
	ldr r3,[pool_038004FC]	; 038004D0
	b loc_038004EE	; 038004D2
loc_038004D4:
	lsl r1,r0,#0x6	; 038004D4
	add r4,r3,r1	; 038004D6
	ldrb r2,[r3,r1]	; 038004D8
	lsl r1,r2,#0x1f	; 038004DA
	lsr r1,r1,#0x1f	; 038004DC
	cmp r1,#0x0	; 038004DE
	bne loc_038004EC	; 038004E0
	mov r1,#0x1	; 038004E2
	bic r2,r1	; 038004E4
	orr r2,r1	; 038004E6
	strb r2,[r4,#0x0]	; 038004E8
	b loc_038004F6	; 038004EA
loc_038004EC:
	add r0,r0,#0x1	; 038004EC
loc_038004EE:
	cmp r0,#0x20	; 038004EE
	blt loc_038004D4	; 038004F0
	mov r0,#0x0	; 038004F2
	mvn r0,r0	; 038004F4
loc_038004F6:
	pop {r4}	; 038004F6
	pop {r3}	; 038004F8
	bx r3	; 038004FA
pool_038004FC:
loc_038004FC:
	.word 0x038066A4	; 038004FC

; ===== function loc_03800500 =====
loc_03800500:
	ldr r2,[pool_0380052C]	; 03800500
	ldr r3,[r2,#0x0]	; 03800502
	cmp r3,#0x0	; 03800504
	bne loc_0380050C	; 03800506
	mov r0,#0x0	; 03800508
	bx lr	; 0380050A
loc_0380050C:
	cmp r1,#0x10	; 0380050C
	bge loc_03800520	; 0380050E
	add r3,#0x20	; 03800510
	ldrb r2,[r0,#0x2]	; 03800512
	mov r0,#0x24	; 03800514
	mul r2,r0	; 03800516
	add r2,r3,r2	; 03800518
	lsl r0,r1,#0x1	; 0380051A
	add r0,r2,r0	; 0380051C
	bx lr	; 0380051E
loc_03800520:
	ldr r0,[pool_03800530]	; 03800520
	add r2,r3,r0	; 03800522
	sub r1,#0x10	; 03800524
	lsl r0,r1,#0x1	; 03800526
	add r0,r2,r0	; 03800528
	bx lr	; 0380052A
pool_0380052C:
loc_0380052C:
	.word P2_BssStart + 0xB80	; 0380052C
pool_03800530:
loc_03800530:
	.word 0x00000260	; 03800530
P2_Entry_03800534:
	push {r4,r5,r6,r7,lr}	; 03800534
	sub sp,#0x4	; 03800536
	add r5,r0,#0x0	; 03800538
	mov r6,#0x0	; 0380053A
	add r4,r6,#0x0	; 0380053C
	mov r7,#0x1	; 0380053E
P2_Entry_03800540:
	add r0,r5,#0x0	; 03800540
	add r1,r4,#0x0	; 03800542
	bl loc_03800E78	; 03800544
	cmp r0,#0x0	; 03800548
	beq P2_Entry_03800568	; 0380054A
	ldr r1,[r0,#0x28]	; 0380054C
	cmp r1,#0x0	; 0380054E
	beq P2_Entry_03800568	; 03800550
	add r1,r5,#0x0	; 03800552
	bl P2_Entry_03800580	; 03800554
	cmp r0,#0x0	; 03800558
	bne P2_Entry_03800560	; 0380055A
	add r6,r7,#0x0	; 0380055C
	b P2_Entry_03800568	; 0380055E
P2_Entry_03800560:
	add r0,r5,#0x0	; 03800560
	add r1,r4,#0x0	; 03800562
	bl loc_03800E34	; 03800564
P2_Entry_03800568:
	add r4,r4,#0x1	; 03800568
	cmp r4,#0x10	; 0380056A
	blt P2_Entry_03800540	; 0380056C
	cmp r6,#0x0	; 0380056E
	bne P2_Entry_03800576	; 03800570
	mov r0,#0x1	; 03800572
	b P2_Entry_03800578	; 03800574
P2_Entry_03800576:
	mov r0,#0x0	; 03800576
P2_Entry_03800578:
	add sp,#0x4	; 03800578
	pop {r4,r5,r6,r7}	; 0380057A
	pop {r3}	; 0380057C
	bx r3	; 0380057E
P2_Entry_03800580:
	push {r4,r5,r6,r7,lr}	; 03800580
	sub sp,#0x24	; 03800582
	add r4,r0,#0x0	; 03800584
	str r1,[sp,#0x4]	; 03800586
	ldrb r1,[r4,#0x0]	; 03800588
	lsl r0,r1,#0x1b	; 0380058A
	lsr r0,r0,#0x1f	; 0380058C
	cmp r0,#0x0	; 0380058E
	beq P2_Entry_038005A2	; 03800590
	ldr r0,[r4,#0x3c]	; 03800592
	cmp r0,#0x0	; 03800594
	beq P2_Entry_0380059C	; 03800596
	mov r0,#0x0	; 03800598
	b P2_Entry_03800BA4	; 0380059A
P2_Entry_0380059C:
	mov r0,#0x10	; 0380059C
	bic r1,r0	; 0380059E
	strb r1,[r4,#0x0]	; 038005A0
P2_Entry_038005A2:
	ldr r0,[r4,#0x20]	; 038005A2
	cmp r0,#0x0	; 038005A4
	ble P2_Entry_038005BC	; 038005A6
	add r1,r4,#0x0	; 038005A8
	add r1,#0x20	; 038005AA
	ldr r0,[r1,#0x0]	; 038005AC
	sub r0,r0,#0x1	; 038005AE
	str r0,[r1,#0x0]	; 038005B0
	ldr r0,[r4,#0x20]	; 038005B2
	cmp r0,#0x0	; 038005B4
	ble P2_Entry_038005BC	; 038005B6
	mov r0,#0x0	; 038005B8
	b P2_Entry_03800BA4	; 038005BA
P2_Entry_038005BC:
	ldr r0,[r4,#0x28]	; 038005BC
	bl loc_038011C8	; 038005BE
	mov r0,#0x0	; 038005C2
	mvn r0,r0	; 038005C4
	str r0,[sp,#0x18]	; 038005C6
	b P2_Entry_03800B90	; 038005C8
P2_Entry_038005CA:
	mov r5,#0x0	; 038005CA
	mov r0,#0x1	; 038005CC
	str r0,[sp,#0xc]	; 038005CE
	add r0,r4,#0x0	; 038005D0
	bl loc_03801180	; 038005D2
	add r6,r0,#0x0	; 038005D6
	cmp r6,#0xa2	; 038005D8
	bne P2_Entry_038005EC	; 038005DA
	add r0,r4,#0x0	; 038005DC
	bl loc_03801180	; 038005DE
	add r6,r0,#0x0	; 038005E2
	ldrb r0,[r4,#0x0]	; 038005E4
	lsl r0,r0,#0x19	; 038005E6
	lsr r0,r0,#0x1f	; 038005E8
	str r0,[sp,#0xc]	; 038005EA
P2_Entry_038005EC:
	cmp r6,#0xa0	; 038005EC
	bne P2_Entry_038005FE	; 038005EE
	add r0,r4,#0x0	; 038005F0
	bl loc_03801180	; 038005F2
	add r6,r0,#0x0	; 038005F6
	mov r0,#0x3	; 038005F8
	str r0,[sp,#0x8]	; 038005FA
	mov r5,#0x1	; 038005FC
P2_Entry_038005FE:
	cmp r6,#0xa1	; 038005FE
	bne P2_Entry_03800610	; 03800600
	add r0,r4,#0x0	; 03800602
	bl loc_03801180	; 03800604
	add r6,r0,#0x0	; 03800608
	mov r0,#0x4	; 0380060A
	str r0,[sp,#0x8]	; 0380060C
	mov r5,#0x1	; 0380060E
P2_Entry_03800610:
	add r1,r6,#0x0	; 03800610
	mov r0,#0x80	; 03800612
	and r1,r0	; 03800614
	cmp r1,#0x0	; 03800616
	bne P2_Entry_0380068A	; 03800618
	add r0,r4,#0x0	; 0380061A
	bl loc_03801180	; 0380061C
	str r0,[sp,#0x10]	; 03800620
	cmp r5,#0x0	; 03800622
	beq P2_Entry_0380062A	; 03800624
	ldr r2,[sp,#0x8]	; 03800626
	b P2_Entry_0380062C	; 03800628
P2_Entry_0380062A:
	mov r2,#0x2	; 0380062A
P2_Entry_0380062C:
	add r0,r4,#0x0	; 0380062C
	ldr r1,[sp,#0x4]	; 0380062E
	bl P2_Entry_03801054	; 03800630
	add r7,r0,#0x0	; 03800634
	mov r0,#0x13	; 03800636
	ldrsb r0,[r4,r0]	; 03800638
	add r5,r6,r0	; 0380063A
	ldr r0,[sp,#0xc]	; 0380063C
	cmp r0,#0x0	; 0380063E
	bne P2_Entry_03800644	; 03800640
	b P2_Entry_03800B90	; 03800642
P2_Entry_03800644:
	cmp r5,#0x0	; 03800644
	bge P2_Entry_0380064C	; 03800646
	mov r5,#0x0	; 03800648
	b P2_Entry_03800652	; 0380064A
P2_Entry_0380064C:
	cmp r5,#0x7f	; 0380064C
	ble P2_Entry_03800652	; 0380064E
	mov r5,#0x7f	; 03800650
P2_Entry_03800652:
	ldrb r0,[r4,#0x0]	; 03800652
	lsl r0,r0,#0x1d	; 03800654
	lsr r0,r0,#0x1f	; 03800656
	cmp r0,#0x0	; 03800658
	bne P2_Entry_0380066A	; 0380065A
	str r7,[sp,#0x0]	; 0380065C
	add r0,r4,#0x0	; 0380065E
	ldr r1,[sp,#0x4]	; 03800660
	add r2,r5,#0x0	; 03800662
	ldr r3,[sp,#0x10]	; 03800664
	bl P2_Entry_03800BAC	; 03800666
P2_Entry_0380066A:
	strb r5,[r4,#0x14]	; 0380066A
	ldrb r0,[r4,#0x0]	; 0380066C
	lsl r0,r0,#0x1e	; 0380066E
	lsr r0,r0,#0x1f	; 03800670
	cmp r0,#0x0	; 03800672
	bne P2_Entry_03800678	; 03800674
	b P2_Entry_03800B90	; 03800676
P2_Entry_03800678:
	str r7,[r4,#0x20]	; 03800678
	cmp r7,#0x0	; 0380067A
	beq P2_Entry_03800680	; 0380067C
	b P2_Entry_03800B90	; 0380067E
P2_Entry_03800680:
	ldrb r1,[r4,#0x0]	; 03800680
	mov r0,#0x10	; 03800682
	orr r1,r0	; 03800684
	strb r1,[r4,#0x0]	; 03800686
	b P2_Entry_03800B90	; 03800688
P2_Entry_0380068A:
	add r1,r6,#0x0	; 0380068A
	mov r0,#0xf0	; 0380068C
	and r1,r0	; 0380068E
	cmp r1,#0xc0	; 03800690
	bgt P2_Entry_038006AE	; 03800692
	cmp r1,#0xc0	; 03800694
	bge P2_Entry_03800792	; 03800696
	cmp r1,#0x90	; 03800698
	bgt P2_Entry_038006A6	; 0380069A
	cmp r1,#0x90	; 0380069C
	bge P2_Entry_038006FA	; 0380069E
	cmp r1,#0x80	; 038006A0
	beq P2_Entry_038006C6	; 038006A2
	b P2_Entry_03800B90	; 038006A4
P2_Entry_038006A6:
	cmp r1,#0xb0	; 038006A6
	bne P2_Entry_038006AC	; 038006A8
	b P2_Entry_0380095E	; 038006AA
P2_Entry_038006AC:
	b P2_Entry_03800B90	; 038006AC
P2_Entry_038006AE:
	cmp r1,#0xe0	; 038006AE
	bgt P2_Entry_038006BE	; 038006B0
	cmp r1,#0xe0	; 038006B2
	blt P2_Entry_038006B8	; 038006B4
	b P2_Entry_03800924	; 038006B6
P2_Entry_038006B8:
	cmp r1,#0xd0	; 038006B8
	beq P2_Entry_03800792	; 038006BA
	b P2_Entry_03800B90	; 038006BC
P2_Entry_038006BE:
	cmp r1,#0xf0	; 038006BE
	bne P2_Entry_038006C4	; 038006C0
	b P2_Entry_03800B00	; 038006C2
P2_Entry_038006C4:
	b P2_Entry_03800B90	; 038006C4
P2_Entry_038006C6:
	cmp r5,#0x0	; 038006C6
	beq P2_Entry_038006CE	; 038006C8
	ldr r2,[sp,#0x8]	; 038006CA
	b P2_Entry_038006D0	; 038006CC
P2_Entry_038006CE:
	mov r2,#0x2	; 038006CE
P2_Entry_038006D0:
	add r0,r4,#0x0	; 038006D0
	ldr r1,[sp,#0x4]	; 038006D2
	bl P2_Entry_03801054	; 038006D4
	ldr r1,[sp,#0xc]	; 038006D8
	cmp r1,#0x0	; 038006DA
	bne P2_Entry_038006E0	; 038006DC
	b P2_Entry_03800B90	; 038006DE
P2_Entry_038006E0:
	cmp r6,#0x80	; 038006E0
	beq P2_Entry_038006EA	; 038006E2
	cmp r6,#0x81	; 038006E4
	beq P2_Entry_038006EE	; 038006E6
	b P2_Entry_03800B90	; 038006E8
P2_Entry_038006EA:
	str r0,[r4,#0x20]	; 038006EA
	b P2_Entry_03800B90	; 038006EC
P2_Entry_038006EE:
	ldr r1,[pool_03800A30]	; 038006EE
	cmp r0,r1	; 038006F0
	blt P2_Entry_038006F6	; 038006F2
	b P2_Entry_03800B90	; 038006F4
P2_Entry_038006F6:
	strh r0,[r4,#0x2]	; 038006F6
	b P2_Entry_03800B90	; 038006F8
P2_Entry_038006FA:
	cmp r6,#0x93	; 038006FA
	beq P2_Entry_03800708	; 038006FC
	cmp r6,#0x94	; 038006FE
	beq P2_Entry_03800748	; 03800700
	cmp r6,#0x95	; 03800702
	beq P2_Entry_0380075E	; 03800704
	b P2_Entry_03800B90	; 03800706
P2_Entry_03800708:
	add r0,r4,#0x0	; 03800708
	bl loc_03801180	; 0380070A
	add r5,r0,#0x0	; 0380070E
	add r0,r4,#0x0	; 03800710
	bl P2_Entry_03801100	; 03800712
	add r6,r0,#0x0	; 03800716
	ldr r0,[sp,#0xc]	; 03800718
	cmp r0,#0x0	; 0380071A
	bne P2_Entry_03800720	; 0380071C
	b P2_Entry_03800B90	; 0380071E
P2_Entry_03800720:
	ldr r0,[sp,#0x4]	; 03800720
	add r1,r5,#0x0	; 03800722
	bl loc_03800E78	; 03800724
	add r5,r0,#0x0	; 03800728
	cmp r5,#0x0	; 0380072A
	bne P2_Entry_03800730	; 0380072C
	b P2_Entry_03800B90	; 0380072E
P2_Entry_03800730:
	cmp r5,r4	; 03800730
	bne P2_Entry_03800736	; 03800732
	b P2_Entry_03800B90	; 03800734
P2_Entry_03800736:
	ldr r1,[sp,#0x4]	; 03800736
	bl loc_03800E6C	; 03800738
	add r0,r5,#0x0	; 0380073C
	ldr r1,[r4,#0x24]	; 0380073E
	add r2,r6,#0x0	; 03800740
	bl loc_03800FB4	; 03800742
	b P2_Entry_03800B90	; 03800746
P2_Entry_03800748:
	add r0,r4,#0x0	; 03800748
	bl P2_Entry_03801100	; 0380074A
	ldr r1,[sp,#0xc]	; 0380074E
	cmp r1,#0x0	; 03800750
	bne P2_Entry_03800756	; 03800752
	b P2_Entry_03800B90	; 03800754
P2_Entry_03800756:
	ldr r1,[r4,#0x24]	; 03800756
	add r0,r1,r0	; 03800758
	str r0,[r4,#0x28]	; 0380075A
	b P2_Entry_03800B90	; 0380075C
P2_Entry_0380075E:
	add r0,r4,#0x0	; 0380075E
	bl P2_Entry_03801100	; 03800760
	ldr r1,[sp,#0xc]	; 03800764
	cmp r1,#0x0	; 03800766
	bne P2_Entry_0380076C	; 03800768
	b P2_Entry_03800B90	; 0380076A
P2_Entry_0380076C:
	add r1,r4,#0x0	; 0380076C
	add r1,#0x3b	; 0380076E
	ldrb r1,[r1,#0x0]	; 03800770
	cmp r1,#0x3	; 03800772
	bcc P2_Entry_03800778	; 03800774
	b P2_Entry_03800B90	; 03800776
P2_Entry_03800778:
	ldr r2,[r4,#0x28]	; 03800778
	lsl r1,r1,#0x2	; 0380077A
	add r1,r4,r1	; 0380077C
	str r2,[r1,#0x2c]	; 0380077E
	add r2,r4,#0x0	; 03800780
	add r2,#0x3b	; 03800782
	ldrb r1,[r2,#0x0]	; 03800784
	add r1,r1,#0x1	; 03800786
	strb r1,[r2,#0x0]	; 03800788
	ldr r1,[r4,#0x24]	; 0380078A
	add r0,r1,r0	; 0380078C
	str r0,[r4,#0x28]	; 0380078E
	b P2_Entry_03800B90	; 03800790
P2_Entry_03800792:
	cmp r5,#0x0	; 03800792
	beq P2_Entry_0380079A	; 03800794
	ldr r2,[sp,#0x8]	; 03800796
	b P2_Entry_0380079C	; 03800798
P2_Entry_0380079A:
	mov r2,#0x0	; 0380079A
P2_Entry_0380079C:
	add r0,r4,#0x0	; 0380079C
	ldr r1,[sp,#0x4]	; 0380079E
	bl P2_Entry_03801054	; 038007A0
	add r1,sp,#0x1c	; 038007A4
	strb r0,[r1,#0x0]	; 038007A6
	ldr r0,[sp,#0xc]	; 038007A8
	cmp r0,#0x0	; 038007AA
	bne P2_Entry_038007B0	; 038007AC
	b P2_Entry_03800B90	; 038007AE
P2_Entry_038007B0:
	sub r6,#0xc0	; 038007B0
	cmp r6,#0x15	; 038007B2
	bls P2_Entry_038007B8	; 038007B4
	b P2_Entry_03800B90	; 038007B6
P2_Entry_038007B8:
	add r0,r6,r6	; 038007B8
P2_SwitchIndexPC_038007B8:
	add r0,pc	; 038007BA
	ldrh r0,[r0,#(P2_SwitchTable_038007B8 - (P2_SwitchIndexPC_038007B8 + 4))]	; 038007BC
	lsl r0,r0,#0x10	; 038007BE
	asr r0,r0,#0x10	; 038007C0
P2_SwitchTargetPC_038007B8:
	add r0,pc	; 038007C2
	bx r0	; 038007C4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038007B8:
	.halfword (P2_Case_0380091A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_038007F2 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800802 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380090A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800912 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380080C + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800814 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380081C + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_038008AA + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_038008CA + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380083A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800842 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380084A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800852 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_038008EA + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800832 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380085A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800862 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380086A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_03800872 + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_0380087A + 1) - (P2_SwitchTargetPC_038007B8 + 4)
	.halfword (P2_Case_038007FA + 1) - (P2_SwitchTargetPC_038007B8 + 4)
P2_SwitchTable_038007B8End:
P2_Case_038007F2:
	lsl r0,r1,#0	; 038007F2
	ldrb r0,[r0,#0x0]	; 038007F4
	strb r0,[r4,#0x4]	; 038007F6
	b P2_Entry_03800B90	; 038007F8
P2_Case_038007FA:
	lsl r0,r1,#0	; 038007FA
	ldrb r0,[r0,#0x0]	; 038007FC
	strb r0,[r4,#0x5]	; 038007FE
	b P2_Entry_03800B90	; 03800800
P2_Case_03800802:
	lsl r0,r1,#0	; 03800802
	ldrb r1,[r0,#0x0]	; 03800804
	ldr r0,[sp,#0x4]	; 03800806
	strb r1,[r0,#0x5]	; 03800808
	b P2_Entry_03800B90	; 0380080A
P2_Case_0380080C:
	lsl r0,r1,#0	; 0380080C
	ldrb r0,[r0,#0x0]	; 0380080E
	strb r0,[r4,#0x7]	; 03800810
	b P2_Entry_03800B90	; 03800812
P2_Case_03800814:
	lsl r0,r1,#0	; 03800814
	ldrb r0,[r0,#0x0]	; 03800816
	strb r0,[r4,#0x12]	; 03800818
	b P2_Entry_03800B90	; 0380081A
P2_Case_0380081C:
	ldrb r0,[r4,#0x0]	; 0380081C
	mov r1,#0x2	; 0380081E
	bic r0,r1	; 03800820
	add r1,sp,#0x1c	; 03800822
	ldrb r2,[r1,#0x0]	; 03800824
	mov r1,#0x1	; 03800826
	and r2,r1	; 03800828
	lsl r1,r2,#0x1	; 0380082A
	orr r0,r1	; 0380082C
	strb r0,[r4,#0x0]	; 0380082E
	b P2_Entry_03800B90	; 03800830
P2_Case_03800832:
	lsl r0,r1,#0	; 03800832
	ldrb r0,[r0,#0x0]	; 03800834
	strb r0,[r4,#0x15]	; 03800836
	b P2_Entry_03800B90	; 03800838
P2_Case_0380083A:
	lsl r0,r1,#0	; 0380083A
	ldrb r0,[r0,#0x0]	; 0380083C
	strb r0,[r4,#0x1a]	; 0380083E
	b P2_Entry_03800B90	; 03800840
P2_Case_03800842:
	lsl r0,r1,#0	; 03800842
	ldrb r0,[r0,#0x0]	; 03800844
	strb r0,[r4,#0x19]	; 03800846
	b P2_Entry_03800B90	; 03800848
P2_Case_0380084A:
	lsl r0,r1,#0	; 0380084A
	ldrb r0,[r0,#0x0]	; 0380084C
	strb r0,[r4,#0x18]	; 0380084E
	b P2_Entry_03800B90	; 03800850
P2_Case_03800852:
	lsl r0,r1,#0	; 03800852
	ldrb r0,[r0,#0x0]	; 03800854
	strb r0,[r4,#0x1b]	; 03800856
	b P2_Entry_03800B90	; 03800858
P2_Case_0380085A:
	lsl r0,r1,#0	; 0380085A
	ldrb r0,[r0,#0x0]	; 0380085C
	strb r0,[r4,#0xe]	; 0380085E
	b P2_Entry_03800B90	; 03800860
P2_Case_03800862:
	lsl r0,r1,#0	; 03800862
	ldrb r0,[r0,#0x0]	; 03800864
	strb r0,[r4,#0xf]	; 03800866
	b P2_Entry_03800B90	; 03800868
P2_Case_0380086A:
	lsl r0,r1,#0	; 0380086A
	ldrb r0,[r0,#0x0]	; 0380086C
	strb r0,[r4,#0x10]	; 0380086E
	b P2_Entry_03800B90	; 03800870
P2_Case_03800872:
	lsl r0,r1,#0	; 03800872
	ldrb r0,[r0,#0x0]	; 03800874
	strb r0,[r4,#0x11]	; 03800876
	b P2_Entry_03800B90	; 03800878
P2_Case_0380087A:
	add r0,r4,#0x0	; 0380087A
	add r0,#0x3b	; 0380087C
	ldrb r0,[r0,#0x0]	; 0380087E
	cmp r0,#0x3	; 03800880
	bcc P2_Entry_03800886	; 03800882
	b P2_Entry_03800B90	; 03800884
P2_Entry_03800886:
	ldr r1,[r4,#0x28]	; 03800886
	lsl r0,r0,#0x2	; 03800888
	add r0,r4,r0	; 0380088A
	str r1,[r0,#0x2c]	; 0380088C
	add r0,sp,#0x1c	; 0380088E
	ldrb r1,[r0,#0x0]	; 03800890
	add r0,r4,#0x0	; 03800892
	add r0,#0x3b	; 03800894
	ldrb r0,[r0,#0x0]	; 03800896
	add r0,r4,r0	; 03800898
	add r0,#0x38	; 0380089A
	strb r1,[r0,#0x0]	; 0380089C
	add r1,r4,#0x0	; 0380089E
	add r1,#0x3b	; 038008A0
	ldrb r0,[r1,#0x0]	; 038008A2
	add r0,r0,#0x1	; 038008A4
	strb r0,[r1,#0x0]	; 038008A6
	b P2_Entry_03800B90	; 038008A8
P2_Case_038008AA:
	ldrb r0,[r4,#0x0]	; 038008AA
	mov r1,#0x8	; 038008AC
	bic r0,r1	; 038008AE
	add r1,sp,#0x1c	; 038008B0
	ldrb r2,[r1,#0x0]	; 038008B2
	mov r1,#0x1	; 038008B4
	and r2,r1	; 038008B6
	lsl r1,r2,#0x3	; 038008B8
	orr r0,r1	; 038008BA
	strb r0,[r4,#0x0]	; 038008BC
	add r0,r4,#0x0	; 038008BE
	ldr r1,[sp,#0x4]	; 038008C0
	ldr r2,[sp,#0x18]	; 038008C2
	bl loc_03800F00	; 038008C4
	b P2_Entry_03800B90	; 038008C8
P2_Case_038008CA:
	lsl r0,r1,#0	; 038008CA
	ldrb r1,[r0,#0x0]	; 038008CC
	mov r0,#0x13	; 038008CE
	ldrsb r0,[r4,r0]	; 038008D0
	add r0,r1,r0	; 038008D2
	strb r0,[r4,#0x14]	; 038008D4
	ldrb r1,[r4,#0x0]	; 038008D6
	mov r0,#0x20	; 038008D8
	orr r1,r0	; 038008DA
	strb r1,[r4,#0x0]	; 038008DC
	add r0,r4,#0x0	; 038008DE
	ldr r1,[sp,#0x4]	; 038008E0
	ldr r2,[sp,#0x18]	; 038008E2
	bl loc_03800F00	; 038008E4
	b P2_Entry_03800B90	; 038008E8
P2_Case_038008EA:
	ldrb r0,[r4,#0x0]	; 038008EA
	mov r1,#0x20	; 038008EC
	bic r0,r1	; 038008EE
	add r1,sp,#0x1c	; 038008F0
	ldrb r2,[r1,#0x0]	; 038008F2
	mov r1,#0x1	; 038008F4
	and r2,r1	; 038008F6
	lsl r1,r2,#0x5	; 038008F8
	orr r0,r1	; 038008FA
	strb r0,[r4,#0x0]	; 038008FC
	add r0,r4,#0x0	; 038008FE
	ldr r1,[sp,#0x4]	; 03800900
	ldr r2,[sp,#0x18]	; 03800902
	bl loc_03800F00	; 03800904
	b P2_Entry_03800B90	; 03800908
P2_Case_0380090A:
	mov r0,#0x0	; 0380090A
	ldrsb r0,[r1,r0]	; 0380090C
	strb r0,[r4,#0x13]	; 0380090E
	b P2_Entry_03800B90	; 03800910
P2_Case_03800912:
	mov r0,#0x0	; 03800912
	ldrsb r0,[r1,r0]	; 03800914
	strb r0,[r4,#0x6]	; 03800916
	b P2_Entry_03800B90	; 03800918
P2_Case_0380091A:
	lsl r0,r1,#0	; 0380091A
	ldrb r0,[r0,#0x0]	; 0380091C
	sub r0,#0x40	; 0380091E
	strb r0,[r4,#0x8]	; 03800920
	b P2_Entry_03800B90	; 03800922
P2_Entry_03800924:
	cmp r5,#0x0	; 03800924
	beq P2_Entry_0380092C	; 03800926
	ldr r2,[sp,#0x8]	; 03800928
	b P2_Entry_0380092E	; 0380092A
P2_Entry_0380092C:
	mov r2,#0x1	; 0380092C
P2_Entry_0380092E:
	add r0,r4,#0x0	; 0380092E
	ldr r1,[sp,#0x4]	; 03800930
	bl P2_Entry_03801054	; 03800932
	lsl r0,r0,#0x10	; 03800936
	asr r1,r0,#0x10	; 03800938
	ldr r0,[sp,#0xc]	; 0380093A
	cmp r0,#0x0	; 0380093C
	bne P2_Entry_03800942	; 0380093E
	b P2_Entry_03800B90	; 03800940
P2_Entry_03800942:
	cmp r6,#0xe0	; 03800942
	beq P2_Entry_03800956	; 03800944
	cmp r6,#0xe1	; 03800946
	beq P2_Entry_03800950	; 03800948
	cmp r6,#0xe3	; 0380094A
	beq P2_Entry_0380095A	; 0380094C
	b P2_Entry_03800B90	; 0380094E
P2_Entry_03800950:
	ldr r0,[sp,#0x4]	; 03800950
	strh r1,[r0,#0x18]	; 03800952
	b P2_Entry_03800B90	; 03800954
P2_Entry_03800956:
	strh r1,[r4,#0x1c]	; 03800956
	b P2_Entry_03800B90	; 03800958
P2_Entry_0380095A:
	strh r1,[r4,#0x16]	; 0380095A
	b P2_Entry_03800B90	; 0380095C
P2_Entry_0380095E:
	add r0,r4,#0x0	; 0380095E
	bl loc_03801180	; 03800960
	str r0,[sp,#0x14]	; 03800964
	cmp r5,#0x0	; 03800966
	beq P2_Entry_0380096E	; 03800968
	ldr r2,[sp,#0x8]	; 0380096A
	b P2_Entry_03800970	; 0380096C
P2_Entry_0380096E:
	mov r2,#0x1	; 0380096E
P2_Entry_03800970:
	add r0,r4,#0x0	; 03800970
	ldr r1,[sp,#0x4]	; 03800972
	bl P2_Entry_03801054	; 03800974
	lsl r0,r0,#0x10	; 03800978
	asr r7,r0,#0x10	; 0380097A
	ldr r0,[sp,#0x4]	; 0380097C
	ldr r1,[sp,#0x14]	; 0380097E
	bl loc_03800500	; 03800980
	add r5,r0,#0x0	; 03800984
	ldr r0,[sp,#0xc]	; 03800986
	cmp r0,#0x0	; 03800988
	bne P2_Entry_0380098E	; 0380098A
	b P2_Entry_03800B90	; 0380098C
P2_Entry_0380098E:
	cmp r5,#0x0	; 0380098E
	bne P2_Entry_03800994	; 03800990
	b P2_Entry_03800B90	; 03800992
P2_Entry_03800994:
	sub r6,#0xb0	; 03800994
	cmp r6,#0xd	; 03800996
	bls P2_Entry_0380099C	; 03800998
	b P2_Entry_03800B90	; 0380099A
P2_Entry_0380099C:
	add r0,r6,r6	; 0380099C
P2_SwitchIndexPC_0380099C:
	add r0,pc	; 0380099E
	ldrh r0,[r0,#(P2_SwitchTable_0380099C - (P2_SwitchIndexPC_0380099C + 4))]	; 038009A0
	lsl r0,r0,#0x10	; 038009A2
	asr r0,r0,#0x10	; 038009A4
P2_SwitchTargetPC_0380099C:
	add r0,pc	; 038009A6
	bx r0	; 038009A8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380099C:
	.halfword (P2_Case_038009C6 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_038009CA + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_038009D4 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_038009DE + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_038009E8 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_038009FC + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800A16 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Entry_03800B90 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800A24 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800A4C + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800A70 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800A94 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800AB8 + 1) - (P2_SwitchTargetPC_0380099C + 4)
	.halfword (P2_Case_03800ADC + 1) - (P2_SwitchTargetPC_0380099C + 4)
P2_SwitchTable_0380099CEnd:
P2_Case_038009C6:
	strh r7,[r5,#0x0]	; 038009C6
	b P2_Entry_03800B90	; 038009C8
P2_Case_038009CA:
	mov r0,#0x0	; 038009CA
	ldrsh r0,[r5,r0]	; 038009CC
	add r0,r0,r7	; 038009CE
	strh r0,[r5,#0x0]	; 038009D0
	b P2_Entry_03800B90	; 038009D2
P2_Case_038009D4:
	mov r0,#0x0	; 038009D4
	ldrsh r0,[r5,r0]	; 038009D6
	sub r0,r0,r7	; 038009D8
	strh r0,[r5,#0x0]	; 038009DA
	b P2_Entry_03800B90	; 038009DC
P2_Case_038009DE:
	mov r0,#0x0	; 038009DE
	ldrsh r0,[r5,r0]	; 038009E0
	mul r0,r7	; 038009E2
	strh r0,[r5,#0x0]	; 038009E4
	b P2_Entry_03800B90	; 038009E6
P2_Case_038009E8:
	cmp r7,#0x0	; 038009E8
	bne P2_Entry_038009EE	; 038009EA
	b P2_Entry_03800B90	; 038009EC
P2_Entry_038009EE:
	mov r0,#0x0	; 038009EE
	ldrsh r0,[r5,r0]	; 038009F0
	add r1,r7,#0x0	; 038009F2
	bl loc_037FE2FC	; 038009F4
	strh r0,[r5,#0x0]	; 038009F8
	b P2_Entry_03800B90	; 038009FA
P2_Case_038009FC:
	cmp r7,#0x0	; 038009FC
	blt P2_Entry_03800A0A	; 038009FE
	mov r0,#0x0	; 03800A00
	ldrsh r0,[r5,r0]	; 03800A02
	lsl r0,r7	; 03800A04
	strh r0,[r5,#0x0]	; 03800A06
	b P2_Entry_03800B90	; 03800A08
P2_Entry_03800A0A:
	mov r0,#0x0	; 03800A0A
	ldrsh r1,[r5,r0]	; 03800A0C
	neg r0,r7	; 03800A0E
	asr r1,r0	; 03800A10
	strh r1,[r5,#0x0]	; 03800A12
	b P2_Entry_03800B90	; 03800A14
P2_Case_03800A16:
	bl loc_037FF7BC	; 03800A16
	add r1,r7,#0x1	; 03800A1A
	mul r0,r1	; 03800A1C
	asr r0,r0,#0x10	; 03800A1E
	strh r0,[r5,#0x0]	; 03800A20
	b P2_Entry_03800B90	; 03800A22
P2_Case_03800A24:
	mov r0,#0x0	; 03800A24
	ldrsh r0,[r5,r0]	; 03800A26
	cmp r0,r7	; 03800A28
	bne P2_Entry_03800A34	; 03800A2A
	mov r2,#0x1	; 03800A2C
	b P2_Entry_03800A36	; 03800A2E
pool_03800A30:
	.word 0x00010000	; 03800A30
P2_Entry_03800A34:
	mov r2,#0x0	; 03800A34
P2_Entry_03800A36:
	ldrb r0,[r4,#0x0]	; 03800A36
	mov r1,#0x40	; 03800A38
	bic r0,r1	; 03800A3A
	lsl r1,r2,#0x18	; 03800A3C
	lsr r2,r1,#0x18	; 03800A3E
	mov r1,#0x1	; 03800A40
	and r2,r1	; 03800A42
	lsl r1,r2,#0x6	; 03800A44
	orr r0,r1	; 03800A46
	strb r0,[r4,#0x0]	; 03800A48
	b P2_Entry_03800B90	; 03800A4A
P2_Case_03800A4C:
	mov r0,#0x0	; 03800A4C
	ldrsh r0,[r5,r0]	; 03800A4E
	cmp r0,r7	; 03800A50
	blt P2_Entry_03800A58	; 03800A52
	mov r2,#0x1	; 03800A54
	b P2_Entry_03800A5A	; 03800A56
P2_Entry_03800A58:
	mov r2,#0x0	; 03800A58
P2_Entry_03800A5A:
	ldrb r0,[r4,#0x0]	; 03800A5A
	mov r1,#0x40	; 03800A5C
	bic r0,r1	; 03800A5E
	lsl r1,r2,#0x18	; 03800A60
	lsr r2,r1,#0x18	; 03800A62
	mov r1,#0x1	; 03800A64
	and r2,r1	; 03800A66
	lsl r1,r2,#0x6	; 03800A68
	orr r0,r1	; 03800A6A
	strb r0,[r4,#0x0]	; 03800A6C
	b P2_Entry_03800B90	; 03800A6E
P2_Case_03800A70:
	mov r0,#0x0	; 03800A70
	ldrsh r0,[r5,r0]	; 03800A72
	cmp r0,r7	; 03800A74
	ble P2_Entry_03800A7C	; 03800A76
	mov r2,#0x1	; 03800A78
	b P2_Entry_03800A7E	; 03800A7A
P2_Entry_03800A7C:
	mov r2,#0x0	; 03800A7C
P2_Entry_03800A7E:
	ldrb r0,[r4,#0x0]	; 03800A7E
	mov r1,#0x40	; 03800A80
	bic r0,r1	; 03800A82
	lsl r1,r2,#0x18	; 03800A84
	lsr r2,r1,#0x18	; 03800A86
	mov r1,#0x1	; 03800A88
	and r2,r1	; 03800A8A
	lsl r1,r2,#0x6	; 03800A8C
	orr r0,r1	; 03800A8E
	strb r0,[r4,#0x0]	; 03800A90
	b P2_Entry_03800B90	; 03800A92
P2_Case_03800A94:
	mov r0,#0x0	; 03800A94
	ldrsh r0,[r5,r0]	; 03800A96
	cmp r0,r7	; 03800A98
	bgt P2_Entry_03800AA0	; 03800A9A
	mov r2,#0x1	; 03800A9C
	b P2_Entry_03800AA2	; 03800A9E
P2_Entry_03800AA0:
	mov r2,#0x0	; 03800AA0
P2_Entry_03800AA2:
	ldrb r0,[r4,#0x0]	; 03800AA2
	mov r1,#0x40	; 03800AA4
	bic r0,r1	; 03800AA6
	lsl r1,r2,#0x18	; 03800AA8
	lsr r2,r1,#0x18	; 03800AAA
	mov r1,#0x1	; 03800AAC
	and r2,r1	; 03800AAE
	lsl r1,r2,#0x6	; 03800AB0
	orr r0,r1	; 03800AB2
	strb r0,[r4,#0x0]	; 03800AB4
	b P2_Entry_03800B90	; 03800AB6
P2_Case_03800AB8:
	mov r0,#0x0	; 03800AB8
	ldrsh r0,[r5,r0]	; 03800ABA
	cmp r0,r7	; 03800ABC
	bge P2_Entry_03800AC4	; 03800ABE
	mov r2,#0x1	; 03800AC0
	b P2_Entry_03800AC6	; 03800AC2
P2_Entry_03800AC4:
	mov r2,#0x0	; 03800AC4
P2_Entry_03800AC6:
	ldrb r0,[r4,#0x0]	; 03800AC6
	mov r1,#0x40	; 03800AC8
	bic r0,r1	; 03800ACA
	lsl r1,r2,#0x18	; 03800ACC
	lsr r2,r1,#0x18	; 03800ACE
	mov r1,#0x1	; 03800AD0
	and r2,r1	; 03800AD2
	lsl r1,r2,#0x6	; 03800AD4
	orr r0,r1	; 03800AD6
	strb r0,[r4,#0x0]	; 03800AD8
	b P2_Entry_03800B90	; 03800ADA
P2_Case_03800ADC:
	mov r0,#0x0	; 03800ADC
	ldrsh r0,[r5,r0]	; 03800ADE
	cmp r0,r7	; 03800AE0
	beq P2_Entry_03800AE8	; 03800AE2
	mov r2,#0x1	; 03800AE4
	b P2_Entry_03800AEA	; 03800AE6
P2_Entry_03800AE8:
	mov r2,#0x0	; 03800AE8
P2_Entry_03800AEA:
	ldrb r0,[r4,#0x0]	; 03800AEA
	mov r1,#0x40	; 03800AEC
	bic r0,r1	; 03800AEE
	lsl r1,r2,#0x18	; 03800AF0
	lsr r2,r1,#0x18	; 03800AF2
	mov r1,#0x1	; 03800AF4
	and r2,r1	; 03800AF6
	lsl r1,r2,#0x6	; 03800AF8
	orr r0,r1	; 03800AFA
	strb r0,[r4,#0x0]	; 03800AFC
	b P2_Entry_03800B90	; 03800AFE
P2_Entry_03800B00:
	ldr r0,[sp,#0xc]	; 03800B00
	cmp r0,#0x0	; 03800B02
	beq P2_Entry_03800B90	; 03800B04
	sub r6,#0xfc	; 03800B06
	cmp r6,#0x3	; 03800B08
	bhi P2_Entry_03800B90	; 03800B0A
	add r0,r6,r6	; 03800B0C
P2_SwitchIndexPC_03800B0C:
	add r0,pc	; 03800B0E
	ldrh r0,[r0,#(P2_SwitchTable_03800B0C - (P2_SwitchIndexPC_03800B0C + 4))]	; 03800B10
	lsl r0,r0,#0x10	; 03800B12
	asr r0,r0,#0x10	; 03800B14
P2_SwitchTargetPC_03800B0C:
	add r0,pc	; 03800B16
	bx r0	; 03800B18
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800B0C:
	.halfword (P2_Case_03800B46 + 1) - (P2_SwitchTargetPC_03800B0C + 4)
	.halfword (P2_Case_03800B22 + 1) - (P2_SwitchTargetPC_03800B0C + 4)
	.halfword (P2_Entry_03800B90 + 1) - (P2_SwitchTargetPC_03800B0C + 4)
	.halfword (P2_Case_03800B8A + 1) - (P2_SwitchTargetPC_03800B0C + 4)
P2_SwitchTable_03800B0CEnd:
P2_Case_03800B22:
	add r0,r4,#0x0	; 03800B22
	add r0,#0x3b	; 03800B24
	ldrb r0,[r0,#0x0]	; 03800B26
	cmp r0,#0x0	; 03800B28
	beq P2_Entry_03800B90	; 03800B2A
	add r1,r4,#0x0	; 03800B2C
	add r1,#0x3b	; 03800B2E
	ldrb r0,[r1,#0x0]	; 03800B30
	sub r0,r0,#0x1	; 03800B32
	strb r0,[r1,#0x0]	; 03800B34
	add r0,r4,#0x0	; 03800B36
	add r0,#0x3b	; 03800B38
	ldrb r0,[r0,#0x0]	; 03800B3A
	lsl r0,r0,#0x2	; 03800B3C
	add r0,r4,r0	; 03800B3E
	ldr r0,[r0,#0x2c]	; 03800B40
	str r0,[r4,#0x28]	; 03800B42
	b P2_Entry_03800B90	; 03800B44
P2_Case_03800B46:
	add r0,r4,#0x0	; 03800B46
	add r0,#0x3b	; 03800B48
	ldrb r0,[r0,#0x0]	; 03800B4A
	cmp r0,#0x0	; 03800B4C
	beq P2_Entry_03800B90	; 03800B4E
	sub r0,r0,#0x1	; 03800B50
	add r1,r4,r0	; 03800B52
	add r0,r1,#0x0	; 03800B54
	add r0,#0x38	; 03800B56
	ldrb r0,[r0,#0x0]	; 03800B58
	cmp r0,#0x0	; 03800B5A
	beq P2_Entry_03800B74	; 03800B5C
	sub r0,r0,#0x1	; 03800B5E
	lsl r0,r0,#0x18	; 03800B60
	lsr r0,r0,#0x18	; 03800B62
	cmp r0,#0x0	; 03800B64
	bne P2_Entry_03800B74	; 03800B66
	add r1,r4,#0x0	; 03800B68
	add r1,#0x3b	; 03800B6A
	ldrb r0,[r1,#0x0]	; 03800B6C
	sub r0,r0,#0x1	; 03800B6E
	strb r0,[r1,#0x0]	; 03800B70
	b P2_Entry_03800B90	; 03800B72
P2_Entry_03800B74:
	add r1,#0x38	; 03800B74
	strb r0,[r1,#0x0]	; 03800B76
	add r0,r4,#0x0	; 03800B78
	add r0,#0x3b	; 03800B7A
	ldrb r0,[r0,#0x0]	; 03800B7C
	sub r0,r0,#0x1	; 03800B7E
	lsl r0,r0,#0x2	; 03800B80
	add r0,r4,r0	; 03800B82
	ldr r0,[r0,#0x2c]	; 03800B84
	str r0,[r4,#0x28]	; 03800B86
	b P2_Entry_03800B90	; 03800B88
P2_Case_03800B8A:
	mov r0,#0x0	; 03800B8A
	mvn r0,r0	; 03800B8C
	b P2_Entry_03800BA4	; 03800B8E
P2_Entry_03800B90:
	ldr r0,[r4,#0x20]	; 03800B90
	cmp r0,#0x0	; 03800B92
	bne P2_Entry_03800BA2	; 03800B94
	ldrb r0,[r4,#0x0]	; 03800B96
	lsl r0,r0,#0x1b	; 03800B98
	lsr r0,r0,#0x1f	; 03800B9A
	cmp r0,#0x0	; 03800B9C
	bne P2_Entry_03800BA2	; 03800B9E
	b P2_Entry_038005CA	; 03800BA0
P2_Entry_03800BA2:
	mov r0,#0x0	; 03800BA2
P2_Entry_03800BA4:
	add sp,#0x24	; 03800BA4
	pop {r4,r5,r6,r7}	; 03800BA6
	pop {r3}	; 03800BA8
	bx r3	; 03800BAA
P2_Entry_03800BAC:
	push {r4,r5,r6,r7,lr}	; 03800BAC
	sub sp,#0x1c	; 03800BAE
	add r4,r0,#0x0	; 03800BB0
	add r6,r1,#0x0	; 03800BB2
	add r7,r2,#0x0	; 03800BB4
	str r3,[sp,#0x8]	; 03800BB6
	mov r5,#0x0	; 03800BB8
	ldr r1,[sp,#0x30]	; 03800BBA
	ldrh r0,[r6,#0x18]	; 03800BBC
	ldrh r2,[r6,#0x1a]	; 03800BBE
	mul r0,r2	; 03800BC0
	mov r2,#0xf0	; 03800BC2
	mul r1,r2	; 03800BC4
	asr r2,r0,#0x8	; 03800BC6
	sub r0,r2,#0x1	; 03800BC8
	add r0,r1,r0	; 03800BCA
	add r1,r2,#0x0	; 03800BCC
	bl loc_037FE2FC	; 03800BCE
	str r0,[sp,#0xc]	; 03800BD2
	ldrb r0,[r4,#0x0]	; 03800BD4
	lsl r0,r0,#0x1c	; 03800BD6
	lsr r0,r0,#0x1f	; 03800BD8
	cmp r0,#0x0	; 03800BDA
	beq P2_Entry_03800BEA	; 03800BDC
	ldr r5,[r4,#0x3c]	; 03800BDE
	cmp r5,#0x0	; 03800BE0
	beq P2_Entry_03800BEA	; 03800BE2
	strb r7,[r5,#0x8]	; 03800BE4
	ldr r0,[sp,#0x8]	; 03800BE6
	strb r0,[r5,#0x9]	; 03800BE8
P2_Entry_03800BEA:
	cmp r5,#0x0	; 03800BEA
	bne P2_Entry_03800C86	; 03800BEC
	ldr r0,[r6,#0x20]	; 03800BEE
	ldrh r1,[r4,#0x2]	; 03800BF0
	add r2,r7,#0x0	; 03800BF2
	add r3,sp,#0x10	; 03800BF4
	bl P2_Entry_0380167C	; 03800BF6
	cmp r0,#0x0	; 03800BFA
	beq P2_Entry_03800CFE	; 03800BFC
	add r0,sp,#0x10	; 03800BFE
	ldrb r0,[r0,#0x0]	; 03800C00
	cmp r0,#0x4	; 03800C02
	bhi P2_Entry_03800CFE	; 03800C04
	add r0,r0,r0	; 03800C06
P2_SwitchIndexPC_03800C06:
	add r0,pc	; 03800C08
	ldrh r0,[r0,#(P2_SwitchTable_03800C06 - (P2_SwitchIndexPC_03800C06 + 4))]	; 03800C0A
	lsl r0,r0,#0x10	; 03800C0C
	asr r0,r0,#0x10	; 03800C0E
P2_SwitchTargetPC_03800C06:
	add r0,pc	; 03800C10
	bx r0	; 03800C12
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800C06:
	.halfword (P2_Case_03800C2A + 1) - (P2_SwitchTargetPC_03800C06 + 4)
	.halfword (P2_Case_03800C1E + 1) - (P2_SwitchTargetPC_03800C06 + 4)
	.halfword (P2_Case_03800C22 + 1) - (P2_SwitchTargetPC_03800C06 + 4)
	.halfword (P2_Case_03800C26 + 1) - (P2_SwitchTargetPC_03800C06 + 4)
	.halfword (P2_Case_03800C1E + 1) - (P2_SwitchTargetPC_03800C06 + 4)
P2_SwitchTable_03800C06End:
P2_Case_03800C1E:
	ldr r0,[pool_03800D08]	; 03800C1E
	b P2_Entry_03800C2C	; 03800C20
P2_Case_03800C22:
	ldr r0,[pool_03800D0C]	; 03800C22
	b P2_Entry_03800C2C	; 03800C24
P2_Case_03800C26:
	ldr r0,[pool_03800D10]	; 03800C26
	b P2_Entry_03800C2C	; 03800C28
P2_Case_03800C2A:
	b P2_Entry_03800CFE	; 03800C2A
P2_Entry_03800C2C:
	ldrh r1,[r4,#0x1e]	; 03800C2C
	and r0,r1	; 03800C2E
	str r4,[sp,#0x0]	; 03800C30
	ldrb r2,[r6,#0x4]	; 03800C32
	ldrb r1,[r4,#0x12]	; 03800C34
	add r1,r2,r1	; 03800C36
	ldrb r2,[r4,#0x0]	; 03800C38
	lsl r2,r2,#0x18	; 03800C3A
	lsr r2,r2,#0x1f	; 03800C3C
	ldr r3,[pool_03800D14]	; 03800C3E
	bl P2_Entry_037FFFB4	; 03800C40
	add r5,r0,#0x0	; 03800C44
	cmp r5,#0x0	; 03800C46
	beq P2_Entry_03800CFE	; 03800C48
	ldrb r0,[r4,#0x0]	; 03800C4A
	lsl r0,r0,#0x1c	; 03800C4C
	lsr r0,r0,#0x1f	; 03800C4E
	cmp r0,#0x0	; 03800C50
	beq P2_Entry_03800C58	; 03800C52
	mov r3,#0x0	; 03800C54
	b P2_Entry_03800C5A	; 03800C56
P2_Entry_03800C58:
	ldr r3,[sp,#0xc]	; 03800C58
P2_Entry_03800C5A:
	ldr r0,[r6,#0x20]	; 03800C5A
	str r0,[sp,#0x0]	; 03800C5C
	add r0,sp,#0x10	; 03800C5E
	str r0,[sp,#0x4]	; 03800C60
	add r0,r5,#0x0	; 03800C62
	add r1,r7,#0x0	; 03800C64
	ldr r2,[sp,#0x8]	; 03800C66
	bl P2_Entry_038015C8	; 03800C68
	cmp r0,#0x0	; 03800C6C
	bne P2_Entry_03800C80	; 03800C6E
	mov r1,#0x0	; 03800C70
	add r0,r5,#0x0	; 03800C72
	add r0,#0x22	; 03800C74
	strb r1,[r0,#0x0]	; 03800C76
	add r0,r5,#0x0	; 03800C78
	bl loc_037FFFA8	; 03800C7A
	b P2_Entry_03800CFE	; 03800C7E
P2_Entry_03800C80:
	ldr r0,[r4,#0x3c]	; 03800C80
	str r0,[r5,#0x50]	; 03800C82
	str r5,[r4,#0x3c]	; 03800C84
P2_Entry_03800C86:
	ldrb r1,[r4,#0xe]	; 03800C86
	cmp r1,#0xff	; 03800C88
	beq P2_Entry_03800C92	; 03800C8A
	add r0,r5,#0x0	; 03800C8C
	bl loc_038000B4	; 03800C8E
P2_Entry_03800C92:
	ldrb r1,[r4,#0xf]	; 03800C92
	cmp r1,#0xff	; 03800C94
	beq P2_Entry_03800C9E	; 03800C96
	add r0,r5,#0x0	; 03800C98
	bl loc_038000A0	; 03800C9A
P2_Entry_03800C9E:
	ldrb r1,[r4,#0x10]	; 03800C9E
	cmp r1,#0xff	; 03800CA0
	beq P2_Entry_03800CAA	; 03800CA2
	add r0,r5,#0x0	; 03800CA4
	bl loc_0380009C	; 03800CA6
P2_Entry_03800CAA:
	ldrb r1,[r4,#0x11]	; 03800CAA
	cmp r1,#0xff	; 03800CAC
	beq P2_Entry_03800CB6	; 03800CAE
	add r0,r5,#0x0	; 03800CB0
	bl loc_03800088	; 03800CB2
P2_Entry_03800CB6:
	mov r0,#0x16	; 03800CB6
	ldrsh r0,[r4,r0]	; 03800CB8
	strh r0,[r5,#0x32]	; 03800CBA
	ldrb r0,[r4,#0x0]	; 03800CBC
	lsl r0,r0,#0x1a	; 03800CBE
	lsr r0,r0,#0x1f	; 03800CC0
	cmp r0,#0x0	; 03800CC2
	beq P2_Entry_03800CDA	; 03800CC4
	add r1,r5,#0x0	; 03800CC6
	add r1,#0x32	; 03800CC8
	mov r0,#0x0	; 03800CCA
	ldrsh r0,[r1,r0]	; 03800CCC
	ldrb r2,[r4,#0x14]	; 03800CCE
	sub r2,r2,r7	; 03800CD0
	lsl r2,r2,#0x16	; 03800CD2
	asr r2,r2,#0x10	; 03800CD4
	add r0,r0,r2	; 03800CD6
	strh r0,[r1,#0x0]	; 03800CD8
P2_Entry_03800CDA:
	ldrb r0,[r4,#0x15]	; 03800CDA
	cmp r0,#0x0	; 03800CDC
	bne P2_Entry_03800CE6	; 03800CDE
	ldr r0,[sp,#0xc]	; 03800CE0
	str r0,[r5,#0x18]	; 03800CE2
	b P2_Entry_03800CFA	; 03800CE4
P2_Entry_03800CE6:
	add r1,r0,#0x0	; 03800CE6
	mul r1,r0	; 03800CE8
	mov r0,#0x32	; 03800CEA
	ldrsh r0,[r5,r0]	; 03800CEC
	cmp r0,#0x0	; 03800CEE
	bge P2_Entry_03800CF4	; 03800CF0
	neg r0,r0	; 03800CF2
P2_Entry_03800CF4:
	mul r1,r0	; 03800CF4
	asr r0,r1,#0xb	; 03800CF6
	str r0,[r5,#0x18]	; 03800CF8
P2_Entry_03800CFA:
	mov r0,#0x0	; 03800CFA
	str r0,[r5,#0x14]	; 03800CFC
P2_Entry_03800CFE:
	add sp,#0x1c	; 03800CFE
	pop {r4,r5,r6,r7}	; 03800D00
	pop {r3}	; 03800D02
	bx r3	; 03800D04
	.byte 0xC0, 0x46	; 03800D06
pool_03800D08:
	.word 0x0000FFFF	; 03800D08
pool_03800D0C:
	.word 0x00003F00	; 03800D0C
pool_03800D10:
	.word 0x0000C000	; 03800D10
pool_03800D14:
	.word 0x03800DC1	; 03800D14
P2_Entry_03800D18:
	push {r4,r5,lr}	; 03800D18
	sub sp,#0x4	; 03800D1A
	add r5,r0,#0x0	; 03800D1C
	mov r4,#0x0	; 03800D1E
P2_Entry_03800D20:
	add r0,r5,#0x0	; 03800D20
	add r1,r4,#0x0	; 03800D22
	bl loc_03800E78	; 03800D24
	cmp r0,#0x0	; 03800D28
	beq P2_Entry_03800D32	; 03800D2A
	add r1,r5,#0x0	; 03800D2C
	bl loc_03800D40	; 03800D2E
P2_Entry_03800D32:
	add r4,r4,#0x1	; 03800D32
	cmp r4,#0x10	; 03800D34
	blt P2_Entry_03800D20	; 03800D36
	add sp,#0x4	; 03800D38
	pop {r4,r5}	; 03800D3A
	pop {r3}	; 03800D3C
	bx r3	; 03800D3E

; ===== function loc_03800D40 =====
loc_03800D40:
	push {r4,r5,r6,r7,lr}	; 03800D40
	sub sp,#0x4	; 03800D42
	add r2,r0,#0x0	; 03800D44
	ldr r0,[r2,#0x3c]	; 03800D46
	mov r3,#0x6	; 03800D48
	ldrsh r6,[r1,r3]	; 03800D4A
	mov r3,#0xa	; 03800D4C
	ldrsh r5,[r2,r3]	; 03800D4E
	ldrb r1,[r1,#0x5]	; 03800D50
	lsl r1,r1,#0x1	; 03800D52
	ldr r4,[pool_03800DBC]	; 03800D54
	ldrsh r3,[r4,r1]	; 03800D56
	ldrb r1,[r2,#0x4]	; 03800D58
	lsl r1,r1,#0x1	; 03800D5A
	ldrsh r1,[r4,r1]	; 03800D5C
	ldrb r7,[r2,#0x5]	; 03800D5E
	lsl r7,r7,#0x1	; 03800D60
	ldrsh r4,[r4,r7]	; 03800D62
	add r1,r1,r4	; 03800D64
	add r1,r3,r1	; 03800D66
	add r1,r5,r1	; 03800D68
	add r4,r6,r1	; 03800D6A
	mov r1,#0x8	; 03800D6C
	ldrsb r3,[r2,r1]	; 03800D6E
	mov r1,#0x9	; 03800D70
	ldrsb r1,[r2,r1]	; 03800D72
	add r3,r3,r1	; 03800D74
	mov r1,#0x6	; 03800D76
	ldrsb r5,[r2,r1]	; 03800D78
	ldrb r1,[r2,#0x7]	; 03800D7A
	lsl r1,r1,#0x6	; 03800D7C
	mul r5,r1	; 03800D7E
	asr r5,r5,#0x7	; 03800D80
	mov r1,#0xc	; 03800D82
	ldrsh r1,[r2,r1]	; 03800D84
	add r1,r5,r1	; 03800D86
	mov r5,#0x7f	; 03800D88
	mvn r6,r5	; 03800D8A
	cmp r3,r6	; 03800D8C
	bge loc_03800D94	; 03800D8E
	add r3,r6,#0x0	; 03800D90
	b loc_03800DB0	; 03800D92
loc_03800D94:
	cmp r3,#0x7f	; 03800D94
	ble loc_03800DB0	; 03800D96
	add r3,r5,#0x0	; 03800D98
	b loc_03800DB0	; 03800D9A
loc_03800D9C:
	strh r4,[r0,#0xc]	; 03800D9C
	strh r1,[r0,#0xe]	; 03800D9E
	strb r3,[r0,#0xb]	; 03800DA0
	ldrh r5,[r2,#0x18]	; 03800DA2
	strh r5,[r0,#0x28]	; 03800DA4
	ldrh r5,[r2,#0x1a]	; 03800DA6
	strh r5,[r0,#0x2a]	; 03800DA8
	ldrh r5,[r2,#0x1c]	; 03800DAA
	strh r5,[r0,#0x2c]	; 03800DAC
	ldr r0,[r0,#0x50]	; 03800DAE
loc_03800DB0:
	cmp r0,#0x0	; 03800DB0
	bne loc_03800D9C	; 03800DB2
	add sp,#0x4	; 03800DB4
	pop {r4,r5,r6,r7}	; 03800DB6
	pop {r3}	; 03800DB8
	bx r3	; 03800DBA
pool_03800DBC:
loc_03800DBC:
	.word P2_Data_03805128	; 03800DBC
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x14, 0x1C, 0x01, 0x29, 0x06, 0xD1, 0x01, 0x22, 0x29, 0x1C	; 03800DD0
	.byte 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xE8, 0xF8, 0x07, 0xE0, 0x02, 0x29, 0x05, 0xD1, 0x00, 0x22	; 03800DE0
	.byte 0x29, 0x1C, 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xDF, 0xF8, 0xE1, 0x6B, 0xA9, 0x42, 0x08, 0xD1	; 03800DF0
	.byte 0x28, 0x6D, 0xE0, 0x63, 0x08, 0xE0, 0xA8, 0x42, 0x02, 0xD1, 0x28, 0x6D, 0x08, 0x65, 0x03, 0xE0	; 03800E00
	.byte 0x01, 0x1C, 0x08, 0x6D, 0x00, 0x28, 0xF6, 0xD1, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03800E10

; ===== function loc_03800E10 =====
loc_03800E10:
	push {r4,r5,lr}	; 03800E10
	sub sp,#0x4	; 03800E12
	add r4,r0,#0x0	; 03800E14
	mov r5,#0x0	; 03800E16
loc_03800E18:
	add r0,r4,#0x0	; 03800E18
	add r1,r5,#0x0	; 03800E1A
	bl loc_03800E34	; 03800E1C
	add r5,r5,#0x1	; 03800E20
	cmp r5,#0x10	; 03800E22
	blt loc_03800E18	; 03800E24
	mov r0,#0x0	; 03800E26
	strb r0,[r4,#0x0]	; 03800E28
	add sp,#0x4	; 03800E2A
	pop {r4,r5}	; 03800E2C
	pop {r3}	; 03800E2E
	bx r3	; 03800E30
	.byte 0x00, 0x00	; 03800E34

; ===== function loc_03800E34 =====
loc_03800E34:
	push {r4,r5,lr}	; 03800E34
	sub sp,#0x4	; 03800E36
	add r5,r0,#0x0	; 03800E38
	add r4,r1,#0x0	; 03800E3A
	bl loc_03800E78	; 03800E3C
	cmp r0,#0x0	; 03800E40
	beq loc_03800E5E	; 03800E42
	add r1,r5,#0x0	; 03800E44
	bl loc_03800E6C	; 03800E46
	add r5,#0x8	; 03800E4A
	ldr r3,[pool_03800E68]	; 03800E4C
	ldrb r0,[r5,r4]	; 03800E4E
	lsl r2,r0,#0x6	; 03800E50
	ldrb r1,[r3,r2]	; 03800E52
	mov r0,#0x1	; 03800E54
	bic r1,r0	; 03800E56
	strb r1,[r3,r2]	; 03800E58
	mov r0,#0xff	; 03800E5A
	strb r0,[r5,r4]	; 03800E5C
loc_03800E5E:
	add sp,#0x4	; 03800E5E
	pop {r4,r5}	; 03800E60
	pop {r3}	; 03800E62
	bx r3	; 03800E64
	.byte 0xC0, 0x46	; 03800E68
pool_03800E68:
loc_03800E68:
	.word P2_BssStart + 0x1304	; 03800E68

; ===== function loc_03800E6C =====
loc_03800E6C:
	mov r2,#0x0	; 03800E6C
	mvn r2,r2	; 03800E6E
	ldr r3,[pool_03800E74]	; 03800E70
	bx r3	; 03800E72
pool_03800E74:
loc_03800E74:
	.word loc_03800F00 + 1	; 03800E74

; ===== function loc_03800E78 =====
loc_03800E78:
	cmp r1,#0xf	; 03800E78
	ble loc_03800E80	; 03800E7A
	mov r0,#0x0	; 03800E7C
	bx lr	; 03800E7E
loc_03800E80:
	add r0,r0,r1	; 03800E80
	ldrb r0,[r0,#0x8]	; 03800E82
	cmp r0,#0xff	; 03800E84
	bne loc_03800E8C	; 03800E86
	mov r0,#0x0	; 03800E88
	bx lr	; 03800E8A
loc_03800E8C:
	ldr r1,[pool_03800E94]	; 03800E8C
	lsl r0,r0,#0x6	; 03800E8E
	add r0,r1,r0	; 03800E90
	bx lr	; 03800E92
pool_03800E94:
loc_03800E94:
	.word 0x038066A4	; 03800E94
P2_Entry_03800E98:
	push {r4,r5,lr}	; 03800E98
	sub sp,#0x4	; 03800E9A
	add r5,r0,#0x0	; 03800E9C
	mov r4,#0x0	; 03800E9E
	add r1,r5,#0x0	; 03800EA0
	add r1,#0x1c	; 03800EA2
	b P2_Entry_03800EAE	; 03800EA4
P2_Entry_03800EA6:
	ldrh r0,[r1,#0x0]	; 03800EA6
	sub r0,#0xf0	; 03800EA8
	strh r0,[r1,#0x0]	; 03800EAA
	add r4,r4,#0x1	; 03800EAC
P2_Entry_03800EAE:
	ldrh r0,[r5,#0x1c]	; 03800EAE
	cmp r0,#0xf0	; 03800EB0
	bcs P2_Entry_03800EA6	; 03800EB2
	ldr r0,[pool_03800EFC]	; 03800EB4
	ldr r2,[r0,#0x0]	; 03800EB6
	cmp r2,#0x0	; 03800EB8
	beq P2_Entry_03800EE0	; 03800EBA
	add r2,#0x40	; 03800EBC
	ldrb r1,[r5,#0x2]	; 03800EBE
	mov r0,#0x24	; 03800EC0
	mul r1,r0	; 03800EC2
	ldr r0,[r2,r1]	; 03800EC4
	add r0,r0,r4	; 03800EC6
	str r0,[r2,r1]	; 03800EC8
	b P2_Entry_03800EE0	; 03800ECA
P2_Entry_03800ECC:
	add r0,r5,#0x0	; 03800ECC
	bl P2_Entry_03800534	; 03800ECE
	cmp r0,#0x0	; 03800ED2
	beq P2_Entry_03800EDE	; 03800ED4
	add r0,r5,#0x0	; 03800ED6
	bl loc_03800E10	; 03800ED8
	b P2_Entry_03800EE4	; 03800EDC
P2_Entry_03800EDE:
	sub r4,r4,#0x1	; 03800EDE
P2_Entry_03800EE0:
	cmp r4,#0x0	; 03800EE0
	bgt P2_Entry_03800ECC	; 03800EE2
P2_Entry_03800EE4:
	ldrh r2,[r5,#0x18]	; 03800EE4
	ldrh r0,[r5,#0x1a]	; 03800EE6
	mul r2,r0	; 03800EE8
	add r5,#0x1c	; 03800EEA
	ldrh r1,[r5,#0x0]	; 03800EEC
	asr r0,r2,#0x8	; 03800EEE
	add r0,r1,r0	; 03800EF0
	strh r0,[r5,#0x0]	; 03800EF2
	add sp,#0x4	; 03800EF4
	pop {r4,r5}	; 03800EF6
	pop {r3}	; 03800EF8
	bx r3	; 03800EFA
pool_03800EFC:
	.word P2_BssStart + 0xB80	; 03800EFC

; ===== function loc_03800F00 =====
loc_03800F00:
	push {r4,r5,r6,r7,lr}	; 03800F00
	sub sp,#0x4	; 03800F02
	add r5,r0,#0x0	; 03800F04
	add r6,r2,#0x0	; 03800F06
	ldr r4,[r5,#0x3c]	; 03800F08
	bl loc_03800D40	; 03800F0A
	lsl r0,r6,#0x18	; 03800F0E
	lsr r7,r0,#0x18	; 03800F10
	b loc_03800F40	; 03800F12
loc_03800F14:
	add r0,r4,#0x0	; 03800F14
	bl loc_03800078	; 03800F16
	cmp r0,#0x0	; 03800F1A
	beq loc_03800F38	; 03800F1C
	cmp r6,#0x0	; 03800F1E
	blt loc_03800F2A	; 03800F20
	add r0,r4,#0x0	; 03800F22
	add r1,r7,#0x0	; 03800F24
	bl loc_03800088	; 03800F26
loc_03800F2A:
	add r1,r4,#0x0	; 03800F2A
	add r1,#0x22	; 03800F2C
	mov r0,#0x1	; 03800F2E
	strb r0,[r1,#0x0]	; 03800F30
	add r0,r4,#0x0	; 03800F32
	bl loc_03800080	; 03800F34
loc_03800F38:
	add r0,r4,#0x0	; 03800F38
	bl loc_037FFFA8	; 03800F3A
	ldr r4,[r4,#0x50]	; 03800F3E
loc_03800F40:
	cmp r4,#0x0	; 03800F40
	bne loc_03800F14	; 03800F42
	mov r0,#0x0	; 03800F44
	str r0,[r5,#0x3c]	; 03800F46
	add sp,#0x4	; 03800F48
	pop {r4,r5,r6,r7}	; 03800F4A
	pop {r3}	; 03800F4C
	bx r3	; 03800F4E

; ===== function loc_03800F50 =====
loc_03800F50:
	push {r4,r5,r6,r7,lr}	; 03800F50
	sub sp,#0x4	; 03800F52
	mov r2,#0x0	; 03800F54
	strb r2,[r0,#0x1]	; 03800F56
	str r1,[r0,#0x20]	; 03800F58
	mov r1,#0x78	; 03800F5A
	strh r1,[r0,#0x18]	; 03800F5C
	ldr r1,[pool_03800FAC]	; 03800F5E
	strh r1,[r0,#0x1a]	; 03800F60
	strh r2,[r0,#0x1c]	; 03800F62
	mov r1,#0x7f	; 03800F64
	strb r1,[r0,#0x5]	; 03800F66
	strh r2,[r0,#0x6]	; 03800F68
	mov r1,#0x40	; 03800F6A
	strb r1,[r0,#0x4]	; 03800F6C
	mov r3,#0xff	; 03800F6E
loc_03800F70:
	add r1,r0,r2	; 03800F70
	strb r3,[r1,#0x8]	; 03800F72
	add r2,r2,#0x1	; 03800F74
	cmp r2,#0x10	; 03800F76
	blt loc_03800F70	; 03800F78
	ldr r4,[pool_03800FB0]	; 03800F7A
	ldr r5,[r4,#0x0]	; 03800F7C
	cmp r5,#0x0	; 03800F7E
	beq loc_03800FA4	; 03800F80
	mov r2,#0x0	; 03800F82
	ldrb r1,[r0,#0x2]	; 03800F84
	mov r3,#0x24	; 03800F86
	mul r1,r3	; 03800F88
	add r1,r5,r1	; 03800F8A
	str r2,[r1,#0x40]	; 03800F8C
	mvn r1,r2	; 03800F8E
loc_03800F90:
	ldr r7,[r4,#0x0]	; 03800F90
	ldrb r5,[r0,#0x2]	; 03800F92
	mul r5,r3	; 03800F94
	lsl r6,r2,#0x1	; 03800F96
	add r5,r7,r5	; 03800F98
	add r5,r6,r5	; 03800F9A
	strh r1,[r5,#0x20]	; 03800F9C
	add r2,r2,#0x1	; 03800F9E
	cmp r2,#0x10	; 03800FA0
	blt loc_03800F90	; 03800FA2
loc_03800FA4:
	add sp,#0x4	; 03800FA4
	pop {r4,r5,r6,r7}	; 03800FA6
	pop {r3}	; 03800FA8
	bx r3	; 03800FAA
pool_03800FAC:
loc_03800FAC:
	.word 0x00000100	; 03800FAC
pool_03800FB0:
loc_03800FB0:
	.word P2_BssStart + 0xB80	; 03800FB0

; ===== function loc_03800FB4 =====
loc_03800FB4:
	str r1,[r0,#0x24]	; 03800FB4
	ldr r1,[r0,#0x24]	; 03800FB6
	add r1,r1,r2	; 03800FB8
	str r1,[r0,#0x28]	; 03800FBA
	bx lr	; 03800FBC
	.byte 0x00, 0x00	; 03800FC0

; ===== function loc_03800FC0 =====
loc_03800FC0:
	push {r4,r5,lr}	; 03800FC0
	sub sp,#0x4	; 03800FC2
	add r4,r0,#0x0	; 03800FC4
	mov r1,#0x0	; 03800FC6
	str r1,[r4,#0x24]	; 03800FC8
	str r1,[r4,#0x28]	; 03800FCA
	ldrb r2,[r4,#0x0]	; 03800FCC
	mov r0,#0x2	; 03800FCE
	orr r2,r0	; 03800FD0
	strb r2,[r4,#0x0]	; 03800FD2
	ldrb r3,[r4,#0x0]	; 03800FD4
	mov r2,#0x4	; 03800FD6
	bic r3,r2	; 03800FD8
	strb r3,[r4,#0x0]	; 03800FDA
	ldrb r3,[r4,#0x0]	; 03800FDC
	mov r2,#0x8	; 03800FDE
	bic r3,r2	; 03800FE0
	strb r3,[r4,#0x0]	; 03800FE2
	ldrb r3,[r4,#0x0]	; 03800FE4
	mov r2,#0x10	; 03800FE6
	bic r3,r2	; 03800FE8
	strb r3,[r4,#0x0]	; 03800FEA
	ldrb r3,[r4,#0x0]	; 03800FEC
	mov r2,#0x20	; 03800FEE
	bic r3,r2	; 03800FF0
	strb r3,[r4,#0x0]	; 03800FF2
	ldrb r2,[r4,#0x0]	; 03800FF4
	mov r3,#0x40	; 03800FF6
	orr r2,r3	; 03800FF8
	strb r2,[r4,#0x0]	; 03800FFA
	ldrb r5,[r4,#0x0]	; 03800FFC
	mov r2,#0x80	; 03800FFE
	bic r5,r2	; 03801000
	strb r5,[r4,#0x0]	; 03801002
	add r2,r4,#0x0	; 03801004
	add r2,#0x3b	; 03801006
	strb r1,[r2,#0x0]	; 03801008
	strh r1,[r4,#0x2]	; 0380100A
	strb r3,[r4,#0x12]	; 0380100C
	mov r2,#0x7f	; 0380100E
	strb r2,[r4,#0x4]	; 03801010
	strb r2,[r4,#0x5]	; 03801012
	strh r1,[r4,#0xa]	; 03801014
	strb r1,[r4,#0x8]	; 03801016
	strb r1,[r4,#0x9]	; 03801018
	strb r1,[r4,#0x6]	; 0380101A
	strh r1,[r4,#0xc]	; 0380101C
	mov r2,#0xff	; 0380101E
	strb r2,[r4,#0xe]	; 03801020
	strb r2,[r4,#0xf]	; 03801022
	strb r2,[r4,#0x10]	; 03801024
	strb r2,[r4,#0x11]	; 03801026
	strb r0,[r4,#0x7]	; 03801028
	mov r0,#0x3c	; 0380102A
	strb r0,[r4,#0x14]	; 0380102C
	strb r1,[r4,#0x15]	; 0380102E
	strh r1,[r4,#0x16]	; 03801030
	strb r1,[r4,#0x13]	; 03801032
	ldr r0,[pool_03801050]	; 03801034
	strh r0,[r4,#0x1e]	; 03801036
	add r0,r4,#0x0	; 03801038
	add r0,#0x18	; 0380103A
	bl loc_037FFDF0	; 0380103C
	mov r0,#0x0	; 03801040
	str r0,[r4,#0x20]	; 03801042
	str r0,[r4,#0x3c]	; 03801044
	add sp,#0x4	; 03801046
	pop {r4,r5}	; 03801048
	pop {r3}	; 0380104A
	bx r3	; 0380104C
	.byte 0xC0, 0x46	; 03801050
pool_03801050:
loc_03801050:
	.word 0x0000FFFF	; 03801050

; ===== function loc_03801054 =====
P2_Entry_03801054:
	push {r4,r5,r6,lr}	; 03801054
	add r4,r0,#0x0	; 03801056
	add r6,r1,#0x0	; 03801058
	cmp r2,#0x4	; 0380105A
	bhi loc_038010C4	; 0380105C
	add r1,r2,r2	; 0380105E
P2_SwitchIndexPC_0380105E:
	add r1,pc	; 03801060
	ldrh r1,[r1,#(P2_SwitchTable_0380105E - (P2_SwitchIndexPC_0380105E + 4))]	; 03801062
	lsl r1,r1,#0x10	; 03801064
	asr r1,r1,#0x10	; 03801066
P2_SwitchTargetPC_0380105E:
	add r1,pc	; 03801068
	bx r1	; 0380106A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380105E:
	.halfword (loc_03801076 + 1) - (P2_SwitchTargetPC_0380105E + 4)
	.halfword (loc_0380107E + 1) - (P2_SwitchTargetPC_0380105E + 4)
	.halfword (loc_03801086 + 1) - (P2_SwitchTargetPC_0380105E + 4)
	.halfword (loc_038010A4 + 1) - (P2_SwitchTargetPC_0380105E + 4)
	.halfword (loc_0380108E + 1) - (P2_SwitchTargetPC_0380105E + 4)
P2_SwitchTable_0380105EEnd:
loc_03801076:
	bl loc_03801180	; 03801076
	add r5,r0,#0x0	; 0380107A
	b loc_038010C4	; 0380107C
loc_0380107E:
	bl loc_03801148	; 0380107E
	add r5,r0,#0x0	; 03801082
	b loc_038010C4	; 03801084
loc_03801086:
	bl loc_038010CC	; 03801086
	add r5,r0,#0x0	; 0380108A
	b loc_038010C4	; 0380108C
loc_0380108E:
	bl loc_03801180	; 0380108E
	add r1,r0,#0x0	; 03801092
	add r0,r6,#0x0	; 03801094
	bl loc_03800500	; 03801096
	cmp r0,#0x0	; 0380109A
	beq loc_038010C4	; 0380109C
	mov r1,#0x0	; 0380109E
	ldrsh r5,[r0,r1]	; 038010A0
	b loc_038010C4	; 038010A2
loc_038010A4:
	bl loc_03801148	; 038010A4
	lsl r0,r0,#0x10	; 038010A8
	asr r5,r0,#0x10	; 038010AA
	add r0,r4,#0x0	; 038010AC
	bl loc_03801148	; 038010AE
	lsl r0,r0,#0x10	; 038010B2
	asr r4,r0,#0x10	; 038010B4
	bl loc_037FF7BC	; 038010B6
	sub r1,r4,r5	; 038010BA
	add r1,r1,#0x1	; 038010BC
	mul r0,r1	; 038010BE
	asr r0,r0,#0x10	; 038010C0
	add r5,r0,r5	; 038010C2
loc_038010C4:
	add r0,r5,#0x0	; 038010C4
	pop {r4,r5,r6}	; 038010C6
	pop {r3}	; 038010C8
	bx r3	; 038010CA

; ===== function loc_038010CC =====
loc_038010CC:
	push {r4,r5,r6,r7,lr}	; 038010CC
	sub sp,#0x4	; 038010CE
	add r6,r0,#0x0	; 038010D0
	mov r5,#0x0	; 038010D2
	add r4,r6,#0x0	; 038010D4
	add r4,#0x28	; 038010D6
	mov r7,#0x80	; 038010D8
loc_038010DA:
	ldr r0,[r6,#0x28]	; 038010DA
	bl loc_03801198	; 038010DC
	ldr r1,[r4,#0x0]	; 038010E0
	add r1,r1,#0x1	; 038010E2
	str r1,[r4,#0x0]	; 038010E4
	lsl r5,r5,#0x7	; 038010E6
	add r2,r0,#0x0	; 038010E8
	mov r1,#0x7f	; 038010EA
	and r2,r1	; 038010EC
	orr r5,r2	; 038010EE
	and r0,r7	; 038010F0
	cmp r0,#0x0	; 038010F2
	bne loc_038010DA	; 038010F4
	add r0,r5,#0x0	; 038010F6
	add sp,#0x4	; 038010F8
	pop {r4,r5,r6,r7}	; 038010FA
	pop {r3}	; 038010FC
	bx r3	; 038010FE
P2_Entry_03801100:
	push {r4,r5,lr}	; 03801100
	sub sp,#0x4	; 03801102
	add r5,r0,#0x0	; 03801104
	ldr r0,[r5,#0x28]	; 03801106
	bl loc_03801198	; 03801108
	add r4,r0,#0x0	; 0380110C
	add r1,r5,#0x0	; 0380110E
	add r1,#0x28	; 03801110
	ldr r0,[r1,#0x0]	; 03801112
	add r0,r0,#0x1	; 03801114
	str r0,[r1,#0x0]	; 03801116
	ldr r0,[r5,#0x28]	; 03801118
	bl loc_03801198	; 0380111A
	lsl r0,r0,#0x8	; 0380111E
	orr r4,r0	; 03801120
	add r1,r5,#0x0	; 03801122
	add r1,#0x28	; 03801124
	ldr r0,[r1,#0x0]	; 03801126
	add r0,r0,#0x1	; 03801128
	str r0,[r1,#0x0]	; 0380112A
	ldr r0,[r5,#0x28]	; 0380112C
	bl loc_03801198	; 0380112E
	lsl r0,r0,#0x10	; 03801132
	orr r4,r0	; 03801134
	add r5,#0x28	; 03801136
	ldr r0,[r5,#0x0]	; 03801138
	add r0,r0,#0x1	; 0380113A
	str r0,[r5,#0x0]	; 0380113C
	add r0,r4,#0x0	; 0380113E
	add sp,#0x4	; 03801140
	pop {r4,r5}	; 03801142
	pop {r3}	; 03801144
	bx r3	; 03801146

; ===== function loc_03801148 =====
loc_03801148:
	push {r4,r5,lr}	; 03801148
	sub sp,#0x4	; 0380114A
	add r5,r0,#0x0	; 0380114C
	ldr r0,[r5,#0x28]	; 0380114E
	bl loc_03801198	; 03801150
	add r4,r0,#0x0	; 03801154
	add r1,r5,#0x0	; 03801156
	add r1,#0x28	; 03801158
	ldr r0,[r1,#0x0]	; 0380115A
	add r0,r0,#0x1	; 0380115C
	str r0,[r1,#0x0]	; 0380115E
	ldr r0,[r5,#0x28]	; 03801160
	bl loc_03801198	; 03801162
	lsl r0,r0,#0x8	; 03801166
	orr r4,r0	; 03801168
	lsl r0,r4,#0x10	; 0380116A
	lsr r0,r0,#0x10	; 0380116C
	add r5,#0x28	; 0380116E
	ldr r1,[r5,#0x0]	; 03801170
	add r1,r1,#0x1	; 03801172
	str r1,[r5,#0x0]	; 03801174
	add sp,#0x4	; 03801176
	pop {r4,r5}	; 03801178
	pop {r3}	; 0380117A
	bx r3	; 0380117C
	.byte 0x00, 0x00	; 03801180

; ===== function loc_03801180 =====
loc_03801180:
	push {r4,lr}	; 03801180
	add r4,r0,#0x0	; 03801182
	ldr r0,[r4,#0x28]	; 03801184
	bl loc_03801198	; 03801186
	add r4,#0x28	; 0380118A
	ldr r1,[r4,#0x0]	; 0380118C
	add r1,r1,#0x1	; 0380118E
	str r1,[r4,#0x0]	; 03801190
	pop {r4}	; 03801192
	pop {r3}	; 03801194
	bx r3	; 03801196

; ===== function loc_03801198 =====
loc_03801198:
	push {r4,lr}	; 03801198
	add r4,r0,#0x0	; 0380119A
	ldr r0,[pool_038011C0]	; 0380119C
	ldr r1,[r0,#0x0]	; 0380119E
	cmp r4,r1	; 038011A0
	bcc loc_038011AA	; 038011A2
	ldr r0,[r0,#0x4]	; 038011A4
	cmp r4,r0	; 038011A6
	bcc loc_038011B0	; 038011A8
loc_038011AA:
	add r0,r4,#0x0	; 038011AA
	bl loc_038011C8	; 038011AC
loc_038011B0:
	ldr r0,[pool_038011C0]	; 038011B0
	ldr r0,[r0,#0x0]	; 038011B2
	sub r1,r4,r0	; 038011B4
	ldr r0,[pool_038011C4]	; 038011B6
	ldrb r0,[r0,r1]	; 038011B8
	pop {r4}	; 038011BA
	pop {r3}	; 038011BC
	bx r3	; 038011BE
pool_038011C0:
loc_038011C0:
	.word P2_BssStart + 0xB68	; 038011C0
pool_038011C4:
loc_038011C4:
	.word P2_BssStart + 0xB70	; 038011C4

; ===== function loc_038011C8 =====
loc_038011C8:
	mov r1,#0x3	; 038011C8
	bic r0,r1	; 038011CA
	ldr r1,[pool_038011E8]	; 038011CC
	str r0,[r1,#0x0]	; 038011CE
	add r2,r0,#0x0	; 038011D0
	add r2,#0x10	; 038011D2
	str r2,[r1,#0x4]	; 038011D4
	ldr r2,[r0,#0x0]	; 038011D6
	str r2,[r1,#0x8]	; 038011D8
	ldr r2,[r0,#0x4]	; 038011DA
	str r2,[r1,#0xc]	; 038011DC
	ldr r2,[r0,#0x8]	; 038011DE
	str r2,[r1,#0x10]	; 038011E0
	ldr r0,[r0,#0xc]	; 038011E2
	str r0,[r1,#0x14]	; 038011E4
	bx lr	; 038011E6
pool_038011E8:
loc_038011E8:
	.word P2_BssStart + 0xB68	; 038011E8

; ===== function loc_038011EC =====
loc_038011EC:
	push {r4,r5,r6,r7,lr}	; 038011EC
	sub sp,#0x4	; 038011EE
	add r6,r1,#0x0	; 038011F0
	add r5,r3,#0x0	; 038011F2
	ldr r4,[sp,#0x18]	; 038011F4
	ldr r3,[pool_03801244]	; 038011F6
	mov r1,#0x24	; 038011F8
	mul r0,r1	; 038011FA
	add r7,r3,r0	; 038011FC
	mov r3,#0x0	; 038011FE
	b loc_03801234	; 03801200
loc_03801202:
	add r1,r6,#0x0	; 03801202
	mov r0,#0x1	; 03801204
	and r1,r0	; 03801206
	cmp r1,#0x0	; 03801208
	beq loc_03801230	; 0380120A
	add r0,r7,#0x0	; 0380120C
	add r1,r3,#0x0	; 0380120E
	bl loc_03800E78	; 03801210
	cmp r0,#0x0	; 03801214
	beq loc_03801230	; 03801216
	cmp r4,#0x1	; 03801218
	beq loc_03801226	; 0380121A
	cmp r4,#0x2	; 0380121C
	beq loc_0380122A	; 0380121E
	cmp r4,#0x4	; 03801220
	beq loc_0380122E	; 03801222
	b loc_03801230	; 03801224
loc_03801226:
	strb r5,[r0,r2]	; 03801226
	b loc_03801230	; 03801228
loc_0380122A:
	strh r5,[r0,r2]	; 0380122A
	b loc_03801230	; 0380122C
loc_0380122E:
	str r5,[r0,r2]	; 0380122E
loc_03801230:
	add r3,r3,#0x1	; 03801230
	lsr r6,r6,#0x1	; 03801232
loc_03801234:
	cmp r3,#0x10	; 03801234
	bge loc_0380123C	; 03801236
	cmp r6,#0x0	; 03801238
	bne loc_03801202	; 0380123A
loc_0380123C:
	add sp,#0x4	; 0380123C
	pop {r4,r5,r6,r7}	; 0380123E
	pop {r3}	; 03801240
	bx r3	; 03801242
pool_03801244:
loc_03801244:
	.word 0x03806464	; 03801244

; ===== function loc_03801248 =====
loc_03801248:
	push {r4,r5,lr}	; 03801248
	sub sp,#0x4	; 0380124A
	ldr r5,[pool_03801274]	; 0380124C
	mov r4,#0x24	; 0380124E
	mul r0,r4	; 03801250
	add r0,r5,r0	; 03801252
	cmp r3,#0x1	; 03801254
	beq loc_03801262	; 03801256
	cmp r3,#0x2	; 03801258
	beq loc_03801266	; 0380125A
	cmp r3,#0x4	; 0380125C
	beq loc_0380126A	; 0380125E
	b loc_0380126C	; 03801260
loc_03801262:
	strb r2,[r0,r1]	; 03801262
	b loc_0380126C	; 03801264
loc_03801266:
	strh r2,[r0,r1]	; 03801266
	b loc_0380126C	; 03801268
loc_0380126A:
	str r2,[r0,r1]	; 0380126A
loc_0380126C:
	add sp,#0x4	; 0380126C
	pop {r4,r5}	; 0380126E
	pop {r3}	; 03801270
	bx r3	; 03801272
pool_03801274:
loc_03801274:
	.word 0x03806464	; 03801274

; ===== function loc_03801278 =====
loc_03801278:
	push {r4,r5,r6,r7,lr}	; 03801278
	sub sp,#0x4	; 0380127A
	add r5,r0,#0x0	; 0380127C
	add r6,r1,#0x0	; 0380127E
	mov r4,#0x0	; 03801280
	ldr r7,[pool_038012B0]	; 03801282
loc_03801284:
	add r1,r4,#0x0	; 03801284
	mov r0,#0x24	; 03801286
	mul r1,r0	; 03801288
	add r0,r7,r1	; 0380128A
	ldrb r1,[r7,r1]	; 0380128C
	cmp r1,#0x0	; 0380128E
	beq loc_038012A0	; 03801290
	ldr r1,[r0,#0x20]	; 03801292
	cmp r5,r1	; 03801294
	bhi loc_038012A0	; 03801296
	cmp r1,r6	; 03801298
	bhi loc_038012A0	; 0380129A
	bl loc_03800E10	; 0380129C
loc_038012A0:
	add r4,r4,#0x1	; 038012A0
	cmp r4,#0x10	; 038012A2
	blt loc_03801284	; 038012A4
	add sp,#0x4	; 038012A6
	pop {r4,r5,r6,r7}	; 038012A8
	pop {r3}	; 038012AA
	bx r3	; 038012AC
	.byte 0xC0, 0x46	; 038012B0
pool_038012B0:
loc_038012B0:
	.word P2_BssStart + 0x10C4	; 038012B0

; ===== function loc_038012B4 =====
loc_038012B4:
	push {r4,r5,r6,r7,lr}	; 038012B4
	sub sp,#0x4	; 038012B6
	add r5,r0,#0x0	; 038012B8
	add r6,r1,#0x0	; 038012BA
	mov r4,#0x0	; 038012BC
	add r7,r4,#0x0	; 038012BE
loc_038012C0:
	add r0,r4,#0x0	; 038012C0
	mov r1,#0x24	; 038012C2
	mul r0,r1	; 038012C4
	ldr r1,[pool_03801308]	; 038012C6
	add r3,r1,r0	; 038012C8
	ldrb r0,[r1,r0]	; 038012CA
	cmp r0,#0x0	; 038012CC
	beq loc_038012F8	; 038012CE
	add r2,r7,#0x0	; 038012D0
	b loc_038012F4	; 038012D2
loc_038012D4:
	add r0,r3,#0x0	; 038012D4
	add r1,r2,#0x0	; 038012D6
	bl loc_03800E78	; 038012D8
	cmp r0,#0x0	; 038012DC
	beq loc_038012F2	; 038012DE
	ldr r0,[r0,#0x28]	; 038012E0
	cmp r5,r0	; 038012E2
	bhi loc_038012F2	; 038012E4
	cmp r0,r6	; 038012E6
	bhi loc_038012F2	; 038012E8
	add r0,r3,#0x0	; 038012EA
	bl loc_03800E10	; 038012EC
	b loc_038012F8	; 038012F0
loc_038012F2:
	add r2,r2,#0x1	; 038012F2
loc_038012F4:
	cmp r2,#0x10	; 038012F4
	blt loc_038012D4	; 038012F6
loc_038012F8:
	add r4,r4,#0x1	; 038012F8
	cmp r4,#0x10	; 038012FA
	blt loc_038012C0	; 038012FC
	add sp,#0x4	; 038012FE
	pop {r4,r5,r6,r7}	; 03801300
	pop {r3}	; 03801302
	bx r3	; 03801304
	.byte 0xC0, 0x46	; 03801308
pool_03801308:
loc_03801308:
	.word P2_BssStart + 0x10C4	; 03801308

; ===== function loc_0380130C =====
loc_0380130C:
	push {r4,r5,r6,r7,lr}	; 0380130C
	sub sp,#0x4	; 0380130E
	add r5,r1,#0x0	; 03801310
	ldr r3,[pool_03801358]	; 03801312
	mov r1,#0x24	; 03801314
	mul r0,r1	; 03801316
	add r4,r3,r0	; 03801318
	mov r3,#0x0	; 0380131A
	lsl r0,r2,#0x10	; 0380131C
	lsr r2,r0,#0x10	; 0380131E
	mov r7,#0x80	; 03801320
	mov r6,#0x1	; 03801322
	b loc_03801348	; 03801324
loc_03801326:
	add r0,r5,#0x0	; 03801326
	and r0,r6	; 03801328
	cmp r0,#0x0	; 0380132A
	beq loc_03801344	; 0380132C
	add r0,r4,#0x0	; 0380132E
	add r1,r3,#0x0	; 03801330
	bl loc_03800E78	; 03801332
	add r1,r0,#0x0	; 03801336
	cmp r1,#0x0	; 03801338
	beq loc_03801344	; 0380133A
	strh r2,[r1,#0x1e]	; 0380133C
	ldrb r0,[r1,#0x0]	; 0380133E
	orr r0,r7	; 03801340
	strb r0,[r1,#0x0]	; 03801342
loc_03801344:
	add r3,r3,#0x1	; 03801344
	lsr r5,r5,#0x1	; 03801346
loc_03801348:
	cmp r3,#0x10	; 03801348
	bge loc_03801350	; 0380134A
	cmp r5,#0x0	; 0380134C
	bne loc_03801326	; 0380134E
loc_03801350:
	add sp,#0x4	; 03801350
	pop {r4,r5,r6,r7}	; 03801352
	pop {r3}	; 03801354
	bx r3	; 03801356
pool_03801358:
loc_03801358:
	.word 0x03806464	; 03801358

; ===== function loc_0380135C =====
loc_0380135C:
	push {r4,r5,r6,r7,lr}	; 0380135C
	sub sp,#0x4	; 0380135E
	add r5,r1,#0x0	; 03801360
	add r6,r2,#0x0	; 03801362
	ldr r2,[pool_038013C0]	; 03801364
	mov r1,#0x24	; 03801366
	mul r0,r1	; 03801368
	add r0,r2,r0	; 0380136A
	str r0,[sp,#0x0]	; 0380136C
	mov r4,#0x0	; 0380136E
	b loc_038013AE	; 03801370
loc_03801372:
	add r1,r5,#0x0	; 03801372
	mov r0,#0x1	; 03801374
	and r1,r0	; 03801376
	cmp r1,#0x0	; 03801378
	beq loc_038013AA	; 0380137A
	ldr r0,[sp,#0x0]	; 0380137C
	add r1,r4,#0x0	; 0380137E
	bl loc_03800E78	; 03801380
	add r7,r0,#0x0	; 03801384
	cmp r7,#0x0	; 03801386
	beq loc_038013AA	; 03801388
	cmp r6,#0x0	; 0380138A
	beq loc_03801396	; 0380138C
	ldr r1,[sp,#0x0]	; 0380138E
	mov r2,#0x7f	; 03801390
	bl loc_03800F00	; 03801392
loc_03801396:
	ldrb r0,[r7,#0x0]	; 03801396
	mov r1,#0x4	; 03801398
	bic r0,r1	; 0380139A
	lsl r1,r6,#0x18	; 0380139C
	lsr r2,r1,#0x18	; 0380139E
	mov r1,#0x1	; 038013A0
	and r2,r1	; 038013A2
	lsl r1,r2,#0x2	; 038013A4
	orr r0,r1	; 038013A6
	strb r0,[r7,#0x0]	; 038013A8
loc_038013AA:
	add r4,r4,#0x1	; 038013AA
	lsr r5,r5,#0x1	; 038013AC
loc_038013AE:
	cmp r4,#0x10	; 038013AE
	bge loc_038013B6	; 038013B0
	cmp r5,#0x0	; 038013B2
	bne loc_03801372	; 038013B4
loc_038013B6:
	add sp,#0x4	; 038013B6
	pop {r4,r5,r6,r7}	; 038013B8
	pop {r3}	; 038013BA
	bx r3	; 038013BC
	.byte 0xC0, 0x46	; 038013C0
pool_038013C0:
loc_038013C0:
	.word 0x03806464	; 038013C0

; ===== function loc_038013C4 =====
loc_038013C4:
	push {r4,r5,r6,lr}	; 038013C4
	ldr r3,[pool_038013F8]	; 038013C6
	mov r2,#0x24	; 038013C8
	mul r0,r2	; 038013CA
	add r5,r3,r0	; 038013CC
	strb r1,[r5,#0x1]	; 038013CE
	cmp r1,#0x0	; 038013D0
	beq loc_038013F2	; 038013D2
	mov r4,#0x0	; 038013D4
	mov r6,#0x7f	; 038013D6
loc_038013D8:
	add r0,r5,#0x0	; 038013D8
	add r1,r4,#0x0	; 038013DA
	bl loc_03800E78	; 038013DC
	cmp r0,#0x0	; 038013E0
	beq loc_038013EC	; 038013E2
	add r1,r5,#0x0	; 038013E4
	add r2,r6,#0x0	; 038013E6
	bl loc_03800F00	; 038013E8
loc_038013EC:
	add r4,r4,#0x1	; 038013EC
	cmp r4,#0x10	; 038013EE
	blt loc_038013D8	; 038013F0
loc_038013F2:
	pop {r4,r5,r6}	; 038013F2
	pop {r3}	; 038013F4
	bx r3	; 038013F6
pool_038013F8:
loc_038013F8:
	.word 0x03806464	; 038013F8

; ===== function loc_038013FC =====
loc_038013FC:
	push {r4,lr}	; 038013FC
	add r4,r0,#0x0	; 038013FE
	ldr r2,[pool_03801430]	; 03801400
	mov r0,#0x24	; 03801402
	add r1,r4,#0x0	; 03801404
	mul r1,r0	; 03801406
	add r0,r2,r1	; 03801408
	ldrb r1,[r2,r1]	; 0380140A
	cmp r1,#0x0	; 0380140C
	beq loc_03801428	; 0380140E
	bl loc_03800E10	; 03801410
	ldr r0,[pool_03801434]	; 03801414
	ldr r0,[r0,#0x0]	; 03801416
	cmp r0,#0x0	; 03801418
	beq loc_03801428	; 0380141A
	add r2,r0,#0x4	; 0380141C
	ldr r1,[r2,#0x0]	; 0380141E
	mov r0,#0x1	; 03801420
	lsl r0,r4	; 03801422
	bic r1,r0	; 03801424
	str r1,[r2,#0x0]	; 03801426
loc_03801428:
	pop {r4}	; 03801428
	pop {r3}	; 0380142A
	bx r3	; 0380142C
	.byte 0xC0, 0x46	; 03801430
pool_03801430:
loc_03801430:
	.word P2_BssStart + 0x10C4	; 03801430
pool_03801434:
loc_03801434:
	.word P2_BssStart + 0xB80	; 03801434

; ===== function loc_03801438 =====
loc_03801438:
	push {r4,r5,r6,r7,lr}	; 03801438
	sub sp,#0xc	; 0380143A
	str r0,[sp,#0x0]	; 0380143C
	add r7,r1,#0x0	; 0380143E
	str r2,[sp,#0x4]	; 03801440
	add r4,r3,#0x0	; 03801442
	ldr r2,[pool_038014FC]	; 03801444
	mov r0,#0x24	; 03801446
	ldr r1,[sp,#0x0]	; 03801448
	mul r1,r0	; 0380144A
	add r5,r2,r1	; 0380144C
	ldrb r0,[r2,r1]	; 0380144E
	cmp r0,#0x0	; 03801450
	beq loc_0380145A	; 03801452
	add r0,r5,#0x0	; 03801454
	bl loc_03800E10	; 03801456
loc_0380145A:
	add r0,r5,#0x0	; 0380145A
	add r1,r4,#0x0	; 0380145C
	bl loc_03800F50	; 0380145E
	bl loc_038004CC	; 03801462
	add r6,r0,#0x0	; 03801466
	cmp r6,#0x0	; 03801468
	blt loc_038014F2	; 0380146A
	ldr r1,[pool_03801500]	; 0380146C
	lsl r0,r6,#0x6	; 0380146E
	add r4,r1,r0	; 03801470
	add r0,r4,#0x0	; 03801472
	bl loc_03800FC0	; 03801474
	add r0,r4,#0x0	; 03801478
	add r1,r7,#0x0	; 0380147A
	ldr r2,[sp,#0x4]	; 0380147C
	bl loc_03800FB4	; 0380147E
	strb r6,[r5,#0x8]	; 03801482
	ldr r0,[r4,#0x28]	; 03801484
	bl loc_038011C8	; 03801486
	add r0,r4,#0x0	; 0380148A
	bl loc_03801180	; 0380148C
	cmp r0,#0xfe	; 03801490
	beq loc_0380149E	; 03801492
	add r4,#0x28	; 03801494
	ldr r0,[r4,#0x0]	; 03801496
	sub r0,r0,#0x1	; 03801498
	str r0,[r4,#0x0]	; 0380149A
	b loc_038014DA	; 0380149C
loc_0380149E:
	add r0,r4,#0x0	; 0380149E
	bl loc_03801148	; 038014A0
	lsl r0,r0,#0xf	; 038014A4
	lsr r4,r0,#0x10	; 038014A6
	mov r6,#0x1	; 038014A8
	str r6,[sp,#0x8]	; 038014AA
	b loc_038014D6	; 038014AC
loc_038014AE:
	add r1,r4,#0x0	; 038014AE
	ldr r0,[sp,#0x8]	; 038014B0
	and r1,r0	; 038014B2
	cmp r1,#0x0	; 038014B4
	beq loc_038014D0	; 038014B6
	bl loc_038004CC	; 038014B8
	add r7,r0,#0x0	; 038014BC
	cmp r7,#0x0	; 038014BE
	blt loc_038014DA	; 038014C0
	lsl r1,r7,#0x6	; 038014C2
	ldr r0,[pool_03801500]	; 038014C4
	add r0,r0,r1	; 038014C6
	bl loc_03800FC0	; 038014C8
	add r0,r5,r6	; 038014CC
	strb r7,[r0,#0x8]	; 038014CE
loc_038014D0:
	add r6,r6,#0x1	; 038014D0
	lsl r0,r4,#0xf	; 038014D2
	lsr r4,r0,#0x10	; 038014D4
loc_038014D6:
	cmp r4,#0x0	; 038014D6
	bne loc_038014AE	; 038014D8
loc_038014DA:
	mov r3,#0x1	; 038014DA
	strb r3,[r5,#0x0]	; 038014DC
	ldr r0,[pool_03801504]	; 038014DE
	ldr r0,[r0,#0x0]	; 038014E0
	cmp r0,#0x0	; 038014E2
	beq loc_038014F2	; 038014E4
	add r2,r0,#0x4	; 038014E6
	ldr r1,[r2,#0x0]	; 038014E8
	ldr r0,[sp,#0x0]	; 038014EA
	lsl r3,r0	; 038014EC
	orr r1,r3	; 038014EE
	str r1,[r2,#0x0]	; 038014F0
loc_038014F2:
	add sp,#0xc	; 038014F2
	pop {r4,r5,r6,r7}	; 038014F4
	pop {r3}	; 038014F6
	bx r3	; 038014F8
	.byte 0xC0, 0x46	; 038014FC
pool_038014FC:
loc_038014FC:
	.word P2_BssStart + 0x10C4	; 038014FC
pool_03801500:
loc_03801500:
	.word 0x038066A4	; 03801500
pool_03801504:
loc_03801504:
	.word P2_BssStart + 0xB80	; 03801504
P2_Entry_03801508:
	push {r4,r5,r6,r7,lr}	; 03801508
	sub sp,#0x4	; 0380150A
	add r7,r0,#0x0	; 0380150C
	mov r6,#0x0	; 0380150E
	add r4,r6,#0x0	; 03801510
P2_Entry_03801512:
	add r0,r4,#0x0	; 03801512
	mov r1,#0x24	; 03801514
	mul r0,r1	; 03801516
	ldr r1,[pool_0380155C]	; 03801518
	add r5,r1,r0	; 0380151A
	ldrb r0,[r1,r0]	; 0380151C
	cmp r0,#0x0	; 0380151E
	beq P2_Entry_03801544	; 03801520
	cmp r7,#0x0	; 03801522
	beq P2_Entry_03801532	; 03801524
	ldrb r0,[r5,#0x1]	; 03801526
	cmp r0,#0x0	; 03801528
	bne P2_Entry_03801532	; 0380152A
	add r0,r5,#0x0	; 0380152C
	bl P2_Entry_03800E98	; 0380152E
P2_Entry_03801532:
	add r0,r5,#0x0	; 03801532
	bl P2_Entry_03800D18	; 03801534
	ldrb r0,[r5,#0x0]	; 03801538
	cmp r0,#0x0	; 0380153A
	beq P2_Entry_03801544	; 0380153C
	mov r0,#0x1	; 0380153E
	lsl r0,r4	; 03801540
	orr r6,r0	; 03801542
P2_Entry_03801544:
	add r4,r4,#0x1	; 03801544
	cmp r4,#0x10	; 03801546
	blt P2_Entry_03801512	; 03801548
	ldr r0,[pool_03801560]	; 0380154A
	ldr r0,[r0,#0x0]	; 0380154C
	cmp r0,#0x0	; 0380154E
	beq P2_Entry_03801554	; 03801550
	str r6,[r0,#0x4]	; 03801552
P2_Entry_03801554:
	add sp,#0x4	; 03801554
	pop {r4,r5,r6,r7}	; 03801556
	pop {r3}	; 03801558
	bx r3	; 0380155A
pool_0380155C:
	.word P2_BssStart + 0x10C4	; 0380155C
pool_03801560:
	.word P2_BssStart + 0xB80	; 03801560
P2_Entry_03801564:
	push {r4,r5,lr}	; 03801564
	sub sp,#0x4	; 03801566
	mov r5,#0x0	; 03801568
	ldr r3,[pool_0380159C]	; 0380156A
	add r0,r5,#0x0	; 0380156C
	mov r1,#0x24	; 0380156E
P2_Entry_03801570:
	add r2,r5,#0x0	; 03801570
	mul r2,r1	; 03801572
	add r4,r3,r2	; 03801574
	strb r0,[r3,r2]	; 03801576
	strb r5,[r4,#0x2]	; 03801578
	add r5,r5,#0x1	; 0380157A
	cmp r5,#0x10	; 0380157C
	blt P2_Entry_03801570	; 0380157E
	ldr r4,[pool_038015A0]	; 03801580
	mov r1,#0x1	; 03801582
P2_Entry_03801584:
	lsl r3,r0,#0x6	; 03801584
	ldrb r2,[r4,r3]	; 03801586
	bic r2,r1	; 03801588
	strb r2,[r4,r3]	; 0380158A
	add r0,r0,#0x1	; 0380158C
	cmp r0,#0x20	; 0380158E
	blt P2_Entry_03801584	; 03801590
	add sp,#0x4	; 03801592
	pop {r4,r5}	; 03801594
	pop {r3}	; 03801596
	bx r3	; 03801598
	.byte 0xC0, 0x46	; 0380159A
pool_0380159C:
	.word P2_BssStart + 0x10C4	; 0380159C
pool_038015A0:
	.word P2_BssStart + 0x1304	; 038015A0

; ===== function loc_038015A4 =====
loc_038015A4:
	lsl r1,r1,#0x3	; 038015A4
	add r0,r0,r1	; 038015A6
	ldr r1,[r0,#0x18]	; 038015A8
	cmp r1,#0x0	; 038015AA
	bne loc_038015B2	; 038015AC
	mov r0,#0x0	; 038015AE
	bx lr	; 038015B0
loc_038015B2:
	ldr r0,[r1,#0x38]	; 038015B2
	cmp r2,r0	; 038015B4
	bcc loc_038015BC	; 038015B6
	mov r0,#0x0	; 038015B8
	bx lr	; 038015BA
loc_038015BC:
	lsl r0,r2,#0x2	; 038015BC
	add r0,r1,r0	; 038015BE
	ldr r0,[r0,#0x3c]	; 038015C0
	add r0,r1,r0	; 038015C2
	bx lr	; 038015C4
	.byte 0x00, 0x00	; 038015C8

; ===== function loc_038015C8 =====
P2_Entry_038015C8:
	push {r4,r5,r6,r7,lr}	; 038015C8
	sub sp,#0x4	; 038015CA
	add r5,r0,#0x0	; 038015CC
	add r7,r1,#0x0	; 038015CE
	str r2,[sp,#0x0]	; 038015D0
	add r6,r3,#0x0	; 038015D2
	ldr r4,[sp,#0x1c]	; 038015D4
	ldrb r1,[r4,#0x0]	; 038015D6
	cmp r1,#0x4	; 038015D8
	bhi loc_03801636	; 038015DA
	add r2,r1,r1	; 038015DC
P2_SwitchIndexPC_038015DC:
	add r2,pc	; 038015DE
	ldrh r2,[r2,#(P2_SwitchTable_038015DC - (P2_SwitchIndexPC_038015DC + 4))]	; 038015E0
	lsl r2,r2,#0x10	; 038015E2
	asr r2,r2,#0x10	; 038015E4
P2_SwitchTargetPC_038015DC:
	add r2,pc	; 038015E6
	bx r2	; 038015E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038015DC:
	.halfword (loc_03801636 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_038015F4 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_03801624 + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_0380162E + 1) - (P2_SwitchTargetPC_038015DC + 4)
	.halfword (loc_038015F4 + 1) - (P2_SwitchTargetPC_038015DC + 4)
P2_SwitchTable_038015DCEnd:
loc_038015F4:
	cmp r1,#0x1	; 038015F4
	bne loc_03801606	; 038015F6
	ldr r0,[sp,#0x18]	; 038015F8
	ldrh r1,[r4,#0x4]	; 038015FA
	ldrh r2,[r4,#0x2]	; 038015FC
	bl loc_038015A4	; 038015FE
	add r2,r0,#0x0	; 03801602
	b loc_0380160E	; 03801604
loc_03801606:
	ldrh r0,[r4,#0x4]	; 03801606
	lsl r2,r0,#0x10	; 03801608
	ldrh r0,[r4,#0x2]	; 0380160A
	orr r2,r0	; 0380160C
loc_0380160E:
	cmp r2,#0x0	; 0380160E
	beq loc_03801620	; 03801610
	add r0,r5,#0x0	; 03801612
	add r1,r2,#0x0	; 03801614
	add r2,#0xc	; 03801616
	add r3,r6,#0x0	; 03801618
	bl loc_03800134	; 0380161A
	b loc_03801638	; 0380161E
loc_03801620:
	mov r0,#0x0	; 03801620
	b loc_03801638	; 03801622
loc_03801624:
	ldrh r1,[r4,#0x2]	; 03801624
	add r2,r6,#0x0	; 03801626
	bl loc_03800100	; 03801628
	b loc_03801638	; 0380162C
loc_0380162E:
	add r1,r6,#0x0	; 0380162E
	bl loc_038000D0	; 03801630
	b loc_03801638	; 03801634
loc_03801636:
	mov r0,#0x0	; 03801636
loc_03801638:
	cmp r0,#0x0	; 03801638
	bne loc_03801640	; 0380163A
	mov r0,#0x0	; 0380163C
	b loc_03801672	; 0380163E
loc_03801640:
	strb r7,[r5,#0x8]	; 03801640
	ldrb r0,[r4,#0x6]	; 03801642
	strb r0,[r5,#0x5]	; 03801644
	ldr r0,[sp,#0x0]	; 03801646
	strb r0,[r5,#0x9]	; 03801648
	add r0,r5,#0x0	; 0380164A
	ldrb r1,[r4,#0x7]	; 0380164C
	bl loc_038000B4	; 0380164E
	add r0,r5,#0x0	; 03801652
	ldrb r1,[r4,#0x8]	; 03801654
	bl loc_038000A0	; 03801656
	add r0,r5,#0x0	; 0380165A
	ldrb r1,[r4,#0x9]	; 0380165C
	bl loc_0380009C	; 0380165E
	add r0,r5,#0x0	; 03801662
	ldrb r1,[r4,#0xa]	; 03801664
	bl loc_03800088	; 03801666
	ldrb r0,[r4,#0xb]	; 0380166A
	sub r0,#0x40	; 0380166C
	strb r0,[r5,#0xa]	; 0380166E
	mov r0,#0x1	; 03801670
loc_03801672:
	add sp,#0x4	; 03801672
	pop {r4,r5,r6,r7}	; 03801674
	pop {r3}	; 03801676
	bx r3	; 03801678
	.byte 0x00, 0x00	; 0380167A
P2_Entry_0380167C:
	push {r4,r5,lr}	; 0380167C
	sub sp,#0x4	; 0380167E
	add r4,r0,#0x0	; 03801680
	add r0,r3,#0x0	; 03801682
	cmp r1,#0x0	; 03801684
	bge P2_Entry_0380168C	; 03801686
	mov r0,#0x0	; 03801688
	b P2_Entry_0380174E	; 0380168A
P2_Entry_0380168C:
	ldr r3,[r4,#0x38]	; 0380168C
	cmp r1,r3	; 0380168E
	bcc P2_Entry_03801696	; 03801690
	mov r0,#0x0	; 03801692
	b P2_Entry_0380174E	; 03801694
P2_Entry_03801696:
	lsl r1,r1,#0x2	; 03801696
	add r1,r4,r1	; 03801698
	ldr r3,[r1,#0x3c]	; 0380169A
	strb r3,[r0,#0x0]	; 0380169C
	ldrb r1,[r0,#0x0]	; 0380169E
	cmp r1,#0x10	; 038016A0
	bgt P2_Entry_038016C4	; 038016A2
	cmp r1,#0x10	; 038016A4
	bge P2_Entry_038016E2	; 038016A6
	cmp r1,#0x4	; 038016A8
	bhi P2_Entry_03801748	; 038016AA
	add r5,r1,r1	; 038016AC
P2_SwitchIndexPC_038016AC:
	add r5,pc	; 038016AE
	ldrh r5,[r5,#(P2_SwitchTable_038016AC - (P2_SwitchIndexPC_038016AC + 4))]	; 038016B0
	lsl r5,r5,#0x10	; 038016B2
	asr r5,r5,#0x10	; 038016B4
P2_SwitchTargetPC_038016AC:
	add r5,pc	; 038016B6
	bx r5	; 038016B8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038016AC:
	.halfword (P2_Entry_03801748 + 1) - (P2_SwitchTargetPC_038016AC + 4)
	.halfword (P2_Case_038016CA + 1) - (P2_SwitchTargetPC_038016AC + 4)
	.halfword (P2_Case_038016CA + 1) - (P2_SwitchTargetPC_038016AC + 4)
	.halfword (P2_Case_038016CA + 1) - (P2_SwitchTargetPC_038016AC + 4)
	.halfword (P2_Case_038016CA + 1) - (P2_SwitchTargetPC_038016AC + 4)
P2_SwitchTable_038016ACEnd:
P2_Entry_038016C4:
	cmp r1,#0x11	; 038016C4
	beq P2_Entry_03801716	; 038016C6
	b P2_Entry_03801748	; 038016C8
P2_Case_038016CA:
	lsr r1,r3,#0x8	; 038016CA
	add r3,r4,r1	; 038016CC
	add r2,r0,#0x2	; 038016CE
	mov r1,#0x5	; 038016D0
P2_Entry_038016D2:
	ldrh r0,[r3,#0x0]	; 038016D2
	add r3,r3,#0x2	; 038016D4
	strh r0,[r2,#0x0]	; 038016D6
	add r2,r2,#0x2	; 038016D8
	sub r1,r1,#0x1	; 038016DA
	cmp r1,#0x0	; 038016DC
	bne P2_Entry_038016D2	; 038016DE
	b P2_Entry_0380174C	; 038016E0
P2_Entry_038016E2:
	lsr r3,r3,#0x8	; 038016E2
	add r1,r4,r3	; 038016E4
	ldrb r5,[r1,#0x1]	; 038016E6
	ldrb r3,[r4,r3]	; 038016E8
	cmp r2,r3	; 038016EA
	bge P2_Entry_038016F2	; 038016EC
	mov r0,#0x0	; 038016EE
	b P2_Entry_0380174E	; 038016F0
P2_Entry_038016F2:
	cmp r2,r5	; 038016F2
	ble P2_Entry_038016FA	; 038016F4
	mov r0,#0x0	; 038016F6
	b P2_Entry_0380174E	; 038016F8
P2_Entry_038016FA:
	sub r3,r2,r3	; 038016FA
	mov r2,#0xc	; 038016FC
	mul r3,r2	; 038016FE
	add r1,r1,r3	; 03801700
	add r3,r1,#0x2	; 03801702
	mov r2,#0x6	; 03801704
P2_Entry_03801706:
	ldrh r1,[r3,#0x0]	; 03801706
	add r3,r3,#0x2	; 03801708
	strh r1,[r0,#0x0]	; 0380170A
	add r0,r0,#0x2	; 0380170C
	sub r2,r2,#0x1	; 0380170E
	cmp r2,#0x0	; 03801710
	bne P2_Entry_03801706	; 03801712
	b P2_Entry_0380174C	; 03801714
P2_Entry_03801716:
	mov r1,#0x0	; 03801716
	lsr r3,r3,#0x8	; 03801718
	add r4,r4,r3	; 0380171A
	b P2_Entry_03801728	; 0380171C
P2_Entry_0380171E:
	add r1,r1,#0x1	; 0380171E
	cmp r1,#0x8	; 03801720
	blt P2_Entry_03801728	; 03801722
	mov r0,#0x0	; 03801724
	b P2_Entry_0380174E	; 03801726
P2_Entry_03801728:
	ldrb r3,[r4,r1]	; 03801728
	cmp r2,r3	; 0380172A
	bgt P2_Entry_0380171E	; 0380172C
	mov r2,#0xc	; 0380172E
	mul r1,r2	; 03801730
	add r3,r4,r1	; 03801732
	add r3,#0x8	; 03801734
	mov r2,#0x6	; 03801736
P2_Entry_03801738:
	ldrh r1,[r3,#0x0]	; 03801738
	add r3,r3,#0x2	; 0380173A
	strh r1,[r0,#0x0]	; 0380173C
	add r0,r0,#0x2	; 0380173E
	sub r2,r2,#0x1	; 03801740
	cmp r2,#0x0	; 03801742
	bne P2_Entry_03801738	; 03801744
	b P2_Entry_0380174C	; 03801746
P2_Entry_03801748:
	mov r0,#0x0	; 03801748
	b P2_Entry_0380174E	; 0380174A
P2_Entry_0380174C:
	mov r0,#0x1	; 0380174C
P2_Entry_0380174E:
	add sp,#0x4	; 0380174E
	pop {r4,r5}	; 03801750
	pop {r3}	; 03801752
	bx r3	; 03801754
	.byte 0x00, 0x00	; 03801756

; ===== function loc_03801758 =====
loc_03801758:
	push {r4,r5,r6,r7,lr}	; 03801758
	sub sp,#0x4	; 0380175A
	mov r5,#0x0	; 0380175C
	add r4,r5,#0x0	; 0380175E
	ldr r0,[pool_038017BC]	; 03801760
	ldr r0,[r0,#0x0]	; 03801762
	cmp r0,#0x0	; 03801764
	beq loc_038017B4	; 03801766
	add r6,r5,#0x0	; 03801768
	mov r7,#0x1	; 0380176A
loc_0380176C:
	add r0,r6,#0x0	; 0380176C
	bl loc_037FF564	; 0380176E
	cmp r0,#0x0	; 03801772
	beq loc_03801780	; 03801774
	add r0,r7,#0x0	; 03801776
	lsl r0,r6	; 03801778
	orr r5,r0	; 0380177A
	lsl r0,r5,#0x10	; 0380177C
	lsr r5,r0,#0x10	; 0380177E
loc_03801780:
	add r6,r6,#0x1	; 03801780
	cmp r6,#0x10	; 03801782
	blt loc_0380176C	; 03801784
	mov r0,#0x0	; 03801786
	bl loc_037FFAB8	; 03801788
	cmp r0,#0x0	; 0380178C
	beq loc_03801798	; 0380178E
	mov r0,#0x1	; 03801790
	orr r4,r0	; 03801792
	lsl r0,r4,#0x10	; 03801794
	lsr r4,r0,#0x10	; 03801796
loc_03801798:
	mov r0,#0x1	; 03801798
	bl loc_037FFAB8	; 0380179A
	cmp r0,#0x0	; 0380179E
	beq loc_038017AA	; 038017A0
	mov r0,#0x2	; 038017A2
	orr r4,r0	; 038017A4
	lsl r0,r4,#0x10	; 038017A6
	lsr r4,r0,#0x10	; 038017A8
loc_038017AA:
	ldr r0,[pool_038017BC]	; 038017AA
	ldr r1,[r0,#0x0]	; 038017AC
	strh r5,[r1,#0x8]	; 038017AE
	ldr r0,[r0,#0x0]	; 038017B0
	strh r4,[r0,#0xa]	; 038017B2
loc_038017B4:
	add sp,#0x4	; 038017B4
	pop {r4,r5,r6,r7}	; 038017B6
	pop {r3}	; 038017B8
	bx r3	; 038017BA
pool_038017BC:
loc_038017BC:
	.word P2_BssStart + 0xB80	; 038017BC

; ===== function loc_038017C0 =====
loc_038017C0:
	ldr r2,[pool_038017D0]	; 038017C0
	ldr r2,[r2,#0x0]	; 038017C2
	lsl r0,r0,#0x1	; 038017C4
	add r2,r2,r0	; 038017C6
	ldr r0,[pool_038017D4]	; 038017C8
	strh r1,[r2,r0]	; 038017CA
	bx lr	; 038017CC
	.byte 0xC0, 0x46	; 038017D0
pool_038017D0:
loc_038017D0:
	.word P2_BssStart + 0xB80	; 038017D0
pool_038017D4:
loc_038017D4:
	.word 0x00000260	; 038017D4

; ===== function loc_038017D8 =====
loc_038017D8:
	push {r4,lr}	; 038017D8
	ldr r3,[pool_038017F0]	; 038017DA
	ldr r4,[r3,#0x0]	; 038017DC
	mov r3,#0x24	; 038017DE
	mul r0,r3	; 038017E0
	add r3,r4,r0	; 038017E2
	lsl r0,r1,#0x1	; 038017E4
	add r0,r3,r0	; 038017E6
	strh r2,[r0,#0x20]	; 038017E8
	pop {r4}	; 038017EA
	pop {r3}	; 038017EC
	bx r3	; 038017EE
pool_038017F0:
loc_038017F0:
	.word P2_BssStart + 0xB80	; 038017F0

; ===== function loc_038017F4 =====
	push {r4,r5,r6,lr}	; 038017F4
	add r5,r0,#0x0	; 038017F6
	mov r4,#0x7	; 038017F8
	mov r6,#0x0	; 038017FA
loc_038017FC:
	add r0,r4,#0x0	; 038017FC
	add r1,r5,#0x0	; 038017FE
	add r2,r6,#0x0	; 03801800
	bl loc_03801F38	; 03801802
	cmp r0,#0x0	; 03801806
	blt loc_038017FC	; 03801808
	pop {r4,r5,r6}	; 0380180A
	pop {r3}	; 0380180C
	bx r3	; 0380180E

; ===== function loc_03801810 =====
loc_03801810:
	push {r4,lr}	; 03801810
	ldr r1,[pool_03801838]	; 03801812
	lsl r0,r0,#0x6	; 03801814
	add r4,r1,r0	; 03801816
	ldrb r0,[r1,r0]	; 03801818
	cmp r0,#0x0	; 0380181A
	beq loc_03801832	; 0380181C
	add r0,r4,#0x0	; 0380181E
	add r0,#0x14	; 03801820
	bl loc_037FEA64	; 03801822
	add r1,r4,#0x1	; 03801826
	ldrb r0,[r1,#0x0]	; 03801828
	add r0,r0,#0x1	; 0380182A
	strb r0,[r1,#0x0]	; 0380182C
	mov r0,#0x0	; 0380182E
	strb r0,[r4,#0x0]	; 03801830
loc_03801832:
	pop {r4}	; 03801832
	pop {r3}	; 03801834
	bx r3	; 03801836
pool_03801838:
loc_03801838:
	.word P2_BssStart + 0x1B04	; 03801838

; ===== function loc_0380183C =====
loc_0380183C:
	push {r4,r5,r6,r7,lr}	; 0380183C
	sub sp,#0x1c	; 0380183E
	str r0,[sp,#0xc]	; 03801840
	ldr r1,[pool_038018C8]	; 03801842
	lsl r0,r0,#0x6	; 03801844
	add r5,r1,r0	; 03801846
	ldrb r0,[r1,r0]	; 03801848
	cmp r0,#0x0	; 0380184A
	beq loc_0380185A	; 0380184C
	add r0,r5,#0x0	; 0380184E
	add r0,#0x14	; 03801850
	bl loc_037FEA64	; 03801852
	mov r0,#0x0	; 03801856
	strb r0,[r5,#0x0]	; 03801858
loc_0380185A:
	ldr r6,[r5,#0x4]	; 0380185A
	ldr r7,[r5,#0x8]	; 0380185C
	ldr r0,[r5,#0xc]	; 0380185E
	str r0,[sp,#0x10]	; 03801860
	ldr r0,[r5,#0x10]	; 03801862
	str r0,[sp,#0x14]	; 03801864
	ldrb r0,[r5,#0x1]	; 03801866
	lsl r4,r0,#0x8	; 03801868
	ldr r0,[sp,#0xc]	; 0380186A
	orr r4,r0	; 0380186C
	add r0,r5,#0x0	; 0380186E
	add r0,#0x14	; 03801870
	bl loc_037FEC3C	; 03801872
	mov r2,#0x0	; 03801876
	ldr r1,[sp,#0x14]	; 03801878
	eor r1,r2	; 0380187A
	ldr r0,[sp,#0x10]	; 0380187C
	eor r0,r2	; 0380187E
	orr r1,r0	; 03801880
	bne loc_03801896	; 03801882
	str r4,[sp,#0x0]	; 03801884
	add r0,r5,#0x0	; 03801886
	add r0,#0x14	; 03801888
	add r1,r6,#0x0	; 0380188A
	add r2,r7,#0x0	; 0380188C
	ldr r3,[pool_038018CC]	; 0380188E
	bl loc_037FEB10	; 03801890
	b loc_038018BA	; 03801894
loc_03801896:
	bl loc_037FE870	; 03801896
	str r0,[sp,#0x18]	; 0380189A
	add r2,r1,#0x0	; 0380189C
	ldr r0,[pool_038018CC]	; 0380189E
	str r0,[sp,#0x4]	; 038018A0
	str r4,[sp,#0x8]	; 038018A2
	ldr r3,[sp,#0x10]	; 038018A4
	ldr r0,[sp,#0x14]	; 038018A6
	str r0,[sp,#0x0]	; 038018A8
	add r0,r5,#0x0	; 038018AA
	add r0,#0x14	; 038018AC
	ldr r1,[sp,#0x18]	; 038018AE
	add r1,r6,r1	; 038018B0
	adc r7,r2	; 038018B2
	add r2,r7,#0x0	; 038018B4
	bl loc_037FEAC0	; 038018B6
loc_038018BA:
	mov r0,#0x1	; 038018BA
	strb r0,[r5,#0x0]	; 038018BC
	add sp,#0x1c	; 038018BE
	pop {r4,r5,r6,r7}	; 038018C0
	pop {r3}	; 038018C2
	bx r3	; 038018C4
	.byte 0xC0, 0x46	; 038018C8
pool_038018C8:
loc_038018C8:
	.word P2_BssStart + 0x1B04	; 038018C8
pool_038018CC:
loc_038018CC:
	.word 0x038017F5	; 038018CC

; ===== function loc_038018D0 =====
loc_038018D0:
	push {r4,r5,r6,lr}	; 038018D0
	sub sp,#0x8	; 038018D2
	add r5,r1,#0x0	; 038018D4
	add r6,r2,#0x0	; 038018D6
	str r3,[sp,#0x0]	; 038018D8
	ldr r1,[sp,#0x18]	; 038018DA
	str r1,[sp,#0x4]	; 038018DC
	ldr r1,[pool_03801910]	; 038018DE
	lsl r0,r0,#0x6	; 038018E0
	add r4,r1,r0	; 038018E2
	ldrb r0,[r1,r0]	; 038018E4
	cmp r0,#0x0	; 038018E6
	beq loc_038018F6	; 038018E8
	add r0,r4,#0x0	; 038018EA
	add r0,#0x14	; 038018EC
	bl loc_037FEA64	; 038018EE
	mov r0,#0x0	; 038018F2
	strb r0,[r4,#0x0]	; 038018F4
loc_038018F6:
	str r5,[r4,#0x4]	; 038018F6
	str r6,[r4,#0x8]	; 038018F8
	ldr r0,[sp,#0x0]	; 038018FA
	str r0,[r4,#0xc]	; 038018FC
	ldr r0,[sp,#0x4]	; 038018FE
	str r0,[r4,#0x10]	; 03801900
	ldr r0,[sp,#0x1c]	; 03801902
	strb r0,[r4,#0x1]	; 03801904
	add sp,#0x8	; 03801906
	pop {r4,r5,r6}	; 03801908
	pop {r3}	; 0380190A
	bx r3	; 0380190C
	.byte 0xC0, 0x46	; 03801910
pool_03801910:
loc_03801910:
	.word P2_BssStart + 0x1B04	; 03801910
P2_Entry_03801914:
	push {r4,r5,lr}	; 03801914
	sub sp,#0x4	; 03801916
	mov r5,#0x0	; 03801918
	ldr r4,[pool_03801938]	; 0380191A
	add r2,r5,#0x0	; 0380191C
	ldr r0,[pool_0380193C]	; 0380191E
	ldr r1,[pool_03801940]	; 03801920
P2_Entry_03801922:
	lsl r3,r5,#0x6	; 03801922
	add r3,r4,r3	; 03801924
	strb r2,[r3,r0]	; 03801926
	strb r2,[r3,r1]	; 03801928
	add r5,r5,#0x1	; 0380192A
	cmp r5,#0x8	; 0380192C
	blt P2_Entry_03801922	; 0380192E
	add sp,#0x4	; 03801930
	pop {r4,r5}	; 03801932
	pop {r3}	; 03801934
	bx r3	; 03801936
pool_03801938:
	.word 0x03805F24	; 03801938
pool_0380193C:
	.word 0x00000F80	; 0380193C
pool_03801940:
	.word 0x00000F81	; 03801940

; ===== function loc_03801944 =====
loc_03801944:
	push {r4,r5,r6,r7,lr}	; 03801944
	sub sp,#0xc	; 03801946
	add r5,r0,#0x0	; 03801948
	add r7,r1,#0x0	; 0380194A
	add r6,r2,#0x0	; 0380194C
	str r3,[sp,#0x0]	; 0380194E
	bl loc_037FDCE8	; 03801950
	str r0,[sp,#0x4]	; 03801954
	mov r4,#0x0	; 03801956
	b loc_0380196E	; 03801958
loc_0380195A:
	add r1,r6,#0x0	; 0380195A
	mov r0,#0x1	; 0380195C
	and r1,r0	; 0380195E
	cmp r1,#0x0	; 03801960
	beq loc_0380196A	; 03801962
	add r0,r4,#0x0	; 03801964
	bl loc_03801810	; 03801966
loc_0380196A:
	add r4,r4,#0x1	; 0380196A
	lsr r6,r6,#0x1	; 0380196C
loc_0380196E:
	cmp r4,#0x8	; 0380196E
	bge loc_03801976	; 03801970
	cmp r6,#0x0	; 03801972
	bne loc_0380195A	; 03801974
loc_03801976:
	mov r4,#0x0	; 03801976
	mov r6,#0x1	; 03801978
	b loc_03801990	; 0380197A
loc_0380197C:
	add r0,r5,#0x0	; 0380197C
	and r0,r6	; 0380197E
	cmp r0,#0x0	; 03801980
	beq loc_0380198C	; 03801982
	add r0,r4,#0x0	; 03801984
	ldr r1,[sp,#0x0]	; 03801986
	bl loc_037FF630	; 03801988
loc_0380198C:
	add r4,r4,#0x1	; 0380198C
	lsr r5,r5,#0x1	; 0380198E
loc_03801990:
	cmp r4,#0x10	; 03801990
	bge loc_03801998	; 03801992
	cmp r5,#0x0	; 03801994
	bne loc_0380197C	; 03801996
loc_03801998:
	mov r0,#0x1	; 03801998
	add r1,r7,#0x0	; 0380199A
	and r1,r0	; 0380199C
	cmp r1,#0x0	; 0380199E
	beq loc_038019A8	; 038019A0
	mov r1,#0x0	; 038019A2
	ldr r0,[pool_038019C8]	; 038019A4
	strb r1,[r0,#0x0]	; 038019A6
loc_038019A8:
	mov r0,#0x2	; 038019A8
	and r7,r0	; 038019AA
	cmp r7,#0x0	; 038019AC
	beq loc_038019B6	; 038019AE
	mov r1,#0x0	; 038019B0
	ldr r0,[pool_038019CC]	; 038019B2
	strb r1,[r0,#0x0]	; 038019B4
loc_038019B6:
	ldr r0,[sp,#0x4]	; 038019B6
	bl loc_037FDD0C	; 038019B8
	bl loc_03801758	; 038019BC
	add sp,#0xc	; 038019C0
	pop {r4,r5,r6,r7}	; 038019C2
	pop {r3}	; 038019C4
	bx r3	; 038019C6
pool_038019C8:
loc_038019C8:
	.word REG_SNDCAP0CNT	; 038019C8
pool_038019CC:
loc_038019CC:
	.word REG_SNDCAP1CNT	; 038019CC

; ===== function loc_038019D0 =====
loc_038019D0:
	push {r4,r5,r6,r7,lr}	; 038019D0
	sub sp,#0x4	; 038019D2
	add r5,r0,#0x0	; 038019D4
	add r4,r1,#0x0	; 038019D6
	add r6,r2,#0x0	; 038019D8
	bl loc_037FDCE8	; 038019DA
	add r7,r0,#0x0	; 038019DE
	mov r3,#0x0	; 038019E0
	b loc_03801A00	; 038019E2
loc_038019E4:
	add r1,r5,#0x0	; 038019E4
	mov r0,#0x1	; 038019E6
	and r1,r0	; 038019E8
	cmp r1,#0x0	; 038019EA
	beq loc_038019FC	; 038019EC
	lsl r1,r3,#0x4	; 038019EE
	ldr r0,[pool_03801A78]	; 038019F0
	add r2,r1,r0	; 038019F2
	ldrb r1,[r2,#0x0]	; 038019F4
	mov r0,#0x80	; 038019F6
	orr r1,r0	; 038019F8
	strb r1,[r2,#0x0]	; 038019FA
loc_038019FC:
	add r3,r3,#0x1	; 038019FC
	lsr r5,r5,#0x1	; 038019FE
loc_03801A00:
	cmp r3,#0x10	; 03801A00
	bge loc_03801A08	; 03801A02
	cmp r5,#0x0	; 03801A04
	bne loc_038019E4	; 03801A06
loc_03801A08:
	mov r0,#0x1	; 03801A08
	add r1,r4,#0x0	; 03801A0A
	and r1,r0	; 03801A0C
	cmp r1,#0x0	; 03801A0E
	beq loc_03801A32	; 03801A10
	mov r0,#0x2	; 03801A12
	and r4,r0	; 03801A14
	cmp r4,#0x0	; 03801A16
	beq loc_03801A26	; 03801A18
	ldr r2,[pool_03801A7C]	; 03801A1A
	ldrh r1,[r2,#0x0]	; 03801A1C
	ldr r0,[pool_03801A80]	; 03801A1E
	orr r1,r0	; 03801A20
	strh r1,[r2,#0x0]	; 03801A22
	b loc_03801A44	; 03801A24
loc_03801A26:
	ldr r2,[pool_03801A7C]	; 03801A26
	ldrb r1,[r2,#0x0]	; 03801A28
	mov r0,#0x80	; 03801A2A
	orr r1,r0	; 03801A2C
	strb r1,[r2,#0x0]	; 03801A2E
	b loc_03801A44	; 03801A30
loc_03801A32:
	mov r0,#0x2	; 03801A32
	and r4,r0	; 03801A34
	cmp r4,#0x0	; 03801A36
	beq loc_03801A44	; 03801A38
	ldr r2,[pool_03801A84]	; 03801A3A
	ldrb r1,[r2,#0x0]	; 03801A3C
	mov r0,#0x80	; 03801A3E
	orr r1,r0	; 03801A40
	strb r1,[r2,#0x0]	; 03801A42
loc_03801A44:
	mov r4,#0x0	; 03801A44
	mov r5,#0x1	; 03801A46
	b loc_03801A5C	; 03801A48
loc_03801A4A:
	add r0,r6,#0x0	; 03801A4A
	and r0,r5	; 03801A4C
	cmp r0,#0x0	; 03801A4E
	beq loc_03801A58	; 03801A50
	add r0,r4,#0x0	; 03801A52
	bl loc_0380183C	; 03801A54
loc_03801A58:
	add r4,r4,#0x1	; 03801A58
	lsr r6,r6,#0x1	; 03801A5A
loc_03801A5C:
	cmp r4,#0x8	; 03801A5C
	bge loc_03801A64	; 03801A5E
	cmp r6,#0x0	; 03801A60
	bne loc_03801A4A	; 03801A62
loc_03801A64:
	add r0,r7,#0x0	; 03801A64
	bl loc_037FDD0C	; 03801A66
	bl loc_03801758	; 03801A6A
	add sp,#0x4	; 03801A6E
	pop {r4,r5,r6,r7}	; 03801A70
	pop {r3}	; 03801A72
	bx r3	; 03801A74
	.byte 0xC0, 0x46	; 03801A78
pool_03801A78:
loc_03801A78:
	.word 0x04000403	; 03801A78
pool_03801A7C:
loc_03801A7C:
	.word REG_SNDCAP0CNT	; 03801A7C
pool_03801A80:
loc_03801A80:
	.word 0x00008080	; 03801A80
pool_03801A84:
loc_03801A84:
	.word REG_SNDCAP1CNT	; 03801A84

; ===== function loc_03801A88 =====
loc_03801A88:
	push {r4,r5,r6,r7,lr}	; 03801A88
	sub sp,#0x4	; 03801A8A
	add r5,r0,#0x0	; 03801A8C
	add r6,r1,#0x0	; 03801A8E
	mov r4,#0x0	; 03801A90
	mov r7,#0x1	; 03801A92
	b loc_03801AAA	; 03801A94
loc_03801A96:
	add r0,r5,#0x0	; 03801A96
	and r0,r7	; 03801A98
	cmp r0,#0x0	; 03801A9A
	beq loc_03801AA6	; 03801A9C
	add r0,r4,#0x0	; 03801A9E
	add r1,r6,#0x0	; 03801AA0
	bl loc_037FF580	; 03801AA2
loc_03801AA6:
	add r4,r4,#0x1	; 03801AA6
	lsr r5,r5,#0x1	; 03801AA8
loc_03801AAA:
	cmp r4,#0x10	; 03801AAA
	bge loc_03801AB2	; 03801AAC
	cmp r5,#0x0	; 03801AAE
	bne loc_03801A96	; 03801AB0
loc_03801AB2:
	add sp,#0x4	; 03801AB2
	pop {r4,r5,r6,r7}	; 03801AB4
	pop {r3}	; 03801AB6
	bx r3	; 03801AB8
	.byte 0x00, 0x00	; 03801ABC

; ===== function loc_03801ABC =====
loc_03801ABC:
	push {r4,r5,r6,r7,lr}	; 03801ABC
	sub sp,#0x4	; 03801ABE
	add r5,r0,#0x0	; 03801AC0
	add r6,r1,#0x0	; 03801AC2
	add r7,r2,#0x0	; 03801AC4
	mov r4,#0x0	; 03801AC6
	b loc_03801AE2	; 03801AC8
loc_03801ACA:
	add r1,r5,#0x0	; 03801ACA
	mov r0,#0x1	; 03801ACC
	and r1,r0	; 03801ACE
	cmp r1,#0x0	; 03801AD0
	beq loc_03801ADE	; 03801AD2
	add r0,r4,#0x0	; 03801AD4
	add r1,r6,#0x0	; 03801AD6
	add r2,r7,#0x0	; 03801AD8
	bl loc_037FF5D8	; 03801ADA
loc_03801ADE:
	add r4,r4,#0x1	; 03801ADE
	lsr r5,r5,#0x1	; 03801AE0
loc_03801AE2:
	cmp r4,#0x10	; 03801AE2
	bge loc_03801AEA	; 03801AE4
	cmp r5,#0x0	; 03801AE6
	bne loc_03801ACA	; 03801AE8
loc_03801AEA:
	add sp,#0x4	; 03801AEA
	pop {r4,r5,r6,r7}	; 03801AEC
	pop {r3}	; 03801AEE
	bx r3	; 03801AF0
	.byte 0x00, 0x00	; 03801AF4

; ===== function loc_03801AF4 =====
loc_03801AF4:
	push {r4,r5,r6,r7,lr}	; 03801AF4
	sub sp,#0x4	; 03801AF6
	add r5,r0,#0x0	; 03801AF8
	add r6,r1,#0x0	; 03801AFA
	mov r4,#0x0	; 03801AFC
	mov r7,#0x1	; 03801AFE
	b loc_03801B16	; 03801B00
loc_03801B02:
	add r0,r5,#0x0	; 03801B02
	and r0,r7	; 03801B04
	cmp r0,#0x0	; 03801B06
	beq loc_03801B12	; 03801B08
	add r0,r4,#0x0	; 03801B0A
	add r1,r6,#0x0	; 03801B0C
	bl loc_037FF5C4	; 03801B0E
loc_03801B12:
	add r4,r4,#0x1	; 03801B12
	lsr r5,r5,#0x1	; 03801B14
loc_03801B16:
	cmp r4,#0x10	; 03801B16
	bge loc_03801B1E	; 03801B18
	cmp r5,#0x0	; 03801B1A
	bne loc_03801B02	; 03801B1C
loc_03801B1E:
	add sp,#0x4	; 03801B1E
	pop {r4,r5,r6,r7}	; 03801B20
	pop {r3}	; 03801B22
	bx r3	; 03801B24
	.byte 0x00, 0x00	; 03801B28

; ===== function loc_03801B28 =====
loc_03801B28:
	mov r0,#0x7	; 03801B28
	ldr r1,[pool_03801B30]	; 03801B2A
	ldr r3,[pool_03801B34]	; 03801B2C
	bx r3	; 03801B2E
pool_03801B30:
loc_03801B30:
	.word 0x03801B39	; 03801B30
pool_03801B34:
loc_03801B34:
	.word P2_SetPxiReceiveCallback + 1	; 03801B34

; ===== function loc_03801B38 =====
	push {r4,r5,lr}	; 03801B38
	sub sp,#0x4	; 03801B3A
	add r5,r1,#0x0	; 03801B3C
	bl loc_037FDCE8	; 03801B3E
	add r4,r0,#0x0	; 03801B42
	ldr r0,[pool_03801B6C]	; 03801B44
	cmp r5,r0	; 03801B46
	bcc loc_03801B56	; 03801B48
	ldr r0,[pool_03801B70]	; 03801B4A
	add r1,r5,#0x0	; 03801B4C
	mov r2,#0x0	; 03801B4E
	bl loc_037FE308	; 03801B50
	b loc_03801B5E	; 03801B54
loc_03801B56:
	cmp r5,#0x0	; 03801B56
	bne loc_03801B5E	; 03801B58
	bl loc_037FF9D8	; 03801B5A
loc_03801B5E:
	add r0,r4,#0x0	; 03801B5E
	bl loc_037FDD0C	; 03801B60
	add sp,#0x4	; 03801B64
	pop {r4,r5}	; 03801B66
	pop {r3}	; 03801B68
	bx r3	; 03801B6A
pool_03801B6C:
loc_03801B6C:
	.word 0x02000000	; 03801B6C
pool_03801B70:
loc_03801B70:
	.word 0x038070A4	; 03801B70

; ===== function loc_03801B74 =====
P2_Entry_03801B74:
	push {r4,r5,r6,r7,lr}	; 03801B74
	sub sp,#0x34	; 03801B76
	mov r4,#0x7f	; 03801B78
	mov r7,#0x3	; 03801B7A
	mov r6,#0x1	; 03801B7C
	b loc_03801DE8	; 03801B7E
loc_03801B80:
	ldr r5,[sp,#0x18]	; 03801B80
	b loc_03801DD8	; 03801B82
loc_03801B84:
	add r3,sp,#0x1c	; 03801B84
	mov r2,#0x3	; 03801B86
loc_03801B88:
	ldmia r5!,{r0,r1}	; 03801B88
	stmia r3!,{r0,r1}	; 03801B8A
	sub r2,r2,#0x1	; 03801B8C
	cmp r2,#0x0	; 03801B8E
	bne loc_03801B88	; 03801B90
	ldr r0,[sp,#0x20]	; 03801B92
	cmp r0,#0x1d	; 03801B94
	bls loc_03801B9A	; 03801B96
	b loc_03801DD6	; 03801B98
loc_03801B9A:
	add r0,r0,r0	; 03801B9A
P2_SwitchIndexPC_03801B9A:
	add r0,pc	; 03801B9C
	ldrh r0,[r0,#(P2_SwitchTable_03801B9A - (P2_SwitchIndexPC_03801B9A + 4))]	; 03801B9E
	lsl r0,r0,#0x10	; 03801BA0
	asr r0,r0,#0x10	; 03801BA2
P2_SwitchTargetPC_03801B9A:
	add r0,pc	; 03801BA4
	bx r0	; 03801BA6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801B9A:
	.halfword (loc_03801BE4 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801BF2 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801BFA + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C04 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C12 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C2C + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C38 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C44 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C54 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C62 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C70 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801CDA + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D26 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D48 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801C7E + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801CA4 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801CBA + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801CC4 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801CD0 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D6A + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D72 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D7A + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D88 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D92 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801D9C + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801DC4 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801DCC + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801DA6 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801DB0 + 1) - (P2_SwitchTargetPC_03801B9A + 4)
	.halfword (loc_03801DBA + 1) - (P2_SwitchTargetPC_03801B9A + 4)
P2_SwitchTable_03801B9AEnd:
loc_03801BE4:
	ldr r0,[sp,#0x24]	; 03801BE4
	ldr r1,[sp,#0x28]	; 03801BE6
	ldr r2,[sp,#0x2c]	; 03801BE8
	ldr r3,[sp,#0x30]	; 03801BEA
	bl loc_03801438	; 03801BEC
	b loc_03801DD6	; 03801BF0
loc_03801BF2:
	ldr r0,[sp,#0x24]	; 03801BF2
	bl loc_038013FC	; 03801BF4
	b loc_03801DD6	; 03801BF8
loc_03801BFA:
	ldr r0,[sp,#0x24]	; 03801BFA
	ldr r1,[sp,#0x28]	; 03801BFC
	bl loc_038013C4	; 03801BFE
	b loc_03801DD6	; 03801C02
loc_03801C04:
	ldr r0,[sp,#0x24]	; 03801C04
	ldr r1,[sp,#0x28]	; 03801C06
	ldr r2,[sp,#0x2c]	; 03801C08
	ldr r3,[sp,#0x30]	; 03801C0A
	bl loc_03801248	; 03801C0C
	b loc_03801DD6	; 03801C10
loc_03801C12:
	ldr r0,[sp,#0x24]	; 03801C12
	lsr r2,r0,#0x18	; 03801C14
	mov r1,#0xff	; 03801C16
	and r2,r1	; 03801C18
	str r2,[sp,#0x0]	; 03801C1A
	ldr r1,[pool_03801E00]	; 03801C1C
	and r0,r1	; 03801C1E
	ldr r1,[sp,#0x28]	; 03801C20
	ldr r2,[sp,#0x2c]	; 03801C22
	ldr r3,[sp,#0x30]	; 03801C24
	bl loc_038011EC	; 03801C26
	b loc_03801DD6	; 03801C2A
loc_03801C2C:
	ldr r0,[sp,#0x24]	; 03801C2C
	ldr r1,[sp,#0x28]	; 03801C2E
	ldr r2,[sp,#0x2c]	; 03801C30
	bl loc_0380135C	; 03801C32
	b loc_03801DD6	; 03801C36
loc_03801C38:
	ldr r0,[sp,#0x24]	; 03801C38
	ldr r1,[sp,#0x28]	; 03801C3A
	ldr r2,[sp,#0x2c]	; 03801C3C
	bl loc_0380130C	; 03801C3E
	b loc_03801DD6	; 03801C42
loc_03801C44:
	ldr r0,[sp,#0x24]	; 03801C44
	ldr r1,[sp,#0x28]	; 03801C46
	ldr r2,[sp,#0x2c]	; 03801C48
	lsl r2,r2,#0x10	; 03801C4A
	asr r2,r2,#0x10	; 03801C4C
	bl loc_038017D8	; 03801C4E
	b loc_03801DD6	; 03801C52
loc_03801C54:
	ldr r0,[sp,#0x24]	; 03801C54
	ldr r1,[sp,#0x28]	; 03801C56
	lsl r1,r1,#0x10	; 03801C58
	asr r1,r1,#0x10	; 03801C5A
	bl loc_038017C0	; 03801C5C
	b loc_03801DD6	; 03801C60
loc_03801C62:
	ldr r0,[sp,#0x24]	; 03801C62
	ldr r1,[sp,#0x28]	; 03801C64
	ldr r2,[sp,#0x2c]	; 03801C66
	ldr r3,[sp,#0x30]	; 03801C68
	bl loc_038019D0	; 03801C6A
	b loc_03801DD6	; 03801C6E
loc_03801C70:
	ldr r0,[sp,#0x24]	; 03801C70
	ldr r1,[sp,#0x28]	; 03801C72
	ldr r2,[sp,#0x2c]	; 03801C74
	ldr r3,[sp,#0x30]	; 03801C76
	bl loc_03801944	; 03801C78
	b loc_03801DD6	; 03801C7C
loc_03801C7E:
	ldr r1,[sp,#0x2c]	; 03801C7E
	lsr r0,r1,#0x1d	; 03801C80
	and r0,r6	; 03801C82
	str r0,[sp,#0x0]	; 03801C84
	lsr r0,r1,#0x1c	; 03801C86
	and r0,r6	; 03801C88
	str r0,[sp,#0x4]	; 03801C8A
	lsr r0,r1,#0x1b	; 03801C8C
	and r0,r6	; 03801C8E
	str r0,[sp,#0x8]	; 03801C90
	lsr r0,r1,#0x1f	; 03801C92
	and r0,r6	; 03801C94
	lsr r1,r1,#0x1e	; 03801C96
	and r1,r6	; 03801C98
	ldr r2,[sp,#0x24]	; 03801C9A
	ldr r3,[sp,#0x28]	; 03801C9C
	bl loc_037FFAD0	; 03801C9E
	b loc_03801DD6	; 03801CA2
loc_03801CA4:
	ldr r0,[sp,#0x30]	; 03801CA4
	str r0,[sp,#0x4]	; 03801CA6
	ldr r3,[sp,#0x2c]	; 03801CA8
	mov r0,#0x0	; 03801CAA
	str r0,[sp,#0x0]	; 03801CAC
	ldr r0,[sp,#0x24]	; 03801CAE
	ldr r1,[sp,#0x28]	; 03801CB0
	mov r2,#0x0	; 03801CB2
	bl loc_038018D0	; 03801CB4
	b loc_03801DD6	; 03801CB8
loc_03801CBA:
	ldr r0,[sp,#0x24]	; 03801CBA
	ldr r1,[sp,#0x28]	; 03801CBC
	bl loc_03801AF4	; 03801CBE
	b loc_03801DD6	; 03801CC2
loc_03801CC4:
	ldr r0,[sp,#0x24]	; 03801CC4
	ldr r1,[sp,#0x28]	; 03801CC6
	ldr r2,[sp,#0x2c]	; 03801CC8
	bl loc_03801ABC	; 03801CCA
	b loc_03801DD6	; 03801CCE
loc_03801CD0:
	ldr r0,[sp,#0x24]	; 03801CD0
	ldr r1,[sp,#0x28]	; 03801CD2
	bl loc_03801A88	; 03801CD4
	b loc_03801DD6	; 03801CD8
loc_03801CDA:
	ldr r3,[sp,#0x30]	; 03801CDA
	ldr r2,[sp,#0x24]	; 03801CDC
	ldr r1,[sp,#0x2c]	; 03801CDE
	add r5,r3,#0x0	; 03801CE0
	ldr r0,[pool_03801E04]	; 03801CE2
	and r5,r0	; 03801CE4
	str r5,[sp,#0x0]	; 03801CE6
	add r5,r1,#0x0	; 03801CE8
	ldr r0,[pool_03801E08]	; 03801CEA
	and r5,r0	; 03801CEC
	str r5,[sp,#0x4]	; 03801CEE
	lsr r0,r1,#0x18	; 03801CF0
	and r0,r4	; 03801CF2
	str r0,[sp,#0x8]	; 03801CF4
	lsr r0,r1,#0x16	; 03801CF6
	and r0,r7	; 03801CF8
	str r0,[sp,#0xc]	; 03801CFA
	lsr r1,r2,#0x10	; 03801CFC
	ldr r0,[pool_03801E04]	; 03801CFE
	and r1,r0	; 03801D00
	str r1,[sp,#0x10]	; 03801D02
	lsr r0,r3,#0x10	; 03801D04
	and r0,r4	; 03801D06
	str r0,[sp,#0x14]	; 03801D08
	ldr r0,[pool_03801E04]	; 03801D0A
	and r2,r0	; 03801D0C
	add r0,r2,#0x0	; 03801D0E
	ldr r2,[sp,#0x28]	; 03801D10
	ldr r1,[pool_03801E0C]	; 03801D12
	and r2,r1	; 03801D14
	add r1,r2,#0x0	; 03801D16
	lsr r2,r3,#0x18	; 03801D18
	and r2,r7	; 03801D1A
	lsr r3,r3,#0x1a	; 03801D1C
	and r3,r7	; 03801D1E
	bl loc_037FF72C	; 03801D20
	b loc_03801DD6	; 03801D24
loc_03801D26:
	ldr r2,[sp,#0x2c]	; 03801D26
	ldr r3,[sp,#0x28]	; 03801D28
	lsr r1,r2,#0x8	; 03801D2A
	ldr r0,[pool_03801E04]	; 03801D2C
	and r1,r0	; 03801D2E
	str r1,[sp,#0x0]	; 03801D30
	and r2,r4	; 03801D32
	str r2,[sp,#0x4]	; 03801D34
	ldr r0,[sp,#0x24]	; 03801D36
	ldr r1,[sp,#0x30]	; 03801D38
	add r2,r3,#0x0	; 03801D3A
	and r2,r4	; 03801D3C
	lsr r3,r3,#0x8	; 03801D3E
	and r3,r7	; 03801D40
	bl loc_037FF6C0	; 03801D42
	b loc_03801DD6	; 03801D46
loc_03801D48:
	ldr r3,[sp,#0x2c]	; 03801D48
	ldr r2,[sp,#0x28]	; 03801D4A
	add r0,r3,#0x0	; 03801D4C
	and r0,r4	; 03801D4E
	str r0,[sp,#0x0]	; 03801D50
	ldr r0,[sp,#0x24]	; 03801D52
	add r1,r2,#0x0	; 03801D54
	and r1,r4	; 03801D56
	lsr r2,r2,#0x8	; 03801D58
	and r2,r7	; 03801D5A
	lsr r5,r3,#0x8	; 03801D5C
	ldr r3,[pool_03801E04]	; 03801D5E
	and r5,r3	; 03801D60
	add r3,r5,#0x0	; 03801D62
	bl loc_037FF658	; 03801D64
	b loc_03801DD6	; 03801D68
loc_03801D6A:
	ldr r0,[sp,#0x24]	; 03801D6A
	bl loc_037FF518	; 03801D6C
	b loc_03801DD6	; 03801D70
loc_03801D72:
	ldr r0,[sp,#0x24]	; 03801D72
	bl loc_037FF440	; 03801D74
	b loc_03801DD6	; 03801D78
loc_03801D7A:
	ldr r0,[sp,#0x24]	; 03801D7A
	ldr r1,[sp,#0x28]	; 03801D7C
	ldr r2,[sp,#0x2c]	; 03801D7E
	ldr r3,[sp,#0x30]	; 03801D80
	bl loc_037FF40C	; 03801D82
	b loc_03801DD6	; 03801D86
loc_03801D88:
	ldr r0,[sp,#0x24]	; 03801D88
	ldr r1,[sp,#0x28]	; 03801D8A
	bl loc_037FFE78	; 03801D8C
	b loc_03801DD6	; 03801D90
loc_03801D92:
	ldr r0,[sp,#0x24]	; 03801D92
	ldr r1,[sp,#0x28]	; 03801D94
	bl loc_037FFE54	; 03801D96
	b loc_03801DD6	; 03801D9A
loc_03801D9C:
	ldr r0,[sp,#0x24]	; 03801D9C
	ldr r1,[sp,#0x28]	; 03801D9E
	bl loc_037FFF24	; 03801DA0
	b loc_03801DD6	; 03801DA4
loc_03801DA6:
	ldr r0,[sp,#0x24]	; 03801DA6
	ldr r1,[sp,#0x28]	; 03801DA8
	bl loc_038012B4	; 03801DAA
	b loc_03801DD6	; 03801DAE
loc_03801DB0:
	ldr r0,[sp,#0x24]	; 03801DB0
	ldr r1,[sp,#0x28]	; 03801DB2
	bl loc_03801278	; 03801DB4
	b loc_03801DD6	; 03801DB8
loc_03801DBA:
	ldr r0,[sp,#0x24]	; 03801DBA
	ldr r1,[sp,#0x28]	; 03801DBC
	bl loc_037FFE04	; 03801DBE
	b loc_03801DD6	; 03801DC2
loc_03801DC4:
	ldr r1,[sp,#0x24]	; 03801DC4
	ldr r0,[pool_03801E10]	; 03801DC6
	str r1,[r0,#0x0]	; 03801DC8
	b loc_03801DD6	; 03801DCA
loc_03801DCC:
	ldr r0,[pool_03801E14]	; 03801DCC
	ldr r1,[sp,#0x24]	; 03801DCE
	ldr r2,[pool_03801E18]	; 03801DD0
	bl loc_03801E20	; 03801DD2
loc_03801DD6:
	ldr r5,[sp,#0x1c]	; 03801DD6
loc_03801DD8:
	cmp r5,#0x0	; 03801DD8
	beq loc_03801DDE	; 03801DDA
	b loc_03801B84	; 03801DDC
loc_03801DDE:
	ldr r0,[pool_03801E10]	; 03801DDE
	ldr r1,[r0,#0x0]	; 03801DE0
	ldr r0,[r1,#0x0]	; 03801DE2
	add r0,r0,#0x1	; 03801DE4
	str r0,[r1,#0x0]	; 03801DE6
loc_03801DE8:
	ldr r0,[pool_03801E1C]	; 03801DE8
	add r1,sp,#0x18	; 03801DEA
	mov r2,#0x0	; 03801DEC
	bl loc_037FE290	; 03801DEE
	cmp r0,#0x0	; 03801DF2
	beq loc_03801DF8	; 03801DF4
	b loc_03801B80	; 03801DF6
loc_03801DF8:
	add sp,#0x34	; 03801DF8
	pop {r4,r5,r6,r7}	; 03801DFA
	pop {r3}	; 03801DFC
	bx r3	; 03801DFE
pool_03801E00:
loc_03801E00:
	.word 0x00FFFFFF	; 03801E00
pool_03801E04:
loc_03801E04:
	.word 0x0000FFFF	; 03801E04
pool_03801E08:
loc_03801E08:
	.word 0x003FFFFF	; 03801E08
pool_03801E0C:
loc_03801E0C:
	.word 0x07FFFFFF	; 03801E0C
pool_03801E10:
loc_03801E10:
	.word P2_BssStart + 0xB80	; 03801E10
pool_03801E14:
loc_03801E14:
	.word 0x03805F24	; 03801E14
pool_03801E18:
loc_03801E18:
	.word 0x00001180	; 03801E18
pool_03801E1C:
loc_03801E1C:
	.word 0x038070A4	; 03801E1C

; ===== function loc_03801E20 =====
loc_03801E20:
	bx pc	; 03801E20
	.byte 0xC0, 0x46	; 03801E24
.arm

; ===== function loc_03801E24 =====
loc_03801E24:
	ldr pc,[pool_03801E28]	; 03801E24
pool_03801E28:
loc_03801E28:
	.word loc_037FF36C	; 03801E28
.thumb

; ===== function loc_03801E2C =====
loc_03801E2C:
	push {lr}	; 03801E2C
	sub sp,#0x4	; 03801E2E
	ldr r0,[pool_03801E4C]	; 03801E30
	ldr r1,[pool_03801E50]	; 03801E32
	mov r2,#0x8	; 03801E34
	bl loc_037FE364	; 03801E36
	bl loc_03801B28	; 03801E3A
	mov r1,#0x0	; 03801E3E
	ldr r0,[pool_03801E54]	; 03801E40
	str r1,[r0,#0x0]	; 03801E42
	add sp,#0x4	; 03801E44
	pop {r3}	; 03801E46
	bx r3	; 03801E48
	.byte 0xC0, 0x46	; 03801E4C
pool_03801E4C:
loc_03801E4C:
	.word 0x038070A4	; 03801E4C
pool_03801E50:
loc_03801E50:
	.word 0x038070B8	; 03801E50
pool_03801E54:
loc_03801E54:
	.word P2_BssStart + 0xB80	; 03801E54

; ===== function loc_03801E58 =====
loc_03801E58:
	ldr r3,[pool_03801E5C]	; 03801E58
	bx r3	; 03801E5A
pool_03801E5C:
loc_03801E5C:
	.word loc_03802010 + 1	; 03801E5C

; ===== function loc_03801E60 =====
P2_IrqHandler_03801E60:
	push {r4,r5,r6,r7,lr}	; 03801E60
	sub sp,#0x4	; 03801E62
	ldr r5,[pool_03801F1C]	; 03801E64
	mov r0,#0x3	; 03801E66
	mvn r6,r0	; 03801E68
	mov r7,#0x2	; 03801E6A
	mvn r4,r7	; 03801E6C
loc_03801E6E:
	ldrh r1,[r5,#0x0]	; 03801E6E
	ldr r0,[pool_03801F20]	; 03801E70
	and r1,r0	; 03801E72
	cmp r1,#0x0	; 03801E74
	beq loc_03801E84	; 03801E76
	ldrh r1,[r5,#0x0]	; 03801E78
	ldr r0,[pool_03801F24]	; 03801E7A
	orr r1,r0	; 03801E7C
	strh r1,[r5,#0x0]	; 03801E7E
	add r0,r4,#0x0	; 03801E80
	b loc_03801EA6	; 03801E82
loc_03801E84:
	bl loc_037FDCE8	; 03801E84
	ldrh r2,[r5,#0x0]	; 03801E88
	ldr r1,[pool_03801F28]	; 03801E8A
	and r2,r1	; 03801E8C
	cmp r2,#0x0	; 03801E8E
	beq loc_03801E9A	; 03801E90
	bl loc_037FDD0C	; 03801E92
	add r0,r6,#0x0	; 03801E96
	b loc_03801EA6	; 03801E98
loc_03801E9A:
	ldr r1,[pool_03801F2C]	; 03801E9A
	ldr r1,[r1,#0x0]	; 03801E9C
	str r1,[sp,#0x0]	; 03801E9E
	bl loc_037FDD0C	; 03801EA0
	mov r0,#0x0	; 03801EA4
loc_03801EA6:
	mov r1,#0x3	; 03801EA6
	mvn r1,r1	; 03801EA8
	cmp r0,r1	; 03801EAA
	beq loc_03801F14	; 03801EAC
	mvn r1,r7	; 03801EAE
	cmp r0,r1	; 03801EB0
	beq loc_03801E6E	; 03801EB2
	ldr r2,[sp,#0x0]	; 03801EB4
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 03801EB6
	lsr r0,r0,#0x1b	; 03801EB8
	cmp r0,#0x0	; 03801EBA
	beq loc_03801E6E	; 03801EBC
	lsl r3,r0,#0x2	; 03801EBE
	ldr r1,[pool_03801F30]	; 03801EC0
	ldr r3,[r1,r3]	; 03801EC2
	cmp r3,#0x0	; 03801EC4
	beq loc_03801ED4	; 03801EC6
	lsr r1,r2,#0x6	; 03801EC8
	lsl r2,r2,#0x1a	; 03801ECA
	lsr r2,r2,#0x1f	; 03801ECC
	bl loc_03805098	; 03801ECE
	b loc_03801E6E	; 03801ED2
loc_03801ED4:
	lsl r0,r2,#0x1a	; 03801ED4
	lsr r0,r0,#0x1f	; 03801ED6
	cmp r0,#0x0	; 03801ED8
	bne loc_03801E6E	; 03801EDA
	mov r0,#0x20	; 03801EDC
	orr r2,r0	; 03801EDE
	str r2,[sp,#0x0]	; 03801EE0
	ldrh r1,[r5,#0x0]	; 03801EE2
	ldr r0,[pool_03801F20]	; 03801EE4
	and r1,r0	; 03801EE6
	cmp r1,#0x0	; 03801EE8
	beq loc_03801EF6	; 03801EEA
	ldrh r1,[r5,#0x0]	; 03801EEC
	ldr r0,[pool_03801F24]	; 03801EEE
	orr r1,r0	; 03801EF0
	strh r1,[r5,#0x0]	; 03801EF2
	b loc_03801E6E	; 03801EF4
loc_03801EF6:
	bl loc_037FDCE8	; 03801EF6
	ldrh r1,[r5,#0x0]	; 03801EFA
	and r1,r7	; 03801EFC
	cmp r1,#0x0	; 03801EFE
	beq loc_03801F08	; 03801F00
	bl loc_037FDD0C	; 03801F02
	b loc_03801E6E	; 03801F06
loc_03801F08:
	ldr r2,[sp,#0x0]	; 03801F08
	ldr r1,[pool_03801F34]	; 03801F0A
	str r2,[r1,#0x0]	; 03801F0C
	bl loc_037FDD0C	; 03801F0E
	b loc_03801E6E	; 03801F12
loc_03801F14:
	add sp,#0x4	; 03801F14
	pop {r4,r5,r6,r7}	; 03801F16
	pop {r3}	; 03801F18
	bx r3	; 03801F1A
pool_03801F1C:
loc_03801F1C:
	.word REG_IPC_FIFO_CR	; 03801F1C
pool_03801F20:
loc_03801F20:
	.word 0x00004000	; 03801F20
pool_03801F24:
loc_03801F24:
	.word 0x0000C000	; 03801F24
pool_03801F28:
loc_03801F28:
	.word 0x00000100	; 03801F28
pool_03801F2C:
loc_03801F2C:
	.word REG_IPC_FIFO_RX	; 03801F2C
pool_03801F30:
loc_03801F30:
	.word P2_PxiReceiveCallbacks	; 03801F30
pool_03801F34:
loc_03801F34:
	.word REG_IPC_FIFO_TX	; 03801F34

; ===== function loc_03801F38 =====
loc_03801F38:
	push {r4,lr}	; 03801F38
	sub sp,#0x8	; 03801F3A
	ldr r3,[sp,#0x0]	; 03801F3C
	mov r4,#0x1f	; 03801F3E
	bic r3,r4	; 03801F40
	and r0,r4	; 03801F42
	orr r3,r0	; 03801F44
	str r3,[sp,#0x0]	; 03801F46
	mov r0,#0x20	; 03801F48
	bic r3,r0	; 03801F4A
	mov r0,#0x1	; 03801F4C
	and r2,r0	; 03801F4E
	lsl r0,r2,#0x5	; 03801F50
	orr r3,r0	; 03801F52
	str r3,[sp,#0x0]	; 03801F54
	mov r0,#0x3f	; 03801F56
	and r3,r0	; 03801F58
	ldr r0,[pool_03801FAC]	; 03801F5A
	and r1,r0	; 03801F5C
	lsl r0,r1,#0x6	; 03801F5E
	orr r3,r0	; 03801F60
	str r3,[sp,#0x0]	; 03801F62
	ldr r2,[pool_03801FB0]	; 03801F64
	ldrh r1,[r2,#0x0]	; 03801F66
	ldr r0,[pool_03801FB4]	; 03801F68
	and r1,r0	; 03801F6A
	cmp r1,#0x0	; 03801F6C
	beq loc_03801F7E	; 03801F6E
	ldrh r1,[r2,#0x0]	; 03801F70
	ldr r0,[pool_03801FB8]	; 03801F72
	orr r1,r0	; 03801F74
	strh r1,[r2,#0x0]	; 03801F76
	mov r0,#0x0	; 03801F78
	mvn r0,r0	; 03801F7A
	b loc_03801FA4	; 03801F7C
loc_03801F7E:
	bl loc_037FDCE8	; 03801F7E
	ldr r1,[pool_03801FB0]	; 03801F82
	ldrh r2,[r1,#0x0]	; 03801F84
	mov r1,#0x2	; 03801F86
	and r2,r1	; 03801F88
	cmp r2,#0x0	; 03801F8A
	beq loc_03801F98	; 03801F8C
	bl loc_037FDD0C	; 03801F8E
	mov r0,#0x1	; 03801F92
	mvn r0,r0	; 03801F94
	b loc_03801FA4	; 03801F96
loc_03801F98:
	ldr r2,[sp,#0x0]	; 03801F98
	ldr r1,[pool_03801FBC]	; 03801F9A
	str r2,[r1,#0x0]	; 03801F9C
	bl loc_037FDD0C	; 03801F9E
	mov r0,#0x0	; 03801FA2
loc_03801FA4:
	add sp,#0x8	; 03801FA4
	pop {r4}	; 03801FA6
	pop {r3}	; 03801FA8
	bx r3	; 03801FAA
pool_03801FAC:
loc_03801FAC:
	.word 0x03FFFFFF	; 03801FAC
pool_03801FB0:
loc_03801FB0:
	.word REG_IPC_FIFO_CR	; 03801FB0
pool_03801FB4:
loc_03801FB4:
	.word 0x00004000	; 03801FB4
pool_03801FB8:
loc_03801FB8:
	.word 0x0000C000	; 03801FB8
pool_03801FBC:
loc_03801FBC:
	.word REG_IPC_FIFO_TX	; 03801FBC

; ===== function loc_03801FC0 =====
loc_03801FC0:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P2_SetPxiReceiveCallback
	push {r4,r5,lr}	; 03801FC0
	sub sp,#0x4	; 03801FC2
	add r5,r0,#0x0	; 03801FC4
	add r4,r1,#0x0	; 03801FC6
	bl loc_037FDCE8	; 03801FC8
	lsl r2,r5,#0x2	; 03801FCC
	ldr r1,[pool_03802004]	; 03801FCE
	str r4,[r1,r2]	; 03801FD0
	cmp r4,#0x0	; 03801FD2
	beq loc_03801FE8	; 03801FD4
	ldr r2,[pool_03802008]	; 03801FD6
	ldr r1,[pool_0380200C]	; 03801FD8
	add r1,r2,r1	; 03801FDA
	ldr r3,[r1,#0x0]	; 03801FDC
	mov r2,#0x1	; 03801FDE
	lsl r2,r5	; 03801FE0
	orr r3,r2	; 03801FE2
	str r3,[r1,#0x0]	; 03801FE4
	b loc_03801FF8	; 03801FE6
loc_03801FE8:
	ldr r2,[pool_03802008]	; 03801FE8
	ldr r1,[pool_0380200C]	; 03801FEA
	add r1,r2,r1	; 03801FEC
	ldr r3,[r1,#0x0]	; 03801FEE
	mov r2,#0x1	; 03801FF0
	lsl r2,r5	; 03801FF2
	bic r3,r2	; 03801FF4
	str r3,[r1,#0x0]	; 03801FF6
loc_03801FF8:
	bl loc_037FDD0C	; 03801FF8
	add sp,#0x4	; 03801FFC
	pop {r4,r5}	; 03801FFE
	pop {r3}	; 03802000
	bx r3	; 03802002
.endfunc
pool_03802004:
loc_03802004:
	.word P2_PxiReceiveCallbacks	; 03802004
pool_03802008:
loc_03802008:
	.word FirmwareSystemWorkAddress	; 03802008
pool_0380200C:
loc_0380200C:
	.word SystemWorkPxiArm7AvailableOffset	; 0380200C

; ===== function loc_03802010 =====
loc_03802010:
	push {r4,r5,r6,r7,lr}	; 03802010
	sub sp,#0x4	; 03802012
	bl loc_037FDCE8	; 03802014
	add r5,r0,#0x0	; 03802018
	ldr r0,[pool_03802084]	; 0380201A
	ldrh r1,[r0,#0x0]	; 0380201C
	cmp r1,#0x0	; 0380201E
	bne loc_03802074	; 03802020
	mov r1,#0x1	; 03802022
	strh r1,[r0,#0x0]	; 03802024
	mov r3,#0x0	; 03802026
	ldr r1,[pool_03802088]	; 03802028
	ldr r0,[pool_0380208C]	; 0380202A
	str r3,[r1,r0]	; 0380202C
	add r2,r3,#0x0	; 0380202E
	ldr r0,[pool_03802090]	; 03802030
loc_03802032:
	lsl r1,r3,#0x2	; 03802032
	str r2,[r0,r1]	; 03802034
	add r3,r3,#0x1	; 03802036
	cmp r3,#PxiFifoChannelCount	; 03802038
	blt loc_03802032	; 0380203A
	ldr r0,[pool_03802094]	; 0380203C
	ldr r1,[pool_03802098]	; 0380203E
	bl loc_037FDB1C	; 03802040
	ldr r0,[pool_03802094]	; 03802044
	bl loc_037FDA98	; 03802046
	ldr r1,[pool_0380209C]	; 0380204A
	ldr r0,[pool_038020A0]	; 0380204C
	strh r1,[r0,#0x0]	; 0380204E
	mov r4,#0x8	; 03802050
	add r7,r4,#0x0	; 03802052
	ldr r6,[pool_038020A4]	; 03802054
	b loc_03802070	; 03802056
loc_03802058:
	lsl r0,r4,#0x8	; 03802058
	strh r0,[r6,#0x0]	; 0380205A
	ldr r0,[pool_038020A8]	; 0380205C
	bl loc_037FF1D0	; 0380205E
	ldrh r1,[r6,#0x0]	; 03802062
	mov r0,#0xf	; 03802064
	and r1,r0	; 03802066
	cmp r1,r4	; 03802068
	beq loc_0380206E	; 0380206A
	add r4,r7,#0x0	; 0380206C
loc_0380206E:
	sub r4,r4,#0x1	; 0380206E
loc_03802070:
	cmp r4,#0x0	; 03802070
	bge loc_03802058	; 03802072
loc_03802074:
	add r0,r5,#0x0	; 03802074
	bl loc_037FDD0C	; 03802076
	add sp,#0x4	; 0380207A
	pop {r4,r5,r6,r7}	; 0380207C
	pop {r3}	; 0380207E
	bx r3	; 03802080
	.byte 0xC0, 0x46	; 03802084
pool_03802084:
loc_03802084:
	.word P2_BssStart + 0x1D38	; 03802084
pool_03802088:
loc_03802088:
	.word FirmwareSystemWorkAddress	; 03802088
pool_0380208C:
loc_0380208C:
	.word SystemWorkPxiArm7AvailableOffset	; 0380208C
pool_03802090:
loc_03802090:
	.word P2_PxiReceiveCallbacks	; 03802090
pool_03802094:
loc_03802094:
	.word 0x00040000	; 03802094
pool_03802098:
loc_03802098:
	.word P2_IrqHandler_03801E60 + 1	; 03802098
pool_0380209C:
loc_0380209C:
	.word 0x0000C408	; 0380209C
pool_038020A0:
loc_038020A0:
	.word REG_IPC_FIFO_CR	; 038020A0
pool_038020A4:
loc_038020A4:
	.word REG_IPC_SYNC	; 038020A4
pool_038020A8:
loc_038020A8:
	.word 0x000003E8	; 038020A8
; 采样 X/Y、调试键与合盖输入；将合盖位转换为共享状态 bit15。
; Sample X/Y, debug and hinge inputs; publish the hinge bit as shared bit15.
.func P2_PublishExtendedKeyState
	push {r4,lr}	; 038020AC
	mov r4,#0x0	; 038020AE
	ldr r0,[pool_038020D8]	; 038020B0
	bl loc_0380214C	; 038020B2
	ldr r0,[pool_038020DC]	; 038020B6
	ldrh r2,[r0,#0x0]	; 038020B8
	mov r0,#KEYXY_LID_CLOSED	; 038020BA
	add r1,r2,#0x0	; 038020BC
	and r1,r0	; 038020BE
	cmp r1,#0x0	; 038020C0
	beq loc_038020C6	; 038020C2
	ldr r4,[pool_038020D8]	; 038020C4
loc_038020C6:
	mov r0,#0xb	; 038020C6
	and r2,r0	; 038020C8
	lsl r1,r2,#0xa	; 038020CA
	orr r1,r4	; 038020CC
	ldr r0,[pool_038020E0]	; 038020CE
	strh r1,[r0,#0x0]	; 038020D0
	pop {r4}	; 038020D2
	pop {r3}	; 038020D4
	bx r3	; 038020D6
.endfunc
pool_038020D8:
loc_038020D8:
; 此 0x8000 常量也传给 RCNT 模式设置；原代码共用同一槽。
; The same 0x8000 literal also selects RCNT GPIO mode in the original code.
	.word SystemWorkLidClosedMask	; 038020D8
pool_038020DC:
loc_038020DC:
	.word REG_KEYXY	; 038020DC
pool_038020E0:
loc_038020E0:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 038020E0

; ===== function loc_038020E4 =====
loc_038020E4:
	push {r4,r5,lr}	; 038020E4
	sub sp,#0xc	; 038020E6
	bl loc_037FE93C	; 038020E8
	cmp r0,#0x0	; 038020EC
	beq loc_038020F8	; 038020EE
	bl loc_037FEC44	; 038020F0
	cmp r0,#0x0	; 038020F4
	bne loc_038020FC	; 038020F6
loc_038020F8:
	mov r0,#0x0	; 038020F8
	b loc_03802134	; 038020FA
loc_038020FC:
	ldr r0,[pool_0380213C]	; 038020FC
	ldr r0,[r0,#0x0]	; 038020FE
	cmp r0,#0x0	; 03802100
	beq loc_03802108	; 03802102
	mov r0,#0x0	; 03802104
	b loc_03802134	; 03802106
loc_03802108:
	ldr r0,[pool_03802140]	; 03802108
	bl loc_037FEC3C	; 0380210A
	bl loc_037FE870	; 0380210E
	add r2,r0,#0x0	; 03802112
	ldr r0,[pool_03802144]	; 03802114
	str r0,[sp,#0x4]	; 03802116
	mov r5,#0x0	; 03802118
	str r5,[sp,#0x8]	; 0380211A
	ldr r3,[pool_03802148]	; 0380211C
	str r5,[sp,#0x0]	; 0380211E
	ldr r0,[pool_03802140]	; 03802120
	add r4,r2,r3	; 03802122
	lsl r2,r1,#0	; 03802124
	adc r2,r5	; 03802126
	add r1,r4,#0x0	; 03802128
	bl loc_037FEAC0	; 0380212A
	mov r0,#0x1	; 0380212E
	ldr r1,[pool_0380213C]	; 03802130
	str r0,[r1,#0x0]	; 03802132
loc_03802134:
	add sp,#0xc	; 03802134
	pop {r4,r5}	; 03802136
	pop {r3}	; 03802138
	bx r3	; 0380213A
pool_0380213C:
loc_0380213C:
	.word P2_BssStart + 0x1DBC	; 0380213C
pool_03802140:
loc_03802140:
	.word 0x03807160	; 03802140
pool_03802144:
loc_03802144:
	.word P2_PublishExtendedKeyState + 1	; 03802144
pool_03802148:
loc_03802148:
	.word 0x0000082E	; 03802148

; ===== function loc_0380214C =====
loc_0380214C:
	add r1,r0,#0x0	; 0380214C
	ldr r0,[pool_03802158]	; 0380214E
	lsl r1,r1,#0x10	; 03802150
	lsr r1,r1,#0x10	; 03802152
	ldr r3,[pool_0380215C]	; 03802154
	bx r3	; 03802156
pool_03802158:
loc_03802158:
	.word 0x0000C000	; 03802158
pool_0380215C:
loc_0380215C:
	.word loc_03802160 + 1	; 0380215C
loc_03802160:
	mvn r3,r0	; 03802160
	ldr r2,[pool_03802170]	; 03802162
	ldrh r0,[r2,#0x0]	; 03802164
	and r3,r0	; 03802166
	orr r1,r3	; 03802168
	strh r1,[r2,#0x0]	; 0380216A
	bx lr	; 0380216C
	.byte 0xC0, 0x46	; 03802170
pool_03802170:
loc_03802170:
	.word REG_RCNT_ARM7	; 03802170

; ===== function loc_03802174 =====
loc_03802174:
	push {lr}	; 03802174
	sub sp,#0x4	; 03802176
	add r0,sp,#0x0	; 03802178
	bl loc_038028F8	; 0380217A
	add r0,sp,#0x0	; 0380217E
	add r0,#0x2	; 03802180
	bl loc_038028B8	; 03802182
	add r0,sp,#0x0	; 03802186
	ldrh r1,[r0,#0x0]	; 03802188
	lsl r2,r1,#0x18	; 0380218A
	lsr r2,r2,#0x1f	; 0380218C
	cmp r2,#0x0	; 0380218E
	bne loc_038021A4	; 03802190
	lsl r1,r1,#0x19	; 03802192
	lsr r1,r1,#0x1f	; 03802194
	cmp r1,#0x0	; 03802196
	bne loc_038021A4	; 03802198
	ldrh r0,[r0,#0x2]	; 0380219A
	lsl r0,r0,#0x18	; 0380219C
	lsr r0,r0,#0x1f	; 0380219E
	cmp r0,#0x0	; 038021A0
	beq loc_038021B6	; 038021A2
loc_038021A4:
	add r1,sp,#0x0	; 038021A4
	ldrh r2,[r1,#0x0]	; 038021A6
	mov r0,#0x1	; 038021A8
	bic r2,r0	; 038021AA
	orr r2,r0	; 038021AC
	strh r2,[r1,#0x0]	; 038021AE
	add r0,sp,#0x0	; 038021B0
	bl loc_038028D8	; 038021B2
loc_038021B6:
	mov r0,#0x1	; 038021B6
	bl loc_03802A28	; 038021B8
	add sp,#0x4	; 038021BC
	pop {r3}	; 038021BE
	bx r3	; 038021C0
	.byte 0x00, 0x00	; 038021C4
	ldr r0,[pool_038021CC]	; 038021C4
	ldr r3,[pool_038021D0]	; 038021C6
	bx r3	; 038021C8
	.byte 0xC0, 0x46	; 038021CC
pool_038021CC:
loc_038021CC:
	.word 0x038073AC	; 038021CC
pool_038021D0:
loc_038021D0:
	.word loc_037FDF0C + 1	; 038021D0

; ===== function loc_038021D4 =====
P2_ThreadEntry_038021D4:
	push {r4,r5,r6,r7,lr}	; 038021D4
	sub sp,#0xc	; 038021D6
	add r4,sp,#0x0	; 038021D8
	ldrh r1,[r4,#0x2]	; 038021DA
	mov r0,#0x10	; 038021DC
	bic r1,r0	; 038021DE
	strh r1,[r4,#0x2]	; 038021E0
	ldrh r1,[r4,#0x2]	; 038021E2
	mov r0,#0x20	; 038021E4
	bic r1,r0	; 038021E6
	strh r1,[r4,#0x2]	; 038021E8
	ldr r6,[pool_03802268]	; 038021EA
	mov r7,#0xf	; 038021EC
loc_038021EE:
	ldr r0,[pool_0380226C]	; 038021EE
	bl loc_037FDF54	; 038021F0
	ldr r0,[r6,#0x1c]	; 038021F4
	cmp r0,#0x0	; 038021F6
	bne loc_038021EE	; 038021F8
	add r0,sp,#0x0	; 038021FA
	bl loc_038028F8	; 038021FC
	ldrh r1,[r4,#0x0]	; 03802200
	lsl r0,r1,#0x1b	; 03802202
	lsr r2,r0,#0x1f	; 03802204
	ldrh r0,[r4,#0x2]	; 03802206
	lsl r3,r0,#0x1b	; 03802208
	lsr r3,r3,#0x1f	; 0380220A
	sub r2,r2,r3	; 0380220C
	cmp r2,#0x1	; 0380220E
	beq loc_03802220	; 03802210
	lsl r1,r1,#0x1a	; 03802212
	lsr r1,r1,#0x1f	; 03802214
	lsl r0,r0,#0x1a	; 03802216
	lsr r0,r0,#0x1f	; 03802218
	sub r0,r1,r0	; 0380221A
	cmp r0,#0x1	; 0380221C
	bne loc_03802260	; 0380221E
loc_03802220:
	add r0,sp,#0x4	; 03802220
	bl loc_038028B8	; 03802222
	mov r5,#0x0	; 03802226
	ldrh r0,[r4,#0x0]	; 03802228
	lsl r0,r0,#0x1b	; 0380222A
	lsr r0,r0,#0x1f	; 0380222C
	cmp r0,#0x0	; 0380222E
	beq loc_0380223C	; 03802230
	mov r0,#0x1	; 03802232
	orr r5,r0	; 03802234
	ldrh r0,[r4,#0x4]	; 03802236
	bic r0,r7	; 03802238
	strh r0,[r4,#0x4]	; 0380223A
loc_0380223C:
	ldrh r0,[r4,#0x0]	; 0380223C
	lsl r0,r0,#0x1a	; 0380223E
	lsr r0,r0,#0x1f	; 03802240
	cmp r0,#0x0	; 03802242
	beq loc_03802252	; 03802244
	mov r0,#0x2	; 03802246
	orr r5,r0	; 03802248
	ldrh r1,[r4,#0x4]	; 0380224A
	mov r0,#0x40	; 0380224C
	bic r1,r0	; 0380224E
	strh r1,[r4,#0x4]	; 03802250
loc_03802252:
	add r0,sp,#0x4	; 03802252
	bl loc_03802898	; 03802254
	mov r0,#0x30	; 03802258
	add r1,r5,#0x0	; 0380225A
	bl loc_03802464	; 0380225C
loc_03802260:
	ldrh r0,[r4,#0x0]	; 03802260
	strh r0,[r4,#0x2]	; 03802262
	b loc_038021EE	; 03802264
	.byte 0xC0, 0x46	; 03802268
pool_03802268:
loc_03802268:
	.word 0x03807310	; 03802268
pool_0380226C:
loc_0380226C:
	.word 0x038073AC	; 0380226C

; ===== function loc_03802270 =====
P2_ThreadEntry_03802270:
	push {r4,r5,r6,r7,lr}	; 03802270
	sub sp,#0x4	; 03802272
	ldr r5,[pool_03802458]	; 03802274
	add r6,r5,#0x4	; 03802276
	mov r7,#0x0	; 03802278
	ldr r4,[pool_0380245C]	; 0380227A
loc_0380227C:
	ldr r0,[pool_03802460]	; 0380227C
	add r1,sp,#0x0	; 0380227E
	mov r2,#0x1	; 03802280
	bl loc_037FE290	; 03802282
	ldrh r0,[r4,#0x20]	; 03802286
	cmp r0,#0x10	; 03802288
	bgt loc_038022A6	; 0380228A
	cmp r0,#0x10	; 0380228C
	bge loc_03802310	; 0380228E
	cmp r0,#0x1	; 03802290
	ble loc_03802296	; 03802292
	b loc_0380244C	; 03802294
loc_03802296:
	cmp r0,#0x0	; 03802296
	bge loc_0380229C	; 03802298
	b loc_0380244C	; 0380229A
loc_0380229C:
	cmp r0,#0x0	; 0380229C
	beq loc_038022EA	; 0380229E
	cmp r0,#0x1	; 038022A0
	beq loc_038022FA	; 038022A2
	b loc_0380244C	; 038022A4
loc_038022A6:
	add r1,r0,#0x0	; 038022A6
	sub r1,#0x14	; 038022A8
	cmp r1,#0x15	; 038022AA
	bls loc_038022B0	; 038022AC
	b loc_0380244C	; 038022AE
loc_038022B0:
	add r1,r1,r1	; 038022B0
P2_SwitchIndexPC_038022B0:
	add r1,pc	; 038022B2
	ldrh r1,[r1,#(P2_SwitchTable_038022B0 - (P2_SwitchIndexPC_038022B0 + 4))]	; 038022B4
	lsl r1,r1,#0x10	; 038022B6
	asr r1,r1,#0x10	; 038022B8
P2_SwitchTargetPC_038022B0:
	add r1,pc	; 038022BA
	bx r1	; 038022BC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038022B0:
	.halfword (loc_03802322 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_03802344 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_03802366 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_03802378 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380238A + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380239C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_038023AE + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380244C + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_038023C0 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_038023E2 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_03802404 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_03802416 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_03802428 + 1) - (P2_SwitchTargetPC_038022B0 + 4)
	.halfword (loc_0380243A + 1) - (P2_SwitchTargetPC_038022B0 + 4)
P2_SwitchTable_038022B0End:
loc_038022EA:
	bl loc_03802AD0	; 038022EA
	str r7,[r4,#0x1c]	; 038022EE
	add r0,r7,#0x0	; 038022F0
	add r1,r7,#0x0	; 038022F2
	bl loc_03802464	; 038022F4
	b loc_0380227C	; 038022F8
loc_038022FA:
	ldrh r0,[r5,#0x0]	; 038022FA
	lsl r0,r0,#0x1e	; 038022FC
	lsr r0,r0,#0x1f	; 038022FE
	bl loc_03802A28	; 03802300
	str r7,[r4,#0x1c]	; 03802304
	mov r0,#0x1	; 03802306
	add r1,r7,#0x0	; 03802308
	bl loc_03802464	; 0380230A
	b loc_0380227C	; 0380230E
loc_03802310:
	add r0,r5,#0x0	; 03802310
	bl loc_03802A08	; 03802312
	str r7,[r4,#0x1c]	; 03802316
	mov r0,#0x10	; 03802318
	add r1,r7,#0x0	; 0380231A
	bl loc_03802464	; 0380231C
	b loc_0380227C	; 03802320
loc_03802322:
	add r0,r5,#0x4	; 03802322
	bl loc_038029B4	; 03802324
	cmp r0,#0x0	; 03802328
	bne loc_03802338	; 0380232A
	str r7,[r4,#0x1c]	; 0380232C
	mov r0,#0x14	; 0380232E
	mov r1,#0x2	; 03802330
	bl loc_03802464	; 03802332
	b loc_0380227C	; 03802336
loc_03802338:
	str r7,[r4,#0x1c]	; 03802338
	mov r0,#0x14	; 0380233A
	add r1,r7,#0x0	; 0380233C
	bl loc_03802464	; 0380233E
	b loc_0380227C	; 03802342
loc_03802344:
	add r0,r6,#0x0	; 03802344
	bl loc_0380294C	; 03802346
	cmp r0,#0x0	; 0380234A
	bne loc_0380235A	; 0380234C
	str r7,[r4,#0x1c]	; 0380234E
	mov r0,#0x15	; 03802350
	mov r1,#0x2	; 03802352
	bl loc_03802464	; 03802354
	b loc_0380227C	; 03802358
loc_0380235A:
	str r7,[r4,#0x1c]	; 0380235A
	mov r0,#0x15	; 0380235C
	add r1,r7,#0x0	; 0380235E
	bl loc_03802464	; 03802360
	b loc_0380227C	; 03802364
loc_03802366:
	add r0,r5,#0x0	; 03802366
	bl loc_038028F8	; 03802368
	str r7,[r4,#0x1c]	; 0380236C
	mov r0,#0x16	; 0380236E
	add r1,r7,#0x0	; 03802370
	bl loc_03802464	; 03802372
	b loc_0380227C	; 03802376
loc_03802378:
	add r0,r5,#0x2	; 03802378
	bl loc_038028B8	; 0380237A
	str r7,[r4,#0x1c]	; 0380237E
	mov r0,#0x17	; 03802380
	add r1,r7,#0x0	; 03802382
	bl loc_03802464	; 03802384
	b loc_0380227C	; 03802388
loc_0380238A:
	add r0,r5,#0x4	; 0380238A
	bl loc_03802878	; 0380238C
	str r7,[r4,#0x1c]	; 03802390
	mov r0,#0x18	; 03802392
	add r1,r7,#0x0	; 03802394
	bl loc_03802464	; 03802396
	b loc_0380227C	; 0380239A
loc_0380239C:
	add r0,r5,#0x4	; 0380239C
	bl loc_03802838	; 0380239E
	str r7,[r4,#0x1c]	; 038023A2
	mov r0,#0x19	; 038023A4
	add r1,r7,#0x0	; 038023A6
	bl loc_03802464	; 038023A8
	b loc_0380227C	; 038023AC
loc_038023AE:
	add r0,r5,#0x0	; 038023AE
	bl loc_038029E8	; 038023B0
	str r7,[r4,#0x1c]	; 038023B4
	mov r0,#0x20	; 038023B6
	add r1,r7,#0x0	; 038023B8
	bl loc_03802464	; 038023BA
	b loc_0380227C	; 038023BE
loc_038023C0:
	add r0,r6,#0x0	; 038023C0
	bl loc_03802980	; 038023C2
	cmp r0,#0x0	; 038023C6
	bne loc_038023D6	; 038023C8
	str r7,[r4,#0x1c]	; 038023CA
	mov r0,#0x24	; 038023CC
	mov r1,#0x2	; 038023CE
	bl loc_03802464	; 038023D0
	b loc_0380227C	; 038023D4
loc_038023D6:
	str r7,[r4,#0x1c]	; 038023D6
	mov r0,#0x24	; 038023D8
	add r1,r7,#0x0	; 038023DA
	bl loc_03802464	; 038023DC
	b loc_0380227C	; 038023E0
loc_038023E2:
	add r0,r6,#0x0	; 038023E2
	bl loc_03802918	; 038023E4
	cmp r0,#0x0	; 038023E8
	bne loc_038023F8	; 038023EA
	str r7,[r4,#0x1c]	; 038023EC
	mov r0,#0x25	; 038023EE
	mov r1,#0x2	; 038023F0
	bl loc_03802464	; 038023F2
	b loc_0380227C	; 038023F6
loc_038023F8:
	str r7,[r4,#0x1c]	; 038023F8
	mov r0,#0x25	; 038023FA
	add r1,r7,#0x0	; 038023FC
	bl loc_03802464	; 038023FE
	b loc_0380227C	; 03802402
loc_03802404:
	add r0,r5,#0x0	; 03802404
	bl loc_038028D8	; 03802406
	str r7,[r4,#0x1c]	; 0380240A
	mov r0,#0x26	; 0380240C
	add r1,r7,#0x0	; 0380240E
	bl loc_03802464	; 03802410
	b loc_0380227C	; 03802414
loc_03802416:
	add r0,r5,#0x2	; 03802416
	bl loc_03802898	; 03802418
	str r7,[r4,#0x1c]	; 0380241C
	mov r0,#0x27	; 0380241E
	add r1,r7,#0x0	; 03802420
	bl loc_03802464	; 03802422
	b loc_0380227C	; 03802426
loc_03802428:
	add r0,r5,#0x4	; 03802428
	bl loc_03802858	; 0380242A
	str r7,[r4,#0x1c]	; 0380242E
	mov r0,#0x28	; 03802430
	add r1,r7,#0x0	; 03802432
	bl loc_03802464	; 03802434
	b loc_0380227C	; 03802438
loc_0380243A:
	add r0,r5,#0x4	; 0380243A
	bl loc_03802818	; 0380243C
	str r7,[r4,#0x1c]	; 03802440
	mov r0,#0x29	; 03802442
	add r1,r7,#0x0	; 03802444
	bl loc_03802464	; 03802446
	b loc_0380227C	; 0380244A
loc_0380244C:
	str r7,[r4,#0x1c]	; 0380244C
	mov r1,#0x1	; 0380244E
	bl loc_03802464	; 03802450
	b loc_0380227C	; 03802454
	.byte 0xC0, 0x46	; 03802458
pool_03802458:
loc_03802458:
	.word 0x027FFDE8	; 03802458
pool_0380245C:
loc_0380245C:
	.word 0x03807310	; 0380245C
pool_03802460:
loc_03802460:
	.word 0x03807190	; 03802460

; ===== function loc_03802464 =====
loc_03802464:
	add r2,r0,#0x0	; 03802464
	mov r0,#0x5	; 03802466
	lsl r3,r2,#0x8	; 03802468
	ldr r2,[pool_03802480]	; 0380246A
	and r3,r2	; 0380246C
	ldr r2,[pool_03802484]	; 0380246E
	orr r3,r2	; 03802470
	mov r2,#0xff	; 03802472
	and r1,r2	; 03802474
	orr r3,r1	; 03802476
	add r1,r3,#0x0	; 03802478
	mov r2,#0x0	; 0380247A
	ldr r3,[pool_03802488]	; 0380247C
	bx r3	; 0380247E
pool_03802480:
loc_03802480:
	.word 0x00007F00	; 03802480
pool_03802484:
loc_03802484:
	.word 0x00008000	; 03802484
pool_03802488:
loc_03802488:
	.word loc_03801F38 + 1	; 03802488
P2_PxiCallback_0380248C:
	push {r4,lr}	; 0380248C
	cmp r2,#0x0	; 0380248E
	bne loc_0380252E	; 03802490
	ldr r0,[pool_03802534]	; 03802492
	and r1,r0	; 03802494
	lsl r0,r1,#0x8	; 03802496
	lsr r4,r0,#0x10	; 03802498
	cmp r4,#0x10	; 0380249A
	bgt loc_038024B4	; 0380249C
	cmp r4,#0x10	; 0380249E
	bge loc_038024F6	; 038024A0
	cmp r4,#0x1	; 038024A2
	bgt loc_03802526	; 038024A4
	cmp r4,#0x0	; 038024A6
	blt loc_03802526	; 038024A8
	cmp r4,#0x0	; 038024AA
	beq loc_038024F6	; 038024AC
	cmp r4,#0x1	; 038024AE
	beq loc_038024F6	; 038024B0
	b loc_03802526	; 038024B2
loc_038024B4:
	add r0,r4,#0x0	; 038024B4
	sub r0,#0x14	; 038024B6
	cmp r0,#0x15	; 038024B8
	bhi loc_03802526	; 038024BA
	add r0,r0,r0	; 038024BC
P2_SwitchIndexPC_038024BC:
	add r0,pc	; 038024BE
	ldrh r0,[r0,#(P2_SwitchTable_038024BC - (P2_SwitchIndexPC_038024BC + 4))]	; 038024C0
	lsl r0,r0,#0x10	; 038024C2
	asr r0,r0,#0x10	; 038024C4
P2_SwitchTargetPC_038024BC:
	add r0,pc	; 038024C6
	bx r0	; 038024C8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038024BC:
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_03802526 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
	.halfword (loc_038024F6 + 1) - (P2_SwitchTargetPC_038024BC + 4)
P2_SwitchTable_038024BCEnd:
loc_038024F6:
	ldr r0,[pool_03802538]	; 038024F6
	ldr r1,[r0,#0x1c]	; 038024F8
	cmp r1,#0x0	; 038024FA
	beq loc_03802508	; 038024FC
	add r0,r4,#0x0	; 038024FE
	mov r1,#0x3	; 03802500
	bl loc_03802464	; 03802502
	b loc_0380252E	; 03802506
loc_03802508:
	mov r1,#0x1	; 03802508
	str r1,[r0,#0x1c]	; 0380250A
	strh r4,[r0,#0x20]	; 0380250C
	ldr r0,[pool_0380253C]	; 0380250E
	mov r1,#0x0	; 03802510
	add r2,r1,#0x0	; 03802512
	bl loc_037FE308	; 03802514
	cmp r0,#0x0	; 03802518
	bne loc_0380252E	; 0380251A
	add r0,r4,#0x0	; 0380251C
	mov r1,#0x4	; 0380251E
	bl loc_03802464	; 03802520
	b loc_0380252E	; 03802524
loc_03802526:
	add r0,r4,#0x0	; 03802526
	mov r1,#0x1	; 03802528
	bl loc_03802464	; 0380252A
loc_0380252E:
	pop {r4}	; 0380252E
	pop {r3}	; 03802530
	bx r3	; 03802532
pool_03802534:
loc_03802534:
	.word 0x00007F00	; 03802534
pool_03802538:
loc_03802538:
	.word P2_BssStart + 0x1F70	; 03802538
pool_0380253C:
loc_0380253C:
	.word 0x03807190	; 0380253C

; ===== function loc_03802540 =====
loc_03802540:
	push {r4,lr}	; 03802540
	sub sp,#0x10	; 03802542
	add r4,r0,#0x0	; 03802544
	mov r1,#0x1	; 03802546
	ldr r0,[pool_038025DC]	; 03802548
	strh r1,[r0,#0x0]	; 0380254A
	ldr r0,[pool_038025E0]	; 0380254C
	str r1,[r0,#0x1c]	; 0380254E
	bl loc_03802174	; 03802550
	mov r1,#0x0	; 03802554
	ldr r0,[pool_038025E0]	; 03802556
	str r1,[r0,#0x1c]	; 03802558
	bl loc_03801E58	; 0380255A
	mov r0,#0x5	; 0380255E
	ldr r1,[pool_038025E4]	; 03802560
	bl P2_SetPxiReceiveCallback	; 03802562
	ldr r0,[pool_038025E8]	; 03802566
	ldr r1,[pool_038025EC]	; 03802568
	mov r2,#0x4	; 0380256A
	bl loc_037FE364	; 0380256C
	ldr r0,[pool_038025F0]	; 03802570
	str r0,[sp,#0x0]	; 03802572
	str r4,[sp,#0x4]	; 03802574
	ldr r0,[pool_038025F4]	; 03802576
	ldr r1,[pool_038025F8]	; 03802578
	mov r2,#0x0	; 0380257A
	ldr r3,[pool_038025FC]	; 0380257C
	bl P2_CreateThread	; 0380257E
	ldr r0,[pool_038025F4]	; 03802582
	bl loc_037FDEE8	; 03802584
	mov r2,#0x0	; 03802588
	ldr r0,[pool_03802600]	; 0380258A
	strh r2,[r0,#0x1c]	; 0380258C
	ldr r0,[pool_038025F0]	; 0380258E
	str r0,[sp,#0x0]	; 03802590
	sub r0,r4,#0x1	; 03802592
	str r0,[sp,#0x4]	; 03802594
	ldr r0,[pool_03802604]	; 03802596
	ldr r1,[pool_03802608]	; 03802598
	ldr r3,[pool_0380260C]	; 0380259A
	bl P2_CreateThread	; 0380259C
	ldr r0,[pool_03802604]	; 038025A0
	bl loc_037FDEE8	; 038025A2
	bl loc_037FEC44	; 038025A6
	cmp r0,#0x0	; 038025AA
	bne loc_038025B2	; 038025AC
	bl loc_037FEC50	; 038025AE
loc_038025B2:
	ldr r0,[pool_0380260C]	; 038025B2
	bl loc_037FEC3C	; 038025B4
	bl loc_037FE870	; 038025B8
	add r4,r0,#0x0	; 038025BC
	add r2,r1,#0x0	; 038025BE
	ldr r0,[pool_03802610]	; 038025C0
	str r0,[sp,#0x4]	; 038025C2
	mov r0,#0x0	; 038025C4
	str r0,[sp,#0x8]	; 038025C6
	ldr r3,[pool_03802614]	; 038025C8
	str r0,[sp,#0x0]	; 038025CA
	ldr r0,[pool_0380260C]	; 038025CC
	add r1,r4,#0x0	; 038025CE
	bl loc_037FEAC0	; 038025D0
	add sp,#0x10	; 038025D4
	pop {r4}	; 038025D6
	pop {r3}	; 038025D8
	bx r3	; 038025DA
pool_038025DC:
loc_038025DC:
	.word P2_BssStart + 0x1DEC	; 038025DC
pool_038025E0:
loc_038025E0:
	.word P2_BssStart + 0x1F70	; 038025E0
pool_038025E4:
loc_038025E4:
	.word P2_PxiCallback_0380248C + 1	; 038025E4
pool_038025E8:
loc_038025E8:
	.word 0x03807190	; 038025E8
pool_038025EC:
loc_038025EC:
	.word 0x038071A4	; 038025EC
pool_038025F0:
loc_038025F0:
	.word 0x00000100	; 038025F0
pool_038025F4:
loc_038025F4:
	.word 0x038071B4	; 038025F4
pool_038025F8:
loc_038025F8:
	.word P2_ThreadEntry_03802270 + 1	; 038025F8
pool_038025FC:
loc_038025FC:
	.word 0x0380732C	; 038025FC
pool_03802600:
loc_03802600:
	.word P2_BssStart + 0x1FF0	; 03802600
pool_03802604:
loc_03802604:
	.word 0x03807334	; 03802604
pool_03802608:
loc_03802608:
	.word P2_ThreadEntry_038021D4 + 1	; 03802608
pool_0380260C:
loc_0380260C:
	.word 0x038074B0	; 0380260C
pool_03802610:
loc_03802610:
	.word 0x038021C5	; 03802610
pool_03802614:
loc_03802614:
	.word 0x00001388	; 03802614

; ===== function loc_03802618 =====
loc_03802618:
	push {r4,r5,r6,r7,lr}	; 03802618
	sub sp,#0x4	; 0380261A
	add r5,r0,#0x0	; 0380261C
	add r7,r1,#0x0	; 0380261E
	add r4,r2,#0x0	; 03802620
	add r6,r3,#0x0	; 03802622
	bl loc_03802658	; 03802624
	add r0,r5,#0x0	; 03802628
	add r1,r7,#0x0	; 0380262A
	bl loc_03802664	; 0380262C
	cmp r5,#0x6	; 03802630
	beq loc_03802642	; 03802632
	cmp r5,#0x86	; 03802634
	bne loc_0380264A	; 03802636
	add r0,r4,#0x0	; 03802638
	add r1,r6,#0x0	; 0380263A
	bl loc_03802670	; 0380263C
	b loc_0380264A	; 03802640
loc_03802642:
	add r0,r4,#0x0	; 03802642
	add r1,r6,#0x0	; 03802644
	bl loc_0380267C	; 03802646
loc_0380264A:
	bl loc_03802688	; 0380264A
	add sp,#0x4	; 0380264E
	pop {r4,r5,r6,r7}	; 03802650
	pop {r3}	; 03802652
	bx r3	; 03802654
	.byte 0xC0, 0x46	; 03802658

; ===== function loc_03802658 =====
loc_03802658:
	bx pc	; 03802658
	.byte 0xC0, 0x46	; 0380265C
.arm

; ===== function loc_0380265C =====
loc_0380265C:
	ldr pc,[pool_03802660]	; 0380265C
pool_03802660:
loc_03802660:
	.word loc_03802AFC	; 03802660
.thumb

; ===== function loc_03802664 =====
loc_03802664:
	bx pc	; 03802664
	.byte 0xC0, 0x46	; 03802668
.arm

; ===== function loc_03802668 =====
loc_03802668:
	ldr pc,[pool_0380266C]	; 03802668
pool_0380266C:
loc_0380266C:
	.word loc_03802B70	; 0380266C
.thumb

; ===== function loc_03802670 =====
loc_03802670:
	bx pc	; 03802670
	.byte 0xC0, 0x46	; 03802674
.arm

; ===== function loc_03802674 =====
loc_03802674:
	ldr pc,[pool_03802678]	; 03802674
pool_03802678:
loc_03802678:
	.word loc_03802C70	; 03802678
.thumb

; ===== function loc_0380267C =====
loc_0380267C:
	bx pc	; 0380267C
	.byte 0xC0, 0x46	; 03802680
.arm

; ===== function loc_03802680 =====
loc_03802680:
	ldr pc,[pool_03802684]	; 03802680
pool_03802684:
loc_03802684:
	.word loc_03802BE0	; 03802684
.thumb

; ===== function loc_03802688 =====
loc_03802688:
	bx pc	; 03802688
	.byte 0xC0, 0x46	; 0380268C
.arm

; ===== function loc_0380268C =====
loc_0380268C:
	ldr pc,[pool_03802690]	; 0380268C
pool_03802690:
loc_03802690:
	.word loc_03802B3C	; 03802690
.thumb

; ===== function loc_03802694 =====
loc_03802694:
	ldr r1,[r0,#0x0]	; 03802694
	lsl r2,r1,#0x12	; 03802696
	lsr r2,r2,#0x1a	; 03802698
	cmp r2,#0x23	; 0380269A
	bhi loc_03802730	; 0380269C
	add r3,r2,r2	; 0380269E
P2_SwitchIndexPC_0380269E:
	add r3,pc	; 038026A0
	ldrh r3,[r3,#(P2_SwitchTable_0380269E - (P2_SwitchIndexPC_0380269E + 4))]	; 038026A2
	lsl r3,r3,#0x10	; 038026A4
	asr r3,r3,#0x10	; 038026A6
P2_SwitchTargetPC_0380269E:
	add r3,pc	; 038026A8
	bx r3	; 038026AA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380269E:
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_0380270E + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_0380270E + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_038026F4 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802730 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
	.halfword (loc_03802728 + 1) - (P2_SwitchTargetPC_0380269E + 4)
P2_SwitchTable_0380269EEnd:
loc_038026F4:
	lsl r3,r1,#0x11	; 038026F4
	lsr r3,r3,#0x1f	; 038026F6
	cmp r3,#0x0	; 038026F8
	beq loc_03802740	; 038026FA
	ldr r3,[pool_03802744]	; 038026FC
	and r1,r3	; 038026FE
	add r2,#0x12	; 03802700
	mov r3,#0x3f	; 03802702
	and r2,r3	; 03802704
	lsl r2,r2,#0x8	; 03802706
	orr r1,r2	; 03802708
	str r1,[r0,#0x0]	; 0380270A
	bx lr	; 0380270C
loc_0380270E:
	lsl r3,r1,#0x11	; 0380270E
	lsr r3,r3,#0x1f	; 03802710
	cmp r3,#0x0	; 03802712
	beq loc_03802740	; 03802714
	ldr r3,[pool_03802744]	; 03802716
	and r1,r3	; 03802718
	add r2,#0x18	; 0380271A
	mov r3,#0x3f	; 0380271C
	and r2,r3	; 0380271E
	lsl r2,r2,#0x8	; 03802720
	orr r1,r2	; 03802722
	str r1,[r0,#0x0]	; 03802724
	bx lr	; 03802726
loc_03802728:
	ldr r2,[pool_03802748]	; 03802728
	orr r1,r2	; 0380272A
	str r1,[r0,#0x0]	; 0380272C
	bx lr	; 0380272E
loc_03802730:
	ldr r2,[r0,#0x0]	; 03802730
	ldr r1,[pool_0380274C]	; 03802732
	and r2,r1	; 03802734
	str r2,[r0,#0x0]	; 03802736
	ldr r2,[r0,#0x0]	; 03802738
	ldr r1,[pool_03802744]	; 0380273A
	and r2,r1	; 0380273C
	str r2,[r0,#0x0]	; 0380273E
loc_03802740:
	bx lr	; 03802740
	.byte 0xC0, 0x46	; 03802744
pool_03802744:
loc_03802744:
	.word 0xFFFFC0FF	; 03802744
pool_03802748:
loc_03802748:
	.word 0x00004000	; 03802748
pool_0380274C:
loc_0380274C:
	.word 0xFFFFBFFF	; 0380274C

; ===== function loc_03802750 =====
loc_03802750:
	ldr r1,[r0,#0x0]	; 03802750
	lsl r2,r1,#0x12	; 03802752
	lsr r2,r2,#0x1a	; 03802754
	cmp r2,#0x23	; 03802756
	bhi loc_038027F8	; 03802758
	add r2,r2,r2	; 0380275A
P2_SwitchIndexPC_0380275A:
	add r2,pc	; 0380275C
	ldrh r2,[r2,#(P2_SwitchTable_0380275A - (P2_SwitchIndexPC_0380275A + 4))]	; 0380275E
	lsl r2,r2,#0x10	; 03802760
	asr r2,r2,#0x10	; 03802762
P2_SwitchTargetPC_0380275A:
	add r2,pc	; 03802764
	bx r2	; 03802766
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380275A:
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B0 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027F8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027D8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027D8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
	.halfword (loc_038027B8 + 1) - (P2_SwitchTargetPC_0380275A + 4)
P2_SwitchTable_0380275AEnd:
loc_038027B0:
	ldr r2,[pool_0380280C]	; 038027B0
	and r1,r2	; 038027B2
	str r1,[r0,#0x0]	; 038027B4
	bx lr	; 038027B6
loc_038027B8:
	ldr r2,[pool_03802810]	; 038027B8
	orr r1,r2	; 038027BA
	str r1,[r0,#0x0]	; 038027BC
	ldr r2,[r0,#0x0]	; 038027BE
	ldr r1,[pool_03802814]	; 038027C0
	add r3,r2,#0x0	; 038027C2
	and r3,r1	; 038027C4
	lsl r1,r2,#0x12	; 038027C6
	lsr r2,r1,#0x1a	; 038027C8
	sub r2,#0x12	; 038027CA
	mov r1,#0x3f	; 038027CC
	and r2,r1	; 038027CE
	lsl r1,r2,#0x8	; 038027D0
	orr r3,r1	; 038027D2
	str r3,[r0,#0x0]	; 038027D4
	bx lr	; 038027D6
loc_038027D8:
	ldr r2,[pool_03802810]	; 038027D8
	orr r1,r2	; 038027DA
	str r1,[r0,#0x0]	; 038027DC
	ldr r2,[r0,#0x0]	; 038027DE
	ldr r1,[pool_03802814]	; 038027E0
	add r3,r2,#0x0	; 038027E2
	and r3,r1	; 038027E4
	lsl r1,r2,#0x12	; 038027E6
	lsr r2,r1,#0x1a	; 038027E8
	sub r2,#0x18	; 038027EA
	mov r1,#0x3f	; 038027EC
	and r2,r1	; 038027EE
	lsl r1,r2,#0x8	; 038027F0
	orr r3,r1	; 038027F2
	str r3,[r0,#0x0]	; 038027F4
	bx lr	; 038027F6
loc_038027F8:
	ldr r2,[r0,#0x0]	; 038027F8
	ldr r1,[pool_0380280C]	; 038027FA
	and r2,r1	; 038027FC
	str r2,[r0,#0x0]	; 038027FE
	ldr r2,[r0,#0x0]	; 03802800
	ldr r1,[pool_03802814]	; 03802802
	and r2,r1	; 03802804
	str r2,[r0,#0x0]	; 03802806
	bx lr	; 03802808
	.byte 0xC0, 0x46	; 0380280C
pool_0380280C:
loc_0380280C:
	.word 0xFFFFBFFF	; 0380280C
pool_03802810:
loc_03802810:
	.word 0x00004000	; 03802810
pool_03802814:
loc_03802814:
	.word 0xFFFFC0FF	; 03802814

; ===== function loc_03802818 =====
loc_03802818:
	push {r4,lr}	; 03802818
	add r4,r0,#0x0	; 0380281A
	ldr r0,[pool_03802834]	; 0380281C
	bl loc_0380214C	; 0380281E
	mov r0,#0x6	; 03802822
	mov r1,#0x70	; 03802824
	add r2,r4,#0x0	; 03802826
	mov r3,#0x1	; 03802828
	bl loc_03802618	; 0380282A
	pop {r4}	; 0380282E
	pop {r3}	; 03802830
	bx r3	; 03802832
pool_03802834:
loc_03802834:
	.word 0x00008000	; 03802834

; ===== function loc_03802838 =====
loc_03802838:
	push {r4,lr}	; 03802838
	add r4,r0,#0x0	; 0380283A
	ldr r0,[pool_03802854]	; 0380283C
	bl loc_0380214C	; 0380283E
	mov r0,#0x86	; 03802842
	mov r1,#0x70	; 03802844
	add r2,r4,#0x0	; 03802846
	mov r3,#0x1	; 03802848
	bl loc_03802618	; 0380284A
	pop {r4}	; 0380284E
	pop {r3}	; 03802850
	bx r3	; 03802852
pool_03802854:
loc_03802854:
	.word 0x00008000	; 03802854

; ===== function loc_03802858 =====
loc_03802858:
	push {r4,lr}	; 03802858
	add r4,r0,#0x0	; 0380285A
	ldr r0,[pool_03802874]	; 0380285C
	bl loc_0380214C	; 0380285E
	mov r0,#0x6	; 03802862
	mov r1,#0x30	; 03802864
	add r2,r4,#0x0	; 03802866
	mov r3,#0x1	; 03802868
	bl loc_03802618	; 0380286A
	pop {r4}	; 0380286E
	pop {r3}	; 03802870
	bx r3	; 03802872
pool_03802874:
loc_03802874:
	.word 0x00008000	; 03802874

; ===== function loc_03802878 =====
loc_03802878:
	push {r4,lr}	; 03802878
	add r4,r0,#0x0	; 0380287A
	ldr r0,[pool_03802894]	; 0380287C
	bl loc_0380214C	; 0380287E
	mov r0,#0x86	; 03802882
	mov r1,#0x30	; 03802884
	add r2,r4,#0x0	; 03802886
	mov r3,#0x1	; 03802888
	bl loc_03802618	; 0380288A
	pop {r4}	; 0380288E
	pop {r3}	; 03802890
	bx r3	; 03802892
pool_03802894:
loc_03802894:
	.word 0x00008000	; 03802894

; ===== function loc_03802898 =====
loc_03802898:
	push {r4,lr}	; 03802898
	add r4,r0,#0x0	; 0380289A
	ldr r0,[pool_038028B4]	; 0380289C
	bl loc_0380214C	; 0380289E
	mov r0,#0x6	; 038028A2
	mov r1,#0x40	; 038028A4
	add r2,r4,#0x0	; 038028A6
	mov r3,#0x1	; 038028A8
	bl loc_03802618	; 038028AA
	pop {r4}	; 038028AE
	pop {r3}	; 038028B0
	bx r3	; 038028B2
pool_038028B4:
loc_038028B4:
	.word 0x00008000	; 038028B4

; ===== function loc_038028B8 =====
loc_038028B8:
	push {r4,lr}	; 038028B8
	add r4,r0,#0x0	; 038028BA
	ldr r0,[pool_038028D4]	; 038028BC
	bl loc_0380214C	; 038028BE
	mov r0,#0x86	; 038028C2
	mov r1,#0x40	; 038028C4
	add r2,r4,#0x0	; 038028C6
	mov r3,#0x1	; 038028C8
	bl loc_03802618	; 038028CA
	pop {r4}	; 038028CE
	pop {r3}	; 038028D0
	bx r3	; 038028D2
pool_038028D4:
loc_038028D4:
	.word 0x00008000	; 038028D4

; ===== function loc_038028D8 =====
loc_038028D8:
	push {r4,lr}	; 038028D8
	add r4,r0,#0x0	; 038028DA
	ldr r0,[pool_038028F4]	; 038028DC
	bl loc_0380214C	; 038028DE
	mov r0,#0x6	; 038028E2
	mov r1,#0x0	; 038028E4
	add r2,r4,#0x0	; 038028E6
	mov r3,#0x1	; 038028E8
	bl loc_03802618	; 038028EA
	pop {r4}	; 038028EE
	pop {r3}	; 038028F0
	bx r3	; 038028F2
pool_038028F4:
loc_038028F4:
	.word 0x00008000	; 038028F4

; ===== function loc_038028F8 =====
loc_038028F8:
	push {r4,lr}	; 038028F8
	add r4,r0,#0x0	; 038028FA
	ldr r0,[pool_03802914]	; 038028FC
	bl loc_0380214C	; 038028FE
	mov r0,#0x86	; 03802902
	mov r1,#0x0	; 03802904
	add r2,r4,#0x0	; 03802906
	mov r3,#0x1	; 03802908
	bl loc_03802618	; 0380290A
	pop {r4}	; 0380290E
	pop {r3}	; 03802910
	bx r3	; 03802912
pool_03802914:
loc_03802914:
	.word 0x00008000	; 03802914

; ===== function loc_03802918 =====
loc_03802918:
	push {r4,lr}	; 03802918
	sub sp,#0x8	; 0380291A
	add r4,r0,#0x0	; 0380291C
	add r0,sp,#0x0	; 0380291E
	bl loc_038028B8	; 03802920
	add r0,sp,#0x0	; 03802924
	ldrh r0,[r0,#0x0]	; 03802926
	lsl r0,r0,#0x19	; 03802928
	lsr r0,r0,#0x1f	; 0380292A
	cmp r0,#0x0	; 0380292C
	beq loc_03802940	; 0380292E
	mov r0,#0x6	; 03802930
	mov r1,#0x50	; 03802932
	add r2,r4,#0x0	; 03802934
	mov r3,#0x3	; 03802936
	bl loc_03802618	; 03802938
	mov r0,#0x1	; 0380293C
	b loc_03802942	; 0380293E
loc_03802940:
	mov r0,#0x0	; 03802940
loc_03802942:
	add sp,#0x8	; 03802942
	pop {r4}	; 03802944
	pop {r3}	; 03802946
	bx r3	; 03802948
	.byte 0x00, 0x00	; 0380294C

; ===== function loc_0380294C =====
loc_0380294C:
	push {r4,lr}	; 0380294C
	sub sp,#0x8	; 0380294E
	add r4,r0,#0x0	; 03802950
	add r0,sp,#0x0	; 03802952
	bl loc_038028B8	; 03802954
	add r0,sp,#0x0	; 03802958
	ldrh r0,[r0,#0x0]	; 0380295A
	lsl r0,r0,#0x19	; 0380295C
	lsr r0,r0,#0x1f	; 0380295E
	cmp r0,#0x0	; 03802960
	beq loc_03802974	; 03802962
	mov r0,#0x86	; 03802964
	mov r1,#0x50	; 03802966
	add r2,r4,#0x0	; 03802968
	mov r3,#0x3	; 0380296A
	bl loc_03802618	; 0380296C
	mov r0,#0x1	; 03802970
	b loc_03802976	; 03802972
loc_03802974:
	mov r0,#0x0	; 03802974
loc_03802976:
	add sp,#0x8	; 03802976
	pop {r4}	; 03802978
	pop {r3}	; 0380297A
	bx r3	; 0380297C
	.byte 0x00, 0x00	; 03802980

; ===== function loc_03802980 =====
loc_03802980:
	push {r4,lr}	; 03802980
	sub sp,#0x8	; 03802982
	add r4,r0,#0x0	; 03802984
	add r0,sp,#0x0	; 03802986
	bl loc_038028B8	; 03802988
	add r0,sp,#0x0	; 0380298C
	ldrh r0,[r0,#0x0]	; 0380298E
	lsl r0,r0,#0x1c	; 03802990
	lsr r0,r0,#0x1c	; 03802992
	cmp r0,#0x4	; 03802994
	bne loc_038029A8	; 03802996
	mov r0,#0x6	; 03802998
	mov r1,#0x10	; 0380299A
	add r2,r4,#0x0	; 0380299C
	mov r3,#0x3	; 0380299E
	bl loc_03802618	; 038029A0
	mov r0,#0x1	; 038029A4
	b loc_038029AA	; 038029A6
loc_038029A8:
	mov r0,#0x0	; 038029A8
loc_038029AA:
	add sp,#0x8	; 038029AA
	pop {r4}	; 038029AC
	pop {r3}	; 038029AE
	bx r3	; 038029B0
	.byte 0x00, 0x00	; 038029B4

; ===== function loc_038029B4 =====
loc_038029B4:
	push {r4,lr}	; 038029B4
	sub sp,#0x8	; 038029B6
	add r4,r0,#0x0	; 038029B8
	add r0,sp,#0x0	; 038029BA
	bl loc_038028B8	; 038029BC
	add r0,sp,#0x0	; 038029C0
	ldrh r0,[r0,#0x0]	; 038029C2
	lsl r0,r0,#0x1c	; 038029C4
	lsr r0,r0,#0x1c	; 038029C6
	cmp r0,#0x4	; 038029C8
	bne loc_038029DC	; 038029CA
	mov r0,#0x86	; 038029CC
	mov r1,#0x10	; 038029CE
	add r2,r4,#0x0	; 038029D0
	mov r3,#0x3	; 038029D2
	bl loc_03802618	; 038029D4
	mov r0,#0x1	; 038029D8
	b loc_038029DE	; 038029DA
loc_038029DC:
	mov r0,#0x0	; 038029DC
loc_038029DE:
	add sp,#0x8	; 038029DE
	pop {r4}	; 038029E0
	pop {r3}	; 038029E2
	bx r3	; 038029E4
	.byte 0x00, 0x00	; 038029E8

; ===== function loc_038029E8 =====
loc_038029E8:
	push {r4,lr}	; 038029E8
	add r4,r0,#0x0	; 038029EA
	ldr r0,[pool_03802A04]	; 038029EC
	bl loc_0380214C	; 038029EE
	mov r0,#0x6	; 038029F2
	mov r1,#0x20	; 038029F4
	add r2,r4,#0x0	; 038029F6
	mov r3,#0x7	; 038029F8
	bl loc_03802618	; 038029FA
	pop {r4}	; 038029FE
	pop {r3}	; 03802A00
	bx r3	; 03802A02
pool_03802A04:
loc_03802A04:
	.word 0x00008000	; 03802A04

; ===== function loc_03802A08 =====
loc_03802A08:
	push {r4,lr}	; 03802A08
	add r4,r0,#0x0	; 03802A0A
	ldr r0,[pool_03802A24]	; 03802A0C
	bl loc_0380214C	; 03802A0E
	mov r0,#0x86	; 03802A12
	mov r1,#0x20	; 03802A14
	add r2,r4,#0x0	; 03802A16
	mov r3,#0x7	; 03802A18
	bl loc_03802618	; 03802A1A
	pop {r4}	; 03802A1E
	pop {r3}	; 03802A20
	bx r3	; 03802A22
pool_03802A24:
loc_03802A24:
	.word 0x00008000	; 03802A24

; ===== function loc_03802A28 =====
loc_03802A28:
	push {r4,r5,lr}	; 03802A28
	sub sp,#0xc	; 03802A2A
	add r5,r0,#0x0	; 03802A2C
	mov r0,#0x1	; 03802A2E
	add r4,r5,#0x0	; 03802A30
	and r4,r0	; 03802A32
	lsl r0,r4,#0x10	; 03802A34
	lsr r0,r0,#0x10	; 03802A36
	cmp r0,#0x1	; 03802A38
	bne loc_03802AC8	; 03802A3A
	add r0,sp,#0x0	; 03802A3C
	bl loc_038028F8	; 03802A3E
	add r0,sp,#0x0	; 03802A42
	ldrh r1,[r0,#0x0]	; 03802A44
	lsl r2,r1,#0x1e	; 03802A46
	lsr r3,r2,#0x1f	; 03802A48
	lsl r2,r4,#0x10	; 03802A4A
	lsr r2,r2,#0x10	; 03802A4C
	cmp r3,r2	; 03802A4E
	beq loc_03802AC8	; 03802A50
	mov r3,#0x1	; 03802A52
	and r5,r3	; 03802A54
	mov r2,#0x2	; 03802A56
	bic r1,r2	; 03802A58
	lsl r2,r5,#0x10	; 03802A5A
	lsr r2,r2,#0x10	; 03802A5C
	and r2,r3	; 03802A5E
	lsl r2,r2,#0x1	; 03802A60
	orr r1,r2	; 03802A62
	strh r1,[r0,#0x0]	; 03802A64
	add r0,sp,#0x0	; 03802A66
	bl loc_038028D8	; 03802A68
	mov r0,#0x86	; 03802A6C
	mov r1,#0x10	; 03802A6E
	add r2,sp,#0x4	; 03802A70
	mov r3,#0x3	; 03802A72
	bl loc_03802618	; 03802A74
	lsl r0,r5,#0x10	; 03802A78
	lsr r0,r0,#0x10	; 03802A7A
	cmp r0,#0x0	; 03802A7C
	bne loc_03802A88	; 03802A7E
	add r0,sp,#0x4	; 03802A80
	bl loc_03802750	; 03802A82
	b loc_03802A8E	; 03802A86
loc_03802A88:
	add r0,sp,#0x4	; 03802A88
	bl loc_03802694	; 03802A8A
loc_03802A8E:
	mov r0,#0x6	; 03802A8E
	mov r1,#0x10	; 03802A90
	add r2,sp,#0x4	; 03802A92
	mov r3,#0x3	; 03802A94
	bl loc_03802618	; 03802A96
	mov r0,#0x86	; 03802A9A
	mov r1,#0x50	; 03802A9C
	add r2,sp,#0x4	; 03802A9E
	mov r3,#0x3	; 03802AA0
	bl loc_03802618	; 03802AA2
	lsl r0,r4,#0x10	; 03802AA6
	lsr r0,r0,#0x10	; 03802AA8
	cmp r0,#0x0	; 03802AAA
	bne loc_03802AB6	; 03802AAC
	add r0,sp,#0x4	; 03802AAE
	bl loc_03802750	; 03802AB0
	b loc_03802ABC	; 03802AB4
loc_03802AB6:
	add r0,sp,#0x4	; 03802AB6
	bl loc_03802694	; 03802AB8
loc_03802ABC:
	mov r0,#0x6	; 03802ABC
	mov r1,#0x50	; 03802ABE
	add r2,sp,#0x4	; 03802AC0
	mov r3,#0x3	; 03802AC2
	bl loc_03802618	; 03802AC4
loc_03802AC8:
	add sp,#0xc	; 03802AC8
	pop {r4,r5}	; 03802ACA
	pop {r3}	; 03802ACC
	bx r3	; 03802ACE

; ===== function loc_03802AD0 =====
loc_03802AD0:
	push {lr}	; 03802AD0
	sub sp,#0x4	; 03802AD2
	ldr r0,[pool_03802AF8]	; 03802AD4
	bl loc_0380214C	; 03802AD6
	add r0,sp,#0x0	; 03802ADA
	ldrh r1,[r0,#0x0]	; 03802ADC
	mov r3,#0x1	; 03802ADE
	bic r1,r3	; 03802AE0
	orr r1,r3	; 03802AE2
	strh r1,[r0,#0x0]	; 03802AE4
	mov r0,#0x6	; 03802AE6
	mov r1,#0x0	; 03802AE8
	add r2,sp,#0x0	; 03802AEA
	bl loc_03802618	; 03802AEC
	add sp,#0x4	; 03802AF0
	pop {r3}	; 03802AF2
	bx r3	; 03802AF4
	.byte 0xC0, 0x46	; 03802AF8
pool_03802AF8:
loc_03802AF8:
	.word 0x00008000	; 03802AF8
.arm

; ===== function loc_03802AFC =====
loc_03802AFC:
	mov r12,#0x4000000	; 03802AFC
	add r12,r12,#0x138	; 03802B00
	ldrh r0,[r12,#0x0]	; 03802B04
	bic r0,r0,#0x77	; 03802B08
	orr r0,r0,#0x72	; 03802B0C
	strh r0,[r12,#0x0]	; 03802B10
	mov r3,#0x2	; 03802B14
loc_03802B18:
	subs r3,r3,#0x1	; 03802B18
	bne loc_03802B18	; 03802B1C
	bic r0,r0,#0x4	; 03802B20
	orr r0,r0,#0x4	; 03802B24
	strh r0,[r12,#0x0]	; 03802B28
	mov r3,#0x2	; 03802B2C
loc_03802B30:
	subs r3,r3,#0x1	; 03802B30
	bne loc_03802B30	; 03802B34
	bx lr	; 03802B38

; ===== function loc_03802B3C =====
loc_03802B3C:
	mov r12,#0x4000000	; 03802B3C
	add r12,r12,#0x138	; 03802B40
	mov r3,#0x2	; 03802B44
loc_03802B48:
	subs r3,r3,#0x1	; 03802B48
	bne loc_03802B48	; 03802B4C
	ldrh r0,[r12,#0x0]	; 03802B50
	bic r0,r0,#0x4	; 03802B54
	orr r0,r0,#0x0	; 03802B58
	strh r0,[r12,#0x0]	; 03802B5C
	mov r3,#0x2	; 03802B60
loc_03802B64:
	subs r3,r3,#0x1	; 03802B64
	bne loc_03802B64	; 03802B68
	bx lr	; 03802B6C

; ===== function loc_03802B70 =====
loc_03802B70:
	mov r12,#0x4000000	; 03802B70
	add r12,r12,#0x138	; 03802B74
	orr r1,r0,r1	; 03802B78
	ldrh r0,[r12,#0x0]	; 03802B7C
	bic r0,r0,#0x77	; 03802B80
	orr r0,r0,#0x74	; 03802B84
	mov r2,#0x0	; 03802B88
loc_03802B8C:
	bic r0,r0,#0x3	; 03802B8C
	orr r0,r0,#0x0	; 03802B90
	mov r3,#0x1	; 03802B94
	tst r3,r1, lsr r2	; 03802B98
	movne r3,#0x1	; 03802B9C
	moveq r3,#0x0	; 03802BA0
	orr r0,r0,r3	; 03802BA4
	strh r0,[r12,#0x0]	; 03802BA8
	mov r3,#0x9	; 03802BAC
loc_03802BB0:
	subs r3,r3,#0x1	; 03802BB0
	bne loc_03802BB0	; 03802BB4
	bic r0,r0,#0x2	; 03802BB8
	orr r0,r0,#0x2	; 03802BBC
	strh r0,[r12,#0x0]	; 03802BC0
	mov r3,#0x9	; 03802BC4
loc_03802BC8:
	subs r3,r3,#0x1	; 03802BC8
	bne loc_03802BC8	; 03802BCC
	add r2,r2,#0x1	; 03802BD0
	cmp r2,#0x8	; 03802BD4
	bne loc_03802B8C	; 03802BD8
	bx lr	; 03802BDC

; ===== function loc_03802BE0 =====
loc_03802BE0:
	mov r12,#0x4000000	; 03802BE0
	add r12,r12,#0x138	; 03802BE4
loc_03802BE8:
	stmdb sp!,{r0,r1}	; 03802BE8
	tst r0,#0x1	; 03802BEC
	ldreqh r1,[r0,#0x0]	; 03802BF0
	ldrneh r1,[r0,#-0x1]	; 03802BF4
	movne r1,r1, lsr #0x8	; 03802BF8
	ldrh r0,[r12,#0x0]	; 03802BFC
	bic r0,r0,#0x77	; 03802C00
	orr r0,r0,#0x74	; 03802C04
	mov r2,#0x0	; 03802C08
loc_03802C0C:
	bic r0,r0,#0x3	; 03802C0C
	orr r0,r0,#0x0	; 03802C10
	mov r3,#0x1	; 03802C14
	tst r3,r1, lsr r2	; 03802C18
	movne r3,#0x1	; 03802C1C
	moveq r3,#0x0	; 03802C20
	orr r0,r0,r3	; 03802C24
	strh r0,[r12,#0x0]	; 03802C28
	mov r3,#0x9	; 03802C2C
loc_03802C30:
	subs r3,r3,#0x1	; 03802C30
	bne loc_03802C30	; 03802C34
	bic r0,r0,#0x2	; 03802C38
	orr r0,r0,#0x2	; 03802C3C
	strh r0,[r12,#0x0]	; 03802C40
	mov r3,#0x9	; 03802C44
loc_03802C48:
	subs r3,r3,#0x1	; 03802C48
	bne loc_03802C48	; 03802C4C
	add r2,r2,#0x1	; 03802C50
	cmp r2,#0x8	; 03802C54
	bne loc_03802C0C	; 03802C58
	ldmia sp!,{r0,r1}	; 03802C5C
	add r0,r0,#0x1	; 03802C60
	subs r1,r1,#0x1	; 03802C64
	bne loc_03802BE8	; 03802C68
	bx lr	; 03802C6C

; ===== function loc_03802C70 =====
loc_03802C70:
	mov r12,#0x4000000	; 03802C70
	add r12,r12,#0x138	; 03802C74
loc_03802C78:
	stmdb sp!,{r0,r1}	; 03802C78
	ldrh r0,[r12,#0x0]	; 03802C7C
	bic r0,r0,#0x77	; 03802C80
	orr r0,r0,#0x64	; 03802C84
	mov r2,#0x0	; 03802C88
	mov r1,#0x0	; 03802C8C
loc_03802C90:
	bic r0,r0,#0x3	; 03802C90
	orr r0,r0,#0x0	; 03802C94
	strh r0,[r12,#0x0]	; 03802C98
	mov r3,#0x9	; 03802C9C
loc_03802CA0:
	subs r3,r3,#0x1	; 03802CA0
	bne loc_03802CA0	; 03802CA4
	ldrh r0,[r12,#0x0]	; 03802CA8
	and r3,r0,#0x1	; 03802CAC
	cmp r3,#0x1	; 03802CB0
	moveq r3,#0x80	; 03802CB4
	movne r3,#0x0	; 03802CB8
	orr r2,r3,r2, lsr #0x1	; 03802CBC
	bic r0,r0,#0x2	; 03802CC0
	orr r0,r0,#0x2	; 03802CC4
	strh r0,[r12,#0x0]	; 03802CC8
	mov r3,#0x9	; 03802CCC
loc_03802CD0:
	subs r3,r3,#0x1	; 03802CD0
	bne loc_03802CD0	; 03802CD4
	add r1,r1,#0x1	; 03802CD8
	cmp r1,#0x8	; 03802CDC
	bne loc_03802C90	; 03802CE0
	ldmia sp!,{r0,r1}	; 03802CE4
	tst r0,#0x1	; 03802CE8
	beq loc_03802D08	; 03802CEC
	ldrh r3,[r0,#-0x1]	; 03802CF0
	bic r3,r3,#0xff00	; 03802CF4
	mov r2,r2, lsl #0x8	; 03802CF8
	orr r3,r2,r3	; 03802CFC
	strh r3,[r0,#-0x1]	; 03802D00
	b loc_03802D18	; 03802D04
loc_03802D08:
	ldrh r3,[r0,#0x0]	; 03802D08
	bic r3,r3,#0xff	; 03802D0C
	orr r3,r3,r2	; 03802D10
	strh r3,[r0,#0x0]	; 03802D14
loc_03802D18:
	add r0,r0,#0x1	; 03802D18
	subs r1,r1,#0x1	; 03802D1C
	bne loc_03802C78	; 03802D20
	bx lr	; 03802D24
.thumb

; ===== function loc_03802D28 =====
P2_PxiCallback_03802D28:
	push {lr}	; 03802D28
	sub sp,#0x4	; 03802D2A
	cmp r2,#0x0	; 03802D2C
	bne loc_03802D54	; 03802D2E
	cmp r0,#0x4	; 03802D30
	beq loc_03802D4E	; 03802D32
	cmp r0,#0x6	; 03802D34
	beq loc_03802D3E	; 03802D36
	cmp r0,#0x8	; 03802D38
	beq loc_03802D46	; 03802D3A
	b loc_03802D54	; 03802D3C
loc_03802D3E:
	add r0,r1,#0x0	; 03802D3E
	bl loc_03803250	; 03802D40
	b loc_03802D54	; 03802D44
loc_03802D46:
	add r0,r1,#0x0	; 03802D46
	bl loc_0380426C	; 03802D48
	b loc_03802D54	; 03802D4C
loc_03802D4E:
	add r0,r1,#0x0	; 03802D4E
	bl loc_03803AF4	; 03802D50
loc_03802D54:
	add sp,#0x4	; 03802D54
	pop {r3}	; 03802D56
	bx r3	; 03802D58
	.byte 0x00, 0x00	; 03802D5A
P2_ThreadEntry_03802D5C:
	push {r4,r5,r6,lr}	; 03802D5C
	sub sp,#0x8	; 03802D5E
	ldr r5,[pool_03802D94]	; 03802D60
	add r4,sp,#0x0	; 03802D62
	mov r6,#0x1	; 03802D64
P2_Entry_03802D66:
	add r0,r5,#0x0	; 03802D66
	add r1,r4,#0x0	; 03802D68
	add r2,r6,#0x0	; 03802D6A
	bl loc_037FE290	; 03802D6C
	ldr r0,[sp,#0x0]	; 03802D70
	ldr r1,[r0,#0x0]	; 03802D72
	cmp r1,#0x0	; 03802D74
	beq P2_Entry_03802D82	; 03802D76
	cmp r1,#0x1	; 03802D78
	beq P2_Entry_03802D8E	; 03802D7A
	cmp r1,#0x3	; 03802D7C
	beq P2_Entry_03802D88	; 03802D7E
	b P2_Entry_03802D66	; 03802D80
P2_Entry_03802D82:
	bl P2_Entry_038030E4	; 03802D82
	b P2_Entry_03802D66	; 03802D86
P2_Entry_03802D88:
	bl P2_Entry_03804170	; 03802D88
	b P2_Entry_03802D66	; 03802D8C
P2_Entry_03802D8E:
	bl P2_Entry_038039A0	; 03802D8E
	b P2_Entry_03802D66	; 03802D92
pool_03802D94:
	.word 0x03807760	; 03802D94

; ===== function loc_03802D98 =====
loc_03802D98:
	push {r0,r1,r2,r3}	; 03802D98
	push {r4,r5,r6,r7,lr}	; 03802D9A
	sub sp,#0x4	; 03802D9C
	add r5,r0,#0x0	; 03802D9E
	add r4,r1,#0x0	; 03802DA0
	add r0,sp,#0x18	; 03802DA2
	ldrh r0,[r0,#0x8]	; 03802DA4
	cmp r0,#0x4	; 03802DA6
	bls loc_03802DAE	; 03802DA8
	mov r0,#0x0	; 03802DAA
	b loc_03802E1E	; 03802DAC
loc_03802DAE:
	bl loc_037FDCE8	; 03802DAE
	add r7,r0,#0x0	; 03802DB2
	ldr r0,[pool_03802E28]	; 03802DB4
	ldr r1,[r0,#0x54]	; 03802DB6
	mov r0,#0x18	; 03802DB8
	mul r1,r0	; 03802DBA
	ldr r0,[pool_03802E2C]	; 03802DBC
	str r5,[r0,r1]	; 03802DBE
	ldr r0,[pool_03802E28]	; 03802DC0
	ldr r1,[r0,#0x54]	; 03802DC2
	mov r0,#0x18	; 03802DC4
	mul r1,r0	; 03802DC6
	ldr r0,[pool_03802E30]	; 03802DC8
	str r4,[r0,r1]	; 03802DCA
	add r1,sp,#0x20	; 03802DCC
	mov r0,#0x3	; 03802DCE
	bic r1,r0	; 03802DD0
	add r6,r1,#0x4	; 03802DD2
	mov r5,#0x0	; 03802DD4
	add r0,sp,#0x18	; 03802DD6
	ldrh r4,[r0,#0x8]	; 03802DD8
	b loc_03802DF8	; 03802DDA
loc_03802DDC:
	add r6,r6,#0x4	; 03802DDC
	sub r0,r6,#0x4	; 03802DDE
	ldr r3,[r0,#0x0]	; 03802DE0
	ldr r0,[pool_03802E28]	; 03802DE2
	ldr r2,[r0,#0x54]	; 03802DE4
	mov r0,#0x18	; 03802DE6
	mul r2,r0	; 03802DE8
	lsl r1,r5,#0x2	; 03802DEA
	ldr r0,[pool_03802E34]	; 03802DEC
	add r0,r0,r2	; 03802DEE
	add r1,r1,r0	; 03802DF0
	ldr r0,[pool_03802E38]	; 03802DF2
	str r3,[r1,r0]	; 03802DF4
	add r5,r5,#0x1	; 03802DF6
loc_03802DF8:
	cmp r5,r4	; 03802DF8
	blt loc_03802DDC	; 03802DFA
	ldr r1,[pool_03802E28]	; 03802DFC
	ldr r4,[r1,#0x54]	; 03802DFE
	add r2,r4,#0x1	; 03802E00
	mov r0,#0xf	; 03802E02
	and r2,r0	; 03802E04
	str r2,[r1,#0x54]	; 03802E06
	add r0,r7,#0x0	; 03802E08
	bl loc_037FDD0C	; 03802E0A
	ldr r0,[pool_03802E3C]	; 03802E0E
	ldr r2,[pool_03802E2C]	; 03802E10
	mov r1,#0x18	; 03802E12
	mul r4,r1	; 03802E14
	add r1,r2,r4	; 03802E16
	mov r2,#0x0	; 03802E18
	bl loc_037FE308	; 03802E1A
loc_03802E1E:
	add sp,#0x4	; 03802E1E
	pop {r4,r5,r6,r7}	; 03802E20
	pop {r3}	; 03802E22
	add sp,#0x10	; 03802E24
	bx r3	; 03802E26
pool_03802E28:
loc_03802E28:
	.word P2_BssStart + 0x2540	; 03802E28
pool_03802E2C:
loc_03802E2C:
	.word P2_BssStart + 0x2414	; 03802E2C
pool_03802E30:
loc_03802E30:
	.word P2_BssStart + 0x2418	; 03802E30
pool_03802E34:
loc_03802E34:
	.word 0x038074E0	; 03802E34
pool_03802E38:
loc_03802E38:
	.word 0x000002DC	; 03802E38
pool_03802E3C:
loc_03802E3C:
	.word 0x03807760	; 03802E3C

; ===== function loc_03802E40 =====
P2_Entry_03802E40:
	push {lr}	; 03802E40
	sub sp,#0x4	; 03802E42
	ldr r1,[pool_03802E60]	; 03802E44
	ldr r2,[r1,#0x4]	; 03802E46
	cmp r2,r0	; 03802E48
	bne loc_03802E5A	; 03802E4A
	mov r0,#0x5	; 03802E4C
	str r0,[r1,#0x4]	; 03802E4E
	mov r0,#0x0	; 03802E50
	str r0,[r1,#0x0]	; 03802E52
	ldr r0,[pool_03802E64]	; 03802E54
	bl loc_037FDF0C	; 03802E56
loc_03802E5A:
	add sp,#0x4	; 03802E5A
	pop {r3}	; 03802E5C
	bx r3	; 03802E5E
pool_03802E60:
loc_03802E60:
	.word P2_BssStart + 0x2140	; 03802E60
pool_03802E64:
loc_03802E64:
	.word 0x03807938	; 03802E64

; ===== function loc_03802E68 =====
loc_03802E68:
	mov r2,#0x1	; 03802E68
	ldr r1,[pool_03802E74]	; 03802E6A
	str r2,[r1,#0x0]	; 03802E6C
	str r0,[r1,#0x4]	; 03802E6E
	bx lr	; 03802E70
	.byte 0xC0, 0x46	; 03802E74
pool_03802E74:
loc_03802E74:
	.word P2_BssStart + 0x2140	; 03802E74
P2_Entry_03802E78:
	ldr r0,[pool_03802E88]	; 03802E78
	ldr r0,[r0,#0x0]	; 03802E7A
	cmp r0,#0x0	; 03802E7C
	bne P2_Entry_03802E84	; 03802E7E
	mov r0,#0x1	; 03802E80
	bx lr	; 03802E82
P2_Entry_03802E84:
	mov r0,#0x0	; 03802E84
	bx lr	; 03802E86
pool_03802E88:
	.word P2_BssStart + 0x2140	; 03802E88

; ===== function loc_03802E8C =====
loc_03802E8C:
	push {r4,r5,r6,lr}	; 03802E8C
	mov r2,#0x70	; 03802E8E
	add r3,r0,#0x0	; 03802E90
	and r3,r2	; 03802E92
	cmp r3,#0x20	; 03802E94
	bgt loc_03802EAC	; 03802E96
	cmp r3,#0x20	; 03802E98
	bge loc_03802EC8	; 03802E9A
	cmp r3,#0x0	; 03802E9C
	bgt loc_03802EA6	; 03802E9E
	cmp r3,#0x0	; 03802EA0
	beq loc_03802EC0	; 03802EA2
	b loc_03802ECA	; 03802EA4
loc_03802EA6:
	cmp r3,#0x10	; 03802EA6
	beq loc_03802EC0	; 03802EA8
	b loc_03802ECA	; 03802EAA
loc_03802EAC:
	cmp r3,#0x60	; 03802EAC
	bgt loc_03802EBA	; 03802EAE
	cmp r3,#0x60	; 03802EB0
	bge loc_03802EC4	; 03802EB2
	cmp r3,#0x30	; 03802EB4
	beq loc_03802EC8	; 03802EB6
	b loc_03802ECA	; 03802EB8
loc_03802EBA:
	cmp r3,#0x70	; 03802EBA
	beq loc_03802EC4	; 03802EBC
	b loc_03802ECA	; 03802EBE
loc_03802EC0:
	mov r5,#0x6	; 03802EC0
	b loc_03802ECA	; 03802EC2
loc_03802EC4:
	mov r5,#0x8	; 03802EC4
	b loc_03802ECA	; 03802EC6
loc_03802EC8:
	mov r5,#0x4	; 03802EC8
loc_03802ECA:
	mov r3,#0xff	; 03802ECA
	and r0,r3	; 03802ECC
	mov r2,#0x80	; 03802ECE
	orr r0,r2	; 03802ED0
	lsl r4,r0,#0x8	; 03802ED2
	ldr r0,[pool_03802EF4]	; 03802ED4
	orr r4,r0	; 03802ED6
	and r1,r3	; 03802ED8
	orr r4,r1	; 03802EDA
	mov r6,#0x0	; 03802EDC
loc_03802EDE:
	add r0,r5,#0x0	; 03802EDE
	add r1,r4,#0x0	; 03802EE0
	add r2,r6,#0x0	; 03802EE2
	bl loc_03801F38	; 03802EE4
	cmp r0,#0x0	; 03802EE8
	blt loc_03802EDE	; 03802EEA
	pop {r4,r5,r6}	; 03802EEC
	pop {r3}	; 03802EEE
	bx r3	; 03802EF0
	.byte 0xC0, 0x46	; 03802EF4
pool_03802EF4:
loc_03802EF4:
	.word 0x03000000	; 03802EF4

; ===== function loc_03802EF8 =====
loc_03802EF8:
	push {lr}	; 03802EF8
	sub sp,#0x4	; 03802EFA
	ldr r1,[pool_03802F34]	; 03802EFC
	ldr r2,[r1,#0x0]	; 03802EFE
	cmp r2,#0x0	; 03802F00
	beq loc_03802F2E	; 03802F02
	ldr r1,[r1,#0x4]	; 03802F04
	cmp r1,#0x4	; 03802F06
	bne loc_03802F2E	; 03802F08
	ldr r1,[pool_03802F38]	; 03802F0A
	ldr r1,[r1,#0x5c]	; 03802F0C
	cmp r1,r0	; 03802F0E
	bne loc_03802F2E	; 03802F10
	bl loc_037FDCE8	; 03802F12
	mov r2,#0x5	; 03802F16
	ldr r1,[pool_03802F34]	; 03802F18
	str r2,[r1,#0x4]	; 03802F1A
	mov r2,#0x0	; 03802F1C
	str r2,[r1,#0x0]	; 03802F1E
	ldr r1,[pool_03802F38]	; 03802F20
	str r2,[r1,#0x5c]	; 03802F22
	bl loc_037FDD0C	; 03802F24
	ldr r0,[pool_03802F3C]	; 03802F28
	bl loc_037FDF0C	; 03802F2A
loc_03802F2E:
	add sp,#0x4	; 03802F2E
	pop {r3}	; 03802F30
	bx r3	; 03802F32
pool_03802F34:
loc_03802F34:
	.word P2_BssStart + 0x2140	; 03802F34
pool_03802F38:
loc_03802F38:
	.word P2_BssStart + 0x2540	; 03802F38
pool_03802F3C:
loc_03802F3C:
	.word 0x03807938	; 03802F3C

; ===== function loc_03802F40 =====
loc_03802F40:
	push {r4,r5,r6,r7,lr}	; 03802F40
	sub sp,#0x4	; 03802F42
	add r5,r0,#0x0	; 03802F44
	ldr r7,[pool_03802F7C]	; 03802F46
	ldr r6,[pool_03802F80]	; 03802F48
loc_03802F4A:
	bl loc_037FDCE8	; 03802F4A
	add r4,r0,#0x0	; 03802F4E
	ldr r1,[r6,#0x0]	; 03802F50
	cmp r1,#0x0	; 03802F52
	beq loc_03802F62	; 03802F54
	bl loc_037FDD0C	; 03802F56
	add r0,r7,#0x0	; 03802F5A
	bl loc_037FDF54	; 03802F5C
	b loc_03802F4A	; 03802F60
loc_03802F62:
	mov r0,#0x4	; 03802F62
	bl loc_03802E68	; 03802F64
	ldr r0,[pool_03802F84]	; 03802F68
	str r5,[r0,#0x5c]	; 03802F6A
	add r0,r4,#0x0	; 03802F6C
	bl loc_037FDD0C	; 03802F6E
	add sp,#0x4	; 03802F72
	pop {r4,r5,r6,r7}	; 03802F74
	pop {r3}	; 03802F76
	bx r3	; 03802F78
	.byte 0xC0, 0x46	; 03802F7C
pool_03802F7C:
loc_03802F7C:
	.word 0x03807938	; 03802F7C
pool_03802F80:
loc_03802F80:
	.word 0x038074E0	; 03802F80
pool_03802F84:
loc_03802F84:
	.word P2_BssStart + 0x2540	; 03802F84

; ===== function loc_03802F88 =====
loc_03802F88:
	push {r4,r5,r6,r7,lr}	; 03802F88
	sub sp,#0xc	; 03802F8A
	add r5,r0,#0x0	; 03802F8C
	ldr r0,[pool_0380301C]	; 03802F8E
	ldrh r1,[r0,#0x0]	; 03802F90
	cmp r1,#0x0	; 03802F92
	bne loc_03803012	; 03802F94
	mov r1,#0x1	; 03802F96
	strh r1,[r0,#0x0]	; 03802F98
	mov r1,#0x0	; 03802F9A
	ldr r0,[pool_03803020]	; 03802F9C
	str r1,[r0,#0x0]	; 03802F9E
	mov r1,#0x5	; 03802FA0
	str r1,[r0,#0x4]	; 03802FA2
	bl loc_03803388	; 03802FA4
	bl loc_03803C2C	; 03802FA8
	bl loc_038043B4	; 03802FAC
	bl loc_03801E58	; 03802FB0
	mov r0,#0x6	; 03802FB4
	ldr r1,[pool_03803024]	; 03802FB6
	bl P2_SetPxiReceiveCallback	; 03802FB8
	mov r0,#0x8	; 03802FBC
	ldr r1,[pool_03803024]	; 03802FBE
	bl P2_SetPxiReceiveCallback	; 03802FC0
	mov r0,#0x4	; 03802FC4
	ldr r1,[pool_03803024]	; 03802FC6
	bl P2_SetPxiReceiveCallback	; 03802FC8
	ldr r0,[pool_03803028]	; 03802FCC
	ldr r1,[pool_0380302C]	; 03802FCE
	mov r2,#0x10	; 03802FD0
	bl loc_037FE364	; 03802FD2
	mov r4,#0x0	; 03802FD6
	ldr r7,[pool_03803030]	; 03802FD8
	add r6,r4,#0x0	; 03802FDA
loc_03802FDC:
	add r1,r4,#0x0	; 03802FDC
	mov r0,#0x18	; 03802FDE
	mul r1,r0	; 03802FE0
	add r0,r7,r1	; 03802FE2
	add r1,r6,#0x0	; 03802FE4
	mov r2,#0x18	; 03802FE6
	bl loc_03803048	; 03802FE8
	add r4,r4,#0x1	; 03802FEC
	cmp r4,#0x10	; 03802FEE
	blt loc_03802FDC	; 03802FF0
	mov r2,#0x0	; 03802FF2
	ldr r0,[pool_03803034]	; 03802FF4
	str r2,[r0,#0x54]	; 03802FF6
	ldr r0,[pool_03803038]	; 03802FF8
	strh r2,[r0,#0x18]	; 03802FFA
	ldr r0,[pool_0380303C]	; 03802FFC
	str r0,[sp,#0x0]	; 03802FFE
	str r5,[sp,#0x4]	; 03803000
	ldr r0,[pool_03803040]	; 03803002
	ldr r1,[pool_03803044]	; 03803004
	ldr r3,[pool_03803028]	; 03803006
	bl P2_CreateThread	; 03803008
	ldr r0,[pool_03803040]	; 0380300C
	bl loc_037FDEE8	; 0380300E
loc_03803012:
	add sp,#0xc	; 03803012
	pop {r4,r5,r6,r7}	; 03803014
	pop {r3}	; 03803016
	bx r3	; 03803018
	.byte 0xC0, 0x46	; 0380301C
pool_0380301C:
loc_0380301C:
	.word P2_BssStart + 0x213C	; 0380301C
pool_03803020:
loc_03803020:
	.word P2_BssStart + 0x2140	; 03803020
pool_03803024:
loc_03803024:
	.word P2_PxiCallback_03802D28 + 1	; 03803024
pool_03803028:
loc_03803028:
	.word 0x03807760	; 03803028
pool_0380302C:
loc_0380302C:
	.word 0x03807774	; 0380302C
pool_03803030:
loc_03803030:
	.word 0x038077B4	; 03803030
pool_03803034:
loc_03803034:
	.word P2_BssStart + 0x2540	; 03803034
pool_03803038:
loc_03803038:
	.word P2_BssStart + 0x2580	; 03803038
pool_0380303C:
loc_0380303C:
	.word 0x00000200	; 0380303C
pool_03803040:
loc_03803040:
	.word 0x038074E8	; 03803040
pool_03803044:
loc_03803044:
	.word P2_ThreadEntry_03802D5C + 1	; 03803044

; ===== function loc_03803048 =====
loc_03803048:
	bx pc	; 03803048
	.byte 0xC0, 0x46	; 0380304C
.arm

; ===== function loc_0380304C =====
loc_0380304C:
	ldr pc,[pool_03803050]	; 0380304C
pool_03803050:
loc_03803050:
	.word loc_037FF3D0	; 03803050
.thumb

; ===== function loc_03803054 =====
loc_03803054:
	push {lr}	; 03803054
	sub sp,#0x4	; 03803056
	cmp r0,#0x0	; 03803058
	bne loc_03803066	; 0380305A
	mov r0,#0x3	; 0380305C
	mov r1,#0x2	; 0380305E
	bl loc_03802E8C	; 03803060
	b loc_03803082	; 03803064
loc_03803066:
	cmp r1,#0x0	; 03803066
	bne loc_03803074	; 03803068
	mov r0,#0x3	; 0380306A
	mov r1,#0x2	; 0380306C
	bl loc_03802E8C	; 0380306E
	b loc_03803082	; 03803072
loc_03803074:
	ldr r2,[pool_03803088]	; 03803074
	str r0,[r2,#0x24]	; 03803076
	str r1,[r2,#0x28]	; 03803078
	mov r0,#0x3	; 0380307A
	mov r1,#0x0	; 0380307C
	bl loc_03802E8C	; 0380307E
loc_03803082:
	add sp,#0x4	; 03803082
	pop {r3}	; 03803084
	bx r3	; 03803086
pool_03803088:
loc_03803088:
	.word P2_BssStart + 0x25A0	; 03803088

; ===== function loc_0380308C =====
	push {r4,lr}	; 0380308C
	sub sp,#0x8	; 0380308E
	add r4,r0,#0x0	; 03803090
	mov r0,#0x0	; 03803092
	mov r1,#0x10	; 03803094
	mov r2,#0x1	; 03803096
	add r3,r4,#0x0	; 03803098
	bl loc_03802D98	; 0380309A
	cmp r0,#0x0	; 0380309E
	bne loc_038030CA	; 038030A0
	ldr r1,[sp,#0x0]	; 038030A2
	ldr r0,[pool_038030D4]	; 038030A4
	and r1,r0	; 038030A6
	ldr r0,[pool_038030D8]	; 038030A8
	orr r1,r0	; 038030AA
	str r1,[sp,#0x0]	; 038030AC
	add r0,sp,#0x0	; 038030AE
	ldrh r2,[r0,#0x0]	; 038030B0
	ldr r1,[pool_038030DC]	; 038030B2
	strh r2,[r1,#0x0]	; 038030B4
	ldrh r1,[r0,#0x2]	; 038030B6
	ldr r0,[pool_038030E0]	; 038030B8
	strh r1,[r0,#0x0]	; 038030BA
	mov r0,#0x10	; 038030BC
	mov r1,#0xff	; 038030BE
	and r4,r1	; 038030C0
	lsl r1,r4,#0x10	; 038030C2
	lsr r1,r1,#0x10	; 038030C4
	bl loc_03802E8C	; 038030C6
loc_038030CA:
	add sp,#0x8	; 038030CA
	pop {r4}	; 038030CC
	pop {r3}	; 038030CE
	bx r3	; 038030D0
	.byte 0xC0, 0x46	; 038030D4
pool_038030D4:
loc_038030D4:
	.word 0xF9FFFFFF	; 038030D4
pool_038030D8:
loc_038030D8:
	.word 0x06000000	; 038030D8
pool_038030DC:
loc_038030DC:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 038030DC
pool_038030E0:
loc_038030E0:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 038030E0
P2_Entry_038030E4:
	push {r4,r5,r6,r7,lr}	; 038030E4
	sub sp,#0xc	; 038030E6
	add r5,r0,#0x0	; 038030E8
	ldr r1,[r5,#0x4]	; 038030EA
	cmp r1,#0x2	; 038030EC
	bhi P2_Entry_038030FE	; 038030EE
	cmp r1,#0x0	; 038030F0
	beq P2_Entry_0380310E	; 038030F2
	cmp r1,#0x1	; 038030F4
	beq P2_Entry_03803184	; 038030F6
	cmp r1,#0x2	; 038030F8
	beq P2_Entry_038031F2	; 038030FA
	b P2_Entry_0380321E	; 038030FC
P2_Entry_038030FE:
	cmp r1,#0x10	; 038030FE
	beq P2_Entry_03803104	; 03803100
	b P2_Entry_0380321E	; 03803102
P2_Entry_03803104:
	ldr r0,[pool_03803228]	; 03803104
	ldr r0,[r0,#0x20]	; 03803106
	cmp r0,#0x2	; 03803108
	beq P2_Entry_0380310E	; 0380310A
	b P2_Entry_0380321E	; 0380310C
P2_Entry_0380310E:
	bl loc_037FDCE8	; 0380310E
	add r4,r0,#0x0	; 03803112
	mov r0,#0x0	; 03803114
	bl P2_Entry_03802E78	; 03803116
	cmp r0,#0x0	; 0380311A
	bne P2_Entry_03803132	; 0380311C
	add r0,r4,#0x0	; 0380311E
	bl loc_037FDD0C	; 03803120
	ldr r0,[r5,#0x4]	; 03803124
	lsl r0,r0,#0x10	; 03803126
	lsr r0,r0,#0x10	; 03803128
	mov r1,#0x4	; 0380312A
	bl loc_03802E8C	; 0380312C
	b P2_Entry_0380321E	; 03803130
P2_Entry_03803132:
	mov r0,#0x0	; 03803132
	bl loc_03802E68	; 03803134
	add r0,r4,#0x0	; 03803138
	bl loc_037FDD0C	; 0380313A
	add r0,sp,#0x4	; 0380313E
	ldr r2,[pool_03803228]	; 03803140
	ldr r1,[r2,#0x28]	; 03803142
	ldr r2,[r2,#0x24]	; 03803144
	bl P2_Entry_03803468	; 03803146
	add r0,sp,#0x4	; 0380314A
	ldrh r2,[r0,#0x0]	; 0380314C
	ldr r1,[pool_0380322C]	; 0380314E
	strh r2,[r1,#0x0]	; 03803150
	ldrh r1,[r0,#0x2]	; 03803152
	ldr r0,[pool_03803230]	; 03803154
	strh r1,[r0,#0x0]	; 03803156
	ldr r0,[r5,#0x4]	; 03803158
	cmp r0,#0x0	; 0380315A
	bne P2_Entry_0380316A	; 0380315C
	lsl r0,r0,#0x10	; 0380315E
	lsr r0,r0,#0x10	; 03803160
	mov r1,#0x0	; 03803162
	bl loc_03802E8C	; 03803164
	b P2_Entry_0380317C	; 03803168
P2_Entry_0380316A:
	lsl r0,r0,#0x10	; 0380316A
	lsr r0,r0,#0x10	; 0380316C
	ldr r2,[r5,#0x8]	; 0380316E
	mov r1,#0xff	; 03803170
	and r2,r1	; 03803172
	lsl r1,r2,#0x10	; 03803174
	lsr r1,r1,#0x10	; 03803176
	bl loc_03802E8C	; 03803178
P2_Entry_0380317C:
	mov r0,#0x0	; 0380317C
	bl P2_Entry_03802E40	; 0380317E
	b P2_Entry_0380321E	; 03803182
P2_Entry_03803184:
	ldr r0,[pool_03803228]	; 03803184
	ldr r0,[r0,#0x20]	; 03803186
	cmp r0,#0x1	; 03803188
	bne P2_Entry_038031E6	; 0380318A
	mov r4,#0x0	; 0380318C
	add r7,r4,#0x0	; 0380318E
	b P2_Entry_038031CC	; 03803190
P2_Entry_03803192:
	lsl r2,r4,#0x1	; 03803192
	ldr r0,[pool_03803228]	; 03803194
	add r6,r0,r2	; 03803196
	add r0,r4,#0x0	; 03803198
	ldr r2,[pool_03803234]	; 0380319A
	mul r0,r2	; 0380319C
	bl loc_03803244	; 0380319E
	ldr r1,[r5,#0xc]	; 038031A2
	add r0,r1,r0	; 038031A4
	ldr r1,[pool_03803234]	; 038031A6
	bl loc_03803244	; 038031A8
	add r0,r6,#0x0	; 038031AC
	add r0,#0xcc	; 038031AE
	strh r1,[r0,#0x0]	; 038031B0
	str r4,[sp,#0x0]	; 038031B2
	add r1,r4,#0x0	; 038031B4
	mov r0,#0x28	; 038031B6
	mul r1,r0	; 038031B8
	ldr r0,[pool_03803238]	; 038031BA
	add r0,r0,r1	; 038031BC
	mov r1,#0xcc	; 038031BE
	ldrsh r1,[r6,r1]	; 038031C0
	add r2,r7,#0x0	; 038031C2
	ldr r3,[pool_0380323C]	; 038031C4
	bl P2_Entry_037FEF44	; 038031C6
	add r4,r4,#0x1	; 038031CA
P2_Entry_038031CC:
	ldr r1,[r5,#0x8]	; 038031CC
	cmp r4,r1	; 038031CE
	bcc P2_Entry_03803192	; 038031D0
	ldr r0,[r5,#0x4]	; 038031D2
	lsl r0,r0,#0x10	; 038031D4
	lsr r0,r0,#0x10	; 038031D6
	mov r1,#0x0	; 038031D8
	bl loc_03802E8C	; 038031DA
	mov r1,#0x2	; 038031DE
	ldr r0,[pool_03803228]	; 038031E0
	str r1,[r0,#0x20]	; 038031E2
	b P2_Entry_0380321E	; 038031E4
P2_Entry_038031E6:
	lsl r0,r1,#0x10	; 038031E6
	lsr r0,r0,#0x10	; 038031E8
	mov r1,#0x3	; 038031EA
	bl loc_03802E8C	; 038031EC
	b P2_Entry_0380321E	; 038031F0
P2_Entry_038031F2:
	ldr r0,[pool_03803228]	; 038031F2
	ldr r0,[r0,#0x20]	; 038031F4
	cmp r0,#0x3	; 038031F6
	bne P2_Entry_03803214	; 038031F8
	ldr r0,[pool_03803240]	; 038031FA
	bl P2_Entry_037FEE50	; 038031FC
	ldr r0,[r5,#0x4]	; 03803200
	lsl r0,r0,#0x10	; 03803202
	lsr r0,r0,#0x10	; 03803204
	mov r1,#0x0	; 03803206
	bl loc_03802E8C	; 03803208
	mov r1,#0x0	; 0380320C
	ldr r0,[pool_03803228]	; 0380320E
	str r1,[r0,#0x20]	; 03803210
	b P2_Entry_0380321E	; 03803212
P2_Entry_03803214:
	lsl r0,r1,#0x10	; 03803214
	lsr r0,r0,#0x10	; 03803216
	mov r1,#0x3	; 03803218
	bl loc_03802E8C	; 0380321A
P2_Entry_0380321E:
	add sp,#0xc	; 0380321E
	pop {r4,r5,r6,r7}	; 03803220
	pop {r3}	; 03803222
	bx r3	; 03803224
	.byte 0xC0, 0x46	; 03803226
pool_03803228:
	.word P2_BssStart + 0x25A0	; 03803228
pool_0380322C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0380322C
pool_03803230:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 2	; 03803230
pool_03803234:
	.word 0x00000107	; 03803234
pool_03803238:
	.word 0x0380796C	; 03803238
pool_0380323C:
	.word 0x0380308D	; 0380323C
pool_03803240:
	.word 0x54505641	; 03803240

; ===== function loc_03803244 =====
loc_03803244:
	bx pc	; 03803244
	.byte 0xC0, 0x46	; 03803248
.arm

; ===== function loc_03803248 =====
loc_03803248:
	ldr pc,[pool_0380324C]	; 03803248
pool_0380324C:
loc_0380324C:
	.word loc_03804DB8	; 0380324C
.thumb

; ===== function loc_03803250 =====
loc_03803250:
	push {r4,lr}	; 03803250
	sub sp,#0x8	; 03803252
	ldr r1,[pool_03803370]	; 03803254
	add r2,r0,#0x0	; 03803256
	and r2,r1	; 03803258
	cmp r2,#0x0	; 0380325A
	beq loc_0380326E	; 0380325C
	mov r4,#0x0	; 0380325E
	add r3,r4,#0x0	; 03803260
	ldr r1,[pool_03803374]	; 03803262
loc_03803264:
	lsl r2,r4,#0x1	; 03803264
	strh r3,[r1,r2]	; 03803266
	add r4,r4,#0x1	; 03803268
	cmp r4,#0x10	; 0380326A
	blt loc_03803264	; 0380326C
loc_0380326E:
	ldr r1,[pool_03803378]	; 0380326E
	add r2,r0,#0x0	; 03803270
	and r2,r1	; 03803272
	lsr r1,r2,#0x10	; 03803274
	lsl r2,r1,#0x1	; 03803276
	ldr r1,[pool_03803374]	; 03803278
	strh r0,[r1,r2]	; 0380327A
	ldr r2,[pool_0380337C]	; 0380327C
	and r0,r2	; 0380327E
	cmp r0,#0x0	; 03803280
	beq loc_03803368	; 03803282
	ldrh r0,[r1,#0x0]	; 03803284
	ldr r2,[pool_03803380]	; 03803286
	add r3,r0,#0x0	; 03803288
	and r3,r2	; 0380328A
	lsl r2,r3,#0x8	; 0380328C
	lsr r4,r2,#0x10	; 0380328E
	cmp r4,#0x3	; 03803290
	bhi loc_03803360	; 03803292
	add r2,r4,r4	; 03803294
P2_SwitchIndexPC_03803294:
	add r2,pc	; 03803296
	ldrh r2,[r2,#(P2_SwitchTable_03803294 - (P2_SwitchIndexPC_03803294 + 4))]	; 03803298
	lsl r2,r2,#0x10	; 0380329A
	asr r2,r2,#0x10	; 0380329C
P2_SwitchTargetPC_03803294:
	add r2,pc	; 0380329E
	bx r2	; 038032A0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803294:
	.halfword (loc_038032BA + 1) - (P2_SwitchTargetPC_03803294 + 4)
	.halfword (loc_038032D2 + 1) - (P2_SwitchTargetPC_03803294 + 4)
	.halfword (loc_03803330 + 1) - (P2_SwitchTargetPC_03803294 + 4)
	.halfword (loc_038032AA + 1) - (P2_SwitchTargetPC_03803294 + 4)
P2_SwitchTable_03803294End:
loc_038032AA:
	mov r2,#0xff	; 038032AA
	and r0,r2	; 038032AC
	lsl r0,r0,#0x10	; 038032AE
	lsr r0,r0,#0x10	; 038032B0
	ldrh r1,[r1,#0x2]	; 038032B2
	bl loc_03803054	; 038032B4
	b loc_03803368	; 038032B8
loc_038032BA:
	mov r0,#0x0	; 038032BA
	add r1,r4,#0x0	; 038032BC
	add r2,r0,#0x0	; 038032BE
	bl loc_03802D98	; 038032C0
	cmp r0,#0x0	; 038032C4
	bne loc_03803368	; 038032C6
	add r0,r4,#0x0	; 038032C8
	mov r1,#0x4	; 038032CA
	bl loc_03802E8C	; 038032CC
	b loc_03803368	; 038032D0
loc_038032D2:
	ldr r2,[r1,#0x20]	; 038032D2
	cmp r2,#0x0	; 038032D4
	beq loc_038032E2	; 038032D6
	add r0,r4,#0x0	; 038032D8
	mov r1,#0x3	; 038032DA
	bl loc_03802E8C	; 038032DC
	b loc_03803368	; 038032E0
loc_038032E2:
	mov r2,#0xff	; 038032E2
	and r0,r2	; 038032E4
	lsl r0,r0,#0x10	; 038032E6
	lsr r3,r0,#0x10	; 038032E8
	cmp r3,#0x0	; 038032EA
	beq loc_038032F2	; 038032EC
	cmp r3,#0x4	; 038032EE
	bls loc_038032FC	; 038032F0
loc_038032F2:
	add r0,r4,#0x0	; 038032F2
	mov r1,#0x2	; 038032F4
	bl loc_03802E8C	; 038032F6
	b loc_03803368	; 038032FA
loc_038032FC:
	ldrh r1,[r1,#0x2]	; 038032FC
	ldr r0,[pool_03803384]	; 038032FE
	cmp r1,r0	; 03803300
	bcc loc_0380330E	; 03803302
	add r0,r4,#0x0	; 03803304
	mov r1,#0x2	; 03803306
	bl loc_03802E8C	; 03803308
	b loc_03803368	; 0380330C
loc_0380330E:
	str r1,[sp,#0x0]	; 0380330E
	mov r0,#0x0	; 03803310
	add r1,r4,#0x0	; 03803312
	mov r2,#0x2	; 03803314
	bl loc_03802D98	; 03803316
	cmp r0,#0x0	; 0380331A
	bne loc_03803328	; 0380331C
	add r0,r4,#0x0	; 0380331E
	mov r1,#0x4	; 03803320
	bl loc_03802E8C	; 03803322
	b loc_03803368	; 03803326
loc_03803328:
	mov r1,#0x1	; 03803328
	ldr r0,[pool_03803374]	; 0380332A
	str r1,[r0,#0x20]	; 0380332C
	b loc_03803368	; 0380332E
loc_03803330:
	ldr r0,[r1,#0x20]	; 03803330
	cmp r0,#0x2	; 03803332
	beq loc_03803340	; 03803334
	add r0,r4,#0x0	; 03803336
	mov r1,#0x3	; 03803338
	bl loc_03802E8C	; 0380333A
	b loc_03803368	; 0380333E
loc_03803340:
	mov r0,#0x0	; 03803340
	add r1,r4,#0x0	; 03803342
	add r2,r0,#0x0	; 03803344
	bl loc_03802D98	; 03803346
	cmp r0,#0x0	; 0380334A
	bne loc_03803358	; 0380334C
	add r0,r4,#0x0	; 0380334E
	mov r1,#0x4	; 03803350
	bl loc_03802E8C	; 03803352
	b loc_03803368	; 03803356
loc_03803358:
	mov r1,#0x3	; 03803358
	ldr r0,[pool_03803374]	; 0380335A
	str r1,[r0,#0x20]	; 0380335C
	b loc_03803368	; 0380335E
loc_03803360:
	add r0,r4,#0x0	; 03803360
	mov r1,#0x1	; 03803362
	bl loc_03802E8C	; 03803364
loc_03803368:
	add sp,#0x8	; 03803368
	pop {r4}	; 0380336A
	pop {r3}	; 0380336C
	bx r3	; 0380336E
pool_03803370:
loc_03803370:
	.word 0x02000000	; 03803370
pool_03803374:
loc_03803374:
	.word P2_BssStart + 0x25A0	; 03803374
pool_03803378:
loc_03803378:
	.word 0x000F0000	; 03803378
pool_0380337C:
loc_0380337C:
	.word 0x01000000	; 0380337C
pool_03803380:
loc_03803380:
	.word 0x0000FF00	; 03803380
pool_03803384:
loc_03803384:
	.word 0x00000107	; 03803384

; ===== function loc_03803388 =====
loc_03803388:
	push {r4,r5,r6,r7,lr}	; 03803388
	sub sp,#0x4	; 0380338A
	mov r3,#0x0	; 0380338C
	ldr r0,[pool_0380344C]	; 0380338E
	str r3,[r0,#0x20]	; 03803390
	mov r1,#0x1e	; 03803392
	str r1,[r0,#0x28]	; 03803394
	mov r1,#0x5	; 03803396
	str r1,[r0,#0x24]	; 03803398
	add r2,r3,#0x0	; 0380339A
loc_0380339C:
	lsl r1,r3,#0x1	; 0380339C
	strh r2,[r0,r1]	; 0380339E
	add r3,r3,#0x1	; 038033A0
	cmp r3,#0x10	; 038033A2
	blt loc_0380339C	; 038033A4
	bl loc_037FF0AC	; 038033A6
	cmp r0,#0x0	; 038033AA
	bne loc_038033B2	; 038033AC
	bl loc_037FF0B8	; 038033AE
loc_038033B2:
	mov r4,#0x0	; 038033B2
	ldr r6,[pool_03803450]	; 038033B4
	mov r7,#0x28	; 038033B6
loc_038033B8:
	add r0,r4,#0x0	; 038033B8
	mul r0,r7	; 038033BA
	add r5,r6,r0	; 038033BC
	add r0,r5,#0x0	; 038033BE
	bl loc_037FF004	; 038033C0
	add r0,r5,#0x0	; 038033C4
	ldr r1,[pool_03803454]	; 038033C6
	bl loc_037FEED8	; 038033C8
	add r4,r4,#0x1	; 038033CC
	cmp r4,#0x4	; 038033CE
	blt loc_038033B8	; 038033D0
	mov r6,#0x1	; 038033D2
	ldr r5,[pool_03803458]	; 038033D4
	mov r4,#0x80	; 038033D6
	b loc_038033E0	; 038033D8
loc_038033DA:
	add r0,r6,#0x0	; 038033DA
	bl loc_038048DC	; 038033DC
loc_038033E0:
	ldrh r0,[r5,#0x0]	; 038033E0
	and r0,r4	; 038033E2
	cmp r0,#0x0	; 038033E4
	bne loc_038033DA	; 038033E6
	ldr r0,[pool_0380345C]	; 038033E8
	strh r0,[r5,#0x0]	; 038033EA
	mov r1,#0x84	; 038033EC
	ldr r0,[pool_03803460]	; 038033EE
	strh r1,[r0,#0x0]	; 038033F0
	mov r6,#0x1	; 038033F2
	ldr r5,[pool_03803458]	; 038033F4
	mov r4,#0x80	; 038033F6
	b loc_03803400	; 038033F8
loc_038033FA:
	add r0,r6,#0x0	; 038033FA
	bl loc_038048DC	; 038033FC
loc_03803400:
	ldrh r0,[r5,#0x0]	; 03803400
	and r0,r4	; 03803402
	cmp r0,#0x0	; 03803404
	bne loc_038033FA	; 03803406
	mov r1,#0x0	; 03803408
	ldr r0,[pool_03803460]	; 0380340A
	strh r1,[r0,#0x0]	; 0380340C
	mov r6,#0x1	; 0380340E
	ldr r5,[pool_03803458]	; 03803410
	mov r4,#0x80	; 03803412
	b loc_0380341C	; 03803414
loc_03803416:
	add r0,r6,#0x0	; 03803416
	bl loc_038048DC	; 03803418
loc_0380341C:
	ldrh r0,[r5,#0x0]	; 0380341C
	and r0,r4	; 0380341E
	cmp r0,#0x0	; 03803420
	bne loc_03803416	; 03803422
	ldr r0,[pool_03803464]	; 03803424
	strh r0,[r5,#0x0]	; 03803426
	mov r1,#0x0	; 03803428
	ldr r0,[pool_03803460]	; 0380342A
	strh r1,[r0,#0x0]	; 0380342C
	mov r6,#0x1	; 0380342E
	ldr r5,[pool_03803458]	; 03803430
	mov r4,#0x80	; 03803432
	b loc_0380343C	; 03803434
loc_03803436:
	add r0,r6,#0x0	; 03803436
	bl loc_038048DC	; 03803438
loc_0380343C:
	ldrh r0,[r5,#0x0]	; 0380343C
	and r0,r4	; 0380343E
	cmp r0,#0x0	; 03803440
	bne loc_03803436	; 03803442
	add sp,#0x4	; 03803444
	pop {r4,r5,r6,r7}	; 03803446
	pop {r3}	; 03803448
	bx r3	; 0380344A
pool_0380344C:
loc_0380344C:
	.word P2_BssStart + 0x25A0	; 0380344C
pool_03803450:
loc_03803450:
	.word 0x0380796C	; 03803450
pool_03803454:
loc_03803454:
	.word 0x54505641	; 03803454
pool_03803458:
loc_03803458:
	.word REG_SPICNT	; 03803458
pool_0380345C:
loc_0380345C:
	.word 0x00008A01	; 0380345C
pool_03803460:
loc_03803460:
	.word REG_SPIDATA	; 03803460
pool_03803464:
loc_03803464:
	.word 0x00008201	; 03803464

; ===== function loc_03803468 =====
P2_Entry_03803468:
	push {r4,r5,r6,r7,lr}	; 03803468
	sub sp,#0x4	; 0380346A
	add r5,r0,#0x0	; 0380346C
	add r4,r1,#0x0	; 0380346E
	add r6,r2,#0x0	; 03803470
	cmp r4,#0x0	; 03803472
	bge loc_03803478	; 03803474
	neg r4,r4	; 03803476
loc_03803478:
	bl loc_0380381C	; 03803478
	add r7,r0,#0x0	; 0380347C
	cmp r7,#0x0	; 0380347E
	bne loc_038034AE	; 03803480
	ldr r1,[r5,#0x0]	; 03803482
	ldr r0,[pool_038035D0]	; 03803484
	and r1,r0	; 03803486
	str r1,[r5,#0x0]	; 03803488
	ldr r1,[r5,#0x0]	; 0380348A
	ldr r0,[pool_038035D4]	; 0380348C
	and r1,r0	; 0380348E
	str r1,[r5,#0x0]	; 03803490
	ldr r1,[r5,#0x0]	; 03803492
	ldr r0,[pool_038035D8]	; 03803494
	and r1,r0	; 03803496
	str r1,[r5,#0x0]	; 03803498
	ldr r1,[r5,#0x0]	; 0380349A
	ldr r0,[pool_038035DC]	; 0380349C
	and r1,r0	; 0380349E
	ldr r0,[pool_038035E0]	; 038034A0
	orr r1,r0	; 038034A2
	str r1,[r5,#0x0]	; 038034A4
	mov r1,#0x0	; 038034A6
	ldr r0,[pool_038035E4]	; 038034A8
	strh r1,[r0,#0x0]	; 038034AA
	b loc_038035C8	; 038034AC
loc_038034AE:
	add r0,sp,#0x0	; 038034AE
	add r1,r4,#0x0	; 038034B0
	add r2,r6,#0x0	; 038034B2
	mov r3,#0x0	; 038034B4
	bl loc_03803604	; 038034B6
	ldr r1,[r5,#0x0]	; 038034BA
	ldr r2,[pool_038035DC]	; 038034BC
	and r1,r2	; 038034BE
	mov r2,#0x3	; 038034C0
	and r0,r2	; 038034C2
	lsl r0,r0,#0x19	; 038034C4
	orr r1,r0	; 038034C6
	str r1,[r5,#0x0]	; 038034C8
	ldr r0,[r5,#0x0]	; 038034CA
	ldr r1,[pool_038035D0]	; 038034CC
	and r0,r1	; 038034CE
	add r1,sp,#0x0	; 038034D0
	ldrh r2,[r1,#0x0]	; 038034D2
	ldr r1,[pool_038035E8]	; 038034D4
	and r2,r1	; 038034D6
	orr r0,r2	; 038034D8
	str r0,[r5,#0x0]	; 038034DA
	add r0,sp,#0x0	; 038034DC
	add r1,r4,#0x0	; 038034DE
	add r2,r6,#0x0	; 038034E0
	mov r3,#0x1	; 038034E2
	bl loc_03803604	; 038034E4
	cmp r0,#0x2	; 038034E8
	bne loc_0380350C	; 038034EA
	ldr r1,[r5,#0x0]	; 038034EC
	lsl r0,r1,#0x5	; 038034EE
	lsr r0,r0,#0x1e	; 038034F0
	cmp r0,#0x1	; 038034F2
	bne loc_03803502	; 038034F4
	ldr r0,[pool_038035DC]	; 038034F6
	and r1,r0	; 038034F8
	ldr r0,[pool_038035E0]	; 038034FA
	orr r1,r0	; 038034FC
	str r1,[r5,#0x0]	; 038034FE
	b loc_0380350C	; 03803500
loc_03803502:
	ldr r0,[pool_038035DC]	; 03803502
	and r1,r0	; 03803504
	ldr r0,[pool_038035EC]	; 03803506
	orr r1,r0	; 03803508
	str r1,[r5,#0x0]	; 0380350A
loc_0380350C:
	ldr r0,[r5,#0x0]	; 0380350C
	ldr r1,[pool_038035D4]	; 0380350E
	and r0,r1	; 03803510
	add r1,sp,#0x0	; 03803512
	ldrh r2,[r1,#0x0]	; 03803514
	ldr r1,[pool_038035E8]	; 03803516
	and r2,r1	; 03803518
	lsl r1,r2,#0xc	; 0380351A
	orr r0,r1	; 0380351C
	str r0,[r5,#0x0]	; 0380351E
	ldr r1,[pool_038035F0]	; 03803520
	ldr r0,[pool_038035F4]	; 03803522
	strh r1,[r0,#0x0]	; 03803524
	mov r4,#0x0	; 03803526
	add r6,r4,#0x0	; 03803528
loc_0380352A:
	ldr r0,[pool_038035F8]	; 0380352A
	strh r6,[r0,#0x0]	; 0380352C
	b loc_03803536	; 0380352E
loc_03803530:
	mov r0,#0x1	; 03803530
	bl loc_038048DC	; 03803532
loc_03803536:
	ldr r0,[pool_038035F4]	; 03803536
	ldrh r1,[r0,#0x0]	; 03803538
	mov r0,#0x80	; 0380353A
	and r1,r0	; 0380353C
	cmp r1,#0x0	; 0380353E
	bne loc_03803530	; 03803540
	add r4,r4,#0x1	; 03803542
	cmp r4,#0xc	; 03803544
	blt loc_0380352A	; 03803546
	ldr r1,[pool_038035FC]	; 03803548
	ldr r0,[pool_038035F4]	; 0380354A
	strh r1,[r0,#0x0]	; 0380354C
	mov r1,#0x0	; 0380354E
	ldr r0,[pool_038035F8]	; 03803550
	strh r1,[r0,#0x0]	; 03803552
	ldr r4,[pool_038035F4]	; 03803554
	mov r6,#0x80	; 03803556
	b loc_03803560	; 03803558
loc_0380355A:
	mov r0,#0x1	; 0380355A
	bl loc_038048DC	; 0380355C
loc_03803560:
	ldrh r0,[r4,#0x0]	; 03803560
	and r0,r6	; 03803562
	cmp r0,#0x0	; 03803564
	bne loc_0380355A	; 03803566
	cmp r7,#0x2	; 03803568
	bne loc_03803578	; 0380356A
	ldr r1,[r5,#0x0]	; 0380356C
	ldr r0,[pool_038035DC]	; 0380356E
	and r1,r0	; 03803570
	ldr r0,[pool_038035E0]	; 03803572
	orr r1,r0	; 03803574
	str r1,[r5,#0x0]	; 03803576
loc_03803578:
	bl loc_0380381C	; 03803578
	cmp r0,#0x0	; 0380357C
	beq loc_038035B4	; 0380357E
	cmp r0,#0x1	; 03803580
	beq loc_038035A4	; 03803582
	cmp r0,#0x2	; 03803584
	bne loc_038035C4	; 03803586
	ldr r1,[r5,#0x0]	; 03803588
	ldr r0,[pool_03803600]	; 0380358A
	orr r1,r0	; 0380358C
	str r1,[r5,#0x0]	; 0380358E
	ldr r1,[r5,#0x0]	; 03803590
	ldr r0,[pool_038035DC]	; 03803592
	and r1,r0	; 03803594
	ldr r0,[pool_038035E0]	; 03803596
	orr r1,r0	; 03803598
	str r1,[r5,#0x0]	; 0380359A
	mov r1,#0x0	; 0380359C
	ldr r0,[pool_038035E4]	; 0380359E
	strh r1,[r0,#0x0]	; 038035A0
	b loc_038035C8	; 038035A2
loc_038035A4:
	ldr r1,[r5,#0x0]	; 038035A4
	ldr r0,[pool_03803600]	; 038035A6
	orr r1,r0	; 038035A8
	str r1,[r5,#0x0]	; 038035AA
	mov r1,#0x1	; 038035AC
	ldr r0,[pool_038035E4]	; 038035AE
	strh r1,[r0,#0x0]	; 038035B0
	b loc_038035C8	; 038035B2
loc_038035B4:
	ldr r1,[r5,#0x0]	; 038035B4
	ldr r0,[pool_038035D8]	; 038035B6
	and r1,r0	; 038035B8
	str r1,[r5,#0x0]	; 038035BA
	mov r1,#0x0	; 038035BC
	ldr r0,[pool_038035E4]	; 038035BE
	strh r1,[r0,#0x0]	; 038035C0
	b loc_038035C8	; 038035C2
loc_038035C4:
	bl loc_037FF1DC	; 038035C4
loc_038035C8:
	add sp,#0x4	; 038035C8
	pop {r4,r5,r6,r7}	; 038035CA
	pop {r3}	; 038035CC
	bx r3	; 038035CE
pool_038035D0:
loc_038035D0:
	.word 0xFFFFF000	; 038035D0
pool_038035D4:
loc_038035D4:
	.word 0xFF000FFF	; 038035D4
pool_038035D8:
loc_038035D8:
	.word 0xFEFFFFFF	; 038035D8
pool_038035DC:
loc_038035DC:
	.word 0xF9FFFFFF	; 038035DC
pool_038035E0:
loc_038035E0:
	.word 0x06000000	; 038035E0
pool_038035E4:
loc_038035E4:
	.word P2_BssStart + 0x2674	; 038035E4
pool_038035E8:
loc_038035E8:
	.word 0x00000FFF	; 038035E8
pool_038035EC:
loc_038035EC:
	.word REG_DISPCNT_A	; 038035EC
pool_038035F0:
loc_038035F0:
	.word 0x00008A01	; 038035F0
pool_038035F4:
loc_038035F4:
	.word REG_SPICNT	; 038035F4
pool_038035F8:
loc_038035F8:
	.word REG_SPIDATA	; 038035F8
pool_038035FC:
loc_038035FC:
	.word 0x00008201	; 038035FC
pool_03803600:
loc_03803600:
	.word 0x01000000	; 03803600

; ===== function loc_03803604 =====
loc_03803604:
	push {r4,r5,r6,r7,lr}	; 03803604
	sub sp,#0x24	; 03803606
	add r6,r0,#0x0	; 03803608
	str r1,[sp,#0x0]	; 0380360A
	str r2,[sp,#0x4]	; 0380360C
	cmp r3,#0x0	; 0380360E
	bne loc_03803618	; 03803610
	mov r4,#0xd1	; 03803612
	mov r7,#0x1	; 03803614
	b loc_03803624	; 03803616
loc_03803618:
	mov r4,#0x91	; 03803618
	mov r7,#0x2	; 0380361A
	b loc_03803624	; 0380361C
loc_0380361E:
	mov r0,#0x1	; 0380361E
	bl loc_038048DC	; 03803620
loc_03803624:
	ldr r5,[pool_03803808]	; 03803624
	ldrh r1,[r5,#0x0]	; 03803626
	mov r0,#0x80	; 03803628
	and r1,r0	; 0380362A
	cmp r1,#0x0	; 0380362C
	bne loc_0380361E	; 0380362E
	ldr r0,[pool_0380380C]	; 03803630
	strh r0,[r5,#0x0]	; 03803632
	mov r0,#0xff	; 03803634
	and r4,r0	; 03803636
	ldr r0,[pool_03803810]	; 03803638
	strh r4,[r0,#0x0]	; 0380363A
	b loc_03803644	; 0380363C
loc_0380363E:
	mov r0,#0x1	; 0380363E
	bl loc_038048DC	; 03803640
loc_03803644:
	ldrh r1,[r5,#0x0]	; 03803644
	mov r0,#0x80	; 03803646
	and r1,r0	; 03803648
	cmp r1,#0x0	; 0380364A
	bne loc_0380363E	; 0380364C
	mov r1,#0x0	; 0380364E
	ldr r0,[pool_03803810]	; 03803650
	strh r1,[r0,#0x0]	; 03803652
	ldr r5,[pool_03803808]	; 03803654
	b loc_0380365E	; 03803656
loc_03803658:
	mov r0,#0x1	; 03803658
	bl loc_038048DC	; 0380365A
loc_0380365E:
	ldrh r1,[r5,#0x0]	; 0380365E
	mov r0,#0x80	; 03803660
	and r1,r0	; 03803662
	cmp r1,#0x0	; 03803664
	bne loc_03803658	; 03803666
	ldr r1,[pool_03803810]	; 03803668
	ldrh r2,[r1,#0x0]	; 0380366A
	mov r0,#0xff	; 0380366C
	and r2,r0	; 0380366E
	lsl r0,r2,#0x10	; 03803670
	lsr r0,r0,#0x8	; 03803672
	str r0,[sp,#0x18]	; 03803674
	strh r4,[r1,#0x0]	; 03803676
	ldr r5,[pool_03803808]	; 03803678
	b loc_03803682	; 0380367A
loc_0380367C:
	mov r0,#0x1	; 0380367C
	bl loc_038048DC	; 0380367E
loc_03803682:
	ldrh r1,[r5,#0x0]	; 03803682
	mov r0,#0x80	; 03803684
	and r1,r0	; 03803686
	cmp r1,#0x0	; 03803688
	bne loc_0380367C	; 0380368A
	ldr r0,[pool_03803810]	; 0380368C
	ldrh r2,[r0,#0x0]	; 0380368E
	mov r1,#0xff	; 03803690
	and r2,r1	; 03803692
	lsl r1,r2,#0x10	; 03803694
	lsr r1,r1,#0x10	; 03803696
	ldr r2,[sp,#0x18]	; 03803698
	orr r2,r1	; 0380369A
	str r2,[sp,#0x18]	; 0380369C
	ldr r1,[pool_03803814]	; 0380369E
	and r2,r1	; 038036A0
	asr r1,r2,#0x3	; 038036A2
	str r1,[sp,#0x18]	; 038036A4
	mov r1,#0x0	; 038036A6
	strh r1,[r0,#0x0]	; 038036A8
	ldr r5,[pool_03803808]	; 038036AA
	b loc_038036B4	; 038036AC
loc_038036AE:
	mov r0,#0x1	; 038036AE
	bl loc_038048DC	; 038036B0
loc_038036B4:
	ldrh r1,[r5,#0x0]	; 038036B4
	mov r0,#0x80	; 038036B6
	and r1,r0	; 038036B8
	cmp r1,#0x0	; 038036BA
	bne loc_038036AE	; 038036BC
	ldr r1,[pool_03803810]	; 038036BE
	ldrh r2,[r1,#0x0]	; 038036C0
	mov r0,#0xff	; 038036C2
	and r2,r0	; 038036C4
	lsl r0,r2,#0x10	; 038036C6
	lsr r0,r0,#0x8	; 038036C8
	str r0,[sp,#0x1c]	; 038036CA
	strh r4,[r1,#0x0]	; 038036CC
	ldr r5,[pool_03803808]	; 038036CE
	b loc_038036D8	; 038036D0
loc_038036D2:
	mov r0,#0x1	; 038036D2
	bl loc_038048DC	; 038036D4
loc_038036D8:
	ldrh r1,[r5,#0x0]	; 038036D8
	mov r0,#0x80	; 038036DA
	and r1,r0	; 038036DC
	cmp r1,#0x0	; 038036DE
	bne loc_038036D2	; 038036E0
	ldr r0,[pool_03803810]	; 038036E2
	ldrh r1,[r0,#0x0]	; 038036E4
	mov r0,#0xff	; 038036E6
	and r1,r0	; 038036E8
	lsl r0,r1,#0x10	; 038036EA
	lsr r0,r0,#0x10	; 038036EC
	ldr r1,[sp,#0x1c]	; 038036EE
	orr r1,r0	; 038036F0
	str r1,[sp,#0x1c]	; 038036F2
	ldr r0,[pool_03803814]	; 038036F4
	and r1,r0	; 038036F6
	asr r1,r1,#0x3	; 038036F8
	str r1,[sp,#0x1c]	; 038036FA
	ldr r0,[sp,#0x4]	; 038036FC
	cmp r0,#0x0	; 038036FE
	bne loc_0380370C	; 03803700
	ldr r0,[sp,#0x18]	; 03803702
	add r0,r0,r1	; 03803704
	asr r0,r0,#0x1	; 03803706
	strh r0,[r6,#0x0]	; 03803708
	mov r7,#0x0	; 0380370A
loc_0380370C:
	mov r5,#0x0	; 0380370C
	ldr r0,[sp,#0x0]	; 0380370E
	neg r0,r0	; 03803710
	str r0,[sp,#0xc]	; 03803712
	str r5,[sp,#0x14]	; 03803714
	b loc_038037C2	; 03803716
loc_03803718:
	ldr r1,[sp,#0x14]	; 03803718
	ldr r0,[pool_03803810]	; 0380371A
	strh r1,[r0,#0x0]	; 0380371C
	b loc_03803726	; 0380371E
loc_03803720:
	mov r0,#0x1	; 03803720
	bl loc_038048DC	; 03803722
loc_03803726:
	ldr r0,[pool_03803808]	; 03803726
	ldrh r1,[r0,#0x0]	; 03803728
	mov r0,#0x80	; 0380372A
	and r1,r0	; 0380372C
	cmp r1,#0x0	; 0380372E
	bne loc_03803720	; 03803730
	ldr r0,[pool_03803810]	; 03803732
	ldrh r1,[r0,#0x0]	; 03803734
	mov r0,#0xff	; 03803736
	and r1,r0	; 03803738
	lsl r0,r1,#0x10	; 0380373A
	lsr r0,r0,#0x8	; 0380373C
	str r0,[sp,#0x8]	; 0380373E
	ldr r0,[pool_03803810]	; 03803740
	strh r4,[r0,#0x0]	; 03803742
	b loc_0380374C	; 03803744
loc_03803746:
	mov r0,#0x1	; 03803746
	bl loc_038048DC	; 03803748
loc_0380374C:
	ldr r0,[pool_03803808]	; 0380374C
	ldrh r1,[r0,#0x0]	; 0380374E
	mov r0,#0x80	; 03803750
	and r1,r0	; 03803752
	cmp r1,#0x0	; 03803754
	bne loc_03803746	; 03803756
	ldr r0,[pool_03803810]	; 03803758
	ldrh r1,[r0,#0x0]	; 0380375A
	mov r0,#0xff	; 0380375C
	and r1,r0	; 0380375E
	lsl r0,r1,#0x10	; 03803760
	lsr r0,r0,#0x10	; 03803762
	ldr r1,[sp,#0x8]	; 03803764
	orr r1,r0	; 03803766
	str r1,[sp,#0x8]	; 03803768
	ldr r0,[pool_03803814]	; 0380376A
	and r1,r0	; 0380376C
	str r1,[sp,#0x8]	; 0380376E
	asr r0,r1,#0x3	; 03803770
	str r0,[sp,#0x10]	; 03803772
	ldr r1,[sp,#0x18]	; 03803774
	sub r1,r1,r0	; 03803776
	ldr r0,[sp,#0xc]	; 03803778
	cmp r1,r0	; 0380377A
	blt loc_038037B0	; 0380377C
	ldr r0,[sp,#0x0]	; 0380377E
	cmp r1,r0	; 03803780
	bgt loc_038037B0	; 03803782
	ldr r1,[sp,#0x1c]	; 03803784
	ldr r0,[sp,#0x10]	; 03803786
	sub r1,r1,r0	; 03803788
	ldr r0,[sp,#0xc]	; 0380378A
	cmp r1,r0	; 0380378C
	blt loc_038037B0	; 0380378E
	ldr r0,[sp,#0x0]	; 03803790
	cmp r1,r0	; 03803792
	bgt loc_038037B0	; 03803794
	add r0,r5,#0x1	; 03803796
	mov r1,#0x2	; 03803798
	bl loc_037FE2FC	; 0380379A
	lsl r1,r1,#0x2	; 0380379E
	add r0,sp,#0x18	; 038037A0
	ldr r1,[r0,r1]	; 038037A2
	ldr r0,[sp,#0x10]	; 038037A4
	add r0,r0,r1	; 038037A6
	asr r0,r0,#0x1	; 038037A8
	strh r0,[r6,#0x0]	; 038037AA
	mov r7,#0x0	; 038037AC
	b loc_038037C8	; 038037AE
loc_038037B0:
	add r0,r5,#0x0	; 038037B0
	mov r1,#0x2	; 038037B2
	bl loc_037FE2FC	; 038037B4
	lsl r2,r1,#0x2	; 038037B8
	ldr r1,[sp,#0x10]	; 038037BA
	add r0,sp,#0x18	; 038037BC
	str r1,[r0,r2]	; 038037BE
	add r5,r5,#0x1	; 038037C0
loc_038037C2:
	ldr r0,[sp,#0x4]	; 038037C2
	cmp r5,r0	; 038037C4
	blt loc_03803718	; 038037C6
loc_038037C8:
	cmp r7,#0x0	; 038037C8
	beq loc_038037D6	; 038037CA
	ldr r1,[sp,#0x18]	; 038037CC
	ldr r0,[sp,#0x1c]	; 038037CE
	add r0,r1,r0	; 038037D0
	asr r0,r0,#0x1	; 038037D2
	strh r0,[r6,#0x0]	; 038037D4
loc_038037D6:
	ldr r0,[pool_03803818]	; 038037D6
	ldr r4,[pool_03803808]	; 038037D8
	strh r0,[r4,#0x0]	; 038037DA
	mov r1,#0x0	; 038037DC
	ldr r0,[pool_03803810]	; 038037DE
	strh r1,[r0,#0x0]	; 038037E0
	mov r5,#0x80	; 038037E2
	b loc_038037EC	; 038037E4
loc_038037E6:
	mov r0,#0x1	; 038037E6
	bl loc_038048DC	; 038037E8
loc_038037EC:
	ldrh r0,[r4,#0x0]	; 038037EC
	and r0,r5	; 038037EE
	cmp r0,#0x0	; 038037F0
	bne loc_038037E6	; 038037F2
	ldrh r1,[r6,#0x0]	; 038037F4
	mov r0,#0x7	; 038037F6
	bic r1,r0	; 038037F8
	strh r1,[r6,#0x0]	; 038037FA
	add r0,r7,#0x0	; 038037FC
	add sp,#0x24	; 038037FE
	pop {r4,r5,r6,r7}	; 03803800
	pop {r3}	; 03803802
	bx r3	; 03803804
	.byte 0xC0, 0x46	; 03803808
pool_03803808:
loc_03803808:
	.word REG_SPICNT	; 03803808
pool_0380380C:
loc_0380380C:
	.word 0x00008A01	; 0380380C
pool_03803810:
loc_03803810:
	.word REG_SPIDATA	; 03803810
pool_03803814:
loc_03803814:
	.word 0x00007FF8	; 03803814
pool_03803818:
loc_03803818:
	.word 0x00008201	; 03803818

; ===== function loc_0380381C =====
loc_0380381C:
	push {r4,r5,r6,lr}	; 0380381C
	ldr r0,[pool_03803938]	; 0380381E
	bl loc_0380214C	; 03803820
	mov r6,#0x1	; 03803824
	ldr r5,[pool_0380393C]	; 03803826
	mov r4,#0x80	; 03803828
	b loc_03803832	; 0380382A
loc_0380382C:
	add r0,r6,#0x0	; 0380382C
	bl loc_038048DC	; 0380382E
loc_03803832:
	ldrh r0,[r5,#0x0]	; 03803832
	and r0,r4	; 03803834
	cmp r0,#0x0	; 03803836
	bne loc_0380382C	; 03803838
	ldr r0,[pool_03803940]	; 0380383A
	strh r0,[r5,#0x0]	; 0380383C
	mov r1,#0x84	; 0380383E
	ldr r0,[pool_03803944]	; 03803840
	strh r1,[r0,#0x0]	; 03803842
	mov r6,#0x1	; 03803844
	ldr r5,[pool_0380393C]	; 03803846
	mov r4,#0x80	; 03803848
	b loc_03803852	; 0380384A
loc_0380384C:
	add r0,r6,#0x0	; 0380384C
	bl loc_038048DC	; 0380384E
loc_03803852:
	ldrh r0,[r5,#0x0]	; 03803852
	and r0,r4	; 03803854
	cmp r0,#0x0	; 03803856
	bne loc_0380384C	; 03803858
	mov r1,#0x0	; 0380385A
	ldr r0,[pool_03803944]	; 0380385C
	strh r1,[r0,#0x0]	; 0380385E
	mov r6,#0x1	; 03803860
	ldr r5,[pool_0380393C]	; 03803862
	mov r4,#0x80	; 03803864
	b loc_0380386E	; 03803866
loc_03803868:
	add r0,r6,#0x0	; 03803868
	bl loc_038048DC	; 0380386A
loc_0380386E:
	ldrh r0,[r5,#0x0]	; 0380386E
	and r0,r4	; 03803870
	cmp r0,#0x0	; 03803872
	bne loc_03803868	; 03803874
	ldr r0,[pool_03803948]	; 03803876
	strh r0,[r5,#0x0]	; 03803878
	mov r1,#0x0	; 0380387A
	ldr r0,[pool_03803944]	; 0380387C
	strh r1,[r0,#0x0]	; 0380387E
	mov r6,#0x1	; 03803880
	ldr r5,[pool_0380393C]	; 03803882
	mov r4,#0x80	; 03803884
	b loc_0380388E	; 03803886
loc_03803888:
	add r0,r6,#0x0	; 03803888
	bl loc_038048DC	; 0380388A
loc_0380388E:
	ldrh r0,[r5,#0x0]	; 0380388E
	and r0,r4	; 03803890
	cmp r0,#0x0	; 03803892
	bne loc_03803888	; 03803894
	ldr r0,[pool_0380394C]	; 03803896
	ldrh r0,[r0,#0x0]	; 03803898
	cmp r0,#0x0	; 0380389A
	bne loc_038038B2	; 0380389C
	ldr r0,[pool_03803950]	; 0380389E
	ldrh r1,[r0,#0x0]	; 038038A0
	mov r0,#0x40	; 038038A2
	and r1,r0	; 038038A4
	cmp r1,#0x0	; 038038A6
	bne loc_038038AE	; 038038A8
	mov r0,#0x1	; 038038AA
	b loc_03803930	; 038038AC
loc_038038AE:
	mov r0,#0x0	; 038038AE
	b loc_03803930	; 038038B0
loc_038038B2:
	ldr r0,[pool_03803950]	; 038038B2
	ldrh r1,[r0,#0x0]	; 038038B4
	mov r0,#0x40	; 038038B6
	and r1,r0	; 038038B8
	cmp r1,#0x0	; 038038BA
	bne loc_038038C2	; 038038BC
	mov r0,#0x1	; 038038BE
	b loc_03803930	; 038038C0
loc_038038C2:
	ldr r0,[pool_03803940]	; 038038C2
	strh r0,[r5,#0x0]	; 038038C4
	mov r1,#0x84	; 038038C6
	ldr r0,[pool_03803944]	; 038038C8
	strh r1,[r0,#0x0]	; 038038CA
	mov r6,#0x1	; 038038CC
	ldr r5,[pool_0380393C]	; 038038CE
	mov r4,#0x80	; 038038D0
	b loc_038038DA	; 038038D2
loc_038038D4:
	add r0,r6,#0x0	; 038038D4
	bl loc_038048DC	; 038038D6
loc_038038DA:
	ldrh r0,[r5,#0x0]	; 038038DA
	and r0,r4	; 038038DC
	cmp r0,#0x0	; 038038DE
	bne loc_038038D4	; 038038E0
	mov r1,#0x0	; 038038E2
	ldr r0,[pool_03803944]	; 038038E4
	strh r1,[r0,#0x0]	; 038038E6
	mov r6,#0x1	; 038038E8
	ldr r5,[pool_0380393C]	; 038038EA
	mov r4,#0x80	; 038038EC
	b loc_038038F6	; 038038EE
loc_038038F0:
	add r0,r6,#0x0	; 038038F0
	bl loc_038048DC	; 038038F2
loc_038038F6:
	ldrh r0,[r5,#0x0]	; 038038F6
	and r0,r4	; 038038F8
	cmp r0,#0x0	; 038038FA
	bne loc_038038F0	; 038038FC
	ldr r0,[pool_03803948]	; 038038FE
	strh r0,[r5,#0x0]	; 03803900
	mov r1,#0x0	; 03803902
	ldr r0,[pool_03803944]	; 03803904
	strh r1,[r0,#0x0]	; 03803906
	mov r6,#0x1	; 03803908
	ldr r5,[pool_0380393C]	; 0380390A
	mov r4,#0x80	; 0380390C
	b loc_03803916	; 0380390E
loc_03803910:
	add r0,r6,#0x0	; 03803910
	bl loc_038048DC	; 03803912
loc_03803916:
	ldrh r0,[r5,#0x0]	; 03803916
	and r0,r4	; 03803918
	cmp r0,#0x0	; 0380391A
	bne loc_03803910	; 0380391C
	ldr r0,[pool_03803950]	; 0380391E
	ldrh r1,[r0,#0x0]	; 03803920
	mov r0,#0x40	; 03803922
	and r1,r0	; 03803924
	cmp r1,#0x0	; 03803926
	beq loc_0380392E	; 03803928
	mov r0,#0x0	; 0380392A
	b loc_03803930	; 0380392C
loc_0380392E:
	mov r0,#0x2	; 0380392E
loc_03803930:
	pop {r4,r5,r6}	; 03803930
	pop {r3}	; 03803932
	bx r3	; 03803934
	.byte 0xC0, 0x46	; 03803938
pool_03803938:
loc_03803938:
	.word 0x00008000	; 03803938
pool_0380393C:
loc_0380393C:
	.word REG_SPICNT	; 0380393C
pool_03803940:
loc_03803940:
	.word 0x00008A01	; 03803940
pool_03803944:
loc_03803944:
	.word REG_SPIDATA	; 03803944
pool_03803948:
loc_03803948:
	.word 0x00008201	; 03803948
pool_0380394C:
loc_0380394C:
	.word P2_BssStart + 0x2674	; 0380394C
pool_03803950:
loc_03803950:
	.word REG_KEYXY	; 03803950
P2_Entry_03803954:
	push {lr}	; 03803954
	sub sp,#0x4	; 03803956
	add r0,sp,#0x0	; 03803958
	bl loc_03804058	; 0380395A
	add r0,sp,#0x0	; 0380395E
	ldrh r2,[r0,#0x0]	; 03803960
	mov r0,#0x1	; 03803962
	add r1,r2,#0x0	; 03803964
	and r1,r0	; 03803966
	cmp r1,#0x0	; 03803968
	beq P2_Entry_03803970	; 0380396A
	mov r0,#0x0	; 0380396C
	b P2_Entry_0380397A	; 0380396E
P2_Entry_03803970:
	mov r1,#0x2	; 03803970
	and r2,r1	; 03803972
	cmp r2,#0x0	; 03803974
	bne P2_Entry_0380397A	; 03803976
	mov r0,#0x0	; 03803978
P2_Entry_0380397A:
	add sp,#0x4	; 0380397A
	pop {r3}	; 0380397C
	bx r3	; 0380397E
P2_Entry_03803980:
	push {lr}	; 03803980
	sub sp,#0x4	; 03803982
	add r0,sp,#0x0	; 03803984
	bl loc_03804058	; 03803986
	add r0,sp,#0x0	; 0380398A
	ldrh r1,[r0,#0x0]	; 0380398C
	mov r0,#0x1	; 0380398E
	and r1,r0	; 03803990
	cmp r1,#0x0	; 03803992
	beq P2_Entry_03803998	; 03803994
	mov r0,#0x0	; 03803996
P2_Entry_03803998:
	add sp,#0x4	; 03803998
	pop {r3}	; 0380399A
	bx r3	; 0380399C
	.byte 0x00, 0x00	; 0380399E
P2_Entry_038039A0:
	push {r4,r5,lr}	; 038039A0
	sub sp,#0x4	; 038039A2
	add r4,r0,#0x0	; 038039A4
	bl loc_037FDCE8	; 038039A6
	add r5,r0,#0x0	; 038039AA
	mov r0,#0x1	; 038039AC
	bl P2_Entry_03802E78	; 038039AE
	cmp r0,#0x0	; 038039B2
	bne P2_Entry_038039CA	; 038039B4
	add r0,r5,#0x0	; 038039B6
	bl loc_037FDD0C	; 038039B8
	ldr r0,[r4,#0x4]	; 038039BC
	lsl r0,r0,#0x10	; 038039BE
	lsr r0,r0,#0x10	; 038039C0
	mov r1,#0x4	; 038039C2
	bl loc_03802E8C	; 038039C4
	b P2_Entry_03803AEA	; 038039C8
P2_Entry_038039CA:
	mov r0,#0x1	; 038039CA
	bl loc_03802E68	; 038039CC
	add r0,r5,#0x0	; 038039D0
	bl loc_037FDD0C	; 038039D2
	ldr r0,[r4,#0x4]	; 038039D6
	sub r0,#0x20	; 038039D8
	cmp r0,#0xd	; 038039DA
	bhi P2_Entry_03803AC4	; 038039DC
	add r0,r0,r0	; 038039DE
P2_SwitchIndexPC_038039DE:
	add r0,pc	; 038039E0
	ldrh r0,[r0,#(P2_SwitchTable_038039DE - (P2_SwitchIndexPC_038039DE + 4))]	; 038039E2
	lsl r0,r0,#0x10	; 038039E4
	asr r0,r0,#0x10	; 038039E6
P2_SwitchTargetPC_038039DE:
	add r0,pc	; 038039E8
	bx r0	; 038039EA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038039DE:
	.halfword (P2_Case_03803A08 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803A0E + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803A14 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803A1C + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Entry_03803AC4 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803A44 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Entry_03803AC4 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803A70 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Entry_03803AC4 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Entry_03803AC4 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Entry_03803AC4 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803A94 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803AB6 + 1) - (P2_SwitchTargetPC_038039DE + 4)
	.halfword (P2_Case_03803ABE + 1) - (P2_SwitchTargetPC_038039DE + 4)
P2_SwitchTable_038039DEEnd:
P2_Case_03803A08:
	bl P2_Entry_03804124	; 03803A08
	b P2_Entry_03803AD8	; 03803A0C
P2_Case_03803A0E:
	bl P2_Entry_038040D8	; 03803A0E
	b P2_Entry_03803AD8	; 03803A12
P2_Case_03803A14:
	ldr r0,[r4,#0x10]	; 03803A14
	bl loc_03804058	; 03803A16
	b P2_Entry_03803AD8	; 03803A1A
P2_Case_03803A1C:
	bl P2_Entry_03803980	; 03803A1C
	cmp r0,#0x0	; 03803A20
	bne P2_Entry_03803A38	; 03803A22
	ldr r0,[r4,#0x4]	; 03803A24
	lsl r0,r0,#0x10	; 03803A26
	lsr r0,r0,#0x10	; 03803A28
	mov r1,#0x3	; 03803A2A
	bl loc_03802E8C	; 03803A2C
	mov r0,#0x1	; 03803A30
	bl P2_Entry_03802E40	; 03803A32
	b P2_Entry_03803AEA	; 03803A36
P2_Entry_03803A38:
	ldr r0,[r4,#0x8]	; 03803A38
	ldr r1,[r4,#0xc]	; 03803A3A
	ldr r2,[r4,#0x10]	; 03803A3C
	bl loc_03803F5C	; 03803A3E
	b P2_Entry_03803AD8	; 03803A42
P2_Case_03803A44:
	bl P2_Entry_03803954	; 03803A44
	cmp r0,#0x0	; 03803A48
	bne P2_Entry_03803A60	; 03803A4A
	ldr r0,[r4,#0x4]	; 03803A4C
	lsl r0,r0,#0x10	; 03803A4E
	lsr r0,r0,#0x10	; 03803A50
	mov r1,#0x3	; 03803A52
	bl loc_03802E8C	; 03803A54
	mov r0,#0x1	; 03803A58
	bl P2_Entry_03802E40	; 03803A5A
	b P2_Entry_03803AEA	; 03803A5E
P2_Entry_03803A60:
	ldr r0,[r4,#0x8]	; 03803A60
	ldr r1,[r4,#0xc]	; 03803A62
	lsl r1,r1,#0x10	; 03803A64
	lsr r1,r1,#0x10	; 03803A66
	ldr r2,[r4,#0x10]	; 03803A68
	bl P2_Entry_03803E50	; 03803A6A
	b P2_Entry_03803AD8	; 03803A6E
P2_Case_03803A70:
	bl P2_Entry_03803954	; 03803A70
	cmp r0,#0x0	; 03803A74
	bne P2_Entry_03803A8C	; 03803A76
	ldr r0,[r4,#0x4]	; 03803A78
	lsl r0,r0,#0x10	; 03803A7A
	lsr r0,r0,#0x10	; 03803A7C
	mov r1,#0x3	; 03803A7E
	bl loc_03802E8C	; 03803A80
	mov r0,#0x1	; 03803A84
	bl P2_Entry_03802E40	; 03803A86
	b P2_Entry_03803AEA	; 03803A8A
P2_Entry_03803A8C:
	ldr r0,[r4,#0x8]	; 03803A8C
	bl P2_Entry_03803D80	; 03803A8E
	b P2_Entry_03803AD8	; 03803A92
P2_Case_03803A94:
	bl P2_Entry_03803954	; 03803A94
	cmp r0,#0x0	; 03803A98
	bne P2_Entry_03803AB0	; 03803A9A
	ldr r0,[r4,#0x4]	; 03803A9C
	lsl r0,r0,#0x10	; 03803A9E
	lsr r0,r0,#0x10	; 03803AA0
	mov r1,#0x3	; 03803AA2
	bl loc_03802E8C	; 03803AA4
	mov r0,#0x1	; 03803AA8
	bl P2_Entry_03802E40	; 03803AAA
	b P2_Entry_03803AEA	; 03803AAE
P2_Entry_03803AB0:
	bl P2_Entry_03803D34	; 03803AB0
	b P2_Entry_03803AD8	; 03803AB4
P2_Case_03803AB6:
	ldr r0,[r4,#0x10]	; 03803AB6
	bl P2_Entry_03803C90	; 03803AB8
	b P2_Entry_03803AD8	; 03803ABC
P2_Case_03803ABE:
	bl P2_Entry_03803C44	; 03803ABE
	b P2_Entry_03803AD8	; 03803AC2
P2_Entry_03803AC4:
	mov r0,#0x1	; 03803AC4
	bl P2_Entry_03802E40	; 03803AC6
	ldr r0,[r4,#0x4]	; 03803ACA
	lsl r0,r0,#0x10	; 03803ACC
	lsr r0,r0,#0x10	; 03803ACE
	mov r1,#0x1	; 03803AD0
	bl loc_03802E8C	; 03803AD2
	b P2_Entry_03803AEA	; 03803AD6
P2_Entry_03803AD8:
	ldr r0,[r4,#0x4]	; 03803AD8
	lsl r0,r0,#0x10	; 03803ADA
	lsr r0,r0,#0x10	; 03803ADC
	mov r1,#0x0	; 03803ADE
	bl loc_03802E8C	; 03803AE0
	mov r0,#0x1	; 03803AE4
	bl P2_Entry_03802E40	; 03803AE6
P2_Entry_03803AEA:
	add sp,#0x4	; 03803AEA
	pop {r4,r5}	; 03803AEC
	pop {r3}	; 03803AEE
	bx r3	; 03803AF0
	.byte 0x00, 0x00	; 03803AF2

; ===== function loc_03803AF4 =====
loc_03803AF4:
	push {r4,r5,r6,r7,lr}	; 03803AF4
	sub sp,#0xc	; 03803AF6
	ldr r1,[pool_03803C14]	; 03803AF8
	add r5,r0,#0x0	; 03803AFA
	and r5,r1	; 03803AFC
	cmp r5,#0x0	; 03803AFE
	beq loc_03803B12	; 03803B00
	mov r5,#0x0	; 03803B02
	add r6,r5,#0x0	; 03803B04
	ldr r7,[pool_03803C18]	; 03803B06
loc_03803B08:
	lsl r1,r5,#0x1	; 03803B08
	strh r6,[r7,r1]	; 03803B0A
	add r5,r5,#0x1	; 03803B0C
	cmp r5,#0x10	; 03803B0E
	blt loc_03803B08	; 03803B10
loc_03803B12:
	ldr r1,[pool_03803C1C]	; 03803B12
	add r5,r0,#0x0	; 03803B14
	and r5,r1	; 03803B16
	lsr r1,r5,#0x10	; 03803B18
	lsl r5,r1,#0x1	; 03803B1A
	ldr r1,[pool_03803C18]	; 03803B1C
	strh r0,[r1,r5]	; 03803B1E
	ldr r5,[pool_03803C20]	; 03803B20
	and r0,r5	; 03803B22
	cmp r0,#0x0	; 03803B24
	beq loc_03803C0C	; 03803B26
	ldrh r0,[r1,#0x0]	; 03803B28
	ldr r7,[pool_03803C24]	; 03803B2A
	add r5,r0,#0x0	; 03803B2C
	and r5,r7	; 03803B2E
	lsl r5,r5,#0x8	; 03803B30
	lsr r6,r5,#0x10	; 03803B32
	add r5,r6,#0x0	; 03803B34
	sub r5,#0x22	; 03803B36
	cmp r5,#0xa	; 03803B38
	bhi loc_03803BF2	; 03803B3A
	add r5,r5,r5	; 03803B3C
P2_SwitchIndexPC_03803B3C:
	add r5,pc	; 03803B3E
	ldrh r5,[r5,#(P2_SwitchTable_03803B3C - (P2_SwitchIndexPC_03803B3C + 4))]	; 03803B40
	lsl r5,r5,#0x10	; 03803B42
	asr r5,r5,#0x10	; 03803B44
P2_SwitchTargetPC_03803B3C:
	add r5,pc	; 03803B46
	bx r5	; 03803B48
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803B3C:
	.halfword (loc_03803B60 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803B8A + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BF2 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BBC + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BF2 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BE8 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BF2 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BF2 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BF2 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803BF2 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
	.halfword (loc_03803B60 + 1) - (P2_SwitchTargetPC_03803B3C + 4)
P2_SwitchTable_03803B3CEnd:
loc_03803B60:
	ldrh r4,[r1,#0x4]	; 03803B60
	and r4,r7	; 03803B62
	lsr r4,r4,#0x8	; 03803B64
	mov r5,#0xff	; 03803B66
	and r0,r5	; 03803B68
	lsl r0,r0,#0x18	; 03803B6A
	ldrh r1,[r1,#0x2]	; 03803B6C
	lsl r1,r1,#0x8	; 03803B6E
	orr r0,r1	; 03803B70
	orr r4,r0	; 03803B72
	ldr r0,[pool_03803C14]	; 03803B74
	cmp r4,r0	; 03803B76
	bcc loc_03803B80	; 03803B78
	ldr r0,[pool_03803C28]	; 03803B7A
	cmp r4,r0	; 03803B7C
	bcc loc_03803BF2	; 03803B7E
loc_03803B80:
	add r0,r6,#0x0	; 03803B80
	mov r1,#0x2	; 03803B82
	bl loc_03802E8C	; 03803B84
	b loc_03803C0C	; 03803B88
loc_03803B8A:
	ldrh r2,[r1,#0x8]	; 03803B8A
	lsl r4,r2,#0x10	; 03803B8C
	ldrh r2,[r1,#0xa]	; 03803B8E
	orr r4,r2	; 03803B90
	ldr r2,[pool_03803C14]	; 03803B92
	cmp r4,r2	; 03803B94
	bcc loc_03803B9E	; 03803B96
	ldr r2,[pool_03803C28]	; 03803B98
	cmp r4,r2	; 03803B9A
	bcc loc_03803BA8	; 03803B9C
loc_03803B9E:
	add r0,r6,#0x0	; 03803B9E
	mov r1,#0x2	; 03803BA0
	bl loc_03802E8C	; 03803BA2
	b loc_03803C0C	; 03803BA6
loc_03803BA8:
	mov r2,#0xff	; 03803BA8
	and r0,r2	; 03803BAA
	lsl r3,r0,#0x10	; 03803BAC
	ldrh r0,[r1,#0x2]	; 03803BAE
	orr r3,r0	; 03803BB0
	ldrh r0,[r1,#0x4]	; 03803BB2
	lsl r2,r0,#0x10	; 03803BB4
	ldrh r0,[r1,#0x6]	; 03803BB6
	orr r2,r0	; 03803BB8
	b loc_03803BF2	; 03803BBA
loc_03803BBC:
	ldrh r2,[r1,#0x6]	; 03803BBC
	lsl r4,r2,#0x10	; 03803BBE
	ldrh r2,[r1,#0x8]	; 03803BC0
	orr r4,r2	; 03803BC2
	ldr r2,[pool_03803C14]	; 03803BC4
	cmp r4,r2	; 03803BC6
	bcc loc_03803BD0	; 03803BC8
	ldr r2,[pool_03803C28]	; 03803BCA
	cmp r4,r2	; 03803BCC
	bcc loc_03803BDA	; 03803BCE
loc_03803BD0:
	add r0,r6,#0x0	; 03803BD0
	mov r1,#0x2	; 03803BD2
	bl loc_03802E8C	; 03803BD4
	b loc_03803C0C	; 03803BD8
loc_03803BDA:
	mov r2,#0xff	; 03803BDA
	and r0,r2	; 03803BDC
	lsl r3,r0,#0x10	; 03803BDE
	ldrh r0,[r1,#0x2]	; 03803BE0
	orr r3,r0	; 03803BE2
	ldrh r2,[r1,#0x4]	; 03803BE4
	b loc_03803BF2	; 03803BE6
loc_03803BE8:
	mov r3,#0xff	; 03803BE8
	and r0,r3	; 03803BEA
	lsl r3,r0,#0x10	; 03803BEC
	ldrh r0,[r1,#0x2]	; 03803BEE
	orr r3,r0	; 03803BF0
loc_03803BF2:
	str r2,[sp,#0x0]	; 03803BF2
	str r4,[sp,#0x4]	; 03803BF4
	mov r0,#0x1	; 03803BF6
	add r1,r6,#0x0	; 03803BF8
	mov r2,#0x3	; 03803BFA
	bl loc_03802D98	; 03803BFC
	cmp r0,#0x0	; 03803C00
	bne loc_03803C0C	; 03803C02
	add r0,r6,#0x0	; 03803C04
	mov r1,#0x4	; 03803C06
	bl loc_03802E8C	; 03803C08
loc_03803C0C:
	add sp,#0xc	; 03803C0C
	pop {r4,r5,r6,r7}	; 03803C0E
	pop {r3}	; 03803C10
	bx r3	; 03803C12
pool_03803C14:
loc_03803C14:
	.word 0x02000000	; 03803C14
pool_03803C18:
loc_03803C18:
	.word P2_BssStart + 0x2678	; 03803C18
pool_03803C1C:
loc_03803C1C:
	.word 0x000F0000	; 03803C1C
pool_03803C20:
loc_03803C20:
	.word 0x01000000	; 03803C20
pool_03803C24:
loc_03803C24:
	.word 0x0000FF00	; 03803C24
pool_03803C28:
loc_03803C28:
	.word 0x02400000	; 03803C28

; ===== function loc_03803C2C =====
loc_03803C2C:
	mov r3,#0x0	; 03803C2C
	add r2,r3,#0x0	; 03803C2E
	ldr r0,[pool_03803C40]	; 03803C30
loc_03803C32:
	lsl r1,r3,#0x1	; 03803C32
	strh r2,[r0,r1]	; 03803C34
	add r3,r3,#0x1	; 03803C36
	cmp r3,#0x10	; 03803C38
	blt loc_03803C32	; 03803C3A
	bx lr	; 03803C3C
	.byte 0xC0, 0x46	; 03803C40
pool_03803C40:
loc_03803C40:
	.word P2_BssStart + 0x2678	; 03803C40
P2_Entry_03803C44:
	push {r4,r5,r6,lr}	; 03803C44
	mov r6,#0x1	; 03803C46
	ldr r5,[pool_03803C84]	; 03803C48
	mov r4,#0x80	; 03803C4A
	b P2_Entry_03803C54	; 03803C4C
P2_Entry_03803C4E:
	add r0,r6,#0x0	; 03803C4E
	bl P2_SwiWaitByLoop	; 03803C50
P2_Entry_03803C54:
	ldrh r0,[r5,#0x0]	; 03803C54
	and r0,r4	; 03803C56
	cmp r0,#0x0	; 03803C58
	bne P2_Entry_03803C4E	; 03803C5A
	ldr r0,[pool_03803C88]	; 03803C5C
	strh r0,[r5,#0x0]	; 03803C5E
	mov r1,#0xff	; 03803C60
	ldr r0,[pool_03803C8C]	; 03803C62
	strh r1,[r0,#0x0]	; 03803C64
	mov r6,#0x1	; 03803C66
	ldr r5,[pool_03803C84]	; 03803C68
	mov r4,#0x80	; 03803C6A
	b P2_Entry_03803C74	; 03803C6C
P2_Entry_03803C6E:
	add r0,r6,#0x0	; 03803C6E
	bl P2_SwiWaitByLoop	; 03803C70
P2_Entry_03803C74:
	ldrh r0,[r5,#0x0]	; 03803C74
	and r0,r4	; 03803C76
	cmp r0,#0x0	; 03803C78
	bne P2_Entry_03803C6E	; 03803C7A
	pop {r4,r5,r6}	; 03803C7C
	pop {r3}	; 03803C7E
	bx r3	; 03803C80
	.byte 0xC0, 0x46	; 03803C82
pool_03803C84:
	.word 0x040001C0	; 03803C84
pool_03803C88:
	.word 0x00008100	; 03803C88
pool_03803C8C:
	.word REG_SPIDATA	; 03803C8C
P2_Entry_03803C90:
	push {r4,r5,r6,r7,lr}	; 03803C90
	sub sp,#0x4	; 03803C92
	add r5,r0,#0x0	; 03803C94
	mov r7,#0x1	; 03803C96
	ldr r4,[pool_03803D24]	; 03803C98
	mov r6,#0x80	; 03803C9A
	b P2_Entry_03803CA4	; 03803C9C
P2_Entry_03803C9E:
	add r0,r7,#0x0	; 03803C9E
	bl P2_SwiWaitByLoop	; 03803CA0
P2_Entry_03803CA4:
	ldrh r0,[r4,#0x0]	; 03803CA4
	and r0,r6	; 03803CA6
	cmp r0,#0x0	; 03803CA8
	bne P2_Entry_03803C9E	; 03803CAA
	ldr r0,[pool_03803D28]	; 03803CAC
	strh r0,[r4,#0x0]	; 03803CAE
	mov r1,#0x9f	; 03803CB0
	ldr r0,[pool_03803D2C]	; 03803CB2
	strh r1,[r0,#0x0]	; 03803CB4
	mov r7,#0x1	; 03803CB6
	ldr r4,[pool_03803D24]	; 03803CB8
	mov r6,#0x80	; 03803CBA
	b P2_Entry_03803CC4	; 03803CBC
P2_Entry_03803CBE:
	add r0,r7,#0x0	; 03803CBE
	bl P2_SwiWaitByLoop	; 03803CC0
P2_Entry_03803CC4:
	ldrh r0,[r4,#0x0]	; 03803CC4
	and r0,r6	; 03803CC6
	cmp r0,#0x0	; 03803CC8
	bne P2_Entry_03803CBE	; 03803CCA
	mov r1,#0x0	; 03803CCC
	ldr r0,[pool_03803D2C]	; 03803CCE
	strh r1,[r0,#0x0]	; 03803CD0
	mov r7,#0x1	; 03803CD2
	ldr r4,[pool_03803D24]	; 03803CD4
	mov r6,#0x80	; 03803CD6
	b P2_Entry_03803CE0	; 03803CD8
P2_Entry_03803CDA:
	add r0,r7,#0x0	; 03803CDA
	bl P2_SwiWaitByLoop	; 03803CDC
P2_Entry_03803CE0:
	ldrh r0,[r4,#0x0]	; 03803CE0
	and r0,r6	; 03803CE2
	cmp r0,#0x0	; 03803CE4
	bne P2_Entry_03803CDA	; 03803CE6
	ldr r1,[pool_03803D2C]	; 03803CE8
	ldrh r2,[r1,#0x0]	; 03803CEA
	mov r0,#0xff	; 03803CEC
	and r2,r0	; 03803CEE
	strb r2,[r5,#0x0]	; 03803CF0
	ldr r0,[pool_03803D30]	; 03803CF2
	strh r0,[r4,#0x0]	; 03803CF4
	mov r0,#0x0	; 03803CF6
	strh r0,[r1,#0x0]	; 03803CF8
	mov r7,#0x1	; 03803CFA
	ldr r4,[pool_03803D24]	; 03803CFC
	mov r6,#0x80	; 03803CFE
	b P2_Entry_03803D08	; 03803D00
P2_Entry_03803D02:
	add r0,r7,#0x0	; 03803D02
	bl P2_SwiWaitByLoop	; 03803D04
P2_Entry_03803D08:
	ldrh r0,[r4,#0x0]	; 03803D08
	and r0,r6	; 03803D0A
	cmp r0,#0x0	; 03803D0C
	bne P2_Entry_03803D02	; 03803D0E
	ldr r0,[pool_03803D2C]	; 03803D10
	ldrh r1,[r0,#0x0]	; 03803D12
	mov r0,#0xff	; 03803D14
	and r1,r0	; 03803D16
	strb r1,[r5,#0x1]	; 03803D18
	add sp,#0x4	; 03803D1A
	pop {r4,r5,r6,r7}	; 03803D1C
	pop {r3}	; 03803D1E
	bx r3	; 03803D20
	.byte 0xC0, 0x46	; 03803D22
pool_03803D24:
	.word 0x040001C0	; 03803D24
pool_03803D28:
	.word 0x00008900	; 03803D28
pool_03803D2C:
	.word REG_SPIDATA	; 03803D2C
pool_03803D30:
	.word 0x00008100	; 03803D30
P2_Entry_03803D34:
	push {r4,r5,r6,lr}	; 03803D34
	mov r6,#0x1	; 03803D36
	ldr r5,[pool_03803D74]	; 03803D38
	mov r4,#0x80	; 03803D3A
	b P2_Entry_03803D44	; 03803D3C
P2_Entry_03803D3E:
	add r0,r6,#0x0	; 03803D3E
	bl P2_SwiWaitByLoop	; 03803D40
P2_Entry_03803D44:
	ldrh r0,[r5,#0x0]	; 03803D44
	and r0,r4	; 03803D46
	cmp r0,#0x0	; 03803D48
	bne P2_Entry_03803D3E	; 03803D4A
	ldr r0,[pool_03803D78]	; 03803D4C
	strh r0,[r5,#0x0]	; 03803D4E
	mov r1,#0xc7	; 03803D50
	ldr r0,[pool_03803D7C]	; 03803D52
	strh r1,[r0,#0x0]	; 03803D54
	mov r6,#0x1	; 03803D56
	ldr r5,[pool_03803D74]	; 03803D58
	mov r4,#0x80	; 03803D5A
	b P2_Entry_03803D64	; 03803D5C
P2_Entry_03803D5E:
	add r0,r6,#0x0	; 03803D5E
	bl P2_SwiWaitByLoop	; 03803D60
P2_Entry_03803D64:
	ldrh r0,[r5,#0x0]	; 03803D64
	and r0,r4	; 03803D66
	cmp r0,#0x0	; 03803D68
	bne P2_Entry_03803D5E	; 03803D6A
	pop {r4,r5,r6}	; 03803D6C
	pop {r3}	; 03803D6E
	bx r3	; 03803D70
	.byte 0xC0, 0x46	; 03803D72
pool_03803D74:
	.word 0x040001C0	; 03803D74
pool_03803D78:
	.word 0x00008100	; 03803D78
pool_03803D7C:
	.word REG_SPIDATA	; 03803D7C
P2_Entry_03803D80:
	push {r4,r5,r6,r7,lr}	; 03803D80
	sub sp,#0x4	; 03803D82
	ldr r1,[pool_03803E38]	; 03803D84
	add r2,r0,#0x0	; 03803D86
	and r2,r1	; 03803D88
	lsr r1,r2,#0x10	; 03803D8A
	lsl r1,r1,#0x10	; 03803D8C
	lsr r5,r1,#0x10	; 03803D8E
	ldr r1,[pool_03803E3C]	; 03803D90
	add r2,r0,#0x0	; 03803D92
	and r2,r1	; 03803D94
	lsl r1,r2,#0x8	; 03803D96
	lsr r4,r1,#0x10	; 03803D98
	mov r1,#0xff	; 03803D9A
	and r0,r1	; 03803D9C
	lsl r0,r0,#0x10	; 03803D9E
	lsr r6,r0,#0x10	; 03803DA0
	ldr r7,[pool_03803E40]	; 03803DA2
	b P2_Entry_03803DAC	; 03803DA4
P2_Entry_03803DA6:
	mov r0,#0x1	; 03803DA6
	bl P2_SwiWaitByLoop	; 03803DA8
P2_Entry_03803DAC:
	ldrh r1,[r7,#0x0]	; 03803DAC
	mov r0,#0x80	; 03803DAE
	and r1,r0	; 03803DB0
	cmp r1,#0x0	; 03803DB2
	bne P2_Entry_03803DA6	; 03803DB4
	ldr r0,[pool_03803E44]	; 03803DB6
	strh r0,[r7,#0x0]	; 03803DB8
	mov r1,#0xdb	; 03803DBA
	ldr r0,[pool_03803E48]	; 03803DBC
	strh r1,[r0,#0x0]	; 03803DBE
	ldr r7,[pool_03803E40]	; 03803DC0
	b P2_Entry_03803DCA	; 03803DC2
P2_Entry_03803DC4:
	mov r0,#0x1	; 03803DC4
	bl P2_SwiWaitByLoop	; 03803DC6
P2_Entry_03803DCA:
	ldrh r1,[r7,#0x0]	; 03803DCA
	mov r0,#0x80	; 03803DCC
	and r1,r0	; 03803DCE
	cmp r1,#0x0	; 03803DD0
	bne P2_Entry_03803DC4	; 03803DD2
	mov r0,#0xff	; 03803DD4
	and r5,r0	; 03803DD6
	ldr r0,[pool_03803E48]	; 03803DD8
	strh r5,[r0,#0x0]	; 03803DDA
	ldr r5,[pool_03803E40]	; 03803DDC
	mov r7,#0x80	; 03803DDE
	b P2_Entry_03803DE8	; 03803DE0
P2_Entry_03803DE2:
	mov r0,#0x1	; 03803DE2
	bl P2_SwiWaitByLoop	; 03803DE4
P2_Entry_03803DE8:
	ldrh r0,[r5,#0x0]	; 03803DE8
	and r0,r7	; 03803DEA
	cmp r0,#0x0	; 03803DEC
	bne P2_Entry_03803DE2	; 03803DEE
	mov r0,#0xff	; 03803DF0
	and r4,r0	; 03803DF2
	ldr r0,[pool_03803E48]	; 03803DF4
	strh r4,[r0,#0x0]	; 03803DF6
	mov r7,#0x1	; 03803DF8
	ldr r4,[pool_03803E40]	; 03803DFA
	mov r5,#0x80	; 03803DFC
	b P2_Entry_03803E06	; 03803DFE
P2_Entry_03803E00:
	add r0,r7,#0x0	; 03803E00
	bl P2_SwiWaitByLoop	; 03803E02
P2_Entry_03803E06:
	ldrh r0,[r4,#0x0]	; 03803E06
	and r0,r5	; 03803E08
	cmp r0,#0x0	; 03803E0A
	bne P2_Entry_03803E00	; 03803E0C
	ldr r0,[pool_03803E4C]	; 03803E0E
	strh r0,[r4,#0x0]	; 03803E10
	mov r0,#0xff	; 03803E12
	and r6,r0	; 03803E14
	ldr r0,[pool_03803E48]	; 03803E16
	strh r6,[r0,#0x0]	; 03803E18
	mov r6,#0x1	; 03803E1A
	ldr r5,[pool_03803E40]	; 03803E1C
	mov r4,#0x80	; 03803E1E
	b P2_Entry_03803E28	; 03803E20
P2_Entry_03803E22:
	add r0,r6,#0x0	; 03803E22
	bl P2_SwiWaitByLoop	; 03803E24
P2_Entry_03803E28:
	ldrh r0,[r5,#0x0]	; 03803E28
	and r0,r4	; 03803E2A
	cmp r0,#0x0	; 03803E2C
	bne P2_Entry_03803E22	; 03803E2E
	add sp,#0x4	; 03803E30
	pop {r4,r5,r6,r7}	; 03803E32
	pop {r3}	; 03803E34
	bx r3	; 03803E36
pool_03803E38:
	.word 0x00FF0000	; 03803E38
pool_03803E3C:
	.word 0x0000FF00	; 03803E3C
pool_03803E40:
	.word 0x040001C0	; 03803E40
pool_03803E44:
	.word 0x00008900	; 03803E44
pool_03803E48:
	.word REG_SPIDATA	; 03803E48
pool_03803E4C:
	.word 0x00008100	; 03803E4C
P2_Entry_03803E50:
	push {r4,r5,r6,r7,lr}	; 03803E50
	sub sp,#0xc	; 03803E52
	add r4,r1,#0x0	; 03803E54
	add r6,r2,#0x0	; 03803E56
	cmp r4,#0x1	; 03803E58
	bcc P2_Entry_03803F38	; 03803E5A
	add r1,r0,r4	; 03803E5C
	sub r1,r1,#0x1	; 03803E5E
	lsr r2,r1,#0x8	; 03803E60
	lsr r1,r0,#0x8	; 03803E62
	cmp r2,r1	; 03803E64
	bls P2_Entry_03803E76	; 03803E66
	mov r1,#0xff	; 03803E68
	add r2,r0,#0x0	; 03803E6A
	and r2,r1	; 03803E6C
	ldr r1,[pool_03803F40]	; 03803E6E
	sub r1,r1,r2	; 03803E70
	lsl r1,r1,#0x10	; 03803E72
	lsr r4,r1,#0x10	; 03803E74
P2_Entry_03803E76:
	ldr r1,[pool_03803F44]	; 03803E76
	add r2,r0,#0x0	; 03803E78
	and r2,r1	; 03803E7A
	lsr r1,r2,#0x10	; 03803E7C
	add r2,sp,#0x0	; 03803E7E
	strh r1,[r2,#0x0]	; 03803E80
	ldr r1,[pool_03803F48]	; 03803E82
	add r3,r0,#0x0	; 03803E84
	and r3,r1	; 03803E86
	lsr r1,r3,#0x8	; 03803E88
	strh r1,[r2,#0x2]	; 03803E8A
	mov r1,#0xff	; 03803E8C
	and r0,r1	; 03803E8E
	strh r0,[r2,#0x4]	; 03803E90
	ldr r5,[pool_03803F4C]	; 03803E92
	mov r7,#0x80	; 03803E94
	b P2_Entry_03803E9E	; 03803E96
P2_Entry_03803E98:
	mov r0,#0x1	; 03803E98
	bl P2_SwiWaitByLoop	; 03803E9A
P2_Entry_03803E9E:
	ldrh r0,[r5,#0x0]	; 03803E9E
	and r0,r7	; 03803EA0
	cmp r0,#0x0	; 03803EA2
	bne P2_Entry_03803E98	; 03803EA4
	ldr r0,[pool_03803F50]	; 03803EA6
	strh r0,[r5,#0x0]	; 03803EA8
	mov r0,#0xa	; 03803EAA
	ldr r7,[pool_03803F54]	; 03803EAC
	strh r0,[r7,#0x0]	; 03803EAE
	mov r5,#0x0	; 03803EB0
	b P2_Entry_03803ED4	; 03803EB2
P2_Entry_03803EB4:
	mov r0,#0x1	; 03803EB4
	bl P2_SwiWaitByLoop	; 03803EB6
P2_Entry_03803EBA:
	ldr r0,[pool_03803F4C]	; 03803EBA
	ldrh r1,[r0,#0x0]	; 03803EBC
	mov r0,#0x80	; 03803EBE
	and r1,r0	; 03803EC0
	cmp r1,#0x0	; 03803EC2
	bne P2_Entry_03803EB4	; 03803EC4
	lsl r1,r5,#0x1	; 03803EC6
	add r0,sp,#0x0	; 03803EC8
	ldrh r1,[r0,r1]	; 03803ECA
	mov r0,#0xff	; 03803ECC
	and r1,r0	; 03803ECE
	strh r1,[r7,#0x0]	; 03803ED0
	add r5,r5,#0x1	; 03803ED2
P2_Entry_03803ED4:
	cmp r5,#0x3	; 03803ED4
	blt P2_Entry_03803EBA	; 03803ED6
	mov r5,#0x0	; 03803ED8
	sub r4,r4,#0x1	; 03803EDA
	ldr r7,[pool_03803F4C]	; 03803EDC
	b P2_Entry_03803EFC	; 03803EDE
P2_Entry_03803EE0:
	mov r0,#0x1	; 03803EE0
	bl P2_SwiWaitByLoop	; 03803EE2
P2_Entry_03803EE6:
	ldrh r1,[r7,#0x0]	; 03803EE6
	mov r0,#0x80	; 03803EE8
	and r1,r0	; 03803EEA
	cmp r1,#0x0	; 03803EEC
	bne P2_Entry_03803EE0	; 03803EEE
	ldrb r1,[r6,r5]	; 03803EF0
	mov r0,#0xff	; 03803EF2
	and r1,r0	; 03803EF4
	ldr r0,[pool_03803F54]	; 03803EF6
	strh r1,[r0,#0x0]	; 03803EF8
	add r5,r5,#0x1	; 03803EFA
P2_Entry_03803EFC:
	cmp r5,r4	; 03803EFC
	blt P2_Entry_03803EE6	; 03803EFE
	ldr r4,[pool_03803F4C]	; 03803F00
	mov r7,#0x80	; 03803F02
	b P2_Entry_03803F0C	; 03803F04
P2_Entry_03803F06:
	mov r0,#0x1	; 03803F06
	bl P2_SwiWaitByLoop	; 03803F08
P2_Entry_03803F0C:
	ldrh r0,[r4,#0x0]	; 03803F0C
	and r0,r7	; 03803F0E
	cmp r0,#0x0	; 03803F10
	bne P2_Entry_03803F06	; 03803F12
	ldr r0,[pool_03803F58]	; 03803F14
	strh r0,[r4,#0x0]	; 03803F16
	ldrb r1,[r6,r5]	; 03803F18
	mov r0,#0xff	; 03803F1A
	and r1,r0	; 03803F1C
	ldr r0,[pool_03803F54]	; 03803F1E
	strh r1,[r0,#0x0]	; 03803F20
	mov r6,#0x1	; 03803F22
	ldr r5,[pool_03803F4C]	; 03803F24
	mov r4,#0x80	; 03803F26
	b P2_Entry_03803F30	; 03803F28
P2_Entry_03803F2A:
	add r0,r6,#0x0	; 03803F2A
	bl P2_SwiWaitByLoop	; 03803F2C
P2_Entry_03803F30:
	ldrh r0,[r5,#0x0]	; 03803F30
	and r0,r4	; 03803F32
	cmp r0,#0x0	; 03803F34
	bne P2_Entry_03803F2A	; 03803F36
P2_Entry_03803F38:
	add sp,#0xc	; 03803F38
	pop {r4,r5,r6,r7}	; 03803F3A
	pop {r3}	; 03803F3C
	bx r3	; 03803F3E
pool_03803F40:
	.word 0x00000100	; 03803F40
pool_03803F44:
	.word 0x00FF0000	; 03803F44
pool_03803F48:
	.word 0x0000FF00	; 03803F48
pool_03803F4C:
	.word REG_SPICNT	; 03803F4C
pool_03803F50:
	.word 0x00008900	; 03803F50
pool_03803F54:
	.word REG_SPIDATA	; 03803F54
pool_03803F58:
	.word 0x00008100	; 03803F58

; ===== function loc_03803F5C =====
loc_03803F5C:
	push {r4,r5,r6,r7,lr}	; 03803F5C
	sub sp,#0xc	; 03803F5E
	add r4,r1,#0x0	; 03803F60
	add r6,r2,#0x0	; 03803F62
	cmp r4,#0x1	; 03803F64
	bcc loc_03804036	; 03803F66
	ldr r1,[pool_03804040]	; 03803F68
	add r2,r0,#0x0	; 03803F6A
	and r2,r1	; 03803F6C
	lsr r1,r2,#0x10	; 03803F6E
	add r2,sp,#0x0	; 03803F70
	strh r1,[r2,#0x0]	; 03803F72
	ldr r1,[pool_03804044]	; 03803F74
	add r3,r0,#0x0	; 03803F76
	and r3,r1	; 03803F78
	lsr r1,r3,#0x8	; 03803F7A
	strh r1,[r2,#0x2]	; 03803F7C
	mov r1,#0xff	; 03803F7E
	and r0,r1	; 03803F80
	strh r0,[r2,#0x4]	; 03803F82
	ldr r5,[pool_03804048]	; 03803F84
	mov r7,#0x80	; 03803F86
	b loc_03803F90	; 03803F88
loc_03803F8A:
	mov r0,#0x1	; 03803F8A
	bl loc_038048DC	; 03803F8C
loc_03803F90:
	ldrh r0,[r5,#0x0]	; 03803F90
	and r0,r7	; 03803F92
	cmp r0,#0x0	; 03803F94
	bne loc_03803F8A	; 03803F96
	ldr r0,[pool_0380404C]	; 03803F98
	strh r0,[r5,#0x0]	; 03803F9A
	mov r0,#0x3	; 03803F9C
	ldr r7,[pool_03804050]	; 03803F9E
	strh r0,[r7,#0x0]	; 03803FA0
	mov r5,#0x0	; 03803FA2
	b loc_03803FC6	; 03803FA4
loc_03803FA6:
	mov r0,#0x1	; 03803FA6
	bl loc_038048DC	; 03803FA8
loc_03803FAC:
	ldr r0,[pool_03804048]	; 03803FAC
	ldrh r1,[r0,#0x0]	; 03803FAE
	mov r0,#0x80	; 03803FB0
	and r1,r0	; 03803FB2
	cmp r1,#0x0	; 03803FB4
	bne loc_03803FA6	; 03803FB6
	lsl r1,r5,#0x1	; 03803FB8
	add r0,sp,#0x0	; 03803FBA
	ldrh r1,[r0,r1]	; 03803FBC
	mov r0,#0xff	; 03803FBE
	and r1,r0	; 03803FC0
	strh r1,[r7,#0x0]	; 03803FC2
	add r5,r5,#0x1	; 03803FC4
loc_03803FC6:
	cmp r5,#0x3	; 03803FC6
	blt loc_03803FAC	; 03803FC8
	ldr r5,[pool_03804048]	; 03803FCA
	mov r7,#0x80	; 03803FCC
	b loc_03803FD6	; 03803FCE
loc_03803FD0:
	mov r0,#0x1	; 03803FD0
	bl loc_038048DC	; 03803FD2
loc_03803FD6:
	ldrh r0,[r5,#0x0]	; 03803FD6
	and r0,r7	; 03803FD8
	cmp r0,#0x0	; 03803FDA
	bne loc_03803FD0	; 03803FDC
	mov r5,#0x0	; 03803FDE
	add r7,r5,#0x0	; 03803FE0
	b loc_03804008	; 03803FE2
loc_03803FE4:
	ldr r0,[pool_03804050]	; 03803FE4
	strh r7,[r0,#0x0]	; 03803FE6
	b loc_03803FF0	; 03803FE8
loc_03803FEA:
	mov r0,#0x1	; 03803FEA
	bl loc_038048DC	; 03803FEC
loc_03803FF0:
	ldr r0,[pool_03804048]	; 03803FF0
	ldrh r1,[r0,#0x0]	; 03803FF2
	mov r0,#0x80	; 03803FF4
	and r1,r0	; 03803FF6
	cmp r1,#0x0	; 03803FF8
	bne loc_03803FEA	; 03803FFA
	ldr r0,[pool_03804050]	; 03803FFC
	ldrh r1,[r0,#0x0]	; 03803FFE
	mov r0,#0xff	; 03804000
	and r1,r0	; 03804002
	strb r1,[r6,r5]	; 03804004
	add r5,r5,#0x1	; 03804006
loc_03804008:
	sub r0,r4,#0x1	; 03804008
	cmp r5,r0	; 0380400A
	bcc loc_03803FE4	; 0380400C
	ldr r0,[pool_03804054]	; 0380400E
	ldr r4,[pool_03804048]	; 03804010
	strh r0,[r4,#0x0]	; 03804012
	mov r1,#0x0	; 03804014
	ldr r0,[pool_03804050]	; 03804016
	strh r1,[r0,#0x0]	; 03804018
	mov r7,#0x80	; 0380401A
	b loc_03804024	; 0380401C
loc_0380401E:
	mov r0,#0x1	; 0380401E
	bl loc_038048DC	; 03804020
loc_03804024:
	ldrh r0,[r4,#0x0]	; 03804024
	and r0,r7	; 03804026
	cmp r0,#0x0	; 03804028
	bne loc_0380401E	; 0380402A
	ldr r0,[pool_03804050]	; 0380402C
	ldrh r1,[r0,#0x0]	; 0380402E
	mov r0,#0xff	; 03804030
	and r1,r0	; 03804032
	strb r1,[r6,r5]	; 03804034
loc_03804036:
	add sp,#0xc	; 03804036
	pop {r4,r5,r6,r7}	; 03804038
	pop {r3}	; 0380403A
	bx r3	; 0380403C
	.byte 0xC0, 0x46	; 03804040
pool_03804040:
loc_03804040:
	.word 0x00FF0000	; 03804040
pool_03804044:
loc_03804044:
	.word 0x0000FF00	; 03804044
pool_03804048:
loc_03804048:
	.word REG_SPICNT	; 03804048
pool_0380404C:
loc_0380404C:
	.word 0x00008900	; 0380404C
pool_03804050:
loc_03804050:
	.word REG_SPIDATA	; 03804050
pool_03804054:
loc_03804054:
	.word 0x00008100	; 03804054

; ===== function loc_03804058 =====
loc_03804058:
	push {r4,r5,r6,r7,lr}	; 03804058
	sub sp,#0x4	; 0380405A
	add r5,r0,#0x0	; 0380405C
	mov r7,#0x1	; 0380405E
	ldr r4,[pool_038040C8]	; 03804060
	mov r6,#0x80	; 03804062
	b loc_0380406C	; 03804064
loc_03804066:
	add r0,r7,#0x0	; 03804066
	bl loc_038048DC	; 03804068
loc_0380406C:
	ldrh r0,[r4,#0x0]	; 0380406C
	and r0,r6	; 0380406E
	cmp r0,#0x0	; 03804070
	bne loc_03804066	; 03804072
	ldr r0,[pool_038040CC]	; 03804074
	strh r0,[r4,#0x0]	; 03804076
	mov r1,#0x5	; 03804078
	ldr r0,[pool_038040D0]	; 0380407A
	strh r1,[r0,#0x0]	; 0380407C
	mov r7,#0x1	; 0380407E
	ldr r4,[pool_038040C8]	; 03804080
	mov r6,#0x80	; 03804082
	b loc_0380408C	; 03804084
loc_03804086:
	add r0,r7,#0x0	; 03804086
	bl loc_038048DC	; 03804088
loc_0380408C:
	ldrh r0,[r4,#0x0]	; 0380408C
	and r0,r6	; 0380408E
	cmp r0,#0x0	; 03804090
	bne loc_03804086	; 03804092
	ldr r0,[pool_038040D4]	; 03804094
	strh r0,[r4,#0x0]	; 03804096
	mov r1,#0x0	; 03804098
	ldr r0,[pool_038040D0]	; 0380409A
	strh r1,[r0,#0x0]	; 0380409C
	mov r7,#0x1	; 0380409E
	ldr r4,[pool_038040C8]	; 038040A0
	mov r6,#0x80	; 038040A2
	b loc_038040AC	; 038040A4
loc_038040A6:
	add r0,r7,#0x0	; 038040A6
	bl loc_038048DC	; 038040A8
loc_038040AC:
	ldrh r0,[r4,#0x0]	; 038040AC
	and r0,r6	; 038040AE
	cmp r0,#0x0	; 038040B0
	bne loc_038040A6	; 038040B2
	ldr r0,[pool_038040D0]	; 038040B4
	ldrh r1,[r0,#0x0]	; 038040B6
	mov r0,#0xff	; 038040B8
	and r1,r0	; 038040BA
	strb r1,[r5,#0x0]	; 038040BC
	add sp,#0x4	; 038040BE
	pop {r4,r5,r6,r7}	; 038040C0
	pop {r3}	; 038040C2
	bx r3	; 038040C4
	.byte 0xC0, 0x46	; 038040C8
pool_038040C8:
loc_038040C8:
	.word REG_SPICNT	; 038040C8
pool_038040CC:
loc_038040CC:
	.word 0x00008900	; 038040CC
pool_038040D0:
loc_038040D0:
	.word REG_SPIDATA	; 038040D0
pool_038040D4:
loc_038040D4:
	.word 0x00008100	; 038040D4
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
	mov r1,#0x4	; 038040F4
	ldr r0,[pool_03804120]	; 038040F6
	strh r1,[r0,#0x0]	; 038040F8
	mov r6,#0x1	; 038040FA
	ldr r5,[pool_03804118]	; 038040FC
	mov r4,#0x80	; 038040FE
	b P2_Entry_03804108	; 03804100
P2_Entry_03804102:
	add r0,r6,#0x0	; 03804102
	.byte 0x00, 0xF0	; 03804104
loc_03804106:
	.byte 0xEA, 0xFB	; 03804106
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
	push {r4,r5,r6,lr}	; 03804124
	mov r6,#0x1	; 03804126
	ldr r5,[pool_03804164]	; 03804128
	mov r4,#0x80	; 0380412A
	b P2_Entry_03804134	; 0380412C
P2_Entry_0380412E:
	add r0,r6,#0x0	; 0380412E
	bl P2_SwiWaitByLoop	; 03804130
P2_Entry_03804134:
	ldrh r0,[r5,#0x0]	; 03804134
	and r0,r4	; 03804136
	cmp r0,#0x0	; 03804138
	bne P2_Entry_0380412E	; 0380413A
	ldr r0,[pool_03804168]	; 0380413C
	strh r0,[r5,#0x0]	; 0380413E
	mov r1,#0x6	; 03804140
	ldr r0,[pool_0380416C]	; 03804142
	strh r1,[r0,#0x0]	; 03804144
	mov r6,#0x1	; 03804146
	ldr r5,[pool_03804164]	; 03804148
	mov r4,#0x80	; 0380414A
	b P2_Entry_03804154	; 0380414C
P2_Entry_0380414E:
	add r0,r6,#0x0	; 0380414E
	bl P2_SwiWaitByLoop	; 03804150
P2_Entry_03804154:
	ldrh r0,[r5,#0x0]	; 03804154
	and r0,r4	; 03804156
	cmp r0,#0x0	; 03804158
	bne P2_Entry_0380414E	; 0380415A
	pop {r4,r5,r6}	; 0380415C
	pop {r3}	; 0380415E
	bx r3	; 03804160
	.byte 0xC0, 0x46	; 03804162
pool_03804164:
	.word 0x040001C0	; 03804164
pool_03804168:
	.word 0x00008100	; 03804168
pool_0380416C:
	.word REG_SPIDATA	; 0380416C
P2_Entry_03804170:
	push {r4,r5,lr}	; 03804170
	sub sp,#0x4	; 03804172
	add r4,r0,#0x0	; 03804174
	bl loc_037FDCE8	; 03804176
	add r5,r0,#0x0	; 0380417A
	mov r0,#0x3	; 0380417C
	bl P2_Entry_03802E78	; 0380417E
	cmp r0,#0x0	; 03804182
	bne P2_Entry_0380419A	; 03804184
	add r0,r5,#0x0	; 03804186
	bl loc_037FDD0C	; 03804188
	ldr r0,[r4,#0x4]	; 0380418C
	lsl r0,r0,#0x10	; 0380418E
	lsr r0,r0,#0x10	; 03804190
	mov r1,#0x4	; 03804192
	bl loc_03802E8C	; 03804194
	b P2_Entry_03804258	; 03804198
P2_Entry_0380419A:
	mov r0,#0x3	; 0380419A
	bl loc_03802E68	; 0380419C
	add r0,r5,#0x0	; 038041A0
	bl loc_037FDD0C	; 038041A2
	ldr r0,[r4,#0x4]	; 038041A6
	add r1,r0,#0x0	; 038041A8
	sub r1,#0x61	; 038041AA
	cmp r1,#0x5	; 038041AC
	bhi P2_Entry_03804248	; 038041AE
	add r1,r1,r1	; 038041B0
P2_SwitchIndexPC_038041B0:
	add r1,pc	; 038041B2
	ldrh r1,[r1,#(P2_SwitchTable_038041B0 - (P2_SwitchIndexPC_038041B0 + 4))]	; 038041B4
	lsl r1,r1,#0x10	; 038041B6
	asr r1,r1,#0x10	; 038041B8
P2_SwitchTargetPC_038041B0:
	add r1,pc	; 038041BA
	bx r1	; 038041BC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038041B0:
	.halfword (P2_Case_038041CA + 1) - (P2_SwitchTargetPC_038041B0 + 4)
	.halfword (P2_Entry_03804248 + 1) - (P2_SwitchTargetPC_038041B0 + 4)
	.halfword (P2_Case_03804228 + 1) - (P2_SwitchTargetPC_038041B0 + 4)
	.halfword (P2_Case_038041E2 + 1) - (P2_SwitchTargetPC_038041B0 + 4)
	.halfword (P2_Case_03804206 + 1) - (P2_SwitchTargetPC_038041B0 + 4)
	.halfword (P2_Case_03804240 + 1) - (P2_SwitchTargetPC_038041B0 + 4)
P2_SwitchTable_038041B0End:
P2_Case_038041CA:
	mov r1,#0x1	; 038041CA
	ldr r0,[pool_03804260]	; 038041CC
	str r1,[r0,#0x20]	; 038041CE
	ldr r1,[r4,#0x8]	; 038041D0
	ldr r0,[pool_03804264]	; 038041D2
	strh r1,[r0,#0x0]	; 038041D4
	ldr r1,[r4,#0xc]	; 038041D6
	ldr r0,[pool_03804268]	; 038041D8
	strh r1,[r0,#0x0]	; 038041DA
	bl P2_Entry_0380466C	; 038041DC
	b P2_Entry_03804252	; 038041E0
P2_Case_038041E2:
	mov r1,#0x4	; 038041E2
	ldr r0,[pool_03804260]	; 038041E4
	str r1,[r0,#0x20]	; 038041E6
	ldr r2,[r4,#0x8]	; 038041E8
	str r2,[r0,#0x28]	; 038041EA
	ldr r1,[r4,#0xc]	; 038041EC
	str r1,[r0,#0x24]	; 038041EE
	lsl r0,r2,#0x10	; 038041F0
	lsr r0,r0,#0x10	; 038041F2
	lsl r1,r1,#0x18	; 038041F4
	lsr r1,r1,#0x18	; 038041F6
	bl loc_038044E0	; 038041F8
	mov r0,#0x64	; 038041FC
	mov r1,#0x0	; 038041FE
	bl loc_03802E8C	; 03804200
	b P2_Entry_03804252	; 03804204
P2_Case_03804206:
	mov r1,#0x3	; 03804206
	ldr r0,[pool_03804260]	; 03804208
	str r1,[r0,#0x20]	; 0380420A
	ldr r1,[r4,#0x8]	; 0380420C
	str r1,[r0,#0x28]	; 0380420E
	lsl r0,r1,#0x10	; 03804210
	lsr r4,r0,#0x10	; 03804212
	add r0,r4,#0x0	; 03804214
	bl P2_ReadPmicRegister	; 03804216
	add r1,r0,#0x0	; 0380421A
	add r4,#0x70	; 0380421C
	lsl r0,r4,#0x10	; 0380421E
	lsr r0,r0,#0x10	; 03804220
	bl loc_03802E8C	; 03804222
	b P2_Entry_03804252	; 03804226
P2_Case_03804228:
	mov r0,#0x2	; 03804228
	ldr r1,[pool_03804260]	; 0380422A
	str r0,[r1,#0x20]	; 0380422C
	ldr r0,[r4,#0x8]	; 0380422E
	str r0,[r1,#0x24]	; 03804230
	bl P2_Entry_0380459C	; 03804232
	mov r0,#0x63	; 03804236
	mov r1,#0x0	; 03804238
	bl loc_03802E8C	; 0380423A
	b P2_Entry_03804252	; 0380423E
P2_Case_03804240:
	ldr r0,[r4,#0x8]	; 03804240
	bl P2_Entry_03804558	; 03804242
	b P2_Entry_03804252	; 03804246
P2_Entry_03804248:
	lsl r0,r0,#0x10	; 03804248
	lsr r0,r0,#0x10	; 0380424A
	mov r1,#0x1	; 0380424C
	bl loc_03802E8C	; 0380424E
P2_Entry_03804252:
	mov r0,#0x3	; 03804252
	bl P2_Entry_03802E40	; 03804254
P2_Entry_03804258:
	add sp,#0x4	; 03804258
	pop {r4,r5}	; 0380425A
	pop {r3}	; 0380425C
	bx r3	; 0380425E
pool_03804260:
	.word P2_BssStart + 0x26A4	; 03804260
pool_03804264:
	.word P2_BssStart + 0x269C	; 03804264
pool_03804268:
	.word P2_BssStart + 0x2698	; 03804268

; ===== function loc_0380426C =====
loc_0380426C:
	push {r4,r5,r6,lr}	; 0380426C
	sub sp,#0x8	; 0380426E
	ldr r1,[pool_0380439C]	; 03804270
	add r2,r0,#0x0	; 03804272
	and r2,r1	; 03804274
	cmp r2,#0x0	; 03804276
	beq loc_0380428A	; 03804278
	mov r4,#0x0	; 0380427A
	add r3,r4,#0x0	; 0380427C
	ldr r1,[pool_038043A0]	; 0380427E
loc_03804280:
	lsl r2,r4,#0x1	; 03804280
	strh r3,[r1,r2]	; 03804282
	add r4,r4,#0x1	; 03804284
	cmp r4,#0x10	; 03804286
	blt loc_03804280	; 03804288
loc_0380428A:
	ldr r1,[pool_038043A4]	; 0380428A
	add r2,r0,#0x0	; 0380428C
	and r2,r1	; 0380428E
	lsr r1,r2,#0x10	; 03804290
	lsl r1,r1,#0x1	; 03804292
	ldr r5,[pool_038043A0]	; 03804294
	strh r0,[r5,r1]	; 03804296
	ldr r1,[pool_038043A8]	; 03804298
	and r0,r1	; 0380429A
	cmp r0,#0x0	; 0380429C
	beq loc_03804394	; 0380429E
	ldrh r3,[r5,#0x0]	; 038042A0
	ldr r0,[pool_038043AC]	; 038042A2
	add r1,r3,#0x0	; 038042A4
	and r1,r0	; 038042A6
	lsl r0,r1,#0x8	; 038042A8
	lsr r4,r0,#0x10	; 038042AA
	add r0,r4,#0x0	; 038042AC
	sub r0,#0x60	; 038042AE
	cmp r0,#0x7	; 038042B0
	bhi loc_0380438C	; 038042B2
	add r0,r0,r0	; 038042B4
P2_SwitchIndexPC_038042B4:
	add r0,pc	; 038042B6
	ldrh r0,[r0,#(P2_SwitchTable_038042B4 - (P2_SwitchIndexPC_038042B4 + 4))]	; 038042B8
	lsl r0,r0,#0x10	; 038042BA
	asr r0,r0,#0x10	; 038042BC
P2_SwitchTargetPC_038042B4:
	add r0,pc	; 038042BE
	bx r0	; 038042C0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038042B4:
	.halfword (loc_038042D2 + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_038042DC + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_0380438C + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_03804340 + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_03804300 + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_03804324 + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_03804366 + 1) - (P2_SwitchTargetPC_038042B4 + 4)
	.halfword (loc_0380437A + 1) - (P2_SwitchTargetPC_038042B4 + 4)
P2_SwitchTable_038042B4End:
loc_038042D2:
	mov r0,#0x60	; 038042D2
	mov r1,#0x0	; 038042D4
	bl loc_03802E8C	; 038042D6
	b loc_03804394	; 038042DA
loc_038042DC:
	ldrh r1,[r5,#0x2]	; 038042DC
	ldr r0,[pool_038043B0]	; 038042DE
	and r1,r0	; 038042E0
	str r1,[sp,#0x0]	; 038042E2
	mov r0,#0x3	; 038042E4
	add r1,r4,#0x0	; 038042E6
	mov r2,#0x2	; 038042E8
	mov r5,#0xff	; 038042EA
	and r3,r5	; 038042EC
	bl loc_03802D98	; 038042EE
	cmp r0,#0x0	; 038042F2
	bne loc_03804394	; 038042F4
	add r0,r4,#0x0	; 038042F6
	mov r1,#0x4	; 038042F8
	bl loc_03802E8C	; 038042FA
	b loc_03804394	; 038042FE
loc_03804300:
	ldrh r1,[r5,#0x2]	; 03804300
	ldr r0,[pool_038043B0]	; 03804302
	and r1,r0	; 03804304
	str r1,[sp,#0x0]	; 03804306
	mov r0,#0x3	; 03804308
	add r1,r4,#0x0	; 0380430A
	mov r2,#0x2	; 0380430C
	mov r5,#0xff	; 0380430E
	and r3,r5	; 03804310
	bl loc_03802D98	; 03804312
	cmp r0,#0x0	; 03804316
	bne loc_03804394	; 03804318
	add r0,r4,#0x0	; 0380431A
	mov r1,#0x4	; 0380431C
	bl loc_03802E8C	; 0380431E
	b loc_03804394	; 03804322
loc_03804324:
	mov r0,#0x3	; 03804324
	add r1,r4,#0x0	; 03804326
	mov r2,#0x1	; 03804328
	ldr r5,[pool_038043B0]	; 0380432A
	and r3,r5	; 0380432C
	bl loc_03802D98	; 0380432E
	cmp r0,#0x0	; 03804332
	bne loc_03804394	; 03804334
	add r0,r4,#0x0	; 03804336
	mov r1,#0x4	; 03804338
	bl loc_03802E8C	; 0380433A
	b loc_03804394	; 0380433E
loc_03804340:
	mov r0,#0x3	; 03804340
	add r1,r4,#0x0	; 03804342
	mov r2,#0x1	; 03804344
	mov r6,#0xff	; 03804346
	and r3,r6	; 03804348
	lsl r3,r3,#0x10	; 0380434A
	ldrh r6,[r5,#0x2]	; 0380434C
	ldr r5,[pool_038043B0]	; 0380434E
	and r6,r5	; 03804350
	orr r3,r6	; 03804352
	bl loc_03802D98	; 03804354
	cmp r0,#0x0	; 03804358
	bne loc_03804394	; 0380435A
	add r0,r4,#0x0	; 0380435C
	mov r1,#0x4	; 0380435E
	bl loc_03802E8C	; 03804360
	b loc_03804394	; 03804364
loc_03804366:
	mov r0,#0xff	; 03804366
	and r3,r0	; 03804368
	add r0,r3,#0x0	; 0380436A
	bl loc_038047C4	; 0380436C
	mov r0,#0x66	; 03804370
	mov r1,#0x0	; 03804372
	bl loc_03802E8C	; 03804374
	b loc_03804394	; 03804378
loc_0380437A:
	bl loc_038047B8	; 0380437A
	add r1,r0,#0x0	; 0380437E
	mov r0,#0x67	; 03804380
	lsl r1,r1,#0x10	; 03804382
	lsr r1,r1,#0x10	; 03804384
	bl loc_03802E8C	; 03804386
	b loc_03804394	; 0380438A
loc_0380438C:
	add r0,r4,#0x0	; 0380438C
	mov r1,#0x1	; 0380438E
	bl loc_03802E8C	; 03804390
loc_03804394:
	add sp,#0x8	; 03804394
	pop {r4,r5,r6}	; 03804396
	pop {r3}	; 03804398
	bx r3	; 0380439A
pool_0380439C:
loc_0380439C:
	.word 0x02000000	; 0380439C
pool_038043A0:
loc_038043A0:
	.word P2_BssStart + 0x26A4	; 038043A0
pool_038043A4:
loc_038043A4:
	.word 0x000F0000	; 038043A4
pool_038043A8:
loc_038043A8:
	.word 0x01000000	; 038043A8
pool_038043AC:
loc_038043AC:
	.word 0x0000FF00	; 038043AC
pool_038043B0:
loc_038043B0:
	.word 0x0000FFFF	; 038043B0

; ===== function loc_038043B4 =====
loc_038043B4:
	mov r1,#0x1	; 038043B4
	ldr r0,[pool_038043D0]	; 038043B6
	str r1,[r0,#0x0]	; 038043B8
	mov r3,#0x0	; 038043BA
	ldr r0,[pool_038043D4]	; 038043BC
	str r3,[r0,#0x20]	; 038043BE
	add r2,r3,#0x0	; 038043C0
loc_038043C2:
	lsl r1,r3,#0x1	; 038043C2
	strh r2,[r0,r1]	; 038043C4
	add r3,r3,#0x1	; 038043C6
	cmp r3,#0x10	; 038043C8
	blt loc_038043C2	; 038043CA
	bx lr	; 038043CC
	.byte 0xC0, 0x46	; 038043D0
pool_038043D0:
loc_038043D0:
	.word P2_BssStart + 0x26A0	; 038043D0
pool_038043D4:
loc_038043D4:
	.word P2_BssStart + 0x26A4	; 038043D4
P2_Entry_038043D8:
	ldr r3,[pool_038043F4]	; 038043D8
	and r2,r3	; 038043DA
	ldr r3,[pool_038043F8]	; 038043DC
	and r0,r3	; 038043DE
	lsl r3,r0,#0x16	; 038043E0
	ldr r0,[pool_038043FC]	; 038043E2
	and r1,r0	; 038043E4
	lsl r0,r1,#0x10	; 038043E6
	orr r3,r0	; 038043E8
	orr r2,r3	; 038043EA
	add r0,r2,#0x0	; 038043EC
	ldr r3,[pool_03804400]	; 038043EE
	bx r3	; 038043F0
	.byte 0xC0, 0x46	; 038043F2
pool_038043F4:
	.word 0x0000FFFF	; 038043F4
pool_038043F8:
	.word 0x03C00000	; 038043F8
pool_038043FC:
	.word 0x003F0000	; 038043FC
pool_03804400:
	.word P2_Entry_03804404 + 1	; 03804400
P2_Entry_03804404:
	push {r4,r5,r6,lr}	; 03804404
	add r5,r0,#0x0	; 03804406
	mov r4,#0x8	; 03804408
	mov r6,#0x0	; 0380440A
P2_Entry_0380440C:
	add r0,r4,#0x0	; 0380440C
	add r1,r5,#0x0	; 0380440E
	add r2,r6,#0x0	; 03804410
	bl loc_03801F38	; 03804412
	cmp r0,#0x0	; 03804416
	bne P2_Entry_0380440C	; 03804418
	pop {r4,r5,r6}	; 0380441A
	pop {r3}	; 0380441C
	bx r3	; 0380441E

; ===== function loc_03804420 =====
loc_03804420:
	push {r4,lr}	; 03804420
	add r4,r0,#0x0	; 03804422
	mov r0,#0x0	; 03804424
	bl P2_ReadPmicRegister	; 03804426
	bic r0,r4	; 0380442A
	lsl r0,r0,#0x18	; 0380442C
	lsr r1,r0,#0x18	; 0380442E
	mov r0,#0x0	; 03804430
	bl loc_038044E0	; 03804432
	pop {r4}	; 03804436
	pop {r3}	; 03804438
	bx r3	; 0380443A

; ===== function loc_0380443C =====
loc_0380443C:
	push {r4,lr}	; 0380443C
	add r4,r0,#0x0	; 0380443E
	mov r0,#0x0	; 03804440
	bl P2_ReadPmicRegister	; 03804442
	add r1,r0,#0x0	; 03804446
	orr r1,r4	; 03804448
	mov r0,#0x0	; 0380444A
	bl loc_038044E0	; 0380444C
	pop {r4}	; 03804450
	pop {r3}	; 03804452
	bx r3	; 03804454
	.byte 0x00, 0x00	; 03804458

; ===== function loc_03804458 =====
loc_03804458:
; 通过 SPI 读取 r0 指定的电源管理寄存器，返回低 8 位。
; Read the PMIC register selected by r0 over SPI; return its low byte.
.func P2_ReadPmicRegister
	push {r4,r5,r6,r7,lr}	; 03804458
	sub sp,#0x4	; 0380445A
	add r5,r0,#0x0	; 0380445C
	mov r7,#0x1	; 0380445E
	ldr r4,[pool_038044D8]	; 03804460
	mov r6,#0x80	; 03804462
	b loc_0380446C	; 03804464
loc_03804466:
	add r0,r7,#0x0	; 03804466
	bl loc_038048DC	; 03804468
loc_0380446C:
	ldrh r0,[r4,#0x0]	; 0380446C
	and r0,r6	; 0380446E
	cmp r0,#0x0	; 03804470
	bne loc_03804466	; 03804472
	mov r0,#0x1	; 03804474
	bl P2_SetPmicSpiHold	; 03804476
	mov r4,#0x80	; 0380447A
	orr r5,r4	; 0380447C
	lsl r0,r5,#0x18	; 0380447E
	lsr r1,r0,#0x18	; 03804480
	mov r0,#0xff	; 03804482
	and r1,r0	; 03804484
	ldr r0,[pool_038044DC]	; 03804486
	strh r1,[r0,#0x0]	; 03804488
	mov r6,#0x1	; 0380448A
	ldr r5,[pool_038044D8]	; 0380448C
	b loc_03804496	; 0380448E
loc_03804490:
	add r0,r6,#0x0	; 03804490
	bl loc_038048DC	; 03804492
loc_03804496:
	ldrh r0,[r5,#0x0]	; 03804496
	and r0,r4	; 03804498
	cmp r0,#0x0	; 0380449A
	bne loc_03804490	; 0380449C
	mov r0,#0x0	; 0380449E
	bl P2_SetPmicSpiHold	; 038044A0
	mov r1,#0x0	; 038044A4
	ldr r0,[pool_038044DC]	; 038044A6
	strh r1,[r0,#0x0]	; 038044A8
	mov r6,#0x1	; 038044AA
	ldr r5,[pool_038044D8]	; 038044AC
	mov r4,#0x80	; 038044AE
	b loc_038044B8	; 038044B0
loc_038044B2:
	add r0,r6,#0x0	; 038044B2
	bl loc_038048DC	; 038044B4
loc_038044B8:
	ldrh r0,[r5,#0x0]	; 038044B8
	and r0,r4	; 038044BA
	cmp r0,#0x0	; 038044BC
	bne loc_038044B2	; 038044BE
	ldr r0,[pool_038044DC]	; 038044C0
	ldrh r1,[r0,#0x0]	; 038044C2
	mov r0,#0xff	; 038044C4
	and r1,r0	; 038044C6
	lsl r0,r1,#0x10	; 038044C8
	lsr r0,r0,#0x10	; 038044CA
	lsl r0,r0,#0x18	; 038044CC
	lsr r0,r0,#0x18	; 038044CE
	add sp,#0x4	; 038044D0
	pop {r4,r5,r6,r7}	; 038044D2
	pop {r3}	; 038044D4
	bx r3	; 038044D6
.endfunc
pool_038044D8:
loc_038044D8:
	.word REG_SPICNT	; 038044D8
pool_038044DC:
loc_038044DC:
	.word REG_SPIDATA	; 038044DC

; ===== function loc_038044E0 =====
loc_038044E0:
	push {r4,r5,r6,r7,lr}	; 038044E0
	sub sp,#0x4	; 038044E2
	add r5,r0,#0x0	; 038044E4
	add r4,r1,#0x0	; 038044E6
	ldr r6,[pool_0380453C]	; 038044E8
	mov r7,#0x80	; 038044EA
	b loc_038044F4	; 038044EC
loc_038044EE:
	mov r0,#0x1	; 038044EE
	bl loc_038048DC	; 038044F0
loc_038044F4:
	ldrh r0,[r6,#0x0]	; 038044F4
	and r0,r7	; 038044F6
	cmp r0,#0x0	; 038044F8
	bne loc_038044EE	; 038044FA
	mov r0,#0x1	; 038044FC
	bl P2_SetPmicSpiHold	; 038044FE
	lsl r0,r5,#0x18	; 03804502
	lsr r1,r0,#0x18	; 03804504
	mov r0,#0xff	; 03804506
	and r1,r0	; 03804508
	ldr r0,[pool_03804540]	; 0380450A
	strh r1,[r0,#0x0]	; 0380450C
	mov r7,#0x1	; 0380450E
	ldr r5,[pool_0380453C]	; 03804510
	mov r6,#0x80	; 03804512
	b loc_0380451C	; 03804514
loc_03804516:
	add r0,r7,#0x0	; 03804516
	bl loc_038048DC	; 03804518
loc_0380451C:
	ldrh r0,[r5,#0x0]	; 0380451C
	and r0,r6	; 0380451E
	cmp r0,#0x0	; 03804520
	bne loc_03804516	; 03804522
	mov r0,#0x0	; 03804524
	bl P2_SetPmicSpiHold	; 03804526
	mov r0,#0xff	; 0380452A
	and r4,r0	; 0380452C
	ldr r0,[pool_03804540]	; 0380452E
	strh r4,[r0,#0x0]	; 03804530
	add sp,#0x4	; 03804532
	pop {r4,r5,r6,r7}	; 03804534
	pop {r3}	; 03804536
	bx r3	; 03804538
	.byte 0xC0, 0x46	; 0380453C
pool_0380453C:
loc_0380453C:
	.word REG_SPICNT	; 0380453C
pool_03804540:
loc_03804540:
	.word REG_SPIDATA	; 03804540

; ===== function loc_03804544 =====
loc_03804544:
; 选择 PMIC 的 SPI 通道；r0 控制两次传输之间是否保持片选。
; Select the PMIC SPI device; r0 controls chip-select hold between transfers.
.func P2_SetPmicSpiHold
	lsl r1,r0,#0xb	; 03804544
	ldr r0,[pool_03804550]	; 03804546
	orr r1,r0	; 03804548
	ldr r0,[pool_03804554]	; 0380454A
	strh r1,[r0,#0x0]	; 0380454C
	bx lr	; 0380454E
.endfunc
pool_03804550:
loc_03804550:
	.word 0x00008002	; 03804550
pool_03804554:
loc_03804554:
	.word REG_SPICNT	; 03804554

; ===== function loc_03804558 =====
P2_Entry_03804558:
	push {r4,lr}	; 03804558
	add r4,r0,#0x0	; 0380455A
	cmp r4,#0x1	; 0380455C
	beq loc_0380456A	; 0380455E
	cmp r4,#0x2	; 03804560
	beq loc_0380457A	; 03804562
	cmp r4,#0x3	; 03804564
	beq loc_03804572	; 03804566
	b loc_03804588	; 03804568
loc_0380456A:
	mov r0,#0x10	; 0380456A
	bl loc_03804420	; 0380456C
	b loc_0380458C	; 03804570
loc_03804572:
	mov r0,#0x30	; 03804572
	bl loc_0380443C	; 03804574
	b loc_0380458C	; 03804578
loc_0380457A:
	mov r0,#0x20	; 0380457A
	bl loc_03804420	; 0380457C
	mov r0,#0x10	; 03804580
	bl loc_0380443C	; 03804582
	b loc_0380458C	; 03804586
loc_03804588:
	bl loc_037FF1DC	; 03804588
loc_0380458C:
	ldr r0,[pool_03804598]	; 0380458C
	str r4,[r0,#0x0]	; 0380458E
	pop {r4}	; 03804590
	pop {r3}	; 03804592
	bx r3	; 03804594
	.byte 0xC0, 0x46	; 03804598
pool_03804598:
loc_03804598:
	.word P2_Data_0380530C	; 03804598
P2_Entry_0380459C:
	push {lr}	; 0380459C
	sub sp,#0x4	; 0380459E
	cmp r0,#0xf	; 038045A0
	bhi P2_Entry_03804664	; 038045A2
	add r0,r0,r0	; 038045A4
P2_SwitchIndexPC_038045A4:
	add r0,pc	; 038045A6
	ldrh r0,[r0,#(P2_SwitchTable_038045A4 - (P2_SwitchIndexPC_038045A4 + 4))]	; 038045A8
	lsl r0,r0,#0x10	; 038045AA
	asr r0,r0,#0x10	; 038045AC
P2_SwitchTargetPC_038045A4:
	add r0,pc	; 038045AE
	bx r0	; 038045B0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038045A4:
	.halfword (P2_Entry_03804664 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_038045D2 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_038045E0 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_038045EE + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_038045FC + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_03804604 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_0380460C + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_03804614 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_0380461C + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_03804624 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_0380462C + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_03804634 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_0380463C + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_03804644 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_03804654 + 1) - (P2_SwitchTargetPC_038045A4 + 4)
	.halfword (P2_Case_0380464C + 1) - (P2_SwitchTargetPC_038045A4 + 4)
P2_SwitchTable_038045A4End:
P2_Case_038045D2:
	mov r0,#0x1	; 038045D2
	bl loc_038047C4	; 038045D4
	mov r0,#0x1	; 038045D8
	bl P2_Entry_03804558	; 038045DA
	b P2_Entry_03804664	; 038045DE
P2_Case_038045E0:
	mov r0,#0x3	; 038045E0
	bl loc_038047C4	; 038045E2
	mov r0,#0x3	; 038045E6
	bl P2_Entry_03804558	; 038045E8
	b P2_Entry_03804664	; 038045EC
P2_Case_038045EE:
	mov r0,#0x2	; 038045EE
	bl loc_038047C4	; 038045F0
	mov r0,#0x2	; 038045F4
	bl P2_Entry_03804558	; 038045F6
	b P2_Entry_03804664	; 038045FA
P2_Case_038045FC:
	mov r0,#0x4	; 038045FC
	bl loc_0380443C	; 038045FE
	b P2_Entry_03804664	; 03804602
P2_Case_03804604:
	mov r0,#0x4	; 03804604
	bl loc_03804420	; 03804606
	b P2_Entry_03804664	; 0380460A
P2_Case_0380460C:
	mov r0,#0x8	; 0380460C
	bl loc_0380443C	; 0380460E
	b P2_Entry_03804664	; 03804612
P2_Case_03804614:
	mov r0,#0x8	; 03804614
	bl loc_03804420	; 03804616
	b P2_Entry_03804664	; 0380461A
P2_Case_0380461C:
	mov r0,#0xc	; 0380461C
	bl loc_0380443C	; 0380461E
	b P2_Entry_03804664	; 03804622
P2_Case_03804624:
	mov r0,#0xc	; 03804624
	bl loc_03804420	; 03804626
	b P2_Entry_03804664	; 0380462A
P2_Case_0380462C:
	mov r0,#0x1	; 0380462C
	bl loc_0380443C	; 0380462E
	b P2_Entry_03804664	; 03804632
P2_Case_03804634:
	mov r0,#0x1	; 03804634
	bl loc_03804420	; 03804636
	b P2_Entry_03804664	; 0380463A
P2_Case_0380463C:
	mov r0,#0x2	; 0380463C
	bl loc_0380443C	; 0380463E
	b P2_Entry_03804664	; 03804642
P2_Case_03804644:
	mov r0,#0x2	; 03804644
	bl loc_03804420	; 03804646
	b P2_Entry_03804664	; 0380464A
P2_Case_0380464C:
	mov r0,#0x40	; 0380464C
	bl loc_03804420	; 0380464E
	b P2_Entry_03804664	; 03804652
P2_Case_03804654:
	bl P2_Entry_037FF480	; 03804654
	mov r0,#0x1	; 03804658
	bl loc_03804420	; 0380465A
	mov r0,#0x40	; 0380465E
	bl loc_0380443C	; 03804660
P2_Entry_03804664:
	add sp,#0x4	; 03804664
	pop {r3}	; 03804666
	bx r3	; 03804668
	.byte 0x00, 0x00	; 0380466A
P2_Entry_0380466C:
	push {r4,r5,r6,r7,lr}	; 0380466C
	sub sp,#0x4	; 0380466E
	ldr r1,[pool_03804780]	; 03804670
	ldrh r4,[r1,#0x0]	; 03804672
	mov r0,#0x0	; 03804674
	strh r0,[r1,#0x0]	; 03804676
	bl loc_037FDCE8	; 03804678
	add r6,r0,#0x0	; 0380467C
	ldr r0,[pool_03804784]	; 0380467E
	bl loc_037FDA6C	; 03804680
	add r7,r0,#0x0	; 03804684
	mov r0,#0x0	; 03804686
	bl P2_ReadPmicRegister	; 03804688
	str r0,[sp,#0x0]	; 0380468C
	mov r0,#0x2	; 0380468E
	bl loc_038047C4	; 03804690
	mov r0,#0x2	; 03804694
	bl P2_Entry_03804558	; 03804696
	mov r0,#0x2	; 0380469A
	bl P2_Entry_03804558	; 0380469C
	bl P2_Entry_037FF480	; 038046A0
	mov r0,#0x1	; 038046A4
	bl loc_03804420	; 038046A6
	ldr r0,[pool_03804788]	; 038046AA
	ldrh r1,[r0,#0x0]	; 038046AC
	mov r0,#0x1	; 038046AE
	and r1,r0	; 038046B0
	cmp r1,#0x0	; 038046B2
	beq P2_Entry_038046C8	; 038046B4
	ldr r0,[pool_0380478C]	; 038046B6
	ldrh r1,[r0,#0x0]	; 038046B8
	ldr r0,[pool_03804790]	; 038046BA
	orr r1,r0	; 038046BC
	ldr r0,[pool_03804794]	; 038046BE
	strh r1,[r0,#0x0]	; 038046C0
	ldr r0,[pool_03804798]	; 038046C2
	bl loc_037FDA98	; 038046C4
P2_Entry_038046C8:
	ldr r0,[pool_03804788]	; 038046C8
	ldrh r1,[r0,#0x0]	; 038046CA
	mov r0,#0x4	; 038046CC
	and r1,r0	; 038046CE
	cmp r1,#0x0	; 038046D0
	beq P2_Entry_038046DA	; 038046D2
	ldr r0,[pool_0380479C]	; 038046D4
	bl loc_037FDA98	; 038046D6
P2_Entry_038046DA:
	ldr r0,[pool_03804788]	; 038046DA
	ldrh r1,[r0,#0x0]	; 038046DC
	mov r0,#0x2	; 038046DE
	and r1,r0	; 038046E0
	cmp r1,#0x0	; 038046E2
	beq P2_Entry_03804706	; 038046E4
	ldr r0,[pool_038047A0]	; 038046E6
	ldrh r5,[r0,#0x0]	; 038046E8
	ldr r0,[pool_038047A4]	; 038046EA
	bl loc_0380214C	; 038046EC
	mov r0,#0x40	; 038046F0
	mov r1,#0x0	; 038046F2
	bl loc_03802160	; 038046F4
	ldr r0,[pool_038047A8]	; 038046F8
	add r1,r0,#0x0	; 038046FA
	bl loc_03802160	; 038046FC
	mov r0,#0x80	; 03804700
	bl loc_037FDA98	; 03804702
P2_Entry_03804706:
	ldr r0,[pool_03804788]	; 03804706
	ldrh r1,[r0,#0x0]	; 03804708
	mov r0,#0x8	; 0380470A
	and r1,r0	; 0380470C
	cmp r1,#0x0	; 0380470E
	beq P2_Entry_03804718	; 03804710
	ldr r0,[pool_038047AC]	; 03804712
	bl loc_037FDA98	; 03804714
P2_Entry_03804718:
	ldr r0,[pool_03804788]	; 03804718
	ldrh r1,[r0,#0x0]	; 0380471A
	mov r0,#0x10	; 0380471C
	and r1,r0	; 0380471E
	cmp r1,#0x0	; 03804720
	beq P2_Entry_0380472A	; 03804722
	ldr r0,[pool_038047B0]	; 03804724
	bl loc_037FDA98	; 03804726
P2_Entry_0380472A:
	add r0,r6,#0x0	; 0380472A
	bl loc_037FDD0C	; 0380472C
	ldr r1,[pool_03804780]	; 03804730
	ldrh r0,[r1,#0x0]	; 03804732
	mov r0,#0x1	; 03804734
	strh r0,[r1,#0x0]	; 03804736
	bl P2_SwiStop	; 03804738
	mov r0,#0x0	; 0380473C
	ldr r1,[sp,#0x0]	; 0380473E
	bl loc_038044E0	; 03804740
	ldr r0,[pool_038047A0]	; 03804744
	strh r5,[r0,#0x0]	; 03804746
	mov r0,#0x1	; 03804748
	bl loc_0380443C	; 0380474A
	bl P2_Entry_037FF44C	; 0380474E
	mov r1,#0x0	; 03804752
	ldr r0,[pool_038047B4]	; 03804754
	str r1,[r0,#0x20]	; 03804756
	mov r0,#0x62	; 03804758
	add r2,r1,#0x0	; 0380475A
	bl P2_Entry_038043D8	; 0380475C
	bl loc_037FDCE8	; 03804760
	add r0,r7,#0x0	; 03804764
	bl loc_037FDA98	; 03804766
	add r0,r6,#0x0	; 0380476A
	bl loc_037FDD0C	; 0380476C
	ldr r1,[pool_03804780]	; 03804770
	ldrh r0,[r1,#0x0]	; 03804772
	strh r4,[r1,#0x0]	; 03804774
	add sp,#0x4	; 03804776
	pop {r4,r5,r6,r7}	; 03804778
	pop {r3}	; 0380477A
	bx r3	; 0380477C
	.byte 0xC0, 0x46	; 0380477E
pool_03804780:
	.word REG_IME	; 03804780
pool_03804784:
	.word 0x01FFFFFF	; 03804784
pool_03804788:
	.word P2_BssStart + 0x269C	; 03804788
pool_0380478C:
	.word P2_BssStart + 0x2698	; 0380478C
pool_03804790:
	.word 0x00004000	; 03804790
pool_03804794:
	.word REG_KEYCNT	; 03804794
pool_03804798:
	.word 0x00001000	; 03804798
pool_0380479C:
	.word 0x00400000	; 0380479C
pool_038047A0:
	.word REG_RCNT_ARM7	; 038047A0
pool_038047A4:
	.word 0x00008000	; 038047A4
pool_038047A8:
	.word 0x00000100	; 038047A8
pool_038047AC:
	.word 0x00100000	; 038047AC
pool_038047B0:
	.word 0x00002000	; 038047B0
pool_038047B4:
	.word P2_BssStart + 0x26A4	; 038047B4

; ===== function loc_038047B8 =====
loc_038047B8:
	ldr r0,[pool_038047C0]	; 038047B8
	ldr r0,[r0,#0x0]	; 038047BA
	bx lr	; 038047BC
	.byte 0xC0, 0x46	; 038047C0
pool_038047C0:
loc_038047C0:
	.word P2_BssStart + 0x26D4	; 038047C0

; ===== function loc_038047C4 =====
loc_038047C4:
	cmp r0,#0xf	; 038047C4
	bgt loc_038047D2	; 038047C6
	ldr r1,[pool_038047D4]	; 038047C8
	str r0,[r1,#0x0]	; 038047CA
	mov r1,#0x0	; 038047CC
	ldr r0,[pool_038047D8]	; 038047CE
	str r1,[r0,#0x0]	; 038047D0
loc_038047D2:
	bx lr	; 038047D2
pool_038047D4:
loc_038047D4:
	.word P2_BssStart + 0x26D4	; 038047D4
pool_038047D8:
loc_038047D8:
	.word P2_BssStart + 0x26D0	; 038047D8

; ===== function loc_038047DC =====
loc_038047DC:
	push {r4,r5,r6,lr}	; 038047DC
	ldr r0,[pool_0380487C]	; 038047DE
	ldr r3,[r0,#0x0]	; 038047E0
	cmp r3,#0x0	; 038047E2
	bne loc_038047FE	; 038047E4
	mov r0,#0x3	; 038047E6
	mov r1,#0x66	; 038047E8
	mov r2,#0x1	; 038047EA
	add r3,r2,#0x0	; 038047EC
	bl loc_03802D98	; 038047EE
	cmp r0,#0x0	; 038047F2
	beq loc_03804874	; 038047F4
	mov r0,#0x1	; 038047F6
	bl loc_038047C4	; 038047F8
	b loc_03804874	; 038047FC
loc_038047FE:
	cmp r3,#0x4	; 038047FE
	bge loc_03804816	; 03804800
	ldr r0,[pool_03804880]	; 03804802
	ldr r0,[r0,#0x0]	; 03804804
	cmp r3,r0	; 03804806
	beq loc_03804874	; 03804808
	mov r0,#0x3	; 0380480A
	mov r1,#0x66	; 0380480C
	mov r2,#0x1	; 0380480E
	bl loc_03802D98	; 03804810
	b loc_03804874	; 03804814
loc_03804816:
	ldr r6,[pool_03804884]	; 03804816
	sub r4,r3,#0x4	; 03804818
	mov r0,#0xc	; 0380481A
	mul r4,r0	; 0380481C
	add r5,r6,r4	; 0380481E
	ldr r0,[pool_03804888]	; 03804820
	ldr r0,[r0,#0x0]	; 03804822
	ldrh r1,[r5,#0xa]	; 03804824
	bl loc_03803244	; 03804826
	add r2,r0,#0x0	; 0380482A
	mov r0,#0x0	; 0380482C
	ldr r1,[pool_0380488C]	; 0380482E
	bl loc_037FF930	; 03804830
	ldr r3,[r6,r4]	; 03804834
	ldr r2,[r5,#0x4]	; 03804836
	and r2,r1	; 03804838
	and r3,r0	; 0380483A
	mov r0,#0x0	; 0380483C
	eor r2,r0	; 0380483E
	eor r3,r0	; 03804840
	orr r2,r3	; 03804842
	beq loc_0380484A	; 03804844
	mov r3,#0x1	; 03804846
	b loc_0380484C	; 03804848
loc_0380484A:
	mov r3,#0x2	; 0380484A
loc_0380484C:
	ldr r0,[pool_03804888]	; 0380484C
	ldr r1,[r0,#0x0]	; 0380484E
	add r4,r1,#0x1	; 03804850
	str r4,[r0,#0x0]	; 03804852
	ldrh r2,[r5,#0x8]	; 03804854
	ldrh r1,[r5,#0xa]	; 03804856
	mul r2,r1	; 03804858
	cmp r4,r2	; 0380485A
	bcc loc_03804862	; 0380485C
	mov r1,#0x0	; 0380485E
	str r1,[r0,#0x0]	; 03804860
loc_03804862:
	ldr r0,[pool_03804880]	; 03804862
	ldr r0,[r0,#0x0]	; 03804864
	cmp r3,r0	; 03804866
	beq loc_03804874	; 03804868
	mov r0,#0x3	; 0380486A
	mov r1,#0x66	; 0380486C
	mov r2,#0x1	; 0380486E
	bl loc_03802D98	; 03804870
loc_03804874:
	pop {r4,r5,r6}	; 03804874
	pop {r3}	; 03804876
	bx r3	; 03804878
	.byte 0xC0, 0x46	; 0380487C
pool_0380487C:
loc_0380487C:
	.word P2_BssStart + 0x26D4	; 0380487C
pool_03804880:
loc_03804880:
	.word P2_Data_0380530C	; 03804880
pool_03804884:
loc_03804884:
	.word 0x03805310	; 03804884
pool_03804888:
loc_03804888:
	.word P2_BssStart + 0x26D0	; 03804888
pool_0380488C:
loc_0380488C:
	.word 0x80000000	; 0380488C

; ===== function loc_03804890 =====
loc_03804890:
	push {lr}	; 03804890
	sub sp,#0x4	; 03804892
	mov r0,#0x0	; 03804894
	str r0,[sp,#0x0]	; 03804896
	add r0,sp,#0x0	; 03804898
	ldr r1,[pool_038048B0]	; 0380489A
	ldr r2,[pool_038048B4]	; 0380489C
	bl loc_0380491C	; 0380489E
	bl loc_037FAFF4	; 038048A2
	ldr r1,[pool_038048B0]	; 038048A6
	strh r0,[r1,#0x2]	; 038048A8
	add sp,#0x4	; 038048AA
	pop {r3}	; 038048AC
	bx r3	; 038048AE
pool_038048B0:
loc_038048B0:
	.word P2_BssStart + 0x26D8	; 038048B0
pool_038048B4:
loc_038048B4:
	.word 0x05000001	; 038048B4

; ===== function loc_038048B8 =====
loc_038048B8:
	push {lr}	; 038048B8
	sub sp,#0x4	; 038048BA
	ldr r0,[pool_038048D4]	; 038048BC
	ldr r1,[r0,#0x0]	; 038048BE
	cmp r1,#0x0	; 038048C0
	bne loc_038048CC	; 038048C2
	mov r1,#0x1	; 038048C4
	str r1,[r0,#0x0]	; 038048C6
	bl loc_03804890	; 038048C8
loc_038048CC:
	add sp,#0x4	; 038048CC
	pop {r3}	; 038048CE
	bx r3	; 038048D0
	.byte 0xC0, 0x46	; 038048D4
pool_038048D4:
loc_038048D4:
	.word P2_BssStart + 0x26DC	; 038048D4
	.byte 0x00, 0xDF, 0x70, 0x47	; 038048DC

.func P2_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_038048DC:
	swi 0x3	; 038048DC
	bx lr	; 038048DE
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
; ===== function loc_038048F6 =====
loc_038048F6:
	swi 0x6	; 038048F6
	bx lr	; 038048F8

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
; ===== function loc_03804902 =====
loc_03804902:
	add r1,r0,#0x0	; 03804902
	mov r0,#0x1	; 03804904
	swi 0x8	; 03804906
	bx lr	; 03804908

.endfunc

.func P2_SwiSoundBiasDecrease
; BIOS SWI #08 wrapper: request sound-bias decrease. / BIOS SWI #08 封装：请求降低声音偏置。
; ===== function loc_0380490A =====
loc_0380490A:
	add r1,r0,#0x0	; 0380490A
	mov r0,#0x0	; 0380490C
	swi 0x8	; 0380490E
	bx lr	; 03804910

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
	bx lr	; 0380491C
.endfunc

.func P2_SwiCpuSet
; BIOS SWI #0B: configurable memory copy/fill. / BIOS SWI #0B：可配置的内存复制/填充。
; ===== function loc_0380491C =====
loc_0380491C:
	swi 0xb	; 0380491C
	bx lr	; 0380491E

.endfunc

.func P2_SwiCpuFastSet
; BIOS SWI #0C: fast 32-byte memory copy/fill. / BIOS SWI #0C：快速 32 字节内存复制/填充。
; ===== function loc_03804920 =====
loc_03804920:
	swi 0xc	; 03804920
	bx lr	; 03804922

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

; ===== function loc_0380494C =====
.func P2_SwiGetPitchTable
; BIOS SWI #1B: obtain pitch-table entry. / BIOS SWI #1B：取得音高表项。
loc_0380494C:
	swi 0x1b	; 0380494C
	bx lr	; 0380494E
.endfunc

; ===== function loc_03804950 =====
.func P2_SwiGetVolumeTable
; BIOS SWI #1C: obtain volume-table entry. / BIOS SWI #1C：取得音量表项。
loc_03804950:
	swi 0x1c	; 03804950
	bx lr	; 03804952
.endfunc
.arm

; ===== function loc_03804954 =====
loc_03804954:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804954
	mov r4,#0x0	; 03804958
	b loc_03804968	; 0380495C
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 03804968
loc_03804968:
	orrs r5,r3,r2	; 03804968
	bne loc_03804978	; 0380496C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804970
	bx lr	; 03804974
loc_03804978:
	orrs r5,r1,r3	; 03804978
	bne loc_03804A20	; 0380497C
	mov r1,r2	; 03804980
	bl loc_03804DC0	; 03804984
	cmp r4,#0x0	; 03804988
	movne r0,r1	; 0380498C
	mov r1,#0x0	; 03804990
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804994
	bx lr	; 03804998
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 038049AC

; ===== function loc_038049AC =====
loc_038049AC:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049AC
	eor r4,r1,r3	; 038049B0
	mov r4,r4, asr #0x1	; 038049B4
	mov r4,r4, lsl #0x1	; 038049B8
	orrs r5,r3,r2	; 038049BC
	bne loc_038049CC	; 038049C0
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049C4
	bx lr	; 038049C8
loc_038049CC:
	mov r5,r0, lsr #0x1f	; 038049CC
	add r5,r5,r1	; 038049D0
	mov r6,r2, lsr #0x1f	; 038049D4
	add r6,r6,r3	; 038049D8
	orrs r6,r5,r6	; 038049DC
	bne loc_03804A00	; 038049E0
	mov r1,r2	; 038049E4
	bl loc_03804BAC	; 038049E8
	ands r4,r4,#0x1	; 038049EC
	movne r0,r1	; 038049F0
	mov r1,r0, asr #0x1f	; 038049F4
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049F8
	bx lr	; 038049FC
loc_03804A00:
	cmp r1,#0x0	; 03804A00
	bge loc_03804A10	; 03804A04
	rsbs r0,r0,#0x0	; 03804A08
	rsc r1,r1,#0x0	; 03804A0C
loc_03804A10:
	cmp r3,#0x0	; 03804A10
	bge loc_03804A20	; 03804A14
	rsbs r2,r2,#0x0	; 03804A18
	rsc r3,r3,#0x0	; 03804A1C
loc_03804A20:
	orrs r5,r1,r0	; 03804A20
	beq loc_03804B44	; 03804A24
	mov r5,#0x0	; 03804A28
	mov r6,#0x1	; 03804A2C
	cmp r3,#0x0	; 03804A30
	bmi loc_03804A4C	; 03804A34
loc_03804A38:
	add r5,r5,#0x1	; 03804A38
	adds r2,r2,r2	; 03804A3C
	adcs r3,r3,r3	; 03804A40
	bpl loc_03804A38	; 03804A44
	add r6,r6,r5	; 03804A48
loc_03804A4C:
	cmp r1,#0x0	; 03804A4C
	blt loc_03804A6C	; 03804A50
loc_03804A54:
	cmp r6,#0x1	; 03804A54
	beq loc_03804A6C	; 03804A58
	sub r6,r6,#0x1	; 03804A5C
	adds r0,r0,r0	; 03804A60
	adcs r1,r1,r1	; 03804A64
	bpl loc_03804A54	; 03804A68
loc_03804A6C:
	mov r7,#0x0	; 03804A6C
	mov r12,#0x0	; 03804A70
	mov r11,#0x0	; 03804A74
	b loc_03804A94	; 03804A78
loc_03804A7C:
	orr r12,r12,#0x1	; 03804A7C
	subs r6,r6,#0x1	; 03804A80
	beq loc_03804AEC	; 03804A84
	adds r0,r0,r0	; 03804A88
	adcs r1,r1,r1	; 03804A8C
	adcs r7,r7,r7	; 03804A90
loc_03804A94:
	subs r0,r0,r2	; 03804A94
	sbcs r1,r1,r3	; 03804A98
	sbcs r7,r7,#0x0	; 03804A9C
	adds r12,r12,r12	; 03804AA0
	adc r11,r11,r11	; 03804AA4
	cmp r7,#0x0	; 03804AA8
	bge loc_03804A7C	; 03804AAC
loc_03804AB0:
	subs r6,r6,#0x1	; 03804AB0
	beq loc_03804AE4	; 03804AB4
	adds r0,r0,r0	; 03804AB8
	adcs r1,r1,r1	; 03804ABC
	adc r7,r7,r7	; 03804AC0
	adds r0,r0,r2	; 03804AC4
	adcs r1,r1,r3	; 03804AC8
	adc r7,r7,#0x0	; 03804ACC
	adds r12,r12,r12	; 03804AD0
	adc r11,r11,r11	; 03804AD4
	cmp r7,#0x0	; 03804AD8
	bge loc_03804A7C	; 03804ADC
	b loc_03804AB0	; 03804AE0
loc_03804AE4:
	adds r0,r0,r2	; 03804AE4
	adc r1,r1,r3	; 03804AE8
loc_03804AEC:
	ands r7,r4,#0x1	; 03804AEC
	moveq r0,r12	; 03804AF0
	moveq r1,r11	; 03804AF4
	beq loc_03804B24	; 03804AF8
	subs r7,r5,#0x20	; 03804AFC
	movge r0,r1, lsr r7	; 03804B00
	bge loc_03804B48	; 03804B04
	rsb r7,r5,#0x20	; 03804B08
	mov r0,r0, lsr r5	; 03804B0C
	orr r0,r0,r1, lsl r7	; 03804B10
	mov r1,r1, lsr r5	; 03804B14
	b loc_03804B24	; 03804B18
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 03804B24
loc_03804B24:
	cmp r4,#0x0	; 03804B24
	blt loc_03804B34	; 03804B28
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B2C
	bx lr	; 03804B30
loc_03804B34:
	rsbs r0,r0,#0x0	; 03804B34
	rsc r1,r1,#0x0	; 03804B38
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B3C
	bx lr	; 03804B40
loc_03804B44:
	mov r0,#0x0	; 03804B44
loc_03804B48:
	mov r1,#0x0	; 03804B48
	cmp r4,#0x0	; 03804B4C
	blt loc_03804B34	; 03804B50
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B54
	bx lr	; 03804B58

; ===== function loc_03804B5C =====
loc_03804B5C:
	stmdb sp!,{r4,r5,lr}	; 03804B5C
	umull r5,r4,r0,r2	; 03804B60
	mla r4,r0,r3,r4	; 03804B64
	mla r4,r2,r1,r4	; 03804B68
	mov r1,r4	; 03804B6C
	mov r0,r5	; 03804B70
	ldmia sp!,{r4,r5,lr}	; 03804B74
	bx lr	; 03804B78

; ===== function loc_03804B7C =====
loc_03804B7C:
	ands r2,r2,#0x3f	; 03804B7C
	bxeq lr	; 03804B80
	subs r3,r2,#0x20	; 03804B84
	bge loc_03804BA0	; 03804B88
	rsb r3,r2,#0x20	; 03804B8C
	mov r1,r1, lsl r2	; 03804B90
	orr r1,r1,r0, lsr r3	; 03804B94
	mov r0,r0, lsl r2	; 03804B98
	bx lr	; 03804B9C
loc_03804BA0:
	mov r1,r0, lsl r3	; 03804BA0
	mov r0,#0x0	; 03804BA4
	bx lr	; 03804BA8

; Signed integer division: quotient in r0, remainder in r1.
; 有符号整数除法：商返回于 r0，余数返回于 r1。
P2_SignedDivMod:
loc_03804BAC:
	eor r12,r0,r1	; 03804BAC
	and r12,r12,#0x80000000	; 03804BB0
	cmp r0,#0x0	; 03804BB4
	rsblt r0,r0,#0x0	; 03804BB8
	addlt r12,r12,#0x1	; 03804BBC
	cmp r1,#0x0	; 03804BC0
	rsblt r1,r1,#0x0	; 03804BC4
	beq loc_03804DA4	; 03804BC8
	cmp r0,r1	; 03804BCC
	movcc r1,r0	; 03804BD0
	movcc r0,#0x0	; 03804BD4
	bcc loc_03804DA4	; 03804BD8
	mov r2,#0x1c	; 03804BDC
	mov r3,r0, lsr #0x4	; 03804BE0
	cmp r1,r3, lsr #0xc	; 03804BE4
	suble r2,r2,#0x10	; 03804BE8
	movle r3,r3, lsr #0x10	; 03804BEC
	cmp r1,r3, lsr #0x4	; 03804BF0
	suble r2,r2,#0x8	; 03804BF4
	movle r3,r3, lsr #0x8	; 03804BF8
	cmp r1,r3	; 03804BFC
	suble r2,r2,#0x4	; 03804C00
	movle r3,r3, lsr #0x4	; 03804C04
	mov r0,r0, lsl r2	; 03804C08
	rsb r1,r1,#0x0	; 03804C0C
	adds r0,r0,r0	; 03804C10
	add r2,r2,r2, lsl #0x1	; 03804C14
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804C18PC:
	add pc,pc,r2, lsl #0x2	; 03804C18
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804C20
loc_03804C20:
P2_DivisionDispatch_03804C18Steps:
	adcs r3,r1,r3, lsl #0x1	; 03804C20
	subcc r3,r3,r1	; 03804C24
	adcs r0,r0,r0	; 03804C28
	adcs r3,r1,r3, lsl #0x1	; 03804C2C
	subcc r3,r3,r1	; 03804C30
	adcs r0,r0,r0	; 03804C34
	adcs r3,r1,r3, lsl #0x1	; 03804C38
	subcc r3,r3,r1	; 03804C3C
	adcs r0,r0,r0	; 03804C40
	adcs r3,r1,r3, lsl #0x1	; 03804C44
	subcc r3,r3,r1	; 03804C48
	adcs r0,r0,r0	; 03804C4C
loc_03804C50:
	adcs r3,r1,r3, lsl #0x1	; 03804C50
	subcc r3,r3,r1	; 03804C54
	adcs r0,r0,r0	; 03804C58
	adcs r3,r1,r3, lsl #0x1	; 03804C5C
	subcc r3,r3,r1	; 03804C60
	adcs r0,r0,r0	; 03804C64
	adcs r3,r1,r3, lsl #0x1	; 03804C68
	subcc r3,r3,r1	; 03804C6C
	adcs r0,r0,r0	; 03804C70
	adcs r3,r1,r3, lsl #0x1	; 03804C74
	subcc r3,r3,r1	; 03804C78
	adcs r0,r0,r0	; 03804C7C
loc_03804C80:
	adcs r3,r1,r3, lsl #0x1	; 03804C80
	subcc r3,r3,r1	; 03804C84
	adcs r0,r0,r0	; 03804C88
	adcs r3,r1,r3, lsl #0x1	; 03804C8C
	subcc r3,r3,r1	; 03804C90
	adcs r0,r0,r0	; 03804C94
	adcs r3,r1,r3, lsl #0x1	; 03804C98
	subcc r3,r3,r1	; 03804C9C
	adcs r0,r0,r0	; 03804CA0
	adcs r3,r1,r3, lsl #0x1	; 03804CA4
	subcc r3,r3,r1	; 03804CA8
	adcs r0,r0,r0	; 03804CAC
	adcs r3,r1,r3, lsl #0x1	; 03804CB0
	subcc r3,r3,r1	; 03804CB4
	adcs r0,r0,r0	; 03804CB8
	adcs r3,r1,r3, lsl #0x1	; 03804CBC
	subcc r3,r3,r1	; 03804CC0
	adcs r0,r0,r0	; 03804CC4
	adcs r3,r1,r3, lsl #0x1	; 03804CC8
	subcc r3,r3,r1	; 03804CCC
	adcs r0,r0,r0	; 03804CD0
	adcs r3,r1,r3, lsl #0x1	; 03804CD4
	subcc r3,r3,r1	; 03804CD8
	adcs r0,r0,r0	; 03804CDC
loc_03804CE0:
	adcs r3,r1,r3, lsl #0x1	; 03804CE0
	subcc r3,r3,r1	; 03804CE4
	adcs r0,r0,r0	; 03804CE8
	adcs r3,r1,r3, lsl #0x1	; 03804CEC
	subcc r3,r3,r1	; 03804CF0
	adcs r0,r0,r0	; 03804CF4
	adcs r3,r1,r3, lsl #0x1	; 03804CF8
	subcc r3,r3,r1	; 03804CFC
	adcs r0,r0,r0	; 03804D00
	adcs r3,r1,r3, lsl #0x1	; 03804D04
	subcc r3,r3,r1	; 03804D08
	adcs r0,r0,r0	; 03804D0C
	adcs r3,r1,r3, lsl #0x1	; 03804D10
	subcc r3,r3,r1	; 03804D14
	adcs r0,r0,r0	; 03804D18
	adcs r3,r1,r3, lsl #0x1	; 03804D1C
	subcc r3,r3,r1	; 03804D20
	adcs r0,r0,r0	; 03804D24
	adcs r3,r1,r3, lsl #0x1	; 03804D28
	subcc r3,r3,r1	; 03804D2C
	adcs r0,r0,r0	; 03804D30
	adcs r3,r1,r3, lsl #0x1	; 03804D34
	subcc r3,r3,r1	; 03804D38
	adcs r0,r0,r0	; 03804D3C
	adcs r3,r1,r3, lsl #0x1	; 03804D40
	subcc r3,r3,r1	; 03804D44
	adcs r0,r0,r0	; 03804D48
	adcs r3,r1,r3, lsl #0x1	; 03804D4C
	subcc r3,r3,r1	; 03804D50
	adcs r0,r0,r0	; 03804D54
	adcs r3,r1,r3, lsl #0x1	; 03804D58
	subcc r3,r3,r1	; 03804D5C
	adcs r0,r0,r0	; 03804D60
	adcs r3,r1,r3, lsl #0x1	; 03804D64
	subcc r3,r3,r1	; 03804D68
	adcs r0,r0,r0	; 03804D6C
	adcs r3,r1,r3, lsl #0x1	; 03804D70
	subcc r3,r3,r1	; 03804D74
	adcs r0,r0,r0	; 03804D78
	adcs r3,r1,r3, lsl #0x1	; 03804D7C
	subcc r3,r3,r1	; 03804D80
	adcs r0,r0,r0	; 03804D84
	adcs r3,r1,r3, lsl #0x1	; 03804D88
	subcc r3,r3,r1	; 03804D8C
	adcs r0,r0,r0	; 03804D90
	adcs r3,r1,r3, lsl #0x1	; 03804D94
	subcc r3,r3,r1	; 03804D98
	adcs r0,r0,r0	; 03804D9C
P2_DivisionDispatch_03804C18End:
.if (P2_DivisionDispatch_03804C18Steps != P2_DivisionDispatch_03804C18PC + 8) || (P2_DivisionDispatch_03804C18End - P2_DivisionDispatch_03804C18Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03804DA0
loc_03804DA4:
	ands r3,r12,#0x80000000	; 03804DA4
	rsbne r0,r0,#0x0	; 03804DA8
	ands r3,r12,#0x1	; 03804DAC
	rsbne r1,r1,#0x0	; 03804DB0
	bx lr	; 03804DB4

; ===== function loc_03804DB8 =====
loc_03804DB8:
	cmp r1,#0x0	; 03804DB8
	bxeq lr	; 03804DBC

; ===== function loc_03804DC0 =====
loc_03804DC0:
	cmp r0,r1	; 03804DC0
	movcc r1,r0	; 03804DC4
	movcc r0,#0x0	; 03804DC8
	bxcc lr	; 03804DCC
	mov r2,#0x1c	; 03804DD0
	mov r3,r0, lsr #0x4	; 03804DD4
	cmp r1,r3, lsr #0xc	; 03804DD8
	suble r2,r2,#0x10	; 03804DDC
	movle r3,r3, lsr #0x10	; 03804DE0
	cmp r1,r3, lsr #0x4	; 03804DE4
	suble r2,r2,#0x8	; 03804DE8
	movle r3,r3, lsr #0x8	; 03804DEC
	cmp r1,r3	; 03804DF0
	suble r2,r2,#0x4	; 03804DF4
	movle r3,r3, lsr #0x4	; 03804DF8
	mov r0,r0, lsl r2	; 03804DFC
	rsb r1,r1,#0x0	; 03804E00
	adds r0,r0,r0	; 03804E04
	add r2,r2,r2, lsl #0x1	; 03804E08
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804E0CPC:
	add pc,pc,r2, lsl #0x2	; 03804E0C
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804E14
loc_03804E14:
P2_DivisionDispatch_03804E0CSteps:
	adcs r3,r1,r3, lsl #0x1	; 03804E14
	subcc r3,r3,r1	; 03804E18
	adcs r0,r0,r0	; 03804E1C
	adcs r3,r1,r3, lsl #0x1	; 03804E20
	subcc r3,r3,r1	; 03804E24
	adcs r0,r0,r0	; 03804E28
	adcs r3,r1,r3, lsl #0x1	; 03804E2C
	subcc r3,r3,r1	; 03804E30
	adcs r0,r0,r0	; 03804E34
	adcs r3,r1,r3, lsl #0x1	; 03804E38
	subcc r3,r3,r1	; 03804E3C
	adcs r0,r0,r0	; 03804E40
loc_03804E44:
	adcs r3,r1,r3, lsl #0x1	; 03804E44
	subcc r3,r3,r1	; 03804E48
	adcs r0,r0,r0	; 03804E4C
	adcs r3,r1,r3, lsl #0x1	; 03804E50
	subcc r3,r3,r1	; 03804E54
	adcs r0,r0,r0	; 03804E58
	adcs r3,r1,r3, lsl #0x1	; 03804E5C
	subcc r3,r3,r1	; 03804E60
	adcs r0,r0,r0	; 03804E64
	adcs r3,r1,r3, lsl #0x1	; 03804E68
	subcc r3,r3,r1	; 03804E6C
	adcs r0,r0,r0	; 03804E70
loc_03804E74:
	adcs r3,r1,r3, lsl #0x1	; 03804E74
	subcc r3,r3,r1	; 03804E78
	adcs r0,r0,r0	; 03804E7C
	adcs r3,r1,r3, lsl #0x1	; 03804E80
	subcc r3,r3,r1	; 03804E84
	adcs r0,r0,r0	; 03804E88
	adcs r3,r1,r3, lsl #0x1	; 03804E8C
	subcc r3,r3,r1	; 03804E90
	adcs r0,r0,r0	; 03804E94
	adcs r3,r1,r3, lsl #0x1	; 03804E98
	subcc r3,r3,r1	; 03804E9C
	adcs r0,r0,r0	; 03804EA0
	adcs r3,r1,r3, lsl #0x1	; 03804EA4
	subcc r3,r3,r1	; 03804EA8
	adcs r0,r0,r0	; 03804EAC
	adcs r3,r1,r3, lsl #0x1	; 03804EB0
	subcc r3,r3,r1	; 03804EB4
	adcs r0,r0,r0	; 03804EB8
	adcs r3,r1,r3, lsl #0x1	; 03804EBC
	subcc r3,r3,r1	; 03804EC0
	adcs r0,r0,r0	; 03804EC4
	adcs r3,r1,r3, lsl #0x1	; 03804EC8
	subcc r3,r3,r1	; 03804ECC
	adcs r0,r0,r0	; 03804ED0
loc_03804ED4:
	adcs r3,r1,r3, lsl #0x1	; 03804ED4
	subcc r3,r3,r1	; 03804ED8
	adcs r0,r0,r0	; 03804EDC
	adcs r3,r1,r3, lsl #0x1	; 03804EE0
	subcc r3,r3,r1	; 03804EE4
	adcs r0,r0,r0	; 03804EE8
	adcs r3,r1,r3, lsl #0x1	; 03804EEC
	subcc r3,r3,r1	; 03804EF0
	adcs r0,r0,r0	; 03804EF4
	adcs r3,r1,r3, lsl #0x1	; 03804EF8
	subcc r3,r3,r1	; 03804EFC
	adcs r0,r0,r0	; 03804F00
	adcs r3,r1,r3, lsl #0x1	; 03804F04
	subcc r3,r3,r1	; 03804F08
	adcs r0,r0,r0	; 03804F0C
	adcs r3,r1,r3, lsl #0x1	; 03804F10
	subcc r3,r3,r1	; 03804F14
	adcs r0,r0,r0	; 03804F18
	adcs r3,r1,r3, lsl #0x1	; 03804F1C
	subcc r3,r3,r1	; 03804F20
	adcs r0,r0,r0	; 03804F24
	adcs r3,r1,r3, lsl #0x1	; 03804F28
	subcc r3,r3,r1	; 03804F2C
	adcs r0,r0,r0	; 03804F30
	adcs r3,r1,r3, lsl #0x1	; 03804F34
	subcc r3,r3,r1	; 03804F38
	adcs r0,r0,r0	; 03804F3C
	adcs r3,r1,r3, lsl #0x1	; 03804F40
	subcc r3,r3,r1	; 03804F44
	adcs r0,r0,r0	; 03804F48
	adcs r3,r1,r3, lsl #0x1	; 03804F4C
	subcc r3,r3,r1	; 03804F50
	adcs r0,r0,r0	; 03804F54
	adcs r3,r1,r3, lsl #0x1	; 03804F58
	subcc r3,r3,r1	; 03804F5C
	adcs r0,r0,r0	; 03804F60
	adcs r3,r1,r3, lsl #0x1	; 03804F64
	subcc r3,r3,r1	; 03804F68
	adcs r0,r0,r0	; 03804F6C
	adcs r3,r1,r3, lsl #0x1	; 03804F70
	subcc r3,r3,r1	; 03804F74
	adcs r0,r0,r0	; 03804F78
	adcs r3,r1,r3, lsl #0x1	; 03804F7C
	subcc r3,r3,r1	; 03804F80
	adcs r0,r0,r0	; 03804F84
	adcs r3,r1,r3, lsl #0x1	; 03804F88
	subcc r3,r3,r1	; 03804F8C
	adcs r0,r0,r0	; 03804F90
P2_DivisionDispatch_03804E0CEnd:
.if (P2_DivisionDispatch_03804E0CSteps != P2_DivisionDispatch_03804E0CPC + 8) || (P2_DivisionDispatch_03804E0CEnd - P2_DivisionDispatch_03804E0CSteps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03804F94
	bx lr	; 03804F98

; ===== function loc_03804F9C =====
loc_03804F9C:
	ands r2,r2,#0x3f	; 03804F9C
	bxeq lr	; 03804FA0
	subs r3,r2,#0x20	; 03804FA4
	bge loc_03804FC0	; 03804FA8
	rsb r3,r2,#0x20	; 03804FAC
	mov r0,r0, lsr r2	; 03804FB0
	orr r0,r0,r1, lsl r3	; 03804FB4
	mov r1,r1, lsr r2	; 03804FB8
	bx lr	; 03804FBC
loc_03804FC0:
	mov r0,r1, lsr r3	; 03804FC0
	mov r1,#0x0	; 03804FC4
	bx lr	; 03804FC8

; ===== function loc_03804FCC =====
loc_03804FCC:
	stmdb sp!,{lr}	; 03804FCC
	bl loc_03805074	; 03804FD0
	mov r1,#0x0	; 03804FD4
	str r1,[r0,#0x0]	; 03804FD8
	bl loc_03805080	; 03804FDC
	mov r1,#0x0	; 03804FE0
	str r1,[r0,#0x4]	; 03804FE4
	str r1,[r0,#0x8]	; 03804FE8
	str r1,[r0,#0xc]	; 03804FEC
	str r1,[r0,#0x10]	; 03804FF0
	str r1,[r0,#0x14]	; 03804FF4
	ldmia sp!,{lr}	; 03804FF8
	bx lr	; 03804FFC
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x1A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805010
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03805020
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 03805030
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 03805040
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x0A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805050
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03805060
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 03805070
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 03805074

; ===== function loc_03805074 =====
loc_03805074:
	ldr r12,[pool_0380507C]	; 03805074
	bx r12	; 03805078
pool_0380507C:
loc_0380507C:
	.word loc_038050C4 + 1	; 0380507C

; ===== function loc_03805080 =====
loc_03805080:
	ldr r12,[pool_03805088]	; 03805080
	bx r12	; 03805084
pool_03805088:
loc_03805088:
	.word loc_038050CC + 1	; 03805088
.thumb

; ===== function loc_0380508C =====
loc_0380508C:
	bx r0	; 0380508C
	.byte 0x00, 0x00	; 03805090

; ===== function loc_03805090 =====
loc_03805090:
	bx r1	; 03805090
	.byte 0x00, 0x00	; 03805094

; ===== function loc_03805094 =====
loc_03805094:
	bx r2	; 03805094
	.byte 0x00, 0x00	; 03805098

; ===== function loc_03805098 =====
loc_03805098:
	bx r3	; 03805098
	.byte 0x00, 0x00	; 0380509C

; ===== function loc_0380509C =====
loc_0380509C:
	bx r4	; 0380509C
	.byte 0x00, 0x00	; 038050A0

; ===== function loc_038050A0 =====
loc_038050A0:
	bx r5	; 038050A0
	.byte 0x00, 0x00	; 038050A4

; ===== function loc_038050A4 =====
loc_038050A4:
	push {r4,lr}	; 038050A4
	ldr r4,[pool_038050C0]	; 038050A6
	b loc_038050AE	; 038050A8
loc_038050AA:
	.byte 0x80, 0x47, 0x24, 0x1D	; 038050AE
loc_038050AE:
	cmp r4,#0x0	; 038050AE
	beq loc_038050B8	; 038050B0
	ldr r0,[r4,#0x0]	; 038050B2
	cmp r0,#0x0	; 038050B4
	bne loc_038050AA	; 038050B6
loc_038050B8:
	pop {r4}	; 038050B8
	pop {r3}	; 038050BA
	bx r3	; 038050BC
	.byte 0xC0, 0x46	; 038050C0
pool_038050C0:
loc_038050C0:
	.word 0x03805250	; 038050C0

; ===== function loc_038050C4 =====
loc_038050C4:
	ldr r0,[pool_038050C8]	; 038050C4
	bx lr	; 038050C6
pool_038050C8:
loc_038050C8:
	.word 0x03807A80	; 038050C8

; ===== function loc_038050CC =====
loc_038050CC:
	ldr r0,[pool_038050D0]	; 038050CC
	bx lr	; 038050CE
pool_038050D0:
loc_038050D0:
	.word 0x03807A84	; 038050D0
	.byte 0xA5, 0x50, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00	; 038050D4
P2_Data_038050E0:
	.byte 0x49, 0x32, 0x00, 0x00	; 038050E0
P2_Data_038050E4:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 038050E4
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 038050F4
P2_Data_03805104:
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 03805104
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 03805114
	.byte 0x7F, 0x00, 0x00, 0x00	; 03805124
P2_Data_03805128:
	.byte 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 03805128
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 03805134
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 03805144
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 03805154
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 03805164
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 03805174
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 03805184
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 03805194
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 038051A4
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 038051B4
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 038051C4
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 038051D4
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 038051E4
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 038051F4
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 03805204
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 03805214
	.byte 0xFF, 0xFF, 0x00, 0x00	; 03805224
P2_Data_03805228:
	.byte 0x00, 0x01, 0x02, 0x04	; 03805228
P2_Data_0380522C:
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 0380522C
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D	; 03805234
P2_Data_0380523C:
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 0380523C
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805244
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P2_CrtDataInitTable:
	.word P2_CopyDescriptors, P2_CopyDescriptorsEnd
	.word P2_WramCopy0LoadStart
	.word P2_BssStart, P2_BssEnd
P2_Data_03805268:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 03805268
	.byte 0x00, 0x00, 0x00, 0x00	; 03805278
P2_Data_0380527C:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P2_IrqHandlers:
	.word P2_IrqHandler_037FD954 + 1	; IRQ 0
	.word loc_037FDA44 + 1	; IRQ 1
	.word loc_037FDA44 + 1	; IRQ 2
	.word P2_IrqHandler_037FD9AC + 1	; IRQ 3
	.word P2_IrqHandler_037FD9A0 + 1	; IRQ 4
	.word P2_IrqHandler_037FD994 + 1	; IRQ 5
	.word P2_IrqHandler_037FD988 + 1	; IRQ 6
	.word loc_037FDA44 + 1	; IRQ 7
	.word P2_IrqHandler_037FD9DC + 1	; IRQ 8
	.word P2_IrqHandler_037FD9D0 + 1	; IRQ 9
	.word P2_IrqHandler_037FD9C4 + 1	; IRQ 10
	.word P2_IrqHandler_037FD9B8 + 1	; IRQ 11
	.word loc_037FDA44 + 1	; IRQ 12
	.word loc_037FDA44 + 1	; IRQ 13
	.word loc_037FDA44 + 1	; IRQ 14
	.word loc_037FDA44 + 1	; IRQ 15
	.word loc_037FDA44 + 1	; IRQ 16
	.word loc_037FDA44 + 1	; IRQ 17
	.word loc_037FDA44 + 1	; IRQ 18
	.word loc_037FDA44 + 1	; IRQ 19
	.word loc_037FDA44 + 1	; IRQ 20
	.word loc_037FDA44 + 1	; IRQ 21
	.word loc_037FDA44 + 1	; IRQ 22
	.word loc_037FDA44 + 1	; IRQ 23
	.word loc_037FDA44 + 1	; IRQ 24
P2_IrqHandlersEnd:
	.byte 0x15, 0xDE, 0x7F, 0x03	; 038052E0
.thumb
P2_Data_038052E4:
	.word 0x12345678	; 038052F4
; ARM7 sound-alarm diagnostic string. / ARM7 声音告警诊断字符串。
P2_SoundAlarmDiagnosticText:
	.ascii "Failed sound alarm OS_SendMessage"
	.byte 0x0A, 0x00, 0x00	; 03805309
P2_Data_0380530C:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x08	; 0380530C
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC, 0x08, 0x00, 0x01, 0x00, 0x00	; 03805319
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805329
	.byte 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0xF8, 0x14	; 03805339
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x0C, 0x00, 0x01, 0x00, 0x00	; 03805349
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805359
	.byte 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x20	; 03805369
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00	; 03805379
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805389
	.byte 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00	; 03805399
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
P2_Runtime_037F8000:
.thumb
; 按共享键值和 Game Code 匹配表项，复制 20 字节补丁并更新共享状态。
; Match the shared key and Game Code, copy a 20-byte patch, then update shared state.
.func P2_ApplyKeyedRuntimePatch
	push {lr}	; 037F8000
	sub sp,#0x4	; 037F8002
	mov r0,#0x1	; 037F8004
	ldr r1,[pool_037F8050]	; 037F8006
	ldr r2,[pool_037F8054]	; 037F8008
	ldr r2,[r2,#0x0]	; 037F800A
	cmp r2,#0x0	; 037F800C
	bne P2_Runtime_037F803A	; 037F800E
	b P2_Entry_037F8048	; 037F8010
P2_Runtime_037F8012:
	ldr r2,[pool_037F8058]	; 037F8012
	ldr r3,[r2,#0x0]	; 037F8014
	ldr r2,[r1,#0x4]	; 037F8016
	cmp r3,r2	; 037F8018
	bne P2_Runtime_037F8038	; 037F801A
	ldr r2,[pool_037F805C]	; 037F801C
	ldr r3,[r2,#0x0]	; 037F801E
	ldr r2,[r1,#0x0]	; 037F8020
	cmp r3,r2	; 037F8022
	bne P2_Runtime_037F8038	; 037F8024
	ldr r0,[pool_037F8060]	; 037F8026
	ldr r1,[r1,#0x8]	; 037F8028
	mov r2,#0x5	; 037F802A
	bl P2_SwiCpuFastSet	; 037F802C
	mov r1,#0x0	; 037F8030
	ldr r0,[pool_037F8054]	; 037F8032
	str r1,[r0,#0x0]	; 037F8034
	b P2_Entry_037F8042	; 037F8036
P2_Runtime_037F8038:
	add r1,#0xc	; 037F8038
P2_Runtime_037F803A:
	add r2,r0,#0x0	; 037F803A
	sub r0,r0,#0x1	; 037F803C
	cmp r2,#0x0	; 037F803E
	bgt P2_Runtime_037F8012	; 037F8040
P2_Entry_037F8042:
	mov r1,#0x0	; 037F8042
	ldr r0,[pool_037F8058]	; 037F8044
	str r1,[r0,#0x0]	; 037F8046
P2_Entry_037F8048:
	add sp,#0x4	; 037F8048
	pop {r3}	; 037F804A
	bx r3	; 037F804C
.endfunc
	.byte 0xC0, 0x46	; 037F804E
pool_037F8050:
	.word P2_RuntimePatchKeyTable	; 037F8050
pool_037F8054:
	.word FirmwareBootSharedAddress + BootSharedRuntimePatchFlagsOffset	; 037F8054
pool_037F8058:
	.word FirmwareBootSharedAddress + BootSharedRuntimePatchKeyOffset	; 037F8058
pool_037F805C:
	.word NdsCartHeaderRamAddress + 0xC	; 037F805C
pool_037F8060:
	.word P2_RuntimePatchTemplate	; 037F8060
P2_Runtime_037F8064:
; 按 Game Code、版本及可选标志筛选；复制补丁和可选的两字替换。
; Filter by Game Code, revision and optional flags; apply a patch and optional two-word replacement.
.func P2_ApplyGameCodeRevisionPatch
	push {r4,r5,r6,r7,lr}	; 037F8064
	sub sp,#0x4	; 037F8066
	mov r3,#0x0	; 037F8068
	mov r2,#0xb	; 037F806A
	ldr r1,[pool_037F80DC]	; 037F806C
	ldr r7,[pool_037F80E0]	; 037F806E
	ldr r5,[pool_037F80E4]	; 037F8070
	ldr r0,[pool_037F80E8]	; 037F8072
	b P2_Entry_037F80AC	; 037F8074
P2_Runtime_037F8076:
	ldr r6,[r0,#0x0]	; 037F8076
	ldr r4,[r1,#0x0]	; 037F8078
	cmp r6,r4	; 037F807A
	bne P2_Runtime_037F80AA	; 037F807C
	ldr r4,[r7,#0x0]	; 037F807E
	cmp r4,#0x0	; 037F8080
	beq P2_Runtime_037F8090	; 037F8082
	lsl r4,r4,#0x18	; 037F8084
	lsr r6,r4,#0x18	; 037F8086
	ldrb r4,[r1,#0x5]	; 037F8088
	and r6,r4	; 037F808A
	cmp r6,#0x0	; 037F808C
	beq P2_Runtime_037F80AA	; 037F808E
P2_Runtime_037F8090:
	ldrb r6,[r1,#0x4]	; 037F8090
	cmp r6,#0xff	; 037F8092
	bne P2_Runtime_037F80A0	; 037F8094
	ldrb r4,[r5,#0x0]	; 037F8096
	cmp r4,#0x8	; 037F8098
	bcs P2_Runtime_037F80AA	; 037F809A
	mov r3,#0x1	; 037F809C
	b P2_Entry_037F80B4	; 037F809E
P2_Runtime_037F80A0:
	ldrb r4,[r5,#0x0]	; 037F80A0
	cmp r6,r4	; 037F80A2
	bne P2_Runtime_037F80AA	; 037F80A4
	mov r3,#0x1	; 037F80A6
	b P2_Entry_037F80B4	; 037F80A8
P2_Runtime_037F80AA:
	add r1,#0x10	; 037F80AA
P2_Entry_037F80AC:
	add r4,r2,#0x0	; 037F80AC
	sub r2,r2,#0x1	; 037F80AE
	cmp r4,#0x0	; 037F80B0
	bgt P2_Runtime_037F8076	; 037F80B2
P2_Entry_037F80B4:
	cmp r3,#0x0	; 037F80B4
	beq P2_Runtime_037F80D2	; 037F80B6
	ldr r3,[r1,#0xc]	; 037F80B8
	cmp r3,#0x0	; 037F80BA
	beq P2_Runtime_037F80C8	; 037F80BC
	ldr r0,[pool_037F80EC]	; 037F80BE
	ldr r2,[r0,#0x0]	; 037F80C0
	str r2,[r3,#0x0]	; 037F80C2
	ldr r0,[r0,#0x4]	; 037F80C4
	str r0,[r3,#0x4]	; 037F80C6
P2_Runtime_037F80C8:
	ldr r0,[pool_037F80F0]	; 037F80C8
	ldr r1,[r1,#0x8]	; 037F80CA
	mov r2,#0x5	; 037F80CC
	bl P2_SwiCpuFastSet	; 037F80CE
P2_Runtime_037F80D2:
	add sp,#0x4	; 037F80D2
	pop {r4,r5,r6,r7}	; 037F80D4
	pop {r3}	; 037F80D6
	bx r3	; 037F80D8
.endfunc
	.byte 0xC0, 0x46	; 037F80DA
pool_037F80DC:
	.word P2_RuntimePatchGameTable	; 037F80DC
pool_037F80E0:
	.word FirmwareBootSharedAddress + BootSharedRuntimePatchFlagsOffset	; 037F80E0
pool_037F80E4:
	.word NdsCartHeaderRamAddress + 0x1E	; 037F80E4
pool_037F80E8:
	.word NdsCartHeaderRamAddress + 0xC	; 037F80E8
pool_037F80EC:
	.word P2_RuntimePatchExtraWords	; 037F80EC
pool_037F80F0:
	.word P2_RuntimePatchTemplate	; 037F80F0

P2_RuntimePatchExtraWords:
; 复制到外部程序的编码模板，不在此地址执行。
; Encoded template copied into an external program, not executed here.
	.word 0xE3A00001, 0xE3A00001

P2_RuntimePatchKeyTable:
; Game Code、共享键、外部程序补丁地址。 / Game Code, shared key, external patch address.
	.ascii "NTRJ"
	.word 0x00000051, 0x022DB8E8

P2_RuntimePatchTemplate:
; 复制到外部程序的编码模板，不在此地址执行。
; Encoded template copied into an external program, not executed here.
	.word 0xE3500005, 0x312FFF1E, 0xE1D100B0, 0xE3500008
	.word 0x9AFFFFF6

P2_RuntimePatchGameTable:
; 每项：Game Code、版本、标志掩码、保留半字、外部程序的两个目标地址。
; Each entry: Game Code, revision, flag mask, reserved halfword, two external destinations.
	.ascii "AYAJ"
	.byte 0x00, 0x01
	.halfword 0x0000
	.word 0x022DB8EC, 0x00000000
	.ascii "AYAJ"
	.byte 0x01, 0x01
	.halfword 0x0000
	.word 0x022DB8EC, 0x00000000
	.ascii "ATGJ"
	.byte 0x00, 0x01
	.halfword 0x0000
	.word 0x022DBBAC, 0x00000000
	.ascii "ADMJ"
	.byte 0xFF, 0x00
	.halfword 0x0000
	.word 0x022DE964, 0x022DAEDC
	.ascii "ADME"
	.byte 0xFF, 0x00
	.halfword 0x0000
	.word 0x022DE964, 0x022DAEDC
	.ascii "ADMP"
	.byte 0xFF, 0x00
	.halfword 0x0000
	.word 0x022DE964, 0x022DAEDC
	.ascii "ASCJ"
	.byte 0x00, 0x00
	.halfword 0x0000
	.word 0x022DB8E8, 0x00000000
	.ascii "ASCE"
	.byte 0x00, 0x00
	.halfword 0x0000
	.word 0x022DB8E8, 0x00000000
	.ascii "ASCP"
	.byte 0x00, 0x00
	.halfword 0x0000
	.word 0x022DB8E8, 0x00000000
	.ascii "ABLJ"
	.byte 0x00, 0x01
	.halfword 0x0000
	.word 0x022C39A4, 0x022DAE20
	.ascii "AM9J"
	.byte 0x00, 0x00
	.halfword 0x0000
	.word 0x022C39A4, 0x022DAE20
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F81D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F81E4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F81F4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8204
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8214
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8224
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8234
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8244
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8254
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8264
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8274
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8284
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F8294
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82A4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 037F82B4
P2_Runtime_037F82BC:
	push {r4,r5,r6,lr}	; 037F82BC
	ldr r0,[pool_037F82F0]	; 037F82BE
	bl P2_Entry_037FE42C	; 037F82C0
	ldr r6,[pool_037F82F4]	; 037F82C4
	ldr r5,[pool_037F82F8]	; 037F82C6
	mov r4,#0x1	; 037F82C8
	b P2_Entry_037F82D2	; 037F82CA
P2_Runtime_037F82CC:
	add r0,r6,#0x0	; 037F82CC
	bl P2_SwiWaitByLoop	; 037F82CE
P2_Entry_037F82D2:
	ldrh r1,[r5,#0x0]	; 037F82D2
	add r0,r1,#0x0	; 037F82D4
	and r0,r4	; 037F82D6
	cmp r0,#0x0	; 037F82D8
	bne P2_Runtime_037F82CC	; 037F82DA
	mov r0,#0x1	; 037F82DC
	orr r1,r0	; 037F82DE
	strh r1,[r5,#0x0]	; 037F82E0
	ldr r0,[pool_037F82FC]	; 037F82E2
	ldr r0,[r0,#0x18]	; 037F82E4
	ldr r0,[r0,#0x8]	; 037F82E6
	pop {r4,r5,r6}	; 037F82E8
	pop {r3}	; 037F82EA
	bx r3	; 037F82EC
	.byte 0xC0, 0x46	; 037F82EE
pool_037F82F0:
	.word 0x0230FF04	; 037F82F0
pool_037F82F4:
	.word 0x00000100	; 037F82F4
pool_037F82F8:
	.word 0x027FFF96	; 037F82F8
pool_037F82FC:
	.word P4_BssStart + 0x23C0	; 037F82FC
P2_Runtime_037F8300:
	push {r4,r5,r6,lr}	; 037F8300
	ldr r0,[pool_037F832C]	; 037F8302
	bl P2_Entry_037FE42C	; 037F8304
	ldr r6,[pool_037F8330]	; 037F8308
	ldr r5,[pool_037F8334]	; 037F830A
	mov r4,#0x1	; 037F830C
	b P2_Entry_037F8316	; 037F830E
P2_Runtime_037F8310:
	add r0,r6,#0x0	; 037F8310
	bl P2_SwiWaitByLoop	; 037F8312
P2_Entry_037F8316:
	ldrh r0,[r5,#0x0]	; 037F8316
	and r0,r4	; 037F8318
	cmp r0,#0x0	; 037F831A
	bne P2_Runtime_037F8310	; 037F831C
	ldr r0,[pool_037F832C]	; 037F831E
	bl P2_Entry_037FE3E8	; 037F8320
	pop {r4,r5,r6}	; 037F8324
	pop {r3}	; 037F8326
	bx r3	; 037F8328
	.byte 0xC0, 0x46	; 037F832A
pool_037F832C:
	.word 0x0230FF04	; 037F832C
pool_037F8330:
	.word 0x00000100	; 037F8330
pool_037F8334:
	.word 0x027FFF96	; 037F8334
P2_Runtime_037F8338:
	push {r4,r5,r6,r7,lr}	; 037F8338
	sub sp,#0x4	; 037F833A
	add r5,r0,#0x0	; 037F833C
	ldr r4,[pool_037F8368]	; 037F833E
	mov r6,#0xa	; 037F8340
	mov r7,#0x0	; 037F8342
	b P2_Entry_037F834C	; 037F8344
P2_Runtime_037F8346:
	add r0,r4,#0x0	; 037F8346
	bl P2_SwiWaitByLoop	; 037F8348
P2_Entry_037F834C:
	add r0,r6,#0x0	; 037F834C
	add r1,r5,#0x0	; 037F834E
	add r2,r7,#0x0	; 037F8350
	bl loc_03801F38	; 037F8352
	cmp r0,#0x0	; 037F8356
	blt P2_Runtime_037F8346	; 037F8358
	ldr r0,[pool_037F836C]	; 037F835A
	bl P2_Entry_037FE3E8	; 037F835C
	add sp,#0x4	; 037F8360
	pop {r4,r5,r6,r7}	; 037F8362
	pop {r3}	; 037F8364
	bx r3	; 037F8366
pool_037F8368:
	.word 0x00000100	; 037F8368
pool_037F836C:
	.word 0x0230FF04	; 037F836C
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
	bl loc_03801E58	; 0380F61C
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
	bl loc_0380508C	; 0380F668
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
.arm
.close
