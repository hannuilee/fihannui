*&---------------------------------------------------------------------*
*& Report ZRTEST_215_07_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_07_02.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR,
       END OF GT_DATA.

DATA : LV_ZCODE(3).

SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.

  PARAMETERS : P_ZCODE1 TYPE ZTTEST_215_HR-ZCODE.

SELECTION-SCREEN END OF SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.

  SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

SELECTION-SCREEN END OF SCREEN 1200.

SELECTION-SCREEN BEGIN OF TABBED BLOCK TAB_BLOCK FOR 10 LINES.
  SELECTION-SCREEN TAB (20) TAB1 USER-COMMAND TAB01 DEFAULT SCREEN 1100.
  SELECTION-SCREEN TAB (20) TAB2 USER-COMMAND TAB02 DEFAULT SCREEN 1200.
SELECTION-SCREEN END OF BLOCK TAB_BLOCK.

INITIALIZATION.

TAB1 = 'PARAMETERS'.
TAB2 = 'SELECT-OPTIONS'.

*TAB_BLOCK-ACTIVETAB = 'TAB01'.
*TAB_BLOCK-DYNNR = 1100.

AT SELECTION-SCREEN ON P_ZCODE1.
  IF P_ZCODE1 IS INITIAL OR P_ZCODE1 = '001' OR P_ZCODE1 = '002'.
  ELSE.
    MESSAGE '잘못된 코드입니다.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

AT SELECTION-SCREEN ON HELP-REQUEST FOR S_ZCODE.
  MESSAGE 'TABLE : ZTTEST_215_HR 참고!' TYPE 'I'.

START-OF-SELECTION.
  IF TAB_BLOCK-ACTIVETAB = 'TAB01'.
    SELECT ZCODE
      INTO TABLE GT_DATA
      FROM ZTTEST_215_HR
      WHERE ZCODE = P_ZCODE1.
  ELSEIF TAB_BLOCK-ACTIVETAB = 'TAB02'.
    SELECT ZCODE
      INTO TABLE GT_DATA
      FROM ZTTEST_215_HR
      WHERE ZCODE IN S_ZCODE.
  ENDIF.

END-OF-SELECTION.
  IF GT_DATA[] IS NOT INITIAL.
    LOOP AT GT_DATA.
      LV_ZCODE = GT_DATA-ZCODE.
      WRITE : / LV_ZCODE.
    ENDLOOP.
  ENDIF.
