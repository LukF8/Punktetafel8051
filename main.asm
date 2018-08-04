;Anzeigetafel
;Minuten und Sekunden anzeige für ein Fußballspiel (Port0)
;Punkte Anzeige für jedes Team  (Port1)
;
;7Seg  ultiplexed über Port2:
; Pin 0-1 für Sekunden
; Pin 2-3 für Minuten
; Pin 4-5 für rechtes Team
; Pun 6-7 für linkes Team
;
;Funktionstasten (Port3; Pinbelegung wie aufgelistet):
;Start Timer, Pause Timer, (opt. Reset Timer,) Punkte Links++, Punkte Rechts++, Punkte Links--, Punkte Rechts--, Game Reset
;Optional eine Hupe für ein erziehltes Tor


Count2 Equ 69h	;Counter 2  bis 195
Count1 Equ 68h	;Counter 1  bis 250

MH Equ 67h
ML Equ 66h	;Minuten
SH Equ 65h
SL Equ 64h	;Sekunden

PLH Equ 63h
PLL Equ 62h	;Punkte Links
PRH Equ 61h
PRL Equ 60h	;Punkt Rechts

; Knöpfe
StartT Equ P3.0
PauseT Equ P3.1
PunkteLP Equ P3.2
PunkteRP Equ P3.3
PunkteLM Equ P3.4
PunkteRM Equ P3.5
ResetGame Equ P3.6

sStartT Equ 2Fh.0
sPauseT Equ 2Fh.1
sPunkteLP Equ 2Fh.2
sPunkteRP Equ 2Fh.3
sPunkteLM Equ 2Fh.4
sPunkteRM Equ 2Fh.5
sResetGame Equ 2Fh.6



org 0h
ljmp init




;########################################
;	Timer 0 Interrupt
;----------------------------------------
org 0Bh	;Timer 0 Interrupt
ljmp timerrutine







;########################################
;	INIT
;----------------------------------------
org 30h		;interrupts überspringen
init:
;mov SP, #30h

; H = High Bit, L = Low Bit
mov PLH, #00d 
mov PLL, #00d
mov PRH, #00d
mov PRL, #00d

mov MH, #00d
mov ML, #00d
mov SH, #00d
mov SL, #00d

mov COUNT1, #00d
mov count2, #00d

setb EA		;Enable all Interrupts
setb ET0	;Enable Timer Interrupt
mov TMOD, #00000010b	;Enable 8 bit mod

mov TL0, #07d	;Laden des Timers mit 0 -> 250 Ticks bis überlauf -> 48000 rounds for 1sec
;250 * 250 * 192 = 1sec
mov TH0, #07d





ljmp main
;########################################





;########################################
;	Main loop
;----------------------------------------
main:
call zeigeAlleSemente

;Check button press
JB StartT, noStartT
setb sStartT  
noStartT:  
JB PauseT, noPauseT
setb sPauseT 
noPauseT:  
JB PunkteLP, noPunkteLP
setb sPunkteLP 
noPunkteLP: 
JB PunkteRP, noPunkteRP
setb sPunkteRP  
noPunkteRP:
JB PunkteLM, noPunkteLM
setb sPunkteLM  
noPunkteLM:
JB PunkteRM, noPunkteRM
setb sPunkteRM   
noPunkteRM:
JB ResetGame, noResetGame
setb sResetGame  
noResetGame:


 


nop


;checkbuttonPressed
JNB sStartT, notStartT
JNB StartT, notStartT
;StartT pressed

setb TR0	;start timer

clr sStartT  
notStartT:

JNB sPauseT, notPauseT
JNB PauseT, notPauseT
;PauseT pressed

clr TR0	;stop timer

clr sPauseT  
notPauseT:

JNB sPunkteLP, notPunkteLP
JNB PunkteLP, notPunkteLP
;PunkteLP pressed

mov R0, #062h		;Links
mov R1, #00d
call countupPunkte


clr sPunkteLP  
notPunkteLP:
 
JNB sPunkteRP, notPunkteRP
JNB PunkteRP, notPunkteRP
;PunkteRP pressed

mov R0, #060h		;Recht
mov R1, #00d
call countupPunkte

clr sPunkteRP  
notPunkteRP:

JNB sPunkteLM, notPunkteLM
JNB PunkteLM, notPunkteLM
;PunkteLM pressed

mov R0, #062h		;Links
mov R1, #01d
call countupPunkte

clr sPunkteLM  
notPunkteLM:
 
JNB sPunkteRM, notPunkteRM
JNB PunkteRM, notPunkteRM
;PunkteRM pressed

mov R0, #060h		;Recht
mov R1, #01d
call countupPunkte

clr sPunkteRM  
notPunkteRM:

JNB sResetGame, notResetGame
JNB ResetGame, notResetGame
;ResetGame pressed

mov PLH, #00d
mov PLL, #00d
mov PRH, #00d
mov PRL, #00d

mov MH, #00d
mov ML, #00d
mov SH, #00d
mov SL, #00d

clr TR0	;stop timer

mov TL0, #07d	 
mov TH0, #07d
mov COUNT1, #00d
mov count2, #00d


clr sResetGame  
notResetGame:
   
ljmp main
;########################################





;########################################
;	Count Up Punkte
;	Zähle Punkte um 1 hoch oder 1 runter
; 	R0 steht für Pointer zu PRL oder PLL
;	R1 steht für: 0 = hoch ; 1 = runter
;----------------------------------------
countupPunkte: 	
push 00h
push 01h
cjne R1, #00d, runtercount
;Count Hoch
INC @R0
cjne @R0, #010d, fertigcountPunkte
mov @R0, #00d
INC R0
INC @R0
cjne @R0, #10d, fertigcountPunkte
mov @R0, #00d
DEC R0
mov @R0, #00d 
ljmp fertigcountPunkte 


runtercount:
;Count Runter
DEC @R0
cjne @R0, #0FFh, fertigcountPunkte
mov @R0, #09d
INC R0
DEC @R0
cjne @R0, #0FFh, fertigcountPunkte
mov @R0, #09d
DEC R0
mov @R0, #09d  

 
fertigcountPunkte: 
pop 01h
pop 00h
ret

;########################################







;########################################
;	Count Up Time
;	Zähle Zeit um 1 hoch
;----------------------------------------
countup:
;Prüfe ob 60Min. bereits erreicht ist
mov A, MH
cjne A, #06d, notfertig
mov A, ML
cjne A, #00d, notfertig
mov A, SH
cjne A, #00d, notfertig
mov A, SL
cjne A, #00d, notfertig
ljmp fertigcount			;60min bereits erreicht
notfertig:			;60min nicht erreicht
;Sekunden Low ++
mov A, SL
INC A
cjne A, #010d, fertigSL
mov SL, #00d
mov A, SH
INC A
cjne A, #06d, fertigSH
mov SH, #00d
mov A, ML
INC A
cjne A, #10d, fertigML
mov ML, #00d
mov A, MH
INC A
ljmp fertigMH 

fertigSL:
mov SL, A
ljmp fertigcount
fertigSH:
mov SH, A
ljmp fertigcount
fertigML:
mov ML, A
ljmp fertigcount
fertigMH:
mov MH, A
ljmp fertigcount
fertigcount:
ret

;########################################




;########################################
;	Anzeigen Loop
;	Alle 7Sementanzeigen werden mit ihren Werten beladen
;----------------------------------------
zeigeAlleSemente:
push 00h	;Sichere R0
push 01h	;Sichere R1	
push 02h	;Sichere R2	
mov R0, #00d	;aktuelles segment
mov R1, #00d	;Pointer für wert von segment

mov A, #01d
cpl A
mov R2, A	;selectiertes segment... wird rotiert

;clear all 7segs 
mov P2, #00h
mov P0, #0FFh
mov P1, #0FFh
mov P2, #0FFh 

loopAlleSegmente:
CJNE R0, #08d, doFuerSegment     ;für alle 8 segmente
pop 02h		;Wiederherstellen von R2
pop 01h		;Wiederherstellen von R1
pop 00h		;Wiederherstellen von R0
ret
 
doFuerSegment:
;	Lade Segment mit entsprechendem Wert
mov p2, R2	;aktivate segment mit P2
 

 
mov A, R0	;get wert für
;60h start adresse für die Sement werte s.o.
Add A, #060h	;aktuelles Segment?  
mov R1, A
mov A, @R1

mov dptr, #numbers	;hole richtigs 7Seg code
movc a,@a+dptr
mov p0, a	;gib 7seg code auf P0 aus
mov p1, a	;gib 7seg code auf P1 aus

mov p2, #0FFh	;deaktivte 7Seg
mov p1, #0FFh	;deaktivte 7Seg
mov p0, #0FFh	;deaktivte 7Seg


; Select nächstes Segment 
mov A, R2
RL A
mov R2, A

;continue loop
Inc R0

ljmp loopAlleSegmente
;########################################



 


;########################################
;	Timer 0 Interrupt Rutine
;----------------------------------------
 
 timerrutine:

;timer * count1 * count2
;250 * 250 * 192 = 1sec


;1ms = 12000 ticks
;250 * 48 = 1ms
INC count1
mov A, count1
;cjne A, #250d, fertigtimer
;cjne A, #48d, fertigtimer
cjne A, #02d, fertigtimer	;fake ms for fake simulator

mov count1, #00d

;INC count2
;mov A, count2
;cjne A, #192d, fertigcount

;mov count2, #00d


call countup


fertigtimer:

 reti
 





;########################################
;	DATA
;----------------------------------------
org 400h
numbers:
db 11000000b
db 11111001b, 10100100b, 10110000b
db 10011001b, 10010010b, 10000010b
db 11111000b, 10000000b, 10010000b

end