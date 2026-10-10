# 任天堂 DS 原始固件

[English README](README.md)

`dsofw` 是任天堂 DS 原始固件的研究与保存工程，当前涵盖任天堂 V1–V7、iQue V1/V2 与
韩国 V1。

项目用于固件学习、资料保存、兼容性研究与技术审阅。组件布局、运行期地址、重建方式和分析
记录见[技术说明](TECHNICAL.zh-cn.md)。

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
