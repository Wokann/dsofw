; BMG resource; included by p5.s at P5_Messages_German.
; BMG 资源，由 p5.s 在 P5_Messages_German 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_German_End - P5_Messages_German
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_de.bmg", 0x11, 0xF ; original format bytes / 原始格式字节
P5_Messages_German_Info:
    .ascii "INF1"
    .word P5_Messages_German_Data - P5_Messages_German_Info
    .dh (P5_Messages_German_EntriesEnd - P5_Messages_German_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_German_Entries:
    .word P5_Messages_German_Msg000 - P5_Messages_German_Text
    .word P5_Messages_German_Msg001 - P5_Messages_German_Text
    .word P5_Messages_German_Msg002 - P5_Messages_German_Text
    .word P5_Messages_German_Msg003 - P5_Messages_German_Text
    .word P5_Messages_German_Msg004 - P5_Messages_German_Text
    .word P5_Messages_German_Msg005 - P5_Messages_German_Text
    .word P5_Messages_German_Msg006 - P5_Messages_German_Text
    .word P5_Messages_German_Msg007 - P5_Messages_German_Text
    .word P5_Messages_German_Msg008 - P5_Messages_German_Text
    .word P5_Messages_German_Msg009 - P5_Messages_German_Text
    .word P5_Messages_German_Msg010 - P5_Messages_German_Text
    .word P5_Messages_German_Msg011 - P5_Messages_German_Text
    .word P5_Messages_German_Msg012 - P5_Messages_German_Text
    .word P5_Messages_German_Msg013 - P5_Messages_German_Text
    .word P5_Messages_German_Msg014 - P5_Messages_German_Text
    .word P5_Messages_German_Msg015 - P5_Messages_German_Text
    .word P5_Messages_German_Msg016 - P5_Messages_German_Text
    .word P5_Messages_German_Msg017 - P5_Messages_German_Text
    .word P5_Messages_German_Msg018 - P5_Messages_German_Text
    .word P5_Messages_German_Msg019 - P5_Messages_German_Text
    .word P5_Messages_German_Msg020 - P5_Messages_German_Text
    .word P5_Messages_German_Msg021 - P5_Messages_German_Text
    .word P5_Messages_German_Msg022 - P5_Messages_German_Text
    .word P5_Messages_German_Msg023 - P5_Messages_German_Text
    .word P5_Messages_German_Msg024 - P5_Messages_German_Text
    .word P5_Messages_German_Msg025 - P5_Messages_German_Text
    .word P5_Messages_German_Msg026 - P5_Messages_German_Text
    .word P5_Messages_German_Msg027 - P5_Messages_German_Text
    .word P5_Messages_German_Msg028 - P5_Messages_German_Text
    .word P5_Messages_German_Msg029 - P5_Messages_German_Text
    .word P5_Messages_German_Msg030 - P5_Messages_German_Text
    .word P5_Messages_German_Msg031 - P5_Messages_German_Text
    .word P5_Messages_German_Msg032 - P5_Messages_German_Text
    .word P5_Messages_German_Msg033 - P5_Messages_German_Text
    .word P5_Messages_German_Msg034 - P5_Messages_German_Text
    .word P5_Messages_German_Msg035 - P5_Messages_German_Text
    .word P5_Messages_German_Msg036 - P5_Messages_German_Text
    .word P5_Messages_German_Msg037 - P5_Messages_German_Text
    .word P5_Messages_German_Msg038 - P5_Messages_German_Text
    .word P5_Messages_German_Msg039 - P5_Messages_German_Text
    .word P5_Messages_German_Msg040 - P5_Messages_German_Text
    .word P5_Messages_German_Msg041 - P5_Messages_German_Text
    .word P5_Messages_German_Msg042 - P5_Messages_German_Text
    .word P5_Messages_German_Msg043 - P5_Messages_German_Text
    .word P5_Messages_German_Msg044 - P5_Messages_German_Text
    .word P5_Messages_German_Msg045 - P5_Messages_German_Text
    .word P5_Messages_German_Msg046 - P5_Messages_German_Text
    .word P5_Messages_German_Msg047 - P5_Messages_German_Text
    .word P5_Messages_German_Msg048 - P5_Messages_German_Text
    .word P5_Messages_German_Msg049 - P5_Messages_German_Text
    .word P5_Messages_German_Msg050 - P5_Messages_German_Text
    .word P5_Messages_German_Msg051 - P5_Messages_German_Text
    .word P5_Messages_German_Msg052 - P5_Messages_German_Text
    .word P5_Messages_German_Msg053 - P5_Messages_German_Text
    .word P5_Messages_German_Msg054 - P5_Messages_German_Text
    .word P5_Messages_German_Msg055 - P5_Messages_German_Text
    .word P5_Messages_German_Msg056 - P5_Messages_German_Text
    .word P5_Messages_German_Msg057 - P5_Messages_German_Text
    .word P5_Messages_German_Msg058 - P5_Messages_German_Text
    .word P5_Messages_German_Msg059 - P5_Messages_German_Text
    .word P5_Messages_German_Msg060 - P5_Messages_German_Text
    .word P5_Messages_German_Msg061 - P5_Messages_German_Text
    .word P5_Messages_German_Msg062 - P5_Messages_German_Text
    .word P5_Messages_German_Msg063 - P5_Messages_German_Text
    .word P5_Messages_German_Msg064 - P5_Messages_German_Text
    .word P5_Messages_German_Msg065 - P5_Messages_German_Text
    .word P5_Messages_German_Msg066 - P5_Messages_German_Text
    .word P5_Messages_German_Msg067 - P5_Messages_German_Text
    .word P5_Messages_German_Msg068 - P5_Messages_German_Text
    .word P5_Messages_German_Msg069 - P5_Messages_German_Text
    .word P5_Messages_German_Msg070 - P5_Messages_German_Text
    .word P5_Messages_German_Msg071 - P5_Messages_German_Text
    .word P5_Messages_German_Msg072 - P5_Messages_German_Text
    .word P5_Messages_German_Msg073 - P5_Messages_German_Text
    .word P5_Messages_German_Msg074 - P5_Messages_German_Text
    .word P5_Messages_German_Msg075 - P5_Messages_German_Text
    .word P5_Messages_German_Msg076 - P5_Messages_German_Text
    .word P5_Messages_German_Msg077 - P5_Messages_German_Text
    .word P5_Messages_German_Msg078 - P5_Messages_German_Text
    .word P5_Messages_German_Msg079 - P5_Messages_German_Text
    .word P5_Messages_German_Msg080 - P5_Messages_German_Text
    .word P5_Messages_German_Msg081 - P5_Messages_German_Text
    .word P5_Messages_German_Msg082 - P5_Messages_German_Text
    .word P5_Messages_German_Msg083 - P5_Messages_German_Text
    .word P5_Messages_German_Msg084 - P5_Messages_German_Text
    .word P5_Messages_German_Msg085 - P5_Messages_German_Text
    .word P5_Messages_German_Msg086 - P5_Messages_German_Text
    .word P5_Messages_German_Msg087 - P5_Messages_German_Text
    .word P5_Messages_German_Msg088 - P5_Messages_German_Text
    .word P5_Messages_German_Msg089 - P5_Messages_German_Text
    .word P5_Messages_German_Msg090 - P5_Messages_German_Text
    .word P5_Messages_German_Msg091 - P5_Messages_German_Text
    .word P5_Messages_German_Msg092 - P5_Messages_German_Text
    .word P5_Messages_German_Msg093 - P5_Messages_German_Text
    .word P5_Messages_German_Msg094 - P5_Messages_German_Text
    .word P5_Messages_German_Msg095 - P5_Messages_German_Text
    .word P5_Messages_German_Msg096 - P5_Messages_German_Text
    .word P5_Messages_German_Msg097 - P5_Messages_German_Text
    .word P5_Messages_German_Msg098 - P5_Messages_German_Text
    .word P5_Messages_German_Msg099 - P5_Messages_German_Text
    .word P5_Messages_German_Msg100 - P5_Messages_German_Text
    .word P5_Messages_German_Msg101 - P5_Messages_German_Text
    .word P5_Messages_German_Msg102 - P5_Messages_German_Text
    .word P5_Messages_German_Msg103 - P5_Messages_German_Text
    .word P5_Messages_German_Msg104 - P5_Messages_German_Text
    .word P5_Messages_German_Msg105 - P5_Messages_German_Text
    .word P5_Messages_German_Msg106 - P5_Messages_German_Text
    .word P5_Messages_German_Msg107 - P5_Messages_German_Text
    .word P5_Messages_German_Msg108 - P5_Messages_German_Text
    .word P5_Messages_German_Msg109 - P5_Messages_German_Text
    .word P5_Messages_German_Msg110 - P5_Messages_German_Text
    .word P5_Messages_German_Msg111 - P5_Messages_German_Text
    .word P5_Messages_German_Msg112 - P5_Messages_German_Text
    .word P5_Messages_German_Msg113 - P5_Messages_German_Text
    .word P5_Messages_German_Msg114 - P5_Messages_German_Text
    .word P5_Messages_German_Msg115 - P5_Messages_German_Text
    .word P5_Messages_German_Msg116 - P5_Messages_German_Text
    .word P5_Messages_German_Msg117 - P5_Messages_German_Text
    .word P5_Messages_German_Msg118 - P5_Messages_German_Text
    .word P5_Messages_German_Msg119 - P5_Messages_German_Text
    .word P5_Messages_German_Msg120 - P5_Messages_German_Text
    .word P5_Messages_German_Msg121 - P5_Messages_German_Text
    .word P5_Messages_German_Msg122 - P5_Messages_German_Text
    .word P5_Messages_German_Msg123 - P5_Messages_German_Text
    .word P5_Messages_German_Msg124 - P5_Messages_German_Text
    .word P5_Messages_German_Msg125 - P5_Messages_German_Text
    .word P5_Messages_German_Msg126 - P5_Messages_German_Text
    .word P5_Messages_German_Msg127 - P5_Messages_German_Text
    .word P5_Messages_German_Msg128 - P5_Messages_German_Text
    .word P5_Messages_German_Msg129 - P5_Messages_German_Text
    .word P5_Messages_German_Msg130 - P5_Messages_German_Text
    .word P5_Messages_German_Msg131 - P5_Messages_German_Text
    .word P5_Messages_German_Msg132 - P5_Messages_German_Text
    .word P5_Messages_German_Msg133 - P5_Messages_German_Text
    .word P5_Messages_German_Msg134 - P5_Messages_German_Text
    .word P5_Messages_German_Msg135 - P5_Messages_German_Text
    .word P5_Messages_German_Msg136 - P5_Messages_German_Text
    .word P5_Messages_German_Msg137 - P5_Messages_German_Text
    .word P5_Messages_German_Msg138 - P5_Messages_German_Text
    .word P5_Messages_German_Msg139 - P5_Messages_German_Text
    .word P5_Messages_German_Msg140 - P5_Messages_German_Text
    .word P5_Messages_German_Msg141 - P5_Messages_German_Text
    .word P5_Messages_German_Msg142 - P5_Messages_German_Text
    .word P5_Messages_German_Msg143 - P5_Messages_German_Text
    .word P5_Messages_German_Msg144 - P5_Messages_German_Text
    .word P5_Messages_German_Msg145 - P5_Messages_German_Text
    .word P5_Messages_German_Msg146 - P5_Messages_German_Text
    .word P5_Messages_German_Msg147 - P5_Messages_German_Text
    .word P5_Messages_German_Msg148 - P5_Messages_German_Text
    .word P5_Messages_German_Msg149 - P5_Messages_German_Text
    .word P5_Messages_German_Msg150 - P5_Messages_German_Text
    .word P5_Messages_German_Msg151 - P5_Messages_German_Text
    .word P5_Messages_German_Msg152 - P5_Messages_German_Text
    .word P5_Messages_German_Msg153 - P5_Messages_German_Text
    .word P5_Messages_German_Msg154 - P5_Messages_German_Text
    .word P5_Messages_German_Msg155 - P5_Messages_German_Text
    .word P5_Messages_German_Msg156 - P5_Messages_German_Text
    .word P5_Messages_German_Msg157 - P5_Messages_German_Text
    .word P5_Messages_German_Msg158 - P5_Messages_German_Text
    .word P5_Messages_German_Msg159 - P5_Messages_German_Text
    .word P5_Messages_German_Msg160 - P5_Messages_German_Text
    .word P5_Messages_German_Msg161 - P5_Messages_German_Text
    .word P5_Messages_German_Msg162 - P5_Messages_German_Text
    .word P5_Messages_German_Msg163 - P5_Messages_German_Text
P5_Messages_German_EntriesEnd:
P5_Messages_German_Data:
    .ascii "DAT1"
    .word P5_Messages_German_End - P5_Messages_German_Data
P5_Messages_German_Text:
    .byte 0x00
P5_Messages_German_Msg000:
    .stringn "Kalibrierung erfolgreich. Berühre "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii ","
    .byte 0x0A ; line break / 换行
    .ascii "um die Kalibrierung zu testen."
    .byte 0x00
P5_Messages_German_Msg001:
    .stringn "Drücke "
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii ", um keine"
    .byte 0x0A ; line break / 换行
    .stringn "Änderungen durchzuführen."
    .byte 0x00
P5_Messages_German_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Neuer Versuch"
    .byte 0x00
P5_Messages_German_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Beenden"
    .byte 0x00
P5_Messages_German_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Ja"
    .byte 0x00
P5_Messages_German_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Nein"
    .byte 0x00
P5_Messages_German_Msg006:
    .ascii "Alles Gute!"
    .byte 0x0A ; line break / 换行
    .stringn "∩ hat heute Geburtstag!"
    .byte 0x00
P5_Messages_German_Msg007:
    .stringn "∩ hat nun den"
    .byte 0x0A ; line break / 换行
    .stringn "Raum von ⊿ betreten."
    .byte 0x00
P5_Messages_German_Msg008:
    .ascii "Betreten "
    .byte 0xEE, 0x80, 0x99 ; U+E019 glyph / 字形
    .stringn "⊿ ∩"
    .byte 0x00
P5_Messages_German_Msg009:
    .ascii "Verlassen "
    .byte 0xEE, 0x80, 0x9A ; U+E01A glyph / 字形
    .stringn "⊿ ∩"
    .byte 0x00
P5_Messages_German_Msg010:
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
P5_Messages_German_Msg011:
    .ascii "Chat-Raum A"
    .byte 0x00
P5_Messages_German_Msg012:
    .ascii "Chat-Raum B"
    .byte 0x00
P5_Messages_German_Msg013:
    .ascii "Chat-Raum C"
    .byte 0x00
P5_Messages_German_Msg014:
    .ascii "Chat-Raum D"
    .byte 0x00
P5_Messages_German_Msg015:
    .stringn "Wähle einen Chat-Raum."
    .byte 0x00
P5_Messages_German_Msg016:
    .stringn "Wähle Farbe"
    .byte 0x00
P5_Messages_German_Msg017:
    .ascii "Abbruch"
    .byte 0x00
P5_Messages_German_Msg018:
    .stringn "Bestätigen"
    .byte 0x00
P5_Messages_German_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Alarm aktivieren"
    .byte 0x00
P5_Messages_German_Msg020:
    .ascii "Stunde"
    .byte 0x00
P5_Messages_German_Msg021:
    .ascii "Minute"
    .byte 0x00
P5_Messages_German_Msg022:
    .ascii "Tag"
    .byte 0x00
P5_Messages_German_Msg023:
    .ascii "Monat"
    .byte 0x00
P5_Messages_German_Msg024:
    .stringn "Das Hauptmenü erscheint"
    .byte 0x0A ; line break / 换行
    .ascii "automatisch, wenn du das"
    .byte 0x0A ; line break / 换行
    .stringn "Gerät einschaltest."
    .byte 0x00
P5_Messages_German_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .ascii " Auto-Modus"
    .byte 0x00
P5_Messages_German_Msg026:
    .ascii "Ist beim Einschalten eine DS-Karte"
    .byte 0x0A ; line break / 换行
    .ascii "oder ein Modul eingesteckt, beginnt"
    .byte 0x0A ; line break / 换行
    .ascii "das Spiel automatisch."
    .byte 0x00
P5_Messages_German_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .ascii " Manueller Modus"
    .byte 0x00
P5_Messages_German_Msg028:
    .ascii "Tag"
    .byte 0x00
P5_Messages_German_Msg029:
    .ascii "Monat"
    .byte 0x00
P5_Messages_German_Msg030:
    .ascii "Jahr"
    .byte 0x00
P5_Messages_German_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Bestätigen"
    .byte 0x00
P5_Messages_German_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Eingabe"
    .byte 0x00
P5_Messages_German_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Betreten"
    .byte 0x00
P5_Messages_German_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_German_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Auswahl"
    .byte 0x00
P5_Messages_German_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_German_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Ja"
    .byte 0x00
P5_Messages_German_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " Zurück"
    .byte 0x00
P5_Messages_German_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Abbruch"
    .byte 0x00
P5_Messages_German_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " Löschen"
    .byte 0x00
P5_Messages_German_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Nein"
    .byte 0x00
P5_Messages_German_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Ende"
    .byte 0x00
P5_Messages_German_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_German_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_German_Msg045:
    .ascii "Es befindet sich keine"
    .byte 0x0A ; line break / 换行
    .ascii "DS-Karte im Kartenschlitz."
    .byte 0x00
P5_Messages_German_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_German_Msg047:
    .ascii "GBA-Spiel wird gestartet."
    .byte 0x00
P5_Messages_German_Msg048:
    .ascii "Es befindet sich kein Modul"
    .byte 0x0A ; line break / 换行
    .ascii "im Modulschacht."
    .byte 0x00
P5_Messages_German_Msg049:
    .ascii "Im Modulschacht befindet"
    .byte 0x0A ; line break / 换行
    .ascii "sich ein DS-Optionsmodul."
    .byte 0x00
P5_Messages_German_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_German_Msg051:
    .ascii "Einstellungen"
    .byte 0x00
P5_Messages_German_Msg052:
    .ascii "DS-Download-Spiel"
    .byte 0x00
P5_Messages_German_Msg053:
    .ascii "Nein"
    .byte 0x00
P5_Messages_German_Msg054:
    .ascii "Ja"
    .byte 0x00
P5_Messages_German_Msg055:
    .ascii "Der Alarm wurde deaktiviert."
    .byte 0x00
P5_Messages_German_Msg056:
    .stringn "Möchtest du den Alarm deaktivieren?"
    .byte 0x00
P5_Messages_German_Msg057:
    .stringn "Möchtest du den Alarm für"
    .byte 0x0A ; line break / 换行
    .stringn "●●:●● einstellen?"
    .byte 0x00
P5_Messages_German_Msg058:
    .stringn "Möchtest du beim Alarm auch die"
    .byte 0x0A ; line break / 换行
    .ascii "Rumble-Funktion aktivieren?"
    .byte 0x00
P5_Messages_German_Msg059:
    .ascii "Verbindungsfehler. Bitte kehre zur"
    .byte 0x0A ; line break / 换行
    .stringn "Raum-Auswahl zurück."
    .byte 0x00
P5_Messages_German_Msg060:
    .stringn "Chat-Raum ⊿ ist voll. Du kannst"
    .byte 0x0A ; line break / 换行
    .stringn "Chat-Raum ⊿ nicht betreten."
    .byte 0x00
P5_Messages_German_Msg061:
    .ascii "Verbindungsfehler. Bitte"
    .byte 0x0A ; line break / 换行
    .stringn "schalte das Gerät aus."
    .byte 0x00
P5_Messages_German_Msg062:
    .ascii "Download erfolgt..."
    .byte 0x00
P5_Messages_German_Msg063:
    .ascii "Download wurde abgebrochen."
    .byte 0x00
P5_Messages_German_Msg064:
    .ascii "Die maximale Teilnehmerzahl wurde"
    .byte 0x0A ; line break / 换行
    .stringn "erreicht. Download nicht möglich."
    .byte 0x00
P5_Messages_German_Msg065:
    .ascii "Die Software wurde"
    .byte 0x0A ; line break / 换行
    .ascii "erfolgreich heruntergeladen."
    .byte 0x00
P5_Messages_German_Msg066:
    .ascii "Du musst zuerst die System-"
    .byte 0x0A ; line break / 换行
    .ascii "einstellungen justieren. Bitte"
    .byte 0x0A ; line break / 换行
    .stringn "berühre den Touchscreen oder"
    .byte 0x0A ; line break / 换行
    .stringn "drücke einen Knopf."
    .byte 0x00
P5_Messages_German_Msg067:
    .stringn "Bestätige deine Einstellungen."
    .byte 0x0A ; line break / 换行
    .stringn "Berühre den Touchscreen oder"
    .byte 0x0A ; line break / 换行
    .stringn "drücke einen Knopf."
    .byte 0x00
P5_Messages_German_Msg068:
    .ascii "Die Sprache wird auf Deutsch"
    .byte 0x0A ; line break / 换行
    .ascii "umgeschaltet. Ist das okay?"
    .byte 0x00
P5_Messages_German_Msg069:
    .stringn "Möchtest du diese Software"
    .byte 0x0A ; line break / 换行
    .ascii "herunterladen?"
    .byte 0x00
P5_Messages_German_Msg070:
    .stringn "Übertragung fortsetzen?"
    .byte 0x00
P5_Messages_German_Msg071:
    .ascii "Verbindungsfehler. Software konnte"
    .byte 0x0A ; line break / 换行
    .ascii "nicht heruntergeladen werden."
    .byte 0x00
P5_Messages_German_Msg072:
    .ascii "Das System wird nun ausgeschaltet."
    .byte 0x00
P5_Messages_German_Msg073:
    .ascii "Um die neuen Einstellungen zu"
    .byte 0x0A ; line break / 换行
    .ascii "aktivieren, muss ein Neustart"
    .byte 0x0A ; line break / 换行
    .stringn "durchgeführt werden. Möchtest du"
    .byte 0x0A ; line break / 换行
    .ascii "jetzt ausschalten?"
    .byte 0x00
P5_Messages_German_Msg074:
    .ascii "Suche nach Software zum"
    .byte 0x0A ; line break / 换行
    .stringn "Download läuft."
    .byte 0x00
P5_Messages_German_Msg075:
    .ascii "Alarmeinstell. wurden gespeichert."
    .byte 0x00
P5_Messages_German_Msg076:
    .ascii "Systemstart ist auf Auto eingestellt."
    .byte 0x00
P5_Messages_German_Msg077:
    .ascii "Geburtsdatum wurde gespeichert."
    .byte 0x00
P5_Messages_German_Msg078:
    .ascii "GBA-Bildschirm wird auf dem"
    .byte 0x0A ; line break / 换行
    .ascii "Touchscreen eingeblendet."
    .byte 0x00
P5_Messages_German_Msg079:
    .ascii "Farbe wurde gespeichert."
    .byte 0x00
P5_Messages_German_Msg080:
    .ascii "Kommentar wurde gespeichert."
    .byte 0x00
P5_Messages_German_Msg081:
    .ascii "Datum wurde gespeichert."
    .byte 0x00
P5_Messages_German_Msg082:
    .ascii "Spracheinstellung: Englisch"
    .byte 0x00
P5_Messages_German_Msg083:
    .stringn "Spracheinstellung: Französisch"
    .byte 0x00
P5_Messages_German_Msg084:
    .ascii "Spracheinstellung: Deutsch"
    .byte 0x00
P5_Messages_German_Msg085:
    .ascii "Spracheinstellung: Italienisch"
    .byte 0x00
P5_Messages_German_Msg086:
    .ascii "Spracheinstellung: Japanisch"
    .byte 0x00
P5_Messages_German_Msg087:
    .ascii "Systemstart ist auf Manuell"
    .byte 0x0A ; line break / 换行
    .ascii "eingestellt."
    .byte 0x00
P5_Messages_German_Msg088:
    .ascii "User-Name wurde gespeichert."
    .byte 0x00
P5_Messages_German_Msg089:
    .ascii "Der Touchscreen wurde kalibriert."
    .byte 0x00
P5_Messages_German_Msg090:
    .ascii "Spracheinstellung: Spanisch"
    .byte 0x00
P5_Messages_German_Msg091:
    .ascii "Uhrzeit wurde gespeichert."
    .byte 0x00
P5_Messages_German_Msg092:
    .ascii "GBA-Bildschirm wird auf dem"
    .byte 0x0A ; line break / 换行
    .ascii "Topscreen eingeblendet."
    .byte 0x00
P5_Messages_German_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_German_Msg094:
    .stringn "Alarm wurde eingestellt. Berühre den Touch-"
    .byte 0x0A ; line break / 换行
    .stringn "screen oder drücke einen Knopf, um ihn zu"
    .byte 0x0A ; line break / 换行
    .ascii "deaktivieren. "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " deaktivieren den Alarm nicht."
    .byte 0x0A ; line break / 换行
    .stringn "(Stelle die Lautstärke ein, falls nötig.)"
    .byte 0x00
P5_Messages_German_Msg095:
    .stringn "Der Alarm wurde aktiviert. Berühre den"
    .byte 0x0A ; line break / 换行
    .stringn "Touchscreen oder drücke einen Knopf,"
    .byte 0x0A ; line break / 换行
    .ascii "um ihn zu deaktivieren. "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " deaktivieren"
    .byte 0x0A ; line break / 换行
    .ascii "den Alarm nicht."
    .byte 0x00
P5_Messages_German_Msg096:
    .stringn "Alarm ist um ●●:●● überschritten. Berühre"
    .byte 0x0A ; line break / 换行
    .stringn "den Touchscreen oder drücke einen Knopf,"
    .byte 0x0A ; line break / 换行
    .ascii "um ihn zu deaktivieren. "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " deaktivieren"
    .byte 0x0A ; line break / 换行
    .ascii "den Alarm nicht."
    .byte 0x00
P5_Messages_German_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_German_Msg098:
    .ascii "Stunde"
    .byte 0x00
P5_Messages_German_Msg099:
    .ascii "Minute"
    .byte 0x00
P5_Messages_German_Msg100:
    .ascii "Touch-"
    .byte 0x0A ; line break / 换行
    .ascii "screen"
    .byte 0x00
P5_Messages_German_Msg101:
    .ascii "Top-"
    .byte 0x0A ; line break / 换行
    .ascii "screen"
    .byte 0x00
P5_Messages_German_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_German_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_German_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_German_Msg105:
    .ascii "Italiano"
    .byte 0x00
P5_Messages_German_Msg106:
    .stringn "日本語"
    .byte 0x00
P5_Messages_German_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_German_Msg108:
    .ascii "00:00"
    .byte 0x00
P5_Messages_German_Msg109:
    .ascii "DD.MM."
    .byte 0x00
P5_Messages_German_Msg110:
    .ascii "Fr"
    .byte 0x00
P5_Messages_German_Msg111:
    .ascii "Lade Software via DS-Download-Spiel"
    .byte 0x0A ; line break / 换行
    .ascii "herunter."
    .byte 0x00
P5_Messages_German_Msg112:
    .stringn "Weitere Einstellungen ändern."
    .byte 0x00
P5_Messages_German_Msg113:
    .ascii "Stelle ein, wie dein Nintendo DS-System"
    .byte 0x0A ; line break / 换行
    .ascii "starten soll, wenn du es einschaltest."
    .byte 0x00
P5_Messages_German_Msg114:
    .stringn "Wähle den Bildschirm, den du für den"
    .byte 0x0A ; line break / 换行
    .stringn "GBA-Modus nutzen möchtest."
    .byte 0x00
P5_Messages_German_Msg115:
    .stringn "Wähle die gewünschte Sprache."
    .byte 0x00
P5_Messages_German_Msg116:
    .ascii "Gib User-Informationen ein."
    .byte 0x00
P5_Messages_German_Msg117:
    .ascii "Gib deinen Spitznamen ein."
    .byte 0x00
P5_Messages_German_Msg118:
    .stringn "Wähle deine Lieblingsfarbe."
    .byte 0x00
P5_Messages_German_Msg119:
    .ascii "Gib dein Geburtsdatum ein."
    .byte 0x00
P5_Messages_German_Msg120:
    .stringn "Gib eine persönliche Nachricht ein."
    .byte 0x00
P5_Messages_German_Msg121:
    .ascii "Kalibriere den Touchscreen."
    .byte 0x0A ; line break / 换行
    .stringn "Berühre "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " mit dem Touchpen."
    .byte 0x00
P5_Messages_German_Msg122:
    .stringn "Ändere deine Einstellungen. Wähle eine"
    .byte 0x0A ; line break / 换行
    .stringn "Einstellung, die du ändern möchtest."
    .byte 0x00
P5_Messages_German_Msg123:
    .stringn "Ändere Datum, Zeit und"
    .byte 0x0A ; line break / 换行
    .ascii "Alarmeinstellungen."
    .byte 0x00
P5_Messages_German_Msg124:
    .ascii "Gib das heutige Datum ein."
    .byte 0x00
P5_Messages_German_Msg125:
    .ascii "Gib die aktuelle Zeit ein."
    .byte 0x00
P5_Messages_German_Msg126:
    .stringn "Berühre ("
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .ascii ") zum Aktivieren des"
    .byte 0x0A ; line break / 换行
    .stringn "Alarms zur gewünschten Zeit."
    .byte 0x00
P5_Messages_German_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_German_Msg128:
    .ascii "Mo"
    .byte 0x00
P5_Messages_German_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_German_Msg130:
    .ascii "Sa"
    .byte 0x00
P5_Messages_German_Msg131:
    .ascii "So"
    .byte 0x00
P5_Messages_German_Msg132:
    .ascii "Do"
    .byte 0x00
P5_Messages_German_Msg133:
    .ascii "DS-Download-Spiel"
    .byte 0x00
P5_Messages_German_Msg134:
    .ascii "Optionen"
    .byte 0x00
P5_Messages_German_Msg135:
    .ascii "Start-up"
    .byte 0x00
P5_Messages_German_Msg136:
    .ascii "GBA-Modus"
    .byte 0x00
P5_Messages_German_Msg137:
    .ascii "Sprache"
    .byte 0x00
P5_Messages_German_Msg138:
    .ascii "User"
    .byte 0x00
P5_Messages_German_Msg139:
    .ascii "User-Name"
    .byte 0x00
P5_Messages_German_Msg140:
    .ascii "Farbe"
    .byte 0x00
P5_Messages_German_Msg141:
    .ascii "Geburtsdatum"
    .byte 0x00
P5_Messages_German_Msg142:
    .ascii "Kommentar"
    .byte 0x00
P5_Messages_German_Msg143:
    .ascii "Touchscreen"
    .byte 0x00
P5_Messages_German_Msg144:
    .ascii "Einstellungen"
    .byte 0x00
P5_Messages_German_Msg145:
    .ascii "Uhr"
    .byte 0x00
P5_Messages_German_Msg146:
    .ascii "Datum"
    .byte 0x00
P5_Messages_German_Msg147:
    .ascii "Zeit"
    .byte 0x00
P5_Messages_German_Msg148:
    .ascii "Alarm"
    .byte 0x00
P5_Messages_German_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_German_Msg150:
    .ascii "Di"
    .byte 0x00
P5_Messages_German_Msg151:
    .ascii "Mi"
    .byte 0x00
P5_Messages_German_Msg152:
    .ascii "MM.YYYY"
    .byte 0x00
P5_Messages_German_Msg153:
    .ascii "DD.MM.YYYY"
    .byte 0x00
P5_Messages_German_Msg154:
    .ascii "Aktuelle Zeit"
    .byte 0x00
P5_Messages_German_Msg155:
    .ascii "00:00:00"
    .byte 0x00
P5_Messages_German_Msg156:
    .ascii "Verbleibende Zeit"
    .byte 0x00
P5_Messages_German_Msg157:
    .ascii "Vergangene Zeit"
    .byte 0x00
P5_Messages_German_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_German_Msg159:
    .ascii "Alarmeinstellung"
    .byte 0x00
P5_Messages_German_Msg160:
    .ascii "Abbruch"
    .byte 0x00
P5_Messages_German_Msg161:
    .stringn "Bestätigen"
    .byte 0x00
P5_Messages_German_Msg162:
    .stringn "Wähle die gewünschte Sprache."
    .byte 0x00
P5_Messages_German_Msg163:
    .stringn "Systemeinstellungen sind gelöscht."
    .byte 0x0A ; line break / 换行
    .stringn "Bitte berühre "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii "."
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
.loadtable "../../include/utf16le.tbl","utf-8"
