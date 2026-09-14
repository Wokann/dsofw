; official_v7_p2
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
	bl loc_03804FC4	; 037FA870
	bl loc_037FA968	; 037FA874
	bl loc_037FA8AC	; 037FA878
	ldr r1,[pool_037FA8A4]	; 037FA87C
	ldr lr,[pool_037FA8A8]	; 037FA880
	bx r1	; 037FA884
pool_037FA888:
loc_037FA888:
	.word 0x03807A94	; 037FA888
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
	.word 0x037FD7DC	; 037FA8A0
pool_037FA8A4:
loc_037FA8A4:
	.word 0x037FAD69	; 037FA8A4
pool_037FA8A8:
loc_037FA8A8:
	.word 0x0380F818	; 037FA8A8

; ===== function loc_037FA8AC =====
loc_037FA8AC:
	ldr r12,[pool_037FA8B4]	; 037FA8AC
	bx r12	; 037FA8B0
pool_037FA8B4:
loc_037FA8B4:
	.word 0x0380509D	; 037FA8B4

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
	.word 0x0380524C	; 037FA924
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
	.word 0x038050D8	; 037FA988
pool_037FA98C:
loc_037FA98C:
	.word 0x038053A8	; 037FA98C
pool_037FA990:
loc_037FA990:
	.word 0x038053A4	; 037FA990
pool_037FA994:
loc_037FA994:
	.word 0x038053A0	; 037FA994
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
	.word 0x038053A0	; 037FA9D8
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
	bl loc_03804918	; 037FA9FE
	mov r4,#0x0	; 037FAA02
loc_037FAA04:
	add r0,r4,#0x0	; 037FAA04
	bl loc_037FF1E4	; 037FAA06
	add r4,r4,#0x1	; 037FAA0A
	cmp r4,#0x3	; 037FAA0C
	ble loc_037FAA04	; 037FAA0E
	mov r0,#0x0	; 037FAA10
	str r0,[sp,#0x4]	; 037FAA12
	add r0,sp,#0x4	; 037FAA14
	ldr r1,[pool_037FAA68]	; 037FAA16
	ldr r2,[pool_037FAA6C]	; 037FAA18
	bl loc_03804918	; 037FAA1A
	mov r0,#0x0	; 037FAA1E
	str r0,[sp,#0x8]	; 037FAA20
	add r0,sp,#0x8	; 037FAA22
	ldr r1,[pool_037FAA70]	; 037FAA24
	ldr r2,[pool_037FAA74]	; 037FAA26
	bl loc_03804918	; 037FAA28
	mov r0,#0x0	; 037FAA2C
	str r0,[sp,#0xc]	; 037FAA2E
	add r0,sp,#0xc	; 037FAA30
	ldr r1,[pool_037FAA78]	; 037FAA32
	ldr r2,[pool_037FAA7C]	; 037FAA34
	bl loc_03804918	; 037FAA36
	mov r2,#0x0	; 037FAA3A
	ldr r0,[pool_037FAA80]	; 037FAA3C
	strh r2,[r0,#0x0]	; 037FAA3E
	ldr r0,[pool_037FAA84]	; 037FAA40
	strh r2,[r0,#0x0]	; 037FAA42
	ldr r1,[pool_037FAA88]	; 037FAA44
	ldr r0,[pool_037FAA8C]	; 037FAA46
	strh r1,[r0,#0x0]	; 037FAA48
	mvn r0,r2	; 037FAA4A
	bl loc_037FDA40	; 037FAA4C
	add sp,#0x10	; 037FAA50
	pop {r4}	; 037FAA52
	pop {r3}	; 037FAA54
	bx r3	; 037FAA56
pool_037FAA58:
loc_037FAA58:
	.word 0x03807A94	; 037FAA58
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
	.word 0x040000B0	; 037FAA68
pool_037FAA6C:
loc_037FAA6C:
	.word 0x01000023	; 037FAA6C
pool_037FAA70:
loc_037FAA70:
	.word 0x04000400	; 037FAA70
pool_037FAA74:
loc_037FAA74:
	.word 0x01000041	; 037FAA74
pool_037FAA78:
loc_037FAA78:
	.word 0x04000508	; 037FAA78
pool_037FAA7C:
loc_037FAA7C:
	.word 0x01000005	; 037FAA7C
pool_037FAA80:
loc_037FAA80:
	.word 0x04000004	; 037FAA80
pool_037FAA84:
loc_037FAA84:
	.word 0x040001C0	; 037FAA84
pool_037FAA88:
loc_037FAA88:
	.word 0x00004008	; 037FAA88
pool_037FAA8C:
loc_037FAA8C:
	.word 0x04000184	; 037FAA8C

; ===== function loc_037FAA90 =====
loc_037FAA90:
	push {r4,lr}	; 037FAA90
	sub sp,#0x8	; 037FAA92
	ldr r1,[pool_037FAAF4]	; 037FAA94
	ldrh r0,[r1,#0x0]	; 037FAA96
	lsl r0,r0,#0x3	; 037FAA98
	ldrh r2,[r1,#0x2]	; 037FAA9A
	lsl r4,r2,#0x3	; 037FAA9C
	ldrh r2,[r1,#0x4]	; 037FAA9E
	ldr r1,[pool_037FAAF8]	; 037FAAA0
	strh r2,[r1,#0x0]	; 037FAAA2
	ldr r2,[pool_037FAAFC]	; 037FAAA4
	ldr r1,[pool_037FAB00]	; 037FAAA6
	str r2,[r1,#0x0]	; 037FAAA8
	mov r1,#0x1	; 037FAAAA
	str r1,[sp,#0x0]	; 037FAAAC
	ldr r1,[pool_037FAB04]	; 037FAAAE
	mov r2,#0x0	; 037FAAB0
	ldr r3,[pool_037FAB08]	; 037FAAB2
	bl loc_037FAC50	; 037FAAB4
	ldr r0,[pool_037FAB0C]	; 037FAAB8
	ldr r1,[r0,#0xc]	; 037FAABA
	ldr r0,[pool_037FAB04]	; 037FAABC
	add r1,r1,r0	; 037FAABE
	ldr r0,[pool_037FAB10]	; 037FAAC0
	str r1,[r0,#0x0]	; 037FAAC2
	ldr r1,[r0,#0x0]	; 037FAAC4
	mov r0,#0x1	; 037FAAC6
	str r0,[sp,#0x0]	; 037FAAC8
	add r0,r4,#0x0	; 037FAACA
	mov r2,#0x0	; 037FAACC
	ldr r3,[pool_037FAB14]	; 037FAACE
	sub r3,r3,r1	; 037FAAD0
	bl loc_037FAC50	; 037FAAD2
	ldr r0,[pool_037FAB10]	; 037FAAD6
	ldr r1,[r0,#0x0]	; 037FAAD8
	ldr r0,[pool_037FAB0C]	; 037FAADA
	ldr r0,[r0,#0xc]	; 037FAADC
	add r1,r1,r0	; 037FAADE
	ldr r0,[pool_037FAB18]	; 037FAAE0
	str r1,[r0,#0x0]	; 037FAAE2
	ldr r0,[pool_037FAB1C]	; 037FAAE4
	bl loc_037FAD40	; 037FAAE6
	add sp,#0x8	; 037FAAEA
	pop {r4}	; 037FAAEC
	pop {r3}	; 037FAAEE
	bx r3	; 037FAAF0
	.byte 0xC0, 0x46	; 037FAAF4
pool_037FAAF4:
loc_037FAAF4:
	.word 0x038053C4	; 037FAAF4
pool_037FAAF8:
loc_037FAAF8:
	.word 0x027FF876	; 037FAAF8
pool_037FAAFC:
loc_037FAAFC:
	.word 0x02300200	; 037FAAFC
pool_037FAB00:
loc_037FAB00:
	.word 0x027FF86C	; 037FAB00
pool_037FAB04:
loc_037FAB04:
	.word 0x022C0000	; 037FAB04
pool_037FAB08:
loc_037FAB08:
	.word 0x00040000	; 037FAB08
pool_037FAB0C:
loc_037FAB0C:
	.word 0x038053B0	; 037FAB0C
pool_037FAB10:
loc_037FAB10:
	.word 0x027FF870	; 037FAB10
pool_037FAB14:
loc_037FAB14:
	.word 0x02300000	; 037FAB14
pool_037FAB18:
loc_037FAB18:
	.word 0x027FF87C	; 037FAB18
pool_037FAB1C:
loc_037FAB1C:
	.word 0x00001000	; 037FAB1C

; ===== function loc_037FAB20 =====
loc_037FAB20:
	push {lr}	; 037FAB20
	sub sp,#0x4	; 037FAB22
	ldr r1,[pool_037FAB4C]	; 037FAB24
	ldrh r0,[r1,#0x16]	; 037FAB26
	lsl r0,r0,#0x3	; 037FAB28
	ldrh r2,[r1,#0x26]	; 037FAB2A
	ldr r1,[pool_037FAB50]	; 037FAB2C
	strh r2,[r1,#0x0]	; 037FAB2E
	mov r1,#0x1	; 037FAB30
	str r1,[sp,#0x0]	; 037FAB32
	ldr r1,[pool_037FAB54]	; 037FAB34
	mov r2,#0x0	; 037FAB36
	ldr r3,[pool_037FAB58]	; 037FAB38
	bl loc_037FAC50	; 037FAB3A
	ldr r0,[pool_037FAB5C]	; 037FAB3E
	bl loc_037FAD40	; 037FAB40
	add sp,#0x4	; 037FAB44
	pop {r3}	; 037FAB46
	bx r3	; 037FAB48
	.byte 0xC0, 0x46	; 037FAB4C
pool_037FAB4C:
loc_037FAB4C:
	.word 0x038053C4	; 037FAB4C
pool_037FAB50:
loc_037FAB50:
	.word 0x027FF874	; 037FAB50
pool_037FAB54:
loc_037FAB54:
	.word 0x022C0000	; 037FAB54
pool_037FAB58:
loc_037FAB58:
	.word 0x00040000	; 037FAB58
pool_037FAB5C:
loc_037FAB5C:
	.word 0x00002000	; 037FAB5C

; ===== function loc_037FAB60 =====
loc_037FAB60:
	push {lr}	; 037FAB60
	sub sp,#0x4	; 037FAB62
	mov r0,#0x0	; 037FAB64
	str r0,[sp,#0x0]	; 037FAB66
	ldr r1,[pool_037FAB84]	; 037FAB68
	mov r2,#0x2c	; 037FAB6A
	add r3,r2,#0x0	; 037FAB6C
	bl loc_037FAC50	; 037FAB6E
	ldr r0,[pool_037FAB84]	; 037FAB72
	ldrh r0,[r0,#0x20]	; 037FAB74
	lsl r1,r0,#0x3	; 037FAB76
	ldr r0,[pool_037FAB88]	; 037FAB78
	str r1,[r0,#0x0]	; 037FAB7A
	add sp,#0x4	; 037FAB7C
	pop {r3}	; 037FAB7E
	bx r3	; 037FAB80
	.byte 0xC0, 0x46	; 037FAB84
pool_037FAB84:
loc_037FAB84:
	.word 0x038053C4	; 037FAB84
pool_037FAB88:
loc_037FAB88:
	.word 0x027FF868	; 037FAB88

; ===== function loc_037FAB8C =====
loc_037FAB8C:
	push {lr}	; 037FAB8C
	sub sp,#0xc	; 037FAB8E
	ldr r1,[pool_037FABE4]	; 037FAB90
	ldr r0,[pool_037FABE8]	; 037FAB92
	ldr r0,[r0,#0x0]	; 037FAB94
	cmp r0,r1	; 037FAB96
	bls loc_037FABB4	; 037FAB98
	sub r2,r0,r1	; 037FAB9A
	cmp r2,#0x0	; 037FAB9C
	beq loc_037FABB4	; 037FAB9E
	mov r0,#0x0	; 037FABA0
	str r0,[sp,#0x0]	; 037FABA2
	add r0,sp,#0x0	; 037FABA4
	lsr r2,r2,#0x2	; 037FABA6
	ldr r3,[pool_037FABEC]	; 037FABA8
	and r2,r3	; 037FABAA
	ldr r3,[pool_037FABF0]	; 037FABAC
	orr r2,r3	; 037FABAE
	bl loc_03804918	; 037FABB0
loc_037FABB4:
	ldr r0,[pool_037FABE8]	; 037FABB4
	ldr r1,[r0,#0x0]	; 037FABB6
	ldr r0,[pool_037FABF4]	; 037FABB8
	ldr r0,[r0,#0x0]	; 037FABBA
	add r1,r1,r0	; 037FABBC
	ldr r0,[pool_037FABF8]	; 037FABBE
	cmp r1,r0	; 037FABC0
	bcs loc_037FABDE	; 037FABC2
	sub r2,r0,r1	; 037FABC4
	cmp r2,#0x0	; 037FABC6
	beq loc_037FABDE	; 037FABC8
	mov r0,#0x0	; 037FABCA
	str r0,[sp,#0x4]	; 037FABCC
	add r0,sp,#0x4	; 037FABCE
	lsr r2,r2,#0x2	; 037FABD0
	ldr r3,[pool_037FABEC]	; 037FABD2
	and r2,r3	; 037FABD4
	ldr r3,[pool_037FABF0]	; 037FABD6
	orr r2,r3	; 037FABD8
	bl loc_03804918	; 037FABDA
loc_037FABDE:
	add sp,#0xc	; 037FABDE
	pop {r3}	; 037FABE0
	bx r3	; 037FABE2
pool_037FABE4:
loc_037FABE4:
	.word 0x02010000	; 037FABE4
pool_037FABE8:
loc_037FABE8:
	.word 0x027FFE28	; 037FABE8
pool_037FABEC:
loc_037FABEC:
	.word 0x001FFFFF	; 037FABEC
pool_037FABF0:
loc_037FABF0:
	.word 0x01000000	; 037FABF0
pool_037FABF4:
loc_037FABF4:
	.word 0x027FFE2C	; 037FABF4
pool_037FABF8:
loc_037FABF8:
	.word 0x02300000	; 037FABF8

; ===== function loc_037FABFC =====
loc_037FABFC:
	push {lr}	; 037FABFC
	sub sp,#0x4	; 037FABFE
	add r0,sp,#0x0	; 037FAC00
	bl loc_038028B0	; 037FAC02
	add r1,sp,#0x0	; 037FAC06
	ldrh r2,[r1,#0x0]	; 037FAC08
	mov r0,#0xf	; 037FAC0A
	bic r2,r0	; 037FAC0C
	mov r0,#0x4	; 037FAC0E
	orr r2,r0	; 037FAC10
	strh r2,[r1,#0x0]	; 037FAC12
	ldrh r2,[r1,#0x0]	; 037FAC14
	mov r0,#0x40	; 037FAC16
	orr r2,r0	; 037FAC18
	strh r2,[r1,#0x0]	; 037FAC1A
	add r0,sp,#0x0	; 037FAC1C
	bl loc_03802890	; 037FAC1E
	ldr r0,[pool_037FAC4C]	; 037FAC22
	bl loc_03802978	; 037FAC24
	ldr r0,[pool_037FAC4C]	; 037FAC28
	bl loc_03802910	; 037FAC2A
	add r1,sp,#0x0	; 037FAC2E
	ldrh r2,[r1,#0x0]	; 037FAC30
	mov r0,#0xf	; 037FAC32
	bic r2,r0	; 037FAC34
	strh r2,[r1,#0x0]	; 037FAC36
	ldrh r2,[r1,#0x0]	; 037FAC38
	mov r0,#0x40	; 037FAC3A
	bic r2,r0	; 037FAC3C
	strh r2,[r1,#0x0]	; 037FAC3E
	add r0,sp,#0x0	; 037FAC40
	bl loc_03802890	; 037FAC42
	add sp,#0x4	; 037FAC46
	pop {r3}	; 037FAC48
	bx r3	; 037FAC4A
pool_037FAC4C:
loc_037FAC4C:
	.word 0x0380539C	; 037FAC4C

; ===== function loc_037FAC50 =====
loc_037FAC50:
	push {r4,r5,lr}	; 037FAC50
	sub sp,#0x4	; 037FAC52
	ldr r5,[sp,#0x10]	; 037FAC54
	ldr r4,[pool_037FAC70]	; 037FAC56
	str r5,[r4,#0x0]	; 037FAC58
	str r0,[r4,#0x4]	; 037FAC5A
	str r1,[r4,#0x8]	; 037FAC5C
	str r2,[r4,#0xc]	; 037FAC5E
	str r3,[r4,#0x10]	; 037FAC60
	ldr r0,[pool_037FAC74]	; 037FAC62
	bl loc_037FDEE0	; 037FAC64
	add sp,#0x4	; 037FAC68
	pop {r4,r5}	; 037FAC6A
	pop {r3}	; 037FAC6C
	bx r3	; 037FAC6E
pool_037FAC70:
loc_037FAC70:
	.word 0x038053B0	; 037FAC70
pool_037FAC74:
loc_037FAC74:
	.word 0x038053EC	; 037FAC74

; ===== function loc_037FAC78 =====
	push {r4,r5,r6,r7,lr}	; 037FAC78
	sub sp,#0x4	; 037FAC7A
	mov r6,#0x0	; 037FAC7C
	mov r7,#0x3	; 037FAC7E
	ldr r4,[pool_037FACCC]	; 037FAC80
	ldr r5,[pool_037FACD0]	; 037FAC82
loc_037FAC84:
	ldr r0,[r5,#0x0]	; 037FAC84
	bl loc_03802F38	; 037FAC86
	ldr r0,[r4,#0x0]	; 037FAC8A
	cmp r0,#0x0	; 037FAC8C
	beq loc_037FACB4	; 037FAC8E
	str r6,[r4,#0xc]	; 037FAC90
	ldr r0,[r4,#0x4]	; 037FAC92
	add r1,r7,#0x0	; 037FAC94
	ldr r2,[pool_037FACD4]	; 037FAC96
	bl loc_03803F54	; 037FAC98
	ldr r0,[r4,#0xc]	; 037FAC9C
	lsr r1,r0,#0x2	; 037FAC9E
	str r1,[r4,#0xc]	; 037FACA0
	ldr r0,[r4,#0x10]	; 037FACA2
	cmp r1,r0	; 037FACA4
	bls loc_037FACAA	; 037FACA6
loc_037FACA8:
	b loc_037FACA8	; 037FACA8
loc_037FACAA:
	ldr r0,[r4,#0x4]	; 037FACAA
	ldr r2,[r4,#0x8]	; 037FACAC
	bl loc_03803F54	; 037FACAE
	b loc_037FACBE	; 037FACB2
loc_037FACB4:
	ldr r0,[r4,#0x4]	; 037FACB4
	ldr r1,[r4,#0xc]	; 037FACB6
	ldr r2,[r4,#0x8]	; 037FACB8
	bl loc_03803F54	; 037FACBA
loc_037FACBE:
	ldr r0,[r5,#0x0]	; 037FACBE
	bl loc_03802EF0	; 037FACC0
	add r0,r6,#0x0	; 037FACC4
	bl loc_037FDF4C	; 037FACC6
	b loc_037FAC84	; 037FACCA
pool_037FACCC:
loc_037FACCC:
	.word 0x038053B0	; 037FACCC
pool_037FACD0:
loc_037FACD0:
	.word 0x038053AC	; 037FACD0
pool_037FACD4:
loc_037FACD4:
	.word 0x038053BC	; 037FACD4

; ===== function loc_037FACD8 =====
	push {lr}	; 037FACD8
	sub sp,#0x4	; 037FACDA
	ldr r0,[pool_037FACF8]	; 037FACDC
	ldr r0,[r0,#0x0]	; 037FACDE
	cmp r0,#0x0	; 037FACE0
	beq loc_037FACE8	; 037FACE2
	bl loc_038047D4	; 037FACE4
loc_037FACE8:
	ldr r2,[pool_037FACFC]	; 037FACE8
	ldr r1,[r2,#0x0]	; 037FACEA
	mov r0,#0x1	; 037FACEC
	orr r1,r0	; 037FACEE
	str r1,[r2,#0x0]	; 037FACF0
	add sp,#0x4	; 037FACF2
	pop {r3}	; 037FACF4
	bx r3	; 037FACF6
pool_037FACF8:
loc_037FACF8:
	.word 0x03807A38	; 037FACF8
pool_037FACFC:
loc_037FACFC:
	.word 0x0380FFF8	; 037FACFC
	mov r1,#0x6	; 037FAD00
	ldr r0,[pool_037FAD08]	; 037FAD02
	str r1,[r0,#0x0]	; 037FAD04
	bx lr	; 037FAD06
pool_037FAD08:
loc_037FAD08:
	.word 0x03805398	; 037FAD08
	cmp r1,#0x3	; 037FAD0C
	bne loc_037FAD18	; 037FAD0E
	mov r1,#0x6	; 037FAD10
	ldr r0,[pool_037FAD3C]	; 037FAD12
	str r1,[r0,#0x0]	; 037FAD14
	bx lr	; 037FAD16
loc_037FAD18:
	cmp r1,#0x6	; 037FAD18
	bne loc_037FAD24	; 037FAD1A
	mov r1,#0x5	; 037FAD1C
	ldr r0,[pool_037FAD3C]	; 037FAD1E
	str r1,[r0,#0x0]	; 037FAD20
	bx lr	; 037FAD22
loc_037FAD24:
	cmp r1,#0x4	; 037FAD24
	bne loc_037FAD30	; 037FAD26
	mov r1,#0x9	; 037FAD28
	ldr r0,[pool_037FAD3C]	; 037FAD2A
	str r1,[r0,#0x0]	; 037FAD2C
	bx lr	; 037FAD2E
loc_037FAD30:
	cmp r1,#0x7	; 037FAD30
	bne loc_037FAD3A	; 037FAD32
	mov r1,#0x8	; 037FAD34
	ldr r0,[pool_037FAD3C]	; 037FAD36
	str r1,[r0,#0x0]	; 037FAD38
loc_037FAD3A:
	bx lr	; 037FAD3A
pool_037FAD3C:
loc_037FAD3C:
	.word 0x03805398	; 037FAD3C

; ===== function loc_037FAD40 =====
loc_037FAD40:
	push {r4,lr}	; 037FAD40
	add r4,r0,#0x0	; 037FAD42
	mov r0,#0xae	; 037FAD44
	ldr r1,[pool_037FAD64]	; 037FAD46
	mov r2,#0x0	; 037FAD48
	bl loc_037FDD84	; 037FAD4A
	ldr r1,[pool_037FAD64]	; 037FAD4E
	ldr r0,[r1,#0x8]	; 037FAD50
	orr r0,r4	; 037FAD52
	str r0,[r1,#0x8]	; 037FAD54
	mov r0,#0xae	; 037FAD56
	mov r2,#0x0	; 037FAD58
	bl loc_037FDD10	; 037FAD5A
	pop {r4}	; 037FAD5E
	pop {r3}	; 037FAD60
	bx r3	; 037FAD62
pool_037FAD64:
loc_037FAD64:
	.word 0x027FF888	; 037FAD64
loc_037FAD68:
	push {r4,r5,r6,r7,lr}	; 037FAD68
	sub sp,#0xc	; 037FAD6A
	mov r0,#0x0	; 037FAD6C
	str r0,[sp,#0x8]	; 037FAD6E
	add r0,sp,#0x8	; 037FAD70
	ldr r1,[pool_037FAF5C]	; 037FAD72
	ldr r2,[pool_037FAF60]	; 037FAD74
	bl loc_03804918	; 037FAD76
	ldr r1,[pool_037FAF64]	; 037FAD7A
	ldr r0,[pool_037FAF68]	; 037FAD7C
	strh r1,[r0,#0x0]	; 037FAD7E
	ldr r0,[pool_037FAF6C]	; 037FAD80
	ldr r2,[pool_037FAF70]	; 037FAD82
	strh r0,[r2,#0x0]	; 037FAD84
	mov r1,#0x0	; 037FAD86
	ldr r0,[pool_037FAF74]	; 037FAD88
	str r1,[r0,#0x0]	; 037FAD8A
	str r1,[r2,#0x0]	; 037FAD8C
	mov r0,#0x1	; 037FAD8E
	bl loc_03804434	; 037FAD90
	mov r1,#0x1	; 037FAD94
	ldr r0,[pool_037FAF78]	; 037FAD96
	strh r1,[r0,#0x0]	; 037FAD98
	mov r0,#0x10	; 037FAD9A
	bl loc_038048FA	; 037FAD9C
	bl loc_037FABFC	; 037FADA0
	bl loc_037FE484	; 037FADA4
	ldr r0,[pool_037FAF7C]	; 037FADA8
	bl 0x0380f618	; 037FADAA
	bl loc_037FB010	; 037FADAE
	mov r0,#0x8	; 037FADB2
	ldr r1,[pool_037FAF80]	; 037FADB4
	bl loc_037FE4B0	; 037FADB6
	mov r0,#0x8	; 037FADBA
	ldr r1,[pool_037FAF84]	; 037FADBC
	bl loc_037FE4BC	; 037FADBE
	bl loc_038020DC	; 037FADC2
	mov r0,#0x2	; 037FADC6
	bl loc_03802F80	; 037FADC8
	mov r0,#0x3	; 037FADCC
	bl loc_037FFA9C	; 037FADCE
	mov r0,#0x8	; 037FADD2
	bl loc_03802538	; 037FADD4
	bl loc_037FAFEC	; 037FADD8
	ldr r1,[pool_037FAF88]	; 037FADDC
	str r0,[r1,#0x0]	; 037FADDE
	mov r0,#0x2	; 037FADE0
	ldr r1,[pool_037FAF8C]	; 037FADE2
	bl loc_03801FB8	; 037FADE4
	ldr r0,[pool_037FAF90]	; 037FADE8
	str r0,[sp,#0x0]	; 037FADEA
	mov r0,#0xe	; 037FADEC
	str r0,[sp,#0x4]	; 037FADEE
	ldr r0,[pool_037FAF94]	; 037FADF0
	ldr r1,[pool_037FAF98]	; 037FADF2
	mov r2,#0x0	; 037FADF4
	ldr r3,[pool_037FAF9C]	; 037FADF6
	bl loc_037FDFCC	; 037FADF8
	bl loc_037FA96C	; 037FADFC
	ldr r0,[pool_037FAFA0]	; 037FAE00
	ldr r1,[pool_037FAFA4]	; 037FAE02
	ldr r1,[r1,#0x0]	; 037FAE04
	bl loc_037FDB14	; 037FAE06
	mov r0,#0x1	; 037FAE0A
	ldr r1,[pool_037FAFA8]	; 037FAE0C
	bl loc_037FDB14	; 037FAE0E
	mov r0,#0x1	; 037FAE12
	bl loc_037FDA90	; 037FAE14
	bl loc_037FAFF8	; 037FAE18
	ldr r2,[pool_037FAFAC]	; 037FAE1C
	ldrh r0,[r2,#0x0]	; 037FAE1E
	ldrh r1,[r2,#0x0]	; 037FAE20
	mov r0,#0x8	; 037FAE22
	orr r1,r0	; 037FAE24
	strh r1,[r2,#0x0]	; 037FAE26
	ldr r1,[pool_037FAFB0]	; 037FAE28
	ldrh r0,[r1,#0x0]	; 037FAE2A
	mov r0,#0x1	; 037FAE2C
	strh r0,[r1,#0x0]	; 037FAE2E
	bl loc_037FAB60	; 037FAE30
	bl loc_037FAB20	; 037FAE34
	mov r0,#0x3	; 037FAE38
	ldr r5,[pool_037FAFB4]	; 037FAE3A
	str r0,[r5,#0x0]	; 037FAE3C
	ldr r7,[pool_037FAFB8]	; 037FAE3E
	mov r6,#0x2	; 037FAE40
	ldr r4,[pool_037FAFBC]	; 037FAE42
loc_037FAE44:
	mov r0,#0x1	; 037FAE44
	lsl r1,r0,#0	; 037FAE46
	bl loc_037FF168	; 037FAE48
	ldr r0,[r4,#0x24]	; 037FAE4C
	cmp r0,#0x3	; 037FAE4E
	bne loc_037FAE82	; 037FAE50
	ldr r1,[r7,#0x0]	; 037FAE52
	ldr r0,[pool_037FAFC0]	; 037FAE54
	and r1,r0	; 037FAE56
	cmp r1,#0x0	; 037FAE58
	beq loc_037FAE44	; 037FAE5A
	ldr r0,[r7,#0x0]	; 037FAE5C
	and r0,r6	; 037FAE5E
	cmp r0,#0x0	; 037FAE60
	beq loc_037FAE7E	; 037FAE62
	ldr r1,[r7,#0x0]	; 037FAE64
	mov r0,#0x4	; 037FAE66
	and r1,r0	; 037FAE68
	cmp r1,#0x0	; 037FAE6A
	bne loc_037FAE7E	; 037FAE6C
	bl loc_037FAB8C	; 037FAE6E
	mov r0,#0xac	; 037FAE72
	bl loc_037FDC6C	; 037FAE74
	mov r0,#0x4	; 037FAE78
	str r0,[r5,#0x0]	; 037FAE7A
	b loc_037FAE44	; 037FAE7C
loc_037FAE7E:
	str r6,[r5,#0x0]	; 037FAE7E
	b loc_037FAE44	; 037FAE80
loc_037FAE82:
	ldr r0,[r4,#0x24]	; 037FAE82
	cmp r0,#0x4	; 037FAE84
	bne loc_037FAEA8	; 037FAE86
	ldr r0,[pool_037FAFC4]	; 037FAE88
	ldr r0,[r0,#0x0]	; 037FAE8A
	bl loc_03805084	; 037FAE8C
	mov r1,#0x1	; 037FAE90
	mvn r1,r1	; 037FAE92
	cmp r0,r1	; 037FAE94
	bne loc_037FAE44	; 037FAE96
	mov r0,#0xac	; 037FAE98
	bl loc_037FDBA0	; 037FAE9A
	ldr r0,[pool_037FAFC8]	; 037FAE9E
	bl loc_037FAD40	; 037FAEA0
	str r6,[r5,#0x0]	; 037FAEA4
	b loc_037FAE44	; 037FAEA6
loc_037FAEA8:
	ldr r0,[r4,#0x24]	; 037FAEA8
	cmp r0,#0x2	; 037FAEAA
	beq loc_037FAEB4	; 037FAEAC
	ldr r0,[r4,#0x24]	; 037FAEAE
	cmp r0,#0x7	; 037FAEB0
	bne loc_037FAEC6	; 037FAEB2
loc_037FAEB4:
	ldr r0,[pool_037FAFCC]	; 037FAEB4
	ldr r0,[r0,#0x0]	; 037FAEB6
	cmp r0,#0x0	; 037FAEB8
	beq loc_037FAE44	; 037FAEBA
	str r0,[r5,#0x0]	; 037FAEBC
	mov r1,#0x0	; 037FAEBE
	ldr r0,[pool_037FAFCC]	; 037FAEC0
	str r1,[r0,#0x0]	; 037FAEC2
	b loc_037FAE44	; 037FAEC4
loc_037FAEC6:
	ldr r0,[r4,#0x24]	; 037FAEC6
	cmp r0,#0x6	; 037FAEC8
	bne loc_037FAEF0	; 037FAECA
	ldr r0,[pool_037FAFD0]	; 037FAECC
	ldr r0,[r0,#0x0]	; 037FAECE
	cmp r0,#0x7	; 037FAED0
	bne loc_037FAE44	; 037FAED2
	ldr r1,[pool_037FAFB0]	; 037FAED4
	ldrh r0,[r1,#0x0]	; 037FAED6
	mov r0,#0x0	; 037FAED8
	strh r0,[r1,#0x0]	; 037FAEDA
	bl loc_037FDABC	; 037FAEDC
	bl 0x037f8148	; 037FAEE0
	bl loc_037FA9E4	; 037FAEE4
	ldr r1,[pool_037FAFD4]	; 037FAEE8
	ldr r0,[pool_037FAFD8]	; 037FAEEA
	strh r1,[r0,#0x0]	; 037FAEEC
	b loc_037FAF52	; 037FAEEE
loc_037FAEF0:
	ldr r0,[r4,#0x24]	; 037FAEF0
	cmp r0,#0x5	; 037FAEF2
	bne loc_037FAF00	; 037FAEF4
	bl loc_037FAA90	; 037FAEF6
	mov r0,#0x7	; 037FAEFA
	str r0,[r5,#0x0]	; 037FAEFC
	b loc_037FAE44	; 037FAEFE
loc_037FAF00:
	ldr r0,[r4,#0x24]	; 037FAF00
	cmp r0,#0x8	; 037FAF02
	bne loc_037FAF1C	; 037FAF04
	mov r1,#0x6	; 037FAF06
	ldr r0,[pool_037FAFDC]	; 037FAF08
	strh r1,[r0,#0x0]	; 037FAF0A
	ldr r0,[pool_037FAFC4]	; 037FAF0C
	ldr r0,[r0,#0x0]	; 037FAF0E
	bl loc_03805084	; 037FAF10
	bl loc_037FB004	; 037FAF14
	str r6,[r5,#0x0]	; 037FAF18
	b loc_037FAE44	; 037FAF1A
loc_037FAF1C:
	ldr r0,[r4,#0x24]	; 037FAF1C
	cmp r0,#0x9	; 037FAF1E
	bne loc_037FAE44	; 037FAF20
	ldr r0,[pool_037FAFD0]	; 037FAF22
	ldr r0,[r0,#0x0]	; 037FAF24
	cmp r0,#0x9	; 037FAF26
	bne loc_037FAE44	; 037FAF28
	ldr r0,[pool_037FAFB0]	; 037FAF2A
	ldrh r0,[r0,#0x0]	; 037FAF2C
	mov r1,#0x0	; 037FAF2E
	ldr r0,[pool_037FAFB0]	; 037FAF30
	strh r1,[r0,#0x0]	; 037FAF32
	ldr r0,[pool_037FAFE0]	; 037FAF34
	ldr r1,[pool_037FAFE4]	; 037FAF36
	ldr r2,[pool_037FAFE8]	; 037FAF38
	bl loc_03804918	; 037FAF3A
	mov r0,#0x10	; 037FAF3E
	bl loc_03804902	; 037FAF40
	ldr r0,[pool_037FAF6C]	; 037FAF44
	bl loc_038048D4	; 037FAF46
	ldr r0,[pool_037FAFE4]	; 037FAF4A
	bl loc_03805084	; 037FAF4C
	b loc_037FAE44	; 037FAF50
loc_037FAF52:
	add sp,#0xc	; 037FAF52
	pop {r4,r5,r6,r7}	; 037FAF54
	pop {r3}	; 037FAF56
	bx r3	; 037FAF58
	.byte 0xC0, 0x46	; 037FAF5C
pool_037FAF5C:
loc_037FAF5C:
	.word 0x023FE800	; 037FAF5C
pool_037FAF60:
loc_037FAF60:
	.word 0x01000200	; 037FAF60
pool_037FAF64:
loc_037FAF64:
	.word 0x0000FFFF	; 037FAF64
pool_037FAF68:
loc_037FAF68:
	.word 0x04001080	; 037FAF68
pool_037FAF6C:
loc_037FAF6C:
	.word 0x00001000	; 037FAF6C
pool_037FAF70:
loc_037FAF70:
	.word 0x04000128	; 037FAF70
pool_037FAF74:
loc_037FAF74:
	.word 0x04000120	; 037FAF74
pool_037FAF78:
loc_037FAF78:
	.word 0x04000304	; 037FAF78
pool_037FAF7C:
loc_037FAF7C:
	.word 0x037FAD01	; 037FAF7C
pool_037FAF80:
loc_037FAF80:
	.word 0x03807A94	; 037FAF80
pool_037FAF84:
loc_037FAF84:
	.word 0x0380F600	; 037FAF84
pool_037FAF88:
loc_037FAF88:
	.word 0x038053AC	; 037FAF88
pool_037FAF8C:
loc_037FAF8C:
	.word 0x037FAD0D	; 037FAF8C
pool_037FAF90:
loc_037FAF90:
	.word 0x00000400	; 037FAF90
pool_037FAF94:
loc_037FAF94:
	.word 0x038053EC	; 037FAF94
pool_037FAF98:
loc_037FAF98:
	.word 0x037FAC79	; 037FAF98
pool_037FAF9C:
loc_037FAF9C:
	.word 0x03805864	; 037FAF9C
pool_037FAFA0:
loc_037FAFA0:
	.word 0x00080000	; 037FAFA0
pool_037FAFA4:
loc_037FAFA4:
	.word 0x038053A8	; 037FAFA4
pool_037FAFA8:
loc_037FAFA8:
	.word 0x037FACD9	; 037FAFA8
pool_037FAFAC:
loc_037FAFAC:
	.word 0x04000004	; 037FAFAC
pool_037FAFB0:
loc_037FAFB0:
	.word 0x04000208	; 037FAFB0
pool_037FAFB4:
loc_037FAFB4:
	.word 0x027FF884	; 037FAFB4
pool_037FAFB8:
loc_037FAFB8:
	.word 0x027FF890	; 037FAFB8
pool_037FAFBC:
loc_037FAFBC:
	.word 0x027FF860	; 037FAFBC
pool_037FAFC0:
loc_037FAFC0:
	.word 0x20000000	; 037FAFC0
pool_037FAFC4:
loc_037FAFC4:
	.word 0x038053A4	; 037FAFC4
pool_037FAFC8:
loc_037FAFC8:
	.word 0x00000200	; 037FAFC8
pool_037FAFCC:
loc_037FAFCC:
	.word 0x03805398	; 037FAFCC
pool_037FAFD0:
loc_037FAFD0:
	.word 0x027FF880	; 037FAFD0
pool_037FAFD4:
loc_037FAFD4:
	.word 0x00002100	; 037FAFD4
pool_037FAFD8:
loc_037FAFD8:
	.word 0x04000180	; 037FAFD8
pool_037FAFDC:
loc_037FAFDC:
	.word 0x027FF810	; 037FAFDC
pool_037FAFE0:
loc_037FAFE0:
	.word 0x037FA998	; 037FAFE0
pool_037FAFE4:
loc_037FAFE4:
	.word 0x037F8000	; 037FAFE4
pool_037FAFE8:
loc_037FAFE8:
	.word 0x00000100	; 037FAFE8

; ===== function loc_037FAFEC =====
loc_037FAFEC:
	bx pc	; 037FAFEC
	.byte 0xC0, 0x46	; 037FAFF0
.arm

; ===== function loc_037FAFF0 =====
loc_037FAFF0:
	ldr pc,[pool_037FAFF4]	; 037FAFF0
pool_037FAFF4:
loc_037FAFF4:
	.word 0x037FDBA8	; 037FAFF4
.thumb

; ===== function loc_037FAFF8 =====
loc_037FAFF8:
	bx pc	; 037FAFF8
	.byte 0xC0, 0x46	; 037FAFFC
.arm

; ===== function loc_037FAFFC =====
loc_037FAFFC:
	ldr pc,[pool_037FB000]	; 037FAFFC
pool_037FB000:
loc_037FB000:
	.word 0x037FF0F0	; 037FB000
.thumb

; ===== function loc_037FB004 =====
loc_037FB004:
	bx pc	; 037FB004
	.byte 0xC0, 0x46	; 037FB008
.arm

; ===== function loc_037FB008 =====
loc_037FB008:
	ldr pc,[pool_037FB00C]	; 037FB008
pool_037FB00C:
loc_037FB00C:
	.word 0x023002EC	; 037FB00C
.thumb

; ===== function loc_037FB010 =====
loc_037FB010:
	push {lr}	; 037FB010
	sub sp,#0xc	; 037FB012
	bl loc_037FB274	; 037FB014
	cmp r0,#0x0	; 037FB018
	bne loc_037FB020	; 037FB01A
	mov r0,#0x0	; 037FB01C
	b loc_037FB058	; 037FB01E
loc_037FB020:
	ldr r2,[pool_037FB060]	; 037FB020
	ldrh r1,[r2,#0x0]	; 037FB022
	mov r0,#0x2	; 037FB024
	orr r1,r0	; 037FB026
	strh r1,[r2,#0x0]	; 037FB028
	mov r1,#0x30	; 037FB02A
	ldr r0,[pool_037FB064]	; 037FB02C
	strh r1,[r0,#0x0]	; 037FB02E
	add r0,sp,#0x0	; 037FB030
	bl loc_037FB1C8	; 037FB032
	bl loc_037FB324	; 037FB036
	bl loc_037FB188	; 037FB03A
	add r0,sp,#0x0	; 037FB03E
	bl loc_037FB16C	; 037FB040
	add r0,sp,#0x0	; 037FB044
	ldrh r0,[r0,#0x0]	; 037FB046
	bl loc_037FB2DC	; 037FB048
	ldr r2,[pool_037FB060]	; 037FB04C
	ldrh r1,[r2,#0x0]	; 037FB04E
	mov r0,#0x2	; 037FB050
	bic r1,r0	; 037FB052
	strh r1,[r2,#0x0]	; 037FB054
	mov r0,#0x1	; 037FB056
loc_037FB058:
	add sp,#0xc	; 037FB058
	pop {r3}	; 037FB05A
	bx r3	; 037FB05C
	.byte 0xC0, 0x46	; 037FB060
pool_037FB060:
loc_037FB060:
	.word 0x04000304	; 037FB060
pool_037FB064:
loc_037FB064:
	.word 0x04000206	; 037FB064

; ===== function loc_037FB068 =====
loc_037FB068:
	push {r4,r5,lr}	; 037FB068
	sub sp,#0x4	; 037FB06A
	mov r5,#0x2	; 037FB06C
	str r5,[sp,#0x0]	; 037FB06E
	add r4,sp,#0x0	; 037FB070
	b loc_037FB07A	; 037FB072
loc_037FB074:
	add r0,r4,#0x0	; 037FB074
	bl loc_03804050	; 037FB076
loc_037FB07A:
	ldr r0,[sp,#0x0]	; 037FB07A
	and r0,r5	; 037FB07C
	cmp r0,#0x0	; 037FB07E
	bne loc_037FB074	; 037FB080
	add sp,#0x4	; 037FB082
	pop {r4,r5}	; 037FB084
	pop {r3}	; 037FB086
	bx r3	; 037FB088
	.byte 0x00, 0x00	; 037FB08C

; ===== function loc_037FB08C =====
loc_037FB08C:
	push {r4,r5,r6,lr}	; 037FB08C
	add r5,r0,#0x0	; 037FB08E
	add r4,r1,#0x0	; 037FB090
	add r6,r2,#0x0	; 037FB092
	bl loc_037FB068	; 037FB094
	add r0,r5,#0x0	; 037FB098
	add r1,r4,#0x0	; 037FB09A
	add r2,r6,#0x0	; 037FB09C
	bl loc_03803F54	; 037FB09E
	pop {r4,r5,r6}	; 037FB0A2
	pop {r3}	; 037FB0A4
	bx r3	; 037FB0A6

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
	.word 0x04808180	; 037FB0C4

; ===== function loc_037FB0C8 =====
loc_037FB0C8:
	push {r4,lr}	; 037FB0C8
	add r4,r0,#0x0	; 037FB0CA
	bl loc_037FB0A8	; 037FB0CC
	ldr r0,[pool_037FB0E4]	; 037FB0D0
	strh r4,[r0,#0x0]	; 037FB0D2
	lsr r1,r4,#0x10	; 037FB0D4
	ldr r0,[pool_037FB0E8]	; 037FB0D6
	strh r1,[r0,#0x0]	; 037FB0D8
	bl loc_037FB0A8	; 037FB0DA
	pop {r4}	; 037FB0DE
	pop {r3}	; 037FB0E0
	bx r3	; 037FB0E2
pool_037FB0E4:
loc_037FB0E4:
	.word 0x0480817E	; 037FB0E4
pool_037FB0E8:
loc_037FB0E8:
	.word 0x0480817C	; 037FB0E8

; ===== function loc_037FB0EC =====
loc_037FB0EC:
	ldr r0,[pool_037FB104]	; 037FB0EC
	ldr r2,[pool_037FB108]	; 037FB0EE
	mov r1,#0x1	; 037FB0F0
	b loc_037FB0FE	; 037FB0F2
loc_037FB0F4:
	ldrh r3,[r2,#0x0]	; 037FB0F4
	and r3,r1	; 037FB0F6
	cmp r3,#0x0	; 037FB0F8
	beq loc_037FB102	; 037FB0FA
	sub r0,r0,#0x1	; 037FB0FC
loc_037FB0FE:
	cmp r0,#0x0	; 037FB0FE
	bne loc_037FB0F4	; 037FB100
loc_037FB102:
	bx lr	; 037FB102
pool_037FB104:
loc_037FB104:
	.word 0x00002000	; 037FB104
pool_037FB108:
loc_037FB108:
	.word 0x0480815E	; 037FB108

; ===== function loc_037FB10C =====
loc_037FB10C:
	push {r4,r5,lr}	; 037FB10C
	sub sp,#0x4	; 037FB10E
	add r5,r0,#0x0	; 037FB110
	add r4,r1,#0x0	; 037FB112
	bl loc_037FB0EC	; 037FB114
	ldr r0,[pool_037FB134]	; 037FB118
	strh r4,[r0,#0x0]	; 037FB11A
	ldr r0,[pool_037FB138]	; 037FB11C
	orr r5,r0	; 037FB11E
	ldr r0,[pool_037FB13C]	; 037FB120
	strh r5,[r0,#0x0]	; 037FB122
	bl loc_037FB0EC	; 037FB124
	mov r0,#0x0	; 037FB128
	add sp,#0x4	; 037FB12A
	pop {r4,r5}	; 037FB12C
	pop {r3}	; 037FB12E
	bx r3	; 037FB130
	.byte 0xC0, 0x46	; 037FB134
pool_037FB134:
loc_037FB134:
	.word 0x0480815A	; 037FB134
pool_037FB138:
loc_037FB138:
	.word 0x00005000	; 037FB138
pool_037FB13C:
loc_037FB13C:
	.word 0x04808158	; 037FB13C

; ===== function loc_037FB140 =====
loc_037FB140:
	push {r4,lr}	; 037FB140
	add r4,r0,#0x0	; 037FB142
	bl loc_037FB0EC	; 037FB144
	ldr r0,[pool_037FB160]	; 037FB148
	orr r4,r0	; 037FB14A
	ldr r0,[pool_037FB164]	; 037FB14C
	strh r4,[r0,#0x0]	; 037FB14E
	bl loc_037FB0EC	; 037FB150
	ldr r0,[pool_037FB168]	; 037FB154
	ldrh r0,[r0,#0x0]	; 037FB156
	pop {r4}	; 037FB158
	pop {r3}	; 037FB15A
	bx r3	; 037FB15C
	.byte 0xC0, 0x46	; 037FB160
pool_037FB160:
loc_037FB160:
	.word 0x00006000	; 037FB160
pool_037FB164:
loc_037FB164:
	.word 0x04808158	; 037FB164
pool_037FB168:
loc_037FB168:
	.word 0x0480815C	; 037FB168

; ===== function loc_037FB16C =====
loc_037FB16C:
	ldrh r2,[r0,#0x2]	; 037FB16C
	lsr r1,r2,#0x7	; 037FB16E
	lsl r3,r1,#0x8	; 037FB170
	mov r1,#0x7f	; 037FB172
	and r2,r1	; 037FB174
	strh r2,[r0,#0x2]	; 037FB176
	ldrh r0,[r0,#0x2]	; 037FB178
	orr r3,r0	; 037FB17A
	ldr r0,[pool_037FB184]	; 037FB17C
	strh r3,[r0,#0x0]	; 037FB17E
	bx lr	; 037FB180
	.byte 0xC0, 0x46	; 037FB184
pool_037FB184:
loc_037FB184:
	.word 0x04808184	; 037FB184

; ===== function loc_037FB188 =====
loc_037FB188:
	push {r4,r5,r6,r7,lr}	; 037FB188
	sub sp,#0x4	; 037FB18A
	ldr r1,[pool_037FB1C0]	; 037FB18C
	ldr r0,[pool_037FB1C4]	; 037FB18E
	strh r1,[r0,#0x0]	; 037FB190
	mov r4,#0x64	; 037FB192
	mov r5,#0x0	; 037FB194
	str r5,[sp,#0x0]	; 037FB196
	mov r6,#0x1	; 037FB198
	add r7,sp,#0x0	; 037FB19A
loc_037FB19C:
	add r0,r4,#0x0	; 037FB19C
	add r1,r6,#0x0	; 037FB19E
	add r2,r7,#0x0	; 037FB1A0
	bl loc_037FB08C	; 037FB1A2
	add r0,r5,#0x0	; 037FB1A6
	ldr r1,[sp,#0x0]	; 037FB1A8
	bl loc_037FB10C	; 037FB1AA
	add r4,r4,#0x1	; 037FB1AE
	add r5,r5,#0x1	; 037FB1B0
	cmp r5,#0x69	; 037FB1B2
	bcc loc_037FB19C	; 037FB1B4
	add sp,#0x4	; 037FB1B6
	pop {r4,r5,r6,r7}	; 037FB1B8
	pop {r3}	; 037FB1BA
	bx r3	; 037FB1BC
	.byte 0xC0, 0x46	; 037FB1C0
pool_037FB1C0:
loc_037FB1C0:
	.word 0x00000100	; 037FB1C0
pool_037FB1C4:
loc_037FB1C4:
	.word 0x04808160	; 037FB1C4

; ===== function loc_037FB1C8 =====
loc_037FB1C8:
	push {r4,lr}	; 037FB1C8
	sub sp,#0x8	; 037FB1CA
	add r4,r0,#0x0	; 037FB1CC
	mov r1,#0x0	; 037FB1CE
	add r0,sp,#0x0	; 037FB1D0
	strh r1,[r0,#0x0]	; 037FB1D2
	ldrh r0,[r0,#0x0]	; 037FB1D4
	add r1,r4,#0x0	; 037FB1D6
	mov r2,#0x8	; 037FB1D8
	bl loc_037FB210	; 037FB1DA
	mov r0,#0x40	; 037FB1DE
	mov r1,#0x1	; 037FB1E0
	add r2,r4,#0x0	; 037FB1E2
	bl loc_037FB08C	; 037FB1E4
	mov r0,#0x41	; 037FB1E8
	mov r1,#0x1	; 037FB1EA
	add r2,r4,#0x2	; 037FB1EC
	bl loc_037FB08C	; 037FB1EE
	mov r0,#0x42	; 037FB1F2
	mov r1,#0x1	; 037FB1F4
	add r2,r4,#0x4	; 037FB1F6
	bl loc_037FB08C	; 037FB1F8
	mov r0,#0x43	; 037FB1FC
	mov r1,#0x1	; 037FB1FE
	add r2,r4,#0x6	; 037FB200
	bl loc_037FB08C	; 037FB202
	add sp,#0x8	; 037FB206
	pop {r4}	; 037FB208
	pop {r3}	; 037FB20A
	bx r3	; 037FB20C
	.byte 0xC0, 0x46	; 037FB210

; ===== function loc_037FB210 =====
loc_037FB210:
	bx pc	; 037FB210
	.byte 0xC0, 0x46	; 037FB214
.arm

; ===== function loc_037FB214 =====
loc_037FB214:
	ldr pc,[pool_037FB218]	; 037FB214
pool_037FB218:
loc_037FB218:
	.word 0x037FF31C	; 037FB218
.thumb

; ===== function loc_037FB21C =====
loc_037FB21C:
	push {r4,r5,lr}	; 037FB21C
	sub sp,#0x4	; 037FB21E
	mov r2,#0xf	; 037FB220
	add r3,r1,#0x0	; 037FB222
	and r3,r2	; 037FB224
	lsl r3,r3,#0x1	; 037FB226
	ldr r4,[pool_037FB26C]	; 037FB228
	ldrh r3,[r4,r3]	; 037FB22A
	asr r1,r1,#0x4	; 037FB22C
	ldr r5,[pool_037FB270]	; 037FB22E
	and r1,r5	; 037FB230
	lsl r1,r1,#0x10	; 037FB232
	lsr r1,r1,#0x10	; 037FB234
	eor r1,r3	; 037FB236
	add r3,r0,#0x0	; 037FB238
	and r3,r2	; 037FB23A
	lsl r3,r3,#0x1	; 037FB23C
	ldrh r3,[r4,r3]	; 037FB23E
	eor r1,r3	; 037FB240
	lsl r1,r1,#0x10	; 037FB242
	lsr r3,r1,#0x10	; 037FB244
	asr r1,r3,#0x4	; 037FB246
	and r1,r5	; 037FB248
	lsl r1,r1,#0x10	; 037FB24A
	lsr r1,r1,#0x10	; 037FB24C
	and r3,r2	; 037FB24E
	lsl r3,r3,#0x1	; 037FB250
	ldrh r3,[r4,r3]	; 037FB252
	eor r1,r3	; 037FB254
	asr r0,r0,#0x4	; 037FB256
	and r0,r2	; 037FB258
	lsl r0,r0,#0x1	; 037FB25A
	ldrh r0,[r4,r0]	; 037FB25C
	eor r1,r0	; 037FB25E
	lsl r0,r1,#0x10	; 037FB260
	lsr r0,r0,#0x10	; 037FB262
	add sp,#0x4	; 037FB264
	pop {r4,r5}	; 037FB266
	pop {r3}	; 037FB268
	bx r3	; 037FB26A
pool_037FB26C:
loc_037FB26C:
	.word 0x038050DC	; 037FB26C
pool_037FB270:
loc_037FB270:
	.word 0x00000FFF	; 037FB270

; ===== function loc_037FB274 =====
loc_037FB274:
	push {r4,r5,r6,r7,lr}	; 037FB274
	sub sp,#0xc	; 037FB276
	mov r5,#0x2a	; 037FB278
	add r0,r5,#0x0	; 037FB27A
	mov r1,#0x2	; 037FB27C
	add r2,sp,#0x0	; 037FB27E
	add r2,#0x2	; 037FB280
	bl loc_037FB08C	; 037FB282
	add r5,r5,#0x2	; 037FB286
	add r0,r5,#0x0	; 037FB288
	mov r1,#0x2	; 037FB28A
	add r2,sp,#0x4	; 037FB28C
	bl loc_037FB08C	; 037FB28E
	add r7,sp,#0x0	; 037FB292
	ldrh r1,[r7,#0x4]	; 037FB294
	ldr r0,[pool_037FB2D8]	; 037FB296
	cmp r1,r0	; 037FB298
	bcs loc_037FB2CE	; 037FB29A
	mov r6,#0x0	; 037FB29C
	add r4,r6,#0x0	; 037FB29E
	b loc_037FB2BA	; 037FB2A0
loc_037FB2A2:
	add r0,r5,#0x0	; 037FB2A2
	mov r1,#0x1	; 037FB2A4
	add r2,sp,#0x0	; 037FB2A6
	bl loc_037FB08C	; 037FB2A8
	add r5,r5,#0x1	; 037FB2AC
	ldrb r0,[r7,#0x0]	; 037FB2AE
	add r1,r6,#0x0	; 037FB2B0
	bl loc_037FB21C	; 037FB2B2
	add r6,r0,#0x0	; 037FB2B6
	add r4,r4,#0x1	; 037FB2B8
loc_037FB2BA:
	ldrh r0,[r7,#0x4]	; 037FB2BA
	cmp r4,r0	; 037FB2BC
	bcc loc_037FB2A2	; 037FB2BE
	ldrh r0,[r7,#0x2]	; 037FB2C0
	cmp r6,r0	; 037FB2C2
	bne loc_037FB2CA	; 037FB2C4
	mov r0,#0x1	; 037FB2C6
	b loc_037FB2D0	; 037FB2C8
loc_037FB2CA:
	mov r0,#0x0	; 037FB2CA
	b loc_037FB2D0	; 037FB2CC
loc_037FB2CE:
	mov r0,#0x0	; 037FB2CE
loc_037FB2D0:
	add sp,#0xc	; 037FB2D0
	pop {r4,r5,r6,r7}	; 037FB2D2
	pop {r3}	; 037FB2D4
	bx r3	; 037FB2D6
pool_037FB2D8:
loc_037FB2D8:
	.word 0x000001D6	; 037FB2D8

; ===== function loc_037FB2DC =====
loc_037FB2DC:
	push {lr}	; 037FB2DC
	sub sp,#0x4	; 037FB2DE
	cmp r0,#0x2	; 037FB2E0
	beq loc_037FB2E8	; 037FB2E2
	cmp r0,#0x3	; 037FB2E4
	b loc_037FB2EE	; 037FB2E6
loc_037FB2E8:
	ldr r0,[pool_037FB314]	; 037FB2E8
	bl loc_037FB0C8	; 037FB2EA
loc_037FB2EE:
	mov r0,#0x1e	; 037FB2EE
	bl loc_037FB140	; 037FB2F0
	mov r2,#0x3f	; 037FB2F4
	add r1,r0,#0x0	; 037FB2F6
	orr r1,r2	; 037FB2F8
	mov r0,#0x1e	; 037FB2FA
	bl loc_037FB10C	; 037FB2FC
	ldr r1,[pool_037FB318]	; 037FB300
	ldr r0,[pool_037FB31C]	; 037FB302
	strh r1,[r0,#0x0]	; 037FB304
	mov r1,#0x1	; 037FB306
	ldr r0,[pool_037FB320]	; 037FB308
	strh r1,[r0,#0x0]	; 037FB30A
	add sp,#0x4	; 037FB30C
	pop {r3}	; 037FB30E
	bx r3	; 037FB310
	.byte 0xC0, 0x46	; 037FB314
pool_037FB314:
loc_037FB314:
	.word 0x0000C008	; 037FB314
pool_037FB318:
loc_037FB318:
	.word 0x0000800D	; 037FB318
pool_037FB31C:
loc_037FB31C:
	.word 0x04808168	; 037FB31C
pool_037FB320:
loc_037FB320:
	.word 0x04808036	; 037FB320

; ===== function loc_037FB324 =====
loc_037FB324:
	push {lr}	; 037FB324
	sub sp,#0x4	; 037FB326
	mov r1,#0x0	; 037FB328
	ldr r0,[pool_037FB340]	; 037FB32A
	strh r1,[r0,#0x0]	; 037FB32C
	ldr r0,[pool_037FB344]	; 037FB32E
	bl loc_037FF1C8	; 037FB330
	mov r1,#0x0	; 037FB334
	ldr r0,[pool_037FB348]	; 037FB336
	strh r1,[r0,#0x0]	; 037FB338
	add sp,#0x4	; 037FB33A
	pop {r3}	; 037FB33C
	bx r3	; 037FB33E
pool_037FB340:
loc_037FB340:
	.word 0x04808036	; 037FB340
pool_037FB344:
loc_037FB344:
	.word 0x00051D23	; 037FB344
pool_037FB348:
loc_037FB348:
	.word 0x04808168	; 037FB348

; ===== function loc_037FB34C =====
	push {r4,r5,r6,r7,lr}	; 037FB34C
	sub sp,#0x4	; 037FB34E
	ldr r6,[pool_037FB3B4]	; 037FB350
	ldr r5,[r6,#0x0]	; 037FB352
	mov r0,#0x0	; 037FB354
	strh r0,[r5,#0x10]	; 037FB356
	strh r0,[r5,#0x14]	; 037FB358
	ldr r4,[pool_037FB3B8]	; 037FB35A
	ldr r7,[pool_037FB3BC]	; 037FB35C
loc_037FB35E:
	ldr r0,[r6,#0x0]	; 037FB35E
	ldr r0,[r0,r7]	; 037FB360
	add r1,sp,#0x0	; 037FB362
	mov r2,#0x0	; 037FB364
	bl loc_037FE288	; 037FB366
	cmp r0,#0x0	; 037FB36A
	beq loc_037FB374	; 037FB36C
	add r0,sp,#0x0	; 037FB36E
	bl loc_037FB4D4	; 037FB370
loc_037FB374:
	ldr r0,[pool_037FB3C0]	; 037FB374
	bl loc_037FDA64	; 037FB376
	ldrh r1,[r5,#0x10]	; 037FB37A
	strh r1,[r5,#0x12]	; 037FB37C
	ldrh r1,[r5,#0x12]	; 037FB37E
	lsl r1,r1,#0x1	; 037FB380
	ldrh r1,[r5,r1]	; 037FB382
	cmp r1,r4	; 037FB384
	bne loc_037FB394	; 037FB386
	ldrh r1,[r5,#0x10]	; 037FB388
	add r1,r1,#0x1	; 037FB38A
	strh r1,[r5,#0x10]	; 037FB38C
	bl loc_037FDA90	; 037FB38E
	b loc_037FB35E	; 037FB392
loc_037FB394:
	bl loc_037FDA90	; 037FB394
	ldrh r0,[r5,#0x12]	; 037FB398
	bl loc_037FB450	; 037FB39A
	strh r0,[r5,#0x14]	; 037FB39E
	ldrh r0,[r5,#0x14]	; 037FB3A0
	lsl r0,r0,#0x3	; 037FB3A2
	add r0,r5,r0	; 037FB3A4
	add r0,#0x94	; 037FB3A6
	ldr r0,[r0,#0x0]	; 037FB3A8
	bl loc_03805084	; 037FB3AA
	strh r4,[r5,#0x14]	; 037FB3AE
	b loc_037FB35E	; 037FB3B0
	.byte 0xC0, 0x46	; 037FB3B4
pool_037FB3B4:
loc_037FB3B4:
	.word 0x0380FFF4	; 037FB3B4
pool_037FB3B8:
loc_037FB3B8:
	.word 0x0000FFFF	; 037FB3B8
pool_037FB3BC:
loc_037FB3BC:
	.word 0x000002DC	; 037FB3BC
pool_037FB3C0:
loc_037FB3C0:
	.word 0x01000010	; 037FB3C0

; ===== function loc_037FB3C4 =====
loc_037FB3C4:
	push {r4,r5,r6,r7,lr}	; 037FB3C4
	sub sp,#0x4	; 037FB3C6
	add r5,r0,#0x0	; 037FB3C8
	add r6,r1,#0x0	; 037FB3CA
	ldr r0,[pool_037FB440]	; 037FB3CC
	ldr r4,[r0,#0x0]	; 037FB3CE
	add r7,r4,#0x0	; 037FB3D0
	add r7,#0x90	; 037FB3D2
	ldr r0,[pool_037FB444]	; 037FB3D4
	bl loc_037FDA64	; 037FB3D6
	str r0,[sp,#0x0]	; 037FB3DA
	lsl r1,r6,#0x3	; 037FB3DC
	add r2,r7,#0x2	; 037FB3DE
	add r0,r2,r1	; 037FB3E0
	ldrh r2,[r2,r1]	; 037FB3E2
	cmp r2,#0x0	; 037FB3E4
	bne loc_037FB416	; 037FB3E6
	mov r2,#0x1	; 037FB3E8
	strh r2,[r0,#0x0]	; 037FB3EA
	ldr r0,[pool_037FB448]	; 037FB3EC
	strh r0,[r7,r1]	; 037FB3EE
	lsl r0,r5,#0x1	; 037FB3F0
	add r2,r4,#0x0	; 037FB3F2
	add r2,#0x8	; 037FB3F4
	add r1,r2,r0	; 037FB3F6
	ldrh r3,[r2,r0]	; 037FB3F8
	ldr r2,[pool_037FB448]	; 037FB3FA
	cmp r3,r2	; 037FB3FC
	bne loc_037FB404	; 037FB3FE
	strh r6,[r4,r0]	; 037FB400
	b loc_037FB40C	; 037FB402
loc_037FB404:
	lsl r0,r3,#0x3	; 037FB404
	add r0,r4,r0	; 037FB406
	add r0,#0x90	; 037FB408
	strh r6,[r0,#0x0]	; 037FB40A
loc_037FB40C:
	strh r6,[r1,#0x0]	; 037FB40C
	ldrh r0,[r4,#0x10]	; 037FB40E
	cmp r5,r0	; 037FB410
	bge loc_037FB416	; 037FB412
	strh r5,[r4,#0x10]	; 037FB414
loc_037FB416:
	ldr r0,[sp,#0x0]	; 037FB416
	bl loc_037FDA90	; 037FB418
	cmp r5,#0x3	; 037FB41C
	beq loc_037FB436	; 037FB41E
	ldrh r0,[r4,#0x12]	; 037FB420
	cmp r0,#0x3	; 037FB422
	bne loc_037FB436	; 037FB424
	ldr r0,[pool_037FB440]	; 037FB426
	ldr r1,[r0,#0x0]	; 037FB428
	ldr r0,[pool_037FB44C]	; 037FB42A
	ldr r0,[r1,r0]	; 037FB42C
	mov r1,#0x0	; 037FB42E
	add r2,r1,#0x0	; 037FB430
	bl loc_037FE300	; 037FB432
loc_037FB436:
	add sp,#0x4	; 037FB436
	pop {r4,r5,r6,r7}	; 037FB438
	pop {r3}	; 037FB43A
	bx r3	; 037FB43C
	.byte 0xC0, 0x46	; 037FB440
pool_037FB440:
loc_037FB440:
	.word 0x0380FFF4	; 037FB440
pool_037FB444:
loc_037FB444:
	.word 0x01000010	; 037FB444
pool_037FB448:
loc_037FB448:
	.word 0x0000FFFF	; 037FB448
pool_037FB44C:
loc_037FB44C:
	.word 0x000002DC	; 037FB44C

; ===== function loc_037FB450 =====
loc_037FB450:
	push {r4,r5,r6,r7,lr}	; 037FB450
	sub sp,#0x4	; 037FB452
	add r4,r0,#0x0	; 037FB454
	ldr r0,[pool_037FB498]	; 037FB456
	ldr r5,[r0,#0x0]	; 037FB458
	ldr r0,[pool_037FB49C]	; 037FB45A
	bl loc_037FDA64	; 037FB45C
	add r7,r0,#0x0	; 037FB460
	lsl r0,r4,#0x1	; 037FB462
	add r6,r5,r0	; 037FB464
	ldrh r4,[r5,r0]	; 037FB466
	ldr r0,[pool_037FB4A0]	; 037FB468
	cmp r4,r0	; 037FB46A
	beq loc_037FB488	; 037FB46C
	add r5,#0x90	; 037FB46E
	lsl r3,r4,#0x3	; 037FB470
	mov r2,#0x0	; 037FB472
	add r1,r5,r3	; 037FB474
	strh r2,[r1,#0x2]	; 037FB476
	ldrh r1,[r5,r3]	; 037FB478
	cmp r1,r0	; 037FB47A
	bne loc_037FB484	; 037FB47C
	strh r0,[r6,#0x0]	; 037FB47E
	strh r0,[r6,#0x8]	; 037FB480
	b loc_037FB488	; 037FB482
loc_037FB484:
	strh r1,[r6,#0x0]	; 037FB484
	strh r0,[r5,r3]	; 037FB486
loc_037FB488:
	add r0,r7,#0x0	; 037FB488
	bl loc_037FDA90	; 037FB48A
	add r0,r4,#0x0	; 037FB48E
	add sp,#0x4	; 037FB490
	pop {r4,r5,r6,r7}	; 037FB492
	pop {r3}	; 037FB494
	bx r3	; 037FB496
pool_037FB498:
loc_037FB498:
	.word 0x0380FFF4	; 037FB498
pool_037FB49C:
loc_037FB49C:
	.word 0x01000010	; 037FB49C
pool_037FB4A0:
loc_037FB4A0:
	.word 0x0000FFFF	; 037FB4A0
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x58, 0x00, 0xA9, 0x01, 0x22	; 037FB4B4
	.byte 0x02, 0xF0, 0xE8, 0xFE, 0x00, 0xA8, 0x00, 0xF0, 0x0B, 0xF8, 0x03, 0x20, 0x0C, 0x21, 0xFF, 0xF7	; 037FB4C4
	.byte 0x7F, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xDC, 0x02, 0x00, 0x00	; 037FB4D4

; ===== function loc_037FB4D4 =====
loc_037FB4D4:
	push {lr}	; 037FB4D4
	sub sp,#0x4	; 037FB4D6
	ldr r1,[r0,#0x0]	; 037FB4D8
	cmp r1,#0x0	; 037FB4DA
	beq loc_037FB4F2	; 037FB4DC
	ldr r0,[pool_037FB4F8]	; 037FB4DE
	ldr r2,[r0,#0x0]	; 037FB4E0
	ldr r0,[pool_037FB4FC]	; 037FB4E2
	add r0,r2,r0	; 037FB4E4
	bl loc_037FB500	; 037FB4E6
	mov r0,#0x2	; 037FB4EA
	mov r1,#0xb	; 037FB4EC
	bl loc_037FB3C4	; 037FB4EE
loc_037FB4F2:
	add sp,#0x4	; 037FB4F2
	pop {r3}	; 037FB4F4
	bx r3	; 037FB4F6
pool_037FB4F8:
loc_037FB4F8:
	.word 0x0380FFF4	; 037FB4F8
pool_037FB4FC:
loc_037FB4FC:
	.word 0x000001D4	; 037FB4FC

; ===== function loc_037FB500 =====
loc_037FB500:
	push {r4,r5,lr}	; 037FB500
	sub sp,#0x4	; 037FB502
	add r5,r0,#0x0	; 037FB504
	add r4,r1,#0x0	; 037FB506
	ldr r0,[pool_037FB548]	; 037FB508
	bl loc_037FDA64	; 037FB50A
	ldrh r1,[r5,#0x8]	; 037FB50E
	cmp r1,#0x0	; 037FB510
	bne loc_037FB51E	; 037FB512
	mov r1,#0x0	; 037FB514
	mvn r1,r1	; 037FB516
	str r1,[r4,#0x0]	; 037FB518
	str r4,[r5,#0x0]	; 037FB51A
	b loc_037FB524	; 037FB51C
loc_037FB51E:
	ldr r1,[r5,#0x4]	; 037FB51E
	str r1,[r4,#0x0]	; 037FB520
	str r4,[r1,#0x4]	; 037FB522
loc_037FB524:
	mov r1,#0x0	; 037FB524
	mvn r1,r1	; 037FB526
	str r1,[r4,#0x4]	; 037FB528
	ldrh r1,[r5,#0xa]	; 037FB52A
	strh r1,[r4,#0x8]	; 037FB52C
	ldr r1,[pool_037FB54C]	; 037FB52E
	strh r1,[r4,#0xa]	; 037FB530
	str r4,[r5,#0x4]	; 037FB532
	ldrh r1,[r5,#0x8]	; 037FB534
	add r1,r1,#0x1	; 037FB536
	strh r1,[r5,#0x8]	; 037FB538
	bl loc_037FDA90	; 037FB53A
	mov r0,#0x0	; 037FB53E
	add sp,#0x4	; 037FB540
	pop {r4,r5}	; 037FB542
	pop {r3}	; 037FB544
	bx r3	; 037FB546
pool_037FB548:
loc_037FB548:
	.word 0x01000000	; 037FB548
pool_037FB54C:
loc_037FB54C:
	.word 0x0000BF1D	; 037FB54C

; ===== function loc_037FB550 =====
loc_037FB550:
	push {r4,r5,lr}	; 037FB550
	sub sp,#0x4	; 037FB552
	add r5,r0,#0x0	; 037FB554
	add r4,r1,#0x0	; 037FB556
	ldrh r1,[r4,#0xa]	; 037FB558
	ldr r0,[pool_037FB5D4]	; 037FB55A
	cmp r1,r0	; 037FB55C
	beq loc_037FB564	; 037FB55E
	mov r0,#0x1	; 037FB560
	b loc_037FB5CA	; 037FB562
loc_037FB564:
	ldrh r1,[r4,#0x8]	; 037FB564
	ldrh r0,[r5,#0xa]	; 037FB566
	cmp r1,r0	; 037FB568
	beq loc_037FB570	; 037FB56A
	mov r0,#0x2	; 037FB56C
	b loc_037FB5CA	; 037FB56E
loc_037FB570:
	ldr r0,[pool_037FB5D8]	; 037FB570
	bl loc_037FDA64	; 037FB572
	ldrh r1,[r5,#0x8]	; 037FB576
	sub r1,r1,#0x1	; 037FB578
	strh r1,[r5,#0x8]	; 037FB57A
	ldrh r1,[r5,#0x8]	; 037FB57C
	cmp r1,#0x0	; 037FB57E
	bne loc_037FB58C	; 037FB580
	mov r1,#0x0	; 037FB582
	mvn r1,r1	; 037FB584
	str r1,[r5,#0x0]	; 037FB586
	str r1,[r5,#0x4]	; 037FB588
	b loc_037FB5C0	; 037FB58A
loc_037FB58C:
	ldr r1,[r5,#0x0]	; 037FB58C
	cmp r4,r1	; 037FB58E
	bne loc_037FB5A0	; 037FB590
	ldr r1,[r4,#0x4]	; 037FB592
	str r1,[r5,#0x0]	; 037FB594
	mov r1,#0x0	; 037FB596
	mvn r2,r1	; 037FB598
	ldr r1,[r5,#0x0]	; 037FB59A
	str r2,[r1,#0x0]	; 037FB59C
	b loc_037FB5C0	; 037FB59E
loc_037FB5A0:
	ldr r1,[r5,#0x4]	; 037FB5A0
	cmp r4,r1	; 037FB5A2
	bne loc_037FB5B4	; 037FB5A4
	ldr r1,[r4,#0x0]	; 037FB5A6
	str r1,[r5,#0x4]	; 037FB5A8
	mov r1,#0x0	; 037FB5AA
	mvn r2,r1	; 037FB5AC
	ldr r1,[r5,#0x4]	; 037FB5AE
	str r2,[r1,#0x4]	; 037FB5B0
	b loc_037FB5C0	; 037FB5B2
loc_037FB5B4:
	ldr r2,[r4,#0x0]	; 037FB5B4
	ldr r1,[r4,#0x4]	; 037FB5B6
	str r2,[r1,#0x0]	; 037FB5B8
	ldr r2,[r4,#0x4]	; 037FB5BA
	ldr r1,[r4,#0x0]	; 037FB5BC
	str r2,[r1,#0x4]	; 037FB5BE
loc_037FB5C0:
	mov r1,#0x0	; 037FB5C0
	strh r1,[r4,#0x8]	; 037FB5C2
	bl loc_037FDA90	; 037FB5C4
	mov r0,#0x0	; 037FB5C8
loc_037FB5CA:
	add sp,#0x4	; 037FB5CA
	pop {r4,r5}	; 037FB5CC
	pop {r3}	; 037FB5CE
	bx r3	; 037FB5D0
	.byte 0xC0, 0x46	; 037FB5D4
pool_037FB5D4:
loc_037FB5D4:
	.word 0x0000BF1D	; 037FB5D4
pool_037FB5D8:
loc_037FB5D8:
	.word 0x01000000	; 037FB5D8

; ===== function loc_037FB5DC =====
	push {r4,r5,lr}	; 037FB5DC
	sub sp,#0x4	; 037FB5DE
	add r5,r0,#0x0	; 037FB5E0
	ldr r0,[pool_037FB63C]	; 037FB5E2
	ldr r2,[r0,#0x0]	; 037FB5E4
	ldr r0,[pool_037FB640]	; 037FB5E6
	add r3,r2,r0	; 037FB5E8
	cmp r1,#0x0	; 037FB5EA
	bne loc_037FB5F2	; 037FB5EC
	mov r0,#0x0	; 037FB5EE
	b loc_037FB632	; 037FB5F0
loc_037FB5F2:
	add r2,r1,#0x0	; 037FB5F2
	add r2,#0xc	; 037FB5F4
	ldr r0,[r3,#0x0]	; 037FB5F6
	cmp r0,#0x0	; 037FB5F8
	beq loc_037FB602	; 037FB5FA
	cmp r0,#0x1	; 037FB5FC
	beq loc_037FB60E	; 037FB5FE
	b loc_037FB618	; 037FB600
loc_037FB602:
	ldr r0,[r3,#0x4]	; 037FB602
	ldr r1,[r3,#0x8]	; 037FB604
	bl loc_037FE71C	; 037FB606
	add r4,r0,#0x0	; 037FB60A
	b loc_037FB618	; 037FB60C
loc_037FB60E:
	add r0,r2,#0x0	; 037FB60E
	ldr r1,[r3,#0x4]	; 037FB610
	bl loc_03805088	; 037FB612
	add r4,r0,#0x0	; 037FB616
loc_037FB618:
	cmp r4,#0x0	; 037FB618
	beq loc_037FB630	; 037FB61A
	ldr r0,[pool_037FB644]	; 037FB61C
	strh r0,[r4,#0xa]	; 037FB61E
	mov r0,#0x0	; 037FB620
	strh r0,[r4,#0x8]	; 037FB622
	add r0,r5,#0x0	; 037FB624
	add r1,r4,#0x0	; 037FB626
	bl loc_037FB6F0	; 037FB628
	add r0,r4,#0x0	; 037FB62C
	b loc_037FB632	; 037FB62E
loc_037FB630:
	mov r0,#0x0	; 037FB630
loc_037FB632:
	add sp,#0x4	; 037FB632
	pop {r4,r5}	; 037FB634
	pop {r3}	; 037FB636
	bx r3	; 037FB638
	.byte 0xC0, 0x46	; 037FB63C
pool_037FB63C:
loc_037FB63C:
	.word 0x0380FFF4	; 037FB63C
pool_037FB640:
loc_037FB640:
	.word 0x00000150	; 037FB640
pool_037FB644:
loc_037FB644:
	.word 0x0000BF1D	; 037FB644
	.byte 0x70, 0xB5, 0x0D, 0x1C, 0x11, 0x4A, 0x13, 0x68, 0x11, 0x4A, 0x9C, 0x18, 0x6B, 0x89, 0x11, 0x4A	; 037FB658
	.byte 0x93, 0x42, 0x01, 0xD0, 0x01, 0x20, 0x15, 0xE0, 0xFF, 0xF7, 0x76, 0xFF, 0x06, 0x1C, 0x00, 0x2E	; 037FB668
	.byte 0x0F, 0xD1, 0x20, 0x68, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x28, 0x06, 0xD0, 0x09, 0xE0, 0x60, 0x68	; 037FB678
	.byte 0xA1, 0x68, 0x2A, 0x1C, 0x03, 0xF0, 0x28, 0xF8, 0x03, 0xE0, 0x28, 0x1C, 0xA1, 0x68, 0x09, 0xF0	; 037FB688
	.byte 0xFF, 0xFC, 0x30, 0x1C, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 037FB698
	.byte 0x50, 0x01, 0x00, 0x00, 0x1D, 0xBF, 0x00, 0x00	; 037FB6A0

; ===== function loc_037FB6A0 =====
loc_037FB6A0:
	push {r4,r5,r6,r7,lr}	; 037FB6A0
	sub sp,#0x4	; 037FB6A2
	add r4,r0,#0x0	; 037FB6A4
	add r6,r1,#0x0	; 037FB6A6
	add r5,r2,#0x0	; 037FB6A8
	ldrh r1,[r5,#0xa]	; 037FB6AA
	ldr r0,[pool_037FB6E8]	; 037FB6AC
	cmp r1,r0	; 037FB6AE
	beq loc_037FB6B6	; 037FB6B0
	mov r0,#0x1	; 037FB6B2
	b loc_037FB6DE	; 037FB6B4
loc_037FB6B6:
	ldr r0,[pool_037FB6EC]	; 037FB6B6
	bl loc_037FDA64	; 037FB6B8
	add r7,r0,#0x0	; 037FB6BC
	add r0,r4,#0x0	; 037FB6BE
	add r1,r5,#0x0	; 037FB6C0
	bl loc_037FB550	; 037FB6C2
	add r4,r0,#0x0	; 037FB6C6
	cmp r4,#0x0	; 037FB6C8
	bne loc_037FB6D6	; 037FB6CA
	add r0,r6,#0x0	; 037FB6CC
	add r1,r5,#0x0	; 037FB6CE
	bl loc_037FB6F0	; 037FB6D0
	add r4,r0,#0x0	; 037FB6D4
loc_037FB6D6:
	add r0,r7,#0x0	; 037FB6D6
	bl loc_037FDA90	; 037FB6D8
	add r0,r4,#0x0	; 037FB6DC
loc_037FB6DE:
	add sp,#0x4	; 037FB6DE
	pop {r4,r5,r6,r7}	; 037FB6E0
	pop {r3}	; 037FB6E2
	bx r3	; 037FB6E4
	.byte 0xC0, 0x46	; 037FB6E8
pool_037FB6E8:
loc_037FB6E8:
	.word 0x0000BF1D	; 037FB6E8
pool_037FB6EC:
loc_037FB6EC:
	.word 0x01000000	; 037FB6EC

; ===== function loc_037FB6F0 =====
loc_037FB6F0:
	push {r4,r5,lr}	; 037FB6F0
	sub sp,#0x4	; 037FB6F2
	add r5,r0,#0x0	; 037FB6F4
	add r4,r1,#0x0	; 037FB6F6
	ldrh r1,[r4,#0xa]	; 037FB6F8
	ldr r0,[pool_037FB74C]	; 037FB6FA
	cmp r1,r0	; 037FB6FC
	beq loc_037FB704	; 037FB6FE
	mov r0,#0x1	; 037FB700
	b loc_037FB742	; 037FB702
loc_037FB704:
	ldrh r0,[r4,#0x8]	; 037FB704
	cmp r0,#0x0	; 037FB706
	beq loc_037FB70E	; 037FB708
	mov r0,#0x2	; 037FB70A
	b loc_037FB742	; 037FB70C
loc_037FB70E:
	ldr r0,[pool_037FB750]	; 037FB70E
	bl loc_037FDA64	; 037FB710
	ldrh r1,[r5,#0x8]	; 037FB714
	cmp r1,#0x0	; 037FB716
	bne loc_037FB724	; 037FB718
	mov r1,#0x0	; 037FB71A
	mvn r1,r1	; 037FB71C
	str r1,[r4,#0x0]	; 037FB71E
	str r4,[r5,#0x0]	; 037FB720
	b loc_037FB72A	; 037FB722
loc_037FB724:
	ldr r1,[r5,#0x4]	; 037FB724
	str r1,[r4,#0x0]	; 037FB726
	str r4,[r1,#0x4]	; 037FB728
loc_037FB72A:
	mov r1,#0x0	; 037FB72A
	mvn r1,r1	; 037FB72C
	str r1,[r4,#0x4]	; 037FB72E
	ldrh r1,[r5,#0xa]	; 037FB730
	strh r1,[r4,#0x8]	; 037FB732
	str r4,[r5,#0x4]	; 037FB734
	ldrh r1,[r5,#0x8]	; 037FB736
	add r1,r1,#0x1	; 037FB738
	strh r1,[r5,#0x8]	; 037FB73A
	bl loc_037FDA90	; 037FB73C
	mov r0,#0x0	; 037FB740
loc_037FB742:
	add sp,#0x4	; 037FB742
	pop {r4,r5}	; 037FB744
	pop {r3}	; 037FB746
	bx r3	; 037FB748
	.byte 0xC0, 0x46	; 037FB74C
pool_037FB74C:
loc_037FB74C:
	.word 0x0000BF1D	; 037FB74C
pool_037FB750:
loc_037FB750:
	.word 0x01000000	; 037FB750
	.byte 0x40, 0x68, 0x70, 0x47	; 037FB758

; ===== function loc_037FB758 =====
	push {r4,r5,r6,r7,lr}	; 037FB758
	sub sp,#0xc	; 037FB75A
	ldr r2,[pool_037FB920]	; 037FB75C
	ldr r0,[r2,#0x0]	; 037FB75E
	ldr r1,[pool_037FB924]	; 037FB760
	add r5,r0,r1	; 037FB762
	mov r1,#0x0	; 037FB764
	add r7,r1,#0x0	; 037FB766
	ldrh r3,[r5,#0x4]	; 037FB768
	cmp r3,#0x0	; 037FB76A
	beq loc_037FB770	; 037FB76C
	b loc_037FB918	; 037FB76E
loc_037FB770:
	ldr r3,[pool_037FB928]	; 037FB770
	ldr r0,[r0,r3]	; 037FB772
	str r0,[r5,#0x0]	; 037FB774
	ldr r0,[r5,#0x0]	; 037FB776
	str r0,[sp,#0x0]	; 037FB778
	mvn r3,r1	; 037FB77A
	cmp r0,r3	; 037FB77C
	bne loc_037FB782	; 037FB77E
	b loc_037FB918	; 037FB780
loc_037FB782:
	ldrh r0,[r0,#0xe]	; 037FB782
	lsl r3,r0,#0x1	; 037FB784
	ldr r0,[sp,#0x0]	; 037FB786
	add r4,r0,r3	; 037FB788
	add r4,#0x10	; 037FB78A
	ldr r0,[r2,#0x0]	; 037FB78C
	ldr r2,[pool_037FB92C]	; 037FB78E
	ldrh r2,[r0,r2]	; 037FB790
	cmp r2,#0x0	; 037FB792
	beq loc_037FB7A0	; 037FB794
	mov r0,#0x1	; 037FB796
	strh r0,[r4,#0x2]	; 037FB798
	mov r0,#0x6	; 037FB79A
	strh r0,[r4,#0x4]	; 037FB79C
	b loc_037FB8F0	; 037FB79E
loc_037FB7A0:
	ldr r2,[sp,#0x0]	; 037FB7A0
	ldrh r6,[r2,#0xc]	; 037FB7A2
	ldrh r2,[r4,#0x0]	; 037FB7A4
	cmp r6,r2	; 037FB7A6
	beq loc_037FB7B0	; 037FB7A8
	mov r0,#0xd	; 037FB7AA
	strh r0,[r4,#0x4]	; 037FB7AC
	b loc_037FB8F0	; 037FB7AE
loc_037FB7B0:
	ldr r2,[pool_037FB930]	; 037FB7B0
	add r3,r6,#0x0	; 037FB7B2
	and r3,r2	; 037FB7B4
	ldr r2,[pool_037FB934]	; 037FB7B6
	cmp r3,r2	; 037FB7B8
	bgt loc_037FB7C6	; 037FB7BA
	cmp r3,r2	; 037FB7BC
	bge loc_037FB802	; 037FB7BE
	cmp r3,#0x0	; 037FB7C0
	beq loc_037FB7DA	; 037FB7C2
	b loc_037FB892	; 037FB7C4
loc_037FB7C6:
	ldr r2,[pool_037FB938]	; 037FB7C6
	cmp r3,r2	; 037FB7C8
	bgt loc_037FB7D2	; 037FB7CA
	cmp r3,r2	; 037FB7CC
	beq loc_037FB81E	; 037FB7CE
	b loc_037FB892	; 037FB7D0
loc_037FB7D2:
	ldr r0,[pool_037FB93C]	; 037FB7D2
	cmp r3,r0	; 037FB7D4
	beq loc_037FB880	; 037FB7D6
	b loc_037FB892	; 037FB7D8
loc_037FB7DA:
	mov r7,#0x1	; 037FB7DA
	ldr r2,[pool_037FB940]	; 037FB7DC
	str r2,[sp,#0x4]	; 037FB7DE
	mov r2,#0xff	; 037FB7E0
	and r6,r2	; 037FB7E2
	lsl r2,r6,#0x10	; 037FB7E4
	lsr r2,r2,#0x10	; 037FB7E6
	mov r3,#0xb	; 037FB7E8
	ldrh r6,[r5,#0x4]	; 037FB7EA
	and r6,r7	; 037FB7EC
	cmp r6,#0x0	; 037FB7EE
	beq loc_037FB7F6	; 037FB7F0
	mov r1,#0x2	; 037FB7F2
	b loc_037FB896	; 037FB7F4
loc_037FB7F6:
	ldr r6,[pool_037FB944]	; 037FB7F6
	ldrh r0,[r0,r6]	; 037FB7F8
	cmp r0,#0x20	; 037FB7FA
	bcs loc_037FB896	; 037FB7FC
	add r1,r7,#0x0	; 037FB7FE
	b loc_037FB896	; 037FB800
loc_037FB802:
	mov r7,#0x2	; 037FB802
	ldr r2,[pool_037FB948]	; 037FB804
	str r2,[sp,#0x4]	; 037FB806
	mov r2,#0xff	; 037FB808
	and r6,r2	; 037FB80A
	lsl r2,r6,#0x10	; 037FB80C
	lsr r2,r2,#0x10	; 037FB80E
	mov r3,#0x5	; 037FB810
	ldr r6,[pool_037FB944]	; 037FB812
	ldrh r0,[r0,r6]	; 037FB814
	cmp r0,#0x40	; 037FB816
	beq loc_037FB896	; 037FB818
	mov r1,#0x1	; 037FB81A
	b loc_037FB896	; 037FB81C
loc_037FB81E:
	mov r2,#0xff	; 037FB81E
	and r6,r2	; 037FB820
	lsl r2,r6,#0x10	; 037FB822
	lsr r2,r2,#0x10	; 037FB824
	cmp r2,#0x40	; 037FB826
	bcs loc_037FB83E	; 037FB828
	ldr r3,[pool_037FB944]	; 037FB82A
	ldrh r0,[r0,r3]	; 037FB82C
	cmp r0,#0x10	; 037FB82E
	bcs loc_037FB834	; 037FB830
	mov r1,#0x1	; 037FB832
loc_037FB834:
	mov r7,#0x4	; 037FB834
	ldr r0,[pool_037FB94C]	; 037FB836
	str r0,[sp,#0x4]	; 037FB838
	mov r3,#0x16	; 037FB83A
	b loc_037FB896	; 037FB83C
loc_037FB83E:
	cmp r2,#0x80	; 037FB83E
	bcs loc_037FB85C	; 037FB840
	ldr r3,[pool_037FB944]	; 037FB842
	ldrh r0,[r0,r3]	; 037FB844
	cmp r0,#0x40	; 037FB846
	beq loc_037FB84C	; 037FB848
	mov r1,#0x1	; 037FB84A
loc_037FB84C:
	mov r7,#0x8	; 037FB84C
	ldr r0,[pool_037FB950]	; 037FB84E
	str r0,[sp,#0x4]	; 037FB850
	sub r2,#0x40	; 037FB852
	lsl r0,r2,#0x10	; 037FB854
	lsr r2,r0,#0x10	; 037FB856
	mov r3,#0x6	; 037FB858
	b loc_037FB896	; 037FB85A
loc_037FB85C:
	cmp r2,#0xc0	; 037FB85C
	bcs loc_037FB87A	; 037FB85E
	ldr r3,[pool_037FB944]	; 037FB860
	ldrh r0,[r0,r3]	; 037FB862
	cmp r0,#0x10	; 037FB864
	bcs loc_037FB86A	; 037FB866
	mov r1,#0x1	; 037FB868
loc_037FB86A:
	mov r7,#0x10	; 037FB86A
	ldr r0,[pool_037FB954]	; 037FB86C
	str r0,[sp,#0x4]	; 037FB86E
	sub r2,#0x80	; 037FB870
	lsl r0,r2,#0x10	; 037FB872
	lsr r2,r0,#0x10	; 037FB874
	mov r3,#0x16	; 037FB876
	b loc_037FB896	; 037FB878
loc_037FB87A:
	mov r2,#0x1	; 037FB87A
	add r3,r1,#0x0	; 037FB87C
	b loc_037FB896	; 037FB87E
loc_037FB880:
	mov r7,#0x40	; 037FB880
	ldr r0,[pool_037FB958]	; 037FB882
	str r0,[sp,#0x4]	; 037FB884
	mov r0,#0xff	; 037FB886
	and r6,r0	; 037FB888
	lsl r0,r6,#0x10	; 037FB88A
	lsr r2,r0,#0x10	; 037FB88C
	mov r3,#0xa	; 037FB88E
	b loc_037FB896	; 037FB890
loc_037FB892:
	mov r2,#0x1	; 037FB892
	mov r3,#0x0	; 037FB894
loc_037FB896:
	cmp r2,r3	; 037FB896
	bls loc_037FB89E	; 037FB898
	mov r1,#0x3	; 037FB89A
	b loc_037FB8BA	; 037FB89C
loc_037FB89E:
	lsl r3,r2,#0x3	; 037FB89E
	ldr r0,[sp,#0x0]	; 037FB8A0
	ldrh r6,[r0,#0xe]	; 037FB8A2
	ldr r0,[sp,#0x4]	; 037FB8A4
	ldrh r0,[r0,r3]	; 037FB8A6
	cmp r6,r0	; 037FB8A8
	bcc loc_037FB8B8	; 037FB8AA
	ldrh r6,[r4,#0x2]	; 037FB8AC
	ldr r0,[sp,#0x4]	; 037FB8AE
	add r0,r0,r3	; 037FB8B0
	ldrh r0,[r0,#0x2]	; 037FB8B2
	cmp r6,r0	; 037FB8B4
	bcs loc_037FB8BA	; 037FB8B6
loc_037FB8B8:
	mov r1,#0x4	; 037FB8B8
loc_037FB8BA:
	cmp r1,#0x0	; 037FB8BA
	beq loc_037FB8C6	; 037FB8BC
	mov r0,#0x1	; 037FB8BE
	strh r0,[r4,#0x2]	; 037FB8C0
	strh r1,[r4,#0x4]	; 037FB8C2
	b loc_037FB8F0	; 037FB8C4
loc_037FB8C6:
	ldrh r0,[r5,#0x4]	; 037FB8C6
	orr r0,r7	; 037FB8C8
	strh r0,[r5,#0x4]	; 037FB8CA
	ldr r0,[sp,#0x0]	; 037FB8CC
	add r1,r4,#0x0	; 037FB8CE
	lsl r3,r2,#0x3	; 037FB8D0
	ldr r2,[sp,#0x4]	; 037FB8D2
	add r2,r2,r3	; 037FB8D4
	ldr r2,[r2,#0x4]	; 037FB8D6
	bl loc_0380508C	; 037FB8D8
	strh r0,[r4,#0x4]	; 037FB8DC
	ldrh r0,[r4,#0x4]	; 037FB8DE
	cmp r0,#0x80	; 037FB8E0
	beq loc_037FB918	; 037FB8E2
	cmp r0,#0x81	; 037FB8E4
	bne loc_037FB8F0	; 037FB8E6
	ldrh r0,[r5,#0x4]	; 037FB8E8
	bic r0,r7	; 037FB8EA
	strh r0,[r5,#0x4]	; 037FB8EC
	b loc_037FB904	; 037FB8EE
loc_037FB8F0:
	ldrh r0,[r5,#0x4]	; 037FB8F0
	bic r0,r7	; 037FB8F2
	strh r0,[r5,#0x4]	; 037FB8F4
	ldr r0,[pool_037FB920]	; 037FB8F6
	ldr r1,[r0,#0x0]	; 037FB8F8
	ldr r0,[pool_037FB928]	; 037FB8FA
	add r0,r1,r0	; 037FB8FC
	ldr r1,[r5,#0x0]	; 037FB8FE
	bl loc_037FB960	; 037FB900
loc_037FB904:
	ldr r0,[pool_037FB920]	; 037FB904
	ldr r1,[r0,#0x0]	; 037FB906
	ldr r0,[pool_037FB95C]	; 037FB908
	ldrh r0,[r1,r0]	; 037FB90A
	cmp r0,#0x0	; 037FB90C
	beq loc_037FB918	; 037FB90E
	mov r0,#0x2	; 037FB910
	mov r1,#0xb	; 037FB912
	bl loc_037FB3C4	; 037FB914
loc_037FB918:
	add sp,#0xc	; 037FB918
	pop {r4,r5,r6,r7}	; 037FB91A
	pop {r3}	; 037FB91C
	bx r3	; 037FB91E
pool_037FB920:
loc_037FB920:
	.word 0x0380FFF4	; 037FB920
pool_037FB924:
loc_037FB924:
	.word 0x000003F8	; 037FB924
pool_037FB928:
loc_037FB928:
	.word 0x000001D4	; 037FB928
pool_037FB92C:
loc_037FB92C:
	.word 0x00000312	; 037FB92C
pool_037FB930:
loc_037FB930:
	.word 0x0000FF00	; 037FB930
pool_037FB934:
loc_037FB934:
	.word 0x00000100	; 037FB934
pool_037FB938:
loc_037FB938:
	.word 0x00000200	; 037FB938
pool_037FB93C:
loc_037FB93C:
	.word 0x00000300	; 037FB93C
pool_037FB940:
loc_037FB940:
	.word 0x0230D980	; 037FB940
pool_037FB944:
loc_037FB944:
	.word 0x00000320	; 037FB944
pool_037FB948:
loc_037FB948:
	.word 0x0230D8D8	; 037FB948
pool_037FB94C:
loc_037FB94C:
	.word 0x0230DA88	; 037FB94C
pool_037FB950:
loc_037FB950:
	.word 0x0230D900	; 037FB950
pool_037FB954:
loc_037FB954:
	.word 0x0230D9D8	; 037FB954
pool_037FB958:
loc_037FB958:
	.word 0x0230D930	; 037FB958
pool_037FB95C:
loc_037FB95C:
	.word 0x000001DC	; 037FB95C

; ===== function loc_037FB960 =====
loc_037FB960:
	push {r4,r5,lr}	; 037FB960
	sub sp,#0x4	; 037FB962
	add r5,r0,#0x0	; 037FB964
	add r4,r1,#0x0	; 037FB966
	ldr r2,[pool_037FB9B8]	; 037FB968
	ldr r2,[r2,#0x0]	; 037FB96A
	ldr r3,[pool_037FB9BC]	; 037FB96C
	ldrh r3,[r2,r3]	; 037FB96E
	cmp r3,#0x0	; 037FB970
	beq loc_037FB988	; 037FB972
	ldr r1,[pool_037FB9C0]	; 037FB974
	add r1,r2,r1	; 037FB976
	add r2,r4,#0x0	; 037FB978
	bl loc_037FB6A0	; 037FB97A
	mov r0,#0x2	; 037FB97E
	mov r1,#0x13	; 037FB980
	bl loc_037FB3C4	; 037FB982
	b loc_037FB9B0	; 037FB986
loc_037FB988:
	ldr r0,[pool_037FB9C4]	; 037FB988
	ldr r0,[r2,r0]	; 037FB98A
	mov r2,#0x0	; 037FB98C
	bl loc_037FE300	; 037FB98E
	cmp r0,#0x0	; 037FB992
	beq loc_037FB9A0	; 037FB994
	add r0,r5,#0x0	; 037FB996
	add r1,r4,#0x0	; 037FB998
	bl loc_037FB550	; 037FB99A
	b loc_037FB9B0	; 037FB99E
loc_037FB9A0:
	add r0,r5,#0x0	; 037FB9A0
	ldr r1,[pool_037FB9B8]	; 037FB9A2
	ldr r2,[r1,#0x0]	; 037FB9A4
	ldr r1,[pool_037FB9C0]	; 037FB9A6
	add r1,r2,r1	; 037FB9A8
	add r2,r4,#0x0	; 037FB9AA
	bl loc_037FB6A0	; 037FB9AC
loc_037FB9B0:
	add sp,#0x4	; 037FB9B0
	pop {r4,r5}	; 037FB9B2
	pop {r3}	; 037FB9B4
	bx r3	; 037FB9B6
pool_037FB9B8:
loc_037FB9B8:
	.word 0x0380FFF4	; 037FB9B8
pool_037FB9BC:
loc_037FB9BC:
	.word 0x000001D0	; 037FB9BC
pool_037FB9C0:
loc_037FB9C0:
	.word 0x000001C8	; 037FB9C0
pool_037FB9C4:
loc_037FB9C4:
	.word 0x000002D8	; 037FB9C4

; ===== function loc_037FB9C8 =====
	push {r4,r5,r6,r7,lr}	; 037FB9C8
	sub sp,#0xc	; 037FB9CA
	ldr r0,[pool_037FBC68]	; 037FB9CC
	ldr r1,[r0,#0x0]	; 037FB9CE
	ldr r0,[pool_037FBC6C]	; 037FB9D0
	add r4,r1,r0	; 037FB9D2
	ldr r0,[pool_037FBC70]	; 037FB9D4
	add r5,r1,r0	; 037FB9D6
	bl loc_037FBDA0	; 037FB9D8
	ldr r1,[pool_037FBC74]	; 037FB9DC
	ldrh r2,[r1,#0x0]	; 037FB9DE
	ldrh r0,[r1,#0x0]	; 037FB9E0
	lsl r0,r0,#0x8	; 037FB9E2
	add r0,r2,r0	; 037FB9E4
	ldrh r1,[r1,#0x0]	; 037FB9E6
	bl loc_037FBD18	; 037FB9E8
	mov r1,#0x1	; 037FB9EC
	add r0,r4,#0x0	; 037FB9EE
	add r0,#0x7c	; 037FB9F0
	strh r1,[r0,#0x0]	; 037FB9F2
	ldrh r0,[r5,#0x1e]	; 037FB9F4
	lsl r0,r0,#0x1d	; 037FB9F6
	lsr r0,r0,#0x1f	; 037FB9F8
	cmp r0,#0x1	; 037FB9FA
	bne loc_037FBA0E	; 037FB9FC
	add r0,r4,#0x0	; 037FB9FE
	add r0,#0x7c	; 037FBA00
	ldrh r1,[r0,#0x0]	; 037FBA02
	mov r0,#0x20	; 037FBA04
	orr r1,r0	; 037FBA06
	add r0,r4,#0x0	; 037FBA08
	add r0,#0x7c	; 037FBA0A
	strh r1,[r0,#0x0]	; 037FBA0C
loc_037FBA0E:
	ldrh r0,[r5,#0x18]	; 037FBA0E
	cmp r0,#0x0	; 037FBA10
	beq loc_037FBA24	; 037FBA12
	add r0,r4,#0x0	; 037FBA14
	add r0,#0x7c	; 037FBA16
	ldrh r1,[r0,#0x0]	; 037FBA18
	mov r0,#0x10	; 037FBA1A
	orr r1,r0	; 037FBA1C
	add r0,r4,#0x0	; 037FBA1E
	add r0,#0x7c	; 037FBA20
	strh r1,[r0,#0x0]	; 037FBA22
loc_037FBA24:
	mov r0,#0x0	; 037FBA24
	strh r0,[r4,#0x12]	; 037FBA26
	ldr r2,[pool_037FBC78]	; 037FBA28
	ldr r1,[pool_037FBC7C]	; 037FBA2A
	strh r2,[r1,#0x0]	; 037FBA2C
	ldr r2,[pool_037FBC80]	; 037FBA2E
	ldr r1,[pool_037FBC84]	; 037FBA30
	strh r2,[r1,#0x0]	; 037FBA32
	ldr r1,[pool_037FBC88]	; 037FBA34
	strh r0,[r1,#0x0]	; 037FBA36
	ldr r1,[pool_037FBC8C]	; 037FBA38
	strh r0,[r1,#0x0]	; 037FBA3A
	mov r1,#0xf	; 037FBA3C
	ldr r0,[pool_037FBC90]	; 037FBA3E
	strh r1,[r0,#0x0]	; 037FBA40
	bl loc_037FBD28	; 037FBA42
	bl loc_037FBD38	; 037FBA46
	bl loc_037FD448	; 037FBA4A
	bl loc_037FD6F0	; 037FBA4E
	ldr r1,[pool_037FBC78]	; 037FBA52
	ldr r0,[pool_037FBC94]	; 037FBA54
	strh r1,[r0,#0x0]	; 037FBA56
	ldr r1,[pool_037FBC80]	; 037FBA58
	ldr r0,[pool_037FBC98]	; 037FBA5A
	strh r1,[r0,#0x0]	; 037FBA5C
	ldr r1,[pool_037FBC9C]	; 037FBA5E
	ldr r0,[pool_037FBCA0]	; 037FBA60
	strh r1,[r0,#0x0]	; 037FBA62
	ldr r0,[pool_037FBC68]	; 037FBA64
	ldr r1,[r0,#0x0]	; 037FBA66
	ldr r0,[pool_037FBCA4]	; 037FBA68
	ldrh r1,[r1,r0]	; 037FBA6A
	mov r0,#0x8	; 037FBA6C
	and r1,r0	; 037FBA6E
	cmp r1,#0x0	; 037FBA70
	beq loc_037FBA7C	; 037FBA72
	ldr r1,[pool_037FBCA8]	; 037FBA74
	ldr r0,[pool_037FBCAC]	; 037FBA76
	strh r1,[r0,#0x0]	; 037FBA78
	b loc_037FBA82	; 037FBA7A
loc_037FBA7C:
	mov r1,#0x0	; 037FBA7C
	ldr r0,[pool_037FBCAC]	; 037FBA7E
	strh r1,[r0,#0x0]	; 037FBA80
loc_037FBA82:
	mov r6,#0x0	; 037FBA82
	ldr r1,[pool_037FBCB0]	; 037FBA84
	strh r6,[r1,#0x0]	; 037FBA86
	ldr r0,[pool_037FBCB4]	; 037FBA88
	strh r6,[r0,#0x0]	; 037FBA8A
	ldrh r2,[r4,#0xc]	; 037FBA8C
	cmp r2,#0x4	; 037FBA8E
	bls loc_037FBA94	; 037FBA90
	b loc_037FBC40	; 037FBA92
loc_037FBA94:
	add r2,r2,r2	; 037FBA94
	add r2,pc	; 037FBA96
	ldrh r2,[r2,#0x8]	; 037FBA98
	lsl r2,r2,#0x10	; 037FBA9A
	asr r2,r2,#0x10	; 037FBA9C
	add r2,pc	; 037FBA9E
	bx r2	; 037FBAA0
	.byte 0x0B, 0x00, 0x33, 0x00, 0xD3, 0x00, 0x43, 0x01, 0x8B, 0x01	; 037FBAAC
loc_037FBAAC:
	mov r3,#0x3f	; 037FBAAC
	ldr r2,[pool_037FBCB8]	; 037FBAAE
	strh r3,[r2,#0x0]	; 037FBAB0
	ldr r3,[pool_037FBC80]	; 037FBAB2
	ldr r2,[pool_037FBCBC]	; 037FBAB4
	strh r3,[r2,#0x0]	; 037FBAB6
	mov r3,#0x8	; 037FBAB8
	ldr r2,[pool_037FBCC0]	; 037FBABA
	strh r3,[r2,#0x0]	; 037FBABC
	strh r6,[r1,#0x0]	; 037FBABE
	strh r6,[r0,#0x0]	; 037FBAC0
	ldr r0,[pool_037FBCC4]	; 037FBAC2
	strh r6,[r0,#0x0]	; 037FBAC4
	mov r1,#0x1	; 037FBAC6
	ldr r0,[pool_037FBCC8]	; 037FBAC8
	strh r1,[r0,#0x0]	; 037FBACA
	mov r0,#0x40	; 037FBACC
	bl loc_037FBE78	; 037FBACE
	b loc_037FBC40	; 037FBAD2
loc_037FBAD4:
	ldr r2,[pool_037FBCCC]	; 037FBAD4
	ldr r0,[pool_037FBCB8]	; 037FBAD6
	strh r2,[r0,#0x0]	; 037FBAD8
	ldr r2,[pool_037FBC9C]	; 037FBADA
	ldr r0,[pool_037FBCA0]	; 037FBADC
	strh r2,[r0,#0x0]	; 037FBADE
	ldr r2,[pool_037FBCD0]	; 037FBAE0
	ldr r0,[pool_037FBCBC]	; 037FBAE2
	strh r2,[r0,#0x0]	; 037FBAE4
	mov r2,#0xd	; 037FBAE6
	ldr r0,[pool_037FBCC0]	; 037FBAE8
	strh r2,[r0,#0x0]	; 037FBAEA
	ldr r0,[pool_037FBCD4]	; 037FBAEC
	strh r0,[r1,#0x0]	; 037FBAEE
	mov r1,#0x1	; 037FBAF0
	ldr r0,[pool_037FBCC8]	; 037FBAF2
	strh r1,[r0,#0x0]	; 037FBAF4
	add r5,sp,#0x0	; 037FBAF6
	ldr r0,[pool_037FBCD8]	; 037FBAF8
	ldrh r0,[r0,#0x0]	; 037FBAFA
	strh r0,[r5,#0x0]	; 037FBAFC
	ldr r0,[pool_037FBCDC]	; 037FBAFE
	ldrh r0,[r0,#0x0]	; 037FBB00
	strh r0,[r5,#0x2]	; 037FBB02
	ldr r0,[pool_037FBCE0]	; 037FBB04
	ldrh r0,[r0,#0x0]	; 037FBB06
	strh r0,[r5,#0x4]	; 037FBB08
	ldr r0,[pool_037FBCE4]	; 037FBB0A
	ldrh r0,[r0,#0x0]	; 037FBB0C
	strh r0,[r5,#0x6]	; 037FBB0E
	add r0,r4,#0x0	; 037FBB10
	add r0,#0x6e	; 037FBB12
	ldrh r0,[r0,#0x0]	; 037FBB14
	lsl r7,r0,#0xa	; 037FBB16
	ldr r0,[sp,#0x0]	; 037FBB18
	ldr r1,[sp,#0x4]	; 037FBB1A
	add r2,r7,#0x0	; 037FBB1C
	add r3,r6,#0x0	; 037FBB1E
	bl loc_037FBD48	; 037FBB20
	str r0,[sp,#0x0]	; 037FBB24
	str r1,[sp,#0x4]	; 037FBB26
	lsl r3,r6,#0	; 037FBB28
	mov r2,#0x1	; 037FBB2A
	add r0,r0,r2	; 037FBB2C
	adc r1,r3	; 037FBB2E
	str r0,[sp,#0x0]	; 037FBB30
	str r1,[sp,#0x4]	; 037FBB32
	add r2,r7,#0x0	; 037FBB34
	bl loc_037FBD54	; 037FBB36
	str r0,[sp,#0x0]	; 037FBB3A
	str r1,[sp,#0x4]	; 037FBB3C
	ldrh r1,[r5,#0x6]	; 037FBB3E
	ldr r0,[pool_037FBCE8]	; 037FBB40
	strh r1,[r0,#0x0]	; 037FBB42
	ldrh r1,[r5,#0x4]	; 037FBB44
	ldr r0,[pool_037FBCEC]	; 037FBB46
	strh r1,[r0,#0x0]	; 037FBB48
	ldrh r1,[r5,#0x2]	; 037FBB4A
	ldr r0,[pool_037FBCF0]	; 037FBB4C
	strh r1,[r0,#0x0]	; 037FBB4E
	ldrh r2,[r5,#0x0]	; 037FBB50
	mov r1,#0x1	; 037FBB52
	orr r2,r1	; 037FBB54
	ldr r0,[pool_037FBCF4]	; 037FBB56
	strh r2,[r0,#0x0]	; 037FBB58
	ldr r0,[pool_037FBCC4]	; 037FBB5A
	strh r1,[r0,#0x0]	; 037FBB5C
	ldr r0,[pool_037FBCF8]	; 037FBB5E
	strh r1,[r0,#0x0]	; 037FBB60
	mov r0,#0x40	; 037FBB62
	bl loc_037FBE78	; 037FBB64
	bl loc_037FBD60	; 037FBB68
	mov r1,#0x2	; 037FBB6C
	ldr r0,[pool_037FBCFC]	; 037FBB6E
	strh r1,[r0,#0x0]	; 037FBB70
	b loc_037FBC40	; 037FBB72
loc_037FBB74:
	ldr r1,[pool_037FBD00]	; 037FBB74
	ldr r0,[pool_037FBCB8]	; 037FBB76
	strh r1,[r0,#0x0]	; 037FBB78
	ldr r1,[pool_037FBC68]	; 037FBB7A
	ldr r2,[r1,#0x0]	; 037FBB7C
	ldr r1,[pool_037FBCA4]	; 037FBB7E
	ldrh r2,[r2,r1]	; 037FBB80
	mov r1,#0x20	; 037FBB82
	and r2,r1	; 037FBB84
	cmp r2,#0x0	; 037FBB86
	beq loc_037FBB92	; 037FBB88
	ldrh r2,[r0,#0x0]	; 037FBB8A
	mov r1,#0xc0	; 037FBB8C
	orr r2,r1	; 037FBB8E
	strh r2,[r0,#0x0]	; 037FBB90
loc_037FBB92:
	ldr r0,[pool_037FBC68]	; 037FBB92
	ldr r1,[r0,#0x0]	; 037FBB94
	ldr r0,[pool_037FBCA4]	; 037FBB96
	ldrh r1,[r1,r0]	; 037FBB98
	mov r0,#0x20	; 037FBB9A
	and r1,r0	; 037FBB9C
	cmp r1,#0x0	; 037FBB9E
	beq loc_037FBBAC	; 037FBBA0
	ldr r2,[pool_037FBCAC]	; 037FBBA2
	ldrh r1,[r2,#0x0]	; 037FBBA4
	mov r0,#0x68	; 037FBBA6
	orr r1,r0	; 037FBBA8
	strh r1,[r2,#0x0]	; 037FBBAA
loc_037FBBAC:
	add r0,r4,#0x0	; 037FBBAC
	add r0,#0x64	; 037FBBAE
	ldrh r1,[r0,#0x0]	; 037FBBB0
	mov r0,#0x1	; 037FBBB2
	and r1,r0	; 037FBBB4
	cmp r1,#0x0	; 037FBBB6
	beq loc_037FBBC2	; 037FBBB8
	ldr r1,[pool_037FBD04]	; 037FBBBA
	ldr r0,[pool_037FBCBC]	; 037FBBBC
	strh r1,[r0,#0x0]	; 037FBBBE
	b loc_037FBBC8	; 037FBBC0
loc_037FBBC2:
	ldr r1,[pool_037FBD08]	; 037FBBC2
	ldr r0,[pool_037FBCBC]	; 037FBBC4
	strh r1,[r0,#0x0]	; 037FBBC6
loc_037FBBC8:
	mov r1,#0xb	; 037FBBC8
	ldr r0,[pool_037FBCC0]	; 037FBBCA
	strh r1,[r0,#0x0]	; 037FBBCC
	mov r1,#0x1	; 037FBBCE
	ldr r0,[pool_037FBCC8]	; 037FBBD0
	strh r1,[r0,#0x0]	; 037FBBD2
	ldr r0,[pool_037FBCC4]	; 037FBBD4
	strh r1,[r0,#0x0]	; 037FBBD6
	ldr r0,[pool_037FBCF8]	; 037FBBD8
	strh r1,[r0,#0x0]	; 037FBBDA
	mov r0,#0x20	; 037FBBDC
	bl loc_037FBE78	; 037FBBDE
	b loc_037FBC40	; 037FBBE2
loc_037FBBE4:
	ldr r1,[pool_037FBC80]	; 037FBBE4
	ldr r0,[pool_037FBC98]	; 037FBBE6
	strh r1,[r0,#0x0]	; 037FBBE8
	ldr r1,[pool_037FBD0C]	; 037FBBEA
	ldr r0,[pool_037FBCB8]	; 037FBBEC
	strh r1,[r0,#0x0]	; 037FBBEE
	add r0,r4,#0x0	; 037FBBF0
	add r0,#0x64	; 037FBBF2
	ldrh r0,[r0,#0x0]	; 037FBBF4
	mov r1,#0x1	; 037FBBF6
	and r0,r1	; 037FBBF8
	cmp r0,#0x0	; 037FBBFA
	beq loc_037FBC06	; 037FBBFC
	ldr r1,[pool_037FBD10]	; 037FBBFE
	ldr r0,[pool_037FBCBC]	; 037FBC00
	strh r1,[r0,#0x0]	; 037FBC02
	b loc_037FBC0A	; 037FBC04
loc_037FBC06:
	ldr r0,[pool_037FBCBC]	; 037FBC06
	strh r1,[r0,#0x0]	; 037FBC08
loc_037FBC0A:
	mov r1,#0xb	; 037FBC0A
	ldr r0,[pool_037FBCC0]	; 037FBC0C
	strh r1,[r0,#0x0]	; 037FBC0E
	mov r1,#0x1	; 037FBC10
	ldr r0,[pool_037FBCC8]	; 037FBC12
	strh r1,[r0,#0x0]	; 037FBC14
	ldr r0,[pool_037FBCC4]	; 037FBC16
	strh r1,[r0,#0x0]	; 037FBC18
	ldr r0,[pool_037FBCF8]	; 037FBC1A
	strh r1,[r0,#0x0]	; 037FBC1C
	mov r1,#0x0	; 037FBC1E
	ldr r0,[pool_037FBD14]	; 037FBC20
	strh r1,[r0,#0x0]	; 037FBC22
	mov r0,#0x20	; 037FBC24
	bl loc_037FBE78	; 037FBC26
	b loc_037FBC40	; 037FBC2A
loc_037FBC2C:
	ldr r0,[pool_037FBCB8]	; 037FBC2C
	strh r6,[r0,#0x0]	; 037FBC2E
	ldr r0,[pool_037FBCA0]	; 037FBC30
	strh r6,[r0,#0x0]	; 037FBC32
	mov r1,#0x1	; 037FBC34
	ldr r0,[pool_037FBCC8]	; 037FBC36
	strh r1,[r0,#0x0]	; 037FBC38
	mov r0,#0x20	; 037FBC3A
	bl loc_037FBE78	; 037FBC3C
loc_037FBC40:
	mov r1,#0x0	; 037FBC40
	ldr r0,[pool_037FBD14]	; 037FBC42
	strh r1,[r0,#0x0]	; 037FBC44
	bl loc_037FBD70	; 037FBC46
	mov r0,#0x2	; 037FBC4A
	ldr r1,[pool_037FBCFC]	; 037FBC4C
	strh r0,[r1,#0x0]	; 037FBC4E
	ldrh r1,[r4,#0xe]	; 037FBC50
	cmp r1,#0x1	; 037FBC52
	bne loc_037FBC5A	; 037FBC54
	bl loc_037FBD80	; 037FBC56
loc_037FBC5A:
	bl loc_037FBD90	; 037FBC5A
	add sp,#0xc	; 037FBC5E
	pop {r4,r5,r6,r7}	; 037FBC60
	pop {r3}	; 037FBC62
	bx r3	; 037FBC64
	.byte 0xC0, 0x46	; 037FBC68
pool_037FBC68:
loc_037FBC68:
	.word 0x0380FFF4	; 037FBC68
pool_037FBC6C:
loc_037FBC6C:
	.word 0x00000318	; 037FBC6C
pool_037FBC70:
loc_037FBC70:
	.word 0x000002F0	; 037FBC70
pool_037FBC74:
loc_037FBC74:
	.word 0x04808044	; 037FBC74
pool_037FBC78:
loc_037FBC78:
	.word 0x00008000	; 037FBC78
pool_037FBC7C:
loc_037FBC7C:
	.word 0x04808032	; 037FBC7C
pool_037FBC80:
loc_037FBC80:
	.word 0x0000FFFF	; 037FBC80
pool_037FBC84:
loc_037FBC84:
	.word 0x04808134	; 037FBC84
pool_037FBC88:
loc_037FBC88:
	.word 0x0480802A	; 037FBC88
pool_037FBC8C:
loc_037FBC8C:
	.word 0x04808028	; 037FBC8C
pool_037FBC90:
loc_037FBC90:
	.word 0x04808038	; 037FBC90
pool_037FBC94:
loc_037FBC94:
	.word 0x04808030	; 037FBC94
pool_037FBC98:
loc_037FBC98:
	.word 0x04808010	; 037FBC98
pool_037FBC9C:
loc_037FBC9C:
	.word 0x00001FFF	; 037FBC9C
pool_037FBCA0:
loc_037FBCA0:
	.word 0x048081AE	; 037FBCA0
pool_037FBCA4:
loc_037FBCA4:
	.word 0x00000638	; 037FBCA4
pool_037FBCA8:
loc_037FBCA8:
	.word 0x00000400	; 037FBCA8
pool_037FBCAC:
loc_037FBCAC:
	.word 0x048081AA	; 037FBCAC
pool_037FBCB0:
loc_037FBCB0:
	.word 0x04808008	; 037FBCB0
pool_037FBCB4:
loc_037FBCB4:
	.word 0x0480800A	; 037FBCB4
pool_037FBCB8:
loc_037FBCB8:
	.word 0x04808012	; 037FBCB8
pool_037FBCBC:
loc_037FBCBC:
	.word 0x048080D0	; 037FBCBC
pool_037FBCC0:
loc_037FBCC0:
	.word 0x048080E0	; 037FBCC0
pool_037FBCC4:
loc_037FBCC4:
	.word 0x048080E8	; 037FBCC4
pool_037FBCC8:
loc_037FBCC8:
	.word 0x04808004	; 037FBCC8
pool_037FBCCC:
loc_037FBCCC:
	.word 0x0000703F	; 037FBCCC
pool_037FBCD0:
loc_037FBCD0:
	.word 0x00000301	; 037FBCD0
pool_037FBCD4:
loc_037FBCD4:
	.word 0x0000E000	; 037FBCD4
pool_037FBCD8:
loc_037FBCD8:
	.word 0x048080F8	; 037FBCD8
pool_037FBCDC:
loc_037FBCDC:
	.word 0x048080FA	; 037FBCDC
pool_037FBCE0:
loc_037FBCE0:
	.word 0x048080FC	; 037FBCE0
pool_037FBCE4:
loc_037FBCE4:
	.word 0x048080FE	; 037FBCE4
pool_037FBCE8:
loc_037FBCE8:
	.word 0x048080F6	; 037FBCE8
pool_037FBCEC:
loc_037FBCEC:
	.word 0x048080F4	; 037FBCEC
pool_037FBCF0:
loc_037FBCF0:
	.word 0x048080F2	; 037FBCF0
pool_037FBCF4:
loc_037FBCF4:
	.word 0x048080F0	; 037FBCF4
pool_037FBCF8:
loc_037FBCF8:
	.word 0x048080EA	; 037FBCF8
pool_037FBCFC:
loc_037FBCFC:
	.word 0x048080AE	; 037FBCFC
pool_037FBD00:
loc_037FBD00:
	.word 0x0000E03F	; 037FBD00
pool_037FBD04:
loc_037FBD04:
	.word 0x00000581	; 037FBD04
pool_037FBD08:
loc_037FBD08:
	.word 0x00000181	; 037FBD08
pool_037FBD0C:
loc_037FBD0C:
	.word 0x0000C03F	; 037FBD0C
pool_037FBD10:
loc_037FBD10:
	.word 0x00000401	; 037FBD10
pool_037FBD14:
loc_037FBD14:
	.word 0x04808048	; 037FBD14

; ===== function loc_037FBD18 =====
loc_037FBD18:
	bx pc	; 037FBD18
	.byte 0xC0, 0x46	; 037FBD1C
.arm

; ===== function loc_037FBD1C =====
loc_037FBD1C:
	ldr r12,[pool_037FBD24]	; 037FBD1C
	bx r12	; 037FBD20
pool_037FBD24:
loc_037FBD24:
	.word 0x0230515D	; 037FBD24
.thumb

; ===== function loc_037FBD28 =====
loc_037FBD28:
	bx pc	; 037FBD28
	.byte 0xC0, 0x46	; 037FBD2C
.arm

; ===== function loc_037FBD2C =====
loc_037FBD2C:
	ldr r12,[pool_037FBD34]	; 037FBD2C
	bx r12	; 037FBD30
pool_037FBD34:
loc_037FBD34:
	.word 0x02306EE1	; 037FBD34
.thumb

; ===== function loc_037FBD38 =====
loc_037FBD38:
	bx pc	; 037FBD38
	.byte 0xC0, 0x46	; 037FBD3C
.arm

; ===== function loc_037FBD3C =====
loc_037FBD3C:
	ldr r12,[pool_037FBD44]	; 037FBD3C
	bx r12	; 037FBD40
pool_037FBD44:
loc_037FBD44:
	.word 0x0230D1C9	; 037FBD44
.thumb

; ===== function loc_037FBD48 =====
loc_037FBD48:
	bx pc	; 037FBD48
	.byte 0xC0, 0x46	; 037FBD4C
.arm

; ===== function loc_037FBD4C =====
loc_037FBD4C:
	ldr pc,[pool_037FBD50]	; 037FBD4C
pool_037FBD50:
loc_037FBD50:
	.word 0x0380494C	; 037FBD50
.thumb

; ===== function loc_037FBD54 =====
loc_037FBD54:
	bx pc	; 037FBD54
	.byte 0xC0, 0x46	; 037FBD58
.arm

; ===== function loc_037FBD58 =====
loc_037FBD58:
	ldr pc,[pool_037FBD5C]	; 037FBD58
pool_037FBD5C:
loc_037FBD5C:
	.word 0x03804B54	; 037FBD5C
.thumb

; ===== function loc_037FBD60 =====
loc_037FBD60:
	bx pc	; 037FBD60
	.byte 0xC0, 0x46	; 037FBD64
.arm

; ===== function loc_037FBD64 =====
loc_037FBD64:
	ldr r12,[pool_037FBD6C]	; 037FBD64
	bx r12	; 037FBD68
pool_037FBD6C:
loc_037FBD6C:
	.word 0x0230A3B5	; 037FBD6C
.thumb

; ===== function loc_037FBD70 =====
loc_037FBD70:
	bx pc	; 037FBD70
	.byte 0xC0, 0x46	; 037FBD74
.arm

; ===== function loc_037FBD74 =====
loc_037FBD74:
	ldr r12,[pool_037FBD7C]	; 037FBD74
	bx r12	; 037FBD78
pool_037FBD7C:
loc_037FBD7C:
	.word 0x02305D25	; 037FBD7C
.thumb

; ===== function loc_037FBD80 =====
loc_037FBD80:
	bx pc	; 037FBD80
	.byte 0xC0, 0x46	; 037FBD84
.arm

; ===== function loc_037FBD84 =====
loc_037FBD84:
	ldr r12,[pool_037FBD8C]	; 037FBD84
	bx r12	; 037FBD88
pool_037FBD8C:
loc_037FBD8C:
	.word 0x02305E91	; 037FBD8C
.thumb

; ===== function loc_037FBD90 =====
loc_037FBD90:
	bx pc	; 037FBD90
	.byte 0xC0, 0x46	; 037FBD94
.arm

; ===== function loc_037FBD94 =====
loc_037FBD94:
	ldr r12,[pool_037FBD9C]	; 037FBD94
	bx r12	; 037FBD98
pool_037FBD9C:
loc_037FBD9C:
	.word 0x02307811	; 037FBD9C
.thumb

; ===== function loc_037FBDA0 =====
loc_037FBDA0:
	push {r4,lr}	; 037FBDA0
	ldr r0,[pool_037FBDFC]	; 037FBDA2
	ldr r1,[r0,#0x0]	; 037FBDA4
	ldr r0,[pool_037FBE00]	; 037FBDA6
	add r4,r1,r0	; 037FBDA8
	bl loc_037FBE28	; 037FBDAA
	bl loc_037FBE38	; 037FBDAE
	mov r0,#0x20	; 037FBDB2
	bl loc_037FBE78	; 037FBDB4
	mov r0,#0x0	; 037FBDB8
	add r1,r4,#0x0	; 037FBDBA
	add r1,#0xa4	; 037FBDBC
	strh r0,[r1,#0x0]	; 037FBDBE
	strh r0,[r4,#0x12]	; 037FBDC0
	ldr r1,[pool_037FBE04]	; 037FBDC2
	strh r0,[r1,#0x0]	; 037FBDC4
	ldr r1,[pool_037FBE08]	; 037FBDC6
	strh r0,[r1,#0x0]	; 037FBDC8
	ldr r1,[pool_037FBE0C]	; 037FBDCA
	strh r0,[r1,#0x0]	; 037FBDCC
	ldr r1,[pool_037FBE10]	; 037FBDCE
	strh r0,[r1,#0x0]	; 037FBDD0
	ldr r1,[pool_037FBE14]	; 037FBDD2
	strh r0,[r1,#0x0]	; 037FBDD4
	ldr r1,[pool_037FBE18]	; 037FBDD6
	strh r0,[r1,#0x0]	; 037FBDD8
	ldrh r0,[r4,#0xc]	; 037FBDDA
	cmp r0,#0x1	; 037FBDDC
	bne loc_037FBDE4	; 037FBDDE
	bl loc_037FBE48	; 037FBDE0
loc_037FBDE4:
	ldr r1,[pool_037FBE1C]	; 037FBDE4
	ldr r0,[pool_037FBE20]	; 037FBDE6
	strh r1,[r0,#0x0]	; 037FBDE8
	ldr r0,[pool_037FBE24]	; 037FBDEA
	strh r1,[r0,#0x0]	; 037FBDEC
	bl loc_037FBE58	; 037FBDEE
	bl loc_037FBE68	; 037FBDF2
	pop {r4}	; 037FBDF6
	pop {r3}	; 037FBDF8
	bx r3	; 037FBDFA
pool_037FBDFC:
loc_037FBDFC:
	.word 0x0380FFF4	; 037FBDFC
pool_037FBE00:
loc_037FBE00:
	.word 0x00000318	; 037FBE00
pool_037FBE04:
loc_037FBE04:
	.word 0x04808012	; 037FBE04
pool_037FBE08:
loc_037FBE08:
	.word 0x04808004	; 037FBE08
pool_037FBE0C:
loc_037FBE0C:
	.word 0x048080EA	; 037FBE0C
pool_037FBE10:
loc_037FBE10:
	.word 0x048080E8	; 037FBE10
pool_037FBE14:
loc_037FBE14:
	.word 0x04808008	; 037FBE14
pool_037FBE18:
loc_037FBE18:
	.word 0x0480800A	; 037FBE18
pool_037FBE1C:
loc_037FBE1C:
	.word 0x0000FFFF	; 037FBE1C
pool_037FBE20:
loc_037FBE20:
	.word 0x048080AC	; 037FBE20
pool_037FBE24:
loc_037FBE24:
	.word 0x048080B4	; 037FBE24

; ===== function loc_037FBE28 =====
loc_037FBE28:
	bx pc	; 037FBE28
	.byte 0xC0, 0x46	; 037FBE2C
.arm

; ===== function loc_037FBE2C =====
loc_037FBE2C:
	ldr r12,[pool_037FBE34]	; 037FBE2C
	bx r12	; 037FBE30
pool_037FBE34:
loc_037FBE34:
	.word 0x02305469	; 037FBE34
.thumb

; ===== function loc_037FBE38 =====
loc_037FBE38:
	bx pc	; 037FBE38
	.byte 0xC0, 0x46	; 037FBE3C
.arm

; ===== function loc_037FBE3C =====
loc_037FBE3C:
	ldr r12,[pool_037FBE44]	; 037FBE3C
	bx r12	; 037FBE40
pool_037FBE44:
loc_037FBE44:
	.word 0x02305359	; 037FBE44
.thumb

; ===== function loc_037FBE48 =====
loc_037FBE48:
	bx pc	; 037FBE48
	.byte 0xC0, 0x46	; 037FBE4C
.arm

; ===== function loc_037FBE4C =====
loc_037FBE4C:
	ldr r12,[pool_037FBE54]	; 037FBE4C
	bx r12	; 037FBE50
pool_037FBE54:
loc_037FBE54:
	.word 0x0230A399	; 037FBE54
.thumb

; ===== function loc_037FBE58 =====
loc_037FBE58:
	bx pc	; 037FBE58
	.byte 0xC0, 0x46	; 037FBE5C
.arm

; ===== function loc_037FBE5C =====
loc_037FBE5C:
	ldr r12,[pool_037FBE64]	; 037FBE5C
	bx r12	; 037FBE60
pool_037FBE64:
loc_037FBE64:
	.word 0x0230A521	; 037FBE64
.thumb

; ===== function loc_037FBE68 =====
loc_037FBE68:
	bx pc	; 037FBE68
	.byte 0xC0, 0x46	; 037FBE6C
.arm

; ===== function loc_037FBE6C =====
loc_037FBE6C:
	ldr r12,[pool_037FBE74]	; 037FBE6C
	bx r12	; 037FBE70
pool_037FBE74:
loc_037FBE74:
	.word 0x02304C4D	; 037FBE74
.thumb

; ===== function loc_037FBE78 =====
loc_037FBE78:
	push {r4,r5,lr}	; 037FBE78
	sub sp,#0x4	; 037FBE7A
	add r5,r0,#0x0	; 037FBE7C
	ldr r0,[pool_037FBED4]	; 037FBE7E
	ldr r1,[r0,#0x0]	; 037FBE80
	ldr r0,[pool_037FBED8]	; 037FBE82
	add r4,r1,r0	; 037FBE84
	ldrh r0,[r4,#0x8]	; 037FBE86
	cmp r0,r5	; 037FBE88
	beq loc_037FBECC	; 037FBE8A
	cmp r0,#0x40	; 037FBE8C
	bne loc_037FBE94	; 037FBE8E
	bl loc_037FBE38	; 037FBE90
loc_037FBE94:
	cmp r5,#0x0	; 037FBE94
	beq loc_037FBEA2	; 037FBE96
	cmp r5,#0x10	; 037FBE98
	beq loc_037FBEA8	; 037FBE9A
	cmp r5,#0x40	; 037FBE9C
	beq loc_037FBEB8	; 037FBE9E
	b loc_037FBECA	; 037FBEA0
loc_037FBEA2:
	bl loc_037FBEE0	; 037FBEA2
	b loc_037FBECA	; 037FBEA6
loc_037FBEA8:
	mov r0,#0x0	; 037FBEA8
	bl loc_037FBEF0	; 037FBEAA
	bl loc_037FBDA0	; 037FBEAE
	bl loc_037FBF00	; 037FBEB2
	b loc_037FBECA	; 037FBEB6
loc_037FBEB8:
	ldrh r0,[r4,#0xc]	; 037FBEB8
	cmp r0,#0x2	; 037FBEBA
	bne loc_037FBEC2	; 037FBEBC
	bl loc_037FBF10	; 037FBEBE
loc_037FBEC2:
	mov r0,#0x64	; 037FBEC2
	ldr r1,[pool_037FBEDC]	; 037FBEC4
	bl loc_037FBF20	; 037FBEC6
loc_037FBECA:
	strh r5,[r4,#0x8]	; 037FBECA
loc_037FBECC:
	add sp,#0x4	; 037FBECC
	pop {r4,r5}	; 037FBECE
	pop {r3}	; 037FBED0
	bx r3	; 037FBED2
pool_037FBED4:
loc_037FBED4:
	.word 0x0380FFF4	; 037FBED4
pool_037FBED8:
loc_037FBED8:
	.word 0x00000318	; 037FBED8
pool_037FBEDC:
loc_037FBEDC:
	.word 0x02305409	; 037FBEDC

; ===== function loc_037FBEE0 =====
loc_037FBEE0:
	bx pc	; 037FBEE0
	.byte 0xC0, 0x46	; 037FBEE4
.arm

; ===== function loc_037FBEE4 =====
loc_037FBEE4:
	ldr r12,[pool_037FBEEC]	; 037FBEE4
	bx r12	; 037FBEE8
pool_037FBEEC:
loc_037FBEEC:
	.word 0x02305E31	; 037FBEEC
.thumb

; ===== function loc_037FBEF0 =====
loc_037FBEF0:
	bx pc	; 037FBEF0
	.byte 0xC0, 0x46	; 037FBEF4
.arm

; ===== function loc_037FBEF4 =====
loc_037FBEF4:
	ldr r12,[pool_037FBEFC]	; 037FBEF4
	bx r12	; 037FBEF8
pool_037FBEFC:
loc_037FBEFC:
	.word 0x02305E85	; 037FBEFC
.thumb

; ===== function loc_037FBF00 =====
loc_037FBF00:
	bx pc	; 037FBF00
	.byte 0xC0, 0x46	; 037FBF04
.arm

; ===== function loc_037FBF04 =====
loc_037FBF04:
	ldr r12,[pool_037FBF0C]	; 037FBF04
	bx r12	; 037FBF08
pool_037FBF0C:
loc_037FBF0C:
	.word 0x02305DC9	; 037FBF0C
.thumb

; ===== function loc_037FBF10 =====
loc_037FBF10:
	bx pc	; 037FBF10
	.byte 0xC0, 0x46	; 037FBF14
.arm

; ===== function loc_037FBF14 =====
loc_037FBF14:
	ldr r12,[pool_037FBF1C]	; 037FBF14
	bx r12	; 037FBF18
pool_037FBF1C:
loc_037FBF1C:
	.word 0x02305D01	; 037FBF1C
.thumb

; ===== function loc_037FBF20 =====
loc_037FBF20:
	bx pc	; 037FBF20
	.byte 0xC0, 0x46	; 037FBF24
.arm

; ===== function loc_037FBF24 =====
loc_037FBF24:
	ldr r12,[pool_037FBF2C]	; 037FBF24
	bx r12	; 037FBF28
pool_037FBF2C:
loc_037FBF2C:
	.word 0x02305481	; 037FBF2C
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x01, 0x27, 0x32, 0x4C, 0x32, 0x4E, 0x25, 0x88, 0x30, 0x88, 0x05, 0x40	; 037FBF40
	.byte 0x00, 0x2D, 0x53, 0xD0, 0x29, 0x1C, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0	; 037FBF50
	.byte 0x85, 0xFD, 0x29, 0x1C, 0x40, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xBE, 0xFD	; 037FBF60
	.byte 0x29, 0x1C, 0x29, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0x63, 0xF8, 0x29, 0x1C	; 037FBF70
	.byte 0x26, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0x98, 0xF8, 0x29, 0x1C, 0x24, 0x48	; 037FBF80
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xB5, 0xF9, 0x29, 0x1C, 0x21, 0x48, 0x01, 0x40	; 037FBF90
	.byte 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0x46, 0xF8, 0x29, 0x1C, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29	; 037FBFA0
	.byte 0x01, 0xD0, 0x00, 0xF0, 0xEF, 0xF9, 0x29, 0x1C, 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0	; 037FBFB0
	.byte 0x00, 0xF0, 0x56, 0xFA, 0x28, 0x1C, 0x38, 0x40, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0xF4, 0xFB	; 037FBFC0
	.byte 0x29, 0x1C, 0x30, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xBF, 0xF9, 0x29, 0x1C	; 037FBFD0
	.byte 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0xF0, 0xFA, 0xFA, 0x0E, 0x48, 0x05, 0x40	; 037FBFE0
	.byte 0x00, 0x2D, 0xAA, 0xD0, 0x38, 0x1C, 0x00, 0xF0, 0xD9, 0xFC, 0xA6, 0xE7, 0x0B, 0x4A, 0x11, 0x68	; 037FBFF0
	.byte 0x0B, 0x48, 0x01, 0x43, 0x11, 0x60, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FC000
	.byte 0x10, 0x80, 0x80, 0x04, 0x12, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00	; 037FC010
	.byte 0x00, 0x20, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0xF8, 0xFF, 0x80, 0x03	; 037FC020
	.byte 0x00, 0x00, 0x00, 0x01, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FC030
	.byte 0x3D, 0x6E, 0x30, 0x02, 0x10, 0xB5, 0x19, 0x48, 0x01, 0x68, 0x19, 0x48, 0x0C, 0x18, 0x19, 0x49	; 037FC040
	.byte 0x19, 0x48, 0x01, 0x80, 0x20, 0x89, 0x40, 0x28, 0x23, 0xD1, 0x20, 0x1C, 0x7E, 0x30, 0x00, 0x88	; 037FC050
	.byte 0x00, 0x28, 0x1E, 0xD0, 0x20, 0x1C, 0x72, 0x30, 0x01, 0x88, 0x20, 0x1C, 0x70, 0x30, 0x00, 0x88	; 037FC060
	.byte 0x81, 0x42, 0x16, 0xD1, 0x20, 0x1C, 0x80, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x20, 0x1C, 0x80, 0x30	; 037FC070
	.byte 0x01, 0x80, 0x20, 0x1C, 0x80, 0x30, 0x01, 0x88, 0x20, 0x1C, 0x7E, 0x30, 0x00, 0x88, 0x81, 0x42	; 037FC080
	.byte 0x07, 0xD9, 0x00, 0x21, 0x20, 0x1C, 0x80, 0x30, 0x01, 0x80, 0x01, 0x20, 0x0D, 0x21, 0xFF, 0xF7	; 037FC090
	.byte 0x99, 0xF9, 0x01, 0x20, 0x20, 0x82, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 037FC0A0
	.byte 0x18, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0xF0, 0xB5, 0x83, 0xB0	; 037FC0B0
	.byte 0x7B, 0x48, 0x01, 0x68, 0x7B, 0x48, 0x0D, 0x18, 0x7B, 0x48, 0x0E, 0x18, 0x7B, 0x48, 0x0C, 0x18	; 037FC0C0
	.byte 0x7B, 0x49, 0x7C, 0x48, 0x01, 0x80, 0xA8, 0x89, 0x01, 0x28, 0x04, 0xD0, 0x02, 0x28, 0x4B, 0xD0	; 037FC0D0
	.byte 0x03, 0x28, 0x5C, 0xD0, 0xE0, 0xE0, 0x20, 0x1C, 0x80, 0x30, 0x01, 0x68, 0x24, 0x31, 0x28, 0x1C	; 037FC0E0
	.byte 0x96, 0x30, 0x00, 0x88, 0x0F, 0x18, 0x08, 0x37, 0x73, 0x48, 0x00, 0x88, 0x00, 0x90, 0x38, 0x1C	; 037FC0F0
	.byte 0x00, 0x99, 0x09, 0x06, 0x09, 0x0E, 0x00, 0xF0, 0xF5, 0xF8, 0x78, 0x1C, 0x00, 0x99, 0x09, 0x0A	; 037FC100
	.byte 0x09, 0x06, 0x09, 0x0E, 0x00, 0xF0, 0xEE, 0xF8, 0xE8, 0x89, 0x01, 0x28, 0x05, 0xD1, 0x32, 0x8C	; 037FC110
	.byte 0x6A, 0x49, 0x08, 0x88, 0x10, 0x18, 0x40, 0x1C, 0x08, 0x80, 0x61, 0x48, 0x00, 0x68, 0x68, 0x49	; 037FC120
	.byte 0x41, 0x5A, 0xCA, 0x43, 0x67, 0x49, 0x41, 0x5A, 0x0A, 0x43, 0x67, 0x49, 0x42, 0x52, 0x67, 0x48	; 037FC130
	.byte 0x02, 0x88, 0x18, 0x20, 0x11, 0x1C, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1, 0x06, 0x20, 0x02, 0x40	; 037FC140
	.byte 0x02, 0x2A, 0x09, 0xD1, 0x20, 0x1C, 0x8C, 0x30, 0x01, 0x68, 0x02, 0x20, 0x81, 0x43, 0x8C, 0x34	; 037FC150
	.byte 0x21, 0x60, 0x00, 0xF0, 0xB5, 0xFD, 0x9F, 0xE0, 0x20, 0x1C, 0x8C, 0x30, 0x01, 0x68, 0x02, 0x20	; 037FC160
	.byte 0x01, 0x43, 0x8C, 0x34, 0x21, 0x60, 0x97, 0xE0, 0x68, 0x8A, 0x00, 0x28, 0x06, 0xD0, 0x32, 0x8C	; 037FC170
	.byte 0x52, 0x49, 0x08, 0x88, 0x10, 0x18, 0x40, 0x1C, 0x08, 0x80, 0x02, 0xE0, 0x54, 0x49, 0x4F, 0x48	; 037FC180
	.byte 0x01, 0x80, 0x68, 0x8B, 0x02, 0x28, 0x02, 0xD1, 0x02, 0x20, 0xFF, 0xF7, 0xF9, 0xFD, 0x28, 0x89	; 037FC190
	.byte 0x40, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x16, 0xE0, 0x00, 0x20, 0x29, 0x1C, 0x72, 0x31, 0x09, 0x88	; 037FC1A0
	.byte 0x01, 0x29, 0x00, 0xD1, 0x01, 0x20, 0xA9, 0x8A, 0x00, 0x29, 0x0C, 0xD0, 0x29, 0x1C, 0x76, 0x31	; 037FC1B0
	.byte 0x09, 0x88, 0x01, 0x29, 0x06, 0xD0, 0x00, 0x29, 0x05, 0xD1, 0x29, 0x1C, 0x74, 0x31, 0x09, 0x88	; 037FC1C0
	.byte 0x01, 0x29, 0x00, 0xD1, 0x01, 0x20, 0x00, 0x28, 0x05, 0xD0, 0x42, 0x4A, 0x11, 0x88, 0x01, 0x20	; 037FC1D0
	.byte 0x01, 0x43, 0x11, 0x80, 0x04, 0xE0, 0x3F, 0x4A, 0x11, 0x88, 0x01, 0x20, 0x81, 0x43, 0x11, 0x80	; 037FC1E0
	.byte 0x3D, 0x48, 0x00, 0x88, 0x0A, 0x28, 0x02, 0xD9, 0x00, 0x21, 0x3C, 0x48, 0x01, 0x80, 0x28, 0x1C	; 037FC1F0
	.byte 0x72, 0x30, 0x00, 0x88, 0x41, 0x1E, 0x28, 0x1C, 0x72, 0x30, 0x01, 0x80, 0x28, 0x1C, 0x72, 0x30	; 037FC200
	.byte 0x00, 0x88, 0x00, 0x28, 0x05, 0xD1, 0x28, 0x1C, 0x70, 0x30, 0x01, 0x88, 0x28, 0x1C, 0x72, 0x30	; 037FC210
	.byte 0x01, 0x80, 0x28, 0x1C, 0x76, 0x30, 0x02, 0x88, 0x28, 0x1C, 0x76, 0x30, 0x00, 0x88, 0x41, 0x1E	; 037FC220
	.byte 0x28, 0x1C, 0x76, 0x30, 0x01, 0x80, 0x00, 0x2A, 0x06, 0xD1, 0x28, 0x1C, 0x74, 0x30, 0x00, 0x88	; 037FC230
	.byte 0x41, 0x1E, 0x28, 0x1C, 0x76, 0x30, 0x01, 0x80, 0x00, 0x26, 0x01, 0x96, 0x31, 0x1C, 0x14, 0x20	; 037FC240
	.byte 0x41, 0x43, 0x67, 0x18, 0x60, 0x5A, 0x00, 0x28, 0x20, 0xD0, 0xF8, 0x68, 0x01, 0x89, 0x00, 0x29	; 037FC250
	.byte 0x1C, 0xD1, 0x29, 0x1C, 0xA8, 0x31, 0x09, 0x68, 0x80, 0x88, 0x08, 0x1A, 0x00, 0x04, 0x01, 0x0C	; 037FC260
	.byte 0x28, 0x1C, 0x8C, 0x30, 0x00, 0x88, 0x81, 0x42, 0x10, 0xD9, 0x30, 0x1C, 0x00, 0xF0, 0x58, 0xFD	; 037FC270
	.byte 0xB9, 0x68, 0x02, 0x20, 0x08, 0x80, 0x01, 0x98, 0x0E, 0x21, 0xFF, 0xF7, 0xA3, 0xF8, 0x20, 0x1C	; 037FC280
	.byte 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x20, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0x76, 0x1C, 0x02, 0x2E	; 037FC290
	.byte 0xD4, 0xD3, 0x0D, 0x21, 0x12, 0x48, 0x01, 0x80, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FC2A0
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00	; 037FC2B0
	.byte 0x00, 0x40, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0xF0, 0xFF, 0x80, 0x03, 0x34, 0x81, 0x80, 0x04	; 037FC2C0
	.byte 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00, 0x08, 0x05, 0x00, 0x00, 0xB6, 0x80, 0x80, 0x04	; 037FC2D0
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x38, 0x80, 0x80, 0x04, 0x18, 0x81, 0x80, 0x04, 0x48, 0x80, 0x80, 0x04	; 037FC2E0
	.byte 0xAE, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FC2F0
	.byte 0xA5, 0x51, 0x30, 0x02, 0x0F, 0x48, 0x01, 0x68, 0x0F, 0x48, 0x08, 0x18, 0x0F, 0x4A, 0x10, 0x49	; 037FC300
	.byte 0x0A, 0x80, 0x0D, 0x22, 0x0F, 0x49, 0x0A, 0x80, 0x41, 0x8B, 0x01, 0x29, 0x02, 0xD1, 0x02, 0x21	; 037FC310
	.byte 0x41, 0x83, 0x70, 0x47, 0x02, 0x29, 0x02, 0xD1, 0x00, 0x21, 0x41, 0x83, 0x70, 0x47, 0x81, 0x89	; 037FC320
	.byte 0x02, 0x29, 0x05, 0xD1, 0x00, 0x89, 0x40, 0x28, 0x02, 0xD0, 0x00, 0x21, 0x06, 0x48, 0x01, 0x80	; 037FC330
	.byte 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00	; 037FC340
	.byte 0x10, 0x80, 0x80, 0x04, 0xAC, 0x80, 0x80, 0x04, 0x48, 0x80, 0x80, 0x04, 0x00, 0xB5, 0x81, 0xB0	; 037FC350
	.byte 0x00, 0xF0, 0x10, 0xF8, 0x04, 0x49, 0x05, 0x48, 0x01, 0x80, 0x30, 0x21, 0x04, 0x48, 0x01, 0x80	; 037FC360
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xFF, 0xFF, 0x00, 0x00, 0xAC, 0x81, 0x80, 0x04	; 037FC370
	.byte 0x10, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FC380
	.byte 0x59, 0x59, 0x30, 0x02, 0xF0, 0xB5, 0x81, 0xB0, 0x08, 0x21, 0x2A, 0x48, 0x01, 0x80, 0x2A, 0x48	; 037FC390
	.byte 0x01, 0x68, 0x2A, 0x48, 0x08, 0x5A, 0xC0, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x09, 0xD0, 0x28, 0x48	; 037FC3A0
	.byte 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1, 0x26, 0x4A, 0x11, 0x88, 0x41, 0x40	; 037FC3B0
	.byte 0x11, 0x80, 0x21, 0x48, 0x02, 0x68, 0x24, 0x48, 0x11, 0x5A, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29	; 037FC3C0
	.byte 0x33, 0xD0, 0x22, 0x48, 0x15, 0x18, 0x22, 0x48, 0x14, 0x18, 0x00, 0x26, 0x31, 0x1C, 0x21, 0x48	; 037FC3D0
	.byte 0x33, 0x1C, 0x14, 0x22, 0x53, 0x43, 0xE7, 0x18, 0xE2, 0x5A, 0x00, 0x2A, 0x22, 0xD0, 0xBB, 0x68	; 037FC3E0
	.byte 0x9F, 0x89, 0x1D, 0x4A, 0x17, 0x40, 0x00, 0x2F, 0x1C, 0xD0, 0x9F, 0x88, 0xFF, 0x22, 0x17, 0x40	; 037FC3F0
	.byte 0x00, 0x2F, 0x17, 0xD0, 0x1F, 0x1C, 0x0C, 0x37, 0x5A, 0x89, 0xBA, 0x18, 0xD2, 0x1F, 0x01, 0x27	; 037FC400
	.byte 0xBA, 0x43, 0x17, 0x88, 0x00, 0x2F, 0x0D, 0xD1, 0x52, 0x88, 0x00, 0x2A, 0x0A, 0xD1, 0x99, 0x80	; 037FC410
	.byte 0x01, 0x80, 0x12, 0x4A, 0x02, 0x80, 0x2A, 0x1C, 0xBA, 0x32, 0x12, 0x88, 0x53, 0x1C, 0x2A, 0x1C	; 037FC420
	.byte 0xBA, 0x32, 0x13, 0x80, 0x76, 0x1C, 0x03, 0x2E, 0xD2, 0xD3, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 037FC430
	.byte 0x18, 0x47, 0xC0, 0x46, 0x10, 0x80, 0x80, 0x04, 0xF4, 0xFF, 0x80, 0x03, 0x0E, 0x03, 0x00, 0x00	; 037FC440
	.byte 0x9C, 0x81, 0x80, 0x04, 0x90, 0x82, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00, 0x18, 0x03, 0x00, 0x00	; 037FC450
	.byte 0x00, 0x04, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04, 0x00, 0x40, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 037FC460
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x3D, 0x48, 0x02, 0x68, 0x3D, 0x49, 0x53, 0x18, 0x3D, 0x4C, 0x12, 0x19	; 037FC470
	.byte 0x04, 0x25, 0x3D, 0x49, 0x0D, 0x80, 0x3D, 0x49, 0x09, 0x88, 0x05, 0x68, 0x3C, 0x48, 0x2D, 0x5A	; 037FC480
	.byte 0x08, 0x20, 0x05, 0x40, 0x00, 0x2D, 0x3B, 0xD0, 0x08, 0x1C, 0x20, 0x40, 0x00, 0x28, 0x37, 0xD0	; 037FC490
	.byte 0x38, 0x48, 0x00, 0x88, 0x01, 0x24, 0x05, 0x1C, 0x25, 0x40, 0x00, 0x2D, 0x02, 0xD0, 0x14, 0x88	; 037FC4A0
	.byte 0x00, 0x2C, 0x1B, 0xD1, 0x04, 0x24, 0x05, 0x1C, 0x25, 0x40, 0x00, 0x2D, 0x02, 0xD0, 0x94, 0x8A	; 037FC4B0
	.byte 0x00, 0x2C, 0x13, 0xD1, 0x08, 0x24, 0x20, 0x40, 0x00, 0x28, 0x02, 0xD0, 0x10, 0x8D, 0x00, 0x28	; 037FC4C0
	.byte 0x0C, 0xD1, 0x2D, 0x48, 0x02, 0x88, 0x01, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x06, 0xD1, 0x00, 0x24	; 037FC4D0
	.byte 0x2A, 0x4A, 0x14, 0x80, 0x2A, 0x48, 0x10, 0x80, 0x5C, 0x80, 0x11, 0xE0, 0x5A, 0x88, 0x50, 0x1C	; 037FC4E0
	.byte 0x58, 0x80, 0x0C, 0x2A, 0x0C, 0xD9, 0x00, 0x20, 0x58, 0x80, 0x24, 0x4A, 0x10, 0x80, 0x24, 0x48	; 037FC4F0
	.byte 0x10, 0x80, 0x1A, 0x48, 0x02, 0x68, 0x23, 0x48, 0x10, 0x18, 0x02, 0x88, 0x52, 0x1C, 0x02, 0x80	; 037FC500
	.byte 0x16, 0x48, 0x02, 0x68, 0x1A, 0x48, 0x12, 0x5A, 0x01, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x20, 0xD0	; 037FC510
	.byte 0x60, 0x20, 0x01, 0x40, 0x00, 0x29, 0x1C, 0xD0, 0x1B, 0x48, 0x04, 0x88, 0x1B, 0x48, 0x01, 0x88	; 037FC520
	.byte 0x1B, 0x48, 0x08, 0x1A, 0x02, 0x21, 0x00, 0xF0, 0x3F, 0xF8, 0x84, 0x42, 0x08, 0xDA, 0x19, 0x48	; 037FC530
	.byte 0x01, 0x88, 0x17, 0x48, 0x08, 0x1A, 0x02, 0x21, 0x00, 0xF0, 0x3C, 0xF8, 0x84, 0x42, 0x06, 0xDA	; 037FC540
	.byte 0x15, 0x48, 0x01, 0x88, 0x15, 0x48, 0x01, 0x80, 0x15, 0x49, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FC550
	.byte 0x37, 0xF8, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 037FC560
	.byte 0xB4, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0xA8, 0x81, 0x80, 0x04	; 037FC570
	.byte 0x38, 0x06, 0x00, 0x00, 0xB0, 0x80, 0x80, 0x04, 0x9C, 0x81, 0x80, 0x04, 0x32, 0x80, 0x80, 0x04	; 037FC580
	.byte 0x00, 0x80, 0x00, 0x00, 0xD2, 0x03, 0x00, 0x00, 0x54, 0x80, 0x80, 0x04, 0x52, 0x80, 0x80, 0x04	; 037FC590
	.byte 0x00, 0x40, 0x00, 0x00, 0x50, 0x80, 0x80, 0x04, 0x5A, 0x80, 0x80, 0x04, 0x56, 0x80, 0x80, 0x04	; 037FC5A0
	.byte 0x01, 0x80, 0x00, 0x00, 0x30, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 037FC5B0
	.byte 0xA4, 0x4B, 0x80, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0xA4, 0x4B, 0x80, 0x03	; 037FC5C0
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x51, 0x4F, 0x30, 0x02	; 037FC5D0
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x5C, 0x4A, 0x11, 0x68, 0x5C, 0x48, 0x0D, 0x18, 0x02, 0x21, 0x5C, 0x48	; 037FC5E0
	.byte 0x01, 0x80, 0x10, 0x68, 0x5B, 0x4A, 0x82, 0x5A, 0x12, 0x2A, 0x02, 0xD1, 0x00, 0xF0, 0xD4, 0xF8	; 037FC5F0
	.byte 0xA5, 0xE0, 0x59, 0x4A, 0x14, 0x88, 0x59, 0x4A, 0x14, 0x40, 0x59, 0x4A, 0x94, 0x42, 0x06, 0xD0	; 037FC600
	.byte 0x58, 0x4A, 0x94, 0x42, 0x17, 0xD0, 0x58, 0x49, 0x8C, 0x42, 0x2F, 0xD0, 0x69, 0xE0, 0x28, 0x1C	; 037FC610
	.byte 0x8C, 0x30, 0x00, 0x68, 0x08, 0x40, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x51, 0xFB, 0x4A, 0x48	; 037FC620
	.byte 0x01, 0x68, 0x52, 0x48, 0x08, 0x18, 0x01, 0x68, 0x49, 0x1C, 0x01, 0x60, 0x00, 0x20, 0x08, 0x21	; 037FC630
	.byte 0xFE, 0xF7, 0xC8, 0xFE, 0x55, 0xE0, 0x28, 0x1C, 0x9E, 0x30, 0x00, 0x88, 0x6A, 0x6C, 0x93, 0x88	; 037FC640
	.byte 0xFF, 0x22, 0x13, 0x40, 0x1A, 0x04, 0x12, 0x0C, 0x90, 0x42, 0x08, 0xD8, 0x48, 0x48, 0x01, 0x80	; 037FC650
	.byte 0x28, 0x1C, 0xAA, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x28, 0x1C, 0xAA, 0x30, 0x01, 0x80, 0x28, 0x1C	; 037FC660
	.byte 0x90, 0x30, 0x01, 0x68, 0x08, 0x8B, 0x40, 0x1C, 0x08, 0x83, 0x3A, 0xE0, 0x29, 0x1C, 0x98, 0x31	; 037FC670
	.byte 0x0E, 0x88, 0x69, 0x6C, 0x4B, 0x88, 0x29, 0x1C, 0x90, 0x31, 0x0A, 0x68, 0x1A, 0x32, 0x01, 0x2B	; 037FC680
	.byte 0x0F, 0xD9, 0x3C, 0x49, 0x40, 0x5A, 0xC0, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x09, 0xD0, 0x3A, 0x48	; 037FC690
	.byte 0x00, 0x88, 0x01, 0x27, 0x38, 0x40, 0x00, 0x28, 0x03, 0xD1, 0x38, 0x49, 0x08, 0x88, 0x78, 0x40	; 037FC6A0
	.byte 0x08, 0x80, 0x29, 0x48, 0x01, 0x68, 0x36, 0x48, 0x09, 0x5A, 0x40, 0x20, 0x01, 0x40, 0x00, 0x29	; 037FC6B0
	.byte 0x17, 0xD0, 0x01, 0x20, 0x13, 0xE0, 0xD9, 0x03, 0x0B, 0x0C, 0x19, 0x1C, 0x01, 0x40, 0x00, 0x29	; 037FC6C0
	.byte 0x02, 0xD0, 0xD1, 0x88, 0x49, 0x1C, 0xD1, 0x80, 0xF1, 0x03, 0x0E, 0x0C, 0x31, 0x1C, 0x01, 0x40	; 037FC6D0
	.byte 0x00, 0x29, 0x04, 0xD0, 0x29, 0x1C, 0x90, 0x31, 0x09, 0x68, 0xC9, 0x8A, 0x52, 0x18, 0x01, 0x2B	; 037FC6E0
	.byte 0xE9, 0xD8, 0x20, 0x48, 0x84, 0x42, 0x26, 0xD0, 0x26, 0x48, 0x01, 0x88, 0x02, 0x20, 0x01, 0x40	; 037FC6F0
	.byte 0x00, 0x29, 0x20, 0xD1, 0xA9, 0x8F, 0x00, 0x29, 0x1A, 0xD0, 0x23, 0x49, 0x08, 0x80, 0x00, 0x22	; 037FC700
	.byte 0x22, 0x49, 0x0A, 0x80, 0x12, 0x49, 0x0A, 0x88, 0x21, 0x49, 0x0A, 0x40, 0x00, 0x2A, 0x02, 0xD1	; 037FC710
	.byte 0x00, 0xF0, 0x44, 0xF9, 0x06, 0xE0, 0x28, 0x1C, 0xAE, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x28, 0x1C	; 037FC720
	.byte 0xAE, 0x30, 0x01, 0x80, 0x28, 0x1C, 0xAC, 0x30, 0x00, 0x88, 0x40, 0x1C, 0xAC, 0x35, 0x28, 0x80	; 037FC730
	.byte 0x02, 0x21, 0x18, 0x48, 0x01, 0x80, 0x00, 0x20, 0x0E, 0x21, 0xFE, 0xF7, 0x43, 0xFE, 0x01, 0xB0	; 037FC740
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00	; 037FC750
	.byte 0x10, 0x80, 0x80, 0x04, 0x20, 0x03, 0x00, 0x00, 0xB8, 0x80, 0x80, 0x04, 0x00, 0x0F, 0x00, 0x00	; 037FC760
	.byte 0x00, 0x03, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x2C, 0x05, 0x00, 0x00	; 037FC770
	.byte 0xAC, 0x80, 0x80, 0x04, 0x0E, 0x03, 0x00, 0x00, 0x9C, 0x81, 0x80, 0x04, 0x90, 0x82, 0x80, 0x04	; 037FC780
	.byte 0x38, 0x06, 0x00, 0x00, 0xB0, 0x80, 0x80, 0x04, 0xB4, 0x80, 0x80, 0x04, 0x48, 0x80, 0x80, 0x04	; 037FC790
	.byte 0x00, 0x10, 0x00, 0x00, 0xAE, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FC7A0
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x51, 0x8C, 0x30, 0x02, 0xF0, 0xB5, 0x87, 0xB0, 0x65, 0x48, 0x01, 0x68	; 037FC7B0
	.byte 0x65, 0x48, 0x0D, 0x18, 0x65, 0x48, 0x08, 0x18, 0x00, 0x90, 0x65, 0x48, 0x0E, 0x5A, 0x01, 0x21	; 037FC7C0
	.byte 0x64, 0x48, 0x01, 0x80, 0x0E, 0x40, 0x00, 0x98, 0x80, 0x88, 0x02, 0x90, 0x62, 0x48, 0x00, 0x88	; 037FC7D0
	.byte 0x03, 0x90, 0x02, 0x99, 0x81, 0x42, 0x00, 0xD1, 0x97, 0xE0, 0x60, 0x48, 0x01, 0x88, 0x60, 0x48	; 037FC7E0
	.byte 0x00, 0x88, 0x5E, 0x4A, 0x13, 0x88, 0x5E, 0x4A, 0x12, 0x88, 0x99, 0x42, 0x03, 0xD9, 0x1C, 0x09	; 037FC7F0
	.byte 0x10, 0x03, 0x04, 0x43, 0x02, 0xE0, 0x0C, 0x09, 0x00, 0x03, 0x04, 0x43, 0x02, 0x98, 0x47, 0x00	; 037FC800
	.byte 0x58, 0x48, 0x38, 0x18, 0x01, 0x90, 0x80, 0x1C, 0x00, 0xF0, 0xB8, 0xFA, 0x04, 0x90, 0x80, 0x1C	; 037FC810
	.byte 0x00, 0xF0, 0xB4, 0xFA, 0x05, 0x90, 0x00, 0x1D, 0x00, 0xF0, 0xB0, 0xFA, 0x02, 0x1C, 0x51, 0x48	; 037FC820
	.byte 0x39, 0x5A, 0x04, 0x98, 0x00, 0x88, 0x43, 0x00, 0x4F, 0x48, 0x03, 0x40, 0x19, 0x43, 0x4D, 0x48	; 037FC830
	.byte 0x39, 0x52, 0x05, 0x98, 0x04, 0x80, 0x12, 0x88, 0x02, 0x98, 0x40, 0x00, 0x10, 0x18, 0x0F, 0x30	; 037FC840
	.byte 0x80, 0x08, 0x44, 0x00, 0x49, 0x48, 0x84, 0x42, 0x04, 0xD3, 0x28, 0x1C, 0x9A, 0x30, 0x00, 0x88	; 037FC850
	.byte 0x40, 0x08, 0x24, 0x1A, 0x46, 0x48, 0x82, 0x42, 0x0B, 0xD9, 0x46, 0x49, 0x01, 0x98, 0x01, 0x80	; 037FC860
	.byte 0x03, 0x9C, 0x28, 0x1C, 0xB4, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x28, 0x1C, 0xB4, 0x30, 0x01, 0x80	; 037FC870
	.byte 0x33, 0xE0, 0x00, 0x2E, 0x31, 0xD0, 0x03, 0x98, 0x84, 0x42, 0x2E, 0xD0, 0x60, 0x00, 0x39, 0x49	; 037FC880
	.byte 0x41, 0x18, 0x38, 0x4B, 0xC0, 0x5A, 0x3C, 0x4B, 0x99, 0x42, 0x05, 0xD2, 0xCB, 0x88, 0xFF, 0x21	; 037FC890
	.byte 0x0B, 0x40, 0x19, 0x04, 0x0B, 0x0C, 0x04, 0xE0, 0x2B, 0x1C, 0x9A, 0x33, 0x1B, 0x88, 0xC9, 0x1A	; 037FC8A0
	.byte 0xCB, 0x88, 0x36, 0x49, 0x08, 0x40, 0x00, 0x28, 0x06, 0xD1, 0x0A, 0x2B, 0x01, 0xD0, 0x14, 0x2B	; 037FC8B0
	.byte 0x02, 0xD1, 0x33, 0x48, 0x82, 0x42, 0x10, 0xD9, 0x28, 0x1C, 0xB4, 0x30, 0x00, 0x88, 0x40, 0x1C	; 037FC8C0
	.byte 0xB4, 0x35, 0x28, 0x80, 0x2B, 0x49, 0x01, 0x98, 0x01, 0x80, 0x03, 0x98, 0x00, 0x04, 0x01, 0x0C	; 037FC8D0
	.byte 0x00, 0x98, 0x81, 0x80, 0x04, 0x98, 0x01, 0x80, 0x17, 0xE0, 0x01, 0x98, 0x01, 0x88, 0x0F, 0x20	; 037FC8E0
	.byte 0x01, 0x40, 0x0C, 0x29, 0x0A, 0xD1, 0x00, 0xF0, 0x59, 0xFA, 0x00, 0x28, 0x06, 0xD1, 0x15, 0x48	; 037FC8F0
	.byte 0x00, 0x68, 0x24, 0x49, 0x41, 0x58, 0x4A, 0x1C, 0x22, 0x49, 0x42, 0x50, 0x20, 0x04, 0x01, 0x0C	; 037FC900
	.byte 0x00, 0x98, 0x81, 0x80, 0x04, 0x98, 0x01, 0x80, 0x5D, 0xE7, 0x00, 0x2E, 0x0C, 0xD0, 0x12, 0x48	; 037FC910
	.byte 0x04, 0x88, 0x00, 0xF0, 0x43, 0xFA, 0x00, 0x28, 0x06, 0xD0, 0x0F, 0x48, 0x00, 0x88, 0x84, 0x42	; 037FC920
	.byte 0x02, 0xD1, 0x20, 0x20, 0x00, 0xF0, 0x32, 0xF8, 0x17, 0x48, 0x01, 0x88, 0x0A, 0x48, 0x00, 0x88	; 037FC930
	.byte 0x81, 0x42, 0x03, 0xD0, 0x00, 0x20, 0x0F, 0x21, 0xFE, 0xF7, 0x44, 0xFD, 0x07, 0xB0, 0xF0, 0xBC	; 037FC940
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xB4, 0x04, 0x00, 0x00	; 037FC950
	.byte 0x38, 0x06, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x54, 0x80, 0x80, 0x04, 0xF8, 0x80, 0x80, 0x04	; 037FC960
	.byte 0xFA, 0x80, 0x80, 0x04, 0x00, 0x40, 0x80, 0x04, 0x00, 0x04, 0x00, 0x00, 0xB0, 0x0F, 0x00, 0x00	; 037FC970
	.byte 0x2C, 0x09, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x5A, 0x5F, 0x80, 0x04, 0x00, 0x7C, 0x00, 0x00	; 037FC980
	.byte 0xFF, 0x0F, 0x00, 0x00, 0x7C, 0x05, 0x00, 0x00, 0x5A, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46	; 037FC990
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x19, 0x4F, 0x30, 0x02, 0x10, 0xB5, 0x22, 0x49	; 037FC9A0
	.byte 0x0B, 0x68, 0x22, 0x4A, 0x9A, 0x18, 0x22, 0x4C, 0x22, 0x4B, 0x1C, 0x80, 0x93, 0x8F, 0x00, 0x2B	; 037FC9B0
	.byte 0x36, 0xD0, 0x0B, 0x68, 0x20, 0x49, 0x5B, 0x5A, 0x10, 0x21, 0x0B, 0x40, 0x00, 0x2B, 0x2B, 0xD0	; 037FC9C0
	.byte 0x00, 0x28, 0x29, 0xD0, 0x1D, 0x48, 0x01, 0x88, 0x1D, 0x48, 0x00, 0x88, 0x03, 0x28, 0x01, 0xD0	; 037FC9D0
	.byte 0x05, 0x28, 0x21, 0xD1, 0x00, 0x29, 0x1F, 0xD1, 0x53, 0x6C, 0x5C, 0x88, 0x00, 0x20, 0x01, 0x21	; 037FC9E0
	.byte 0x04, 0xE0, 0x22, 0x1C, 0x0A, 0x40, 0x80, 0x18, 0xE2, 0x03, 0x14, 0x0C, 0x00, 0x2C, 0xF8, 0xD1	; 037FC9F0
	.byte 0x59, 0x89, 0x8A, 0x00, 0x99, 0x8C, 0x0A, 0x31, 0x48, 0x43, 0xC0, 0x30, 0x10, 0x18, 0x00, 0x04	; 037FCA00
	.byte 0x00, 0x0C, 0x10, 0x49, 0x00, 0xF0, 0x22, 0xF8, 0x07, 0x48, 0x01, 0x68, 0x0E, 0x48, 0x08, 0x18	; 037FCA10
	.byte 0x01, 0x88, 0x49, 0x1C, 0x01, 0x80, 0x03, 0xE0, 0x00, 0x20, 0x10, 0x21, 0xFE, 0xF7, 0xD2, 0xFC	; 037FCA20
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00	; 037FCA30
	.byte 0x00, 0x10, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00, 0xB6, 0x80, 0x80, 0x04	; 037FCA40
	.byte 0x14, 0x82, 0x80, 0x04, 0x31, 0xCD, 0x7F, 0x03, 0xD4, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 037FCA50
	.byte 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x71, 0x53, 0x30, 0x02, 0x10, 0xB5, 0x17, 0x4B	; 037FCA60
	.byte 0x19, 0x68, 0x17, 0x48, 0x09, 0x18, 0x80, 0x20, 0x16, 0x4A, 0x10, 0x80, 0x1B, 0x68, 0x16, 0x4A	; 037FCA70
	.byte 0x9B, 0x5A, 0x20, 0x22, 0x13, 0x40, 0x00, 0x2B, 0x1D, 0xD0, 0x14, 0x4A, 0x13, 0x88, 0xFF, 0x22	; 037FCA80
	.byte 0x13, 0x40, 0x1A, 0x04, 0x13, 0x0C, 0x12, 0x4A, 0x14, 0x88, 0x03, 0x2B, 0x13, 0xD3, 0x05, 0x2B	; 037FCA90
	.byte 0x11, 0xD8, 0x8A, 0x6D, 0x53, 0x08, 0x0F, 0x4A, 0x13, 0x40, 0x9C, 0x42, 0x0B, 0xD3, 0x09, 0x6B	; 037FCAA0
	.byte 0x49, 0x08, 0x11, 0x40, 0x8C, 0x42, 0x06, 0xD8, 0x0B, 0x4A, 0x11, 0x88, 0x01, 0x43, 0x11, 0x80	; 037FCAB0
	.byte 0x11, 0x88, 0x81, 0x43, 0x11, 0x80, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 037FCAC0
	.byte 0x00, 0x04, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00, 0x14, 0x82, 0x80, 0x04	; 037FCAD0
	.byte 0x68, 0x82, 0x80, 0x04, 0xFF, 0x0F, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04, 0xF0, 0xB5, 0x81, 0xB0	; 037FCAE0
	.byte 0x5E, 0x48, 0x02, 0x68, 0x5E, 0x49, 0x55, 0x18, 0x5E, 0x49, 0x56, 0x18, 0x40, 0x22, 0x5E, 0x49	; 037FCAF0
	.byte 0x0A, 0x80, 0x01, 0x68, 0x5D, 0x48, 0x09, 0x5A, 0x20, 0x20, 0x01, 0x40, 0x00, 0x29, 0x00, 0xD1	; 037FCB00
	.byte 0xA7, 0xE0, 0x30, 0x1C, 0xA6, 0x30, 0x01, 0x88, 0x59, 0x48, 0x81, 0x42, 0x00, 0xD0, 0xA0, 0xE0	; 037FCB10
	.byte 0x58, 0x48, 0x01, 0x88, 0x03, 0x20, 0x01, 0x40, 0x03, 0x29, 0x00, 0xD0, 0x99, 0xE0, 0x56, 0x48	; 037FCB20
	.byte 0x02, 0x88, 0x56, 0x48, 0x00, 0x88, 0x41, 0x08, 0x55, 0x48, 0x01, 0x40, 0x8A, 0x42, 0x00, 0xDA	; 037FCB30
	.byte 0x8F, 0xE0, 0x54, 0x48, 0x00, 0x88, 0x00, 0x90, 0x41, 0x00, 0x53, 0x48, 0x08, 0x18, 0x08, 0x30	; 037FCB40
	.byte 0x00, 0xF0, 0x1C, 0xF9, 0x00, 0x1D, 0x00, 0xF0, 0x19, 0xF9, 0x02, 0x88, 0x4F, 0x49, 0x0A, 0x40	; 037FCB50
	.byte 0x4F, 0x49, 0x8A, 0x42, 0x7D, 0xD1, 0x80, 0x1C, 0x00, 0xF0, 0x10, 0xF9, 0x01, 0x1C, 0x4D, 0x4C	; 037FCB60
	.byte 0x22, 0x88, 0x4D, 0x48, 0x17, 0x1A, 0x44, 0x48, 0x02, 0x88, 0x00, 0x98, 0x10, 0x1A, 0x00, 0x04	; 037FCB70
	.byte 0x03, 0x0C, 0x1A, 0x1C, 0x49, 0x48, 0x02, 0x40, 0x00, 0x2A, 0x06, 0xD0, 0x28, 0x1C, 0x9A, 0x30	; 037FCB80
	.byte 0x00, 0x88, 0x40, 0x08, 0x18, 0x18, 0x00, 0x04, 0x03, 0x0C, 0x0E, 0x2B, 0x06, 0xD8, 0x20, 0x88	; 037FCB90
	.byte 0xC0, 0x1B, 0x00, 0x04, 0x00, 0x0C, 0x40, 0x28, 0xE5, 0xD9, 0x5A, 0xE0, 0x08, 0x31, 0x00, 0x24	; 037FCBA0
	.byte 0x0B, 0xE0, 0x08, 0x1C, 0x00, 0xF0, 0xEA, 0xF8, 0x81, 0x1C, 0x00, 0x88, 0x62, 0x00, 0xAA, 0x18	; 037FCBB0
	.byte 0x64, 0x32, 0x12, 0x88, 0x90, 0x42, 0x4C, 0xD1, 0x64, 0x1C, 0x03, 0x2C, 0xF1, 0xD3, 0x0A, 0x31	; 037FCBC0
	.byte 0x08, 0x1C, 0x00, 0xF0, 0xDB, 0xF8, 0x03, 0x1C, 0x2B, 0x4C, 0x21, 0x88, 0x00, 0x98, 0x08, 0x1A	; 037FCBD0
	.byte 0x00, 0x04, 0x02, 0x0C, 0x11, 0x1C, 0x31, 0x48, 0x01, 0x40, 0x00, 0x29, 0x06, 0xD0, 0x28, 0x1C	; 037FCBE0
	.byte 0x9A, 0x30, 0x00, 0x88, 0x40, 0x08, 0x10, 0x18, 0x00, 0x04, 0x02, 0x0C, 0x14, 0x2A, 0x07, 0xD8	; 037FCBF0
	.byte 0x28, 0x48, 0x00, 0x88, 0xC0, 0x1B, 0x00, 0x04, 0x00, 0x0C, 0x70, 0x28, 0xE5, 0xD9, 0x28, 0xE0	; 037FCC00
	.byte 0x19, 0x88, 0x30, 0x1C, 0xA2, 0x30, 0x00, 0x88, 0x01, 0x40, 0x00, 0x29, 0x21, 0xD1, 0x24, 0x48	; 037FCC10
	.byte 0x00, 0x88, 0xA6, 0x36, 0x30, 0x80, 0x40, 0x21, 0x22, 0x48, 0x01, 0x80, 0x28, 0x1C, 0xBE, 0x30	; 037FCC20
	.byte 0x00, 0x88, 0x40, 0x1C, 0xBE, 0x35, 0x28, 0x80, 0x12, 0x49, 0x03, 0x20, 0x0A, 0x88, 0x02, 0x40	; 037FCC30
	.byte 0x03, 0x2A, 0xFB, 0xD0, 0x1C, 0x4A, 0x11, 0x88, 0x40, 0x20, 0x01, 0x43, 0x11, 0x80, 0x11, 0x88	; 037FCC40
	.byte 0x81, 0x43, 0x11, 0x80, 0x08, 0x20, 0x19, 0x49, 0x08, 0x80, 0x00, 0x20, 0x08, 0x80, 0x00, 0xF0	; 037FCC50
	.byte 0x2F, 0xF8, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 037FCC60
	.byte 0x18, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x10, 0x80, 0x80, 0x04, 0x38, 0x06, 0x00, 0x00	; 037FCC70
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x9C, 0x81, 0x80, 0x04, 0x68, 0x82, 0x80, 0x04, 0x50, 0x80, 0x80, 0x04	; 037FCC80
	.byte 0xFF, 0x0F, 0x00, 0x00, 0x54, 0x80, 0x80, 0x04, 0x00, 0x40, 0x80, 0x04, 0xFF, 0xE7, 0x00, 0x00	; 037FCC90
	.byte 0x28, 0x02, 0x00, 0x00, 0xF8, 0x80, 0x80, 0x04, 0x00, 0x00, 0x01, 0x00, 0x00, 0x80, 0x00, 0x00	; 037FCCA0
	.byte 0x98, 0x80, 0x80, 0x04, 0xB4, 0x80, 0x80, 0x04, 0x44, 0x82, 0x80, 0x04, 0x28, 0x82, 0x80, 0x04	; 037FCCB0
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xF5, 0x6D, 0x30, 0x02	; 037FCCC0
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x14, 0x48, 0x01, 0x68, 0x14, 0x48, 0x0D, 0x18, 0x00, 0x24, 0x01, 0x20	; 037FCCD0
	.byte 0x00, 0xF0, 0x26, 0xF8, 0x20, 0x00, 0x00, 0xF0, 0x23, 0xF8, 0xE8, 0x69, 0x00, 0x88, 0x00, 0x28	; 037FCCE0
	.byte 0x01, 0xD0, 0x01, 0x24, 0x01, 0xE0, 0x20, 0x00, 0xA8, 0x82, 0xA8, 0x68, 0x00, 0x88, 0x00, 0x28	; 037FCCF0
	.byte 0x01, 0xD0, 0x01, 0x24, 0x01, 0xE0, 0x00, 0x20, 0x28, 0x80, 0x00, 0x2C, 0x03, 0xD0, 0x00, 0x20	; 037FCD00
	.byte 0x0E, 0x21, 0xFE, 0xF7, 0x5F, 0xFB, 0x00, 0x20, 0x14, 0x21, 0xFE, 0xF7, 0x5B, 0xFB, 0x01, 0xB0	; 037FCD10
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00	; 037FCD20
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0xA5, 0xA6, 0x30, 0x02	; 037FCD30
	.byte 0x10, 0xB5, 0x0E, 0x48, 0x00, 0xF0, 0x96, 0xFE, 0x04, 0x1C, 0x0D, 0x4A, 0x13, 0x88, 0x0D, 0x49	; 037FCD40
	.byte 0x0D, 0x48, 0x01, 0x80, 0x64, 0x21, 0x03, 0xE0, 0x10, 0x88, 0x83, 0x42, 0x02, 0xD1, 0x49, 0x1E	; 037FCD50
	.byte 0x00, 0x29, 0xF9, 0xD1, 0x00, 0x20, 0x08, 0x49, 0x08, 0x80, 0xFF, 0xF7, 0x1F, 0xFE, 0x20, 0x1C	; 037FCD60
	.byte 0x00, 0xF0, 0x96, 0xFE, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x00, 0x00, 0x00, 0x01	; 037FCD70
	.byte 0x10, 0x82, 0x80, 0x04, 0x00, 0x10, 0x00, 0x00, 0x44, 0x82, 0x80, 0x04, 0x04, 0x49, 0x88, 0x42	; 037FCD80
	.byte 0x04, 0xD3, 0x04, 0x49, 0x0A, 0x68, 0x04, 0x49, 0x51, 0x5A, 0x40, 0x1A, 0x70, 0x47, 0xC0, 0x46	; 037FCD90
	.byte 0x60, 0x5F, 0x80, 0x04, 0xF4, 0xFF, 0x80, 0x03, 0xB2, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x0C, 0x48	; 037FCDA0
	.byte 0x01, 0x68, 0x0C, 0x48, 0x0C, 0x18, 0x20, 0x1C, 0x50, 0x30, 0x00, 0xF0, 0x15, 0xF8, 0x00, 0x28	; 037FCDB0
	.byte 0x01, 0xD0, 0x01, 0x20, 0x08, 0xE0, 0x64, 0x34, 0x20, 0x1C, 0x00, 0xF0, 0x0D, 0xF8, 0x00, 0x28	; 037FCDC0
	.byte 0x01, 0xD0, 0x01, 0x20, 0x00, 0xE0, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FCDD0
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x00, 0x04, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FCDE0
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xB1, 0x6D, 0x30, 0x02, 0x00, 0xB5, 0x81, 0xB0, 0x0A, 0x48, 0x01, 0x68	; 037FCDF0
	.byte 0x0A, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x14, 0xF8, 0x06, 0x48, 0x01, 0x68	; 037FCE00
	.byte 0x07, 0x48, 0x08, 0x5A, 0x40, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x12, 0xF8	; 037FCE10
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xBC, 0x03, 0x00, 0x00	; 037FCE20
	.byte 0x0E, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FCE30
	.byte 0xD1, 0x9F, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1	; 037FCE40
	.byte 0xD5, 0x79, 0x30, 0x02, 0xF0, 0xB5, 0x83, 0xB0, 0x4B, 0x48, 0x01, 0x68, 0x4B, 0x48, 0x0D, 0x18	; 037FCE50
	.byte 0x4B, 0x48, 0x0F, 0x18, 0x02, 0x24, 0x01, 0x94, 0x00, 0x94, 0x21, 0x1C, 0x14, 0x20, 0x41, 0x43	; 037FCE60
	.byte 0x7A, 0x18, 0xA0, 0x00, 0x47, 0x49, 0x43, 0x18, 0x41, 0x5A, 0x47, 0x48, 0x01, 0x40, 0x00, 0x29	; 037FCE70
	.byte 0x79, 0xD1, 0x10, 0x88, 0x00, 0x28, 0x76, 0xD0, 0xD0, 0x68, 0x00, 0x28, 0x6B, 0xD0, 0x91, 0x68	; 037FCE80
	.byte 0x09, 0x88, 0x01, 0x81, 0x90, 0x68, 0x81, 0x89, 0xD0, 0x68, 0x81, 0x82, 0x90, 0x68, 0x86, 0x89	; 037FCE90
	.byte 0x3E, 0x49, 0x0E, 0x40, 0x00, 0x2E, 0x50, 0xD0, 0x37, 0x49, 0x0E, 0x68, 0x3C, 0x49, 0x76, 0x5A	; 037FCEA0
	.byte 0x08, 0x21, 0x0E, 0x40, 0x00, 0x2E, 0x40, 0xD0, 0x06, 0x1C, 0x0C, 0x36, 0x41, 0x89, 0x71, 0x18	; 037FCEB0
	.byte 0xC9, 0x1F, 0x01, 0x26, 0xB1, 0x43, 0x0E, 0x88, 0x00, 0x2E, 0x36, 0xD1, 0x49, 0x88, 0x00, 0x29	; 037FCEC0
	.byte 0x33, 0xD1, 0x28, 0x1C, 0xA8, 0x30, 0x00, 0x68, 0xD1, 0x68, 0x89, 0x88, 0x40, 0x1A, 0x00, 0x04	; 037FCED0
	.byte 0x00, 0x0C, 0x00, 0x26, 0x2F, 0x49, 0x0E, 0x80, 0x2B, 0x4E, 0x0E, 0x80, 0x29, 0x1C, 0xBA, 0x31	; 037FCEE0
	.byte 0x09, 0x88, 0x49, 0x1C, 0x2E, 0x1C, 0xBA, 0x36, 0x31, 0x80, 0x29, 0x1C, 0x8C, 0x31, 0x09, 0x88	; 037FCEF0
	.byte 0x88, 0x42, 0x12, 0xD9, 0xD1, 0x68, 0x00, 0x98, 0x08, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80	; 037FCF00
	.byte 0x38, 0x1C, 0xB0, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x38, 0x1C, 0xB0, 0x30, 0x01, 0x80, 0xD0, 0x68	; 037FCF10
	.byte 0x01, 0x21, 0x12, 0x69, 0x08, 0xF0, 0xBA, 0xF8, 0x25, 0xE0, 0xD1, 0x68, 0x00, 0x20, 0x88, 0x81	; 037FCF20
	.byte 0x19, 0x88, 0x19, 0x48, 0x01, 0x43, 0x19, 0x80, 0x1D, 0xE0, 0xD3, 0x68, 0x99, 0x89, 0x86, 0x88	; 037FCF30
	.byte 0xFF, 0x20, 0x06, 0x40, 0x88, 0x19, 0x98, 0x81, 0x04, 0xE0, 0x81, 0x88, 0xFF, 0x20, 0x01, 0x40	; 037FCF40
	.byte 0xD0, 0x68, 0x81, 0x81, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0xD0, 0x68, 0x01, 0x99, 0x12, 0x69	; 037FCF50
	.byte 0x08, 0xF0, 0x9C, 0xF8, 0x07, 0xE0, 0x90, 0x88, 0x40, 0x1C, 0x90, 0x80, 0x90, 0x68, 0x03, 0x21	; 037FCF60
	.byte 0x12, 0x69, 0x08, 0xF0, 0x93, 0xF8, 0x64, 0x1E, 0x00, 0x2C, 0x00, 0xDB, 0x75, 0xE7, 0x03, 0xB0	; 037FCF70
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 037FCF80
	.byte 0x00, 0x04, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00	; 037FCF90
	.byte 0x38, 0x06, 0x00, 0x00, 0x32, 0x80, 0x80, 0x04, 0xF0, 0xB5, 0x89, 0xB0, 0x96, 0x48, 0x01, 0x68	; 037FCFA0
	.byte 0x96, 0x48, 0x0F, 0x18, 0x96, 0x48, 0x0E, 0x18, 0x00, 0x20, 0x00, 0x90, 0x03, 0x90, 0x07, 0x90	; 037FCFB0
	.byte 0x06, 0x90, 0x05, 0x90, 0x04, 0x90, 0x08, 0x90, 0x92, 0x48, 0x01, 0x88, 0xB8, 0x88, 0x81, 0x42	; 037FCFC0
	.byte 0x00, 0xD1, 0x15, 0xE1, 0x4C, 0x00, 0x90, 0x48, 0x25, 0x18, 0xA8, 0x1C, 0xFF, 0xF7, 0xD6, 0xFE	; 037FCFD0
	.byte 0x00, 0x88, 0x02, 0x90, 0x8C, 0x48, 0x21, 0x5A, 0x8C, 0x48, 0x81, 0x42, 0x03, 0xD1, 0x02, 0x99	; 037FCFE0
	.byte 0x88, 0x48, 0x01, 0x80, 0x00, 0xE1, 0x28, 0x1C, 0x08, 0x30, 0xFF, 0xF7, 0xC7, 0xFE, 0x01, 0x88	; 037FCFF0
	.byte 0x28, 0x1C, 0x00, 0xF0, 0xF5, 0xF9, 0x04, 0x1C, 0x02, 0x99, 0x82, 0x48, 0x01, 0x80, 0x00, 0x2C	; 037FD000
	.byte 0x0C, 0xD1, 0x29, 0x88, 0x0F, 0x20, 0x01, 0x40, 0x0C, 0x29, 0x03, 0xD1, 0x10, 0x20, 0xFF, 0xF7	; 037FD010
	.byte 0xBD, 0xFC, 0xE9, 0xE0, 0x08, 0x20, 0xFF, 0xF7, 0xB9, 0xFC, 0xE5, 0xE0, 0x76, 0x48, 0x01, 0x68	; 037FD020
	.byte 0x7B, 0x48, 0x09, 0x5A, 0x08, 0x20, 0x01, 0x40, 0x00, 0x29, 0x06, 0xD0, 0xA1, 0x8A, 0x79, 0x48	; 037FD030
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x03, 0x98, 0x78, 0x80, 0x21, 0x89, 0x01, 0x20, 0x01, 0x90	; 037FD040
	.byte 0x0A, 0x1C, 0x75, 0x48, 0x02, 0x40, 0x00, 0x2A, 0x19, 0xD0, 0xA0, 0x8A, 0x40, 0x05, 0xC0, 0x0F	; 037FD050
	.byte 0x01, 0x28, 0x05, 0xD0, 0x60, 0x8D, 0x00, 0x07, 0x00, 0x0F, 0x00, 0x28, 0x00, 0xD1, 0xA3, 0xE0	; 037FD060
	.byte 0x04, 0x98, 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C, 0x6C, 0x31, 0x22, 0x1C, 0x10, 0x3A	; 037FD070
	.byte 0xFE, 0xF7, 0x16, 0xFB, 0x02, 0x20, 0x09, 0x21, 0xFE, 0xF7, 0xA4, 0xF9, 0x94, 0xE0, 0x0F, 0x20	; 037FD080
	.byte 0x01, 0x40, 0x0F, 0x29, 0x00, 0xD9, 0x8F, 0xE0, 0x48, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 037FD090
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x57, 0x00, 0x49, 0x00, 0x13, 0x01, 0x13, 0x01, 0x13, 0x01	; 037FD0A0
	.byte 0x7F, 0x00, 0x13, 0x01, 0x13, 0x01, 0x21, 0x00, 0x13, 0x01, 0x13, 0x01, 0x13, 0x01, 0xBB, 0x00	; 037FD0B0
	.byte 0xF1, 0x00, 0xA7, 0x00, 0xA7, 0x00, 0xA1, 0x8A, 0x0F, 0x20, 0x01, 0x40, 0x08, 0x29, 0x73, 0xD1	; 037FD0C0
	.byte 0x05, 0x98, 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C, 0x48, 0x31, 0x22, 0x1C, 0x10, 0x3A	; 037FD0D0
	.byte 0xFE, 0xF7, 0xE6, 0xFA, 0x02, 0x20, 0x06, 0x21, 0xFE, 0xF7, 0x74, 0xF9, 0x64, 0xE0, 0xA0, 0x8A	; 037FD0E0
	.byte 0x80, 0x28, 0x61, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0xAF, 0xF8, 0x5D, 0xE0, 0xA1, 0x8A, 0x0F, 0x20	; 037FD0F0
	.byte 0x01, 0x40, 0x00, 0x29, 0x58, 0xD1, 0x06, 0x98, 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C	; 037FD100
	.byte 0x60, 0x31, 0x22, 0x1C, 0x10, 0x3A, 0xFE, 0xF7, 0xCB, 0xFA, 0x01, 0x20, 0x07, 0x21, 0xFE, 0xF7	; 037FD110
	.byte 0x59, 0xF9, 0x49, 0xE0, 0xA1, 0x8A, 0x41, 0x48, 0x01, 0x40, 0xA4, 0x29, 0x44, 0xD1, 0x07, 0x98	; 037FD120
	.byte 0x01, 0x90, 0x30, 0x1C, 0x0C, 0x30, 0x31, 0x1C, 0x60, 0x31, 0x22, 0x1C, 0x10, 0x3A, 0xFE, 0xF7	; 037FD130
	.byte 0xB7, 0xFA, 0x01, 0x20, 0x07, 0x21, 0xFE, 0xF7, 0x45, 0xF9, 0x35, 0xE0, 0xA0, 0x8A, 0x38, 0x49	; 037FD140
	.byte 0x08, 0x40, 0x38, 0x49, 0x88, 0x42, 0x2F, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0x85, 0xF8, 0x2B, 0xE0	; 037FD150
	.byte 0xA0, 0x8A, 0x32, 0x49, 0x08, 0x40, 0x34, 0x49, 0x88, 0x42, 0x25, 0xD1, 0x26, 0x48, 0x01, 0x68	; 037FD160
	.byte 0x32, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x02, 0xD1, 0x01, 0x21, 0x31, 0x48, 0x01, 0x80, 0x22, 0x48	; 037FD170
	.byte 0x02, 0x68, 0x30, 0x48, 0x10, 0x58, 0x41, 0x1C, 0x2E, 0x48, 0x11, 0x50, 0x20, 0x1C, 0x00, 0xF0	; 037FD180
	.byte 0x73, 0xF8, 0x01, 0x90, 0x10, 0xE0, 0xA0, 0x8A, 0x24, 0x49, 0x08, 0x40, 0x2A, 0x49, 0x88, 0x42	; 037FD190
	.byte 0x0A, 0xD1, 0x19, 0x48, 0x02, 0x68, 0x29, 0x48, 0x10, 0x58, 0x41, 0x1C, 0x27, 0x48, 0x11, 0x50	; 037FD1A0
	.byte 0x20, 0x1C, 0x00, 0xF0, 0x69, 0xF8, 0x01, 0x90, 0x01, 0x98, 0x00, 0x28, 0x05, 0xD0, 0x30, 0x1C	; 037FD1B0
	.byte 0x0C, 0x30, 0x10, 0x3C, 0x21, 0x1C, 0xFE, 0xF7, 0x47, 0xFA, 0x0F, 0x48, 0x01, 0x68, 0x14, 0x48	; 037FD1C0
	.byte 0x09, 0x5A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x0E, 0xD0, 0x08, 0x98, 0x1C, 0x49, 0x8D, 0x42	; 037FD1D0
	.byte 0x04, 0xD3, 0x09, 0x49, 0x0A, 0x68, 0x1B, 0x49, 0x51, 0x5A, 0x6D, 0x1A, 0x0B, 0x49, 0x29, 0x80	; 037FD1E0
	.byte 0xAD, 0x1C, 0x40, 0x1C, 0x07, 0x28, 0xF1, 0xD3, 0x00, 0x98, 0x40, 0x1C, 0x00, 0x90, 0xE3, 0xE6	; 037FD1F0
	.byte 0x09, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xB4, 0x04, 0x00, 0x00	; 037FD200
	.byte 0x50, 0x01, 0x00, 0x00, 0x5A, 0x80, 0x80, 0x04, 0x00, 0x40, 0x80, 0x04, 0xFF, 0xFF, 0x00, 0x00	; 037FD210
	.byte 0x38, 0x06, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0xFF, 0xE7, 0x00, 0x00	; 037FD220
	.byte 0xBF, 0xE7, 0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x28, 0x02, 0x00, 0x00, 0x28, 0x03, 0x00, 0x00	; 037FD230
	.byte 0x3C, 0x80, 0x80, 0x04, 0x80, 0x05, 0x00, 0x00, 0x18, 0x02, 0x00, 0x00, 0x84, 0x05, 0x00, 0x00	; 037FD240
	.byte 0x60, 0x5F, 0x80, 0x04, 0xB2, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD250
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xD1, 0xC6, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD260
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xD5, 0xCC, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD270
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x0D, 0xCE, 0x30, 0x02, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD280
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x2D, 0xCC, 0x30, 0x02, 0x10, 0xB5, 0x28, 0x48, 0x01, 0x68, 0x28, 0x48	; 037FD290
	.byte 0x0C, 0x18, 0xA0, 0x8F, 0x00, 0x28, 0x46, 0xD0, 0x20, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x01, 0x8A	; 037FD2A0
	.byte 0x60, 0x6C, 0x40, 0x88, 0x81, 0x42, 0x01, 0xD0, 0xFF, 0xF7, 0x76, 0xFE, 0x60, 0x6C, 0x80, 0x88	; 037FD2B0
	.byte 0xFF, 0x21, 0x08, 0x40, 0x00, 0x28, 0x07, 0xD0, 0x1C, 0x49, 0x0A, 0x68, 0x1D, 0x49, 0x51, 0x18	; 037FD2C0
	.byte 0x0A, 0x68, 0x10, 0x18, 0x08, 0x60, 0x06, 0xE0, 0x18, 0x48, 0x01, 0x68, 0x19, 0x48, 0x08, 0x18	; 037FD2D0
	.byte 0x01, 0x68, 0x49, 0x1C, 0x01, 0x60, 0x20, 0x1C, 0x40, 0x30, 0x00, 0x88, 0x41, 0x1C, 0x20, 0x1C	; 037FD2E0
	.byte 0x40, 0x30, 0x01, 0x80, 0x20, 0x1C, 0x90, 0x30, 0x02, 0x68, 0x11, 0x8A, 0x60, 0x6C, 0x40, 0x88	; 037FD2F0
	.byte 0x41, 0x40, 0x51, 0x82, 0x20, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x01, 0x8A, 0x20, 0x1C, 0xA0, 0x30	; 037FD300
	.byte 0x01, 0x80, 0x00, 0x20, 0xA0, 0x87, 0x09, 0x48, 0x01, 0x68, 0x0B, 0x48, 0x08, 0x5A, 0x00, 0x28	; 037FD310
	.byte 0x01, 0xD0, 0xFE, 0xF7, 0x2D, 0xFD, 0x05, 0x48, 0x01, 0x68, 0x08, 0x48, 0x08, 0x18, 0x90, 0x34	; 037FD320
	.byte 0x21, 0x68, 0xFE, 0xF7, 0x1D, 0xFB, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 037FD330
	.byte 0x00, 0x04, 0x00, 0x00, 0x74, 0x05, 0x00, 0x00, 0xBE, 0x03, 0x00, 0x00, 0x5C, 0x01, 0x00, 0x00	; 037FD340
	.byte 0x10, 0xB5, 0x19, 0x48, 0x00, 0x68, 0x19, 0x49, 0x44, 0x18, 0x19, 0x49, 0x09, 0x88, 0x00, 0x29	; 037FD350
	.byte 0x08, 0xD1, 0x21, 0x8F, 0x00, 0x29, 0x05, 0xD0, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x00, 0xF0	; 037FD360
	.byte 0x2F, 0xF8, 0x1D, 0xE0, 0x14, 0x49, 0x42, 0x5A, 0x14, 0x49, 0x40, 0x5A, 0x82, 0x43, 0x00, 0x2A	; 037FD370
	.byte 0x07, 0xD1, 0x08, 0x21, 0x0F, 0x48, 0x01, 0x80, 0x20, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0	; 037FD380
	.byte 0x1F, 0xF8, 0x05, 0x21, 0x0B, 0x48, 0x01, 0x80, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 037FD390
	.byte 0x00, 0xF0, 0x1E, 0xF8, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0x18, 0xF8	; 037FD3A0
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00	; 037FD3B0
	.byte 0x88, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 037FD3C0
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x81, 0xAE, 0x30, 0x02	; 037FD3D0
	.byte 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5, 0x1C, 0xFF, 0x2F, 0xE1, 0x0D, 0xAF, 0x30, 0x02	; 037FD3E0
	.byte 0x70, 0xB5, 0x06, 0x1C, 0x0D, 0x1C, 0x12, 0x48, 0x01, 0x68, 0x12, 0x48, 0x08, 0x18, 0x29, 0x1C	; 037FD3F0
	.byte 0x22, 0x31, 0xFE, 0xF7, 0xF3, 0xF8, 0x00, 0x28, 0x01, 0xD1, 0x00, 0x20, 0x14, 0xE0, 0x04, 0x1C	; 037FD400
	.byte 0x10, 0x34, 0x20, 0x1C, 0x08, 0x30, 0x31, 0x1C, 0x2A, 0x1C, 0x0C, 0x32, 0x00, 0xF0, 0x14, 0xF8	; 037FD410
	.byte 0x18, 0x3D, 0xE5, 0x80, 0xE2, 0x89, 0xFF, 0x20, 0x02, 0x40, 0x61, 0x8A, 0x01, 0x40, 0x08, 0x04	; 037FD420
	.byte 0x00, 0x0A, 0x02, 0x43, 0xE2, 0x81, 0x20, 0x1C, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FD430
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x00, 0xC0, 0x9F, 0xE5	; 037FD440
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0xB5, 0x52, 0x30, 0x02	; 037FD448
.thumb

; ===== function loc_037FD448 =====
loc_037FD448:
	push {r4,r5,r6,r7,lr}	; 037FD448
	sub sp,#0x4	; 037FD44A
	ldr r0,[pool_037FD608]	; 037FD44C
	ldr r6,[r0,#0x0]	; 037FD44E
	ldr r0,[pool_037FD60C]	; 037FD450
	add r4,r6,r0	; 037FD452
	ldr r0,[pool_037FD610]	; 037FD454
	add r5,r6,r0	; 037FD456
	ldr r0,[pool_037FD614]	; 037FD458
	add r7,r6,r0	; 037FD45A
	mov r0,#0x0	; 037FD45C
	str r0,[sp,#0x0]	; 037FD45E
	ldr r0,[sp,#0x0]	; 037FD460
	add r1,r4,#0x0	; 037FD462
	mov r2,#0xb4	; 037FD464
	bl loc_037FD6D4	; 037FD466
	mov r1,#0x0	; 037FD46A
	ldr r0,[pool_037FD60C]	; 037FD46C
	strh r1,[r6,r0]	; 037FD46E
	str r1,[r4,#0xc]	; 037FD470
	strh r1,[r4,#0x14]	; 037FD472
	str r1,[r4,#0x20]	; 037FD474
	strh r1,[r4,#0x28]	; 037FD476
	str r1,[r4,#0x34]	; 037FD478
	ldr r1,[pool_037FD618]	; 037FD47A
	add r0,r4,#0x0	; 037FD47C
	add r0,#0xa4	; 037FD47E
	strh r1,[r0,#0x0]	; 037FD480
	add r0,r4,#0x0	; 037FD482
	add r0,#0xa6	; 037FD484
	strh r1,[r0,#0x0]	; 037FD486
	ldrh r0,[r5,#0xc]	; 037FD488
	cmp r0,#0x3	; 037FD48A
	bls loc_037FD490	; 037FD48C
	b loc_037FD5EA	; 037FD48E
loc_037FD490:
	add r0,r0,r0	; 037FD490
	add r0,pc	; 037FD492
	ldrh r0,[r0,#0x8]	; 037FD494
	lsl r0,r0,#0x10	; 037FD496
	asr r0,r0,#0x10	; 037FD498
	add r0,pc	; 037FD49A
	bx r0	; 037FD49C
	.byte 0x09, 0x00, 0x4D, 0x00, 0xAF, 0x00, 0x0B, 0x01	; 037FD4A6
loc_037FD4A6:
	ldr r0,[pool_037FD61C]	; 037FD4A6
	str r0,[r4,#0x8]	; 037FD4A8
	ldr r0,[pool_037FD620]	; 037FD4AA
	str r0,[r4,#0x1c]	; 037FD4AC
	ldr r0,[pool_037FD624]	; 037FD4AE
	str r0,[r4,#0x30]	; 037FD4B0
	ldr r0,[pool_037FD628]	; 037FD4B2
	str r0,[r4,#0x10]	; 037FD4B4
	ldr r0,[pool_037FD62C]	; 037FD4B6
	str r0,[r4,#0x24]	; 037FD4B8
	ldr r0,[pool_037FD630]	; 037FD4BA
	str r0,[r4,#0x38]	; 037FD4BC
	ldr r1,[pool_037FD634]	; 037FD4BE
	ldr r0,[pool_037FD638]	; 037FD4C0
	strh r1,[r0,#0x0]	; 037FD4C2
	ldr r0,[pool_037FD63C]	; 037FD4C4
	ldr r2,[pool_037FD640]	; 037FD4C6
	strh r0,[r2,#0x0]	; 037FD4C8
	ldr r2,[pool_037FD644]	; 037FD4CA
	strh r1,[r2,#0x0]	; 037FD4CC
	ldr r2,[pool_037FD648]	; 037FD4CE
	strh r0,[r2,#0x0]	; 037FD4D0
	ldr r2,[pool_037FD64C]	; 037FD4D2
	strh r1,[r2,#0x0]	; 037FD4D4
	ldr r1,[pool_037FD650]	; 037FD4D6
	strh r0,[r1,#0x0]	; 037FD4D8
	mov r1,#0x8	; 037FD4DA
	add r0,r5,#0x0	; 037FD4DC
	add r0,#0x8a	; 037FD4DE
	strh r1,[r0,#0x0]	; 037FD4E0
	mov r1,#0x1	; 037FD4E2
	ldr r0,[pool_037FD654]	; 037FD4E4
	strh r1,[r0,#0x0]	; 037FD4E6
	b loc_037FD5EA	; 037FD4E8
loc_037FD4EA:
	ldr r0,[pool_037FD658]	; 037FD4EA
	str r0,[r4,#0x8]	; 037FD4EC
	ldr r0,[pool_037FD65C]	; 037FD4EE
	str r0,[r4,#0x1c]	; 037FD4F0
	ldr r0,[pool_037FD660]	; 037FD4F2
	str r0,[r4,#0x30]	; 037FD4F4
	ldr r0,[pool_037FD628]	; 037FD4F6
	str r0,[r4,#0x10]	; 037FD4F8
	ldr r0,[pool_037FD62C]	; 037FD4FA
	str r0,[r4,#0x24]	; 037FD4FC
	ldr r0,[pool_037FD664]	; 037FD4FE
	str r0,[r4,#0x38]	; 037FD500
	ldr r2,[pool_037FD668]	; 037FD502
	add r0,r4,#0x0	; 037FD504
	add r0,#0x80	; 037FD506
	str r2,[r0,#0x0]	; 037FD508
	ldr r0,[pool_037FD624]	; 037FD50A
	str r0,[r4,#0x44]	; 037FD50C
	ldr r1,[pool_037FD634]	; 037FD50E
	ldr r0,[pool_037FD66C]	; 037FD510
	strh r1,[r0,#0x0]	; 037FD512
	ldr r0,[pool_037FD63C]	; 037FD514
	ldr r3,[pool_037FD670]	; 037FD516
	strh r0,[r3,#0x0]	; 037FD518
	ldr r3,[pool_037FD674]	; 037FD51A
	strh r1,[r3,#0x0]	; 037FD51C
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
	ldr r1,[pool_037FD690]	; 037FD536
	strh r0,[r1,#0x0]	; 037FD538
	ldr r1,[pool_037FD694]	; 037FD53A
	add r0,r5,#0x0	; 037FD53C
	add r0,#0x8a	; 037FD53E
	strh r1,[r0,#0x0]	; 037FD540
	add r4,#0x80	; 037FD542
	str r2,[r4,#0x0]	; 037FD544
	bl loc_037FD6E0	; 037FD546
	b loc_037FD5EA	; 037FD54A
loc_037FD54C:
	ldr r0,[pool_037FD698]	; 037FD54C
	str r0,[r4,#0x8]	; 037FD54E
	ldr r0,[pool_037FD69C]	; 037FD550
	str r0,[r4,#0x1c]	; 037FD552
	ldr r0,[pool_037FD6A0]	; 037FD554
	str r0,[r4,#0x30]	; 037FD556
	ldr r0,[pool_037FD628]	; 037FD558
	str r0,[r4,#0x10]	; 037FD55A
	ldr r0,[pool_037FD62C]	; 037FD55C
	str r0,[r4,#0x24]	; 037FD55E
	ldr r0,[pool_037FD630]	; 037FD560
	str r0,[r4,#0x38]	; 037FD562
	ldr r0,[pool_037FD624]	; 037FD564
	str r0,[r4,#0x58]	; 037FD566
	ldr r0,[pool_037FD66C]	; 037FD568
	str r0,[r4,#0x6c]	; 037FD56A
	ldr r1,[pool_037FD634]	; 037FD56C
	ldr r0,[pool_037FD6A4]	; 037FD56E
	strh r1,[r0,#0x0]	; 037FD570
	ldr r0,[pool_037FD63C]	; 037FD572
	ldr r2,[pool_037FD6A8]	; 037FD574
	strh r0,[r2,#0x0]	; 037FD576
	ldr r2,[pool_037FD6AC]	; 037FD578
	strh r1,[r2,#0x0]	; 037FD57A
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
	ldr r1,[pool_037FD6C8]	; 037FD594
	strh r0,[r1,#0x0]	; 037FD596
	ldr r1,[pool_037FD6CC]	; 037FD598
	add r0,r5,#0x0	; 037FD59A
	add r0,#0x8a	; 037FD59C
	strh r1,[r0,#0x0]	; 037FD59E
	mov r1,#0xd	; 037FD5A0
	ldr r0,[pool_037FD654]	; 037FD5A2
	strh r1,[r0,#0x0]	; 037FD5A4
	b loc_037FD5EA	; 037FD5A6
loc_037FD5A8:
	ldr r0,[pool_037FD61C]	; 037FD5A8
	str r0,[r4,#0x8]	; 037FD5AA
	ldr r0,[pool_037FD620]	; 037FD5AC
	str r0,[r4,#0x1c]	; 037FD5AE
	ldr r0,[pool_037FD624]	; 037FD5B0
	str r0,[r4,#0x30]	; 037FD5B2
	ldr r0,[pool_037FD628]	; 037FD5B4
	str r0,[r4,#0x10]	; 037FD5B6
	ldr r0,[pool_037FD62C]	; 037FD5B8
	str r0,[r4,#0x24]	; 037FD5BA
	ldr r0,[pool_037FD630]	; 037FD5BC
	str r0,[r4,#0x38]	; 037FD5BE
	ldr r1,[pool_037FD634]	; 037FD5C0
	ldr r0,[pool_037FD638]	; 037FD5C2
	strh r1,[r0,#0x0]	; 037FD5C4
	ldr r0,[pool_037FD63C]	; 037FD5C6
	ldr r2,[pool_037FD640]	; 037FD5C8
	strh r0,[r2,#0x0]	; 037FD5CA
	ldr r2,[pool_037FD644]	; 037FD5CC
	strh r1,[r2,#0x0]	; 037FD5CE
	ldr r2,[pool_037FD648]	; 037FD5D0
	strh r0,[r2,#0x0]	; 037FD5D2
	ldr r2,[pool_037FD64C]	; 037FD5D4
	strh r1,[r2,#0x0]	; 037FD5D6
	ldr r1,[pool_037FD650]	; 037FD5D8
	strh r0,[r1,#0x0]	; 037FD5DA
	ldr r1,[pool_037FD6CC]	; 037FD5DC
	add r0,r5,#0x0	; 037FD5DE
	add r0,#0x8a	; 037FD5E0
	strh r1,[r0,#0x0]	; 037FD5E2
	mov r1,#0xd	; 037FD5E4
	ldr r0,[pool_037FD654]	; 037FD5E6
	strh r1,[r0,#0x0]	; 037FD5E8
loc_037FD5EA:
	ldrh r0,[r7,#0x18]	; 037FD5EA
	cmp r0,#0x0	; 037FD5EC
	beq loc_037FD5FE	; 037FD5EE
	add r0,r5,#0x0	; 037FD5F0
	add r0,#0x8a	; 037FD5F2
	ldrh r1,[r0,#0x0]	; 037FD5F4
	ldr r0,[pool_037FD6D0]	; 037FD5F6
	orr r1,r0	; 037FD5F8
	add r5,#0x8a	; 037FD5FA
	strh r1,[r5,#0x0]	; 037FD5FC
loc_037FD5FE:
	add sp,#0x4	; 037FD5FE
	pop {r4,r5,r6,r7}	; 037FD600
	pop {r3}	; 037FD602
	bx r3	; 037FD604
	.byte 0xC0, 0x46	; 037FD608
pool_037FD608:
loc_037FD608:
	.word 0x0380FFF4	; 037FD608
pool_037FD60C:
loc_037FD60C:
	.word 0x00000400	; 037FD60C
pool_037FD610:
loc_037FD610:
	.word 0x00000318	; 037FD610
pool_037FD614:
loc_037FD614:
	.word 0x000002F0	; 037FD614
pool_037FD618:
loc_037FD618:
	.word 0x0000FFFF	; 037FD618
pool_037FD61C:
loc_037FD61C:
	.word 0x04804170	; 037FD61C
pool_037FD620:
loc_037FD620:
	.word 0x04804028	; 037FD620
pool_037FD624:
loc_037FD624:
	.word 0x04804000	; 037FD624
pool_037FD628:
loc_037FD628:
	.word 0x0230AC71	; 037FD628
pool_037FD62C:
loc_037FD62C:
	.word 0x0230A9C1	; 037FD62C
pool_037FD630:
loc_037FD630:
	.word 0x0230A971	; 037FD630
pool_037FD634:
loc_037FD634:
	.word 0x0000B6B8	; 037FD634
pool_037FD638:
loc_037FD638:
	.word 0x04804024	; 037FD638
pool_037FD63C:
loc_037FD63C:
	.word 0x00001D46	; 037FD63C
pool_037FD640:
loc_037FD640:
	.word 0x04804026	; 037FD640
pool_037FD644:
loc_037FD644:
	.word 0x0480416C	; 037FD644
pool_037FD648:
loc_037FD648:
	.word 0x0480416E	; 037FD648
pool_037FD64C:
loc_037FD64C:
	.word 0x04804790	; 037FD64C
pool_037FD650:
loc_037FD650:
	.word 0x04804792	; 037FD650
pool_037FD654:
loc_037FD654:
	.word 0x048080AE	; 037FD654
pool_037FD658:
loc_037FD658:
	.word 0x04804AA0	; 037FD658
pool_037FD65C:
loc_037FD65C:
	.word 0x04804958	; 037FD65C
pool_037FD660:
loc_037FD660:
	.word 0x04804334	; 037FD660
pool_037FD664:
loc_037FD664:
	.word 0x0230A8A5	; 037FD664
pool_037FD668:
loc_037FD668:
	.word 0x04804238	; 037FD668
pool_037FD66C:
loc_037FD66C:
	.word 0x04804234	; 037FD66C
pool_037FD670:
loc_037FD670:
	.word 0x04804236	; 037FD670
pool_037FD674:
loc_037FD674:
	.word 0x04804330	; 037FD674
pool_037FD678:
loc_037FD678:
	.word 0x04804332	; 037FD678
pool_037FD67C:
loc_037FD67C:
	.word 0x04804954	; 037FD67C
pool_037FD680:
loc_037FD680:
	.word 0x04804956	; 037FD680
pool_037FD684:
loc_037FD684:
	.word 0x04804A9C	; 037FD684
pool_037FD688:
loc_037FD688:
	.word 0x04804A9E	; 037FD688
pool_037FD68C:
loc_037FD68C:
	.word 0x048050C0	; 037FD68C
pool_037FD690:
loc_037FD690:
	.word 0x048050C2	; 037FD690
pool_037FD694:
loc_037FD694:
	.word 0x00000208	; 037FD694
pool_037FD698:
loc_037FD698:
	.word 0x048045D8	; 037FD698
pool_037FD69C:
loc_037FD69C:
	.word 0x04804490	; 037FD69C
pool_037FD6A0:
loc_037FD6A0:
	.word 0x04804468	; 037FD6A0
pool_037FD6A4:
loc_037FD6A4:
	.word 0x04804230	; 037FD6A4
pool_037FD6A8:
loc_037FD6A8:
	.word 0x04804232	; 037FD6A8
pool_037FD6AC:
loc_037FD6AC:
	.word 0x04804464	; 037FD6AC
pool_037FD6B0:
loc_037FD6B0:
	.word 0x04804466	; 037FD6B0
pool_037FD6B4:
loc_037FD6B4:
	.word 0x0480448C	; 037FD6B4
pool_037FD6B8:
loc_037FD6B8:
	.word 0x0480448E	; 037FD6B8
pool_037FD6BC:
loc_037FD6BC:
	.word 0x048045D4	; 037FD6BC
pool_037FD6C0:
loc_037FD6C0:
	.word 0x048045D6	; 037FD6C0
pool_037FD6C4:
loc_037FD6C4:
	.word 0x04804BF8	; 037FD6C4
pool_037FD6C8:
loc_037FD6C8:
	.word 0x04804BFA	; 037FD6C8
pool_037FD6CC:
loc_037FD6CC:
	.word 0x00000108	; 037FD6CC
pool_037FD6D0:
loc_037FD6D0:
	.word 0x00004000	; 037FD6D0

; ===== function loc_037FD6D4 =====
loc_037FD6D4:
	bx pc	; 037FD6D4
	.byte 0xC0, 0x46	; 037FD6D8
.arm

; ===== function loc_037FD6D8 =====
loc_037FD6D8:
	ldr pc,[pool_037FD6DC]	; 037FD6D8
pool_037FD6DC:
loc_037FD6DC:
	.word 0x037FF350	; 037FD6DC
.thumb

; ===== function loc_037FD6E0 =====
loc_037FD6E0:
	bx pc	; 037FD6E0
	.byte 0xC0, 0x46	; 037FD6E4
.arm

; ===== function loc_037FD6E4 =====
loc_037FD6E4:
	ldr r12,[pool_037FD6EC]	; 037FD6E4
	bx r12	; 037FD6E8
pool_037FD6EC:
loc_037FD6EC:
	.word 0x0230A0B5	; 037FD6EC
.thumb

; ===== function loc_037FD6F0 =====
loc_037FD6F0:
	push {r4,r5,r6,lr}	; 037FD6F0
	sub sp,#0x8	; 037FD6F2
	ldr r0,[pool_037FD780]	; 037FD6F4
	ldr r1,[r0,#0x0]	; 037FD6F6
	ldr r0,[pool_037FD784]	; 037FD6F8
	add r6,r1,r0	; 037FD6FA
	ldr r0,[pool_037FD788]	; 037FD6FC
	add r4,r1,r0	; 037FD6FE
	mov r0,#0x0	; 037FD700
	str r0,[sp,#0x0]	; 037FD702
	ldr r0,[sp,#0x0]	; 037FD704
	add r1,r4,#0x0	; 037FD706
	mov r2,#0x50	; 037FD708
	bl loc_037FD7D0	; 037FD70A
	ldr r1,[pool_037FD78C]	; 037FD70E
	ldr r0,[pool_037FD790]	; 037FD710
	strh r1,[r0,#0x0]	; 037FD712
	ldr r0,[pool_037FD780]	; 037FD714
	ldr r1,[r0,#0x0]	; 037FD716
	ldr r0,[pool_037FD794]	; 037FD718
	ldrh r0,[r1,r0]	; 037FD71A
	cmp r0,#0x3	; 037FD71C
	bhi loc_037FD744	; 037FD71E
	add r0,r0,r0	; 037FD720
	add r0,pc	; 037FD722
	ldrh r0,[r0,#0x8]	; 037FD724
	lsl r0,r0,#0x10	; 037FD726
	asr r0,r0,#0x10	; 037FD728
	add r0,pc	; 037FD72A
	bx r0	; 037FD72C
	.byte 0x09, 0x00, 0x0D, 0x00, 0x11, 0x00, 0x15, 0x00	; 037FD736
loc_037FD736:
	ldr r5,[pool_037FD798]	; 037FD736
	b loc_037FD744	; 037FD738
loc_037FD73A:
	ldr r5,[pool_037FD79C]	; 037FD73A
	b loc_037FD744	; 037FD73C
loc_037FD73E:
	ldr r5,[pool_037FD7A0]	; 037FD73E
	b loc_037FD744	; 037FD740
loc_037FD742:
	ldr r5,[pool_037FD798]	; 037FD742
loc_037FD744:
	ldr r0,[pool_037FD7A4]	; 037FD744
	add r1,r5,r0	; 037FD746
	ldr r0,[pool_037FD7A8]	; 037FD748
	strh r1,[r0,#0x0]	; 037FD74A
	lsl r0,r5,#0xf	; 037FD74C
	lsr r2,r0,#0x10	; 037FD74E
	ldr r0,[pool_037FD7AC]	; 037FD750
	strh r2,[r0,#0x0]	; 037FD752
	ldr r1,[pool_037FD7B0]	; 037FD754
	ldr r0,[pool_037FD7B4]	; 037FD756
	strh r1,[r0,#0x0]	; 037FD758
	ldr r0,[pool_037FD7B8]	; 037FD75A
	strh r2,[r0,#0x0]	; 037FD75C
	strh r2,[r4,#0x4]	; 037FD75E
	ldr r0,[pool_037FD7BC]	; 037FD760
	strh r0,[r4,#0x0]	; 037FD762
	ldr r0,[pool_037FD7C0]	; 037FD764
	sub r0,r0,r5	; 037FD766
	add r6,#0x9a	; 037FD768
	strh r0,[r6,#0x0]	; 037FD76A
	ldr r1,[pool_037FD7C4]	; 037FD76C
	ldr r0,[pool_037FD7C8]	; 037FD76E
	strh r1,[r0,#0x0]	; 037FD770
	ldr r1,[pool_037FD7CC]	; 037FD772
	ldr r0,[pool_037FD790]	; 037FD774
	strh r1,[r0,#0x0]	; 037FD776
	add sp,#0x8	; 037FD778
	pop {r4,r5,r6}	; 037FD77A
	pop {r3}	; 037FD77C
	bx r3	; 037FD77E
pool_037FD780:
loc_037FD780:
	.word 0x0380FFF4	; 037FD780
pool_037FD784:
loc_037FD784:
	.word 0x00000318	; 037FD784
pool_037FD788:
loc_037FD788:
	.word 0x000004B4	; 037FD788
pool_037FD78C:
loc_037FD78C:
	.word 0x00008000	; 037FD78C
pool_037FD790:
loc_037FD790:
	.word 0x04808030	; 037FD790
pool_037FD794:
loc_037FD794:
	.word 0x00000324	; 037FD794
pool_037FD798:
loc_037FD798:
	.word 0x00000794	; 037FD798
pool_037FD79C:
loc_037FD79C:
	.word 0x000010C4	; 037FD79C
pool_037FD7A0:
loc_037FD7A0:
	.word 0x00000BFC	; 037FD7A0
pool_037FD7A4:
loc_037FD7A4:
	.word 0x04804000	; 037FD7A4
pool_037FD7A8:
loc_037FD7A8:
	.word 0x04808050	; 037FD7A8
pool_037FD7AC:
loc_037FD7AC:
	.word 0x04808056	; 037FD7AC
pool_037FD7B0:
loc_037FD7B0:
	.word 0x00005F60	; 037FD7B0
pool_037FD7B4:
loc_037FD7B4:
	.word 0x04808052	; 037FD7B4
pool_037FD7B8:
loc_037FD7B8:
	.word 0x0480805A	; 037FD7B8
pool_037FD7BC:
loc_037FD7BC:
	.word 0x0000FFFF	; 037FD7BC
pool_037FD7C0:
loc_037FD7C0:
	.word 0x00001F60	; 037FD7C0
pool_037FD7C4:
loc_037FD7C4:
	.word 0x00005F5E	; 037FD7C4
pool_037FD7C8:
loc_037FD7C8:
	.word 0x04808062	; 037FD7C8
pool_037FD7CC:
loc_037FD7CC:
	.word 0x00008001	; 037FD7CC

; ===== function loc_037FD7D0 =====
loc_037FD7D0:
	bx pc	; 037FD7D0
	.byte 0xC0, 0x46	; 037FD7D4
.arm

; ===== function loc_037FD7D4 =====
loc_037FD7D4:
	ldr pc,[pool_037FD7D8]	; 037FD7D4
pool_037FD7D8:
loc_037FD7D8:
	.word 0x037FF350	; 037FD7D8

; ===== function loc_037FD7DC =====
	stmdb sp!,{lr}	; 037FD7DC
	mov r12,#0x4000000	; 037FD7E0
	add r12,r12,#0x210	; 037FD7E4
	ldr r1,[r12,#-0x8]	; 037FD7E8
	cmp r1,#0x0	; 037FD7EC
	ldmeqia sp!,{pc}	; 037FD7F0
	ldmia r12,{r1,r2}	; 037FD7F4
	ands r1,r1,r2	; 037FD7F8
	ldmeqia sp!,{pc}	; 037FD7FC
	mov r3,#0x1	; 037FD800
	mov r0,#0x0	; 037FD804
loc_037FD808:
	ands r2,r1,r3, lsl r0	; 037FD808
	addeq r0,r0,#0x1	; 037FD80C
	beq loc_037FD808	; 037FD810
	str r2,[r12,#0x4]	; 037FD814
	ldr r1,[pool_037FD828]	; 037FD818
	ldr r0,[r1,r0,lsl #0x2]	; 037FD81C
	ldr lr,[pool_037FD82C]	; 037FD820
	bx r0	; 037FD824
pool_037FD828:
loc_037FD828:
	.word 0x03805274	; 037FD828
pool_037FD82C:
loc_037FD82C:
	.word 0x037FD830	; 037FD82C
	.byte 0x0C, 0xC1, 0x9F, 0xE5, 0xB0, 0x30, 0xDC, 0xE1, 0x00, 0x00, 0xA0, 0xE3, 0x00, 0x00, 0x53, 0xE3	; 037FD840
	.byte 0x0C, 0x00, 0x00, 0x0A, 0xB0, 0x00, 0xCC, 0xE1, 0xF8, 0xC0, 0x9F, 0xE5, 0x01, 0x10, 0xA0, 0xE3	; 037FD850
	.byte 0xB0, 0x10, 0xCC, 0xE1, 0x0C, 0xC0, 0x9C, 0xE5, 0x01, 0x20, 0xA0, 0xE3, 0x00, 0x00, 0x5C, 0xE3	; 037FD860
	.byte 0x04, 0x00, 0x00, 0x0A, 0x50, 0x00, 0x9C, 0xE5, 0x11, 0x00, 0x13, 0xE1, 0x48, 0x20, 0x8C, 0x15	; 037FD870
	.byte 0x4C, 0xC0, 0x9C, 0xE5, 0xF8, 0xFF, 0xFF, 0xEA, 0xC8, 0xC0, 0x9F, 0xE5, 0xB0, 0x10, 0xDC, 0xE1	; 037FD880
	.byte 0x00, 0x00, 0x51, 0xE3, 0x04, 0xF0, 0x9D, 0x04, 0x00, 0x10, 0xA0, 0xE3, 0xB0, 0x10, 0xCC, 0xE1	; 037FD890
	.byte 0xD2, 0x30, 0xA0, 0xE3, 0x03, 0xF0, 0x21, 0xE1, 0x0C, 0x20, 0x8C, 0xE2, 0x00, 0x10, 0x92, 0xE5	; 037FD8A0
	.byte 0x00, 0x00, 0x51, 0xE3, 0xB8, 0x04, 0xD1, 0x11, 0x01, 0x00, 0x50, 0x13, 0x4C, 0x10, 0x91, 0x15	; 037FD8B0
	.byte 0xFA, 0xFF, 0xFF, 0x1A, 0x00, 0x00, 0x51, 0xE3, 0x02, 0x00, 0x00, 0x1A, 0x92, 0x30, 0xA0, 0xE3	; 037FD8C0
	.byte 0x03, 0xF0, 0x21, 0xE1, 0x04, 0xF0, 0x9D, 0xE4, 0x08, 0x00, 0x9C, 0xE5, 0x00, 0x00, 0x51, 0xE1	; 037FD8D0
	.byte 0xF9, 0xFF, 0xFF, 0x0A, 0x10, 0x30, 0x9C, 0xE5, 0x00, 0x00, 0x53, 0xE3, 0x03, 0x00, 0x00, 0x0A	; 037FD8E0
	.byte 0x03, 0x10, 0x2D, 0xE9, 0x0F, 0xE0, 0xA0, 0xE1, 0x13, 0xFF, 0x2F, 0xE1, 0x03, 0x10, 0xBD, 0xE8	; 037FD8F0
	.byte 0x08, 0x10, 0x8C, 0xE5, 0x00, 0x20, 0x4F, 0xE1, 0x00, 0x20, 0xA0, 0xE5, 0x0C, 0x00, 0xBD, 0xE9	; 037FD900
	.byte 0x0C, 0x00, 0xA0, 0xE9, 0x0C, 0x50, 0xBD, 0xE9, 0xFC, 0x7F, 0xE0, 0xE9, 0x00, 0x40, 0xA0, 0xE9	; 037FD910
	.byte 0xD3, 0x30, 0xA0, 0xE3, 0x03, 0xF0, 0x21, 0xE1, 0x00, 0x20, 0xA0, 0xE9, 0x44, 0xD0, 0x91, 0xE5	; 037FD920
	.byte 0xD2, 0x30, 0xA0, 0xE3, 0x03, 0xF0, 0x21, 0xE1, 0x00, 0x20, 0xB1, 0xE5, 0x02, 0xF0, 0x69, 0xE1	; 037FD930
	.byte 0x40, 0xE0, 0x91, 0xE5, 0xFF, 0x7F, 0xF1, 0xE9, 0x00, 0x00, 0xA0, 0xE1, 0x0F, 0x50, 0x2D, 0xE8	; 037FD940
	.byte 0x00, 0x80, 0xBD, 0xE8, 0x64, 0x58, 0x80, 0x03, 0xE4, 0x58, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0	; 037FD950
	.byte 0x08, 0x48, 0x02, 0x6E, 0x08, 0x49, 0x08, 0x68, 0x40, 0x1C, 0x08, 0x60, 0x00, 0x2A, 0x01, 0xD0	; 037FD960
	.byte 0x07, 0xF0, 0x94, 0xFB, 0x05, 0x4A, 0x11, 0x68, 0x01, 0x20, 0x01, 0x43, 0x11, 0x60, 0x01, 0xB0	; 037FD970
	.byte 0x08, 0xBC, 0x18, 0x47, 0x68, 0x58, 0x80, 0x03, 0x3C, 0xFC, 0x7F, 0x02, 0xF8, 0xFF, 0x80, 0x03	; 037FD980
.thumb
	mov r0,#0x7	; 037FD980
	ldr r3,[pool_037FD988]	; 037FD982
	bx r3	; 037FD984
	.byte 0xC0, 0x46	; 037FD988
pool_037FD988:
loc_037FD988:
	.word 0x037FD9E1	; 037FD988
	mov r0,#0x6	; 037FD98C
	ldr r3,[pool_037FD994]	; 037FD98E
	bx r3	; 037FD990
	.byte 0xC0, 0x46	; 037FD994
pool_037FD994:
loc_037FD994:
	.word 0x037FD9E1	; 037FD994
	mov r0,#0x5	; 037FD998
	ldr r3,[pool_037FD9A0]	; 037FD99A
	bx r3	; 037FD99C
	.byte 0xC0, 0x46	; 037FD9A0
pool_037FD9A0:
loc_037FD9A0:
	.word 0x037FD9E1	; 037FD9A0
	mov r0,#0x4	; 037FD9A4
	ldr r3,[pool_037FD9AC]	; 037FD9A6
	bx r3	; 037FD9A8
	.byte 0xC0, 0x46	; 037FD9AC
pool_037FD9AC:
loc_037FD9AC:
	.word 0x037FD9E1	; 037FD9AC
	mov r0,#0x3	; 037FD9B0
	ldr r3,[pool_037FD9B8]	; 037FD9B2
	bx r3	; 037FD9B4
	.byte 0xC0, 0x46	; 037FD9B8
pool_037FD9B8:
loc_037FD9B8:
	.word 0x037FD9E1	; 037FD9B8
	mov r0,#0x2	; 037FD9BC
	ldr r3,[pool_037FD9C4]	; 037FD9BE
	bx r3	; 037FD9C0
	.byte 0xC0, 0x46	; 037FD9C4
pool_037FD9C4:
loc_037FD9C4:
	.word 0x037FD9E1	; 037FD9C4
	mov r0,#0x1	; 037FD9C8
	ldr r3,[pool_037FD9D0]	; 037FD9CA
	bx r3	; 037FD9CC
	.byte 0xC0, 0x46	; 037FD9D0
pool_037FD9D0:
loc_037FD9D0:
	.word 0x037FD9E1	; 037FD9D0
	mov r0,#0x0	; 037FD9D4
	ldr r3,[pool_037FD9DC]	; 037FD9D6
	bx r3	; 037FD9D8
	.byte 0xC0, 0x46	; 037FD9DC
pool_037FD9DC:
loc_037FD9DC:
	.word 0x037FD9E1	; 037FD9DC
loc_037FD9E0:
	push {r4,r5,lr}	; 037FD9E0
	sub sp,#0x4	; 037FD9E2
	mov r5,#0x1	; 037FD9E4
	lsl r2,r0,#0x1	; 037FD9E6
	ldr r1,[pool_037FDA28]	; 037FD9E8
	ldrh r1,[r1,r2]	; 037FD9EA
	lsl r5,r1	; 037FD9EC
	mov r1,#0xc	; 037FD9EE
	add r4,r0,#0x0	; 037FD9F0
	mul r4,r1	; 037FD9F2
	ldr r2,[pool_037FDA2C]	; 037FD9F4
	ldr r1,[r2,r4]	; 037FD9F6
	mov r0,#0x0	; 037FD9F8
	str r0,[r2,r4]	; 037FD9FA
	cmp r1,#0x0	; 037FD9FC
	beq loc_037FDA08	; 037FD9FE
	ldr r0,[pool_037FDA30]	; 037FDA00
	ldr r0,[r0,r4]	; 037FDA02
	bl loc_03805088	; 037FDA04
loc_037FDA08:
	ldr r1,[pool_037FDA34]	; 037FDA08
	ldr r0,[r1,#0x0]	; 037FDA0A
	orr r0,r5	; 037FDA0C
	str r0,[r1,#0x0]	; 037FDA0E
	ldr r0,[pool_037FDA38]	; 037FDA10
	ldr r0,[r0,r4]	; 037FDA12
	cmp r0,#0x0	; 037FDA14
	bne loc_037FDA1E	; 037FDA16
	add r0,r5,#0x0	; 037FDA18
	bl loc_037FDA64	; 037FDA1A
loc_037FDA1E:
	add sp,#0x4	; 037FDA1E
	pop {r4,r5}	; 037FDA20
	pop {r3}	; 037FDA22
	bx r3	; 037FDA24
	.byte 0xC0, 0x46	; 037FDA28
pool_037FDA28:
loc_037FDA28:
	.word 0x03805260	; 037FDA28
pool_037FDA2C:
loc_037FDA2C:
	.word 0x03805868	; 037FDA2C
pool_037FDA30:
loc_037FDA30:
	.word 0x03805870	; 037FDA30
pool_037FDA34:
loc_037FDA34:
	.word 0x0380FFF8	; 037FDA34
pool_037FDA38:
loc_037FDA38:
	.word 0x0380586C	; 037FDA38
loc_037FDA3C:
	bx lr	; 037FDA3C
	.byte 0x00, 0x00	; 037FDA40

; ===== function loc_037FDA40 =====
loc_037FDA40:
	push {r4,lr}	; 037FDA40
	ldr r4,[pool_037FDA5C]	; 037FDA42
	ldrh r3,[r4,#0x0]	; 037FDA44
	mov r1,#0x0	; 037FDA46
	strh r1,[r4,#0x0]	; 037FDA48
	ldr r2,[pool_037FDA60]	; 037FDA4A
	ldr r1,[r2,#0x0]	; 037FDA4C
	str r0,[r2,#0x0]	; 037FDA4E
	ldrh r0,[r4,#0x0]	; 037FDA50
	strh r3,[r4,#0x0]	; 037FDA52
	add r0,r1,#0x0	; 037FDA54
	pop {r4}	; 037FDA56
	pop {r3}	; 037FDA58
	bx r3	; 037FDA5A
pool_037FDA5C:
loc_037FDA5C:
	.word 0x04000208	; 037FDA5C
pool_037FDA60:
loc_037FDA60:
	.word 0x04000214	; 037FDA60

; ===== function loc_037FDA64 =====
loc_037FDA64:
	push {r4,r5,lr}	; 037FDA64
	sub sp,#0x4	; 037FDA66
	ldr r5,[pool_037FDA88]	; 037FDA68
	ldrh r4,[r5,#0x0]	; 037FDA6A
	mov r1,#0x0	; 037FDA6C
	strh r1,[r5,#0x0]	; 037FDA6E
	ldr r3,[pool_037FDA8C]	; 037FDA70
	ldr r2,[r3,#0x0]	; 037FDA72
	add r1,r2,#0x0	; 037FDA74
	bic r1,r0	; 037FDA76
	str r1,[r3,#0x0]	; 037FDA78
	ldrh r0,[r5,#0x0]	; 037FDA7A
	strh r4,[r5,#0x0]	; 037FDA7C
	add r0,r2,#0x0	; 037FDA7E
	add sp,#0x4	; 037FDA80
	pop {r4,r5}	; 037FDA82
	pop {r3}	; 037FDA84
	bx r3	; 037FDA86
pool_037FDA88:
loc_037FDA88:
	.word 0x04000208	; 037FDA88
pool_037FDA8C:
loc_037FDA8C:
	.word 0x04000210	; 037FDA8C

; ===== function loc_037FDA90 =====
loc_037FDA90:
	push {r4,r5,lr}	; 037FDA90
	sub sp,#0x4	; 037FDA92
	ldr r5,[pool_037FDAB4]	; 037FDA94
	ldrh r4,[r5,#0x0]	; 037FDA96
	mov r1,#0x0	; 037FDA98
	strh r1,[r5,#0x0]	; 037FDA9A
	ldr r3,[pool_037FDAB8]	; 037FDA9C
	ldr r2,[r3,#0x0]	; 037FDA9E
	add r1,r2,#0x0	; 037FDAA0
	orr r1,r0	; 037FDAA2
	str r1,[r3,#0x0]	; 037FDAA4
	ldrh r0,[r5,#0x0]	; 037FDAA6
	strh r4,[r5,#0x0]	; 037FDAA8
	add r0,r2,#0x0	; 037FDAAA
	add sp,#0x4	; 037FDAAC
	pop {r4,r5}	; 037FDAAE
	pop {r3}	; 037FDAB0
	bx r3	; 037FDAB2
pool_037FDAB4:
loc_037FDAB4:
	.word 0x04000208	; 037FDAB4
pool_037FDAB8:
loc_037FDAB8:
	.word 0x04000210	; 037FDAB8

; ===== function loc_037FDABC =====
loc_037FDABC:
	push {r4,lr}	; 037FDABC
	ldr r4,[pool_037FDAD8]	; 037FDABE
	ldrh r3,[r4,#0x0]	; 037FDAC0
	mov r1,#0x0	; 037FDAC2
	strh r1,[r4,#0x0]	; 037FDAC4
	ldr r2,[pool_037FDADC]	; 037FDAC6
	ldr r1,[r2,#0x0]	; 037FDAC8
	str r0,[r2,#0x0]	; 037FDACA
	ldrh r0,[r4,#0x0]	; 037FDACC
	strh r3,[r4,#0x0]	; 037FDACE
	add r0,r1,#0x0	; 037FDAD0
	pop {r4}	; 037FDAD2
	pop {r3}	; 037FDAD4
	bx r3	; 037FDAD6
pool_037FDAD8:
loc_037FDAD8:
	.word 0x04000208	; 037FDAD8
pool_037FDADC:
loc_037FDADC:
	.word 0x04000210	; 037FDADC

; ===== function loc_037FDAE0 =====
loc_037FDAE0:
	push {r4,lr}	; 037FDAE0
	mov r3,#0xc	; 037FDAE2
	add r4,r0,#0x0	; 037FDAE4
	mul r4,r3	; 037FDAE6
	ldr r3,[pool_037FDB08]	; 037FDAE8
	str r1,[r3,r4]	; 037FDAEA
	ldr r1,[pool_037FDB0C]	; 037FDAEC
	str r2,[r1,r4]	; 037FDAEE
	mov r1,#0x1	; 037FDAF0
	add r0,r0,#0x3	; 037FDAF2
	lsl r1,r0	; 037FDAF4
	add r0,r1,#0x0	; 037FDAF6
	bl loc_037FDA90	; 037FDAF8
	mov r1,#0x1	; 037FDAFC
	ldr r0,[pool_037FDB10]	; 037FDAFE
	str r1,[r0,r4]	; 037FDB00
	pop {r4}	; 037FDB02
	pop {r3}	; 037FDB04
	bx r3	; 037FDB06
pool_037FDB08:
loc_037FDB08:
	.word 0x03805898	; 037FDB08
pool_037FDB0C:
loc_037FDB0C:
	.word 0x038058A0	; 037FDB0C
pool_037FDB10:
loc_037FDB10:
	.word 0x0380589C	; 037FDB10

; ===== function loc_037FDB14 =====
loc_037FDB14:
	push {r4,r5,r6,r7,lr}	; 037FDB14
	sub sp,#0x4	; 037FDB16
	mov r5,#0x0	; 037FDB18
	add r3,r5,#0x0	; 037FDB1A
	add r2,r5,#0x0	; 037FDB1C
loc_037FDB1E:
	add r6,r0,#0x0	; 037FDB1E
	mov r4,#0x1	; 037FDB20
	and r6,r4	; 037FDB22
	cmp r6,#0x0	; 037FDB24
	beq loc_037FDB6E	; 037FDB26
	add r4,r3,#0x0	; 037FDB28
	cmp r5,#0x8	; 037FDB2A
	blt loc_037FDB40	; 037FDB2C
	cmp r5,#0xb	; 037FDB2E
	bgt loc_037FDB40	; 037FDB30
	add r6,r5,#0x0	; 037FDB32
	sub r6,#0x8	; 037FDB34
	mov r4,#0xc	; 037FDB36
	mul r6,r4	; 037FDB38
	ldr r4,[pool_037FDB80]	; 037FDB3A
	add r4,r4,r6	; 037FDB3C
	b loc_037FDB62	; 037FDB3E
loc_037FDB40:
	cmp r5,#0x3	; 037FDB40
	blt loc_037FDB54	; 037FDB42
	cmp r5,#0x6	; 037FDB44
	bgt loc_037FDB54	; 037FDB46
	add r6,r5,#0x1	; 037FDB48
	mov r4,#0xc	; 037FDB4A
	mul r6,r4	; 037FDB4C
	ldr r4,[pool_037FDB80]	; 037FDB4E
	add r4,r4,r6	; 037FDB50
	b loc_037FDB62	; 037FDB52
loc_037FDB54:
	cmp r5,#0x0	; 037FDB54
	bne loc_037FDB5C	; 037FDB56
	ldr r4,[pool_037FDB84]	; 037FDB58
	b loc_037FDB62	; 037FDB5A
loc_037FDB5C:
	lsl r7,r5,#0x2	; 037FDB5C
	ldr r6,[pool_037FDB88]	; 037FDB5E
	str r1,[r6,r7]	; 037FDB60
loc_037FDB62:
	cmp r4,#0x0	; 037FDB62
	beq loc_037FDB6E	; 037FDB64
	str r1,[r4,#0x0]	; 037FDB66
	str r2,[r4,#0x8]	; 037FDB68
	mov r6,#0x1	; 037FDB6A
	str r6,[r4,#0x4]	; 037FDB6C
loc_037FDB6E:
	lsr r0,r0,#0x1	; 037FDB6E
	add r5,r5,#0x1	; 037FDB70
	cmp r5,#0x19	; 037FDB72
	blt loc_037FDB1E	; 037FDB74
	add sp,#0x4	; 037FDB76
	pop {r4,r5,r6,r7}	; 037FDB78
	pop {r3}	; 037FDB7A
	bx r3	; 037FDB7C
	.byte 0xC0, 0x46	; 037FDB80
pool_037FDB80:
loc_037FDB80:
	.word 0x03805868	; 037FDB80
pool_037FDB84:
loc_037FDB84:
	.word 0x038058C8	; 037FDB84
pool_037FDB88:
loc_037FDB88:
	.word 0x03805274	; 037FDB88

; ===== function loc_037FDB8C =====
loc_037FDB8C:
	mov r1,#0x0	; 037FDB8C
	ldr r0,[pool_037FDB98]	; 037FDB8E
	strh r1,[r0,#0x0]	; 037FDB90
	ldr r0,[pool_037FDB9C]	; 037FDB92
	str r1,[r0,#0x0]	; 037FDB94
	bx lr	; 037FDB96
pool_037FDB98:
loc_037FDB98:
	.word 0x03805864	; 037FDB98
pool_037FDB9C:
loc_037FDB9C:
	.word 0x027FFC3C	; 037FDB9C

; ===== function loc_037FDBA0 =====
loc_037FDBA0:
	ldr r1,[pool_037FDBA4]	; 037FDBA0
	bx r1	; 037FDBA2
pool_037FDBA4:
loc_037FDBA4:
	.word 0x037FDC59	; 037FDBA4
.arm

; ===== function loc_037FDBA8 =====
loc_037FDBA8:
	ldr r3,[pool_037FDC38]	; 037FDBA8
	ldr r1,[r3,#0x0]	; 037FDBAC
	mov r2,#0x0	; 037FDBB0
	mov r0,#0x80000000	; 037FDBB4
loc_037FDBB8:
	tst r1,r0	; 037FDBB8
	bne loc_037FDBD4	; 037FDBBC
	add r2,r2,#0x1	; 037FDBC0
	cmp r2,#0x20	; 037FDBC4
	beq loc_037FDBD4	; 037FDBC8
	mov r0,r0, lsr #0x1	; 037FDBCC
	b loc_037FDBB8	; 037FDBD0
loc_037FDBD4:
	cmp r2,#0x20	; 037FDBD4
	movne r0,#0x80	; 037FDBD8
	bne loc_037FDC1C	; 037FDBDC
	add r3,r3,#0x4	; 037FDBE0
	ldr r1,[r3,#0x0]	; 037FDBE4
	mov r2,#0x0	; 037FDBE8
	mov r0,#0x80000000	; 037FDBEC
loc_037FDBF0:
	tst r1,r0	; 037FDBF0
	bne loc_037FDC0C	; 037FDBF4
	add r2,r2,#0x1	; 037FDBF8
	cmp r2,#0x20	; 037FDBFC
	beq loc_037FDC0C	; 037FDC00
	mov r0,r0, lsr #0x1	; 037FDC04
	b loc_037FDBF0	; 037FDC08
loc_037FDC0C:
	cmp r2,#0x20	; 037FDC0C
	ldr r0,[pool_037FDC3C]	; 037FDC10
	bxeq lr	; 037FDC14
	mov r0,#0xa0	; 037FDC18
loc_037FDC1C:
	add r0,r0,r2	; 037FDC1C
	mov r1,#0x80000000	; 037FDC20
	mov r1,r1, lsr r2	; 037FDC24
	ldr r2,[r3,#0x0]	; 037FDC28
	bic r2,r2,r1	; 037FDC2C
	str r2,[r3,#0x0]	; 037FDC30
	bx lr	; 037FDC34
pool_037FDC38:
loc_037FDC38:
	.word 0x027FFFB8	; 037FDC38
pool_037FDC3C:
loc_037FDC3C:
	.word 0xFFFFFFFD	; 037FDC3C
.thumb

; ===== function loc_037FDC40 =====
loc_037FDC40:
	ldr r0,[pool_037FDC48]	; 037FDC40
	ldr r3,[pool_037FDC4C]	; 037FDC42
	bx r3	; 037FDC44
	.byte 0xC0, 0x46	; 037FDC48
pool_037FDC48:
loc_037FDC48:
	.word 0x00001000	; 037FDC48
pool_037FDC4C:
loc_037FDC4C:
	.word 0x037FF1C9	; 037FDC4C
	.byte 0x70, 0x47, 0x00, 0x00, 0x70, 0x47, 0x00, 0x00	; 037FDC58

; ===== function loc_037FDC58 =====
loc_037FDC58:
	ldr r1,[pool_037FDC60]	; 037FDC58
	ldr r2,[pool_037FDC64]	; 037FDC5A
	ldr r3,[pool_037FDC68]	; 037FDC5C
	bx r3	; 037FDC5E
pool_037FDC60:
loc_037FDC60:
	.word 0x027FFFE0	; 037FDC60
pool_037FDC64:
loc_037FDC64:
	.word 0x037FDC51	; 037FDC64
pool_037FDC68:
loc_037FDC68:
	.word 0x037FDD21	; 037FDC68

; ===== function loc_037FDC6C =====
loc_037FDC6C:
	ldr r1,[pool_037FDC74]	; 037FDC6C
	ldr r2,[pool_037FDC78]	; 037FDC6E
	ldr r3,[pool_037FDC7C]	; 037FDC70
	bx r3	; 037FDC72
pool_037FDC74:
loc_037FDC74:
	.word 0x027FFFE0	; 037FDC74
pool_037FDC78:
loc_037FDC78:
	.word 0x037FDC55	; 037FDC78
pool_037FDC7C:
loc_037FDC7C:
	.word 0x037FDD85	; 037FDC7C

; ===== function loc_037FDC80 =====
loc_037FDC80:
	push {r4,r5,r6,r7,lr}	; 037FDC80
	sub sp,#0xc	; 037FDC82
	add r5,r0,#0x0	; 037FDC84
	add r6,r1,#0x0	; 037FDC86
	add r4,r2,#0x0	; 037FDC88
	add r7,r3,#0x0	; 037FDC8A
	cmp r7,#0x0	; 037FDC8C
	beq loc_037FDC98	; 037FDC8E
	bl loc_037FDCD4	; 037FDC90
	str r0,[sp,#0x0]	; 037FDC94
	b loc_037FDC9E	; 037FDC96
loc_037FDC98:
	bl loc_037FDCE0	; 037FDC98
	str r0,[sp,#0x0]	; 037FDC9C
loc_037FDC9E:
	add r0,r5,#0x0	; 037FDC9E
	add r1,r6,#0x0	; 037FDCA0
	bl loc_037FDCEC	; 037FDCA2
	str r0,[sp,#0x4]	; 037FDCA6
	cmp r0,#0x0	; 037FDCA8
	bne loc_037FDCB6	; 037FDCAA
	cmp r4,#0x0	; 037FDCAC
	beq loc_037FDCB4	; 037FDCAE
	bl loc_03805094	; 037FDCB0
loc_037FDCB4:
	strh r5,[r6,#0x4]	; 037FDCB4
loc_037FDCB6:
	cmp r7,#0x0	; 037FDCB6
	beq loc_037FDCC2	; 037FDCB8
	ldr r0,[sp,#0x0]	; 037FDCBA
	bl loc_037FDCF8	; 037FDCBC
	b loc_037FDCC8	; 037FDCC0
loc_037FDCC2:
	ldr r0,[sp,#0x0]	; 037FDCC2
	bl loc_037FDD04	; 037FDCC4
loc_037FDCC8:
	ldr r0,[sp,#0x4]	; 037FDCC8
	add sp,#0xc	; 037FDCCA
	pop {r4,r5,r6,r7}	; 037FDCCC
	pop {r3}	; 037FDCCE
	bx r3	; 037FDCD0
	.byte 0xC0, 0x46	; 037FDCD4

; ===== function loc_037FDCD4 =====
loc_037FDCD4:
	bx pc	; 037FDCD4
	.byte 0xC0, 0x46	; 037FDCD8
.arm

; ===== function loc_037FDCD8 =====
loc_037FDCD8:
	ldr pc,[pool_037FDCDC]	; 037FDCD8
pool_037FDCDC:
loc_037FDCDC:
	.word 0x037FF130	; 037FDCDC
.thumb

; ===== function loc_037FDCE0 =====
loc_037FDCE0:
	bx pc	; 037FDCE0
	.byte 0xC0, 0x46	; 037FDCE4
.arm

; ===== function loc_037FDCE4 =====
loc_037FDCE4:
	ldr pc,[pool_037FDCE8]	; 037FDCE4
pool_037FDCE8:
loc_037FDCE8:
	.word 0x037FF104	; 037FDCE8
.thumb

; ===== function loc_037FDCEC =====
loc_037FDCEC:
	bx pc	; 037FDCEC
	.byte 0xC0, 0x46	; 037FDCF0
.arm

; ===== function loc_037FDCF0 =====
loc_037FDCF0:
	ldr pc,[pool_037FDCF4]	; 037FDCF0
pool_037FDCF4:
loc_037FDCF4:
	.word 0x037FF3FC	; 037FDCF4
.thumb

; ===== function loc_037FDCF8 =====
loc_037FDCF8:
	bx pc	; 037FDCF8
	.byte 0xC0, 0x46	; 037FDCFC
.arm

; ===== function loc_037FDCFC =====
loc_037FDCFC:
	ldr pc,[pool_037FDD00]	; 037FDCFC
pool_037FDD00:
loc_037FDD00:
	.word 0x037FF144	; 037FDD00
.thumb

; ===== function loc_037FDD04 =====
loc_037FDD04:
	bx pc	; 037FDD04
	.byte 0xC0, 0x46	; 037FDD08
.arm

; ===== function loc_037FDD08 =====
loc_037FDD08:
	ldr pc,[pool_037FDD0C]	; 037FDD08
pool_037FDD0C:
loc_037FDD0C:
	.word 0x037FF118	; 037FDD0C
.thumb

; ===== function loc_037FDD10 =====
loc_037FDD10:
	push {lr}	; 037FDD10
	sub sp,#0x4	; 037FDD12
	mov r3,#0x0	; 037FDD14
	bl loc_037FDD30	; 037FDD16
	add sp,#0x4	; 037FDD1A
	pop {r3}	; 037FDD1C
	bx r3	; 037FDD1E
loc_037FDD20:
	push {lr}	; 037FDD20
	sub sp,#0x4	; 037FDD22
	mov r3,#0x0	; 037FDD24
	bl loc_037FDD30	; 037FDD26
	add sp,#0x4	; 037FDD2A
	pop {r3}	; 037FDD2C
	bx r3	; 037FDD2E

; ===== function loc_037FDD30 =====
loc_037FDD30:
	push {r4,r5,r6,r7,lr}	; 037FDD30
	sub sp,#0x4	; 037FDD32
	add r5,r1,#0x0	; 037FDD34
	add r4,r2,#0x0	; 037FDD36
	add r6,r3,#0x0	; 037FDD38
	ldrh r1,[r5,#0x4]	; 037FDD3A
	cmp r0,r1	; 037FDD3C
	beq loc_037FDD46	; 037FDD3E
	mov r0,#0x1	; 037FDD40
	mvn r0,r0	; 037FDD42
	b loc_037FDD7C	; 037FDD44
loc_037FDD46:
	cmp r6,#0x0	; 037FDD46
	beq loc_037FDD52	; 037FDD48
	bl loc_037FDCD4	; 037FDD4A
	add r7,r0,#0x0	; 037FDD4E
	b loc_037FDD58	; 037FDD50
loc_037FDD52:
	bl loc_037FDCE0	; 037FDD52
	add r7,r0,#0x0	; 037FDD56
loc_037FDD58:
	mov r0,#0x0	; 037FDD58
	strh r0,[r5,#0x4]	; 037FDD5A
	cmp r4,#0x0	; 037FDD5C
	beq loc_037FDD64	; 037FDD5E
	bl loc_03805094	; 037FDD60
loc_037FDD64:
	mov r0,#0x0	; 037FDD64
	str r0,[r5,#0x0]	; 037FDD66
	cmp r6,#0x0	; 037FDD68
	beq loc_037FDD74	; 037FDD6A
	add r0,r7,#0x0	; 037FDD6C
	bl loc_037FDCF8	; 037FDD6E
	b loc_037FDD7A	; 037FDD72
loc_037FDD74:
	add r0,r7,#0x0	; 037FDD74
	bl loc_037FDD04	; 037FDD76
loc_037FDD7A:
	mov r0,#0x0	; 037FDD7A
loc_037FDD7C:
	add sp,#0x4	; 037FDD7C
	pop {r4,r5,r6,r7}	; 037FDD7E
	pop {r3}	; 037FDD80
	bx r3	; 037FDD82

; ===== function loc_037FDD84 =====
loc_037FDD84:
	push {lr}	; 037FDD84
	sub sp,#0x4	; 037FDD86
	mov r3,#0x0	; 037FDD88
	bl loc_037FDD94	; 037FDD8A
	add sp,#0x4	; 037FDD8E
	pop {r3}	; 037FDD90
	bx r3	; 037FDD92

; ===== function loc_037FDD94 =====
loc_037FDD94:
	push {r4,r5,r6,r7,lr}	; 037FDD94
	sub sp,#0x4	; 037FDD96
	add r5,r0,#0x0	; 037FDD98
	add r4,r1,#0x0	; 037FDD9A
	add r6,r2,#0x0	; 037FDD9C
	add r7,r3,#0x0	; 037FDD9E
	b loc_037FDDA6	; 037FDDA0
loc_037FDDA2:
	bl loc_037FDC40	; 037FDDA2
loc_037FDDA6:
	add r0,r5,#0x0	; 037FDDA6
	add r1,r4,#0x0	; 037FDDA8
	add r2,r6,#0x0	; 037FDDAA
	add r3,r7,#0x0	; 037FDDAC
	bl loc_037FDC80	; 037FDDAE
	cmp r0,#0x0	; 037FDDB2
	bgt loc_037FDDA2	; 037FDDB4
	add sp,#0x4	; 037FDDB6
	pop {r4,r5,r6,r7}	; 037FDDB8
	pop {r3}	; 037FDDBA
	bx r3	; 037FDDBC
	.byte 0x00, 0x00	; 037FDDC0

; ===== function loc_037FDDC0 =====
loc_037FDDC0:
	push {r4,lr}	; 037FDDC0
	ldr r0,[pool_037FDDF8]	; 037FDDC2
	ldr r1,[r0,#0x0]	; 037FDDC4
	cmp r1,#0x0	; 037FDDC6
	bne loc_037FDDF2	; 037FDDC8
	mov r1,#0x1	; 037FDDCA
	str r1,[r0,#0x0]	; 037FDDCC
	mov r0,#0x0	; 037FDDCE
	ldr r4,[pool_037FDDFC]	; 037FDDD0
	strh r0,[r4,#0x6]	; 037FDDD2
	b loc_037FDDDA	; 037FDDD4
loc_037FDDD6:
	bl loc_037FDC40	; 037FDDD6
loc_037FDDDA:
	ldrh r0,[r4,#0x4]	; 037FDDDA
	cmp r0,#0x7f	; 037FDDDC
	bne loc_037FDDD6	; 037FDDDE
	mov r0,#0x0	; 037FDDE0
	mvn r1,r0	; 037FDDE2
	ldr r0,[pool_037FDE00]	; 037FDDE4
	str r1,[r0,#0x0]	; 037FDDE6
	ldr r1,[pool_037FDE04]	; 037FDDE8
	ldr r0,[pool_037FDE08]	; 037FDDEA
	str r1,[r0,#0x0]	; 037FDDEC
	mov r0,#0xbf	; 037FDDEE
	strh r0,[r4,#0x6]	; 037FDDF0
loc_037FDDF2:
	pop {r4}	; 037FDDF2
	pop {r3}	; 037FDDF4
	bx r3	; 037FDDF6
pool_037FDDF8:
loc_037FDDF8:
	.word 0x038058D4	; 037FDDF8
pool_037FDDFC:
loc_037FDDFC:
	.word 0x027FFFF0	; 037FDDFC
pool_037FDE00:
loc_037FDE00:
	.word 0x027FFFB8	; 037FDE00
pool_037FDE04:
loc_037FDE04:
	.word 0xFFFF0000	; 037FDE04
pool_037FDE08:
loc_037FDE08:
	.word 0x027FFFBC	; 037FDE08
	.byte 0x70, 0x47, 0x00, 0x00	; 037FDE10

; ===== function loc_037FDE10 =====
loc_037FDE10:
	push {r4,r5,lr}	; 037FDE10
	sub sp,#0x4	; 037FDE12
	add r5,r0,#0x0	; 037FDE14
	bl loc_037FDCE0	; 037FDE16
	ldr r1,[pool_037FDE30]	; 037FDE1A
	ldr r4,[r1,#0x10]	; 037FDE1C
	str r5,[r1,#0x10]	; 037FDE1E
	bl loc_037FDD04	; 037FDE20
	add r0,r4,#0x0	; 037FDE24
	add sp,#0x4	; 037FDE26
	pop {r4,r5}	; 037FDE28
	pop {r3}	; 037FDE2A
	bx r3	; 037FDE2C
	.byte 0xC0, 0x46	; 037FDE30
pool_037FDE30:
loc_037FDE30:
	.word 0x038058E4	; 037FDE30

; ===== function loc_037FDE34 =====
loc_037FDE34:
	push {r4,r5,r6,lr}	; 037FDE34
	ldr r6,[pool_037FDE98]	; 037FDE36
	ldrh r0,[r6,#0x4]	; 037FDE38
	cmp r0,#0x0	; 037FDE3A
	bne loc_037FDE46	; 037FDE3C
	bl loc_037FDEA4	; 037FDE3E
	cmp r0,#0x12	; 037FDE42
	bne loc_037FDE4C	; 037FDE44
loc_037FDE46:
	mov r0,#0x1	; 037FDE46
	strh r0,[r6,#0x0]	; 037FDE48
	b loc_037FDE92	; 037FDE4A
loc_037FDE4C:
	ldr r0,[pool_037FDE9C]	; 037FDE4C
	ldr r0,[r0,#0x0]	; 037FDE4E
	ldr r5,[r0,#0x0]	; 037FDE50
	bl loc_037FDEC8	; 037FDE52
	add r4,r0,#0x0	; 037FDE56
	cmp r5,r4	; 037FDE58
	beq loc_037FDE92	; 037FDE5A
	cmp r4,#0x0	; 037FDE5C
	beq loc_037FDE92	; 037FDE5E
	add r0,r5,#0x0	; 037FDE60
	bl loc_037FDEB0	; 037FDE62
	cmp r0,#0x0	; 037FDE66
	bne loc_037FDE92	; 037FDE68
	ldr r0,[pool_037FDEA0]	; 037FDE6A
	ldr r2,[r0,#0x0]	; 037FDE6C
	cmp r2,#0x0	; 037FDE6E
	beq loc_037FDE7A	; 037FDE70
	add r0,r5,#0x0	; 037FDE72
	add r1,r4,#0x0	; 037FDE74
	bl loc_0380508C	; 037FDE76
loc_037FDE7A:
	ldr r2,[r6,#0x10]	; 037FDE7A
	cmp r2,#0x0	; 037FDE7C
	beq loc_037FDE88	; 037FDE7E
	add r0,r5,#0x0	; 037FDE80
	add r1,r4,#0x0	; 037FDE82
	bl loc_0380508C	; 037FDE84
loc_037FDE88:
	ldr r0,[pool_037FDE98]	; 037FDE88
	str r4,[r0,#0x8]	; 037FDE8A
	add r0,r4,#0x0	; 037FDE8C
	bl loc_037FDEBC	; 037FDE8E
loc_037FDE92:
	pop {r4,r5,r6}	; 037FDE92
	pop {r3}	; 037FDE94
	bx r3	; 037FDE96
pool_037FDE98:
loc_037FDE98:
	.word 0x038058E4	; 037FDE98
pool_037FDE9C:
loc_037FDE9C:
	.word 0x038058DC	; 037FDE9C
pool_037FDEA0:
loc_037FDEA0:
	.word 0x038058D8	; 037FDEA0

; ===== function loc_037FDEA4 =====
loc_037FDEA4:
	bx pc	; 037FDEA4
	.byte 0xC0, 0x46	; 037FDEA8
.arm

; ===== function loc_037FDEA8 =====
loc_037FDEA8:
	ldr pc,[pool_037FDEAC]	; 037FDEA8
pool_037FDEAC:
loc_037FDEAC:
	.word 0x037FF15C	; 037FDEAC
.thumb

; ===== function loc_037FDEB0 =====
loc_037FDEB0:
	bx pc	; 037FDEB0
	.byte 0xC0, 0x46	; 037FDEB4
.arm

; ===== function loc_037FDEB4 =====
loc_037FDEB4:
	ldr pc,[pool_037FDEB8]	; 037FDEB4
pool_037FDEB8:
loc_037FDEB8:
	.word 0x037FE228	; 037FDEB8
.thumb

; ===== function loc_037FDEBC =====
loc_037FDEBC:
	bx pc	; 037FDEBC
	.byte 0xC0, 0x46	; 037FDEC0
.arm

; ===== function loc_037FDEC0 =====
loc_037FDEC0:
	ldr pc,[pool_037FDEC4]	; 037FDEC0
pool_037FDEC4:
loc_037FDEC4:
	.word 0x037FE25C	; 037FDEC4
.thumb

; ===== function loc_037FDEC8 =====
loc_037FDEC8:
	ldr r0,[pool_037FDEDC]	; 037FDEC8
	ldr r0,[r0,#0xc]	; 037FDECA
	b loc_037FDED0	; 037FDECC
loc_037FDECE:
	ldr r0,[r0,#0x4c]	; 037FDECE
loc_037FDED0:
	cmp r0,#0x0	; 037FDED0
	beq loc_037FDEDA	; 037FDED2
	ldr r1,[r0,#0x48]	; 037FDED4
	cmp r1,#0x1	; 037FDED6
	bne loc_037FDECE	; 037FDED8
loc_037FDEDA:
	bx lr	; 037FDEDA
pool_037FDEDC:
loc_037FDEDC:
	.word 0x038058E4	; 037FDEDC

; ===== function loc_037FDEE0 =====
loc_037FDEE0:
	push {r4,r5,lr}	; 037FDEE0
	sub sp,#0x4	; 037FDEE2
	add r5,r0,#0x0	; 037FDEE4
	bl loc_037FDCE0	; 037FDEE6
	add r4,r0,#0x0	; 037FDEEA
	mov r0,#0x1	; 037FDEEC
	str r0,[r5,#0x48]	; 037FDEEE
	bl loc_037FDE34	; 037FDEF0
	add r0,r4,#0x0	; 037FDEF4
	bl loc_037FDD04	; 037FDEF6
	add sp,#0x4	; 037FDEFA
	pop {r4,r5}	; 037FDEFC
	pop {r3}	; 037FDEFE
	bx r3	; 037FDF00
	.byte 0x00, 0x00	; 037FDF04

; ===== function loc_037FDF04 =====
loc_037FDF04:
	push {r4,r5,r6,lr}	; 037FDF04
	add r5,r0,#0x0	; 037FDF06
	bl loc_037FDCE0	; 037FDF08
	add r4,r0,#0x0	; 037FDF0C
	ldrh r1,[r5,#0x0]	; 037FDF0E
	cmp r1,#0x0	; 037FDF10
	beq loc_037FDF3A	; 037FDF12
	ldr r0,[pool_037FDF48]	; 037FDF14
	ldr r0,[r0,#0xc]	; 037FDF16
	mov r3,#0x1	; 037FDF18
	b loc_037FDF2E	; 037FDF1A
loc_037FDF1C:
	ldr r2,[r0,#0x50]	; 037FDF1C
	add r6,r3,#0x0	; 037FDF1E
	lsl r6,r2	; 037FDF20
	add r2,r1,#0x0	; 037FDF22
	and r2,r6	; 037FDF24
	cmp r2,#0x0	; 037FDF26
	beq loc_037FDF2C	; 037FDF28
	str r3,[r0,#0x48]	; 037FDF2A
loc_037FDF2C:
	ldr r0,[r0,#0x4c]	; 037FDF2C
loc_037FDF2E:
	cmp r0,#0x0	; 037FDF2E
	bne loc_037FDF1C	; 037FDF30
	mov r0,#0x0	; 037FDF32
	strh r0,[r5,#0x0]	; 037FDF34
	bl loc_037FDE34	; 037FDF36
loc_037FDF3A:
	add r0,r4,#0x0	; 037FDF3A
	bl loc_037FDD04	; 037FDF3C
	pop {r4,r5,r6}	; 037FDF40
	pop {r3}	; 037FDF42
	bx r3	; 037FDF44
	.byte 0xC0, 0x46	; 037FDF48
pool_037FDF48:
loc_037FDF48:
	.word 0x038058E4	; 037FDF48

; ===== function loc_037FDF4C =====
loc_037FDF4C:
	push {r4,r5,lr}	; 037FDF4C
	sub sp,#0x4	; 037FDF4E
	add r5,r0,#0x0	; 037FDF50
	bl loc_037FDCE0	; 037FDF52
	add r4,r0,#0x0	; 037FDF56
	ldr r0,[pool_037FDF88]	; 037FDF58
	ldr r0,[r0,#0x0]	; 037FDF5A
	ldr r1,[r0,#0x0]	; 037FDF5C
	cmp r5,#0x0	; 037FDF5E
	beq loc_037FDF72	; 037FDF60
	ldrh r0,[r5,#0x0]	; 037FDF62
	mov r3,#0x1	; 037FDF64
	ldr r2,[r1,#0x50]	; 037FDF66
	lsl r3,r2	; 037FDF68
	lsl r2,r3,#0x10	; 037FDF6A
	lsr r2,r2,#0x10	; 037FDF6C
	orr r0,r2	; 037FDF6E
	strh r0,[r5,#0x0]	; 037FDF70
loc_037FDF72:
	mov r0,#0x0	; 037FDF72
	str r0,[r1,#0x48]	; 037FDF74
	bl loc_037FDE34	; 037FDF76
	add r0,r4,#0x0	; 037FDF7A
	bl loc_037FDD04	; 037FDF7C
	add sp,#0x4	; 037FDF80
	pop {r4,r5}	; 037FDF82
	pop {r3}	; 037FDF84
	bx r3	; 037FDF86
pool_037FDF88:
loc_037FDF88:
	.word 0x038058DC	; 037FDF88
	push {r4,lr}	; 037FDF8C
	bl loc_037FDCE0	; 037FDF8E
	ldr r0,[pool_037FDFC4]	; 037FDF92
	ldr r0,[r0,#0x0]	; 037FDF94
	ldr r4,[r0,#0x0]	; 037FDF96
	add r0,r4,#0x0	; 037FDF98
	bl loc_037FE3B8	; 037FDF9A
	add r0,r4,#0x0	; 037FDF9E
	bl loc_037FE13C	; 037FDFA0
	mov r2,#0x0	; 037FDFA4
	ldr r0,[r4,#0x50]	; 037FDFA6
	lsl r1,r0,#0x2	; 037FDFA8
	ldr r0,[pool_037FDFC8]	; 037FDFAA
	str r2,[r0,r1]	; 037FDFAC
	mov r0,#0x2	; 037FDFAE
	str r0,[r4,#0x48]	; 037FDFB0
	add r4,#0x74	; 037FDFB2
	add r0,r4,#0x0	; 037FDFB4
	bl loc_037FDF04	; 037FDFB6
	bl loc_037FDE34	; 037FDFBA
	pop {r4}	; 037FDFBE
	pop {r3}	; 037FDFC0
	bx r3	; 037FDFC2
pool_037FDFC4:
loc_037FDFC4:
	.word 0x038058DC	; 037FDFC4
pool_037FDFC8:
loc_037FDFC8:
	.word 0x038058F8	; 037FDFC8

; ===== function loc_037FDFCC =====
loc_037FDFCC:
	push {r4,r5,r6,r7,lr}	; 037FDFCC
	sub sp,#0xc	; 037FDFCE
	add r5,r0,#0x0	; 037FDFD0
	str r1,[sp,#0x0]	; 037FDFD2
	add r7,r2,#0x0	; 037FDFD4
	add r4,r3,#0x0	; 037FDFD6
	bl loc_037FDCE0	; 037FDFD8
	str r0,[sp,#0x4]	; 037FDFDC
	bl loc_037FE1A4	; 037FDFDE
	cmp r0,#0x0	; 037FDFE2
	bge loc_037FDFEE	; 037FDFE4
	ldr r0,[sp,#0x4]	; 037FDFE6
	bl loc_037FDD04	; 037FDFE8
	b loc_037FE04C	; 037FDFEC
loc_037FDFEE:
	ldr r1,[sp,#0x24]	; 037FDFEE
	str r1,[r5,#0x54]	; 037FDFF0
	str r0,[r5,#0x50]	; 037FDFF2
	mov r1,#0x0	; 037FDFF4
	str r1,[r5,#0x48]	; 037FDFF6
	lsl r1,r0,#0x2	; 037FDFF8
	ldr r0,[pool_037FE054]	; 037FDFFA
	str r5,[r0,r1]	; 037FDFFC
	add r0,r5,#0x0	; 037FDFFE
	bl loc_037FE168	; 037FE000
	str r4,[r5,#0x6c]	; 037FE004
	ldr r0,[sp,#0x20]	; 037FE006
	sub r6,r4,r0	; 037FE008
	str r6,[r5,#0x68]	; 037FE00A
	mov r0,#0x0	; 037FE00C
	str r0,[r5,#0x70]	; 037FE00E
	ldr r1,[pool_037FE058]	; 037FE010
	ldr r0,[r5,#0x6c]	; 037FE012
	sub r0,r0,#0x4	; 037FE014
	str r1,[r0,#0x0]	; 037FE016
	ldr r1,[pool_037FE05C]	; 037FE018
	ldr r0,[r5,#0x68]	; 037FE01A
	str r1,[r0,#0x0]	; 037FE01C
	add r0,r5,#0x0	; 037FE01E
	ldr r1,[sp,#0x0]	; 037FE020
	sub r2,r4,#0x4	; 037FE022
	bl loc_037FE064	; 037FE024
	str r7,[r5,#0x4]	; 037FE028
	ldr r0,[pool_037FE060]	; 037FE02A
	str r0,[r5,#0x3c]	; 037FE02C
	mov r0,#0x0	; 037FE02E
	str r0,[sp,#0x8]	; 037FE030
	ldr r0,[sp,#0x8]	; 037FE032
	add r1,r6,#0x4	; 037FE034
	ldr r2,[sp,#0x20]	; 037FE036
	sub r2,#0x8	; 037FE038
	bl loc_037FE070	; 037FE03A
	mov r0,#0x0	; 037FE03E
	str r0,[r5,#0x5c]	; 037FE040
	str r0,[r5,#0x60]	; 037FE042
	str r0,[r5,#0x64]	; 037FE044
	ldr r0,[sp,#0x4]	; 037FE046
	bl loc_037FDD04	; 037FE048
loc_037FE04C:
	add sp,#0xc	; 037FE04C
	pop {r4,r5,r6,r7}	; 037FE04E
	pop {r3}	; 037FE050
	bx r3	; 037FE052
pool_037FE054:
loc_037FE054:
	.word 0x038058F8	; 037FE054
pool_037FE058:
loc_037FE058:
	.word 0xD73BFDF7	; 037FE058
pool_037FE05C:
loc_037FE05C:
	.word 0xFBDD37BB	; 037FE05C
pool_037FE060:
loc_037FE060:
	.word 0x037FDF8D	; 037FE060

; ===== function loc_037FE064 =====
loc_037FE064:
	bx pc	; 037FE064
	.byte 0xC0, 0x46	; 037FE068
.arm

; ===== function loc_037FE068 =====
loc_037FE068:
	ldr pc,[pool_037FE06C]	; 037FE068
pool_037FE06C:
loc_037FE06C:
	.word 0x037FE1C4	; 037FE06C
.thumb

; ===== function loc_037FE070 =====
loc_037FE070:
	bx pc	; 037FE070
	.byte 0xC0, 0x46	; 037FE074
.arm

; ===== function loc_037FE074 =====
loc_037FE074:
	ldr pc,[pool_037FE078]	; 037FE074
pool_037FE078:
loc_037FE078:
	.word 0x037FF350	; 037FE078
.thumb

; ===== function loc_037FE07C =====
loc_037FE07C:
	push {lr}	; 037FE07C
	sub sp,#0x4	; 037FE07E
	ldr r0,[pool_037FE108]	; 037FE080
	ldr r1,[r0,#0x0]	; 037FE082
	cmp r1,#0x0	; 037FE084
	bne loc_037FE100	; 037FE086
	mov r1,#0x1	; 037FE088
	str r1,[r0,#0x0]	; 037FE08A
	mov r3,#0x0	; 037FE08C
	add r1,r3,#0x0	; 037FE08E
	ldr r0,[pool_037FE10C]	; 037FE090
loc_037FE092:
	lsl r2,r3,#0x2	; 037FE092
	add r2,r0,r2	; 037FE094
	str r1,[r2,#0x14]	; 037FE096
	add r3,r3,#0x1	; 037FE098
	cmp r3,#0x10	; 037FE09A
	blt loc_037FE092	; 037FE09C
	ldr r3,[pool_037FE110]	; 037FE09E
	ldr r2,[pool_037FE114]	; 037FE0A0
	str r3,[r2,#0x0]	; 037FE0A2
	mov r3,#0x10	; 037FE0A4
	ldr r2,[pool_037FE118]	; 037FE0A6
	str r3,[r2,#0x54]	; 037FE0A8
	str r1,[r2,#0x50]	; 037FE0AA
	mov r3,#0x1	; 037FE0AC
	str r3,[r2,#0x48]	; 037FE0AE
	str r1,[r2,#0x4c]	; 037FE0B0
	str r1,[r2,#0x58]	; 037FE0B2
	str r2,[r0,#0x14]	; 037FE0B4
	str r2,[r0,#0xc]	; 037FE0B6
	str r2,[r0,#0x8]	; 037FE0B8
	ldr r2,[pool_037FE11C]	; 037FE0BA
	cmp r2,#0x0	; 037FE0BC
	bne loc_037FE0C6	; 037FE0BE
	ldr r0,[pool_037FE120]	; 037FE0C0
	sub r3,r0,r2	; 037FE0C2
	b loc_037FE0CE	; 037FE0C4
loc_037FE0C6:
	ldr r1,[pool_037FE124]	; 037FE0C6
	ldr r0,[pool_037FE128]	; 037FE0C8
	sub r0,r0,r1	; 037FE0CA
	sub r3,r0,r2	; 037FE0CC
loc_037FE0CE:
	ldr r1,[pool_037FE124]	; 037FE0CE
	ldr r0,[pool_037FE128]	; 037FE0D0
	sub r1,r0,r1	; 037FE0D2
	ldr r2,[pool_037FE118]	; 037FE0D4
	str r1,[r2,#0x6c]	; 037FE0D6
	str r3,[r2,#0x68]	; 037FE0D8
	mov r0,#0x0	; 037FE0DA
	str r0,[r2,#0x70]	; 037FE0DC
	ldr r3,[pool_037FE12C]	; 037FE0DE
	sub r1,r1,#0x4	; 037FE0E0
	str r3,[r1,#0x0]	; 037FE0E2
	ldr r3,[pool_037FE130]	; 037FE0E4
	ldr r1,[r2,#0x68]	; 037FE0E6
	str r3,[r1,#0x0]	; 037FE0E8
	ldr r1,[pool_037FE134]	; 037FE0EA
	strh r0,[r1,#0x34]	; 037FE0EC
	mov r2,#0x10	; 037FE0EE
	ldr r1,[pool_037FE10C]	; 037FE0F0
	strh r2,[r1,#0x2]	; 037FE0F2
	strh r0,[r1,#0x0]	; 037FE0F4
	strh r0,[r1,#0x4]	; 037FE0F6
	ldr r2,[pool_037FE138]	; 037FE0F8
	str r1,[r2,#0x0]	; 037FE0FA
	bl loc_037FDE10	; 037FE0FC
loc_037FE100:
	add sp,#0x4	; 037FE100
	pop {r3}	; 037FE102
	bx r3	; 037FE104
	.byte 0xC0, 0x46	; 037FE108
pool_037FE108:
loc_037FE108:
	.word 0x038058E0	; 037FE108
pool_037FE10C:
loc_037FE10C:
	.word 0x038058E4	; 037FE10C
pool_037FE110:
loc_037FE110:
	.word 0x038058EC	; 037FE110
pool_037FE114:
loc_037FE114:
	.word 0x038058DC	; 037FE114
pool_037FE118:
loc_037FE118:
	.word 0x03805938	; 037FE118
pool_037FE11C:
loc_037FE11C:
	.word 0x00000400	; 037FE11C
pool_037FE120:
loc_037FE120:
	.word 0x037F8000	; 037FE120
pool_037FE124:
loc_037FE124:
	.word 0x00000200	; 037FE124
pool_037FE128:
loc_037FE128:
	.word 0x0380FF80	; 037FE128
pool_037FE12C:
loc_037FE12C:
	.word 0xD73BFDF7	; 037FE12C
pool_037FE130:
loc_037FE130:
	.word 0xFBDD37BB	; 037FE130
pool_037FE134:
loc_037FE134:
	.word 0x03805978	; 037FE134
pool_037FE138:
loc_037FE138:
	.word 0x027FFFA4	; 037FE138

; ===== function loc_037FE13C =====
loc_037FE13C:
	ldr r1,[pool_037FE164]	; 037FE13C
	ldr r2,[r1,#0xc]	; 037FE13E
	mov r1,#0x0	; 037FE140
	b loc_037FE148	; 037FE142
loc_037FE144:
	add r1,r2,#0x0	; 037FE144
	ldr r2,[r2,#0x4c]	; 037FE146
loc_037FE148:
	cmp r2,#0x0	; 037FE148
	beq loc_037FE150	; 037FE14A
	cmp r2,r0	; 037FE14C
	bne loc_037FE144	; 037FE14E
loc_037FE150:
	cmp r1,#0x0	; 037FE150
	bne loc_037FE15C	; 037FE152
	ldr r1,[r0,#0x4c]	; 037FE154
	ldr r0,[pool_037FE164]	; 037FE156
	str r1,[r0,#0xc]	; 037FE158
	bx lr	; 037FE15A
loc_037FE15C:
	ldr r0,[r0,#0x4c]	; 037FE15C
	str r0,[r1,#0x4c]	; 037FE15E
	bx lr	; 037FE160
	.byte 0xC0, 0x46	; 037FE164
pool_037FE164:
loc_037FE164:
	.word 0x038058E4	; 037FE164

; ===== function loc_037FE168 =====
loc_037FE168:
	push {r4,r5,lr}	; 037FE168
	sub sp,#0x4	; 037FE16A
	ldr r1,[pool_037FE1A0]	; 037FE16C
	ldr r3,[r1,#0xc]	; 037FE16E
	add r5,r3,#0x0	; 037FE170
	mov r4,#0x0	; 037FE172
	b loc_037FE17A	; 037FE174
loc_037FE176:
	add r4,r5,#0x0	; 037FE176
	ldr r5,[r5,#0x4c]	; 037FE178
loc_037FE17A:
	cmp r5,#0x0	; 037FE17A
	beq loc_037FE186	; 037FE17C
	ldr r2,[r5,#0x54]	; 037FE17E
	ldr r1,[r0,#0x54]	; 037FE180
	cmp r2,r1	; 037FE182
	bcc loc_037FE176	; 037FE184
loc_037FE186:
	cmp r4,#0x0	; 037FE186
	bne loc_037FE192	; 037FE188
	str r3,[r0,#0x4c]	; 037FE18A
	ldr r1,[pool_037FE1A0]	; 037FE18C
	str r0,[r1,#0xc]	; 037FE18E
	b loc_037FE198	; 037FE190
loc_037FE192:
	ldr r1,[r4,#0x4c]	; 037FE192
	str r1,[r0,#0x4c]	; 037FE194
	str r0,[r4,#0x4c]	; 037FE196
loc_037FE198:
	add sp,#0x4	; 037FE198
	pop {r4,r5}	; 037FE19A
	pop {r3}	; 037FE19C
	bx r3	; 037FE19E
pool_037FE1A0:
loc_037FE1A0:
	.word 0x038058E4	; 037FE1A0

; ===== function loc_037FE1A4 =====
loc_037FE1A4:
	mov r0,#0x0	; 037FE1A4
	ldr r2,[pool_037FE1C0]	; 037FE1A6
	b loc_037FE1B6	; 037FE1A8
loc_037FE1AA:
	lsl r1,r0,#0x2	; 037FE1AA
	add r1,r2,r1	; 037FE1AC
	ldr r1,[r1,#0x14]	; 037FE1AE
	cmp r1,#0x0	; 037FE1B0
	beq loc_037FE1BE	; 037FE1B2
	add r0,r0,#0x1	; 037FE1B4
loc_037FE1B6:
	cmp r0,#0x10	; 037FE1B6
	blt loc_037FE1AA	; 037FE1B8
	mov r0,#0x0	; 037FE1BA
	mvn r0,r0	; 037FE1BC
loc_037FE1BE:
	bx lr	; 037FE1BE
pool_037FE1C0:
loc_037FE1C0:
	.word 0x038058E4	; 037FE1C0
.arm

; ===== function loc_037FE1C4 =====
loc_037FE1C4:
	add r1,r1,#0x4	; 037FE1C4
	str r1,[r0,#0x40]	; 037FE1C8
	str r2,[r0,#0x44]	; 037FE1CC
	sub r2,r2,#0x40	; 037FE1D0
	str r2,[r0,#0x38]	; 037FE1D4
	ands r1,r1,#0x1	; 037FE1D8
	movne r1,#0x3f	; 037FE1DC
	moveq r1,#0x1f	; 037FE1E0
	str r1,[r0,#0x0]	; 037FE1E4
	mov r1,#0x0	; 037FE1E8
	str r1,[r0,#0x4]	; 037FE1EC
	str r1,[r0,#0x8]	; 037FE1F0
	str r1,[r0,#0xc]	; 037FE1F4
	str r1,[r0,#0x10]	; 037FE1F8
	str r1,[r0,#0x14]	; 037FE1FC
	str r1,[r0,#0x18]	; 037FE200
	str r1,[r0,#0x1c]	; 037FE204
	str r1,[r0,#0x20]	; 037FE208
	str r1,[r0,#0x24]	; 037FE20C
	str r1,[r0,#0x28]	; 037FE210
	str r1,[r0,#0x2c]	; 037FE214
	str r1,[r0,#0x30]	; 037FE218
	str r1,[r0,#0x34]	; 037FE21C
	str r1,[r0,#0x3c]	; 037FE220
	bx lr	; 037FE224

; ===== function loc_037FE228 =====
loc_037FE228:
	add r1,r0,#0x0	; 037FE228
	mrs r2,cpsr	; 037FE22C
	str r2,[r1],#0x4	; 037FE230
	mov r0,#0xd3	; 037FE234
	msr cpsr_c,r0	; 037FE238
	str sp,[r1,#0x40]	; 037FE23C
	msr cpsr_c,r2	; 037FE240
	mov r0,#0x1	; 037FE244
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 037FE248
	adr r0,loc_037FE25C	; 037FE24C
	str r0,[r1,#0x3c]	; 037FE250
	mov r0,#0x0	; 037FE254
	bx lr	; 037FE258

; ===== function loc_037FE25C =====
loc_037FE25C:
	mrs r1,cpsr	; 037FE25C
	bic r1,r1,#0x1f	; 037FE260
	orr r1,r1,#0xd3	; 037FE264
	msr cpsr_c,r1	; 037FE268
	ldr r1,[r0],#0x4	; 037FE26C
	msr spsr_cxsf,r1	; 037FE270
	ldr sp,[r0,#0x40]	; 037FE274
	ldr lr,[r0,#0x3c]	; 037FE278
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 037FE27C
	mov r0,r0	; 037FE280
	subs pc,lr,#0x4	; 037FE284
.thumb

; ===== function loc_037FE288 =====
loc_037FE288:
	push {r4,r5,r6,r7,lr}	; 037FE288
	sub sp,#0x4	; 037FE28A
	add r5,r0,#0x0	; 037FE28C
	add r6,r1,#0x0	; 037FE28E
	add r4,r2,#0x0	; 037FE290
	bl loc_037FDCE0	; 037FE292
	add r7,r0,#0x0	; 037FE296
	mov r0,#0x1	; 037FE298
	and r4,r0	; 037FE29A
	add r0,r5,#0x2	; 037FE29C
	str r0,[sp,#0x0]	; 037FE29E
	b loc_037FE2B6	; 037FE2A0
loc_037FE2A2:
	cmp r4,#0x0	; 037FE2A2
	bne loc_037FE2B0	; 037FE2A4
	add r0,r7,#0x0	; 037FE2A6
	bl loc_037FDD04	; 037FE2A8
	mov r0,#0x0	; 037FE2AC
	b loc_037FE2EA	; 037FE2AE
loc_037FE2B0:
	ldr r0,[sp,#0x0]	; 037FE2B0
	bl loc_037FDF4C	; 037FE2B2
loc_037FE2B6:
	ldr r0,[r5,#0x10]	; 037FE2B6
	cmp r0,#0x0	; 037FE2B8
	beq loc_037FE2A2	; 037FE2BA
	cmp r6,#0x0	; 037FE2BC
	beq loc_037FE2CA	; 037FE2BE
	ldr r1,[r5,#0x4]	; 037FE2C0
	ldr r0,[r5,#0xc]	; 037FE2C2
	lsl r0,r0,#0x2	; 037FE2C4
	ldr r0,[r1,r0]	; 037FE2C6
	str r0,[r6,#0x0]	; 037FE2C8
loc_037FE2CA:
	ldr r0,[r5,#0xc]	; 037FE2CA
	add r0,r0,#0x1	; 037FE2CC
	ldr r1,[r5,#0x8]	; 037FE2CE
	bl loc_037FE2F4	; 037FE2D0
	str r1,[r5,#0xc]	; 037FE2D4
	ldr r0,[r5,#0x10]	; 037FE2D6
	sub r0,r0,#0x1	; 037FE2D8
	str r0,[r5,#0x10]	; 037FE2DA
	add r0,r5,#0x0	; 037FE2DC
	bl loc_037FDF04	; 037FE2DE
	add r0,r7,#0x0	; 037FE2E2
	bl loc_037FDD04	; 037FE2E4
	mov r0,#0x1	; 037FE2E8
loc_037FE2EA:
	add sp,#0x4	; 037FE2EA
	pop {r4,r5,r6,r7}	; 037FE2EC
	pop {r3}	; 037FE2EE
	bx r3	; 037FE2F0
	.byte 0xC0, 0x46	; 037FE2F4

; ===== function loc_037FE2F4 =====
loc_037FE2F4:
	bx pc	; 037FE2F4
	.byte 0xC0, 0x46	; 037FE2F8
.arm

; ===== function loc_037FE2F8 =====
loc_037FE2F8:
	ldr pc,[pool_037FE2FC]	; 037FE2F8
pool_037FE2FC:
loc_037FE2FC:
	.word 0x03804BA4	; 037FE2FC
.thumb

; ===== function loc_037FE300 =====
loc_037FE300:
	push {r4,r5,r6,r7,lr}	; 037FE300
	sub sp,#0x4	; 037FE302
	add r5,r0,#0x0	; 037FE304
	add r6,r1,#0x0	; 037FE306
	add r4,r2,#0x0	; 037FE308
	bl loc_037FDCE0	; 037FE30A
	add r7,r0,#0x0	; 037FE30E
	mov r0,#0x1	; 037FE310
	and r4,r0	; 037FE312
	b loc_037FE32A	; 037FE314
loc_037FE316:
	cmp r4,#0x0	; 037FE316
	bne loc_037FE324	; 037FE318
	add r0,r7,#0x0	; 037FE31A
	bl loc_037FDD04	; 037FE31C
	mov r0,#0x0	; 037FE320
	b loc_037FE354	; 037FE322
loc_037FE324:
	add r0,r5,#0x0	; 037FE324
	bl loc_037FDF4C	; 037FE326
loc_037FE32A:
	ldr r2,[r5,#0x10]	; 037FE32A
	ldr r1,[r5,#0x8]	; 037FE32C
	cmp r1,r2	; 037FE32E
	ble loc_037FE316	; 037FE330
	ldr r0,[r5,#0xc]	; 037FE332
	add r0,r0,r2	; 037FE334
	bl loc_037FE2F4	; 037FE336
	ldr r2,[r5,#0x4]	; 037FE33A
	lsl r0,r1,#0x2	; 037FE33C
	str r6,[r2,r0]	; 037FE33E
	ldr r0,[r5,#0x10]	; 037FE340
	add r0,r0,#0x1	; 037FE342
	str r0,[r5,#0x10]	; 037FE344
	add r0,r5,#0x2	; 037FE346
	bl loc_037FDF04	; 037FE348
	add r0,r7,#0x0	; 037FE34C
	bl loc_037FDD04	; 037FE34E
	mov r0,#0x1	; 037FE352
loc_037FE354:
	add sp,#0x4	; 037FE354
	pop {r4,r5,r6,r7}	; 037FE356
	pop {r3}	; 037FE358
	bx r3	; 037FE35A

; ===== function loc_037FE35C =====
loc_037FE35C:
	mov r3,#0x0	; 037FE35C
	strh r3,[r0,#0x0]	; 037FE35E
	strh r3,[r0,#0x2]	; 037FE360
	str r1,[r0,#0x4]	; 037FE362
	str r2,[r0,#0x8]	; 037FE364
	str r3,[r0,#0xc]	; 037FE366
	str r3,[r0,#0x10]	; 037FE368
	bx lr	; 037FE36A

; ===== function loc_037FE36C =====
loc_037FE36C:
	ldr r3,[r0,#0x60]	; 037FE36C
	ldr r2,[r3,#0x10]	; 037FE36E
	cmp r2,#0x0	; 037FE370
	bne loc_037FE37A	; 037FE372
	mov r1,#0x0	; 037FE374
	str r1,[r0,#0x64]	; 037FE376
	b loc_037FE37E	; 037FE378
loc_037FE37A:
	mov r1,#0x0	; 037FE37A
	str r1,[r2,#0xc]	; 037FE37C
loc_037FE37E:
	str r2,[r0,#0x60]	; 037FE37E
	add r0,r3,#0x0	; 037FE380
	bx lr	; 037FE382
	.byte 0x0A, 0x69, 0xC9, 0x68, 0x00, 0x2A, 0x01, 0xD1, 0x41, 0x66, 0x00, 0xE0, 0xD1, 0x60, 0x00, 0x29	; 037FE394
	.byte 0x01, 0xD1, 0x02, 0x66, 0x70, 0x47, 0x0A, 0x61, 0x70, 0x47, 0x00, 0x00, 0x43, 0x6E, 0x00, 0x2B	; 037FE3A4
	.byte 0x01, 0xD1, 0x01, 0x66, 0x01, 0xE0, 0x02, 0x6E, 0x11, 0x61, 0xCB, 0x60, 0x00, 0x22, 0x0A, 0x61	; 037FE3B4
	.byte 0x41, 0x66, 0x70, 0x47	; 037FE3B8

; ===== function loc_037FE3B8 =====
loc_037FE3B8:
	push {r4,r5,lr}	; 037FE3B8
	sub sp,#0x4	; 037FE3BA
	add r5,r0,#0x0	; 037FE3BC
	mov r4,#0x0	; 037FE3BE
	b loc_037FE3D0	; 037FE3C0
loc_037FE3C2:
	add r0,r5,#0x0	; 037FE3C2
	bl loc_037FE36C	; 037FE3C4
	str r4,[r0,#0x8]	; 037FE3C8
	str r4,[r0,#0x4]	; 037FE3CA
	bl loc_037FDF04	; 037FE3CC
loc_037FE3D0:
	ldr r0,[r5,#0x60]	; 037FE3D0
	cmp r0,#0x0	; 037FE3D2
	bne loc_037FE3C2	; 037FE3D4
	add sp,#0x4	; 037FE3D6
	pop {r4,r5}	; 037FE3D8
	pop {r3}	; 037FE3DA
	bx r3	; 037FE3DC
	.byte 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFF, 0xF7, 0x7B, 0xFC, 0x04, 0x1C, 0x0C, 0x48	; 037FE3EE
	.byte 0x80, 0x68, 0x69, 0x68, 0x81, 0x42, 0x0D, 0xD1, 0xA9, 0x68, 0x49, 0x1E, 0xA9, 0x60, 0xA9, 0x68	; 037FE3FE
	.byte 0x00, 0x29, 0x07, 0xD1, 0x29, 0x1C, 0xFF, 0xF7, 0xBE, 0xFF, 0x00, 0x20, 0x68, 0x60, 0x28, 0x1C	; 037FE40E
	.byte 0xFF, 0xF7, 0x79, 0xFD, 0x20, 0x1C, 0xFF, 0xF7, 0x76, 0xFC, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 037FE41E
	.byte 0x18, 0x47, 0xE4, 0x58, 0x80, 0x03, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFF, 0xF7, 0x59, 0xFC	; 037FE42E
	.byte 0x06, 0x1C, 0x10, 0x48, 0x84, 0x68, 0x00, 0x27, 0x68, 0x68, 0x00, 0x28, 0x08, 0xD1, 0x6C, 0x60	; 037FE43E
	.byte 0xA8, 0x68, 0x40, 0x1C, 0xA8, 0x60, 0x20, 0x1C, 0x29, 0x1C, 0xFF, 0xF7, 0xAA, 0xFF, 0x0B, 0xE0	; 037FE44E
	.byte 0xA0, 0x42, 0x03, 0xD1, 0xA8, 0x68, 0x40, 0x1C, 0xA8, 0x60, 0x05, 0xE0, 0xE5, 0x65, 0x28, 0x1C	; 037FE45E
	.byte 0xFF, 0xF7, 0x75, 0xFD, 0xE7, 0x65, 0xE7, 0xE7, 0x30, 0x1C, 0xFF, 0xF7, 0x4C, 0xFC, 0x01, 0xB0	; 037FE46E
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xE4, 0x58, 0x80, 0x03, 0x00, 0x21, 0x01, 0x80, 0x41, 0x60	; 037FE47E
	.byte 0x81, 0x60, 0x70, 0x47, 0x00, 0x00	; 037FE484

; ===== function loc_037FE484 =====
loc_037FE484:
	push {lr}	; 037FE484
	sub sp,#0x4	; 037FE486
	bl loc_037FE568	; 037FE488
	bl loc_03801E50	; 037FE48C
	bl loc_037FDDC0	; 037FE490
	bl loc_037FDB8C	; 037FE494
	bl loc_037FE940	; 037FE498
	bl loc_037FEC48	; 037FE49C
	bl loc_037FE07C	; 037FE4A0
	bl loc_038048B0	; 037FE4A4
	add sp,#0x4	; 037FE4A8
	pop {r3}	; 037FE4AA
	bx r3	; 037FE4AC
	.byte 0x00, 0x00	; 037FE4B0

; ===== function loc_037FE4B0 =====
loc_037FE4B0:
	lsl r2,r0,#0x2	; 037FE4B0
	ldr r0,[pool_037FE4B8]	; 037FE4B2
	str r1,[r2,r0]	; 037FE4B4
	bx lr	; 037FE4B6
pool_037FE4B8:
loc_037FE4B8:
	.word 0x027FFDA0	; 037FE4B8

; ===== function loc_037FE4BC =====
loc_037FE4BC:
	lsl r2,r0,#0x2	; 037FE4BC
	ldr r0,[pool_037FE4C4]	; 037FE4BE
	str r1,[r2,r0]	; 037FE4C0
	bx lr	; 037FE4C2
pool_037FE4C4:
loc_037FE4C4:
	.word 0x027FFDC4	; 037FE4C4

; ===== function loc_037FE4C8 =====
loc_037FE4C8:
	cmp r0,#0x1	; 037FE4C8
	beq loc_037FE4D6	; 037FE4CA
	cmp r0,#0x7	; 037FE4CC
	beq loc_037FE4DA	; 037FE4CE
	cmp r0,#0x8	; 037FE4D0
	beq loc_037FE4E6	; 037FE4D2
	b loc_037FE4F2	; 037FE4D4
loc_037FE4D6:
	ldr r0,[pool_037FE4F8]	; 037FE4D6
	bx lr	; 037FE4D8
loc_037FE4DA:
	ldr r0,[pool_037FE4FC]	; 037FE4DA
	ldr r1,[pool_037FE500]	; 037FE4DC
	cmp r0,r1	; 037FE4DE
	bls loc_037FE4F4	; 037FE4E0
	add r0,r1,#0x0	; 037FE4E2
	bx lr	; 037FE4E4
loc_037FE4E6:
	ldr r0,[pool_037FE500]	; 037FE4E6
	ldr r1,[pool_037FE4FC]	; 037FE4E8
	cmp r1,r0	; 037FE4EA
	bls loc_037FE4F4	; 037FE4EC
	add r0,r1,#0x0	; 037FE4EE
	bx lr	; 037FE4F0
loc_037FE4F2:
	mov r0,#0x0	; 037FE4F2
loc_037FE4F4:
	bx lr	; 037FE4F4
	.byte 0xC0, 0x46	; 037FE4F8
pool_037FE4F8:
loc_037FE4F8:
	.word 0x027C0000	; 037FE4F8
pool_037FE4FC:
loc_037FE4FC:
	.word 0x037F8424	; 037FE4FC
pool_037FE500:
loc_037FE500:
	.word 0x03800000	; 037FE500

; ===== function loc_037FE504 =====
loc_037FE504:
	cmp r0,#0x1	; 037FE504
	beq loc_037FE512	; 037FE506
	cmp r0,#0x7	; 037FE508
	beq loc_037FE516	; 037FE50A
	cmp r0,#0x8	; 037FE50C
	beq loc_037FE51A	; 037FE50E
	b loc_037FE538	; 037FE510
loc_037FE512:
	ldr r0,[pool_037FE53C]	; 037FE512
	bx lr	; 037FE514
loc_037FE516:
	ldr r0,[pool_037FE540]	; 037FE516
	bx lr	; 037FE518
loc_037FE51A:
	ldr r1,[pool_037FE544]	; 037FE51A
	ldr r0,[pool_037FE548]	; 037FE51C
	sub r0,r0,r1	; 037FE51E
	ldr r1,[pool_037FE54C]	; 037FE520
	cmp r1,#0x0	; 037FE522
	bne loc_037FE52A	; 037FE524
	ldr r0,[pool_037FE540]	; 037FE526
	bx lr	; 037FE528
loc_037FE52A:
	cmp r1,#0x0	; 037FE52A
	bge loc_037FE534	; 037FE52C
	ldr r0,[pool_037FE540]	; 037FE52E
	sub r0,r0,r1	; 037FE530
	bx lr	; 037FE532
loc_037FE534:
	sub r0,r0,r1	; 037FE534
	bx lr	; 037FE536
loc_037FE538:
	mov r0,#0x0	; 037FE538
	bx lr	; 037FE53A
pool_037FE53C:
loc_037FE53C:
	.word 0x027FF000	; 037FE53C
pool_037FE540:
loc_037FE540:
	.word 0x03800000	; 037FE540
pool_037FE544:
loc_037FE544:
	.word 0x00000200	; 037FE544
pool_037FE548:
loc_037FE548:
	.word 0x0380FF80	; 037FE548
pool_037FE54C:
loc_037FE54C:
	.word 0x00000400	; 037FE54C
	.byte 0x81, 0x00, 0x01, 0x48, 0x08, 0x58, 0x70, 0x47, 0xA0, 0xFD, 0x7F, 0x02, 0x81, 0x00, 0x01, 0x48	; 037FE560
	.byte 0x08, 0x58, 0x70, 0x47, 0xC4, 0xFD, 0x7F, 0x02	; 037FE568

; ===== function loc_037FE568 =====
loc_037FE568:
	push {lr}	; 037FE568
	sub sp,#0x4	; 037FE56A
	ldr r1,[pool_037FE590]	; 037FE56C
	ldr r0,[r1,#0x0]	; 037FE56E
	cmp r0,#0x0	; 037FE570
	bne loc_037FE588	; 037FE572
	mov r0,#0x1	; 037FE574
	str r0,[r1,#0x0]	; 037FE576
	bl loc_037FE594	; 037FE578
	mov r0,#0x7	; 037FE57C
	bl loc_037FE594	; 037FE57E
	mov r0,#0x8	; 037FE582
	bl loc_037FE594	; 037FE584
loc_037FE588:
	add sp,#0x4	; 037FE588
	pop {r3}	; 037FE58A
	bx r3	; 037FE58C
	.byte 0xC0, 0x46	; 037FE590
pool_037FE590:
loc_037FE590:
	.word 0x038059B0	; 037FE590

; ===== function loc_037FE594 =====
loc_037FE594:
	push {r4,lr}	; 037FE594
	add r4,r0,#0x0	; 037FE596
	bl loc_037FE504	; 037FE598
	add r1,r0,#0x0	; 037FE59C
	add r0,r4,#0x0	; 037FE59E
	bl loc_037FE4BC	; 037FE5A0
	add r0,r4,#0x0	; 037FE5A4
	bl loc_037FE4C8	; 037FE5A6
	add r1,r0,#0x0	; 037FE5AA
	add r0,r4,#0x0	; 037FE5AC
	bl loc_037FE4B0	; 037FE5AE
	pop {r4}	; 037FE5B2
	pop {r3}	; 037FE5B4
	bx r3	; 037FE5B6

; ===== function loc_037FE5B8 =====
	push {r4,r5,r6,r7,lr}	; 037FE5B8
	sub sp,#0xc	; 037FE5BA
	add r4,r0,#0x0	; 037FE5BC
	add r5,r1,#0x0	; 037FE5BE
	add r6,r2,#0x0	; 037FE5C0
	bl loc_037FDCE0	; 037FE5C2
	str r0,[sp,#0x4]	; 037FE5C6
	lsl r1,r4,#0x2	; 037FE5C8
	ldr r0,[pool_037FE628]	; 037FE5CA
	ldr r1,[r0,r1]	; 037FE5CC
	add r5,#0x1f	; 037FE5CE
	mov r0,#0x1f	; 037FE5D0
	bic r5,r0	; 037FE5D2
	bic r6,r0	; 037FE5D4
	mov r4,#0x0	; 037FE5D6
	ldr r7,[r1,#0x4]	; 037FE5D8
	b loc_037FE610	; 037FE5DA
loc_037FE5DC:
	ldr r0,[r1,#0x10]	; 037FE5DC
	add r3,r4,#0x0	; 037FE5DE
	str r3,[sp,#0x0]	; 037FE5E0
	mov r2,#0xc	; 037FE5E2
	mul r3,r2	; 037FE5E4
	str r3,[sp,#0x0]	; 037FE5E6
	add r3,r0,r3	; 037FE5E8
	ldr r2,[sp,#0x0]	; 037FE5EA
	ldr r0,[r0,r2]	; 037FE5EC
	cmp r0,#0x0	; 037FE5EE
	bge loc_037FE60E	; 037FE5F0
	sub r0,r6,r5	; 037FE5F2
	str r0,[r3,#0x0]	; 037FE5F4
	mov r1,#0x0	; 037FE5F6
	str r1,[r5,#0x0]	; 037FE5F8
	str r1,[r5,#0x4]	; 037FE5FA
	ldr r0,[r3,#0x0]	; 037FE5FC
	str r0,[r5,#0x8]	; 037FE5FE
	str r5,[r3,#0x4]	; 037FE600
	str r1,[r3,#0x8]	; 037FE602
	ldr r0,[sp,#0x4]	; 037FE604
	bl loc_037FDD04	; 037FE606
	add r0,r4,#0x0	; 037FE60A
	b loc_037FE61E	; 037FE60C
loc_037FE60E:
	add r4,r4,#0x1	; 037FE60E
loc_037FE610:
	cmp r4,r7	; 037FE610
	blt loc_037FE5DC	; 037FE612
	ldr r0,[sp,#0x4]	; 037FE614
	bl loc_037FDD04	; 037FE616
	mov r0,#0x0	; 037FE61A
	mvn r0,r0	; 037FE61C
loc_037FE61E:
	add sp,#0xc	; 037FE61E
	pop {r4,r5,r6,r7}	; 037FE620
	pop {r3}	; 037FE622
	bx r3	; 037FE624
	.byte 0xC0, 0x46	; 037FE628
pool_037FE628:
loc_037FE628:
	.word 0x038059B4	; 037FE628
	.byte 0xF0, 0xB5, 0x83, 0xB0, 0x06, 0x1C, 0x0D, 0x1C, 0x02, 0x92, 0x1C, 0x1C, 0xFF, 0xF7, 0x52, 0xFB	; 037FE63C
	.byte 0x00, 0x90, 0xB1, 0x00, 0x18, 0x48, 0x45, 0x50, 0x23, 0x1C, 0x0C, 0x20, 0x43, 0x43, 0x28, 0x1C	; 037FE64C
	.byte 0x14, 0x30, 0x28, 0x61, 0x6C, 0x60, 0x00, 0x22, 0xD0, 0x43, 0x17, 0x1C, 0x0C, 0xE0, 0x29, 0x69	; 037FE65C
	.byte 0x16, 0x1C, 0x01, 0x96, 0x0C, 0x24, 0x66, 0x43, 0x01, 0x96, 0x8E, 0x19, 0x01, 0x9C, 0x08, 0x51	; 037FE66C
	.byte 0xB7, 0x60, 0xB1, 0x68, 0x71, 0x60, 0x52, 0x1C, 0x69, 0x68, 0x8A, 0x42, 0xEF, 0xDB, 0x00, 0x20	; 037FE67C
	.byte 0xC0, 0x43, 0x28, 0x60, 0x28, 0x69, 0xC0, 0x18, 0x1F, 0x30, 0x1F, 0x21, 0x88, 0x43, 0xA8, 0x60	; 037FE68C
	.byte 0x02, 0x98, 0x88, 0x43, 0x02, 0x90, 0xE8, 0x60, 0x00, 0x98, 0xFF, 0xF7, 0x35, 0xFB, 0xA8, 0x68	; 037FE69C
	.byte 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xB4, 0x59, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0	; 037FE6AC
	.byte 0x05, 0x1C, 0x0C, 0x1C, 0xFF, 0xF7, 0x16, 0xFB, 0xAA, 0x00, 0x05, 0x49, 0x89, 0x58, 0x0D, 0x68	; 037FE6BC
	.byte 0x0C, 0x60, 0xFF, 0xF7, 0x21, 0xFB, 0x28, 0x1C, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FE6CC
	.byte 0xB4, 0x59, 0x80, 0x03, 0xF0, 0xB5, 0x81, 0xB0, 0x06, 0x1C, 0x0D, 0x1C, 0x14, 0x1C, 0xFF, 0xF7	; 037FE6DC
	.byte 0x01, 0xFB, 0x07, 0x1C, 0xB1, 0x00, 0x0D, 0x48, 0x40, 0x58, 0x00, 0x2D, 0x00, 0xDA, 0x05, 0x68	; 037FE6EC
	.byte 0x20, 0x3C, 0x01, 0x69, 0x0C, 0x20, 0x45, 0x43, 0x4D, 0x19, 0xA8, 0x68, 0x21, 0x1C, 0x00, 0xF0	; 037FE6FC
	.byte 0x95, 0xF8, 0xA8, 0x60, 0x68, 0x68, 0x21, 0x1C, 0x00, 0xF0, 0x60, 0xF8, 0x68, 0x60, 0x38, 0x1C	; 037FE70C
	.byte 0xFF, 0xF7, 0xFA, 0xFA, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xB4, 0x59, 0x80, 0x03	; 037FE71C

; ===== function loc_037FE71C =====
loc_037FE71C:
	push {r4,r5,r6,r7,lr}	; 037FE71C
	sub sp,#0x4	; 037FE71E
	add r6,r0,#0x0	; 037FE720
	add r4,r1,#0x0	; 037FE722
	add r5,r2,#0x0	; 037FE724
	bl loc_037FDCE0	; 037FE726
	add r7,r0,#0x0	; 037FE72A
	lsl r2,r6,#0x2	; 037FE72C
	ldr r1,[pool_037FE7C4]	; 037FE72E
	ldr r1,[r1,r2]	; 037FE730
	cmp r1,#0x0	; 037FE732
	bne loc_037FE73E	; 037FE734
	bl loc_037FDD04	; 037FE736
	mov r0,#0x0	; 037FE73A
	b loc_037FE7BC	; 037FE73C
loc_037FE73E:
	cmp r4,#0x0	; 037FE73E
	bge loc_037FE744	; 037FE740
	ldr r4,[r1,#0x0]	; 037FE742
loc_037FE744:
	ldr r1,[r1,#0x10]	; 037FE744
	mov r0,#0xc	; 037FE746
	mul r4,r0	; 037FE748
	add r6,r1,r4	; 037FE74A
	add r5,#0x20	; 037FE74C
	add r5,#0x1f	; 037FE74E
	mov r0,#0x1f	; 037FE750
	bic r5,r0	; 037FE752
	ldr r0,[r6,#0x4]	; 037FE754
	add r4,r0,#0x0	; 037FE756
	b loc_037FE762	; 037FE758
loc_037FE75A:
	ldr r1,[r4,#0x8]	; 037FE75A
	cmp r5,r1	; 037FE75C
	ble loc_037FE766	; 037FE75E
	ldr r4,[r4,#0x4]	; 037FE760
loc_037FE762:
	cmp r4,#0x0	; 037FE762
	bne loc_037FE75A	; 037FE764
loc_037FE766:
	cmp r4,#0x0	; 037FE766
	bne loc_037FE774	; 037FE768
	add r0,r7,#0x0	; 037FE76A
	bl loc_037FDD04	; 037FE76C
	mov r0,#0x0	; 037FE770
	b loc_037FE7BC	; 037FE772
loc_037FE774:
	ldr r1,[r4,#0x8]	; 037FE774
	sub r1,r1,r5	; 037FE776
	cmp r1,#0x40	; 037FE778
	bcs loc_037FE786	; 037FE77A
	add r1,r4,#0x0	; 037FE77C
	bl loc_037FE828	; 037FE77E
	str r0,[r6,#0x4]	; 037FE782
	b loc_037FE7A8	; 037FE784
loc_037FE786:
	str r5,[r4,#0x8]	; 037FE786
	add r0,r4,r5	; 037FE788
	str r1,[r0,#0x8]	; 037FE78A
	ldr r1,[r4,#0x0]	; 037FE78C
	str r1,[r4,r5]	; 037FE78E
	ldr r1,[r4,#0x4]	; 037FE790
	str r1,[r0,#0x4]	; 037FE792
	ldr r1,[r0,#0x4]	; 037FE794
	cmp r1,#0x0	; 037FE796
	beq loc_037FE79C	; 037FE798
	str r0,[r1,#0x0]	; 037FE79A
loc_037FE79C:
	ldr r1,[r0,#0x0]	; 037FE79C
	cmp r1,#0x0	; 037FE79E
	beq loc_037FE7A6	; 037FE7A0
	str r0,[r1,#0x4]	; 037FE7A2
	b loc_037FE7A8	; 037FE7A4
loc_037FE7A6:
	str r0,[r6,#0x4]	; 037FE7A6
loc_037FE7A8:
	ldr r0,[r6,#0x8]	; 037FE7A8
	add r1,r4,#0x0	; 037FE7AA
	bl loc_037FE844	; 037FE7AC
	str r0,[r6,#0x8]	; 037FE7B0
	add r0,r7,#0x0	; 037FE7B2
	bl loc_037FDD04	; 037FE7B4
	add r4,#0x20	; 037FE7B8
	add r0,r4,#0x0	; 037FE7BA
loc_037FE7BC:
	add sp,#0x4	; 037FE7BC
	pop {r4,r5,r6,r7}	; 037FE7BE
	pop {r3}	; 037FE7C0
	bx r3	; 037FE7C2
pool_037FE7C4:
loc_037FE7C4:
	.word 0x038059B4	; 037FE7C4
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x02, 0x1C, 0x00, 0x23, 0x03, 0xE0, 0x91, 0x42, 0x03, 0xD9, 0x13, 0x1C	; 037FE7D8
	.byte 0x52, 0x68, 0x00, 0x2A, 0xF9, 0xD1, 0x4A, 0x60, 0x0B, 0x60, 0x00, 0x2A, 0x0C, 0xD0, 0x11, 0x60	; 037FE7E8
	.byte 0x8D, 0x68, 0x4C, 0x19, 0x94, 0x42, 0x07, 0xD1, 0x94, 0x68, 0x2C, 0x19, 0x8C, 0x60, 0x52, 0x68	; 037FE7F8
	.byte 0x4A, 0x60, 0x00, 0x2A, 0x00, 0xD0, 0x11, 0x60, 0x00, 0x2B, 0x0C, 0xD0, 0x59, 0x60, 0x9C, 0x68	; 037FE808
	.byte 0x1D, 0x19, 0x8D, 0x42, 0x08, 0xD1, 0x89, 0x68, 0x61, 0x18, 0x99, 0x60, 0x5A, 0x60, 0x00, 0x2A	; 037FE818
	.byte 0x02, 0xD0, 0x13, 0x60, 0x00, 0xE0, 0x08, 0x1C, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FE828

; ===== function loc_037FE828 =====
loc_037FE828:
	ldr r3,[r1,#0x4]	; 037FE828
	cmp r3,#0x0	; 037FE82A
	beq loc_037FE832	; 037FE82C
	ldr r2,[r1,#0x0]	; 037FE82E
	str r2,[r3,#0x0]	; 037FE830
loc_037FE832:
	ldr r2,[r1,#0x0]	; 037FE832
	cmp r2,#0x0	; 037FE834
	bne loc_037FE83C	; 037FE836
	ldr r0,[r1,#0x4]	; 037FE838
	bx lr	; 037FE83A
loc_037FE83C:
	ldr r1,[r1,#0x4]	; 037FE83C
	str r1,[r2,#0x4]	; 037FE83E
	bx lr	; 037FE840
	.byte 0x00, 0x00	; 037FE844

; ===== function loc_037FE844 =====
loc_037FE844:
	str r0,[r1,#0x4]	; 037FE844
	mov r2,#0x0	; 037FE846
	str r2,[r1,#0x0]	; 037FE848
	cmp r0,#0x0	; 037FE84A
	beq loc_037FE850	; 037FE84C
	str r1,[r0,#0x0]	; 037FE84E
loc_037FE850:
	add r0,r1,#0x0	; 037FE850
	bx lr	; 037FE852

; ===== function loc_037FE854 =====
loc_037FE854:
	ldr r1,[pool_037FE864]	; 037FE854
	ldrh r3,[r1,#0x0]	; 037FE856
	mov r2,#0x1	; 037FE858
	lsl r2,r0	; 037FE85A
	orr r3,r2	; 037FE85C
	strh r3,[r1,#0x0]	; 037FE85E
	bx lr	; 037FE860
	.byte 0xC0, 0x46	; 037FE864
pool_037FE864:
loc_037FE864:
	.word 0x038059D8	; 037FE864

; ===== function loc_037FE868 =====
loc_037FE868:
	push {r4,r5,lr}	; 037FE868
	sub sp,#0xc	; 037FE86A
	bl loc_037FDCE0	; 037FE86C
	ldr r1,[pool_037FE8D0]	; 037FE870
	ldrh r1,[r1,#0x0]	; 037FE872
	add r3,sp,#0x0	; 037FE874
	strh r1,[r3,#0x0]	; 037FE876
	ldr r1,[pool_037FE8D4]	; 037FE878
	ldr r5,[r1,#0x0]	; 037FE87A
	ldr r4,[r1,#0x4]	; 037FE87C
	ldr r1,[pool_037FE8D8]	; 037FE87E
	mov r2,#0x0	; 037FE880
	and r4,r1	; 037FE882
	bic r5,r2	; 037FE884
	str r5,[sp,#0x4]	; 037FE886
	str r4,[sp,#0x8]	; 037FE888
	ldr r1,[pool_037FE8DC]	; 037FE88A
	ldr r4,[r1,#0x0]	; 037FE88C
	mov r1,#0x8	; 037FE88E
	and r4,r1	; 037FE890
	cmp r4,#0x0	; 037FE892
	beq loc_037FE8AE	; 037FE894
	ldrh r3,[r3,#0x0]	; 037FE896
	ldr r1,[pool_037FE8E0]	; 037FE898
	and r3,r1	; 037FE89A
	cmp r3,#0x0	; 037FE89C
	bne loc_037FE8AE	; 037FE89E
	ldr r3,[sp,#0x4]	; 037FE8A0
	ldr r4,[sp,#0x8]	; 037FE8A2
	mov r1,#0x1	; 037FE8A4
	add r1,r3,r1	; 037FE8A6
	adc r4,r2	; 037FE8A8
	str r1,[sp,#0x4]	; 037FE8AA
	str r4,[sp,#0x8]	; 037FE8AC
loc_037FE8AE:
	bl loc_037FDD04	; 037FE8AE
	ldr r2,[sp,#0x4]	; 037FE8B2
	ldr r1,[sp,#0x8]	; 037FE8B4
	lsr r0,r2,#0x10	; 037FE8B6
	lsl r1,r1,#0x10	; 037FE8B8
	orr r1,r0	; 037FE8BA
	lsl r0,r2,#0x10	; 037FE8BC
	add r2,sp,#0x0	; 037FE8BE
	ldrh r3,[r2,#0x0]	; 037FE8C0
	asr r2,r3,#0x1f	; 037FE8C2
	orr r1,r2	; 037FE8C4
	orr r0,r3	; 037FE8C6
	add sp,#0xc	; 037FE8C8
	pop {r4,r5}	; 037FE8CA
	pop {r3}	; 037FE8CC
	bx r3	; 037FE8CE
pool_037FE8D0:
loc_037FE8D0:
	.word 0x04000100	; 037FE8D0
pool_037FE8D4:
loc_037FE8D4:
	.word 0x038059E4	; 037FE8D4
pool_037FE8D8:
loc_037FE8D8:
	.word 0x0000FFFF	; 037FE8D8
pool_037FE8DC:
loc_037FE8DC:
	.word 0x04000214	; 037FE8DC
pool_037FE8E0:
loc_037FE8E0:
	.word 0x00008000	; 037FE8E0

; ===== function loc_037FE8E4 =====
	push {r4,lr}	; 037FE8E4
	ldr r1,[pool_037FE920]	; 037FE8E6
	ldr r2,[r1,#0x0]	; 037FE8E8
	ldr r4,[r1,#0x4]	; 037FE8EA
	mov r3,#0x0	; 037FE8EC
	mov r0,#0x1	; 037FE8EE
	add r0,r2,r0	; 037FE8F0
	adc r4,r3	; 037FE8F2
	str r0,[r1,#0x0]	; 037FE8F4
	str r4,[r1,#0x4]	; 037FE8F6
	ldr r0,[pool_037FE924]	; 037FE8F8
	ldr r1,[r0,#0x0]	; 037FE8FA
	cmp r1,#0x0	; 037FE8FC
	beq loc_037FE90E	; 037FE8FE
	ldr r2,[pool_037FE928]	; 037FE900
	strh r3,[r2,#0x0]	; 037FE902
	ldr r1,[pool_037FE92C]	; 037FE904
	strh r3,[r1,#0x0]	; 037FE906
	mov r1,#0xc1	; 037FE908
	strh r1,[r2,#0x0]	; 037FE90A
	str r3,[r0,#0x0]	; 037FE90C
loc_037FE90E:
	mov r0,#0x0	; 037FE90E
	ldr r1,[pool_037FE930]	; 037FE910
	add r2,r0,#0x0	; 037FE912
	bl loc_037FDAE0	; 037FE914
	pop {r4}	; 037FE918
	pop {r3}	; 037FE91A
	bx r3	; 037FE91C
	.byte 0xC0, 0x46	; 037FE920
pool_037FE920:
loc_037FE920:
	.word 0x038059E4	; 037FE920
pool_037FE924:
loc_037FE924:
	.word 0x038059E0	; 037FE924
pool_037FE928:
loc_037FE928:
	.word 0x04000102	; 037FE928
pool_037FE92C:
loc_037FE92C:
	.word 0x04000100	; 037FE92C
pool_037FE930:
loc_037FE930:
	.word 0x037FE8E5	; 037FE930

; ===== function loc_037FE934 =====
loc_037FE934:
	ldr r0,[pool_037FE93C]	; 037FE934
	ldrh r0,[r0,#0x0]	; 037FE936
	bx lr	; 037FE938
	.byte 0xC0, 0x46	; 037FE93C
pool_037FE93C:
loc_037FE93C:
	.word 0x038059DC	; 037FE93C

; ===== function loc_037FE940 =====
loc_037FE940:
	push {lr}	; 037FE940
	sub sp,#0x4	; 037FE942
	ldr r0,[pool_037FE984]	; 037FE944
	ldrh r1,[r0,#0x0]	; 037FE946
	cmp r1,#0x0	; 037FE948
	bne loc_037FE97E	; 037FE94A
	mov r1,#0x1	; 037FE94C
	strh r1,[r0,#0x0]	; 037FE94E
	mov r0,#0x0	; 037FE950
	bl loc_037FE854	; 037FE952
	mov r2,#0x0	; 037FE956
	ldr r0,[pool_037FE988]	; 037FE958
	str r2,[r0,#0x0]	; 037FE95A
	str r2,[r0,#0x4]	; 037FE95C
	ldr r1,[pool_037FE98C]	; 037FE95E
	strh r2,[r1,#0x0]	; 037FE960
	ldr r0,[pool_037FE990]	; 037FE962
	strh r2,[r0,#0x0]	; 037FE964
	mov r0,#0xc1	; 037FE966
	strh r0,[r1,#0x0]	; 037FE968
	mov r0,#0x8	; 037FE96A
	ldr r1,[pool_037FE994]	; 037FE96C
	bl loc_037FDB14	; 037FE96E
	mov r0,#0x8	; 037FE972
	bl loc_037FDA90	; 037FE974
	mov r1,#0x0	; 037FE978
	ldr r0,[pool_037FE998]	; 037FE97A
	str r1,[r0,#0x0]	; 037FE97C
loc_037FE97E:
	add sp,#0x4	; 037FE97E
	pop {r3}	; 037FE980
	bx r3	; 037FE982
pool_037FE984:
loc_037FE984:
	.word 0x038059DC	; 037FE984
pool_037FE988:
loc_037FE988:
	.word 0x038059E4	; 037FE988
pool_037FE98C:
loc_037FE98C:
	.word 0x04000102	; 037FE98C
pool_037FE990:
loc_037FE990:
	.word 0x04000100	; 037FE990
pool_037FE994:
loc_037FE994:
	.word 0x037FE8E5	; 037FE994
pool_037FE998:
loc_037FE998:
	.word 0x038059E0	; 037FE998
.arm
	stmdb sp!,{lr}	; 037FE99C
	bl loc_037FE9AC	; 037FE9A0
	ldmia sp!,{lr}	; 037FE9A4
	bx lr	; 037FE9A8

; ===== function loc_037FE9AC =====
loc_037FE9AC:
	ldr r12,[pool_037FE9B4]	; 037FE9AC
	bx r12	; 037FE9B0
pool_037FE9B4:
loc_037FE9B4:
	.word 0x037FE9B9	; 037FE9B4
.thumb
loc_037FE9B8:
	push {r4,r5,lr}	; 037FE9B8
	sub sp,#0x4	; 037FE9BA
	mov r1,#0x0	; 037FE9BC
	ldr r0,[pool_037FEA50]	; 037FE9BE
	strh r1,[r0,#0x0]	; 037FE9C0
	mov r0,#0x10	; 037FE9C2
	bl loc_037FDA64	; 037FE9C4
	ldr r2,[pool_037FEA54]	; 037FE9C8
	ldr r1,[r2,#0x0]	; 037FE9CA
	mov r0,#0x10	; 037FE9CC
	orr r1,r0	; 037FE9CE
	str r1,[r2,#0x0]	; 037FE9D0
	bl loc_037FE868	; 037FE9D2
	ldr r2,[pool_037FEA58]	; 037FE9D6
	ldr r4,[r2,#0x0]	; 037FE9D8
	cmp r4,#0x0	; 037FE9DA
	beq loc_037FEA46	; 037FE9DC
	ldr r5,[r4,#0xc]	; 037FE9DE
	ldr r3,[r4,#0x10]	; 037FE9E0
	sub r0,r0,r5	; 037FE9E2
	sbc r1,r3	; 037FE9E4
	bcs loc_037FE9F0	; 037FE9E6
	add r0,r4,#0x0	; 037FE9E8
	bl loc_037FEC78	; 037FE9EA
	b loc_037FEA46	; 037FE9EE
loc_037FE9F0:
	ldr r1,[r4,#0x18]	; 037FE9F0
	str r1,[r2,#0x0]	; 037FE9F2
	cmp r1,#0x0	; 037FE9F4
	bne loc_037FE9FE	; 037FE9F6
	mov r0,#0x0	; 037FE9F8
	str r0,[r2,#0x4]	; 037FE9FA
	b loc_037FEA02	; 037FE9FC
loc_037FE9FE:
	mov r0,#0x0	; 037FE9FE
	str r0,[r1,#0x14]	; 037FEA00
loc_037FEA02:
	ldr r5,[r4,#0x0]	; 037FEA02
	ldr r2,[r4,#0x1c]	; 037FEA04
	ldr r1,[r4,#0x20]	; 037FEA06
	mov r0,#0x0	; 037FEA08
	eor r1,r0	; 037FEA0A
	eor r2,r0	; 037FEA0C
	orr r1,r2	; 037FEA0E
	bne loc_037FEA16	; 037FEA10
	mov r0,#0x0	; 037FEA12
	str r0,[r4,#0x0]	; 037FEA14
loc_037FEA16:
	cmp r5,#0x0	; 037FEA16
	beq loc_037FEA20	; 037FEA18
	ldr r0,[r4,#0x4]	; 037FEA1A
	bl loc_03805098	; 037FEA1C
loc_037FEA20:
	ldr r2,[r4,#0x1c]	; 037FEA20
	ldr r1,[r4,#0x20]	; 037FEA22
	mov r0,#0x0	; 037FEA24
	eor r1,r0	; 037FEA26
	eor r2,r0	; 037FEA28
	orr r1,r2	; 037FEA2A
	beq loc_037FEA3A	; 037FEA2C
	str r5,[r4,#0x0]	; 037FEA2E
	add r0,r4,#0x0	; 037FEA30
	mov r1,#0x0	; 037FEA32
	add r2,r1,#0x0	; 037FEA34
	bl loc_037FEB58	; 037FEA36
loc_037FEA3A:
	ldr r0,[pool_037FEA58]	; 037FEA3A
	ldr r0,[r0,#0x0]	; 037FEA3C
	cmp r0,#0x0	; 037FEA3E
	beq loc_037FEA46	; 037FEA40
	bl loc_037FEC78	; 037FEA42
loc_037FEA46:
	add sp,#0x4	; 037FEA46
	pop {r4,r5}	; 037FEA48
	pop {r3}	; 037FEA4A
	bx r3	; 037FEA4C
	.byte 0xC0, 0x46	; 037FEA50
pool_037FEA50:
loc_037FEA50:
	.word 0x04000106	; 037FEA50
pool_037FEA54:
loc_037FEA54:
	.word 0x0380FFF8	; 037FEA54
pool_037FEA58:
loc_037FEA58:
	.word 0x038059F0	; 037FEA58

; ===== function loc_037FEA5C =====
loc_037FEA5C:
	push {r4,r5,lr}	; 037FEA5C
	sub sp,#0x4	; 037FEA5E
	add r5,r0,#0x0	; 037FEA60
	bl loc_037FDCE0	; 037FEA62
	add r4,r0,#0x0	; 037FEA66
	ldr r1,[r5,#0x0]	; 037FEA68
	cmp r1,#0x0	; 037FEA6A
	bne loc_037FEA74	; 037FEA6C
	bl loc_037FDD04	; 037FEA6E
	b loc_037FEAAA	; 037FEA72
loc_037FEA74:
	ldr r0,[r5,#0x18]	; 037FEA74
	cmp r0,#0x0	; 037FEA76
	bne loc_037FEA82	; 037FEA78
	ldr r2,[r5,#0x14]	; 037FEA7A
	ldr r1,[pool_037FEAB4]	; 037FEA7C
	str r2,[r1,#0x4]	; 037FEA7E
	b loc_037FEA86	; 037FEA80
loc_037FEA82:
	ldr r1,[r5,#0x14]	; 037FEA82
	str r1,[r0,#0x14]	; 037FEA84
loc_037FEA86:
	ldr r1,[r5,#0x14]	; 037FEA86
	cmp r1,#0x0	; 037FEA88
	beq loc_037FEA90	; 037FEA8A
	str r0,[r1,#0x18]	; 037FEA8C
	b loc_037FEA9C	; 037FEA8E
loc_037FEA90:
	ldr r1,[pool_037FEAB4]	; 037FEA90
	str r0,[r1,#0x0]	; 037FEA92
	cmp r0,#0x0	; 037FEA94
	beq loc_037FEA9C	; 037FEA96
	bl loc_037FEC78	; 037FEA98
loc_037FEA9C:
	mov r0,#0x0	; 037FEA9C
	str r0,[r5,#0x0]	; 037FEA9E
	str r0,[r5,#0x1c]	; 037FEAA0
	str r0,[r5,#0x20]	; 037FEAA2
	add r0,r4,#0x0	; 037FEAA4
	bl loc_037FDD04	; 037FEAA6
loc_037FEAAA:
	add sp,#0x4	; 037FEAAA
	pop {r4,r5}	; 037FEAAC
	pop {r3}	; 037FEAAE
	bx r3	; 037FEAB0
	.byte 0xC0, 0x46	; 037FEAB4
pool_037FEAB4:
loc_037FEAB4:
	.word 0x038059F0	; 037FEAB4

; ===== function loc_037FEAB8 =====
loc_037FEAB8:
	push {r4,r5,r6,lr}	; 037FEAB8
	sub sp,#0x10	; 037FEABA
	add r5,r0,#0x0	; 037FEABC
	add r4,r1,#0x0	; 037FEABE
	add r6,r2,#0x0	; 037FEAC0
	str r3,[sp,#0x0]	; 037FEAC2
	ldr r0,[sp,#0x20]	; 037FEAC4
	str r0,[sp,#0x4]	; 037FEAC6
	cmp r5,#0x0	; 037FEAC8
	beq loc_037FEAD2	; 037FEACA
	ldr r0,[r5,#0x0]	; 037FEACC
	cmp r0,#0x0	; 037FEACE
	beq loc_037FEAD6	; 037FEAD0
loc_037FEAD2:
	bl loc_037FF1D4	; 037FEAD2
loc_037FEAD6:
	bl loc_037FDCE0	; 037FEAD6
	str r0,[sp,#0x8]	; 037FEADA
	ldr r0,[sp,#0x0]	; 037FEADC
	str r0,[r5,#0x1c]	; 037FEADE
	ldr r0,[sp,#0x4]	; 037FEAE0
	str r0,[r5,#0x20]	; 037FEAE2
	str r4,[r5,#0x24]	; 037FEAE4
	str r6,[r5,#0x28]	; 037FEAE6
	ldr r0,[sp,#0x24]	; 037FEAE8
	str r0,[r5,#0x0]	; 037FEAEA
	ldr r0,[sp,#0x28]	; 037FEAEC
	str r0,[r5,#0x4]	; 037FEAEE
	add r0,r5,#0x0	; 037FEAF0
	mov r1,#0x0	; 037FEAF2
	add r2,r1,#0x0	; 037FEAF4
	bl loc_037FEB58	; 037FEAF6
	ldr r0,[sp,#0x8]	; 037FEAFA
	bl loc_037FDD04	; 037FEAFC
	add sp,#0x10	; 037FEB00
	pop {r4,r5,r6}	; 037FEB02
	pop {r3}	; 037FEB04
	bx r3	; 037FEB06

; ===== function loc_037FEB08 =====
loc_037FEB08:
	push {r4,r5,r6,r7,lr}	; 037FEB08
	sub sp,#0x4	; 037FEB0A
	add r5,r0,#0x0	; 037FEB0C
	add r6,r1,#0x0	; 037FEB0E
	add r4,r2,#0x0	; 037FEB10
	add r7,r3,#0x0	; 037FEB12
	cmp r5,#0x0	; 037FEB14
	beq loc_037FEB1E	; 037FEB16
	ldr r0,[r5,#0x0]	; 037FEB18
	cmp r0,#0x0	; 037FEB1A
	beq loc_037FEB22	; 037FEB1C
loc_037FEB1E:
	bl loc_037FF1D4	; 037FEB1E
loc_037FEB22:
	bl loc_037FDCE0	; 037FEB22
	str r0,[sp,#0x0]	; 037FEB26
	mov r0,#0x0	; 037FEB28
	str r0,[r5,#0x1c]	; 037FEB2A
	str r0,[r5,#0x20]	; 037FEB2C
	str r7,[r5,#0x0]	; 037FEB2E
	ldr r0,[sp,#0x18]	; 037FEB30
	str r0,[r5,#0x4]	; 037FEB32
	bl loc_037FE868	; 037FEB34
	add r2,r0,#0x0	; 037FEB38
	add r0,r5,#0x0	; 037FEB3A
	add r2,r6,r2	; 037FEB3C
	adc r4,r1	; 037FEB3E
	add r1,r2,#0x0	; 037FEB40
	add r2,r4,#0x0	; 037FEB42
	bl loc_037FEB58	; 037FEB44
	ldr r0,[sp,#0x0]	; 037FEB48
	bl loc_037FDD04	; 037FEB4A
	add sp,#0x4	; 037FEB4E
	pop {r4,r5,r6,r7}	; 037FEB50
	pop {r3}	; 037FEB52
	bx r3	; 037FEB54
	.byte 0x00, 0x00	; 037FEB58

; ===== function loc_037FEB58 =====
loc_037FEB58:
	push {r4,r5,r6,r7,lr}	; 037FEB58
	sub sp,#0xc	; 037FEB5A
	add r5,r0,#0x0	; 037FEB5C
	add r4,r1,#0x0	; 037FEB5E
	add r6,r2,#0x0	; 037FEB60
	ldr r2,[r5,#0x1c]	; 037FEB62
	ldr r1,[r5,#0x20]	; 037FEB64
	mov r0,#0x0	; 037FEB66
	eor r1,r0	; 037FEB68
	eor r2,r0	; 037FEB6A
	orr r1,r2	; 037FEB6C
	beq loc_037FEBB2	; 037FEB6E
	bl loc_037FE868	; 037FEB70
	ldr r4,[r5,#0x24]	; 037FEB74
	ldr r6,[r5,#0x28]	; 037FEB76
	sub r2,r4,r0	; 037FEB78
	lsl r2,r6,#0	; 037FEB7A
	sbc r2,r1	; 037FEB7C
	bcs loc_037FEBB2	; 037FEB7E
	ldr r2,[r5,#0x1c]	; 037FEB80
	str r2,[sp,#0x0]	; 037FEB82
	ldr r2,[r5,#0x20]	; 037FEB84
	str r2,[sp,#0x4]	; 037FEB86
	sub r0,r0,r4	; 037FEB88
	sbc r1,r6	; 037FEB8A
	ldr r2,[sp,#0x0]	; 037FEB8C
	ldr r3,[sp,#0x4]	; 037FEB8E
	bl loc_037FEC1C	; 037FEB90
	str r0,[sp,#0x8]	; 037FEB94
	add r7,r1,#0x0	; 037FEB96
	ldr r0,[sp,#0x0]	; 037FEB98
	ldr r1,[sp,#0x4]	; 037FEB9A
	mov r3,#0x1	; 037FEB9C
	ldr r2,[sp,#0x8]	; 037FEB9E
	add r3,r2,r3	; 037FEBA0
	mov r2,#0x0	; 037FEBA2
	adc r7,r2	; 037FEBA4
	add r2,r3,#0x0	; 037FEBA6
	add r3,r7,#0x0	; 037FEBA8
	bl loc_037FEC28	; 037FEBAA
	add r4,r4,r0	; 037FEBAE
	adc r6,r1	; 037FEBB0
loc_037FEBB2:
	str r4,[r5,#0xc]	; 037FEBB2
	str r6,[r5,#0x10]	; 037FEBB4
	ldr r0,[pool_037FEC18]	; 037FEBB6
	ldr r3,[r0,#0x0]	; 037FEBB8
	b loc_037FEBEE	; 037FEBBA
loc_037FEBBC:
	ldr r1,[r3,#0xc]	; 037FEBBC
	ldr r0,[r3,#0x10]	; 037FEBBE
	sub r2,r4,r1	; 037FEBC0
	lsl r1,r6,#0	; 037FEBC2
	sbc r1,r0	; 037FEBC4
	mov r0,#0x0	; 037FEBC6
	sub r2,r2,r0	; 037FEBC8
	sbc r1,r0	; 037FEBCA
	bge loc_037FEBEC	; 037FEBCC
	ldr r0,[r3,#0x14]	; 037FEBCE
	str r0,[r5,#0x14]	; 037FEBD0
	str r5,[r3,#0x14]	; 037FEBD2
	str r3,[r5,#0x18]	; 037FEBD4
	ldr r0,[r5,#0x14]	; 037FEBD6
	cmp r0,#0x0	; 037FEBD8
	beq loc_037FEBE0	; 037FEBDA
	str r5,[r0,#0x18]	; 037FEBDC
	b loc_037FEC10	; 037FEBDE
loc_037FEBE0:
	ldr r0,[pool_037FEC18]	; 037FEBE0
	str r5,[r0,#0x0]	; 037FEBE2
	add r0,r5,#0x0	; 037FEBE4
	bl loc_037FEC78	; 037FEBE6
	b loc_037FEC10	; 037FEBEA
loc_037FEBEC:
	ldr r3,[r3,#0x18]	; 037FEBEC
loc_037FEBEE:
	cmp r3,#0x0	; 037FEBEE
	bne loc_037FEBBC	; 037FEBF0
	mov r0,#0x0	; 037FEBF2
	str r0,[r5,#0x18]	; 037FEBF4
	ldr r0,[pool_037FEC18]	; 037FEBF6
	ldr r1,[r0,#0x4]	; 037FEBF8
	str r5,[r0,#0x4]	; 037FEBFA
	str r1,[r5,#0x14]	; 037FEBFC
	cmp r1,#0x0	; 037FEBFE
	beq loc_037FEC06	; 037FEC00
	str r5,[r1,#0x18]	; 037FEC02
	b loc_037FEC10	; 037FEC04
loc_037FEC06:
	str r5,[r0,#0x4]	; 037FEC06
	str r5,[r0,#0x0]	; 037FEC08
	add r0,r5,#0x0	; 037FEC0A
	bl loc_037FEC78	; 037FEC0C
loc_037FEC10:
	add sp,#0xc	; 037FEC10
	pop {r4,r5,r6,r7}	; 037FEC12
	pop {r3}	; 037FEC14
	bx r3	; 037FEC16
pool_037FEC18:
loc_037FEC18:
	.word 0x038059F0	; 037FEC18

; ===== function loc_037FEC1C =====
loc_037FEC1C:
	bx pc	; 037FEC1C
	.byte 0xC0, 0x46	; 037FEC20
.arm

; ===== function loc_037FEC20 =====
loc_037FEC20:
	ldr pc,[pool_037FEC24]	; 037FEC20
pool_037FEC24:
loc_037FEC24:
	.word 0x0380494C	; 037FEC24
.thumb

; ===== function loc_037FEC28 =====
loc_037FEC28:
	bx pc	; 037FEC28
	.byte 0xC0, 0x46	; 037FEC2C
.arm

; ===== function loc_037FEC2C =====
loc_037FEC2C:
	ldr pc,[pool_037FEC30]	; 037FEC2C
pool_037FEC30:
loc_037FEC30:
	.word 0x03804B54	; 037FEC30
.thumb

; ===== function loc_037FEC34 =====
loc_037FEC34:
	mov r1,#0x0	; 037FEC34
	str r1,[r0,#0x0]	; 037FEC36
	str r1,[r0,#0x8]	; 037FEC38
	bx lr	; 037FEC3A

; ===== function loc_037FEC3C =====
loc_037FEC3C:
	ldr r0,[pool_037FEC44]	; 037FEC3C
	ldrh r0,[r0,#0x0]	; 037FEC3E
	bx lr	; 037FEC40
	.byte 0xC0, 0x46	; 037FEC44
pool_037FEC44:
loc_037FEC44:
	.word 0x038059EC	; 037FEC44

; ===== function loc_037FEC48 =====
loc_037FEC48:
	push {lr}	; 037FEC48
	sub sp,#0x4	; 037FEC4A
	ldr r1,[pool_037FEC70]	; 037FEC4C
	ldrh r0,[r1,#0x0]	; 037FEC4E
	cmp r0,#0x0	; 037FEC50
	bne loc_037FEC6A	; 037FEC52
	mov r0,#0x1	; 037FEC54
	strh r0,[r1,#0x0]	; 037FEC56
	bl loc_037FE854	; 037FEC58
	mov r1,#0x0	; 037FEC5C
	ldr r0,[pool_037FEC74]	; 037FEC5E
	str r1,[r0,#0x0]	; 037FEC60
	str r1,[r0,#0x4]	; 037FEC62
	mov r0,#0x10	; 037FEC64
	bl loc_037FDA64	; 037FEC66
loc_037FEC6A:
	add sp,#0x4	; 037FEC6A
	pop {r3}	; 037FEC6C
	bx r3	; 037FEC6E
pool_037FEC70:
loc_037FEC70:
	.word 0x038059EC	; 037FEC70
pool_037FEC74:
loc_037FEC74:
	.word 0x038059F0	; 037FEC74

; ===== function loc_037FEC78 =====
loc_037FEC78:
	push {r4,r5,lr}	; 037FEC78
	sub sp,#0x4	; 037FEC7A
	add r4,r0,#0x0	; 037FEC7C
	bl loc_037FE868	; 037FEC7E
	mov r2,#0x0	; 037FEC82
	ldr r3,[pool_037FECD0]	; 037FEC84
	strh r2,[r3,#0x0]	; 037FEC86
	ldr r3,[r4,#0xc]	; 037FEC88
	ldr r4,[r4,#0x10]	; 037FEC8A
	sub r5,r3,r0	; 037FEC8C
	sbc r4,r1	; 037FEC8E
	mov r0,#0x1	; 037FEC90
	ldr r1,[pool_037FECD4]	; 037FEC92
	bl loc_037FDAE0	; 037FEC94
	mov r1,#0x0	; 037FEC98
	sub r0,r5,r1	; 037FEC9A
	lsl r0,r4,#0	; 037FEC9C
	sbc r0,r1	; 037FEC9E
	bge loc_037FECA6	; 037FECA0
	ldr r1,[pool_037FECD8]	; 037FECA2
	b loc_037FECB8	; 037FECA4
loc_037FECA6:
	ldr r0,[pool_037FECDC]	; 037FECA6
	sub r0,r5,r0	; 037FECA8
	sbc r4,r1	; 037FECAA
	bge loc_037FECB6	; 037FECAC
	mvn r0,r5	; 037FECAE
	lsl r0,r0,#0x10	; 037FECB0
	lsr r1,r0,#0x10	; 037FECB2
	b loc_037FECB8	; 037FECB4
loc_037FECB6:
	mov r1,#0x0	; 037FECB6
loc_037FECB8:
	ldr r0,[pool_037FECE0]	; 037FECB8
	strh r1,[r0,#0x0]	; 037FECBA
	mov r1,#0xc1	; 037FECBC
	ldr r0,[pool_037FECD0]	; 037FECBE
	strh r1,[r0,#0x0]	; 037FECC0
	mov r0,#0x10	; 037FECC2
	bl loc_037FDA90	; 037FECC4
	add sp,#0x4	; 037FECC8
	pop {r4,r5}	; 037FECCA
	pop {r3}	; 037FECCC
	bx r3	; 037FECCE
pool_037FECD0:
loc_037FECD0:
	.word 0x04000106	; 037FECD0
pool_037FECD4:
loc_037FECD4:
	.word 0x037FE99C	; 037FECD4
pool_037FECD8:
loc_037FECD8:
	.word 0x0000FFFE	; 037FECD8
pool_037FECDC:
loc_037FECDC:
	.word 0x00010000	; 037FECDC
pool_037FECE0:
loc_037FECE0:
	.word 0x04000104	; 037FECE0

; ===== function loc_037FECE4 =====
	push {r4,lr}	; 037FECE4
	add r4,r0,#0x0	; 037FECE6
	bl loc_037FDCE0	; 037FECE8
	ldr r1,[pool_037FED10]	; 037FECEC
	ldr r1,[r1,#0x0]	; 037FECEE
	cmp r4,r1	; 037FECF0
	bcs loc_037FECFC	; 037FECF2
	ldr r1,[pool_037FED14]	; 037FECF4
	ldr r2,[r1,#0x0]	; 037FECF6
	add r2,r2,#0x1	; 037FECF8
	str r2,[r1,#0x0]	; 037FECFA
loc_037FECFC:
	ldr r1,[pool_037FED10]	; 037FECFC
	str r4,[r1,#0x0]	; 037FECFE
	bl loc_037FDD04	; 037FED00
	ldr r0,[pool_037FED14]	; 037FED04
	ldr r0,[r0,#0x0]	; 037FED06
	pop {r4}	; 037FED08
	pop {r3}	; 037FED0A
	bx r3	; 037FED0C
	.byte 0xC0, 0x46	; 037FED10
pool_037FED10:
loc_037FED10:
	.word 0x038059FC	; 037FED10
pool_037FED14:
loc_037FED14:
	.word 0x03805A00	; 037FED14
	.byte 0xC3, 0x68, 0xCB, 0x1A, 0x10, 0x21, 0x41, 0x5E, 0x52, 0x1A, 0x00, 0x2B, 0x03, 0xDB, 0x00, 0x2B	; 037FED28
	.byte 0x03, 0xD1, 0x00, 0x2A, 0x01, 0xDA, 0x00, 0x20, 0x70, 0x47, 0x00, 0x2A, 0x01, 0xDA, 0x05, 0x49	; 037FED38
	.byte 0x52, 0x18, 0x12, 0x21, 0x40, 0x5E, 0x82, 0x42, 0x01, 0xDC, 0x01, 0x20, 0x70, 0x47, 0x02, 0x20	; 037FED48
	.byte 0x70, 0x47, 0xC0, 0x46, 0x07, 0x01, 0x00, 0x00, 0xF0, 0xB5, 0x81, 0xB0, 0x04, 0x20, 0xFE, 0xF7	; 037FED58
	.byte 0x85, 0xFE, 0x35, 0x4B, 0x19, 0x88, 0x20, 0x20, 0x81, 0x43, 0x19, 0x80, 0x33, 0x4A, 0x11, 0x68	; 037FED68
	.byte 0x04, 0x20, 0x01, 0x43, 0x11, 0x60, 0x19, 0x88, 0x0A, 0x12, 0xFF, 0x20, 0x02, 0x40, 0x49, 0x00	; 037FED78
	.byte 0x2F, 0x48, 0x01, 0x40, 0x0A, 0x43, 0x50, 0x1E, 0xFF, 0xF7, 0xB0, 0xFF, 0x2D, 0x4F, 0x4B, 0xE0	; 037FED88
	.byte 0x3C, 0x88, 0x20, 0x1C, 0xFF, 0xF7, 0xAA, 0xFF, 0x06, 0x1C, 0x28, 0x1C, 0x31, 0x1C, 0x22, 0x1C	; 037FED98
	.byte 0xFF, 0xF7, 0xBE, 0xFF, 0x00, 0x28, 0x04, 0xD0, 0x01, 0x28, 0x19, 0xD0, 0x02, 0x28, 0x31, 0xD0	; 037FEDA8
	.byte 0x3A, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0xA0, 0xF8, 0x39, 0x88, 0x10, 0x20, 0x28, 0x5E, 0x88, 0x42	; 037FEDB8
	.byte 0x36, 0xD1, 0xE8, 0x68, 0xB0, 0x42, 0x33, 0xD1, 0x04, 0x20, 0xFE, 0xF7, 0x4F, 0xFE, 0x1A, 0x48	; 037FEDC8
	.byte 0x01, 0x88, 0x20, 0x20, 0x81, 0x43, 0x18, 0x48, 0x01, 0x80, 0x04, 0x20, 0xFE, 0xF7, 0x34, 0xFE	; 037FEDD8
	.byte 0x2C, 0x68, 0x28, 0x1C, 0x00, 0xF0, 0x14, 0xF9, 0x00, 0x20, 0x28, 0x60, 0x00, 0x2C, 0x02, 0xD0	; 037FEDE8
	.byte 0x68, 0x68, 0x06, 0xF0, 0x53, 0xF9, 0xE8, 0x69, 0x00, 0x28, 0x15, 0xD0, 0x68, 0x6A, 0x00, 0x28	; 037FEDF8
	.byte 0x12, 0xD1, 0x2C, 0x60, 0x10, 0x48, 0x00, 0x68, 0x40, 0x1C, 0xE8, 0x60, 0x28, 0x1C, 0x00, 0xF0	; 037FEE08
	.byte 0x13, 0xF9, 0x09, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0xFB, 0xF8, 0x28, 0x1C, 0x00, 0xF0, 0x0C, 0xF9	; 037FEE18
	.byte 0x09, 0x48, 0x00, 0x68, 0x40, 0x1C, 0xE8, 0x60, 0x08, 0x48, 0x05, 0x68, 0x00, 0x2D, 0xAF, 0xD1	; 037FEE28
	.byte 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x04, 0x00, 0x00, 0x04, 0xF8, 0xFF, 0x80, 0x03	; 037FEE38
	.byte 0x00, 0x01, 0x00, 0x00, 0x06, 0x00, 0x00, 0x04, 0x00, 0x5A, 0x80, 0x03, 0x04, 0x5A, 0x80, 0x03	; 037FEE48
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFE, 0xF7, 0x47, 0xFF, 0x06, 0x1C, 0x00, 0x2D, 0x01, 0xD1	; 037FEE58
	.byte 0x00, 0xF0, 0xBC, 0xF9, 0x0E, 0x48, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x84, 0x69, 0x00, 0xE0	; 037FEE68
	.byte 0x00, 0x24, 0x00, 0x27, 0x0A, 0xE0, 0x81, 0x68, 0xA9, 0x42, 0x01, 0xD1, 0x00, 0xF0, 0x12, 0xF8	; 037FEE78
	.byte 0x20, 0x1C, 0x00, 0x2C, 0x01, 0xD0, 0xA4, 0x69, 0x00, 0xE0, 0x3C, 0x1C, 0x00, 0x28, 0xF2, 0xD1	; 037FEE88
	.byte 0x30, 0x1C, 0xFE, 0xF7, 0x3B, 0xFF, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FEE98
	.byte 0x04, 0x5A, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xFE, 0xF7, 0x1D, 0xFF, 0x04, 0x1C	; 037FEEA8
	.byte 0x01, 0x21, 0x69, 0x62, 0x29, 0x68, 0x00, 0x29, 0x02, 0xD1, 0xFE, 0xF7, 0x27, 0xFF, 0x07, 0xE0	; 037FEEB8
	.byte 0x28, 0x1C, 0x00, 0xF0, 0xA5, 0xF8, 0x00, 0x20, 0x28, 0x60, 0x20, 0x1C, 0xFE, 0xF7, 0x1E, 0xFF	; 037FEEC8
	.byte 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 037FEED0

; ===== function loc_037FEED0 =====
loc_037FEED0:
	push {r4,r5,lr}	; 037FEED0
	sub sp,#0x4	; 037FEED2
	add r5,r0,#0x0	; 037FEED4
	add r4,r1,#0x0	; 037FEED6
	cmp r4,#0x0	; 037FEED8
	bne loc_037FEEE0	; 037FEEDA
	bl loc_037FF1D4	; 037FEEDC
loc_037FEEE0:
	cmp r5,#0x0	; 037FEEE0
	beq loc_037FEEE6	; 037FEEE2
	str r4,[r5,#0x8]	; 037FEEE4
loc_037FEEE6:
	add sp,#0x4	; 037FEEE6
	pop {r4,r5}	; 037FEEE8
	pop {r3}	; 037FEEEA
	bx r3	; 037FEEEC
	.byte 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C, 0x04, 0x20, 0x0E, 0x49, 0xFE, 0xF7, 0x0C, 0xFE, 0x10, 0x20	; 037FEEFE
	.byte 0x20, 0x5E, 0x0C, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x54, 0x10, 0x0B, 0x4A, 0x13, 0x88, 0x3F, 0x21	; 037FEF0E
	.byte 0x0B, 0x40, 0xFF, 0x21, 0x08, 0x40, 0x00, 0x02, 0x03, 0x43, 0x1C, 0x43, 0x14, 0x80, 0x11, 0x88	; 037FEF1E
	.byte 0x20, 0x20, 0x01, 0x43, 0x11, 0x80, 0x04, 0x20, 0xFE, 0xF7, 0xB3, 0xFD, 0x10, 0xBC, 0x08, 0xBC	; 037FEF2E
	.byte 0x18, 0x47, 0x51, 0xED, 0x7F, 0x03, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x04, 0xF0, 0xB5	; 037FEF3E
	.byte 0x83, 0xB0, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x1F, 0x1C, 0xFE, 0xF7, 0xCA, 0xFE, 0x00, 0x90	; 037FEF4E
	.byte 0x00, 0x2D, 0x02, 0xD0, 0x28, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x3C, 0xF9, 0x0E, 0x48	; 037FEF5E
	.byte 0x00, 0x88, 0x01, 0x90, 0xFF, 0xF7, 0xBF, 0xFE, 0x01, 0x21, 0xE9, 0x61, 0x2C, 0x82, 0x01, 0x99	; 037FEF6E
	.byte 0x8C, 0x42, 0x00, 0xDC, 0x40, 0x1C, 0xE8, 0x60, 0x6E, 0x82, 0x2F, 0x60, 0x08, 0x98, 0x68, 0x60	; 037FEF7E
	.byte 0x00, 0x20, 0x68, 0x62, 0x28, 0x1C, 0x00, 0xF0, 0x68, 0xF8, 0x00, 0x98, 0xFE, 0xF7, 0xBB, 0xFE	; 037FEF8E
	.byte 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x06, 0x00, 0x00, 0x04, 0xF0, 0xB5	; 037FEF9E
	.byte 0x83, 0xB0, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x1F, 0x1C, 0xFE, 0xF7, 0x9A, 0xFE, 0x00, 0x90	; 037FEFAE
	.byte 0x00, 0x2D, 0x02, 0xD0, 0x28, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x0C, 0xF9, 0x0E, 0x48	; 037FEFBE
	.byte 0x00, 0x88, 0x01, 0x90, 0xFF, 0xF7, 0x8F, 0xFE, 0x00, 0x21, 0xE9, 0x61, 0x2C, 0x82, 0x01, 0x99	; 037FEFCE
	.byte 0x8C, 0x42, 0x00, 0xDC, 0x40, 0x1C, 0xE8, 0x60, 0x6E, 0x82, 0x2F, 0x60, 0x08, 0x98, 0x68, 0x60	; 037FEFDE
	.byte 0x00, 0x20, 0x68, 0x62, 0x28, 0x1C, 0x00, 0xF0, 0x38, 0xF8, 0x00, 0x98, 0xFE, 0xF7, 0x8B, 0xFE	; 037FEFEE
	.byte 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x06, 0x00, 0x00, 0x04	; 037FEFFC

; ===== function loc_037FEFFC =====
loc_037FEFFC:
	mov r1,#0x0	; 037FEFFC
	str r1,[r0,#0x0]	; 037FEFFE
	str r1,[r0,#0x8]	; 037FF000
	str r1,[r0,#0x20]	; 037FF002
	bx lr	; 037FF004
	.byte 0x00, 0x00, 0x00, 0x28, 0x0D, 0xD0, 0x42, 0x69, 0x81, 0x69, 0x00, 0x29, 0x01, 0xD0, 0x4A, 0x61	; 037FF016
	.byte 0x01, 0xE0, 0x04, 0x48, 0x42, 0x60, 0x00, 0x2A, 0x01, 0xD0, 0x91, 0x61, 0x70, 0x47, 0x01, 0x48	; 037FF026
	.byte 0x01, 0x60, 0x70, 0x47, 0xC0, 0x46, 0x04, 0x5A, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x49	; 037FF036
	.byte 0x4B, 0x68, 0x43, 0x61, 0x00, 0x22, 0x82, 0x61, 0x48, 0x60, 0x00, 0x2B, 0x01, 0xD0, 0x98, 0x61	; 037FF046
	.byte 0x02, 0xE0, 0x08, 0x60, 0xFF, 0xF7, 0x51, 0xFF, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x04, 0x5A	; 037FF056
	.byte 0x80, 0x03, 0x10, 0xB5, 0x11, 0x49, 0x09, 0x68, 0x10, 0x22, 0x17, 0xE0, 0xC4, 0x68, 0xCB, 0x68	; 037FF066
	.byte 0xA3, 0x42, 0x12, 0xD3, 0xA3, 0x42, 0x03, 0xD1, 0x8C, 0x5E, 0x83, 0x5E, 0x9C, 0x42, 0x0C, 0xDD	; 037FF076
	.byte 0x4A, 0x69, 0x42, 0x61, 0x81, 0x61, 0x48, 0x61, 0x00, 0x2A, 0x01, 0xD0, 0x90, 0x61, 0x09, 0xE0	; 037FF086
	.byte 0x06, 0x49, 0x08, 0x60, 0xFF, 0xF7, 0x31, 0xFF, 0x04, 0xE0, 0x89, 0x69, 0x00, 0x29, 0xE5, 0xD1	; 037FF096
	.byte 0xFF, 0xF7, 0xCB, 0xFF, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x04, 0x5A, 0x80, 0x03	; 037FF0A4

; ===== function loc_037FF0A4 =====
loc_037FF0A4:
	ldr r0,[pool_037FF0AC]	; 037FF0A4
	ldrh r0,[r0,#0x0]	; 037FF0A6
	bx lr	; 037FF0A8
	.byte 0xC0, 0x46	; 037FF0AC
pool_037FF0AC:
loc_037FF0AC:
	.word 0x038059F8	; 037FF0AC

; ===== function loc_037FF0B0 =====
loc_037FF0B0:
	push {lr}	; 037FF0B0
	sub sp,#0x4	; 037FF0B2
	ldr r0,[pool_037FF0E0]	; 037FF0B4
	ldrh r1,[r0,#0x0]	; 037FF0B6
	cmp r1,#0x0	; 037FF0B8
	bne loc_037FF0D8	; 037FF0BA
	mov r1,#0x1	; 037FF0BC
	strh r1,[r0,#0x0]	; 037FF0BE
	mov r1,#0x0	; 037FF0C0
	ldr r0,[pool_037FF0E4]	; 037FF0C2
	str r1,[r0,#0x0]	; 037FF0C4
	str r1,[r0,#0x4]	; 037FF0C6
	mov r0,#0x4	; 037FF0C8
	bl loc_037FDA64	; 037FF0CA
	mov r1,#0x0	; 037FF0CE
	ldr r0,[pool_037FF0E8]	; 037FF0D0
	str r1,[r0,#0x0]	; 037FF0D2
	ldr r0,[pool_037FF0EC]	; 037FF0D4
	str r1,[r0,#0x0]	; 037FF0D6
loc_037FF0D8:
	add sp,#0x4	; 037FF0D8
	pop {r3}	; 037FF0DA
	bx r3	; 037FF0DC
	.byte 0xC0, 0x46	; 037FF0E0
pool_037FF0E0:
loc_037FF0E0:
	.word 0x038059F8	; 037FF0E0
pool_037FF0E4:
loc_037FF0E4:
	.word 0x03805A04	; 037FF0E4
pool_037FF0E8:
loc_037FF0E8:
	.word 0x03805A00	; 037FF0E8
pool_037FF0EC:
loc_037FF0EC:
	.word 0x038059FC	; 037FF0EC
.arm

; ===== function loc_037FF0F0 =====
loc_037FF0F0:
	mrs r0,cpsr	; 037FF0F0
	bic r1,r0,#0x80	; 037FF0F4
	msr cpsr_c,r1	; 037FF0F8
	and r0,r0,#0x80	; 037FF0FC
	bx lr	; 037FF100

; ===== function loc_037FF104 =====
loc_037FF104:
	mrs r0,cpsr	; 037FF104
	orr r1,r0,#0x80	; 037FF108
	msr cpsr_c,r1	; 037FF10C
	and r0,r0,#0x80	; 037FF110
	bx lr	; 037FF114

; ===== function loc_037FF118 =====
loc_037FF118:
	mrs r1,cpsr	; 037FF118
	bic r2,r1,#0x80	; 037FF11C
	orr r2,r2,r0	; 037FF120
	msr cpsr_c,r2	; 037FF124
	and r0,r1,#0x80	; 037FF128
	bx lr	; 037FF12C

; ===== function loc_037FF130 =====
loc_037FF130:
	mrs r0,cpsr	; 037FF130
	orr r1,r0,#0xc0	; 037FF134
	msr cpsr_c,r1	; 037FF138
	and r0,r0,#0xc0	; 037FF13C
	bx lr	; 037FF140

; ===== function loc_037FF144 =====
loc_037FF144:
	mrs r1,cpsr	; 037FF144
	bic r2,r1,#0xc0	; 037FF148
	orr r2,r2,r0	; 037FF14C
	msr cpsr_c,r2	; 037FF150
	and r0,r1,#0xc0	; 037FF154
	bx lr	; 037FF158

; ===== function loc_037FF15C =====
loc_037FF15C:
	mrs r0,cpsr	; 037FF15C
	and r0,r0,#0x1f	; 037FF160
	bx lr	; 037FF164
.thumb

; ===== function loc_037FF168 =====
loc_037FF168:
	push {r4,r5,r6,r7,lr}	; 037FF168
	sub sp,#0x4	; 037FF16A
	add r6,r0,#0x0	; 037FF16C
	add r5,r1,#0x0	; 037FF16E
	bl loc_037FDCE0	; 037FF170
	add r7,r0,#0x0	; 037FF174
	ldr r1,[pool_037FF1C0]	; 037FF176
	ldrh r4,[r1,#0x0]	; 037FF178
	mov r0,#0x1	; 037FF17A
	strh r0,[r1,#0x0]	; 037FF17C
	cmp r6,#0x0	; 037FF17E
	beq loc_037FF198	; 037FF180
	ldr r1,[pool_037FF1C4]	; 037FF182
	ldr r0,[r1,#0x0]	; 037FF184
	bic r0,r5	; 037FF186
	str r0,[r1,#0x0]	; 037FF188
	b loc_037FF198	; 037FF18A
loc_037FF18C:
	bl loc_038048EE	; 037FF18C
	bl loc_037FAFF8	; 037FF190
	bl loc_037FDCE0	; 037FF194
loc_037FF198:
	ldr r1,[pool_037FF1C4]	; 037FF198
	ldr r0,[r1,#0x0]	; 037FF19A
	add r2,r5,#0x0	; 037FF19C
	and r2,r0	; 037FF19E
	cmp r2,#0x0	; 037FF1A0
	beq loc_037FF18C	; 037FF1A2
	ldr r0,[r1,#0x0]	; 037FF1A4
	bic r0,r5	; 037FF1A6
	str r0,[r1,#0x0]	; 037FF1A8
	ldr r1,[pool_037FF1C0]	; 037FF1AA
	ldrh r0,[r1,#0x0]	; 037FF1AC
	strh r4,[r1,#0x0]	; 037FF1AE
	add r0,r7,#0x0	; 037FF1B0
	bl loc_037FDD04	; 037FF1B2
	add sp,#0x4	; 037FF1B6
	pop {r4,r5,r6,r7}	; 037FF1B8
	pop {r3}	; 037FF1BA
	bx r3	; 037FF1BC
	.byte 0xC0, 0x46	; 037FF1C0
pool_037FF1C0:
loc_037FF1C0:
	.word 0x04000208	; 037FF1C0
pool_037FF1C4:
loc_037FF1C4:
	.word 0x0380FFF8	; 037FF1C4

; ===== function loc_037FF1C8 =====
loc_037FF1C8:
	lsr r0,r0,#0x2	; 037FF1C8
	ldr r3,[pool_037FF1D0]	; 037FF1CA
	bx r3	; 037FF1CC
	.byte 0xC0, 0x46	; 037FF1D0
pool_037FF1D0:
loc_037FF1D0:
	.word 0x038048D5	; 037FF1D0

; ===== function loc_037FF1D4 =====
loc_037FF1D4:
	push {lr}	; 037FF1D4
	sub sp,#0x4	; 037FF1D6
loc_037FF1D8:
	bl loc_037FDCE0	; 037FF1D8
	bl loc_038048EE	; 037FF1DC
	b loc_037FF1D8	; 037FF1E0
	.byte 0x00, 0x00	; 037FF1E4

; ===== function loc_037FF1E4 =====
loc_037FF1E4:
	push {r4,lr}	; 037FF1E4
	add r4,r0,#0x0	; 037FF1E6
	bl loc_037FDCE0	; 037FF1E8
	mov r1,#0x6	; 037FF1EC
	mul r4,r1	; 037FF1EE
	add r1,r4,#0x5	; 037FF1F0
	lsl r2,r1,#0x1	; 037FF1F2
	ldr r1,[pool_037FF218]	; 037FF1F4
	add r2,r2,r1	; 037FF1F6
	ldrh r3,[r2,#0x0]	; 037FF1F8
	ldr r1,[pool_037FF21C]	; 037FF1FA
	and r3,r1	; 037FF1FC
	strh r3,[r2,#0x0]	; 037FF1FE
	ldrh r3,[r2,#0x0]	; 037FF200
	ldr r1,[pool_037FF220]	; 037FF202
	and r3,r1	; 037FF204
	strh r3,[r2,#0x0]	; 037FF206
	ldrh r1,[r2,#0x0]	; 037FF208
	ldrh r1,[r2,#0x0]	; 037FF20A
	bl loc_037FDD04	; 037FF20C
	pop {r4}	; 037FF210
	pop {r3}	; 037FF212
	bx r3	; 037FF214
	.byte 0xC0, 0x46	; 037FF218
pool_037FF218:
loc_037FF218:
	.word 0x040000B0	; 037FF218
pool_037FF21C:
loc_037FF21C:
	.word 0xFFFFCDFF	; 037FF21C
pool_037FF220:
loc_037FF220:
	.word 0xFFFF7FFF	; 037FF220
	.byte 0x03, 0x21, 0x48, 0x43, 0x80, 0x1C, 0x81, 0x00, 0x03, 0x48, 0x0A, 0x18, 0x03, 0x48, 0x11, 0x68	; 037FF234
	.byte 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0x70, 0x47, 0xB0, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x80	; 037FF244
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x17, 0x1C, 0x00, 0x93, 0x00, 0x2B, 0x20, 0xD0	; 037FF254
	.byte 0x03, 0x20, 0x29, 0x1C, 0x41, 0x43, 0x88, 0x1C, 0x81, 0x00, 0x10, 0x48, 0x0C, 0x18, 0x10, 0x48	; 037FF264
	.byte 0x21, 0x68, 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0xFE, 0xF7, 0x38, 0xFD, 0x0C, 0x21, 0x4D, 0x43	; 037FF274
	.byte 0x0A, 0x49, 0x6A, 0x18, 0x16, 0x60, 0x57, 0x60, 0x00, 0x9B, 0x5D, 0x08, 0x08, 0x4B, 0x1D, 0x43	; 037FF284
	.byte 0x95, 0x60, 0x09, 0x68, 0xFE, 0xF7, 0x3C, 0xFD, 0x05, 0x48, 0x21, 0x68, 0x01, 0x40, 0x00, 0x29	; 037FF294
	.byte 0xFB, 0xD1, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xB0, 0x00, 0x00, 0x04	; 037FF2A4
	.byte 0x00, 0x00, 0x00, 0x80, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x17, 0x1C, 0x00, 0x93	; 037FF2B4
	.byte 0x00, 0x2B, 0x24, 0xD0, 0x03, 0x20, 0x29, 0x1C, 0x41, 0x43, 0x88, 0x1C, 0x81, 0x00, 0x12, 0x48	; 037FF2C4
	.byte 0x0C, 0x18, 0x12, 0x48, 0x21, 0x68, 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0xFE, 0xF7, 0x06, 0xFD	; 037FF2D4
	.byte 0xAA, 0x00, 0x0F, 0x49, 0x51, 0x18, 0x0F, 0x60, 0x0C, 0x22, 0x55, 0x43, 0x0A, 0x4A, 0xAB, 0x18	; 037FF2E4
	.byte 0x19, 0x60, 0x5E, 0x60, 0x00, 0x99, 0x4D, 0x08, 0x0A, 0x49, 0x0D, 0x43, 0x9D, 0x60, 0x11, 0x68	; 037FF2F4
	.byte 0xFE, 0xF7, 0x06, 0xFD, 0x05, 0x48, 0x21, 0x68, 0x01, 0x40, 0x00, 0x29, 0xFB, 0xD1, 0x01, 0xB0	; 037FF304
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xB0, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x80	; 037FF314
	.byte 0xE0, 0xFF, 0x80, 0x03, 0x00, 0x00, 0x00, 0x81	; 037FF31C
.arm

; ===== function loc_037FF31C =====
loc_037FF31C:
	mov r3,#0x0	; 037FF31C
loc_037FF320:
	cmp r3,r2	; 037FF320
	strlth r0,[r1,r3]	; 037FF324
	addlt r3,r3,#0x2	; 037FF328
	blt loc_037FF320	; 037FF32C
	bx lr	; 037FF330
	.byte 0x00, 0xC0, 0xA0, 0xE3, 0x02, 0x00, 0x5C, 0xE1, 0xBC, 0x30, 0x90, 0xB1, 0xBC, 0x30, 0x81, 0xB1	; 037FF344
	.byte 0x02, 0xC0, 0x8C, 0xB2, 0xFA, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1	; 037FF350

; ===== function loc_037FF350 =====
loc_037FF350:
	add r12,r1,r2	; 037FF350
loc_037FF354:
	cmp r1,r12	; 037FF354
	stmltia r1!,{r0}	; 037FF358
	blt loc_037FF354	; 037FF35C
	bx lr	; 037FF360

; ===== function loc_037FF364 =====
loc_037FF364:
	add r12,r1,r2	; 037FF364
loc_037FF368:
	cmp r1,r12	; 037FF368
	ldmltia r0!,{r2}	; 037FF36C
	stmltia r1!,{r2}	; 037FF370
	blt loc_037FF368	; 037FF374
	bx lr	; 037FF378
	.byte 0xF0, 0x03, 0x2D, 0xE9, 0x02, 0x90, 0x81, 0xE0, 0xA2, 0xC2, 0xA0, 0xE1, 0x8C, 0xC2, 0x81, 0xE0	; 037FF38C
	.byte 0x00, 0x20, 0xA0, 0xE1, 0x02, 0x30, 0xA0, 0xE1, 0x02, 0x40, 0xA0, 0xE1, 0x02, 0x50, 0xA0, 0xE1	; 037FF39C
	.byte 0x02, 0x60, 0xA0, 0xE1, 0x02, 0x70, 0xA0, 0xE1, 0x02, 0x80, 0xA0, 0xE1, 0x0C, 0x00, 0x51, 0xE1	; 037FF3AC
	.byte 0xFD, 0x01, 0xA1, 0xB8, 0xFC, 0xFF, 0xFF, 0xBA, 0x09, 0x00, 0x51, 0xE1, 0x01, 0x00, 0xA1, 0xB8	; 037FF3BC
	.byte 0xFC, 0xFF, 0xFF, 0xBA, 0xF0, 0x03, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 037FF3C8

; ===== function loc_037FF3C8 =====
loc_037FF3C8:
	mov r12,#0x0	; 037FF3C8
loc_037FF3CC:
	cmp r12,r2	; 037FF3CC
	strltb r1,[r0,r12]	; 037FF3D0
	addlt r12,r12,#0x1	; 037FF3D4
	blt loc_037FF3CC	; 037FF3D8
	bx lr	; 037FF3DC
	.byte 0x00, 0xC0, 0xA0, 0xE3, 0x02, 0x00, 0x5C, 0xE1, 0x0C, 0x30, 0xD0, 0xB7, 0x0C, 0x30, 0xC1, 0xB7	; 037FF3F0
	.byte 0x01, 0xC0, 0x8C, 0xB2, 0xFA, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1	; 037FF3FC

; ===== function loc_037FF3FC =====
loc_037FF3FC:
	swp r0,r0,[r1]	; 037FF3FC
	bx lr	; 037FF400
.thumb

; ===== function loc_037FF404 =====
loc_037FF404:
	push {r4,r5,r6,lr}	; 037FF404
	ldr r4,[pool_037FF434]	; 037FF406
	ldrb r5,[r4,#0x0]	; 037FF408
	mov r4,#0x80	; 037FF40A
	and r5,r4	; 037FF40C
	cmp r5,#0x0	; 037FF40E
	beq loc_037FF416	; 037FF410
	mov r6,#0x1	; 037FF412
	b loc_037FF418	; 037FF414
loc_037FF416:
	mov r6,#0x0	; 037FF416
loc_037FF418:
	lsl r5,r1,#0x2	; 037FF418
	lsl r4,r2,#0x4	; 037FF41A
	lsl r2,r6,#0x7	; 037FF41C
	lsl r1,r3,#0x5	; 037FF41E
	orr r2,r1	; 037FF420
	orr r4,r2	; 037FF422
	orr r5,r4	; 037FF424
	orr r0,r5	; 037FF426
	ldr r1,[pool_037FF434]	; 037FF428
	strb r0,[r1,#0x0]	; 037FF42A
	pop {r4,r5,r6}	; 037FF42C
	pop {r3}	; 037FF42E
	bx r3	; 037FF430
	.byte 0xC0, 0x46	; 037FF434
pool_037FF434:
loc_037FF434:
	.word 0x04000501	; 037FF434

; ===== function loc_037FF438 =====
loc_037FF438:
	ldr r1,[pool_037FF440]	; 037FF438
	strb r0,[r1,#0x0]	; 037FF43A
	bx lr	; 037FF43C
	.byte 0xC0, 0x46	; 037FF440
pool_037FF440:
loc_037FF440:
	.word 0x04000500	; 037FF440
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x4A, 0x11, 0x88, 0x01, 0x20, 0x01, 0x43, 0x11, 0x80, 0x04, 0xF0	; 037FF454
	.byte 0xEF, 0xFF, 0x06, 0x48, 0x05, 0xF0, 0x4F, 0xFA, 0x05, 0x48, 0xFF, 0xF7, 0xB3, 0xFE, 0x00, 0xF0	; 037FF464
	.byte 0x2B, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x04, 0x03, 0x00, 0x04, 0x00, 0x01, 0x00, 0x00	; 037FF474
	.byte 0x80, 0xAB, 0x07, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xF0, 0x16, 0xF8, 0x80, 0x20, 0x05, 0xF0	; 037FF484
	.byte 0x3E, 0xFA, 0x07, 0x48, 0xFF, 0xF7, 0x9E, 0xFE, 0x01, 0x20, 0x04, 0xF0, 0xC3, 0xFF, 0x05, 0x4A	; 037FF494
	.byte 0x11, 0x88, 0x01, 0x20, 0x81, 0x43, 0x11, 0x80, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FF4A4
	.byte 0x00, 0x00, 0x04, 0x00, 0x04, 0x03, 0x00, 0x04, 0x02, 0x4A, 0x11, 0x78, 0x80, 0x20, 0x81, 0x43	; 037FF4B4
	.byte 0x11, 0x70, 0x70, 0x47, 0x01, 0x05, 0x00, 0x04, 0x02, 0x4A, 0x11, 0x78, 0x80, 0x20, 0x01, 0x43	; 037FF4C4
	.byte 0x11, 0x70, 0x70, 0x47, 0x01, 0x05, 0x00, 0x04	; 037FF4CC

; ===== function loc_037FF4CC =====
loc_037FF4CC:
	push {r4,lr}	; 037FF4CC
	cmp r1,#0x18	; 037FF4CE
	bge loc_037FF4E8	; 037FF4D0
	ldr r2,[pool_037FF508]	; 037FF4D2
	ldr r3,[r2,#0x0]	; 037FF4D4
	ldr r2,[pool_037FF50C]	; 037FF4D6
	sub r2,r2,r3	; 037FF4D8
	lsl r2,r2,#0x6	; 037FF4DA
	add r1,#0x28	; 037FF4DC
	mul r3,r1	; 037FF4DE
	add r1,r2,r3	; 037FF4E0
	mul r0,r1	; 037FF4E2
	asr r0,r0,#0x15	; 037FF4E4
	b loc_037FF502	; 037FF4E6
loc_037FF4E8:
	cmp r1,#0x68	; 037FF4E8
	ble loc_037FF502	; 037FF4EA
	ldr r2,[pool_037FF508]	; 037FF4EC
	ldr r4,[r2,#0x0]	; 037FF4EE
	ldr r2,[pool_037FF50C]	; 037FF4F0
	add r2,r4,r2	; 037FF4F2
	lsl r3,r2,#0x6	; 037FF4F4
	neg r2,r4	; 037FF4F6
	sub r1,#0x28	; 037FF4F8
	mul r2,r1	; 037FF4FA
	add r1,r3,r2	; 037FF4FC
	mul r0,r1	; 037FF4FE
	asr r0,r0,#0x15	; 037FF500
loc_037FF502:
	pop {r4}	; 037FF502
	pop {r3}	; 037FF504
	bx r3	; 037FF506
pool_037FF508:
loc_037FF508:
	.word 0x03805A0C	; 037FF508
pool_037FF50C:
loc_037FF50C:
	.word 0x00007FFF	; 037FF50C

; ===== function loc_037FF510 =====
loc_037FF510:
	push {r4,r5,r6,r7,lr}	; 037FF510
	sub sp,#0x4	; 037FF512
	ldr r1,[pool_037FF548]	; 037FF514
	str r0,[r1,#0x0]	; 037FF516
	mov r5,#0x0	; 037FF518
	ldr r6,[pool_037FF54C]	; 037FF51A
	ldr r7,[pool_037FF550]	; 037FF51C
loc_037FF51E:
	mov r0,#0x1	; 037FF51E
	lsl r0,r5	; 037FF520
	and r0,r7	; 037FF522
	cmp r0,#0x0	; 037FF524
	beq loc_037FF538	; 037FF526
	lsl r4,r5,#0x4	; 037FF528
	ldr r0,[pool_037FF554]	; 037FF52A
	ldrb r1,[r4,r0]	; 037FF52C
	ldrb r0,[r6,r5]	; 037FF52E
	bl loc_037FF4CC	; 037FF530
	ldr r1,[pool_037FF558]	; 037FF534
	strb r0,[r4,r1]	; 037FF536
loc_037FF538:
	add r5,r5,#0x1	; 037FF538
	cmp r5,#0x10	; 037FF53A
	blt loc_037FF51E	; 037FF53C
	add sp,#0x4	; 037FF53E
	pop {r4,r5,r6,r7}	; 037FF540
	pop {r3}	; 037FF542
	bx r3	; 037FF544
	.byte 0xC0, 0x46	; 037FF548
pool_037FF548:
loc_037FF548:
	.word 0x03805A0C	; 037FF548
pool_037FF54C:
loc_037FF54C:
	.word 0x03805A10	; 037FF54C
pool_037FF550:
loc_037FF550:
	.word 0x0000FFF5	; 037FF550
pool_037FF554:
loc_037FF554:
	.word 0x04000402	; 037FF554
pool_037FF558:
loc_037FF558:
	.word 0x04000400	; 037FF558

; ===== function loc_037FF55C =====
loc_037FF55C:
	lsl r1,r0,#0x4	; 037FF55C
	ldr r0,[pool_037FF574]	; 037FF55E
	ldrb r1,[r1,r0]	; 037FF560
	mov r0,#0x80	; 037FF562
	and r1,r0	; 037FF564
	cmp r1,#0x0	; 037FF566
	beq loc_037FF56E	; 037FF568
	mov r0,#0x1	; 037FF56A
	bx lr	; 037FF56C
loc_037FF56E:
	mov r0,#0x0	; 037FF56E
	bx lr	; 037FF570
	.byte 0xC0, 0x46	; 037FF574
pool_037FF574:
loc_037FF574:
	.word 0x04000403	; 037FF574

; ===== function loc_037FF578 =====
loc_037FF578:
	push {r4,lr}	; 037FF578
	lsl r4,r0,#0x4	; 037FF57A
	ldr r2,[pool_037FF5A8]	; 037FF57C
	strb r1,[r4,r2]	; 037FF57E
	ldr r2,[pool_037FF5AC]	; 037FF580
	ldr r2,[r2,#0x0]	; 037FF582
	cmp r2,#0x0	; 037FF584
	ble loc_037FF5A0	; 037FF586
	mov r3,#0x1	; 037FF588
	lsl r3,r0	; 037FF58A
	ldr r2,[pool_037FF5B0]	; 037FF58C
	and r3,r2	; 037FF58E
	cmp r3,#0x0	; 037FF590
	beq loc_037FF5A0	; 037FF592
	ldr r2,[pool_037FF5B4]	; 037FF594
	ldrb r0,[r2,r0]	; 037FF596
	bl loc_037FF4CC	; 037FF598
	ldr r1,[pool_037FF5B8]	; 037FF59C
	strb r0,[r4,r1]	; 037FF59E
loc_037FF5A0:
	pop {r4}	; 037FF5A0
	pop {r3}	; 037FF5A2
	bx r3	; 037FF5A4
	.byte 0xC0, 0x46	; 037FF5A8
pool_037FF5A8:
loc_037FF5A8:
	.word 0x04000402	; 037FF5A8
pool_037FF5AC:
loc_037FF5AC:
	.word 0x03805A0C	; 037FF5AC
pool_037FF5B0:
loc_037FF5B0:
	.word 0x0000FFF5	; 037FF5B0
pool_037FF5B4:
loc_037FF5B4:
	.word 0x03805A10	; 037FF5B4
pool_037FF5B8:
loc_037FF5B8:
	.word 0x04000400	; 037FF5B8

; ===== function loc_037FF5BC =====
loc_037FF5BC:
	ldr r2,[pool_037FF5C8]	; 037FF5BC
	sub r2,r2,r1	; 037FF5BE
	lsl r1,r0,#0x4	; 037FF5C0
	ldr r0,[pool_037FF5CC]	; 037FF5C2
	strh r2,[r1,r0]	; 037FF5C4
	bx lr	; 037FF5C6
pool_037FF5C8:
loc_037FF5C8:
	.word 0x00010000	; 037FF5C8
pool_037FF5CC:
loc_037FF5CC:
	.word 0x04000408	; 037FF5CC

; ===== function loc_037FF5D0 =====
loc_037FF5D0:
	push {r4,r5,lr}	; 037FF5D0
	sub sp,#0x4	; 037FF5D2
	add r5,r0,#0x0	; 037FF5D4
	add r4,r2,#0x0	; 037FF5D6
	ldr r0,[pool_037FF614]	; 037FF5D8
	strb r1,[r0,r5]	; 037FF5DA
	ldr r0,[pool_037FF618]	; 037FF5DC
	ldr r0,[r0,#0x0]	; 037FF5DE
	cmp r0,#0x0	; 037FF5E0
	ble loc_037FF600	; 037FF5E2
	mov r2,#0x1	; 037FF5E4
	lsl r2,r5	; 037FF5E6
	ldr r0,[pool_037FF61C]	; 037FF5E8
	and r2,r0	; 037FF5EA
	cmp r2,#0x0	; 037FF5EC
	beq loc_037FF600	; 037FF5EE
	lsl r2,r5,#0x4	; 037FF5F0
	ldr r0,[pool_037FF620]	; 037FF5F2
	ldrb r2,[r2,r0]	; 037FF5F4
	add r0,r1,#0x0	; 037FF5F6
	add r1,r2,#0x0	; 037FF5F8
	bl loc_037FF4CC	; 037FF5FA
	add r1,r0,#0x0	; 037FF5FE
loc_037FF600:
	lsl r2,r4,#0x8	; 037FF600
	orr r2,r1	; 037FF602
	lsl r1,r5,#0x4	; 037FF604
	ldr r0,[pool_037FF624]	; 037FF606
	strh r2,[r1,r0]	; 037FF608
	add sp,#0x4	; 037FF60A
	pop {r4,r5}	; 037FF60C
	pop {r3}	; 037FF60E
	bx r3	; 037FF610
	.byte 0xC0, 0x46	; 037FF614
pool_037FF614:
loc_037FF614:
	.word 0x03805A10	; 037FF614
pool_037FF618:
loc_037FF618:
	.word 0x03805A0C	; 037FF618
pool_037FF61C:
loc_037FF61C:
	.word 0x0000FFF5	; 037FF61C
pool_037FF620:
loc_037FF620:
	.word 0x04000402	; 037FF620
pool_037FF624:
loc_037FF624:
	.word 0x04000400	; 037FF624

; ===== function loc_037FF628 =====
loc_037FF628:
	lsl r2,r0,#0x4	; 037FF628
	ldr r0,[pool_037FF644]	; 037FF62A
	add r3,r2,r0	; 037FF62C
	ldr r2,[r3,#0x0]	; 037FF62E
	ldr r0,[pool_037FF648]	; 037FF630
	and r2,r0	; 037FF632
	mov r0,#0x1	; 037FF634
	and r1,r0	; 037FF636
	cmp r1,#0x0	; 037FF638
	beq loc_037FF640	; 037FF63A
	ldr r0,[pool_037FF64C]	; 037FF63C
	orr r2,r0	; 037FF63E
loc_037FF640:
	str r2,[r3,#0x0]	; 037FF640
	bx lr	; 037FF642
pool_037FF644:
loc_037FF644:
	.word 0x04000400	; 037FF644
pool_037FF648:
loc_037FF648:
	.word 0x7FFFFFFF	; 037FF648
pool_037FF64C:
loc_037FF64C:
	.word 0x00008000	; 037FF64C

; ===== function loc_037FF650 =====
loc_037FF650:
	push {r4,r5,r6,lr}	; 037FF650
	add r5,r2,#0x0	; 037FF652
	add r6,r3,#0x0	; 037FF654
	lsl r4,r0,#0x4	; 037FF656
	ldr r2,[pool_037FF69C]	; 037FF658
	strb r1,[r2,r0]	; 037FF65A
	ldr r2,[pool_037FF6A0]	; 037FF65C
	ldr r2,[r2,#0x0]	; 037FF65E
	cmp r2,#0x0	; 037FF660
	ble loc_037FF67A	; 037FF662
	mov r2,#0x1	; 037FF664
	lsl r2,r0	; 037FF666
	ldr r0,[pool_037FF6A4]	; 037FF668
	and r2,r0	; 037FF66A
	cmp r2,#0x0	; 037FF66C
	beq loc_037FF67A	; 037FF66E
	add r0,r1,#0x0	; 037FF670
	ldr r1,[sp,#0x10]	; 037FF672
	bl loc_037FF4CC	; 037FF674
	add r1,r0,#0x0	; 037FF678
loc_037FF67A:
	ldr r0,[sp,#0x10]	; 037FF67A
	lsl r2,r0,#0x10	; 037FF67C
	ldr r0,[pool_037FF6A8]	; 037FF67E
	orr r2,r0	; 037FF680
	lsl r0,r5,#0x8	; 037FF682
	orr r2,r0	; 037FF684
	orr r1,r2	; 037FF686
	ldr r0,[pool_037FF6AC]	; 037FF688
	str r1,[r4,r0]	; 037FF68A
	ldr r0,[pool_037FF6B0]	; 037FF68C
	sub r1,r0,r6	; 037FF68E
	ldr r0,[pool_037FF6B4]	; 037FF690
	strh r1,[r4,r0]	; 037FF692
	pop {r4,r5,r6}	; 037FF694
	pop {r3}	; 037FF696
	bx r3	; 037FF698
	.byte 0xC0, 0x46	; 037FF69C
pool_037FF69C:
loc_037FF69C:
	.word 0x03805A10	; 037FF69C
pool_037FF6A0:
loc_037FF6A0:
	.word 0x03805A0C	; 037FF6A0
pool_037FF6A4:
loc_037FF6A4:
	.word 0x0000FFF5	; 037FF6A4
pool_037FF6A8:
loc_037FF6A8:
	.word 0x60000000	; 037FF6A8
pool_037FF6AC:
loc_037FF6AC:
	.word 0x04000400	; 037FF6AC
pool_037FF6B0:
loc_037FF6B0:
	.word 0x00010000	; 037FF6B0
pool_037FF6B4:
loc_037FF6B4:
	.word 0x04000408	; 037FF6B4

; ===== function loc_037FF6B8 =====
loc_037FF6B8:
	push {r4,r5,r6,lr}	; 037FF6B8
	add r5,r1,#0x0	; 037FF6BA
	add r6,r3,#0x0	; 037FF6BC
	lsl r4,r0,#0x4	; 037FF6BE
	ldr r1,[pool_037FF708]	; 037FF6C0
	strb r2,[r1,r0]	; 037FF6C2
	ldr r1,[pool_037FF70C]	; 037FF6C4
	ldr r1,[r1,#0x0]	; 037FF6C6
	cmp r1,#0x0	; 037FF6C8
	ble loc_037FF6E2	; 037FF6CA
	mov r1,#0x1	; 037FF6CC
	lsl r1,r0	; 037FF6CE
	ldr r0,[pool_037FF710]	; 037FF6D0
	and r1,r0	; 037FF6D2
	cmp r1,#0x0	; 037FF6D4
	beq loc_037FF6E2	; 037FF6D6
	add r0,r2,#0x0	; 037FF6D8
	ldr r1,[sp,#0x14]	; 037FF6DA
	bl loc_037FF4CC	; 037FF6DC
	add r2,r0,#0x0	; 037FF6E0
loc_037FF6E2:
	lsl r0,r6,#0x8	; 037FF6E2
	lsl r3,r5,#0x18	; 037FF6E4
	ldr r1,[pool_037FF714]	; 037FF6E6
	orr r3,r1	; 037FF6E8
	ldr r1,[sp,#0x14]	; 037FF6EA
	lsl r1,r1,#0x10	; 037FF6EC
	orr r3,r1	; 037FF6EE
	orr r0,r3	; 037FF6F0
	orr r2,r0	; 037FF6F2
	ldr r0,[pool_037FF718]	; 037FF6F4
	str r2,[r4,r0]	; 037FF6F6
	ldr r1,[sp,#0x10]	; 037FF6F8
	ldr r0,[pool_037FF71C]	; 037FF6FA
	sub r1,r0,r1	; 037FF6FC
	ldr r0,[pool_037FF720]	; 037FF6FE
	strh r1,[r4,r0]	; 037FF700
	pop {r4,r5,r6}	; 037FF702
	pop {r3}	; 037FF704
	bx r3	; 037FF706
pool_037FF708:
loc_037FF708:
	.word 0x03805A10	; 037FF708
pool_037FF70C:
loc_037FF70C:
	.word 0x03805A0C	; 037FF70C
pool_037FF710:
loc_037FF710:
	.word 0x0000FFF5	; 037FF710
pool_037FF714:
loc_037FF714:
	.word 0x60000000	; 037FF714
pool_037FF718:
loc_037FF718:
	.word 0x04000400	; 037FF718
pool_037FF71C:
loc_037FF71C:
	.word 0x00010000	; 037FF71C
pool_037FF720:
loc_037FF720:
	.word 0x04000408	; 037FF720

; ===== function loc_037FF724 =====
loc_037FF724:
	push {r4,r5,r6,r7,lr}	; 037FF724
	sub sp,#0x4	; 037FF726
	add r5,r1,#0x0	; 037FF728
	add r6,r2,#0x0	; 037FF72A
	add r7,r3,#0x0	; 037FF72C
	ldr r1,[sp,#0x20]	; 037FF72E
	lsl r4,r0,#0x4	; 037FF730
	ldr r2,[pool_037FF790]	; 037FF732
	strb r1,[r2,r0]	; 037FF734
	ldr r2,[pool_037FF794]	; 037FF736
	ldr r2,[r2,#0x0]	; 037FF738
	cmp r2,#0x0	; 037FF73A
	ble loc_037FF754	; 037FF73C
	mov r2,#0x1	; 037FF73E
	lsl r2,r0	; 037FF740
	ldr r0,[pool_037FF798]	; 037FF742
	and r2,r0	; 037FF744
	cmp r2,#0x0	; 037FF746
	beq loc_037FF754	; 037FF748
	add r0,r1,#0x0	; 037FF74A
	ldr r1,[sp,#0x2c]	; 037FF74C
	bl loc_037FF4CC	; 037FF74E
	add r1,r0,#0x0	; 037FF752
loc_037FF754:
	ldr r0,[sp,#0x24]	; 037FF754
	lsl r2,r0,#0x8	; 037FF756
	ldr r0,[sp,#0x2c]	; 037FF758
	lsl r0,r0,#0x10	; 037FF75A
	lsl r3,r6,#0x1d	; 037FF75C
	lsl r6,r7,#0x1b	; 037FF75E
	orr r3,r6	; 037FF760
	orr r0,r3	; 037FF762
	orr r2,r0	; 037FF764
	orr r1,r2	; 037FF766
	ldr r0,[pool_037FF79C]	; 037FF768
	str r1,[r4,r0]	; 037FF76A
	ldr r1,[sp,#0x28]	; 037FF76C
	ldr r0,[pool_037FF7A0]	; 037FF76E
	sub r1,r0,r1	; 037FF770
	ldr r0,[pool_037FF7A4]	; 037FF772
	strh r1,[r4,r0]	; 037FF774
	ldr r1,[sp,#0x18]	; 037FF776
	ldr r0,[pool_037FF7A8]	; 037FF778
	strh r1,[r4,r0]	; 037FF77A
	ldr r1,[sp,#0x1c]	; 037FF77C
	ldr r0,[pool_037FF7AC]	; 037FF77E
	str r1,[r4,r0]	; 037FF780
	ldr r0,[pool_037FF7B0]	; 037FF782
	str r5,[r4,r0]	; 037FF784
	add sp,#0x4	; 037FF786
	pop {r4,r5,r6,r7}	; 037FF788
	pop {r3}	; 037FF78A
	bx r3	; 037FF78C
	.byte 0xC0, 0x46	; 037FF790
pool_037FF790:
loc_037FF790:
	.word 0x03805A10	; 037FF790
pool_037FF794:
loc_037FF794:
	.word 0x03805A0C	; 037FF794
pool_037FF798:
loc_037FF798:
	.word 0x0000FFF5	; 037FF798
pool_037FF79C:
loc_037FF79C:
	.word 0x04000400	; 037FF79C
pool_037FF7A0:
loc_037FF7A0:
	.word 0x00010000	; 037FF7A0
pool_037FF7A4:
loc_037FF7A4:
	.word 0x04000408	; 037FF7A4
pool_037FF7A8:
loc_037FF7A8:
	.word 0x0400040A	; 037FF7A8
pool_037FF7AC:
loc_037FF7AC:
	.word 0x0400040C	; 037FF7AC
pool_037FF7B0:
loc_037FF7B0:
	.word 0x04000404	; 037FF7B0

; ===== function loc_037FF7B4 =====
loc_037FF7B4:
	ldr r1,[pool_037FF7CC]	; 037FF7B4
	ldr r2,[r1,#0x0]	; 037FF7B6
	ldr r0,[pool_037FF7D0]	; 037FF7B8
	mul r2,r0	; 037FF7BA
	ldr r0,[pool_037FF7D4]	; 037FF7BC
	add r0,r2,r0	; 037FF7BE
	str r0,[r1,#0x0]	; 037FF7C0
	lsr r0,r0,#0x10	; 037FF7C2
	lsl r0,r0,#0x10	; 037FF7C4
	lsr r0,r0,#0x10	; 037FF7C6
	bx lr	; 037FF7C8
	.byte 0xC0, 0x46	; 037FF7CC
pool_037FF7CC:
loc_037FF7CC:
	.word 0x038052DC	; 037FF7CC
pool_037FF7D0:
loc_037FF7D0:
	.word 0x0019660D	; 037FF7D0
pool_037FF7D4:
loc_037FF7D4:
	.word 0x3C6EF35F	; 037FF7D4

; ===== function loc_037FF7D8 =====
loc_037FF7D8:
	cmp r0,#0x20	; 037FF7D8
	bge loc_037FF7E2	; 037FF7DA
	ldr r1,[pool_037FF814]	; 037FF7DC
	ldrsb r0,[r1,r0]	; 037FF7DE
	bx lr	; 037FF7E0
loc_037FF7E2:
	cmp r0,#0x40	; 037FF7E2
	bge loc_037FF7F0	; 037FF7E4
	mov r1,#0x40	; 037FF7E6
	sub r1,r1,r0	; 037FF7E8
	ldr r0,[pool_037FF814]	; 037FF7EA
	ldrsb r0,[r0,r1]	; 037FF7EC
	bx lr	; 037FF7EE
loc_037FF7F0:
	cmp r0,#0x60	; 037FF7F0
	bge loc_037FF802	; 037FF7F2
	sub r0,#0x40	; 037FF7F4
	ldr r1,[pool_037FF814]	; 037FF7F6
	ldrsb r0,[r1,r0]	; 037FF7F8
	neg r0,r0	; 037FF7FA
	lsl r0,r0,#0x18	; 037FF7FC
	asr r0,r0,#0x18	; 037FF7FE
	bx lr	; 037FF800
loc_037FF802:
	sub r0,#0x60	; 037FF802
	mov r1,#0x20	; 037FF804
	sub r1,r1,r0	; 037FF806
	ldr r0,[pool_037FF814]	; 037FF808
	ldrsb r0,[r0,r1]	; 037FF80A
	neg r0,r0	; 037FF80C
	lsl r0,r0,#0x18	; 037FF80E
	asr r0,r0,#0x18	; 037FF810
	bx lr	; 037FF812
pool_037FF814:
loc_037FF814:
	.word 0x038050FC	; 037FF814

; ===== function loc_037FF818 =====
loc_037FF818:
	push {r4,lr}	; 037FF818
	add r4,r0,#0x0	; 037FF81A
	ldr r0,[pool_037FF868]	; 037FF81C
	cmp r4,r0	; 037FF81E
	bge loc_037FF826	; 037FF820
	add r4,r0,#0x0	; 037FF822
	b loc_037FF82C	; 037FF824
loc_037FF826:
	cmp r4,#0x0	; 037FF826
	ble loc_037FF82C	; 037FF828
	mov r4,#0x0	; 037FF82A
loc_037FF82C:
	ldr r0,[pool_037FF86C]	; 037FF82C
	add r0,r4,r0	; 037FF82E
	bl loc_03804948	; 037FF830
	mov r1,#0xef	; 037FF834
	mvn r1,r1	; 037FF836
	cmp r4,r1	; 037FF838
	bge loc_037FF840	; 037FF83A
	mov r1,#0x3	; 037FF83C
	b loc_037FF85A	; 037FF83E
loc_037FF840:
	mov r1,#0x77	; 037FF840
	mvn r1,r1	; 037FF842
	cmp r4,r1	; 037FF844
	bge loc_037FF84C	; 037FF846
	mov r1,#0x2	; 037FF848
	b loc_037FF85A	; 037FF84A
loc_037FF84C:
	mov r1,#0x3b	; 037FF84C
	mvn r1,r1	; 037FF84E
	cmp r4,r1	; 037FF850
	bge loc_037FF858	; 037FF852
	mov r1,#0x1	; 037FF854
	b loc_037FF85A	; 037FF856
loc_037FF858:
	mov r1,#0x0	; 037FF858
loc_037FF85A:
	lsl r1,r1,#0x8	; 037FF85A
	orr r1,r0	; 037FF85C
	lsl r0,r1,#0x10	; 037FF85E
	lsr r0,r0,#0x10	; 037FF860
	pop {r4}	; 037FF862
	pop {r3}	; 037FF864
	bx r3	; 037FF866
pool_037FF868:
loc_037FF868:
	.word 0xFFFFFD2D	; 037FF868
pool_037FF86C:
loc_037FF86C:
	.word 0x000002D3	; 037FF86C

; ===== function loc_037FF870 =====
loc_037FF870:
	push {r4,r5,r6,lr}	; 037FF870
	add r5,r0,#0x0	; 037FF872
	mov r4,#0x0	; 037FF874
	neg r0,r1	; 037FF876
	ldr r1,[pool_037FF91C]	; 037FF878
	b loc_037FF880	; 037FF87A
loc_037FF87C:
	sub r4,r4,#0x1	; 037FF87C
	add r0,r0,r1	; 037FF87E
loc_037FF880:
	cmp r0,#0x0	; 037FF880
	blt loc_037FF87C	; 037FF882
	ldr r1,[pool_037FF91C]	; 037FF884
	b loc_037FF88C	; 037FF886
loc_037FF888:
	add r4,r4,#0x1	; 037FF888
	sub r0,r0,r1	; 037FF88A
loc_037FF88C:
	cmp r0,r1	; 037FF88C
	bge loc_037FF888	; 037FF88E
	bl loc_03804944	; 037FF890
	mov r1,#0x0	; 037FF894
	ldr r2,[pool_037FF920]	; 037FF896
	add r0,r0,r2	; 037FF898
	adc r1,r1	; 037FF89A
	asr r3,r5,#0x1f	; 037FF89C
	add r2,r5,#0x0	; 037FF89E
	bl loc_037FEC28	; 037FF8A0
	add r6,r0,#0x0	; 037FF8A4
	add r5,r1,#0x0	; 037FF8A6
	add r2,r4,#0x0	; 037FF8A8
	sub r2,#0x10	; 037FF8AA
	cmp r2,#0x0	; 037FF8AC
	bgt loc_037FF8BA	; 037FF8AE
	neg r2,r2	; 037FF8B0
	bl loc_037FF928	; 037FF8B2
	add r5,r1,#0x0	; 037FF8B6
	b loc_037FF8F6	; 037FF8B8
loc_037FF8BA:
	cmp r2,#0x20	; 037FF8BA
	bge loc_037FF8F2	; 037FF8BC
	mov r0,#0x0	; 037FF8BE
	mvn r0,r0	; 037FF8C0
	add r1,r0,#0x0	; 037FF8C2
	mov r3,#0x20	; 037FF8C4
	sub r2,r3,r2	; 037FF8C6
	bl loc_037FF934	; 037FF8C8
	add r2,r5,#0x0	; 037FF8CC
	and r2,r1	; 037FF8CE
	add r1,r6,#0x0	; 037FF8D0
	and r1,r0	; 037FF8D2
	mov r0,#0x0	; 037FF8D4
	eor r2,r0	; 037FF8D6
	eor r1,r0	; 037FF8D8
	orr r2,r1	; 037FF8DA
	beq loc_037FF8E2	; 037FF8DC
	ldr r0,[pool_037FF924]	; 037FF8DE
	b loc_037FF914	; 037FF8E0
loc_037FF8E2:
	add r0,r6,#0x0	; 037FF8E2
	add r1,r5,#0x0	; 037FF8E4
	sub r4,#0x10	; 037FF8E6
	add r2,r4,#0x0	; 037FF8E8
	bl loc_037FF934	; 037FF8EA
	add r5,r1,#0x0	; 037FF8EE
	b loc_037FF8F6	; 037FF8F0
loc_037FF8F2:
	ldr r0,[pool_037FF924]	; 037FF8F2
	b loc_037FF914	; 037FF8F4
loc_037FF8F6:
	mov r2,#0x0	; 037FF8F6
	mov r1,#0x10	; 037FF8F8
	sub r1,r0,r1	; 037FF8FA
	lsl r1,r5,#0	; 037FF8FC
	sbc r1,r2	; 037FF8FE
	bcs loc_037FF906	; 037FF900
	mov r0,#0x10	; 037FF902
	b loc_037FF910	; 037FF904
loc_037FF906:
	ldr r1,[pool_037FF924]	; 037FF906
	sub r1,r1,r0	; 037FF908
	sbc r2,r5	; 037FF90A
	bcs loc_037FF910	; 037FF90C
	ldr r0,[pool_037FF924]	; 037FF90E
loc_037FF910:
	lsl r0,r0,#0x10	; 037FF910
	lsr r0,r0,#0x10	; 037FF912
loc_037FF914:
	pop {r4,r5,r6}	; 037FF914
	pop {r3}	; 037FF916
	bx r3	; 037FF918
	.byte 0xC0, 0x46	; 037FF91C
pool_037FF91C:
loc_037FF91C:
	.word 0x00000300	; 037FF91C
pool_037FF920:
loc_037FF920:
	.word 0x00010000	; 037FF920
pool_037FF924:
loc_037FF924:
	.word 0x0000FFFF	; 037FF924

; ===== function loc_037FF928 =====
loc_037FF928:
	bx pc	; 037FF928
	.byte 0xC0, 0x46	; 037FF92C
.arm

; ===== function loc_037FF92C =====
loc_037FF92C:
	ldr pc,[pool_037FF930]	; 037FF92C
pool_037FF930:
loc_037FF930:
	.word 0x03804F94	; 037FF930
.thumb

; ===== function loc_037FF934 =====
loc_037FF934:
	bx pc	; 037FF934
	.byte 0xC0, 0x46	; 037FF938
.arm

; ===== function loc_037FF938 =====
loc_037FF938:
	ldr pc,[pool_037FF93C]	; 037FF938
pool_037FF93C:
loc_037FF93C:
	.word 0x03804B74	; 037FF93C
	.byte 0x70, 0xB5, 0x00, 0xF0, 0x7D, 0xF8, 0x00, 0xF0, 0x9D, 0xFD, 0x01, 0xF0, 0x07, 0xFE, 0x01, 0xF0	; 037FF950
	.byte 0xDD, 0xFF, 0xFF, 0xF7, 0xB3, 0xFD, 0x00, 0x20, 0x01, 0x1C, 0x02, 0x1C, 0x03, 0x1C, 0xFF, 0xF7	; 037FF960
	.byte 0x51, 0xFD, 0x7F, 0x20, 0xFF, 0xF7, 0x68, 0xFD, 0x00, 0xF0, 0x4A, 0xF8, 0x01, 0x26, 0x00, 0x24	; 037FF970
	.byte 0x25, 0x1C, 0x00, 0xF0, 0x37, 0xF8, 0x01, 0x28, 0x01, 0xD0, 0x02, 0x28, 0x00, 0xE0, 0x35, 0x1C	; 037FF980
	.byte 0x00, 0xF0, 0xE0, 0xFC, 0x02, 0xF0, 0xF2, 0xF8, 0x28, 0x1C, 0x01, 0xF0, 0xB9, 0xFD, 0x28, 0x1C	; 037FF990
	.byte 0x00, 0xF0, 0xE0, 0xFB, 0x01, 0xF0, 0xDC, 0xFE, 0xFF, 0xF7, 0x0C, 0xFF, 0xE8, 0xE7, 0x00, 0x00	; 037FF9A0
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x01, 0x21, 0x00, 0x22, 0xFE, 0xF7, 0xA9, 0xFC, 0x00, 0x28	; 037FF9B0
	.byte 0x04, 0xD1, 0x05, 0x48, 0x05, 0x49, 0x09, 0x68, 0x05, 0xF0, 0x66, 0xFB, 0x01, 0xB0, 0x08, 0xBC	; 037FF9C0
	.byte 0x18, 0x47, 0xC0, 0x46, 0x20, 0x5A, 0x80, 0x03, 0xE0, 0x52, 0x80, 0x03, 0xD8, 0x52, 0x80, 0x03	; 037FF9D0
.thumb

; ===== function loc_037FF9D0 =====
loc_037FF9D0:
	ldr r0,[pool_037FF9DC]	; 037FF9D0
	mov r1,#0x2	; 037FF9D2
	mov r2,#0x0	; 037FF9D4
	ldr r3,[pool_037FF9E0]	; 037FF9D6
	bx r3	; 037FF9D8
	.byte 0xC0, 0x46	; 037FF9DC
pool_037FF9DC:
loc_037FF9DC:
	.word 0x03805A20	; 037FF9DC
pool_037FF9E0:
loc_037FF9E0:
	.word 0x037FE301	; 037FF9E0

; ===== function loc_037FF9E4 =====
	push {lr}	; 037FF9E4
	sub sp,#0x4	; 037FF9E6
	ldr r0,[pool_037FF9FC]	; 037FF9E8
	add r1,sp,#0x0	; 037FF9EA
	mov r2,#0x1	; 037FF9EC
	bl loc_037FE288	; 037FF9EE
	ldr r0,[sp,#0x0]	; 037FF9F2
	add sp,#0x4	; 037FF9F4
	pop {r3}	; 037FF9F6
	bx r3	; 037FF9F8
	.byte 0xC0, 0x46	; 037FF9FC
pool_037FF9FC:
loc_037FF9FC:
	.word 0x03805A20	; 037FF9FC
	.byte 0x30, 0xB5, 0x83, 0xB0, 0xFE, 0xF7, 0x30, 0xFF, 0x04, 0x1C, 0x09, 0x48, 0x01, 0x90, 0x00, 0x25	; 037FFA10
	.byte 0x02, 0x95, 0x08, 0x4B, 0x00, 0x95, 0x08, 0x48, 0x08, 0x4A, 0xA4, 0x18, 0x0A, 0x00, 0x6A, 0x41	; 037FFA20
	.byte 0x21, 0x1C, 0xFF, 0xF7, 0x49, 0xF8, 0x03, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 037FFA30
	.byte 0xA1, 0xF9, 0x7F, 0x03, 0xA8, 0x0A, 0x00, 0x00, 0x54, 0x5A, 0x80, 0x03, 0x00, 0x00, 0x01, 0x00	; 037FFA40
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x05, 0x48, 0x06, 0x49, 0x08, 0x22, 0xFE, 0xF7, 0x87, 0xFC, 0x05, 0x48	; 037FFA50
	.byte 0xFF, 0xF7, 0xF0, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x20, 0x5A, 0x80, 0x03	; 037FFA60
	.byte 0x34, 0x5A, 0x80, 0x03, 0x54, 0x5A, 0x80, 0x03	; 037FFA68

; ===== function loc_037FFA68 =====
loc_037FFA68:
	push {lr}	; 037FFA68
	sub sp,#0xc	; 037FFA6A
	ldr r1,[pool_037FFA8C]	; 037FFA6C
	str r1,[sp,#0x0]	; 037FFA6E
	str r0,[sp,#0x4]	; 037FFA70
	ldr r0,[pool_037FFA90]	; 037FFA72
	ldr r1,[pool_037FFA94]	; 037FFA74
	mov r2,#0x0	; 037FFA76
	ldr r3,[pool_037FFA98]	; 037FFA78
	bl loc_037FDFCC	; 037FFA7A
	ldr r0,[pool_037FFA90]	; 037FFA7E
	bl loc_037FDEE0	; 037FFA80
	add sp,#0xc	; 037FFA84
	pop {r3}	; 037FFA86
	bx r3	; 037FFA88
	.byte 0xC0, 0x46	; 037FFA8C
pool_037FFA8C:
loc_037FFA8C:
	.word 0x00000400	; 037FFA8C
pool_037FFA90:
loc_037FFA90:
	.word 0x03805A80	; 037FFA90
pool_037FFA94:
loc_037FFA94:
	.word 0x037FF941	; 037FFA94
pool_037FFA98:
loc_037FFA98:
	.word 0x03805EF8	; 037FFA98

; ===== function loc_037FFA9C =====
loc_037FFA9C:
	push {r4,lr}	; 037FFA9C
	add r4,r0,#0x0	; 037FFA9E
	bl loc_03801E24	; 037FFAA0
	add r0,r4,#0x0	; 037FFAA4
	bl loc_037FFA68	; 037FFAA6
	pop {r4}	; 037FFAAA
	pop {r3}	; 037FFAAC
	bx r3	; 037FFAAE

; ===== function loc_037FFAB0 =====
loc_037FFAB0:
	ldr r1,[pool_037FFAC4]	; 037FFAB0
	ldrb r1,[r0,r1]	; 037FFAB2
	mov r0,#0x80	; 037FFAB4
	and r1,r0	; 037FFAB6
	cmp r1,#0x0	; 037FFAB8
	beq loc_037FFAC0	; 037FFABA
	mov r0,#0x1	; 037FFABC
	bx lr	; 037FFABE
loc_037FFAC0:
	mov r0,#0x0	; 037FFAC0
	bx lr	; 037FFAC2
pool_037FFAC4:
loc_037FFAC4:
	.word 0x04000508	; 037FFAC4

; ===== function loc_037FFAC8 =====
loc_037FFAC8:
	push {r4,r5,r6,r7,lr}	; 037FFAC8
	sub sp,#0x4	; 037FFACA
	add r4,r0,#0x0	; 037FFACC
	add r0,r2,#0x0	; 037FFACE
	add r6,r3,#0x0	; 037FFAD0
	lsl r3,r4,#0x3	; 037FFAD2
	ldr r2,[sp,#0x18]	; 037FFAD4
	cmp r2,#0x0	; 037FFAD6
	beq loc_037FFADE	; 037FFAD8
	mov r5,#0x0	; 037FFADA
	b loc_037FFAE0	; 037FFADC
loc_037FFADE:
	mov r5,#0x1	; 037FFADE
loc_037FFAE0:
	ldr r2,[sp,#0x20]	; 037FFAE0
	ldr r7,[sp,#0x1c]	; 037FFAE2
	lsl r7,r7,#0x1	; 037FFAE4
	lsl r1,r1,#0x3	; 037FFAE6
	lsl r5,r5,#0x2	; 037FFAE8
	orr r1,r5	; 037FFAEA
	orr r7,r1	; 037FFAEC
	orr r2,r7	; 037FFAEE
	ldr r1,[pool_037FFB04]	; 037FFAF0
	strb r2,[r4,r1]	; 037FFAF2
	ldr r1,[pool_037FFB08]	; 037FFAF4
	str r0,[r3,r1]	; 037FFAF6
	ldr r0,[pool_037FFB0C]	; 037FFAF8
	strh r6,[r3,r0]	; 037FFAFA
	add sp,#0x4	; 037FFAFC
	pop {r4,r5,r6,r7}	; 037FFAFE
	pop {r3}	; 037FFB00
	bx r3	; 037FFB02
pool_037FFB04:
loc_037FFB04:
	.word 0x04000508	; 037FFB04
pool_037FFB08:
loc_037FFB08:
	.word 0x04000510	; 037FFB08
pool_037FFB0C:
loc_037FFB0C:
	.word 0x04000514	; 037FFB0C

; ===== function loc_037FFB10 =====
loc_037FFB10:
	push {r4,r5,r6,r7,lr}	; 037FFB10
	sub sp,#0x4	; 037FFB12
	add r5,r0,#0x0	; 037FFB14
	add r6,r1,#0x0	; 037FFB16
	add r0,#0x28	; 037FFB18
	bl loc_037FFD68	; 037FFB1A
	add r4,r0,#0x0	; 037FFB1E
	asr r3,r4,#0x1f	; 037FFB20
	mov r2,#0x0	; 037FFB22
	add r1,r3,#0x0	; 037FFB24
	eor r1,r2	; 037FFB26
	add r7,r4,#0x0	; 037FFB28
	eor r7,r2	; 037FFB2A
	orr r1,r7	; 037FFB2C
	beq loc_037FFB6C	; 037FFB2E
	add r1,r5,#0x0	; 037FFB30
	add r1,#0x28	; 037FFB32
	ldrb r1,[r1,#0x0]	; 037FFB34
	cmp r1,#0x0	; 037FFB36
	beq loc_037FFB54	; 037FFB38
	cmp r1,#0x1	; 037FFB3A
	beq loc_037FFB44	; 037FFB3C
	cmp r1,#0x2	; 037FFB3E
	beq loc_037FFB5E	; 037FFB40
	b loc_037FFB66	; 037FFB42
loc_037FFB44:
	add r1,r3,#0x0	; 037FFB44
	mov r2,#0x3c	; 037FFB46
	mov r3,#0x0	; 037FFB48
	bl loc_037FFB84	; 037FFB4A
	add r4,r0,#0x0	; 037FFB4E
	add r3,r1,#0x0	; 037FFB50
	b loc_037FFB66	; 037FFB52
loc_037FFB54:
	lsr r0,r4,#0x1a	; 037FFB54
	lsl r3,r3,#0x6	; 037FFB56
	orr r3,r0	; 037FFB58
	lsl r4,r4,#0x6	; 037FFB5A
	b loc_037FFB66	; 037FFB5C
loc_037FFB5E:
	lsr r0,r4,#0x1a	; 037FFB5E
	lsl r3,r3,#0x6	; 037FFB60
	orr r3,r0	; 037FFB62
	lsl r4,r4,#0x6	; 037FFB64
loc_037FFB66:
	lsl r0,r3,#0x12	; 037FFB66
	lsr r4,r4,#0xe	; 037FFB68
	orr r4,r0	; 037FFB6A
loc_037FFB6C:
	cmp r6,#0x0	; 037FFB6C
	beq loc_037FFB78	; 037FFB6E
	add r5,#0x28	; 037FFB70
	add r0,r5,#0x0	; 037FFB72
	bl loc_037FFD9C	; 037FFB74
loc_037FFB78:
	add r0,r4,#0x0	; 037FFB78
	add sp,#0x4	; 037FFB7A
	pop {r4,r5,r6,r7}	; 037FFB7C
	pop {r3}	; 037FFB7E
	bx r3	; 037FFB80
	.byte 0xC0, 0x46	; 037FFB84

; ===== function loc_037FFB84 =====
loc_037FFB84:
	bx pc	; 037FFB84
	.byte 0xC0, 0x46	; 037FFB88
.arm

; ===== function loc_037FFB88 =====
loc_037FFB88:
	ldr pc,[pool_037FFB8C]	; 037FFB88
pool_037FFB8C:
loc_037FFB8C:
	.word 0x03804B54	; 037FFB8C
.thumb

; ===== function loc_037FFB90 =====
loc_037FFB90:
	push {r4,r5,r6,lr}	; 037FFB90
	add r5,r0,#0x0	; 037FFB92
	add r6,r1,#0x0	; 037FFB94
	mov r0,#0x32	; 037FFB96
	ldrsh r0,[r5,r0]	; 037FFB98
	cmp r0,#0x0	; 037FFB9A
	bne loc_037FFBA2	; 037FFB9C
	mov r0,#0x0	; 037FFB9E
	b loc_037FFBCC	; 037FFBA0
loc_037FFBA2:
	ldr r2,[r5,#0x14]	; 037FFBA2
	ldr r4,[r5,#0x18]	; 037FFBA4
	cmp r2,r4	; 037FFBA6
	blt loc_037FFBAE	; 037FFBA8
	mov r0,#0x0	; 037FFBAA
	b loc_037FFBCC	; 037FFBAC
loc_037FFBAE:
	asr r1,r0,#0x1f	; 037FFBAE
	sub r2,r4,r2	; 037FFBB0
	asr r3,r2,#0x1f	; 037FFBB2
	bl loc_037FFB84	; 037FFBB4
	asr r3,r4,#0x1f	; 037FFBB8
	add r2,r4,#0x0	; 037FFBBA
	bl loc_037FFBD4	; 037FFBBC
	cmp r6,#0x0	; 037FFBC0
	beq loc_037FFBCC	; 037FFBC2
	add r5,#0x14	; 037FFBC4
	ldr r1,[r5,#0x0]	; 037FFBC6
	add r1,r1,#0x1	; 037FFBC8
	str r1,[r5,#0x0]	; 037FFBCA
loc_037FFBCC:
	pop {r4,r5,r6}	; 037FFBCC
	pop {r3}	; 037FFBCE
	bx r3	; 037FFBD0
	.byte 0xC0, 0x46	; 037FFBD4

; ===== function loc_037FFBD4 =====
loc_037FFBD4:
	bx pc	; 037FFBD4
	.byte 0xC0, 0x46	; 037FFBD8
.arm

; ===== function loc_037FFBD8 =====
loc_037FFBD8:
	ldr pc,[pool_037FFBDC]	; 037FFBD8
pool_037FFBDC:
loc_037FFBDC:
	.word 0x038049A4	; 037FFBDC
.thumb

; ===== function loc_037FFBE0 =====
loc_037FFBE0:
	push {r4,lr}	; 037FFBE0
	cmp r1,#0x0	; 037FFBE2
	beq loc_037FFC4C	; 037FFBE4
	ldrb r1,[r0,#0x2]	; 037FFBE6
	cmp r1,#0x3	; 037FFBE8
	bhi loc_037FFC4C	; 037FFBEA
	add r1,r1,r1	; 037FFBEC
	add r1,pc	; 037FFBEE
	ldrh r1,[r1,#0x8]	; 037FFBF0
	lsl r1,r1,#0x10	; 037FFBF2
	asr r1,r1,#0x10	; 037FFBF4
	add r1,pc	; 037FFBF6
	bx r1	; 037FFBF8
	.byte 0x09, 0x00, 0x23, 0x00, 0x53, 0x00, 0x47, 0x00	; 037FFC02
loc_037FFC02:
	ldr r1,[r0,#0x10]	; 037FFC02
	neg r2,r1	; 037FFC04
	ldrb r1,[r0,#0x1c]	; 037FFC06
	mul r2,r1	; 037FFC08
	asr r1,r2,#0x8	; 037FFC0A
	neg r1,r1	; 037FFC0C
	str r1,[r0,#0x10]	; 037FFC0E
	ldr r1,[r0,#0x10]	; 037FFC10
	cmp r1,#0x0	; 037FFC12
	bne loc_037FFC4C	; 037FFC14
	mov r1,#0x1	; 037FFC16
	strb r1,[r0,#0x2]	; 037FFC18
	b loc_037FFC4C	; 037FFC1A
loc_037FFC1C:
	ldrb r1,[r0,#0x1d]	; 037FFC1C
	lsl r2,r1,#0x1	; 037FFC1E
	ldr r1,[pool_037FFC58]	; 037FFC20
	ldrsh r1,[r1,r2]	; 037FFC22
	lsl r4,r1,#0x7	; 037FFC24
	add r3,r0,#0x0	; 037FFC26
	add r3,#0x10	; 037FFC28
	ldr r2,[r3,#0x0]	; 037FFC2A
	ldrh r1,[r0,#0x1e]	; 037FFC2C
	sub r1,r2,r1	; 037FFC2E
	str r1,[r3,#0x0]	; 037FFC30
	ldr r1,[r0,#0x10]	; 037FFC32
	cmp r1,r4	; 037FFC34
	bgt loc_037FFC4C	; 037FFC36
	str r4,[r0,#0x10]	; 037FFC38
	mov r1,#0x2	; 037FFC3A
	strb r1,[r0,#0x2]	; 037FFC3C
	b loc_037FFC4C	; 037FFC3E
loc_037FFC40:
	add r3,r0,#0x0	; 037FFC40
	add r3,#0x10	; 037FFC42
	ldr r2,[r3,#0x0]	; 037FFC44
	ldrh r1,[r0,#0x20]	; 037FFC46
	sub r1,r2,r1	; 037FFC48
	str r1,[r3,#0x0]	; 037FFC4A
loc_037FFC4C:
	ldr r0,[r0,#0x10]	; 037FFC4C
	asr r0,r0,#0x7	; 037FFC4E
	pop {r4}	; 037FFC50
	pop {r3}	; 037FFC52
	bx r3	; 037FFC54
	.byte 0xC0, 0x46	; 037FFC58
pool_037FFC58:
loc_037FFC58:
	.word 0x03805120	; 037FFC58

; ===== function loc_037FFC5C =====
loc_037FFC5C:
	push {r4,r5,lr}	; 037FFC5C
	sub sp,#0x4	; 037FFC5E
	ldrh r5,[r0,#0x24]	; 037FFC60
	mov r0,#0xff	; 037FFC62
	add r2,r5,#0x0	; 037FFC64
	and r2,r0	; 037FFC66
	ldrh r4,[r1,#0x24]	; 037FFC68
	add r1,r4,#0x0	; 037FFC6A
	and r1,r0	; 037FFC6C
	lsl r3,r2,#0x4	; 037FFC6E
	lsl r2,r1,#0x4	; 037FFC70
	asr r0,r5,#0x8	; 037FFC72
	ldr r1,[pool_037FFC9C]	; 037FFC74
	ldrb r0,[r1,r0]	; 037FFC76
	asr r3,r0	; 037FFC78
	asr r0,r4,#0x8	; 037FFC7A
	ldrb r0,[r1,r0]	; 037FFC7C
	asr r2,r0	; 037FFC7E
	cmp r3,r2	; 037FFC80
	beq loc_037FFC92	; 037FFC82
	cmp r3,r2	; 037FFC84
	bge loc_037FFC8C	; 037FFC86
	mov r0,#0x1	; 037FFC88
	b loc_037FFC94	; 037FFC8A
loc_037FFC8C:
	mov r0,#0x0	; 037FFC8C
	mvn r0,r0	; 037FFC8E
	b loc_037FFC94	; 037FFC90
loc_037FFC92:
	mov r0,#0x0	; 037FFC92
loc_037FFC94:
	add sp,#0x4	; 037FFC94
	pop {r4,r5}	; 037FFC96
	pop {r3}	; 037FFC98
	bx r3	; 037FFC9A
pool_037FFC9C:
loc_037FFC9C:
	.word 0x03805220	; 037FFC9C

; ===== function loc_037FFCA0 =====
loc_037FFCA0:
	push {lr}	; 037FFCA0
	sub sp,#0x4	; 037FFCA2
	add r2,r0,#0x0	; 037FFCA4
	cmp r2,#0x7f	; 037FFCA6
	bne loc_037FFCAE	; 037FFCA8
	ldr r0,[pool_037FFCD8]	; 037FFCAA
	b loc_037FFCD2	; 037FFCAC
loc_037FFCAE:
	cmp r2,#0x7e	; 037FFCAE
	bne loc_037FFCB6	; 037FFCB0
	ldr r0,[pool_037FFCDC]	; 037FFCB2
	b loc_037FFCD2	; 037FFCB4
loc_037FFCB6:
	cmp r2,#0x32	; 037FFCB6
	bge loc_037FFCC4	; 037FFCB8
	lsl r0,r2,#0x1	; 037FFCBA
	add r0,r0,#0x1	; 037FFCBC
	lsl r0,r0,#0x10	; 037FFCBE
	lsr r0,r0,#0x10	; 037FFCC0
	b loc_037FFCD2	; 037FFCC2
loc_037FFCC4:
	ldr r0,[pool_037FFCE0]	; 037FFCC4
	mov r1,#0x7e	; 037FFCC6
	sub r1,r1,r2	; 037FFCC8
	bl loc_037FE2F4	; 037FFCCA
	lsl r0,r0,#0x10	; 037FFCCE
	lsr r0,r0,#0x10	; 037FFCD0
loc_037FFCD2:
	add sp,#0x4	; 037FFCD2
	pop {r3}	; 037FFCD4
	bx r3	; 037FFCD6
pool_037FFCD8:
loc_037FFCD8:
	.word 0x0000FFFF	; 037FFCD8
pool_037FFCDC:
loc_037FFCDC:
	.word 0x00003C00	; 037FFCDC
pool_037FFCE0:
loc_037FFCE0:
	.word 0x00001E00	; 037FFCE0

; ===== function loc_037FFCE4 =====
loc_037FFCE4:
	push {r4,lr}	; 037FFCE4
	add r4,r0,#0x0	; 037FFCE6
	ldr r0,[pool_037FFD14]	; 037FFCE8
	str r0,[r4,#0x10]	; 037FFCEA
	mov r0,#0x0	; 037FFCEC
	strb r0,[r4,#0x2]	; 037FFCEE
	str r1,[r4,#0x34]	; 037FFCF0
	add r0,r4,#0x0	; 037FFCF2
	add r0,#0x28	; 037FFCF4
	bl loc_037FFDE0	; 037FFCF6
	add r2,r4,#0x3	; 037FFCFA
	ldrb r1,[r2,#0x0]	; 037FFCFC
	mov r0,#0x2	; 037FFCFE
	orr r1,r0	; 037FFD00
	strb r1,[r2,#0x0]	; 037FFD02
	ldrb r1,[r2,#0x0]	; 037FFD04
	mov r0,#0x1	; 037FFD06
	bic r1,r0	; 037FFD08
	orr r1,r0	; 037FFD0A
	strb r1,[r2,#0x0]	; 037FFD0C
	pop {r4}	; 037FFD0E
	pop {r3}	; 037FFD10
	bx r3	; 037FFD12
pool_037FFD14:
loc_037FFD14:
	.word 0xFFFE9680	; 037FFD14

; ===== function loc_037FFD18 =====
loc_037FFD18:
	push {r4,r5,lr}	; 037FFD18
	sub sp,#0x4	; 037FFD1A
	mov r4,#0x0	; 037FFD1C
	str r4,[r0,#0x50]	; 037FFD1E
	str r1,[r0,#0x48]	; 037FFD20
	str r2,[r0,#0x4c]	; 037FFD22
	str r4,[r0,#0x34]	; 037FFD24
	add r1,r0,#0x0	; 037FFD26
	add r1,#0x22	; 037FFD28
	strb r3,[r1,#0x0]	; 037FFD2A
	mov r5,#0x7f	; 037FFD2C
	strh r5,[r0,#0x24]	; 037FFD2E
	add r3,r0,#0x3	; 037FFD30
	ldrb r2,[r3,#0x0]	; 037FFD32
	mov r1,#0x2	; 037FFD34
	bic r2,r1	; 037FFD36
	strb r2,[r3,#0x0]	; 037FFD38
	mov r1,#0x3c	; 037FFD3A
	strb r1,[r0,#0x8]	; 037FFD3C
	strb r1,[r0,#0x5]	; 037FFD3E
	strb r5,[r0,#0x9]	; 037FFD40
	strb r4,[r0,#0xa]	; 037FFD42
	strh r4,[r0,#0xc]	; 037FFD44
	strh r4,[r0,#0xe]	; 037FFD46
	strb r4,[r0,#0xb]	; 037FFD48
	strh r4,[r0,#0x32]	; 037FFD4A
	str r4,[r0,#0x18]	; 037FFD4C
	str r4,[r0,#0x14]	; 037FFD4E
	strb r5,[r0,#0x1c]	; 037FFD50
	strh r5,[r0,#0x1e]	; 037FFD52
	strb r5,[r0,#0x1d]	; 037FFD54
	strh r5,[r0,#0x20]	; 037FFD56
	add r0,#0x28	; 037FFD58
	bl loc_037FFDE8	; 037FFD5A
	add sp,#0x4	; 037FFD5E
	pop {r4,r5}	; 037FFD60
	pop {r3}	; 037FFD62
	bx r3	; 037FFD64
	.byte 0x00, 0x00	; 037FFD68

; ===== function loc_037FFD68 =====
loc_037FFD68:
	push {r4,lr}	; 037FFD68
	add r4,r0,#0x0	; 037FFD6A
	ldrb r0,[r4,#0x2]	; 037FFD6C
	cmp r0,#0x0	; 037FFD6E
	bne loc_037FFD76	; 037FFD70
	mov r0,#0x0	; 037FFD72
	b loc_037FFD94	; 037FFD74
loc_037FFD76:
	ldrh r1,[r4,#0x6]	; 037FFD76
	ldrh r0,[r4,#0x4]	; 037FFD78
	cmp r1,r0	; 037FFD7A
	bcs loc_037FFD82	; 037FFD7C
	mov r2,#0x0	; 037FFD7E
	b loc_037FFD92	; 037FFD80
loc_037FFD82:
	ldrh r0,[r4,#0x8]	; 037FFD82
	lsr r0,r0,#0x8	; 037FFD84
	bl loc_037FF7D8	; 037FFD86
	ldrb r2,[r4,#0x3]	; 037FFD8A
	ldrb r1,[r4,#0x2]	; 037FFD8C
	mul r1,r0	; 037FFD8E
	mul r2,r1	; 037FFD90
loc_037FFD92:
	add r0,r2,#0x0	; 037FFD92
loc_037FFD94:
	pop {r4}	; 037FFD94
	pop {r3}	; 037FFD96
	bx r3	; 037FFD98
	.byte 0x00, 0x00	; 037FFD9C

; ===== function loc_037FFD9C =====
loc_037FFD9C:
	push {r4,lr}	; 037FFD9C
	ldrh r2,[r0,#0x6]	; 037FFD9E
	ldrh r1,[r0,#0x4]	; 037FFDA0
	cmp r2,r1	; 037FFDA2
	bcs loc_037FFDB0	; 037FFDA4
	add r1,r0,#0x6	; 037FFDA6
	ldrh r0,[r1,#0x0]	; 037FFDA8
	add r0,r0,#0x1	; 037FFDAA
	strh r0,[r1,#0x0]	; 037FFDAC
	b loc_037FFDDA	; 037FFDAE
loc_037FFDB0:
	ldrh r2,[r0,#0x8]	; 037FFDB0
	ldrb r1,[r0,#0x1]	; 037FFDB2
	lsl r3,r1,#0x6	; 037FFDB4
	add r1,r2,r3	; 037FFDB6
	lsr r4,r1,#0x8	; 037FFDB8
	b loc_037FFDBE	; 037FFDBA
loc_037FFDBC:
	sub r4,#0x80	; 037FFDBC
loc_037FFDBE:
	cmp r4,#0x80	; 037FFDBE
	bcs loc_037FFDBC	; 037FFDC0
	add r0,#0x8	; 037FFDC2
	ldrh r1,[r0,#0x0]	; 037FFDC4
	add r1,r1,r3	; 037FFDC6
	strh r1,[r0,#0x0]	; 037FFDC8
	ldrh r2,[r0,#0x0]	; 037FFDCA
	mov r1,#0xff	; 037FFDCC
	and r2,r1	; 037FFDCE
	strh r2,[r0,#0x0]	; 037FFDD0
	ldrh r2,[r0,#0x0]	; 037FFDD2
	lsl r1,r4,#0x8	; 037FFDD4
	orr r2,r1	; 037FFDD6
	strh r2,[r0,#0x0]	; 037FFDD8
loc_037FFDDA:
	pop {r4}	; 037FFDDA
	pop {r3}	; 037FFDDC
	bx r3	; 037FFDDE

; ===== function loc_037FFDE0 =====
loc_037FFDE0:
	mov r1,#0x0	; 037FFDE0
	strh r1,[r0,#0x8]	; 037FFDE2
	strh r1,[r0,#0x6]	; 037FFDE4
	bx lr	; 037FFDE6

; ===== function loc_037FFDE8 =====
loc_037FFDE8:
	mov r2,#0x0	; 037FFDE8
	strb r2,[r0,#0x0]	; 037FFDEA
	strb r2,[r0,#0x2]	; 037FFDEC
	mov r1,#0x1	; 037FFDEE
	strb r1,[r0,#0x3]	; 037FFDF0
	mov r1,#0x10	; 037FFDF2
	strb r1,[r0,#0x1]	; 037FFDF4
	strh r2,[r0,#0x4]	; 037FFDF6
	bx lr	; 037FFDF8
	.byte 0x00, 0x00	; 037FFDFC

; ===== function loc_037FFDFC =====
loc_037FFDFC:
	push {r4,r5,r6,r7,lr}	; 037FFDFC
	sub sp,#0x4	; 037FFDFE
	add r5,r0,#0x0	; 037FFE00
	add r6,r1,#0x0	; 037FFE02
	mov r4,#0x0	; 037FFE04
	add r7,r4,#0x0	; 037FFE06
loc_037FFE08:
	add r1,r4,#0x0	; 037FFE08
	mov r0,#0x54	; 037FFE0A
	mul r1,r0	; 037FFE0C
	ldr r0,[pool_037FFE48]	; 037FFE0E
	add r1,r0,r1	; 037FFE10
	ldrb r0,[r1,#0x1]	; 037FFE12
	cmp r0,#0x0	; 037FFE14
	bne loc_037FFE34	; 037FFE16
	ldr r0,[r1,#0x44]	; 037FFE18
	cmp r5,r0	; 037FFE1A
	bhi loc_037FFE34	; 037FFE1C
	cmp r0,r6	; 037FFE1E
	bhi loc_037FFE34	; 037FFE20
	add r2,r1,#0x3	; 037FFE22
	ldrb r1,[r2,#0x0]	; 037FFE24
	mov r0,#0x2	; 037FFE26
	bic r1,r0	; 037FFE28
	strb r1,[r2,#0x0]	; 037FFE2A
	add r0,r4,#0x0	; 037FFE2C
	add r1,r7,#0x0	; 037FFE2E
	bl loc_037FF628	; 037FFE30
loc_037FFE34:
	add r0,r4,#0x1	; 037FFE34
	lsl r0,r0,#0x18	; 037FFE36
	lsr r4,r0,#0x18	; 037FFE38
	cmp r4,#0x10	; 037FFE3A
	bcc loc_037FFE08	; 037FFE3C
	add sp,#0x4	; 037FFE3E
	pop {r4,r5,r6,r7}	; 037FFE40
	pop {r3}	; 037FFE42
	bx r3	; 037FFE44
	.byte 0xC0, 0x46	; 037FFE48
pool_037FFE48:
loc_037FFE48:
	.word 0x03805F1C	; 037FFE48

; ===== function loc_037FFE4C =====
loc_037FFE4C:
	mov r2,#0x1	; 037FFE4C
	and r1,r2	; 037FFE4E
	cmp r1,#0x0	; 037FFE50
	beq loc_037FFE5E	; 037FFE52
	ldr r1,[pool_037FFE68]	; 037FFE54
	ldr r2,[r1,#0x0]	; 037FFE56
	bic r2,r0	; 037FFE58
	str r2,[r1,#0x0]	; 037FFE5A
	bx lr	; 037FFE5C
loc_037FFE5E:
	ldr r1,[pool_037FFE6C]	; 037FFE5E
	ldr r2,[r1,#0x0]	; 037FFE60
	bic r2,r0	; 037FFE62
	str r2,[r1,#0x0]	; 037FFE64
	bx lr	; 037FFE66
pool_037FFE68:
loc_037FFE68:
	.word 0x03805EF8	; 037FFE68
pool_037FFE6C:
loc_037FFE6C:
	.word 0x03805EFC	; 037FFE6C

; ===== function loc_037FFE70 =====
loc_037FFE70:
	push {r4,r5,r6,r7,lr}	; 037FFE70
	sub sp,#0x14	; 037FFE72
	add r7,r0,#0x0	; 037FFE74
	str r1,[sp,#0x0]	; 037FFE76
	add r6,r7,#0x0	; 037FFE78
	mov r4,#0x0	; 037FFE7A
	str r4,[sp,#0x4]	; 037FFE7C
	str r4,[sp,#0x8]	; 037FFE7E
	str r4,[sp,#0xc]	; 037FFE80
	str r4,[sp,#0x10]	; 037FFE82
	b loc_037FFEE0	; 037FFE84
loc_037FFE86:
	add r1,r6,#0x0	; 037FFE86
	mov r0,#0x1	; 037FFE88
	and r1,r0	; 037FFE8A
	cmp r1,#0x0	; 037FFE8C
	beq loc_037FFEDC	; 037FFE8E
	add r1,r4,#0x0	; 037FFE90
	mov r0,#0x54	; 037FFE92
	mul r1,r0	; 037FFE94
	ldr r0,[pool_037FFF10]	; 037FFE96
	add r5,r0,r1	; 037FFE98
	ldr r0,[pool_037FFF14]	; 037FFE9A
	ldr r1,[r0,#0x0]	; 037FFE9C
	mov r0,#0x1	; 037FFE9E
	lsl r0,r4	; 037FFEA0
	and r1,r0	; 037FFEA2
	cmp r1,#0x0	; 037FFEA4
	bne loc_037FFEDC	; 037FFEA6
	ldr r3,[r5,#0x48]	; 037FFEA8
	cmp r3,#0x0	; 037FFEAA
	beq loc_037FFEB8	; 037FFEAC
	add r0,r5,#0x0	; 037FFEAE
	ldr r1,[sp,#0x4]	; 037FFEB0
	ldr r2,[r5,#0x4c]	; 037FFEB2
	bl loc_03805090	; 037FFEB4
loc_037FFEB8:
	add r0,r4,#0x0	; 037FFEB8
	ldr r1,[sp,#0x8]	; 037FFEBA
	bl loc_037FF628	; 037FFEBC
	add r1,r5,#0x0	; 037FFEC0
	add r1,#0x22	; 037FFEC2
	ldr r0,[sp,#0xc]	; 037FFEC4
	strb r0,[r1,#0x0]	; 037FFEC6
	add r0,r5,#0x0	; 037FFEC8
	bl loc_037FFFA0	; 037FFECA
	ldr r0,[sp,#0x10]	; 037FFECE
	strb r0,[r5,#0x4]	; 037FFED0
	add r2,r5,#0x3	; 037FFED2
	ldrb r1,[r2,#0x0]	; 037FFED4
	mov r0,#0x1	; 037FFED6
	bic r1,r0	; 037FFED8
	strb r1,[r2,#0x0]	; 037FFEDA
loc_037FFEDC:
	add r4,r4,#0x1	; 037FFEDC
	lsr r6,r6,#0x1	; 037FFEDE
loc_037FFEE0:
	cmp r4,#0x10	; 037FFEE0
	bge loc_037FFEE8	; 037FFEE2
	cmp r6,#0x0	; 037FFEE4
	bne loc_037FFE86	; 037FFEE6
loc_037FFEE8:
	mov r1,#0x1	; 037FFEE8
	ldr r0,[sp,#0x0]	; 037FFEEA
	and r0,r1	; 037FFEEC
	str r0,[sp,#0x0]	; 037FFEEE
	cmp r0,#0x0	; 037FFEF0
	beq loc_037FFEFE	; 037FFEF2
	ldr r0,[pool_037FFF18]	; 037FFEF4
	ldr r1,[r0,#0x0]	; 037FFEF6
	orr r1,r7	; 037FFEF8
	str r1,[r0,#0x0]	; 037FFEFA
	b loc_037FFF06	; 037FFEFC
loc_037FFEFE:
	ldr r0,[pool_037FFF14]	; 037FFEFE
	ldr r1,[r0,#0x0]	; 037FFF00
	orr r1,r7	; 037FFF02
	str r1,[r0,#0x0]	; 037FFF04
loc_037FFF06:
	add sp,#0x14	; 037FFF06
	pop {r4,r5,r6,r7}	; 037FFF08
	pop {r3}	; 037FFF0A
	bx r3	; 037FFF0C
	.byte 0xC0, 0x46	; 037FFF10
pool_037FFF10:
loc_037FFF10:
	.word 0x03805F1C	; 037FFF10
pool_037FFF14:
loc_037FFF14:
	.word 0x03805EFC	; 037FFF14
pool_037FFF18:
loc_037FFF18:
	.word 0x03805EF8	; 037FFF18

; ===== function loc_037FFF1C =====
loc_037FFF1C:
	push {r4,r5,r6,r7,lr}	; 037FFF1C
	sub sp,#0xc	; 037FFF1E
	add r6,r0,#0x0	; 037FFF20
	mov r4,#0x0	; 037FFF22
	str r4,[sp,#0x0]	; 037FFF24
	str r4,[sp,#0x4]	; 037FFF26
	add r7,r4,#0x0	; 037FFF28
	str r4,[sp,#0x8]	; 037FFF2A
	b loc_037FFF86	; 037FFF2C
loc_037FFF2E:
	add r1,r6,#0x0	; 037FFF2E
	mov r0,#0x1	; 037FFF30
	and r1,r0	; 037FFF32
	cmp r1,#0x0	; 037FFF34
	beq loc_037FFF82	; 037FFF36
	add r1,r4,#0x0	; 037FFF38
	mov r0,#0x54	; 037FFF3A
	mul r1,r0	; 037FFF3C
	ldr r0,[pool_037FFF98]	; 037FFF3E
	add r5,r0,r1	; 037FFF40
	ldr r0,[pool_037FFF9C]	; 037FFF42
	ldr r1,[r0,#0x0]	; 037FFF44
	mov r0,#0x1	; 037FFF46
	lsl r0,r4	; 037FFF48
	and r1,r0	; 037FFF4A
	cmp r1,#0x0	; 037FFF4C
	bne loc_037FFF82	; 037FFF4E
	ldr r3,[r5,#0x48]	; 037FFF50
	cmp r3,#0x0	; 037FFF52
	beq loc_037FFF60	; 037FFF54
	add r0,r5,#0x0	; 037FFF56
	ldr r1,[sp,#0x0]	; 037FFF58
	ldr r2,[r5,#0x4c]	; 037FFF5A
	bl loc_03805090	; 037FFF5C
loc_037FFF60:
	add r0,r4,#0x0	; 037FFF60
	ldr r1,[sp,#0x4]	; 037FFF62
	bl loc_037FF628	; 037FFF64
	add r0,r5,#0x0	; 037FFF68
	add r0,#0x22	; 037FFF6A
	strb r7,[r0,#0x0]	; 037FFF6C
	add r0,r5,#0x0	; 037FFF6E
	bl loc_037FFFA0	; 037FFF70
	ldr r0,[sp,#0x8]	; 037FFF74
	strb r0,[r5,#0x4]	; 037FFF76
	add r2,r5,#0x3	; 037FFF78
	ldrb r1,[r2,#0x0]	; 037FFF7A
	mov r0,#0x1	; 037FFF7C
	bic r1,r0	; 037FFF7E
	strb r1,[r2,#0x0]	; 037FFF80
loc_037FFF82:
	add r4,r4,#0x1	; 037FFF82
	lsr r6,r6,#0x1	; 037FFF84
loc_037FFF86:
	cmp r4,#0x10	; 037FFF86
	bge loc_037FFF8E	; 037FFF88
	cmp r6,#0x0	; 037FFF8A
	bne loc_037FFF2E	; 037FFF8C
loc_037FFF8E:
	add sp,#0xc	; 037FFF8E
	pop {r4,r5,r6,r7}	; 037FFF90
	pop {r3}	; 037FFF92
	bx r3	; 037FFF94
	.byte 0xC0, 0x46	; 037FFF98
pool_037FFF98:
loc_037FFF98:
	.word 0x03805F1C	; 037FFF98
pool_037FFF9C:
loc_037FFF9C:
	.word 0x03805EFC	; 037FFF9C

; ===== function loc_037FFFA0 =====
loc_037FFFA0:
	cmp r0,#0x0	; 037FFFA0
	beq loc_037FFFAA	; 037FFFA2
	mov r1,#0x0	; 037FFFA4
	str r1,[r0,#0x48]	; 037FFFA6
	str r1,[r0,#0x4c]	; 037FFFA8
loc_037FFFAA:
	bx lr	; 037FFFAA

; ===== function loc_037FFFAC =====
	push {r4,r5,r6,r7,lr}	; 037FFFAC
	sub sp,#0xc	; 037FFFAE
	add r5,r0,#0x0	; 037FFFB0
	str r1,[sp,#0x0]	; 037FFFB2
	str r3,[sp,#0x4]	; 037FFFB4
	ldr r0,[pool_03800060]	; 037FFFB6
	ldr r0,[r0,#0x0]	; 037FFFB8
	bic r5,r0	; 037FFFBA
	cmp r2,#0x0	; 037FFFBC
	bne loc_037FFFC6	; 037FFFBE
	ldr r0,[pool_03800064]	; 037FFFC0
	ldr r0,[r0,#0x0]	; 037FFFC2
	bic r5,r0	; 037FFFC4
loc_037FFFC6:
	mov r4,#0x0	; 037FFFC6
	add r6,r4,#0x0	; 037FFFC8
loc_037FFFCA:
	ldr r0,[pool_03800068]	; 037FFFCA
	ldrb r0,[r0,r6]	; 037FFFCC
	mov r1,#0x1	; 037FFFCE
	lsl r1,r0	; 037FFFD0
	add r2,r5,#0x0	; 037FFFD2
	and r2,r1	; 037FFFD4
	cmp r2,#0x0	; 037FFFD6
	beq loc_0380000C	; 037FFFD8
	mov r1,#0x54	; 037FFFDA
	mul r0,r1	; 037FFFDC
	ldr r1,[pool_0380006C]	; 037FFFDE
	add r7,r1,r0	; 037FFFE0
	cmp r4,#0x0	; 037FFFE2
	bne loc_037FFFEA	; 037FFFE4
	add r4,r7,#0x0	; 037FFFE6
	b loc_0380000C	; 037FFFE8
loc_037FFFEA:
	add r0,r4,#0x0	; 037FFFEA
	add r0,#0x22	; 037FFFEC
	ldrb r1,[r0,#0x0]	; 037FFFEE
	add r0,r7,#0x0	; 037FFFF0
	add r0,#0x22	; 037FFFF2
	ldrb r0,[r0,#0x0]	; 037FFFF4
	cmp r0,r1	; 037FFFF6
	bhi loc_0380000C	; 037FFFF8
	cmp r0,r1	; 037FFFFA
	bne loc_0380000A	; 037FFFFC
	add r0,r4,#0x0	; 037FFFFE
	add r1,r7,#0x0	; 03800000
	bl loc_037FFC5C	; 03800002
	cmp r0,#0x0	; 03800006
	bge loc_0380000C	; 03800008
loc_0380000A:
	add r4,r7,#0x0	; 0380000A
loc_0380000C:
	add r6,r6,#0x1	; 0380000C
	cmp r6,#0x10	; 0380000E
	blt loc_037FFFCA	; 03800010
	cmp r4,#0x0	; 03800012
	bne loc_0380001A	; 03800014
	mov r0,#0x0	; 03800016
	b loc_03800056	; 03800018
loc_0380001A:
	add r0,r4,#0x0	; 0380001A
	add r0,#0x22	; 0380001C
	ldrb r1,[r0,#0x0]	; 0380001E
	ldr r0,[sp,#0x0]	; 03800020
	cmp r0,r1	; 03800022
	bge loc_0380002A	; 03800024
	mov r0,#0x0	; 03800026
	b loc_03800056	; 03800028
loc_0380002A:
	ldr r3,[r4,#0x48]	; 0380002A
	cmp r3,#0x0	; 0380002C
	beq loc_0380003A	; 0380002E
	add r0,r4,#0x0	; 03800030
	mov r1,#0x0	; 03800032
	ldr r2,[r4,#0x4c]	; 03800034
	bl loc_03805090	; 03800036
loc_0380003A:
	mov r0,#0x2	; 0380003A
	strb r0,[r4,#0x4]	; 0380003C
	add r2,r4,#0x3	; 0380003E
	ldrb r1,[r2,#0x0]	; 03800040
	mov r0,#0x1	; 03800042
	bic r1,r0	; 03800044
	strb r1,[r2,#0x0]	; 03800046
	add r0,r4,#0x0	; 03800048
	ldr r1,[sp,#0x4]	; 0380004A
	ldr r2,[sp,#0x20]	; 0380004C
	ldr r3,[sp,#0x0]	; 0380004E
	bl loc_037FFD18	; 03800050
	add r0,r4,#0x0	; 03800054
loc_03800056:
	add sp,#0xc	; 03800056
	pop {r4,r5,r6,r7}	; 03800058
	pop {r3}	; 0380005A
	bx r3	; 0380005C
	.byte 0xC0, 0x46	; 03800060
pool_03800060:
loc_03800060:
	.word 0x03805EFC	; 03800060
pool_03800064:
loc_03800064:
	.word 0x03805EF8	; 03800064
pool_03800068:
loc_03800068:
	.word 0x03805224	; 03800068
pool_0380006C:
loc_0380006C:
	.word 0x03805F1C	; 0380006C

; ===== function loc_03800070 =====
loc_03800070:
	ldrb r0,[r0,#0x3]	; 03800070
	lsl r0,r0,#0x1f	; 03800072
	lsr r0,r0,#0x1f	; 03800074
	bx lr	; 03800076

; ===== function loc_03800078 =====
loc_03800078:
	mov r1,#0x3	; 03800078
	strb r1,[r0,#0x2]	; 0380007A
	bx lr	; 0380007C
	.byte 0x00, 0x00	; 03800080

; ===== function loc_03800080 =====
loc_03800080:
	push {r4,lr}	; 03800080
	add r4,r0,#0x0	; 03800082
	add r0,r1,#0x0	; 03800084
	bl loc_037FFCA0	; 03800086
	strh r0,[r4,#0x20]	; 0380008A
	pop {r4}	; 0380008C
	pop {r3}	; 0380008E
	bx r3	; 03800090
	.byte 0x00, 0x00	; 03800094

; ===== function loc_03800094 =====
loc_03800094:
	strb r1,[r0,#0x1d]	; 03800094
	bx lr	; 03800096

; ===== function loc_03800098 =====
loc_03800098:
	push {r4,lr}	; 03800098
	add r4,r0,#0x0	; 0380009A
	add r0,r1,#0x0	; 0380009C
	bl loc_037FFCA0	; 0380009E
	strh r0,[r4,#0x1e]	; 038000A2
	pop {r4}	; 038000A4
	pop {r3}	; 038000A6
	bx r3	; 038000A8
	.byte 0x00, 0x00	; 038000AC

; ===== function loc_038000AC =====
loc_038000AC:
	cmp r1,#0x6d	; 038000AC
	bge loc_038000B8	; 038000AE
	mov r2,#0xff	; 038000B0
	sub r1,r2,r1	; 038000B2
	strb r1,[r0,#0x1c]	; 038000B4
	bx lr	; 038000B6
loc_038000B8:
	mov r2,#0x7f	; 038000B8
	sub r2,r2,r1	; 038000BA
	ldr r1,[pool_038000C4]	; 038000BC
	ldrb r1,[r1,r2]	; 038000BE
	strb r1,[r0,#0x1c]	; 038000C0
	bx lr	; 038000C2
pool_038000C4:
loc_038000C4:
	.word 0x03805234	; 038000C4

; ===== function loc_038000C8 =====
loc_038000C8:
	push {lr}	; 038000C8
	sub sp,#0x4	; 038000CA
	ldrb r2,[r0,#0x0]	; 038000CC
	cmp r2,#0xe	; 038000CE
	bcs loc_038000D6	; 038000D0
	mov r0,#0x0	; 038000D2
	b loc_038000EC	; 038000D4
loc_038000D6:
	cmp r2,#0xf	; 038000D6
	bls loc_038000DE	; 038000D8
	mov r0,#0x0	; 038000DA
	b loc_038000EC	; 038000DC
loc_038000DE:
	mov r2,#0x2	; 038000DE
	strb r2,[r0,#0x1]	; 038000E0
	ldr r2,[pool_038000F4]	; 038000E2
	strh r2,[r0,#0x3c]	; 038000E4
	bl loc_037FFCE4	; 038000E6
	mov r0,#0x1	; 038000EA
loc_038000EC:
	add sp,#0x4	; 038000EC
	pop {r3}	; 038000EE
	bx r3	; 038000F0
	.byte 0xC0, 0x46	; 038000F4
pool_038000F4:
loc_038000F4:
	.word 0x00001F46	; 038000F4

; ===== function loc_038000F8 =====
loc_038000F8:
	push {lr}	; 038000F8
	sub sp,#0x4	; 038000FA
	ldrb r3,[r0,#0x0]	; 038000FC
	cmp r3,#0x8	; 038000FE
	bcs loc_03800106	; 03800100
	mov r0,#0x0	; 03800102
	b loc_03800120	; 03800104
loc_03800106:
	cmp r3,#0xd	; 03800106
	bls loc_0380010E	; 03800108
	mov r0,#0x0	; 0380010A
	b loc_03800120	; 0380010C
loc_0380010E:
	mov r3,#0x1	; 0380010E
	strb r3,[r0,#0x1]	; 03800110
	str r1,[r0,#0x44]	; 03800112
	ldr r1,[pool_03800128]	; 03800114
	strh r1,[r0,#0x3c]	; 03800116
	add r1,r2,#0x0	; 03800118
	bl loc_037FFCE4	; 0380011A
	mov r0,#0x1	; 0380011E
loc_03800120:
	add sp,#0x4	; 03800120
	pop {r3}	; 03800122
	bx r3	; 03800124
	.byte 0xC0, 0x46	; 03800128
pool_03800128:
loc_03800128:
	.word 0x00001F46	; 03800128

; ===== function loc_0380012C =====
loc_0380012C:
	push {r4,r5,r6,lr}	; 0380012C
	add r6,r0,#0x0	; 0380012E
	add r5,r1,#0x0	; 03800130
	mov r0,#0x0	; 03800132
	strb r0,[r6,#0x1]	; 03800134
	add r4,r6,#0x0	; 03800136
	add r4,#0x38	; 03800138
	ldmia r5!,{r0,r1}	; 0380013A
	stmia r4!,{r0,r1}	; 0380013C
	ldr r0,[r5,#0x0]	; 0380013E
	str r0,[r4,#0x0]	; 03800140
	str r2,[r6,#0x44]	; 03800142
	add r0,r6,#0x0	; 03800144
	add r1,r3,#0x0	; 03800146
	bl loc_037FFCE4	; 03800148
	mov r0,#0x1	; 0380014C
	pop {r4,r5,r6}	; 0380014E
	pop {r3}	; 03800150
	bx r3	; 03800152

; ===== function loc_03800154 =====
	push {r4,r5,r6,r7,lr}	; 03800154
	sub sp,#0x24	; 03800156
	str r0,[sp,#0x0]	; 03800158
	mov r0,#0x0	; 0380015A
	str r0,[sp,#0x4]	; 0380015C
	str r0,[sp,#0xc]	; 0380015E
	str r0,[sp,#0x14]	; 03800160
	str r0,[sp,#0x1c]	; 03800162
	str r0,[sp,#0x18]	; 03800164
	str r0,[sp,#0x10]	; 03800166
	str r0,[sp,#0x8]	; 03800168
loc_0380016A:
	ldr r6,[sp,#0x8]	; 0380016A
	lsl r7,r6,#0	; 0380016C
	lsl r4,r6,#0	; 0380016E
	ldr r1,[sp,#0x4]	; 03800170
	mov r0,#0x54	; 03800172
	mul r1,r0	; 03800174
	ldr r0,[pool_03800334]	; 03800176
	add r5,r0,r1	; 03800178
	ldrb r0,[r5,#0x3]	; 0380017A
	lsl r1,r0,#0x1f	; 0380017C
	lsr r1,r1,#0x1f	; 0380017E
	cmp r1,#0x0	; 03800180
	bne loc_03800186	; 03800182
	b loc_03800320	; 03800184
loc_03800186:
	lsl r0,r0,#0x1e	; 03800186
	lsr r0,r0,#0x1f	; 03800188
	cmp r0,#0x0	; 0380018A
	beq loc_038001A4	; 0380018C
	add r2,r5,#0x4	; 0380018E
	ldrb r1,[r2,#0x0]	; 03800190
	mov r0,#0x1	; 03800192
	orr r1,r0	; 03800194
	strb r1,[r2,#0x0]	; 03800196
	add r2,r5,#0x3	; 03800198
	ldrb r1,[r2,#0x0]	; 0380019A
	mov r0,#0x2	; 0380019C
	bic r1,r0	; 0380019E
	strb r1,[r2,#0x0]	; 038001A0
	b loc_038001D8	; 038001A2
loc_038001A4:
	ldr r0,[sp,#0x4]	; 038001A4
	bl loc_037FF55C	; 038001A6
	cmp r0,#0x0	; 038001AA
	bne loc_038001D8	; 038001AC
	ldr r3,[r5,#0x48]	; 038001AE
	cmp r3,#0x0	; 038001B0
	beq loc_038001C0	; 038001B2
	add r0,r5,#0x0	; 038001B4
	mov r1,#0x2	; 038001B6
	ldr r2,[r5,#0x4c]	; 038001B8
	bl loc_03805090	; 038001BA
	b loc_038001C8	; 038001BE
loc_038001C0:
	add r1,r5,#0x0	; 038001C0
	add r1,#0x22	; 038001C2
	ldr r0,[sp,#0xc]	; 038001C4
	strb r0,[r1,#0x0]	; 038001C6
loc_038001C8:
	ldr r0,[sp,#0x10]	; 038001C8
	strh r0,[r5,#0x24]	; 038001CA
	add r2,r5,#0x3	; 038001CC
	ldrb r1,[r2,#0x0]	; 038001CE
	mov r0,#0x1	; 038001D0
	bic r1,r0	; 038001D2
	strb r1,[r2,#0x0]	; 038001D4
	b loc_03800320	; 038001D6
loc_038001D8:
	ldrb r0,[r5,#0x9]	; 038001D8
	lsl r1,r0,#0x1	; 038001DA
	ldr r0,[pool_03800338]	; 038001DC
	ldrsh r0,[r0,r1]	; 038001DE
	add r6,r6,r0	; 038001E0
	ldrb r1,[r5,#0x8]	; 038001E2
	ldrb r0,[r5,#0x5]	; 038001E4
	sub r0,r1,r0	; 038001E6
	lsl r0,r0,#0x6	; 038001E8
	add r7,r7,r0	; 038001EA
	add r0,r5,#0x0	; 038001EC
	ldr r1,[sp,#0x0]	; 038001EE
	bl loc_037FFBE0	; 038001F0
	add r6,r6,r0	; 038001F4
	add r0,r5,#0x0	; 038001F6
	ldr r1,[sp,#0x0]	; 038001F8
	bl loc_037FFB90	; 038001FA
	add r7,r7,r0	; 038001FE
	add r0,r5,#0x0	; 03800200
	ldr r1,[sp,#0x0]	; 03800202
	bl loc_037FFB10	; 03800204
	add r1,r5,#0x0	; 03800208
	add r1,#0x28	; 0380020A
	ldrb r1,[r1,#0x0]	; 0380020C
	cmp r1,#0x0	; 0380020E
	beq loc_03800220	; 03800210
	cmp r1,#0x1	; 03800212
	beq loc_0380021C	; 03800214
	cmp r1,#0x2	; 03800216
	beq loc_03800224	; 03800218
	b loc_03800226	; 0380021A
loc_0380021C:
	add r6,r6,r0	; 0380021C
	b loc_03800226	; 0380021E
loc_03800220:
	add r7,r7,r0	; 03800220
	b loc_03800226	; 03800222
loc_03800224:
	add r4,r4,r0	; 03800224
loc_03800226:
	mov r0,#0xc	; 03800226
	ldrsh r0,[r5,r0]	; 03800228
	add r6,r6,r0	; 0380022A
	mov r0,#0xe	; 0380022C
	ldrsh r0,[r5,r0]	; 0380022E
	add r7,r7,r0	; 03800230
	mov r0,#0xb	; 03800232
	ldrsb r0,[r5,r0]	; 03800234
	add r1,r4,r0	; 03800236
	mov r0,#0xa	; 03800238
	ldrsb r0,[r5,r0]	; 0380023A
	add r4,r1,r0	; 0380023C
	ldrb r0,[r5,#0x2]	; 0380023E
	cmp r0,#0x3	; 03800240
	bne loc_03800278	; 03800242
	ldr r0,[pool_0380033C]	; 03800244
	cmp r6,r0	; 03800246
	bgt loc_03800278	; 03800248
	mov r0,#0x2	; 0380024A
	strb r0,[r5,#0x4]	; 0380024C
	ldr r3,[r5,#0x48]	; 0380024E
	cmp r3,#0x0	; 03800250
	beq loc_03800260	; 03800252
	add r0,r5,#0x0	; 03800254
	mov r1,#0x2	; 03800256
	ldr r2,[r5,#0x4c]	; 03800258
	bl loc_03805090	; 0380025A
	b loc_03800268	; 0380025E
loc_03800260:
	add r1,r5,#0x0	; 03800260
	add r1,#0x22	; 03800262
	ldr r0,[sp,#0x14]	; 03800264
	strb r0,[r1,#0x0]	; 03800266
loc_03800268:
	ldr r0,[sp,#0x18]	; 03800268
	strh r0,[r5,#0x24]	; 0380026A
	add r2,r5,#0x3	; 0380026C
	ldrb r1,[r2,#0x0]	; 0380026E
	mov r0,#0x1	; 03800270
	bic r1,r0	; 03800272
	strb r1,[r2,#0x0]	; 03800274
	b loc_03800320	; 03800276
loc_03800278:
	add r0,r6,#0x0	; 03800278
	bl loc_037FF818	; 0380027A
	add r6,r0,#0x0	; 0380027E
	ldrh r0,[r5,#0x3c]	; 03800280
	add r1,r7,#0x0	; 03800282
	bl loc_037FF870	; 03800284
	ldrb r1,[r5,#0x1]	; 03800288
	cmp r1,#0x1	; 0380028A
	bne loc_03800296	; 0380028C
	ldr r1,[pool_03800340]	; 0380028E
	and r0,r1	; 03800290
	lsl r0,r0,#0x10	; 03800292
	lsr r0,r0,#0x10	; 03800294
loc_03800296:
	add r4,#0x40	; 03800296
	cmp r4,#0x0	; 03800298
	bge loc_038002A0	; 0380029A
	ldr r4,[sp,#0x1c]	; 0380029C
	b loc_038002A6	; 0380029E
loc_038002A0:
	cmp r4,#0x7f	; 038002A0
	ble loc_038002A6	; 038002A2
	mov r4,#0x7f	; 038002A4
loc_038002A6:
	ldrh r1,[r5,#0x24]	; 038002A6
	cmp r6,r1	; 038002A8
	beq loc_038002B8	; 038002AA
	strh r6,[r5,#0x24]	; 038002AC
	add r3,r5,#0x4	; 038002AE
	ldrb r2,[r3,#0x0]	; 038002B0
	mov r1,#0x8	; 038002B2
	orr r2,r1	; 038002B4
	strb r2,[r3,#0x0]	; 038002B6
loc_038002B8:
	ldrh r1,[r5,#0x26]	; 038002B8
	cmp r0,r1	; 038002BA
	beq loc_038002CA	; 038002BC
	strh r0,[r5,#0x26]	; 038002BE
	add r2,r5,#0x4	; 038002C0
	ldrb r1,[r2,#0x0]	; 038002C2
	mov r0,#0x4	; 038002C4
	orr r1,r0	; 038002C6
	strb r1,[r2,#0x0]	; 038002C8
loc_038002CA:
	add r0,r5,#0x0	; 038002CA
	add r0,#0x23	; 038002CC
	ldrb r0,[r0,#0x0]	; 038002CE
	cmp r4,r0	; 038002D0
	beq loc_038002E4	; 038002D2
	add r0,r5,#0x0	; 038002D4
	add r0,#0x23	; 038002D6
	strb r4,[r0,#0x0]	; 038002D8
	add r2,r5,#0x4	; 038002DA
	ldrb r1,[r2,#0x0]	; 038002DC
	mov r0,#0x10	; 038002DE
	orr r1,r0	; 038002E0
	strb r1,[r2,#0x0]	; 038002E2
loc_038002E4:
	ldr r0,[sp,#0x0]	; 038002E4
	cmp r0,#0x0	; 038002E6
	beq loc_03800320	; 038002E8
	ldr r0,[r5,#0x34]	; 038002EA
	cmp r0,#0x0	; 038002EC
	ble loc_03800320	; 038002EE
	add r1,r5,#0x0	; 038002F0
	add r1,#0x34	; 038002F2
	ldr r0,[r1,#0x0]	; 038002F4
	sub r0,r0,#0x1	; 038002F6
	str r0,[r1,#0x0]	; 038002F8
	ldr r0,[r5,#0x34]	; 038002FA
	cmp r0,#0x0	; 038002FC
	bne loc_03800320	; 038002FE
	ldr r3,[r5,#0x48]	; 03800300
	cmp r3,#0x0	; 03800302
	beq loc_03800312	; 03800304
	add r0,r5,#0x0	; 03800306
	mov r1,#0x1	; 03800308
	ldr r2,[r5,#0x4c]	; 0380030A
	bl loc_03805090	; 0380030C
	b loc_0380031A	; 03800310
loc_03800312:
	add r1,r5,#0x0	; 03800312
	add r1,#0x22	; 03800314
	mov r0,#0x1	; 03800316
	strb r0,[r1,#0x0]	; 03800318
loc_0380031A:
	add r0,r5,#0x0	; 0380031A
	bl loc_03800078	; 0380031C
loc_03800320:
	ldr r0,[sp,#0x4]	; 03800320
	add r0,r0,#0x1	; 03800322
	str r0,[sp,#0x4]	; 03800324
	cmp r0,#0x10	; 03800326
	bge loc_0380032C	; 03800328
	b loc_0380016A	; 0380032A
loc_0380032C:
	add sp,#0x24	; 0380032C
	pop {r4,r5,r6,r7}	; 0380032E
	pop {r3}	; 03800330
	bx r3	; 03800332
pool_03800334:
loc_03800334:
	.word 0x03805F1C	; 03800334
pool_03800338:
loc_03800338:
	.word 0x03805120	; 03800338
pool_0380033C:
loc_0380033C:
	.word 0xFFFFFD2D	; 0380033C
pool_03800340:
loc_03800340:
	.word 0x0000FFFC	; 03800340
	.byte 0xF0, 0xB5, 0x87, 0xB0, 0x00, 0x24, 0x27, 0x1C, 0xFF, 0x26, 0x21, 0x1C, 0x54, 0x20, 0x41, 0x43	; 03800354
	.byte 0x49, 0x48, 0x45, 0x18, 0x29, 0x79, 0x00, 0x29, 0x6E, 0xD0, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29	; 03800364
	.byte 0x03, 0xD0, 0x20, 0x1C, 0x39, 0x1C, 0xFF, 0xF7, 0x5D, 0xF9, 0x28, 0x79, 0x02, 0x1C, 0x01, 0x21	; 03800374
	.byte 0x0A, 0x40, 0x00, 0x2A, 0x42, 0xD0, 0x68, 0x78, 0x00, 0x28, 0x04, 0xD0, 0x01, 0x28, 0x21, 0xD0	; 03800384
	.byte 0x02, 0x28, 0x2E, 0xD0, 0x58, 0xE0, 0x28, 0x1C, 0x39, 0x30, 0x00, 0x78, 0x00, 0x28, 0x01, 0xD0	; 03800394
	.byte 0x0B, 0x00, 0x00, 0xE0, 0x02, 0x23, 0xA8, 0x8C, 0xE9, 0x8F, 0x00, 0x91, 0x29, 0x6C, 0x01, 0x91	; 038003A4
	.byte 0x01, 0x1C, 0x31, 0x40, 0x02, 0x91, 0x00, 0x12, 0x03, 0x90, 0xE8, 0x8C, 0x04, 0x90, 0x28, 0x1C	; 038003B4
	.byte 0x23, 0x30, 0x00, 0x78, 0x05, 0x90, 0x20, 0x1C, 0x69, 0x6C, 0x38, 0x35, 0x2A, 0x78, 0xFF, 0xF7	; 038003C4
	.byte 0xAF, 0xF9, 0x39, 0xE0, 0xAB, 0x8C, 0xE8, 0x8C, 0x00, 0x90, 0x28, 0x1C, 0x23, 0x30, 0x00, 0x78	; 038003D4
	.byte 0x01, 0x90, 0x20, 0x1C, 0x69, 0x6C, 0x1A, 0x1C, 0x32, 0x40, 0x1B, 0x12, 0xFF, 0xF7, 0x6A, 0xF9	; 038003E4
	.byte 0x2A, 0xE0, 0xAA, 0x8C, 0x28, 0x1C, 0x23, 0x30, 0x00, 0x78, 0x00, 0x90, 0x20, 0x1C, 0x11, 0x1C	; 038003F4
	.byte 0x31, 0x40, 0x12, 0x12, 0xEB, 0x8C, 0xFF, 0xF7, 0x29, 0xF9, 0x1D, 0xE0, 0x04, 0x21, 0x08, 0x40	; 03800404
	.byte 0x00, 0x28, 0x03, 0xD0, 0x20, 0x1C, 0xE9, 0x8C, 0xFF, 0xF7, 0xD6, 0xF8, 0x29, 0x79, 0x08, 0x20	; 03800414
	.byte 0x01, 0x40, 0x00, 0x29, 0x06, 0xD0, 0xAA, 0x8C, 0x20, 0x1C, 0x11, 0x1C, 0x31, 0x40, 0x12, 0x12	; 03800424
	.byte 0xFF, 0xF7, 0xD4, 0xF8, 0x29, 0x79, 0x10, 0x20, 0x01, 0x40, 0x00, 0x29, 0x04, 0xD0, 0x20, 0x1C	; 03800434
	.byte 0x23, 0x35, 0x29, 0x78, 0xFF, 0xF7, 0x9E, 0xF8, 0x64, 0x1C, 0x10, 0x2C, 0x85, 0xDB, 0x00, 0x22	; 03800444
	.byte 0x15, 0x1C, 0x0D, 0x48, 0x54, 0x24, 0x11, 0x1C, 0x61, 0x43, 0x41, 0x18, 0x0E, 0x79, 0x00, 0x2E	; 03800454
	.byte 0x0B, 0xD0, 0x01, 0x23, 0x1E, 0x40, 0x00, 0x2E, 0x06, 0xD0, 0x16, 0x01, 0x07, 0x4B, 0xF7, 0x18	; 03800464
	.byte 0x3E, 0x78, 0x80, 0x23, 0x1E, 0x43, 0x3E, 0x70, 0x0D, 0x71, 0x52, 0x1C, 0x10, 0x2A, 0xEA, 0xDB	; 03800474
	.byte 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x1C, 0x5F, 0x80, 0x03, 0x03, 0x04, 0x00, 0x04	; 03800484
	.byte 0x70, 0xB5, 0x00, 0x20, 0x0B, 0x4E, 0x05, 0x1C, 0x54, 0x21, 0x01, 0x22, 0x03, 0x1C, 0x4B, 0x43	; 03800494
	.byte 0xF4, 0x18, 0xF0, 0x54, 0x25, 0x71, 0xE4, 0x1C, 0x23, 0x78, 0x93, 0x43, 0x23, 0x70, 0x40, 0x1C	; 038004A4
	.byte 0x10, 0x28, 0xF3, 0xDB, 0x04, 0x48, 0x05, 0x60, 0x04, 0x48, 0x05, 0x60, 0x70, 0xBC, 0x08, 0xBC	; 038004B4
	.byte 0x18, 0x47, 0xC0, 0x46, 0x1C, 0x5F, 0x80, 0x03, 0xFC, 0x5E, 0x80, 0x03, 0xF8, 0x5E, 0x80, 0x03	; 038004C4

; ===== function loc_038004C4 =====
loc_038004C4:
	push {r4,lr}	; 038004C4
	mov r0,#0x0	; 038004C6
	ldr r3,[pool_038004F4]	; 038004C8
	b loc_038004E6	; 038004CA
loc_038004CC:
	lsl r1,r0,#0x6	; 038004CC
	add r4,r3,r1	; 038004CE
	ldrb r2,[r3,r1]	; 038004D0
	lsl r1,r2,#0x1f	; 038004D2
	lsr r1,r1,#0x1f	; 038004D4
	cmp r1,#0x0	; 038004D6
	bne loc_038004E4	; 038004D8
	mov r1,#0x1	; 038004DA
	bic r2,r1	; 038004DC
	orr r2,r1	; 038004DE
	strb r2,[r4,#0x0]	; 038004E0
	b loc_038004EE	; 038004E2
loc_038004E4:
	add r0,r0,#0x1	; 038004E4
loc_038004E6:
	cmp r0,#0x20	; 038004E6
	blt loc_038004CC	; 038004E8
	mov r0,#0x0	; 038004EA
	mvn r0,r0	; 038004EC
loc_038004EE:
	pop {r4}	; 038004EE
	pop {r3}	; 038004F0
	bx r3	; 038004F2
pool_038004F4:
loc_038004F4:
	.word 0x0380669C	; 038004F4

; ===== function loc_038004F8 =====
loc_038004F8:
	ldr r2,[pool_03800524]	; 038004F8
	ldr r3,[r2,#0x0]	; 038004FA
	cmp r3,#0x0	; 038004FC
	bne loc_03800504	; 038004FE
	mov r0,#0x0	; 03800500
	bx lr	; 03800502
loc_03800504:
	cmp r1,#0x10	; 03800504
	bge loc_03800518	; 03800506
	add r3,#0x20	; 03800508
	ldrb r2,[r0,#0x2]	; 0380050A
	mov r0,#0x24	; 0380050C
	mul r2,r0	; 0380050E
	add r2,r3,r2	; 03800510
	lsl r0,r1,#0x1	; 03800512
	add r0,r2,r0	; 03800514
	bx lr	; 03800516
loc_03800518:
	ldr r0,[pool_03800528]	; 03800518
	add r2,r3,r0	; 0380051A
	sub r1,#0x10	; 0380051C
	lsl r0,r1,#0x1	; 0380051E
	add r0,r2,r0	; 03800520
	bx lr	; 03800522
pool_03800524:
loc_03800524:
	.word 0x03805F18	; 03800524
pool_03800528:
loc_03800528:
	.word 0x00000260	; 03800528
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x26, 0x34, 0x1C, 0x01, 0x27, 0x28, 0x1C, 0x21, 0x1C	; 0380053C
	.byte 0x00, 0xF0, 0x98, 0xFC, 0x00, 0x28, 0x0D, 0xD0, 0x81, 0x6A, 0x00, 0x29, 0x0A, 0xD0, 0x29, 0x1C	; 0380054C
	.byte 0x00, 0xF0, 0x14, 0xF8, 0x00, 0x28, 0x01, 0xD1, 0x3E, 0x1C, 0x03, 0xE0, 0x28, 0x1C, 0x21, 0x1C	; 0380055C
	.byte 0x00, 0xF0, 0x66, 0xFC, 0x64, 0x1C, 0x10, 0x2C, 0xE8, 0xDB, 0x00, 0x2E, 0x01, 0xD1, 0x01, 0x20	; 0380056C
	.byte 0x00, 0xE0, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF0, 0xB5, 0x89, 0xB0	; 0380057C
	.byte 0x04, 0x1C, 0x01, 0x91, 0x21, 0x78, 0xC8, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x07, 0xD0, 0xE0, 0x6B	; 0380058C
	.byte 0x00, 0x28, 0x01, 0xD0, 0x00, 0x20, 0x03, 0xE3, 0x10, 0x20, 0x81, 0x43, 0x21, 0x70, 0x20, 0x6A	; 0380059C
	.byte 0x00, 0x28, 0x09, 0xDD, 0x21, 0x1C, 0x20, 0x31, 0x08, 0x68, 0x40, 0x1E, 0x08, 0x60, 0x20, 0x6A	; 038005AC
	.byte 0x00, 0x28, 0x01, 0xDD, 0x00, 0x20, 0xF3, 0xE2, 0xA0, 0x6A, 0x00, 0xF0, 0x03, 0xFE, 0x00, 0x20	; 038005BC
	.byte 0xC0, 0x43, 0x06, 0x90, 0xE2, 0xE2, 0x00, 0x25, 0x01, 0x20, 0x03, 0x90, 0x20, 0x1C, 0x00, 0xF0	; 038005CC
	.byte 0xD5, 0xFD, 0x06, 0x1C, 0xA2, 0x2E, 0x07, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0xCF, 0xFD, 0x06, 0x1C	; 038005DC
	.byte 0x20, 0x78, 0x40, 0x06, 0xC0, 0x0F, 0x03, 0x90, 0xA0, 0x2E, 0x06, 0xD1, 0x20, 0x1C, 0x00, 0xF0	; 038005EC
	.byte 0xC5, 0xFD, 0x06, 0x1C, 0x03, 0x20, 0x02, 0x90, 0x01, 0x25, 0xA1, 0x2E, 0x06, 0xD1, 0x20, 0x1C	; 038005FC
	.byte 0x00, 0xF0, 0xBC, 0xFD, 0x06, 0x1C, 0x04, 0x20, 0x02, 0x90, 0x01, 0x25, 0x31, 0x1C, 0x80, 0x20	; 0380060C
	.byte 0x01, 0x40, 0x00, 0x29, 0x37, 0xD1, 0x20, 0x1C, 0x00, 0xF0, 0xB0, 0xFD, 0x04, 0x90, 0x00, 0x2D	; 0380061C
	.byte 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x02, 0x22, 0x20, 0x1C, 0x01, 0x99, 0x00, 0xF0, 0x10, 0xFD	; 0380062C
	.byte 0x07, 0x1C, 0x13, 0x20, 0x20, 0x56, 0x35, 0x18, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0xA5, 0xE2	; 0380063C
	.byte 0x00, 0x2D, 0x01, 0xDA, 0x00, 0x25, 0x02, 0xE0, 0x7F, 0x2D, 0x00, 0xDD, 0x7F, 0x25, 0x20, 0x78	; 0380064C
	.byte 0x40, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x06, 0xD1, 0x00, 0x97, 0x20, 0x1C, 0x01, 0x99, 0x2A, 0x1C	; 0380065C
	.byte 0x04, 0x9B, 0x00, 0xF0, 0xA1, 0xFA, 0x25, 0x75, 0x20, 0x78, 0x80, 0x07, 0xC0, 0x0F, 0x00, 0x28	; 0380066C
	.byte 0x00, 0xD1, 0x8B, 0xE2, 0x27, 0x62, 0x00, 0x2F, 0x00, 0xD0, 0x87, 0xE2, 0x21, 0x78, 0x10, 0x20	; 0380067C
	.byte 0x01, 0x43, 0x21, 0x70, 0x82, 0xE2, 0x31, 0x1C, 0xF0, 0x20, 0x01, 0x40, 0xC0, 0x29, 0x0C, 0xDC	; 0380068C
	.byte 0xC0, 0x29, 0x7C, 0xDA, 0x90, 0x29, 0x04, 0xDC, 0x90, 0x29, 0x2C, 0xDA, 0x80, 0x29, 0x10, 0xD0	; 0380069C
	.byte 0x74, 0xE2, 0xB0, 0x29, 0x00, 0xD1, 0x58, 0xE1, 0x70, 0xE2, 0xE0, 0x29, 0x05, 0xDC, 0xE0, 0x29	; 038006AC
	.byte 0x00, 0xDB, 0x35, 0xE1, 0xD0, 0x29, 0x6A, 0xD0, 0x68, 0xE2, 0xF0, 0x29, 0x00, 0xD1, 0x1D, 0xE2	; 038006BC
	.byte 0x64, 0xE2, 0x00, 0x2D, 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x02, 0x22, 0x20, 0x1C, 0x01, 0x99	; 038006CC
	.byte 0x00, 0xF0, 0xBE, 0xFC, 0x03, 0x99, 0x00, 0x29, 0x00, 0xD1, 0x57, 0xE2, 0x80, 0x2E, 0x02, 0xD0	; 038006DC
	.byte 0x81, 0x2E, 0x02, 0xD0, 0x52, 0xE2, 0x20, 0x62, 0x50, 0xE2, 0xD0, 0x49, 0x88, 0x42, 0x00, 0xDB	; 038006EC
	.byte 0x4C, 0xE2, 0x60, 0x80, 0x4A, 0xE2, 0x93, 0x2E, 0x04, 0xD0, 0x94, 0x2E, 0x22, 0xD0, 0x95, 0x2E	; 038006FC
	.byte 0x2B, 0xD0, 0x43, 0xE2, 0x20, 0x1C, 0x00, 0xF0, 0x39, 0xFD, 0x05, 0x1C, 0x20, 0x1C, 0x00, 0xF0	; 0380070C
	.byte 0xF5, 0xFC, 0x06, 0x1C, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0x37, 0xE2, 0x01, 0x98, 0x29, 0x1C	; 0380071C
	.byte 0x00, 0xF0, 0xA8, 0xFB, 0x05, 0x1C, 0x00, 0x2D, 0x00, 0xD1, 0x2F, 0xE2, 0xA5, 0x42, 0x00, 0xD1	; 0380072C
	.byte 0x2C, 0xE2, 0x01, 0x99, 0x00, 0xF0, 0x98, 0xFB, 0x28, 0x1C, 0x61, 0x6A, 0x32, 0x1C, 0x00, 0xF0	; 0380073C
	.byte 0x37, 0xFC, 0x23, 0xE2, 0x20, 0x1C, 0x00, 0xF0, 0xD9, 0xFC, 0x03, 0x99, 0x00, 0x29, 0x00, 0xD1	; 0380074C
	.byte 0x1C, 0xE2, 0x61, 0x6A, 0x08, 0x18, 0xA0, 0x62, 0x18, 0xE2, 0x20, 0x1C, 0x00, 0xF0, 0xCE, 0xFC	; 0380075C
	.byte 0x03, 0x99, 0x00, 0x29, 0x00, 0xD1, 0x11, 0xE2, 0x21, 0x1C, 0x3B, 0x31, 0x09, 0x78, 0x03, 0x29	; 0380076C
	.byte 0x00, 0xD3, 0x0B, 0xE2, 0xA2, 0x6A, 0x89, 0x00, 0x61, 0x18, 0xCA, 0x62, 0x22, 0x1C, 0x3B, 0x32	; 0380077C
	.byte 0x11, 0x78, 0x49, 0x1C, 0x11, 0x70, 0x61, 0x6A, 0x08, 0x18, 0xA0, 0x62, 0xFE, 0xE1, 0x00, 0x2D	; 0380078C
	.byte 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x1C, 0x01, 0x99, 0x00, 0xF0, 0x58, 0xFC	; 0380079C
	.byte 0x07, 0xA9, 0x08, 0x70, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0xEF, 0xE1, 0xC0, 0x3E, 0x15, 0x2E	; 038007AC
	.byte 0x00, 0xD9, 0xEB, 0xE1, 0xB0, 0x19, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44	; 038007BC
	.byte 0x00, 0x47, 0x55, 0x01, 0x2D, 0x00, 0x3D, 0x00, 0x45, 0x01, 0x4D, 0x01, 0x47, 0x00, 0x4F, 0x00	; 038007CC
	.byte 0x57, 0x00, 0xE5, 0x00, 0x05, 0x01, 0x75, 0x00, 0x7D, 0x00, 0x85, 0x00, 0x8D, 0x00, 0x25, 0x01	; 038007DC
	.byte 0x6D, 0x00, 0x95, 0x00, 0x9D, 0x00, 0xA5, 0x00, 0xAD, 0x00, 0xB5, 0x00, 0x35, 0x00, 0x08, 0x00	; 038007EC
	.byte 0x00, 0x78, 0x20, 0x71, 0xCA, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x60, 0x71, 0xC6, 0xE1, 0x08, 0x00	; 038007FC
	.byte 0x01, 0x78, 0x01, 0x98, 0x41, 0x71, 0xC1, 0xE1, 0x08, 0x00, 0x00, 0x78, 0xE0, 0x71, 0xBD, 0xE1	; 0380080C
	.byte 0x08, 0x00, 0x00, 0x78, 0xA0, 0x74, 0xB9, 0xE1, 0x20, 0x78, 0x02, 0x21, 0x88, 0x43, 0x07, 0xA9	; 0380081C
	.byte 0x0A, 0x78, 0x01, 0x21, 0x0A, 0x40, 0x51, 0x00, 0x08, 0x43, 0x20, 0x70, 0xAE, 0xE1, 0x08, 0x00	; 0380082C
	.byte 0x00, 0x78, 0x60, 0x75, 0xAA, 0xE1, 0x08, 0x00, 0x00, 0x78, 0xA0, 0x76, 0xA6, 0xE1, 0x08, 0x00	; 0380083C
	.byte 0x00, 0x78, 0x60, 0x76, 0xA2, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x20, 0x76, 0x9E, 0xE1, 0x08, 0x00	; 0380084C
	.byte 0x00, 0x78, 0xE0, 0x76, 0x9A, 0xE1, 0x08, 0x00, 0x00, 0x78, 0xA0, 0x73, 0x96, 0xE1, 0x08, 0x00	; 0380085C
	.byte 0x00, 0x78, 0xE0, 0x73, 0x92, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x20, 0x74, 0x8E, 0xE1, 0x08, 0x00	; 0380086C
	.byte 0x00, 0x78, 0x60, 0x74, 0x8A, 0xE1, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x03, 0x28, 0x00, 0xD3	; 0380087C
	.byte 0x84, 0xE1, 0xA1, 0x6A, 0x80, 0x00, 0x20, 0x18, 0xC1, 0x62, 0x07, 0xA8, 0x01, 0x78, 0x20, 0x1C	; 0380088C
	.byte 0x3B, 0x30, 0x00, 0x78, 0x20, 0x18, 0x38, 0x30, 0x01, 0x70, 0x21, 0x1C, 0x3B, 0x31, 0x08, 0x78	; 0380089C
	.byte 0x40, 0x1C, 0x08, 0x70, 0x72, 0xE1, 0x20, 0x78, 0x08, 0x21, 0x88, 0x43, 0x07, 0xA9, 0x0A, 0x78	; 038008AC
	.byte 0x01, 0x21, 0x0A, 0x40, 0xD1, 0x00, 0x08, 0x43, 0x20, 0x70, 0x20, 0x1C, 0x01, 0x99, 0x06, 0x9A	; 038008BC
	.byte 0x00, 0xF0, 0x1C, 0xFB, 0x62, 0xE1, 0x08, 0x00, 0x01, 0x78, 0x13, 0x20, 0x20, 0x56, 0x08, 0x18	; 038008CC
	.byte 0x20, 0x75, 0x21, 0x78, 0x20, 0x20, 0x01, 0x43, 0x21, 0x70, 0x20, 0x1C, 0x01, 0x99, 0x06, 0x9A	; 038008DC
	.byte 0x00, 0xF0, 0x0C, 0xFB, 0x52, 0xE1, 0x20, 0x78, 0x20, 0x21, 0x88, 0x43, 0x07, 0xA9, 0x0A, 0x78	; 038008EC
	.byte 0x01, 0x21, 0x0A, 0x40, 0x51, 0x01, 0x08, 0x43, 0x20, 0x70, 0x20, 0x1C, 0x01, 0x99, 0x06, 0x9A	; 038008FC
	.byte 0x00, 0xF0, 0xFC, 0xFA, 0x42, 0xE1, 0x00, 0x20, 0x08, 0x56, 0xE0, 0x74, 0x3E, 0xE1, 0x00, 0x20	; 0380090C
	.byte 0x08, 0x56, 0xA0, 0x71, 0x3A, 0xE1, 0x08, 0x00, 0x00, 0x78, 0x40, 0x38, 0x20, 0x72, 0x35, 0xE1	; 0380091C
	.byte 0x00, 0x2D, 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x01, 0x22, 0x20, 0x1C, 0x01, 0x99, 0x00, 0xF0	; 0380092C
	.byte 0x8F, 0xFB, 0x00, 0x04, 0x01, 0x14, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0x26, 0xE1, 0xE0, 0x2E	; 0380093C
	.byte 0x07, 0xD0, 0xE1, 0x2E, 0x02, 0xD0, 0xE3, 0x2E, 0x05, 0xD0, 0x1F, 0xE1, 0x01, 0x98, 0x01, 0x83	; 0380094C
	.byte 0x1C, 0xE1, 0xA1, 0x83, 0x1A, 0xE1, 0xE1, 0x82, 0x18, 0xE1, 0x20, 0x1C, 0x00, 0xF0, 0x0E, 0xFC	; 0380095C
	.byte 0x05, 0x90, 0x00, 0x2D, 0x01, 0xD0, 0x02, 0x9A, 0x00, 0xE0, 0x01, 0x22, 0x20, 0x1C, 0x01, 0x99	; 0380096C
	.byte 0x00, 0xF0, 0x6E, 0xFB, 0x00, 0x04, 0x07, 0x14, 0x01, 0x98, 0x05, 0x99, 0xFF, 0xF7, 0xBE, 0xFD	; 0380097C
	.byte 0x05, 0x1C, 0x03, 0x98, 0x00, 0x28, 0x00, 0xD1, 0x00, 0xE1, 0x00, 0x2D, 0x00, 0xD1, 0xFD, 0xE0	; 0380098C
	.byte 0xB0, 0x3E, 0x0D, 0x2E, 0x00, 0xD9, 0xF9, 0xE0, 0xB0, 0x19, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 0380099C
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x1D, 0x00, 0x21, 0x00, 0x2B, 0x00, 0x35, 0x00, 0x3F, 0x00	; 038009AC
	.byte 0x53, 0x00, 0x6D, 0x00, 0xE7, 0x01, 0x7B, 0x00, 0xA3, 0x00, 0xC7, 0x00, 0xEB, 0x00, 0x0F, 0x01	; 038009BC
	.byte 0x33, 0x01, 0x2F, 0x80, 0xE2, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xC0, 0x19, 0x28, 0x80, 0xDD, 0xE0	; 038009CC
	.byte 0x00, 0x20, 0x28, 0x5E, 0xC0, 0x1B, 0x28, 0x80, 0xD8, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0x78, 0x43	; 038009DC
	.byte 0x28, 0x80, 0xD3, 0xE0, 0x00, 0x2F, 0x00, 0xD1, 0xD0, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0x39, 0x1C	; 038009EC
	.byte 0xFD, 0xF7, 0x82, 0xFC, 0x28, 0x80, 0xC9, 0xE0, 0x00, 0x2F, 0x04, 0xDB, 0x00, 0x20, 0x28, 0x5E	; 038009FC
	.byte 0xB8, 0x40, 0x28, 0x80, 0xC2, 0xE0, 0x00, 0x20, 0x29, 0x5E, 0x78, 0x42, 0x01, 0x41, 0x29, 0x80	; 03800A0C
	.byte 0xBC, 0xE0, 0xFE, 0xF7, 0xD1, 0xFE, 0x79, 0x1C, 0x48, 0x43, 0x00, 0x14, 0x28, 0x80, 0xB5, 0xE0	; 03800A1C
	.byte 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x03, 0xD1, 0x01, 0x22, 0x02, 0xE0, 0x00, 0x00, 0x01, 0x00	; 03800A2C
	.byte 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40	; 03800A3C
	.byte 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0xA1, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xDB	; 03800A4C
	.byte 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E	; 03800A5C
	.byte 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x8F, 0xE0, 0x00, 0x20, 0x28, 0x5E	; 03800A6C
	.byte 0xB8, 0x42, 0x01, 0xDD, 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43	; 03800A7C
	.byte 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x7D, 0xE0	; 03800A8C
	.byte 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xDC, 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78	; 03800A9C
	.byte 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43	; 03800AAC
	.byte 0x20, 0x70, 0x6B, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xDA, 0x01, 0x22, 0x00, 0xE0	; 03800ABC
	.byte 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E, 0x01, 0x21, 0x0A, 0x40	; 03800ACC
	.byte 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x59, 0xE0, 0x00, 0x20, 0x28, 0x5E, 0xB8, 0x42, 0x01, 0xD0	; 03800ADC
	.byte 0x01, 0x22, 0x00, 0xE0, 0x00, 0x22, 0x20, 0x78, 0x40, 0x21, 0x88, 0x43, 0x11, 0x06, 0x0A, 0x0E	; 03800AEC
	.byte 0x01, 0x21, 0x0A, 0x40, 0x91, 0x01, 0x08, 0x43, 0x20, 0x70, 0x47, 0xE0, 0x03, 0x98, 0x00, 0x28	; 03800AFC
	.byte 0x44, 0xD0, 0xFC, 0x3E, 0x03, 0x2E, 0x41, 0xD8, 0xB0, 0x19, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 03800B0C
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x2D, 0x00, 0x09, 0x00, 0x77, 0x00, 0x71, 0x00, 0x20, 0x1C	; 03800B1C
	.byte 0x3B, 0x30, 0x00, 0x78, 0x00, 0x28, 0x31, 0xD0, 0x21, 0x1C, 0x3B, 0x31, 0x08, 0x78, 0x40, 0x1E	; 03800B2C
	.byte 0x08, 0x70, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x80, 0x00, 0x20, 0x18, 0xC0, 0x6A, 0xA0, 0x62	; 03800B3C
	.byte 0x24, 0xE0, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x00, 0x28, 0x1F, 0xD0, 0x40, 0x1E, 0x21, 0x18	; 03800B4C
	.byte 0x08, 0x1C, 0x38, 0x30, 0x00, 0x78, 0x00, 0x28, 0x0A, 0xD0, 0x40, 0x1E, 0x00, 0x06, 0x00, 0x0E	; 03800B5C
	.byte 0x00, 0x28, 0x05, 0xD1, 0x21, 0x1C, 0x3B, 0x31, 0x08, 0x78, 0x40, 0x1E, 0x08, 0x70, 0x0D, 0xE0	; 03800B6C
	.byte 0x38, 0x31, 0x08, 0x70, 0x20, 0x1C, 0x3B, 0x30, 0x00, 0x78, 0x40, 0x1E, 0x80, 0x00, 0x20, 0x18	; 03800B7C
	.byte 0xC0, 0x6A, 0xA0, 0x62, 0x02, 0xE0, 0x00, 0x20, 0xC0, 0x43, 0x09, 0xE0, 0x20, 0x6A, 0x00, 0x28	; 03800B8C
	.byte 0x05, 0xD1, 0x20, 0x78, 0xC0, 0x06, 0xC0, 0x0F, 0x00, 0x28, 0x00, 0xD1, 0x13, 0xE5, 0x00, 0x20	; 03800B9C
	.byte 0x09, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF0, 0xB5, 0x87, 0xB0, 0x04, 0x1C, 0x0E, 0x1C	; 03800BAC
	.byte 0x17, 0x1C, 0x02, 0x93, 0x00, 0x25, 0x0C, 0x99, 0x30, 0x8B, 0x72, 0x8B, 0x50, 0x43, 0xF0, 0x22	; 03800BBC
	.byte 0x51, 0x43, 0x02, 0x12, 0x50, 0x1E, 0x08, 0x18, 0x11, 0x1C, 0xFD, 0xF7, 0x95, 0xFB, 0x03, 0x90	; 03800BCC
	.byte 0x20, 0x78, 0x00, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x05, 0xD0, 0xE5, 0x6B, 0x00, 0x2D, 0x02, 0xD0	; 03800BDC
	.byte 0x2F, 0x72, 0x02, 0x98, 0x68, 0x72, 0x00, 0x2D, 0x4B, 0xD1, 0x30, 0x6A, 0x61, 0x88, 0x3A, 0x1C	; 03800BEC
	.byte 0x04, 0xAB, 0x00, 0xF0, 0x41, 0xFD, 0x00, 0x28, 0x7F, 0xD0, 0x04, 0xA8, 0x00, 0x78, 0x04, 0x28	; 03800BFC
	.byte 0x7B, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44, 0x00, 0x47	; 03800C0C
	.byte 0x17, 0x00, 0x0B, 0x00, 0x0F, 0x00, 0x13, 0x00, 0x0B, 0x00, 0x3A, 0x48, 0x04, 0xE0, 0x3A, 0x48	; 03800C1C
	.byte 0x02, 0xE0, 0x3A, 0x48, 0x00, 0xE0, 0x68, 0xE0, 0xE1, 0x8B, 0x08, 0x40, 0x00, 0x94, 0x32, 0x79	; 03800C2C
	.byte 0xA1, 0x7C, 0x51, 0x18, 0x22, 0x78, 0x12, 0x06, 0xD2, 0x0F, 0x35, 0x4B, 0xFF, 0xF7, 0xB8, 0xF9	; 03800C3C
	.byte 0x05, 0x1C, 0x00, 0x2D, 0x59, 0xD0, 0x20, 0x78, 0x00, 0x07, 0xC0, 0x0F, 0x00, 0x28, 0x01, 0xD0	; 03800C4C
	.byte 0x00, 0x23, 0x00, 0xE0, 0x03, 0x9B, 0x30, 0x6A, 0x00, 0x90, 0x04, 0xA8, 0x01, 0x90, 0x28, 0x1C	; 03800C5C
	.byte 0x39, 0x1C, 0x02, 0x9A, 0x00, 0xF0, 0xAE, 0xFC, 0x00, 0x28, 0x07, 0xD1, 0x00, 0x21, 0x28, 0x1C	; 03800C6C
	.byte 0x22, 0x30, 0x01, 0x70, 0x28, 0x1C, 0xFF, 0xF7, 0x95, 0xF9, 0x3E, 0xE0, 0xE0, 0x6B, 0x28, 0x65	; 03800C7C
	.byte 0xE5, 0x63, 0xA1, 0x7B, 0xFF, 0x29, 0x02, 0xD0, 0x28, 0x1C, 0xFF, 0xF7, 0x11, 0xFA, 0xE1, 0x7B	; 03800C8C
	.byte 0xFF, 0x29, 0x02, 0xD0, 0x28, 0x1C, 0xFF, 0xF7, 0x01, 0xFA, 0x21, 0x7C, 0xFF, 0x29, 0x02, 0xD0	; 03800C9C
	.byte 0x28, 0x1C, 0xFF, 0xF7, 0xF9, 0xF9, 0x61, 0x7C, 0xFF, 0x29, 0x02, 0xD0, 0x28, 0x1C, 0xFF, 0xF7	; 03800CAC
	.byte 0xE9, 0xF9, 0x16, 0x20, 0x20, 0x5E, 0x68, 0x86, 0x20, 0x78, 0x80, 0x06, 0xC0, 0x0F, 0x00, 0x28	; 03800CBC
	.byte 0x09, 0xD0, 0x29, 0x1C, 0x32, 0x31, 0x00, 0x20, 0x08, 0x5E, 0x22, 0x7D, 0xD2, 0x1B, 0x92, 0x05	; 03800CCC
	.byte 0x12, 0x14, 0x80, 0x18, 0x08, 0x80, 0x60, 0x7D, 0x00, 0x28, 0x02, 0xD1, 0x03, 0x98, 0xA8, 0x61	; 03800CDC
	.byte 0x09, 0xE0, 0x01, 0x1C, 0x41, 0x43, 0x32, 0x20, 0x28, 0x5E, 0x00, 0x28, 0x00, 0xDA, 0x40, 0x42	; 03800CEC
	.byte 0x41, 0x43, 0xC8, 0x12, 0xA8, 0x61, 0x00, 0x20, 0x68, 0x61, 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 03800CFC
	.byte 0x18, 0x47, 0xC0, 0x46, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x00	; 03800D0C
	.byte 0xB9, 0x0D, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x24, 0x28, 0x1C, 0x21, 0x1C	; 03800D1C
	.byte 0x00, 0xF0, 0xA8, 0xF8, 0x00, 0x28, 0x02, 0xD0, 0x29, 0x1C, 0x00, 0xF0, 0x07, 0xF8, 0x64, 0x1C	; 03800D2C
	.byte 0x10, 0x2C, 0xF3, 0xDB, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03800D38

; ===== function loc_03800D38 =====
loc_03800D38:
	push {r4,r5,r6,r7,lr}	; 03800D38
	sub sp,#0x4	; 03800D3A
	add r2,r0,#0x0	; 03800D3C
	ldr r0,[r2,#0x3c]	; 03800D3E
	mov r3,#0x6	; 03800D40
	ldrsh r6,[r1,r3]	; 03800D42
	mov r3,#0xa	; 03800D44
	ldrsh r5,[r2,r3]	; 03800D46
	ldrb r1,[r1,#0x5]	; 03800D48
	lsl r1,r1,#0x1	; 03800D4A
	ldr r4,[pool_03800DB4]	; 03800D4C
	ldrsh r3,[r4,r1]	; 03800D4E
	ldrb r1,[r2,#0x4]	; 03800D50
	lsl r1,r1,#0x1	; 03800D52
	ldrsh r1,[r4,r1]	; 03800D54
	ldrb r7,[r2,#0x5]	; 03800D56
	lsl r7,r7,#0x1	; 03800D58
	ldrsh r4,[r4,r7]	; 03800D5A
	add r1,r1,r4	; 03800D5C
	add r1,r3,r1	; 03800D5E
	add r1,r5,r1	; 03800D60
	add r4,r6,r1	; 03800D62
	mov r1,#0x8	; 03800D64
	ldrsb r3,[r2,r1]	; 03800D66
	mov r1,#0x9	; 03800D68
	ldrsb r1,[r2,r1]	; 03800D6A
	add r3,r3,r1	; 03800D6C
	mov r1,#0x6	; 03800D6E
	ldrsb r5,[r2,r1]	; 03800D70
	ldrb r1,[r2,#0x7]	; 03800D72
	lsl r1,r1,#0x6	; 03800D74
	mul r5,r1	; 03800D76
	asr r5,r5,#0x7	; 03800D78
	mov r1,#0xc	; 03800D7A
	ldrsh r1,[r2,r1]	; 03800D7C
	add r1,r5,r1	; 03800D7E
	mov r5,#0x7f	; 03800D80
	mvn r6,r5	; 03800D82
	cmp r3,r6	; 03800D84
	bge loc_03800D8C	; 03800D86
	add r3,r6,#0x0	; 03800D88
	b loc_03800DA8	; 03800D8A
loc_03800D8C:
	cmp r3,#0x7f	; 03800D8C
	ble loc_03800DA8	; 03800D8E
	add r3,r5,#0x0	; 03800D90
	b loc_03800DA8	; 03800D92
loc_03800D94:
	strh r4,[r0,#0xc]	; 03800D94
	strh r1,[r0,#0xe]	; 03800D96
	strb r3,[r0,#0xb]	; 03800D98
	ldrh r5,[r2,#0x18]	; 03800D9A
	strh r5,[r0,#0x28]	; 03800D9C
	ldrh r5,[r2,#0x1a]	; 03800D9E
	strh r5,[r0,#0x2a]	; 03800DA0
	ldrh r5,[r2,#0x1c]	; 03800DA2
	strh r5,[r0,#0x2c]	; 03800DA4
	ldr r0,[r0,#0x50]	; 03800DA6
loc_03800DA8:
	cmp r0,#0x0	; 03800DA8
	bne loc_03800D94	; 03800DAA
	add sp,#0x4	; 03800DAC
	pop {r4,r5,r6,r7}	; 03800DAE
	pop {r3}	; 03800DB0
	bx r3	; 03800DB2
pool_03800DB4:
loc_03800DB4:
	.word 0x03805120	; 03800DB4
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x14, 0x1C, 0x01, 0x29, 0x06, 0xD1, 0x01, 0x22, 0x29, 0x1C	; 03800DC8
	.byte 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xE8, 0xF8, 0x07, 0xE0, 0x02, 0x29, 0x05, 0xD1, 0x00, 0x22	; 03800DD8
	.byte 0x29, 0x1C, 0x22, 0x31, 0x0A, 0x70, 0xFF, 0xF7, 0xDF, 0xF8, 0xE1, 0x6B, 0xA9, 0x42, 0x08, 0xD1	; 03800DE8
	.byte 0x28, 0x6D, 0xE0, 0x63, 0x08, 0xE0, 0xA8, 0x42, 0x02, 0xD1, 0x28, 0x6D, 0x08, 0x65, 0x03, 0xE0	; 03800DF8
	.byte 0x01, 0x1C, 0x08, 0x6D, 0x00, 0x28, 0xF6, 0xD1, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03800E08

; ===== function loc_03800E08 =====
loc_03800E08:
	push {r4,r5,lr}	; 03800E08
	sub sp,#0x4	; 03800E0A
	add r4,r0,#0x0	; 03800E0C
	mov r5,#0x0	; 03800E0E
loc_03800E10:
	add r0,r4,#0x0	; 03800E10
	add r1,r5,#0x0	; 03800E12
	bl loc_03800E2C	; 03800E14
	add r5,r5,#0x1	; 03800E18
	cmp r5,#0x10	; 03800E1A
	blt loc_03800E10	; 03800E1C
	mov r0,#0x0	; 03800E1E
	strb r0,[r4,#0x0]	; 03800E20
	add sp,#0x4	; 03800E22
	pop {r4,r5}	; 03800E24
	pop {r3}	; 03800E26
	bx r3	; 03800E28
	.byte 0x00, 0x00	; 03800E2C

; ===== function loc_03800E2C =====
loc_03800E2C:
	push {r4,r5,lr}	; 03800E2C
	sub sp,#0x4	; 03800E2E
	add r5,r0,#0x0	; 03800E30
	add r4,r1,#0x0	; 03800E32
	bl loc_03800E70	; 03800E34
	cmp r0,#0x0	; 03800E38
	beq loc_03800E56	; 03800E3A
	add r1,r5,#0x0	; 03800E3C
	bl loc_03800E64	; 03800E3E
	add r5,#0x8	; 03800E42
	ldr r3,[pool_03800E60]	; 03800E44
	ldrb r0,[r5,r4]	; 03800E46
	lsl r2,r0,#0x6	; 03800E48
	ldrb r1,[r3,r2]	; 03800E4A
	mov r0,#0x1	; 03800E4C
	bic r1,r0	; 03800E4E
	strb r1,[r3,r2]	; 03800E50
	mov r0,#0xff	; 03800E52
	strb r0,[r5,r4]	; 03800E54
loc_03800E56:
	add sp,#0x4	; 03800E56
	pop {r4,r5}	; 03800E58
	pop {r3}	; 03800E5A
	bx r3	; 03800E5C
	.byte 0xC0, 0x46	; 03800E60
pool_03800E60:
loc_03800E60:
	.word 0x0380669C	; 03800E60

; ===== function loc_03800E64 =====
loc_03800E64:
	mov r2,#0x0	; 03800E64
	mvn r2,r2	; 03800E66
	ldr r3,[pool_03800E6C]	; 03800E68
	bx r3	; 03800E6A
pool_03800E6C:
loc_03800E6C:
	.word 0x03800EF9	; 03800E6C

; ===== function loc_03800E70 =====
loc_03800E70:
	cmp r1,#0xf	; 03800E70
	ble loc_03800E78	; 03800E72
	mov r0,#0x0	; 03800E74
	bx lr	; 03800E76
loc_03800E78:
	add r0,r0,r1	; 03800E78
	ldrb r0,[r0,#0x8]	; 03800E7A
	cmp r0,#0xff	; 03800E7C
	bne loc_03800E84	; 03800E7E
	mov r0,#0x0	; 03800E80
	bx lr	; 03800E82
loc_03800E84:
	ldr r1,[pool_03800E8C]	; 03800E84
	lsl r0,r0,#0x6	; 03800E86
	add r0,r1,r0	; 03800E88
	bx lr	; 03800E8A
pool_03800E8C:
loc_03800E8C:
	.word 0x0380669C	; 03800E8C
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x24, 0x29, 0x1C, 0x1C, 0x31, 0x03, 0xE0, 0x08, 0x88	; 03800EA0
	.byte 0xF0, 0x38, 0x08, 0x80, 0x64, 0x1C, 0xA8, 0x8B, 0xF0, 0x28, 0xF8, 0xD2, 0x11, 0x48, 0x02, 0x68	; 03800EB0
	.byte 0x00, 0x2A, 0x11, 0xD0, 0x40, 0x32, 0xA9, 0x78, 0x24, 0x20, 0x41, 0x43, 0x50, 0x58, 0x00, 0x19	; 03800EC0
	.byte 0x50, 0x50, 0x09, 0xE0, 0x28, 0x1C, 0xFF, 0xF7, 0x31, 0xFB, 0x00, 0x28, 0x03, 0xD0, 0x28, 0x1C	; 03800ED0
	.byte 0xFF, 0xF7, 0x9A, 0xFF, 0x02, 0xE0, 0x64, 0x1E, 0x00, 0x2C, 0xF3, 0xDC, 0x2A, 0x8B, 0x68, 0x8B	; 03800EE0
	.byte 0x42, 0x43, 0x1C, 0x35, 0x29, 0x88, 0x10, 0x12, 0x08, 0x18, 0x28, 0x80, 0x01, 0xB0, 0x30, 0xBC	; 03800EF0
	.byte 0x08, 0xBC, 0x18, 0x47, 0x18, 0x5F, 0x80, 0x03	; 03800EF8

; ===== function loc_03800EF8 =====
loc_03800EF8:
	push {r4,r5,r6,r7,lr}	; 03800EF8
	sub sp,#0x4	; 03800EFA
	add r5,r0,#0x0	; 03800EFC
	add r6,r2,#0x0	; 03800EFE
	ldr r4,[r5,#0x3c]	; 03800F00
	bl loc_03800D38	; 03800F02
	lsl r0,r6,#0x18	; 03800F06
	lsr r7,r0,#0x18	; 03800F08
	b loc_03800F38	; 03800F0A
loc_03800F0C:
	add r0,r4,#0x0	; 03800F0C
	bl loc_03800070	; 03800F0E
	cmp r0,#0x0	; 03800F12
	beq loc_03800F30	; 03800F14
	cmp r6,#0x0	; 03800F16
	blt loc_03800F22	; 03800F18
	add r0,r4,#0x0	; 03800F1A
	add r1,r7,#0x0	; 03800F1C
	bl loc_03800080	; 03800F1E
loc_03800F22:
	add r1,r4,#0x0	; 03800F22
	add r1,#0x22	; 03800F24
	mov r0,#0x1	; 03800F26
	strb r0,[r1,#0x0]	; 03800F28
	add r0,r4,#0x0	; 03800F2A
	bl loc_03800078	; 03800F2C
loc_03800F30:
	add r0,r4,#0x0	; 03800F30
	bl loc_037FFFA0	; 03800F32
	ldr r4,[r4,#0x50]	; 03800F36
loc_03800F38:
	cmp r4,#0x0	; 03800F38
	bne loc_03800F0C	; 03800F3A
	mov r0,#0x0	; 03800F3C
	str r0,[r5,#0x3c]	; 03800F3E
	add sp,#0x4	; 03800F40
	pop {r4,r5,r6,r7}	; 03800F42
	pop {r3}	; 03800F44
	bx r3	; 03800F46

; ===== function loc_03800F48 =====
loc_03800F48:
	push {r4,r5,r6,r7,lr}	; 03800F48
	sub sp,#0x4	; 03800F4A
	mov r2,#0x0	; 03800F4C
	strb r2,[r0,#0x1]	; 03800F4E
	str r1,[r0,#0x20]	; 03800F50
	mov r1,#0x78	; 03800F52
	strh r1,[r0,#0x18]	; 03800F54
	ldr r1,[pool_03800FA4]	; 03800F56
	strh r1,[r0,#0x1a]	; 03800F58
	strh r2,[r0,#0x1c]	; 03800F5A
	mov r1,#0x7f	; 03800F5C
	strb r1,[r0,#0x5]	; 03800F5E
	strh r2,[r0,#0x6]	; 03800F60
	mov r1,#0x40	; 03800F62
	strb r1,[r0,#0x4]	; 03800F64
	mov r3,#0xff	; 03800F66
loc_03800F68:
	add r1,r0,r2	; 03800F68
	strb r3,[r1,#0x8]	; 03800F6A
	add r2,r2,#0x1	; 03800F6C
	cmp r2,#0x10	; 03800F6E
	blt loc_03800F68	; 03800F70
	ldr r4,[pool_03800FA8]	; 03800F72
	ldr r5,[r4,#0x0]	; 03800F74
	cmp r5,#0x0	; 03800F76
	beq loc_03800F9C	; 03800F78
	mov r2,#0x0	; 03800F7A
	ldrb r1,[r0,#0x2]	; 03800F7C
	mov r3,#0x24	; 03800F7E
	mul r1,r3	; 03800F80
	add r1,r5,r1	; 03800F82
	str r2,[r1,#0x40]	; 03800F84
	mvn r1,r2	; 03800F86
loc_03800F88:
	ldr r7,[r4,#0x0]	; 03800F88
	ldrb r5,[r0,#0x2]	; 03800F8A
	mul r5,r3	; 03800F8C
	lsl r6,r2,#0x1	; 03800F8E
	add r5,r7,r5	; 03800F90
	add r5,r6,r5	; 03800F92
	strh r1,[r5,#0x20]	; 03800F94
	add r2,r2,#0x1	; 03800F96
	cmp r2,#0x10	; 03800F98
	blt loc_03800F88	; 03800F9A
loc_03800F9C:
	add sp,#0x4	; 03800F9C
	pop {r4,r5,r6,r7}	; 03800F9E
	pop {r3}	; 03800FA0
	bx r3	; 03800FA2
pool_03800FA4:
loc_03800FA4:
	.word 0x00000100	; 03800FA4
pool_03800FA8:
loc_03800FA8:
	.word 0x03805F18	; 03800FA8

; ===== function loc_03800FAC =====
loc_03800FAC:
	str r1,[r0,#0x24]	; 03800FAC
	ldr r1,[r0,#0x24]	; 03800FAE
	add r1,r1,r2	; 03800FB0
	str r1,[r0,#0x28]	; 03800FB2
	bx lr	; 03800FB4
	.byte 0x00, 0x00	; 03800FB8

; ===== function loc_03800FB8 =====
loc_03800FB8:
	push {r4,r5,lr}	; 03800FB8
	sub sp,#0x4	; 03800FBA
	add r4,r0,#0x0	; 03800FBC
	mov r1,#0x0	; 03800FBE
	str r1,[r4,#0x24]	; 03800FC0
	str r1,[r4,#0x28]	; 03800FC2
	ldrb r2,[r4,#0x0]	; 03800FC4
	mov r0,#0x2	; 03800FC6
	orr r2,r0	; 03800FC8
	strb r2,[r4,#0x0]	; 03800FCA
	ldrb r3,[r4,#0x0]	; 03800FCC
	mov r2,#0x4	; 03800FCE
	bic r3,r2	; 03800FD0
	strb r3,[r4,#0x0]	; 03800FD2
	ldrb r3,[r4,#0x0]	; 03800FD4
	mov r2,#0x8	; 03800FD6
	bic r3,r2	; 03800FD8
	strb r3,[r4,#0x0]	; 03800FDA
	ldrb r3,[r4,#0x0]	; 03800FDC
	mov r2,#0x10	; 03800FDE
	bic r3,r2	; 03800FE0
	strb r3,[r4,#0x0]	; 03800FE2
	ldrb r3,[r4,#0x0]	; 03800FE4
	mov r2,#0x20	; 03800FE6
	bic r3,r2	; 03800FE8
	strb r3,[r4,#0x0]	; 03800FEA
	ldrb r2,[r4,#0x0]	; 03800FEC
	mov r3,#0x40	; 03800FEE
	orr r2,r3	; 03800FF0
	strb r2,[r4,#0x0]	; 03800FF2
	ldrb r5,[r4,#0x0]	; 03800FF4
	mov r2,#0x80	; 03800FF6
	bic r5,r2	; 03800FF8
	strb r5,[r4,#0x0]	; 03800FFA
	add r2,r4,#0x0	; 03800FFC
	add r2,#0x3b	; 03800FFE
	strb r1,[r2,#0x0]	; 03801000
	strh r1,[r4,#0x2]	; 03801002
	strb r3,[r4,#0x12]	; 03801004
	mov r2,#0x7f	; 03801006
	strb r2,[r4,#0x4]	; 03801008
	strb r2,[r4,#0x5]	; 0380100A
	strh r1,[r4,#0xa]	; 0380100C
	strb r1,[r4,#0x8]	; 0380100E
	strb r1,[r4,#0x9]	; 03801010
	strb r1,[r4,#0x6]	; 03801012
	strh r1,[r4,#0xc]	; 03801014
	mov r2,#0xff	; 03801016
	strb r2,[r4,#0xe]	; 03801018
	strb r2,[r4,#0xf]	; 0380101A
	strb r2,[r4,#0x10]	; 0380101C
	strb r2,[r4,#0x11]	; 0380101E
	strb r0,[r4,#0x7]	; 03801020
	mov r0,#0x3c	; 03801022
	strb r0,[r4,#0x14]	; 03801024
	strb r1,[r4,#0x15]	; 03801026
	strh r1,[r4,#0x16]	; 03801028
	strb r1,[r4,#0x13]	; 0380102A
	ldr r0,[pool_03801048]	; 0380102C
	strh r0,[r4,#0x1e]	; 0380102E
	add r0,r4,#0x0	; 03801030
	add r0,#0x18	; 03801032
	bl loc_037FFDE8	; 03801034
	mov r0,#0x0	; 03801038
	str r0,[r4,#0x20]	; 0380103A
	str r0,[r4,#0x3c]	; 0380103C
	add sp,#0x4	; 0380103E
	pop {r4,r5}	; 03801040
	pop {r3}	; 03801042
	bx r3	; 03801044
	.byte 0xC0, 0x46	; 03801048
pool_03801048:
loc_03801048:
	.word 0x0000FFFF	; 03801048

; ===== function loc_0380104C =====
	push {r4,r5,r6,lr}	; 0380104C
	add r4,r0,#0x0	; 0380104E
	add r6,r1,#0x0	; 03801050
	cmp r2,#0x4	; 03801052
	bhi loc_038010BC	; 03801054
	add r1,r2,r2	; 03801056
	add r1,pc	; 03801058
	ldrh r1,[r1,#0x8]	; 0380105A
	lsl r1,r1,#0x10	; 0380105C
	asr r1,r1,#0x10	; 0380105E
	add r1,pc	; 03801060
	bx r1	; 03801062
	.byte 0x0B, 0x00, 0x13, 0x00, 0x1B, 0x00, 0x39, 0x00, 0x23, 0x00	; 0380106E
loc_0380106E:
	bl loc_03801178	; 0380106E
	add r5,r0,#0x0	; 03801072
	b loc_038010BC	; 03801074
loc_03801076:
	bl loc_03801140	; 03801076
	add r5,r0,#0x0	; 0380107A
	b loc_038010BC	; 0380107C
loc_0380107E:
	bl loc_038010C4	; 0380107E
	add r5,r0,#0x0	; 03801082
	b loc_038010BC	; 03801084
loc_03801086:
	bl loc_03801178	; 03801086
	add r1,r0,#0x0	; 0380108A
	add r0,r6,#0x0	; 0380108C
	bl loc_038004F8	; 0380108E
	cmp r0,#0x0	; 03801092
	beq loc_038010BC	; 03801094
	mov r1,#0x0	; 03801096
	ldrsh r5,[r0,r1]	; 03801098
	b loc_038010BC	; 0380109A
loc_0380109C:
	bl loc_03801140	; 0380109C
	lsl r0,r0,#0x10	; 038010A0
	asr r5,r0,#0x10	; 038010A2
	add r0,r4,#0x0	; 038010A4
	bl loc_03801140	; 038010A6
	lsl r0,r0,#0x10	; 038010AA
	asr r4,r0,#0x10	; 038010AC
	bl loc_037FF7B4	; 038010AE
	sub r1,r4,r5	; 038010B2
	add r1,r1,#0x1	; 038010B4
	mul r0,r1	; 038010B6
	asr r0,r0,#0x10	; 038010B8
	add r5,r0,r5	; 038010BA
loc_038010BC:
	add r0,r5,#0x0	; 038010BC
	pop {r4,r5,r6}	; 038010BE
	pop {r3}	; 038010C0
	bx r3	; 038010C2

; ===== function loc_038010C4 =====
loc_038010C4:
	push {r4,r5,r6,r7,lr}	; 038010C4
	sub sp,#0x4	; 038010C6
	add r6,r0,#0x0	; 038010C8
	mov r5,#0x0	; 038010CA
	add r4,r6,#0x0	; 038010CC
	add r4,#0x28	; 038010CE
	mov r7,#0x80	; 038010D0
loc_038010D2:
	ldr r0,[r6,#0x28]	; 038010D2
	bl loc_03801190	; 038010D4
	ldr r1,[r4,#0x0]	; 038010D8
	add r1,r1,#0x1	; 038010DA
	str r1,[r4,#0x0]	; 038010DC
	lsl r5,r5,#0x7	; 038010DE
	add r2,r0,#0x0	; 038010E0
	mov r1,#0x7f	; 038010E2
	and r2,r1	; 038010E4
	orr r5,r2	; 038010E6
	and r0,r7	; 038010E8
	cmp r0,#0x0	; 038010EA
	bne loc_038010D2	; 038010EC
	add r0,r5,#0x0	; 038010EE
	add sp,#0x4	; 038010F0
	pop {r4,r5,r6,r7}	; 038010F2
	pop {r3}	; 038010F4
	bx r3	; 038010F6
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0xA8, 0x6A, 0x00, 0xF0, 0x46, 0xF8, 0x04, 0x1C, 0x29, 0x1C	; 03801108
	.byte 0x28, 0x31, 0x08, 0x68, 0x40, 0x1C, 0x08, 0x60, 0xA8, 0x6A, 0x00, 0xF0, 0x3D, 0xF8, 0x00, 0x02	; 03801118
	.byte 0x04, 0x43, 0x29, 0x1C, 0x28, 0x31, 0x08, 0x68, 0x40, 0x1C, 0x08, 0x60, 0xA8, 0x6A, 0x00, 0xF0	; 03801128
	.byte 0x33, 0xF8, 0x00, 0x04, 0x04, 0x43, 0x28, 0x35, 0x28, 0x68, 0x40, 0x1C, 0x28, 0x60, 0x20, 0x1C	; 03801138
	.byte 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03801140

; ===== function loc_03801140 =====
loc_03801140:
	push {r4,r5,lr}	; 03801140
	sub sp,#0x4	; 03801142
	add r5,r0,#0x0	; 03801144
	ldr r0,[r5,#0x28]	; 03801146
	bl loc_03801190	; 03801148
	add r4,r0,#0x0	; 0380114C
	add r1,r5,#0x0	; 0380114E
	add r1,#0x28	; 03801150
	ldr r0,[r1,#0x0]	; 03801152
	add r0,r0,#0x1	; 03801154
	str r0,[r1,#0x0]	; 03801156
	ldr r0,[r5,#0x28]	; 03801158
	bl loc_03801190	; 0380115A
	lsl r0,r0,#0x8	; 0380115E
	orr r4,r0	; 03801160
	lsl r0,r4,#0x10	; 03801162
	lsr r0,r0,#0x10	; 03801164
	add r5,#0x28	; 03801166
	ldr r1,[r5,#0x0]	; 03801168
	add r1,r1,#0x1	; 0380116A
	str r1,[r5,#0x0]	; 0380116C
	add sp,#0x4	; 0380116E
	pop {r4,r5}	; 03801170
	pop {r3}	; 03801172
	bx r3	; 03801174
	.byte 0x00, 0x00	; 03801178

; ===== function loc_03801178 =====
loc_03801178:
	push {r4,lr}	; 03801178
	add r4,r0,#0x0	; 0380117A
	ldr r0,[r4,#0x28]	; 0380117C
	bl loc_03801190	; 0380117E
	add r4,#0x28	; 03801182
	ldr r1,[r4,#0x0]	; 03801184
	add r1,r1,#0x1	; 03801186
	str r1,[r4,#0x0]	; 03801188
	pop {r4}	; 0380118A
	pop {r3}	; 0380118C
	bx r3	; 0380118E

; ===== function loc_03801190 =====
loc_03801190:
	push {r4,lr}	; 03801190
	add r4,r0,#0x0	; 03801192
	ldr r0,[pool_038011B8]	; 03801194
	ldr r1,[r0,#0x0]	; 03801196
	cmp r4,r1	; 03801198
	bcc loc_038011A2	; 0380119A
	ldr r0,[r0,#0x4]	; 0380119C
	cmp r4,r0	; 0380119E
	bcc loc_038011A8	; 038011A0
loc_038011A2:
	add r0,r4,#0x0	; 038011A2
	bl loc_038011C0	; 038011A4
loc_038011A8:
	ldr r0,[pool_038011B8]	; 038011A8
	ldr r0,[r0,#0x0]	; 038011AA
	sub r1,r4,r0	; 038011AC
	ldr r0,[pool_038011BC]	; 038011AE
	ldrb r0,[r0,r1]	; 038011B0
	pop {r4}	; 038011B2
	pop {r3}	; 038011B4
	bx r3	; 038011B6
pool_038011B8:
loc_038011B8:
	.word 0x03805F00	; 038011B8
pool_038011BC:
loc_038011BC:
	.word 0x03805F08	; 038011BC

; ===== function loc_038011C0 =====
loc_038011C0:
	mov r1,#0x3	; 038011C0
	bic r0,r1	; 038011C2
	ldr r1,[pool_038011E0]	; 038011C4
	str r0,[r1,#0x0]	; 038011C6
	add r2,r0,#0x0	; 038011C8
	add r2,#0x10	; 038011CA
	str r2,[r1,#0x4]	; 038011CC
	ldr r2,[r0,#0x0]	; 038011CE
	str r2,[r1,#0x8]	; 038011D0
	ldr r2,[r0,#0x4]	; 038011D2
	str r2,[r1,#0xc]	; 038011D4
	ldr r2,[r0,#0x8]	; 038011D6
	str r2,[r1,#0x10]	; 038011D8
	ldr r0,[r0,#0xc]	; 038011DA
	str r0,[r1,#0x14]	; 038011DC
	bx lr	; 038011DE
pool_038011E0:
loc_038011E0:
	.word 0x03805F00	; 038011E0

; ===== function loc_038011E4 =====
loc_038011E4:
	push {r4,r5,r6,r7,lr}	; 038011E4
	sub sp,#0x4	; 038011E6
	add r6,r1,#0x0	; 038011E8
	add r5,r3,#0x0	; 038011EA
	ldr r4,[sp,#0x18]	; 038011EC
	ldr r3,[pool_0380123C]	; 038011EE
	mov r1,#0x24	; 038011F0
	mul r0,r1	; 038011F2
	add r7,r3,r0	; 038011F4
	mov r3,#0x0	; 038011F6
	b loc_0380122C	; 038011F8
loc_038011FA:
	add r1,r6,#0x0	; 038011FA
	mov r0,#0x1	; 038011FC
	and r1,r0	; 038011FE
	cmp r1,#0x0	; 03801200
	beq loc_03801228	; 03801202
	add r0,r7,#0x0	; 03801204
	add r1,r3,#0x0	; 03801206
	bl loc_03800E70	; 03801208
	cmp r0,#0x0	; 0380120C
	beq loc_03801228	; 0380120E
	cmp r4,#0x1	; 03801210
	beq loc_0380121E	; 03801212
	cmp r4,#0x2	; 03801214
	beq loc_03801222	; 03801216
	cmp r4,#0x4	; 03801218
	beq loc_03801226	; 0380121A
	b loc_03801228	; 0380121C
loc_0380121E:
	strb r5,[r0,r2]	; 0380121E
	b loc_03801228	; 03801220
loc_03801222:
	strh r5,[r0,r2]	; 03801222
	b loc_03801228	; 03801224
loc_03801226:
	str r5,[r0,r2]	; 03801226
loc_03801228:
	add r3,r3,#0x1	; 03801228
	lsr r6,r6,#0x1	; 0380122A
loc_0380122C:
	cmp r3,#0x10	; 0380122C
	bge loc_03801234	; 0380122E
	cmp r6,#0x0	; 03801230
	bne loc_038011FA	; 03801232
loc_03801234:
	add sp,#0x4	; 03801234
	pop {r4,r5,r6,r7}	; 03801236
	pop {r3}	; 03801238
	bx r3	; 0380123A
pool_0380123C:
loc_0380123C:
	.word 0x0380645C	; 0380123C

; ===== function loc_03801240 =====
loc_03801240:
	push {r4,r5,lr}	; 03801240
	sub sp,#0x4	; 03801242
	ldr r5,[pool_0380126C]	; 03801244
	mov r4,#0x24	; 03801246
	mul r0,r4	; 03801248
	add r0,r5,r0	; 0380124A
	cmp r3,#0x1	; 0380124C
	beq loc_0380125A	; 0380124E
	cmp r3,#0x2	; 03801250
	beq loc_0380125E	; 03801252
	cmp r3,#0x4	; 03801254
	beq loc_03801262	; 03801256
	b loc_03801264	; 03801258
loc_0380125A:
	strb r2,[r0,r1]	; 0380125A
	b loc_03801264	; 0380125C
loc_0380125E:
	strh r2,[r0,r1]	; 0380125E
	b loc_03801264	; 03801260
loc_03801262:
	str r2,[r0,r1]	; 03801262
loc_03801264:
	add sp,#0x4	; 03801264
	pop {r4,r5}	; 03801266
	pop {r3}	; 03801268
	bx r3	; 0380126A
pool_0380126C:
loc_0380126C:
	.word 0x0380645C	; 0380126C

; ===== function loc_03801270 =====
loc_03801270:
	push {r4,r5,r6,r7,lr}	; 03801270
	sub sp,#0x4	; 03801272
	add r5,r0,#0x0	; 03801274
	add r6,r1,#0x0	; 03801276
	mov r4,#0x0	; 03801278
	ldr r7,[pool_038012A8]	; 0380127A
loc_0380127C:
	add r1,r4,#0x0	; 0380127C
	mov r0,#0x24	; 0380127E
	mul r1,r0	; 03801280
	add r0,r7,r1	; 03801282
	ldrb r1,[r7,r1]	; 03801284
	cmp r1,#0x0	; 03801286
	beq loc_03801298	; 03801288
	ldr r1,[r0,#0x20]	; 0380128A
	cmp r5,r1	; 0380128C
	bhi loc_03801298	; 0380128E
	cmp r1,r6	; 03801290
	bhi loc_03801298	; 03801292
	bl loc_03800E08	; 03801294
loc_03801298:
	add r4,r4,#0x1	; 03801298
	cmp r4,#0x10	; 0380129A
	blt loc_0380127C	; 0380129C
	add sp,#0x4	; 0380129E
	pop {r4,r5,r6,r7}	; 038012A0
	pop {r3}	; 038012A2
	bx r3	; 038012A4
	.byte 0xC0, 0x46	; 038012A8
pool_038012A8:
loc_038012A8:
	.word 0x0380645C	; 038012A8

; ===== function loc_038012AC =====
loc_038012AC:
	push {r4,r5,r6,r7,lr}	; 038012AC
	sub sp,#0x4	; 038012AE
	add r5,r0,#0x0	; 038012B0
	add r6,r1,#0x0	; 038012B2
	mov r4,#0x0	; 038012B4
	add r7,r4,#0x0	; 038012B6
loc_038012B8:
	add r0,r4,#0x0	; 038012B8
	mov r1,#0x24	; 038012BA
	mul r0,r1	; 038012BC
	ldr r1,[pool_03801300]	; 038012BE
	add r3,r1,r0	; 038012C0
	ldrb r0,[r1,r0]	; 038012C2
	cmp r0,#0x0	; 038012C4
	beq loc_038012F0	; 038012C6
	add r2,r7,#0x0	; 038012C8
	b loc_038012EC	; 038012CA
loc_038012CC:
	add r0,r3,#0x0	; 038012CC
	add r1,r2,#0x0	; 038012CE
	bl loc_03800E70	; 038012D0
	cmp r0,#0x0	; 038012D4
	beq loc_038012EA	; 038012D6
	ldr r0,[r0,#0x28]	; 038012D8
	cmp r5,r0	; 038012DA
	bhi loc_038012EA	; 038012DC
	cmp r0,r6	; 038012DE
	bhi loc_038012EA	; 038012E0
	add r0,r3,#0x0	; 038012E2
	bl loc_03800E08	; 038012E4
	b loc_038012F0	; 038012E8
loc_038012EA:
	add r2,r2,#0x1	; 038012EA
loc_038012EC:
	cmp r2,#0x10	; 038012EC
	blt loc_038012CC	; 038012EE
loc_038012F0:
	add r4,r4,#0x1	; 038012F0
	cmp r4,#0x10	; 038012F2
	blt loc_038012B8	; 038012F4
	add sp,#0x4	; 038012F6
	pop {r4,r5,r6,r7}	; 038012F8
	pop {r3}	; 038012FA
	bx r3	; 038012FC
	.byte 0xC0, 0x46	; 03801300
pool_03801300:
loc_03801300:
	.word 0x0380645C	; 03801300

; ===== function loc_03801304 =====
loc_03801304:
	push {r4,r5,r6,r7,lr}	; 03801304
	sub sp,#0x4	; 03801306
	add r5,r1,#0x0	; 03801308
	ldr r3,[pool_03801350]	; 0380130A
	mov r1,#0x24	; 0380130C
	mul r0,r1	; 0380130E
	add r4,r3,r0	; 03801310
	mov r3,#0x0	; 03801312
	lsl r0,r2,#0x10	; 03801314
	lsr r2,r0,#0x10	; 03801316
	mov r7,#0x80	; 03801318
	mov r6,#0x1	; 0380131A
	b loc_03801340	; 0380131C
loc_0380131E:
	add r0,r5,#0x0	; 0380131E
	and r0,r6	; 03801320
	cmp r0,#0x0	; 03801322
	beq loc_0380133C	; 03801324
	add r0,r4,#0x0	; 03801326
	add r1,r3,#0x0	; 03801328
	bl loc_03800E70	; 0380132A
	add r1,r0,#0x0	; 0380132E
	cmp r1,#0x0	; 03801330
	beq loc_0380133C	; 03801332
	strh r2,[r1,#0x1e]	; 03801334
	ldrb r0,[r1,#0x0]	; 03801336
	orr r0,r7	; 03801338
	strb r0,[r1,#0x0]	; 0380133A
loc_0380133C:
	add r3,r3,#0x1	; 0380133C
	lsr r5,r5,#0x1	; 0380133E
loc_03801340:
	cmp r3,#0x10	; 03801340
	bge loc_03801348	; 03801342
	cmp r5,#0x0	; 03801344
	bne loc_0380131E	; 03801346
loc_03801348:
	add sp,#0x4	; 03801348
	pop {r4,r5,r6,r7}	; 0380134A
	pop {r3}	; 0380134C
	bx r3	; 0380134E
pool_03801350:
loc_03801350:
	.word 0x0380645C	; 03801350

; ===== function loc_03801354 =====
loc_03801354:
	push {r4,r5,r6,r7,lr}	; 03801354
	sub sp,#0x4	; 03801356
	add r5,r1,#0x0	; 03801358
	add r6,r2,#0x0	; 0380135A
	ldr r2,[pool_038013B8]	; 0380135C
	mov r1,#0x24	; 0380135E
	mul r0,r1	; 03801360
	add r0,r2,r0	; 03801362
	str r0,[sp,#0x0]	; 03801364
	mov r4,#0x0	; 03801366
	b loc_038013A6	; 03801368
loc_0380136A:
	add r1,r5,#0x0	; 0380136A
	mov r0,#0x1	; 0380136C
	and r1,r0	; 0380136E
	cmp r1,#0x0	; 03801370
	beq loc_038013A2	; 03801372
	ldr r0,[sp,#0x0]	; 03801374
	add r1,r4,#0x0	; 03801376
	bl loc_03800E70	; 03801378
	add r7,r0,#0x0	; 0380137C
	cmp r7,#0x0	; 0380137E
	beq loc_038013A2	; 03801380
	cmp r6,#0x0	; 03801382
	beq loc_0380138E	; 03801384
	ldr r1,[sp,#0x0]	; 03801386
	mov r2,#0x7f	; 03801388
	bl loc_03800EF8	; 0380138A
loc_0380138E:
	ldrb r0,[r7,#0x0]	; 0380138E
	mov r1,#0x4	; 03801390
	bic r0,r1	; 03801392
	lsl r1,r6,#0x18	; 03801394
	lsr r2,r1,#0x18	; 03801396
	mov r1,#0x1	; 03801398
	and r2,r1	; 0380139A
	lsl r1,r2,#0x2	; 0380139C
	orr r0,r1	; 0380139E
	strb r0,[r7,#0x0]	; 038013A0
loc_038013A2:
	add r4,r4,#0x1	; 038013A2
	lsr r5,r5,#0x1	; 038013A4
loc_038013A6:
	cmp r4,#0x10	; 038013A6
	bge loc_038013AE	; 038013A8
	cmp r5,#0x0	; 038013AA
	bne loc_0380136A	; 038013AC
loc_038013AE:
	add sp,#0x4	; 038013AE
	pop {r4,r5,r6,r7}	; 038013B0
	pop {r3}	; 038013B2
	bx r3	; 038013B4
	.byte 0xC0, 0x46	; 038013B8
pool_038013B8:
loc_038013B8:
	.word 0x0380645C	; 038013B8

; ===== function loc_038013BC =====
loc_038013BC:
	push {r4,r5,r6,lr}	; 038013BC
	ldr r3,[pool_038013F0]	; 038013BE
	mov r2,#0x24	; 038013C0
	mul r0,r2	; 038013C2
	add r5,r3,r0	; 038013C4
	strb r1,[r5,#0x1]	; 038013C6
	cmp r1,#0x0	; 038013C8
	beq loc_038013EA	; 038013CA
	mov r4,#0x0	; 038013CC
	mov r6,#0x7f	; 038013CE
loc_038013D0:
	add r0,r5,#0x0	; 038013D0
	add r1,r4,#0x0	; 038013D2
	bl loc_03800E70	; 038013D4
	cmp r0,#0x0	; 038013D8
	beq loc_038013E4	; 038013DA
	add r1,r5,#0x0	; 038013DC
	add r2,r6,#0x0	; 038013DE
	bl loc_03800EF8	; 038013E0
loc_038013E4:
	add r4,r4,#0x1	; 038013E4
	cmp r4,#0x10	; 038013E6
	blt loc_038013D0	; 038013E8
loc_038013EA:
	pop {r4,r5,r6}	; 038013EA
	pop {r3}	; 038013EC
	bx r3	; 038013EE
pool_038013F0:
loc_038013F0:
	.word 0x0380645C	; 038013F0

; ===== function loc_038013F4 =====
loc_038013F4:
	push {r4,lr}	; 038013F4
	add r4,r0,#0x0	; 038013F6
	ldr r2,[pool_03801428]	; 038013F8
	mov r0,#0x24	; 038013FA
	add r1,r4,#0x0	; 038013FC
	mul r1,r0	; 038013FE
	add r0,r2,r1	; 03801400
	ldrb r1,[r2,r1]	; 03801402
	cmp r1,#0x0	; 03801404
	beq loc_03801420	; 03801406
	bl loc_03800E08	; 03801408
	ldr r0,[pool_0380142C]	; 0380140C
	ldr r0,[r0,#0x0]	; 0380140E
	cmp r0,#0x0	; 03801410
	beq loc_03801420	; 03801412
	add r2,r0,#0x4	; 03801414
	ldr r1,[r2,#0x0]	; 03801416
	mov r0,#0x1	; 03801418
	lsl r0,r4	; 0380141A
	bic r1,r0	; 0380141C
	str r1,[r2,#0x0]	; 0380141E
loc_03801420:
	pop {r4}	; 03801420
	pop {r3}	; 03801422
	bx r3	; 03801424
	.byte 0xC0, 0x46	; 03801428
pool_03801428:
loc_03801428:
	.word 0x0380645C	; 03801428
pool_0380142C:
loc_0380142C:
	.word 0x03805F18	; 0380142C

; ===== function loc_03801430 =====
loc_03801430:
	push {r4,r5,r6,r7,lr}	; 03801430
	sub sp,#0xc	; 03801432
	str r0,[sp,#0x0]	; 03801434
	add r7,r1,#0x0	; 03801436
	str r2,[sp,#0x4]	; 03801438
	add r4,r3,#0x0	; 0380143A
	ldr r2,[pool_038014F4]	; 0380143C
	mov r0,#0x24	; 0380143E
	ldr r1,[sp,#0x0]	; 03801440
	mul r1,r0	; 03801442
	add r5,r2,r1	; 03801444
	ldrb r0,[r2,r1]	; 03801446
	cmp r0,#0x0	; 03801448
	beq loc_03801452	; 0380144A
	add r0,r5,#0x0	; 0380144C
	bl loc_03800E08	; 0380144E
loc_03801452:
	add r0,r5,#0x0	; 03801452
	add r1,r4,#0x0	; 03801454
	bl loc_03800F48	; 03801456
	bl loc_038004C4	; 0380145A
	add r6,r0,#0x0	; 0380145E
	cmp r6,#0x0	; 03801460
	blt loc_038014EA	; 03801462
	ldr r1,[pool_038014F8]	; 03801464
	lsl r0,r6,#0x6	; 03801466
	add r4,r1,r0	; 03801468
	add r0,r4,#0x0	; 0380146A
	bl loc_03800FB8	; 0380146C
	add r0,r4,#0x0	; 03801470
	add r1,r7,#0x0	; 03801472
	ldr r2,[sp,#0x4]	; 03801474
	bl loc_03800FAC	; 03801476
	strb r6,[r5,#0x8]	; 0380147A
	ldr r0,[r4,#0x28]	; 0380147C
	bl loc_038011C0	; 0380147E
	add r0,r4,#0x0	; 03801482
	bl loc_03801178	; 03801484
	cmp r0,#0xfe	; 03801488
	beq loc_03801496	; 0380148A
	add r4,#0x28	; 0380148C
	ldr r0,[r4,#0x0]	; 0380148E
	sub r0,r0,#0x1	; 03801490
	str r0,[r4,#0x0]	; 03801492
	b loc_038014D2	; 03801494
loc_03801496:
	add r0,r4,#0x0	; 03801496
	bl loc_03801140	; 03801498
	lsl r0,r0,#0xf	; 0380149C
	lsr r4,r0,#0x10	; 0380149E
	mov r6,#0x1	; 038014A0
	str r6,[sp,#0x8]	; 038014A2
	b loc_038014CE	; 038014A4
loc_038014A6:
	add r1,r4,#0x0	; 038014A6
	ldr r0,[sp,#0x8]	; 038014A8
	and r1,r0	; 038014AA
	cmp r1,#0x0	; 038014AC
	beq loc_038014C8	; 038014AE
	bl loc_038004C4	; 038014B0
	add r7,r0,#0x0	; 038014B4
	cmp r7,#0x0	; 038014B6
	blt loc_038014D2	; 038014B8
	lsl r1,r7,#0x6	; 038014BA
	ldr r0,[pool_038014F8]	; 038014BC
	add r0,r0,r1	; 038014BE
	bl loc_03800FB8	; 038014C0
	add r0,r5,r6	; 038014C4
	strb r7,[r0,#0x8]	; 038014C6
loc_038014C8:
	add r6,r6,#0x1	; 038014C8
	lsl r0,r4,#0xf	; 038014CA
	lsr r4,r0,#0x10	; 038014CC
loc_038014CE:
	cmp r4,#0x0	; 038014CE
	bne loc_038014A6	; 038014D0
loc_038014D2:
	mov r3,#0x1	; 038014D2
	strb r3,[r5,#0x0]	; 038014D4
	ldr r0,[pool_038014FC]	; 038014D6
	ldr r0,[r0,#0x0]	; 038014D8
	cmp r0,#0x0	; 038014DA
	beq loc_038014EA	; 038014DC
	add r2,r0,#0x4	; 038014DE
	ldr r1,[r2,#0x0]	; 038014E0
	ldr r0,[sp,#0x0]	; 038014E2
	lsl r3,r0	; 038014E4
	orr r1,r3	; 038014E6
	str r1,[r2,#0x0]	; 038014E8
loc_038014EA:
	add sp,#0xc	; 038014EA
	pop {r4,r5,r6,r7}	; 038014EC
	pop {r3}	; 038014EE
	bx r3	; 038014F0
	.byte 0xC0, 0x46	; 038014F4
pool_038014F4:
loc_038014F4:
	.word 0x0380645C	; 038014F4
pool_038014F8:
loc_038014F8:
	.word 0x0380669C	; 038014F8
pool_038014FC:
loc_038014FC:
	.word 0x03805F18	; 038014FC
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x07, 0x1C, 0x00, 0x26, 0x34, 0x1C, 0x20, 0x1C, 0x24, 0x21, 0x48, 0x43	; 03801510
	.byte 0x10, 0x49, 0x0D, 0x18, 0x08, 0x5C, 0x00, 0x28, 0x10, 0xD0, 0x00, 0x2F, 0x05, 0xD0, 0x68, 0x78	; 03801520
	.byte 0x00, 0x28, 0x02, 0xD1, 0x28, 0x1C, 0xFF, 0xF7, 0xB3, 0xFC, 0x28, 0x1C, 0xFF, 0xF7, 0xF0, 0xFB	; 03801530
	.byte 0x28, 0x78, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20, 0xA0, 0x40, 0x06, 0x43, 0x64, 0x1C, 0x10, 0x2C	; 03801540
	.byte 0xE3, 0xDB, 0x05, 0x48, 0x00, 0x68, 0x00, 0x28, 0x00, 0xD0, 0x46, 0x60, 0x01, 0xB0, 0xF0, 0xBC	; 03801550
	.byte 0x08, 0xBC, 0x18, 0x47, 0x5C, 0x64, 0x80, 0x03, 0x18, 0x5F, 0x80, 0x03, 0x30, 0xB5, 0x81, 0xB0	; 03801560
	.byte 0x00, 0x25, 0x0C, 0x4B, 0x28, 0x1C, 0x24, 0x21, 0x2A, 0x1C, 0x4A, 0x43, 0x9C, 0x18, 0x98, 0x54	; 03801570
	.byte 0xA5, 0x70, 0x6D, 0x1C, 0x10, 0x2D, 0xF7, 0xDB, 0x07, 0x4C, 0x01, 0x21, 0x83, 0x01, 0xE2, 0x5C	; 03801580
	.byte 0x8A, 0x43, 0xE2, 0x54, 0x40, 0x1C, 0x20, 0x28, 0xF8, 0xDB, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 03801590
	.byte 0x18, 0x47, 0xC0, 0x46, 0x5C, 0x64, 0x80, 0x03, 0x9C, 0x66, 0x80, 0x03	; 0380159C

; ===== function loc_0380159C =====
loc_0380159C:
	lsl r1,r1,#0x3	; 0380159C
	add r0,r0,r1	; 0380159E
	ldr r1,[r0,#0x18]	; 038015A0
	cmp r1,#0x0	; 038015A2
	bne loc_038015AA	; 038015A4
	mov r0,#0x0	; 038015A6
	bx lr	; 038015A8
loc_038015AA:
	ldr r0,[r1,#0x38]	; 038015AA
	cmp r2,r0	; 038015AC
	bcc loc_038015B4	; 038015AE
	mov r0,#0x0	; 038015B0
	bx lr	; 038015B2
loc_038015B4:
	lsl r0,r2,#0x2	; 038015B4
	add r0,r1,r0	; 038015B6
	ldr r0,[r0,#0x3c]	; 038015B8
	add r0,r1,r0	; 038015BA
	bx lr	; 038015BC
	.byte 0x00, 0x00	; 038015C0

; ===== function loc_038015C0 =====
	push {r4,r5,r6,r7,lr}	; 038015C0
	sub sp,#0x4	; 038015C2
	add r5,r0,#0x0	; 038015C4
	add r7,r1,#0x0	; 038015C6
	str r2,[sp,#0x0]	; 038015C8
	add r6,r3,#0x0	; 038015CA
	ldr r4,[sp,#0x1c]	; 038015CC
	ldrb r1,[r4,#0x0]	; 038015CE
	cmp r1,#0x4	; 038015D0
	bhi loc_0380162E	; 038015D2
	add r2,r1,r1	; 038015D4
	add r2,pc	; 038015D6
	ldrh r2,[r2,#0x8]	; 038015D8
	lsl r2,r2,#0x10	; 038015DA
	asr r2,r2,#0x10	; 038015DC
	add r2,pc	; 038015DE
	bx r2	; 038015E0
	.byte 0x4D, 0x00, 0x0B, 0x00, 0x3B, 0x00, 0x45, 0x00, 0x0B, 0x00	; 038015EC
loc_038015EC:
	cmp r1,#0x1	; 038015EC
	bne loc_038015FE	; 038015EE
	ldr r0,[sp,#0x18]	; 038015F0
	ldrh r1,[r4,#0x4]	; 038015F2
	ldrh r2,[r4,#0x2]	; 038015F4
	bl loc_0380159C	; 038015F6
	add r2,r0,#0x0	; 038015FA
	b loc_03801606	; 038015FC
loc_038015FE:
	ldrh r0,[r4,#0x4]	; 038015FE
	lsl r2,r0,#0x10	; 03801600
	ldrh r0,[r4,#0x2]	; 03801602
	orr r2,r0	; 03801604
loc_03801606:
	cmp r2,#0x0	; 03801606
	beq loc_03801618	; 03801608
	add r0,r5,#0x0	; 0380160A
	add r1,r2,#0x0	; 0380160C
	add r2,#0xc	; 0380160E
	add r3,r6,#0x0	; 03801610
	bl loc_0380012C	; 03801612
	b loc_03801630	; 03801616
loc_03801618:
	mov r0,#0x0	; 03801618
	b loc_03801630	; 0380161A
loc_0380161C:
	ldrh r1,[r4,#0x2]	; 0380161C
	add r2,r6,#0x0	; 0380161E
	bl loc_038000F8	; 03801620
	b loc_03801630	; 03801624
loc_03801626:
	add r1,r6,#0x0	; 03801626
	bl loc_038000C8	; 03801628
	b loc_03801630	; 0380162C
loc_0380162E:
	mov r0,#0x0	; 0380162E
loc_03801630:
	cmp r0,#0x0	; 03801630
	bne loc_03801638	; 03801632
	mov r0,#0x0	; 03801634
	b loc_0380166A	; 03801636
loc_03801638:
	strb r7,[r5,#0x8]	; 03801638
	ldrb r0,[r4,#0x6]	; 0380163A
	strb r0,[r5,#0x5]	; 0380163C
	ldr r0,[sp,#0x0]	; 0380163E
	strb r0,[r5,#0x9]	; 03801640
	add r0,r5,#0x0	; 03801642
	ldrb r1,[r4,#0x7]	; 03801644
	bl loc_038000AC	; 03801646
	add r0,r5,#0x0	; 0380164A
	ldrb r1,[r4,#0x8]	; 0380164C
	bl loc_03800098	; 0380164E
	add r0,r5,#0x0	; 03801652
	ldrb r1,[r4,#0x9]	; 03801654
	bl loc_03800094	; 03801656
	add r0,r5,#0x0	; 0380165A
	ldrb r1,[r4,#0xa]	; 0380165C
	bl loc_03800080	; 0380165E
	ldrb r0,[r4,#0xb]	; 03801662
	sub r0,#0x40	; 03801664
	strb r0,[r5,#0xa]	; 03801666
	mov r0,#0x1	; 03801668
loc_0380166A:
	add sp,#0x4	; 0380166A
	pop {r4,r5,r6,r7}	; 0380166C
	pop {r3}	; 0380166E
	bx r3	; 03801670
	.byte 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0, 0x04, 0x1C, 0x18, 0x1C, 0x00, 0x29, 0x01, 0xDA, 0x00, 0x20	; 03801682
	.byte 0x60, 0xE0, 0xA3, 0x6B, 0x99, 0x42, 0x01, 0xD3, 0x00, 0x20, 0x5B, 0xE0, 0x89, 0x00, 0x61, 0x18	; 03801692
	.byte 0xCB, 0x6B, 0x03, 0x70, 0x01, 0x78, 0x10, 0x29, 0x0F, 0xDC, 0x10, 0x29, 0x1C, 0xDA, 0x04, 0x29	; 038016A2
	.byte 0x4D, 0xD8, 0x4D, 0x18, 0x7D, 0x44, 0x2D, 0x89, 0x2D, 0x04, 0x2D, 0x14, 0x7D, 0x44, 0x28, 0x47	; 038016B2
	.byte 0x8F, 0x00, 0x11, 0x00, 0x11, 0x00, 0x11, 0x00, 0x11, 0x00, 0x11, 0x29, 0x26, 0xD0, 0x3E, 0xE0	; 038016C2
	.byte 0x19, 0x0A, 0x63, 0x18, 0x82, 0x1C, 0x05, 0x21, 0x18, 0x88, 0x9B, 0x1C, 0x10, 0x80, 0x92, 0x1C	; 038016D2
	.byte 0x49, 0x1E, 0x00, 0x29, 0xF8, 0xD1, 0x34, 0xE0, 0x1B, 0x0A, 0xE1, 0x18, 0x4D, 0x78, 0xE3, 0x5C	; 038016E2
	.byte 0x9A, 0x42, 0x01, 0xDA, 0x00, 0x20, 0x2D, 0xE0, 0xAA, 0x42, 0x01, 0xDD, 0x00, 0x20, 0x29, 0xE0	; 038016F2
	.byte 0xD3, 0x1A, 0x0C, 0x22, 0x53, 0x43, 0xC9, 0x18, 0x8B, 0x1C, 0x06, 0x22, 0x19, 0x88, 0x9B, 0x1C	; 03801702
	.byte 0x01, 0x80, 0x80, 0x1C, 0x52, 0x1E, 0x00, 0x2A, 0xF8, 0xD1, 0x1A, 0xE0, 0x00, 0x21, 0x1B, 0x0A	; 03801712
	.byte 0xE4, 0x18, 0x04, 0xE0, 0x49, 0x1C, 0x08, 0x29, 0x01, 0xDB, 0x00, 0x20, 0x12, 0xE0, 0x63, 0x5C	; 03801722
	.byte 0x9A, 0x42, 0xF7, 0xDC, 0x0C, 0x22, 0x51, 0x43, 0x63, 0x18, 0x08, 0x33, 0x06, 0x22, 0x19, 0x88	; 03801732
	.byte 0x9B, 0x1C, 0x01, 0x80, 0x80, 0x1C, 0x52, 0x1E, 0x00, 0x2A, 0xF8, 0xD1, 0x01, 0xE0, 0x00, 0x20	; 03801742
	.byte 0x00, 0xE0, 0x01, 0x20, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 03801750

; ===== function loc_03801750 =====
loc_03801750:
	push {r4,r5,r6,r7,lr}	; 03801750
	sub sp,#0x4	; 03801752
	mov r5,#0x0	; 03801754
	add r4,r5,#0x0	; 03801756
	ldr r0,[pool_038017B4]	; 03801758
	ldr r0,[r0,#0x0]	; 0380175A
	cmp r0,#0x0	; 0380175C
	beq loc_038017AC	; 0380175E
	add r6,r5,#0x0	; 03801760
	mov r7,#0x1	; 03801762
loc_03801764:
	add r0,r6,#0x0	; 03801764
	bl loc_037FF55C	; 03801766
	cmp r0,#0x0	; 0380176A
	beq loc_03801778	; 0380176C
	add r0,r7,#0x0	; 0380176E
	lsl r0,r6	; 03801770
	orr r5,r0	; 03801772
	lsl r0,r5,#0x10	; 03801774
	lsr r5,r0,#0x10	; 03801776
loc_03801778:
	add r6,r6,#0x1	; 03801778
	cmp r6,#0x10	; 0380177A
	blt loc_03801764	; 0380177C
	mov r0,#0x0	; 0380177E
	bl loc_037FFAB0	; 03801780
	cmp r0,#0x0	; 03801784
	beq loc_03801790	; 03801786
	mov r0,#0x1	; 03801788
	orr r4,r0	; 0380178A
	lsl r0,r4,#0x10	; 0380178C
	lsr r4,r0,#0x10	; 0380178E
loc_03801790:
	mov r0,#0x1	; 03801790
	bl loc_037FFAB0	; 03801792
	cmp r0,#0x0	; 03801796
	beq loc_038017A2	; 03801798
	mov r0,#0x2	; 0380179A
	orr r4,r0	; 0380179C
	lsl r0,r4,#0x10	; 0380179E
	lsr r4,r0,#0x10	; 038017A0
loc_038017A2:
	ldr r0,[pool_038017B4]	; 038017A2
	ldr r1,[r0,#0x0]	; 038017A4
	strh r5,[r1,#0x8]	; 038017A6
	ldr r0,[r0,#0x0]	; 038017A8
	strh r4,[r0,#0xa]	; 038017AA
loc_038017AC:
	add sp,#0x4	; 038017AC
	pop {r4,r5,r6,r7}	; 038017AE
	pop {r3}	; 038017B0
	bx r3	; 038017B2
pool_038017B4:
loc_038017B4:
	.word 0x03805F18	; 038017B4

; ===== function loc_038017B8 =====
loc_038017B8:
	ldr r2,[pool_038017C8]	; 038017B8
	ldr r2,[r2,#0x0]	; 038017BA
	lsl r0,r0,#0x1	; 038017BC
	add r2,r2,r0	; 038017BE
	ldr r0,[pool_038017CC]	; 038017C0
	strh r1,[r2,r0]	; 038017C2
	bx lr	; 038017C4
	.byte 0xC0, 0x46	; 038017C8
pool_038017C8:
loc_038017C8:
	.word 0x03805F18	; 038017C8
pool_038017CC:
loc_038017CC:
	.word 0x00000260	; 038017CC

; ===== function loc_038017D0 =====
loc_038017D0:
	push {r4,lr}	; 038017D0
	ldr r3,[pool_038017E8]	; 038017D2
	ldr r4,[r3,#0x0]	; 038017D4
	mov r3,#0x24	; 038017D6
	mul r0,r3	; 038017D8
	add r3,r4,r0	; 038017DA
	lsl r0,r1,#0x1	; 038017DC
	add r0,r3,r0	; 038017DE
	strh r2,[r0,#0x20]	; 038017E0
	pop {r4}	; 038017E2
	pop {r3}	; 038017E4
	bx r3	; 038017E6
pool_038017E8:
loc_038017E8:
	.word 0x03805F18	; 038017E8

; ===== function loc_038017EC =====
	push {r4,r5,r6,lr}	; 038017EC
	add r5,r0,#0x0	; 038017EE
	mov r4,#0x7	; 038017F0
	mov r6,#0x0	; 038017F2
loc_038017F4:
	add r0,r4,#0x0	; 038017F4
	add r1,r5,#0x0	; 038017F6
	add r2,r6,#0x0	; 038017F8
	bl loc_03801F30	; 038017FA
	cmp r0,#0x0	; 038017FE
	blt loc_038017F4	; 03801800
	pop {r4,r5,r6}	; 03801802
	pop {r3}	; 03801804
	bx r3	; 03801806

; ===== function loc_03801808 =====
loc_03801808:
	push {r4,lr}	; 03801808
	ldr r1,[pool_03801830]	; 0380180A
	lsl r0,r0,#0x6	; 0380180C
	add r4,r1,r0	; 0380180E
	ldrb r0,[r1,r0]	; 03801810
	cmp r0,#0x0	; 03801812
	beq loc_0380182A	; 03801814
	add r0,r4,#0x0	; 03801816
	add r0,#0x14	; 03801818
	bl loc_037FEA5C	; 0380181A
	add r1,r4,#0x1	; 0380181E
	ldrb r0,[r1,#0x0]	; 03801820
	add r0,r0,#0x1	; 03801822
	strb r0,[r1,#0x0]	; 03801824
	mov r0,#0x0	; 03801826
	strb r0,[r4,#0x0]	; 03801828
loc_0380182A:
	pop {r4}	; 0380182A
	pop {r3}	; 0380182C
	bx r3	; 0380182E
pool_03801830:
loc_03801830:
	.word 0x03806E9C	; 03801830

; ===== function loc_03801834 =====
loc_03801834:
	push {r4,r5,r6,r7,lr}	; 03801834
	sub sp,#0x1c	; 03801836
	str r0,[sp,#0xc]	; 03801838
	ldr r1,[pool_038018C0]	; 0380183A
	lsl r0,r0,#0x6	; 0380183C
	add r5,r1,r0	; 0380183E
	ldrb r0,[r1,r0]	; 03801840
	cmp r0,#0x0	; 03801842
	beq loc_03801852	; 03801844
	add r0,r5,#0x0	; 03801846
	add r0,#0x14	; 03801848
	bl loc_037FEA5C	; 0380184A
	mov r0,#0x0	; 0380184E
	strb r0,[r5,#0x0]	; 03801850
loc_03801852:
	ldr r6,[r5,#0x4]	; 03801852
	ldr r7,[r5,#0x8]	; 03801854
	ldr r0,[r5,#0xc]	; 03801856
	str r0,[sp,#0x10]	; 03801858
	ldr r0,[r5,#0x10]	; 0380185A
	str r0,[sp,#0x14]	; 0380185C
	ldrb r0,[r5,#0x1]	; 0380185E
	lsl r4,r0,#0x8	; 03801860
	ldr r0,[sp,#0xc]	; 03801862
	orr r4,r0	; 03801864
	add r0,r5,#0x0	; 03801866
	add r0,#0x14	; 03801868
	bl loc_037FEC34	; 0380186A
	mov r2,#0x0	; 0380186E
	ldr r1,[sp,#0x14]	; 03801870
	eor r1,r2	; 03801872
	ldr r0,[sp,#0x10]	; 03801874
	eor r0,r2	; 03801876
	orr r1,r0	; 03801878
	bne loc_0380188E	; 0380187A
	str r4,[sp,#0x0]	; 0380187C
	add r0,r5,#0x0	; 0380187E
	add r0,#0x14	; 03801880
	add r1,r6,#0x0	; 03801882
	add r2,r7,#0x0	; 03801884
	ldr r3,[pool_038018C4]	; 03801886
	bl loc_037FEB08	; 03801888
	b loc_038018B2	; 0380188C
loc_0380188E:
	bl loc_037FE868	; 0380188E
	str r0,[sp,#0x18]	; 03801892
	add r2,r1,#0x0	; 03801894
	ldr r0,[pool_038018C4]	; 03801896
	str r0,[sp,#0x4]	; 03801898
	str r4,[sp,#0x8]	; 0380189A
	ldr r3,[sp,#0x10]	; 0380189C
	ldr r0,[sp,#0x14]	; 0380189E
	str r0,[sp,#0x0]	; 038018A0
	add r0,r5,#0x0	; 038018A2
	add r0,#0x14	; 038018A4
	ldr r1,[sp,#0x18]	; 038018A6
	add r1,r6,r1	; 038018A8
	adc r7,r2	; 038018AA
	add r2,r7,#0x0	; 038018AC
	bl loc_037FEAB8	; 038018AE
loc_038018B2:
	mov r0,#0x1	; 038018B2
	strb r0,[r5,#0x0]	; 038018B4
	add sp,#0x1c	; 038018B6
	pop {r4,r5,r6,r7}	; 038018B8
	pop {r3}	; 038018BA
	bx r3	; 038018BC
	.byte 0xC0, 0x46	; 038018C0
pool_038018C0:
loc_038018C0:
	.word 0x03806E9C	; 038018C0
pool_038018C4:
loc_038018C4:
	.word 0x038017ED	; 038018C4

; ===== function loc_038018C8 =====
loc_038018C8:
	push {r4,r5,r6,lr}	; 038018C8
	sub sp,#0x8	; 038018CA
	add r5,r1,#0x0	; 038018CC
	add r6,r2,#0x0	; 038018CE
	str r3,[sp,#0x0]	; 038018D0
	ldr r1,[sp,#0x18]	; 038018D2
	str r1,[sp,#0x4]	; 038018D4
	ldr r1,[pool_03801908]	; 038018D6
	lsl r0,r0,#0x6	; 038018D8
	add r4,r1,r0	; 038018DA
	ldrb r0,[r1,r0]	; 038018DC
	cmp r0,#0x0	; 038018DE
	beq loc_038018EE	; 038018E0
	add r0,r4,#0x0	; 038018E2
	add r0,#0x14	; 038018E4
	bl loc_037FEA5C	; 038018E6
	mov r0,#0x0	; 038018EA
	strb r0,[r4,#0x0]	; 038018EC
loc_038018EE:
	str r5,[r4,#0x4]	; 038018EE
	str r6,[r4,#0x8]	; 038018F0
	ldr r0,[sp,#0x0]	; 038018F2
	str r0,[r4,#0xc]	; 038018F4
	ldr r0,[sp,#0x4]	; 038018F6
	str r0,[r4,#0x10]	; 038018F8
	ldr r0,[sp,#0x1c]	; 038018FA
	strb r0,[r4,#0x1]	; 038018FC
	add sp,#0x8	; 038018FE
	pop {r4,r5,r6}	; 03801900
	pop {r3}	; 03801902
	bx r3	; 03801904
	.byte 0xC0, 0x46	; 03801908
pool_03801908:
loc_03801908:
	.word 0x03806E9C	; 03801908
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x00, 0x25, 0x07, 0x4C, 0x2A, 0x1C, 0x07, 0x48, 0x07, 0x49, 0xAB, 0x01	; 0380191C
	.byte 0xE3, 0x18, 0x1A, 0x54, 0x5A, 0x54, 0x6D, 0x1C, 0x08, 0x2D, 0xF8, 0xDB, 0x01, 0xB0, 0x30, 0xBC	; 0380192C
	.byte 0x08, 0xBC, 0x18, 0x47, 0x1C, 0x5F, 0x80, 0x03, 0x80, 0x0F, 0x00, 0x00, 0x81, 0x0F, 0x00, 0x00	; 0380193C

; ===== function loc_0380193C =====
loc_0380193C:
	push {r4,r5,r6,r7,lr}	; 0380193C
	sub sp,#0xc	; 0380193E
	add r5,r0,#0x0	; 03801940
	add r7,r1,#0x0	; 03801942
	add r6,r2,#0x0	; 03801944
	str r3,[sp,#0x0]	; 03801946
	bl loc_037FDCE0	; 03801948
	str r0,[sp,#0x4]	; 0380194C
	mov r4,#0x0	; 0380194E
	b loc_03801966	; 03801950
loc_03801952:
	add r1,r6,#0x0	; 03801952
	mov r0,#0x1	; 03801954
	and r1,r0	; 03801956
	cmp r1,#0x0	; 03801958
	beq loc_03801962	; 0380195A
	add r0,r4,#0x0	; 0380195C
	bl loc_03801808	; 0380195E
loc_03801962:
	add r4,r4,#0x1	; 03801962
	lsr r6,r6,#0x1	; 03801964
loc_03801966:
	cmp r4,#0x8	; 03801966
	bge loc_0380196E	; 03801968
	cmp r6,#0x0	; 0380196A
	bne loc_03801952	; 0380196C
loc_0380196E:
	mov r4,#0x0	; 0380196E
	mov r6,#0x1	; 03801970
	b loc_03801988	; 03801972
loc_03801974:
	add r0,r5,#0x0	; 03801974
	and r0,r6	; 03801976
	cmp r0,#0x0	; 03801978
	beq loc_03801984	; 0380197A
	add r0,r4,#0x0	; 0380197C
	ldr r1,[sp,#0x0]	; 0380197E
	bl loc_037FF628	; 03801980
loc_03801984:
	add r4,r4,#0x1	; 03801984
	lsr r5,r5,#0x1	; 03801986
loc_03801988:
	cmp r4,#0x10	; 03801988
	bge loc_03801990	; 0380198A
	cmp r5,#0x0	; 0380198C
	bne loc_03801974	; 0380198E
loc_03801990:
	mov r0,#0x1	; 03801990
	add r1,r7,#0x0	; 03801992
	and r1,r0	; 03801994
	cmp r1,#0x0	; 03801996
	beq loc_038019A0	; 03801998
	mov r1,#0x0	; 0380199A
	ldr r0,[pool_038019C0]	; 0380199C
	strb r1,[r0,#0x0]	; 0380199E
loc_038019A0:
	mov r0,#0x2	; 038019A0
	and r7,r0	; 038019A2
	cmp r7,#0x0	; 038019A4
	beq loc_038019AE	; 038019A6
	mov r1,#0x0	; 038019A8
	ldr r0,[pool_038019C4]	; 038019AA
	strb r1,[r0,#0x0]	; 038019AC
loc_038019AE:
	ldr r0,[sp,#0x4]	; 038019AE
	bl loc_037FDD04	; 038019B0
	bl loc_03801750	; 038019B4
	add sp,#0xc	; 038019B8
	pop {r4,r5,r6,r7}	; 038019BA
	pop {r3}	; 038019BC
	bx r3	; 038019BE
pool_038019C0:
loc_038019C0:
	.word 0x04000508	; 038019C0
pool_038019C4:
loc_038019C4:
	.word 0x04000509	; 038019C4

; ===== function loc_038019C8 =====
loc_038019C8:
	push {r4,r5,r6,r7,lr}	; 038019C8
	sub sp,#0x4	; 038019CA
	add r5,r0,#0x0	; 038019CC
	add r4,r1,#0x0	; 038019CE
	add r6,r2,#0x0	; 038019D0
	bl loc_037FDCE0	; 038019D2
	add r7,r0,#0x0	; 038019D6
	mov r3,#0x0	; 038019D8
	b loc_038019F8	; 038019DA
loc_038019DC:
	add r1,r5,#0x0	; 038019DC
	mov r0,#0x1	; 038019DE
	and r1,r0	; 038019E0
	cmp r1,#0x0	; 038019E2
	beq loc_038019F4	; 038019E4
	lsl r1,r3,#0x4	; 038019E6
	ldr r0,[pool_03801A70]	; 038019E8
	add r2,r1,r0	; 038019EA
	ldrb r1,[r2,#0x0]	; 038019EC
	mov r0,#0x80	; 038019EE
	orr r1,r0	; 038019F0
	strb r1,[r2,#0x0]	; 038019F2
loc_038019F4:
	add r3,r3,#0x1	; 038019F4
	lsr r5,r5,#0x1	; 038019F6
loc_038019F8:
	cmp r3,#0x10	; 038019F8
	bge loc_03801A00	; 038019FA
	cmp r5,#0x0	; 038019FC
	bne loc_038019DC	; 038019FE
loc_03801A00:
	mov r0,#0x1	; 03801A00
	add r1,r4,#0x0	; 03801A02
	and r1,r0	; 03801A04
	cmp r1,#0x0	; 03801A06
	beq loc_03801A2A	; 03801A08
	mov r0,#0x2	; 03801A0A
	and r4,r0	; 03801A0C
	cmp r4,#0x0	; 03801A0E
	beq loc_03801A1E	; 03801A10
	ldr r2,[pool_03801A74]	; 03801A12
	ldrh r1,[r2,#0x0]	; 03801A14
	ldr r0,[pool_03801A78]	; 03801A16
	orr r1,r0	; 03801A18
	strh r1,[r2,#0x0]	; 03801A1A
	b loc_03801A3C	; 03801A1C
loc_03801A1E:
	ldr r2,[pool_03801A74]	; 03801A1E
	ldrb r1,[r2,#0x0]	; 03801A20
	mov r0,#0x80	; 03801A22
	orr r1,r0	; 03801A24
	strb r1,[r2,#0x0]	; 03801A26
	b loc_03801A3C	; 03801A28
loc_03801A2A:
	mov r0,#0x2	; 03801A2A
	and r4,r0	; 03801A2C
	cmp r4,#0x0	; 03801A2E
	beq loc_03801A3C	; 03801A30
	ldr r2,[pool_03801A7C]	; 03801A32
	ldrb r1,[r2,#0x0]	; 03801A34
	mov r0,#0x80	; 03801A36
	orr r1,r0	; 03801A38
	strb r1,[r2,#0x0]	; 03801A3A
loc_03801A3C:
	mov r4,#0x0	; 03801A3C
	mov r5,#0x1	; 03801A3E
	b loc_03801A54	; 03801A40
loc_03801A42:
	add r0,r6,#0x0	; 03801A42
	and r0,r5	; 03801A44
	cmp r0,#0x0	; 03801A46
	beq loc_03801A50	; 03801A48
	add r0,r4,#0x0	; 03801A4A
	bl loc_03801834	; 03801A4C
loc_03801A50:
	add r4,r4,#0x1	; 03801A50
	lsr r6,r6,#0x1	; 03801A52
loc_03801A54:
	cmp r4,#0x8	; 03801A54
	bge loc_03801A5C	; 03801A56
	cmp r6,#0x0	; 03801A58
	bne loc_03801A42	; 03801A5A
loc_03801A5C:
	add r0,r7,#0x0	; 03801A5C
	bl loc_037FDD04	; 03801A5E
	bl loc_03801750	; 03801A62
	add sp,#0x4	; 03801A66
	pop {r4,r5,r6,r7}	; 03801A68
	pop {r3}	; 03801A6A
	bx r3	; 03801A6C
	.byte 0xC0, 0x46	; 03801A70
pool_03801A70:
loc_03801A70:
	.word 0x04000403	; 03801A70
pool_03801A74:
loc_03801A74:
	.word 0x04000508	; 03801A74
pool_03801A78:
loc_03801A78:
	.word 0x00008080	; 03801A78
pool_03801A7C:
loc_03801A7C:
	.word 0x04000509	; 03801A7C

; ===== function loc_03801A80 =====
loc_03801A80:
	push {r4,r5,r6,r7,lr}	; 03801A80
	sub sp,#0x4	; 03801A82
	add r5,r0,#0x0	; 03801A84
	add r6,r1,#0x0	; 03801A86
	mov r4,#0x0	; 03801A88
	mov r7,#0x1	; 03801A8A
	b loc_03801AA2	; 03801A8C
loc_03801A8E:
	add r0,r5,#0x0	; 03801A8E
	and r0,r7	; 03801A90
	cmp r0,#0x0	; 03801A92
	beq loc_03801A9E	; 03801A94
	add r0,r4,#0x0	; 03801A96
	add r1,r6,#0x0	; 03801A98
	bl loc_037FF578	; 03801A9A
loc_03801A9E:
	add r4,r4,#0x1	; 03801A9E
	lsr r5,r5,#0x1	; 03801AA0
loc_03801AA2:
	cmp r4,#0x10	; 03801AA2
	bge loc_03801AAA	; 03801AA4
	cmp r5,#0x0	; 03801AA6
	bne loc_03801A8E	; 03801AA8
loc_03801AAA:
	add sp,#0x4	; 03801AAA
	pop {r4,r5,r6,r7}	; 03801AAC
	pop {r3}	; 03801AAE
	bx r3	; 03801AB0
	.byte 0x00, 0x00	; 03801AB4

; ===== function loc_03801AB4 =====
loc_03801AB4:
	push {r4,r5,r6,r7,lr}	; 03801AB4
	sub sp,#0x4	; 03801AB6
	add r5,r0,#0x0	; 03801AB8
	add r6,r1,#0x0	; 03801ABA
	add r7,r2,#0x0	; 03801ABC
	mov r4,#0x0	; 03801ABE
	b loc_03801ADA	; 03801AC0
loc_03801AC2:
	add r1,r5,#0x0	; 03801AC2
	mov r0,#0x1	; 03801AC4
	and r1,r0	; 03801AC6
	cmp r1,#0x0	; 03801AC8
	beq loc_03801AD6	; 03801ACA
	add r0,r4,#0x0	; 03801ACC
	add r1,r6,#0x0	; 03801ACE
	add r2,r7,#0x0	; 03801AD0
	bl loc_037FF5D0	; 03801AD2
loc_03801AD6:
	add r4,r4,#0x1	; 03801AD6
	lsr r5,r5,#0x1	; 03801AD8
loc_03801ADA:
	cmp r4,#0x10	; 03801ADA
	bge loc_03801AE2	; 03801ADC
	cmp r5,#0x0	; 03801ADE
	bne loc_03801AC2	; 03801AE0
loc_03801AE2:
	add sp,#0x4	; 03801AE2
	pop {r4,r5,r6,r7}	; 03801AE4
	pop {r3}	; 03801AE6
	bx r3	; 03801AE8
	.byte 0x00, 0x00	; 03801AEC

; ===== function loc_03801AEC =====
loc_03801AEC:
	push {r4,r5,r6,r7,lr}	; 03801AEC
	sub sp,#0x4	; 03801AEE
	add r5,r0,#0x0	; 03801AF0
	add r6,r1,#0x0	; 03801AF2
	mov r4,#0x0	; 03801AF4
	mov r7,#0x1	; 03801AF6
	b loc_03801B0E	; 03801AF8
loc_03801AFA:
	add r0,r5,#0x0	; 03801AFA
	and r0,r7	; 03801AFC
	cmp r0,#0x0	; 03801AFE
	beq loc_03801B0A	; 03801B00
	add r0,r4,#0x0	; 03801B02
	add r1,r6,#0x0	; 03801B04
	bl loc_037FF5BC	; 03801B06
loc_03801B0A:
	add r4,r4,#0x1	; 03801B0A
	lsr r5,r5,#0x1	; 03801B0C
loc_03801B0E:
	cmp r4,#0x10	; 03801B0E
	bge loc_03801B16	; 03801B10
	cmp r5,#0x0	; 03801B12
	bne loc_03801AFA	; 03801B14
loc_03801B16:
	add sp,#0x4	; 03801B16
	pop {r4,r5,r6,r7}	; 03801B18
	pop {r3}	; 03801B1A
	bx r3	; 03801B1C
	.byte 0x00, 0x00	; 03801B20

; ===== function loc_03801B20 =====
loc_03801B20:
	mov r0,#0x7	; 03801B20
	ldr r1,[pool_03801B28]	; 03801B22
	ldr r3,[pool_03801B2C]	; 03801B24
	bx r3	; 03801B26
pool_03801B28:
loc_03801B28:
	.word 0x03801B31	; 03801B28
pool_03801B2C:
loc_03801B2C:
	.word 0x03801FB9	; 03801B2C

; ===== function loc_03801B30 =====
	push {r4,r5,lr}	; 03801B30
	sub sp,#0x4	; 03801B32
	add r5,r1,#0x0	; 03801B34
	bl loc_037FDCE0	; 03801B36
	add r4,r0,#0x0	; 03801B3A
	ldr r0,[pool_03801B64]	; 03801B3C
	cmp r5,r0	; 03801B3E
	bcc loc_03801B4E	; 03801B40
	ldr r0,[pool_03801B68]	; 03801B42
	add r1,r5,#0x0	; 03801B44
	mov r2,#0x0	; 03801B46
	bl loc_037FE300	; 03801B48
	b loc_03801B56	; 03801B4C
loc_03801B4E:
	cmp r5,#0x0	; 03801B4E
	bne loc_03801B56	; 03801B50
	bl loc_037FF9D0	; 03801B52
loc_03801B56:
	add r0,r4,#0x0	; 03801B56
	bl loc_037FDD04	; 03801B58
	add sp,#0x4	; 03801B5C
	pop {r4,r5}	; 03801B5E
	pop {r3}	; 03801B60
	bx r3	; 03801B62
pool_03801B64:
loc_03801B64:
	.word 0x02000000	; 03801B64
pool_03801B68:
loc_03801B68:
	.word 0x0380709C	; 03801B68

; ===== function loc_03801B6C =====
	push {r4,r5,r6,r7,lr}	; 03801B6C
	sub sp,#0x34	; 03801B6E
	mov r4,#0x7f	; 03801B70
	mov r7,#0x3	; 03801B72
	mov r6,#0x1	; 03801B74
	b loc_03801DE0	; 03801B76
loc_03801B78:
	ldr r5,[sp,#0x18]	; 03801B78
	b loc_03801DD0	; 03801B7A
loc_03801B7C:
	add r3,sp,#0x1c	; 03801B7C
	mov r2,#0x3	; 03801B7E
loc_03801B80:
	ldmia r5!,{r0,r1}	; 03801B80
	stmia r3!,{r0,r1}	; 03801B82
	sub r2,r2,#0x1	; 03801B84
	cmp r2,#0x0	; 03801B86
	bne loc_03801B80	; 03801B88
	ldr r0,[sp,#0x20]	; 03801B8A
	cmp r0,#0x1d	; 03801B8C
	bls loc_03801B92	; 03801B8E
	b loc_03801DCE	; 03801B90
loc_03801B92:
	add r0,r0,r0	; 03801B92
	add r0,pc	; 03801B94
	ldrh r0,[r0,#0x8]	; 03801B96
	lsl r0,r0,#0x10	; 03801B98
	asr r0,r0,#0x10	; 03801B9A
	add r0,pc	; 03801B9C
	bx r0	; 03801B9E
	.byte 0x3D, 0x00, 0x4B, 0x00, 0x53, 0x00, 0x5D, 0x00, 0x6B, 0x00, 0x85, 0x00, 0x91, 0x00, 0x9D, 0x00	; 03801BB0
	.byte 0xAD, 0x00, 0xBB, 0x00, 0xC9, 0x00, 0x33, 0x01, 0x7F, 0x01, 0xA1, 0x01, 0xD7, 0x00, 0xFD, 0x00	; 03801BC0
	.byte 0x13, 0x01, 0x1D, 0x01, 0x29, 0x01, 0xC3, 0x01, 0xCB, 0x01, 0xD3, 0x01, 0xE1, 0x01, 0xEB, 0x01	; 03801BD0
	.byte 0xF5, 0x01, 0x1D, 0x02, 0x25, 0x02, 0xFF, 0x01, 0x09, 0x02, 0x13, 0x02	; 03801BDC
loc_03801BDC:
	ldr r0,[sp,#0x24]	; 03801BDC
	ldr r1,[sp,#0x28]	; 03801BDE
	ldr r2,[sp,#0x2c]	; 03801BE0
	ldr r3,[sp,#0x30]	; 03801BE2
	bl loc_03801430	; 03801BE4
	b loc_03801DCE	; 03801BE8
loc_03801BEA:
	ldr r0,[sp,#0x24]	; 03801BEA
	bl loc_038013F4	; 03801BEC
	b loc_03801DCE	; 03801BF0
loc_03801BF2:
	ldr r0,[sp,#0x24]	; 03801BF2
	ldr r1,[sp,#0x28]	; 03801BF4
	bl loc_038013BC	; 03801BF6
	b loc_03801DCE	; 03801BFA
loc_03801BFC:
	ldr r0,[sp,#0x24]	; 03801BFC
	ldr r1,[sp,#0x28]	; 03801BFE
	ldr r2,[sp,#0x2c]	; 03801C00
	ldr r3,[sp,#0x30]	; 03801C02
	bl loc_03801240	; 03801C04
	b loc_03801DCE	; 03801C08
loc_03801C0A:
	ldr r0,[sp,#0x24]	; 03801C0A
	lsr r2,r0,#0x18	; 03801C0C
	mov r1,#0xff	; 03801C0E
	and r2,r1	; 03801C10
	str r2,[sp,#0x0]	; 03801C12
	ldr r1,[pool_03801DF8]	; 03801C14
	and r0,r1	; 03801C16
	ldr r1,[sp,#0x28]	; 03801C18
	ldr r2,[sp,#0x2c]	; 03801C1A
	ldr r3,[sp,#0x30]	; 03801C1C
	bl loc_038011E4	; 03801C1E
	b loc_03801DCE	; 03801C22
loc_03801C24:
	ldr r0,[sp,#0x24]	; 03801C24
	ldr r1,[sp,#0x28]	; 03801C26
	ldr r2,[sp,#0x2c]	; 03801C28
	bl loc_03801354	; 03801C2A
	b loc_03801DCE	; 03801C2E
loc_03801C30:
	ldr r0,[sp,#0x24]	; 03801C30
	ldr r1,[sp,#0x28]	; 03801C32
	ldr r2,[sp,#0x2c]	; 03801C34
	bl loc_03801304	; 03801C36
	b loc_03801DCE	; 03801C3A
loc_03801C3C:
	ldr r0,[sp,#0x24]	; 03801C3C
	ldr r1,[sp,#0x28]	; 03801C3E
	ldr r2,[sp,#0x2c]	; 03801C40
	lsl r2,r2,#0x10	; 03801C42
	asr r2,r2,#0x10	; 03801C44
	bl loc_038017D0	; 03801C46
	b loc_03801DCE	; 03801C4A
loc_03801C4C:
	ldr r0,[sp,#0x24]	; 03801C4C
	ldr r1,[sp,#0x28]	; 03801C4E
	lsl r1,r1,#0x10	; 03801C50
	asr r1,r1,#0x10	; 03801C52
	bl loc_038017B8	; 03801C54
	b loc_03801DCE	; 03801C58
loc_03801C5A:
	ldr r0,[sp,#0x24]	; 03801C5A
	ldr r1,[sp,#0x28]	; 03801C5C
	ldr r2,[sp,#0x2c]	; 03801C5E
	ldr r3,[sp,#0x30]	; 03801C60
	bl loc_038019C8	; 03801C62
	b loc_03801DCE	; 03801C66
loc_03801C68:
	ldr r0,[sp,#0x24]	; 03801C68
	ldr r1,[sp,#0x28]	; 03801C6A
	ldr r2,[sp,#0x2c]	; 03801C6C
	ldr r3,[sp,#0x30]	; 03801C6E
	bl loc_0380193C	; 03801C70
	b loc_03801DCE	; 03801C74
loc_03801C76:
	ldr r1,[sp,#0x2c]	; 03801C76
	lsr r0,r1,#0x1d	; 03801C78
	and r0,r6	; 03801C7A
	str r0,[sp,#0x0]	; 03801C7C
	lsr r0,r1,#0x1c	; 03801C7E
	and r0,r6	; 03801C80
	str r0,[sp,#0x4]	; 03801C82
	lsr r0,r1,#0x1b	; 03801C84
	and r0,r6	; 03801C86
	str r0,[sp,#0x8]	; 03801C88
	lsr r0,r1,#0x1f	; 03801C8A
	and r0,r6	; 03801C8C
	lsr r1,r1,#0x1e	; 03801C8E
	and r1,r6	; 03801C90
	ldr r2,[sp,#0x24]	; 03801C92
	ldr r3,[sp,#0x28]	; 03801C94
	bl loc_037FFAC8	; 03801C96
	b loc_03801DCE	; 03801C9A
loc_03801C9C:
	ldr r0,[sp,#0x30]	; 03801C9C
	str r0,[sp,#0x4]	; 03801C9E
	ldr r3,[sp,#0x2c]	; 03801CA0
	mov r0,#0x0	; 03801CA2
	str r0,[sp,#0x0]	; 03801CA4
	ldr r0,[sp,#0x24]	; 03801CA6
	ldr r1,[sp,#0x28]	; 03801CA8
	mov r2,#0x0	; 03801CAA
	bl loc_038018C8	; 03801CAC
	b loc_03801DCE	; 03801CB0
loc_03801CB2:
	ldr r0,[sp,#0x24]	; 03801CB2
	ldr r1,[sp,#0x28]	; 03801CB4
	bl loc_03801AEC	; 03801CB6
	b loc_03801DCE	; 03801CBA
loc_03801CBC:
	ldr r0,[sp,#0x24]	; 03801CBC
	ldr r1,[sp,#0x28]	; 03801CBE
	ldr r2,[sp,#0x2c]	; 03801CC0
	bl loc_03801AB4	; 03801CC2
	b loc_03801DCE	; 03801CC6
loc_03801CC8:
	ldr r0,[sp,#0x24]	; 03801CC8
	ldr r1,[sp,#0x28]	; 03801CCA
	bl loc_03801A80	; 03801CCC
	b loc_03801DCE	; 03801CD0
loc_03801CD2:
	ldr r3,[sp,#0x30]	; 03801CD2
	ldr r2,[sp,#0x24]	; 03801CD4
	ldr r1,[sp,#0x2c]	; 03801CD6
	add r5,r3,#0x0	; 03801CD8
	ldr r0,[pool_03801DFC]	; 03801CDA
	and r5,r0	; 03801CDC
	str r5,[sp,#0x0]	; 03801CDE
	add r5,r1,#0x0	; 03801CE0
	ldr r0,[pool_03801E00]	; 03801CE2
	and r5,r0	; 03801CE4
	str r5,[sp,#0x4]	; 03801CE6
	lsr r0,r1,#0x18	; 03801CE8
	and r0,r4	; 03801CEA
	str r0,[sp,#0x8]	; 03801CEC
	lsr r0,r1,#0x16	; 03801CEE
	and r0,r7	; 03801CF0
	str r0,[sp,#0xc]	; 03801CF2
	lsr r1,r2,#0x10	; 03801CF4
	ldr r0,[pool_03801DFC]	; 03801CF6
	and r1,r0	; 03801CF8
	str r1,[sp,#0x10]	; 03801CFA
	lsr r0,r3,#0x10	; 03801CFC
	and r0,r4	; 03801CFE
	str r0,[sp,#0x14]	; 03801D00
	ldr r0,[pool_03801DFC]	; 03801D02
	and r2,r0	; 03801D04
	add r0,r2,#0x0	; 03801D06
	ldr r2,[sp,#0x28]	; 03801D08
	ldr r1,[pool_03801E04]	; 03801D0A
	and r2,r1	; 03801D0C
	add r1,r2,#0x0	; 03801D0E
	lsr r2,r3,#0x18	; 03801D10
	and r2,r7	; 03801D12
	lsr r3,r3,#0x1a	; 03801D14
	and r3,r7	; 03801D16
	bl loc_037FF724	; 03801D18
	b loc_03801DCE	; 03801D1C
loc_03801D1E:
	ldr r2,[sp,#0x2c]	; 03801D1E
	ldr r3,[sp,#0x28]	; 03801D20
	lsr r1,r2,#0x8	; 03801D22
	ldr r0,[pool_03801DFC]	; 03801D24
	and r1,r0	; 03801D26
	str r1,[sp,#0x0]	; 03801D28
	and r2,r4	; 03801D2A
	str r2,[sp,#0x4]	; 03801D2C
	ldr r0,[sp,#0x24]	; 03801D2E
	ldr r1,[sp,#0x30]	; 03801D30
	add r2,r3,#0x0	; 03801D32
	and r2,r4	; 03801D34
	lsr r3,r3,#0x8	; 03801D36
	and r3,r7	; 03801D38
	bl loc_037FF6B8	; 03801D3A
	b loc_03801DCE	; 03801D3E
loc_03801D40:
	ldr r3,[sp,#0x2c]	; 03801D40
	ldr r2,[sp,#0x28]	; 03801D42
	add r0,r3,#0x0	; 03801D44
	and r0,r4	; 03801D46
	str r0,[sp,#0x0]	; 03801D48
	ldr r0,[sp,#0x24]	; 03801D4A
	add r1,r2,#0x0	; 03801D4C
	and r1,r4	; 03801D4E
	lsr r2,r2,#0x8	; 03801D50
	and r2,r7	; 03801D52
	lsr r5,r3,#0x8	; 03801D54
	ldr r3,[pool_03801DFC]	; 03801D56
	and r5,r3	; 03801D58
	add r3,r5,#0x0	; 03801D5A
	bl loc_037FF650	; 03801D5C
	b loc_03801DCE	; 03801D60
loc_03801D62:
	ldr r0,[sp,#0x24]	; 03801D62
	bl loc_037FF510	; 03801D64
	b loc_03801DCE	; 03801D68
loc_03801D6A:
	ldr r0,[sp,#0x24]	; 03801D6A
	bl loc_037FF438	; 03801D6C
	b loc_03801DCE	; 03801D70
loc_03801D72:
	ldr r0,[sp,#0x24]	; 03801D72
	ldr r1,[sp,#0x28]	; 03801D74
	ldr r2,[sp,#0x2c]	; 03801D76
	ldr r3,[sp,#0x30]	; 03801D78
	bl loc_037FF404	; 03801D7A
	b loc_03801DCE	; 03801D7E
loc_03801D80:
	ldr r0,[sp,#0x24]	; 03801D80
	ldr r1,[sp,#0x28]	; 03801D82
	bl loc_037FFE70	; 03801D84
	b loc_03801DCE	; 03801D88
loc_03801D8A:
	ldr r0,[sp,#0x24]	; 03801D8A
	ldr r1,[sp,#0x28]	; 03801D8C
	bl loc_037FFE4C	; 03801D8E
	b loc_03801DCE	; 03801D92
loc_03801D94:
	ldr r0,[sp,#0x24]	; 03801D94
	ldr r1,[sp,#0x28]	; 03801D96
	bl loc_037FFF1C	; 03801D98
	b loc_03801DCE	; 03801D9C
loc_03801D9E:
	ldr r0,[sp,#0x24]	; 03801D9E
	ldr r1,[sp,#0x28]	; 03801DA0
	bl loc_038012AC	; 03801DA2
	b loc_03801DCE	; 03801DA6
loc_03801DA8:
	ldr r0,[sp,#0x24]	; 03801DA8
	ldr r1,[sp,#0x28]	; 03801DAA
	bl loc_03801270	; 03801DAC
	b loc_03801DCE	; 03801DB0
loc_03801DB2:
	ldr r0,[sp,#0x24]	; 03801DB2
	ldr r1,[sp,#0x28]	; 03801DB4
	bl loc_037FFDFC	; 03801DB6
	b loc_03801DCE	; 03801DBA
loc_03801DBC:
	ldr r1,[sp,#0x24]	; 03801DBC
	ldr r0,[pool_03801E08]	; 03801DBE
	str r1,[r0,#0x0]	; 03801DC0
	b loc_03801DCE	; 03801DC2
loc_03801DC4:
	ldr r0,[pool_03801E0C]	; 03801DC4
	ldr r1,[sp,#0x24]	; 03801DC6
	ldr r2,[pool_03801E10]	; 03801DC8
	bl loc_03801E18	; 03801DCA
loc_03801DCE:
	ldr r5,[sp,#0x1c]	; 03801DCE
loc_03801DD0:
	cmp r5,#0x0	; 03801DD0
	beq loc_03801DD6	; 03801DD2
	b loc_03801B7C	; 03801DD4
loc_03801DD6:
	ldr r0,[pool_03801E08]	; 03801DD6
	ldr r1,[r0,#0x0]	; 03801DD8
	ldr r0,[r1,#0x0]	; 03801DDA
	add r0,r0,#0x1	; 03801DDC
	str r0,[r1,#0x0]	; 03801DDE
loc_03801DE0:
	ldr r0,[pool_03801E14]	; 03801DE0
	add r1,sp,#0x18	; 03801DE2
	mov r2,#0x0	; 03801DE4
	bl loc_037FE288	; 03801DE6
	cmp r0,#0x0	; 03801DEA
	beq loc_03801DF0	; 03801DEC
	b loc_03801B78	; 03801DEE
loc_03801DF0:
	add sp,#0x34	; 03801DF0
	pop {r4,r5,r6,r7}	; 03801DF2
	pop {r3}	; 03801DF4
	bx r3	; 03801DF6
pool_03801DF8:
loc_03801DF8:
	.word 0x00FFFFFF	; 03801DF8
pool_03801DFC:
loc_03801DFC:
	.word 0x0000FFFF	; 03801DFC
pool_03801E00:
loc_03801E00:
	.word 0x003FFFFF	; 03801E00
pool_03801E04:
loc_03801E04:
	.word 0x07FFFFFF	; 03801E04
pool_03801E08:
loc_03801E08:
	.word 0x03805F18	; 03801E08
pool_03801E0C:
loc_03801E0C:
	.word 0x03805F1C	; 03801E0C
pool_03801E10:
loc_03801E10:
	.word 0x00001180	; 03801E10
pool_03801E14:
loc_03801E14:
	.word 0x0380709C	; 03801E14

; ===== function loc_03801E18 =====
loc_03801E18:
	bx pc	; 03801E18
	.byte 0xC0, 0x46	; 03801E1C
.arm

; ===== function loc_03801E1C =====
loc_03801E1C:
	ldr pc,[pool_03801E20]	; 03801E1C
pool_03801E20:
loc_03801E20:
	.word 0x037FF364	; 03801E20
.thumb

; ===== function loc_03801E24 =====
loc_03801E24:
	push {lr}	; 03801E24
	sub sp,#0x4	; 03801E26
	ldr r0,[pool_03801E44]	; 03801E28
	ldr r1,[pool_03801E48]	; 03801E2A
	mov r2,#0x8	; 03801E2C
	bl loc_037FE35C	; 03801E2E
	bl loc_03801B20	; 03801E32
	mov r1,#0x0	; 03801E36
	ldr r0,[pool_03801E4C]	; 03801E38
	str r1,[r0,#0x0]	; 03801E3A
	add sp,#0x4	; 03801E3C
	pop {r3}	; 03801E3E
	bx r3	; 03801E40
	.byte 0xC0, 0x46	; 03801E44
pool_03801E44:
loc_03801E44:
	.word 0x0380709C	; 03801E44
pool_03801E48:
loc_03801E48:
	.word 0x038070B0	; 03801E48
pool_03801E4C:
loc_03801E4C:
	.word 0x03805F18	; 03801E4C

; ===== function loc_03801E50 =====
loc_03801E50:
	ldr r3,[pool_03801E54]	; 03801E50
	bx r3	; 03801E52
pool_03801E54:
loc_03801E54:
	.word 0x03802009	; 03801E54

; ===== function loc_03801E58 =====
	push {r4,r5,r6,r7,lr}	; 03801E58
	sub sp,#0x4	; 03801E5A
	ldr r5,[pool_03801F14]	; 03801E5C
	mov r0,#0x3	; 03801E5E
	mvn r6,r0	; 03801E60
	mov r7,#0x2	; 03801E62
	mvn r4,r7	; 03801E64
loc_03801E66:
	ldrh r1,[r5,#0x0]	; 03801E66
	ldr r0,[pool_03801F18]	; 03801E68
	and r1,r0	; 03801E6A
	cmp r1,#0x0	; 03801E6C
	beq loc_03801E7C	; 03801E6E
	ldrh r1,[r5,#0x0]	; 03801E70
	ldr r0,[pool_03801F1C]	; 03801E72
	orr r1,r0	; 03801E74
	strh r1,[r5,#0x0]	; 03801E76
	add r0,r4,#0x0	; 03801E78
	b loc_03801E9E	; 03801E7A
loc_03801E7C:
	bl loc_037FDCE0	; 03801E7C
	ldrh r2,[r5,#0x0]	; 03801E80
	ldr r1,[pool_03801F20]	; 03801E82
	and r2,r1	; 03801E84
	cmp r2,#0x0	; 03801E86
	beq loc_03801E92	; 03801E88
	bl loc_037FDD04	; 03801E8A
	add r0,r6,#0x0	; 03801E8E
	b loc_03801E9E	; 03801E90
loc_03801E92:
	ldr r1,[pool_03801F24]	; 03801E92
	ldr r1,[r1,#0x0]	; 03801E94
	str r1,[sp,#0x0]	; 03801E96
	bl loc_037FDD04	; 03801E98
	mov r0,#0x0	; 03801E9C
loc_03801E9E:
	mov r1,#0x3	; 03801E9E
	mvn r1,r1	; 03801EA0
	cmp r0,r1	; 03801EA2
	beq loc_03801F0C	; 03801EA4
	mvn r1,r7	; 03801EA6
	cmp r0,r1	; 03801EA8
	beq loc_03801E66	; 03801EAA
	ldr r2,[sp,#0x0]	; 03801EAC
	lsl r0,r2,#0x1b	; 03801EAE
	lsr r0,r0,#0x1b	; 03801EB0
	cmp r0,#0x0	; 03801EB2
	beq loc_03801E66	; 03801EB4
	lsl r3,r0,#0x2	; 03801EB6
	ldr r1,[pool_03801F28]	; 03801EB8
	ldr r3,[r1,r3]	; 03801EBA
	cmp r3,#0x0	; 03801EBC
	beq loc_03801ECC	; 03801EBE
	lsr r1,r2,#0x6	; 03801EC0
	lsl r2,r2,#0x1a	; 03801EC2
	lsr r2,r2,#0x1f	; 03801EC4
	bl loc_03805090	; 03801EC6
	b loc_03801E66	; 03801ECA
loc_03801ECC:
	lsl r0,r2,#0x1a	; 03801ECC
	lsr r0,r0,#0x1f	; 03801ECE
	cmp r0,#0x0	; 03801ED0
	bne loc_03801E66	; 03801ED2
	mov r0,#0x20	; 03801ED4
	orr r2,r0	; 03801ED6
	str r2,[sp,#0x0]	; 03801ED8
	ldrh r1,[r5,#0x0]	; 03801EDA
	ldr r0,[pool_03801F18]	; 03801EDC
	and r1,r0	; 03801EDE
	cmp r1,#0x0	; 03801EE0
	beq loc_03801EEE	; 03801EE2
	ldrh r1,[r5,#0x0]	; 03801EE4
	ldr r0,[pool_03801F1C]	; 03801EE6
	orr r1,r0	; 03801EE8
	strh r1,[r5,#0x0]	; 03801EEA
	b loc_03801E66	; 03801EEC
loc_03801EEE:
	bl loc_037FDCE0	; 03801EEE
	ldrh r1,[r5,#0x0]	; 03801EF2
	and r1,r7	; 03801EF4
	cmp r1,#0x0	; 03801EF6
	beq loc_03801F00	; 03801EF8
	bl loc_037FDD04	; 03801EFA
	b loc_03801E66	; 03801EFE
loc_03801F00:
	ldr r2,[sp,#0x0]	; 03801F00
	ldr r1,[pool_03801F2C]	; 03801F02
	str r2,[r1,#0x0]	; 03801F04
	bl loc_037FDD04	; 03801F06
	b loc_03801E66	; 03801F0A
loc_03801F0C:
	add sp,#0x4	; 03801F0C
	pop {r4,r5,r6,r7}	; 03801F0E
	pop {r3}	; 03801F10
	bx r3	; 03801F12
pool_03801F14:
loc_03801F14:
	.word 0x04000184	; 03801F14
pool_03801F18:
loc_03801F18:
	.word 0x00004000	; 03801F18
pool_03801F1C:
loc_03801F1C:
	.word 0x0000C000	; 03801F1C
pool_03801F20:
loc_03801F20:
	.word 0x00000100	; 03801F20
pool_03801F24:
loc_03801F24:
	.word 0x04100000	; 03801F24
pool_03801F28:
loc_03801F28:
	.word 0x038070D4	; 03801F28
pool_03801F2C:
loc_03801F2C:
	.word 0x04000188	; 03801F2C

; ===== function loc_03801F30 =====
loc_03801F30:
	push {r4,lr}	; 03801F30
	sub sp,#0x8	; 03801F32
	ldr r3,[sp,#0x0]	; 03801F34
	mov r4,#0x1f	; 03801F36
	bic r3,r4	; 03801F38
	and r0,r4	; 03801F3A
	orr r3,r0	; 03801F3C
	str r3,[sp,#0x0]	; 03801F3E
	mov r0,#0x20	; 03801F40
	bic r3,r0	; 03801F42
	mov r0,#0x1	; 03801F44
	and r2,r0	; 03801F46
	lsl r0,r2,#0x5	; 03801F48
	orr r3,r0	; 03801F4A
	str r3,[sp,#0x0]	; 03801F4C
	mov r0,#0x3f	; 03801F4E
	and r3,r0	; 03801F50
	ldr r0,[pool_03801FA4]	; 03801F52
	and r1,r0	; 03801F54
	lsl r0,r1,#0x6	; 03801F56
	orr r3,r0	; 03801F58
	str r3,[sp,#0x0]	; 03801F5A
	ldr r2,[pool_03801FA8]	; 03801F5C
	ldrh r1,[r2,#0x0]	; 03801F5E
	ldr r0,[pool_03801FAC]	; 03801F60
	and r1,r0	; 03801F62
	cmp r1,#0x0	; 03801F64
	beq loc_03801F76	; 03801F66
	ldrh r1,[r2,#0x0]	; 03801F68
	ldr r0,[pool_03801FB0]	; 03801F6A
	orr r1,r0	; 03801F6C
	strh r1,[r2,#0x0]	; 03801F6E
	mov r0,#0x0	; 03801F70
	mvn r0,r0	; 03801F72
	b loc_03801F9C	; 03801F74
loc_03801F76:
	bl loc_037FDCE0	; 03801F76
	ldr r1,[pool_03801FA8]	; 03801F7A
	ldrh r2,[r1,#0x0]	; 03801F7C
	mov r1,#0x2	; 03801F7E
	and r2,r1	; 03801F80
	cmp r2,#0x0	; 03801F82
	beq loc_03801F90	; 03801F84
	bl loc_037FDD04	; 03801F86
	mov r0,#0x1	; 03801F8A
	mvn r0,r0	; 03801F8C
	b loc_03801F9C	; 03801F8E
loc_03801F90:
	ldr r2,[sp,#0x0]	; 03801F90
	ldr r1,[pool_03801FB4]	; 03801F92
	str r2,[r1,#0x0]	; 03801F94
	bl loc_037FDD04	; 03801F96
	mov r0,#0x0	; 03801F9A
loc_03801F9C:
	add sp,#0x8	; 03801F9C
	pop {r4}	; 03801F9E
	pop {r3}	; 03801FA0
	bx r3	; 03801FA2
pool_03801FA4:
loc_03801FA4:
	.word 0x03FFFFFF	; 03801FA4
pool_03801FA8:
loc_03801FA8:
	.word 0x04000184	; 03801FA8
pool_03801FAC:
loc_03801FAC:
	.word 0x00004000	; 03801FAC
pool_03801FB0:
loc_03801FB0:
	.word 0x0000C000	; 03801FB0
pool_03801FB4:
loc_03801FB4:
	.word 0x04000188	; 03801FB4

; ===== function loc_03801FB8 =====
loc_03801FB8:
	push {r4,r5,lr}	; 03801FB8
	sub sp,#0x4	; 03801FBA
	add r5,r0,#0x0	; 03801FBC
	add r4,r1,#0x0	; 03801FBE
	bl loc_037FDCE0	; 03801FC0
	lsl r2,r5,#0x2	; 03801FC4
	ldr r1,[pool_03801FFC]	; 03801FC6
	str r4,[r1,r2]	; 03801FC8
	cmp r4,#0x0	; 03801FCA
	beq loc_03801FE0	; 03801FCC
	ldr r2,[pool_03802000]	; 03801FCE
	ldr r1,[pool_03802004]	; 03801FD0
	add r1,r2,r1	; 03801FD2
	ldr r3,[r1,#0x0]	; 03801FD4
	mov r2,#0x1	; 03801FD6
	lsl r2,r5	; 03801FD8
	orr r3,r2	; 03801FDA
	str r3,[r1,#0x0]	; 03801FDC
	b loc_03801FF0	; 03801FDE
loc_03801FE0:
	ldr r2,[pool_03802000]	; 03801FE0
	ldr r1,[pool_03802004]	; 03801FE2
	add r1,r2,r1	; 03801FE4
	ldr r3,[r1,#0x0]	; 03801FE6
	mov r2,#0x1	; 03801FE8
	lsl r2,r5	; 03801FEA
	bic r3,r2	; 03801FEC
	str r3,[r1,#0x0]	; 03801FEE
loc_03801FF0:
	bl loc_037FDD04	; 03801FF0
	add sp,#0x4	; 03801FF4
	pop {r4,r5}	; 03801FF6
	pop {r3}	; 03801FF8
	bx r3	; 03801FFA
pool_03801FFC:
loc_03801FFC:
	.word 0x038070D4	; 03801FFC
pool_03802000:
loc_03802000:
	.word 0x027FFC00	; 03802000
pool_03802004:
loc_03802004:
	.word 0x0000038C	; 03802004

; ===== function loc_03802008 =====
loc_03802008:
	push {r4,r5,r6,r7,lr}	; 03802008
	sub sp,#0x4	; 0380200A
	bl loc_037FDCE0	; 0380200C
	add r5,r0,#0x0	; 03802010
	ldr r0,[pool_0380207C]	; 03802012
	ldrh r1,[r0,#0x0]	; 03802014
	cmp r1,#0x0	; 03802016
	bne loc_0380206C	; 03802018
	mov r1,#0x1	; 0380201A
	strh r1,[r0,#0x0]	; 0380201C
	mov r3,#0x0	; 0380201E
	ldr r1,[pool_03802080]	; 03802020
	ldr r0,[pool_03802084]	; 03802022
	str r3,[r1,r0]	; 03802024
	add r2,r3,#0x0	; 03802026
	ldr r0,[pool_03802088]	; 03802028
loc_0380202A:
	lsl r1,r3,#0x2	; 0380202A
	str r2,[r0,r1]	; 0380202C
	add r3,r3,#0x1	; 0380202E
	cmp r3,#0x20	; 03802030
	blt loc_0380202A	; 03802032
	ldr r0,[pool_0380208C]	; 03802034
	ldr r1,[pool_03802090]	; 03802036
	bl loc_037FDB14	; 03802038
	ldr r0,[pool_0380208C]	; 0380203C
	bl loc_037FDA90	; 0380203E
	ldr r1,[pool_03802094]	; 03802042
	ldr r0,[pool_03802098]	; 03802044
	strh r1,[r0,#0x0]	; 03802046
	mov r4,#0x8	; 03802048
	add r7,r4,#0x0	; 0380204A
	ldr r6,[pool_0380209C]	; 0380204C
	b loc_03802068	; 0380204E
loc_03802050:
	lsl r0,r4,#0x8	; 03802050
	strh r0,[r6,#0x0]	; 03802052
	ldr r0,[pool_038020A0]	; 03802054
	bl loc_037FF1C8	; 03802056
	ldrh r1,[r6,#0x0]	; 0380205A
	mov r0,#0xf	; 0380205C
	and r1,r0	; 0380205E
	cmp r1,r4	; 03802060
	beq loc_03802066	; 03802062
	add r4,r7,#0x0	; 03802064
loc_03802066:
	sub r4,r4,#0x1	; 03802066
loc_03802068:
	cmp r4,#0x0	; 03802068
	bge loc_03802050	; 0380206A
loc_0380206C:
	add r0,r5,#0x0	; 0380206C
	bl loc_037FDD04	; 0380206E
	add sp,#0x4	; 03802072
	pop {r4,r5,r6,r7}	; 03802074
	pop {r3}	; 03802076
	bx r3	; 03802078
	.byte 0xC0, 0x46	; 0380207C
pool_0380207C:
loc_0380207C:
	.word 0x038070D0	; 0380207C
pool_03802080:
loc_03802080:
	.word 0x027FFC00	; 03802080
pool_03802084:
loc_03802084:
	.word 0x0000038C	; 03802084
pool_03802088:
loc_03802088:
	.word 0x038070D4	; 03802088
pool_0380208C:
loc_0380208C:
	.word 0x00040000	; 0380208C
pool_03802090:
loc_03802090:
	.word 0x03801E59	; 03802090
pool_03802094:
loc_03802094:
	.word 0x0000C408	; 03802094
pool_03802098:
loc_03802098:
	.word 0x04000184	; 03802098
pool_0380209C:
loc_0380209C:
	.word 0x04000180	; 0380209C
pool_038020A0:
loc_038020A0:
	.word 0x000003E8	; 038020A0
	push {r4,lr}	; 038020A4
	mov r4,#0x0	; 038020A6
	ldr r0,[pool_038020D0]	; 038020A8
	bl loc_03802144	; 038020AA
	ldr r0,[pool_038020D4]	; 038020AE
	ldrh r2,[r0,#0x0]	; 038020B0
	mov r0,#0x80	; 038020B2
	add r1,r2,#0x0	; 038020B4
	and r1,r0	; 038020B6
	cmp r1,#0x0	; 038020B8
	beq loc_038020BE	; 038020BA
	ldr r4,[pool_038020D0]	; 038020BC
loc_038020BE:
	mov r0,#0xb	; 038020BE
	and r2,r0	; 038020C0
	lsl r1,r2,#0xa	; 038020C2
	orr r1,r4	; 038020C4
	ldr r0,[pool_038020D8]	; 038020C6
	strh r1,[r0,#0x0]	; 038020C8
	pop {r4}	; 038020CA
	pop {r3}	; 038020CC
	bx r3	; 038020CE
pool_038020D0:
loc_038020D0:
	.word 0x00008000	; 038020D0
pool_038020D4:
loc_038020D4:
	.word 0x04000136	; 038020D4
pool_038020D8:
loc_038020D8:
	.word 0x027FFFA8	; 038020D8

; ===== function loc_038020DC =====
loc_038020DC:
	push {r4,r5,lr}	; 038020DC
	sub sp,#0xc	; 038020DE
	bl loc_037FE934	; 038020E0
	cmp r0,#0x0	; 038020E4
	beq loc_038020F0	; 038020E6
	bl loc_037FEC3C	; 038020E8
	cmp r0,#0x0	; 038020EC
	bne loc_038020F4	; 038020EE
loc_038020F0:
	mov r0,#0x0	; 038020F0
	b loc_0380212C	; 038020F2
loc_038020F4:
	ldr r0,[pool_03802134]	; 038020F4
	ldr r0,[r0,#0x0]	; 038020F6
	cmp r0,#0x0	; 038020F8
	beq loc_03802100	; 038020FA
	mov r0,#0x0	; 038020FC
	b loc_0380212C	; 038020FE
loc_03802100:
	ldr r0,[pool_03802138]	; 03802100
	bl loc_037FEC34	; 03802102
	bl loc_037FE868	; 03802106
	add r2,r0,#0x0	; 0380210A
	ldr r0,[pool_0380213C]	; 0380210C
	str r0,[sp,#0x4]	; 0380210E
	mov r5,#0x0	; 03802110
	str r5,[sp,#0x8]	; 03802112
	ldr r3,[pool_03802140]	; 03802114
	str r5,[sp,#0x0]	; 03802116
	ldr r0,[pool_03802138]	; 03802118
	add r4,r2,r3	; 0380211A
	lsl r2,r1,#0	; 0380211C
	adc r2,r5	; 0380211E
	add r1,r4,#0x0	; 03802120
	bl loc_037FEAB8	; 03802122
	mov r0,#0x1	; 03802126
	ldr r1,[pool_03802134]	; 03802128
	str r0,[r1,#0x0]	; 0380212A
loc_0380212C:
	add sp,#0xc	; 0380212C
	pop {r4,r5}	; 0380212E
	pop {r3}	; 03802130
	bx r3	; 03802132
pool_03802134:
loc_03802134:
	.word 0x03807154	; 03802134
pool_03802138:
loc_03802138:
	.word 0x03807158	; 03802138
pool_0380213C:
loc_0380213C:
	.word 0x038020A5	; 0380213C
pool_03802140:
loc_03802140:
	.word 0x0000082E	; 03802140

; ===== function loc_03802144 =====
loc_03802144:
	add r1,r0,#0x0	; 03802144
	ldr r0,[pool_03802150]	; 03802146
	lsl r1,r1,#0x10	; 03802148
	lsr r1,r1,#0x10	; 0380214A
	ldr r3,[pool_03802154]	; 0380214C
	bx r3	; 0380214E
pool_03802150:
loc_03802150:
	.word 0x0000C000	; 03802150
pool_03802154:
loc_03802154:
	.word 0x03802159	; 03802154
loc_03802158:
	mvn r3,r0	; 03802158
	ldr r2,[pool_03802168]	; 0380215A
	ldrh r0,[r2,#0x0]	; 0380215C
	and r3,r0	; 0380215E
	orr r1,r3	; 03802160
	strh r1,[r2,#0x0]	; 03802162
	bx lr	; 03802164
	.byte 0xC0, 0x46	; 03802168
pool_03802168:
loc_03802168:
	.word 0x04000134	; 03802168

; ===== function loc_0380216C =====
loc_0380216C:
	push {lr}	; 0380216C
	sub sp,#0x4	; 0380216E
	add r0,sp,#0x0	; 03802170
	bl loc_038028F0	; 03802172
	add r0,sp,#0x0	; 03802176
	add r0,#0x2	; 03802178
	bl loc_038028B0	; 0380217A
	add r0,sp,#0x0	; 0380217E
	ldrh r1,[r0,#0x0]	; 03802180
	lsl r2,r1,#0x18	; 03802182
	lsr r2,r2,#0x1f	; 03802184
	cmp r2,#0x0	; 03802186
	bne loc_0380219C	; 03802188
	lsl r1,r1,#0x19	; 0380218A
	lsr r1,r1,#0x1f	; 0380218C
	cmp r1,#0x0	; 0380218E
	bne loc_0380219C	; 03802190
	ldrh r0,[r0,#0x2]	; 03802192
	lsl r0,r0,#0x18	; 03802194
	lsr r0,r0,#0x1f	; 03802196
	cmp r0,#0x0	; 03802198
	beq loc_038021AE	; 0380219A
loc_0380219C:
	add r1,sp,#0x0	; 0380219C
	ldrh r2,[r1,#0x0]	; 0380219E
	mov r0,#0x1	; 038021A0
	bic r2,r0	; 038021A2
	orr r2,r0	; 038021A4
	strh r2,[r1,#0x0]	; 038021A6
	add r0,sp,#0x0	; 038021A8
	bl loc_038028D0	; 038021AA
loc_038021AE:
	mov r0,#0x1	; 038021AE
	bl loc_03802A20	; 038021B0
	add sp,#0x4	; 038021B4
	pop {r3}	; 038021B6
	bx r3	; 038021B8
	.byte 0x00, 0x00	; 038021BC
	ldr r0,[pool_038021C4]	; 038021BC
	ldr r3,[pool_038021C8]	; 038021BE
	bx r3	; 038021C0
	.byte 0xC0, 0x46	; 038021C4
pool_038021C4:
loc_038021C4:
	.word 0x038073A4	; 038021C4
pool_038021C8:
loc_038021C8:
	.word 0x037FDF05	; 038021C8

; ===== function loc_038021CC =====
	push {r4,r5,r6,r7,lr}	; 038021CC
	sub sp,#0xc	; 038021CE
	add r4,sp,#0x0	; 038021D0
	ldrh r1,[r4,#0x2]	; 038021D2
	mov r0,#0x10	; 038021D4
	bic r1,r0	; 038021D6
	strh r1,[r4,#0x2]	; 038021D8
	ldrh r1,[r4,#0x2]	; 038021DA
	mov r0,#0x20	; 038021DC
	bic r1,r0	; 038021DE
	strh r1,[r4,#0x2]	; 038021E0
	ldr r6,[pool_03802260]	; 038021E2
	mov r7,#0xf	; 038021E4
loc_038021E6:
	ldr r0,[pool_03802264]	; 038021E6
	bl loc_037FDF4C	; 038021E8
	ldr r0,[r6,#0x1c]	; 038021EC
	cmp r0,#0x0	; 038021EE
	bne loc_038021E6	; 038021F0
	add r0,sp,#0x0	; 038021F2
	bl loc_038028F0	; 038021F4
	ldrh r1,[r4,#0x0]	; 038021F8
	lsl r0,r1,#0x1b	; 038021FA
	lsr r2,r0,#0x1f	; 038021FC
	ldrh r0,[r4,#0x2]	; 038021FE
	lsl r3,r0,#0x1b	; 03802200
	lsr r3,r3,#0x1f	; 03802202
	sub r2,r2,r3	; 03802204
	cmp r2,#0x1	; 03802206
	beq loc_03802218	; 03802208
	lsl r1,r1,#0x1a	; 0380220A
	lsr r1,r1,#0x1f	; 0380220C
	lsl r0,r0,#0x1a	; 0380220E
	lsr r0,r0,#0x1f	; 03802210
	sub r0,r1,r0	; 03802212
	cmp r0,#0x1	; 03802214
	bne loc_03802258	; 03802216
loc_03802218:
	add r0,sp,#0x4	; 03802218
	bl loc_038028B0	; 0380221A
	mov r5,#0x0	; 0380221E
	ldrh r0,[r4,#0x0]	; 03802220
	lsl r0,r0,#0x1b	; 03802222
	lsr r0,r0,#0x1f	; 03802224
	cmp r0,#0x0	; 03802226
	beq loc_03802234	; 03802228
	mov r0,#0x1	; 0380222A
	orr r5,r0	; 0380222C
	ldrh r0,[r4,#0x4]	; 0380222E
	bic r0,r7	; 03802230
	strh r0,[r4,#0x4]	; 03802232
loc_03802234:
	ldrh r0,[r4,#0x0]	; 03802234
	lsl r0,r0,#0x1a	; 03802236
	lsr r0,r0,#0x1f	; 03802238
	cmp r0,#0x0	; 0380223A
	beq loc_0380224A	; 0380223C
	mov r0,#0x2	; 0380223E
	orr r5,r0	; 03802240
	ldrh r1,[r4,#0x4]	; 03802242
	mov r0,#0x40	; 03802244
	bic r1,r0	; 03802246
	strh r1,[r4,#0x4]	; 03802248
loc_0380224A:
	add r0,sp,#0x4	; 0380224A
	bl loc_03802890	; 0380224C
	mov r0,#0x30	; 03802250
	add r1,r5,#0x0	; 03802252
	bl loc_0380245C	; 03802254
loc_03802258:
	ldrh r0,[r4,#0x0]	; 03802258
	strh r0,[r4,#0x2]	; 0380225A
	b loc_038021E6	; 0380225C
	.byte 0xC0, 0x46	; 03802260
pool_03802260:
loc_03802260:
	.word 0x03807308	; 03802260
pool_03802264:
loc_03802264:
	.word 0x038073A4	; 03802264

; ===== function loc_03802268 =====
	push {r4,r5,r6,r7,lr}	; 03802268
	sub sp,#0x4	; 0380226A
	ldr r5,[pool_03802450]	; 0380226C
	add r6,r5,#0x4	; 0380226E
	mov r7,#0x0	; 03802270
	ldr r4,[pool_03802454]	; 03802272
loc_03802274:
	ldr r0,[pool_03802458]	; 03802274
	add r1,sp,#0x0	; 03802276
	mov r2,#0x1	; 03802278
	bl loc_037FE288	; 0380227A
	ldrh r0,[r4,#0x20]	; 0380227E
	cmp r0,#0x10	; 03802280
	bgt loc_0380229E	; 03802282
	cmp r0,#0x10	; 03802284
	bge loc_03802308	; 03802286
	cmp r0,#0x1	; 03802288
	ble loc_0380228E	; 0380228A
	b loc_03802444	; 0380228C
loc_0380228E:
	cmp r0,#0x0	; 0380228E
	bge loc_03802294	; 03802290
	b loc_03802444	; 03802292
loc_03802294:
	cmp r0,#0x0	; 03802294
	beq loc_038022E2	; 03802296
	cmp r0,#0x1	; 03802298
	beq loc_038022F2	; 0380229A
	b loc_03802444	; 0380229C
loc_0380229E:
	add r1,r0,#0x0	; 0380229E
	sub r1,#0x14	; 038022A0
	cmp r1,#0x15	; 038022A2
	bls loc_038022A8	; 038022A4
	b loc_03802444	; 038022A6
loc_038022A8:
	add r1,r1,r1	; 038022A8
	add r1,pc	; 038022AA
	ldrh r1,[r1,#0x8]	; 038022AC
	lsl r1,r1,#0x10	; 038022AE
	asr r1,r1,#0x10	; 038022B0
	add r1,pc	; 038022B2
	bx r1	; 038022B4
	.byte 0x65, 0x00, 0x87, 0x00, 0xA9, 0x00, 0xBB, 0x00, 0xCD, 0x00, 0xDF, 0x00, 0x8F, 0x01, 0x8F, 0x01	; 038022C6
	.byte 0x8F, 0x01, 0x8F, 0x01, 0x8F, 0x01, 0x8F, 0x01, 0xF1, 0x00, 0x8F, 0x01, 0x8F, 0x01, 0x8F, 0x01	; 038022D6
	.byte 0x03, 0x01, 0x25, 0x01, 0x47, 0x01, 0x59, 0x01, 0x6B, 0x01, 0x7D, 0x01	; 038022E2
loc_038022E2:
	bl loc_03802AC8	; 038022E2
	str r7,[r4,#0x1c]	; 038022E6
	add r0,r7,#0x0	; 038022E8
	add r1,r7,#0x0	; 038022EA
	bl loc_0380245C	; 038022EC
	b loc_03802274	; 038022F0
loc_038022F2:
	ldrh r0,[r5,#0x0]	; 038022F2
	lsl r0,r0,#0x1e	; 038022F4
	lsr r0,r0,#0x1f	; 038022F6
	bl loc_03802A20	; 038022F8
	str r7,[r4,#0x1c]	; 038022FC
	mov r0,#0x1	; 038022FE
	add r1,r7,#0x0	; 03802300
	bl loc_0380245C	; 03802302
	b loc_03802274	; 03802306
loc_03802308:
	add r0,r5,#0x0	; 03802308
	bl loc_03802A00	; 0380230A
	str r7,[r4,#0x1c]	; 0380230E
	mov r0,#0x10	; 03802310
	add r1,r7,#0x0	; 03802312
	bl loc_0380245C	; 03802314
	b loc_03802274	; 03802318
loc_0380231A:
	add r0,r5,#0x4	; 0380231A
	bl loc_038029AC	; 0380231C
	cmp r0,#0x0	; 03802320
	bne loc_03802330	; 03802322
	str r7,[r4,#0x1c]	; 03802324
	mov r0,#0x14	; 03802326
	mov r1,#0x2	; 03802328
	bl loc_0380245C	; 0380232A
	b loc_03802274	; 0380232E
loc_03802330:
	str r7,[r4,#0x1c]	; 03802330
	mov r0,#0x14	; 03802332
	add r1,r7,#0x0	; 03802334
	bl loc_0380245C	; 03802336
	b loc_03802274	; 0380233A
loc_0380233C:
	add r0,r6,#0x0	; 0380233C
	bl loc_03802944	; 0380233E
	cmp r0,#0x0	; 03802342
	bne loc_03802352	; 03802344
	str r7,[r4,#0x1c]	; 03802346
	mov r0,#0x15	; 03802348
	mov r1,#0x2	; 0380234A
	bl loc_0380245C	; 0380234C
	b loc_03802274	; 03802350
loc_03802352:
	str r7,[r4,#0x1c]	; 03802352
	mov r0,#0x15	; 03802354
	add r1,r7,#0x0	; 03802356
	bl loc_0380245C	; 03802358
	b loc_03802274	; 0380235C
loc_0380235E:
	add r0,r5,#0x0	; 0380235E
	bl loc_038028F0	; 03802360
	str r7,[r4,#0x1c]	; 03802364
	mov r0,#0x16	; 03802366
	add r1,r7,#0x0	; 03802368
	bl loc_0380245C	; 0380236A
	b loc_03802274	; 0380236E
loc_03802370:
	add r0,r5,#0x2	; 03802370
	bl loc_038028B0	; 03802372
	str r7,[r4,#0x1c]	; 03802376
	mov r0,#0x17	; 03802378
	add r1,r7,#0x0	; 0380237A
	bl loc_0380245C	; 0380237C
	b loc_03802274	; 03802380
loc_03802382:
	add r0,r5,#0x4	; 03802382
	bl loc_03802870	; 03802384
	str r7,[r4,#0x1c]	; 03802388
	mov r0,#0x18	; 0380238A
	add r1,r7,#0x0	; 0380238C
	bl loc_0380245C	; 0380238E
	b loc_03802274	; 03802392
loc_03802394:
	add r0,r5,#0x4	; 03802394
	bl loc_03802830	; 03802396
	str r7,[r4,#0x1c]	; 0380239A
	mov r0,#0x19	; 0380239C
	add r1,r7,#0x0	; 0380239E
	bl loc_0380245C	; 038023A0
	b loc_03802274	; 038023A4
loc_038023A6:
	add r0,r5,#0x0	; 038023A6
	bl loc_038029E0	; 038023A8
	str r7,[r4,#0x1c]	; 038023AC
	mov r0,#0x20	; 038023AE
	add r1,r7,#0x0	; 038023B0
	bl loc_0380245C	; 038023B2
	b loc_03802274	; 038023B6
loc_038023B8:
	add r0,r6,#0x0	; 038023B8
	bl loc_03802978	; 038023BA
	cmp r0,#0x0	; 038023BE
	bne loc_038023CE	; 038023C0
	str r7,[r4,#0x1c]	; 038023C2
	mov r0,#0x24	; 038023C4
	mov r1,#0x2	; 038023C6
	bl loc_0380245C	; 038023C8
	b loc_03802274	; 038023CC
loc_038023CE:
	str r7,[r4,#0x1c]	; 038023CE
	mov r0,#0x24	; 038023D0
	add r1,r7,#0x0	; 038023D2
	bl loc_0380245C	; 038023D4
	b loc_03802274	; 038023D8
loc_038023DA:
	add r0,r6,#0x0	; 038023DA
	bl loc_03802910	; 038023DC
	cmp r0,#0x0	; 038023E0
	bne loc_038023F0	; 038023E2
	str r7,[r4,#0x1c]	; 038023E4
	mov r0,#0x25	; 038023E6
	mov r1,#0x2	; 038023E8
	bl loc_0380245C	; 038023EA
	b loc_03802274	; 038023EE
loc_038023F0:
	str r7,[r4,#0x1c]	; 038023F0
	mov r0,#0x25	; 038023F2
	add r1,r7,#0x0	; 038023F4
	bl loc_0380245C	; 038023F6
	b loc_03802274	; 038023FA
loc_038023FC:
	add r0,r5,#0x0	; 038023FC
	bl loc_038028D0	; 038023FE
	str r7,[r4,#0x1c]	; 03802402
	mov r0,#0x26	; 03802404
	add r1,r7,#0x0	; 03802406
	bl loc_0380245C	; 03802408
	b loc_03802274	; 0380240C
loc_0380240E:
	add r0,r5,#0x2	; 0380240E
	bl loc_03802890	; 03802410
	str r7,[r4,#0x1c]	; 03802414
	mov r0,#0x27	; 03802416
	add r1,r7,#0x0	; 03802418
	bl loc_0380245C	; 0380241A
	b loc_03802274	; 0380241E
loc_03802420:
	add r0,r5,#0x4	; 03802420
	bl loc_03802850	; 03802422
	str r7,[r4,#0x1c]	; 03802426
	mov r0,#0x28	; 03802428
	add r1,r7,#0x0	; 0380242A
	bl loc_0380245C	; 0380242C
	b loc_03802274	; 03802430
loc_03802432:
	add r0,r5,#0x4	; 03802432
	bl loc_03802810	; 03802434
	str r7,[r4,#0x1c]	; 03802438
	mov r0,#0x29	; 0380243A
	add r1,r7,#0x0	; 0380243C
	bl loc_0380245C	; 0380243E
	b loc_03802274	; 03802442
loc_03802444:
	str r7,[r4,#0x1c]	; 03802444
	mov r1,#0x1	; 03802446
	bl loc_0380245C	; 03802448
	b loc_03802274	; 0380244C
	.byte 0xC0, 0x46	; 03802450
pool_03802450:
loc_03802450:
	.word 0x027FFDE8	; 03802450
pool_03802454:
loc_03802454:
	.word 0x03807308	; 03802454
pool_03802458:
loc_03802458:
	.word 0x03807188	; 03802458

; ===== function loc_0380245C =====
loc_0380245C:
	add r2,r0,#0x0	; 0380245C
	mov r0,#0x5	; 0380245E
	lsl r3,r2,#0x8	; 03802460
	ldr r2,[pool_03802478]	; 03802462
	and r3,r2	; 03802464
	ldr r2,[pool_0380247C]	; 03802466
	orr r3,r2	; 03802468
	mov r2,#0xff	; 0380246A
	and r1,r2	; 0380246C
	orr r3,r1	; 0380246E
	add r1,r3,#0x0	; 03802470
	mov r2,#0x0	; 03802472
	ldr r3,[pool_03802480]	; 03802474
	bx r3	; 03802476
pool_03802478:
loc_03802478:
	.word 0x00007F00	; 03802478
pool_0380247C:
loc_0380247C:
	.word 0x00008000	; 0380247C
pool_03802480:
loc_03802480:
	.word 0x03801F31	; 03802480
	push {r4,lr}	; 03802484
	cmp r2,#0x0	; 03802486
	bne loc_03802526	; 03802488
	ldr r0,[pool_0380252C]	; 0380248A
	and r1,r0	; 0380248C
	lsl r0,r1,#0x8	; 0380248E
	lsr r4,r0,#0x10	; 03802490
	cmp r4,#0x10	; 03802492
	bgt loc_038024AC	; 03802494
	cmp r4,#0x10	; 03802496
	bge loc_038024EE	; 03802498
	cmp r4,#0x1	; 0380249A
	bgt loc_0380251E	; 0380249C
	cmp r4,#0x0	; 0380249E
	blt loc_0380251E	; 038024A0
	cmp r4,#0x0	; 038024A2
	beq loc_038024EE	; 038024A4
	cmp r4,#0x1	; 038024A6
	beq loc_038024EE	; 038024A8
	b loc_0380251E	; 038024AA
loc_038024AC:
	add r0,r4,#0x0	; 038024AC
	sub r0,#0x14	; 038024AE
	cmp r0,#0x15	; 038024B0
	bhi loc_0380251E	; 038024B2
	add r0,r0,r0	; 038024B4
	add r0,pc	; 038024B6
	ldrh r0,[r0,#0x8]	; 038024B8
	lsl r0,r0,#0x10	; 038024BA
	asr r0,r0,#0x10	; 038024BC
	add r0,pc	; 038024BE
	bx r0	; 038024C0
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x5D, 0x00, 0x5D, 0x00	; 038024D2
	.byte 0x5D, 0x00, 0x5D, 0x00, 0x5D, 0x00, 0x5D, 0x00, 0x2D, 0x00, 0x5D, 0x00, 0x5D, 0x00, 0x5D, 0x00	; 038024E2
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00	; 038024EE
loc_038024EE:
	ldr r0,[pool_03802530]	; 038024EE
	ldr r1,[r0,#0x1c]	; 038024F0
	cmp r1,#0x0	; 038024F2
	beq loc_03802500	; 038024F4
	add r0,r4,#0x0	; 038024F6
	mov r1,#0x3	; 038024F8
	bl loc_0380245C	; 038024FA
	b loc_03802526	; 038024FE
loc_03802500:
	mov r1,#0x1	; 03802500
	str r1,[r0,#0x1c]	; 03802502
	strh r4,[r0,#0x20]	; 03802504
	ldr r0,[pool_03802534]	; 03802506
	mov r1,#0x0	; 03802508
	add r2,r1,#0x0	; 0380250A
	bl loc_037FE300	; 0380250C
	cmp r0,#0x0	; 03802510
	bne loc_03802526	; 03802512
	add r0,r4,#0x0	; 03802514
	mov r1,#0x4	; 03802516
	bl loc_0380245C	; 03802518
	b loc_03802526	; 0380251C
loc_0380251E:
	add r0,r4,#0x0	; 0380251E
	mov r1,#0x1	; 03802520
	bl loc_0380245C	; 03802522
loc_03802526:
	pop {r4}	; 03802526
	pop {r3}	; 03802528
	bx r3	; 0380252A
pool_0380252C:
loc_0380252C:
	.word 0x00007F00	; 0380252C
pool_03802530:
loc_03802530:
	.word 0x03807308	; 03802530
pool_03802534:
loc_03802534:
	.word 0x03807188	; 03802534

; ===== function loc_03802538 =====
loc_03802538:
	push {r4,lr}	; 03802538
	sub sp,#0x10	; 0380253A
	add r4,r0,#0x0	; 0380253C
	mov r1,#0x1	; 0380253E
	ldr r0,[pool_038025D4]	; 03802540
	strh r1,[r0,#0x0]	; 03802542
	ldr r0,[pool_038025D8]	; 03802544
	str r1,[r0,#0x1c]	; 03802546
	bl loc_0380216C	; 03802548
	mov r1,#0x0	; 0380254C
	ldr r0,[pool_038025D8]	; 0380254E
	str r1,[r0,#0x1c]	; 03802550
	bl loc_03801E50	; 03802552
	mov r0,#0x5	; 03802556
	ldr r1,[pool_038025DC]	; 03802558
	bl loc_03801FB8	; 0380255A
	ldr r0,[pool_038025E0]	; 0380255E
	ldr r1,[pool_038025E4]	; 03802560
	mov r2,#0x4	; 03802562
	bl loc_037FE35C	; 03802564
	ldr r0,[pool_038025E8]	; 03802568
	str r0,[sp,#0x0]	; 0380256A
	str r4,[sp,#0x4]	; 0380256C
	ldr r0,[pool_038025EC]	; 0380256E
	ldr r1,[pool_038025F0]	; 03802570
	mov r2,#0x0	; 03802572
	ldr r3,[pool_038025F4]	; 03802574
	bl loc_037FDFCC	; 03802576
	ldr r0,[pool_038025EC]	; 0380257A
	bl loc_037FDEE0	; 0380257C
	mov r2,#0x0	; 03802580
	ldr r0,[pool_038025F8]	; 03802582
	strh r2,[r0,#0x1c]	; 03802584
	ldr r0,[pool_038025E8]	; 03802586
	str r0,[sp,#0x0]	; 03802588
	sub r0,r4,#0x1	; 0380258A
	str r0,[sp,#0x4]	; 0380258C
	ldr r0,[pool_038025FC]	; 0380258E
	ldr r1,[pool_03802600]	; 03802590
	ldr r3,[pool_03802604]	; 03802592
	bl loc_037FDFCC	; 03802594
	ldr r0,[pool_038025FC]	; 03802598
	bl loc_037FDEE0	; 0380259A
	bl loc_037FEC3C	; 0380259E
	cmp r0,#0x0	; 038025A2
	bne loc_038025AA	; 038025A4
	bl loc_037FEC48	; 038025A6
loc_038025AA:
	ldr r0,[pool_03802604]	; 038025AA
	bl loc_037FEC34	; 038025AC
	bl loc_037FE868	; 038025B0
	add r4,r0,#0x0	; 038025B4
	add r2,r1,#0x0	; 038025B6
	ldr r0,[pool_03802608]	; 038025B8
	str r0,[sp,#0x4]	; 038025BA
	mov r0,#0x0	; 038025BC
	str r0,[sp,#0x8]	; 038025BE
	ldr r3,[pool_0380260C]	; 038025C0
	str r0,[sp,#0x0]	; 038025C2
	ldr r0,[pool_03802604]	; 038025C4
	add r1,r4,#0x0	; 038025C6
	bl loc_037FEAB8	; 038025C8
	add sp,#0x10	; 038025CC
	pop {r4}	; 038025CE
	pop {r3}	; 038025D0
	bx r3	; 038025D2
pool_038025D4:
loc_038025D4:
	.word 0x03807184	; 038025D4
pool_038025D8:
loc_038025D8:
	.word 0x03807308	; 038025D8
pool_038025DC:
loc_038025DC:
	.word 0x03802485	; 038025DC
pool_038025E0:
loc_038025E0:
	.word 0x03807188	; 038025E0
pool_038025E4:
loc_038025E4:
	.word 0x0380719C	; 038025E4
pool_038025E8:
loc_038025E8:
	.word 0x00000100	; 038025E8
pool_038025EC:
loc_038025EC:
	.word 0x038071AC	; 038025EC
pool_038025F0:
loc_038025F0:
	.word 0x03802269	; 038025F0
pool_038025F4:
loc_038025F4:
	.word 0x03807324	; 038025F4
pool_038025F8:
loc_038025F8:
	.word 0x03807388	; 038025F8
pool_038025FC:
loc_038025FC:
	.word 0x0380732C	; 038025FC
pool_03802600:
loc_03802600:
	.word 0x038021CD	; 03802600
pool_03802604:
loc_03802604:
	.word 0x038074A8	; 03802604
pool_03802608:
loc_03802608:
	.word 0x038021BD	; 03802608
pool_0380260C:
loc_0380260C:
	.word 0x00001388	; 0380260C

; ===== function loc_03802610 =====
loc_03802610:
	push {r4,r5,r6,r7,lr}	; 03802610
	sub sp,#0x4	; 03802612
	add r5,r0,#0x0	; 03802614
	add r7,r1,#0x0	; 03802616
	add r4,r2,#0x0	; 03802618
	add r6,r3,#0x0	; 0380261A
	bl loc_03802650	; 0380261C
	add r0,r5,#0x0	; 03802620
	add r1,r7,#0x0	; 03802622
	bl loc_0380265C	; 03802624
	cmp r5,#0x6	; 03802628
	beq loc_0380263A	; 0380262A
	cmp r5,#0x86	; 0380262C
	bne loc_03802642	; 0380262E
	add r0,r4,#0x0	; 03802630
	add r1,r6,#0x0	; 03802632
	bl loc_03802668	; 03802634
	b loc_03802642	; 03802638
loc_0380263A:
	add r0,r4,#0x0	; 0380263A
	add r1,r6,#0x0	; 0380263C
	bl loc_03802674	; 0380263E
loc_03802642:
	bl loc_03802680	; 03802642
	add sp,#0x4	; 03802646
	pop {r4,r5,r6,r7}	; 03802648
	pop {r3}	; 0380264A
	bx r3	; 0380264C
	.byte 0xC0, 0x46	; 03802650

; ===== function loc_03802650 =====
loc_03802650:
	bx pc	; 03802650
	.byte 0xC0, 0x46	; 03802654
.arm

; ===== function loc_03802654 =====
loc_03802654:
	ldr pc,[pool_03802658]	; 03802654
pool_03802658:
loc_03802658:
	.word 0x03802AF4	; 03802658
.thumb

; ===== function loc_0380265C =====
loc_0380265C:
	bx pc	; 0380265C
	.byte 0xC0, 0x46	; 03802660
.arm

; ===== function loc_03802660 =====
loc_03802660:
	ldr pc,[pool_03802664]	; 03802660
pool_03802664:
loc_03802664:
	.word 0x03802B68	; 03802664
.thumb

; ===== function loc_03802668 =====
loc_03802668:
	bx pc	; 03802668
	.byte 0xC0, 0x46	; 0380266C
.arm

; ===== function loc_0380266C =====
loc_0380266C:
	ldr pc,[pool_03802670]	; 0380266C
pool_03802670:
loc_03802670:
	.word 0x03802C68	; 03802670
.thumb

; ===== function loc_03802674 =====
loc_03802674:
	bx pc	; 03802674
	.byte 0xC0, 0x46	; 03802678
.arm

; ===== function loc_03802678 =====
loc_03802678:
	ldr pc,[pool_0380267C]	; 03802678
pool_0380267C:
loc_0380267C:
	.word 0x03802BD8	; 0380267C
.thumb

; ===== function loc_03802680 =====
loc_03802680:
	bx pc	; 03802680
	.byte 0xC0, 0x46	; 03802684
.arm

; ===== function loc_03802684 =====
loc_03802684:
	ldr pc,[pool_03802688]	; 03802684
pool_03802688:
loc_03802688:
	.word 0x03802B34	; 03802688
.thumb

; ===== function loc_0380268C =====
loc_0380268C:
	ldr r1,[r0,#0x0]	; 0380268C
	lsl r2,r1,#0x12	; 0380268E
	lsr r2,r2,#0x1a	; 03802690
	cmp r2,#0x23	; 03802692
	bhi loc_03802728	; 03802694
	add r3,r2,r2	; 03802696
	add r3,pc	; 03802698
	ldrh r3,[r3,#0x8]	; 0380269A
	lsl r3,r3,#0x10	; 0380269C
	asr r3,r3,#0x10	; 0380269E
	add r3,pc	; 038026A0
	bx r3	; 038026A2
	.byte 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00	; 038026B4
	.byte 0x63, 0x00, 0x63, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00	; 038026C4
	.byte 0x49, 0x00, 0x49, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00	; 038026D4
	.byte 0x7D, 0x00, 0x7D, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00, 0x85, 0x00	; 038026E4
	.byte 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00, 0x7D, 0x00	; 038026EC
loc_038026EC:
	lsl r3,r1,#0x11	; 038026EC
	lsr r3,r3,#0x1f	; 038026EE
	cmp r3,#0x0	; 038026F0
	beq loc_03802738	; 038026F2
	ldr r3,[pool_0380273C]	; 038026F4
	and r1,r3	; 038026F6
	add r2,#0x12	; 038026F8
	mov r3,#0x3f	; 038026FA
	and r2,r3	; 038026FC
	lsl r2,r2,#0x8	; 038026FE
	orr r1,r2	; 03802700
	str r1,[r0,#0x0]	; 03802702
	bx lr	; 03802704
loc_03802706:
	lsl r3,r1,#0x11	; 03802706
	lsr r3,r3,#0x1f	; 03802708
	cmp r3,#0x0	; 0380270A
	beq loc_03802738	; 0380270C
	ldr r3,[pool_0380273C]	; 0380270E
	and r1,r3	; 03802710
	add r2,#0x18	; 03802712
	mov r3,#0x3f	; 03802714
	and r2,r3	; 03802716
	lsl r2,r2,#0x8	; 03802718
	orr r1,r2	; 0380271A
	str r1,[r0,#0x0]	; 0380271C
	bx lr	; 0380271E
loc_03802720:
	ldr r2,[pool_03802740]	; 03802720
	orr r1,r2	; 03802722
	str r1,[r0,#0x0]	; 03802724
	bx lr	; 03802726
loc_03802728:
	ldr r2,[r0,#0x0]	; 03802728
	ldr r1,[pool_03802744]	; 0380272A
	and r2,r1	; 0380272C
	str r2,[r0,#0x0]	; 0380272E
	ldr r2,[r0,#0x0]	; 03802730
	ldr r1,[pool_0380273C]	; 03802732
	and r2,r1	; 03802734
	str r2,[r0,#0x0]	; 03802736
loc_03802738:
	bx lr	; 03802738
	.byte 0xC0, 0x46	; 0380273C
pool_0380273C:
loc_0380273C:
	.word 0xFFFFC0FF	; 0380273C
pool_03802740:
loc_03802740:
	.word 0x00004000	; 03802740
pool_03802744:
loc_03802744:
	.word 0xFFFFBFFF	; 03802744

; ===== function loc_03802748 =====
loc_03802748:
	ldr r1,[r0,#0x0]	; 03802748
	lsl r2,r1,#0x12	; 0380274A
	lsr r2,r2,#0x1a	; 0380274C
	cmp r2,#0x23	; 0380274E
	bhi loc_038027F0	; 03802750
	add r2,r2,r2	; 03802752
	add r2,pc	; 03802754
	ldrh r2,[r2,#0x8]	; 03802756
	lsl r2,r2,#0x10	; 03802758
	asr r2,r2,#0x10	; 0380275A
	add r2,pc	; 0380275C
	bx r2	; 0380275E
	.byte 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00, 0x49, 0x00	; 03802770
	.byte 0x49, 0x00, 0x49, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00	; 03802780
	.byte 0x49, 0x00, 0x49, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00, 0x51, 0x00	; 03802790
	.byte 0x51, 0x00, 0x51, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00, 0x91, 0x00	; 038027A0
	.byte 0x71, 0x00, 0x71, 0x00, 0x51, 0x00, 0x51, 0x00	; 038027A8
loc_038027A8:
	ldr r2,[pool_03802804]	; 038027A8
	and r1,r2	; 038027AA
	str r1,[r0,#0x0]	; 038027AC
	bx lr	; 038027AE
loc_038027B0:
	ldr r2,[pool_03802808]	; 038027B0
	orr r1,r2	; 038027B2
	str r1,[r0,#0x0]	; 038027B4
	ldr r2,[r0,#0x0]	; 038027B6
	ldr r1,[pool_0380280C]	; 038027B8
	add r3,r2,#0x0	; 038027BA
	and r3,r1	; 038027BC
	lsl r1,r2,#0x12	; 038027BE
	lsr r2,r1,#0x1a	; 038027C0
	sub r2,#0x12	; 038027C2
	mov r1,#0x3f	; 038027C4
	and r2,r1	; 038027C6
	lsl r1,r2,#0x8	; 038027C8
	orr r3,r1	; 038027CA
	str r3,[r0,#0x0]	; 038027CC
	bx lr	; 038027CE
loc_038027D0:
	ldr r2,[pool_03802808]	; 038027D0
	orr r1,r2	; 038027D2
	str r1,[r0,#0x0]	; 038027D4
	ldr r2,[r0,#0x0]	; 038027D6
	ldr r1,[pool_0380280C]	; 038027D8
	add r3,r2,#0x0	; 038027DA
	and r3,r1	; 038027DC
	lsl r1,r2,#0x12	; 038027DE
	lsr r2,r1,#0x1a	; 038027E0
	sub r2,#0x18	; 038027E2
	mov r1,#0x3f	; 038027E4
	and r2,r1	; 038027E6
	lsl r1,r2,#0x8	; 038027E8
	orr r3,r1	; 038027EA
	str r3,[r0,#0x0]	; 038027EC
	bx lr	; 038027EE
loc_038027F0:
	ldr r2,[r0,#0x0]	; 038027F0
	ldr r1,[pool_03802804]	; 038027F2
	and r2,r1	; 038027F4
	str r2,[r0,#0x0]	; 038027F6
	ldr r2,[r0,#0x0]	; 038027F8
	ldr r1,[pool_0380280C]	; 038027FA
	and r2,r1	; 038027FC
	str r2,[r0,#0x0]	; 038027FE
	bx lr	; 03802800
	.byte 0xC0, 0x46	; 03802804
pool_03802804:
loc_03802804:
	.word 0xFFFFBFFF	; 03802804
pool_03802808:
loc_03802808:
	.word 0x00004000	; 03802808
pool_0380280C:
loc_0380280C:
	.word 0xFFFFC0FF	; 0380280C

; ===== function loc_03802810 =====
loc_03802810:
	push {r4,lr}	; 03802810
	add r4,r0,#0x0	; 03802812
	ldr r0,[pool_0380282C]	; 03802814
	bl loc_03802144	; 03802816
	mov r0,#0x6	; 0380281A
	mov r1,#0x70	; 0380281C
	add r2,r4,#0x0	; 0380281E
	mov r3,#0x1	; 03802820
	bl loc_03802610	; 03802822
	pop {r4}	; 03802826
	pop {r3}	; 03802828
	bx r3	; 0380282A
pool_0380282C:
loc_0380282C:
	.word 0x00008000	; 0380282C

; ===== function loc_03802830 =====
loc_03802830:
	push {r4,lr}	; 03802830
	add r4,r0,#0x0	; 03802832
	ldr r0,[pool_0380284C]	; 03802834
	bl loc_03802144	; 03802836
	mov r0,#0x86	; 0380283A
	mov r1,#0x70	; 0380283C
	add r2,r4,#0x0	; 0380283E
	mov r3,#0x1	; 03802840
	bl loc_03802610	; 03802842
	pop {r4}	; 03802846
	pop {r3}	; 03802848
	bx r3	; 0380284A
pool_0380284C:
loc_0380284C:
	.word 0x00008000	; 0380284C

; ===== function loc_03802850 =====
loc_03802850:
	push {r4,lr}	; 03802850
	add r4,r0,#0x0	; 03802852
	ldr r0,[pool_0380286C]	; 03802854
	bl loc_03802144	; 03802856
	mov r0,#0x6	; 0380285A
	mov r1,#0x30	; 0380285C
	add r2,r4,#0x0	; 0380285E
	mov r3,#0x1	; 03802860
	bl loc_03802610	; 03802862
	pop {r4}	; 03802866
	pop {r3}	; 03802868
	bx r3	; 0380286A
pool_0380286C:
loc_0380286C:
	.word 0x00008000	; 0380286C

; ===== function loc_03802870 =====
loc_03802870:
	push {r4,lr}	; 03802870
	add r4,r0,#0x0	; 03802872
	ldr r0,[pool_0380288C]	; 03802874
	bl loc_03802144	; 03802876
	mov r0,#0x86	; 0380287A
	mov r1,#0x30	; 0380287C
	add r2,r4,#0x0	; 0380287E
	mov r3,#0x1	; 03802880
	bl loc_03802610	; 03802882
	pop {r4}	; 03802886
	pop {r3}	; 03802888
	bx r3	; 0380288A
pool_0380288C:
loc_0380288C:
	.word 0x00008000	; 0380288C

; ===== function loc_03802890 =====
loc_03802890:
	push {r4,lr}	; 03802890
	add r4,r0,#0x0	; 03802892
	ldr r0,[pool_038028AC]	; 03802894
	bl loc_03802144	; 03802896
	mov r0,#0x6	; 0380289A
	mov r1,#0x40	; 0380289C
	add r2,r4,#0x0	; 0380289E
	mov r3,#0x1	; 038028A0
	bl loc_03802610	; 038028A2
	pop {r4}	; 038028A6
	pop {r3}	; 038028A8
	bx r3	; 038028AA
pool_038028AC:
loc_038028AC:
	.word 0x00008000	; 038028AC

; ===== function loc_038028B0 =====
loc_038028B0:
	push {r4,lr}	; 038028B0
	add r4,r0,#0x0	; 038028B2
	ldr r0,[pool_038028CC]	; 038028B4
	bl loc_03802144	; 038028B6
	mov r0,#0x86	; 038028BA
	mov r1,#0x40	; 038028BC
	add r2,r4,#0x0	; 038028BE
	mov r3,#0x1	; 038028C0
	bl loc_03802610	; 038028C2
	pop {r4}	; 038028C6
	pop {r3}	; 038028C8
	bx r3	; 038028CA
pool_038028CC:
loc_038028CC:
	.word 0x00008000	; 038028CC

; ===== function loc_038028D0 =====
loc_038028D0:
	push {r4,lr}	; 038028D0
	add r4,r0,#0x0	; 038028D2
	ldr r0,[pool_038028EC]	; 038028D4
	bl loc_03802144	; 038028D6
	mov r0,#0x6	; 038028DA
	mov r1,#0x0	; 038028DC
	add r2,r4,#0x0	; 038028DE
	mov r3,#0x1	; 038028E0
	bl loc_03802610	; 038028E2
	pop {r4}	; 038028E6
	pop {r3}	; 038028E8
	bx r3	; 038028EA
pool_038028EC:
loc_038028EC:
	.word 0x00008000	; 038028EC

; ===== function loc_038028F0 =====
loc_038028F0:
	push {r4,lr}	; 038028F0
	add r4,r0,#0x0	; 038028F2
	ldr r0,[pool_0380290C]	; 038028F4
	bl loc_03802144	; 038028F6
	mov r0,#0x86	; 038028FA
	mov r1,#0x0	; 038028FC
	add r2,r4,#0x0	; 038028FE
	mov r3,#0x1	; 03802900
	bl loc_03802610	; 03802902
	pop {r4}	; 03802906
	pop {r3}	; 03802908
	bx r3	; 0380290A
pool_0380290C:
loc_0380290C:
	.word 0x00008000	; 0380290C

; ===== function loc_03802910 =====
loc_03802910:
	push {r4,lr}	; 03802910
	sub sp,#0x8	; 03802912
	add r4,r0,#0x0	; 03802914
	add r0,sp,#0x0	; 03802916
	bl loc_038028B0	; 03802918
	add r0,sp,#0x0	; 0380291C
	ldrh r0,[r0,#0x0]	; 0380291E
	lsl r0,r0,#0x19	; 03802920
	lsr r0,r0,#0x1f	; 03802922
	cmp r0,#0x0	; 03802924
	beq loc_03802938	; 03802926
	mov r0,#0x6	; 03802928
	mov r1,#0x50	; 0380292A
	add r2,r4,#0x0	; 0380292C
	mov r3,#0x3	; 0380292E
	bl loc_03802610	; 03802930
	mov r0,#0x1	; 03802934
	b loc_0380293A	; 03802936
loc_03802938:
	mov r0,#0x0	; 03802938
loc_0380293A:
	add sp,#0x8	; 0380293A
	pop {r4}	; 0380293C
	pop {r3}	; 0380293E
	bx r3	; 03802940
	.byte 0x00, 0x00	; 03802944

; ===== function loc_03802944 =====
loc_03802944:
	push {r4,lr}	; 03802944
	sub sp,#0x8	; 03802946
	add r4,r0,#0x0	; 03802948
	add r0,sp,#0x0	; 0380294A
	bl loc_038028B0	; 0380294C
	add r0,sp,#0x0	; 03802950
	ldrh r0,[r0,#0x0]	; 03802952
	lsl r0,r0,#0x19	; 03802954
	lsr r0,r0,#0x1f	; 03802956
	cmp r0,#0x0	; 03802958
	beq loc_0380296C	; 0380295A
	mov r0,#0x86	; 0380295C
	mov r1,#0x50	; 0380295E
	add r2,r4,#0x0	; 03802960
	mov r3,#0x3	; 03802962
	bl loc_03802610	; 03802964
	mov r0,#0x1	; 03802968
	b loc_0380296E	; 0380296A
loc_0380296C:
	mov r0,#0x0	; 0380296C
loc_0380296E:
	add sp,#0x8	; 0380296E
	pop {r4}	; 03802970
	pop {r3}	; 03802972
	bx r3	; 03802974
	.byte 0x00, 0x00	; 03802978

; ===== function loc_03802978 =====
loc_03802978:
	push {r4,lr}	; 03802978
	sub sp,#0x8	; 0380297A
	add r4,r0,#0x0	; 0380297C
	add r0,sp,#0x0	; 0380297E
	bl loc_038028B0	; 03802980
	add r0,sp,#0x0	; 03802984
	ldrh r0,[r0,#0x0]	; 03802986
	lsl r0,r0,#0x1c	; 03802988
	lsr r0,r0,#0x1c	; 0380298A
	cmp r0,#0x4	; 0380298C
	bne loc_038029A0	; 0380298E
	mov r0,#0x6	; 03802990
	mov r1,#0x10	; 03802992
	add r2,r4,#0x0	; 03802994
	mov r3,#0x3	; 03802996
	bl loc_03802610	; 03802998
	mov r0,#0x1	; 0380299C
	b loc_038029A2	; 0380299E
loc_038029A0:
	mov r0,#0x0	; 038029A0
loc_038029A2:
	add sp,#0x8	; 038029A2
	pop {r4}	; 038029A4
	pop {r3}	; 038029A6
	bx r3	; 038029A8
	.byte 0x00, 0x00	; 038029AC

; ===== function loc_038029AC =====
loc_038029AC:
	push {r4,lr}	; 038029AC
	sub sp,#0x8	; 038029AE
	add r4,r0,#0x0	; 038029B0
	add r0,sp,#0x0	; 038029B2
	bl loc_038028B0	; 038029B4
	add r0,sp,#0x0	; 038029B8
	ldrh r0,[r0,#0x0]	; 038029BA
	lsl r0,r0,#0x1c	; 038029BC
	lsr r0,r0,#0x1c	; 038029BE
	cmp r0,#0x4	; 038029C0
	bne loc_038029D4	; 038029C2
	mov r0,#0x86	; 038029C4
	mov r1,#0x10	; 038029C6
	add r2,r4,#0x0	; 038029C8
	mov r3,#0x3	; 038029CA
	bl loc_03802610	; 038029CC
	mov r0,#0x1	; 038029D0
	b loc_038029D6	; 038029D2
loc_038029D4:
	mov r0,#0x0	; 038029D4
loc_038029D6:
	add sp,#0x8	; 038029D6
	pop {r4}	; 038029D8
	pop {r3}	; 038029DA
	bx r3	; 038029DC
	.byte 0x00, 0x00	; 038029E0

; ===== function loc_038029E0 =====
loc_038029E0:
	push {r4,lr}	; 038029E0
	add r4,r0,#0x0	; 038029E2
	ldr r0,[pool_038029FC]	; 038029E4
	bl loc_03802144	; 038029E6
	mov r0,#0x6	; 038029EA
	mov r1,#0x20	; 038029EC
	add r2,r4,#0x0	; 038029EE
	mov r3,#0x7	; 038029F0
	bl loc_03802610	; 038029F2
	pop {r4}	; 038029F6
	pop {r3}	; 038029F8
	bx r3	; 038029FA
pool_038029FC:
loc_038029FC:
	.word 0x00008000	; 038029FC

; ===== function loc_03802A00 =====
loc_03802A00:
	push {r4,lr}	; 03802A00
	add r4,r0,#0x0	; 03802A02
	ldr r0,[pool_03802A1C]	; 03802A04
	bl loc_03802144	; 03802A06
	mov r0,#0x86	; 03802A0A
	mov r1,#0x20	; 03802A0C
	add r2,r4,#0x0	; 03802A0E
	mov r3,#0x7	; 03802A10
	bl loc_03802610	; 03802A12
	pop {r4}	; 03802A16
	pop {r3}	; 03802A18
	bx r3	; 03802A1A
pool_03802A1C:
loc_03802A1C:
	.word 0x00008000	; 03802A1C

; ===== function loc_03802A20 =====
loc_03802A20:
	push {r4,r5,lr}	; 03802A20
	sub sp,#0xc	; 03802A22
	add r5,r0,#0x0	; 03802A24
	mov r0,#0x1	; 03802A26
	add r4,r5,#0x0	; 03802A28
	and r4,r0	; 03802A2A
	lsl r0,r4,#0x10	; 03802A2C
	lsr r0,r0,#0x10	; 03802A2E
	cmp r0,#0x1	; 03802A30
	bne loc_03802AC0	; 03802A32
	add r0,sp,#0x0	; 03802A34
	bl loc_038028F0	; 03802A36
	add r0,sp,#0x0	; 03802A3A
	ldrh r1,[r0,#0x0]	; 03802A3C
	lsl r2,r1,#0x1e	; 03802A3E
	lsr r3,r2,#0x1f	; 03802A40
	lsl r2,r4,#0x10	; 03802A42
	lsr r2,r2,#0x10	; 03802A44
	cmp r3,r2	; 03802A46
	beq loc_03802AC0	; 03802A48
	mov r3,#0x1	; 03802A4A
	and r5,r3	; 03802A4C
	mov r2,#0x2	; 03802A4E
	bic r1,r2	; 03802A50
	lsl r2,r5,#0x10	; 03802A52
	lsr r2,r2,#0x10	; 03802A54
	and r2,r3	; 03802A56
	lsl r2,r2,#0x1	; 03802A58
	orr r1,r2	; 03802A5A
	strh r1,[r0,#0x0]	; 03802A5C
	add r0,sp,#0x0	; 03802A5E
	bl loc_038028D0	; 03802A60
	mov r0,#0x86	; 03802A64
	mov r1,#0x10	; 03802A66
	add r2,sp,#0x4	; 03802A68
	mov r3,#0x3	; 03802A6A
	bl loc_03802610	; 03802A6C
	lsl r0,r5,#0x10	; 03802A70
	lsr r0,r0,#0x10	; 03802A72
	cmp r0,#0x0	; 03802A74
	bne loc_03802A80	; 03802A76
	add r0,sp,#0x4	; 03802A78
	bl loc_03802748	; 03802A7A
	b loc_03802A86	; 03802A7E
loc_03802A80:
	add r0,sp,#0x4	; 03802A80
	bl loc_0380268C	; 03802A82
loc_03802A86:
	mov r0,#0x6	; 03802A86
	mov r1,#0x10	; 03802A88
	add r2,sp,#0x4	; 03802A8A
	mov r3,#0x3	; 03802A8C
	bl loc_03802610	; 03802A8E
	mov r0,#0x86	; 03802A92
	mov r1,#0x50	; 03802A94
	add r2,sp,#0x4	; 03802A96
	mov r3,#0x3	; 03802A98
	bl loc_03802610	; 03802A9A
	lsl r0,r4,#0x10	; 03802A9E
	lsr r0,r0,#0x10	; 03802AA0
	cmp r0,#0x0	; 03802AA2
	bne loc_03802AAE	; 03802AA4
	add r0,sp,#0x4	; 03802AA6
	bl loc_03802748	; 03802AA8
	b loc_03802AB4	; 03802AAC
loc_03802AAE:
	add r0,sp,#0x4	; 03802AAE
	bl loc_0380268C	; 03802AB0
loc_03802AB4:
	mov r0,#0x6	; 03802AB4
	mov r1,#0x50	; 03802AB6
	add r2,sp,#0x4	; 03802AB8
	mov r3,#0x3	; 03802ABA
	bl loc_03802610	; 03802ABC
loc_03802AC0:
	add sp,#0xc	; 03802AC0
	pop {r4,r5}	; 03802AC2
	pop {r3}	; 03802AC4
	bx r3	; 03802AC6

; ===== function loc_03802AC8 =====
loc_03802AC8:
	push {lr}	; 03802AC8
	sub sp,#0x4	; 03802ACA
	ldr r0,[pool_03802AF0]	; 03802ACC
	bl loc_03802144	; 03802ACE
	add r0,sp,#0x0	; 03802AD2
	ldrh r1,[r0,#0x0]	; 03802AD4
	mov r3,#0x1	; 03802AD6
	bic r1,r3	; 03802AD8
	orr r1,r3	; 03802ADA
	strh r1,[r0,#0x0]	; 03802ADC
	mov r0,#0x6	; 03802ADE
	mov r1,#0x0	; 03802AE0
	add r2,sp,#0x0	; 03802AE2
	bl loc_03802610	; 03802AE4
	add sp,#0x4	; 03802AE8
	pop {r3}	; 03802AEA
	bx r3	; 03802AEC
	.byte 0xC0, 0x46	; 03802AF0
pool_03802AF0:
loc_03802AF0:
	.word 0x00008000	; 03802AF0
.arm

; ===== function loc_03802AF4 =====
loc_03802AF4:
	mov r12,#0x4000000	; 03802AF4
	add r12,r12,#0x138	; 03802AF8
	ldrh r0,[r12,#0x0]	; 03802AFC
	bic r0,r0,#0x77	; 03802B00
	orr r0,r0,#0x72	; 03802B04
	strh r0,[r12,#0x0]	; 03802B08
	mov r3,#0x2	; 03802B0C
loc_03802B10:
	subs r3,r3,#0x1	; 03802B10
	bne loc_03802B10	; 03802B14
	bic r0,r0,#0x4	; 03802B18
	orr r0,r0,#0x4	; 03802B1C
	strh r0,[r12,#0x0]	; 03802B20
	mov r3,#0x2	; 03802B24
loc_03802B28:
	subs r3,r3,#0x1	; 03802B28
	bne loc_03802B28	; 03802B2C
	bx lr	; 03802B30

; ===== function loc_03802B34 =====
loc_03802B34:
	mov r12,#0x4000000	; 03802B34
	add r12,r12,#0x138	; 03802B38
	mov r3,#0x2	; 03802B3C
loc_03802B40:
	subs r3,r3,#0x1	; 03802B40
	bne loc_03802B40	; 03802B44
	ldrh r0,[r12,#0x0]	; 03802B48
	bic r0,r0,#0x4	; 03802B4C
	orr r0,r0,#0x0	; 03802B50
	strh r0,[r12,#0x0]	; 03802B54
	mov r3,#0x2	; 03802B58
loc_03802B5C:
	subs r3,r3,#0x1	; 03802B5C
	bne loc_03802B5C	; 03802B60
	bx lr	; 03802B64

; ===== function loc_03802B68 =====
loc_03802B68:
	mov r12,#0x4000000	; 03802B68
	add r12,r12,#0x138	; 03802B6C
	orr r1,r0,r1	; 03802B70
	ldrh r0,[r12,#0x0]	; 03802B74
	bic r0,r0,#0x77	; 03802B78
	orr r0,r0,#0x74	; 03802B7C
	mov r2,#0x0	; 03802B80
loc_03802B84:
	bic r0,r0,#0x3	; 03802B84
	orr r0,r0,#0x0	; 03802B88
	mov r3,#0x1	; 03802B8C
	tst r3,r1, lsr r2	; 03802B90
	movne r3,#0x1	; 03802B94
	moveq r3,#0x0	; 03802B98
	orr r0,r0,r3	; 03802B9C
	strh r0,[r12,#0x0]	; 03802BA0
	mov r3,#0x9	; 03802BA4
loc_03802BA8:
	subs r3,r3,#0x1	; 03802BA8
	bne loc_03802BA8	; 03802BAC
	bic r0,r0,#0x2	; 03802BB0
	orr r0,r0,#0x2	; 03802BB4
	strh r0,[r12,#0x0]	; 03802BB8
	mov r3,#0x9	; 03802BBC
loc_03802BC0:
	subs r3,r3,#0x1	; 03802BC0
	bne loc_03802BC0	; 03802BC4
	add r2,r2,#0x1	; 03802BC8
	cmp r2,#0x8	; 03802BCC
	bne loc_03802B84	; 03802BD0
	bx lr	; 03802BD4

; ===== function loc_03802BD8 =====
loc_03802BD8:
	mov r12,#0x4000000	; 03802BD8
	add r12,r12,#0x138	; 03802BDC
loc_03802BE0:
	stmdb sp!,{r0,r1}	; 03802BE0
	tst r0,#0x1	; 03802BE4
	ldreqh r1,[r0,#0x0]	; 03802BE8
	ldrneh r1,[r0,#-0x1]	; 03802BEC
	movne r1,r1, lsr #0x8	; 03802BF0
	ldrh r0,[r12,#0x0]	; 03802BF4
	bic r0,r0,#0x77	; 03802BF8
	orr r0,r0,#0x74	; 03802BFC
	mov r2,#0x0	; 03802C00
loc_03802C04:
	bic r0,r0,#0x3	; 03802C04
	orr r0,r0,#0x0	; 03802C08
	mov r3,#0x1	; 03802C0C
	tst r3,r1, lsr r2	; 03802C10
	movne r3,#0x1	; 03802C14
	moveq r3,#0x0	; 03802C18
	orr r0,r0,r3	; 03802C1C
	strh r0,[r12,#0x0]	; 03802C20
	mov r3,#0x9	; 03802C24
loc_03802C28:
	subs r3,r3,#0x1	; 03802C28
	bne loc_03802C28	; 03802C2C
	bic r0,r0,#0x2	; 03802C30
	orr r0,r0,#0x2	; 03802C34
	strh r0,[r12,#0x0]	; 03802C38
	mov r3,#0x9	; 03802C3C
loc_03802C40:
	subs r3,r3,#0x1	; 03802C40
	bne loc_03802C40	; 03802C44
	add r2,r2,#0x1	; 03802C48
	cmp r2,#0x8	; 03802C4C
	bne loc_03802C04	; 03802C50
	ldmia sp!,{r0,r1}	; 03802C54
	add r0,r0,#0x1	; 03802C58
	subs r1,r1,#0x1	; 03802C5C
	bne loc_03802BE0	; 03802C60
	bx lr	; 03802C64

; ===== function loc_03802C68 =====
loc_03802C68:
	mov r12,#0x4000000	; 03802C68
	add r12,r12,#0x138	; 03802C6C
loc_03802C70:
	stmdb sp!,{r0,r1}	; 03802C70
	ldrh r0,[r12,#0x0]	; 03802C74
	bic r0,r0,#0x77	; 03802C78
	orr r0,r0,#0x64	; 03802C7C
	mov r2,#0x0	; 03802C80
	mov r1,#0x0	; 03802C84
loc_03802C88:
	bic r0,r0,#0x3	; 03802C88
	orr r0,r0,#0x0	; 03802C8C
	strh r0,[r12,#0x0]	; 03802C90
	mov r3,#0x9	; 03802C94
loc_03802C98:
	subs r3,r3,#0x1	; 03802C98
	bne loc_03802C98	; 03802C9C
	ldrh r0,[r12,#0x0]	; 03802CA0
	and r3,r0,#0x1	; 03802CA4
	cmp r3,#0x1	; 03802CA8
	moveq r3,#0x80	; 03802CAC
	movne r3,#0x0	; 03802CB0
	orr r2,r3,r2, lsr #0x1	; 03802CB4
	bic r0,r0,#0x2	; 03802CB8
	orr r0,r0,#0x2	; 03802CBC
	strh r0,[r12,#0x0]	; 03802CC0
	mov r3,#0x9	; 03802CC4
loc_03802CC8:
	subs r3,r3,#0x1	; 03802CC8
	bne loc_03802CC8	; 03802CCC
	add r1,r1,#0x1	; 03802CD0
	cmp r1,#0x8	; 03802CD4
	bne loc_03802C88	; 03802CD8
	ldmia sp!,{r0,r1}	; 03802CDC
	tst r0,#0x1	; 03802CE0
	beq loc_03802D00	; 03802CE4
	ldrh r3,[r0,#-0x1]	; 03802CE8
	bic r3,r3,#0xff00	; 03802CEC
	mov r2,r2, lsl #0x8	; 03802CF0
	orr r3,r2,r3	; 03802CF4
	strh r3,[r0,#-0x1]	; 03802CF8
	b loc_03802D10	; 03802CFC
loc_03802D00:
	ldrh r3,[r0,#0x0]	; 03802D00
	bic r3,r3,#0xff	; 03802D04
	orr r3,r3,r2	; 03802D08
	strh r3,[r0,#0x0]	; 03802D0C
loc_03802D10:
	add r0,r0,#0x1	; 03802D10
	subs r1,r1,#0x1	; 03802D14
	bne loc_03802C70	; 03802D18
	bx lr	; 03802D1C
.thumb

; ===== function loc_03802D20 =====
	push {lr}	; 03802D20
	sub sp,#0x4	; 03802D22
	cmp r2,#0x0	; 03802D24
	bne loc_03802D4C	; 03802D26
	cmp r0,#0x4	; 03802D28
	beq loc_03802D46	; 03802D2A
	cmp r0,#0x6	; 03802D2C
	beq loc_03802D36	; 03802D2E
	cmp r0,#0x8	; 03802D30
	beq loc_03802D3E	; 03802D32
	b loc_03802D4C	; 03802D34
loc_03802D36:
	add r0,r1,#0x0	; 03802D36
	bl loc_03803248	; 03802D38
	b loc_03802D4C	; 03802D3C
loc_03802D3E:
	add r0,r1,#0x0	; 03802D3E
	bl loc_03804264	; 03802D40
	b loc_03802D4C	; 03802D44
loc_03802D46:
	add r0,r1,#0x0	; 03802D46
	bl loc_03803AEC	; 03802D48
loc_03802D4C:
	add sp,#0x4	; 03802D4C
	pop {r3}	; 03802D4E
	bx r3	; 03802D50
	.byte 0x00, 0x00, 0x70, 0xB5, 0x82, 0xB0, 0x0C, 0x4D, 0x00, 0xAC, 0x01, 0x26, 0x28, 0x1C, 0x21, 0x1C	; 03802D62
	.byte 0x32, 0x1C, 0xFB, 0xF7, 0x90, 0xFA, 0x00, 0x98, 0x01, 0x68, 0x00, 0x29, 0x04, 0xD0, 0x01, 0x29	; 03802D72
	.byte 0x08, 0xD0, 0x03, 0x29, 0x03, 0xD0, 0xF1, 0xE7, 0x00, 0xF0, 0xAF, 0xF9, 0xEE, 0xE7, 0x01, 0xF0	; 03802D82
	.byte 0xF2, 0xF9, 0xEB, 0xE7, 0x00, 0xF0, 0x07, 0xFE, 0xE8, 0xE7, 0x58, 0x77, 0x80, 0x03	; 03802D90

; ===== function loc_03802D90 =====
loc_03802D90:
	push {r0,r1,r2,r3}	; 03802D90
	push {r4,r5,r6,r7,lr}	; 03802D92
	sub sp,#0x4	; 03802D94
	add r5,r0,#0x0	; 03802D96
	add r4,r1,#0x0	; 03802D98
	add r0,sp,#0x18	; 03802D9A
	ldrh r0,[r0,#0x8]	; 03802D9C
	cmp r0,#0x4	; 03802D9E
	bls loc_03802DA6	; 03802DA0
	mov r0,#0x0	; 03802DA2
	b loc_03802E16	; 03802DA4
loc_03802DA6:
	bl loc_037FDCE0	; 03802DA6
	add r7,r0,#0x0	; 03802DAA
	ldr r0,[pool_03802E20]	; 03802DAC
	ldr r1,[r0,#0x54]	; 03802DAE
	mov r0,#0x18	; 03802DB0
	mul r1,r0	; 03802DB2
	ldr r0,[pool_03802E24]	; 03802DB4
	str r5,[r0,r1]	; 03802DB6
	ldr r0,[pool_03802E20]	; 03802DB8
	ldr r1,[r0,#0x54]	; 03802DBA
	mov r0,#0x18	; 03802DBC
	mul r1,r0	; 03802DBE
	ldr r0,[pool_03802E28]	; 03802DC0
	str r4,[r0,r1]	; 03802DC2
	add r1,sp,#0x20	; 03802DC4
	mov r0,#0x3	; 03802DC6
	bic r1,r0	; 03802DC8
	add r6,r1,#0x4	; 03802DCA
	mov r5,#0x0	; 03802DCC
	add r0,sp,#0x18	; 03802DCE
	ldrh r4,[r0,#0x8]	; 03802DD0
	b loc_03802DF0	; 03802DD2
loc_03802DD4:
	add r6,r6,#0x4	; 03802DD4
	sub r0,r6,#0x4	; 03802DD6
	ldr r3,[r0,#0x0]	; 03802DD8
	ldr r0,[pool_03802E20]	; 03802DDA
	ldr r2,[r0,#0x54]	; 03802DDC
	mov r0,#0x18	; 03802DDE
	mul r2,r0	; 03802DE0
	lsl r1,r5,#0x2	; 03802DE2
	ldr r0,[pool_03802E2C]	; 03802DE4
	add r0,r0,r2	; 03802DE6
	add r1,r1,r0	; 03802DE8
	ldr r0,[pool_03802E30]	; 03802DEA
	str r3,[r1,r0]	; 03802DEC
	add r5,r5,#0x1	; 03802DEE
loc_03802DF0:
	cmp r5,r4	; 03802DF0
	blt loc_03802DD4	; 03802DF2
	ldr r1,[pool_03802E20]	; 03802DF4
	ldr r4,[r1,#0x54]	; 03802DF6
	add r2,r4,#0x1	; 03802DF8
	mov r0,#0xf	; 03802DFA
	and r2,r0	; 03802DFC
	str r2,[r1,#0x54]	; 03802DFE
	add r0,r7,#0x0	; 03802E00
	bl loc_037FDD04	; 03802E02
	ldr r0,[pool_03802E34]	; 03802E06
	ldr r2,[pool_03802E24]	; 03802E08
	mov r1,#0x18	; 03802E0A
	mul r4,r1	; 03802E0C
	add r1,r2,r4	; 03802E0E
	mov r2,#0x0	; 03802E10
	bl loc_037FE300	; 03802E12
loc_03802E16:
	add sp,#0x4	; 03802E16
	pop {r4,r5,r6,r7}	; 03802E18
	pop {r3}	; 03802E1A
	add sp,#0x10	; 03802E1C
	bx r3	; 03802E1E
pool_03802E20:
loc_03802E20:
	.word 0x038078D8	; 03802E20
pool_03802E24:
loc_03802E24:
	.word 0x038077AC	; 03802E24
pool_03802E28:
loc_03802E28:
	.word 0x038077B0	; 03802E28
pool_03802E2C:
loc_03802E2C:
	.word 0x038074D8	; 03802E2C
pool_03802E30:
loc_03802E30:
	.word 0x000002DC	; 03802E30
pool_03802E34:
loc_03802E34:
	.word 0x03807758	; 03802E34

; ===== function loc_03802E38 =====
	push {lr}	; 03802E38
	sub sp,#0x4	; 03802E3A
	ldr r1,[pool_03802E58]	; 03802E3C
	ldr r2,[r1,#0x4]	; 03802E3E
	cmp r2,r0	; 03802E40
	bne loc_03802E52	; 03802E42
	mov r0,#0x5	; 03802E44
	str r0,[r1,#0x4]	; 03802E46
	mov r0,#0x0	; 03802E48
	str r0,[r1,#0x0]	; 03802E4A
	ldr r0,[pool_03802E5C]	; 03802E4C
	bl loc_037FDF04	; 03802E4E
loc_03802E52:
	add sp,#0x4	; 03802E52
	pop {r3}	; 03802E54
	bx r3	; 03802E56
pool_03802E58:
loc_03802E58:
	.word 0x038074D8	; 03802E58
pool_03802E5C:
loc_03802E5C:
	.word 0x03807930	; 03802E5C

; ===== function loc_03802E60 =====
loc_03802E60:
	mov r2,#0x1	; 03802E60
	ldr r1,[pool_03802E6C]	; 03802E62
	str r2,[r1,#0x0]	; 03802E64
	str r0,[r1,#0x4]	; 03802E66
	bx lr	; 03802E68
	.byte 0xC0, 0x46	; 03802E6C
pool_03802E6C:
loc_03802E6C:
	.word 0x038074D8	; 03802E6C
	.byte 0x03, 0x48, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD1, 0x01, 0x20, 0x70, 0x47, 0x00, 0x20, 0x70, 0x47	; 03802E80
	.byte 0xD8, 0x74, 0x80, 0x03	; 03802E84

; ===== function loc_03802E84 =====
loc_03802E84:
	push {r4,r5,r6,lr}	; 03802E84
	mov r2,#0x70	; 03802E86
	add r3,r0,#0x0	; 03802E88
	and r3,r2	; 03802E8A
	cmp r3,#0x20	; 03802E8C
	bgt loc_03802EA4	; 03802E8E
	cmp r3,#0x20	; 03802E90
	bge loc_03802EC0	; 03802E92
	cmp r3,#0x0	; 03802E94
	bgt loc_03802E9E	; 03802E96
	cmp r3,#0x0	; 03802E98
	beq loc_03802EB8	; 03802E9A
	b loc_03802EC2	; 03802E9C
loc_03802E9E:
	cmp r3,#0x10	; 03802E9E
	beq loc_03802EB8	; 03802EA0
	b loc_03802EC2	; 03802EA2
loc_03802EA4:
	cmp r3,#0x60	; 03802EA4
	bgt loc_03802EB2	; 03802EA6
	cmp r3,#0x60	; 03802EA8
	bge loc_03802EBC	; 03802EAA
	cmp r3,#0x30	; 03802EAC
	beq loc_03802EC0	; 03802EAE
	b loc_03802EC2	; 03802EB0
loc_03802EB2:
	cmp r3,#0x70	; 03802EB2
	beq loc_03802EBC	; 03802EB4
	b loc_03802EC2	; 03802EB6
loc_03802EB8:
	mov r5,#0x6	; 03802EB8
	b loc_03802EC2	; 03802EBA
loc_03802EBC:
	mov r5,#0x8	; 03802EBC
	b loc_03802EC2	; 03802EBE
loc_03802EC0:
	mov r5,#0x4	; 03802EC0
loc_03802EC2:
	mov r3,#0xff	; 03802EC2
	and r0,r3	; 03802EC4
	mov r2,#0x80	; 03802EC6
	orr r0,r2	; 03802EC8
	lsl r4,r0,#0x8	; 03802ECA
	ldr r0,[pool_03802EEC]	; 03802ECC
	orr r4,r0	; 03802ECE
	and r1,r3	; 03802ED0
	orr r4,r1	; 03802ED2
	mov r6,#0x0	; 03802ED4
loc_03802ED6:
	add r0,r5,#0x0	; 03802ED6
	add r1,r4,#0x0	; 03802ED8
	add r2,r6,#0x0	; 03802EDA
	bl loc_03801F30	; 03802EDC
	cmp r0,#0x0	; 03802EE0
	blt loc_03802ED6	; 03802EE2
	pop {r4,r5,r6}	; 03802EE4
	pop {r3}	; 03802EE6
	bx r3	; 03802EE8
	.byte 0xC0, 0x46	; 03802EEC
pool_03802EEC:
loc_03802EEC:
	.word 0x03000000	; 03802EEC

; ===== function loc_03802EF0 =====
loc_03802EF0:
	push {lr}	; 03802EF0
	sub sp,#0x4	; 03802EF2
	ldr r1,[pool_03802F2C]	; 03802EF4
	ldr r2,[r1,#0x0]	; 03802EF6
	cmp r2,#0x0	; 03802EF8
	beq loc_03802F26	; 03802EFA
	ldr r1,[r1,#0x4]	; 03802EFC
	cmp r1,#0x4	; 03802EFE
	bne loc_03802F26	; 03802F00
	ldr r1,[pool_03802F30]	; 03802F02
	ldr r1,[r1,#0x5c]	; 03802F04
	cmp r1,r0	; 03802F06
	bne loc_03802F26	; 03802F08
	bl loc_037FDCE0	; 03802F0A
	mov r2,#0x5	; 03802F0E
	ldr r1,[pool_03802F2C]	; 03802F10
	str r2,[r1,#0x4]	; 03802F12
	mov r2,#0x0	; 03802F14
	str r2,[r1,#0x0]	; 03802F16
	ldr r1,[pool_03802F30]	; 03802F18
	str r2,[r1,#0x5c]	; 03802F1A
	bl loc_037FDD04	; 03802F1C
	ldr r0,[pool_03802F34]	; 03802F20
	bl loc_037FDF04	; 03802F22
loc_03802F26:
	add sp,#0x4	; 03802F26
	pop {r3}	; 03802F28
	bx r3	; 03802F2A
pool_03802F2C:
loc_03802F2C:
	.word 0x038074D8	; 03802F2C
pool_03802F30:
loc_03802F30:
	.word 0x038078D8	; 03802F30
pool_03802F34:
loc_03802F34:
	.word 0x03807930	; 03802F34

; ===== function loc_03802F38 =====
loc_03802F38:
	push {r4,r5,r6,r7,lr}	; 03802F38
	sub sp,#0x4	; 03802F3A
	add r5,r0,#0x0	; 03802F3C
	ldr r7,[pool_03802F74]	; 03802F3E
	ldr r6,[pool_03802F78]	; 03802F40
loc_03802F42:
	bl loc_037FDCE0	; 03802F42
	add r4,r0,#0x0	; 03802F46
	ldr r1,[r6,#0x0]	; 03802F48
	cmp r1,#0x0	; 03802F4A
	beq loc_03802F5A	; 03802F4C
	bl loc_037FDD04	; 03802F4E
	add r0,r7,#0x0	; 03802F52
	bl loc_037FDF4C	; 03802F54
	b loc_03802F42	; 03802F58
loc_03802F5A:
	mov r0,#0x4	; 03802F5A
	bl loc_03802E60	; 03802F5C
	ldr r0,[pool_03802F7C]	; 03802F60
	str r5,[r0,#0x5c]	; 03802F62
	add r0,r4,#0x0	; 03802F64
	bl loc_037FDD04	; 03802F66
	add sp,#0x4	; 03802F6A
	pop {r4,r5,r6,r7}	; 03802F6C
	pop {r3}	; 03802F6E
	bx r3	; 03802F70
	.byte 0xC0, 0x46	; 03802F74
pool_03802F74:
loc_03802F74:
	.word 0x03807930	; 03802F74
pool_03802F78:
loc_03802F78:
	.word 0x038074D8	; 03802F78
pool_03802F7C:
loc_03802F7C:
	.word 0x038078D8	; 03802F7C

; ===== function loc_03802F80 =====
loc_03802F80:
	push {r4,r5,r6,r7,lr}	; 03802F80
	sub sp,#0xc	; 03802F82
	add r5,r0,#0x0	; 03802F84
	ldr r0,[pool_03803014]	; 03802F86
	ldrh r1,[r0,#0x0]	; 03802F88
	cmp r1,#0x0	; 03802F8A
	bne loc_0380300A	; 03802F8C
	mov r1,#0x1	; 03802F8E
	strh r1,[r0,#0x0]	; 03802F90
	mov r1,#0x0	; 03802F92
	ldr r0,[pool_03803018]	; 03802F94
	str r1,[r0,#0x0]	; 03802F96
	mov r1,#0x5	; 03802F98
	str r1,[r0,#0x4]	; 03802F9A
	bl loc_03803380	; 03802F9C
	bl loc_03803C24	; 03802FA0
	bl loc_038043AC	; 03802FA4
	bl loc_03801E50	; 03802FA8
	mov r0,#0x6	; 03802FAC
	ldr r1,[pool_0380301C]	; 03802FAE
	bl loc_03801FB8	; 03802FB0
	mov r0,#0x8	; 03802FB4
	ldr r1,[pool_0380301C]	; 03802FB6
	bl loc_03801FB8	; 03802FB8
	mov r0,#0x4	; 03802FBC
	ldr r1,[pool_0380301C]	; 03802FBE
	bl loc_03801FB8	; 03802FC0
	ldr r0,[pool_03803020]	; 03802FC4
	ldr r1,[pool_03803024]	; 03802FC6
	mov r2,#0x10	; 03802FC8
	bl loc_037FE35C	; 03802FCA
	mov r4,#0x0	; 03802FCE
	ldr r7,[pool_03803028]	; 03802FD0
	add r6,r4,#0x0	; 03802FD2
loc_03802FD4:
	add r1,r4,#0x0	; 03802FD4
	mov r0,#0x18	; 03802FD6
	mul r1,r0	; 03802FD8
	add r0,r7,r1	; 03802FDA
	add r1,r6,#0x0	; 03802FDC
	mov r2,#0x18	; 03802FDE
	bl loc_03803040	; 03802FE0
	add r4,r4,#0x1	; 03802FE4
	cmp r4,#0x10	; 03802FE6
	blt loc_03802FD4	; 03802FE8
	mov r2,#0x0	; 03802FEA
	ldr r0,[pool_0380302C]	; 03802FEC
	str r2,[r0,#0x54]	; 03802FEE
	ldr r0,[pool_03803030]	; 03802FF0
	strh r2,[r0,#0x18]	; 03802FF2
	ldr r0,[pool_03803034]	; 03802FF4
	str r0,[sp,#0x0]	; 03802FF6
	str r5,[sp,#0x4]	; 03802FF8
	ldr r0,[pool_03803038]	; 03802FFA
	ldr r1,[pool_0380303C]	; 03802FFC
	ldr r3,[pool_03803020]	; 03802FFE
	bl loc_037FDFCC	; 03803000
	ldr r0,[pool_03803038]	; 03803004
	bl loc_037FDEE0	; 03803006
loc_0380300A:
	add sp,#0xc	; 0380300A
	pop {r4,r5,r6,r7}	; 0380300C
	pop {r3}	; 0380300E
	bx r3	; 03803010
	.byte 0xC0, 0x46	; 03803014
pool_03803014:
loc_03803014:
	.word 0x038074D4	; 03803014
pool_03803018:
loc_03803018:
	.word 0x038074D8	; 03803018
pool_0380301C:
loc_0380301C:
	.word 0x03802D21	; 0380301C
pool_03803020:
loc_03803020:
	.word 0x03807758	; 03803020
pool_03803024:
loc_03803024:
	.word 0x0380776C	; 03803024
pool_03803028:
loc_03803028:
	.word 0x038077AC	; 03803028
pool_0380302C:
loc_0380302C:
	.word 0x038078D8	; 0380302C
pool_03803030:
loc_03803030:
	.word 0x03807918	; 03803030
pool_03803034:
loc_03803034:
	.word 0x00000200	; 03803034
pool_03803038:
loc_03803038:
	.word 0x038074E0	; 03803038
pool_0380303C:
loc_0380303C:
	.word 0x03802D55	; 0380303C

; ===== function loc_03803040 =====
loc_03803040:
	bx pc	; 03803040
	.byte 0xC0, 0x46	; 03803044
.arm

; ===== function loc_03803044 =====
loc_03803044:
	ldr pc,[pool_03803048]	; 03803044
pool_03803048:
loc_03803048:
	.word 0x037FF3C8	; 03803048
.thumb

; ===== function loc_0380304C =====
loc_0380304C:
	push {lr}	; 0380304C
	sub sp,#0x4	; 0380304E
	cmp r0,#0x0	; 03803050
	bne loc_0380305E	; 03803052
	mov r0,#0x3	; 03803054
	mov r1,#0x2	; 03803056
	bl loc_03802E84	; 03803058
	b loc_0380307A	; 0380305C
loc_0380305E:
	cmp r1,#0x0	; 0380305E
	bne loc_0380306C	; 03803060
	mov r0,#0x3	; 03803062
	mov r1,#0x2	; 03803064
	bl loc_03802E84	; 03803066
	b loc_0380307A	; 0380306A
loc_0380306C:
	ldr r2,[pool_03803080]	; 0380306C
	str r0,[r2,#0x24]	; 0380306E
	str r1,[r2,#0x28]	; 03803070
	mov r0,#0x3	; 03803072
	mov r1,#0x0	; 03803074
	bl loc_03802E84	; 03803076
loc_0380307A:
	add sp,#0x4	; 0380307A
	pop {r3}	; 0380307C
	bx r3	; 0380307E
pool_03803080:
loc_03803080:
	.word 0x03807938	; 03803080

; ===== function loc_03803084 =====
	push {r4,lr}	; 03803084
	sub sp,#0x8	; 03803086
	add r4,r0,#0x0	; 03803088
	mov r0,#0x0	; 0380308A
	mov r1,#0x10	; 0380308C
	mov r2,#0x1	; 0380308E
	add r3,r4,#0x0	; 03803090
	bl loc_03802D90	; 03803092
	cmp r0,#0x0	; 03803096
	bne loc_038030C2	; 03803098
	ldr r1,[sp,#0x0]	; 0380309A
	ldr r0,[pool_038030CC]	; 0380309C
	and r1,r0	; 0380309E
	ldr r0,[pool_038030D0]	; 038030A0
	orr r1,r0	; 038030A2
	str r1,[sp,#0x0]	; 038030A4
	add r0,sp,#0x0	; 038030A6
	ldrh r2,[r0,#0x0]	; 038030A8
	ldr r1,[pool_038030D4]	; 038030AA
	strh r2,[r1,#0x0]	; 038030AC
	ldrh r1,[r0,#0x2]	; 038030AE
	ldr r0,[pool_038030D8]	; 038030B0
	strh r1,[r0,#0x0]	; 038030B2
	mov r0,#0x10	; 038030B4
	mov r1,#0xff	; 038030B6
	and r4,r1	; 038030B8
	lsl r1,r4,#0x10	; 038030BA
	lsr r1,r1,#0x10	; 038030BC
	bl loc_03802E84	; 038030BE
loc_038030C2:
	add sp,#0x8	; 038030C2
	pop {r4}	; 038030C4
	pop {r3}	; 038030C6
	bx r3	; 038030C8
	.byte 0xC0, 0x46	; 038030CC
pool_038030CC:
loc_038030CC:
	.word 0xF9FFFFFF	; 038030CC
pool_038030D0:
loc_038030D0:
	.word 0x06000000	; 038030D0
pool_038030D4:
loc_038030D4:
	.word 0x027FFFAA	; 038030D4
pool_038030D8:
loc_038030D8:
	.word 0x027FFFAC	; 038030D8
	.byte 0xF0, 0xB5, 0x83, 0xB0, 0x05, 0x1C, 0x69, 0x68, 0x02, 0x29, 0x06, 0xD8, 0x00, 0x29, 0x0C, 0xD0	; 038030EC
	.byte 0x01, 0x29, 0x45, 0xD0, 0x02, 0x29, 0x7A, 0xD0, 0x8F, 0xE0, 0x10, 0x29, 0x00, 0xD0, 0x8C, 0xE0	; 038030FC
	.byte 0x48, 0x48, 0x00, 0x6A, 0x02, 0x28, 0x00, 0xD0, 0x87, 0xE0, 0xFA, 0xF7, 0xEB, 0xFD, 0x04, 0x1C	; 0380310C
	.byte 0x00, 0x20, 0xFF, 0xF7, 0xAF, 0xFE, 0x00, 0x28, 0x09, 0xD1, 0x20, 0x1C, 0xFA, 0xF7, 0xF4, 0xFD	; 0380311C
	.byte 0x68, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x21, 0xFF, 0xF7, 0xAE, 0xFE, 0x75, 0xE0, 0x00, 0x20	; 0380312C
	.byte 0xFF, 0xF7, 0x98, 0xFE, 0x20, 0x1C, 0xFA, 0xF7, 0xE7, 0xFD, 0x01, 0xA8, 0x39, 0x4A, 0x91, 0x6A	; 0380313C
	.byte 0x52, 0x6A, 0x00, 0xF0, 0x8F, 0xF9, 0x01, 0xA8, 0x02, 0x88, 0x37, 0x49, 0x0A, 0x80, 0x41, 0x88	; 0380314C
	.byte 0x36, 0x48, 0x01, 0x80, 0x68, 0x68, 0x00, 0x28, 0x05, 0xD1, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x21	; 0380315C
	.byte 0xFF, 0xF7, 0x92, 0xFE, 0x08, 0xE0, 0x00, 0x04, 0x00, 0x0C, 0xAA, 0x68, 0xFF, 0x21, 0x0A, 0x40	; 0380316C
	.byte 0x11, 0x04, 0x09, 0x0C, 0xFF, 0xF7, 0x88, 0xFE, 0x00, 0x20, 0xFF, 0xF7, 0x5F, 0xFE, 0x4C, 0xE0	; 0380317C
	.byte 0x28, 0x48, 0x00, 0x6A, 0x01, 0x28, 0x2C, 0xD1, 0x00, 0x24, 0x27, 0x1C, 0x1C, 0xE0, 0x62, 0x00	; 0380318C
	.byte 0x24, 0x48, 0x86, 0x18, 0x20, 0x1C, 0x26, 0x4A, 0x50, 0x43, 0x00, 0xF0, 0x51, 0xF8, 0xE9, 0x68	; 0380319C
	.byte 0x08, 0x18, 0x23, 0x49, 0x00, 0xF0, 0x4C, 0xF8, 0x30, 0x1C, 0xCC, 0x30, 0x01, 0x80, 0x00, 0x94	; 038031AC
	.byte 0x21, 0x1C, 0x28, 0x20, 0x41, 0x43, 0x1F, 0x48, 0x40, 0x18, 0xCC, 0x21, 0x71, 0x5E, 0x3A, 0x1C	; 038031BC
	.byte 0x1D, 0x4B, 0xFB, 0xF7, 0xBD, 0xFE, 0x64, 0x1C, 0xA9, 0x68, 0x8C, 0x42, 0xDF, 0xD3, 0x68, 0x68	; 038031CC
	.byte 0x00, 0x04, 0x00, 0x0C, 0x00, 0x21, 0xFF, 0xF7, 0x57, 0xFE, 0x02, 0x21, 0x11, 0x48, 0x01, 0x62	; 038031DC
	.byte 0x1B, 0xE0, 0x08, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x4E, 0xFE, 0x15, 0xE0, 0x0D, 0x48	; 038031EC
	.byte 0x00, 0x6A, 0x03, 0x28, 0x0C, 0xD1, 0x11, 0x48, 0xFB, 0xF7, 0x28, 0xFE, 0x68, 0x68, 0x00, 0x04	; 038031FC
	.byte 0x00, 0x0C, 0x00, 0x21, 0xFF, 0xF7, 0x40, 0xFE, 0x00, 0x21, 0x06, 0x48, 0x01, 0x62, 0x04, 0xE0	; 0380320C
	.byte 0x08, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x37, 0xFE, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 0380321C
	.byte 0x18, 0x47, 0xC0, 0x46, 0x38, 0x79, 0x80, 0x03, 0xAA, 0xFF, 0x7F, 0x02, 0xAC, 0xFF, 0x7F, 0x02	; 0380322C
	.byte 0x07, 0x01, 0x00, 0x00, 0x64, 0x79, 0x80, 0x03, 0x85, 0x30, 0x80, 0x03, 0x41, 0x56, 0x50, 0x54	; 0380323C

; ===== function loc_0380323C =====
loc_0380323C:
	bx pc	; 0380323C
	.byte 0xC0, 0x46	; 03803240
.arm

; ===== function loc_03803240 =====
loc_03803240:
	ldr pc,[pool_03803244]	; 03803240
pool_03803244:
loc_03803244:
	.word 0x03804DB0	; 03803244
.thumb

; ===== function loc_03803248 =====
loc_03803248:
	push {r4,lr}	; 03803248
	sub sp,#0x8	; 0380324A
	ldr r1,[pool_03803368]	; 0380324C
	add r2,r0,#0x0	; 0380324E
	and r2,r1	; 03803250
	cmp r2,#0x0	; 03803252
	beq loc_03803266	; 03803254
	mov r4,#0x0	; 03803256
	add r3,r4,#0x0	; 03803258
	ldr r1,[pool_0380336C]	; 0380325A
loc_0380325C:
	lsl r2,r4,#0x1	; 0380325C
	strh r3,[r1,r2]	; 0380325E
	add r4,r4,#0x1	; 03803260
	cmp r4,#0x10	; 03803262
	blt loc_0380325C	; 03803264
loc_03803266:
	ldr r1,[pool_03803370]	; 03803266
	add r2,r0,#0x0	; 03803268
	and r2,r1	; 0380326A
	lsr r1,r2,#0x10	; 0380326C
	lsl r2,r1,#0x1	; 0380326E
	ldr r1,[pool_0380336C]	; 03803270
	strh r0,[r1,r2]	; 03803272
	ldr r2,[pool_03803374]	; 03803274
	and r0,r2	; 03803276
	cmp r0,#0x0	; 03803278
	beq loc_03803360	; 0380327A
	ldrh r0,[r1,#0x0]	; 0380327C
	ldr r2,[pool_03803378]	; 0380327E
	add r3,r0,#0x0	; 03803280
	and r3,r2	; 03803282
	lsl r2,r3,#0x8	; 03803284
	lsr r4,r2,#0x10	; 03803286
	cmp r4,#0x3	; 03803288
	bhi loc_03803358	; 0380328A
	add r2,r4,r4	; 0380328C
	add r2,pc	; 0380328E
	ldrh r2,[r2,#0x8]	; 03803290
	lsl r2,r2,#0x10	; 03803292
	asr r2,r2,#0x10	; 03803294
	add r2,pc	; 03803296
	bx r2	; 03803298
	.byte 0x19, 0x00, 0x31, 0x00, 0x8F, 0x00, 0x09, 0x00	; 038032A2
loc_038032A2:
	mov r2,#0xff	; 038032A2
	and r0,r2	; 038032A4
	lsl r0,r0,#0x10	; 038032A6
	lsr r0,r0,#0x10	; 038032A8
	ldrh r1,[r1,#0x2]	; 038032AA
	bl loc_0380304C	; 038032AC
	b loc_03803360	; 038032B0
loc_038032B2:
	mov r0,#0x0	; 038032B2
	add r1,r4,#0x0	; 038032B4
	add r2,r0,#0x0	; 038032B6
	bl loc_03802D90	; 038032B8
	cmp r0,#0x0	; 038032BC
	bne loc_03803360	; 038032BE
	add r0,r4,#0x0	; 038032C0
	mov r1,#0x4	; 038032C2
	bl loc_03802E84	; 038032C4
	b loc_03803360	; 038032C8
loc_038032CA:
	ldr r2,[r1,#0x20]	; 038032CA
	cmp r2,#0x0	; 038032CC
	beq loc_038032DA	; 038032CE
	add r0,r4,#0x0	; 038032D0
	mov r1,#0x3	; 038032D2
	bl loc_03802E84	; 038032D4
	b loc_03803360	; 038032D8
loc_038032DA:
	mov r2,#0xff	; 038032DA
	and r0,r2	; 038032DC
	lsl r0,r0,#0x10	; 038032DE
	lsr r3,r0,#0x10	; 038032E0
	cmp r3,#0x0	; 038032E2
	beq loc_038032EA	; 038032E4
	cmp r3,#0x4	; 038032E6
	bls loc_038032F4	; 038032E8
loc_038032EA:
	add r0,r4,#0x0	; 038032EA
	mov r1,#0x2	; 038032EC
	bl loc_03802E84	; 038032EE
	b loc_03803360	; 038032F2
loc_038032F4:
	ldrh r1,[r1,#0x2]	; 038032F4
	ldr r0,[pool_0380337C]	; 038032F6
	cmp r1,r0	; 038032F8
	bcc loc_03803306	; 038032FA
	add r0,r4,#0x0	; 038032FC
	mov r1,#0x2	; 038032FE
	bl loc_03802E84	; 03803300
	b loc_03803360	; 03803304
loc_03803306:
	str r1,[sp,#0x0]	; 03803306
	mov r0,#0x0	; 03803308
	add r1,r4,#0x0	; 0380330A
	mov r2,#0x2	; 0380330C
	bl loc_03802D90	; 0380330E
	cmp r0,#0x0	; 03803312
	bne loc_03803320	; 03803314
	add r0,r4,#0x0	; 03803316
	mov r1,#0x4	; 03803318
	bl loc_03802E84	; 0380331A
	b loc_03803360	; 0380331E
loc_03803320:
	mov r1,#0x1	; 03803320
	ldr r0,[pool_0380336C]	; 03803322
	str r1,[r0,#0x20]	; 03803324
	b loc_03803360	; 03803326
loc_03803328:
	ldr r0,[r1,#0x20]	; 03803328
	cmp r0,#0x2	; 0380332A
	beq loc_03803338	; 0380332C
	add r0,r4,#0x0	; 0380332E
	mov r1,#0x3	; 03803330
	bl loc_03802E84	; 03803332
	b loc_03803360	; 03803336
loc_03803338:
	mov r0,#0x0	; 03803338
	add r1,r4,#0x0	; 0380333A
	add r2,r0,#0x0	; 0380333C
	bl loc_03802D90	; 0380333E
	cmp r0,#0x0	; 03803342
	bne loc_03803350	; 03803344
	add r0,r4,#0x0	; 03803346
	mov r1,#0x4	; 03803348
	bl loc_03802E84	; 0380334A
	b loc_03803360	; 0380334E
loc_03803350:
	mov r1,#0x3	; 03803350
	ldr r0,[pool_0380336C]	; 03803352
	str r1,[r0,#0x20]	; 03803354
	b loc_03803360	; 03803356
loc_03803358:
	add r0,r4,#0x0	; 03803358
	mov r1,#0x1	; 0380335A
	bl loc_03802E84	; 0380335C
loc_03803360:
	add sp,#0x8	; 03803360
	pop {r4}	; 03803362
	pop {r3}	; 03803364
	bx r3	; 03803366
pool_03803368:
loc_03803368:
	.word 0x02000000	; 03803368
pool_0380336C:
loc_0380336C:
	.word 0x03807938	; 0380336C
pool_03803370:
loc_03803370:
	.word 0x000F0000	; 03803370
pool_03803374:
loc_03803374:
	.word 0x01000000	; 03803374
pool_03803378:
loc_03803378:
	.word 0x0000FF00	; 03803378
pool_0380337C:
loc_0380337C:
	.word 0x00000107	; 0380337C

; ===== function loc_03803380 =====
loc_03803380:
	push {r4,r5,r6,r7,lr}	; 03803380
	sub sp,#0x4	; 03803382
	mov r3,#0x0	; 03803384
	ldr r0,[pool_03803444]	; 03803386
	str r3,[r0,#0x20]	; 03803388
	mov r1,#0x1e	; 0380338A
	str r1,[r0,#0x28]	; 0380338C
	mov r1,#0x5	; 0380338E
	str r1,[r0,#0x24]	; 03803390
	add r2,r3,#0x0	; 03803392
loc_03803394:
	lsl r1,r3,#0x1	; 03803394
	strh r2,[r0,r1]	; 03803396
	add r3,r3,#0x1	; 03803398
	cmp r3,#0x10	; 0380339A
	blt loc_03803394	; 0380339C
	bl loc_037FF0A4	; 0380339E
	cmp r0,#0x0	; 038033A2
	bne loc_038033AA	; 038033A4
	bl loc_037FF0B0	; 038033A6
loc_038033AA:
	mov r4,#0x0	; 038033AA
	ldr r6,[pool_03803448]	; 038033AC
	mov r7,#0x28	; 038033AE
loc_038033B0:
	add r0,r4,#0x0	; 038033B0
	mul r0,r7	; 038033B2
	add r5,r6,r0	; 038033B4
	add r0,r5,#0x0	; 038033B6
	bl loc_037FEFFC	; 038033B8
	add r0,r5,#0x0	; 038033BC
	ldr r1,[pool_0380344C]	; 038033BE
	bl loc_037FEED0	; 038033C0
	add r4,r4,#0x1	; 038033C4
	cmp r4,#0x4	; 038033C6
	blt loc_038033B0	; 038033C8
	mov r6,#0x1	; 038033CA
	ldr r5,[pool_03803450]	; 038033CC
	mov r4,#0x80	; 038033CE
	b loc_038033D8	; 038033D0
loc_038033D2:
	add r0,r6,#0x0	; 038033D2
	bl loc_038048D4	; 038033D4
loc_038033D8:
	ldrh r0,[r5,#0x0]	; 038033D8
	and r0,r4	; 038033DA
	cmp r0,#0x0	; 038033DC
	bne loc_038033D2	; 038033DE
	ldr r0,[pool_03803454]	; 038033E0
	strh r0,[r5,#0x0]	; 038033E2
	mov r1,#0x84	; 038033E4
	ldr r0,[pool_03803458]	; 038033E6
	strh r1,[r0,#0x0]	; 038033E8
	mov r6,#0x1	; 038033EA
	ldr r5,[pool_03803450]	; 038033EC
	mov r4,#0x80	; 038033EE
	b loc_038033F8	; 038033F0
loc_038033F2:
	add r0,r6,#0x0	; 038033F2
	bl loc_038048D4	; 038033F4
loc_038033F8:
	ldrh r0,[r5,#0x0]	; 038033F8
	and r0,r4	; 038033FA
	cmp r0,#0x0	; 038033FC
	bne loc_038033F2	; 038033FE
	mov r1,#0x0	; 03803400
	ldr r0,[pool_03803458]	; 03803402
	strh r1,[r0,#0x0]	; 03803404
	mov r6,#0x1	; 03803406
	ldr r5,[pool_03803450]	; 03803408
	mov r4,#0x80	; 0380340A
	b loc_03803414	; 0380340C
loc_0380340E:
	add r0,r6,#0x0	; 0380340E
	bl loc_038048D4	; 03803410
loc_03803414:
	ldrh r0,[r5,#0x0]	; 03803414
	and r0,r4	; 03803416
	cmp r0,#0x0	; 03803418
	bne loc_0380340E	; 0380341A
	ldr r0,[pool_0380345C]	; 0380341C
	strh r0,[r5,#0x0]	; 0380341E
	mov r1,#0x0	; 03803420
	ldr r0,[pool_03803458]	; 03803422
	strh r1,[r0,#0x0]	; 03803424
	mov r6,#0x1	; 03803426
	ldr r5,[pool_03803450]	; 03803428
	mov r4,#0x80	; 0380342A
	b loc_03803434	; 0380342C
loc_0380342E:
	add r0,r6,#0x0	; 0380342E
	bl loc_038048D4	; 03803430
loc_03803434:
	ldrh r0,[r5,#0x0]	; 03803434
	and r0,r4	; 03803436
	cmp r0,#0x0	; 03803438
	bne loc_0380342E	; 0380343A
	add sp,#0x4	; 0380343C
	pop {r4,r5,r6,r7}	; 0380343E
	pop {r3}	; 03803440
	bx r3	; 03803442
pool_03803444:
loc_03803444:
	.word 0x03807938	; 03803444
pool_03803448:
loc_03803448:
	.word 0x03807964	; 03803448
pool_0380344C:
loc_0380344C:
	.word 0x54505641	; 0380344C
pool_03803450:
loc_03803450:
	.word 0x040001C0	; 03803450
pool_03803454:
loc_03803454:
	.word 0x00008A01	; 03803454
pool_03803458:
loc_03803458:
	.word 0x040001C2	; 03803458
pool_0380345C:
loc_0380345C:
	.word 0x00008201	; 0380345C

; ===== function loc_03803460 =====
	push {r4,r5,r6,r7,lr}	; 03803460
	sub sp,#0x4	; 03803462
	add r5,r0,#0x0	; 03803464
	add r4,r1,#0x0	; 03803466
	add r6,r2,#0x0	; 03803468
	cmp r4,#0x0	; 0380346A
	bge loc_03803470	; 0380346C
	neg r4,r4	; 0380346E
loc_03803470:
	bl loc_03803814	; 03803470
	add r7,r0,#0x0	; 03803474
	cmp r7,#0x0	; 03803476
	bne loc_038034A6	; 03803478
	ldr r1,[r5,#0x0]	; 0380347A
	ldr r0,[pool_038035C8]	; 0380347C
	and r1,r0	; 0380347E
	str r1,[r5,#0x0]	; 03803480
	ldr r1,[r5,#0x0]	; 03803482
	ldr r0,[pool_038035CC]	; 03803484
	and r1,r0	; 03803486
	str r1,[r5,#0x0]	; 03803488
	ldr r1,[r5,#0x0]	; 0380348A
	ldr r0,[pool_038035D0]	; 0380348C
	and r1,r0	; 0380348E
	str r1,[r5,#0x0]	; 03803490
	ldr r1,[r5,#0x0]	; 03803492
	ldr r0,[pool_038035D4]	; 03803494
	and r1,r0	; 03803496
	ldr r0,[pool_038035D8]	; 03803498
	orr r1,r0	; 0380349A
	str r1,[r5,#0x0]	; 0380349C
	mov r1,#0x0	; 0380349E
	ldr r0,[pool_038035DC]	; 038034A0
	strh r1,[r0,#0x0]	; 038034A2
	b loc_038035C0	; 038034A4
loc_038034A6:
	add r0,sp,#0x0	; 038034A6
	add r1,r4,#0x0	; 038034A8
	add r2,r6,#0x0	; 038034AA
	mov r3,#0x0	; 038034AC
	bl loc_038035FC	; 038034AE
	ldr r1,[r5,#0x0]	; 038034B2
	ldr r2,[pool_038035D4]	; 038034B4
	and r1,r2	; 038034B6
	mov r2,#0x3	; 038034B8
	and r0,r2	; 038034BA
	lsl r0,r0,#0x19	; 038034BC
	orr r1,r0	; 038034BE
	str r1,[r5,#0x0]	; 038034C0
	ldr r0,[r5,#0x0]	; 038034C2
	ldr r1,[pool_038035C8]	; 038034C4
	and r0,r1	; 038034C6
	add r1,sp,#0x0	; 038034C8
	ldrh r2,[r1,#0x0]	; 038034CA
	ldr r1,[pool_038035E0]	; 038034CC
	and r2,r1	; 038034CE
	orr r0,r2	; 038034D0
	str r0,[r5,#0x0]	; 038034D2
	add r0,sp,#0x0	; 038034D4
	add r1,r4,#0x0	; 038034D6
	add r2,r6,#0x0	; 038034D8
	mov r3,#0x1	; 038034DA
	bl loc_038035FC	; 038034DC
	cmp r0,#0x2	; 038034E0
	bne loc_03803504	; 038034E2
	ldr r1,[r5,#0x0]	; 038034E4
	lsl r0,r1,#0x5	; 038034E6
	lsr r0,r0,#0x1e	; 038034E8
	cmp r0,#0x1	; 038034EA
	bne loc_038034FA	; 038034EC
	ldr r0,[pool_038035D4]	; 038034EE
	and r1,r0	; 038034F0
	ldr r0,[pool_038035D8]	; 038034F2
	orr r1,r0	; 038034F4
	str r1,[r5,#0x0]	; 038034F6
	b loc_03803504	; 038034F8
loc_038034FA:
	ldr r0,[pool_038035D4]	; 038034FA
	and r1,r0	; 038034FC
	ldr r0,[pool_038035E4]	; 038034FE
	orr r1,r0	; 03803500
	str r1,[r5,#0x0]	; 03803502
loc_03803504:
	ldr r0,[r5,#0x0]	; 03803504
	ldr r1,[pool_038035CC]	; 03803506
	and r0,r1	; 03803508
	add r1,sp,#0x0	; 0380350A
	ldrh r2,[r1,#0x0]	; 0380350C
	ldr r1,[pool_038035E0]	; 0380350E
	and r2,r1	; 03803510
	lsl r1,r2,#0xc	; 03803512
	orr r0,r1	; 03803514
	str r0,[r5,#0x0]	; 03803516
	ldr r1,[pool_038035E8]	; 03803518
	ldr r0,[pool_038035EC]	; 0380351A
	strh r1,[r0,#0x0]	; 0380351C
	mov r4,#0x0	; 0380351E
	add r6,r4,#0x0	; 03803520
loc_03803522:
	ldr r0,[pool_038035F0]	; 03803522
	strh r6,[r0,#0x0]	; 03803524
	b loc_0380352E	; 03803526
loc_03803528:
	mov r0,#0x1	; 03803528
	bl loc_038048D4	; 0380352A
loc_0380352E:
	ldr r0,[pool_038035EC]	; 0380352E
	ldrh r1,[r0,#0x0]	; 03803530
	mov r0,#0x80	; 03803532
	and r1,r0	; 03803534
	cmp r1,#0x0	; 03803536
	bne loc_03803528	; 03803538
	add r4,r4,#0x1	; 0380353A
	cmp r4,#0xc	; 0380353C
	blt loc_03803522	; 0380353E
	ldr r1,[pool_038035F4]	; 03803540
	ldr r0,[pool_038035EC]	; 03803542
	strh r1,[r0,#0x0]	; 03803544
	mov r1,#0x0	; 03803546
	ldr r0,[pool_038035F0]	; 03803548
	strh r1,[r0,#0x0]	; 0380354A
	ldr r4,[pool_038035EC]	; 0380354C
	mov r6,#0x80	; 0380354E
	b loc_03803558	; 03803550
loc_03803552:
	mov r0,#0x1	; 03803552
	bl loc_038048D4	; 03803554
loc_03803558:
	ldrh r0,[r4,#0x0]	; 03803558
	and r0,r6	; 0380355A
	cmp r0,#0x0	; 0380355C
	bne loc_03803552	; 0380355E
	cmp r7,#0x2	; 03803560
	bne loc_03803570	; 03803562
	ldr r1,[r5,#0x0]	; 03803564
	ldr r0,[pool_038035D4]	; 03803566
	and r1,r0	; 03803568
	ldr r0,[pool_038035D8]	; 0380356A
	orr r1,r0	; 0380356C
	str r1,[r5,#0x0]	; 0380356E
loc_03803570:
	bl loc_03803814	; 03803570
	cmp r0,#0x0	; 03803574
	beq loc_038035AC	; 03803576
	cmp r0,#0x1	; 03803578
	beq loc_0380359C	; 0380357A
	cmp r0,#0x2	; 0380357C
	bne loc_038035BC	; 0380357E
	ldr r1,[r5,#0x0]	; 03803580
	ldr r0,[pool_038035F8]	; 03803582
	orr r1,r0	; 03803584
	str r1,[r5,#0x0]	; 03803586
	ldr r1,[r5,#0x0]	; 03803588
	ldr r0,[pool_038035D4]	; 0380358A
	and r1,r0	; 0380358C
	ldr r0,[pool_038035D8]	; 0380358E
	orr r1,r0	; 03803590
	str r1,[r5,#0x0]	; 03803592
	mov r1,#0x0	; 03803594
	ldr r0,[pool_038035DC]	; 03803596
	strh r1,[r0,#0x0]	; 03803598
	b loc_038035C0	; 0380359A
loc_0380359C:
	ldr r1,[r5,#0x0]	; 0380359C
	ldr r0,[pool_038035F8]	; 0380359E
	orr r1,r0	; 038035A0
	str r1,[r5,#0x0]	; 038035A2
	mov r1,#0x1	; 038035A4
	ldr r0,[pool_038035DC]	; 038035A6
	strh r1,[r0,#0x0]	; 038035A8
	b loc_038035C0	; 038035AA
loc_038035AC:
	ldr r1,[r5,#0x0]	; 038035AC
	ldr r0,[pool_038035D0]	; 038035AE
	and r1,r0	; 038035B0
	str r1,[r5,#0x0]	; 038035B2
	mov r1,#0x0	; 038035B4
	ldr r0,[pool_038035DC]	; 038035B6
	strh r1,[r0,#0x0]	; 038035B8
	b loc_038035C0	; 038035BA
loc_038035BC:
	bl loc_037FF1D4	; 038035BC
loc_038035C0:
	add sp,#0x4	; 038035C0
	pop {r4,r5,r6,r7}	; 038035C2
	pop {r3}	; 038035C4
	bx r3	; 038035C6
pool_038035C8:
loc_038035C8:
	.word 0xFFFFF000	; 038035C8
pool_038035CC:
loc_038035CC:
	.word 0xFF000FFF	; 038035CC
pool_038035D0:
loc_038035D0:
	.word 0xFEFFFFFF	; 038035D0
pool_038035D4:
loc_038035D4:
	.word 0xF9FFFFFF	; 038035D4
pool_038035D8:
loc_038035D8:
	.word 0x06000000	; 038035D8
pool_038035DC:
loc_038035DC:
	.word 0x03807A0C	; 038035DC
pool_038035E0:
loc_038035E0:
	.word 0x00000FFF	; 038035E0
pool_038035E4:
loc_038035E4:
	.word 0x04000000	; 038035E4
pool_038035E8:
loc_038035E8:
	.word 0x00008A01	; 038035E8
pool_038035EC:
loc_038035EC:
	.word 0x040001C0	; 038035EC
pool_038035F0:
loc_038035F0:
	.word 0x040001C2	; 038035F0
pool_038035F4:
loc_038035F4:
	.word 0x00008201	; 038035F4
pool_038035F8:
loc_038035F8:
	.word 0x01000000	; 038035F8

; ===== function loc_038035FC =====
loc_038035FC:
	push {r4,r5,r6,r7,lr}	; 038035FC
	sub sp,#0x24	; 038035FE
	add r6,r0,#0x0	; 03803600
	str r1,[sp,#0x0]	; 03803602
	str r2,[sp,#0x4]	; 03803604
	cmp r3,#0x0	; 03803606
	bne loc_03803610	; 03803608
	mov r4,#0xd1	; 0380360A
	mov r7,#0x1	; 0380360C
	b loc_0380361C	; 0380360E
loc_03803610:
	mov r4,#0x91	; 03803610
	mov r7,#0x2	; 03803612
	b loc_0380361C	; 03803614
loc_03803616:
	mov r0,#0x1	; 03803616
	bl loc_038048D4	; 03803618
loc_0380361C:
	ldr r5,[pool_03803800]	; 0380361C
	ldrh r1,[r5,#0x0]	; 0380361E
	mov r0,#0x80	; 03803620
	and r1,r0	; 03803622
	cmp r1,#0x0	; 03803624
	bne loc_03803616	; 03803626
	ldr r0,[pool_03803804]	; 03803628
	strh r0,[r5,#0x0]	; 0380362A
	mov r0,#0xff	; 0380362C
	and r4,r0	; 0380362E
	ldr r0,[pool_03803808]	; 03803630
	strh r4,[r0,#0x0]	; 03803632
	b loc_0380363C	; 03803634
loc_03803636:
	mov r0,#0x1	; 03803636
	bl loc_038048D4	; 03803638
loc_0380363C:
	ldrh r1,[r5,#0x0]	; 0380363C
	mov r0,#0x80	; 0380363E
	and r1,r0	; 03803640
	cmp r1,#0x0	; 03803642
	bne loc_03803636	; 03803644
	mov r1,#0x0	; 03803646
	ldr r0,[pool_03803808]	; 03803648
	strh r1,[r0,#0x0]	; 0380364A
	ldr r5,[pool_03803800]	; 0380364C
	b loc_03803656	; 0380364E
loc_03803650:
	mov r0,#0x1	; 03803650
	bl loc_038048D4	; 03803652
loc_03803656:
	ldrh r1,[r5,#0x0]	; 03803656
	mov r0,#0x80	; 03803658
	and r1,r0	; 0380365A
	cmp r1,#0x0	; 0380365C
	bne loc_03803650	; 0380365E
	ldr r1,[pool_03803808]	; 03803660
	ldrh r2,[r1,#0x0]	; 03803662
	mov r0,#0xff	; 03803664
	and r2,r0	; 03803666
	lsl r0,r2,#0x10	; 03803668
	lsr r0,r0,#0x8	; 0380366A
	str r0,[sp,#0x18]	; 0380366C
	strh r4,[r1,#0x0]	; 0380366E
	ldr r5,[pool_03803800]	; 03803670
	b loc_0380367A	; 03803672
loc_03803674:
	mov r0,#0x1	; 03803674
	bl loc_038048D4	; 03803676
loc_0380367A:
	ldrh r1,[r5,#0x0]	; 0380367A
	mov r0,#0x80	; 0380367C
	and r1,r0	; 0380367E
	cmp r1,#0x0	; 03803680
	bne loc_03803674	; 03803682
	ldr r0,[pool_03803808]	; 03803684
	ldrh r2,[r0,#0x0]	; 03803686
	mov r1,#0xff	; 03803688
	and r2,r1	; 0380368A
	lsl r1,r2,#0x10	; 0380368C
	lsr r1,r1,#0x10	; 0380368E
	ldr r2,[sp,#0x18]	; 03803690
	orr r2,r1	; 03803692
	str r2,[sp,#0x18]	; 03803694
	ldr r1,[pool_0380380C]	; 03803696
	and r2,r1	; 03803698
	asr r1,r2,#0x3	; 0380369A
	str r1,[sp,#0x18]	; 0380369C
	mov r1,#0x0	; 0380369E
	strh r1,[r0,#0x0]	; 038036A0
	ldr r5,[pool_03803800]	; 038036A2
	b loc_038036AC	; 038036A4
loc_038036A6:
	mov r0,#0x1	; 038036A6
	bl loc_038048D4	; 038036A8
loc_038036AC:
	ldrh r1,[r5,#0x0]	; 038036AC
	mov r0,#0x80	; 038036AE
	and r1,r0	; 038036B0
	cmp r1,#0x0	; 038036B2
	bne loc_038036A6	; 038036B4
	ldr r1,[pool_03803808]	; 038036B6
	ldrh r2,[r1,#0x0]	; 038036B8
	mov r0,#0xff	; 038036BA
	and r2,r0	; 038036BC
	lsl r0,r2,#0x10	; 038036BE
	lsr r0,r0,#0x8	; 038036C0
	str r0,[sp,#0x1c]	; 038036C2
	strh r4,[r1,#0x0]	; 038036C4
	ldr r5,[pool_03803800]	; 038036C6
	b loc_038036D0	; 038036C8
loc_038036CA:
	mov r0,#0x1	; 038036CA
	bl loc_038048D4	; 038036CC
loc_038036D0:
	ldrh r1,[r5,#0x0]	; 038036D0
	mov r0,#0x80	; 038036D2
	and r1,r0	; 038036D4
	cmp r1,#0x0	; 038036D6
	bne loc_038036CA	; 038036D8
	ldr r0,[pool_03803808]	; 038036DA
	ldrh r1,[r0,#0x0]	; 038036DC
	mov r0,#0xff	; 038036DE
	and r1,r0	; 038036E0
	lsl r0,r1,#0x10	; 038036E2
	lsr r0,r0,#0x10	; 038036E4
	ldr r1,[sp,#0x1c]	; 038036E6
	orr r1,r0	; 038036E8
	str r1,[sp,#0x1c]	; 038036EA
	ldr r0,[pool_0380380C]	; 038036EC
	and r1,r0	; 038036EE
	asr r1,r1,#0x3	; 038036F0
	str r1,[sp,#0x1c]	; 038036F2
	ldr r0,[sp,#0x4]	; 038036F4
	cmp r0,#0x0	; 038036F6
	bne loc_03803704	; 038036F8
	ldr r0,[sp,#0x18]	; 038036FA
	add r0,r0,r1	; 038036FC
	asr r0,r0,#0x1	; 038036FE
	strh r0,[r6,#0x0]	; 03803700
	mov r7,#0x0	; 03803702
loc_03803704:
	mov r5,#0x0	; 03803704
	ldr r0,[sp,#0x0]	; 03803706
	neg r0,r0	; 03803708
	str r0,[sp,#0xc]	; 0380370A
	str r5,[sp,#0x14]	; 0380370C
	b loc_038037BA	; 0380370E
loc_03803710:
	ldr r1,[sp,#0x14]	; 03803710
	ldr r0,[pool_03803808]	; 03803712
	strh r1,[r0,#0x0]	; 03803714
	b loc_0380371E	; 03803716
loc_03803718:
	mov r0,#0x1	; 03803718
	bl loc_038048D4	; 0380371A
loc_0380371E:
	ldr r0,[pool_03803800]	; 0380371E
	ldrh r1,[r0,#0x0]	; 03803720
	mov r0,#0x80	; 03803722
	and r1,r0	; 03803724
	cmp r1,#0x0	; 03803726
	bne loc_03803718	; 03803728
	ldr r0,[pool_03803808]	; 0380372A
	ldrh r1,[r0,#0x0]	; 0380372C
	mov r0,#0xff	; 0380372E
	and r1,r0	; 03803730
	lsl r0,r1,#0x10	; 03803732
	lsr r0,r0,#0x8	; 03803734
	str r0,[sp,#0x8]	; 03803736
	ldr r0,[pool_03803808]	; 03803738
	strh r4,[r0,#0x0]	; 0380373A
	b loc_03803744	; 0380373C
loc_0380373E:
	mov r0,#0x1	; 0380373E
	bl loc_038048D4	; 03803740
loc_03803744:
	ldr r0,[pool_03803800]	; 03803744
	ldrh r1,[r0,#0x0]	; 03803746
	mov r0,#0x80	; 03803748
	and r1,r0	; 0380374A
	cmp r1,#0x0	; 0380374C
	bne loc_0380373E	; 0380374E
	ldr r0,[pool_03803808]	; 03803750
	ldrh r1,[r0,#0x0]	; 03803752
	mov r0,#0xff	; 03803754
	and r1,r0	; 03803756
	lsl r0,r1,#0x10	; 03803758
	lsr r0,r0,#0x10	; 0380375A
	ldr r1,[sp,#0x8]	; 0380375C
	orr r1,r0	; 0380375E
	str r1,[sp,#0x8]	; 03803760
	ldr r0,[pool_0380380C]	; 03803762
	and r1,r0	; 03803764
	str r1,[sp,#0x8]	; 03803766
	asr r0,r1,#0x3	; 03803768
	str r0,[sp,#0x10]	; 0380376A
	ldr r1,[sp,#0x18]	; 0380376C
	sub r1,r1,r0	; 0380376E
	ldr r0,[sp,#0xc]	; 03803770
	cmp r1,r0	; 03803772
	blt loc_038037A8	; 03803774
	ldr r0,[sp,#0x0]	; 03803776
	cmp r1,r0	; 03803778
	bgt loc_038037A8	; 0380377A
	ldr r1,[sp,#0x1c]	; 0380377C
	ldr r0,[sp,#0x10]	; 0380377E
	sub r1,r1,r0	; 03803780
	ldr r0,[sp,#0xc]	; 03803782
	cmp r1,r0	; 03803784
	blt loc_038037A8	; 03803786
	ldr r0,[sp,#0x0]	; 03803788
	cmp r1,r0	; 0380378A
	bgt loc_038037A8	; 0380378C
	add r0,r5,#0x1	; 0380378E
	mov r1,#0x2	; 03803790
	bl loc_037FE2F4	; 03803792
	lsl r1,r1,#0x2	; 03803796
	add r0,sp,#0x18	; 03803798
	ldr r1,[r0,r1]	; 0380379A
	ldr r0,[sp,#0x10]	; 0380379C
	add r0,r0,r1	; 0380379E
	asr r0,r0,#0x1	; 038037A0
	strh r0,[r6,#0x0]	; 038037A2
	mov r7,#0x0	; 038037A4
	b loc_038037C0	; 038037A6
loc_038037A8:
	add r0,r5,#0x0	; 038037A8
	mov r1,#0x2	; 038037AA
	bl loc_037FE2F4	; 038037AC
	lsl r2,r1,#0x2	; 038037B0
	ldr r1,[sp,#0x10]	; 038037B2
	add r0,sp,#0x18	; 038037B4
	str r1,[r0,r2]	; 038037B6
	add r5,r5,#0x1	; 038037B8
loc_038037BA:
	ldr r0,[sp,#0x4]	; 038037BA
	cmp r5,r0	; 038037BC
	blt loc_03803710	; 038037BE
loc_038037C0:
	cmp r7,#0x0	; 038037C0
	beq loc_038037CE	; 038037C2
	ldr r1,[sp,#0x18]	; 038037C4
	ldr r0,[sp,#0x1c]	; 038037C6
	add r0,r1,r0	; 038037C8
	asr r0,r0,#0x1	; 038037CA
	strh r0,[r6,#0x0]	; 038037CC
loc_038037CE:
	ldr r0,[pool_03803810]	; 038037CE
	ldr r4,[pool_03803800]	; 038037D0
	strh r0,[r4,#0x0]	; 038037D2
	mov r1,#0x0	; 038037D4
	ldr r0,[pool_03803808]	; 038037D6
	strh r1,[r0,#0x0]	; 038037D8
	mov r5,#0x80	; 038037DA
	b loc_038037E4	; 038037DC
loc_038037DE:
	mov r0,#0x1	; 038037DE
	bl loc_038048D4	; 038037E0
loc_038037E4:
	ldrh r0,[r4,#0x0]	; 038037E4
	and r0,r5	; 038037E6
	cmp r0,#0x0	; 038037E8
	bne loc_038037DE	; 038037EA
	ldrh r1,[r6,#0x0]	; 038037EC
	mov r0,#0x7	; 038037EE
	bic r1,r0	; 038037F0
	strh r1,[r6,#0x0]	; 038037F2
	add r0,r7,#0x0	; 038037F4
	add sp,#0x24	; 038037F6
	pop {r4,r5,r6,r7}	; 038037F8
	pop {r3}	; 038037FA
	bx r3	; 038037FC
	.byte 0xC0, 0x46	; 03803800
pool_03803800:
loc_03803800:
	.word 0x040001C0	; 03803800
pool_03803804:
loc_03803804:
	.word 0x00008A01	; 03803804
pool_03803808:
loc_03803808:
	.word 0x040001C2	; 03803808
pool_0380380C:
loc_0380380C:
	.word 0x00007FF8	; 0380380C
pool_03803810:
loc_03803810:
	.word 0x00008201	; 03803810

; ===== function loc_03803814 =====
loc_03803814:
	push {r4,r5,r6,lr}	; 03803814
	ldr r0,[pool_03803930]	; 03803816
	bl loc_03802144	; 03803818
	mov r6,#0x1	; 0380381C
	ldr r5,[pool_03803934]	; 0380381E
	mov r4,#0x80	; 03803820
	b loc_0380382A	; 03803822
loc_03803824:
	add r0,r6,#0x0	; 03803824
	bl loc_038048D4	; 03803826
loc_0380382A:
	ldrh r0,[r5,#0x0]	; 0380382A
	and r0,r4	; 0380382C
	cmp r0,#0x0	; 0380382E
	bne loc_03803824	; 03803830
	ldr r0,[pool_03803938]	; 03803832
	strh r0,[r5,#0x0]	; 03803834
	mov r1,#0x84	; 03803836
	ldr r0,[pool_0380393C]	; 03803838
	strh r1,[r0,#0x0]	; 0380383A
	mov r6,#0x1	; 0380383C
	ldr r5,[pool_03803934]	; 0380383E
	mov r4,#0x80	; 03803840
	b loc_0380384A	; 03803842
loc_03803844:
	add r0,r6,#0x0	; 03803844
	bl loc_038048D4	; 03803846
loc_0380384A:
	ldrh r0,[r5,#0x0]	; 0380384A
	and r0,r4	; 0380384C
	cmp r0,#0x0	; 0380384E
	bne loc_03803844	; 03803850
	mov r1,#0x0	; 03803852
	ldr r0,[pool_0380393C]	; 03803854
	strh r1,[r0,#0x0]	; 03803856
	mov r6,#0x1	; 03803858
	ldr r5,[pool_03803934]	; 0380385A
	mov r4,#0x80	; 0380385C
	b loc_03803866	; 0380385E
loc_03803860:
	add r0,r6,#0x0	; 03803860
	bl loc_038048D4	; 03803862
loc_03803866:
	ldrh r0,[r5,#0x0]	; 03803866
	and r0,r4	; 03803868
	cmp r0,#0x0	; 0380386A
	bne loc_03803860	; 0380386C
	ldr r0,[pool_03803940]	; 0380386E
	strh r0,[r5,#0x0]	; 03803870
	mov r1,#0x0	; 03803872
	ldr r0,[pool_0380393C]	; 03803874
	strh r1,[r0,#0x0]	; 03803876
	mov r6,#0x1	; 03803878
	ldr r5,[pool_03803934]	; 0380387A
	mov r4,#0x80	; 0380387C
	b loc_03803886	; 0380387E
loc_03803880:
	add r0,r6,#0x0	; 03803880
	bl loc_038048D4	; 03803882
loc_03803886:
	ldrh r0,[r5,#0x0]	; 03803886
	and r0,r4	; 03803888
	cmp r0,#0x0	; 0380388A
	bne loc_03803880	; 0380388C
	ldr r0,[pool_03803944]	; 0380388E
	ldrh r0,[r0,#0x0]	; 03803890
	cmp r0,#0x0	; 03803892
	bne loc_038038AA	; 03803894
	ldr r0,[pool_03803948]	; 03803896
	ldrh r1,[r0,#0x0]	; 03803898
	mov r0,#0x40	; 0380389A
	and r1,r0	; 0380389C
	cmp r1,#0x0	; 0380389E
	bne loc_038038A6	; 038038A0
	mov r0,#0x1	; 038038A2
	b loc_03803928	; 038038A4
loc_038038A6:
	mov r0,#0x0	; 038038A6
	b loc_03803928	; 038038A8
loc_038038AA:
	ldr r0,[pool_03803948]	; 038038AA
	ldrh r1,[r0,#0x0]	; 038038AC
	mov r0,#0x40	; 038038AE
	and r1,r0	; 038038B0
	cmp r1,#0x0	; 038038B2
	bne loc_038038BA	; 038038B4
	mov r0,#0x1	; 038038B6
	b loc_03803928	; 038038B8
loc_038038BA:
	ldr r0,[pool_03803938]	; 038038BA
	strh r0,[r5,#0x0]	; 038038BC
	mov r1,#0x84	; 038038BE
	ldr r0,[pool_0380393C]	; 038038C0
	strh r1,[r0,#0x0]	; 038038C2
	mov r6,#0x1	; 038038C4
	ldr r5,[pool_03803934]	; 038038C6
	mov r4,#0x80	; 038038C8
	b loc_038038D2	; 038038CA
loc_038038CC:
	add r0,r6,#0x0	; 038038CC
	bl loc_038048D4	; 038038CE
loc_038038D2:
	ldrh r0,[r5,#0x0]	; 038038D2
	and r0,r4	; 038038D4
	cmp r0,#0x0	; 038038D6
	bne loc_038038CC	; 038038D8
	mov r1,#0x0	; 038038DA
	ldr r0,[pool_0380393C]	; 038038DC
	strh r1,[r0,#0x0]	; 038038DE
	mov r6,#0x1	; 038038E0
	ldr r5,[pool_03803934]	; 038038E2
	mov r4,#0x80	; 038038E4
	b loc_038038EE	; 038038E6
loc_038038E8:
	add r0,r6,#0x0	; 038038E8
	bl loc_038048D4	; 038038EA
loc_038038EE:
	ldrh r0,[r5,#0x0]	; 038038EE
	and r0,r4	; 038038F0
	cmp r0,#0x0	; 038038F2
	bne loc_038038E8	; 038038F4
	ldr r0,[pool_03803940]	; 038038F6
	strh r0,[r5,#0x0]	; 038038F8
	mov r1,#0x0	; 038038FA
	ldr r0,[pool_0380393C]	; 038038FC
	strh r1,[r0,#0x0]	; 038038FE
	mov r6,#0x1	; 03803900
	ldr r5,[pool_03803934]	; 03803902
	mov r4,#0x80	; 03803904
	b loc_0380390E	; 03803906
loc_03803908:
	add r0,r6,#0x0	; 03803908
	bl loc_038048D4	; 0380390A
loc_0380390E:
	ldrh r0,[r5,#0x0]	; 0380390E
	and r0,r4	; 03803910
	cmp r0,#0x0	; 03803912
	bne loc_03803908	; 03803914
	ldr r0,[pool_03803948]	; 03803916
	ldrh r1,[r0,#0x0]	; 03803918
	mov r0,#0x40	; 0380391A
	and r1,r0	; 0380391C
	cmp r1,#0x0	; 0380391E
	beq loc_03803926	; 03803920
	mov r0,#0x0	; 03803922
	b loc_03803928	; 03803924
loc_03803926:
	mov r0,#0x2	; 03803926
loc_03803928:
	pop {r4,r5,r6}	; 03803928
	pop {r3}	; 0380392A
	bx r3	; 0380392C
	.byte 0xC0, 0x46	; 03803930
pool_03803930:
loc_03803930:
	.word 0x00008000	; 03803930
pool_03803934:
loc_03803934:
	.word 0x040001C0	; 03803934
pool_03803938:
loc_03803938:
	.word 0x00008A01	; 03803938
pool_0380393C:
loc_0380393C:
	.word 0x040001C2	; 0380393C
pool_03803940:
loc_03803940:
	.word 0x00008201	; 03803940
pool_03803944:
loc_03803944:
	.word 0x03807A0C	; 03803944
pool_03803948:
loc_03803948:
	.word 0x04000136	; 03803948
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xA8, 0x00, 0xF0, 0x7D, 0xFB, 0x00, 0xA8, 0x02, 0x88, 0x01, 0x20	; 0380395C
	.byte 0x11, 0x1C, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x00, 0x20, 0x04, 0xE0, 0x02, 0x21, 0x0A, 0x40	; 0380396C
	.byte 0x00, 0x2A, 0x00, 0xD1, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xB5, 0x81, 0xB0	; 0380397C
	.byte 0x00, 0xA8, 0x00, 0xF0, 0x67, 0xFB, 0x00, 0xA8, 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 0380398C
	.byte 0x00, 0xD0, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0	; 0380399C
	.byte 0x04, 0x1C, 0xFA, 0xF7, 0x9F, 0xF9, 0x05, 0x1C, 0x01, 0x20, 0xFF, 0xF7, 0x63, 0xFA, 0x00, 0x28	; 038039AC
	.byte 0x09, 0xD1, 0x28, 0x1C, 0xFA, 0xF7, 0xA8, 0xF9, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x21	; 038039BC
	.byte 0xFF, 0xF7, 0x62, 0xFA, 0x8F, 0xE0, 0x01, 0x20, 0xFF, 0xF7, 0x4C, 0xFA, 0x28, 0x1C, 0xFA, 0xF7	; 038039CC
	.byte 0x9B, 0xF9, 0x60, 0x68, 0x20, 0x38, 0x0D, 0x28, 0x72, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89	; 038039DC
	.byte 0x00, 0x04, 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0x1D, 0x00, 0x23, 0x00, 0x29, 0x00, 0x31, 0x00	; 038039EC
	.byte 0xD9, 0x00, 0x59, 0x00, 0xD9, 0x00, 0x85, 0x00, 0xD9, 0x00, 0xD9, 0x00, 0xD9, 0x00, 0xA9, 0x00	; 038039FC
	.byte 0xCB, 0x00, 0xD3, 0x00, 0x00, 0xF0, 0x8C, 0xFB, 0x64, 0xE0, 0x00, 0xF0, 0x63, 0xFB, 0x61, 0xE0	; 03803A0C
	.byte 0x20, 0x69, 0x00, 0xF0, 0x1F, 0xFB, 0x5D, 0xE0, 0xFF, 0xF7, 0xB0, 0xFF, 0x00, 0x28, 0x09, 0xD1	; 03803A1C
	.byte 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x2E, 0xFA, 0x01, 0x20, 0xFF, 0xF7	; 03803A2C
	.byte 0x05, 0xFA, 0x58, 0xE0, 0xA0, 0x68, 0xE1, 0x68, 0x22, 0x69, 0x00, 0xF0, 0x8D, 0xFA, 0x49, 0xE0	; 03803A3C
	.byte 0xFF, 0xF7, 0x86, 0xFF, 0x00, 0x28, 0x09, 0xD1, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21	; 03803A4C
	.byte 0xFF, 0xF7, 0x1A, 0xFA, 0x01, 0x20, 0xFF, 0xF7, 0xF1, 0xF9, 0x44, 0xE0, 0xA0, 0x68, 0xE1, 0x68	; 03803A5C
	.byte 0x09, 0x04, 0x09, 0x0C, 0x22, 0x69, 0x00, 0xF0, 0xF1, 0xF9, 0x33, 0xE0, 0xFF, 0xF7, 0x70, 0xFF	; 03803A6C
	.byte 0x00, 0x28, 0x09, 0xD1, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21, 0xFF, 0xF7, 0x04, 0xFA	; 03803A7C
	.byte 0x01, 0x20, 0xFF, 0xF7, 0xDB, 0xF9, 0x2E, 0xE0, 0xA0, 0x68, 0x00, 0xF0, 0x77, 0xF9, 0x21, 0xE0	; 03803A8C
	.byte 0xFF, 0xF7, 0x5E, 0xFF, 0x00, 0x28, 0x09, 0xD1, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x03, 0x21	; 03803A9C
	.byte 0xFF, 0xF7, 0xF2, 0xF9, 0x01, 0x20, 0xFF, 0xF7, 0xC9, 0xF9, 0x1C, 0xE0, 0x00, 0xF0, 0x40, 0xF9	; 03803AAC
	.byte 0x10, 0xE0, 0x20, 0x69, 0x00, 0xF0, 0xEA, 0xF8, 0x0C, 0xE0, 0x00, 0xF0, 0xC1, 0xF8, 0x09, 0xE0	; 03803ABC
	.byte 0x01, 0x20, 0xFF, 0xF7, 0xBB, 0xF9, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x01, 0x21, 0xFF, 0xF7	; 03803ACC
	.byte 0xDB, 0xF9, 0x08, 0xE0, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x21, 0xFF, 0xF7, 0xD4, 0xF9	; 03803ADC
	.byte 0x01, 0x20, 0xFF, 0xF7, 0xAB, 0xF9, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 03803AEC

; ===== function loc_03803AEC =====
loc_03803AEC:
	push {r4,r5,r6,r7,lr}	; 03803AEC
	sub sp,#0xc	; 03803AEE
	ldr r1,[pool_03803C0C]	; 03803AF0
	add r5,r0,#0x0	; 03803AF2
	and r5,r1	; 03803AF4
	cmp r5,#0x0	; 03803AF6
	beq loc_03803B0A	; 03803AF8
	mov r5,#0x0	; 03803AFA
	add r6,r5,#0x0	; 03803AFC
	ldr r7,[pool_03803C10]	; 03803AFE
loc_03803B00:
	lsl r1,r5,#0x1	; 03803B00
	strh r6,[r7,r1]	; 03803B02
	add r5,r5,#0x1	; 03803B04
	cmp r5,#0x10	; 03803B06
	blt loc_03803B00	; 03803B08
loc_03803B0A:
	ldr r1,[pool_03803C14]	; 03803B0A
	add r5,r0,#0x0	; 03803B0C
	and r5,r1	; 03803B0E
	lsr r1,r5,#0x10	; 03803B10
	lsl r5,r1,#0x1	; 03803B12
	ldr r1,[pool_03803C10]	; 03803B14
	strh r0,[r1,r5]	; 03803B16
	ldr r5,[pool_03803C18]	; 03803B18
	and r0,r5	; 03803B1A
	cmp r0,#0x0	; 03803B1C
	beq loc_03803C04	; 03803B1E
	ldrh r0,[r1,#0x0]	; 03803B20
	ldr r7,[pool_03803C1C]	; 03803B22
	add r5,r0,#0x0	; 03803B24
	and r5,r7	; 03803B26
	lsl r5,r5,#0x8	; 03803B28
	lsr r6,r5,#0x10	; 03803B2A
	add r5,r6,#0x0	; 03803B2C
	sub r5,#0x22	; 03803B2E
	cmp r5,#0xa	; 03803B30
	bhi loc_03803BEA	; 03803B32
	add r5,r5,r5	; 03803B34
	add r5,pc	; 03803B36
	ldrh r5,[r5,#0x8]	; 03803B38
	lsl r5,r5,#0x10	; 03803B3A
	asr r5,r5,#0x10	; 03803B3C
	add r5,pc	; 03803B3E
	bx r5	; 03803B40
	.byte 0x17, 0x00, 0x41, 0x00, 0xA9, 0x00, 0x73, 0x00, 0xA9, 0x00, 0x9F, 0x00, 0xA9, 0x00, 0xA9, 0x00	; 03803B52
	.byte 0xA9, 0x00, 0xA9, 0x00, 0x17, 0x00	; 03803B58
loc_03803B58:
	ldrh r4,[r1,#0x4]	; 03803B58
	and r4,r7	; 03803B5A
	lsr r4,r4,#0x8	; 03803B5C
	mov r5,#0xff	; 03803B5E
	and r0,r5	; 03803B60
	lsl r0,r0,#0x18	; 03803B62
	ldrh r1,[r1,#0x2]	; 03803B64
	lsl r1,r1,#0x8	; 03803B66
	orr r0,r1	; 03803B68
	orr r4,r0	; 03803B6A
	ldr r0,[pool_03803C0C]	; 03803B6C
	cmp r4,r0	; 03803B6E
	bcc loc_03803B78	; 03803B70
	ldr r0,[pool_03803C20]	; 03803B72
	cmp r4,r0	; 03803B74
	bcc loc_03803BEA	; 03803B76
loc_03803B78:
	add r0,r6,#0x0	; 03803B78
	mov r1,#0x2	; 03803B7A
	bl loc_03802E84	; 03803B7C
	b loc_03803C04	; 03803B80
loc_03803B82:
	ldrh r2,[r1,#0x8]	; 03803B82
	lsl r4,r2,#0x10	; 03803B84
	ldrh r2,[r1,#0xa]	; 03803B86
	orr r4,r2	; 03803B88
	ldr r2,[pool_03803C0C]	; 03803B8A
	cmp r4,r2	; 03803B8C
	bcc loc_03803B96	; 03803B8E
	ldr r2,[pool_03803C20]	; 03803B90
	cmp r4,r2	; 03803B92
	bcc loc_03803BA0	; 03803B94
loc_03803B96:
	add r0,r6,#0x0	; 03803B96
	mov r1,#0x2	; 03803B98
	bl loc_03802E84	; 03803B9A
	b loc_03803C04	; 03803B9E
loc_03803BA0:
	mov r2,#0xff	; 03803BA0
	and r0,r2	; 03803BA2
	lsl r3,r0,#0x10	; 03803BA4
	ldrh r0,[r1,#0x2]	; 03803BA6
	orr r3,r0	; 03803BA8
	ldrh r0,[r1,#0x4]	; 03803BAA
	lsl r2,r0,#0x10	; 03803BAC
	ldrh r0,[r1,#0x6]	; 03803BAE
	orr r2,r0	; 03803BB0
	b loc_03803BEA	; 03803BB2
loc_03803BB4:
	ldrh r2,[r1,#0x6]	; 03803BB4
	lsl r4,r2,#0x10	; 03803BB6
	ldrh r2,[r1,#0x8]	; 03803BB8
	orr r4,r2	; 03803BBA
	ldr r2,[pool_03803C0C]	; 03803BBC
	cmp r4,r2	; 03803BBE
	bcc loc_03803BC8	; 03803BC0
	ldr r2,[pool_03803C20]	; 03803BC2
	cmp r4,r2	; 03803BC4
	bcc loc_03803BD2	; 03803BC6
loc_03803BC8:
	add r0,r6,#0x0	; 03803BC8
	mov r1,#0x2	; 03803BCA
	bl loc_03802E84	; 03803BCC
	b loc_03803C04	; 03803BD0
loc_03803BD2:
	mov r2,#0xff	; 03803BD2
	and r0,r2	; 03803BD4
	lsl r3,r0,#0x10	; 03803BD6
	ldrh r0,[r1,#0x2]	; 03803BD8
	orr r3,r0	; 03803BDA
	ldrh r2,[r1,#0x4]	; 03803BDC
	b loc_03803BEA	; 03803BDE
loc_03803BE0:
	mov r3,#0xff	; 03803BE0
	and r0,r3	; 03803BE2
	lsl r3,r0,#0x10	; 03803BE4
	ldrh r0,[r1,#0x2]	; 03803BE6
	orr r3,r0	; 03803BE8
loc_03803BEA:
	str r2,[sp,#0x0]	; 03803BEA
	str r4,[sp,#0x4]	; 03803BEC
	mov r0,#0x1	; 03803BEE
	add r1,r6,#0x0	; 03803BF0
	mov r2,#0x3	; 03803BF2
	bl loc_03802D90	; 03803BF4
	cmp r0,#0x0	; 03803BF8
	bne loc_03803C04	; 03803BFA
	add r0,r6,#0x0	; 03803BFC
	mov r1,#0x4	; 03803BFE
	bl loc_03802E84	; 03803C00
loc_03803C04:
	add sp,#0xc	; 03803C04
	pop {r4,r5,r6,r7}	; 03803C06
	pop {r3}	; 03803C08
	bx r3	; 03803C0A
pool_03803C0C:
loc_03803C0C:
	.word 0x02000000	; 03803C0C
pool_03803C10:
loc_03803C10:
	.word 0x03807A10	; 03803C10
pool_03803C14:
loc_03803C14:
	.word 0x000F0000	; 03803C14
pool_03803C18:
loc_03803C18:
	.word 0x01000000	; 03803C18
pool_03803C1C:
loc_03803C1C:
	.word 0x0000FF00	; 03803C1C
pool_03803C20:
loc_03803C20:
	.word 0x02400000	; 03803C20

; ===== function loc_03803C24 =====
loc_03803C24:
	mov r3,#0x0	; 03803C24
	add r2,r3,#0x0	; 03803C26
	ldr r0,[pool_03803C38]	; 03803C28
loc_03803C2A:
	lsl r1,r3,#0x1	; 03803C2A
	strh r2,[r0,r1]	; 03803C2C
	add r3,r3,#0x1	; 03803C2E
	cmp r3,#0x10	; 03803C30
	blt loc_03803C2A	; 03803C32
	bx lr	; 03803C34
	.byte 0xC0, 0x46	; 03803C38
pool_03803C38:
loc_03803C38:
	.word 0x03807A10	; 03803C38
	.byte 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0x44, 0xFE	; 03803C4C
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0xFF, 0x21, 0x0A, 0x48	; 03803C5C
	.byte 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0x34, 0xFE	; 03803C6C
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03803C7C
	.byte 0xC0, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0xF0, 0xB5, 0x81, 0xB0	; 03803C8C
	.byte 0x05, 0x1C, 0x01, 0x27, 0x22, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0, 0x1C, 0xFE	; 03803C9C
	.byte 0x20, 0x88, 0x30, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x1E, 0x48, 0x20, 0x80, 0x9F, 0x21, 0x1E, 0x48	; 03803CAC
	.byte 0x01, 0x80, 0x01, 0x27, 0x1A, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0, 0x0C, 0xFE	; 03803CBC
	.byte 0x20, 0x88, 0x30, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x00, 0x21, 0x17, 0x48, 0x01, 0x80, 0x01, 0x27	; 03803CCC
	.byte 0x13, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0, 0xFE, 0xFD, 0x20, 0x88, 0x30, 0x40	; 03803CDC
	.byte 0x00, 0x28, 0xF8, 0xD1, 0x10, 0x49, 0x0A, 0x88, 0xFF, 0x20, 0x02, 0x40, 0x2A, 0x70, 0x0F, 0x48	; 03803CEC
	.byte 0x20, 0x80, 0x00, 0x20, 0x08, 0x80, 0x01, 0x27, 0x09, 0x4C, 0x80, 0x26, 0x02, 0xE0, 0x38, 0x1C	; 03803CFC
	.byte 0x00, 0xF0, 0xEA, 0xFD, 0x20, 0x88, 0x30, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x06, 0x48, 0x01, 0x88	; 03803D0C
	.byte 0xFF, 0x20, 0x01, 0x40, 0x69, 0x70, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03803D1C
	.byte 0xC0, 0x01, 0x00, 0x04, 0x00, 0x89, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00	; 03803D2C
	.byte 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xCC, 0xFD	; 03803D3C
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0xC7, 0x21, 0x0A, 0x48	; 03803D4C
	.byte 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xBC, 0xFD	; 03803D5C
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 03803D6C
	.byte 0xC0, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0xF0, 0xB5, 0x81, 0xB0	; 03803D7C
	.byte 0x2C, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x11, 0x0C, 0x09, 0x04, 0x0D, 0x0C, 0x2A, 0x49, 0x02, 0x1C	; 03803D8C
	.byte 0x0A, 0x40, 0x11, 0x02, 0x0C, 0x0C, 0xFF, 0x21, 0x08, 0x40, 0x00, 0x04, 0x06, 0x0C, 0x27, 0x4F	; 03803D9C
	.byte 0x02, 0xE0, 0x01, 0x20, 0x00, 0xF0, 0x98, 0xFD, 0x39, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29	; 03803DAC
	.byte 0xF7, 0xD1, 0x23, 0x48, 0x38, 0x80, 0xDB, 0x21, 0x22, 0x48, 0x01, 0x80, 0x1F, 0x4F, 0x02, 0xE0	; 03803DBC
	.byte 0x01, 0x20, 0x00, 0xF0, 0x89, 0xFD, 0x39, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29, 0xF7, 0xD1	; 03803DCC
	.byte 0xFF, 0x20, 0x05, 0x40, 0x1B, 0x48, 0x05, 0x80, 0x18, 0x4D, 0x80, 0x27, 0x02, 0xE0, 0x01, 0x20	; 03803DDC
	.byte 0x00, 0xF0, 0x7A, 0xFD, 0x28, 0x88, 0x38, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0xFF, 0x20, 0x04, 0x40	; 03803DEC
	.byte 0x14, 0x48, 0x04, 0x80, 0x01, 0x27, 0x11, 0x4C, 0x80, 0x25, 0x02, 0xE0, 0x38, 0x1C, 0x00, 0xF0	; 03803DFC
	.byte 0x6B, 0xFD, 0x20, 0x88, 0x28, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0F, 0x48, 0x20, 0x80, 0xFF, 0x20	; 03803E0C
	.byte 0x06, 0x40, 0x0C, 0x48, 0x06, 0x80, 0x01, 0x26, 0x08, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C	; 03803E1C
	.byte 0x00, 0xF0, 0x5A, 0xFD, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x01, 0xB0, 0xF0, 0xBC	; 03803E2C
	.byte 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xC0, 0x01, 0x00, 0x04	; 03803E3C
	.byte 0x00, 0x89, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xF0, 0xB5, 0x83, 0xB0	; 03803E4C
	.byte 0x0C, 0x1C, 0x16, 0x1C, 0x01, 0x2C, 0x6D, 0xD3, 0x01, 0x19, 0x49, 0x1E, 0x0A, 0x0A, 0x01, 0x0A	; 03803E5C
	.byte 0x8A, 0x42, 0x06, 0xD9, 0xFF, 0x21, 0x02, 0x1C, 0x0A, 0x40, 0x34, 0x49, 0x89, 0x1A, 0x09, 0x04	; 03803E6C
	.byte 0x0C, 0x0C, 0x33, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x11, 0x0C, 0x00, 0xAA, 0x11, 0x80, 0x31, 0x49	; 03803E7C
	.byte 0x03, 0x1C, 0x0B, 0x40, 0x19, 0x0A, 0x51, 0x80, 0xFF, 0x21, 0x08, 0x40, 0x90, 0x80, 0x2E, 0x4D	; 03803E8C
	.byte 0x80, 0x27, 0x02, 0xE0, 0x01, 0x20, 0x00, 0xF0, 0x1F, 0xFD, 0x28, 0x88, 0x38, 0x40, 0x00, 0x28	; 03803E9C
	.byte 0xF8, 0xD1, 0x2A, 0x48, 0x28, 0x80, 0x0A, 0x20, 0x29, 0x4F, 0x38, 0x80, 0x00, 0x25, 0x0F, 0xE0	; 03803EAC
	.byte 0x01, 0x20, 0x00, 0xF0, 0x11, 0xFD, 0x24, 0x48, 0x01, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29	; 03803EBC
	.byte 0xF6, 0xD1, 0x69, 0x00, 0x00, 0xA8, 0x41, 0x5A, 0xFF, 0x20, 0x01, 0x40, 0x39, 0x80, 0x6D, 0x1C	; 03803ECC
	.byte 0x03, 0x2D, 0xF0, 0xDB, 0x00, 0x25, 0x64, 0x1E, 0x1B, 0x4F, 0x0D, 0xE0, 0x01, 0x20, 0x00, 0xF0	; 03803EDC
	.byte 0xFB, 0xFC, 0x39, 0x88, 0x80, 0x20, 0x01, 0x40, 0x00, 0x29, 0xF7, 0xD1, 0x71, 0x5D, 0xFF, 0x20	; 03803EEC
	.byte 0x01, 0x40, 0x17, 0x48, 0x01, 0x80, 0x6D, 0x1C, 0xA5, 0x42, 0xF2, 0xDB, 0x12, 0x4C, 0x80, 0x27	; 03803EFC
	.byte 0x02, 0xE0, 0x01, 0x20, 0x00, 0xF0, 0xE8, 0xFC, 0x20, 0x88, 0x38, 0x40, 0x00, 0x28, 0xF8, 0xD1	; 03803F0C
	.byte 0x10, 0x48, 0x20, 0x80, 0x71, 0x5D, 0xFF, 0x20, 0x01, 0x40, 0x0D, 0x48, 0x01, 0x80, 0x01, 0x26	; 03803F1C
	.byte 0x09, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xD6, 0xFC, 0x28, 0x88, 0x20, 0x40	; 03803F2C
	.byte 0x00, 0x28, 0xF8, 0xD1, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x01, 0x00, 0x00	; 03803F3C
	.byte 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xC0, 0x01, 0x00, 0x04, 0x00, 0x89, 0x00, 0x00	; 03803F4C
	.byte 0xC2, 0x01, 0x00, 0x04, 0x00, 0x81, 0x00, 0x00	; 03803F54

; ===== function loc_03803F54 =====
loc_03803F54:
	push {r4,r5,r6,r7,lr}	; 03803F54
	sub sp,#0xc	; 03803F56
	add r4,r1,#0x0	; 03803F58
	add r6,r2,#0x0	; 03803F5A
	cmp r4,#0x1	; 03803F5C
	bcc loc_0380402E	; 03803F5E
	ldr r1,[pool_03804038]	; 03803F60
	add r2,r0,#0x0	; 03803F62
	and r2,r1	; 03803F64
	lsr r1,r2,#0x10	; 03803F66
	add r2,sp,#0x0	; 03803F68
	strh r1,[r2,#0x0]	; 03803F6A
	ldr r1,[pool_0380403C]	; 03803F6C
	add r3,r0,#0x0	; 03803F6E
	and r3,r1	; 03803F70
	lsr r1,r3,#0x8	; 03803F72
	strh r1,[r2,#0x2]	; 03803F74
	mov r1,#0xff	; 03803F76
	and r0,r1	; 03803F78
	strh r0,[r2,#0x4]	; 03803F7A
	ldr r5,[pool_03804040]	; 03803F7C
	mov r7,#0x80	; 03803F7E
	b loc_03803F88	; 03803F80
loc_03803F82:
	mov r0,#0x1	; 03803F82
	bl loc_038048D4	; 03803F84
loc_03803F88:
	ldrh r0,[r5,#0x0]	; 03803F88
	and r0,r7	; 03803F8A
	cmp r0,#0x0	; 03803F8C
	bne loc_03803F82	; 03803F8E
	ldr r0,[pool_03804044]	; 03803F90
	strh r0,[r5,#0x0]	; 03803F92
	mov r0,#0x3	; 03803F94
	ldr r7,[pool_03804048]	; 03803F96
	strh r0,[r7,#0x0]	; 03803F98
	mov r5,#0x0	; 03803F9A
	b loc_03803FBE	; 03803F9C
loc_03803F9E:
	mov r0,#0x1	; 03803F9E
	bl loc_038048D4	; 03803FA0
loc_03803FA4:
	ldr r0,[pool_03804040]	; 03803FA4
	ldrh r1,[r0,#0x0]	; 03803FA6
	mov r0,#0x80	; 03803FA8
	and r1,r0	; 03803FAA
	cmp r1,#0x0	; 03803FAC
	bne loc_03803F9E	; 03803FAE
	lsl r1,r5,#0x1	; 03803FB0
	add r0,sp,#0x0	; 03803FB2
	ldrh r1,[r0,r1]	; 03803FB4
	mov r0,#0xff	; 03803FB6
	and r1,r0	; 03803FB8
	strh r1,[r7,#0x0]	; 03803FBA
	add r5,r5,#0x1	; 03803FBC
loc_03803FBE:
	cmp r5,#0x3	; 03803FBE
	blt loc_03803FA4	; 03803FC0
	ldr r5,[pool_03804040]	; 03803FC2
	mov r7,#0x80	; 03803FC4
	b loc_03803FCE	; 03803FC6
loc_03803FC8:
	mov r0,#0x1	; 03803FC8
	bl loc_038048D4	; 03803FCA
loc_03803FCE:
	ldrh r0,[r5,#0x0]	; 03803FCE
	and r0,r7	; 03803FD0
	cmp r0,#0x0	; 03803FD2
	bne loc_03803FC8	; 03803FD4
	mov r5,#0x0	; 03803FD6
	add r7,r5,#0x0	; 03803FD8
	b loc_03804000	; 03803FDA
loc_03803FDC:
	ldr r0,[pool_03804048]	; 03803FDC
	strh r7,[r0,#0x0]	; 03803FDE
	b loc_03803FE8	; 03803FE0
loc_03803FE2:
	mov r0,#0x1	; 03803FE2
	bl loc_038048D4	; 03803FE4
loc_03803FE8:
	ldr r0,[pool_03804040]	; 03803FE8
	ldrh r1,[r0,#0x0]	; 03803FEA
	mov r0,#0x80	; 03803FEC
	and r1,r0	; 03803FEE
	cmp r1,#0x0	; 03803FF0
	bne loc_03803FE2	; 03803FF2
	ldr r0,[pool_03804048]	; 03803FF4
	ldrh r1,[r0,#0x0]	; 03803FF6
	mov r0,#0xff	; 03803FF8
	and r1,r0	; 03803FFA
	strb r1,[r6,r5]	; 03803FFC
	add r5,r5,#0x1	; 03803FFE
loc_03804000:
	sub r0,r4,#0x1	; 03804000
	cmp r5,r0	; 03804002
	bcc loc_03803FDC	; 03804004
	ldr r0,[pool_0380404C]	; 03804006
	ldr r4,[pool_03804040]	; 03804008
	strh r0,[r4,#0x0]	; 0380400A
	mov r1,#0x0	; 0380400C
	ldr r0,[pool_03804048]	; 0380400E
	strh r1,[r0,#0x0]	; 03804010
	mov r7,#0x80	; 03804012
	b loc_0380401C	; 03804014
loc_03804016:
	mov r0,#0x1	; 03804016
	bl loc_038048D4	; 03804018
loc_0380401C:
	ldrh r0,[r4,#0x0]	; 0380401C
	and r0,r7	; 0380401E
	cmp r0,#0x0	; 03804020
	bne loc_03804016	; 03804022
	ldr r0,[pool_03804048]	; 03804024
	ldrh r1,[r0,#0x0]	; 03804026
	mov r0,#0xff	; 03804028
	and r1,r0	; 0380402A
	strb r1,[r6,r5]	; 0380402C
loc_0380402E:
	add sp,#0xc	; 0380402E
	pop {r4,r5,r6,r7}	; 03804030
	pop {r3}	; 03804032
	bx r3	; 03804034
	.byte 0xC0, 0x46	; 03804038
pool_03804038:
loc_03804038:
	.word 0x00FF0000	; 03804038
pool_0380403C:
loc_0380403C:
	.word 0x0000FF00	; 0380403C
pool_03804040:
loc_03804040:
	.word 0x040001C0	; 03804040
pool_03804044:
loc_03804044:
	.word 0x00008900	; 03804044
pool_03804048:
loc_03804048:
	.word 0x040001C2	; 03804048
pool_0380404C:
loc_0380404C:
	.word 0x00008100	; 0380404C

; ===== function loc_03804050 =====
loc_03804050:
	push {r4,r5,r6,r7,lr}	; 03804050
	sub sp,#0x4	; 03804052
	add r5,r0,#0x0	; 03804054
	mov r7,#0x1	; 03804056
	ldr r4,[pool_038040C0]	; 03804058
	mov r6,#0x80	; 0380405A
	b loc_03804064	; 0380405C
loc_0380405E:
	add r0,r7,#0x0	; 0380405E
	bl loc_038048D4	; 03804060
loc_03804064:
	ldrh r0,[r4,#0x0]	; 03804064
	and r0,r6	; 03804066
	cmp r0,#0x0	; 03804068
	bne loc_0380405E	; 0380406A
	ldr r0,[pool_038040C4]	; 0380406C
	strh r0,[r4,#0x0]	; 0380406E
	mov r1,#0x5	; 03804070
	ldr r0,[pool_038040C8]	; 03804072
	strh r1,[r0,#0x0]	; 03804074
	mov r7,#0x1	; 03804076
	ldr r4,[pool_038040C0]	; 03804078
	mov r6,#0x80	; 0380407A
	b loc_03804084	; 0380407C
loc_0380407E:
	add r0,r7,#0x0	; 0380407E
	bl loc_038048D4	; 03804080
loc_03804084:
	ldrh r0,[r4,#0x0]	; 03804084
	and r0,r6	; 03804086
	cmp r0,#0x0	; 03804088
	bne loc_0380407E	; 0380408A
	ldr r0,[pool_038040CC]	; 0380408C
	strh r0,[r4,#0x0]	; 0380408E
	mov r1,#0x0	; 03804090
	ldr r0,[pool_038040C8]	; 03804092
	strh r1,[r0,#0x0]	; 03804094
	mov r7,#0x1	; 03804096
	ldr r4,[pool_038040C0]	; 03804098
	mov r6,#0x80	; 0380409A
	b loc_038040A4	; 0380409C
loc_0380409E:
	add r0,r7,#0x0	; 0380409E
	bl loc_038048D4	; 038040A0
loc_038040A4:
	ldrh r0,[r4,#0x0]	; 038040A4
	and r0,r6	; 038040A6
	cmp r0,#0x0	; 038040A8
	bne loc_0380409E	; 038040AA
	ldr r0,[pool_038040C8]	; 038040AC
	ldrh r1,[r0,#0x0]	; 038040AE
	mov r0,#0xff	; 038040B0
	and r1,r0	; 038040B2
	strb r1,[r5,#0x0]	; 038040B4
	add sp,#0x4	; 038040B6
	pop {r4,r5,r6,r7}	; 038040B8
	pop {r3}	; 038040BA
	bx r3	; 038040BC
	.byte 0xC0, 0x46	; 038040C0
pool_038040C0:
loc_038040C0:
	.word 0x040001C0	; 038040C0
pool_038040C4:
loc_038040C4:
	.word 0x00008900	; 038040C4
pool_038040C8:
loc_038040C8:
	.word 0x040001C2	; 038040C8
pool_038040CC:
loc_038040CC:
	.word 0x00008100	; 038040CC
	.byte 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xFA, 0xFB	; 038040E0
	.byte 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0x04, 0x21, 0x0A, 0x48	; 038040F0
	.byte 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D, 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0	; 038040FE
loc_038040FE:
	.byte 0xEA, 0xFB, 0x28, 0x88	; 038040FE
	.byte 0x20, 0x40, 0x00, 0x28	; 03804102
	.byte 0xF8, 0xD1, 0x70, 0xBC	; 03804106
	.byte 0x08, 0xBC, 0x18, 0x47	; 0380410A
	.byte 0xC0, 0x46, 0xC0, 0x01	; 0380410E
	.byte 0x00, 0x04, 0x00, 0x81, 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x70, 0xB5, 0x01, 0x26, 0x0E, 0x4D	; 03804122
	.byte 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xD4, 0xFB, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28	; 03804132
	.byte 0xF8, 0xD1, 0x0A, 0x48, 0x28, 0x80, 0x06, 0x21, 0x0A, 0x48, 0x01, 0x80, 0x01, 0x26, 0x06, 0x4D	; 03804142
	.byte 0x80, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x00, 0xF0, 0xC4, 0xFB, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28	; 03804152
	.byte 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xC0, 0x01, 0x00, 0x04, 0x00, 0x81	; 03804162
	.byte 0x00, 0x00, 0xC2, 0x01, 0x00, 0x04, 0x30, 0xB5, 0x81, 0xB0, 0x04, 0x1C, 0xF9, 0xF7, 0xB7, 0xFD	; 03804172
	.byte 0x05, 0x1C, 0x03, 0x20, 0xFE, 0xF7, 0x7B, 0xFE, 0x00, 0x28, 0x09, 0xD1, 0x28, 0x1C, 0xF9, 0xF7	; 03804182
	.byte 0xC0, 0xFD, 0x60, 0x68, 0x00, 0x04, 0x00, 0x0C, 0x04, 0x21, 0xFE, 0xF7, 0x7A, 0xFE, 0x5E, 0xE0	; 03804192
	.byte 0x03, 0x20, 0xFE, 0xF7, 0x64, 0xFE, 0x28, 0x1C, 0xF9, 0xF7, 0xB3, 0xFD, 0x60, 0x68, 0x01, 0x1C	; 038041A2
	.byte 0x61, 0x39, 0x05, 0x29, 0x4B, 0xD8, 0x49, 0x18, 0x79, 0x44, 0x09, 0x89, 0x09, 0x04, 0x09, 0x14	; 038041B2
	.byte 0x79, 0x44, 0x08, 0x47, 0x0D, 0x00, 0x8B, 0x00, 0x6B, 0x00, 0x25, 0x00, 0x49, 0x00, 0x83, 0x00	; 038041C2
	.byte 0x01, 0x21, 0x24, 0x48, 0x01, 0x62, 0xA1, 0x68, 0x24, 0x48, 0x01, 0x80, 0xE1, 0x68, 0x23, 0x48	; 038041D2
	.byte 0x01, 0x80, 0x00, 0xF0, 0x46, 0xFA, 0x37, 0xE0, 0x04, 0x21, 0x1E, 0x48, 0x01, 0x62, 0xA2, 0x68	; 038041E2
	.byte 0x82, 0x62, 0xE1, 0x68, 0x41, 0x62, 0x10, 0x04, 0x00, 0x0C, 0x09, 0x06, 0x09, 0x0E, 0x00, 0xF0	; 038041F2
	.byte 0x72, 0xF9, 0x64, 0x20, 0x00, 0x21, 0xFE, 0xF7, 0x44, 0xFE, 0x25, 0xE0, 0x03, 0x21, 0x15, 0x48	; 03804202
	.byte 0x01, 0x62, 0xA1, 0x68, 0x81, 0x62, 0x08, 0x04, 0x04, 0x0C, 0x20, 0x1C, 0x00, 0xF0, 0x1F, 0xF9	; 03804212
	.byte 0x01, 0x1C, 0x70, 0x34, 0x20, 0x04, 0x00, 0x0C, 0xFE, 0xF7, 0x33, 0xFE, 0x14, 0xE0, 0x02, 0x20	; 03804222
	.byte 0x0D, 0x49, 0x08, 0x62, 0xA0, 0x68, 0x48, 0x62, 0x00, 0xF0, 0xB3, 0xF9, 0x63, 0x20, 0x00, 0x21	; 03804232
	.byte 0xFE, 0xF7, 0x27, 0xFE, 0x08, 0xE0, 0xA0, 0x68, 0x00, 0xF0, 0x89, 0xF9, 0x04, 0xE0, 0x00, 0x04	; 03804242
	.byte 0x00, 0x0C, 0x01, 0x21, 0xFE, 0xF7, 0x1D, 0xFE, 0x03, 0x20, 0xFE, 0xF7, 0xF4, 0xFD, 0x01, 0xB0	; 03804252
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x3C, 0x7A, 0x80, 0x03, 0x34, 0x7A, 0x80, 0x03, 0x30, 0x7A	; 03804262
	.byte 0x80, 0x03	; 03804264

; ===== function loc_03804264 =====
loc_03804264:
	push {r4,r5,r6,lr}	; 03804264
	sub sp,#0x8	; 03804266
	ldr r1,[pool_03804394]	; 03804268
	add r2,r0,#0x0	; 0380426A
	and r2,r1	; 0380426C
	cmp r2,#0x0	; 0380426E
	beq loc_03804282	; 03804270
	mov r4,#0x0	; 03804272
	add r3,r4,#0x0	; 03804274
	ldr r1,[pool_03804398]	; 03804276
loc_03804278:
	lsl r2,r4,#0x1	; 03804278
	strh r3,[r1,r2]	; 0380427A
	add r4,r4,#0x1	; 0380427C
	cmp r4,#0x10	; 0380427E
	blt loc_03804278	; 03804280
loc_03804282:
	ldr r1,[pool_0380439C]	; 03804282
	add r2,r0,#0x0	; 03804284
	and r2,r1	; 03804286
	lsr r1,r2,#0x10	; 03804288
	lsl r1,r1,#0x1	; 0380428A
	ldr r5,[pool_03804398]	; 0380428C
	strh r0,[r5,r1]	; 0380428E
	ldr r1,[pool_038043A0]	; 03804290
	and r0,r1	; 03804292
	cmp r0,#0x0	; 03804294
	beq loc_0380438C	; 03804296
	ldrh r3,[r5,#0x0]	; 03804298
	ldr r0,[pool_038043A4]	; 0380429A
	add r1,r3,#0x0	; 0380429C
	and r1,r0	; 0380429E
	lsl r0,r1,#0x8	; 038042A0
	lsr r4,r0,#0x10	; 038042A2
	add r0,r4,#0x0	; 038042A4
	sub r0,#0x60	; 038042A6
	cmp r0,#0x7	; 038042A8
	bhi loc_03804384	; 038042AA
	add r0,r0,r0	; 038042AC
	add r0,pc	; 038042AE
	ldrh r0,[r0,#0x8]	; 038042B0
	lsl r0,r0,#0x10	; 038042B2
	asr r0,r0,#0x10	; 038042B4
	add r0,pc	; 038042B6
	bx r0	; 038042B8
	.byte 0x11, 0x00, 0x1B, 0x00, 0xCB, 0x00, 0x7F, 0x00, 0x3F, 0x00, 0x63, 0x00, 0xA5, 0x00, 0xB9, 0x00	; 038042CA
loc_038042CA:
	mov r0,#0x60	; 038042CA
	mov r1,#0x0	; 038042CC
	bl loc_03802E84	; 038042CE
	b loc_0380438C	; 038042D2
loc_038042D4:
	ldrh r1,[r5,#0x2]	; 038042D4
	ldr r0,[pool_038043A8]	; 038042D6
	and r1,r0	; 038042D8
	str r1,[sp,#0x0]	; 038042DA
	mov r0,#0x3	; 038042DC
	add r1,r4,#0x0	; 038042DE
	mov r2,#0x2	; 038042E0
	mov r5,#0xff	; 038042E2
	and r3,r5	; 038042E4
	bl loc_03802D90	; 038042E6
	cmp r0,#0x0	; 038042EA
	bne loc_0380438C	; 038042EC
	add r0,r4,#0x0	; 038042EE
	mov r1,#0x4	; 038042F0
	bl loc_03802E84	; 038042F2
	b loc_0380438C	; 038042F6
loc_038042F8:
	ldrh r1,[r5,#0x2]	; 038042F8
	ldr r0,[pool_038043A8]	; 038042FA
	and r1,r0	; 038042FC
	str r1,[sp,#0x0]	; 038042FE
	mov r0,#0x3	; 03804300
	add r1,r4,#0x0	; 03804302
	mov r2,#0x2	; 03804304
	mov r5,#0xff	; 03804306
	and r3,r5	; 03804308
	bl loc_03802D90	; 0380430A
	cmp r0,#0x0	; 0380430E
	bne loc_0380438C	; 03804310
	add r0,r4,#0x0	; 03804312
	mov r1,#0x4	; 03804314
	bl loc_03802E84	; 03804316
	b loc_0380438C	; 0380431A
loc_0380431C:
	mov r0,#0x3	; 0380431C
	add r1,r4,#0x0	; 0380431E
	mov r2,#0x1	; 03804320
	ldr r5,[pool_038043A8]	; 03804322
	and r3,r5	; 03804324
	bl loc_03802D90	; 03804326
	cmp r0,#0x0	; 0380432A
	bne loc_0380438C	; 0380432C
	add r0,r4,#0x0	; 0380432E
	mov r1,#0x4	; 03804330
	bl loc_03802E84	; 03804332
	b loc_0380438C	; 03804336
loc_03804338:
	mov r0,#0x3	; 03804338
	add r1,r4,#0x0	; 0380433A
	mov r2,#0x1	; 0380433C
	mov r6,#0xff	; 0380433E
	and r3,r6	; 03804340
	lsl r3,r3,#0x10	; 03804342
	ldrh r6,[r5,#0x2]	; 03804344
	ldr r5,[pool_038043A8]	; 03804346
	and r6,r5	; 03804348
	orr r3,r6	; 0380434A
	bl loc_03802D90	; 0380434C
	cmp r0,#0x0	; 03804350
	bne loc_0380438C	; 03804352
	add r0,r4,#0x0	; 03804354
	mov r1,#0x4	; 03804356
	bl loc_03802E84	; 03804358
	b loc_0380438C	; 0380435C
loc_0380435E:
	mov r0,#0xff	; 0380435E
	and r3,r0	; 03804360
	add r0,r3,#0x0	; 03804362
	bl loc_038047BC	; 03804364
	mov r0,#0x66	; 03804368
	mov r1,#0x0	; 0380436A
	bl loc_03802E84	; 0380436C
	b loc_0380438C	; 03804370
loc_03804372:
	bl loc_038047B0	; 03804372
	add r1,r0,#0x0	; 03804376
	mov r0,#0x67	; 03804378
	lsl r1,r1,#0x10	; 0380437A
	lsr r1,r1,#0x10	; 0380437C
	bl loc_03802E84	; 0380437E
	b loc_0380438C	; 03804382
loc_03804384:
	add r0,r4,#0x0	; 03804384
	mov r1,#0x1	; 03804386
	bl loc_03802E84	; 03804388
loc_0380438C:
	add sp,#0x8	; 0380438C
	pop {r4,r5,r6}	; 0380438E
	pop {r3}	; 03804390
	bx r3	; 03804392
pool_03804394:
loc_03804394:
	.word 0x02000000	; 03804394
pool_03804398:
loc_03804398:
	.word 0x03807A3C	; 03804398
pool_0380439C:
loc_0380439C:
	.word 0x000F0000	; 0380439C
pool_038043A0:
loc_038043A0:
	.word 0x01000000	; 038043A0
pool_038043A4:
loc_038043A4:
	.word 0x0000FF00	; 038043A4
pool_038043A8:
loc_038043A8:
	.word 0x0000FFFF	; 038043A8

; ===== function loc_038043AC =====
loc_038043AC:
	mov r1,#0x1	; 038043AC
	ldr r0,[pool_038043C8]	; 038043AE
	str r1,[r0,#0x0]	; 038043B0
	mov r3,#0x0	; 038043B2
	ldr r0,[pool_038043CC]	; 038043B4
	str r3,[r0,#0x20]	; 038043B6
	add r2,r3,#0x0	; 038043B8
loc_038043BA:
	lsl r1,r3,#0x1	; 038043BA
	strh r2,[r0,r1]	; 038043BC
	add r3,r3,#0x1	; 038043BE
	cmp r3,#0x10	; 038043C0
	blt loc_038043BA	; 038043C2
	bx lr	; 038043C4
	.byte 0xC0, 0x46	; 038043C8
pool_038043C8:
loc_038043C8:
	.word 0x03807A38	; 038043C8
pool_038043CC:
loc_038043CC:
	.word 0x03807A3C	; 038043CC
	.byte 0x06, 0x4B, 0x1A, 0x40, 0x06, 0x4B, 0x18, 0x40, 0x83, 0x05, 0x06, 0x48, 0x01, 0x40, 0x08, 0x04	; 038043E0
	.byte 0x03, 0x43, 0x1A, 0x43, 0x10, 0x1C, 0x04, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xFF, 0xFF, 0x00, 0x00	; 038043F0
	.byte 0x00, 0x00, 0xC0, 0x03, 0x00, 0x00, 0x3F, 0x00, 0xFD, 0x43, 0x80, 0x03, 0x70, 0xB5, 0x05, 0x1C	; 03804400
	.byte 0x08, 0x24, 0x00, 0x26, 0x20, 0x1C, 0x29, 0x1C, 0x32, 0x1C, 0xFD, 0xF7, 0x91, 0xFD, 0x00, 0x28	; 03804410
	.byte 0xF8, 0xD1, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 03804418

; ===== function loc_03804418 =====
loc_03804418:
	push {r4,lr}	; 03804418
	add r4,r0,#0x0	; 0380441A
	mov r0,#0x0	; 0380441C
	bl loc_03804450	; 0380441E
	bic r0,r4	; 03804422
	lsl r0,r0,#0x18	; 03804424
	lsr r1,r0,#0x18	; 03804426
	mov r0,#0x0	; 03804428
	bl loc_038044D8	; 0380442A
	pop {r4}	; 0380442E
	pop {r3}	; 03804430
	bx r3	; 03804432

; ===== function loc_03804434 =====
loc_03804434:
	push {r4,lr}	; 03804434
	add r4,r0,#0x0	; 03804436
	mov r0,#0x0	; 03804438
	bl loc_03804450	; 0380443A
	add r1,r0,#0x0	; 0380443E
	orr r1,r4	; 03804440
	mov r0,#0x0	; 03804442
	bl loc_038044D8	; 03804444
	pop {r4}	; 03804448
	pop {r3}	; 0380444A
	bx r3	; 0380444C
	.byte 0x00, 0x00	; 03804450

; ===== function loc_03804450 =====
loc_03804450:
	push {r4,r5,r6,r7,lr}	; 03804450
	sub sp,#0x4	; 03804452
	add r5,r0,#0x0	; 03804454
	mov r7,#0x1	; 03804456
	ldr r4,[pool_038044D0]	; 03804458
	mov r6,#0x80	; 0380445A
	b loc_03804464	; 0380445C
loc_0380445E:
	add r0,r7,#0x0	; 0380445E
	bl loc_038048D4	; 03804460
loc_03804464:
	ldrh r0,[r4,#0x0]	; 03804464
	and r0,r6	; 03804466
	cmp r0,#0x0	; 03804468
	bne loc_0380445E	; 0380446A
	mov r0,#0x1	; 0380446C
	bl loc_0380453C	; 0380446E
	mov r4,#0x80	; 03804472
	orr r5,r4	; 03804474
	lsl r0,r5,#0x18	; 03804476
	lsr r1,r0,#0x18	; 03804478
	mov r0,#0xff	; 0380447A
	and r1,r0	; 0380447C
	ldr r0,[pool_038044D4]	; 0380447E
	strh r1,[r0,#0x0]	; 03804480
	mov r6,#0x1	; 03804482
	ldr r5,[pool_038044D0]	; 03804484
	b loc_0380448E	; 03804486
loc_03804488:
	add r0,r6,#0x0	; 03804488
	bl loc_038048D4	; 0380448A
loc_0380448E:
	ldrh r0,[r5,#0x0]	; 0380448E
	and r0,r4	; 03804490
	cmp r0,#0x0	; 03804492
	bne loc_03804488	; 03804494
	mov r0,#0x0	; 03804496
	bl loc_0380453C	; 03804498
	mov r1,#0x0	; 0380449C
	ldr r0,[pool_038044D4]	; 0380449E
	strh r1,[r0,#0x0]	; 038044A0
	mov r6,#0x1	; 038044A2
	ldr r5,[pool_038044D0]	; 038044A4
	mov r4,#0x80	; 038044A6
	b loc_038044B0	; 038044A8
loc_038044AA:
	add r0,r6,#0x0	; 038044AA
	bl loc_038048D4	; 038044AC
loc_038044B0:
	ldrh r0,[r5,#0x0]	; 038044B0
	and r0,r4	; 038044B2
	cmp r0,#0x0	; 038044B4
	bne loc_038044AA	; 038044B6
	ldr r0,[pool_038044D4]	; 038044B8
	ldrh r1,[r0,#0x0]	; 038044BA
	mov r0,#0xff	; 038044BC
	and r1,r0	; 038044BE
	lsl r0,r1,#0x10	; 038044C0
	lsr r0,r0,#0x10	; 038044C2
	lsl r0,r0,#0x18	; 038044C4
	lsr r0,r0,#0x18	; 038044C6
	add sp,#0x4	; 038044C8
	pop {r4,r5,r6,r7}	; 038044CA
	pop {r3}	; 038044CC
	bx r3	; 038044CE
pool_038044D0:
loc_038044D0:
	.word 0x040001C0	; 038044D0
pool_038044D4:
loc_038044D4:
	.word 0x040001C2	; 038044D4

; ===== function loc_038044D8 =====
loc_038044D8:
	push {r4,r5,r6,r7,lr}	; 038044D8
	sub sp,#0x4	; 038044DA
	add r5,r0,#0x0	; 038044DC
	add r4,r1,#0x0	; 038044DE
	ldr r6,[pool_03804534]	; 038044E0
	mov r7,#0x80	; 038044E2
	b loc_038044EC	; 038044E4
loc_038044E6:
	mov r0,#0x1	; 038044E6
	bl loc_038048D4	; 038044E8
loc_038044EC:
	ldrh r0,[r6,#0x0]	; 038044EC
	and r0,r7	; 038044EE
	cmp r0,#0x0	; 038044F0
	bne loc_038044E6	; 038044F2
	mov r0,#0x1	; 038044F4
	bl loc_0380453C	; 038044F6
	lsl r0,r5,#0x18	; 038044FA
	lsr r1,r0,#0x18	; 038044FC
	mov r0,#0xff	; 038044FE
	and r1,r0	; 03804500
	ldr r0,[pool_03804538]	; 03804502
	strh r1,[r0,#0x0]	; 03804504
	mov r7,#0x1	; 03804506
	ldr r5,[pool_03804534]	; 03804508
	mov r6,#0x80	; 0380450A
	b loc_03804514	; 0380450C
loc_0380450E:
	add r0,r7,#0x0	; 0380450E
	bl loc_038048D4	; 03804510
loc_03804514:
	ldrh r0,[r5,#0x0]	; 03804514
	and r0,r6	; 03804516
	cmp r0,#0x0	; 03804518
	bne loc_0380450E	; 0380451A
	mov r0,#0x0	; 0380451C
	bl loc_0380453C	; 0380451E
	mov r0,#0xff	; 03804522
	and r4,r0	; 03804524
	ldr r0,[pool_03804538]	; 03804526
	strh r4,[r0,#0x0]	; 03804528
	add sp,#0x4	; 0380452A
	pop {r4,r5,r6,r7}	; 0380452C
	pop {r3}	; 0380452E
	bx r3	; 03804530
	.byte 0xC0, 0x46	; 03804534
pool_03804534:
loc_03804534:
	.word 0x040001C0	; 03804534
pool_03804538:
loc_03804538:
	.word 0x040001C2	; 03804538

; ===== function loc_0380453C =====
loc_0380453C:
	lsl r1,r0,#0xb	; 0380453C
	ldr r0,[pool_03804548]	; 0380453E
	orr r1,r0	; 03804540
	ldr r0,[pool_0380454C]	; 03804542
	strh r1,[r0,#0x0]	; 03804544
	bx lr	; 03804546
pool_03804548:
loc_03804548:
	.word 0x00008002	; 03804548
pool_0380454C:
loc_0380454C:
	.word 0x040001C0	; 0380454C

; ===== function loc_03804550 =====
	push {r4,lr}	; 03804550
	add r4,r0,#0x0	; 03804552
	cmp r4,#0x1	; 03804554
	beq loc_03804562	; 03804556
	cmp r4,#0x2	; 03804558
	beq loc_03804572	; 0380455A
	cmp r4,#0x3	; 0380455C
	beq loc_0380456A	; 0380455E
	b loc_03804580	; 03804560
loc_03804562:
	mov r0,#0x10	; 03804562
	bl loc_03804418	; 03804564
	b loc_03804584	; 03804568
loc_0380456A:
	mov r0,#0x30	; 0380456A
	bl loc_03804434	; 0380456C
	b loc_03804584	; 03804570
loc_03804572:
	mov r0,#0x20	; 03804572
	bl loc_03804418	; 03804574
	mov r0,#0x10	; 03804578
	bl loc_03804434	; 0380457A
	b loc_03804584	; 0380457E
loc_03804580:
	bl loc_037FF1D4	; 03804580
loc_03804584:
	ldr r0,[pool_03804590]	; 03804584
	str r4,[r0,#0x0]	; 03804586
	pop {r4}	; 03804588
	pop {r3}	; 0380458A
	bx r3	; 0380458C
	.byte 0xC0, 0x46	; 03804590
pool_03804590:
loc_03804590:
	.word 0x03805304	; 03804590
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0F, 0x28, 0x5F, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04	; 038045A4
	.byte 0x00, 0x14, 0x78, 0x44, 0x00, 0x47, 0xB3, 0x00, 0x21, 0x00, 0x2F, 0x00, 0x3D, 0x00, 0x4B, 0x00	; 038045B4
	.byte 0x53, 0x00, 0x5B, 0x00, 0x63, 0x00, 0x6B, 0x00, 0x73, 0x00, 0x7B, 0x00, 0x83, 0x00, 0x8B, 0x00	; 038045C4
	.byte 0x93, 0x00, 0xA3, 0x00, 0x9B, 0x00, 0x01, 0x20, 0x00, 0xF0, 0xF6, 0xF8, 0x01, 0x20, 0xFF, 0xF7	; 038045D4
	.byte 0xBD, 0xFF, 0x41, 0xE0, 0x03, 0x20, 0x00, 0xF0, 0xEF, 0xF8, 0x03, 0x20, 0xFF, 0xF7, 0xB6, 0xFF	; 038045E4
	.byte 0x3A, 0xE0, 0x02, 0x20, 0x00, 0xF0, 0xE8, 0xF8, 0x02, 0x20, 0xFF, 0xF7, 0xAF, 0xFF, 0x33, 0xE0	; 038045F4
	.byte 0x04, 0x20, 0xFF, 0xF7, 0x1D, 0xFF, 0x2F, 0xE0, 0x04, 0x20, 0xFF, 0xF7, 0x0B, 0xFF, 0x2B, 0xE0	; 03804604
	.byte 0x08, 0x20, 0xFF, 0xF7, 0x15, 0xFF, 0x27, 0xE0, 0x08, 0x20, 0xFF, 0xF7, 0x03, 0xFF, 0x23, 0xE0	; 03804614
	.byte 0x0C, 0x20, 0xFF, 0xF7, 0x0D, 0xFF, 0x1F, 0xE0, 0x0C, 0x20, 0xFF, 0xF7, 0xFB, 0xFE, 0x1B, 0xE0	; 03804624
	.byte 0x01, 0x20, 0xFF, 0xF7, 0x05, 0xFF, 0x17, 0xE0, 0x01, 0x20, 0xFF, 0xF7, 0xF3, 0xFE, 0x13, 0xE0	; 03804634
	.byte 0x02, 0x20, 0xFF, 0xF7, 0xFD, 0xFE, 0x0F, 0xE0, 0x02, 0x20, 0xFF, 0xF7, 0xEB, 0xFE, 0x0B, 0xE0	; 03804644
	.byte 0x40, 0x20, 0xFF, 0xF7, 0xE7, 0xFE, 0x07, 0xE0, 0xFA, 0xF7, 0x14, 0xFF, 0x01, 0x20, 0xFF, 0xF7	; 03804654
	.byte 0xE1, 0xFE, 0x40, 0x20, 0xFF, 0xF7, 0xEC, 0xFE, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 03804664
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x43, 0x49, 0x0C, 0x88, 0x00, 0x20, 0x08, 0x80, 0xF9, 0xF7, 0x36, 0xFB	; 03804674
	.byte 0x06, 0x1C, 0x41, 0x48, 0xF9, 0xF7, 0xF4, 0xF9, 0x07, 0x1C, 0x00, 0x20, 0xFF, 0xF7, 0xE6, 0xFE	; 03804684
	.byte 0x00, 0x90, 0x02, 0x20, 0x00, 0xF0, 0x98, 0xF8, 0x02, 0x20, 0xFF, 0xF7, 0x5F, 0xFF, 0x02, 0x20	; 03804694
	.byte 0xFF, 0xF7, 0x5C, 0xFF, 0xFA, 0xF7, 0xEE, 0xFE, 0x01, 0x20, 0xFF, 0xF7, 0xBB, 0xFE, 0x37, 0x48	; 038046A4
	.byte 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x08, 0xD0, 0x35, 0x48, 0x01, 0x88, 0x35, 0x48	; 038046B4
	.byte 0x01, 0x43, 0x35, 0x48, 0x01, 0x80, 0x35, 0x48, 0xF9, 0xF7, 0xE8, 0xF9, 0x2F, 0x48, 0x01, 0x88	; 038046C4
	.byte 0x04, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x31, 0x48, 0xF9, 0xF7, 0xDF, 0xF9, 0x2B, 0x48	; 038046D4
	.byte 0x01, 0x88, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x0F, 0xD0, 0x2E, 0x48, 0x05, 0x88, 0x2E, 0x48	; 038046E4
	.byte 0xFD, 0xF7, 0x2E, 0xFD, 0x40, 0x20, 0x00, 0x21, 0xFD, 0xF7, 0x34, 0xFD, 0x2B, 0x48, 0x01, 0x1C	; 038046F4
	.byte 0xFD, 0xF7, 0x30, 0xFD, 0x80, 0x20, 0xF9, 0xF7, 0xC9, 0xF9, 0x20, 0x48, 0x01, 0x88, 0x08, 0x20	; 03804704
	.byte 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x26, 0x48, 0xF9, 0xF7, 0xC0, 0xF9, 0x1B, 0x48, 0x01, 0x88	; 03804714
	.byte 0x10, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x22, 0x48, 0xF9, 0xF7, 0xB7, 0xF9, 0x30, 0x1C	; 03804724
	.byte 0xF9, 0xF7, 0xEE, 0xFA, 0x13, 0x49, 0x08, 0x88, 0x01, 0x20, 0x08, 0x80, 0x00, 0xF0, 0xDF, 0xF8	; 03804734
	.byte 0x00, 0x20, 0x00, 0x99, 0xFF, 0xF7, 0xCE, 0xFE, 0x16, 0x48, 0x05, 0x80, 0x01, 0x20, 0xFF, 0xF7	; 03804744
	.byte 0x77, 0xFE, 0xFA, 0xF7, 0x7D, 0xFE, 0x00, 0x21, 0x17, 0x48, 0x01, 0x62, 0x62, 0x20, 0x0A, 0x1C	; 03804754
	.byte 0xFF, 0xF7, 0x3C, 0xFE, 0xF9, 0xF7, 0xC2, 0xFA, 0x38, 0x1C, 0xF9, 0xF7, 0x97, 0xF9, 0x30, 0x1C	; 03804764
	.byte 0xF9, 0xF7, 0xCE, 0xFA, 0x03, 0x49, 0x08, 0x88, 0x0C, 0x80, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 03804774
	.byte 0x18, 0x47, 0xC0, 0x46, 0x08, 0x02, 0x00, 0x04, 0xFF, 0xFF, 0xFF, 0x01, 0x34, 0x7A, 0x80, 0x03	; 03804784
	.byte 0x30, 0x7A, 0x80, 0x03, 0x00, 0x40, 0x00, 0x00, 0x32, 0x01, 0x00, 0x04, 0x00, 0x10, 0x00, 0x00	; 03804794
	.byte 0x00, 0x00, 0x40, 0x00, 0x34, 0x01, 0x00, 0x04, 0x00, 0x80, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00	; 038047A4
	.byte 0x00, 0x00, 0x10, 0x00, 0x00, 0x20, 0x00, 0x00, 0x3C, 0x7A, 0x80, 0x03	; 038047B0

; ===== function loc_038047B0 =====
loc_038047B0:
	ldr r0,[pool_038047B8]	; 038047B0
	ldr r0,[r0,#0x0]	; 038047B2
	bx lr	; 038047B4
	.byte 0xC0, 0x46	; 038047B8
pool_038047B8:
loc_038047B8:
	.word 0x03807A6C	; 038047B8

; ===== function loc_038047BC =====
loc_038047BC:
	cmp r0,#0xf	; 038047BC
	bgt loc_038047CA	; 038047BE
	ldr r1,[pool_038047CC]	; 038047C0
	str r0,[r1,#0x0]	; 038047C2
	mov r1,#0x0	; 038047C4
	ldr r0,[pool_038047D0]	; 038047C6
	str r1,[r0,#0x0]	; 038047C8
loc_038047CA:
	bx lr	; 038047CA
pool_038047CC:
loc_038047CC:
	.word 0x03807A6C	; 038047CC
pool_038047D0:
loc_038047D0:
	.word 0x03807A68	; 038047D0

; ===== function loc_038047D4 =====
loc_038047D4:
	push {r4,r5,r6,lr}	; 038047D4
	ldr r0,[pool_03804874]	; 038047D6
	ldr r3,[r0,#0x0]	; 038047D8
	cmp r3,#0x0	; 038047DA
	bne loc_038047F6	; 038047DC
	mov r0,#0x3	; 038047DE
	mov r1,#0x66	; 038047E0
	mov r2,#0x1	; 038047E2
	add r3,r2,#0x0	; 038047E4
	bl loc_03802D90	; 038047E6
	cmp r0,#0x0	; 038047EA
	beq loc_0380486C	; 038047EC
	mov r0,#0x1	; 038047EE
	bl loc_038047BC	; 038047F0
	b loc_0380486C	; 038047F4
loc_038047F6:
	cmp r3,#0x4	; 038047F6
	bge loc_0380480E	; 038047F8
	ldr r0,[pool_03804878]	; 038047FA
	ldr r0,[r0,#0x0]	; 038047FC
	cmp r3,r0	; 038047FE
	beq loc_0380486C	; 03804800
	mov r0,#0x3	; 03804802
	mov r1,#0x66	; 03804804
	mov r2,#0x1	; 03804806
	bl loc_03802D90	; 03804808
	b loc_0380486C	; 0380480C
loc_0380480E:
	ldr r6,[pool_0380487C]	; 0380480E
	sub r4,r3,#0x4	; 03804810
	mov r0,#0xc	; 03804812
	mul r4,r0	; 03804814
	add r5,r6,r4	; 03804816
	ldr r0,[pool_03804880]	; 03804818
	ldr r0,[r0,#0x0]	; 0380481A
	ldrh r1,[r5,#0xa]	; 0380481C
	bl loc_0380323C	; 0380481E
	add r2,r0,#0x0	; 03804822
	mov r0,#0x0	; 03804824
	ldr r1,[pool_03804884]	; 03804826
	bl loc_037FF928	; 03804828
	ldr r3,[r6,r4]	; 0380482C
	ldr r2,[r5,#0x4]	; 0380482E
	and r2,r1	; 03804830
	and r3,r0	; 03804832
	mov r0,#0x0	; 03804834
	eor r2,r0	; 03804836
	eor r3,r0	; 03804838
	orr r2,r3	; 0380483A
	beq loc_03804842	; 0380483C
	mov r3,#0x1	; 0380483E
	b loc_03804844	; 03804840
loc_03804842:
	mov r3,#0x2	; 03804842
loc_03804844:
	ldr r0,[pool_03804880]	; 03804844
	ldr r1,[r0,#0x0]	; 03804846
	add r4,r1,#0x1	; 03804848
	str r4,[r0,#0x0]	; 0380484A
	ldrh r2,[r5,#0x8]	; 0380484C
	ldrh r1,[r5,#0xa]	; 0380484E
	mul r2,r1	; 03804850
	cmp r4,r2	; 03804852
	bcc loc_0380485A	; 03804854
	mov r1,#0x0	; 03804856
	str r1,[r0,#0x0]	; 03804858
loc_0380485A:
	ldr r0,[pool_03804878]	; 0380485A
	ldr r0,[r0,#0x0]	; 0380485C
	cmp r3,r0	; 0380485E
	beq loc_0380486C	; 03804860
	mov r0,#0x3	; 03804862
	mov r1,#0x66	; 03804864
	mov r2,#0x1	; 03804866
	bl loc_03802D90	; 03804868
loc_0380486C:
	pop {r4,r5,r6}	; 0380486C
	pop {r3}	; 0380486E
	bx r3	; 03804870
	.byte 0xC0, 0x46	; 03804874
pool_03804874:
loc_03804874:
	.word 0x03807A6C	; 03804874
pool_03804878:
loc_03804878:
	.word 0x03805304	; 03804878
pool_0380487C:
loc_0380487C:
	.word 0x03805308	; 0380487C
pool_03804880:
loc_03804880:
	.word 0x03807A68	; 03804880
pool_03804884:
loc_03804884:
	.word 0x80000000	; 03804884

; ===== function loc_03804888 =====
loc_03804888:
	push {lr}	; 03804888
	sub sp,#0x4	; 0380488A
	mov r0,#0x0	; 0380488C
	str r0,[sp,#0x0]	; 0380488E
	add r0,sp,#0x0	; 03804890
	ldr r1,[pool_038048A8]	; 03804892
	ldr r2,[pool_038048AC]	; 03804894
	bl loc_03804914	; 03804896
	bl loc_037FAFEC	; 0380489A
	ldr r1,[pool_038048A8]	; 0380489E
	strh r0,[r1,#0x2]	; 038048A0
	add sp,#0x4	; 038048A2
	pop {r3}	; 038048A4
	bx r3	; 038048A6
pool_038048A8:
loc_038048A8:
	.word 0x03807A70	; 038048A8
pool_038048AC:
loc_038048AC:
	.word 0x05000001	; 038048AC

; ===== function loc_038048B0 =====
loc_038048B0:
	push {lr}	; 038048B0
	sub sp,#0x4	; 038048B2
	ldr r0,[pool_038048CC]	; 038048B4
	ldr r1,[r0,#0x0]	; 038048B6
	cmp r1,#0x0	; 038048B8
	bne loc_038048C4	; 038048BA
	mov r1,#0x1	; 038048BC
	str r1,[r0,#0x0]	; 038048BE
	bl loc_03804888	; 038048C0
loc_038048C4:
	add sp,#0x4	; 038048C4
	pop {r3}	; 038048C6
	bx r3	; 038048C8
	.byte 0xC0, 0x46	; 038048CC
pool_038048CC:
loc_038048CC:
	.word 0x03807A74	; 038048CC
	.byte 0x00, 0xDF, 0x70, 0x47	; 038048D4

; ===== function loc_038048D4 =====
loc_038048D4:
	swi 0x3	; 038048D4
	bx lr	; 038048D6
	.byte 0x02, 0x4A, 0x94, 0x46, 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04	; 038048E8
	.byte 0x00, 0x22, 0x05, 0xDF, 0x70, 0x47	; 038048EE

; ===== function loc_038048EE =====
loc_038048EE:
	swi 0x6	; 038048EE
	bx lr	; 038048F0
	.byte 0x07, 0xDF, 0x70, 0x47, 0x08, 0xDF, 0x70, 0x47	; 038048FA

; ===== function loc_038048FA =====
loc_038048FA:
	add r1,r0,#0x0	; 038048FA
	mov r0,#0x1	; 038048FC
	swi 0x8	; 038048FE
	bx lr	; 03804900

; ===== function loc_03804902 =====
loc_03804902:
	add r1,r0,#0x0	; 03804902
	mov r0,#0x0	; 03804904
	swi 0x8	; 03804906
	bx lr	; 03804908
	.byte 0x09, 0xDF, 0x70, 0x47, 0x09, 0xDF, 0x08, 0x1C, 0x70, 0x47	; 03804914

; ===== function loc_03804914 =====
loc_03804914:
	swi 0xb	; 03804914
	bx lr	; 03804916

; ===== function loc_03804918 =====
loc_03804918:
	swi 0xc	; 03804918
	bx lr	; 0380491A
	.byte 0x0D, 0xDF, 0x70, 0x47, 0x0E, 0xDF, 0x70, 0x47, 0x0F, 0xDF, 0x70, 0x47, 0x10, 0xDF, 0x70, 0x47	; 0380492C
	.byte 0x11, 0xDF, 0x70, 0x47, 0x12, 0xDF, 0x70, 0x47, 0x13, 0xDF, 0x70, 0x47, 0x14, 0xDF, 0x70, 0x47	; 0380493C
	.byte 0x15, 0xDF, 0x70, 0x47, 0x1A, 0xDF, 0x70, 0x47	; 03804944

; ===== function loc_03804944 =====
loc_03804944:
	swi 0x1b	; 03804944
	bx lr	; 03804946

; ===== function loc_03804948 =====
loc_03804948:
	swi 0x1c	; 03804948
	bx lr	; 0380494A
.arm

; ===== function loc_0380494C =====
loc_0380494C:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0380494C
	mov r4,#0x0	; 03804950
	b loc_03804960	; 03804954
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 03804960
loc_03804960:
	orrs r5,r3,r2	; 03804960
	bne loc_03804970	; 03804964
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804968
	bx lr	; 0380496C
loc_03804970:
	orrs r5,r1,r3	; 03804970
	bne loc_03804A18	; 03804974
	mov r1,r2	; 03804978
	bl loc_03804DB8	; 0380497C
	cmp r4,#0x0	; 03804980
	movne r0,r1	; 03804984
	mov r1,#0x0	; 03804988
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0380498C
	bx lr	; 03804990
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 038049A4

; ===== function loc_038049A4 =====
loc_038049A4:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049A4
	eor r4,r1,r3	; 038049A8
	mov r4,r4, asr #0x1	; 038049AC
	mov r4,r4, lsl #0x1	; 038049B0
	orrs r5,r3,r2	; 038049B4
	bne loc_038049C4	; 038049B8
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049BC
	bx lr	; 038049C0
loc_038049C4:
	mov r5,r0, lsr #0x1f	; 038049C4
	add r5,r5,r1	; 038049C8
	mov r6,r2, lsr #0x1f	; 038049CC
	add r6,r6,r3	; 038049D0
	orrs r6,r5,r6	; 038049D4
	bne loc_038049F8	; 038049D8
	mov r1,r2	; 038049DC
	bl loc_03804BA4	; 038049E0
	ands r4,r4,#0x1	; 038049E4
	movne r0,r1	; 038049E8
	mov r1,r0, asr #0x1f	; 038049EC
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 038049F0
	bx lr	; 038049F4
loc_038049F8:
	cmp r1,#0x0	; 038049F8
	bge loc_03804A08	; 038049FC
	rsbs r0,r0,#0x0	; 03804A00
	rsc r1,r1,#0x0	; 03804A04
loc_03804A08:
	cmp r3,#0x0	; 03804A08
	bge loc_03804A18	; 03804A0C
	rsbs r2,r2,#0x0	; 03804A10
	rsc r3,r3,#0x0	; 03804A14
loc_03804A18:
	orrs r5,r1,r0	; 03804A18
	beq loc_03804B3C	; 03804A1C
	mov r5,#0x0	; 03804A20
	mov r6,#0x1	; 03804A24
	cmp r3,#0x0	; 03804A28
	bmi loc_03804A44	; 03804A2C
loc_03804A30:
	add r5,r5,#0x1	; 03804A30
	adds r2,r2,r2	; 03804A34
	adcs r3,r3,r3	; 03804A38
	bpl loc_03804A30	; 03804A3C
	add r6,r6,r5	; 03804A40
loc_03804A44:
	cmp r1,#0x0	; 03804A44
	blt loc_03804A64	; 03804A48
loc_03804A4C:
	cmp r6,#0x1	; 03804A4C
	beq loc_03804A64	; 03804A50
	sub r6,r6,#0x1	; 03804A54
	adds r0,r0,r0	; 03804A58
	adcs r1,r1,r1	; 03804A5C
	bpl loc_03804A4C	; 03804A60
loc_03804A64:
	mov r7,#0x0	; 03804A64
	mov r12,#0x0	; 03804A68
	mov r11,#0x0	; 03804A6C
	b loc_03804A8C	; 03804A70
loc_03804A74:
	orr r12,r12,#0x1	; 03804A74
	subs r6,r6,#0x1	; 03804A78
	beq loc_03804AE4	; 03804A7C
	adds r0,r0,r0	; 03804A80
	adcs r1,r1,r1	; 03804A84
	adcs r7,r7,r7	; 03804A88
loc_03804A8C:
	subs r0,r0,r2	; 03804A8C
	sbcs r1,r1,r3	; 03804A90
	sbcs r7,r7,#0x0	; 03804A94
	adds r12,r12,r12	; 03804A98
	adc r11,r11,r11	; 03804A9C
	cmp r7,#0x0	; 03804AA0
	bge loc_03804A74	; 03804AA4
loc_03804AA8:
	subs r6,r6,#0x1	; 03804AA8
	beq loc_03804ADC	; 03804AAC
	adds r0,r0,r0	; 03804AB0
	adcs r1,r1,r1	; 03804AB4
	adc r7,r7,r7	; 03804AB8
	adds r0,r0,r2	; 03804ABC
	adcs r1,r1,r3	; 03804AC0
	adc r7,r7,#0x0	; 03804AC4
	adds r12,r12,r12	; 03804AC8
	adc r11,r11,r11	; 03804ACC
	cmp r7,#0x0	; 03804AD0
	bge loc_03804A74	; 03804AD4
	b loc_03804AA8	; 03804AD8
loc_03804ADC:
	adds r0,r0,r2	; 03804ADC
	adc r1,r1,r3	; 03804AE0
loc_03804AE4:
	ands r7,r4,#0x1	; 03804AE4
	moveq r0,r12	; 03804AE8
	moveq r1,r11	; 03804AEC
	beq loc_03804B1C	; 03804AF0
	subs r7,r5,#0x20	; 03804AF4
	movge r0,r1, lsr r7	; 03804AF8
	bge loc_03804B40	; 03804AFC
	rsb r7,r5,#0x20	; 03804B00
	mov r0,r0, lsr r5	; 03804B04
	orr r0,r0,r1, lsl r7	; 03804B08
	mov r1,r1, lsr r5	; 03804B0C
	b loc_03804B1C	; 03804B10
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 03804B1C
loc_03804B1C:
	cmp r4,#0x0	; 03804B1C
	blt loc_03804B2C	; 03804B20
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B24
	bx lr	; 03804B28
loc_03804B2C:
	rsbs r0,r0,#0x0	; 03804B2C
	rsc r1,r1,#0x0	; 03804B30
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B34
	bx lr	; 03804B38
loc_03804B3C:
	mov r0,#0x0	; 03804B3C
loc_03804B40:
	mov r1,#0x0	; 03804B40
	cmp r4,#0x0	; 03804B44
	blt loc_03804B2C	; 03804B48
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 03804B4C
	bx lr	; 03804B50

; ===== function loc_03804B54 =====
loc_03804B54:
	stmdb sp!,{r4,r5,lr}	; 03804B54
	umull r5,r4,r0,r2	; 03804B58
	mla r4,r0,r3,r4	; 03804B5C
	mla r4,r2,r1,r4	; 03804B60
	mov r1,r4	; 03804B64
	mov r0,r5	; 03804B68
	ldmia sp!,{r4,r5,lr}	; 03804B6C
	bx lr	; 03804B70

; ===== function loc_03804B74 =====
loc_03804B74:
	ands r2,r2,#0x3f	; 03804B74
	bxeq lr	; 03804B78
	subs r3,r2,#0x20	; 03804B7C
	bge loc_03804B98	; 03804B80
	rsb r3,r2,#0x20	; 03804B84
	mov r1,r1, lsl r2	; 03804B88
	orr r1,r1,r0, lsr r3	; 03804B8C
	mov r0,r0, lsl r2	; 03804B90
	bx lr	; 03804B94
loc_03804B98:
	mov r1,r0, lsl r3	; 03804B98
	mov r0,#0x0	; 03804B9C
	bx lr	; 03804BA0

; ===== function loc_03804BA4 =====
loc_03804BA4:
	eor r12,r0,r1	; 03804BA4
	and r12,r12,#0x80000000	; 03804BA8
	cmp r0,#0x0	; 03804BAC
	rsblt r0,r0,#0x0	; 03804BB0
	addlt r12,r12,#0x1	; 03804BB4
	cmp r1,#0x0	; 03804BB8
	rsblt r1,r1,#0x0	; 03804BBC
	beq loc_03804D9C	; 03804BC0
	cmp r0,r1	; 03804BC4
	movcc r1,r0	; 03804BC8
	movcc r0,#0x0	; 03804BCC
	bcc loc_03804D9C	; 03804BD0
	mov r2,#0x1c	; 03804BD4
	mov r3,r0, lsr #0x4	; 03804BD8
	cmp r1,r3, lsr #0xc	; 03804BDC
	suble r2,r2,#0x10	; 03804BE0
	movle r3,r3, lsr #0x10	; 03804BE4
	cmp r1,r3, lsr #0x4	; 03804BE8
	suble r2,r2,#0x8	; 03804BEC
	movle r3,r3, lsr #0x8	; 03804BF0
	cmp r1,r3	; 03804BF4
	suble r2,r2,#0x4	; 03804BF8
	movle r3,r3, lsr #0x4	; 03804BFC
	mov r0,r0, lsl r2	; 03804C00
	rsb r1,r1,#0x0	; 03804C04
	adds r0,r0,r0	; 03804C08
	add r2,r2,r2, lsl #0x1	; 03804C0C
	add pc,pc,r2, lsl #0x2	; 03804C10
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804C18
loc_03804C18:
	adcs r3,r1,r3, lsl #0x1	; 03804C18
	subcc r3,r3,r1	; 03804C1C
	adcs r0,r0,r0	; 03804C20
	adcs r3,r1,r3, lsl #0x1	; 03804C24
	subcc r3,r3,r1	; 03804C28
	adcs r0,r0,r0	; 03804C2C
	adcs r3,r1,r3, lsl #0x1	; 03804C30
	subcc r3,r3,r1	; 03804C34
	adcs r0,r0,r0	; 03804C38
	adcs r3,r1,r3, lsl #0x1	; 03804C3C
	subcc r3,r3,r1	; 03804C40
	adcs r0,r0,r0	; 03804C44
loc_03804C48:
	adcs r3,r1,r3, lsl #0x1	; 03804C48
	subcc r3,r3,r1	; 03804C4C
	adcs r0,r0,r0	; 03804C50
	adcs r3,r1,r3, lsl #0x1	; 03804C54
	subcc r3,r3,r1	; 03804C58
	adcs r0,r0,r0	; 03804C5C
	adcs r3,r1,r3, lsl #0x1	; 03804C60
	subcc r3,r3,r1	; 03804C64
	adcs r0,r0,r0	; 03804C68
	adcs r3,r1,r3, lsl #0x1	; 03804C6C
	subcc r3,r3,r1	; 03804C70
	adcs r0,r0,r0	; 03804C74
loc_03804C78:
	adcs r3,r1,r3, lsl #0x1	; 03804C78
	subcc r3,r3,r1	; 03804C7C
	adcs r0,r0,r0	; 03804C80
	adcs r3,r1,r3, lsl #0x1	; 03804C84
	subcc r3,r3,r1	; 03804C88
	adcs r0,r0,r0	; 03804C8C
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
	adcs r3,r1,r3, lsl #0x1	; 03804CC0
	subcc r3,r3,r1	; 03804CC4
	adcs r0,r0,r0	; 03804CC8
	adcs r3,r1,r3, lsl #0x1	; 03804CCC
	subcc r3,r3,r1	; 03804CD0
	adcs r0,r0,r0	; 03804CD4
loc_03804CD8:
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
	mov r1,r3	; 03804D98
loc_03804D9C:
	ands r3,r12,#0x80000000	; 03804D9C
	rsbne r0,r0,#0x0	; 03804DA0
	ands r3,r12,#0x1	; 03804DA4
	rsbne r1,r1,#0x0	; 03804DA8
	bx lr	; 03804DAC

; ===== function loc_03804DB0 =====
loc_03804DB0:
	cmp r1,#0x0	; 03804DB0
	bxeq lr	; 03804DB4

; ===== function loc_03804DB8 =====
loc_03804DB8:
	cmp r0,r1	; 03804DB8
	movcc r1,r0	; 03804DBC
	movcc r0,#0x0	; 03804DC0
	bxcc lr	; 03804DC4
	mov r2,#0x1c	; 03804DC8
	mov r3,r0, lsr #0x4	; 03804DCC
	cmp r1,r3, lsr #0xc	; 03804DD0
	suble r2,r2,#0x10	; 03804DD4
	movle r3,r3, lsr #0x10	; 03804DD8
	cmp r1,r3, lsr #0x4	; 03804DDC
	suble r2,r2,#0x8	; 03804DE0
	movle r3,r3, lsr #0x8	; 03804DE4
	cmp r1,r3	; 03804DE8
	suble r2,r2,#0x4	; 03804DEC
	movle r3,r3, lsr #0x4	; 03804DF0
	mov r0,r0, lsl r2	; 03804DF4
	rsb r1,r1,#0x0	; 03804DF8
	adds r0,r0,r0	; 03804DFC
	add r2,r2,r2, lsl #0x1	; 03804E00
	add pc,pc,r2, lsl #0x2	; 03804E04
	.byte 0x00, 0x00, 0xA0, 0xE1	; 03804E0C
loc_03804E0C:
	adcs r3,r1,r3, lsl #0x1	; 03804E0C
	subcc r3,r3,r1	; 03804E10
	adcs r0,r0,r0	; 03804E14
	adcs r3,r1,r3, lsl #0x1	; 03804E18
	subcc r3,r3,r1	; 03804E1C
	adcs r0,r0,r0	; 03804E20
	adcs r3,r1,r3, lsl #0x1	; 03804E24
	subcc r3,r3,r1	; 03804E28
	adcs r0,r0,r0	; 03804E2C
	adcs r3,r1,r3, lsl #0x1	; 03804E30
	subcc r3,r3,r1	; 03804E34
	adcs r0,r0,r0	; 03804E38
loc_03804E3C:
	adcs r3,r1,r3, lsl #0x1	; 03804E3C
	subcc r3,r3,r1	; 03804E40
	adcs r0,r0,r0	; 03804E44
	adcs r3,r1,r3, lsl #0x1	; 03804E48
	subcc r3,r3,r1	; 03804E4C
	adcs r0,r0,r0	; 03804E50
	adcs r3,r1,r3, lsl #0x1	; 03804E54
	subcc r3,r3,r1	; 03804E58
	adcs r0,r0,r0	; 03804E5C
	adcs r3,r1,r3, lsl #0x1	; 03804E60
	subcc r3,r3,r1	; 03804E64
	adcs r0,r0,r0	; 03804E68
loc_03804E6C:
	adcs r3,r1,r3, lsl #0x1	; 03804E6C
	subcc r3,r3,r1	; 03804E70
	adcs r0,r0,r0	; 03804E74
	adcs r3,r1,r3, lsl #0x1	; 03804E78
	subcc r3,r3,r1	; 03804E7C
	adcs r0,r0,r0	; 03804E80
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
	adcs r3,r1,r3, lsl #0x1	; 03804EB4
	subcc r3,r3,r1	; 03804EB8
	adcs r0,r0,r0	; 03804EBC
	adcs r3,r1,r3, lsl #0x1	; 03804EC0
	subcc r3,r3,r1	; 03804EC4
	adcs r0,r0,r0	; 03804EC8
loc_03804ECC:
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
	mov r1,r3	; 03804F8C
	bx lr	; 03804F90

; ===== function loc_03804F94 =====
loc_03804F94:
	ands r2,r2,#0x3f	; 03804F94
	bxeq lr	; 03804F98
	subs r3,r2,#0x20	; 03804F9C
	bge loc_03804FB8	; 03804FA0
	rsb r3,r2,#0x20	; 03804FA4
	mov r0,r0, lsr r2	; 03804FA8
	orr r0,r0,r1, lsl r3	; 03804FAC
	mov r1,r1, lsr r2	; 03804FB0
	bx lr	; 03804FB4
loc_03804FB8:
	mov r0,r1, lsr r3	; 03804FB8
	mov r1,#0x0	; 03804FBC
	bx lr	; 03804FC0

; ===== function loc_03804FC4 =====
loc_03804FC4:
	stmdb sp!,{lr}	; 03804FC4
	bl loc_0380506C	; 03804FC8
	mov r1,#0x0	; 03804FCC
	str r1,[r0,#0x0]	; 03804FD0
	bl loc_03805078	; 03804FD4
	mov r1,#0x0	; 03804FD8
	str r1,[r0,#0x4]	; 03804FDC
	str r1,[r0,#0x8]	; 03804FE0
	str r1,[r0,#0xc]	; 03804FE4
	str r1,[r0,#0x10]	; 03804FE8
	str r1,[r0,#0x14]	; 03804FEC
	ldmia sp!,{lr}	; 03804FF0
	bx lr	; 03804FF4
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x1A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805008
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03805018
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 03805028
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 03805038
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x0A, 0x00, 0x00, 0xEB, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 03805048
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 03805058
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 03805068
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0380506C

; ===== function loc_0380506C =====
loc_0380506C:
	ldr r12,[pool_03805074]	; 0380506C
	bx r12	; 03805070
pool_03805074:
loc_03805074:
	.word 0x038050BD	; 03805074

; ===== function loc_03805078 =====
loc_03805078:
	ldr r12,[pool_03805080]	; 03805078
	bx r12	; 0380507C
pool_03805080:
loc_03805080:
	.word 0x038050C5	; 03805080
.thumb

; ===== function loc_03805084 =====
loc_03805084:
	bx r0	; 03805084
	.byte 0x00, 0x00	; 03805088

; ===== function loc_03805088 =====
loc_03805088:
	bx r1	; 03805088
	.byte 0x00, 0x00	; 0380508C

; ===== function loc_0380508C =====
loc_0380508C:
	bx r2	; 0380508C
	.byte 0x00, 0x00	; 03805090

; ===== function loc_03805090 =====
loc_03805090:
	bx r3	; 03805090
	.byte 0x00, 0x00	; 03805094

; ===== function loc_03805094 =====
loc_03805094:
	bx r4	; 03805094
	.byte 0x00, 0x00	; 03805098

; ===== function loc_03805098 =====
loc_03805098:
	bx r5	; 03805098
	.byte 0x00, 0x00	; 0380509C

; ===== function loc_0380509C =====
loc_0380509C:
	push {r4,lr}	; 0380509C
	ldr r4,[pool_038050B8]	; 0380509E
	b loc_038050A6	; 038050A0
loc_038050A2:
	.byte 0x80, 0x47, 0x24, 0x1D	; 038050A6
loc_038050A6:
	cmp r4,#0x0	; 038050A6
	beq loc_038050B0	; 038050A8
	ldr r0,[r4,#0x0]	; 038050AA
	cmp r0,#0x0	; 038050AC
	bne loc_038050A2	; 038050AE
loc_038050B0:
	pop {r4}	; 038050B0
	pop {r3}	; 038050B2
	bx r3	; 038050B4
	.byte 0xC0, 0x46	; 038050B8
pool_038050B8:
loc_038050B8:
	.word 0x03805248	; 038050B8

; ===== function loc_038050BC =====
loc_038050BC:
	ldr r0,[pool_038050C0]	; 038050BC
	bx lr	; 038050BE
pool_038050C0:
loc_038050C0:
	.word 0x03807A78	; 038050C0

; ===== function loc_038050C4 =====
loc_038050C4:
	ldr r0,[pool_038050C8]	; 038050C4
	bx lr	; 038050C6
pool_038050C8:
loc_038050C8:
	.word 0x03807A7C	; 038050C8
	.byte 0x9D, 0x50, 0x80, 0x03, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x49, 0x32, 0x00, 0x00	; 038050DC
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C, 0x00, 0x28, 0x01, 0xE4	; 038050EC
	.byte 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C, 0x01, 0x88, 0x00, 0x44	; 038050FC
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B, 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55	; 0380510C
	.byte 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73, 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F	; 0380511C
	.byte 0x7F, 0x00, 0x00, 0x00, 0x2D, 0xFD, 0x2E, 0xFD, 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD	; 0380512C
	.byte 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE, 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE	; 0380513C
	.byte 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE, 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE	; 0380514C
	.byte 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE, 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE	; 0380515C
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF, 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF	; 0380516C
	.byte 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF, 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF	; 0380517C
	.byte 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF, 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF	; 0380518C
	.byte 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF, 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF	; 0380519C
	.byte 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF, 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF	; 038051AC
	.byte 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF	; 038051BC
	.byte 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF	; 038051CC
	.byte 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF	; 038051DC
	.byte 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF	; 038051EC
	.byte 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF	; 038051FC
	.byte 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF	; 0380520C
	.byte 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF	; 0380521C
	.byte 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x01, 0x02, 0x04, 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01	; 0380522C
	.byte 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D, 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F	; 0380523C
	.byte 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F, 0x84, 0x89, 0x8F, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380524C
	.byte 0x8C, 0x5A, 0x80, 0x03, 0xB0, 0x5A, 0x80, 0x03, 0x98, 0x53, 0x80, 0x03, 0x98, 0x53, 0x80, 0x03	; 0380525C
	.byte 0x94, 0x7A, 0x80, 0x03, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00	; 0380526C
	.byte 0x05, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0xD9, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03	; 0380527C
	.byte 0x3D, 0xDA, 0x7F, 0x03, 0xA5, 0xD9, 0x7F, 0x03, 0x99, 0xD9, 0x7F, 0x03, 0x8D, 0xD9, 0x7F, 0x03	; 0380528C
	.byte 0x81, 0xD9, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0xD5, 0xD9, 0x7F, 0x03, 0xC9, 0xD9, 0x7F, 0x03	; 0380529C
	.byte 0xBD, 0xD9, 0x7F, 0x03, 0xB1, 0xD9, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03	; 038052AC
	.byte 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03	; 038052BC
	.byte 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03	; 038052CC
	.byte 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x3D, 0xDA, 0x7F, 0x03, 0x0D, 0xDE, 0x7F, 0x03	; 038052DC
	.byte 0x78, 0x56, 0x34, 0x12, 0x46, 0x61, 0x69, 0x6C, 0x65, 0x64, 0x20, 0x73, 0x6F, 0x75, 0x6E, 0x64	; 038052EC
	.byte 0x20, 0x61, 0x6C, 0x61, 0x72, 0x6D, 0x20, 0x4F, 0x53, 0x5F, 0x53, 0x65, 0x6E, 0x64, 0x4D, 0x65	; 038052FC
	.byte 0x73, 0x73, 0x61, 0x67, 0x65, 0x0A, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380530C
	.byte 0x00, 0x00, 0x00, 0xAA, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xCC	; 0380531C
	.byte 0x08, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xE3, 0x0C, 0x00, 0x01, 0x00	; 0380532C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xF0, 0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380533C
	.byte 0x00, 0x00, 0x3E, 0xF8, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFC	; 0380534C
	.byte 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x10, 0x00, 0x01, 0x00	; 0380535C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xFF, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380536C
	.byte 0x00, 0x00, 0x00, 0xFF, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF	; 0380537C
	.byte 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x20, 0x00, 0x01, 0x00	; 0380538C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC3, 0x28, 0x00, 0x02, 0x00, 0x24, 0x00, 0x4F, 0xE2	; 0380539C
	.byte 0x14, 0x10, 0x1F, 0xE5, 0x05, 0x20, 0xA0, 0xE3, 0x00, 0x00, 0x0C, 0xEF, 0x1C, 0xC0, 0x1F, 0xE5	; 038053AC
	.byte 0x0C, 0xE0, 0xA0, 0xE1, 0x00, 0x00, 0xA0, 0xE3, 0x00, 0x10, 0xA0, 0xE1, 0x00, 0x20, 0xA0, 0xE1	; 038053BC
	.byte 0x1C, 0xFF, 0x2F, 0xE1, 0x30, 0xB5, 0x81, 0xB0, 0x0C, 0x4B, 0x0D, 0x4A, 0x00, 0x25, 0x0C, 0x68	; 038053CC
	.byte 0x09, 0x1D, 0x10, 0xC3, 0x6D, 0x1C, 0x05, 0x2D, 0xF9, 0xDB, 0x18, 0x60, 0x19, 0x1D, 0x08, 0x33	; 038053DC
	.byte 0x08, 0x48, 0x00, 0x68, 0x08, 0x60, 0x00, 0x21, 0x10, 0x68, 0x12, 0x1D, 0x01, 0xC3, 0x49, 0x1C	; 038053EC
	.byte 0x0A, 0x29, 0xF9, 0xDB, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xF8, 0x7F, 0x02	; 038053FC
	.byte 0x00, 0x80, 0x7F, 0x03, 0x34, 0xFE, 0x7F, 0x02, 0xF0, 0xB5, 0x83, 0xB0, 0x00, 0x91, 0x01, 0x92	; 0380540C
	.byte 0x1B, 0x49, 0x88, 0x42, 0x09, 0xD1, 0x1B, 0x49, 0x0E, 0x68, 0x1B, 0x49, 0x0A, 0x68, 0x1B, 0x49	; 0380541C
	.byte 0x09, 0x68, 0x71, 0x1A, 0x51, 0x1A, 0x8D, 0x08, 0x20, 0xE0, 0x19, 0x4E, 0x19, 0x49, 0x09, 0x68	; 0380542C
	.byte 0x8D, 0x08, 0x1B, 0xE0, 0x32, 0x68, 0x36, 0x1D, 0x01, 0x68, 0x8A, 0x42, 0x16, 0xD1, 0x04, 0x1D	; 0380543C
	.byte 0x33, 0x1C, 0x00, 0x99, 0x4A, 0x1E, 0x95, 0x42, 0x14, 0xDB, 0x05, 0xE0, 0x21, 0x68, 0x24, 0x1D	; 0380544C
	.byte 0x1F, 0x68, 0x1B, 0x1D, 0xB9, 0x42, 0x03, 0xD1, 0x11, 0x1C, 0x52, 0x1E, 0x00, 0x29, 0xF5, 0xD1	; 0380545C
	.byte 0x00, 0x2A, 0x03, 0xDA, 0x31, 0x1F, 0x01, 0x98, 0x08, 0x18, 0x04, 0xE0, 0x29, 0x1C, 0x6D, 0x1E	; 0380546C
	.byte 0x00, 0x29, 0xDF, 0xD1, 0x00, 0x20, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0380547C
	.byte 0xE0, 0x81, 0x7F, 0x03, 0x24, 0xFE, 0x7F, 0x02, 0x2C, 0xFE, 0x7F, 0x02, 0x28, 0xFE, 0x7F, 0x02	; 0380548C
	.byte 0x00, 0x00, 0x2C, 0x02, 0x3C, 0xFE, 0x7F, 0x02, 0x00, 0xB5, 0x81, 0xB0, 0x0D, 0x48, 0x02, 0x21	; 0380549C
	.byte 0x03, 0x22, 0xD2, 0x43, 0xFF, 0xF7, 0xB0, 0xFF, 0x00, 0x28, 0x01, 0xD1, 0x00, 0x20, 0x0E, 0xE0	; 038054AC
	.byte 0x01, 0x68, 0x09, 0x48, 0x81, 0x42, 0x04, 0xD3, 0x08, 0x48, 0x81, 0x42, 0x06, 0xD3, 0x00, 0x20	; 038054BC
	.byte 0x05, 0xE0, 0x07, 0x48, 0x81, 0x42, 0x01, 0xD3, 0x00, 0x20, 0x00, 0xE0, 0x01, 0x20, 0x01, 0xB0	; 038054CC
	.byte 0x08, 0xBC, 0x18, 0x47, 0xE0, 0x81, 0x7F, 0x03, 0x00, 0x00, 0x00, 0x03, 0x4C, 0x4F, 0x00, 0x03	; 038054DC
	.byte 0x33, 0x75, 0x02, 0x02, 0x10, 0xB5, 0xFF, 0xF7, 0xD7, 0xFF, 0x00, 0x28, 0x2C, 0xD0, 0x18, 0x4C	; 038054EC
	.byte 0x18, 0x48, 0x0E, 0x21, 0x18, 0x22, 0xFF, 0xF7, 0x87, 0xFF, 0x01, 0x1C, 0x00, 0x29, 0x06, 0xD1	; 038054FC
	.byte 0x15, 0x4C, 0x16, 0x48, 0x0E, 0x21, 0x04, 0x22, 0xFF, 0xF7, 0x7E, 0xFF, 0x01, 0x1C, 0x00, 0x29	; 0380550C
	.byte 0x1A, 0xD0, 0x13, 0x48, 0x00, 0x78, 0x01, 0x28, 0x04, 0xD1, 0x20, 0x1C, 0x05, 0x22, 0x0C, 0xF0	; 0380551C
	.byte 0xC9, 0xFB, 0x11, 0xE0, 0x0F, 0x48, 0x00, 0x88, 0x02, 0x28, 0x02, 0xD1, 0x0E, 0x48, 0x02, 0x68	; 0380552C
	.byte 0x01, 0xE0, 0x0E, 0x48, 0x02, 0x68, 0x0E, 0x48, 0x08, 0x1A, 0x80, 0x18, 0x21, 0x1C, 0xFF, 0xF7	; 0380553C
	.byte 0x41, 0xFF, 0x0C, 0x49, 0x0C, 0x48, 0x01, 0x60, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0380554C
	.byte 0xFC, 0x81, 0x7F, 0x03, 0x48, 0x82, 0x7F, 0x03, 0xE8, 0x81, 0x7F, 0x03, 0x10, 0x82, 0x7F, 0x03	; 0380555C
	.byte 0x7A, 0xF8, 0x7F, 0x02, 0x40, 0xFC, 0x7F, 0x02, 0x38, 0xFE, 0x7F, 0x02, 0x60, 0xF8, 0x7F, 0x02	; 0380556C
	.byte 0x00, 0x00, 0x2C, 0x02, 0x1C, 0xF8, 0x7F, 0x02, 0x34, 0xFE, 0x7F, 0x02, 0x21, 0x06, 0xC0, 0xDE	; 0380557C
	.byte 0xDE, 0xC0, 0x06, 0x21, 0x05, 0x00, 0x50, 0xE3, 0x02, 0x00, 0x00, 0x3A, 0xB0, 0x00, 0xD1, 0xE1	; 0380558C
	.byte 0x08, 0x00, 0x50, 0xE3, 0xF6, 0xFF, 0xFF, 0x9A, 0x05, 0x00, 0x50, 0xE3, 0x1E, 0xFF, 0x2F, 0x31	; 0380559C
	.byte 0xB0, 0x00, 0xD1, 0xE1, 0x08, 0x00, 0x50, 0xE3, 0xF6, 0xFF, 0xFF, 0x9A, 0xB0, 0x00, 0xD1, 0xE1	; 038055AC
	.byte 0x06, 0x00, 0x50, 0xE3, 0xF9, 0xFF, 0xFF, 0x0A, 0xB0, 0x00, 0xD1, 0xE1, 0x05, 0x00, 0x50, 0xE3	; 038055BC
	.byte 0xF6, 0xFF, 0xFF, 0x0A, 0x00, 0x10, 0xA0, 0xE3, 0x68, 0x00, 0x9F, 0xE5, 0xB0, 0x10, 0xC0, 0xE1	; 038055CC
	.byte 0x64, 0x00, 0x9F, 0xE5, 0xB0, 0x10, 0xC0, 0xE1, 0x4C, 0x00, 0x9F, 0xE5, 0x00, 0x00, 0x90, 0xE5	; 038055DC
	.byte 0x03, 0x0C, 0x80, 0xE2, 0x28, 0x10, 0x9F, 0xE5, 0x28, 0x20, 0x9F, 0xE5, 0xB0, 0x00, 0xD2, 0xE1	; 038055EC
	.byte 0x01, 0x00, 0x10, 0xE2, 0xFC, 0xFF, 0xFF, 0x1A, 0xB0, 0x00, 0xD1, 0xE1, 0x06, 0x00, 0x50, 0xE3	; 038055FC
	.byte 0xF9, 0xFF, 0xFF, 0x0A, 0xB0, 0x00, 0xD1, 0xE1, 0x05, 0x00, 0x50, 0xE3, 0xF6, 0xFF, 0xFF, 0x0A	; 0380560C
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x14, 0x82, 0x80, 0x04, 0x9C, 0x81, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00	; 0380561C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380562C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380563C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380564C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380565C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380566C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380567C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380568C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0380569C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038056AC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038056BC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038056CC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038056DC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038056EC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 038056FC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0xB5, 0x0C, 0x48	; 0380570C
	.byte 0x06, 0xF0, 0x56, 0xF8, 0x0B, 0x4E, 0x0C, 0x4D, 0x01, 0x24, 0x02, 0xE0, 0x30, 0x1C, 0x0C, 0xF0	; 0380571C
	.byte 0xA7, 0xFA, 0x29, 0x88, 0x08, 0x1C, 0x20, 0x40, 0x00, 0x28, 0xF7, 0xD1, 0x01, 0x20, 0x01, 0x43	; 0380572C
	.byte 0x29, 0x80, 0x06, 0x48, 0x80, 0x69, 0x80, 0x68, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0380573C
	.byte 0x04, 0xFF, 0x30, 0x02, 0x00, 0x01, 0x00, 0x00, 0x96, 0xFF, 0x7F, 0x02, 0x0C, 0xFF, 0x30, 0x02	; 0380574C
	.byte 0x70, 0xB5, 0x0A, 0x48, 0x06, 0xF0, 0x34, 0xF8, 0x09, 0x4E, 0x0A, 0x4D, 0x01, 0x24, 0x02, 0xE0	; 0380575C
	.byte 0x30, 0x1C, 0x0C, 0xF0, 0x85, 0xFA, 0x28, 0x88, 0x20, 0x40, 0x00, 0x28, 0xF8, 0xD1, 0x03, 0x48	; 0380576C
	.byte 0x06, 0xF0, 0x04, 0xF8, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x04, 0xFF, 0x30, 0x02	; 0380577C
	.byte 0x00, 0x01, 0x00, 0x00, 0x96, 0xFF, 0x7F, 0x02, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0A, 0x4C	; 0380578C
	.byte 0x0A, 0x26, 0x00, 0x27, 0x02, 0xE0, 0x20, 0x1C, 0x0C, 0xF0, 0x6A, 0xFA, 0x30, 0x1C, 0x29, 0x1C	; 0380579C
	.byte 0x3A, 0x1C, 0x09, 0xF0, 0x93, 0xFD, 0x00, 0x28, 0xF5, 0xDB, 0x04, 0x48, 0x05, 0xF0, 0xE6, 0xFF	; 038057AC
	.byte 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x01, 0x00, 0x00, 0x04, 0xFF, 0x30, 0x02	; 038057BC
	.byte 0x02, 0xC0, 0x81, 0xE0, 0x0C, 0x00, 0x51, 0xE1, 0x04, 0x00, 0xB0, 0xB8, 0x04, 0x00, 0xA1, 0xB8	; 038057CC
	.byte 0xFB, 0xFF, 0xFF, 0xBA, 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB5, 0x04, 0x1C, 0xF2, 0xF7, 0x18, 0xFC	; 038057DC
	.byte 0x07, 0x48, 0x04, 0x60, 0x07, 0x49, 0x08, 0x88, 0x02, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x08, 0x80	; 038057EC
	.byte 0x01, 0x20, 0x05, 0x49, 0xF2, 0xF7, 0xC0, 0xFC, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 038057FC
	.byte 0xF4, 0xF6, 0x80, 0x03, 0x40, 0xFC, 0x7F, 0x02, 0x55, 0xF6, 0x80, 0x03, 0x00, 0x4B, 0x18, 0x47	; 0380580C
	.byte 0x79, 0xF6, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x28, 0x07, 0xD1, 0x01, 0x29, 0x05, 0xD1	; 0380581C
	.byte 0x04, 0x48, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD0, 0xF5, 0xF7, 0x0C, 0xFD, 0x01, 0xB0, 0x08, 0xBC	; 0380582C
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xF6, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x04, 0x48, 0x00, 0x88	; 0380583C
	.byte 0x02, 0x28, 0x02, 0xD1, 0x03, 0x48, 0x00, 0xF0, 0x29, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47	; 0380584C
	.byte 0x40, 0xFC, 0x7F, 0x02, 0x40, 0xE8, 0x3F, 0x02, 0x70, 0xB5, 0x0E, 0x1C, 0x00, 0x28, 0x13, 0xD0	; 0380585C
	.byte 0x00, 0x25, 0x04, 0x1C, 0x0C, 0x34, 0x28, 0x01, 0x22, 0x18, 0xD0, 0x68, 0xC0, 0x07, 0xC0, 0x0F	; 0380586C
	.byte 0xB0, 0x42, 0x06, 0xD1, 0x51, 0x68, 0x10, 0x68, 0x88, 0x42, 0x02, 0xD0, 0x92, 0x68, 0x00, 0xF0	; 0380587C
	.byte 0x07, 0xF8, 0x6D, 0x1C, 0x03, 0x2D, 0xEE, 0xDB, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0380588C
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x00, 0xF6, 0x80, 0x03, 0x10, 0xB5, 0x04, 0x1C	; 0380589C
	.byte 0x00, 0x21, 0xFF, 0xF7, 0xD9, 0xFF, 0x20, 0x1C, 0x01, 0x21, 0xFF, 0xF7, 0xD5, 0xFF, 0x10, 0xBC	; 038058AC
	.byte 0x08, 0xBC, 0x18, 0x47, 0x0E, 0xB0, 0xA0, 0xE1, 0x54, 0x00, 0x9F, 0xE5, 0x54, 0x10, 0x9F, 0xE5	; 038058BC
	.byte 0x66, 0x00, 0x00, 0xEB, 0x50, 0x00, 0x9F, 0xE5, 0x50, 0x10, 0x9F, 0xE5, 0x63, 0x00, 0x00, 0xEB	; 038058CC
	.byte 0x4C, 0x30, 0x9F, 0xE5, 0xB0, 0x10, 0xD3, 0xE1, 0x02, 0x00, 0x51, 0xE3, 0x0B, 0x00, 0x00, 0x0A	; 038058DC
	.byte 0x40, 0x30, 0x9F, 0xE5, 0x00, 0x10, 0x93, 0xE5, 0x00, 0x00, 0x51, 0xE3, 0x07, 0x00, 0x00, 0x0A	; 038058EC
	.byte 0x34, 0x30, 0x9F, 0xE5, 0x38, 0x00, 0x93, 0xE5, 0x3C, 0x20, 0x93, 0xE5, 0x38, 0x10, 0x83, 0xE5	; 038058FC
	.byte 0xAD, 0xFF, 0xFF, 0xEB, 0x24, 0x00, 0x9F, 0xE5, 0x01, 0x17, 0x80, 0xE2, 0x53, 0x00, 0x00, 0xEB	; 0380590C
	.byte 0x1B, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x30, 0x02, 0x00, 0xE8, 0x3F, 0x02, 0x00, 0x80, 0x7F, 0x03	; 0380591C
	.byte 0x00, 0xF6, 0x80, 0x03, 0x40, 0xFC, 0x7F, 0x02, 0x60, 0xF8, 0x7F, 0x02, 0x00, 0xFE, 0x7F, 0x02	; 0380592C
	.byte 0x00, 0x00, 0x2C, 0x02, 0x0E, 0xC0, 0xA0, 0xE1, 0xD3, 0x00, 0xA0, 0xE3, 0x00, 0xF0, 0x2F, 0xE1	; 0380593C
	.byte 0x78, 0xD0, 0x9F, 0xE5, 0x00, 0xE0, 0xA0, 0xE3, 0x0E, 0xF0, 0x6F, 0xE1, 0xD2, 0x00, 0xA0, 0xE3	; 0380594C
	.byte 0x00, 0xF0, 0x2F, 0xE1, 0x68, 0x20, 0x9F, 0xE5, 0x02, 0xD0, 0xA0, 0xE1, 0x00, 0xE0, 0xA0, 0xE3	; 0380595C
	.byte 0x0E, 0xF0, 0x6F, 0xE1, 0xDF, 0x00, 0xA0, 0xE3, 0x00, 0xF0, 0x2F, 0xE1, 0x02, 0x1C, 0xA0, 0xE3	; 0380596C
	.byte 0x01, 0x10, 0x42, 0xE0, 0x01, 0xD0, 0xA0, 0xE1, 0x48, 0x20, 0x9F, 0xE5, 0x06, 0x0C, 0x42, 0xE2	; 0380597C
	.byte 0x02, 0x10, 0xA0, 0xE1, 0x35, 0x00, 0x00, 0xEB, 0x0A, 0x0C, 0x42, 0xE2, 0x38, 0x10, 0x9F, 0xE5	; 0380598C
	.byte 0x32, 0x00, 0x00, 0xEB, 0x34, 0x20, 0x9F, 0xE5, 0x02, 0x00, 0xA0, 0xE1, 0x02, 0x1B, 0x82, 0xE2	; 0380599C
	.byte 0x2E, 0x00, 0x00, 0xEB, 0x36, 0x0D, 0x82, 0xE2, 0x80, 0x10, 0x80, 0xE2, 0x2B, 0x00, 0x00, 0xEB	; 038059AC
	.byte 0x3E, 0x0D, 0x82, 0xE2, 0x80, 0x10, 0x80, 0xE2	; 038059B4
.arm
	bl loc_03805A5C	; 038059B4
	bx r12	; 038059B8
	.byte 0xC0, 0xFF, 0x80, 0x03, 0x80, 0xFF, 0x80, 0x03, 0x00, 0x00, 0x81, 0x03, 0xF8, 0xF6, 0x80, 0x03	; 038059CC
	.byte 0x00, 0xF0, 0x7F, 0x02, 0x74, 0x10, 0x9F, 0xE5, 0x02, 0x0C, 0xA0, 0xE3, 0xB0, 0x00, 0xC1, 0xE1	; 038059DC
	.byte 0xB0, 0x00, 0xD1, 0xE1, 0x0F, 0x00, 0x00, 0xE2, 0x02, 0x00, 0x50, 0xE3, 0xFB, 0xFF, 0xFF, 0x1A	; 038059EC
	.byte 0xAF, 0xFF, 0xFF, 0xEB, 0x58, 0x10, 0x9F, 0xE5, 0x17, 0x00, 0x00, 0xEB, 0x4C, 0x10, 0x9F, 0xE5	; 038059FC
	.byte 0x01, 0x0C, 0xA0, 0xE3, 0xB0, 0x00, 0xC1, 0xE1, 0xB0, 0x00, 0xD1, 0xE1, 0x0F, 0x00, 0x00, 0xE2	; 03805A0C
	.byte 0x01, 0x00, 0x50, 0xE3, 0xFB, 0xFF, 0xFF, 0x1A, 0xC5, 0xFF, 0xFF, 0xEB, 0x2C, 0x10, 0x9F, 0xE5	; 03805A1C
	.byte 0x00, 0x00, 0xA0, 0xE3	; 03805A20
	strh r0,[r1,#0x0]	; 03805A20
loc_03805A24:
	ldrh r0,[r1,#0x0]	; 03805A24
	cmp r0,#0x1	; 03805A28
	beq loc_03805A24	; 03805A2C
	ldr r3,[pool_03805A54]	; 03805A30
	ldr r12,[r3,#-0x1cc]	; 03805A34
	mov lr,r12	; 03805A38
	mov r11,#0x4000000	; 03805A3C
	ldmdb r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 03805A40
	mov r11,#0x0	; 03805A44
	bx r12	; 03805A48
	.byte 0x80, 0x01, 0x00, 0x04, 0x4D, 0xF6, 0x80, 0x03	; 03805A54
pool_03805A54:
loc_03805A54:
	.word 0x02800000	; 03805A54
	.byte 0x11, 0xFF, 0x2F, 0xE1	; 03805A5C

; ===== function loc_03805A5C =====
loc_03805A5C:
	mov r3,#0x0	; 03805A5C
	mov r4,r3	; 03805A60
	mov r5,r3	; 03805A64
	mov r6,r3	; 03805A68
	mov r7,r3	; 03805A6C
	mov r8,r3	; 03805A70
	mov r9,r3	; 03805A74
	mov r10,r3	; 03805A78
loc_03805A7C:
	cmp r0,r1	; 03805A7C
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 03805A80
	blt loc_03805A7C	; 03805A84
	bx lr	; 03805A88
	.byte 0x00, 0x80, 0x7F, 0x03, 0x24, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF6, 0x80, 0x03	; 03805A9C
	.byte 0xF4, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0xF8, 0xF6, 0x80, 0x03, 0xDC, 0x01, 0x00, 0x00	; 03805AAC
	.byte 0x00, 0x00, 0x00, 0x00	; 03805AB0
.close
