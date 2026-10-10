# dsofw armips 构建

[English README](README.md)

本目录的 `armips.exe` 是 `dsofw` 使用的补丁版构建。各固件 Makefile 会直接调用此
可执行文件；重建已记录的固件变体时，应使用它而不是未修改的 armips 发布版。

`0001-armv4t-ldrh-writeback.patch` 记录了本地改动：补丁补充 `LDRH`、`LDRSB`、
`LDRSH` 三类合法 ARMv4T 预索引写回形式，覆盖立即数与寄存器偏移。当前源码需要
`LDRH [Rn,#imm]!`；补丁不改变既有编码选择。

## 专用源码分支

该构建的源码维护在
[Wokann/armips 的 `flashme-arm-immediate-encoding` 分支](https://github.com/Wokann/armips/tree/flashme-arm-immediate-encoding)。
它基于 armips 的 `62adab4ef30da765f5cf22a451eb08a59c54dc8b` 修订，并保留上游 MIT
许可证。仓库内的可执行文件与补丁才是固件 Makefile 所使用的工具。
