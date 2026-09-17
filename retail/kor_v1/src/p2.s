; official_kor_v1_p2
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
	bl loc_038053A8	; 037FA870
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
	.word loc_03805480 + 1	; 037FA8B4

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
	.word P2_Data_038054BC	; 037FA988
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
	bl loc_037FF5D4	; 037FAA06
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
	bl loc_037FDE30	; 037FAA4C
	add sp,#0x10	; 037FAA50
	pop {r4}	; 037FAA52
	pop {r3}	; 037FAA54
	bx r3	; 037FAA56
.endfunc
pool_037FAA58:
loc_037FAA58:
	.word 0x03808078	; 037FAA58
pool_037FAA5C:
loc_037FAA5C:
	.word 0x0380F600	; 037FAA5C
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
	.word loc_037FF7B8	; 037FAAC4
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
	bl loc_03802CA0	; 037FAC56
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
	bl loc_03802C80	; 037FAC72
	ldr r0,[pool_037FACA0]	; 037FAC76
	bl loc_03802D68	; 037FAC78
	ldr r0,[pool_037FACA0]	; 037FAC7C
	bl loc_03802D00	; 037FAC7E
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
	bl loc_03802C80	; 037FAC96
	add sp,#0x4	; 037FAC9A
	pop {r3}	; 037FAC9C
	bx r3	; 037FAC9E
pool_037FACA0:
loc_037FACA0:
	.word 0x03805780	; 037FACA0

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
	bl loc_037FE2D0	; 037FACB8
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
	.word 0x038057D0	; 037FACC8

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
	bl loc_03803328	; 037FACDA
	ldr r0,[r4,#0x0]	; 037FACDE
	cmp r0,#0x0	; 037FACE0
	beq loc_037FAD08	; 037FACE2
	str r6,[r4,#0xc]	; 037FACE4
	ldr r0,[r4,#0x4]	; 037FACE6
	add r1,r7,#0x0	; 037FACE8
	ldr r2,[pool_037FAD28]	; 037FACEA
	bl loc_03804338	; 037FACEC
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
	bl loc_03804338	; 037FAD02
	b loc_037FAD12	; 037FAD06
loc_037FAD08:
	ldr r0,[r4,#0x4]	; 037FAD08
	ldr r1,[r4,#0xc]	; 037FAD0A
	ldr r2,[r4,#0x8]	; 037FAD0C
	bl loc_03804338	; 037FAD0E
loc_037FAD12:
	ldr r0,[r5,#0x0]	; 037FAD12
	bl loc_038032E0	; 037FAD14
	add r0,r6,#0x0	; 037FAD18
	bl loc_037FE33C	; 037FAD1A
	b loc_037FACD8	; 037FAD1E
.endfunc
pool_037FAD20:
loc_037FAD20:
	.word 0x03805794	; 037FAD20
pool_037FAD24:
loc_037FAD24:
	.word P2_BssStart + 0x14	; 037FAD24
pool_037FAD28:
loc_037FAD28:
	.word 0x038057A0	; 037FAD28

; ===== function loc_037FAD2C =====
P2_IrqHandler_037FAD2C:
	push {lr}	; 037FAD2C
	sub sp,#0x4	; 037FAD2E
	ldr r0,[pool_037FAD4C]	; 037FAD30
	ldr r0,[r0,#0x0]	; 037FAD32
	cmp r0,#0x0	; 037FAD34
	beq loc_037FAD3C	; 037FAD36
	bl loc_03804BB8	; 037FAD38
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
	.word P2_BssStart + 0x28A0	; 037FAD4C
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
	bl loc_037FE174	; 037FAD9E
	ldr r1,[pool_037FADB8]	; 037FADA2
	ldr r0,[r1,#0x8]	; 037FADA4
	orr r0,r4	; 037FADA6
	str r0,[r1,#0x8]	; 037FADA8
	mov r0,#0xae	; 037FADAA
	mov r2,#0x0	; 037FADAC
	bl loc_037FE100	; 037FADAE
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
	ldr r1,[pool_037FAFCC]	; 037FADC6
	ldr r2,[pool_037FAFD0]	; 037FADC8
	bl P2_SwiCpuFastSet	; 037FADCA
	ldr r1,[pool_037FAFD4]	; 037FADCE
; 锁定 Lite 扩展寄存器；写入值保持 FFFF。
; Lock the Lite extension registers; retain the original FFFF write.
	ldr r0,[pool_037FAFD8]	; 037FADD0
	strh r1,[r0,#0x0]	; 037FADD2
	ldr r0,[pool_037FAFDC]	; 037FADD4
	ldr r2,[pool_037FAFE0]	; 037FADD6
	strh r0,[r2,#0x0]	; 037FADD8
	mov r1,#0x0	; 037FADDA
	ldr r0,[pool_037FAFE4]	; 037FADDC
	str r1,[r0,#0x0]	; 037FADDE
	str r1,[r2,#0x0]	; 037FADE0
	mov r0,#0x1	; 037FADE2
	bl loc_03804818	; 037FADE4
; 缓存 PMIC 寄存器 4 的 bit6，供 ARM9 亮度路径判断；不是充电检测位。
; Cache PMIC register 4 bit6 for ARM9 brightness gating, not the charger-detect bit.
	mov r0,#0x4	; 037FADE8
	bl P2_ReadPmicRegister	; 037FADEA
	mov r1,#0x40	; 037FADEE
	add r4,r0,#0x0	; 037FADF0
	and r4,r1	; 037FADF2
	mov r1,#0x1	; 037FADF4
	ldr r0,[pool_037FAFE8]	; 037FADF6
	strh r1,[r0,#0x0]	; 037FADF8
	mov r0,#0x10	; 037FADFA
	bl loc_03804CDE	; 037FADFC
	bl loc_037FAC50	; 037FAE00
	bl loc_037FE874	; 037FAE04
	ldr r0,[pool_037FAFEC]	; 037FAE08
	bl P2_InitPxiChannel1Callback	; 037FAE0A
	bl loc_037FB400	; 037FAE0E
	ldr r0,[pool_037FAFF0]	; 037FAE12
	strb r4,[r0,#0x0]	; 037FAE14
	mov r0,#0x8	; 037FAE16
	ldr r1,[pool_037FAFF4]	; 037FAE18
	bl loc_037FE8A0	; 037FAE1A
	mov r0,#0x8	; 037FAE1E
	ldr r1,[pool_037FAFF8]	; 037FAE20
	bl loc_037FE8AC	; 037FAE22
	bl loc_038024CC	; 037FAE26
	mov r0,#0x2	; 037FAE2A
	bl loc_03803370	; 037FAE2C
	mov r0,#0x3	; 037FAE30
	bl loc_037FFE8C	; 037FAE32
	mov r0,#0x8	; 037FAE36
	bl loc_03802928	; 037FAE38
	bl loc_037FB068	; 037FAE3C
	ldr r1,[pool_037FAFFC]	; 037FAE40
	str r0,[r1,#0x0]	; 037FAE42
	mov r0,#0x2	; 037FAE44
	ldr r1,[pool_037FB000]	; 037FAE46
	bl P2_SetPxiReceiveCallback	; 037FAE48
	ldr r0,[pool_037FB004]	; 037FAE4C
	str r0,[sp,#0x0]	; 037FAE4E
	mov r0,#0xe	; 037FAE50
	str r0,[sp,#0x4]	; 037FAE52
	ldr r0,[pool_037FB008]	; 037FAE54
	ldr r1,[pool_037FB00C]	; 037FAE56
	mov r2,#0x0	; 037FAE58
	ldr r3,[pool_037FB010]	; 037FAE5A
	bl P2_CreateThread	; 037FAE5C
	bl P2_InitializeBootProcedureCallbacks	; 037FAE60
; KOR 以固件内的装载步骤和分块完成回调替换 BIOS 入口，沿用 BIOS 的状态布局。
; KOR replaces BIOS load-step and block-completion callbacks, retaining the BIOS state layout.
	ldr r1,[pool_037FB014]	; 037FAE64
	ldr r0,[pool_037FB018]	; 037FAE66
	str r1,[r0,#0x0]	; 037FAE68
	ldr r1,[pool_037FB01C]	; 037FAE6A
	ldr r0,[pool_037FB020]	; 037FAE6C
	str r1,[r0,#0x0]	; 037FAE6E
	ldr r0,[pool_037FB024]	; 037FAE70
	bl loc_037FDF04	; 037FAE72
	mov r0,#0x1	; 037FAE76
	ldr r1,[pool_037FB028]	; 037FAE78
	bl loc_037FDF04	; 037FAE7A
	mov r0,#0x1	; 037FAE7E
	bl loc_037FDE80	; 037FAE80
	bl loc_037FB074	; 037FAE84
	ldr r2,[pool_037FB02C]	; 037FAE88
	ldrh r0,[r2,#0x0]	; 037FAE8A
	ldrh r1,[r2,#0x0]	; 037FAE8C
	mov r0,#0x8	; 037FAE8E
	orr r1,r0	; 037FAE90
	strh r1,[r2,#0x0]	; 037FAE92
	ldr r1,[pool_037FB030]	; 037FAE94
	ldrh r0,[r1,#0x0]	; 037FAE96
	mov r0,#0x1	; 037FAE98
	strh r0,[r1,#0x0]	; 037FAE9A
	bl P2_LoadFirmwareHeaderAndSettingsOffset	; 037FAE9C
	bl P2_LoadFirmwarePart5ToStaging	; 037FAEA0
	mov r0,#0x3	; 037FAEA4
	ldr r5,[pool_037FB034]	; 037FAEA6
	str r0,[r5,#0x0]	; 037FAEA8
	ldr r7,[pool_037FB038]	; 037FAEAA
	mov r6,#0x2	; 037FAEAC
	ldr r4,[pool_037FB03C]	; 037FAEAE
loc_037FAEB0:
	mov r0,#0x1	; 037FAEB0
	lsl r1,r0,#0	; 037FAEB2
	bl loc_037FF558	; 037FAEB4
	ldr r0,[r4,#0x24]	; 037FAEB8
	cmp r0,#0x3	; 037FAEBA
	bne loc_037FAEEE	; 037FAEBC
	ldr r1,[r7,#0x0]	; 037FAEBE
	ldr r0,[pool_037FB040]	; 037FAEC0
	and r1,r0	; 037FAEC2
	cmp r1,#0x0	; 037FAEC4
	beq loc_037FAEB0	; 037FAEC6
	ldr r0,[r7,#0x0]	; 037FAEC8
	and r0,r6	; 037FAECA
	cmp r0,#0x0	; 037FAECC
	beq loc_037FAEEA	; 037FAECE
	ldr r1,[r7,#0x0]	; 037FAED0
	mov r0,#0x4	; 037FAED2
	and r1,r0	; 037FAED4
	cmp r1,#0x0	; 037FAED6
	bne loc_037FAEEA	; 037FAED8
	bl P2_ClearMainRamOutsideArm9Image	; 037FAEDA
	mov r0,#0xac	; 037FAEDE
	bl loc_037FE05C	; 037FAEE0
	mov r0,#0x4	; 037FAEE4
	str r0,[r5,#0x0]	; 037FAEE6
	b loc_037FAEB0	; 037FAEE8
loc_037FAEEA:
	str r6,[r5,#0x0]	; 037FAEEA
	b loc_037FAEB0	; 037FAEEC
loc_037FAEEE:
	ldr r0,[r4,#0x24]	; 037FAEEE
	cmp r0,#0x4	; 037FAEF0
	bne loc_037FAF14	; 037FAEF2
	ldr r0,[pool_037FB018]	; 037FAEF4
	ldr r0,[r0,#0x0]	; 037FAEF6
	bl loc_03805468	; 037FAEF8
	mov r1,#0x1	; 037FAEFC
	mvn r1,r1	; 037FAEFE
	cmp r0,r1	; 037FAF00
	bne loc_037FAEB0	; 037FAF02
	mov r0,#0xac	; 037FAF04
	bl loc_037FDF90	; 037FAF06
	ldr r0,[pool_037FB044]	; 037FAF0A
	bl P2_OrSharedEventFlags	; 037FAF0C
	str r6,[r5,#0x0]	; 037FAF10
	b loc_037FAEB0	; 037FAF12
loc_037FAF14:
	ldr r0,[r4,#0x24]	; 037FAF14
	cmp r0,#0x2	; 037FAF16
	beq loc_037FAF20	; 037FAF18
	ldr r0,[r4,#0x24]	; 037FAF1A
	cmp r0,#0x7	; 037FAF1C
	bne loc_037FAF32	; 037FAF1E
loc_037FAF20:
	ldr r0,[pool_037FB048]	; 037FAF20
	ldr r0,[r0,#0x0]	; 037FAF22
	cmp r0,#0x0	; 037FAF24
	beq loc_037FAEB0	; 037FAF26
	str r0,[r5,#0x0]	; 037FAF28
	mov r1,#0x0	; 037FAF2A
	ldr r0,[pool_037FB048]	; 037FAF2C
	str r1,[r0,#0x0]	; 037FAF2E
	b loc_037FAEB0	; 037FAF30
loc_037FAF32:
	ldr r0,[r4,#0x24]	; 037FAF32
	cmp r0,#0x6	; 037FAF34
	bne loc_037FAF5C	; 037FAF36
	ldr r0,[pool_037FB04C]	; 037FAF38
	ldr r0,[r0,#0x0]	; 037FAF3A
	cmp r0,#0x7	; 037FAF3C
	bne loc_037FAEB0	; 037FAF3E
	ldr r1,[pool_037FB030]	; 037FAF40
	ldrh r0,[r1,#0x0]	; 037FAF42
	mov r0,#0x0	; 037FAF44
	strh r0,[r1,#0x0]	; 037FAF46
	bl loc_037FDEAC	; 037FAF48
	bl P2_ApplyPatternSelectedRuntimePatch	; 037FAF4C
	bl P2_ResetArm7Peripherals	; 037FAF50
	ldr r1,[pool_037FB050]	; 037FAF54
	ldr r0,[pool_037FB054]	; 037FAF56
	strh r1,[r0,#0x0]	; 037FAF58
	b loc_037FAFC2	; 037FAF5A
loc_037FAF5C:
	ldr r0,[r4,#0x24]	; 037FAF5C
	cmp r0,#0x5	; 037FAF5E
	bne loc_037FAF6C	; 037FAF60
	bl P2_LoadSecondaryFirmwarePartsToStaging	; 037FAF62
	mov r0,#0x7	; 037FAF66
	str r0,[r5,#0x0]	; 037FAF68
	b loc_037FAEB0	; 037FAF6A
loc_037FAF6C:
	ldr r0,[r4,#0x24]	; 037FAF6C
	cmp r0,#0x8	; 037FAF6E
	bne loc_037FAF8C	; 037FAF70
	bl P2_InitializeBootProcedureCallbacks	; 037FAF72
	mov r1,#0x6	; 037FAF76
; 启动状态 8 路径在私有源区写入 6；发布时此字段会被另行覆盖。
; Boot state 8 writes 6 to this private slot; publication later replaces the field.
	ldr r0,[pool_037FB058]	; 037FAF78
	strh r1,[r0,#0x0]	; 037FAF7A
	ldr r0,[pool_037FB018]	; 037FAF7C
	ldr r0,[r0,#0x0]	; 037FAF7E
	bl loc_03805468	; 037FAF80
	bl loc_037FB080	; 037FAF84
	str r6,[r5,#0x0]	; 037FAF88
	b loc_037FAEB0	; 037FAF8A
loc_037FAF8C:
	ldr r0,[r4,#0x24]	; 037FAF8C
	cmp r0,#0x9	; 037FAF8E
	bne loc_037FAEB0	; 037FAF90
	ldr r0,[pool_037FB04C]	; 037FAF92
	ldr r0,[r0,#0x0]	; 037FAF94
	cmp r0,#0x9	; 037FAF96
	bne loc_037FAEB0	; 037FAF98
	ldr r0,[pool_037FB030]	; 037FAF9A
	ldrh r0,[r0,#0x0]	; 037FAF9C
	mov r1,#0x0	; 037FAF9E
	ldr r0,[pool_037FB030]	; 037FAFA0
	strh r1,[r0,#0x0]	; 037FAFA2
	ldr r0,[pool_037FB05C]	; 037FAFA4
	ldr r1,[pool_037FB060]	; 037FAFA6
	ldr r2,[pool_037FB064]	; 037FAFA8
	bl P2_SwiCpuFastSet	; 037FAFAA
	mov r0,#0x10	; 037FAFAE
	bl loc_03804CE6	; 037FAFB0
	ldr r0,[pool_037FAFDC]	; 037FAFB4
	bl loc_03804CB8	; 037FAFB6
	ldr r0,[pool_037FB060]	; 037FAFBA
	bl loc_03805468	; 037FAFBC
	b loc_037FAEB0	; 037FAFC0
loc_037FAFC2:
	add sp,#0xc	; 037FAFC2
	pop {r4,r5,r6,r7}	; 037FAFC4
	pop {r3}	; 037FAFC6
	bx r3	; 037FAFC8
	.byte 0xC0, 0x46	; 037FAFCC
pool_037FAFCC:
loc_037FAFCC:
	.word 0x023FE800	; 037FAFCC
pool_037FAFD0:
loc_037FAFD0:
	.word 0x01000200	; 037FAFD0
pool_037FAFD4:
loc_037FAFD4:
	.word 0x0000FFFF	; 037FAFD4
pool_037FAFD8:
loc_037FAFD8:
	.word REG_NITRO2_REGCNT	; 037FAFD8
pool_037FAFDC:
loc_037FAFDC:
	.word 0x00001000	; 037FAFDC
pool_037FAFE0:
loc_037FAFE0:
	.word REG_SIOCNT_ARM7	; 037FAFE0
pool_037FAFE4:
loc_037FAFE4:
	.word REG_SIODATA32_ARM7	; 037FAFE4
pool_037FAFE8:
loc_037FAFE8:
	.word REG_POWERCNT	; 037FAFE8
pool_037FAFEC:
loc_037FAFEC:
	.word P2_PxiChannel1UserCallback + 1	; 037FAFEC
pool_037FAFF0:
loc_037FAFF0:
	.word FirmwareBootSharedAddress + BootSharedPmicReg4Bit6Offset	; 037FAFF0
pool_037FAFF4:
loc_037FAFF4:
	.word 0x03808078	; 037FAFF4
pool_037FAFF8:
loc_037FAFF8:
	.word 0x0380F600	; 037FAFF8
pool_037FAFFC:
loc_037FAFFC:
	.word P2_BssStart + 0x14	; 037FAFFC
pool_037FB000:
loc_037FB000:
	.word P2_PxiCallback_037FAD60 + 1	; 037FB000
pool_037FB004:
loc_037FB004:
	.word 0x00000400	; 037FB004
pool_037FB008:
loc_037FB008:
	.word 0x038057D0	; 037FB008
pool_037FB00C:
loc_037FB00C:
	.word P2_RunTransferRequestServiceLoop + 1	; 037FB00C
pool_037FB010:
loc_037FB010:
	.word P2_CartReadBuffer	; 037FB010
pool_037FB014:
loc_037FB014:
	.word P2_StepCartBootLoad + 1	; 037FB014
pool_037FB018:
loc_037FB018:
	.word P2_BssStart + 0xC	; 037FB018
pool_037FB01C:
loc_037FB01C:
	.word P2_OnCartReadBlock + 1	; 037FB01C
pool_037FB020:
loc_037FB020:
	.word P2_BssStart + 0x10	; 037FB020
pool_037FB024:
loc_037FB024:
	.word 0x00080000	; 037FB024
pool_037FB028:
loc_037FB028:
	.word P2_IrqHandler_037FAD2C + 1	; 037FB028
pool_037FB02C:
loc_037FB02C:
	.word REG_DISPSTAT	; 037FB02C
pool_037FB030:
loc_037FB030:
	.word REG_IME	; 037FB030
pool_037FB034:
loc_037FB034:
	.word FirmwareBootSharedAddress + BootSharedArm7StateOffset	; 037FB034
pool_037FB038:
loc_037FB038:
	.word 0x027FF890	; 037FB038
pool_037FB03C:
loc_037FB03C:
	.word 0x027FF860	; 037FB03C
pool_037FB040:
loc_037FB040:
	.word 0x20000000	; 037FB040
pool_037FB044:
loc_037FB044:
	.word 0x00000200	; 037FB044
pool_037FB048:
loc_037FB048:
	.word P2_BssStart	; 037FB048
pool_037FB04C:
loc_037FB04C:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 037FB04C
pool_037FB050:
loc_037FB050:
	.word 0x00002100	; 037FB050
pool_037FB054:
loc_037FB054:
	.word REG_IPC_SYNC	; 037FB054
pool_037FB058:
loc_037FB058:
	.word FirmwareBootInfoScratchAddress + 0x10	; 037FB058
pool_037FB05C:
loc_037FB05C:
	.word P2_WaitVCount200ThenEnterAgbMode	; 037FB05C
pool_037FB060:
loc_037FB060:
	.word 0x037F8000	; 037FB060
pool_037FB064:
loc_037FB064:
	.word 0x00000100	; 037FB064

; ===== function loc_037FB068 =====
loc_037FB068:
	bx pc	; 037FB068
	.byte 0xC0, 0x46	; 037FB06C
.arm

; ===== function loc_037FB06C =====
loc_037FB06C:
	ldr pc,[pool_037FB070]	; 037FB06C
pool_037FB070:
loc_037FB070:
	.word loc_037FDF98	; 037FB070
.thumb

; ===== function loc_037FB074 =====
loc_037FB074:
	bx pc	; 037FB074
	.byte 0xC0, 0x46	; 037FB078
.arm

; ===== function loc_037FB078 =====
loc_037FB078:
	ldr pc,[pool_037FB07C]	; 037FB078
pool_037FB07C:
loc_037FB07C:
	.word loc_037FF4E0	; 037FB07C
.thumb

; ===== function loc_037FB080 =====
loc_037FB080:
	bx pc	; 037FB080
	.byte 0xC0, 0x46	; 037FB084
.arm

; ===== function loc_037FB084 =====
loc_037FB084:
	ldr pc,[pool_037FB088]	; 037FB084
pool_037FB088:
loc_037FB088:
	.word P4_InitializeRuntimeContext	; 037FB088
.thumb

; ===== function P2_DisableAndAcknowledgeIrqs =====
loc_037FB08C:
; 临时关 IME，屏蔽并确认 r0 指定的中断，再恢复 IME。
; Mask and acknowledge IRQs selected by r0 while IME is off, then restore IME.
.func P2_DisableAndAcknowledgeIrqs
	push {r4,lr}	; 037FB08C
	ldr r4,[pool_037FB0AC]	; 037FB08E
	ldrh r3,[r4,#0x0]	; 037FB090
	mov r1,#0x0	; 037FB092
	strh r1,[r4,#0x0]	; 037FB094
	ldr r2,[pool_037FB0B0]	; 037FB096
	ldr r1,[r2,#0x0]	; 037FB098
	bic r1,r0	; 037FB09A
	str r1,[r2,#0x0]	; 037FB09C
	ldr r1,[pool_037FB0B4]	; 037FB09E
	str r0,[r1,#0x0]	; 037FB0A0
	strh r3,[r4,#0x0]	; 037FB0A2
	pop {r4}	; 037FB0A4
	pop {r3}	; 037FB0A6
	bx r3	; 037FB0A8
.endfunc
	.byte 0xC0, 0x46	; 037FB0AC
pool_037FB0AC:
loc_037FB0AC:
	.word REG_IME	; 037FB0AC
pool_037FB0B0:
loc_037FB0B0:
	.word REG_IE	; 037FB0B0
pool_037FB0B4:
loc_037FB0B4:
	.word REG_IF	; 037FB0B4

; ===== function P2_FinishCartRead =====
loc_037FB0B8:
; 等待卡带空闲、停止 DMA，再关闭卡带传输和卡带请求中断。
; Wait for the card, stop DMA, then disable card-transfer and card-request IRQs.
.func P2_FinishCartRead
	push {lr}	; 037FB0B8
	sub sp,#0x4	; 037FB0BA
	ldr r0,[pool_037FB0D0]	; 037FB0BC
	ldr r0,[r0,#Bios7CartCommandOffset]	; 037FB0BE
	bl P2_WaitCartIdleAndStopDma	; 037FB0C0
	ldr r0,[pool_037FB0D4]	; 037FB0C4
	bl P2_DisableAndAcknowledgeIrqs	; 037FB0C6
	add sp,#0x4	; 037FB0CA
	pop {r3}	; 037FB0CC
	bx r3	; 037FB0CE
.endfunc
pool_037FB0D0:
loc_037FB0D0:
	.word Bios7CartTransferStateAddress	; 037FB0D0
pool_037FB0D4:
loc_037FB0D4:
	.word 0x00180000	; 037FB0D4

; ===== function P2_EnableCartReadIrq =====
loc_037FB0D8:
; 清传输完成标志，启用卡带传输中断，最后将 IME 置 1。
; Clear completion flags, enable the card-transfer IRQ, then set IME to 1.
.func P2_EnableCartReadIrq
	mov r1,#0x0	; 037FB0D8
	ldr r0,[pool_037FB0FC]	; 037FB0DA
	strh r1,[r0,#0x0]	; 037FB0DC
	ldr r3,[pool_037FB100]	; 037FB0DE
	ldr r2,[r3,#0x0]	; 037FB0E0
	ldr r1,[pool_037FB104]	; 037FB0E2
	and r2,r1	; 037FB0E4
	str r2,[r3,#0x0]	; 037FB0E6
	ldr r3,[pool_037FB108]	; 037FB0E8
	ldr r1,[pool_037FB10C]	; 037FB0EA
	str r3,[r1,#0x0]	; 037FB0EC
	ldr r2,[pool_037FB110]	; 037FB0EE
	ldr r1,[r2,#0x0]	; 037FB0F0
	orr r1,r3	; 037FB0F2
	str r1,[r2,#0x0]	; 037FB0F4
	mov r1,#0x1	; 037FB0F6
	strh r1,[r0,#0x0]	; 037FB0F8
	bx lr	; 037FB0FA
.endfunc
pool_037FB0FC:
loc_037FB0FC:
	.word REG_IME	; 037FB0FC
pool_037FB100:
loc_037FB100:
	.word Bios7IrqFlagsAddress	; 037FB100
pool_037FB104:
loc_037FB104:
	.word 0xFFF7FFFF	; 037FB104
pool_037FB108:
loc_037FB108:
	.word 0x00080000	; 037FB108
pool_037FB10C:
loc_037FB10C:
	.word REG_IF	; 037FB10C
pool_037FB110:
loc_037FB110:
	.word REG_IE	; 037FB110

; ===== function P2_PrepareCartReadState =====
loc_037FB114:
; r0=总字节数，r1=状态区；设置 512 字节块并准备传输中断。
; r0=total bytes, r1=state; select 512-byte blocks and prepare the transfer IRQ.
.func P2_PrepareCartReadState
	push {lr}	; 037FB114
	sub sp,#0x4	; 037FB116
	str r0,[r1,#Bios7CartRemainingOffset]	; 037FB118
	ldr r0,[pool_037FB130]	; 037FB11A
	str r0,[r1,#Bios7CartBlockBytesOffset]	; 037FB11C
	ldr r0,[r1,#Bios7CartCommandOffset]	; 037FB11E
	bl P2_WaitCartIdleAndStopDma	; 037FB120
	bl P2_EnableCartReadIrq	; 037FB124
	add sp,#0x4	; 037FB128
	pop {r3}	; 037FB12A
	bx r3	; 037FB12C
.endfunc
	.byte 0xC0, 0x46	; 037FB130
pool_037FB130:
loc_037FB130:
	.word P2_CartReadBlockBytes	; 037FB130
; r0=ROM 偏移、r1=缓冲区、r3=命令结构；构造 B7 读取并启动 DMA。
; r0=ROM offset, r1=buffer, r3=command context; form a B7 read and start DMA.
.func P2_StartCartReadB7
	push {r4,lr}	; 037FB134
	lsl r4,r0,#0x18	; 037FB136
	str r4,[r3,#Bios7CartCmdLowWordOffset]	; 037FB138
	lsr r4,r0,#0x8	; 037FB13A
	ldr r0,[pool_037FB158]	; 037FB13C
	orr r4,r0	; 037FB13E
	str r4,[r3,#Bios7CartCmdHighWordOffset]	; 037FB140
	ldr r4,[pool_037FB15C]	; 037FB142
	ldr r0,[pool_037FB160]	; 037FB144
	str r4,[r0,#0x0]	; 037FB146
	add r0,r1,#0x0	; 037FB148
	add r1,r2,#0x0	; 037FB14A
	add r2,r3,#0x0	; 037FB14C
	bl P2_StartCartReadDma	; 037FB14E
	pop {r4}	; 037FB152
	pop {r3}	; 037FB154
	bx r3	; 037FB156
.endfunc
pool_037FB158:
loc_037FB158:
	.word 0xB7000000	; 037FB158
pool_037FB15C:
loc_037FB15C:
	.word 0x20000000	; 037FB15C
pool_037FB160:
loc_037FB160:
	.word REG_ROMCTRL	; 037FB160

; ===== function P2_StartCartReadDma =====
loc_037FB164:
; 写命令后，仅对通道 0..3 设置固定卡带源 DMA，再写 ROMCTRL 启动。
; After writing the command, start fixed-source card DMA and ROMCTRL only for channels 0..3.
.func P2_StartCartReadDma
	push {r4,r5,lr}	; 037FB164
	sub sp,#0x4	; 037FB166
	add r5,r0,#0x0	; 037FB168
	add r4,r2,#0x0	; 037FB16A
	add r0,r4,#0x0	; 037FB16C
	bl P2_WriteCartCommand	; 037FB16E
	ldr r1,[r4,#Bios7CartCmdDmaChannelOffset]	; 037FB172
	cmp r1,#0x3	; 037FB174
	bhi loc_037FB192	; 037FB176
	mov r0,#0xc	; 037FB178
	mul r1,r0	; 037FB17A
	ldr r0,[pool_037FB19C]	; 037FB17C
	add r2,r1,r0	; 037FB17E
	ldr r1,[pool_037FB1A0]	; 037FB180
	str r1,[r2,#0x0]	; 037FB182
	str r5,[r2,#0x4]	; 037FB184
	ldr r1,[pool_037FB1A4]	; 037FB186
	str r1,[r2,#0x8]	; 037FB188
	ldr r0,[r0,#0x0]	; 037FB18A
	ldr r1,[r4,#Bios7CartCmdControlOffset]	; 037FB18C
	ldr r0,[pool_037FB1A8]	; 037FB18E
	str r1,[r0,#0x0]	; 037FB190
loc_037FB192:
	add sp,#0x4	; 037FB192
	pop {r4,r5}	; 037FB194
	pop {r3}	; 037FB196
	bx r3	; 037FB198
.endfunc
	.byte 0xC0, 0x46	; 037FB19C
pool_037FB19C:
loc_037FB19C:
	.word REG_DMA0SAD	; 037FB19C
pool_037FB1A0:
loc_037FB1A0:
	.word REG_GCDATAIN	; 037FB1A0
pool_037FB1A4:
loc_037FB1A4:
	.word 0xA7000001	; 037FB1A4
pool_037FB1A8:
loc_037FB1A8:
	.word REG_ROMCTRL	; 037FB1A8

; ===== function P2_WaitCartIdleAndStopDma =====
loc_037FB1AC:
; 等待 ROMCTRL busy 清零；r0 在 0..3 时停止对应 DMA 通道。
; Wait for ROMCTRL busy to clear; stop DMA when r0 selects channel 0..3.
.func P2_WaitCartIdleAndStopDma
	push {lr}	; 037FB1AC
	sub sp,#0x4	; 037FB1AE
	ldr r2,[pool_037FB1CC]	; 037FB1B0
	ldr r1,[pool_037FB1D0]	; 037FB1B2
loc_037FB1B4:
	ldr r3,[r2,#0x0]	; 037FB1B4
	and r3,r1	; 037FB1B6
	cmp r3,#0x0	; 037FB1B8
	bne loc_037FB1B4	; 037FB1BA
	cmp r0,#0x3	; 037FB1BC
	bhi loc_037FB1C4	; 037FB1BE
	bl loc_037FF5D4	; 037FB1C0
loc_037FB1C4:
	add sp,#0x4	; 037FB1C4
	pop {r3}	; 037FB1C6
	bx r3	; 037FB1C8
.endfunc
	.byte 0xC0, 0x46	; 037FB1CC
pool_037FB1CC:
loc_037FB1CC:
	.word REG_ROMCTRL	; 037FB1CC
pool_037FB1D0:
loc_037FB1D0:
	.word 0x80000000	; 037FB1D0

; ===== function P2_WriteCartCommand =====
loc_037FB1D4:
; r0=命令结构；先发高字再发低字，各字按高字节优先写入命令端口。
; r0=command context; send the high word then low word, most-significant byte first.
.func P2_WriteCartCommand
	push {r4,r5,r6,r7,lr}	; 037FB1D4
	sub sp,#0x4	; 037FB1D6
	add r4,r0,#0x0	; 037FB1D8
	ldr r0,[r4,#Bios7CartCmdDmaChannelOffset]	; 037FB1DA
	bl P2_WaitCartIdleAndStopDma	; 037FB1DC
	mov r1,#0xc0	; 037FB1E0
	ldr r0,[pool_037FB214]	; 037FB1E2
	strb r1,[r0,#0x0]	; 037FB1E4
	mov r2,#0x0	; 037FB1E6
	mov r3,#0x1	; 037FB1E8
	ldr r5,[pool_037FB218]	; 037FB1EA
loc_037FB1EC:
	sub r0,r3,r2	; 037FB1EC
	lsl r0,r0,#0x2	; 037FB1EE
	add r0,r4,r0	; 037FB1F0
	ldr r1,[r0,#Bios7CartCmdLowWordOffset]	; 037FB1F2
	lsl r7,r2,#0x2	; 037FB1F4
	add r0,r7,r5	; 037FB1F6
	lsr r6,r1,#0x18	; 037FB1F8
	strb r6,[r7,r5]	; 037FB1FA
	lsr r6,r1,#0x10	; 037FB1FC
	strb r6,[r0,#0x1]	; 037FB1FE
	lsr r6,r1,#0x8	; 037FB200
	strb r6,[r0,#0x2]	; 037FB202
	strb r1,[r0,#0x3]	; 037FB204
	add r2,r2,#0x1	; 037FB206
	cmp r2,#0x2	; 037FB208
	blt loc_037FB1EC	; 037FB20A
	add sp,#0x4	; 037FB20C
	pop {r4,r5,r6,r7}	; 037FB20E
	pop {r3}	; 037FB210
	bx r3	; 037FB212
.endfunc
pool_037FB214:
loc_037FB214:
	.word REG_AUXSPICNT + 1	; 037FB214
pool_037FB218:
loc_037FB218:
	.word REG_GCCMDOUT	; 037FB218

; ===== function loc_037FB21C =====
; 从中转缓冲区复制固定 512 字节；推进地址并读下一块，或置完成标志。
; Copy a fixed 512-byte bounce buffer, advance addresses, then read again or signal completion.
.func P2_OnCartReadBlock
	push {r4,r5,lr}	; 037FB21C
	sub sp,#0x4	; 037FB21E
	ldr r1,[pool_037FB26C]	; 037FB220
	ldr r5,[r1,#Bios7CartBlockBytesOffset]	; 037FB222
	ldr r0,[r1,#Bios7CartRemainingOffset]	; 037FB224
	sub r0,r0,r5	; 037FB226
	str r0,[r1,#Bios7CartRemainingOffset]	; 037FB228
	ldr r0,[r1,#Bios7CartRomOffset]	; 037FB22A
	add r0,r0,r5	; 037FB22C
	str r0,[r1,#Bios7CartRomOffset]	; 037FB22E
	ldr r0,[pool_037FB270]	; 037FB230
	ldr r1,[r1,#Bios7CartDestinationOffset]	; 037FB232
	mov r2,#(P2_CartReadBlockBytes / 4)	; 037FB234
	bl P2_SwiCpuFastSet	; 037FB236
	ldr r4,[pool_037FB26C]	; 037FB23A
	ldr r0,[r4,#Bios7CartDestinationOffset]	; 037FB23C
	add r0,r0,r5	; 037FB23E
	str r0,[r4,#Bios7CartDestinationOffset]	; 037FB240
	ldr r0,[r4,#Bios7CartRemainingOffset]	; 037FB242
	cmp r0,#0x0	; 037FB244
	ble loc_037FB25A	; 037FB246
	ldr r0,[r4,#Bios7CartRomOffset]	; 037FB248
	ldr r1,[pool_037FB270]	; 037FB24A
	add r2,r5,#0x0	; 037FB24C
	add r3,r4,#0x0	; 037FB24E
	add r3,#Bios7CartCommandOffset	; 037FB250
	ldr r4,[r4,#Bios7CartReaderOffset]	; 037FB252
	bl loc_03805478	; 037FB254
	b loc_037FB264	; 037FB258
loc_037FB25A:
	ldr r2,[pool_037FB274]	; 037FB25A
	ldr r1,[r2,#0x0]	; 037FB25C
	ldr r0,[pool_037FB278]	; 037FB25E
	orr r1,r0	; 037FB260
	str r1,[r2,#0x0]	; 037FB262
loc_037FB264:
	add sp,#0x4	; 037FB264
	pop {r4,r5}	; 037FB266
	pop {r3}	; 037FB268
	bx r3	; 037FB26A
.endfunc
pool_037FB26C:
loc_037FB26C:
	.word Bios7CartTransferStateAddress	; 037FB26C
pool_037FB270:
loc_037FB270:
	.word P2_CartReadBuffer	; 037FB270
pool_037FB274:
loc_037FB274:
	.word Bios7IrqFlagsAddress	; 037FB274
pool_037FB278:
loc_037FB278:
	.word 0x00080000	; 037FB278

; ===== function P2_StartCartImageRead =====
loc_037FB27C:
; r0=ROM 偏移、r1=目标、r2=长度；复用 BIOS 状态，以 DMA3 分块读取。
; r0=ROM offset, r1=destination, r2=length; reuse BIOS state for block reads via DMA3.
.func P2_StartCartImageRead
	push {r4,r5,lr}	; 037FB27C
	sub sp,#0x4	; 037FB27E
	ldr r3,[pool_037FB2B8]	; 037FB280
	ldr r5,[r3,#0x0]	; 037FB282
	ldr r3,[pool_037FB2BC]	; 037FB284
	orr r5,r3	; 037FB286
	ldr r4,[pool_037FB2C0]	; 037FB288
	str r5,[r4,#Bios7CartControlOffset]	; 037FB28A
	mov r3,#0x3	; 037FB28C
	str r3,[r4,#Bios7CartCommandOffset]	; 037FB28E
	ldr r3,[pool_037FB2C4]	; 037FB290
	str r3,[r4,#Bios7CartReaderOffset]	; 037FB292
	str r0,[r4,#Bios7CartRomOffset]	; 037FB294
	str r1,[r4,#Bios7CartDestinationOffset]	; 037FB296
	add r0,r2,#0x0	; 037FB298
	add r1,r4,#0x0	; 037FB29A
	bl P2_PrepareCartReadState	; 037FB29C
	ldr r0,[r4,#Bios7CartRomOffset]	; 037FB2A0
	ldr r1,[pool_037FB2C8]	; 037FB2A2
	ldr r2,[r4,#Bios7CartBlockBytesOffset]	; 037FB2A4
	add r3,r4,#0x0	; 037FB2A6
	add r3,#Bios7CartCommandOffset	; 037FB2A8
	ldr r4,[r4,#Bios7CartReaderOffset]	; 037FB2AA
	bl loc_03805478	; 037FB2AC
	add sp,#0x4	; 037FB2B0
	pop {r4,r5}	; 037FB2B2
	pop {r3}	; 037FB2B4
	bx r3	; 037FB2B6
.endfunc
pool_037FB2B8:
loc_037FB2B8:
	.word NdsCartHeaderRamAddress + 0x60	; 037FB2B8
pool_037FB2BC:
loc_037FB2BC:
	.word 0xA1000000	; 037FB2BC
pool_037FB2C0:
loc_037FB2C0:
	.word Bios7CartTransferStateAddress	; 037FB2C0
pool_037FB2C4:
loc_037FB2C4:
	.word P2_StartCartReadB7 + 1	; 037FB2C4
pool_037FB2C8:
loc_037FB2C8:
	.word P2_CartReadBuffer	; 037FB2C8

; ===== function loc_037FB2CC =====
; 依次启动/等待 ARM9、ARM7 装载；完成后恢复 BIOS 回调。下方含内嵌分派表。
; Start/wait for ARM9 then ARM7 loads; restore BIOS callbacks on completion. An inline dispatch table follows.
P2_StepCartBootLoad:
	push {r4,r5,lr}	; 037FB2CC
	sub sp,#0x4	; 037FB2CE
	ldr r0,[pool_037FB3DC]	; 037FB2D0
	add r4,r0,#0x0	; 037FB2D2
	add r4,#0x10	; 037FB2D4
	mov r1,#0x10	; 037FB2D6
	ldrsh r1,[r0,r1]	; 037FB2D8
	cmp r1,#0x3	; 037FB2DA
	bhi loc_037FB3CA	; 037FB2DC
	add r1,r1,r1	; 037FB2DE
P2_SwitchIndexPC_037FB2DE:
	add r1,pc	; 037FB2E0
	ldrh r1,[r1,#(P2_SwitchTable_037FB2DE - (P2_SwitchIndexPC_037FB2DE + 4))]	; 037FB2E2
	lsl r1,r1,#0x10	; 037FB2E4
	asr r1,r1,#0x10	; 037FB2E6
P2_SwitchTargetPC_037FB2DE:
	add r1,pc	; 037FB2E8
	bx r1	; 037FB2EA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FB2DE:
	.halfword (loc_037FB2F4 + 1) - (P2_SwitchTargetPC_037FB2DE + 4)
	.halfword (loc_037FB34A + 1) - (P2_SwitchTargetPC_037FB2DE + 4)
	.halfword (loc_037FB360 + 1) - (P2_SwitchTargetPC_037FB2DE + 4)
	.halfword (loc_037FB3B4 + 1) - (P2_SwitchTargetPC_037FB2DE + 4)
P2_SwitchTable_037FB2DEEnd:
loc_037FB2F4:
	mov r1,#0xc	; 037FB2F4
	ldrsh r0,[r0,r1]	; 037FB2F6
	cmp r0,#0x0	; 037FB2F8
	bne loc_037FB344	; 037FB2FA
	ldr r2,[pool_037FB3E0]	; 037FB2FC
	ldr r0,[r2,#0x20]	; 037FB2FE
	ldr r1,[r2,#0x28]	; 037FB300
	ldr r2,[r2,#0x2c]	; 037FB302
	ldr r3,[pool_037FB3E4]	; 037FB304
	sub r3,r3,r0	; 037FB306
	cmp r3,#0x0	; 037FB308
	bge loc_037FB30E	; 037FB30A
	mov r3,#0x0	; 037FB30C
loc_037FB30E:
	add r0,r0,r3	; 037FB30E
	add r1,r1,r3	; 037FB310
	sub r2,r2,r3	; 037FB312
	ldr r3,[pool_037FB3E8]	; 037FB314
	cmp r1,r3	; 037FB316
	bcc loc_037FB33E	; 037FB318
	ldr r3,[pool_037FB3EC]	; 037FB31A
	cmp r1,r3	; 037FB31C
	bcs loc_037FB33E	; 037FB31E
	add r5,r1,r2	; 037FB320
	cmp r5,r3	; 037FB322
	bls loc_037FB32A	; 037FB324
	sub r3,r5,r3	; 037FB326
	sub r2,r2,r3	; 037FB328
loc_037FB32A:
	cmp r2,#0x0	; 037FB32A
	ble loc_037FB338	; 037FB32C
	bl P2_StartCartImageRead	; 037FB32E
	mov r0,#0x1	; 037FB332
	strh r0,[r4,#0x0]	; 037FB334
	b loc_037FB3CE	; 037FB336
loc_037FB338:
	mov r0,#0x2	; 037FB338
	strh r0,[r4,#0x0]	; 037FB33A
	b loc_037FB3CE	; 037FB33C
loc_037FB33E:
	mov r0,#0x2	; 037FB33E
	strh r0,[r4,#0x0]	; 037FB340
	b loc_037FB3CE	; 037FB342
loc_037FB344:
	mov r0,#0x6	; 037FB344
	strh r0,[r4,#0x0]	; 037FB346
	b loc_037FB3CE	; 037FB348
loc_037FB34A:
	ldr r0,[pool_037FB3F0]	; 037FB34A
	ldr r1,[r0,#0x0]	; 037FB34C
	ldr r0,[pool_037FB3F4]	; 037FB34E
	and r1,r0	; 037FB350
	cmp r1,#0x0	; 037FB352
	beq loc_037FB3CE	; 037FB354
	bl P2_FinishCartRead	; 037FB356
	mov r0,#0x2	; 037FB35A
	strh r0,[r4,#0x0]	; 037FB35C
	b loc_037FB3CE	; 037FB35E
loc_037FB360:
	ldr r2,[pool_037FB3E0]	; 037FB360
	ldr r0,[r2,#0x30]	; 037FB362
	ldr r1,[r2,#0x38]	; 037FB364
	mov r3,#0x0	; 037FB366
	ldr r2,[r2,#0x3c]	; 037FB368
	ldr r5,[pool_037FB3F8]	; 037FB36A
	cmp r1,r5	; 037FB36C
	bcc loc_037FB380	; 037FB36E
	ldr r5,[pool_037FB3FC]	; 037FB370
	cmp r1,r5	; 037FB372
	bcs loc_037FB380	; 037FB374
	add r3,r1,r2	; 037FB376
	cmp r3,r5	; 037FB378
	bls loc_037FB380	; 037FB37A
	sub r5,r3,r5	; 037FB37C
	sub r2,r2,r5	; 037FB37E
loc_037FB380:
	ldr r5,[pool_037FB3E8]	; 037FB380
	cmp r1,r5	; 037FB382
	bcc loc_037FB396	; 037FB384
	ldr r5,[pool_037FB3EC]	; 037FB386
	cmp r1,r5	; 037FB388
	bcs loc_037FB396	; 037FB38A
	add r3,r1,r2	; 037FB38C
	cmp r3,r5	; 037FB38E
	bls loc_037FB396	; 037FB390
	sub r5,r3,r5	; 037FB392
	sub r2,r2,r5	; 037FB394
loc_037FB396:
	cmp r3,#0x0	; 037FB396
	beq loc_037FB3AE	; 037FB398
	cmp r2,#0x0	; 037FB39A
	ble loc_037FB3A8	; 037FB39C
	bl P2_StartCartImageRead	; 037FB39E
	mov r0,#0x3	; 037FB3A2
	strh r0,[r4,#0x0]	; 037FB3A4
	b loc_037FB3CE	; 037FB3A6
loc_037FB3A8:
	mov r0,#0x4	; 037FB3A8
	strh r0,[r4,#0x0]	; 037FB3AA
	b loc_037FB3CE	; 037FB3AC
loc_037FB3AE:
	mov r0,#0x4	; 037FB3AE
	strh r0,[r4,#0x0]	; 037FB3B0
	b loc_037FB3CE	; 037FB3B2
loc_037FB3B4:
	ldr r0,[pool_037FB3F0]	; 037FB3B4
	ldr r1,[r0,#0x0]	; 037FB3B6
	ldr r0,[pool_037FB3F4]	; 037FB3B8
	and r1,r0	; 037FB3BA
	cmp r1,#0x0	; 037FB3BC
	beq loc_037FB3CE	; 037FB3BE
	bl P2_FinishCartRead	; 037FB3C0
	mov r0,#0x4	; 037FB3C4
	strh r0,[r4,#0x0]	; 037FB3C6
	b loc_037FB3CE	; 037FB3C8
loc_037FB3CA:
	bl P2_InitializeBootProcedureCallbacks	; 037FB3CA
loc_037FB3CE:
	mov r0,#0x0	; 037FB3CE
	ldrsh r0,[r4,r0]	; 037FB3D0
	add sp,#0x4	; 037FB3D2
	pop {r4,r5}	; 037FB3D4
	pop {r3}	; 037FB3D6
	bx r3	; 037FB3D8
	.byte 0xC0, 0x46	; 037FB3DC
pool_037FB3DC:
loc_037FB3DC:
	.word FirmwareBootInfoScratchAddress	; 037FB3DC
pool_037FB3E0:
loc_037FB3E0:
	.word NdsCartHeaderRamAddress	; 037FB3E0
pool_037FB3E4:
loc_037FB3E4:
	.word 0x00008000	; 037FB3E4
pool_037FB3E8:
loc_037FB3E8:
	.word 0x02000000	; 037FB3E8
pool_037FB3EC:
loc_037FB3EC:
	.word 0x023BFE01	; 037FB3EC
pool_037FB3F0:
loc_037FB3F0:
	.word Bios7IrqFlagsAddress	; 037FB3F0
pool_037FB3F4:
loc_037FB3F4:
	.word 0x00080000	; 037FB3F4
pool_037FB3F8:
loc_037FB3F8:
	.word 0x037F8000	; 037FB3F8
pool_037FB3FC:
loc_037FB3FC:
	.word 0x03807E01	; 037FB3FC

; ===== function loc_037FB400 =====
loc_037FB400:
	push {lr}	; 037FB400
	sub sp,#0xc	; 037FB402
	bl loc_037FB664	; 037FB404
	cmp r0,#0x0	; 037FB408
	bne loc_037FB410	; 037FB40A
	mov r0,#0x0	; 037FB40C
	b loc_037FB448	; 037FB40E
loc_037FB410:
	ldr r2,[pool_037FB450]	; 037FB410
	ldrh r1,[r2,#0x0]	; 037FB412
	mov r0,#0x2	; 037FB414
	orr r1,r0	; 037FB416
	strh r1,[r2,#0x0]	; 037FB418
	mov r1,#0x30	; 037FB41A
	ldr r0,[pool_037FB454]	; 037FB41C
	strh r1,[r0,#0x0]	; 037FB41E
	add r0,sp,#0x0	; 037FB420
	bl loc_037FB5B8	; 037FB422
	bl loc_037FB714	; 037FB426
	bl loc_037FB578	; 037FB42A
	add r0,sp,#0x0	; 037FB42E
	bl loc_037FB55C	; 037FB430
	add r0,sp,#0x0	; 037FB434
	ldrh r0,[r0,#0x0]	; 037FB436
	bl loc_037FB6CC	; 037FB438
	ldr r2,[pool_037FB450]	; 037FB43C
	ldrh r1,[r2,#0x0]	; 037FB43E
	mov r0,#0x2	; 037FB440
	bic r1,r0	; 037FB442
	strh r1,[r2,#0x0]	; 037FB444
	mov r0,#0x1	; 037FB446
loc_037FB448:
	add sp,#0xc	; 037FB448
	pop {r3}	; 037FB44A
	bx r3	; 037FB44C
	.byte 0xC0, 0x46	; 037FB450
pool_037FB450:
loc_037FB450:
	.word REG_POWERCNT	; 037FB450
pool_037FB454:
loc_037FB454:
	.word REG_WIFIWAITCNT_ARM7	; 037FB454

; ===== function loc_037FB458 =====
loc_037FB458:
	push {r4,r5,lr}	; 037FB458
	sub sp,#0x4	; 037FB45A
	mov r5,#0x2	; 037FB45C
	str r5,[sp,#0x0]	; 037FB45E
	add r4,sp,#0x0	; 037FB460
	b loc_037FB46A	; 037FB462
loc_037FB464:
	add r0,r4,#0x0	; 037FB464
	bl loc_03804434	; 037FB466
loc_037FB46A:
	ldr r0,[sp,#0x0]	; 037FB46A
	and r0,r5	; 037FB46C
	cmp r0,#0x0	; 037FB46E
	bne loc_037FB464	; 037FB470
	add sp,#0x4	; 037FB472
	pop {r4,r5}	; 037FB474
	pop {r3}	; 037FB476
	bx r3	; 037FB478
	.byte 0x00, 0x00	; 037FB47C

; ===== function loc_037FB47C =====
loc_037FB47C:
	push {r4,r5,r6,lr}	; 037FB47C
	add r5,r0,#0x0	; 037FB47E
	add r4,r1,#0x0	; 037FB480
	add r6,r2,#0x0	; 037FB482
	bl loc_037FB458	; 037FB484
	add r0,r5,#0x0	; 037FB488
	add r1,r4,#0x0	; 037FB48A
	add r2,r6,#0x0	; 037FB48C
	bl loc_03804338	; 037FB48E
	pop {r4,r5,r6}	; 037FB492
	pop {r3}	; 037FB494
	bx r3	; 037FB496

; ===== function loc_037FB498 =====
loc_037FB498:
	ldr r0,[pool_037FB4B0]	; 037FB498
	ldr r2,[pool_037FB4B4]	; 037FB49A
	mov r1,#0x1	; 037FB49C
	b loc_037FB4AA	; 037FB49E
loc_037FB4A0:
	ldrh r3,[r2,#0x0]	; 037FB4A0
	and r3,r1	; 037FB4A2
	cmp r3,#0x0	; 037FB4A4
	beq loc_037FB4AE	; 037FB4A6
	sub r0,r0,#0x1	; 037FB4A8
loc_037FB4AA:
	cmp r0,#0x0	; 037FB4AA
	bne loc_037FB4A0	; 037FB4AC
loc_037FB4AE:
	bx lr	; 037FB4AE
pool_037FB4B0:
loc_037FB4B0:
	.word 0x00002000	; 037FB4B0
pool_037FB4B4:
loc_037FB4B4:
	.word 0x04808180	; 037FB4B4

; ===== function loc_037FB4B8 =====
loc_037FB4B8:
	push {r4,lr}	; 037FB4B8
	add r4,r0,#0x0	; 037FB4BA
	bl loc_037FB498	; 037FB4BC
	ldr r0,[pool_037FB4D4]	; 037FB4C0
	strh r4,[r0,#0x0]	; 037FB4C2
	lsr r1,r4,#0x10	; 037FB4C4
	ldr r0,[pool_037FB4D8]	; 037FB4C6
	strh r1,[r0,#0x0]	; 037FB4C8
	bl loc_037FB498	; 037FB4CA
	pop {r4}	; 037FB4CE
	pop {r3}	; 037FB4D0
	bx r3	; 037FB4D2
pool_037FB4D4:
loc_037FB4D4:
	.word REG_WIFI_RF_DATA1	; 037FB4D4
pool_037FB4D8:
loc_037FB4D8:
	.word REG_WIFI_RF_DATA2	; 037FB4D8

; ===== function loc_037FB4DC =====
loc_037FB4DC:
	ldr r0,[pool_037FB4F4]	; 037FB4DC
	ldr r2,[pool_037FB4F8]	; 037FB4DE
	mov r1,#0x1	; 037FB4E0
	b loc_037FB4EE	; 037FB4E2
loc_037FB4E4:
	ldrh r3,[r2,#0x0]	; 037FB4E4
	and r3,r1	; 037FB4E6
	cmp r3,#0x0	; 037FB4E8
	beq loc_037FB4F2	; 037FB4EA
	sub r0,r0,#0x1	; 037FB4EC
loc_037FB4EE:
	cmp r0,#0x0	; 037FB4EE
	bne loc_037FB4E4	; 037FB4F0
loc_037FB4F2:
	bx lr	; 037FB4F2
pool_037FB4F4:
loc_037FB4F4:
	.word 0x00002000	; 037FB4F4
pool_037FB4F8:
loc_037FB4F8:
	.word 0x0480815E	; 037FB4F8

; ===== function loc_037FB4FC =====
loc_037FB4FC:
	push {r4,r5,lr}	; 037FB4FC
	sub sp,#0x4	; 037FB4FE
	add r5,r0,#0x0	; 037FB500
	add r4,r1,#0x0	; 037FB502
	bl loc_037FB4DC	; 037FB504
	ldr r0,[pool_037FB524]	; 037FB508
	strh r4,[r0,#0x0]	; 037FB50A
	ldr r0,[pool_037FB528]	; 037FB50C
	orr r5,r0	; 037FB50E
	ldr r0,[pool_037FB52C]	; 037FB510
	strh r5,[r0,#0x0]	; 037FB512
	bl loc_037FB4DC	; 037FB514
	mov r0,#0x0	; 037FB518
	add sp,#0x4	; 037FB51A
	pop {r4,r5}	; 037FB51C
	pop {r3}	; 037FB51E
	bx r3	; 037FB520
	.byte 0xC0, 0x46	; 037FB524
pool_037FB524:
loc_037FB524:
	.word REG_WIFI_BB_WRITE	; 037FB524
pool_037FB528:
loc_037FB528:
	.word 0x00005000	; 037FB528
pool_037FB52C:
loc_037FB52C:
	.word REG_WIFI_BB_CNT	; 037FB52C

; ===== function loc_037FB530 =====
loc_037FB530:
	push {r4,lr}	; 037FB530
	add r4,r0,#0x0	; 037FB532
	bl loc_037FB4DC	; 037FB534
	ldr r0,[pool_037FB550]	; 037FB538
	orr r4,r0	; 037FB53A
	ldr r0,[pool_037FB554]	; 037FB53C
	strh r4,[r0,#0x0]	; 037FB53E
	bl loc_037FB4DC	; 037FB540
	ldr r0,[pool_037FB558]	; 037FB544
	ldrh r0,[r0,#0x0]	; 037FB546
	pop {r4}	; 037FB548
	pop {r3}	; 037FB54A
	bx r3	; 037FB54C
	.byte 0xC0, 0x46	; 037FB550
pool_037FB550:
loc_037FB550:
	.word 0x00006000	; 037FB550
pool_037FB554:
loc_037FB554:
	.word REG_WIFI_BB_CNT	; 037FB554
pool_037FB558:
loc_037FB558:
	.word REG_WIFI_BB_READ	; 037FB558

; ===== function loc_037FB55C =====
loc_037FB55C:
	ldrh r2,[r0,#0x2]	; 037FB55C
	lsr r1,r2,#0x7	; 037FB55E
	lsl r3,r1,#0x8	; 037FB560
	mov r1,#0x7f	; 037FB562
	and r2,r1	; 037FB564
	strh r2,[r0,#0x2]	; 037FB566
	ldrh r0,[r0,#0x2]	; 037FB568
	orr r3,r0	; 037FB56A
	ldr r0,[pool_037FB574]	; 037FB56C
	strh r3,[r0,#0x0]	; 037FB56E
	bx lr	; 037FB570
	.byte 0xC0, 0x46	; 037FB574
pool_037FB574:
loc_037FB574:
	.word REG_WIFI_RF_CNT	; 037FB574

; ===== function loc_037FB578 =====
loc_037FB578:
	push {r4,r5,r6,r7,lr}	; 037FB578
	sub sp,#0x4	; 037FB57A
	ldr r1,[pool_037FB5B0]	; 037FB57C
	ldr r0,[pool_037FB5B4]	; 037FB57E
	strh r1,[r0,#0x0]	; 037FB580
	mov r4,#0x64	; 037FB582
	mov r5,#0x0	; 037FB584
	str r5,[sp,#0x0]	; 037FB586
	mov r6,#0x1	; 037FB588
	add r7,sp,#0x0	; 037FB58A
loc_037FB58C:
	add r0,r4,#0x0	; 037FB58C
	add r1,r6,#0x0	; 037FB58E
	add r2,r7,#0x0	; 037FB590
	bl loc_037FB47C	; 037FB592
	add r0,r5,#0x0	; 037FB596
	ldr r1,[sp,#0x0]	; 037FB598
	bl loc_037FB4FC	; 037FB59A
	add r4,r4,#0x1	; 037FB59E
	add r5,r5,#0x1	; 037FB5A0
	cmp r5,#0x69	; 037FB5A2
	bcc loc_037FB58C	; 037FB5A4
	add sp,#0x4	; 037FB5A6
	pop {r4,r5,r6,r7}	; 037FB5A8
	pop {r3}	; 037FB5AA
	bx r3	; 037FB5AC
	.byte 0xC0, 0x46	; 037FB5B0
pool_037FB5B0:
loc_037FB5B0:
	.word 0x00000100	; 037FB5B0
pool_037FB5B4:
loc_037FB5B4:
	.word REG_WIFI_BB_MODE	; 037FB5B4

; ===== function loc_037FB5B8 =====
loc_037FB5B8:
	push {r4,lr}	; 037FB5B8
	sub sp,#0x8	; 037FB5BA
	add r4,r0,#0x0	; 037FB5BC
	mov r1,#0x0	; 037FB5BE
	add r0,sp,#0x0	; 037FB5C0
	strh r1,[r0,#0x0]	; 037FB5C2
	ldrh r0,[r0,#0x0]	; 037FB5C4
	add r1,r4,#0x0	; 037FB5C6
	mov r2,#0x8	; 037FB5C8
	bl loc_037FB600	; 037FB5CA
	mov r0,#0x40	; 037FB5CE
	mov r1,#0x1	; 037FB5D0
	add r2,r4,#0x0	; 037FB5D2
	bl loc_037FB47C	; 037FB5D4
	mov r0,#0x41	; 037FB5D8
	mov r1,#0x1	; 037FB5DA
	add r2,r4,#0x2	; 037FB5DC
	bl loc_037FB47C	; 037FB5DE
	mov r0,#0x42	; 037FB5E2
	mov r1,#0x1	; 037FB5E4
	add r2,r4,#0x4	; 037FB5E6
	bl loc_037FB47C	; 037FB5E8
	mov r0,#0x43	; 037FB5EC
	mov r1,#0x1	; 037FB5EE
	add r2,r4,#0x6	; 037FB5F0
	bl loc_037FB47C	; 037FB5F2
	add sp,#0x8	; 037FB5F6
	pop {r4}	; 037FB5F8
	pop {r3}	; 037FB5FA
	bx r3	; 037FB5FC
	.byte 0xC0, 0x46	; 037FB600

; ===== function loc_037FB600 =====
loc_037FB600:
	bx pc	; 037FB600
	.byte 0xC0, 0x46	; 037FB604
.arm

; ===== function loc_037FB604 =====
loc_037FB604:
	ldr pc,[pool_037FB608]	; 037FB604
pool_037FB608:
loc_037FB608:
	.word loc_037FF70C	; 037FB608
.thumb

; ===== function loc_037FB60C =====
loc_037FB60C:
	push {r4,r5,lr}	; 037FB60C
	sub sp,#0x4	; 037FB60E
	mov r2,#0xf	; 037FB610
	add r3,r1,#0x0	; 037FB612
	and r3,r2	; 037FB614
	lsl r3,r3,#0x1	; 037FB616
	ldr r4,[pool_037FB65C]	; 037FB618
	ldrh r3,[r4,r3]	; 037FB61A
	asr r1,r1,#0x4	; 037FB61C
	ldr r5,[pool_037FB660]	; 037FB61E
	and r1,r5	; 037FB620
	lsl r1,r1,#0x10	; 037FB622
	lsr r1,r1,#0x10	; 037FB624
	eor r1,r3	; 037FB626
	add r3,r0,#0x0	; 037FB628
	and r3,r2	; 037FB62A
	lsl r3,r3,#0x1	; 037FB62C
	ldrh r3,[r4,r3]	; 037FB62E
	eor r1,r3	; 037FB630
	lsl r1,r1,#0x10	; 037FB632
	lsr r3,r1,#0x10	; 037FB634
	asr r1,r3,#0x4	; 037FB636
	and r1,r5	; 037FB638
	lsl r1,r1,#0x10	; 037FB63A
	lsr r1,r1,#0x10	; 037FB63C
	and r3,r2	; 037FB63E
	lsl r3,r3,#0x1	; 037FB640
	ldrh r3,[r4,r3]	; 037FB642
	eor r1,r3	; 037FB644
	asr r0,r0,#0x4	; 037FB646
	and r0,r2	; 037FB648
	lsl r0,r0,#0x1	; 037FB64A
	ldrh r0,[r4,r0]	; 037FB64C
	eor r1,r0	; 037FB64E
	lsl r0,r1,#0x10	; 037FB650
	lsr r0,r0,#0x10	; 037FB652
	add sp,#0x4	; 037FB654
	pop {r4,r5}	; 037FB656
	pop {r3}	; 037FB658
	bx r3	; 037FB65A
pool_037FB65C:
loc_037FB65C:
	.word P2_Data_038054C0	; 037FB65C
pool_037FB660:
loc_037FB660:
	.word 0x00000FFF	; 037FB660

; ===== function loc_037FB664 =====
loc_037FB664:
	push {r4,r5,r6,r7,lr}	; 037FB664
	sub sp,#0xc	; 037FB666
	mov r5,#0x2a	; 037FB668
	add r0,r5,#0x0	; 037FB66A
	mov r1,#0x2	; 037FB66C
	add r2,sp,#0x0	; 037FB66E
	add r2,#0x2	; 037FB670
	bl loc_037FB47C	; 037FB672
	add r5,r5,#0x2	; 037FB676
	add r0,r5,#0x0	; 037FB678
	mov r1,#0x2	; 037FB67A
	add r2,sp,#0x4	; 037FB67C
	bl loc_037FB47C	; 037FB67E
	add r7,sp,#0x0	; 037FB682
	ldrh r1,[r7,#0x4]	; 037FB684
	ldr r0,[pool_037FB6C8]	; 037FB686
	cmp r1,r0	; 037FB688
	bcs loc_037FB6BE	; 037FB68A
	mov r6,#0x0	; 037FB68C
	add r4,r6,#0x0	; 037FB68E
	b loc_037FB6AA	; 037FB690
loc_037FB692:
	add r0,r5,#0x0	; 037FB692
	mov r1,#0x1	; 037FB694
	add r2,sp,#0x0	; 037FB696
	bl loc_037FB47C	; 037FB698
	add r5,r5,#0x1	; 037FB69C
	ldrb r0,[r7,#0x0]	; 037FB69E
	add r1,r6,#0x0	; 037FB6A0
	bl loc_037FB60C	; 037FB6A2
	add r6,r0,#0x0	; 037FB6A6
	add r4,r4,#0x1	; 037FB6A8
loc_037FB6AA:
	ldrh r0,[r7,#0x4]	; 037FB6AA
	cmp r4,r0	; 037FB6AC
	bcc loc_037FB692	; 037FB6AE
	ldrh r0,[r7,#0x2]	; 037FB6B0
	cmp r6,r0	; 037FB6B2
	bne loc_037FB6BA	; 037FB6B4
	mov r0,#0x1	; 037FB6B6
	b loc_037FB6C0	; 037FB6B8
loc_037FB6BA:
	mov r0,#0x0	; 037FB6BA
	b loc_037FB6C0	; 037FB6BC
loc_037FB6BE:
	mov r0,#0x0	; 037FB6BE
loc_037FB6C0:
	add sp,#0xc	; 037FB6C0
	pop {r4,r5,r6,r7}	; 037FB6C2
	pop {r3}	; 037FB6C4
	bx r3	; 037FB6C6
pool_037FB6C8:
loc_037FB6C8:
	.word 0x000001D6	; 037FB6C8

; ===== function loc_037FB6CC =====
loc_037FB6CC:
	push {lr}	; 037FB6CC
	sub sp,#0x4	; 037FB6CE
	cmp r0,#0x2	; 037FB6D0
	beq loc_037FB6D8	; 037FB6D2
	cmp r0,#0x3	; 037FB6D4
	b loc_037FB6DE	; 037FB6D6
loc_037FB6D8:
	ldr r0,[pool_037FB704]	; 037FB6D8
	bl loc_037FB4B8	; 037FB6DA
loc_037FB6DE:
	mov r0,#0x1e	; 037FB6DE
	bl loc_037FB530	; 037FB6E0
	mov r2,#0x3f	; 037FB6E4
	add r1,r0,#0x0	; 037FB6E6
	orr r1,r2	; 037FB6E8
	mov r0,#0x1e	; 037FB6EA
	bl loc_037FB4FC	; 037FB6EC
	ldr r1,[pool_037FB708]	; 037FB6F0
	ldr r0,[pool_037FB70C]	; 037FB6F2
	strh r1,[r0,#0x0]	; 037FB6F4
	mov r1,#0x1	; 037FB6F6
	ldr r0,[pool_037FB710]	; 037FB6F8
	strh r1,[r0,#0x0]	; 037FB6FA
	add sp,#0x4	; 037FB6FC
	pop {r3}	; 037FB6FE
	bx r3	; 037FB700
	.byte 0xC0, 0x46	; 037FB704
pool_037FB704:
loc_037FB704:
	.word 0x0000C008	; 037FB704
pool_037FB708:
loc_037FB708:
	.word 0x0000800D	; 037FB708
pool_037FB70C:
loc_037FB70C:
	.word REG_WIFI_BB_POWER	; 037FB70C
pool_037FB710:
loc_037FB710:
	.word REG_WIFI_POWER_US	; 037FB710

; ===== function loc_037FB714 =====
loc_037FB714:
	push {lr}	; 037FB714
	sub sp,#0x4	; 037FB716
	mov r1,#0x0	; 037FB718
	ldr r0,[pool_037FB730]	; 037FB71A
	strh r1,[r0,#0x0]	; 037FB71C
	ldr r0,[pool_037FB734]	; 037FB71E
	bl loc_037FF5B8	; 037FB720
	mov r1,#0x0	; 037FB724
	ldr r0,[pool_037FB738]	; 037FB726
	strh r1,[r0,#0x0]	; 037FB728
	add sp,#0x4	; 037FB72A
	pop {r3}	; 037FB72C
	bx r3	; 037FB72E
pool_037FB730:
loc_037FB730:
	.word REG_WIFI_POWER_US	; 037FB730
pool_037FB734:
loc_037FB734:
	.word 0x00051D23	; 037FB734
pool_037FB738:
loc_037FB738:
	.word REG_WIFI_BB_POWER	; 037FB738

; ===== function loc_037FB73C =====
P2_ThreadEntry_037FB73C:
	push {r4,r5,r6,r7,lr}	; 037FB73C
	sub sp,#0x4	; 037FB73E
	ldr r6,[pool_037FB7A4]	; 037FB740
	ldr r5,[r6,#0x0]	; 037FB742
	mov r0,#0x0	; 037FB744
	strh r0,[r5,#0x10]	; 037FB746
	strh r0,[r5,#0x14]	; 037FB748
	ldr r4,[pool_037FB7A8]	; 037FB74A
	ldr r7,[pool_037FB7AC]	; 037FB74C
loc_037FB74E:
	ldr r0,[r6,#0x0]	; 037FB74E
	ldr r0,[r0,r7]	; 037FB750
	add r1,sp,#0x0	; 037FB752
	mov r2,#0x0	; 037FB754
	bl loc_037FE678	; 037FB756
	cmp r0,#0x0	; 037FB75A
	beq loc_037FB764	; 037FB75C
	add r0,sp,#0x0	; 037FB75E
	bl loc_037FB8C4	; 037FB760
loc_037FB764:
	ldr r0,[pool_037FB7B0]	; 037FB764
	bl loc_037FDE54	; 037FB766
	ldrh r1,[r5,#0x10]	; 037FB76A
	strh r1,[r5,#0x12]	; 037FB76C
	ldrh r1,[r5,#0x12]	; 037FB76E
	lsl r1,r1,#0x1	; 037FB770
	ldrh r1,[r5,r1]	; 037FB772
	cmp r1,r4	; 037FB774
	bne loc_037FB784	; 037FB776
	ldrh r1,[r5,#0x10]	; 037FB778
	add r1,r1,#0x1	; 037FB77A
	strh r1,[r5,#0x10]	; 037FB77C
	bl loc_037FDE80	; 037FB77E
	b loc_037FB74E	; 037FB782
loc_037FB784:
	bl loc_037FDE80	; 037FB784
	ldrh r0,[r5,#0x12]	; 037FB788
	bl loc_037FB840	; 037FB78A
	strh r0,[r5,#0x14]	; 037FB78E
	ldrh r0,[r5,#0x14]	; 037FB790
	lsl r0,r0,#0x3	; 037FB792
	add r0,r5,r0	; 037FB794
	add r0,#0x94	; 037FB796
	ldr r0,[r0,#0x0]	; 037FB798
	bl loc_03805468	; 037FB79A
	strh r4,[r5,#0x14]	; 037FB79E
	b loc_037FB74E	; 037FB7A0
	.byte 0xC0, 0x46	; 037FB7A4
pool_037FB7A4:
loc_037FB7A4:
	.word FirmwareWlWorkPointerSlot	; 037FB7A4
pool_037FB7A8:
loc_037FB7A8:
	.word 0x0000FFFF	; 037FB7A8
pool_037FB7AC:
loc_037FB7AC:
	.word 0x000002DC	; 037FB7AC
pool_037FB7B0:
loc_037FB7B0:
	.word 0x01000010	; 037FB7B0

; ===== function loc_037FB7B4 =====
loc_037FB7B4:
	push {r4,r5,r6,r7,lr}	; 037FB7B4
	sub sp,#0x4	; 037FB7B6
	add r5,r0,#0x0	; 037FB7B8
	add r6,r1,#0x0	; 037FB7BA
	ldr r0,[pool_037FB830]	; 037FB7BC
	ldr r4,[r0,#0x0]	; 037FB7BE
	add r7,r4,#0x0	; 037FB7C0
	add r7,#0x90	; 037FB7C2
	ldr r0,[pool_037FB834]	; 037FB7C4
	bl loc_037FDE54	; 037FB7C6
	str r0,[sp,#0x0]	; 037FB7CA
	lsl r1,r6,#0x3	; 037FB7CC
	add r2,r7,#0x2	; 037FB7CE
	add r0,r2,r1	; 037FB7D0
	ldrh r2,[r2,r1]	; 037FB7D2
	cmp r2,#0x0	; 037FB7D4
	bne loc_037FB806	; 037FB7D6
	mov r2,#0x1	; 037FB7D8
	strh r2,[r0,#0x0]	; 037FB7DA
	ldr r0,[pool_037FB838]	; 037FB7DC
	strh r0,[r7,r1]	; 037FB7DE
	lsl r0,r5,#0x1	; 037FB7E0
	add r2,r4,#0x0	; 037FB7E2
	add r2,#0x8	; 037FB7E4
	add r1,r2,r0	; 037FB7E6
	ldrh r3,[r2,r0]	; 037FB7E8
	ldr r2,[pool_037FB838]	; 037FB7EA
	cmp r3,r2	; 037FB7EC
	bne loc_037FB7F4	; 037FB7EE
	strh r6,[r4,r0]	; 037FB7F0
	b loc_037FB7FC	; 037FB7F2
loc_037FB7F4:
	lsl r0,r3,#0x3	; 037FB7F4
	add r0,r4,r0	; 037FB7F6
	add r0,#0x90	; 037FB7F8
	strh r6,[r0,#0x0]	; 037FB7FA
loc_037FB7FC:
	strh r6,[r1,#0x0]	; 037FB7FC
	ldrh r0,[r4,#0x10]	; 037FB7FE
	cmp r5,r0	; 037FB800
	bge loc_037FB806	; 037FB802
	strh r5,[r4,#0x10]	; 037FB804
loc_037FB806:
	ldr r0,[sp,#0x0]	; 037FB806
	bl loc_037FDE80	; 037FB808
	cmp r5,#0x3	; 037FB80C
	beq loc_037FB826	; 037FB80E
	ldrh r0,[r4,#0x12]	; 037FB810
	cmp r0,#0x3	; 037FB812
	bne loc_037FB826	; 037FB814
	ldr r0,[pool_037FB830]	; 037FB816
	ldr r1,[r0,#0x0]	; 037FB818
	ldr r0,[pool_037FB83C]	; 037FB81A
	ldr r0,[r1,r0]	; 037FB81C
	mov r1,#0x0	; 037FB81E
	add r2,r1,#0x0	; 037FB820
	bl loc_037FE6F0	; 037FB822
loc_037FB826:
	add sp,#0x4	; 037FB826
	pop {r4,r5,r6,r7}	; 037FB828
	pop {r3}	; 037FB82A
	bx r3	; 037FB82C
	.byte 0xC0, 0x46	; 037FB830
pool_037FB830:
loc_037FB830:
	.word FirmwareWlWorkPointerSlot	; 037FB830
pool_037FB834:
loc_037FB834:
	.word 0x01000010	; 037FB834
pool_037FB838:
loc_037FB838:
	.word 0x0000FFFF	; 037FB838
pool_037FB83C:
loc_037FB83C:
	.word 0x000002DC	; 037FB83C

; ===== function loc_037FB840 =====
loc_037FB840:
	push {r4,r5,r6,r7,lr}	; 037FB840
	sub sp,#0x4	; 037FB842
	add r4,r0,#0x0	; 037FB844
	ldr r0,[pool_037FB888]	; 037FB846
	ldr r5,[r0,#0x0]	; 037FB848
	ldr r0,[pool_037FB88C]	; 037FB84A
	bl loc_037FDE54	; 037FB84C
	add r7,r0,#0x0	; 037FB850
	lsl r0,r4,#0x1	; 037FB852
	add r6,r5,r0	; 037FB854
	ldrh r4,[r5,r0]	; 037FB856
	ldr r0,[pool_037FB890]	; 037FB858
	cmp r4,r0	; 037FB85A
	beq loc_037FB878	; 037FB85C
	add r5,#0x90	; 037FB85E
	lsl r3,r4,#0x3	; 037FB860
	mov r2,#0x0	; 037FB862
	add r1,r5,r3	; 037FB864
	strh r2,[r1,#0x2]	; 037FB866
	ldrh r1,[r5,r3]	; 037FB868
	cmp r1,r0	; 037FB86A
	bne loc_037FB874	; 037FB86C
	strh r0,[r6,#0x0]	; 037FB86E
	strh r0,[r6,#0x8]	; 037FB870
	b loc_037FB878	; 037FB872
loc_037FB874:
	strh r1,[r6,#0x0]	; 037FB874
	strh r0,[r5,r3]	; 037FB876
loc_037FB878:
	add r0,r7,#0x0	; 037FB878
	bl loc_037FDE80	; 037FB87A
	add r0,r4,#0x0	; 037FB87E
	add sp,#0x4	; 037FB880
	pop {r4,r5,r6,r7}	; 037FB882
	pop {r3}	; 037FB884
	bx r3	; 037FB886
pool_037FB888:
loc_037FB888:
	.word FirmwareWlWorkPointerSlot	; 037FB888
pool_037FB88C:
loc_037FB88C:
	.word 0x01000010	; 037FB88C
pool_037FB890:
loc_037FB890:
	.word 0x0000FFFF	; 037FB890
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x58, 0x00, 0xA9, 0x01, 0x22	; 037FB8A4
	.byte 0x02, 0xF0, 0xE8, 0xFE, 0x00, 0xA8, 0x00, 0xF0, 0x0B, 0xF8, 0x03, 0x20, 0x0C, 0x21, 0xFF, 0xF7	; 037FB8B4
	.byte 0x7F, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xDC, 0x02, 0x00, 0x00	; 037FB8C4

; ===== function loc_037FB8C4 =====
loc_037FB8C4:
	push {lr}	; 037FB8C4
	sub sp,#0x4	; 037FB8C6
	ldr r1,[r0,#0x0]	; 037FB8C8
	cmp r1,#0x0	; 037FB8CA
	beq loc_037FB8E2	; 037FB8CC
	ldr r0,[pool_037FB8E8]	; 037FB8CE
	ldr r2,[r0,#0x0]	; 037FB8D0
	ldr r0,[pool_037FB8EC]	; 037FB8D2
	add r0,r2,r0	; 037FB8D4
	bl loc_037FB8F0	; 037FB8D6
	mov r0,#0x2	; 037FB8DA
	mov r1,#0xb	; 037FB8DC
	bl loc_037FB7B4	; 037FB8DE
loc_037FB8E2:
	add sp,#0x4	; 037FB8E2
	pop {r3}	; 037FB8E4
	bx r3	; 037FB8E6
pool_037FB8E8:
loc_037FB8E8:
	.word FirmwareWlWorkPointerSlot	; 037FB8E8
pool_037FB8EC:
loc_037FB8EC:
	.word 0x000001D4	; 037FB8EC

; ===== function loc_037FB8F0 =====
loc_037FB8F0:
	push {r4,r5,lr}	; 037FB8F0
	sub sp,#0x4	; 037FB8F2
	add r5,r0,#0x0	; 037FB8F4
	add r4,r1,#0x0	; 037FB8F6
	ldr r0,[pool_037FB938]	; 037FB8F8
	bl loc_037FDE54	; 037FB8FA
	ldrh r1,[r5,#0x8]	; 037FB8FE
	cmp r1,#0x0	; 037FB900
	bne loc_037FB90E	; 037FB902
	mov r1,#0x0	; 037FB904
	mvn r1,r1	; 037FB906
	str r1,[r4,#0x0]	; 037FB908
	str r4,[r5,#0x0]	; 037FB90A
	b loc_037FB914	; 037FB90C
loc_037FB90E:
	ldr r1,[r5,#0x4]	; 037FB90E
	str r1,[r4,#0x0]	; 037FB910
	str r4,[r1,#0x4]	; 037FB912
loc_037FB914:
	mov r1,#0x0	; 037FB914
	mvn r1,r1	; 037FB916
	str r1,[r4,#0x4]	; 037FB918
	ldrh r1,[r5,#0xa]	; 037FB91A
	strh r1,[r4,#0x8]	; 037FB91C
	ldr r1,[pool_037FB93C]	; 037FB91E
	strh r1,[r4,#0xa]	; 037FB920
	str r4,[r5,#0x4]	; 037FB922
	ldrh r1,[r5,#0x8]	; 037FB924
	add r1,r1,#0x1	; 037FB926
	strh r1,[r5,#0x8]	; 037FB928
	bl loc_037FDE80	; 037FB92A
	mov r0,#0x0	; 037FB92E
	add sp,#0x4	; 037FB930
	pop {r4,r5}	; 037FB932
	pop {r3}	; 037FB934
	bx r3	; 037FB936
pool_037FB938:
loc_037FB938:
	.word 0x01000000	; 037FB938
pool_037FB93C:
loc_037FB93C:
	.word 0x0000BF1D	; 037FB93C

; ===== function loc_037FB940 =====
loc_037FB940:
	push {r4,r5,lr}	; 037FB940
	sub sp,#0x4	; 037FB942
	add r5,r0,#0x0	; 037FB944
	add r4,r1,#0x0	; 037FB946
	ldrh r1,[r4,#0xa]	; 037FB948
	ldr r0,[pool_037FB9C4]	; 037FB94A
	cmp r1,r0	; 037FB94C
	beq loc_037FB954	; 037FB94E
	mov r0,#0x1	; 037FB950
	b loc_037FB9BA	; 037FB952
loc_037FB954:
	ldrh r1,[r4,#0x8]	; 037FB954
	ldrh r0,[r5,#0xa]	; 037FB956
	cmp r1,r0	; 037FB958
	beq loc_037FB960	; 037FB95A
	mov r0,#0x2	; 037FB95C
	b loc_037FB9BA	; 037FB95E
loc_037FB960:
	ldr r0,[pool_037FB9C8]	; 037FB960
	bl loc_037FDE54	; 037FB962
	ldrh r1,[r5,#0x8]	; 037FB966
	sub r1,r1,#0x1	; 037FB968
	strh r1,[r5,#0x8]	; 037FB96A
	ldrh r1,[r5,#0x8]	; 037FB96C
	cmp r1,#0x0	; 037FB96E
	bne loc_037FB97C	; 037FB970
	mov r1,#0x0	; 037FB972
	mvn r1,r1	; 037FB974
	str r1,[r5,#0x0]	; 037FB976
	str r1,[r5,#0x4]	; 037FB978
	b loc_037FB9B0	; 037FB97A
loc_037FB97C:
	ldr r1,[r5,#0x0]	; 037FB97C
	cmp r4,r1	; 037FB97E
	bne loc_037FB990	; 037FB980
	ldr r1,[r4,#0x4]	; 037FB982
	str r1,[r5,#0x0]	; 037FB984
	mov r1,#0x0	; 037FB986
	mvn r2,r1	; 037FB988
	ldr r1,[r5,#0x0]	; 037FB98A
	str r2,[r1,#0x0]	; 037FB98C
	b loc_037FB9B0	; 037FB98E
loc_037FB990:
	ldr r1,[r5,#0x4]	; 037FB990
	cmp r4,r1	; 037FB992
	bne loc_037FB9A4	; 037FB994
	ldr r1,[r4,#0x0]	; 037FB996
	str r1,[r5,#0x4]	; 037FB998
	mov r1,#0x0	; 037FB99A
	mvn r2,r1	; 037FB99C
	ldr r1,[r5,#0x4]	; 037FB99E
	str r2,[r1,#0x4]	; 037FB9A0
	b loc_037FB9B0	; 037FB9A2
loc_037FB9A4:
	ldr r2,[r4,#0x0]	; 037FB9A4
	ldr r1,[r4,#0x4]	; 037FB9A6
	str r2,[r1,#0x0]	; 037FB9A8
	ldr r2,[r4,#0x4]	; 037FB9AA
	ldr r1,[r4,#0x0]	; 037FB9AC
	str r2,[r1,#0x4]	; 037FB9AE
loc_037FB9B0:
	mov r1,#0x0	; 037FB9B0
	strh r1,[r4,#0x8]	; 037FB9B2
	bl loc_037FDE80	; 037FB9B4
	mov r0,#0x0	; 037FB9B8
loc_037FB9BA:
	add sp,#0x4	; 037FB9BA
	pop {r4,r5}	; 037FB9BC
	pop {r3}	; 037FB9BE
	bx r3	; 037FB9C0
	.byte 0xC0, 0x46	; 037FB9C4
pool_037FB9C4:
loc_037FB9C4:
	.word 0x0000BF1D	; 037FB9C4
pool_037FB9C8:
loc_037FB9C8:
	.word 0x01000000	; 037FB9C8

; ===== function loc_037FB9CC =====
P2_Entry_037FB9CC:
	push {r4,r5,lr}	; 037FB9CC
	sub sp,#0x4	; 037FB9CE
	add r5,r0,#0x0	; 037FB9D0
	ldr r0,[pool_037FBA2C]	; 037FB9D2
	ldr r2,[r0,#0x0]	; 037FB9D4
	ldr r0,[pool_037FBA30]	; 037FB9D6
	add r3,r2,r0	; 037FB9D8
	cmp r1,#0x0	; 037FB9DA
	bne loc_037FB9E2	; 037FB9DC
	mov r0,#0x0	; 037FB9DE
	b loc_037FBA22	; 037FB9E0
loc_037FB9E2:
	add r2,r1,#0x0	; 037FB9E2
	add r2,#0xc	; 037FB9E4
	ldr r0,[r3,#0x0]	; 037FB9E6
	cmp r0,#0x0	; 037FB9E8
	beq loc_037FB9F2	; 037FB9EA
	cmp r0,#0x1	; 037FB9EC
	beq loc_037FB9FE	; 037FB9EE
	b loc_037FBA08	; 037FB9F0
loc_037FB9F2:
	ldr r0,[r3,#0x4]	; 037FB9F2
	ldr r1,[r3,#0x8]	; 037FB9F4
	bl loc_037FEB0C	; 037FB9F6
	add r4,r0,#0x0	; 037FB9FA
	b loc_037FBA08	; 037FB9FC
loc_037FB9FE:
	add r0,r2,#0x0	; 037FB9FE
	ldr r1,[r3,#0x4]	; 037FBA00
	bl loc_0380546C	; 037FBA02
	add r4,r0,#0x0	; 037FBA06
loc_037FBA08:
	cmp r4,#0x0	; 037FBA08
	beq loc_037FBA20	; 037FBA0A
	ldr r0,[pool_037FBA34]	; 037FBA0C
	strh r0,[r4,#0xa]	; 037FBA0E
	mov r0,#0x0	; 037FBA10
	strh r0,[r4,#0x8]	; 037FBA12
	add r0,r5,#0x0	; 037FBA14
	add r1,r4,#0x0	; 037FBA16
	bl loc_037FBAE0	; 037FBA18
	add r0,r4,#0x0	; 037FBA1C
	b loc_037FBA22	; 037FBA1E
loc_037FBA20:
	mov r0,#0x0	; 037FBA20
loc_037FBA22:
	add sp,#0x4	; 037FBA22
	pop {r4,r5}	; 037FBA24
	pop {r3}	; 037FBA26
	bx r3	; 037FBA28
	.byte 0xC0, 0x46	; 037FBA2C
pool_037FBA2C:
loc_037FBA2C:
	.word FirmwareWlWorkPointerSlot	; 037FBA2C
pool_037FBA30:
loc_037FBA30:
	.word 0x00000150	; 037FBA30
pool_037FBA34:
loc_037FBA34:
	.word 0x0000BF1D	; 037FBA34
P2_Entry_037FBA38:
	push {r4,r5,r6,lr}	; 037FBA38
	add r5,r1,#0x0	; 037FBA3A
	ldr r2,[pool_037FBA84]	; 037FBA3C
	ldr r3,[r2,#0x0]	; 037FBA3E
	ldr r2,[pool_037FBA88]	; 037FBA40
	add r4,r3,r2	; 037FBA42
	ldrh r3,[r5,#0xa]	; 037FBA44
	ldr r2,[pool_037FBA8C]	; 037FBA46
	cmp r3,r2	; 037FBA48
	beq P2_Entry_037FBA50	; 037FBA4A
	mov r0,#0x1	; 037FBA4C
	b P2_Entry_037FBA7C	; 037FBA4E
P2_Entry_037FBA50:
	bl loc_037FB940	; 037FBA50
	add r6,r0,#0x0	; 037FBA54
	cmp r6,#0x0	; 037FBA56
	bne P2_Entry_037FBA7A	; 037FBA58
	ldr r0,[r4,#0x0]	; 037FBA5A
	cmp r0,#0x0	; 037FBA5C
	beq P2_Entry_037FBA66	; 037FBA5E
	cmp r0,#0x1	; 037FBA60
	beq P2_Entry_037FBA72	; 037FBA62
	b P2_Entry_037FBA7A	; 037FBA64
P2_Entry_037FBA66:
	ldr r0,[r4,#0x4]	; 037FBA66
	ldr r1,[r4,#0x8]	; 037FBA68
	add r2,r5,#0x0	; 037FBA6A
	bl P2_Entry_037FEAC0	; 037FBA6C
	b P2_Entry_037FBA7A	; 037FBA70
P2_Entry_037FBA72:
	add r0,r5,#0x0	; 037FBA72
	ldr r1,[r4,#0x8]	; 037FBA74
	bl loc_0380546C	; 037FBA76
P2_Entry_037FBA7A:
	add r0,r6,#0x0	; 037FBA7A
P2_Entry_037FBA7C:
	pop {r4,r5,r6}	; 037FBA7C
	pop {r3}	; 037FBA7E
	bx r3	; 037FBA80
	.byte 0xC0, 0x46	; 037FBA82
pool_037FBA84:
	.word FirmwareWlWorkPointerSlot	; 037FBA84
pool_037FBA88:
	.word 0x00000150	; 037FBA88
pool_037FBA8C:
	.word 0x0000BF1D	; 037FBA8C

; ===== function loc_037FBA90 =====
loc_037FBA90:
	push {r4,r5,r6,r7,lr}	; 037FBA90
	sub sp,#0x4	; 037FBA92
	add r4,r0,#0x0	; 037FBA94
	add r6,r1,#0x0	; 037FBA96
	add r5,r2,#0x0	; 037FBA98
	ldrh r1,[r5,#0xa]	; 037FBA9A
	ldr r0,[pool_037FBAD8]	; 037FBA9C
	cmp r1,r0	; 037FBA9E
	beq loc_037FBAA6	; 037FBAA0
	mov r0,#0x1	; 037FBAA2
	b loc_037FBACE	; 037FBAA4
loc_037FBAA6:
	ldr r0,[pool_037FBADC]	; 037FBAA6
	bl loc_037FDE54	; 037FBAA8
	add r7,r0,#0x0	; 037FBAAC
	add r0,r4,#0x0	; 037FBAAE
	add r1,r5,#0x0	; 037FBAB0
	bl loc_037FB940	; 037FBAB2
	add r4,r0,#0x0	; 037FBAB6
	cmp r4,#0x0	; 037FBAB8
	bne loc_037FBAC6	; 037FBABA
	add r0,r6,#0x0	; 037FBABC
	add r1,r5,#0x0	; 037FBABE
	bl loc_037FBAE0	; 037FBAC0
	add r4,r0,#0x0	; 037FBAC4
loc_037FBAC6:
	add r0,r7,#0x0	; 037FBAC6
	bl loc_037FDE80	; 037FBAC8
	add r0,r4,#0x0	; 037FBACC
loc_037FBACE:
	add sp,#0x4	; 037FBACE
	pop {r4,r5,r6,r7}	; 037FBAD0
	pop {r3}	; 037FBAD2
	bx r3	; 037FBAD4
	.byte 0xC0, 0x46	; 037FBAD8
pool_037FBAD8:
loc_037FBAD8:
	.word 0x0000BF1D	; 037FBAD8
pool_037FBADC:
loc_037FBADC:
	.word 0x01000000	; 037FBADC

; ===== function loc_037FBAE0 =====
loc_037FBAE0:
	push {r4,r5,lr}	; 037FBAE0
	sub sp,#0x4	; 037FBAE2
	add r5,r0,#0x0	; 037FBAE4
	add r4,r1,#0x0	; 037FBAE6
	ldrh r1,[r4,#0xa]	; 037FBAE8
	ldr r0,[pool_037FBB3C]	; 037FBAEA
	cmp r1,r0	; 037FBAEC
	beq loc_037FBAF4	; 037FBAEE
	mov r0,#0x1	; 037FBAF0
	b loc_037FBB32	; 037FBAF2
loc_037FBAF4:
	ldrh r0,[r4,#0x8]	; 037FBAF4
	cmp r0,#0x0	; 037FBAF6
	beq loc_037FBAFE	; 037FBAF8
	mov r0,#0x2	; 037FBAFA
	b loc_037FBB32	; 037FBAFC
loc_037FBAFE:
	ldr r0,[pool_037FBB40]	; 037FBAFE
	bl loc_037FDE54	; 037FBB00
	ldrh r1,[r5,#0x8]	; 037FBB04
	cmp r1,#0x0	; 037FBB06
	bne loc_037FBB14	; 037FBB08
	mov r1,#0x0	; 037FBB0A
	mvn r1,r1	; 037FBB0C
	str r1,[r4,#0x0]	; 037FBB0E
	str r4,[r5,#0x0]	; 037FBB10
	b loc_037FBB1A	; 037FBB12
loc_037FBB14:
	ldr r1,[r5,#0x4]	; 037FBB14
	str r1,[r4,#0x0]	; 037FBB16
	str r4,[r1,#0x4]	; 037FBB18
loc_037FBB1A:
	mov r1,#0x0	; 037FBB1A
	mvn r1,r1	; 037FBB1C
	str r1,[r4,#0x4]	; 037FBB1E
	ldrh r1,[r5,#0xa]	; 037FBB20
	strh r1,[r4,#0x8]	; 037FBB22
	str r4,[r5,#0x4]	; 037FBB24
	ldrh r1,[r5,#0x8]	; 037FBB26
	add r1,r1,#0x1	; 037FBB28
	strh r1,[r5,#0x8]	; 037FBB2A
	bl loc_037FDE80	; 037FBB2C
	mov r0,#0x0	; 037FBB30
loc_037FBB32:
	add sp,#0x4	; 037FBB32
	pop {r4,r5}	; 037FBB34
	pop {r3}	; 037FBB36
	bx r3	; 037FBB38
	.byte 0xC0, 0x46	; 037FBB3C
pool_037FBB3C:
loc_037FBB3C:
	.word 0x0000BF1D	; 037FBB3C
pool_037FBB40:
loc_037FBB40:
	.word 0x01000000	; 037FBB40
P2_Entry_037FBB44:
	ldr r0,[r0,#0x4]	; 037FBB44
	bx lr	; 037FBB46

; ===== function loc_037FBB48 =====
	push {r4,r5,r6,r7,lr}	; 037FBB48
	sub sp,#0xc	; 037FBB4A
	ldr r2,[pool_037FBD10]	; 037FBB4C
	ldr r0,[r2,#0x0]	; 037FBB4E
	ldr r1,[pool_037FBD14]	; 037FBB50
	add r5,r0,r1	; 037FBB52
	mov r1,#0x0	; 037FBB54
	add r7,r1,#0x0	; 037FBB56
	ldrh r3,[r5,#0x4]	; 037FBB58
	cmp r3,#0x0	; 037FBB5A
	beq loc_037FBB60	; 037FBB5C
	b loc_037FBD08	; 037FBB5E
loc_037FBB60:
	ldr r3,[pool_037FBD18]	; 037FBB60
	ldr r0,[r0,r3]	; 037FBB62
	str r0,[r5,#0x0]	; 037FBB64
	ldr r0,[r5,#0x0]	; 037FBB66
	str r0,[sp,#0x0]	; 037FBB68
	mvn r3,r1	; 037FBB6A
	cmp r0,r3	; 037FBB6C
	bne loc_037FBB72	; 037FBB6E
	b loc_037FBD08	; 037FBB70
loc_037FBB72:
	ldrh r0,[r0,#0xe]	; 037FBB72
	lsl r3,r0,#0x1	; 037FBB74
	ldr r0,[sp,#0x0]	; 037FBB76
	add r4,r0,r3	; 037FBB78
	add r4,#0x10	; 037FBB7A
	ldr r0,[r2,#0x0]	; 037FBB7C
	ldr r2,[pool_037FBD1C]	; 037FBB7E
	ldrh r2,[r0,r2]	; 037FBB80
	cmp r2,#0x0	; 037FBB82
	beq loc_037FBB90	; 037FBB84
	mov r0,#0x1	; 037FBB86
	strh r0,[r4,#0x2]	; 037FBB88
	mov r0,#0x6	; 037FBB8A
	strh r0,[r4,#0x4]	; 037FBB8C
	b loc_037FBCE0	; 037FBB8E
loc_037FBB90:
	ldr r2,[sp,#0x0]	; 037FBB90
	ldrh r6,[r2,#0xc]	; 037FBB92
	ldrh r2,[r4,#0x0]	; 037FBB94
	cmp r6,r2	; 037FBB96
	beq loc_037FBBA0	; 037FBB98
	mov r0,#0xd	; 037FBB9A
	strh r0,[r4,#0x4]	; 037FBB9C
	b loc_037FBCE0	; 037FBB9E
loc_037FBBA0:
	ldr r2,[pool_037FBD20]	; 037FBBA0
	add r3,r6,#0x0	; 037FBBA2
	and r3,r2	; 037FBBA4
	ldr r2,[pool_037FBD24]	; 037FBBA6
	cmp r3,r2	; 037FBBA8
	bgt loc_037FBBB6	; 037FBBAA
	cmp r3,r2	; 037FBBAC
	bge loc_037FBBF2	; 037FBBAE
	cmp r3,#0x0	; 037FBBB0
	beq loc_037FBBCA	; 037FBBB2
	b loc_037FBC82	; 037FBBB4
loc_037FBBB6:
	ldr r2,[pool_037FBD28]	; 037FBBB6
	cmp r3,r2	; 037FBBB8
	bgt loc_037FBBC2	; 037FBBBA
	cmp r3,r2	; 037FBBBC
	beq loc_037FBC0E	; 037FBBBE
	b loc_037FBC82	; 037FBBC0
loc_037FBBC2:
	ldr r0,[pool_037FBD2C]	; 037FBBC2
	cmp r3,r0	; 037FBBC4
	beq loc_037FBC70	; 037FBBC6
	b loc_037FBC82	; 037FBBC8
loc_037FBBCA:
	mov r7,#0x1	; 037FBBCA
	ldr r2,[pool_037FBD30]	; 037FBBCC
	str r2,[sp,#0x4]	; 037FBBCE
	mov r2,#0xff	; 037FBBD0
	and r6,r2	; 037FBBD2
	lsl r2,r6,#0x10	; 037FBBD4
	lsr r2,r2,#0x10	; 037FBBD6
	mov r3,#0xb	; 037FBBD8
	ldrh r6,[r5,#0x4]	; 037FBBDA
	and r6,r7	; 037FBBDC
	cmp r6,#0x0	; 037FBBDE
	beq loc_037FBBE6	; 037FBBE0
	mov r1,#0x2	; 037FBBE2
	b loc_037FBC86	; 037FBBE4
loc_037FBBE6:
	ldr r6,[pool_037FBD34]	; 037FBBE6
	ldrh r0,[r0,r6]	; 037FBBE8
	cmp r0,#0x20	; 037FBBEA
	bcs loc_037FBC86	; 037FBBEC
	add r1,r7,#0x0	; 037FBBEE
	b loc_037FBC86	; 037FBBF0
loc_037FBBF2:
	mov r7,#0x2	; 037FBBF2
	ldr r2,[pool_037FBD38]	; 037FBBF4
	str r2,[sp,#0x4]	; 037FBBF6
	mov r2,#0xff	; 037FBBF8
	and r6,r2	; 037FBBFA
	lsl r2,r6,#0x10	; 037FBBFC
	lsr r2,r2,#0x10	; 037FBBFE
	mov r3,#0x5	; 037FBC00
	ldr r6,[pool_037FBD34]	; 037FBC02
	ldrh r0,[r0,r6]	; 037FBC04
	cmp r0,#0x40	; 037FBC06
	beq loc_037FBC86	; 037FBC08
	mov r1,#0x1	; 037FBC0A
	b loc_037FBC86	; 037FBC0C
loc_037FBC0E:
	mov r2,#0xff	; 037FBC0E
	and r6,r2	; 037FBC10
	lsl r2,r6,#0x10	; 037FBC12
	lsr r2,r2,#0x10	; 037FBC14
	cmp r2,#0x40	; 037FBC16
	bcs loc_037FBC2E	; 037FBC18
	ldr r3,[pool_037FBD34]	; 037FBC1A
	ldrh r0,[r0,r3]	; 037FBC1C
	cmp r0,#0x10	; 037FBC1E
	bcs loc_037FBC24	; 037FBC20
	mov r1,#0x1	; 037FBC22
loc_037FBC24:
	mov r7,#0x4	; 037FBC24
	ldr r0,[pool_037FBD3C]	; 037FBC26
	str r0,[sp,#0x4]	; 037FBC28
	mov r3,#0x16	; 037FBC2A
	b loc_037FBC86	; 037FBC2C
loc_037FBC2E:
	cmp r2,#0x80	; 037FBC2E
	bcs loc_037FBC4C	; 037FBC30
	ldr r3,[pool_037FBD34]	; 037FBC32
	ldrh r0,[r0,r3]	; 037FBC34
	cmp r0,#0x40	; 037FBC36
	beq loc_037FBC3C	; 037FBC38
	mov r1,#0x1	; 037FBC3A
loc_037FBC3C:
	mov r7,#0x8	; 037FBC3C
	ldr r0,[pool_037FBD40]	; 037FBC3E
	str r0,[sp,#0x4]	; 037FBC40
	sub r2,#0x40	; 037FBC42
	lsl r0,r2,#0x10	; 037FBC44
	lsr r2,r0,#0x10	; 037FBC46
	mov r3,#0x6	; 037FBC48
	b loc_037FBC86	; 037FBC4A
loc_037FBC4C:
	cmp r2,#0xc0	; 037FBC4C
	bcs loc_037FBC6A	; 037FBC4E
	ldr r3,[pool_037FBD34]	; 037FBC50
	ldrh r0,[r0,r3]	; 037FBC52
	cmp r0,#0x10	; 037FBC54
	bcs loc_037FBC5A	; 037FBC56
	mov r1,#0x1	; 037FBC58
loc_037FBC5A:
	mov r7,#0x10	; 037FBC5A
	ldr r0,[pool_037FBD44]	; 037FBC5C
	str r0,[sp,#0x4]	; 037FBC5E
	sub r2,#0x80	; 037FBC60
	lsl r0,r2,#0x10	; 037FBC62
	lsr r2,r0,#0x10	; 037FBC64
	mov r3,#0x16	; 037FBC66
	b loc_037FBC86	; 037FBC68
loc_037FBC6A:
	mov r2,#0x1	; 037FBC6A
	add r3,r1,#0x0	; 037FBC6C
	b loc_037FBC86	; 037FBC6E
loc_037FBC70:
	mov r7,#0x40	; 037FBC70
	ldr r0,[pool_037FBD48]	; 037FBC72
	str r0,[sp,#0x4]	; 037FBC74
	mov r0,#0xff	; 037FBC76
	and r6,r0	; 037FBC78
	lsl r0,r6,#0x10	; 037FBC7A
	lsr r2,r0,#0x10	; 037FBC7C
	mov r3,#0xa	; 037FBC7E
	b loc_037FBC86	; 037FBC80
loc_037FBC82:
	mov r2,#0x1	; 037FBC82
	mov r3,#0x0	; 037FBC84
loc_037FBC86:
	cmp r2,r3	; 037FBC86
	bls loc_037FBC8E	; 037FBC88
	mov r1,#0x3	; 037FBC8A
	b loc_037FBCAA	; 037FBC8C
loc_037FBC8E:
	lsl r3,r2,#0x3	; 037FBC8E
	ldr r0,[sp,#0x0]	; 037FBC90
	ldrh r6,[r0,#0xe]	; 037FBC92
	ldr r0,[sp,#0x4]	; 037FBC94
	ldrh r0,[r0,r3]	; 037FBC96
	cmp r6,r0	; 037FBC98
	bcc loc_037FBCA8	; 037FBC9A
	ldrh r6,[r4,#0x2]	; 037FBC9C
	ldr r0,[sp,#0x4]	; 037FBC9E
	add r0,r0,r3	; 037FBCA0
	ldrh r0,[r0,#0x2]	; 037FBCA2
	cmp r6,r0	; 037FBCA4
	bcs loc_037FBCAA	; 037FBCA6
loc_037FBCA8:
	mov r1,#0x4	; 037FBCA8
loc_037FBCAA:
	cmp r1,#0x0	; 037FBCAA
	beq loc_037FBCB6	; 037FBCAC
	mov r0,#0x1	; 037FBCAE
	strh r0,[r4,#0x2]	; 037FBCB0
	strh r1,[r4,#0x4]	; 037FBCB2
	b loc_037FBCE0	; 037FBCB4
loc_037FBCB6:
	ldrh r0,[r5,#0x4]	; 037FBCB6
	orr r0,r7	; 037FBCB8
	strh r0,[r5,#0x4]	; 037FBCBA
	ldr r0,[sp,#0x0]	; 037FBCBC
	add r1,r4,#0x0	; 037FBCBE
	lsl r3,r2,#0x3	; 037FBCC0
	ldr r2,[sp,#0x4]	; 037FBCC2
	add r2,r2,r3	; 037FBCC4
	ldr r2,[r2,#0x4]	; 037FBCC6
	bl loc_03805470	; 037FBCC8
	strh r0,[r4,#0x4]	; 037FBCCC
	ldrh r0,[r4,#0x4]	; 037FBCCE
	cmp r0,#0x80	; 037FBCD0
	beq loc_037FBD08	; 037FBCD2
	cmp r0,#0x81	; 037FBCD4
	bne loc_037FBCE0	; 037FBCD6
	ldrh r0,[r5,#0x4]	; 037FBCD8
	bic r0,r7	; 037FBCDA
	strh r0,[r5,#0x4]	; 037FBCDC
	b loc_037FBCF4	; 037FBCDE
loc_037FBCE0:
	ldrh r0,[r5,#0x4]	; 037FBCE0
	bic r0,r7	; 037FBCE2
	strh r0,[r5,#0x4]	; 037FBCE4
	ldr r0,[pool_037FBD10]	; 037FBCE6
	ldr r1,[r0,#0x0]	; 037FBCE8
	ldr r0,[pool_037FBD18]	; 037FBCEA
	add r0,r1,r0	; 037FBCEC
	ldr r1,[r5,#0x0]	; 037FBCEE
	bl loc_037FBD50	; 037FBCF0
loc_037FBCF4:
	ldr r0,[pool_037FBD10]	; 037FBCF4
	ldr r1,[r0,#0x0]	; 037FBCF6
	ldr r0,[pool_037FBD4C]	; 037FBCF8
	ldrh r0,[r1,r0]	; 037FBCFA
	cmp r0,#0x0	; 037FBCFC
	beq loc_037FBD08	; 037FBCFE
	mov r0,#0x2	; 037FBD00
	mov r1,#0xb	; 037FBD02
	bl loc_037FB7B4	; 037FBD04
loc_037FBD08:
	add sp,#0xc	; 037FBD08
	pop {r4,r5,r6,r7}	; 037FBD0A
	pop {r3}	; 037FBD0C
	bx r3	; 037FBD0E
pool_037FBD10:
loc_037FBD10:
	.word FirmwareWlWorkPointerSlot	; 037FBD10
pool_037FBD14:
loc_037FBD14:
	.word 0x000003F8	; 037FBD14
pool_037FBD18:
loc_037FBD18:
	.word 0x000001D4	; 037FBD18
pool_037FBD1C:
loc_037FBD1C:
	.word 0x00000312	; 037FBD1C
pool_037FBD20:
loc_037FBD20:
	.word 0x0000FF00	; 037FBD20
pool_037FBD24:
loc_037FBD24:
	.word 0x00000100	; 037FBD24
pool_037FBD28:
loc_037FBD28:
	.word 0x00000200	; 037FBD28
pool_037FBD2C:
loc_037FBD2C:
	.word 0x00000300	; 037FBD2C
pool_037FBD30:
loc_037FBD30:
	.word 0x0230D980	; 037FBD30
pool_037FBD34:
loc_037FBD34:
	.word 0x00000320	; 037FBD34
pool_037FBD38:
loc_037FBD38:
	.word 0x0230D8D8	; 037FBD38
pool_037FBD3C:
loc_037FBD3C:
	.word 0x0230DA88	; 037FBD3C
pool_037FBD40:
loc_037FBD40:
	.word 0x0230D900	; 037FBD40
pool_037FBD44:
loc_037FBD44:
	.word 0x0230D9D8	; 037FBD44
pool_037FBD48:
loc_037FBD48:
	.word 0x0230D930	; 037FBD48
pool_037FBD4C:
loc_037FBD4C:
	.word 0x000001DC	; 037FBD4C

; ===== function loc_037FBD50 =====
loc_037FBD50:
	push {r4,r5,lr}	; 037FBD50
	sub sp,#0x4	; 037FBD52
	add r5,r0,#0x0	; 037FBD54
	add r4,r1,#0x0	; 037FBD56
	ldr r2,[pool_037FBDA8]	; 037FBD58
	ldr r2,[r2,#0x0]	; 037FBD5A
	ldr r3,[pool_037FBDAC]	; 037FBD5C
	ldrh r3,[r2,r3]	; 037FBD5E
	cmp r3,#0x0	; 037FBD60
	beq loc_037FBD78	; 037FBD62
	ldr r1,[pool_037FBDB0]	; 037FBD64
	add r1,r2,r1	; 037FBD66
	add r2,r4,#0x0	; 037FBD68
	bl loc_037FBA90	; 037FBD6A
	mov r0,#0x2	; 037FBD6E
	mov r1,#0x13	; 037FBD70
	bl loc_037FB7B4	; 037FBD72
	b loc_037FBDA0	; 037FBD76
loc_037FBD78:
	ldr r0,[pool_037FBDB4]	; 037FBD78
	ldr r0,[r2,r0]	; 037FBD7A
	mov r2,#0x0	; 037FBD7C
	bl loc_037FE6F0	; 037FBD7E
	cmp r0,#0x0	; 037FBD82
	beq loc_037FBD90	; 037FBD84
	add r0,r5,#0x0	; 037FBD86
	add r1,r4,#0x0	; 037FBD88
	bl loc_037FB940	; 037FBD8A
	b loc_037FBDA0	; 037FBD8E
loc_037FBD90:
	add r0,r5,#0x0	; 037FBD90
	ldr r1,[pool_037FBDA8]	; 037FBD92
	ldr r2,[r1,#0x0]	; 037FBD94
	ldr r1,[pool_037FBDB0]	; 037FBD96
	add r1,r2,r1	; 037FBD98
	add r2,r4,#0x0	; 037FBD9A
	bl loc_037FBA90	; 037FBD9C
loc_037FBDA0:
	add sp,#0x4	; 037FBDA0
	pop {r4,r5}	; 037FBDA2
	pop {r3}	; 037FBDA4
	bx r3	; 037FBDA6
pool_037FBDA8:
loc_037FBDA8:
	.word FirmwareWlWorkPointerSlot	; 037FBDA8
pool_037FBDAC:
loc_037FBDAC:
	.word 0x000001D0	; 037FBDAC
pool_037FBDB0:
loc_037FBDB0:
	.word 0x000001C8	; 037FBDB0
pool_037FBDB4:
loc_037FBDB4:
	.word 0x000002D8	; 037FBDB4

; ===== function loc_037FBDB8 =====
P2_Entry_037FBDB8:
	push {r4,r5,r6,r7,lr}	; 037FBDB8
	sub sp,#0xc	; 037FBDBA
	ldr r0,[pool_037FC058]	; 037FBDBC
	ldr r1,[r0,#0x0]	; 037FBDBE
	ldr r0,[pool_037FC05C]	; 037FBDC0
	add r4,r1,r0	; 037FBDC2
	ldr r0,[pool_037FC060]	; 037FBDC4
	add r5,r1,r0	; 037FBDC6
	bl loc_037FC190	; 037FBDC8
	ldr r1,[pool_037FC064]	; 037FBDCC
	ldrh r2,[r1,#0x0]	; 037FBDCE
	ldrh r0,[r1,#0x0]	; 037FBDD0
	lsl r0,r0,#0x8	; 037FBDD2
	add r0,r2,r0	; 037FBDD4
	ldrh r1,[r1,#0x0]	; 037FBDD6
	bl loc_037FC108	; 037FBDD8
	mov r1,#0x1	; 037FBDDC
	add r0,r4,#0x0	; 037FBDDE
	add r0,#0x7c	; 037FBDE0
	strh r1,[r0,#0x0]	; 037FBDE2
	ldrh r0,[r5,#0x1e]	; 037FBDE4
	lsl r0,r0,#0x1d	; 037FBDE6
	lsr r0,r0,#0x1f	; 037FBDE8
	cmp r0,#0x1	; 037FBDEA
	bne loc_037FBDFE	; 037FBDEC
	add r0,r4,#0x0	; 037FBDEE
	add r0,#0x7c	; 037FBDF0
	ldrh r1,[r0,#0x0]	; 037FBDF2
	mov r0,#0x20	; 037FBDF4
	orr r1,r0	; 037FBDF6
	add r0,r4,#0x0	; 037FBDF8
	add r0,#0x7c	; 037FBDFA
	strh r1,[r0,#0x0]	; 037FBDFC
loc_037FBDFE:
	ldrh r0,[r5,#0x18]	; 037FBDFE
	cmp r0,#0x0	; 037FBE00
	beq loc_037FBE14	; 037FBE02
	add r0,r4,#0x0	; 037FBE04
	add r0,#0x7c	; 037FBE06
	ldrh r1,[r0,#0x0]	; 037FBE08
	mov r0,#0x10	; 037FBE0A
	orr r1,r0	; 037FBE0C
	add r0,r4,#0x0	; 037FBE0E
	add r0,#0x7c	; 037FBE10
	strh r1,[r0,#0x0]	; 037FBE12
loc_037FBE14:
	mov r0,#0x0	; 037FBE14
	strh r0,[r4,#0x12]	; 037FBE16
	ldr r2,[pool_037FC068]	; 037FBE18
	ldr r1,[pool_037FC06C]	; 037FBE1A
	strh r2,[r1,#0x0]	; 037FBE1C
	ldr r2,[pool_037FC070]	; 037FBE1E
	ldr r1,[pool_037FC074]	; 037FBE20
	strh r2,[r1,#0x0]	; 037FBE22
	ldr r1,[pool_037FC078]	; 037FBE24
	strh r0,[r1,#0x0]	; 037FBE26
	ldr r1,[pool_037FC07C]	; 037FBE28
	strh r0,[r1,#0x0]	; 037FBE2A
	mov r1,#0xf	; 037FBE2C
	ldr r0,[pool_037FC080]	; 037FBE2E
	strh r1,[r0,#0x0]	; 037FBE30
	bl loc_037FC118	; 037FBE32
	bl loc_037FC128	; 037FBE36
	bl loc_037FD838	; 037FBE3A
	bl loc_037FDAE0	; 037FBE3E
	ldr r1,[pool_037FC068]	; 037FBE42
	ldr r0,[pool_037FC084]	; 037FBE44
	strh r1,[r0,#0x0]	; 037FBE46
	ldr r1,[pool_037FC070]	; 037FBE48
	ldr r0,[pool_037FC088]	; 037FBE4A
	strh r1,[r0,#0x0]	; 037FBE4C
	ldr r1,[pool_037FC08C]	; 037FBE4E
	ldr r0,[pool_037FC090]	; 037FBE50
	strh r1,[r0,#0x0]	; 037FBE52
	ldr r0,[pool_037FC058]	; 037FBE54
	ldr r1,[r0,#0x0]	; 037FBE56
	ldr r0,[pool_037FC094]	; 037FBE58
	ldrh r1,[r1,r0]	; 037FBE5A
	mov r0,#0x8	; 037FBE5C
	and r1,r0	; 037FBE5E
	cmp r1,#0x0	; 037FBE60
	beq loc_037FBE6C	; 037FBE62
	ldr r1,[pool_037FC098]	; 037FBE64
	ldr r0,[pool_037FC09C]	; 037FBE66
	strh r1,[r0,#0x0]	; 037FBE68
	b loc_037FBE72	; 037FBE6A
loc_037FBE6C:
	mov r1,#0x0	; 037FBE6C
	ldr r0,[pool_037FC09C]	; 037FBE6E
	strh r1,[r0,#0x0]	; 037FBE70
loc_037FBE72:
	mov r6,#0x0	; 037FBE72
	ldr r1,[pool_037FC0A0]	; 037FBE74
	strh r6,[r1,#0x0]	; 037FBE76
	ldr r0,[pool_037FC0A4]	; 037FBE78
	strh r6,[r0,#0x0]	; 037FBE7A
	ldrh r2,[r4,#0xc]	; 037FBE7C
	cmp r2,#0x4	; 037FBE7E
	bls loc_037FBE84	; 037FBE80
	b loc_037FC030	; 037FBE82
loc_037FBE84:
	add r2,r2,r2	; 037FBE84
P2_SwitchIndexPC_037FBE84:
	add r2,pc	; 037FBE86
	ldrh r2,[r2,#(P2_SwitchTable_037FBE84 - (P2_SwitchIndexPC_037FBE84 + 4))]	; 037FBE88
	lsl r2,r2,#0x10	; 037FBE8A
	asr r2,r2,#0x10	; 037FBE8C
P2_SwitchTargetPC_037FBE84:
	add r2,pc	; 037FBE8E
	bx r2	; 037FBE90
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FBE84:
	.halfword (loc_037FBE9C + 1) - (P2_SwitchTargetPC_037FBE84 + 4)
	.halfword (loc_037FBEC4 + 1) - (P2_SwitchTargetPC_037FBE84 + 4)
	.halfword (loc_037FBF64 + 1) - (P2_SwitchTargetPC_037FBE84 + 4)
	.halfword (loc_037FBFD4 + 1) - (P2_SwitchTargetPC_037FBE84 + 4)
	.halfword (loc_037FC01C + 1) - (P2_SwitchTargetPC_037FBE84 + 4)
P2_SwitchTable_037FBE84End:
loc_037FBE9C:
	mov r3,#0x3f	; 037FBE9C
	ldr r2,[pool_037FC0A8]	; 037FBE9E
	strh r3,[r2,#0x0]	; 037FBEA0
	ldr r3,[pool_037FC070]	; 037FBEA2
	ldr r2,[pool_037FC0AC]	; 037FBEA4
	strh r3,[r2,#0x0]	; 037FBEA6
	mov r3,#0x8	; 037FBEA8
	ldr r2,[pool_037FC0B0]	; 037FBEAA
	strh r3,[r2,#0x0]	; 037FBEAC
	strh r6,[r1,#0x0]	; 037FBEAE
	strh r6,[r0,#0x0]	; 037FBEB0
	ldr r0,[pool_037FC0B4]	; 037FBEB2
	strh r6,[r0,#0x0]	; 037FBEB4
	mov r1,#0x1	; 037FBEB6
	ldr r0,[pool_037FC0B8]	; 037FBEB8
	strh r1,[r0,#0x0]	; 037FBEBA
	mov r0,#0x40	; 037FBEBC
	bl loc_037FC268	; 037FBEBE
	b loc_037FC030	; 037FBEC2
loc_037FBEC4:
	ldr r2,[pool_037FC0BC]	; 037FBEC4
	ldr r0,[pool_037FC0A8]	; 037FBEC6
	strh r2,[r0,#0x0]	; 037FBEC8
	ldr r2,[pool_037FC08C]	; 037FBECA
	ldr r0,[pool_037FC090]	; 037FBECC
	strh r2,[r0,#0x0]	; 037FBECE
	ldr r2,[pool_037FC0C0]	; 037FBED0
	ldr r0,[pool_037FC0AC]	; 037FBED2
	strh r2,[r0,#0x0]	; 037FBED4
	mov r2,#0xd	; 037FBED6
	ldr r0,[pool_037FC0B0]	; 037FBED8
	strh r2,[r0,#0x0]	; 037FBEDA
	ldr r0,[pool_037FC0C4]	; 037FBEDC
	strh r0,[r1,#0x0]	; 037FBEDE
	mov r1,#0x1	; 037FBEE0
	ldr r0,[pool_037FC0B8]	; 037FBEE2
	strh r1,[r0,#0x0]	; 037FBEE4
	add r5,sp,#0x0	; 037FBEE6
	ldr r0,[pool_037FC0C8]	; 037FBEE8
	ldrh r0,[r0,#0x0]	; 037FBEEA
	strh r0,[r5,#0x0]	; 037FBEEC
	ldr r0,[pool_037FC0CC]	; 037FBEEE
	ldrh r0,[r0,#0x0]	; 037FBEF0
	strh r0,[r5,#0x2]	; 037FBEF2
	ldr r0,[pool_037FC0D0]	; 037FBEF4
	ldrh r0,[r0,#0x0]	; 037FBEF6
	strh r0,[r5,#0x4]	; 037FBEF8
	ldr r0,[pool_037FC0D4]	; 037FBEFA
	ldrh r0,[r0,#0x0]	; 037FBEFC
	strh r0,[r5,#0x6]	; 037FBEFE
	add r0,r4,#0x0	; 037FBF00
	add r0,#0x6e	; 037FBF02
	ldrh r0,[r0,#0x0]	; 037FBF04
	lsl r7,r0,#0xa	; 037FBF06
	ldr r0,[sp,#0x0]	; 037FBF08
	ldr r1,[sp,#0x4]	; 037FBF0A
	add r2,r7,#0x0	; 037FBF0C
	add r3,r6,#0x0	; 037FBF0E
	bl loc_037FC138	; 037FBF10
	str r0,[sp,#0x0]	; 037FBF14
	str r1,[sp,#0x4]	; 037FBF16
	lsl r3,r6,#0	; 037FBF18
	mov r2,#0x1	; 037FBF1A
	add r0,r0,r2	; 037FBF1C
	adc r1,r3	; 037FBF1E
	str r0,[sp,#0x0]	; 037FBF20
	str r1,[sp,#0x4]	; 037FBF22
	add r2,r7,#0x0	; 037FBF24
	bl loc_037FC144	; 037FBF26
	str r0,[sp,#0x0]	; 037FBF2A
	str r1,[sp,#0x4]	; 037FBF2C
	ldrh r1,[r5,#0x6]	; 037FBF2E
	ldr r0,[pool_037FC0D8]	; 037FBF30
	strh r1,[r0,#0x0]	; 037FBF32
	ldrh r1,[r5,#0x4]	; 037FBF34
	ldr r0,[pool_037FC0DC]	; 037FBF36
	strh r1,[r0,#0x0]	; 037FBF38
	ldrh r1,[r5,#0x2]	; 037FBF3A
	ldr r0,[pool_037FC0E0]	; 037FBF3C
	strh r1,[r0,#0x0]	; 037FBF3E
	ldrh r2,[r5,#0x0]	; 037FBF40
	mov r1,#0x1	; 037FBF42
	orr r2,r1	; 037FBF44
	ldr r0,[pool_037FC0E4]	; 037FBF46
	strh r2,[r0,#0x0]	; 037FBF48
	ldr r0,[pool_037FC0B4]	; 037FBF4A
	strh r1,[r0,#0x0]	; 037FBF4C
	ldr r0,[pool_037FC0E8]	; 037FBF4E
	strh r1,[r0,#0x0]	; 037FBF50
	mov r0,#0x40	; 037FBF52
	bl loc_037FC268	; 037FBF54
	bl loc_037FC150	; 037FBF58
	mov r1,#0x2	; 037FBF5C
	ldr r0,[pool_037FC0EC]	; 037FBF5E
	strh r1,[r0,#0x0]	; 037FBF60
	b loc_037FC030	; 037FBF62
loc_037FBF64:
	ldr r1,[pool_037FC0F0]	; 037FBF64
	ldr r0,[pool_037FC0A8]	; 037FBF66
	strh r1,[r0,#0x0]	; 037FBF68
	ldr r1,[pool_037FC058]	; 037FBF6A
	ldr r2,[r1,#0x0]	; 037FBF6C
	ldr r1,[pool_037FC094]	; 037FBF6E
	ldrh r2,[r2,r1]	; 037FBF70
	mov r1,#0x20	; 037FBF72
	and r2,r1	; 037FBF74
	cmp r2,#0x0	; 037FBF76
	beq loc_037FBF82	; 037FBF78
	ldrh r2,[r0,#0x0]	; 037FBF7A
	mov r1,#0xc0	; 037FBF7C
	orr r2,r1	; 037FBF7E
	strh r2,[r0,#0x0]	; 037FBF80
loc_037FBF82:
	ldr r0,[pool_037FC058]	; 037FBF82
	ldr r1,[r0,#0x0]	; 037FBF84
	ldr r0,[pool_037FC094]	; 037FBF86
	ldrh r1,[r1,r0]	; 037FBF88
	mov r0,#0x20	; 037FBF8A
	and r1,r0	; 037FBF8C
	cmp r1,#0x0	; 037FBF8E
	beq loc_037FBF9C	; 037FBF90
	ldr r2,[pool_037FC09C]	; 037FBF92
	ldrh r1,[r2,#0x0]	; 037FBF94
	mov r0,#0x68	; 037FBF96
	orr r1,r0	; 037FBF98
	strh r1,[r2,#0x0]	; 037FBF9A
loc_037FBF9C:
	add r0,r4,#0x0	; 037FBF9C
	add r0,#0x64	; 037FBF9E
	ldrh r1,[r0,#0x0]	; 037FBFA0
	mov r0,#0x1	; 037FBFA2
	and r1,r0	; 037FBFA4
	cmp r1,#0x0	; 037FBFA6
	beq loc_037FBFB2	; 037FBFA8
	ldr r1,[pool_037FC0F4]	; 037FBFAA
	ldr r0,[pool_037FC0AC]	; 037FBFAC
	strh r1,[r0,#0x0]	; 037FBFAE
	b loc_037FBFB8	; 037FBFB0
loc_037FBFB2:
	ldr r1,[pool_037FC0F8]	; 037FBFB2
	ldr r0,[pool_037FC0AC]	; 037FBFB4
	strh r1,[r0,#0x0]	; 037FBFB6
loc_037FBFB8:
	mov r1,#0xb	; 037FBFB8
	ldr r0,[pool_037FC0B0]	; 037FBFBA
	strh r1,[r0,#0x0]	; 037FBFBC
	mov r1,#0x1	; 037FBFBE
	ldr r0,[pool_037FC0B8]	; 037FBFC0
	strh r1,[r0,#0x0]	; 037FBFC2
	ldr r0,[pool_037FC0B4]	; 037FBFC4
	strh r1,[r0,#0x0]	; 037FBFC6
	ldr r0,[pool_037FC0E8]	; 037FBFC8
	strh r1,[r0,#0x0]	; 037FBFCA
	mov r0,#0x20	; 037FBFCC
	bl loc_037FC268	; 037FBFCE
	b loc_037FC030	; 037FBFD2
loc_037FBFD4:
	ldr r1,[pool_037FC070]	; 037FBFD4
	ldr r0,[pool_037FC088]	; 037FBFD6
	strh r1,[r0,#0x0]	; 037FBFD8
	ldr r1,[pool_037FC0FC]	; 037FBFDA
	ldr r0,[pool_037FC0A8]	; 037FBFDC
	strh r1,[r0,#0x0]	; 037FBFDE
	add r0,r4,#0x0	; 037FBFE0
	add r0,#0x64	; 037FBFE2
	ldrh r0,[r0,#0x0]	; 037FBFE4
	mov r1,#0x1	; 037FBFE6
	and r0,r1	; 037FBFE8
	cmp r0,#0x0	; 037FBFEA
	beq loc_037FBFF6	; 037FBFEC
	ldr r1,[pool_037FC100]	; 037FBFEE
	ldr r0,[pool_037FC0AC]	; 037FBFF0
	strh r1,[r0,#0x0]	; 037FBFF2
	b loc_037FBFFA	; 037FBFF4
loc_037FBFF6:
	ldr r0,[pool_037FC0AC]	; 037FBFF6
	strh r1,[r0,#0x0]	; 037FBFF8
loc_037FBFFA:
	mov r1,#0xb	; 037FBFFA
	ldr r0,[pool_037FC0B0]	; 037FBFFC
	strh r1,[r0,#0x0]	; 037FBFFE
	mov r1,#0x1	; 037FC000
	ldr r0,[pool_037FC0B8]	; 037FC002
	strh r1,[r0,#0x0]	; 037FC004
	ldr r0,[pool_037FC0B4]	; 037FC006
	strh r1,[r0,#0x0]	; 037FC008
	ldr r0,[pool_037FC0E8]	; 037FC00A
	strh r1,[r0,#0x0]	; 037FC00C
	mov r1,#0x0	; 037FC00E
	ldr r0,[pool_037FC104]	; 037FC010
	strh r1,[r0,#0x0]	; 037FC012
	mov r0,#0x20	; 037FC014
	bl loc_037FC268	; 037FC016
	b loc_037FC030	; 037FC01A
loc_037FC01C:
	ldr r0,[pool_037FC0A8]	; 037FC01C
	strh r6,[r0,#0x0]	; 037FC01E
	ldr r0,[pool_037FC090]	; 037FC020
	strh r6,[r0,#0x0]	; 037FC022
	mov r1,#0x1	; 037FC024
	ldr r0,[pool_037FC0B8]	; 037FC026
	strh r1,[r0,#0x0]	; 037FC028
	mov r0,#0x20	; 037FC02A
	bl loc_037FC268	; 037FC02C
loc_037FC030:
	mov r1,#0x0	; 037FC030
	ldr r0,[pool_037FC104]	; 037FC032
	strh r1,[r0,#0x0]	; 037FC034
	bl loc_037FC160	; 037FC036
	mov r0,#0x2	; 037FC03A
	ldr r1,[pool_037FC0EC]	; 037FC03C
	strh r0,[r1,#0x0]	; 037FC03E
	ldrh r1,[r4,#0xe]	; 037FC040
	cmp r1,#0x1	; 037FC042
	bne loc_037FC04A	; 037FC044
	bl loc_037FC170	; 037FC046
loc_037FC04A:
	bl loc_037FC180	; 037FC04A
	add sp,#0xc	; 037FC04E
	pop {r4,r5,r6,r7}	; 037FC050
	pop {r3}	; 037FC052
	bx r3	; 037FC054
	.byte 0xC0, 0x46	; 037FC058
pool_037FC058:
loc_037FC058:
	.word FirmwareWlWorkPointerSlot	; 037FC058
pool_037FC05C:
loc_037FC05C:
	.word 0x00000318	; 037FC05C
pool_037FC060:
loc_037FC060:
	.word 0x000002F0	; 037FC060
pool_037FC064:
loc_037FC064:
	.word REG_WIFI_RANDOM	; 037FC064
pool_037FC068:
loc_037FC068:
	.word 0x00008000	; 037FC068
pool_037FC06C:
loc_037FC06C:
	.word REG_WIFI_WEP_CNT	; 037FC06C
pool_037FC070:
loc_037FC070:
	.word 0x0000FFFF	; 037FC070
pool_037FC074:
loc_037FC074:
	.word REG_WIFI_POST_BEACON	; 037FC074
pool_037FC078:
loc_037FC078:
	.word REG_WIFI_AID_FULL	; 037FC078
pool_037FC07C:
loc_037FC07C:
	.word REG_WIFI_AID_LOW	; 037FC07C
pool_037FC080:
loc_037FC080:
	.word REG_WIFI_POWER_TX	; 037FC080
pool_037FC084:
loc_037FC084:
	.word REG_WIFI_RXCNT	; 037FC084
pool_037FC088:
loc_037FC088:
	.word REG_WIFI_IF	; 037FC088
pool_037FC08C:
loc_037FC08C:
	.word 0x00001FFF	; 037FC08C
pool_037FC090:
loc_037FC090:
	.word REG_WIFI_RXSTAT_OVF_IE	; 037FC090
pool_037FC094:
loc_037FC094:
	.word 0x00000638	; 037FC094
pool_037FC098:
loc_037FC098:
	.word 0x00000400	; 037FC098
pool_037FC09C:
loc_037FC09C:
	.word REG_WIFI_RXSTAT_INC_IE	; 037FC09C
pool_037FC0A0:
loc_037FC0A0:
	.word REG_WIFI_TXSTATCNT	; 037FC0A0
pool_037FC0A4:
loc_037FC0A4:
	.word REG_WIFI_UNKNOWN_00A	; 037FC0A4
pool_037FC0A8:
loc_037FC0A8:
	.word REG_WIFI_IE	; 037FC0A8
pool_037FC0AC:
loc_037FC0AC:
	.word REG_WIFI_RXFILTER	; 037FC0AC
pool_037FC0B0:
loc_037FC0B0:
	.word REG_WIFI_RXFILTER2	; 037FC0B0
pool_037FC0B4:
loc_037FC0B4:
	.word REG_WIFI_US_COUNTCNT	; 037FC0B4
pool_037FC0B8:
loc_037FC0B8:
	.word REG_WIFI_MODE_RST	; 037FC0B8
pool_037FC0BC:
loc_037FC0BC:
	.word 0x0000703F	; 037FC0BC
pool_037FC0C0:
loc_037FC0C0:
	.word 0x00000301	; 037FC0C0
pool_037FC0C4:
loc_037FC0C4:
	.word 0x0000E000	; 037FC0C4
pool_037FC0C8:
loc_037FC0C8:
	.word REG_WIFI_US_COUNT0	; 037FC0C8
pool_037FC0CC:
loc_037FC0CC:
	.word REG_WIFI_US_COUNT1	; 037FC0CC
pool_037FC0D0:
loc_037FC0D0:
	.word REG_WIFI_US_COUNT2	; 037FC0D0
pool_037FC0D4:
loc_037FC0D4:
	.word REG_WIFI_US_COUNT3	; 037FC0D4
pool_037FC0D8:
loc_037FC0D8:
	.word REG_WIFI_US_COMPARE3	; 037FC0D8
pool_037FC0DC:
loc_037FC0DC:
	.word REG_WIFI_US_COMPARE2	; 037FC0DC
pool_037FC0E0:
loc_037FC0E0:
	.word REG_WIFI_US_COMPARE1	; 037FC0E0
pool_037FC0E4:
loc_037FC0E4:
	.word REG_WIFI_US_COMPARE0	; 037FC0E4
pool_037FC0E8:
loc_037FC0E8:
	.word REG_WIFI_US_COMPARECNT	; 037FC0E8
pool_037FC0EC:
loc_037FC0EC:
	.word REG_WIFI_TXREQ_SET	; 037FC0EC
pool_037FC0F0:
loc_037FC0F0:
	.word 0x0000E03F	; 037FC0F0
pool_037FC0F4:
loc_037FC0F4:
	.word 0x00000581	; 037FC0F4
pool_037FC0F8:
loc_037FC0F8:
	.word 0x00000181	; 037FC0F8
pool_037FC0FC:
loc_037FC0FC:
	.word 0x0000C03F	; 037FC0FC
pool_037FC100:
loc_037FC100:
	.word 0x00000401	; 037FC100
pool_037FC104:
loc_037FC104:
	.word REG_WIFI_UNKNOWN_048	; 037FC104

; ===== function loc_037FC108 =====
loc_037FC108:
	bx pc	; 037FC108
	.byte 0xC0, 0x46	; 037FC10C
.arm

; ===== function loc_037FC10C =====
loc_037FC10C:
	ldr r12,[pool_037FC114]	; 037FC10C
	bx r12	; 037FC110
pool_037FC114:
loc_037FC114:
	.word loc_0230515C + 1	; 037FC114
.thumb

; ===== function loc_037FC118 =====
loc_037FC118:
	bx pc	; 037FC118
	.byte 0xC0, 0x46	; 037FC11C
.arm

; ===== function loc_037FC11C =====
loc_037FC11C:
	ldr r12,[pool_037FC124]	; 037FC11C
	bx r12	; 037FC120
pool_037FC124:
loc_037FC124:
	.word P4_Entry_02306EE0 + 1	; 037FC124
.thumb

; ===== function loc_037FC128 =====
loc_037FC128:
	bx pc	; 037FC128
	.byte 0xC0, 0x46	; 037FC12C
.arm

; ===== function loc_037FC12C =====
loc_037FC12C:
	ldr r12,[pool_037FC134]	; 037FC12C
	bx r12	; 037FC130
pool_037FC134:
loc_037FC134:
	.word P4_Entry_0230D1C8 + 1	; 037FC134
.thumb

; ===== function loc_037FC138 =====
loc_037FC138:
	bx pc	; 037FC138
	.byte 0xC0, 0x46	; 037FC13C
.arm

; ===== function loc_037FC13C =====
loc_037FC13C:
	ldr pc,[pool_037FC140]	; 037FC13C
pool_037FC140:
loc_037FC140:
	.word loc_03804D30	; 037FC140
.thumb

; ===== function loc_037FC144 =====
loc_037FC144:
	bx pc	; 037FC144
	.byte 0xC0, 0x46	; 037FC148
.arm

; ===== function loc_037FC148 =====
loc_037FC148:
	ldr pc,[pool_037FC14C]	; 037FC148
pool_037FC14C:
loc_037FC14C:
	.word loc_03804F38	; 037FC14C
.thumb

; ===== function loc_037FC150 =====
loc_037FC150:
	bx pc	; 037FC150
	.byte 0xC0, 0x46	; 037FC154
.arm

; ===== function loc_037FC154 =====
loc_037FC154:
	ldr r12,[pool_037FC15C]	; 037FC154
	bx r12	; 037FC158
pool_037FC15C:
loc_037FC15C:
	.word P4_Entry_0230A3B4 + 1	; 037FC15C
.thumb

; ===== function loc_037FC160 =====
loc_037FC160:
	bx pc	; 037FC160
	.byte 0xC0, 0x46	; 037FC164
.arm

; ===== function loc_037FC164 =====
loc_037FC164:
	ldr r12,[pool_037FC16C]	; 037FC164
	bx r12	; 037FC168
pool_037FC16C:
loc_037FC16C:
	.word loc_02305D24 + 1	; 037FC16C
.thumb

; ===== function loc_037FC170 =====
loc_037FC170:
	bx pc	; 037FC170
	.byte 0xC0, 0x46	; 037FC174
.arm

; ===== function loc_037FC174 =====
loc_037FC174:
	ldr r12,[pool_037FC17C]	; 037FC174
	bx r12	; 037FC178
pool_037FC17C:
loc_037FC17C:
	.word loc_02305E90 + 1	; 037FC17C
.thumb

; ===== function loc_037FC180 =====
loc_037FC180:
	bx pc	; 037FC180
	.byte 0xC0, 0x46	; 037FC184
.arm

; ===== function loc_037FC184 =====
loc_037FC184:
	ldr r12,[pool_037FC18C]	; 037FC184
	bx r12	; 037FC188
pool_037FC18C:
loc_037FC18C:
	.word P4_Entry_02307810 + 1	; 037FC18C
.thumb

; ===== function loc_037FC190 =====
loc_037FC190:
	push {r4,lr}	; 037FC190
	ldr r0,[pool_037FC1EC]	; 037FC192
	ldr r1,[r0,#0x0]	; 037FC194
	ldr r0,[pool_037FC1F0]	; 037FC196
	add r4,r1,r0	; 037FC198
	bl loc_037FC218	; 037FC19A
	bl loc_037FC228	; 037FC19E
	mov r0,#0x20	; 037FC1A2
	bl loc_037FC268	; 037FC1A4
	mov r0,#0x0	; 037FC1A8
	add r1,r4,#0x0	; 037FC1AA
	add r1,#0xa4	; 037FC1AC
	strh r0,[r1,#0x0]	; 037FC1AE
	strh r0,[r4,#0x12]	; 037FC1B0
	ldr r1,[pool_037FC1F4]	; 037FC1B2
	strh r0,[r1,#0x0]	; 037FC1B4
	ldr r1,[pool_037FC1F8]	; 037FC1B6
	strh r0,[r1,#0x0]	; 037FC1B8
	ldr r1,[pool_037FC1FC]	; 037FC1BA
	strh r0,[r1,#0x0]	; 037FC1BC
	ldr r1,[pool_037FC200]	; 037FC1BE
	strh r0,[r1,#0x0]	; 037FC1C0
	ldr r1,[pool_037FC204]	; 037FC1C2
	strh r0,[r1,#0x0]	; 037FC1C4
	ldr r1,[pool_037FC208]	; 037FC1C6
	strh r0,[r1,#0x0]	; 037FC1C8
	ldrh r0,[r4,#0xc]	; 037FC1CA
	cmp r0,#0x1	; 037FC1CC
	bne loc_037FC1D4	; 037FC1CE
	bl loc_037FC238	; 037FC1D0
loc_037FC1D4:
	ldr r1,[pool_037FC20C]	; 037FC1D4
	ldr r0,[pool_037FC210]	; 037FC1D6
	strh r1,[r0,#0x0]	; 037FC1D8
	ldr r0,[pool_037FC214]	; 037FC1DA
	strh r1,[r0,#0x0]	; 037FC1DC
	bl loc_037FC248	; 037FC1DE
	bl loc_037FC258	; 037FC1E2
	pop {r4}	; 037FC1E6
	pop {r3}	; 037FC1E8
	bx r3	; 037FC1EA
pool_037FC1EC:
loc_037FC1EC:
	.word FirmwareWlWorkPointerSlot	; 037FC1EC
pool_037FC1F0:
loc_037FC1F0:
	.word 0x00000318	; 037FC1F0
pool_037FC1F4:
loc_037FC1F4:
	.word REG_WIFI_IE	; 037FC1F4
pool_037FC1F8:
loc_037FC1F8:
	.word REG_WIFI_MODE_RST	; 037FC1F8
pool_037FC1FC:
loc_037FC1FC:
	.word REG_WIFI_US_COMPARECNT	; 037FC1FC
pool_037FC200:
loc_037FC200:
	.word REG_WIFI_US_COUNTCNT	; 037FC200
pool_037FC204:
loc_037FC204:
	.word REG_WIFI_TXSTATCNT	; 037FC204
pool_037FC208:
loc_037FC208:
	.word REG_WIFI_UNKNOWN_00A	; 037FC208
pool_037FC20C:
loc_037FC20C:
	.word 0x0000FFFF	; 037FC20C
pool_037FC210:
loc_037FC210:
	.word REG_WIFI_TXREQ_RESET	; 037FC210
pool_037FC214:
loc_037FC214:
	.word REG_WIFI_TXBUF_RESET	; 037FC214

; ===== function loc_037FC218 =====
loc_037FC218:
	bx pc	; 037FC218
	.byte 0xC0, 0x46	; 037FC21C
.arm

; ===== function loc_037FC21C =====
loc_037FC21C:
	ldr r12,[pool_037FC224]	; 037FC21C
	bx r12	; 037FC220
pool_037FC224:
loc_037FC224:
	.word P4_Entry_02305468 + 1	; 037FC224
.thumb

; ===== function loc_037FC228 =====
loc_037FC228:
	bx pc	; 037FC228
	.byte 0xC0, 0x46	; 037FC22C
.arm

; ===== function loc_037FC22C =====
loc_037FC22C:
	ldr r12,[pool_037FC234]	; 037FC22C
	bx r12	; 037FC230
pool_037FC234:
loc_037FC234:
	.word loc_02305358 + 1	; 037FC234
.thumb

; ===== function loc_037FC238 =====
loc_037FC238:
	bx pc	; 037FC238
	.byte 0xC0, 0x46	; 037FC23C
.arm

; ===== function loc_037FC23C =====
loc_037FC23C:
	ldr r12,[pool_037FC244]	; 037FC23C
	bx r12	; 037FC240
pool_037FC244:
loc_037FC244:
	.word P4_Entry_0230A398 + 1	; 037FC244
.thumb

; ===== function loc_037FC248 =====
loc_037FC248:
	bx pc	; 037FC248
	.byte 0xC0, 0x46	; 037FC24C
.arm

; ===== function loc_037FC24C =====
loc_037FC24C:
	ldr r12,[pool_037FC254]	; 037FC24C
	bx r12	; 037FC250
pool_037FC254:
loc_037FC254:
	.word P4_Entry_0230A520 + 1	; 037FC254
.thumb

; ===== function loc_037FC258 =====
loc_037FC258:
	bx pc	; 037FC258
	.byte 0xC0, 0x46	; 037FC25C
.arm

; ===== function loc_037FC25C =====
loc_037FC25C:
	ldr r12,[pool_037FC264]	; 037FC25C
	bx r12	; 037FC260
pool_037FC264:
loc_037FC264:
	.word P4_Entry_02304C4C + 1	; 037FC264
.thumb

; ===== function loc_037FC268 =====
loc_037FC268:
	push {r4,r5,lr}	; 037FC268
	sub sp,#0x4	; 037FC26A
	add r5,r0,#0x0	; 037FC26C
	ldr r0,[pool_037FC2C4]	; 037FC26E
	ldr r1,[r0,#0x0]	; 037FC270
	ldr r0,[pool_037FC2C8]	; 037FC272
	add r4,r1,r0	; 037FC274
	ldrh r0,[r4,#0x8]	; 037FC276
	cmp r0,r5	; 037FC278
	beq loc_037FC2BC	; 037FC27A
	cmp r0,#0x40	; 037FC27C
	bne loc_037FC284	; 037FC27E
	bl loc_037FC228	; 037FC280
loc_037FC284:
	cmp r5,#0x0	; 037FC284
	beq loc_037FC292	; 037FC286
	cmp r5,#0x10	; 037FC288
	beq loc_037FC298	; 037FC28A
	cmp r5,#0x40	; 037FC28C
	beq loc_037FC2A8	; 037FC28E
	b loc_037FC2BA	; 037FC290
loc_037FC292:
	bl loc_037FC2D0	; 037FC292
	b loc_037FC2BA	; 037FC296
loc_037FC298:
	mov r0,#0x0	; 037FC298
	bl loc_037FC2E0	; 037FC29A
	bl loc_037FC190	; 037FC29E
	bl loc_037FC2F0	; 037FC2A2
	b loc_037FC2BA	; 037FC2A6
loc_037FC2A8:
	ldrh r0,[r4,#0xc]	; 037FC2A8
	cmp r0,#0x2	; 037FC2AA
	bne loc_037FC2B2	; 037FC2AC
	bl loc_037FC300	; 037FC2AE
loc_037FC2B2:
	mov r0,#0x64	; 037FC2B2
	ldr r1,[pool_037FC2CC]	; 037FC2B4
	bl loc_037FC310	; 037FC2B6
loc_037FC2BA:
	strh r5,[r4,#0x8]	; 037FC2BA
loc_037FC2BC:
	add sp,#0x4	; 037FC2BC
	pop {r4,r5}	; 037FC2BE
	pop {r3}	; 037FC2C0
	bx r3	; 037FC2C2
pool_037FC2C4:
loc_037FC2C4:
	.word FirmwareWlWorkPointerSlot	; 037FC2C4
pool_037FC2C8:
loc_037FC2C8:
	.word 0x00000318	; 037FC2C8
pool_037FC2CC:
loc_037FC2CC:
	.word 0x02305409	; 037FC2CC

; ===== function loc_037FC2D0 =====
loc_037FC2D0:
	bx pc	; 037FC2D0
	.byte 0xC0, 0x46	; 037FC2D4
.arm

; ===== function loc_037FC2D4 =====
loc_037FC2D4:
	ldr r12,[pool_037FC2DC]	; 037FC2D4
	bx r12	; 037FC2D8
pool_037FC2DC:
loc_037FC2DC:
	.word loc_02305E30 + 1	; 037FC2DC
.thumb

; ===== function loc_037FC2E0 =====
loc_037FC2E0:
	bx pc	; 037FC2E0
	.byte 0xC0, 0x46	; 037FC2E4
.arm

; ===== function loc_037FC2E4 =====
loc_037FC2E4:
	ldr r12,[pool_037FC2EC]	; 037FC2E4
	bx r12	; 037FC2E8
pool_037FC2EC:
loc_037FC2EC:
	.word loc_02305E84 + 1	; 037FC2EC
.thumb

; ===== function loc_037FC2F0 =====
loc_037FC2F0:
	bx pc	; 037FC2F0
	.byte 0xC0, 0x46	; 037FC2F4
.arm

; ===== function loc_037FC2F4 =====
loc_037FC2F4:
	ldr r12,[pool_037FC2FC]	; 037FC2F4
	bx r12	; 037FC2F8
pool_037FC2FC:
loc_037FC2FC:
	.word loc_02305DC8 + 1	; 037FC2FC
.thumb

; ===== function loc_037FC300 =====
loc_037FC300:
	bx pc	; 037FC300
	.byte 0xC0, 0x46	; 037FC304
.arm

; ===== function loc_037FC304 =====
loc_037FC304:
	ldr r12,[pool_037FC30C]	; 037FC304
	bx r12	; 037FC308
pool_037FC30C:
loc_037FC30C:
	.word loc_02305D00 + 1	; 037FC30C
.thumb

; ===== function loc_037FC310 =====
loc_037FC310:
	bx pc	; 037FC310
	.byte 0xC0, 0x46	; 037FC314
.arm

; ===== function loc_037FC314 =====
loc_037FC314:
	ldr r12,[pool_037FC31C]	; 037FC314
	bx r12	; 037FC318
pool_037FC31C:
loc_037FC31C:
	.word P4_Entry_02305480 + 1	; 037FC31C
.thumb
P2_IrqHandler_037FC320:
	push {r4,r5,r6,r7,lr}	; 037FC320
	sub sp,#0x4	; 037FC322
	mov r7,#0x1	; 037FC324
	ldr r4,[pool_037FC3F0]	; 037FC326
	ldr r6,[pool_037FC3F4]	; 037FC328
P2_Entry_037FC32A:
	ldrh r5,[r4,#0x0]	; 037FC32A
	ldrh r0,[r6,#0x0]	; 037FC32C
	and r5,r0	; 037FC32E
	cmp r5,#0x0	; 037FC330
	beq P2_Entry_037FC3DC	; 037FC332
	add r1,r5,#0x0	; 037FC334
	mov r0,#0x80	; 037FC336
	and r1,r0	; 037FC338
	cmp r1,#0x0	; 037FC33A
	beq P2_Entry_037FC342	; 037FC33C
	bl P2_Entry_037FCE4C	; 037FC33E
P2_Entry_037FC342:
	add r1,r5,#0x0	; 037FC342
	mov r0,#0x40	; 037FC344
	and r1,r0	; 037FC346
	cmp r1,#0x0	; 037FC348
	beq P2_Entry_037FC350	; 037FC34A
	bl P2_Entry_037FCECC	; 037FC34C
P2_Entry_037FC350:
	add r1,r5,#0x0	; 037FC350
	ldr r0,[pool_037FC3F8]	; 037FC352
	and r1,r0	; 037FC354
	cmp r1,#0x0	; 037FC356
	beq P2_Entry_037FC35E	; 037FC358
	bl P2_Entry_037FC424	; 037FC35A
P2_Entry_037FC35E:
	add r1,r5,#0x0	; 037FC35E
	ldr r0,[pool_037FC3FC]	; 037FC360
	and r1,r0	; 037FC362
	cmp r1,#0x0	; 037FC364
	beq P2_Entry_037FC36C	; 037FC366
	bl P2_Entry_037FC49C	; 037FC368
P2_Entry_037FC36C:
	add r1,r5,#0x0	; 037FC36C
	ldr r0,[pool_037FC400]	; 037FC36E
	and r1,r0	; 037FC370
	cmp r1,#0x0	; 037FC372
	beq P2_Entry_037FC37A	; 037FC374
	bl P2_Entry_037FC6E4	; 037FC376
P2_Entry_037FC37A:
	add r1,r5,#0x0	; 037FC37A
	ldr r0,[pool_037FC404]	; 037FC37C
	and r1,r0	; 037FC37E
	cmp r1,#0x0	; 037FC380
	beq P2_Entry_037FC388	; 037FC382
	bl P2_Entry_037FC414	; 037FC384
P2_Entry_037FC388:
	add r1,r5,#0x0	; 037FC388
	mov r0,#0x8	; 037FC38A
	and r1,r0	; 037FC38C
	cmp r1,#0x0	; 037FC38E
	beq P2_Entry_037FC396	; 037FC390
	bl P2_Entry_037FC774	; 037FC392
P2_Entry_037FC396:
	add r1,r5,#0x0	; 037FC396
	mov r0,#0x4	; 037FC398
	and r1,r0	; 037FC39A
	cmp r1,#0x0	; 037FC39C
	beq P2_Entry_037FC3A4	; 037FC39E
	bl P2_Entry_037FC850	; 037FC3A0
P2_Entry_037FC3A4:
	add r0,r5,#0x0	; 037FC3A4
	and r0,r7	; 037FC3A6
	cmp r0,#0x0	; 037FC3A8
	beq P2_Entry_037FC3B0	; 037FC3AA
	bl P2_Entry_037FCB98	; 037FC3AC
P2_Entry_037FC3B0:
	add r1,r5,#0x0	; 037FC3B0
	mov r0,#0x30	; 037FC3B2
	and r1,r0	; 037FC3B4
	cmp r1,#0x0	; 037FC3B6
	beq P2_Entry_037FC3BE	; 037FC3B8
	bl P2_Entry_037FC73C	; 037FC3BA
P2_Entry_037FC3BE:
	add r1,r5,#0x0	; 037FC3BE
	mov r0,#0x2	; 037FC3C0
	and r1,r0	; 037FC3C2
	cmp r1,#0x0	; 037FC3C4
	beq P2_Entry_037FC3CC	; 037FC3C6
	bl P2_Entry_037FC9C0	; 037FC3C8
P2_Entry_037FC3CC:
	ldr r0,[pool_037FC408]	; 037FC3CC
	and r5,r0	; 037FC3CE
	cmp r5,#0x0	; 037FC3D0
	beq P2_Entry_037FC32A	; 037FC3D2
	add r0,r7,#0x0	; 037FC3D4
	bl P2_Entry_037FCD8C	; 037FC3D6
	b P2_Entry_037FC32A	; 037FC3DA
P2_Entry_037FC3DC:
	ldr r2,[pool_037FC40C]	; 037FC3DC
	ldr r1,[r2,#0x0]	; 037FC3DE
	ldr r0,[pool_037FC410]	; 037FC3E0
	orr r1,r0	; 037FC3E2
	str r1,[r2,#0x0]	; 037FC3E4
	add sp,#0x4	; 037FC3E6
	pop {r4,r5,r6,r7}	; 037FC3E8
	pop {r3}	; 037FC3EA
	bx r3	; 037FC3EC
	.byte 0xC0, 0x46	; 037FC3EE
pool_037FC3F0:
	.word REG_WIFI_IF	; 037FC3F0
pool_037FC3F4:
	.word REG_WIFI_IE	; 037FC3F4
pool_037FC3F8:
	.word 0x00008000	; 037FC3F8
pool_037FC3FC:
	.word 0x00004000	; 037FC3FC
pool_037FC400:
	.word 0x00002000	; 037FC400
pool_037FC404:
	.word 0x00000800	; 037FC404
pool_037FC408:
	.word 0x00001000	; 037FC408
pool_037FC40C:
	.word Bios7IrqFlagsAddress	; 037FC40C
pool_037FC410:
	.word 0x01000000	; 037FC410
P2_Entry_037FC414:
	bx pc	; 037FC414
	.byte 0xC0, 0x46	; 037FC416
.arm
	ldr r12,[pool_037FC420]	; 037FC418
	bx r12	; 037FC41C
pool_037FC420:
	.word P4_Entry_02306E3C + 1	; 037FC420
P2_Entry_037FC424:
.thumb
	push {r4,lr}	; 037FC424
	ldr r0,[pool_037FC48C]	; 037FC426
	ldr r1,[r0,#0x0]	; 037FC428
	ldr r0,[pool_037FC490]	; 037FC42A
	add r4,r1,r0	; 037FC42C
	ldr r1,[pool_037FC494]	; 037FC42E
	ldr r0,[pool_037FC498]	; 037FC430
	strh r1,[r0,#0x0]	; 037FC432
	ldrh r0,[r4,#0x8]	; 037FC434
	cmp r0,#0x40	; 037FC436
	bne P2_Entry_037FC482	; 037FC438
	add r0,r4,#0x0	; 037FC43A
	add r0,#0x7e	; 037FC43C
	ldrh r0,[r0,#0x0]	; 037FC43E
	cmp r0,#0x0	; 037FC440
	beq P2_Entry_037FC482	; 037FC442
	add r0,r4,#0x0	; 037FC444
	add r0,#0x72	; 037FC446
	ldrh r1,[r0,#0x0]	; 037FC448
	add r0,r4,#0x0	; 037FC44A
	add r0,#0x70	; 037FC44C
	ldrh r0,[r0,#0x0]	; 037FC44E
	cmp r1,r0	; 037FC450
	bne P2_Entry_037FC482	; 037FC452
	add r0,r4,#0x0	; 037FC454
	add r0,#0x80	; 037FC456
	ldrh r0,[r0,#0x0]	; 037FC458
	add r1,r0,#0x1	; 037FC45A
	add r0,r4,#0x0	; 037FC45C
	add r0,#0x80	; 037FC45E
	strh r1,[r0,#0x0]	; 037FC460
	add r0,r4,#0x0	; 037FC462
	add r0,#0x80	; 037FC464
	ldrh r1,[r0,#0x0]	; 037FC466
	add r0,r4,#0x0	; 037FC468
	add r0,#0x7e	; 037FC46A
	ldrh r0,[r0,#0x0]	; 037FC46C
	cmp r1,r0	; 037FC46E
	bls P2_Entry_037FC482	; 037FC470
	mov r1,#0x0	; 037FC472
	add r0,r4,#0x0	; 037FC474
	add r0,#0x80	; 037FC476
	strh r1,[r0,#0x0]	; 037FC478
	mov r0,#0x1	; 037FC47A
	mov r1,#0xd	; 037FC47C
	bl loc_037FB7B4	; 037FC47E
P2_Entry_037FC482:
	mov r0,#0x1	; 037FC482
	strh r0,[r4,#0x10]	; 037FC484
	pop {r4}	; 037FC486
	pop {r3}	; 037FC488
	bx r3	; 037FC48A
pool_037FC48C:
	.word FirmwareWlWorkPointerSlot	; 037FC48C
pool_037FC490:
	.word 0x00000318	; 037FC490
pool_037FC494:
	.word 0x00008000	; 037FC494
pool_037FC498:
	.word REG_WIFI_IF	; 037FC498
P2_Entry_037FC49C:
	push {r4,r5,r6,r7,lr}	; 037FC49C
	sub sp,#0xc	; 037FC49E
	ldr r0,[pool_037FC690]	; 037FC4A0
	ldr r1,[r0,#0x0]	; 037FC4A2
	ldr r0,[pool_037FC694]	; 037FC4A4
	add r5,r1,r0	; 037FC4A6
	ldr r0,[pool_037FC698]	; 037FC4A8
	add r6,r1,r0	; 037FC4AA
	ldr r0,[pool_037FC69C]	; 037FC4AC
	add r4,r1,r0	; 037FC4AE
	ldr r1,[pool_037FC6A0]	; 037FC4B0
	ldr r0,[pool_037FC6A4]	; 037FC4B2
	strh r1,[r0,#0x0]	; 037FC4B4
	ldrh r0,[r5,#0xc]	; 037FC4B6
	cmp r0,#0x1	; 037FC4B8
	beq P2_Entry_037FC4C6	; 037FC4BA
	cmp r0,#0x2	; 037FC4BC
	beq P2_Entry_037FC558	; 037FC4BE
	cmp r0,#0x3	; 037FC4C0
	beq P2_Entry_037FC57E	; 037FC4C2
	b P2_Entry_037FC688	; 037FC4C4
P2_Entry_037FC4C6:
	add r0,r4,#0x0	; 037FC4C6
	add r0,#0x80	; 037FC4C8
	ldr r1,[r0,#0x0]	; 037FC4CA
	add r1,#0x24	; 037FC4CC
	add r0,r5,#0x0	; 037FC4CE
	add r0,#0x96	; 037FC4D0
	ldrh r0,[r0,#0x0]	; 037FC4D2
	add r7,r1,r0	; 037FC4D4
	add r7,#0x8	; 037FC4D6
	ldr r0,[pool_037FC6A8]	; 037FC4D8
	ldrh r0,[r0,#0x0]	; 037FC4DA
	str r0,[sp,#0x0]	; 037FC4DC
	add r0,r7,#0x0	; 037FC4DE
	ldr r1,[sp,#0x0]	; 037FC4E0
	lsl r1,r1,#0x18	; 037FC4E2
	lsr r1,r1,#0x18	; 037FC4E4
	bl P2_Entry_037FC6D4	; 037FC4E6
	add r0,r7,#0x1	; 037FC4EA
	ldr r1,[sp,#0x0]	; 037FC4EC
	lsr r1,r1,#0x8	; 037FC4EE
	lsl r1,r1,#0x18	; 037FC4F0
	lsr r1,r1,#0x18	; 037FC4F2
	bl P2_Entry_037FC6D4	; 037FC4F4
	ldrh r0,[r5,#0xe]	; 037FC4F8
	cmp r0,#0x1	; 037FC4FA
	bne P2_Entry_037FC50A	; 037FC4FC
	ldrh r2,[r6,#0x20]	; 037FC4FE
	ldr r1,[pool_037FC6AC]	; 037FC500
	ldrh r0,[r1,#0x0]	; 037FC502
	add r0,r2,r0	; 037FC504
	add r0,r0,#0x1	; 037FC506
	strh r0,[r1,#0x0]	; 037FC508
P2_Entry_037FC50A:
	ldr r0,[pool_037FC690]	; 037FC50A
	ldr r0,[r0,#0x0]	; 037FC50C
	ldr r1,[pool_037FC6B0]	; 037FC50E
	ldrh r1,[r0,r1]	; 037FC510
	mvn r2,r1	; 037FC512
	ldr r1,[pool_037FC6B4]	; 037FC514
	ldrh r1,[r0,r1]	; 037FC516
	orr r2,r1	; 037FC518
	ldr r1,[pool_037FC6B8]	; 037FC51A
	strh r2,[r0,r1]	; 037FC51C
	ldr r0,[pool_037FC6BC]	; 037FC51E
	ldrh r2,[r0,#0x0]	; 037FC520
	mov r0,#0x18	; 037FC522
	add r1,r2,#0x0	; 037FC524
	and r1,r0	; 037FC526
	cmp r1,#0x0	; 037FC528
	bne P2_Entry_037FC534	; 037FC52A
	mov r0,#0x6	; 037FC52C
	and r2,r0	; 037FC52E
	cmp r2,#0x2	; 037FC530
	bne P2_Entry_037FC548	; 037FC532
P2_Entry_037FC534:
	add r0,r4,#0x0	; 037FC534
	add r0,#0x8c	; 037FC536
	ldr r1,[r0,#0x0]	; 037FC538
	mov r0,#0x2	; 037FC53A
	bic r1,r0	; 037FC53C
	add r4,#0x8c	; 037FC53E
	str r1,[r4,#0x0]	; 037FC540
	bl P2_Entry_037FD0B0	; 037FC542
	b P2_Entry_037FC688	; 037FC546
P2_Entry_037FC548:
	add r0,r4,#0x0	; 037FC548
	add r0,#0x8c	; 037FC54A
	ldr r1,[r0,#0x0]	; 037FC54C
	mov r0,#0x2	; 037FC54E
	orr r1,r0	; 037FC550
	add r4,#0x8c	; 037FC552
	str r1,[r4,#0x0]	; 037FC554
	b P2_Entry_037FC688	; 037FC556
P2_Entry_037FC558:
	ldrh r0,[r5,#0x12]	; 037FC558
	cmp r0,#0x0	; 037FC55A
	beq P2_Entry_037FC56C	; 037FC55C
	ldrh r2,[r6,#0x20]	; 037FC55E
	ldr r1,[pool_037FC6AC]	; 037FC560
	ldrh r0,[r1,#0x0]	; 037FC562
	add r0,r2,r0	; 037FC564
	add r0,r0,#0x1	; 037FC566
	strh r0,[r1,#0x0]	; 037FC568
	b P2_Entry_037FC572	; 037FC56A
P2_Entry_037FC56C:
	ldr r1,[pool_037FC6C0]	; 037FC56C
	ldr r0,[pool_037FC6AC]	; 037FC56E
	strh r1,[r0,#0x0]	; 037FC570
P2_Entry_037FC572:
	ldrh r0,[r5,#0x1a]	; 037FC572
	cmp r0,#0x2	; 037FC574
	bne P2_Entry_037FC57E	; 037FC576
	mov r0,#0x2	; 037FC578
	bl loc_037FC170	; 037FC57A
P2_Entry_037FC57E:
	ldrh r0,[r5,#0x8]	; 037FC57E
	cmp r0,#0x40	; 037FC580
	beq P2_Entry_037FC588	; 037FC582
	mov r0,#0x1	; 037FC584
	b P2_Entry_037FC5B6	; 037FC586
P2_Entry_037FC588:
	mov r0,#0x0	; 037FC588
	add r1,r5,#0x0	; 037FC58A
	add r1,#0x72	; 037FC58C
	ldrh r1,[r1,#0x0]	; 037FC58E
	cmp r1,#0x1	; 037FC590
	bne P2_Entry_037FC596	; 037FC592
	mov r0,#0x1	; 037FC594
P2_Entry_037FC596:
	ldrh r1,[r5,#0x14]	; 037FC596
	cmp r1,#0x0	; 037FC598
	beq P2_Entry_037FC5B6	; 037FC59A
	add r1,r5,#0x0	; 037FC59C
	add r1,#0x76	; 037FC59E
	ldrh r1,[r1,#0x0]	; 037FC5A0
	cmp r1,#0x1	; 037FC5A2
	beq P2_Entry_037FC5B4	; 037FC5A4
	cmp r1,#0x0	; 037FC5A6
	bne P2_Entry_037FC5B6	; 037FC5A8
	add r1,r5,#0x0	; 037FC5AA
	add r1,#0x74	; 037FC5AC
	ldrh r1,[r1,#0x0]	; 037FC5AE
	cmp r1,#0x1	; 037FC5B0
	bne P2_Entry_037FC5B6	; 037FC5B2
P2_Entry_037FC5B4:
	mov r0,#0x1	; 037FC5B4
P2_Entry_037FC5B6:
	cmp r0,#0x0	; 037FC5B6
	beq P2_Entry_037FC5C6	; 037FC5B8
	ldr r2,[pool_037FC6C4]	; 037FC5BA
	ldrh r1,[r2,#0x0]	; 037FC5BC
	mov r0,#0x1	; 037FC5BE
	orr r1,r0	; 037FC5C0
	strh r1,[r2,#0x0]	; 037FC5C2
	b P2_Entry_037FC5D0	; 037FC5C4
P2_Entry_037FC5C6:
	ldr r2,[pool_037FC6C4]	; 037FC5C6
	ldrh r1,[r2,#0x0]	; 037FC5C8
	mov r0,#0x1	; 037FC5CA
	bic r1,r0	; 037FC5CC
	strh r1,[r2,#0x0]	; 037FC5CE
P2_Entry_037FC5D0:
	ldr r0,[pool_037FC6C8]	; 037FC5D0
	ldrh r0,[r0,#0x0]	; 037FC5D2
	cmp r0,#0xa	; 037FC5D4
	bls P2_Entry_037FC5DE	; 037FC5D6
	mov r1,#0x0	; 037FC5D8
	ldr r0,[pool_037FC6CC]	; 037FC5DA
	strh r1,[r0,#0x0]	; 037FC5DC
P2_Entry_037FC5DE:
	add r0,r5,#0x0	; 037FC5DE
	add r0,#0x72	; 037FC5E0
	ldrh r0,[r0,#0x0]	; 037FC5E2
	sub r1,r0,#0x1	; 037FC5E4
	add r0,r5,#0x0	; 037FC5E6
	add r0,#0x72	; 037FC5E8
	strh r1,[r0,#0x0]	; 037FC5EA
	add r0,r5,#0x0	; 037FC5EC
	add r0,#0x72	; 037FC5EE
	ldrh r0,[r0,#0x0]	; 037FC5F0
	cmp r0,#0x0	; 037FC5F2
	bne P2_Entry_037FC602	; 037FC5F4
	add r0,r5,#0x0	; 037FC5F6
	add r0,#0x70	; 037FC5F8
	ldrh r1,[r0,#0x0]	; 037FC5FA
	add r0,r5,#0x0	; 037FC5FC
	add r0,#0x72	; 037FC5FE
	strh r1,[r0,#0x0]	; 037FC600
P2_Entry_037FC602:
	add r0,r5,#0x0	; 037FC602
	add r0,#0x76	; 037FC604
	ldrh r2,[r0,#0x0]	; 037FC606
	add r0,r5,#0x0	; 037FC608
	add r0,#0x76	; 037FC60A
	ldrh r0,[r0,#0x0]	; 037FC60C
	sub r1,r0,#0x1	; 037FC60E
	add r0,r5,#0x0	; 037FC610
	add r0,#0x76	; 037FC612
	strh r1,[r0,#0x0]	; 037FC614
	cmp r2,#0x0	; 037FC616
	bne P2_Entry_037FC628	; 037FC618
	add r0,r5,#0x0	; 037FC61A
	add r0,#0x74	; 037FC61C
	ldrh r0,[r0,#0x0]	; 037FC61E
	sub r1,r0,#0x1	; 037FC620
	add r0,r5,#0x0	; 037FC622
	add r0,#0x76	; 037FC624
	strh r1,[r0,#0x0]	; 037FC626
P2_Entry_037FC628:
	mov r6,#0x0	; 037FC628
	str r6,[sp,#0x4]	; 037FC62A
P2_Entry_037FC62C:
	add r1,r6,#0x0	; 037FC62C
	mov r0,#0x14	; 037FC62E
	mul r1,r0	; 037FC630
	add r7,r4,r1	; 037FC632
	ldrh r0,[r4,r1]	; 037FC634
	cmp r0,#0x0	; 037FC636
	beq P2_Entry_037FC67C	; 037FC638
	ldr r0,[r7,#0xc]	; 037FC63A
	ldrh r1,[r0,#0x8]	; 037FC63C
	cmp r1,#0x0	; 037FC63E
	bne P2_Entry_037FC67C	; 037FC640
	add r1,r5,#0x0	; 037FC642
	add r1,#0xa8	; 037FC644
	ldr r1,[r1,#0x0]	; 037FC646
	ldrh r0,[r0,#0x4]	; 037FC648
	sub r0,r1,r0	; 037FC64A
	lsl r0,r0,#0x10	; 037FC64C
	lsr r1,r0,#0x10	; 037FC64E
	add r0,r5,#0x0	; 037FC650
	add r0,#0x8c	; 037FC652
	ldrh r0,[r0,#0x0]	; 037FC654
	cmp r1,r0	; 037FC656
	bls P2_Entry_037FC67C	; 037FC658
	add r0,r6,#0x0	; 037FC65A
	bl P2_Entry_037FD110	; 037FC65C
	ldr r1,[r7,#0x8]	; 037FC660
	mov r0,#0x2	; 037FC662
	strh r0,[r1,#0x0]	; 037FC664
	ldr r0,[sp,#0x4]	; 037FC666
	mov r1,#0xe	; 037FC668
	bl loc_037FB7B4	; 037FC66A
	add r0,r4,#0x0	; 037FC66E
	add r0,#0xb0	; 037FC670
	ldrh r0,[r0,#0x0]	; 037FC672
	add r1,r0,#0x1	; 037FC674
	add r0,r4,#0x0	; 037FC676
	add r0,#0xb0	; 037FC678
	strh r1,[r0,#0x0]	; 037FC67A
P2_Entry_037FC67C:
	add r6,r6,#0x1	; 037FC67C
	cmp r6,#0x2	; 037FC67E
	bcc P2_Entry_037FC62C	; 037FC680
	mov r1,#0xd	; 037FC682
	ldr r0,[pool_037FC6D0]	; 037FC684
	strh r1,[r0,#0x0]	; 037FC686
P2_Entry_037FC688:
	add sp,#0xc	; 037FC688
	pop {r4,r5,r6,r7}	; 037FC68A
	pop {r3}	; 037FC68C
	bx r3	; 037FC68E
pool_037FC690:
	.word FirmwareWlWorkPointerSlot	; 037FC690
pool_037FC694:
	.word 0x00000318	; 037FC694
pool_037FC698:
	.word 0x000002F0	; 037FC698
pool_037FC69C:
	.word 0x00000400	; 037FC69C
pool_037FC6A0:
	.word 0x00004000	; 037FC6A0
pool_037FC6A4:
	.word REG_WIFI_IF	; 037FC6A4
pool_037FC6A8:
	.word FirmwareWlAdjustedTimeSlot	; 037FC6A8
pool_037FC6AC:
	.word REG_WIFI_POST_BEACON	; 037FC6AC
pool_037FC6B0:
	.word 0x00000506	; 037FC6B0
pool_037FC6B4:
	.word 0x0000050A	; 037FC6B4
pool_037FC6B8:
	.word 0x00000508	; 037FC6B8
pool_037FC6BC:
	.word REG_WIFI_TXBUSY	; 037FC6BC
pool_037FC6C0:
	.word 0x0000FFFF	; 037FC6C0
pool_037FC6C4:
	.word REG_WIFI_POWER_TX	; 037FC6C4
pool_037FC6C8:
	.word REG_WIFI_CMD_COUNT	; 037FC6C8
pool_037FC6CC:
	.word REG_WIFI_UNKNOWN_048	; 037FC6CC
pool_037FC6D0:
	.word REG_WIFI_TXREQ_SET	; 037FC6D0
P2_Entry_037FC6D4:
	bx pc	; 037FC6D4
	.byte 0xC0, 0x46	; 037FC6D6
.arm
	ldr r12,[pool_037FC6E0]	; 037FC6D8
	bx r12	; 037FC6DC
pool_037FC6E0:
	.word loc_023051A4 + 1	; 037FC6E0
P2_Entry_037FC6E4:
.thumb
	ldr r0,[pool_037FC724]	; 037FC6E4
	ldr r1,[r0,#0x0]	; 037FC6E6
	ldr r0,[pool_037FC728]	; 037FC6E8
	add r0,r1,r0	; 037FC6EA
	ldr r2,[pool_037FC72C]	; 037FC6EC
	ldr r1,[pool_037FC730]	; 037FC6EE
	strh r2,[r1,#0x0]	; 037FC6F0
	mov r2,#0xd	; 037FC6F2
	ldr r1,[pool_037FC734]	; 037FC6F4
	strh r2,[r1,#0x0]	; 037FC6F6
	ldrh r1,[r0,#0x1a]	; 037FC6F8
	cmp r1,#0x1	; 037FC6FA
	bne P2_Entry_037FC704	; 037FC6FC
	mov r1,#0x2	; 037FC6FE
	strh r1,[r0,#0x1a]	; 037FC700
	bx lr	; 037FC702
P2_Entry_037FC704:
	cmp r1,#0x2	; 037FC704
	bne P2_Entry_037FC70E	; 037FC706
	mov r1,#0x0	; 037FC708
	strh r1,[r0,#0x1a]	; 037FC70A
	bx lr	; 037FC70C
P2_Entry_037FC70E:
	ldrh r1,[r0,#0xc]	; 037FC70E
	cmp r1,#0x2	; 037FC710
	bne P2_Entry_037FC720	; 037FC712
	ldrh r0,[r0,#0x8]	; 037FC714
	cmp r0,#0x40	; 037FC716
	beq P2_Entry_037FC720	; 037FC718
	mov r1,#0x0	; 037FC71A
	ldr r0,[pool_037FC738]	; 037FC71C
	strh r1,[r0,#0x0]	; 037FC71E
P2_Entry_037FC720:
	bx lr	; 037FC720
	.byte 0xC0, 0x46	; 037FC722
pool_037FC724:
	.word FirmwareWlWorkPointerSlot	; 037FC724
pool_037FC728:
	.word 0x00000318	; 037FC728
pool_037FC72C:
	.word 0x00002000	; 037FC72C
pool_037FC730:
	.word REG_WIFI_IF	; 037FC730
pool_037FC734:
	.word REG_WIFI_TXREQ_RESET	; 037FC734
pool_037FC738:
	.word REG_WIFI_UNKNOWN_048	; 037FC738
P2_Entry_037FC73C:
	push {lr}	; 037FC73C
	sub sp,#0x4	; 037FC73E
	bl P2_Entry_037FC764	; 037FC740
	ldr r1,[pool_037FC758]	; 037FC744
	ldr r0,[pool_037FC75C]	; 037FC746
	strh r1,[r0,#0x0]	; 037FC748
	mov r1,#0x30	; 037FC74A
	ldr r0,[pool_037FC760]	; 037FC74C
	strh r1,[r0,#0x0]	; 037FC74E
	add sp,#0x4	; 037FC750
	pop {r3}	; 037FC752
	bx r3	; 037FC754
	.byte 0xC0, 0x46	; 037FC756
pool_037FC758:
	.word 0x0000FFFF	; 037FC758
pool_037FC75C:
	.word REG_WIFI_RXSTAT_OVF_IF	; 037FC75C
pool_037FC760:
	.word REG_WIFI_IF	; 037FC760
P2_Entry_037FC764:
	bx pc	; 037FC764
	.byte 0xC0, 0x46	; 037FC766
.arm
	ldr r12,[pool_037FC770]	; 037FC768
	bx r12	; 037FC76C
pool_037FC770:
	.word P4_Entry_02305958 + 1	; 037FC770
P2_Entry_037FC774:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC774
	sub sp,#0x4	; 037FC776
	mov r1,#0x8	; 037FC778
	ldr r0,[pool_037FC824]	; 037FC77A
	strh r1,[r0,#0x0]	; 037FC77C
	ldr r0,[pool_037FC828]	; 037FC77E
	ldr r1,[r0,#0x0]	; 037FC780
	ldr r0,[pool_037FC82C]	; 037FC782
	ldrh r0,[r1,r0]	; 037FC784
	lsl r0,r0,#0x1b	; 037FC786
	lsr r0,r0,#0x1f	; 037FC788
	cmp r0,#0x0	; 037FC78A
	beq P2_Entry_037FC7A2	; 037FC78C
	ldr r0,[pool_037FC830]	; 037FC78E
	ldrh r1,[r0,#0x0]	; 037FC790
	mov r0,#0x1	; 037FC792
	and r1,r0	; 037FC794
	cmp r1,#0x0	; 037FC796
	bne P2_Entry_037FC7A2	; 037FC798
	ldr r2,[pool_037FC834]	; 037FC79A
	ldrh r1,[r2,#0x0]	; 037FC79C
	eor r1,r0	; 037FC79E
	strh r1,[r2,#0x0]	; 037FC7A0
P2_Entry_037FC7A2:
	ldr r0,[pool_037FC828]	; 037FC7A2
	ldr r2,[r0,#0x0]	; 037FC7A4
	ldr r0,[pool_037FC838]	; 037FC7A6
	ldrh r1,[r2,r0]	; 037FC7A8
	mov r0,#0x8	; 037FC7AA
	and r1,r0	; 037FC7AC
	cmp r1,#0x0	; 037FC7AE
	beq P2_Entry_037FC81A	; 037FC7B0
	ldr r0,[pool_037FC83C]	; 037FC7B2
	add r5,r2,r0	; 037FC7B4
	ldr r0,[pool_037FC840]	; 037FC7B6
	add r4,r2,r0	; 037FC7B8
	mov r6,#0x0	; 037FC7BA
	add r1,r6,#0x0	; 037FC7BC
	ldr r0,[pool_037FC844]	; 037FC7BE
P2_Entry_037FC7C0:
	add r3,r6,#0x0	; 037FC7C0
	mov r2,#0x14	; 037FC7C2
	mul r3,r2	; 037FC7C4
	add r7,r4,r3	; 037FC7C6
	ldrh r2,[r4,r3]	; 037FC7C8
	cmp r2,#0x0	; 037FC7CA
	beq P2_Entry_037FC814	; 037FC7CC
	ldr r3,[r7,#0x8]	; 037FC7CE
	ldrh r7,[r3,#0xc]	; 037FC7D0
	ldr r2,[pool_037FC848]	; 037FC7D2
	and r7,r2	; 037FC7D4
	cmp r7,#0x0	; 037FC7D6
	beq P2_Entry_037FC814	; 037FC7D8
	ldrh r7,[r3,#0x4]	; 037FC7DA
	mov r2,#0xff	; 037FC7DC
	and r7,r2	; 037FC7DE
	cmp r7,#0x0	; 037FC7E0
	beq P2_Entry_037FC814	; 037FC7E2
	add r7,r3,#0x0	; 037FC7E4
	add r7,#0xc	; 037FC7E6
	ldrh r2,[r3,#0xa]	; 037FC7E8
	add r2,r7,r2	; 037FC7EA
	sub r2,r2,#0x7	; 037FC7EC
	mov r7,#0x1	; 037FC7EE
	bic r2,r7	; 037FC7F0
	ldrh r7,[r2,#0x0]	; 037FC7F2
	cmp r7,#0x0	; 037FC7F4
	bne P2_Entry_037FC814	; 037FC7F6
	ldrh r2,[r2,#0x2]	; 037FC7F8
	cmp r2,#0x0	; 037FC7FA
	bne P2_Entry_037FC814	; 037FC7FC
	strh r1,[r3,#0x4]	; 037FC7FE
	strh r1,[r0,#0x0]	; 037FC800
	ldr r2,[pool_037FC84C]	; 037FC802
	strh r2,[r0,#0x0]	; 037FC804
	add r2,r5,#0x0	; 037FC806
	add r2,#0xba	; 037FC808
	ldrh r2,[r2,#0x0]	; 037FC80A
	add r3,r2,#0x1	; 037FC80C
	add r2,r5,#0x0	; 037FC80E
	add r2,#0xba	; 037FC810
	strh r3,[r2,#0x0]	; 037FC812
P2_Entry_037FC814:
	add r6,r6,#0x1	; 037FC814
	cmp r6,#0x3	; 037FC816
	bcc P2_Entry_037FC7C0	; 037FC818
P2_Entry_037FC81A:
	add sp,#0x4	; 037FC81A
	pop {r4,r5,r6,r7}	; 037FC81C
	pop {r3}	; 037FC81E
	bx r3	; 037FC820
	.byte 0xC0, 0x46	; 037FC822
pool_037FC824:
	.word REG_WIFI_IF	; 037FC824
pool_037FC828:
	.word FirmwareWlWorkPointerSlot	; 037FC828
pool_037FC82C:
	.word 0x0000030E	; 037FC82C
pool_037FC830:
	.word REG_WIFI_RF_PINS	; 037FC830
pool_037FC834:
	.word REG_WIFI_UNKNOWN_290	; 037FC834
pool_037FC838:
	.word 0x00000638	; 037FC838
pool_037FC83C:
	.word 0x00000318	; 037FC83C
pool_037FC840:
	.word 0x00000400	; 037FC840
pool_037FC844:
	.word 0x04808032	; 037FC844
pool_037FC848:
	.word 0x00004000	; 037FC848
pool_037FC84C:
	.word 0x00008000	; 037FC84C
P2_Entry_037FC850:
	push {r4,r5,lr}	; 037FC850
	sub sp,#0x4	; 037FC852
	ldr r0,[pool_037FC94C]	; 037FC854
	ldr r2,[r0,#0x0]	; 037FC856
	ldr r1,[pool_037FC950]	; 037FC858
	add r3,r2,r1	; 037FC85A
	ldr r4,[pool_037FC954]	; 037FC85C
	add r2,r2,r4	; 037FC85E
	mov r5,#0x4	; 037FC860
	ldr r1,[pool_037FC958]	; 037FC862
	strh r5,[r1,#0x0]	; 037FC864
	ldr r1,[pool_037FC95C]	; 037FC866
	ldrh r1,[r1,#0x0]	; 037FC868
	ldr r5,[r0,#0x0]	; 037FC86A
	ldr r0,[pool_037FC960]	; 037FC86C
	ldrh r5,[r5,r0]	; 037FC86E
	mov r0,#0x8	; 037FC870
	and r5,r0	; 037FC872
	cmp r5,#0x0	; 037FC874
	beq P2_Entry_037FC8F0	; 037FC876
	add r0,r1,#0x0	; 037FC878
	and r0,r4	; 037FC87A
	cmp r0,#0x0	; 037FC87C
	beq P2_Entry_037FC8F0	; 037FC87E
	ldr r0,[pool_037FC964]	; 037FC880
	ldrh r0,[r0,#0x0]	; 037FC882
	mov r4,#0x1	; 037FC884
	add r5,r0,#0x0	; 037FC886
	and r5,r4	; 037FC888
	cmp r5,#0x0	; 037FC88A
	beq P2_Entry_037FC894	; 037FC88C
	ldrh r4,[r2,#0x0]	; 037FC88E
	cmp r4,#0x0	; 037FC890
	bne P2_Entry_037FC8CC	; 037FC892
P2_Entry_037FC894:
	mov r4,#0x4	; 037FC894
	add r5,r0,#0x0	; 037FC896
	and r5,r4	; 037FC898
	cmp r5,#0x0	; 037FC89A
	beq P2_Entry_037FC8A4	; 037FC89C
	ldrh r4,[r2,#0x14]	; 037FC89E
	cmp r4,#0x0	; 037FC8A0
	bne P2_Entry_037FC8CC	; 037FC8A2
P2_Entry_037FC8A4:
	mov r4,#0x8	; 037FC8A4
	and r0,r4	; 037FC8A6
	cmp r0,#0x0	; 037FC8A8
	beq P2_Entry_037FC8B2	; 037FC8AA
	ldrh r0,[r2,#0x28]	; 037FC8AC
	cmp r0,#0x0	; 037FC8AE
	bne P2_Entry_037FC8CC	; 037FC8B0
P2_Entry_037FC8B2:
	ldr r0,[pool_037FC968]	; 037FC8B2
	ldrh r2,[r0,#0x0]	; 037FC8B4
	mov r0,#0x1	; 037FC8B6
	and r2,r0	; 037FC8B8
	cmp r2,#0x0	; 037FC8BA
	bne P2_Entry_037FC8CC	; 037FC8BC
	mov r4,#0x0	; 037FC8BE
	ldr r2,[pool_037FC96C]	; 037FC8C0
	strh r4,[r2,#0x0]	; 037FC8C2
	ldr r0,[pool_037FC970]	; 037FC8C4
	strh r0,[r2,#0x0]	; 037FC8C6
	strh r4,[r3,#0x2]	; 037FC8C8
	b P2_Entry_037FC8F0	; 037FC8CA
P2_Entry_037FC8CC:
	ldrh r2,[r3,#0x2]	; 037FC8CC
	add r0,r2,#0x1	; 037FC8CE
	strh r0,[r3,#0x2]	; 037FC8D0
	cmp r2,#0xc	; 037FC8D2
	bls P2_Entry_037FC8F0	; 037FC8D4
	mov r0,#0x0	; 037FC8D6
	strh r0,[r3,#0x2]	; 037FC8D8
	ldr r2,[pool_037FC96C]	; 037FC8DA
	strh r0,[r2,#0x0]	; 037FC8DC
	ldr r0,[pool_037FC970]	; 037FC8DE
	strh r0,[r2,#0x0]	; 037FC8E0
	ldr r0,[pool_037FC94C]	; 037FC8E2
	ldr r2,[r0,#0x0]	; 037FC8E4
	ldr r0,[pool_037FC974]	; 037FC8E6
	add r0,r2,r0	; 037FC8E8
	ldrh r2,[r0,#0x0]	; 037FC8EA
	add r2,r2,#0x1	; 037FC8EC
	strh r2,[r0,#0x0]	; 037FC8EE
P2_Entry_037FC8F0:
	ldr r0,[pool_037FC94C]	; 037FC8F0
	ldr r2,[r0,#0x0]	; 037FC8F2
	ldr r0,[pool_037FC960]	; 037FC8F4
	ldrh r2,[r2,r0]	; 037FC8F6
	mov r0,#0x1	; 037FC8F8
	and r2,r0	; 037FC8FA
	cmp r2,#0x0	; 037FC8FC
	beq P2_Entry_037FC942	; 037FC8FE
	mov r0,#0x60	; 037FC900
	and r1,r0	; 037FC902
	cmp r1,#0x0	; 037FC904
	beq P2_Entry_037FC942	; 037FC906
	ldr r0,[pool_037FC978]	; 037FC908
	ldrh r4,[r0,#0x0]	; 037FC90A
	ldr r0,[pool_037FC97C]	; 037FC90C
	ldrh r1,[r0,#0x0]	; 037FC90E
	ldr r0,[pool_037FC980]	; 037FC910
	sub r0,r1,r0	; 037FC912
	mov r1,#0x2	; 037FC914
	bl P2_Entry_037FC998	; 037FC916
	cmp r4,r0	; 037FC91A
	bge P2_Entry_037FC930	; 037FC91C
	ldr r0,[pool_037FC984]	; 037FC91E
	ldrh r1,[r0,#0x0]	; 037FC920
	ldr r0,[pool_037FC980]	; 037FC922
	sub r0,r1,r0	; 037FC924
	mov r1,#0x2	; 037FC926
	bl P2_Entry_037FC9A4	; 037FC928
	cmp r4,r0	; 037FC92C
	bge P2_Entry_037FC93E	; 037FC92E
P2_Entry_037FC930:
	ldr r0,[pool_037FC988]	; 037FC930
	ldrh r1,[r0,#0x0]	; 037FC932
	ldr r0,[pool_037FC98C]	; 037FC934
	strh r1,[r0,#0x0]	; 037FC936
	ldr r1,[pool_037FC990]	; 037FC938
	ldr r0,[pool_037FC994]	; 037FC93A
	strh r1,[r0,#0x0]	; 037FC93C
P2_Entry_037FC93E:
	bl P2_Entry_037FC9B0	; 037FC93E
P2_Entry_037FC942:
	add sp,#0x4	; 037FC942
	pop {r4,r5}	; 037FC944
	pop {r3}	; 037FC946
	bx r3	; 037FC948
	.byte 0xC0, 0x46	; 037FC94A
pool_037FC94C:
	.word FirmwareWlWorkPointerSlot	; 037FC94C
pool_037FC950:
	.word 0x000004B4	; 037FC950
pool_037FC954:
	.word 0x00000400	; 037FC954
pool_037FC958:
	.word REG_WIFI_IF	; 037FC958
pool_037FC95C:
	.word REG_WIFI_RXSTAT_INC_IF	; 037FC95C
pool_037FC960:
	.word 0x00000638	; 037FC960
pool_037FC964:
	.word REG_WIFI_TXREQ_READ	; 037FC964
pool_037FC968:
	.word REG_WIFI_RF_PINS	; 037FC968
pool_037FC96C:
	.word REG_WIFI_WEP_CNT	; 037FC96C
pool_037FC970:
	.word 0x00008000	; 037FC970
pool_037FC974:
	.word 0x000003D2	; 037FC974
pool_037FC978:
	.word REG_WIFI_RXBUF_WRCSR	; 037FC978
pool_037FC97C:
	.word REG_WIFI_RXBUF_END	; 037FC97C
pool_037FC980:
	.word 0x00004000	; 037FC980
pool_037FC984:
	.word REG_WIFI_RXBUF_BEGIN	; 037FC984
pool_037FC988:
	.word REG_WIFI_RXBUF_READCSR	; 037FC988
pool_037FC98C:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FC98C
pool_037FC990:
	.word 0x00008001	; 037FC990
pool_037FC994:
	.word REG_WIFI_RXCNT	; 037FC994
P2_Entry_037FC998:
	bx pc	; 037FC998
	.byte 0xC0, 0x46	; 037FC99A
.arm
	ldr pc,[pool_037FC9A0]	; 037FC99C
pool_037FC9A0:
	.word P2_SignedDivMod	; 037FC9A0
P2_Entry_037FC9A4:
.thumb
	bx pc	; 037FC9A4
	.byte 0xC0, 0x46	; 037FC9A6
.arm
	ldr pc,[pool_037FC9AC]	; 037FC9A8
pool_037FC9AC:
	.word P2_SignedDivMod	; 037FC9AC
P2_Entry_037FC9B0:
.thumb
	bx pc	; 037FC9B0
	.byte 0xC0, 0x46	; 037FC9B2
.arm
	ldr r12,[pool_037FC9BC]	; 037FC9B4
	bx r12	; 037FC9B8
pool_037FC9BC:
	.word P4_Entry_02304F50 + 1	; 037FC9BC
P2_Entry_037FC9C0:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FC9C0
	sub sp,#0x4	; 037FC9C2
	ldr r2,[pool_037FCB38]	; 037FC9C4
	ldr r1,[r2,#0x0]	; 037FC9C6
	ldr r0,[pool_037FCB3C]	; 037FC9C8
	add r5,r1,r0	; 037FC9CA
	mov r1,#0x2	; 037FC9CC
	ldr r0,[pool_037FCB40]	; 037FC9CE
	strh r1,[r0,#0x0]	; 037FC9D0
	ldr r0,[r2,#0x0]	; 037FC9D2
	ldr r2,[pool_037FCB44]	; 037FC9D4
	ldrh r2,[r0,r2]	; 037FC9D6
	cmp r2,#0x12	; 037FC9D8
	bne P2_Entry_037FC9E2	; 037FC9DA
	bl P2_Entry_037FCB88	; 037FC9DC
	b P2_Entry_037FCB2E	; 037FC9E0
P2_Entry_037FC9E2:
	ldr r2,[pool_037FCB48]	; 037FC9E2
	ldrh r4,[r2,#0x0]	; 037FC9E4
	ldr r2,[pool_037FCB4C]	; 037FC9E6
	and r4,r2	; 037FC9E8
	ldr r2,[pool_037FCB50]	; 037FC9EA
	cmp r4,r2	; 037FC9EC
	beq P2_Entry_037FC9FE	; 037FC9EE
	ldr r2,[pool_037FCB54]	; 037FC9F0
	cmp r4,r2	; 037FC9F2
	beq P2_Entry_037FCA26	; 037FC9F4
	ldr r1,[pool_037FCB58]	; 037FC9F6
	cmp r4,r1	; 037FC9F8
	beq P2_Entry_037FCA5C	; 037FC9FA
	b P2_Entry_037FCAD2	; 037FC9FC
P2_Entry_037FC9FE:
	add r0,r5,#0x0	; 037FC9FE
	add r0,#0x8c	; 037FCA00
	ldr r0,[r0,#0x0]	; 037FCA02
	and r0,r1	; 037FCA04
	cmp r0,#0x0	; 037FCA06
	beq P2_Entry_037FCA0E	; 037FCA08
	bl P2_Entry_037FD0B0	; 037FCA0A
P2_Entry_037FCA0E:
	ldr r0,[pool_037FCB38]	; 037FCA0E
	ldr r1,[r0,#0x0]	; 037FCA10
	ldr r0,[pool_037FCB5C]	; 037FCA12
	add r0,r1,r0	; 037FCA14
	ldr r1,[r0,#0x0]	; 037FCA16
	add r1,r1,#0x1	; 037FCA18
	str r1,[r0,#0x0]	; 037FCA1A
	mov r0,#0x0	; 037FCA1C
	mov r1,#0x8	; 037FCA1E
	bl loc_037FB7B4	; 037FCA20
	b P2_Entry_037FCAD2	; 037FCA24
P2_Entry_037FCA26:
	add r0,r5,#0x0	; 037FCA26
	add r0,#0x9e	; 037FCA28
	ldrh r0,[r0,#0x0]	; 037FCA2A
	ldr r2,[r5,#0x44]	; 037FCA2C
	ldrh r3,[r2,#0x4]	; 037FCA2E
	mov r2,#0xff	; 037FCA30
	and r3,r2	; 037FCA32
	lsl r2,r3,#0x10	; 037FCA34
	lsr r2,r2,#0x10	; 037FCA36
	cmp r0,r2	; 037FCA38
	bhi P2_Entry_037FCA4E	; 037FCA3A
	ldr r0,[pool_037FCB60]	; 037FCA3C
	strh r1,[r0,#0x0]	; 037FCA3E
	add r0,r5,#0x0	; 037FCA40
	add r0,#0xaa	; 037FCA42
	ldrh r0,[r0,#0x0]	; 037FCA44
	add r1,r0,#0x1	; 037FCA46
	add r0,r5,#0x0	; 037FCA48
	add r0,#0xaa	; 037FCA4A
	strh r1,[r0,#0x0]	; 037FCA4C
P2_Entry_037FCA4E:
	add r0,r5,#0x0	; 037FCA4E
	add r0,#0x90	; 037FCA50
	ldr r1,[r0,#0x0]	; 037FCA52
	ldrh r0,[r1,#0x18]	; 037FCA54
	add r0,r0,#0x1	; 037FCA56
	strh r0,[r1,#0x18]	; 037FCA58
	b P2_Entry_037FCAD2	; 037FCA5A
P2_Entry_037FCA5C:
	add r1,r5,#0x0	; 037FCA5C
	add r1,#0x98	; 037FCA5E
	ldrh r6,[r1,#0x0]	; 037FCA60
	ldr r1,[r5,#0x44]	; 037FCA62
	ldrh r3,[r1,#0x2]	; 037FCA64
	add r1,r5,#0x0	; 037FCA66
	add r1,#0x90	; 037FCA68
	ldr r2,[r1,#0x0]	; 037FCA6A
	add r2,#0x1a	; 037FCA6C
	cmp r3,#0x1	; 037FCA6E
	bls P2_Entry_037FCA92	; 037FCA70
	ldr r1,[pool_037FCB64]	; 037FCA72
	ldrh r0,[r0,r1]	; 037FCA74
	lsl r0,r0,#0x1b	; 037FCA76
	lsr r0,r0,#0x1f	; 037FCA78
	cmp r0,#0x0	; 037FCA7A
	beq P2_Entry_037FCA92	; 037FCA7C
	ldr r0,[pool_037FCB68]	; 037FCA7E
	ldrh r0,[r0,#0x0]	; 037FCA80
	mov r7,#0x1	; 037FCA82
	and r0,r7	; 037FCA84
	cmp r0,#0x0	; 037FCA86
	bne P2_Entry_037FCA92	; 037FCA88
	ldr r1,[pool_037FCB6C]	; 037FCA8A
	ldrh r0,[r1,#0x0]	; 037FCA8C
	eor r0,r7	; 037FCA8E
	strh r0,[r1,#0x0]	; 037FCA90
P2_Entry_037FCA92:
	ldr r0,[pool_037FCB38]	; 037FCA92
	ldr r1,[r0,#0x0]	; 037FCA94
	ldr r0,[pool_037FCB70]	; 037FCA96
	ldrh r1,[r1,r0]	; 037FCA98
	mov r0,#0x40	; 037FCA9A
	and r1,r0	; 037FCA9C
	cmp r1,#0x0	; 037FCA9E
	beq P2_Entry_037FCAD2	; 037FCAA0
	mov r0,#0x1	; 037FCAA2
	b P2_Entry_037FCACE	; 037FCAA4
P2_Entry_037FCAA6:
	lsl r1,r3,#0xf	; 037FCAA6
	lsr r3,r1,#0x10	; 037FCAA8
	add r1,r3,#0x0	; 037FCAAA
	and r1,r0	; 037FCAAC
	cmp r1,#0x0	; 037FCAAE
	beq P2_Entry_037FCAB8	; 037FCAB0
	ldrh r1,[r2,#0x6]	; 037FCAB2
	add r1,r1,#0x1	; 037FCAB4
	strh r1,[r2,#0x6]	; 037FCAB6
P2_Entry_037FCAB8:
	lsl r1,r6,#0xf	; 037FCAB8
	lsr r6,r1,#0x10	; 037FCABA
	add r1,r6,#0x0	; 037FCABC
	and r1,r0	; 037FCABE
	cmp r1,#0x0	; 037FCAC0
	beq P2_Entry_037FCACE	; 037FCAC2
	add r1,r5,#0x0	; 037FCAC4
	add r1,#0x90	; 037FCAC6
	ldr r1,[r1,#0x0]	; 037FCAC8
	ldrh r1,[r1,#0x16]	; 037FCACA
	add r2,r2,r1	; 037FCACC
P2_Entry_037FCACE:
	cmp r3,#0x1	; 037FCACE
	bhi P2_Entry_037FCAA6	; 037FCAD0
P2_Entry_037FCAD2:
	ldr r0,[pool_037FCB54]	; 037FCAD2
	cmp r4,r0	; 037FCAD4
	beq P2_Entry_037FCB26	; 037FCAD6
	ldr r0,[pool_037FCB74]	; 037FCAD8
	ldrh r1,[r0,#0x0]	; 037FCADA
	mov r0,#0x2	; 037FCADC
	and r1,r0	; 037FCADE
	cmp r1,#0x0	; 037FCAE0
	bne P2_Entry_037FCB26	; 037FCAE2
	ldrh r1,[r5,#0x3c]	; 037FCAE4
	cmp r1,#0x0	; 037FCAE6
	beq P2_Entry_037FCB20	; 037FCAE8
	ldr r1,[pool_037FCB78]	; 037FCAEA
	strh r0,[r1,#0x0]	; 037FCAEC
	mov r2,#0x0	; 037FCAEE
	ldr r1,[pool_037FCB7C]	; 037FCAF0
	strh r2,[r1,#0x0]	; 037FCAF2
	ldr r1,[pool_037FCB40]	; 037FCAF4
	ldrh r2,[r1,#0x0]	; 037FCAF6
	ldr r1,[pool_037FCB80]	; 037FCAF8
	and r2,r1	; 037FCAFA
	cmp r2,#0x0	; 037FCAFC
	bne P2_Entry_037FCB06	; 037FCAFE
	bl P2_Entry_037FCD8C	; 037FCB00
	b P2_Entry_037FCB14	; 037FCB04
P2_Entry_037FCB06:
	add r0,r5,#0x0	; 037FCB06
	add r0,#0xae	; 037FCB08
	ldrh r0,[r0,#0x0]	; 037FCB0A
	add r1,r0,#0x1	; 037FCB0C
	add r0,r5,#0x0	; 037FCB0E
	add r0,#0xae	; 037FCB10
	strh r1,[r0,#0x0]	; 037FCB12
P2_Entry_037FCB14:
	add r0,r5,#0x0	; 037FCB14
	add r0,#0xac	; 037FCB16
	ldrh r0,[r0,#0x0]	; 037FCB18
	add r0,r0,#0x1	; 037FCB1A
	add r5,#0xac	; 037FCB1C
	strh r0,[r5,#0x0]	; 037FCB1E
P2_Entry_037FCB20:
	mov r1,#0x2	; 037FCB20
	ldr r0,[pool_037FCB84]	; 037FCB22
	strh r1,[r0,#0x0]	; 037FCB24
P2_Entry_037FCB26:
	mov r0,#0x0	; 037FCB26
	mov r1,#0xe	; 037FCB28
	bl loc_037FB7B4	; 037FCB2A
P2_Entry_037FCB2E:
	add sp,#0x4	; 037FCB2E
	pop {r4,r5,r6,r7}	; 037FCB30
	pop {r3}	; 037FCB32
	bx r3	; 037FCB34
	.byte 0xC0, 0x46	; 037FCB36
pool_037FCB38:
	.word FirmwareWlWorkPointerSlot	; 037FCB38
pool_037FCB3C:
	.word 0x00000400	; 037FCB3C
pool_037FCB40:
	.word REG_WIFI_IF	; 037FCB40
pool_037FCB44:
	.word 0x00000320	; 037FCB44
pool_037FCB48:
	.word REG_WIFI_TXSTAT	; 037FCB48
pool_037FCB4C:
	.word 0x00000F00	; 037FCB4C
pool_037FCB50:
	.word 0x00000300	; 037FCB50
pool_037FCB54:
	.word 0x00000800	; 037FCB54
pool_037FCB58:
	.word 0x00000B00	; 037FCB58
pool_037FCB5C:
	.word 0x0000052C	; 037FCB5C
pool_037FCB60:
	.word REG_WIFI_TXREQ_RESET	; 037FCB60
pool_037FCB64:
	.word 0x0000030E	; 037FCB64
pool_037FCB68:
	.word REG_WIFI_RF_PINS	; 037FCB68
pool_037FCB6C:
	.word REG_WIFI_UNKNOWN_290	; 037FCB6C
pool_037FCB70:
	.word 0x00000638	; 037FCB70
pool_037FCB74:
	.word REG_WIFI_TXREQ_READ	; 037FCB74
pool_037FCB78:
	.word REG_WIFI_TXBUF_RESET	; 037FCB78
pool_037FCB7C:
	.word REG_WIFI_UNKNOWN_048	; 037FCB7C
pool_037FCB80:
	.word 0x00001000	; 037FCB80
pool_037FCB84:
	.word REG_WIFI_TXREQ_SET	; 037FCB84
P2_Entry_037FCB88:
	bx pc	; 037FCB88
	.byte 0xC0, 0x46	; 037FCB8A
.arm
	ldr r12,[pool_037FCB94]	; 037FCB8C
	bx r12	; 037FCB90
pool_037FCB94:
	.word P4_Entry_02308C50 + 1	; 037FCB94
P2_Entry_037FCB98:
.thumb
	push {r4,r5,r6,r7,lr}	; 037FCB98
	sub sp,#0x1c	; 037FCB9A
	ldr r0,[pool_037FCD34]	; 037FCB9C
	ldr r1,[r0,#0x0]	; 037FCB9E
	ldr r0,[pool_037FCD38]	; 037FCBA0
	add r5,r1,r0	; 037FCBA2
	ldr r0,[pool_037FCD3C]	; 037FCBA4
	add r0,r1,r0	; 037FCBA6
	str r0,[sp,#0x0]	; 037FCBA8
	ldr r0,[pool_037FCD40]	; 037FCBAA
	ldrh r6,[r1,r0]	; 037FCBAC
	mov r1,#0x1	; 037FCBAE
	ldr r0,[pool_037FCD44]	; 037FCBB0
	strh r1,[r0,#0x0]	; 037FCBB2
	and r6,r1	; 037FCBB4
P2_Entry_037FCBB6:
	ldr r0,[sp,#0x0]	; 037FCBB6
	ldrh r0,[r0,#0x4]	; 037FCBB8
	str r0,[sp,#0x8]	; 037FCBBA
	ldr r0,[pool_037FCD48]	; 037FCBBC
	ldrh r0,[r0,#0x0]	; 037FCBBE
	str r0,[sp,#0xc]	; 037FCBC0
	ldr r1,[sp,#0x8]	; 037FCBC2
	cmp r1,r0	; 037FCBC4
	bne P2_Entry_037FCBCA	; 037FCBC6
	b P2_Entry_037FCCFA	; 037FCBC8
P2_Entry_037FCBCA:
	ldr r0,[pool_037FCD4C]	; 037FCBCA
	ldrh r1,[r0,#0x0]	; 037FCBCC
	ldr r0,[pool_037FCD50]	; 037FCBCE
	ldrh r0,[r0,#0x0]	; 037FCBD0
	ldr r2,[pool_037FCD4C]	; 037FCBD2
	ldrh r3,[r2,#0x0]	; 037FCBD4
	ldr r2,[pool_037FCD50]	; 037FCBD6
	ldrh r2,[r2,#0x0]	; 037FCBD8
	cmp r1,r3	; 037FCBDA
	bls P2_Entry_037FCBE6	; 037FCBDC
	lsr r4,r3,#0x4	; 037FCBDE
	lsl r0,r2,#0xc	; 037FCBE0
	orr r4,r0	; 037FCBE2
	b P2_Entry_037FCBEC	; 037FCBE4
P2_Entry_037FCBE6:
	lsr r4,r1,#0x4	; 037FCBE6
	lsl r0,r0,#0xc	; 037FCBE8
	orr r4,r0	; 037FCBEA
P2_Entry_037FCBEC:
	ldr r0,[sp,#0x8]	; 037FCBEC
	lsl r7,r0,#0x1	; 037FCBEE
	ldr r0,[pool_037FCD54]	; 037FCBF0
	add r0,r7,r0	; 037FCBF2
	str r0,[sp,#0x4]	; 037FCBF4
	add r0,r0,#0x2	; 037FCBF6
	bl P2_Entry_037FD16C	; 037FCBF8
	str r0,[sp,#0x10]	; 037FCBFC
	add r0,r0,#0x2	; 037FCBFE
	bl P2_Entry_037FD16C	; 037FCC00
	str r0,[sp,#0x14]	; 037FCC04
	add r0,r0,#0x4	; 037FCC06
	bl P2_Entry_037FD16C	; 037FCC08
	add r2,r0,#0x0	; 037FCC0C
	ldr r0,[pool_037FCD54]	; 037FCC0E
	ldrh r1,[r7,r0]	; 037FCC10
	ldr r0,[sp,#0x10]	; 037FCC12
	ldrh r0,[r0,#0x0]	; 037FCC14
	lsl r3,r0,#0x1	; 037FCC16
	ldr r0,[pool_037FCD58]	; 037FCC18
	and r3,r0	; 037FCC1A
	orr r1,r3	; 037FCC1C
	ldr r0,[pool_037FCD54]	; 037FCC1E
	strh r1,[r7,r0]	; 037FCC20
	ldr r0,[sp,#0x14]	; 037FCC22
	strh r4,[r0,#0x0]	; 037FCC24
	ldrh r2,[r2,#0x0]	; 037FCC26
	ldr r0,[sp,#0x8]	; 037FCC28
	lsl r0,r0,#0x1	; 037FCC2A
	add r0,r2,r0	; 037FCC2C
	add r0,#0xf	; 037FCC2E
	lsr r0,r0,#0x2	; 037FCC30
	lsl r4,r0,#0x1	; 037FCC32
	ldr r0,[pool_037FCD5C]	; 037FCC34
	cmp r4,r0	; 037FCC36
	bcc P2_Entry_037FCC44	; 037FCC38
	add r0,r5,#0x0	; 037FCC3A
	add r0,#0x9a	; 037FCC3C
	ldrh r0,[r0,#0x0]	; 037FCC3E
	lsr r0,r0,#0x1	; 037FCC40
	sub r4,r4,r0	; 037FCC42
P2_Entry_037FCC44:
	ldr r0,[pool_037FCD60]	; 037FCC44
	cmp r2,r0	; 037FCC46
	bls P2_Entry_037FCC62	; 037FCC48
	ldr r1,[pool_037FCD64]	; 037FCC4A
	ldr r0,[sp,#0x4]	; 037FCC4C
	strh r1,[r0,#0x0]	; 037FCC4E
	ldr r4,[sp,#0xc]	; 037FCC50
	add r0,r5,#0x0	; 037FCC52
	add r0,#0xb4	; 037FCC54
	ldrh r0,[r0,#0x0]	; 037FCC56
	add r1,r0,#0x1	; 037FCC58
	add r0,r5,#0x0	; 037FCC5A
	add r0,#0xb4	; 037FCC5C
	strh r1,[r0,#0x0]	; 037FCC5E
	b P2_Entry_037FCCCA	; 037FCC60
P2_Entry_037FCC62:
	cmp r6,#0x0	; 037FCC62
	beq P2_Entry_037FCCCA	; 037FCC64
	ldr r0,[sp,#0xc]	; 037FCC66
	cmp r4,r0	; 037FCC68
	beq P2_Entry_037FCCCA	; 037FCC6A
	lsl r0,r4,#0x1	; 037FCC6C
	ldr r1,[pool_037FCD54]	; 037FCC6E
	add r1,r0,r1	; 037FCC70
	ldr r3,[pool_037FCD54]	; 037FCC72
	ldrh r0,[r0,r3]	; 037FCC74
	ldr r3,[pool_037FCD68]	; 037FCC76
	cmp r1,r3	; 037FCC78
	bcs P2_Entry_037FCC88	; 037FCC7A
	ldrh r3,[r1,#0x6]	; 037FCC7C
	mov r1,#0xff	; 037FCC7E
	and r3,r1	; 037FCC80
	lsl r1,r3,#0x10	; 037FCC82
	lsr r3,r1,#0x10	; 037FCC84
	b P2_Entry_037FCC92	; 037FCC86
P2_Entry_037FCC88:
	add r3,r5,#0x0	; 037FCC88
	add r3,#0x9a	; 037FCC8A
	ldrh r3,[r3,#0x0]	; 037FCC8C
	sub r1,r1,r3	; 037FCC8E
	ldrh r3,[r1,#0x6]	; 037FCC90
P2_Entry_037FCC92:
	ldr r1,[pool_037FCD6C]	; 037FCC92
	and r0,r1	; 037FCC94
	cmp r0,#0x0	; 037FCC96
	bne P2_Entry_037FCCA8	; 037FCC98
	cmp r3,#0xa	; 037FCC9A
	beq P2_Entry_037FCCA2	; 037FCC9C
	cmp r3,#0x14	; 037FCC9E
	bne P2_Entry_037FCCA8	; 037FCCA0
P2_Entry_037FCCA2:
	ldr r0,[pool_037FCD70]	; 037FCCA2
	cmp r2,r0	; 037FCCA4
	bls P2_Entry_037FCCCA	; 037FCCA6
P2_Entry_037FCCA8:
	add r0,r5,#0x0	; 037FCCA8
	add r0,#0xb4	; 037FCCAA
	ldrh r0,[r0,#0x0]	; 037FCCAC
	add r0,r0,#0x1	; 037FCCAE
	add r5,#0xb4	; 037FCCB0
	strh r0,[r5,#0x0]	; 037FCCB2
	ldr r1,[pool_037FCD64]	; 037FCCB4
	ldr r0,[sp,#0x4]	; 037FCCB6
	strh r1,[r0,#0x0]	; 037FCCB8
	ldr r0,[sp,#0xc]	; 037FCCBA
	lsl r0,r0,#0x10	; 037FCCBC
	lsr r1,r0,#0x10	; 037FCCBE
	ldr r0,[sp,#0x0]	; 037FCCC0
	strh r1,[r0,#0x4]	; 037FCCC2
	ldr r0,[sp,#0x10]	; 037FCCC4
	strh r1,[r0,#0x0]	; 037FCCC6
	b P2_Entry_037FCCFA	; 037FCCC8
P2_Entry_037FCCCA:
	ldr r0,[sp,#0x4]	; 037FCCCA
	ldrh r1,[r0,#0x0]	; 037FCCCC
	mov r0,#0xf	; 037FCCCE
	and r1,r0	; 037FCCD0
	cmp r1,#0xc	; 037FCCD2
	bne P2_Entry_037FCCEC	; 037FCCD4
	bl P2_Entry_037FD18C	; 037FCCD6
	cmp r0,#0x0	; 037FCCDA
	bne P2_Entry_037FCCEC	; 037FCCDC
	ldr r0,[pool_037FCD34]	; 037FCCDE
	ldr r0,[r0,#0x0]	; 037FCCE0
	ldr r1,[pool_037FCD74]	; 037FCCE2
	ldr r1,[r0,r1]	; 037FCCE4
	add r2,r1,#0x1	; 037FCCE6
	ldr r1,[pool_037FCD74]	; 037FCCE8
	str r2,[r0,r1]	; 037FCCEA
P2_Entry_037FCCEC:
	lsl r0,r4,#0x10	; 037FCCEC
	lsr r1,r0,#0x10	; 037FCCEE
	ldr r0,[sp,#0x0]	; 037FCCF0
	strh r1,[r0,#0x4]	; 037FCCF2
	ldr r0,[sp,#0x10]	; 037FCCF4
	strh r1,[r0,#0x0]	; 037FCCF6
	b P2_Entry_037FCBB6	; 037FCCF8
P2_Entry_037FCCFA:
	cmp r6,#0x0	; 037FCCFA
	beq P2_Entry_037FCD18	; 037FCCFC
	ldr r0,[pool_037FCD48]	; 037FCCFE
	ldrh r4,[r0,#0x0]	; 037FCD00
	bl P2_Entry_037FD18C	; 037FCD02
	cmp r0,#0x0	; 037FCD06
	beq P2_Entry_037FCD18	; 037FCD08
	ldr r0,[pool_037FCD48]	; 037FCD0A
	ldrh r0,[r0,#0x0]	; 037FCD0C
	cmp r4,r0	; 037FCD0E
	bne P2_Entry_037FCD18	; 037FCD10
	mov r0,#0x20	; 037FCD12
	bl P2_Entry_037FCD7C	; 037FCD14
P2_Entry_037FCD18:
	ldr r0,[pool_037FCD78]	; 037FCD18
	ldrh r1,[r0,#0x0]	; 037FCD1A
	ldr r0,[pool_037FCD48]	; 037FCD1C
	ldrh r0,[r0,#0x0]	; 037FCD1E
	cmp r1,r0	; 037FCD20
	beq P2_Entry_037FCD2C	; 037FCD22
	mov r0,#0x0	; 037FCD24
	mov r1,#0xf	; 037FCD26
	bl loc_037FB7B4	; 037FCD28
P2_Entry_037FCD2C:
	add sp,#0x1c	; 037FCD2C
	pop {r4,r5,r6,r7}	; 037FCD2E
	pop {r3}	; 037FCD30
	bx r3	; 037FCD32
pool_037FCD34:
	.word FirmwareWlWorkPointerSlot	; 037FCD34
pool_037FCD38:
	.word 0x00000318	; 037FCD38
pool_037FCD3C:
	.word 0x000004B4	; 037FCD3C
pool_037FCD40:
	.word 0x00000638	; 037FCD40
pool_037FCD44:
	.word REG_WIFI_IF	; 037FCD44
pool_037FCD48:
	.word REG_WIFI_RXBUF_WRCSR	; 037FCD48
pool_037FCD4C:
	.word REG_WIFI_US_COUNT0	; 037FCD4C
pool_037FCD50:
	.word REG_WIFI_US_COUNT1	; 037FCD50
pool_037FCD54:
	.word 0x04804000	; 037FCD54
pool_037FCD58:
	.word 0x00000400	; 037FCD58
pool_037FCD5C:
	.word 0x00000FB0	; 037FCD5C
pool_037FCD60:
	.word 0x0000092C	; 037FCD60
pool_037FCD64:
	.word 0x0000FFFF	; 037FCD64
pool_037FCD68:
	.word 0x04805F5A	; 037FCD68
pool_037FCD6C:
	.word 0x00007C00	; 037FCD6C
pool_037FCD70:
	.word 0x00000FFF	; 037FCD70
pool_037FCD74:
	.word 0x0000057C	; 037FCD74
pool_037FCD78:
	.word REG_WIFI_RXBUF_READCSR	; 037FCD78
.arm
P2_Entry_037FCD7C:
.thumb
	bx pc	; 037FCD7C
	.byte 0xC0, 0x46	; 037FCD7E
.arm
	ldr r12,[pool_037FCD88]	; 037FCD80
	bx r12	; 037FCD84
pool_037FCD88:
	.word loc_02304F18 + 1	; 037FCD88
P2_Entry_037FCD8C:
.thumb
	push {r4,lr}	; 037FCD8C
	ldr r1,[pool_037FCE18]	; 037FCD8E
	ldr r3,[r1,#0x0]	; 037FCD90
	ldr r2,[pool_037FCE1C]	; 037FCD92
	add r2,r3,r2	; 037FCD94
	ldr r4,[pool_037FCE20]	; 037FCD96
	ldr r3,[pool_037FCE24]	; 037FCD98
	strh r4,[r3,#0x0]	; 037FCD9A
	ldrh r3,[r2,#0x3c]	; 037FCD9C
	cmp r3,#0x0	; 037FCD9E
	beq P2_Entry_037FCE10	; 037FCDA0
	ldr r3,[r1,#0x0]	; 037FCDA2
	ldr r1,[pool_037FCE28]	; 037FCDA4
	ldrh r3,[r3,r1]	; 037FCDA6
	mov r1,#0x10	; 037FCDA8
	and r3,r1	; 037FCDAA
	cmp r3,#0x0	; 037FCDAC
	beq P2_Entry_037FCE08	; 037FCDAE
	cmp r0,#0x0	; 037FCDB0
	beq P2_Entry_037FCE08	; 037FCDB2
	ldr r0,[pool_037FCE2C]	; 037FCDB4
	ldrh r1,[r0,#0x0]	; 037FCDB6
	ldr r0,[pool_037FCE30]	; 037FCDB8
	ldrh r0,[r0,#0x0]	; 037FCDBA
	cmp r0,#0x3	; 037FCDBC
	beq P2_Entry_037FCDC4	; 037FCDBE
	cmp r0,#0x5	; 037FCDC0
	bne P2_Entry_037FCE08	; 037FCDC2
P2_Entry_037FCDC4:
	cmp r1,#0x0	; 037FCDC4
	bne P2_Entry_037FCE08	; 037FCDC6
	ldr r3,[r2,#0x44]	; 037FCDC8
	ldrh r4,[r3,#0x2]	; 037FCDCA
	mov r0,#0x0	; 037FCDCC
	mov r1,#0x1	; 037FCDCE
	b P2_Entry_037FCDDC	; 037FCDD0
P2_Entry_037FCDD2:
	add r2,r4,#0x0	; 037FCDD2
	and r2,r1	; 037FCDD4
	add r0,r0,r2	; 037FCDD6
	lsl r2,r4,#0xf	; 037FCDD8
	lsr r4,r2,#0x10	; 037FCDDA
P2_Entry_037FCDDC:
	cmp r4,#0x0	; 037FCDDC
	bne P2_Entry_037FCDD2	; 037FCDDE
	ldrh r1,[r3,#0xa]	; 037FCDE0
	lsl r2,r1,#0x2	; 037FCDE2
	ldrh r1,[r3,#0x24]	; 037FCDE4
	add r1,#0xa	; 037FCDE6
	mul r0,r1	; 037FCDE8
	add r0,#0xc0	; 037FCDEA
	add r0,r2,r0	; 037FCDEC
	lsl r0,r0,#0x10	; 037FCDEE
	lsr r0,r0,#0x10	; 037FCDF0
	ldr r1,[pool_037FCE34]	; 037FCDF2
	bl P2_Entry_037FCE3C	; 037FCDF4
	ldr r0,[pool_037FCE18]	; 037FCDF8
	ldr r1,[r0,#0x0]	; 037FCDFA
	ldr r0,[pool_037FCE38]	; 037FCDFC
	add r0,r1,r0	; 037FCDFE
	ldrh r1,[r0,#0x0]	; 037FCE00
	add r1,r1,#0x1	; 037FCE02
	strh r1,[r0,#0x0]	; 037FCE04
	b P2_Entry_037FCE10	; 037FCE06
P2_Entry_037FCE08:
	mov r0,#0x0	; 037FCE08
	mov r1,#0x10	; 037FCE0A
	bl loc_037FB7B4	; 037FCE0C
P2_Entry_037FCE10:
	pop {r4}	; 037FCE10
	pop {r3}	; 037FCE12
	bx r3	; 037FCE14
	.byte 0xC0, 0x46	; 037FCE16
pool_037FCE18:
	.word FirmwareWlWorkPointerSlot	; 037FCE18
pool_037FCE1C:
	.word 0x00000400	; 037FCE1C
pool_037FCE20:
	.word 0x00001000	; 037FCE20
pool_037FCE24:
	.word REG_WIFI_IF	; 037FCE24
pool_037FCE28:
	.word 0x00000638	; 037FCE28
pool_037FCE2C:
	.word REG_WIFI_TXBUSY	; 037FCE2C
pool_037FCE30:
	.word REG_WIFI_RF_STATUS	; 037FCE30
pool_037FCE34:
	.word 0x037FD121	; 037FCE34
pool_037FCE38:
	.word 0x000003D4	; 037FCE38
P2_Entry_037FCE3C:
	bx pc	; 037FCE3C
	.byte 0xC0, 0x46	; 037FCE3E
.arm
	ldr r12,[pool_037FCE48]	; 037FCE40
	bx r12	; 037FCE44
pool_037FCE48:
	.word P4_Entry_02305370 + 1	; 037FCE48
P2_Entry_037FCE4C:
.thumb
	push {r4,lr}	; 037FCE4C
	ldr r3,[pool_037FCEAC]	; 037FCE4E
	ldr r1,[r3,#0x0]	; 037FCE50
	ldr r0,[pool_037FCEB0]	; 037FCE52
	add r1,r1,r0	; 037FCE54
	mov r0,#0x80	; 037FCE56
	ldr r2,[pool_037FCEB4]	; 037FCE58
	strh r0,[r2,#0x0]	; 037FCE5A
	ldr r3,[r3,#0x0]	; 037FCE5C
	ldr r2,[pool_037FCEB8]	; 037FCE5E
	ldrh r3,[r3,r2]	; 037FCE60
	mov r2,#0x20	; 037FCE62
	and r3,r2	; 037FCE64
	cmp r3,#0x0	; 037FCE66
	beq P2_Entry_037FCEA6	; 037FCE68
	ldr r2,[pool_037FCEBC]	; 037FCE6A
	ldrh r3,[r2,#0x0]	; 037FCE6C
	mov r2,#0xff	; 037FCE6E
	and r3,r2	; 037FCE70
	lsl r2,r3,#0x10	; 037FCE72
	lsr r3,r2,#0x10	; 037FCE74
	ldr r2,[pool_037FCEC0]	; 037FCE76
	ldrh r4,[r2,#0x0]	; 037FCE78
	cmp r3,#0x3	; 037FCE7A
	bcc P2_Entry_037FCEA6	; 037FCE7C
	cmp r3,#0x5	; 037FCE7E
	bhi P2_Entry_037FCEA6	; 037FCE80
	ldr r2,[r1,#0x58]	; 037FCE82
	lsr r3,r2,#0x1	; 037FCE84
	ldr r2,[pool_037FCEC4]	; 037FCE86
	and r3,r2	; 037FCE88
	cmp r4,r3	; 037FCE8A
	bcc P2_Entry_037FCEA6	; 037FCE8C
	ldr r1,[r1,#0x30]	; 037FCE8E
	lsr r1,r1,#0x1	; 037FCE90
	and r1,r2	; 037FCE92
	cmp r4,r1	; 037FCE94
	bhi P2_Entry_037FCEA6	; 037FCE96
	ldr r2,[pool_037FCEC8]	; 037FCE98
	ldrh r1,[r2,#0x0]	; 037FCE9A
	orr r1,r0	; 037FCE9C
	strh r1,[r2,#0x0]	; 037FCE9E
	ldrh r1,[r2,#0x0]	; 037FCEA0
	bic r1,r0	; 037FCEA2
	strh r1,[r2,#0x0]	; 037FCEA4
P2_Entry_037FCEA6:
	pop {r4}	; 037FCEA6
	pop {r3}	; 037FCEA8
	bx r3	; 037FCEAA
pool_037FCEAC:
	.word FirmwareWlWorkPointerSlot	; 037FCEAC
pool_037FCEB0:
	.word 0x00000400	; 037FCEB0
pool_037FCEB4:
	.word REG_WIFI_IF	; 037FCEB4
pool_037FCEB8:
	.word 0x00000638	; 037FCEB8
pool_037FCEBC:
	.word REG_WIFI_RF_STATUS	; 037FCEBC
pool_037FCEC0:
	.word REG_WIFI_RXTX_ADDR	; 037FCEC0
pool_037FCEC4:
	.word 0x00000FFF	; 037FCEC4
pool_037FCEC8:
	.word REG_WIFI_UNKNOWN_244	; 037FCEC8
P2_Entry_037FCECC:
	push {r4,r5,r6,r7,lr}	; 037FCECC
	sub sp,#0x4	; 037FCECE
	ldr r0,[pool_037FD04C]	; 037FCED0
	ldr r2,[r0,#0x0]	; 037FCED2
	ldr r1,[pool_037FD050]	; 037FCED4
	add r5,r2,r1	; 037FCED6
	ldr r1,[pool_037FD054]	; 037FCED8
	add r6,r2,r1	; 037FCEDA
	mov r2,#0x40	; 037FCEDC
	ldr r1,[pool_037FD058]	; 037FCEDE
	strh r2,[r1,#0x0]	; 037FCEE0
	ldr r1,[r0,#0x0]	; 037FCEE2
	ldr r0,[pool_037FD05C]	; 037FCEE4
	ldrh r1,[r1,r0]	; 037FCEE6
	mov r0,#0x20	; 037FCEE8
	and r1,r0	; 037FCEEA
	cmp r1,#0x0	; 037FCEEC
	bne P2_Entry_037FCEF2	; 037FCEEE
	b P2_Entry_037FD042	; 037FCEF0
P2_Entry_037FCEF2:
	add r0,r6,#0x0	; 037FCEF2
	add r0,#0xa6	; 037FCEF4
	ldrh r1,[r0,#0x0]	; 037FCEF6
	ldr r0,[pool_037FD060]	; 037FCEF8
	cmp r1,r0	; 037FCEFA
	beq P2_Entry_037FCF00	; 037FCEFC
	b P2_Entry_037FD042	; 037FCEFE
P2_Entry_037FCF00:
	ldr r0,[pool_037FD064]	; 037FCF00
	ldrh r1,[r0,#0x0]	; 037FCF02
	mov r0,#0x3	; 037FCF04
	and r1,r0	; 037FCF06
	cmp r1,#0x3	; 037FCF08
	beq P2_Entry_037FCF0E	; 037FCF0A
	b P2_Entry_037FD042	; 037FCF0C
P2_Entry_037FCF0E:
	ldr r0,[pool_037FD068]	; 037FCF0E
	ldrh r2,[r0,#0x0]	; 037FCF10
	ldr r0,[pool_037FD06C]	; 037FCF12
	ldrh r0,[r0,#0x0]	; 037FCF14
	lsr r1,r0,#0x1	; 037FCF16
	ldr r0,[pool_037FD070]	; 037FCF18
	and r1,r0	; 037FCF1A
	cmp r2,r1	; 037FCF1C
	bge P2_Entry_037FCF22	; 037FCF1E
	b P2_Entry_037FD042	; 037FCF20
P2_Entry_037FCF22:
	ldr r0,[pool_037FD074]	; 037FCF22
	ldrh r0,[r0,#0x0]	; 037FCF24
	str r0,[sp,#0x0]	; 037FCF26
	lsl r1,r0,#0x1	; 037FCF28
	ldr r0,[pool_037FD078]	; 037FCF2A
	add r0,r1,r0	; 037FCF2C
	add r0,#0x8	; 037FCF2E
	bl P2_Entry_037FD16C	; 037FCF30
	add r0,r0,#0x4	; 037FCF34
	bl P2_Entry_037FD16C	; 037FCF36
	ldrh r2,[r0,#0x0]	; 037FCF3A
	ldr r1,[pool_037FD07C]	; 037FCF3C
	and r2,r1	; 037FCF3E
	ldr r1,[pool_037FD080]	; 037FCF40
	cmp r2,r1	; 037FCF42
	bne P2_Entry_037FD042	; 037FCF44
	add r0,r0,#0x2	; 037FCF46
	bl P2_Entry_037FD16C	; 037FCF48
	add r1,r0,#0x0	; 037FCF4C
	ldr r4,[pool_037FD084]	; 037FCF4E
	ldrh r2,[r4,#0x0]	; 037FCF50
	ldr r0,[pool_037FD088]	; 037FCF52
	sub r7,r2,r0	; 037FCF54
P2_Entry_037FCF56:
	ldr r0,[pool_037FD068]	; 037FCF56
	ldrh r2,[r0,#0x0]	; 037FCF58
	ldr r0,[sp,#0x0]	; 037FCF5A
	sub r0,r2,r0	; 037FCF5C
	lsl r0,r0,#0x10	; 037FCF5E
	lsr r3,r0,#0x10	; 037FCF60
	add r2,r3,#0x0	; 037FCF62
	ldr r0,[pool_037FD08C]	; 037FCF64
	and r2,r0	; 037FCF66
	cmp r2,#0x0	; 037FCF68
	beq P2_Entry_037FCF7A	; 037FCF6A
	add r0,r5,#0x0	; 037FCF6C
	add r0,#0x9a	; 037FCF6E
	ldrh r0,[r0,#0x0]	; 037FCF70
	lsr r0,r0,#0x1	; 037FCF72
	add r0,r3,r0	; 037FCF74
	lsl r0,r0,#0x10	; 037FCF76
	lsr r3,r0,#0x10	; 037FCF78
P2_Entry_037FCF7A:
	cmp r3,#0xe	; 037FCF7A
	bhi P2_Entry_037FCF8C	; 037FCF7C
	ldrh r0,[r4,#0x0]	; 037FCF7E
	sub r0,r0,r7	; 037FCF80
	lsl r0,r0,#0x10	; 037FCF82
	lsr r0,r0,#0x10	; 037FCF84
	cmp r0,#0x40	; 037FCF86
	bls P2_Entry_037FCF56	; 037FCF88
	b P2_Entry_037FD042	; 037FCF8A
P2_Entry_037FCF8C:
	add r1,#0x8	; 037FCF8C
	mov r4,#0x0	; 037FCF8E
	b P2_Entry_037FCFAA	; 037FCF90
P2_Entry_037FCF92:
	add r0,r1,#0x0	; 037FCF92
	bl P2_Entry_037FD16C	; 037FCF94
	add r1,r0,#0x2	; 037FCF98
	ldrh r0,[r0,#0x0]	; 037FCF9A
	lsl r2,r4,#0x1	; 037FCF9C
	add r2,r5,r2	; 037FCF9E
	add r2,#0x64	; 037FCFA0
	ldrh r2,[r2,#0x0]	; 037FCFA2
	cmp r0,r2	; 037FCFA4
	bne P2_Entry_037FD042	; 037FCFA6
	add r4,r4,#0x1	; 037FCFA8
P2_Entry_037FCFAA:
	cmp r4,#0x3	; 037FCFAA
	bcc P2_Entry_037FCF92	; 037FCFAC
	add r1,#0xa	; 037FCFAE
	add r0,r1,#0x0	; 037FCFB0
	bl P2_Entry_037FD16C	; 037FCFB2
	add r3,r0,#0x0	; 037FCFB6
	ldr r4,[pool_037FD068]	; 037FCFB8
P2_Entry_037FCFBA:
	ldrh r1,[r4,#0x0]	; 037FCFBA
	ldr r0,[sp,#0x0]	; 037FCFBC
	sub r0,r1,r0	; 037FCFBE
	lsl r0,r0,#0x10	; 037FCFC0
	lsr r2,r0,#0x10	; 037FCFC2
	add r1,r2,#0x0	; 037FCFC4
	ldr r0,[pool_037FD08C]	; 037FCFC6
	and r1,r0	; 037FCFC8
	cmp r1,#0x0	; 037FCFCA
	beq P2_Entry_037FCFDC	; 037FCFCC
	add r0,r5,#0x0	; 037FCFCE
	add r0,#0x9a	; 037FCFD0
	ldrh r0,[r0,#0x0]	; 037FCFD2
	lsr r0,r0,#0x1	; 037FCFD4
	add r0,r2,r0	; 037FCFD6
	lsl r0,r0,#0x10	; 037FCFD8
	lsr r2,r0,#0x10	; 037FCFDA
P2_Entry_037FCFDC:
	cmp r2,#0x14	; 037FCFDC
	bhi P2_Entry_037FCFF0	; 037FCFDE
	ldr r0,[pool_037FD084]	; 037FCFE0
	ldrh r0,[r0,#0x0]	; 037FCFE2
	sub r0,r0,r7	; 037FCFE4
	lsl r0,r0,#0x10	; 037FCFE6
	lsr r0,r0,#0x10	; 037FCFE8
	cmp r0,#0x70	; 037FCFEA
	bls P2_Entry_037FCFBA	; 037FCFEC
	b P2_Entry_037FD042	; 037FCFEE
P2_Entry_037FCFF0:
	ldrh r1,[r3,#0x0]	; 037FCFF0
	add r0,r6,#0x0	; 037FCFF2
	add r0,#0xa2	; 037FCFF4
	ldrh r0,[r0,#0x0]	; 037FCFF6
	and r1,r0	; 037FCFF8
	cmp r1,#0x0	; 037FCFFA
	bne P2_Entry_037FD042	; 037FCFFC
	ldr r0,[pool_037FD090]	; 037FCFFE
	ldrh r0,[r0,#0x0]	; 037FD000
	add r6,#0xa6	; 037FD002
	strh r0,[r6,#0x0]	; 037FD004
	mov r1,#0x40	; 037FD006
	ldr r0,[pool_037FD094]	; 037FD008
	strh r1,[r0,#0x0]	; 037FD00A
	add r0,r5,#0x0	; 037FD00C
	add r0,#0xbe	; 037FD00E
	ldrh r0,[r0,#0x0]	; 037FD010
	add r0,r0,#0x1	; 037FD012
	add r5,#0xbe	; 037FD014
	strh r0,[r5,#0x0]	; 037FD016
	ldr r1,[pool_037FD064]	; 037FD018
	mov r0,#0x3	; 037FD01A
P2_Entry_037FD01C:
	ldrh r2,[r1,#0x0]	; 037FD01C
	and r2,r0	; 037FD01E
	cmp r2,#0x3	; 037FD020
	beq P2_Entry_037FD01C	; 037FD022
	ldr r2,[pool_037FD098]	; 037FD024
	ldrh r1,[r2,#0x0]	; 037FD026
	mov r0,#0x40	; 037FD028
	orr r1,r0	; 037FD02A
	strh r1,[r2,#0x0]	; 037FD02C
	ldrh r1,[r2,#0x0]	; 037FD02E
	bic r1,r0	; 037FD030
	strh r1,[r2,#0x0]	; 037FD032
	mov r0,#0x8	; 037FD034
	ldr r1,[pool_037FD09C]	; 037FD036
	strh r0,[r1,#0x0]	; 037FD038
	mov r0,#0x0	; 037FD03A
	strh r0,[r1,#0x0]	; 037FD03C
	bl P2_Entry_037FD0A0	; 037FD03E
P2_Entry_037FD042:
	add sp,#0x4	; 037FD042
	pop {r4,r5,r6,r7}	; 037FD044
	pop {r3}	; 037FD046
	bx r3	; 037FD048
	.byte 0xC0, 0x46	; 037FD04A
pool_037FD04C:
	.word FirmwareWlWorkPointerSlot	; 037FD04C
pool_037FD050:
	.word 0x00000318	; 037FD050
pool_037FD054:
	.word 0x00000400	; 037FD054
pool_037FD058:
	.word REG_WIFI_IF	; 037FD058
pool_037FD05C:
	.word 0x00000638	; 037FD05C
pool_037FD060:
	.word 0x0000FFFF	; 037FD060
pool_037FD064:
	.word REG_WIFI_RF_PINS	; 037FD064
pool_037FD068:
	.word REG_WIFI_RXTX_ADDR	; 037FD068
pool_037FD06C:
	.word REG_WIFI_RXBUF_BEGIN	; 037FD06C
pool_037FD070:
	.word 0x00000FFF	; 037FD070
pool_037FD074:
	.word REG_WIFI_RXBUF_WRCSR	; 037FD074
pool_037FD078:
	.word 0x04804000	; 037FD078
pool_037FD07C:
	.word 0x0000E7FF	; 037FD07C
pool_037FD080:
	.word 0x00000228	; 037FD080
pool_037FD084:
	.word REG_WIFI_US_COUNT0	; 037FD084
pool_037FD088:
	.word 0x00010000	; 037FD088
pool_037FD08C:
	.word 0x00008000	; 037FD08C
pool_037FD090:
	.word REG_WIFI_TXBUF_REPLY2	; 037FD090
pool_037FD094:
	.word REG_WIFI_TXBUF_RESET	; 037FD094
pool_037FD098:
	.word REG_WIFI_UNKNOWN_244	; 037FD098
pool_037FD09C:
	.word REG_WIFI_UNKNOWN_228	; 037FD09C
P2_Entry_037FD0A0:
	bx pc	; 037FD0A0
	.byte 0xC0, 0x46	; 037FD0A2
.arm
	ldr r12,[pool_037FD0AC]	; 037FD0A4
	bx r12	; 037FD0A8
pool_037FD0AC:
	.word P4_Entry_02306DF4 + 1	; 037FD0AC
P2_Entry_037FD0B0:
.thumb
	push {r4,r5,lr}	; 037FD0B0
	sub sp,#0x4	; 037FD0B2
	ldr r0,[pool_037FD108]	; 037FD0B4
	ldr r1,[r0,#0x0]	; 037FD0B6
	ldr r0,[pool_037FD10C]	; 037FD0B8
	add r5,r1,r0	; 037FD0BA
	mov r4,#0x0	; 037FD0BC
	mov r0,#0x1	; 037FD0BE
	bl P2_Entry_037FD110	; 037FD0C0
	lsl r0,r4,#0	; 037FD0C4
	bl P2_Entry_037FD110	; 037FD0C6
	ldr r0,[r5,#0x1c]	; 037FD0CA
	ldrh r0,[r0,#0x0]	; 037FD0CC
	cmp r0,#0x0	; 037FD0CE
	beq P2_Entry_037FD0D6	; 037FD0D0
	mov r4,#0x1	; 037FD0D2
	b P2_Entry_037FD0DA	; 037FD0D4
P2_Entry_037FD0D6:
	lsl r0,r4,#0	; 037FD0D6
	strh r0,[r5,#0x14]	; 037FD0D8
P2_Entry_037FD0DA:
	ldr r0,[r5,#0x8]	; 037FD0DA
	ldrh r0,[r0,#0x0]	; 037FD0DC
	cmp r0,#0x0	; 037FD0DE
	beq P2_Entry_037FD0E6	; 037FD0E0
	mov r4,#0x1	; 037FD0E2
	b P2_Entry_037FD0EA	; 037FD0E4
P2_Entry_037FD0E6:
	mov r0,#0x0	; 037FD0E6
	strh r0,[r5,#0x0]	; 037FD0E8
P2_Entry_037FD0EA:
	cmp r4,#0x0	; 037FD0EA
	beq P2_Entry_037FD0F6	; 037FD0EC
	mov r0,#0x0	; 037FD0EE
	mov r1,#0xe	; 037FD0F0
	bl loc_037FB7B4	; 037FD0F2
P2_Entry_037FD0F6:
	mov r0,#0x0	; 037FD0F6
	mov r1,#0x14	; 037FD0F8
	bl loc_037FB7B4	; 037FD0FA
	add sp,#0x4	; 037FD0FE
	pop {r4,r5}	; 037FD100
	pop {r3}	; 037FD102
	bx r3	; 037FD104
	.byte 0xC0, 0x46	; 037FD106
pool_037FD108:
	.word FirmwareWlWorkPointerSlot	; 037FD108
pool_037FD10C:
	.word 0x00000400	; 037FD10C
P2_Entry_037FD110:
	bx pc	; 037FD110
	.byte 0xC0, 0x46	; 037FD112
.arm
	ldr r12,[pool_037FD11C]	; 037FD114
	bx r12	; 037FD118
pool_037FD11C:
	.word loc_0230A6A4 + 1	; 037FD11C
	.byte 0x10, 0xB5, 0x0E, 0x48, 0x00, 0xF0, 0x96, 0xFE, 0x04, 0x1C, 0x0D, 0x4A, 0x13, 0x88, 0x0D, 0x49	; 037FD120
	.byte 0x0D, 0x48, 0x01, 0x80, 0x64, 0x21, 0x03, 0xE0, 0x10, 0x88, 0x83, 0x42, 0x02, 0xD1, 0x49, 0x1E	; 037FD130
	.byte 0x00, 0x29, 0xF9, 0xD1, 0x00, 0x20, 0x08, 0x49, 0x08, 0x80, 0xFF, 0xF7, 0x1F, 0xFE, 0x20, 0x1C	; 037FD140
	.byte 0x00, 0xF0, 0x96, 0xFE, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x00, 0x00, 0x00, 0x01	; 037FD150
	.byte 0x10, 0x82, 0x80, 0x04, 0x00, 0x10, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04	; 037FD160
P2_Entry_037FD16C:
.thumb
	ldr r1,[pool_037FD180]	; 037FD16C
	cmp r0,r1	; 037FD16E
	bcc P2_Entry_037FD17C	; 037FD170
	ldr r1,[pool_037FD184]	; 037FD172
	ldr r2,[r1,#0x0]	; 037FD174
	ldr r1,[pool_037FD188]	; 037FD176
	ldrh r1,[r2,r1]	; 037FD178
	sub r0,r0,r1	; 037FD17A
P2_Entry_037FD17C:
	bx lr	; 037FD17C
	.byte 0xC0, 0x46	; 037FD17E
pool_037FD180:
	.word 0x04805F60	; 037FD180
pool_037FD184:
	.word FirmwareWlWorkPointerSlot	; 037FD184
pool_037FD188:
	.word 0x000003B2	; 037FD188
P2_Entry_037FD18C:
	push {r4,lr}	; 037FD18C
	ldr r0,[pool_037FD1C0]	; 037FD18E
	ldr r1,[r0,#0x0]	; 037FD190
	ldr r0,[pool_037FD1C4]	; 037FD192
	add r4,r1,r0	; 037FD194
	add r0,r4,#0x0	; 037FD196
	add r0,#0x50	; 037FD198
	bl P2_Entry_037FD1C8	; 037FD19A
	cmp r0,#0x0	; 037FD19E
	beq P2_Entry_037FD1A6	; 037FD1A0
	mov r0,#0x1	; 037FD1A2
	b P2_Entry_037FD1B8	; 037FD1A4
P2_Entry_037FD1A6:
	add r4,#0x64	; 037FD1A6
	add r0,r4,#0x0	; 037FD1A8
	bl P2_Entry_037FD1C8	; 037FD1AA
	cmp r0,#0x0	; 037FD1AE
	beq P2_Entry_037FD1B6	; 037FD1B0
	mov r0,#0x1	; 037FD1B2
	b P2_Entry_037FD1B8	; 037FD1B4
P2_Entry_037FD1B6:
	mov r0,#0x0	; 037FD1B6
P2_Entry_037FD1B8:
	pop {r4}	; 037FD1B8
	pop {r3}	; 037FD1BA
	bx r3	; 037FD1BC
	.byte 0xC0, 0x46	; 037FD1BE
pool_037FD1C0:
	.word FirmwareWlWorkPointerSlot	; 037FD1C0
pool_037FD1C4:
	.word 0x00000400	; 037FD1C4
P2_Entry_037FD1C8:
	bx pc	; 037FD1C8
	.byte 0xC0, 0x46	; 037FD1CA
.arm
	ldr r12,[pool_037FD1D4]	; 037FD1CC
	bx r12	; 037FD1D0
pool_037FD1D4:
	.word P4_Entry_02306DB0 + 1	; 037FD1D4
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0A, 0x48, 0x01, 0x68, 0x0A, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD0	; 037FD1D8
	.byte 0x00, 0xF0, 0x14, 0xF8, 0x06, 0x48, 0x01, 0x68, 0x07, 0x48, 0x08, 0x5A, 0x40, 0x06, 0xC0, 0x0F	; 037FD1E8
	.byte 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x12, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FD1F8
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xBC, 0x03, 0x00, 0x00, 0x0E, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 037FD208
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xD1, 0x9F, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46	; 037FD218
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xD5, 0x79, 0x30, 0x02, 0xF0, 0xB5, 0x83, 0xB0	; 037FD228
	.byte 0x4B, 0x48, 0x01, 0x68, 0x4B, 0x48, 0x0D, 0x18, 0x4B, 0x48, 0x0F, 0x18, 0x02, 0x24, 0x01, 0x94	; 037FD238
	.byte 0x00, 0x94, 0x21, 0x1C, 0x14, 0x20, 0x41, 0x43, 0x7A, 0x18, 0xA0, 0x00, 0x47, 0x49, 0x43, 0x18	; 037FD248
	.byte 0x41, 0x5A, 0x47, 0x48, 0x01, 0x40, 0x00, 0x29, 0x79, 0xD1, 0x10, 0x88, 0x00, 0x28, 0x76, 0xD0	; 037FD258
	.byte 0xD0, 0x68, 0x00, 0x28, 0x6B, 0xD0, 0x91, 0x68, 0x09, 0x88, 0x01, 0x81, 0x90, 0x68, 0x81, 0x89	; 037FD268
	.byte 0xD0, 0x68, 0x81, 0x82, 0x90, 0x68, 0x86, 0x89, 0x3E, 0x49, 0x0E, 0x40, 0x00, 0x2E, 0x50, 0xD0	; 037FD278
	.byte 0x37, 0x49, 0x0E, 0x68, 0x3C, 0x49, 0x76, 0x5A, 0x08, 0x21, 0x0E, 0x40, 0x00, 0x2E, 0x40, 0xD0	; 037FD288
	.byte 0x06, 0x1C, 0x0C, 0x36, 0x41, 0x89, 0x71, 0x18, 0xC9, 0x1F, 0x01, 0x26, 0xB1, 0x43, 0x0E, 0x88	; 037FD298
	.byte 0x00, 0x2E, 0x36, 0xD1, 0x49, 0x88, 0x00, 0x29, 0x33, 0xD1, 0x28, 0x1C, 0xA8, 0x30, 0x00, 0x68	; 037FD2A8
	.byte 0xD1, 0x68, 0x89, 0x88, 0x40, 0x1A, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x26, 0x2F, 0x49, 0x0E, 0x80	; 037FD2B8
	.byte 0x2B, 0x4E, 0x0E, 0x80, 0x29, 0x1C, 0xBA, 0x31, 0x09, 0x88, 0x49, 0x1C, 0x2E, 0x1C, 0xBA, 0x36	; 037FD2C8
	.byte 0x31, 0x80, 0x29, 0x1C, 0x8C, 0x31, 0x09, 0x88, 0x88, 0x42, 0x12, 0xD9, 0xD1, 0x68, 0x00, 0x98	; 037FD2D8
	.byte 0x08, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0x38, 0x1C, 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C	; 037FD2E8
	.byte 0x38, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0xD0, 0x68, 0x01, 0x21, 0x12, 0x69, 0x08, 0xF0, 0xB4, 0xF8	; 037FD2F8
	.byte 0x25, 0xE0, 0xD1, 0x68, 0x00, 0x20, 0x88, 0x81, 0x19, 0x88, 0x19, 0x48, 0x01, 0x43, 0x19, 0x80	; 037FD308
	.byte 0x1D, 0xE0, 0xD3, 0x68, 0x99, 0x89, 0x86, 0x88, 0xFF, 0x20, 0x06, 0x40, 0x88, 0x19, 0x98, 0x81	; 037FD318
	.byte 0x04, 0xE0, 0x81, 0x88, 0xFF, 0x20, 0x01, 0x40, 0xD0, 0x68, 0x81, 0x81, 0x90, 0x88, 0x40, 0x1C	; 037FD328
	.byte 0x90, 0x80, 0xD0, 0x68, 0x01, 0x99, 0x12, 0x69, 0x08, 0xF0, 0x96, 0xF8, 0x07, 0xE0, 0x90, 0x88	; 037FD338
	.byte 0x40, 0x1C, 0x90, 0x80, 0x90, 0x68, 0x03, 0x21, 0x12, 0x69, 0x08, 0xF0, 0x8D, 0xF8, 0x64, 0x1E	; 037FD348
	.byte 0x00, 0x2C, 0x00, 0xDB, 0x75, 0xE7, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FD358
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04	; 037FD368
	.byte 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x38, 0x06, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04	; 037FD378
.thumb
P2_Entry_037FD388:
	push {r4,r5,r6,r7,lr}	; 037FD388
	sub sp,#0x24	; 037FD38A
	ldr r0,[pool_037FD5E8]	; 037FD38C
	ldr r1,[r0,#0x0]	; 037FD38E
	ldr r0,[pool_037FD5EC]	; 037FD390
	add r7,r1,r0	; 037FD392
	ldr r0,[pool_037FD5F0]	; 037FD394
	add r6,r1,r0	; 037FD396
	mov r0,#0x0	; 037FD398
	str r0,[sp,#0x0]	; 037FD39A
	str r0,[sp,#0xc]	; 037FD39C
	str r0,[sp,#0x1c]	; 037FD39E
	str r0,[sp,#0x18]	; 037FD3A0
	str r0,[sp,#0x14]	; 037FD3A2
	str r0,[sp,#0x10]	; 037FD3A4
	str r0,[sp,#0x20]	; 037FD3A6
P2_Entry_037FD3A8:
	ldr r0,[pool_037FD5F4]	; 037FD3A8
	ldrh r1,[r0,#0x0]	; 037FD3AA
	ldrh r0,[r7,#0x4]	; 037FD3AC
	cmp r1,r0	; 037FD3AE
	bne P2_Entry_037FD3B4	; 037FD3B0
	b P2_Entry_037FD5E0	; 037FD3B2
P2_Entry_037FD3B4:
	lsl r4,r1,#0x1	; 037FD3B4
	ldr r0,[pool_037FD5F8]	; 037FD3B6
	add r5,r4,r0	; 037FD3B8
	add r0,r5,#0x2	; 037FD3BA
	bl P2_Entry_037FD16C	; 037FD3BC
	ldrh r0,[r0,#0x0]	; 037FD3C0
	str r0,[sp,#0x8]	; 037FD3C2
	ldr r0,[pool_037FD5F8]	; 037FD3C4
	ldrh r1,[r4,r0]	; 037FD3C6
	ldr r0,[pool_037FD5FC]	; 037FD3C8
	cmp r1,r0	; 037FD3CA
	bne P2_Entry_037FD3D6	; 037FD3CC
	ldr r1,[sp,#0x8]	; 037FD3CE
	ldr r0,[pool_037FD5F4]	; 037FD3D0
	strh r1,[r0,#0x0]	; 037FD3D2
	b P2_Entry_037FD5D8	; 037FD3D4
P2_Entry_037FD3D6:
	add r0,r5,#0x0	; 037FD3D6
	add r0,#0x8	; 037FD3D8
	bl P2_Entry_037FD16C	; 037FD3DA
	ldrh r1,[r0,#0x0]	; 037FD3DE
	add r0,r5,#0x0	; 037FD3E0
	bl P2_Entry_037FD7D0	; 037FD3E2
	add r4,r0,#0x0	; 037FD3E6
	ldr r1,[sp,#0x8]	; 037FD3E8
	ldr r0,[pool_037FD5F4]	; 037FD3EA
	strh r1,[r0,#0x0]	; 037FD3EC
	cmp r4,#0x0	; 037FD3EE
	bne P2_Entry_037FD40C	; 037FD3F0
	ldrh r1,[r5,#0x0]	; 037FD3F2
	mov r0,#0xf	; 037FD3F4
	and r1,r0	; 037FD3F6
	cmp r1,#0xc	; 037FD3F8
	bne P2_Entry_037FD404	; 037FD3FA
	mov r0,#0x10	; 037FD3FC
	bl P2_Entry_037FCD7C	; 037FD3FE
	b P2_Entry_037FD5D8	; 037FD402
P2_Entry_037FD404:
	mov r0,#0x8	; 037FD404
	bl P2_Entry_037FCD7C	; 037FD406
	b P2_Entry_037FD5D8	; 037FD40A
P2_Entry_037FD40C:
	ldr r0,[pool_037FD5E8]	; 037FD40C
	ldr r1,[r0,#0x0]	; 037FD40E
	ldr r0,[pool_037FD600]	; 037FD410
	ldrh r1,[r1,r0]	; 037FD412
	mov r0,#0x8	; 037FD414
	and r1,r0	; 037FD416
	cmp r1,#0x0	; 037FD418
	beq P2_Entry_037FD42A	; 037FD41A
	ldrh r1,[r4,#0x14]	; 037FD41C
	ldr r0,[pool_037FD604]	; 037FD41E
	and r1,r0	; 037FD420
	cmp r1,#0x0	; 037FD422
	beq P2_Entry_037FD42A	; 037FD424
	ldr r0,[sp,#0xc]	; 037FD426
	strh r0,[r7,#0x2]	; 037FD428
P2_Entry_037FD42A:
	ldrh r1,[r4,#0x8]	; 037FD42A
	mov r0,#0x1	; 037FD42C
	str r0,[sp,#0x4]	; 037FD42E
	add r2,r1,#0x0	; 037FD430
	ldr r0,[pool_037FD608]	; 037FD432
	and r2,r0	; 037FD434
	cmp r2,#0x0	; 037FD436
	beq P2_Entry_037FD46E	; 037FD438
	ldrh r0,[r4,#0x14]	; 037FD43A
	lsl r0,r0,#0x15	; 037FD43C
	lsr r0,r0,#0x1f	; 037FD43E
	cmp r0,#0x1	; 037FD440
	beq P2_Entry_037FD450	; 037FD442
	ldrh r0,[r4,#0x2a]	; 037FD444
	lsl r0,r0,#0x1c	; 037FD446
	lsr r0,r0,#0x1c	; 037FD448
	cmp r0,#0x0	; 037FD44A
	bne P2_Entry_037FD450	; 037FD44C
	b P2_Entry_037FD598	; 037FD44E
P2_Entry_037FD450:
	ldr r0,[sp,#0x10]	; 037FD450
	str r0,[sp,#0x4]	; 037FD452
	add r0,r6,#0x0	; 037FD454
	add r0,#0xc	; 037FD456
	add r1,r6,#0x0	; 037FD458
	add r1,#0x6c	; 037FD45A
	add r2,r4,#0x0	; 037FD45C
	sub r2,#0x10	; 037FD45E
	bl loc_037FBA90	; 037FD460
	mov r0,#0x2	; 037FD464
	mov r1,#0x9	; 037FD466
	bl loc_037FB7B4	; 037FD468
	b P2_Entry_037FD598	; 037FD46C
P2_Entry_037FD46E:
	mov r0,#0xf	; 037FD46E
	and r1,r0	; 037FD470
	cmp r1,#0xf	; 037FD472
	bls P2_Entry_037FD478	; 037FD474
	b P2_Entry_037FD598	; 037FD476
P2_Entry_037FD478:
	add r0,r1,r1	; 037FD478
P2_SwitchIndexPC_037FD478:
	add r0,pc	; 037FD47A
	ldrh r0,[r0,#(P2_SwitchTable_037FD478 - (P2_SwitchIndexPC_037FD478 + 4))]	; 037FD47C
	lsl r0,r0,#0x10	; 037FD47E
	asr r0,r0,#0x10	; 037FD480
P2_SwitchTargetPC_037FD478:
	add r0,pc	; 037FD482
	bx r0	; 037FD484
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD478:
	.halfword (P2_Case_037FD4DC + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD4CE + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD504 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD4A6 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Entry_037FD598 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD540 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD576 + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD52C + 1) - (P2_SwitchTargetPC_037FD478 + 4)
	.halfword (P2_Case_037FD52C + 1) - (P2_SwitchTargetPC_037FD478 + 4)
P2_SwitchTable_037FD478End:
P2_Case_037FD4A6:
	ldrh r1,[r4,#0x14]	; 037FD4A6
	mov r0,#0xf	; 037FD4A8
	and r1,r0	; 037FD4AA
	cmp r1,#0x8	; 037FD4AC
	bne P2_Entry_037FD598	; 037FD4AE
	ldr r0,[sp,#0x14]	; 037FD4B0
	str r0,[sp,#0x4]	; 037FD4B2
	add r0,r6,#0x0	; 037FD4B4
	add r0,#0xc	; 037FD4B6
	add r1,r6,#0x0	; 037FD4B8
	add r1,#0x48	; 037FD4BA
	add r2,r4,#0x0	; 037FD4BC
	sub r2,#0x10	; 037FD4BE
	bl loc_037FBA90	; 037FD4C0
	mov r0,#0x2	; 037FD4C4
	mov r1,#0x6	; 037FD4C6
	bl loc_037FB7B4	; 037FD4C8
	b P2_Entry_037FD598	; 037FD4CC
P2_Case_037FD4CE:
	ldrh r0,[r4,#0x14]	; 037FD4CE
	cmp r0,#0x80	; 037FD4D0
	bne P2_Entry_037FD598	; 037FD4D2
	add r0,r4,#0x0	; 037FD4D4
	bl P2_Entry_037FD638	; 037FD4D6
	b P2_Entry_037FD598	; 037FD4DA
P2_Case_037FD4DC:
	ldrh r1,[r4,#0x14]	; 037FD4DC
	mov r0,#0xf	; 037FD4DE
	and r1,r0	; 037FD4E0
	cmp r1,#0x0	; 037FD4E2
	bne P2_Entry_037FD598	; 037FD4E4
	ldr r0,[sp,#0x18]	; 037FD4E6
	str r0,[sp,#0x4]	; 037FD4E8
	add r0,r6,#0x0	; 037FD4EA
	add r0,#0xc	; 037FD4EC
	add r1,r6,#0x0	; 037FD4EE
	add r1,#0x60	; 037FD4F0
	add r2,r4,#0x0	; 037FD4F2
	sub r2,#0x10	; 037FD4F4
	bl loc_037FBA90	; 037FD4F6
	mov r0,#0x1	; 037FD4FA
	mov r1,#0x7	; 037FD4FC
	bl loc_037FB7B4	; 037FD4FE
	b P2_Entry_037FD598	; 037FD502
P2_Case_037FD504:
	ldrh r1,[r4,#0x14]	; 037FD504
	ldr r0,[pool_037FD60C]	; 037FD506
	and r1,r0	; 037FD508
	cmp r1,#0xa4	; 037FD50A
	bne P2_Entry_037FD598	; 037FD50C
	ldr r0,[sp,#0x1c]	; 037FD50E
	str r0,[sp,#0x4]	; 037FD510
	add r0,r6,#0x0	; 037FD512
	add r0,#0xc	; 037FD514
	add r1,r6,#0x0	; 037FD516
	add r1,#0x60	; 037FD518
	add r2,r4,#0x0	; 037FD51A
	sub r2,#0x10	; 037FD51C
	bl loc_037FBA90	; 037FD51E
	mov r0,#0x1	; 037FD522
	mov r1,#0x7	; 037FD524
	bl loc_037FB7B4	; 037FD526
	b P2_Entry_037FD598	; 037FD52A
P2_Case_037FD52C:
	ldrh r0,[r4,#0x14]	; 037FD52C
	ldr r1,[pool_037FD610]	; 037FD52E
	and r0,r1	; 037FD530
	ldr r1,[pool_037FD614]	; 037FD532
	cmp r0,r1	; 037FD534
	bne P2_Entry_037FD598	; 037FD536
	add r0,r4,#0x0	; 037FD538
	bl P2_Entry_037FD648	; 037FD53A
	b P2_Entry_037FD598	; 037FD53E
P2_Case_037FD540:
	ldrh r0,[r4,#0x14]	; 037FD540
	ldr r1,[pool_037FD60C]	; 037FD542
	and r0,r1	; 037FD544
	ldr r1,[pool_037FD618]	; 037FD546
	cmp r0,r1	; 037FD548
	bne P2_Entry_037FD598	; 037FD54A
	ldr r0,[pool_037FD5E8]	; 037FD54C
	ldr r1,[r0,#0x0]	; 037FD54E
	ldr r0,[pool_037FD61C]	; 037FD550
	ldrh r0,[r1,r0]	; 037FD552
	cmp r0,#0x0	; 037FD554
	bne P2_Entry_037FD55E	; 037FD556
	mov r1,#0x1	; 037FD558
	ldr r0,[pool_037FD620]	; 037FD55A
	strh r1,[r0,#0x0]	; 037FD55C
P2_Entry_037FD55E:
	ldr r0,[pool_037FD5E8]	; 037FD55E
	ldr r2,[r0,#0x0]	; 037FD560
	ldr r0,[pool_037FD624]	; 037FD562
	ldr r0,[r2,r0]	; 037FD564
	add r1,r0,#0x1	; 037FD566
	ldr r0,[pool_037FD624]	; 037FD568
	str r1,[r2,r0]	; 037FD56A
	add r0,r4,#0x0	; 037FD56C
	bl P2_Entry_037FD658	; 037FD56E
	str r0,[sp,#0x4]	; 037FD572
	b P2_Entry_037FD598	; 037FD574
P2_Case_037FD576:
	ldrh r0,[r4,#0x14]	; 037FD576
	ldr r1,[pool_037FD60C]	; 037FD578
	and r0,r1	; 037FD57A
	ldr r1,[pool_037FD628]	; 037FD57C
	cmp r0,r1	; 037FD57E
	bne P2_Entry_037FD598	; 037FD580
	ldr r0,[pool_037FD5E8]	; 037FD582
	ldr r2,[r0,#0x0]	; 037FD584
	ldr r0,[pool_037FD62C]	; 037FD586
	ldr r0,[r2,r0]	; 037FD588
	add r1,r0,#0x1	; 037FD58A
	ldr r0,[pool_037FD62C]	; 037FD58C
	str r1,[r2,r0]	; 037FD58E
	add r0,r4,#0x0	; 037FD590
	bl P2_Entry_037FD668	; 037FD592
	str r0,[sp,#0x4]	; 037FD596
P2_Entry_037FD598:
	ldr r0,[sp,#0x4]	; 037FD598
	cmp r0,#0x0	; 037FD59A
	beq P2_Entry_037FD5AA	; 037FD59C
	add r0,r6,#0x0	; 037FD59E
	add r0,#0xc	; 037FD5A0
	sub r4,#0x10	; 037FD5A2
	add r1,r4,#0x0	; 037FD5A4
	bl P2_Entry_037FBA38	; 037FD5A6
P2_Entry_037FD5AA:
	ldr r0,[pool_037FD5E8]	; 037FD5AA
	ldr r1,[r0,#0x0]	; 037FD5AC
	ldr r0,[pool_037FD600]	; 037FD5AE
	ldrh r1,[r1,r0]	; 037FD5B0
	mov r0,#0x1	; 037FD5B2
	and r1,r0	; 037FD5B4
	cmp r1,#0x0	; 037FD5B6
	beq P2_Entry_037FD5D8	; 037FD5B8
	ldr r0,[sp,#0x20]	; 037FD5BA
P2_Entry_037FD5BC:
	ldr r1,[pool_037FD630]	; 037FD5BC
	cmp r5,r1	; 037FD5BE
	bcc P2_Entry_037FD5CC	; 037FD5C0
	ldr r1,[pool_037FD5E8]	; 037FD5C2
	ldr r2,[r1,#0x0]	; 037FD5C4
	ldr r1,[pool_037FD634]	; 037FD5C6
	ldrh r1,[r2,r1]	; 037FD5C8
	sub r5,r5,r1	; 037FD5CA
P2_Entry_037FD5CC:
	ldr r1,[pool_037FD5FC]	; 037FD5CC
	strh r1,[r5,#0x0]	; 037FD5CE
	add r5,r5,#0x2	; 037FD5D0
	add r0,r0,#0x1	; 037FD5D2
	cmp r0,#0x7	; 037FD5D4
	bcc P2_Entry_037FD5BC	; 037FD5D6
P2_Entry_037FD5D8:
	ldr r0,[sp,#0x0]	; 037FD5D8
	add r0,r0,#0x1	; 037FD5DA
	str r0,[sp,#0x0]	; 037FD5DC
	b P2_Entry_037FD3A8	; 037FD5DE
P2_Entry_037FD5E0:
	add sp,#0x24	; 037FD5E0
	pop {r4,r5,r6,r7}	; 037FD5E2
	pop {r3}	; 037FD5E4
	bx r3	; 037FD5E6
pool_037FD5E8:
	.word FirmwareWlWorkPointerSlot	; 037FD5E8
pool_037FD5EC:
	.word 0x000004B4	; 037FD5EC
pool_037FD5F0:
	.word 0x00000150	; 037FD5F0
pool_037FD5F4:
	.word REG_WIFI_RXBUF_READCSR	; 037FD5F4
pool_037FD5F8:
	.word 0x04804000	; 037FD5F8
pool_037FD5FC:
	.word 0x0000FFFF	; 037FD5FC
pool_037FD600:
	.word 0x00000638	; 037FD600
pool_037FD604:
	.word 0x00004000	; 037FD604
pool_037FD608:
	.word 0x00000200	; 037FD608
pool_037FD60C:
	.word 0x0000E7FF	; 037FD60C
pool_037FD610:
	.word 0x0000E7BF	; 037FD610
pool_037FD614:
	.word 0x00000118	; 037FD614
pool_037FD618:
	.word 0x00000228	; 037FD618
pool_037FD61C:
	.word 0x00000328	; 037FD61C
pool_037FD620:
	.word REG_WIFI_POWERSTATE	; 037FD620
pool_037FD624:
	.word 0x00000580	; 037FD624
pool_037FD628:
	.word 0x00000218	; 037FD628
pool_037FD62C:
	.word 0x00000584	; 037FD62C
pool_037FD630:
	.word 0x04805F60	; 037FD630
pool_037FD634:
	.word 0x000003B2	; 037FD634
P2_Entry_037FD638:
	bx pc	; 037FD638
	.byte 0xC0, 0x46	; 037FD63A
.arm
	ldr r12,[pool_037FD644]	; 037FD63C
	bx r12	; 037FD640
pool_037FD644:
	.word loc_0230C6D0 + 1	; 037FD644
P2_Entry_037FD648:
.thumb
	bx pc	; 037FD648
	.byte 0xC0, 0x46	; 037FD64A
.arm
	ldr r12,[pool_037FD654]	; 037FD64C
	bx r12	; 037FD650
pool_037FD654:
	.word P4_Entry_0230CCD4 + 1	; 037FD654
P2_Entry_037FD658:
.thumb
	bx pc	; 037FD658
	.byte 0xC0, 0x46	; 037FD65A
.arm
	ldr r12,[pool_037FD664]	; 037FD65C
	bx r12	; 037FD660
pool_037FD664:
	.word P4_Entry_0230CE0C + 1	; 037FD664
P2_Entry_037FD668:
.thumb
	bx pc	; 037FD668
	.byte 0xC0, 0x46	; 037FD66A
.arm
	ldr r12,[pool_037FD674]	; 037FD66C
	bx r12	; 037FD670
pool_037FD674:
	.word P4_Entry_0230CC2C + 1	; 037FD674
.thumb
P2_Entry_037FD678:
	push {r4,lr}	; 037FD678
	ldr r0,[pool_037FD71C]	; 037FD67A
	ldr r1,[r0,#0x0]	; 037FD67C
	ldr r0,[pool_037FD720]	; 037FD67E
	add r4,r1,r0	; 037FD680
	ldrh r0,[r4,#0x3c]	; 037FD682
	cmp r0,#0x0	; 037FD684
	beq P2_Entry_037FD716	; 037FD686
	add r0,r4,#0x0	; 037FD688
	add r0,#0x90	; 037FD68A
	ldr r0,[r0,#0x0]	; 037FD68C
	ldrh r1,[r0,#0x10]	; 037FD68E
	ldr r0,[r4,#0x44]	; 037FD690
	ldrh r0,[r0,#0x2]	; 037FD692
	cmp r1,r0	; 037FD694
	beq P2_Entry_037FD69C	; 037FD696
	bl P2_Entry_037FD388	; 037FD698
P2_Entry_037FD69C:
	ldr r0,[r4,#0x44]	; 037FD69C
	ldrh r0,[r0,#0x4]	; 037FD69E
	mov r1,#0xff	; 037FD6A0
	and r0,r1	; 037FD6A2
	cmp r0,#0x0	; 037FD6A4
	beq P2_Entry_037FD6B8	; 037FD6A6
	ldr r1,[pool_037FD71C]	; 037FD6A8
	ldr r2,[r1,#0x0]	; 037FD6AA
	ldr r1,[pool_037FD724]	; 037FD6AC
	add r1,r2,r1	; 037FD6AE
	ldr r2,[r1,#0x0]	; 037FD6B0
	add r0,r2,r0	; 037FD6B2
	str r0,[r1,#0x0]	; 037FD6B4
	b P2_Entry_037FD6C6	; 037FD6B6
P2_Entry_037FD6B8:
	ldr r0,[pool_037FD71C]	; 037FD6B8
	ldr r1,[r0,#0x0]	; 037FD6BA
	ldr r0,[pool_037FD724]	; 037FD6BC
	add r0,r1,r0	; 037FD6BE
	ldr r1,[r0,#0x0]	; 037FD6C0
	add r1,r1,#0x1	; 037FD6C2
	str r1,[r0,#0x0]	; 037FD6C4
P2_Entry_037FD6C6:
	add r0,r4,#0x0	; 037FD6C6
	add r0,#0x40	; 037FD6C8
	ldrh r0,[r0,#0x0]	; 037FD6CA
	add r1,r0,#0x1	; 037FD6CC
	add r0,r4,#0x0	; 037FD6CE
	add r0,#0x40	; 037FD6D0
	strh r1,[r0,#0x0]	; 037FD6D2
	add r0,r4,#0x0	; 037FD6D4
	add r0,#0x90	; 037FD6D6
	ldr r2,[r0,#0x0]	; 037FD6D8
	ldrh r1,[r2,#0x10]	; 037FD6DA
	ldr r0,[r4,#0x44]	; 037FD6DC
	ldrh r0,[r0,#0x2]	; 037FD6DE
	eor r1,r0	; 037FD6E0
	strh r1,[r2,#0x12]	; 037FD6E2
	add r0,r4,#0x0	; 037FD6E4
	add r0,#0x90	; 037FD6E6
	ldr r0,[r0,#0x0]	; 037FD6E8
	ldrh r1,[r0,#0x10]	; 037FD6EA
	add r0,r4,#0x0	; 037FD6EC
	add r0,#0xa0	; 037FD6EE
	strh r1,[r0,#0x0]	; 037FD6F0
	mov r0,#0x0	; 037FD6F2
	strh r0,[r4,#0x3c]	; 037FD6F4
	ldr r0,[pool_037FD71C]	; 037FD6F6
	ldr r1,[r0,#0x0]	; 037FD6F8
	ldr r0,[pool_037FD728]	; 037FD6FA
	ldrh r0,[r1,r0]	; 037FD6FC
	cmp r0,#0x0	; 037FD6FE
	beq P2_Entry_037FD706	; 037FD700
	bl loc_037FC160	; 037FD702
P2_Entry_037FD706:
	ldr r0,[pool_037FD71C]	; 037FD706
	ldr r1,[r0,#0x0]	; 037FD708
	ldr r0,[pool_037FD72C]	; 037FD70A
	add r0,r1,r0	; 037FD70C
	add r4,#0x90	; 037FD70E
	ldr r1,[r4,#0x0]	; 037FD710
	bl loc_037FBD50	; 037FD712
P2_Entry_037FD716:
	pop {r4}	; 037FD716
	pop {r3}	; 037FD718
	bx r3	; 037FD71A
pool_037FD71C:
	.word FirmwareWlWorkPointerSlot	; 037FD71C
pool_037FD720:
	.word 0x00000400	; 037FD720
pool_037FD724:
	.word 0x00000574	; 037FD724
pool_037FD728:
	.word 0x000003BE	; 037FD728
pool_037FD72C:
	.word 0x0000015C	; 037FD72C
	.byte 0x10, 0xB5, 0x19, 0x48, 0x00, 0x68, 0x19, 0x49, 0x44, 0x18, 0x19, 0x49, 0x09, 0x88, 0x00, 0x29	; 037FD730
	.byte 0x08, 0xD1, 0x21, 0x8F, 0x00, 0x29, 0x05, 0xD0, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FD740
	.byte 0x2F, 0xF8, 0x1D, 0xE0, 0x14, 0x49, 0x42, 0x5A, 0x14, 0x49, 0x40, 0x5A, 0x82, 0x43, 0x00, 0x2A	; 037FD750
	.byte 0x07, 0xD1, 0x08, 0x21, 0x0F, 0x48, 0x01, 0x80, 0x20, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0	; 037FD760
	.byte 0x1F, 0xF8, 0x05, 0x21, 0x0B, 0x48, 0x01, 0x80, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 037FD770
	.byte 0x00, 0xF0, 0x1E, 0xF8, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0x18, 0xF8	; 037FD780
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00	; 037FD790
	.byte 0x88, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 037FD7A0
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x81, 0xAE, 0x30, 0x02	; 037FD7B0
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x0D, 0xAF, 0x30, 0x02	; 037FD7C0
P2_Entry_037FD7D0:
	push {r4,r5,r6,lr}	; 037FD7D0
	add r6,r0,#0x0	; 037FD7D2
	add r5,r1,#0x0	; 037FD7D4
	ldr r0,[pool_037FD820]	; 037FD7D6
	ldr r1,[r0,#0x0]	; 037FD7D8
	ldr r0,[pool_037FD824]	; 037FD7DA
	add r0,r1,r0	; 037FD7DC
	add r1,r5,#0x0	; 037FD7DE
	add r1,#0x22	; 037FD7E0
	bl P2_Entry_037FB9CC	; 037FD7E2
	cmp r0,#0x0	; 037FD7E6
	bne P2_Entry_037FD7EE	; 037FD7E8
	mov r0,#0x0	; 037FD7EA
	b P2_Entry_037FD818	; 037FD7EC
P2_Entry_037FD7EE:
	add r4,r0,#0x0	; 037FD7EE
	add r4,#0x10	; 037FD7F0
	add r0,r4,#0x0	; 037FD7F2
	add r0,#0x8	; 037FD7F4
	add r1,r6,#0x0	; 037FD7F6
	add r2,r5,#0x0	; 037FD7F8
	add r2,#0xc	; 037FD7FA
	bl P2_Entry_037FD828	; 037FD7FC
	sub r5,#0x18	; 037FD800
	strh r5,[r4,#0x6]	; 037FD802
	ldrh r2,[r4,#0xe]	; 037FD804
	mov r0,#0xff	; 037FD806
	and r2,r0	; 037FD808
	ldrh r1,[r4,#0x12]	; 037FD80A
	and r1,r0	; 037FD80C
	lsl r0,r1,#0x10	; 037FD80E
	lsr r0,r0,#0x8	; 037FD810
	orr r2,r0	; 037FD812
	strh r2,[r4,#0xe]	; 037FD814
	add r0,r4,#0x0	; 037FD816
P2_Entry_037FD818:
	pop {r4,r5,r6}	; 037FD818
	pop {r3}	; 037FD81A
	bx r3	; 037FD81C
	.byte 0xC0, 0x46	; 037FD81E
pool_037FD820:
	.word FirmwareWlWorkPointerSlot	; 037FD820
pool_037FD824:
	.word 0x0000015C	; 037FD824
P2_Entry_037FD828:
	bx pc	; 037FD828
	.byte 0xC0, 0x46	; 037FD82A
.arm
	ldr r12,[pool_037FD834]	; 037FD82C
	bx r12	; 037FD830
pool_037FD834:
	.word loc_023052B4 + 1	; 037FD834
.thumb

; ===== function loc_037FD838 =====
loc_037FD838:
	push {r4,r5,r6,r7,lr}	; 037FD838
	sub sp,#0x4	; 037FD83A
	ldr r0,[pool_037FD9F8]	; 037FD83C
	ldr r6,[r0,#0x0]	; 037FD83E
	ldr r0,[pool_037FD9FC]	; 037FD840
	add r4,r6,r0	; 037FD842
	ldr r0,[pool_037FDA00]	; 037FD844
	add r5,r6,r0	; 037FD846
	ldr r0,[pool_037FDA04]	; 037FD848
	add r7,r6,r0	; 037FD84A
	mov r0,#0x0	; 037FD84C
	str r0,[sp,#0x0]	; 037FD84E
	ldr r0,[sp,#0x0]	; 037FD850
	add r1,r4,#0x0	; 037FD852
	mov r2,#0xb4	; 037FD854
	bl loc_037FDAC4	; 037FD856
	mov r1,#0x0	; 037FD85A
	ldr r0,[pool_037FD9FC]	; 037FD85C
	strh r1,[r6,r0]	; 037FD85E
	str r1,[r4,#0xc]	; 037FD860
	strh r1,[r4,#0x14]	; 037FD862
	str r1,[r4,#0x20]	; 037FD864
	strh r1,[r4,#0x28]	; 037FD866
	str r1,[r4,#0x34]	; 037FD868
	ldr r1,[pool_037FDA08]	; 037FD86A
	add r0,r4,#0x0	; 037FD86C
	add r0,#0xa4	; 037FD86E
	strh r1,[r0,#0x0]	; 037FD870
	add r0,r4,#0x0	; 037FD872
	add r0,#0xa6	; 037FD874
	strh r1,[r0,#0x0]	; 037FD876
	ldrh r0,[r5,#0xc]	; 037FD878
	cmp r0,#0x3	; 037FD87A
	bls loc_037FD880	; 037FD87C
	b loc_037FD9DA	; 037FD87E
loc_037FD880:
	add r0,r0,r0	; 037FD880
P2_SwitchIndexPC_037FD880:
	add r0,pc	; 037FD882
	ldrh r0,[r0,#(P2_SwitchTable_037FD880 - (P2_SwitchIndexPC_037FD880 + 4))]	; 037FD884
	lsl r0,r0,#0x10	; 037FD886
	asr r0,r0,#0x10	; 037FD888
P2_SwitchTargetPC_037FD880:
	add r0,pc	; 037FD88A
	bx r0	; 037FD88C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FD880:
	.halfword (loc_037FD896 + 1) - (P2_SwitchTargetPC_037FD880 + 4)
	.halfword (loc_037FD8DA + 1) - (P2_SwitchTargetPC_037FD880 + 4)
	.halfword (loc_037FD93C + 1) - (P2_SwitchTargetPC_037FD880 + 4)
	.halfword (loc_037FD998 + 1) - (P2_SwitchTargetPC_037FD880 + 4)
P2_SwitchTable_037FD880End:
loc_037FD896:
	ldr r0,[pool_037FDA0C]	; 037FD896
	str r0,[r4,#0x8]	; 037FD898
	ldr r0,[pool_037FDA10]	; 037FD89A
	str r0,[r4,#0x1c]	; 037FD89C
	ldr r0,[pool_037FDA14]	; 037FD89E
	str r0,[r4,#0x30]	; 037FD8A0
	ldr r0,[pool_037FDA18]	; 037FD8A2
	str r0,[r4,#0x10]	; 037FD8A4
	ldr r0,[pool_037FDA1C]	; 037FD8A6
	str r0,[r4,#0x24]	; 037FD8A8
	ldr r0,[pool_037FDA20]	; 037FD8AA
	str r0,[r4,#0x38]	; 037FD8AC
	ldr r1,[pool_037FDA24]	; 037FD8AE
	ldr r0,[pool_037FDA28]	; 037FD8B0
	strh r1,[r0,#0x0]	; 037FD8B2
	ldr r0,[pool_037FDA2C]	; 037FD8B4
	ldr r2,[pool_037FDA30]	; 037FD8B6
	strh r0,[r2,#0x0]	; 037FD8B8
	ldr r2,[pool_037FDA34]	; 037FD8BA
	strh r1,[r2,#0x0]	; 037FD8BC
	ldr r2,[pool_037FDA38]	; 037FD8BE
	strh r0,[r2,#0x0]	; 037FD8C0
	ldr r2,[pool_037FDA3C]	; 037FD8C2
	strh r1,[r2,#0x0]	; 037FD8C4
	ldr r1,[pool_037FDA40]	; 037FD8C6
	strh r0,[r1,#0x0]	; 037FD8C8
	mov r1,#0x8	; 037FD8CA
	add r0,r5,#0x0	; 037FD8CC
	add r0,#0x8a	; 037FD8CE
	strh r1,[r0,#0x0]	; 037FD8D0
	mov r1,#0x1	; 037FD8D2
	ldr r0,[pool_037FDA44]	; 037FD8D4
	strh r1,[r0,#0x0]	; 037FD8D6
	b loc_037FD9DA	; 037FD8D8
loc_037FD8DA:
	ldr r0,[pool_037FDA48]	; 037FD8DA
	str r0,[r4,#0x8]	; 037FD8DC
	ldr r0,[pool_037FDA4C]	; 037FD8DE
	str r0,[r4,#0x1c]	; 037FD8E0
	ldr r0,[pool_037FDA50]	; 037FD8E2
	str r0,[r4,#0x30]	; 037FD8E4
	ldr r0,[pool_037FDA18]	; 037FD8E6
	str r0,[r4,#0x10]	; 037FD8E8
	ldr r0,[pool_037FDA1C]	; 037FD8EA
	str r0,[r4,#0x24]	; 037FD8EC
	ldr r0,[pool_037FDA54]	; 037FD8EE
	str r0,[r4,#0x38]	; 037FD8F0
	ldr r2,[pool_037FDA58]	; 037FD8F2
	add r0,r4,#0x0	; 037FD8F4
	add r0,#0x80	; 037FD8F6
	str r2,[r0,#0x0]	; 037FD8F8
	ldr r0,[pool_037FDA14]	; 037FD8FA
	str r0,[r4,#0x44]	; 037FD8FC
	ldr r1,[pool_037FDA24]	; 037FD8FE
	ldr r0,[pool_037FDA5C]	; 037FD900
	strh r1,[r0,#0x0]	; 037FD902
	ldr r0,[pool_037FDA2C]	; 037FD904
	ldr r3,[pool_037FDA60]	; 037FD906
	strh r0,[r3,#0x0]	; 037FD908
	ldr r3,[pool_037FDA64]	; 037FD90A
	strh r1,[r3,#0x0]	; 037FD90C
	ldr r3,[pool_037FDA68]	; 037FD90E
	strh r0,[r3,#0x0]	; 037FD910
	ldr r3,[pool_037FDA6C]	; 037FD912
	strh r1,[r3,#0x0]	; 037FD914
	ldr r3,[pool_037FDA70]	; 037FD916
	strh r0,[r3,#0x0]	; 037FD918
	ldr r3,[pool_037FDA74]	; 037FD91A
	strh r1,[r3,#0x0]	; 037FD91C
	ldr r3,[pool_037FDA78]	; 037FD91E
	strh r0,[r3,#0x0]	; 037FD920
	ldr r3,[pool_037FDA7C]	; 037FD922
	strh r1,[r3,#0x0]	; 037FD924
	ldr r1,[pool_037FDA80]	; 037FD926
	strh r0,[r1,#0x0]	; 037FD928
	ldr r1,[pool_037FDA84]	; 037FD92A
	add r0,r5,#0x0	; 037FD92C
	add r0,#0x8a	; 037FD92E
	strh r1,[r0,#0x0]	; 037FD930
	add r4,#0x80	; 037FD932
	str r2,[r4,#0x0]	; 037FD934
	bl loc_037FDAD0	; 037FD936
	b loc_037FD9DA	; 037FD93A
loc_037FD93C:
	ldr r0,[pool_037FDA88]	; 037FD93C
	str r0,[r4,#0x8]	; 037FD93E
	ldr r0,[pool_037FDA8C]	; 037FD940
	str r0,[r4,#0x1c]	; 037FD942
	ldr r0,[pool_037FDA90]	; 037FD944
	str r0,[r4,#0x30]	; 037FD946
	ldr r0,[pool_037FDA18]	; 037FD948
	str r0,[r4,#0x10]	; 037FD94A
	ldr r0,[pool_037FDA1C]	; 037FD94C
	str r0,[r4,#0x24]	; 037FD94E
	ldr r0,[pool_037FDA20]	; 037FD950
	str r0,[r4,#0x38]	; 037FD952
	ldr r0,[pool_037FDA14]	; 037FD954
	str r0,[r4,#0x58]	; 037FD956
	ldr r0,[pool_037FDA5C]	; 037FD958
	str r0,[r4,#0x6c]	; 037FD95A
	ldr r1,[pool_037FDA24]	; 037FD95C
	ldr r0,[pool_037FDA94]	; 037FD95E
	strh r1,[r0,#0x0]	; 037FD960
	ldr r0,[pool_037FDA2C]	; 037FD962
	ldr r2,[pool_037FDA98]	; 037FD964
	strh r0,[r2,#0x0]	; 037FD966
	ldr r2,[pool_037FDA9C]	; 037FD968
	strh r1,[r2,#0x0]	; 037FD96A
	ldr r2,[pool_037FDAA0]	; 037FD96C
	strh r0,[r2,#0x0]	; 037FD96E
	ldr r2,[pool_037FDAA4]	; 037FD970
	strh r1,[r2,#0x0]	; 037FD972
	ldr r2,[pool_037FDAA8]	; 037FD974
	strh r0,[r2,#0x0]	; 037FD976
	ldr r2,[pool_037FDAAC]	; 037FD978
	strh r1,[r2,#0x0]	; 037FD97A
	ldr r2,[pool_037FDAB0]	; 037FD97C
	strh r0,[r2,#0x0]	; 037FD97E
	ldr r2,[pool_037FDAB4]	; 037FD980
	strh r1,[r2,#0x0]	; 037FD982
	ldr r1,[pool_037FDAB8]	; 037FD984
	strh r0,[r1,#0x0]	; 037FD986
	ldr r1,[pool_037FDABC]	; 037FD988
	add r0,r5,#0x0	; 037FD98A
	add r0,#0x8a	; 037FD98C
	strh r1,[r0,#0x0]	; 037FD98E
	mov r1,#0xd	; 037FD990
	ldr r0,[pool_037FDA44]	; 037FD992
	strh r1,[r0,#0x0]	; 037FD994
	b loc_037FD9DA	; 037FD996
loc_037FD998:
	ldr r0,[pool_037FDA0C]	; 037FD998
	str r0,[r4,#0x8]	; 037FD99A
	ldr r0,[pool_037FDA10]	; 037FD99C
	str r0,[r4,#0x1c]	; 037FD99E
	ldr r0,[pool_037FDA14]	; 037FD9A0
	str r0,[r4,#0x30]	; 037FD9A2
	ldr r0,[pool_037FDA18]	; 037FD9A4
	str r0,[r4,#0x10]	; 037FD9A6
	ldr r0,[pool_037FDA1C]	; 037FD9A8
	str r0,[r4,#0x24]	; 037FD9AA
	ldr r0,[pool_037FDA20]	; 037FD9AC
	str r0,[r4,#0x38]	; 037FD9AE
	ldr r1,[pool_037FDA24]	; 037FD9B0
	ldr r0,[pool_037FDA28]	; 037FD9B2
	strh r1,[r0,#0x0]	; 037FD9B4
	ldr r0,[pool_037FDA2C]	; 037FD9B6
	ldr r2,[pool_037FDA30]	; 037FD9B8
	strh r0,[r2,#0x0]	; 037FD9BA
	ldr r2,[pool_037FDA34]	; 037FD9BC
	strh r1,[r2,#0x0]	; 037FD9BE
	ldr r2,[pool_037FDA38]	; 037FD9C0
	strh r0,[r2,#0x0]	; 037FD9C2
	ldr r2,[pool_037FDA3C]	; 037FD9C4
	strh r1,[r2,#0x0]	; 037FD9C6
	ldr r1,[pool_037FDA40]	; 037FD9C8
	strh r0,[r1,#0x0]	; 037FD9CA
	ldr r1,[pool_037FDABC]	; 037FD9CC
	add r0,r5,#0x0	; 037FD9CE
	add r0,#0x8a	; 037FD9D0
	strh r1,[r0,#0x0]	; 037FD9D2
	mov r1,#0xd	; 037FD9D4
	ldr r0,[pool_037FDA44]	; 037FD9D6
	strh r1,[r0,#0x0]	; 037FD9D8
loc_037FD9DA:
	ldrh r0,[r7,#0x18]	; 037FD9DA
	cmp r0,#0x0	; 037FD9DC
	beq loc_037FD9EE	; 037FD9DE
	add r0,r5,#0x0	; 037FD9E0
	add r0,#0x8a	; 037FD9E2
	ldrh r1,[r0,#0x0]	; 037FD9E4
	ldr r0,[pool_037FDAC0]	; 037FD9E6
	orr r1,r0	; 037FD9E8
	add r5,#0x8a	; 037FD9EA
	strh r1,[r5,#0x0]	; 037FD9EC
loc_037FD9EE:
	add sp,#0x4	; 037FD9EE
	pop {r4,r5,r6,r7}	; 037FD9F0
	pop {r3}	; 037FD9F2
	bx r3	; 037FD9F4
	.byte 0xC0, 0x46	; 037FD9F8
pool_037FD9F8:
loc_037FD9F8:
	.word FirmwareWlWorkPointerSlot	; 037FD9F8
pool_037FD9FC:
loc_037FD9FC:
	.word 0x00000400	; 037FD9FC
pool_037FDA00:
loc_037FDA00:
	.word 0x00000318	; 037FDA00
pool_037FDA04:
loc_037FDA04:
	.word 0x000002F0	; 037FDA04
pool_037FDA08:
loc_037FDA08:
	.word 0x0000FFFF	; 037FDA08
pool_037FDA0C:
loc_037FDA0C:
	.word 0x04804170	; 037FDA0C
pool_037FDA10:
loc_037FDA10:
	.word 0x04804028	; 037FDA10
pool_037FDA14:
loc_037FDA14:
	.word 0x04804000	; 037FDA14
pool_037FDA18:
loc_037FDA18:
	.word 0x0230AC71	; 037FDA18
pool_037FDA1C:
loc_037FDA1C:
	.word 0x0230A9C1	; 037FDA1C
pool_037FDA20:
loc_037FDA20:
	.word 0x0230A971	; 037FDA20
pool_037FDA24:
loc_037FDA24:
	.word 0x0000B6B8	; 037FDA24
pool_037FDA28:
loc_037FDA28:
	.word WifiRamBase + 0x24	; 037FDA28
pool_037FDA2C:
loc_037FDA2C:
	.word 0x00001D46	; 037FDA2C
pool_037FDA30:
loc_037FDA30:
	.word WifiRamBase + 0x26	; 037FDA30
pool_037FDA34:
loc_037FDA34:
	.word WifiRamBase + 0x16C	; 037FDA34
pool_037FDA38:
loc_037FDA38:
	.word WifiRamBase + 0x16E	; 037FDA38
pool_037FDA3C:
loc_037FDA3C:
	.word WifiRamBase + 0x790	; 037FDA3C
pool_037FDA40:
loc_037FDA40:
	.word WifiRamBase + 0x792	; 037FDA40
pool_037FDA44:
loc_037FDA44:
	.word REG_WIFI_TXREQ_SET	; 037FDA44
pool_037FDA48:
loc_037FDA48:
	.word 0x04804AA0	; 037FDA48
pool_037FDA4C:
loc_037FDA4C:
	.word 0x04804958	; 037FDA4C
pool_037FDA50:
loc_037FDA50:
	.word 0x04804334	; 037FDA50
pool_037FDA54:
loc_037FDA54:
	.word 0x0230A8A5	; 037FDA54
pool_037FDA58:
loc_037FDA58:
	.word 0x04804238	; 037FDA58
pool_037FDA5C:
loc_037FDA5C:
	.word WifiRamBase + 0x234	; 037FDA5C
pool_037FDA60:
loc_037FDA60:
	.word WifiRamBase + 0x236	; 037FDA60
pool_037FDA64:
loc_037FDA64:
	.word WifiRamBase + 0x330	; 037FDA64
pool_037FDA68:
loc_037FDA68:
	.word WifiRamBase + 0x332	; 037FDA68
pool_037FDA6C:
loc_037FDA6C:
	.word WifiRamBase + 0x954	; 037FDA6C
pool_037FDA70:
loc_037FDA70:
	.word WifiRamBase + 0x956	; 037FDA70
pool_037FDA74:
loc_037FDA74:
	.word WifiRamBase + 0xA9C	; 037FDA74
pool_037FDA78:
loc_037FDA78:
	.word WifiRamBase + 0xA9E	; 037FDA78
pool_037FDA7C:
loc_037FDA7C:
	.word WifiRamBase + 0x10C0	; 037FDA7C
pool_037FDA80:
loc_037FDA80:
	.word WifiRamBase + 0x10C2	; 037FDA80
pool_037FDA84:
loc_037FDA84:
	.word 0x00000208	; 037FDA84
pool_037FDA88:
loc_037FDA88:
	.word 0x048045D8	; 037FDA88
pool_037FDA8C:
loc_037FDA8C:
	.word 0x04804490	; 037FDA8C
pool_037FDA90:
loc_037FDA90:
	.word 0x04804468	; 037FDA90
pool_037FDA94:
loc_037FDA94:
	.word WifiRamBase + 0x230	; 037FDA94
pool_037FDA98:
loc_037FDA98:
	.word WifiRamBase + 0x232	; 037FDA98
pool_037FDA9C:
loc_037FDA9C:
	.word WifiRamBase + 0x464	; 037FDA9C
pool_037FDAA0:
loc_037FDAA0:
	.word WifiRamBase + 0x466	; 037FDAA0
pool_037FDAA4:
loc_037FDAA4:
	.word WifiRamBase + 0x48C	; 037FDAA4
pool_037FDAA8:
loc_037FDAA8:
	.word WifiRamBase + 0x48E	; 037FDAA8
pool_037FDAAC:
loc_037FDAAC:
	.word WifiRamBase + 0x5D4	; 037FDAAC
pool_037FDAB0:
loc_037FDAB0:
	.word WifiRamBase + 0x5D6	; 037FDAB0
pool_037FDAB4:
loc_037FDAB4:
	.word WifiRamBase + 0xBF8	; 037FDAB4
pool_037FDAB8:
loc_037FDAB8:
	.word WifiRamBase + 0xBFA	; 037FDAB8
pool_037FDABC:
loc_037FDABC:
	.word 0x00000108	; 037FDABC
pool_037FDAC0:
loc_037FDAC0:
	.word 0x00004000	; 037FDAC0

; ===== function loc_037FDAC4 =====
loc_037FDAC4:
	bx pc	; 037FDAC4
	.byte 0xC0, 0x46	; 037FDAC8
.arm

; ===== function loc_037FDAC8 =====
loc_037FDAC8:
	ldr pc,[pool_037FDACC]	; 037FDAC8
pool_037FDACC:
loc_037FDACC:
	.word loc_037FF740	; 037FDACC
.thumb

; ===== function loc_037FDAD0 =====
loc_037FDAD0:
	bx pc	; 037FDAD0
	.byte 0xC0, 0x46	; 037FDAD4
.arm

; ===== function loc_037FDAD4 =====
loc_037FDAD4:
	ldr r12,[pool_037FDADC]	; 037FDAD4
	bx r12	; 037FDAD8
pool_037FDADC:
loc_037FDADC:
	.word P4_Entry_0230A0B4 + 1	; 037FDADC
.thumb

; ===== function loc_037FDAE0 =====
loc_037FDAE0:
	push {r4,r5,r6,lr}	; 037FDAE0
	sub sp,#0x8	; 037FDAE2
	ldr r0,[pool_037FDB70]	; 037FDAE4
	ldr r1,[r0,#0x0]	; 037FDAE6
	ldr r0,[pool_037FDB74]	; 037FDAE8
	add r6,r1,r0	; 037FDAEA
	ldr r0,[pool_037FDB78]	; 037FDAEC
	add r4,r1,r0	; 037FDAEE
	mov r0,#0x0	; 037FDAF0
	str r0,[sp,#0x0]	; 037FDAF2
	ldr r0,[sp,#0x0]	; 037FDAF4
	add r1,r4,#0x0	; 037FDAF6
	mov r2,#0x50	; 037FDAF8
	bl loc_037FDBC0	; 037FDAFA
	ldr r1,[pool_037FDB7C]	; 037FDAFE
	ldr r0,[pool_037FDB80]	; 037FDB00
	strh r1,[r0,#0x0]	; 037FDB02
	ldr r0,[pool_037FDB70]	; 037FDB04
	ldr r1,[r0,#0x0]	; 037FDB06
	ldr r0,[pool_037FDB84]	; 037FDB08
	ldrh r0,[r1,r0]	; 037FDB0A
	cmp r0,#0x3	; 037FDB0C
	bhi loc_037FDB34	; 037FDB0E
	add r0,r0,r0	; 037FDB10
P2_SwitchIndexPC_037FDB10:
	add r0,pc	; 037FDB12
	ldrh r0,[r0,#(P2_SwitchTable_037FDB10 - (P2_SwitchIndexPC_037FDB10 + 4))]	; 037FDB14
	lsl r0,r0,#0x10	; 037FDB16
	asr r0,r0,#0x10	; 037FDB18
P2_SwitchTargetPC_037FDB10:
	add r0,pc	; 037FDB1A
	bx r0	; 037FDB1C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FDB10:
	.halfword (loc_037FDB26 + 1) - (P2_SwitchTargetPC_037FDB10 + 4)
	.halfword (loc_037FDB2A + 1) - (P2_SwitchTargetPC_037FDB10 + 4)
	.halfword (loc_037FDB2E + 1) - (P2_SwitchTargetPC_037FDB10 + 4)
	.halfword (loc_037FDB32 + 1) - (P2_SwitchTargetPC_037FDB10 + 4)
P2_SwitchTable_037FDB10End:
loc_037FDB26:
	ldr r5,[pool_037FDB88]	; 037FDB26
	b loc_037FDB34	; 037FDB28
loc_037FDB2A:
	ldr r5,[pool_037FDB8C]	; 037FDB2A
	b loc_037FDB34	; 037FDB2C
loc_037FDB2E:
	ldr r5,[pool_037FDB90]	; 037FDB2E
	b loc_037FDB34	; 037FDB30
loc_037FDB32:
	ldr r5,[pool_037FDB88]	; 037FDB32
loc_037FDB34:
	ldr r0,[pool_037FDB94]	; 037FDB34
	add r1,r5,r0	; 037FDB36
	ldr r0,[pool_037FDB98]	; 037FDB38
	strh r1,[r0,#0x0]	; 037FDB3A
	lsl r0,r5,#0xf	; 037FDB3C
	lsr r2,r0,#0x10	; 037FDB3E
	ldr r0,[pool_037FDB9C]	; 037FDB40
	strh r2,[r0,#0x0]	; 037FDB42
	ldr r1,[pool_037FDBA0]	; 037FDB44
	ldr r0,[pool_037FDBA4]	; 037FDB46
	strh r1,[r0,#0x0]	; 037FDB48
	ldr r0,[pool_037FDBA8]	; 037FDB4A
	strh r2,[r0,#0x0]	; 037FDB4C
	strh r2,[r4,#0x4]	; 037FDB4E
	ldr r0,[pool_037FDBAC]	; 037FDB50
	strh r0,[r4,#0x0]	; 037FDB52
	ldr r0,[pool_037FDBB0]	; 037FDB54
	sub r0,r0,r5	; 037FDB56
	add r6,#0x9a	; 037FDB58
	strh r0,[r6,#0x0]	; 037FDB5A
	ldr r1,[pool_037FDBB4]	; 037FDB5C
	ldr r0,[pool_037FDBB8]	; 037FDB5E
	strh r1,[r0,#0x0]	; 037FDB60
	ldr r1,[pool_037FDBBC]	; 037FDB62
	ldr r0,[pool_037FDB80]	; 037FDB64
	strh r1,[r0,#0x0]	; 037FDB66
	add sp,#0x8	; 037FDB68
	pop {r4,r5,r6}	; 037FDB6A
	pop {r3}	; 037FDB6C
	bx r3	; 037FDB6E
pool_037FDB70:
loc_037FDB70:
	.word FirmwareWlWorkPointerSlot	; 037FDB70
pool_037FDB74:
loc_037FDB74:
	.word 0x00000318	; 037FDB74
pool_037FDB78:
loc_037FDB78:
	.word 0x000004B4	; 037FDB78
pool_037FDB7C:
loc_037FDB7C:
	.word 0x00008000	; 037FDB7C
pool_037FDB80:
loc_037FDB80:
	.word REG_WIFI_RXCNT	; 037FDB80
pool_037FDB84:
loc_037FDB84:
	.word 0x00000324	; 037FDB84
pool_037FDB88:
loc_037FDB88:
	.word 0x00000794	; 037FDB88
pool_037FDB8C:
loc_037FDB8C:
	.word 0x000010C4	; 037FDB8C
pool_037FDB90:
loc_037FDB90:
	.word 0x00000BFC	; 037FDB90
pool_037FDB94:
loc_037FDB94:
	.word 0x04804000	; 037FDB94
pool_037FDB98:
loc_037FDB98:
	.word REG_WIFI_RXBUF_BEGIN	; 037FDB98
pool_037FDB9C:
loc_037FDB9C:
	.word REG_WIFI_RXBUF_WR_ADDR	; 037FDB9C
pool_037FDBA0:
loc_037FDBA0:
	.word 0x00005F60	; 037FDBA0
pool_037FDBA4:
loc_037FDBA4:
	.word REG_WIFI_RXBUF_END	; 037FDBA4
pool_037FDBA8:
loc_037FDBA8:
	.word REG_WIFI_RXBUF_READCSR	; 037FDBA8
pool_037FDBAC:
loc_037FDBAC:
	.word 0x0000FFFF	; 037FDBAC
pool_037FDBB0:
loc_037FDBB0:
	.word 0x00001F60	; 037FDBB0
pool_037FDBB4:
loc_037FDBB4:
	.word 0x00005F5E	; 037FDBB4
pool_037FDBB8:
loc_037FDBB8:
	.word REG_WIFI_RXBUF_GAP	; 037FDBB8
pool_037FDBBC:
loc_037FDBBC:
	.word 0x00008001	; 037FDBBC

; ===== function loc_037FDBC0 =====
loc_037FDBC0:
	bx pc	; 037FDBC0
	.byte 0xC0, 0x46	; 037FDBC4
.arm

; ===== function loc_037FDBC4 =====
loc_037FDBC4:
	ldr pc,[pool_037FDBC8]	; 037FDBC4
pool_037FDBC8:
loc_037FDBC8:
	.word loc_037FF740	; 037FDBC8

; ===== function loc_037FDBCC =====
; 取已启用的待处理中断，清除请求并调用对应回调。
; Select an enabled pending IRQ, acknowledge it and call its registered handler.
.func P2_DispatchIrq
	stmdb sp!,{lr}	; 037FDBCC
	mov r12,#0x4000000	; 037FDBD0
	add r12,r12,#0x210	; 037FDBD4
	ldr r1,[r12,#-0x8]	; 037FDBD8
	cmp r1,#0x0	; 037FDBDC
	ldmeqia sp!,{pc}	; 037FDBE0
	ldmia r12,{r1,r2}	; 037FDBE4
	ands r1,r1,r2	; 037FDBE8
	ldmeqia sp!,{pc}	; 037FDBEC
	mov r3,#0x1	; 037FDBF0
	mov r0,#0x0	; 037FDBF4
loc_037FDBF8:
	ands r2,r1,r3, lsl r0	; 037FDBF8
	addeq r0,r0,#0x1	; 037FDBFC
	beq loc_037FDBF8	; 037FDC00
	str r2,[r12,#0x4]	; 037FDC04
	ldr r1,[pool_037FDC18]	; 037FDC08
	ldr r0,[r1,r0,lsl #0x2]	; 037FDC0C
	ldr lr,[pool_037FDC1C]	; 037FDC10
	bx r0	; 037FDC14
.endfunc
pool_037FDC18:
loc_037FDC18:
	.word P2_IrqHandlers	; 037FDC18
pool_037FDC1C:
loc_037FDC1C:
	.word P2_IrqReturnContinuation	; 037FDC1C
; 中断回调返回后处理待执行状态，必要时保存并切换执行上下文。
; After the IRQ callback, process pending state and save/switch context when needed.
.func P2_IrqReturnContinuation
	ldr r12,[pool_037FDD34]	; 037FDC20
	ldrh r3,[r12,#0x0]	; 037FDC24
	mov r0,#0x0	; 037FDC28
	cmp r3,#0x0	; 037FDC2C
	beq P2_Entry_037FDC68	; 037FDC30
	strh r0,[r12,#0x0]	; 037FDC34
	ldr r12,[pool_037FDD38]	; 037FDC38
	mov r1,#0x1	; 037FDC3C
	strh r1,[r12,#0x0]	; 037FDC40
	ldr r12,[r12,#0xc]	; 037FDC44
	mov r2,#0x1	; 037FDC48
P2_Entry_037FDC4C:
	cmp r12,#0x0	; 037FDC4C
	beq P2_Entry_037FDC68	; 037FDC50
	ldr r0,[r12,#0x50]	; 037FDC54
	tst r3,r1, lsl r0	; 037FDC58
	strne r2,[r12,#0x48]	; 037FDC5C
	ldr r12,[r12,#0x4c]	; 037FDC60
	b P2_Entry_037FDC4C	; 037FDC64
P2_Entry_037FDC68:
	ldr r12,[pool_037FDD38]	; 037FDC68
	ldrh r1,[r12,#0x0]	; 037FDC6C
	cmp r1,#0x0	; 037FDC70
	ldreq pc,[sp],#0x4	; 037FDC74
	mov r1,#0x0	; 037FDC78
	strh r1,[r12,#0x0]	; 037FDC7C
	mov r3,#0xd2	; 037FDC80
	msr cpsr_c,r3	; 037FDC84
	add r2,r12,#0xc	; 037FDC88
	ldr r1,[r2,#0x0]	; 037FDC8C
P2_Entry_037FDC90:
	cmp r1,#0x0	; 037FDC90
	ldrneh r0,[r1,#0x48]	; 037FDC94
	cmpne r0,#0x1	; 037FDC98
	ldrne r1,[r1,#0x4c]	; 037FDC9C
	bne P2_Entry_037FDC90	; 037FDCA0
	cmp r1,#0x0	; 037FDCA4
	bne P2_Entry_037FDCB8	; 037FDCA8
P2_Entry_037FDCAC:
	mov r3,#0x92	; 037FDCAC
	msr cpsr_c,r3	; 037FDCB0
	ldr pc,[sp],#0x4	; 037FDCB4
P2_Entry_037FDCB8:
	ldr r0,[r12,#0x8]	; 037FDCB8
	cmp r1,r0	; 037FDCBC
	beq P2_Entry_037FDCAC	; 037FDCC0
	ldr r3,[r12,#0x10]	; 037FDCC4
	cmp r3,#0x0	; 037FDCC8
	beq P2_Entry_037FDCE0	; 037FDCCC
	stmdb sp!,{r0,r1,r12}	; 037FDCD0
	mov lr,pc	; 037FDCD4
	bx r3	; 037FDCD8
	ldmia sp!,{r0,r1,r12}	; 037FDCDC
P2_Entry_037FDCE0:
	str r1,[r12,#0x8]	; 037FDCE0
	mrs r2,spsr	; 037FDCE4
	str r2,[r0,#0x0]!	; 037FDCE8
	ldmib sp!,{r2,r3}	; 037FDCEC
	stmib r0!,{r2,r3}	; 037FDCF0
	ldmib sp!,{r2,r3,r12,lr}	; 037FDCF4
	stmib r0!,{r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FDCF8
	stmib r0!,{lr}	; 037FDCFC
	mov r3,#0xd3	; 037FDD00
	msr cpsr_c,r3	; 037FDD04
	stmib r0!,{sp}	; 037FDD08
	ldr sp,[r1,#0x44]	; 037FDD0C
	mov r3,#0xd2	; 037FDD10
	msr cpsr_c,r3	; 037FDD14
	ldr r2,[r1,#0x0]!	; 037FDD18
	msr spsr_cf,r2	; 037FDD1C
	ldr lr,[r1,#0x40]	; 037FDD20
	ldmib r1!,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FDD24
	mov r0,r0	; 037FDD28
	stmda sp!,{r0,r1,r2,r3,r12,lr}	; 037FDD2C
	ldmia sp!,{pc}	; 037FDD30
.endfunc
pool_037FDD34:
	.word P2_BssStart + 0x6CC	; 037FDD34
pool_037FDD38:
	.word P2_BssStart + 0x74C	; 037FDD38
.thumb
P2_IrqHandler_037FDD3C:
	push {lr}	; 037FDD3C
	sub sp,#0x4	; 037FDD3E
	ldr r0,[pool_037FDD64]	; 037FDD40
	ldr r2,[r0,#0x60]	; 037FDD42
	ldr r1,[pool_037FDD68]	; 037FDD44
	ldr r0,[r1,#0x0]	; 037FDD46
	add r0,r0,#0x1	; 037FDD48
	str r0,[r1,#0x0]	; 037FDD4A
	cmp r2,#0x0	; 037FDD4C
	beq P2_Entry_037FDD54	; 037FDD4E
	bl loc_03805470	; 037FDD50
P2_Entry_037FDD54:
	ldr r2,[pool_037FDD6C]	; 037FDD54
	ldr r1,[r2,#0x0]	; 037FDD56
	mov r0,#0x1	; 037FDD58
	orr r1,r0	; 037FDD5A
	str r1,[r2,#0x0]	; 037FDD5C
	add sp,#0x4	; 037FDD5E
	pop {r3}	; 037FDD60
	bx r3	; 037FDD62
pool_037FDD64:
	.word P2_BssStart + 0x6D0	; 037FDD64
pool_037FDD68:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FDD68
pool_037FDD6C:
	.word Bios7IrqFlagsAddress	; 037FDD6C
.arm
.thumb
P2_IrqHandler_037FDD70:
	mov r0,#0x7	; 037FDD70
	ldr r3,[pool_037FDD78]	; 037FDD72
	bx r3	; 037FDD74
	.byte 0xC0, 0x46	; 037FDD78
pool_037FDD78:
loc_037FDD78:
	.word loc_037FDDD0 + 1	; 037FDD78
P2_IrqHandler_037FDD7C:
	mov r0,#0x6	; 037FDD7C
	ldr r3,[pool_037FDD84]	; 037FDD7E
	bx r3	; 037FDD80
	.byte 0xC0, 0x46	; 037FDD84
pool_037FDD84:
loc_037FDD84:
	.word loc_037FDDD0 + 1	; 037FDD84
P2_IrqHandler_037FDD88:
	mov r0,#0x5	; 037FDD88
	ldr r3,[pool_037FDD90]	; 037FDD8A
	bx r3	; 037FDD8C
	.byte 0xC0, 0x46	; 037FDD90
pool_037FDD90:
loc_037FDD90:
	.word loc_037FDDD0 + 1	; 037FDD90
P2_IrqHandler_037FDD94:
	mov r0,#0x4	; 037FDD94
	ldr r3,[pool_037FDD9C]	; 037FDD96
	bx r3	; 037FDD98
	.byte 0xC0, 0x46	; 037FDD9C
pool_037FDD9C:
loc_037FDD9C:
	.word loc_037FDDD0 + 1	; 037FDD9C
P2_IrqHandler_037FDDA0:
	mov r0,#0x3	; 037FDDA0
	ldr r3,[pool_037FDDA8]	; 037FDDA2
	bx r3	; 037FDDA4
	.byte 0xC0, 0x46	; 037FDDA8
pool_037FDDA8:
loc_037FDDA8:
	.word loc_037FDDD0 + 1	; 037FDDA8
P2_IrqHandler_037FDDAC:
	mov r0,#0x2	; 037FDDAC
	ldr r3,[pool_037FDDB4]	; 037FDDAE
	bx r3	; 037FDDB0
	.byte 0xC0, 0x46	; 037FDDB4
pool_037FDDB4:
loc_037FDDB4:
	.word loc_037FDDD0 + 1	; 037FDDB4
P2_IrqHandler_037FDDB8:
	mov r0,#0x1	; 037FDDB8
	ldr r3,[pool_037FDDC0]	; 037FDDBA
	bx r3	; 037FDDBC
	.byte 0xC0, 0x46	; 037FDDC0
pool_037FDDC0:
loc_037FDDC0:
	.word loc_037FDDD0 + 1	; 037FDDC0
P2_IrqHandler_037FDDC4:
	mov r0,#0x0	; 037FDDC4
	ldr r3,[pool_037FDDCC]	; 037FDDC6
	bx r3	; 037FDDC8
	.byte 0xC0, 0x46	; 037FDDCC
pool_037FDDCC:
loc_037FDDCC:
	.word loc_037FDDD0 + 1	; 037FDDCC
loc_037FDDD0:
	push {r4,r5,lr}	; 037FDDD0
	sub sp,#0x4	; 037FDDD2
	mov r5,#0x1	; 037FDDD4
	lsl r2,r0,#0x1	; 037FDDD6
	ldr r1,[pool_037FDE18]	; 037FDDD8
	ldrh r1,[r1,r2]	; 037FDDDA
	lsl r5,r1	; 037FDDDC
	mov r1,#0xc	; 037FDDDE
	add r4,r0,#0x0	; 037FDDE0
	mul r4,r1	; 037FDDE2
	ldr r2,[pool_037FDE1C]	; 037FDDE4
	ldr r1,[r2,r4]	; 037FDDE6
	mov r0,#0x0	; 037FDDE8
	str r0,[r2,r4]	; 037FDDEA
	cmp r1,#0x0	; 037FDDEC
	beq loc_037FDDF8	; 037FDDEE
	ldr r0,[pool_037FDE20]	; 037FDDF0
	ldr r0,[r0,r4]	; 037FDDF2
	bl loc_0380546C	; 037FDDF4
loc_037FDDF8:
	ldr r1,[pool_037FDE24]	; 037FDDF8
	ldr r0,[r1,#0x0]	; 037FDDFA
	orr r0,r5	; 037FDDFC
	str r0,[r1,#0x0]	; 037FDDFE
	ldr r0,[pool_037FDE28]	; 037FDE00
	ldr r0,[r0,r4]	; 037FDE02
	cmp r0,#0x0	; 037FDE04
	bne loc_037FDE0E	; 037FDE06
	add r0,r5,#0x0	; 037FDE08
	bl loc_037FDE54	; 037FDE0A
loc_037FDE0E:
	add sp,#0x4	; 037FDE0E
	pop {r4,r5}	; 037FDE10
	pop {r3}	; 037FDE12
	bx r3	; 037FDE14
	.byte 0xC0, 0x46	; 037FDE18
pool_037FDE18:
loc_037FDE18:
	.word P2_Data_03805644	; 037FDE18
pool_037FDE1C:
loc_037FDE1C:
	.word P2_BssStart + 0x6D0	; 037FDE1C
pool_037FDE20:
loc_037FDE20:
	.word P2_BssStart + 0x6D8	; 037FDE20
pool_037FDE24:
loc_037FDE24:
	.word Bios7IrqFlagsAddress	; 037FDE24
pool_037FDE28:
loc_037FDE28:
	.word P2_BssStart + 0x6D4	; 037FDE28
loc_037FDE2C:
	bx lr	; 037FDE2C
	.byte 0x00, 0x00	; 037FDE30

; ===== function loc_037FDE30 =====
loc_037FDE30:
	push {r4,lr}	; 037FDE30
	ldr r4,[pool_037FDE4C]	; 037FDE32
	ldrh r3,[r4,#0x0]	; 037FDE34
	mov r1,#0x0	; 037FDE36
	strh r1,[r4,#0x0]	; 037FDE38
	ldr r2,[pool_037FDE50]	; 037FDE3A
	ldr r1,[r2,#0x0]	; 037FDE3C
	str r0,[r2,#0x0]	; 037FDE3E
	ldrh r0,[r4,#0x0]	; 037FDE40
	strh r3,[r4,#0x0]	; 037FDE42
	add r0,r1,#0x0	; 037FDE44
	pop {r4}	; 037FDE46
	pop {r3}	; 037FDE48
	bx r3	; 037FDE4A
pool_037FDE4C:
loc_037FDE4C:
	.word REG_IME	; 037FDE4C
pool_037FDE50:
loc_037FDE50:
	.word REG_IF	; 037FDE50

; ===== function loc_037FDE54 =====
loc_037FDE54:
	push {r4,r5,lr}	; 037FDE54
	sub sp,#0x4	; 037FDE56
	ldr r5,[pool_037FDE78]	; 037FDE58
	ldrh r4,[r5,#0x0]	; 037FDE5A
	mov r1,#0x0	; 037FDE5C
	strh r1,[r5,#0x0]	; 037FDE5E
	ldr r3,[pool_037FDE7C]	; 037FDE60
	ldr r2,[r3,#0x0]	; 037FDE62
	add r1,r2,#0x0	; 037FDE64
	bic r1,r0	; 037FDE66
	str r1,[r3,#0x0]	; 037FDE68
	ldrh r0,[r5,#0x0]	; 037FDE6A
	strh r4,[r5,#0x0]	; 037FDE6C
	add r0,r2,#0x0	; 037FDE6E
	add sp,#0x4	; 037FDE70
	pop {r4,r5}	; 037FDE72
	pop {r3}	; 037FDE74
	bx r3	; 037FDE76
pool_037FDE78:
loc_037FDE78:
	.word REG_IME	; 037FDE78
pool_037FDE7C:
loc_037FDE7C:
	.word REG_IE	; 037FDE7C

; ===== function loc_037FDE80 =====
loc_037FDE80:
	push {r4,r5,lr}	; 037FDE80
	sub sp,#0x4	; 037FDE82
	ldr r5,[pool_037FDEA4]	; 037FDE84
	ldrh r4,[r5,#0x0]	; 037FDE86
	mov r1,#0x0	; 037FDE88
	strh r1,[r5,#0x0]	; 037FDE8A
	ldr r3,[pool_037FDEA8]	; 037FDE8C
	ldr r2,[r3,#0x0]	; 037FDE8E
	add r1,r2,#0x0	; 037FDE90
	orr r1,r0	; 037FDE92
	str r1,[r3,#0x0]	; 037FDE94
	ldrh r0,[r5,#0x0]	; 037FDE96
	strh r4,[r5,#0x0]	; 037FDE98
	add r0,r2,#0x0	; 037FDE9A
	add sp,#0x4	; 037FDE9C
	pop {r4,r5}	; 037FDE9E
	pop {r3}	; 037FDEA0
	bx r3	; 037FDEA2
pool_037FDEA4:
loc_037FDEA4:
	.word REG_IME	; 037FDEA4
pool_037FDEA8:
loc_037FDEA8:
	.word REG_IE	; 037FDEA8

; ===== function loc_037FDEAC =====
loc_037FDEAC:
	push {r4,lr}	; 037FDEAC
	ldr r4,[pool_037FDEC8]	; 037FDEAE
	ldrh r3,[r4,#0x0]	; 037FDEB0
	mov r1,#0x0	; 037FDEB2
	strh r1,[r4,#0x0]	; 037FDEB4
	ldr r2,[pool_037FDECC]	; 037FDEB6
	ldr r1,[r2,#0x0]	; 037FDEB8
	str r0,[r2,#0x0]	; 037FDEBA
	ldrh r0,[r4,#0x0]	; 037FDEBC
	strh r3,[r4,#0x0]	; 037FDEBE
	add r0,r1,#0x0	; 037FDEC0
	pop {r4}	; 037FDEC2
	pop {r3}	; 037FDEC4
	bx r3	; 037FDEC6
pool_037FDEC8:
loc_037FDEC8:
	.word REG_IME	; 037FDEC8
pool_037FDECC:
loc_037FDECC:
	.word REG_IE	; 037FDECC

; ===== function loc_037FDED0 =====
loc_037FDED0:
	push {r4,lr}	; 037FDED0
	mov r3,#0xc	; 037FDED2
	add r4,r0,#0x0	; 037FDED4
	mul r4,r3	; 037FDED6
	ldr r3,[pool_037FDEF8]	; 037FDED8
	str r1,[r3,r4]	; 037FDEDA
	ldr r1,[pool_037FDEFC]	; 037FDEDC
	str r2,[r1,r4]	; 037FDEDE
	mov r1,#0x1	; 037FDEE0
	add r0,r0,#0x3	; 037FDEE2
	lsl r1,r0	; 037FDEE4
	add r0,r1,#0x0	; 037FDEE6
	bl loc_037FDE80	; 037FDEE8
	mov r1,#0x1	; 037FDEEC
	ldr r0,[pool_037FDF00]	; 037FDEEE
	str r1,[r0,r4]	; 037FDEF0
	pop {r4}	; 037FDEF2
	pop {r3}	; 037FDEF4
	bx r3	; 037FDEF6
pool_037FDEF8:
loc_037FDEF8:
	.word P2_BssStart + 0x700	; 037FDEF8
pool_037FDEFC:
loc_037FDEFC:
	.word P2_BssStart + 0x708	; 037FDEFC
pool_037FDF00:
loc_037FDF00:
	.word P2_BssStart + 0x704	; 037FDF00

; ===== function loc_037FDF04 =====
loc_037FDF04:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P2_SetIrqHandlers
	push {r4,r5,r6,r7,lr}	; 037FDF04
	sub sp,#0x4	; 037FDF06
	mov r5,#0x0	; 037FDF08
	add r3,r5,#0x0	; 037FDF0A
	add r2,r5,#0x0	; 037FDF0C
loc_037FDF0E:
	add r6,r0,#0x0	; 037FDF0E
	mov r4,#0x1	; 037FDF10
	and r6,r4	; 037FDF12
	cmp r6,#0x0	; 037FDF14
	beq loc_037FDF5E	; 037FDF16
	add r4,r3,#0x0	; 037FDF18
	cmp r5,#0x8	; 037FDF1A
	blt loc_037FDF30	; 037FDF1C
	cmp r5,#0xb	; 037FDF1E
	bgt loc_037FDF30	; 037FDF20
	add r6,r5,#0x0	; 037FDF22
	sub r6,#0x8	; 037FDF24
	mov r4,#0xc	; 037FDF26
	mul r6,r4	; 037FDF28
	ldr r4,[pool_037FDF70]	; 037FDF2A
	add r4,r4,r6	; 037FDF2C
	b loc_037FDF52	; 037FDF2E
loc_037FDF30:
	cmp r5,#0x3	; 037FDF30
	blt loc_037FDF44	; 037FDF32
	cmp r5,#0x6	; 037FDF34
	bgt loc_037FDF44	; 037FDF36
	add r6,r5,#0x1	; 037FDF38
	mov r4,#0xc	; 037FDF3A
	mul r6,r4	; 037FDF3C
	ldr r4,[pool_037FDF70]	; 037FDF3E
	add r4,r4,r6	; 037FDF40
	b loc_037FDF52	; 037FDF42
loc_037FDF44:
	cmp r5,#0x0	; 037FDF44
	bne loc_037FDF4C	; 037FDF46
	ldr r4,[pool_037FDF74]	; 037FDF48
	b loc_037FDF52	; 037FDF4A
loc_037FDF4C:
	lsl r7,r5,#0x2	; 037FDF4C
	ldr r6,[pool_037FDF78]	; 037FDF4E
	str r1,[r6,r7]	; 037FDF50
loc_037FDF52:
	cmp r4,#0x0	; 037FDF52
	beq loc_037FDF5E	; 037FDF54
	str r1,[r4,#0x0]	; 037FDF56
	str r2,[r4,#0x8]	; 037FDF58
	mov r6,#0x1	; 037FDF5A
	str r6,[r4,#0x4]	; 037FDF5C
loc_037FDF5E:
	lsr r0,r0,#0x1	; 037FDF5E
	add r5,r5,#0x1	; 037FDF60
	cmp r5,#0x19	; 037FDF62
	blt loc_037FDF0E	; 037FDF64
	add sp,#0x4	; 037FDF66
	pop {r4,r5,r6,r7}	; 037FDF68
	pop {r3}	; 037FDF6A
	bx r3	; 037FDF6C
.endfunc
	.byte 0xC0, 0x46	; 037FDF70
pool_037FDF70:
loc_037FDF70:
	.word 0x03805E4C	; 037FDF70
pool_037FDF74:
loc_037FDF74:
	.word 0x03805EAC	; 037FDF74
pool_037FDF78:
loc_037FDF78:
	.word P2_IrqHandlers	; 037FDF78

; ===== function loc_037FDF7C =====
loc_037FDF7C:
	mov r1,#0x0	; 037FDF7C
	ldr r0,[pool_037FDF88]	; 037FDF7E
	strh r1,[r0,#0x0]	; 037FDF80
	ldr r0,[pool_037FDF8C]	; 037FDF82
	str r1,[r0,#0x0]	; 037FDF84
	bx lr	; 037FDF86
pool_037FDF88:
loc_037FDF88:
	.word P2_BssStart + 0x6CC	; 037FDF88
pool_037FDF8C:
loc_037FDF8C:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 037FDF8C

; ===== function loc_037FDF90 =====
loc_037FDF90:
	ldr r1,[pool_037FDF94]	; 037FDF90
	bx r1	; 037FDF92
pool_037FDF94:
loc_037FDF94:
	.word loc_037FE048 + 1	; 037FDF94
.arm

; ===== function loc_037FDF98 =====
loc_037FDF98:
	ldr r3,[pool_037FE028]	; 037FDF98
	ldr r1,[r3,#0x0]	; 037FDF9C
	mov r2,#0x0	; 037FDFA0
	mov r0,#0x80000000	; 037FDFA4
loc_037FDFA8:
	tst r1,r0	; 037FDFA8
	bne loc_037FDFC4	; 037FDFAC
	add r2,r2,#0x1	; 037FDFB0
	cmp r2,#0x20	; 037FDFB4
	beq loc_037FDFC4	; 037FDFB8
	mov r0,r0, lsr #0x1	; 037FDFBC
	b loc_037FDFA8	; 037FDFC0
loc_037FDFC4:
	cmp r2,#0x20	; 037FDFC4
	movne r0,#0x80	; 037FDFC8
	bne loc_037FE00C	; 037FDFCC
	add r3,r3,#0x4	; 037FDFD0
	ldr r1,[r3,#0x0]	; 037FDFD4
	mov r2,#0x0	; 037FDFD8
	mov r0,#0x80000000	; 037FDFDC
loc_037FDFE0:
	tst r1,r0	; 037FDFE0
	bne loc_037FDFFC	; 037FDFE4
	add r2,r2,#0x1	; 037FDFE8
	cmp r2,#0x20	; 037FDFEC
	beq loc_037FDFFC	; 037FDFF0
	mov r0,r0, lsr #0x1	; 037FDFF4
	b loc_037FDFE0	; 037FDFF8
loc_037FDFFC:
	cmp r2,#0x20	; 037FDFFC
	ldr r0,[pool_037FE02C]	; 037FE000
	bxeq lr	; 037FE004
	mov r0,#0xa0	; 037FE008
loc_037FE00C:
	add r0,r0,r2	; 037FE00C
	mov r1,#0x80000000	; 037FE010
	mov r1,r1, lsr r2	; 037FE014
	ldr r2,[r3,#0x0]	; 037FE018
	bic r2,r2,r1	; 037FE01C
	str r2,[r3,#0x0]	; 037FE020
	bx lr	; 037FE024
pool_037FE028:
loc_037FE028:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FE028
pool_037FE02C:
loc_037FE02C:
	.word 0xFFFFFFFD	; 037FE02C
.thumb

; ===== function loc_037FE030 =====
loc_037FE030:
	ldr r0,[pool_037FE038]	; 037FE030
	ldr r3,[pool_037FE03C]	; 037FE032
	bx r3	; 037FE034
	.byte 0xC0, 0x46	; 037FE038
pool_037FE038:
loc_037FE038:
	.word 0x00001000	; 037FE038
pool_037FE03C:
loc_037FE03C:
	.word loc_037FF5B8 + 1	; 037FE03C
	.byte 0x70, 0x47, 0x00, 0x00, 0x70, 0x47, 0x00, 0x00	; 037FE048

; ===== function loc_037FE048 =====
loc_037FE048:
	ldr r1,[pool_037FE050]	; 037FE048
	ldr r2,[pool_037FE054]	; 037FE04A
	ldr r3,[pool_037FE058]	; 037FE04C
	bx r3	; 037FE04E
pool_037FE050:
loc_037FE050:
	.word 0x027FFFE0	; 037FE050
pool_037FE054:
loc_037FE054:
	.word 0x037FE041	; 037FE054
pool_037FE058:
loc_037FE058:
	.word loc_037FE110 + 1	; 037FE058

; ===== function loc_037FE05C =====
loc_037FE05C:
	ldr r1,[pool_037FE064]	; 037FE05C
	ldr r2,[pool_037FE068]	; 037FE05E
	ldr r3,[pool_037FE06C]	; 037FE060
	bx r3	; 037FE062
pool_037FE064:
loc_037FE064:
	.word 0x027FFFE0	; 037FE064
pool_037FE068:
loc_037FE068:
	.word 0x037FE045	; 037FE068
pool_037FE06C:
loc_037FE06C:
	.word loc_037FE174 + 1	; 037FE06C

; ===== function loc_037FE070 =====
loc_037FE070:
	push {r4,r5,r6,r7,lr}	; 037FE070
	sub sp,#0xc	; 037FE072
	add r5,r0,#0x0	; 037FE074
	add r6,r1,#0x0	; 037FE076
	add r4,r2,#0x0	; 037FE078
	add r7,r3,#0x0	; 037FE07A
	cmp r7,#0x0	; 037FE07C
	beq loc_037FE088	; 037FE07E
	bl loc_037FE0C4	; 037FE080
	str r0,[sp,#0x0]	; 037FE084
	b loc_037FE08E	; 037FE086
loc_037FE088:
	bl loc_037FE0D0	; 037FE088
	str r0,[sp,#0x0]	; 037FE08C
loc_037FE08E:
	add r0,r5,#0x0	; 037FE08E
	add r1,r6,#0x0	; 037FE090
	bl loc_037FE0DC	; 037FE092
	str r0,[sp,#0x4]	; 037FE096
	cmp r0,#0x0	; 037FE098
	bne loc_037FE0A6	; 037FE09A
	cmp r4,#0x0	; 037FE09C
	beq loc_037FE0A4	; 037FE09E
	bl loc_03805478	; 037FE0A0
loc_037FE0A4:
	strh r5,[r6,#0x4]	; 037FE0A4
loc_037FE0A6:
	cmp r7,#0x0	; 037FE0A6
	beq loc_037FE0B2	; 037FE0A8
	ldr r0,[sp,#0x0]	; 037FE0AA
	bl loc_037FE0E8	; 037FE0AC
	b loc_037FE0B8	; 037FE0B0
loc_037FE0B2:
	ldr r0,[sp,#0x0]	; 037FE0B2
	bl loc_037FE0F4	; 037FE0B4
loc_037FE0B8:
	ldr r0,[sp,#0x4]	; 037FE0B8
	add sp,#0xc	; 037FE0BA
	pop {r4,r5,r6,r7}	; 037FE0BC
	pop {r3}	; 037FE0BE
	bx r3	; 037FE0C0
	.byte 0xC0, 0x46	; 037FE0C4

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
	.word loc_037FF520	; 037FE0CC
.thumb

; ===== function loc_037FE0D0 =====
loc_037FE0D0:
	bx pc	; 037FE0D0
	.byte 0xC0, 0x46	; 037FE0D4
.arm

; ===== function loc_037FE0D4 =====
loc_037FE0D4:
	ldr pc,[pool_037FE0D8]	; 037FE0D4
pool_037FE0D8:
loc_037FE0D8:
	.word loc_037FF4F4	; 037FE0D8
.thumb

; ===== function loc_037FE0DC =====
loc_037FE0DC:
	bx pc	; 037FE0DC
	.byte 0xC0, 0x46	; 037FE0E0
.arm

; ===== function loc_037FE0E0 =====
loc_037FE0E0:
	ldr pc,[pool_037FE0E4]	; 037FE0E0
pool_037FE0E4:
loc_037FE0E4:
	.word loc_037FF7EC	; 037FE0E4
.thumb

; ===== function loc_037FE0E8 =====
loc_037FE0E8:
	bx pc	; 037FE0E8
	.byte 0xC0, 0x46	; 037FE0EC
.arm

; ===== function loc_037FE0EC =====
loc_037FE0EC:
	ldr pc,[pool_037FE0F0]	; 037FE0EC
pool_037FE0F0:
loc_037FE0F0:
	.word loc_037FF534	; 037FE0F0
.thumb

; ===== function loc_037FE0F4 =====
loc_037FE0F4:
	bx pc	; 037FE0F4
	.byte 0xC0, 0x46	; 037FE0F8
.arm

; ===== function loc_037FE0F8 =====
loc_037FE0F8:
	ldr pc,[pool_037FE0FC]	; 037FE0F8
pool_037FE0FC:
loc_037FE0FC:
	.word loc_037FF508	; 037FE0FC
.thumb

; ===== function loc_037FE100 =====
loc_037FE100:
	push {lr}	; 037FE100
	sub sp,#0x4	; 037FE102
	mov r3,#0x0	; 037FE104
	bl loc_037FE120	; 037FE106
	add sp,#0x4	; 037FE10A
	pop {r3}	; 037FE10C
	bx r3	; 037FE10E
loc_037FE110:
	push {lr}	; 037FE110
	sub sp,#0x4	; 037FE112
	mov r3,#0x0	; 037FE114
	bl loc_037FE120	; 037FE116
	add sp,#0x4	; 037FE11A
	pop {r3}	; 037FE11C
	bx r3	; 037FE11E

; ===== function loc_037FE120 =====
loc_037FE120:
	push {r4,r5,r6,r7,lr}	; 037FE120
	sub sp,#0x4	; 037FE122
	add r5,r1,#0x0	; 037FE124
	add r4,r2,#0x0	; 037FE126
	add r6,r3,#0x0	; 037FE128
	ldrh r1,[r5,#0x4]	; 037FE12A
	cmp r0,r1	; 037FE12C
	beq loc_037FE136	; 037FE12E
	mov r0,#0x1	; 037FE130
	mvn r0,r0	; 037FE132
	b loc_037FE16C	; 037FE134
loc_037FE136:
	cmp r6,#0x0	; 037FE136
	beq loc_037FE142	; 037FE138
	bl loc_037FE0C4	; 037FE13A
	add r7,r0,#0x0	; 037FE13E
	b loc_037FE148	; 037FE140
loc_037FE142:
	bl loc_037FE0D0	; 037FE142
	add r7,r0,#0x0	; 037FE146
loc_037FE148:
	mov r0,#0x0	; 037FE148
	strh r0,[r5,#0x4]	; 037FE14A
	cmp r4,#0x0	; 037FE14C
	beq loc_037FE154	; 037FE14E
	bl loc_03805478	; 037FE150
loc_037FE154:
	mov r0,#0x0	; 037FE154
	str r0,[r5,#0x0]	; 037FE156
	cmp r6,#0x0	; 037FE158
	beq loc_037FE164	; 037FE15A
	add r0,r7,#0x0	; 037FE15C
	bl loc_037FE0E8	; 037FE15E
	b loc_037FE16A	; 037FE162
loc_037FE164:
	add r0,r7,#0x0	; 037FE164
	bl loc_037FE0F4	; 037FE166
loc_037FE16A:
	mov r0,#0x0	; 037FE16A
loc_037FE16C:
	add sp,#0x4	; 037FE16C
	pop {r4,r5,r6,r7}	; 037FE16E
	pop {r3}	; 037FE170
	bx r3	; 037FE172

; ===== function loc_037FE174 =====
loc_037FE174:
	push {lr}	; 037FE174
	sub sp,#0x4	; 037FE176
	mov r3,#0x0	; 037FE178
	bl loc_037FE184	; 037FE17A
	add sp,#0x4	; 037FE17E
	pop {r3}	; 037FE180
	bx r3	; 037FE182

; ===== function loc_037FE184 =====
loc_037FE184:
	push {r4,r5,r6,r7,lr}	; 037FE184
	sub sp,#0x4	; 037FE186
	add r5,r0,#0x0	; 037FE188
	add r4,r1,#0x0	; 037FE18A
	add r6,r2,#0x0	; 037FE18C
	add r7,r3,#0x0	; 037FE18E
	b loc_037FE196	; 037FE190
loc_037FE192:
	bl loc_037FE030	; 037FE192
loc_037FE196:
	add r0,r5,#0x0	; 037FE196
	add r1,r4,#0x0	; 037FE198
	add r2,r6,#0x0	; 037FE19A
	add r3,r7,#0x0	; 037FE19C
	bl loc_037FE070	; 037FE19E
	cmp r0,#0x0	; 037FE1A2
	bgt loc_037FE192	; 037FE1A4
	add sp,#0x4	; 037FE1A6
	pop {r4,r5,r6,r7}	; 037FE1A8
	pop {r3}	; 037FE1AA
	bx r3	; 037FE1AC
	.byte 0x00, 0x00	; 037FE1B0

; ===== function loc_037FE1B0 =====
loc_037FE1B0:
	push {r4,lr}	; 037FE1B0
	ldr r0,[pool_037FE1E8]	; 037FE1B2
	ldr r1,[r0,#0x0]	; 037FE1B4
	cmp r1,#0x0	; 037FE1B6
	bne loc_037FE1E2	; 037FE1B8
	mov r1,#0x1	; 037FE1BA
	str r1,[r0,#0x0]	; 037FE1BC
	mov r0,#0x0	; 037FE1BE
	ldr r4,[pool_037FE1EC]	; 037FE1C0
	strh r0,[r4,#0x6]	; 037FE1C2
	b loc_037FE1CA	; 037FE1C4
loc_037FE1C6:
	bl loc_037FE030	; 037FE1C6
loc_037FE1CA:
	ldrh r0,[r4,#0x4]	; 037FE1CA
	cmp r0,#0x7f	; 037FE1CC
	bne loc_037FE1C6	; 037FE1CE
	mov r0,#0x0	; 037FE1D0
	mvn r1,r0	; 037FE1D2
	ldr r0,[pool_037FE1F0]	; 037FE1D4
	str r1,[r0,#0x0]	; 037FE1D6
	ldr r1,[pool_037FE1F4]	; 037FE1D8
	ldr r0,[pool_037FE1F8]	; 037FE1DA
	str r1,[r0,#0x0]	; 037FE1DC
	mov r0,#0xbf	; 037FE1DE
	strh r0,[r4,#0x6]	; 037FE1E0
loc_037FE1E2:
	pop {r4}	; 037FE1E2
	pop {r3}	; 037FE1E4
	bx r3	; 037FE1E6
pool_037FE1E8:
loc_037FE1E8:
	.word P2_BssStart + 0x73C	; 037FE1E8
pool_037FE1EC:
loc_037FE1EC:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 037FE1EC
pool_037FE1F0:
loc_037FE1F0:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset	; 037FE1F0
pool_037FE1F4:
loc_037FE1F4:
	.word 0xFFFF0000	; 037FE1F4
pool_037FE1F8:
loc_037FE1F8:
	.word FirmwareSystemWorkAddress + SystemWorkArm7LockIdsOffset + 0x4	; 037FE1F8
	.byte 0x70, 0x47, 0x00, 0x00	; 037FE200

; ===== function loc_037FE200 =====
loc_037FE200:
	push {r4,r5,lr}	; 037FE200
	sub sp,#0x4	; 037FE202
	add r5,r0,#0x0	; 037FE204
	bl loc_037FE0D0	; 037FE206
	ldr r1,[pool_037FE220]	; 037FE20A
	ldr r4,[r1,#0x10]	; 037FE20C
	str r5,[r1,#0x10]	; 037FE20E
	bl loc_037FE0F4	; 037FE210
	add r0,r4,#0x0	; 037FE214
	add sp,#0x4	; 037FE216
	pop {r4,r5}	; 037FE218
	pop {r3}	; 037FE21A
	bx r3	; 037FE21C
	.byte 0xC0, 0x46	; 037FE220
pool_037FE220:
loc_037FE220:
	.word P2_BssStart + 0x74C	; 037FE220

; ===== function loc_037FE224 =====
loc_037FE224:
	push {r4,r5,r6,lr}	; 037FE224
	ldr r6,[pool_037FE288]	; 037FE226
	ldrh r0,[r6,#0x4]	; 037FE228
	cmp r0,#0x0	; 037FE22A
	bne loc_037FE236	; 037FE22C
	bl loc_037FE294	; 037FE22E
	cmp r0,#0x12	; 037FE232
	bne loc_037FE23C	; 037FE234
loc_037FE236:
	mov r0,#0x1	; 037FE236
	strh r0,[r6,#0x0]	; 037FE238
	b loc_037FE282	; 037FE23A
loc_037FE23C:
	ldr r0,[pool_037FE28C]	; 037FE23C
	ldr r0,[r0,#0x0]	; 037FE23E
	ldr r5,[r0,#0x0]	; 037FE240
	bl loc_037FE2B8	; 037FE242
	add r4,r0,#0x0	; 037FE246
	cmp r5,r4	; 037FE248
	beq loc_037FE282	; 037FE24A
	cmp r4,#0x0	; 037FE24C
	beq loc_037FE282	; 037FE24E
	add r0,r5,#0x0	; 037FE250
	bl loc_037FE2A0	; 037FE252
	cmp r0,#0x0	; 037FE256
	bne loc_037FE282	; 037FE258
	ldr r0,[pool_037FE290]	; 037FE25A
	ldr r2,[r0,#0x0]	; 037FE25C
	cmp r2,#0x0	; 037FE25E
	beq loc_037FE26A	; 037FE260
	add r0,r5,#0x0	; 037FE262
	add r1,r4,#0x0	; 037FE264
	bl loc_03805470	; 037FE266
loc_037FE26A:
	ldr r2,[r6,#0x10]	; 037FE26A
	cmp r2,#0x0	; 037FE26C
	beq loc_037FE278	; 037FE26E
	add r0,r5,#0x0	; 037FE270
	add r1,r4,#0x0	; 037FE272
	bl loc_03805470	; 037FE274
loc_037FE278:
	ldr r0,[pool_037FE288]	; 037FE278
	str r4,[r0,#0x8]	; 037FE27A
	add r0,r4,#0x0	; 037FE27C
	bl loc_037FE2AC	; 037FE27E
loc_037FE282:
	pop {r4,r5,r6}	; 037FE282
	pop {r3}	; 037FE284
	bx r3	; 037FE286
pool_037FE288:
loc_037FE288:
	.word P2_BssStart + 0x74C	; 037FE288
pool_037FE28C:
loc_037FE28C:
	.word P2_BssStart + 0x744	; 037FE28C
pool_037FE290:
loc_037FE290:
	.word P2_BssStart + 0x740	; 037FE290

; ===== function loc_037FE294 =====
loc_037FE294:
	bx pc	; 037FE294
	.byte 0xC0, 0x46	; 037FE298
.arm

; ===== function loc_037FE298 =====
loc_037FE298:
	ldr pc,[pool_037FE29C]	; 037FE298
pool_037FE29C:
loc_037FE29C:
	.word loc_037FF54C	; 037FE29C
.thumb

; ===== function loc_037FE2A0 =====
loc_037FE2A0:
	bx pc	; 037FE2A0
	.byte 0xC0, 0x46	; 037FE2A4
.arm

; ===== function loc_037FE2A4 =====
loc_037FE2A4:
	ldr pc,[pool_037FE2A8]	; 037FE2A4
pool_037FE2A8:
loc_037FE2A8:
	.word P2_SaveThreadContext	; 037FE2A8
.thumb

; ===== function loc_037FE2AC =====
loc_037FE2AC:
	bx pc	; 037FE2AC
	.byte 0xC0, 0x46	; 037FE2B0
.arm

; ===== function loc_037FE2B0 =====
loc_037FE2B0:
	ldr pc,[pool_037FE2B4]	; 037FE2B0
pool_037FE2B4:
loc_037FE2B4:
	.word P2_LoadThreadContext	; 037FE2B4
.thumb

; ===== function loc_037FE2B8 =====
loc_037FE2B8:
	ldr r0,[pool_037FE2CC]	; 037FE2B8
	ldr r0,[r0,#0xc]	; 037FE2BA
	b loc_037FE2C0	; 037FE2BC
loc_037FE2BE:
	ldr r0,[r0,#0x4c]	; 037FE2BE
loc_037FE2C0:
	cmp r0,#0x0	; 037FE2C0
	beq loc_037FE2CA	; 037FE2C2
	ldr r1,[r0,#0x48]	; 037FE2C4
	cmp r1,#0x1	; 037FE2C6
	bne loc_037FE2BE	; 037FE2C8
loc_037FE2CA:
	bx lr	; 037FE2CA
pool_037FE2CC:
loc_037FE2CC:
	.word P2_BssStart + 0x74C	; 037FE2CC

; ===== function loc_037FE2D0 =====
loc_037FE2D0:
	push {r4,r5,lr}	; 037FE2D0
	sub sp,#0x4	; 037FE2D2
	add r5,r0,#0x0	; 037FE2D4
	bl loc_037FE0D0	; 037FE2D6
	add r4,r0,#0x0	; 037FE2DA
	mov r0,#0x1	; 037FE2DC
	str r0,[r5,#0x48]	; 037FE2DE
	bl loc_037FE224	; 037FE2E0
	add r0,r4,#0x0	; 037FE2E4
	bl loc_037FE0F4	; 037FE2E6
	add sp,#0x4	; 037FE2EA
	pop {r4,r5}	; 037FE2EC
	pop {r3}	; 037FE2EE
	bx r3	; 037FE2F0
	.byte 0x00, 0x00	; 037FE2F4

; ===== function loc_037FE2F4 =====
loc_037FE2F4:
	push {r4,r5,r6,lr}	; 037FE2F4
	add r5,r0,#0x0	; 037FE2F6
	bl loc_037FE0D0	; 037FE2F8
	add r4,r0,#0x0	; 037FE2FC
	ldrh r1,[r5,#0x0]	; 037FE2FE
	cmp r1,#0x0	; 037FE300
	beq loc_037FE32A	; 037FE302
	ldr r0,[pool_037FE338]	; 037FE304
	ldr r0,[r0,#0xc]	; 037FE306
	mov r3,#0x1	; 037FE308
	b loc_037FE31E	; 037FE30A
loc_037FE30C:
	ldr r2,[r0,#0x50]	; 037FE30C
	add r6,r3,#0x0	; 037FE30E
	lsl r6,r2	; 037FE310
	add r2,r1,#0x0	; 037FE312
	and r2,r6	; 037FE314
	cmp r2,#0x0	; 037FE316
	beq loc_037FE31C	; 037FE318
	str r3,[r0,#0x48]	; 037FE31A
loc_037FE31C:
	ldr r0,[r0,#0x4c]	; 037FE31C
loc_037FE31E:
	cmp r0,#0x0	; 037FE31E
	bne loc_037FE30C	; 037FE320
	mov r0,#0x0	; 037FE322
	strh r0,[r5,#0x0]	; 037FE324
	bl loc_037FE224	; 037FE326
loc_037FE32A:
	add r0,r4,#0x0	; 037FE32A
	bl loc_037FE0F4	; 037FE32C
	pop {r4,r5,r6}	; 037FE330
	pop {r3}	; 037FE332
	bx r3	; 037FE334
	.byte 0xC0, 0x46	; 037FE338
pool_037FE338:
loc_037FE338:
	.word P2_BssStart + 0x74C	; 037FE338

; ===== function loc_037FE33C =====
loc_037FE33C:
	push {r4,r5,lr}	; 037FE33C
	sub sp,#0x4	; 037FE33E
	add r5,r0,#0x0	; 037FE340
	bl loc_037FE0D0	; 037FE342
	add r4,r0,#0x0	; 037FE346
	ldr r0,[pool_037FE378]	; 037FE348
	ldr r0,[r0,#0x0]	; 037FE34A
	ldr r1,[r0,#0x0]	; 037FE34C
	cmp r5,#0x0	; 037FE34E
	beq loc_037FE362	; 037FE350
	ldrh r0,[r5,#0x0]	; 037FE352
	mov r3,#0x1	; 037FE354
	ldr r2,[r1,#0x50]	; 037FE356
	lsl r3,r2	; 037FE358
	lsl r2,r3,#0x10	; 037FE35A
	lsr r2,r2,#0x10	; 037FE35C
	orr r0,r2	; 037FE35E
	strh r0,[r5,#0x0]	; 037FE360
loc_037FE362:
	mov r0,#0x0	; 037FE362
	str r0,[r1,#0x48]	; 037FE364
	bl loc_037FE224	; 037FE366
	add r0,r4,#0x0	; 037FE36A
	bl loc_037FE0F4	; 037FE36C
	add sp,#0x4	; 037FE370
	pop {r4,r5}	; 037FE372
	pop {r3}	; 037FE374
	bx r3	; 037FE376
pool_037FE378:
loc_037FE378:
	.word P2_BssStart + 0x744	; 037FE378
P2_Entry_037FE37C:
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P2_ExitThread
	push {r4,lr}	; 037FE37C
	bl loc_037FE0D0	; 037FE37E
	ldr r0,[pool_037FE3B4]	; 037FE382
	ldr r0,[r0,#0x0]	; 037FE384
	ldr r4,[r0,#0x0]	; 037FE386
	add r0,r4,#0x0	; 037FE388
	bl loc_037FE7A8	; 037FE38A
	add r0,r4,#0x0	; 037FE38E
	bl loc_037FE52C	; 037FE390
	mov r2,#0x0	; 037FE394
	ldr r0,[r4,#0x50]	; 037FE396
	lsl r1,r0,#0x2	; 037FE398
	ldr r0,[pool_037FE3B8]	; 037FE39A
	str r2,[r0,r1]	; 037FE39C
	mov r0,#0x2	; 037FE39E
	str r0,[r4,#0x48]	; 037FE3A0
	add r4,#0x74	; 037FE3A2
	add r0,r4,#0x0	; 037FE3A4
	bl loc_037FE2F4	; 037FE3A6
	bl loc_037FE224	; 037FE3AA
	pop {r4}	; 037FE3AE
	pop {r3}	; 037FE3B0
	bx r3	; 037FE3B2
.endfunc
pool_037FE3B4:
loc_037FE3B4:
	.word P2_BssStart + 0x744	; 037FE3B4
pool_037FE3B8:
loc_037FE3B8:
	.word P2_BssStart + 0x760	; 037FE3B8

; ===== function loc_037FE3BC =====
loc_037FE3BC:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P2_CreateThread
	push {r4,r5,r6,r7,lr}	; 037FE3BC
	sub sp,#0xc	; 037FE3BE
	add r5,r0,#0x0	; 037FE3C0
	str r1,[sp,#0x0]	; 037FE3C2
	add r7,r2,#0x0	; 037FE3C4
	add r4,r3,#0x0	; 037FE3C6
	bl loc_037FE0D0	; 037FE3C8
	str r0,[sp,#0x4]	; 037FE3CC
	bl loc_037FE594	; 037FE3CE
	cmp r0,#0x0	; 037FE3D2
	bge loc_037FE3DE	; 037FE3D4
	ldr r0,[sp,#0x4]	; 037FE3D6
	bl loc_037FE0F4	; 037FE3D8
	b loc_037FE43C	; 037FE3DC
loc_037FE3DE:
	ldr r1,[sp,#0x24]	; 037FE3DE
	str r1,[r5,#0x54]	; 037FE3E0
	str r0,[r5,#0x50]	; 037FE3E2
	mov r1,#0x0	; 037FE3E4
	str r1,[r5,#0x48]	; 037FE3E6
	lsl r1,r0,#0x2	; 037FE3E8
	ldr r0,[pool_037FE444]	; 037FE3EA
	str r5,[r0,r1]	; 037FE3EC
	add r0,r5,#0x0	; 037FE3EE
	bl loc_037FE558	; 037FE3F0
	str r4,[r5,#0x6c]	; 037FE3F4
	ldr r0,[sp,#0x20]	; 037FE3F6
	sub r6,r4,r0	; 037FE3F8
	str r6,[r5,#0x68]	; 037FE3FA
	mov r0,#0x0	; 037FE3FC
	str r0,[r5,#0x70]	; 037FE3FE
	ldr r1,[pool_037FE448]	; 037FE400
	ldr r0,[r5,#0x6c]	; 037FE402
	sub r0,r0,#0x4	; 037FE404
	str r1,[r0,#0x0]	; 037FE406
	ldr r1,[pool_037FE44C]	; 037FE408
	ldr r0,[r5,#0x68]	; 037FE40A
	str r1,[r0,#0x0]	; 037FE40C
	add r0,r5,#0x0	; 037FE40E
	ldr r1,[sp,#0x0]	; 037FE410
	sub r2,r4,#0x4	; 037FE412
	bl loc_037FE454	; 037FE414
	str r7,[r5,#ThreadContextR0Offset]	; 037FE418
	ldr r0,[pool_037FE450]	; 037FE41A
	str r0,[r5,#ThreadContextLrOffset]	; 037FE41C
	mov r0,#0x0	; 037FE41E
	str r0,[sp,#0x8]	; 037FE420
	ldr r0,[sp,#0x8]	; 037FE422
	add r1,r6,#0x4	; 037FE424
	ldr r2,[sp,#0x20]	; 037FE426
	sub r2,#0x8	; 037FE428
	bl loc_037FE460	; 037FE42A
	mov r0,#0x0	; 037FE42E
	str r0,[r5,#0x5c]	; 037FE430
	str r0,[r5,#0x60]	; 037FE432
	str r0,[r5,#0x64]	; 037FE434
	ldr r0,[sp,#0x4]	; 037FE436
	bl loc_037FE0F4	; 037FE438
loc_037FE43C:
	add sp,#0xc	; 037FE43C
	pop {r4,r5,r6,r7}	; 037FE43E
	pop {r3}	; 037FE440
	bx r3	; 037FE442
.endfunc
pool_037FE444:
loc_037FE444:
	.word P2_BssStart + 0x760	; 037FE444
pool_037FE448:
loc_037FE448:
	.word 0xD73BFDF7	; 037FE448
pool_037FE44C:
loc_037FE44C:
	.word 0xFBDD37BB	; 037FE44C
pool_037FE450:
loc_037FE450:
	.word P2_ExitThread + 1	; 037FE450

; ===== function loc_037FE454 =====
loc_037FE454:
	bx pc	; 037FE454
	.byte 0xC0, 0x46	; 037FE458
.arm

; ===== function loc_037FE458 =====
loc_037FE458:
	ldr pc,[pool_037FE45C]	; 037FE458
pool_037FE45C:
loc_037FE45C:
	.word P2_InitThreadContext	; 037FE45C
.thumb

; ===== function loc_037FE460 =====
loc_037FE460:
	bx pc	; 037FE460
	.byte 0xC0, 0x46	; 037FE464
.arm

; ===== function loc_037FE464 =====
loc_037FE464:
	ldr pc,[pool_037FE468]	; 037FE464
pool_037FE468:
loc_037FE468:
	.word loc_037FF740	; 037FE468
.thumb

; ===== function loc_037FE46C =====
loc_037FE46C:
	push {lr}	; 037FE46C
	sub sp,#0x4	; 037FE46E
	ldr r0,[pool_037FE4F8]	; 037FE470
	ldr r1,[r0,#0x0]	; 037FE472
	cmp r1,#0x0	; 037FE474
	bne loc_037FE4F0	; 037FE476
	mov r1,#0x1	; 037FE478
	str r1,[r0,#0x0]	; 037FE47A
	mov r3,#0x0	; 037FE47C
	add r1,r3,#0x0	; 037FE47E
	ldr r0,[pool_037FE4FC]	; 037FE480
loc_037FE482:
	lsl r2,r3,#0x2	; 037FE482
	add r2,r0,r2	; 037FE484
	str r1,[r2,#0x14]	; 037FE486
	add r3,r3,#0x1	; 037FE488
	cmp r3,#0x10	; 037FE48A
	blt loc_037FE482	; 037FE48C
	ldr r3,[pool_037FE500]	; 037FE48E
	ldr r2,[pool_037FE504]	; 037FE490
	str r3,[r2,#0x0]	; 037FE492
	mov r3,#0x10	; 037FE494
	ldr r2,[pool_037FE508]	; 037FE496
	str r3,[r2,#0x54]	; 037FE498
	str r1,[r2,#0x50]	; 037FE49A
	mov r3,#0x1	; 037FE49C
	str r3,[r2,#0x48]	; 037FE49E
	str r1,[r2,#0x4c]	; 037FE4A0
	str r1,[r2,#0x58]	; 037FE4A2
	str r2,[r0,#0x14]	; 037FE4A4
	str r2,[r0,#0xc]	; 037FE4A6
	str r2,[r0,#0x8]	; 037FE4A8
	ldr r2,[pool_037FE50C]	; 037FE4AA
	cmp r2,#0x0	; 037FE4AC
	bne loc_037FE4B6	; 037FE4AE
	ldr r0,[pool_037FE510]	; 037FE4B0
	sub r3,r0,r2	; 037FE4B2
	b loc_037FE4BE	; 037FE4B4
loc_037FE4B6:
	ldr r1,[pool_037FE514]	; 037FE4B6
	ldr r0,[pool_037FE518]	; 037FE4B8
	sub r0,r0,r1	; 037FE4BA
	sub r3,r0,r2	; 037FE4BC
loc_037FE4BE:
	ldr r1,[pool_037FE514]	; 037FE4BE
	ldr r0,[pool_037FE518]	; 037FE4C0
	sub r1,r0,r1	; 037FE4C2
	ldr r2,[pool_037FE508]	; 037FE4C4
	str r1,[r2,#0x6c]	; 037FE4C6
	str r3,[r2,#0x68]	; 037FE4C8
	mov r0,#0x0	; 037FE4CA
	str r0,[r2,#0x70]	; 037FE4CC
	ldr r3,[pool_037FE51C]	; 037FE4CE
	sub r1,r1,#0x4	; 037FE4D0
	str r3,[r1,#0x0]	; 037FE4D2
	ldr r3,[pool_037FE520]	; 037FE4D4
	ldr r1,[r2,#0x68]	; 037FE4D6
	str r3,[r1,#0x0]	; 037FE4D8
	ldr r1,[pool_037FE524]	; 037FE4DA
	strh r0,[r1,#0x34]	; 037FE4DC
	mov r2,#0x10	; 037FE4DE
	ldr r1,[pool_037FE4FC]	; 037FE4E0
	strh r2,[r1,#0x2]	; 037FE4E2
	strh r0,[r1,#0x0]	; 037FE4E4
	strh r0,[r1,#0x4]	; 037FE4E6
	ldr r2,[pool_037FE528]	; 037FE4E8
	str r1,[r2,#0x0]	; 037FE4EA
	bl loc_037FE200	; 037FE4EC
loc_037FE4F0:
	add sp,#0x4	; 037FE4F0
	pop {r3}	; 037FE4F2
	bx r3	; 037FE4F4
	.byte 0xC0, 0x46	; 037FE4F8
pool_037FE4F8:
loc_037FE4F8:
	.word P2_BssStart + 0x748	; 037FE4F8
pool_037FE4FC:
loc_037FE4FC:
	.word P2_BssStart + 0x74C	; 037FE4FC
pool_037FE500:
loc_037FE500:
	.word 0x03805ED0	; 037FE500
pool_037FE504:
loc_037FE504:
	.word P2_BssStart + 0x744	; 037FE504
pool_037FE508:
loc_037FE508:
	.word P2_BssStart + 0x7A0	; 037FE508
pool_037FE50C:
loc_037FE50C:
	.word 0x00000400	; 037FE50C
pool_037FE510:
loc_037FE510:
	.word 0x037F8000	; 037FE510
pool_037FE514:
loc_037FE514:
	.word 0x00000200	; 037FE514
pool_037FE518:
loc_037FE518:
	.word 0x0380FF80	; 037FE518
pool_037FE51C:
loc_037FE51C:
	.word 0xD73BFDF7	; 037FE51C
pool_037FE520:
loc_037FE520:
	.word 0xFBDD37BB	; 037FE520
pool_037FE524:
loc_037FE524:
	.word P2_BssStart + 0x7E0	; 037FE524
pool_037FE528:
loc_037FE528:
	.word FirmwareSystemWorkAddress + SystemWorkArm7ThreadInfoOffset	; 037FE528

; ===== function loc_037FE52C =====
loc_037FE52C:
	ldr r1,[pool_037FE554]	; 037FE52C
	ldr r2,[r1,#0xc]	; 037FE52E
	mov r1,#0x0	; 037FE530
	b loc_037FE538	; 037FE532
loc_037FE534:
	add r1,r2,#0x0	; 037FE534
	ldr r2,[r2,#0x4c]	; 037FE536
loc_037FE538:
	cmp r2,#0x0	; 037FE538
	beq loc_037FE540	; 037FE53A
	cmp r2,r0	; 037FE53C
	bne loc_037FE534	; 037FE53E
loc_037FE540:
	cmp r1,#0x0	; 037FE540
	bne loc_037FE54C	; 037FE542
	ldr r1,[r0,#0x4c]	; 037FE544
	ldr r0,[pool_037FE554]	; 037FE546
	str r1,[r0,#0xc]	; 037FE548
	bx lr	; 037FE54A
loc_037FE54C:
	ldr r0,[r0,#0x4c]	; 037FE54C
	str r0,[r1,#0x4c]	; 037FE54E
	bx lr	; 037FE550
	.byte 0xC0, 0x46	; 037FE554
pool_037FE554:
loc_037FE554:
	.word P2_BssStart + 0x74C	; 037FE554

; ===== function loc_037FE558 =====
loc_037FE558:
	push {r4,r5,lr}	; 037FE558
	sub sp,#0x4	; 037FE55A
	ldr r1,[pool_037FE590]	; 037FE55C
	ldr r3,[r1,#0xc]	; 037FE55E
	add r5,r3,#0x0	; 037FE560
	mov r4,#0x0	; 037FE562
	b loc_037FE56A	; 037FE564
loc_037FE566:
	add r4,r5,#0x0	; 037FE566
	ldr r5,[r5,#0x4c]	; 037FE568
loc_037FE56A:
	cmp r5,#0x0	; 037FE56A
	beq loc_037FE576	; 037FE56C
	ldr r2,[r5,#0x54]	; 037FE56E
	ldr r1,[r0,#0x54]	; 037FE570
	cmp r2,r1	; 037FE572
	bcc loc_037FE566	; 037FE574
loc_037FE576:
	cmp r4,#0x0	; 037FE576
	bne loc_037FE582	; 037FE578
	str r3,[r0,#0x4c]	; 037FE57A
	ldr r1,[pool_037FE590]	; 037FE57C
	str r0,[r1,#0xc]	; 037FE57E
	b loc_037FE588	; 037FE580
loc_037FE582:
	ldr r1,[r4,#0x4c]	; 037FE582
	str r1,[r0,#0x4c]	; 037FE584
	str r0,[r4,#0x4c]	; 037FE586
loc_037FE588:
	add sp,#0x4	; 037FE588
	pop {r4,r5}	; 037FE58A
	pop {r3}	; 037FE58C
	bx r3	; 037FE58E
pool_037FE590:
loc_037FE590:
	.word P2_BssStart + 0x74C	; 037FE590

; ===== function loc_037FE594 =====
loc_037FE594:
	mov r0,#0x0	; 037FE594
	ldr r2,[pool_037FE5B0]	; 037FE596
	b loc_037FE5A6	; 037FE598
loc_037FE59A:
	lsl r1,r0,#0x2	; 037FE59A
	add r1,r2,r1	; 037FE59C
	ldr r1,[r1,#0x14]	; 037FE59E
	cmp r1,#0x0	; 037FE5A0
	beq loc_037FE5AE	; 037FE5A2
	add r0,r0,#0x1	; 037FE5A4
loc_037FE5A6:
	cmp r0,#0x10	; 037FE5A6
	blt loc_037FE59A	; 037FE5A8
	mov r0,#0x0	; 037FE5AA
	mvn r0,r0	; 037FE5AC
loc_037FE5AE:
	bx lr	; 037FE5AE
pool_037FE5B0:
loc_037FE5B0:
	.word 0x03805EC8	; 037FE5B0
.arm

; ===== function loc_037FE5B4 =====
loc_037FE5B4:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P2_InitThreadContext
	add r1,r1,#0x4	; 037FE5B4
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 037FE5B8
	str r2,[r0,#ThreadContextSvcSpOffset]	; 037FE5BC
	sub r2,r2,#ThreadContextSvcStackBytes	; 037FE5C0
	str r2,[r0,#ThreadContextSpOffset]	; 037FE5C4
	ands r1,r1,#0x1	; 037FE5C8
	movne r1,#0x3f	; 037FE5CC
	moveq r1,#0x1f	; 037FE5D0
	str r1,[r0,#ThreadContextCpsrOffset]	; 037FE5D4
	mov r1,#0x0	; 037FE5D8
	str r1,[r0,#ThreadContextR0Offset]	; 037FE5DC
	str r1,[r0,#0x8]	; 037FE5E0
	str r1,[r0,#0xc]	; 037FE5E4
	str r1,[r0,#0x10]	; 037FE5E8
	str r1,[r0,#0x14]	; 037FE5EC
	str r1,[r0,#0x18]	; 037FE5F0
	str r1,[r0,#0x1c]	; 037FE5F4
	str r1,[r0,#0x20]	; 037FE5F8
	str r1,[r0,#0x24]	; 037FE5FC
	str r1,[r0,#0x28]	; 037FE600
	str r1,[r0,#0x2c]	; 037FE604
	str r1,[r0,#0x30]	; 037FE608
	str r1,[r0,#0x34]	; 037FE60C
	str r1,[r0,#ThreadContextLrOffset]	; 037FE610
	bx lr	; 037FE614
.endfunc

; ===== function loc_037FE618 =====
loc_037FE618:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P2_SaveThreadContext
	add r1,r0,#0x0	; 037FE618
	mrs r2,cpsr	; 037FE61C
	str r2,[r1],#0x4	; 037FE620
	mov r0,#0xd3	; 037FE624
	msr cpsr_c,r0	; 037FE628
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE62C
	msr cpsr_c,r2	; 037FE630
	mov r0,#0x1	; 037FE634
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FE638
	adr r0,P2_SaveThreadContextReturn + 4	; 037FE63C
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE640
	mov r0,#0x0	; 037FE644
P2_SaveThreadContextReturn:
	bx lr	; 037FE648
.endfunc

; ===== function loc_037FE64C =====
loc_037FE64C:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P2_LoadThreadContext
	mrs r1,cpsr	; 037FE64C
	bic r1,r1,#0x1f	; 037FE650
	orr r1,r1,#0xd3	; 037FE654
	msr cpsr_c,r1	; 037FE658
	ldr r1,[r0],#0x4	; 037FE65C
	msr spsr_cxsf,r1	; 037FE660
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 037FE664
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 037FE668
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FE66C
	mov r0,r0	; 037FE670
	subs pc,lr,#0x4	; 037FE674
.endfunc
.thumb

; ===== function loc_037FE678 =====
loc_037FE678:
	push {r4,r5,r6,r7,lr}	; 037FE678
	sub sp,#0x4	; 037FE67A
	add r5,r0,#0x0	; 037FE67C
	add r6,r1,#0x0	; 037FE67E
	add r4,r2,#0x0	; 037FE680
	bl loc_037FE0D0	; 037FE682
	add r7,r0,#0x0	; 037FE686
	mov r0,#0x1	; 037FE688
	and r4,r0	; 037FE68A
	add r0,r5,#0x2	; 037FE68C
	str r0,[sp,#0x0]	; 037FE68E
	b loc_037FE6A6	; 037FE690
loc_037FE692:
	cmp r4,#0x0	; 037FE692
	bne loc_037FE6A0	; 037FE694
	add r0,r7,#0x0	; 037FE696
	bl loc_037FE0F4	; 037FE698
	mov r0,#0x0	; 037FE69C
	b loc_037FE6DA	; 037FE69E
loc_037FE6A0:
	ldr r0,[sp,#0x0]	; 037FE6A0
	bl loc_037FE33C	; 037FE6A2
loc_037FE6A6:
	ldr r0,[r5,#0x10]	; 037FE6A6
	cmp r0,#0x0	; 037FE6A8
	beq loc_037FE692	; 037FE6AA
	cmp r6,#0x0	; 037FE6AC
	beq loc_037FE6BA	; 037FE6AE
	ldr r1,[r5,#0x4]	; 037FE6B0
	ldr r0,[r5,#0xc]	; 037FE6B2
	lsl r0,r0,#0x2	; 037FE6B4
	ldr r0,[r1,r0]	; 037FE6B6
	str r0,[r6,#0x0]	; 037FE6B8
loc_037FE6BA:
	ldr r0,[r5,#0xc]	; 037FE6BA
	add r0,r0,#0x1	; 037FE6BC
	ldr r1,[r5,#0x8]	; 037FE6BE
	bl loc_037FE6E4	; 037FE6C0
	str r1,[r5,#0xc]	; 037FE6C4
	ldr r0,[r5,#0x10]	; 037FE6C6
	sub r0,r0,#0x1	; 037FE6C8
	str r0,[r5,#0x10]	; 037FE6CA
	add r0,r5,#0x0	; 037FE6CC
	bl loc_037FE2F4	; 037FE6CE
	add r0,r7,#0x0	; 037FE6D2
	bl loc_037FE0F4	; 037FE6D4
	mov r0,#0x1	; 037FE6D8
loc_037FE6DA:
	add sp,#0x4	; 037FE6DA
	pop {r4,r5,r6,r7}	; 037FE6DC
	pop {r3}	; 037FE6DE
	bx r3	; 037FE6E0
	.byte 0xC0, 0x46	; 037FE6E4

; ===== function loc_037FE6E4 =====
loc_037FE6E4:
	bx pc	; 037FE6E4
	.byte 0xC0, 0x46	; 037FE6E8
.arm

; ===== function loc_037FE6E8 =====
loc_037FE6E8:
	ldr pc,[pool_037FE6EC]	; 037FE6E8
pool_037FE6EC:
loc_037FE6EC:
	.word P2_SignedDivMod	; 037FE6EC
.thumb

; ===== function loc_037FE6F0 =====
loc_037FE6F0:
	push {r4,r5,r6,r7,lr}	; 037FE6F0
	sub sp,#0x4	; 037FE6F2
	add r5,r0,#0x0	; 037FE6F4
	add r6,r1,#0x0	; 037FE6F6
	add r4,r2,#0x0	; 037FE6F8
	bl loc_037FE0D0	; 037FE6FA
	add r7,r0,#0x0	; 037FE6FE
	mov r0,#0x1	; 037FE700
	and r4,r0	; 037FE702
	b loc_037FE71A	; 037FE704
loc_037FE706:
	cmp r4,#0x0	; 037FE706
	bne loc_037FE714	; 037FE708
	add r0,r7,#0x0	; 037FE70A
	bl loc_037FE0F4	; 037FE70C
	mov r0,#0x0	; 037FE710
	b loc_037FE744	; 037FE712
loc_037FE714:
	add r0,r5,#0x0	; 037FE714
	bl loc_037FE33C	; 037FE716
loc_037FE71A:
	ldr r2,[r5,#0x10]	; 037FE71A
	ldr r1,[r5,#0x8]	; 037FE71C
	cmp r1,r2	; 037FE71E
	ble loc_037FE706	; 037FE720
	ldr r0,[r5,#0xc]	; 037FE722
	add r0,r0,r2	; 037FE724
	bl loc_037FE6E4	; 037FE726
	ldr r2,[r5,#0x4]	; 037FE72A
	lsl r0,r1,#0x2	; 037FE72C
	str r6,[r2,r0]	; 037FE72E
	ldr r0,[r5,#0x10]	; 037FE730
	add r0,r0,#0x1	; 037FE732
	str r0,[r5,#0x10]	; 037FE734
	add r0,r5,#0x2	; 037FE736
	bl loc_037FE2F4	; 037FE738
	add r0,r7,#0x0	; 037FE73C
	bl loc_037FE0F4	; 037FE73E
	mov r0,#0x1	; 037FE742
loc_037FE744:
	add sp,#0x4	; 037FE744
	pop {r4,r5,r6,r7}	; 037FE746
	pop {r3}	; 037FE748
	bx r3	; 037FE74A

; ===== function loc_037FE74C =====
loc_037FE74C:
	mov r3,#0x0	; 037FE74C
	strh r3,[r0,#0x0]	; 037FE74E
	strh r3,[r0,#0x2]	; 037FE750
	str r1,[r0,#0x4]	; 037FE752
	str r2,[r0,#0x8]	; 037FE754
	str r3,[r0,#0xc]	; 037FE756
	str r3,[r0,#0x10]	; 037FE758
	bx lr	; 037FE75A

; ===== function loc_037FE75C =====
loc_037FE75C:
	ldr r3,[r0,#0x60]	; 037FE75C
	ldr r2,[r3,#0x10]	; 037FE75E
	cmp r2,#0x0	; 037FE760
	bne loc_037FE76A	; 037FE762
	mov r1,#0x0	; 037FE764
	str r1,[r0,#0x64]	; 037FE766
	b loc_037FE76E	; 037FE768
loc_037FE76A:
	mov r1,#0x0	; 037FE76A
	str r1,[r2,#0xc]	; 037FE76C
loc_037FE76E:
	str r2,[r0,#0x60]	; 037FE76E
	add r0,r3,#0x0	; 037FE770
	bx lr	; 037FE772
P2_Entry_037FE774:
	ldr r2,[r1,#0x10]	; 037FE774
	ldr r1,[r1,#0xc]	; 037FE776
	cmp r2,#0x0	; 037FE778
	bne P2_Entry_037FE780	; 037FE77A
	str r1,[r0,#0x64]	; 037FE77C
	b P2_Entry_037FE782	; 037FE77E
P2_Entry_037FE780:
	str r1,[r2,#0xc]	; 037FE780
P2_Entry_037FE782:
	cmp r1,#0x0	; 037FE782
	bne P2_Entry_037FE78A	; 037FE784
	str r2,[r0,#0x60]	; 037FE786
	bx lr	; 037FE788
P2_Entry_037FE78A:
	str r2,[r1,#0x10]	; 037FE78A
	bx lr	; 037FE78C
	.byte 0x00, 0x00	; 037FE78E
P2_Entry_037FE790:
	ldr r3,[r0,#0x64]	; 037FE790
	cmp r3,#0x0	; 037FE792
	bne P2_Entry_037FE79A	; 037FE794
	str r1,[r0,#0x60]	; 037FE796
	b P2_Entry_037FE79E	; 037FE798
P2_Entry_037FE79A:
	ldr r2,[r0,#0x60]	; 037FE79A
	str r1,[r2,#0x10]	; 037FE79C
P2_Entry_037FE79E:
	str r3,[r1,#0xc]	; 037FE79E
	mov r2,#0x0	; 037FE7A0
	str r2,[r1,#0x10]	; 037FE7A2
	str r1,[r0,#0x64]	; 037FE7A4
	bx lr	; 037FE7A6

; ===== function loc_037FE7A8 =====
loc_037FE7A8:
	push {r4,r5,lr}	; 037FE7A8
	sub sp,#0x4	; 037FE7AA
	add r5,r0,#0x0	; 037FE7AC
	mov r4,#0x0	; 037FE7AE
	b loc_037FE7C0	; 037FE7B0
loc_037FE7B2:
	add r0,r5,#0x0	; 037FE7B2
	bl loc_037FE75C	; 037FE7B4
	str r4,[r0,#0x8]	; 037FE7B8
	str r4,[r0,#0x4]	; 037FE7BA
	bl loc_037FE2F4	; 037FE7BC
loc_037FE7C0:
	ldr r0,[r5,#0x60]	; 037FE7C0
	cmp r0,#0x0	; 037FE7C2
	bne loc_037FE7B2	; 037FE7C4
	add sp,#0x4	; 037FE7C6
	pop {r4,r5}	; 037FE7C8
	pop {r3}	; 037FE7CA
	bx r3	; 037FE7CC
	.byte 0x00, 0x00	; 037FE7CE
P2_Entry_037FE7D0:
	push {r4,r5,lr}	; 037FE7D0
	sub sp,#0x4	; 037FE7D2
	add r5,r0,#0x0	; 037FE7D4
	bl loc_037FE0D0	; 037FE7D6
	add r4,r0,#0x0	; 037FE7DA
	ldr r0,[pool_037FE810]	; 037FE7DC
	ldr r0,[r0,#0x8]	; 037FE7DE
	ldr r1,[r5,#0x4]	; 037FE7E0
	cmp r1,r0	; 037FE7E2
	bne P2_Entry_037FE802	; 037FE7E4
	ldr r1,[r5,#0x8]	; 037FE7E6
	sub r1,r1,#0x1	; 037FE7E8
	str r1,[r5,#0x8]	; 037FE7EA
	ldr r1,[r5,#0x8]	; 037FE7EC
	cmp r1,#0x0	; 037FE7EE
	bne P2_Entry_037FE802	; 037FE7F0
	add r1,r5,#0x0	; 037FE7F2
	bl P2_Entry_037FE774	; 037FE7F4
	mov r0,#0x0	; 037FE7F8
	str r0,[r5,#0x4]	; 037FE7FA
	add r0,r5,#0x0	; 037FE7FC
	bl loc_037FE2F4	; 037FE7FE
P2_Entry_037FE802:
	add r0,r4,#0x0	; 037FE802
	bl loc_037FE0F4	; 037FE804
	add sp,#0x4	; 037FE808
	pop {r4,r5}	; 037FE80A
	pop {r3}	; 037FE80C
	bx r3	; 037FE80E
pool_037FE810:
	.word P2_BssStart + 0x74C	; 037FE810
P2_Entry_037FE814:
	push {r4,r5,r6,r7,lr}	; 037FE814
	sub sp,#0x4	; 037FE816
	add r5,r0,#0x0	; 037FE818
	bl loc_037FE0D0	; 037FE81A
	add r6,r0,#0x0	; 037FE81E
	ldr r0,[pool_037FE864]	; 037FE820
	ldr r4,[r0,#0x8]	; 037FE822
	mov r7,#0x0	; 037FE824
P2_Entry_037FE826:
	ldr r0,[r5,#0x4]	; 037FE826
	cmp r0,#0x0	; 037FE828
	bne P2_Entry_037FE83E	; 037FE82A
	str r4,[r5,#0x4]	; 037FE82C
	ldr r0,[r5,#0x8]	; 037FE82E
	add r0,r0,#0x1	; 037FE830
	str r0,[r5,#0x8]	; 037FE832
	add r0,r4,#0x0	; 037FE834
	add r1,r5,#0x0	; 037FE836
	bl P2_Entry_037FE790	; 037FE838
	b P2_Entry_037FE856	; 037FE83C
P2_Entry_037FE83E:
	cmp r0,r4	; 037FE83E
	bne P2_Entry_037FE84A	; 037FE840
	ldr r0,[r5,#0x8]	; 037FE842
	add r0,r0,#0x1	; 037FE844
	str r0,[r5,#0x8]	; 037FE846
	b P2_Entry_037FE856	; 037FE848
P2_Entry_037FE84A:
	str r5,[r4,#0x5c]	; 037FE84A
	add r0,r5,#0x0	; 037FE84C
	bl loc_037FE33C	; 037FE84E
	str r7,[r4,#0x5c]	; 037FE852
	b P2_Entry_037FE826	; 037FE854
P2_Entry_037FE856:
	add r0,r6,#0x0	; 037FE856
	bl loc_037FE0F4	; 037FE858
	add sp,#0x4	; 037FE85C
	pop {r4,r5,r6,r7}	; 037FE85E
	pop {r3}	; 037FE860
	bx r3	; 037FE862
pool_037FE864:
	.word P2_BssStart + 0x74C	; 037FE864
P2_Entry_037FE868:
	mov r1,#0x0	; 037FE868
	strh r1,[r0,#0x0]	; 037FE86A
	str r1,[r0,#0x4]	; 037FE86C
	str r1,[r0,#0x8]	; 037FE86E
	bx lr	; 037FE870
	.byte 0x00, 0x00	; 037FE872

; ===== function loc_037FE874 =====
loc_037FE874:
	push {lr}	; 037FE874
	sub sp,#0x4	; 037FE876
	bl loc_037FE958	; 037FE878
	bl loc_03802240	; 037FE87C
	bl loc_037FE1B0	; 037FE880
	bl loc_037FDF7C	; 037FE884
	bl loc_037FED30	; 037FE888
	bl loc_037FF038	; 037FE88C
	bl loc_037FE46C	; 037FE890
	bl loc_03804C94	; 037FE894
	add sp,#0x4	; 037FE898
	pop {r3}	; 037FE89A
	bx r3	; 037FE89C
	.byte 0x00, 0x00	; 037FE8A0

; ===== function loc_037FE8A0 =====
loc_037FE8A0:
	lsl r2,r0,#0x2	; 037FE8A0
	ldr r0,[pool_037FE8A8]	; 037FE8A2
	str r1,[r2,r0]	; 037FE8A4
	bx lr	; 037FE8A6
pool_037FE8A8:
loc_037FE8A8:
	.word 0x027FFDA0	; 037FE8A8

; ===== function loc_037FE8AC =====
loc_037FE8AC:
	lsl r2,r0,#0x2	; 037FE8AC
	ldr r0,[pool_037FE8B4]	; 037FE8AE
	str r1,[r2,r0]	; 037FE8B0
	bx lr	; 037FE8B2
pool_037FE8B4:
loc_037FE8B4:
	.word 0x027FFDC4	; 037FE8B4

; ===== function loc_037FE8B8 =====
loc_037FE8B8:
	cmp r0,#0x1	; 037FE8B8
	beq loc_037FE8C6	; 037FE8BA
	cmp r0,#0x7	; 037FE8BC
	beq loc_037FE8CA	; 037FE8BE
	cmp r0,#0x8	; 037FE8C0
	beq loc_037FE8D6	; 037FE8C2
	b loc_037FE8E2	; 037FE8C4
loc_037FE8C6:
	ldr r0,[pool_037FE8E8]	; 037FE8C6
	bx lr	; 037FE8C8
loc_037FE8CA:
	ldr r0,[pool_037FE8EC]	; 037FE8CA
	ldr r1,[pool_037FE8F0]	; 037FE8CC
	cmp r0,r1	; 037FE8CE
	bls loc_037FE8E4	; 037FE8D0
	add r0,r1,#0x0	; 037FE8D2
	bx lr	; 037FE8D4
loc_037FE8D6:
	ldr r0,[pool_037FE8F0]	; 037FE8D6
	ldr r1,[pool_037FE8EC]	; 037FE8D8
	cmp r1,r0	; 037FE8DA
	bls loc_037FE8E4	; 037FE8DC
	add r0,r1,#0x0	; 037FE8DE
	bx lr	; 037FE8E0
loc_037FE8E2:
	mov r0,#0x0	; 037FE8E2
loc_037FE8E4:
	bx lr	; 037FE8E4
	.byte 0xC0, 0x46	; 037FE8E8
pool_037FE8E8:
loc_037FE8E8:
	.word 0x027C0000	; 037FE8E8
pool_037FE8EC:
loc_037FE8EC:
	.word 0x037F8424	; 037FE8EC
pool_037FE8F0:
loc_037FE8F0:
	.word 0x03800000	; 037FE8F0

; ===== function loc_037FE8F4 =====
loc_037FE8F4:
	cmp r0,#0x1	; 037FE8F4
	beq loc_037FE902	; 037FE8F6
	cmp r0,#0x7	; 037FE8F8
	beq loc_037FE906	; 037FE8FA
	cmp r0,#0x8	; 037FE8FC
	beq loc_037FE90A	; 037FE8FE
	b loc_037FE928	; 037FE900
loc_037FE902:
	ldr r0,[pool_037FE92C]	; 037FE902
	bx lr	; 037FE904
loc_037FE906:
	ldr r0,[pool_037FE930]	; 037FE906
	bx lr	; 037FE908
loc_037FE90A:
	ldr r1,[pool_037FE934]	; 037FE90A
	ldr r0,[pool_037FE938]	; 037FE90C
	sub r0,r0,r1	; 037FE90E
	ldr r1,[pool_037FE93C]	; 037FE910
	cmp r1,#0x0	; 037FE912
	bne loc_037FE91A	; 037FE914
	ldr r0,[pool_037FE930]	; 037FE916
	bx lr	; 037FE918
loc_037FE91A:
	cmp r1,#0x0	; 037FE91A
	bge loc_037FE924	; 037FE91C
	ldr r0,[pool_037FE930]	; 037FE91E
	sub r0,r0,r1	; 037FE920
	bx lr	; 037FE922
loc_037FE924:
	sub r0,r0,r1	; 037FE924
	bx lr	; 037FE926
loc_037FE928:
	mov r0,#0x0	; 037FE928
	bx lr	; 037FE92A
pool_037FE92C:
loc_037FE92C:
	.word 0x027FF000	; 037FE92C
pool_037FE930:
loc_037FE930:
	.word 0x03800000	; 037FE930
pool_037FE934:
loc_037FE934:
	.word 0x00000200	; 037FE934
pool_037FE938:
loc_037FE938:
	.word 0x0380FF80	; 037FE938
pool_037FE93C:
loc_037FE93C:
	.word 0x00000400	; 037FE93C
P2_Entry_037FE940:
	lsl r1,r0,#0x2	; 037FE940
	ldr r0,[pool_037FE948]	; 037FE942
	ldr r0,[r1,r0]	; 037FE944
	bx lr	; 037FE946
pool_037FE948:
	.word 0x027FFDA0	; 037FE948
P2_Entry_037FE94C:
	lsl r1,r0,#0x2	; 037FE94C
	ldr r0,[pool_037FE954]	; 037FE94E
	ldr r0,[r1,r0]	; 037FE950
	bx lr	; 037FE952
pool_037FE954:
	.word 0x027FFDC4	; 037FE954

; ===== function loc_037FE958 =====
loc_037FE958:
	push {lr}	; 037FE958
	sub sp,#0x4	; 037FE95A
	ldr r1,[pool_037FE980]	; 037FE95C
	ldr r0,[r1,#0x0]	; 037FE95E
	cmp r0,#0x0	; 037FE960
	bne loc_037FE978	; 037FE962
	mov r0,#0x1	; 037FE964
	str r0,[r1,#0x0]	; 037FE966
	bl loc_037FE984	; 037FE968
	mov r0,#0x7	; 037FE96C
	bl loc_037FE984	; 037FE96E
	mov r0,#0x8	; 037FE972
	bl loc_037FE984	; 037FE974
loc_037FE978:
	add sp,#0x4	; 037FE978
	pop {r3}	; 037FE97A
	bx r3	; 037FE97C
	.byte 0xC0, 0x46	; 037FE980
pool_037FE980:
loc_037FE980:
	.word P2_BssStart + 0x818	; 037FE980

; ===== function loc_037FE984 =====
loc_037FE984:
	push {r4,lr}	; 037FE984
	add r4,r0,#0x0	; 037FE986
	bl loc_037FE8F4	; 037FE988
	add r1,r0,#0x0	; 037FE98C
	add r0,r4,#0x0	; 037FE98E
	bl loc_037FE8AC	; 037FE990
	add r0,r4,#0x0	; 037FE994
	bl loc_037FE8B8	; 037FE996
	add r1,r0,#0x0	; 037FE99A
	add r0,r4,#0x0	; 037FE99C
	bl loc_037FE8A0	; 037FE99E
	pop {r4}	; 037FE9A2
	pop {r3}	; 037FE9A4
	bx r3	; 037FE9A6

; ===== function loc_037FE9A8 =====
P2_Entry_037FE9A8:
	push {r4,r5,r6,r7,lr}	; 037FE9A8
	sub sp,#0xc	; 037FE9AA
	add r4,r0,#0x0	; 037FE9AC
	add r5,r1,#0x0	; 037FE9AE
	add r6,r2,#0x0	; 037FE9B0
	bl loc_037FE0D0	; 037FE9B2
	str r0,[sp,#0x4]	; 037FE9B6
	lsl r1,r4,#0x2	; 037FE9B8
	ldr r0,[pool_037FEA18]	; 037FE9BA
	ldr r1,[r0,r1]	; 037FE9BC
	add r5,#0x1f	; 037FE9BE
	mov r0,#0x1f	; 037FE9C0
	bic r5,r0	; 037FE9C2
	bic r6,r0	; 037FE9C4
	mov r4,#0x0	; 037FE9C6
	ldr r7,[r1,#0x4]	; 037FE9C8
	b loc_037FEA00	; 037FE9CA
loc_037FE9CC:
	ldr r0,[r1,#0x10]	; 037FE9CC
	add r3,r4,#0x0	; 037FE9CE
	str r3,[sp,#0x0]	; 037FE9D0
	mov r2,#0xc	; 037FE9D2
	mul r3,r2	; 037FE9D4
	str r3,[sp,#0x0]	; 037FE9D6
	add r3,r0,r3	; 037FE9D8
	ldr r2,[sp,#0x0]	; 037FE9DA
	ldr r0,[r0,r2]	; 037FE9DC
	cmp r0,#0x0	; 037FE9DE
	bge loc_037FE9FE	; 037FE9E0
	sub r0,r6,r5	; 037FE9E2
	str r0,[r3,#0x0]	; 037FE9E4
	mov r1,#0x0	; 037FE9E6
	str r1,[r5,#0x0]	; 037FE9E8
	str r1,[r5,#0x4]	; 037FE9EA
	ldr r0,[r3,#0x0]	; 037FE9EC
	str r0,[r5,#0x8]	; 037FE9EE
	str r5,[r3,#0x4]	; 037FE9F0
	str r1,[r3,#0x8]	; 037FE9F2
	ldr r0,[sp,#0x4]	; 037FE9F4
	bl loc_037FE0F4	; 037FE9F6
	add r0,r4,#0x0	; 037FE9FA
	b loc_037FEA0E	; 037FE9FC
loc_037FE9FE:
	add r4,r4,#0x1	; 037FE9FE
loc_037FEA00:
	cmp r4,r7	; 037FEA00
	blt loc_037FE9CC	; 037FEA02
	ldr r0,[sp,#0x4]	; 037FEA04
	bl loc_037FE0F4	; 037FEA06
	mov r0,#0x0	; 037FEA0A
	mvn r0,r0	; 037FEA0C
loc_037FEA0E:
	add sp,#0xc	; 037FEA0E
	pop {r4,r5,r6,r7}	; 037FEA10
	pop {r3}	; 037FEA12
	bx r3	; 037FEA14
	.byte 0xC0, 0x46	; 037FEA18
pool_037FEA18:
loc_037FEA18:
	.word P2_BssStart + 0x81C	; 037FEA18
P2_Entry_037FEA1C:
	push {r4,r5,r6,r7,lr}	; 037FEA1C
	sub sp,#0xc	; 037FEA1E
	add r6,r0,#0x0	; 037FEA20
	add r5,r1,#0x0	; 037FEA22
	str r2,[sp,#0x8]	; 037FEA24
	add r4,r3,#0x0	; 037FEA26
	bl loc_037FE0D0	; 037FEA28
	str r0,[sp,#0x0]	; 037FEA2C
	lsl r1,r6,#0x2	; 037FEA2E
	ldr r0,[pool_037FEA94]	; 037FEA30
	str r5,[r0,r1]	; 037FEA32
	add r3,r4,#0x0	; 037FEA34
	mov r0,#0xc	; 037FEA36
	mul r3,r0	; 037FEA38
	add r0,r5,#0x0	; 037FEA3A
	add r0,#0x14	; 037FEA3C
	str r0,[r5,#0x10]	; 037FEA3E
	str r4,[r5,#0x4]	; 037FEA40
	mov r2,#0x0	; 037FEA42
	mvn r0,r2	; 037FEA44
	add r7,r2,#0x0	; 037FEA46
	b P2_Entry_037FEA64	; 037FEA48
P2_Entry_037FEA4A:
	ldr r1,[r5,#0x10]	; 037FEA4A
	add r6,r2,#0x0	; 037FEA4C
	str r6,[sp,#0x4]	; 037FEA4E
	mov r4,#0xc	; 037FEA50
	mul r6,r4	; 037FEA52
	str r6,[sp,#0x4]	; 037FEA54
	add r6,r1,r6	; 037FEA56
	ldr r4,[sp,#0x4]	; 037FEA58
	str r0,[r1,r4]	; 037FEA5A
	str r7,[r6,#0x8]	; 037FEA5C
	ldr r1,[r6,#0x8]	; 037FEA5E
	str r1,[r6,#0x4]	; 037FEA60
	add r2,r2,#0x1	; 037FEA62
P2_Entry_037FEA64:
	ldr r1,[r5,#0x4]	; 037FEA64
	cmp r2,r1	; 037FEA66
	blt P2_Entry_037FEA4A	; 037FEA68
	mov r0,#0x0	; 037FEA6A
	mvn r0,r0	; 037FEA6C
	str r0,[r5,#0x0]	; 037FEA6E
	ldr r0,[r5,#0x10]	; 037FEA70
	add r0,r0,r3	; 037FEA72
	add r0,#0x1f	; 037FEA74
	mov r1,#0x1f	; 037FEA76
	bic r0,r1	; 037FEA78
	str r0,[r5,#0x8]	; 037FEA7A
	ldr r0,[sp,#0x8]	; 037FEA7C
	bic r0,r1	; 037FEA7E
	str r0,[sp,#0x8]	; 037FEA80
	str r0,[r5,#0xc]	; 037FEA82
	ldr r0,[sp,#0x0]	; 037FEA84
	bl loc_037FE0F4	; 037FEA86
	ldr r0,[r5,#0x8]	; 037FEA8A
	add sp,#0xc	; 037FEA8C
	pop {r4,r5,r6,r7}	; 037FEA8E
	pop {r3}	; 037FEA90
	bx r3	; 037FEA92
pool_037FEA94:
	.word P2_BssStart + 0x81C	; 037FEA94
P2_Entry_037FEA98:
	push {r4,r5,lr}	; 037FEA98
	sub sp,#0x4	; 037FEA9A
	add r5,r0,#0x0	; 037FEA9C
	add r4,r1,#0x0	; 037FEA9E
	bl loc_037FE0D0	; 037FEAA0
	lsl r2,r5,#0x2	; 037FEAA4
	ldr r1,[pool_037FEABC]	; 037FEAA6
	ldr r1,[r1,r2]	; 037FEAA8
	ldr r5,[r1,#0x0]	; 037FEAAA
	str r4,[r1,#0x0]	; 037FEAAC
	bl loc_037FE0F4	; 037FEAAE
	add r0,r5,#0x0	; 037FEAB2
	add sp,#0x4	; 037FEAB4
	pop {r4,r5}	; 037FEAB6
	pop {r3}	; 037FEAB8
	bx r3	; 037FEABA
pool_037FEABC:
	.word P2_BssStart + 0x81C	; 037FEABC
P2_Entry_037FEAC0:
	push {r4,r5,r6,r7,lr}	; 037FEAC0
	sub sp,#0x4	; 037FEAC2
	add r6,r0,#0x0	; 037FEAC4
	add r5,r1,#0x0	; 037FEAC6
	add r4,r2,#0x0	; 037FEAC8
	bl loc_037FE0D0	; 037FEACA
	add r7,r0,#0x0	; 037FEACE
	lsl r1,r6,#0x2	; 037FEAD0
	ldr r0,[pool_037FEB08]	; 037FEAD2
	ldr r0,[r0,r1]	; 037FEAD4
	cmp r5,#0x0	; 037FEAD6
	bge P2_Entry_037FEADC	; 037FEAD8
	ldr r5,[r0,#0x0]	; 037FEADA
P2_Entry_037FEADC:
	sub r4,#0x20	; 037FEADC
	ldr r1,[r0,#0x10]	; 037FEADE
	mov r0,#0xc	; 037FEAE0
	mul r5,r0	; 037FEAE2
	add r5,r1,r5	; 037FEAE4
	ldr r0,[r5,#0x8]	; 037FEAE6
	add r1,r4,#0x0	; 037FEAE8
	bl loc_037FEC18	; 037FEAEA
	str r0,[r5,#0x8]	; 037FEAEE
	ldr r0,[r5,#0x4]	; 037FEAF0
	add r1,r4,#0x0	; 037FEAF2
	bl P2_Entry_037FEBB8	; 037FEAF4
	str r0,[r5,#0x4]	; 037FEAF8
	add r0,r7,#0x0	; 037FEAFA
	bl loc_037FE0F4	; 037FEAFC
	add sp,#0x4	; 037FEB00
	pop {r4,r5,r6,r7}	; 037FEB02
	pop {r3}	; 037FEB04
	bx r3	; 037FEB06
pool_037FEB08:
	.word P2_BssStart + 0x81C	; 037FEB08

; ===== function loc_037FEB0C =====
loc_037FEB0C:
	push {r4,r5,r6,r7,lr}	; 037FEB0C
	sub sp,#0x4	; 037FEB0E
	add r6,r0,#0x0	; 037FEB10
	add r4,r1,#0x0	; 037FEB12
	add r5,r2,#0x0	; 037FEB14
	bl loc_037FE0D0	; 037FEB16
	add r7,r0,#0x0	; 037FEB1A
	lsl r2,r6,#0x2	; 037FEB1C
	ldr r1,[pool_037FEBB4]	; 037FEB1E
	ldr r1,[r1,r2]	; 037FEB20
	cmp r1,#0x0	; 037FEB22
	bne loc_037FEB2E	; 037FEB24
	bl loc_037FE0F4	; 037FEB26
	mov r0,#0x0	; 037FEB2A
	b loc_037FEBAC	; 037FEB2C
loc_037FEB2E:
	cmp r4,#0x0	; 037FEB2E
	bge loc_037FEB34	; 037FEB30
	ldr r4,[r1,#0x0]	; 037FEB32
loc_037FEB34:
	ldr r1,[r1,#0x10]	; 037FEB34
	mov r0,#0xc	; 037FEB36
	mul r4,r0	; 037FEB38
	add r6,r1,r4	; 037FEB3A
	add r5,#0x20	; 037FEB3C
	add r5,#0x1f	; 037FEB3E
	mov r0,#0x1f	; 037FEB40
	bic r5,r0	; 037FEB42
	ldr r0,[r6,#0x4]	; 037FEB44
	add r4,r0,#0x0	; 037FEB46
	b loc_037FEB52	; 037FEB48
loc_037FEB4A:
	ldr r1,[r4,#0x8]	; 037FEB4A
	cmp r5,r1	; 037FEB4C
	ble loc_037FEB56	; 037FEB4E
	ldr r4,[r4,#0x4]	; 037FEB50
loc_037FEB52:
	cmp r4,#0x0	; 037FEB52
	bne loc_037FEB4A	; 037FEB54
loc_037FEB56:
	cmp r4,#0x0	; 037FEB56
	bne loc_037FEB64	; 037FEB58
	add r0,r7,#0x0	; 037FEB5A
	bl loc_037FE0F4	; 037FEB5C
	mov r0,#0x0	; 037FEB60
	b loc_037FEBAC	; 037FEB62
loc_037FEB64:
	ldr r1,[r4,#0x8]	; 037FEB64
	sub r1,r1,r5	; 037FEB66
	cmp r1,#0x40	; 037FEB68
	bcs loc_037FEB76	; 037FEB6A
	add r1,r4,#0x0	; 037FEB6C
	bl loc_037FEC18	; 037FEB6E
	str r0,[r6,#0x4]	; 037FEB72
	b loc_037FEB98	; 037FEB74
loc_037FEB76:
	str r5,[r4,#0x8]	; 037FEB76
	add r0,r4,r5	; 037FEB78
	str r1,[r0,#0x8]	; 037FEB7A
	ldr r1,[r4,#0x0]	; 037FEB7C
	str r1,[r4,r5]	; 037FEB7E
	ldr r1,[r4,#0x4]	; 037FEB80
	str r1,[r0,#0x4]	; 037FEB82
	ldr r1,[r0,#0x4]	; 037FEB84
	cmp r1,#0x0	; 037FEB86
	beq loc_037FEB8C	; 037FEB88
	str r0,[r1,#0x0]	; 037FEB8A
loc_037FEB8C:
	ldr r1,[r0,#0x0]	; 037FEB8C
	cmp r1,#0x0	; 037FEB8E
	beq loc_037FEB96	; 037FEB90
	str r0,[r1,#0x4]	; 037FEB92
	b loc_037FEB98	; 037FEB94
loc_037FEB96:
	str r0,[r6,#0x4]	; 037FEB96
loc_037FEB98:
	ldr r0,[r6,#0x8]	; 037FEB98
	add r1,r4,#0x0	; 037FEB9A
	bl loc_037FEC34	; 037FEB9C
	str r0,[r6,#0x8]	; 037FEBA0
	add r0,r7,#0x0	; 037FEBA2
	bl loc_037FE0F4	; 037FEBA4
	add r4,#0x20	; 037FEBA8
	add r0,r4,#0x0	; 037FEBAA
loc_037FEBAC:
	add sp,#0x4	; 037FEBAC
	pop {r4,r5,r6,r7}	; 037FEBAE
	pop {r3}	; 037FEBB0
	bx r3	; 037FEBB2
pool_037FEBB4:
loc_037FEBB4:
	.word P2_BssStart + 0x81C	; 037FEBB4
P2_Entry_037FEBB8:
	push {r4,r5,lr}	; 037FEBB8
	sub sp,#0x4	; 037FEBBA
	add r2,r0,#0x0	; 037FEBBC
	mov r3,#0x0	; 037FEBBE
	b P2_Entry_037FEBCA	; 037FEBC0
P2_Entry_037FEBC2:
	cmp r1,r2	; 037FEBC2
	bls P2_Entry_037FEBCE	; 037FEBC4
	add r3,r2,#0x0	; 037FEBC6
	ldr r2,[r2,#0x4]	; 037FEBC8
P2_Entry_037FEBCA:
	cmp r2,#0x0	; 037FEBCA
	bne P2_Entry_037FEBC2	; 037FEBCC
P2_Entry_037FEBCE:
	str r2,[r1,#0x4]	; 037FEBCE
	str r3,[r1,#0x0]	; 037FEBD0
	cmp r2,#0x0	; 037FEBD2
	beq P2_Entry_037FEBF0	; 037FEBD4
	str r1,[r2,#0x0]	; 037FEBD6
	ldr r5,[r1,#0x8]	; 037FEBD8
	add r4,r1,r5	; 037FEBDA
	cmp r4,r2	; 037FEBDC
	bne P2_Entry_037FEBF0	; 037FEBDE
	ldr r4,[r2,#0x8]	; 037FEBE0
	add r4,r5,r4	; 037FEBE2
	str r4,[r1,#0x8]	; 037FEBE4
	ldr r2,[r2,#0x4]	; 037FEBE6
	str r2,[r1,#0x4]	; 037FEBE8
	cmp r2,#0x0	; 037FEBEA
	beq P2_Entry_037FEBF0	; 037FEBEC
	str r1,[r2,#0x0]	; 037FEBEE
P2_Entry_037FEBF0:
	cmp r3,#0x0	; 037FEBF0
	beq P2_Entry_037FEC0E	; 037FEBF2
	str r1,[r3,#0x4]	; 037FEBF4
	ldr r4,[r3,#0x8]	; 037FEBF6
	add r5,r3,r4	; 037FEBF8
	cmp r5,r1	; 037FEBFA
	bne P2_Entry_037FEC10	; 037FEBFC
	ldr r1,[r1,#0x8]	; 037FEBFE
	add r1,r4,r1	; 037FEC00
	str r1,[r3,#0x8]	; 037FEC02
	str r2,[r3,#0x4]	; 037FEC04
	cmp r2,#0x0	; 037FEC06
	beq P2_Entry_037FEC10	; 037FEC08
	str r3,[r2,#0x0]	; 037FEC0A
	b P2_Entry_037FEC10	; 037FEC0C
P2_Entry_037FEC0E:
	add r0,r1,#0x0	; 037FEC0E
P2_Entry_037FEC10:
	add sp,#0x4	; 037FEC10
	pop {r4,r5}	; 037FEC12
	pop {r3}	; 037FEC14
	bx r3	; 037FEC16

; ===== function loc_037FEC18 =====
loc_037FEC18:
	ldr r3,[r1,#0x4]	; 037FEC18
	cmp r3,#0x0	; 037FEC1A
	beq loc_037FEC22	; 037FEC1C
	ldr r2,[r1,#0x0]	; 037FEC1E
	str r2,[r3,#0x0]	; 037FEC20
loc_037FEC22:
	ldr r2,[r1,#0x0]	; 037FEC22
	cmp r2,#0x0	; 037FEC24
	bne loc_037FEC2C	; 037FEC26
	ldr r0,[r1,#0x4]	; 037FEC28
	bx lr	; 037FEC2A
loc_037FEC2C:
	ldr r1,[r1,#0x4]	; 037FEC2C
	str r1,[r2,#0x4]	; 037FEC2E
	bx lr	; 037FEC30
	.byte 0x00, 0x00	; 037FEC34

; ===== function loc_037FEC34 =====
loc_037FEC34:
	str r0,[r1,#0x4]	; 037FEC34
	mov r2,#0x0	; 037FEC36
	str r2,[r1,#0x0]	; 037FEC38
	cmp r0,#0x0	; 037FEC3A
	beq loc_037FEC40	; 037FEC3C
	str r1,[r0,#0x0]	; 037FEC3E
loc_037FEC40:
	add r0,r1,#0x0	; 037FEC40
	bx lr	; 037FEC42

; ===== function loc_037FEC44 =====
loc_037FEC44:
	ldr r1,[pool_037FEC54]	; 037FEC44
	ldrh r3,[r1,#0x0]	; 037FEC46
	mov r2,#0x1	; 037FEC48
	lsl r2,r0	; 037FEC4A
	orr r3,r2	; 037FEC4C
	strh r3,[r1,#0x0]	; 037FEC4E
	bx lr	; 037FEC50
	.byte 0xC0, 0x46	; 037FEC54
pool_037FEC54:
loc_037FEC54:
	.word P2_BssStart + 0x840	; 037FEC54

; ===== function loc_037FEC58 =====
loc_037FEC58:
	push {r4,r5,lr}	; 037FEC58
	sub sp,#0xc	; 037FEC5A
	bl loc_037FE0D0	; 037FEC5C
	ldr r1,[pool_037FECC0]	; 037FEC60
	ldrh r1,[r1,#0x0]	; 037FEC62
	add r3,sp,#0x0	; 037FEC64
	strh r1,[r3,#0x0]	; 037FEC66
	ldr r1,[pool_037FECC4]	; 037FEC68
	ldr r5,[r1,#0x0]	; 037FEC6A
	ldr r4,[r1,#0x4]	; 037FEC6C
	ldr r1,[pool_037FECC8]	; 037FEC6E
	mov r2,#0x0	; 037FEC70
	and r4,r1	; 037FEC72
	bic r5,r2	; 037FEC74
	str r5,[sp,#0x4]	; 037FEC76
	str r4,[sp,#0x8]	; 037FEC78
	ldr r1,[pool_037FECCC]	; 037FEC7A
	ldr r4,[r1,#0x0]	; 037FEC7C
	mov r1,#0x8	; 037FEC7E
	and r4,r1	; 037FEC80
	cmp r4,#0x0	; 037FEC82
	beq loc_037FEC9E	; 037FEC84
	ldrh r3,[r3,#0x0]	; 037FEC86
	ldr r1,[pool_037FECD0]	; 037FEC88
	and r3,r1	; 037FEC8A
	cmp r3,#0x0	; 037FEC8C
	bne loc_037FEC9E	; 037FEC8E
	ldr r3,[sp,#0x4]	; 037FEC90
	ldr r4,[sp,#0x8]	; 037FEC92
	mov r1,#0x1	; 037FEC94
	add r1,r3,r1	; 037FEC96
	adc r4,r2	; 037FEC98
	str r1,[sp,#0x4]	; 037FEC9A
	str r4,[sp,#0x8]	; 037FEC9C
loc_037FEC9E:
	bl loc_037FE0F4	; 037FEC9E
	ldr r2,[sp,#0x4]	; 037FECA2
	ldr r1,[sp,#0x8]	; 037FECA4
	lsr r0,r2,#0x10	; 037FECA6
	lsl r1,r1,#0x10	; 037FECA8
	orr r1,r0	; 037FECAA
	lsl r0,r2,#0x10	; 037FECAC
	add r2,sp,#0x0	; 037FECAE
	ldrh r3,[r2,#0x0]	; 037FECB0
	asr r2,r3,#0x1f	; 037FECB2
	orr r1,r2	; 037FECB4
	orr r0,r3	; 037FECB6
	add sp,#0xc	; 037FECB8
	pop {r4,r5}	; 037FECBA
	pop {r3}	; 037FECBC
	bx r3	; 037FECBE
pool_037FECC0:
loc_037FECC0:
	.word TIMER0_DATA	; 037FECC0
pool_037FECC4:
loc_037FECC4:
	.word P2_BssStart + 0x84C	; 037FECC4
pool_037FECC8:
loc_037FECC8:
	.word 0x0000FFFF	; 037FECC8
pool_037FECCC:
loc_037FECCC:
	.word REG_IF	; 037FECCC
pool_037FECD0:
loc_037FECD0:
	.word 0x00008000	; 037FECD0

; ===== function loc_037FECD4 =====
P2_IrqHandler_037FECD4:
	push {r4,lr}	; 037FECD4
	ldr r1,[pool_037FED10]	; 037FECD6
	ldr r2,[r1,#0x0]	; 037FECD8
	ldr r4,[r1,#0x4]	; 037FECDA
	mov r3,#0x0	; 037FECDC
	mov r0,#0x1	; 037FECDE
	add r0,r2,r0	; 037FECE0
	adc r4,r3	; 037FECE2
	str r0,[r1,#0x0]	; 037FECE4
	str r4,[r1,#0x4]	; 037FECE6
	ldr r0,[pool_037FED14]	; 037FECE8
	ldr r1,[r0,#0x0]	; 037FECEA
	cmp r1,#0x0	; 037FECEC
	beq loc_037FECFE	; 037FECEE
	ldr r2,[pool_037FED18]	; 037FECF0
	strh r3,[r2,#0x0]	; 037FECF2
	ldr r1,[pool_037FED1C]	; 037FECF4
	strh r3,[r1,#0x0]	; 037FECF6
	mov r1,#0xc1	; 037FECF8
	strh r1,[r2,#0x0]	; 037FECFA
	str r3,[r0,#0x0]	; 037FECFC
loc_037FECFE:
	mov r0,#0x0	; 037FECFE
	ldr r1,[pool_037FED20]	; 037FED00
	add r2,r0,#0x0	; 037FED02
	bl loc_037FDED0	; 037FED04
	pop {r4}	; 037FED08
	pop {r3}	; 037FED0A
	bx r3	; 037FED0C
	.byte 0xC0, 0x46	; 037FED10
pool_037FED10:
loc_037FED10:
	.word P2_BssStart + 0x84C	; 037FED10
pool_037FED14:
loc_037FED14:
	.word P2_BssStart + 0x848	; 037FED14
pool_037FED18:
loc_037FED18:
	.word TIMER0_CR	; 037FED18
pool_037FED1C:
loc_037FED1C:
	.word TIMER0_DATA	; 037FED1C
pool_037FED20:
loc_037FED20:
	.word 0x037FECD5	; 037FED20

; ===== function loc_037FED24 =====
loc_037FED24:
	ldr r0,[pool_037FED2C]	; 037FED24
	ldrh r0,[r0,#0x0]	; 037FED26
	bx lr	; 037FED28
	.byte 0xC0, 0x46	; 037FED2C
pool_037FED2C:
loc_037FED2C:
	.word P2_BssStart + 0x844	; 037FED2C

; ===== function loc_037FED30 =====
loc_037FED30:
	push {lr}	; 037FED30
	sub sp,#0x4	; 037FED32
	ldr r0,[pool_037FED74]	; 037FED34
	ldrh r1,[r0,#0x0]	; 037FED36
	cmp r1,#0x0	; 037FED38
	bne loc_037FED6E	; 037FED3A
	mov r1,#0x1	; 037FED3C
	strh r1,[r0,#0x0]	; 037FED3E
	mov r0,#0x0	; 037FED40
	bl loc_037FEC44	; 037FED42
	mov r2,#0x0	; 037FED46
	ldr r0,[pool_037FED78]	; 037FED48
	str r2,[r0,#0x0]	; 037FED4A
	str r2,[r0,#0x4]	; 037FED4C
	ldr r1,[pool_037FED7C]	; 037FED4E
	strh r2,[r1,#0x0]	; 037FED50
	ldr r0,[pool_037FED80]	; 037FED52
	strh r2,[r0,#0x0]	; 037FED54
	mov r0,#0xc1	; 037FED56
	strh r0,[r1,#0x0]	; 037FED58
	mov r0,#0x8	; 037FED5A
	ldr r1,[pool_037FED84]	; 037FED5C
	bl loc_037FDF04	; 037FED5E
	mov r0,#0x8	; 037FED62
	bl loc_037FDE80	; 037FED64
	mov r1,#0x0	; 037FED68
	ldr r0,[pool_037FED88]	; 037FED6A
	str r1,[r0,#0x0]	; 037FED6C
loc_037FED6E:
	add sp,#0x4	; 037FED6E
	pop {r3}	; 037FED70
	bx r3	; 037FED72
pool_037FED74:
loc_037FED74:
	.word P2_BssStart + 0x844	; 037FED74
pool_037FED78:
loc_037FED78:
	.word P2_BssStart + 0x84C	; 037FED78
pool_037FED7C:
loc_037FED7C:
	.word TIMER0_CR	; 037FED7C
pool_037FED80:
loc_037FED80:
	.word TIMER0_DATA	; 037FED80
pool_037FED84:
loc_037FED84:
	.word P2_IrqHandler_037FECD4 + 1	; 037FED84
pool_037FED88:
loc_037FED88:
	.word P2_BssStart + 0x848	; 037FED88
.arm
	stmdb sp!,{lr}	; 037FED8C
	bl loc_037FED9C	; 037FED90
	ldmia sp!,{lr}	; 037FED94
	bx lr	; 037FED98

; ===== function loc_037FED9C =====
loc_037FED9C:
	ldr r12,[pool_037FEDA4]	; 037FED9C
	bx r12	; 037FEDA0
pool_037FEDA4:
loc_037FEDA4:
	.word loc_037FEDA8 + 1	; 037FEDA4
.thumb
loc_037FEDA8:
	push {r4,r5,lr}	; 037FEDA8
	sub sp,#0x4	; 037FEDAA
	mov r1,#0x0	; 037FEDAC
	ldr r0,[pool_037FEE40]	; 037FEDAE
	strh r1,[r0,#0x0]	; 037FEDB0
	mov r0,#0x10	; 037FEDB2
	bl loc_037FDE54	; 037FEDB4
	ldr r2,[pool_037FEE44]	; 037FEDB8
	ldr r1,[r2,#0x0]	; 037FEDBA
	mov r0,#0x10	; 037FEDBC
	orr r1,r0	; 037FEDBE
	str r1,[r2,#0x0]	; 037FEDC0
	bl loc_037FEC58	; 037FEDC2
	ldr r2,[pool_037FEE48]	; 037FEDC6
	ldr r4,[r2,#0x0]	; 037FEDC8
	cmp r4,#0x0	; 037FEDCA
	beq loc_037FEE36	; 037FEDCC
	ldr r5,[r4,#0xc]	; 037FEDCE
	ldr r3,[r4,#0x10]	; 037FEDD0
	sub r0,r0,r5	; 037FEDD2
	sbc r1,r3	; 037FEDD4
	bcs loc_037FEDE0	; 037FEDD6
	add r0,r4,#0x0	; 037FEDD8
	bl loc_037FF068	; 037FEDDA
	b loc_037FEE36	; 037FEDDE
loc_037FEDE0:
	ldr r1,[r4,#0x18]	; 037FEDE0
	str r1,[r2,#0x0]	; 037FEDE2
	cmp r1,#0x0	; 037FEDE4
	bne loc_037FEDEE	; 037FEDE6
	mov r0,#0x0	; 037FEDE8
	str r0,[r2,#0x4]	; 037FEDEA
	b loc_037FEDF2	; 037FEDEC
loc_037FEDEE:
	mov r0,#0x0	; 037FEDEE
	str r0,[r1,#0x14]	; 037FEDF0
loc_037FEDF2:
	ldr r5,[r4,#0x0]	; 037FEDF2
	ldr r2,[r4,#0x1c]	; 037FEDF4
	ldr r1,[r4,#0x20]	; 037FEDF6
	mov r0,#0x0	; 037FEDF8
	eor r1,r0	; 037FEDFA
	eor r2,r0	; 037FEDFC
	orr r1,r2	; 037FEDFE
	bne loc_037FEE06	; 037FEE00
	mov r0,#0x0	; 037FEE02
	str r0,[r4,#0x0]	; 037FEE04
loc_037FEE06:
	cmp r5,#0x0	; 037FEE06
	beq loc_037FEE10	; 037FEE08
	ldr r0,[r4,#0x4]	; 037FEE0A
	bl loc_0380547C	; 037FEE0C
loc_037FEE10:
	ldr r2,[r4,#0x1c]	; 037FEE10
	ldr r1,[r4,#0x20]	; 037FEE12
	mov r0,#0x0	; 037FEE14
	eor r1,r0	; 037FEE16
	eor r2,r0	; 037FEE18
	orr r1,r2	; 037FEE1A
	beq loc_037FEE2A	; 037FEE1C
	str r5,[r4,#0x0]	; 037FEE1E
	add r0,r4,#0x0	; 037FEE20
	mov r1,#0x0	; 037FEE22
	add r2,r1,#0x0	; 037FEE24
	bl loc_037FEF48	; 037FEE26
loc_037FEE2A:
	ldr r0,[pool_037FEE48]	; 037FEE2A
	ldr r0,[r0,#0x0]	; 037FEE2C
	cmp r0,#0x0	; 037FEE2E
	beq loc_037FEE36	; 037FEE30
	bl loc_037FF068	; 037FEE32
loc_037FEE36:
	add sp,#0x4	; 037FEE36
	pop {r4,r5}	; 037FEE38
	pop {r3}	; 037FEE3A
	bx r3	; 037FEE3C
	.byte 0xC0, 0x46	; 037FEE40
pool_037FEE40:
loc_037FEE40:
	.word TIMER1_CR	; 037FEE40
pool_037FEE44:
loc_037FEE44:
	.word Bios7IrqFlagsAddress	; 037FEE44
pool_037FEE48:
loc_037FEE48:
	.word P2_BssStart + 0x858	; 037FEE48

; ===== function loc_037FEE4C =====
loc_037FEE4C:
	push {r4,r5,lr}	; 037FEE4C
	sub sp,#0x4	; 037FEE4E
	add r5,r0,#0x0	; 037FEE50
	bl loc_037FE0D0	; 037FEE52
	add r4,r0,#0x0	; 037FEE56
	ldr r1,[r5,#0x0]	; 037FEE58
	cmp r1,#0x0	; 037FEE5A
	bne loc_037FEE64	; 037FEE5C
	bl loc_037FE0F4	; 037FEE5E
	b loc_037FEE9A	; 037FEE62
loc_037FEE64:
	ldr r0,[r5,#0x18]	; 037FEE64
	cmp r0,#0x0	; 037FEE66
	bne loc_037FEE72	; 037FEE68
	ldr r2,[r5,#0x14]	; 037FEE6A
	ldr r1,[pool_037FEEA4]	; 037FEE6C
	str r2,[r1,#0x4]	; 037FEE6E
	b loc_037FEE76	; 037FEE70
loc_037FEE72:
	ldr r1,[r5,#0x14]	; 037FEE72
	str r1,[r0,#0x14]	; 037FEE74
loc_037FEE76:
	ldr r1,[r5,#0x14]	; 037FEE76
	cmp r1,#0x0	; 037FEE78
	beq loc_037FEE80	; 037FEE7A
	str r0,[r1,#0x18]	; 037FEE7C
	b loc_037FEE8C	; 037FEE7E
loc_037FEE80:
	ldr r1,[pool_037FEEA4]	; 037FEE80
	str r0,[r1,#0x0]	; 037FEE82
	cmp r0,#0x0	; 037FEE84
	beq loc_037FEE8C	; 037FEE86
	bl loc_037FF068	; 037FEE88
loc_037FEE8C:
	mov r0,#0x0	; 037FEE8C
	str r0,[r5,#0x0]	; 037FEE8E
	str r0,[r5,#0x1c]	; 037FEE90
	str r0,[r5,#0x20]	; 037FEE92
	add r0,r4,#0x0	; 037FEE94
	bl loc_037FE0F4	; 037FEE96
loc_037FEE9A:
	add sp,#0x4	; 037FEE9A
	pop {r4,r5}	; 037FEE9C
	pop {r3}	; 037FEE9E
	bx r3	; 037FEEA0
	.byte 0xC0, 0x46	; 037FEEA4
pool_037FEEA4:
loc_037FEEA4:
	.word P2_BssStart + 0x858	; 037FEEA4

; ===== function loc_037FEEA8 =====
loc_037FEEA8:
	push {r4,r5,r6,lr}	; 037FEEA8
	sub sp,#0x10	; 037FEEAA
	add r5,r0,#0x0	; 037FEEAC
	add r4,r1,#0x0	; 037FEEAE
	add r6,r2,#0x0	; 037FEEB0
	str r3,[sp,#0x0]	; 037FEEB2
	ldr r0,[sp,#0x20]	; 037FEEB4
	str r0,[sp,#0x4]	; 037FEEB6
	cmp r5,#0x0	; 037FEEB8
	beq loc_037FEEC2	; 037FEEBA
	ldr r0,[r5,#0x0]	; 037FEEBC
	cmp r0,#0x0	; 037FEEBE
	beq loc_037FEEC6	; 037FEEC0
loc_037FEEC2:
	bl loc_037FF5C4	; 037FEEC2
loc_037FEEC6:
	bl loc_037FE0D0	; 037FEEC6
	str r0,[sp,#0x8]	; 037FEECA
	ldr r0,[sp,#0x0]	; 037FEECC
	str r0,[r5,#0x1c]	; 037FEECE
	ldr r0,[sp,#0x4]	; 037FEED0
	str r0,[r5,#0x20]	; 037FEED2
	str r4,[r5,#0x24]	; 037FEED4
	str r6,[r5,#0x28]	; 037FEED6
	ldr r0,[sp,#0x24]	; 037FEED8
	str r0,[r5,#0x0]	; 037FEEDA
	ldr r0,[sp,#0x28]	; 037FEEDC
	str r0,[r5,#0x4]	; 037FEEDE
	add r0,r5,#0x0	; 037FEEE0
	mov r1,#0x0	; 037FEEE2
	add r2,r1,#0x0	; 037FEEE4
	bl loc_037FEF48	; 037FEEE6
	ldr r0,[sp,#0x8]	; 037FEEEA
	bl loc_037FE0F4	; 037FEEEC
	add sp,#0x10	; 037FEEF0
	pop {r4,r5,r6}	; 037FEEF2
	pop {r3}	; 037FEEF4
	bx r3	; 037FEEF6

; ===== function loc_037FEEF8 =====
loc_037FEEF8:
	push {r4,r5,r6,r7,lr}	; 037FEEF8
	sub sp,#0x4	; 037FEEFA
	add r5,r0,#0x0	; 037FEEFC
	add r6,r1,#0x0	; 037FEEFE
	add r4,r2,#0x0	; 037FEF00
	add r7,r3,#0x0	; 037FEF02
	cmp r5,#0x0	; 037FEF04
	beq loc_037FEF0E	; 037FEF06
	ldr r0,[r5,#0x0]	; 037FEF08
	cmp r0,#0x0	; 037FEF0A
	beq loc_037FEF12	; 037FEF0C
loc_037FEF0E:
	bl loc_037FF5C4	; 037FEF0E
loc_037FEF12:
	bl loc_037FE0D0	; 037FEF12
	str r0,[sp,#0x0]	; 037FEF16
	mov r0,#0x0	; 037FEF18
	str r0,[r5,#0x1c]	; 037FEF1A
	str r0,[r5,#0x20]	; 037FEF1C
	str r7,[r5,#0x0]	; 037FEF1E
	ldr r0,[sp,#0x18]	; 037FEF20
	str r0,[r5,#0x4]	; 037FEF22
	bl loc_037FEC58	; 037FEF24
	add r2,r0,#0x0	; 037FEF28
	add r0,r5,#0x0	; 037FEF2A
	add r2,r6,r2	; 037FEF2C
	adc r4,r1	; 037FEF2E
	add r1,r2,#0x0	; 037FEF30
	add r2,r4,#0x0	; 037FEF32
	bl loc_037FEF48	; 037FEF34
	ldr r0,[sp,#0x0]	; 037FEF38
	bl loc_037FE0F4	; 037FEF3A
	add sp,#0x4	; 037FEF3E
	pop {r4,r5,r6,r7}	; 037FEF40
	pop {r3}	; 037FEF42
	bx r3	; 037FEF44
	.byte 0x00, 0x00	; 037FEF48

; ===== function loc_037FEF48 =====
loc_037FEF48:
	push {r4,r5,r6,r7,lr}	; 037FEF48
	sub sp,#0xc	; 037FEF4A
	add r5,r0,#0x0	; 037FEF4C
	add r4,r1,#0x0	; 037FEF4E
	add r6,r2,#0x0	; 037FEF50
	ldr r2,[r5,#0x1c]	; 037FEF52
	ldr r1,[r5,#0x20]	; 037FEF54
	mov r0,#0x0	; 037FEF56
	eor r1,r0	; 037FEF58
	eor r2,r0	; 037FEF5A
	orr r1,r2	; 037FEF5C
	beq loc_037FEFA2	; 037FEF5E
	bl loc_037FEC58	; 037FEF60
	ldr r4,[r5,#0x24]	; 037FEF64
	ldr r6,[r5,#0x28]	; 037FEF66
	sub r2,r4,r0	; 037FEF68
	lsl r2,r6,#0	; 037FEF6A
	sbc r2,r1	; 037FEF6C
	bcs loc_037FEFA2	; 037FEF6E
	ldr r2,[r5,#0x1c]	; 037FEF70
	str r2,[sp,#0x0]	; 037FEF72
	ldr r2,[r5,#0x20]	; 037FEF74
	str r2,[sp,#0x4]	; 037FEF76
	sub r0,r0,r4	; 037FEF78
	sbc r1,r6	; 037FEF7A
	ldr r2,[sp,#0x0]	; 037FEF7C
	ldr r3,[sp,#0x4]	; 037FEF7E
	bl loc_037FF00C	; 037FEF80
	str r0,[sp,#0x8]	; 037FEF84
	add r7,r1,#0x0	; 037FEF86
	ldr r0,[sp,#0x0]	; 037FEF88
	ldr r1,[sp,#0x4]	; 037FEF8A
	mov r3,#0x1	; 037FEF8C
	ldr r2,[sp,#0x8]	; 037FEF8E
	add r3,r2,r3	; 037FEF90
	mov r2,#0x0	; 037FEF92
	adc r7,r2	; 037FEF94
	add r2,r3,#0x0	; 037FEF96
	add r3,r7,#0x0	; 037FEF98
	bl loc_037FF018	; 037FEF9A
	add r4,r4,r0	; 037FEF9E
	adc r6,r1	; 037FEFA0
loc_037FEFA2:
	str r4,[r5,#0xc]	; 037FEFA2
	str r6,[r5,#0x10]	; 037FEFA4
	ldr r0,[pool_037FF008]	; 037FEFA6
	ldr r3,[r0,#0x0]	; 037FEFA8
	b loc_037FEFDE	; 037FEFAA
loc_037FEFAC:
	ldr r1,[r3,#0xc]	; 037FEFAC
	ldr r0,[r3,#0x10]	; 037FEFAE
	sub r2,r4,r1	; 037FEFB0
	lsl r1,r6,#0	; 037FEFB2
	sbc r1,r0	; 037FEFB4
	mov r0,#0x0	; 037FEFB6
	sub r2,r2,r0	; 037FEFB8
	sbc r1,r0	; 037FEFBA
	bge loc_037FEFDC	; 037FEFBC
	ldr r0,[r3,#0x14]	; 037FEFBE
	str r0,[r5,#0x14]	; 037FEFC0
	str r5,[r3,#0x14]	; 037FEFC2
	str r3,[r5,#0x18]	; 037FEFC4
	ldr r0,[r5,#0x14]	; 037FEFC6
	cmp r0,#0x0	; 037FEFC8
	beq loc_037FEFD0	; 037FEFCA
	str r5,[r0,#0x18]	; 037FEFCC
	b loc_037FF000	; 037FEFCE
loc_037FEFD0:
	ldr r0,[pool_037FF008]	; 037FEFD0
	str r5,[r0,#0x0]	; 037FEFD2
	add r0,r5,#0x0	; 037FEFD4
	bl loc_037FF068	; 037FEFD6
	b loc_037FF000	; 037FEFDA
loc_037FEFDC:
	ldr r3,[r3,#0x18]	; 037FEFDC
loc_037FEFDE:
	cmp r3,#0x0	; 037FEFDE
	bne loc_037FEFAC	; 037FEFE0
	mov r0,#0x0	; 037FEFE2
	str r0,[r5,#0x18]	; 037FEFE4
	ldr r0,[pool_037FF008]	; 037FEFE6
	ldr r1,[r0,#0x4]	; 037FEFE8
	str r5,[r0,#0x4]	; 037FEFEA
	str r1,[r5,#0x14]	; 037FEFEC
	cmp r1,#0x0	; 037FEFEE
	beq loc_037FEFF6	; 037FEFF0
	str r5,[r1,#0x18]	; 037FEFF2
	b loc_037FF000	; 037FEFF4
loc_037FEFF6:
	str r5,[r0,#0x4]	; 037FEFF6
	str r5,[r0,#0x0]	; 037FEFF8
	add r0,r5,#0x0	; 037FEFFA
	bl loc_037FF068	; 037FEFFC
loc_037FF000:
	add sp,#0xc	; 037FF000
	pop {r4,r5,r6,r7}	; 037FF002
	pop {r3}	; 037FF004
	bx r3	; 037FF006
pool_037FF008:
loc_037FF008:
	.word P2_BssStart + 0x858	; 037FF008

; ===== function loc_037FF00C =====
loc_037FF00C:
	bx pc	; 037FF00C
	.byte 0xC0, 0x46	; 037FF010
.arm

; ===== function loc_037FF010 =====
loc_037FF010:
	ldr pc,[pool_037FF014]	; 037FF010
pool_037FF014:
loc_037FF014:
	.word loc_03804D30	; 037FF014
.thumb

; ===== function loc_037FF018 =====
loc_037FF018:
	bx pc	; 037FF018
	.byte 0xC0, 0x46	; 037FF01C
.arm

; ===== function loc_037FF01C =====
loc_037FF01C:
	ldr pc,[pool_037FF020]	; 037FF01C
pool_037FF020:
loc_037FF020:
	.word loc_03804F38	; 037FF020
.thumb

; ===== function loc_037FF024 =====
loc_037FF024:
	mov r1,#0x0	; 037FF024
	str r1,[r0,#0x0]	; 037FF026
	str r1,[r0,#0x8]	; 037FF028
	bx lr	; 037FF02A

; ===== function loc_037FF02C =====
loc_037FF02C:
	ldr r0,[pool_037FF034]	; 037FF02C
	ldrh r0,[r0,#0x0]	; 037FF02E
	bx lr	; 037FF030
	.byte 0xC0, 0x46	; 037FF034
pool_037FF034:
loc_037FF034:
	.word P2_BssStart + 0x854	; 037FF034

; ===== function loc_037FF038 =====
loc_037FF038:
	push {lr}	; 037FF038
	sub sp,#0x4	; 037FF03A
	ldr r1,[pool_037FF060]	; 037FF03C
	ldrh r0,[r1,#0x0]	; 037FF03E
	cmp r0,#0x0	; 037FF040
	bne loc_037FF05A	; 037FF042
	mov r0,#0x1	; 037FF044
	strh r0,[r1,#0x0]	; 037FF046
	bl loc_037FEC44	; 037FF048
	mov r1,#0x0	; 037FF04C
	ldr r0,[pool_037FF064]	; 037FF04E
	str r1,[r0,#0x0]	; 037FF050
	str r1,[r0,#0x4]	; 037FF052
	mov r0,#0x10	; 037FF054
	bl loc_037FDE54	; 037FF056
loc_037FF05A:
	add sp,#0x4	; 037FF05A
	pop {r3}	; 037FF05C
	bx r3	; 037FF05E
pool_037FF060:
loc_037FF060:
	.word P2_BssStart + 0x854	; 037FF060
pool_037FF064:
loc_037FF064:
	.word P2_BssStart + 0x858	; 037FF064

; ===== function loc_037FF068 =====
loc_037FF068:
	push {r4,r5,lr}	; 037FF068
	sub sp,#0x4	; 037FF06A
	add r4,r0,#0x0	; 037FF06C
	bl loc_037FEC58	; 037FF06E
	mov r2,#0x0	; 037FF072
	ldr r3,[pool_037FF0C0]	; 037FF074
	strh r2,[r3,#0x0]	; 037FF076
	ldr r3,[r4,#0xc]	; 037FF078
	ldr r4,[r4,#0x10]	; 037FF07A
	sub r5,r3,r0	; 037FF07C
	sbc r4,r1	; 037FF07E
	mov r0,#0x1	; 037FF080
	ldr r1,[pool_037FF0C4]	; 037FF082
	bl loc_037FDED0	; 037FF084
	mov r1,#0x0	; 037FF088
	sub r0,r5,r1	; 037FF08A
	lsl r0,r4,#0	; 037FF08C
	sbc r0,r1	; 037FF08E
	bge loc_037FF096	; 037FF090
	ldr r1,[pool_037FF0C8]	; 037FF092
	b loc_037FF0A8	; 037FF094
loc_037FF096:
	ldr r0,[pool_037FF0CC]	; 037FF096
	sub r0,r5,r0	; 037FF098
	sbc r4,r1	; 037FF09A
	bge loc_037FF0A6	; 037FF09C
	mvn r0,r5	; 037FF09E
	lsl r0,r0,#0x10	; 037FF0A0
	lsr r1,r0,#0x10	; 037FF0A2
	b loc_037FF0A8	; 037FF0A4
loc_037FF0A6:
	mov r1,#0x0	; 037FF0A6
loc_037FF0A8:
	ldr r0,[pool_037FF0D0]	; 037FF0A8
	strh r1,[r0,#0x0]	; 037FF0AA
	mov r1,#0xc1	; 037FF0AC
	ldr r0,[pool_037FF0C0]	; 037FF0AE
	strh r1,[r0,#0x0]	; 037FF0B0
	mov r0,#0x10	; 037FF0B2
	bl loc_037FDE80	; 037FF0B4
	add sp,#0x4	; 037FF0B8
	pop {r4,r5}	; 037FF0BA
	pop {r3}	; 037FF0BC
	bx r3	; 037FF0BE
pool_037FF0C0:
loc_037FF0C0:
	.word TIMER1_CR	; 037FF0C0
pool_037FF0C4:
loc_037FF0C4:
	.word 0x037FED8C	; 037FF0C4
pool_037FF0C8:
loc_037FF0C8:
	.word 0x0000FFFE	; 037FF0C8
pool_037FF0CC:
loc_037FF0CC:
	.word 0x00010000	; 037FF0CC
pool_037FF0D0:
loc_037FF0D0:
	.word TIMER1_DATA	; 037FF0D0

; ===== function loc_037FF0D4 =====
P2_Entry_037FF0D4:
	push {r4,lr}	; 037FF0D4
	add r4,r0,#0x0	; 037FF0D6
	bl loc_037FE0D0	; 037FF0D8
	ldr r1,[pool_037FF100]	; 037FF0DC
	ldr r1,[r1,#0x0]	; 037FF0DE
	cmp r4,r1	; 037FF0E0
	bcs loc_037FF0EC	; 037FF0E2
	ldr r1,[pool_037FF104]	; 037FF0E4
	ldr r2,[r1,#0x0]	; 037FF0E6
	add r2,r2,#0x1	; 037FF0E8
	str r2,[r1,#0x0]	; 037FF0EA
loc_037FF0EC:
	ldr r1,[pool_037FF100]	; 037FF0EC
	str r4,[r1,#0x0]	; 037FF0EE
	bl loc_037FE0F4	; 037FF0F0
	ldr r0,[pool_037FF104]	; 037FF0F4
	ldr r0,[r0,#0x0]	; 037FF0F6
	pop {r4}	; 037FF0F8
	pop {r3}	; 037FF0FA
	bx r3	; 037FF0FC
	.byte 0xC0, 0x46	; 037FF100
pool_037FF100:
loc_037FF100:
	.word P2_BssStart + 0x864	; 037FF100
pool_037FF104:
loc_037FF104:
	.word P2_BssStart + 0x868	; 037FF104
P2_Entry_037FF108:
	ldr r3,[r0,#0xc]	; 037FF108
	sub r3,r1,r3	; 037FF10A
	mov r1,#0x10	; 037FF10C
	ldrsh r1,[r0,r1]	; 037FF10E
	sub r2,r2,r1	; 037FF110
	cmp r3,#0x0	; 037FF112
	blt P2_Entry_037FF11E	; 037FF114
	cmp r3,#0x0	; 037FF116
	bne P2_Entry_037FF122	; 037FF118
	cmp r2,#0x0	; 037FF11A
	bge P2_Entry_037FF122	; 037FF11C
P2_Entry_037FF11E:
	mov r0,#0x0	; 037FF11E
	bx lr	; 037FF120
P2_Entry_037FF122:
	cmp r2,#0x0	; 037FF122
	bge P2_Entry_037FF12A	; 037FF124
	ldr r1,[pool_037FF13C]	; 037FF126
	add r2,r2,r1	; 037FF128
P2_Entry_037FF12A:
	mov r1,#0x12	; 037FF12A
	ldrsh r0,[r0,r1]	; 037FF12C
	cmp r2,r0	; 037FF12E
	bgt P2_Entry_037FF136	; 037FF130
	mov r0,#0x1	; 037FF132
	bx lr	; 037FF134
P2_Entry_037FF136:
	mov r0,#0x2	; 037FF136
	bx lr	; 037FF138
	.byte 0xC0, 0x46	; 037FF13A
pool_037FF13C:
	.word 0x00000107	; 037FF13C
P2_IrqHandler_037FF140:
	push {r4,r5,r6,r7,lr}	; 037FF140
	sub sp,#0x4	; 037FF142
	mov r0,#0x4	; 037FF144
	bl loc_037FDE54	; 037FF146
	ldr r3,[pool_037FF220]	; 037FF14A
	ldrh r1,[r3,#0x0]	; 037FF14C
	mov r0,#0x20	; 037FF14E
	bic r1,r0	; 037FF150
	strh r1,[r3,#0x0]	; 037FF152
	ldr r2,[pool_037FF224]	; 037FF154
	ldr r1,[r2,#0x0]	; 037FF156
	mov r0,#0x4	; 037FF158
	orr r1,r0	; 037FF15A
	str r1,[r2,#0x0]	; 037FF15C
	ldrh r1,[r3,#0x0]	; 037FF15E
	asr r2,r1,#0x8	; 037FF160
	mov r0,#0xff	; 037FF162
	and r2,r0	; 037FF164
	lsl r1,r1,#0x1	; 037FF166
	ldr r0,[pool_037FF228]	; 037FF168
	and r1,r0	; 037FF16A
	orr r2,r1	; 037FF16C
	sub r0,r2,#0x1	; 037FF16E
	bl P2_Entry_037FF0D4	; 037FF170
	ldr r7,[pool_037FF22C]	; 037FF174
	b P2_Entry_037FF210	; 037FF176
P2_Entry_037FF178:
	ldrh r4,[r7,#0x0]	; 037FF178
	add r0,r4,#0x0	; 037FF17A
	bl P2_Entry_037FF0D4	; 037FF17C
	add r6,r0,#0x0	; 037FF180
	add r0,r5,#0x0	; 037FF182
	add r1,r6,#0x0	; 037FF184
	add r2,r4,#0x0	; 037FF186
	bl P2_Entry_037FF108	; 037FF188
	cmp r0,#0x0	; 037FF18C
	beq P2_Entry_037FF19A	; 037FF18E
	cmp r0,#0x1	; 037FF190
	beq P2_Entry_037FF1C8	; 037FF192
	cmp r0,#0x2	; 037FF194
	beq P2_Entry_037FF1FC	; 037FF196
	b P2_Entry_037FF210	; 037FF198
P2_Entry_037FF19A:
	add r0,r5,#0x0	; 037FF19A
	bl P2_Entry_037FF2E0	; 037FF19C
	ldrh r1,[r7,#0x0]	; 037FF1A0
	mov r0,#0x10	; 037FF1A2
	ldrsh r0,[r5,r0]	; 037FF1A4
	cmp r0,r1	; 037FF1A6
	bne P2_Entry_037FF218	; 037FF1A8
	ldr r0,[r5,#0xc]	; 037FF1AA
	cmp r0,r6	; 037FF1AC
	bne P2_Entry_037FF218	; 037FF1AE
	mov r0,#0x4	; 037FF1B0
	bl loc_037FDE54	; 037FF1B2
	ldr r0,[pool_037FF220]	; 037FF1B6
	ldrh r1,[r0,#0x0]	; 037FF1B8
	mov r0,#0x20	; 037FF1BA
	bic r1,r0	; 037FF1BC
	ldr r0,[pool_037FF220]	; 037FF1BE
	strh r1,[r0,#0x0]	; 037FF1C0
	mov r0,#0x4	; 037FF1C2
	bl loc_037FDE30	; 037FF1C4
P2_Entry_037FF1C8:
	ldr r4,[r5,#0x0]	; 037FF1C8
	add r0,r5,#0x0	; 037FF1CA
	bl P2_Entry_037FF3F8	; 037FF1CC
	mov r0,#0x0	; 037FF1D0
	str r0,[r5,#0x0]	; 037FF1D2
	cmp r4,#0x0	; 037FF1D4
	beq P2_Entry_037FF1DE	; 037FF1D6
	ldr r0,[r5,#0x4]	; 037FF1D8
	bl loc_03805478	; 037FF1DA
P2_Entry_037FF1DE:
	ldr r0,[r5,#0x1c]	; 037FF1DE
	cmp r0,#0x0	; 037FF1E0
	beq P2_Entry_037FF210	; 037FF1E2
	ldr r0,[r5,#0x24]	; 037FF1E4
	cmp r0,#0x0	; 037FF1E6
	bne P2_Entry_037FF210	; 037FF1E8
	str r4,[r5,#0x0]	; 037FF1EA
	ldr r0,[pool_037FF230]	; 037FF1EC
	ldr r0,[r0,#0x0]	; 037FF1EE
	add r0,r0,#0x1	; 037FF1F0
	str r0,[r5,#0xc]	; 037FF1F2
	add r0,r5,#0x0	; 037FF1F4
	bl P2_Entry_037FF420	; 037FF1F6
	b P2_Entry_037FF210	; 037FF1FA
P2_Entry_037FF1FC:
	add r0,r5,#0x0	; 037FF1FC
	bl P2_Entry_037FF3F8	; 037FF1FE
	add r0,r5,#0x0	; 037FF202
	bl P2_Entry_037FF420	; 037FF204
	ldr r0,[pool_037FF230]	; 037FF208
	ldr r0,[r0,#0x0]	; 037FF20A
	add r0,r0,#0x1	; 037FF20C
	str r0,[r5,#0xc]	; 037FF20E
P2_Entry_037FF210:
	ldr r0,[pool_037FF234]	; 037FF210
	ldr r5,[r0,#0x0]	; 037FF212
	cmp r5,#0x0	; 037FF214
	bne P2_Entry_037FF178	; 037FF216
P2_Entry_037FF218:
	add sp,#0x4	; 037FF218
	pop {r4,r5,r6,r7}	; 037FF21A
	pop {r3}	; 037FF21C
	bx r3	; 037FF21E
pool_037FF220:
	.word REG_DISPSTAT	; 037FF220
pool_037FF224:
	.word Bios7IrqFlagsAddress	; 037FF224
pool_037FF228:
	.word 0x00000100	; 037FF228
pool_037FF22C:
	.word 0x04000006	; 037FF22C
pool_037FF230:
	.word P2_BssStart + 0x868	; 037FF230
pool_037FF234:
	.word P2_BssStart + 0x86C	; 037FF234
P2_Entry_037FF238:
	push {r4,r5,r6,r7,lr}	; 037FF238
	sub sp,#0x4	; 037FF23A
	add r5,r0,#0x0	; 037FF23C
	bl loc_037FE0D0	; 037FF23E
	add r6,r0,#0x0	; 037FF242
	cmp r5,#0x0	; 037FF244
	bne P2_Entry_037FF24C	; 037FF246
	bl loc_037FF5C4	; 037FF248
P2_Entry_037FF24C:
	ldr r0,[pool_037FF288]	; 037FF24C
	ldr r0,[r0,#0x0]	; 037FF24E
	cmp r0,#0x0	; 037FF250
	beq P2_Entry_037FF258	; 037FF252
	ldr r4,[r0,#0x18]	; 037FF254
	b P2_Entry_037FF25A	; 037FF256
P2_Entry_037FF258:
	mov r4,#0x0	; 037FF258
P2_Entry_037FF25A:
	mov r7,#0x0	; 037FF25A
	b P2_Entry_037FF274	; 037FF25C
P2_Entry_037FF25E:
	ldr r1,[r0,#0x8]	; 037FF25E
	cmp r1,r5	; 037FF260
	bne P2_Entry_037FF268	; 037FF262
	bl P2_Entry_037FF28C	; 037FF264
P2_Entry_037FF268:
	add r0,r4,#0x0	; 037FF268
	cmp r4,#0x0	; 037FF26A
	beq P2_Entry_037FF272	; 037FF26C
	ldr r4,[r4,#0x18]	; 037FF26E
	b P2_Entry_037FF274	; 037FF270
P2_Entry_037FF272:
	add r4,r7,#0x0	; 037FF272
P2_Entry_037FF274:
	cmp r0,#0x0	; 037FF274
	bne P2_Entry_037FF25E	; 037FF276
	add r0,r6,#0x0	; 037FF278
	bl loc_037FE0F4	; 037FF27A
	add sp,#0x4	; 037FF27E
	pop {r4,r5,r6,r7}	; 037FF280
	pop {r3}	; 037FF282
	bx r3	; 037FF284
	.byte 0xC0, 0x46	; 037FF286
pool_037FF288:
	.word P2_BssStart + 0x86C	; 037FF288
P2_Entry_037FF28C:
	push {r4,r5,lr}	; 037FF28C
	sub sp,#0x4	; 037FF28E
	add r5,r0,#0x0	; 037FF290
	bl loc_037FE0D0	; 037FF292
	add r4,r0,#0x0	; 037FF296
	mov r1,#0x1	; 037FF298
	str r1,[r5,#0x24]	; 037FF29A
	ldr r1,[r5,#0x0]	; 037FF29C
	cmp r1,#0x0	; 037FF29E
	bne P2_Entry_037FF2A8	; 037FF2A0
	bl loc_037FE0F4	; 037FF2A2
	b P2_Entry_037FF2B8	; 037FF2A6
P2_Entry_037FF2A8:
	add r0,r5,#0x0	; 037FF2A8
	bl P2_Entry_037FF3F8	; 037FF2AA
	mov r0,#0x0	; 037FF2AE
	str r0,[r5,#0x0]	; 037FF2B0
	add r0,r4,#0x0	; 037FF2B2
	bl loc_037FE0F4	; 037FF2B4
P2_Entry_037FF2B8:
	add sp,#0x4	; 037FF2B8
	pop {r4,r5}	; 037FF2BA
	pop {r3}	; 037FF2BC
	bx r3	; 037FF2BE

; ===== function loc_037FF2C0 =====
loc_037FF2C0:
	push {r4,r5,lr}	; 037FF2C0
	sub sp,#0x4	; 037FF2C2
	add r5,r0,#0x0	; 037FF2C4
	add r4,r1,#0x0	; 037FF2C6
	cmp r4,#0x0	; 037FF2C8
	bne loc_037FF2D0	; 037FF2CA
	bl loc_037FF5C4	; 037FF2CC
loc_037FF2D0:
	cmp r5,#0x0	; 037FF2D0
	beq loc_037FF2D6	; 037FF2D2
	str r4,[r5,#0x8]	; 037FF2D4
loc_037FF2D6:
	add sp,#0x4	; 037FF2D6
	pop {r4,r5}	; 037FF2D8
	pop {r3}	; 037FF2DA
	bx r3	; 037FF2DC
	.byte 0x00, 0x00	; 037FF2DE
P2_Entry_037FF2E0:
	push {r4,lr}	; 037FF2E0
	add r4,r0,#0x0	; 037FF2E2
	mov r0,#0x4	; 037FF2E4
	ldr r1,[pool_037FF320]	; 037FF2E6
	bl loc_037FDF04	; 037FF2E8
	mov r0,#0x10	; 037FF2EC
	ldrsh r0,[r4,r0]	; 037FF2EE
	ldr r1,[pool_037FF324]	; 037FF2F0
	add r2,r0,#0x0	; 037FF2F2
	and r2,r1	; 037FF2F4
	asr r4,r2,#0x1	; 037FF2F6
	ldr r2,[pool_037FF328]	; 037FF2F8
	ldrh r3,[r2,#0x0]	; 037FF2FA
	mov r1,#0x3f	; 037FF2FC
	and r3,r1	; 037FF2FE
	mov r1,#0xff	; 037FF300
	and r0,r1	; 037FF302
	lsl r0,r0,#0x8	; 037FF304
	orr r3,r0	; 037FF306
	orr r4,r3	; 037FF308
	strh r4,[r2,#0x0]	; 037FF30A
	ldrh r1,[r2,#0x0]	; 037FF30C
	mov r0,#0x20	; 037FF30E
	orr r1,r0	; 037FF310
	strh r1,[r2,#0x0]	; 037FF312
	mov r0,#0x4	; 037FF314
	bl loc_037FDE80	; 037FF316
	pop {r4}	; 037FF31A
	pop {r3}	; 037FF31C
	bx r3	; 037FF31E
pool_037FF320:
	.word P2_IrqHandler_037FF140 + 1	; 037FF320
pool_037FF324:
	.word 0x00000100	; 037FF324
pool_037FF328:
	.word REG_DISPSTAT	; 037FF328
P2_Entry_037FF32C:
	push {r4,r5,r6,r7,lr}	; 037FF32C
	sub sp,#0xc	; 037FF32E
	add r5,r0,#0x0	; 037FF330
	add r4,r1,#0x0	; 037FF332
	add r6,r2,#0x0	; 037FF334
	add r7,r3,#0x0	; 037FF336
	bl loc_037FE0D0	; 037FF338
	str r0,[sp,#0x0]	; 037FF33C
	cmp r5,#0x0	; 037FF33E
	beq P2_Entry_037FF348	; 037FF340
	ldr r0,[r5,#0x0]	; 037FF342
	cmp r0,#0x0	; 037FF344
	beq P2_Entry_037FF34C	; 037FF346
P2_Entry_037FF348:
	bl loc_037FF5C4	; 037FF348
P2_Entry_037FF34C:
	ldr r0,[pool_037FF388]	; 037FF34C
	ldrh r0,[r0,#0x0]	; 037FF34E
	str r0,[sp,#0x4]	; 037FF350
	bl P2_Entry_037FF0D4	; 037FF352
	mov r1,#0x1	; 037FF356
	str r1,[r5,#0x1c]	; 037FF358
	strh r4,[r5,#0x10]	; 037FF35A
	ldr r1,[sp,#0x4]	; 037FF35C
	cmp r4,r1	; 037FF35E
	bgt P2_Entry_037FF364	; 037FF360
	add r0,r0,#0x1	; 037FF362
P2_Entry_037FF364:
	str r0,[r5,#0xc]	; 037FF364
	strh r6,[r5,#0x12]	; 037FF366
	str r7,[r5,#0x0]	; 037FF368
	ldr r0,[sp,#0x20]	; 037FF36A
	str r0,[r5,#0x4]	; 037FF36C
	mov r0,#0x0	; 037FF36E
	str r0,[r5,#0x24]	; 037FF370
	add r0,r5,#0x0	; 037FF372
	bl P2_Entry_037FF448	; 037FF374
	ldr r0,[sp,#0x0]	; 037FF378
	bl loc_037FE0F4	; 037FF37A
	add sp,#0xc	; 037FF37E
	pop {r4,r5,r6,r7}	; 037FF380
	pop {r3}	; 037FF382
	bx r3	; 037FF384
	.byte 0xC0, 0x46	; 037FF386
pool_037FF388:
	.word REG_VCOUNT	; 037FF388
P2_Entry_037FF38C:
	push {r4,r5,r6,r7,lr}	; 037FF38C
	sub sp,#0xc	; 037FF38E
	add r5,r0,#0x0	; 037FF390
	add r4,r1,#0x0	; 037FF392
	add r6,r2,#0x0	; 037FF394
	add r7,r3,#0x0	; 037FF396
	bl loc_037FE0D0	; 037FF398
	str r0,[sp,#0x0]	; 037FF39C
	cmp r5,#0x0	; 037FF39E
	beq P2_Entry_037FF3A8	; 037FF3A0
	ldr r0,[r5,#0x0]	; 037FF3A2
	cmp r0,#0x0	; 037FF3A4
	beq P2_Entry_037FF3AC	; 037FF3A6
P2_Entry_037FF3A8:
	bl loc_037FF5C4	; 037FF3A8
P2_Entry_037FF3AC:
	ldr r0,[pool_037FF3E8]	; 037FF3AC
	ldrh r0,[r0,#0x0]	; 037FF3AE
	str r0,[sp,#0x4]	; 037FF3B0
	bl P2_Entry_037FF0D4	; 037FF3B2
	mov r1,#0x0	; 037FF3B6
	str r1,[r5,#0x1c]	; 037FF3B8
	strh r4,[r5,#0x10]	; 037FF3BA
	ldr r1,[sp,#0x4]	; 037FF3BC
	cmp r4,r1	; 037FF3BE
	bgt P2_Entry_037FF3C4	; 037FF3C0
	add r0,r0,#0x1	; 037FF3C2
P2_Entry_037FF3C4:
	str r0,[r5,#0xc]	; 037FF3C4
	strh r6,[r5,#0x12]	; 037FF3C6
	str r7,[r5,#0x0]	; 037FF3C8
	ldr r0,[sp,#0x20]	; 037FF3CA
	str r0,[r5,#0x4]	; 037FF3CC
	mov r0,#0x0	; 037FF3CE
	str r0,[r5,#0x24]	; 037FF3D0
	add r0,r5,#0x0	; 037FF3D2
	bl P2_Entry_037FF448	; 037FF3D4
	ldr r0,[sp,#0x0]	; 037FF3D8
	bl loc_037FE0F4	; 037FF3DA
	add sp,#0xc	; 037FF3DE
	pop {r4,r5,r6,r7}	; 037FF3E0
	pop {r3}	; 037FF3E2
	bx r3	; 037FF3E4
	.byte 0xC0, 0x46	; 037FF3E6
pool_037FF3E8:
	.word REG_VCOUNT	; 037FF3E8

; ===== function loc_037FF3EC =====
loc_037FF3EC:
	mov r1,#0x0	; 037FF3EC
	str r1,[r0,#0x0]	; 037FF3EE
	str r1,[r0,#0x8]	; 037FF3F0
	str r1,[r0,#0x20]	; 037FF3F2
	bx lr	; 037FF3F4
	.byte 0x00, 0x00	; 037FF3F6
P2_Entry_037FF3F8:
	cmp r0,#0x0	; 037FF3F8
	beq P2_Entry_037FF418	; 037FF3FA
	ldr r2,[r0,#0x14]	; 037FF3FC
	ldr r1,[r0,#0x18]	; 037FF3FE
	cmp r1,#0x0	; 037FF400
	beq P2_Entry_037FF408	; 037FF402
	str r2,[r1,#0x14]	; 037FF404
	b P2_Entry_037FF40C	; 037FF406
P2_Entry_037FF408:
	ldr r0,[pool_037FF41C]	; 037FF408
	str r2,[r0,#0x4]	; 037FF40A
P2_Entry_037FF40C:
	cmp r2,#0x0	; 037FF40C
	beq P2_Entry_037FF414	; 037FF40E
	str r1,[r2,#0x18]	; 037FF410
	bx lr	; 037FF412
P2_Entry_037FF414:
	ldr r0,[pool_037FF41C]	; 037FF414
	str r1,[r0,#0x0]	; 037FF416
P2_Entry_037FF418:
	bx lr	; 037FF418
	.byte 0xC0, 0x46	; 037FF41A
pool_037FF41C:
	.word P2_BssStart + 0x86C	; 037FF41C
P2_Entry_037FF420:
	push {lr}	; 037FF420
	sub sp,#0x4	; 037FF422
	ldr r1,[pool_037FF444]	; 037FF424
	ldr r3,[r1,#0x4]	; 037FF426
	str r3,[r0,#0x14]	; 037FF428
	mov r2,#0x0	; 037FF42A
	str r2,[r0,#0x18]	; 037FF42C
	str r0,[r1,#0x4]	; 037FF42E
	cmp r3,#0x0	; 037FF430
	beq P2_Entry_037FF438	; 037FF432
	str r0,[r3,#0x18]	; 037FF434
	b P2_Entry_037FF43E	; 037FF436
P2_Entry_037FF438:
	str r0,[r1,#0x0]	; 037FF438
	bl P2_Entry_037FF2E0	; 037FF43A
P2_Entry_037FF43E:
	add sp,#0x4	; 037FF43E
	pop {r3}	; 037FF440
	bx r3	; 037FF442
pool_037FF444:
	.word P2_BssStart + 0x86C	; 037FF444
P2_Entry_037FF448:
	push {r4,lr}	; 037FF448
	ldr r1,[pool_037FF490]	; 037FF44A
	ldr r1,[r1,#0x0]	; 037FF44C
	mov r2,#0x10	; 037FF44E
	b P2_Entry_037FF482	; 037FF450
P2_Entry_037FF452:
	ldr r4,[r0,#0xc]	; 037FF452
	ldr r3,[r1,#0xc]	; 037FF454
	cmp r3,r4	; 037FF456
	bcc P2_Entry_037FF480	; 037FF458
	cmp r3,r4	; 037FF45A
	bne P2_Entry_037FF466	; 037FF45C
	ldrsh r4,[r1,r2]	; 037FF45E
	ldrsh r3,[r0,r2]	; 037FF460
	cmp r4,r3	; 037FF462
	ble P2_Entry_037FF480	; 037FF464
P2_Entry_037FF466:
	ldr r2,[r1,#0x14]	; 037FF466
	str r2,[r0,#0x14]	; 037FF468
	str r1,[r0,#0x18]	; 037FF46A
	str r0,[r1,#0x14]	; 037FF46C
	cmp r2,#0x0	; 037FF46E
	beq P2_Entry_037FF476	; 037FF470
	str r0,[r2,#0x18]	; 037FF472
	b P2_Entry_037FF48A	; 037FF474
P2_Entry_037FF476:
	ldr r1,[pool_037FF490]	; 037FF476
	str r0,[r1,#0x0]	; 037FF478
	bl P2_Entry_037FF2E0	; 037FF47A
	b P2_Entry_037FF48A	; 037FF47E
P2_Entry_037FF480:
	ldr r1,[r1,#0x18]	; 037FF480
P2_Entry_037FF482:
	cmp r1,#0x0	; 037FF482
	bne P2_Entry_037FF452	; 037FF484
	bl P2_Entry_037FF420	; 037FF486
P2_Entry_037FF48A:
	pop {r4}	; 037FF48A
	pop {r3}	; 037FF48C
	bx r3	; 037FF48E
pool_037FF490:
	.word P2_BssStart + 0x86C	; 037FF490

; ===== function loc_037FF494 =====
loc_037FF494:
	ldr r0,[pool_037FF49C]	; 037FF494
	ldrh r0,[r0,#0x0]	; 037FF496
	bx lr	; 037FF498
	.byte 0xC0, 0x46	; 037FF49C
pool_037FF49C:
loc_037FF49C:
	.word P2_BssStart + 0x860	; 037FF49C

; ===== function loc_037FF4A0 =====
loc_037FF4A0:
	push {lr}	; 037FF4A0
	sub sp,#0x4	; 037FF4A2
	ldr r0,[pool_037FF4D0]	; 037FF4A4
	ldrh r1,[r0,#0x0]	; 037FF4A6
	cmp r1,#0x0	; 037FF4A8
	bne loc_037FF4C8	; 037FF4AA
	mov r1,#0x1	; 037FF4AC
	strh r1,[r0,#0x0]	; 037FF4AE
	mov r1,#0x0	; 037FF4B0
	ldr r0,[pool_037FF4D4]	; 037FF4B2
	str r1,[r0,#0x0]	; 037FF4B4
	str r1,[r0,#0x4]	; 037FF4B6
	mov r0,#0x4	; 037FF4B8
	bl loc_037FDE54	; 037FF4BA
	mov r1,#0x0	; 037FF4BE
	ldr r0,[pool_037FF4D8]	; 037FF4C0
	str r1,[r0,#0x0]	; 037FF4C2
	ldr r0,[pool_037FF4DC]	; 037FF4C4
	str r1,[r0,#0x0]	; 037FF4C6
loc_037FF4C8:
	add sp,#0x4	; 037FF4C8
	pop {r3}	; 037FF4CA
	bx r3	; 037FF4CC
	.byte 0xC0, 0x46	; 037FF4D0
pool_037FF4D0:
loc_037FF4D0:
	.word P2_BssStart + 0x860	; 037FF4D0
pool_037FF4D4:
loc_037FF4D4:
	.word P2_BssStart + 0x86C	; 037FF4D4
pool_037FF4D8:
loc_037FF4D8:
	.word P2_BssStart + 0x868	; 037FF4D8
pool_037FF4DC:
loc_037FF4DC:
	.word P2_BssStart + 0x864	; 037FF4DC
.arm

; ===== function loc_037FF4E0 =====
loc_037FF4E0:
	mrs r0,cpsr	; 037FF4E0
	bic r1,r0,#0x80	; 037FF4E4
	msr cpsr_c,r1	; 037FF4E8
	and r0,r0,#0x80	; 037FF4EC
	bx lr	; 037FF4F0

; ===== function loc_037FF4F4 =====
loc_037FF4F4:
	mrs r0,cpsr	; 037FF4F4
	orr r1,r0,#0x80	; 037FF4F8
	msr cpsr_c,r1	; 037FF4FC
	and r0,r0,#0x80	; 037FF500
	bx lr	; 037FF504

; ===== function loc_037FF508 =====
loc_037FF508:
	mrs r1,cpsr	; 037FF508
	bic r2,r1,#0x80	; 037FF50C
	orr r2,r2,r0	; 037FF510
	msr cpsr_c,r2	; 037FF514
	and r0,r1,#0x80	; 037FF518
	bx lr	; 037FF51C

; ===== function loc_037FF520 =====
loc_037FF520:
	mrs r0,cpsr	; 037FF520
	orr r1,r0,#0xc0	; 037FF524
	msr cpsr_c,r1	; 037FF528
	and r0,r0,#0xc0	; 037FF52C
	bx lr	; 037FF530

; ===== function loc_037FF534 =====
loc_037FF534:
	mrs r1,cpsr	; 037FF534
	bic r2,r1,#0xc0	; 037FF538
	orr r2,r2,r0	; 037FF53C
	msr cpsr_c,r2	; 037FF540
	and r0,r1,#0xc0	; 037FF544
	bx lr	; 037FF548

; ===== function loc_037FF54C =====
loc_037FF54C:
	mrs r0,cpsr	; 037FF54C
	and r0,r0,#0x1f	; 037FF550
	bx lr	; 037FF554
.thumb

; ===== function loc_037FF558 =====
loc_037FF558:
	push {r4,r5,r6,r7,lr}	; 037FF558
	sub sp,#0x4	; 037FF55A
	add r6,r0,#0x0	; 037FF55C
	add r5,r1,#0x0	; 037FF55E
	bl loc_037FE0D0	; 037FF560
	add r7,r0,#0x0	; 037FF564
	ldr r1,[pool_037FF5B0]	; 037FF566
	ldrh r4,[r1,#0x0]	; 037FF568
	mov r0,#0x1	; 037FF56A
	strh r0,[r1,#0x0]	; 037FF56C
	cmp r6,#0x0	; 037FF56E
	beq loc_037FF588	; 037FF570
	ldr r1,[pool_037FF5B4]	; 037FF572
	ldr r0,[r1,#0x0]	; 037FF574
	bic r0,r5	; 037FF576
	str r0,[r1,#0x0]	; 037FF578
	b loc_037FF588	; 037FF57A
loc_037FF57C:
	bl loc_03804CD2	; 037FF57C
	bl loc_037FB074	; 037FF580
	bl loc_037FE0D0	; 037FF584
loc_037FF588:
	ldr r1,[pool_037FF5B4]	; 037FF588
	ldr r0,[r1,#0x0]	; 037FF58A
	add r2,r5,#0x0	; 037FF58C
	and r2,r0	; 037FF58E
	cmp r2,#0x0	; 037FF590
	beq loc_037FF57C	; 037FF592
	ldr r0,[r1,#0x0]	; 037FF594
	bic r0,r5	; 037FF596
	str r0,[r1,#0x0]	; 037FF598
	ldr r1,[pool_037FF5B0]	; 037FF59A
	ldrh r0,[r1,#0x0]	; 037FF59C
	strh r4,[r1,#0x0]	; 037FF59E
	add r0,r7,#0x0	; 037FF5A0
	bl loc_037FE0F4	; 037FF5A2
	add sp,#0x4	; 037FF5A6
	pop {r4,r5,r6,r7}	; 037FF5A8
	pop {r3}	; 037FF5AA
	bx r3	; 037FF5AC
	.byte 0xC0, 0x46	; 037FF5B0
pool_037FF5B0:
loc_037FF5B0:
	.word REG_IME	; 037FF5B0
pool_037FF5B4:
loc_037FF5B4:
	.word Bios7IrqFlagsAddress	; 037FF5B4

; ===== function loc_037FF5B8 =====
loc_037FF5B8:
	lsr r0,r0,#0x2	; 037FF5B8
	ldr r3,[pool_037FF5C0]	; 037FF5BA
	bx r3	; 037FF5BC
	.byte 0xC0, 0x46	; 037FF5C0
pool_037FF5C0:
loc_037FF5C0:
	.word P2_SwiWaitByLoop + 1	; 037FF5C0

; ===== function loc_037FF5C4 =====
loc_037FF5C4:
	push {lr}	; 037FF5C4
	sub sp,#0x4	; 037FF5C6
loc_037FF5C8:
	bl loc_037FE0D0	; 037FF5C8
	bl loc_03804CD2	; 037FF5CC
	b loc_037FF5C8	; 037FF5D0
	.byte 0x00, 0x00	; 037FF5D4

; ===== function loc_037FF5D4 =====
loc_037FF5D4:
	push {r4,lr}	; 037FF5D4
	add r4,r0,#0x0	; 037FF5D6
	bl loc_037FE0D0	; 037FF5D8
	mov r1,#0x6	; 037FF5DC
	mul r4,r1	; 037FF5DE
	add r1,r4,#0x5	; 037FF5E0
	lsl r2,r1,#0x1	; 037FF5E2
	ldr r1,[pool_037FF608]	; 037FF5E4
	add r2,r2,r1	; 037FF5E6
	ldrh r3,[r2,#0x0]	; 037FF5E8
	ldr r1,[pool_037FF60C]	; 037FF5EA
	and r3,r1	; 037FF5EC
	strh r3,[r2,#0x0]	; 037FF5EE
	ldrh r3,[r2,#0x0]	; 037FF5F0
	ldr r1,[pool_037FF610]	; 037FF5F2
	and r3,r1	; 037FF5F4
	strh r3,[r2,#0x0]	; 037FF5F6
	ldrh r1,[r2,#0x0]	; 037FF5F8
	ldrh r1,[r2,#0x0]	; 037FF5FA
	bl loc_037FE0F4	; 037FF5FC
	pop {r4}	; 037FF600
	pop {r3}	; 037FF602
	bx r3	; 037FF604
	.byte 0xC0, 0x46	; 037FF608
pool_037FF608:
loc_037FF608:
	.word REG_DMA0SAD	; 037FF608
pool_037FF60C:
loc_037FF60C:
	.word 0xFFFFCDFF	; 037FF60C
pool_037FF610:
loc_037FF610:
	.word 0xFFFF7FFF	; 037FF610
P2_Entry_037FF614:
	mov r1,#0x3	; 037FF614
	mul r0,r1	; 037FF616
	add r0,r0,#0x2	; 037FF618
	lsl r1,r0,#0x2	; 037FF61A
	ldr r0,[pool_037FF62C]	; 037FF61C
	add r2,r1,r0	; 037FF61E
	ldr r0,[pool_037FF630]	; 037FF620
P2_Entry_037FF622:
	ldr r1,[r2,#0x0]	; 037FF622
	and r1,r0	; 037FF624
	cmp r1,#0x0	; 037FF626
	bne P2_Entry_037FF622	; 037FF628
	bx lr	; 037FF62A
pool_037FF62C:
	.word 0x040000B0	; 037FF62C
pool_037FF630:
	.word 0x80000000	; 037FF630
P2_Entry_037FF634:
	push {r4,r5,r6,r7,lr}	; 037FF634
	sub sp,#0x4	; 037FF636
	add r5,r0,#0x0	; 037FF638
	add r6,r1,#0x0	; 037FF63A
	add r7,r2,#0x0	; 037FF63C
	str r3,[sp,#0x0]	; 037FF63E
	cmp r3,#0x0	; 037FF640
	beq P2_Entry_037FF686	; 037FF642
	mov r0,#0x3	; 037FF644
	add r1,r5,#0x0	; 037FF646
	mul r1,r0	; 037FF648
	add r0,r1,#0x2	; 037FF64A
	lsl r1,r0,#0x2	; 037FF64C
	ldr r0,[pool_037FF690]	; 037FF64E
	add r4,r1,r0	; 037FF650
	ldr r0,[pool_037FF694]	; 037FF652
P2_Entry_037FF654:
	ldr r1,[r4,#0x0]	; 037FF654
	and r1,r0	; 037FF656
	cmp r1,#0x0	; 037FF658
	bne P2_Entry_037FF654	; 037FF65A
	bl loc_037FE0D0	; 037FF65C
	mov r1,#0xc	; 037FF660
	mul r5,r1	; 037FF662
	ldr r1,[pool_037FF690]	; 037FF664
	add r2,r5,r1	; 037FF666
	str r6,[r2,#0x0]	; 037FF668
	str r7,[r2,#0x4]	; 037FF66A
	ldr r3,[sp,#0x0]	; 037FF66C
	lsr r5,r3,#0x1	; 037FF66E
	ldr r3,[pool_037FF694]	; 037FF670
	orr r5,r3	; 037FF672
	str r5,[r2,#0x8]	; 037FF674
	ldr r1,[r1,#0x0]	; 037FF676
	bl loc_037FE0F4	; 037FF678
	ldr r0,[pool_037FF694]	; 037FF67C
P2_Entry_037FF67E:
	ldr r1,[r4,#0x0]	; 037FF67E
	and r1,r0	; 037FF680
	cmp r1,#0x0	; 037FF682
	bne P2_Entry_037FF67E	; 037FF684
P2_Entry_037FF686:
	add sp,#0x4	; 037FF686
	pop {r4,r5,r6,r7}	; 037FF688
	pop {r3}	; 037FF68A
	bx r3	; 037FF68C
	.byte 0xC0, 0x46	; 037FF68E
pool_037FF690:
	.word REG_DMA0SAD	; 037FF690
pool_037FF694:
	.word 0x80000000	; 037FF694
P2_Entry_037FF698:
	push {r4,r5,r6,r7,lr}	; 037FF698
	sub sp,#0x4	; 037FF69A
	add r5,r0,#0x0	; 037FF69C
	add r6,r1,#0x0	; 037FF69E
	add r7,r2,#0x0	; 037FF6A0
	str r3,[sp,#0x0]	; 037FF6A2
	cmp r3,#0x0	; 037FF6A4
	beq P2_Entry_037FF6F2	; 037FF6A6
	mov r0,#0x3	; 037FF6A8
	add r1,r5,#0x0	; 037FF6AA
	mul r1,r0	; 037FF6AC
	add r0,r1,#0x2	; 037FF6AE
	lsl r1,r0,#0x2	; 037FF6B0
	ldr r0,[pool_037FF6FC]	; 037FF6B2
	add r4,r1,r0	; 037FF6B4
	ldr r0,[pool_037FF700]	; 037FF6B6
P2_Entry_037FF6B8:
	ldr r1,[r4,#0x0]	; 037FF6B8
	and r1,r0	; 037FF6BA
	cmp r1,#0x0	; 037FF6BC
	bne P2_Entry_037FF6B8	; 037FF6BE
	bl loc_037FE0D0	; 037FF6C0
	lsl r2,r5,#0x2	; 037FF6C4
	ldr r1,[pool_037FF704]	; 037FF6C6
	add r1,r2,r1	; 037FF6C8
	str r7,[r1,#0x0]	; 037FF6CA
	mov r2,#0xc	; 037FF6CC
	mul r5,r2	; 037FF6CE
	ldr r2,[pool_037FF6FC]	; 037FF6D0
	add r3,r5,r2	; 037FF6D2
	str r1,[r3,#0x0]	; 037FF6D4
	str r6,[r3,#0x4]	; 037FF6D6
	ldr r1,[sp,#0x0]	; 037FF6D8
	lsr r5,r1,#0x1	; 037FF6DA
	ldr r1,[pool_037FF708]	; 037FF6DC
	orr r5,r1	; 037FF6DE
	str r5,[r3,#0x8]	; 037FF6E0
	ldr r1,[r2,#0x0]	; 037FF6E2
	bl loc_037FE0F4	; 037FF6E4
	ldr r0,[pool_037FF700]	; 037FF6E8
P2_Entry_037FF6EA:
	ldr r1,[r4,#0x0]	; 037FF6EA
	and r1,r0	; 037FF6EC
	cmp r1,#0x0	; 037FF6EE
	bne P2_Entry_037FF6EA	; 037FF6F0
P2_Entry_037FF6F2:
	add sp,#0x4	; 037FF6F2
	pop {r4,r5,r6,r7}	; 037FF6F4
	pop {r3}	; 037FF6F6
	bx r3	; 037FF6F8
	.byte 0xC0, 0x46	; 037FF6FA
pool_037FF6FC:
	.word REG_DMA0SAD	; 037FF6FC
pool_037FF700:
	.word 0x80000000	; 037FF700
pool_037FF704:
	.word 0x0380FFE0	; 037FF704
pool_037FF708:
	.word 0x81000000	; 037FF708
.arm

; ===== function loc_037FF70C =====
loc_037FF70C:
	mov r3,#0x0	; 037FF70C
loc_037FF710:
	cmp r3,r2	; 037FF710
	strlth r0,[r1,r3]	; 037FF714
	addlt r3,r3,#0x2	; 037FF718
	blt loc_037FF710	; 037FF71C
	bx lr	; 037FF720
P2_Entry_037FF724:
	mov r12,#0x0	; 037FF724
P2_Entry_037FF728:
	cmp r12,r2	; 037FF728
	ldrlth r3,[r0,r12]	; 037FF72C
	strlth r3,[r1,r12]	; 037FF730
	addlt r12,r12,#0x2	; 037FF734
	blt P2_Entry_037FF728	; 037FF738
	bx lr	; 037FF73C

; ===== function loc_037FF740 =====
loc_037FF740:
	add r12,r1,r2	; 037FF740
loc_037FF744:
	cmp r1,r12	; 037FF744
	stmltia r1!,{r0}	; 037FF748
	blt loc_037FF744	; 037FF74C
	bx lr	; 037FF750

; ===== function loc_037FF754 =====
loc_037FF754:
	add r12,r1,r2	; 037FF754
loc_037FF758:
	cmp r1,r12	; 037FF758
	ldmltia r0!,{r2}	; 037FF75C
	stmltia r1!,{r2}	; 037FF760
	blt loc_037FF758	; 037FF764
	bx lr	; 037FF768
P2_Entry_037FF76C:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 037FF76C
	add r9,r1,r2	; 037FF770
	mov r12,r2, lsr #0x5	; 037FF774
	add r12,r1,r12, lsl #0x5	; 037FF778
	mov r2,r0	; 037FF77C
	mov r3,r2	; 037FF780
	mov r4,r2	; 037FF784
	mov r5,r2	; 037FF788
	mov r6,r2	; 037FF78C
	mov r7,r2	; 037FF790
	mov r8,r2	; 037FF794
P2_Entry_037FF798:
	cmp r1,r12	; 037FF798
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 037FF79C
	blt P2_Entry_037FF798	; 037FF7A0
P2_Entry_037FF7A4:
	cmp r1,r9	; 037FF7A4
	stmltia r1!,{r0}	; 037FF7A8
	blt P2_Entry_037FF7A4	; 037FF7AC
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 037FF7B0
	bx lr	; 037FF7B4

; ===== function loc_037FF7B8 =====
loc_037FF7B8:
	mov r12,#0x0	; 037FF7B8
loc_037FF7BC:
	cmp r12,r2	; 037FF7BC
	strltb r1,[r0,r12]	; 037FF7C0
	addlt r12,r12,#0x1	; 037FF7C4
	blt loc_037FF7BC	; 037FF7C8
	bx lr	; 037FF7CC
P2_Entry_037FF7D0:
	mov r12,#0x0	; 037FF7D0
P2_Entry_037FF7D4:
	cmp r12,r2	; 037FF7D4
	ldrltb r3,[r0,r12]	; 037FF7D8
	strltb r3,[r1,r12]	; 037FF7DC
	addlt r12,r12,#0x1	; 037FF7E0
	blt P2_Entry_037FF7D4	; 037FF7E4
	bx lr	; 037FF7E8

; ===== function loc_037FF7EC =====
loc_037FF7EC:
	swp r0,r0,[r1]	; 037FF7EC
	bx lr	; 037FF7F0
.thumb

; ===== function loc_037FF7F4 =====
loc_037FF7F4:
	push {r4,r5,r6,lr}	; 037FF7F4
	ldr r4,[pool_037FF824]	; 037FF7F6
	ldrb r5,[r4,#0x0]	; 037FF7F8
	mov r4,#0x80	; 037FF7FA
	and r5,r4	; 037FF7FC
	cmp r5,#0x0	; 037FF7FE
	beq loc_037FF806	; 037FF800
	mov r6,#0x1	; 037FF802
	b loc_037FF808	; 037FF804
loc_037FF806:
	mov r6,#0x0	; 037FF806
loc_037FF808:
	lsl r5,r1,#0x2	; 037FF808
	lsl r4,r2,#0x4	; 037FF80A
	lsl r2,r6,#0x7	; 037FF80C
	lsl r1,r3,#0x5	; 037FF80E
	orr r2,r1	; 037FF810
	orr r4,r2	; 037FF812
	orr r5,r4	; 037FF814
	orr r0,r5	; 037FF816
	ldr r1,[pool_037FF824]	; 037FF818
	strb r0,[r1,#0x0]	; 037FF81A
	pop {r4,r5,r6}	; 037FF81C
	pop {r3}	; 037FF81E
	bx r3	; 037FF820
	.byte 0xC0, 0x46	; 037FF824
pool_037FF824:
loc_037FF824:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF824

; ===== function loc_037FF828 =====
loc_037FF828:
	ldr r1,[pool_037FF830]	; 037FF828
	strb r0,[r1,#0x0]	; 037FF82A
	bx lr	; 037FF82C
	.byte 0xC0, 0x46	; 037FF830
pool_037FF830:
loc_037FF830:
	.word REG_SOUNDCNT_ARM7	; 037FF830
P2_Entry_037FF834:
	push {lr}	; 037FF834
	sub sp,#0x4	; 037FF836
	ldr r2,[pool_037FF85C]	; 037FF838
	ldrh r1,[r2,#0x0]	; 037FF83A
	mov r0,#0x1	; 037FF83C
	orr r1,r0	; 037FF83E
	strh r1,[r2,#0x0]	; 037FF840
	bl loc_03804818	; 037FF842
	ldr r0,[pool_037FF860]	; 037FF846
	bl P2_SwiSoundBiasIncrease	; 037FF848
	ldr r0,[pool_037FF864]	; 037FF84C
	bl loc_037FF5B8	; 037FF84E
	bl P2_Entry_037FF8AC	; 037FF852
	add sp,#0x4	; 037FF856
	pop {r3}	; 037FF858
	bx r3	; 037FF85A
pool_037FF85C:
	.word REG_POWERCNT_ARM7	; 037FF85C
pool_037FF860:
	.word 0x00000100	; 037FF860
pool_037FF864:
	.word 0x0007AB80	; 037FF864
P2_Entry_037FF868:
	push {lr}	; 037FF868
	sub sp,#0x4	; 037FF86A
	bl P2_Entry_037FF89C	; 037FF86C
	mov r0,#0x80	; 037FF870
	bl P2_SwiSoundBiasDecrease	; 037FF872
	ldr r0,[pool_037FF894]	; 037FF876
	bl loc_037FF5B8	; 037FF878
	mov r0,#0x1	; 037FF87C
	bl loc_038047FC	; 037FF87E
	ldr r2,[pool_037FF898]	; 037FF882
	ldrh r1,[r2,#0x0]	; 037FF884
	mov r0,#0x1	; 037FF886
	bic r1,r0	; 037FF888
	strh r1,[r2,#0x0]	; 037FF88A
	add sp,#0x4	; 037FF88C
	pop {r3}	; 037FF88E
	bx r3	; 037FF890
	.byte 0xC0, 0x46	; 037FF892
pool_037FF894:
	.word 0x00040000	; 037FF894
pool_037FF898:
	.word REG_POWERCNT_ARM7	; 037FF898
P2_Entry_037FF89C:
	ldr r2,[pool_037FF8A8]	; 037FF89C
	ldrb r1,[r2,#0x0]	; 037FF89E
	mov r0,#0x80	; 037FF8A0
	bic r1,r0	; 037FF8A2
	strb r1,[r2,#0x0]	; 037FF8A4
	bx lr	; 037FF8A6
pool_037FF8A8:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF8A8
P2_Entry_037FF8AC:
	ldr r2,[pool_037FF8B8]	; 037FF8AC
	ldrb r1,[r2,#0x0]	; 037FF8AE
	mov r0,#0x80	; 037FF8B0
	orr r1,r0	; 037FF8B2
	strb r1,[r2,#0x0]	; 037FF8B4
	bx lr	; 037FF8B6
pool_037FF8B8:
	.word REG_SOUNDCNT_ARM7 + 1	; 037FF8B8

; ===== function loc_037FF8BC =====
loc_037FF8BC:
	push {r4,lr}	; 037FF8BC
	cmp r1,#0x18	; 037FF8BE
	bge loc_037FF8D8	; 037FF8C0
	ldr r2,[pool_037FF8F8]	; 037FF8C2
	ldr r3,[r2,#0x0]	; 037FF8C4
	ldr r2,[pool_037FF8FC]	; 037FF8C6
	sub r2,r2,r3	; 037FF8C8
	lsl r2,r2,#0x6	; 037FF8CA
	add r1,#0x28	; 037FF8CC
	mul r3,r1	; 037FF8CE
	add r1,r2,r3	; 037FF8D0
	mul r0,r1	; 037FF8D2
	asr r0,r0,#0x15	; 037FF8D4
	b loc_037FF8F2	; 037FF8D6
loc_037FF8D8:
	cmp r1,#0x68	; 037FF8D8
	ble loc_037FF8F2	; 037FF8DA
	ldr r2,[pool_037FF8F8]	; 037FF8DC
	ldr r4,[r2,#0x0]	; 037FF8DE
	ldr r2,[pool_037FF8FC]	; 037FF8E0
	add r2,r4,r2	; 037FF8E2
	lsl r3,r2,#0x6	; 037FF8E4
	neg r2,r4	; 037FF8E6
	sub r1,#0x28	; 037FF8E8
	mul r2,r1	; 037FF8EA
	add r1,r3,r2	; 037FF8EC
	mul r0,r1	; 037FF8EE
	asr r0,r0,#0x15	; 037FF8F0
loc_037FF8F2:
	pop {r4}	; 037FF8F2
	pop {r3}	; 037FF8F4
	bx r3	; 037FF8F6
pool_037FF8F8:
loc_037FF8F8:
	.word P2_BssStart + 0x874	; 037FF8F8
pool_037FF8FC:
loc_037FF8FC:
	.word 0x00007FFF	; 037FF8FC

; ===== function loc_037FF900 =====
loc_037FF900:
	push {r4,r5,r6,r7,lr}	; 037FF900
	sub sp,#0x4	; 037FF902
	ldr r1,[pool_037FF938]	; 037FF904
	str r0,[r1,#0x0]	; 037FF906
	mov r5,#0x0	; 037FF908
	ldr r6,[pool_037FF93C]	; 037FF90A
	ldr r7,[pool_037FF940]	; 037FF90C
loc_037FF90E:
	mov r0,#0x1	; 037FF90E
	lsl r0,r5	; 037FF910
	and r0,r7	; 037FF912
	cmp r0,#0x0	; 037FF914
	beq loc_037FF928	; 037FF916
	lsl r4,r5,#0x4	; 037FF918
	ldr r0,[pool_037FF944]	; 037FF91A
	ldrb r1,[r4,r0]	; 037FF91C
	ldrb r0,[r6,r5]	; 037FF91E
	bl loc_037FF8BC	; 037FF920
	ldr r1,[pool_037FF948]	; 037FF924
	strb r0,[r4,r1]	; 037FF926
loc_037FF928:
	add r5,r5,#0x1	; 037FF928
	cmp r5,#0x10	; 037FF92A
	blt loc_037FF90E	; 037FF92C
	add sp,#0x4	; 037FF92E
	pop {r4,r5,r6,r7}	; 037FF930
	pop {r3}	; 037FF932
	bx r3	; 037FF934
	.byte 0xC0, 0x46	; 037FF938
pool_037FF938:
loc_037FF938:
	.word P2_BssStart + 0x874	; 037FF938
pool_037FF93C:
loc_037FF93C:
	.word 0x03805FF4	; 037FF93C
pool_037FF940:
loc_037FF940:
	.word 0x0000FFF5	; 037FF940
pool_037FF944:
loc_037FF944:
	.word SCHANNEL0_PAN	; 037FF944
pool_037FF948:
loc_037FF948:
	.word SCHANNEL0_CR	; 037FF948

; ===== function loc_037FF94C =====
loc_037FF94C:
	lsl r1,r0,#0x4	; 037FF94C
	ldr r0,[pool_037FF964]	; 037FF94E
	ldrb r1,[r1,r0]	; 037FF950
	mov r0,#0x80	; 037FF952
	and r1,r0	; 037FF954
	cmp r1,#0x0	; 037FF956
	beq loc_037FF95E	; 037FF958
	mov r0,#0x1	; 037FF95A
	bx lr	; 037FF95C
loc_037FF95E:
	mov r0,#0x0	; 037FF95E
	bx lr	; 037FF960
	.byte 0xC0, 0x46	; 037FF964
pool_037FF964:
loc_037FF964:
	.word 0x04000403	; 037FF964

; ===== function loc_037FF968 =====
loc_037FF968:
	push {r4,lr}	; 037FF968
	lsl r4,r0,#0x4	; 037FF96A
	ldr r2,[pool_037FF998]	; 037FF96C
	strb r1,[r4,r2]	; 037FF96E
	ldr r2,[pool_037FF99C]	; 037FF970
	ldr r2,[r2,#0x0]	; 037FF972
	cmp r2,#0x0	; 037FF974
	ble loc_037FF990	; 037FF976
	mov r3,#0x1	; 037FF978
	lsl r3,r0	; 037FF97A
	ldr r2,[pool_037FF9A0]	; 037FF97C
	and r3,r2	; 037FF97E
	cmp r3,#0x0	; 037FF980
	beq loc_037FF990	; 037FF982
	ldr r2,[pool_037FF9A4]	; 037FF984
	ldrb r0,[r2,r0]	; 037FF986
	bl loc_037FF8BC	; 037FF988
	ldr r1,[pool_037FF9A8]	; 037FF98C
	strb r0,[r4,r1]	; 037FF98E
loc_037FF990:
	pop {r4}	; 037FF990
	pop {r3}	; 037FF992
	bx r3	; 037FF994
	.byte 0xC0, 0x46	; 037FF998
pool_037FF998:
loc_037FF998:
	.word SCHANNEL0_PAN	; 037FF998
pool_037FF99C:
loc_037FF99C:
	.word P2_BssStart + 0x874	; 037FF99C
pool_037FF9A0:
loc_037FF9A0:
	.word 0x0000FFF5	; 037FF9A0
pool_037FF9A4:
loc_037FF9A4:
	.word P2_BssStart + 0x878	; 037FF9A4
pool_037FF9A8:
loc_037FF9A8:
	.word SCHANNEL0_CR	; 037FF9A8

; ===== function loc_037FF9AC =====
loc_037FF9AC:
	ldr r2,[pool_037FF9B8]	; 037FF9AC
	sub r2,r2,r1	; 037FF9AE
	lsl r1,r0,#0x4	; 037FF9B0
	ldr r0,[pool_037FF9BC]	; 037FF9B2
	strh r2,[r1,r0]	; 037FF9B4
	bx lr	; 037FF9B6
pool_037FF9B8:
loc_037FF9B8:
	.word 0x00010000	; 037FF9B8
pool_037FF9BC:
loc_037FF9BC:
	.word SCHANNEL0_TIMER	; 037FF9BC

; ===== function loc_037FF9C0 =====
loc_037FF9C0:
	push {r4,r5,lr}	; 037FF9C0
	sub sp,#0x4	; 037FF9C2
	add r5,r0,#0x0	; 037FF9C4
	add r4,r2,#0x0	; 037FF9C6
	ldr r0,[pool_037FFA04]	; 037FF9C8
	strb r1,[r0,r5]	; 037FF9CA
	ldr r0,[pool_037FFA08]	; 037FF9CC
	ldr r0,[r0,#0x0]	; 037FF9CE
	cmp r0,#0x0	; 037FF9D0
	ble loc_037FF9F0	; 037FF9D2
	mov r2,#0x1	; 037FF9D4
	lsl r2,r5	; 037FF9D6
	ldr r0,[pool_037FFA0C]	; 037FF9D8
	and r2,r0	; 037FF9DA
	cmp r2,#0x0	; 037FF9DC
	beq loc_037FF9F0	; 037FF9DE
	lsl r2,r5,#0x4	; 037FF9E0
	ldr r0,[pool_037FFA10]	; 037FF9E2
	ldrb r2,[r2,r0]	; 037FF9E4
	add r0,r1,#0x0	; 037FF9E6
	add r1,r2,#0x0	; 037FF9E8
	bl loc_037FF8BC	; 037FF9EA
	add r1,r0,#0x0	; 037FF9EE
loc_037FF9F0:
	lsl r2,r4,#0x8	; 037FF9F0
	orr r2,r1	; 037FF9F2
	lsl r1,r5,#0x4	; 037FF9F4
	ldr r0,[pool_037FFA14]	; 037FF9F6
	strh r2,[r1,r0]	; 037FF9F8
	add sp,#0x4	; 037FF9FA
	pop {r4,r5}	; 037FF9FC
	pop {r3}	; 037FF9FE
	bx r3	; 037FFA00
	.byte 0xC0, 0x46	; 037FFA04
pool_037FFA04:
loc_037FFA04:
	.word P2_BssStart + 0x878	; 037FFA04
pool_037FFA08:
loc_037FFA08:
	.word P2_BssStart + 0x874	; 037FFA08
pool_037FFA0C:
loc_037FFA0C:
	.word 0x0000FFF5	; 037FFA0C
pool_037FFA10:
loc_037FFA10:
	.word SCHANNEL0_PAN	; 037FFA10
pool_037FFA14:
loc_037FFA14:
	.word SCHANNEL0_CR	; 037FFA14

; ===== function loc_037FFA18 =====
loc_037FFA18:
	lsl r2,r0,#0x4	; 037FFA18
	ldr r0,[pool_037FFA34]	; 037FFA1A
	add r3,r2,r0	; 037FFA1C
	ldr r2,[r3,#0x0]	; 037FFA1E
	ldr r0,[pool_037FFA38]	; 037FFA20
	and r2,r0	; 037FFA22
	mov r0,#0x1	; 037FFA24
	and r1,r0	; 037FFA26
	cmp r1,#0x0	; 037FFA28
	beq loc_037FFA30	; 037FFA2A
	ldr r0,[pool_037FFA3C]	; 037FFA2C
	orr r2,r0	; 037FFA2E
loc_037FFA30:
	str r2,[r3,#0x0]	; 037FFA30
	bx lr	; 037FFA32
pool_037FFA34:
loc_037FFA34:
	.word SCHANNEL0_CR	; 037FFA34
pool_037FFA38:
loc_037FFA38:
	.word 0x7FFFFFFF	; 037FFA38
pool_037FFA3C:
loc_037FFA3C:
	.word 0x00008000	; 037FFA3C

; ===== function loc_037FFA40 =====
loc_037FFA40:
	push {r4,r5,r6,lr}	; 037FFA40
	add r5,r2,#0x0	; 037FFA42
	add r6,r3,#0x0	; 037FFA44
	lsl r4,r0,#0x4	; 037FFA46
	ldr r2,[pool_037FFA8C]	; 037FFA48
	strb r1,[r2,r0]	; 037FFA4A
	ldr r2,[pool_037FFA90]	; 037FFA4C
	ldr r2,[r2,#0x0]	; 037FFA4E
	cmp r2,#0x0	; 037FFA50
	ble loc_037FFA6A	; 037FFA52
	mov r2,#0x1	; 037FFA54
	lsl r2,r0	; 037FFA56
	ldr r0,[pool_037FFA94]	; 037FFA58
	and r2,r0	; 037FFA5A
	cmp r2,#0x0	; 037FFA5C
	beq loc_037FFA6A	; 037FFA5E
	add r0,r1,#0x0	; 037FFA60
	ldr r1,[sp,#0x10]	; 037FFA62
	bl loc_037FF8BC	; 037FFA64
	add r1,r0,#0x0	; 037FFA68
loc_037FFA6A:
	ldr r0,[sp,#0x10]	; 037FFA6A
	lsl r2,r0,#0x10	; 037FFA6C
	ldr r0,[pool_037FFA98]	; 037FFA6E
	orr r2,r0	; 037FFA70
	lsl r0,r5,#0x8	; 037FFA72
	orr r2,r0	; 037FFA74
	orr r1,r2	; 037FFA76
	ldr r0,[pool_037FFA9C]	; 037FFA78
	str r1,[r4,r0]	; 037FFA7A
	ldr r0,[pool_037FFAA0]	; 037FFA7C
	sub r1,r0,r6	; 037FFA7E
	ldr r0,[pool_037FFAA4]	; 037FFA80
	strh r1,[r4,r0]	; 037FFA82
	pop {r4,r5,r6}	; 037FFA84
	pop {r3}	; 037FFA86
	bx r3	; 037FFA88
	.byte 0xC0, 0x46	; 037FFA8C
pool_037FFA8C:
loc_037FFA8C:
	.word P2_BssStart + 0x878	; 037FFA8C
pool_037FFA90:
loc_037FFA90:
	.word P2_BssStart + 0x874	; 037FFA90
pool_037FFA94:
loc_037FFA94:
	.word 0x0000FFF5	; 037FFA94
pool_037FFA98:
loc_037FFA98:
	.word 0x60000000	; 037FFA98
pool_037FFA9C:
loc_037FFA9C:
	.word SCHANNEL0_CR	; 037FFA9C
pool_037FFAA0:
loc_037FFAA0:
	.word 0x00010000	; 037FFAA0
pool_037FFAA4:
loc_037FFAA4:
	.word SCHANNEL0_TIMER	; 037FFAA4

; ===== function loc_037FFAA8 =====
loc_037FFAA8:
	push {r4,r5,r6,lr}	; 037FFAA8
	add r5,r1,#0x0	; 037FFAAA
	add r6,r3,#0x0	; 037FFAAC
	lsl r4,r0,#0x4	; 037FFAAE
	ldr r1,[pool_037FFAF8]	; 037FFAB0
	strb r2,[r1,r0]	; 037FFAB2
	ldr r1,[pool_037FFAFC]	; 037FFAB4
	ldr r1,[r1,#0x0]	; 037FFAB6
	cmp r1,#0x0	; 037FFAB8
	ble loc_037FFAD2	; 037FFABA
	mov r1,#0x1	; 037FFABC
	lsl r1,r0	; 037FFABE
	ldr r0,[pool_037FFB00]	; 037FFAC0
	and r1,r0	; 037FFAC2
	cmp r1,#0x0	; 037FFAC4
	beq loc_037FFAD2	; 037FFAC6
	add r0,r2,#0x0	; 037FFAC8
	ldr r1,[sp,#0x14]	; 037FFACA
	bl loc_037FF8BC	; 037FFACC
	add r2,r0,#0x0	; 037FFAD0
loc_037FFAD2:
	lsl r0,r6,#0x8	; 037FFAD2
	lsl r3,r5,#0x18	; 037FFAD4
	ldr r1,[pool_037FFB04]	; 037FFAD6
	orr r3,r1	; 037FFAD8
	ldr r1,[sp,#0x14]	; 037FFADA
	lsl r1,r1,#0x10	; 037FFADC
	orr r3,r1	; 037FFADE
	orr r0,r3	; 037FFAE0
	orr r2,r0	; 037FFAE2
	ldr r0,[pool_037FFB08]	; 037FFAE4
	str r2,[r4,r0]	; 037FFAE6
	ldr r1,[sp,#0x10]	; 037FFAE8
	ldr r0,[pool_037FFB0C]	; 037FFAEA
	sub r1,r0,r1	; 037FFAEC
	ldr r0,[pool_037FFB10]	; 037FFAEE
	strh r1,[r4,r0]	; 037FFAF0
	pop {r4,r5,r6}	; 037FFAF2
	pop {r3}	; 037FFAF4
	bx r3	; 037FFAF6
pool_037FFAF8:
loc_037FFAF8:
	.word P2_BssStart + 0x878	; 037FFAF8
pool_037FFAFC:
loc_037FFAFC:
	.word P2_BssStart + 0x874	; 037FFAFC
pool_037FFB00:
loc_037FFB00:
	.word 0x0000FFF5	; 037FFB00
pool_037FFB04:
loc_037FFB04:
	.word 0x60000000	; 037FFB04
pool_037FFB08:
loc_037FFB08:
	.word SCHANNEL0_CR	; 037FFB08
pool_037FFB0C:
loc_037FFB0C:
	.word 0x00010000	; 037FFB0C
pool_037FFB10:
loc_037FFB10:
	.word SCHANNEL0_TIMER	; 037FFB10

; ===== function loc_037FFB14 =====
loc_037FFB14:
	push {r4,r5,r6,r7,lr}	; 037FFB14
	sub sp,#0x4	; 037FFB16
	add r5,r1,#0x0	; 037FFB18
	add r6,r2,#0x0	; 037FFB1A
	add r7,r3,#0x0	; 037FFB1C
	ldr r1,[sp,#0x20]	; 037FFB1E
	lsl r4,r0,#0x4	; 037FFB20
	ldr r2,[pool_037FFB80]	; 037FFB22
	strb r1,[r2,r0]	; 037FFB24
	ldr r2,[pool_037FFB84]	; 037FFB26
	ldr r2,[r2,#0x0]	; 037FFB28
	cmp r2,#0x0	; 037FFB2A
	ble loc_037FFB44	; 037FFB2C
	mov r2,#0x1	; 037FFB2E
	lsl r2,r0	; 037FFB30
	ldr r0,[pool_037FFB88]	; 037FFB32
	and r2,r0	; 037FFB34
	cmp r2,#0x0	; 037FFB36
	beq loc_037FFB44	; 037FFB38
	add r0,r1,#0x0	; 037FFB3A
	ldr r1,[sp,#0x2c]	; 037FFB3C
	bl loc_037FF8BC	; 037FFB3E
	add r1,r0,#0x0	; 037FFB42
loc_037FFB44:
	ldr r0,[sp,#0x24]	; 037FFB44
	lsl r2,r0,#0x8	; 037FFB46
	ldr r0,[sp,#0x2c]	; 037FFB48
	lsl r0,r0,#0x10	; 037FFB4A
	lsl r3,r6,#0x1d	; 037FFB4C
	lsl r6,r7,#0x1b	; 037FFB4E
	orr r3,r6	; 037FFB50
	orr r0,r3	; 037FFB52
	orr r2,r0	; 037FFB54
	orr r1,r2	; 037FFB56
	ldr r0,[pool_037FFB8C]	; 037FFB58
	str r1,[r4,r0]	; 037FFB5A
	ldr r1,[sp,#0x28]	; 037FFB5C
	ldr r0,[pool_037FFB90]	; 037FFB5E
	sub r1,r0,r1	; 037FFB60
	ldr r0,[pool_037FFB94]	; 037FFB62
	strh r1,[r4,r0]	; 037FFB64
	ldr r1,[sp,#0x18]	; 037FFB66
	ldr r0,[pool_037FFB98]	; 037FFB68
	strh r1,[r4,r0]	; 037FFB6A
	ldr r1,[sp,#0x1c]	; 037FFB6C
	ldr r0,[pool_037FFB9C]	; 037FFB6E
	str r1,[r4,r0]	; 037FFB70
	ldr r0,[pool_037FFBA0]	; 037FFB72
	str r5,[r4,r0]	; 037FFB74
	add sp,#0x4	; 037FFB76
	pop {r4,r5,r6,r7}	; 037FFB78
	pop {r3}	; 037FFB7A
	bx r3	; 037FFB7C
	.byte 0xC0, 0x46	; 037FFB80
pool_037FFB80:
loc_037FFB80:
	.word P2_BssStart + 0x878	; 037FFB80
pool_037FFB84:
loc_037FFB84:
	.word P2_BssStart + 0x874	; 037FFB84
pool_037FFB88:
loc_037FFB88:
	.word 0x0000FFF5	; 037FFB88
pool_037FFB8C:
loc_037FFB8C:
	.word SCHANNEL0_CR	; 037FFB8C
pool_037FFB90:
loc_037FFB90:
	.word 0x00010000	; 037FFB90
pool_037FFB94:
loc_037FFB94:
	.word SCHANNEL0_TIMER	; 037FFB94
pool_037FFB98:
loc_037FFB98:
	.word 0x0400040A	; 037FFB98
pool_037FFB9C:
loc_037FFB9C:
	.word 0x0400040C	; 037FFB9C
pool_037FFBA0:
loc_037FFBA0:
	.word 0x04000404	; 037FFBA0

; ===== function loc_037FFBA4 =====
loc_037FFBA4:
	ldr r1,[pool_037FFBBC]	; 037FFBA4
	ldr r2,[r1,#0x0]	; 037FFBA6
	ldr r0,[pool_037FFBC0]	; 037FFBA8
	mul r2,r0	; 037FFBAA
	ldr r0,[pool_037FFBC4]	; 037FFBAC
	add r0,r2,r0	; 037FFBAE
	str r0,[r1,#0x0]	; 037FFBB0
	lsr r0,r0,#0x10	; 037FFBB2
	lsl r0,r0,#0x10	; 037FFBB4
	lsr r0,r0,#0x10	; 037FFBB6
	bx lr	; 037FFBB8
	.byte 0xC0, 0x46	; 037FFBBC
pool_037FFBBC:
loc_037FFBBC:
	.word P2_Data_038056C0	; 037FFBBC
pool_037FFBC0:
loc_037FFBC0:
	.word 0x0019660D	; 037FFBC0
pool_037FFBC4:
loc_037FFBC4:
	.word 0x3C6EF35F	; 037FFBC4

; ===== function loc_037FFBC8 =====
loc_037FFBC8:
	cmp r0,#0x20	; 037FFBC8
	bge loc_037FFBD2	; 037FFBCA
	ldr r1,[pool_037FFC04]	; 037FFBCC
	ldrsb r0,[r1,r0]	; 037FFBCE
	bx lr	; 037FFBD0
loc_037FFBD2:
	cmp r0,#0x40	; 037FFBD2
	bge loc_037FFBE0	; 037FFBD4
	mov r1,#0x40	; 037FFBD6
	sub r1,r1,r0	; 037FFBD8
	ldr r0,[pool_037FFC04]	; 037FFBDA
	ldrsb r0,[r0,r1]	; 037FFBDC
	bx lr	; 037FFBDE
loc_037FFBE0:
	cmp r0,#0x60	; 037FFBE0
	bge loc_037FFBF2	; 037FFBE2
	sub r0,#0x40	; 037FFBE4
	ldr r1,[pool_037FFC04]	; 037FFBE6
	ldrsb r0,[r1,r0]	; 037FFBE8
	neg r0,r0	; 037FFBEA
	lsl r0,r0,#0x18	; 037FFBEC
	asr r0,r0,#0x18	; 037FFBEE
	bx lr	; 037FFBF0
loc_037FFBF2:
	sub r0,#0x60	; 037FFBF2
	mov r1,#0x20	; 037FFBF4
	sub r1,r1,r0	; 037FFBF6
	ldr r0,[pool_037FFC04]	; 037FFBF8
	ldrsb r0,[r0,r1]	; 037FFBFA
	neg r0,r0	; 037FFBFC
	lsl r0,r0,#0x18	; 037FFBFE
	asr r0,r0,#0x18	; 037FFC00
	bx lr	; 037FFC02
pool_037FFC04:
loc_037FFC04:
	.word P2_Data_038054E0	; 037FFC04

; ===== function loc_037FFC08 =====
loc_037FFC08:
	push {r4,lr}	; 037FFC08
	add r4,r0,#0x0	; 037FFC0A
	ldr r0,[pool_037FFC58]	; 037FFC0C
	cmp r4,r0	; 037FFC0E
	bge loc_037FFC16	; 037FFC10
	add r4,r0,#0x0	; 037FFC12
	b loc_037FFC1C	; 037FFC14
loc_037FFC16:
	cmp r4,#0x0	; 037FFC16
	ble loc_037FFC1C	; 037FFC18
	mov r4,#0x0	; 037FFC1A
loc_037FFC1C:
	ldr r0,[pool_037FFC5C]	; 037FFC1C
	add r0,r4,r0	; 037FFC1E
	bl loc_03804D2C	; 037FFC20
	mov r1,#0xef	; 037FFC24
	mvn r1,r1	; 037FFC26
	cmp r4,r1	; 037FFC28
	bge loc_037FFC30	; 037FFC2A
	mov r1,#0x3	; 037FFC2C
	b loc_037FFC4A	; 037FFC2E
loc_037FFC30:
	mov r1,#0x77	; 037FFC30
	mvn r1,r1	; 037FFC32
	cmp r4,r1	; 037FFC34
	bge loc_037FFC3C	; 037FFC36
	mov r1,#0x2	; 037FFC38
	b loc_037FFC4A	; 037FFC3A
loc_037FFC3C:
	mov r1,#0x3b	; 037FFC3C
	mvn r1,r1	; 037FFC3E
	cmp r4,r1	; 037FFC40
	bge loc_037FFC48	; 037FFC42
	mov r1,#0x1	; 037FFC44
	b loc_037FFC4A	; 037FFC46
loc_037FFC48:
	mov r1,#0x0	; 037FFC48
loc_037FFC4A:
	lsl r1,r1,#0x8	; 037FFC4A
	orr r1,r0	; 037FFC4C
	lsl r0,r1,#0x10	; 037FFC4E
	lsr r0,r0,#0x10	; 037FFC50
	pop {r4}	; 037FFC52
	pop {r3}	; 037FFC54
	bx r3	; 037FFC56
pool_037FFC58:
loc_037FFC58:
	.word 0xFFFFFD2D	; 037FFC58
pool_037FFC5C:
loc_037FFC5C:
	.word 0x000002D3	; 037FFC5C

; ===== function loc_037FFC60 =====
loc_037FFC60:
	push {r4,r5,r6,lr}	; 037FFC60
	add r5,r0,#0x0	; 037FFC62
	mov r4,#0x0	; 037FFC64
	neg r0,r1	; 037FFC66
	ldr r1,[pool_037FFD0C]	; 037FFC68
	b loc_037FFC70	; 037FFC6A
loc_037FFC6C:
	sub r4,r4,#0x1	; 037FFC6C
	add r0,r0,r1	; 037FFC6E
loc_037FFC70:
	cmp r0,#0x0	; 037FFC70
	blt loc_037FFC6C	; 037FFC72
	ldr r1,[pool_037FFD0C]	; 037FFC74
	b loc_037FFC7C	; 037FFC76
loc_037FFC78:
	add r4,r4,#0x1	; 037FFC78
	sub r0,r0,r1	; 037FFC7A
loc_037FFC7C:
	cmp r0,r1	; 037FFC7C
	bge loc_037FFC78	; 037FFC7E
	bl loc_03804D28	; 037FFC80
	mov r1,#0x0	; 037FFC84
	ldr r2,[pool_037FFD10]	; 037FFC86
	add r0,r0,r2	; 037FFC88
	adc r1,r1	; 037FFC8A
	asr r3,r5,#0x1f	; 037FFC8C
	add r2,r5,#0x0	; 037FFC8E
	bl loc_037FF018	; 037FFC90
	add r6,r0,#0x0	; 037FFC94
	add r5,r1,#0x0	; 037FFC96
	add r2,r4,#0x0	; 037FFC98
	sub r2,#0x10	; 037FFC9A
	cmp r2,#0x0	; 037FFC9C
	bgt loc_037FFCAA	; 037FFC9E
	neg r2,r2	; 037FFCA0
	bl loc_037FFD18	; 037FFCA2
	add r5,r1,#0x0	; 037FFCA6
	b loc_037FFCE6	; 037FFCA8
loc_037FFCAA:
	cmp r2,#0x20	; 037FFCAA
	bge loc_037FFCE2	; 037FFCAC
	mov r0,#0x0	; 037FFCAE
	mvn r0,r0	; 037FFCB0
	add r1,r0,#0x0	; 037FFCB2
	mov r3,#0x20	; 037FFCB4
	sub r2,r3,r2	; 037FFCB6
	bl loc_037FFD24	; 037FFCB8
	add r2,r5,#0x0	; 037FFCBC
	and r2,r1	; 037FFCBE
	add r1,r6,#0x0	; 037FFCC0
	and r1,r0	; 037FFCC2
	mov r0,#0x0	; 037FFCC4
	eor r2,r0	; 037FFCC6
	eor r1,r0	; 037FFCC8
	orr r2,r1	; 037FFCCA
	beq loc_037FFCD2	; 037FFCCC
	ldr r0,[pool_037FFD14]	; 037FFCCE
	b loc_037FFD04	; 037FFCD0
loc_037FFCD2:
	add r0,r6,#0x0	; 037FFCD2
	add r1,r5,#0x0	; 037FFCD4
	sub r4,#0x10	; 037FFCD6
	add r2,r4,#0x0	; 037FFCD8
	bl loc_037FFD24	; 037FFCDA
	add r5,r1,#0x0	; 037FFCDE
	b loc_037FFCE6	; 037FFCE0
loc_037FFCE2:
	ldr r0,[pool_037FFD14]	; 037FFCE2
	b loc_037FFD04	; 037FFCE4
loc_037FFCE6:
	mov r2,#0x0	; 037FFCE6
	mov r1,#0x10	; 037FFCE8
	sub r1,r0,r1	; 037FFCEA
	lsl r1,r5,#0	; 037FFCEC
	sbc r1,r2	; 037FFCEE
	bcs loc_037FFCF6	; 037FFCF0
	mov r0,#0x10	; 037FFCF2
	b loc_037FFD00	; 037FFCF4
loc_037FFCF6:
	ldr r1,[pool_037FFD14]	; 037FFCF6
	sub r1,r1,r0	; 037FFCF8
	sbc r2,r5	; 037FFCFA
	bcs loc_037FFD00	; 037FFCFC
	ldr r0,[pool_037FFD14]	; 037FFCFE
loc_037FFD00:
	lsl r0,r0,#0x10	; 037FFD00
	lsr r0,r0,#0x10	; 037FFD02
loc_037FFD04:
	pop {r4,r5,r6}	; 037FFD04
	pop {r3}	; 037FFD06
	bx r3	; 037FFD08
	.byte 0xC0, 0x46	; 037FFD0C
pool_037FFD0C:
loc_037FFD0C:
	.word 0x00000300	; 037FFD0C
pool_037FFD10:
loc_037FFD10:
	.word 0x00010000	; 037FFD10
pool_037FFD14:
loc_037FFD14:
	.word 0x0000FFFF	; 037FFD14

; ===== function loc_037FFD18 =====
loc_037FFD18:
	bx pc	; 037FFD18
	.byte 0xC0, 0x46	; 037FFD1C
.arm

; ===== function loc_037FFD1C =====
loc_037FFD1C:
	ldr pc,[pool_037FFD20]	; 037FFD1C
pool_037FFD20:
loc_037FFD20:
	.word loc_03805378	; 037FFD20
.thumb

; ===== function loc_037FFD24 =====
loc_037FFD24:
	bx pc	; 037FFD24
	.byte 0xC0, 0x46	; 037FFD28
.arm

; ===== function loc_037FFD28 =====
loc_037FFD28:
	ldr pc,[pool_037FFD2C]	; 037FFD28
pool_037FFD2C:
loc_037FFD2C:
	.word loc_03804F58	; 037FFD2C
.thumb
P2_ThreadEntry_037FFD30:
	push {r4,r5,r6,lr}	; 037FFD30
	bl P2_Entry_037FFE30	; 037FFD32
	bl P2_Entry_03800874	; 037FFD36
	bl P2_Entry_0380194C	; 037FFD3A
	bl P2_Entry_03801CFC	; 037FFD3E
	bl P2_Entry_037FF8AC	; 037FFD42
	mov r0,#0x0	; 037FFD46
	add r1,r0,#0x0	; 037FFD48
	add r2,r0,#0x0	; 037FFD4A
	add r3,r0,#0x0	; 037FFD4C
	bl loc_037FF7F4	; 037FFD4E
	mov r0,#0x7f	; 037FFD52
	bl loc_037FF828	; 037FFD54
	bl P2_Entry_037FFDF0	; 037FFD58
	mov r6,#0x1	; 037FFD5C
	mov r4,#0x0	; 037FFD5E
P2_Entry_037FFD60:
	add r5,r4,#0x0	; 037FFD60
	bl P2_Entry_037FFDD4	; 037FFD62
	cmp r0,#0x1	; 037FFD66
	beq P2_Entry_037FFD6E	; 037FFD68
	cmp r0,#0x2	; 037FFD6A
	b P2_Entry_037FFD70	; 037FFD6C
P2_Entry_037FFD6E:
	add r5,r6,#0x0	; 037FFD6E
P2_Entry_037FFD70:
	bl P2_Entry_03800734	; 037FFD70
	bl P2_Entry_03801F5C	; 037FFD74
	add r0,r5,#0x0	; 037FFD78
	bl P2_Entry_038018F0	; 037FFD7A
	add r0,r5,#0x0	; 037FFD7E
	bl P2_Entry_03800544	; 037FFD80
	bl loc_03801B40	; 037FFD84
	bl loc_037FFBA4	; 037FFD88
	b P2_Entry_037FFD60	; 037FFD8C
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xA9, 0xFC	; 037FFD8E
	.byte 0x00, 0x28, 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0x60, 0xFB, 0x01, 0xB0	; 037FFD9E
	.byte 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x04, 0x60, 0x80, 0x03, 0xC4, 0x56, 0x80, 0x03, 0xBC, 0x56	; 037FFDAE
	.byte 0x80, 0x03	; 037FFDBE
.arm
.thumb

; ===== function loc_037FFDC0 =====
loc_037FFDC0:
	ldr r0,[pool_037FFDCC]	; 037FFDC0
	mov r1,#0x2	; 037FFDC2
	mov r2,#0x0	; 037FFDC4
	ldr r3,[pool_037FFDD0]	; 037FFDC6
	bx r3	; 037FFDC8
	.byte 0xC0, 0x46	; 037FFDCC
pool_037FFDCC:
loc_037FFDCC:
	.word 0x03806004	; 037FFDCC
pool_037FFDD0:
loc_037FFDD0:
	.word loc_037FE6F0 + 1	; 037FFDD0

; ===== function loc_037FFDD4 =====
P2_Entry_037FFDD4:
	push {lr}	; 037FFDD4
	sub sp,#0x4	; 037FFDD6
	ldr r0,[pool_037FFDEC]	; 037FFDD8
	add r1,sp,#0x0	; 037FFDDA
	mov r2,#0x1	; 037FFDDC
	bl loc_037FE678	; 037FFDDE
	ldr r0,[sp,#0x0]	; 037FFDE2
	add sp,#0x4	; 037FFDE4
	pop {r3}	; 037FFDE6
	bx r3	; 037FFDE8
	.byte 0xC0, 0x46	; 037FFDEC
pool_037FFDEC:
loc_037FFDEC:
	.word 0x03806004	; 037FFDEC
P2_Entry_037FFDF0:
	push {r4,r5,lr}	; 037FFDF0
	sub sp,#0xc	; 037FFDF2
	bl loc_037FEC58	; 037FFDF4
	add r4,r0,#0x0	; 037FFDF8
	ldr r0,[pool_037FFE20]	; 037FFDFA
	str r0,[sp,#0x4]	; 037FFDFC
	mov r5,#0x0	; 037FFDFE
	str r5,[sp,#0x8]	; 037FFE00
	ldr r3,[pool_037FFE24]	; 037FFE02
	str r5,[sp,#0x0]	; 037FFE04
	ldr r0,[pool_037FFE28]	; 037FFE06
	ldr r2,[pool_037FFE2C]	; 037FFE08
	add r4,r4,r2	; 037FFE0A
	lsl r2,r1,#0	; 037FFE0C
	adc r2,r5	; 037FFE0E
	add r1,r4,#0x0	; 037FFE10
	bl loc_037FEEA8	; 037FFE12
	add sp,#0xc	; 037FFE16
	pop {r4,r5}	; 037FFE18
	pop {r3}	; 037FFE1A
	bx r3	; 037FFE1C
	.byte 0xC0, 0x46	; 037FFE1E
pool_037FFE20:
	.word 0x037FFD91	; 037FFE20
pool_037FFE24:
	.word 0x00000AA8	; 037FFE24
pool_037FFE28:
	.word 0x03806038	; 037FFE28
pool_037FFE2C:
	.word 0x00010000	; 037FFE2C
P2_Entry_037FFE30:
	push {lr}	; 037FFE30
	sub sp,#0x4	; 037FFE32
	ldr r0,[pool_037FFE4C]	; 037FFE34
	ldr r1,[pool_037FFE50]	; 037FFE36
	mov r2,#0x8	; 037FFE38
	bl loc_037FE74C	; 037FFE3A
	ldr r0,[pool_037FFE54]	; 037FFE3E
	bl loc_037FF024	; 037FFE40
	add sp,#0x4	; 037FFE44
	pop {r3}	; 037FFE46
	bx r3	; 037FFE48
	.byte 0xC0, 0x46	; 037FFE4A
pool_037FFE4C:
	.word 0x03806004	; 037FFE4C
pool_037FFE50:
	.word 0x03806018	; 037FFE50
pool_037FFE54:
	.word 0x03806038	; 037FFE54

; ===== function loc_037FFE58 =====
loc_037FFE58:
	push {lr}	; 037FFE58
	sub sp,#0xc	; 037FFE5A
	ldr r1,[pool_037FFE7C]	; 037FFE5C
	str r1,[sp,#0x0]	; 037FFE5E
	str r0,[sp,#0x4]	; 037FFE60
	ldr r0,[pool_037FFE80]	; 037FFE62
	ldr r1,[pool_037FFE84]	; 037FFE64
	mov r2,#0x0	; 037FFE66
	ldr r3,[pool_037FFE88]	; 037FFE68
	bl P2_CreateThread	; 037FFE6A
	ldr r0,[pool_037FFE80]	; 037FFE6E
	bl loc_037FE2D0	; 037FFE70
	add sp,#0xc	; 037FFE74
	pop {r3}	; 037FFE76
	bx r3	; 037FFE78
	.byte 0xC0, 0x46	; 037FFE7C
pool_037FFE7C:
loc_037FFE7C:
	.word 0x00000400	; 037FFE7C
pool_037FFE80:
loc_037FFE80:
	.word 0x03806064	; 037FFE80
pool_037FFE84:
loc_037FFE84:
	.word P2_ThreadEntry_037FFD30 + 1	; 037FFE84
pool_037FFE88:
loc_037FFE88:
	.word 0x038064DC	; 037FFE88

; ===== function loc_037FFE8C =====
loc_037FFE8C:
	push {r4,lr}	; 037FFE8C
	add r4,r0,#0x0	; 037FFE8E
	bl loc_03802214	; 037FFE90
	add r0,r4,#0x0	; 037FFE94
	bl loc_037FFE58	; 037FFE96
	pop {r4}	; 037FFE9A
	pop {r3}	; 037FFE9C
	bx r3	; 037FFE9E

; ===== function loc_037FFEA0 =====
loc_037FFEA0:
	ldr r1,[pool_037FFEB4]	; 037FFEA0
	ldrb r1,[r0,r1]	; 037FFEA2
	mov r0,#0x80	; 037FFEA4
	and r1,r0	; 037FFEA6
	cmp r1,#0x0	; 037FFEA8
	beq loc_037FFEB0	; 037FFEAA
	mov r0,#0x1	; 037FFEAC
	bx lr	; 037FFEAE
loc_037FFEB0:
	mov r0,#0x0	; 037FFEB0
	bx lr	; 037FFEB2
pool_037FFEB4:
loc_037FFEB4:
	.word REG_SNDCAP0CNT	; 037FFEB4

; ===== function loc_037FFEB8 =====
loc_037FFEB8:
	push {r4,r5,r6,r7,lr}	; 037FFEB8
	sub sp,#0x4	; 037FFEBA
	add r4,r0,#0x0	; 037FFEBC
	add r0,r2,#0x0	; 037FFEBE
	add r6,r3,#0x0	; 037FFEC0
	lsl r3,r4,#0x3	; 037FFEC2
	ldr r2,[sp,#0x18]	; 037FFEC4
	cmp r2,#0x0	; 037FFEC6
	beq loc_037FFECE	; 037FFEC8
	mov r5,#0x0	; 037FFECA
	b loc_037FFED0	; 037FFECC
loc_037FFECE:
	mov r5,#0x1	; 037FFECE
loc_037FFED0:
	ldr r2,[sp,#0x20]	; 037FFED0
	ldr r7,[sp,#0x1c]	; 037FFED2
	lsl r7,r7,#0x1	; 037FFED4
	lsl r1,r1,#0x3	; 037FFED6
	lsl r5,r5,#0x2	; 037FFED8
	orr r1,r5	; 037FFEDA
	orr r7,r1	; 037FFEDC
	orr r2,r7	; 037FFEDE
	ldr r1,[pool_037FFEF4]	; 037FFEE0
	strb r2,[r4,r1]	; 037FFEE2
	ldr r1,[pool_037FFEF8]	; 037FFEE4
	str r0,[r3,r1]	; 037FFEE6
	ldr r0,[pool_037FFEFC]	; 037FFEE8
	strh r6,[r3,r0]	; 037FFEEA
	add sp,#0x4	; 037FFEEC
	pop {r4,r5,r6,r7}	; 037FFEEE
	pop {r3}	; 037FFEF0
	bx r3	; 037FFEF2
pool_037FFEF4:
loc_037FFEF4:
	.word REG_SNDCAP0CNT	; 037FFEF4
pool_037FFEF8:
loc_037FFEF8:
	.word REG_SNDCAP0DAD	; 037FFEF8
pool_037FFEFC:
loc_037FFEFC:
	.word REG_SNDCAP0LEN	; 037FFEFC

; ===== function loc_037FFF00 =====
loc_037FFF00:
	push {r4,r5,r6,r7,lr}	; 037FFF00
	sub sp,#0x4	; 037FFF02
	add r5,r0,#0x0	; 037FFF04
	add r6,r1,#0x0	; 037FFF06
	add r0,#0x28	; 037FFF08
	bl loc_03800158	; 037FFF0A
	add r4,r0,#0x0	; 037FFF0E
	asr r3,r4,#0x1f	; 037FFF10
	mov r2,#0x0	; 037FFF12
	add r1,r3,#0x0	; 037FFF14
	eor r1,r2	; 037FFF16
	add r7,r4,#0x0	; 037FFF18
	eor r7,r2	; 037FFF1A
	orr r1,r7	; 037FFF1C
	beq loc_037FFF5C	; 037FFF1E
	add r1,r5,#0x0	; 037FFF20
	add r1,#0x28	; 037FFF22
	ldrb r1,[r1,#0x0]	; 037FFF24
	cmp r1,#0x0	; 037FFF26
	beq loc_037FFF44	; 037FFF28
	cmp r1,#0x1	; 037FFF2A
	beq loc_037FFF34	; 037FFF2C
	cmp r1,#0x2	; 037FFF2E
	beq loc_037FFF4E	; 037FFF30
	b loc_037FFF56	; 037FFF32
loc_037FFF34:
	add r1,r3,#0x0	; 037FFF34
	mov r2,#0x3c	; 037FFF36
	mov r3,#0x0	; 037FFF38
	bl loc_037FFF74	; 037FFF3A
	add r4,r0,#0x0	; 037FFF3E
	add r3,r1,#0x0	; 037FFF40
	b loc_037FFF56	; 037FFF42
loc_037FFF44:
	lsr r0,r4,#0x1a	; 037FFF44
	lsl r3,r3,#0x6	; 037FFF46
	orr r3,r0	; 037FFF48
	lsl r4,r4,#0x6	; 037FFF4A
	b loc_037FFF56	; 037FFF4C
loc_037FFF4E:
	lsr r0,r4,#0x1a	; 037FFF4E
	lsl r3,r3,#0x6	; 037FFF50
	orr r3,r0	; 037FFF52
	lsl r4,r4,#0x6	; 037FFF54
loc_037FFF56:
	lsl r0,r3,#0x12	; 037FFF56
	lsr r4,r4,#0xe	; 037FFF58
	orr r4,r0	; 037FFF5A
loc_037FFF5C:
	cmp r6,#0x0	; 037FFF5C
	beq loc_037FFF68	; 037FFF5E
	add r5,#0x28	; 037FFF60
	add r0,r5,#0x0	; 037FFF62
	bl loc_0380018C	; 037FFF64
loc_037FFF68:
	add r0,r4,#0x0	; 037FFF68
	add sp,#0x4	; 037FFF6A
	pop {r4,r5,r6,r7}	; 037FFF6C
	pop {r3}	; 037FFF6E
	bx r3	; 037FFF70
	.byte 0xC0, 0x46	; 037FFF74

; ===== function loc_037FFF74 =====
loc_037FFF74:
	bx pc	; 037FFF74
	.byte 0xC0, 0x46	; 037FFF78
.arm

; ===== function loc_037FFF78 =====
loc_037FFF78:
	ldr pc,[pool_037FFF7C]	; 037FFF78
pool_037FFF7C:
loc_037FFF7C:
	.word loc_03804F38	; 037FFF7C
.thumb

; ===== function loc_037FFF80 =====
loc_037FFF80:
	push {r4,r5,r6,lr}	; 037FFF80
	add r5,r0,#0x0	; 037FFF82
	add r6,r1,#0x0	; 037FFF84
	mov r0,#0x32	; 037FFF86
	ldrsh r0,[r5,r0]	; 037FFF88
	cmp r0,#0x0	; 037FFF8A
	bne loc_037FFF92	; 037FFF8C
	mov r0,#0x0	; 037FFF8E
	b loc_037FFFBC	; 037FFF90
loc_037FFF92:
	ldr r2,[r5,#0x14]	; 037FFF92
	ldr r4,[r5,#0x18]	; 037FFF94
	cmp r2,r4	; 037FFF96
	blt loc_037FFF9E	; 037FFF98
	mov r0,#0x0	; 037FFF9A
	b loc_037FFFBC	; 037FFF9C
loc_037FFF9E:
	asr r1,r0,#0x1f	; 037FFF9E
	sub r2,r4,r2	; 037FFFA0
	asr r3,r2,#0x1f	; 037FFFA2
	bl loc_037FFF74	; 037FFFA4
	asr r3,r4,#0x1f	; 037FFFA8
	add r2,r4,#0x0	; 037FFFAA
	bl loc_037FFFC4	; 037FFFAC
	cmp r6,#0x0	; 037FFFB0
	beq loc_037FFFBC	; 037FFFB2
	add r5,#0x14	; 037FFFB4
	ldr r1,[r5,#0x0]	; 037FFFB6
	add r1,r1,#0x1	; 037FFFB8
	str r1,[r5,#0x0]	; 037FFFBA
loc_037FFFBC:
	pop {r4,r5,r6}	; 037FFFBC
	pop {r3}	; 037FFFBE
	bx r3	; 037FFFC0
	.byte 0xC0, 0x46	; 037FFFC4

; ===== function loc_037FFFC4 =====
loc_037FFFC4:
	bx pc	; 037FFFC4
	.byte 0xC0, 0x46	; 037FFFC8
.arm

; ===== function loc_037FFFC8 =====
loc_037FFFC8:
	ldr pc,[pool_037FFFCC]	; 037FFFC8
pool_037FFFCC:
loc_037FFFCC:
	.word loc_03804D88	; 037FFFCC
.thumb

; ===== function loc_037FFFD0 =====
loc_037FFFD0:
	push {r4,lr}	; 037FFFD0
	cmp r1,#0x0	; 037FFFD2
	beq loc_0380003C	; 037FFFD4
	ldrb r1,[r0,#0x2]	; 037FFFD6
	cmp r1,#0x3	; 037FFFD8
	bhi loc_0380003C	; 037FFFDA
	add r1,r1,r1	; 037FFFDC
P2_SwitchIndexPC_037FFFDC:
	add r1,pc	; 037FFFDE
	ldrh r1,[r1,#(P2_SwitchTable_037FFFDC - (P2_SwitchIndexPC_037FFFDC + 4))]	; 037FFFE0
	lsl r1,r1,#0x10	; 037FFFE2
	asr r1,r1,#0x10	; 037FFFE4
P2_SwitchTargetPC_037FFFDC:
	add r1,pc	; 037FFFE6
	bx r1	; 037FFFE8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_037FFFDC:
	.halfword (loc_037FFFF2 + 1) - (P2_SwitchTargetPC_037FFFDC + 4)
	.halfword (loc_0380000C + 1) - (P2_SwitchTargetPC_037FFFDC + 4)
	.halfword (loc_0380003C + 1) - (P2_SwitchTargetPC_037FFFDC + 4)
	.halfword (loc_03800030 + 1) - (P2_SwitchTargetPC_037FFFDC + 4)
P2_SwitchTable_037FFFDCEnd:
loc_037FFFF2:
	ldr r1,[r0,#0x10]	; 037FFFF2
	neg r2,r1	; 037FFFF4
	ldrb r1,[r0,#0x1c]	; 037FFFF6
	mul r2,r1	; 037FFFF8
	asr r1,r2,#0x8	; 037FFFFA
	neg r1,r1	; 037FFFFC
	str r1,[r0,#0x10]	; 037FFFFE
	.byte 0x01, 0x69, 0x00, 0x29, 0x1A, 0xD1, 0x01, 0x21, 0x81, 0x70, 0x17, 0xE0	; 0380000C
loc_0380000C:
	ldrb r1,[r0,#0x1d]	; 0380000C
	lsl r2,r1,#0x1	; 0380000E
	ldr r1,[pool_03800048]	; 03800010
	ldrsh r1,[r1,r2]	; 03800012
	lsl r4,r1,#0x7	; 03800014
	add r3,r0,#0x0	; 03800016
	add r3,#0x10	; 03800018
	ldr r2,[r3,#0x0]	; 0380001A
	ldrh r1,[r0,#0x1e]	; 0380001C
	sub r1,r2,r1	; 0380001E
	str r1,[r3,#0x0]	; 03800020
	ldr r1,[r0,#0x10]	; 03800022
	cmp r1,r4	; 03800024
	bgt loc_0380003C	; 03800026
	str r4,[r0,#0x10]	; 03800028
	mov r1,#0x2	; 0380002A
	strb r1,[r0,#0x2]	; 0380002C
	b loc_0380003C	; 0380002E
loc_03800030:
	add r3,r0,#0x0	; 03800030
	add r3,#0x10	; 03800032
	ldr r2,[r3,#0x0]	; 03800034
	ldrh r1,[r0,#0x20]	; 03800036
	sub r1,r2,r1	; 03800038
	str r1,[r3,#0x0]	; 0380003A
loc_0380003C:
	ldr r0,[r0,#0x10]	; 0380003C
	asr r0,r0,#0x7	; 0380003E
	pop {r4}	; 03800040
	pop {r3}	; 03800042
	bx r3	; 03800044
	.byte 0xC0, 0x46	; 03800048
pool_03800048:
loc_03800048:
	.word P2_Data_03805504	; 03800048

; ===== function loc_0380004C =====
loc_0380004C:
	push {r4,r5,lr}	; 0380004C
	sub sp,#0x4	; 0380004E
	ldrh r5,[r0,#0x24]	; 03800050
	mov r0,#0xff	; 03800052
	add r2,r5,#0x0	; 03800054
	and r2,r0	; 03800056
	ldrh r4,[r1,#0x24]	; 03800058
	add r1,r4,#0x0	; 0380005A
	and r1,r0	; 0380005C
	lsl r3,r2,#0x4	; 0380005E
	lsl r2,r1,#0x4	; 03800060
	asr r0,r5,#0x8	; 03800062
	ldr r1,[pool_0380008C]	; 03800064
	ldrb r0,[r1,r0]	; 03800066
	asr r3,r0	; 03800068
	asr r0,r4,#0x8	; 0380006A
	ldrb r0,[r1,r0]	; 0380006C
	asr r2,r0	; 0380006E
	cmp r3,r2	; 03800070
	beq loc_03800082	; 03800072
	cmp r3,r2	; 03800074
	bge loc_0380007C	; 03800076
	mov r0,#0x1	; 03800078
	b loc_03800084	; 0380007A
loc_0380007C:
	mov r0,#0x0	; 0380007C
	mvn r0,r0	; 0380007E
	b loc_03800084	; 03800080
loc_03800082:
	mov r0,#0x0	; 03800082
loc_03800084:
	add sp,#0x4	; 03800084
	pop {r4,r5}	; 03800086
	pop {r3}	; 03800088
	bx r3	; 0380008A
pool_0380008C:
loc_0380008C:
	.word P2_Data_03805604	; 0380008C

; ===== function loc_03800090 =====
loc_03800090:
	push {lr}	; 03800090
	sub sp,#0x4	; 03800092
	add r2,r0,#0x0	; 03800094
	cmp r2,#0x7f	; 03800096
	bne loc_0380009E	; 03800098
	ldr r0,[pool_038000C8]	; 0380009A
	b loc_038000C2	; 0380009C
loc_0380009E:
	cmp r2,#0x7e	; 0380009E
	bne loc_038000A6	; 038000A0
	ldr r0,[pool_038000CC]	; 038000A2
	b loc_038000C2	; 038000A4
loc_038000A6:
	cmp r2,#0x32	; 038000A6
	bge loc_038000B4	; 038000A8
	lsl r0,r2,#0x1	; 038000AA
	add r0,r0,#0x1	; 038000AC
	lsl r0,r0,#0x10	; 038000AE
	lsr r0,r0,#0x10	; 038000B0
	b loc_038000C2	; 038000B2
loc_038000B4:
	ldr r0,[pool_038000D0]	; 038000B4
	mov r1,#0x7e	; 038000B6
	sub r1,r1,r2	; 038000B8
	bl loc_037FE6E4	; 038000BA
	lsl r0,r0,#0x10	; 038000BE
	lsr r0,r0,#0x10	; 038000C0
loc_038000C2:
	add sp,#0x4	; 038000C2
	pop {r3}	; 038000C4
	bx r3	; 038000C6
pool_038000C8:
loc_038000C8:
	.word 0x0000FFFF	; 038000C8
pool_038000CC:
loc_038000CC:
	.word 0x00003C00	; 038000CC
pool_038000D0:
loc_038000D0:
	.word 0x00001E00	; 038000D0

; ===== function loc_038000D4 =====
loc_038000D4:
	push {r4,lr}	; 038000D4
	add r4,r0,#0x0	; 038000D6
	ldr r0,[pool_03800104]	; 038000D8
	str r0,[r4,#0x10]	; 038000DA
	mov r0,#0x0	; 038000DC
	strb r0,[r4,#0x2]	; 038000DE
	str r1,[r4,#0x34]	; 038000E0
	add r0,r4,#0x0	; 038000E2
	add r0,#0x28	; 038000E4
	bl loc_038001D0	; 038000E6
	add r2,r4,#0x3	; 038000EA
	ldrb r1,[r2,#0x0]	; 038000EC
	mov r0,#0x2	; 038000EE
	orr r1,r0	; 038000F0
	strb r1,[r2,#0x0]	; 038000F2
	ldrb r1,[r2,#0x0]	; 038000F4
	mov r0,#0x1	; 038000F6
	bic r1,r0	; 038000F8
	orr r1,r0	; 038000FA
	strb r1,[r2,#0x0]	; 038000FC
	pop {r4}	; 038000FE
	pop {r3}	; 03800100
	bx r3	; 03800102
pool_03800104:
loc_03800104:
	.word 0xFFFE9680	; 03800104

; ===== function loc_03800108 =====
loc_03800108:
	push {r4,r5,lr}	; 03800108
	sub sp,#0x4	; 0380010A
	mov r4,#0x0	; 0380010C
	str r4,[r0,#0x50]	; 0380010E
	str r1,[r0,#0x48]	; 03800110
	str r2,[r0,#0x4c]	; 03800112
	str r4,[r0,#0x34]	; 03800114
	add r1,r0,#0x0	; 03800116
	add r1,#0x22	; 03800118
	strb r3,[r1,#0x0]	; 0380011A
	mov r5,#0x7f	; 0380011C
	strh r5,[r0,#0x24]	; 0380011E
	add r3,r0,#0x3	; 03800120
	ldrb r2,[r3,#0x0]	; 03800122
	mov r1,#0x2	; 03800124
	bic r2,r1	; 03800126
	strb r2,[r3,#0x0]	; 03800128
	mov r1,#0x3c	; 0380012A
	strb r1,[r0,#0x8]	; 0380012C
	strb r1,[r0,#0x5]	; 0380012E
	strb r5,[r0,#0x9]	; 03800130
	strb r4,[r0,#0xa]	; 03800132
	strh r4,[r0,#0xc]	; 03800134
	strh r4,[r0,#0xe]	; 03800136
	strb r4,[r0,#0xb]	; 03800138
	strh r4,[r0,#0x32]	; 0380013A
	str r4,[r0,#0x18]	; 0380013C
	str r4,[r0,#0x14]	; 0380013E
	strb r5,[r0,#0x1c]	; 03800140
	strh r5,[r0,#0x1e]	; 03800142
	strb r5,[r0,#0x1d]	; 03800144
	strh r5,[r0,#0x20]	; 03800146
	add r0,#0x28	; 03800148
	bl loc_038001D8	; 0380014A
	add sp,#0x4	; 0380014E
	pop {r4,r5}	; 03800150
	pop {r3}	; 03800152
	bx r3	; 03800154
	.byte 0x00, 0x00	; 03800158

; ===== function loc_03800158 =====
loc_03800158:
	push {r4,lr}	; 03800158
	add r4,r0,#0x0	; 0380015A
	ldrb r0,[r4,#0x2]	; 0380015C
	cmp r0,#0x0	; 0380015E
	bne loc_03800166	; 03800160
	mov r0,#0x0	; 03800162
	b loc_03800184	; 03800164
loc_03800166:
	ldrh r1,[r4,#0x6]	; 03800166
	ldrh r0,[r4,#0x4]	; 03800168
	cmp r1,r0	; 0380016A
	bcs loc_03800172	; 0380016C
	mov r2,#0x0	; 0380016E
	b loc_03800182	; 03800170
loc_03800172:
	ldrh r0,[r4,#0x8]	; 03800172
	lsr r0,r0,#0x8	; 03800174
	bl loc_037FFBC8	; 03800176
	ldrb r2,[r4,#0x3]	; 0380017A
	ldrb r1,[r4,#0x2]	; 0380017C
	mul r1,r0	; 0380017E
	mul r2,r1	; 03800180
loc_03800182:
	add r0,r2,#0x0	; 03800182
loc_03800184:
	pop {r4}	; 03800184
	pop {r3}	; 03800186
	bx r3	; 03800188
	.byte 0x00, 0x00	; 0380018C

; ===== function loc_0380018C =====
loc_0380018C:
	push {r4,lr}	; 0380018C
	ldrh r2,[r0,#0x6]	; 0380018E
	ldrh r1,[r0,#0x4]	; 03800190
	cmp r2,r1	; 03800192
	bcs loc_038001A0	; 03800194
	add r1,r0,#0x6	; 03800196
	ldrh r0,[r1,#0x0]	; 03800198
	add r0,r0,#0x1	; 0380019A
	strh r0,[r1,#0x0]	; 0380019C
	b loc_038001CA	; 0380019E
loc_038001A0:
	ldrh r2,[r0,#0x8]	; 038001A0
	ldrb r1,[r0,#0x1]	; 038001A2
	lsl r3,r1,#0x6	; 038001A4
	add r1,r2,r3	; 038001A6
	lsr r4,r1,#0x8	; 038001A8
	b loc_038001AE	; 038001AA
loc_038001AC:
	sub r4,#0x80	; 038001AC
loc_038001AE:
	cmp r4,#0x80	; 038001AE
	bcs loc_038001AC	; 038001B0
	add r0,#0x8	; 038001B2
	ldrh r1,[r0,#0x0]	; 038001B4
	add r1,r1,r3	; 038001B6
	strh r1,[r0,#0x0]	; 038001B8
	ldrh r2,[r0,#0x0]	; 038001BA
	mov r1,#0xff	; 038001BC
	and r2,r1	; 038001BE
	strh r2,[r0,#0x0]	; 038001C0
	ldrh r2,[r0,#0x0]	; 038001C2
	lsl r1,r4,#0x8	; 038001C4
	orr r2,r1	; 038001C6
	strh r2,[r0,#0x0]	; 038001C8
loc_038001CA:
	pop {r4}	; 038001CA
	pop {r3}	; 038001CC
	bx r3	; 038001CE

; ===== function loc_038001D0 =====
loc_038001D0:
	mov r1,#0x0	; 038001D0
	strh r1,[r0,#0x8]	; 038001D2
	strh r1,[r0,#0x6]	; 038001D4
	bx lr	; 038001D6

; ===== function loc_038001D8 =====
loc_038001D8:
	mov r2,#0x0	; 038001D8
	strb r2,[r0,#0x0]	; 038001DA
	strb r2,[r0,#0x2]	; 038001DC
	mov r1,#0x1	; 038001DE
	strb r1,[r0,#0x3]	; 038001E0
	mov r1,#0x10	; 038001E2
	strb r1,[r0,#0x1]	; 038001E4
	strh r2,[r0,#0x4]	; 038001E6
	bx lr	; 038001E8
	.byte 0x00, 0x00	; 038001EC

; ===== function loc_038001EC =====
loc_038001EC:
	push {r4,r5,r6,r7,lr}	; 038001EC
	sub sp,#0x4	; 038001EE
	add r5,r0,#0x0	; 038001F0
	add r6,r1,#0x0	; 038001F2
	mov r4,#0x0	; 038001F4
	add r7,r4,#0x0	; 038001F6
loc_038001F8:
	add r1,r4,#0x0	; 038001F8
	mov r0,#0x54	; 038001FA
	mul r1,r0	; 038001FC
	ldr r0,[pool_03800238]	; 038001FE
	add r1,r0,r1	; 03800200
	ldrb r0,[r1,#0x1]	; 03800202
	cmp r0,#0x0	; 03800204
	bne loc_03800224	; 03800206
	ldr r0,[r1,#0x44]	; 03800208
	cmp r5,r0	; 0380020A
	bhi loc_03800224	; 0380020C
	cmp r0,r6	; 0380020E
	bhi loc_03800224	; 03800210
	add r2,r1,#0x3	; 03800212
	ldrb r1,[r2,#0x0]	; 03800214
	mov r0,#0x2	; 03800216
	bic r1,r0	; 03800218
	strb r1,[r2,#0x0]	; 0380021A
	add r0,r4,#0x0	; 0380021C
	add r1,r7,#0x0	; 0380021E
	bl loc_037FFA18	; 03800220
loc_03800224:
	add r0,r4,#0x1	; 03800224
	lsl r0,r0,#0x18	; 03800226
	lsr r4,r0,#0x18	; 03800228
	cmp r4,#0x10	; 0380022A
	bcc loc_038001F8	; 0380022C
	add sp,#0x4	; 0380022E
	pop {r4,r5,r6,r7}	; 03800230
	pop {r3}	; 03800232
	bx r3	; 03800234
	.byte 0xC0, 0x46	; 03800238
pool_03800238:
loc_03800238:
	.word 0x03806500	; 03800238

; ===== function loc_0380023C =====
loc_0380023C:
	mov r2,#0x1	; 0380023C
	and r1,r2	; 0380023E
	cmp r1,#0x0	; 03800240
	beq loc_0380024E	; 03800242
	ldr r1,[pool_03800258]	; 03800244
	ldr r2,[r1,#0x0]	; 03800246
	bic r2,r0	; 03800248
	str r2,[r1,#0x0]	; 0380024A
	bx lr	; 0380024C
loc_0380024E:
	ldr r1,[pool_0380025C]	; 0380024E
	ldr r2,[r1,#0x0]	; 03800250
	bic r2,r0	; 03800252
	str r2,[r1,#0x0]	; 03800254
	bx lr	; 03800256
pool_03800258:
loc_03800258:
	.word P2_BssStart + 0xD60	; 03800258
pool_0380025C:
loc_0380025C:
	.word P2_BssStart + 0xD64	; 0380025C

; ===== function loc_03800260 =====
loc_03800260:
	push {r4,r5,r6,r7,lr}	; 03800260
	sub sp,#0x14	; 03800262
	add r7,r0,#0x0	; 03800264
	str r1,[sp,#0x0]	; 03800266
	add r6,r7,#0x0	; 03800268
	mov r4,#0x0	; 0380026A
	str r4,[sp,#0x4]	; 0380026C
	str r4,[sp,#0x8]	; 0380026E
	str r4,[sp,#0xc]	; 03800270
	str r4,[sp,#0x10]	; 03800272
	b loc_038002D0	; 03800274
loc_03800276:
	add r1,r6,#0x0	; 03800276
	mov r0,#0x1	; 03800278
	and r1,r0	; 0380027A
	cmp r1,#0x0	; 0380027C
	beq loc_038002CC	; 0380027E
	add r1,r4,#0x0	; 03800280
	mov r0,#0x54	; 03800282
	mul r1,r0	; 03800284
	ldr r0,[pool_03800300]	; 03800286
	add r5,r0,r1	; 03800288
	ldr r0,[pool_03800304]	; 0380028A
	ldr r1,[r0,#0x0]	; 0380028C
	mov r0,#0x1	; 0380028E
	lsl r0,r4	; 03800290
	and r1,r0	; 03800292
	cmp r1,#0x0	; 03800294
	bne loc_038002CC	; 03800296
	ldr r3,[r5,#0x48]	; 03800298
	cmp r3,#0x0	; 0380029A
	beq loc_038002A8	; 0380029C
	add r0,r5,#0x0	; 0380029E
	ldr r1,[sp,#0x4]	; 038002A0
	ldr r2,[r5,#0x4c]	; 038002A2
	bl loc_03805474	; 038002A4
loc_038002A8:
	add r0,r4,#0x0	; 038002A8
	ldr r1,[sp,#0x8]	; 038002AA
	bl loc_037FFA18	; 038002AC
	add r1,r5,#0x0	; 038002B0
	add r1,#0x22	; 038002B2
	ldr r0,[sp,#0xc]	; 038002B4
	strb r0,[r1,#0x0]	; 038002B6
	add r0,r5,#0x0	; 038002B8
	bl loc_03800390	; 038002BA
	ldr r0,[sp,#0x10]	; 038002BE
	strb r0,[r5,#0x4]	; 038002C0
	add r2,r5,#0x3	; 038002C2
	ldrb r1,[r2,#0x0]	; 038002C4
	mov r0,#0x1	; 038002C6
	bic r1,r0	; 038002C8
	strb r1,[r2,#0x0]	; 038002CA
loc_038002CC:
	add r4,r4,#0x1	; 038002CC
	lsr r6,r6,#0x1	; 038002CE
loc_038002D0:
	cmp r4,#0x10	; 038002D0
	bge loc_038002D8	; 038002D2
	cmp r6,#0x0	; 038002D4
	bne loc_03800276	; 038002D6
loc_038002D8:
	mov r1,#0x1	; 038002D8
	ldr r0,[sp,#0x0]	; 038002DA
	and r0,r1	; 038002DC
	str r0,[sp,#0x0]	; 038002DE
	cmp r0,#0x0	; 038002E0
	beq loc_038002EE	; 038002E2
	ldr r0,[pool_03800308]	; 038002E4
	ldr r1,[r0,#0x0]	; 038002E6
	orr r1,r7	; 038002E8
	str r1,[r0,#0x0]	; 038002EA
	b loc_038002F6	; 038002EC
loc_038002EE:
	ldr r0,[pool_03800304]	; 038002EE
	ldr r1,[r0,#0x0]	; 038002F0
	orr r1,r7	; 038002F2
	str r1,[r0,#0x0]	; 038002F4
loc_038002F6:
	add sp,#0x14	; 038002F6
	pop {r4,r5,r6,r7}	; 038002F8
	pop {r3}	; 038002FA
	bx r3	; 038002FC
	.byte 0xC0, 0x46	; 03800300
pool_03800300:
loc_03800300:
	.word 0x03806500	; 03800300
pool_03800304:
loc_03800304:
	.word P2_BssStart + 0xD64	; 03800304
pool_03800308:
loc_03800308:
	.word P2_BssStart + 0xD60	; 03800308

; ===== function loc_0380030C =====
loc_0380030C:
	push {r4,r5,r6,r7,lr}	; 0380030C
	sub sp,#0xc	; 0380030E
	add r6,r0,#0x0	; 03800310
	mov r4,#0x0	; 03800312
	str r4,[sp,#0x0]	; 03800314
	str r4,[sp,#0x4]	; 03800316
	add r7,r4,#0x0	; 03800318
	str r4,[sp,#0x8]	; 0380031A
	b loc_03800376	; 0380031C
loc_0380031E:
	add r1,r6,#0x0	; 0380031E
	mov r0,#0x1	; 03800320
	and r1,r0	; 03800322
	cmp r1,#0x0	; 03800324
	beq loc_03800372	; 03800326
	add r1,r4,#0x0	; 03800328
	mov r0,#0x54	; 0380032A
	mul r1,r0	; 0380032C
	ldr r0,[pool_03800388]	; 0380032E
	add r5,r0,r1	; 03800330
	ldr r0,[pool_0380038C]	; 03800332
	ldr r1,[r0,#0x0]	; 03800334
	mov r0,#0x1	; 03800336
	lsl r0,r4	; 03800338
	and r1,r0	; 0380033A
	cmp r1,#0x0	; 0380033C
	bne loc_03800372	; 0380033E
	ldr r3,[r5,#0x48]	; 03800340
	cmp r3,#0x0	; 03800342
	beq loc_03800350	; 03800344
	add r0,r5,#0x0	; 03800346
	ldr r1,[sp,#0x0]	; 03800348
	ldr r2,[r5,#0x4c]	; 0380034A
	bl loc_03805474	; 0380034C
loc_03800350:
	add r0,r4,#0x0	; 03800350
	ldr r1,[sp,#0x4]	; 03800352
	bl loc_037FFA18	; 03800354
	add r0,r5,#0x0	; 03800358
	add r0,#0x22	; 0380035A
	strb r7,[r0,#0x0]	; 0380035C
	add r0,r5,#0x0	; 0380035E
	bl loc_03800390	; 03800360
	ldr r0,[sp,#0x8]	; 03800364
	strb r0,[r5,#0x4]	; 03800366
	add r2,r5,#0x3	; 03800368
	ldrb r1,[r2,#0x0]	; 0380036A
	mov r0,#0x1	; 0380036C
	bic r1,r0	; 0380036E
	strb r1,[r2,#0x0]	; 03800370
loc_03800372:
	add r4,r4,#0x1	; 03800372
	lsr r6,r6,#0x1	; 03800374
loc_03800376:
	cmp r4,#0x10	; 03800376
	bge loc_0380037E	; 03800378
	cmp r6,#0x0	; 0380037A
	bne loc_0380031E	; 0380037C
loc_0380037E:
	add sp,#0xc	; 0380037E
	pop {r4,r5,r6,r7}	; 03800380
	pop {r3}	; 03800382
	bx r3	; 03800384
	.byte 0xC0, 0x46	; 03800388
pool_03800388:
loc_03800388:
	.word 0x03806500	; 03800388
pool_0380038C:
loc_0380038C:
	.word P2_BssStart + 0xD64	; 0380038C

; ===== function loc_03800390 =====
loc_03800390:
	cmp r0,#0x0	; 03800390
	beq loc_0380039A	; 03800392
	mov r1,#0x0	; 03800394
	str r1,[r0,#0x48]	; 03800396
	str r1,[r0,#0x4c]	; 03800398
loc_0380039A:
	bx lr	; 0380039A

; ===== function loc_0380039C =====
P2_Entry_0380039C:
	push {r4,r5,r6,r7,lr}	; 0380039C
	sub sp,#0xc	; 0380039E
	add r5,r0,#0x0	; 038003A0
	str r1,[sp,#0x0]	; 038003A2
	str r3,[sp,#0x4]	; 038003A4
	ldr r0,[pool_03800450]	; 038003A6
	ldr r0,[r0,#0x0]	; 038003A8
	bic r5,r0	; 038003AA
	cmp r2,#0x0	; 038003AC
	bne loc_038003B6	; 038003AE
	ldr r0,[pool_03800454]	; 038003B0
	ldr r0,[r0,#0x0]	; 038003B2
	bic r5,r0	; 038003B4
loc_038003B6:
	mov r4,#0x0	; 038003B6
	add r6,r4,#0x0	; 038003B8
loc_038003BA:
	ldr r0,[pool_03800458]	; 038003BA
	ldrb r0,[r0,r6]	; 038003BC
	mov r1,#0x1	; 038003BE
	lsl r1,r0	; 038003C0
	add r2,r5,#0x0	; 038003C2
	and r2,r1	; 038003C4
	cmp r2,#0x0	; 038003C6
	beq loc_038003FC	; 038003C8
	mov r1,#0x54	; 038003CA
	mul r0,r1	; 038003CC
	ldr r1,[pool_0380045C]	; 038003CE
	add r7,r1,r0	; 038003D0
	cmp r4,#0x0	; 038003D2
	bne loc_038003DA	; 038003D4
	add r4,r7,#0x0	; 038003D6
	b loc_038003FC	; 038003D8
loc_038003DA:
	add r0,r4,#0x0	; 038003DA
	add r0,#0x22	; 038003DC
	ldrb r1,[r0,#0x0]	; 038003DE
	add r0,r7,#0x0	; 038003E0
	add r0,#0x22	; 038003E2
	ldrb r0,[r0,#0x0]	; 038003E4
	cmp r0,r1	; 038003E6
	bhi loc_038003FC	; 038003E8
	cmp r0,r1	; 038003EA
	bne loc_038003FA	; 038003EC
	add r0,r4,#0x0	; 038003EE
	add r1,r7,#0x0	; 038003F0
	bl loc_0380004C	; 038003F2
	cmp r0,#0x0	; 038003F6
	bge loc_038003FC	; 038003F8
loc_038003FA:
	add r4,r7,#0x0	; 038003FA
loc_038003FC:
	add r6,r6,#0x1	; 038003FC
	cmp r6,#0x10	; 038003FE
	blt loc_038003BA	; 03800400
	cmp r4,#0x0	; 03800402
	bne loc_0380040A	; 03800404
	mov r0,#0x0	; 03800406
	b loc_03800446	; 03800408
loc_0380040A:
	add r0,r4,#0x0	; 0380040A
	add r0,#0x22	; 0380040C
	ldrb r1,[r0,#0x0]	; 0380040E
	ldr r0,[sp,#0x0]	; 03800410
	cmp r0,r1	; 03800412
	bge loc_0380041A	; 03800414
	mov r0,#0x0	; 03800416
	b loc_03800446	; 03800418
loc_0380041A:
	ldr r3,[r4,#0x48]	; 0380041A
	cmp r3,#0x0	; 0380041C
	beq loc_0380042A	; 0380041E
	add r0,r4,#0x0	; 03800420
	mov r1,#0x0	; 03800422
	ldr r2,[r4,#0x4c]	; 03800424
	bl loc_03805474	; 03800426
loc_0380042A:
	mov r0,#0x2	; 0380042A
	strb r0,[r4,#0x4]	; 0380042C
	add r2,r4,#0x3	; 0380042E
	ldrb r1,[r2,#0x0]	; 03800430
	mov r0,#0x1	; 03800432
	bic r1,r0	; 03800434
	strb r1,[r2,#0x0]	; 03800436
	add r0,r4,#0x0	; 03800438
	ldr r1,[sp,#0x4]	; 0380043A
	ldr r2,[sp,#0x20]	; 0380043C
	ldr r3,[sp,#0x0]	; 0380043E
	bl loc_03800108	; 03800440
	add r0,r4,#0x0	; 03800444
loc_03800446:
	add sp,#0xc	; 03800446
	pop {r4,r5,r6,r7}	; 03800448
	pop {r3}	; 0380044A
	bx r3	; 0380044C
	.byte 0xC0, 0x46	; 03800450
pool_03800450:
loc_03800450:
	.word P2_BssStart + 0xD64	; 03800450
pool_03800454:
loc_03800454:
	.word P2_BssStart + 0xD60	; 03800454
pool_03800458:
loc_03800458:
	.word P2_Data_03805608	; 03800458
pool_0380045C:
loc_0380045C:
	.word 0x03806500	; 0380045C

; ===== function loc_03800460 =====
loc_03800460:
	ldrb r0,[r0,#0x3]	; 03800460
	lsl r0,r0,#0x1f	; 03800462
	lsr r0,r0,#0x1f	; 03800464
	bx lr	; 03800466

; ===== function loc_03800468 =====
loc_03800468:
	mov r1,#0x3	; 03800468
	strb r1,[r0,#0x2]	; 0380046A
	bx lr	; 0380046C
	.byte 0x00, 0x00	; 03800470

; ===== function loc_03800470 =====
loc_03800470:
	push {r4,lr}	; 03800470
	add r4,r0,#0x0	; 03800472
	add r0,r1,#0x0	; 03800474
	bl loc_03800090	; 03800476
	strh r0,[r4,#0x20]	; 0380047A
	pop {r4}	; 0380047C
	pop {r3}	; 0380047E
	bx r3	; 03800480
	.byte 0x00, 0x00	; 03800484

; ===== function loc_03800484 =====
loc_03800484:
	strb r1,[r0,#0x1d]	; 03800484
	bx lr	; 03800486

; ===== function loc_03800488 =====
loc_03800488:
	push {r4,lr}	; 03800488
	add r4,r0,#0x0	; 0380048A
	add r0,r1,#0x0	; 0380048C
	bl loc_03800090	; 0380048E
	strh r0,[r4,#0x1e]	; 03800492
	pop {r4}	; 03800494
	pop {r3}	; 03800496
	bx r3	; 03800498
	.byte 0x00, 0x00	; 0380049C

; ===== function loc_0380049C =====
loc_0380049C:
	cmp r1,#0x6d	; 0380049C
	bge loc_038004A8	; 0380049E
	mov r2,#0xff	; 038004A0
	sub r1,r2,r1	; 038004A2
	strb r1,[r0,#0x1c]	; 038004A4
	bx lr	; 038004A6
loc_038004A8:
	mov r2,#0x7f	; 038004A8
	sub r2,r2,r1	; 038004AA
	ldr r1,[pool_038004B4]	; 038004AC
	ldrb r1,[r1,r2]	; 038004AE
	strb r1,[r0,#0x1c]	; 038004B0
	bx lr	; 038004B2
pool_038004B4:
loc_038004B4:
	.word P2_Data_03805618	; 038004B4

; ===== function loc_038004B8 =====
loc_038004B8:
	push {lr}	; 038004B8
	sub sp,#0x4	; 038004BA
	ldrb r2,[r0,#0x0]	; 038004BC
	cmp r2,#0xe	; 038004BE
	bcs loc_038004C6	; 038004C0
	mov r0,#0x0	; 038004C2
	b loc_038004DC	; 038004C4
loc_038004C6:
	cmp r2,#0xf	; 038004C6
	bls loc_038004CE	; 038004C8
	mov r0,#0x0	; 038004CA
	b loc_038004DC	; 038004CC
loc_038004CE:
	mov r2,#0x2	; 038004CE
	strb r2,[r0,#0x1]	; 038004D0
	ldr r2,[pool_038004E4]	; 038004D2
	strh r2,[r0,#0x3c]	; 038004D4
	bl loc_038000D4	; 038004D6
	mov r0,#0x1	; 038004DA
loc_038004DC:
	add sp,#0x4	; 038004DC
	pop {r3}	; 038004DE
	bx r3	; 038004E0
	.byte 0xC0, 0x46	; 038004E4
pool_038004E4:
loc_038004E4:
	.word 0x00001F46	; 038004E4

; ===== function loc_038004E8 =====
loc_038004E8:
	push {lr}	; 038004E8
	sub sp,#0x4	; 038004EA
	ldrb r3,[r0,#0x0]	; 038004EC
	cmp r3,#0x8	; 038004EE
	bcs loc_038004F6	; 038004F0
	mov r0,#0x0	; 038004F2
	b loc_03800510	; 038004F4
loc_038004F6:
	cmp r3,#0xd	; 038004F6
	bls loc_038004FE	; 038004F8
	mov r0,#0x0	; 038004FA
	b loc_03800510	; 038004FC
loc_038004FE:
	mov r3,#0x1	; 038004FE
	strb r3,[r0,#0x1]	; 03800500
	str r1,[r0,#0x44]	; 03800502
	ldr r1,[pool_03800518]	; 03800504
	strh r1,[r0,#0x3c]	; 03800506
	add r1,r2,#0x0	; 03800508
	bl loc_038000D4	; 0380050A
	mov r0,#0x1	; 0380050E
loc_03800510:
	add sp,#0x4	; 03800510
	pop {r3}	; 03800512
	bx r3	; 03800514
	.byte 0xC0, 0x46	; 03800518
pool_03800518:
loc_03800518:
	.word 0x00001F46	; 03800518

; ===== function loc_0380051C =====
loc_0380051C:
	push {r4,r5,r6,lr}	; 0380051C
	add r6,r0,#0x0	; 0380051E
	add r5,r1,#0x0	; 03800520
	mov r0,#0x0	; 03800522
	strb r0,[r6,#0x1]	; 03800524
	add r4,r6,#0x0	; 03800526
	add r4,#0x38	; 03800528
	ldmia r5!,{r0,r1}	; 0380052A
	stmia r4!,{r0,r1}	; 0380052C
	ldr r0,[r5,#0x0]	; 0380052E
	str r0,[r4,#0x0]	; 03800530
	str r2,[r6,#0x44]	; 03800532
	add r0,r6,#0x0	; 03800534
	add r1,r3,#0x0	; 03800536
	bl loc_038000D4	; 03800538
	mov r0,#0x1	; 0380053C
	pop {r4,r5,r6}	; 0380053E
	pop {r3}	; 03800540
	bx r3	; 03800542

; ===== function loc_03800544 =====
P2_Entry_03800544:
	push {r4,r5,r6,r7,lr}	; 03800544
	sub sp,#0x24	; 03800546
	str r0,[sp,#0x0]	; 03800548
	mov r0,#0x0	; 0380054A
	str r0,[sp,#0x4]	; 0380054C
	str r0,[sp,#0xc]	; 0380054E
	str r0,[sp,#0x14]	; 03800550
	str r0,[sp,#0x1c]	; 03800552
	str r0,[sp,#0x18]	; 03800554
	str r0,[sp,#0x10]	; 03800556
	str r0,[sp,#0x8]	; 03800558
loc_0380055A:
	ldr r6,[sp,#0x8]	; 0380055A
	lsl r7,r6,#0	; 0380055C
	lsl r4,r6,#0	; 0380055E
	ldr r1,[sp,#0x4]	; 03800560
	mov r0,#0x54	; 03800562
	mul r1,r0	; 03800564
	ldr r0,[pool_03800724]	; 03800566
	add r5,r0,r1	; 03800568
	ldrb r0,[r5,#0x3]	; 0380056A
	lsl r1,r0,#0x1f	; 0380056C
	lsr r1,r1,#0x1f	; 0380056E
	cmp r1,#0x0	; 03800570
	bne loc_03800576	; 03800572
	b loc_03800710	; 03800574
loc_03800576:
	lsl r0,r0,#0x1e	; 03800576
	lsr r0,r0,#0x1f	; 03800578
	cmp r0,#0x0	; 0380057A
	beq loc_03800594	; 0380057C
	add r2,r5,#0x4	; 0380057E
	ldrb r1,[r2,#0x0]	; 03800580
	mov r0,#0x1	; 03800582
	orr r1,r0	; 03800584
	strb r1,[r2,#0x0]	; 03800586
	add r2,r5,#0x3	; 03800588
	ldrb r1,[r2,#0x0]	; 0380058A
	mov r0,#0x2	; 0380058C
	bic r1,r0	; 0380058E
	strb r1,[r2,#0x0]	; 03800590
	b loc_038005C8	; 03800592
loc_03800594:
	ldr r0,[sp,#0x4]	; 03800594
	bl loc_037FF94C	; 03800596
	cmp r0,#0x0	; 0380059A
	bne loc_038005C8	; 0380059C
	ldr r3,[r5,#0x48]	; 0380059E
	cmp r3,#0x0	; 038005A0
	beq loc_038005B0	; 038005A2
	add r0,r5,#0x0	; 038005A4
	mov r1,#0x2	; 038005A6
	ldr r2,[r5,#0x4c]	; 038005A8
	bl loc_03805474	; 038005AA
	b loc_038005B8	; 038005AE
loc_038005B0:
	add r1,r5,#0x0	; 038005B0
	add r1,#0x22	; 038005B2
	ldr r0,[sp,#0xc]	; 038005B4
	strb r0,[r1,#0x0]	; 038005B6
loc_038005B8:
	ldr r0,[sp,#0x10]	; 038005B8
	strh r0,[r5,#0x24]	; 038005BA
	add r2,r5,#0x3	; 038005BC
	ldrb r1,[r2,#0x0]	; 038005BE
	mov r0,#0x1	; 038005C0
	bic r1,r0	; 038005C2
	strb r1,[r2,#0x0]	; 038005C4
	b loc_03800710	; 038005C6
loc_038005C8:
	ldrb r0,[r5,#0x9]	; 038005C8
	lsl r1,r0,#0x1	; 038005CA
	ldr r0,[pool_03800728]	; 038005CC
	ldrsh r0,[r0,r1]	; 038005CE
	add r6,r6,r0	; 038005D0
	ldrb r1,[r5,#0x8]	; 038005D2
	ldrb r0,[r5,#0x5]	; 038005D4
	sub r0,r1,r0	; 038005D6
	lsl r0,r0,#0x6	; 038005D8
	add r7,r7,r0	; 038005DA
	add r0,r5,#0x0	; 038005DC
	ldr r1,[sp,#0x0]	; 038005DE
	bl loc_037FFFD0	; 038005E0
	add r6,r6,r0	; 038005E4
	add r0,r5,#0x0	; 038005E6
	ldr r1,[sp,#0x0]	; 038005E8
	bl loc_037FFF80	; 038005EA
	add r7,r7,r0	; 038005EE
	add r0,r5,#0x0	; 038005F0
	ldr r1,[sp,#0x0]	; 038005F2
	bl loc_037FFF00	; 038005F4
	add r1,r5,#0x0	; 038005F8
	add r1,#0x28	; 038005FA
	ldrb r1,[r1,#0x0]	; 038005FC
	cmp r1,#0x0	; 038005FE
	beq loc_03800610	; 03800600
	cmp r1,#0x1	; 03800602
	beq loc_0380060C	; 03800604
	cmp r1,#0x2	; 03800606
	beq loc_03800614	; 03800608
	b loc_03800616	; 0380060A
loc_0380060C:
	add r6,r6,r0	; 0380060C
	b loc_03800616	; 0380060E
loc_03800610:
	add r7,r7,r0	; 03800610
	b loc_03800616	; 03800612
loc_03800614:
	add r4,r4,r0	; 03800614
loc_03800616:
	mov r0,#0xc	; 03800616
	ldrsh r0,[r5,r0]	; 03800618
	add r6,r6,r0	; 0380061A
	mov r0,#0xe	; 0380061C
	ldrsh r0,[r5,r0]	; 0380061E
	add r7,r7,r0	; 03800620
	mov r0,#0xb	; 03800622
	ldrsb r0,[r5,r0]	; 03800624
	add r1,r4,r0	; 03800626
	mov r0,#0xa	; 03800628
	ldrsb r0,[r5,r0]	; 0380062A
	add r4,r1,r0	; 0380062C
	ldrb r0,[r5,#0x2]	; 0380062E
	cmp r0,#0x3	; 03800630
	bne loc_03800668	; 03800632
	ldr r0,[pool_0380072C]	; 03800634
	cmp r6,r0	; 03800636
	bgt loc_03800668	; 03800638
	mov r0,#0x2	; 0380063A
	strb r0,[r5,#0x4]	; 0380063C
	ldr r3,[r5,#0x48]	; 0380063E
	cmp r3,#0x0	; 03800640
	beq loc_03800650	; 03800642
	add r0,r5,#0x0	; 03800644
	mov r1,#0x2	; 03800646
	ldr r2,[r5,#0x4c]	; 03800648
	bl loc_03805474	; 0380064A
	b loc_03800658	; 0380064E
loc_03800650:
	add r1,r5,#0x0	; 03800650
	add r1,#0x22	; 03800652
	ldr r0,[sp,#0x14]	; 03800654
	strb r0,[r1,#0x0]	; 03800656
loc_03800658:
	ldr r0,[sp,#0x18]	; 03800658
	strh r0,[r5,#0x24]	; 0380065A
	add r2,r5,#0x3	; 0380065C
	ldrb r1,[r2,#0x0]	; 0380065E
	mov r0,#0x1	; 03800660
	bic r1,r0	; 03800662
	strb r1,[r2,#0x0]	; 03800664
	b loc_03800710	; 03800666
loc_03800668:
	add r0,r6,#0x0	; 03800668
	bl loc_037FFC08	; 0380066A
	add r6,r0,#0x0	; 0380066E
	ldrh r0,[r5,#0x3c]	; 03800670
	add r1,r7,#0x0	; 03800672
	bl loc_037FFC60	; 03800674
	ldrb r1,[r5,#0x1]	; 03800678
	cmp r1,#0x1	; 0380067A
	bne loc_03800686	; 0380067C
	ldr r1,[pool_03800730]	; 0380067E
	and r0,r1	; 03800680
	lsl r0,r0,#0x10	; 03800682
	lsr r0,r0,#0x10	; 03800684
loc_03800686:
	add r4,#0x40	; 03800686
	cmp r4,#0x0	; 03800688
	bge loc_03800690	; 0380068A
	ldr r4,[sp,#0x1c]	; 0380068C
	b loc_03800696	; 0380068E
loc_03800690:
	cmp r4,#0x7f	; 03800690
	ble loc_03800696	; 03800692
	mov r4,#0x7f	; 03800694
loc_03800696:
	ldrh r1,[r5,#0x24]	; 03800696
	cmp r6,r1	; 03800698
	beq loc_038006A8	; 0380069A
	strh r6,[r5,#0x24]	; 0380069C
	add r3,r5,#0x4	; 0380069E
	ldrb r2,[r3,#0x0]	; 038006A0
	mov r1,#0x8	; 038006A2
	orr r2,r1	; 038006A4
	strb r2,[r3,#0x0]	; 038006A6
loc_038006A8:
	ldrh r1,[r5,#0x26]	; 038006A8
	cmp r0,r1	; 038006AA
	beq loc_038006BA	; 038006AC
	strh r0,[r5,#0x26]	; 038006AE
	add r2,r5,#0x4	; 038006B0
	ldrb r1,[r2,#0x0]	; 038006B2
	mov r0,#0x4	; 038006B4
	orr r1,r0	; 038006B6
	strb r1,[r2,#0x0]	; 038006B8
loc_038006BA:
	add r0,r5,#0x0	; 038006BA
	add r0,#0x23	; 038006BC
	ldrb r0,[r0,#0x0]	; 038006BE
	cmp r4,r0	; 038006C0
	beq loc_038006D4	; 038006C2
	add r0,r5,#0x0	; 038006C4
	add r0,#0x23	; 038006C6
	strb r4,[r0,#0x0]	; 038006C8
	add r2,r5,#0x4	; 038006CA
	ldrb r1,[r2,#0x0]	; 038006CC
	mov r0,#0x10	; 038006CE
	orr r1,r0	; 038006D0
	strb r1,[r2,#0x0]	; 038006D2
loc_038006D4:
	ldr r0,[sp,#0x0]	; 038006D4
	cmp r0,#0x0	; 038006D6
	beq loc_03800710	; 038006D8
	ldr r0,[r5,#0x34]	; 038006DA
	cmp r0,#0x0	; 038006DC
	ble loc_03800710	; 038006DE
	add r1,r5,#0x0	; 038006E0
	add r1,#0x34	; 038006E2
	ldr r0,[r1,#0x0]	; 038006E4
	sub r0,r0,#0x1	; 038006E6
	str r0,[r1,#0x0]	; 038006E8
	ldr r0,[r5,#0x34]	; 038006EA
	cmp r0,#0x0	; 038006EC
	bne loc_03800710	; 038006EE
	ldr r3,[r5,#0x48]	; 038006F0
	cmp r3,#0x0	; 038006F2
	beq loc_03800702	; 038006F4
	add r0,r5,#0x0	; 038006F6
	mov r1,#0x1	; 038006F8
	ldr r2,[r5,#0x4c]	; 038006FA
	bl loc_03805474	; 038006FC
	b loc_0380070A	; 03800700
loc_03800702:
	add r1,r5,#0x0	; 03800702
	add r1,#0x22	; 03800704
	mov r0,#0x1	; 03800706
	strb r0,[r1,#0x0]	; 03800708
loc_0380070A:
	add r0,r5,#0x0	; 0380070A
	bl loc_03800468	; 0380070C
loc_03800710:
	ldr r0,[sp,#0x4]	; 03800710
	add r0,r0,#0x1	; 03800712
	str r0,[sp,#0x4]	; 03800714
	cmp r0,#0x10	; 03800716
	bge loc_0380071C	; 03800718
	b loc_0380055A	; 0380071A
loc_0380071C:
	add sp,#0x24	; 0380071C
	pop {r4,r5,r6,r7}	; 0380071E
	pop {r3}	; 03800720
	bx r3	; 03800722
pool_03800724:
loc_03800724:
	.word 0x03806500	; 03800724
pool_03800728:
loc_03800728:
	.word P2_Data_03805504	; 03800728
pool_0380072C:
loc_0380072C:
	.word 0xFFFFFD2D	; 0380072C
pool_03800730:
loc_03800730:
	.word 0x0000FFFC	; 03800730
P2_Entry_03800734:
	push {r4,r5,r6,r7,lr}	; 03800734
	sub sp,#0x1c	; 03800736
	mov r4,#0x0	; 03800738
	add r7,r4,#0x0	; 0380073A
	mov r6,#0xff	; 0380073C
P2_Entry_0380073E:
	add r1,r4,#0x0	; 0380073E
	mov r0,#0x54	; 03800740
	mul r1,r0	; 03800742
	ldr r0,[pool_0380086C]	; 03800744
	add r5,r0,r1	; 03800746
	ldrb r1,[r5,#0x4]	; 03800748
	cmp r1,#0x0	; 0380074A
	beq P2_Entry_0380082C	; 0380074C
	mov r0,#0x2	; 0380074E
	and r1,r0	; 03800750
	cmp r1,#0x0	; 03800752
	beq P2_Entry_0380075E	; 03800754
	add r0,r4,#0x0	; 03800756
	add r1,r7,#0x0	; 03800758
	bl loc_037FFA18	; 0380075A
P2_Entry_0380075E:
	ldrb r0,[r5,#0x4]	; 0380075E
	add r2,r0,#0x0	; 03800760
	mov r1,#0x1	; 03800762
	and r2,r1	; 03800764
	cmp r2,#0x0	; 03800766
	beq P2_Entry_038007F0	; 03800768
	ldrb r0,[r5,#0x1]	; 0380076A
	cmp r0,#0x0	; 0380076C
	beq P2_Entry_0380077A	; 0380076E
	cmp r0,#0x1	; 03800770
	beq P2_Entry_038007B8	; 03800772
	cmp r0,#0x2	; 03800774
	beq P2_Entry_038007D6	; 03800776
	b P2_Entry_0380082C	; 03800778
P2_Entry_0380077A:
	add r0,r5,#0x0	; 0380077A
	add r0,#0x39	; 0380077C
	ldrb r0,[r0,#0x0]	; 0380077E
	cmp r0,#0x0	; 03800780
	beq P2_Entry_03800788	; 03800782
	lsl r3,r1,#0	; 03800784
	b P2_Entry_0380078A	; 03800786
P2_Entry_03800788:
	mov r3,#0x2	; 03800788
P2_Entry_0380078A:
	ldrh r0,[r5,#0x24]	; 0380078A
	ldrh r1,[r5,#0x3e]	; 0380078C
	str r1,[sp,#0x0]	; 0380078E
	ldr r1,[r5,#0x40]	; 03800790
	str r1,[sp,#0x4]	; 03800792
	add r1,r0,#0x0	; 03800794
	and r1,r6	; 03800796
	str r1,[sp,#0x8]	; 03800798
	asr r0,r0,#0x8	; 0380079A
	str r0,[sp,#0xc]	; 0380079C
	ldrh r0,[r5,#0x26]	; 0380079E
	str r0,[sp,#0x10]	; 038007A0
	add r0,r5,#0x0	; 038007A2
	add r0,#0x23	; 038007A4
	ldrb r0,[r0,#0x0]	; 038007A6
	str r0,[sp,#0x14]	; 038007A8
	add r0,r4,#0x0	; 038007AA
	ldr r1,[r5,#0x44]	; 038007AC
	add r5,#0x38	; 038007AE
	ldrb r2,[r5,#0x0]	; 038007B0
	bl loc_037FFB14	; 038007B2
	b P2_Entry_0380082C	; 038007B6
P2_Entry_038007B8:
	ldrh r3,[r5,#0x24]	; 038007B8
	ldrh r0,[r5,#0x26]	; 038007BA
	str r0,[sp,#0x0]	; 038007BC
	add r0,r5,#0x0	; 038007BE
	add r0,#0x23	; 038007C0
	ldrb r0,[r0,#0x0]	; 038007C2
	str r0,[sp,#0x4]	; 038007C4
	add r0,r4,#0x0	; 038007C6
	ldr r1,[r5,#0x44]	; 038007C8
	add r2,r3,#0x0	; 038007CA
	and r2,r6	; 038007CC
	asr r3,r3,#0x8	; 038007CE
	bl loc_037FFAA8	; 038007D0
	b P2_Entry_0380082C	; 038007D4
P2_Entry_038007D6:
	ldrh r2,[r5,#0x24]	; 038007D6
	add r0,r5,#0x0	; 038007D8
	add r0,#0x23	; 038007DA
	ldrb r0,[r0,#0x0]	; 038007DC
	str r0,[sp,#0x0]	; 038007DE
	add r0,r4,#0x0	; 038007E0
	add r1,r2,#0x0	; 038007E2
	and r1,r6	; 038007E4
	asr r2,r2,#0x8	; 038007E6
	ldrh r3,[r5,#0x26]	; 038007E8
	bl loc_037FFA40	; 038007EA
	b P2_Entry_0380082C	; 038007EE
P2_Entry_038007F0:
	mov r1,#0x4	; 038007F0
	and r0,r1	; 038007F2
	cmp r0,#0x0	; 038007F4
	beq P2_Entry_03800800	; 038007F6
	add r0,r4,#0x0	; 038007F8
	ldrh r1,[r5,#0x26]	; 038007FA
	bl loc_037FF9AC	; 038007FC
P2_Entry_03800800:
	ldrb r1,[r5,#0x4]	; 03800800
	mov r0,#0x8	; 03800802
	and r1,r0	; 03800804
	cmp r1,#0x0	; 03800806
	beq P2_Entry_03800818	; 03800808
	ldrh r2,[r5,#0x24]	; 0380080A
	add r0,r4,#0x0	; 0380080C
	add r1,r2,#0x0	; 0380080E
	and r1,r6	; 03800810
	asr r2,r2,#0x8	; 03800812
	bl loc_037FF9C0	; 03800814
P2_Entry_03800818:
	ldrb r1,[r5,#0x4]	; 03800818
	mov r0,#0x10	; 0380081A
	and r1,r0	; 0380081C
	cmp r1,#0x0	; 0380081E
	beq P2_Entry_0380082C	; 03800820
	add r0,r4,#0x0	; 03800822
	add r5,#0x23	; 03800824
	ldrb r1,[r5,#0x0]	; 03800826
	bl loc_037FF968	; 03800828
P2_Entry_0380082C:
	add r4,r4,#0x1	; 0380082C
	cmp r4,#0x10	; 0380082E
	blt P2_Entry_0380073E	; 03800830
	mov r2,#0x0	; 03800832
	add r5,r2,#0x0	; 03800834
	ldr r0,[pool_0380086C]	; 03800836
	mov r4,#0x54	; 03800838
P2_Entry_0380083A:
	add r1,r2,#0x0	; 0380083A
	mul r1,r4	; 0380083C
	add r1,r0,r1	; 0380083E
	ldrb r6,[r1,#0x4]	; 03800840
	cmp r6,#0x0	; 03800842
	beq P2_Entry_0380085E	; 03800844
	mov r3,#0x1	; 03800846
	and r6,r3	; 03800848
	cmp r6,#0x0	; 0380084A
	beq P2_Entry_0380085C	; 0380084C
	lsl r6,r2,#0x4	; 0380084E
	ldr r3,[pool_03800870]	; 03800850
	add r7,r6,r3	; 03800852
	ldrb r6,[r7,#0x0]	; 03800854
	mov r3,#0x80	; 03800856
	orr r6,r3	; 03800858
	strb r6,[r7,#0x0]	; 0380085A
P2_Entry_0380085C:
	strb r5,[r1,#0x4]	; 0380085C
P2_Entry_0380085E:
	add r2,r2,#0x1	; 0380085E
	cmp r2,#0x10	; 03800860
	blt P2_Entry_0380083A	; 03800862
	add sp,#0x1c	; 03800864
	pop {r4,r5,r6,r7}	; 03800866
	pop {r3}	; 03800868
	bx r3	; 0380086A
pool_0380086C:
	.word 0x03806500	; 0380086C
pool_03800870:
	.word 0x04000403	; 03800870
P2_Entry_03800874:
	push {r4,r5,r6,lr}	; 03800874
	mov r0,#0x0	; 03800876
	ldr r6,[pool_038008A8]	; 03800878
	add r5,r0,#0x0	; 0380087A
	mov r1,#0x54	; 0380087C
	mov r2,#0x1	; 0380087E
P2_Entry_03800880:
	add r3,r0,#0x0	; 03800880
	mul r3,r1	; 03800882
	add r4,r6,r3	; 03800884
	strb r0,[r6,r3]	; 03800886
	strb r5,[r4,#0x4]	; 03800888
	add r4,r4,#0x3	; 0380088A
	ldrb r3,[r4,#0x0]	; 0380088C
	bic r3,r2	; 0380088E
	strb r3,[r4,#0x0]	; 03800890
	add r0,r0,#0x1	; 03800892
	cmp r0,#0x10	; 03800894
	blt P2_Entry_03800880	; 03800896
	ldr r0,[pool_038008AC]	; 03800898
	str r5,[r0,#0x0]	; 0380089A
	ldr r0,[pool_038008B0]	; 0380089C
	str r5,[r0,#0x0]	; 0380089E
	pop {r4,r5,r6}	; 038008A0
	pop {r3}	; 038008A2
	bx r3	; 038008A4
	.byte 0xC0, 0x46	; 038008A6
pool_038008A8:
	.word P2_BssStart + 0xD84	; 038008A8
pool_038008AC:
	.word P2_BssStart + 0xD64	; 038008AC
pool_038008B0:
	.word P2_BssStart + 0xD60	; 038008B0

; ===== function loc_038008B4 =====
loc_038008B4:
	push {r4,lr}	; 038008B4
	mov r0,#0x0	; 038008B6
	ldr r3,[pool_038008E4]	; 038008B8
	b loc_038008D6	; 038008BA
loc_038008BC:
	lsl r1,r0,#0x6	; 038008BC
	add r4,r3,r1	; 038008BE
	ldrb r2,[r3,r1]	; 038008C0
	lsl r1,r2,#0x1f	; 038008C2
	lsr r1,r1,#0x1f	; 038008C4
	cmp r1,#0x0	; 038008C6
	bne loc_038008D4	; 038008C8
	mov r1,#0x1	; 038008CA
	bic r2,r1	; 038008CC
	orr r2,r1	; 038008CE
	strb r2,[r4,#0x0]	; 038008D0
	b loc_038008DE	; 038008D2
loc_038008D4:
	add r0,r0,#0x1	; 038008D4
loc_038008D6:
	cmp r0,#0x20	; 038008D6
	blt loc_038008BC	; 038008D8
	mov r0,#0x0	; 038008DA
	mvn r0,r0	; 038008DC
loc_038008DE:
	pop {r4}	; 038008DE
	pop {r3}	; 038008E0
	bx r3	; 038008E2
pool_038008E4:
loc_038008E4:
	.word 0x03806C80	; 038008E4

; ===== function loc_038008E8 =====
loc_038008E8:
	ldr r2,[pool_03800914]	; 038008E8
	ldr r3,[r2,#0x0]	; 038008EA
	cmp r3,#0x0	; 038008EC
	bne loc_038008F4	; 038008EE
	mov r0,#0x0	; 038008F0
	bx lr	; 038008F2
loc_038008F4:
	cmp r1,#0x10	; 038008F4
	bge loc_03800908	; 038008F6
	add r3,#0x20	; 038008F8
	ldrb r2,[r0,#0x2]	; 038008FA
	mov r0,#0x24	; 038008FC
	mul r2,r0	; 038008FE
	add r2,r3,r2	; 03800900
	lsl r0,r1,#0x1	; 03800902
	add r0,r2,r0	; 03800904
	bx lr	; 03800906
loc_03800908:
	ldr r0,[pool_03800918]	; 03800908
	add r2,r3,r0	; 0380090A
	sub r1,#0x10	; 0380090C
	lsl r0,r1,#0x1	; 0380090E
	add r0,r2,r0	; 03800910
	bx lr	; 03800912
pool_03800914:
loc_03800914:
	.word P2_BssStart + 0xD80	; 03800914
pool_03800918:
loc_03800918:
	.word 0x00000260	; 03800918
P2_Entry_0380091C:
	push {r4,r5,r6,r7,lr}	; 0380091C
	sub sp,#0x4	; 0380091E
	add r5,r0,#0x0	; 03800920
	mov r6,#0x0	; 03800922
	add r4,r6,#0x0	; 03800924
	mov r7,#0x1	; 03800926
P2_Entry_03800928:
	add r0,r5,#0x0	; 03800928
	add r1,r4,#0x0	; 0380092A
	bl loc_03801260	; 0380092C
	cmp r0,#0x0	; 03800930
	beq P2_Entry_03800950	; 03800932
	ldr r1,[r0,#0x28]	; 03800934
	cmp r1,#0x0	; 03800936
	beq P2_Entry_03800950	; 03800938
	add r1,r5,#0x0	; 0380093A
	bl P2_Entry_03800968	; 0380093C
	cmp r0,#0x0	; 03800940
	bne P2_Entry_03800948	; 03800942
	add r6,r7,#0x0	; 03800944
	b P2_Entry_03800950	; 03800946
P2_Entry_03800948:
	add r0,r5,#0x0	; 03800948
	add r1,r4,#0x0	; 0380094A
	bl loc_0380121C	; 0380094C
P2_Entry_03800950:
	add r4,r4,#0x1	; 03800950
	cmp r4,#0x10	; 03800952
	blt P2_Entry_03800928	; 03800954
	cmp r6,#0x0	; 03800956
	bne P2_Entry_0380095E	; 03800958
	mov r0,#0x1	; 0380095A
	b P2_Entry_03800960	; 0380095C
P2_Entry_0380095E:
	mov r0,#0x0	; 0380095E
P2_Entry_03800960:
	add sp,#0x4	; 03800960
	pop {r4,r5,r6,r7}	; 03800962
	pop {r3}	; 03800964
	bx r3	; 03800966
P2_Entry_03800968:
	push {r4,r5,r6,r7,lr}	; 03800968
	sub sp,#0x24	; 0380096A
	add r4,r0,#0x0	; 0380096C
	str r1,[sp,#0x4]	; 0380096E
	ldrb r1,[r4,#0x0]	; 03800970
	lsl r0,r1,#0x1b	; 03800972
	lsr r0,r0,#0x1f	; 03800974
	cmp r0,#0x0	; 03800976
	beq P2_Entry_0380098A	; 03800978
	ldr r0,[r4,#0x3c]	; 0380097A
	cmp r0,#0x0	; 0380097C
	beq P2_Entry_03800984	; 0380097E
	mov r0,#0x0	; 03800980
	b P2_Entry_03800F8C	; 03800982
P2_Entry_03800984:
	mov r0,#0x10	; 03800984
	bic r1,r0	; 03800986
	strb r1,[r4,#0x0]	; 03800988
P2_Entry_0380098A:
	ldr r0,[r4,#0x20]	; 0380098A
	cmp r0,#0x0	; 0380098C
	ble P2_Entry_038009A4	; 0380098E
	add r1,r4,#0x0	; 03800990
	add r1,#0x20	; 03800992
	ldr r0,[r1,#0x0]	; 03800994
	sub r0,r0,#0x1	; 03800996
	str r0,[r1,#0x0]	; 03800998
	ldr r0,[r4,#0x20]	; 0380099A
	cmp r0,#0x0	; 0380099C
	ble P2_Entry_038009A4	; 0380099E
	mov r0,#0x0	; 038009A0
	b P2_Entry_03800F8C	; 038009A2
P2_Entry_038009A4:
	ldr r0,[r4,#0x28]	; 038009A4
	bl loc_038015B0	; 038009A6
	mov r0,#0x0	; 038009AA
	mvn r0,r0	; 038009AC
	str r0,[sp,#0x18]	; 038009AE
	b P2_Entry_03800F78	; 038009B0
P2_Entry_038009B2:
	mov r5,#0x0	; 038009B2
	mov r0,#0x1	; 038009B4
	str r0,[sp,#0xc]	; 038009B6
	add r0,r4,#0x0	; 038009B8
	bl loc_03801568	; 038009BA
	add r6,r0,#0x0	; 038009BE
	cmp r6,#0xa2	; 038009C0
	bne P2_Entry_038009D4	; 038009C2
	add r0,r4,#0x0	; 038009C4
	bl loc_03801568	; 038009C6
	add r6,r0,#0x0	; 038009CA
	ldrb r0,[r4,#0x0]	; 038009CC
	lsl r0,r0,#0x19	; 038009CE
	lsr r0,r0,#0x1f	; 038009D0
	str r0,[sp,#0xc]	; 038009D2
P2_Entry_038009D4:
	cmp r6,#0xa0	; 038009D4
	bne P2_Entry_038009E6	; 038009D6
	add r0,r4,#0x0	; 038009D8
	bl loc_03801568	; 038009DA
	add r6,r0,#0x0	; 038009DE
	mov r0,#0x3	; 038009E0
	str r0,[sp,#0x8]	; 038009E2
	mov r5,#0x1	; 038009E4
P2_Entry_038009E6:
	cmp r6,#0xa1	; 038009E6
	bne P2_Entry_038009F8	; 038009E8
	add r0,r4,#0x0	; 038009EA
	bl loc_03801568	; 038009EC
	add r6,r0,#0x0	; 038009F0
	mov r0,#0x4	; 038009F2
	str r0,[sp,#0x8]	; 038009F4
	mov r5,#0x1	; 038009F6
P2_Entry_038009F8:
	add r1,r6,#0x0	; 038009F8
	mov r0,#0x80	; 038009FA
	and r1,r0	; 038009FC
	cmp r1,#0x0	; 038009FE
	bne P2_Entry_03800A72	; 03800A00
	add r0,r4,#0x0	; 03800A02
	bl loc_03801568	; 03800A04
	str r0,[sp,#0x10]	; 03800A08
	cmp r5,#0x0	; 03800A0A
	beq P2_Entry_03800A12	; 03800A0C
	ldr r2,[sp,#0x8]	; 03800A0E
	b P2_Entry_03800A14	; 03800A10
P2_Entry_03800A12:
	mov r2,#0x2	; 03800A12
P2_Entry_03800A14:
	add r0,r4,#0x0	; 03800A14
	ldr r1,[sp,#0x4]	; 03800A16
	bl P2_Entry_0380143C	; 03800A18
	add r7,r0,#0x0	; 03800A1C
	mov r0,#0x13	; 03800A1E
	ldrsb r0,[r4,r0]	; 03800A20
	add r5,r6,r0	; 03800A22
	ldr r0,[sp,#0xc]	; 03800A24
	cmp r0,#0x0	; 03800A26
	bne P2_Entry_03800A2C	; 03800A28
	b P2_Entry_03800F78	; 03800A2A
P2_Entry_03800A2C:
	cmp r5,#0x0	; 03800A2C
	bge P2_Entry_03800A34	; 03800A2E
	mov r5,#0x0	; 03800A30
	b P2_Entry_03800A3A	; 03800A32
P2_Entry_03800A34:
	cmp r5,#0x7f	; 03800A34
	ble P2_Entry_03800A3A	; 03800A36
	mov r5,#0x7f	; 03800A38
P2_Entry_03800A3A:
	ldrb r0,[r4,#0x0]	; 03800A3A
	lsl r0,r0,#0x1d	; 03800A3C
	lsr r0,r0,#0x1f	; 03800A3E
	cmp r0,#0x0	; 03800A40
	bne P2_Entry_03800A52	; 03800A42
	str r7,[sp,#0x0]	; 03800A44
	add r0,r4,#0x0	; 03800A46
	ldr r1,[sp,#0x4]	; 03800A48
	add r2,r5,#0x0	; 03800A4A
	ldr r3,[sp,#0x10]	; 03800A4C
	bl P2_Entry_03800F94	; 03800A4E
P2_Entry_03800A52:
	strb r5,[r4,#0x14]	; 03800A52
	ldrb r0,[r4,#0x0]	; 03800A54
	lsl r0,r0,#0x1e	; 03800A56
	lsr r0,r0,#0x1f	; 03800A58
	cmp r0,#0x0	; 03800A5A
	bne P2_Entry_03800A60	; 03800A5C
	b P2_Entry_03800F78	; 03800A5E
P2_Entry_03800A60:
	str r7,[r4,#0x20]	; 03800A60
	cmp r7,#0x0	; 03800A62
	beq P2_Entry_03800A68	; 03800A64
	b P2_Entry_03800F78	; 03800A66
P2_Entry_03800A68:
	ldrb r1,[r4,#0x0]	; 03800A68
	mov r0,#0x10	; 03800A6A
	orr r1,r0	; 03800A6C
	strb r1,[r4,#0x0]	; 03800A6E
	b P2_Entry_03800F78	; 03800A70
P2_Entry_03800A72:
	add r1,r6,#0x0	; 03800A72
	mov r0,#0xf0	; 03800A74
	and r1,r0	; 03800A76
	cmp r1,#0xc0	; 03800A78
	bgt P2_Entry_03800A96	; 03800A7A
	cmp r1,#0xc0	; 03800A7C
	bge P2_Entry_03800B7A	; 03800A7E
	cmp r1,#0x90	; 03800A80
	bgt P2_Entry_03800A8E	; 03800A82
	cmp r1,#0x90	; 03800A84
	bge P2_Entry_03800AE2	; 03800A86
	cmp r1,#0x80	; 03800A88
	beq P2_Entry_03800AAE	; 03800A8A
	b P2_Entry_03800F78	; 03800A8C
P2_Entry_03800A8E:
	cmp r1,#0xb0	; 03800A8E
	bne P2_Entry_03800A94	; 03800A90
	b P2_Entry_03800D46	; 03800A92
P2_Entry_03800A94:
	b P2_Entry_03800F78	; 03800A94
P2_Entry_03800A96:
	cmp r1,#0xe0	; 03800A96
	bgt P2_Entry_03800AA6	; 03800A98
	cmp r1,#0xe0	; 03800A9A
	blt P2_Entry_03800AA0	; 03800A9C
	b P2_Entry_03800D0C	; 03800A9E
P2_Entry_03800AA0:
	cmp r1,#0xd0	; 03800AA0
	beq P2_Entry_03800B7A	; 03800AA2
	b P2_Entry_03800F78	; 03800AA4
P2_Entry_03800AA6:
	cmp r1,#0xf0	; 03800AA6
	bne P2_Entry_03800AAC	; 03800AA8
	b P2_Entry_03800EE8	; 03800AAA
P2_Entry_03800AAC:
	b P2_Entry_03800F78	; 03800AAC
P2_Entry_03800AAE:
	cmp r5,#0x0	; 03800AAE
	beq P2_Entry_03800AB6	; 03800AB0
	ldr r2,[sp,#0x8]	; 03800AB2
	b P2_Entry_03800AB8	; 03800AB4
P2_Entry_03800AB6:
	mov r2,#0x2	; 03800AB6
P2_Entry_03800AB8:
	add r0,r4,#0x0	; 03800AB8
	ldr r1,[sp,#0x4]	; 03800ABA
	bl P2_Entry_0380143C	; 03800ABC
	ldr r1,[sp,#0xc]	; 03800AC0
	cmp r1,#0x0	; 03800AC2
	bne P2_Entry_03800AC8	; 03800AC4
	b P2_Entry_03800F78	; 03800AC6
P2_Entry_03800AC8:
	cmp r6,#0x80	; 03800AC8
	beq P2_Entry_03800AD2	; 03800ACA
	cmp r6,#0x81	; 03800ACC
	beq P2_Entry_03800AD6	; 03800ACE
	b P2_Entry_03800F78	; 03800AD0
P2_Entry_03800AD2:
	str r0,[r4,#0x20]	; 03800AD2
	b P2_Entry_03800F78	; 03800AD4
P2_Entry_03800AD6:
	ldr r1,[pool_03800E18]	; 03800AD6
	cmp r0,r1	; 03800AD8
	blt P2_Entry_03800ADE	; 03800ADA
	b P2_Entry_03800F78	; 03800ADC
P2_Entry_03800ADE:
	strh r0,[r4,#0x2]	; 03800ADE
	b P2_Entry_03800F78	; 03800AE0
P2_Entry_03800AE2:
	cmp r6,#0x93	; 03800AE2
	beq P2_Entry_03800AF0	; 03800AE4
	cmp r6,#0x94	; 03800AE6
	beq P2_Entry_03800B30	; 03800AE8
	cmp r6,#0x95	; 03800AEA
	beq P2_Entry_03800B46	; 03800AEC
	b P2_Entry_03800F78	; 03800AEE
P2_Entry_03800AF0:
	add r0,r4,#0x0	; 03800AF0
	bl loc_03801568	; 03800AF2
	add r5,r0,#0x0	; 03800AF6
	add r0,r4,#0x0	; 03800AF8
	bl P2_Entry_038014E8	; 03800AFA
	add r6,r0,#0x0	; 03800AFE
	ldr r0,[sp,#0xc]	; 03800B00
	cmp r0,#0x0	; 03800B02
	bne P2_Entry_03800B08	; 03800B04
	b P2_Entry_03800F78	; 03800B06
P2_Entry_03800B08:
	ldr r0,[sp,#0x4]	; 03800B08
	add r1,r5,#0x0	; 03800B0A
	bl loc_03801260	; 03800B0C
	add r5,r0,#0x0	; 03800B10
	cmp r5,#0x0	; 03800B12
	bne P2_Entry_03800B18	; 03800B14
	b P2_Entry_03800F78	; 03800B16
P2_Entry_03800B18:
	cmp r5,r4	; 03800B18
	bne P2_Entry_03800B1E	; 03800B1A
	b P2_Entry_03800F78	; 03800B1C
P2_Entry_03800B1E:
	ldr r1,[sp,#0x4]	; 03800B1E
	bl loc_03801254	; 03800B20
	add r0,r5,#0x0	; 03800B24
	ldr r1,[r4,#0x24]	; 03800B26
	add r2,r6,#0x0	; 03800B28
	bl loc_0380139C	; 03800B2A
	b P2_Entry_03800F78	; 03800B2E
P2_Entry_03800B30:
	add r0,r4,#0x0	; 03800B30
	bl P2_Entry_038014E8	; 03800B32
	ldr r1,[sp,#0xc]	; 03800B36
	cmp r1,#0x0	; 03800B38
	bne P2_Entry_03800B3E	; 03800B3A
	b P2_Entry_03800F78	; 03800B3C
P2_Entry_03800B3E:
	ldr r1,[r4,#0x24]	; 03800B3E
	add r0,r1,r0	; 03800B40
	str r0,[r4,#0x28]	; 03800B42
	b P2_Entry_03800F78	; 03800B44
P2_Entry_03800B46:
	add r0,r4,#0x0	; 03800B46
	bl P2_Entry_038014E8	; 03800B48
	ldr r1,[sp,#0xc]	; 03800B4C
	cmp r1,#0x0	; 03800B4E
	bne P2_Entry_03800B54	; 03800B50
	b P2_Entry_03800F78	; 03800B52
P2_Entry_03800B54:
	add r1,r4,#0x0	; 03800B54
	add r1,#0x3b	; 03800B56
	ldrb r1,[r1,#0x0]	; 03800B58
	cmp r1,#0x3	; 03800B5A
	bcc P2_Entry_03800B60	; 03800B5C
	b P2_Entry_03800F78	; 03800B5E
P2_Entry_03800B60:
	ldr r2,[r4,#0x28]	; 03800B60
	lsl r1,r1,#0x2	; 03800B62
	add r1,r4,r1	; 03800B64
	str r2,[r1,#0x2c]	; 03800B66
	add r2,r4,#0x0	; 03800B68
	add r2,#0x3b	; 03800B6A
	ldrb r1,[r2,#0x0]	; 03800B6C
	add r1,r1,#0x1	; 03800B6E
	strb r1,[r2,#0x0]	; 03800B70
	ldr r1,[r4,#0x24]	; 03800B72
	add r0,r1,r0	; 03800B74
	str r0,[r4,#0x28]	; 03800B76
	b P2_Entry_03800F78	; 03800B78
P2_Entry_03800B7A:
	cmp r5,#0x0	; 03800B7A
	beq P2_Entry_03800B82	; 03800B7C
	ldr r2,[sp,#0x8]	; 03800B7E
	b P2_Entry_03800B84	; 03800B80
P2_Entry_03800B82:
	mov r2,#0x0	; 03800B82
P2_Entry_03800B84:
	add r0,r4,#0x0	; 03800B84
	ldr r1,[sp,#0x4]	; 03800B86
	bl P2_Entry_0380143C	; 03800B88
	add r1,sp,#0x1c	; 03800B8C
	strb r0,[r1,#0x0]	; 03800B8E
	ldr r0,[sp,#0xc]	; 03800B90
	cmp r0,#0x0	; 03800B92
	bne P2_Entry_03800B98	; 03800B94
	b P2_Entry_03800F78	; 03800B96
P2_Entry_03800B98:
	sub r6,#0xc0	; 03800B98
	cmp r6,#0x15	; 03800B9A
	bls P2_Entry_03800BA0	; 03800B9C
	b P2_Entry_03800F78	; 03800B9E
P2_Entry_03800BA0:
	add r0,r6,r6	; 03800BA0
P2_SwitchIndexPC_03800BA0:
	add r0,pc	; 03800BA2
	ldrh r0,[r0,#(P2_SwitchTable_03800BA0 - (P2_SwitchIndexPC_03800BA0 + 4))]	; 03800BA4
	lsl r0,r0,#0x10	; 03800BA6
	asr r0,r0,#0x10	; 03800BA8
P2_SwitchTargetPC_03800BA0:
	add r0,pc	; 03800BAA
	bx r0	; 03800BAC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800BA0:
	.halfword (P2_Case_03800D02 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800BDA + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800BEA + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800CF2 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800CFA + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800BF4 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800BFC + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C04 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C92 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800CB2 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C22 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C2A + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C32 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C3A + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800CD2 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C1A + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C42 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C4A + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C52 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C5A + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800C62 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
	.halfword (P2_Case_03800BE2 + 1) - (P2_SwitchTargetPC_03800BA0 + 4)
P2_SwitchTable_03800BA0End:
P2_Case_03800BDA:
	lsl r0,r1,#0	; 03800BDA
	ldrb r0,[r0,#0x0]	; 03800BDC
	strb r0,[r4,#0x4]	; 03800BDE
	b P2_Entry_03800F78	; 03800BE0
P2_Case_03800BE2:
	lsl r0,r1,#0	; 03800BE2
	ldrb r0,[r0,#0x0]	; 03800BE4
	strb r0,[r4,#0x5]	; 03800BE6
	b P2_Entry_03800F78	; 03800BE8
P2_Case_03800BEA:
	lsl r0,r1,#0	; 03800BEA
	ldrb r1,[r0,#0x0]	; 03800BEC
	ldr r0,[sp,#0x4]	; 03800BEE
	strb r1,[r0,#0x5]	; 03800BF0
	b P2_Entry_03800F78	; 03800BF2
P2_Case_03800BF4:
	lsl r0,r1,#0	; 03800BF4
	ldrb r0,[r0,#0x0]	; 03800BF6
	strb r0,[r4,#0x7]	; 03800BF8
	b P2_Entry_03800F78	; 03800BFA
P2_Case_03800BFC:
	lsl r0,r1,#0	; 03800BFC
	ldrb r0,[r0,#0x0]	; 03800BFE
	strb r0,[r4,#0x12]	; 03800C00
	b P2_Entry_03800F78	; 03800C02
P2_Case_03800C04:
	ldrb r0,[r4,#0x0]	; 03800C04
	mov r1,#0x2	; 03800C06
	bic r0,r1	; 03800C08
	add r1,sp,#0x1c	; 03800C0A
	ldrb r2,[r1,#0x0]	; 03800C0C
	mov r1,#0x1	; 03800C0E
	and r2,r1	; 03800C10
	lsl r1,r2,#0x1	; 03800C12
	orr r0,r1	; 03800C14
	strb r0,[r4,#0x0]	; 03800C16
	b P2_Entry_03800F78	; 03800C18
P2_Case_03800C1A:
	lsl r0,r1,#0	; 03800C1A
	ldrb r0,[r0,#0x0]	; 03800C1C
	strb r0,[r4,#0x15]	; 03800C1E
	b P2_Entry_03800F78	; 03800C20
P2_Case_03800C22:
	lsl r0,r1,#0	; 03800C22
	ldrb r0,[r0,#0x0]	; 03800C24
	strb r0,[r4,#0x1a]	; 03800C26
	b P2_Entry_03800F78	; 03800C28
P2_Case_03800C2A:
	lsl r0,r1,#0	; 03800C2A
	ldrb r0,[r0,#0x0]	; 03800C2C
	strb r0,[r4,#0x19]	; 03800C2E
	b P2_Entry_03800F78	; 03800C30
P2_Case_03800C32:
	lsl r0,r1,#0	; 03800C32
	ldrb r0,[r0,#0x0]	; 03800C34
	strb r0,[r4,#0x18]	; 03800C36
	b P2_Entry_03800F78	; 03800C38
P2_Case_03800C3A:
	lsl r0,r1,#0	; 03800C3A
	ldrb r0,[r0,#0x0]	; 03800C3C
	strb r0,[r4,#0x1b]	; 03800C3E
	b P2_Entry_03800F78	; 03800C40
P2_Case_03800C42:
	lsl r0,r1,#0	; 03800C42
	ldrb r0,[r0,#0x0]	; 03800C44
	strb r0,[r4,#0xe]	; 03800C46
	b P2_Entry_03800F78	; 03800C48
P2_Case_03800C4A:
	lsl r0,r1,#0	; 03800C4A
	ldrb r0,[r0,#0x0]	; 03800C4C
	strb r0,[r4,#0xf]	; 03800C4E
	b P2_Entry_03800F78	; 03800C50
P2_Case_03800C52:
	lsl r0,r1,#0	; 03800C52
	ldrb r0,[r0,#0x0]	; 03800C54
	strb r0,[r4,#0x10]	; 03800C56
	b P2_Entry_03800F78	; 03800C58
P2_Case_03800C5A:
	lsl r0,r1,#0	; 03800C5A
	ldrb r0,[r0,#0x0]	; 03800C5C
	strb r0,[r4,#0x11]	; 03800C5E
	b P2_Entry_03800F78	; 03800C60
P2_Case_03800C62:
	add r0,r4,#0x0	; 03800C62
	add r0,#0x3b	; 03800C64
	ldrb r0,[r0,#0x0]	; 03800C66
	cmp r0,#0x3	; 03800C68
	bcc P2_Entry_03800C6E	; 03800C6A
	b P2_Entry_03800F78	; 03800C6C
P2_Entry_03800C6E:
	ldr r1,[r4,#0x28]	; 03800C6E
	lsl r0,r0,#0x2	; 03800C70
	add r0,r4,r0	; 03800C72
	str r1,[r0,#0x2c]	; 03800C74
	add r0,sp,#0x1c	; 03800C76
	ldrb r1,[r0,#0x0]	; 03800C78
	add r0,r4,#0x0	; 03800C7A
	add r0,#0x3b	; 03800C7C
	ldrb r0,[r0,#0x0]	; 03800C7E
	add r0,r4,r0	; 03800C80
	add r0,#0x38	; 03800C82
	strb r1,[r0,#0x0]	; 03800C84
	add r1,r4,#0x0	; 03800C86
	add r1,#0x3b	; 03800C88
	ldrb r0,[r1,#0x0]	; 03800C8A
	add r0,r0,#0x1	; 03800C8C
	strb r0,[r1,#0x0]	; 03800C8E
	b P2_Entry_03800F78	; 03800C90
P2_Case_03800C92:
	ldrb r0,[r4,#0x0]	; 03800C92
	mov r1,#0x8	; 03800C94
	bic r0,r1	; 03800C96
	add r1,sp,#0x1c	; 03800C98
	ldrb r2,[r1,#0x0]	; 03800C9A
	mov r1,#0x1	; 03800C9C
	and r2,r1	; 03800C9E
	lsl r1,r2,#0x3	; 03800CA0
	orr r0,r1	; 03800CA2
	strb r0,[r4,#0x0]	; 03800CA4
	add r0,r4,#0x0	; 03800CA6
	ldr r1,[sp,#0x4]	; 03800CA8
	ldr r2,[sp,#0x18]	; 03800CAA
	bl loc_038012E8	; 03800CAC
	b P2_Entry_03800F78	; 03800CB0
P2_Case_03800CB2:
	lsl r0,r1,#0	; 03800CB2
	ldrb r1,[r0,#0x0]	; 03800CB4
	mov r0,#0x13	; 03800CB6
	ldrsb r0,[r4,r0]	; 03800CB8
	add r0,r1,r0	; 03800CBA
	strb r0,[r4,#0x14]	; 03800CBC
	ldrb r1,[r4,#0x0]	; 03800CBE
	mov r0,#0x20	; 03800CC0
	orr r1,r0	; 03800CC2
	strb r1,[r4,#0x0]	; 03800CC4
	add r0,r4,#0x0	; 03800CC6
	ldr r1,[sp,#0x4]	; 03800CC8
	ldr r2,[sp,#0x18]	; 03800CCA
	bl loc_038012E8	; 03800CCC
	b P2_Entry_03800F78	; 03800CD0
P2_Case_03800CD2:
	ldrb r0,[r4,#0x0]	; 03800CD2
	mov r1,#0x20	; 03800CD4
	bic r0,r1	; 03800CD6
	add r1,sp,#0x1c	; 03800CD8
	ldrb r2,[r1,#0x0]	; 03800CDA
	mov r1,#0x1	; 03800CDC
	and r2,r1	; 03800CDE
	lsl r1,r2,#0x5	; 03800CE0
	orr r0,r1	; 03800CE2
	strb r0,[r4,#0x0]	; 03800CE4
	add r0,r4,#0x0	; 03800CE6
	ldr r1,[sp,#0x4]	; 03800CE8
	ldr r2,[sp,#0x18]	; 03800CEA
	bl loc_038012E8	; 03800CEC
	b P2_Entry_03800F78	; 03800CF0
P2_Case_03800CF2:
	mov r0,#0x0	; 03800CF2
	ldrsb r0,[r1,r0]	; 03800CF4
	strb r0,[r4,#0x13]	; 03800CF6
	b P2_Entry_03800F78	; 03800CF8
P2_Case_03800CFA:
	mov r0,#0x0	; 03800CFA
	ldrsb r0,[r1,r0]	; 03800CFC
	strb r0,[r4,#0x6]	; 03800CFE
	b P2_Entry_03800F78	; 03800D00
P2_Case_03800D02:
	lsl r0,r1,#0	; 03800D02
	ldrb r0,[r0,#0x0]	; 03800D04
	sub r0,#0x40	; 03800D06
	strb r0,[r4,#0x8]	; 03800D08
	b P2_Entry_03800F78	; 03800D0A
P2_Entry_03800D0C:
	cmp r5,#0x0	; 03800D0C
	beq P2_Entry_03800D14	; 03800D0E
	ldr r2,[sp,#0x8]	; 03800D10
	b P2_Entry_03800D16	; 03800D12
P2_Entry_03800D14:
	mov r2,#0x1	; 03800D14
P2_Entry_03800D16:
	add r0,r4,#0x0	; 03800D16
	ldr r1,[sp,#0x4]	; 03800D18
	bl P2_Entry_0380143C	; 03800D1A
	lsl r0,r0,#0x10	; 03800D1E
	asr r1,r0,#0x10	; 03800D20
	ldr r0,[sp,#0xc]	; 03800D22
	cmp r0,#0x0	; 03800D24
	bne P2_Entry_03800D2A	; 03800D26
	b P2_Entry_03800F78	; 03800D28
P2_Entry_03800D2A:
	cmp r6,#0xe0	; 03800D2A
	beq P2_Entry_03800D3E	; 03800D2C
	cmp r6,#0xe1	; 03800D2E
	beq P2_Entry_03800D38	; 03800D30
	cmp r6,#0xe3	; 03800D32
	beq P2_Entry_03800D42	; 03800D34
	b P2_Entry_03800F78	; 03800D36
P2_Entry_03800D38:
	ldr r0,[sp,#0x4]	; 03800D38
	strh r1,[r0,#0x18]	; 03800D3A
	b P2_Entry_03800F78	; 03800D3C
P2_Entry_03800D3E:
	strh r1,[r4,#0x1c]	; 03800D3E
	b P2_Entry_03800F78	; 03800D40
P2_Entry_03800D42:
	strh r1,[r4,#0x16]	; 03800D42
	b P2_Entry_03800F78	; 03800D44
P2_Entry_03800D46:
	add r0,r4,#0x0	; 03800D46
	bl loc_03801568	; 03800D48
	str r0,[sp,#0x14]	; 03800D4C
	cmp r5,#0x0	; 03800D4E
	beq P2_Entry_03800D56	; 03800D50
	ldr r2,[sp,#0x8]	; 03800D52
	b P2_Entry_03800D58	; 03800D54
P2_Entry_03800D56:
	mov r2,#0x1	; 03800D56
P2_Entry_03800D58:
	add r0,r4,#0x0	; 03800D58
	ldr r1,[sp,#0x4]	; 03800D5A
	bl P2_Entry_0380143C	; 03800D5C
	lsl r0,r0,#0x10	; 03800D60
	asr r7,r0,#0x10	; 03800D62
	ldr r0,[sp,#0x4]	; 03800D64
	ldr r1,[sp,#0x14]	; 03800D66
	bl loc_038008E8	; 03800D68
	add r5,r0,#0x0	; 03800D6C
	ldr r0,[sp,#0xc]	; 03800D6E
	cmp r0,#0x0	; 03800D70
	bne P2_Entry_03800D76	; 03800D72
	b P2_Entry_03800F78	; 03800D74
P2_Entry_03800D76:
	cmp r5,#0x0	; 03800D76
	bne P2_Entry_03800D7C	; 03800D78
	b P2_Entry_03800F78	; 03800D7A
P2_Entry_03800D7C:
	sub r6,#0xb0	; 03800D7C
	cmp r6,#0xd	; 03800D7E
	bls P2_Entry_03800D84	; 03800D80
	b P2_Entry_03800F78	; 03800D82
P2_Entry_03800D84:
	add r0,r6,r6	; 03800D84
P2_SwitchIndexPC_03800D84:
	add r0,pc	; 03800D86
	ldrh r0,[r0,#(P2_SwitchTable_03800D84 - (P2_SwitchIndexPC_03800D84 + 4))]	; 03800D88
	lsl r0,r0,#0x10	; 03800D8A
	asr r0,r0,#0x10	; 03800D8C
P2_SwitchTargetPC_03800D84:
	add r0,pc	; 03800D8E
	bx r0	; 03800D90
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800D84:
	.halfword (P2_Case_03800DAE + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800DB2 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800DBC + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800DC6 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800DD0 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800DE4 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800DFE + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Entry_03800F78 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800E0C + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800E34 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800E58 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800E7C + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800EA0 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
	.halfword (P2_Case_03800EC4 + 1) - (P2_SwitchTargetPC_03800D84 + 4)
P2_SwitchTable_03800D84End:
P2_Case_03800DAE:
	strh r7,[r5,#0x0]	; 03800DAE
	b P2_Entry_03800F78	; 03800DB0
P2_Case_03800DB2:
	mov r0,#0x0	; 03800DB2
	ldrsh r0,[r5,r0]	; 03800DB4
	add r0,r0,r7	; 03800DB6
	strh r0,[r5,#0x0]	; 03800DB8
	b P2_Entry_03800F78	; 03800DBA
P2_Case_03800DBC:
	mov r0,#0x0	; 03800DBC
	ldrsh r0,[r5,r0]	; 03800DBE
	sub r0,r0,r7	; 03800DC0
	strh r0,[r5,#0x0]	; 03800DC2
	b P2_Entry_03800F78	; 03800DC4
P2_Case_03800DC6:
	mov r0,#0x0	; 03800DC6
	ldrsh r0,[r5,r0]	; 03800DC8
	mul r0,r7	; 03800DCA
	strh r0,[r5,#0x0]	; 03800DCC
	b P2_Entry_03800F78	; 03800DCE
P2_Case_03800DD0:
	cmp r7,#0x0	; 03800DD0
	bne P2_Entry_03800DD6	; 03800DD2
	b P2_Entry_03800F78	; 03800DD4
P2_Entry_03800DD6:
	mov r0,#0x0	; 03800DD6
	ldrsh r0,[r5,r0]	; 03800DD8
	add r1,r7,#0x0	; 03800DDA
	bl loc_037FE6E4	; 03800DDC
	strh r0,[r5,#0x0]	; 03800DE0
	b P2_Entry_03800F78	; 03800DE2
P2_Case_03800DE4:
	cmp r7,#0x0	; 03800DE4
	blt P2_Entry_03800DF2	; 03800DE6
	mov r0,#0x0	; 03800DE8
	ldrsh r0,[r5,r0]	; 03800DEA
	lsl r0,r7	; 03800DEC
	strh r0,[r5,#0x0]	; 03800DEE
	b P2_Entry_03800F78	; 03800DF0
P2_Entry_03800DF2:
	mov r0,#0x0	; 03800DF2
	ldrsh r1,[r5,r0]	; 03800DF4
	neg r0,r7	; 03800DF6
	asr r1,r0	; 03800DF8
	strh r1,[r5,#0x0]	; 03800DFA
	b P2_Entry_03800F78	; 03800DFC
P2_Case_03800DFE:
	bl loc_037FFBA4	; 03800DFE
	add r1,r7,#0x1	; 03800E02
	mul r0,r1	; 03800E04
	asr r0,r0,#0x10	; 03800E06
	strh r0,[r5,#0x0]	; 03800E08
	b P2_Entry_03800F78	; 03800E0A
P2_Case_03800E0C:
	mov r0,#0x0	; 03800E0C
	ldrsh r0,[r5,r0]	; 03800E0E
	cmp r0,r7	; 03800E10
	bne P2_Entry_03800E1C	; 03800E12
	mov r2,#0x1	; 03800E14
	b P2_Entry_03800E1E	; 03800E16
pool_03800E18:
	.word 0x00010000	; 03800E18
P2_Entry_03800E1C:
	mov r2,#0x0	; 03800E1C
P2_Entry_03800E1E:
	ldrb r0,[r4,#0x0]	; 03800E1E
	mov r1,#0x40	; 03800E20
	bic r0,r1	; 03800E22
	lsl r1,r2,#0x18	; 03800E24
	lsr r2,r1,#0x18	; 03800E26
	mov r1,#0x1	; 03800E28
	and r2,r1	; 03800E2A
	lsl r1,r2,#0x6	; 03800E2C
	orr r0,r1	; 03800E2E
	strb r0,[r4,#0x0]	; 03800E30
	b P2_Entry_03800F78	; 03800E32
P2_Case_03800E34:
	mov r0,#0x0	; 03800E34
	ldrsh r0,[r5,r0]	; 03800E36
	cmp r0,r7	; 03800E38
	blt P2_Entry_03800E40	; 03800E3A
	mov r2,#0x1	; 03800E3C
	b P2_Entry_03800E42	; 03800E3E
P2_Entry_03800E40:
	mov r2,#0x0	; 03800E40
P2_Entry_03800E42:
	ldrb r0,[r4,#0x0]	; 03800E42
	mov r1,#0x40	; 03800E44
	bic r0,r1	; 03800E46
	lsl r1,r2,#0x18	; 03800E48
	lsr r2,r1,#0x18	; 03800E4A
	mov r1,#0x1	; 03800E4C
	and r2,r1	; 03800E4E
	lsl r1,r2,#0x6	; 03800E50
	orr r0,r1	; 03800E52
	strb r0,[r4,#0x0]	; 03800E54
	b P2_Entry_03800F78	; 03800E56
P2_Case_03800E58:
	mov r0,#0x0	; 03800E58
	ldrsh r0,[r5,r0]	; 03800E5A
	cmp r0,r7	; 03800E5C
	ble P2_Entry_03800E64	; 03800E5E
	mov r2,#0x1	; 03800E60
	b P2_Entry_03800E66	; 03800E62
P2_Entry_03800E64:
	mov r2,#0x0	; 03800E64
P2_Entry_03800E66:
	ldrb r0,[r4,#0x0]	; 03800E66
	mov r1,#0x40	; 03800E68
	bic r0,r1	; 03800E6A
	lsl r1,r2,#0x18	; 03800E6C
	lsr r2,r1,#0x18	; 03800E6E
	mov r1,#0x1	; 03800E70
	and r2,r1	; 03800E72
	lsl r1,r2,#0x6	; 03800E74
	orr r0,r1	; 03800E76
	strb r0,[r4,#0x0]	; 03800E78
	b P2_Entry_03800F78	; 03800E7A
P2_Case_03800E7C:
	mov r0,#0x0	; 03800E7C
	ldrsh r0,[r5,r0]	; 03800E7E
	cmp r0,r7	; 03800E80
	bgt P2_Entry_03800E88	; 03800E82
	mov r2,#0x1	; 03800E84
	b P2_Entry_03800E8A	; 03800E86
P2_Entry_03800E88:
	mov r2,#0x0	; 03800E88
P2_Entry_03800E8A:
	ldrb r0,[r4,#0x0]	; 03800E8A
	mov r1,#0x40	; 03800E8C
	bic r0,r1	; 03800E8E
	lsl r1,r2,#0x18	; 03800E90
	lsr r2,r1,#0x18	; 03800E92
	mov r1,#0x1	; 03800E94
	and r2,r1	; 03800E96
	lsl r1,r2,#0x6	; 03800E98
	orr r0,r1	; 03800E9A
	strb r0,[r4,#0x0]	; 03800E9C
	b P2_Entry_03800F78	; 03800E9E
P2_Case_03800EA0:
	mov r0,#0x0	; 03800EA0
	ldrsh r0,[r5,r0]	; 03800EA2
	cmp r0,r7	; 03800EA4
	bge P2_Entry_03800EAC	; 03800EA6
	mov r2,#0x1	; 03800EA8
	b P2_Entry_03800EAE	; 03800EAA
P2_Entry_03800EAC:
	mov r2,#0x0	; 03800EAC
P2_Entry_03800EAE:
	ldrb r0,[r4,#0x0]	; 03800EAE
	mov r1,#0x40	; 03800EB0
	bic r0,r1	; 03800EB2
	lsl r1,r2,#0x18	; 03800EB4
	lsr r2,r1,#0x18	; 03800EB6
	mov r1,#0x1	; 03800EB8
	and r2,r1	; 03800EBA
	lsl r1,r2,#0x6	; 03800EBC
	orr r0,r1	; 03800EBE
	strb r0,[r4,#0x0]	; 03800EC0
	b P2_Entry_03800F78	; 03800EC2
P2_Case_03800EC4:
	mov r0,#0x0	; 03800EC4
	ldrsh r0,[r5,r0]	; 03800EC6
	cmp r0,r7	; 03800EC8
	beq P2_Entry_03800ED0	; 03800ECA
	mov r2,#0x1	; 03800ECC
	b P2_Entry_03800ED2	; 03800ECE
P2_Entry_03800ED0:
	mov r2,#0x0	; 03800ED0
P2_Entry_03800ED2:
	ldrb r0,[r4,#0x0]	; 03800ED2
	mov r1,#0x40	; 03800ED4
	bic r0,r1	; 03800ED6
	lsl r1,r2,#0x18	; 03800ED8
	lsr r2,r1,#0x18	; 03800EDA
	mov r1,#0x1	; 03800EDC
	and r2,r1	; 03800EDE
	lsl r1,r2,#0x6	; 03800EE0
	orr r0,r1	; 03800EE2
	strb r0,[r4,#0x0]	; 03800EE4
	b P2_Entry_03800F78	; 03800EE6
P2_Entry_03800EE8:
	ldr r0,[sp,#0xc]	; 03800EE8
	cmp r0,#0x0	; 03800EEA
	beq P2_Entry_03800F78	; 03800EEC
	sub r6,#0xfc	; 03800EEE
	cmp r6,#0x3	; 03800EF0
	bhi P2_Entry_03800F78	; 03800EF2
	add r0,r6,r6	; 03800EF4
P2_SwitchIndexPC_03800EF4:
	add r0,pc	; 03800EF6
	ldrh r0,[r0,#(P2_SwitchTable_03800EF4 - (P2_SwitchIndexPC_03800EF4 + 4))]	; 03800EF8
	lsl r0,r0,#0x10	; 03800EFA
	asr r0,r0,#0x10	; 03800EFC
P2_SwitchTargetPC_03800EF4:
	add r0,pc	; 03800EFE
	bx r0	; 03800F00
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800EF4:
	.halfword (P2_Case_03800F2E + 1) - (P2_SwitchTargetPC_03800EF4 + 4)
	.halfword (P2_Case_03800F0A + 1) - (P2_SwitchTargetPC_03800EF4 + 4)
	.halfword (P2_Entry_03800F78 + 1) - (P2_SwitchTargetPC_03800EF4 + 4)
	.halfword (P2_Case_03800F72 + 1) - (P2_SwitchTargetPC_03800EF4 + 4)
P2_SwitchTable_03800EF4End:
P2_Case_03800F0A:
	add r0,r4,#0x0	; 03800F0A
	add r0,#0x3b	; 03800F0C
	ldrb r0,[r0,#0x0]	; 03800F0E
	cmp r0,#0x0	; 03800F10
	beq P2_Entry_03800F78	; 03800F12
	add r1,r4,#0x0	; 03800F14
	add r1,#0x3b	; 03800F16
	ldrb r0,[r1,#0x0]	; 03800F18
	sub r0,r0,#0x1	; 03800F1A
	strb r0,[r1,#0x0]	; 03800F1C
	add r0,r4,#0x0	; 03800F1E
	add r0,#0x3b	; 03800F20
	ldrb r0,[r0,#0x0]	; 03800F22
	lsl r0,r0,#0x2	; 03800F24
	add r0,r4,r0	; 03800F26
	ldr r0,[r0,#0x2c]	; 03800F28
	str r0,[r4,#0x28]	; 03800F2A
	b P2_Entry_03800F78	; 03800F2C
P2_Case_03800F2E:
	add r0,r4,#0x0	; 03800F2E
	add r0,#0x3b	; 03800F30
	ldrb r0,[r0,#0x0]	; 03800F32
	cmp r0,#0x0	; 03800F34
	beq P2_Entry_03800F78	; 03800F36
	sub r0,r0,#0x1	; 03800F38
	add r1,r4,r0	; 03800F3A
	add r0,r1,#0x0	; 03800F3C
	add r0,#0x38	; 03800F3E
	ldrb r0,[r0,#0x0]	; 03800F40
	cmp r0,#0x0	; 03800F42
	beq P2_Entry_03800F5C	; 03800F44
	sub r0,r0,#0x1	; 03800F46
	lsl r0,r0,#0x18	; 03800F48
	lsr r0,r0,#0x18	; 03800F4A
	cmp r0,#0x0	; 03800F4C
	bne P2_Entry_03800F5C	; 03800F4E
	add r1,r4,#0x0	; 03800F50
	add r1,#0x3b	; 03800F52
	ldrb r0,[r1,#0x0]	; 03800F54
	sub r0,r0,#0x1	; 03800F56
	strb r0,[r1,#0x0]	; 03800F58
	b P2_Entry_03800F78	; 03800F5A
P2_Entry_03800F5C:
	add r1,#0x38	; 03800F5C
	strb r0,[r1,#0x0]	; 03800F5E
	add r0,r4,#0x0	; 03800F60
	add r0,#0x3b	; 03800F62
	ldrb r0,[r0,#0x0]	; 03800F64
	sub r0,r0,#0x1	; 03800F66
	lsl r0,r0,#0x2	; 03800F68
	add r0,r4,r0	; 03800F6A
	ldr r0,[r0,#0x2c]	; 03800F6C
	str r0,[r4,#0x28]	; 03800F6E
	b P2_Entry_03800F78	; 03800F70
P2_Case_03800F72:
	mov r0,#0x0	; 03800F72
	mvn r0,r0	; 03800F74
	b P2_Entry_03800F8C	; 03800F76
P2_Entry_03800F78:
	ldr r0,[r4,#0x20]	; 03800F78
	cmp r0,#0x0	; 03800F7A
	bne P2_Entry_03800F8A	; 03800F7C
	ldrb r0,[r4,#0x0]	; 03800F7E
	lsl r0,r0,#0x1b	; 03800F80
	lsr r0,r0,#0x1f	; 03800F82
	cmp r0,#0x0	; 03800F84
	bne P2_Entry_03800F8A	; 03800F86
	b P2_Entry_038009B2	; 03800F88
P2_Entry_03800F8A:
	mov r0,#0x0	; 03800F8A
P2_Entry_03800F8C:
	add sp,#0x24	; 03800F8C
	pop {r4,r5,r6,r7}	; 03800F8E
	pop {r3}	; 03800F90
	bx r3	; 03800F92
P2_Entry_03800F94:
	push {r4,r5,r6,r7,lr}	; 03800F94
	sub sp,#0x1c	; 03800F96
	add r4,r0,#0x0	; 03800F98
	add r6,r1,#0x0	; 03800F9A
	add r7,r2,#0x0	; 03800F9C
	str r3,[sp,#0x8]	; 03800F9E
	mov r5,#0x0	; 03800FA0
	ldr r1,[sp,#0x30]	; 03800FA2
	ldrh r0,[r6,#0x18]	; 03800FA4
	ldrh r2,[r6,#0x1a]	; 03800FA6
	mul r0,r2	; 03800FA8
	mov r2,#0xf0	; 03800FAA
	mul r1,r2	; 03800FAC
	asr r2,r0,#0x8	; 03800FAE
	sub r0,r2,#0x1	; 03800FB0
	add r0,r1,r0	; 03800FB2
	add r1,r2,#0x0	; 03800FB4
	bl loc_037FE6E4	; 03800FB6
	str r0,[sp,#0xc]	; 03800FBA
	ldrb r0,[r4,#0x0]	; 03800FBC
	lsl r0,r0,#0x1c	; 03800FBE
	lsr r0,r0,#0x1f	; 03800FC0
	cmp r0,#0x0	; 03800FC2
	beq P2_Entry_03800FD2	; 03800FC4
	ldr r5,[r4,#0x3c]	; 03800FC6
	cmp r5,#0x0	; 03800FC8
	beq P2_Entry_03800FD2	; 03800FCA
	strb r7,[r5,#0x8]	; 03800FCC
	ldr r0,[sp,#0x8]	; 03800FCE
	strb r0,[r5,#0x9]	; 03800FD0
P2_Entry_03800FD2:
	cmp r5,#0x0	; 03800FD2
	bne P2_Entry_0380106E	; 03800FD4
	ldr r0,[r6,#0x20]	; 03800FD6
	ldrh r1,[r4,#0x2]	; 03800FD8
	add r2,r7,#0x0	; 03800FDA
	add r3,sp,#0x10	; 03800FDC
	bl P2_Entry_03801A64	; 03800FDE
	cmp r0,#0x0	; 03800FE2
	beq P2_Entry_038010E6	; 03800FE4
	add r0,sp,#0x10	; 03800FE6
	ldrb r0,[r0,#0x0]	; 03800FE8
	cmp r0,#0x4	; 03800FEA
	bhi P2_Entry_038010E6	; 03800FEC
	add r0,r0,r0	; 03800FEE
P2_SwitchIndexPC_03800FEE:
	add r0,pc	; 03800FF0
	ldrh r0,[r0,#(P2_SwitchTable_03800FEE - (P2_SwitchIndexPC_03800FEE + 4))]	; 03800FF2
	lsl r0,r0,#0x10	; 03800FF4
	asr r0,r0,#0x10	; 03800FF6
P2_SwitchTargetPC_03800FEE:
	add r0,pc	; 03800FF8
	bx r0	; 03800FFA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03800FEE:
	.halfword (P2_Case_03801012 + 1) - (P2_SwitchTargetPC_03800FEE + 4)
	.halfword (P2_Case_03801006 + 1) - (P2_SwitchTargetPC_03800FEE + 4)
	.halfword (P2_Case_0380100A + 1) - (P2_SwitchTargetPC_03800FEE + 4)
	.halfword (P2_Case_0380100E + 1) - (P2_SwitchTargetPC_03800FEE + 4)
	.halfword (P2_Case_03801006 + 1) - (P2_SwitchTargetPC_03800FEE + 4)
P2_SwitchTable_03800FEEEnd:
P2_Case_03801006:
	ldr r0,[pool_038010F0]	; 03801006
	b P2_Entry_03801014	; 03801008
P2_Case_0380100A:
	ldr r0,[pool_038010F4]	; 0380100A
	b P2_Entry_03801014	; 0380100C
P2_Case_0380100E:
	ldr r0,[pool_038010F8]	; 0380100E
	b P2_Entry_03801014	; 03801010
P2_Case_03801012:
	b P2_Entry_038010E6	; 03801012
P2_Entry_03801014:
	ldrh r1,[r4,#0x1e]	; 03801014
	and r0,r1	; 03801016
	str r4,[sp,#0x0]	; 03801018
	ldrb r2,[r6,#0x4]	; 0380101A
	ldrb r1,[r4,#0x12]	; 0380101C
	add r1,r2,r1	; 0380101E
	ldrb r2,[r4,#0x0]	; 03801020
	lsl r2,r2,#0x18	; 03801022
	lsr r2,r2,#0x1f	; 03801024
	ldr r3,[pool_038010FC]	; 03801026
	bl P2_Entry_0380039C	; 03801028
	add r5,r0,#0x0	; 0380102C
	cmp r5,#0x0	; 0380102E
	beq P2_Entry_038010E6	; 03801030
	ldrb r0,[r4,#0x0]	; 03801032
	lsl r0,r0,#0x1c	; 03801034
	lsr r0,r0,#0x1f	; 03801036
	cmp r0,#0x0	; 03801038
	beq P2_Entry_03801040	; 0380103A
	mov r3,#0x0	; 0380103C
	b P2_Entry_03801042	; 0380103E
P2_Entry_03801040:
	ldr r3,[sp,#0xc]	; 03801040
P2_Entry_03801042:
	ldr r0,[r6,#0x20]	; 03801042
	str r0,[sp,#0x0]	; 03801044
	add r0,sp,#0x10	; 03801046
	str r0,[sp,#0x4]	; 03801048
	add r0,r5,#0x0	; 0380104A
	add r1,r7,#0x0	; 0380104C
	ldr r2,[sp,#0x8]	; 0380104E
	bl P2_Entry_038019B0	; 03801050
	cmp r0,#0x0	; 03801054
	bne P2_Entry_03801068	; 03801056
	mov r1,#0x0	; 03801058
	add r0,r5,#0x0	; 0380105A
	add r0,#0x22	; 0380105C
	strb r1,[r0,#0x0]	; 0380105E
	add r0,r5,#0x0	; 03801060
	bl loc_03800390	; 03801062
	b P2_Entry_038010E6	; 03801066
P2_Entry_03801068:
	ldr r0,[r4,#0x3c]	; 03801068
	str r0,[r5,#0x50]	; 0380106A
	str r5,[r4,#0x3c]	; 0380106C
P2_Entry_0380106E:
	ldrb r1,[r4,#0xe]	; 0380106E
	cmp r1,#0xff	; 03801070
	beq P2_Entry_0380107A	; 03801072
	add r0,r5,#0x0	; 03801074
	bl loc_0380049C	; 03801076
P2_Entry_0380107A:
	ldrb r1,[r4,#0xf]	; 0380107A
	cmp r1,#0xff	; 0380107C
	beq P2_Entry_03801086	; 0380107E
	add r0,r5,#0x0	; 03801080
	bl loc_03800488	; 03801082
P2_Entry_03801086:
	ldrb r1,[r4,#0x10]	; 03801086
	cmp r1,#0xff	; 03801088
	beq P2_Entry_03801092	; 0380108A
	add r0,r5,#0x0	; 0380108C
	bl loc_03800484	; 0380108E
P2_Entry_03801092:
	ldrb r1,[r4,#0x11]	; 03801092
	cmp r1,#0xff	; 03801094
	beq P2_Entry_0380109E	; 03801096
	add r0,r5,#0x0	; 03801098
	bl loc_03800470	; 0380109A
P2_Entry_0380109E:
	mov r0,#0x16	; 0380109E
	ldrsh r0,[r4,r0]	; 038010A0
	strh r0,[r5,#0x32]	; 038010A2
	ldrb r0,[r4,#0x0]	; 038010A4
	lsl r0,r0,#0x1a	; 038010A6
	lsr r0,r0,#0x1f	; 038010A8
	cmp r0,#0x0	; 038010AA
	beq P2_Entry_038010C2	; 038010AC
	add r1,r5,#0x0	; 038010AE
	add r1,#0x32	; 038010B0
	mov r0,#0x0	; 038010B2
	ldrsh r0,[r1,r0]	; 038010B4
	ldrb r2,[r4,#0x14]	; 038010B6
	sub r2,r2,r7	; 038010B8
	lsl r2,r2,#0x16	; 038010BA
	asr r2,r2,#0x10	; 038010BC
	add r0,r0,r2	; 038010BE
	strh r0,[r1,#0x0]	; 038010C0
P2_Entry_038010C2:
	ldrb r0,[r4,#0x15]	; 038010C2
	cmp r0,#0x0	; 038010C4
	bne P2_Entry_038010CE	; 038010C6
	ldr r0,[sp,#0xc]	; 038010C8
	str r0,[r5,#0x18]	; 038010CA
	b P2_Entry_038010E2	; 038010CC
P2_Entry_038010CE:
	add r1,r0,#0x0	; 038010CE
	mul r1,r0	; 038010D0
	mov r0,#0x32	; 038010D2
	ldrsh r0,[r5,r0]	; 038010D4
	cmp r0,#0x0	; 038010D6
	bge P2_Entry_038010DC	; 038010D8
	neg r0,r0	; 038010DA
P2_Entry_038010DC:
	mul r1,r0	; 038010DC
	asr r0,r1,#0xb	; 038010DE
	str r0,[r5,#0x18]	; 038010E0
P2_Entry_038010E2:
	mov r0,#0x0	; 038010E2
	str r0,[r5,#0x14]	; 038010E4
P2_Entry_038010E6:
	add sp,#0x1c	; 038010E6
	pop {r4,r5,r6,r7}	; 038010E8
	pop {r3}	; 038010EA
	bx r3	; 038010EC
	.byte 0xC0, 0x46	; 038010EE
pool_038010F0:
	.word 0x0000FFFF	; 038010F0
pool_038010F4:
	.word 0x00003F00	; 038010F4
pool_038010F8:
	.word 0x0000C000	; 038010F8
pool_038010FC:
	.word 0x038011A9	; 038010FC
P2_Entry_03801100:
	push {r4,r5,lr}	; 03801100
	sub sp,#0x4	; 03801102
	add r5,r0,#0x0	; 03801104
	mov r4,#0x0	; 03801106
P2_Entry_03801108:
	add r0,r5,#0x0	; 03801108
	add r1,r4,#0x0	; 0380110A
	bl loc_03801260	; 0380110C
	cmp r0,#0x0	; 03801110
	beq P2_Entry_0380111A	; 03801112
	add r1,r5,#0x0	; 03801114
	bl loc_03801128	; 03801116
P2_Entry_0380111A:
	add r4,r4,#0x1	; 0380111A
	cmp r4,#0x10	; 0380111C
	blt P2_Entry_03801108	; 0380111E
	add sp,#0x4	; 03801120
	pop {r4,r5}	; 03801122
	pop {r3}	; 03801124
	bx r3	; 03801126

; ===== function loc_03801128 =====
loc_03801128:
	push {r4,r5,r6,r7,lr}	; 03801128
	sub sp,#0x4	; 0380112A
	add r2,r0,#0x0	; 0380112C
	ldr r0,[r2,#0x3c]	; 0380112E
	mov r3,#0x6	; 03801130
	ldrsh r6,[r1,r3]	; 03801132
	mov r3,#0xa	; 03801134
	ldrsh r5,[r2,r3]	; 03801136
	ldrb r1,[r1,#0x5]	; 03801138
	lsl r1,r1,#0x1	; 0380113A
	ldr r4,[pool_038011A4]	; 0380113C
	ldrsh r3,[r4,r1]	; 0380113E
	ldrb r1,[r2,#0x4]	; 03801140
	lsl r1,r1,#0x1	; 03801142
	ldrsh r1,[r4,r1]	; 03801144
	ldrb r7,[r2,#0x5]	; 03801146
	lsl r7,r7,#0x1	; 03801148
	ldrsh r4,[r4,r7]	; 0380114A
	add r1,r1,r4	; 0380114C
	add r1,r3,r1	; 0380114E
	add r1,r5,r1	; 03801150
	add r4,r6,r1	; 03801152
	mov r1,#0x8	; 03801154
	ldrsb r3,[r2,r1]	; 03801156
	mov r1,#0x9	; 03801158
	ldrsb r1,[r2,r1]	; 0380115A
	add r3,r3,r1	; 0380115C
	mov r1,#0x6	; 0380115E
	ldrsb r5,[r2,r1]	; 03801160
	ldrb r1,[r2,#0x7]	; 03801162
	lsl r1,r1,#0x6	; 03801164
	mul r5,r1	; 03801166
	asr r5,r5,#0x7	; 03801168
	mov r1,#0xc	; 0380116A
	ldrsh r1,[r2,r1]	; 0380116C
	add r1,r5,r1	; 0380116E
	mov r5,#0x7f	; 03801170
	mvn r6,r5	; 03801172
	cmp r3,r6	; 03801174
	bge loc_0380117C	; 03801176
	add r3,r6,#0x0	; 03801178
	b loc_03801198	; 0380117A
loc_0380117C:
	cmp r3,#0x7f	; 0380117C
	ble loc_03801198	; 0380117E
	add r3,r5,#0x0	; 03801180
	b loc_03801198	; 03801182
loc_03801184:
	strh r4,[r0,#0xc]	; 03801184
	strh r1,[r0,#0xe]	; 03801186
	strb r3,[r0,#0xb]	; 03801188
	ldrh r5,[r2,#0x18]	; 0380118A
	strh r5,[r0,#0x28]	; 0380118C
	ldrh r5,[r2,#0x1a]	; 0380118E
	strh r5,[r0,#0x2a]	; 03801190
	ldrh r5,[r2,#0x1c]	; 03801192
	strh r5,[r0,#0x2c]	; 03801194
	ldr r0,[r0,#0x50]	; 03801196
loc_03801198:
	cmp r0,#0x0	; 03801198
	bne loc_03801184	; 0380119A
	add sp,#0x4	; 0380119C
	pop {r4,r5,r6,r7}	; 0380119E
	pop {r3}	; 038011A0
	bx r3	; 038011A2
pool_038011A4:
loc_038011A4:
	.word P2_Data_03805504	; 038011A4
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x14, 0x1C, 0x01, 0x29, 0x06, 0xD1, 0x01, 0x22, 0x29, 0x1C	; 038011B8
	.byte 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xE8, 0xF8, 0x07, 0xE0, 0x02, 0x29, 0x05, 0xD1, 0x00, 0x22	; 038011C8
	.byte 0x29, 0x1C, 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xDF, 0xF8, 0xE1, 0x6B, 0xA9, 0x42, 0x08, 0xD1	; 038011D8
	.byte 0x28, 0x6D, 0xE0, 0x63, 0x08, 0xE0, 0xA8, 0x42, 0x02, 0xD1, 0x28, 0x6D, 0x08, 0x65, 0x03, 0xE0	; 038011E8
	.byte 0x01, 0x1C, 0x08, 0x6D, 0x00, 0x28, 0xF6, 0xD1, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 038011F8

; ===== function loc_038011F8 =====
loc_038011F8:
	push {r4,r5,lr}	; 038011F8
	sub sp,#0x4	; 038011FA
	add r4,r0,#0x0	; 038011FC
	mov r5,#0x0	; 038011FE
loc_03801200:
	add r0,r4,#0x0	; 03801200
	add r1,r5,#0x0	; 03801202
	bl loc_0380121C	; 03801204
	add r5,r5,#0x1	; 03801208
	cmp r5,#0x10	; 0380120A
	blt loc_03801200	; 0380120C
	mov r0,#0x0	; 0380120E
	strb r0,[r4,#0x0]	; 03801210
	add sp,#0x4	; 03801212
	pop {r4,r5}	; 03801214
	pop {r3}	; 03801216
	bx r3	; 03801218
	.byte 0x00, 0x00	; 0380121C

; ===== function loc_0380121C =====
loc_0380121C:
	push {r4,r5,lr}	; 0380121C
	sub sp,#0x4	; 0380121E
	add r5,r0,#0x0	; 03801220
	add r4,r1,#0x0	; 03801222
	bl loc_03801260	; 03801224
	cmp r0,#0x0	; 03801228
	beq loc_03801246	; 0380122A
	add r1,r5,#0x0	; 0380122C
	bl loc_03801254	; 0380122E
	add r5,#0x8	; 03801232
	ldr r3,[pool_03801250]	; 03801234
	ldrb r0,[r5,r4]	; 03801236
	lsl r2,r0,#0x6	; 03801238
	ldrb r1,[r3,r2]	; 0380123A
	mov r0,#0x1	; 0380123C
	bic r1,r0	; 0380123E
	strb r1,[r3,r2]	; 03801240
	mov r0,#0xff	; 03801242
	strb r0,[r5,r4]	; 03801244
loc_03801246:
	add sp,#0x4	; 03801246
	pop {r4,r5}	; 03801248
	pop {r3}	; 0380124A
	bx r3	; 0380124C
	.byte 0xC0, 0x46	; 03801250
pool_03801250:
loc_03801250:
	.word P2_BssStart + 0x1504	; 03801250

; ===== function loc_03801254 =====
loc_03801254:
	mov r2,#0x0	; 03801254
	mvn r2,r2	; 03801256
	ldr r3,[pool_0380125C]	; 03801258
	bx r3	; 0380125A
pool_0380125C:
loc_0380125C:
	.word loc_038012E8 + 1	; 0380125C

; ===== function loc_03801260 =====
loc_03801260:
	cmp r1,#0xf	; 03801260
	ble loc_03801268	; 03801262
	mov r0,#0x0	; 03801264
	bx lr	; 03801266
loc_03801268:
	add r0,r0,r1	; 03801268
	ldrb r0,[r0,#0x8]	; 0380126A
	cmp r0,#0xff	; 0380126C
	bne loc_03801274	; 0380126E
	mov r0,#0x0	; 03801270
	bx lr	; 03801272
loc_03801274:
	ldr r1,[pool_0380127C]	; 03801274
	lsl r0,r0,#0x6	; 03801276
	add r0,r1,r0	; 03801278
	bx lr	; 0380127A
pool_0380127C:
loc_0380127C:
	.word 0x03806C80	; 0380127C
P2_Entry_03801280:
	push {r4,r5,lr}	; 03801280
	sub sp,#0x4	; 03801282
	add r5,r0,#0x0	; 03801284
	mov r4,#0x0	; 03801286
	add r1,r5,#0x0	; 03801288
	add r1,#0x1c	; 0380128A
	b P2_Entry_03801296	; 0380128C
P2_Entry_0380128E:
	ldrh r0,[r1,#0x0]	; 0380128E
	sub r0,#0xf0	; 03801290
	strh r0,[r1,#0x0]	; 03801292
	add r4,r4,#0x1	; 03801294
P2_Entry_03801296:
	ldrh r0,[r5,#0x1c]	; 03801296
	cmp r0,#0xf0	; 03801298
	bcs P2_Entry_0380128E	; 0380129A
	ldr r0,[pool_038012E4]	; 0380129C
	ldr r2,[r0,#0x0]	; 0380129E
	cmp r2,#0x0	; 038012A0
	beq P2_Entry_038012C8	; 038012A2
	add r2,#0x40	; 038012A4
	ldrb r1,[r5,#0x2]	; 038012A6
	mov r0,#0x24	; 038012A8
	mul r1,r0	; 038012AA
	ldr r0,[r2,r1]	; 038012AC
	add r0,r0,r4	; 038012AE
	str r0,[r2,r1]	; 038012B0
	b P2_Entry_038012C8	; 038012B2
P2_Entry_038012B4:
	add r0,r5,#0x0	; 038012B4
	bl P2_Entry_0380091C	; 038012B6
	cmp r0,#0x0	; 038012BA
	beq P2_Entry_038012C6	; 038012BC
	add r0,r5,#0x0	; 038012BE
	bl loc_038011F8	; 038012C0
	b P2_Entry_038012CC	; 038012C4
P2_Entry_038012C6:
	sub r4,r4,#0x1	; 038012C6
P2_Entry_038012C8:
	cmp r4,#0x0	; 038012C8
	bgt P2_Entry_038012B4	; 038012CA
P2_Entry_038012CC:
	ldrh r2,[r5,#0x18]	; 038012CC
	ldrh r0,[r5,#0x1a]	; 038012CE
	mul r2,r0	; 038012D0
	add r5,#0x1c	; 038012D2
	ldrh r1,[r5,#0x0]	; 038012D4
	asr r0,r2,#0x8	; 038012D6
	add r0,r1,r0	; 038012D8
	strh r0,[r5,#0x0]	; 038012DA
	add sp,#0x4	; 038012DC
	pop {r4,r5}	; 038012DE
	pop {r3}	; 038012E0
	bx r3	; 038012E2
pool_038012E4:
	.word P2_BssStart + 0xD80	; 038012E4

; ===== function loc_038012E8 =====
loc_038012E8:
	push {r4,r5,r6,r7,lr}	; 038012E8
	sub sp,#0x4	; 038012EA
	add r5,r0,#0x0	; 038012EC
	add r6,r2,#0x0	; 038012EE
	ldr r4,[r5,#0x3c]	; 038012F0
	bl loc_03801128	; 038012F2
	lsl r0,r6,#0x18	; 038012F6
	lsr r7,r0,#0x18	; 038012F8
	b loc_03801328	; 038012FA
loc_038012FC:
	add r0,r4,#0x0	; 038012FC
	bl loc_03800460	; 038012FE
	cmp r0,#0x0	; 03801302
	beq loc_03801320	; 03801304
	cmp r6,#0x0	; 03801306
	blt loc_03801312	; 03801308
	add r0,r4,#0x0	; 0380130A
	add r1,r7,#0x0	; 0380130C
	bl loc_03800470	; 0380130E
loc_03801312:
	add r1,r4,#0x0	; 03801312
	add r1,#0x22	; 03801314
	mov r0,#0x1	; 03801316
	strb r0,[r1,#0x0]	; 03801318
	add r0,r4,#0x0	; 0380131A
	bl loc_03800468	; 0380131C
loc_03801320:
	add r0,r4,#0x0	; 03801320
	bl loc_03800390	; 03801322
	ldr r4,[r4,#0x50]	; 03801326
loc_03801328:
	cmp r4,#0x0	; 03801328
	bne loc_038012FC	; 0380132A
	mov r0,#0x0	; 0380132C
	str r0,[r5,#0x3c]	; 0380132E
	add sp,#0x4	; 03801330
	pop {r4,r5,r6,r7}	; 03801332
	pop {r3}	; 03801334
	bx r3	; 03801336

; ===== function loc_03801338 =====
loc_03801338:
	push {r4,r5,r6,r7,lr}	; 03801338
	sub sp,#0x4	; 0380133A
	mov r2,#0x0	; 0380133C
	strb r2,[r0,#0x1]	; 0380133E
	str r1,[r0,#0x20]	; 03801340
	mov r1,#0x78	; 03801342
	strh r1,[r0,#0x18]	; 03801344
	ldr r1,[pool_03801394]	; 03801346
	strh r1,[r0,#0x1a]	; 03801348
	strh r2,[r0,#0x1c]	; 0380134A
	mov r1,#0x7f	; 0380134C
	strb r1,[r0,#0x5]	; 0380134E
	strh r2,[r0,#0x6]	; 03801350
	mov r1,#0x40	; 03801352
	strb r1,[r0,#0x4]	; 03801354
	mov r3,#0xff	; 03801356
loc_03801358:
	add r1,r0,r2	; 03801358
	strb r3,[r1,#0x8]	; 0380135A
	add r2,r2,#0x1	; 0380135C
	cmp r2,#0x10	; 0380135E
	blt loc_03801358	; 03801360
	ldr r4,[pool_03801398]	; 03801362
	ldr r5,[r4,#0x0]	; 03801364
	cmp r5,#0x0	; 03801366
	beq loc_0380138C	; 03801368
	mov r2,#0x0	; 0380136A
	ldrb r1,[r0,#0x2]	; 0380136C
	mov r3,#0x24	; 0380136E
	mul r1,r3	; 03801370
	add r1,r5,r1	; 03801372
	str r2,[r1,#0x40]	; 03801374
	mvn r1,r2	; 03801376
loc_03801378:
	ldr r7,[r4,#0x0]	; 03801378
	ldrb r5,[r0,#0x2]	; 0380137A
	mul r5,r3	; 0380137C
	lsl r6,r2,#0x1	; 0380137E
	add r5,r7,r5	; 03801380
	add r5,r6,r5	; 03801382
	strh r1,[r5,#0x20]	; 03801384
	add r2,r2,#0x1	; 03801386
	cmp r2,#0x10	; 03801388
	blt loc_03801378	; 0380138A
loc_0380138C:
	add sp,#0x4	; 0380138C
	pop {r4,r5,r6,r7}	; 0380138E
	pop {r3}	; 03801390
	bx r3	; 03801392
pool_03801394:
loc_03801394:
	.word 0x00000100	; 03801394
pool_03801398:
loc_03801398:
	.word P2_BssStart + 0xD80	; 03801398

; ===== function loc_0380139C =====
loc_0380139C:
	str r1,[r0,#0x24]	; 0380139C
	ldr r1,[r0,#0x24]	; 0380139E
	add r1,r1,r2	; 038013A0
	str r1,[r0,#0x28]	; 038013A2
	bx lr	; 038013A4
	.byte 0x00, 0x00	; 038013A8

; ===== function loc_038013A8 =====
loc_038013A8:
	push {r4,r5,lr}	; 038013A8
	sub sp,#0x4	; 038013AA
	add r4,r0,#0x0	; 038013AC
	mov r1,#0x0	; 038013AE
	str r1,[r4,#0x24]	; 038013B0
	str r1,[r4,#0x28]	; 038013B2
	ldrb r2,[r4,#0x0]	; 038013B4
	mov r0,#0x2	; 038013B6
	orr r2,r0	; 038013B8
	strb r2,[r4,#0x0]	; 038013BA
	ldrb r3,[r4,#0x0]	; 038013BC
	mov r2,#0x4	; 038013BE
	bic r3,r2	; 038013C0
	strb r3,[r4,#0x0]	; 038013C2
	ldrb r3,[r4,#0x0]	; 038013C4
	mov r2,#0x8	; 038013C6
	bic r3,r2	; 038013C8
	strb r3,[r4,#0x0]	; 038013CA
	ldrb r3,[r4,#0x0]	; 038013CC
	mov r2,#0x10	; 038013CE
	bic r3,r2	; 038013D0
	strb r3,[r4,#0x0]	; 038013D2
	ldrb r3,[r4,#0x0]	; 038013D4
	mov r2,#0x20	; 038013D6
	bic r3,r2	; 038013D8
	strb r3,[r4,#0x0]	; 038013DA
	ldrb r2,[r4,#0x0]	; 038013DC
	mov r3,#0x40	; 038013DE
	orr r2,r3	; 038013E0
	strb r2,[r4,#0x0]	; 038013E2
	ldrb r5,[r4,#0x0]	; 038013E4
	mov r2,#0x80	; 038013E6
	bic r5,r2	; 038013E8
	strb r5,[r4,#0x0]	; 038013EA
	add r2,r4,#0x0	; 038013EC
	add r2,#0x3b	; 038013EE
	strb r1,[r2,#0x0]	; 038013F0
	strh r1,[r4,#0x2]	; 038013F2
	strb r3,[r4,#0x12]	; 038013F4
	mov r2,#0x7f	; 038013F6
	strb r2,[r4,#0x4]	; 038013F8
	strb r2,[r4,#0x5]	; 038013FA
	strh r1,[r4,#0xa]	; 038013FC
	strb r1,[r4,#0x8]	; 038013FE
	strb r1,[r4,#0x9]	; 03801400
	strb r1,[r4,#0x6]	; 03801402
	strh r1,[r4,#0xc]	; 03801404
	mov r2,#0xff	; 03801406
	strb r2,[r4,#0xe]	; 03801408
	strb r2,[r4,#0xf]	; 0380140A
	strb r2,[r4,#0x10]	; 0380140C
	strb r2,[r4,#0x11]	; 0380140E
	strb r0,[r4,#0x7]	; 03801410
	mov r0,#0x3c	; 03801412
	strb r0,[r4,#0x14]	; 03801414
	strb r1,[r4,#0x15]	; 03801416
	strh r1,[r4,#0x16]	; 03801418
	strb r1,[r4,#0x13]	; 0380141A
	ldr r0,[pool_03801438]	; 0380141C
	strh r0,[r4,#0x1e]	; 0380141E
	add r0,r4,#0x0	; 03801420
	add r0,#0x18	; 03801422
	bl loc_038001D8	; 03801424
	mov r0,#0x0	; 03801428
	str r0,[r4,#0x20]	; 0380142A
	str r0,[r4,#0x3c]	; 0380142C
	add sp,#0x4	; 0380142E
	pop {r4,r5}	; 03801430
	pop {r3}	; 03801432
	bx r3	; 03801434
	.byte 0xC0, 0x46	; 03801438
pool_03801438:
loc_03801438:
	.word 0x0000FFFF	; 03801438

; ===== function loc_0380143C =====
P2_Entry_0380143C:
	push {r4,r5,r6,lr}	; 0380143C
	add r4,r0,#0x0	; 0380143E
	add r6,r1,#0x0	; 03801440
	cmp r2,#0x4	; 03801442
	bhi loc_038014AC	; 03801444
	add r1,r2,r2	; 03801446
P2_SwitchIndexPC_03801446:
	add r1,pc	; 03801448
	ldrh r1,[r1,#(P2_SwitchTable_03801446 - (P2_SwitchIndexPC_03801446 + 4))]	; 0380144A
	lsl r1,r1,#0x10	; 0380144C
	asr r1,r1,#0x10	; 0380144E
P2_SwitchTargetPC_03801446:
	add r1,pc	; 03801450
	bx r1	; 03801452
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801446:
	.halfword (loc_0380145E + 1) - (P2_SwitchTargetPC_03801446 + 4)
	.halfword (loc_03801466 + 1) - (P2_SwitchTargetPC_03801446 + 4)
	.halfword (loc_0380146E + 1) - (P2_SwitchTargetPC_03801446 + 4)
	.halfword (loc_0380148C + 1) - (P2_SwitchTargetPC_03801446 + 4)
	.halfword (loc_03801476 + 1) - (P2_SwitchTargetPC_03801446 + 4)
P2_SwitchTable_03801446End:
loc_0380145E:
	bl loc_03801568	; 0380145E
	add r5,r0,#0x0	; 03801462
	b loc_038014AC	; 03801464
loc_03801466:
	bl loc_03801530	; 03801466
	add r5,r0,#0x0	; 0380146A
	b loc_038014AC	; 0380146C
loc_0380146E:
	bl loc_038014B4	; 0380146E
	add r5,r0,#0x0	; 03801472
	b loc_038014AC	; 03801474
loc_03801476:
	bl loc_03801568	; 03801476
	add r1,r0,#0x0	; 0380147A
	add r0,r6,#0x0	; 0380147C
	bl loc_038008E8	; 0380147E
	cmp r0,#0x0	; 03801482
	beq loc_038014AC	; 03801484
	mov r1,#0x0	; 03801486
	ldrsh r5,[r0,r1]	; 03801488
	b loc_038014AC	; 0380148A
loc_0380148C:
	bl loc_03801530	; 0380148C
	lsl r0,r0,#0x10	; 03801490
	asr r5,r0,#0x10	; 03801492
	add r0,r4,#0x0	; 03801494
	bl loc_03801530	; 03801496
	lsl r0,r0,#0x10	; 0380149A
	asr r4,r0,#0x10	; 0380149C
	bl loc_037FFBA4	; 0380149E
	sub r1,r4,r5	; 038014A2
	add r1,r1,#0x1	; 038014A4
	mul r0,r1	; 038014A6
	asr r0,r0,#0x10	; 038014A8
	add r5,r0,r5	; 038014AA
loc_038014AC:
	add r0,r5,#0x0	; 038014AC
	pop {r4,r5,r6}	; 038014AE
	pop {r3}	; 038014B0
	bx r3	; 038014B2

; ===== function loc_038014B4 =====
loc_038014B4:
	push {r4,r5,r6,r7,lr}	; 038014B4
	sub sp,#0x4	; 038014B6
	add r6,r0,#0x0	; 038014B8
	mov r5,#0x0	; 038014BA
	add r4,r6,#0x0	; 038014BC
	add r4,#0x28	; 038014BE
	mov r7,#0x80	; 038014C0
loc_038014C2:
	ldr r0,[r6,#0x28]	; 038014C2
	bl loc_03801580	; 038014C4
	ldr r1,[r4,#0x0]	; 038014C8
	add r1,r1,#0x1	; 038014CA
	str r1,[r4,#0x0]	; 038014CC
	lsl r5,r5,#0x7	; 038014CE
	add r2,r0,#0x0	; 038014D0
	mov r1,#0x7f	; 038014D2
	and r2,r1	; 038014D4
	orr r5,r2	; 038014D6
	and r0,r7	; 038014D8
	cmp r0,#0x0	; 038014DA
	bne loc_038014C2	; 038014DC
	add r0,r5,#0x0	; 038014DE
	add sp,#0x4	; 038014E0
	pop {r4,r5,r6,r7}	; 038014E2
	pop {r3}	; 038014E4
	bx r3	; 038014E6
P2_Entry_038014E8:
	push {r4,r5,lr}	; 038014E8
	sub sp,#0x4	; 038014EA
	add r5,r0,#0x0	; 038014EC
	ldr r0,[r5,#0x28]	; 038014EE
	bl loc_03801580	; 038014F0
	add r4,r0,#0x0	; 038014F4
	add r1,r5,#0x0	; 038014F6
	add r1,#0x28	; 038014F8
	ldr r0,[r1,#0x0]	; 038014FA
	add r0,r0,#0x1	; 038014FC
	str r0,[r1,#0x0]	; 038014FE
	ldr r0,[r5,#0x28]	; 03801500
	bl loc_03801580	; 03801502
	lsl r0,r0,#0x8	; 03801506
	orr r4,r0	; 03801508
	add r1,r5,#0x0	; 0380150A
	add r1,#0x28	; 0380150C
	ldr r0,[r1,#0x0]	; 0380150E
	add r0,r0,#0x1	; 03801510
	str r0,[r1,#0x0]	; 03801512
	ldr r0,[r5,#0x28]	; 03801514
	bl loc_03801580	; 03801516
	lsl r0,r0,#0x10	; 0380151A
	orr r4,r0	; 0380151C
	add r5,#0x28	; 0380151E
	ldr r0,[r5,#0x0]	; 03801520
	add r0,r0,#0x1	; 03801522
	str r0,[r5,#0x0]	; 03801524
	add r0,r4,#0x0	; 03801526
	add sp,#0x4	; 03801528
	pop {r4,r5}	; 0380152A
	pop {r3}	; 0380152C
	bx r3	; 0380152E

; ===== function loc_03801530 =====
loc_03801530:
	push {r4,r5,lr}	; 03801530
	sub sp,#0x4	; 03801532
	add r5,r0,#0x0	; 03801534
	ldr r0,[r5,#0x28]	; 03801536
	bl loc_03801580	; 03801538
	add r4,r0,#0x0	; 0380153C
	add r1,r5,#0x0	; 0380153E
	add r1,#0x28	; 03801540
	ldr r0,[r1,#0x0]	; 03801542
	add r0,r0,#0x1	; 03801544
	str r0,[r1,#0x0]	; 03801546
	ldr r0,[r5,#0x28]	; 03801548
	bl loc_03801580	; 0380154A
	lsl r0,r0,#0x8	; 0380154E
	orr r4,r0	; 03801550
	lsl r0,r4,#0x10	; 03801552
	lsr r0,r0,#0x10	; 03801554
	add r5,#0x28	; 03801556
	ldr r1,[r5,#0x0]	; 03801558
	add r1,r1,#0x1	; 0380155A
	str r1,[r5,#0x0]	; 0380155C
	add sp,#0x4	; 0380155E
	pop {r4,r5}	; 03801560
	pop {r3}	; 03801562
	bx r3	; 03801564
	.byte 0x00, 0x00	; 03801568

; ===== function loc_03801568 =====
loc_03801568:
	push {r4,lr}	; 03801568
	add r4,r0,#0x0	; 0380156A
	ldr r0,[r4,#0x28]	; 0380156C
	bl loc_03801580	; 0380156E
	add r4,#0x28	; 03801572
	ldr r1,[r4,#0x0]	; 03801574
	add r1,r1,#0x1	; 03801576
	str r1,[r4,#0x0]	; 03801578
	pop {r4}	; 0380157A
	pop {r3}	; 0380157C
	bx r3	; 0380157E

; ===== function loc_03801580 =====
loc_03801580:
	push {r4,lr}	; 03801580
	add r4,r0,#0x0	; 03801582
	ldr r0,[pool_038015A8]	; 03801584
	ldr r1,[r0,#0x0]	; 03801586
	cmp r4,r1	; 03801588
	bcc loc_03801592	; 0380158A
	ldr r0,[r0,#0x4]	; 0380158C
	cmp r4,r0	; 0380158E
	bcc loc_03801598	; 03801590
loc_03801592:
	add r0,r4,#0x0	; 03801592
	bl loc_038015B0	; 03801594
loc_03801598:
	ldr r0,[pool_038015A8]	; 03801598
	ldr r0,[r0,#0x0]	; 0380159A
	sub r1,r4,r0	; 0380159C
	ldr r0,[pool_038015AC]	; 0380159E
	ldrb r0,[r0,r1]	; 038015A0
	pop {r4}	; 038015A2
	pop {r3}	; 038015A4
	bx r3	; 038015A6
pool_038015A8:
loc_038015A8:
	.word P2_BssStart + 0xD68	; 038015A8
pool_038015AC:
loc_038015AC:
	.word P2_BssStart + 0xD70	; 038015AC

; ===== function loc_038015B0 =====
loc_038015B0:
	mov r1,#0x3	; 038015B0
	bic r0,r1	; 038015B2
	ldr r1,[pool_038015D0]	; 038015B4
	str r0,[r1,#0x0]	; 038015B6
	add r2,r0,#0x0	; 038015B8
	add r2,#0x10	; 038015BA
	str r2,[r1,#0x4]	; 038015BC
	ldr r2,[r0,#0x0]	; 038015BE
	str r2,[r1,#0x8]	; 038015C0
	ldr r2,[r0,#0x4]	; 038015C2
	str r2,[r1,#0xc]	; 038015C4
	ldr r2,[r0,#0x8]	; 038015C6
	str r2,[r1,#0x10]	; 038015C8
	ldr r0,[r0,#0xc]	; 038015CA
	str r0,[r1,#0x14]	; 038015CC
	bx lr	; 038015CE
pool_038015D0:
loc_038015D0:
	.word P2_BssStart + 0xD68	; 038015D0

; ===== function loc_038015D4 =====
loc_038015D4:
	push {r4,r5,r6,r7,lr}	; 038015D4
	sub sp,#0x4	; 038015D6
	add r6,r1,#0x0	; 038015D8
	add r5,r3,#0x0	; 038015DA
	ldr r4,[sp,#0x18]	; 038015DC
	ldr r3,[pool_0380162C]	; 038015DE
	mov r1,#0x24	; 038015E0
	mul r0,r1	; 038015E2
	add r7,r3,r0	; 038015E4
	mov r3,#0x0	; 038015E6
	b loc_0380161C	; 038015E8
loc_038015EA:
	add r1,r6,#0x0	; 038015EA
	mov r0,#0x1	; 038015EC
	and r1,r0	; 038015EE
	cmp r1,#0x0	; 038015F0
	beq loc_03801618	; 038015F2
	add r0,r7,#0x0	; 038015F4
	add r1,r3,#0x0	; 038015F6
	bl loc_03801260	; 038015F8
	cmp r0,#0x0	; 038015FC
	beq loc_03801618	; 038015FE
	cmp r4,#0x1	; 03801600
	beq loc_0380160E	; 03801602
	cmp r4,#0x2	; 03801604
	beq loc_03801612	; 03801606
	cmp r4,#0x4	; 03801608
	beq loc_03801616	; 0380160A
	b loc_03801618	; 0380160C
loc_0380160E:
	strb r5,[r0,r2]	; 0380160E
	b loc_03801618	; 03801610
loc_03801612:
	strh r5,[r0,r2]	; 03801612
	b loc_03801618	; 03801614
loc_03801616:
	str r5,[r0,r2]	; 03801616
loc_03801618:
	add r3,r3,#0x1	; 03801618
	lsr r6,r6,#0x1	; 0380161A
loc_0380161C:
	cmp r3,#0x10	; 0380161C
	bge loc_03801624	; 0380161E
	cmp r6,#0x0	; 03801620
	bne loc_038015EA	; 03801622
loc_03801624:
	add sp,#0x4	; 03801624
	pop {r4,r5,r6,r7}	; 03801626
	pop {r3}	; 03801628
	bx r3	; 0380162A
pool_0380162C:
loc_0380162C:
	.word 0x03806A40	; 0380162C

; ===== function loc_03801630 =====
loc_03801630:
	push {r4,r5,lr}	; 03801630
	sub sp,#0x4	; 03801632
	ldr r5,[pool_0380165C]	; 03801634
	mov r4,#0x24	; 03801636
	mul r0,r4	; 03801638
	add r0,r5,r0	; 0380163A
	cmp r3,#0x1	; 0380163C
	beq loc_0380164A	; 0380163E
	cmp r3,#0x2	; 03801640
	beq loc_0380164E	; 03801642
	cmp r3,#0x4	; 03801644
	beq loc_03801652	; 03801646
	b loc_03801654	; 03801648
loc_0380164A:
	strb r2,[r0,r1]	; 0380164A
	b loc_03801654	; 0380164C
loc_0380164E:
	strh r2,[r0,r1]	; 0380164E
	b loc_03801654	; 03801650
loc_03801652:
	str r2,[r0,r1]	; 03801652
loc_03801654:
	add sp,#0x4	; 03801654
	pop {r4,r5}	; 03801656
	pop {r3}	; 03801658
	bx r3	; 0380165A
pool_0380165C:
loc_0380165C:
	.word 0x03806A40	; 0380165C

; ===== function loc_03801660 =====
loc_03801660:
	push {r4,r5,r6,r7,lr}	; 03801660
	sub sp,#0x4	; 03801662
	add r5,r0,#0x0	; 03801664
	add r6,r1,#0x0	; 03801666
	mov r4,#0x0	; 03801668
	ldr r7,[pool_03801698]	; 0380166A
loc_0380166C:
	add r1,r4,#0x0	; 0380166C
	mov r0,#0x24	; 0380166E
	mul r1,r0	; 03801670
	add r0,r7,r1	; 03801672
	ldrb r1,[r7,r1]	; 03801674
	cmp r1,#0x0	; 03801676
	beq loc_03801688	; 03801678
	ldr r1,[r0,#0x20]	; 0380167A
	cmp r5,r1	; 0380167C
	bhi loc_03801688	; 0380167E
	cmp r1,r6	; 03801680
	bhi loc_03801688	; 03801682
	bl loc_038011F8	; 03801684
loc_03801688:
	add r4,r4,#0x1	; 03801688
	cmp r4,#0x10	; 0380168A
	blt loc_0380166C	; 0380168C
	add sp,#0x4	; 0380168E
	pop {r4,r5,r6,r7}	; 03801690
	pop {r3}	; 03801692
	bx r3	; 03801694
	.byte 0xC0, 0x46	; 03801698
pool_03801698:
loc_03801698:
	.word P2_BssStart + 0x12C4	; 03801698

; ===== function loc_0380169C =====
loc_0380169C:
	push {r4,r5,r6,r7,lr}	; 0380169C
	sub sp,#0x4	; 0380169E
	add r5,r0,#0x0	; 038016A0
	add r6,r1,#0x0	; 038016A2
	mov r4,#0x0	; 038016A4
	add r7,r4,#0x0	; 038016A6
loc_038016A8:
	add r0,r4,#0x0	; 038016A8
	mov r1,#0x24	; 038016AA
	mul r0,r1	; 038016AC
	ldr r1,[pool_038016F0]	; 038016AE
	add r3,r1,r0	; 038016B0
	ldrb r0,[r1,r0]	; 038016B2
	cmp r0,#0x0	; 038016B4
	beq loc_038016E0	; 038016B6
	add r2,r7,#0x0	; 038016B8
	b loc_038016DC	; 038016BA
loc_038016BC:
	add r0,r3,#0x0	; 038016BC
	add r1,r2,#0x0	; 038016BE
	bl loc_03801260	; 038016C0
	cmp r0,#0x0	; 038016C4
	beq loc_038016DA	; 038016C6
	ldr r0,[r0,#0x28]	; 038016C8
	cmp r5,r0	; 038016CA
	bhi loc_038016DA	; 038016CC
	cmp r0,r6	; 038016CE
	bhi loc_038016DA	; 038016D0
	add r0,r3,#0x0	; 038016D2
	bl loc_038011F8	; 038016D4
	b loc_038016E0	; 038016D8
loc_038016DA:
	add r2,r2,#0x1	; 038016DA
loc_038016DC:
	cmp r2,#0x10	; 038016DC
	blt loc_038016BC	; 038016DE
loc_038016E0:
	add r4,r4,#0x1	; 038016E0
	cmp r4,#0x10	; 038016E2
	blt loc_038016A8	; 038016E4
	add sp,#0x4	; 038016E6
	pop {r4,r5,r6,r7}	; 038016E8
	pop {r3}	; 038016EA
	bx r3	; 038016EC
	.byte 0xC0, 0x46	; 038016F0
pool_038016F0:
loc_038016F0:
	.word P2_BssStart + 0x12C4	; 038016F0

; ===== function loc_038016F4 =====
loc_038016F4:
	push {r4,r5,r6,r7,lr}	; 038016F4
	sub sp,#0x4	; 038016F6
	add r5,r1,#0x0	; 038016F8
	ldr r3,[pool_03801740]	; 038016FA
	mov r1,#0x24	; 038016FC
	mul r0,r1	; 038016FE
	add r4,r3,r0	; 03801700
	mov r3,#0x0	; 03801702
	lsl r0,r2,#0x10	; 03801704
	lsr r2,r0,#0x10	; 03801706
	mov r7,#0x80	; 03801708
	mov r6,#0x1	; 0380170A
	b loc_03801730	; 0380170C
loc_0380170E:
	add r0,r5,#0x0	; 0380170E
	and r0,r6	; 03801710
	cmp r0,#0x0	; 03801712
	beq loc_0380172C	; 03801714
	add r0,r4,#0x0	; 03801716
	add r1,r3,#0x0	; 03801718
	bl loc_03801260	; 0380171A
	add r1,r0,#0x0	; 0380171E
	cmp r1,#0x0	; 03801720
	beq loc_0380172C	; 03801722
	strh r2,[r1,#0x1e]	; 03801724
	ldrb r0,[r1,#0x0]	; 03801726
	orr r0,r7	; 03801728
	strb r0,[r1,#0x0]	; 0380172A
loc_0380172C:
	add r3,r3,#0x1	; 0380172C
	lsr r5,r5,#0x1	; 0380172E
loc_03801730:
	cmp r3,#0x10	; 03801730
	bge loc_03801738	; 03801732
	cmp r5,#0x0	; 03801734
	bne loc_0380170E	; 03801736
loc_03801738:
	add sp,#0x4	; 03801738
	pop {r4,r5,r6,r7}	; 0380173A
	pop {r3}	; 0380173C
	bx r3	; 0380173E
pool_03801740:
loc_03801740:
	.word 0x03806A40	; 03801740

; ===== function loc_03801744 =====
loc_03801744:
	push {r4,r5,r6,r7,lr}	; 03801744
	sub sp,#0x4	; 03801746
	add r5,r1,#0x0	; 03801748
	add r6,r2,#0x0	; 0380174A
	ldr r2,[pool_038017A8]	; 0380174C
	mov r1,#0x24	; 0380174E
	mul r0,r1	; 03801750
	add r0,r2,r0	; 03801752
	str r0,[sp,#0x0]	; 03801754
	mov r4,#0x0	; 03801756
	b loc_03801796	; 03801758
loc_0380175A:
	add r1,r5,#0x0	; 0380175A
	mov r0,#0x1	; 0380175C
	and r1,r0	; 0380175E
	cmp r1,#0x0	; 03801760
	beq loc_03801792	; 03801762
	ldr r0,[sp,#0x0]	; 03801764
	add r1,r4,#0x0	; 03801766
	bl loc_03801260	; 03801768
	add r7,r0,#0x0	; 0380176C
	cmp r7,#0x0	; 0380176E
	beq loc_03801792	; 03801770
	cmp r6,#0x0	; 03801772
	beq loc_0380177E	; 03801774
	ldr r1,[sp,#0x0]	; 03801776
	mov r2,#0x7f	; 03801778
	bl loc_038012E8	; 0380177A
loc_0380177E:
	ldrb r0,[r7,#0x0]	; 0380177E
	mov r1,#0x4	; 03801780
	bic r0,r1	; 03801782
	lsl r1,r6,#0x18	; 03801784
	lsr r2,r1,#0x18	; 03801786
	mov r1,#0x1	; 03801788
	and r2,r1	; 0380178A
	lsl r1,r2,#0x2	; 0380178C
	orr r0,r1	; 0380178E
	strb r0,[r7,#0x0]	; 03801790
loc_03801792:
	add r4,r4,#0x1	; 03801792
	lsr r5,r5,#0x1	; 03801794
loc_03801796:
	cmp r4,#0x10	; 03801796
	bge loc_0380179E	; 03801798
	cmp r5,#0x0	; 0380179A
	bne loc_0380175A	; 0380179C
loc_0380179E:
	add sp,#0x4	; 0380179E
	pop {r4,r5,r6,r7}	; 038017A0
	pop {r3}	; 038017A2
	bx r3	; 038017A4
	.byte 0xC0, 0x46	; 038017A8
pool_038017A8:
loc_038017A8:
	.word 0x03806A40	; 038017A8

; ===== function loc_038017AC =====
loc_038017AC:
	push {r4,r5,r6,lr}	; 038017AC
	ldr r3,[pool_038017E0]	; 038017AE
	mov r2,#0x24	; 038017B0
	mul r0,r2	; 038017B2
	add r5,r3,r0	; 038017B4
	strb r1,[r5,#0x1]	; 038017B6
	cmp r1,#0x0	; 038017B8
	beq loc_038017DA	; 038017BA
	mov r4,#0x0	; 038017BC
	mov r6,#0x7f	; 038017BE
loc_038017C0:
	add r0,r5,#0x0	; 038017C0
	add r1,r4,#0x0	; 038017C2
	bl loc_03801260	; 038017C4
	cmp r0,#0x0	; 038017C8
	beq loc_038017D4	; 038017CA
	add r1,r5,#0x0	; 038017CC
	add r2,r6,#0x0	; 038017CE
	bl loc_038012E8	; 038017D0
loc_038017D4:
	add r4,r4,#0x1	; 038017D4
	cmp r4,#0x10	; 038017D6
	blt loc_038017C0	; 038017D8
loc_038017DA:
	pop {r4,r5,r6}	; 038017DA
	pop {r3}	; 038017DC
	bx r3	; 038017DE
pool_038017E0:
loc_038017E0:
	.word 0x03806A40	; 038017E0

; ===== function loc_038017E4 =====
loc_038017E4:
	push {r4,lr}	; 038017E4
	add r4,r0,#0x0	; 038017E6
	ldr r2,[pool_03801818]	; 038017E8
	mov r0,#0x24	; 038017EA
	add r1,r4,#0x0	; 038017EC
	mul r1,r0	; 038017EE
	add r0,r2,r1	; 038017F0
	ldrb r1,[r2,r1]	; 038017F2
	cmp r1,#0x0	; 038017F4
	beq loc_03801810	; 038017F6
	bl loc_038011F8	; 038017F8
	ldr r0,[pool_0380181C]	; 038017FC
	ldr r0,[r0,#0x0]	; 038017FE
	cmp r0,#0x0	; 03801800
	beq loc_03801810	; 03801802
	add r2,r0,#0x4	; 03801804
	ldr r1,[r2,#0x0]	; 03801806
	mov r0,#0x1	; 03801808
	lsl r0,r4	; 0380180A
	bic r1,r0	; 0380180C
	str r1,[r2,#0x0]	; 0380180E
loc_03801810:
	pop {r4}	; 03801810
	pop {r3}	; 03801812
	bx r3	; 03801814
	.byte 0xC0, 0x46	; 03801818
pool_03801818:
loc_03801818:
	.word P2_BssStart + 0x12C4	; 03801818
pool_0380181C:
loc_0380181C:
	.word P2_BssStart + 0xD80	; 0380181C

; ===== function loc_03801820 =====
loc_03801820:
	push {r4,r5,r6,r7,lr}	; 03801820
	sub sp,#0xc	; 03801822
	str r0,[sp,#0x0]	; 03801824
	add r7,r1,#0x0	; 03801826
	str r2,[sp,#0x4]	; 03801828
	add r4,r3,#0x0	; 0380182A
	ldr r2,[pool_038018E4]	; 0380182C
	mov r0,#0x24	; 0380182E
	ldr r1,[sp,#0x0]	; 03801830
	mul r1,r0	; 03801832
	add r5,r2,r1	; 03801834
	ldrb r0,[r2,r1]	; 03801836
	cmp r0,#0x0	; 03801838
	beq loc_03801842	; 0380183A
	add r0,r5,#0x0	; 0380183C
	bl loc_038011F8	; 0380183E
loc_03801842:
	add r0,r5,#0x0	; 03801842
	add r1,r4,#0x0	; 03801844
	bl loc_03801338	; 03801846
	bl loc_038008B4	; 0380184A
	add r6,r0,#0x0	; 0380184E
	cmp r6,#0x0	; 03801850
	blt loc_038018DA	; 03801852
	ldr r1,[pool_038018E8]	; 03801854
	lsl r0,r6,#0x6	; 03801856
	add r4,r1,r0	; 03801858
	add r0,r4,#0x0	; 0380185A
	bl loc_038013A8	; 0380185C
	add r0,r4,#0x0	; 03801860
	add r1,r7,#0x0	; 03801862
	ldr r2,[sp,#0x4]	; 03801864
	bl loc_0380139C	; 03801866
	strb r6,[r5,#0x8]	; 0380186A
	ldr r0,[r4,#0x28]	; 0380186C
	bl loc_038015B0	; 0380186E
	add r0,r4,#0x0	; 03801872
	bl loc_03801568	; 03801874
	cmp r0,#0xfe	; 03801878
	beq loc_03801886	; 0380187A
	add r4,#0x28	; 0380187C
	ldr r0,[r4,#0x0]	; 0380187E
	sub r0,r0,#0x1	; 03801880
	str r0,[r4,#0x0]	; 03801882
	b loc_038018C2	; 03801884
loc_03801886:
	add r0,r4,#0x0	; 03801886
	bl loc_03801530	; 03801888
	lsl r0,r0,#0xf	; 0380188C
	lsr r4,r0,#0x10	; 0380188E
	mov r6,#0x1	; 03801890
	str r6,[sp,#0x8]	; 03801892
	b loc_038018BE	; 03801894
loc_03801896:
	add r1,r4,#0x0	; 03801896
	ldr r0,[sp,#0x8]	; 03801898
	and r1,r0	; 0380189A
	cmp r1,#0x0	; 0380189C
	beq loc_038018B8	; 0380189E
	bl loc_038008B4	; 038018A0
	add r7,r0,#0x0	; 038018A4
	cmp r7,#0x0	; 038018A6
	blt loc_038018C2	; 038018A8
	lsl r1,r7,#0x6	; 038018AA
	ldr r0,[pool_038018E8]	; 038018AC
	add r0,r0,r1	; 038018AE
	bl loc_038013A8	; 038018B0
	add r0,r5,r6	; 038018B4
	strb r7,[r0,#0x8]	; 038018B6
loc_038018B8:
	add r6,r6,#0x1	; 038018B8
	lsl r0,r4,#0xf	; 038018BA
	lsr r4,r0,#0x10	; 038018BC
loc_038018BE:
	cmp r4,#0x0	; 038018BE
	bne loc_03801896	; 038018C0
loc_038018C2:
	mov r3,#0x1	; 038018C2
	strb r3,[r5,#0x0]	; 038018C4
	ldr r0,[pool_038018EC]	; 038018C6
	ldr r0,[r0,#0x0]	; 038018C8
	cmp r0,#0x0	; 038018CA
	beq loc_038018DA	; 038018CC
	add r2,r0,#0x4	; 038018CE
	ldr r1,[r2,#0x0]	; 038018D0
	ldr r0,[sp,#0x0]	; 038018D2
	lsl r3,r0	; 038018D4
	orr r1,r3	; 038018D6
	str r1,[r2,#0x0]	; 038018D8
loc_038018DA:
	add sp,#0xc	; 038018DA
	pop {r4,r5,r6,r7}	; 038018DC
	pop {r3}	; 038018DE
	bx r3	; 038018E0
	.byte 0xC0, 0x46	; 038018E4
pool_038018E4:
loc_038018E4:
	.word P2_BssStart + 0x12C4	; 038018E4
pool_038018E8:
loc_038018E8:
	.word 0x03806C80	; 038018E8
pool_038018EC:
loc_038018EC:
	.word P2_BssStart + 0xD80	; 038018EC
P2_Entry_038018F0:
	push {r4,r5,r6,r7,lr}	; 038018F0
	sub sp,#0x4	; 038018F2
	add r7,r0,#0x0	; 038018F4
	mov r6,#0x0	; 038018F6
	add r4,r6,#0x0	; 038018F8
P2_Entry_038018FA:
	add r0,r4,#0x0	; 038018FA
	mov r1,#0x24	; 038018FC
	mul r0,r1	; 038018FE
	ldr r1,[pool_03801944]	; 03801900
	add r5,r1,r0	; 03801902
	ldrb r0,[r1,r0]	; 03801904
	cmp r0,#0x0	; 03801906
	beq P2_Entry_0380192C	; 03801908
	cmp r7,#0x0	; 0380190A
	beq P2_Entry_0380191A	; 0380190C
	ldrb r0,[r5,#0x1]	; 0380190E
	cmp r0,#0x0	; 03801910
	bne P2_Entry_0380191A	; 03801912
	add r0,r5,#0x0	; 03801914
	bl P2_Entry_03801280	; 03801916
P2_Entry_0380191A:
	add r0,r5,#0x0	; 0380191A
	bl P2_Entry_03801100	; 0380191C
	ldrb r0,[r5,#0x0]	; 03801920
	cmp r0,#0x0	; 03801922
	beq P2_Entry_0380192C	; 03801924
	mov r0,#0x1	; 03801926
	lsl r0,r4	; 03801928
	orr r6,r0	; 0380192A
P2_Entry_0380192C:
	add r4,r4,#0x1	; 0380192C
	cmp r4,#0x10	; 0380192E
	blt P2_Entry_038018FA	; 03801930
	ldr r0,[pool_03801948]	; 03801932
	ldr r0,[r0,#0x0]	; 03801934
	cmp r0,#0x0	; 03801936
	beq P2_Entry_0380193C	; 03801938
	str r6,[r0,#0x4]	; 0380193A
P2_Entry_0380193C:
	add sp,#0x4	; 0380193C
	pop {r4,r5,r6,r7}	; 0380193E
	pop {r3}	; 03801940
	bx r3	; 03801942
pool_03801944:
	.word P2_BssStart + 0x12C4	; 03801944
pool_03801948:
	.word P2_BssStart + 0xD80	; 03801948
P2_Entry_0380194C:
	push {r4,r5,lr}	; 0380194C
	sub sp,#0x4	; 0380194E
	mov r5,#0x0	; 03801950
	ldr r3,[pool_03801984]	; 03801952
	add r0,r5,#0x0	; 03801954
	mov r1,#0x24	; 03801956
P2_Entry_03801958:
	add r2,r5,#0x0	; 03801958
	mul r2,r1	; 0380195A
	add r4,r3,r2	; 0380195C
	strb r0,[r3,r2]	; 0380195E
	strb r5,[r4,#0x2]	; 03801960
	add r5,r5,#0x1	; 03801962
	cmp r5,#0x10	; 03801964
	blt P2_Entry_03801958	; 03801966
	ldr r4,[pool_03801988]	; 03801968
	mov r1,#0x1	; 0380196A
P2_Entry_0380196C:
	lsl r3,r0,#0x6	; 0380196C
	ldrb r2,[r4,r3]	; 0380196E
	bic r2,r1	; 03801970
	strb r2,[r4,r3]	; 03801972
	add r0,r0,#0x1	; 03801974
	cmp r0,#0x20	; 03801976
	blt P2_Entry_0380196C	; 03801978
	add sp,#0x4	; 0380197A
	pop {r4,r5}	; 0380197C
	pop {r3}	; 0380197E
	bx r3	; 03801980
	.byte 0xC0, 0x46	; 03801982
pool_03801984:
	.word P2_BssStart + 0x12C4	; 03801984
pool_03801988:
	.word P2_BssStart + 0x1504	; 03801988

; ===== function loc_0380198C =====
loc_0380198C:
	lsl r1,r1,#0x3	; 0380198C
	add r0,r0,r1	; 0380198E
	ldr r1,[r0,#0x18]	; 03801990
	cmp r1,#0x0	; 03801992
	bne loc_0380199A	; 03801994
	mov r0,#0x0	; 03801996
	bx lr	; 03801998
loc_0380199A:
	ldr r0,[r1,#0x38]	; 0380199A
	cmp r2,r0	; 0380199C
	bcc loc_038019A4	; 0380199E
	mov r0,#0x0	; 038019A0
	bx lr	; 038019A2
loc_038019A4:
	lsl r0,r2,#0x2	; 038019A4
	add r0,r1,r0	; 038019A6
	ldr r0,[r0,#0x3c]	; 038019A8
	add r0,r1,r0	; 038019AA
	bx lr	; 038019AC
	.byte 0x00, 0x00	; 038019B0

; ===== function loc_038019B0 =====
P2_Entry_038019B0:
	push {r4,r5,r6,r7,lr}	; 038019B0
	sub sp,#0x4	; 038019B2
	add r5,r0,#0x0	; 038019B4
	add r7,r1,#0x0	; 038019B6
	str r2,[sp,#0x0]	; 038019B8
	add r6,r3,#0x0	; 038019BA
	ldr r4,[sp,#0x1c]	; 038019BC
	ldrb r1,[r4,#0x0]	; 038019BE
	cmp r1,#0x4	; 038019C0
	bhi loc_03801A1E	; 038019C2
	add r2,r1,r1	; 038019C4
P2_SwitchIndexPC_038019C4:
	add r2,pc	; 038019C6
	ldrh r2,[r2,#(P2_SwitchTable_038019C4 - (P2_SwitchIndexPC_038019C4 + 4))]	; 038019C8
	lsl r2,r2,#0x10	; 038019CA
	asr r2,r2,#0x10	; 038019CC
P2_SwitchTargetPC_038019C4:
	add r2,pc	; 038019CE
	bx r2	; 038019D0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038019C4:
	.halfword (loc_03801A1E + 1) - (P2_SwitchTargetPC_038019C4 + 4)
	.halfword (loc_038019DC + 1) - (P2_SwitchTargetPC_038019C4 + 4)
	.halfword (loc_03801A0C + 1) - (P2_SwitchTargetPC_038019C4 + 4)
	.halfword (loc_03801A16 + 1) - (P2_SwitchTargetPC_038019C4 + 4)
	.halfword (loc_038019DC + 1) - (P2_SwitchTargetPC_038019C4 + 4)
P2_SwitchTable_038019C4End:
loc_038019DC:
	cmp r1,#0x1	; 038019DC
	bne loc_038019EE	; 038019DE
	ldr r0,[sp,#0x18]	; 038019E0
	ldrh r1,[r4,#0x4]	; 038019E2
	ldrh r2,[r4,#0x2]	; 038019E4
	bl loc_0380198C	; 038019E6
	add r2,r0,#0x0	; 038019EA
	b loc_038019F6	; 038019EC
loc_038019EE:
	ldrh r0,[r4,#0x4]	; 038019EE
	lsl r2,r0,#0x10	; 038019F0
	ldrh r0,[r4,#0x2]	; 038019F2
	orr r2,r0	; 038019F4
loc_038019F6:
	cmp r2,#0x0	; 038019F6
	beq loc_03801A08	; 038019F8
	add r0,r5,#0x0	; 038019FA
	add r1,r2,#0x0	; 038019FC
	add r2,#0xc	; 038019FE
	add r3,r6,#0x0	; 03801A00
	bl loc_0380051C	; 03801A02
	b loc_03801A20	; 03801A06
loc_03801A08:
	mov r0,#0x0	; 03801A08
	b loc_03801A20	; 03801A0A
loc_03801A0C:
	ldrh r1,[r4,#0x2]	; 03801A0C
	add r2,r6,#0x0	; 03801A0E
	bl loc_038004E8	; 03801A10
	b loc_03801A20	; 03801A14
loc_03801A16:
	add r1,r6,#0x0	; 03801A16
	bl loc_038004B8	; 03801A18
	b loc_03801A20	; 03801A1C
loc_03801A1E:
	mov r0,#0x0	; 03801A1E
loc_03801A20:
	cmp r0,#0x0	; 03801A20
	bne loc_03801A28	; 03801A22
	mov r0,#0x0	; 03801A24
	b loc_03801A5A	; 03801A26
loc_03801A28:
	strb r7,[r5,#0x8]	; 03801A28
	ldrb r0,[r4,#0x6]	; 03801A2A
	strb r0,[r5,#0x5]	; 03801A2C
	ldr r0,[sp,#0x0]	; 03801A2E
	strb r0,[r5,#0x9]	; 03801A30
	add r0,r5,#0x0	; 03801A32
	ldrb r1,[r4,#0x7]	; 03801A34
	bl loc_0380049C	; 03801A36
	add r0,r5,#0x0	; 03801A3A
	ldrb r1,[r4,#0x8]	; 03801A3C
	bl loc_03800488	; 03801A3E
	add r0,r5,#0x0	; 03801A42
	ldrb r1,[r4,#0x9]	; 03801A44
	bl loc_03800484	; 03801A46
	add r0,r5,#0x0	; 03801A4A
	ldrb r1,[r4,#0xa]	; 03801A4C
	bl loc_03800470	; 03801A4E
	ldrb r0,[r4,#0xb]	; 03801A52
	sub r0,#0x40	; 03801A54
	strb r0,[r5,#0xa]	; 03801A56
	mov r0,#0x1	; 03801A58
loc_03801A5A:
	add sp,#0x4	; 03801A5A
	pop {r4,r5,r6,r7}	; 03801A5C
	pop {r3}	; 03801A5E
	bx r3	; 03801A60
	.byte 0x00, 0x00	; 03801A62
P2_Entry_03801A64:
	push {r4,r5,lr}	; 03801A64
	sub sp,#0x4	; 03801A66
	add r4,r0,#0x0	; 03801A68
	add r0,r3,#0x0	; 03801A6A
	cmp r1,#0x0	; 03801A6C
	bge P2_Entry_03801A74	; 03801A6E
	mov r0,#0x0	; 03801A70
	b P2_Entry_03801B36	; 03801A72
P2_Entry_03801A74:
	ldr r3,[r4,#0x38]	; 03801A74
	cmp r1,r3	; 03801A76
	bcc P2_Entry_03801A7E	; 03801A78
	mov r0,#0x0	; 03801A7A
	b P2_Entry_03801B36	; 03801A7C
P2_Entry_03801A7E:
	lsl r1,r1,#0x2	; 03801A7E
	add r1,r4,r1	; 03801A80
	ldr r3,[r1,#0x3c]	; 03801A82
	strb r3,[r0,#0x0]	; 03801A84
	ldrb r1,[r0,#0x0]	; 03801A86
	cmp r1,#0x10	; 03801A88
	bgt P2_Entry_03801AAC	; 03801A8A
	cmp r1,#0x10	; 03801A8C
	bge P2_Entry_03801ACA	; 03801A8E
	cmp r1,#0x4	; 03801A90
	bhi P2_Entry_03801B30	; 03801A92
	add r5,r1,r1	; 03801A94
P2_SwitchIndexPC_03801A94:
	add r5,pc	; 03801A96
	ldrh r5,[r5,#(P2_SwitchTable_03801A94 - (P2_SwitchIndexPC_03801A94 + 4))]	; 03801A98
	lsl r5,r5,#0x10	; 03801A9A
	asr r5,r5,#0x10	; 03801A9C
P2_SwitchTargetPC_03801A94:
	add r5,pc	; 03801A9E
	bx r5	; 03801AA0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801A94:
	.halfword (P2_Entry_03801B30 + 1) - (P2_SwitchTargetPC_03801A94 + 4)
	.halfword (P2_Case_03801AB2 + 1) - (P2_SwitchTargetPC_03801A94 + 4)
	.halfword (P2_Case_03801AB2 + 1) - (P2_SwitchTargetPC_03801A94 + 4)
	.halfword (P2_Case_03801AB2 + 1) - (P2_SwitchTargetPC_03801A94 + 4)
	.halfword (P2_Case_03801AB2 + 1) - (P2_SwitchTargetPC_03801A94 + 4)
P2_SwitchTable_03801A94End:
P2_Entry_03801AAC:
	cmp r1,#0x11	; 03801AAC
	beq P2_Entry_03801AFE	; 03801AAE
	b P2_Entry_03801B30	; 03801AB0
P2_Case_03801AB2:
	lsr r1,r3,#0x8	; 03801AB2
	add r3,r4,r1	; 03801AB4
	add r2,r0,#0x2	; 03801AB6
	mov r1,#0x5	; 03801AB8
P2_Entry_03801ABA:
	ldrh r0,[r3,#0x0]	; 03801ABA
	add r3,r3,#0x2	; 03801ABC
	strh r0,[r2,#0x0]	; 03801ABE
	add r2,r2,#0x2	; 03801AC0
	sub r1,r1,#0x1	; 03801AC2
	cmp r1,#0x0	; 03801AC4
	bne P2_Entry_03801ABA	; 03801AC6
	b P2_Entry_03801B34	; 03801AC8
P2_Entry_03801ACA:
	lsr r3,r3,#0x8	; 03801ACA
	add r1,r4,r3	; 03801ACC
	ldrb r5,[r1,#0x1]	; 03801ACE
	ldrb r3,[r4,r3]	; 03801AD0
	cmp r2,r3	; 03801AD2
	bge P2_Entry_03801ADA	; 03801AD4
	mov r0,#0x0	; 03801AD6
	b P2_Entry_03801B36	; 03801AD8
P2_Entry_03801ADA:
	cmp r2,r5	; 03801ADA
	ble P2_Entry_03801AE2	; 03801ADC
	mov r0,#0x0	; 03801ADE
	b P2_Entry_03801B36	; 03801AE0
P2_Entry_03801AE2:
	sub r3,r2,r3	; 03801AE2
	mov r2,#0xc	; 03801AE4
	mul r3,r2	; 03801AE6
	add r1,r1,r3	; 03801AE8
	add r3,r1,#0x2	; 03801AEA
	mov r2,#0x6	; 03801AEC
P2_Entry_03801AEE:
	ldrh r1,[r3,#0x0]	; 03801AEE
	add r3,r3,#0x2	; 03801AF0
	strh r1,[r0,#0x0]	; 03801AF2
	add r0,r0,#0x2	; 03801AF4
	sub r2,r2,#0x1	; 03801AF6
	cmp r2,#0x0	; 03801AF8
	bne P2_Entry_03801AEE	; 03801AFA
	b P2_Entry_03801B34	; 03801AFC
P2_Entry_03801AFE:
	mov r1,#0x0	; 03801AFE
	lsr r3,r3,#0x8	; 03801B00
	add r4,r4,r3	; 03801B02
	b P2_Entry_03801B10	; 03801B04
P2_Entry_03801B06:
	add r1,r1,#0x1	; 03801B06
	cmp r1,#0x8	; 03801B08
	blt P2_Entry_03801B10	; 03801B0A
	mov r0,#0x0	; 03801B0C
	b P2_Entry_03801B36	; 03801B0E
P2_Entry_03801B10:
	ldrb r3,[r4,r1]	; 03801B10
	cmp r2,r3	; 03801B12
	bgt P2_Entry_03801B06	; 03801B14
	mov r2,#0xc	; 03801B16
	mul r1,r2	; 03801B18
	add r3,r4,r1	; 03801B1A
	add r3,#0x8	; 03801B1C
	mov r2,#0x6	; 03801B1E
P2_Entry_03801B20:
	ldrh r1,[r3,#0x0]	; 03801B20
	add r3,r3,#0x2	; 03801B22
	strh r1,[r0,#0x0]	; 03801B24
	add r0,r0,#0x2	; 03801B26
	sub r2,r2,#0x1	; 03801B28
	cmp r2,#0x0	; 03801B2A
	bne P2_Entry_03801B20	; 03801B2C
	b P2_Entry_03801B34	; 03801B2E
P2_Entry_03801B30:
	mov r0,#0x0	; 03801B30
	b P2_Entry_03801B36	; 03801B32
P2_Entry_03801B34:
	mov r0,#0x1	; 03801B34
P2_Entry_03801B36:
	add sp,#0x4	; 03801B36
	pop {r4,r5}	; 03801B38
	pop {r3}	; 03801B3A
	bx r3	; 03801B3C
	.byte 0x00, 0x00	; 03801B3E

; ===== function loc_03801B40 =====
loc_03801B40:
	push {r4,r5,r6,r7,lr}	; 03801B40
	sub sp,#0x4	; 03801B42
	mov r5,#0x0	; 03801B44
	add r4,r5,#0x0	; 03801B46
	ldr r0,[pool_03801BA4]	; 03801B48
	ldr r0,[r0,#0x0]	; 03801B4A
	cmp r0,#0x0	; 03801B4C
	beq loc_03801B9C	; 03801B4E
	add r6,r5,#0x0	; 03801B50
	mov r7,#0x1	; 03801B52
loc_03801B54:
	add r0,r6,#0x0	; 03801B54
	bl loc_037FF94C	; 03801B56
	cmp r0,#0x0	; 03801B5A
	beq loc_03801B68	; 03801B5C
	add r0,r7,#0x0	; 03801B5E
	lsl r0,r6	; 03801B60
	orr r5,r0	; 03801B62
	lsl r0,r5,#0x10	; 03801B64
	lsr r5,r0,#0x10	; 03801B66
loc_03801B68:
	add r6,r6,#0x1	; 03801B68
	cmp r6,#0x10	; 03801B6A
	blt loc_03801B54	; 03801B6C
	mov r0,#0x0	; 03801B6E
	bl loc_037FFEA0	; 03801B70
	cmp r0,#0x0	; 03801B74
	beq loc_03801B80	; 03801B76
	mov r0,#0x1	; 03801B78
	orr r4,r0	; 03801B7A
	lsl r0,r4,#0x10	; 03801B7C
	lsr r4,r0,#0x10	; 03801B7E
loc_03801B80:
	mov r0,#0x1	; 03801B80
	bl loc_037FFEA0	; 03801B82
	cmp r0,#0x0	; 03801B86
	beq loc_03801B92	; 03801B88
	mov r0,#0x2	; 03801B8A
	orr r4,r0	; 03801B8C
	lsl r0,r4,#0x10	; 03801B8E
	lsr r4,r0,#0x10	; 03801B90
loc_03801B92:
	ldr r0,[pool_03801BA4]	; 03801B92
	ldr r1,[r0,#0x0]	; 03801B94
	strh r5,[r1,#0x8]	; 03801B96
	ldr r0,[r0,#0x0]	; 03801B98
	strh r4,[r0,#0xa]	; 03801B9A
loc_03801B9C:
	add sp,#0x4	; 03801B9C
	pop {r4,r5,r6,r7}	; 03801B9E
	pop {r3}	; 03801BA0
	bx r3	; 03801BA2
pool_03801BA4:
loc_03801BA4:
	.word P2_BssStart + 0xD80	; 03801BA4

; ===== function loc_03801BA8 =====
loc_03801BA8:
	ldr r2,[pool_03801BB8]	; 03801BA8
	ldr r2,[r2,#0x0]	; 03801BAA
	lsl r0,r0,#0x1	; 03801BAC
	add r2,r2,r0	; 03801BAE
	ldr r0,[pool_03801BBC]	; 03801BB0
	strh r1,[r2,r0]	; 03801BB2
	bx lr	; 03801BB4
	.byte 0xC0, 0x46	; 03801BB8
pool_03801BB8:
loc_03801BB8:
	.word P2_BssStart + 0xD80	; 03801BB8
pool_03801BBC:
loc_03801BBC:
	.word 0x00000260	; 03801BBC

; ===== function loc_03801BC0 =====
loc_03801BC0:
	push {r4,lr}	; 03801BC0
	ldr r3,[pool_03801BD8]	; 03801BC2
	ldr r4,[r3,#0x0]	; 03801BC4
	mov r3,#0x24	; 03801BC6
	mul r0,r3	; 03801BC8
	add r3,r4,r0	; 03801BCA
	lsl r0,r1,#0x1	; 03801BCC
	add r0,r3,r0	; 03801BCE
	strh r2,[r0,#0x20]	; 03801BD0
	pop {r4}	; 03801BD2
	pop {r3}	; 03801BD4
	bx r3	; 03801BD6
pool_03801BD8:
loc_03801BD8:
	.word P2_BssStart + 0xD80	; 03801BD8

; ===== function loc_03801BDC =====
	push {r4,r5,r6,lr}	; 03801BDC
	add r5,r0,#0x0	; 03801BDE
	mov r4,#0x7	; 03801BE0
	mov r6,#0x0	; 03801BE2
loc_03801BE4:
	add r0,r4,#0x0	; 03801BE4
	add r1,r5,#0x0	; 03801BE6
	add r2,r6,#0x0	; 03801BE8
	bl loc_03802320	; 03801BEA
	cmp r0,#0x0	; 03801BEE
	blt loc_03801BE4	; 03801BF0
	pop {r4,r5,r6}	; 03801BF2
	pop {r3}	; 03801BF4
	bx r3	; 03801BF6

; ===== function loc_03801BF8 =====
loc_03801BF8:
	push {r4,lr}	; 03801BF8
	ldr r1,[pool_03801C20]	; 03801BFA
	lsl r0,r0,#0x6	; 03801BFC
	add r4,r1,r0	; 03801BFE
	ldrb r0,[r1,r0]	; 03801C00
	cmp r0,#0x0	; 03801C02
	beq loc_03801C1A	; 03801C04
	add r0,r4,#0x0	; 03801C06
	add r0,#0x14	; 03801C08
	bl loc_037FEE4C	; 03801C0A
	add r1,r4,#0x1	; 03801C0E
	ldrb r0,[r1,#0x0]	; 03801C10
	add r0,r0,#0x1	; 03801C12
	strb r0,[r1,#0x0]	; 03801C14
	mov r0,#0x0	; 03801C16
	strb r0,[r4,#0x0]	; 03801C18
loc_03801C1A:
	pop {r4}	; 03801C1A
	pop {r3}	; 03801C1C
	bx r3	; 03801C1E
pool_03801C20:
loc_03801C20:
	.word P2_BssStart + 0x1D04	; 03801C20

; ===== function loc_03801C24 =====
loc_03801C24:
	push {r4,r5,r6,r7,lr}	; 03801C24
	sub sp,#0x1c	; 03801C26
	str r0,[sp,#0xc]	; 03801C28
	ldr r1,[pool_03801CB0]	; 03801C2A
	lsl r0,r0,#0x6	; 03801C2C
	add r5,r1,r0	; 03801C2E
	ldrb r0,[r1,r0]	; 03801C30
	cmp r0,#0x0	; 03801C32
	beq loc_03801C42	; 03801C34
	add r0,r5,#0x0	; 03801C36
	add r0,#0x14	; 03801C38
	bl loc_037FEE4C	; 03801C3A
	mov r0,#0x0	; 03801C3E
	strb r0,[r5,#0x0]	; 03801C40
loc_03801C42:
	ldr r6,[r5,#0x4]	; 03801C42
	ldr r7,[r5,#0x8]	; 03801C44
	ldr r0,[r5,#0xc]	; 03801C46
	str r0,[sp,#0x10]	; 03801C48
	ldr r0,[r5,#0x10]	; 03801C4A
	str r0,[sp,#0x14]	; 03801C4C
	ldrb r0,[r5,#0x1]	; 03801C4E
	lsl r4,r0,#0x8	; 03801C50
	ldr r0,[sp,#0xc]	; 03801C52
	orr r4,r0	; 03801C54
	add r0,r5,#0x0	; 03801C56
	add r0,#0x14	; 03801C58
	bl loc_037FF024	; 03801C5A
	mov r2,#0x0	; 03801C5E
	ldr r1,[sp,#0x14]	; 03801C60
	eor r1,r2	; 03801C62
	ldr r0,[sp,#0x10]	; 03801C64
	eor r0,r2	; 03801C66
	orr r1,r0	; 03801C68
	bne loc_03801C7E	; 03801C6A
	str r4,[sp,#0x0]	; 03801C6C
	add r0,r5,#0x0	; 03801C6E
	add r0,#0x14	; 03801C70
	add r1,r6,#0x0	; 03801C72
	add r2,r7,#0x0	; 03801C74
	ldr r3,[pool_03801CB4]	; 03801C76
	bl loc_037FEEF8	; 03801C78
	b loc_03801CA2	; 03801C7C
loc_03801C7E:
	bl loc_037FEC58	; 03801C7E
	str r0,[sp,#0x18]	; 03801C82
	add r2,r1,#0x0	; 03801C84
	ldr r0,[pool_03801CB4]	; 03801C86
	str r0,[sp,#0x4]	; 03801C88
	str r4,[sp,#0x8]	; 03801C8A
	ldr r3,[sp,#0x10]	; 03801C8C
	ldr r0,[sp,#0x14]	; 03801C8E
	str r0,[sp,#0x0]	; 03801C90
	add r0,r5,#0x0	; 03801C92
	add r0,#0x14	; 03801C94
	ldr r1,[sp,#0x18]	; 03801C96
	add r1,r6,r1	; 03801C98
	adc r7,r2	; 03801C9A
	add r2,r7,#0x0	; 03801C9C
	bl loc_037FEEA8	; 03801C9E
loc_03801CA2:
	mov r0,#0x1	; 03801CA2
	strb r0,[r5,#0x0]	; 03801CA4
	add sp,#0x1c	; 03801CA6
	pop {r4,r5,r6,r7}	; 03801CA8
	pop {r3}	; 03801CAA
	bx r3	; 03801CAC
	.byte 0xC0, 0x46	; 03801CB0
pool_03801CB0:
loc_03801CB0:
	.word P2_BssStart + 0x1D04	; 03801CB0
pool_03801CB4:
loc_03801CB4:
	.word 0x03801BDD	; 03801CB4

; ===== function loc_03801CB8 =====
loc_03801CB8:
	push {r4,r5,r6,lr}	; 03801CB8
	sub sp,#0x8	; 03801CBA
	add r5,r1,#0x0	; 03801CBC
	add r6,r2,#0x0	; 03801CBE
	str r3,[sp,#0x0]	; 03801CC0
	ldr r1,[sp,#0x18]	; 03801CC2
	str r1,[sp,#0x4]	; 03801CC4
	ldr r1,[pool_03801CF8]	; 03801CC6
	lsl r0,r0,#0x6	; 03801CC8
	add r4,r1,r0	; 03801CCA
	ldrb r0,[r1,r0]	; 03801CCC
	cmp r0,#0x0	; 03801CCE
	beq loc_03801CDE	; 03801CD0
	add r0,r4,#0x0	; 03801CD2
	add r0,#0x14	; 03801CD4
	bl loc_037FEE4C	; 03801CD6
	mov r0,#0x0	; 03801CDA
	strb r0,[r4,#0x0]	; 03801CDC
loc_03801CDE:
	str r5,[r4,#0x4]	; 03801CDE
	str r6,[r4,#0x8]	; 03801CE0
	ldr r0,[sp,#0x0]	; 03801CE2
	str r0,[r4,#0xc]	; 03801CE4
	ldr r0,[sp,#0x4]	; 03801CE6
	str r0,[r4,#0x10]	; 03801CE8
	ldr r0,[sp,#0x1c]	; 03801CEA
	strb r0,[r4,#0x1]	; 03801CEC
	add sp,#0x8	; 03801CEE
	pop {r4,r5,r6}	; 03801CF0
	pop {r3}	; 03801CF2
	bx r3	; 03801CF4
	.byte 0xC0, 0x46	; 03801CF8
pool_03801CF8:
loc_03801CF8:
	.word P2_BssStart + 0x1D04	; 03801CF8
P2_Entry_03801CFC:
	push {r4,r5,lr}	; 03801CFC
	sub sp,#0x4	; 03801CFE
	mov r5,#0x0	; 03801D00
	ldr r4,[pool_03801D20]	; 03801D02
	add r2,r5,#0x0	; 03801D04
	ldr r0,[pool_03801D24]	; 03801D06
	ldr r1,[pool_03801D28]	; 03801D08
P2_Entry_03801D0A:
	lsl r3,r5,#0x6	; 03801D0A
	add r3,r4,r3	; 03801D0C
	strb r2,[r3,r0]	; 03801D0E
	strb r2,[r3,r1]	; 03801D10
	add r5,r5,#0x1	; 03801D12
	cmp r5,#0x8	; 03801D14
	blt P2_Entry_03801D0A	; 03801D16
	add sp,#0x4	; 03801D18
	pop {r4,r5}	; 03801D1A
	pop {r3}	; 03801D1C
	bx r3	; 03801D1E
pool_03801D20:
	.word 0x03806500	; 03801D20
pool_03801D24:
	.word 0x00000F80	; 03801D24
pool_03801D28:
	.word 0x00000F81	; 03801D28

; ===== function loc_03801D2C =====
loc_03801D2C:
	push {r4,r5,r6,r7,lr}	; 03801D2C
	sub sp,#0xc	; 03801D2E
	add r5,r0,#0x0	; 03801D30
	add r7,r1,#0x0	; 03801D32
	add r6,r2,#0x0	; 03801D34
	str r3,[sp,#0x0]	; 03801D36
	bl loc_037FE0D0	; 03801D38
	str r0,[sp,#0x4]	; 03801D3C
	mov r4,#0x0	; 03801D3E
	b loc_03801D56	; 03801D40
loc_03801D42:
	add r1,r6,#0x0	; 03801D42
	mov r0,#0x1	; 03801D44
	and r1,r0	; 03801D46
	cmp r1,#0x0	; 03801D48
	beq loc_03801D52	; 03801D4A
	add r0,r4,#0x0	; 03801D4C
	bl loc_03801BF8	; 03801D4E
loc_03801D52:
	add r4,r4,#0x1	; 03801D52
	lsr r6,r6,#0x1	; 03801D54
loc_03801D56:
	cmp r4,#0x8	; 03801D56
	bge loc_03801D5E	; 03801D58
	cmp r6,#0x0	; 03801D5A
	bne loc_03801D42	; 03801D5C
loc_03801D5E:
	mov r4,#0x0	; 03801D5E
	mov r6,#0x1	; 03801D60
	b loc_03801D78	; 03801D62
loc_03801D64:
	add r0,r5,#0x0	; 03801D64
	and r0,r6	; 03801D66
	cmp r0,#0x0	; 03801D68
	beq loc_03801D74	; 03801D6A
	add r0,r4,#0x0	; 03801D6C
	ldr r1,[sp,#0x0]	; 03801D6E
	bl loc_037FFA18	; 03801D70
loc_03801D74:
	add r4,r4,#0x1	; 03801D74
	lsr r5,r5,#0x1	; 03801D76
loc_03801D78:
	cmp r4,#0x10	; 03801D78
	bge loc_03801D80	; 03801D7A
	cmp r5,#0x0	; 03801D7C
	bne loc_03801D64	; 03801D7E
loc_03801D80:
	mov r0,#0x1	; 03801D80
	add r1,r7,#0x0	; 03801D82
	and r1,r0	; 03801D84
	cmp r1,#0x0	; 03801D86
	beq loc_03801D90	; 03801D88
	mov r1,#0x0	; 03801D8A
	ldr r0,[pool_03801DB0]	; 03801D8C
	strb r1,[r0,#0x0]	; 03801D8E
loc_03801D90:
	mov r0,#0x2	; 03801D90
	and r7,r0	; 03801D92
	cmp r7,#0x0	; 03801D94
	beq loc_03801D9E	; 03801D96
	mov r1,#0x0	; 03801D98
	ldr r0,[pool_03801DB4]	; 03801D9A
	strb r1,[r0,#0x0]	; 03801D9C
loc_03801D9E:
	ldr r0,[sp,#0x4]	; 03801D9E
	bl loc_037FE0F4	; 03801DA0
	bl loc_03801B40	; 03801DA4
	add sp,#0xc	; 03801DA8
	pop {r4,r5,r6,r7}	; 03801DAA
	pop {r3}	; 03801DAC
	bx r3	; 03801DAE
pool_03801DB0:
loc_03801DB0:
	.word REG_SNDCAP0CNT	; 03801DB0
pool_03801DB4:
loc_03801DB4:
	.word REG_SNDCAP1CNT	; 03801DB4

; ===== function loc_03801DB8 =====
loc_03801DB8:
	push {r4,r5,r6,r7,lr}	; 03801DB8
	sub sp,#0x4	; 03801DBA
	add r5,r0,#0x0	; 03801DBC
	add r4,r1,#0x0	; 03801DBE
	add r6,r2,#0x0	; 03801DC0
	bl loc_037FE0D0	; 03801DC2
	add r7,r0,#0x0	; 03801DC6
	mov r3,#0x0	; 03801DC8
	b loc_03801DE8	; 03801DCA
loc_03801DCC:
	add r1,r5,#0x0	; 03801DCC
	mov r0,#0x1	; 03801DCE
	and r1,r0	; 03801DD0
	cmp r1,#0x0	; 03801DD2
	beq loc_03801DE4	; 03801DD4
	lsl r1,r3,#0x4	; 03801DD6
	ldr r0,[pool_03801E60]	; 03801DD8
	add r2,r1,r0	; 03801DDA
	ldrb r1,[r2,#0x0]	; 03801DDC
	mov r0,#0x80	; 03801DDE
	orr r1,r0	; 03801DE0
	strb r1,[r2,#0x0]	; 03801DE2
loc_03801DE4:
	add r3,r3,#0x1	; 03801DE4
	lsr r5,r5,#0x1	; 03801DE6
loc_03801DE8:
	cmp r3,#0x10	; 03801DE8
	bge loc_03801DF0	; 03801DEA
	cmp r5,#0x0	; 03801DEC
	bne loc_03801DCC	; 03801DEE
loc_03801DF0:
	mov r0,#0x1	; 03801DF0
	add r1,r4,#0x0	; 03801DF2
	and r1,r0	; 03801DF4
	cmp r1,#0x0	; 03801DF6
	beq loc_03801E1A	; 03801DF8
	mov r0,#0x2	; 03801DFA
	and r4,r0	; 03801DFC
	cmp r4,#0x0	; 03801DFE
	beq loc_03801E0E	; 03801E00
	ldr r2,[pool_03801E64]	; 03801E02
	ldrh r1,[r2,#0x0]	; 03801E04
	ldr r0,[pool_03801E68]	; 03801E06
	orr r1,r0	; 03801E08
	strh r1,[r2,#0x0]	; 03801E0A
	b loc_03801E2C	; 03801E0C
loc_03801E0E:
	ldr r2,[pool_03801E64]	; 03801E0E
	ldrb r1,[r2,#0x0]	; 03801E10
	mov r0,#0x80	; 03801E12
	orr r1,r0	; 03801E14
	strb r1,[r2,#0x0]	; 03801E16
	b loc_03801E2C	; 03801E18
loc_03801E1A:
	mov r0,#0x2	; 03801E1A
	and r4,r0	; 03801E1C
	cmp r4,#0x0	; 03801E1E
	beq loc_03801E2C	; 03801E20
	ldr r2,[pool_03801E6C]	; 03801E22
	ldrb r1,[r2,#0x0]	; 03801E24
	mov r0,#0x80	; 03801E26
	orr r1,r0	; 03801E28
	strb r1,[r2,#0x0]	; 03801E2A
loc_03801E2C:
	mov r4,#0x0	; 03801E2C
	mov r5,#0x1	; 03801E2E
	b loc_03801E44	; 03801E30
loc_03801E32:
	add r0,r6,#0x0	; 03801E32
	and r0,r5	; 03801E34
	cmp r0,#0x0	; 03801E36
	beq loc_03801E40	; 03801E38
	add r0,r4,#0x0	; 03801E3A
	bl loc_03801C24	; 03801E3C
loc_03801E40:
	add r4,r4,#0x1	; 03801E40
	lsr r6,r6,#0x1	; 03801E42
loc_03801E44:
	cmp r4,#0x8	; 03801E44
	bge loc_03801E4C	; 03801E46
	cmp r6,#0x0	; 03801E48
	bne loc_03801E32	; 03801E4A
loc_03801E4C:
	add r0,r7,#0x0	; 03801E4C
	bl loc_037FE0F4	; 03801E4E
	bl loc_03801B40	; 03801E52
	add sp,#0x4	; 03801E56
	pop {r4,r5,r6,r7}	; 03801E58
	pop {r3}	; 03801E5A
	bx r3	; 03801E5C
	.byte 0xC0, 0x46	; 03801E60
pool_03801E60:
loc_03801E60:
	.word 0x04000403	; 03801E60
pool_03801E64:
loc_03801E64:
	.word REG_SNDCAP0CNT	; 03801E64
pool_03801E68:
loc_03801E68:
	.word 0x00008080	; 03801E68
pool_03801E6C:
loc_03801E6C:
	.word REG_SNDCAP1CNT	; 03801E6C

; ===== function loc_03801E70 =====
loc_03801E70:
	push {r4,r5,r6,r7,lr}	; 03801E70
	sub sp,#0x4	; 03801E72
	add r5,r0,#0x0	; 03801E74
	add r6,r1,#0x0	; 03801E76
	mov r4,#0x0	; 03801E78
	mov r7,#0x1	; 03801E7A
	b loc_03801E92	; 03801E7C
loc_03801E7E:
	add r0,r5,#0x0	; 03801E7E
	and r0,r7	; 03801E80
	cmp r0,#0x0	; 03801E82
	beq loc_03801E8E	; 03801E84
	add r0,r4,#0x0	; 03801E86
	add r1,r6,#0x0	; 03801E88
	bl loc_037FF968	; 03801E8A
loc_03801E8E:
	add r4,r4,#0x1	; 03801E8E
	lsr r5,r5,#0x1	; 03801E90
loc_03801E92:
	cmp r4,#0x10	; 03801E92
	bge loc_03801E9A	; 03801E94
	cmp r5,#0x0	; 03801E96
	bne loc_03801E7E	; 03801E98
loc_03801E9A:
	add sp,#0x4	; 03801E9A
	pop {r4,r5,r6,r7}	; 03801E9C
	pop {r3}	; 03801E9E
	bx r3	; 03801EA0
	.byte 0x00, 0x00	; 03801EA4

; ===== function loc_03801EA4 =====
loc_03801EA4:
	push {r4,r5,r6,r7,lr}	; 03801EA4
	sub sp,#0x4	; 03801EA6
	add r5,r0,#0x0	; 03801EA8
	add r6,r1,#0x0	; 03801EAA
	add r7,r2,#0x0	; 03801EAC
	mov r4,#0x0	; 03801EAE
	b loc_03801ECA	; 03801EB0
loc_03801EB2:
	add r1,r5,#0x0	; 03801EB2
	mov r0,#0x1	; 03801EB4
	and r1,r0	; 03801EB6
	cmp r1,#0x0	; 03801EB8
	beq loc_03801EC6	; 03801EBA
	add r0,r4,#0x0	; 03801EBC
	add r1,r6,#0x0	; 03801EBE
	add r2,r7,#0x0	; 03801EC0
	bl loc_037FF9C0	; 03801EC2
loc_03801EC6:
	add r4,r4,#0x1	; 03801EC6
	lsr r5,r5,#0x1	; 03801EC8
loc_03801ECA:
	cmp r4,#0x10	; 03801ECA
	bge loc_03801ED2	; 03801ECC
	cmp r5,#0x0	; 03801ECE
	bne loc_03801EB2	; 03801ED0
loc_03801ED2:
	add sp,#0x4	; 03801ED2
	pop {r4,r5,r6,r7}	; 03801ED4
	pop {r3}	; 03801ED6
	bx r3	; 03801ED8
	.byte 0x00, 0x00	; 03801EDC

; ===== function loc_03801EDC =====
loc_03801EDC:
	push {r4,r5,r6,r7,lr}	; 03801EDC
	sub sp,#0x4	; 03801EDE
	add r5,r0,#0x0	; 03801EE0
	add r6,r1,#0x0	; 03801EE2
	mov r4,#0x0	; 03801EE4
	mov r7,#0x1	; 03801EE6
	b loc_03801EFE	; 03801EE8
loc_03801EEA:
	add r0,r5,#0x0	; 03801EEA
	and r0,r7	; 03801EEC
	cmp r0,#0x0	; 03801EEE
	beq loc_03801EFA	; 03801EF0
	add r0,r4,#0x0	; 03801EF2
	add r1,r6,#0x0	; 03801EF4
	bl loc_037FF9AC	; 03801EF6
loc_03801EFA:
	add r4,r4,#0x1	; 03801EFA
	lsr r5,r5,#0x1	; 03801EFC
loc_03801EFE:
	cmp r4,#0x10	; 03801EFE
	bge loc_03801F06	; 03801F00
	cmp r5,#0x0	; 03801F02
	bne loc_03801EEA	; 03801F04
loc_03801F06:
	add sp,#0x4	; 03801F06
	pop {r4,r5,r6,r7}	; 03801F08
	pop {r3}	; 03801F0A
	bx r3	; 03801F0C
	.byte 0x00, 0x00	; 03801F10

; ===== function loc_03801F10 =====
loc_03801F10:
	mov r0,#0x7	; 03801F10
	ldr r1,[pool_03801F18]	; 03801F12
	ldr r3,[pool_03801F1C]	; 03801F14
	bx r3	; 03801F16
pool_03801F18:
loc_03801F18:
	.word 0x03801F21	; 03801F18
pool_03801F1C:
loc_03801F1C:
	.word P2_SetPxiReceiveCallback + 1	; 03801F1C

; ===== function loc_03801F20 =====
	push {r4,r5,lr}	; 03801F20
	sub sp,#0x4	; 03801F22
	add r5,r1,#0x0	; 03801F24
	bl loc_037FE0D0	; 03801F26
	add r4,r0,#0x0	; 03801F2A
	ldr r0,[pool_03801F54]	; 03801F2C
	cmp r5,r0	; 03801F2E
	bcc loc_03801F3E	; 03801F30
	ldr r0,[pool_03801F58]	; 03801F32
	add r1,r5,#0x0	; 03801F34
	mov r2,#0x0	; 03801F36
	bl loc_037FE6F0	; 03801F38
	b loc_03801F46	; 03801F3C
loc_03801F3E:
	cmp r5,#0x0	; 03801F3E
	bne loc_03801F46	; 03801F40
	bl loc_037FFDC0	; 03801F42
loc_03801F46:
	add r0,r4,#0x0	; 03801F46
	bl loc_037FE0F4	; 03801F48
	add sp,#0x4	; 03801F4C
	pop {r4,r5}	; 03801F4E
	pop {r3}	; 03801F50
	bx r3	; 03801F52
pool_03801F54:
loc_03801F54:
	.word 0x02000000	; 03801F54
pool_03801F58:
loc_03801F58:
	.word 0x03807680	; 03801F58

; ===== function loc_03801F5C =====
P2_Entry_03801F5C:
	push {r4,r5,r6,r7,lr}	; 03801F5C
	sub sp,#0x34	; 03801F5E
	mov r4,#0x7f	; 03801F60
	mov r7,#0x3	; 03801F62
	mov r6,#0x1	; 03801F64
	b loc_038021D0	; 03801F66
loc_03801F68:
	ldr r5,[sp,#0x18]	; 03801F68
	b loc_038021C0	; 03801F6A
loc_03801F6C:
	add r3,sp,#0x1c	; 03801F6C
	mov r2,#0x3	; 03801F6E
loc_03801F70:
	ldmia r5!,{r0,r1}	; 03801F70
	stmia r3!,{r0,r1}	; 03801F72
	sub r2,r2,#0x1	; 03801F74
	cmp r2,#0x0	; 03801F76
	bne loc_03801F70	; 03801F78
	ldr r0,[sp,#0x20]	; 03801F7A
	cmp r0,#0x1d	; 03801F7C
	bls loc_03801F82	; 03801F7E
	b loc_038021BE	; 03801F80
loc_03801F82:
	add r0,r0,r0	; 03801F82
P2_SwitchIndexPC_03801F82:
	add r0,pc	; 03801F84
	ldrh r0,[r0,#(P2_SwitchTable_03801F82 - (P2_SwitchIndexPC_03801F82 + 4))]	; 03801F86
	lsl r0,r0,#0x10	; 03801F88
	asr r0,r0,#0x10	; 03801F8A
P2_SwitchTargetPC_03801F82:
	add r0,pc	; 03801F8C
	bx r0	; 03801F8E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03801F82:
	.halfword (loc_03801FCC + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03801FDA + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03801FE2 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03801FEC + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03801FFA + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802014 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802020 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380202C + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380203C + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380204A + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802058 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038020C2 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380210E + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802130 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802066 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380208C + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038020A2 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038020AC + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038020B8 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802152 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380215A + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802162 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802170 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380217A + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802184 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038021AC + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038021B4 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_0380218E + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_03802198 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
	.halfword (loc_038021A2 + 1) - (P2_SwitchTargetPC_03801F82 + 4)
P2_SwitchTable_03801F82End:
loc_03801FCC:
	ldr r0,[sp,#0x24]	; 03801FCC
	ldr r1,[sp,#0x28]	; 03801FCE
	ldr r2,[sp,#0x2c]	; 03801FD0
	ldr r3,[sp,#0x30]	; 03801FD2
	bl loc_03801820	; 03801FD4
	b loc_038021BE	; 03801FD8
loc_03801FDA:
	ldr r0,[sp,#0x24]	; 03801FDA
	bl loc_038017E4	; 03801FDC
	b loc_038021BE	; 03801FE0
loc_03801FE2:
	ldr r0,[sp,#0x24]	; 03801FE2
	ldr r1,[sp,#0x28]	; 03801FE4
	bl loc_038017AC	; 03801FE6
	b loc_038021BE	; 03801FEA
loc_03801FEC:
	ldr r0,[sp,#0x24]	; 03801FEC
	ldr r1,[sp,#0x28]	; 03801FEE
	ldr r2,[sp,#0x2c]	; 03801FF0
	ldr r3,[sp,#0x30]	; 03801FF2
	bl loc_03801630	; 03801FF4
	b loc_038021BE	; 03801FF8
loc_03801FFA:
	ldr r0,[sp,#0x24]	; 03801FFA
	lsr r2,r0,#0x18	; 03801FFC
	mov r1,#0xff	; 03801FFE
	and r2,r1	; 03802000
	str r2,[sp,#0x0]	; 03802002
	ldr r1,[pool_038021E8]	; 03802004
	and r0,r1	; 03802006
	ldr r1,[sp,#0x28]	; 03802008
	ldr r2,[sp,#0x2c]	; 0380200A
	ldr r3,[sp,#0x30]	; 0380200C
	bl loc_038015D4	; 0380200E
	b loc_038021BE	; 03802012
loc_03802014:
	ldr r0,[sp,#0x24]	; 03802014
	ldr r1,[sp,#0x28]	; 03802016
	ldr r2,[sp,#0x2c]	; 03802018
	bl loc_03801744	; 0380201A
	b loc_038021BE	; 0380201E
loc_03802020:
	ldr r0,[sp,#0x24]	; 03802020
	ldr r1,[sp,#0x28]	; 03802022
	ldr r2,[sp,#0x2c]	; 03802024
	bl loc_038016F4	; 03802026
	b loc_038021BE	; 0380202A
loc_0380202C:
	ldr r0,[sp,#0x24]	; 0380202C
	ldr r1,[sp,#0x28]	; 0380202E
	ldr r2,[sp,#0x2c]	; 03802030
	lsl r2,r2,#0x10	; 03802032
	asr r2,r2,#0x10	; 03802034
	bl loc_03801BC0	; 03802036
	b loc_038021BE	; 0380203A
loc_0380203C:
	ldr r0,[sp,#0x24]	; 0380203C
	ldr r1,[sp,#0x28]	; 0380203E
	lsl r1,r1,#0x10	; 03802040
	asr r1,r1,#0x10	; 03802042
	bl loc_03801BA8	; 03802044
	b loc_038021BE	; 03802048
loc_0380204A:
	ldr r0,[sp,#0x24]	; 0380204A
	ldr r1,[sp,#0x28]	; 0380204C
	ldr r2,[sp,#0x2c]	; 0380204E
	ldr r3,[sp,#0x30]	; 03802050
	bl loc_03801DB8	; 03802052
	b loc_038021BE	; 03802056
loc_03802058:
	ldr r0,[sp,#0x24]	; 03802058
	ldr r1,[sp,#0x28]	; 0380205A
	ldr r2,[sp,#0x2c]	; 0380205C
	ldr r3,[sp,#0x30]	; 0380205E
	bl loc_03801D2C	; 03802060
	b loc_038021BE	; 03802064
loc_03802066:
	ldr r1,[sp,#0x2c]	; 03802066
	lsr r0,r1,#0x1d	; 03802068
	and r0,r6	; 0380206A
	str r0,[sp,#0x0]	; 0380206C
	lsr r0,r1,#0x1c	; 0380206E
	and r0,r6	; 03802070
	str r0,[sp,#0x4]	; 03802072
	lsr r0,r1,#0x1b	; 03802074
	and r0,r6	; 03802076
	str r0,[sp,#0x8]	; 03802078
	lsr r0,r1,#0x1f	; 0380207A
	and r0,r6	; 0380207C
	lsr r1,r1,#0x1e	; 0380207E
	and r1,r6	; 03802080
	ldr r2,[sp,#0x24]	; 03802082
	ldr r3,[sp,#0x28]	; 03802084
	bl loc_037FFEB8	; 03802086
	b loc_038021BE	; 0380208A
loc_0380208C:
	ldr r0,[sp,#0x30]	; 0380208C
	str r0,[sp,#0x4]	; 0380208E
	ldr r3,[sp,#0x2c]	; 03802090
	mov r0,#0x0	; 03802092
	str r0,[sp,#0x0]	; 03802094
	ldr r0,[sp,#0x24]	; 03802096
	ldr r1,[sp,#0x28]	; 03802098
	mov r2,#0x0	; 0380209A
	bl loc_03801CB8	; 0380209C
	b loc_038021BE	; 038020A0
loc_038020A2:
	ldr r0,[sp,#0x24]	; 038020A2
	ldr r1,[sp,#0x28]	; 038020A4
	bl loc_03801EDC	; 038020A6
	b loc_038021BE	; 038020AA
loc_038020AC:
	ldr r0,[sp,#0x24]	; 038020AC
	ldr r1,[sp,#0x28]	; 038020AE
	ldr r2,[sp,#0x2c]	; 038020B0
	bl loc_03801EA4	; 038020B2
	b loc_038021BE	; 038020B6
loc_038020B8:
	ldr r0,[sp,#0x24]	; 038020B8
	ldr r1,[sp,#0x28]	; 038020BA
	bl loc_03801E70	; 038020BC
	b loc_038021BE	; 038020C0
loc_038020C2:
	ldr r3,[sp,#0x30]	; 038020C2
	ldr r2,[sp,#0x24]	; 038020C4
	ldr r1,[sp,#0x2c]	; 038020C6
	add r5,r3,#0x0	; 038020C8
	ldr r0,[pool_038021EC]	; 038020CA
	and r5,r0	; 038020CC
	str r5,[sp,#0x0]	; 038020CE
	add r5,r1,#0x0	; 038020D0
	ldr r0,[pool_038021F0]	; 038020D2
	and r5,r0	; 038020D4
	str r5,[sp,#0x4]	; 038020D6
	lsr r0,r1,#0x18	; 038020D8
	and r0,r4	; 038020DA
	str r0,[sp,#0x8]	; 038020DC
	lsr r0,r1,#0x16	; 038020DE
	and r0,r7	; 038020E0
	str r0,[sp,#0xc]	; 038020E2
	lsr r1,r2,#0x10	; 038020E4
	ldr r0,[pool_038021EC]	; 038020E6
	and r1,r0	; 038020E8
	str r1,[sp,#0x10]	; 038020EA
	lsr r0,r3,#0x10	; 038020EC
	and r0,r4	; 038020EE
	str r0,[sp,#0x14]	; 038020F0
	ldr r0,[pool_038021EC]	; 038020F2
	and r2,r0	; 038020F4
	add r0,r2,#0x0	; 038020F6
	ldr r2,[sp,#0x28]	; 038020F8
	ldr r1,[pool_038021F4]	; 038020FA
	and r2,r1	; 038020FC
	add r1,r2,#0x0	; 038020FE
	lsr r2,r3,#0x18	; 03802100
	and r2,r7	; 03802102
	lsr r3,r3,#0x1a	; 03802104
	and r3,r7	; 03802106
	bl loc_037FFB14	; 03802108
	b loc_038021BE	; 0380210C
loc_0380210E:
	ldr r2,[sp,#0x2c]	; 0380210E
	ldr r3,[sp,#0x28]	; 03802110
	lsr r1,r2,#0x8	; 03802112
	ldr r0,[pool_038021EC]	; 03802114
	and r1,r0	; 03802116
	str r1,[sp,#0x0]	; 03802118
	and r2,r4	; 0380211A
	str r2,[sp,#0x4]	; 0380211C
	ldr r0,[sp,#0x24]	; 0380211E
	ldr r1,[sp,#0x30]	; 03802120
	add r2,r3,#0x0	; 03802122
	and r2,r4	; 03802124
	lsr r3,r3,#0x8	; 03802126
	and r3,r7	; 03802128
	bl loc_037FFAA8	; 0380212A
	b loc_038021BE	; 0380212E
loc_03802130:
	ldr r3,[sp,#0x2c]	; 03802130
	ldr r2,[sp,#0x28]	; 03802132
	add r0,r3,#0x0	; 03802134
	and r0,r4	; 03802136
	str r0,[sp,#0x0]	; 03802138
	ldr r0,[sp,#0x24]	; 0380213A
	add r1,r2,#0x0	; 0380213C
	and r1,r4	; 0380213E
	lsr r2,r2,#0x8	; 03802140
	and r2,r7	; 03802142
	lsr r5,r3,#0x8	; 03802144
	ldr r3,[pool_038021EC]	; 03802146
	and r5,r3	; 03802148
	add r3,r5,#0x0	; 0380214A
	bl loc_037FFA40	; 0380214C
	b loc_038021BE	; 03802150
loc_03802152:
	ldr r0,[sp,#0x24]	; 03802152
	bl loc_037FF900	; 03802154
	b loc_038021BE	; 03802158
loc_0380215A:
	ldr r0,[sp,#0x24]	; 0380215A
	bl loc_037FF828	; 0380215C
	b loc_038021BE	; 03802160
loc_03802162:
	ldr r0,[sp,#0x24]	; 03802162
	ldr r1,[sp,#0x28]	; 03802164
	ldr r2,[sp,#0x2c]	; 03802166
	ldr r3,[sp,#0x30]	; 03802168
	bl loc_037FF7F4	; 0380216A
	b loc_038021BE	; 0380216E
loc_03802170:
	ldr r0,[sp,#0x24]	; 03802170
	ldr r1,[sp,#0x28]	; 03802172
	bl loc_03800260	; 03802174
	b loc_038021BE	; 03802178
loc_0380217A:
	ldr r0,[sp,#0x24]	; 0380217A
	ldr r1,[sp,#0x28]	; 0380217C
	bl loc_0380023C	; 0380217E
	b loc_038021BE	; 03802182
loc_03802184:
	ldr r0,[sp,#0x24]	; 03802184
	ldr r1,[sp,#0x28]	; 03802186
	bl loc_0380030C	; 03802188
	b loc_038021BE	; 0380218C
loc_0380218E:
	ldr r0,[sp,#0x24]	; 0380218E
	ldr r1,[sp,#0x28]	; 03802190
	bl loc_0380169C	; 03802192
	b loc_038021BE	; 03802196
loc_03802198:
	ldr r0,[sp,#0x24]	; 03802198
	ldr r1,[sp,#0x28]	; 0380219A
	bl loc_03801660	; 0380219C
	b loc_038021BE	; 038021A0
loc_038021A2:
	ldr r0,[sp,#0x24]	; 038021A2
	ldr r1,[sp,#0x28]	; 038021A4
	bl loc_038001EC	; 038021A6
	b loc_038021BE	; 038021AA
loc_038021AC:
	ldr r1,[sp,#0x24]	; 038021AC
	ldr r0,[pool_038021F8]	; 038021AE
	str r1,[r0,#0x0]	; 038021B0
	b loc_038021BE	; 038021B2
loc_038021B4:
	ldr r0,[pool_038021FC]	; 038021B4
	ldr r1,[sp,#0x24]	; 038021B6
	ldr r2,[pool_03802200]	; 038021B8
	bl loc_03802208	; 038021BA
loc_038021BE:
	ldr r5,[sp,#0x1c]	; 038021BE
loc_038021C0:
	cmp r5,#0x0	; 038021C0
	beq loc_038021C6	; 038021C2
	b loc_03801F6C	; 038021C4
loc_038021C6:
	ldr r0,[pool_038021F8]	; 038021C6
	ldr r1,[r0,#0x0]	; 038021C8
	ldr r0,[r1,#0x0]	; 038021CA
	add r0,r0,#0x1	; 038021CC
	str r0,[r1,#0x0]	; 038021CE
loc_038021D0:
	ldr r0,[pool_03802204]	; 038021D0
	add r1,sp,#0x18	; 038021D2
	mov r2,#0x0	; 038021D4
	bl loc_037FE678	; 038021D6
	cmp r0,#0x0	; 038021DA
	beq loc_038021E0	; 038021DC
	b loc_03801F68	; 038021DE
loc_038021E0:
	add sp,#0x34	; 038021E0
	pop {r4,r5,r6,r7}	; 038021E2
	pop {r3}	; 038021E4
	bx r3	; 038021E6
pool_038021E8:
loc_038021E8:
	.word 0x00FFFFFF	; 038021E8
pool_038021EC:
loc_038021EC:
	.word 0x0000FFFF	; 038021EC
pool_038021F0:
loc_038021F0:
	.word 0x003FFFFF	; 038021F0
pool_038021F4:
loc_038021F4:
	.word 0x07FFFFFF	; 038021F4
pool_038021F8:
loc_038021F8:
	.word P2_BssStart + 0xD80	; 038021F8
pool_038021FC:
loc_038021FC:
	.word 0x03806500	; 038021FC
pool_03802200:
loc_03802200:
	.word 0x00001180	; 03802200
pool_03802204:
loc_03802204:
	.word 0x03807680	; 03802204

; ===== function loc_03802208 =====
loc_03802208:
	bx pc	; 03802208
	.byte 0xC0, 0x46	; 0380220C
.arm

; ===== function loc_0380220C =====
loc_0380220C:
	ldr pc,[pool_03802210]	; 0380220C
pool_03802210:
loc_03802210:
	.word loc_037FF754	; 03802210
.thumb

; ===== function loc_03802214 =====
loc_03802214:
	push {lr}	; 03802214
	sub sp,#0x4	; 03802216
	ldr r0,[pool_03802234]	; 03802218
	ldr r1,[pool_03802238]	; 0380221A
	mov r2,#0x8	; 0380221C
	bl loc_037FE74C	; 0380221E
	bl loc_03801F10	; 03802222
	mov r1,#0x0	; 03802226
	ldr r0,[pool_0380223C]	; 03802228
	str r1,[r0,#0x0]	; 0380222A
	add sp,#0x4	; 0380222C
	pop {r3}	; 0380222E
	bx r3	; 03802230
	.byte 0xC0, 0x46	; 03802234
pool_03802234:
loc_03802234:
	.word 0x03807680	; 03802234
pool_03802238:
loc_03802238:
	.word 0x03807694	; 03802238
pool_0380223C:
loc_0380223C:
	.word P2_BssStart + 0xD80	; 0380223C

; ===== function loc_03802240 =====
loc_03802240:
	ldr r3,[pool_03802244]	; 03802240
	bx r3	; 03802242
pool_03802244:
loc_03802244:
	.word loc_038023F8 + 1	; 03802244

; ===== function loc_03802248 =====
P2_IrqHandler_03802248:
	push {r4,r5,r6,r7,lr}	; 03802248
	sub sp,#0x4	; 0380224A
	ldr r5,[pool_03802304]	; 0380224C
	mov r0,#0x3	; 0380224E
	mvn r6,r0	; 03802250
	mov r7,#0x2	; 03802252
	mvn r4,r7	; 03802254
loc_03802256:
	ldrh r1,[r5,#0x0]	; 03802256
	ldr r0,[pool_03802308]	; 03802258
	and r1,r0	; 0380225A
	cmp r1,#0x0	; 0380225C
	beq loc_0380226C	; 0380225E
	ldrh r1,[r5,#0x0]	; 03802260
	ldr r0,[pool_0380230C]	; 03802262
	orr r1,r0	; 03802264
	strh r1,[r5,#0x0]	; 03802266
	add r0,r4,#0x0	; 03802268
	b loc_0380228E	; 0380226A
loc_0380226C:
	bl loc_037FE0D0	; 0380226C
	ldrh r2,[r5,#0x0]	; 03802270
	ldr r1,[pool_03802310]	; 03802272
	and r2,r1	; 03802274
	cmp r2,#0x0	; 03802276
	beq loc_03802282	; 03802278
	bl loc_037FE0F4	; 0380227A
	add r0,r6,#0x0	; 0380227E
	b loc_0380228E	; 03802280
loc_03802282:
	ldr r1,[pool_03802314]	; 03802282
	ldr r1,[r1,#0x0]	; 03802284
	str r1,[sp,#0x0]	; 03802286
	bl loc_037FE0F4	; 03802288
	mov r0,#0x0	; 0380228C
loc_0380228E:
	mov r1,#0x3	; 0380228E
	mvn r1,r1	; 03802290
	cmp r0,r1	; 03802292
	beq loc_038022FC	; 03802294
	mvn r1,r7	; 03802296
	cmp r0,r1	; 03802298
	beq loc_03802256	; 0380229A
	ldr r2,[sp,#0x0]	; 0380229C
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 0380229E
	lsr r0,r0,#0x1b	; 038022A0
	cmp r0,#0x0	; 038022A2
	beq loc_03802256	; 038022A4
	lsl r3,r0,#0x2	; 038022A6
	ldr r1,[pool_03802318]	; 038022A8
	ldr r3,[r1,r3]	; 038022AA
	cmp r3,#0x0	; 038022AC
	beq loc_038022BC	; 038022AE
	lsr r1,r2,#0x6	; 038022B0
	lsl r2,r2,#0x1a	; 038022B2
	lsr r2,r2,#0x1f	; 038022B4
	bl loc_03805474	; 038022B6
	b loc_03802256	; 038022BA
loc_038022BC:
	lsl r0,r2,#0x1a	; 038022BC
	lsr r0,r0,#0x1f	; 038022BE
	cmp r0,#0x0	; 038022C0
	bne loc_03802256	; 038022C2
	mov r0,#0x20	; 038022C4
	orr r2,r0	; 038022C6
	str r2,[sp,#0x0]	; 038022C8
	ldrh r1,[r5,#0x0]	; 038022CA
	ldr r0,[pool_03802308]	; 038022CC
	and r1,r0	; 038022CE
	cmp r1,#0x0	; 038022D0
	beq loc_038022DE	; 038022D2
	ldrh r1,[r5,#0x0]	; 038022D4
	ldr r0,[pool_0380230C]	; 038022D6
	orr r1,r0	; 038022D8
	strh r1,[r5,#0x0]	; 038022DA
	b loc_03802256	; 038022DC
loc_038022DE:
	bl loc_037FE0D0	; 038022DE
	ldrh r1,[r5,#0x0]	; 038022E2
	and r1,r7	; 038022E4
	cmp r1,#0x0	; 038022E6
	beq loc_038022F0	; 038022E8
	bl loc_037FE0F4	; 038022EA
	b loc_03802256	; 038022EE
loc_038022F0:
	ldr r2,[sp,#0x0]	; 038022F0
	ldr r1,[pool_0380231C]	; 038022F2
	str r2,[r1,#0x0]	; 038022F4
	bl loc_037FE0F4	; 038022F6
	b loc_03802256	; 038022FA
loc_038022FC:
	add sp,#0x4	; 038022FC
	pop {r4,r5,r6,r7}	; 038022FE
	pop {r3}	; 03802300
	bx r3	; 03802302
pool_03802304:
loc_03802304:
	.word REG_IPC_FIFO_CR	; 03802304
pool_03802308:
loc_03802308:
	.word 0x00004000	; 03802308
pool_0380230C:
loc_0380230C:
	.word 0x0000C000	; 0380230C
pool_03802310:
loc_03802310:
	.word 0x00000100	; 03802310
pool_03802314:
loc_03802314:
	.word REG_IPC_FIFO_RX	; 03802314
pool_03802318:
loc_03802318:
	.word P2_PxiReceiveCallbacks	; 03802318
pool_0380231C:
loc_0380231C:
	.word REG_IPC_FIFO_TX	; 0380231C

; ===== function loc_03802320 =====
loc_03802320:
	push {r4,lr}	; 03802320
	sub sp,#0x8	; 03802322
	ldr r3,[sp,#0x0]	; 03802324
	mov r4,#0x1f	; 03802326
	bic r3,r4	; 03802328
	and r0,r4	; 0380232A
	orr r3,r0	; 0380232C
	str r3,[sp,#0x0]	; 0380232E
	mov r0,#0x20	; 03802330
	bic r3,r0	; 03802332
	mov r0,#0x1	; 03802334
	and r2,r0	; 03802336
	lsl r0,r2,#0x5	; 03802338
	orr r3,r0	; 0380233A
	str r3,[sp,#0x0]	; 0380233C
	mov r0,#0x3f	; 0380233E
	and r3,r0	; 03802340
	ldr r0,[pool_03802394]	; 03802342
	and r1,r0	; 03802344
	lsl r0,r1,#0x6	; 03802346
	orr r3,r0	; 03802348
	str r3,[sp,#0x0]	; 0380234A
	ldr r2,[pool_03802398]	; 0380234C
	ldrh r1,[r2,#0x0]	; 0380234E
	ldr r0,[pool_0380239C]	; 03802350
	and r1,r0	; 03802352
	cmp r1,#0x0	; 03802354
	beq loc_03802366	; 03802356
	ldrh r1,[r2,#0x0]	; 03802358
	ldr r0,[pool_038023A0]	; 0380235A
	orr r1,r0	; 0380235C
	strh r1,[r2,#0x0]	; 0380235E
	mov r0,#0x0	; 03802360
	mvn r0,r0	; 03802362
	b loc_0380238C	; 03802364
loc_03802366:
	bl loc_037FE0D0	; 03802366
	ldr r1,[pool_03802398]	; 0380236A
	ldrh r2,[r1,#0x0]	; 0380236C
	mov r1,#0x2	; 0380236E
	and r2,r1	; 03802370
	cmp r2,#0x0	; 03802372
	beq loc_03802380	; 03802374
	bl loc_037FE0F4	; 03802376
	mov r0,#0x1	; 0380237A
	mvn r0,r0	; 0380237C
	b loc_0380238C	; 0380237E
loc_03802380:
	ldr r2,[sp,#0x0]	; 03802380
	ldr r1,[pool_038023A4]	; 03802382
	str r2,[r1,#0x0]	; 03802384
	bl loc_037FE0F4	; 03802386
	mov r0,#0x0	; 0380238A
loc_0380238C:
	add sp,#0x8	; 0380238C
	pop {r4}	; 0380238E
	pop {r3}	; 03802390
	bx r3	; 03802392
pool_03802394:
loc_03802394:
	.word 0x03FFFFFF	; 03802394
pool_03802398:
loc_03802398:
	.word REG_IPC_FIFO_CR	; 03802398
pool_0380239C:
loc_0380239C:
	.word 0x00004000	; 0380239C
pool_038023A0:
loc_038023A0:
	.word 0x0000C000	; 038023A0
pool_038023A4:
loc_038023A4:
	.word REG_IPC_FIFO_TX	; 038023A4

; ===== function loc_038023A8 =====
loc_038023A8:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P2_SetPxiReceiveCallback
	push {r4,r5,lr}	; 038023A8
	sub sp,#0x4	; 038023AA
	add r5,r0,#0x0	; 038023AC
	add r4,r1,#0x0	; 038023AE
	bl loc_037FE0D0	; 038023B0
	lsl r2,r5,#0x2	; 038023B4
	ldr r1,[pool_038023EC]	; 038023B6
	str r4,[r1,r2]	; 038023B8
	cmp r4,#0x0	; 038023BA
	beq loc_038023D0	; 038023BC
	ldr r2,[pool_038023F0]	; 038023BE
	ldr r1,[pool_038023F4]	; 038023C0
	add r1,r2,r1	; 038023C2
	ldr r3,[r1,#0x0]	; 038023C4
	mov r2,#0x1	; 038023C6
	lsl r2,r5	; 038023C8
	orr r3,r2	; 038023CA
	str r3,[r1,#0x0]	; 038023CC
	b loc_038023E0	; 038023CE
loc_038023D0:
	ldr r2,[pool_038023F0]	; 038023D0
	ldr r1,[pool_038023F4]	; 038023D2
	add r1,r2,r1	; 038023D4
	ldr r3,[r1,#0x0]	; 038023D6
	mov r2,#0x1	; 038023D8
	lsl r2,r5	; 038023DA
	bic r3,r2	; 038023DC
	str r3,[r1,#0x0]	; 038023DE
loc_038023E0:
	bl loc_037FE0F4	; 038023E0
	add sp,#0x4	; 038023E4
	pop {r4,r5}	; 038023E6
	pop {r3}	; 038023E8
	bx r3	; 038023EA
.endfunc
pool_038023EC:
loc_038023EC:
	.word P2_PxiReceiveCallbacks	; 038023EC
pool_038023F0:
loc_038023F0:
	.word FirmwareSystemWorkAddress	; 038023F0
pool_038023F4:
loc_038023F4:
	.word SystemWorkPxiArm7AvailableOffset	; 038023F4

; ===== function loc_038023F8 =====
loc_038023F8:
	push {r4,r5,r6,r7,lr}	; 038023F8
	sub sp,#0x4	; 038023FA
	bl loc_037FE0D0	; 038023FC
	add r5,r0,#0x0	; 03802400
	ldr r0,[pool_0380246C]	; 03802402
	ldrh r1,[r0,#0x0]	; 03802404
	cmp r1,#0x0	; 03802406
	bne loc_0380245C	; 03802408
	mov r1,#0x1	; 0380240A
	strh r1,[r0,#0x0]	; 0380240C
	mov r3,#0x0	; 0380240E
	ldr r1,[pool_03802470]	; 03802410
	ldr r0,[pool_03802474]	; 03802412
	str r3,[r1,r0]	; 03802414
	add r2,r3,#0x0	; 03802416
	ldr r0,[pool_03802478]	; 03802418
loc_0380241A:
	lsl r1,r3,#0x2	; 0380241A
	str r2,[r0,r1]	; 0380241C
	add r3,r3,#0x1	; 0380241E
	cmp r3,#PxiFifoChannelCount	; 03802420
	blt loc_0380241A	; 03802422
	ldr r0,[pool_0380247C]	; 03802424
	ldr r1,[pool_03802480]	; 03802426
	bl loc_037FDF04	; 03802428
	ldr r0,[pool_0380247C]	; 0380242C
	bl loc_037FDE80	; 0380242E
	ldr r1,[pool_03802484]	; 03802432
	ldr r0,[pool_03802488]	; 03802434
	strh r1,[r0,#0x0]	; 03802436
	mov r4,#0x8	; 03802438
	add r7,r4,#0x0	; 0380243A
	ldr r6,[pool_0380248C]	; 0380243C
	b loc_03802458	; 0380243E
loc_03802440:
	lsl r0,r4,#0x8	; 03802440
	strh r0,[r6,#0x0]	; 03802442
	ldr r0,[pool_03802490]	; 03802444
	bl loc_037FF5B8	; 03802446
	ldrh r1,[r6,#0x0]	; 0380244A
	mov r0,#0xf	; 0380244C
	and r1,r0	; 0380244E
	cmp r1,r4	; 03802450
	beq loc_03802456	; 03802452
	add r4,r7,#0x0	; 03802454
loc_03802456:
	sub r4,r4,#0x1	; 03802456
loc_03802458:
	cmp r4,#0x0	; 03802458
	bge loc_03802440	; 0380245A
loc_0380245C:
	add r0,r5,#0x0	; 0380245C
	bl loc_037FE0F4	; 0380245E
	add sp,#0x4	; 03802462
	pop {r4,r5,r6,r7}	; 03802464
	pop {r3}	; 03802466
	bx r3	; 03802468
	.byte 0xC0, 0x46	; 0380246C
pool_0380246C:
loc_0380246C:
	.word P2_BssStart + 0x1F38	; 0380246C
pool_03802470:
loc_03802470:
	.word FirmwareSystemWorkAddress	; 03802470
pool_03802474:
loc_03802474:
	.word SystemWorkPxiArm7AvailableOffset	; 03802474
pool_03802478:
loc_03802478:
	.word P2_PxiReceiveCallbacks	; 03802478
pool_0380247C:
loc_0380247C:
	.word 0x00040000	; 0380247C
pool_03802480:
loc_03802480:
	.word P2_IrqHandler_03802248 + 1	; 03802480
pool_03802484:
loc_03802484:
	.word 0x0000C408	; 03802484
pool_03802488:
loc_03802488:
	.word REG_IPC_FIFO_CR	; 03802488
pool_0380248C:
loc_0380248C:
	.word REG_IPC_SYNC	; 0380248C
pool_03802490:
loc_03802490:
	.word 0x000003E8	; 03802490
; 采样 X/Y、调试键与合盖输入；将合盖位转换为共享状态 bit15。
; Sample X/Y, debug and hinge inputs; publish the hinge bit as shared bit15.
.func P2_PublishExtendedKeyState
	push {r4,lr}	; 03802494
	mov r4,#0x0	; 03802496
	ldr r0,[pool_038024C0]	; 03802498
	bl loc_03802534	; 0380249A
	ldr r0,[pool_038024C4]	; 0380249E
	ldrh r2,[r0,#0x0]	; 038024A0
	mov r0,#KEYXY_LID_CLOSED	; 038024A2
	add r1,r2,#0x0	; 038024A4
	and r1,r0	; 038024A6
	cmp r1,#0x0	; 038024A8
	beq loc_038024AE	; 038024AA
	ldr r4,[pool_038024C0]	; 038024AC
loc_038024AE:
	mov r0,#0xb	; 038024AE
	and r2,r0	; 038024B0
	lsl r1,r2,#0xa	; 038024B2
	orr r1,r4	; 038024B4
	ldr r0,[pool_038024C8]	; 038024B6
	strh r1,[r0,#0x0]	; 038024B8
	pop {r4}	; 038024BA
	pop {r3}	; 038024BC
	bx r3	; 038024BE
.endfunc
pool_038024C0:
loc_038024C0:
; 此 0x8000 常量也传给 RCNT 模式设置；原代码共用同一槽。
; The same 0x8000 literal also selects RCNT GPIO mode in the original code.
	.word SystemWorkLidClosedMask	; 038024C0
pool_038024C4:
loc_038024C4:
	.word REG_KEYXY	; 038024C4
pool_038024C8:
loc_038024C8:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 038024C8

; ===== function loc_038024CC =====
loc_038024CC:
	push {r4,r5,lr}	; 038024CC
	sub sp,#0xc	; 038024CE
	bl loc_037FED24	; 038024D0
	cmp r0,#0x0	; 038024D4
	beq loc_038024E0	; 038024D6
	bl loc_037FF02C	; 038024D8
	cmp r0,#0x0	; 038024DC
	bne loc_038024E4	; 038024DE
loc_038024E0:
	mov r0,#0x0	; 038024E0
	b loc_0380251C	; 038024E2
loc_038024E4:
	ldr r0,[pool_03802524]	; 038024E4
	ldr r0,[r0,#0x0]	; 038024E6
	cmp r0,#0x0	; 038024E8
	beq loc_038024F0	; 038024EA
	mov r0,#0x0	; 038024EC
	b loc_0380251C	; 038024EE
loc_038024F0:
	ldr r0,[pool_03802528]	; 038024F0
	bl loc_037FF024	; 038024F2
	bl loc_037FEC58	; 038024F6
	add r2,r0,#0x0	; 038024FA
	ldr r0,[pool_0380252C]	; 038024FC
	str r0,[sp,#0x4]	; 038024FE
	mov r5,#0x0	; 03802500
	str r5,[sp,#0x8]	; 03802502
	ldr r3,[pool_03802530]	; 03802504
	str r5,[sp,#0x0]	; 03802506
	ldr r0,[pool_03802528]	; 03802508
	add r4,r2,r3	; 0380250A
	lsl r2,r1,#0	; 0380250C
	adc r2,r5	; 0380250E
	add r1,r4,#0x0	; 03802510
	bl loc_037FEEA8	; 03802512
	mov r0,#0x1	; 03802516
	ldr r1,[pool_03802524]	; 03802518
	str r0,[r1,#0x0]	; 0380251A
loc_0380251C:
	add sp,#0xc	; 0380251C
	pop {r4,r5}	; 0380251E
	pop {r3}	; 03802520
	bx r3	; 03802522
pool_03802524:
loc_03802524:
	.word P2_BssStart + 0x1FBC	; 03802524
pool_03802528:
loc_03802528:
	.word 0x0380773C	; 03802528
pool_0380252C:
loc_0380252C:
	.word P2_PublishExtendedKeyState + 1	; 0380252C
pool_03802530:
loc_03802530:
	.word 0x0000082E	; 03802530

; ===== function loc_03802534 =====
loc_03802534:
	add r1,r0,#0x0	; 03802534
	ldr r0,[pool_03802540]	; 03802536
	lsl r1,r1,#0x10	; 03802538
	lsr r1,r1,#0x10	; 0380253A
	ldr r3,[pool_03802544]	; 0380253C
	bx r3	; 0380253E
pool_03802540:
loc_03802540:
	.word 0x0000C000	; 03802540
pool_03802544:
loc_03802544:
	.word loc_03802548 + 1	; 03802544
loc_03802548:
	mvn r3,r0	; 03802548
	ldr r2,[pool_03802558]	; 0380254A
	ldrh r0,[r2,#0x0]	; 0380254C
	and r3,r0	; 0380254E
	orr r1,r3	; 03802550
	strh r1,[r2,#0x0]	; 03802552
	bx lr	; 03802554
	.byte 0xC0, 0x46	; 03802558
pool_03802558:
loc_03802558:
	.word REG_RCNT_ARM7	; 03802558

; ===== function loc_0380255C =====
loc_0380255C:
	push {lr}	; 0380255C
	sub sp,#0x4	; 0380255E
	add r0,sp,#0x0	; 03802560
	bl loc_03802CE0	; 03802562
	add r0,sp,#0x0	; 03802566
	add r0,#0x2	; 03802568
	bl loc_03802CA0	; 0380256A
	add r0,sp,#0x0	; 0380256E
	ldrh r1,[r0,#0x0]	; 03802570
	lsl r2,r1,#0x18	; 03802572
	lsr r2,r2,#0x1f	; 03802574
	cmp r2,#0x0	; 03802576
	bne loc_0380258C	; 03802578
	lsl r1,r1,#0x19	; 0380257A
	lsr r1,r1,#0x1f	; 0380257C
	cmp r1,#0x0	; 0380257E
	bne loc_0380258C	; 03802580
	ldrh r0,[r0,#0x2]	; 03802582
	lsl r0,r0,#0x18	; 03802584
	lsr r0,r0,#0x1f	; 03802586
	cmp r0,#0x0	; 03802588
	beq loc_0380259E	; 0380258A
loc_0380258C:
	add r1,sp,#0x0	; 0380258C
	ldrh r2,[r1,#0x0]	; 0380258E
	mov r0,#0x1	; 03802590
	bic r2,r0	; 03802592
	orr r2,r0	; 03802594
	strh r2,[r1,#0x0]	; 03802596
	add r0,sp,#0x0	; 03802598
	bl loc_03802CC0	; 0380259A
loc_0380259E:
	mov r0,#0x1	; 0380259E
	bl loc_03802E10	; 038025A0
	add sp,#0x4	; 038025A4
	pop {r3}	; 038025A6
	bx r3	; 038025A8
	.byte 0x00, 0x00	; 038025AC
	ldr r0,[pool_038025B4]	; 038025AC
	ldr r3,[pool_038025B8]	; 038025AE
	bx r3	; 038025B0
	.byte 0xC0, 0x46	; 038025B4
pool_038025B4:
loc_038025B4:
	.word 0x03807988	; 038025B4
pool_038025B8:
loc_038025B8:
	.word loc_037FE2F4 + 1	; 038025B8

; ===== function loc_038025BC =====
P2_ThreadEntry_038025BC:
	push {r4,r5,r6,r7,lr}	; 038025BC
	sub sp,#0xc	; 038025BE
	add r4,sp,#0x0	; 038025C0
	ldrh r1,[r4,#0x2]	; 038025C2
	mov r0,#0x10	; 038025C4
	bic r1,r0	; 038025C6
	strh r1,[r4,#0x2]	; 038025C8
	ldrh r1,[r4,#0x2]	; 038025CA
	mov r0,#0x20	; 038025CC
	bic r1,r0	; 038025CE
	strh r1,[r4,#0x2]	; 038025D0
	ldr r6,[pool_03802650]	; 038025D2
	mov r7,#0xf	; 038025D4
loc_038025D6:
	ldr r0,[pool_03802654]	; 038025D6
	bl loc_037FE33C	; 038025D8
	ldr r0,[r6,#0x1c]	; 038025DC
	cmp r0,#0x0	; 038025DE
	bne loc_038025D6	; 038025E0
	add r0,sp,#0x0	; 038025E2
	bl loc_03802CE0	; 038025E4
	ldrh r1,[r4,#0x0]	; 038025E8
	lsl r0,r1,#0x1b	; 038025EA
	lsr r2,r0,#0x1f	; 038025EC
	ldrh r0,[r4,#0x2]	; 038025EE
	lsl r3,r0,#0x1b	; 038025F0
	lsr r3,r3,#0x1f	; 038025F2
	sub r2,r2,r3	; 038025F4
	cmp r2,#0x1	; 038025F6
	beq loc_03802608	; 038025F8
	lsl r1,r1,#0x1a	; 038025FA
	lsr r1,r1,#0x1f	; 038025FC
	lsl r0,r0,#0x1a	; 038025FE
	lsr r0,r0,#0x1f	; 03802600
	sub r0,r1,r0	; 03802602
	cmp r0,#0x1	; 03802604
	bne loc_03802648	; 03802606
loc_03802608:
	add r0,sp,#0x4	; 03802608
	bl loc_03802CA0	; 0380260A
	mov r5,#0x0	; 0380260E
	ldrh r0,[r4,#0x0]	; 03802610
	lsl r0,r0,#0x1b	; 03802612
	lsr r0,r0,#0x1f	; 03802614
	cmp r0,#0x0	; 03802616
	beq loc_03802624	; 03802618
	mov r0,#0x1	; 0380261A
	orr r5,r0	; 0380261C
	ldrh r0,[r4,#0x4]	; 0380261E
	bic r0,r7	; 03802620
	strh r0,[r4,#0x4]	; 03802622
loc_03802624:
	ldrh r0,[r4,#0x0]	; 03802624
	lsl r0,r0,#0x1a	; 03802626
	lsr r0,r0,#0x1f	; 03802628
	cmp r0,#0x0	; 0380262A
	beq loc_0380263A	; 0380262C
	mov r0,#0x2	; 0380262E
	orr r5,r0	; 03802630
	ldrh r1,[r4,#0x4]	; 03802632
	mov r0,#0x40	; 03802634
	bic r1,r0	; 03802636
	strh r1,[r4,#0x4]	; 03802638
loc_0380263A:
	add r0,sp,#0x4	; 0380263A
	bl loc_03802C80	; 0380263C
	mov r0,#0x30	; 03802640
	add r1,r5,#0x0	; 03802642
	bl loc_0380284C	; 03802644
loc_03802648:
	ldrh r0,[r4,#0x0]	; 03802648
	strh r0,[r4,#0x2]	; 0380264A
	b loc_038025D6	; 0380264C
	.byte 0xC0, 0x46	; 03802650
pool_03802650:
loc_03802650:
	.word 0x038078EC	; 03802650
pool_03802654:
loc_03802654:
	.word 0x03807988	; 03802654

; ===== function loc_03802658 =====
P2_ThreadEntry_03802658:
	push {r4,r5,r6,r7,lr}	; 03802658
	sub sp,#0x4	; 0380265A
	ldr r5,[pool_03802840]	; 0380265C
	add r6,r5,#0x4	; 0380265E
	mov r7,#0x0	; 03802660
	ldr r4,[pool_03802844]	; 03802662
loc_03802664:
	ldr r0,[pool_03802848]	; 03802664
	add r1,sp,#0x0	; 03802666
	mov r2,#0x1	; 03802668
	bl loc_037FE678	; 0380266A
	ldrh r0,[r4,#0x20]	; 0380266E
	cmp r0,#0x10	; 03802670
	bgt loc_0380268E	; 03802672
	cmp r0,#0x10	; 03802674
	bge loc_038026F8	; 03802676
	cmp r0,#0x1	; 03802678
	ble loc_0380267E	; 0380267A
	b loc_03802834	; 0380267C
loc_0380267E:
	cmp r0,#0x0	; 0380267E
	bge loc_03802684	; 03802680
	b loc_03802834	; 03802682
loc_03802684:
	cmp r0,#0x0	; 03802684
	beq loc_038026D2	; 03802686
	cmp r0,#0x1	; 03802688
	beq loc_038026E2	; 0380268A
	b loc_03802834	; 0380268C
loc_0380268E:
	add r1,r0,#0x0	; 0380268E
	sub r1,#0x14	; 03802690
	cmp r1,#0x15	; 03802692
	bls loc_03802698	; 03802694
	b loc_03802834	; 03802696
loc_03802698:
	add r1,r1,r1	; 03802698
P2_SwitchIndexPC_03802698:
	add r1,pc	; 0380269A
	ldrh r1,[r1,#(P2_SwitchTable_03802698 - (P2_SwitchIndexPC_03802698 + 4))]	; 0380269C
	lsl r1,r1,#0x10	; 0380269E
	asr r1,r1,#0x10	; 038026A0
P2_SwitchTargetPC_03802698:
	add r1,pc	; 038026A2
	bx r1	; 038026A4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802698:
	.halfword (loc_0380270A + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_0380272C + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_0380274E + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802760 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802772 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802784 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802796 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802834 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_038027A8 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_038027CA + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_038027EC + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_038027FE + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802810 + 1) - (P2_SwitchTargetPC_03802698 + 4)
	.halfword (loc_03802822 + 1) - (P2_SwitchTargetPC_03802698 + 4)
P2_SwitchTable_03802698End:
loc_038026D2:
	bl loc_03802EB8	; 038026D2
	str r7,[r4,#0x1c]	; 038026D6
	add r0,r7,#0x0	; 038026D8
	add r1,r7,#0x0	; 038026DA
	bl loc_0380284C	; 038026DC
	b loc_03802664	; 038026E0
loc_038026E2:
	ldrh r0,[r5,#0x0]	; 038026E2
	lsl r0,r0,#0x1e	; 038026E4
	lsr r0,r0,#0x1f	; 038026E6
	bl loc_03802E10	; 038026E8
	str r7,[r4,#0x1c]	; 038026EC
	mov r0,#0x1	; 038026EE
	add r1,r7,#0x0	; 038026F0
	bl loc_0380284C	; 038026F2
	b loc_03802664	; 038026F6
loc_038026F8:
	add r0,r5,#0x0	; 038026F8
	bl loc_03802DF0	; 038026FA
	str r7,[r4,#0x1c]	; 038026FE
	mov r0,#0x10	; 03802700
	add r1,r7,#0x0	; 03802702
	bl loc_0380284C	; 03802704
	b loc_03802664	; 03802708
loc_0380270A:
	add r0,r5,#0x4	; 0380270A
	bl loc_03802D9C	; 0380270C
	cmp r0,#0x0	; 03802710
	bne loc_03802720	; 03802712
	str r7,[r4,#0x1c]	; 03802714
	mov r0,#0x14	; 03802716
	mov r1,#0x2	; 03802718
	bl loc_0380284C	; 0380271A
	b loc_03802664	; 0380271E
loc_03802720:
	str r7,[r4,#0x1c]	; 03802720
	mov r0,#0x14	; 03802722
	add r1,r7,#0x0	; 03802724
	bl loc_0380284C	; 03802726
	b loc_03802664	; 0380272A
loc_0380272C:
	add r0,r6,#0x0	; 0380272C
	bl loc_03802D34	; 0380272E
	cmp r0,#0x0	; 03802732
	bne loc_03802742	; 03802734
	str r7,[r4,#0x1c]	; 03802736
	mov r0,#0x15	; 03802738
	mov r1,#0x2	; 0380273A
	bl loc_0380284C	; 0380273C
	b loc_03802664	; 03802740
loc_03802742:
	str r7,[r4,#0x1c]	; 03802742
	mov r0,#0x15	; 03802744
	add r1,r7,#0x0	; 03802746
	bl loc_0380284C	; 03802748
	b loc_03802664	; 0380274C
loc_0380274E:
	add r0,r5,#0x0	; 0380274E
	bl loc_03802CE0	; 03802750
	str r7,[r4,#0x1c]	; 03802754
	mov r0,#0x16	; 03802756
	add r1,r7,#0x0	; 03802758
	bl loc_0380284C	; 0380275A
	b loc_03802664	; 0380275E
loc_03802760:
	add r0,r5,#0x2	; 03802760
	bl loc_03802CA0	; 03802762
	str r7,[r4,#0x1c]	; 03802766
	mov r0,#0x17	; 03802768
	add r1,r7,#0x0	; 0380276A
	bl loc_0380284C	; 0380276C
	b loc_03802664	; 03802770
loc_03802772:
	add r0,r5,#0x4	; 03802772
	bl loc_03802C60	; 03802774
	str r7,[r4,#0x1c]	; 03802778
	mov r0,#0x18	; 0380277A
	add r1,r7,#0x0	; 0380277C
	bl loc_0380284C	; 0380277E
	b loc_03802664	; 03802782
loc_03802784:
	add r0,r5,#0x4	; 03802784
	bl loc_03802C20	; 03802786
	str r7,[r4,#0x1c]	; 0380278A
	mov r0,#0x19	; 0380278C
	add r1,r7,#0x0	; 0380278E
	bl loc_0380284C	; 03802790
	b loc_03802664	; 03802794
loc_03802796:
	add r0,r5,#0x0	; 03802796
	bl loc_03802DD0	; 03802798
	str r7,[r4,#0x1c]	; 0380279C
	mov r0,#0x20	; 0380279E
	add r1,r7,#0x0	; 038027A0
	bl loc_0380284C	; 038027A2
	b loc_03802664	; 038027A6
loc_038027A8:
	add r0,r6,#0x0	; 038027A8
	bl loc_03802D68	; 038027AA
	cmp r0,#0x0	; 038027AE
	bne loc_038027BE	; 038027B0
	str r7,[r4,#0x1c]	; 038027B2
	mov r0,#0x24	; 038027B4
	mov r1,#0x2	; 038027B6
	bl loc_0380284C	; 038027B8
	b loc_03802664	; 038027BC
loc_038027BE:
	str r7,[r4,#0x1c]	; 038027BE
	mov r0,#0x24	; 038027C0
	add r1,r7,#0x0	; 038027C2
	bl loc_0380284C	; 038027C4
	b loc_03802664	; 038027C8
loc_038027CA:
	add r0,r6,#0x0	; 038027CA
	bl loc_03802D00	; 038027CC
	cmp r0,#0x0	; 038027D0
	bne loc_038027E0	; 038027D2
	str r7,[r4,#0x1c]	; 038027D4
	mov r0,#0x25	; 038027D6
	mov r1,#0x2	; 038027D8
	bl loc_0380284C	; 038027DA
	b loc_03802664	; 038027DE
loc_038027E0:
	str r7,[r4,#0x1c]	; 038027E0
	mov r0,#0x25	; 038027E2
	add r1,r7,#0x0	; 038027E4
	bl loc_0380284C	; 038027E6
	b loc_03802664	; 038027EA
loc_038027EC:
	add r0,r5,#0x0	; 038027EC
	bl loc_03802CC0	; 038027EE
	str r7,[r4,#0x1c]	; 038027F2
	mov r0,#0x26	; 038027F4
	add r1,r7,#0x0	; 038027F6
	bl loc_0380284C	; 038027F8
	b loc_03802664	; 038027FC
loc_038027FE:
	add r0,r5,#0x2	; 038027FE
	bl loc_03802C80	; 03802800
	str r7,[r4,#0x1c]	; 03802804
	mov r0,#0x27	; 03802806
	add r1,r7,#0x0	; 03802808
	bl loc_0380284C	; 0380280A
	b loc_03802664	; 0380280E
loc_03802810:
	add r0,r5,#0x4	; 03802810
	bl loc_03802C40	; 03802812
	str r7,[r4,#0x1c]	; 03802816
	mov r0,#0x28	; 03802818
	add r1,r7,#0x0	; 0380281A
	bl loc_0380284C	; 0380281C
	b loc_03802664	; 03802820
loc_03802822:
	add r0,r5,#0x4	; 03802822
	bl loc_03802C00	; 03802824
	str r7,[r4,#0x1c]	; 03802828
	mov r0,#0x29	; 0380282A
	add r1,r7,#0x0	; 0380282C
	bl loc_0380284C	; 0380282E
	b loc_03802664	; 03802832
loc_03802834:
	str r7,[r4,#0x1c]	; 03802834
	mov r1,#0x1	; 03802836
	bl loc_0380284C	; 03802838
	b loc_03802664	; 0380283C
	.byte 0xC0, 0x46	; 03802840
pool_03802840:
loc_03802840:
	.word 0x027FFDE8	; 03802840
pool_03802844:
loc_03802844:
	.word 0x038078EC	; 03802844
pool_03802848:
loc_03802848:
	.word 0x0380776C	; 03802848

; ===== function loc_0380284C =====
loc_0380284C:
	add r2,r0,#0x0	; 0380284C
	mov r0,#0x5	; 0380284E
	lsl r3,r2,#0x8	; 03802850
	ldr r2,[pool_03802868]	; 03802852
	and r3,r2	; 03802854
	ldr r2,[pool_0380286C]	; 03802856
	orr r3,r2	; 03802858
	mov r2,#0xff	; 0380285A
	and r1,r2	; 0380285C
	orr r3,r1	; 0380285E
	add r1,r3,#0x0	; 03802860
	mov r2,#0x0	; 03802862
	ldr r3,[pool_03802870]	; 03802864
	bx r3	; 03802866
pool_03802868:
loc_03802868:
	.word 0x00007F00	; 03802868
pool_0380286C:
loc_0380286C:
	.word 0x00008000	; 0380286C
pool_03802870:
loc_03802870:
	.word loc_03802320 + 1	; 03802870
P2_PxiCallback_03802874:
	push {r4,lr}	; 03802874
	cmp r2,#0x0	; 03802876
	bne loc_03802916	; 03802878
	ldr r0,[pool_0380291C]	; 0380287A
	and r1,r0	; 0380287C
	lsl r0,r1,#0x8	; 0380287E
	lsr r4,r0,#0x10	; 03802880
	cmp r4,#0x10	; 03802882
	bgt loc_0380289C	; 03802884
	cmp r4,#0x10	; 03802886
	bge loc_038028DE	; 03802888
	cmp r4,#0x1	; 0380288A
	bgt loc_0380290E	; 0380288C
	cmp r4,#0x0	; 0380288E
	blt loc_0380290E	; 03802890
	cmp r4,#0x0	; 03802892
	beq loc_038028DE	; 03802894
	cmp r4,#0x1	; 03802896
	beq loc_038028DE	; 03802898
	b loc_0380290E	; 0380289A
loc_0380289C:
	add r0,r4,#0x0	; 0380289C
	sub r0,#0x14	; 0380289E
	cmp r0,#0x15	; 038028A0
	bhi loc_0380290E	; 038028A2
	add r0,r0,r0	; 038028A4
P2_SwitchIndexPC_038028A4:
	add r0,pc	; 038028A6
	ldrh r0,[r0,#(P2_SwitchTable_038028A4 - (P2_SwitchIndexPC_038028A4 + 4))]	; 038028A8
	lsl r0,r0,#0x10	; 038028AA
	asr r0,r0,#0x10	; 038028AC
P2_SwitchTargetPC_038028A4:
	add r0,pc	; 038028AE
	bx r0	; 038028B0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_038028A4:
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_0380290E + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
	.halfword (loc_038028DE + 1) - (P2_SwitchTargetPC_038028A4 + 4)
P2_SwitchTable_038028A4End:
loc_038028DE:
	ldr r0,[pool_03802920]	; 038028DE
	ldr r1,[r0,#0x1c]	; 038028E0
	cmp r1,#0x0	; 038028E2
	beq loc_038028F0	; 038028E4
	add r0,r4,#0x0	; 038028E6
	mov r1,#0x3	; 038028E8
	bl loc_0380284C	; 038028EA
	b loc_03802916	; 038028EE
loc_038028F0:
	mov r1,#0x1	; 038028F0
	str r1,[r0,#0x1c]	; 038028F2
	strh r4,[r0,#0x20]	; 038028F4
	ldr r0,[pool_03802924]	; 038028F6
	mov r1,#0x0	; 038028F8
	add r2,r1,#0x0	; 038028FA
	bl loc_037FE6F0	; 038028FC
	cmp r0,#0x0	; 03802900
	bne loc_03802916	; 03802902
	add r0,r4,#0x0	; 03802904
	mov r1,#0x4	; 03802906
	bl loc_0380284C	; 03802908
	b loc_03802916	; 0380290C
loc_0380290E:
	add r0,r4,#0x0	; 0380290E
	mov r1,#0x1	; 03802910
	bl loc_0380284C	; 03802912
loc_03802916:
	pop {r4}	; 03802916
	pop {r3}	; 03802918
	bx r3	; 0380291A
pool_0380291C:
loc_0380291C:
	.word 0x00007F00	; 0380291C
pool_03802920:
loc_03802920:
	.word P2_BssStart + 0x2170	; 03802920
pool_03802924:
loc_03802924:
	.word 0x0380776C	; 03802924

; ===== function loc_03802928 =====
loc_03802928:
	push {r4,lr}	; 03802928
	sub sp,#0x10	; 0380292A
	add r4,r0,#0x0	; 0380292C
	mov r1,#0x1	; 0380292E
	ldr r0,[pool_038029C4]	; 03802930
	strh r1,[r0,#0x0]	; 03802932
	ldr r0,[pool_038029C8]	; 03802934
	str r1,[r0,#0x1c]	; 03802936
	bl loc_0380255C	; 03802938
	mov r1,#0x0	; 0380293C
	ldr r0,[pool_038029C8]	; 0380293E
	str r1,[r0,#0x1c]	; 03802940
	bl loc_03802240	; 03802942
	mov r0,#0x5	; 03802946
	ldr r1,[pool_038029CC]	; 03802948
	bl P2_SetPxiReceiveCallback	; 0380294A
	ldr r0,[pool_038029D0]	; 0380294E
	ldr r1,[pool_038029D4]	; 03802950
	mov r2,#0x4	; 03802952
	bl loc_037FE74C	; 03802954
	ldr r0,[pool_038029D8]	; 03802958
	str r0,[sp,#0x0]	; 0380295A
	str r4,[sp,#0x4]	; 0380295C
	ldr r0,[pool_038029DC]	; 0380295E
	ldr r1,[pool_038029E0]	; 03802960
	mov r2,#0x0	; 03802962
	ldr r3,[pool_038029E4]	; 03802964
	bl P2_CreateThread	; 03802966
	ldr r0,[pool_038029DC]	; 0380296A
	bl loc_037FE2D0	; 0380296C
	mov r2,#0x0	; 03802970
	ldr r0,[pool_038029E8]	; 03802972
	strh r2,[r0,#0x1c]	; 03802974
	ldr r0,[pool_038029D8]	; 03802976
	str r0,[sp,#0x0]	; 03802978
	sub r0,r4,#0x1	; 0380297A
	str r0,[sp,#0x4]	; 0380297C
	ldr r0,[pool_038029EC]	; 0380297E
	ldr r1,[pool_038029F0]	; 03802980
	ldr r3,[pool_038029F4]	; 03802982
	bl P2_CreateThread	; 03802984
	ldr r0,[pool_038029EC]	; 03802988
	bl loc_037FE2D0	; 0380298A
	bl loc_037FF02C	; 0380298E
	cmp r0,#0x0	; 03802992
	bne loc_0380299A	; 03802994
	bl loc_037FF038	; 03802996
loc_0380299A:
	ldr r0,[pool_038029F4]	; 0380299A
	bl loc_037FF024	; 0380299C
	bl loc_037FEC58	; 038029A0
	add r4,r0,#0x0	; 038029A4
	add r2,r1,#0x0	; 038029A6
	ldr r0,[pool_038029F8]	; 038029A8
	str r0,[sp,#0x4]	; 038029AA
	mov r0,#0x0	; 038029AC
	str r0,[sp,#0x8]	; 038029AE
	ldr r3,[pool_038029FC]	; 038029B0
	str r0,[sp,#0x0]	; 038029B2
	ldr r0,[pool_038029F4]	; 038029B4
	add r1,r4,#0x0	; 038029B6
	bl loc_037FEEA8	; 038029B8
	add sp,#0x10	; 038029BC
	pop {r4}	; 038029BE
	pop {r3}	; 038029C0
	bx r3	; 038029C2
pool_038029C4:
loc_038029C4:
	.word P2_BssStart + 0x1FEC	; 038029C4
pool_038029C8:
loc_038029C8:
	.word P2_BssStart + 0x2170	; 038029C8
pool_038029CC:
loc_038029CC:
	.word P2_PxiCallback_03802874 + 1	; 038029CC
pool_038029D0:
loc_038029D0:
	.word 0x0380776C	; 038029D0
pool_038029D4:
loc_038029D4:
	.word 0x03807780	; 038029D4
pool_038029D8:
loc_038029D8:
	.word 0x00000100	; 038029D8
pool_038029DC:
loc_038029DC:
	.word 0x03807790	; 038029DC
pool_038029E0:
loc_038029E0:
	.word P2_ThreadEntry_03802658 + 1	; 038029E0
pool_038029E4:
loc_038029E4:
	.word 0x03807908	; 038029E4
pool_038029E8:
loc_038029E8:
	.word P2_BssStart + 0x21F0	; 038029E8
pool_038029EC:
loc_038029EC:
	.word 0x03807910	; 038029EC
pool_038029F0:
loc_038029F0:
	.word P2_ThreadEntry_038025BC + 1	; 038029F0
pool_038029F4:
loc_038029F4:
	.word 0x03807A8C	; 038029F4
pool_038029F8:
loc_038029F8:
	.word 0x038025AD	; 038029F8
pool_038029FC:
loc_038029FC:
	.word 0x00001388	; 038029FC

; ===== function loc_03802A00 =====
loc_03802A00:
	push {r4,r5,r6,r7,lr}	; 03802A00
	sub sp,#0x4	; 03802A02
	add r5,r0,#0x0	; 03802A04
	add r7,r1,#0x0	; 03802A06
	add r4,r2,#0x0	; 03802A08
	add r6,r3,#0x0	; 03802A0A
	bl loc_03802A40	; 03802A0C
	add r0,r5,#0x0	; 03802A10
	add r1,r7,#0x0	; 03802A12
	bl loc_03802A4C	; 03802A14
	cmp r5,#0x6	; 03802A18
	beq loc_03802A2A	; 03802A1A
	cmp r5,#0x86	; 03802A1C
	bne loc_03802A32	; 03802A1E
	add r0,r4,#0x0	; 03802A20
	add r1,r6,#0x0	; 03802A22
	bl loc_03802A58	; 03802A24
	b loc_03802A32	; 03802A28
loc_03802A2A:
	add r0,r4,#0x0	; 03802A2A
	add r1,r6,#0x0	; 03802A2C
	bl loc_03802A64	; 03802A2E
loc_03802A32:
	bl loc_03802A70	; 03802A32
	add sp,#0x4	; 03802A36
	pop {r4,r5,r6,r7}	; 03802A38
	pop {r3}	; 03802A3A
	bx r3	; 03802A3C
	.byte 0xC0, 0x46	; 03802A40

; ===== function loc_03802A40 =====
loc_03802A40:
	bx pc	; 03802A40
	.byte 0xC0, 0x46	; 03802A44
.arm

; ===== function loc_03802A44 =====
loc_03802A44:
	ldr pc,[pool_03802A48]	; 03802A44
pool_03802A48:
loc_03802A48:
	.word loc_03802EE4	; 03802A48
.thumb

; ===== function loc_03802A4C =====
loc_03802A4C:
	bx pc	; 03802A4C
	.byte 0xC0, 0x46	; 03802A50
.arm

; ===== function loc_03802A50 =====
loc_03802A50:
	ldr pc,[pool_03802A54]	; 03802A50
pool_03802A54:
loc_03802A54:
	.word loc_03802F58	; 03802A54
.thumb

; ===== function loc_03802A58 =====
loc_03802A58:
	bx pc	; 03802A58
	.byte 0xC0, 0x46	; 03802A5C
.arm

; ===== function loc_03802A5C =====
loc_03802A5C:
	ldr pc,[pool_03802A60]	; 03802A5C
pool_03802A60:
loc_03802A60:
	.word loc_03803058	; 03802A60
.thumb

; ===== function loc_03802A64 =====
loc_03802A64:
	bx pc	; 03802A64
	.byte 0xC0, 0x46	; 03802A68
.arm

; ===== function loc_03802A68 =====
loc_03802A68:
	ldr pc,[pool_03802A6C]	; 03802A68
pool_03802A6C:
loc_03802A6C:
	.word loc_03802FC8	; 03802A6C
.thumb

; ===== function loc_03802A70 =====
loc_03802A70:
	bx pc	; 03802A70
	.byte 0xC0, 0x46	; 03802A74
.arm

; ===== function loc_03802A74 =====
loc_03802A74:
	ldr pc,[pool_03802A78]	; 03802A74
pool_03802A78:
loc_03802A78:
	.word loc_03802F24	; 03802A78
.thumb

; ===== function loc_03802A7C =====
loc_03802A7C:
	ldr r1,[r0,#0x0]	; 03802A7C
	lsl r2,r1,#0x12	; 03802A7E
	lsr r2,r2,#0x1a	; 03802A80
	cmp r2,#0x23	; 03802A82
	bhi loc_03802B18	; 03802A84
	add r3,r2,r2	; 03802A86
P2_SwitchIndexPC_03802A86:
	add r3,pc	; 03802A88
	ldrh r3,[r3,#(P2_SwitchTable_03802A86 - (P2_SwitchIndexPC_03802A86 + 4))]	; 03802A8A
	lsl r3,r3,#0x10	; 03802A8C
	asr r3,r3,#0x10	; 03802A8E
P2_SwitchTargetPC_03802A86:
	add r3,pc	; 03802A90
	bx r3	; 03802A92
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802A86:
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802AF6 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802AF6 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802ADC + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B18 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
	.halfword (loc_03802B10 + 1) - (P2_SwitchTargetPC_03802A86 + 4)
P2_SwitchTable_03802A86End:
loc_03802ADC:
	lsl r3,r1,#0x11	; 03802ADC
	lsr r3,r3,#0x1f	; 03802ADE
	cmp r3,#0x0	; 03802AE0
	beq loc_03802B28	; 03802AE2
	ldr r3,[pool_03802B2C]	; 03802AE4
	and r1,r3	; 03802AE6
	add r2,#0x12	; 03802AE8
	mov r3,#0x3f	; 03802AEA
	and r2,r3	; 03802AEC
	lsl r2,r2,#0x8	; 03802AEE
	orr r1,r2	; 03802AF0
	str r1,[r0,#0x0]	; 03802AF2
	bx lr	; 03802AF4
loc_03802AF6:
	lsl r3,r1,#0x11	; 03802AF6
	lsr r3,r3,#0x1f	; 03802AF8
	cmp r3,#0x0	; 03802AFA
	beq loc_03802B28	; 03802AFC
	ldr r3,[pool_03802B2C]	; 03802AFE
	and r1,r3	; 03802B00
	add r2,#0x18	; 03802B02
	mov r3,#0x3f	; 03802B04
	and r2,r3	; 03802B06
	lsl r2,r2,#0x8	; 03802B08
	orr r1,r2	; 03802B0A
	str r1,[r0,#0x0]	; 03802B0C
	bx lr	; 03802B0E
loc_03802B10:
	ldr r2,[pool_03802B30]	; 03802B10
	orr r1,r2	; 03802B12
	str r1,[r0,#0x0]	; 03802B14
	bx lr	; 03802B16
loc_03802B18:
	ldr r2,[r0,#0x0]	; 03802B18
	ldr r1,[pool_03802B34]	; 03802B1A
	and r2,r1	; 03802B1C
	str r2,[r0,#0x0]	; 03802B1E
	ldr r2,[r0,#0x0]	; 03802B20
	ldr r1,[pool_03802B2C]	; 03802B22
	and r2,r1	; 03802B24
	str r2,[r0,#0x0]	; 03802B26
loc_03802B28:
	bx lr	; 03802B28
	.byte 0xC0, 0x46	; 03802B2C
pool_03802B2C:
loc_03802B2C:
	.word 0xFFFFC0FF	; 03802B2C
pool_03802B30:
loc_03802B30:
	.word 0x00004000	; 03802B30
pool_03802B34:
loc_03802B34:
	.word 0xFFFFBFFF	; 03802B34

; ===== function loc_03802B38 =====
loc_03802B38:
	ldr r1,[r0,#0x0]	; 03802B38
	lsl r2,r1,#0x12	; 03802B3A
	lsr r2,r2,#0x1a	; 03802B3C
	cmp r2,#0x23	; 03802B3E
	bhi loc_03802BE0	; 03802B40
	add r2,r2,r2	; 03802B42
P2_SwitchIndexPC_03802B42:
	add r2,pc	; 03802B44
	ldrh r2,[r2,#(P2_SwitchTable_03802B42 - (P2_SwitchIndexPC_03802B42 + 4))]	; 03802B46
	lsl r2,r2,#0x10	; 03802B48
	asr r2,r2,#0x10	; 03802B4A
P2_SwitchTargetPC_03802B42:
	add r2,pc	; 03802B4C
	bx r2	; 03802B4E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03802B42:
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802B98 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BE0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BC0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BC0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
	.halfword (loc_03802BA0 + 1) - (P2_SwitchTargetPC_03802B42 + 4)
P2_SwitchTable_03802B42End:
loc_03802B98:
	ldr r2,[pool_03802BF4]	; 03802B98
	and r1,r2	; 03802B9A
	str r1,[r0,#0x0]	; 03802B9C
	bx lr	; 03802B9E
loc_03802BA0:
	ldr r2,[pool_03802BF8]	; 03802BA0
	orr r1,r2	; 03802BA2
	str r1,[r0,#0x0]	; 03802BA4
	ldr r2,[r0,#0x0]	; 03802BA6
	ldr r1,[pool_03802BFC]	; 03802BA8
	add r3,r2,#0x0	; 03802BAA
	and r3,r1	; 03802BAC
	lsl r1,r2,#0x12	; 03802BAE
	lsr r2,r1,#0x1a	; 03802BB0
	sub r2,#0x12	; 03802BB2
	mov r1,#0x3f	; 03802BB4
	and r2,r1	; 03802BB6
	lsl r1,r2,#0x8	; 03802BB8
	orr r3,r1	; 03802BBA
	str r3,[r0,#0x0]	; 03802BBC
	bx lr	; 03802BBE
loc_03802BC0:
	ldr r2,[pool_03802BF8]	; 03802BC0
	orr r1,r2	; 03802BC2
	str r1,[r0,#0x0]	; 03802BC4
	ldr r2,[r0,#0x0]	; 03802BC6
	ldr r1,[pool_03802BFC]	; 03802BC8
	add r3,r2,#0x0	; 03802BCA
	and r3,r1	; 03802BCC
	lsl r1,r2,#0x12	; 03802BCE
	lsr r2,r1,#0x1a	; 03802BD0
	sub r2,#0x18	; 03802BD2
	mov r1,#0x3f	; 03802BD4
	and r2,r1	; 03802BD6
	lsl r1,r2,#0x8	; 03802BD8
	orr r3,r1	; 03802BDA
	str r3,[r0,#0x0]	; 03802BDC
	bx lr	; 03802BDE
loc_03802BE0:
	ldr r2,[r0,#0x0]	; 03802BE0
	ldr r1,[pool_03802BF4]	; 03802BE2
	and r2,r1	; 03802BE4
	str r2,[r0,#0x0]	; 03802BE6
	ldr r2,[r0,#0x0]	; 03802BE8
	ldr r1,[pool_03802BFC]	; 03802BEA
	and r2,r1	; 03802BEC
	str r2,[r0,#0x0]	; 03802BEE
	bx lr	; 03802BF0
	.byte 0xC0, 0x46	; 03802BF4
pool_03802BF4:
loc_03802BF4:
	.word 0xFFFFBFFF	; 03802BF4
pool_03802BF8:
loc_03802BF8:
	.word 0x00004000	; 03802BF8
pool_03802BFC:
loc_03802BFC:
	.word 0xFFFFC0FF	; 03802BFC

; ===== function loc_03802C00 =====
loc_03802C00:
	push {r4,lr}	; 03802C00
	add r4,r0,#0x0	; 03802C02
	ldr r0,[pool_03802C1C]	; 03802C04
	bl loc_03802534	; 03802C06
	mov r0,#0x6	; 03802C0A
	mov r1,#0x70	; 03802C0C
	add r2,r4,#0x0	; 03802C0E
	mov r3,#0x1	; 03802C10
	bl loc_03802A00	; 03802C12
	pop {r4}	; 03802C16
	pop {r3}	; 03802C18
	bx r3	; 03802C1A
pool_03802C1C:
loc_03802C1C:
	.word 0x00008000	; 03802C1C

; ===== function loc_03802C20 =====
loc_03802C20:
	push {r4,lr}	; 03802C20
	add r4,r0,#0x0	; 03802C22
	ldr r0,[pool_03802C3C]	; 03802C24
	bl loc_03802534	; 03802C26
	mov r0,#0x86	; 03802C2A
	mov r1,#0x70	; 03802C2C
	add r2,r4,#0x0	; 03802C2E
	mov r3,#0x1	; 03802C30
	bl loc_03802A00	; 03802C32
	pop {r4}	; 03802C36
	pop {r3}	; 03802C38
	bx r3	; 03802C3A
pool_03802C3C:
loc_03802C3C:
	.word 0x00008000	; 03802C3C

; ===== function loc_03802C40 =====
loc_03802C40:
	push {r4,lr}	; 03802C40
	add r4,r0,#0x0	; 03802C42
	ldr r0,[pool_03802C5C]	; 03802C44
	bl loc_03802534	; 03802C46
	mov r0,#0x6	; 03802C4A
	mov r1,#0x30	; 03802C4C
	add r2,r4,#0x0	; 03802C4E
	mov r3,#0x1	; 03802C50
	bl loc_03802A00	; 03802C52
	pop {r4}	; 03802C56
	pop {r3}	; 03802C58
	bx r3	; 03802C5A
pool_03802C5C:
loc_03802C5C:
	.word 0x00008000	; 03802C5C

; ===== function loc_03802C60 =====
loc_03802C60:
	push {r4,lr}	; 03802C60
	add r4,r0,#0x0	; 03802C62
	ldr r0,[pool_03802C7C]	; 03802C64
	bl loc_03802534	; 03802C66
	mov r0,#0x86	; 03802C6A
	mov r1,#0x30	; 03802C6C
	add r2,r4,#0x0	; 03802C6E
	mov r3,#0x1	; 03802C70
	bl loc_03802A00	; 03802C72
	pop {r4}	; 03802C76
	pop {r3}	; 03802C78
	bx r3	; 03802C7A
pool_03802C7C:
loc_03802C7C:
	.word 0x00008000	; 03802C7C

; ===== function loc_03802C80 =====
loc_03802C80:
	push {r4,lr}	; 03802C80
	add r4,r0,#0x0	; 03802C82
	ldr r0,[pool_03802C9C]	; 03802C84
	bl loc_03802534	; 03802C86
	mov r0,#0x6	; 03802C8A
	mov r1,#0x40	; 03802C8C
	add r2,r4,#0x0	; 03802C8E
	mov r3,#0x1	; 03802C90
	bl loc_03802A00	; 03802C92
	pop {r4}	; 03802C96
	pop {r3}	; 03802C98
	bx r3	; 03802C9A
pool_03802C9C:
loc_03802C9C:
	.word 0x00008000	; 03802C9C

; ===== function loc_03802CA0 =====
loc_03802CA0:
	push {r4,lr}	; 03802CA0
	add r4,r0,#0x0	; 03802CA2
	ldr r0,[pool_03802CBC]	; 03802CA4
	bl loc_03802534	; 03802CA6
	mov r0,#0x86	; 03802CAA
	mov r1,#0x40	; 03802CAC
	add r2,r4,#0x0	; 03802CAE
	mov r3,#0x1	; 03802CB0
	bl loc_03802A00	; 03802CB2
	pop {r4}	; 03802CB6
	pop {r3}	; 03802CB8
	bx r3	; 03802CBA
pool_03802CBC:
loc_03802CBC:
	.word 0x00008000	; 03802CBC

; ===== function loc_03802CC0 =====
loc_03802CC0:
	push {r4,lr}	; 03802CC0
	add r4,r0,#0x0	; 03802CC2
	ldr r0,[pool_03802CDC]	; 03802CC4
	bl loc_03802534	; 03802CC6
	mov r0,#0x6	; 03802CCA
	mov r1,#0x0	; 03802CCC
	add r2,r4,#0x0	; 03802CCE
	mov r3,#0x1	; 03802CD0
	bl loc_03802A00	; 03802CD2
	pop {r4}	; 03802CD6
	pop {r3}	; 03802CD8
	bx r3	; 03802CDA
pool_03802CDC:
loc_03802CDC:
	.word 0x00008000	; 03802CDC

; ===== function loc_03802CE0 =====
loc_03802CE0:
	push {r4,lr}	; 03802CE0
	add r4,r0,#0x0	; 03802CE2
	ldr r0,[pool_03802CFC]	; 03802CE4
	bl loc_03802534	; 03802CE6
	mov r0,#0x86	; 03802CEA
	mov r1,#0x0	; 03802CEC
	add r2,r4,#0x0	; 03802CEE
	mov r3,#0x1	; 03802CF0
	bl loc_03802A00	; 03802CF2
	pop {r4}	; 03802CF6
	pop {r3}	; 03802CF8
	bx r3	; 03802CFA
pool_03802CFC:
loc_03802CFC:
	.word 0x00008000	; 03802CFC

; ===== function loc_03802D00 =====
loc_03802D00:
	push {r4,lr}	; 03802D00
	sub sp,#0x8	; 03802D02
	add r4,r0,#0x0	; 03802D04
	add r0,sp,#0x0	; 03802D06
	bl loc_03802CA0	; 03802D08
	add r0,sp,#0x0	; 03802D0C
	ldrh r0,[r0,#0x0]	; 03802D0E
	lsl r0,r0,#0x19	; 03802D10
	lsr r0,r0,#0x1f	; 03802D12
	cmp r0,#0x0	; 03802D14
	beq loc_03802D28	; 03802D16
	mov r0,#0x6	; 03802D18
	mov r1,#0x50	; 03802D1A
	add r2,r4,#0x0	; 03802D1C
	mov r3,#0x3	; 03802D1E
	bl loc_03802A00	; 03802D20
	mov r0,#0x1	; 03802D24
	b loc_03802D2A	; 03802D26
loc_03802D28:
	mov r0,#0x0	; 03802D28
loc_03802D2A:
	add sp,#0x8	; 03802D2A
	pop {r4}	; 03802D2C
	pop {r3}	; 03802D2E
	bx r3	; 03802D30
	.byte 0x00, 0x00	; 03802D34

; ===== function loc_03802D34 =====
loc_03802D34:
	push {r4,lr}	; 03802D34
	sub sp,#0x8	; 03802D36
	add r4,r0,#0x0	; 03802D38
	add r0,sp,#0x0	; 03802D3A
	bl loc_03802CA0	; 03802D3C
	add r0,sp,#0x0	; 03802D40
	ldrh r0,[r0,#0x0]	; 03802D42
	lsl r0,r0,#0x19	; 03802D44
	lsr r0,r0,#0x1f	; 03802D46
	cmp r0,#0x0	; 03802D48
	beq loc_03802D5C	; 03802D4A
	mov r0,#0x86	; 03802D4C
	mov r1,#0x50	; 03802D4E
	add r2,r4,#0x0	; 03802D50
	mov r3,#0x3	; 03802D52
	bl loc_03802A00	; 03802D54
	mov r0,#0x1	; 03802D58
	b loc_03802D5E	; 03802D5A
loc_03802D5C:
	mov r0,#0x0	; 03802D5C
loc_03802D5E:
	add sp,#0x8	; 03802D5E
	pop {r4}	; 03802D60
	pop {r3}	; 03802D62
	bx r3	; 03802D64
	.byte 0x00, 0x00	; 03802D68

; ===== function loc_03802D68 =====
loc_03802D68:
	push {r4,lr}	; 03802D68
	sub sp,#0x8	; 03802D6A
	add r4,r0,#0x0	; 03802D6C
	add r0,sp,#0x0	; 03802D6E
	bl loc_03802CA0	; 03802D70
	add r0,sp,#0x0	; 03802D74
	ldrh r0,[r0,#0x0]	; 03802D76
	lsl r0,r0,#0x1c	; 03802D78
	lsr r0,r0,#0x1c	; 03802D7A
	cmp r0,#0x4	; 03802D7C
	bne loc_03802D90	; 03802D7E
	mov r0,#0x6	; 03802D80
	mov r1,#0x10	; 03802D82
	add r2,r4,#0x0	; 03802D84
	mov r3,#0x3	; 03802D86
	bl loc_03802A00	; 03802D88
	mov r0,#0x1	; 03802D8C
	b loc_03802D92	; 03802D8E
loc_03802D90:
	mov r0,#0x0	; 03802D90
loc_03802D92:
	add sp,#0x8	; 03802D92
	pop {r4}	; 03802D94
	pop {r3}	; 03802D96
	bx r3	; 03802D98
	.byte 0x00, 0x00	; 03802D9C

; ===== function loc_03802D9C =====
loc_03802D9C:
	push {r4,lr}	; 03802D9C
	sub sp,#0x8	; 03802D9E
	add r4,r0,#0x0	; 03802DA0
	add r0,sp,#0x0	; 03802DA2
	bl loc_03802CA0	; 03802DA4
	add r0,sp,#0x0	; 03802DA8
	ldrh r0,[r0,#0x0]	; 03802DAA
	lsl r0,r0,#0x1c	; 03802DAC
	lsr r0,r0,#0x1c	; 03802DAE
	cmp r0,#0x4	; 03802DB0
	bne loc_03802DC4	; 03802DB2
	mov r0,#0x86	; 03802DB4
	mov r1,#0x10	; 03802DB6
	add r2,r4,#0x0	; 03802DB8
	mov r3,#0x3	; 03802DBA
	bl loc_03802A00	; 03802DBC
	mov r0,#0x1	; 03802DC0
	b loc_03802DC6	; 03802DC2
loc_03802DC4:
	mov r0,#0x0	; 03802DC4
loc_03802DC6:
	add sp,#0x8	; 03802DC6
	pop {r4}	; 03802DC8
	pop {r3}	; 03802DCA
	bx r3	; 03802DCC
	.byte 0x00, 0x00	; 03802DD0

; ===== function loc_03802DD0 =====
loc_03802DD0:
	push {r4,lr}	; 03802DD0
	add r4,r0,#0x0	; 03802DD2
	ldr r0,[pool_03802DEC]	; 03802DD4
	bl loc_03802534	; 03802DD6
	mov r0,#0x6	; 03802DDA
	mov r1,#0x20	; 03802DDC
	add r2,r4,#0x0	; 03802DDE
	mov r3,#0x7	; 03802DE0
	bl loc_03802A00	; 03802DE2
	pop {r4}	; 03802DE6
	pop {r3}	; 03802DE8
	bx r3	; 03802DEA
pool_03802DEC:
loc_03802DEC:
	.word 0x00008000	; 03802DEC

; ===== function loc_03802DF0 =====
loc_03802DF0:
	push {r4,lr}	; 03802DF0
	add r4,r0,#0x0	; 03802DF2
	ldr r0,[pool_03802E0C]	; 03802DF4
	bl loc_03802534	; 03802DF6
	mov r0,#0x86	; 03802DFA
	mov r1,#0x20	; 03802DFC
	add r2,r4,#0x0	; 03802DFE
	mov r3,#0x7	; 03802E00
	bl loc_03802A00	; 03802E02
	pop {r4}	; 03802E06
	pop {r3}	; 03802E08
	bx r3	; 03802E0A
pool_03802E0C:
loc_03802E0C:
	.word 0x00008000	; 03802E0C

; ===== function loc_03802E10 =====
loc_03802E10:
	push {r4,r5,lr}	; 03802E10
	sub sp,#0xc	; 03802E12
	add r5,r0,#0x0	; 03802E14
	mov r0,#0x1	; 03802E16
	add r4,r5,#0x0	; 03802E18
	and r4,r0	; 03802E1A
	lsl r0,r4,#0x10	; 03802E1C
	lsr r0,r0,#0x10	; 03802E1E
	cmp r0,#0x1	; 03802E20
	bne loc_03802EB0	; 03802E22
	add r0,sp,#0x0	; 03802E24
	bl loc_03802CE0	; 03802E26
	add r0,sp,#0x0	; 03802E2A
	ldrh r1,[r0,#0x0]	; 03802E2C
	lsl r2,r1,#0x1e	; 03802E2E
	lsr r3,r2,#0x1f	; 03802E30
	lsl r2,r4,#0x10	; 03802E32
	lsr r2,r2,#0x10	; 03802E34
	cmp r3,r2	; 03802E36
	beq loc_03802EB0	; 03802E38
	mov r3,#0x1	; 03802E3A
	and r5,r3	; 03802E3C
	mov r2,#0x2	; 03802E3E
	bic r1,r2	; 03802E40
	lsl r2,r5,#0x10	; 03802E42
	lsr r2,r2,#0x10	; 03802E44
	and r2,r3	; 03802E46
	lsl r2,r2,#0x1	; 03802E48
	orr r1,r2	; 03802E4A
	strh r1,[r0,#0x0]	; 03802E4C
	add r0,sp,#0x0	; 03802E4E
	bl loc_03802CC0	; 03802E50
	mov r0,#0x86	; 03802E54
	mov r1,#0x10	; 03802E56
	add r2,sp,#0x4	; 03802E58
	mov r3,#0x3	; 03802E5A
	bl loc_03802A00	; 03802E5C
	lsl r0,r5,#0x10	; 03802E60
	lsr r0,r0,#0x10	; 03802E62
	cmp r0,#0x0	; 03802E64
	bne loc_03802E70	; 03802E66
	add r0,sp,#0x4	; 03802E68
	bl loc_03802B38	; 03802E6A
	b loc_03802E76	; 03802E6E
loc_03802E70:
	add r0,sp,#0x4	; 03802E70
	bl loc_03802A7C	; 03802E72
loc_03802E76:
	mov r0,#0x6	; 03802E76
	mov r1,#0x10	; 03802E78
	add r2,sp,#0x4	; 03802E7A
	mov r3,#0x3	; 03802E7C
	bl loc_03802A00	; 03802E7E
	mov r0,#0x86	; 03802E82
	mov r1,#0x50	; 03802E84
	add r2,sp,#0x4	; 03802E86
	mov r3,#0x3	; 03802E88
	bl loc_03802A00	; 03802E8A
	lsl r0,r4,#0x10	; 03802E8E
	lsr r0,r0,#0x10	; 03802E90
	cmp r0,#0x0	; 03802E92
	bne loc_03802E9E	; 03802E94
	add r0,sp,#0x4	; 03802E96
	bl loc_03802B38	; 03802E98
	b loc_03802EA4	; 03802E9C
loc_03802E9E:
	add r0,sp,#0x4	; 03802E9E
	bl loc_03802A7C	; 03802EA0
loc_03802EA4:
	mov r0,#0x6	; 03802EA4
	mov r1,#0x50	; 03802EA6
	add r2,sp,#0x4	; 03802EA8
	mov r3,#0x3	; 03802EAA
	bl loc_03802A00	; 03802EAC
loc_03802EB0:
	add sp,#0xc	; 03802EB0
	pop {r4,r5}	; 03802EB2
	pop {r3}	; 03802EB4
	bx r3	; 03802EB6

; ===== function loc_03802EB8 =====
loc_03802EB8:
	push {lr}	; 03802EB8
	sub sp,#0x4	; 03802EBA
	ldr r0,[pool_03802EE0]	; 03802EBC
	bl loc_03802534	; 03802EBE
	add r0,sp,#0x0	; 03802EC2
	ldrh r1,[r0,#0x0]	; 03802EC4
	mov r3,#0x1	; 03802EC6
	bic r1,r3	; 03802EC8
	orr r1,r3	; 03802ECA
	strh r1,[r0,#0x0]	; 03802ECC
	mov r0,#0x6	; 03802ECE
	mov r1,#0x0	; 03802ED0
	add r2,sp,#0x0	; 03802ED2
	bl loc_03802A00	; 03802ED4
	add sp,#0x4	; 03802ED8
	pop {r3}	; 03802EDA
	bx r3	; 03802EDC
	.byte 0xC0, 0x46	; 03802EE0
pool_03802EE0:
loc_03802EE0:
	.word 0x00008000	; 03802EE0
.arm

; ===== function loc_03802EE4 =====
loc_03802EE4:
	mov r12,#0x4000000	; 03802EE4
	add r12,r12,#0x138	; 03802EE8
	ldrh r0,[r12,#0x0]	; 03802EEC
	bic r0,r0,#0x77	; 03802EF0
	orr r0,r0,#0x72	; 03802EF4
	strh r0,[r12,#0x0]	; 03802EF8
	mov r3,#0x2	; 03802EFC
loc_03802F00:
	subs r3,r3,#0x1	; 03802F00
	bne loc_03802F00	; 03802F04
	bic r0,r0,#0x4	; 03802F08
	orr r0,r0,#0x4	; 03802F0C
	strh r0,[r12,#0x0]	; 03802F10
	mov r3,#0x2	; 03802F14
loc_03802F18:
	subs r3,r3,#0x1	; 03802F18
	bne loc_03802F18	; 03802F1C
	bx lr	; 03802F20

; ===== function loc_03802F24 =====
loc_03802F24:
	mov r12,#0x4000000	; 03802F24
	add r12,r12,#0x138	; 03802F28
	mov r3,#0x2	; 03802F2C
loc_03802F30:
	subs r3,r3,#0x1	; 03802F30
	bne loc_03802F30	; 03802F34
	ldrh r0,[r12,#0x0]	; 03802F38
	bic r0,r0,#0x4	; 03802F3C
	orr r0,r0,#0x0	; 03802F40
	strh r0,[r12,#0x0]	; 03802F44
	mov r3,#0x2	; 03802F48
loc_03802F4C:
	subs r3,r3,#0x1	; 03802F4C
	bne loc_03802F4C	; 03802F50
	bx lr	; 03802F54

; ===== function loc_03802F58 =====
loc_03802F58:
	mov r12,#0x4000000	; 03802F58
	add r12,r12,#0x138	; 03802F5C
	orr r1,r0,r1	; 03802F60
	ldrh r0,[r12,#0x0]	; 03802F64
	bic r0,r0,#0x77	; 03802F68
	orr r0,r0,#0x74	; 03802F6C
	mov r2,#0x0	; 03802F70
loc_03802F74:
	bic r0,r0,#0x3	; 03802F74
	orr r0,r0,#0x0	; 03802F78
	mov r3,#0x1	; 03802F7C
	tst r3,r1, lsr r2	; 03802F80
	movne r3,#0x1	; 03802F84
	moveq r3,#0x0	; 03802F88
	orr r0,r0,r3	; 03802F8C
	strh r0,[r12,#0x0]	; 03802F90
	mov r3,#0x9	; 03802F94
loc_03802F98:
	subs r3,r3,#0x1	; 03802F98
	bne loc_03802F98	; 03802F9C
	bic r0,r0,#0x2	; 03802FA0
	orr r0,r0,#0x2	; 03802FA4
	strh r0,[r12,#0x0]	; 03802FA8
	mov r3,#0x9	; 03802FAC
loc_03802FB0:
	subs r3,r3,#0x1	; 03802FB0
	bne loc_03802FB0	; 03802FB4
	add r2,r2,#0x1	; 03802FB8
	cmp r2,#0x8	; 03802FBC
	bne loc_03802F74	; 03802FC0
	bx lr	; 03802FC4

; ===== function loc_03802FC8 =====
loc_03802FC8:
	mov r12,#0x4000000	; 03802FC8
	add r12,r12,#0x138	; 03802FCC
loc_03802FD0:
	stmdb sp!,{r0,r1}	; 03802FD0
	tst r0,#0x1	; 03802FD4
	ldreqh r1,[r0,#0x0]	; 03802FD8
	ldrneh r1,[r0,#-0x1]	; 03802FDC
	movne r1,r1, lsr #0x8	; 03802FE0
	ldrh r0,[r12,#0x0]	; 03802FE4
	bic r0,r0,#0x77	; 03802FE8
	orr r0,r0,#0x74	; 03802FEC
	mov r2,#0x0	; 03802FF0
loc_03802FF4:
	bic r0,r0,#0x3	; 03802FF4
	orr r0,r0,#0x0	; 03802FF8
	mov r3,#0x1	; 03802FFC
	tst r3,r1, lsr r2	; 03803000
	movne r3,#0x1	; 03803004
	moveq r3,#0x0	; 03803008
	orr r0,r0,r3	; 0380300C
	strh r0,[r12,#0x0]	; 03803010
	mov r3,#0x9	; 03803014
loc_03803018:
	subs r3,r3,#0x1	; 03803018
	bne loc_03803018	; 0380301C
	bic r0,r0,#0x2	; 03803020
	orr r0,r0,#0x2	; 03803024
	strh r0,[r12,#0x0]	; 03803028
	mov r3,#0x9	; 0380302C
loc_03803030:
	subs r3,r3,#0x1	; 03803030
	bne loc_03803030	; 03803034
	add r2,r2,#0x1	; 03803038
	cmp r2,#0x8	; 0380303C
	bne loc_03802FF4	; 03803040
	ldmia sp!,{r0,r1}	; 03803044
	add r0,r0,#0x1	; 03803048
	subs r1,r1,#0x1	; 0380304C
	bne loc_03802FD0	; 03803050
	bx lr	; 03803054

; ===== function loc_03803058 =====
loc_03803058:
	mov r12,#0x4000000	; 03803058
	add r12,r12,#0x138	; 0380305C
loc_03803060:
	stmdb sp!,{r0,r1}	; 03803060
	ldrh r0,[r12,#0x0]	; 03803064
	bic r0,r0,#0x77	; 03803068
	orr r0,r0,#0x64	; 0380306C
	mov r2,#0x0	; 03803070
	mov r1,#0x0	; 03803074
loc_03803078:
	bic r0,r0,#0x3	; 03803078
	orr r0,r0,#0x0	; 0380307C
	strh r0,[r12,#0x0]	; 03803080
	mov r3,#0x9	; 03803084
loc_03803088:
	subs r3,r3,#0x1	; 03803088
	bne loc_03803088	; 0380308C
	ldrh r0,[r12,#0x0]	; 03803090
	and r3,r0,#0x1	; 03803094
	cmp r3,#0x1	; 03803098
	moveq r3,#0x80	; 0380309C
	movne r3,#0x0	; 038030A0
	orr r2,r3,r2, lsr #0x1	; 038030A4
	bic r0,r0,#0x2	; 038030A8
	orr r0,r0,#0x2	; 038030AC
	strh r0,[r12,#0x0]	; 038030B0
	mov r3,#0x9	; 038030B4
loc_038030B8:
	subs r3,r3,#0x1	; 038030B8
	bne loc_038030B8	; 038030BC
	add r1,r1,#0x1	; 038030C0
	cmp r1,#0x8	; 038030C4
	bne loc_03803078	; 038030C8
	ldmia sp!,{r0,r1}	; 038030CC
	tst r0,#0x1	; 038030D0
	beq loc_038030F0	; 038030D4
	ldrh r3,[r0,#-0x1]	; 038030D8
	bic r3,r3,#0xff00	; 038030DC
	mov r2,r2, lsl #0x8	; 038030E0
	orr r3,r2,r3	; 038030E4
	strh r3,[r0,#-0x1]	; 038030E8
	b loc_03803100	; 038030EC
loc_038030F0:
	ldrh r3,[r0,#0x0]	; 038030F0
	bic r3,r3,#0xff	; 038030F4
	orr r3,r3,r2	; 038030F8
	strh r3,[r0,#0x0]	; 038030FC
loc_03803100:
	add r0,r0,#0x1	; 03803100
	subs r1,r1,#0x1	; 03803104
	bne loc_03803060	; 03803108
	bx lr	; 0380310C
.thumb

; ===== function loc_03803110 =====
P2_PxiCallback_03803110:
	push {lr}	; 03803110
	sub sp,#0x4	; 03803112
	cmp r2,#0x0	; 03803114
	bne loc_0380313C	; 03803116
	cmp r0,#0x4	; 03803118
	beq loc_03803136	; 0380311A
	cmp r0,#0x6	; 0380311C
	beq loc_03803126	; 0380311E
	cmp r0,#0x8	; 03803120
	beq loc_0380312E	; 03803122
	b loc_0380313C	; 03803124
loc_03803126:
	add r0,r1,#0x0	; 03803126
	bl loc_0380362C	; 03803128
	b loc_0380313C	; 0380312C
loc_0380312E:
	add r0,r1,#0x0	; 0380312E
	bl loc_03804648	; 03803130
	b loc_0380313C	; 03803134
loc_03803136:
	add r0,r1,#0x0	; 03803136
	bl loc_03803ED0	; 03803138
loc_0380313C:
	add sp,#0x4	; 0380313C
	pop {r3}	; 0380313E
	bx r3	; 03803140
	.byte 0x00, 0x00	; 03803142
P2_ThreadEntry_03803144:
	push {r4,r5,r6,lr}	; 03803144
	sub sp,#0x8	; 03803146
	ldr r5,[pool_0380317C]	; 03803148
	add r4,sp,#0x0	; 0380314A
	mov r6,#0x1	; 0380314C
P2_Entry_0380314E:
	add r0,r5,#0x0	; 0380314E
	add r1,r4,#0x0	; 03803150
	add r2,r6,#0x0	; 03803152
	bl loc_037FE678	; 03803154
	ldr r0,[sp,#0x0]	; 03803158
	ldr r1,[r0,#0x0]	; 0380315A
	cmp r1,#0x0	; 0380315C
	beq P2_Entry_0380316A	; 0380315E
	cmp r1,#0x1	; 03803160
	beq P2_Entry_03803176	; 03803162
	cmp r1,#0x3	; 03803164
	beq P2_Entry_03803170	; 03803166
	b P2_Entry_0380314E	; 03803168
P2_Entry_0380316A:
	bl P2_Entry_038034C0	; 0380316A
	b P2_Entry_0380314E	; 0380316E
P2_Entry_03803170:
	bl P2_Entry_0380454C	; 03803170
	b P2_Entry_0380314E	; 03803174
P2_Entry_03803176:
	bl P2_Entry_03803D7C	; 03803176
	b P2_Entry_0380314E	; 0380317A
pool_0380317C:
	.word 0x03807D3C	; 0380317C

; ===== function loc_03803180 =====
loc_03803180:
	push {r0,r1,r2,r3}	; 03803180
	push {r4,r5,r6,r7,lr}	; 03803182
	sub sp,#0x4	; 03803184
	add r5,r0,#0x0	; 03803186
	add r4,r1,#0x0	; 03803188
	add r0,sp,#0x18	; 0380318A
	ldrh r0,[r0,#0x8]	; 0380318C
	cmp r0,#0x4	; 0380318E
	bls loc_03803196	; 03803190
	mov r0,#0x0	; 03803192
	b loc_03803206	; 03803194
loc_03803196:
	bl loc_037FE0D0	; 03803196
	add r7,r0,#0x0	; 0380319A
	ldr r0,[pool_03803210]	; 0380319C
	ldr r1,[r0,#0x54]	; 0380319E
	mov r0,#0x18	; 038031A0
	mul r1,r0	; 038031A2
	ldr r0,[pool_03803214]	; 038031A4
	str r5,[r0,r1]	; 038031A6
	ldr r0,[pool_03803210]	; 038031A8
	ldr r1,[r0,#0x54]	; 038031AA
	mov r0,#0x18	; 038031AC
	mul r1,r0	; 038031AE
	ldr r0,[pool_03803218]	; 038031B0
	str r4,[r0,r1]	; 038031B2
	add r1,sp,#0x20	; 038031B4
	mov r0,#0x3	; 038031B6
	bic r1,r0	; 038031B8
	add r6,r1,#0x4	; 038031BA
	mov r5,#0x0	; 038031BC
	add r0,sp,#0x18	; 038031BE
	ldrh r4,[r0,#0x8]	; 038031C0
	b loc_038031E0	; 038031C2
loc_038031C4:
	add r6,r6,#0x4	; 038031C4
	sub r0,r6,#0x4	; 038031C6
	ldr r3,[r0,#0x0]	; 038031C8
	ldr r0,[pool_03803210]	; 038031CA
	ldr r2,[r0,#0x54]	; 038031CC
	mov r0,#0x18	; 038031CE
	mul r2,r0	; 038031D0
	lsl r1,r5,#0x2	; 038031D2
	ldr r0,[pool_0380321C]	; 038031D4
	add r0,r0,r2	; 038031D6
	add r1,r1,r0	; 038031D8
	ldr r0,[pool_03803220]	; 038031DA
	str r3,[r1,r0]	; 038031DC
	add r5,r5,#0x1	; 038031DE
loc_038031E0:
	cmp r5,r4	; 038031E0
	blt loc_038031C4	; 038031E2
	ldr r1,[pool_03803210]	; 038031E4
	ldr r4,[r1,#0x54]	; 038031E6
	add r2,r4,#0x1	; 038031E8
	mov r0,#0xf	; 038031EA
	and r2,r0	; 038031EC
	str r2,[r1,#0x54]	; 038031EE
	add r0,r7,#0x0	; 038031F0
	bl loc_037FE0F4	; 038031F2
	ldr r0,[pool_03803224]	; 038031F6
	ldr r2,[pool_03803214]	; 038031F8
	mov r1,#0x18	; 038031FA
	mul r4,r1	; 038031FC
	add r1,r2,r4	; 038031FE
	mov r2,#0x0	; 03803200
	bl loc_037FE6F0	; 03803202
loc_03803206:
	add sp,#0x4	; 03803206
	pop {r4,r5,r6,r7}	; 03803208
	pop {r3}	; 0380320A
	add sp,#0x10	; 0380320C
	bx r3	; 0380320E
pool_03803210:
loc_03803210:
	.word P2_BssStart + 0x2740	; 03803210
pool_03803214:
loc_03803214:
	.word P2_BssStart + 0x2614	; 03803214
pool_03803218:
loc_03803218:
	.word P2_BssStart + 0x2618	; 03803218
pool_0380321C:
loc_0380321C:
	.word 0x03807ABC	; 0380321C
pool_03803220:
loc_03803220:
	.word 0x000002DC	; 03803220
pool_03803224:
loc_03803224:
	.word 0x03807D3C	; 03803224

; ===== function loc_03803228 =====
P2_Entry_03803228:
	push {lr}	; 03803228
	sub sp,#0x4	; 0380322A
	ldr r1,[pool_03803248]	; 0380322C
	ldr r2,[r1,#0x4]	; 0380322E
	cmp r2,r0	; 03803230
	bne loc_03803242	; 03803232
	mov r0,#0x5	; 03803234
	str r0,[r1,#0x4]	; 03803236
	mov r0,#0x0	; 03803238
	str r0,[r1,#0x0]	; 0380323A
	ldr r0,[pool_0380324C]	; 0380323C
	bl loc_037FE2F4	; 0380323E
loc_03803242:
	add sp,#0x4	; 03803242
	pop {r3}	; 03803244
	bx r3	; 03803246
pool_03803248:
loc_03803248:
	.word P2_BssStart + 0x2340	; 03803248
pool_0380324C:
loc_0380324C:
	.word 0x03807F14	; 0380324C

; ===== function loc_03803250 =====
loc_03803250:
	mov r2,#0x1	; 03803250
	ldr r1,[pool_0380325C]	; 03803252
	str r2,[r1,#0x0]	; 03803254
	str r0,[r1,#0x4]	; 03803256
	bx lr	; 03803258
	.byte 0xC0, 0x46	; 0380325C
pool_0380325C:
loc_0380325C:
	.word P2_BssStart + 0x2340	; 0380325C
P2_Entry_03803260:
	ldr r0,[pool_03803270]	; 03803260
	ldr r0,[r0,#0x0]	; 03803262
	cmp r0,#0x0	; 03803264
	bne P2_Entry_0380326C	; 03803266
	mov r0,#0x1	; 03803268
	bx lr	; 0380326A
P2_Entry_0380326C:
	mov r0,#0x0	; 0380326C
	bx lr	; 0380326E
pool_03803270:
	.word P2_BssStart + 0x2340	; 03803270

; ===== function loc_03803274 =====
loc_03803274:
	push {r4,r5,r6,lr}	; 03803274
	mov r2,#0x70	; 03803276
	add r3,r0,#0x0	; 03803278
	and r3,r2	; 0380327A
	cmp r3,#0x20	; 0380327C
	bgt loc_03803294	; 0380327E
	cmp r3,#0x20	; 03803280
	bge loc_038032B0	; 03803282
	cmp r3,#0x0	; 03803284
	bgt loc_0380328E	; 03803286
	cmp r3,#0x0	; 03803288
	beq loc_038032A8	; 0380328A
	b loc_038032B2	; 0380328C
loc_0380328E:
	cmp r3,#0x10	; 0380328E
	beq loc_038032A8	; 03803290
	b loc_038032B2	; 03803292
loc_03803294:
	cmp r3,#0x60	; 03803294
	bgt loc_038032A2	; 03803296
	cmp r3,#0x60	; 03803298
	bge loc_038032AC	; 0380329A
	cmp r3,#0x30	; 0380329C
	beq loc_038032B0	; 0380329E
	b loc_038032B2	; 038032A0
loc_038032A2:
	cmp r3,#0x70	; 038032A2
	beq loc_038032AC	; 038032A4
	b loc_038032B2	; 038032A6
loc_038032A8:
	mov r5,#0x6	; 038032A8
	b loc_038032B2	; 038032AA
loc_038032AC:
	mov r5,#0x8	; 038032AC
	b loc_038032B2	; 038032AE
loc_038032B0:
	mov r5,#0x4	; 038032B0
loc_038032B2:
	mov r3,#0xff	; 038032B2
	and r0,r3	; 038032B4
	mov r2,#0x80	; 038032B6
	orr r0,r2	; 038032B8
	lsl r4,r0,#0x8	; 038032BA
	ldr r0,[pool_038032DC]	; 038032BC
	orr r4,r0	; 038032BE
	and r1,r3	; 038032C0
	orr r4,r1	; 038032C2
	mov r6,#0x0	; 038032C4
loc_038032C6:
	add r0,r5,#0x0	; 038032C6
	add r1,r4,#0x0	; 038032C8
	add r2,r6,#0x0	; 038032CA
	bl loc_03802320	; 038032CC
	cmp r0,#0x0	; 038032D0
	blt loc_038032C6	; 038032D2
	pop {r4,r5,r6}	; 038032D4
	pop {r3}	; 038032D6
	bx r3	; 038032D8
	.byte 0xC0, 0x46	; 038032DC
pool_038032DC:
loc_038032DC:
	.word 0x03000000	; 038032DC

; ===== function loc_038032E0 =====
loc_038032E0:
	push {lr}	; 038032E0
	sub sp,#0x4	; 038032E2
	ldr r1,[pool_0380331C]	; 038032E4
	ldr r2,[r1,#0x0]	; 038032E6
	cmp r2,#0x0	; 038032E8
	beq loc_03803316	; 038032EA
	ldr r1,[r1,#0x4]	; 038032EC
	cmp r1,#0x4	; 038032EE
	bne loc_03803316	; 038032F0
	ldr r1,[pool_03803320]	; 038032F2
	ldr r1,[r1,#0x5c]	; 038032F4
	cmp r1,r0	; 038032F6
	bne loc_03803316	; 038032F8
	bl loc_037FE0D0	; 038032FA
	mov r2,#0x5	; 038032FE
	ldr r1,[pool_0380331C]	; 03803300
	str r2,[r1,#0x4]	; 03803302
	mov r2,#0x0	; 03803304
	str r2,[r1,#0x0]	; 03803306
	ldr r1,[pool_03803320]	; 03803308
	str r2,[r1,#0x5c]	; 0380330A
	bl loc_037FE0F4	; 0380330C
	ldr r0,[pool_03803324]	; 03803310
	bl loc_037FE2F4	; 03803312
loc_03803316:
	add sp,#0x4	; 03803316
	pop {r3}	; 03803318
	bx r3	; 0380331A
pool_0380331C:
loc_0380331C:
	.word P2_BssStart + 0x2340	; 0380331C
pool_03803320:
loc_03803320:
	.word P2_BssStart + 0x2740	; 03803320
pool_03803324:
loc_03803324:
	.word 0x03807F14	; 03803324

; ===== function loc_03803328 =====
loc_03803328:
	push {r4,r5,r6,r7,lr}	; 03803328
	sub sp,#0x4	; 0380332A
	add r5,r0,#0x0	; 0380332C
	ldr r7,[pool_03803364]	; 0380332E
	ldr r6,[pool_03803368]	; 03803330
loc_03803332:
	bl loc_037FE0D0	; 03803332
	add r4,r0,#0x0	; 03803336
	ldr r1,[r6,#0x0]	; 03803338
	cmp r1,#0x0	; 0380333A
	beq loc_0380334A	; 0380333C
	bl loc_037FE0F4	; 0380333E
	add r0,r7,#0x0	; 03803342
	bl loc_037FE33C	; 03803344
	b loc_03803332	; 03803348
loc_0380334A:
	mov r0,#0x4	; 0380334A
	bl loc_03803250	; 0380334C
	ldr r0,[pool_0380336C]	; 03803350
	str r5,[r0,#0x5c]	; 03803352
	add r0,r4,#0x0	; 03803354
	bl loc_037FE0F4	; 03803356
	add sp,#0x4	; 0380335A
	pop {r4,r5,r6,r7}	; 0380335C
	pop {r3}	; 0380335E
	bx r3	; 03803360
	.byte 0xC0, 0x46	; 03803364
pool_03803364:
loc_03803364:
	.word 0x03807F14	; 03803364
pool_03803368:
loc_03803368:
	.word 0x03807ABC	; 03803368
pool_0380336C:
loc_0380336C:
	.word P2_BssStart + 0x2740	; 0380336C

; ===== function loc_03803370 =====
loc_03803370:
	push {r4,r5,r6,r7,lr}	; 03803370
	sub sp,#0xc	; 03803372
	add r5,r0,#0x0	; 03803374
	ldr r0,[pool_03803404]	; 03803376
	ldrh r1,[r0,#0x0]	; 03803378
	cmp r1,#0x0	; 0380337A
	bne loc_038033FA	; 0380337C
	mov r1,#0x1	; 0380337E
	strh r1,[r0,#0x0]	; 03803380
	mov r1,#0x0	; 03803382
	ldr r0,[pool_03803408]	; 03803384
	str r1,[r0,#0x0]	; 03803386
	mov r1,#0x5	; 03803388
	str r1,[r0,#0x4]	; 0380338A
	bl loc_03803764	; 0380338C
	bl loc_03804008	; 03803390
	bl loc_03804790	; 03803394
	bl loc_03802240	; 03803398
	mov r0,#0x6	; 0380339C
	ldr r1,[pool_0380340C]	; 0380339E
	bl P2_SetPxiReceiveCallback	; 038033A0
	mov r0,#0x8	; 038033A4
	ldr r1,[pool_0380340C]	; 038033A6
	bl P2_SetPxiReceiveCallback	; 038033A8
	mov r0,#0x4	; 038033AC
	ldr r1,[pool_0380340C]	; 038033AE
	bl P2_SetPxiReceiveCallback	; 038033B0
	ldr r0,[pool_03803410]	; 038033B4
	ldr r1,[pool_03803414]	; 038033B6
	mov r2,#0x10	; 038033B8
	bl loc_037FE74C	; 038033BA
	mov r4,#0x0	; 038033BE
	ldr r7,[pool_03803418]	; 038033C0
	add r6,r4,#0x0	; 038033C2
loc_038033C4:
	add r1,r4,#0x0	; 038033C4
	mov r0,#0x18	; 038033C6
	mul r1,r0	; 038033C8
	add r0,r7,r1	; 038033CA
	add r1,r6,#0x0	; 038033CC
	mov r2,#0x18	; 038033CE
	bl loc_037FAABC	; 038033D0
	add r4,r4,#0x1	; 038033D4
	cmp r4,#0x10	; 038033D6
	blt loc_038033C4	; 038033D8
	mov r2,#0x0	; 038033DA
	ldr r0,[pool_0380341C]	; 038033DC
	str r2,[r0,#0x54]	; 038033DE
	ldr r0,[pool_03803420]	; 038033E0
	strh r2,[r0,#0x18]	; 038033E2
	ldr r0,[pool_03803424]	; 038033E4
	str r0,[sp,#0x0]	; 038033E6
	str r5,[sp,#0x4]	; 038033E8
	ldr r0,[pool_03803428]	; 038033EA
	ldr r1,[pool_0380342C]	; 038033EC
	ldr r3,[pool_03803410]	; 038033EE
	bl P2_CreateThread	; 038033F0
	ldr r0,[pool_03803428]	; 038033F4
	bl loc_037FE2D0	; 038033F6
loc_038033FA:
	add sp,#0xc	; 038033FA
	pop {r4,r5,r6,r7}	; 038033FC
	pop {r3}	; 038033FE
	bx r3	; 03803400
	.byte 0xC0, 0x46	; 03803404
pool_03803404:
loc_03803404:
	.word P2_BssStart + 0x233C	; 03803404
pool_03803408:
loc_03803408:
	.word P2_BssStart + 0x2340	; 03803408
pool_0380340C:
loc_0380340C:
	.word P2_PxiCallback_03803110 + 1	; 0380340C
pool_03803410:
loc_03803410:
	.word 0x03807D3C	; 03803410
pool_03803414:
loc_03803414:
	.word 0x03807D50	; 03803414
pool_03803418:
loc_03803418:
	.word 0x03807D90	; 03803418
pool_0380341C:
loc_0380341C:
	.word P2_BssStart + 0x2740	; 0380341C
pool_03803420:
loc_03803420:
	.word P2_BssStart + 0x2780	; 03803420
pool_03803424:
loc_03803424:
	.word 0x00000200	; 03803424
pool_03803428:
loc_03803428:
	.word 0x03807AC4	; 03803428
pool_0380342C:
loc_0380342C:
	.word P2_ThreadEntry_03803144 + 1	; 0380342C

; ===== function loc_03803430 =====
loc_03803430:
	push {lr}	; 03803430
	sub sp,#0x4	; 03803432
	cmp r0,#0x0	; 03803434
	bne loc_03803442	; 03803436
	mov r0,#0x3	; 03803438
	mov r1,#0x2	; 0380343A
	bl loc_03803274	; 0380343C
	b loc_0380345E	; 03803440
loc_03803442:
	cmp r1,#0x0	; 03803442
	bne loc_03803450	; 03803444
	mov r0,#0x3	; 03803446
	mov r1,#0x2	; 03803448
	bl loc_03803274	; 0380344A
	b loc_0380345E	; 0380344E
loc_03803450:
	ldr r2,[pool_03803464]	; 03803450
	str r0,[r2,#0x24]	; 03803452
	str r1,[r2,#0x28]	; 03803454
	mov r0,#0x3	; 03803456
	mov r1,#0x0	; 03803458
	bl loc_03803274	; 0380345A
loc_0380345E:
	add sp,#0x4	; 0380345E
	pop {r3}	; 03803460
	bx r3	; 03803462
pool_03803464:
loc_03803464:
	.word P2_BssStart + 0x27A0	; 03803464

; ===== function loc_03803468 =====
	push {r4,lr}	; 03803468
	sub sp,#0x8	; 0380346A
	add r4,r0,#0x0	; 0380346C
	mov r0,#0x0	; 0380346E
	mov r1,#0x10	; 03803470
	mov r2,#0x1	; 03803472
	add r3,r4,#0x0	; 03803474
	bl loc_03803180	; 03803476
	cmp r0,#0x0	; 0380347A
	bne loc_038034A6	; 0380347C
	ldr r1,[sp,#0x0]	; 0380347E
	ldr r0,[pool_038034B0]	; 03803480
	and r1,r0	; 03803482
	ldr r0,[pool_038034B4]	; 03803484
	orr r1,r0	; 03803486
	str r1,[sp,#0x0]	; 03803488
	add r0,sp,#0x0	; 0380348A
	ldrh r2,[r0,#0x0]	; 0380348C
	ldr r1,[pool_038034B8]	; 0380348E
	strh r2,[r1,#0x0]	; 03803490
	ldrh r1,[r0,#0x2]	; 03803492
	ldr r0,[pool_038034BC]	; 03803494
	strh r1,[r0,#0x0]	; 03803496
	mov r0,#0x10	; 03803498
	mov r1,#0xff	; 0380349A
	and r4,r1	; 0380349C
	lsl r1,r4,#0x10	; 0380349E
	lsr r1,r1,#0x10	; 038034A0
	bl loc_03803274	; 038034A2
loc_038034A6:
	add sp,#0x8	; 038034A6
	pop {r4}	; 038034A8
	pop {r3}	; 038034AA
	bx r3	; 038034AC
	.byte 0xC0, 0x46	; 038034B0
pool_038034B0:
loc_038034B0:
	.word 0xF9FFFFFF	; 038034B0
pool_038034B4:
loc_038034B4:
	.word 0x06000000	; 038034B4
pool_038034B8:
loc_038034B8:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 038034B8
pool_038034BC:
loc_038034BC:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 038034BC
P2_Entry_038034C0:
	push {r4,r5,r6,r7,lr}	; 038034C0
	sub sp,#0xc	; 038034C2
	add r5,r0,#0x0	; 038034C4
	ldr r1,[r5,#0x4]	; 038034C6
	cmp r1,#0x2	; 038034C8
	bhi P2_Entry_038034DA	; 038034CA
	cmp r1,#0x0	; 038034CC
	beq P2_Entry_038034EA	; 038034CE
	cmp r1,#0x1	; 038034D0
	beq P2_Entry_03803560	; 038034D2
	cmp r1,#0x2	; 038034D4
	beq P2_Entry_038035CE	; 038034D6
	b P2_Entry_038035FA	; 038034D8
P2_Entry_038034DA:
	cmp r1,#0x10	; 038034DA
	beq P2_Entry_038034E0	; 038034DC
	b P2_Entry_038035FA	; 038034DE
P2_Entry_038034E0:
	ldr r0,[pool_03803604]	; 038034E0
	ldr r0,[r0,#0x20]	; 038034E2
	cmp r0,#0x2	; 038034E4
	beq P2_Entry_038034EA	; 038034E6
	b P2_Entry_038035FA	; 038034E8
P2_Entry_038034EA:
	bl loc_037FE0D0	; 038034EA
	add r4,r0,#0x0	; 038034EE
	mov r0,#0x0	; 038034F0
	bl P2_Entry_03803260	; 038034F2
	cmp r0,#0x0	; 038034F6
	bne P2_Entry_0380350E	; 038034F8
	add r0,r4,#0x0	; 038034FA
	bl loc_037FE0F4	; 038034FC
	ldr r0,[r5,#0x4]	; 03803500
	lsl r0,r0,#0x10	; 03803502
	lsr r0,r0,#0x10	; 03803504
	mov r1,#0x4	; 03803506
	bl loc_03803274	; 03803508
	b P2_Entry_038035FA	; 0380350C
P2_Entry_0380350E:
	mov r0,#0x0	; 0380350E
	bl loc_03803250	; 03803510
	add r0,r4,#0x0	; 03803514
	bl loc_037FE0F4	; 03803516
	add r0,sp,#0x4	; 0380351A
	ldr r2,[pool_03803604]	; 0380351C
	ldr r1,[r2,#0x28]	; 0380351E
	ldr r2,[r2,#0x24]	; 03803520
	bl P2_Entry_03803844	; 03803522
	add r0,sp,#0x4	; 03803526
	ldrh r2,[r0,#0x0]	; 03803528
	ldr r1,[pool_03803608]	; 0380352A
	strh r2,[r1,#0x0]	; 0380352C
	ldrh r1,[r0,#0x2]	; 0380352E
	ldr r0,[pool_0380360C]	; 03803530
	strh r1,[r0,#0x0]	; 03803532
	ldr r0,[r5,#0x4]	; 03803534
	cmp r0,#0x0	; 03803536
	bne P2_Entry_03803546	; 03803538
	lsl r0,r0,#0x10	; 0380353A
	lsr r0,r0,#0x10	; 0380353C
	mov r1,#0x0	; 0380353E
	bl loc_03803274	; 03803540
	b P2_Entry_03803558	; 03803544
P2_Entry_03803546:
	lsl r0,r0,#0x10	; 03803546
	lsr r0,r0,#0x10	; 03803548
	ldr r2,[r5,#0x8]	; 0380354A
	mov r1,#0xff	; 0380354C
	and r2,r1	; 0380354E
	lsl r1,r2,#0x10	; 03803550
	lsr r1,r1,#0x10	; 03803552
	bl loc_03803274	; 03803554
P2_Entry_03803558:
	mov r0,#0x0	; 03803558
	bl P2_Entry_03803228	; 0380355A
	b P2_Entry_038035FA	; 0380355E
P2_Entry_03803560:
	ldr r0,[pool_03803604]	; 03803560
	ldr r0,[r0,#0x20]	; 03803562
	cmp r0,#0x1	; 03803564
	bne P2_Entry_038035C2	; 03803566
	mov r4,#0x0	; 03803568
	add r7,r4,#0x0	; 0380356A
	b P2_Entry_038035A8	; 0380356C
P2_Entry_0380356E:
	lsl r2,r4,#0x1	; 0380356E
	ldr r0,[pool_03803604]	; 03803570
	add r6,r0,r2	; 03803572
	add r0,r4,#0x0	; 03803574
	ldr r2,[pool_03803610]	; 03803576
	mul r0,r2	; 03803578
	bl loc_03803620	; 0380357A
	ldr r1,[r5,#0xc]	; 0380357E
	add r0,r1,r0	; 03803580
	ldr r1,[pool_03803610]	; 03803582
	bl loc_03803620	; 03803584
	add r0,r6,#0x0	; 03803588
	add r0,#0xcc	; 0380358A
	strh r1,[r0,#0x0]	; 0380358C
	str r4,[sp,#0x0]	; 0380358E
	add r1,r4,#0x0	; 03803590
	mov r0,#0x28	; 03803592
	mul r1,r0	; 03803594
	ldr r0,[pool_03803614]	; 03803596
	add r0,r0,r1	; 03803598
	mov r1,#0xcc	; 0380359A
	ldrsh r1,[r6,r1]	; 0380359C
	add r2,r7,#0x0	; 0380359E
	ldr r3,[pool_03803618]	; 038035A0
	bl P2_Entry_037FF32C	; 038035A2
	add r4,r4,#0x1	; 038035A6
P2_Entry_038035A8:
	ldr r1,[r5,#0x8]	; 038035A8
	cmp r4,r1	; 038035AA
	bcc P2_Entry_0380356E	; 038035AC
	ldr r0,[r5,#0x4]	; 038035AE
	lsl r0,r0,#0x10	; 038035B0
	lsr r0,r0,#0x10	; 038035B2
	mov r1,#0x0	; 038035B4
	bl loc_03803274	; 038035B6
	mov r1,#0x2	; 038035BA
	ldr r0,[pool_03803604]	; 038035BC
	str r1,[r0,#0x20]	; 038035BE
	b P2_Entry_038035FA	; 038035C0
P2_Entry_038035C2:
	lsl r0,r1,#0x10	; 038035C2
	lsr r0,r0,#0x10	; 038035C4
	mov r1,#0x3	; 038035C6
	bl loc_03803274	; 038035C8
	b P2_Entry_038035FA	; 038035CC
P2_Entry_038035CE:
	ldr r0,[pool_03803604]	; 038035CE
	ldr r0,[r0,#0x20]	; 038035D0
	cmp r0,#0x3	; 038035D2
	bne P2_Entry_038035F0	; 038035D4
	ldr r0,[pool_0380361C]	; 038035D6
	bl P2_Entry_037FF238	; 038035D8
	ldr r0,[r5,#0x4]	; 038035DC
	lsl r0,r0,#0x10	; 038035DE
	lsr r0,r0,#0x10	; 038035E0
	mov r1,#0x0	; 038035E2
	bl loc_03803274	; 038035E4
	mov r1,#0x0	; 038035E8
	ldr r0,[pool_03803604]	; 038035EA
	str r1,[r0,#0x20]	; 038035EC
	b P2_Entry_038035FA	; 038035EE
P2_Entry_038035F0:
	lsl r0,r1,#0x10	; 038035F0
	lsr r0,r0,#0x10	; 038035F2
	mov r1,#0x3	; 038035F4
	bl loc_03803274	; 038035F6
P2_Entry_038035FA:
	add sp,#0xc	; 038035FA
	pop {r4,r5,r6,r7}	; 038035FC
	pop {r3}	; 038035FE
	bx r3	; 03803600
	.byte 0xC0, 0x46	; 03803602
pool_03803604:
	.word P2_BssStart + 0x27A0	; 03803604
pool_03803608:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 03803608
pool_0380360C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 2	; 0380360C
pool_03803610:
	.word 0x00000107	; 03803610
pool_03803614:
	.word 0x03807F48	; 03803614
pool_03803618:
	.word 0x03803469	; 03803618
pool_0380361C:
	.word 0x54505641	; 0380361C

; ===== function loc_03803620 =====
loc_03803620:
	bx pc	; 03803620
	.byte 0xC0, 0x46	; 03803624
.arm

; ===== function loc_03803624 =====
loc_03803624:
	ldr pc,[pool_03803628]	; 03803624
pool_03803628:
loc_03803628:
	.word loc_03805194	; 03803628
.thumb

; ===== function loc_0380362C =====
loc_0380362C:
	push {r4,lr}	; 0380362C
	sub sp,#0x8	; 0380362E
	ldr r1,[pool_0380374C]	; 03803630
	add r2,r0,#0x0	; 03803632
	and r2,r1	; 03803634
	cmp r2,#0x0	; 03803636
	beq loc_0380364A	; 03803638
	mov r4,#0x0	; 0380363A
	add r3,r4,#0x0	; 0380363C
	ldr r1,[pool_03803750]	; 0380363E
loc_03803640:
	lsl r2,r4,#0x1	; 03803640
	strh r3,[r1,r2]	; 03803642
	add r4,r4,#0x1	; 03803644
	cmp r4,#0x10	; 03803646
	blt loc_03803640	; 03803648
loc_0380364A:
	ldr r1,[pool_03803754]	; 0380364A
	add r2,r0,#0x0	; 0380364C
	and r2,r1	; 0380364E
	lsr r1,r2,#0x10	; 03803650
	lsl r2,r1,#0x1	; 03803652
	ldr r1,[pool_03803750]	; 03803654
	strh r0,[r1,r2]	; 03803656
	ldr r2,[pool_03803758]	; 03803658
	and r0,r2	; 0380365A
	cmp r0,#0x0	; 0380365C
	beq loc_03803744	; 0380365E
	ldrh r0,[r1,#0x0]	; 03803660
	ldr r2,[pool_0380375C]	; 03803662
	add r3,r0,#0x0	; 03803664
	and r3,r2	; 03803666
	lsl r2,r3,#0x8	; 03803668
	lsr r4,r2,#0x10	; 0380366A
	cmp r4,#0x3	; 0380366C
	bhi loc_0380373C	; 0380366E
	add r2,r4,r4	; 03803670
P2_SwitchIndexPC_03803670:
	add r2,pc	; 03803672
	ldrh r2,[r2,#(P2_SwitchTable_03803670 - (P2_SwitchIndexPC_03803670 + 4))]	; 03803674
	lsl r2,r2,#0x10	; 03803676
	asr r2,r2,#0x10	; 03803678
P2_SwitchTargetPC_03803670:
	add r2,pc	; 0380367A
	bx r2	; 0380367C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803670:
	.halfword (loc_03803696 + 1) - (P2_SwitchTargetPC_03803670 + 4)
	.halfword (loc_038036AE + 1) - (P2_SwitchTargetPC_03803670 + 4)
	.halfword (loc_0380370C + 1) - (P2_SwitchTargetPC_03803670 + 4)
	.halfword (loc_03803686 + 1) - (P2_SwitchTargetPC_03803670 + 4)
P2_SwitchTable_03803670End:
loc_03803686:
	mov r2,#0xff	; 03803686
	and r0,r2	; 03803688
	lsl r0,r0,#0x10	; 0380368A
	lsr r0,r0,#0x10	; 0380368C
	ldrh r1,[r1,#0x2]	; 0380368E
	bl loc_03803430	; 03803690
	b loc_03803744	; 03803694
loc_03803696:
	mov r0,#0x0	; 03803696
	add r1,r4,#0x0	; 03803698
	add r2,r0,#0x0	; 0380369A
	bl loc_03803180	; 0380369C
	cmp r0,#0x0	; 038036A0
	bne loc_03803744	; 038036A2
	add r0,r4,#0x0	; 038036A4
	mov r1,#0x4	; 038036A6
	bl loc_03803274	; 038036A8
	b loc_03803744	; 038036AC
loc_038036AE:
	ldr r2,[r1,#0x20]	; 038036AE
	cmp r2,#0x0	; 038036B0
	beq loc_038036BE	; 038036B2
	add r0,r4,#0x0	; 038036B4
	mov r1,#0x3	; 038036B6
	bl loc_03803274	; 038036B8
	b loc_03803744	; 038036BC
loc_038036BE:
	mov r2,#0xff	; 038036BE
	and r0,r2	; 038036C0
	lsl r0,r0,#0x10	; 038036C2
	lsr r3,r0,#0x10	; 038036C4
	cmp r3,#0x0	; 038036C6
	beq loc_038036CE	; 038036C8
	cmp r3,#0x4	; 038036CA
	bls loc_038036D8	; 038036CC
loc_038036CE:
	add r0,r4,#0x0	; 038036CE
	mov r1,#0x2	; 038036D0
	bl loc_03803274	; 038036D2
	b loc_03803744	; 038036D6
loc_038036D8:
	ldrh r1,[r1,#0x2]	; 038036D8
	ldr r0,[pool_03803760]	; 038036DA
	cmp r1,r0	; 038036DC
	bcc loc_038036EA	; 038036DE
	add r0,r4,#0x0	; 038036E0
	mov r1,#0x2	; 038036E2
	bl loc_03803274	; 038036E4
	b loc_03803744	; 038036E8
loc_038036EA:
	str r1,[sp,#0x0]	; 038036EA
	mov r0,#0x0	; 038036EC
	add r1,r4,#0x0	; 038036EE
	mov r2,#0x2	; 038036F0
	bl loc_03803180	; 038036F2
	cmp r0,#0x0	; 038036F6
	bne loc_03803704	; 038036F8
	add r0,r4,#0x0	; 038036FA
	mov r1,#0x4	; 038036FC
	bl loc_03803274	; 038036FE
	b loc_03803744	; 03803702
loc_03803704:
	mov r1,#0x1	; 03803704
	ldr r0,[pool_03803750]	; 03803706
	str r1,[r0,#0x20]	; 03803708
	b loc_03803744	; 0380370A
loc_0380370C:
	ldr r0,[r1,#0x20]	; 0380370C
	cmp r0,#0x2	; 0380370E
	beq loc_0380371C	; 03803710
	add r0,r4,#0x0	; 03803712
	mov r1,#0x3	; 03803714
	bl loc_03803274	; 03803716
	b loc_03803744	; 0380371A
loc_0380371C:
	mov r0,#0x0	; 0380371C
	add r1,r4,#0x0	; 0380371E
	add r2,r0,#0x0	; 03803720
	bl loc_03803180	; 03803722
	cmp r0,#0x0	; 03803726
	bne loc_03803734	; 03803728
	add r0,r4,#0x0	; 0380372A
	mov r1,#0x4	; 0380372C
	bl loc_03803274	; 0380372E
	b loc_03803744	; 03803732
loc_03803734:
	mov r1,#0x3	; 03803734
	ldr r0,[pool_03803750]	; 03803736
	str r1,[r0,#0x20]	; 03803738
	b loc_03803744	; 0380373A
loc_0380373C:
	add r0,r4,#0x0	; 0380373C
	mov r1,#0x1	; 0380373E
	bl loc_03803274	; 03803740
loc_03803744:
	add sp,#0x8	; 03803744
	pop {r4}	; 03803746
	pop {r3}	; 03803748
	bx r3	; 0380374A
pool_0380374C:
loc_0380374C:
	.word 0x02000000	; 0380374C
pool_03803750:
loc_03803750:
	.word P2_BssStart + 0x27A0	; 03803750
pool_03803754:
loc_03803754:
	.word 0x000F0000	; 03803754
pool_03803758:
loc_03803758:
	.word 0x01000000	; 03803758
pool_0380375C:
loc_0380375C:
	.word 0x0000FF00	; 0380375C
pool_03803760:
loc_03803760:
	.word 0x00000107	; 03803760

; ===== function loc_03803764 =====
loc_03803764:
	push {r4,r5,r6,r7,lr}	; 03803764
	sub sp,#0x4	; 03803766
	mov r3,#0x0	; 03803768
	ldr r0,[pool_03803828]	; 0380376A
	str r3,[r0,#0x20]	; 0380376C
	mov r1,#0x1e	; 0380376E
	str r1,[r0,#0x28]	; 03803770
	mov r1,#0x5	; 03803772
	str r1,[r0,#0x24]	; 03803774
	add r2,r3,#0x0	; 03803776
loc_03803778:
	lsl r1,r3,#0x1	; 03803778
	strh r2,[r0,r1]	; 0380377A
	add r3,r3,#0x1	; 0380377C
	cmp r3,#0x10	; 0380377E
	blt loc_03803778	; 03803780
	bl loc_037FF494	; 03803782
	cmp r0,#0x0	; 03803786
	bne loc_0380378E	; 03803788
	bl loc_037FF4A0	; 0380378A
loc_0380378E:
	mov r4,#0x0	; 0380378E
	ldr r6,[pool_0380382C]	; 03803790
	mov r7,#0x28	; 03803792
loc_03803794:
	add r0,r4,#0x0	; 03803794
	mul r0,r7	; 03803796
	add r5,r6,r0	; 03803798
	add r0,r5,#0x0	; 0380379A
	bl loc_037FF3EC	; 0380379C
	add r0,r5,#0x0	; 038037A0
	ldr r1,[pool_03803830]	; 038037A2
	bl loc_037FF2C0	; 038037A4
	add r4,r4,#0x1	; 038037A8
	cmp r4,#0x4	; 038037AA
	blt loc_03803794	; 038037AC
	mov r6,#0x1	; 038037AE
	ldr r5,[pool_03803834]	; 038037B0
	mov r4,#0x80	; 038037B2
	b loc_038037BC	; 038037B4
loc_038037B6:
	add r0,r6,#0x0	; 038037B6
	bl loc_03804CB8	; 038037B8
loc_038037BC:
	ldrh r0,[r5,#0x0]	; 038037BC
	and r0,r4	; 038037BE
	cmp r0,#0x0	; 038037C0
	bne loc_038037B6	; 038037C2
	ldr r0,[pool_03803838]	; 038037C4
	strh r0,[r5,#0x0]	; 038037C6
	mov r1,#0x84	; 038037C8
	ldr r0,[pool_0380383C]	; 038037CA
	strh r1,[r0,#0x0]	; 038037CC
	mov r6,#0x1	; 038037CE
	ldr r5,[pool_03803834]	; 038037D0
	mov r4,#0x80	; 038037D2
	b loc_038037DC	; 038037D4
loc_038037D6:
	add r0,r6,#0x0	; 038037D6
	bl loc_03804CB8	; 038037D8
loc_038037DC:
	ldrh r0,[r5,#0x0]	; 038037DC
	and r0,r4	; 038037DE
	cmp r0,#0x0	; 038037E0
	bne loc_038037D6	; 038037E2
	mov r1,#0x0	; 038037E4
	ldr r0,[pool_0380383C]	; 038037E6
	strh r1,[r0,#0x0]	; 038037E8
	mov r6,#0x1	; 038037EA
	ldr r5,[pool_03803834]	; 038037EC
	mov r4,#0x80	; 038037EE
	b loc_038037F8	; 038037F0
loc_038037F2:
	add r0,r6,#0x0	; 038037F2
	bl loc_03804CB8	; 038037F4
loc_038037F8:
	ldrh r0,[r5,#0x0]	; 038037F8
	and r0,r4	; 038037FA
	cmp r0,#0x0	; 038037FC
	bne loc_038037F2	; 038037FE
	ldr r0,[pool_03803840]	; 03803800
	strh r0,[r5,#0x0]	; 03803802
	mov r1,#0x0	; 03803804
	ldr r0,[pool_0380383C]	; 03803806
	strh r1,[r0,#0x0]	; 03803808
	mov r6,#0x1	; 0380380A
	ldr r5,[pool_03803834]	; 0380380C
	mov r4,#0x80	; 0380380E
	b loc_03803818	; 03803810
loc_03803812:
	add r0,r6,#0x0	; 03803812
	bl loc_03804CB8	; 03803814
loc_03803818:
	ldrh r0,[r5,#0x0]	; 03803818
	and r0,r4	; 0380381A
	cmp r0,#0x0	; 0380381C
	bne loc_03803812	; 0380381E
	add sp,#0x4	; 03803820
	pop {r4,r5,r6,r7}	; 03803822
	pop {r3}	; 03803824
	bx r3	; 03803826
pool_03803828:
loc_03803828:
	.word P2_BssStart + 0x27A0	; 03803828
pool_0380382C:
loc_0380382C:
	.word 0x03807F48	; 0380382C
pool_03803830:
loc_03803830:
	.word 0x54505641	; 03803830
pool_03803834:
loc_03803834:
	.word REG_SPICNT	; 03803834
pool_03803838:
loc_03803838:
	.word 0x00008A01	; 03803838
pool_0380383C:
loc_0380383C:
	.word REG_SPIDATA	; 0380383C
pool_03803840:
loc_03803840:
	.word 0x00008201	; 03803840

; ===== function loc_03803844 =====
P2_Entry_03803844:
	push {r4,r5,r6,r7,lr}	; 03803844
	sub sp,#0x4	; 03803846
	add r5,r0,#0x0	; 03803848
	add r4,r1,#0x0	; 0380384A
	add r6,r2,#0x0	; 0380384C
	cmp r4,#0x0	; 0380384E
	bge loc_03803854	; 03803850
	neg r4,r4	; 03803852
loc_03803854:
	bl loc_03803BF8	; 03803854
	add r7,r0,#0x0	; 03803858
	cmp r7,#0x0	; 0380385A
	bne loc_0380388A	; 0380385C
	ldr r1,[r5,#0x0]	; 0380385E
	ldr r0,[pool_038039AC]	; 03803860
	and r1,r0	; 03803862
	str r1,[r5,#0x0]	; 03803864
	ldr r1,[r5,#0x0]	; 03803866
	ldr r0,[pool_038039B0]	; 03803868
	and r1,r0	; 0380386A
	str r1,[r5,#0x0]	; 0380386C
	ldr r1,[r5,#0x0]	; 0380386E
	ldr r0,[pool_038039B4]	; 03803870
	and r1,r0	; 03803872
	str r1,[r5,#0x0]	; 03803874
	ldr r1,[r5,#0x0]	; 03803876
	ldr r0,[pool_038039B8]	; 03803878
	and r1,r0	; 0380387A
	ldr r0,[pool_038039BC]	; 0380387C
	orr r1,r0	; 0380387E
	str r1,[r5,#0x0]	; 03803880
	mov r1,#0x0	; 03803882
	ldr r0,[pool_038039C0]	; 03803884
	strh r1,[r0,#0x0]	; 03803886
	b loc_038039A4	; 03803888
loc_0380388A:
	add r0,sp,#0x0	; 0380388A
	add r1,r4,#0x0	; 0380388C
	add r2,r6,#0x0	; 0380388E
	mov r3,#0x0	; 03803890
	bl loc_038039E0	; 03803892
	ldr r1,[r5,#0x0]	; 03803896
	ldr r2,[pool_038039B8]	; 03803898
	and r1,r2	; 0380389A
	mov r2,#0x3	; 0380389C
	and r0,r2	; 0380389E
	lsl r0,r0,#0x19	; 038038A0
	orr r1,r0	; 038038A2
	str r1,[r5,#0x0]	; 038038A4
	ldr r0,[r5,#0x0]	; 038038A6
	ldr r1,[pool_038039AC]	; 038038A8
	and r0,r1	; 038038AA
	add r1,sp,#0x0	; 038038AC
	ldrh r2,[r1,#0x0]	; 038038AE
	ldr r1,[pool_038039C4]	; 038038B0
	and r2,r1	; 038038B2
	orr r0,r2	; 038038B4
	str r0,[r5,#0x0]	; 038038B6
	add r0,sp,#0x0	; 038038B8
	add r1,r4,#0x0	; 038038BA
	add r2,r6,#0x0	; 038038BC
	mov r3,#0x1	; 038038BE
	bl loc_038039E0	; 038038C0
	cmp r0,#0x2	; 038038C4
	bne loc_038038E8	; 038038C6
	ldr r1,[r5,#0x0]	; 038038C8
	lsl r0,r1,#0x5	; 038038CA
	lsr r0,r0,#0x1e	; 038038CC
	cmp r0,#0x1	; 038038CE
	bne loc_038038DE	; 038038D0
	ldr r0,[pool_038039B8]	; 038038D2
	and r1,r0	; 038038D4
	ldr r0,[pool_038039BC]	; 038038D6
	orr r1,r0	; 038038D8
	str r1,[r5,#0x0]	; 038038DA
	b loc_038038E8	; 038038DC
loc_038038DE:
	ldr r0,[pool_038039B8]	; 038038DE
	and r1,r0	; 038038E0
	ldr r0,[pool_038039C8]	; 038038E2
	orr r1,r0	; 038038E4
	str r1,[r5,#0x0]	; 038038E6
loc_038038E8:
	ldr r0,[r5,#0x0]	; 038038E8
	ldr r1,[pool_038039B0]	; 038038EA
	and r0,r1	; 038038EC
	add r1,sp,#0x0	; 038038EE
	ldrh r2,[r1,#0x0]	; 038038F0
	ldr r1,[pool_038039C4]	; 038038F2
	and r2,r1	; 038038F4
	lsl r1,r2,#0xc	; 038038F6
	orr r0,r1	; 038038F8
	str r0,[r5,#0x0]	; 038038FA
	ldr r1,[pool_038039CC]	; 038038FC
	ldr r0,[pool_038039D0]	; 038038FE
	strh r1,[r0,#0x0]	; 03803900
	mov r4,#0x0	; 03803902
	add r6,r4,#0x0	; 03803904
loc_03803906:
	ldr r0,[pool_038039D4]	; 03803906
	strh r6,[r0,#0x0]	; 03803908
	b loc_03803912	; 0380390A
loc_0380390C:
	mov r0,#0x1	; 0380390C
	bl loc_03804CB8	; 0380390E
loc_03803912:
	ldr r0,[pool_038039D0]	; 03803912
	ldrh r1,[r0,#0x0]	; 03803914
	mov r0,#0x80	; 03803916
	and r1,r0	; 03803918
	cmp r1,#0x0	; 0380391A
	bne loc_0380390C	; 0380391C
	add r4,r4,#0x1	; 0380391E
	cmp r4,#0xc	; 03803920
	blt loc_03803906	; 03803922
	ldr r1,[pool_038039D8]	; 03803924
	ldr r0,[pool_038039D0]	; 03803926
	strh r1,[r0,#0x0]	; 03803928
	mov r1,#0x0	; 0380392A
	ldr r0,[pool_038039D4]	; 0380392C
	strh r1,[r0,#0x0]	; 0380392E
	ldr r4,[pool_038039D0]	; 03803930
	mov r6,#0x80	; 03803932
	b loc_0380393C	; 03803934
loc_03803936:
	mov r0,#0x1	; 03803936
	bl loc_03804CB8	; 03803938
loc_0380393C:
	ldrh r0,[r4,#0x0]	; 0380393C
	and r0,r6	; 0380393E
	cmp r0,#0x0	; 03803940
	bne loc_03803936	; 03803942
	cmp r7,#0x2	; 03803944
	bne loc_03803954	; 03803946
	ldr r1,[r5,#0x0]	; 03803948
	ldr r0,[pool_038039B8]	; 0380394A
	and r1,r0	; 0380394C
	ldr r0,[pool_038039BC]	; 0380394E
	orr r1,r0	; 03803950
	str r1,[r5,#0x0]	; 03803952
loc_03803954:
	bl loc_03803BF8	; 03803954
	cmp r0,#0x0	; 03803958
	beq loc_03803990	; 0380395A
	cmp r0,#0x1	; 0380395C
	beq loc_03803980	; 0380395E
	cmp r0,#0x2	; 03803960
	bne loc_038039A0	; 03803962
	ldr r1,[r5,#0x0]	; 03803964
	ldr r0,[pool_038039DC]	; 03803966
	orr r1,r0	; 03803968
	str r1,[r5,#0x0]	; 0380396A
	ldr r1,[r5,#0x0]	; 0380396C
	ldr r0,[pool_038039B8]	; 0380396E
	and r1,r0	; 03803970
	ldr r0,[pool_038039BC]	; 03803972
	orr r1,r0	; 03803974
	str r1,[r5,#0x0]	; 03803976
	mov r1,#0x0	; 03803978
	ldr r0,[pool_038039C0]	; 0380397A
	strh r1,[r0,#0x0]	; 0380397C
	b loc_038039A4	; 0380397E
loc_03803980:
	ldr r1,[r5,#0x0]	; 03803980
	ldr r0,[pool_038039DC]	; 03803982
	orr r1,r0	; 03803984
	str r1,[r5,#0x0]	; 03803986
	mov r1,#0x1	; 03803988
	ldr r0,[pool_038039C0]	; 0380398A
	strh r1,[r0,#0x0]	; 0380398C
	b loc_038039A4	; 0380398E
loc_03803990:
	ldr r1,[r5,#0x0]	; 03803990
	ldr r0,[pool_038039B4]	; 03803992
	and r1,r0	; 03803994
	str r1,[r5,#0x0]	; 03803996
	mov r1,#0x0	; 03803998
	ldr r0,[pool_038039C0]	; 0380399A
	strh r1,[r0,#0x0]	; 0380399C
	b loc_038039A4	; 0380399E
loc_038039A0:
	bl loc_037FF5C4	; 038039A0
loc_038039A4:
	add sp,#0x4	; 038039A4
	pop {r4,r5,r6,r7}	; 038039A6
	pop {r3}	; 038039A8
	bx r3	; 038039AA
pool_038039AC:
loc_038039AC:
	.word 0xFFFFF000	; 038039AC
pool_038039B0:
loc_038039B0:
	.word 0xFF000FFF	; 038039B0
pool_038039B4:
loc_038039B4:
	.word 0xFEFFFFFF	; 038039B4
pool_038039B8:
loc_038039B8:
	.word 0xF9FFFFFF	; 038039B8
pool_038039BC:
loc_038039BC:
	.word 0x06000000	; 038039BC
pool_038039C0:
loc_038039C0:
	.word P2_BssStart + 0x2874	; 038039C0
pool_038039C4:
loc_038039C4:
	.word 0x00000FFF	; 038039C4
pool_038039C8:
loc_038039C8:
	.word REG_DISPCNT_A	; 038039C8
pool_038039CC:
loc_038039CC:
	.word 0x00008A01	; 038039CC
pool_038039D0:
loc_038039D0:
	.word REG_SPICNT	; 038039D0
pool_038039D4:
loc_038039D4:
	.word REG_SPIDATA	; 038039D4
pool_038039D8:
loc_038039D8:
	.word 0x00008201	; 038039D8
pool_038039DC:
loc_038039DC:
	.word 0x01000000	; 038039DC

; ===== function loc_038039E0 =====
loc_038039E0:
	push {r4,r5,r6,r7,lr}	; 038039E0
	sub sp,#0x24	; 038039E2
	add r6,r0,#0x0	; 038039E4
	str r1,[sp,#0x0]	; 038039E6
	str r2,[sp,#0x4]	; 038039E8
	cmp r3,#0x0	; 038039EA
	bne loc_038039F4	; 038039EC
	mov r4,#0xd1	; 038039EE
	mov r7,#0x1	; 038039F0
	b loc_03803A00	; 038039F2
loc_038039F4:
	mov r4,#0x91	; 038039F4
	mov r7,#0x2	; 038039F6
	b loc_03803A00	; 038039F8
loc_038039FA:
	mov r0,#0x1	; 038039FA
	bl loc_03804CB8	; 038039FC
loc_03803A00:
	ldr r5,[pool_03803BE4]	; 03803A00
	ldrh r1,[r5,#0x0]	; 03803A02
	mov r0,#0x80	; 03803A04
	and r1,r0	; 03803A06
	cmp r1,#0x0	; 03803A08
	bne loc_038039FA	; 03803A0A
	ldr r0,[pool_03803BE8]	; 03803A0C
	strh r0,[r5,#0x0]	; 03803A0E
	mov r0,#0xff	; 03803A10
	and r4,r0	; 03803A12
	ldr r0,[pool_03803BEC]	; 03803A14
	strh r4,[r0,#0x0]	; 03803A16
	b loc_03803A20	; 03803A18
loc_03803A1A:
	mov r0,#0x1	; 03803A1A
	bl loc_03804CB8	; 03803A1C
loc_03803A20:
	ldrh r1,[r5,#0x0]	; 03803A20
	mov r0,#0x80	; 03803A22
	and r1,r0	; 03803A24
	cmp r1,#0x0	; 03803A26
	bne loc_03803A1A	; 03803A28
	mov r1,#0x0	; 03803A2A
	ldr r0,[pool_03803BEC]	; 03803A2C
	strh r1,[r0,#0x0]	; 03803A2E
	ldr r5,[pool_03803BE4]	; 03803A30
	b loc_03803A3A	; 03803A32
loc_03803A34:
	mov r0,#0x1	; 03803A34
	bl loc_03804CB8	; 03803A36
loc_03803A3A:
	ldrh r1,[r5,#0x0]	; 03803A3A
	mov r0,#0x80	; 03803A3C
	and r1,r0	; 03803A3E
	cmp r1,#0x0	; 03803A40
	bne loc_03803A34	; 03803A42
	ldr r1,[pool_03803BEC]	; 03803A44
	ldrh r2,[r1,#0x0]	; 03803A46
	mov r0,#0xff	; 03803A48
	and r2,r0	; 03803A4A
	lsl r0,r2,#0x10	; 03803A4C
	lsr r0,r0,#0x8	; 03803A4E
	str r0,[sp,#0x18]	; 03803A50
	strh r4,[r1,#0x0]	; 03803A52
	ldr r5,[pool_03803BE4]	; 03803A54
	b loc_03803A5E	; 03803A56
loc_03803A58:
	mov r0,#0x1	; 03803A58
	bl loc_03804CB8	; 03803A5A
loc_03803A5E:
	ldrh r1,[r5,#0x0]	; 03803A5E
	mov r0,#0x80	; 03803A60
	and r1,r0	; 03803A62
	cmp r1,#0x0	; 03803A64
	bne loc_03803A58	; 03803A66
	ldr r0,[pool_03803BEC]	; 03803A68
	ldrh r2,[r0,#0x0]	; 03803A6A
	mov r1,#0xff	; 03803A6C
	and r2,r1	; 03803A6E
	lsl r1,r2,#0x10	; 03803A70
	lsr r1,r1,#0x10	; 03803A72
	ldr r2,[sp,#0x18]	; 03803A74
	orr r2,r1	; 03803A76
	str r2,[sp,#0x18]	; 03803A78
	ldr r1,[pool_03803BF0]	; 03803A7A
	and r2,r1	; 03803A7C
	asr r1,r2,#0x3	; 03803A7E
	str r1,[sp,#0x18]	; 03803A80
	mov r1,#0x0	; 03803A82
	strh r1,[r0,#0x0]	; 03803A84
	ldr r5,[pool_03803BE4]	; 03803A86
	b loc_03803A90	; 03803A88
loc_03803A8A:
	mov r0,#0x1	; 03803A8A
	bl loc_03804CB8	; 03803A8C
loc_03803A90:
	ldrh r1,[r5,#0x0]	; 03803A90
	mov r0,#0x80	; 03803A92
	and r1,r0	; 03803A94
	cmp r1,#0x0	; 03803A96
	bne loc_03803A8A	; 03803A98
	ldr r1,[pool_03803BEC]	; 03803A9A
	ldrh r2,[r1,#0x0]	; 03803A9C
	mov r0,#0xff	; 03803A9E
	and r2,r0	; 03803AA0
	lsl r0,r2,#0x10	; 03803AA2
	lsr r0,r0,#0x8	; 03803AA4
	str r0,[sp,#0x1c]	; 03803AA6
	strh r4,[r1,#0x0]	; 03803AA8
	ldr r5,[pool_03803BE4]	; 03803AAA
	b loc_03803AB4	; 03803AAC
loc_03803AAE:
	mov r0,#0x1	; 03803AAE
	bl loc_03804CB8	; 03803AB0
loc_03803AB4:
	ldrh r1,[r5,#0x0]	; 03803AB4
	mov r0,#0x80	; 03803AB6
	and r1,r0	; 03803AB8
	cmp r1,#0x0	; 03803ABA
	bne loc_03803AAE	; 03803ABC
	ldr r0,[pool_03803BEC]	; 03803ABE
	ldrh r1,[r0,#0x0]	; 03803AC0
	mov r0,#0xff	; 03803AC2
	and r1,r0	; 03803AC4
	lsl r0,r1,#0x10	; 03803AC6
	lsr r0,r0,#0x10	; 03803AC8
	ldr r1,[sp,#0x1c]	; 03803ACA
	orr r1,r0	; 03803ACC
	str r1,[sp,#0x1c]	; 03803ACE
	ldr r0,[pool_03803BF0]	; 03803AD0
	and r1,r0	; 03803AD2
	asr r1,r1,#0x3	; 03803AD4
	str r1,[sp,#0x1c]	; 03803AD6
	ldr r0,[sp,#0x4]	; 03803AD8
	cmp r0,#0x0	; 03803ADA
	bne loc_03803AE8	; 03803ADC
	ldr r0,[sp,#0x18]	; 03803ADE
	add r0,r0,r1	; 03803AE0
	asr r0,r0,#0x1	; 03803AE2
	strh r0,[r6,#0x0]	; 03803AE4
	mov r7,#0x0	; 03803AE6
loc_03803AE8:
	mov r5,#0x0	; 03803AE8
	ldr r0,[sp,#0x0]	; 03803AEA
	neg r0,r0	; 03803AEC
	str r0,[sp,#0xc]	; 03803AEE
	str r5,[sp,#0x14]	; 03803AF0
	b loc_03803B9E	; 03803AF2
loc_03803AF4:
	ldr r1,[sp,#0x14]	; 03803AF4
	ldr r0,[pool_03803BEC]	; 03803AF6
	strh r1,[r0,#0x0]	; 03803AF8
	b loc_03803B02	; 03803AFA
loc_03803AFC:
	mov r0,#0x1	; 03803AFC
	bl loc_03804CB8	; 03803AFE
loc_03803B02:
	ldr r0,[pool_03803BE4]	; 03803B02
	ldrh r1,[r0,#0x0]	; 03803B04
	mov r0,#0x80	; 03803B06
	and r1,r0	; 03803B08
	cmp r1,#0x0	; 03803B0A
	bne loc_03803AFC	; 03803B0C
	ldr r0,[pool_03803BEC]	; 03803B0E
	ldrh r1,[r0,#0x0]	; 03803B10
	mov r0,#0xff	; 03803B12
	and r1,r0	; 03803B14
	lsl r0,r1,#0x10	; 03803B16
	lsr r0,r0,#0x8	; 03803B18
	str r0,[sp,#0x8]	; 03803B1A
	ldr r0,[pool_03803BEC]	; 03803B1C
	strh r4,[r0,#0x0]	; 03803B1E
	b loc_03803B28	; 03803B20
loc_03803B22:
	mov r0,#0x1	; 03803B22
	bl loc_03804CB8	; 03803B24
loc_03803B28:
	ldr r0,[pool_03803BE4]	; 03803B28
	ldrh r1,[r0,#0x0]	; 03803B2A
	mov r0,#0x80	; 03803B2C
	and r1,r0	; 03803B2E
	cmp r1,#0x0	; 03803B30
	bne loc_03803B22	; 03803B32
	ldr r0,[pool_03803BEC]	; 03803B34
	ldrh r1,[r0,#0x0]	; 03803B36
	mov r0,#0xff	; 03803B38
	and r1,r0	; 03803B3A
	lsl r0,r1,#0x10	; 03803B3C
	lsr r0,r0,#0x10	; 03803B3E
	ldr r1,[sp,#0x8]	; 03803B40
	orr r1,r0	; 03803B42
	str r1,[sp,#0x8]	; 03803B44
	ldr r0,[pool_03803BF0]	; 03803B46
	and r1,r0	; 03803B48
	str r1,[sp,#0x8]	; 03803B4A
	asr r0,r1,#0x3	; 03803B4C
	str r0,[sp,#0x10]	; 03803B4E
	ldr r1,[sp,#0x18]	; 03803B50
	sub r1,r1,r0	; 03803B52
	ldr r0,[sp,#0xc]	; 03803B54
	cmp r1,r0	; 03803B56
	blt loc_03803B8C	; 03803B58
	ldr r0,[sp,#0x0]	; 03803B5A
	cmp r1,r0	; 03803B5C
	bgt loc_03803B8C	; 03803B5E
	ldr r1,[sp,#0x1c]	; 03803B60
	ldr r0,[sp,#0x10]	; 03803B62
	sub r1,r1,r0	; 03803B64
	ldr r0,[sp,#0xc]	; 03803B66
	cmp r1,r0	; 03803B68
	blt loc_03803B8C	; 03803B6A
	ldr r0,[sp,#0x0]	; 03803B6C
	cmp r1,r0	; 03803B6E
	bgt loc_03803B8C	; 03803B70
	add r0,r5,#0x1	; 03803B72
	mov r1,#0x2	; 03803B74
	bl loc_037FE6E4	; 03803B76
	lsl r1,r1,#0x2	; 03803B7A
	add r0,sp,#0x18	; 03803B7C
	ldr r1,[r0,r1]	; 03803B7E
	ldr r0,[sp,#0x10]	; 03803B80
	add r0,r0,r1	; 03803B82
	asr r0,r0,#0x1	; 03803B84
	strh r0,[r6,#0x0]	; 03803B86
	mov r7,#0x0	; 03803B88
	b loc_03803BA4	; 03803B8A
loc_03803B8C:
	add r0,r5,#0x0	; 03803B8C
	mov r1,#0x2	; 03803B8E
	bl loc_037FE6E4	; 03803B90
	lsl r2,r1,#0x2	; 03803B94
	ldr r1,[sp,#0x10]	; 03803B96
	add r0,sp,#0x18	; 03803B98
	str r1,[r0,r2]	; 03803B9A
	add r5,r5,#0x1	; 03803B9C
loc_03803B9E:
	ldr r0,[sp,#0x4]	; 03803B9E
	cmp r5,r0	; 03803BA0
	blt loc_03803AF4	; 03803BA2
loc_03803BA4:
	cmp r7,#0x0	; 03803BA4
	beq loc_03803BB2	; 03803BA6
	ldr r1,[sp,#0x18]	; 03803BA8
	ldr r0,[sp,#0x1c]	; 03803BAA
	add r0,r1,r0	; 03803BAC
	asr r0,r0,#0x1	; 03803BAE
	strh r0,[r6,#0x0]	; 03803BB0
loc_03803BB2:
	ldr r0,[pool_03803BF4]	; 03803BB2
	ldr r4,[pool_03803BE4]	; 03803BB4
	strh r0,[r4,#0x0]	; 03803BB6
	mov r1,#0x0	; 03803BB8
	ldr r0,[pool_03803BEC]	; 03803BBA
	strh r1,[r0,#0x0]	; 03803BBC
	mov r5,#0x80	; 03803BBE
	b loc_03803BC8	; 03803BC0
loc_03803BC2:
	mov r0,#0x1	; 03803BC2
	bl loc_03804CB8	; 03803BC4
loc_03803BC8:
	ldrh r0,[r4,#0x0]	; 03803BC8
	and r0,r5	; 03803BCA
	cmp r0,#0x0	; 03803BCC
	bne loc_03803BC2	; 03803BCE
	ldrh r1,[r6,#0x0]	; 03803BD0
	mov r0,#0x7	; 03803BD2
	bic r1,r0	; 03803BD4
	strh r1,[r6,#0x0]	; 03803BD6
	add r0,r7,#0x0	; 03803BD8
	add sp,#0x24	; 03803BDA
	pop {r4,r5,r6,r7}	; 03803BDC
	pop {r3}	; 03803BDE
	bx r3	; 03803BE0
	.byte 0xC0, 0x46	; 03803BE4
pool_03803BE4:
loc_03803BE4:
	.word REG_SPICNT	; 03803BE4
pool_03803BE8:
loc_03803BE8:
	.word 0x00008A01	; 03803BE8
pool_03803BEC:
loc_03803BEC:
	.word REG_SPIDATA	; 03803BEC
pool_03803BF0:
loc_03803BF0:
	.word 0x00007FF8	; 03803BF0
pool_03803BF4:
loc_03803BF4:
	.word 0x00008201	; 03803BF4

; ===== function loc_03803BF8 =====
loc_03803BF8:
	push {r4,r5,r6,lr}	; 03803BF8
	ldr r0,[pool_03803D14]	; 03803BFA
	bl loc_03802534	; 03803BFC
	mov r6,#0x1	; 03803C00
	ldr r5,[pool_03803D18]	; 03803C02
	mov r4,#0x80	; 03803C04
	b loc_03803C0E	; 03803C06
loc_03803C08:
	add r0,r6,#0x0	; 03803C08
	bl loc_03804CB8	; 03803C0A
loc_03803C0E:
	ldrh r0,[r5,#0x0]	; 03803C0E
	and r0,r4	; 03803C10
	cmp r0,#0x0	; 03803C12
	bne loc_03803C08	; 03803C14
	ldr r0,[pool_03803D1C]	; 03803C16
	strh r0,[r5,#0x0]	; 03803C18
	mov r1,#0x84	; 03803C1A
	ldr r0,[pool_03803D20]	; 03803C1C
	strh r1,[r0,#0x0]	; 03803C1E
	mov r6,#0x1	; 03803C20
	ldr r5,[pool_03803D18]	; 03803C22
	mov r4,#0x80	; 03803C24
	b loc_03803C2E	; 03803C26
loc_03803C28:
	add r0,r6,#0x0	; 03803C28
	bl loc_03804CB8	; 03803C2A
loc_03803C2E:
	ldrh r0,[r5,#0x0]	; 03803C2E
	and r0,r4	; 03803C30
	cmp r0,#0x0	; 03803C32
	bne loc_03803C28	; 03803C34
	mov r1,#0x0	; 03803C36
	ldr r0,[pool_03803D20]	; 03803C38
	strh r1,[r0,#0x0]	; 03803C3A
	mov r6,#0x1	; 03803C3C
	ldr r5,[pool_03803D18]	; 03803C3E
	mov r4,#0x80	; 03803C40
	b loc_03803C4A	; 03803C42
loc_03803C44:
	add r0,r6,#0x0	; 03803C44
	bl loc_03804CB8	; 03803C46
loc_03803C4A:
	ldrh r0,[r5,#0x0]	; 03803C4A
	and r0,r4	; 03803C4C
	cmp r0,#0x0	; 03803C4E
	bne loc_03803C44	; 03803C50
	ldr r0,[pool_03803D24]	; 03803C52
	strh r0,[r5,#0x0]	; 03803C54
	mov r1,#0x0	; 03803C56
	ldr r0,[pool_03803D20]	; 03803C58
	strh r1,[r0,#0x0]	; 03803C5A
	mov r6,#0x1	; 03803C5C
	ldr r5,[pool_03803D18]	; 03803C5E
	mov r4,#0x80	; 03803C60
	b loc_03803C6A	; 03803C62
loc_03803C64:
	add r0,r6,#0x0	; 03803C64
	bl loc_03804CB8	; 03803C66
loc_03803C6A:
	ldrh r0,[r5,#0x0]	; 03803C6A
	and r0,r4	; 03803C6C
	cmp r0,#0x0	; 03803C6E
	bne loc_03803C64	; 03803C70
	ldr r0,[pool_03803D28]	; 03803C72
	ldrh r0,[r0,#0x0]	; 03803C74
	cmp r0,#0x0	; 03803C76
	bne loc_03803C8E	; 03803C78
	ldr r0,[pool_03803D2C]	; 03803C7A
	ldrh r1,[r0,#0x0]	; 03803C7C
	mov r0,#0x40	; 03803C7E
	and r1,r0	; 03803C80
	cmp r1,#0x0	; 03803C82
	bne loc_03803C8A	; 03803C84
	mov r0,#0x1	; 03803C86
	b loc_03803D0C	; 03803C88
loc_03803C8A:
	mov r0,#0x0	; 03803C8A
	b loc_03803D0C	; 03803C8C
loc_03803C8E:
	ldr r0,[pool_03803D2C]	; 03803C8E
	ldrh r1,[r0,#0x0]	; 03803C90
	mov r0,#0x40	; 03803C92
	and r1,r0	; 03803C94
	cmp r1,#0x0	; 03803C96
	bne loc_03803C9E	; 03803C98
	mov r0,#0x1	; 03803C9A
	b loc_03803D0C	; 03803C9C
loc_03803C9E:
	ldr r0,[pool_03803D1C]	; 03803C9E
	strh r0,[r5,#0x0]	; 03803CA0
	mov r1,#0x84	; 03803CA2
	ldr r0,[pool_03803D20]	; 03803CA4
	strh r1,[r0,#0x0]	; 03803CA6
	mov r6,#0x1	; 03803CA8
	ldr r5,[pool_03803D18]	; 03803CAA
	mov r4,#0x80	; 03803CAC
	b loc_03803CB6	; 03803CAE
loc_03803CB0:
	add r0,r6,#0x0	; 03803CB0
	bl loc_03804CB8	; 03803CB2
loc_03803CB6:
	ldrh r0,[r5,#0x0]	; 03803CB6
	and r0,r4	; 03803CB8
	cmp r0,#0x0	; 03803CBA
	bne loc_03803CB0	; 03803CBC
	mov r1,#0x0	; 03803CBE
	ldr r0,[pool_03803D20]	; 03803CC0
	strh r1,[r0,#0x0]	; 03803CC2
	mov r6,#0x1	; 03803CC4
	ldr r5,[pool_03803D18]	; 03803CC6
	mov r4,#0x80	; 03803CC8
	b loc_03803CD2	; 03803CCA
loc_03803CCC:
	add r0,r6,#0x0	; 03803CCC
	bl loc_03804CB8	; 03803CCE
loc_03803CD2:
	ldrh r0,[r5,#0x0]	; 03803CD2
	and r0,r4	; 03803CD4
	cmp r0,#0x0	; 03803CD6
	bne loc_03803CCC	; 03803CD8
	ldr r0,[pool_03803D24]	; 03803CDA
	strh r0,[r5,#0x0]	; 03803CDC
	mov r1,#0x0	; 03803CDE
	ldr r0,[pool_03803D20]	; 03803CE0
	strh r1,[r0,#0x0]	; 03803CE2
	mov r6,#0x1	; 03803CE4
	ldr r5,[pool_03803D18]	; 03803CE6
	mov r4,#0x80	; 03803CE8
	b loc_03803CF2	; 03803CEA
loc_03803CEC:
	add r0,r6,#0x0	; 03803CEC
	bl loc_03804CB8	; 03803CEE
loc_03803CF2:
	ldrh r0,[r5,#0x0]	; 03803CF2
	and r0,r4	; 03803CF4
	cmp r0,#0x0	; 03803CF6
	bne loc_03803CEC	; 03803CF8
	ldr r0,[pool_03803D2C]	; 03803CFA
	ldrh r1,[r0,#0x0]	; 03803CFC
	mov r0,#0x40	; 03803CFE
	and r1,r0	; 03803D00
	cmp r1,#0x0	; 03803D02
	beq loc_03803D0A	; 03803D04
	mov r0,#0x0	; 03803D06
	b loc_03803D0C	; 03803D08
loc_03803D0A:
	mov r0,#0x2	; 03803D0A
loc_03803D0C:
	pop {r4,r5,r6}	; 03803D0C
	pop {r3}	; 03803D0E
	bx r3	; 03803D10
	.byte 0xC0, 0x46	; 03803D14
pool_03803D14:
loc_03803D14:
	.word 0x00008000	; 03803D14
pool_03803D18:
loc_03803D18:
	.word REG_SPICNT	; 03803D18
pool_03803D1C:
loc_03803D1C:
	.word 0x00008A01	; 03803D1C
pool_03803D20:
loc_03803D20:
	.word REG_SPIDATA	; 03803D20
pool_03803D24:
loc_03803D24:
	.word 0x00008201	; 03803D24
pool_03803D28:
loc_03803D28:
	.word P2_BssStart + 0x2874	; 03803D28
pool_03803D2C:
loc_03803D2C:
	.word REG_KEYXY	; 03803D2C
P2_Entry_03803D30:
	push {lr}	; 03803D30
	sub sp,#0x4	; 03803D32
	add r0,sp,#0x0	; 03803D34
	bl loc_03804434	; 03803D36
	add r0,sp,#0x0	; 03803D3A
	ldrh r2,[r0,#0x0]	; 03803D3C
	mov r0,#0x1	; 03803D3E
	add r1,r2,#0x0	; 03803D40
	and r1,r0	; 03803D42
	cmp r1,#0x0	; 03803D44
	beq P2_Entry_03803D4C	; 03803D46
	mov r0,#0x0	; 03803D48
	b P2_Entry_03803D56	; 03803D4A
P2_Entry_03803D4C:
	mov r1,#0x2	; 03803D4C
	and r2,r1	; 03803D4E
	cmp r2,#0x0	; 03803D50
	bne P2_Entry_03803D56	; 03803D52
	mov r0,#0x0	; 03803D54
P2_Entry_03803D56:
	add sp,#0x4	; 03803D56
	pop {r3}	; 03803D58
	bx r3	; 03803D5A
P2_Entry_03803D5C:
	push {lr}	; 03803D5C
	sub sp,#0x4	; 03803D5E
	add r0,sp,#0x0	; 03803D60
	bl loc_03804434	; 03803D62
	add r0,sp,#0x0	; 03803D66
	ldrh r1,[r0,#0x0]	; 03803D68
	mov r0,#0x1	; 03803D6A
	and r1,r0	; 03803D6C
	cmp r1,#0x0	; 03803D6E
	beq P2_Entry_03803D74	; 03803D70
	mov r0,#0x0	; 03803D72
P2_Entry_03803D74:
	add sp,#0x4	; 03803D74
	pop {r3}	; 03803D76
	bx r3	; 03803D78
	.byte 0x00, 0x00	; 03803D7A
P2_Entry_03803D7C:
	push {r4,r5,lr}	; 03803D7C
	sub sp,#0x4	; 03803D7E
	add r4,r0,#0x0	; 03803D80
	bl loc_037FE0D0	; 03803D82
	add r5,r0,#0x0	; 03803D86
	mov r0,#0x1	; 03803D88
	bl P2_Entry_03803260	; 03803D8A
	cmp r0,#0x0	; 03803D8E
	bne P2_Entry_03803DA6	; 03803D90
	add r0,r5,#0x0	; 03803D92
	bl loc_037FE0F4	; 03803D94
	ldr r0,[r4,#0x4]	; 03803D98
	lsl r0,r0,#0x10	; 03803D9A
	lsr r0,r0,#0x10	; 03803D9C
	mov r1,#0x4	; 03803D9E
	bl loc_03803274	; 03803DA0
	b P2_Entry_03803EC6	; 03803DA4
P2_Entry_03803DA6:
	mov r0,#0x1	; 03803DA6
	bl loc_03803250	; 03803DA8
	add r0,r5,#0x0	; 03803DAC
	bl loc_037FE0F4	; 03803DAE
	ldr r0,[r4,#0x4]	; 03803DB2
	sub r0,#0x20	; 03803DB4
	cmp r0,#0xd	; 03803DB6
	bhi P2_Entry_03803EA0	; 03803DB8
	add r0,r0,r0	; 03803DBA
P2_SwitchIndexPC_03803DBA:
	add r0,pc	; 03803DBC
	ldrh r0,[r0,#(P2_SwitchTable_03803DBA - (P2_SwitchIndexPC_03803DBA + 4))]	; 03803DBE
	lsl r0,r0,#0x10	; 03803DC0
	asr r0,r0,#0x10	; 03803DC2
P2_SwitchTargetPC_03803DBA:
	add r0,pc	; 03803DC4
	bx r0	; 03803DC6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803DBA:
	.halfword (P2_Case_03803DE4 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803DEA + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803DF0 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803DF8 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Entry_03803EA0 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803E20 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Entry_03803EA0 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803E4C + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Entry_03803EA0 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Entry_03803EA0 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Entry_03803EA0 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803E70 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803E92 + 1) - (P2_SwitchTargetPC_03803DBA + 4)
	.halfword (P2_Case_03803E9A + 1) - (P2_SwitchTargetPC_03803DBA + 4)
P2_SwitchTable_03803DBAEnd:
P2_Case_03803DE4:
	bl P2_Entry_03804500	; 03803DE4
	b P2_Entry_03803EB4	; 03803DE8
P2_Case_03803DEA:
	bl P2_Entry_038044B4	; 03803DEA
	b P2_Entry_03803EB4	; 03803DEE
P2_Case_03803DF0:
	ldr r0,[r4,#0x10]	; 03803DF0
	bl loc_03804434	; 03803DF2
	b P2_Entry_03803EB4	; 03803DF6
P2_Case_03803DF8:
	bl P2_Entry_03803D5C	; 03803DF8
	cmp r0,#0x0	; 03803DFC
	bne P2_Entry_03803E14	; 03803DFE
	ldr r0,[r4,#0x4]	; 03803E00
	lsl r0,r0,#0x10	; 03803E02
	lsr r0,r0,#0x10	; 03803E04
	mov r1,#0x3	; 03803E06
	bl loc_03803274	; 03803E08
	mov r0,#0x1	; 03803E0C
	bl P2_Entry_03803228	; 03803E0E
	b P2_Entry_03803EC6	; 03803E12
P2_Entry_03803E14:
	ldr r0,[r4,#0x8]	; 03803E14
	ldr r1,[r4,#0xc]	; 03803E16
	ldr r2,[r4,#0x10]	; 03803E18
	bl loc_03804338	; 03803E1A
	b P2_Entry_03803EB4	; 03803E1E
P2_Case_03803E20:
	bl P2_Entry_03803D30	; 03803E20
	cmp r0,#0x0	; 03803E24
	bne P2_Entry_03803E3C	; 03803E26
	ldr r0,[r4,#0x4]	; 03803E28
	lsl r0,r0,#0x10	; 03803E2A
	lsr r0,r0,#0x10	; 03803E2C
	mov r1,#0x3	; 03803E2E
	bl loc_03803274	; 03803E30
	mov r0,#0x1	; 03803E34
	bl P2_Entry_03803228	; 03803E36
	b P2_Entry_03803EC6	; 03803E3A
P2_Entry_03803E3C:
	ldr r0,[r4,#0x8]	; 03803E3C
	ldr r1,[r4,#0xc]	; 03803E3E
	lsl r1,r1,#0x10	; 03803E40
	lsr r1,r1,#0x10	; 03803E42
	ldr r2,[r4,#0x10]	; 03803E44
	bl P2_Entry_0380422C	; 03803E46
	b P2_Entry_03803EB4	; 03803E4A
P2_Case_03803E4C:
	bl P2_Entry_03803D30	; 03803E4C
	cmp r0,#0x0	; 03803E50
	bne P2_Entry_03803E68	; 03803E52
	ldr r0,[r4,#0x4]	; 03803E54
	lsl r0,r0,#0x10	; 03803E56
	lsr r0,r0,#0x10	; 03803E58
	mov r1,#0x3	; 03803E5A
	bl loc_03803274	; 03803E5C
	mov r0,#0x1	; 03803E60
	bl P2_Entry_03803228	; 03803E62
	b P2_Entry_03803EC6	; 03803E66
P2_Entry_03803E68:
	ldr r0,[r4,#0x8]	; 03803E68
	bl P2_Entry_0380415C	; 03803E6A
	b P2_Entry_03803EB4	; 03803E6E
P2_Case_03803E70:
	bl P2_Entry_03803D30	; 03803E70
	cmp r0,#0x0	; 03803E74
	bne P2_Entry_03803E8C	; 03803E76
	ldr r0,[r4,#0x4]	; 03803E78
	lsl r0,r0,#0x10	; 03803E7A
	lsr r0,r0,#0x10	; 03803E7C
	mov r1,#0x3	; 03803E7E
	bl loc_03803274	; 03803E80
	mov r0,#0x1	; 03803E84
	bl P2_Entry_03803228	; 03803E86
	b P2_Entry_03803EC6	; 03803E8A
P2_Entry_03803E8C:
	bl P2_Entry_03804110	; 03803E8C
	b P2_Entry_03803EB4	; 03803E90
P2_Case_03803E92:
	ldr r0,[r4,#0x10]	; 03803E92
	bl P2_Entry_0380406C	; 03803E94
	b P2_Entry_03803EB4	; 03803E98
P2_Case_03803E9A:
	bl P2_Entry_03804020	; 03803E9A
	b P2_Entry_03803EB4	; 03803E9E
P2_Entry_03803EA0:
	mov r0,#0x1	; 03803EA0
	bl P2_Entry_03803228	; 03803EA2
	ldr r0,[r4,#0x4]	; 03803EA6
	lsl r0,r0,#0x10	; 03803EA8
	lsr r0,r0,#0x10	; 03803EAA
	mov r1,#0x1	; 03803EAC
	bl loc_03803274	; 03803EAE
	b P2_Entry_03803EC6	; 03803EB2
P2_Entry_03803EB4:
	ldr r0,[r4,#0x4]	; 03803EB4
	lsl r0,r0,#0x10	; 03803EB6
	lsr r0,r0,#0x10	; 03803EB8
	mov r1,#0x0	; 03803EBA
	bl loc_03803274	; 03803EBC
	mov r0,#0x1	; 03803EC0
	bl P2_Entry_03803228	; 03803EC2
P2_Entry_03803EC6:
	add sp,#0x4	; 03803EC6
	pop {r4,r5}	; 03803EC8
	pop {r3}	; 03803ECA
	bx r3	; 03803ECC
	.byte 0x00, 0x00	; 03803ECE

; ===== function loc_03803ED0 =====
loc_03803ED0:
	push {r4,r5,r6,r7,lr}	; 03803ED0
	sub sp,#0xc	; 03803ED2
	ldr r1,[pool_03803FF0]	; 03803ED4
	add r5,r0,#0x0	; 03803ED6
	and r5,r1	; 03803ED8
	cmp r5,#0x0	; 03803EDA
	beq loc_03803EEE	; 03803EDC
	mov r5,#0x0	; 03803EDE
	add r6,r5,#0x0	; 03803EE0
	ldr r7,[pool_03803FF4]	; 03803EE2
loc_03803EE4:
	lsl r1,r5,#0x1	; 03803EE4
	strh r6,[r7,r1]	; 03803EE6
	add r5,r5,#0x1	; 03803EE8
	cmp r5,#0x10	; 03803EEA
	blt loc_03803EE4	; 03803EEC
loc_03803EEE:
	ldr r1,[pool_03803FF8]	; 03803EEE
	add r5,r0,#0x0	; 03803EF0
	and r5,r1	; 03803EF2
	lsr r1,r5,#0x10	; 03803EF4
	lsl r5,r1,#0x1	; 03803EF6
	ldr r1,[pool_03803FF4]	; 03803EF8
	strh r0,[r1,r5]	; 03803EFA
	ldr r5,[pool_03803FFC]	; 03803EFC
	and r0,r5	; 03803EFE
	cmp r0,#0x0	; 03803F00
	beq loc_03803FE8	; 03803F02
	ldrh r0,[r1,#0x0]	; 03803F04
	ldr r7,[pool_03804000]	; 03803F06
	add r5,r0,#0x0	; 03803F08
	and r5,r7	; 03803F0A
	lsl r5,r5,#0x8	; 03803F0C
	lsr r6,r5,#0x10	; 03803F0E
	add r5,r6,#0x0	; 03803F10
	sub r5,#0x22	; 03803F12
	cmp r5,#0xa	; 03803F14
	bhi loc_03803FCE	; 03803F16
	add r5,r5,r5	; 03803F18
P2_SwitchIndexPC_03803F18:
	add r5,pc	; 03803F1A
	ldrh r5,[r5,#(P2_SwitchTable_03803F18 - (P2_SwitchIndexPC_03803F18 + 4))]	; 03803F1C
	lsl r5,r5,#0x10	; 03803F1E
	asr r5,r5,#0x10	; 03803F20
P2_SwitchTargetPC_03803F18:
	add r5,pc	; 03803F22
	bx r5	; 03803F24
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03803F18:
	.halfword (loc_03803F3C + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803F66 + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FCE + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803F98 + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FCE + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FC4 + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FCE + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FCE + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FCE + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803FCE + 1) - (P2_SwitchTargetPC_03803F18 + 4)
	.halfword (loc_03803F3C + 1) - (P2_SwitchTargetPC_03803F18 + 4)
P2_SwitchTable_03803F18End:
loc_03803F3C:
	ldrh r4,[r1,#0x4]	; 03803F3C
	and r4,r7	; 03803F3E
	lsr r4,r4,#0x8	; 03803F40
	mov r5,#0xff	; 03803F42
	and r0,r5	; 03803F44
	lsl r0,r0,#0x18	; 03803F46
	ldrh r1,[r1,#0x2]	; 03803F48
	lsl r1,r1,#0x8	; 03803F4A
	orr r0,r1	; 03803F4C
	orr r4,r0	; 03803F4E
	ldr r0,[pool_03803FF0]	; 03803F50
	cmp r4,r0	; 03803F52
	bcc loc_03803F5C	; 03803F54
	ldr r0,[pool_03804004]	; 03803F56
	cmp r4,r0	; 03803F58
	bcc loc_03803FCE	; 03803F5A
loc_03803F5C:
	add r0,r6,#0x0	; 03803F5C
	mov r1,#0x2	; 03803F5E
	bl loc_03803274	; 03803F60
	b loc_03803FE8	; 03803F64
loc_03803F66:
	ldrh r2,[r1,#0x8]	; 03803F66
	lsl r4,r2,#0x10	; 03803F68
	ldrh r2,[r1,#0xa]	; 03803F6A
	orr r4,r2	; 03803F6C
	ldr r2,[pool_03803FF0]	; 03803F6E
	cmp r4,r2	; 03803F70
	bcc loc_03803F7A	; 03803F72
	ldr r2,[pool_03804004]	; 03803F74
	cmp r4,r2	; 03803F76
	bcc loc_03803F84	; 03803F78
loc_03803F7A:
	add r0,r6,#0x0	; 03803F7A
	mov r1,#0x2	; 03803F7C
	bl loc_03803274	; 03803F7E
	b loc_03803FE8	; 03803F82
loc_03803F84:
	mov r2,#0xff	; 03803F84
	and r0,r2	; 03803F86
	lsl r3,r0,#0x10	; 03803F88
	ldrh r0,[r1,#0x2]	; 03803F8A
	orr r3,r0	; 03803F8C
	ldrh r0,[r1,#0x4]	; 03803F8E
	lsl r2,r0,#0x10	; 03803F90
	ldrh r0,[r1,#0x6]	; 03803F92
	orr r2,r0	; 03803F94
	b loc_03803FCE	; 03803F96
loc_03803F98:
	ldrh r2,[r1,#0x6]	; 03803F98
	lsl r4,r2,#0x10	; 03803F9A
	ldrh r2,[r1,#0x8]	; 03803F9C
	orr r4,r2	; 03803F9E
	ldr r2,[pool_03803FF0]	; 03803FA0
	cmp r4,r2	; 03803FA2
	bcc loc_03803FAC	; 03803FA4
	ldr r2,[pool_03804004]	; 03803FA6
	cmp r4,r2	; 03803FA8
	bcc loc_03803FB6	; 03803FAA
loc_03803FAC:
	add r0,r6,#0x0	; 03803FAC
	mov r1,#0x2	; 03803FAE
	bl loc_03803274	; 03803FB0
	b loc_03803FE8	; 03803FB4
loc_03803FB6:
	mov r2,#0xff	; 03803FB6
	and r0,r2	; 03803FB8
	lsl r3,r0,#0x10	; 03803FBA
	ldrh r0,[r1,#0x2]	; 03803FBC
	orr r3,r0	; 03803FBE
	ldrh r2,[r1,#0x4]	; 03803FC0
	b loc_03803FCE	; 03803FC2
loc_03803FC4:
	mov r3,#0xff	; 03803FC4
	and r0,r3	; 03803FC6
	lsl r3,r0,#0x10	; 03803FC8
	ldrh r0,[r1,#0x2]	; 03803FCA
	orr r3,r0	; 03803FCC
loc_03803FCE:
	str r2,[sp,#0x0]	; 03803FCE
	str r4,[sp,#0x4]	; 03803FD0
	mov r0,#0x1	; 03803FD2
	add r1,r6,#0x0	; 03803FD4
	mov r2,#0x3	; 03803FD6
	bl loc_03803180	; 03803FD8
	cmp r0,#0x0	; 03803FDC
	bne loc_03803FE8	; 03803FDE
	add r0,r6,#0x0	; 03803FE0
	mov r1,#0x4	; 03803FE2
	bl loc_03803274	; 03803FE4
loc_03803FE8:
	add sp,#0xc	; 03803FE8
	pop {r4,r5,r6,r7}	; 03803FEA
	pop {r3}	; 03803FEC
	bx r3	; 03803FEE
pool_03803FF0:
loc_03803FF0:
	.word 0x02000000	; 03803FF0
pool_03803FF4:
loc_03803FF4:
	.word P2_BssStart + 0x2878	; 03803FF4
pool_03803FF8:
loc_03803FF8:
	.word 0x000F0000	; 03803FF8
pool_03803FFC:
loc_03803FFC:
	.word 0x01000000	; 03803FFC
pool_03804000:
loc_03804000:
	.word 0x0000FF00	; 03804000
pool_03804004:
loc_03804004:
	.word 0x02400000	; 03804004

; ===== function loc_03804008 =====
loc_03804008:
	mov r3,#0x0	; 03804008
	add r2,r3,#0x0	; 0380400A
	ldr r0,[pool_0380401C]	; 0380400C
loc_0380400E:
	lsl r1,r3,#0x1	; 0380400E
	strh r2,[r0,r1]	; 03804010
	add r3,r3,#0x1	; 03804012
	cmp r3,#0x10	; 03804014
	blt loc_0380400E	; 03804016
	bx lr	; 03804018
	.byte 0xC0, 0x46	; 0380401C
pool_0380401C:
loc_0380401C:
	.word P2_BssStart + 0x2878	; 0380401C
P2_Entry_03804020:
	push {r4,r5,r6,lr}	; 03804020
	mov r6,#0x1	; 03804022
	ldr r5,[pool_03804060]	; 03804024
	mov r4,#0x80	; 03804026
	b P2_Entry_03804030	; 03804028
P2_Entry_0380402A:
	add r0,r6,#0x0	; 0380402A
	bl P2_SwiWaitByLoop	; 0380402C
P2_Entry_03804030:
	ldrh r0,[r5,#0x0]	; 03804030
	and r0,r4	; 03804032
	cmp r0,#0x0	; 03804034
	bne P2_Entry_0380402A	; 03804036
	ldr r0,[pool_03804064]	; 03804038
	strh r0,[r5,#0x0]	; 0380403A
	mov r1,#0xff	; 0380403C
	ldr r0,[pool_03804068]	; 0380403E
	strh r1,[r0,#0x0]	; 03804040
	mov r6,#0x1	; 03804042
	ldr r5,[pool_03804060]	; 03804044
	mov r4,#0x80	; 03804046
	b P2_Entry_03804050	; 03804048
P2_Entry_0380404A:
	add r0,r6,#0x0	; 0380404A
	bl P2_SwiWaitByLoop	; 0380404C
P2_Entry_03804050:
	ldrh r0,[r5,#0x0]	; 03804050
	and r0,r4	; 03804052
	cmp r0,#0x0	; 03804054
	bne P2_Entry_0380404A	; 03804056
	pop {r4,r5,r6}	; 03804058
	pop {r3}	; 0380405A
	bx r3	; 0380405C
	.byte 0xC0, 0x46	; 0380405E
pool_03804060:
	.word 0x040001C0	; 03804060
pool_03804064:
	.word 0x00008100	; 03804064
pool_03804068:
	.word REG_SPIDATA	; 03804068
P2_Entry_0380406C:
	push {r4,r5,r6,r7,lr}	; 0380406C
	sub sp,#0x4	; 0380406E
	add r5,r0,#0x0	; 03804070
	mov r7,#0x1	; 03804072
	ldr r4,[pool_03804100]	; 03804074
	mov r6,#0x80	; 03804076
	b P2_Entry_03804080	; 03804078
P2_Entry_0380407A:
	add r0,r7,#0x0	; 0380407A
	bl P2_SwiWaitByLoop	; 0380407C
P2_Entry_03804080:
	ldrh r0,[r4,#0x0]	; 03804080
	and r0,r6	; 03804082
	cmp r0,#0x0	; 03804084
	bne P2_Entry_0380407A	; 03804086
	ldr r0,[pool_03804104]	; 03804088
	strh r0,[r4,#0x0]	; 0380408A
	mov r1,#0x9f	; 0380408C
	ldr r0,[pool_03804108]	; 0380408E
	strh r1,[r0,#0x0]	; 03804090
	mov r7,#0x1	; 03804092
	ldr r4,[pool_03804100]	; 03804094
	mov r6,#0x80	; 03804096
	b P2_Entry_038040A0	; 03804098
P2_Entry_0380409A:
	add r0,r7,#0x0	; 0380409A
	bl P2_SwiWaitByLoop	; 0380409C
P2_Entry_038040A0:
	ldrh r0,[r4,#0x0]	; 038040A0
	and r0,r6	; 038040A2
	cmp r0,#0x0	; 038040A4
	bne P2_Entry_0380409A	; 038040A6
	mov r1,#0x0	; 038040A8
	ldr r0,[pool_03804108]	; 038040AA
	strh r1,[r0,#0x0]	; 038040AC
	mov r7,#0x1	; 038040AE
	ldr r4,[pool_03804100]	; 038040B0
	mov r6,#0x80	; 038040B2
	b P2_Entry_038040BC	; 038040B4
P2_Entry_038040B6:
	add r0,r7,#0x0	; 038040B6
	bl P2_SwiWaitByLoop	; 038040B8
P2_Entry_038040BC:
	ldrh r0,[r4,#0x0]	; 038040BC
	and r0,r6	; 038040BE
	cmp r0,#0x0	; 038040C0
	bne P2_Entry_038040B6	; 038040C2
	ldr r1,[pool_03804108]	; 038040C4
	ldrh r2,[r1,#0x0]	; 038040C6
	mov r0,#0xff	; 038040C8
	and r2,r0	; 038040CA
	strb r2,[r5,#0x0]	; 038040CC
	ldr r0,[pool_0380410C]	; 038040CE
	strh r0,[r4,#0x0]	; 038040D0
	mov r0,#0x0	; 038040D2
	strh r0,[r1,#0x0]	; 038040D4
	mov r7,#0x1	; 038040D6
	ldr r4,[pool_03804100]	; 038040D8
	mov r6,#0x80	; 038040DA
	b P2_Entry_038040E4	; 038040DC
P2_Entry_038040DE:
	add r0,r7,#0x0	; 038040DE
	bl P2_SwiWaitByLoop	; 038040E0
P2_Entry_038040E4:
	ldrh r0,[r4,#0x0]	; 038040E4
	and r0,r6	; 038040E6
	cmp r0,#0x0	; 038040E8
	bne P2_Entry_038040DE	; 038040EA
	ldr r0,[pool_03804108]	; 038040EC
	ldrh r1,[r0,#0x0]	; 038040EE
	mov r0,#0xff	; 038040F0
	and r1,r0	; 038040F2
	strb r1,[r5,#0x1]	; 038040F4
	add sp,#0x4	; 038040F6
	pop {r4,r5,r6,r7}	; 038040F8
	pop {r3}	; 038040FA
	bx r3	; 038040FC
	.byte 0xC0, 0x46	; 038040FE
pool_03804100:
	.word 0x040001C0	; 03804100
pool_03804104:
	.word 0x00008900	; 03804104
pool_03804108:
	.word REG_SPIDATA	; 03804108
pool_0380410C:
	.word 0x00008100	; 0380410C
P2_Entry_03804110:
	push {r4,r5,r6,lr}	; 03804110
	mov r6,#0x1	; 03804112
	ldr r5,[pool_03804150]	; 03804114
	mov r4,#0x80	; 03804116
	b P2_Entry_03804120	; 03804118
P2_Entry_0380411A:
	add r0,r6,#0x0	; 0380411A
	bl P2_SwiWaitByLoop	; 0380411C
P2_Entry_03804120:
	ldrh r0,[r5,#0x0]	; 03804120
	and r0,r4	; 03804122
	cmp r0,#0x0	; 03804124
	bne P2_Entry_0380411A	; 03804126
	ldr r0,[pool_03804154]	; 03804128
	strh r0,[r5,#0x0]	; 0380412A
	mov r1,#0xc7	; 0380412C
	ldr r0,[pool_03804158]	; 0380412E
	strh r1,[r0,#0x0]	; 03804130
	mov r6,#0x1	; 03804132
	ldr r5,[pool_03804150]	; 03804134
	mov r4,#0x80	; 03804136
	b P2_Entry_03804140	; 03804138
P2_Entry_0380413A:
	add r0,r6,#0x0	; 0380413A
	bl P2_SwiWaitByLoop	; 0380413C
P2_Entry_03804140:
	ldrh r0,[r5,#0x0]	; 03804140
	and r0,r4	; 03804142
	cmp r0,#0x0	; 03804144
	bne P2_Entry_0380413A	; 03804146
	pop {r4,r5,r6}	; 03804148
	pop {r3}	; 0380414A
	bx r3	; 0380414C
	.byte 0xC0, 0x46	; 0380414E
pool_03804150:
	.word 0x040001C0	; 03804150
pool_03804154:
	.word 0x00008100	; 03804154
pool_03804158:
	.word REG_SPIDATA	; 03804158
P2_Entry_0380415C:
	push {r4,r5,r6,r7,lr}	; 0380415C
	sub sp,#0x4	; 0380415E
	ldr r1,[pool_03804214]	; 03804160
	add r2,r0,#0x0	; 03804162
	and r2,r1	; 03804164
	lsr r1,r2,#0x10	; 03804166
	lsl r1,r1,#0x10	; 03804168
	lsr r5,r1,#0x10	; 0380416A
	ldr r1,[pool_03804218]	; 0380416C
	add r2,r0,#0x0	; 0380416E
	and r2,r1	; 03804170
	lsl r1,r2,#0x8	; 03804172
	lsr r4,r1,#0x10	; 03804174
	mov r1,#0xff	; 03804176
	and r0,r1	; 03804178
	lsl r0,r0,#0x10	; 0380417A
	lsr r6,r0,#0x10	; 0380417C
	ldr r7,[pool_0380421C]	; 0380417E
	b P2_Entry_03804188	; 03804180
P2_Entry_03804182:
	mov r0,#0x1	; 03804182
	bl P2_SwiWaitByLoop	; 03804184
P2_Entry_03804188:
	ldrh r1,[r7,#0x0]	; 03804188
	mov r0,#0x80	; 0380418A
	and r1,r0	; 0380418C
	cmp r1,#0x0	; 0380418E
	bne P2_Entry_03804182	; 03804190
	ldr r0,[pool_03804220]	; 03804192
	strh r0,[r7,#0x0]	; 03804194
	mov r1,#0xdb	; 03804196
	ldr r0,[pool_03804224]	; 03804198
	strh r1,[r0,#0x0]	; 0380419A
	ldr r7,[pool_0380421C]	; 0380419C
	b P2_Entry_038041A6	; 0380419E
P2_Entry_038041A0:
	mov r0,#0x1	; 038041A0
	bl P2_SwiWaitByLoop	; 038041A2
P2_Entry_038041A6:
	ldrh r1,[r7,#0x0]	; 038041A6
	mov r0,#0x80	; 038041A8
	and r1,r0	; 038041AA
	cmp r1,#0x0	; 038041AC
	bne P2_Entry_038041A0	; 038041AE
	mov r0,#0xff	; 038041B0
	and r5,r0	; 038041B2
	ldr r0,[pool_03804224]	; 038041B4
	strh r5,[r0,#0x0]	; 038041B6
	ldr r5,[pool_0380421C]	; 038041B8
	mov r7,#0x80	; 038041BA
	b P2_Entry_038041C4	; 038041BC
P2_Entry_038041BE:
	mov r0,#0x1	; 038041BE
	bl P2_SwiWaitByLoop	; 038041C0
P2_Entry_038041C4:
	ldrh r0,[r5,#0x0]	; 038041C4
	and r0,r7	; 038041C6
	cmp r0,#0x0	; 038041C8
	bne P2_Entry_038041BE	; 038041CA
	mov r0,#0xff	; 038041CC
	and r4,r0	; 038041CE
	ldr r0,[pool_03804224]	; 038041D0
	strh r4,[r0,#0x0]	; 038041D2
	mov r7,#0x1	; 038041D4
	ldr r4,[pool_0380421C]	; 038041D6
	mov r5,#0x80	; 038041D8
	b P2_Entry_038041E2	; 038041DA
P2_Entry_038041DC:
	add r0,r7,#0x0	; 038041DC
	bl P2_SwiWaitByLoop	; 038041DE
P2_Entry_038041E2:
	ldrh r0,[r4,#0x0]	; 038041E2
	and r0,r5	; 038041E4
	cmp r0,#0x0	; 038041E6
	bne P2_Entry_038041DC	; 038041E8
	ldr r0,[pool_03804228]	; 038041EA
	strh r0,[r4,#0x0]	; 038041EC
	mov r0,#0xff	; 038041EE
	and r6,r0	; 038041F0
	ldr r0,[pool_03804224]	; 038041F2
	strh r6,[r0,#0x0]	; 038041F4
	mov r6,#0x1	; 038041F6
	ldr r5,[pool_0380421C]	; 038041F8
	mov r4,#0x80	; 038041FA
	b P2_Entry_03804204	; 038041FC
P2_Entry_038041FE:
	add r0,r6,#0x0	; 038041FE
	bl P2_SwiWaitByLoop	; 03804200
P2_Entry_03804204:
	ldrh r0,[r5,#0x0]	; 03804204
	and r0,r4	; 03804206
	cmp r0,#0x0	; 03804208
	bne P2_Entry_038041FE	; 0380420A
	add sp,#0x4	; 0380420C
	pop {r4,r5,r6,r7}	; 0380420E
	pop {r3}	; 03804210
	bx r3	; 03804212
pool_03804214:
	.word 0x00FF0000	; 03804214
pool_03804218:
	.word 0x0000FF00	; 03804218
pool_0380421C:
	.word 0x040001C0	; 0380421C
pool_03804220:
	.word 0x00008900	; 03804220
pool_03804224:
	.word REG_SPIDATA	; 03804224
pool_03804228:
	.word 0x00008100	; 03804228
P2_Entry_0380422C:
	push {r4,r5,r6,r7,lr}	; 0380422C
	sub sp,#0xc	; 0380422E
	add r4,r1,#0x0	; 03804230
	add r6,r2,#0x0	; 03804232
	cmp r4,#0x1	; 03804234
	bcc P2_Entry_03804314	; 03804236
	add r1,r0,r4	; 03804238
	sub r1,r1,#0x1	; 0380423A
	lsr r2,r1,#0x8	; 0380423C
	lsr r1,r0,#0x8	; 0380423E
	cmp r2,r1	; 03804240
	bls P2_Entry_03804252	; 03804242
	mov r1,#0xff	; 03804244
	add r2,r0,#0x0	; 03804246
	and r2,r1	; 03804248
	ldr r1,[pool_0380431C]	; 0380424A
	sub r1,r1,r2	; 0380424C
	lsl r1,r1,#0x10	; 0380424E
	lsr r4,r1,#0x10	; 03804250
P2_Entry_03804252:
	ldr r1,[pool_03804320]	; 03804252
	add r2,r0,#0x0	; 03804254
	and r2,r1	; 03804256
	lsr r1,r2,#0x10	; 03804258
	add r2,sp,#0x0	; 0380425A
	strh r1,[r2,#0x0]	; 0380425C
	ldr r1,[pool_03804324]	; 0380425E
	add r3,r0,#0x0	; 03804260
	and r3,r1	; 03804262
	lsr r1,r3,#0x8	; 03804264
	strh r1,[r2,#0x2]	; 03804266
	mov r1,#0xff	; 03804268
	and r0,r1	; 0380426A
	strh r0,[r2,#0x4]	; 0380426C
	ldr r5,[pool_03804328]	; 0380426E
	mov r7,#0x80	; 03804270
	b P2_Entry_0380427A	; 03804272
P2_Entry_03804274:
	mov r0,#0x1	; 03804274
	bl P2_SwiWaitByLoop	; 03804276
P2_Entry_0380427A:
	ldrh r0,[r5,#0x0]	; 0380427A
	and r0,r7	; 0380427C
	cmp r0,#0x0	; 0380427E
	bne P2_Entry_03804274	; 03804280
	ldr r0,[pool_0380432C]	; 03804282
	strh r0,[r5,#0x0]	; 03804284
	mov r0,#0xa	; 03804286
	ldr r7,[pool_03804330]	; 03804288
	strh r0,[r7,#0x0]	; 0380428A
	mov r5,#0x0	; 0380428C
	b P2_Entry_038042B0	; 0380428E
P2_Entry_03804290:
	mov r0,#0x1	; 03804290
	bl P2_SwiWaitByLoop	; 03804292
P2_Entry_03804296:
	ldr r0,[pool_03804328]	; 03804296
	ldrh r1,[r0,#0x0]	; 03804298
	mov r0,#0x80	; 0380429A
	and r1,r0	; 0380429C
	cmp r1,#0x0	; 0380429E
	bne P2_Entry_03804290	; 038042A0
	lsl r1,r5,#0x1	; 038042A2
	add r0,sp,#0x0	; 038042A4
	ldrh r1,[r0,r1]	; 038042A6
	mov r0,#0xff	; 038042A8
	and r1,r0	; 038042AA
	strh r1,[r7,#0x0]	; 038042AC
	add r5,r5,#0x1	; 038042AE
P2_Entry_038042B0:
	cmp r5,#0x3	; 038042B0
	blt P2_Entry_03804296	; 038042B2
	mov r5,#0x0	; 038042B4
	sub r4,r4,#0x1	; 038042B6
	ldr r7,[pool_03804328]	; 038042B8
	b P2_Entry_038042D8	; 038042BA
P2_Entry_038042BC:
	mov r0,#0x1	; 038042BC
	bl P2_SwiWaitByLoop	; 038042BE
P2_Entry_038042C2:
	ldrh r1,[r7,#0x0]	; 038042C2
	mov r0,#0x80	; 038042C4
	and r1,r0	; 038042C6
	cmp r1,#0x0	; 038042C8
	bne P2_Entry_038042BC	; 038042CA
	ldrb r1,[r6,r5]	; 038042CC
	mov r0,#0xff	; 038042CE
	and r1,r0	; 038042D0
	ldr r0,[pool_03804330]	; 038042D2
	strh r1,[r0,#0x0]	; 038042D4
	add r5,r5,#0x1	; 038042D6
P2_Entry_038042D8:
	cmp r5,r4	; 038042D8
	blt P2_Entry_038042C2	; 038042DA
	ldr r4,[pool_03804328]	; 038042DC
	mov r7,#0x80	; 038042DE
	b P2_Entry_038042E8	; 038042E0
P2_Entry_038042E2:
	mov r0,#0x1	; 038042E2
	bl P2_SwiWaitByLoop	; 038042E4
P2_Entry_038042E8:
	ldrh r0,[r4,#0x0]	; 038042E8
	and r0,r7	; 038042EA
	cmp r0,#0x0	; 038042EC
	bne P2_Entry_038042E2	; 038042EE
	ldr r0,[pool_03804334]	; 038042F0
	strh r0,[r4,#0x0]	; 038042F2
	ldrb r1,[r6,r5]	; 038042F4
	mov r0,#0xff	; 038042F6
	and r1,r0	; 038042F8
	ldr r0,[pool_03804330]	; 038042FA
	strh r1,[r0,#0x0]	; 038042FC
	mov r6,#0x1	; 038042FE
	ldr r5,[pool_03804328]	; 03804300
	mov r4,#0x80	; 03804302
	b P2_Entry_0380430C	; 03804304
P2_Entry_03804306:
	add r0,r6,#0x0	; 03804306
	bl P2_SwiWaitByLoop	; 03804308
P2_Entry_0380430C:
	ldrh r0,[r5,#0x0]	; 0380430C
	and r0,r4	; 0380430E
	cmp r0,#0x0	; 03804310
	bne P2_Entry_03804306	; 03804312
P2_Entry_03804314:
	add sp,#0xc	; 03804314
	pop {r4,r5,r6,r7}	; 03804316
	pop {r3}	; 03804318
	bx r3	; 0380431A
pool_0380431C:
	.word 0x00000100	; 0380431C
pool_03804320:
	.word 0x00FF0000	; 03804320
pool_03804324:
	.word 0x0000FF00	; 03804324
pool_03804328:
	.word REG_SPICNT	; 03804328
pool_0380432C:
	.word 0x00008900	; 0380432C
pool_03804330:
	.word REG_SPIDATA	; 03804330
pool_03804334:
	.word 0x00008100	; 03804334

; ===== function loc_03804338 =====
loc_03804338:
	push {r4,r5,r6,r7,lr}	; 03804338
	sub sp,#0xc	; 0380433A
	add r4,r1,#0x0	; 0380433C
	add r6,r2,#0x0	; 0380433E
	cmp r4,#0x1	; 03804340
	bcc loc_03804412	; 03804342
	ldr r1,[pool_0380441C]	; 03804344
	add r2,r0,#0x0	; 03804346
	and r2,r1	; 03804348
	lsr r1,r2,#0x10	; 0380434A
	add r2,sp,#0x0	; 0380434C
	strh r1,[r2,#0x0]	; 0380434E
	ldr r1,[pool_03804420]	; 03804350
	add r3,r0,#0x0	; 03804352
	and r3,r1	; 03804354
	lsr r1,r3,#0x8	; 03804356
	strh r1,[r2,#0x2]	; 03804358
	mov r1,#0xff	; 0380435A
	and r0,r1	; 0380435C
	strh r0,[r2,#0x4]	; 0380435E
	ldr r5,[pool_03804424]	; 03804360
	mov r7,#0x80	; 03804362
	b loc_0380436C	; 03804364
loc_03804366:
	mov r0,#0x1	; 03804366
	bl loc_03804CB8	; 03804368
loc_0380436C:
	ldrh r0,[r5,#0x0]	; 0380436C
	and r0,r7	; 0380436E
	cmp r0,#0x0	; 03804370
	bne loc_03804366	; 03804372
	ldr r0,[pool_03804428]	; 03804374
	strh r0,[r5,#0x0]	; 03804376
	mov r0,#0x3	; 03804378
	ldr r7,[pool_0380442C]	; 0380437A
	strh r0,[r7,#0x0]	; 0380437C
	mov r5,#0x0	; 0380437E
	b loc_038043A2	; 03804380
loc_03804382:
	mov r0,#0x1	; 03804382
	bl loc_03804CB8	; 03804384
loc_03804388:
	ldr r0,[pool_03804424]	; 03804388
	ldrh r1,[r0,#0x0]	; 0380438A
	mov r0,#0x80	; 0380438C
	and r1,r0	; 0380438E
	cmp r1,#0x0	; 03804390
	bne loc_03804382	; 03804392
	lsl r1,r5,#0x1	; 03804394
	add r0,sp,#0x0	; 03804396
	ldrh r1,[r0,r1]	; 03804398
	mov r0,#0xff	; 0380439A
	and r1,r0	; 0380439C
	strh r1,[r7,#0x0]	; 0380439E
	add r5,r5,#0x1	; 038043A0
loc_038043A2:
	cmp r5,#0x3	; 038043A2
	blt loc_03804388	; 038043A4
	ldr r5,[pool_03804424]	; 038043A6
	mov r7,#0x80	; 038043A8
	b loc_038043B2	; 038043AA
loc_038043AC:
	mov r0,#0x1	; 038043AC
	bl loc_03804CB8	; 038043AE
loc_038043B2:
	ldrh r0,[r5,#0x0]	; 038043B2
	and r0,r7	; 038043B4
	cmp r0,#0x0	; 038043B6
	bne loc_038043AC	; 038043B8
	mov r5,#0x0	; 038043BA
	add r7,r5,#0x0	; 038043BC
	b loc_038043E4	; 038043BE
loc_038043C0:
	ldr r0,[pool_0380442C]	; 038043C0
	strh r7,[r0,#0x0]	; 038043C2
	b loc_038043CC	; 038043C4
loc_038043C6:
	mov r0,#0x1	; 038043C6
	bl loc_03804CB8	; 038043C8
loc_038043CC:
	ldr r0,[pool_03804424]	; 038043CC
	ldrh r1,[r0,#0x0]	; 038043CE
	mov r0,#0x80	; 038043D0
	and r1,r0	; 038043D2
	cmp r1,#0x0	; 038043D4
	bne loc_038043C6	; 038043D6
	ldr r0,[pool_0380442C]	; 038043D8
	ldrh r1,[r0,#0x0]	; 038043DA
	mov r0,#0xff	; 038043DC
	and r1,r0	; 038043DE
	strb r1,[r6,r5]	; 038043E0
	add r5,r5,#0x1	; 038043E2
loc_038043E4:
	sub r0,r4,#0x1	; 038043E4
	cmp r5,r0	; 038043E6
	bcc loc_038043C0	; 038043E8
	ldr r0,[pool_03804430]	; 038043EA
	ldr r4,[pool_03804424]	; 038043EC
	strh r0,[r4,#0x0]	; 038043EE
	mov r1,#0x0	; 038043F0
	ldr r0,[pool_0380442C]	; 038043F2
	strh r1,[r0,#0x0]	; 038043F4
	mov r7,#0x80	; 038043F6
	b loc_03804400	; 038043F8
loc_038043FA:
	mov r0,#0x1	; 038043FA
	bl loc_03804CB8	; 038043FC
loc_03804400:
	ldrh r0,[r4,#0x0]	; 03804400
	and r0,r7	; 03804402
	cmp r0,#0x0	; 03804404
	bne loc_038043FA	; 03804406
	ldr r0,[pool_0380442C]	; 03804408
	ldrh r1,[r0,#0x0]	; 0380440A
	mov r0,#0xff	; 0380440C
	and r1,r0	; 0380440E
	strb r1,[r6,r5]	; 03804410
loc_03804412:
	add sp,#0xc	; 03804412
	pop {r4,r5,r6,r7}	; 03804414
	pop {r3}	; 03804416
	bx r3	; 03804418
	.byte 0xC0, 0x46	; 0380441C
pool_0380441C:
loc_0380441C:
	.word 0x00FF0000	; 0380441C
pool_03804420:
loc_03804420:
	.word 0x0000FF00	; 03804420
pool_03804424:
loc_03804424:
	.word REG_SPICNT	; 03804424
pool_03804428:
loc_03804428:
	.word 0x00008900	; 03804428
pool_0380442C:
loc_0380442C:
	.word REG_SPIDATA	; 0380442C
pool_03804430:
loc_03804430:
	.word 0x00008100	; 03804430

; ===== function loc_03804434 =====
loc_03804434:
	push {r4,r5,r6,r7,lr}	; 03804434
	sub sp,#0x4	; 03804436
	add r5,r0,#0x0	; 03804438
	mov r7,#0x1	; 0380443A
	ldr r4,[pool_038044A4]	; 0380443C
	mov r6,#0x80	; 0380443E
	b loc_03804448	; 03804440
loc_03804442:
	add r0,r7,#0x0	; 03804442
	bl loc_03804CB8	; 03804444
loc_03804448:
	ldrh r0,[r4,#0x0]	; 03804448
	and r0,r6	; 0380444A
	cmp r0,#0x0	; 0380444C
	bne loc_03804442	; 0380444E
	ldr r0,[pool_038044A8]	; 03804450
	strh r0,[r4,#0x0]	; 03804452
	mov r1,#0x5	; 03804454
	ldr r0,[pool_038044AC]	; 03804456
	strh r1,[r0,#0x0]	; 03804458
	mov r7,#0x1	; 0380445A
	ldr r4,[pool_038044A4]	; 0380445C
	mov r6,#0x80	; 0380445E
	b loc_03804468	; 03804460
loc_03804462:
	add r0,r7,#0x0	; 03804462
	bl loc_03804CB8	; 03804464
loc_03804468:
	ldrh r0,[r4,#0x0]	; 03804468
	and r0,r6	; 0380446A
	cmp r0,#0x0	; 0380446C
	bne loc_03804462	; 0380446E
	ldr r0,[pool_038044B0]	; 03804470
	strh r0,[r4,#0x0]	; 03804472
	mov r1,#0x0	; 03804474
	ldr r0,[pool_038044AC]	; 03804476
	strh r1,[r0,#0x0]	; 03804478
	mov r7,#0x1	; 0380447A
	ldr r4,[pool_038044A4]	; 0380447C
	mov r6,#0x80	; 0380447E
	b loc_03804488	; 03804480
loc_03804482:
	add r0,r7,#0x0	; 03804482
	bl loc_03804CB8	; 03804484
loc_03804488:
	ldrh r0,[r4,#0x0]	; 03804488
	and r0,r6	; 0380448A
	cmp r0,#0x0	; 0380448C
	bne loc_03804482	; 0380448E
	ldr r0,[pool_038044AC]	; 03804490
	ldrh r1,[r0,#0x0]	; 03804492
	mov r0,#0xff	; 03804494
	and r1,r0	; 03804496
	strb r1,[r5,#0x0]	; 03804498
	add sp,#0x4	; 0380449A
	pop {r4,r5,r6,r7}	; 0380449C
	pop {r3}	; 0380449E
	bx r3	; 038044A0
	.byte 0xC0, 0x46	; 038044A4
pool_038044A4:
loc_038044A4:
	.word REG_SPICNT	; 038044A4
pool_038044A8:
loc_038044A8:
	.word 0x00008900	; 038044A8
pool_038044AC:
loc_038044AC:
	.word REG_SPIDATA	; 038044AC
pool_038044B0:
loc_038044B0:
	.word 0x00008100	; 038044B0
P2_Entry_038044B4:
	push {r4,r5,r6,lr}	; 038044B4
	mov r6,#0x1	; 038044B6
	ldr r5,[pool_038044F4]	; 038044B8
	mov r4,#0x80	; 038044BA
	b P2_Entry_038044C4	; 038044BC
P2_Entry_038044BE:
	add r0,r6,#0x0	; 038044BE
	bl P2_SwiWaitByLoop	; 038044C0
P2_Entry_038044C4:
	ldrh r0,[r5,#0x0]	; 038044C4
	and r0,r4	; 038044C6
	cmp r0,#0x0	; 038044C8
	bne P2_Entry_038044BE	; 038044CA
	ldr r0,[pool_038044F8]	; 038044CC
	strh r0,[r5,#0x0]	; 038044CE
	mov r1,#0x4	; 038044D0
	ldr r0,[pool_038044FC]	; 038044D2
	strh r1,[r0,#0x0]	; 038044D4
	mov r6,#0x1	; 038044D6
	ldr r5,[pool_038044F4]	; 038044D8
	mov r4,#0x80	; 038044DA
	b P2_Entry_038044E4	; 038044DC
P2_Entry_038044DE:
	add r0,r6,#0x0	; 038044DE
	bl P2_SwiWaitByLoop	; 038044E0
P2_Entry_038044E4:
	ldrh r0,[r5,#0x0]	; 038044E4
	and r0,r4	; 038044E6
loc_038044E8:
	cmp r0,#0x0	; 038044E8
	bne P2_Entry_038044DE	; 038044EA
	pop {r4,r5,r6}	; 038044EC
	pop {r3}	; 038044EE
	bx r3	; 038044F0
	.byte 0xC0, 0x46	; 038044F2
pool_038044F4:
	.word 0x040001C0	; 038044F4
pool_038044F8:
	.word 0x00008100	; 038044F8
pool_038044FC:
	.word REG_SPIDATA	; 038044FC
P2_Entry_03804500:
	push {r4,r5,r6,lr}	; 03804500
	mov r6,#0x1	; 03804502
	ldr r5,[pool_03804540]	; 03804504
	mov r4,#0x80	; 03804506
	b P2_Entry_03804510	; 03804508
P2_Entry_0380450A:
	add r0,r6,#0x0	; 0380450A
	bl P2_SwiWaitByLoop	; 0380450C
P2_Entry_03804510:
	ldrh r0,[r5,#0x0]	; 03804510
	and r0,r4	; 03804512
	cmp r0,#0x0	; 03804514
	bne P2_Entry_0380450A	; 03804516
	ldr r0,[pool_03804544]	; 03804518
	strh r0,[r5,#0x0]	; 0380451A
	mov r1,#0x6	; 0380451C
	ldr r0,[pool_03804548]	; 0380451E
	strh r1,[r0,#0x0]	; 03804520
	mov r6,#0x1	; 03804522
	ldr r5,[pool_03804540]	; 03804524
	mov r4,#0x80	; 03804526
	b P2_Entry_03804530	; 03804528
P2_Entry_0380452A:
	add r0,r6,#0x0	; 0380452A
	bl P2_SwiWaitByLoop	; 0380452C
P2_Entry_03804530:
	ldrh r0,[r5,#0x0]	; 03804530
	and r0,r4	; 03804532
	cmp r0,#0x0	; 03804534
	bne P2_Entry_0380452A	; 03804536
	pop {r4,r5,r6}	; 03804538
	pop {r3}	; 0380453A
	bx r3	; 0380453C
	.byte 0xC0, 0x46	; 0380453E
pool_03804540:
	.word 0x040001C0	; 03804540
pool_03804544:
	.word 0x00008100	; 03804544
pool_03804548:
	.word REG_SPIDATA	; 03804548
P2_Entry_0380454C:
	push {r4,r5,lr}	; 0380454C
	sub sp,#0x4	; 0380454E
	add r4,r0,#0x0	; 03804550
	bl loc_037FE0D0	; 03804552
	add r5,r0,#0x0	; 03804556
	mov r0,#0x3	; 03804558
	bl P2_Entry_03803260	; 0380455A
	cmp r0,#0x0	; 0380455E
	bne P2_Entry_03804576	; 03804560
	add r0,r5,#0x0	; 03804562
	bl loc_037FE0F4	; 03804564
	ldr r0,[r4,#0x4]	; 03804568
	lsl r0,r0,#0x10	; 0380456A
	lsr r0,r0,#0x10	; 0380456C
	mov r1,#0x4	; 0380456E
	bl loc_03803274	; 03804570
	b P2_Entry_03804634	; 03804574
P2_Entry_03804576:
	mov r0,#0x3	; 03804576
	bl loc_03803250	; 03804578
	add r0,r5,#0x0	; 0380457C
	bl loc_037FE0F4	; 0380457E
	ldr r0,[r4,#0x4]	; 03804582
	add r1,r0,#0x0	; 03804584
	sub r1,#0x61	; 03804586
	cmp r1,#0x5	; 03804588
	bhi P2_Entry_03804624	; 0380458A
	add r1,r1,r1	; 0380458C
P2_SwitchIndexPC_0380458C:
	add r1,pc	; 0380458E
	ldrh r1,[r1,#(P2_SwitchTable_0380458C - (P2_SwitchIndexPC_0380458C + 4))]	; 03804590
	lsl r1,r1,#0x10	; 03804592
	asr r1,r1,#0x10	; 03804594
P2_SwitchTargetPC_0380458C:
	add r1,pc	; 03804596
	bx r1	; 03804598
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_0380458C:
	.halfword (P2_Case_038045A6 + 1) - (P2_SwitchTargetPC_0380458C + 4)
	.halfword (P2_Entry_03804624 + 1) - (P2_SwitchTargetPC_0380458C + 4)
	.halfword (P2_Case_03804604 + 1) - (P2_SwitchTargetPC_0380458C + 4)
	.halfword (P2_Case_038045BE + 1) - (P2_SwitchTargetPC_0380458C + 4)
	.halfword (P2_Case_038045E2 + 1) - (P2_SwitchTargetPC_0380458C + 4)
	.halfword (P2_Case_0380461C + 1) - (P2_SwitchTargetPC_0380458C + 4)
P2_SwitchTable_0380458CEnd:
P2_Case_038045A6:
	mov r1,#0x1	; 038045A6
	ldr r0,[pool_0380463C]	; 038045A8
	str r1,[r0,#0x20]	; 038045AA
	ldr r1,[r4,#0x8]	; 038045AC
	ldr r0,[pool_03804640]	; 038045AE
	strh r1,[r0,#0x0]	; 038045B0
	ldr r1,[r4,#0xc]	; 038045B2
	ldr r0,[pool_03804644]	; 038045B4
	strh r1,[r0,#0x0]	; 038045B6
	bl P2_Entry_03804A48	; 038045B8
	b P2_Entry_0380462E	; 038045BC
P2_Case_038045BE:
	mov r1,#0x4	; 038045BE
	ldr r0,[pool_0380463C]	; 038045C0
	str r1,[r0,#0x20]	; 038045C2
	ldr r2,[r4,#0x8]	; 038045C4
	str r2,[r0,#0x28]	; 038045C6
	ldr r1,[r4,#0xc]	; 038045C8
	str r1,[r0,#0x24]	; 038045CA
	lsl r0,r2,#0x10	; 038045CC
	lsr r0,r0,#0x10	; 038045CE
	lsl r1,r1,#0x18	; 038045D0
	lsr r1,r1,#0x18	; 038045D2
	bl loc_038048BC	; 038045D4
	mov r0,#0x64	; 038045D8
	mov r1,#0x0	; 038045DA
	bl loc_03803274	; 038045DC
	b P2_Entry_0380462E	; 038045E0
P2_Case_038045E2:
	mov r1,#0x3	; 038045E2
	ldr r0,[pool_0380463C]	; 038045E4
	str r1,[r0,#0x20]	; 038045E6
	ldr r1,[r4,#0x8]	; 038045E8
	str r1,[r0,#0x28]	; 038045EA
	lsl r0,r1,#0x10	; 038045EC
	lsr r4,r0,#0x10	; 038045EE
	add r0,r4,#0x0	; 038045F0
	bl P2_ReadPmicRegister	; 038045F2
	add r1,r0,#0x0	; 038045F6
	add r4,#0x70	; 038045F8
	lsl r0,r4,#0x10	; 038045FA
	lsr r0,r0,#0x10	; 038045FC
	bl loc_03803274	; 038045FE
	b P2_Entry_0380462E	; 03804602
P2_Case_03804604:
	mov r0,#0x2	; 03804604
	ldr r1,[pool_0380463C]	; 03804606
	str r0,[r1,#0x20]	; 03804608
	ldr r0,[r4,#0x8]	; 0380460A
	str r0,[r1,#0x24]	; 0380460C
	bl P2_Entry_03804978	; 0380460E
	mov r0,#0x63	; 03804612
	mov r1,#0x0	; 03804614
	bl loc_03803274	; 03804616
	b P2_Entry_0380462E	; 0380461A
P2_Case_0380461C:
	ldr r0,[r4,#0x8]	; 0380461C
	bl P2_Entry_03804934	; 0380461E
	b P2_Entry_0380462E	; 03804622
P2_Entry_03804624:
	lsl r0,r0,#0x10	; 03804624
	lsr r0,r0,#0x10	; 03804626
	mov r1,#0x1	; 03804628
	bl loc_03803274	; 0380462A
P2_Entry_0380462E:
	mov r0,#0x3	; 0380462E
	bl P2_Entry_03803228	; 03804630
P2_Entry_03804634:
	add sp,#0x4	; 03804634
	pop {r4,r5}	; 03804636
	pop {r3}	; 03804638
	bx r3	; 0380463A
pool_0380463C:
	.word P2_BssStart + 0x28A4	; 0380463C
pool_03804640:
	.word P2_BssStart + 0x289C	; 03804640
pool_03804644:
	.word P2_BssStart + 0x2898	; 03804644

; ===== function loc_03804648 =====
loc_03804648:
	push {r4,r5,r6,lr}	; 03804648
	sub sp,#0x8	; 0380464A
	ldr r1,[pool_03804778]	; 0380464C
	add r2,r0,#0x0	; 0380464E
	and r2,r1	; 03804650
	cmp r2,#0x0	; 03804652
	beq loc_03804666	; 03804654
	mov r4,#0x0	; 03804656
	add r3,r4,#0x0	; 03804658
	ldr r1,[pool_0380477C]	; 0380465A
loc_0380465C:
	lsl r2,r4,#0x1	; 0380465C
	strh r3,[r1,r2]	; 0380465E
	add r4,r4,#0x1	; 03804660
	cmp r4,#0x10	; 03804662
	blt loc_0380465C	; 03804664
loc_03804666:
	ldr r1,[pool_03804780]	; 03804666
	add r2,r0,#0x0	; 03804668
	and r2,r1	; 0380466A
	lsr r1,r2,#0x10	; 0380466C
	lsl r1,r1,#0x1	; 0380466E
	ldr r5,[pool_0380477C]	; 03804670
	strh r0,[r5,r1]	; 03804672
	ldr r1,[pool_03804784]	; 03804674
	and r0,r1	; 03804676
	cmp r0,#0x0	; 03804678
	beq loc_03804770	; 0380467A
	ldrh r3,[r5,#0x0]	; 0380467C
	ldr r0,[pool_03804788]	; 0380467E
	add r1,r3,#0x0	; 03804680
	and r1,r0	; 03804682
	lsl r0,r1,#0x8	; 03804684
	lsr r4,r0,#0x10	; 03804686
	add r0,r4,#0x0	; 03804688
	sub r0,#0x60	; 0380468A
	cmp r0,#0x7	; 0380468C
	bhi loc_03804768	; 0380468E
	add r0,r0,r0	; 03804690
P2_SwitchIndexPC_03804690:
	add r0,pc	; 03804692
	ldrh r0,[r0,#(P2_SwitchTable_03804690 - (P2_SwitchIndexPC_03804690 + 4))]	; 03804694
	lsl r0,r0,#0x10	; 03804696
	asr r0,r0,#0x10	; 03804698
P2_SwitchTargetPC_03804690:
	add r0,pc	; 0380469A
	bx r0	; 0380469C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03804690:
	.halfword (loc_038046AE + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_038046B8 + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_03804768 + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_0380471C + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_038046DC + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_03804700 + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_03804742 + 1) - (P2_SwitchTargetPC_03804690 + 4)
	.halfword (loc_03804756 + 1) - (P2_SwitchTargetPC_03804690 + 4)
P2_SwitchTable_03804690End:
loc_038046AE:
	mov r0,#0x60	; 038046AE
	mov r1,#0x0	; 038046B0
	bl loc_03803274	; 038046B2
	b loc_03804770	; 038046B6
loc_038046B8:
	ldrh r1,[r5,#0x2]	; 038046B8
	ldr r0,[pool_0380478C]	; 038046BA
	and r1,r0	; 038046BC
	str r1,[sp,#0x0]	; 038046BE
	mov r0,#0x3	; 038046C0
	add r1,r4,#0x0	; 038046C2
	mov r2,#0x2	; 038046C4
	mov r5,#0xff	; 038046C6
	and r3,r5	; 038046C8
	bl loc_03803180	; 038046CA
	cmp r0,#0x0	; 038046CE
	bne loc_03804770	; 038046D0
	add r0,r4,#0x0	; 038046D2
	mov r1,#0x4	; 038046D4
	bl loc_03803274	; 038046D6
	b loc_03804770	; 038046DA
loc_038046DC:
	ldrh r1,[r5,#0x2]	; 038046DC
	ldr r0,[pool_0380478C]	; 038046DE
	and r1,r0	; 038046E0
	str r1,[sp,#0x0]	; 038046E2
	mov r0,#0x3	; 038046E4
	add r1,r4,#0x0	; 038046E6
	mov r2,#0x2	; 038046E8
	mov r5,#0xff	; 038046EA
	and r3,r5	; 038046EC
	bl loc_03803180	; 038046EE
	cmp r0,#0x0	; 038046F2
	bne loc_03804770	; 038046F4
	add r0,r4,#0x0	; 038046F6
	mov r1,#0x4	; 038046F8
	bl loc_03803274	; 038046FA
	b loc_03804770	; 038046FE
loc_03804700:
	mov r0,#0x3	; 03804700
	add r1,r4,#0x0	; 03804702
	mov r2,#0x1	; 03804704
	ldr r5,[pool_0380478C]	; 03804706
	and r3,r5	; 03804708
	bl loc_03803180	; 0380470A
	cmp r0,#0x0	; 0380470E
	bne loc_03804770	; 03804710
	add r0,r4,#0x0	; 03804712
	mov r1,#0x4	; 03804714
	bl loc_03803274	; 03804716
	b loc_03804770	; 0380471A
loc_0380471C:
	mov r0,#0x3	; 0380471C
	add r1,r4,#0x0	; 0380471E
	mov r2,#0x1	; 03804720
	mov r6,#0xff	; 03804722
	and r3,r6	; 03804724
	lsl r3,r3,#0x10	; 03804726
	ldrh r6,[r5,#0x2]	; 03804728
	ldr r5,[pool_0380478C]	; 0380472A
	and r6,r5	; 0380472C
	orr r3,r6	; 0380472E
	bl loc_03803180	; 03804730
	cmp r0,#0x0	; 03804734
	bne loc_03804770	; 03804736
	add r0,r4,#0x0	; 03804738
	mov r1,#0x4	; 0380473A
	bl loc_03803274	; 0380473C
	b loc_03804770	; 03804740
loc_03804742:
	mov r0,#0xff	; 03804742
	and r3,r0	; 03804744
	add r0,r3,#0x0	; 03804746
	bl loc_03804BA0	; 03804748
	mov r0,#0x66	; 0380474C
	mov r1,#0x0	; 0380474E
	bl loc_03803274	; 03804750
	b loc_03804770	; 03804754
loc_03804756:
	bl loc_03804B94	; 03804756
	add r1,r0,#0x0	; 0380475A
	mov r0,#0x67	; 0380475C
	lsl r1,r1,#0x10	; 0380475E
	lsr r1,r1,#0x10	; 03804760
	bl loc_03803274	; 03804762
	b loc_03804770	; 03804766
loc_03804768:
	add r0,r4,#0x0	; 03804768
	mov r1,#0x1	; 0380476A
	bl loc_03803274	; 0380476C
loc_03804770:
	add sp,#0x8	; 03804770
	pop {r4,r5,r6}	; 03804772
	pop {r3}	; 03804774
	bx r3	; 03804776
pool_03804778:
loc_03804778:
	.word 0x02000000	; 03804778
pool_0380477C:
loc_0380477C:
	.word P2_BssStart + 0x28A4	; 0380477C
pool_03804780:
loc_03804780:
	.word 0x000F0000	; 03804780
pool_03804784:
loc_03804784:
	.word 0x01000000	; 03804784
pool_03804788:
loc_03804788:
	.word 0x0000FF00	; 03804788
pool_0380478C:
loc_0380478C:
	.word 0x0000FFFF	; 0380478C

; ===== function loc_03804790 =====
loc_03804790:
	mov r1,#0x1	; 03804790
	ldr r0,[pool_038047AC]	; 03804792
	str r1,[r0,#0x0]	; 03804794
	mov r3,#0x0	; 03804796
	ldr r0,[pool_038047B0]	; 03804798
	str r3,[r0,#0x20]	; 0380479A
	add r2,r3,#0x0	; 0380479C
loc_0380479E:
	lsl r1,r3,#0x1	; 0380479E
	strh r2,[r0,r1]	; 038047A0
	add r3,r3,#0x1	; 038047A2
	cmp r3,#0x10	; 038047A4
	blt loc_0380479E	; 038047A6
	bx lr	; 038047A8
	.byte 0xC0, 0x46	; 038047AC
pool_038047AC:
loc_038047AC:
	.word P2_BssStart + 0x28A0	; 038047AC
pool_038047B0:
loc_038047B0:
	.word P2_BssStart + 0x28A4	; 038047B0
P2_Entry_038047B4:
	ldr r3,[pool_038047D0]	; 038047B4
	and r2,r3	; 038047B6
	ldr r3,[pool_038047D4]	; 038047B8
	and r0,r3	; 038047BA
	lsl r3,r0,#0x16	; 038047BC
	ldr r0,[pool_038047D8]	; 038047BE
	and r1,r0	; 038047C0
	lsl r0,r1,#0x10	; 038047C2
	orr r3,r0	; 038047C4
	orr r2,r3	; 038047C6
	add r0,r2,#0x0	; 038047C8
	ldr r3,[pool_038047DC]	; 038047CA
	bx r3	; 038047CC
	.byte 0xC0, 0x46	; 038047CE
pool_038047D0:
	.word 0x0000FFFF	; 038047D0
pool_038047D4:
	.word 0x03C00000	; 038047D4
pool_038047D8:
	.word 0x003F0000	; 038047D8
pool_038047DC:
	.word P2_Entry_038047E0 + 1	; 038047DC
P2_Entry_038047E0:
	push {r4,r5,r6,lr}	; 038047E0
	add r5,r0,#0x0	; 038047E2
	mov r4,#0x8	; 038047E4
	mov r6,#0x0	; 038047E6
P2_Entry_038047E8:
	add r0,r4,#0x0	; 038047E8
	add r1,r5,#0x0	; 038047EA
	add r2,r6,#0x0	; 038047EC
	bl loc_03802320	; 038047EE
	cmp r0,#0x0	; 038047F2
	bne P2_Entry_038047E8	; 038047F4
	pop {r4,r5,r6}	; 038047F6
	pop {r3}	; 038047F8
	bx r3	; 038047FA

; ===== function loc_038047FC =====
loc_038047FC:
	push {r4,lr}	; 038047FC
	add r4,r0,#0x0	; 038047FE
	mov r0,#0x0	; 03804800
	bl P2_ReadPmicRegister	; 03804802
	bic r0,r4	; 03804806
	lsl r0,r0,#0x18	; 03804808
	lsr r1,r0,#0x18	; 0380480A
	mov r0,#0x0	; 0380480C
	bl loc_038048BC	; 0380480E
	pop {r4}	; 03804812
	pop {r3}	; 03804814
	bx r3	; 03804816

; ===== function loc_03804818 =====
loc_03804818:
	push {r4,lr}	; 03804818
	add r4,r0,#0x0	; 0380481A
	mov r0,#0x0	; 0380481C
	bl P2_ReadPmicRegister	; 0380481E
	add r1,r0,#0x0	; 03804822
	orr r1,r4	; 03804824
	mov r0,#0x0	; 03804826
	bl loc_038048BC	; 03804828
	pop {r4}	; 0380482C
	pop {r3}	; 0380482E
	bx r3	; 03804830
	.byte 0x00, 0x00	; 03804834

; ===== function loc_03804834 =====
loc_03804834:
; 通过 SPI 读取 r0 指定的电源管理寄存器，返回低 8 位。
; Read the PMIC register selected by r0 over SPI; return its low byte.
.func P2_ReadPmicRegister
	push {r4,r5,r6,r7,lr}	; 03804834
	sub sp,#0x4	; 03804836
	add r5,r0,#0x0	; 03804838
	mov r7,#0x1	; 0380483A
	ldr r4,[pool_038048B4]	; 0380483C
	mov r6,#0x80	; 0380483E
	b loc_03804848	; 03804840
loc_03804842:
	add r0,r7,#0x0	; 03804842
	bl loc_03804CB8	; 03804844
loc_03804848:
	ldrh r0,[r4,#0x0]	; 03804848
	and r0,r6	; 0380484A
	cmp r0,#0x0	; 0380484C
	bne loc_03804842	; 0380484E
	mov r0,#0x1	; 03804850
	bl P2_SetPmicSpiHold	; 03804852
	mov r4,#0x80	; 03804856
	orr r5,r4	; 03804858
	lsl r0,r5,#0x18	; 0380485A
	lsr r1,r0,#0x18	; 0380485C
	mov r0,#0xff	; 0380485E
	and r1,r0	; 03804860
	ldr r0,[pool_038048B8]	; 03804862
	strh r1,[r0,#0x0]	; 03804864
	mov r6,#0x1	; 03804866
	ldr r5,[pool_038048B4]	; 03804868
	b loc_03804872	; 0380486A
loc_0380486C:
	add r0,r6,#0x0	; 0380486C
	bl loc_03804CB8	; 0380486E
loc_03804872:
	ldrh r0,[r5,#0x0]	; 03804872
	and r0,r4	; 03804874
	cmp r0,#0x0	; 03804876
	bne loc_0380486C	; 03804878
	mov r0,#0x0	; 0380487A
	bl P2_SetPmicSpiHold	; 0380487C
	mov r1,#0x0	; 03804880
	ldr r0,[pool_038048B8]	; 03804882
	strh r1,[r0,#0x0]	; 03804884
	mov r6,#0x1	; 03804886
	ldr r5,[pool_038048B4]	; 03804888
	mov r4,#0x80	; 0380488A
	b loc_03804894	; 0380488C
loc_0380488E:
	add r0,r6,#0x0	; 0380488E
	bl loc_03804CB8	; 03804890
loc_03804894:
	ldrh r0,[r5,#0x0]	; 03804894
	and r0,r4	; 03804896
	cmp r0,#0x0	; 03804898
	bne loc_0380488E	; 0380489A
	ldr r0,[pool_038048B8]	; 0380489C
	ldrh r1,[r0,#0x0]	; 0380489E
	mov r0,#0xff	; 038048A0
	and r1,r0	; 038048A2
	lsl r0,r1,#0x10	; 038048A4
	lsr r0,r0,#0x10	; 038048A6
	lsl r0,r0,#0x18	; 038048A8
	lsr r0,r0,#0x18	; 038048AA
	add sp,#0x4	; 038048AC
	pop {r4,r5,r6,r7}	; 038048AE
	pop {r3}	; 038048B0
	bx r3	; 038048B2
.endfunc
pool_038048B4:
loc_038048B4:
	.word REG_SPICNT	; 038048B4
pool_038048B8:
loc_038048B8:
	.word REG_SPIDATA	; 038048B8

; ===== function loc_038048BC =====
loc_038048BC:
	push {r4,r5,r6,r7,lr}	; 038048BC
	sub sp,#0x4	; 038048BE
	add r5,r0,#0x0	; 038048C0
	add r4,r1,#0x0	; 038048C2
	ldr r6,[pool_03804918]	; 038048C4
	mov r7,#0x80	; 038048C6
	b loc_038048D0	; 038048C8
loc_038048CA:
	mov r0,#0x1	; 038048CA
	bl loc_03804CB8	; 038048CC
loc_038048D0:
	ldrh r0,[r6,#0x0]	; 038048D0
	and r0,r7	; 038048D2
	cmp r0,#0x0	; 038048D4
	bne loc_038048CA	; 038048D6
	mov r0,#0x1	; 038048D8
	bl P2_SetPmicSpiHold	; 038048DA
	lsl r0,r5,#0x18	; 038048DE
	lsr r1,r0,#0x18	; 038048E0
	mov r0,#0xff	; 038048E2
	and r1,r0	; 038048E4
	ldr r0,[pool_0380491C]	; 038048E6
	strh r1,[r0,#0x0]	; 038048E8
	mov r7,#0x1	; 038048EA
	ldr r5,[pool_03804918]	; 038048EC
	mov r6,#0x80	; 038048EE
	b loc_038048F8	; 038048F0
loc_038048F2:
	add r0,r7,#0x0	; 038048F2
	bl loc_03804CB8	; 038048F4
loc_038048F8:
	ldrh r0,[r5,#0x0]	; 038048F8
	and r0,r6	; 038048FA
	cmp r0,#0x0	; 038048FC
	bne loc_038048F2	; 038048FE
	mov r0,#0x0	; 03804900
	bl P2_SetPmicSpiHold	; 03804902
	mov r0,#0xff	; 03804906
	and r4,r0	; 03804908
	ldr r0,[pool_0380491C]	; 0380490A
	strh r4,[r0,#0x0]	; 0380490C
	add sp,#0x4	; 0380490E
	pop {r4,r5,r6,r7}	; 03804910
	pop {r3}	; 03804912
	bx r3	; 03804914
	.byte 0xC0, 0x46	; 03804918
pool_03804918:
loc_03804918:
	.word REG_SPICNT	; 03804918
pool_0380491C:
loc_0380491C:
	.word REG_SPIDATA	; 0380491C

; ===== function loc_03804920 =====
loc_03804920:
; 选择 PMIC 的 SPI 通道；r0 控制两次传输之间是否保持片选。
; Select the PMIC SPI device; r0 controls chip-select hold between transfers.
.func P2_SetPmicSpiHold
	lsl r1,r0,#0xb	; 03804920
	ldr r0,[pool_0380492C]	; 03804922
	orr r1,r0	; 03804924
	ldr r0,[pool_03804930]	; 03804926
	strh r1,[r0,#0x0]	; 03804928
	bx lr	; 0380492A
.endfunc
pool_0380492C:
loc_0380492C:
	.word 0x00008002	; 0380492C
pool_03804930:
loc_03804930:
	.word REG_SPICNT	; 03804930

; ===== function loc_03804934 =====
P2_Entry_03804934:
	push {r4,lr}	; 03804934
	add r4,r0,#0x0	; 03804936
	cmp r4,#0x1	; 03804938
	beq loc_03804946	; 0380493A
	cmp r4,#0x2	; 0380493C
	beq loc_03804956	; 0380493E
	cmp r4,#0x3	; 03804940
	beq loc_0380494E	; 03804942
	b loc_03804964	; 03804944
loc_03804946:
	mov r0,#0x10	; 03804946
	bl loc_038047FC	; 03804948
	b loc_03804968	; 0380494C
loc_0380494E:
	mov r0,#0x30	; 0380494E
	bl loc_03804818	; 03804950
	b loc_03804968	; 03804954
loc_03804956:
	mov r0,#0x20	; 03804956
	bl loc_038047FC	; 03804958
	mov r0,#0x10	; 0380495C
	bl loc_03804818	; 0380495E
	b loc_03804968	; 03804962
loc_03804964:
	bl loc_037FF5C4	; 03804964
loc_03804968:
	ldr r0,[pool_03804974]	; 03804968
	str r4,[r0,#0x0]	; 0380496A
	pop {r4}	; 0380496C
	pop {r3}	; 0380496E
	bx r3	; 03804970
	.byte 0xC0, 0x46	; 03804974
pool_03804974:
loc_03804974:
	.word P2_Data_038056E8	; 03804974
P2_Entry_03804978:
	push {lr}	; 03804978
	sub sp,#0x4	; 0380497A
	cmp r0,#0xf	; 0380497C
	bhi P2_Entry_03804A40	; 0380497E
	add r0,r0,r0	; 03804980
P2_SwitchIndexPC_03804980:
	add r0,pc	; 03804982
	ldrh r0,[r0,#(P2_SwitchTable_03804980 - (P2_SwitchIndexPC_03804980 + 4))]	; 03804984
	lsl r0,r0,#0x10	; 03804986
	asr r0,r0,#0x10	; 03804988
P2_SwitchTargetPC_03804980:
	add r0,pc	; 0380498A
	bx r0	; 0380498C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P2_SwitchTable_03804980:
	.halfword (P2_Entry_03804A40 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049AE + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049BC + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049CA + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049D8 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049E0 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049E8 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049F0 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_038049F8 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A00 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A08 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A10 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A18 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A20 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A30 + 1) - (P2_SwitchTargetPC_03804980 + 4)
	.halfword (P2_Case_03804A28 + 1) - (P2_SwitchTargetPC_03804980 + 4)
P2_SwitchTable_03804980End:
P2_Case_038049AE:
	mov r0,#0x1	; 038049AE
	bl loc_03804BA0	; 038049B0
	mov r0,#0x1	; 038049B4
	bl P2_Entry_03804934	; 038049B6
	b P2_Entry_03804A40	; 038049BA
P2_Case_038049BC:
	mov r0,#0x3	; 038049BC
	bl loc_03804BA0	; 038049BE
	mov r0,#0x3	; 038049C2
	bl P2_Entry_03804934	; 038049C4
	b P2_Entry_03804A40	; 038049C8
P2_Case_038049CA:
	mov r0,#0x2	; 038049CA
	bl loc_03804BA0	; 038049CC
	mov r0,#0x2	; 038049D0
	bl P2_Entry_03804934	; 038049D2
	b P2_Entry_03804A40	; 038049D6
P2_Case_038049D8:
	mov r0,#0x4	; 038049D8
	bl loc_03804818	; 038049DA
	b P2_Entry_03804A40	; 038049DE
P2_Case_038049E0:
	mov r0,#0x4	; 038049E0
	bl loc_038047FC	; 038049E2
	b P2_Entry_03804A40	; 038049E6
P2_Case_038049E8:
	mov r0,#0x8	; 038049E8
	bl loc_03804818	; 038049EA
	b P2_Entry_03804A40	; 038049EE
P2_Case_038049F0:
	mov r0,#0x8	; 038049F0
	bl loc_038047FC	; 038049F2
	b P2_Entry_03804A40	; 038049F6
P2_Case_038049F8:
	mov r0,#0xc	; 038049F8
	bl loc_03804818	; 038049FA
	b P2_Entry_03804A40	; 038049FE
P2_Case_03804A00:
	mov r0,#0xc	; 03804A00
	bl loc_038047FC	; 03804A02
	b P2_Entry_03804A40	; 03804A06
P2_Case_03804A08:
	mov r0,#0x1	; 03804A08
	bl loc_03804818	; 03804A0A
	b P2_Entry_03804A40	; 03804A0E
P2_Case_03804A10:
	mov r0,#0x1	; 03804A10
	bl loc_038047FC	; 03804A12
	b P2_Entry_03804A40	; 03804A16
P2_Case_03804A18:
	mov r0,#0x2	; 03804A18
	bl loc_03804818	; 03804A1A
	b P2_Entry_03804A40	; 03804A1E
P2_Case_03804A20:
	mov r0,#0x2	; 03804A20
	bl loc_038047FC	; 03804A22
	b P2_Entry_03804A40	; 03804A26
P2_Case_03804A28:
	mov r0,#0x40	; 03804A28
	bl loc_038047FC	; 03804A2A
	b P2_Entry_03804A40	; 03804A2E
P2_Case_03804A30:
	bl P2_Entry_037FF868	; 03804A30
	mov r0,#0x1	; 03804A34
	bl loc_038047FC	; 03804A36
	mov r0,#0x40	; 03804A3A
	bl loc_03804818	; 03804A3C
P2_Entry_03804A40:
	add sp,#0x4	; 03804A40
	pop {r3}	; 03804A42
	bx r3	; 03804A44
	.byte 0x00, 0x00	; 03804A46
P2_Entry_03804A48:
	push {r4,r5,r6,r7,lr}	; 03804A48
	sub sp,#0x4	; 03804A4A
	ldr r1,[pool_03804B5C]	; 03804A4C
	ldrh r4,[r1,#0x0]	; 03804A4E
	mov r0,#0x0	; 03804A50
	strh r0,[r1,#0x0]	; 03804A52
	bl loc_037FE0D0	; 03804A54
	add r6,r0,#0x0	; 03804A58
	ldr r0,[pool_03804B60]	; 03804A5A
	bl loc_037FDE54	; 03804A5C
	add r7,r0,#0x0	; 03804A60
	mov r0,#0x0	; 03804A62
	bl P2_ReadPmicRegister	; 03804A64
	str r0,[sp,#0x0]	; 03804A68
	mov r0,#0x2	; 03804A6A
	bl loc_03804BA0	; 03804A6C
	mov r0,#0x2	; 03804A70
	bl P2_Entry_03804934	; 03804A72
	mov r0,#0x2	; 03804A76
	bl P2_Entry_03804934	; 03804A78
	bl P2_Entry_037FF868	; 03804A7C
	mov r0,#0x1	; 03804A80
	bl loc_038047FC	; 03804A82
	ldr r0,[pool_03804B64]	; 03804A86
	ldrh r1,[r0,#0x0]	; 03804A88
	mov r0,#0x1	; 03804A8A
	and r1,r0	; 03804A8C
	cmp r1,#0x0	; 03804A8E
	beq P2_Entry_03804AA4	; 03804A90
	ldr r0,[pool_03804B68]	; 03804A92
	ldrh r1,[r0,#0x0]	; 03804A94
	ldr r0,[pool_03804B6C]	; 03804A96
	orr r1,r0	; 03804A98
	ldr r0,[pool_03804B70]	; 03804A9A
	strh r1,[r0,#0x0]	; 03804A9C
	ldr r0,[pool_03804B74]	; 03804A9E
	bl loc_037FDE80	; 03804AA0
P2_Entry_03804AA4:
	ldr r0,[pool_03804B64]	; 03804AA4
	ldrh r1,[r0,#0x0]	; 03804AA6
	mov r0,#0x4	; 03804AA8
	and r1,r0	; 03804AAA
	cmp r1,#0x0	; 03804AAC
	beq P2_Entry_03804AB6	; 03804AAE
	ldr r0,[pool_03804B78]	; 03804AB0
	bl loc_037FDE80	; 03804AB2
P2_Entry_03804AB6:
	ldr r0,[pool_03804B64]	; 03804AB6
	ldrh r1,[r0,#0x0]	; 03804AB8
	mov r0,#0x2	; 03804ABA
	and r1,r0	; 03804ABC
	cmp r1,#0x0	; 03804ABE
	beq P2_Entry_03804AE2	; 03804AC0
	ldr r0,[pool_03804B7C]	; 03804AC2
	ldrh r5,[r0,#0x0]	; 03804AC4
	ldr r0,[pool_03804B80]	; 03804AC6
	bl loc_03802534	; 03804AC8
	mov r0,#0x40	; 03804ACC
	mov r1,#0x0	; 03804ACE
	bl loc_03802548	; 03804AD0
	ldr r0,[pool_03804B84]	; 03804AD4
	add r1,r0,#0x0	; 03804AD6
	bl loc_03802548	; 03804AD8
	mov r0,#0x80	; 03804ADC
	bl loc_037FDE80	; 03804ADE
P2_Entry_03804AE2:
	ldr r0,[pool_03804B64]	; 03804AE2
	ldrh r1,[r0,#0x0]	; 03804AE4
	mov r0,#0x8	; 03804AE6
	and r1,r0	; 03804AE8
	cmp r1,#0x0	; 03804AEA
	beq P2_Entry_03804AF4	; 03804AEC
	ldr r0,[pool_03804B88]	; 03804AEE
	bl loc_037FDE80	; 03804AF0
P2_Entry_03804AF4:
	ldr r0,[pool_03804B64]	; 03804AF4
	ldrh r1,[r0,#0x0]	; 03804AF6
	mov r0,#0x10	; 03804AF8
	and r1,r0	; 03804AFA
	cmp r1,#0x0	; 03804AFC
	beq P2_Entry_03804B06	; 03804AFE
	ldr r0,[pool_03804B8C]	; 03804B00
	bl loc_037FDE80	; 03804B02
P2_Entry_03804B06:
	add r0,r6,#0x0	; 03804B06
	bl loc_037FE0F4	; 03804B08
	ldr r1,[pool_03804B5C]	; 03804B0C
	ldrh r0,[r1,#0x0]	; 03804B0E
	mov r0,#0x1	; 03804B10
	strh r0,[r1,#0x0]	; 03804B12
	bl P2_SwiStop	; 03804B14
	mov r0,#0x0	; 03804B18
	ldr r1,[sp,#0x0]	; 03804B1A
	bl loc_038048BC	; 03804B1C
	ldr r0,[pool_03804B7C]	; 03804B20
	strh r5,[r0,#0x0]	; 03804B22
	mov r0,#0x1	; 03804B24
	bl loc_03804818	; 03804B26
	bl P2_Entry_037FF834	; 03804B2A
	mov r1,#0x0	; 03804B2E
	ldr r0,[pool_03804B90]	; 03804B30
	str r1,[r0,#0x20]	; 03804B32
	mov r0,#0x62	; 03804B34
	add r2,r1,#0x0	; 03804B36
	bl P2_Entry_038047B4	; 03804B38
	bl loc_037FE0D0	; 03804B3C
	add r0,r7,#0x0	; 03804B40
	bl loc_037FDE80	; 03804B42
	add r0,r6,#0x0	; 03804B46
	bl loc_037FE0F4	; 03804B48
	ldr r1,[pool_03804B5C]	; 03804B4C
	ldrh r0,[r1,#0x0]	; 03804B4E
	strh r4,[r1,#0x0]	; 03804B50
	add sp,#0x4	; 03804B52
	pop {r4,r5,r6,r7}	; 03804B54
	pop {r3}	; 03804B56
	bx r3	; 03804B58
	.byte 0xC0, 0x46	; 03804B5A
pool_03804B5C:
	.word REG_IME	; 03804B5C
pool_03804B60:
	.word 0x01FFFFFF	; 03804B60
pool_03804B64:
	.word P2_BssStart + 0x289C	; 03804B64
pool_03804B68:
	.word P2_BssStart + 0x2898	; 03804B68
pool_03804B6C:
	.word 0x00004000	; 03804B6C
pool_03804B70:
	.word REG_KEYCNT	; 03804B70
pool_03804B74:
	.word 0x00001000	; 03804B74
pool_03804B78:
	.word 0x00400000	; 03804B78
pool_03804B7C:
	.word REG_RCNT_ARM7	; 03804B7C
pool_03804B80:
	.word 0x00008000	; 03804B80
pool_03804B84:
	.word 0x00000100	; 03804B84
pool_03804B88:
	.word 0x00100000	; 03804B88
pool_03804B8C:
	.word 0x00002000	; 03804B8C
pool_03804B90:
	.word P2_BssStart + 0x28A4	; 03804B90

; ===== function loc_03804B94 =====
loc_03804B94:
	ldr r0,[pool_03804B9C]	; 03804B94
	ldr r0,[r0,#0x0]	; 03804B96
	bx lr	; 03804B98
	.byte 0xC0, 0x46	; 03804B9C
pool_03804B9C:
loc_03804B9C:
	.word P2_BssStart + 0x28D4	; 03804B9C

; ===== function loc_03804BA0 =====
loc_03804BA0:
	cmp r0,#0xf	; 03804BA0
	bgt loc_03804BAE	; 03804BA2
	ldr r1,[pool_03804BB0]	; 03804BA4
	str r0,[r1,#0x0]	; 03804BA6
	mov r1,#0x0	; 03804BA8
	ldr r0,[pool_03804BB4]	; 03804BAA
	str r1,[r0,#0x0]	; 03804BAC
loc_03804BAE:
	bx lr	; 03804BAE
pool_03804BB0:
loc_03804BB0:
	.word P2_BssStart + 0x28D4	; 03804BB0
pool_03804BB4:
loc_03804BB4:
	.word P2_BssStart + 0x28D0	; 03804BB4

; ===== function loc_03804BB8 =====
loc_03804BB8:
	push {r4,r5,r6,lr}	; 03804BB8
	ldr r0,[pool_03804C58]	; 03804BBA
	ldr r3,[r0,#0x0]	; 03804BBC
	cmp r3,#0x0	; 03804BBE
	bne loc_03804BDA	; 03804BC0
	mov r0,#0x3	; 03804BC2
	mov r1,#0x66	; 03804BC4
	mov r2,#0x1	; 03804BC6
	add r3,r2,#0x0	; 03804BC8
	bl loc_03803180	; 03804BCA
	cmp r0,#0x0	; 03804BCE
	beq loc_03804C50	; 03804BD0
	mov r0,#0x1	; 03804BD2
	bl loc_03804BA0	; 03804BD4
	b loc_03804C50	; 03804BD8
loc_03804BDA:
	cmp r3,#0x4	; 03804BDA
	bge loc_03804BF2	; 03804BDC
	ldr r0,[pool_03804C5C]	; 03804BDE
	ldr r0,[r0,#0x0]	; 03804BE0
	cmp r3,r0	; 03804BE2
	beq loc_03804C50	; 03804BE4
	mov r0,#0x3	; 03804BE6
	mov r1,#0x66	; 03804BE8
	mov r2,#0x1	; 03804BEA
	bl loc_03803180	; 03804BEC
	b loc_03804C50	; 03804BF0
loc_03804BF2:
	ldr r6,[pool_03804C60]	; 03804BF2
	sub r4,r3,#0x4	; 03804BF4
	mov r0,#0xc	; 03804BF6
	mul r4,r0	; 03804BF8
	add r5,r6,r4	; 03804BFA
	ldr r0,[pool_03804C64]	; 03804BFC
	ldr r0,[r0,#0x0]	; 03804BFE
	ldrh r1,[r5,#0xa]	; 03804C00
	bl loc_03803620	; 03804C02
	add r2,r0,#0x0	; 03804C06
	mov r0,#0x0	; 03804C08
	ldr r1,[pool_03804C68]	; 03804C0A
	bl loc_037FFD18	; 03804C0C
	ldr r3,[r6,r4]	; 03804C10
	ldr r2,[r5,#0x4]	; 03804C12
	and r2,r1	; 03804C14
	and r3,r0	; 03804C16
	mov r0,#0x0	; 03804C18
	eor r2,r0	; 03804C1A
	eor r3,r0	; 03804C1C
	orr r2,r3	; 03804C1E
	beq loc_03804C26	; 03804C20
	mov r3,#0x1	; 03804C22
	b loc_03804C28	; 03804C24
loc_03804C26:
	mov r3,#0x2	; 03804C26
loc_03804C28:
	ldr r0,[pool_03804C64]	; 03804C28
	ldr r1,[r0,#0x0]	; 03804C2A
	add r4,r1,#0x1	; 03804C2C
	str r4,[r0,#0x0]	; 03804C2E
	ldrh r2,[r5,#0x8]	; 03804C30
	ldrh r1,[r5,#0xa]	; 03804C32
	mul r2,r1	; 03804C34
	cmp r4,r2	; 03804C36
	bcc loc_03804C3E	; 03804C38
	mov r1,#0x0	; 03804C3A
	str r1,[r0,#0x0]	; 03804C3C
loc_03804C3E:
	ldr r0,[pool_03804C5C]	; 03804C3E
	ldr r0,[r0,#0x0]	; 03804C40
	cmp r3,r0	; 03804C42
	beq loc_03804C50	; 03804C44
	mov r0,#0x3	; 03804C46
	mov r1,#0x66	; 03804C48
	mov r2,#0x1	; 03804C4A
	bl loc_03803180	; 03804C4C
loc_03804C50:
	pop {r4,r5,r6}	; 03804C50
	pop {r3}	; 03804C52
	bx r3	; 03804C54
	.byte 0xC0, 0x46	; 03804C58
pool_03804C58:
loc_03804C58:
	.word P2_BssStart + 0x28D4	; 03804C58
pool_03804C5C:
loc_03804C5C:
	.word P2_Data_038056E8	; 03804C5C
pool_03804C60:
loc_03804C60:
	.word 0x038056EC	; 03804C60
pool_03804C64:
loc_03804C64:
	.word P2_BssStart + 0x28D0	; 03804C64
pool_03804C68:
loc_03804C68:
	.word 0x80000000	; 03804C68

; ===== function loc_03804C6C =====
loc_03804C6C:
	push {lr}	; 03804C6C
	sub sp,#0x4	; 03804C6E
	mov r0,#0x0	; 03804C70
	str r0,[sp,#0x0]	; 03804C72
	add r0,sp,#0x0	; 03804C74
	ldr r1,[pool_03804C8C]	; 03804C76
	ldr r2,[pool_03804C90]	; 03804C78
	bl loc_03804CF8	; 03804C7A
	bl loc_037FB068	; 03804C7E
	ldr r1,[pool_03804C8C]	; 03804C82
	strh r0,[r1,#0x2]	; 03804C84
	add sp,#0x4	; 03804C86
	pop {r3}	; 03804C88
	bx r3	; 03804C8A
pool_03804C8C:
loc_03804C8C:
	.word P2_BssStart + 0x28D8	; 03804C8C
pool_03804C90:
loc_03804C90:
	.word 0x05000001	; 03804C90

; ===== function loc_03804C94 =====
loc_03804C94:
	push {lr}	; 03804C94
	sub sp,#0x4	; 03804C96
	ldr r0,[pool_03804CB0]	; 03804C98
	ldr r1,[r0,#0x0]	; 03804C9A
	cmp r1,#0x0	; 03804C9C
	bne loc_03804CA8	; 03804C9E
	mov r1,#0x1	; 03804CA0
	str r1,[r0,#0x0]	; 03804CA2
	bl loc_03804C6C	; 03804CA4
loc_03804CA8:
	add sp,#0x4	; 03804CA8
	pop {r3}	; 03804CAA
	bx r3	; 03804CAC
	.byte 0xC0, 0x46	; 03804CB0
pool_03804CB0:
loc_03804CB0:
	.word P2_BssStart + 0x28DC	; 03804CB0
	.byte 0x00, 0xDF, 0x70, 0x47	; 03804CB8

; ===== function loc_03804CB8 =====
.func P2_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_03804CB8:
	swi 0x3	; 03804CB8
	bx lr	; 03804CBA
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

; ===== function loc_03804CD2 =====
.func P2_SwiHalt
; BIOS SWI #06: halt ARM7 until an interrupt. / BIOS SWI #06：使 ARM7 停止至中断发生。
loc_03804CD2:
	swi 0x6	; 03804CD2
	bx lr	; 03804CD4
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

; ===== function loc_03804CDE =====
.func P2_SwiSoundBiasIncrease
; BIOS SWI #08 wrapper: request sound-bias increase. / BIOS SWI #08 封装：请求提高声音偏置。
loc_03804CDE:
	add r1,r0,#0x0	; 03804CDE
	mov r0,#0x1	; 03804CE0
	swi 0x8	; 03804CE2
	bx lr	; 03804CE4
.endfunc

; ===== function loc_03804CE6 =====
.func P2_SwiSoundBiasDecrease
; BIOS SWI #08 wrapper: request sound-bias decrease. / BIOS SWI #08 封装：请求降低声音偏置。
loc_03804CE6:
	add r1,r0,#0x0	; 03804CE6
	mov r0,#0x0	; 03804CE8
	swi 0x8	; 03804CEA
	bx lr	; 03804CEC
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
.endfunc	; 03804CF8

; ===== function loc_03804CF8 =====
.func P2_SwiCpuSet
; BIOS SWI #0B: configurable memory copy/fill. / BIOS SWI #0B：可配置的内存复制/填充。
loc_03804CF8:
	swi 0xb	; 03804CF8
	bx lr	; 03804CFA
.endfunc

; ===== function loc_03804CFC =====
.func P2_SwiCpuFastSet
; BIOS SWI #0C: fast 32-byte memory copy/fill. / BIOS SWI #0C：快速 32 字节内存复制/填充。
loc_03804CFC:
	swi 0xc	; 03804CFC
	bx lr	; 03804CFE
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

; ===== function loc_03804D28 =====
.func P2_SwiGetPitchTable
; BIOS SWI #1B: obtain pitch-table entry. / BIOS SWI #1B：取得音高表项。
loc_03804D28:
	swi 0x1b	; 03804D28
	bx lr	; 03804D2A
.endfunc

; ===== function loc_03804D2C =====
.func P2_SwiGetVolumeTable
; BIOS SWI #1C: obtain volume-table entry. / BIOS SWI #1C：取得音量表项。
loc_03804D2C:
	swi 0x1c	; 03804D2C
	bx lr	; 03804D2E
.endfunc
.arm

; ===== function loc_03804D30 =====
loc_03804D30:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804D30
	mov r4,#0x0	; 03804D34
	b loc_03804D44	; 03804D38
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 03804D44
loc_03804D44:
	orrs r5,r3,r2	; 03804D44
	bne loc_03804D54	; 03804D48
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804D4C
	bx lr	; 03804D50
loc_03804D54:
	orrs r5,r1,r3	; 03804D54
	bne loc_03804DFC	; 03804D58
	mov r1,r2	; 03804D5C
	bl loc_0380519C	; 03804D60
	cmp r4,#0x0	; 03804D64
	movne r0,r1	; 03804D68
	mov r1,#0x0	; 03804D6C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804D70
	bx lr	; 03804D74
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 03804D88

; ===== function loc_03804D88 =====
loc_03804D88:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804D88
	eor r4,r1,r3	; 03804D8C
	mov r4,r4, asr #0x1	; 03804D90
	mov r4,r4, lsl #0x1	; 03804D94
	orrs r5,r3,r2	; 03804D98
	bne loc_03804DA8	; 03804D9C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804DA0
	bx lr	; 03804DA4
loc_03804DA8:
	mov r5,r0, lsr #0x1f	; 03804DA8
	add r5,r5,r1	; 03804DAC
	mov r6,r2, lsr #0x1f	; 03804DB0
	add r6,r6,r3	; 03804DB4
	orrs r6,r5,r6	; 03804DB8
	bne loc_03804DDC	; 03804DBC
	mov r1,r2	; 03804DC0
	bl loc_03804F88	; 03804DC4
	ands r4,r4,#0x1	; 03804DC8
	movne r0,r1	; 03804DCC
	mov r1,r0, asr #0x1f	; 03804DD0
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804DD4
	bx lr	; 03804DD8
loc_03804DDC:
	cmp r1,#0x0	; 03804DDC
	bge loc_03804DEC	; 03804DE0
	rsbs r0,r0,#0x0	; 03804DE4
	rsc r1,r1,#0x0	; 03804DE8
loc_03804DEC:
	cmp r3,#0x0	; 03804DEC
	bge loc_03804DFC	; 03804DF0
	rsbs r2,r2,#0x0	; 03804DF4
	rsc r3,r3,#0x0	; 03804DF8
loc_03804DFC:
	orrs r5,r1,r0	; 03804DFC
	beq loc_03804F20	; 03804E00
	mov r5,#0x0	; 03804E04
	mov r6,#0x1	; 03804E08
	cmp r3,#0x0	; 03804E0C
	bmi loc_03804E28	; 03804E10
loc_03804E14:
	add r5,r5,#0x1	; 03804E14
	adds r2,r2,r2	; 03804E18
	adcs r3,r3,r3	; 03804E1C
	bpl loc_03804E14	; 03804E20
	add r6,r6,r5	; 03804E24
loc_03804E28:
	cmp r1,#0x0	; 03804E28
	blt loc_03804E48	; 03804E2C
loc_03804E30:
	cmp r6,#0x1	; 03804E30
	beq loc_03804E48	; 03804E34
	sub r6,r6,#0x1	; 03804E38
	adds r0,r0,r0	; 03804E3C
	adcs r1,r1,r1	; 03804E40
	bpl loc_03804E30	; 03804E44
loc_03804E48:
	mov r7,#0x0	; 03804E48
	mov r12,#0x0	; 03804E4C
	mov r11,#0x0	; 03804E50
	b loc_03804E70	; 03804E54
loc_03804E58:
	orr r12,r12,#0x1	; 03804E58
	subs r6,r6,#0x1	; 03804E5C
	beq loc_03804EC8	; 03804E60
	adds r0,r0,r0	; 03804E64
	adcs r1,r1,r1	; 03804E68
	adcs r7,r7,r7	; 03804E6C
loc_03804E70:
	subs r0,r0,r2	; 03804E70
	sbcs r1,r1,r3	; 03804E74
	sbcs r7,r7,#0x0	; 03804E78
	adds r12,r12,r12	; 03804E7C
	adc r11,r11,r11	; 03804E80
	cmp r7,#0x0	; 03804E84
	bge loc_03804E58	; 03804E88
loc_03804E8C:
	subs r6,r6,#0x1	; 03804E8C
	beq loc_03804EC0	; 03804E90
	adds r0,r0,r0	; 03804E94
	adcs r1,r1,r1	; 03804E98
	adc r7,r7,r7	; 03804E9C
	adds r0,r0,r2	; 03804EA0
	adcs r1,r1,r3	; 03804EA4
	adc r7,r7,#0x0	; 03804EA8
	adds r12,r12,r12	; 03804EAC
	adc r11,r11,r11	; 03804EB0
	cmp r7,#0x0	; 03804EB4
	bge loc_03804E58	; 03804EB8
	b loc_03804E8C	; 03804EBC
loc_03804EC0:
	adds r0,r0,r2	; 03804EC0
	adc r1,r1,r3	; 03804EC4
loc_03804EC8:
	ands r7,r4,#0x1	; 03804EC8
	moveq r0,r12	; 03804ECC
	moveq r1,r11	; 03804ED0
	beq loc_03804F00	; 03804ED4
	subs r7,r5,#0x20	; 03804ED8
	movge r0,r1, lsr r7	; 03804EDC
	bge loc_03804F24	; 03804EE0
	rsb r7,r5,#0x20	; 03804EE4
	mov r0,r0, lsr r5	; 03804EE8
	orr r0,r0,r1, lsl r7	; 03804EEC
	mov r1,r1, lsr r5	; 03804EF0
	b loc_03804F00	; 03804EF4
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 03804F00
loc_03804F00:
	cmp r4,#0x0	; 03804F00
	blt loc_03804F10	; 03804F04
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804F08
	bx lr	; 03804F0C
loc_03804F10:
	rsbs r0,r0,#0x0	; 03804F10
	rsc r1,r1,#0x0	; 03804F14
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804F18
	bx lr	; 03804F1C
loc_03804F20:
	mov r0,#0x0	; 03804F20
loc_03804F24:
	mov r1,#0x0	; 03804F24
	cmp r4,#0x0	; 03804F28
	blt loc_03804F10	; 03804F2C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804F30
	bx lr	; 03804F34

; ===== function loc_03804F38 =====
loc_03804F38:
	stmdb sp!,{r4,r5,lr}	; 03804F38
	umull r5,r4,r0,r2	; 03804F3C
	mla r4,r0,r3,r4	; 03804F40
	mla r4,r2,r1,r4	; 03804F44
	mov r1,r4	; 03804F48
	mov r0,r5	; 03804F4C
	ldmia sp!,{r4,r5,lr}	; 03804F50
	bx lr	; 03804F54

; ===== function loc_03804F58 =====
loc_03804F58:
	ands r2,r2,#0x3f	; 03804F58
	bxeq lr	; 03804F5C
	subs r3,r2,#0x20	; 03804F60
	bge loc_03804F7C	; 03804F64
	rsb r3,r2,#0x20	; 03804F68
	mov r1,r1, lsl r2	; 03804F6C
	orr r1,r1,r0, lsr r3	; 03804F70
	mov r0,r0, lsl r2	; 03804F74
	bx lr	; 03804F78
loc_03804F7C:
	mov r1,r0, lsl r3	; 03804F7C
	mov r0,#0x0	; 03804F80
	bx lr	; 03804F84

; Signed integer division: quotient in r0, remainder in r1.
; 有符号整数除法：商返回于 r0，余数返回于 r1。
P2_SignedDivMod:
loc_03804F88:
	eor r12,r0,r1	; 03804F88
	and r12,r12,#0x80000000	; 03804F8C
	cmp r0,#0x0	; 03804F90
	rsblt r0,r0,#0x0	; 03804F94
	addlt r12,r12,#0x1	; 03804F98
	cmp r1,#0x0	; 03804F9C
	rsblt r1,r1,#0x0	; 03804FA0
	beq loc_03805180	; 03804FA4
	cmp r0,r1	; 03804FA8
	movcc r1,r0	; 03804FAC
	movcc r0,#0x0	; 03804FB0
	bcc loc_03805180	; 03804FB4
	mov r2,#0x1c	; 03804FB8
	mov r3,r0, lsr #0x4	; 03804FBC
	cmp r1,r3, lsr #0xc	; 03804FC0
	suble r2,r2,#0x10	; 03804FC4
	movle r3,r3, lsr #0x10	; 03804FC8
	cmp r1,r3, lsr #0x4	; 03804FCC
	suble r2,r2,#0x8	; 03804FD0
	movle r3,r3, lsr #0x8	; 03804FD4
	cmp r1,r3	; 03804FD8
	suble r2,r2,#0x4	; 03804FDC
	movle r3,r3, lsr #0x4	; 03804FE0
	mov r0,r0, lsl r2	; 03804FE4
	rsb r1,r1,#0x0	; 03804FE8
	adds r0,r0,r0	; 03804FEC
	add r2,r2,r2, lsl #0x1	; 03804FF0
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_03804FF4PC:
	add pc,pc,r2, lsl #0x2	; 03804FF4
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804FFC
loc_03804FFC:
P2_DivisionDispatch_03804FF4Steps:
	adcs r3,r1,r3, lsl #0x1	; 03804FFC
	subcc r3,r3,r1	; 03805000
	adcs r0,r0,r0	; 03805004
	adcs r3,r1,r3, lsl #0x1	; 03805008
	subcc r3,r3,r1	; 0380500C
	adcs r0,r0,r0	; 03805010
	adcs r3,r1,r3, lsl #0x1	; 03805014
	subcc r3,r3,r1	; 03805018
	adcs r0,r0,r0	; 0380501C
	adcs r3,r1,r3, lsl #0x1	; 03805020
	subcc r3,r3,r1	; 03805024
	adcs r0,r0,r0	; 03805028
loc_0380502C:
	adcs r3,r1,r3, lsl #0x1	; 0380502C
	subcc r3,r3,r1	; 03805030
	adcs r0,r0,r0	; 03805034
	adcs r3,r1,r3, lsl #0x1	; 03805038
	subcc r3,r3,r1	; 0380503C
	adcs r0,r0,r0	; 03805040
	adcs r3,r1,r3, lsl #0x1	; 03805044
	subcc r3,r3,r1	; 03805048
	adcs r0,r0,r0	; 0380504C
	adcs r3,r1,r3, lsl #0x1	; 03805050
	subcc r3,r3,r1	; 03805054
	adcs r0,r0,r0	; 03805058
loc_0380505C:
	adcs r3,r1,r3, lsl #0x1	; 0380505C
	subcc r3,r3,r1	; 03805060
	adcs r0,r0,r0	; 03805064
	adcs r3,r1,r3, lsl #0x1	; 03805068
	subcc r3,r3,r1	; 0380506C
	adcs r0,r0,r0	; 03805070
	adcs r3,r1,r3, lsl #0x1	; 03805074
	subcc r3,r3,r1	; 03805078
	adcs r0,r0,r0	; 0380507C
	adcs r3,r1,r3, lsl #0x1	; 03805080
	subcc r3,r3,r1	; 03805084
	adcs r0,r0,r0	; 03805088
	adcs r3,r1,r3, lsl #0x1	; 0380508C
	subcc r3,r3,r1	; 03805090
	adcs r0,r0,r0	; 03805094
	adcs r3,r1,r3, lsl #0x1	; 03805098
	subcc r3,r3,r1	; 0380509C
	adcs r0,r0,r0	; 038050A0
	adcs r3,r1,r3, lsl #0x1	; 038050A4
	subcc r3,r3,r1	; 038050A8
	adcs r0,r0,r0	; 038050AC
	adcs r3,r1,r3, lsl #0x1	; 038050B0
	subcc r3,r3,r1	; 038050B4
	adcs r0,r0,r0	; 038050B8
loc_038050BC:
	adcs r3,r1,r3, lsl #0x1	; 038050BC
	subcc r3,r3,r1	; 038050C0
	adcs r0,r0,r0	; 038050C4
	adcs r3,r1,r3, lsl #0x1	; 038050C8
	subcc r3,r3,r1	; 038050CC
	adcs r0,r0,r0	; 038050D0
	adcs r3,r1,r3, lsl #0x1	; 038050D4
	subcc r3,r3,r1	; 038050D8
	adcs r0,r0,r0	; 038050DC
	adcs r3,r1,r3, lsl #0x1	; 038050E0
	subcc r3,r3,r1	; 038050E4
	adcs r0,r0,r0	; 038050E8
	adcs r3,r1,r3, lsl #0x1	; 038050EC
	subcc r3,r3,r1	; 038050F0
	adcs r0,r0,r0	; 038050F4
	adcs r3,r1,r3, lsl #0x1	; 038050F8
	subcc r3,r3,r1	; 038050FC
	adcs r0,r0,r0	; 03805100
	adcs r3,r1,r3, lsl #0x1	; 03805104
	subcc r3,r3,r1	; 03805108
	adcs r0,r0,r0	; 0380510C
	adcs r3,r1,r3, lsl #0x1	; 03805110
	subcc r3,r3,r1	; 03805114
	adcs r0,r0,r0	; 03805118
	adcs r3,r1,r3, lsl #0x1	; 0380511C
	subcc r3,r3,r1	; 03805120
	adcs r0,r0,r0	; 03805124
	adcs r3,r1,r3, lsl #0x1	; 03805128
	subcc r3,r3,r1	; 0380512C
	adcs r0,r0,r0	; 03805130
	adcs r3,r1,r3, lsl #0x1	; 03805134
	subcc r3,r3,r1	; 03805138
	adcs r0,r0,r0	; 0380513C
	adcs r3,r1,r3, lsl #0x1	; 03805140
	subcc r3,r3,r1	; 03805144
	adcs r0,r0,r0	; 03805148
	adcs r3,r1,r3, lsl #0x1	; 0380514C
	subcc r3,r3,r1	; 03805150
	adcs r0,r0,r0	; 03805154
	adcs r3,r1,r3, lsl #0x1	; 03805158
	subcc r3,r3,r1	; 0380515C
	adcs r0,r0,r0	; 03805160
	adcs r3,r1,r3, lsl #0x1	; 03805164
	subcc r3,r3,r1	; 03805168
	adcs r0,r0,r0	; 0380516C
	adcs r3,r1,r3, lsl #0x1	; 03805170
	subcc r3,r3,r1	; 03805174
	adcs r0,r0,r0	; 03805178
P2_DivisionDispatch_03804FF4End:
.if (P2_DivisionDispatch_03804FF4Steps != P2_DivisionDispatch_03804FF4PC + 8) || (P2_DivisionDispatch_03804FF4End - P2_DivisionDispatch_03804FF4Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0380517C
loc_03805180:
	ands r3,r12,#0x80000000	; 03805180
	rsbne r0,r0,#0x0	; 03805184
	ands r3,r12,#0x1	; 03805188
	rsbne r1,r1,#0x0	; 0380518C
	bx lr	; 03805190

; ===== function loc_03805194 =====
loc_03805194:
	cmp r1,#0x0	; 03805194
	bxeq lr	; 03805198

; ===== function loc_0380519C =====
loc_0380519C:
	cmp r0,r1	; 0380519C
	movcc r1,r0	; 038051A0
	movcc r0,#0x0	; 038051A4
	bxcc lr	; 038051A8
	mov r2,#0x1c	; 038051AC
	mov r3,r0, lsr #0x4	; 038051B0
	cmp r1,r3, lsr #0xc	; 038051B4
	suble r2,r2,#0x10	; 038051B8
	movle r3,r3, lsr #0x10	; 038051BC
	cmp r1,r3, lsr #0x4	; 038051C0
	suble r2,r2,#0x8	; 038051C4
	movle r3,r3, lsr #0x8	; 038051C8
	cmp r1,r3	; 038051CC
	suble r2,r2,#0x4	; 038051D0
	movle r3,r3, lsr #0x4	; 038051D4
	mov r0,r0, lsl r2	; 038051D8
	rsb r1,r1,#0x0	; 038051DC
	adds r0,r0,r0	; 038051E0
	add r2,r2,r2, lsl #0x1	; 038051E4
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P2_DivisionDispatch_038051E8PC:
	add pc,pc,r2, lsl #0x2	; 038051E8
	.byte 0x00, 0x00, 0xA0, 0xE1	; 038051F0
loc_038051F0:
P2_DivisionDispatch_038051E8Steps:
	adcs r3,r1,r3, lsl #0x1	; 038051F0
	subcc r3,r3,r1	; 038051F4
	adcs r0,r0,r0	; 038051F8
	adcs r3,r1,r3, lsl #0x1	; 038051FC
	subcc r3,r3,r1	; 03805200
	adcs r0,r0,r0	; 03805204
	adcs r3,r1,r3, lsl #0x1	; 03805208
	subcc r3,r3,r1	; 0380520C
	adcs r0,r0,r0	; 03805210
	adcs r3,r1,r3, lsl #0x1	; 03805214
	subcc r3,r3,r1	; 03805218
	adcs r0,r0,r0	; 0380521C
loc_03805220:
	adcs r3,r1,r3, lsl #0x1	; 03805220
	subcc r3,r3,r1	; 03805224
	adcs r0,r0,r0	; 03805228
	adcs r3,r1,r3, lsl #0x1	; 0380522C
	subcc r3,r3,r1	; 03805230
	adcs r0,r0,r0	; 03805234
	adcs r3,r1,r3, lsl #0x1	; 03805238
	subcc r3,r3,r1	; 0380523C
	adcs r0,r0,r0	; 03805240
	adcs r3,r1,r3, lsl #0x1	; 03805244
	subcc r3,r3,r1	; 03805248
	adcs r0,r0,r0	; 0380524C
loc_03805250:
	adcs r3,r1,r3, lsl #0x1	; 03805250
	subcc r3,r3,r1	; 03805254
	adcs r0,r0,r0	; 03805258
	adcs r3,r1,r3, lsl #0x1	; 0380525C
	subcc r3,r3,r1	; 03805260
	adcs r0,r0,r0	; 03805264
	adcs r3,r1,r3, lsl #0x1	; 03805268
	subcc r3,r3,r1	; 0380526C
	adcs r0,r0,r0	; 03805270
	adcs r3,r1,r3, lsl #0x1	; 03805274
	subcc r3,r3,r1	; 03805278
	adcs r0,r0,r0	; 0380527C
	adcs r3,r1,r3, lsl #0x1	; 03805280
	subcc r3,r3,r1	; 03805284
	adcs r0,r0,r0	; 03805288
	adcs r3,r1,r3, lsl #0x1	; 0380528C
	subcc r3,r3,r1	; 03805290
	adcs r0,r0,r0	; 03805294
	adcs r3,r1,r3, lsl #0x1	; 03805298
	subcc r3,r3,r1	; 0380529C
	adcs r0,r0,r0	; 038052A0
	adcs r3,r1,r3, lsl #0x1	; 038052A4
	subcc r3,r3,r1	; 038052A8
	adcs r0,r0,r0	; 038052AC
loc_038052B0:
	adcs r3,r1,r3, lsl #0x1	; 038052B0
	subcc r3,r3,r1	; 038052B4
	adcs r0,r0,r0	; 038052B8
	adcs r3,r1,r3, lsl #0x1	; 038052BC
	subcc r3,r3,r1	; 038052C0
	adcs r0,r0,r0	; 038052C4
	adcs r3,r1,r3, lsl #0x1	; 038052C8
	subcc r3,r3,r1	; 038052CC
	adcs r0,r0,r0	; 038052D0
	adcs r3,r1,r3, lsl #0x1	; 038052D4
	subcc r3,r3,r1	; 038052D8
	adcs r0,r0,r0	; 038052DC
	adcs r3,r1,r3, lsl #0x1	; 038052E0
	subcc r3,r3,r1	; 038052E4
	adcs r0,r0,r0	; 038052E8
	adcs r3,r1,r3, lsl #0x1	; 038052EC
	subcc r3,r3,r1	; 038052F0
	adcs r0,r0,r0	; 038052F4
	adcs r3,r1,r3, lsl #0x1	; 038052F8
	subcc r3,r3,r1	; 038052FC
	adcs r0,r0,r0	; 03805300
	adcs r3,r1,r3, lsl #0x1	; 03805304
	subcc r3,r3,r1	; 03805308
	adcs r0,r0,r0	; 0380530C
	adcs r3,r1,r3, lsl #0x1	; 03805310
	subcc r3,r3,r1	; 03805314
	adcs r0,r0,r0	; 03805318
	adcs r3,r1,r3, lsl #0x1	; 0380531C
	subcc r3,r3,r1	; 03805320
	adcs r0,r0,r0	; 03805324
	adcs r3,r1,r3, lsl #0x1	; 03805328
	subcc r3,r3,r1	; 0380532C
	adcs r0,r0,r0	; 03805330
	adcs r3,r1,r3, lsl #0x1	; 03805334
	subcc r3,r3,r1	; 03805338
	adcs r0,r0,r0	; 0380533C
	adcs r3,r1,r3, lsl #0x1	; 03805340
	subcc r3,r3,r1	; 03805344
	adcs r0,r0,r0	; 03805348
	adcs r3,r1,r3, lsl #0x1	; 0380534C
	subcc r3,r3,r1	; 03805350
	adcs r0,r0,r0	; 03805354
	adcs r3,r1,r3, lsl #0x1	; 03805358
	subcc r3,r3,r1	; 0380535C
	adcs r0,r0,r0	; 03805360
	adcs r3,r1,r3, lsl #0x1	; 03805364
	subcc r3,r3,r1	; 03805368
	adcs r0,r0,r0	; 0380536C
P2_DivisionDispatch_038051E8End:
.if (P2_DivisionDispatch_038051E8Steps != P2_DivisionDispatch_038051E8PC + 8) || (P2_DivisionDispatch_038051E8End - P2_DivisionDispatch_038051E8Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 03805370
	bx lr	; 03805374

; ===== function loc_03805378 =====
loc_03805378:
	ands r2,r2,#0x3f	; 03805378
	bxeq lr	; 0380537C
	subs r3,r2,#0x20	; 03805380
	bge loc_0380539C	; 03805384
	rsb r3,r2,#0x20	; 03805388
	mov r0,r0, lsr r2	; 0380538C
	orr r0,r0,r1, lsl r3	; 03805390
	mov r1,r1, lsr r2	; 03805394
	bx lr	; 03805398
loc_0380539C:
	mov r0,r1, lsr r3	; 0380539C
	mov r1,#0x0	; 038053A0
	bx lr	; 038053A4

; ===== function loc_038053A8 =====
loc_038053A8:
	stmdb sp!,{lr}	; 038053A8
	bl loc_03805450	; 038053AC
	mov r1,#0x0	; 038053B0
	str r1,[r0,#0x0]	; 038053B4
	bl loc_0380545C	; 038053B8
	mov r1,#0x0	; 038053BC
	str r1,[r0,#0x4]	; 038053C0
	str r1,[r0,#0x8]	; 038053C4
	str r1,[r0,#0xc]	; 038053C8
	str r1,[r0,#0x10]	; 038053CC
	str r1,[r0,#0x14]	; 038053D0
	ldmia sp!,{lr}	; 038053D4
	bx lr	; 038053D8
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x1A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 038053EC
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 038053FC
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0380540C
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0380541C
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x0A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0380542C
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0380543C
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0380544C
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 03805450

; ===== function loc_03805450 =====
loc_03805450:
	ldr r12,[pool_03805458]	; 03805450
	bx r12	; 03805454
pool_03805458:
loc_03805458:
	.word loc_038054A0 + 1	; 03805458

; ===== function loc_0380545C =====
loc_0380545C:
	ldr r12,[pool_03805464]	; 0380545C
	bx r12	; 03805460
pool_03805464:
loc_03805464:
	.word loc_038054A8 + 1	; 03805464
.thumb

; ===== function loc_03805468 =====
loc_03805468:
	bx r0	; 03805468
	.byte 0x00, 0x00	; 0380546C

; ===== function loc_0380546C =====
loc_0380546C:
	bx r1	; 0380546C
	.byte 0x00, 0x00	; 03805470

; ===== function loc_03805470 =====
loc_03805470:
	bx r2	; 03805470
	.byte 0x00, 0x00	; 03805474

; ===== function loc_03805474 =====
loc_03805474:
	bx r3	; 03805474
	.byte 0x00, 0x00	; 03805478

; ===== function loc_03805478 =====
loc_03805478:
	bx r4	; 03805478
	.byte 0x00, 0x00	; 0380547C

; ===== function loc_0380547C =====
loc_0380547C:
	bx r5	; 0380547C
	.byte 0x00, 0x00	; 03805480

; ===== function loc_03805480 =====
loc_03805480:
	push {r4,lr}	; 03805480
	ldr r4,[pool_0380549C]	; 03805482
	b loc_0380548A	; 03805484
loc_03805486:
	.byte 0x80, 0x47, 0x24, 0x1D	; 0380548A
loc_0380548A:
	cmp r4,#0x0	; 0380548A
	beq loc_03805494	; 0380548C
	ldr r0,[r4,#0x0]	; 0380548E
	cmp r0,#0x0	; 03805490
	bne loc_03805486	; 03805492
loc_03805494:
	pop {r4}	; 03805494
	pop {r3}	; 03805496
	bx r3	; 03805498
	.byte 0xC0, 0x46	; 0380549C
pool_0380549C:
loc_0380549C:
	.word 0x0380562C	; 0380549C

; ===== function loc_038054A0 =====
loc_038054A0:
	ldr r0,[pool_038054A4]	; 038054A0
	bx lr	; 038054A2
pool_038054A4:
loc_038054A4:
	.word 0x0380805C	; 038054A4

; ===== function loc_038054A8 =====
loc_038054A8:
	ldr r0,[pool_038054AC]	; 038054A8
	bx lr	; 038054AA
pool_038054AC:
loc_038054AC:
	.word 0x03808060	; 038054AC
	.byte 0x81, 0x54, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00	; 038054B0
P2_Data_038054BC:
	.byte 0x49, 0x32, 0x00, 0x00	; 038054BC
P2_Data_038054C0:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 038054C0
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 038054D0
P2_Data_038054E0:
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 038054E0
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 038054F0
	.byte 0x7F, 0x00, 0x00, 0x00	; 03805500
P2_Data_03805504:
	.byte 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 03805504
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 03805510
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 03805520
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 03805530
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 03805540
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 03805550
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 03805560
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 03805570
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 03805580
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 03805590
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 038055A0
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 038055B0
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 038055C0
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 038055D0
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 038055E0
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 038055F0
	.byte 0xFF, 0xFF, 0x00, 0x00	; 03805600
P2_Data_03805604:
	.byte 0x00, 0x01, 0x02, 0x04	; 03805604
P2_Data_03805608:
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 03805608
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D	; 03805610
P2_Data_03805618:
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 03805618
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805620
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P2_CrtDataInitTable:
	.word P2_CopyDescriptors, P2_CopyDescriptorsEnd
	.word P2_WramCopy0LoadStart
	.word P2_BssStart, P2_BssEnd
P2_Data_03805644:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 03805644
	.byte 0x00, 0x00, 0x00, 0x00	; 03805654
P2_Data_03805658:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P2_IrqHandlers:
	.word P2_IrqHandler_037FDD3C + 1	; IRQ 0
	.word loc_037FDE2C + 1	; IRQ 1
	.word loc_037FDE2C + 1	; IRQ 2
	.word P2_IrqHandler_037FDD94 + 1	; IRQ 3
	.word P2_IrqHandler_037FDD88 + 1	; IRQ 4
	.word P2_IrqHandler_037FDD7C + 1	; IRQ 5
	.word P2_IrqHandler_037FDD70 + 1	; IRQ 6
	.word loc_037FDE2C + 1	; IRQ 7
	.word P2_IrqHandler_037FDDC4 + 1	; IRQ 8
	.word P2_IrqHandler_037FDDB8 + 1	; IRQ 9
	.word P2_IrqHandler_037FDDAC + 1	; IRQ 10
	.word P2_IrqHandler_037FDDA0 + 1	; IRQ 11
	.word loc_037FDE2C + 1	; IRQ 12
	.word loc_037FDE2C + 1	; IRQ 13
	.word loc_037FDE2C + 1	; IRQ 14
	.word loc_037FDE2C + 1	; IRQ 15
	.word loc_037FDE2C + 1	; IRQ 16
	.word loc_037FDE2C + 1	; IRQ 17
	.word loc_037FDE2C + 1	; IRQ 18
	.word loc_037FDE2C + 1	; IRQ 19
	.word loc_037FDE2C + 1	; IRQ 20
	.word loc_037FDE2C + 1	; IRQ 21
	.word loc_037FDE2C + 1	; IRQ 22
	.word loc_037FDE2C + 1	; IRQ 23
	.word loc_037FDE2C + 1	; IRQ 24
P2_IrqHandlersEnd:
	.byte 0xFD, 0xE1, 0x7F, 0x03	; 038056BC
.thumb
P2_Data_038056C0:
	.word 0x12345678	; 038056D0
; ARM7 sound-alarm diagnostic string. / ARM7 声音告警诊断字符串。
P2_SoundAlarmDiagnosticText:
	.ascii "Failed sound alarm OS_SendMessage"
	.byte 0x0A, 0x00, 0x00	; 038056E5
P2_Data_038056E8:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x08	; 038056E8
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC, 0x08, 0x00, 0x01, 0x00, 0x00	; 038056F5
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805705
	.byte 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0xF8, 0x14	; 03805715
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x0C, 0x00, 0x01, 0x00, 0x00	; 03805725
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805735
	.byte 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x20	; 03805745
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00	; 03805755
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805765
	.byte 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00	; 03805775
; CRT 复制后，此保存区复用为主 BSS；下游偏移仍保留原内存布局。
; After CRT copying, reuse this load area as BSS; keep the original field offsets.
P2_BssStart:
; 本 CPU 的 32 项 FIFO 回调表，按通道索引；位于 CRT 清零的 BSS。
; This CPU's 32 FIFO callback slots, indexed by channel, live in CRT-cleared BSS.
.definelabel P2_PxiReceiveCallbacks, P2_BssStart + 0x1F3C
.definelabel P2_PxiReceiveCallbacksEnd, P2_PxiReceiveCallbacks + PxiFifoChannelCount * 4
.definelabel P2_CachedFirmwareHeader, P2_BssStart + 0x2C
.definelabel P2_BssEnd, P2_BssStart + 0x28FC

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
	bl P2_Entry_037FE814	; 037F8374
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
	.word 0x0230FF04	; 037F83A4
pool_037F83A8:
	.word 0x00000100	; 037F83A8
pool_037F83AC:
	.word 0x027FFF96	; 037F83AC
pool_037F83B0:
	.word P4_BssStart + 0x23C0	; 037F83B0
P2_Runtime_037F83B4:
	push {r4,r5,r6,lr}	; 037F83B4
	ldr r0,[pool_037F83E0]	; 037F83B6
	bl P2_Entry_037FE814	; 037F83B8
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
	bl P2_Entry_037FE7D0	; 037F83D4
	pop {r4,r5,r6}	; 037F83D8
	pop {r3}	; 037F83DA
	bx r3	; 037F83DC
	.byte 0xC0, 0x46	; 037F83DE
pool_037F83E0:
	.word 0x0230FF04	; 037F83E0
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
	bl loc_03802320	; 037F8406
	cmp r0,#0x0	; 037F840A
	blt P2_Runtime_037F83FA	; 037F840C
	ldr r0,[pool_037F8420]	; 037F840E
	bl P2_Entry_037FE7D0	; 037F8410
	add sp,#0x4	; 037F8414
	pop {r4,r5,r6,r7}	; 037F8416
	pop {r3}	; 037F8418
	bx r3	; 037F841A
pool_037F841C:
	.word 0x00000100	; 037F841C
pool_037F8420:
	.word 0x0230FF04	; 037F8420
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
	bl loc_03802240	; 0380F61C
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
	bl loc_03805468	; 0380F668
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
	.word 0x037F8000	; 0380F76C
pool_0380F770:
	.word 0x0380F600	; 0380F770
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
	.word 0x0380F6F8	; 0380F81C
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
	.word 0x0380F64D	; 0380F8A4
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
.thumb
.close

; 延迟补丁阶段复用早期启动信息暂存区：补丁、目标地址、原入口，随后是入口代码。
; Deferred patching reuses the early boot-info scratch: payload, destination, saved entry, then code.
.definelabel P2_DeferredPatchPayload, FirmwareBootInfoScratchAddress
.definelabel P2_DeferredPatchPayloadBytes, 20
.definelabel P2_DeferredPatchDestination, P2_DeferredPatchPayload + P2_DeferredPatchPayloadBytes
.definelabel P2_DeferredPatchOriginalEntry, P2_DeferredPatchDestination + 4

; 中转缓冲区紧接传输线程栈顶；每次回调固定复制一块，尾块也不缩短。
; The bounce buffer starts at the transfer-thread stack top; callbacks always copy a full block.
.definelabel P2_CartReadBuffer, P2_BssStart + 0x4CC
.definelabel P2_CartReadBlockBytes, 0x200
