# armips compatibility patch

The strict reconstruction route uses [Kingcom/armips](https://github.com/Kingcom/armips)
because its Thumb parser retains the retail imm3 encodings that GNU as
canonicalises. The tested upstream revision is
`62adab4ef30da765f5cf22a451eb08a59c54dc8b`.

Apply `0001-armv4t-ldrh-writeback.patch` before building armips. It adds the
valid ARMv4T pre-indexed-writeback forms for `LDRH`, `LDRSB`, and `LDRSH`, with
both immediate and register offsets. Current firmware sources require only
`LDRH [Rn,#imm]!`; the complete load-family fix keeps future readable sources
from needing raw opcodes. It does not change any existing encoding selection.

```text
git clone https://github.com/Kingcom/armips.git
cd armips
git checkout 62adab4ef30da765f5cf22a451eb08a59c54dc8b
git apply /path/to/dsofw/tools/armips/0001-armv4t-ldrh-writeback.patch
cmake -S . -B build -DARMIPS_USE_STD_FILESYSTEM=ON
cmake --build build --target armips-bin
```

The maintained local working branch is
`D:\Project\Tool\_develop\PC\53_ARMIPS\armips`, branch
`codex/dsofw-armv4t-halfword-writeback`.  Its built executable is shared at
`dsofw/tools/armips/armips.exe`; each version directory invokes it directly
through its own `Makefile` and `p1.s`–`p5.s` sources.

---

# armips 兼容补丁

严格重建路线使用 [Kingcom/armips](https://github.com/Kingcom/armips)，因为它的
Thumb 解析器会保留 GNU as 会规范化掉的零售版 imm3 编码。已验证的上游版本为
`62adab4ef30da765f5cf22a451eb08a59c54dc8b`。

在构建 armips 前应用 `0001-armv4t-ldrh-writeback.patch`。补丁补充了
`LDRH`、`LDRSB`、`LDRSH` 三类合法 ARMv4T 预索引写回形式，覆盖立即数与寄存器
偏移。当前固件源码只需要 `LDRH [Rn,#imm]!`，但完整修复可避免后续可读源码依赖
原始操作码；它不改变既有编码选择。

当前维护的本地工作分支位于
`D:\Project\Tool\_develop\PC\53_ARMIPS\armips`，分支名为
`codex/dsofw-armv4t-halfword-writeback`。构建后的公共程序位于
`dsofw/tools/armips/armips.exe`；每个版本目录均直接以自己的 `Makefile` 和
`p1.s`–`p5.s` 调用它。
