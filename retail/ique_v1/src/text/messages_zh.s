; BMG resource; included by p5.s at P5_Messages_Chinese.
; BMG 资源，由 p5.s 在 P5_Messages_Chinese 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_Chinese_End - P5_Messages_Chinese
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_zh.bmg", 0x11, 0xF ; original format bytes / 原始格式字节
P5_Messages_Chinese_Info:
    .ascii "INF1"
    .word P5_Messages_Chinese_Data - P5_Messages_Chinese_Info
    .dh (P5_Messages_Chinese_EntriesEnd - P5_Messages_Chinese_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_Chinese_Entries:
    .word P5_Messages_Chinese_Msg000 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg001 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg002 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg003 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg004 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg005 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg006 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg007 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg008 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg009 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg010 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg011 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg012 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg013 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg014 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg015 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg016 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg017 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg018 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg019 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg020 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg021 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg022 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg023 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg024 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg025 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg026 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg027 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg028 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg029 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg030 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg031 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg032 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg033 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg034 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg035 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg036 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg037 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg038 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg039 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg040 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg041 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg042 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg043 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg044 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg045 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg046 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg047 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg048 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg049 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg050 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg051 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg052 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg053 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg054 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg055 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg056 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg057 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg058 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg059 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg060 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg061 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg062 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg063 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg064 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg065 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg066 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg067 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg068 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg069 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg070 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg071 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg072 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg073 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg074 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg075 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg076 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg077 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg078 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg079 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg080 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg081 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg082 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg083 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg084 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg085 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg086 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg087 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg088 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg089 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg090 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg091 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg092 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg093 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg094 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg095 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg096 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg097 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg098 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg099 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg100 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg101 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg102 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg103 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg104 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg105 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg106 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg107 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg108 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg109 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg110 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg111 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg112 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg113 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg114 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg115 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg116 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg117 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg118 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg119 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg120 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg121 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg122 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg123 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg124 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg125 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg126 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg127 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg128 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg129 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg130 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg131 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg132 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg133 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg134 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg135 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg136 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg137 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg138 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg139 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg140 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg141 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg142 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg143 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg144 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg145 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg146 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg147 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg148 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg149 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg150 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg151 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg152 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg153 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg154 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg155 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg156 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg157 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg158 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg159 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg160 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg161 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg162 - P5_Messages_Chinese_Text
    .word P5_Messages_Chinese_Msg163 - P5_Messages_Chinese_Text
P5_Messages_Chinese_EntriesEnd:
P5_Messages_Chinese_Data:
    .ascii "DAT1"
    .word P5_Messages_Chinese_End - P5_Messages_Chinese_Data
P5_Messages_Chinese_Text:
    .byte 0x00
P5_Messages_Chinese_Msg000:
    .stringn "校准完毕。请点触"
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "进行测试。"
    .byte 0x00
P5_Messages_Chinese_Msg001:
    .stringn "按"
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "键取消"
    .byte 0x00
P5_Messages_Chinese_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .stringn " 重试"
    .byte 0x00
P5_Messages_Chinese_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 关闭"
    .byte 0x00
P5_Messages_Chinese_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 是"
    .byte 0x00
P5_Messages_Chinese_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 否"
    .byte 0x00
P5_Messages_Chinese_Msg006:
    .stringn "生日快乐！"
    .byte 0x0A ; line break / 换行
    .stringn "今天是∩的生日！"
    .byte 0x00
P5_Messages_Chinese_Msg007:
    .stringn "∩已经转移到聊天室⊿。"
    .byte 0x00
P5_Messages_Chinese_Msg008:
    .stringn "加入 ⊿: ∩"
    .byte 0x00
P5_Messages_Chinese_Msg009:
    .stringn "退出 ⊿: ∩"
    .byte 0x00
P5_Messages_Chinese_Msg010:
    .byte 0xEE, 0x80, 0xB0 ; U+E030 glyph / 字形
    .byte 0xEE, 0x80, 0xB1 ; U+E031 glyph / 字形
    .byte 0xEE, 0x80, 0xB2 ; U+E032 glyph / 字形
    .byte 0xEE, 0x80, 0xB3 ; U+E033 glyph / 字形
    .byte 0xEE, 0x80, 0x88 ; U+E008 glyph / 字形
    .byte 0xEE, 0x80, 0xB2 ; U+E032 glyph / 字形
    .byte 0xEE, 0x80, 0xB4 ; U+E034 glyph / 字形
    .byte 0xEE, 0x80, 0xB5 ; U+E035 glyph / 字形
    .byte 0xEE, 0x80, 0xB3 ; U+E033 glyph / 字形
    .byte 0x00
P5_Messages_Chinese_Msg011:
    .stringn "聊天室A"
    .byte 0x00
P5_Messages_Chinese_Msg012:
    .stringn "聊天室B"
    .byte 0x00
P5_Messages_Chinese_Msg013:
    .stringn "聊天室C"
    .byte 0x00
P5_Messages_Chinese_Msg014:
    .stringn "聊天室D"
    .byte 0x00
P5_Messages_Chinese_Msg015:
    .stringn "请选择聊天室。"
    .byte 0x00
P5_Messages_Chinese_Msg016:
    .stringn "请选择颜色"
    .byte 0x00
P5_Messages_Chinese_Msg017:
    .stringn "取消"
    .byte 0x00
P5_Messages_Chinese_Msg018:
    .stringn "确定"
    .byte 0x00
P5_Messages_Chinese_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .stringn " 开启闹钟"
    .byte 0x00
P5_Messages_Chinese_Msg020:
    .stringn "小时"
    .byte 0x00
P5_Messages_Chinese_Msg021:
    .stringn "分钟"
    .byte 0x00
P5_Messages_Chinese_Msg022:
    .stringn "日"
    .byte 0x00
P5_Messages_Chinese_Msg023:
    .stringn "月"
    .byte 0x00
P5_Messages_Chinese_Msg024:
    .stringn "当您打开电源时， 将自动"
    .byte 0x0A ; line break / 换行
    .stringn "出现iQue DS菜单画面。"
    .byte 0x00
P5_Messages_Chinese_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .stringn " 自动模式"
    .byte 0x00
P5_Messages_Chinese_Msg026:
    .stringn "如果打开电源时，iQue DS里"
    .byte 0x0A ; line break / 换行
    .stringn "已经插入了iQue DS或iQue GBA"
    .byte 0x0A ; line break / 换行
    .stringn "游戏卡， 游戏将自动开始。"
    .byte 0x00
P5_Messages_Chinese_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .stringn " 手动模式"
    .byte 0x00
P5_Messages_Chinese_Msg028:
    .stringn "日"
    .byte 0x00
P5_Messages_Chinese_Msg029:
    .stringn "月"
    .byte 0x00
P5_Messages_Chinese_Msg030:
    .stringn "年"
    .byte 0x00
P5_Messages_Chinese_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 确定"
    .byte 0x00
P5_Messages_Chinese_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 输入"
    .byte 0x00
P5_Messages_Chinese_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 加入"
    .byte 0x00
P5_Messages_Chinese_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_Chinese_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 选择"
    .byte 0x00
P5_Messages_Chinese_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_Chinese_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 是"
    .byte 0x00
P5_Messages_Chinese_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 返回"
    .byte 0x00
P5_Messages_Chinese_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 取消"
    .byte 0x00
P5_Messages_Chinese_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 删除"
    .byte 0x00
P5_Messages_Chinese_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 否"
    .byte 0x00
P5_Messages_Chinese_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 退出"
    .byte 0x00
P5_Messages_Chinese_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_Chinese_Msg044:
    .stringn "涂鸦聊天"
    .byte 0x00
P5_Messages_Chinese_Msg045:
    .stringn "无iQue DS游戏卡。"
    .byte 0x00
P5_Messages_Chinese_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_Chinese_Msg047:
    .stringn "开始iQue GBA游戏。"
    .byte 0x00
P5_Messages_Chinese_Msg048:
    .stringn "无iQue GBA游戏卡。"
    .byte 0x00
P5_Messages_Chinese_Msg049:
    .stringn "已插入iQue DS扩展卡。"
    .byte 0x00
P5_Messages_Chinese_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_Chinese_Msg051:
    .stringn "设定"
    .byte 0x00
P5_Messages_Chinese_Msg052:
    .stringn "iQue DS下载游戏"
    .byte 0x00
P5_Messages_Chinese_Msg053:
    .stringn "否"
    .byte 0x00
P5_Messages_Chinese_Msg054:
    .stringn "是"
    .byte 0x00
P5_Messages_Chinese_Msg055:
    .stringn "闹钟已关闭。"
    .byte 0x00
P5_Messages_Chinese_Msg056:
    .stringn "您想关闭闹钟吗？"
    .byte 0x00
P5_Messages_Chinese_Msg057:
    .stringn "闹钟时间已设定在●●:●●。"
    .byte 0x0A ; line break / 换行
    .stringn "您想开启闹钟吗？"
    .byte 0x00
P5_Messages_Chinese_Msg058:
    .stringn "您是否想要为闹钟开启"
    .byte 0x0A ; line break / 换行
    .stringn "震动功能？"
    .byte 0x00
P5_Messages_Chinese_Msg059:
    .stringn "通讯错误。"
    .byte 0x0A ; line break / 换行
    .stringn "返回聊天室选择画面。"
    .byte 0x00
P5_Messages_Chinese_Msg060:
    .stringn "聊天室⊿已满。"
    .byte 0x0A ; line break / 换行
    .stringn "您无法进入。"
    .byte 0x00
P5_Messages_Chinese_Msg061:
    .stringn "通讯错误。"
    .byte 0x0A ; line break / 换行
    .stringn "请关闭电源。"
    .byte 0x00
P5_Messages_Chinese_Msg062:
    .stringn "正在下载……"
    .byte 0x00
P5_Messages_Chinese_Msg063:
    .stringn "已取消下载。"
    .byte 0x00
P5_Messages_Chinese_Msg064:
    .stringn "参与人数已达上限。"
    .byte 0x0A ; line break / 换行
    .stringn "无法下载。"
    .byte 0x00
P5_Messages_Chinese_Msg065:
    .stringn "游戏已成功下载。"
    .byte 0x00
P5_Messages_Chinese_Msg066:
    .stringn "开始前，您必须先设定系"
    .byte 0x0A ; line break / 换行
    .stringn "统。请点触触摸屏或是按"
    .byte 0x0A ; line break / 换行
    .stringn "任意键继续。"
    .byte 0x00
P5_Messages_Chinese_Msg067:
    .stringn "请点触触摸屏或按任意键确"
    .byte 0x0A ; line break / 换行
    .stringn "定系统的设定。"
    .byte 0x00
P5_Messages_Chinese_Msg068:
    .stringn "语言设定将更改为中文。"
    .byte 0x0A ; line break / 换行
    .stringn "可以吗？"
    .byte 0x00
P5_Messages_Chinese_Msg069:
    .stringn "您想下载这个游戏吗？"
    .byte 0x00
P5_Messages_Chinese_Msg070:
    .stringn "恢复通讯？"
    .byte 0x00
P5_Messages_Chinese_Msg071:
    .stringn "通讯错误。"
    .byte 0x0A ; line break / 换行
    .stringn "无法完成下载。"
    .byte 0x00
P5_Messages_Chinese_Msg072:
    .stringn "iQue DS将关闭。"
    .byte 0x00
P5_Messages_Chinese_Msg073:
    .stringn "要使新的设定生效，您必须"
    .byte 0x0A ; line break / 换行
    .stringn "重启iQue DS。立即重启吗？"
    .byte 0x00
P5_Messages_Chinese_Msg074:
    .stringn "寻找可下载的游戏……"
    .byte 0x00
P5_Messages_Chinese_Msg075:
    .stringn "已保存闹钟设定。"
    .byte 0x00
P5_Messages_Chinese_Msg076:
    .stringn "启动模式已设定为自动模式。"
    .byte 0x00
P5_Messages_Chinese_Msg077:
    .stringn "已保存生日设定。"
    .byte 0x00
P5_Messages_Chinese_Msg078:
    .stringn "触摸屏设定为默认的"
    .byte 0x0A ; line break / 换行
    .stringn "iQue GBA游戏屏幕。"
    .byte 0x00
P5_Messages_Chinese_Msg079:
    .stringn "已保存颜色设定。"
    .byte 0x00
P5_Messages_Chinese_Msg080:
    .stringn "已保存个人信息。"
    .byte 0x00
P5_Messages_Chinese_Msg081:
    .stringn "已保存日期设定。"
    .byte 0x00
P5_Messages_Chinese_Msg082:
    .stringn "语言设定为英语。"
    .byte 0x00
P5_Messages_Chinese_Msg083:
    .stringn "语言设定为法语。"
    .byte 0x00
P5_Messages_Chinese_Msg084:
    .stringn "语言设定为德语。"
    .byte 0x00
P5_Messages_Chinese_Msg085:
    .stringn "语言设定为意大利语。"
    .byte 0x00
P5_Messages_Chinese_Msg086:
    .stringn "语言设定为中文。"
    .byte 0x00
P5_Messages_Chinese_Msg087:
    .stringn "启动模式已设定为手动模式。"
    .byte 0x00
P5_Messages_Chinese_Msg088:
    .stringn "已保存用户名。"
    .byte 0x00
P5_Messages_Chinese_Msg089:
    .stringn "触摸屏已校准完毕。"
    .byte 0x00
P5_Messages_Chinese_Msg090:
    .stringn "语言设定为西班牙语。"
    .byte 0x00
P5_Messages_Chinese_Msg091:
    .stringn "已保存时间设定。"
    .byte 0x00
P5_Messages_Chinese_Msg092:
    .stringn "上方的液晶屏设定为默"
    .byte 0x0A ; line break / 换行
    .stringn "认的iQue GBA游戏屏幕。"
    .byte 0x00
P5_Messages_Chinese_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Chinese_Msg094:
    .stringn "闹钟已开启。"
    .byte 0x0A ; line break / 换行
    .stringn "点触触摸屏或按任意键"
    .byte 0x0A ; line break / 换行
    .stringn "（除"
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "）均可关闭闹钟。"
    .byte 0x0A ; line break / 换行
    .stringn "（如有必要，可以调节音量。）"
    .byte 0x00
P5_Messages_Chinese_Msg095:
    .stringn "设定时间已到。"
    .byte 0x0A ; line break / 换行
    .stringn "请点触触摸屏或按任意键"
    .byte 0x0A ; line break / 换行
    .stringn "（除"
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "）关闭闹钟。"
    .byte 0x00
P5_Messages_Chinese_Msg096:
    .stringn "已过设定的闹钟"
    .byte 0x0A ; line break / 换行
    .stringn "时间●●:●●。"
    .byte 0x0A ; line break / 换行
    .stringn "请点触触摸屏或按任意键"
    .byte 0x0A ; line break / 换行
    .stringn "（除"
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "）关闭闹钟。"
    .byte 0x00
P5_Messages_Chinese_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_Chinese_Msg098:
    .stringn "小时"
    .byte 0x00
P5_Messages_Chinese_Msg099:
    .stringn "分钟"
    .byte 0x00
P5_Messages_Chinese_Msg100:
    .stringn "触摸屏"
    .byte 0x00
P5_Messages_Chinese_Msg101:
    .stringn "上方的液晶屏"
    .byte 0x00
P5_Messages_Chinese_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_Chinese_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_Chinese_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_Chinese_Msg105:
    .ascii "Italiano"
    .byte 0x00
P5_Messages_Chinese_Msg106:
    .stringn "中文"
    .byte 0x00
P5_Messages_Chinese_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_Chinese_Msg108:
    .ascii "0:00"
    .byte 0x00
P5_Messages_Chinese_Msg109:
    .ascii "MM/DD"
    .byte 0x00
P5_Messages_Chinese_Msg110:
    .stringn "五"
    .byte 0x00
P5_Messages_Chinese_Msg111:
    .stringn "通过iQue DS下载游戏。"
    .byte 0x00
P5_Messages_Chinese_Msg112:
    .stringn "更改其他设定。"
    .byte 0x00
P5_Messages_Chinese_Msg113:
    .stringn "设定开机时iQue DS的启动模式。"
    .byte 0x00
P5_Messages_Chinese_Msg114:
    .stringn "请选择当您进行iQue GBA"
    .byte 0x0A ; line break / 换行
    .stringn "游戏时所希望使用的游戏屏幕。"
    .byte 0x00
P5_Messages_Chinese_Msg115:
    .stringn "请选择语言。"
    .byte 0x00
P5_Messages_Chinese_Msg116:
    .stringn "请输入用户信息。"
    .byte 0x00
P5_Messages_Chinese_Msg117:
    .stringn "请输入您的昵称。"
    .byte 0x00
P5_Messages_Chinese_Msg118:
    .stringn "请选择您喜爱的颜色。"
    .byte 0x00
P5_Messages_Chinese_Msg119:
    .stringn "请输入您的生日。"
    .byte 0x00
P5_Messages_Chinese_Msg120:
    .stringn "请输入个人信息。"
    .byte 0x00
P5_Messages_Chinese_Msg121:
    .stringn "校准触摸屏， 请使用手写笔点触"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "标记的中心位置。"
    .byte 0x00
P5_Messages_Chinese_Msg122:
    .stringn "您可以在此更改系统设定。"
    .byte 0x0A ; line break / 换行
    .stringn "请选择您想更改的设定。"
    .byte 0x00
P5_Messages_Chinese_Msg123:
    .stringn "更改日期、时间和闹钟设定。"
    .byte 0x00
P5_Messages_Chinese_Msg124:
    .stringn "请输入日期。"
    .byte 0x00
P5_Messages_Chinese_Msg125:
    .stringn "请输入时间。"
    .byte 0x00
P5_Messages_Chinese_Msg126:
    .stringn "点击闹钟图标"
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .stringn "，启动闹钟。"
    .byte 0x00
P5_Messages_Chinese_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Chinese_Msg128:
    .stringn "一"
    .byte 0x00
P5_Messages_Chinese_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_Chinese_Msg130:
    .stringn "六"
    .byte 0x00
P5_Messages_Chinese_Msg131:
    .stringn "日"
    .byte 0x00
P5_Messages_Chinese_Msg132:
    .stringn "四"
    .byte 0x00
P5_Messages_Chinese_Msg133:
    .stringn "iQue DS下载游戏"
    .byte 0x00
P5_Messages_Chinese_Msg134:
    .stringn "选项"
    .byte 0x00
P5_Messages_Chinese_Msg135:
    .stringn "启动"
    .byte 0x00
P5_Messages_Chinese_Msg136:
    .stringn "iQue GBA模式"
    .byte 0x00
P5_Messages_Chinese_Msg137:
    .stringn "语言"
    .byte 0x00
P5_Messages_Chinese_Msg138:
    .stringn "用户"
    .byte 0x00
P5_Messages_Chinese_Msg139:
    .stringn "用户名"
    .byte 0x00
P5_Messages_Chinese_Msg140:
    .stringn "颜色"
    .byte 0x00
P5_Messages_Chinese_Msg141:
    .stringn "生日"
    .byte 0x00
P5_Messages_Chinese_Msg142:
    .stringn "个人信息"
    .byte 0x00
P5_Messages_Chinese_Msg143:
    .stringn "触摸屏"
    .byte 0x00
P5_Messages_Chinese_Msg144:
    .stringn "设定"
    .byte 0x00
P5_Messages_Chinese_Msg145:
    .stringn "时钟"
    .byte 0x00
P5_Messages_Chinese_Msg146:
    .stringn "日期"
    .byte 0x00
P5_Messages_Chinese_Msg147:
    .stringn "时间"
    .byte 0x00
P5_Messages_Chinese_Msg148:
    .stringn "闹钟"
    .byte 0x00
P5_Messages_Chinese_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_Chinese_Msg150:
    .stringn "二"
    .byte 0x00
P5_Messages_Chinese_Msg151:
    .stringn "三"
    .byte 0x00
P5_Messages_Chinese_Msg152:
    .ascii "YYYY/MM"
    .byte 0x00
P5_Messages_Chinese_Msg153:
    .ascii "YYYY/MM/DD"
    .byte 0x00
P5_Messages_Chinese_Msg154:
    .stringn "当前时间"
    .byte 0x00
P5_Messages_Chinese_Msg155:
    .ascii "0:00:00"
    .byte 0x00
P5_Messages_Chinese_Msg156:
    .stringn "剩余时间"
    .byte 0x00
P5_Messages_Chinese_Msg157:
    .stringn "已过时间"
    .byte 0x00
P5_Messages_Chinese_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_Chinese_Msg159:
    .stringn "闹钟设定"
    .byte 0x00
P5_Messages_Chinese_Msg160:
    .stringn "取消"
    .byte 0x00
P5_Messages_Chinese_Msg161:
    .stringn "确定"
    .byte 0x00
P5_Messages_Chinese_Msg162:
    .stringn "请选择您要使用的语言。"
    .byte 0x00
P5_Messages_Chinese_Msg163:
    .stringn "系统设定已丢失。请点触"
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "。"
    .byte 0x00
.loadtable "../../include/utf16le.tbl","utf-8"
