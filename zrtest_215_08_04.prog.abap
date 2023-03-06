*&---------------------------------------------------------------------*
*& Report ZRTEST_215_08_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_08_04.

CONTROLS : G_TAB TYPE TABSTRIP.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA_01 OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA_01.

DATA : BEGIN OF GT_DATA_02 OCCURS 0,
        ZCODE LIKE ZTTEST_215_UNI-ZCODE,
        ZMAJOR LIKE ZTTEST_215_UNI-ZMAJOR,
       END OF GT_DATA_02.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GV_DYNNR TYPE SY-DYNNR.
DATA : GV_REPID TYPE SY-REPID.

INITIALIZATION.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

START-OF-SELECTION.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 IF GV_REPID IS INITIAL.
   GV_REPID = SY-REPID.
   GV_DYNNR = '0110'.
*   G_TAB-ACTIVETAB = 'TAB1'.
 ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  "ACTIVETAB
  "마지막으로 활성화된 TAB PAGE의 FUNCTION CODE를
  "TAB TITLE에 설정

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'TAB01'.
      GV_DYNNR = '0110'.
*      G_TAB-ACTIVETAB = OK_CODE.
      G_TAB-ACTIVETAB = 'TAB01'.

    WHEN 'TAB02'.
      GV_DYNNR = '0120'.
*      G_TAB-ACTIVETAB = OK_CODE.
      G_TAB-ACTIVETAB = 'TAB02'.
  ENDCASE.

ENDMODULE.
