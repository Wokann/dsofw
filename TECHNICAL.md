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
the read-only normalised CRC32 record in that version directory. Build tools,
shared includes and checksum records are provided by this project; no sibling
repository is required.

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
| P5 | `0x023A4960`–`0x023DF100` | `0x023A4A80`–`0x023DF220` | loaded shared UI resource data |

## Nintendo V1–V7 samples

| Directory | P1 | P2 | P3 | P4 | P5 |
| --- | --- | --- | --- | --- | --- |
| [`v1`](retail/v1/) | `0x02320000`–`0x023311C4` | `0x037FA800`–`0x038031A0` | `0x02354F10`–`0x0236FA70` | `0x02300200`–`0x023108AC` | `0x0239F0E0`–`0x023D9880` |
| [`v2`](retail/v2/) | `0x02320000`–`0x023311E4` | `0x037FA800`–`0x038031A0` | `0x02354F30`–`0x0236FAB0` | `0x02300200`–`0x023108B0` | `0x0239F120`–`0x023D98C0` |
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
- P5 has no known execution entry in the original loader path and is retained
  as resource structures and explicit data rather than speculative code.

Confirmed intra-component and cross-component targets use labels at their
actual positions. Unconfirmed targets retain numeric runtime addresses.
Neutral `loc_XXXXXXXX` labels may remain beside functional labels without
inventing names for unverified routines.

## Shared P5 resources

All ten P5 components contain the following 100 identified top-level resource containers. Source labels express
directories, relative offsets, record counts and file sizes. Unknown fields,
padding and payload bytes retain their original values. Component offsets,
runtime RAM addresses and standalone NDS file offsets are distinct coordinates.

| Format | Count per version | Recovered structure |
| --- | --- | --- |
| BNFR font (`JNFR` signature) | 4 | Version, glyph count, packed width/height, two metric bytes per glyph and 1bpp bitmaps |
| BNCMP character map (`JNCM` signature) | 4 | Inclusive Unicode ranges and explicit code points; both offsets are relative to container `+8` |
| BMG messages | 6 | UTF-8 text, INF1 index and DAT1 payload; 164 shared firmware messages per language |
| BNCD graphic cells (`JNCD` signature) | 4 | 28-byte header, 6-byte directory entries, 12-byte auxiliary records and graphic payload |
| SDAT sound archive | 1 | INFO, FAT and FILE; SSAR/SBNK/SWAR files, including 50 SSAR sequence entries |
| BNBL button layouts (`JNBL` signature) | 19 | 6-byte entries: packed X/Y coordinates and origins, byte width and height |
| BNCL cell layouts (`JNCL` signature) | 31 | 8-byte entries: packed X/Y coordinates and origins, cell index |
| BNLL text layouts (`JNLL` signature) | 31 | 12-byte entries: position, spacing, font/palette/color and text offset; optional UTF-16 strings follow |

Each version stores complete resource files by purpose:

| Directory | Files |
| --- | --- |
| `src/graphic/` | `font_00.bnfr` through `font_03.bnfr`, `font_map_00.bncmp` through `font_map_03.bncmp`, and `cells_00.bncd` through `cells_03.bncd` |
| `src/text/` | `messages_ja.bmg`, `messages_en.bmg`, `messages_fr.bmg`, `messages_de.bmg`, `messages_it.bmg`, `messages_es.bmg`; iQue substitutes `zh` for `ja`, Korean substitutes `ko` for `it` |
| `src/sound/` | `system.sdat` and its subfiles `sequences.ssar`, `bank.sbnk`, `waves.swar` |
| `src/layout/` | `buttons_00.bnbl` through `buttons_18.bnbl`, `cells_00.bncl` through `cells_30.bncl`, `text_00.bnll` through `text_30.bnll` |

Extensions identify the confirmed formats; every file includes its complete
original header and data. See the
[BNFR](https://wiki.dshack.org/Wiki.jsp?page=BNFR+File+Format) and
[BNCD](https://wiki.dshack.org/Wiki.jsp?page=BNCD) structure descriptions.

Fonts, character maps, graphic cells, BMG and SDAT have matching `.s` files.
Layouts are grouped in `src/layout/buttons.s`, `cells.s` and `text.s`. These
sources are included by `p5.s` in their original order within the shared
component symbol scope. Headers, directories, indices,
character maps and ordinary messages remain readable assembly. Segmented
`.incbin` directives select reserved fields, metrics, bitmaps, graphics and
sound data from the complete format files. Edit message text in
`src/text/messages_*.s`, which retains readable strings, control sequences and
per-message labels. Audio keeps its original event and sample encoding rather
than being transcoded to WAV. These files are build inputs; building does not
require unpacking a firmware image. Unclassified data outside these resource
ranges remains in `p5.s`.

BNCMP glyph indices enumerate the ranges first, followed by the explicit code
points. Counts are linked to the corresponding BNFR font.
The three ASCII software-keyboard character sets and five extended character
tables are kept separately in `src/text/keyboard.s`, preserving their original
UTF-16 data, BOMs and private glyph codes. They are distinct from the BNCMP
font-index maps.

Layout fields can be cross-checked against the
[jnlib layout format](https://wiki.dshack.org/Wiki.jsp?page=Jnlib+Layout+File+Format),
[BNBL](https://wiki.dshack.org/Wiki.jsp?page=BNBL),
[BNCL](https://wiki.dshack.org/Wiki.jsp?page=BNCL) and
[BNLL](https://wiki.dshack.org/Wiki.jsp?page=BNLL) descriptions.
In this firmware, nonzero BNLL text offsets are relative to the container
start and point to UTF-16 strings after the entry array. Zero retains the
absence of stored text. The purpose of the header word at `0x04` remains
unconfirmed; its original value is preserved. `src/layout/text.s` keeps these
strings readable and loads `include/p5-utf16le.tbl` only within that file,
restoring the original table afterward.

The international BMG language slots are Japanese, English, French, German,
Italian and Spanish. iQue uses Chinese in slot 0; Korean uses Korean in slot 4.
These messages are shared by the whole firmware, not separate 164-message sets
for PictoChat and Download Play. INF1 offsets are relative to the DAT1 text
payload. Control sequences, private glyphs and terminators retain explicit
bytes; ordinary text is written as readable strings. `include/utf8.tbl` encodes
those source characters back to their original UTF-8 bytes; it adds no font
resources. The layout can be cross-checked against
[ndspy's BMG reader](https://github.com/RoadrunnerWMC/ndspy/blob/master/ndspy/bmg.py).

SDAT FAT file offsets are relative to SDAT, INFO table offsets to INFO, and
SSAR sequence offsets to the sequence-event data. Corresponding labels calculate
these offsets and sizes. International V1/V2 and V3–V7 P5 differ in only three
bytes, all within SDAT:

| P5 offset | V1/V2 | V3–V7 | SSAR field (ndspy naming) |
| --- | --- | --- | --- |
| `0x731D` | `0x0A` | `0x08` | Sequence 29 `playerID` |
| `0x73B9` | `0x0F` | `0x0E` | Sequence 42 `playerID` |
| `0x73C4` | `0x40` | `0x46` | Sequence 43 `polyphonicPressure` |

Sequence numbers are zero-based. See
[ndspy's SSAR reader](https://github.com/RoadrunnerWMC/ndspy/blob/master/ndspy/soundSequenceArchive.py)
for field layout. Their exact hardware effects have not been independently
tested; reconstruction preserves each version's values. All four fonts, four
character maps and six message groups match across international V1–V7.
The complete iQue V1/V2 P5 components are identical.

Lossless parsing and writing establish the JNCD directory and auxiliary-record
boundaries, but not every record's display meaning or complete pixel/palette
reassembly. Payload matches against DSi/3DS references do not establish whole
container or application-code equivalence. DS message IDs are not directly
interchangeable with the DSi standalone applications' 138-message sets.
