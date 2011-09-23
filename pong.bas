DECLARE SUB bye ()
DECLARE SUB intro ()
DECLARE SUB win (e$)
DECLARE SUB directions ()
DECLARE SUB about ()
DECLARE SUB game ()

' ******************
' * PONG! v1.0     *
' * By Luke Macken *
' *                *
' * geek@nofx.com  *
' *                *
' ******************

RANDOMIZE TIMER
CALL intro
CALL bye

SUB about
  CLS
  LINE (55, 15)-(280, 20), 8, BF
  LINE (55, 15)-(280, 120), 7, B
  LOCATE 5, 18: PRINT "About"
  LOCATE 7, 9: PRINT "Pong! v1.0 was programmed"
  LOCATE 8, 9: PRINT "by Luke Macken. If you have"
  LOCATE 9, 9: PRINT "any questions or comments, "
  LOCATE 10, 9: PRINT "please email them to:"
  LOCATE 12, 9: PRINT "     geek@nofx.com"
  COLOR 7
  LOCATE 14, 18: PRINT "< Ok >"
  COLOR 15
  DO
    a$ = INKEY$
  LOOP WHILE a$ = ""
  CALL intro
END SUB

SUB bye
  CLS
  LINE (100, 75)-(210, 80), 8, BF
  LINE (100, 75)-(210, 120), 7, B
  LOCATE 13, 17: PRINT "Bye! "; CHR$(1)
  END
END SUB

SUB directions
  CLS
  LINE (80, 15)-(240, 20), 8, BF
  LINE (80, 15)-(240, 120), 7, B
  LOCATE 5, 16: PRINT "Directions"
  LOCATE 7, 13: PRINT CHR$(24); " - Up"
  LOCATE 8, 13: PRINT CHR$(25); " - Down"
  LOCATE 9, 13: PRINT "Objective: To Hit"
  LOCATE 10, 13: PRINT "the ball with the"
  LOCATE 11, 13: PRINT "paddle."
  COLOR 7
  LOCATE 14, 18: PRINT "< Ok >"
  COLOR 15
  DO
    a$ = INKEY$
  LOOP WHILE a$ = ""
  CALL intro
END SUB

SUB game
CLS
INPUT "Enter your name: ", Name$
PRINT
PRINT
INPUT "Press any key to start..", dummy

Begin:
CLS
ballcolor = INT(15 * RND + 1)
padspeed = 15
speed = 500
padcol = 15
padrow = 100
padlen = 50
row = INT(195 * RND + 5)
col = 10
PRINT USING "\      \ ::   PONG   ::   Score: ######"; Name$; speed - 500

' Draw Border
LINE (1, 10)-(1, 200)
LINE (1, 10)-(320, 10)
LINE (319, 10)-(319, 200)
LINE (1, 199)-(319, 199)

start:
LINE (5, padrow)-(10, padrow + padlen), padcol, B
DO
  IF col > 312 THEN
    c = 1
  ELSEIF col < 8 THEN
    c = 2
  END IF
 
  IF row > 193 THEN
    r = 1
  ELSEIF row < 21 THEN
    r = 2
  END IF

  IF c = 0 THEN col = col + 1
  IF c = 1 THEN col = col - 1
  IF c = 2 THEN col = col + 1
  IF r = 0 THEN row = row - 1
  IF r = 1 THEN row = row - 1
  IF r = 2 THEN row = row + 1
  CIRCLE (col, row), 5, ballcolor

  ' Redraw Paddle
  LINE (5, padrow)-(10, padrow + padlen), padcol, B

  IF c = 1 AND col = 8 THEN
     BEEP: BEEP: BEEP: BEEP
     CLS
     LINE (1, 10)-(1, 200)
     LINE (1, 10)-(320, 10)
     LINE (319, 10)-(319, 200)
     LINE (1, 199)-(319, 199)
     PRINT USING "\      \ ::   PONG   ::   Score: ######"; Name$; speed - 500
     GOTO Die
  END IF

  IF col = 15 AND c = 1 THEN
    FOR x = padrow TO padrow + padlen
      IF row = x AND c = 2 THEN
        c = 1
      END IF
    NEXT x
  END IF
  IF col = 15 AND c = 1 THEN
    FOR x = padrow TO padrow + padlen
      IF row = x AND c = 1 THEN
        c = 2
        speed = speed - 20
        ballcolor = INT(15 * RND + 1)
        CLS
        score = score + 10
        LINE (1, 10)-(1, 200)
        LINE (1, 10)-(320, 10)
        LINE (319, 10)-(319, 200)
        LINE (1, 199)-(319, 199)
        PRINT USING "\      \ ::   PONG   ::   Score: ######"; Name$; score
      END IF
    NEXT x
  END IF

  FOR delay = 1 TO speed
  NEXT delay
 
  CIRCLE (col, row), 5, 0

  a$ = INKEY$
LOOP WHILE a$ = ""

IF a$ = CHR$(119) THEN
  IF padrow < 16 THEN GOTO start
  LINE (5, padrow)-(10, padrow + padlen), 0, B
  padrow = padrow - padspeed
  LINE (5, padrow)-(10, padrow + padlen), padcol, B
  GOTO start
ELSEIF a$ = CHR$(115) THEN
  IF padrow + padlen > 193 THEN GOTO start
  LINE (5, padrow)-(10, padrow + padlen), 0, B
  padrow = padrow + padspeed
  LINE (5, padrow)-(10, padrow + padlen), padcol, B
  GOTO start
ELSEIF a$ = CHR$(113) THEN
  CALL bye
ELSE
  GOTO start
END IF

Die:
CLS
LINE (100, 75)-(220, 80), 8, BF
LINE (100, 75)-(220, 120), 7, B
LOCATE 12, 17: PRINT "GAME OVER"
LOCATE 13, 16: PRINT USING "Score: ###"; score
LOCATE 14, 16: PRINT "Play again?"
loopy:
DO
  p$ = INKEY$
LOOP WHILE p$ = ""

IF p$ = CHR$(121) THEN
    CLS
    speed = 500
    score = 0
    LINE (1, 10)-(1, 200)
    LINE (1, 10)-(320, 10)
    LINE (319, 10)-(319, 200)
    LINE (1, 199)-(319, 199)
    PRINT USING "\      \ ::   PONG   ::   Score: ######"; Name$; score
ELSEIF p$ = CHR$(110) THEN
  CALL bye
ELSE
    GOTO loopy
END IF
GOTO start
END SUB

SUB intro
CLS
DIM m$(1 TO 4)
SCREEN 7
LINE (100, 15)-(220, 20), 8, BF
LINE (100, 15)-(220, 80), 7, B
LOCATE 4, 16: PRINT "PONG! v1.0"
LINE (120, 32)-(198, 32)
m$(1) = "New Game"
m$(2) = "Directions"
m$(3) = "About"
m$(4) = "Quit"
asel = 6
DO
  DO
    a$ = INKEY$
    d = 6
    COLOR 4
    LOCATE asel, 15: PRINT CHR$(26)
    COLOR 15
    FOR x = 1 TO 4
      LOCATE d, 16: PRINT m$(x)
      d = d + 1
    NEXT x
  LOOP WHILE a$ = ""
  IF a$ = CHR$(0) + CHR$(80) THEN
    COLOR 0
    LOCATE asel, 15: PRINT CHR$(26)
    COLOR 15
    asel = asel + 1
    IF asel = 10 THEN asel = 6
  ELSEIF a$ = CHR$(0) + CHR$(72) THEN
    COLOR 0
    LOCATE asel, 15: PRINT CHR$(26)
    COLOR 15
    asel = asel - 1
    IF asel = 5 THEN asel = 9
  ELSEIF a$ = CHR$(13) THEN
    sel = asel
  ELSE
    PRINT "ELSE"
  END IF
LOOP WHILE sel = 0
SELECT CASE sel
  CASE IS = 6
    CALL game
  CASE IS = 7
    CALL directions
  CASE IS = 8
    CALL about
  CASE IS = 9
    CALL bye
  CASE ELSE
    e$ = "Unknown Selection"
    CALL win(e$)
END SELECT
END SUB

SUB win (e$)
  CLS
  LINE (80, 15)-(240, 20), 8, BF
  LINE (80, 15)-(240, 80), 7, B
  LOCATE 5, 18: PRINT "ERROR"
  LOCATE 7, 13: PRINT e$
  DO
    a$ = INKEY$
  LOOP WHILE a$ = ""
END SUB

