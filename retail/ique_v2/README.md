# Nintendo iQue V2 component listings

[中文说明](README.zh-cn.md)

The five files in this directory are address-oriented Ghidra exports of the
decompressed Nintendo iQue V2 firmware components. They are reverse-engineering
listings, not claimed GNU `as` sources. P1/P3 use ARM9 execution mode; P2/P4
use ARM7 execution mode; P5 is retained as explicit data.

| File | Runtime address | Raw component size |
| --- | --- | --- |
| `p1.s` | `0x02320000` | `0x14584` |
| `p2.s` | `0x037FA800` | `0xB304` |
| `p3.s` | `0x02364900` | `0x17940` |
| `p4.s` | `0x02300200` | `0xD94C` |
| `p5.s` | `0x0237C240` | `0x5EAA0` |

See the [Technical Notes](../../TECHNICAL.md) for export policy and
load-address evidence.
