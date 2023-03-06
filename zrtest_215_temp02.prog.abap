*&---------------------------------------------------------------------*
*& Report ZRTEST_215_TEMP02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_TEMP02.

INCLUDE ZRTEST_215_TEMP02_CLS.
INCLUDE ZRTEST_215_TEMP02_TOP.
INCLUDE ZRTEST_215_TEMP02_SCR.
INCLUDE ZRTEST_215_TEMP02_PBO.
INCLUDE ZRTEST_215_TEMP02_PAI.
INCLUDE ZRTEST_215_TEMP02_F01.


INITIALIZATION.

START-OF-SELECTION.
  PERFORM GET_DATA.

  CALL SCREEN 100.
