; BMG resource; included by p5.s at P5_Messages_Japanese.
; BMG 资源，由 p5.s 在 P5_Messages_Japanese 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_Japanese_End - P5_Messages_Japanese
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_ja.bmg", 0x11, 0x3 ; original format bytes / 原始格式字节
    .incbin "src/text/messages_ja.bmg", 0x14, 0xC ; original format bytes / 原始格式字节
P5_Messages_Japanese_Info:
    .ascii "INF1"
    .word P5_Messages_Japanese_Data - P5_Messages_Japanese_Info
    .dh (P5_Messages_Japanese_EntriesEnd - P5_Messages_Japanese_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_Japanese_Entries:
    .word P5_Messages_Japanese_Msg000 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg001 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg002 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg003 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg004 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg005 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg006 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg007 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg008 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg009 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg010 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg011 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg012 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg013 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg014 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg015 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg016 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg017 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg018 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg019 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg020 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg021 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg022 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg023 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg024 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg025 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg026 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg027 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg028 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg029 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg030 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg031 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg032 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg033 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg034 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg035 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg036 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg037 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg038 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg039 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg040 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg041 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg042 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg043 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg044 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg045 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg046 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg047 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg048 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg049 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg050 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg051 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg052 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg053 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg054 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg055 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg056 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg057 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg058 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg059 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg060 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg061 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg062 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg063 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg064 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg065 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg066 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg067 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg068 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg069 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg070 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg071 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg072 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg073 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg074 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg075 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg076 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg077 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg078 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg079 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg080 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg081 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg082 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg083 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg084 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg085 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg086 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg087 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg088 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg089 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg090 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg091 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg092 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg093 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg094 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg095 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg096 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg097 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg098 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg099 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg100 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg101 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg102 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg103 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg104 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg105 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg106 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg107 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg108 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg109 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg110 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg111 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg112 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg113 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg114 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg115 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg116 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg117 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg118 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg119 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg120 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg121 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg122 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg123 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg124 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg125 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg126 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg127 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg128 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg129 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg130 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg131 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg132 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg133 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg134 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg135 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg136 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg137 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg138 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg139 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg140 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg141 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg142 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg143 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg144 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg145 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg146 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg147 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg148 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg149 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg150 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg151 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg152 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg153 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg154 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg155 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg156 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg157 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg158 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg159 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg160 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg161 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg162 - P5_Messages_Japanese_Text
    .word P5_Messages_Japanese_Msg163 - P5_Messages_Japanese_Text
P5_Messages_Japanese_EntriesEnd:
P5_Messages_Japanese_Data:
    .ascii "DAT1"
    .word P5_Messages_Japanese_End - P5_Messages_Japanese_Data
P5_Messages_Japanese_Text:
    .byte 0x00
P5_Messages_Japanese_Msg000:
    .stringn "補正しました。"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "をタッチして確認して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg001:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn "ボタンで補正をキャンセルできます。"
    .byte 0x00
P5_Messages_Japanese_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .stringn " もう一度"
    .byte 0x00
P5_Messages_Japanese_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " とじる"
    .byte 0x00
P5_Messages_Japanese_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " はい"
    .byte 0x00
P5_Messages_Japanese_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " いいえ"
    .byte 0x00
P5_Messages_Japanese_Msg006:
    .stringn "誕生日おめでとう！"
    .byte 0x0A ; line break / 换行
    .stringn "今日は∩さんの誕生日です。"
    .byte 0x00
P5_Messages_Japanese_Msg007:
    .stringn "∩さんが"
    .byte 0x0A ; line break / 换行
    .stringn "ルーム⊿へ移動しました。"
    .byte 0x00
P5_Messages_Japanese_Msg008:
    .stringn "参加 "
    .byte 0xEE, 0x80, 0x99 ; U+E019 glyph / 字形
    .stringn "⊿  ∩ さん"
    .byte 0x00
P5_Messages_Japanese_Msg009:
    .stringn "退室 "
    .byte 0xEE, 0x80, 0x9A ; U+E01A glyph / 字形
    .stringn "⊿  ∩ さん"
    .byte 0x00
P5_Messages_Japanese_Msg010:
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
P5_Messages_Japanese_Msg011:
    .stringn "チャットル-ムA"
    .byte 0x00
P5_Messages_Japanese_Msg012:
    .stringn "チャットル-ムB"
    .byte 0x00
P5_Messages_Japanese_Msg013:
    .stringn "チャットル-ムC"
    .byte 0x00
P5_Messages_Japanese_Msg014:
    .stringn "チャットル-ムD"
    .byte 0x00
P5_Messages_Japanese_Msg015:
    .stringn "参加したいルームを選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg016:
    .stringn "せんたくカラ-"
    .byte 0x00
P5_Messages_Japanese_Msg017:
    .stringn "キャンセル"
    .byte 0x00
P5_Messages_Japanese_Msg018:
    .stringn "決定"
    .byte 0x00
P5_Messages_Japanese_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .stringn " アラームをセット"
    .byte 0x00
P5_Messages_Japanese_Msg020:
    .stringn "時"
    .byte 0x00
P5_Messages_Japanese_Msg021:
    .stringn "分"
    .byte 0x00
P5_Messages_Japanese_Msg022:
    .stringn "日"
    .byte 0x00
P5_Messages_Japanese_Msg023:
    .stringn "月"
    .byte 0x00
P5_Messages_Japanese_Msg024:
    .stringn "電源を入れた後"
    .byte 0x0A ; line break / 换行
    .stringn "DSメニューで何をするか"
    .byte 0x0A ; line break / 换行
    .stringn "選択できます。"
    .byte 0x00
P5_Messages_Japanese_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .stringn " オートモード"
    .byte 0x00
P5_Messages_Japanese_Msg026:
    .stringn "電源を入れた後"
    .byte 0x0A ; line break / 换行
    .stringn "じょうきょうに応じて"
    .byte 0x0A ; line break / 换行
    .stringn "自動でソフトが起動します。"
    .byte 0x00
P5_Messages_Japanese_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .stringn " マニュアルモード"
    .byte 0x00
P5_Messages_Japanese_Msg028:
    .stringn "日"
    .byte 0x00
P5_Messages_Japanese_Msg029:
    .stringn "月"
    .byte 0x00
P5_Messages_Japanese_Msg030:
    .stringn "年"
    .byte 0x00
P5_Messages_Japanese_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 決定"
    .byte 0x00
P5_Messages_Japanese_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 入力"
    .byte 0x00
P5_Messages_Japanese_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 参加"
    .byte 0x00
P5_Messages_Japanese_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_Japanese_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " 選択"
    .byte 0x00
P5_Messages_Japanese_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_Japanese_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " はい"
    .byte 0x00
P5_Messages_Japanese_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " もどる"
    .byte 0x00
P5_Messages_Japanese_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " キャンセル"
    .byte 0x00
P5_Messages_Japanese_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 消去"
    .byte 0x00
P5_Messages_Japanese_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " いいえ"
    .byte 0x00
P5_Messages_Japanese_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .stringn " 終了"
    .byte 0x00
P5_Messages_Japanese_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_Japanese_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_Japanese_Msg045:
    .stringn "何も差さっていません"
    .byte 0x00
P5_Messages_Japanese_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_Japanese_Msg047:
    .stringn "GBAカートリッジ"
    .byte 0x00
P5_Messages_Japanese_Msg048:
    .stringn "何も差さっていません"
    .byte 0x00
P5_Messages_Japanese_Msg049:
    .stringn "DSオプションカートリッジ"
    .byte 0x00
P5_Messages_Japanese_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_Japanese_Msg051:
    .stringn "本体設定"
    .byte 0x00
P5_Messages_Japanese_Msg052:
    .stringn "DSダウンロードプレイ"
    .byte 0x00
P5_Messages_Japanese_Msg053:
    .stringn "いいえ"
    .byte 0x00
P5_Messages_Japanese_Msg054:
    .stringn "はい"
    .byte 0x00
P5_Messages_Japanese_Msg055:
    .stringn "「アラーム」を解除しました。"
    .byte 0x00
P5_Messages_Japanese_Msg056:
    .stringn "「アラーム」を解除しますか？"
    .byte 0x00
P5_Messages_Japanese_Msg057:
    .stringn "●●:●●に「アラーム」をセットします。"
    .byte 0x0A ; line break / 换行
    .stringn "よろしいですか？"
    .byte 0x00
P5_Messages_Japanese_Msg058:
    .stringn "振動機能を使いますか？"
    .byte 0x00
P5_Messages_Japanese_Msg059:
    .stringn "通信エラーが発生しました。"
    .byte 0x0A ; line break / 换行
    .stringn "ルーム選択へもどります。"
    .byte 0x00
P5_Messages_Japanese_Msg060:
    .stringn "定員オーバーです。"
    .byte 0x0A ; line break / 换行
    .stringn "ルーム⊿に入れませんでした。"
    .byte 0x00
P5_Messages_Japanese_Msg061:
    .stringn "通信エラーが発生しました。"
    .byte 0x0A ; line break / 换行
    .stringn "一度電源を切って下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg062:
    .stringn "ダウンロードしています。"
    .byte 0x00
P5_Messages_Japanese_Msg063:
    .stringn "ダウンロードをキャンセルしました。"
    .byte 0x00
P5_Messages_Japanese_Msg064:
    .stringn "定員オーバーです。"
    .byte 0x0A ; line break / 换行
    .stringn "ダウンロードできませんでした。"
    .byte 0x00
P5_Messages_Japanese_Msg065:
    .stringn "ダウンロードが完了しました。"
    .byte 0x00
P5_Messages_Japanese_Msg066:
    .stringn "初めに本体の設定をしましょう。"
    .byte 0x0A ; line break / 换行
    .stringn "画面をタッチするか"
    .byte 0x0A ; line break / 换行
    .stringn "何かボタンを押して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg067:
    .stringn "本体の設定を確認して下さい。"
    .byte 0x0A ; line break / 换行
    .stringn "画面をタッチするか"
    .byte 0x0A ; line break / 换行
    .stringn "何かボタンを押して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg068:
    .stringn "「日本語」に設定します。"
    .byte 0x0A ; line break / 换行
    .stringn "よろしいですか？"
    .byte 0x00
P5_Messages_Japanese_Msg069:
    .stringn "このソフトをダウンロードしますか？"
    .byte 0x00
P5_Messages_Japanese_Msg070:
    .stringn "DSワイヤレス通信を開始します。"
    .byte 0x0A ; line break / 换行
    .stringn "よろしいですか？"
    .byte 0x00
P5_Messages_Japanese_Msg071:
    .stringn "通信エラーが発生しました。"
    .byte 0x0A ; line break / 换行
    .stringn "ダウンロードできませんでした。"
    .byte 0x00
P5_Messages_Japanese_Msg072:
    .stringn "電源を切って終了します。"
    .byte 0x00
P5_Messages_Japanese_Msg073:
    .stringn "入力が終了しました。"
    .byte 0x0A ; line break / 换行
    .stringn "設定を保存して電源を切ります。"
    .byte 0x00
P5_Messages_Japanese_Msg074:
    .stringn "ダウンロードできる"
    .byte 0x0A ; line break / 换行
    .stringn "ソフトを探しています。"
    .byte 0x00
P5_Messages_Japanese_Msg075:
    .stringn "「アラーム」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg076:
    .stringn "「オートモード」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg077:
    .stringn "「誕生日」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg078:
    .stringn "「下画面」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg079:
    .stringn "「ユーザーカラー」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg080:
    .stringn "「コメント」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg081:
    .stringn "「日付」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg082:
    .stringn "「えいご」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg083:
    .stringn "「フランスご」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg084:
    .stringn "「ドイツご」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg085:
    .stringn "「イタリアご」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg086:
    .stringn "「日本語」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg087:
    .stringn "「マニュアルモード」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg088:
    .stringn "「ユーザーネーム」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg089:
    .stringn "「タッチスクリーン」を補正しました。"
    .byte 0x00
P5_Messages_Japanese_Msg090:
    .stringn "「スペインご」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg091:
    .stringn "「時刻」を設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg092:
    .stringn "「上画面」に設定しました。"
    .byte 0x00
P5_Messages_Japanese_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Japanese_Msg094:
    .stringn "「アラーム」がセットされています。"
    .byte 0x0A ; line break / 换行
    .stringn "解除するには、画面をタッチするか"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "以外のボタンを押して下さい。"
    .byte 0x0A ; line break / 换行
    .stringn "（必要に応じて、ボリュームを調整して下さい。）"
    .byte 0x00
P5_Messages_Japanese_Msg095:
    .stringn "セットした時刻になりました。"
    .byte 0x0A ; line break / 换行
    .stringn "解除するには、画面をタッチするか"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "以外のボタンを押して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg096:
    .stringn "セットした時刻から●●:●●たちました。"
    .byte 0x0A ; line break / 换行
    .stringn "解除するには、画面をタッチするか"
    .byte 0x0A ; line break / 换行
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn "以外のボタンを押して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_Japanese_Msg098:
    .stringn "時"
    .byte 0x00
P5_Messages_Japanese_Msg099:
    .stringn "分"
    .byte 0x00
P5_Messages_Japanese_Msg100:
    .stringn "下画面"
    .byte 0x00
P5_Messages_Japanese_Msg101:
    .stringn "上画面"
    .byte 0x00
P5_Messages_Japanese_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_Japanese_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_Japanese_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_Japanese_Msg105:
    .stringn "한국어"
    .byte 0x00
P5_Messages_Japanese_Msg106:
    .stringn "日本語"
    .byte 0x00
P5_Messages_Japanese_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_Japanese_Msg108:
    .ascii "00:00"
    .byte 0x00
P5_Messages_Japanese_Msg109:
    .ascii "MM/DD"
    .byte 0x00
P5_Messages_Japanese_Msg110:
    .stringn "金"
    .byte 0x00
P5_Messages_Japanese_Msg111:
    .stringn "ダウンロードするソフトを選択します。"
    .byte 0x00
P5_Messages_Japanese_Msg112:
    .stringn "オプションを設定します。"
    .byte 0x00
P5_Messages_Japanese_Msg113:
    .stringn "電源を入れた時の"
    .byte 0x0A ; line break / 换行
    .stringn "起動方法を選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg114:
    .stringn "GBAソフトをプレイする画面を"
    .byte 0x0A ; line break / 换行
    .stringn "選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg115:
    .stringn "使用する言語を選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg116:
    .stringn "ユーザー情報を登録します。"
    .byte 0x00
P5_Messages_Japanese_Msg117:
    .stringn "ニックネームなどを入力して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg118:
    .stringn "好きな色を選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg119:
    .stringn "誕生日を入力して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg120:
    .stringn "コメントを入力して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg121:
    .stringn "タッチ位置のずれを補正します。"
    .byte 0x0A ; line break / 换行
    .stringn "タッチペンで"
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "をタッチして下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg122:
    .stringn "本体の設定をします。"
    .byte 0x0A ; line break / 换行
    .stringn "設定したいパネルを選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg123:
    .stringn "日付・時刻・アラームを設定します。"
    .byte 0x00
P5_Messages_Japanese_Msg124:
    .stringn "今日の日付に合わせて下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg125:
    .stringn "現在の時刻に合わせて下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg126:
    .stringn "アラームアイコン（"
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .stringn "）をタッチすると"
    .byte 0x0A ; line break / 换行
    .stringn "設定した時刻にアラームが鳴ります。"
    .byte 0x00
P5_Messages_Japanese_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Japanese_Msg128:
    .stringn "月"
    .byte 0x00
P5_Messages_Japanese_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_Japanese_Msg130:
    .stringn "土"
    .byte 0x00
P5_Messages_Japanese_Msg131:
    .stringn "日"
    .byte 0x00
P5_Messages_Japanese_Msg132:
    .stringn "木"
    .byte 0x00
P5_Messages_Japanese_Msg133:
    .stringn "DSダウンロードプレイ"
    .byte 0x00
P5_Messages_Japanese_Msg134:
    .stringn "オプション"
    .byte 0x00
P5_Messages_Japanese_Msg135:
    .stringn "起動モード"
    .byte 0x00
P5_Messages_Japanese_Msg136:
    .stringn "GBA表示"
    .byte 0x00
P5_Messages_Japanese_Msg137:
    .stringn "言語"
    .byte 0x00
P5_Messages_Japanese_Msg138:
    .stringn "ユーザー"
    .byte 0x00
P5_Messages_Japanese_Msg139:
    .stringn "ユーザーネーム"
    .byte 0x00
P5_Messages_Japanese_Msg140:
    .stringn "ユーザーカラー"
    .byte 0x00
P5_Messages_Japanese_Msg141:
    .stringn "誕生日"
    .byte 0x00
P5_Messages_Japanese_Msg142:
    .stringn "コメント"
    .byte 0x00
P5_Messages_Japanese_Msg143:
    .stringn "タッチスクリーン"
    .byte 0x00
P5_Messages_Japanese_Msg144:
    .stringn "本体設定"
    .byte 0x00
P5_Messages_Japanese_Msg145:
    .stringn "日付＆時刻"
    .byte 0x00
P5_Messages_Japanese_Msg146:
    .stringn "日付"
    .byte 0x00
P5_Messages_Japanese_Msg147:
    .stringn "時刻"
    .byte 0x00
P5_Messages_Japanese_Msg148:
    .stringn "アラーム"
    .byte 0x00
P5_Messages_Japanese_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_Japanese_Msg150:
    .stringn "火"
    .byte 0x00
P5_Messages_Japanese_Msg151:
    .stringn "水"
    .byte 0x00
P5_Messages_Japanese_Msg152:
    .ascii "YYYY/MM"
    .byte 0x00
P5_Messages_Japanese_Msg153:
    .ascii "YYYY/MM/DD"
    .byte 0x00
P5_Messages_Japanese_Msg154:
    .stringn "現在時刻"
    .byte 0x00
P5_Messages_Japanese_Msg155:
    .ascii "00:00:00"
    .byte 0x00
P5_Messages_Japanese_Msg156:
    .stringn "残り時間"
    .byte 0x00
P5_Messages_Japanese_Msg157:
    .stringn "経過時間"
    .byte 0x00
P5_Messages_Japanese_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_Japanese_Msg159:
    .stringn "設定時刻"
    .byte 0x00
P5_Messages_Japanese_Msg160:
    .stringn "キャンセル"
    .byte 0x00
P5_Messages_Japanese_Msg161:
    .stringn "決定"
    .byte 0x00
P5_Messages_Japanese_Msg162:
    .stringn "使用する言語を選択して下さい。"
    .byte 0x00
P5_Messages_Japanese_Msg163:
    .stringn "設定が消えた可能性があります。"
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn "をタッチして下さい。"
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
