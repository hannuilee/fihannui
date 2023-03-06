*&---------------------------------------------------------------------*
*& Report ZRTEST_215_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_15.

INCLUDE ZRTEST_215_15_ALV.

INCLUDE ZRTEST_215_15_TOP.

INCLUDE ZRTEST_215_15_SCR.

INCLUDE ZRTEST_215_15_O01.

INCLUDE ZRTEST_215_15_I01.

INCLUDE ZRTEST_215_15_F01.


INITIALIZATION.

START-OF-SELECTION.
  PERFORM GET_DATA.

  CALL SCREEN 100.
