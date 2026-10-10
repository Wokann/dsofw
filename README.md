# Nintendo DS Original Firmware

[中文说明](README.zh-cn.md)

`dsofw` is a research and preservation project for Nintendo DS original
firmware.  It currently covers Nintendo V1–V7, iQue V1/V2, and Korean V1.

The project is maintained for firmware study, archival work, compatibility
research, and technical review.  See [Technical Notes](TECHNICAL.md) for the
component layout, runtime addresses, reconstruction method, and analysis
records.

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
