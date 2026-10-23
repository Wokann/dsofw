; BMG resource; included by p5.s at P5_Messages_French.
; BMG 资源，由 p5.s 在 P5_Messages_French 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_French_End - P5_Messages_French
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_fr.bmg", 0x11, 0xF ; original format bytes / 原始格式字节
P5_Messages_French_Info:
    .ascii "INF1"
    .word P5_Messages_French_Data - P5_Messages_French_Info
    .dh (P5_Messages_French_EntriesEnd - P5_Messages_French_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_French_Entries:
    .word P5_Messages_French_Msg000 - P5_Messages_French_Text
    .word P5_Messages_French_Msg001 - P5_Messages_French_Text
    .word P5_Messages_French_Msg002 - P5_Messages_French_Text
    .word P5_Messages_French_Msg003 - P5_Messages_French_Text
    .word P5_Messages_French_Msg004 - P5_Messages_French_Text
    .word P5_Messages_French_Msg005 - P5_Messages_French_Text
    .word P5_Messages_French_Msg006 - P5_Messages_French_Text
    .word P5_Messages_French_Msg007 - P5_Messages_French_Text
    .word P5_Messages_French_Msg008 - P5_Messages_French_Text
    .word P5_Messages_French_Msg009 - P5_Messages_French_Text
    .word P5_Messages_French_Msg010 - P5_Messages_French_Text
    .word P5_Messages_French_Msg011 - P5_Messages_French_Text
    .word P5_Messages_French_Msg012 - P5_Messages_French_Text
    .word P5_Messages_French_Msg013 - P5_Messages_French_Text
    .word P5_Messages_French_Msg014 - P5_Messages_French_Text
    .word P5_Messages_French_Msg015 - P5_Messages_French_Text
    .word P5_Messages_French_Msg016 - P5_Messages_French_Text
    .word P5_Messages_French_Msg017 - P5_Messages_French_Text
    .word P5_Messages_French_Msg018 - P5_Messages_French_Text
    .word P5_Messages_French_Msg019 - P5_Messages_French_Text
    .word P5_Messages_French_Msg020 - P5_Messages_French_Text
    .word P5_Messages_French_Msg021 - P5_Messages_French_Text
    .word P5_Messages_French_Msg022 - P5_Messages_French_Text
    .word P5_Messages_French_Msg023 - P5_Messages_French_Text
    .word P5_Messages_French_Msg024 - P5_Messages_French_Text
    .word P5_Messages_French_Msg025 - P5_Messages_French_Text
    .word P5_Messages_French_Msg026 - P5_Messages_French_Text
    .word P5_Messages_French_Msg027 - P5_Messages_French_Text
    .word P5_Messages_French_Msg028 - P5_Messages_French_Text
    .word P5_Messages_French_Msg029 - P5_Messages_French_Text
    .word P5_Messages_French_Msg030 - P5_Messages_French_Text
    .word P5_Messages_French_Msg031 - P5_Messages_French_Text
    .word P5_Messages_French_Msg032 - P5_Messages_French_Text
    .word P5_Messages_French_Msg033 - P5_Messages_French_Text
    .word P5_Messages_French_Msg034 - P5_Messages_French_Text
    .word P5_Messages_French_Msg035 - P5_Messages_French_Text
    .word P5_Messages_French_Msg036 - P5_Messages_French_Text
    .word P5_Messages_French_Msg037 - P5_Messages_French_Text
    .word P5_Messages_French_Msg038 - P5_Messages_French_Text
    .word P5_Messages_French_Msg039 - P5_Messages_French_Text
    .word P5_Messages_French_Msg040 - P5_Messages_French_Text
    .word P5_Messages_French_Msg041 - P5_Messages_French_Text
    .word P5_Messages_French_Msg042 - P5_Messages_French_Text
    .word P5_Messages_French_Msg043 - P5_Messages_French_Text
    .word P5_Messages_French_Msg044 - P5_Messages_French_Text
    .word P5_Messages_French_Msg045 - P5_Messages_French_Text
    .word P5_Messages_French_Msg046 - P5_Messages_French_Text
    .word P5_Messages_French_Msg047 - P5_Messages_French_Text
    .word P5_Messages_French_Msg048 - P5_Messages_French_Text
    .word P5_Messages_French_Msg049 - P5_Messages_French_Text
    .word P5_Messages_French_Msg050 - P5_Messages_French_Text
    .word P5_Messages_French_Msg051 - P5_Messages_French_Text
    .word P5_Messages_French_Msg052 - P5_Messages_French_Text
    .word P5_Messages_French_Msg053 - P5_Messages_French_Text
    .word P5_Messages_French_Msg054 - P5_Messages_French_Text
    .word P5_Messages_French_Msg055 - P5_Messages_French_Text
    .word P5_Messages_French_Msg056 - P5_Messages_French_Text
    .word P5_Messages_French_Msg057 - P5_Messages_French_Text
    .word P5_Messages_French_Msg058 - P5_Messages_French_Text
    .word P5_Messages_French_Msg059 - P5_Messages_French_Text
    .word P5_Messages_French_Msg060 - P5_Messages_French_Text
    .word P5_Messages_French_Msg061 - P5_Messages_French_Text
    .word P5_Messages_French_Msg062 - P5_Messages_French_Text
    .word P5_Messages_French_Msg063 - P5_Messages_French_Text
    .word P5_Messages_French_Msg064 - P5_Messages_French_Text
    .word P5_Messages_French_Msg065 - P5_Messages_French_Text
    .word P5_Messages_French_Msg066 - P5_Messages_French_Text
    .word P5_Messages_French_Msg067 - P5_Messages_French_Text
    .word P5_Messages_French_Msg068 - P5_Messages_French_Text
    .word P5_Messages_French_Msg069 - P5_Messages_French_Text
    .word P5_Messages_French_Msg070 - P5_Messages_French_Text
    .word P5_Messages_French_Msg071 - P5_Messages_French_Text
    .word P5_Messages_French_Msg072 - P5_Messages_French_Text
    .word P5_Messages_French_Msg073 - P5_Messages_French_Text
    .word P5_Messages_French_Msg074 - P5_Messages_French_Text
    .word P5_Messages_French_Msg075 - P5_Messages_French_Text
    .word P5_Messages_French_Msg076 - P5_Messages_French_Text
    .word P5_Messages_French_Msg077 - P5_Messages_French_Text
    .word P5_Messages_French_Msg078 - P5_Messages_French_Text
    .word P5_Messages_French_Msg079 - P5_Messages_French_Text
    .word P5_Messages_French_Msg080 - P5_Messages_French_Text
    .word P5_Messages_French_Msg081 - P5_Messages_French_Text
    .word P5_Messages_French_Msg082 - P5_Messages_French_Text
    .word P5_Messages_French_Msg083 - P5_Messages_French_Text
    .word P5_Messages_French_Msg084 - P5_Messages_French_Text
    .word P5_Messages_French_Msg085 - P5_Messages_French_Text
    .word P5_Messages_French_Msg086 - P5_Messages_French_Text
    .word P5_Messages_French_Msg087 - P5_Messages_French_Text
    .word P5_Messages_French_Msg088 - P5_Messages_French_Text
    .word P5_Messages_French_Msg089 - P5_Messages_French_Text
    .word P5_Messages_French_Msg090 - P5_Messages_French_Text
    .word P5_Messages_French_Msg091 - P5_Messages_French_Text
    .word P5_Messages_French_Msg092 - P5_Messages_French_Text
    .word P5_Messages_French_Msg093 - P5_Messages_French_Text
    .word P5_Messages_French_Msg094 - P5_Messages_French_Text
    .word P5_Messages_French_Msg095 - P5_Messages_French_Text
    .word P5_Messages_French_Msg096 - P5_Messages_French_Text
    .word P5_Messages_French_Msg097 - P5_Messages_French_Text
    .word P5_Messages_French_Msg098 - P5_Messages_French_Text
    .word P5_Messages_French_Msg099 - P5_Messages_French_Text
    .word P5_Messages_French_Msg100 - P5_Messages_French_Text
    .word P5_Messages_French_Msg101 - P5_Messages_French_Text
    .word P5_Messages_French_Msg102 - P5_Messages_French_Text
    .word P5_Messages_French_Msg103 - P5_Messages_French_Text
    .word P5_Messages_French_Msg104 - P5_Messages_French_Text
    .word P5_Messages_French_Msg105 - P5_Messages_French_Text
    .word P5_Messages_French_Msg106 - P5_Messages_French_Text
    .word P5_Messages_French_Msg107 - P5_Messages_French_Text
    .word P5_Messages_French_Msg108 - P5_Messages_French_Text
    .word P5_Messages_French_Msg109 - P5_Messages_French_Text
    .word P5_Messages_French_Msg110 - P5_Messages_French_Text
    .word P5_Messages_French_Msg111 - P5_Messages_French_Text
    .word P5_Messages_French_Msg112 - P5_Messages_French_Text
    .word P5_Messages_French_Msg113 - P5_Messages_French_Text
    .word P5_Messages_French_Msg114 - P5_Messages_French_Text
    .word P5_Messages_French_Msg115 - P5_Messages_French_Text
    .word P5_Messages_French_Msg116 - P5_Messages_French_Text
    .word P5_Messages_French_Msg117 - P5_Messages_French_Text
    .word P5_Messages_French_Msg118 - P5_Messages_French_Text
    .word P5_Messages_French_Msg119 - P5_Messages_French_Text
    .word P5_Messages_French_Msg120 - P5_Messages_French_Text
    .word P5_Messages_French_Msg121 - P5_Messages_French_Text
    .word P5_Messages_French_Msg122 - P5_Messages_French_Text
    .word P5_Messages_French_Msg123 - P5_Messages_French_Text
    .word P5_Messages_French_Msg124 - P5_Messages_French_Text
    .word P5_Messages_French_Msg125 - P5_Messages_French_Text
    .word P5_Messages_French_Msg126 - P5_Messages_French_Text
    .word P5_Messages_French_Msg127 - P5_Messages_French_Text
    .word P5_Messages_French_Msg128 - P5_Messages_French_Text
    .word P5_Messages_French_Msg129 - P5_Messages_French_Text
    .word P5_Messages_French_Msg130 - P5_Messages_French_Text
    .word P5_Messages_French_Msg131 - P5_Messages_French_Text
    .word P5_Messages_French_Msg132 - P5_Messages_French_Text
    .word P5_Messages_French_Msg133 - P5_Messages_French_Text
    .word P5_Messages_French_Msg134 - P5_Messages_French_Text
    .word P5_Messages_French_Msg135 - P5_Messages_French_Text
    .word P5_Messages_French_Msg136 - P5_Messages_French_Text
    .word P5_Messages_French_Msg137 - P5_Messages_French_Text
    .word P5_Messages_French_Msg138 - P5_Messages_French_Text
    .word P5_Messages_French_Msg139 - P5_Messages_French_Text
    .word P5_Messages_French_Msg140 - P5_Messages_French_Text
    .word P5_Messages_French_Msg141 - P5_Messages_French_Text
    .word P5_Messages_French_Msg142 - P5_Messages_French_Text
    .word P5_Messages_French_Msg143 - P5_Messages_French_Text
    .word P5_Messages_French_Msg144 - P5_Messages_French_Text
    .word P5_Messages_French_Msg145 - P5_Messages_French_Text
    .word P5_Messages_French_Msg146 - P5_Messages_French_Text
    .word P5_Messages_French_Msg147 - P5_Messages_French_Text
    .word P5_Messages_French_Msg148 - P5_Messages_French_Text
    .word P5_Messages_French_Msg149 - P5_Messages_French_Text
    .word P5_Messages_French_Msg150 - P5_Messages_French_Text
    .word P5_Messages_French_Msg151 - P5_Messages_French_Text
    .word P5_Messages_French_Msg152 - P5_Messages_French_Text
    .word P5_Messages_French_Msg153 - P5_Messages_French_Text
    .word P5_Messages_French_Msg154 - P5_Messages_French_Text
    .word P5_Messages_French_Msg155 - P5_Messages_French_Text
    .word P5_Messages_French_Msg156 - P5_Messages_French_Text
    .word P5_Messages_French_Msg157 - P5_Messages_French_Text
    .word P5_Messages_French_Msg158 - P5_Messages_French_Text
    .word P5_Messages_French_Msg159 - P5_Messages_French_Text
    .word P5_Messages_French_Msg160 - P5_Messages_French_Text
    .word P5_Messages_French_Msg161 - P5_Messages_French_Text
    .word P5_Messages_French_Msg162 - P5_Messages_French_Text
    .word P5_Messages_French_Msg163 - P5_Messages_French_Text
P5_Messages_French_EntriesEnd:
P5_Messages_French_Data:
    .ascii "DAT1"
    .word P5_Messages_French_End - P5_Messages_French_Data
P5_Messages_French_Text:
    .byte 0x00
P5_Messages_French_Msg000:
    .stringn "Calibrage terminé. Touchez les"
    .byte 0x0A ; line break / 换行
    .ascii "marques "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " pour tester le calibrage."
    .byte 0x00
P5_Messages_French_Msg001:
    .ascii "Appuyez sur "
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " pour annuler."
    .byte 0x00
P5_Messages_French_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Nouvel essai"
    .byte 0x00
P5_Messages_French_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Fermer"
    .byte 0x00
P5_Messages_French_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Oui"
    .byte 0x00
P5_Messages_French_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Non"
    .byte 0x00
P5_Messages_French_Msg006:
    .ascii "Joyeux anniversaire!"
    .byte 0x0A ; line break / 换行
    .ascii "C'est aujourd'hui"
    .byte 0x0A ; line break / 换行
    .stringn "l'anniversaire de ∩!"
    .byte 0x00
P5_Messages_French_Msg007:
    .stringn "∩ se rend dans"
    .byte 0x0A ; line break / 换行
    .stringn "la salle de chat ⊿."
    .byte 0x00
P5_Messages_French_Msg008:
    .ascii "Entre "
    .byte 0xEE, 0x80, 0x99 ; U+E019 glyph / 字形
    .stringn "⊿ ∩"
    .byte 0x00
P5_Messages_French_Msg009:
    .ascii "Quitte "
    .byte 0xEE, 0x80, 0x9A ; U+E01A glyph / 字形
    .stringn "⊿ ∩"
    .byte 0x00
P5_Messages_French_Msg010:
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
P5_Messages_French_Msg011:
    .ascii "Salle de chat A"
    .byte 0x00
P5_Messages_French_Msg012:
    .ascii "Salle de chat B"
    .byte 0x00
P5_Messages_French_Msg013:
    .ascii "Salle de chat C"
    .byte 0x00
P5_Messages_French_Msg014:
    .ascii "Salle de chat D"
    .byte 0x00
P5_Messages_French_Msg015:
    .ascii "Veuillez choisir une salle de chat."
    .byte 0x00
P5_Messages_French_Msg016:
    .ascii "Couleur"
    .byte 0x00
P5_Messages_French_Msg017:
    .ascii "Annuler"
    .byte 0x00
P5_Messages_French_Msg018:
    .ascii "Confirmer"
    .byte 0x00
P5_Messages_French_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Activer l'alarme"
    .byte 0x00
P5_Messages_French_Msg020:
    .ascii "Heure"
    .byte 0x00
P5_Messages_French_Msg021:
    .ascii "Minute"
    .byte 0x00
P5_Messages_French_Msg022:
    .ascii "Jour"
    .byte 0x00
P5_Messages_French_Msg023:
    .ascii "Mois"
    .byte 0x00
P5_Messages_French_Msg024:
    .stringn "Le menu principal apparaît"
    .byte 0x0A ; line break / 换行
    .ascii "automatiquement quand"
    .byte 0x0A ; line break / 换行
    .ascii "vous allumez la console."
    .byte 0x00
P5_Messages_French_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .ascii " Mode automatique"
    .byte 0x00
P5_Messages_French_Msg026:
    .ascii "Si une carte DS ou une cartouche de"
    .byte 0x0A ; line break / 换行
    .stringn "jeu est insérée quand vous allumez,"
    .byte 0x0A ; line break / 换行
    .stringn "le jeu démarre automatiquement."
    .byte 0x00
P5_Messages_French_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .ascii " Mode manuel"
    .byte 0x00
P5_Messages_French_Msg028:
    .ascii "Jour"
    .byte 0x00
P5_Messages_French_Msg029:
    .ascii "Mois"
    .byte 0x00
P5_Messages_French_Msg030:
    .stringn "Année"
    .byte 0x00
P5_Messages_French_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Confirmer"
    .byte 0x00
P5_Messages_French_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Entrée"
    .byte 0x00
P5_Messages_French_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Joindre"
    .byte 0x00
P5_Messages_French_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_French_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Sélectionner"
    .byte 0x00
P5_Messages_French_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_French_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Oui"
    .byte 0x00
P5_Messages_French_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Retour"
    .byte 0x00
P5_Messages_French_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Annuler"
    .byte 0x00
P5_Messages_French_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Effacer"
    .byte 0x00
P5_Messages_French_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Non"
    .byte 0x00
P5_Messages_French_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Quitter"
    .byte 0x00
P5_Messages_French_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_French_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_French_Msg045:
    .ascii "Aucune carte DS"
    .byte 0x0A ; line break / 换行
    .stringn "n'est insérée."
    .byte 0x00
P5_Messages_French_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_French_Msg047:
    .stringn "Démarrer le jeu GBA."
    .byte 0x00
P5_Messages_French_Msg048:
    .ascii "Aucune cartouche de jeu"
    .byte 0x0A ; line break / 换行
    .stringn "n'est insérée."
    .byte 0x00
P5_Messages_French_Msg049:
    .ascii "Il y a une cartouche"
    .byte 0x0A ; line break / 换行
    .stringn "d'option DS inséree."
    .byte 0x00
P5_Messages_French_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_French_Msg051:
    .stringn "Paramètres"
    .byte 0x00
P5_Messages_French_Msg052:
    .stringn "Téléchargement DS"
    .byte 0x00
P5_Messages_French_Msg053:
    .ascii "Non"
    .byte 0x00
P5_Messages_French_Msg054:
    .ascii "Oui"
    .byte 0x00
P5_Messages_French_Msg055:
    .stringn "L'alarme a été désactivée."
    .byte 0x00
P5_Messages_French_Msg056:
    .stringn "Voulez-vous désactiver l'alarme?"
    .byte 0x00
P5_Messages_French_Msg057:
    .ascii "Voulez-vous activer"
    .byte 0x0A ; line break / 换行
    .ascii "l'alarme pour qu'elle"
    .byte 0x0A ; line break / 换行
    .stringn "sonne à ●●:●●?"
    .byte 0x00
P5_Messages_French_Msg058:
    .ascii "Voulez-vous que la fonction"
    .byte 0x0A ; line break / 换行
    .ascii "vibration accompagne l'alarme?"
    .byte 0x00
P5_Messages_French_Msg059:
    .ascii "Erreur de transmission."
    .byte 0x0A ; line break / 换行
    .stringn "Retour à la sélection de salle."
    .byte 0x00
P5_Messages_French_Msg060:
    .stringn "16 personnes se trouvent déjà"
    .byte 0x0A ; line break / 换行
    .stringn "dans la salle ⊿. Vous ne pouvez"
    .byte 0x0A ; line break / 换行
    .ascii "pas y entrer."
    .byte 0x00
P5_Messages_French_Msg061:
    .ascii "Erreur de transmission."
    .byte 0x0A ; line break / 换行
    .stringn "Veuillez éteindre la console."
    .byte 0x00
P5_Messages_French_Msg062:
    .stringn "Téléchargement en cours..."
    .byte 0x00
P5_Messages_French_Msg063:
    .stringn "Le téléchargement a été annulé."
    .byte 0x00
P5_Messages_French_Msg064:
    .ascii "Le nombre maximum de"
    .byte 0x0A ; line break / 换行
    .stringn "participants a été atteint."
    .byte 0x0A ; line break / 换行
    .stringn "Téléchargement impossible."
    .byte 0x00
P5_Messages_French_Msg065:
    .stringn "Téléchargement du logiciel réussi."
    .byte 0x00
P5_Messages_French_Msg066:
    .stringn "Vous devez régler les paramètres"
    .byte 0x0A ; line break / 换行
    .ascii "avant de commencer. Veuillez"
    .byte 0x0A ; line break / 换行
    .stringn "toucher l'écran tactile ou appuyer"
    .byte 0x0A ; line break / 换行
    .ascii "sur un bouton."
    .byte 0x00
P5_Messages_French_Msg067:
    .stringn "Veuillez confirmer vos paramètres."
    .byte 0x0A ; line break / 换行
    .stringn "Touchez l'écran tactile ou appuyez"
    .byte 0x0A ; line break / 换行
    .ascii "sur un bouton."
    .byte 0x00
P5_Messages_French_Msg068:
    .stringn "La langue par défaut sera"
    .byte 0x0A ; line break / 换行
    .stringn "le français. OK?"
    .byte 0x00
P5_Messages_French_Msg069:
    .stringn "Voulez-vous télécharger"
    .byte 0x0A ; line break / 换行
    .ascii "ce logiciel?"
    .byte 0x00
P5_Messages_French_Msg070:
    .ascii "Reprendre la transmission?"
    .byte 0x00
P5_Messages_French_Msg071:
    .ascii "Erreur de transmission."
    .byte 0x0A ; line break / 换行
    .stringn "Le téléchargement a échoué."
    .byte 0x00
P5_Messages_French_Msg072:
    .stringn "Voulez-vous éteindre"
    .byte 0x0A ; line break / 换行
    .ascii "la console?"
    .byte 0x00
P5_Messages_French_Msg073:
    .stringn "Vous devez redémarrer pour que"
    .byte 0x0A ; line break / 换行
    .stringn "les nouveaux paramètres soient"
    .byte 0x0A ; line break / 换行
    .ascii "pris en compte. Voulez-voulez"
    .byte 0x0A ; line break / 换行
    .stringn "éteindre maintenant?"
    .byte 0x00
P5_Messages_French_Msg074:
    .ascii "Recherche de logiciels"
    .byte 0x0A ; line break / 换行
    .stringn "à télécharger en cours..."
    .byte 0x00
P5_Messages_French_Msg075:
    .stringn "L'alarme a été sauvegardée."
    .byte 0x00
P5_Messages_French_Msg076:
    .stringn "Le démarrage est réglé"
    .byte 0x0A ; line break / 换行
    .ascii "sur automatique."
    .byte 0x00
P5_Messages_French_Msg077:
    .ascii "La date d'anniversaire"
    .byte 0x0A ; line break / 换行
    .stringn "a été sauvegardée."
    .byte 0x00
P5_Messages_French_Msg078:
    .ascii "Le mode GBA s'affiche"
    .byte 0x0A ; line break / 换行
    .stringn "sur l'écran tactile."
    .byte 0x00
P5_Messages_French_Msg079:
    .stringn "La couleur a été sauvegardée."
    .byte 0x00
P5_Messages_French_Msg080:
    .stringn "Le message a été sauvegardé."
    .byte 0x00
P5_Messages_French_Msg081:
    .stringn "La date a été sauvegardée."
    .byte 0x00
P5_Messages_French_Msg082:
    .stringn "La langue est réglée sur anglais."
    .byte 0x00
P5_Messages_French_Msg083:
    .stringn "La langue est réglée sur français."
    .byte 0x00
P5_Messages_French_Msg084:
    .stringn "La langue est réglée sur allemand."
    .byte 0x00
P5_Messages_French_Msg085:
    .stringn "La langue est réglée sur italien."
    .byte 0x00
P5_Messages_French_Msg086:
    .byte 0x00
P5_Messages_French_Msg087:
    .stringn "Le démarrage est réglé sur manuel."
    .byte 0x00
P5_Messages_French_Msg088:
    .ascii "Le nom de l'utilisateur"
    .byte 0x0A ; line break / 换行
    .stringn "a été sauvegardé."
    .byte 0x00
P5_Messages_French_Msg089:
    .stringn "L'écran tactile a été calibré."
    .byte 0x00
P5_Messages_French_Msg090:
    .stringn "La langue est réglée sur espagnol."
    .byte 0x00
P5_Messages_French_Msg091:
    .stringn "L'heure a été sauvegardée."
    .byte 0x00
P5_Messages_French_Msg092:
    .ascii "Le mode GBA s'affiche"
    .byte 0x0A ; line break / 换行
    .stringn "sur l'écran supérieur."
    .byte 0x00
P5_Messages_French_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_French_Msg094:
    .stringn "L'alarme est activée. Touchez l'écran tactile"
    .byte 0x0A ; line break / 换行
    .ascii "ou appuyez sur un bouton pour la"
    .byte 0x0A ; line break / 换行
    .stringn "désactiver. "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .stringn " ne peuvent pas la désactiver. "
    .byte 0x0A ; line break / 换行
    .stringn "(Ajustez le volume si nécessaire.)"
    .byte 0x00
P5_Messages_French_Msg095:
    .stringn "Pour éteindre la sonnerie de"
    .byte 0x0A ; line break / 换行
    .stringn "l'alarme, touchez l'écran tactile"
    .byte 0x0A ; line break / 换行
    .ascii "ou appuyez sur un bouton."
    .byte 0x00
P5_Messages_French_Msg096:
    .stringn "L'alarme est passée depuis ●●:●●. Pour"
    .byte 0x0A ; line break / 换行
    .stringn "désactiver l'alarme, touchez l'écran"
    .byte 0x0A ; line break / 换行
    .ascii "tactile ou appuyez sur un bouton."
    .byte 0x00
P5_Messages_French_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_French_Msg098:
    .ascii "Heure"
    .byte 0x00
P5_Messages_French_Msg099:
    .ascii "Minute"
    .byte 0x00
P5_Messages_French_Msg100:
    .ascii "Ecran tactile"
    .byte 0x00
P5_Messages_French_Msg101:
    .stringn "Ecran supérieur"
    .byte 0x00
P5_Messages_French_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_French_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_French_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_French_Msg105:
    .ascii "Italiano"
    .byte 0x00
P5_Messages_French_Msg106:
    .stringn "日本語"
    .byte 0x00
P5_Messages_French_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_French_Msg108:
    .ascii "00:00"
    .byte 0x00
P5_Messages_French_Msg109:
    .ascii "DD/MM"
    .byte 0x00
P5_Messages_French_Msg110:
    .ascii "Ve"
    .byte 0x00
P5_Messages_French_Msg111:
    .stringn "Télécharger un logiciel"
    .byte 0x0A ; line break / 换行
    .stringn "via le téléchargement DS."
    .byte 0x00
P5_Messages_French_Msg112:
    .stringn "Changer d'autres paramètres."
    .byte 0x00
P5_Messages_French_Msg113:
    .stringn "Choisissez le type de démarrage"
    .byte 0x0A ; line break / 换行
    .ascii "lorsque vous allumez la console."
    .byte 0x00
P5_Messages_French_Msg114:
    .stringn "Choisissez l'écran que vous voulez"
    .byte 0x0A ; line break / 换行
    .stringn "utiliser en démarrant le mode GBA."
    .byte 0x00
P5_Messages_French_Msg115:
    .stringn "Sélectionnez la langue que"
    .byte 0x0A ; line break / 换行
    .ascii "vous voulez utiliser."
    .byte 0x00
P5_Messages_French_Msg116:
    .ascii "Entrer les informations"
    .byte 0x0A ; line break / 换行
    .ascii "sur l'utilisateur."
    .byte 0x00
P5_Messages_French_Msg117:
    .ascii "Entrez votre surnom."
    .byte 0x00
P5_Messages_French_Msg118:
    .stringn "Sélectionnez votre"
    .byte 0x0A ; line break / 换行
    .ascii "couleur favorite."
    .byte 0x00
P5_Messages_French_Msg119:
    .ascii "Entrez votre date d'anniversaire."
    .byte 0x00
P5_Messages_French_Msg120:
    .ascii "Entrez un message personnel."
    .byte 0x00
P5_Messages_French_Msg121:
    .stringn "Pour calibrer l'écran tactile, veuillez"
    .byte 0x0A ; line break / 换行
    .ascii "pointer la marque "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " avec le stylet."
    .byte 0x00
P5_Messages_French_Msg122:
    .stringn "Changer les paramètres. Choisissez"
    .byte 0x0A ; line break / 换行
    .stringn "le paramètre à modifier."
    .byte 0x00
P5_Messages_French_Msg123:
    .ascii "Changer la date, l'heure et l'alarme."
    .byte 0x00
P5_Messages_French_Msg124:
    .ascii "Entrez la date d'aujourd'hui."
    .byte 0x00
P5_Messages_French_Msg125:
    .stringn "Réglez l'heure."
    .byte 0x00
P5_Messages_French_Msg126:
    .stringn "Pointez l'icône de l'alarme ("
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .ascii ") pour"
    .byte 0x0A ; line break / 换行
    .stringn "la faire sonner à l'heure choisie."
    .byte 0x00
P5_Messages_French_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_French_Msg128:
    .ascii "Lu"
    .byte 0x00
P5_Messages_French_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_French_Msg130:
    .ascii "Sa"
    .byte 0x00
P5_Messages_French_Msg131:
    .ascii "Di"
    .byte 0x00
P5_Messages_French_Msg132:
    .ascii "Je"
    .byte 0x00
P5_Messages_French_Msg133:
    .stringn "Téléchargement DS"
    .byte 0x00
P5_Messages_French_Msg134:
    .ascii "Options"
    .byte 0x00
P5_Messages_French_Msg135:
    .stringn "Démarrage"
    .byte 0x00
P5_Messages_French_Msg136:
    .ascii "Mode GBA"
    .byte 0x00
P5_Messages_French_Msg137:
    .ascii "Langue"
    .byte 0x00
P5_Messages_French_Msg138:
    .ascii "Utilisateur"
    .byte 0x00
P5_Messages_French_Msg139:
    .ascii "Nom de l'utilisateur"
    .byte 0x00
P5_Messages_French_Msg140:
    .ascii "Couleur"
    .byte 0x00
P5_Messages_French_Msg141:
    .ascii "Anniversaire"
    .byte 0x00
P5_Messages_French_Msg142:
    .ascii "Message"
    .byte 0x00
P5_Messages_French_Msg143:
    .ascii "Ecran tactile"
    .byte 0x00
P5_Messages_French_Msg144:
    .stringn "Paramètres"
    .byte 0x00
P5_Messages_French_Msg145:
    .ascii "Horloge"
    .byte 0x00
P5_Messages_French_Msg146:
    .ascii "Date"
    .byte 0x00
P5_Messages_French_Msg147:
    .ascii "Heure"
    .byte 0x00
P5_Messages_French_Msg148:
    .ascii "Alarme"
    .byte 0x00
P5_Messages_French_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_French_Msg150:
    .ascii "Ma"
    .byte 0x00
P5_Messages_French_Msg151:
    .ascii "Me"
    .byte 0x00
P5_Messages_French_Msg152:
    .ascii "MM/YYYY"
    .byte 0x00
P5_Messages_French_Msg153:
    .ascii "DD/MM/YYYY"
    .byte 0x00
P5_Messages_French_Msg154:
    .ascii "Heure"
    .byte 0x00
P5_Messages_French_Msg155:
    .ascii "00:00:00"
    .byte 0x00
P5_Messages_French_Msg156:
    .ascii "Temps restant:"
    .byte 0x00
P5_Messages_French_Msg157:
    .stringn "Temps écoulé:"
    .byte 0x00
P5_Messages_French_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_French_Msg159:
    .ascii "Alarme"
    .byte 0x00
P5_Messages_French_Msg160:
    .ascii "Annuler"
    .byte 0x00
P5_Messages_French_Msg161:
    .ascii "Confirmer"
    .byte 0x00
P5_Messages_French_Msg162:
    .stringn "Sélectionnez la langue à utiliser."
    .byte 0x00
P5_Messages_French_Msg163:
    .stringn "Les paramètres ont été perdus. "
    .byte 0x0A ; line break / 换行
    .ascii "Pointez la marque "
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
.loadtable "../../include/utf16le.tbl","utf-8"
