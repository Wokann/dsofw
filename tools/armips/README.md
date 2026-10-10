# dsofw armips build

[中文说明](README.zh-cn.md)

`armips.exe` in this directory is the patched build used by `dsofw`.  The
firmware Makefiles call this executable directly; use it rather than an
unmodified armips release when rebuilding the recorded firmware variants.

`0001-armv4t-ldrh-writeback.patch` documents the local change: it adds valid
ARMv4T pre-indexed writeback forms for `LDRH`, `LDRSB`, and `LDRSH`, with both
immediate and register offsets.  Current sources require `LDRH [Rn,#imm]!`.
The patch does not change existing encoding selection.

## Custom source branch

The source for this build is maintained in
[Wokann/armips, branch `flashme-arm-immediate-encoding`](https://github.com/Wokann/armips/tree/flashme-arm-immediate-encoding).
It is based on armips revision `62adab4ef30da765f5cf22a451eb08a59c54dc8b` and
retains the upstream MIT licence.  The checked-in executable and patch are the
tooling used by the firmware Makefiles.
