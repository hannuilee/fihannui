*&---------------------------------------------------------------------*
*& Report ZRSUWON_215_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_04.

DATA : GV_CHAR1(10).

GV_CHAR1 = 'SUBROUTINE TEST'.

PERFORM TEST.

DATA : GV_CHAR2(10).

GV_CHAR2 = 'TEST111'.

WRITE : / GV_CHAR2.

PERFORM TEST2.

WRITE : / GV_CHAR2.

"USING + CHANGING + 선언
DATA : GV_NUM1 TYPE I,
       GV_NUM2 TYPE I,
       GV_RESULT1 TYPE I.

GV_NUM1 = 2.
GV_NUM2 = 3.

PERFORM CALCULATE1.

WRITE : / GV_RESULT1.

"LOCAL 변수
PERFORM CALCULATE2.

"PEFORM에 PERFORM
PERFORM CALCULATE3.

"PERFROM에 PERFORM +++ USING, CHANGING
PERFORM CALCULATE6.



"STRUCTURE 선언
DATA : BEGIN OF GS_DATA,
        CHAR1(10),
        CHAR2(10),
       END OF GS_DATA.

PERFORM STRUCTURE1.


"INTERNAL TABLE 선언
DATA : GT_DATA LIKE TABLE OF GS_DATA.
PERFORM INTERNAL_TABLE1.

"MACRO
DATA : GV_CHAR3(10),
       GV_CHAR4(10),
       GV_CHAR5(10).

DEFINE MACRO_WRITE.
  WRITE : / &1, &2, &3.
END-OF-DEFINITION.

GV_CHAR3 = 'A'.
GV_CHAR4 = 'B'.
GV_CHAR5 = 'C'.

MACRO_WRITE GV_CHAR3 GV_CHAR4 GV_CHAR5.

"PERFORM 응용
DATA : BEGIN OF GS_DATA2,
        NUM1 TYPE I,
        NUM2 TYPE I,
        RESULT TYPE I,
       END OF GS_DATA2.

DATA : GT_DATA2 LIKE TABLE OF GS_DATA2.

DATA : GV_VAR,
       GV_VAR2(10).

DATA : GV_CHAR6(10),
       GV_CHAR7(10),
       GV_CHAR8(10).

CLEAR GS_DATA2.
GS_DATA2-NUM1 = 1.
GS_DATA2-NUM2 = 3.
APPEND GS_DATA2 TO GT_DATA2.

CLEAR GS_DATA2.
GS_DATA2-NUM1 = 5.
GS_DATA2-NUM2 = 2.
APPEND GS_DATA2 TO GT_DATA2.

GV_VAR = '+'.
PERFORM INTERNAL_CAL TABLES GT_DATA2
                     USING GV_VAR
                     CHANGING GV_VAR2.

LOOP AT GT_DATA2 INTO GS_DATA2.
  GV_CHAR6 = GS_DATA2-NUM1.
  GV_CHAR7 = GS_DATA2-NUM2.
  GV_CHAR8 = GS_DATA2-RESULT.

  WRITE : / GV_CHAR6, GV_VAR2, GV_CHAR7, '=', GV_CHAR8.
ENDLOOP.


GV_VAR = '*'.
PERFORM INTERNAL_CAL TABLES GT_DATA2
                     USING GV_VAR
                     CHANGING GV_VAR2.

LOOP AT GT_DATA2 INTO GS_DATA2.
  GV_CHAR6 = GS_DATA2-NUM1.
  GV_CHAR7 = GS_DATA2-NUM2.
  GV_CHAR8 = GS_DATA2-RESULT.

  WRITE : / GV_CHAR6, GV_VAR2, GV_CHAR7, '=', GV_CHAR8.
ENDLOOP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""



DATA : GV_NUM3 TYPE I,
       GV_NUM4 TYPE I,
       GV_RESULT2 TYPE I.

CLEAR : GV_RESULT2.
CALL FUNCTION 'ZFC_SUWON_215_CAL'
  EXPORTING
    IV_NUM1         = 3
    IV_NUM2         = 2
    IV_CHAR         = '+'
 IMPORTING
   EV_RESULT       = GV_RESULT2.

WRITE : / GV_RESULT2.

GV_NUM3 = 4.
GV_NUM4 = 5.
CLEAR : GV_RESULT2.
CALL FUNCTION 'ZFC_SUWON_215_CAL'
  EXPORTING
    IV_NUM1         = GV_NUM3
    IV_NUM2         = GV_NUM4
    IV_CHAR         = '+'
 IMPORTING
   EV_RESULT       = GV_RESULT2.

WRITE : / GV_RESULT2.

GV_NUM3 = 4.
GV_NUM4 = 0.
CLEAR : GV_RESULT2.
CALL FUNCTION 'ZFC_SUWON_215_CAL'
  EXPORTING
    IV_NUM1         = GV_NUM3
    IV_NUM2         = GV_NUM4
    IV_CHAR         = '/'
 IMPORTING
   EV_RESULT       = GV_RESULT2
 EXCEPTIONS
   DIV_ZERO        = 1
   OTHERS          = 2.
IF SY-SUBRC <> 0.
  MESSAGE '0으로 나누었습니다.' TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.

WRITE : / GV_RESULT2.




DATA : GS_SFLIGHT1 LIKE SFLIGHT,
       GS_SFLIGHT2 LIKE SFLIGHT.

GS_SFLIGHT1-CARRID = 'AC'.

CALL FUNCTION 'ZFC_SUWON_215_SFLIGHT'
  EXPORTING
    IS_SFLIGHT       = GS_SFLIGHT1
 IMPORTING
   ES_SFLIGHT       = GS_SFLIGHT2.

WRITE : / GS_SFLIGHT2-CARRID,
        / GS_SFLIGHT2-CONNID.

DATA : GS_SFLIGHT3 LIKE SFLIGHT.

GS_SFLIGHT3-CARRID = 'AF'.

CALL FUNCTION 'ZFC_SUWON_215_SFLIGHT'
*  EXPORTING
*    IS_SFLIGHT       =
* IMPORTING
*   ES_SFLIGHT       =
  CHANGING
    CS_SFLIGHT       = GS_SFLIGHT3.

WRITE : / GS_SFLIGHT3-CARRID,
        / GS_SFLIGHT3-CONNID.

DATA : GT_SFLIGHT1 LIKE SFLIGHT OCCURS 0." WITH HEADER LINE.
DATA : GS_SFLIGHT4 LIKE SFLIGHT.

GS_SFLIGHT4-CARRID = 'LH'.

CALL FUNCTION 'ZFC_SUWON_215_SFLIGHT'
 EXPORTING
   IS_SFLIGHT       = GS_SFLIGHT4
   IV_CHAR          = 'X'
* IMPORTING
*   ES_SFLIGHT       =
 TABLES
   T_SFLIGHT        = GT_SFLIGHT1
* CHANGING
*   CS_SFLIGHT       =
          .

CL_DEMO_OUTPUT=>DISPLAY( GT_SFLIGHT1 ).

*LOOP AT GT_SFLIGHT1.
*  WRITE : / GT_SFLIGHT1-CARRID,
*          / GT_SFLIGHT1-CONNID.
*ENDLOOP.






*&---------------------------------------------------------------------*
*& Form TEST
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_CHAR
*&---------------------------------------------------------------------*
FORM TEST.

  WRITE : / GV_CHAR1.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form TEST2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GV_CHAR2
*&---------------------------------------------------------------------*
FORM TEST2.

  GV_CHAR2 = 'TEST222'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_NUM1
*&      --> GV_NUM2
*&      <-- GV_RESULT1
*&---------------------------------------------------------------------*
FORM CALCULATE1.

  GV_RESULT1 = GV_NUM1 + GV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_NUM1
*&      --> GV_NUM2
*&      <-- GV_RESULT1
*&---------------------------------------------------------------------*
FORM CALCULATE2.
  DATA : LV_RESULT TYPE I.

  LV_RESULT = GV_NUM1 + GV_NUM2.

  WRITE : / LV_RESULT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_NUM1
*&      --> GV_NUM2
*&      <-- GV_RESULT1
*&---------------------------------------------------------------------*
FORM CALCULATE3.
  DATA : LV_RESULT TYPE I.

  PERFORM CALCULATE4.

  PERFORM CALCULATE5 USING LV_RESULT.

  WRITE : / LV_RESULT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE4
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_NUM1
*&      --> GV_NUM2
*&---------------------------------------------------------------------*
FORM CALCULATE4.

*  LV_RESULT = GV_NUM1 + GV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE5
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LV_RESULT
*&---------------------------------------------------------------------*
FORM CALCULATE5  USING LV_RESULT.

  LV_RESULT = GV_NUM1 + GV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE6
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CALCULATE6 .

  DATA : LV_NUM1 TYPE I,
         LV_NUM2 TYPE I,
         LV_RESULT TYPE I.

  LV_NUM1 = 2.
  LV_NUM2 = 3.

  PERFORM CALCULATE7 USING LV_NUM1 LV_NUM2 LV_RESULT.

  WRITE : / LV_RESULT.

  PERFORM CALCULATE8 USING LV_NUM1 LV_NUM2
                     CHANGING LV_RESULT.

  WRITE : / LV_RESULT.

  PERFORM CALCULATE9 USING LV_NUM1 LV_NUM2
                     CHANGING LV_RESULT.

  WRITE : / LV_RESULT.

  PERFORM CALCULATE10 USING LV_NUM1 LV_NUM2
                      CHANGING LV_RESULT.

  WRITE : / LV_RESULT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE7
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LV_NUM1
*&      --> LV_NUM2
*&      --> LV_RESULT
*&---------------------------------------------------------------------*
FORM CALCULATE7  USING LV_NUM1
                       LV_NUM2
                       LV_RESULT.

  LV_RESULT = LV_NUM1 + LV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE8
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LV_NUM1
*&      --> LV_NUM2
*&      <-- LV_RESULT
*&---------------------------------------------------------------------*
FORM CALCULATE8  USING    LV_NUM1
                          LV_NUM2
                 CHANGING LV_RESULT.

  LV_RESULT = LV_NUM1 + LV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE9
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LV_NUM1
*&      --> LV_NUM2
*&      <-- LV_RESULT
*&---------------------------------------------------------------------*
FORM CALCULATE9  USING    LV_NUM1 TYPE I
                          LV_NUM2 TYPE I
                 CHANGING LV_RESULT TYPE I.

  LV_RESULT = LV_NUM1 + LV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALCULATE10
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LV_NUM1
*&      --> LV_NUM2
*&      <-- LV_RESULT
*&---------------------------------------------------------------------*
FORM CALCULATE10  USING    LV_NUM1 LIKE GV_NUM1
                           LV_NUM2 LIKE GV_NUM2
                  CHANGING LV_RESULT LIKE GV_RESULT1.

  LV_RESULT = LV_NUM1 + LV_NUM2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form STRUCTURE1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_DATA1
*&---------------------------------------------------------------------*
FORM STRUCTURE1.

  DATA : BEGIN OF LS_DATA,
          CHAR1(10),
          CHAR2(10),
         END OF LS_DATA.

   LS_DATA-CHAR1 = 'AAA'.
   LS_DATA-CHAR2 = 'BBB'.

   PERFORM STRUCTURE2 USING LS_DATA.

   PERFORM STRUCTURE3 USING LS_DATA.

   PERFORM STRUCTURE4 USING LS_DATA.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form STRUCTURE2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_DATA
*&---------------------------------------------------------------------*
FORM STRUCTURE2  USING LS_DATA.

  WRITE :/ 'STRUCTURE2', LS_DATA.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form STRUCTURE3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_DATA
*&---------------------------------------------------------------------*
FORM STRUCTURE3  USING LS_DATA LIKE GS_DATA.

 WRITE : / 'STRUCTURE3', LS_DATA.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form STRUCTURE4
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_DATA
*&---------------------------------------------------------------------*
FORM STRUCTURE4  USING LS_DATA STRUCTURE GS_DATA.

  WRITE :/ 'STRUCTURE4', LS_DATA.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INTERNAL_TABLE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_DATA1
*&---------------------------------------------------------------------*
FORM INTERNAL_TABLE1.
  DATA : LT_DATA LIKE TABLE OF GS_DATA.

  GS_DATA-CHAR1 = 'AAA'.
  GS_DATA-CHAR2 = 'BBB'.
  APPEND GS_DATA TO LT_DATA.

  PERFORM INTERNAL_TABLE2 TABLES LT_DATA.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INTERNAL_TABLE2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LT_DATA
*&---------------------------------------------------------------------*
FORM INTERNAL_TABLE2  TABLES LT_DATA STRUCTURE GS_DATA.

  LOOP AT LT_DATA INTO GS_DATA.
    WRITE : / 'INTERNAL', GS_DATA.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INTERNAL_CAL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_DATA2
*&      --> GV_VAR
*&      <-- GV_VAR2
*&---------------------------------------------------------------------*
FORM INTERNAL_CAL  TABLES   GT_DATA2 STRUCTURE GS_DATA2
                   USING    GV_VAR
                   CHANGING GV_VAR2.

  DATA : LV_RESULT TYPE I.

  IF GV_VAR = '+'.
    GV_VAR2 = '더하기'.
    LOOP AT GT_DATA2 INTO GS_DATA2.
      CLEAR LV_RESULT.
      LV_RESULT = GS_DATA2-NUM1 + GS_DATA2-NUM2.
      GS_DATA2-RESULT = LV_RESULT.

      MODIFY GT_DATA2 FROM GS_DATA2.
    ENDLOOP.

  ELSEIF GV_VAR = '*'.
    GV_VAR2 = '곱하기'.
    LOOP AT GT_DATA2 INTO GS_DATA2.
      CLEAR LV_RESULT.
      LV_RESULT = GS_DATA2-NUM1 * GS_DATA2-NUM2.
      GS_DATA2-RESULT = LV_RESULT.

      MODIFY GT_DATA2 FROM GS_DATA2.
    ENDLOOP.

  ENDIF.

ENDFORM.
