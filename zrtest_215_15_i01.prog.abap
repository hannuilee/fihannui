*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_14_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA : LV_INT(2),
         LV_CHAR(10).

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

    WHEN 'CHANGE'.
      "E_VALID   = "DATA 변경 여부 / 수정 후 저장 안 하고 나갈 시 체크할 수있음
      CALL METHOD GC_GRID_1->CHECK_CHANGED_DATA
*        IMPORTING
*          E_VALID   =
*        CHANGING
*          C_REFRESH = 'X'
          .

      READ TABLE GT_DATA INDEX 1.
      LV_INT = GT_DATA-INT.
      CONCATENATE LV_INT '/' GT_DATA-NAME INTO LV_CHAR.
      MESSAGE LV_CHAR TYPE 'I'.

  ENDCASE.

ENDMODULE.
