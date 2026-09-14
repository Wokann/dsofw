; official_v3_p2
; Readable armips reconstruction exported from Ghidra.
; Recognised code is assembly; data is retained only where Ghidra has no instruction.
.nds
.create "build/p2.bin", 0x037FA800
.arm
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
	bl loc_037FA8B8	; 037FA85C
	bl loc_037FA92C	; 037FA860
	ldr r1,[pool_037FA89C]	; 037FA864
	ldr r0,[pool_037FA8A0]	; 037FA868
	str r0,[r1,#0x0]	; 037FA86C
	bl loc_03804F80	; 037FA870
	bl loc_037FA968	; 037FA874
	bl loc_037FA8AC	; 037FA878
	ldr r1,[pool_037FA8A4]	; 037FA87C
	ldr lr,[pool_037FA8A8]	; 037FA880
	bx r1	; 037FA884
pool_037FA888:
loc_037FA888:
	.word 0x03807A4C	; 037FA888
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
	.word 0x0380FFFC	; 037FA89C
pool_037FA8A0:
loc_037FA8A0:
	.word 0x037FD798	; 037FA8A0
pool_037FA8A4:
loc_037FA8A4:
	.word 0x037FAD35	; 037FA8A4
pool_037FA8A8:
loc_037FA8A8:
	.word 0x0380F818	; 037FA8A8

; ===== function loc_037FA8AC =====
loc_037FA8AC:
	ldr r12,[pool_037FA8B4]	; 037FA8AC
	bx r12	; 037FA8B0
pool_037FA8B4:
loc_037FA8B4:
	.word 0x03805059	; 037FA8B4

; ===== function loc_037FA8B8 =====
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
	.word 0x03805208	; 037FA924
loc_037FA928:
	bx lr	; 037FA928

; ===== function loc_037FA92C =====
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
pool_037FA964:
loc_037FA964:
	.word 0x027FFFFA	; 037FA964

; ===== function loc_037FA968 =====
loc_037FA968:
	bx lr	; 037FA968
.thumb

; ===== function loc_037FA96C =====
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
pool_037FA988:
loc_037FA988:
	.word 0x03805094	; 037FA988
pool_037FA98C:
loc_037FA98C:
	.word 0x03805364	; 037FA98C
pool_037FA990:
loc_037FA990:
	.word 0x03805360	; 037FA990
pool_037FA994:
loc_037FA994:
	.word 0x0380535C	; 037FA994
.arm

; ===== function loc_037FA998 =====
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
pool_037FA9D8:
loc_037FA9D8:
	.word 0x0380535C	; 037FA9D8
pool_037FA9DC:
loc_037FA9DC:
	.word 0x027FF884	; 037FA9DC
pool_037FA9E0:
loc_037FA9E0:
	.word 0x04000006	; 037FA9E0
.thumb

; ===== function loc_037FA9E4 =====
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
	bl loc_038048D4	; 037FAA0A
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
	bl loc_038048D4	; 037FAA26
	mov r0,#0x0	; 037FAA2A
	str r0,[sp,#0x8]	; 037FAA2C
	add r0,sp,#0x8	; 037FAA2E
	ldr r1,[pool_037FAA80]	; 037FAA30
	ldr r2,[pool_037FAA84]	; 037FAA32
	bl loc_038048D4	; 037FAA34
	mov r0,#0x0	; 037FAA38
	str r0,[sp,#0xc]	; 037FAA3A
	add r0,sp,#0xc	; 037FAA3C
	ldr r1,[pool_037FAA88]	; 037FAA3E
	ldr r2,[pool_037FAA8C]	; 037FAA40
	bl loc_038048D4	; 037FAA42
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
pool_037FAA64:
loc_037FAA64:
	.word 0x04000208	; 037FAA64
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
	.word 0x040000B0	; 037FAA78
pool_037FAA7C:
loc_037FAA7C:
	.word 0x01000023	; 037FAA7C
pool_037FAA80:
loc_037FAA80:
	.word 0x04000400	; 037FAA80
pool_037FAA84:
loc_037FAA84:
	.word 0x01000041	; 037FAA84
pool_037FAA88:
loc_037FAA88:
	.word 0x04000508	; 037FAA88
pool_037FAA8C:
loc_037FAA8C:
	.word 0x01000005	; 037FAA8C
pool_037FAA90:
loc_037FAA90:
	.word 0x04000004	; 037FAA90
pool_037FAA94:
loc_037FAA94:
	.word 0x040001C0	; 037FAA94
pool_037FAA98:
loc_037FAA98:
	.word 0x00004008	; 037FAA98
pool_037FAA9C:
loc_037FAA9C:
	.word 0x04000184	; 037FAA9C

; ===== function loc_037FAAA0 =====
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
	bl loc_037FAC2C	; 037FAAB8
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
	bl loc_037FAC2C	; 037FAAD6
	ldr r0,[pool_037FAB04]	; 037FAADA
	bl loc_037FAD0C	; 037FAADC
	pop {r4}	; 037FAAE0
	pop {r3}	; 037FAAE2
	bx r3	; 037FAAE4
	.byte 0xC0, 0x46	; 037FAAE8
pool_037FAAE8:
loc_037FAAE8:
	.word 0x0380537C	; 037FAAE8
pool_037FAAEC:
loc_037FAAEC:
	.word 0x027FF876	; 037FAAEC
pool_037FAAF0:
loc_037FAAF0:
	.word 0x022C0000	; 037FAAF0
pool_037FAAF4:
loc_037FAAF4:
	.word 0x02300200	; 037FAAF4
pool_037FAAF8:
loc_037FAAF8:
	.word 0x027FF86C	; 037FAAF8
pool_037FAAFC:
loc_037FAAFC:
	.word 0x0380536C	; 037FAAFC
pool_037FAB00:
loc_037FAB00:
	.word 0x027FF870	; 037FAB00
pool_037FAB04:
loc_037FAB04:
	.word 0x00001000	; 037FAB04

; ===== function loc_037FAB08 =====
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
	bl loc_037FAC2C	; 037FAB1E
	ldr r0,[pool_037FAB3C]	; 037FAB22
	bl loc_037FAD0C	; 037FAB24
	add sp,#0x4	; 037FAB28
	pop {r3}	; 037FAB2A
	bx r3	; 037FAB2C
	.byte 0xC0, 0x46	; 037FAB30
pool_037FAB30:
loc_037FAB30:
	.word 0x0380537C	; 037FAB30
pool_037FAB34:
loc_037FAB34:
	.word 0x027FF874	; 037FAB34
pool_037FAB38:
loc_037FAB38:
	.word 0x022C0000	; 037FAB38
pool_037FAB3C:
loc_037FAB3C:
	.word 0x00002000	; 037FAB3C

; ===== function loc_037FAB40 =====
loc_037FAB40:
	push {lr}	; 037FAB40
	sub sp,#0x4	; 037FAB42
	mov r0,#0x0	; 037FAB44
	ldr r1,[pool_037FAB60]	; 037FAB46
	mov r2,#0x2c	; 037FAB48
	add r3,r0,#0x0	; 037FAB4A
	bl loc_037FAC2C	; 037FAB4C
	ldr r0,[pool_037FAB60]	; 037FAB50
	ldrh r0,[r0,#0x20]	; 037FAB52
	lsl r1,r0,#0x3	; 037FAB54
	ldr r0,[pool_037FAB64]	; 037FAB56
	str r1,[r0,#0x0]	; 037FAB58
	add sp,#0x4	; 037FAB5A
	pop {r3}	; 037FAB5C
	bx r3	; 037FAB5E
pool_037FAB60:
loc_037FAB60:
	.word 0x0380537C	; 037FAB60
pool_037FAB64:
loc_037FAB64:
	.word 0x027FF868	; 037FAB64

; ===== function loc_037FAB68 =====
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
	bl loc_038048D4	; 037FAB8C
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
	bl loc_038048D4	; 037FABB6
loc_037FABBA:
	add sp,#0xc	; 037FABBA
	pop {r3}	; 037FABBC
	bx r3	; 037FABBE
pool_037FABC0:
loc_037FABC0:
	.word 0x02010000	; 037FABC0
pool_037FABC4:
loc_037FABC4:
	.word 0x027FFE28	; 037FABC4
pool_037FABC8:
loc_037FABC8:
	.word 0x001FFFFF	; 037FABC8
pool_037FABCC:
loc_037FABCC:
	.word 0x01000000	; 037FABCC
pool_037FABD0:
loc_037FABD0:
	.word 0x027FFE2C	; 037FABD0
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

; ===== function loc_037FAC2C =====
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
pool_037FAC44:
loc_037FAC44:
	.word 0x0380536C	; 037FAC44
pool_037FAC48:
loc_037FAC48:
	.word 0x038053A4	; 037FAC48

; ===== function loc_037FAC4C =====
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
pool_037FAC98:
loc_037FAC98:
	.word 0x0380536C	; 037FAC98
pool_037FAC9C:
loc_037FAC9C:
	.word 0x03805368	; 037FAC9C
pool_037FACA0:
loc_037FACA0:
	.word 0x03805378	; 037FACA0

; ===== function loc_037FACA4 =====
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
	.word 0x038079F0	; 037FACC4
pool_037FACC8:
loc_037FACC8:
	.word 0x0380FFF8	; 037FACC8
	mov r1,#0x6	; 037FACCC
	ldr r0,[pool_037FACD4]	; 037FACCE
	str r1,[r0,#0x0]	; 037FACD0
	bx lr	; 037FACD2
pool_037FACD4:
loc_037FACD4:
	.word 0x03805354	; 037FACD4
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
	.word 0x03805354	; 037FAD08

; ===== function loc_037FAD0C =====
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
pool_037FAD30:
loc_037FAD30:
	.word 0x027FF888	; 037FAD30
loc_037FAD34:
	push {r4,r5,r6,r7,lr}	; 037FAD34
	sub sp,#0xc	; 037FAD36
	mov r0,#0x0	; 037FAD38
	str r0,[sp,#0x8]	; 037FAD3A
	add r0,sp,#0x8	; 037FAD3C
	ldr r1,[pool_037FAF18]	; 037FAD3E
	ldr r2,[pool_037FAF1C]	; 037FAD40
	bl loc_038048D4	; 037FAD42
	ldr r1,[pool_037FAF20]	; 037FAD46
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
	bl loc_038048B6	; 037FAD68
	bl loc_037FABD8	; 037FAD6C
	bl loc_037FE440	; 037FAD70
	ldr r0,[pool_037FAF38]	; 037FAD74
	bl 0x0380f618	; 037FAD76
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
	bl loc_03801F74	; 037FADB0
	ldr r0,[pool_037FAF4C]	; 037FADB4
	str r0,[sp,#0x0]	; 037FADB6
	mov r0,#0xe	; 037FADB8
	str r0,[sp,#0x4]	; 037FADBA
	ldr r0,[pool_037FAF50]	; 037FADBC
	ldr r1,[pool_037FAF54]	; 037FADBE
	mov r2,#0x0	; 037FADC0
	ldr r3,[pool_037FAF58]	; 037FADC2
	bl loc_037FDF88	; 037FADC4
	bl loc_037FA96C	; 037FADC8
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
	bl loc_037FAB40	; 037FADFC
	bl loc_037FAB08	; 037FAE00
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
	bl loc_037FAB68	; 037FAE3A
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
	bl loc_037FAD0C	; 037FAE6C
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
	bl loc_037FA9E4	; 037FAEA0
	ldr r1,[pool_037FAF90]	; 037FAEA4
	ldr r0,[pool_037FAF94]	; 037FAEA6
	strh r1,[r0,#0x0]	; 037FAEA8
	b loc_037FAF0E	; 037FAEAA
loc_037FAEAC:
	ldr r0,[r4,#0x24]	; 037FAEAC
	cmp r0,#0x5	; 037FAEAE
	bne loc_037FAEBC	; 037FAEB0
	bl loc_037FAAA0	; 037FAEB2
	mov r0,#0x7	; 037FAEB6
	str r0,[r5,#0x0]	; 037FAEB8
	b loc_037FAE10	; 037FAEBA
loc_037FAEBC:
	ldr r0,[r4,#0x24]	; 037FAEBC
	cmp r0,#0x8	; 037FAEBE
	bne loc_037FAED8	; 037FAEC0
	mov r1,#0x6	; 037FAEC2
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
	bl loc_038048D4	; 037FAEF6
	mov r0,#0x10	; 037FAEFA
	bl loc_038048BE	; 037FAEFC
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
	.word 0x04001080	; 037FAF24
pool_037FAF28:
loc_037FAF28:
	.word 0x00001000	; 037FAF28
pool_037FAF2C:
loc_037FAF2C:
	.word 0x04000128	; 037FAF2C
pool_037FAF30:
loc_037FAF30:
	.word 0x04000120	; 037FAF30
pool_037FAF34:
loc_037FAF34:
	.word 0x04000304	; 037FAF34
pool_037FAF38:
loc_037FAF38:
	.word 0x037FACCD	; 037FAF38
pool_037FAF3C:
loc_037FAF3C:
	.word 0x03807A4C	; 037FAF3C
pool_037FAF40:
loc_037FAF40:
	.word 0x0380F600	; 037FAF40
pool_037FAF44:
loc_037FAF44:
	.word 0x03805368	; 037FAF44
pool_037FAF48:
loc_037FAF48:
	.word 0x037FACD9	; 037FAF48
pool_037FAF4C:
loc_037FAF4C:
	.word 0x00000400	; 037FAF4C
pool_037FAF50:
loc_037FAF50:
	.word 0x038053A4	; 037FAF50
pool_037FAF54:
loc_037FAF54:
	.word 0x037FAC4D	; 037FAF54
pool_037FAF58:
loc_037FAF58:
	.word 0x0380581C	; 037FAF58
pool_037FAF5C:
loc_037FAF5C:
	.word 0x00080000	; 037FAF5C
pool_037FAF60:
loc_037FAF60:
	.word 0x03805364	; 037FAF60
pool_037FAF64:
loc_037FAF64:
	.word 0x037FACA5	; 037FAF64
pool_037FAF68:
loc_037FAF68:
	.word 0x04000004	; 037FAF68
pool_037FAF6C:
loc_037FAF6C:
	.word 0x04000208	; 037FAF6C
pool_037FAF70:
loc_037FAF70:
	.word 0x027FF884	; 037FAF70
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
	.word 0x03805360	; 037FAF80
pool_037FAF84:
loc_037FAF84:
	.word 0x00000200	; 037FAF84
pool_037FAF88:
loc_037FAF88:
	.word 0x03805354	; 037FAF88
pool_037FAF8C:
loc_037FAF8C:
	.word 0x027FF880	; 037FAF8C
pool_037FAF90:
loc_037FAF90:
	.word 0x00002100	; 037FAF90
pool_037FAF94:
loc_037FAF94:
	.word 0x04000180	; 037FAF94
pool_037FAF98:
loc_037FAF98:
	.word 0x027FF810	; 037FAF98
pool_037FAF9C:
loc_037FAF9C:
	.word 0x037FA998	; 037FAF9C
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
	.word 0x037FDB64	; 037FAFB0
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
	.word 0x037FF0AC	; 037FAFBC
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
	.word 0x023002EC	; 037FAFC8
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
	.word 0x04000304	; 037FB01C
pool_037FB020:
loc_037FB020:
	.word 0x04000206	; 037FB020

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
	.word 0x0480817E	; 037FB0A0
pool_037FB0A4:
loc_037FB0A4:
	.word 0x0480817C	; 037FB0A4

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
	.word 0x0480815A	; 037FB0F0
pool_037FB0F4:
loc_037FB0F4:
	.word 0x00005000	; 037FB0F4
pool_037FB0F8:
loc_037FB0F8:
	.word 0x04808158	; 037FB0F8

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
	.word 0x04808158	; 037FB120
pool_037FB124:
loc_037FB124:
	.word 0x0480815C	; 037FB124

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
	.word 0x04808184	; 037FB140

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
	.word 0x04808160	; 037FB180

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
	.word 0x037FF2D8	; 037FB1D4
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
	.word 0x03805098	; 037FB228
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
	.word 0x04808168	; 037FB2D8
pool_037FB2DC:
loc_037FB2DC:
	.word 0x04808036	; 037FB2DC

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
	.word 0x04808036	; 037FB2FC
pool_037FB300:
loc_037FB300:
	.word 0x00051D23	; 037FB300
pool_037FB304:
loc_037FB304:
	.word 0x04808168	; 037FB304

; ===== function loc_037FB308 =====
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
	.word 0x0380FFF4	; 037FB370
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
	.word 0x0380FFF4	; 037FB3FC
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
	.word 0x0380FFF4	; 037FB454
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
	.word 0x0380FFF4	; 037FB4B4
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
	.word 0x0380FFF4	; 037FB5F8
pool_037FB5FC:
loc_037FB5FC:
	.word 0x00000150	; 037FB5FC
pool_037FB600:
loc_037FB600:
	.word 0x0000BF1D	; 037FB600
	.byte 0x70, 0xB5, 0x0D, 0x1C, 0x11, 0x4A, 0x13, 0x68, 0x11, 0x4A, 0x9C, 0x18, 0x6B, 0x89, 0x11, 0x4A	; 037FB614
	.byte 0x93, 0x42, 0x01, 0xD0, 0x01, 0x20, 0x15, 0xE0, 0xFF, 0xF7, 0x76, 0xFF, 0x06, 0x1C, 0x00, 0x2E	; 037FB624
	.byte 0x0F, 0xD1, 0x20, 0x68, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x28, 0x06, 0xD0, 0x09, 0xE0, 0x60, 0x68	; 037FB634
	.byte 0xA1, 0x68, 0x2A, 0x1C, 0x03, 0xF0, 0x28, 0xF8, 0x03, 0xE0, 0x28, 0x1C, 0xA1, 0x68, 0x09, 0xF0	; 037FB644
	.byte 0xFF, 0xFC, 0x30, 0x1C, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 037FB654
	.byte 0x50, 0x01, 0x00, 0x00, 0x1D, 0xBF, 0x00, 0x00	; 037FB65C

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
	.byte 0x40, 0x68, 0x70, 0x47	; 037FB714

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
	.word 0x0380FFF4	; 037FB8DC
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
	.word 0x0380FFF4	; 037FB974
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
	add r2,pc	; 037FBA52
	ldrh r2,[r2,#0x8]	; 037FBA54
	lsl r2,r2,#0x10	; 037FBA56
	asr r2,r2,#0x10	; 037FBA58
	add r2,pc	; 037FBA5A
	bx r2	; 037FBA5C
	.byte 0x0B, 0x00, 0x33, 0x00, 0xD3, 0x00, 0x43, 0x01, 0x8B, 0x01	; 037FBA68
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
	.word 0x0380FFF4	; 037FBC24
pool_037FBC28:
loc_037FBC28:
	.word 0x00000318	; 037FBC28
pool_037FBC2C:
loc_037FBC2C:
	.word 0x000002F0	; 037FBC2C
pool_037FBC30:
loc_037FBC30:
	.word 0x04808044	; 037FBC30
pool_037FBC34:
loc_037FBC34:
	.word 0x00008000	; 037FBC34
pool_037FBC38:
loc_037FBC38:
	.word 0x04808032	; 037FBC38
pool_037FBC3C:
loc_037FBC3C:
	.word 0x0000FFFF	; 037FBC3C
pool_037FBC40:
loc_037FBC40:
	.word 0x04808134	; 037FBC40
pool_037FBC44:
loc_037FBC44:
	.word 0x0480802A	; 037FBC44
pool_037FBC48:
loc_037FBC48:
	.word 0x04808028	; 037FBC48
pool_037FBC4C:
loc_037FBC4C:
	.word 0x04808038	; 037FBC4C
pool_037FBC50:
loc_037FBC50:
	.word 0x04808030	; 037FBC50
pool_037FBC54:
loc_037FBC54:
	.word 0x04808010	; 037FBC54
pool_037FBC58:
loc_037FBC58:
	.word 0x00001FFF	; 037FBC58
pool_037FBC5C:
loc_037FBC5C:
	.word 0x048081AE	; 037FBC5C
pool_037FBC60:
loc_037FBC60:
	.word 0x00000638	; 037FBC60
pool_037FBC64:
loc_037FBC64:
	.word 0x00000400	; 037FBC64
pool_037FBC68:
loc_037FBC68:
	.word 0x048081AA	; 037FBC68
pool_037FBC6C:
loc_037FBC6C:
	.word 0x04808008	; 037FBC6C
pool_037FBC70:
loc_037FBC70:
	.word 0x0480800A	; 037FBC70
pool_037FBC74:
loc_037FBC74:
	.word 0x04808012	; 037FBC74
pool_037FBC78:
loc_037FBC78:
	.word 0x048080D0	; 037FBC78
pool_037FBC7C:
loc_037FBC7C:
	.word 0x048080E0	; 037FBC7C
pool_037FBC80:
loc_037FBC80:
	.word 0x048080E8	; 037FBC80
pool_037FBC84:
loc_037FBC84:
	.word 0x04808004	; 037FBC84
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
	.word 0x048080F8	; 037FBC94
pool_037FBC98:
loc_037FBC98:
	.word 0x048080FA	; 037FBC98
pool_037FBC9C:
loc_037FBC9C:
	.word 0x048080FC	; 037FBC9C
pool_037FBCA0:
loc_037FBCA0:
	.word 0x048080FE	; 037FBCA0
pool_037FBCA4:
loc_037FBCA4:
	.word 0x048080F6	; 037FBCA4
pool_037FBCA8:
loc_037FBCA8:
	.word 0x048080F4	; 037FBCA8
pool_037FBCAC:
loc_037FBCAC:
	.word 0x048080F2	; 037FBCAC
pool_037FBCB0:
loc_037FBCB0:
	.word 0x048080F0	; 037FBCB0
pool_037FBCB4:
loc_037FBCB4:
	.word 0x048080EA	; 037FBCB4
pool_037FBCB8:
loc_037FBCB8:
	.word 0x048080AE	; 037FBCB8
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
	.word 0x04808048	; 037FBCD0

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
	.word 0x0230515D	; 037FBCE0
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
	.word 0x02306EE1	; 037FBCF0
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
	.word 0x0230D1BD	; 037FBD00
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
	.word 0x03804908	; 037FBD0C
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
	.word 0x03804B10	; 037FBD18
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
	.word 0x0230A3A9	; 037FBD28
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
	.word 0x02305D25	; 037FBD38
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
	.word 0x02305E91	; 037FBD48
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
	.word 0x02307805	; 037FBD58
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
	.word 0x0380FFF4	; 037FBDB8
pool_037FBDBC:
loc_037FBDBC:
	.word 0x00000318	; 037FBDBC
pool_037FBDC0:
loc_037FBDC0:
	.word 0x04808012	; 037FBDC0
pool_037FBDC4:
loc_037FBDC4:
	.word 0x04808004	; 037FBDC4
pool_037FBDC8:
loc_037FBDC8:
	.word 0x048080EA	; 037FBDC8
pool_037FBDCC:
loc_037FBDCC:
	.word 0x048080E8	; 037FBDCC
pool_037FBDD0:
loc_037FBDD0:
	.word 0x04808008	; 037FBDD0
pool_037FBDD4:
loc_037FBDD4:
	.word 0x0480800A	; 037FBDD4
pool_037FBDD8:
loc_037FBDD8:
	.word 0x0000FFFF	; 037FBDD8
pool_037FBDDC:
loc_037FBDDC:
	.word 0x048080AC	; 037FBDDC
pool_037FBDE0:
loc_037FBDE0:
	.word 0x048080B4	; 037FBDE0

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
	.word 0x02305469	; 037FBDF0
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
	.word 0x02305359	; 037FBE00
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
	.word 0x0230A38D	; 037FBE10
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
	.word 0x0230A515	; 037FBE20
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
	.word 0x02304C4D	; 037FBE30
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
	.word 0x0380FFF4	; 037FBE90
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
	.word 0x02305E31	; 037FBEA8
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
	.word 0x02305E85	; 037FBEB8
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
	.word 0x02305DC9	; 037FBEC8
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
	.word 0x02305D01	; 037FBED8
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
	.word 0x02305481	; 037FBEE8
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x01, 0x27, 0x32, 0x4C, 0x32, 0x4E, 0x25, 0x88, 0x30, 0x88, 0x05, 0x40	; 037FBEFC
	.byte 0x00, 0x2D, 0x53, 0xD0, 0x29, 0x1C, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0	; 037FBF0C
	.byte 0x85, 0xFD, 0x29, 0x1C, 0x40, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xBE, 0xFD	; 037FBF1C
	.byte 0x29, 0x1C, 0x29, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0x63, 0xF8, 0x29, 0x1C	; 037FBF2C
	.byte 0x26, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0x98, 0xF8, 0x29, 0x1C, 0x24, 0x48	; 037FBF3C
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xB5, 0xF9, 0x29, 0x1C, 0x21, 0x48, 0x01, 0x40	; 037FBF4C
	.byte 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0x46, 0xF8, 0x29, 0x1C, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29	; 037FBF5C
	.byte 0x01, 0xD0, 0x00, 0xF0, 0xEF, 0xF9, 0x29, 0x1C, 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0	; 037FBF6C
	.byte 0x00, 0xF0, 0x56, 0xFA, 0x28, 0x1C, 0x38, 0x40, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0xF4, 0xFB	; 037FBF7C
	.byte 0x29, 0x1C, 0x30, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xBF, 0xF9, 0x29, 0x1C	; 037FBF8C
	.byte 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xFA, 0xFA, 0x0E, 0x48, 0x05, 0x40	; 037FBF9C
	.byte 0x00, 0x2D, 0xAA, 0xD0, 0x38, 0x1C, 0x00, 0xF0, 0xD9, 0xFC, 0xA6, 0xE7, 0x0B, 0x4A, 0x11, 0x68	; 037FBFAC
	.byte 0x0B, 0x48, 0x01, 0x43, 0x11, 0x60, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FBFBC
	.byte 0x10, 0x80, 0x80, 0x04, 0x12, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00	; 037FBFCC
	.byte 0x00, 0x20, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0xF8, 0xFF, 0x80, 0x03	; 037FBFDC
	.byte 0x00, 0x00, 0x00, 0x01, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FBFEC
	.byte 0x3D, 0x6E, 0x30, 0x02, 0x10, 0xB5, 0x19, 0x48, 0x01, 0x68, 0x19, 0x48, 0x0C, 0x18, 0x19, 0x49	; 037FBFFC
	.byte 0x19, 0x48, 0x01, 0x80, 0x20, 0x89, 0x40, 0x28, 0x23, 0xD1, 0x20, 0x1C, 0x7E, 0x30, 0x00, 0x88	; 037FC00C
	.byte 0x00, 0x28, 0x1E, 0xD0, 0x20, 0x1C, 0x72, 0x30, 0x01, 0x88, 0x20, 0x1C, 0x70, 0x30, 0x00, 0x88	; 037FC01C
	.byte 0x81, 0x42, 0x16, 0xD1, 0x20, 0x1C, 0x80, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x20, 0x1C, 0x80, 0x30	; 037FC02C
	.byte 0x01, 0x80, 0x20, 0x1C, 0x80, 0x30, 0x01, 0x88, 0x20, 0x1C, 0x7E, 0x30, 0x00, 0x88, 0x81, 0x42	; 037FC03C
	.byte 0x07, 0xD9, 0x00, 0x21, 0x20, 0x1C, 0x80, 0x30, 0x01, 0x80, 0x01, 0x20, 0x0D, 0x21, 0xFF, 0xF7	; 037FC04C
	.byte 0x99, 0xF9, 0x01, 0x20, 0x20, 0x82, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 037FC05C
	.byte 0x18, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0xF0, 0xB5, 0x83, 0xB0	; 037FC06C
	.byte 0x7B, 0x48, 0x01, 0x68, 0x7B, 0x48, 0x0D, 0x18, 0x7B, 0x48, 0x0E, 0x18, 0x7B, 0x48, 0x0C, 0x18	; 037FC07C
	.byte 0x7B, 0x49, 0x7C, 0x48, 0x01, 0x80, 0xA8, 0x89, 0x01, 0x28, 0x04, 0xD0, 0x02, 0x28, 0x4B, 0xD0	; 037FC08C
	.byte 0x03, 0x28, 0x5C, 0xD0, 0xE0, 0xE0, 0x20, 0x1C, 0x80, 0x30, 0x01, 0x68, 0x24, 0x31, 0x28, 0x1C	; 037FC09C
	.byte 0x96, 0x30, 0x00, 0x88, 0x0F, 0x18, 0x08, 0x37, 0x73, 0x48, 0x00, 0x88, 0x00, 0x90, 0x38, 0x1C	; 037FC0AC
	.byte 0x00, 0x99, 0x09, 0x06, 0x09, 0x0E, 0x00, 0xF0, 0xF5, 0xF8, 0x78, 0x1C, 0x00, 0x99, 0x09, 0x0A	; 037FC0BC
	.byte 0x09, 0x06, 0x09, 0x0E, 0x00, 0xF0, 0xEE, 0xF8, 0xE8, 0x89, 0x01, 0x28, 0x05, 0xD1, 0x32, 0x8C	; 037FC0CC
	.byte 0x6A, 0x49, 0x08, 0x88, 0x10, 0x18, 0x40, 0x1C, 0x08, 0x80, 0x61, 0x48, 0x00, 0x68, 0x68, 0x49	; 037FC0DC
	.byte 0x41, 0x5A, 0xCA, 0x43, 0x67, 0x49, 0x41, 0x5A, 0x0A, 0x43, 0x67, 0x49, 0x42, 0x52, 0x67, 0x48	; 037FC0EC
	.byte 0x02, 0x88, 0x18, 0x20, 0x11, 0x1C, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1, 0x06, 0x20, 0x02, 0x40	; 037FC0FC
	.byte 0x02, 0x2A, 0x09, 0xD1, 0x20, 0x1C, 0x8C, 0x30, 0x01, 0x68, 0x02, 0x20, 0x81, 0x43, 0x8C, 0x34	; 037FC10C
	.byte 0x21, 0x60, 0x00, 0xF0, 0xB5, 0xFD, 0x9F, 0xE0, 0x20, 0x1C, 0x8C, 0x30, 0x01, 0x68, 0x02, 0x20	; 037FC11C
	.byte 0x01, 0x43, 0x8C, 0x34, 0x21, 0x60, 0x97, 0xE0, 0x68, 0x8A, 0x00, 0x28, 0x06, 0xD0, 0x32, 0x8C	; 037FC12C
	.byte 0x52, 0x49, 0x08, 0x88, 0x10, 0x18, 0x40, 0x1C, 0x08, 0x80, 0x02, 0xE0, 0x54, 0x49, 0x4F, 0x48	; 037FC13C
	.byte 0x01, 0x80, 0x68, 0x8B, 0x02, 0x28, 0x02, 0xD1, 0x02, 0x20, 0xFF, 0xF7, 0xF9, 0xFD, 0x28, 0x89	; 037FC14C
	.byte 0x40, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x16, 0xE0, 0x00, 0x20, 0x29, 0x1C, 0x72, 0x31, 0x09, 0x88	; 037FC15C
	.byte 0x01, 0x29, 0x00, 0xD1, 0x01, 0x20, 0xA9, 0x8A, 0x00, 0x29, 0x0C, 0xD0, 0x29, 0x1C, 0x76, 0x31	; 037FC16C
	.byte 0x09, 0x88, 0x01, 0x29, 0x06, 0xD0, 0x00, 0x29, 0x05, 0xD1, 0x29, 0x1C, 0x74, 0x31, 0x09, 0x88	; 037FC17C
	.byte 0x01, 0x29, 0x00, 0xD1, 0x01, 0x20, 0x00, 0x28, 0x05, 0xD0, 0x42, 0x4A, 0x11, 0x88, 0x01, 0x20	; 037FC18C
	.byte 0x01, 0x43, 0x11, 0x80, 0x04, 0xE0, 0x3F, 0x4A, 0x11, 0x88, 0x01, 0x20, 0x81, 0x43, 0x11, 0x80	; 037FC19C
	.byte 0x3D, 0x48, 0x00, 0x88, 0x0A, 0x28, 0x02, 0xD9, 0x00, 0x21, 0x3C, 0x48, 0x01, 0x80, 0x28, 0x1C	; 037FC1AC
	.byte 0x72, 0x30, 0x00, 0x88, 0x41, 0x1E, 0x28, 0x1C, 0x72, 0x30, 0x01, 0x80, 0x28, 0x1C, 0x72, 0x30	; 037FC1BC
	.byte 0x00, 0x88, 0x00, 0x28, 0x05, 0xD1, 0x28, 0x1C, 0x70, 0x30, 0x01, 0x88, 0x28, 0x1C, 0x72, 0x30	; 037FC1CC
	.byte 0x01, 0x80, 0x28, 0x1C, 0x76, 0x30, 0x02, 0x88, 0x28, 0x1C, 0x76, 0x30, 0x00, 0x88, 0x41, 0x1E	; 037FC1DC
	.byte 0x28, 0x1C, 0x76, 0x30, 0x01, 0x80, 0x00, 0x2A, 0x06, 0xD1, 0x28, 0x1C, 0x74, 0x30, 0x00, 0x88	; 037FC1EC
	.byte 0x41, 0x1E, 0x28, 0x1C, 0x76, 0x30, 0x01, 0x80, 0x00, 0x26, 0x01, 0x96, 0x31, 0x1C, 0x14, 0x20	; 037FC1FC
	.byte 0x41, 0x43, 0x67, 0x18, 0x60, 0x5A, 0x00, 0x28, 0x20, 0xD0, 0xF8, 0x68, 0x01, 0x89, 0x00, 0x29	; 037FC20C
	.byte 0x1C, 0xD1, 0x29, 0x1C, 0xA8, 0x31, 0x09, 0x68, 0x80, 0x88, 0x08, 0x1A, 0x00, 0x04, 0x01, 0x0C	; 037FC21C
	.byte 0x28, 0x1C, 0x8C, 0x30, 0x00, 0x88, 0x81, 0x42, 0x10, 0xD9, 0x30, 0x1C, 0x00, 0xF0, 0x58, 0xFD	; 037FC22C
	.byte 0xB9, 0x68, 0x02, 0x20, 0x08, 0x80, 0x01, 0x98, 0x0E, 0x21, 0xFF, 0xF7, 0xA3, 0xF8, 0x20, 0x1C	; 037FC23C
	.byte 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x20, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0x76, 0x1C, 0x02, 0x2E	; 037FC24C
	.byte 0xD4, 0xD3, 0x0D, 0x21, 0x12, 0x48, 0x01, 0x80, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FC25C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00	; 037FC26C
	.byte 0x00, 0x40, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0xF0, 0xFF, 0x80, 0x03, 0x34, 0x81, 0x80, 0x04	; 037FC27C
	.byte 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00, 0x08, 0x05, 0x00, 0x00, 0xB6, 0x80, 0x80, 0x04	; 037FC28C
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x38, 0x80, 0x80, 0x04, 0x18, 0x81, 0x80, 0x04, 0x48, 0x80, 0x80, 0x04	; 037FC29C
	.byte 0xAE, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FC2AC
	.byte 0xA5, 0x51, 0x30, 0x02, 0x0F, 0x48, 0x01, 0x68, 0x0F, 0x48, 0x08, 0x18, 0x0F, 0x4A, 0x10, 0x49	; 037FC2BC
	.byte 0x0A, 0x80, 0x0D, 0x22, 0x0F, 0x49, 0x0A, 0x80, 0x41, 0x8B, 0x01, 0x29, 0x02, 0xD1, 0x02, 0x21	; 037FC2CC
	.byte 0x41, 0x83, 0x70, 0x47, 0x02, 0x29, 0x02, 0xD1, 0x00, 0x21, 0x41, 0x83, 0x70, 0x47, 0x81, 0x89	; 037FC2DC
	.byte 0x02, 0x29, 0x05, 0xD1, 0x00, 0x89, 0x40, 0x28, 0x02, 0xD0, 0x00, 0x21, 0x06, 0x48, 0x01, 0x80	; 037FC2EC
	.byte 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00	; 037FC2FC
	.byte 0x10, 0x80, 0x80, 0x04, 0xAC, 0x80, 0x80, 0x04, 0x48, 0x80, 0x80, 0x04, 0x00, 0xB5, 0x81, 0xB0	; 037FC30C
	.byte 0x00, 0xF0, 0x10, 0xF8, 0x04, 0x49, 0x05, 0x48, 0x01, 0x80, 0x30, 0x21, 0x04, 0x48, 0x01, 0x80	; 037FC31C
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xFF, 0xFF, 0x00, 0x00, 0xAC, 0x81, 0x80, 0x04	; 037FC32C
	.byte 0x10, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FC33C
	.byte 0x59, 0x59, 0x30, 0x02, 0xF0, 0xB5, 0x81, 0xB0, 0x08, 0x21, 0x2A, 0x48, 0x01, 0x80, 0x2A, 0x48	; 037FC34C
	.byte 0x01, 0x68, 0x2A, 0x48, 0x08, 0x5A, 0xC0, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x09, 0xD0, 0x28, 0x48	; 037FC35C
	.byte 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1, 0x26, 0x4A, 0x11, 0x88, 0x41, 0x40	; 037FC36C
	.byte 0x11, 0x80, 0x21, 0x48, 0x02, 0x68, 0x24, 0x48, 0x11, 0x5A, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29	; 037FC37C
	.byte 0x33, 0xD0, 0x22, 0x48, 0x15, 0x18, 0x22, 0x48, 0x14, 0x18, 0x00, 0x26, 0x31, 0x1C, 0x21, 0x48	; 037FC38C
	.byte 0x33, 0x1C, 0x14, 0x22, 0x53, 0x43, 0xE7, 0x18, 0xE2, 0x5A, 0x00, 0x2A, 0x22, 0xD0, 0xBB, 0x68	; 037FC39C
	.byte 0x9F, 0x89, 0x1D, 0x4A, 0x17, 0x40, 0x00, 0x2F, 0x1C, 0xD0, 0x9F, 0x88, 0xFF, 0x22, 0x17, 0x40	; 037FC3AC
	.byte 0x00, 0x2F, 0x17, 0xD0, 0x1F, 0x1C, 0x0C, 0x37, 0x5A, 0x89, 0xBA, 0x18, 0xD2, 0x1F, 0x01, 0x27	; 037FC3BC
	.byte 0xBA, 0x43, 0x17, 0x88, 0x00, 0x2F, 0x0D, 0xD1, 0x52, 0x88, 0x00, 0x2A, 0x0A, 0xD1, 0x99, 0x80	; 037FC3CC
	.byte 0x01, 0x80, 0x12, 0x4A, 0x02, 0x80, 0x2A, 0x1C, 0xBA, 0x32, 0x12, 0x88, 0x53, 0x1C, 0x2A, 0x1C	; 037FC3DC
	.byte 0xBA, 0x32, 0x13, 0x80, 0x76, 0x1C, 0x03, 0x2E, 0xD2, 0xD3, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 037FC3EC
	.byte 0x18, 0x47, 0xC0, 0x46, 0x10, 0x80, 0x80, 0x04, 0xF4, 0xFF, 0x80, 0x03, 0x0E, 0x03, 0x00, 0x00	; 037FC3FC
	.byte 0x9C, 0x81, 0x80, 0x04, 0x90, 0x82, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00, 0x18, 0x03, 0x00, 0x00	; 037FC40C
	.byte 0x00, 0x04, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04, 0x00, 0x40, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 037FC41C
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x3D, 0x48, 0x02, 0x68, 0x3D, 0x49, 0x53, 0x18, 0x3D, 0x4C, 0x12, 0x19	; 037FC42C
	.byte 0x04, 0x25, 0x3D, 0x49, 0x0D, 0x80, 0x3D, 0x49, 0x09, 0x88, 0x05, 0x68, 0x3C, 0x48, 0x2D, 0x5A	; 037FC43C
	.byte 0x08, 0x20, 0x05, 0x40, 0x00, 0x2D, 0x3B, 0xD0, 0x08, 0x1C, 0x20, 0x40, 0x00, 0x28, 0x37, 0xD0	; 037FC44C
	.byte 0x38, 0x48, 0x00, 0x88, 0x01, 0x24, 0x05, 0x1C, 0x25, 0x40, 0x00, 0x2D, 0x02, 0xD0, 0x14, 0x88	; 037FC45C
	.byte 0x00, 0x2C, 0x1B, 0xD1, 0x04, 0x24, 0x05, 0x1C, 0x25, 0x40, 0x00, 0x2D, 0x02, 0xD0, 0x94, 0x8A	; 037FC46C
	.byte 0x00, 0x2C, 0x13, 0xD1, 0x08, 0x24, 0x20, 0x40, 0x00, 0x28, 0x02, 0xD0, 0x10, 0x8D, 0x00, 0x28	; 037FC47C
	.byte 0x0C, 0xD1, 0x2D, 0x48, 0x02, 0x88, 0x01, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x06, 0xD1, 0x00, 0x24	; 037FC48C
	.byte 0x2A, 0x4A, 0x14, 0x80, 0x2A, 0x48, 0x10, 0x80, 0x5C, 0x80, 0x11, 0xE0, 0x5A, 0x88, 0x50, 0x1C	; 037FC49C
	.byte 0x58, 0x80, 0x0C, 0x2A, 0x0C, 0xD9, 0x00, 0x20, 0x58, 0x80, 0x24, 0x4A, 0x10, 0x80, 0x24, 0x48	; 037FC4AC
	.byte 0x10, 0x80, 0x1A, 0x48, 0x02, 0x68, 0x23, 0x48, 0x10, 0x18, 0x02, 0x88, 0x52, 0x1C, 0x02, 0x80	; 037FC4BC
	.byte 0x16, 0x48, 0x02, 0x68, 0x1A, 0x48, 0x12, 0x5A, 0x01, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x20, 0xD0	; 037FC4CC
	.byte 0x60, 0x20, 0x01, 0x40, 0x00, 0x29, 0x1C, 0xD0, 0x1B, 0x48, 0x04, 0x88, 0x1B, 0x48, 0x01, 0x88	; 037FC4DC
	.byte 0x1B, 0x48, 0x08, 0x1A, 0x02, 0x21, 0x00, 0xF0, 0x3F, 0xF8, 0x84, 0x42, 0x08, 0xDA, 0x19, 0x48	; 037FC4EC
	.byte 0x01, 0x88, 0x17, 0x48, 0x08, 0x1A, 0x02, 0x21, 0x00, 0xF0, 0x3C, 0xF8, 0x84, 0x42, 0x06, 0xDA	; 037FC4FC
	.byte 0x15, 0x48, 0x01, 0x88, 0x15, 0x48, 0x01, 0x80, 0x15, 0x49, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FC50C
	.byte 0x37, 0xF8, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 037FC51C
	.byte 0xB4, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0xA8, 0x81, 0x80, 0x04	; 037FC52C
	.byte 0x38, 0x06, 0x00, 0x00, 0xB0, 0x80, 0x80, 0x04, 0x9C, 0x81, 0x80, 0x04, 0x32, 0x80, 0x80, 0x04	; 037FC53C
	.byte 0x00, 0x80, 0x00, 0x00, 0xD2, 0x03, 0x00, 0x00, 0x54, 0x80, 0x80, 0x04, 0x52, 0x80, 0x80, 0x04	; 037FC54C
	.byte 0x00, 0x40, 0x00, 0x00, 0x50, 0x80, 0x80, 0x04, 0x5A, 0x80, 0x80, 0x04, 0x56, 0x80, 0x80, 0x04	; 037FC55C
	.byte 0x01, 0x80, 0x00, 0x00, 0x30, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 037FC56C
	.byte 0x60, 0x4B, 0x80, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x60, 0x4B, 0x80, 0x03	; 037FC57C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x51, 0x4F, 0x30, 0x02	; 037FC58C
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x5C, 0x4A, 0x11, 0x68, 0x5C, 0x48, 0x0D, 0x18, 0x02, 0x21, 0x5C, 0x48	; 037FC59C
	.byte 0x01, 0x80, 0x10, 0x68, 0x5B, 0x4A, 0x82, 0x5A, 0x12, 0x2A, 0x02, 0xD1, 0x00, 0xF0, 0xD4, 0xF8	; 037FC5AC
	.byte 0xA5, 0xE0, 0x59, 0x4A, 0x14, 0x88, 0x59, 0x4A, 0x14, 0x40, 0x59, 0x4A, 0x94, 0x42, 0x06, 0xD0	; 037FC5BC
	.byte 0x58, 0x4A, 0x94, 0x42, 0x17, 0xD0, 0x58, 0x49, 0x8C, 0x42, 0x2F, 0xD0, 0x69, 0xE0, 0x28, 0x1C	; 037FC5CC
	.byte 0x8C, 0x30, 0x00, 0x68, 0x08, 0x40, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x51, 0xFB, 0x4A, 0x48	; 037FC5DC
	.byte 0x01, 0x68, 0x52, 0x48, 0x08, 0x18, 0x01, 0x68, 0x49, 0x1C, 0x01, 0x60, 0x00, 0x20, 0x08, 0x21	; 037FC5EC
	.byte 0xFE, 0xF7, 0xC8, 0xFE, 0x55, 0xE0, 0x28, 0x1C, 0x9E, 0x30, 0x00, 0x88, 0x6A, 0x6C, 0x93, 0x88	; 037FC5FC
	.byte 0xFF, 0x22, 0x13, 0x40, 0x1A, 0x04, 0x12, 0x0C, 0x90, 0x42, 0x08, 0xD8, 0x48, 0x48, 0x01, 0x80	; 037FC60C
	.byte 0x28, 0x1C, 0xAA, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x28, 0x1C, 0xAA, 0x30, 0x01, 0x80, 0x28, 0x1C	; 037FC61C
	.byte 0x90, 0x30, 0x01, 0x68, 0x08, 0x8B, 0x40, 0x1C, 0x08, 0x83, 0x3A, 0xE0, 0x29, 0x1C, 0x98, 0x31	; 037FC62C
	.byte 0x0E, 0x88, 0x69, 0x6C, 0x4B, 0x88, 0x29, 0x1C, 0x90, 0x31, 0x0A, 0x68, 0x1A, 0x32, 0x01, 0x2B	; 037FC63C
	.byte 0x0F, 0xD9, 0x3C, 0x49, 0x40, 0x5A, 0xC0, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x09, 0xD0, 0x3A, 0x48	; 037FC64C
	.byte 0x00, 0x88, 0x01, 0x27, 0x38, 0x40, 0x00, 0x28, 0x03, 0xD1, 0x38, 0x49, 0x08, 0x88, 0x78, 0x40	; 037FC65C
	.byte 0x08, 0x80, 0x29, 0x48, 0x01, 0x68, 0x36, 0x48, 0x09, 0x5A, 0x40, 0x20, 0x01, 0x40, 0x00, 0x29	; 037FC66C
	.byte 0x17, 0xD0, 0x01, 0x20, 0x13, 0xE0, 0xD9, 0x03, 0x0B, 0x0C, 0x19, 0x1C, 0x01, 0x40, 0x00, 0x29	; 037FC67C
	.byte 0x02, 0xD0, 0xD1, 0x88, 0x49, 0x1C, 0xD1, 0x80, 0xF1, 0x03, 0x0E, 0x0C, 0x31, 0x1C, 0x01, 0x40	; 037FC68C
	.byte 0x00, 0x29, 0x04, 0xD0, 0x29, 0x1C, 0x90, 0x31, 0x09, 0x68, 0xC9, 0x8A, 0x52, 0x18, 0x01, 0x2B	; 037FC69C
	.byte 0xE9, 0xD8, 0x20, 0x48, 0x84, 0x42, 0x26, 0xD0, 0x26, 0x48, 0x01, 0x88, 0x02, 0x20, 0x01, 0x40	; 037FC6AC
	.byte 0x00, 0x29, 0x20, 0xD1, 0xA9, 0x8F, 0x00, 0x29, 0x1A, 0xD0, 0x23, 0x49, 0x08, 0x80, 0x00, 0x22	; 037FC6BC
	.byte 0x22, 0x49, 0x0A, 0x80, 0x12, 0x49, 0x0A, 0x88, 0x21, 0x49, 0x0A, 0x40, 0x00, 0x2A, 0x02, 0xD1	; 037FC6CC
	.byte 0x00, 0xF0, 0x44, 0xF9, 0x06, 0xE0, 0x28, 0x1C, 0xAE, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x28, 0x1C	; 037FC6DC
	.byte 0xAE, 0x30, 0x01, 0x80, 0x28, 0x1C, 0xAC, 0x30, 0x00, 0x88, 0x40, 0x1C, 0xAC, 0x35, 0x28, 0x80	; 037FC6EC
	.byte 0x02, 0x21, 0x18, 0x48, 0x01, 0x80, 0x00, 0x20, 0x0E, 0x21, 0xFE, 0xF7, 0x43, 0xFE, 0x01, 0xB0	; 037FC6FC
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00	; 037FC70C
	.byte 0x10, 0x80, 0x80, 0x04, 0x20, 0x03, 0x00, 0x00, 0xB8, 0x80, 0x80, 0x04, 0x00, 0x0F, 0x00, 0x00	; 037FC71C
	.byte 0x00, 0x03, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x2C, 0x05, 0x00, 0x00	; 037FC72C
	.byte 0xAC, 0x80, 0x80, 0x04, 0x0E, 0x03, 0x00, 0x00, 0x9C, 0x81, 0x80, 0x04, 0x90, 0x82, 0x80, 0x04	; 037FC73C
	.byte 0x38, 0x06, 0x00, 0x00, 0xB0, 0x80, 0x80, 0x04, 0xB4, 0x80, 0x80, 0x04, 0x48, 0x80, 0x80, 0x04	; 037FC74C
	.byte 0x00, 0x10, 0x00, 0x00, 0xAE, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FC75C
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x45, 0x8C, 0x30, 0x02, 0xF0, 0xB5, 0x87, 0xB0, 0x65, 0x48, 0x01, 0x68	; 037FC76C
	.byte 0x65, 0x48, 0x0D, 0x18, 0x65, 0x48, 0x08, 0x18, 0x00, 0x90, 0x65, 0x48, 0x0E, 0x5A, 0x01, 0x21	; 037FC77C
	.byte 0x64, 0x48, 0x01, 0x80, 0x0E, 0x40, 0x00, 0x98, 0x80, 0x88, 0x02, 0x90, 0x62, 0x48, 0x00, 0x88	; 037FC78C
	.byte 0x03, 0x90, 0x02, 0x99, 0x81, 0x42, 0x00, 0xD1, 0x97, 0xE0, 0x60, 0x48, 0x01, 0x88, 0x60, 0x48	; 037FC79C
	.byte 0x00, 0x88, 0x5E, 0x4A, 0x13, 0x88, 0x5E, 0x4A, 0x12, 0x88, 0x99, 0x42, 0x03, 0xD9, 0x1C, 0x09	; 037FC7AC
	.byte 0x10, 0x03, 0x04, 0x43, 0x02, 0xE0, 0x0C, 0x09, 0x00, 0x03, 0x04, 0x43, 0x02, 0x98, 0x47, 0x00	; 037FC7BC
	.byte 0x58, 0x48, 0x38, 0x18, 0x01, 0x90, 0x80, 0x1C, 0x00, 0xF0, 0xB8, 0xFA, 0x04, 0x90, 0x80, 0x1C	; 037FC7CC
	.byte 0x00, 0xF0, 0xB4, 0xFA, 0x05, 0x90, 0x00, 0x1D, 0x00, 0xF0, 0xB0, 0xFA, 0x02, 0x1C, 0x51, 0x48	; 037FC7DC
	.byte 0x39, 0x5A, 0x04, 0x98, 0x00, 0x88, 0x43, 0x00, 0x4F, 0x48, 0x03, 0x40, 0x19, 0x43, 0x4D, 0x48	; 037FC7EC
	.byte 0x39, 0x52, 0x05, 0x98, 0x04, 0x80, 0x12, 0x88, 0x02, 0x98, 0x40, 0x00, 0x10, 0x18, 0x0F, 0x30	; 037FC7FC
	.byte 0x80, 0x08, 0x44, 0x00, 0x49, 0x48, 0x84, 0x42, 0x04, 0xD3, 0x28, 0x1C, 0x9A, 0x30, 0x00, 0x88	; 037FC80C
	.byte 0x40, 0x08, 0x24, 0x1A, 0x46, 0x48, 0x82, 0x42, 0x0B, 0xD9, 0x46, 0x49, 0x01, 0x98, 0x01, 0x80	; 037FC81C
	.byte 0x03, 0x9C, 0x28, 0x1C, 0xB4, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x28, 0x1C, 0xB4, 0x30, 0x01, 0x80	; 037FC82C
	.byte 0x33, 0xE0, 0x00, 0x2E, 0x31, 0xD0, 0x03, 0x98, 0x84, 0x42, 0x2E, 0xD0, 0x60, 0x00, 0x39, 0x49	; 037FC83C
	.byte 0x41, 0x18, 0x38, 0x4B, 0xC0, 0x5A, 0x3C, 0x4B, 0x99, 0x42, 0x05, 0xD2, 0xCB, 0x88, 0xFF, 0x21	; 037FC84C
	.byte 0x0B, 0x40, 0x19, 0x04, 0x0B, 0x0C, 0x04, 0xE0, 0x2B, 0x1C, 0x9A, 0x33, 0x1B, 0x88, 0xC9, 0x1A	; 037FC85C
	.byte 0xCB, 0x88, 0x36, 0x49, 0x08, 0x40, 0x00, 0x28, 0x06, 0xD1, 0x0A, 0x2B, 0x01, 0xD0, 0x14, 0x2B	; 037FC86C
	.byte 0x02, 0xD1, 0x33, 0x48, 0x82, 0x42, 0x10, 0xD9, 0x28, 0x1C, 0xB4, 0x30, 0x00, 0x88, 0x40, 0x1C	; 037FC87C
	.byte 0xB4, 0x35, 0x28, 0x80, 0x2B, 0x49, 0x01, 0x98, 0x01, 0x80, 0x03, 0x98, 0x00, 0x04, 0x01, 0x0C	; 037FC88C
	.byte 0x00, 0x98, 0x81, 0x80, 0x04, 0x98, 0x01, 0x80, 0x17, 0xE0, 0x01, 0x98, 0x01, 0x88, 0x0F, 0x20	; 037FC89C
	.byte 0x01, 0x40, 0x0C, 0x29, 0x0A, 0xD1, 0x00, 0xF0, 0x59, 0xFA, 0x00, 0x28, 0x06, 0xD1, 0x15, 0x48	; 037FC8AC
	.byte 0x00, 0x68, 0x24, 0x49, 0x41, 0x58, 0x4A, 0x1C, 0x22, 0x49, 0x42, 0x50, 0x20, 0x04, 0x01, 0x0C	; 037FC8BC
	.byte 0x00, 0x98, 0x81, 0x80, 0x04, 0x98, 0x01, 0x80, 0x5D, 0xE7, 0x00, 0x2E, 0x0C, 0xD0, 0x12, 0x48	; 037FC8CC
	.byte 0x04, 0x88, 0x00, 0xF0, 0x43, 0xFA, 0x00, 0x28, 0x06, 0xD0, 0x0F, 0x48, 0x00, 0x88, 0x84, 0x42	; 037FC8DC
	.byte 0x02, 0xD1, 0x20, 0x20, 0x00, 0xF0, 0x32, 0xF8, 0x17, 0x48, 0x01, 0x88, 0x0A, 0x48, 0x00, 0x88	; 037FC8EC
	.byte 0x81, 0x42, 0x03, 0xD0, 0x00, 0x20, 0x0F, 0x21, 0xFE, 0xF7, 0x44, 0xFD, 0x07, 0xB0, 0xF0, 0xBC	; 037FC8FC
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xB4, 0x04, 0x00, 0x00	; 037FC90C
	.byte 0x38, 0x06, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x54, 0x80, 0x80, 0x04, 0xF8, 0x80, 0x80, 0x04	; 037FC91C
	.byte 0xFA, 0x80, 0x80, 0x04, 0x00, 0x40, 0x80, 0x04, 0x00, 0x04, 0x00, 0x00, 0xB0, 0x0F, 0x00, 0x00	; 037FC92C
	.byte 0x2C, 0x09, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x5A, 0x5F, 0x80, 0x04, 0x00, 0x7C, 0x00, 0x00	; 037FC93C
	.byte 0xFF, 0x0F, 0x00, 0x00, 0x7C, 0x05, 0x00, 0x00, 0x5A, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46	; 037FC94C
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x19, 0x4F, 0x30, 0x02, 0x10, 0xB5, 0x22, 0x49	; 037FC95C
	.byte 0x0B, 0x68, 0x22, 0x4A, 0x9A, 0x18, 0x22, 0x4C, 0x22, 0x4B, 0x1C, 0x80, 0x93, 0x8F, 0x00, 0x2B	; 037FC96C
	.byte 0x36, 0xD0, 0x0B, 0x68, 0x20, 0x49, 0x5B, 0x5A, 0x10, 0x21, 0x0B, 0x40, 0x00, 0x2B, 0x2B, 0xD0	; 037FC97C
	.byte 0x00, 0x28, 0x29, 0xD0, 0x1D, 0x48, 0x01, 0x88, 0x1D, 0x48, 0x00, 0x88, 0x03, 0x28, 0x01, 0xD0	; 037FC98C
	.byte 0x05, 0x28, 0x21, 0xD1, 0x00, 0x29, 0x1F, 0xD1, 0x53, 0x6C, 0x5C, 0x88, 0x00, 0x20, 0x01, 0x21	; 037FC99C
	.byte 0x04, 0xE0, 0x22, 0x1C, 0x0A, 0x40, 0x80, 0x18, 0xE2, 0x03, 0x14, 0x0C, 0x00, 0x2C, 0xF8, 0xD1	; 037FC9AC
	.byte 0x59, 0x89, 0x8A, 0x00, 0x99, 0x8C, 0x0A, 0x31, 0x48, 0x43, 0xC0, 0x30, 0x10, 0x18, 0x00, 0x04	; 037FC9BC
	.byte 0x00, 0x0C, 0x10, 0x49, 0x00, 0xF0, 0x22, 0xF8, 0x07, 0x48, 0x01, 0x68, 0x0E, 0x48, 0x08, 0x18	; 037FC9CC
	.byte 0x01, 0x88, 0x49, 0x1C, 0x01, 0x80, 0x03, 0xE0, 0x00, 0x20, 0x10, 0x21, 0xFE, 0xF7, 0xD2, 0xFC	; 037FC9DC
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00	; 037FC9EC
	.byte 0x00, 0x10, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00, 0xB6, 0x80, 0x80, 0x04	; 037FC9FC
	.byte 0x14, 0x82, 0x80, 0x04, 0xED, 0xCC, 0x7F, 0x03, 0xD4, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 037FCA0C
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x71, 0x53, 0x30, 0x02, 0x10, 0xB5, 0x17, 0x4B	; 037FCA1C
	.byte 0x19, 0x68, 0x17, 0x48, 0x09, 0x18, 0x80, 0x20, 0x16, 0x4A, 0x10, 0x80, 0x1B, 0x68, 0x16, 0x4A	; 037FCA2C
	.byte 0x9B, 0x5A, 0x20, 0x22, 0x13, 0x40, 0x00, 0x2B, 0x1D, 0xD0, 0x14, 0x4A, 0x13, 0x88, 0xFF, 0x22	; 037FCA3C
	.byte 0x13, 0x40, 0x1A, 0x04, 0x13, 0x0C, 0x12, 0x4A, 0x14, 0x88, 0x03, 0x2B, 0x13, 0xD3, 0x05, 0x2B	; 037FCA4C
	.byte 0x11, 0xD8, 0x8A, 0x6D, 0x53, 0x08, 0x0F, 0x4A, 0x13, 0x40, 0x9C, 0x42, 0x0B, 0xD3, 0x09, 0x6B	; 037FCA5C
	.byte 0x49, 0x08, 0x11, 0x40, 0x8C, 0x42, 0x06, 0xD8, 0x0B, 0x4A, 0x11, 0x88, 0x01, 0x43, 0x11, 0x80	; 037FCA6C
	.byte 0x11, 0x88, 0x81, 0x43, 0x11, 0x80, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 037FCA7C
	.byte 0x00, 0x04, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00, 0x14, 0x82, 0x80, 0x04	; 037FCA8C
	.byte 0x68, 0x82, 0x80, 0x04, 0xFF, 0x0F, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04, 0xF0, 0xB5, 0x81, 0xB0	; 037FCA9C
	.byte 0x5E, 0x48, 0x02, 0x68, 0x5E, 0x49, 0x55, 0x18, 0x5E, 0x49, 0x56, 0x18, 0x40, 0x22, 0x5E, 0x49	; 037FCAAC
	.byte 0x0A, 0x80, 0x01, 0x68, 0x5D, 0x48, 0x09, 0x5A, 0x20, 0x20, 0x01, 0x40, 0x00, 0x29, 0x00, 0xD1	; 037FCABC
	.byte 0xA7, 0xE0, 0x30, 0x1C, 0xA6, 0x30, 0x01, 0x88, 0x59, 0x48, 0x81, 0x42, 0x00, 0xD0, 0xA0, 0xE0	; 037FCACC
	.byte 0x58, 0x48, 0x01, 0x88, 0x03, 0x20, 0x01, 0x40, 0x03, 0x29, 0x00, 0xD0, 0x99, 0xE0, 0x56, 0x48	; 037FCADC
	.byte 0x02, 0x88, 0x56, 0x48, 0x00, 0x88, 0x41, 0x08, 0x55, 0x48, 0x01, 0x40, 0x8A, 0x42, 0x00, 0xDA	; 037FCAEC
	.byte 0x8F, 0xE0, 0x54, 0x48, 0x00, 0x88, 0x00, 0x90, 0x41, 0x00, 0x53, 0x48, 0x08, 0x18, 0x08, 0x30	; 037FCAFC
	.byte 0x00, 0xF0, 0x1C, 0xF9, 0x00, 0x1D, 0x00, 0xF0, 0x19, 0xF9, 0x02, 0x88, 0x4F, 0x49, 0x0A, 0x40	; 037FCB0C
	.byte 0x4F, 0x49, 0x8A, 0x42, 0x7D, 0xD1, 0x80, 0x1C, 0x00, 0xF0, 0x10, 0xF9, 0x01, 0x1C, 0x4D, 0x4C	; 037FCB1C
	.byte 0x22, 0x88, 0x4D, 0x48, 0x17, 0x1A, 0x44, 0x48, 0x02, 0x88, 0x00, 0x98, 0x10, 0x1A, 0x00, 0x04	; 037FCB2C
	.byte 0x03, 0x0C, 0x1A, 0x1C, 0x49, 0x48, 0x02, 0x40, 0x00, 0x2A, 0x06, 0xD0, 0x28, 0x1C, 0x9A, 0x30	; 037FCB3C
	.byte 0x00, 0x88, 0x40, 0x08, 0x18, 0x18, 0x00, 0x04, 0x03, 0x0C, 0x0E, 0x2B, 0x06, 0xD8, 0x20, 0x88	; 037FCB4C
	.byte 0xC0, 0x1B, 0x00, 0x04, 0x00, 0x0C, 0x40, 0x28, 0xE5, 0xD9, 0x5A, 0xE0, 0x08, 0x31, 0x00, 0x24	; 037FCB5C
	.byte 0x0B, 0xE0, 0x08, 0x1C, 0x00, 0xF0, 0xEA, 0xF8, 0x81, 0x1C, 0x00, 0x88, 0x62, 0x00, 0xAA, 0x18	; 037FCB6C
	.byte 0x64, 0x32, 0x12, 0x88, 0x90, 0x42, 0x4C, 0xD1, 0x64, 0x1C, 0x03, 0x2C, 0xF1, 0xD3, 0x0A, 0x31	; 037FCB7C
	.byte 0x08, 0x1C, 0x00, 0xF0, 0xDB, 0xF8, 0x03, 0x1C, 0x2B, 0x4C, 0x21, 0x88, 0x00, 0x98, 0x08, 0x1A	; 037FCB8C
	.byte 0x00, 0x04, 0x02, 0x0C, 0x11, 0x1C, 0x31, 0x48, 0x01, 0x40, 0x00, 0x29, 0x06, 0xD0, 0x28, 0x1C	; 037FCB9C
	.byte 0x9A, 0x30, 0x00, 0x88, 0x40, 0x08, 0x10, 0x18, 0x00, 0x04, 0x02, 0x0C, 0x14, 0x2A, 0x07, 0xD8	; 037FCBAC
	.byte 0x28, 0x48, 0x00, 0x88, 0xC0, 0x1B, 0x00, 0x04, 0x00, 0x0C, 0x70, 0x28, 0xE5, 0xD9, 0x28, 0xE0	; 037FCBBC
	.byte 0x19, 0x88, 0x30, 0x1C, 0xA2, 0x30, 0x00, 0x88, 0x01, 0x40, 0x00, 0x29, 0x21, 0xD1, 0x24, 0x48	; 037FCBCC
	.byte 0x00, 0x88, 0xA6, 0x36, 0x30, 0x80, 0x40, 0x21, 0x22, 0x48, 0x01, 0x80, 0x28, 0x1C, 0xBE, 0x30	; 037FCBDC
	.byte 0x00, 0x88, 0x40, 0x1C, 0xBE, 0x35, 0x28, 0x80, 0x12, 0x49, 0x03, 0x20, 0x0A, 0x88, 0x02, 0x40	; 037FCBEC
	.byte 0x03, 0x2A, 0xFB, 0xD0, 0x1C, 0x4A, 0x11, 0x88, 0x40, 0x20, 0x01, 0x43, 0x11, 0x80, 0x11, 0x88	; 037FCBFC
	.byte 0x81, 0x43, 0x11, 0x80, 0x08, 0x20, 0x19, 0x49, 0x08, 0x80, 0x00, 0x20, 0x08, 0x80, 0x00, 0xF0	; 037FCC0C
	.byte 0x2F, 0xF8, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 037FCC1C
	.byte 0x18, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00	; 037FCC2C
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x9C, 0x81, 0x80, 0x04, 0x68, 0x82, 0x80, 0x04, 0x50, 0x80, 0x80, 0x04	; 037FCC3C
	.byte 0xFF, 0x0F, 0x00, 0x00, 0x54, 0x80, 0x80, 0x04, 0x00, 0x40, 0x80, 0x04, 0xFF, 0xE7, 0x00, 0x00	; 037FCC4C
	.byte 0x28, 0x02, 0x00, 0x00, 0xF8, 0x80, 0x80, 0x04, 0x00, 0x00, 0x01, 0x00, 0x00, 0x80, 0x00, 0x00	; 037FCC5C
	.byte 0x98, 0x80, 0x80, 0x04, 0xB4, 0x80, 0x80, 0x04, 0x44, 0x82, 0x80, 0x04, 0x28, 0x82, 0x80, 0x04	; 037FCC6C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xF5, 0x6D, 0x30, 0x02	; 037FCC7C
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x14, 0x48, 0x01, 0x68, 0x14, 0x48, 0x0D, 0x18, 0x00, 0x24, 0x01, 0x20	; 037FCC8C
	.byte 0x00, 0xF0, 0x26, 0xF8, 0x20, 0x00, 0x00, 0xF0, 0x23, 0xF8, 0xE8, 0x69, 0x00, 0x88, 0x00, 0x28	; 037FCC9C
	.byte 0x01, 0xD0, 0x01, 0x24, 0x01, 0xE0, 0x20, 0x00, 0xA8, 0x82, 0xA8, 0x68, 0x00, 0x88, 0x00, 0x28	; 037FCCAC
	.byte 0x01, 0xD0, 0x01, 0x24, 0x01, 0xE0, 0x00, 0x20, 0x28, 0x80, 0x00, 0x2C, 0x03, 0xD0, 0x00, 0x20	; 037FCCBC
	.byte 0x0E, 0x21, 0xFE, 0xF7, 0x5F, 0xFB, 0x00, 0x20, 0x14, 0x21, 0xFE, 0xF7, 0x5B, 0xFB, 0x01, 0xB0	; 037FCCCC
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00	; 037FCCDC
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x99, 0xA6, 0x30, 0x02	; 037FCCEC
	.byte 0x10, 0xB5, 0x0E, 0x48, 0x00, 0xF0, 0x96, 0xFE, 0x04, 0x1C, 0x0D, 0x4A, 0x13, 0x88, 0x0D, 0x49	; 037FCCFC
	.byte 0x0D, 0x48, 0x01, 0x80, 0x64, 0x21, 0x03, 0xE0, 0x10, 0x88, 0x83, 0x42, 0x02, 0xD1, 0x49, 0x1E	; 037FCD0C
	.byte 0x00, 0x29, 0xF9, 0xD1, 0x00, 0x20, 0x08, 0x49, 0x08, 0x80, 0xFF, 0xF7, 0x1F, 0xFE, 0x20, 0x1C	; 037FCD1C
	.byte 0x00, 0xF0, 0x96, 0xFE, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x00, 0x00, 0x00, 0x01	; 037FCD2C
	.byte 0x10, 0x82, 0x80, 0x04, 0x00, 0x10, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04, 0x04, 0x49, 0x88, 0x42	; 037FCD3C
	.byte 0x04, 0xD3, 0x04, 0x49, 0x0A, 0x68, 0x04, 0x49, 0x51, 0x5A, 0x40, 0x1A, 0x70, 0x47, 0xC0, 0x46	; 037FCD4C
	.byte 0x60, 0x5F, 0x80, 0x04, 0xF4, 0xFF, 0x80, 0x03, 0xB2, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x0C, 0x48	; 037FCD5C
	.byte 0x01, 0x68, 0x0C, 0x48, 0x0C, 0x18, 0x20, 0x1C, 0x50, 0x30, 0x00, 0xF0, 0x15, 0xF8, 0x00, 0x28	; 037FCD6C
	.byte 0x01, 0xD0, 0x01, 0x20, 0x08, 0xE0, 0x64, 0x34, 0x20, 0x1C, 0x00, 0xF0, 0x0D, 0xF8, 0x00, 0x28	; 037FCD7C
	.byte 0x01, 0xD0, 0x01, 0x20, 0x00, 0xE0, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCD8C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FCD9C
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xB1, 0x6D, 0x30, 0x02, 0x00, 0xB5, 0x81, 0xB0, 0x0A, 0x48, 0x01, 0x68	; 037FCDAC
	.byte 0x0A, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x14, 0xF8, 0x06, 0x48, 0x01, 0x68	; 037FCDBC
	.byte 0x07, 0x48, 0x08, 0x5A, 0x40, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x12, 0xF8	; 037FCDCC
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xBC, 0x03, 0x00, 0x00	; 037FCDDC
	.byte 0x0E, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FCDEC
	.byte 0xC5, 0x9F, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FCDFC
	.byte 0xC9, 0x79, 0x30, 0x02, 0xF0, 0xB5, 0x83, 0xB0, 0x4B, 0x48, 0x01, 0x68, 0x4B, 0x48, 0x0D, 0x18	; 037FCE0C
	.byte 0x4B, 0x48, 0x0F, 0x18, 0x02, 0x24, 0x01, 0x94, 0x00, 0x94, 0x21, 0x1C, 0x14, 0x20, 0x41, 0x43	; 037FCE1C
	.byte 0x7A, 0x18, 0xA0, 0x00, 0x47, 0x49, 0x43, 0x18, 0x41, 0x5A, 0x47, 0x48, 0x01, 0x40, 0x00, 0x29	; 037FCE2C
	.byte 0x79, 0xD1, 0x10, 0x88, 0x00, 0x28, 0x76, 0xD0, 0xD0, 0x68, 0x00, 0x28, 0x6B, 0xD0, 0x91, 0x68	; 037FCE3C
	.byte 0x09, 0x88, 0x01, 0x81, 0x90, 0x68, 0x81, 0x89, 0xD0, 0x68, 0x81, 0x82, 0x90, 0x68, 0x86, 0x89	; 037FCE4C
	.byte 0x3E, 0x49, 0x0E, 0x40, 0x00, 0x2E, 0x50, 0xD0, 0x37, 0x49, 0x0E, 0x68, 0x3C, 0x49, 0x76, 0x5A	; 037FCE5C
	.byte 0x08, 0x21, 0x0E, 0x40, 0x00, 0x2E, 0x40, 0xD0, 0x06, 0x1C, 0x0C, 0x36, 0x41, 0x89, 0x71, 0x18	; 037FCE6C
	.byte 0xC9, 0x1F, 0x01, 0x26, 0xB1, 0x43, 0x0E, 0x88, 0x00, 0x2E, 0x36, 0xD1, 0x49, 0x88, 0x00, 0x29	; 037FCE7C
	.byte 0x33, 0xD1, 0x28, 0x1C, 0xA8, 0x30, 0x00, 0x68, 0xD1, 0x68, 0x89, 0x88, 0x40, 0x1A, 0x00, 0x04	; 037FCE8C
	.byte 0x00, 0x0C, 0x00, 0x26, 0x2F, 0x49, 0x0E, 0x80, 0x2B, 0x4E, 0x0E, 0x80, 0x29, 0x1C, 0xBA, 0x31	; 037FCE9C
	.byte 0x09, 0x88, 0x49, 0x1C, 0x2E, 0x1C, 0xBA, 0x36, 0x31, 0x80, 0x29, 0x1C, 0x8C, 0x31, 0x09, 0x88	; 037FCEAC
	.byte 0x88, 0x42, 0x12, 0xD9, 0xD1, 0x68, 0x00, 0x98, 0x08, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80	; 037FCEBC
	.byte 0x38, 0x1C, 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x38, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0xD0, 0x68	; 037FCECC
	.byte 0x01, 0x21, 0x12, 0x69, 0x08, 0xF0, 0xBA, 0xF8, 0x25, 0xE0, 0xD1, 0x68, 0x00, 0x20, 0x88, 0x81	; 037FCEDC
	.byte 0x19, 0x88, 0x19, 0x48, 0x01, 0x43, 0x19, 0x80, 0x1D, 0xE0, 0xD3, 0x68, 0x99, 0x89, 0x86, 0x88	; 037FCEEC
	.byte 0xFF, 0x20, 0x06, 0x40, 0x88, 0x19, 0x98, 0x81, 0x04, 0xE0, 0x81, 0x88, 0xFF, 0x20, 0x01, 0x40	; 037FCEFC
	.byte 0xD0, 0x68, 0x81, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0xD0, 0x68, 0x01, 0x99, 0x12, 0x69	; 037FCF0C
	.byte 0x08, 0xF0, 0x9C, 0xF8, 0x07, 0xE0, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0x90, 0x68, 0x03, 0x21	; 037FCF1C
	.byte 0x12, 0x69, 0x08, 0xF0, 0x93, 0xF8, 0x64, 0x1E, 0x00, 0x2C, 0x00, 0xDB, 0x75, 0xE7, 0x03, 0xB0	; 037FCF2C
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 037FCF3C
	.byte 0x00, 0x04, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00	; 037FCF4C
	.byte 0x38, 0x06, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04, 0xF0, 0xB5, 0x89, 0xB0, 0x96, 0x48, 0x01, 0x68	; 037FCF5C
	.byte 0x96, 0x48, 0x0F, 0x18, 0x96, 0x48, 0x0E, 0x18, 0x00, 0x20, 0x00, 0x90, 0x03, 0x90, 0x07, 0x90	; 037FCF6C
	.byte 0x06, 0x90, 0x05, 0x90, 0x04, 0x90, 0x08, 0x90, 0x92, 0x48, 0x01, 0x88, 0xB8, 0x88, 0x81, 0x42	; 037FCF7C
	.byte 0x00, 0xD1, 0x15, 0xE1, 0x4C, 0x00, 0x90, 0x48, 0x25, 0x18, 0xA8, 0x1C, 0xFF, 0xF7, 0xD6, 0xFE	; 037FCF8C
	.byte 0x00, 0x88, 0x02, 0x90, 0x8C, 0x48, 0x21, 0x5A, 0x8C, 0x48, 0x81, 0x42, 0x03, 0xD1, 0x02, 0x99	; 037FCF9C
	.byte 0x88, 0x48, 0x01, 0x80, 0x00, 0xE1, 0x28, 0x1C, 0x08, 0x30, 0xFF, 0xF7, 0xC7, 0xFE, 0x01, 0x88	; 037FCFAC
	.byte 0x28, 0x1C, 0x00, 0xF0, 0xF5, 0xF9, 0x04, 0x1C, 0x02, 0x99, 0x82, 0x48, 0x01, 0x80, 0x00, 0x2C	; 037FCFBC
	.byte 0x0C, 0xD1, 0x29, 0x88, 0x0F, 0x20, 0x01, 0x40, 0x0C, 0x29, 0x03, 0xD1, 0x10, 0x20, 0xFF, 0xF7	; 037FCFCC
	.byte 0xBD, 0xFC, 0xE9, 0xE0, 0x08, 0x20, 0xFF, 0xF7, 0xB9, 0xFC, 0xE5, 0xE0, 0x76, 0x48, 0x01, 0x68	; 037FCFDC
	.byte 0x7B, 0x48, 0x09, 0x5A, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29, 0x06, 0xD0, 0xA1, 0x8A, 0x79, 0x48	; 037FCFEC
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x03, 0x98, 0x78, 0x80, 0x21, 0x89, 0x01, 0x20, 0x01, 0x90	; 037FCFFC
	.byte 0x0A, 0x1C, 0x75, 0x48, 0x02, 0x40, 0x00, 0x2A, 0x19, 0xD0, 0xA0, 0x8A, 0x40, 0x05, 0xC0, 0x0F	; 037FD00C
	.byte 0x01, 0x28, 0x05, 0xD0, 0x60, 0x8D, 0x00, 0x07, 0x00, 0x0F, 0x00, 0x28, 0x00, 0xD1, 0xA3, 0xE0	; 037FD01C
	.byte 0x04, 0x98, 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C, 0x6C, 0x31, 0x22, 0x1C, 0x10, 0x3A	; 037FD02C
	.byte 0xFE, 0xF7, 0x16, 0xFB, 0x02, 0x20, 0x09, 0x21, 0xFE, 0xF7, 0xA4, 0xF9, 0x94, 0xE0, 0x0F, 0x20	; 037FD03C
	.byte 0x01, 0x40, 0x0F, 0x29, 0x00, 0xD9, 0x8F, 0xE0, 0x48, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 037FD04C
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x57, 0x00, 0x49, 0x00, 0x13, 0x01, 0x13, 0x01, 0x13, 0x01	; 037FD05C
	.byte 0x7F, 0x00, 0x13, 0x01, 0x13, 0x01, 0x21, 0x00, 0x13, 0x01, 0x13, 0x01, 0x13, 0x01, 0xBB, 0x00	; 037FD06C
	.byte 0xF1, 0x00, 0xA7, 0x00, 0xA7, 0x00, 0xA1, 0x8A, 0x0F, 0x20, 0x01, 0x40, 0x08, 0x29, 0x73, 0xD1	; 037FD07C
	.byte 0x05, 0x98, 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C, 0x48, 0x31, 0x22, 0x1C, 0x10, 0x3A	; 037FD08C
	.byte 0xFE, 0xF7, 0xE6, 0xFA, 0x02, 0x20, 0x06, 0x21, 0xFE, 0xF7, 0x74, 0xF9, 0x64, 0xE0, 0xA0, 0x8A	; 037FD09C
	.byte 0x80, 0x28, 0x61, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0xAF, 0xF8, 0x5D, 0xE0, 0xA1, 0x8A, 0x0F, 0x20	; 037FD0AC
	.byte 0x01, 0x40, 0x00, 0x29, 0x58, 0xD1, 0x06, 0x98, 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C	; 037FD0BC
	.byte 0x60, 0x31, 0x22, 0x1C, 0x10, 0x3A, 0xFE, 0xF7, 0xCB, 0xFA, 0x01, 0x20, 0x07, 0x21, 0xFE, 0xF7	; 037FD0CC
	.byte 0x59, 0xF9, 0x49, 0xE0, 0xA1, 0x8A, 0x41, 0x48, 0x01, 0x40, 0xA4, 0x29, 0x44, 0xD1, 0x07, 0x98	; 037FD0DC
	.byte 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C, 0x60, 0x31, 0x22, 0x1C, 0x10, 0x3A, 0xFE, 0xF7	; 037FD0EC
	.byte 0xB7, 0xFA, 0x01, 0x20, 0x07, 0x21, 0xFE, 0xF7, 0x45, 0xF9, 0x35, 0xE0, 0xA0, 0x8A, 0x38, 0x49	; 037FD0FC
	.byte 0x08, 0x40, 0x38, 0x49, 0x88, 0x42, 0x2F, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0x85, 0xF8, 0x2B, 0xE0	; 037FD10C
	.byte 0xA0, 0x8A, 0x32, 0x49, 0x08, 0x40, 0x34, 0x49, 0x88, 0x42, 0x25, 0xD1, 0x26, 0x48, 0x01, 0x68	; 037FD11C
	.byte 0x32, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x02, 0xD1, 0x01, 0x21, 0x31, 0x48, 0x01, 0x80, 0x22, 0x48	; 037FD12C
	.byte 0x02, 0x68, 0x30, 0x48, 0x10, 0x58, 0x41, 0x1C, 0x2E, 0x48, 0x11, 0x50, 0x20, 0x1C, 0x00, 0xF0	; 037FD13C
	.byte 0x73, 0xF8, 0x01, 0x90, 0x10, 0xE0, 0xA0, 0x8A, 0x24, 0x49, 0x08, 0x40, 0x2A, 0x49, 0x88, 0x42	; 037FD14C
	.byte 0x0A, 0xD1, 0x19, 0x48, 0x02, 0x68, 0x29, 0x48, 0x10, 0x58, 0x41, 0x1C, 0x27, 0x48, 0x11, 0x50	; 037FD15C
	.byte 0x20, 0x1C, 0x00, 0xF0, 0x69, 0xF8, 0x01, 0x90, 0x01, 0x98, 0x00, 0x28, 0x05, 0xD0, 0x30, 0x1C	; 037FD16C
	.byte 0x0C, 0x30, 0x10, 0x3C, 0x21, 0x1C, 0xFE, 0xF7, 0x47, 0xFA, 0x0F, 0x48, 0x01, 0x68, 0x14, 0x48	; 037FD17C
	.byte 0x09, 0x5A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x0E, 0xD0, 0x08, 0x98, 0x1C, 0x49, 0x8D, 0x42	; 037FD18C
	.byte 0x04, 0xD3, 0x09, 0x49, 0x0A, 0x68, 0x1B, 0x49, 0x51, 0x5A, 0x6D, 0x1A, 0x0B, 0x49, 0x29, 0x80	; 037FD19C
	.byte 0xAD, 0x1C, 0x40, 0x1C, 0x07, 0x28, 0xF1, 0xD3, 0x00, 0x98, 0x40, 0x1C, 0x00, 0x90, 0xE3, 0xE6	; 037FD1AC
	.byte 0x09, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xB4, 0x04, 0x00, 0x00	; 037FD1BC
	.byte 0x50, 0x01, 0x00, 0x00, 0x5A, 0x80, 0x80, 0x04, 0x00, 0x40, 0x80, 0x04, 0xFF, 0xFF, 0x00, 0x00	; 037FD1CC
	.byte 0x38, 0x06, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0xFF, 0xE7, 0x00, 0x00	; 037FD1DC
	.byte 0xBF, 0xE7, 0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x28, 0x02, 0x00, 0x00, 0x28, 0x03, 0x00, 0x00	; 037FD1EC
	.byte 0x3C, 0x80, 0x80, 0x04, 0x80, 0x05, 0x00, 0x00, 0x18, 0x02, 0x00, 0x00, 0x84, 0x05, 0x00, 0x00	; 037FD1FC
	.byte 0x60, 0x5F, 0x80, 0x04, 0xB2, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD20C
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xC5, 0xC6, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD21C
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xC9, 0xCC, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD22C
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x01, 0xCE, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD23C
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x21, 0xCC, 0x30, 0x02, 0x10, 0xB5, 0x28, 0x48, 0x01, 0x68, 0x28, 0x48	; 037FD24C
	.byte 0x0C, 0x18, 0xA0, 0x8F, 0x00, 0x28, 0x46, 0xD0, 0x20, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x01, 0x8A	; 037FD25C
	.byte 0x60, 0x6C, 0x40, 0x88, 0x81, 0x42, 0x01, 0xD0, 0xFF, 0xF7, 0x76, 0xFE, 0x60, 0x6C, 0x80, 0x88	; 037FD26C
	.byte 0xFF, 0x21, 0x08, 0x40, 0x00, 0x28, 0x07, 0xD0, 0x1C, 0x49, 0x0A, 0x68, 0x1D, 0x49, 0x51, 0x18	; 037FD27C
	.byte 0x0A, 0x68, 0x10, 0x18, 0x08, 0x60, 0x06, 0xE0, 0x18, 0x48, 0x01, 0x68, 0x19, 0x48, 0x08, 0x18	; 037FD28C
	.byte 0x01, 0x68, 0x49, 0x1C, 0x01, 0x60, 0x20, 0x1C, 0x40, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x20, 0x1C	; 037FD29C
	.byte 0x40, 0x30, 0x01, 0x80, 0x20, 0x1C, 0x90, 0x30, 0x02, 0x68, 0x11, 0x8A, 0x60, 0x6C, 0x40, 0x88	; 037FD2AC
	.byte 0x41, 0x40, 0x51, 0x82, 0x20, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x01, 0x8A, 0x20, 0x1C, 0xA0, 0x30	; 037FD2BC
	.byte 0x01, 0x80, 0x00, 0x20, 0xA0, 0x87, 0x09, 0x48, 0x01, 0x68, 0x0B, 0x48, 0x08, 0x5A, 0x00, 0x28	; 037FD2CC
	.byte 0x01, 0xD0, 0xFE, 0xF7, 0x2D, 0xFD, 0x05, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x18, 0x90, 0x34	; 037FD2DC
	.byte 0x21, 0x68, 0xFE, 0xF7, 0x1D, 0xFB, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 037FD2EC
	.byte 0x00, 0x04, 0x00, 0x00, 0x74, 0x05, 0x00, 0x00, 0xBE, 0x03, 0x00, 0x00, 0x5C, 0x01, 0x00, 0x00	; 037FD2FC
	.byte 0x10, 0xB5, 0x19, 0x48, 0x00, 0x68, 0x19, 0x49, 0x44, 0x18, 0x19, 0x49, 0x09, 0x88, 0x00, 0x29	; 037FD30C
	.byte 0x08, 0xD1, 0x21, 0x8F, 0x00, 0x29, 0x05, 0xD0, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FD31C
	.byte 0x2F, 0xF8, 0x1D, 0xE0, 0x14, 0x49, 0x42, 0x5A, 0x14, 0x49, 0x40, 0x5A, 0x82, 0x43, 0x00, 0x2A	; 037FD32C
	.byte 0x07, 0xD1, 0x08, 0x21, 0x0F, 0x48, 0x01, 0x80, 0x20, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0	; 037FD33C
	.byte 0x1F, 0xF8, 0x05, 0x21, 0x0B, 0x48, 0x01, 0x80, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 037FD34C
	.byte 0x00, 0xF0, 0x1E, 0xF8, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0x18, 0xF8	; 037FD35C
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00	; 037FD36C
	.byte 0x88, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 037FD37C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x75, 0xAE, 0x30, 0x02	; 037FD38C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x01, 0xAF, 0x30, 0x02	; 037FD39C
	.byte 0x70, 0xB5, 0x06, 0x1C, 0x0D, 0x1C, 0x12, 0x48, 0x01, 0x68, 0x12, 0x48, 0x08, 0x18, 0x29, 0x1C	; 037FD3AC
	.byte 0x22, 0x31, 0xFE, 0xF7, 0xF3, 0xF8, 0x00, 0x28, 0x01, 0xD1, 0x00, 0x20, 0x14, 0xE0, 0x04, 0x1C	; 037FD3BC
	.byte 0x10, 0x34, 0x20, 0x1C, 0x08, 0x30, 0x31, 0x1C, 0x2A, 0x1C, 0x0C, 0x32, 0x00, 0xF0, 0x14, 0xF8	; 037FD3CC
	.byte 0x18, 0x3D, 0xE5, 0x80, 0xE2, 0x89, 0xFF, 0x20, 0x02, 0x40, 0x61, 0x8A, 0x01, 0x40, 0x08, 0x04	; 037FD3DC
	.byte 0x00, 0x0A, 0x02, 0x43, 0xE2, 0x81, 0x20, 0x1C, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FD3EC
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD3FC
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xB5, 0x52, 0x30, 0x02	; 037FD404
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
	add r0,pc	; 037FD44E
	ldrh r0,[r0,#0x8]	; 037FD450
	lsl r0,r0,#0x10	; 037FD452
	asr r0,r0,#0x10	; 037FD454
	add r0,pc	; 037FD456
	bx r0	; 037FD458
	.byte 0x09, 0x00, 0x4D, 0x00, 0xAF, 0x00, 0x0B, 0x01	; 037FD462
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
	.word 0x0380FFF4	; 037FD5C4
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
	.word 0x04804024	; 037FD5F4
pool_037FD5F8:
loc_037FD5F8:
	.word 0x00001D46	; 037FD5F8
pool_037FD5FC:
loc_037FD5FC:
	.word 0x04804026	; 037FD5FC
pool_037FD600:
loc_037FD600:
	.word 0x0480416C	; 037FD600
pool_037FD604:
loc_037FD604:
	.word 0x0480416E	; 037FD604
pool_037FD608:
loc_037FD608:
	.word 0x04804790	; 037FD608
pool_037FD60C:
loc_037FD60C:
	.word 0x04804792	; 037FD60C
pool_037FD610:
loc_037FD610:
	.word 0x048080AE	; 037FD610
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
	.word 0x04804234	; 037FD628
pool_037FD62C:
loc_037FD62C:
	.word 0x04804236	; 037FD62C
pool_037FD630:
loc_037FD630:
	.word 0x04804330	; 037FD630
pool_037FD634:
loc_037FD634:
	.word 0x04804332	; 037FD634
pool_037FD638:
loc_037FD638:
	.word 0x04804954	; 037FD638
pool_037FD63C:
loc_037FD63C:
	.word 0x04804956	; 037FD63C
pool_037FD640:
loc_037FD640:
	.word 0x04804A9C	; 037FD640
pool_037FD644:
loc_037FD644:
	.word 0x04804A9E	; 037FD644
pool_037FD648:
loc_037FD648:
	.word 0x048050C0	; 037FD648
pool_037FD64C:
loc_037FD64C:
	.word 0x048050C2	; 037FD64C
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
	.word 0x04804230	; 037FD660
pool_037FD664:
loc_037FD664:
	.word 0x04804232	; 037FD664
pool_037FD668:
loc_037FD668:
	.word 0x04804464	; 037FD668
pool_037FD66C:
loc_037FD66C:
	.word 0x04804466	; 037FD66C
pool_037FD670:
loc_037FD670:
	.word 0x0480448C	; 037FD670
pool_037FD674:
loc_037FD674:
	.word 0x0480448E	; 037FD674
pool_037FD678:
loc_037FD678:
	.word 0x048045D4	; 037FD678
pool_037FD67C:
loc_037FD67C:
	.word 0x048045D6	; 037FD67C
pool_037FD680:
loc_037FD680:
	.word 0x04804BF8	; 037FD680
pool_037FD684:
loc_037FD684:
	.word 0x04804BFA	; 037FD684
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
	.word 0x037FF30C	; 037FD698
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
	.word 0x0230A0A9	; 037FD6A8
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
	add r0,pc	; 037FD6DE
	ldrh r0,[r0,#0x8]	; 037FD6E0
	lsl r0,r0,#0x10	; 037FD6E2
	asr r0,r0,#0x10	; 037FD6E4
	add r0,pc	; 037FD6E6
	bx r0	; 037FD6E8
	.byte 0x09, 0x00, 0x0D, 0x00, 0x11, 0x00, 0x15, 0x00	; 037FD6F2
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
	.word 0x0380FFF4	; 037FD73C
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
	.word 0x04808030	; 037FD74C
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
	.word 0x04808050	; 037FD764
pool_037FD768:
loc_037FD768:
	.word 0x04808056	; 037FD768
pool_037FD76C:
loc_037FD76C:
	.word 0x00005F60	; 037FD76C
pool_037FD770:
loc_037FD770:
	.word 0x04808052	; 037FD770
pool_037FD774:
loc_037FD774:
	.word 0x0480805A	; 037FD774
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
	.word 0x04808062	; 037FD784
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
	.word 0x037FF30C	; 037FD794

; ===== function loc_037FD798 =====
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
pool_037FD7E4:
loc_037FD7E4:
	.word 0x03805230	; 037FD7E4
pool_037FD7E8:
loc_037FD7E8:
	.word 0x037FD7EC	; 037FD7E8
	.byte 0x0C, 0xC1, 0x9F, 0xE5, 0xB0, 0x30, 0xDC, 0xE1, 0x00, 0x00, 0xA0, 0xE3, 0x00, 0x00, 0x53, 0xE3	; 037FD7FC
	.byte 0x0C, 0x00, 0x00, 0x0A, 0xB0, 0x00, 0xCC, 0xE1, 0xF8, 0xC0, 0x9F, 0xE5, 0x01, 0x10, 0xA0, 0xE3	; 037FD80C
	.byte 0xB0, 0x10, 0xCC, 0xE1, 0x0C, 0xC0, 0x9C, 0xE5, 0x01, 0x20, 0xA0, 0xE3, 0x00, 0x00, 0x5C, 0xE3	; 037FD81C
	.byte 0x04, 0x00, 0x00, 0x0A, 0x50, 0x00, 0x9C, 0xE5, 0x11, 0x00, 0x13, 0xE1, 0x48, 0x20, 0x8C, 0x15	; 037FD82C
	.byte 0x4C, 0xC0, 0x9C, 0xE5, 0xF8, 0xFF, 0xFF, 0xEA, 0xC8, 0xC0, 0x9F, 0xE5, 0xB0, 0x10, 0xDC, 0xE1	; 037FD83C
	.byte 0x00, 0x00, 0x51, 0xE3, 0x04, 0xF0, 0x9D, 0x04, 0x00, 0x10, 0xA0, 0xE3, 0xB0, 0x10, 0xCC, 0xE1	; 037FD84C
	.byte 0xD2, 0x30, 0xA0, 0xE3, 0x03, 0xF0, 0x21, 0xE1, 0x0C, 0x20, 0x8C, 0xE2, 0x00, 0x10, 0x92, 0xE5	; 037FD85C
	.byte 0x00, 0x00, 0x51, 0xE3, 0xB8, 0x04, 0xD1, 0x11, 0x01, 0x00, 0x50, 0x13, 0x4C, 0x10, 0x91, 0x15	; 037FD86C
	.byte 0xFA, 0xFF, 0xFF, 0x1A, 0x00, 0x00, 0x51, 0xE3, 0x02, 0x00, 0x00, 0x1A, 0x92, 0x30, 0xA0, 0xE3	; 037FD87C
	.byte 0x03, 0xF0, 0x21, 0xE1, 0x04, 0xF0, 0x9D, 0xE4, 0x08, 0x00, 0x9C, 0xE5, 0x00, 0x00, 0x51, 0xE1	; 037FD88C
	.byte 0xF9, 0xFF, 0xFF, 0x0A, 0x10, 0x30, 0x9C, 0xE5, 0x00, 0x00, 0x53, 0xE3, 0x03, 0x00, 0x00, 0x0A	; 037FD89C
	.byte 0x03, 0x10, 0x2D, 0xE9, 0x0F, 0xE0, 0xA0, 0xE1, 0x13, 0xFF, 0x2F, 0xE1, 0x03, 0x10, 0xBD, 0xE8	; 037FD8AC
	.byte 0x08, 0x10, 0x8C, 0xE5, 0x00, 0x20, 0x4F, 0xE1, 0x00, 0x20, 0xA0, 0xE5, 0x0C, 0x00, 0xBD, 0xE9	; 037FD8BC
	.byte 0x0C, 0x00, 0xA0, 0xE9, 0x0C, 0x50, 0xBD, 0xE9, 0xFC, 0x7F, 0xE0, 0xE9, 0x00, 0x40, 0xA0, 0xE9	; 037FD8CC
	.byte 0xD3, 0x30, 0xA0, 0xE3, 0x03, 0xF0, 0x21, 0xE1, 0x00, 0x20, 0xA0, 0xE9, 0x44, 0xD0, 0x91, 0xE5	; 037FD8DC
	.byte 0xD2, 0x30, 0xA0, 0xE3, 0x03, 0xF0, 0x21, 0xE1, 0x00, 0x20, 0xB1, 0xE5, 0x02, 0xF0, 0x69, 0xE1	; 037FD8EC
	.byte 0x40, 0xE0, 0x91, 0xE5, 0xFF, 0x7F, 0xF1, 0xE9, 0x00, 0x00, 0xA0, 0xE1, 0x0F, 0x50, 0x2D, 0xE8	; 037FD8FC
	.byte 0x00, 0x80, 0xBD, 0xE8, 0x1C, 0x58, 0x80, 0x03, 0x9C, 0x58, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0	; 037FD90C
	.byte 0x08, 0x48, 0x02, 0x6E, 0x08, 0x49, 0x08, 0x68, 0x40, 0x1C, 0x08, 0x60, 0x00, 0x2A, 0x01, 0xD0	; 037FD91C
	.byte 0x07, 0xF0, 0x94, 0xFB, 0x05, 0x4A, 0x11, 0x68, 0x01, 0x20, 0x01, 0x43, 0x11, 0x60, 0x01, 0xB0	; 037FD92C
	.byte 0x08, 0xBC, 0x18, 0x47, 0x20, 0x58, 0x80, 0x03, 0x3C, 0xFC, 0x7F, 0x02, 0xF8, 0xFF, 0x80, 0x03	; 037FD93C
.thumb
	mov r0,#0x7	; 037FD93C
	ldr r3,[pool_037FD944]	; 037FD93E
	bx r3	; 037FD940
	.byte 0xC0, 0x46	; 037FD944
pool_037FD944:
loc_037FD944:
	.word 0x037FD99D	; 037FD944
	mov r0,#0x6	; 037FD948
	ldr r3,[pool_037FD950]	; 037FD94A
	bx r3	; 037FD94C
	.byte 0xC0, 0x46	; 037FD950
pool_037FD950:
loc_037FD950:
	.word 0x037FD99D	; 037FD950
	mov r0,#0x5	; 037FD954
	ldr r3,[pool_037FD95C]	; 037FD956
	bx r3	; 037FD958
	.byte 0xC0, 0x46	; 037FD95C
pool_037FD95C:
loc_037FD95C:
	.word 0x037FD99D	; 037FD95C
	mov r0,#0x4	; 037FD960
	ldr r3,[pool_037FD968]	; 037FD962
	bx r3	; 037FD964
	.byte 0xC0, 0x46	; 037FD968
pool_037FD968:
loc_037FD968:
	.word 0x037FD99D	; 037FD968
	mov r0,#0x3	; 037FD96C
	ldr r3,[pool_037FD974]	; 037FD96E
	bx r3	; 037FD970
	.byte 0xC0, 0x46	; 037FD974
pool_037FD974:
loc_037FD974:
	.word 0x037FD99D	; 037FD974
	mov r0,#0x2	; 037FD978
	ldr r3,[pool_037FD980]	; 037FD97A
	bx r3	; 037FD97C
	.byte 0xC0, 0x46	; 037FD980
pool_037FD980:
loc_037FD980:
	.word 0x037FD99D	; 037FD980
	mov r0,#0x1	; 037FD984
	ldr r3,[pool_037FD98C]	; 037FD986
	bx r3	; 037FD988
	.byte 0xC0, 0x46	; 037FD98C
pool_037FD98C:
loc_037FD98C:
	.word 0x037FD99D	; 037FD98C
	mov r0,#0x0	; 037FD990
	ldr r3,[pool_037FD998]	; 037FD992
	bx r3	; 037FD994
	.byte 0xC0, 0x46	; 037FD998
pool_037FD998:
loc_037FD998:
	.word 0x037FD99D	; 037FD998
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
	.word 0x0380521C	; 037FD9E4
pool_037FD9E8:
loc_037FD9E8:
	.word 0x03805820	; 037FD9E8
pool_037FD9EC:
loc_037FD9EC:
	.word 0x03805828	; 037FD9EC
pool_037FD9F0:
loc_037FD9F0:
	.word 0x0380FFF8	; 037FD9F0
pool_037FD9F4:
loc_037FD9F4:
	.word 0x03805824	; 037FD9F4
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
	.word 0x04000208	; 037FDA18
pool_037FDA1C:
loc_037FDA1C:
	.word 0x04000214	; 037FDA1C

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
	.word 0x04000208	; 037FDA44
pool_037FDA48:
loc_037FDA48:
	.word 0x04000210	; 037FDA48

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
	.word 0x04000208	; 037FDA70
pool_037FDA74:
loc_037FDA74:
	.word 0x04000210	; 037FDA74

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
	.word 0x04000208	; 037FDA94
pool_037FDA98:
loc_037FDA98:
	.word 0x04000210	; 037FDA98

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
	.word 0x03805850	; 037FDAC4
pool_037FDAC8:
loc_037FDAC8:
	.word 0x03805858	; 037FDAC8
pool_037FDACC:
loc_037FDACC:
	.word 0x03805854	; 037FDACC

; ===== function loc_037FDAD0 =====
loc_037FDAD0:
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
	.byte 0xC0, 0x46	; 037FDB3C
pool_037FDB3C:
loc_037FDB3C:
	.word 0x03805820	; 037FDB3C
pool_037FDB40:
loc_037FDB40:
	.word 0x03805880	; 037FDB40
pool_037FDB44:
loc_037FDB44:
	.word 0x03805230	; 037FDB44

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
	.word 0x0380581C	; 037FDB54
pool_037FDB58:
loc_037FDB58:
	.word 0x027FFC3C	; 037FDB58

; ===== function loc_037FDB5C =====
loc_037FDB5C:
	ldr r1,[pool_037FDB60]	; 037FDB5C
	bx r1	; 037FDB5E
pool_037FDB60:
loc_037FDB60:
	.word 0x037FDC15	; 037FDB60
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
	.word 0x027FFFB8	; 037FDBF4
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
	.word 0x037FF185	; 037FDC08
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
	.word 0x037FDCDD	; 037FDC24

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
	.word 0x037FDD41	; 037FDC38

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
	.word 0x037FF0EC	; 037FDC98
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
	.word 0x037FF0C0	; 037FDCA4
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
	.word 0x037FF3B8	; 037FDCB0
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
	.word 0x037FF100	; 037FDCBC
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
	.word 0x037FF0D4	; 037FDCC8
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
	.word 0x0380588C	; 037FDDB4
pool_037FDDB8:
loc_037FDDB8:
	.word 0x027FFFF0	; 037FDDB8
pool_037FDDBC:
loc_037FDDBC:
	.word 0x027FFFB8	; 037FDDBC
pool_037FDDC0:
loc_037FDDC0:
	.word 0xFFFF0000	; 037FDDC0
pool_037FDDC4:
loc_037FDDC4:
	.word 0x027FFFBC	; 037FDDC4
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
	.word 0x0380589C	; 037FDDEC

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
	.word 0x0380589C	; 037FDE54
pool_037FDE58:
loc_037FDE58:
	.word 0x03805894	; 037FDE58
pool_037FDE5C:
loc_037FDE5C:
	.word 0x03805890	; 037FDE5C

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
	.word 0x037FF118	; 037FDE68
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
	.word 0x037FE1E4	; 037FDE74
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
	.word 0x037FE218	; 037FDE80
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
	.word 0x0380589C	; 037FDE98

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
	.word 0x0380589C	; 037FDF04

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
	.word 0x03805894	; 037FDF44
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
pool_037FDF80:
loc_037FDF80:
	.word 0x03805894	; 037FDF80
pool_037FDF84:
loc_037FDF84:
	.word 0x038058B0	; 037FDF84

; ===== function loc_037FDF88 =====
loc_037FDF88:
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
	str r7,[r5,#0x4]	; 037FDFE4
	ldr r0,[pool_037FE01C]	; 037FDFE6
	str r0,[r5,#0x3c]	; 037FDFE8
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
pool_037FE010:
loc_037FE010:
	.word 0x038058B0	; 037FE010
pool_037FE014:
loc_037FE014:
	.word 0xD73BFDF7	; 037FE014
pool_037FE018:
loc_037FE018:
	.word 0xFBDD37BB	; 037FE018
pool_037FE01C:
loc_037FE01C:
	.word 0x037FDF49	; 037FE01C

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
	.word 0x037FE180	; 037FE028
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
	.word 0x037FF30C	; 037FE034
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
	.word 0x03805898	; 037FE0C4
pool_037FE0C8:
loc_037FE0C8:
	.word 0x0380589C	; 037FE0C8
pool_037FE0CC:
loc_037FE0CC:
	.word 0x038058A4	; 037FE0CC
pool_037FE0D0:
loc_037FE0D0:
	.word 0x03805894	; 037FE0D0
pool_037FE0D4:
loc_037FE0D4:
	.word 0x038058F0	; 037FE0D4
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
	.word 0x03805930	; 037FE0F0
pool_037FE0F4:
loc_037FE0F4:
	.word 0x027FFFA4	; 037FE0F4

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
	.word 0x0380589C	; 037FE120

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
	.word 0x0380589C	; 037FE15C

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
	add r1,r1,#0x4	; 037FE180
	str r1,[r0,#0x40]	; 037FE184
	str r2,[r0,#0x44]	; 037FE188
	sub r2,r2,#0x40	; 037FE18C
	str r2,[r0,#0x38]	; 037FE190
	ands r1,r1,#0x1	; 037FE194
	movne r1,#0x3f	; 037FE198
	moveq r1,#0x1f	; 037FE19C
	str r1,[r0,#0x0]	; 037FE1A0
	mov r1,#0x0	; 037FE1A4
	str r1,[r0,#0x4]	; 037FE1A8
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
	str r1,[r0,#0x3c]	; 037FE1DC
	bx lr	; 037FE1E0

; ===== function loc_037FE1E4 =====
loc_037FE1E4:
	add r1,r0,#0x0	; 037FE1E4
	mrs r2,cpsr	; 037FE1E8
	str r2,[r1],#0x4	; 037FE1EC
	mov r0,#0xd3	; 037FE1F0
	msr cpsr_c,r0	; 037FE1F4
	str sp,[r1,#0x40]	; 037FE1F8
	msr cpsr_c,r2	; 037FE1FC
	mov r0,#0x1	; 037FE200
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FE204
	adr r0,loc_037FE218	; 037FE208
	str r0,[r1,#0x3c]	; 037FE20C
	mov r0,#0x0	; 037FE210
	bx lr	; 037FE214

; ===== function loc_037FE218 =====
loc_037FE218:
	mrs r1,cpsr	; 037FE218
	bic r1,r1,#0x1f	; 037FE21C
	orr r1,r1,#0xd3	; 037FE220
	msr cpsr_c,r1	; 037FE224
	ldr r1,[r0],#0x4	; 037FE228
	msr spsr_cxsf,r1	; 037FE22C
	ldr sp,[r0,#0x40]	; 037FE230
	ldr lr,[r0,#0x3c]	; 037FE234
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FE238
	mov r0,r0	; 037FE23C
	subs pc,lr,#0x4	; 037FE240
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
	.word 0x03804B60	; 037FE2B8
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
	.byte 0x0A, 0x69, 0xC9, 0x68, 0x00, 0x2A, 0x01, 0xD1, 0x41, 0x66, 0x00, 0xE0, 0xD1, 0x60, 0x00, 0x29	; 037FE350
	.byte 0x01, 0xD1, 0x02, 0x66, 0x70, 0x47, 0x0A, 0x61, 0x70, 0x47, 0x00, 0x00, 0x43, 0x6E, 0x00, 0x2B	; 037FE360
	.byte 0x01, 0xD1, 0x01, 0x66, 0x01, 0xE0, 0x02, 0x6E, 0x11, 0x61, 0xCB, 0x60, 0x00, 0x22, 0x0A, 0x61	; 037FE370
	.byte 0x41, 0x66, 0x70, 0x47	; 037FE374

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
	.byte 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFF, 0xF7, 0x7B, 0xFC, 0x04, 0x1C, 0x0C, 0x48	; 037FE3AA
	.byte 0x80, 0x68, 0x69, 0x68, 0x81, 0x42, 0x0D, 0xD1, 0xA9, 0x68, 0x49, 0x1E, 0xA9, 0x60, 0xA9, 0x68	; 037FE3BA
	.byte 0x00, 0x29, 0x07, 0xD1, 0x29, 0x1C, 0xFF, 0xF7, 0xBE, 0xFF, 0x00, 0x20, 0x68, 0x60, 0x28, 0x1C	; 037FE3CA
	.byte 0xFF, 0xF7, 0x79, 0xFD, 0x20, 0x1C, 0xFF, 0xF7, 0x76, 0xFC, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 037FE3DA
	.byte 0x18, 0x47, 0x9C, 0x58, 0x80, 0x03, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFF, 0xF7, 0x59, 0xFC	; 037FE3EA
	.byte 0x06, 0x1C, 0x10, 0x48, 0x84, 0x68, 0x00, 0x27, 0x68, 0x68, 0x00, 0x28, 0x08, 0xD1, 0x6C, 0x60	; 037FE3FA
	.byte 0xA8, 0x68, 0x40, 0x1C, 0xA8, 0x60, 0x20, 0x1C, 0x29, 0x1C, 0xFF, 0xF7, 0xAA, 0xFF, 0x0B, 0xE0	; 037FE40A
	.byte 0xA0, 0x42, 0x03, 0xD1, 0xA8, 0x68, 0x40, 0x1C, 0xA8, 0x60, 0x05, 0xE0, 0xE5, 0x65, 0x28, 0x1C	; 037FE41A
	.byte 0xFF, 0xF7, 0x75, 0xFD, 0xE7, 0x65, 0xE7, 0xE7, 0x30, 0x1C, 0xFF, 0xF7, 0x4C, 0xFC, 0x01, 0xB0	; 037FE42A
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0x58, 0x80, 0x03, 0x00, 0x21, 0x01, 0x80, 0x41, 0x60	; 037FE43A
	.byte 0x81, 0x60, 0x70, 0x47, 0x00, 0x00	; 037FE440

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
	.byte 0x81, 0x00, 0x01, 0x48, 0x08, 0x58, 0x70, 0x47, 0xA0, 0xFD, 0x7F, 0x02, 0x81, 0x00, 0x01, 0x48	; 037FE51C
	.byte 0x08, 0x58, 0x70, 0x47, 0xC4, 0xFD, 0x7F, 0x02	; 037FE524

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
	.word 0x03805968	; 037FE54C

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
	.word 0x0380596C	; 037FE5E4
	.byte 0xF0, 0xB5, 0x83, 0xB0, 0x06, 0x1C, 0x0D, 0x1C, 0x02, 0x92, 0x1C, 0x1C, 0xFF, 0xF7, 0x52, 0xFB	; 037FE5F8
	.byte 0x00, 0x90, 0xB1, 0x00, 0x18, 0x48, 0x45, 0x50, 0x23, 0x1C, 0x0C, 0x20, 0x43, 0x43, 0x28, 0x1C	; 037FE608
	.byte 0x14, 0x30, 0x28, 0x61, 0x6C, 0x60, 0x00, 0x22, 0xD0, 0x43, 0x17, 0x1C, 0x0C, 0xE0, 0x29, 0x69	; 037FE618
	.byte 0x16, 0x1C, 0x01, 0x96, 0x0C, 0x24, 0x66, 0x43, 0x01, 0x96, 0x8E, 0x19, 0x01, 0x9C, 0x08, 0x51	; 037FE628
	.byte 0xB7, 0x60, 0xB1, 0x68, 0x71, 0x60, 0x52, 0x1C, 0x69, 0x68, 0x8A, 0x42, 0xEF, 0xDB, 0x00, 0x20	; 037FE638
	.byte 0xC0, 0x43, 0x28, 0x60, 0x28, 0x69, 0xC0, 0x18, 0x1F, 0x30, 0x1F, 0x21, 0x88, 0x43, 0xA8, 0x60	; 037FE648
	.byte 0x02, 0x98, 0x88, 0x43, 0x02, 0x90, 0xE8, 0x60, 0x00, 0x98, 0xFF, 0xF7, 0x35, 0xFB, 0xA8, 0x68	; 037FE658
	.byte 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x6C, 0x59, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0	; 037FE668
	.byte 0x05, 0x1C, 0x0C, 0x1C, 0xFF, 0xF7, 0x16, 0xFB, 0xAA, 0x00, 0x05, 0x49, 0x89, 0x58, 0x0D, 0x68	; 037FE678
	.byte 0x0C, 0x60, 0xFF, 0xF7, 0x21, 0xFB, 0x28, 0x1C, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FE688
	.byte 0x6C, 0x59, 0x80, 0x03, 0xF0, 0xB5, 0x81, 0xB0, 0x06, 0x1C, 0x0D, 0x1C, 0x14, 0x1C, 0xFF, 0xF7	; 037FE698
	.byte 0x01, 0xFB, 0x07, 0x1C, 0xB1, 0x00, 0x0D, 0x48, 0x40, 0x58, 0x00, 0x2D, 0x00, 0xDA, 0x05, 0x68	; 037FE6A8
	.byte 0x20, 0x3C, 0x01, 0x69, 0x0C, 0x20, 0x45, 0x43, 0x4D, 0x19, 0xA8, 0x68, 0x21, 0x1C, 0x00, 0xF0	; 037FE6B8
	.byte 0x95, 0xF8, 0xA8, 0x60, 0x68, 0x68, 0x21, 0x1C, 0x00, 0xF0, 0x60, 0xF8, 0x68, 0x60, 0x38, 0x1C	; 037FE6C8
	.byte 0xFF, 0xF7, 0xFA, 0xFA, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x6C, 0x59, 0x80, 0x03	; 037FE6D8

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
	.word 0x0380596C	; 037FE780
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x02, 0x1C, 0x00, 0x23, 0x03, 0xE0, 0x91, 0x42, 0x03, 0xD9, 0x13, 0x1C	; 037FE794
	.byte 0x52, 0x68, 0x00, 0x2A, 0xF9, 0xD1, 0x4A, 0x60, 0x0B, 0x60, 0x00, 0x2A, 0x0C, 0xD0, 0x11, 0x60	; 037FE7A4
	.byte 0x8D, 0x68, 0x4C, 0x19, 0x94, 0x42, 0x07, 0xD1, 0x94, 0x68, 0x2C, 0x19, 0x8C, 0x60, 0x52, 0x68	; 037FE7B4
	.byte 0x4A, 0x60, 0x00, 0x2A, 0x00, 0xD0, 0x11, 0x60, 0x00, 0x2B, 0x0C, 0xD0, 0x59, 0x60, 0x9C, 0x68	; 037FE7C4
	.byte 0x1D, 0x19, 0x8D, 0x42, 0x08, 0xD1, 0x89, 0x68, 0x61, 0x18, 0x99, 0x60, 0x5A, 0x60, 0x00, 0x2A	; 037FE7D4
	.byte 0x02, 0xD0, 0x13, 0x60, 0x00, 0xE0, 0x08, 0x1C, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FE7E4

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
	.word 0x03805990	; 037FE820

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
	.word 0x04000100	; 037FE88C
pool_037FE890:
loc_037FE890:
	.word 0x0380599C	; 037FE890
pool_037FE894:
loc_037FE894:
	.word 0x0000FFFF	; 037FE894
pool_037FE898:
loc_037FE898:
	.word 0x04000214	; 037FE898
pool_037FE89C:
loc_037FE89C:
	.word 0x00008000	; 037FE89C

; ===== function loc_037FE8A0 =====
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
	.word 0x0380599C	; 037FE8DC
pool_037FE8E0:
loc_037FE8E0:
	.word 0x03805998	; 037FE8E0
pool_037FE8E4:
loc_037FE8E4:
	.word 0x04000102	; 037FE8E4
pool_037FE8E8:
loc_037FE8E8:
	.word 0x04000100	; 037FE8E8
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
	.word 0x03805994	; 037FE8F8

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
	.word 0x03805994	; 037FE940
pool_037FE944:
loc_037FE944:
	.word 0x0380599C	; 037FE944
pool_037FE948:
loc_037FE948:
	.word 0x04000102	; 037FE948
pool_037FE94C:
loc_037FE94C:
	.word 0x04000100	; 037FE94C
pool_037FE950:
loc_037FE950:
	.word 0x037FE8A1	; 037FE950
pool_037FE954:
loc_037FE954:
	.word 0x03805998	; 037FE954
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
	.word 0x037FE975	; 037FE970
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
	.word 0x04000106	; 037FEA0C
pool_037FEA10:
loc_037FEA10:
	.word 0x0380FFF8	; 037FEA10
pool_037FEA14:
loc_037FEA14:
	.word 0x038059A8	; 037FEA14

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
	.word 0x038059A8	; 037FEA70

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
	.word 0x038059A8	; 037FEBD4

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
	.word 0x03804908	; 037FEBE0
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
	.word 0x03804B10	; 037FEBEC
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
	.word 0x038059A4	; 037FEC00

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
	.word 0x038059A4	; 037FEC2C
pool_037FEC30:
loc_037FEC30:
	.word 0x038059A8	; 037FEC30

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
	.word 0x04000106	; 037FEC8C
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
	.word 0x04000104	; 037FEC9C

; ===== function loc_037FECA0 =====
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
	.word 0x038059B4	; 037FECCC
pool_037FECD0:
loc_037FECD0:
	.word 0x038059B8	; 037FECD0
	.byte 0xC3, 0x68, 0xCB, 0x1A, 0x10, 0x21, 0x41, 0x5E, 0x52, 0x1A, 0x00, 0x2B, 0x03, 0xDB, 0x00, 0x2B	; 037FECE4
	.byte 0x03, 0xD1, 0x00, 0x2A, 0x01, 0xDA, 0x00, 0x20, 0x70, 0x47, 0x00, 0x2A, 0x01, 0xDA, 0x05, 0x49	; 037FECF4
	.byte 0x52, 0x18, 0x12, 0x21, 0x40, 0x5E, 0x82, 0x42, 0x01, 0xDC, 0x01, 0x20, 0x70, 0x47, 0x02, 0x20	; 037FED04
	.byte 0x70, 0x47, 0xC0, 0x46, 0x07, 0x01, 0x00, 0x00, 0xF0, 0xB5, 0x81, 0xB0, 0x04, 0x20, 0xFE, 0xF7	; 037FED14
	.byte 0x85, 0xFE, 0x35, 0x4B, 0x19, 0x88, 0x20, 0x20, 0x81, 0x43, 0x19, 0x80, 0x33, 0x4A, 0x11, 0x68	; 037FED24
	.byte 0x04, 0x20, 0x01, 0x43, 0x11, 0x60, 0x19, 0x88, 0x0A, 0x12, 0xFF, 0x20, 0x02, 0x40, 0x49, 0x00	; 037FED34
	.byte 0x2F, 0x48, 0x01, 0x40, 0x0A, 0x43, 0x50, 0x1E, 0xFF, 0xF7, 0xB0, 0xFF, 0x2D, 0x4F, 0x4B, 0xE0	; 037FED44
	.byte 0x3C, 0x88, 0x20, 0x1C, 0xFF, 0xF7, 0xAA, 0xFF, 0x06, 0x1C, 0x28, 0x1C, 0x31, 0x1C, 0x22, 0x1C	; 037FED54
	.byte 0xFF, 0xF7, 0xBE, 0xFF, 0x00, 0x28, 0x04, 0xD0, 0x01, 0x28, 0x19, 0xD0, 0x02, 0x28, 0x31, 0xD0	; 037FED64
	.byte 0x3A, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0xA0, 0xF8, 0x39, 0x88, 0x10, 0x20, 0x28, 0x5E, 0x88, 0x42	; 037FED74
	.byte 0x36, 0xD1, 0xE8, 0x68, 0xB0, 0x42, 0x33, 0xD1, 0x04, 0x20, 0xFE, 0xF7, 0x4F, 0xFE, 0x1A, 0x48	; 037FED84
	.byte 0x01, 0x88, 0x20, 0x20, 0x81, 0x43, 0x18, 0x48, 0x01, 0x80, 0x04, 0x20, 0xFE, 0xF7, 0x34, 0xFE	; 037FED94
	.byte 0x2C, 0x68, 0x28, 0x1C, 0x00, 0xF0, 0x14, 0xF9, 0x00, 0x20, 0x28, 0x60, 0x00, 0x2C, 0x02, 0xD0	; 037FEDA4
	.byte 0x68, 0x68, 0x06, 0xF0, 0x53, 0xF9, 0xE8, 0x69, 0x00, 0x28, 0x15, 0xD0, 0x68, 0x6A, 0x00, 0x28	; 037FEDB4
	.byte 0x12, 0xD1, 0x2C, 0x60, 0x10, 0x48, 0x00, 0x68, 0x40, 0x1C, 0xE8, 0x60, 0x28, 0x1C, 0x00, 0xF0	; 037FEDC4
	.byte 0x13, 0xF9, 0x09, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0xFB, 0xF8, 0x28, 0x1C, 0x00, 0xF0, 0x0C, 0xF9	; 037FEDD4
	.byte 0x09, 0x48, 0x00, 0x68, 0x40, 0x1C, 0xE8, 0x60, 0x08, 0x48, 0x05, 0x68, 0x00, 0x2D, 0xAF, 0xD1	; 037FEDE4
	.byte 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x04, 0x00, 0x00, 0x04, 0xF8, 0xFF, 0x80, 0x03	; 037FEDF4
	.byte 0x00, 0x01, 0x00, 0x00, 0x06, 0x00, 0x00, 0x04, 0xB8, 0x59, 0x80, 0x03, 0xBC, 0x59, 0x80, 0x03	; 037FEE04
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFE, 0xF7, 0x47, 0xFF, 0x06, 0x1C, 0x00, 0x2D, 0x01, 0xD1	; 037FEE14
	.byte 0x00, 0xF0, 0xBC, 0xF9, 0x0E, 0x48, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x84, 0x69, 0x00, 0xE0	; 037FEE24
	.byte 0x00, 0x24, 0x00, 0x27, 0x0A, 0xE0, 0x81, 0x68, 0xA9, 0x42, 0x01, 0xD1, 0x00, 0xF0, 0x12, 0xF8	; 037FEE34
	.byte 0x20, 0x1C, 0x00, 0x2C, 0x01, 0xD0, 0xA4, 0x69, 0x00, 0xE0, 0x3C, 0x1C, 0x00, 0x28, 0xF2, 0xD1	; 037FEE44
	.byte 0x30, 0x1C, 0xFE, 0xF7, 0x3B, 0xFF, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FEE54
	.byte 0xBC, 0x59, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFE, 0xF7, 0x1D, 0xFF, 0x04, 0x1C	; 037FEE64
	.byte 0x01, 0x21, 0x69, 0x62, 0x29, 0x68, 0x00, 0x29, 0x02, 0xD1, 0xFE, 0xF7, 0x27, 0xFF, 0x07, 0xE0	; 037FEE74
	.byte 0x28, 0x1C, 0x00, 0xF0, 0xA5, 0xF8, 0x00, 0x20, 0x28, 0x60, 0x20, 0x1C, 0xFE, 0xF7, 0x1E, 0xFF	; 037FEE84
	.byte 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FEE8C

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
	.byte 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C, 0x04, 0x20, 0x0E, 0x49, 0xFE, 0xF7, 0x0C, 0xFE, 0x10, 0x20	; 037FEEBA
	.byte 0x20, 0x5E, 0x0C, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x54, 0x10, 0x0B, 0x4A, 0x13, 0x88, 0x3F, 0x21	; 037FEECA
	.byte 0x0B, 0x40, 0xFF, 0x21, 0x08, 0x40, 0x00, 0x02, 0x03, 0x43, 0x1C, 0x43, 0x14, 0x80, 0x11, 0x88	; 037FEEDA
	.byte 0x20, 0x20, 0x01, 0x43, 0x11, 0x80, 0x04, 0x20, 0xFE, 0xF7, 0xB3, 0xFD, 0x10, 0xBC, 0x08, 0xBC	; 037FEEEA
	.byte 0x18, 0x47, 0x0D, 0xED, 0x7F, 0x03, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x04, 0xF0, 0xB5	; 037FEEFA
	.byte 0x83, 0xB0, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x1F, 0x1C, 0xFE, 0xF7, 0xCA, 0xFE, 0x00, 0x90	; 037FEF0A
	.byte 0x00, 0x2D, 0x02, 0xD0, 0x28, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x3C, 0xF9, 0x0E, 0x48	; 037FEF1A
	.byte 0x00, 0x88, 0x01, 0x90, 0xFF, 0xF7, 0xBF, 0xFE, 0x01, 0x21, 0xE9, 0x61, 0x2C, 0x82, 0x01, 0x99	; 037FEF2A
	.byte 0x8C, 0x42, 0x00, 0xDC, 0x40, 0x1C, 0xE8, 0x60, 0x6E, 0x82, 0x2F, 0x60, 0x08, 0x98, 0x68, 0x60	; 037FEF3A
	.byte 0x00, 0x20, 0x68, 0x62, 0x28, 0x1C, 0x00, 0xF0, 0x68, 0xF8, 0x00, 0x98, 0xFE, 0xF7, 0xBB, 0xFE	; 037FEF4A
	.byte 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x06, 0x00, 0x00, 0x04, 0xF0, 0xB5	; 037FEF5A
	.byte 0x83, 0xB0, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x1F, 0x1C, 0xFE, 0xF7, 0x9A, 0xFE, 0x00, 0x90	; 037FEF6A
	.byte 0x00, 0x2D, 0x02, 0xD0, 0x28, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x0C, 0xF9, 0x0E, 0x48	; 037FEF7A
	.byte 0x00, 0x88, 0x01, 0x90, 0xFF, 0xF7, 0x8F, 0xFE, 0x00, 0x21, 0xE9, 0x61, 0x2C, 0x82, 0x01, 0x99	; 037FEF8A
	.byte 0x8C, 0x42, 0x00, 0xDC, 0x40, 0x1C, 0xE8, 0x60, 0x6E, 0x82, 0x2F, 0x60, 0x08, 0x98, 0x68, 0x60	; 037FEF9A
	.byte 0x00, 0x20, 0x68, 0x62, 0x28, 0x1C, 0x00, 0xF0, 0x38, 0xF8, 0x00, 0x98, 0xFE, 0xF7, 0x8B, 0xFE	; 037FEFAA
	.byte 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x06, 0x00, 0x00, 0x04	; 037FEFB8

; ===== function loc_037FEFB8 =====
loc_037FEFB8:
	mov r1,#0x0	; 037FEFB8
	str r1,[r0,#0x0]	; 037FEFBA
	str r1,[r0,#0x8]	; 037FEFBC
	str r1,[r0,#0x20]	; 037FEFBE
	bx lr	; 037FEFC0
	.byte 0x00, 0x00, 0x00, 0x28, 0x0D, 0xD0, 0x42, 0x69, 0x81, 0x69, 0x00, 0x29, 0x01, 0xD0, 0x4A, 0x61	; 037FEFD2
	.byte 0x01, 0xE0, 0x04, 0x48, 0x42, 0x60, 0x00, 0x2A, 0x01, 0xD0, 0x91, 0x61, 0x70, 0x47, 0x01, 0x48	; 037FEFE2
	.byte 0x01, 0x60, 0x70, 0x47, 0xC0, 0x46, 0xBC, 0x59, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x49	; 037FEFF2
	.byte 0x4B, 0x68, 0x43, 0x61, 0x00, 0x22, 0x82, 0x61, 0x48, 0x60, 0x00, 0x2B, 0x01, 0xD0, 0x98, 0x61	; 037FF002
	.byte 0x02, 0xE0, 0x08, 0x60, 0xFF, 0xF7, 0x51, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xBC, 0x59	; 037FF012
	.byte 0x80, 0x03, 0x10, 0xB5, 0x11, 0x49, 0x09, 0x68, 0x10, 0x22, 0x17, 0xE0, 0xC4, 0x68, 0xCB, 0x68	; 037FF022
	.byte 0xA3, 0x42, 0x12, 0xD3, 0xA3, 0x42, 0x03, 0xD1, 0x8C, 0x5E, 0x83, 0x5E, 0x9C, 0x42, 0x0C, 0xDD	; 037FF032
	.byte 0x4A, 0x69, 0x42, 0x61, 0x81, 0x61, 0x48, 0x61, 0x00, 0x2A, 0x01, 0xD0, 0x90, 0x61, 0x09, 0xE0	; 037FF042
	.byte 0x06, 0x49, 0x08, 0x60, 0xFF, 0xF7, 0x31, 0xFF, 0x04, 0xE0, 0x89, 0x69, 0x00, 0x29, 0xE5, 0xD1	; 037FF052
	.byte 0xFF, 0xF7, 0xCB, 0xFF, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xBC, 0x59, 0x80, 0x03	; 037FF060

; ===== function loc_037FF060 =====
loc_037FF060:
	ldr r0,[pool_037FF068]	; 037FF060
	ldrh r0,[r0,#0x0]	; 037FF062
	bx lr	; 037FF064
	.byte 0xC0, 0x46	; 037FF068
pool_037FF068:
loc_037FF068:
	.word 0x038059B0	; 037FF068

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
	.word 0x038059B0	; 037FF09C
pool_037FF0A0:
loc_037FF0A0:
	.word 0x038059BC	; 037FF0A0
pool_037FF0A4:
loc_037FF0A4:
	.word 0x038059B8	; 037FF0A4
pool_037FF0A8:
loc_037FF0A8:
	.word 0x038059B4	; 037FF0A8
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
	bl loc_038048AA	; 037FF148
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
	.word 0x04000208	; 037FF17C
pool_037FF180:
loc_037FF180:
	.word 0x0380FFF8	; 037FF180

; ===== function loc_037FF184 =====
loc_037FF184:
	lsr r0,r0,#0x2	; 037FF184
	ldr r3,[pool_037FF18C]	; 037FF186
	bx r3	; 037FF188
	.byte 0xC0, 0x46	; 037FF18C
pool_037FF18C:
loc_037FF18C:
	.word 0x03804891	; 037FF18C

; ===== function loc_037FF190 =====
loc_037FF190:
	push {lr}	; 037FF190
	sub sp,#0x4	; 037FF192
loc_037FF194:
	bl loc_037FDC9C	; 037FF194
	bl loc_038048AA	; 037FF198
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
	.word 0x040000B0	; 037FF1D4
pool_037FF1D8:
loc_037FF1D8:
	.word 0xFFFFCDFF	; 037FF1D8
pool_037FF1DC:
loc_037FF1DC:
	.word 0xFFFF7FFF	; 037FF1DC
	.byte 0x03, 0x21, 0x48, 0x43, 0x80, 0x1C, 0x81, 0x00, 0x03, 0x48, 0x0A, 0x18, 0x03, 0x48, 0x11, 0x68	; 037FF1F0
	.byte 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0x70, 0x47, 0xB0, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x80	; 037FF200
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x17, 0x1C, 0x00, 0x93, 0x00, 0x2B, 0x20, 0xD0	; 037FF210
	.byte 0x03, 0x20, 0x29, 0x1C, 0x41, 0x43, 0x88, 0x1C, 0x81, 0x00, 0x10, 0x48, 0x0C, 0x18, 0x10, 0x48	; 037FF220
	.byte 0x21, 0x68, 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0xFE, 0xF7, 0x38, 0xFD, 0x0C, 0x21, 0x4D, 0x43	; 037FF230
	.byte 0x0A, 0x49, 0x6A, 0x18, 0x16, 0x60, 0x57, 0x60, 0x00, 0x9B, 0x5D, 0x08, 0x08, 0x4B, 0x1D, 0x43	; 037FF240
	.byte 0x95, 0x60, 0x09, 0x68, 0xFE, 0xF7, 0x3C, 0xFD, 0x05, 0x48, 0x21, 0x68, 0x01, 0x40, 0x00, 0x29	; 037FF250
	.byte 0xFB, 0xD1, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xB0, 0x00, 0x00, 0x04	; 037FF260
	.byte 0x00, 0x00, 0x00, 0x80, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x17, 0x1C, 0x00, 0x93	; 037FF270
	.byte 0x00, 0x2B, 0x24, 0xD0, 0x03, 0x20, 0x29, 0x1C, 0x41, 0x43, 0x88, 0x1C, 0x81, 0x00, 0x12, 0x48	; 037FF280
	.byte 0x0C, 0x18, 0x12, 0x48, 0x21, 0x68, 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0xFE, 0xF7, 0x06, 0xFD	; 037FF290
	.byte 0xAA, 0x00, 0x0F, 0x49, 0x51, 0x18, 0x0F, 0x60, 0x0C, 0x22, 0x55, 0x43, 0x0A, 0x4A, 0xAB, 0x18	; 037FF2A0
	.byte 0x19, 0x60, 0x5E, 0x60, 0x00, 0x99, 0x4D, 0x08, 0x0A, 0x49, 0x0D, 0x43, 0x9D, 0x60, 0x11, 0x68	; 037FF2B0
	.byte 0xFE, 0xF7, 0x06, 0xFD, 0x05, 0x48, 0x21, 0x68, 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0x01, 0xB0	; 037FF2C0
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xB0, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x80	; 037FF2D0
	.byte 0xE0, 0xFF, 0x80, 0x03, 0x00, 0x00, 0x00, 0x81	; 037FF2D8
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
	.byte 0x00, 0xC0, 0xA0, 0xE3, 0x02, 0x00, 0x5C, 0xE1, 0xBC, 0x30, 0x90, 0xB1, 0xBC, 0x30, 0x81, 0xB1	; 037FF300
	.byte 0x02, 0xC0, 0x8C, 0xB2, 0xFA, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1	; 037FF30C

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
	.byte 0xF0, 0x03, 0x2D, 0xE9, 0x02, 0x90, 0x81, 0xE0, 0xA2, 0xC2, 0xA0, 0xE1, 0x8C, 0xC2, 0x81, 0xE0	; 037FF348
	.byte 0x00, 0x20, 0xA0, 0xE1, 0x02, 0x30, 0xA0, 0xE1, 0x02, 0x40, 0xA0, 0xE1, 0x02, 0x50, 0xA0, 0xE1	; 037FF358
	.byte 0x02, 0x60, 0xA0, 0xE1, 0x02, 0x70, 0xA0, 0xE1, 0x02, 0x80, 0xA0, 0xE1, 0x0C, 0x00, 0x51, 0xE1	; 037FF368
	.byte 0xFD, 0x01, 0xA1, 0xB8, 0xFC, 0xFF, 0xFF, 0xBA, 0x09, 0x00, 0x51, 0xE1, 0x01, 0x00, 0xA1, 0xB8	; 037FF378
	.byte 0xFC, 0xFF, 0xFF, 0xBA, 0xF0, 0x03, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 037FF384

; ===== function loc_037FF384 =====
loc_037FF384:
	mov r12,#0x0	; 037FF384
loc_037FF388:
	cmp r12,r2	; 037FF388
	strltb r1,[r0,r12]	; 037FF38C
	addlt r12,r12,#0x1	; 037FF390
	blt loc_037FF388	; 037FF394
	bx lr	; 037FF398
	.byte 0x00, 0xC0, 0xA0, 0xE3, 0x02, 0x00, 0x5C, 0xE1, 0x0C, 0x30, 0xD0, 0xB7, 0x0C, 0x30, 0xC1, 0xB7	; 037FF3AC
	.byte 0x01, 0xC0, 0x8C, 0xB2, 0xFA, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1	; 037FF3B8

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
	.word 0x04000501	; 037FF3F0

; ===== function loc_037FF3F4 =====
loc_037FF3F4:
	ldr r1,[pool_037FF3FC]	; 037FF3F4
	strb r0,[r1,#0x0]	; 037FF3F6
	bx lr	; 037FF3F8
	.byte 0xC0, 0x46	; 037FF3FC
pool_037FF3FC:
loc_037FF3FC:
	.word 0x04000500	; 037FF3FC
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x4A, 0x11, 0x88, 0x01, 0x20, 0x01, 0x43, 0x11, 0x80, 0x04, 0xF0	; 037FF410
	.byte 0xEF, 0xFF, 0x06, 0x48, 0x05, 0xF0, 0x4F, 0xFA, 0x05, 0x48, 0xFF, 0xF7, 0xB3, 0xFE, 0x00, 0xF0	; 037FF420
	.byte 0x2B, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x04, 0x03, 0x00, 0x04, 0x00, 0x01, 0x00, 0x00	; 037FF430
	.byte 0x80, 0xAB, 0x07, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xF0, 0x16, 0xF8, 0x80, 0x20, 0x05, 0xF0	; 037FF440
	.byte 0x3E, 0xFA, 0x07, 0x48, 0xFF, 0xF7, 0x9E, 0xFE, 0x01, 0x20, 0x04, 0xF0, 0xC3, 0xFF, 0x05, 0x4A	; 037FF450
	.byte 0x11, 0x88, 0x01, 0x20, 0x81, 0x43, 0x11, 0x80, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FF460
	.byte 0x00, 0x00, 0x04, 0x00, 0x04, 0x03, 0x00, 0x04, 0x02, 0x4A, 0x11, 0x78, 0x80, 0x20, 0x81, 0x43	; 037FF470
	.byte 0x11, 0x70, 0x70, 0x47, 0x01, 0x05, 0x00, 0x04, 0x02, 0x4A, 0x11, 0x78, 0x80, 0x20, 0x01, 0x43	; 037FF480
	.byte 0x11, 0x70, 0x70, 0x47, 0x01, 0x05, 0x00, 0x04	; 037FF488

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
	.word 0x038059C4	; 037FF4C4
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
	.word 0x038059C4	; 037FF504
pool_037FF508:
loc_037FF508:
	.word 0x038059C8	; 037FF508
pool_037FF50C:
loc_037FF50C:
	.word 0x0000FFF5	; 037FF50C
pool_037FF510:
loc_037FF510:
	.word 0x04000402	; 037FF510
pool_037FF514:
loc_037FF514:
	.word 0x04000400	; 037FF514

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
	.word 0x04000402	; 037FF564
pool_037FF568:
loc_037FF568:
	.word 0x038059C4	; 037FF568
pool_037FF56C:
loc_037FF56C:
	.word 0x0000FFF5	; 037FF56C
pool_037FF570:
loc_037FF570:
	.word 0x038059C8	; 037FF570
pool_037FF574:
loc_037FF574:
	.word 0x04000400	; 037FF574

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
	.word 0x04000408	; 037FF588

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
	.word 0x038059C8	; 037FF5D0
pool_037FF5D4:
loc_037FF5D4:
	.word 0x038059C4	; 037FF5D4
pool_037FF5D8:
loc_037FF5D8:
	.word 0x0000FFF5	; 037FF5D8
pool_037FF5DC:
loc_037FF5DC:
	.word 0x04000402	; 037FF5DC
pool_037FF5E0:
loc_037FF5E0:
	.word 0x04000400	; 037FF5E0

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
	.word 0x04000400	; 037FF600
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
	.word 0x038059C8	; 037FF658
pool_037FF65C:
loc_037FF65C:
	.word 0x038059C4	; 037FF65C
pool_037FF660:
loc_037FF660:
	.word 0x0000FFF5	; 037FF660
pool_037FF664:
loc_037FF664:
	.word 0x60000000	; 037FF664
pool_037FF668:
loc_037FF668:
	.word 0x04000400	; 037FF668
pool_037FF66C:
loc_037FF66C:
	.word 0x00010000	; 037FF66C
pool_037FF670:
loc_037FF670:
	.word 0x04000408	; 037FF670

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
	.word 0x038059C8	; 037FF6C4
pool_037FF6C8:
loc_037FF6C8:
	.word 0x038059C4	; 037FF6C8
pool_037FF6CC:
loc_037FF6CC:
	.word 0x0000FFF5	; 037FF6CC
pool_037FF6D0:
loc_037FF6D0:
	.word 0x60000000	; 037FF6D0
pool_037FF6D4:
loc_037FF6D4:
	.word 0x04000400	; 037FF6D4
pool_037FF6D8:
loc_037FF6D8:
	.word 0x00010000	; 037FF6D8
pool_037FF6DC:
loc_037FF6DC:
	.word 0x04000408	; 037FF6DC

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
	.word 0x038059C8	; 037FF74C
pool_037FF750:
loc_037FF750:
	.word 0x038059C4	; 037FF750
pool_037FF754:
loc_037FF754:
	.word 0x0000FFF5	; 037FF754
pool_037FF758:
loc_037FF758:
	.word 0x04000400	; 037FF758
pool_037FF75C:
loc_037FF75C:
	.word 0x00010000	; 037FF75C
pool_037FF760:
loc_037FF760:
	.word 0x04000408	; 037FF760
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
	.word 0x03805298	; 037FF788
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
	.word 0x038050B8	; 037FF7D0

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
	.word 0x03804F50	; 037FF8EC
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
	.word 0x03804B30	; 037FF8F8
	.byte 0x70, 0xB5, 0x00, 0xF0, 0x7D, 0xF8, 0x00, 0xF0, 0x9D, 0xFD, 0x01, 0xF0, 0x07, 0xFE, 0x01, 0xF0	; 037FF90C
	.byte 0xDD, 0xFF, 0xFF, 0xF7, 0xB3, 0xFD, 0x00, 0x20, 0x01, 0x1C, 0x02, 0x1C, 0x03, 0x1C, 0xFF, 0xF7	; 037FF91C
	.byte 0x51, 0xFD, 0x7F, 0x20, 0xFF, 0xF7, 0x68, 0xFD, 0x00, 0xF0, 0x4A, 0xF8, 0x01, 0x26, 0x00, 0x24	; 037FF92C
	.byte 0x25, 0x1C, 0x00, 0xF0, 0x37, 0xF8, 0x01, 0x28, 0x01, 0xD0, 0x02, 0x28, 0x00, 0xE0, 0x35, 0x1C	; 037FF93C
	.byte 0x00, 0xF0, 0xE0, 0xFC, 0x02, 0xF0, 0xF2, 0xF8, 0x28, 0x1C, 0x01, 0xF0, 0xB9, 0xFD, 0x28, 0x1C	; 037FF94C
	.byte 0x00, 0xF0, 0xE0, 0xFB, 0x01, 0xF0, 0xDC, 0xFE, 0xFF, 0xF7, 0x0C, 0xFF, 0xE8, 0xE7, 0x00, 0x00	; 037FF95C
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xA9, 0xFC, 0x00, 0x28	; 037FF96C
	.byte 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0x66, 0xFB, 0x01, 0xB0, 0x08, 0xBC	; 037FF97C
	.byte 0x18, 0x47, 0xC0, 0x46, 0xD8, 0x59, 0x80, 0x03, 0x9C, 0x52, 0x80, 0x03, 0x94, 0x52, 0x80, 0x03	; 037FF98C
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
	.word 0x037FE2BD	; 037FF99C

; ===== function loc_037FF9A0 =====
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
	.byte 0x30, 0xB5, 0x83, 0xB0, 0xFE, 0xF7, 0x30, 0xFF, 0x04, 0x1C, 0x09, 0x48, 0x01, 0x90, 0x00, 0x25	; 037FF9CC
	.byte 0x02, 0x95, 0x08, 0x4B, 0x00, 0x95, 0x08, 0x48, 0x08, 0x4A, 0xA4, 0x18, 0x0A, 0x00, 0x6A, 0x41	; 037FF9DC
	.byte 0x21, 0x1C, 0xFF, 0xF7, 0x49, 0xF8, 0x03, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FF9EC
	.byte 0x5D, 0xF9, 0x7F, 0x03, 0xA8, 0x0A, 0x00, 0x00, 0x0C, 0x5A, 0x80, 0x03, 0x00, 0x00, 0x01, 0x00	; 037FF9FC
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x05, 0x48, 0x06, 0x49, 0x08, 0x22, 0xFE, 0xF7, 0x87, 0xFC, 0x05, 0x48	; 037FFA0C
	.byte 0xFF, 0xF7, 0xF0, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xD8, 0x59, 0x80, 0x03	; 037FFA1C
	.byte 0xEC, 0x59, 0x80, 0x03, 0x0C, 0x5A, 0x80, 0x03	; 037FFA24

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
	bl loc_037FDF88	; 037FFA36
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
	.word 0x037FF8FD	; 037FFA50
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
	.word 0x04000508	; 037FFA80

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
	.word 0x04000508	; 037FFAC0
pool_037FFAC4:
loc_037FFAC4:
	.word 0x04000510	; 037FFAC4
pool_037FFAC8:
loc_037FFAC8:
	.word 0x04000514	; 037FFAC8

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
	.word 0x03804B10	; 037FFB48
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
	.word 0x03804960	; 037FFB98
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
	add r1,pc	; 037FFBAA
	ldrh r1,[r1,#0x8]	; 037FFBAC
	lsl r1,r1,#0x10	; 037FFBAE
	asr r1,r1,#0x10	; 037FFBB0
	add r1,pc	; 037FFBB2
	bx r1	; 037FFBB4
	.byte 0x09, 0x00, 0x23, 0x00, 0x53, 0x00, 0x47, 0x00	; 037FFBBE
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
	.word 0x038050DC	; 037FFC14

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
	.word 0x038051DC	; 037FFC58

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
	.word 0x03805EB0	; 037FFE24
pool_037FFE28:
loc_037FFE28:
	.word 0x03805EB4	; 037FFE28

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
	.word 0x03805EB4	; 037FFED0
pool_037FFED4:
loc_037FFED4:
	.word 0x03805EB0	; 037FFED4

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
	.word 0x03805EB4	; 037FFF58

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
	.word 0x03805EB4	; 0380001C
pool_03800020:
loc_03800020:
	.word 0x03805EB0	; 03800020
pool_03800024:
loc_03800024:
	.word 0x038051E0	; 03800024
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
	.word 0x038051F0	; 03800080

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
	.word 0x038050DC	; 038002F4
pool_038002F8:
loc_038002F8:
	.word 0xFFFFFD2D	; 038002F8
pool_038002FC:
loc_038002FC:
	.word 0x0000FFFC	; 038002FC
	.byte 0xF0, 0xB5, 0x87, 0xB0, 0x00, 0x24, 0x27, 0x1C, 0xFF, 0x26, 0x21, 0x1C, 0x54, 0x20, 0x41, 0x43	; 03800310
	.byte 0x49, 0x48, 0x45, 0x18, 0x29, 0x79, 0x00, 0x29, 0x6E, 0xD0, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29	; 03800320
	.byte 0x03, 0xD0, 0x20, 0x1C, 0x39, 0x1C, 0xFF, 0xF7, 0x5D, 0xF9, 0x28, 0x79, 0x02, 0x1C, 0x01, 0x21	; 03800330
	.byte 0x0A, 0x40, 0x00, 0x2A, 0x42, 0xD0, 0x68, 0x78, 0x00, 0x28, 0x04, 0xD0, 0x01, 0x28, 0x21, 0xD0	; 03800340
	.byte 0x02, 0x28, 0x2E, 0xD0, 0x58, 0xE0, 0x28, 0x1C, 0x39, 0x30, 0x00, 0x78, 0x00, 0x28, 0x01, 0xD0	; 03800350
	.byte 0x0B, 0x00, 0x00, 0xE0, 0x02, 0x23, 0xA8, 0x8C, 0xE9, 0x8F, 0x00, 0x91, 0x29, 0x6C, 0x01, 0x91	; 03800360
	.byte 0x01, 0x1C, 0x31, 0x40, 0x02, 0x91, 0x00, 0x12, 0x03, 0x90, 0xE8, 0x8C, 0x04, 0x90, 0x28, 0x1C	; 03800370
	.byte 0x23, 0x30, 0x00, 0x78, 0x05, 0x90, 0x20, 0x1C, 0x69, 0x6C, 0x38, 0x35, 0x2A, 0x78, 0xFF, 0xF7	; 03800380
	.byte 0xAF, 0xF9, 0x39, 0xE0, 0xAB, 0x8C, 0xE8, 0x8C, 0x00, 0x90, 0x28, 0x1C, 0x23, 0x30, 0x00, 0x78	; 03800390
	.byte 0x01, 0x90, 0x20, 0x1C, 0x69, 0x6C, 0x1A, 0x1C, 0x32, 0x40, 0x1B, 0x12, 0xFF, 0xF7, 0x6A, 0xF9	; 038003A0
	.byte 0x2A, 0xE0, 0xAA, 0x8C, 0x28, 0x1C, 0x23, 0x30, 0x00, 0x78, 0x00, 0x90, 0x20, 0x1C, 0x11, 0x1C	; 038003B0
	.byte 0x31, 0x40, 0x12, 0x12, 0xEB, 0x8C, 0xFF, 0xF7, 0x29, 0xF9, 0x1D, 0xE0, 0x04, 0x21, 0x08, 0x40	; 038003C0
	.byte 0x00, 0x28, 0x03, 0xD0, 0x20, 0x1C, 0xE9, 0x8C, 0xFF, 0xF7, 0xD6, 0xF8, 0x29, 0x79, 0x08, 0x20	; 038003D0
	.byte 0x01, 0x40, 0x00, 0x29, 0x06, 0xD0, 0xAA, 0x8C, 0x20, 0x1C, 0x11, 0x1C, 0x31, 0x40, 0x12, 0x12	; 038003E0
	.byte 0xFF, 0xF7, 0xD4, 0xF8, 0x29, 0x79, 0x10, 0x20, 0x01, 0x40, 0x00, 0x29, 0x04, 0xD0, 0x20, 0x1C	; 038003F0
	.byte 0x23, 0x35, 0x29, 0x78, 0xFF, 0xF7, 0x9E, 0xF8, 0x64, 0x1C, 0x10, 0x2C, 0x85, 0xDB, 0x00, 0x22	; 03800400
	.byte 0x15, 0x1C, 0x0D, 0x48, 0x54, 0x24, 0x11, 0x1C, 0x61, 0x43, 0x41, 0x18, 0x0E, 0x79, 0x00, 0x2E	; 03800410
	.byte 0x0B, 0xD0, 0x01, 0x23, 0x1E, 0x40, 0x00, 0x2E, 0x06, 0xD0, 0x16, 0x01, 0x07, 0x4B, 0xF7, 0x18	; 03800420
	.byte 0x3E, 0x78, 0x80, 0x23, 0x1E, 0x43, 0x3E, 0x70, 0x0D, 0x71, 0x52, 0x1C, 0x10, 0x2A, 0xEA, 0xDB	; 03800430
	.byte 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xD4, 0x5E, 0x80, 0x03, 0x03, 0x04, 0x00, 0x04	; 03800440
	.byte 0x70, 0xB5, 0x00, 0x20, 0x0B, 0x4E, 0x05, 0x1C, 0x54, 0x21, 0x01, 0x22, 0x03, 0x1C, 0x4B, 0x43	; 03800450
	.byte 0xF4, 0x18, 0xF0, 0x54, 0x25, 0x71, 0xE4, 0x1C, 0x23, 0x78, 0x93, 0x43, 0x23, 0x70, 0x40, 0x1C	; 03800460
	.byte 0x10, 0x28, 0xF3, 0xDB, 0x04, 0x48, 0x05, 0x60, 0x04, 0x48, 0x05, 0x60, 0x70, 0xBC, 0x08, 0xBC	; 03800470
	.byte 0x18, 0x47, 0xC0, 0x46, 0xD4, 0x5E, 0x80, 0x03, 0xB4, 0x5E, 0x80, 0x03, 0xB0, 0x5E, 0x80, 0x03	; 03800480

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
	.word 0x03805ED0	; 038004E0
pool_038004E4:
loc_038004E4:
	.word 0x00000260	; 038004E4
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x26, 0x34, 0x1C, 0x01, 0x27, 0x28, 0x1C, 0x21, 0x1C	; 038004F8
	.byte 0x00, 0xF0, 0x98, 0xFC, 0x00, 0x28, 0x0D, 0xD0, 0x81, 0x6A, 0x00, 0x29, 0x0A, 0xD0, 0x29, 0x1C	; 03800508
	.byte 0x00, 0xF0, 0x14, 0xF8, 0x00, 0x28, 0x01, 0xD1, 0x3E, 0x1C, 0x03, 0xE0, 0x28, 0x1C, 0x21, 0x1C	; 03800518
	.byte 0x00, 0xF0, 0x66, 0xFC, 0x64, 0x1C, 0x10, 0x2C, 0xE8, 0xDB, 0x00, 0x2E, 0x01, 0xD1, 0x01, 0x20	; 03800528
	.byte 0x00, 0xE0, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF0, 0xB5, 0x89, 0xB0	; 03800538
	.byte 0x04, 0x1C, 0x01, 0x91, 0x21, 0x78, 0xC8, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x07, 0xD0, 0xE0, 0x6B	; 03800548
	.byte 0x00, 0x28, 0x01, 0xD0, 0x00, 0x20, 0x03, 0xE3, 0x10, 0x20, 0x81, 0x43, 0x21, 0x70, 0x20, 0x6A	; 03800558
	.byte 0x00, 0x28, 0x09, 0xDD, 0x21, 0x1C, 0x20, 0x31, 0x08, 0x68, 0x40, 0x1E, 0x08, 0x60, 0x20, 0x6A	; 03800568
	.byte 0x00, 0x28, 0x01, 0xDD, 0x00, 0x20, 0xF3, 0xE2, 0xA0, 0x6A, 0x00, 0xF0, 0x03, 0xFE, 0x00, 0x20	; 03800578
	.byte 0xC0, 0x43, 0x06, 0x90, 0xE2, 0xE2, 0x00, 0x25, 0x01, 0x20, 0x03, 0x90, 0x20, 0x1C, 0x00, 0xF0	; 03800588
	.byte 0xD5, 0xFD, 0x06, 0x1C, 0xA2, 0x2E, 0x07, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0xCF, 0xFD, 0x06, 0x1C	; 03800598
	.byte 0x20, 0x78, 0x40, 0x06, 0xC0, 0x0F, 0x03, 0x90, 0xA0, 0x2E, 0x06, 0xD1, 0x20, 0x1C, 0x00, 0xF0	; 038005A8
	.byte 0xC5, 0xFD, 0x06, 0x1C, 0x03, 0x20, 0x02, 0x90, 0x01, 0x25, 0xA1, 0x2E, 0x06, 0xD1, 0x20, 0x1C	; 038005B8
	.byte 0x00, 0xF0, 0xBC, 0xFD, 0x06, 0x1C, 0x04, 0x20, 0x02, 0x90, 0x01, 0x25, 0x31, 0x1C, 0x80, 0x20	; 038005C8
	.byte 0x01, 0x40, 0x00, 0x29, 0x37, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0xB0, 0xFD, 0x04, 0x90, 0x00, 0x2D	; 038005D8
	.byte 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x02, 0x22, 0x20, 0x1C, 0x01, 0x99, 0x00, 0xF0, 0x10, 0xFD	; 038005E8
	.byte 0x07, 0x1C, 0x13, 0x20, 0x20, 0x56, 0x35, 0x18, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0xA5, 0xE2	; 038005F8
	.byte 0x00, 0x2D, 0x01, 0xDA, 0x00, 0x25, 0x02, 0xE0, 0x7F, 0x2D, 0x00, 0xDD, 0x7F, 0x25, 0x20, 0x78	; 03800608
	.byte 0x40, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x06, 0xD1, 0x00, 0x97, 0x20, 0x1C, 0x01, 0x99, 0x2A, 0x1C	; 03800618
	.byte 0x04, 0x9B, 0x00, 0xF0, 0xA1, 0xFA, 0x25, 0x75, 0x20, 0x78, 0x80, 0x07, 0xC0, 0x0F, 0x00, 0x28	; 03800628
	.byte 0x00, 0xD1, 0x8B, 0xE2, 0x27, 0x62, 0x00, 0x2F, 0x00, 0xD0, 0x87, 0xE2, 0x21, 0x78, 0x10, 0x20	; 03800638
	.byte 0x01, 0x43, 0x21, 0x70, 0x82, 0xE2, 0x31, 0x1C, 0xF0, 0x20, 0x01, 0x40, 0xC0, 0x29, 0x0C, 0xDC	; 03800648
	.byte 0xC0, 0x29, 0x7C, 0xDA, 0x90, 0x29, 0x04, 0xDC, 0x90, 0x29, 0x2C, 0xDA, 0x80, 0x29, 0x10, 0xD0	; 03800658
	.byte 0x74, 0xE2, 0xB0, 0x29, 0x00, 0xD1, 0x58, 0xE1, 0x70, 0xE2, 0xE0, 0x29, 0x05, 0xDC, 0xE0, 0x29	; 03800668
	.byte 0x00, 0xDB, 0x35, 0xE1, 0xD0, 0x29, 0x6A, 0xD0, 0x68, 0xE2, 0xF0, 0x29, 0x00, 0xD1, 0x1D, 0xE2	; 03800678
	.byte 0x64, 0xE2, 0x00, 0x2D, 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x02, 0x22, 0x20, 0x1C, 0x01, 0x99	; 03800688
	.byte 0x00, 0xF0, 0xBE, 0xFC, 0x03, 0x99, 0x00, 0x29, 0x00, 0xD1, 0x57, 0xE2, 0x80, 0x2E, 0x02, 0xD0	; 03800698
	.byte 0x81, 0x2E, 0x02, 0xD0, 0x52, 0xE2, 0x20, 0x62, 0x50, 0xE2, 0xD0, 0x49, 0x88, 0x42, 0x00, 0xDB	; 038006A8
	.byte 0x4C, 0xE2, 0x60, 0x80, 0x4A, 0xE2, 0x93, 0x2E, 0x04, 0xD0, 0x94, 0x2E, 0x22, 0xD0, 0x95, 0x2E	; 038006B8
	.byte 0x2B, 0xD0, 0x43, 0xE2, 0x20, 0x1C, 0x00, 0xF0, 0x39, 0xFD, 0x05, 0x1C, 0x20, 0x1C, 0x00, 0xF0	; 038006C8
	.byte 0xF5, 0xFC, 0x06, 0x1C, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0x37, 0xE2, 0x01, 0x98, 0x29, 0x1C	; 038006D8
	.byte 0x00, 0xF0, 0xA8, 0xFB, 0x05, 0x1C, 0x00, 0x2D, 0x00, 0xD1, 0x2F, 0xE2, 0xA5, 0x42, 0x00, 0xD1	; 038006E8
	.byte 0x2C, 0xE2, 0x01, 0x99, 0x00, 0xF0, 0x98, 0xFB, 0x28, 0x1C, 0x61, 0x6A, 0x32, 0x1C, 0x00, 0xF0	; 038006F8
	.byte 0x37, 0xFC, 0x23, 0xE2, 0x20, 0x1C, 0x00, 0xF0, 0xD9, 0xFC, 0x03, 0x99, 0x00, 0x29, 0x00, 0xD1	; 03800708
	.byte 0x1C, 0xE2, 0x61, 0x6A, 0x08, 0x18, 0xA0, 0x62, 0x18, 0xE2, 0x20, 0x1C, 0x00, 0xF0, 0xCE, 0xFC	; 03800718
	.byte 0x03, 0x99, 0x00, 0x29, 0x00, 0xD1, 0x11, 0xE2, 0x21, 0x1C, 0x3B, 0x31, 0x09, 0x78, 0x03, 0x29	; 03800728
	.byte 0x00, 0xD3, 0x0B, 0xE2, 0xA2, 0x6A, 0x89, 0x00, 0x61, 0x18, 0xCA, 0x62, 0x22, 0x1C, 0x3B, 0x32	; 03800738
	.byte 0x11, 0x78, 0x49, 0x1C, 0x11, 0x70, 0x61, 0x6A, 0x08, 0x18, 0xA0, 0x62, 0xFE, 0xE1, 0x00, 0x2D	; 03800748
	.byte 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x1C, 0x01, 0x99, 0x00, 0xF0, 0x58, 0xFC	; 03800758
	.byte 0x07, 0xA9, 0x08, 0x70, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0xEF, 0xE1, 0xC0, 0x3E, 0x15, 0x2E	; 03800768
	.byte 0x00, 0xD9, 0xEB, 0xE1, 0xB0, 0x19, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44	; 03800778
	.byte 0x00, 0x47, 0x55, 0x01, 0x2D, 0x00, 0x3D, 0x00, 0x45, 0x01, 0x4D, 0x01, 0x47, 0x00, 0x4F, 0x00	; 03800788
	.byte 0x57, 0x00, 0xE5, 0x00, 0x05, 0x01, 0x75, 0x00, 0x7D, 0x00, 0x85, 0x00, 0x8D, 0x00, 0x25, 0x01	; 03800798
	.byte 0x6D, 0x00, 0x95, 0x00, 0x9D, 0x00, 0xA5, 0x00, 0xAD, 0x00, 0xB5, 0x00, 0x35, 0x00, 0x08, 0x00	; 038007A8
	.byte 0x00, 0x78, 0x20, 0x71, 0xCA, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x60, 0x71, 0xC6, 0xE1, 0x08, 0x00	; 038007B8
	.byte 0x01, 0x78, 0x01, 0x98, 0x41, 0x71, 0xC1, 0xE1, 0x08, 0x00, 0x00, 0x78, 0xE0, 0x71, 0xBD, 0xE1	; 038007C8
	.byte 0x08, 0x00, 0x00, 0x78, 0xA0, 0x74, 0xB9, 0xE1, 0x20, 0x78, 0x02, 0x21, 0x88, 0x43, 0x07, 0xA9	; 038007D8
	.byte 0x0A, 0x78, 0x01, 0x21, 0x0A, 0x40, 0x51, 0x00, 0x08, 0x43, 0x20, 0x70, 0xAE, 0xE1, 0x08, 0x00	; 038007E8
	.byte 0x00, 0x78, 0x60, 0x75, 0xAA, 0xE1, 0x08, 0x00, 0x00, 0x78, 0xA0, 0x76, 0xA6, 0xE1, 0x08, 0x00	; 038007F8
	.byte 0x00, 0x78, 0x60, 0x76, 0xA2, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x20, 0x76, 0x9E, 0xE1, 0x08, 0x00	; 03800808
	.byte 0x00, 0x78, 0xE0, 0x76, 0x9A, 0xE1, 0x08, 0x00, 0x00, 0x78, 0xA0, 0x73, 0x96, 0xE1, 0x08, 0x00	; 03800818
	.byte 0x00, 0x78, 0xE0, 0x73, 0x92, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x20, 0x74, 0x8E, 0xE1, 0x08, 0x00	; 03800828
	.byte 0x00, 0x78, 0x60, 0x74, 0x8A, 0xE1, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x03, 0x28, 0x00, 0xD3	; 03800838
	.byte 0x84, 0xE1, 0xA1, 0x6A, 0x80, 0x00, 0x20, 0x18, 0xC1, 0x62, 0x07, 0xA8, 0x01, 0x78, 0x20, 0x1C	; 03800848
	.byte 0x3B, 0x30, 0x00, 0x78, 0x20, 0x18, 0x38, 0x30, 0x01, 0x70, 0x21, 0x1C, 0x3B, 0x31, 0x08, 0x78	; 03800858
	.byte 0x40, 0x1C, 0x08, 0x70, 0x72, 0xE1, 0x20, 0x78, 0x08, 0x21, 0x88, 0x43, 0x07, 0xA9, 0x0A, 0x78	; 03800868
	.byte 0x01, 0x21, 0x0A, 0x40, 0xD1, 0x00, 0x08, 0x43, 0x20, 0x70, 0x20, 0x1C, 0x01, 0x99, 0x06, 0x9A	; 03800878
	.byte 0x00, 0xF0, 0x1C, 0xFB, 0x62, 0xE1, 0x08, 0x00, 0x01, 0x78, 0x13, 0x20, 0x20, 0x56, 0x08, 0x18	; 03800888
	.byte 0x20, 0x75, 0x21, 0x78, 0x20, 0x20, 0x01, 0x43, 0x21, 0x70, 0x20, 0x1C, 0x01, 0x99, 0x06, 0x9A	; 03800898
	.byte 0x00, 0xF0, 0x0C, 0xFB, 0x52, 0xE1, 0x20, 0x78, 0x20, 0x21, 0x88, 0x43, 0x07, 0xA9, 0x0A, 0x78	; 038008A8
	.byte 0x01, 0x21, 0x0A, 0x40, 0x51, 0x01, 0x08, 0x43, 0x20, 0x70, 0x20, 0x1C, 0x01, 0x99, 0x06, 0x9A	; 038008B8
	.byte 0x00, 0xF0, 0xFC, 0xFA, 0x42, 0xE1, 0x00, 0x20, 0x08, 0x56, 0xE0, 0x74, 0x3E, 0xE1, 0x00, 0x20	; 038008C8
	.byte 0x08, 0x56, 0xA0, 0x71, 0x3A, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x40, 0x38, 0x20, 0x72, 0x35, 0xE1	; 038008D8
	.byte 0x00, 0x2D, 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x01, 0x22, 0x20, 0x1C, 0x01, 0x99, 0x00, 0xF0	; 038008E8
	.byte 0x8F, 0xFB, 0x00, 0x04, 0x01, 0x14, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0x26, 0xE1, 0xE0, 0x2E	; 038008F8
	.byte 0x07, 0xD0, 0xE1, 0x2E, 0x02, 0xD0, 0xE3, 0x2E, 0x05, 0xD0, 0x1F, 0xE1, 0x01, 0x98, 0x01, 0x83	; 03800908
	.byte 0x1C, 0xE1, 0xA1, 0x83, 0x1A, 0xE1, 0xE1, 0x82, 0x18, 0xE1, 0x20, 0x1C, 0x00, 0xF0, 0x0E, 0xFC	; 03800918
	.byte 0x05, 0x90, 0x00, 0x2D, 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x01, 0x22, 0x20, 0x1C, 0x01, 0x99	; 03800928
	.byte 0x00, 0xF0, 0x6E, 0xFB, 0x00, 0x04, 0x07, 0x14, 0x01, 0x98, 0x05, 0x99, 0xFF, 0xF7, 0xBE, 0xFD	; 03800938
	.byte 0x05, 0x1C, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0x00, 0xE1, 0x00, 0x2D, 0x00, 0xD1, 0xFD, 0xE0	; 03800948
	.byte 0xB0, 0x3E, 0x0D, 0x2E, 0x00, 0xD9, 0xF9, 0xE0, 0xB0, 0x19, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 03800958
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x1D, 0x00, 0x21, 0x00, 0x2B, 0x00, 0x35, 0x00, 0x3F, 0x00	; 03800968
	.byte 0x53, 0x00, 0x6D, 0x00, 0xE7, 0x01, 0x7B, 0x00, 0xA3, 0x00, 0xC7, 0x00, 0xEB, 0x00, 0x0F, 0x01	; 03800978
	.byte 0x33, 0x01, 0x2F, 0x80, 0xE2, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xC0, 0x19, 0x28, 0x80, 0xDD, 0xE0	; 03800988
	.byte 0x00, 0x20, 0x28, 0x5E, 0xC0, 0x1B, 0x28, 0x80, 0xD8, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0x78, 0x43	; 03800998
	.byte 0x28, 0x80, 0xD3, 0xE0, 0x00, 0x2F, 0x00, 0xD1, 0xD0, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0x39, 0x1C	; 038009A8
	.byte 0xFD, 0xF7, 0x82, 0xFC, 0x28, 0x80, 0xC9, 0xE0, 0x00, 0x2F, 0x04, 0xDB, 0x00, 0x20, 0x28, 0x5E	; 038009B8
	.byte 0xB8, 0x40, 0x28, 0x80, 0xC2, 0xE0, 0x00, 0x20, 0x29, 0x5E, 0x78, 0x42, 0x01, 0x41, 0x29, 0x80	; 038009C8
	.byte 0xBC, 0xE0, 0xFE, 0xF7, 0xD1, 0xFE, 0x79, 0x1C, 0x48, 0x43, 0x00, 0x14, 0x28, 0x80, 0xB5, 0xE0	; 038009D8
	.byte 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x03, 0xD1, 0x01, 0x22, 0x02, 0xE0, 0x00, 0x00, 0x01, 0x00	; 038009E8
	.byte 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40	; 038009F8
	.byte 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0xA1, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xDB	; 03800A08
	.byte 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E	; 03800A18
	.byte 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x8F, 0xE0, 0x00, 0x20, 0x28, 0x5E	; 03800A28
	.byte 0xB8, 0x42, 0x01, 0xDD, 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43	; 03800A38
	.byte 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x7D, 0xE0	; 03800A48
	.byte 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xDC, 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78	; 03800A58
	.byte 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43	; 03800A68
	.byte 0x20, 0x70, 0x6B, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xDA, 0x01, 0x22, 0x00, 0xE0	; 03800A78
	.byte 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40	; 03800A88
	.byte 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x59, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xD0	; 03800A98
	.byte 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E	; 03800AA8
	.byte 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x47, 0xE0, 0x03, 0x98, 0x00, 0x28	; 03800AB8
	.byte 0x44, 0xD0, 0xFC, 0x3E, 0x03, 0x2E, 0x41, 0xD8, 0xB0, 0x19, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 03800AC8
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x2D, 0x00, 0x09, 0x00, 0x77, 0x00, 0x71, 0x00, 0x20, 0x1C	; 03800AD8
	.byte 0x3B, 0x30, 0x00, 0x78, 0x00, 0x28, 0x31, 0xD0, 0x21, 0x1C, 0x3B, 0x31, 0x08, 0x78, 0x40, 0x1E	; 03800AE8
	.byte 0x08, 0x70, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x80, 0x00, 0x20, 0x18, 0xC0, 0x6A, 0xA0, 0x62	; 03800AF8
	.byte 0x24, 0xE0, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x00, 0x28, 0x1F, 0xD0, 0x40, 0x1E, 0x21, 0x18	; 03800B08
	.byte 0x08, 0x1C, 0x38, 0x30, 0x00, 0x78, 0x00, 0x28, 0x0A, 0xD0, 0x40, 0x1E, 0x00, 0x06, 0x00, 0x0E	; 03800B18
	.byte 0x00, 0x28, 0x05, 0xD1, 0x21, 0x1C, 0x3B, 0x31, 0x08, 0x78, 0x40, 0x1E, 0x08, 0x70, 0x0D, 0xE0	; 03800B28
	.byte 0x38, 0x31, 0x08, 0x70, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x40, 0x1E, 0x80, 0x00, 0x20, 0x18	; 03800B38
	.byte 0xC0, 0x6A, 0xA0, 0x62, 0x02, 0xE0, 0x00, 0x20, 0xC0, 0x43, 0x09, 0xE0, 0x20, 0x6A, 0x00, 0x28	; 03800B48
	.byte 0x05, 0xD1, 0x20, 0x78, 0xC0, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x00, 0xD1, 0x13, 0xE5, 0x00, 0x20	; 03800B58
	.byte 0x09, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF0, 0xB5, 0x87, 0xB0, 0x04, 0x1C, 0x0E, 0x1C	; 03800B68
	.byte 0x17, 0x1C, 0x02, 0x93, 0x00, 0x25, 0x0C, 0x99, 0x30, 0x8B, 0x72, 0x8B, 0x50, 0x43, 0xF0, 0x22	; 03800B78
	.byte 0x51, 0x43, 0x02, 0x12, 0x50, 0x1E, 0x08, 0x18, 0x11, 0x1C, 0xFD, 0xF7, 0x95, 0xFB, 0x03, 0x90	; 03800B88
	.byte 0x20, 0x78, 0x00, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x05, 0xD0, 0xE5, 0x6B, 0x00, 0x2D, 0x02, 0xD0	; 03800B98
	.byte 0x2F, 0x72, 0x02, 0x98, 0x68, 0x72, 0x00, 0x2D, 0x4B, 0xD1, 0x30, 0x6A, 0x61, 0x88, 0x3A, 0x1C	; 03800BA8
	.byte 0x04, 0xAB, 0x00, 0xF0, 0x41, 0xFD, 0x00, 0x28, 0x7F, 0xD0, 0x04, 0xA8, 0x00, 0x78, 0x04, 0x28	; 03800BB8
	.byte 0x7B, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44, 0x00, 0x47	; 03800BC8
	.byte 0x17, 0x00, 0x0B, 0x00, 0x0F, 0x00, 0x13, 0x00, 0x0B, 0x00, 0x3A, 0x48, 0x04, 0xE0, 0x3A, 0x48	; 03800BD8
	.byte 0x02, 0xE0, 0x3A, 0x48, 0x00, 0xE0, 0x68, 0xE0, 0xE1, 0x8B, 0x08, 0x40, 0x00, 0x94, 0x32, 0x79	; 03800BE8
	.byte 0xA1, 0x7C, 0x51, 0x18, 0x22, 0x78, 0x12, 0x06, 0xD2, 0x0F, 0x35, 0x4B, 0xFF, 0xF7, 0xB8, 0xF9	; 03800BF8
	.byte 0x05, 0x1C, 0x00, 0x2D, 0x59, 0xD0, 0x20, 0x78, 0x00, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x01, 0xD0	; 03800C08
	.byte 0x00, 0x23, 0x00, 0xE0, 0x03, 0x9B, 0x30, 0x6A, 0x00, 0x90, 0x04, 0xA8, 0x01, 0x90, 0x28, 0x1C	; 03800C18
	.byte 0x39, 0x1C, 0x02, 0x9A, 0x00, 0xF0, 0xAE, 0xFC, 0x00, 0x28, 0x07, 0xD1, 0x00, 0x21, 0x28, 0x1C	; 03800C28
	.byte 0x22, 0x30, 0x01, 0x70, 0x28, 0x1C, 0xFF, 0xF7, 0x95, 0xF9, 0x3E, 0xE0, 0xE0, 0x6B, 0x28, 0x65	; 03800C38
	.byte 0xE5, 0x63, 0xA1, 0x7B, 0xFF, 0x29, 0x02, 0xD0, 0x28, 0x1C, 0xFF, 0xF7, 0x11, 0xFA, 0xE1, 0x7B	; 03800C48
	.byte 0xFF, 0x29, 0x02, 0xD0, 0x28, 0x1C, 0xFF, 0xF7, 0x01, 0xFA, 0x21, 0x7C, 0xFF, 0x29, 0x02, 0xD0	; 03800C58
	.byte 0x28, 0x1C, 0xFF, 0xF7, 0xF9, 0xF9, 0x61, 0x7C, 0xFF, 0x29, 0x02, 0xD0, 0x28, 0x1C, 0xFF, 0xF7	; 03800C68
	.byte 0xE9, 0xF9, 0x16, 0x20, 0x20, 0x5E, 0x68, 0x86, 0x20, 0x78, 0x80, 0x06, 0xC0, 0x0F, 0x00, 0x28	; 03800C78
	.byte 0x09, 0xD0, 0x29, 0x1C, 0x32, 0x31, 0x00, 0x20, 0x08, 0x5E, 0x22, 0x7D, 0xD2, 0x1B, 0x92, 0x05	; 03800C88
	.byte 0x12, 0x14, 0x80, 0x18, 0x08, 0x80, 0x60, 0x7D, 0x00, 0x28, 0x02, 0xD1, 0x03, 0x98, 0xA8, 0x61	; 03800C98
	.byte 0x09, 0xE0, 0x01, 0x1C, 0x41, 0x43, 0x32, 0x20, 0x28, 0x5E, 0x00, 0x28, 0x00, 0xDA, 0x40, 0x42	; 03800CA8
	.byte 0x41, 0x43, 0xC8, 0x12, 0xA8, 0x61, 0x00, 0x20, 0x68, 0x61, 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 03800CB8
	.byte 0x18, 0x47, 0xC0, 0x46, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x00	; 03800CC8
	.byte 0x75, 0x0D, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x24, 0x28, 0x1C, 0x21, 0x1C	; 03800CD8
	.byte 0x00, 0xF0, 0xA8, 0xF8, 0x00, 0x28, 0x02, 0xD0, 0x29, 0x1C, 0x00, 0xF0, 0x07, 0xF8, 0x64, 0x1C	; 03800CE8
	.byte 0x10, 0x2C, 0xF3, 0xDB, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03800CF4

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
	.word 0x038050DC	; 03800D70
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
	.word 0x03806654	; 03800E1C

; ===== function loc_03800E20 =====
loc_03800E20:
	mov r2,#0x0	; 03800E20
	mvn r2,r2	; 03800E22
	ldr r3,[pool_03800E28]	; 03800E24
	bx r3	; 03800E26
pool_03800E28:
loc_03800E28:
	.word 0x03800EB5	; 03800E28

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
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x24, 0x29, 0x1C, 0x1C, 0x31, 0x03, 0xE0, 0x08, 0x88	; 03800E5C
	.byte 0xF0, 0x38, 0x08, 0x80, 0x64, 0x1C, 0xA8, 0x8B, 0xF0, 0x28, 0xF8, 0xD2, 0x11, 0x48, 0x02, 0x68	; 03800E6C
	.byte 0x00, 0x2A, 0x11, 0xD0, 0x40, 0x32, 0xA9, 0x78, 0x24, 0x20, 0x41, 0x43, 0x50, 0x58, 0x00, 0x19	; 03800E7C
	.byte 0x50, 0x50, 0x09, 0xE0, 0x28, 0x1C, 0xFF, 0xF7, 0x31, 0xFB, 0x00, 0x28, 0x03, 0xD0, 0x28, 0x1C	; 03800E8C
	.byte 0xFF, 0xF7, 0x9A, 0xFF, 0x02, 0xE0, 0x64, 0x1E, 0x00, 0x2C, 0xF3, 0xDC, 0x2A, 0x8B, 0x68, 0x8B	; 03800E9C
	.byte 0x42, 0x43, 0x1C, 0x35, 0x29, 0x88, 0x10, 0x12, 0x08, 0x18, 0x28, 0x80, 0x01, 0xB0, 0x30, 0xBC	; 03800EAC
	.byte 0x08, 0xBC, 0x18, 0x47, 0xD0, 0x5E, 0x80, 0x03	; 03800EB4

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
	.word 0x03805ED0	; 03800F64

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
	push {r4,r5,r6,lr}	; 03801008
	add r4,r0,#0x0	; 0380100A
	add r6,r1,#0x0	; 0380100C
	cmp r2,#0x4	; 0380100E
	bhi loc_03801078	; 03801010
	add r1,r2,r2	; 03801012
	add r1,pc	; 03801014
	ldrh r1,[r1,#0x8]	; 03801016
	lsl r1,r1,#0x10	; 03801018
	asr r1,r1,#0x10	; 0380101A
	add r1,pc	; 0380101C
	bx r1	; 0380101E
	.byte 0x0B, 0x00, 0x13, 0x00, 0x1B, 0x00, 0x39, 0x00, 0x23, 0x00	; 0380102A
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
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xA8, 0x6A, 0x00, 0xF0, 0x46, 0xF8, 0x04, 0x1C, 0x29, 0x1C	; 038010C4
	.byte 0x28, 0x31, 0x08, 0x68, 0x40, 0x1C, 0x08, 0x60, 0xA8, 0x6A, 0x00, 0xF0, 0x3D, 0xF8, 0x00, 0x02	; 038010D4
	.byte 0x04, 0x43, 0x29, 0x1C, 0x28, 0x31, 0x08, 0x68, 0x40, 0x1C, 0x08, 0x60, 0xA8, 0x6A, 0x00, 0xF0	; 038010E4
	.byte 0x33, 0xF8, 0x00, 0x04, 0x04, 0x43, 0x28, 0x35, 0x28, 0x68, 0x40, 0x1C, 0x28, 0x60, 0x20, 0x1C	; 038010F4
	.byte 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 038010FC

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
	.word 0x03805EB8	; 03801174
pool_03801178:
loc_03801178:
	.word 0x03805EC0	; 03801178

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
	.word 0x03805EB8	; 0380119C

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
	.word 0x03806414	; 03801264

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
	.word 0x03806414	; 038012BC

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
	.word 0x03806414	; 038013E4
pool_038013E8:
loc_038013E8:
	.word 0x03805ED0	; 038013E8

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
	.word 0x03806414	; 038014B0
pool_038014B4:
loc_038014B4:
	.word 0x03806654	; 038014B4
pool_038014B8:
loc_038014B8:
	.word 0x03805ED0	; 038014B8
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x07, 0x1C, 0x00, 0x26, 0x34, 0x1C, 0x20, 0x1C, 0x24, 0x21, 0x48, 0x43	; 038014CC
	.byte 0x10, 0x49, 0x0D, 0x18, 0x08, 0x5C, 0x00, 0x28, 0x10, 0xD0, 0x00, 0x2F, 0x05, 0xD0, 0x68, 0x78	; 038014DC
	.byte 0x00, 0x28, 0x02, 0xD1, 0x28, 0x1C, 0xFF, 0xF7, 0xB3, 0xFC, 0x28, 0x1C, 0xFF, 0xF7, 0xF0, 0xFB	; 038014EC
	.byte 0x28, 0x78, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20, 0xA0, 0x40, 0x06, 0x43, 0x64, 0x1C, 0x10, 0x2C	; 038014FC
	.byte 0xE3, 0xDB, 0x05, 0x48, 0x00, 0x68, 0x00, 0x28, 0x00, 0xD0, 0x46, 0x60, 0x01, 0xB0, 0xF0, 0xBC	; 0380150C
	.byte 0x08, 0xBC, 0x18, 0x47, 0x14, 0x64, 0x80, 0x03, 0xD0, 0x5E, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0	; 0380151C
	.byte 0x00, 0x25, 0x0C, 0x4B, 0x28, 0x1C, 0x24, 0x21, 0x2A, 0x1C, 0x4A, 0x43, 0x9C, 0x18, 0x98, 0x54	; 0380152C
	.byte 0xA5, 0x70, 0x6D, 0x1C, 0x10, 0x2D, 0xF7, 0xDB, 0x07, 0x4C, 0x01, 0x21, 0x83, 0x01, 0xE2, 0x5C	; 0380153C
	.byte 0x8A, 0x43, 0xE2, 0x54, 0x40, 0x1C, 0x20, 0x28, 0xF8, 0xDB, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 0380154C
	.byte 0x18, 0x47, 0xC0, 0x46, 0x14, 0x64, 0x80, 0x03, 0x54, 0x66, 0x80, 0x03	; 03801558

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
	add r2,pc	; 03801592
	ldrh r2,[r2,#0x8]	; 03801594
	lsl r2,r2,#0x10	; 03801596
	asr r2,r2,#0x10	; 03801598
	add r2,pc	; 0380159A
	bx r2	; 0380159C
	.byte 0x4D, 0x00, 0x0B, 0x00, 0x3B, 0x00, 0x45, 0x00, 0x0B, 0x00	; 038015A8
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
	.byte 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0, 0x04, 0x1C, 0x18, 0x1C, 0x00, 0x29, 0x01, 0xDA, 0x00, 0x20	; 0380163E
	.byte 0x60, 0xE0, 0xA3, 0x6B, 0x99, 0x42, 0x01, 0xD3, 0x00, 0x20, 0x5B, 0xE0, 0x89, 0x00, 0x61, 0x18	; 0380164E
	.byte 0xCB, 0x6B, 0x03, 0x70, 0x01, 0x78, 0x10, 0x29, 0x0F, 0xDC, 0x10, 0x29, 0x1C, 0xDA, 0x04, 0x29	; 0380165E
	.byte 0x4D, 0xD8, 0x4D, 0x18, 0x7D, 0x44, 0x2D, 0x89, 0x2D, 0x04, 0x2D, 0x14, 0x7D, 0x44, 0x28, 0x47	; 0380166E
	.byte 0x8F, 0x00, 0x11, 0x00, 0x11, 0x00, 0x11, 0x00, 0x11, 0x00, 0x11, 0x29, 0x26, 0xD0, 0x3E, 0xE0	; 0380167E
	.byte 0x19, 0x0A, 0x63, 0x18, 0x82, 0x1C, 0x05, 0x21, 0x18, 0x88, 0x9B, 0x1C, 0x10, 0x80, 0x92, 0x1C	; 0380168E
	.byte 0x49, 0x1E, 0x00, 0x29, 0xF8, 0xD1, 0x34, 0xE0, 0x1B, 0x0A, 0xE1, 0x18, 0x4D, 0x78, 0xE3, 0x5C	; 0380169E
	.byte 0x9A, 0x42, 0x01, 0xDA, 0x00, 0x20, 0x2D, 0xE0, 0xAA, 0x42, 0x01, 0xDD, 0x00, 0x20, 0x29, 0xE0	; 038016AE
	.byte 0xD3, 0x1A, 0x0C, 0x22, 0x53, 0x43, 0xC9, 0x18, 0x8B, 0x1C, 0x06, 0x22, 0x19, 0x88, 0x9B, 0x1C	; 038016BE
	.byte 0x01, 0x80, 0x80, 0x1C, 0x52, 0x1E, 0x00, 0x2A, 0xF8, 0xD1, 0x1A, 0xE0, 0x00, 0x21, 0x1B, 0x0A	; 038016CE
	.byte 0xE4, 0x18, 0x04, 0xE0, 0x49, 0x1C, 0x08, 0x29, 0x01, 0xDB, 0x00, 0x20, 0x12, 0xE0, 0x63, 0x5C	; 038016DE
	.byte 0x9A, 0x42, 0xF7, 0xDC, 0x0C, 0x22, 0x51, 0x43, 0x63, 0x18, 0x08, 0x33, 0x06, 0x22, 0x19, 0x88	; 038016EE
	.byte 0x9B, 0x1C, 0x01, 0x80, 0x80, 0x1C, 0x52, 0x1E, 0x00, 0x2A, 0xF8, 0xD1, 0x01, 0xE0, 0x00, 0x20	; 038016FE
	.byte 0x00, 0xE0, 0x01, 0x20, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 0380170C

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
	.word 0x03805ED0	; 03801770

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
	.word 0x03805ED0	; 03801784
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
	.word 0x03805ED0	; 038017A4

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
	.word 0x03806E54	; 038017EC

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
	.word 0x03806E54	; 0380187C
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
	.word 0x03806E54	; 038018C4
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x00, 0x25, 0x07, 0x4C, 0x2A, 0x1C, 0x07, 0x48, 0x07, 0x49, 0xAB, 0x01	; 038018D8
	.byte 0xE3, 0x18, 0x1A, 0x54, 0x5A, 0x54, 0x6D, 0x1C, 0x08, 0x2D, 0xF8, 0xDB, 0x01, 0xB0, 0x30, 0xBC	; 038018E8
	.byte 0x08, 0xBC, 0x18, 0x47, 0xD4, 0x5E, 0x80, 0x03, 0x80, 0x0F, 0x00, 0x00, 0x81, 0x0F, 0x00, 0x00	; 038018F8

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
	.word 0x04000508	; 0380197C
pool_03801980:
loc_03801980:
	.word 0x04000509	; 03801980

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
	.word 0x04000508	; 03801A30
pool_03801A34:
loc_03801A34:
	.word 0x00008080	; 03801A34
pool_03801A38:
loc_03801A38:
	.word 0x04000509	; 03801A38

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
	.word 0x03801F75	; 03801AE8

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
	add r0,pc	; 03801B50
	ldrh r0,[r0,#0x8]	; 03801B52
	lsl r0,r0,#0x10	; 03801B54
	asr r0,r0,#0x10	; 03801B56
	add r0,pc	; 03801B58
	bx r0	; 03801B5A
	.byte 0x3D, 0x00, 0x4B, 0x00, 0x53, 0x00, 0x5D, 0x00, 0x6B, 0x00, 0x85, 0x00, 0x91, 0x00, 0x9D, 0x00	; 03801B6C
	.byte 0xAD, 0x00, 0xBB, 0x00, 0xC9, 0x00, 0x33, 0x01, 0x7F, 0x01, 0xA1, 0x01, 0xD7, 0x00, 0xFD, 0x00	; 03801B7C
	.byte 0x13, 0x01, 0x1D, 0x01, 0x29, 0x01, 0xC3, 0x01, 0xCB, 0x01, 0xD3, 0x01, 0xE1, 0x01, 0xEB, 0x01	; 03801B8C
	.byte 0xF5, 0x01, 0x1D, 0x02, 0x25, 0x02, 0xFF, 0x01, 0x09, 0x02, 0x13, 0x02	; 03801B98
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
	.word 0x03805ED0	; 03801DC4
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
	.word 0x037FF320	; 03801DDC
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
	.word 0x03805ED0	; 03801E08

; ===== function loc_03801E0C =====
loc_03801E0C:
	ldr r3,[pool_03801E10]	; 03801E0C
	bx r3	; 03801E0E
pool_03801E10:
loc_03801E10:
	.word 0x03801FC5	; 03801E10

; ===== function loc_03801E14 =====
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
	.word 0x04000184	; 03801ED0
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
	.word 0x04100000	; 03801EE0
pool_03801EE4:
loc_03801EE4:
	.word 0x0380708C	; 03801EE4
pool_03801EE8:
loc_03801EE8:
	.word 0x04000188	; 03801EE8

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
	.word 0x04000184	; 03801F64
pool_03801F68:
loc_03801F68:
	.word 0x00004000	; 03801F68
pool_03801F6C:
loc_03801F6C:
	.word 0x0000C000	; 03801F6C
pool_03801F70:
loc_03801F70:
	.word 0x04000188	; 03801F70

; ===== function loc_03801F74 =====
loc_03801F74:
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
pool_03801FB8:
loc_03801FB8:
	.word 0x0380708C	; 03801FB8
pool_03801FBC:
loc_03801FBC:
	.word 0x027FFC00	; 03801FBC
pool_03801FC0:
loc_03801FC0:
	.word 0x0000038C	; 03801FC0

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
	cmp r3,#0x20	; 03801FEC
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
	.word 0x03807088	; 03802038
pool_0380203C:
loc_0380203C:
	.word 0x027FFC00	; 0380203C
pool_03802040:
loc_03802040:
	.word 0x0000038C	; 03802040
pool_03802044:
loc_03802044:
	.word 0x0380708C	; 03802044
pool_03802048:
loc_03802048:
	.word 0x00040000	; 03802048
pool_0380204C:
loc_0380204C:
	.word 0x03801E15	; 0380204C
pool_03802050:
loc_03802050:
	.word 0x0000C408	; 03802050
pool_03802054:
loc_03802054:
	.word 0x04000184	; 03802054
pool_03802058:
loc_03802058:
	.word 0x04000180	; 03802058
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
	.word 0x04000136	; 03802090
pool_03802094:
loc_03802094:
	.word 0x027FFFA8	; 03802094

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
	.word 0x0380710C	; 038020F0
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
	.word 0x03802115	; 03802110
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
	.word 0x04000134	; 03802124

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
	.word 0x037FDEC1	; 03802184

; ===== function loc_03802188 =====
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
	add r1,pc	; 03802266
	ldrh r1,[r1,#0x8]	; 03802268
	lsl r1,r1,#0x10	; 0380226A
	asr r1,r1,#0x10	; 0380226C
	add r1,pc	; 0380226E
	bx r1	; 03802270
	.byte 0x65, 0x00, 0x87, 0x00, 0xA9, 0x00, 0xBB, 0x00, 0xCD, 0x00, 0xDF, 0x00, 0x8F, 0x01, 0x8F, 0x01	; 03802282
	.byte 0x8F, 0x01, 0x8F, 0x01, 0x8F, 0x01, 0x8F, 0x01, 0xF1, 0x00, 0x8F, 0x01, 0x8F, 0x01, 0x8F, 0x01	; 03802292
	.byte 0x03, 0x01, 0x25, 0x01, 0x47, 0x01, 0x59, 0x01, 0x6B, 0x01, 0x7D, 0x01	; 0380229E
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
	.word 0x03801EED	; 0380243C
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
	add r0,pc	; 03802472
	ldrh r0,[r0,#0x8]	; 03802474
	lsl r0,r0,#0x10	; 03802476
	asr r0,r0,#0x10	; 03802478
	add r0,pc	; 0380247A
	bx r0	; 0380247C
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x5D, 0x00, 0x5D, 0x00	; 0380248E
	.byte 0x5D, 0x00, 0x5D, 0x00, 0x5D, 0x00, 0x5D, 0x00, 0x2D, 0x00, 0x5D, 0x00, 0x5D, 0x00, 0x5D, 0x00	; 0380249E
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00	; 038024AA
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
	.word 0x038072C0	; 038024EC
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
	bl loc_03801F74	; 03802516
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
	bl loc_037FDF88	; 03802532
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
	bl loc_037FDF88	; 03802550
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
	.word 0x0380713C	; 03802590
pool_03802594:
loc_03802594:
	.word 0x038072C0	; 03802594
pool_03802598:
loc_03802598:
	.word 0x03802441	; 03802598
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
	.word 0x03802225	; 038025AC
pool_038025B0:
loc_038025B0:
	.word 0x038072DC	; 038025B0
pool_038025B4:
loc_038025B4:
	.word 0x03807340	; 038025B4
pool_038025B8:
loc_038025B8:
	.word 0x038072E4	; 038025B8
pool_038025BC:
loc_038025BC:
	.word 0x03802189	; 038025BC
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
	.word 0x03802AB0	; 03802614
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
	.word 0x03802B24	; 03802620
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
	.word 0x03802C24	; 0380262C
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
	.word 0x03802B94	; 03802638
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
	.word 0x03802AF0	; 03802644
.thumb

; ===== function loc_03802648 =====
loc_03802648:
	ldr r1,[r0,#0x0]	; 03802648
	lsl r2,r1,#0x12	; 0380264A
	lsr r2,r2,#0x1a	; 0380264C
	cmp r2,#0x23	; 0380264E
	bhi loc_038026E4	; 03802650
	add r3,r2,r2	; 03802652
	add r3,pc	; 03802654
	ldrh r3,[r3,#0x8]	; 03802656
	lsl r3,r3,#0x10	; 03802658
	asr r3,r3,#0x10	; 0380265A
	add r3,pc	; 0380265C
	bx r3	; 0380265E
	.byte 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00	; 03802670
	.byte 0x63, 0x00, 0x63, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00	; 03802680
	.byte 0x49, 0x00, 0x49, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00	; 03802690
	.byte 0x7D, 0x00, 0x7D, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00	; 038026A0
	.byte 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00	; 038026A8
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
	add r2,pc	; 03802710
	ldrh r2,[r2,#0x8]	; 03802712
	lsl r2,r2,#0x10	; 03802714
	asr r2,r2,#0x10	; 03802716
	add r2,pc	; 03802718
	bx r2	; 0380271A
	.byte 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00	; 0380272C
	.byte 0x49, 0x00, 0x49, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00	; 0380273C
	.byte 0x49, 0x00, 0x49, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00	; 0380274C
	.byte 0x51, 0x00, 0x51, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00	; 0380275C
	.byte 0x71, 0x00, 0x71, 0x00, 0x51, 0x00, 0x51, 0x00	; 03802764
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
	.byte 0x00, 0x00, 0x70, 0xB5, 0x82, 0xB0, 0x0C, 0x4D, 0x00, 0xAC, 0x01, 0x26, 0x28, 0x1C, 0x21, 0x1C	; 03802D1E
	.byte 0x32, 0x1C, 0xFB, 0xF7, 0x90, 0xFA, 0x00, 0x98, 0x01, 0x68, 0x00, 0x29, 0x04, 0xD0, 0x01, 0x29	; 03802D2E
	.byte 0x08, 0xD0, 0x03, 0x29, 0x03, 0xD0, 0xF1, 0xE7, 0x00, 0xF0, 0xAF, 0xF9, 0xEE, 0xE7, 0x01, 0xF0	; 03802D3E
	.byte 0xF2, 0xF9, 0xEB, 0xE7, 0x00, 0xF0, 0x07, 0xFE, 0xE8, 0xE7, 0x10, 0x77, 0x80, 0x03	; 03802D4C

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
	.word 0x03807890	; 03802DDC
pool_03802DE0:
loc_03802DE0:
	.word 0x03807764	; 03802DE0
pool_03802DE4:
loc_03802DE4:
	.word 0x03807768	; 03802DE4
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
	.word 0x03807490	; 03802E14
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
	.word 0x03807490	; 03802E28
	.byte 0x03, 0x48, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD1, 0x01, 0x20, 0x70, 0x47, 0x00, 0x20, 0x70, 0x47	; 03802E3C
	.byte 0x90, 0x74, 0x80, 0x03	; 03802E40

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
	.word 0x03807490	; 03802EE8
pool_03802EEC:
loc_03802EEC:
	.word 0x03807890	; 03802EEC
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
	.word 0x03807890	; 03802F38

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
	bl loc_03801F74	; 03802F6C
	mov r0,#0x8	; 03802F70
	ldr r1,[pool_03802FD8]	; 03802F72
	bl loc_03801F74	; 03802F74
	mov r0,#0x4	; 03802F78
	ldr r1,[pool_03802FD8]	; 03802F7A
	bl loc_03801F74	; 03802F7C
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
	bl loc_037FDF88	; 03802FBC
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
	.word 0x0380748C	; 03802FD0
pool_03802FD4:
loc_03802FD4:
	.word 0x03807490	; 03802FD4
pool_03802FD8:
loc_03802FD8:
	.word 0x03802CDD	; 03802FD8
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
	.word 0x03807890	; 03802FE8
pool_03802FEC:
loc_03802FEC:
	.word 0x038078D0	; 03802FEC
pool_03802FF0:
loc_03802FF0:
	.word 0x00000200	; 03802FF0
pool_03802FF4:
loc_03802FF4:
	.word 0x03807498	; 03802FF4
pool_03802FF8:
loc_03802FF8:
	.word 0x03802D11	; 03802FF8

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
	.word 0x037FF384	; 03803004
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
	.word 0x038078F0	; 0380303C

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
	.word 0x027FFFAA	; 03803090
pool_03803094:
loc_03803094:
	.word 0x027FFFAC	; 03803094
	.byte 0xF0, 0xB5, 0x83, 0xB0, 0x05, 0x1C, 0x69, 0x68, 0x02, 0x29, 0x06, 0xD8, 0x00, 0x29, 0x0C, 0xD0	; 038030A8
	.byte 0x01, 0x29, 0x45, 0xD0, 0x02, 0x29, 0x7A, 0xD0, 0x8F, 0xE0, 0x10, 0x29, 0x00, 0xD0, 0x8C, 0xE0	; 038030B8
	.byte 0x48, 0x48, 0x00, 0x6A, 0x02, 0x28, 0x00, 0xD0, 0x87, 0xE0, 0xFA, 0xF7, 0xEB, 0xFD, 0x04, 0x1C	; 038030C8
	.byte 0x00, 0x20, 0xFF, 0xF7, 0xAF, 0xFE, 0x00, 0x28, 0x09, 0xD1, 0x20, 0x1C, 0xFA, 0xF7, 0xF4, 0xFD	; 038030D8
	.byte 0x68, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x21, 0xFF, 0xF7, 0xAE, 0xFE, 0x75, 0xE0, 0x00, 0x20	; 038030E8
	.byte 0xFF, 0xF7, 0x98, 0xFE, 0x20, 0x1C, 0xFA, 0xF7, 0xE7, 0xFD, 0x01, 0xA8, 0x39, 0x4A, 0x91, 0x6A	; 038030F8
	.byte 0x52, 0x6A, 0x00, 0xF0, 0x8F, 0xF9, 0x01, 0xA8, 0x02, 0x88, 0x37, 0x49, 0x0A, 0x80, 0x41, 0x88	; 03803108
	.byte 0x36, 0x48, 0x01, 0x80, 0x68, 0x68, 0x00, 0x28, 0x05, 0xD1, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x21	; 03803118
	.byte 0xFF, 0xF7, 0x92, 0xFE, 0x08, 0xE0, 0x00, 0x04, 0x00, 0x0C, 0xAA, 0x68, 0xFF, 0x21, 0x0A, 0x40	; 03803128
	.byte 0x11, 0x04, 0x09, 0x0C, 0xFF, 0xF7, 0x88, 0xFE, 0x00, 0x20, 0xFF, 0xF7, 0x5F, 0xFE, 0x4C, 0xE0	; 03803138
	.byte 0x28, 0x48, 0x00, 0x6A, 0x01, 0x28, 0x2C, 0xD1, 0x00, 0x24, 0x27, 0x1C, 0x1C, 0xE0, 0x62, 0x00	; 03803148
	.byte 0x24, 0x48, 0x86, 0x18, 0x20, 0x1C, 0x26, 0x4A, 0x50, 0x43, 0x00, 0xF0, 0x51, 0xF8, 0xE9, 0x68	; 03803158
	.byte 0x08, 0x18, 0x23, 0x49, 0x00, 0xF0, 0x4C, 0xF8, 0x30, 0x1C, 0xCC, 0x30, 0x01, 0x80, 0x00, 0x94	; 03803168
	.byte 0x21, 0x1C, 0x28, 0x20, 0x41, 0x43, 0x1F, 0x48, 0x40, 0x18, 0xCC, 0x21, 0x71, 0x5E, 0x3A, 0x1C	; 03803178
	.byte 0x1D, 0x4B, 0xFB, 0xF7, 0xBD, 0xFE, 0x64, 0x1C, 0xA9, 0x68, 0x8C, 0x42, 0xDF, 0xD3, 0x68, 0x68	; 03803188
	.byte 0x00, 0x04, 0x00, 0x0C, 0x00, 0x21, 0xFF, 0xF7, 0x57, 0xFE, 0x02, 0x21, 0x11, 0x48, 0x01, 0x62	; 03803198
	.byte 0x1B, 0xE0, 0x08, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x4E, 0xFE, 0x15, 0xE0, 0x0D, 0x48	; 038031A8
	.byte 0x00, 0x6A, 0x03, 0x28, 0x0C, 0xD1, 0x11, 0x48, 0xFB, 0xF7, 0x28, 0xFE, 0x68, 0x68, 0x00, 0x04	; 038031B8
	.byte 0x00, 0x0C, 0x00, 0x21, 0xFF, 0xF7, 0x40, 0xFE, 0x00, 0x21, 0x06, 0x48, 0x01, 0x62, 0x04, 0xE0	; 038031C8
	.byte 0x08, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x37, 0xFE, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 038031D8
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF0, 0x78, 0x80, 0x03, 0xAA, 0xFF, 0x7F, 0x02, 0xAC, 0xFF, 0x7F, 0x02	; 038031E8
	.byte 0x07, 0x01, 0x00, 0x00, 0x1C, 0x79, 0x80, 0x03, 0x41, 0x30, 0x80, 0x03, 0x41, 0x56, 0x50, 0x54	; 038031F8

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
	.word 0x03804D6C	; 03803200
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
	add r2,pc	; 0380324A
	ldrh r2,[r2,#0x8]	; 0380324C
	lsl r2,r2,#0x10	; 0380324E
	asr r2,r2,#0x10	; 03803250
	add r2,pc	; 03803252
	bx r2	; 03803254
	.byte 0x19, 0x00, 0x31, 0x00, 0x8F, 0x00, 0x09, 0x00	; 0380325E
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
	.word 0x038078F0	; 03803328
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
	.word 0x038078F0	; 03803400
pool_03803404:
loc_03803404:
	.word 0x0380791C	; 03803404
pool_03803408:
loc_03803408:
	.word 0x54505641	; 03803408
pool_0380340C:
loc_0380340C:
	.word 0x040001C0	; 0380340C
pool_03803410:
loc_03803410:
	.word 0x00008A01	; 03803410
pool_03803414:
loc_03803414:
	.word 0x040001C2	; 03803414
pool_03803418:
loc_03803418:
	.word 0x00008201	; 03803418

; ===== function loc_0380341C =====
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
	.word 0x038079C4	; 03803598
pool_0380359C:
loc_0380359C:
	.word 0x00000FFF	; 0380359C
pool_038035A0:
loc_038035A0:
	.word 0x04000000	; 038035A0
pool_038035A4:
loc_038035A4:
	.word 0x00008A01	; 038035A4
pool_038035A8:
loc_038035A8:
	.word 0x040001C0	; 038035A8
pool_038035AC:
loc_038035AC:
	.word 0x040001C2	; 038035AC
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
	.word 0x040001C0	; 038037BC
pool_038037C0:
loc_038037C0:
	.word 0x00008A01	; 038037C0
pool_038037C4:
loc_038037C4:
	.word 0x040001C2	; 038037C4
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
	.word 0x040001C0	; 038038F0
pool_038038F4:
loc_038038F4:
	.word 0x00008A01	; 038038F4
pool_038038F8:
loc_038038F8:
	.word 0x040001C2	; 038038F8
pool_038038FC:
loc_038038FC:
	.word 0x00008201	; 038038FC
pool_03803900:
loc_03803900:
	.word 0x038079C4	; 03803900
pool_03803904:
loc_03803904:
	.word 0x04000136	; 03803904
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xA8, 0x00, 0xF0, 0x7D, 0xFB, 0x00, 0xA8, 0x02, 0x88, 0x01, 0x20	; 03803918
	.byte 0x11, 0x1C, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0x20, 0x04, 0xE0, 0x02, 0x21, 0x0A, 0x40	; 03803928
	.byte 0x00, 0x2A, 0x00, 0xD1, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xB5, 0x81, 0xB0	; 03803938
	.byte 0x00, 0xA8, 0x00, 0xF0, 0x67, 0xFB, 0x00, 0xA8, 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 03803948
	.byte 0x00, 0xD0, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0	; 03803958
	.byte 0x04, 0x1C, 0xFA, 0xF7, 0x9F, 0xF9, 0x05, 0x1C, 0x01, 0x20, 0xFF, 0xF7, 0x63, 0xFA, 0x00, 0x28	; 03803968
	.byte 0x09, 0xD1, 0x28, 0x1C, 0xFA, 0xF7, 0xA8, 0xF9, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x21	; 03803978
	.byte 0xFF, 0xF7, 0x62, 0xFA, 0x8F, 0xE0, 0x01, 0x20, 0xFF, 0xF7, 0x4C, 0xFA, 0x28, 0x1C, 0xFA, 0xF7	; 03803988
	.byte 0x9B, 0xF9, 0x60, 0x68, 0x20, 0x38, 0x0D, 0x28, 0x72, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89	; 03803998
	.byte 0x00, 0x04, 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x1D, 0x00, 0x23, 0x00, 0x29, 0x00, 0x31, 0x00	; 038039A8
	.byte 0xD9, 0x00, 0x59, 0x00, 0xD9, 0x00, 0x85, 0x00, 0xD9, 0x00, 0xD9, 0x00, 0xD9, 0x00, 0xA9, 0x00	; 038039B8
	.byte 0xCB, 0x00, 0xD3, 0x00, 0x00, 0xF0, 0x8C, 0xFB, 0x64, 0xE0, 0x00, 0xF0, 0x63, 0xFB, 0x61, 0xE0	; 038039C8
	.byte 0x20, 0x69, 0x00, 0xF0, 0x1F, 0xFB, 0x5D, 0xE0, 0xFF, 0xF7, 0xB0, 0xFF, 0x00, 0x28, 0x09, 0xD1	; 038039D8
	.byte 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x2E, 0xFA, 0x01, 0x20, 0xFF, 0xF7	; 038039E8
	.byte 0x05, 0xFA, 0x58, 0xE0, 0xA0, 0x68, 0xE1, 0x68, 0x22, 0x69, 0x00, 0xF0, 0x8D, 0xFA, 0x49, 0xE0	; 038039F8
	.byte 0xFF, 0xF7, 0x86, 0xFF, 0x00, 0x28, 0x09, 0xD1, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21	; 03803A08
	.byte 0xFF, 0xF7, 0x1A, 0xFA, 0x01, 0x20, 0xFF, 0xF7, 0xF1, 0xF9, 0x44, 0xE0, 0xA0, 0x68, 0xE1, 0x68	; 03803A18
	.byte 0x09, 0x04, 0x09, 0x0C, 0x22, 0x69, 0x00, 0xF0, 0xF1, 0xF9, 0x33, 0xE0, 0xFF, 0xF7, 0x70, 0xFF	; 03803A28
	.byte 0x00, 0x28, 0x09, 0xD1, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x04, 0xFA	; 03803A38
	.byte 0x01, 0x20, 0xFF, 0xF7, 0xDB, 0xF9, 0x2E, 0xE0, 0xA0, 0x68, 0x00, 0xF0, 0x77, 0xF9, 0x21, 0xE0	; 03803A48
	.byte 0xFF, 0xF7, 0x5E, 0xFF, 0x00, 0x28, 0x09, 0xD1, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21	; 03803A58
	.byte 0xFF, 0xF7, 0xF2, 0xF9, 0x01, 0x20, 0xFF, 0xF7, 0xC9, 0xF9, 0x1C, 0xE0, 0x00, 0xF0, 0x40, 0xF9	; 03803A68
	.byte 0x10, 0xE0, 0x20, 0x69, 0x00, 0xF0, 0xEA, 0xF8, 0x0C, 0xE0, 0x00, 0xF0, 0xC1, 0xF8, 0x09, 0xE0	; 03803A78
	.byte 0x01, 0x20, 0xFF, 0xF7, 0xBB, 0xF9, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x01, 0x21, 0xFF, 0xF7	; 03803A88
	.byte 0xDB, 0xF9, 0x08, 0xE0, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x21, 0xFF, 0xF7, 0xD4, 0xF9	; 03803A98
	.byte 0x01, 0x20, 0xFF, 0xF7, 0xAB, 0xF9, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 03803AA8

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
	add r5,pc	; 03803AF2
	ldrh r5,[r5,#0x8]	; 03803AF4
	lsl r5,r5,#0x10	; 03803AF6
	asr r5,r5,#0x10	; 03803AF8
	add r5,pc	; 03803AFA
	bx r5	; 03803AFC
	.byte 0x17, 0x00, 0x41, 0x00, 0xA9, 0x00, 0x73, 0x00, 0xA9, 0x00, 0x9F, 0x00, 0xA9, 0x00, 0xA9, 0x00	; 03803B0E
	.byte 0xA9, 0x00, 0xA9, 0x00, 0x17, 0x00	; 03803B14
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
	.word 0x038079C8	; 03803BCC
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
	.word 0x038079C8	; 03803BF4
	.byte 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0x44, 0xFE	; 03803C08
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0xFF, 0x21, 0x0A, 0x48	; 03803C18
	.byte 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0x34, 0xFE	; 03803C28
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03803C38
	.byte 0xC0, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0xF0, 0xB5, 0x81, 0xB0	; 03803C48
	.byte 0x05, 0x1C, 0x01, 0x27, 0x22, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0, 0x1C, 0xFE	; 03803C58
	.byte 0x20, 0x88, 0x30, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x1E, 0x48, 0x20, 0x80, 0x9F, 0x21, 0x1E, 0x48	; 03803C68
	.byte 0x01, 0x80, 0x01, 0x27, 0x1A, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0, 0x0C, 0xFE	; 03803C78
	.byte 0x20, 0x88, 0x30, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x00, 0x21, 0x17, 0x48, 0x01, 0x80, 0x01, 0x27	; 03803C88
	.byte 0x13, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0, 0xFE, 0xFD, 0x20, 0x88, 0x30, 0x40	; 03803C98
	.byte 0x00, 0x28, 0xF8, 0xD1, 0x10, 0x49, 0x0A, 0x88, 0xFF, 0x20, 0x02, 0x40, 0x2A, 0x70, 0x0F, 0x48	; 03803CA8
	.byte 0x20, 0x80, 0x00, 0x20, 0x08, 0x80, 0x01, 0x27, 0x09, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C	; 03803CB8
	.byte 0x00, 0xF0, 0xEA, 0xFD, 0x20, 0x88, 0x30, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x06, 0x48, 0x01, 0x88	; 03803CC8
	.byte 0xFF, 0x20, 0x01, 0x40, 0x69, 0x70, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03803CD8
	.byte 0xC0, 0x01, 0x00, 0x04, 0x00, 0x89, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00	; 03803CE8
	.byte 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xCC, 0xFD	; 03803CF8
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0xC7, 0x21, 0x0A, 0x48	; 03803D08
	.byte 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xBC, 0xFD	; 03803D18
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03803D28
	.byte 0xC0, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0xF0, 0xB5, 0x81, 0xB0	; 03803D38
	.byte 0x2C, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x11, 0x0C, 0x09, 0x04, 0x0D, 0x0C, 0x2A, 0x49, 0x02, 0x1C	; 03803D48
	.byte 0x0A, 0x40, 0x11, 0x02, 0x0C, 0x0C, 0xFF, 0x21, 0x08, 0x40, 0x00, 0x04, 0x06, 0x0C, 0x27, 0x4F	; 03803D58
	.byte 0x02, 0xE0, 0x01, 0x20, 0x00, 0xF0, 0x98, 0xFD, 0x39, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29	; 03803D68
	.byte 0xF7, 0xD1, 0x23, 0x48, 0x38, 0x80, 0xDB, 0x21, 0x22, 0x48, 0x01, 0x80, 0x1F, 0x4F, 0x02, 0xE0	; 03803D78
	.byte 0x01, 0x20, 0x00, 0xF0, 0x89, 0xFD, 0x39, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29, 0xF7, 0xD1	; 03803D88
	.byte 0xFF, 0x20, 0x05, 0x40, 0x1B, 0x48, 0x05, 0x80, 0x18, 0x4D, 0x80, 0x27, 0x02, 0xE0, 0x01, 0x20	; 03803D98
	.byte 0x00, 0xF0, 0x7A, 0xFD, 0x28, 0x88, 0x38, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0xFF, 0x20, 0x04, 0x40	; 03803DA8
	.byte 0x14, 0x48, 0x04, 0x80, 0x01, 0x27, 0x11, 0x4C, 0x80, 0x25, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0	; 03803DB8
	.byte 0x6B, 0xFD, 0x20, 0x88, 0x28, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0F, 0x48, 0x20, 0x80, 0xFF, 0x20	; 03803DC8
	.byte 0x06, 0x40, 0x0C, 0x48, 0x06, 0x80, 0x01, 0x26, 0x08, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C	; 03803DD8
	.byte 0x00, 0xF0, 0x5A, 0xFD, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x01, 0xB0, 0xF0, 0xBC	; 03803DE8
	.byte 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xC0, 0x01, 0x00, 0x04	; 03803DF8
	.byte 0x00, 0x89, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xF0, 0xB5, 0x83, 0xB0	; 03803E08
	.byte 0x0C, 0x1C, 0x16, 0x1C, 0x01, 0x2C, 0x6D, 0xD3, 0x01, 0x19, 0x49, 0x1E, 0x0A, 0x0A, 0x01, 0x0A	; 03803E18
	.byte 0x8A, 0x42, 0x06, 0xD9, 0xFF, 0x21, 0x02, 0x1C, 0x0A, 0x40, 0x34, 0x49, 0x89, 0x1A, 0x09, 0x04	; 03803E28
	.byte 0x0C, 0x0C, 0x33, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x11, 0x0C, 0x00, 0xAA, 0x11, 0x80, 0x31, 0x49	; 03803E38
	.byte 0x03, 0x1C, 0x0B, 0x40, 0x19, 0x0A, 0x51, 0x80, 0xFF, 0x21, 0x08, 0x40, 0x90, 0x80, 0x2E, 0x4D	; 03803E48
	.byte 0x80, 0x27, 0x02, 0xE0, 0x01, 0x20, 0x00, 0xF0, 0x1F, 0xFD, 0x28, 0x88, 0x38, 0x40, 0x00, 0x28	; 03803E58
	.byte 0xF8, 0xD1, 0x2A, 0x48, 0x28, 0x80, 0x0A, 0x20, 0x29, 0x4F, 0x38, 0x80, 0x00, 0x25, 0x0F, 0xE0	; 03803E68
	.byte 0x01, 0x20, 0x00, 0xF0, 0x11, 0xFD, 0x24, 0x48, 0x01, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29	; 03803E78
	.byte 0xF6, 0xD1, 0x69, 0x00, 0x00, 0xA8, 0x41, 0x5A, 0xFF, 0x20, 0x01, 0x40, 0x39, 0x80, 0x6D, 0x1C	; 03803E88
	.byte 0x03, 0x2D, 0xF0, 0xDB, 0x00, 0x25, 0x64, 0x1E, 0x1B, 0x4F, 0x0D, 0xE0, 0x01, 0x20, 0x00, 0xF0	; 03803E98
	.byte 0xFB, 0xFC, 0x39, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29, 0xF7, 0xD1, 0x71, 0x5D, 0xFF, 0x20	; 03803EA8
	.byte 0x01, 0x40, 0x17, 0x48, 0x01, 0x80, 0x6D, 0x1C, 0xA5, 0x42, 0xF2, 0xDB, 0x12, 0x4C, 0x80, 0x27	; 03803EB8
	.byte 0x02, 0xE0, 0x01, 0x20, 0x00, 0xF0, 0xE8, 0xFC, 0x20, 0x88, 0x38, 0x40, 0x00, 0x28, 0xF8, 0xD1	; 03803EC8
	.byte 0x10, 0x48, 0x20, 0x80, 0x71, 0x5D, 0xFF, 0x20, 0x01, 0x40, 0x0D, 0x48, 0x01, 0x80, 0x01, 0x26	; 03803ED8
	.byte 0x09, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xD6, 0xFC, 0x28, 0x88, 0x20, 0x40	; 03803EE8
	.byte 0x00, 0x28, 0xF8, 0xD1, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x01, 0x00, 0x00	; 03803EF8
	.byte 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xC0, 0x01, 0x00, 0x04, 0x00, 0x89, 0x00, 0x00	; 03803F08
	.byte 0xC2, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00	; 03803F10

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
	.word 0x040001C0	; 03803FFC
pool_03804000:
loc_03804000:
	.word 0x00008900	; 03804000
pool_03804004:
loc_03804004:
	.word 0x040001C2	; 03804004
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
	.word 0x040001C0	; 0380407C
pool_03804080:
loc_03804080:
	.word 0x00008900	; 03804080
pool_03804084:
loc_03804084:
	.word 0x040001C2	; 03804084
pool_03804088:
loc_03804088:
	.word 0x00008100	; 03804088
	.byte 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xFA, 0xFB	; 0380409C
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0x04, 0x21, 0x0A, 0x48	; 038040AC
	.byte 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0	; 038040BA
loc_038040BA:
	.byte 0xEA, 0xFB, 0x28, 0x88	; 038040BA
	.byte 0x20, 0x40, 0x00, 0x28	; 038040BE
	.byte 0xF8, 0xD1, 0x70, 0xBC	; 038040C2
	.byte 0x08, 0xBC, 0x18, 0x47	; 038040C6
	.byte 0xC0, 0x46, 0xC0, 0x01	; 038040CA
	.byte 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D	; 038040DE
	.byte 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xD4, 0xFB, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28	; 038040EE
	.byte 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0x06, 0x21, 0x0A, 0x48, 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D	; 038040FE
	.byte 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xC4, 0xFB, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28	; 0380410E
	.byte 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xC0, 0x01, 0x00, 0x04, 0x00, 0x81	; 0380411E
	.byte 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x30, 0xB5, 0x81, 0xB0, 0x04, 0x1C, 0xF9, 0xF7, 0xB7, 0xFD	; 0380412E
	.byte 0x05, 0x1C, 0x03, 0x20, 0xFE, 0xF7, 0x7B, 0xFE, 0x00, 0x28, 0x09, 0xD1, 0x28, 0x1C, 0xF9, 0xF7	; 0380413E
	.byte 0xC0, 0xFD, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x21, 0xFE, 0xF7, 0x7A, 0xFE, 0x5E, 0xE0	; 0380414E
	.byte 0x03, 0x20, 0xFE, 0xF7, 0x64, 0xFE, 0x28, 0x1C, 0xF9, 0xF7, 0xB3, 0xFD, 0x60, 0x68, 0x01, 0x1C	; 0380415E
	.byte 0x61, 0x39, 0x05, 0x29, 0x4B, 0xD8, 0x49, 0x18, 0x79, 0x44, 0x09, 0x89, 0x09, 0x04, 0x09, 0x14	; 0380416E
	.byte 0x79, 0x44, 0x08, 0x47, 0x0D, 0x00, 0x8B, 0x00, 0x6B, 0x00, 0x25, 0x00, 0x49, 0x00, 0x83, 0x00	; 0380417E
	.byte 0x01, 0x21, 0x24, 0x48, 0x01, 0x62, 0xA1, 0x68, 0x24, 0x48, 0x01, 0x80, 0xE1, 0x68, 0x23, 0x48	; 0380418E
	.byte 0x01, 0x80, 0x00, 0xF0, 0x46, 0xFA, 0x37, 0xE0, 0x04, 0x21, 0x1E, 0x48, 0x01, 0x62, 0xA2, 0x68	; 0380419E
	.byte 0x82, 0x62, 0xE1, 0x68, 0x41, 0x62, 0x10, 0x04, 0x00, 0x0C, 0x09, 0x06, 0x09, 0x0E, 0x00, 0xF0	; 038041AE
	.byte 0x72, 0xF9, 0x64, 0x20, 0x00, 0x21, 0xFE, 0xF7, 0x44, 0xFE, 0x25, 0xE0, 0x03, 0x21, 0x15, 0x48	; 038041BE
	.byte 0x01, 0x62, 0xA1, 0x68, 0x81, 0x62, 0x08, 0x04, 0x04, 0x0C, 0x20, 0x1C, 0x00, 0xF0, 0x1F, 0xF9	; 038041CE
	.byte 0x01, 0x1C, 0x70, 0x34, 0x20, 0x04, 0x00, 0x0C, 0xFE, 0xF7, 0x33, 0xFE, 0x14, 0xE0, 0x02, 0x20	; 038041DE
	.byte 0x0D, 0x49, 0x08, 0x62, 0xA0, 0x68, 0x48, 0x62, 0x00, 0xF0, 0xB3, 0xF9, 0x63, 0x20, 0x00, 0x21	; 038041EE
	.byte 0xFE, 0xF7, 0x27, 0xFE, 0x08, 0xE0, 0xA0, 0x68, 0x00, 0xF0, 0x89, 0xF9, 0x04, 0xE0, 0x00, 0x04	; 038041FE
	.byte 0x00, 0x0C, 0x01, 0x21, 0xFE, 0xF7, 0x1D, 0xFE, 0x03, 0x20, 0xFE, 0xF7, 0xF4, 0xFD, 0x01, 0xB0	; 0380420E
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0x79, 0x80, 0x03, 0xEC, 0x79, 0x80, 0x03, 0xE8, 0x79	; 0380421E
	.byte 0x80, 0x03	; 03804220

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
	add r0,pc	; 0380426A
	ldrh r0,[r0,#0x8]	; 0380426C
	lsl r0,r0,#0x10	; 0380426E
	asr r0,r0,#0x10	; 03804270
	add r0,pc	; 03804272
	bx r0	; 03804274
	.byte 0x11, 0x00, 0x1B, 0x00, 0xCB, 0x00, 0x7F, 0x00, 0x3F, 0x00, 0x63, 0x00, 0xA5, 0x00, 0xB9, 0x00	; 03804286
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
	.word 0x038079F4	; 03804354
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
	.word 0x038079F0	; 03804384
pool_03804388:
loc_03804388:
	.word 0x038079F4	; 03804388
	.byte 0x06, 0x4B, 0x1A, 0x40, 0x06, 0x4B, 0x18, 0x40, 0x83, 0x05, 0x06, 0x48, 0x01, 0x40, 0x08, 0x04	; 0380439C
	.byte 0x03, 0x43, 0x1A, 0x43, 0x10, 0x1C, 0x04, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xFF, 0xFF, 0x00, 0x00	; 038043AC
	.byte 0x00, 0x00, 0xC0, 0x03, 0x00, 0x00, 0x3F, 0x00, 0xB9, 0x43, 0x80, 0x03, 0x70, 0xB5, 0x05, 0x1C	; 038043BC
	.byte 0x08, 0x24, 0x00, 0x26, 0x20, 0x1C, 0x29, 0x1C, 0x32, 0x1C, 0xFD, 0xF7, 0x91, 0xFD, 0x00, 0x28	; 038043CC
	.byte 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 038043D4

; ===== function loc_038043D4 =====
loc_038043D4:
	push {r4,lr}	; 038043D4
	add r4,r0,#0x0	; 038043D6
	mov r0,#0x0	; 038043D8
	bl loc_0380440C	; 038043DA
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
	bl loc_0380440C	; 038043F6
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
	bl loc_038044F8	; 0380442A
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
	bl loc_038044F8	; 03804454
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
pool_0380448C:
loc_0380448C:
	.word 0x040001C0	; 0380448C
pool_03804490:
loc_03804490:
	.word 0x040001C2	; 03804490

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
	bl loc_038044F8	; 038044B2
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
	bl loc_038044F8	; 038044DA
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
	.word 0x040001C0	; 038044F0
pool_038044F4:
loc_038044F4:
	.word 0x040001C2	; 038044F4

; ===== function loc_038044F8 =====
loc_038044F8:
	lsl r1,r0,#0xb	; 038044F8
	ldr r0,[pool_03804504]	; 038044FA
	orr r1,r0	; 038044FC
	ldr r0,[pool_03804508]	; 038044FE
	strh r1,[r0,#0x0]	; 03804500
	bx lr	; 03804502
pool_03804504:
loc_03804504:
	.word 0x00008002	; 03804504
pool_03804508:
loc_03804508:
	.word 0x040001C0	; 03804508

; ===== function loc_0380450C =====
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
	.word 0x038052C0	; 0380454C
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0F, 0x28, 0x5F, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 03804560
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0xB3, 0x00, 0x21, 0x00, 0x2F, 0x00, 0x3D, 0x00, 0x4B, 0x00	; 03804570
	.byte 0x53, 0x00, 0x5B, 0x00, 0x63, 0x00, 0x6B, 0x00, 0x73, 0x00, 0x7B, 0x00, 0x83, 0x00, 0x8B, 0x00	; 03804580
	.byte 0x93, 0x00, 0xA3, 0x00, 0x9B, 0x00, 0x01, 0x20, 0x00, 0xF0, 0xF6, 0xF8, 0x01, 0x20, 0xFF, 0xF7	; 03804590
	.byte 0xBD, 0xFF, 0x41, 0xE0, 0x03, 0x20, 0x00, 0xF0, 0xEF, 0xF8, 0x03, 0x20, 0xFF, 0xF7, 0xB6, 0xFF	; 038045A0
	.byte 0x3A, 0xE0, 0x02, 0x20, 0x00, 0xF0, 0xE8, 0xF8, 0x02, 0x20, 0xFF, 0xF7, 0xAF, 0xFF, 0x33, 0xE0	; 038045B0
	.byte 0x04, 0x20, 0xFF, 0xF7, 0x1D, 0xFF, 0x2F, 0xE0, 0x04, 0x20, 0xFF, 0xF7, 0x0B, 0xFF, 0x2B, 0xE0	; 038045C0
	.byte 0x08, 0x20, 0xFF, 0xF7, 0x15, 0xFF, 0x27, 0xE0, 0x08, 0x20, 0xFF, 0xF7, 0x03, 0xFF, 0x23, 0xE0	; 038045D0
	.byte 0x0C, 0x20, 0xFF, 0xF7, 0x0D, 0xFF, 0x1F, 0xE0, 0x0C, 0x20, 0xFF, 0xF7, 0xFB, 0xFE, 0x1B, 0xE0	; 038045E0
	.byte 0x01, 0x20, 0xFF, 0xF7, 0x05, 0xFF, 0x17, 0xE0, 0x01, 0x20, 0xFF, 0xF7, 0xF3, 0xFE, 0x13, 0xE0	; 038045F0
	.byte 0x02, 0x20, 0xFF, 0xF7, 0xFD, 0xFE, 0x0F, 0xE0, 0x02, 0x20, 0xFF, 0xF7, 0xEB, 0xFE, 0x0B, 0xE0	; 03804600
	.byte 0x40, 0x20, 0xFF, 0xF7, 0xE7, 0xFE, 0x07, 0xE0, 0xFA, 0xF7, 0x14, 0xFF, 0x01, 0x20, 0xFF, 0xF7	; 03804610
	.byte 0xE1, 0xFE, 0x40, 0x20, 0xFF, 0xF7, 0xEC, 0xFE, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 03804620
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x43, 0x49, 0x0C, 0x88, 0x00, 0x20, 0x08, 0x80, 0xF9, 0xF7, 0x36, 0xFB	; 03804630
	.byte 0x06, 0x1C, 0x41, 0x48, 0xF9, 0xF7, 0xF4, 0xF9, 0x07, 0x1C, 0x00, 0x20, 0xFF, 0xF7, 0xE6, 0xFE	; 03804640
	.byte 0x00, 0x90, 0x02, 0x20, 0x00, 0xF0, 0x98, 0xF8, 0x02, 0x20, 0xFF, 0xF7, 0x5F, 0xFF, 0x02, 0x20	; 03804650
	.byte 0xFF, 0xF7, 0x5C, 0xFF, 0xFA, 0xF7, 0xEE, 0xFE, 0x01, 0x20, 0xFF, 0xF7, 0xBB, 0xFE, 0x37, 0x48	; 03804660
	.byte 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x08, 0xD0, 0x35, 0x48, 0x01, 0x88, 0x35, 0x48	; 03804670
	.byte 0x01, 0x43, 0x35, 0x48, 0x01, 0x80, 0x35, 0x48, 0xF9, 0xF7, 0xE8, 0xF9, 0x2F, 0x48, 0x01, 0x88	; 03804680
	.byte 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x31, 0x48, 0xF9, 0xF7, 0xDF, 0xF9, 0x2B, 0x48	; 03804690
	.byte 0x01, 0x88, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x0F, 0xD0, 0x2E, 0x48, 0x05, 0x88, 0x2E, 0x48	; 038046A0
	.byte 0xFD, 0xF7, 0x2E, 0xFD, 0x40, 0x20, 0x01, 0x1C, 0xFD, 0xF7, 0x34, 0xFD, 0x2B, 0x48, 0x01, 0x1C	; 038046B0
	.byte 0xFD, 0xF7, 0x30, 0xFD, 0x80, 0x20, 0xF9, 0xF7, 0xC9, 0xF9, 0x20, 0x48, 0x01, 0x88, 0x08, 0x20	; 038046C0
	.byte 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x26, 0x48, 0xF9, 0xF7, 0xC0, 0xF9, 0x1B, 0x48, 0x01, 0x88	; 038046D0
	.byte 0x10, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x22, 0x48, 0xF9, 0xF7, 0xB7, 0xF9, 0x30, 0x1C	; 038046E0
	.byte 0xF9, 0xF7, 0xEE, 0xFA, 0x13, 0x49, 0x08, 0x88, 0x01, 0x20, 0x08, 0x80, 0x00, 0xF0, 0xDF, 0xF8	; 038046F0
	.byte 0x00, 0x20, 0x00, 0x99, 0xFF, 0xF7, 0xCE, 0xFE, 0x16, 0x48, 0x05, 0x80, 0x01, 0x20, 0xFF, 0xF7	; 03804700
	.byte 0x77, 0xFE, 0xFA, 0xF7, 0x7D, 0xFE, 0x00, 0x21, 0x17, 0x48, 0x01, 0x62, 0x62, 0x20, 0x0A, 0x1C	; 03804710
	.byte 0xFF, 0xF7, 0x3C, 0xFE, 0xF9, 0xF7, 0xC2, 0xFA, 0x38, 0x1C, 0xF9, 0xF7, 0x97, 0xF9, 0x30, 0x1C	; 03804720
	.byte 0xF9, 0xF7, 0xCE, 0xFA, 0x03, 0x49, 0x08, 0x88, 0x0C, 0x80, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 03804730
	.byte 0x18, 0x47, 0xC0, 0x46, 0x08, 0x02, 0x00, 0x04, 0xFF, 0xFF, 0xFF, 0x01, 0xEC, 0x79, 0x80, 0x03	; 03804740
	.byte 0xE8, 0x79, 0x80, 0x03, 0x00, 0x40, 0x00, 0x00, 0x32, 0x01, 0x00, 0x04, 0x00, 0x10, 0x00, 0x00	; 03804750
	.byte 0x00, 0x00, 0x40, 0x00, 0x34, 0x01, 0x00, 0x04, 0x00, 0x80, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00	; 03804760
	.byte 0x00, 0x00, 0x10, 0x00, 0x00, 0x20, 0x00, 0x00, 0xF4, 0x79, 0x80, 0x03	; 0380476C

; ===== function loc_0380476C =====
loc_0380476C:
	ldr r0,[pool_03804774]	; 0380476C
	ldr r0,[r0,#0x0]	; 0380476E
	bx lr	; 03804770
	.byte 0xC0, 0x46	; 03804774
pool_03804774:
loc_03804774:
	.word 0x03807A24	; 03804774

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
	.word 0x03807A24	; 03804788
pool_0380478C:
loc_0380478C:
	.word 0x03807A20	; 0380478C

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
	.word 0x03807A24	; 03804830
pool_03804834:
loc_03804834:
	.word 0x038052C0	; 03804834
pool_03804838:
loc_03804838:
	.word 0x038052C4	; 03804838
pool_0380483C:
loc_0380483C:
	.word 0x03807A20	; 0380483C
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
	bl loc_038048D0	; 03804852
	bl loc_037FAFA8	; 03804856
	ldr r1,[pool_03804864]	; 0380485A
	strh r0,[r1,#0x2]	; 0380485C
	add sp,#0x4	; 0380485E
	pop {r3}	; 03804860
	bx r3	; 03804862
pool_03804864:
loc_03804864:
	.word 0x03807A28	; 03804864
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
	.word 0x03807A2C	; 03804888
	.byte 0x00, 0xDF, 0x70, 0x47	; 03804890

; ===== function loc_03804890 =====
loc_03804890:
	swi 0x3	; 03804890
	bx lr	; 03804892
	.byte 0x02, 0x4A, 0x94, 0x46, 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04	; 038048A4
	.byte 0x00, 0x22, 0x05, 0xDF, 0x70, 0x47	; 038048AA

; ===== function loc_038048AA =====
loc_038048AA:
	swi 0x6	; 038048AA
	bx lr	; 038048AC
	.byte 0x07, 0xDF, 0x70, 0x47, 0x08, 0xDF, 0x70, 0x47	; 038048B6

; ===== function loc_038048B6 =====
loc_038048B6:
	add r1,r0,#0x0	; 038048B6
	mov r0,#0x1	; 038048B8
	swi 0x8	; 038048BA
	bx lr	; 038048BC

; ===== function loc_038048BE =====
loc_038048BE:
	add r1,r0,#0x0	; 038048BE
	mov r0,#0x0	; 038048C0
	swi 0x8	; 038048C2
	bx lr	; 038048C4
	.byte 0x09, 0xDF, 0x70, 0x47, 0x09, 0xDF, 0x08, 0x1C, 0x70, 0x47	; 038048D0

; ===== function loc_038048D0 =====
loc_038048D0:
	swi 0xb	; 038048D0
	bx lr	; 038048D2

; ===== function loc_038048D4 =====
loc_038048D4:
	swi 0xc	; 038048D4
	bx lr	; 038048D6
	.byte 0x0D, 0xDF, 0x70, 0x47, 0x0E, 0xDF, 0x70, 0x47, 0x0F, 0xDF, 0x70, 0x47, 0x10, 0xDF, 0x70, 0x47	; 038048E8
	.byte 0x11, 0xDF, 0x70, 0x47, 0x12, 0xDF, 0x70, 0x47, 0x13, 0xDF, 0x70, 0x47, 0x14, 0xDF, 0x70, 0x47	; 038048F8
	.byte 0x15, 0xDF, 0x70, 0x47, 0x1A, 0xDF, 0x70, 0x47	; 03804900

; ===== function loc_03804900 =====
loc_03804900:
	swi 0x1b	; 03804900
	bx lr	; 03804902

; ===== function loc_03804904 =====
loc_03804904:
	swi 0x1c	; 03804904
	bx lr	; 03804906
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

; ===== function loc_03804B60 =====
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
	add pc,pc,r2, lsl #0x2	; 03804BCC
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804BD4
loc_03804BD4:
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
	add pc,pc,r2, lsl #0x2	; 03804DC0
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804DC8
loc_03804DC8:
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
	.word 0x03805079	; 03805030

; ===== function loc_03805034 =====
loc_03805034:
	ldr r12,[pool_0380503C]	; 03805034
	bx r12	; 03805038
pool_0380503C:
loc_0380503C:
	.word 0x03805081	; 0380503C
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
	.byte 0x59, 0x50, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x49, 0x32, 0x00, 0x00	; 03805098
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 038050A8
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 038050B8
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 038050C8
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 038050D8
	.byte 0x7F, 0x00, 0x00, 0x00, 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 038050E8
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 038050F8
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 03805108
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 03805118
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 03805128
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 03805138
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 03805148
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 03805158
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 03805168
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 03805178
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 03805188
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 03805198
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 038051A8
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 038051B8
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 038051C8
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 038051D8
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x01, 0x02, 0x04, 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 038051E8
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D, 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 038051F8
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805208
	.byte 0xC8, 0x57, 0x80, 0x03, 0xEC, 0x57, 0x80, 0x03, 0x54, 0x53, 0x80, 0x03, 0x54, 0x53, 0x80, 0x03	; 03805218
	.byte 0x4C, 0x7A, 0x80, 0x03, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00	; 03805228
	.byte 0x05, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03	; 03805238
	.byte 0xF9, 0xD9, 0x7F, 0x03, 0x61, 0xD9, 0x7F, 0x03, 0x55, 0xD9, 0x7F, 0x03, 0x49, 0xD9, 0x7F, 0x03	; 03805248
	.byte 0x3D, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0x91, 0xD9, 0x7F, 0x03, 0x85, 0xD9, 0x7F, 0x03	; 03805258
	.byte 0x79, 0xD9, 0x7F, 0x03, 0x6D, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03	; 03805268
	.byte 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03	; 03805278
	.byte 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03	; 03805288
	.byte 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xF9, 0xD9, 0x7F, 0x03, 0xC9, 0xDD, 0x7F, 0x03	; 03805298
	.byte 0x78, 0x56, 0x34, 0x12, 0x46, 0x61, 0x69, 0x6C, 0x65, 0x64, 0x20, 0x73, 0x6F, 0x75, 0x6E, 0x64	; 038052A8
	.byte 0x20, 0x61, 0x6C, 0x61, 0x72, 0x6D, 0x20, 0x4F, 0x53, 0x5F, 0x53, 0x65, 0x6E, 0x64, 0x4D, 0x65	; 038052B8
	.byte 0x73, 0x73, 0x61, 0x67, 0x65, 0x0A, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038052C8
	.byte 0x00, 0x00, 0x00, 0xAA, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC	; 038052D8
	.byte 0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00	; 038052E8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 038052F8
	.byte 0x00, 0x00, 0x3E, 0xF8, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC	; 03805308
	.byte 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00	; 03805318
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805328
	.byte 0x00, 0x00, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF	; 03805338
	.byte 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00	; 03805348
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805358
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805368
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805378
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805388
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805398
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053A8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053B8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053C8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053D8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053E8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038053F8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805408
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805418
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805428
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03805438
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0xB5, 0x0C, 0x48	; 03805448
	.byte 0x06, 0xF0, 0x74, 0xF9, 0x0B, 0x4E, 0x0C, 0x4D, 0x01, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x0C, 0xF0	; 03805458
	.byte 0xC5, 0xFB, 0x29, 0x88, 0x08, 0x1C, 0x20, 0x40, 0x00, 0x28, 0xF7, 0xD1, 0x01, 0x20, 0x01, 0x43	; 03805468
	.byte 0x29, 0x80, 0x06, 0x48, 0x80, 0x69, 0x80, 0x68, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03805478
	.byte 0xF8, 0xFE, 0x30, 0x02, 0x00, 0x01, 0x00, 0x00, 0x96, 0xFF, 0x7F, 0x02, 0x00, 0xFF, 0x30, 0x02	; 03805488
	.byte 0x70, 0xB5, 0x0A, 0x48, 0x06, 0xF0, 0x52, 0xF9, 0x09, 0x4E, 0x0A, 0x4D, 0x01, 0x24, 0x02, 0xE0	; 03805498
	.byte 0x30, 0x1C, 0x0C, 0xF0, 0xA3, 0xFB, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x03, 0x48	; 038054A8
	.byte 0x06, 0xF0, 0x22, 0xF9, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF8, 0xFE, 0x30, 0x02	; 038054B8
	.byte 0x00, 0x01, 0x00, 0x00, 0x96, 0xFF, 0x7F, 0x02, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0A, 0x4C	; 038054C8
	.byte 0x0A, 0x26, 0x00, 0x27, 0x02, 0xE0, 0x20, 0x1C, 0x0C, 0xF0, 0x88, 0xFB, 0x30, 0x1C, 0x29, 0x1C	; 038054D8
	.byte 0x3A, 0x1C, 0x09, 0xF0, 0xB1, 0xFE, 0x00, 0x28, 0xF5, 0xDB, 0x04, 0x48, 0x06, 0xF0, 0x04, 0xF9	; 038054E8
	.byte 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x01, 0x00, 0x00, 0xF8, 0xFE, 0x30, 0x02	; 038054F8
	.byte 0x02, 0xC0, 0x81, 0xE0, 0x0C, 0x00, 0x51, 0xE1, 0x04, 0x00, 0xB0, 0xB8, 0x04, 0x00, 0xA1, 0xB8	; 03805508
	.byte 0xFB, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB5, 0x04, 0x1C, 0xF2, 0xF7, 0xF6, 0xFB	; 03805518
	.byte 0x07, 0x48, 0x04, 0x60, 0x07, 0x49, 0x08, 0x88, 0x02, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x08, 0x80	; 03805528
	.byte 0x01, 0x20, 0x05, 0x49, 0xF2, 0xF7, 0x9E, 0xFC, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03805538
	.byte 0xF4, 0xF6, 0x80, 0x03, 0x40, 0xFC, 0x7F, 0x02, 0x55, 0xF6, 0x80, 0x03, 0x00, 0x4B, 0x18, 0x47	; 03805548
	.byte 0x79, 0xF6, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x28, 0x07, 0xD1, 0x01, 0x29, 0x05, 0xD1	; 03805558
	.byte 0x04, 0x48, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD0, 0xF5, 0xF7, 0xEA, 0xFC, 0x01, 0xB0, 0x08, 0xBC	; 03805568
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xF6, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x04, 0x48, 0x00, 0x88	; 03805578
	.byte 0x02, 0x28, 0x02, 0xD1, 0x03, 0x48, 0x00, 0xF0, 0x29, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47	; 03805588
	.byte 0x40, 0xFC, 0x7F, 0x02, 0x40, 0xE8, 0x3F, 0x02, 0x70, 0xB5, 0x0E, 0x1C, 0x00, 0x28, 0x13, 0xD0	; 03805598
	.byte 0x00, 0x25, 0x04, 0x1C, 0x0C, 0x34, 0x28, 0x01, 0x22, 0x18, 0xD0, 0x68, 0xC0, 0x07, 0xC0, 0x0F	; 038055A8
	.byte 0xB0, 0x42, 0x06, 0xD1, 0x51, 0x68, 0x10, 0x68, 0x88, 0x42, 0x02, 0xD0, 0x92, 0x68, 0x00, 0xF0	; 038055B8
	.byte 0x07, 0xF8, 0x6D, 0x1C, 0x03, 0x2D, 0xEE, 0xDB, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 038055C8
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x00, 0xF6, 0x80, 0x03, 0x10, 0xB5, 0x04, 0x1C	; 038055D8
	.byte 0x00, 0x21, 0xFF, 0xF7, 0xD9, 0xFF, 0x20, 0x1C, 0x01, 0x21, 0xFF, 0xF7, 0xD5, 0xFF, 0x10, 0xBC	; 038055E8
	.byte 0x08, 0xBC, 0x18, 0x47, 0x0E, 0xB0, 0xA0, 0xE1, 0x54, 0x00, 0x9F, 0xE5, 0x54, 0x10, 0x9F, 0xE5	; 038055F8
	.byte 0x66, 0x00, 0x00, 0xEB, 0x50, 0x00, 0x9F, 0xE5, 0x50, 0x10, 0x9F, 0xE5, 0x63, 0x00, 0x00, 0xEB	; 03805608
	.byte 0x4C, 0x30, 0x9F, 0xE5, 0xB0, 0x10, 0xD3, 0xE1, 0x02, 0x00, 0x51, 0xE3, 0x0B, 0x00, 0x00, 0x0A	; 03805618
	.byte 0x40, 0x30, 0x9F, 0xE5, 0x00, 0x10, 0x93, 0xE5, 0x00, 0x00, 0x51, 0xE3, 0x07, 0x00, 0x00, 0x0A	; 03805628
	.byte 0x34, 0x30, 0x9F, 0xE5, 0x38, 0x00, 0x93, 0xE5, 0x3C, 0x20, 0x93, 0xE5, 0x38, 0x10, 0x83, 0xE5	; 03805638
	.byte 0xAD, 0xFF, 0xFF, 0xEB, 0x24, 0x00, 0x9F, 0xE5, 0x01, 0x17, 0x80, 0xE2, 0x53, 0x00, 0x00, 0xEB	; 03805648
	.byte 0x1B, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x30, 0x02, 0x00, 0xE8, 0x3F, 0x02, 0x00, 0x80, 0x7F, 0x03	; 03805658
	.byte 0x00, 0xF6, 0x80, 0x03, 0x40, 0xFC, 0x7F, 0x02, 0x60, 0xF8, 0x7F, 0x02, 0x00, 0xFE, 0x7F, 0x02	; 03805668
	.byte 0x00, 0x00, 0x2C, 0x02, 0x0E, 0xC0, 0xA0, 0xE1, 0xD3, 0x00, 0xA0, 0xE3, 0x00, 0xF0, 0x2F, 0xE1	; 03805678
	.byte 0x78, 0xD0, 0x9F, 0xE5, 0x00, 0xE0, 0xA0, 0xE3, 0x0E, 0xF0, 0x6F, 0xE1, 0xD2, 0x00, 0xA0, 0xE3	; 03805688
	.byte 0x00, 0xF0, 0x2F, 0xE1, 0x68, 0x20, 0x9F, 0xE5, 0x02, 0xD0, 0xA0, 0xE1, 0x00, 0xE0, 0xA0, 0xE3	; 03805698
	.byte 0x0E, 0xF0, 0x6F, 0xE1, 0xDF, 0x00, 0xA0, 0xE3, 0x00, 0xF0, 0x2F, 0xE1, 0x02, 0x1C, 0xA0, 0xE3	; 038056A8
	.byte 0x01, 0x10, 0x42, 0xE0, 0x01, 0xD0, 0xA0, 0xE1, 0x48, 0x20, 0x9F, 0xE5, 0x06, 0x0C, 0x42, 0xE2	; 038056B8
	.byte 0x02, 0x10, 0xA0, 0xE1, 0x35, 0x00, 0x00, 0xEB, 0x0A, 0x0C, 0x42, 0xE2, 0x38, 0x10, 0x9F, 0xE5	; 038056C8
	.byte 0x32, 0x00, 0x00, 0xEB, 0x34, 0x20, 0x9F, 0xE5, 0x02, 0x00, 0xA0, 0xE1, 0x02, 0x1B, 0x82, 0xE2	; 038056D8
	.byte 0x2E, 0x00, 0x00, 0xEB, 0x36, 0x0D, 0x82, 0xE2, 0x80, 0x10, 0x80, 0xE2, 0x2B, 0x00, 0x00, 0xEB	; 038056E8
	.byte 0x3E, 0x0D, 0x82, 0xE2, 0x80, 0x10, 0x80, 0xE2, 0x28, 0x00, 0x00, 0xEB, 0x1C, 0xFF, 0x2F, 0xE1	; 038056F8
	.byte 0xC0, 0xFF, 0x80, 0x03, 0x80, 0xFF, 0x80, 0x03, 0x00, 0x00, 0x81, 0x03, 0xF8, 0xF6, 0x80, 0x03	; 03805708
	.byte 0x00, 0xF0, 0x7F, 0x02, 0x74, 0x10, 0x9F, 0xE5, 0x02, 0x0C, 0xA0, 0xE3, 0xB0, 0x00, 0xC1, 0xE1	; 03805718
	.byte 0xB0, 0x00, 0xD1, 0xE1, 0x0F, 0x00, 0x00, 0xE2, 0x02, 0x00, 0x50, 0xE3, 0xFB, 0xFF, 0xFF, 0x1A	; 03805728
	.byte 0xAF, 0xFF, 0xFF, 0xEB, 0x58, 0x10, 0x9F, 0xE5, 0x17, 0x00, 0x00, 0xEB, 0x4C, 0x10, 0x9F, 0xE5	; 03805738
	.byte 0x01, 0x0C, 0xA0, 0xE3, 0xB0, 0x00, 0xC1, 0xE1, 0xB0, 0x00, 0xD1, 0xE1, 0x0F, 0x00, 0x00, 0xE2	; 03805748
	.byte 0x01, 0x00, 0x50, 0xE3, 0xFB, 0xFF, 0xFF, 0x1A, 0xC5, 0xFF, 0xFF, 0xEB, 0x2C, 0x10, 0x9F, 0xE5	; 03805758
	.byte 0x00, 0x00, 0xA0, 0xE3, 0xB0, 0x00, 0xC1, 0xE1, 0xB0, 0x00, 0xD1, 0xE1, 0x01, 0x00, 0x50, 0xE3	; 03805768
	.byte 0xFC, 0xFF, 0xFF, 0x0A, 0x1C, 0x30, 0x9F, 0xE5, 0xCC, 0xC1, 0x13, 0xE5, 0x0C, 0xE0, 0xA0, 0xE1	; 03805778
	.byte 0x01, 0xB3, 0xA0, 0xE3, 0xFF, 0x07, 0x1B, 0xE9, 0x00, 0xB0, 0xA0, 0xE3, 0x1C, 0xFF, 0x2F, 0xE1	; 03805788
	.byte 0x80, 0x01, 0x00, 0x04, 0x4D, 0xF6, 0x80, 0x03, 0x00, 0x00, 0x80, 0x02, 0x11, 0xFF, 0x2F, 0xE1	; 03805798
	.byte 0x00, 0x30, 0xA0, 0xE3, 0x03, 0x40, 0xA0, 0xE1, 0x03, 0x50, 0xA0, 0xE1, 0x03, 0x60, 0xA0, 0xE1	; 038057A8
	.byte 0x03, 0x70, 0xA0, 0xE1, 0x03, 0x80, 0xA0, 0xE1, 0x03, 0x90, 0xA0, 0xE1, 0x03, 0xA0, 0xA0, 0xE1	; 038057B8
	.byte 0x01, 0x00, 0x50, 0xE1, 0xF8, 0x07, 0xA0, 0xB8, 0xFC, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1	; 038057C8
	.byte 0x00, 0x80, 0x7F, 0x03, 0xA4, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF6, 0x80, 0x03	; 038057D8
	.byte 0xF4, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0xF8, 0xF6, 0x80, 0x03, 0xDC, 0x01, 0x00, 0x00	; 038057E8
	.byte 0x00, 0x00, 0x00, 0x00	; 038057EC
.close
