# Technical Notes: Nintendo DS Original Firmware

[中文说明](TECHNICAL.zh-cn.md) · [Project README](README.md)

## Direct strict readable reassembly

Every version directory contains byte-exact armips sources under `src/`:
`h.s`, `p1.s`–`p5.s`, and `rsa.s` for iQue/Korean variants.  P1–P4 use
ARM/Thumb instructions and intra-component `loc_` labels; P5 remains explicit
data because no execution entry has been confirmed in the original loader.
Each `src/p*.s` maps its runtime RAM address to a zero-based component output.
`make` compiles the source inputs and `dsfwtool` packs them according to the
version-local `layout.ld`.  `make verify-firmware` compares the result with
the normalised CRC32 record maintained in the sibling `dscfw` repository.

GNU `as` canonicalises some semantically identical Thumb-1 `ADD`/`SUB` forms
to different encodings, so it cannot meet the retail byte-exact requirement
without raw-opcode directives.  The strict route uses the bundled patched
armips build, which accepts the required ARMv4T forms while preserving the
required encodings.  See [`tools/armips/README.md`](tools/armips/README.md).
No `.inst` or `.hword` is used in these readable strict sources.

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
| [`v3`](retail/v3/) | `0x02320000`–`0x02330D24` | `0x037FA800`–`0x038057EC` | `0x02358D00`–`0x02373CA0` | `0x02300200`–`0x0230DB40` | `0x023A4960`–`0x023DF100` |
| [`v4`](retail/v4/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v5`](retail/v5/) | `0x02320000`–`0x02330DE4` | `0x037FA800`–`0x03805830` | `0x02358DC0`–`0x02373D40` | `0x02300200`–`0x0230DB40` | `0x023A4A00`–`0x023DF1A0` |
| [`v6`](retail/v6/) | `0x02320000`–`0x02330E24` | `0x037FA800`–`0x03805A04` | `0x02358E00`–`0x02373DC0` | `0x02300200`–`0x0230DB4C` | `0x023A4A80`–`0x023DF220` |
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
