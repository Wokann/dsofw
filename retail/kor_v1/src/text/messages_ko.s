; BMG resource; included by p5.s at P5_Messages_Korean.
; BMG 资源，由 p5.s 在 P5_Messages_Korean 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_Korean_End - P5_Messages_Korean
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_ko.bmg", 0x11, 0x3 ; original format bytes / 原始格式字节
    .incbin "src/text/messages_ko.bmg", 0x14, 0xC ; original format bytes / 原始格式字节
P5_Messages_Korean_Info:
    .ascii "INF1"
    .word P5_Messages_Korean_Data - P5_Messages_Korean_Info
    .dh (P5_Messages_Korean_EntriesEnd - P5_Messages_Korean_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_Korean_Entries:
    .word P5_Messages_Korean_Msg000 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg001 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg002 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg003 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg004 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg005 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg006 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg007 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg008 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg009 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg010 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg011 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg012 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg013 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg014 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg015 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg016 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg017 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg018 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg019 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg020 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg021 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg022 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg023 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg024 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg025 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg026 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg027 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg028 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg029 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg030 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg031 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg032 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg033 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg034 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg035 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg036 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg037 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg038 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg039 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg040 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg041 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg042 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg043 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg044 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg045 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg046 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg047 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg048 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg049 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg050 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg051 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg052 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg053 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg054 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg055 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg056 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg057 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg058 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg059 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg060 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg061 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg062 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg063 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg064 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg065 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg066 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg067 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg068 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg069 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg070 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg071 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg072 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg073 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg074 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg075 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg076 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg077 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg078 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg079 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg080 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg081 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg082 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg083 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg084 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg085 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg086 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg087 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg088 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg089 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg090 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg091 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg092 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg093 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg094 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg095 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg096 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg097 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg098 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg099 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg100 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg101 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg102 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg103 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg104 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg105 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg106 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg107 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg108 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg109 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg110 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg111 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg112 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg113 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg114 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg115 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg116 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg117 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg118 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg119 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg120 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg121 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg122 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg123 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg124 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg125 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg126 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg127 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg128 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg129 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg130 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg131 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg132 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg133 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg134 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg135 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg136 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg137 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg138 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg139 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg140 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg141 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg142 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg143 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg144 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg145 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg146 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg147 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg148 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg149 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg150 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg151 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg152 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg153 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg154 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg155 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg156 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg157 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg158 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg159 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg160 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg161 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg162 - P5_Messages_Korean_Text
    .word P5_Messages_Korean_Msg163 - P5_Messages_Korean_Text
P5_Messages_Korean_EntriesEnd:
P5_Messages_Korean_Data:
    .ascii "DAT1"
    .word P5_Messages_Korean_End - P5_Messages_Korean_Data
P5_Messages_Korean_Text:
    .byte 0x00
P5_Messages_Korean_Msg000:
    .stringn "수정했습니다."
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "을  터치해서  확인해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg001:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  버튼으로  수정을  "
    .byte 0x0A ; line break / 换行
    .stringn "취소할  수  있습니다."
    .byte 0x00
P5_Messages_Korean_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .stringn "  한  번  더"
    .byte 0x00
P5_Messages_Korean_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  닫기"
    .byte 0x00
P5_Messages_Korean_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  예"
    .byte 0x00
P5_Messages_Korean_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  아니오"
    .byte 0x00
P5_Messages_Korean_Msg006:
    .stringn "생일  축하합니다!"
    .byte 0x0A ; line break / 换行
    .stringn "오늘은  ∩ 님의"
    .byte 0x0A ; line break / 换行
    .stringn "생일입니다."
    .byte 0x00
P5_Messages_Korean_Msg007:
    .stringn "∩ 님이"
    .byte 0x0A ; line break / 换行
    .stringn "채팅방⊿로  이동했습니다."
    .byte 0x00
P5_Messages_Korean_Msg008:
    .stringn "참가  "
    .byte 0xEE, 0x80, 0x99 ; U+E019 glyph / 字形
    .stringn "⊿  ∩ 님"
    .byte 0x00
P5_Messages_Korean_Msg009:
    .stringn "퇴실  "
    .byte 0xEE, 0x80, 0x9A ; U+E01A glyph / 字形
    .stringn "⊿  ∩ 님"
    .byte 0x00
P5_Messages_Korean_Msg010:
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
P5_Messages_Korean_Msg011:
    .stringn "채팅방  A"
    .byte 0x00
P5_Messages_Korean_Msg012:
    .stringn "채팅방  B"
    .byte 0x00
P5_Messages_Korean_Msg013:
    .stringn "채팅방  C"
    .byte 0x00
P5_Messages_Korean_Msg014:
    .stringn "채팅방  D"
    .byte 0x00
P5_Messages_Korean_Msg015:
    .stringn "참가할  채팅방을  선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg016:
    .stringn "선택  컬러"
    .byte 0x00
P5_Messages_Korean_Msg017:
    .stringn "취소"
    .byte 0x00
P5_Messages_Korean_Msg018:
    .stringn "결정"
    .byte 0x00
P5_Messages_Korean_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .stringn "  알람을  설정"
    .byte 0x00
P5_Messages_Korean_Msg020:
    .stringn "시"
    .byte 0x00
P5_Messages_Korean_Msg021:
    .stringn "분"
    .byte 0x00
P5_Messages_Korean_Msg022:
    .stringn "일"
    .byte 0x00
P5_Messages_Korean_Msg023:
    .stringn "월"
    .byte 0x00
P5_Messages_Korean_Msg024:
    .stringn "전원을  넣은  후"
    .byte 0x0A ; line break / 换行
    .stringn "DS  메뉴에서  무엇을  할지"
    .byte 0x0A ; line break / 换行
    .stringn "선택할  수  있습니다."
    .byte 0x00
P5_Messages_Korean_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .stringn "  오토  모드"
    .byte 0x00
P5_Messages_Korean_Msg026:
    .stringn "전원을  넣은  후"
    .byte 0x0A ; line break / 换行
    .stringn "상황에  따라서"
    .byte 0x0A ; line break / 换行
    .stringn "자동으로  소프트가  실행됩니다."
    .byte 0x00
P5_Messages_Korean_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .stringn "  매뉴얼  모드"
    .byte 0x00
P5_Messages_Korean_Msg028:
    .stringn "일"
    .byte 0x00
P5_Messages_Korean_Msg029:
    .stringn "월"
    .byte 0x00
P5_Messages_Korean_Msg030:
    .stringn "년"
    .byte 0x00
P5_Messages_Korean_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  결정"
    .byte 0x00
P5_Messages_Korean_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  입력"
    .byte 0x00
P5_Messages_Korean_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  참가"
    .byte 0x00
P5_Messages_Korean_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii "  OK"
    .byte 0x00
P5_Messages_Korean_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  선택"
    .byte 0x00
P5_Messages_Korean_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_Korean_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn "  예"
    .byte 0x00
P5_Messages_Korean_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  돌아가기"
    .byte 0x00
P5_Messages_Korean_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  취소"
    .byte 0x00
P5_Messages_Korean_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  삭제"
    .byte 0x00
P5_Messages_Korean_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  아니오"
    .byte 0x00
P5_Messages_Korean_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "  종료"
    .byte 0x00
P5_Messages_Korean_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_Korean_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_Korean_Msg045:
    .stringn "아무것도  꽂혀"
    .byte 0x0A ; line break / 换行
    .stringn "있지  않습니다"
    .byte 0x00
P5_Messages_Korean_Msg046:
    .stringn "아아아아아아아아아아아아아아"
    .byte 0x0A ; line break / 换行
    .stringn "아"
    .byte 0x0A ; line break / 换行
    .stringn "아"
    .byte 0x00
P5_Messages_Korean_Msg047:
    .stringn "GBA  카트리지"
    .byte 0x00
P5_Messages_Korean_Msg048:
    .stringn "아무것도  꽂혀"
    .byte 0x0A ; line break / 换行
    .stringn "있지  않습니다"
    .byte 0x00
P5_Messages_Korean_Msg049:
    .stringn "DS  옵션  카트리지"
    .byte 0x00
P5_Messages_Korean_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_Korean_Msg051:
    .stringn "본체  설정"
    .byte 0x00
P5_Messages_Korean_Msg052:
    .stringn "DS 다운로드 플레이"
    .byte 0x00
P5_Messages_Korean_Msg053:
    .stringn "아니오"
    .byte 0x00
P5_Messages_Korean_Msg054:
    .stringn "예"
    .byte 0x00
P5_Messages_Korean_Msg055:
    .stringn "「알람」을  해제했습니다."
    .byte 0x00
P5_Messages_Korean_Msg056:
    .stringn "「알람」을  해제하겠습니까？"
    .byte 0x00
P5_Messages_Korean_Msg057:
    .stringn "●●:●●  으로"
    .byte 0x0A ; line break / 换行
    .stringn "알람을  설정하겠습니까？"
    .byte 0x00
P5_Messages_Korean_Msg058:
    .stringn "진동  기능을  사용하겠습니까？"
    .byte 0x00
P5_Messages_Korean_Msg059:
    .stringn "통신  에러가  발생했습니다."
    .byte 0x0A ; line break / 换行
    .stringn "채팅방  선택으로  되돌아갑니다."
    .byte 0x00
P5_Messages_Korean_Msg060:
    .stringn "정원  초과입니다."
    .byte 0x0A ; line break / 换行
    .stringn "채팅방  ⊿에  들어가지  못  했습니다."
    .byte 0x00
P5_Messages_Korean_Msg061:
    .stringn "통신  에러가  발생했습니다."
    .byte 0x0A ; line break / 换行
    .stringn "전원을  꺼  주세요."
    .byte 0x00
P5_Messages_Korean_Msg062:
    .stringn "다운로드하고  있습니다."
    .byte 0x00
P5_Messages_Korean_Msg063:
    .stringn "다운로드를  취소했습니다."
    .byte 0x00
P5_Messages_Korean_Msg064:
    .stringn "정원  초과입니다."
    .byte 0x0A ; line break / 换行
    .stringn "다운로드에  실패했습니다."
    .byte 0x00
P5_Messages_Korean_Msg065:
    .stringn "다운로드가  완료되었습니다."
    .byte 0x00
P5_Messages_Korean_Msg066:
    .stringn "우선  본체  설정을  합시다."
    .byte 0x0A ; line break / 换行
    .stringn "화면을  터치하거나"
    .byte 0x0A ; line break / 换行
    .stringn "아무  버튼이나  눌러  주세요."
    .byte 0x00
P5_Messages_Korean_Msg067:
    .stringn "본체  설정을  확인해  주세요."
    .byte 0x0A ; line break / 换行
    .stringn "화면을  터치하거나"
    .byte 0x0A ; line break / 换行
    .stringn "아무  버튼이나  눌러  주세요."
    .byte 0x00
P5_Messages_Korean_Msg068:
    .stringn "「한국어」로  설정하겠습니까？"
    .byte 0x00
P5_Messages_Korean_Msg069:
    .stringn "이  소프트를  다운로드하겠습니까？"
    .byte 0x00
P5_Messages_Korean_Msg070:
    .stringn "DS  무선  통신을  시작하겠습니까？"
    .byte 0x00
P5_Messages_Korean_Msg071:
    .stringn "통신  에러가  발생했습니다."
    .byte 0x0A ; line break / 换行
    .stringn "다운로드에  실패했습니다."
    .byte 0x00
P5_Messages_Korean_Msg072:
    .stringn "전원을  끄고  종료합니다."
    .byte 0x00
P5_Messages_Korean_Msg073:
    .stringn "입력이  종료되었습니다."
    .byte 0x0A ; line break / 换行
    .stringn "설정을  저장하고  전원을  끕니다."
    .byte 0x00
P5_Messages_Korean_Msg074:
    .stringn "다운로드  가능한"
    .byte 0x0A ; line break / 换行
    .stringn "소프트를  찾고  있습니다."
    .byte 0x00
P5_Messages_Korean_Msg075:
    .stringn "「알람」을  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg076:
    .stringn "「오토  모드」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg077:
    .stringn "「생일」을  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg078:
    .stringn "「아래  화면」으로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg079:
    .stringn "「유저  컬러」를  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg080:
    .stringn "「코멘트」를  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg081:
    .stringn "「날짜」를  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg082:
    .stringn "「영어」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg083:
    .stringn "「프랑스어」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg084:
    .stringn "「독일어」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg085:
    .stringn "「한국어」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg086:
    .stringn "「일본어」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg087:
    .stringn "「매뉴얼  모드」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg088:
    .stringn "「유저  네임」을  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg089:
    .stringn "「터치스크린」을  수정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg090:
    .stringn "「스페인어」로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg091:
    .stringn "「시각」을  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg092:
    .stringn "「위  화면」으로  설정했습니다."
    .byte 0x00
P5_Messages_Korean_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Korean_Msg094:
    .stringn "「알람」이  설정되어  있습니다."
    .byte 0x0A ; line break / 换行
    .stringn "해제하려면  화면을  터치하거나"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "  이외의  버튼을  눌러  주세요."
    .byte 0x0A ; line break / 换行
    .stringn "（필요에  따라  볼륨을  조정해  주세요.）"
    .byte 0x00
P5_Messages_Korean_Msg095:
    .stringn "설정한  시각이  되었습니다."
    .byte 0x0A ; line break / 换行
    .stringn "해제하려면  화면을  터치하거나"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "  이외의  버튼을  눌러  주세요."
    .byte 0x00
P5_Messages_Korean_Msg096:
    .stringn "설정한  시각으로부터  ●●:●●  지났습니다."
    .byte 0x0A ; line break / 换行
    .stringn "해제하려면  화면을  터치하거나"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "  이외의  버튼을  눌러  주세요."
    .byte 0x00
P5_Messages_Korean_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_Korean_Msg098:
    .stringn "시"
    .byte 0x00
P5_Messages_Korean_Msg099:
    .stringn "분"
    .byte 0x00
P5_Messages_Korean_Msg100:
    .stringn "아래  화면"
    .byte 0x00
P5_Messages_Korean_Msg101:
    .stringn "위  화면"
    .byte 0x00
P5_Messages_Korean_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_Korean_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_Korean_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_Korean_Msg105:
    .stringn "한국어"
    .byte 0x00
P5_Messages_Korean_Msg106:
    .stringn "日本語"
    .byte 0x00
P5_Messages_Korean_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_Korean_Msg108:
    .ascii "0:00"
    .byte 0x00
P5_Messages_Korean_Msg109:
    .ascii "MM/DD"
    .byte 0x00
P5_Messages_Korean_Msg110:
    .stringn "금"
    .byte 0x00
P5_Messages_Korean_Msg111:
    .stringn "다운로드할  소프트를  선택합니다."
    .byte 0x00
P5_Messages_Korean_Msg112:
    .stringn "옵션을  설정합니다."
    .byte 0x00
P5_Messages_Korean_Msg113:
    .stringn "전원을  넣었을  때의"
    .byte 0x0A ; line break / 换行
    .stringn "실행  방법을  선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg114:
    .stringn "GBA  소프트를  플레이할  화면을"
    .byte 0x0A ; line break / 换行
    .stringn "선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg115:
    .stringn "사용할  언어를  선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg116:
    .stringn "유저  정보를  등록합니다."
    .byte 0x00
P5_Messages_Korean_Msg117:
    .stringn "닉네임  등을  입력해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg118:
    .stringn "좋아하는  색을  선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg119:
    .stringn "생일을  입력해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg120:
    .stringn "코멘트를  입력해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg121:
    .stringn "터치  위치의  오차를  수정합니다."
    .byte 0x0A ; line break / 换行
    .stringn "터치펜으로  "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "을  터치해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg122:
    .stringn "본체  설정을  합니다.  설정하고  싶은"
    .byte 0x0A ; line break / 换行
    .stringn "패널을  선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg123:
    .stringn "날짜・시각・알람을  설정합니다."
    .byte 0x00
P5_Messages_Korean_Msg124:
    .stringn "오늘  날짜로  맞추어  주세요."
    .byte 0x00
P5_Messages_Korean_Msg125:
    .stringn "현재  시각으로  맞추어  주세요."
    .byte 0x00
P5_Messages_Korean_Msg126:
    .stringn "알람  아이콘（"
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .stringn "）을  터치하면"
    .byte 0x0A ; line break / 换行
    .stringn "설정한  시각에  알람이  울립니다."
    .byte 0x00
P5_Messages_Korean_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Korean_Msg128:
    .stringn "월"
    .byte 0x00
P5_Messages_Korean_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_Korean_Msg130:
    .stringn "토"
    .byte 0x00
P5_Messages_Korean_Msg131:
    .stringn "일"
    .byte 0x00
P5_Messages_Korean_Msg132:
    .stringn "목"
    .byte 0x00
P5_Messages_Korean_Msg133:
    .stringn "DS  다운로드  플레이"
    .byte 0x00
P5_Messages_Korean_Msg134:
    .stringn "옵션"
    .byte 0x00
P5_Messages_Korean_Msg135:
    .stringn "실행  모드"
    .byte 0x00
P5_Messages_Korean_Msg136:
    .stringn "GBA  표시"
    .byte 0x00
P5_Messages_Korean_Msg137:
    .stringn "언어"
    .byte 0x00
P5_Messages_Korean_Msg138:
    .stringn "유저"
    .byte 0x00
P5_Messages_Korean_Msg139:
    .stringn "유저  네임"
    .byte 0x00
P5_Messages_Korean_Msg140:
    .stringn "유저  컬러"
    .byte 0x00
P5_Messages_Korean_Msg141:
    .stringn "생일"
    .byte 0x00
P5_Messages_Korean_Msg142:
    .stringn "코멘트"
    .byte 0x00
P5_Messages_Korean_Msg143:
    .stringn "터치스크린"
    .byte 0x00
P5_Messages_Korean_Msg144:
    .stringn "본체  설정"
    .byte 0x00
P5_Messages_Korean_Msg145:
    .stringn "날짜＆시각"
    .byte 0x00
P5_Messages_Korean_Msg146:
    .stringn "날짜"
    .byte 0x00
P5_Messages_Korean_Msg147:
    .stringn "시각"
    .byte 0x00
P5_Messages_Korean_Msg148:
    .stringn "알람"
    .byte 0x00
P5_Messages_Korean_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_Korean_Msg150:
    .stringn "화"
    .byte 0x00
P5_Messages_Korean_Msg151:
    .stringn "수"
    .byte 0x00
P5_Messages_Korean_Msg152:
    .ascii "YYYY/MM"
    .byte 0x00
P5_Messages_Korean_Msg153:
    .ascii "YYYY/MM/DD"
    .byte 0x00
P5_Messages_Korean_Msg154:
    .stringn "현재  시각"
    .byte 0x00
P5_Messages_Korean_Msg155:
    .ascii "0:00:00"
    .byte 0x00
P5_Messages_Korean_Msg156:
    .stringn "남은  시간"
    .byte 0x00
P5_Messages_Korean_Msg157:
    .stringn "경과  시간"
    .byte 0x00
P5_Messages_Korean_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_Korean_Msg159:
    .stringn "설정  시각"
    .byte 0x00
P5_Messages_Korean_Msg160:
    .stringn "취소"
    .byte 0x00
P5_Messages_Korean_Msg161:
    .stringn "결정"
    .byte 0x00
P5_Messages_Korean_Msg162:
    .stringn "사용할  언어를  선택해  주세요."
    .byte 0x00
P5_Messages_Korean_Msg163:
    .stringn "설정이 지워졌을 가능성이 있습니다.  "
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "을 터치해 주세요."
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
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
.loadtable "../../include/utf16le.tbl","utf-8"
