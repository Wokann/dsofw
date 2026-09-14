# Nintendo original firmware analysis exports

This directory contains Ghidra-derived, address-oriented listings of the five
decompressed components from the seven Nintendo original firmware revisions
V1–V7, plus the iQue V1, iQue V2, and Korean V1 Nintendo-region samples. It
deliberately does not contain either original firmware image or the
decrypted/decompressed binary inputs.

Each version directory contains complete, byte-exact armips sources under
`src/`: `h.s`, `p1.s`–`p5.s`, and, for iQue/Korean variants, `rsa.s`.
`src/main.s` supplies their common include/symbol scope; every component
retains its own output file. Ghidra-recognised instructions are
ARM/Thumb mnemonics; bytes not classified as code remain explicit `.byte`
data. Sources preserve real runtime RAM addresses, use `pool_` labels instead
of fixed PC offsets for literal loads, and mark recognised function entries.

## Direct strict readable reassembly / 直接严格可读重组

Each version directory itself is the byte-exact, readable-source route.
P1–P4 use ARM/Thumb instructions and intra-component `loc_` labels; P5 is
explicit data because the original loader has no established P5 execution
entry. Each `src/p*.s` directly maps its true RAM address to a zero-based
component output. `make` compiles all source inputs, and `dsfwtool` packs them
according to the version-local `layout.ld`; it neither reads an official
firmware image nor uses `-b`. `make verify-firmware` checks the result against
the shared normalised CRC32 record in the sibling `dscfw` repository.

Obtaining and unpacking an official image is an external reverse-engineering
aid used to prepare these sources, not a reconstruction-project target or
build input. The H sources deliberately represent private Wi-Fi calibration
and user-settings bytes in their normalised form, so the recorded CRC check is
reproducible without tracking personal firmware data.

GNU `as` canonicalises some semantically identical Thumb-1 `ADD`/`SUB` forms
to different encodings, so it cannot meet the retail byte-exact requirement
without raw-opcode directives. The strict route instead uses the repository's
small compatibility patch for [Kingcom/armips](https://github.com/Kingcom/armips),
whose documented ARM7/ARM9 ARM/Thumb support preserves the required encoding.
See [`tools/armips/README.md`](tools/armips/README.md). No `.inst` or `.hword`
is used in these readable strict sources.

每个版本目录本身都是逐字节一致的可读源码路线。P1–P4 使用
ARM/Thumb 指令和组件内 `loc_` 标签；原始装载器没有已证实的 P5 执行入口，故
P5 明确保留为数据。每个 `src/p*.s` 自身将真实 RAM 地址映射为从零开始的组件输出。
`make` 会从 `src/main.s` 编译组件并按 `layout.ld` 组装；`make verify-firmware`
会检查相邻 `dscfw` 仓库统一维护的归一化 CRC32。构建过程不读取官方镜像，也不使用 `-b`。

GNU `as` 会把少数语义等价的 Thumb-1 `ADD`/`SUB` 规范化为不同编码；若不使用
原始操作码指令，便不能满足零售镜像的逐字节要求。因此严格路线改用仓库内的
[Kingcom/armips](https://github.com/Kingcom/armips) 小型兼容补丁；其文档明确支持
ARM7/ARM9 的 ARM/Thumb 模式，并能保留所需编码。详情见
[`tools/armips/README.md`](tools/armips/README.md)。这些严格可读源码中不使用
`.inst` 或 `.hword`。

根目录 `Makefile` 直接调用 `tools/armips/armips.exe`。官方固件的取得与解包只用于
重构前的外部辅助，不是本工程的目标或输入；工程内只使用版本目录 `src/` 下的源码进行
编译、压缩、加密和组装。`h.s` 将私有 Wi-Fi 校准与用户设置范围按归一化规则表示，故无需
存放个人固件数据，仍可验证记录的归一化 CRC32。

| Component | `official_v3` runtime range | `official_v6` runtime range | Execution model |
| --- | --- | --- | --- |
| P1 | `0x02320000`–`0x02330D24` | `0x02320000`–`0x02330E24` | ARM9 / ARMv5TE, mixed ARM and Thumb |
| P2 | `0x037FA800`–`0x038057EC` | `0x037FA800`–`0x03805A04` | ARM7 / ARMv4T, mixed ARM and Thumb |
| P3 | `0x02358D00`–`0x02373CA0` | `0x02358E00`–`0x02373DC0` | ARM9 / ARMv5TE Thumb code |
| P4 | `0x02300200`–`0x0230DB40` | `0x02300200`–`0x0230DB4C` | ARM7 / ARMv4T code |
| P5 | `0x023A4960`–`0x023DF100` | `0x023A4A80`–`0x023DF220` | loaded guide-data region; exported as raw data |

## Nintendo V1–V7 samples

| Directory | P1 | P2 | P3 | P4 | P5 |
| --- | --- | --- | --- | --- | --- |
| [`v1`](retail/v1/) | `0x02320000`–`0x023311C4` | `0x037FA800`–`0x038031A0` | `0x02354F10`–`0x0236FA70` | `0x02300200`–`0x023108AC` | `0x02373D00`–`0x023AE4A0` |
| [`v2`](retail/v2/) | `0x02320000`–`0x023311E4` | `0x037FA800`–`0x038031A0` | `0x02354F30`–`0x0236FAB0` | `0x02300200`–`0x023108B0` | `0x02373D40`–`0x023AE4E0` |
| [`v4`](retail/v4/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v5`](retail/v5/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v7`](retail/v7/) | `0x02320000`–`0x02330B44` | `0x037FA800`–`0x03805AB0` | `0x02358B20`–`0x02373AA0` | `0x02300200`–`0x0230DB4C` | `0x023A4760`–`0x023DEF00` |

P1/P2 bases are decoded from the H descriptor. P3/P4/P5 bases are recovered
from the original loader literals, then checked by decoding the first P3
Thumb `BL`: V1/V2 target `0x02321404`, V4/V5 target `0x02325778`, and V7
targets `0x02325734`, all within their respective P1 components.

## Regional Nintendo samples

| Directory | P1 | P2 | P3 | P4 | P5 |
| --- | --- | --- | --- | --- | --- |
| [`ique_v1`](retail/ique_v1/) | `0x02320000`–`0x023347A4` | `0x037FA800`–`0x03805884` | `0x02364B20`–`0x0237C460` | `0x02300200`–`0x0230DB40` | `0x0237C460`–`0x023DAF00` |
| [`ique_v2`](retail/ique_v2/) | `0x02320000`–`0x02334584` | `0x037FA800`–`0x03805B04` | `0x02364900`–`0x0237C240` | `0x02300200`–`0x0230DB4C` | `0x0237C240`–`0x023DACE0` |
| [`kor_v1`](retail/kor_v1/) | `0x02320000`–`0x02334604` | `0x037FA800`–`0x03805EA0` | `0x02364B80`–`0x0237C4E0` | `0x02300200`–`0x0230DB4C` | `0x0237C4E0`–`0x023C48E0` |

Their P1/P2 bases are decoded from the H descriptor just as for V3/V6. Their
P3 and P5 bases were recovered from the respective P1 load/CRC literal tables;
P5 begins at the effective end of P3 in all three samples. These are Nintendo
firmware region variants, not FlashMe release versions.

## Why these are the runtime addresses

P1 and P2 come directly from the original H descriptor fields.  In both
versions, `part1_ramaddr = 0x4E00`, `part2_ramaddr = 0x0158`, and
`shift_amounts = 0x2CB2`.  Applying the documented descriptor formulas yields
P1 at `0x02320000` and P2 at `0x037FA800`.

P3, P4, and P5 are not guessed from their ROM component offsets.  The original
P1/P2 code contains their RAM load literals:

| Value | V3 source location | V6 source location | Meaning |
| --- | --- | --- | --- |
| P3 base | P1 `0x02326E04`: `0x02358D00` | P1 `0x02326DCC`: `0x02358E00` | ARM9 GUI program target |
| P4 base | P2 `0x037FAAF4`: `0x02300200` | P2 `0x037FAB0C`: `0x02300200` | ARM7 GUI program target |
| P5 base | P1 `0x02326E4C`: `0x023A4960` | P1 `0x02326E14`: `0x023A4A80` | guide-data target |

The V3 P3 entry's first `BL`, when decoded at `0x02358D00`, targets
`0x02325778`, which is inside V3 P1.  This cross-component control-flow result
independently validates the P3 base.  In particular, an earlier convenient
patch-coordinate base of `0x02380000` must not be treated as P3's execution
address; it produces incorrect call destinations.  It can still cancel out in
an assembler expression of the form `headersize + raw-offset`, so correcting
the analysis mapping does not by itself change a generated patch byte.

## Export policy

- P1 was seeded as ARM at component offset `0x0` and Thumb at `0xA0`.
- P2 was seeded as ARM at `0x0`.
- P3 was seeded as Thumb at `0x0`.
- P4 was seeded as ARM at `0x0`.
- P5 has no known execution entry in the original loader path and is therefore
  retained as explicit data bytes rather than speculative code.

External calls remain numeric runtime addresses when their target belongs to a
different loaded region, BIOS, or hardware.  Calls within a component receive
`loc_XXXXXXXX` labels at their target addresses.  Together with the table
above, this keeps component-to-component relationships visible without
inventing names for unverified routines.

---

# 任天堂原始固件分析导出

本目录保存任天堂原始 V1–V7 固件中五个已解压组件的 Ghidra 地址化清单，也保存 iQue V1、
iQue V2 与韩国 V1 三份任天堂地区固件样本的对应清单；不包含原始固件镜像，也不包含解密、
解压后的输入二进制文件。

## 任天堂 V1–V7 样本

| 目录 | P1 | P2 | P3 | P4 | P5 |
| --- | --- | --- | --- | --- | --- |
| [`v1`](retail/v1/) | `0x02320000`–`0x023311C4` | `0x037FA800`–`0x038031A0` | `0x02354F10`–`0x0236FA70` | `0x02300200`–`0x023108AC` | `0x02373D00`–`0x023AE4A0` |
| [`v2`](retail/v2/) | `0x02320000`–`0x023311E4` | `0x037FA800`–`0x038031A0` | `0x02354F30`–`0x0236FAB0` | `0x02300200`–`0x023108B0` | `0x02373D40`–`0x023AE4E0` |
| [`v4`](retail/v4/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v5`](retail/v5/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
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

每份 `p*.s` 都完整覆盖对应组件。Ghidra 识别为代码的部分以 ARM/Thumb 指令输出，未
被识别为代码的字节则保留为 `.byte`。地址注释与 `.create` 均使用实际运行期 RAM 地址，
而不是固件镜像中的组件偏移；常量池载入使用 `pool_` 标签而非固定 PC 偏移。文件可由
版本目录中的 `Makefile` 直接使用 armips 无损重组。

上表给出了每个组件的运行期范围和 CPU 模型。P1/P2 直接由原始 H 描述符解码；P3/P4/P5
则由原始 P1/P2 中实际读取的 RAM 装载常量确定，位置与数值见英文段落中的证据表。

尤其要注意：先前补丁文件中为方便表达“组件原始偏移”所采用的 P3 `0x02380000`，不是
P3 的真实执行地址。V3 P3 从 `0x02358D00` 开始时，入口第一条 `BL` 会正确指向 P1 内
的 `0x02325778`；这构成了独立的交叉控制流验证。单纯修正分析映射并不会自动改变采用
`headersize + 原始偏移` 形式的补丁生成字节，但能避免解释运行时逻辑时得到错误目标。

P5 目前没有原始加载路径可证明的执行入口，因此刻意完整导出为数据，而非猜测性反汇编
为指令。跨组件、BIOS 或硬件的调用保持数值运行地址；同组件内的引用会使用
`loc_XXXXXXXX` 标签。
