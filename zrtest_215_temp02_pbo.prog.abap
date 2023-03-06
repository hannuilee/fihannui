*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_TEMP02_PBO
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module ALV_DISPLAY_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE ALV_DISPLAY_0100 OUTPUT.

  IF GC_DOCKING IS INITIAL.
    PERFORM CREATE_OBJECT.
    PERFORM FIELD_CATALOG.
    PERFORM LAYOUT.
    PERFORM ETC.
    PERFORM EVENT.
    PERFORM DISPLAY.

  ELSE.
    "REFRESH
    PERFORM REFRESH.
  ENDIF.






ENDMODULE.
