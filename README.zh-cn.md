# 任天堂 DS 原始固件

[English README](README.md)

`dsofw` 是任天堂 DS 原始固件的研究与保存工程，当前涵盖任天堂 V1–V7、iQue V1/V2 与
韩国 V1。

项目用于固件学习、资料保存、兼容性研究与技术审阅。组件布局、运行期地址、重建方式和分析
记录见[技术说明](TECHNICAL.zh-cn.md)。

## 版本命名

F-Writer 是任天堂官方的固件刷写工具；其数据以七项独立字段记录每个固件：机型、地区、
ROM 内文件路径、官方版本号、时间戳、CRC32 与 F-Writer 边框颜色。

本仓库的目录直接采用民间社区的简写。

| 民间社区名称 | 官方名称* |
| --- | --- |
| `v1`–`v5` | `NTR-WORLD WIDE-Ver1.0`–`Ver5.0` |
| `v6` | `USG-WORLD WIDE-Ver2.0` |
| `v7` | `USG-WORLD WIDE-Ver3.0` |
| `ique_v1` | `NTR-CHN [iQue]-Ver1.0` |
| `ique_v2` | `USG-CHN [iQue]-Ver1.0C` |
| `kor_v1` | `USG-KOR-Ver1.0K` |

\* 官方名称列为便于对照，将机型、地区与官方版本号三个字段连写，例如
`NTR-WORLD WIDE-Ver5.0`；它不是 F-Writer 或固件镜像中原样存在的单一字段值。

F-Writer 的记录直接确认了 `v4` 以后及表内其余条目的机型、地区与版本字段；`v1`–`v3` 的早期
NTR 正式名称为后续确定版本命名方式反推而得，理论上命名方式不会有太大偏差，但也不排除官方
存在其他命名的可能性。完整数据结构、证据、时间戳与地区对应关系见
[NDS 固件及 FlashMe 历史梳理](https://wokann.github.io/2026/04/28/DS-firmware-history.html)和
[TCRF 的 Nintendo DS 资料页](https://tcrf.net/Nintendo_DS)。

### F-Writer 与固件升级

以下线索支持对 F-Writer 用途的一种推测：

1. F-Writer 内只留有从 `v4` 开始的固件信息，没有 `v1`–`v3` 的对应信息。
2. `v4` 与 `ique_v1`（F-Writer 中也记录有信息）是同期的固件版本，均封堵了 PassMe1、WiFiMe
   所利用的漏洞。
3. F-Writer 本身必须在已经能够正常启动的主机上运行。
4. 社区曾反馈线下客服会升级玩家主机固件版本。

基于以上信息，一种可能的推测是：`v4` 发布后，任天堂客服会在维修早期版本的主机时，使用
F-Writer 将其刷写为当时的最新固件，目的可能是封锁这些主机使用 PassMe1、WiFiMe 的可能性。
这只是推测，并非已证实的任天堂政策或动机。

## 构建

在 [`retail/`](retail/) 目录运行 `make` 可重建全部已收录固件变体；进入某个版本目录后运行
`make` 则只构建该版本。运行 `make verify-firmware` 可将重建镜像与记录的归一化 CRC32 比较。

## 关联项目

[dscfw](https://github.com/Wokann/dscfw) 是任天堂 DS 自制固件源码重建的配套仓库，收录
FlashMe 和 DS Lite TV-out 固件修改等项目。`dsofw` 保存并重建用于分析的原始固件变体；
`dscfw` 则保存基于这些研究资料的历史自制固件重建工程。

## 版权

Nintendo、Nintendo DS、iQue 及原始固件的权利均归各自权利人所有；本项目与 Nintendo、
iQue 不存在隶属、授权或背书关系。随附的 `tools/armips/armips.exe` 是本项目使用的
补丁版 armips，来自
[`flashme-arm-immediate-encoding`](https://github.com/Wokann/armips/tree/flashme-arm-immediate-encoding)
分支，详见其[本地工具说明](tools/armips/README.zh-cn.md)。
