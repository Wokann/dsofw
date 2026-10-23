; SDAT resource; included by p5.s at P5_NitroSoundArchive.
; SDAT 资源，由 p5.s 在 P5_NitroSoundArchive 处引入。
	.ascii "SDAT"
	.dh 0xFEFF, 0x0100
    .word P5_NitroSoundArchive_End - P5_NitroSoundArchive
	.dh 0x0040, 0x0003
	.dw 0x00000000, 0x00000000 ; absent SYMB block / 缺少的 SYMB 块
    .word P5_NitroSoundArchiveInfoBlock - P5_NitroSoundArchive
    .word P5_NitroSoundArchiveInfoBlock_End - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveFatBlock - P5_NitroSoundArchive
    .word P5_NitroSoundArchiveFatBlock_End - P5_NitroSoundArchiveFatBlock
    .word P5_NitroSoundArchiveFileBlock - P5_NitroSoundArchive
    .word P5_NitroSoundArchiveFileBlock_End - P5_NitroSoundArchiveFileBlock
    .incbin "src/sound/system.sdat", 0x30, 0x10 ; original format bytes / 原始格式字节
P5_NitroSoundArchiveInfoBlock:
; INFO table offsets: sequence, sequence archive, bank, wave archive, player, group, stream-player, stream.
; INFO 表偏移：序列、序列归档、音色库、波形归档、播放器、组、流播放器、流。
; INFO offsets are relative to INFO; FAT offsets are relative to SDAT. / INFO 内偏移相对 INFO，FAT 文件偏移相对 SDAT。
	.ascii "INFO"
    .word P5_NitroSoundArchiveInfoBlock_End - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_Sequences - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_SequenceArchives - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_Banks - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_WaveArchives - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_Players - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_Groups - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_StreamPlayers - P5_NitroSoundArchiveInfoBlock
    .word P5_NitroSoundArchiveInfo_Streams - P5_NitroSoundArchiveInfoBlock
	.fill 0x18, 0x00
P5_NitroSoundArchiveInfoTables:
P5_NitroSoundArchiveInfo_Sequences:
    .word 0 ; record count / 记录数
P5_NitroSoundArchiveInfo_SequenceArchives:
    .word 1 ; record count / 记录数
    .word P5_NitroSoundArchiveInfo_SequenceArchives_00 - P5_NitroSoundArchiveInfoBlock
P5_NitroSoundArchiveInfo_SequenceArchives_00:
    .byte 0x00, 0x00, 0x00, 0x00
P5_NitroSoundArchiveInfo_Banks:
    .word 1 ; record count / 记录数
    .word P5_NitroSoundArchiveInfo_Banks_00 - P5_NitroSoundArchiveInfoBlock
P5_NitroSoundArchiveInfo_Banks_00:
    .byte 0x01, 0x00, 0x00, 0x00
    .byte 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
P5_NitroSoundArchiveInfo_WaveArchives:
    .word 1 ; record count / 记录数
    .word P5_NitroSoundArchiveInfo_WaveArchives_00 - P5_NitroSoundArchiveInfoBlock
P5_NitroSoundArchiveInfo_WaveArchives_00:
    .byte 0x02, 0x00, 0x00, 0x00
P5_NitroSoundArchiveInfo_Players:
    .word 0 ; record count / 记录数
P5_NitroSoundArchiveInfo_Groups:
    .word 0 ; record count / 记录数
P5_NitroSoundArchiveInfo_StreamPlayers:
    .word 0 ; record count / 记录数
P5_NitroSoundArchiveInfo_Streams:
    .word 0 ; record count / 记录数
; FAT block. / 文件分配表块。
P5_NitroSoundArchiveFatBlock:
; Three absolute file entries: sequence archive, bank and wave archive.
; 三条绝对文件项：序列归档、音色库与波形归档。
P5_NitroSoundArchiveInfoBlock_End:
	.ascii "FAT "
    .word P5_NitroSoundArchiveFatBlock_End - P5_NitroSoundArchiveFatBlock
    .byte 0x03, 0x00, 0x00, 0x00
P5_NitroSoundArchiveFatSequenceArchiveEntry:
    .word P5_NitroSoundArchiveSequenceArchive - P5_NitroSoundArchive
    .word P5_NitroSoundArchiveSequenceArchive_End - P5_NitroSoundArchiveSequenceArchive
    .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
P5_NitroSoundArchiveFatBankEntry:
    .word P5_NitroSoundArchiveSoundBank - P5_NitroSoundArchive
    .word P5_NitroSoundArchiveSoundBank_End - P5_NitroSoundArchiveSoundBank
    .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
P5_NitroSoundArchiveFatWaveArchiveEntry:
    .word P5_NitroSoundArchiveWaveArchive - P5_NitroSoundArchive
    .word P5_NitroSoundArchiveWaveArchive_End - P5_NitroSoundArchiveWaveArchive
    .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
; FILE block. / 文件数据块。
P5_NitroSoundArchiveFileBlock:
; FILE data block: three archive files, each aligned by the SDAT container.
; FILE 数据块：三个归档文件，均由 SDAT 容器对齐。
P5_NitroSoundArchiveFatBlock_End:
	.ascii "FILE"
    .word P5_NitroSoundArchiveFileBlock_End - P5_NitroSoundArchiveFileBlock
    .byte 0x03, 0x00, 0x00, 0x00
	.fill 0x18, 0x00
; Sequence archive file (SSAR). / 序列归档文件。
P5_NitroSoundArchiveSequenceArchive:
P5_NitroSoundArchiveSequenceArchiveHeader:
	.ascii "SSAR"
	.dh 0xFEFF, 0x0100
    .word P5_NitroSoundArchiveSequenceArchive_End - P5_NitroSoundArchiveSequenceArchive
P5_NitroSoundArchiveSequenceArchiveDataBlock:
	.dh 0x0010, 0x0001
P5_NitroSoundArchiveSequenceArchive_Data:
	.ascii "DATA"
    .word P5_NitroSoundArchiveSequenceArchive_End - P5_NitroSoundArchiveSequenceArchive_Data
    .word P5_NitroSoundArchiveSequenceArchive_Sequences - P5_NitroSoundArchiveSequenceArchive
    .word (P5_NitroSoundArchiveSequenceArchive_EntriesEnd - P5_NitroSoundArchiveSequenceArchive_Entries) / 12
P5_NitroSoundArchiveSequenceArchive_Entries:
P5_NitroSoundArchiveSequenceArchive_Entry00:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence00 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry01:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence01 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x00 ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry02:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence02 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x00 ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry03:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence03 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0D ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry04:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence04 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x46 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0E ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry05:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence05 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0F ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry06:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence06 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry07:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence07 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry08:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence08 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry09:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence09 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry10:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence10 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry11:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence11 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry12:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence12 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x1E ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry13:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence13 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry14:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence14 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry15:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence15 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x09 ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry16:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence16 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry17:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence17 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x32 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry18:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence18 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x28 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry19:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence19 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry20:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence20 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x64 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry21:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence21 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x28 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry22:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence22 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0B ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry23:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence23 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x08 ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry24:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence24 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x5A ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry25:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence25 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x32 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry26:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence26 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x5A ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry27:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence27 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry28:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence28 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry29:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence29 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x32 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x08 ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry30:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence30 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x5A ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry31:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence31 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x3C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry32:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence32 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry33:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence33 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0C ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry34:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence34 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x50 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry35:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence35 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x28 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry36:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence36 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0B ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry37:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence37 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x5A ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0B ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry38:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence38 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x5A ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry39:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence39 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry40:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence40 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry41:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence41 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x30 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0F ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry42:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence42 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x0C ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0E ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry43:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence43 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x30 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x46 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0F ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry44:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence44 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x60 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0B ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry45:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence45 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x60 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry46:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence46 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x60 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry47:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence47 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x14 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry48:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence48 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x14 ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_Entry49:
    .word P5_NitroSoundArchiveSequenceArchive_Sequence49 - P5_NitroSoundArchiveSequenceArchive_Sequences
    .dh 0x0000 ; bank ID / 音色库 ID
    .byte 0x7F ; volume / 音量
    .byte 0x60 ; channelPressure (ndspy) / 声道参数
    .byte 0x40 ; polyphonicPressure (ndspy) / 复音参数
    .byte 0x0A ; player ID / 播放器 ID
    .byte 0x00, 0x00
P5_NitroSoundArchiveSequenceArchive_EntriesEnd:
P5_NitroSoundArchiveSequenceArchive_Sequences:
P5_NitroSoundArchiveSequenceArchive_Sequence24:
P5_NitroSoundArchiveSequenceArchive_Sequence29:
P5_NitroSoundArchiveSequenceArchive_Sequence40:
P5_NitroSoundArchiveSequenceArchive_Sequence49:
; Data from the complete sound resource; headers remain explicit. / 从完整声音资源引用数据区，文件头仍显式编写。
    .incbin "src/sound/sequences.ssar", 0x278, 0x6
P5_NitroSoundArchiveSequenceArchive_Sequence06:
P5_NitroSoundArchiveSequenceArchive_Sequence08:
P5_NitroSoundArchiveSequenceArchive_Sequence10:
    .incbin "src/sound/sequences.ssar", 0x27E, 0x6
P5_NitroSoundArchiveSequenceArchive_Sequence07:
P5_NitroSoundArchiveSequenceArchive_Sequence09:
P5_NitroSoundArchiveSequenceArchive_Sequence11:
    .incbin "src/sound/sequences.ssar", 0x284, 0x6
P5_NitroSoundArchiveSequenceArchive_Sequence00:
    .incbin "src/sound/sequences.ssar", 0x28A, 0x9
P5_NitroSoundArchiveSequenceArchive_Sequence01:
    .incbin "src/sound/sequences.ssar", 0x293, 0xF
P5_NitroSoundArchiveSequenceArchive_Sequence02:
    .incbin "src/sound/sequences.ssar", 0x2A2, 0xFD
P5_NitroSoundArchiveSequenceArchive_Sequence03:
    .incbin "src/sound/sequences.ssar", 0x39F, 0x1C
P5_NitroSoundArchiveSequenceArchive_Sequence04:
    .incbin "src/sound/sequences.ssar", 0x3BB, 0x4E
P5_NitroSoundArchiveSequenceArchive_Sequence12:
    .incbin "src/sound/sequences.ssar", 0x409, 0x14
P5_NitroSoundArchiveSequenceArchive_Sequence13:
    .incbin "src/sound/sequences.ssar", 0x41D, 0x1D
P5_NitroSoundArchiveSequenceArchive_Sequence14:
    .incbin "src/sound/sequences.ssar", 0x43A, 0xC
P5_NitroSoundArchiveSequenceArchive_Sequence05:
    .incbin "src/sound/sequences.ssar", 0x446, 0x31
P5_NitroSoundArchiveSequenceArchive_Sequence15:
    .incbin "src/sound/sequences.ssar", 0x477, 0x8
P5_NitroSoundArchiveSequenceArchive_Sequence18:
    .incbin "src/sound/sequences.ssar", 0x47F, 0x8
P5_NitroSoundArchiveSequenceArchive_Sequence19:
    .incbin "src/sound/sequences.ssar", 0x487, 0x45
P5_NitroSoundArchiveSequenceArchive_Sequence21:
    .incbin "src/sound/sequences.ssar", 0x4CC, 0x51
P5_NitroSoundArchiveSequenceArchive_Sequence16:
    .incbin "src/sound/sequences.ssar", 0x51D, 0xD
P5_NitroSoundArchiveSequenceArchive_Sequence17:
    .incbin "src/sound/sequences.ssar", 0x52A, 0x13
P5_NitroSoundArchiveSequenceArchive_Sequence20:
    .incbin "src/sound/sequences.ssar", 0x53D, 0x6
P5_NitroSoundArchiveSequenceArchive_Sequence22:
    .incbin "src/sound/sequences.ssar", 0x543, 0x40
P5_NitroSoundArchiveSequenceArchive_Sequence23:
    .incbin "src/sound/sequences.ssar", 0x583, 0x5E
P5_NitroSoundArchiveSequenceArchive_Sequence25:
    .incbin "src/sound/sequences.ssar", 0x5E1, 0x16
P5_NitroSoundArchiveSequenceArchive_Sequence26:
P5_NitroSoundArchiveSequenceArchive_Sequence38:
    .incbin "src/sound/sequences.ssar", 0x5F7, 0x59
P5_NitroSoundArchiveSequenceArchive_Sequence27:
    .incbin "src/sound/sequences.ssar", 0x650, 0x2D
P5_NitroSoundArchiveSequenceArchive_Sequence28:
    .incbin "src/sound/sequences.ssar", 0x67D, 0x27
P5_NitroSoundArchiveSequenceArchive_Sequence32:
    .incbin "src/sound/sequences.ssar", 0x6A4, 0xB
P5_NitroSoundArchiveSequenceArchive_Sequence30:
    .incbin "src/sound/sequences.ssar", 0x6AF, 0x6A
P5_NitroSoundArchiveSequenceArchive_Sequence31:
    .incbin "src/sound/sequences.ssar", 0x719, 0xD8
P5_NitroSoundArchiveSequenceArchive_Sequence33:
    .incbin "src/sound/sequences.ssar", 0x7F1, 0x6E
P5_NitroSoundArchiveSequenceArchive_Sequence34:
    .incbin "src/sound/sequences.ssar", 0x85F, 0x2F
P5_NitroSoundArchiveSequenceArchive_Sequence35:
    .incbin "src/sound/sequences.ssar", 0x88E, 0x3D
P5_NitroSoundArchiveSequenceArchive_Sequence44:
    .incbin "src/sound/sequences.ssar", 0x8CB, 0x2C
P5_NitroSoundArchiveSequenceArchive_Sequence36:
    .incbin "src/sound/sequences.ssar", 0x8F7, 0x15
P5_NitroSoundArchiveSequenceArchive_Sequence37:
    .incbin "src/sound/sequences.ssar", 0x90C, 0xF
P5_NitroSoundArchiveSequenceArchive_Sequence39:
    .incbin "src/sound/sequences.ssar", 0x91B, 0x76
P5_NitroSoundArchiveSequenceArchive_Sequence41:
P5_NitroSoundArchiveSequenceArchive_Sequence42:
    .incbin "src/sound/sequences.ssar", 0x991, 0x8
P5_NitroSoundArchiveSequenceArchive_Sequence43:
    .incbin "src/sound/sequences.ssar", 0x999, 0x56
P5_NitroSoundArchiveSequenceArchive_Sequence45:
P5_NitroSoundArchiveSequenceArchive_Sequence46:
    .incbin "src/sound/sequences.ssar", 0x9EF, 0x8
P5_NitroSoundArchiveSequenceArchive_Sequence47:
    .incbin "src/sound/sequences.ssar", 0x9F7, 0xB
P5_NitroSoundArchiveSequenceArchive_Sequence48:
    .incbin "src/sound/sequences.ssar", 0xA02, 0xE
P5_NitroSoundArchiveSequenceArchive_End:
    .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00
; Sound-bank file (SBNK). / 音色库文件。
P5_NitroSoundArchiveSoundBank:
P5_NitroSoundArchiveSoundBankHeader:
	.ascii "SBNK"
	.dh 0xFEFF, 0x0100
    .word P5_NitroSoundArchiveSoundBank_End - P5_NitroSoundArchiveSoundBank
P5_NitroSoundArchiveSoundBankDataBlock:
	.dh 0x0010, 0x0001
P5_NitroSoundArchiveSoundBank_Data:
	.ascii "DATA"
    .word P5_NitroSoundArchiveSoundBank_End - P5_NitroSoundArchiveSoundBank_Data
; Data from the complete sound resource; headers remain explicit. / 从完整声音资源引用数据区，文件头仍显式编写。
P5_NitroSoundArchiveSoundBank_Payload:
    .incbin "src/sound/bank.sbnk", 0x18, 0x1C0
P5_NitroSoundArchiveSoundBank_End:
    .byte 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00
; Wave-archive file (SWAR). / 波形归档文件。
P5_NitroSoundArchiveWaveArchive:
P5_NitroSoundArchiveWaveArchiveHeader:
	.ascii "SWAR"
	.dh 0xFEFF, 0x0100
    .word P5_NitroSoundArchiveWaveArchive_End - P5_NitroSoundArchiveWaveArchive
P5_NitroSoundArchiveWaveArchiveDataBlock:
	.dh 0x0010, 0x0001
P5_NitroSoundArchiveWaveArchive_Data:
	.ascii "DATA"
    .word P5_NitroSoundArchiveWaveArchive_End - P5_NitroSoundArchiveWaveArchive_Data
; Data from the complete sound resource; headers remain explicit. / 从完整声音资源引用数据区，文件头仍显式编写。
P5_NitroSoundArchiveWaveArchive_Payload:
    .incbin "src/sound/waves.swar", 0x18, 0x1CE4
P5_NitroSoundArchiveWaveArchive_End:
	.byte 0x00, 0x00, 0x00, 0x00	; 02393D40
