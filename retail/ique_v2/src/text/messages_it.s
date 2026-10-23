; BMG resource; included by p5.s at P5_Messages_Italian.
; BMG 资源，由 p5.s 在 P5_Messages_Italian 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_Italian_End - P5_Messages_Italian
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_it.bmg", 0x11, 0xF ; original format bytes / 原始格式字节
P5_Messages_Italian_Info:
    .ascii "INF1"
    .word P5_Messages_Italian_Data - P5_Messages_Italian_Info
    .dh (P5_Messages_Italian_EntriesEnd - P5_Messages_Italian_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_Italian_Entries:
    .word P5_Messages_Italian_Msg000 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg001 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg002 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg003 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg004 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg005 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg006 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg007 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg008 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg009 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg010 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg011 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg012 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg013 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg014 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg015 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg016 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg017 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg018 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg019 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg020 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg021 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg022 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg023 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg024 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg025 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg026 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg027 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg028 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg029 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg030 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg031 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg032 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg033 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg034 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg035 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg036 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg037 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg038 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg039 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg040 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg041 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg042 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg043 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg044 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg045 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg046 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg047 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg048 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg049 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg050 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg051 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg052 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg053 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg054 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg055 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg056 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg057 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg058 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg059 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg060 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg061 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg062 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg063 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg064 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg065 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg066 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg067 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg068 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg069 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg070 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg071 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg072 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg073 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg074 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg075 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg076 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg077 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg078 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg079 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg080 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg081 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg082 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg083 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg084 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg085 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg086 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg087 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg088 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg089 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg090 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg091 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg092 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg093 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg094 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg095 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg096 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg097 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg098 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg099 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg100 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg101 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg102 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg103 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg104 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg105 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg106 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg107 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg108 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg109 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg110 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg111 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg112 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg113 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg114 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg115 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg116 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg117 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg118 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg119 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg120 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg121 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg122 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg123 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg124 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg125 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg126 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg127 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg128 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg129 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg130 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg131 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg132 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg133 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg134 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg135 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg136 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg137 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg138 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg139 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg140 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg141 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg142 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg143 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg144 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg145 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg146 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg147 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg148 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg149 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg150 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg151 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg152 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg153 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg154 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg155 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg156 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg157 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg158 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg159 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg160 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg161 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg162 - P5_Messages_Italian_Text
    .word P5_Messages_Italian_Msg163 - P5_Messages_Italian_Text
P5_Messages_Italian_EntriesEnd:
P5_Messages_Italian_Data:
    .ascii "DAT1"
    .word P5_Messages_Italian_End - P5_Messages_Italian_Data
P5_Messages_Italian_Text:
    .byte 0x00
P5_Messages_Italian_Msg000:
    .ascii "Calibrazione completata. Puoi"
    .byte 0x0A ; line break / 换行
    .ascii "testarla toccando le icone "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii "."
    .byte 0x00
P5_Messages_Italian_Msg001:
    .ascii "Premi "
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " per annullare."
    .byte 0x00
P5_Messages_Italian_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Ripeti"
    .byte 0x00
P5_Messages_Italian_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Chiudi"
    .byte 0x00
P5_Messages_Italian_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Sì"
    .byte 0x00
P5_Messages_Italian_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " No"
    .byte 0x00
P5_Messages_Italian_Msg006:
    .ascii "Tanti auguri!"
    .byte 0x0A ; line break / 换行
    .stringn "Oggi è il compleanno di ∩!"
    .byte 0x00
P5_Messages_Italian_Msg007:
    .stringn "∩ ha cambiato stanza."
    .byte 0x0A ; line break / 换行
    .stringn "Ora è nella stanza ⊿."
    .byte 0x00
P5_Messages_Italian_Msg008:
    .stringn "Entra nella stanza ⊿: ∩"
    .byte 0x00
P5_Messages_Italian_Msg009:
    .stringn "Esce dalla stanza ⊿: ∩"
    .byte 0x00
P5_Messages_Italian_Msg010:
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
P5_Messages_Italian_Msg011:
    .ascii "Stanza A"
    .byte 0x00
P5_Messages_Italian_Msg012:
    .ascii "Stanza B"
    .byte 0x00
P5_Messages_Italian_Msg013:
    .ascii "Stanza C"
    .byte 0x00
P5_Messages_Italian_Msg014:
    .ascii "Stanza D"
    .byte 0x00
P5_Messages_Italian_Msg015:
    .ascii "Scegli la stanza in cui vuoi chattare."
    .byte 0x00
P5_Messages_Italian_Msg016:
    .ascii "Scegli colore"
    .byte 0x00
P5_Messages_Italian_Msg017:
    .ascii "Annulla"
    .byte 0x00
P5_Messages_Italian_Msg018:
    .ascii "Conferma"
    .byte 0x00
P5_Messages_Italian_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Attiva la sveglia"
    .byte 0x00
P5_Messages_Italian_Msg020:
    .ascii "Ore"
    .byte 0x00
P5_Messages_Italian_Msg021:
    .ascii "Minuti"
    .byte 0x00
P5_Messages_Italian_Msg022:
    .ascii "Giorno"
    .byte 0x00
P5_Messages_Italian_Msg023:
    .ascii "Mese"
    .byte 0x00
P5_Messages_Italian_Msg024:
    .ascii "Quando accendi la console"
    .byte 0x0A ; line break / 换行
    .ascii "appare automaticamente il"
    .byte 0x0A ; line break / 换行
    .ascii "menu di sistema."
    .byte 0x00
P5_Messages_Italian_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .stringn " Modalità automatica"
    .byte 0x00
P5_Messages_Italian_Msg026:
    .ascii "Se accendi la console con una scheda DS"
    .byte 0x0A ; line break / 换行
    .ascii "o una cassetta di gioco inserita, inizia"
    .byte 0x0A ; line break / 换行
    .ascii "automaticamente il gioco."
    .byte 0x00
P5_Messages_Italian_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .stringn " Modalità manuale"
    .byte 0x00
P5_Messages_Italian_Msg028:
    .ascii "Giorno"
    .byte 0x00
P5_Messages_Italian_Msg029:
    .ascii "Mese"
    .byte 0x00
P5_Messages_Italian_Msg030:
    .ascii "Anno"
    .byte 0x00
P5_Messages_Italian_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Conferma"
    .byte 0x00
P5_Messages_Italian_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Inserisci"
    .byte 0x00
P5_Messages_Italian_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Seleziona"
    .byte 0x00
P5_Messages_Italian_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_Italian_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Seleziona"
    .byte 0x00
P5_Messages_Italian_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_Italian_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Sì"
    .byte 0x00
P5_Messages_Italian_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Indietro"
    .byte 0x00
P5_Messages_Italian_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Annulla"
    .byte 0x00
P5_Messages_Italian_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Cancella"
    .byte 0x00
P5_Messages_Italian_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " No"
    .byte 0x00
P5_Messages_Italian_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Esci"
    .byte 0x00
P5_Messages_Italian_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_Italian_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_Italian_Msg045:
    .stringn "Non è inserita alcuna"
    .byte 0x0A ; line break / 换行
    .ascii "scheda DS."
    .byte 0x00
P5_Messages_Italian_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_Italian_Msg047:
    .ascii "Avvia gioco GBA."
    .byte 0x00
P5_Messages_Italian_Msg048:
    .stringn "Non è inserita alcuna"
    .byte 0x0A ; line break / 换行
    .ascii "cassetta di gioco."
    .byte 0x00
P5_Messages_Italian_Msg049:
    .stringn "È inserita una cassetta"
    .byte 0x0A ; line break / 换行
    .ascii "opzioni DS."
    .byte 0x00
P5_Messages_Italian_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_Italian_Msg051:
    .ascii "Impostazioni"
    .byte 0x00
P5_Messages_Italian_Msg052:
    .ascii "Download DS"
    .byte 0x00
P5_Messages_Italian_Msg053:
    .ascii "No"
    .byte 0x00
P5_Messages_Italian_Msg054:
    .stringn "Sì"
    .byte 0x00
P5_Messages_Italian_Msg055:
    .stringn "La sveglia è stata disattivata."
    .byte 0x00
P5_Messages_Italian_Msg056:
    .ascii "Vuoi disattivare la sveglia?"
    .byte 0x00
P5_Messages_Italian_Msg057:
    .stringn "La sveglia suonerà a"
    .byte 0x0A ; line break / 换行
    .stringn "quest'ora: ●●:●●."
    .byte 0x0A ; line break / 换行
    .ascii "Va bene?"
    .byte 0x00
P5_Messages_Italian_Msg058:
    .ascii "Vuoi attivare la funzione di"
    .byte 0x0A ; line break / 换行
    .ascii "vibrazione insieme alla sveglia?"
    .byte 0x00
P5_Messages_Italian_Msg059:
    .ascii "Errore di trasmissione."
    .byte 0x0A ; line break / 换行
    .ascii "Ritorna alla selezione stanze."
    .byte 0x00
P5_Messages_Italian_Msg060:
    .stringn "La stanza ⊿ è piena."
    .byte 0x0A ; line break / 换行
    .ascii "Non puoi entrarci."
    .byte 0x00
P5_Messages_Italian_Msg061:
    .ascii "Errore di trasmissione."
    .byte 0x0A ; line break / 换行
    .ascii "Spegni la console."
    .byte 0x00
P5_Messages_Italian_Msg062:
    .ascii "Download in corso."
    .byte 0x00
P5_Messages_Italian_Msg063:
    .stringn "Il download è stato annullato."
    .byte 0x00
P5_Messages_Italian_Msg064:
    .stringn "È stato raggiunto il numero massimo"
    .byte 0x0A ; line break / 换行
    .ascii "di partecipanti. Impossibile"
    .byte 0x0A ; line break / 换行
    .ascii "effettuare il download."
    .byte 0x00
P5_Messages_Italian_Msg065:
    .stringn "Il download del software è"
    .byte 0x0A ; line break / 换行
    .ascii "completato."
    .byte 0x00
P5_Messages_Italian_Msg066:
    .ascii "Prima di tutto devi configurare le"
    .byte 0x0A ; line break / 换行
    .ascii "impostazioni di sistema. Tocca il"
    .byte 0x0A ; line break / 换行
    .ascii "touch screen o premi un pulsante."
    .byte 0x00
P5_Messages_Italian_Msg067:
    .ascii "Controlla le impostazioni di sistema."
    .byte 0x0A ; line break / 换行
    .ascii "Tocca il touch screen o premi un"
    .byte 0x0A ; line break / 换行
    .ascii "pulsante."
    .byte 0x00
P5_Messages_Italian_Msg068:
    .stringn "La lingua impostata diventerà"
    .byte 0x0A ; line break / 换行
    .ascii "l'italiano."
    .byte 0x0A ; line break / 换行
    .ascii "Confermi la selezione?"
    .byte 0x00
P5_Messages_Italian_Msg069:
    .ascii "Vuoi scaricare questo software?"
    .byte 0x00
P5_Messages_Italian_Msg070:
    .ascii "Ristabilire la comunicazione?"
    .byte 0x00
P5_Messages_Italian_Msg071:
    .ascii "Errore di trasmissione."
    .byte 0x0A ; line break / 换行
    .ascii "Download non completato."
    .byte 0x00
P5_Messages_Italian_Msg072:
    .stringn "La console si spegnerà."
    .byte 0x0A ; line break / 换行
    .ascii "Va bene?"
    .byte 0x00
P5_Messages_Italian_Msg073:
    .ascii "Le nuove impostazioni si attiveranno"
    .byte 0x0A ; line break / 换行
    .ascii "soltanto alla riaccensione della"
    .byte 0x0A ; line break / 换行
    .ascii "console. Vuoi spegnerla adesso?"
    .byte 0x00
P5_Messages_Italian_Msg074:
    .ascii "Ricerca di software da"
    .byte 0x0A ; line break / 换行
    .ascii "scaricare in corso."
    .byte 0x00
P5_Messages_Italian_Msg075:
    .stringn "L'ora della sveglia è stata salvata."
    .byte 0x00
P5_Messages_Italian_Msg076:
    .stringn "Ora la modalità di avvio è"
    .byte 0x0A ; line break / 换行
    .ascii "impostata su \"automatica\"."
    .byte 0x00
P5_Messages_Italian_Msg077:
    .stringn "Il compleanno è stato salvato."
    .byte 0x00
P5_Messages_Italian_Msg078:
    .stringn "Ora lo schermo della modalità GBA"
    .byte 0x0A ; line break / 换行
    .stringn "è il touch screen."
    .byte 0x00
P5_Messages_Italian_Msg079:
    .stringn "Il colore è stato salvato."
    .byte 0x00
P5_Messages_Italian_Msg080:
    .stringn "Il messaggio è stato salvato."
    .byte 0x00
P5_Messages_Italian_Msg081:
    .stringn "La data è stata salvata."
    .byte 0x00
P5_Messages_Italian_Msg082:
    .ascii "Lingua impostata: inglese."
    .byte 0x00
P5_Messages_Italian_Msg083:
    .ascii "Lingua impostata: francese."
    .byte 0x00
P5_Messages_Italian_Msg084:
    .ascii "Lingua impostata: tedesco."
    .byte 0x00
P5_Messages_Italian_Msg085:
    .ascii "Lingua impostata: italiano."
    .byte 0x00
P5_Messages_Italian_Msg086:
    .byte 0x00
P5_Messages_Italian_Msg087:
    .stringn "Ora la modalità di avvio"
    .byte 0x0A ; line break / 换行
    .stringn "è impostata su \"manuale\"."
    .byte 0x00
P5_Messages_Italian_Msg088:
    .stringn "Il nome utente è stato salvato."
    .byte 0x00
P5_Messages_Italian_Msg089:
    .stringn "Il touch screen è stato calibrato."
    .byte 0x00
P5_Messages_Italian_Msg090:
    .ascii "Lingua impostata: spagnolo."
    .byte 0x00
P5_Messages_Italian_Msg091:
    .stringn "L'ora è stata salvata."
    .byte 0x00
P5_Messages_Italian_Msg092:
    .stringn "Ora lo schermo della modalità GBA"
    .byte 0x0A ; line break / 换行
    .stringn "è lo schermo superiore."
    .byte 0x00
P5_Messages_Italian_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Italian_Msg094:
    .stringn "La sveglia è attivata. Per disattivarla,"
    .byte 0x0A ; line break / 换行
    .ascii "tocca il touch screen o premi un pulsante."
    .byte 0x0A ; line break / 换行
    .ascii "Non puoi disattivarla premendo "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .ascii " o "
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii "."
    .byte 0x0A ; line break / 换行
    .ascii "Se necessario, regola il volume."
    .byte 0x00
P5_Messages_Italian_Msg095:
    .stringn "È scattata la sveglia! Per disattivarla,"
    .byte 0x0A ; line break / 换行
    .ascii "tocca il touch screen o premi un pulsante."
    .byte 0x0A ; line break / 换行
    .ascii "Non puoi disattivarla premendo "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .ascii " o "
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii "."
    .byte 0x00
P5_Messages_Italian_Msg096:
    .stringn "Tempo trascorso da quando è scattata la"
    .byte 0x0A ; line break / 换行
    .stringn "sveglia: ●●:●●. Per disattivarla, tocca il touch"
    .byte 0x0A ; line break / 换行
    .ascii "screen o premi un pulsante."
    .byte 0x0A ; line break / 换行
    .ascii "Non puoi disattivarla premendo "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .ascii " o "
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii "."
    .byte 0x00
P5_Messages_Italian_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_Italian_Msg098:
    .ascii "Ore"
    .byte 0x00
P5_Messages_Italian_Msg099:
    .ascii "Minuti"
    .byte 0x00
P5_Messages_Italian_Msg100:
    .ascii "Touch"
    .byte 0x0A ; line break / 换行
    .ascii "screen"
    .byte 0x00
P5_Messages_Italian_Msg101:
    .ascii "Schermo"
    .byte 0x0A ; line break / 换行
    .ascii "superiore"
    .byte 0x00
P5_Messages_Italian_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_Italian_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_Italian_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_Italian_Msg105:
    .ascii "Italiano"
    .byte 0x00
P5_Messages_Italian_Msg106:
    .stringn "中文"
    .byte 0x00
P5_Messages_Italian_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_Italian_Msg108:
    .ascii "00:00"
    .byte 0x00
P5_Messages_Italian_Msg109:
    .ascii "DD/MM"
    .byte 0x00
P5_Messages_Italian_Msg110:
    .ascii "Ve"
    .byte 0x00
P5_Messages_Italian_Msg111:
    .ascii "Scarica software tramite il download DS."
    .byte 0x00
P5_Messages_Italian_Msg112:
    .stringn "Scegli la lingua, la modalità di avvio e lo"
    .byte 0x0A ; line break / 换行
    .stringn "schermo della modalità GBA."
    .byte 0x00
P5_Messages_Italian_Msg113:
    .stringn "Scegli la modalità in cui si presenta"
    .byte 0x0A ; line break / 换行
    .ascii "la console all'accensione."
    .byte 0x00
P5_Messages_Italian_Msg114:
    .ascii "Scegli lo schermo che vuoi utilizzare"
    .byte 0x0A ; line break / 换行
    .stringn "quando ti trovi in modalità GBA."
    .byte 0x00
P5_Messages_Italian_Msg115:
    .ascii "Imposta la lingua del sistema."
    .byte 0x00
P5_Messages_Italian_Msg116:
    .ascii "Inserisci i tuoi dati personali."
    .byte 0x00
P5_Messages_Italian_Msg117:
    .ascii "Inserisci il tuo soprannome."
    .byte 0x00
P5_Messages_Italian_Msg118:
    .ascii "Seleziona il colore che preferisci."
    .byte 0x00
P5_Messages_Italian_Msg119:
    .ascii "Inserisci la data del tuo compleanno."
    .byte 0x00
P5_Messages_Italian_Msg120:
    .ascii "Inserisci un messaggio personale."
    .byte 0x00
P5_Messages_Italian_Msg121:
    .ascii "Calibra il touch screen. Tocca "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " sullo"
    .byte 0x0A ; line break / 换行
    .ascii "schermo con lo stilo."
    .byte 0x00
P5_Messages_Italian_Msg122:
    .ascii "Qui puoi cambiare le impostazioni."
    .byte 0x0A ; line break / 换行
    .ascii "Scegli l'impostazione da modificare."
    .byte 0x00
P5_Messages_Italian_Msg123:
    .ascii "Imposta la data, l'ora e la sveglia."
    .byte 0x00
P5_Messages_Italian_Msg124:
    .ascii "Inserisci la data di oggi."
    .byte 0x00
P5_Messages_Italian_Msg125:
    .ascii "Inserisci l'ora attuale."
    .byte 0x00
P5_Messages_Italian_Msg126:
    .ascii "Tocca l'icona della sveglia ("
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .ascii ") per"
    .byte 0x0A ; line break / 换行
    .ascii "farla suonare all'ora impostata."
    .byte 0x00
P5_Messages_Italian_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Italian_Msg128:
    .ascii "Lu"
    .byte 0x00
P5_Messages_Italian_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_Italian_Msg130:
    .ascii "Sa"
    .byte 0x00
P5_Messages_Italian_Msg131:
    .ascii "Do"
    .byte 0x00
P5_Messages_Italian_Msg132:
    .ascii "Gi"
    .byte 0x00
P5_Messages_Italian_Msg133:
    .ascii "Download DS"
    .byte 0x00
P5_Messages_Italian_Msg134:
    .ascii "Opzioni"
    .byte 0x00
P5_Messages_Italian_Msg135:
    .stringn "Modalità di avvio"
    .byte 0x00
P5_Messages_Italian_Msg136:
    .stringn "Modalità GBA"
    .byte 0x00
P5_Messages_Italian_Msg137:
    .ascii "Lingua"
    .byte 0x00
P5_Messages_Italian_Msg138:
    .ascii "Scheda personale"
    .byte 0x00
P5_Messages_Italian_Msg139:
    .ascii "Nome utente"
    .byte 0x00
P5_Messages_Italian_Msg140:
    .ascii "Colore"
    .byte 0x00
P5_Messages_Italian_Msg141:
    .ascii "Compleanno"
    .byte 0x00
P5_Messages_Italian_Msg142:
    .ascii "Messaggio"
    .byte 0x00
P5_Messages_Italian_Msg143:
    .ascii "Touch screen"
    .byte 0x00
P5_Messages_Italian_Msg144:
    .ascii "Impostazioni"
    .byte 0x00
P5_Messages_Italian_Msg145:
    .ascii "Orologio"
    .byte 0x00
P5_Messages_Italian_Msg146:
    .ascii "Data"
    .byte 0x00
P5_Messages_Italian_Msg147:
    .ascii "Ora"
    .byte 0x00
P5_Messages_Italian_Msg148:
    .ascii "Sveglia"
    .byte 0x00
P5_Messages_Italian_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_Italian_Msg150:
    .ascii "Ma"
    .byte 0x00
P5_Messages_Italian_Msg151:
    .ascii "Me"
    .byte 0x00
P5_Messages_Italian_Msg152:
    .ascii "MM/YYYY"
    .byte 0x00
P5_Messages_Italian_Msg153:
    .ascii "DD/MM/YYYY"
    .byte 0x00
P5_Messages_Italian_Msg154:
    .ascii "Ora attuale"
    .byte 0x00
P5_Messages_Italian_Msg155:
    .ascii "00:00:00"
    .byte 0x00
P5_Messages_Italian_Msg156:
    .ascii "Tempo restante:"
    .byte 0x00
P5_Messages_Italian_Msg157:
    .ascii "Tempo trascorso:"
    .byte 0x00
P5_Messages_Italian_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_Italian_Msg159:
    .ascii "Sveglia"
    .byte 0x00
P5_Messages_Italian_Msg160:
    .ascii "Annulla"
    .byte 0x00
P5_Messages_Italian_Msg161:
    .ascii "Conferma"
    .byte 0x00
P5_Messages_Italian_Msg162:
    .ascii "Seleziona la lingua del sistema."
    .byte 0x00
P5_Messages_Italian_Msg163:
    .ascii "Le impostazioni di sistema sono state perdute."
    .byte 0x0A ; line break / 换行
    .ascii "Tocca "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii "."
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
.loadtable "../../include/utf16le.tbl","utf-8"
