*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_TEMP02_PAI
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'APPEND'.
      CLEAR GS_DATA.
      APPEND GS_DATA TO GT_DATA.
      APPEND GS_DATA TO GT_DATA.
  ENDCASE.

ENDMODULE.
