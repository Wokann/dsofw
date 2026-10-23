; BMG resource; included by p5.s at P5_Messages_Spanish.
; BMG 资源，由 p5.s 在 P5_Messages_Spanish 处引入。
.loadtable "../../include/utf8.tbl","utf-8"
    .ascii "MESGbmg1"
    .word P5_Messages_Spanish_End - P5_Messages_Spanish
    .word 2 ; INF1 + DAT1
    .byte 4 ; UTF-8
    .incbin "src/text/messages_es.bmg", 0x11, 0x3 ; original format bytes / 原始格式字节
    .incbin "src/text/messages_es.bmg", 0x14, 0xC ; original format bytes / 原始格式字节
P5_Messages_Spanish_Info:
    .ascii "INF1"
    .word P5_Messages_Spanish_Data - P5_Messages_Spanish_Info
    .dh (P5_Messages_Spanish_EntriesEnd - P5_Messages_Spanish_Entries) / 4
    .dh 4 ; bytes per message offset / 每项偏移字节数
    .word 0x00000000 ; message group ID / 消息组 ID
P5_Messages_Spanish_Entries:
    .word P5_Messages_Spanish_Msg000 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg001 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg002 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg003 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg004 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg005 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg006 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg007 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg008 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg009 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg010 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg011 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg012 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg013 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg014 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg015 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg016 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg017 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg018 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg019 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg020 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg021 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg022 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg023 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg024 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg025 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg026 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg027 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg028 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg029 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg030 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg031 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg032 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg033 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg034 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg035 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg036 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg037 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg038 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg039 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg040 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg041 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg042 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg043 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg044 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg045 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg046 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg047 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg048 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg049 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg050 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg051 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg052 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg053 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg054 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg055 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg056 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg057 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg058 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg059 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg060 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg061 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg062 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg063 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg064 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg065 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg066 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg067 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg068 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg069 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg070 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg071 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg072 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg073 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg074 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg075 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg076 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg077 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg078 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg079 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg080 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg081 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg082 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg083 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg084 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg085 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg086 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg087 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg088 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg089 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg090 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg091 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg092 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg093 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg094 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg095 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg096 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg097 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg098 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg099 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg100 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg101 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg102 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg103 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg104 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg105 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg106 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg107 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg108 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg109 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg110 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg111 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg112 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg113 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg114 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg115 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg116 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg117 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg118 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg119 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg120 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg121 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg122 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg123 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg124 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg125 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg126 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg127 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg128 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg129 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg130 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg131 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg132 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg133 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg134 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg135 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg136 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg137 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg138 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg139 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg140 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg141 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg142 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg143 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg144 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg145 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg146 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg147 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg148 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg149 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg150 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg151 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg152 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg153 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg154 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg155 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg156 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg157 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg158 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg159 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg160 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg161 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg162 - P5_Messages_Spanish_Text
    .word P5_Messages_Spanish_Msg163 - P5_Messages_Spanish_Text
P5_Messages_Spanish_EntriesEnd:
P5_Messages_Spanish_Data:
    .ascii "DAT1"
    .word P5_Messages_Spanish_End - P5_Messages_Spanish_Data
P5_Messages_Spanish_Text:
    .byte 0x00
P5_Messages_Spanish_Msg000:
    .stringn "Ya está calibrada la pantalla."
    .byte 0x0A ; line break / 换行
    .ascii "Da un suave toque sobre las"
    .byte 0x0A ; line break / 换行
    .ascii "marcas "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .ascii " para comprobarlo."
    .byte 0x00
P5_Messages_Spanish_Msg001:
    .stringn "Pulsa el Botón "
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " para cancelar."
    .byte 0x00
P5_Messages_Spanish_Msg002:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Intentar de nuevo"
    .byte 0x00
P5_Messages_Spanish_Msg003:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Cerrar"
    .byte 0x00
P5_Messages_Spanish_Msg004:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Sí"
    .byte 0x00
P5_Messages_Spanish_Msg005:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " No"
    .byte 0x00
P5_Messages_Spanish_Msg006:
    .stringn "¡Felicidades!"
    .byte 0x0A ; line break / 换行
    .stringn "¡Hoy es el cumpleaños"
    .byte 0x0A ; line break / 换行
    .stringn "de ∩!"
    .byte 0x00
P5_Messages_Spanish_Msg007:
    .stringn "∩ se ha ido"
    .byte 0x0A ; line break / 换行
    .stringn "a la sala de chat ⊿."
    .byte 0x00
P5_Messages_Spanish_Msg008:
    .stringn "Entra en la sala ⊿: ∩"
    .byte 0x00
P5_Messages_Spanish_Msg009:
    .stringn "Sale de la sala ⊿: ∩"
    .byte 0x00
P5_Messages_Spanish_Msg010:
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
P5_Messages_Spanish_Msg011:
    .ascii "Sala de chat A"
    .byte 0x00
P5_Messages_Spanish_Msg012:
    .ascii "Sala de chat B"
    .byte 0x00
P5_Messages_Spanish_Msg013:
    .ascii "Sala de chat C"
    .byte 0x00
P5_Messages_Spanish_Msg014:
    .ascii "Sala de chat D"
    .byte 0x00
P5_Messages_Spanish_Msg015:
    .ascii "Elige la sala de chat en la que quieras entrar."
    .byte 0x00
P5_Messages_Spanish_Msg016:
    .ascii "Elige un color"
    .byte 0x00
P5_Messages_Spanish_Msg017:
    .ascii "Cancelar"
    .byte 0x00
P5_Messages_Spanish_Msg018:
    .ascii "Confirmar"
    .byte 0x00
P5_Messages_Spanish_Msg019:
    .byte 0xEE, 0x80, 0x82 ; U+E002 glyph / 字形
    .ascii " Poner la alarma"
    .byte 0x00
P5_Messages_Spanish_Msg020:
    .ascii "Hora"
    .byte 0x00
P5_Messages_Spanish_Msg021:
    .ascii "Minuto"
    .byte 0x00
P5_Messages_Spanish_Msg022:
    .stringn "Día"
    .byte 0x00
P5_Messages_Spanish_Msg023:
    .ascii "Mes"
    .byte 0x00
P5_Messages_Spanish_Msg024:
    .ascii "Cuando enciendas la consola,"
    .byte 0x0A ; line break / 换行
    .stringn "aparecerá el menú superior."
    .byte 0x00
P5_Messages_Spanish_Msg025:
    .byte 0xEE, 0x80, 0xAD ; U+E02D glyph / 字形
    .stringn " Modo automático"
    .byte 0x00
P5_Messages_Spanish_Msg026:
    .ascii "Si hay una tarjeta DS o un cartucho"
    .byte 0x0A ; line break / 换行
    .ascii "insertado al encender la consola,"
    .byte 0x0A ; line break / 换行
    .stringn "accederás enseguida al contenido."
    .byte 0x00
P5_Messages_Spanish_Msg027:
    .byte 0xEE, 0x80, 0xAE ; U+E02E glyph / 字形
    .ascii " Modo manual"
    .byte 0x00
P5_Messages_Spanish_Msg028:
    .stringn "Día"
    .byte 0x00
P5_Messages_Spanish_Msg029:
    .ascii "Mes"
    .byte 0x00
P5_Messages_Spanish_Msg030:
    .stringn "Año"
    .byte 0x00
P5_Messages_Spanish_Msg031:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Confirmar"
    .byte 0x00
P5_Messages_Spanish_Msg032:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Añadir"
    .byte 0x00
P5_Messages_Spanish_Msg033:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Conectar"
    .byte 0x00
P5_Messages_Spanish_Msg034:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " OK"
    .byte 0x00
P5_Messages_Spanish_Msg035:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .ascii " Seleccionar"
    .byte 0x00
P5_Messages_Spanish_Msg036:
    .stringn "－－－－－－－－"
    .byte 0x00
P5_Messages_Spanish_Msg037:
    .byte 0xEE, 0x80, 0x80 ; U+E000 glyph / 字形
    .stringn " Sí"
    .byte 0x00
P5_Messages_Spanish_Msg038:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Cancelar"
    .byte 0x00
P5_Messages_Spanish_Msg039:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Cancelar"
    .byte 0x00
P5_Messages_Spanish_Msg040:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Borrar"
    .byte 0x00
P5_Messages_Spanish_Msg041:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " No"
    .byte 0x00
P5_Messages_Spanish_Msg042:
    .byte 0xEE, 0x80, 0x81 ; U+E001 glyph / 字形
    .ascii " Salir"
    .byte 0x00
P5_Messages_Spanish_Msg043:
    .stringn "－－－－－－－－－"
    .byte 0x00
P5_Messages_Spanish_Msg044:
    .ascii "PictoChat"
    .byte 0x00
P5_Messages_Spanish_Msg045:
    .ascii "No se detecta ninguna"
    .byte 0x0A ; line break / 换行
    .ascii "tarjeta DS."
    .byte 0x00
P5_Messages_Spanish_Msg046:
    .stringn "ああああああああああああああ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x0A ; line break / 换行
    .stringn "あ"
    .byte 0x00
P5_Messages_Spanish_Msg047:
    .ascii "Jugar al juego de GBA."
    .byte 0x00
P5_Messages_Spanish_Msg048:
    .stringn "No se detecta ningún"
    .byte 0x0A ; line break / 换行
    .ascii "cartucho."
    .byte 0x00
P5_Messages_Spanish_Msg049:
    .ascii "Se ha detectado un"
    .byte 0x0A ; line break / 换行
    .stringn "cartucho con opción de DS."
    .byte 0x00
P5_Messages_Spanish_Msg050:
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "------------------------"
    .byte 0x00
P5_Messages_Spanish_Msg051:
    .stringn "Configuración"
    .byte 0x00
P5_Messages_Spanish_Msg052:
    .ascii "Descarga DS"
    .byte 0x00
P5_Messages_Spanish_Msg053:
    .ascii "No"
    .byte 0x00
P5_Messages_Spanish_Msg054:
    .stringn "Sí"
    .byte 0x00
P5_Messages_Spanish_Msg055:
    .ascii "Acabas de quitar la alarma."
    .byte 0x00
P5_Messages_Spanish_Msg056:
    .stringn "¿Quieres quitar la alarma?"
    .byte 0x00
P5_Messages_Spanish_Msg057:
    .stringn "¿Quieres poner la alarma a las ●●:●●?"
    .byte 0x00
P5_Messages_Spanish_Msg058:
    .stringn "¿Quieres activar la función"
    .byte 0x0A ; line break / 换行
    .stringn "de vibración junto con la alarma?"
    .byte 0x00
P5_Messages_Spanish_Msg059:
    .ascii "Se ha producido un error"
    .byte 0x0A ; line break / 换行
    .stringn "en la comunicación."
    .byte 0x0A ; line break / 换行
    .ascii "Vuelve a seleccionar una sala."
    .byte 0x00
P5_Messages_Spanish_Msg060:
    .stringn "La sala de chat ⊿ está llena."
    .byte 0x0A ; line break / 换行
    .stringn "No queda sitio para nadie más."
    .byte 0x00
P5_Messages_Spanish_Msg061:
    .ascii "Se ha producido un error"
    .byte 0x0A ; line break / 换行
    .stringn "en la comunicación."
    .byte 0x0A ; line break / 换行
    .ascii "Apaga la consola."
    .byte 0x00
P5_Messages_Spanish_Msg062:
    .ascii "Descargando los datos..."
    .byte 0x00
P5_Messages_Spanish_Msg063:
    .ascii "Se ha cancelado"
    .byte 0x0A ; line break / 换行
    .ascii "la descarga de datos."
    .byte 0x00
P5_Messages_Spanish_Msg064:
    .stringn "Se ha alcanzado el número"
    .byte 0x0A ; line break / 换行
    .stringn "máximo de participantes."
    .byte 0x0A ; line break / 换行
    .ascii "No es posible descargar los datos."
    .byte 0x00
P5_Messages_Spanish_Msg065:
    .ascii "Se han descargado los datos."
    .byte 0x00
P5_Messages_Spanish_Msg066:
    .ascii "Antes de comenzar, debes realizar"
    .byte 0x0A ; line break / 换行
    .stringn "la configuración. Toca la pantalla"
    .byte 0x0A ; line break / 换行
    .stringn "táctil o pulsa cualquier botón."
    .byte 0x00
P5_Messages_Spanish_Msg067:
    .stringn "Confirma la configuración."
    .byte 0x0A ; line break / 换行
    .stringn "Toca la pantalla táctil"
    .byte 0x0A ; line break / 换行
    .stringn "o pulsa cualquier botón."
    .byte 0x00
P5_Messages_Spanish_Msg068:
    .stringn "Si confirmas, los mensajes saldrán"
    .byte 0x0A ; line break / 换行
    .stringn "en español. ¿Estás de acuerdo?"
    .byte 0x00
P5_Messages_Spanish_Msg069:
    .stringn "¿Quieres descargar los datos?"
    .byte 0x00
P5_Messages_Spanish_Msg070:
    .stringn "¿Quieres continuar"
    .byte 0x0A ; line break / 换行
    .stringn "con la comunicación?"
    .byte 0x00
P5_Messages_Spanish_Msg071:
    .ascii "Se ha producido un error"
    .byte 0x0A ; line break / 换行
    .stringn "en la comunicación."
    .byte 0x0A ; line break / 换行
    .ascii "No se han podido descargar"
    .byte 0x0A ; line break / 换行
    .ascii "los datos."
    .byte 0x00
P5_Messages_Spanish_Msg072:
    .stringn "¿Quieres apagar la consola?"
    .byte 0x00
P5_Messages_Spanish_Msg073:
    .stringn "Para activar la nueva configuración,"
    .byte 0x0A ; line break / 换行
    .ascii "debes reiniciar la consola."
    .byte 0x0A ; line break / 换行
    .stringn "¿Quieres apagar la consola ahora?"
    .byte 0x00
P5_Messages_Spanish_Msg074:
    .ascii "Buscando datos para"
    .byte 0x0A ; line break / 换行
    .ascii "descargar..."
    .byte 0x00
P5_Messages_Spanish_Msg075:
    .ascii "Acabas de guardar la alarma."
    .byte 0x00
P5_Messages_Spanish_Msg076:
    .ascii "El modo de inicio de la"
    .byte 0x0A ; line break / 换行
    .stringn "consola será automático."
    .byte 0x00
P5_Messages_Spanish_Msg077:
    .ascii "Acabas de guardar"
    .byte 0x0A ; line break / 换行
    .stringn "la fecha de cumpleaños."
    .byte 0x00
P5_Messages_Spanish_Msg078:
    .stringn "La pantalla GBA quedará configurada"
    .byte 0x0A ; line break / 换行
    .stringn "por defecto como pantalla táctil."
    .byte 0x00
P5_Messages_Spanish_Msg079:
    .ascii "Acabas de guardar"
    .byte 0x0A ; line break / 换行
    .ascii "el color."
    .byte 0x00
P5_Messages_Spanish_Msg080:
    .ascii "Acabas de guardar el mensaje."
    .byte 0x00
P5_Messages_Spanish_Msg081:
    .ascii "Acabas de guardar la fecha."
    .byte 0x00
P5_Messages_Spanish_Msg082:
    .stringn "Los mensajes saldrán en inglés."
    .byte 0x00
P5_Messages_Spanish_Msg083:
    .stringn "Los mensajes saldrán en francés."
    .byte 0x00
P5_Messages_Spanish_Msg084:
    .stringn "Los mensajes saldrán en alemán."
    .byte 0x00
P5_Messages_Spanish_Msg085:
    .stringn "Los mensajes saldrán en italiano."
    .byte 0x00
P5_Messages_Spanish_Msg086:
    .stringn "Los mensajes saldrán en japonés."
    .byte 0x00
P5_Messages_Spanish_Msg087:
    .ascii "El modo de inicio de la"
    .byte 0x0A ; line break / 换行
    .stringn "consola será manual."
    .byte 0x00
P5_Messages_Spanish_Msg088:
    .ascii "Acabas de guardar"
    .byte 0x0A ; line break / 换行
    .ascii "el nombre del usuario."
    .byte 0x00
P5_Messages_Spanish_Msg089:
    .stringn "Acabas de calibrar la pantalla táctil."
    .byte 0x00
P5_Messages_Spanish_Msg090:
    .stringn "Los mensajes saldrán en español."
    .byte 0x00
P5_Messages_Spanish_Msg091:
    .ascii "Acabas de guardar la hora."
    .byte 0x00
P5_Messages_Spanish_Msg092:
    .stringn "La pantalla GBA aparecerá por"
    .byte 0x0A ; line break / 换行
    .ascii "defecto como pantalla superior."
    .byte 0x00
P5_Messages_Spanish_Msg093:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Spanish_Msg094:
    .stringn "La alarma está puesta. Toca la pantalla"
    .byte 0x0A ; line break / 换行
    .stringn "táctil o pulsa cualquier botón para quitarla."
    .byte 0x0A ; line break / 换行
    .ascii "Los Botones "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .ascii " y "
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " no sirven para quitarla."
    .byte 0x0A ; line break / 换行
    .ascii "(Ajusta el volumen si es necesario.)"
    .byte 0x00
P5_Messages_Spanish_Msg095:
    .ascii "Se ha activado la alarma."
    .byte 0x0A ; line break / 换行
    .ascii "Si quieres quitarla, toca la pantalla"
    .byte 0x0A ; line break / 换行
    .stringn "táctil o pulsa cualquier botón."
    .byte 0x0A ; line break / 换行
    .ascii "Los Botones "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .ascii " y "
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " no sirven para quitarla."
    .byte 0x00
P5_Messages_Spanish_Msg096:
    .stringn "La alarma ha sonado hace ●●:●●."
    .byte 0x0A ; line break / 换行
    .ascii "Si quieres quitarla, toca la pantalla"
    .byte 0x0A ; line break / 换行
    .stringn "táctil o pulsa cualquier botón."
    .byte 0x0A ; line break / 换行
    .ascii "Los Botones "
    .byte 0xEE, 0x80, 0x84 ; U+E004 glyph / 字形
    .ascii " y "
    .byte 0xEE, 0x80, 0x85 ; U+E005 glyph / 字形
    .ascii " no sirven para quitarla."
    .byte 0x00
P5_Messages_Spanish_Msg097:
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "-------------------------------------"
    .byte 0x00
P5_Messages_Spanish_Msg098:
    .ascii "Hora"
    .byte 0x00
P5_Messages_Spanish_Msg099:
    .ascii "Minuto"
    .byte 0x00
P5_Messages_Spanish_Msg100:
    .ascii "Pantalla"
    .byte 0x0A ; line break / 换行
    .stringn "táctil"
    .byte 0x00
P5_Messages_Spanish_Msg101:
    .ascii "Pantalla"
    .byte 0x0A ; line break / 换行
    .ascii "superior"
    .byte 0x00
P5_Messages_Spanish_Msg102:
    .ascii "English"
    .byte 0x00
P5_Messages_Spanish_Msg103:
    .stringn "Français"
    .byte 0x00
P5_Messages_Spanish_Msg104:
    .ascii "Deutsch"
    .byte 0x00
P5_Messages_Spanish_Msg105:
    .stringn "한국어"
    .byte 0x00
P5_Messages_Spanish_Msg106:
    .stringn "日本語"
    .byte 0x00
P5_Messages_Spanish_Msg107:
    .stringn "Español"
    .byte 0x00
P5_Messages_Spanish_Msg108:
    .ascii "00:00"
    .byte 0x00
P5_Messages_Spanish_Msg109:
    .ascii "DD/MM"
    .byte 0x00
P5_Messages_Spanish_Msg110:
    .ascii "Vi"
    .byte 0x00
P5_Messages_Spanish_Msg111:
    .ascii "Descarga de datos mediante"
    .byte 0x0A ; line break / 换行
    .ascii "descarga DS."
    .byte 0x00
P5_Messages_Spanish_Msg112:
    .stringn "Aquí puedes cambiar otras opciones."
    .byte 0x00
P5_Messages_Spanish_Msg113:
    .ascii "Selecciona el modo de inicio"
    .byte 0x0A ; line break / 换行
    .ascii "al encender la consola."
    .byte 0x00
P5_Messages_Spanish_Msg114:
    .ascii "Selecciona la pantalla de inicio"
    .byte 0x0A ; line break / 换行
    .ascii "para el modo GBA."
    .byte 0x00
P5_Messages_Spanish_Msg115:
    .ascii "Selecciona el idioma que quieras."
    .byte 0x00
P5_Messages_Spanish_Msg116:
    .ascii "Escribe los datos del usuario."
    .byte 0x00
P5_Messages_Spanish_Msg117:
    .ascii "Escribe un apodo."
    .byte 0x00
P5_Messages_Spanish_Msg118:
    .ascii "Selecciona un color."
    .byte 0x00
P5_Messages_Spanish_Msg119:
    .stringn "Escribe una fecha de cumpleaños."
    .byte 0x00
P5_Messages_Spanish_Msg120:
    .stringn "Escribe algún mensaje."
    .byte 0x00
P5_Messages_Spanish_Msg121:
    .stringn "Calibra la pantalla táctil dando un suave"
    .byte 0x0A ; line break / 换行
    .ascii "toque en la marca "
    .byte 0xEE, 0x80, 0x94 ; U+E014 glyph / 字形
    .stringn " con el lápiz táctil."
    .byte 0x00
P5_Messages_Spanish_Msg122:
    .stringn "Aquí puedes cambiar la configuración de"
    .byte 0x0A ; line break / 换行
    .ascii "la consola. Elige lo que quieras cambiar."
    .byte 0x00
P5_Messages_Spanish_Msg123:
    .ascii "Cambia la fecha, la hora y la alarma."
    .byte 0x00
P5_Messages_Spanish_Msg124:
    .ascii "Pon la fecha de hoy."
    .byte 0x00
P5_Messages_Spanish_Msg125:
    .ascii "Pon la consola en hora."
    .byte 0x00
P5_Messages_Spanish_Msg126:
    .ascii "Da un golpecito sobre el icono"
    .byte 0x0A ; line break / 换行
    .ascii "de la alarma ("
    .byte 0xEE, 0x80, 0x87 ; U+E007 glyph / 字形
    .ascii ") para ponerla."
    .byte 0x00
P5_Messages_Spanish_Msg127:
    .ascii "---------------------------------"
    .byte 0x0A ; line break / 换行
    .ascii "---------------------------------"
    .byte 0x00
P5_Messages_Spanish_Msg128:
    .ascii "Lu"
    .byte 0x00
P5_Messages_Spanish_Msg129:
    .ascii "-------------"
    .byte 0x00
P5_Messages_Spanish_Msg130:
    .ascii "Sa"
    .byte 0x00
P5_Messages_Spanish_Msg131:
    .ascii "Do"
    .byte 0x00
P5_Messages_Spanish_Msg132:
    .ascii "Ju"
    .byte 0x00
P5_Messages_Spanish_Msg133:
    .ascii "Descarga DS"
    .byte 0x00
P5_Messages_Spanish_Msg134:
    .ascii "Opciones"
    .byte 0x00
P5_Messages_Spanish_Msg135:
    .ascii "Modo de inicio"
    .byte 0x00
P5_Messages_Spanish_Msg136:
    .ascii "Modo GBA"
    .byte 0x00
P5_Messages_Spanish_Msg137:
    .ascii "Idioma"
    .byte 0x00
P5_Messages_Spanish_Msg138:
    .ascii "Usuario"
    .byte 0x00
P5_Messages_Spanish_Msg139:
    .ascii "Nombre del usuario"
    .byte 0x00
P5_Messages_Spanish_Msg140:
    .ascii "Color"
    .byte 0x00
P5_Messages_Spanish_Msg141:
    .stringn "Cumpleaños"
    .byte 0x00
P5_Messages_Spanish_Msg142:
    .ascii "Mensaje"
    .byte 0x00
P5_Messages_Spanish_Msg143:
    .stringn "Pantalla táctil"
    .byte 0x00
P5_Messages_Spanish_Msg144:
    .stringn "Configuración"
    .byte 0x00
P5_Messages_Spanish_Msg145:
    .ascii "Reloj"
    .byte 0x00
P5_Messages_Spanish_Msg146:
    .ascii "Fecha"
    .byte 0x00
P5_Messages_Spanish_Msg147:
    .ascii "Hora"
    .byte 0x00
P5_Messages_Spanish_Msg148:
    .ascii "Alarma"
    .byte 0x00
P5_Messages_Spanish_Msg149:
    .stringn "－－－－－－－－－－－－－－－－－－－"
    .byte 0x00
P5_Messages_Spanish_Msg150:
    .ascii "Ma"
    .byte 0x00
P5_Messages_Spanish_Msg151:
    .ascii "Mi"
    .byte 0x00
P5_Messages_Spanish_Msg152:
    .ascii "MM/YYYY"
    .byte 0x00
P5_Messages_Spanish_Msg153:
    .ascii "DD/MM/YYYY"
    .byte 0x00
P5_Messages_Spanish_Msg154:
    .ascii "Hora actual"
    .byte 0x00
P5_Messages_Spanish_Msg155:
    .ascii "00:00:00"
    .byte 0x00
P5_Messages_Spanish_Msg156:
    .ascii "Tiempo restante"
    .byte 0x00
P5_Messages_Spanish_Msg157:
    .ascii "Ha sonado hace"
    .byte 0x00
P5_Messages_Spanish_Msg158:
    .ascii "-----------------"
    .byte 0x00
P5_Messages_Spanish_Msg159:
    .ascii "Hora de la alarma"
    .byte 0x00
P5_Messages_Spanish_Msg160:
    .ascii "Cancelar"
    .byte 0x00
P5_Messages_Spanish_Msg161:
    .ascii "Confirmar"
    .byte 0x00
P5_Messages_Spanish_Msg162:
    .ascii "Selecciona el idioma que quieras."
    .byte 0x00
P5_Messages_Spanish_Msg163:
    .stringn "Se ha perdido la configuración."
    .byte 0x0A ; line break / 换行
    .ascii "Da un suave toque sobre la marca "
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
.loadtable "../../include/utf16le.tbl","utf-8"
