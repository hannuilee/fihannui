*&---------------------------------------------------------------------*
*& Report ZRTEST_215_13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_13.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
        CHECK,
        INT TYPE I,

        INFO(4), "INFO_FNAME
        CTAB TYPE LVC_T_SCOL, "CTAB_FNAME
        STYLE TYPE LVC_T_STYL, "STYLEFNAME
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

DATA : GS_SORT TYPE LVC_S_SORT.
DATA : GT_SORT TYPE LVC_T_SORT.

DATA : GS_VARIANT TYPE DISVARIANT.

DATA : GT_TOOLBAR TYPE UI_FUNCTIONS.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SCOL TYPE LVC_S_SCOL.

DATA : GS_STYLE TYPE LVC_S_STYL.

DATA : LV_TABIX TYPE SY-TABIX.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM ZTTEST_215_HR
    WHERE ZCODE IN S_ZCODE.

  LOOP AT GT_DATA.
    LV_TABIX = SY-TABIX.
    GT_DATA-INT = LV_TABIX.

    IF LV_TABIX = 2.
      GT_DATA-INFO = 'C500'.
    ENDIF.

    IF LV_TABIX = 4.
      CLEAR GS_SCOL.
      GS_SCOL-FNAME = 'INT'.
      GS_SCOL-COLOR-COL  = 7.
*      GS_SCOL-COLOR-INT  = 1.
*      GS_SCOL-COLOR-INV  = 1.
*      GS_SCOL-NOKEYCOL  = 'X'. "키를 일반 컬럼으로 표시 / 그냥 이거 체크 안 해도 색상 넣어짐

*      INSERT GS_SCOL INTO TABLE GT_DATA-CTAB.
      APPEND GS_SCOL TO GT_DATA-CTAB.
    ENDIF.

    IF LV_TABIX = 6.
      GS_STYLE-FIELDNAME = 'CHECK'.
*      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
*      GS_STYLE-STYLE = '00100000'.


      GS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.
*      GS_STYLE-STYLE = '00080000'.

*      INSERT GS_STYLE INTO TABLE GT_DATA-STYLE.
      APPEND GS_STYLE TO GT_DATA-STYLE.
    ENDIF.

    MODIFY GT_DATA.
    CLEAR GT_DATA.
  ENDLOOP.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module DISPLAY_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_alv_0100 OUTPUT.

  CREATE OBJECT GC_DOCKING
    EXPORTING
*      parent                      =
      repid                       = SY-REPID
      dynnr                       = SY-DYNNR
*      side                        = DOCK_AT_LEFT
      extension                   = 5000
*      style                       =
*      lifetime                    = lifetime_default
*      caption                     =
*      metric                      = 0
*      ratio                       =
*      no_autodef_progid_dynnr     =
*      name                        =
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

  CREATE OBJECT GC_SPLITTER
    EXPORTING
*      link_dynnr        =
*      link_repid        =
*      shellstyle        =
*      left              =
*      top               =
*      width             =
*      height            =
*      metric            = cntl_metric_dynpro
*      align             = 15
      parent            = GC_DOCKING
      rows              = 1
      columns           = 2
*      no_autodef_progid_dynnr =
*      name              =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CALL METHOD GC_SPLITTER->get_container
    EXPORTING
      row       = 1
      COLUMN    = 1
    RECEIVING
      container = GC_CONTAINER_1.

  CALL METHOD GC_SPLITTER->get_container
    EXPORTING
      row       = 1
      COLUMN    = 2
    RECEIVING
      container = GC_CONTAINER_2.

  CALL METHOD GC_SPLITTER->set_column_width
    EXPORTING
      ID                = 1
      WIDTH             = 90
*    IMPORTING
*      result            =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

  CALL METHOD GC_SPLITTER->set_column_width
    EXPORTING
      ID                = 2
      WIDTH             = 10
*    IMPORTING
*      result            =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.





  CREATE OBJECT GC_GRID_1
    exporting
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CONTAINER_1
*      i_appl_events     = SPACE
*      i_parentdbg       =
*      i_applogparent    =
*      i_graphicsparent  =
*      i_name            =
*      i_fcat_complete   = SPACE
*      o_previous_sral_handler =
*    EXCEPTIONS
*      error_cntl_create =  1
*      error_cntl_init   = 2
*      error_cntl_link   = 3
*      error_dp_create   = 4
*      others            = 5
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT GC_GRID_2
    exporting
*      i_shellstyle      = 0
*      i_lifetime        =
      i_parent          = GC_CONTAINER_2
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

""""""""""""""""""""""""""""""""""""""""""""""""""
  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT   = '코드'.

  GS_FCAT-KEY       = 'X'.

  GS_FCAT-JUST      = 'C'. "L, R, C

  APPEND GS_FCAT TO GT_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""
  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'ZNAME'.
*  GS_FCAT-COLTEXT = '코드명'.
  GS_FCAT-SCRTEXT_L = 'LONGLONGLONG'.
  GS_FCAT-SCRTEXT_M = '중간'.
  GS_FCAT-SCRTEXT_S = '짧'.

  GS_FCAT-EMPHASIZE = 'C300'.

  GS_FCAT-HOTSPOT   = 'X'.

  APPEND GS_FCAT TO GT_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""
  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'CHECK'.
  GS_FCAT-COLTEXT   = '체크'.
  GS_FCAT-CHECKBOX  = 'X'.
  GS_FCAT-OUTPUTLEN = 3.
*  GS_FCAT-EDIT      = 'X'. "EDIT 먹이면 라인 선택바 생김
*  GS_FCAT-NO_OUT    = 'X'.
*  GS_FCAT-TECH      = 'X'.
  APPEND GS_FCAT TO GT_FCAT.

""""""""""""""""""""""""""""""""""""""""""""""""""
  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'INT'.
  GS_FCAT-COLTEXT   = '숫자'.
  GS_FCAT-NO_ZERO   = 'X'.
  GS_FCAT-DO_SUM    = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
""""""""""""""""""""""""""""""""""""""""""""""""""

  GS_LAYOUT-ZEBRA      = 'X'.
  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-GRID_TITLE = 'GRID TITLE'.
  GS_LAYOUT-SMALLTITLE = 'X'.

*  GS_LAYOUT-NO_TOOLBAR = 'X'.

  GS_LAYOUT-SEL_MODE = 'D'. "D > A > C > B = SPACE

  GS_LAYOUT-INFO_FNAME = 'INFO'.
  GS_LAYOUT-CTAB_FNAME = 'CTAB'.
  GS_LAYOUT-STYLEFNAME = 'STYLE'.

  "툴바가 다 나온다
  CALL METHOD GC_GRID_1->set_ready_for_input
    EXPORTING
      i_ready_for_input = 1
      .

APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO GT_TOOLBAR. "'&LOCAL&DELETE_ROW'
*APPEND '&LOCAL&DELETE_ROW' TO GT_TOOLBAR. "'&LOCAL&DELETE_ROW'

  CALL METHOD GC_GRID_1->set_table_for_first_display
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
*      is_variant                    =
*      i_save                        =
*      i_default                     = 'X'
      is_layout                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
      it_toolbar_excluding          = GT_TOOLBAR
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

  GS_SORT-FIELDNAME = 'ZNAME'.
  GS_SORT-UP        = 'X'.
  GS_SORT-SUBTOT    = 'X'.
  APPEND GS_SORT TO GT_SORT.

  "이걸 먼저 먹여야 레이아웃 설정이 가능하다
  GS_VARIANT-REPORT   = SY-REPID.
  GS_VARIANT-USERNAME = SY-UNAME.
*  GS_VARIANT-VARIANT = '/215'.

  "I_SAVE
  "X - GLOBAL 레이아웃 세팅만 가능함
  "U - 특정 사용자에 한해서 레이아웃 세팅만 가능함
  "A - X와 U 둘 다 가능함
  "SPACE - 레이아웃 저장을 하지 않음

  CALL METHOD GC_GRID_2->set_table_for_first_display
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
      is_variant                    = GS_VARIANT
      i_save                        = 'A' "A, U, X, SPACE
      i_default                     = 'X' "X, SPACE
*      is_layout                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          = GT_TOOLBAR
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = GT_DATA[]
      it_fieldcatalog               = GT_FCAT
      it_sort                       = GT_SORT
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
  ENDCASE.

ENDMODULE.
