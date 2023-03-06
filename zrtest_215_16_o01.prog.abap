*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_14_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_alv_0100 OUTPUT.

IF GC_DOCKING IS INITIAL.
  PERFORM CREATE_OBJECT.
  PERFORM VARIANT.
  PERFORM LAYOUT.
  PERFORM FIELDCATALOG.
  PERFORM ETC.
  PERFORM EVENT.
  PERFORM DISPLAY_ALV.

ELSE.
  "REFRESH
  PERFORM REFRESH.
ENDIF.

ENDMODULE.
