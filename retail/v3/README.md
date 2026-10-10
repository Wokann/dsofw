# `official_v3` component listings

[中文说明](README.zh-cn.md)

The five listings in this directory are the decompressed original Nintendo
firmware V3 components, mapped to their observed runtime addresses.  See the
[Technical Notes](../../TECHNICAL.md) for loader-literal evidence, CPU
selection, and export policy.

| File | Runtime address | Raw component size |
| --- | --- | --- |
| `src/p1.s` | `0x02320000` | `0x10D24` |
| `src/p2.s` | `0x037FA800` | `0xAFEC` |
| `src/p3.s` | `0x02358D00` | `0x1AFA0` |
| `src/p4.s` | `0x02300200` | `0xD940` |
| `src/p5.s` | `0x023A4960` | `0x3A7A0` |

`src/main.s` organises `src/h.s` and `src/p1.s`–`src/p5.s`.  Run `make` to
rebuild the version or `make verify-firmware` to check its normalised CRC32.
