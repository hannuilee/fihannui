*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_14_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .
  DATA : LS_SCOL TYPE LVC_S_SCOL.
  DATA : LS_STYLE TYPE LVC_S_STYL.
  DATA : LV_TABIX TYPE SY-TABIX.

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
      CLEAR LS_SCOL.
      LS_SCOL-FNAME = 'INT'.
      LS_SCOL-COLOR-COL  = 7.
*      LS_SCOL-COLOR-INT  = 1.
*      LS_SCOL-COLOR-INV  = 1.
*      LS_SCOL-NOKEYCOL  = 'X'.

*      INSERT LS_SCOL INTO TABLE GT_DATA-CTAB.
      APPEND LS_SCOL TO GT_DATA-CTAB.
    ENDIF.

    IF LV_TABIX = 6.
      LS_STYLE-FIELDNAME = 'CHECK'.
*      LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
*      LS_STYLE-STYLE = '00100000'.

      LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.
*      LS_STYLE-STYLE = '00080000'.

*      INSERT LS_STYLE INTO TABLE GT_DATA-STYLE.
      APPEND LS_STYLE TO GT_DATA-STYLE.
    ENDIF.

    MODIFY GT_DATA.
    CLEAR GT_DATA.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING
    EXPORTING
*      parent                      =
      REPID                       = SY-REPID
      DYNNR                       = SY-DYNNR
*      side                        = DOCK_AT_LEFT
      EXTENSION                   = 5000
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
  IF SY-SUBRC <> 0.
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
      PARENT            = GC_DOCKING
      ROWS              = 1
      COLUMNS           = 2
*      no_autodef_progid_dynnr =
*      name              =
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      others            = 3
      .
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
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

  CALL METHOD GC_SPLITTER->SET_COLUMN_WIDTH
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
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.

  CALL METHOD GC_SPLITTER->SET_COLUMN_WIDTH
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
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.





  CREATE OBJECT GC_GRID_1
    EXPORTING
*      i_shellstyle      = 0
*      i_lifetime        =
      I_PARENT          = GC_CONTAINER_1
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
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT GC_GRID_2
    EXPORTING
*      i_shellstyle      = 0
*      i_lifetime        =
      I_PARENT          = GC_CONTAINER_2
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
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VARIANT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM VARIANT .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LAYOUT .

  GS_LAYOUT-ZEBRA      = 'X'.
  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-GRID_TITLE = 'GRID TITLE'.
  GS_LAYOUT-SMALLTITLE = 'X'.

*  GS_LAYOUT-NO_TOOLBAR = 'X'.

  GS_LAYOUT-SEL_MODE = 'D'. "D > A > C > B = SPACE

  GS_LAYOUT-INFO_FNAME = 'INFO'.
  GS_LAYOUT-CTAB_FNAME = 'CTAB'.
  GS_LAYOUT-STYLEFNAME = 'STYLE'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form FIELDCATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM FIELDCATALOG .
  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
   EXPORTING
     I_PROGRAM_NAME               = SY-REPID
     I_INTERNAL_TABNAME           = 'GT_DATA'
*     I_STRUCTURE_NAME             =
*     I_CLIENT_NEVER_DISPLAY       = 'X'
*     I_INCLNAME                   = SY-REPID "주석
*     I_BYPASSING_BUFFER           = 'X' "주석
*     I_BUFFER_ACTIVE              = 'X' "주석
    CHANGING
      CT_FIELDCAT                  = LT_FCAT
*   EXCEPTIONS
*     INCONSISTENT_INTERFACE       = 1
*     PROGRAM_ERROR                = 2
*     OTHERS                       = 3
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

  "위에서 가져온 필드 카탈로그는 SLIS 형식
  "메소드 호출을 위해서 LVC 형식으로 바꿔줘야함
  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      IT_FIELDCAT_ALV       = LT_FCAT
*     IT_SORT_ALV           =
*     IT_FILTER_ALV         =
*     IS_LAYOUT_ALV         =
   IMPORTING
     ET_FIELDCAT_LVC       = GT_FCAT_2
*     ET_SORT_LVC           =
*     ET_FILTER_LVC         =
*     ES_LAYOUT_LVC         =
    TABLES
      IT_DATA               = GT_DATA[]
*   EXCEPTIONS
*     IT_DATA_MISSING       = 1
*     OTHERS                = 2
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT GT_FCAT_2 INTO GS_FCAT_2.
    CASE GS_FCAT_2-FIELDNAME.
      WHEN 'ICON'.
        GS_FCAT_2-COLTEXT = '아이콘'.

      WHEN 'ZCODE'.
        GS_FCAT_2-COLTEXT = '코드'.
*  GS_FCAT_2-KEY       = 'X'.

        GS_FCAT_2-JUST      = 'C'. "L, R, C

      WHEN 'ZNAME'.
*  GS_FCAT_2-COLTEXT = '코드명'.
        GS_FCAT_2-SCRTEXT_L = 'LONGLONGLONG'.
        GS_FCAT_2-SCRTEXT_M = '중간'.
        GS_FCAT_2-SCRTEXT_S = '짧'.

        GS_FCAT_2-EMPHASIZE = 'C300'.

        GS_FCAT_2-HOTSPOT   = 'X'.

      WHEN 'CHECK'.
        GS_FCAT_2-FIELDNAME = 'CHECK'.
        GS_FCAT_2-COLTEXT   = '체크'.
        GS_FCAT_2-CHECKBOX  = 'X'.
        GS_FCAT_2-OUTPUTLEN = 3.
*  GS_FCAT_2-EDIT      = 'X'. "EDIT 먹이면 라인 선택바 생김
*  GS_FCAT_2-NO_OUT    = 'X'.
*  GS_FCAT_2-TECH      = 'X'.

      WHEN 'INT'.
        GS_FCAT_2-COLTEXT   = '숫자'.
        GS_FCAT_2-NO_ZERO   = 'X'.
        GS_FCAT_2-DO_SUM    = 'X'.

      WHEN 'NAME'.
        GS_FCAT_2-COLTEXT   = '이름'.
        GS_FCAT_2-EDIT      = 'X'.

      WHEN 'OK_NO'.
        GS_FCAT_2-COLTEXT   = 'FINISHED'.

    ENDCASE.

    MODIFY GT_FCAT_2 FROM GS_FCAT_2.
  ENDLOOP.

  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'ICON'.
  GS_FCAT-COLTEXT   = '아이콘'.
  APPEND GS_FCAT TO GT_FCAT.

  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-COLTEXT   = '코드'.

*  GS_FCAT-KEY       = 'X'.

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

  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'NAME'.
  GS_FCAT-COLTEXT   = '이름'.
  GS_FCAT-EDIT      = 'X'.
  APPEND GS_FCAT TO GT_FCAT.

  CLEAR : GS_FCAT.
  GS_FCAT-FIELDNAME = 'OK_NO'.
  GS_FCAT-COLTEXT   = 'FINISHED'.
  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ETC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM ETC .

  "툴바가 다 나온다
  CALL METHOD GC_GRID_1->SET_READY_FOR_INPUT
    EXPORTING
      I_READY_FOR_INPUT = 1
      .

  APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO GT_TOOLBAR. "'&LOCAL&DELETE_ROW'
*APPEND '&LOCAL&DELETE_ROW' TO GT_TOOLBAR. "'&LOCAL&DELETE_ROW'

*  GS_SORT-FIELDNAME = 'ZNAME'.
*  GS_SORT-UP        = 'X'.
*  GS_SORT-SUBTOT    = 'X'.
*  APPEND GS_SORT TO GT_SORT.

  "이걸 먼저 먹여야 레이아웃 설정이 가능하다
  GS_VARIANT-REPORT   = SY-REPID.
  GS_VARIANT-USERNAME = SY-UNAME.
*  GS_VARIANT-VARIANT = '/215'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV .

  CALL METHOD GC_GRID_1->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
*      is_variant                    =
*      i_save                        =
*      i_default                     = 'X'
      IS_LAYOUT                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
      IT_TOOLBAR_EXCLUDING          = GT_TOOLBAR
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      IT_OUTTAB                     = GT_DATA[]
      IT_FIELDCATALOG               = GT_FCAT_2
*      it_sort                       =
*      it_filter                     =
*    EXCEPTIONS
*      invalid_parameter_combination = 1
*      program_error                 = 2
*      too_many_lines                = 3
*      others                        = 4
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.

  "I_SAVE
  "X - GLOBAL 레이아웃 세팅만 가능함
  "U - 특정 사용자에 한해서 레이아웃 세팅만 가능함
  "A - X와 U 둘 다 가능함
  "SPACE - 레이아웃 저장을 하지 않음

  CALL METHOD GC_GRID_2->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
      IS_VARIANT                    = GS_VARIANT
      I_SAVE                        = 'A' "A, U, X, SPACE
      I_DEFAULT                     = 'X' "X, SPACE
*      is_layout                     = GS_LAYOUT
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          = GT_TOOLBAR
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      IT_OUTTAB                     = GT_DATA[]
      IT_FIELDCATALOG               = GT_FCAT
      IT_SORT                       = GT_SORT
*      it_filter                     =
*    EXCEPTIONS
*      invalid_parameter_combination = 1
*      program_error                 = 2
*      too_many_lines                = 3
*      others                        = 4
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.
  LS_STABLE-COL = 'X'.

  GS_LAYOUT-ZEBRA = ''.

  CALL METHOD GC_GRID_1->SET_FRONTEND_LAYOUT
    EXPORTING
      IS_LAYOUT = GS_LAYOUT
      .

  CALL METHOD GC_GRID_1->REFRESH_TABLE_DISPLAY
    EXPORTING
      IS_STABLE      = LS_STABLE
      I_SOFT_REFRESH = ' '
*      i_soft_refresh = 'X'
*    EXCEPTIONS
*      finished       = 1
*      others         = 2
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_OBJECT
*&      --> E_INTERACTIVE
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_TOOLBAR  USING E_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET
                               E_INTERACTIVE TYPE C.
  "CL_ALV_EVENT_TOOLBAR_SET->MT_TOOLBAR
  "MT_TOOLBAR-TTB_BUTTON-STB_BUTTON

  "BUTN_TYPE
  "0 - Button (normal)
  "1 - Menu and default button
  "2 - Menu
  "3 - Separator
  "4 - Radio button
  "5 - Checkbox
  "6 - Menu option

  DATA : LS_TOOLBAR TYPE STB_BUTTON.

  CLEAR : LS_TOOLBAR.
  LS_TOOLBAR-FUNCTION  = 'CHANGE'.
  LS_TOOLBAR-ICON      = ICON_FAILURE. "@03@
  LS_TOOLBAR-TEXT      = '변경'.
  LS_TOOLBAR-QUICKINFO = 'QUICK'.
  LS_TOOLBAR-BUTN_TYPE = 0.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.

  CLEAR : LS_TOOLBAR.
  LS_TOOLBAR-BUTN_TYPE = 3.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.

  CLEAR : LS_TOOLBAR.
  LS_TOOLBAR-FUNCTION  = 'CHANGE2'.
  LS_TOOLBAR-ICON      = ICON_FAILURE. "@03@
  LS_TOOLBAR-TEXT      = '변경2'.
  LS_TOOLBAR-QUICKINFO = 'QUICK'.
  LS_TOOLBAR-BUTN_TYPE = 0.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form EVENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM EVENT .

  CREATE OBJECT GC_EVENT.

  SET HANDLER GC_EVENT->HANDLE_TOOLBAR FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_USER_COMMAND FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_DOUBLE_CLICK FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_HOTSPOT_CLICK FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID_1.
  SET HANDLER GC_EVENT->HANDLE_CHANGED_FINISHED FOR GC_GRID_1.

*  CALL METHOD GC_GRID_1->REGISTER_EDIT_EVENT
*    EXPORTING
**      I_EVENT_ID = CL_GUI_ALV_GRID=>EVT_ENTER "PROTECTED여서 사용 못함
*      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER
**      I_EVENT_ID = 19
**    EXCEPTIONS
**      ERROR      = 1
**      OTHERS     = 2
*          .
*  IF SY-SUBRC <> 0.
**   Implement suitable error handling here
*  ENDIF.

  CALL METHOD GC_GRID_1->REGISTER_EDIT_EVENT
    EXPORTING
      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED
*      I_EVENT_ID = 18
*    EXCEPTIONS
*      ERROR      = 1
*      OTHERS     = 2
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_UCOMM
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_USER_COMMAND  USING E_UCOMM TYPE SY-UCOMM.
  DATA : LT_ROW_NO TYPE LVC_T_ROID,
         LS_ROW_NO TYPE LVC_S_ROID,
         LT_INDEX_ROWS TYPE LVC_T_ROW.

  DATA : LV_CNT TYPE I.

  CASE E_UCOMM.
    WHEN 'CHANGE'.
      MESSAGE '변경!' TYPE 'I'.

    WHEN 'CHANGE2'.
      CALL METHOD GC_GRID_1->GET_SELECTED_ROWS
        IMPORTING
          ET_INDEX_ROWS = LT_INDEX_ROWS
          ET_ROW_NO     = LT_ROW_NO.

      IF LT_ROW_NO[] IS INITIAL.
        MESSAGE '라인을 선택해주세요!' TYPE 'S' DISPLAY LIKE 'E'.
        EXIT.
      ENDIF.

      DESCRIBE TABLE LT_ROW_NO LINES LV_CNT.
      IF LV_CNT > 1.
        MESSAGE '한 라인만 선택해주세요!' TYPE 'S' DISPLAY LIKE 'E'.
        EXIT.
      ENDIF.

      LOOP AT LT_ROW_NO INTO LS_ROW_NO.
        CLEAR GT_DATA.
        READ TABLE GT_DATA INDEX LS_ROW_NO-ROW_ID.

        GT_DATA-ZNAME = '임시DATA'.

        MODIFY GT_DATA INDEX LS_ROW_NO-ROW_ID.
      ENDLOOP.

      PERFORM REFRESH.


  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW_ID
*&      --> E_COLUMN_ID
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_HOTSPOT_CLICK  USING E_ROW_ID TYPE LVC_S_ROW
                                     E_COLUMN_ID TYPE LVC_S_COL
                                     ES_ROW_NO TYPE LVC_S_ROID.

  DATA : LT_DATA LIKE GT_DATA OCCURS 0 WITH HEADER LINE.
  DATA : LT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
         LS_FCAT TYPE SLIS_FIELDCAT_ALV.

  CASE E_COLUMN_ID-FIELDNAME.
    WHEN 'ZNAME'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX ES_ROW_NO-ROW_ID.
      LT_DATA = GT_DATA.
      APPEND LT_DATA.

      LS_FCAT-FIELDNAME = 'ZCODE'.
      LS_FCAT-SELTEXT_S =
      LS_FCAT-SELTEXT_M =
      LS_FCAT-SELTEXT_L = '코드'.
      APPEND LS_FCAT TO LT_FCAT.

      LS_FCAT-FIELDNAME = 'ZNAME'.
      LS_FCAT-SELTEXT_S =
      LS_FCAT-SELTEXT_M =
      LS_FCAT-SELTEXT_L = '코드명'.
      APPEND LS_FCAT TO LT_FCAT.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
       EXPORTING
*         I_INTERFACE_CHECK                 = ' '
*         I_BYPASSING_BUFFER                = ' '
*         I_BUFFER_ACTIVE                   = ' '
*         I_CALLBACK_PROGRAM                = ' '
*         I_CALLBACK_PF_STATUS_SET          = ' '
*         I_CALLBACK_USER_COMMAND           = ' '
*         I_CALLBACK_TOP_OF_PAGE            = ' '
*         I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*         I_CALLBACK_HTML_END_OF_LIST       = ' '
*         I_STRUCTURE_NAME                  =
*         I_BACKGROUND_ID                   = ' '
         I_GRID_TITLE                      = 'POPUP'
*         I_GRID_SETTINGS                   =
*         IS_LAYOUT                         =
         IT_FIELDCAT                       = LT_FCAT
*         IT_EXCLUDING                      =
*         IT_SPECIAL_GROUPS                 =
*         IT_SORT                           =
*         IT_FILTER                         =
*         IS_SEL_HIDE                       =
*         I_DEFAULT                         = 'X'
*         I_SAVE                            = ' '
*         IS_VARIANT                        =
*         IT_EVENTS                         =
*         IT_EVENT_EXIT                     =
*         IS_PRINT                          =
*         IS_REPREP_ID                      =
         I_SCREEN_START_COLUMN             = 10
         I_SCREEN_START_LINE               = 10
         I_SCREEN_END_COLUMN               = 50
         I_SCREEN_END_LINE                 = 20
*         I_HTML_HEIGHT_TOP                 = 0
*         I_HTML_HEIGHT_END                 = 0
*         IT_ALV_GRAPHICS                   =
*         IT_HYPERLINK                      =
*         IT_ADD_FIELDCAT                   =
*         IT_EXCEPT_QINFO                   =
*         IR_SALV_FULLSCREEN_ADAPTER        =
*         O_PREVIOUS_SRAL_HANDLER           =
*       IMPORTING
*         E_EXIT_CAUSED_BY_CALLER           =
*         ES_EXIT_CAUSED_BY_USER            =
        TABLES
          T_OUTTAB                          = LT_DATA[]
*       EXCEPTIONS
*         PROGRAM_ERROR                     = 1
*         OTHERS                            = 2
                .
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.

  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_DOUBLE_CLICK  USING E_ROW TYPE LVC_S_ROW
                                    E_COLUMN TYPE LVC_S_COL
                                    ES_ROW_NO TYPE LVC_S_ROID.
  DATA : LV_CHAR(2).

  CASE E_COLUMN-FIELDNAME.
    WHEN 'INT'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX ES_ROW_NO-ROW_ID.

      LV_CHAR = GT_DATA-INT.
      MESSAGE LV_CHAR TYPE 'I'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DATA_CHANGED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_DATA_CHANGED  USING ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  "METHOD : CL_ALV_CHANGED_DATA_PROTOCOL->MODIFY_CELL
  "ATTRIBUTE : CL_ALV_CHANGED_DATA_PROTOCOL->MT_GOOD_CELLS
  "MT_GOOD_CELLS-LVC_T_MODI / LVC_S_MODI

  DATA : LS_MODI TYPE LVC_S_MODI.

  "첫번째첫번째첫번째첫번째첫번째첫번째첫번째첫번째첫번째
  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
    IF LS_MODI-FIELDNAME = 'NAME'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.

      IF LS_MODI-VALUE = '이원오'.
        GT_DATA-ICON = ICON_LED_GREEN.
      ELSE.
        GT_DATA-ICON = ICON_LED_RED.
      ENDIF.

      MODIFY GT_DATA INDEX LS_MODI-ROW_ID.
    ENDIF.
  ENDLOOP.

*  PERFORM REFRESH. "FINISHED에서 탈 것이다
  "첫번째첫번째첫번째첫번째첫번째첫번째첫번째첫번째첫번째

  "두번째두번째두번째두번째두번째두번째두번째두번째두번째
*  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
*    IF LS_MODI-FIELDNAME = 'NAME'.
*      CLEAR GT_DATA.
*      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.
*
*      IF LS_MODI-VALUE = '이원오'.
*        CALL METHOD ER_DATA_CHANGED->MODIFY_CELL
*          EXPORTING
*            I_ROW_ID    = LS_MODI-ROW_ID
**            I_TABIX     =
*            I_FIELDNAME = 'ICON'
*            I_VALUE     = ICON_LED_GREEN
*            .
*
*      ELSE.
*        CALL METHOD ER_DATA_CHANGED->MODIFY_CELL
*          EXPORTING
*            I_ROW_ID    = LS_MODI-ROW_ID
**            I_TABIX     =
*            I_FIELDNAME = 'ICON'
*            I_VALUE     = ICON_LED_RED
*            .
*      ENDIF.
*    ENDIF.
*  ENDLOOP.
  "두번째두번째두번째두번째두번째두번째두번째두번째두번째

  "세번째세번째세번째세번째세번째세번째세번째세번째세번째
*  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
*    IF LS_MODI-FIELDNAME = 'NAME'.
*      CLEAR GT_DATA.
*      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.
*
*      IF LS_MODI-VALUE = '이원오'.
*        GT_DATA-ICON = ICON_LED_GREEN.
*      ELSE.
*        GT_DATA-ICON = ICON_LED_RED.
*      ENDIF.
*
*      MODIFY GT_DATA INDEX LS_MODI-ROW_ID.
*    ENDIF.
*  ENDLOOP.
*
*  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE
*    EXPORTING
*      NEW_CODE = 'OK'
**    IMPORTING
**      RC       =
*      .
  "세번째세번째세번째세번째세번째세번째세번째세번째세번째

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_CHANGED_FINISHED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ET_GOOD_CELLS
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_CHANGED_FINISHED  USING ET_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.

  LOOP AT ET_GOOD_CELLS INTO LS_MODI.
    IF LS_MODI-FIELDNAME = 'NAME'.
      CLEAR GT_DATA.
      READ TABLE GT_DATA INDEX LS_MODI-ROW_ID.

      IF GT_DATA-ICON = ICON_LED_GREEN.
        GT_DATA-OK_NO = 'OK'.
      ELSEIF GT_DATA-ICON = ICON_LED_RED.
        GT_DATA-OK_NO = 'NO'.
      ENDIF.

      MODIFY GT_DATA INDEX LS_MODI-ROW_ID.
    ENDIF.
  ENDLOOP.

  CHECK ET_GOOD_CELLS[] IS NOT INITIAL.
  PERFORM REFRESH.

ENDFORM.
