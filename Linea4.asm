        .ORIG	x3000

        LD	R0,MATRIZT
        PUTS
        AND R6,R6,#0
        ADD R6,R6,#15
        ADD R6,R6,#3
        BR	START

MSG1T   .FILL	MSG1
MSG2T   .FILL	MSG2
MSGET   .FILL	MSGE
WIN1T   .FILL	WIN1
WIN2T   .FILL	WIN2
TIET    .FILL	TIE
ASCII0T .FILL	ASCII0
ASCII5T .FILL	ASCII5
ASCIIOT .FILL	ASCIIO
ASCIIXT .FILL	ASCIIX
PLAYER1T .FILL	PLAYER1
PLAYER2T .FILL	PLAYER2
PTR0T   .FILL	PTR0
PTR1T   .FILL	PTR1
PTR2T   .FILL	PTR2
PTR3T   .FILL	PTR3
PTR4T   .FILL	PTR4
PTR5T   .FILL	PTR5
LFT     .FILL	LF
CONT1T  .FILL	CONT1
CONT2T  .FILL	CONT2
CONTCOL0T .FILL	CONTCOL0
CONTCOL1T .FILL	CONTCOL1
CONTCOL2T .FILL	CONTCOL2
CONTCOL3T .FILL	CONTCOL3
CONTCOL4T .FILL	CONTCOL4
CONTCOL5T .FILL	CONTCOL5

MATRIZT .FILL	MATRIZ


START   LD  R0,MATRIZT
        JSR PTR
SP1     LD  R0,MSG1T
        ;LD  R1,MSGET
        JSR RANGE
        LDI R1,ASCII0T
        AND R2,R2,#0
        ADD R2,R2,R0    ;col ingresada por el usuario
        ADD R2,R2,R1
        STI R2,CONT1T   ;Almaceno el valor del usuario
        LD  R0,PTR0T
        ADD R0,R0,R2    ;Para saber que puntero uso
        LDI R1,ASCIIOT
        LD  R3,CONTCOL0T
        ADD R3,R3,R2    
        JSR COL
        ADD R4,R4,#-1   ;Si no es posible vuelvo y compruebo
        BRn SP1
        AND R2,R2,#0
        ADD R2,R2,R0    ;Guardo la pos del puntero en R2
        LDR	R0,R0,#0    ;Cargo la dir de memoria del puntero
        LDI R1,ASCIIOT
        JSR VERT
        ADD R4,R4,#-1
        BRn WIN01
        LDI R5,CONT1T
        JSR HORIZ
        ADD R4,R4,#-1
        BRn WIN01
        JSR DIAG
WIN01   AND R5,R5,#0
        LDI R5,PLAYER1T
        STR R5,R0,#0 
        ADD R0,R0,#-12  ;Muevo la dir de la matriz una casilla hacia arriba
        STR R0,R2,#0
        LD  R0,MATRIZT
        PUTS
        ADD R4,R4,#-1
        BRn GANASTE1
        ;Aca imprimo la matriz 
SP2     LD  R0,MSG2T
        ;LD  R1,MSGET
        JSR RANGE
        LDI R1,ASCII0T
        AND R2,R2,#0
        ADD R2,R2,R0    ;col ingresada por el usuario
        ADD R2,R2,R1
        STI R2,CONT2T   ;Almaceno el valor del usuario (dec)
        LD  R0,PTR0T
        ADD R0,R0,R2    ;Para saber que puntero uso
        LDI R1,ASCIIOT
        LD  R3,CONTCOL0T
        ADD R3,R3,R2    ;Para saber que contador uso
        JSR COL
        ADD R4,R4,#-1   ;Si no es posible vuelvo y pido el dato
        BRn SP2
        ;TODO: Verificar si el jugador completa 4 en linea
        AND R2,R2,#0
        ADD R2,R2,R0    ;Guardo la pos del puntero en R2
        LDR	R0,R0,#0    ;Cargo la dir de memoria del puntero
        LDI R1,ASCIIXT
        JSR VERT
        ADD R4,R4,#-1
        BRn WIN02
        LDI R5,CONT2T
        JSR HORIZ
        ADD R4,R4,#-1
        BRn WIN02
        JSR DIAG
WIN02   AND R5,R5,#0
        LDI R5,PLAYER2T
        STR R5,R0,#0 
        ADD R0,R0,#-12  ;Muevo la dir de la matriz una casilla hacia arriba
        STR R0,R2,#0
        LD  R0,MATRIZT
        PUTS
        ADD R4,R4,#-1
        BRn GANASTE2
        ADD R6,R6,#-1
        BRp SP1 
        LD  R0,TIET
        PUTS 
FIN     HALT
GANASTE1 LD  R0,WIN1T
        PUTS
        BR   FIN
GANASTE2 LD  R0,WIN2T
        PUTS
        BR   FIN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RANGE   ST   R0,RgSaveR0
        ST   R1,RgSaveR1
        ST   R7,RgSaveR7
SRGE    LD   R0,RgSaveR0
        PUTS
        GETC
        LD   R1,ASCII0T
        LDR  R1,R1,#0
        ADD  R1,R0,R1
        BRn  ERGE
        LD   R1,ASCII5T
        LDR  R1,R1,#0
        ADD  R1,R0,R1
        BRp  ERGE
        OUT
        ST   R0,CopyR0
        LD   R0,LFT
        PUTS
FINRGE  LD   R0,CopyR0
        LD   R1,RgSaveR1
        LD   R7,RgSaveR7
        RET
ERGE    OUT
        AND  R0,R0,#0
        LD   R0,MSGET
        PUTS
        BR   SRGE
RgSaveR0    .BLKW	1
CopyR0      .BLKW	1
RgSaveR1    .BLKW	1
RgSaveR7    .BLKW	1

PTR     ST   R7,ptrSaveR7     
        LD   R1,ASCII60
        ADD  R0,R0,R1
        LD   R2,PTR0T
        STR	 R0,R2,#0
        ADD  R0,R0,#2
        STR	 R0,R2,#1
        ADD  R0,R0,#2
        STR	 R0,R2,#2
        ADD  R0,R0,#2
        STR	 R0,R2,#3
        ADD  R0,R0,#2
        STR	 R0,R2,#4
        ADD  R0,R0,#2
        STR	 R0,R2,#5
        LD   R7,ptrSaveR7
        RET
ptrSaveR7     .BLKW	1
ASCII60     .FILL	x003C

COL     ST   R0,cSaveR0
        ST   R3,cSaveR3
        ;ST   R6,cSaveR6
        ST   R7,cSaveR7     
        AND  R3,R3,#0
        ;AND  R6,R6,#0
        AND  R4,R4,#0
        AND  R5,R5,#0
        ;ADD  R6,R6,R2
        LDI  R3,cSaveR3
        ADD  R3,R3,#0
        BRz  ECOL
        LDI  R0,cSaveR0
LOOPC   AND  R2,R2,#0
        LDR  R5,R0,#0
        ADD  R2,R5,R1
        BRzp  ECOL
        ;LD   R0,cSaveR0
        ADD  R0,R0,#-12
        ;ST   R0,cSaveR0
        ADD  R3,R3,#-1
        BRp  LOOPC
        AND  R3,R3,#0
        LDI  R3,cSaveR3
        ADD  R3,R3,#-1
        STI  R3,cSaveR3     ;Almaceno el valor del nuevo contador
        ADD  R4,R4,#1
FINCOL  LD   R0,cSaveR0
        ;LD   R6,cSaveR6
        LD   R7,cSaveR7
        RET
ECOL    AND  R0,R0,#0
        LD   R0,MSGET
        PUTS
        BR   FINCOL
cSaveR0 .BLKW	1
cSaveR3 .BLKW	1
;cSaveR6 .BLKW	1
cSaveR7 .BLKW	1

VERT    ST   R7,vSaveR7
        ST   R0,vSaveR0
        ST   R2,vSaveR2
        ;Recibo la dir de memoria del puntero
        ;Recibo el caracter a comparar en R1
        AND  R4,R4,#0
        ADD  R4,R4,#3
LOOPV   ADD  R0,R0,#12
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp FINVERT
        ADD  R4,R4,#-1
        BRp  LOOPV
FINVERT LD   R0,vSaveR0
        LD   R2,vSaveR2
        LD   R7,vSaveR7
        RET
vSaveR0 .BLKW	1
vSaveR2 .BLKW	1
vSaveR7 .BLKW	1

HORIZ   ST   R7,hSaveR7
        ST   R0,hSaveR0
        ST   R2,hSaveR2
        ST   R5,hSaveR5
        ST   R6,hSaveR6
RIGHT   AND  R4,R4,#0
        ADD  R4,R4,#3
        ST   R4,hSaveR4
        AND  R6,R6,#0
        ADD  R6,R6,#6
        NOT	 R5,R5
        ADD  R5,R5,#1       ;Ingreso el numero del usuario
        ADD  R6,R6,R5       ;Posibles movimientos a la derecha
        NOT	 R5,R5
        ADD  R5,R5,#2       ;Posibles movimientos a la izquierda
LOOPR   ADD  R6,R6,#-1
        BRnz LEFT
        ADD  R0,R0,#2
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp LEFT
        ADD  R4,R4,#-1
        ST   R4,hSaveR4
        BRp  LOOPR
        BRnz FINHORIZ
LEFT    LD   R0,hSaveR0
LOOPL   ADD  R5,R5,#-1
        BRnz FINHORIZ
        LD   R4,hSaveR4        
        ADD  R0,R0,#-2
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp FINHORIZ
        ADD  R4,R4,#-1
        ST   R4,hSaveR4
        BRp  LOOPL
FINHORIZ LD   R7,hSaveR7
        LD   R0,hSaveR0
        LD   R2,hSaveR2
        LD   R6,hSaveR6
        RET
hSaveR0 .BLKW	1
hSaveR2 .BLKW	1
hSaveR4 .BLKW	1
hSaveR5 .BLKW	1
hSaveR6 .BLKW	1
hSaveR7 .BLKW	1

DIAG    ST   R7,dSaveR7
        ST   R0,dSaveR0
        ST   R2,dSaveR2
        ST   R4,dSaveR4
        ST   R6,dSaveR6
        LD   R5,hSaveR5     ;col ingresada por el U
        AND  R4,R4,#0
        ADD  R4,R4,#3       ;Contador de fichas
        ST   R4,dSaveR4
        AND  R6,R6,#0
        ADD  R6,R6,#6
        NOT	 R5,R5
        ADD  R5,R5,#1       
        ADD  R6,R6,R5       ;Posibles movimientos a la derecha
        NOT	 R5,R5
        ADD  R5,R5,#2       ;Posibles movimientos a la izquierda
DIAGR1  ADD  R6,R6,#-1      ;DIAG SUPERIOR
        BRnz DIAGL2
        ADD  R0,R0,#-10
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp DIAGL2
        ADD  R4,R4,#-1
        ST   R4,dSaveR4
        BRp  DIAGR1
        BRnz FINDIAG
DIAGL2  LD   R0,dSaveR0
LOOPD   ADD  R5,R5,#-1
        BRnz DIAGR2
        LD   R4,dSaveR4
        ADD  R0,R0,#10
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp DIAGR2
        ADD  R4,R4,#-1
        ST   R4,dSaveR4
        BRp  LOOPD
        BRnz FINDIAG
        ;;;;;;;;;;;;;;;;;;;;;;;; Vuelvo y cargp los valores
DIAGR2  LD   R0,dSaveR0
        LD   R5,hSaveR5     ;col ingresada por el U
        AND  R4,R4,#0
        ADD  R4,R4,#3       ;Contador de fichas
        ST   R4,dSaveR4
        AND  R6,R6,#0
        ADD  R6,R6,#6
        NOT	 R5,R5
        ADD  R5,R5,#1       
        ADD  R6,R6,R5       ;Posibles movimientos a la derecha
        NOT	 R5,R5
        ADD  R5,R5,#2       ;Posibles movimientos a la izquierda
        ;;;;;;;;;;;
LOOPD2  ADD  R6,R6,#-1      ;DIAG INF
        BRnz DIAGL1
        ADD  R0,R0,#14
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp DIAGL1
        ADD  R4,R4,#-1
        ST   R4,dSaveR4
        BRp  LOOPD2
        BR   FINDIAG
DIAGL1  LD   R0,dSaveR0
LOOPD1  ADD  R5,R5,#-1
        BRnz FINDIAG
        LD   R4,dSaveR4
        ADD  R0,R0,#-14
        AND  R3,R3,#0
        ;LDR  R0,R0,#0     ;Cargo la dir de memoria de la matriz
        LDR  R2,R0,#0       ;Cargo el valor de esa posicion
        ADD  R3,R2,R1     ;Si es cero disminuyo el contador
        BRnp FINDIAG
        ADD  R4,R4,#-1
        ST   R4,dSaveR4
        BRp  LOOPD1
FINDIAG LD   R0,dSaveR0
        LD   R2,dSaveR2
        LD   R4,dSaveR4
        LD   R6,dSaveR6
        LD   R7,dSaveR7
        RET
dSaveR0 .BLKW	1
dSaveR2 .BLKW	1
dSaveR4 .BLKW	1
dSaveR6 .BLKW	1
dSaveR7 .BLKW	1

MSG1    .STRINGZ	"\nJugador 1, seleccione columna: "
MSG2    .STRINGZ	"\nJugador 2, seleccione columna: "
LF      .STRINGZ	"\n"
MSGE    .STRINGZ	"\nMovimiento invalido. Intente de nuevo"
WIN1    .STRINGZ	"\nJugador 1 Gana"
WIN2    .STRINGZ	"\nJugador 2 Gana"
TIE     .STRINGZ	"\nEmpate"
ASCII0  .FILL	    xFFD0   ;-48
ASCII5 .FILL	    xFFCB   ;-53
ASCIIO  .FILL	xFFB1
ASCIIX  .FILL	xFFA8
PLAYER1 .FILL	x004F
PLAYER2 .FILL	x0058
CONT1   .BLKW	1
CONT2   .BLKW	1
CONTCOL0 .FILL	6
CONTCOL1 .FILL	6
CONTCOL2 .FILL	6
CONTCOL3 .FILL	6
CONTCOL4 .FILL	6
CONTCOL5 .FILL	6
PTR0    .BLKW	1
PTR1    .BLKW	1
PTR2    .BLKW	1
PTR3    .BLKW	1
PTR4    .BLKW	1
PTR5    .BLKW	1

MATRIZ  
.FILL x002D .FILL x0020 .FILL x002D .FILL x0020 .FILL  x002D .FILL	x0020  .FILL  x002D .FILL  x0020  .FILL  x002D 
.FILL  x0020 .FILL	x002D  .FILL  x000A           
.FILL x002D .FILL x0020 .FILL x002D .FILL x0020 .FILL  x002D .FILL  x0020  .FILL  x002D .FILL  x0020  .FILL  x002D 
.FILL  x0020 .FILL	x002D  .FILL  x000A
.FILL x002D .FILL x0020 .FILL x002D .FILL x0020 .FILL  x002D .FILL  x0020  .FILL  x002D .FILL  x0020  .FILL  x002D 
.FILL  x0020  .FILL	x002D  .FILL  x000A 
.FILL x002D .FILL x0020 .FILL x002D .FILL x0020 .FILL  x002D .FILL  x0020  .FILL  x002D .FILL  x0020  .FILL  x002D 
.FILL  x0020  .FILL	x002D  .FILL  x000A   
.FILL x002D .FILL x0020 .FILL x002D .FILL x0020 .FILL  x002D .FILL  x0020  .FILL  x002D .FILL  x0020  .FILL  x002D 
.FILL  x0020  .FILL	x002D  .FILL  x000A   
.FILL x002D .FILL x0020 .FILL x002D .FILL x0020 .FILL  x002D .FILL  x0020  .FILL  x002D .FILL  x0020  .FILL  x002D 
.FILL  x0020  .FILL	x002D  
        
        .END

