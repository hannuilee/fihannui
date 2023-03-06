*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_14_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'APPEND'.
      CLEAR : GT_DATA.
      GT_DATA-ZCODE = 'ABC'.
      GT_DATA-ZNAME = 'DATA추가'.
      GT_DATA-CHECK = 'X'.
      GT_DATA-INT = 100.
      APPEND GT_DATA.
      CLEAR GT_DATA.

  ENDCASE.

ENDMODULE.
