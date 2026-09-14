# Nintendo Korean V1 component listings

The five files in this directory are address-oriented Ghidra exports of the
decompressed Nintendo Korean V1 firmware components. They are reverse-engineering
listings, not claimed GNU `as` sources. P1/P3 use ARM9 execution mode; P2/P4
use ARM7 execution mode; P5 is retained as explicit data.

| File | Runtime address | Raw component size |
| --- | --- | --- |
| `p1.s` | `0x02320000` | `0x14604` |
| `p2.s` | `0x037FA800` | `0xB6A0` |
| `p3.s` | `0x02364B80` | `0x17960` |
| `p4.s` | `0x02300200` | `0xD94C` |
| `p5.s` | `0x0237C4E0` | `0x48400` |

See the parent [README](../README.md) for export policy and load-address
evidence.

---

# 任天堂韩国 V1 组件清单

本目录的五个文件是任天堂韩国 V1 已解压组件的 Ghidra 地址化导出。它们用于逆向分析，
可直接由 armips 重组。P1/P3 为 ARM9 执行模式，P2/P4 为 ARM7 执行模式，
P5 保留为显式数据。

各组件的运行期地址与原始长度见上表；导出策略和装载地址证据见上级
[README](../README.md)。
