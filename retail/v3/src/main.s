.nds

; Shared hardware names and recovered v3 runtime symbols.
; 各组件共享的硬件名称与已恢复的 v3 运行期符号。
.include "../../include/common.inc"
.include "../../include/official_v3_sym.inc"

; Each source owns one output via .create. Inclusion here establishes one
; shared armips symbol scope, so P1/P2/P3 .func labels may be called across
; components. 每个源文件通过 .create 输出一个组件；此入口建立共享符号域，
; 让 P1/P2/P3 的 .func 可跨组件调用。
.include "src/h.s"
.include "src/p1.s"
.include "src/p2.s"
.include "src/p3.s"
.include "src/p4.s"
.include "src/p5.s"
