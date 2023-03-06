*&---------------------------------------------------------------------*
*& Report ZRTEST_215_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_10.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA.

"MEMORY EXPORT IMPORT TEST
DATA : BEGIN OF GT_DATA_02 OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA_02.

DATA : GV_ZRTEST_215_10.
"MEMORY EXPORT IMPORT TEST

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

DATA : GT_FCAT TYPE LVC_T_FCAT.
DATA : GS_FCAT TYPE LVC_S_FCAT.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO TABLE GT_DATA
    FROM ZTTEST_215_HR
    WHERE ZCODE IN S_ZCODE.

  IMPORT GV_ZRTEST_215_10 FROM MEMORY ID 'MEM_10'.
  IF GV_ZRTEST_215_10 IS NOT INITIAL.
    GT_DATA_02[] = GT_DATA[].
    EXPORT GT_DATA_02[] TO MEMORY ID 'MEM_GT_DATA_02'.
    CLEAR GT_DATA_02[].
    LEAVE PROGRAM.
  ENDIF.

  CALL SCREEN 100.
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
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'SUBMIT'.
*      SUBMIT ZRTEST_215_10_02.
*      SUBMIT ZRTEST_215_10_02 AND RETURN.
      SUBMIT ZRTEST_215_10_02 WITH S_ZCODE IN S_ZCODE AND RETURN.

    WHEN 'NEW_SUBMIT'.
      CALL FUNCTION 'RS_TOOL_ACCESS'
        EXPORTING
          OPERATION                 = 'TEST'
         OBJECT_NAME               = 'ZRTEST_215_10_02'
         OBJECT_TYPE               = 'PROG'
*         ENCLOSING_OBJECT          =
*         POSITION                  = ' '
*         DEVCLASS                  =
*         INCLUDE                   =
*         VERSION                   = ' '
*         MONITOR_ACTIVATION        = 'X'
*         WB_MANAGER                =
         IN_NEW_WINDOW             = 'X'
*         WITH_OBJECTLIST           = ' '
*         WITH_WORKLIST             = ' '
*       IMPORTING
*         NEW_NAME                  =
*         WB_TODO_REQUEST           =
*       TABLES
*         OBJLIST                   =
*       CHANGING
*         P_REQUEST                 = ' '
*       EXCEPTIONS
*         NOT_EXECUTED              = 1
*         INVALID_OBJECT_TYPE       = 2
*         OTHERS                    = 3
                .
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.


    WHEN 'TCODE'. "조회조건은 없나?
*      CALL TRANSACTION 'ZRTEST_215_10_02'.
      CALL TRANSACTION 'ZRTEST_215_10_02' AND SKIP FIRST SCREEN.

*      LEAVE TO TRANSACTION 'ZRTEST_215_10_02'.
*      LEAVE TO TRANSACTION 'ZRTEST_215_10_02' AND SKIP FIRST SCREEN.


    WHEN 'NEW_TCODE'.
      CALL FUNCTION 'TH_CREATE_MODE'
       EXPORTING
         TRANSAKTION                 = 'ZRTEST_215_10_02'
*         DEL_ON_EOT                  = 0
*         PARAMETERS                  =
         PROCESS_DARK                = 'X'
*         INHERIT_STAT_TRANS_ID       = 0
*       IMPORTING
*         MODE                        =
*       EXCEPTIONS
*         MAX_SESSIONS                = 1
*         INTERNAL_ERROR              = 2
*         NO_AUTHORITY                = 3
*         OTHERS                      = 4
                .
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.

    WHEN 'CALL'.
      CALL SCREEN 200.

      MESSAGE 'CALL SCREEN WRITE' TYPE 'I'.

    WHEN 'SET'.
      SET SCREEN 200.

      MESSAGE 'SET SCREEN WRITE' TYPE 'I'.

    WHEN 'SUB_CALL'.
      CALL SCREEN 200 STARTING AT 20 20
                      ENDING AT   50 25.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ALV_DISPLAY_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE alv_display_0100 OUTPUT.

  CREATE OBJECT GC_CUSTOM
    exporting
*      parent                      =
      container_name              = 'GC_CONTROL'
*      style                       =
*      lifetime                    = lifetime_default
*      repid                       =
*      dynnr                       =
*      no_autodef_progid_dynnr     =
*    EXCEPTIONS
*      cntl_error                  = 1
*      cntl_system_error           = 2
*      create_error                = 3
*      lifetime_error              = 4
*      lifetime_dynpro_dynpro_link = 5
*      others                      = 6
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT GC_GRID
    exporting
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CUSTOM
*      i_appl_events     = SPACE
*      i_parentdbg       =
*      i_applogparent    =
*      i_graphicsparent  =
*      i_name            =
*      i_fcat_complete   = SPACE
*      o_previous_sral_handler =
*    EXCEPTIONS
*      error_cntl_create = 1
*      error_cntl_init   = 2
*      error_cntl_link   = 3
*      error_dp_create   = 4
*      others            = 5
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT = '코드'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-COLTEXT = '코드명'.
  APPEND GS_FCAT TO GT_FCAT.

  CALL METHOD GC_GRID->set_table_for_first_display
*    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
*      is_variant                    =
*      i_save                        =
*      i_default                     = 'X'
*      is_layout                     =
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          =
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = GT_DATA[]
      it_fieldcatalog               = GT_FCAT
*      it_sort                       =
*      it_filter                     =
*    EXCEPTIONS
*      invalid_parameter_combination = 1
*      program_error                 = 2
*      too_many_lines                = 3
*      others                        = 4
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.




ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
 SET PF-STATUS 'STATUS200'.
 SET TITLEBAR 'T200'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
