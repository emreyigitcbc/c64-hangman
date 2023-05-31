10 rem start screen
20 RS = 0 : rem fast-restart checker
30 print chr$(147)
40 print "{clear}{white}"
50 poke 53269, 0 : rem all sprites off
60 poke 53276, 255 : rem multicolor on
70 poke 53277, 255 : rem all sprites double x on
80 poke 53271, 255 : rem all sprites double y on
90 poke 53281, 0 : rem background to black
100 if RS = 1 THEN GOTO 180
110 FOR I = 0 TO 383: read y: POKE 12800+I, y:next : rem load all sprites to mem
120 poke 2040, 200 : rem set pointers
130 poke 2041, 201
140 poke 2042, 202
150 poke 2043, 203
160 poke 2044, 204
170 poke 2045, 205
180 DY = 1 : DX = 7
190 gosub 1640
200 print "hangman v1.0 - emre cebeci"
210 DY = 7 : DX = 14
220 gosub 1640
230 print "press any key to start"
240 gosub 1550
250 poke 53269, 255
260 v=53248
270 pokev+37, 15 : pokev+38,10
280 pokev, 82 : pokev+1, 72 : rem head
290 pokev+2, 78 : pokev+3, 92 : rem body
300 pokev+4, 108 : pokev+5, 98  : rem right arm
310 pokev+6, 68 : pokev+7, 98 : rem left arm
320 pokev+8, 78 : pokev+9, 128 : rem left leg
330 pokev+10, 102 : pokev+11, 128 : rem right leg
340 get a$ : if a$ = "" then 340
350 print "{clear}{white}"
360 poke 53269, 0 : rem all sprites off
370 gosub 1550 : rem scaffold print
380 DY = 7 : DX = 0
390 gosub 1640
400 print tab(20)"{up}select a character"
410 for i = 66 to 91 : print TAB(20)chr$(i-1)"{right}";
420 if i / 5 =INT(i/5) then print""
430 next i
440 rem pick a random word
450 if RS = 1 then goto 500
460 dim WD$(100) : dim WC$(100) : dim CW$(100)
461 WD$(0) = "america"
462 WD$(1) = "turkey"
463 WD$(2) = "minecraft"
464 WD$(3) = "trump"
465 WD$(4) = "butterfly"
466 WD$(5) = "hangman"
500 W$=WD$(INT(rnd(0) * 5))
510 DY = 18 : DX = 6
520 gosub 1640
530 for i = 0 to len(W$)-1
540 WC$(i) = MID$(W$,i+1, 1)
550 CW$(i) = chr$(102)
560 printchr$(102)" ";: next i
570 DY = 7 : DX = 20
580 gosub 1640
590 A$="": B$="": A=0 : TC=0:C=0
600 poke 204, 0
610 GET A$: IF A$="" THEN 610
620 A=ASC(A$)
630 CR = 1024+DY*40+DX : rem get current cursor pos
640 IF A = 145 THEN DY = DY - 1 : rem handle ARROW BUTTONS
650 IF A = 29 THEN DX = DX + 2
660 IF A = 157 THEN DX = DX - 2
670 IF A = 17 THEN DY = DY + 1
680 IF DY > 12 THEN DY = 12
690 IF DY < 7 THEN DY = 7
700 IF DX > 28 THEN DX = 28
710 IF DX < 20 THEN DX = 20
720 poke 204, 1
730 IF peek(CR) - 128 > 0 then poke CR, peek(CR)-128 : rem fix reversed chars
740 IF A = 13 and not peek(CR) = 32 THEN GOTO 770 : rem check for enter
750 gosub 1640
760 goto 600
770 TP = 0: CP = 1 : rem TP check if chr changed CP check for finished
780 if peek(CR) - 128 > 0 then goto 600 : rem dont do action
790 FOR N = 0 TO len(W$)
800 if WC$(N) = CHR$(PEEK(CR)+64) THEN CW$(N) = CHR$(PEEK(CR)+64) : TP = 1
810 if NOT CW$(N) = WC$(N) THEN CP = 0
820 NEXT N : TM = 1
830 if NOT TP = 1 THEN C = C + 1 : rem increase fail count by 1
840 FOR I = 0 TO C-1 : TM = TM * 2 : NEXT I
850 if NOT TC = C THEN POKE 53269, TM-1
860 if C = 6 THEN GOTO 940
870 TC = C
880 DY = 18 : DX = 6 : GOSUB 1640
890 for i = 0 to len(W$) : print CW$(i)" ";: next i
900 IF CP = 1 THEN GOTO 1100
910 DY = 7 : DX = 20 : gosub 1640
920 poke CR, 32
930 goto 600
940 rem lose
950 poke 646, 1
960 X$="you lose, word was"
970 DX=0 : DY = 13 : GOSUB 1640
980 for i = 0 to 4
990 for j = 0 to 39 : print "{reverse on}{sh space}"; : next j
1000 next i
1010 DX=INT(LEN(X$)/2) : DY = 14 : GOSUB 1640
1020 print "{white}"X$"{down}"
1030 DY = 15 : GOSUB 1640
1040 print W$"{reverse off}{down}"
1050 DY=16 : GOSUB 1640
1060 print "press any key to restart"
1070 GET A$: IF A$="" THEN 1070
1080 RS = 1
1090 goto 30
1100 rem win
1110 poke 646, 5
1120 poke 53269, peek(53269) and 15
1130 X$="you won!"
1140 DX=0 : DY = 13 : GOSUB 1640
1150 for i = 0 to 3
1160 for j = 0 to 39 : print "{reverse on}{sh space}"; : next j
1170 next i
1180 DX=INT(LEN(X$)/2) : DY = 14 : GOSUB 1640
1190 print "{white}"X$"{down}"
1200 DY = 15 : GOSUB 1640
1210 print "press any key to restart"
1220 GET A$: IF A$="" THEN 1220
1230 RS = 1
1240 goto 30
1250 data 63,192,0,255,240,0,192,48,0,208,112,0,208,112,0
1260 data 192,48,0,197,48,0,192,48,0,240,240,0,63,192,0
1270 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1280 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1290 data 0,0,0,0
1300 data 3,192,0,3,192,0,5,80,0,85,85,0,85,85,0
1310 data 85,85,0,85,85,0,85,85,0,85,85,0,85,85,0
1320 data 85,85,0,85,85,0,85,85,0,85,85,0,85,85,0
1330 data 85,85,0,85,85,0,85,85,0,85,85,0,0,0,0
1340 data 0,0,0,0
1350 data 80,0,0,84,0,0,84,0,0,84,0,0,20,0,0
1360 data 20,0,0,20,0,0,20,0,0,60,0,0,60,0,0
1370 data 60,0,0,60,0,0,60,0,0,60,0,0,60,0,0
1380 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1390 data 0,0,0,0
1400 data 20,0,0,84,0,0,84,0,0,84,0,0,80,0,0
1410 data 80,0,0,80,0,0,80,0,0,240,0,0,240,0,0
1420 data 240,0,0,240,0,0,240,0,0,240,0,0,240,0,0
1430 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1440 data 0,0,0,0
1450 data 80,0,0,80,0,0,80,0,0,80,0,0,80,0,0
1460 data 80,0,0,80,0,0,80,0,0,240,0,0,240,0,0
1470 data 240,0,0,240,0,0,240,0,0,240,0,0,240,0,0
1480 data 240,0,0,240,0,0,240,0,0,240,0,0,0,0,0
1490 data 0,0,0,0
1500 data 80,0,0,80,0,0,80,0,0,80,0,0,80,0,0
1510 data 80,0,0,80,0,0,80,0,0,240,0,0,240,0,0
1520 data 240,0,0,240,0,0,240,0,0,240,0,0,240,0,0
1530 data 240,0,0,240,0,0,240,0,0,240,0,0,0,0,0
1540 data 0,0,0,0
1550 rem print scaffold
1560 DY = 2 : DX = 3
1570 gosub 1640
1580 print chr$(111)chr$(183)chr$(183)chr$(183)chr$(183)chr$(112)
1590 for i = 1 to 15
1600 print "{right}{right}{right}"chr$(244)
1610 next i
1620 print "{right}{right}"chr$(206)chr$(205)
1630 return
1640 poke 214, DY
1650 poke 211, DX
1660 sys 58732
1670 return