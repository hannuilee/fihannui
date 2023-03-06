*&---------------------------------------------------------------------*
*& Report ZRTEST_215_08_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_08_05.

CONTROLS : G_TAB TYPE TABSTRIP.
CONTROLS : G_CON TYPE TABLEVIEW USING SCREEN 200.

TABLES : SFLIGHT.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GV_DYNNR TYPE SY-DYNNR.
DATA : GV_REPID TYPE SY-REPID.

TYPES : BEGIN OF TY_DATA,
         CARRID LIKE SFLIGHT-CARRID,
         CONNID LIKE SFLIGHT-CONNID,
        END OF TY_DATA.

DATA : GT_DATA TYPE TABLE OF TY_DATA.
DATA : GS_DATA TYPE TY_DATA.

*DATA : BEGIN OF GT_DATA OCCURS 0,
*        CARRID LIKE SFLIGHT-CARRID,
*        CONNID LIKE SFLIGHT-CONNID,
*       END OF GT_DATA.

INITIALIZATION.

SELECTION-SCREEN BEGIN OF SCREEN 2000 AS SUBSCREEN.
  SELECT-OPTIONS : S_CARRID FOR SFLIGHT-CARRID.

SELECTION-SCREEN END OF SCREEN 2000.

SELECTION-SCREEN BEGIN OF SCREEN 2100 AS SUBSCREEN.
  SELECT-OPTIONS : S_CONNID FOR SFLIGHT-CONNID.

SELECTION-SCREEN END OF SCREEN 2100.

*SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

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
   GV_DYNNR = '2000'.
*   G_TAB-ACTIVETAB = 'TAB01'.
 ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'TAB01'.
      GV_DYNNR = '2000'.
      G_TAB-ACTIVETAB = 'TAB01'.

    WHEN 'TAB02'.
      GV_DYNNR = '2100'.
      G_TAB-ACTIVETAB = 'TAB02'.

    WHEN 'RUN'.
      IF G_TAB-ACTIVETAB = 'TAB01'.
        SELECT CARRID CONNID
          INTO TABLE GT_DATA
          FROM SFLIGHT
          WHERE CARRID IN S_CARRID.

      ELSEIF G_TAB-ACTIVETAB = 'TAB02'.
        SELECT CARRID CONNID
          INTO TABLE GT_DATA
          FROM SFLIGHT
          WHERE CONNID IN S_CONNID.

      ENDIF.

      CALL SCREEN 200.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
 SET TITLEBAR 'T200'.

 DESCRIBE TABLE GT_DATA LINES G_CON-LINES.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MOVE_ABAP_SCREEN_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_abap_screen_data OUTPUT.

  READ TABLE GT_DATA INTO GS_DATA
  INDEX G_CON-CURRENT_LINE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MOVE_SCREEN_ABAP_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE move_screen_abap_data INPUT.

  MODIFY GT_DATA FROM GS_DATA
  INDEX G_CON-CURRENT_LINE.

ENDMODULE.
