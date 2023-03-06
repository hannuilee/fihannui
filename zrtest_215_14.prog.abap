*&---------------------------------------------------------------------*
*& Report ZRTEST_215_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_14.

INCLUDE ZRTEST_215_14_TOP.
INCLUDE ZRTEST_215_14_SCR.
INCLUDE ZRTEST_215_14_O01.
INCLUDE ZRTEST_215_14_I01.
INCLUDE ZRTEST_215_14_F01.

INITIALIZATION.

START-OF-SELECTION.
  PERFORM GET_DATA.

  CALL SCREEN 100.
