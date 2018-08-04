
;; Nachslagwerk:
;#############################################

mov A, #0254d	;Akku laden mit Const
mov R7, #01h	;Register laden mit Const
mov 50h, #023o	;Adr laden mit Const
nop

mov A, R7	;Register in Akku laden
mov R0, A	;Akku in Register laden
mov A, 50h	;Adr in Akku laden
mov 51h, A	;Akku in Adr laden
mov R1, 51h	;Adr in Register laden
mov 52h, R1	;Register in Adr laden
mov 53h, 54h	;Adr in Adr laden


mov R0, #054h	;Zieladresse/Quelladresse - for demo purpose
mov R1, #055h	;Zieladresse/Quelladresse - for demo purpose
mov A, @R0	;Data@Adr R0/R1 in Akku laden 
mov @R1, A	;Akku in Data@Adr R0/R1 laden 
mov 56h, @R1	;Data@Adr R0/R1 in Adr laden 
mov @R1, #042d	;Const in Data@Adr R0/R1 laden 
mov @R0, 55h	;Adr in Data@Adr R0/R1 laden 

push 55h	;Push Adr
pop 57h		;Pop Adr

nop		;No operation
setb C		;Set C - for demo purpose
mov 50h, C	;Carry in BAdr laden
mov C, 51h	;BADr in Carry laden
mov dptr, #0FFAAh ;16Const in DPTR laden

XCH A, R0	;Tausche Akku mit Register
XCH A, 55h	;Tausche Akku mit Adr
XCH A, @R0	;Tausche Akku mit Data@Adr R0/R1
XCHD A, @R1	;Tausche Akku mit Data@Adr R0/R1 NUR LOW-Nibble!
MovX A, @R0	;EXT Data@Adr R0/R1 in Akku laden
MovX @R1, A	;Akku in EXT Data@Adr R0/R1  laden

movX A, @DPTR	;EXT Data@Adr in Akku laden
movX @DPTR, A	; Akku in EXT Data@Adr laden

movC A, @A+DPTR	;Const aus EEPROM in Akku laden
movC A, @A+PC	;Const aus EEPROM in Akku laden

;#############################################

clr A		;Akku leeren
cpl A		;Komplement des Akku
Inc A		;Akku++
INC R0		;Register++
INC 57h		;Adr++
INC DPTR	;DPTR++

 
 
INC @R1		;Data@Adr R0/R1++

DEC A		;Akku--
DEC R0		;Register--
DEC 56h		;Adr--	

DEC @R1		;Data@Adr R0/R1--

ADD A, #042d	;Akku + Const
AddC A, #042d	;Akku + Const + Carry
Add A, R4	;Akku + Register
AddC A, R4	;Akku + Register + Carry
Add A, 052h	;Akku + Adr
AddC A, 052h	;Akku + Adr + Carry

Add A, @R0	;Akku + Data@Adr R0/R1
AddC A, @R0	;Akku + Data@Adr R0/R1 + Carry

Subb A, #042d	;Akku - Const - Carry
Subb A, 052h	;Akku - Adr - Carry
Subb A, R5	;Akku - Register - Carry
Subb A, @R1	;Akku - Data@Adr R0/R1 - Carry

Swap A		;Tausche Low gegen High-Nibble
Mul AB		;BA = A * B
DIV AB		;AB = A / B  (B ist der rest)

RL A		;Rotiere nach links (bit 7 in bit0)
RLC A		;Rotiere nach links mit carry (carry in bit0)
RR A		;Rotiere nach Rechts (bit0 in bit7)
RRC A		;Rotiere nach rechts mit carry (bit0 in carry)

SetB C		;Setze Carry 1
CLR C		;leere Carry
CPL C		;Komplement vom Carry

SetB 042h	;Setze BAdr auf 1
CLR 042h	;Leere BAdr
CPL 042h	;Komplement der BAdr


;####################################################

ANL A, #042d	;Akku Bitweises Und mit Const
ANL A, R5	;Akku Bitweises Und mit Register
ANL A, 050h	;Akku Bitweises Und mit Adr
ANL 051h, #042d	;Adr Bitweises Und mit Const
ANL 051h, A	;Adr Bitweises Und mit Akku
ANL C, 042h	;Carry Bitweises Und mit BAdr
ANL C, /042h	;Carry Bitweises Und mit invertiertem BAdr 

ANL A, @R0	;;Akku Bitweises Und mit Data@Adr R0/R1

ORL A, #042d	;Akku Bitweises Oder mit Const
ORL 051h, #042d	;Adr Bitweises Oder mit Const
ORL A, R0	;Akku Bitweises Oder mit Register
ORL A, 051h	;Akku Bitweises Oder mit Adr
ORL 051h, A	;Adr Bitweises Oder mit Akku
ORL C, 042h	;Carry Bitweises Oder mit BAdr
ORL C, /042h	;Carry Bitweises Oder mit invertiertem BAdr

ORL A, @R0	;Akku Bitweises Oder mit Data@Adr R0/R1

XRL A, #042d	;Akku Bitweises XOR mit Const
XRL 051h, #042d	;Adr Bitweises XOR mit Const
XRL A, R0	;Akku Bitweises XOR mit Register
XRL A, 042h	;Akku Bitweises XOR mit Adr
XRL 042h, A	;Adr Bitweises XOR mit Akku

XRL A, @R0	;Akku Bitweises XOR mit Data@Adr R0/R1


;####################################################


LJmp label1 	;long jump 16bit
nop
label1:

sjmp relativ1	;relativer jump 8bit
nop
relativ1:

ajmp next1	;short jump 11bit
nop
next1:

mov DPTR, #calc1
mov A, #0h
jmp @A+DPTR	;Brechneter jump
nop
calc1:

JBC 042d, bc1	;springe bei gesetzer BAdr und lösche es
nop
bc1:

JB 042d, bc2	;springe bei gesetzer BAdr
nop
bc2:

JNB 042d, bc3	;springe bei nicht gesetzer BAdr
nop
bc3:

Jc carry1	;Springe bei gesetztem carry
nop
carry1:

Jnc carry2	;Springe bei nicht gesetztem carry
nop
carry2:

Jz akku1	;Springe wenn akku = 0
nop
akku1:

Jnz akku2	;Springe wenn akku nicht = 0
nop
akku2:

DJnz R0, reg0	;Register--; Springe wenn register nicht = 0
nop
reg0:

DJnz 053h, adr0	;Adr--; Springe wenn register nicht = 0
nop
adr0:

CJNE A, #024d, akku3	;vergleiche Akku mit Const
nop
akku3:

CJNE R0, #024d, reg1	;vergleiche Register mit Const
nop
reg1:

CJNE A, 042h, akku4	;vergleiche Akku mit Adr
nop
akku4:

CJNE @R0, #024d, ref0	;vergleiche Data@Adr R0/R1 mit Const
nop
ref0:

LCALL lol	;long call -- ACall = short call
LJMP endtag

lol:
ret		;reti for interrupt


endtag:
nop


