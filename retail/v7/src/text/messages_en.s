; BMG resource; included by p5.s at P5_Messages_English.
; BMG 资源，由 p5.s 在 P5_Messages_English 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_English_End - P5_Messages_English
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_en.bmg", 0x11, 0xF ; original format bytes / 原始格式字节
P5_Messages_English_Info:
    .ascii "INF1"
    .word P5_Messages_English_Data - P5_Messages_English_Info
    .dh (P5_Messages_English_EntriesEnd - P5_Messages_English_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_English_Entries:
    .word P5_Messages_English_Msg000 - P5_Messages_English_Text
    .word P5_Messages_English_Msg001 - P5_Messages_English_Text
    .word P5_Messages_English_Msg002 - P5_Messages_English_Text
    .word P5_Messages_English_Msg003 - P5_Messages_English_Text
    .word P5_Messages_English_Msg004 - P5_Messages_English_Text
    .word P5_Messages_English_Msg005 - P5_Messages_English_Text
    .word P5_Messages_English_Msg006 - P5_Messages_English_Text
    .word P5_Messages_English_Msg007 - P5_Messages_English_Text
    .word P5_Messages_English_Msg008 - P5_Messages_English_Text
    .word P5_Messages_English_Msg009 - P5_Messages_English_Text
    .word P5_Messages_English_Msg010 - P5_Messages_English_Text
    .word P5_Messages_English_Msg011 - P5_Messages_English_Text
    .word P5_Messages_English_Msg012 - P5_Messages_English_Text
    .word P5_Messages_English_Msg013 - P5_Messages_English_Text
    .word P5_Messages_English_Msg014 - P5_Messages_English_Text
    .word P5_Messages_English_Msg015 - P5_Messages_English_Text
    .word P5_Messages_English_Msg016 - P5_Messages_English_Text
    .word P5_Messages_English_Msg017 - P5_Messages_English_Text
    .word P5_Messages_English_Msg018 - P5_Messages_English_Text
    .word P5_Messages_English_Msg019 - P5_Messages_English_Text
    .word P5_Messages_English_Msg020 - P5_Messages_English_Text
    .word P5_Messages_English_Msg021 - P5_Messages_English_Text
    .word P5_Messages_English_Msg022 - P5_Messages_English_Text
    .word P5_Messages_English_Msg023 - P5_Messages_English_Text
    .word P5_Messages_English_Msg024 - P5_Messages_English_Text
    .word P5_Messages_English_Msg025 - P5_Messages_English_Text
    .word P5_Messages_English_Msg026 - P5_Messages_English_Text
    .word P5_Messages_English_Msg027 - P5_Messages_English_Text
    .word P5_Messages_English_Msg028 - P5_Messages_English_Text
    .word P5_Messages_English_Msg029 - P5_Messages_English_Text
    .word P5_Messages_English_Msg030 - P5_Messages_English_Text
    .word P5_Messages_English_Msg031 - P5_Messages_English_Text
    .word P5_Messages_English_Msg032 - P5_Messages_English_Text
    .word P5_Messages_English_Msg033 - P5_Messages_English_Text
    .word P5_Messages_English_Msg034 - P5_Messages_English_Text
    .word P5_Messages_English_Msg035 - P5_Messages_English_Text
    .word P5_Messages_English_Msg036 - P5_Messages_English_Text
    .word P5_Messages_English_Msg037 - P5_Messages_English_Text
    .word P5_Messages_English_Msg038 - P5_Messages_English_Text
    .word P5_Messages_English_Msg039 - P5_Messages_English_Text
    .word P5_Messages_English_Msg040 - P5_Messages_English_Text
    .word P5_Messages_English_Msg041 - P5_Messages_English_Text
    .word P5_Messages_English_Msg042 - P5_Messages_English_Text
    .word P5_Messages_English_Msg043 - P5_Messages_English_Text
    .word P5_Messages_English_Msg044 - P5_Messages_English_Text
    .word P5_Messages_English_Msg045 - P5_Messages_English_Text
    .word P5_Messages_English_Msg046 - P5_Messages_English_Text
    .word P5_Messages_English_Msg047 - P5_Messages_English_Text
    .word P5_Messages_English_Msg048 - P5_Messages_English_Text
    .word P5_Messages_English_Msg049 - P5_Messages_English_Text
    .word P5_Messages_English_Msg050 - P5_Messages_English_Text
    .word P5_Messages_English_Msg051 - P5_Messages_English_Text
    .word P5_Messages_English_Msg052 - P5_Messages_English_Text
    .word P5_Messages_English_Msg053 - P5_Messages_English_Text
    .word P5_Messages_English_Msg054 - P5_Messages_English_Text
    .word P5_Messages_English_Msg055 - P5_Messages_English_Text
    .word P5_Messages_English_Msg056 - P5_Messages_English_Text
    .word P5_Messages_English_Msg057 - P5_Messages_English_Text
    .word P5_Messages_English_Msg058 - P5_Messages_English_Text
    .word P5_Messages_English_Msg059 - P5_Messages_English_Text
    .word P5_Messages_English_Msg060 - P5_Messages_English_Text
    .word P5_Messages_English_Msg061 - P5_Messages_English_Text
    .word P5_Messages_English_Msg062 - P5_Messages_English_Text
    .word P5_Messages_English_Msg063 - P5_Messages_English_Text
    .word P5_Messages_English_Msg064 - P5_Messages_English_Text
    .word P5_Messages_English_Msg065 - P5_Messages_English_Text
    .word P5_Messages_English_Msg066 - P5_Messages_English_Text
    .word P5_Messages_English_Msg067 - P5_Messages_English_Text
    .word P5_Messages_English_Msg068 - P5_Messages_English_Text
    .word P5_Messages_English_Msg069 - P5_Messages_English_Text
    .word P5_Messages_English_Msg070 - P5_Messages_English_Text
    .word P5_Messages_English_Msg071 - P5_Messages_English_Text
    .word P5_Messages_English_Msg072 - P5_Messages_English_Text
    .word P5_Messages_English_Msg073 - P5_Messages_English_Text
    .word P5_Messages_English_Msg074 - P5_Messages_English_Text
    .word P5_Messages_English_Msg075 - P5_Messages_English_Text
    .word P5_Messages_English_Msg076 - P5_Messages_English_Text
    .word P5_Messages_English_Msg077 - P5_Messages_English_Text
    .word P5_Messages_English_Msg078 - P5_Messages_English_Text
    .word P5_Messages_English_Msg079 - P5_Messages_English_Text
    .word P5_Messages_English_Msg080 - P5_Messages_English_Text
    .word P5_Messages_English_Msg081 - P5_Messages_English_Text
    .word P5_Messages_English_Msg082 - P5_Messages_English_Text
    .word P5_Messages_English_Msg083 - P5_Messages_English_Text
    .word P5_Messages_English_Msg084 - P5_Messages_English_Text
    .word P5_Messages_English_Msg085 - P5_Messages_English_Text
    .word P5_Messages_English_Msg086 - P5_Messages_English_Text
    .word P5_Messages_English_Msg087 - P5_Messages_English_Text
    .word P5_Messages_English_Msg088 - P5_Messages_English_Text
    .word P5_Messages_English_Msg089 - P5_Messages_English_Text
    .word P5_Messages_English_Msg090 - P5_Messages_English_Text
    .word P5_Messages_English_Msg091 - P5_Messages_English_Text
    .word P5_Messages_English_Msg092 - P5_Messages_English_Text
    .word P5_Messages_English_Msg093 - P5_Messages_English_Text
    .word P5_Messages_English_Msg094 - P5_Messages_English_Text
    .word P5_Messages_English_Msg095 - P5_Messages_English_Text
    .word P5_Messages_English_Msg096 - P5_Messages_English_Text
    .word P5_Messages_English_Msg097 - P5_Messages_English_Text
    .word P5_Messages_English_Msg098 - P5_Messages_English_Text
    .word P5_Messages_English_Msg099 - P5_Messages_English_Text
    .word P5_Messages_English_Msg100 - P5_Messages_English_Text
    .word P5_Messages_English_Msg101 - P5_Messages_English_Text
    .word P5_Messages_English_Msg102 - P5_Messages_English_Text
    .word P5_Messages_English_Msg103 - P5_Messages_English_Text
    .word P5_Messages_English_Msg104 - P5_Messages_English_Text
    .word P5_Messages_English_Msg105 - P5_Messages_English_Text
    .word P5_Messages_English_Msg106 - P5_Messages_English_Text
    .word P5_Messages_English_Msg107 - P5_Messages_English_Text
    .word P5_Messages_English_Msg108 - P5_Messages_English_Text
    .word P5_Messages_English_Msg109 - P5_Messages_English_Text
    .word P5_Messages_English_Msg110 - P5_Messages_English_Text
    .word P5_Messages_English_Msg111 - P5_Messages_English_Text
    .word P5_Messages_English_Msg112 - P5_Messages_English_Text
    .word P5_Messages_English_Msg113 - P5_Messages_English_Text
    .word P5_Messages_English_Msg114 - P5_Messages_English_Text
    .word P5_Messages_English_Msg115 - P5_Messages_English_Text
    .word P5_Messages_English_Msg116 - P5_Messages_English_Text
    .word P5_Messages_English_Msg117 - P5_Messages_English_Text
    .word P5_Messages_English_Msg118 - P5_Messages_English_Text
    .word P5_Messages_English_Msg119 - P5_Messages_English_Text
    .word P5_Messages_English_Msg120 - P5_Messages_English_Text
    .word P5_Messages_English_Msg121 - P5_Messages_English_Text
    .word P5_Messages_English_Msg122 - P5_Messages_English_Text
    .word P5_Messages_English_Msg123 - P5_Messages_English_Text
    .word P5_Messages_English_Msg124 - P5_Messages_English_Text
    .word P5_Messages_English_Msg125 - P5_Messages_English_Text
    .word P5_Messages_English_Msg126 - P5_Messages_English_Text
    .word P5_Messages_English_Msg127 - P5_Messages_English_Text
    .word P5_Messages_English_Msg128 - P5_Messages_English_Text
    .word P5_Messages_English_Msg129 - P5_Messages_English_Text
    .word P5_Messages_English_Msg130 - P5_Messages_English_Text
    .word P5_Messages_English_Msg131 - P5_Messages_English_Text
    .word P5_Messages_English_Msg132 - P5_Messages_English_Text
    .word P5_Messages_English_Msg133 - P5_Messages_English_Text
    .word P5_Messages_English_Msg134 - P5_Messages_English_Text
    .word P5_Messages_English_Msg135 - P5_Messages_English_Text
    .word P5_Messages_English_Msg136 - P5_Messages_English_Text
    .word P5_Messages_English_Msg137 - P5_Messages_English_Text
    .word P5_Messages_English_Msg138 - P5_Messages_English_Text
    .word P5_Messages_English_Msg139 - P5_Messages_English_Text
    .word P5_Messages_English_Msg140 - P5_Messages_English_Text
    .word P5_Messages_English_Msg141 - P5_Messages_English_Text
    .word P5_Messages_English_Msg142 - P5_Messages_English_Text
    .word P5_Messages_English_Msg143 - P5_Messages_English_Text
    .word P5_Messages_English_Msg144 - P5_Messages_English_Text
    .word P5_Messages_English_Msg145 - P5_Messages_English_Text
    .word P5_Messages_English_Msg146 - P5_Messages_English_Text
    .word P5_Messages_English_Msg147 - P5_Messages_English_Text
    .word P5_Messages_English_Msg148 - P5_Messages_English_Text
    .word P5_Messages_English_Msg149 - P5_Messages_English_Text
    .word P5_Messages_English_Msg150 - P5_Messages_English_Text
    .word P5_Messages_English_Msg151 - P5_Messages_English_Text
    .word P5_Messages_English_Msg152 - P5_Messages_English_Text
    .word P5_Messages_English_Msg153 - P5_Messages_English_Text
    .word P5_Messages_English_Msg154 - P5_Messages_English_Text
    .word P5_Messages_English_Msg155 - P5_Messages_English_Text
    .word P5_Messages_English_Msg156 - P5_Messages_English_Text
    .word P5_Messages_English_Msg157 - P5_Messages_English_Text
    .word P5_Messages_English_Msg158 - P5_Messages_English_Text
    .word P5_Messages_English_Msg159 - P5_Messages_English_Text
    .word P5_Messages_English_Msg160 - P5_Messages_English_Text
    .word P5_Messages_English_Msg161 - P5_Messages_English_Text
    .word P5_Messages_English_Msg162 - P5_Messages_English_Text
    .word P5_Messages_English_Msg163 - P5_Messages_English_Text
P5_Messages_English_EntriesEnd:
P5_Messages_English_Data:
    .ascii "DAT1"
    .word P5_Messages_English_End - P5_Messages_English_Data
P5_Messages_English_Text:
    .byte 0x00
P5_Messages_English_Msg000:
    .ascii "Calibration complete. Touch the"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " marks to test the calibration."
    .byte 0x00
P5_Messages_English_Msg001:
    .ascii "Press "
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " to cancel."
    .byte 0x00
P5_Messages_English_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Try again"
    .byte 0x00
P5_Messages_English_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Close"
    .byte 0x00
P5_Messages_English_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Yes"
    .byte 0x00
P5_Messages_English_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " No"
    .byte 0x00
P5_Messages_English_Msg006:
    .ascii "Happy Birthday!"
    .byte 0x0A ; line break / 换行
    .stringn "Today is ∩'s Birthday!"
    .byte 0x00
P5_Messages_English_Msg007:
    .stringn "∩ has moved to"
    .byte 0x0A ; line break / 换行
    .stringn "Chat Room ⊿."
    .byte 0x00
P5_Messages_English_Msg008:
    .stringn "Now entering ⊿: ∩"
    .byte 0x00
P5_Messages_English_Msg009:
    .stringn "Now leaving ⊿: ∩"
    .byte 0x00
P5_Messages_English_Msg010:
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
P5_Messages_English_Msg011:
    .ascii "Chat Room A"
    .byte 0x00
P5_Messages_English_Msg012:
    .ascii "Chat Room B"
    .byte 0x00
P5_Messages_English_Msg013:
    .ascii "Chat Room C"
    .byte 0x00
P5_Messages_English_Msg014:
    .ascii "Chat Room D"
    .byte 0x00
P5_Messages_English_Msg015:
    .ascii "Choose a Chat Room to join."
    .byte 0x00
P5_Messages_English_Msg016:
    .ascii "Choose Color"
    .byte 0x00
P5_Messages_English_Msg017:
    .ascii "Cancel"
    .byte 0x00
P5_Messages_English_Msg018:
    .ascii "Confirm"
    .byte 0x00
P5_Messages_English_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Turn Alarm On"
    .byte 0x00
P5_Messages_English_Msg020:
    .ascii "Hour"
    .byte 0x00
P5_Messages_English_Msg021:
    .ascii "Minute"
    .byte 0x00
P5_Messages_English_Msg022:
    .ascii "Day"
    .byte 0x00
P5_Messages_English_Msg023:
    .ascii "Month"
    .byte 0x00
P5_Messages_English_Msg024:
    .ascii "The Main Menu will appear"
    .byte 0x0A ; line break / 换行
    .ascii "automatically when you turn"
    .byte 0x0A ; line break / 换行
    .ascii "the power on."
    .byte 0x00
P5_Messages_English_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .ascii " Auto Mode"
    .byte 0x00
P5_Messages_English_Msg026:
    .ascii "If a DS Card or a Game Pak is"
    .byte 0x0A ; line break / 换行
    .ascii "inserted when you power up, the"
    .byte 0x0A ; line break / 换行
    .ascii "game will begin automatically."
    .byte 0x00
P5_Messages_English_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .ascii " Manual Mode"
    .byte 0x00
P5_Messages_English_Msg028:
    .ascii "Day"
    .byte 0x00
P5_Messages_English_Msg029:
    .ascii "Month"
    .byte 0x00
P5_Messages_English_Msg030:
    .ascii "Year"
    .byte 0x00
P5_Messages_English_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Confirm"
    .byte 0x00
P5_Messages_English_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Input"
    .byte 0x00
P5_Messages_English_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Join"
    .byte 0x00
P5_Messages_English_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_English_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Select"
    .byte 0x00
P5_Messages_English_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_English_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Yes"
    .byte 0x00
P5_Messages_English_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Go back"
    .byte 0x00
P5_Messages_English_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Cancel"
    .byte 0x00
P5_Messages_English_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Erase"
    .byte 0x00
P5_Messages_English_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " No"
    .byte 0x00
P5_Messages_English_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Quit"
    .byte 0x00
P5_Messages_English_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_English_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_English_Msg045:
    .ascii "There is no DS Card"
    .byte 0x0A ; line break / 换行
    .ascii "inserted."
    .byte 0x00
P5_Messages_English_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_English_Msg047:
    .ascii "Start GBA game."
    .byte 0x00
P5_Messages_English_Msg048:
    .ascii "There is no Game Pak"
    .byte 0x0A ; line break / 换行
    .ascii "inserted."
    .byte 0x00
P5_Messages_English_Msg049:
    .ascii "There is a DS Option"
    .byte 0x0A ; line break / 换行
    .ascii "Pak inserted."
    .byte 0x00
P5_Messages_English_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_English_Msg051:
    .ascii "Settings"
    .byte 0x00
P5_Messages_English_Msg052:
    .ascii "DS Download Play"
    .byte 0x00
P5_Messages_English_Msg053:
    .ascii "No"
    .byte 0x00
P5_Messages_English_Msg054:
    .ascii "Yes"
    .byte 0x00
P5_Messages_English_Msg055:
    .ascii "The alarm has been turned off."
    .byte 0x00
P5_Messages_English_Msg056:
    .ascii "Would you like to turn the"
    .byte 0x0A ; line break / 换行
    .ascii "alarm off?"
    .byte 0x00
P5_Messages_English_Msg057:
    .stringn "The alarm has been set for ●●:●●."
    .byte 0x0A ; line break / 换行
    .ascii "Would you like to turn the alarm on?"
    .byte 0x00
P5_Messages_English_Msg058:
    .ascii "Would you like the Rumble Feature"
    .byte 0x0A ; line break / 换行
    .ascii "to accompany the alarm?"
    .byte 0x00
P5_Messages_English_Msg059:
    .ascii "Communication error."
    .byte 0x0A ; line break / 换行
    .ascii "Return to room selection."
    .byte 0x00
P5_Messages_English_Msg060:
    .stringn "Chat Room ⊿ is full. You"
    .byte 0x0A ; line break / 换行
    .stringn "cannot enter Chat Room ⊿."
    .byte 0x00
P5_Messages_English_Msg061:
    .ascii "Communication error."
    .byte 0x0A ; line break / 换行
    .ascii "Please turn the power off."
    .byte 0x00
P5_Messages_English_Msg062:
    .ascii "Downloading..."
    .byte 0x00
P5_Messages_English_Msg063:
    .ascii "Download has been canceled."
    .byte 0x00
P5_Messages_English_Msg064:
    .ascii "Maximum number of participants has"
    .byte 0x0A ; line break / 换行
    .ascii "been reached. Unable to download."
    .byte 0x00
P5_Messages_English_Msg065:
    .ascii "The software has been"
    .byte 0x0A ; line break / 换行
    .ascii "successfully downloaded."
    .byte 0x00
P5_Messages_English_Msg066:
    .ascii "Before you begin, you must adjust"
    .byte 0x0A ; line break / 换行
    .ascii "system settings. Please touch the"
    .byte 0x0A ; line break / 换行
    .ascii "Touch Screen or press any button."
    .byte 0x00
P5_Messages_English_Msg067:
    .ascii "Confirm your system settings."
    .byte 0x0A ; line break / 换行
    .ascii "Touch the Touch Screen"
    .byte 0x0A ; line break / 换行
    .ascii "or press any button."
    .byte 0x00
P5_Messages_English_Msg068:
    .ascii "This will change your settings to"
    .byte 0x0A ; line break / 换行
    .ascii "English. Is this OK?"
    .byte 0x00
P5_Messages_English_Msg069:
    .ascii "Would you like to download"
    .byte 0x0A ; line break / 换行
    .ascii "this software?"
    .byte 0x00
P5_Messages_English_Msg070:
    .ascii "Resume communication?"
    .byte 0x00
P5_Messages_English_Msg071:
    .ascii "Communication error."
    .byte 0x0A ; line break / 换行
    .ascii "Download not completed."
    .byte 0x00
P5_Messages_English_Msg072:
    .ascii "The system will now shut down."
    .byte 0x00
P5_Messages_English_Msg073:
    .ascii "In order for the new settings"
    .byte 0x0A ; line break / 换行
    .ascii "to take effect, you must restart"
    .byte 0x0A ; line break / 换行
    .ascii "your system. Shut down now?"
    .byte 0x00
P5_Messages_English_Msg074:
    .ascii "Looking for software available"
    .byte 0x0A ; line break / 换行
    .ascii "for download..."
    .byte 0x00
P5_Messages_English_Msg075:
    .ascii "Alarm setting saved."
    .byte 0x00
P5_Messages_English_Msg076:
    .ascii "System start-up set to Auto."
    .byte 0x00
P5_Messages_English_Msg077:
    .ascii "Birthday setting saved."
    .byte 0x00
P5_Messages_English_Msg078:
    .ascii "Default GBA screen"
    .byte 0x0A ; line break / 换行
    .ascii "set to Touch Screen."
    .byte 0x00
P5_Messages_English_Msg079:
    .ascii "Color setting saved."
    .byte 0x00
P5_Messages_English_Msg080:
    .ascii "Message saved."
    .byte 0x00
P5_Messages_English_Msg081:
    .ascii "Date setting saved."
    .byte 0x00
P5_Messages_English_Msg082:
    .ascii "Language set to English."
    .byte 0x00
P5_Messages_English_Msg083:
    .ascii "Language set to French."
    .byte 0x00
P5_Messages_English_Msg084:
    .ascii "Language set to German."
    .byte 0x00
P5_Messages_English_Msg085:
    .ascii "Language set to Italian."
    .byte 0x00
P5_Messages_English_Msg086:
    .stringn "「日本語」に設定しました。"
    .byte 0x00
P5_Messages_English_Msg087:
    .ascii "System start-up set to Manual."
    .byte 0x00
P5_Messages_English_Msg088:
    .ascii "User Name saved."
    .byte 0x00
P5_Messages_English_Msg089:
    .ascii "The Touch Screen has"
    .byte 0x0A ; line break / 换行
    .ascii "been calibrated."
    .byte 0x00
P5_Messages_English_Msg090:
    .ascii "Language set to Spanish."
    .byte 0x00
P5_Messages_English_Msg091:
    .ascii "Time setting saved."
    .byte 0x00
P5_Messages_English_Msg092:
    .ascii "Default GBA screen"
    .byte 0x0A ; line break / 换行
    .ascii "set to Top Screen."
    .byte 0x00
P5_Messages_English_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_English_Msg094:
    .ascii "The alarm is currently on. Touch the Touch"
    .byte 0x0A ; line break / 换行
    .ascii "Screen or press any button to turn it off."
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " will not turn the alarm off."
    .byte 0x0A ; line break / 换行
    .ascii "(Adjust volume if necessary.)"
    .byte 0x00
P5_Messages_English_Msg095:
    .ascii "The alarm has been turned on."
    .byte 0x0A ; line break / 换行
    .ascii "To turn the alarm off, touch the Touch"
    .byte 0x0A ; line break / 换行
    .ascii "Screen or press any button."
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " will not turn the alarm off."
    .byte 0x00
P5_Messages_English_Msg096:
    .stringn "It is ●●:●● past the set alarm time."
    .byte 0x0A ; line break / 换行
    .ascii "To turn the alarm off, touch the Touch"
    .byte 0x0A ; line break / 换行
    .ascii "Screen or press any button."
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " will not turn the alarm off."
    .byte 0x00
P5_Messages_English_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_English_Msg098:
    .ascii "Hour"
    .byte 0x00
P5_Messages_English_Msg099:
    .ascii "Minute"
    .byte 0x00
P5_Messages_English_Msg100:
    .ascii "Touch"
    .byte 0x0A ; line break / 换行
    .ascii "Screen"
    .byte 0x00
P5_Messages_English_Msg101:
    .ascii "Top"
    .byte 0x0A ; line break / 换行
    .ascii "Screen"
    .byte 0x00
P5_Messages_English_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_English_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_English_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_English_Msg105:
    .ascii "Italiano"
    .byte 0x00
P5_Messages_English_Msg106:
    .stringn "日本語"
    .byte 0x00
P5_Messages_English_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_English_Msg108:
    .ascii "00:00"
    .byte 0x00
P5_Messages_English_Msg109:
    .ascii "MM/DD"
    .byte 0x00
P5_Messages_English_Msg110:
    .ascii "Fr"
    .byte 0x00
P5_Messages_English_Msg111:
    .ascii "Download software via DS Download Play."
    .byte 0x00
P5_Messages_English_Msg112:
    .ascii "Change other settings."
    .byte 0x00
P5_Messages_English_Msg113:
    .ascii "Set how you would like your system to"
    .byte 0x0A ; line break / 换行
    .ascii "start up when you turn the power on."
    .byte 0x00
P5_Messages_English_Msg114:
    .ascii "Select the screen you would like to use"
    .byte 0x0A ; line break / 换行
    .ascii "when starting GBA Mode."
    .byte 0x00
P5_Messages_English_Msg115:
    .ascii "Select the language to use."
    .byte 0x00
P5_Messages_English_Msg116:
    .ascii "Enter user information."
    .byte 0x00
P5_Messages_English_Msg117:
    .ascii "Enter your nickname."
    .byte 0x00
P5_Messages_English_Msg118:
    .ascii "Select your favorite color."
    .byte 0x00
P5_Messages_English_Msg119:
    .ascii "Enter your birthday."
    .byte 0x00
P5_Messages_English_Msg120:
    .ascii "Enter a personal message."
    .byte 0x00
P5_Messages_English_Msg121:
    .ascii "To calibrate the Touch Screen, tap the"
    .byte 0x0A ; line break / 换行
    .ascii "center of the "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " marks with the stylus."
    .byte 0x00
P5_Messages_English_Msg122:
    .ascii "Change system settings here. Select"
    .byte 0x0A ; line break / 换行
    .ascii "the setting you'd like to change."
    .byte 0x00
P5_Messages_English_Msg123:
    .ascii "Change date, time, and alarm settings."
    .byte 0x00
P5_Messages_English_Msg124:
    .ascii "Enter today's date."
    .byte 0x00
P5_Messages_English_Msg125:
    .ascii "Enter the current time."
    .byte 0x00
P5_Messages_English_Msg126:
    .ascii "Tap the alarm icon ("
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .ascii ") to have the"
    .byte 0x0A ; line break / 换行
    .ascii "alarm sound at the designated time."
    .byte 0x00
P5_Messages_English_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_English_Msg128:
    .ascii "Mo"
    .byte 0x00
P5_Messages_English_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_English_Msg130:
    .ascii "Sa"
    .byte 0x00
P5_Messages_English_Msg131:
    .ascii "Su"
    .byte 0x00
P5_Messages_English_Msg132:
    .ascii "Th"
    .byte 0x00
P5_Messages_English_Msg133:
    .ascii "DS Download Play"
    .byte 0x00
P5_Messages_English_Msg134:
    .ascii "Options"
    .byte 0x00
P5_Messages_English_Msg135:
    .ascii "Start-up"
    .byte 0x00
P5_Messages_English_Msg136:
    .ascii "GBA Mode"
    .byte 0x00
P5_Messages_English_Msg137:
    .ascii "Language"
    .byte 0x00
P5_Messages_English_Msg138:
    .ascii "User"
    .byte 0x00
P5_Messages_English_Msg139:
    .ascii "User Name"
    .byte 0x00
P5_Messages_English_Msg140:
    .ascii "Color"
    .byte 0x00
P5_Messages_English_Msg141:
    .ascii "Birthday"
    .byte 0x00
P5_Messages_English_Msg142:
    .ascii "Message"
    .byte 0x00
P5_Messages_English_Msg143:
    .ascii "Touch Screen"
    .byte 0x00
P5_Messages_English_Msg144:
    .ascii "Settings"
    .byte 0x00
P5_Messages_English_Msg145:
    .ascii "Clock"
    .byte 0x00
P5_Messages_English_Msg146:
    .ascii "Date"
    .byte 0x00
P5_Messages_English_Msg147:
    .ascii "Time"
    .byte 0x00
P5_Messages_English_Msg148:
    .ascii "Alarm"
    .byte 0x00
P5_Messages_English_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_English_Msg150:
    .ascii "Tu"
    .byte 0x00
P5_Messages_English_Msg151:
    .ascii "We"
    .byte 0x00
P5_Messages_English_Msg152:
    .ascii "MM/YYYY"
    .byte 0x00
P5_Messages_English_Msg153:
    .ascii "MM/DD/YYYY"
    .byte 0x00
P5_Messages_English_Msg154:
    .ascii "Current Time"
    .byte 0x00
P5_Messages_English_Msg155:
    .ascii "00:00:00"
    .byte 0x00
P5_Messages_English_Msg156:
    .ascii "Time Remaining"
    .byte 0x00
P5_Messages_English_Msg157:
    .ascii "Elapsed Time"
    .byte 0x00
P5_Messages_English_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_English_Msg159:
    .ascii "Alarm Setting"
    .byte 0x00
P5_Messages_English_Msg160:
    .ascii "Cancel"
    .byte 0x00
P5_Messages_English_Msg161:
    .ascii "Confirm"
    .byte 0x00
P5_Messages_English_Msg162:
    .ascii "Select the language to use."
    .byte 0x00
P5_Messages_English_Msg163:
    .ascii "System settings have been lost. Tap "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii "."
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
.loadtable "../../include/utf16le.tbl","utf-8"
