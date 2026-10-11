# Nintendo DS Original Firmware

[中文说明](README.zh-cn.md)

`dsofw` is a research and preservation project for Nintendo DS original
firmware.  It currently covers Nintendo V1–V7, iQue V1/V2, and Korean V1.

The project is maintained for firmware study, archival work, compatibility
research, and technical review.  See [Technical Notes](TECHNICAL.md) for the
component layout, runtime addresses, reconstruction method, and analysis
records.

## Version names

F-Writer, Nintendo's official firmware-writing tool, records each firmware
with seven separate fields: console, region, ROM file path, official version
name, timestamp, CRC32, and F-Writer border colour.

This repository uses community short names as its directory names.

| Community name | Official name* |
| --- | --- |
| `v1`–`v5` | `NTR-WORLD WIDE-Ver1.0`–`Ver5.0` |
| `v6` | `USG-WORLD WIDE-Ver2.0` |
| `v7` | `USG-WORLD WIDE-Ver3.0` |
| `ique_v1` | `NTR-CHN [iQue]-Ver1.0` |
| `ique_v2` | `USG-CHN [iQue]-Ver1.0C` |
| `kor_v1` | `USG-KOR-Ver1.0K` |

\* The official-name column writes the console, region, and official-version
fields together for convenient comparison, for example
`NTR-WORLD WIDE-Ver5.0`; it is not a literal single-field value stored by
F-Writer or the firmware image.

F-Writer directly records the constituent console, region, and version fields
for `v4` onward and the remaining entries in the table.  The early NTR names
for `v1`–`v3` are inferred from the naming scheme established by later
confirmed versions.  That scheme is unlikely to differ materially, but other
official names cannot be ruled out.  For the full record structure, evidence,
timestamps, and regional mapping, see [NDS firmware and FlashMe history](https://wokann.github.io/2026/04/28/DS-firmware-history.html)
and [TCRF's Nintendo DS documentation](https://tcrf.net/Nintendo_DS).

### F-Writer and firmware updates

The following observations support one possible inference about F-Writer's
role:

1. F-Writer retains firmware information from `v4` onward, but no
   corresponding information for `v1`–`v3`.
2. `v4` and `ique_v1`, both recorded by F-Writer, are contemporaneous and
   both close the vulnerabilities used by PassMe1 and WiFiMe.
3. F-Writer itself must run on a console that can already boot normally.
4. Community reports describe in-person service upgrades of console firmware.

Taken together, one possible inference is that, after `v4` was released,
Nintendo service staff could use F-Writer while repairing early-version
consoles to reflash them with the then-current firmware, possibly to prevent
the use of PassMe1 and WiFiMe.  This is an inference, not a documented
Nintendo policy or motive.

## Building

Run `make` in [`retail/`](retail/) to rebuild every listed firmware variant,
or enter a version directory to build that version alone.  Run
`make verify-firmware` to compare rebuilt images with the recorded normalised
CRC32 values.

## Related project

[dscfw](https://github.com/Wokann/dscfw) is the companion repository for
Nintendo DS custom-firmware source reconstructions, including FlashMe and the
DS Lite TV-out firmware modification.  `dsofw` records and reconstructs the
original firmware variants used for analysis; `dscfw` contains the historical
custom-firmware reconstruction projects built from that research.

## Copyright

Nintendo, Nintendo DS, iQue, and the original firmware are the property of
their respective rightsholders.  This project is not affiliated with or
endorsed by Nintendo or iQue.  The bundled `tools/armips/armips.exe` is this
project's patched armips build from the
[`flashme-arm-immediate-encoding`](https://github.com/Wokann/armips/tree/flashme-arm-immediate-encoding)
branch; see its local [tool documentation](tools/armips/README.md).
