*&---------------------------------------------------------------------*
*& Report ZRTEST_215_11_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_12_02.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.
DATA : GC_SPLITTER TYPE REF TO CL_GUI_SPLITTER_CONTAINER.

DATA : GC_CONTAINER_1 TYPE REF TO CL_GUI_CONTAINER.
DATA : GC_CONTAINER_2 TYPE REF TO CL_GUI_CONTAINER.

DATA : GC_GRID_1 TYPE REF TO CL_GUI_ALV_GRID.
DATA : GC_GRID_2 TYPE REF TO CL_GUI_ALV_GRID.

DATA : GT_FCAT TYPE LVC_T_FCAT.
DATA : GS_FCAT TYPE LVC_S_FCAT.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO TABLE GT_DATA
    FROM ZTTEST_215_HR
    WHERE ZCODE IN S_ZCODE.

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
*& Module DISPLAY_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_alv_0100 OUTPUT.

CREATE OBJECT GC_DOCKING
  EXPORTING
*    parent                      =
    repid                       = SY-REPID
    dynnr                       = SY-DYNNR
*    side                        = DOCK_AT_LEFT
*    side                        = 1 "오른쪽
*    side                        = 2 "아래
    side                        = 4 "위
*    side                        = 8 "왼쪽
    extension                   = 200
*    style                       =
*    lifetime                    = lifetime_default
*    caption                     =
*    metric                      = 0
*    ratio                       =
*    no_autodef_progid_dynnr     =
*    name                        =
*  EXCEPTIONS
*    cntl_error                  = 1
*    cntl_system_error           = 2
*    create_error                = 3
*    lifetime_error              = 4
*    lifetime_dynpro_dynpro_link = 5
*    others                      = 6
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CREATE OBJECT GC_SPLITTER
  EXPORTING
*    link_dynnr        =
*    link_repid        =
*    shellstyle        =
*    left              =
*    top               =
*    width             =
*    height            =
*    metric            = cntl_metric_dynpro
*    align             = 15
    parent            = GC_DOCKING
    rows              = 1
    columns           = 2
*    no_autodef_progid_dynnr =
*    name              =
*  EXCEPTIONS
*    cntl_error        = 1
*    cntl_system_error = 2
*    others            = 3
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CALL METHOD GC_SPLITTER->GET_CONTAINER
  EXPORTING
    ROW       = 1
    COLUMN    = 1
  RECEIVING
    CONTAINER = GC_CONTAINER_1.

CALL METHOD GC_SPLITTER->GET_CONTAINER
  EXPORTING
    ROW       = 1
    COLUMN    = 2
  RECEIVING
    CONTAINER = GC_CONTAINER_2.

CREATE OBJECT GC_GRID_1
  exporting
*    i_shellstyle      = 0
*    i_lifetime        =
    i_parent          = GC_CONTAINER_1
*    i_appl_events     = SPACE
*    i_parentdbg       =
*    i_applogparent    =
*    i_graphicsparent  =
*    i_name            =
*    i_fcat_complete   = SPACE
*    o_previous_sral_handler =
*  EXCEPTIONS
*    error_cntl_create = 1
*    error_cntl_init   = 2
*    error_cntl_link   = 3
*    error_dp_create   = 4
*    others            = 5
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CREATE OBJECT GC_GRID_2
  exporting
*    i_shellstyle      = 0
*    i_lifetime        =
    i_parent          = GC_CONTAINER_2
*    i_appl_events     = SPACE
*    i_parentdbg       =
*    i_applogparent    =
*    i_graphicsparent  =
*    i_name            =
*    i_fcat_complete   = SPACE
*    o_previous_sral_handler =
*  EXCEPTIONS
*    error_cntl_create = 1
*    error_cntl_init   = 2
*    error_cntl_link   = 3
*    error_dp_create   = 4
*    others            = 5
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT = '코드'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-COLTEXT = '코드명'.
  APPEND GS_FCAT TO GT_FCAT.

CALL METHOD GC_GRID_1->set_table_for_first_display
*  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
*    i_structure_name              =
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = GT_DATA[]
    it_fieldcatalog               = GT_FCAT
*    it_sort                       =
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4
        .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL METHOD GC_GRID_2->set_table_for_first_display
*  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
*    i_structure_name              =
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = GT_DATA[]
    it_fieldcatalog               = GT_FCAT
*    it_sort                       =
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4
        .
IF sy-subrc <> 0.
* Implement suitable error handling here
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
  ENDCASE.

ENDMODULE.
