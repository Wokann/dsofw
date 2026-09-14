# `official_v3` component listings

The five listings in this directory are the decompressed original Nintendo
firmware V3 components, mapped to their observed runtime addresses.  See the
parent [README](../README.md) for the loader-literal evidence, CPU selection,
and export limitations.

| File | Runtime address | Raw component size |
| --- | --- | --- |
| `src/p1.s` | `0x02320000` | `0x10D24` |
| `src/p2.s` | `0x037FA800` | `0xAFEC` |
| `src/p3.s` | `0x02358D00` | `0x1AFA0` |
| `src/p4.s` | `0x02300200` | `0xD940` |
| `src/p5.s` | `0x023A4960` | `0x3A7A0` |

---

# `official_v3` 组件清单

本目录的五份清单是已解压的任天堂原始 V3 固件组件，已映射到观察到的实际运行期地址。
装载常量证据、CPU 选择和导出限制请参阅上级 [README](../README.md)。本目录的
`src/main.s` 会组织 `src/h.s` 与 `src/p1.s`–`src/p5.s`，可直接由 armips 重建；
运行 `make`，或运行 `make verify-firmware` 校验相邻 `dscfw` 仓库的归一化 CRC32。官方镜像的
取得与解包只属于重构前的外部辅助，不是此构建的输入。
