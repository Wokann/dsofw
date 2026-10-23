# 技术说明：任天堂 DS 原始固件

[English](TECHNICAL.md) · [项目说明](README.zh-cn.md)

## 严格可读重建

每个版本目录的 `src/` 中均保存逐字节重建所需的 armips 源码：`h.s`、`p1.s`–`p5.s`，
iQue/Korean 变体另有 `rsa.s`。P1–P4 使用 ARM/Thumb 指令及组件内 `loc_` 标签；原始
装载器中尚未确认 P5 的执行入口，故 P5 保持为显式数据。各 `src/p*.s` 将实际运行期 RAM
地址映射到从零开始的组件输出。

`make` 编译各源文件，`dsfwtool` 按版本目录的 `layout.ld` 组装镜像；
`make verify-firmware` 将结果与版本目录内的只读归一化 CRC32 记录比较。
编译工具、公共头文件与 CRC 记录均由本工程提供，不依赖相邻仓库。

GNU `as` 会把少数语义等价的 Thumb-1 `ADD`/`SUB` 规范化为不同编码；若不使用原始操作码
指令，便不能满足零售镜像的逐字节要求。因此严格路线使用随附的补丁版 armips；它接受所需的
ARMv4T 形式并保留所需编码。详见 [`tools/armips/README.zh-cn.md`](tools/armips/README.zh-cn.md)。
严格可读源码中不使用 `.inst` 或 `.hword`。

| 组件 | `official_v3` 运行期范围 | `official_v6` 运行期范围 | 执行模型 |
| --- | --- | --- | --- |
| P1 | `0x02320000`–`0x02330D24` | `0x02320000`–`0x02330E24` | ARM9 / ARMv5TE，ARM 与 Thumb 混合 |
| P2 | `0x037FA800`–`0x038057EC` | `0x037FA800`–`0x03805A04` | ARM7 / ARMv4T，ARM 与 Thumb 混合 |
| P3 | `0x02358D00`–`0x02373CA0` | `0x02358E00`–`0x02373DC0` | ARM9 / ARMv5TE Thumb 代码 |
| P4 | `0x02300200`–`0x0230DB40` | `0x02300200`–`0x0230DB4C` | ARM7 / ARMv4T 代码 |
| P5 | `0x023A4960`–`0x023DF100` | `0x023A4A80`–`0x023DF220` | 已加载的共享 UI 资源数据 |

## 任天堂 V1–V7 样本

| 目录 | P1 | P2 | P3 | P4 | P5 |
| --- | --- | --- | --- | --- | --- |
| [`v1`](retail/v1/) | `0x02320000`–`0x023311C4` | `0x037FA800`–`0x038031A0` | `0x02354F10`–`0x0236FA70` | `0x02300200`–`0x023108AC` | `0x0239F0E0`–`0x023D9880` |
| [`v2`](retail/v2/) | `0x02320000`–`0x023311E4` | `0x037FA800`–`0x038031A0` | `0x02354F30`–`0x0236FAB0` | `0x02300200`–`0x023108B0` | `0x0239F120`–`0x023D98C0` |
| [`v3`](retail/v3/) | `0x02320000`–`0x02330D24` | `0x037FA800`–`0x038057EC` | `0x02358D00`–`0x02373CA0` | `0x02300200`–`0x0230DB40` | `0x023A4960`–`0x023DF100` |
| [`v4`](retail/v4/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v5`](retail/v5/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v6`](retail/v6/) | `0x02320000`–`0x02330E24` | `0x037FA800`–`0x03805A04` | `0x02358E00`–`0x02373DC0` | `0x02300200`–`0x0230DB4C` | `0x023A4A80`–`0x023DF220` |
| [`v7`](retail/v7/) | `0x02320000`–`0x02330B44` | `0x037FA800`–`0x03805AB0` | `0x02358B20`–`0x02373AA0` | `0x02300200`–`0x0230DB4C` | `0x023A4760`–`0x023DEF00` |

P1/P2 基址由 H 描述符解码；P3/P4/P5 基址由原始装载常量恢复，再通过 P3 首条 Thumb
`BL` 验证：V1/V2 指向 `0x02321404`，V4/V5 指向 `0x02325778`，V7 指向
`0x02325734`，均位于各自 P1 内。

## 任天堂地区固件样本

| 目录 | P1 | P2 | P3 | P4 | P5 |
| --- | --- | --- | --- | --- | --- |
| [`ique_v1`](retail/ique_v1/) | `0x02320000`–`0x023347A4` | `0x037FA800`–`0x03805884` | `0x02364B20`–`0x0237C460` | `0x02300200`–`0x0230DB40` | `0x0237C460`–`0x023DAF00` |
| [`ique_v2`](retail/ique_v2/) | `0x02320000`–`0x02334584` | `0x037FA800`–`0x03805B04` | `0x02364900`–`0x0237C240` | `0x02300200`–`0x0230DB4C` | `0x0237C240`–`0x023DACE0` |
| [`kor_v1`](retail/kor_v1/) | `0x02320000`–`0x02334604` | `0x037FA800`–`0x03805EA0` | `0x02364B80`–`0x0237C4E0` | `0x02300200`–`0x0230DB4C` | `0x0237C4E0`–`0x023C48E0` |

三份样本的 P1/P2 基址都与 V3/V6 一样，从 H 描述符解码得到；P3/P5 基址则从各自 P1
中的装载/CRC 字面量表恢复，且三者的 P5 都恰好从 P3 有效末尾开始。这些是任天堂的地区
固件变体，不是 FlashMe 的发布版本。

## 运行期地址依据

P1 和 P2 直接来自原始 H 描述符字段。两版中均有 `part1_ramaddr = 0x4E00`、
`part2_ramaddr = 0x0158`、`shift_amounts = 0x2CB2`；按描述符公式解码后，P1 位于
`0x02320000`，P2 位于 `0x037FA800`。

P3、P4、P5 不是由 ROM 组件偏移推测。原始 P1/P2 代码包含其 RAM 装载常量：

| 数值 | V3 源码位置 | V6 源码位置 | 含义 |
| --- | --- | --- | --- |
| P3 基址 | P1 `0x02326E04`: `0x02358D00` | P1 `0x02326DCC`: `0x02358E00` | ARM9 GUI 程序目标 |
| P4 基址 | P2 `0x037FAAF4`: `0x02300200` | P2 `0x037FAB0C`: `0x02300200` | ARM7 GUI 程序目标 |
| P5 基址 | P1 `0x02326E4C`: `0x023A4960` | P1 `0x02326E14`: `0x023A4A80` | 指引数据目标 |

V3 P3 入口在 `0x02358D00` 解码后的首条 `BL` 指向 `0x02325778`，位于 V3 P1 内，独立验证了
P3 基址。补丁文件中便于表达组件原始偏移的 `0x02380000` 不是 P3 的实际执行地址；它会导致
错误的调用目标。采用 `headersize + 原始偏移` 的汇编表达式中，两者的差异可以抵消，故修正
分析映射本身不一定改变补丁生成字节。

## 导出策略

- P1 以组件偏移 `0x0` 的 ARM 和 `0xA0` 的 Thumb 入口开始分析。
- P2 以 `0x0` 的 ARM 入口开始分析。
- P3 以 `0x0` 的 Thumb 入口开始分析。
- P4 以 `0x0` 的 ARM 入口开始分析。
- P5 在原始装载路径中尚无已知执行入口，按资源结构与显式数据保留，不作推测性反汇编。

已确认的组件内和跨组件目标使用实际位置标签；尚未确认的目标保留数值运行期地址。
中性 `loc_XXXXXXXX` 标签可保留在功能标签旁，不为未经确认的例程虚构名称。

## P5 共享资源

十个版本的 P5 均已识别出以下 100 个顶层资源容器。源码以实际标签表达目录、相对偏移、记录数量和文件
长度；未知字段、填充和载荷保持原值。P5 组件内偏移、装载后的 RAM 地址与独立 NDS 文件
偏移是不同坐标，不能互相替代。

| 格式 | 每版数量 | 已恢复结构 |
| --- | --- | --- |
| BNFR 字体（标识 `JNFR`） | 4 | 版本、字形数、宽高位字段、每字形两个度量字节及 1bpp 位图 |
| BNCMP 字符映射（标识 `JNCM`） | 4 | 连续 Unicode 区间与离散码点；两个表偏移以容器 `+8` 为基准 |
| BMG 消息 | 6 | UTF-8 文本、INF1 索引及 DAT1 正文；每组 164 条固件共享消息 |
| BNCD 图像单元（标识 `JNCD`） | 4 | 28 字节头、6 字节目录项、12 字节辅助记录及图像载荷 |
| SDAT 声音档案 | 1 | INFO、FAT、FILE 与 SSAR/SBNK/SWAR；SSAR 有 50 项序列记录 |
| BNBL 按钮布局（标识 `JNBL`） | 19 | 每项 6 字节：打包的 X/Y 坐标与基准、字节宽高 |
| BNCL 图像布局（标识 `JNCL`） | 31 | 每项 8 字节：打包的 X/Y 坐标与基准、图像单元索引 |
| BNLL 文本布局（标识 `JNLL`） | 31 | 每项 12 字节：位置、间距、字体/调色板/颜色及文本偏移；后接可选 UTF-16 字符串 |

各版的完整资源文件按用途存放：

| 目录 | 文件 |
| --- | --- |
| `src/graphic/` | `font_00.bnfr`–`font_03.bnfr`、`font_map_00.bncmp`–`font_map_03.bncmp`、`cells_00.bncd`–`cells_03.bncd` |
| `src/text/` | `messages_ja.bmg`、`messages_en.bmg`、`messages_fr.bmg`、`messages_de.bmg`、`messages_it.bmg`、`messages_es.bmg`；iQue 以 `zh` 替代 `ja`，韩版以 `ko` 替代 `it` |
| `src/sound/` | `system.sdat` 及其子文件 `sequences.ssar`、`bank.sbnk`、`waves.swar` |
| `src/layout/` | `buttons_00.bnbl`–`buttons_18.bnbl`、`cells_00.bncl`–`cells_30.bncl`、`text_00.bnll`–`text_30.bnll` |

文件后缀使用已确认的格式名，均含完整的原始格式头及数据。
格式可与 [BNFR](https://wiki.dshack.org/Wiki.jsp?page=BNFR+File+Format) 和
[BNCD](https://wiki.dshack.org/Wiki.jsp?page=BNCD) 的结构说明交叉核对。

字体、字符映射、图像单元、BMG 和 SDAT 各有同名 `.s`；布局资源按类别归入
`src/layout/buttons.s`、`cells.s`、`text.s`。它们由 `p5.s` 按原顺序引入，共享组件符号域。文件头、目录、索引、
字符映射和普通消息仍用可读汇编表达；`.incbin` 从完整格式文件引用保留字段、度量、位图、
图像及声音数据区。修改消息正文的位置是 `src/text/messages_*.s`，其中保留明文、控制码
和各条消息标签。声音保留原始序列和采样编码，不转码为 WAV。这些文件是编译输入，
不需要构建时解包固件镜像；资源范围之外尚未分类的数据继续在 `p5.s` 中保留。

BNCMP 的字形索引先按连续区间展开，再接离散码点，数量与对应 BNFR 字体关联。
软件键盘使用的三组 ASCII 字符集及五组扩展字符表独立放在 `src/text/keyboard.s`，
保留原有 UTF-16 数据、BOM 和私用字形编码；它们不是 BNCMP 字体索引表。

布局字段可与 [JNLib 布局格式](https://wiki.dshack.org/Wiki.jsp?page=Jnlib+Layout+File+Format)、
[BNBL](https://wiki.dshack.org/Wiki.jsp?page=BNBL)、[BNCL](https://wiki.dshack.org/Wiki.jsp?page=BNCL)
和 [BNLL](https://wiki.dshack.org/Wiki.jsp?page=BNLL) 的结构说明交叉核对。
本固件 BNLL 的非零文本偏移相对本容器开头，指向条目数组之后的 UTF-16 字符串；
零值保留为无内置文本。头部 `0x04` 的字段用途尚未确认，原值保留。
`src/layout/text.s` 保留这些字符串的明文，仅在本文件范围内加载
`include/p5-utf16le.tbl`，结束后恢复原字符表。

BMG 的六个语言槽在国际版为日、英、法、德、意、西；iQue 的槽 0 为中文，韩版的槽 4 为
韩文。它们是整个固件共用的文本，不是 PictoChat 与 Download Play 各自拥有一套 164 条
消息。INF1 的偏移相对 DAT1 的正文起点；控制码、私用字形及终止符保留显式字节，普通文本
以明文编写。`include/utf8.tbl` 只负责把源码字符编码回原始 UTF-8 字节，不增加字体资源。
布局可与 [ndspy 的 BMG 读取实现](https://github.com/RoadrunnerWMC/ndspy/blob/master/ndspy/bmg.py)
交叉核对。

SDAT 的 FAT 文件偏移相对整个 SDAT，INFO 表偏移相对 INFO，SSAR 序列起点相对序列事件区。
这些偏移及大小由对应标签计算。国际 V1/V2 与 V3–V7 的 P5 仅三字节不同，均在 SDAT 内：

| P5 偏移 | V1/V2 | V3–V7 | SSAR 字段（按 ndspy 命名） |
| --- | --- | --- | --- |
| `0x731D` | `0x0A` | `0x08` | 序列 29 的 `playerID` |
| `0x73B9` | `0x0F` | `0x0E` | 序列 42 的 `playerID` |
| `0x73C4` | `0x40` | `0x46` | 序列 43 的 `polyphonicPressure` |

序列编号从 0 开始。字段布局见
[ndspy 的 SSAR 读取实现](https://github.com/RoadrunnerWMC/ndspy/blob/master/ndspy/soundSequenceArchive.py)；
这些参数在实机上的具体影响尚未独立验证，重建时保留版本差异。国际 V1–V7 的四份字体、
四份字符映射及六组消息完全相同；iQue V1/V2 的整个 P5 相同。

JNCD 目录与辅助记录的边界已由无损解析和回写确认，但记录各字段的显示含义、像素及调色板
重组方式尚未完全恢复。与 DSi/3DS 参照匹配的载荷片段不等于完整容器或应用代码等价；
DS 的消息编号也不能直接套用到各有 138 条消息的 DSi 独立应用。
