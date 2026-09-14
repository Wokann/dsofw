.nds

; Shared hardware names and recovered v4 runtime symbols.
; 各组件共享的硬件名称与已恢复的 v4 运行期符号。
.include "../../include/common.inc"
.include "../../include/official_v4_sym.inc"

; Each source owns one output via .create; this entry only supplies the
; common symbol scope and inclusion order. 每个源文件通过 .create 输出一个组件；
; 此入口只提供共享符号域与包含顺序。
.include "src/h.s"
.include "src/p1.s"
.include "src/p2.s"
.include "src/p3.s"
.include "src/p4.s"
.include "src/p5.s"
