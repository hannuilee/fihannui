*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVTEST_215_02...................................*
FORM GET_DATA_ZVTEST_215_02.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTTEST_215_COM WHERE
(VIM_WHERETAB) .
    CLEAR ZVTEST_215_02 .
ZVTEST_215_02-MANDT =
ZTTEST_215_COM-MANDT .
ZVTEST_215_02-ZCODE =
ZTTEST_215_COM-ZCODE .
ZVTEST_215_02-ZCERTI1 =
ZTTEST_215_COM-ZCERTI1 .
ZVTEST_215_02-ZCERTI_CNT =
ZTTEST_215_COM-ZCERTI_CNT .
ZVTEST_215_02-ZCERTI2 =
ZTTEST_215_COM-ZCERTI2 .
ZVTEST_215_02-ZCERTI3 =
ZTTEST_215_COM-ZCERTI3 .
    SELECT * FROM ZTTEST_215_CERTI WHERE
ZCERTI = ZTTEST_215_COM-ZCERTI1 .
ZVTEST_215_02-ZCERTI =
ZTTEST_215_CERTI-ZCERTI .
      EXIT.
    ENDSELECT.
<VIM_TOTAL_STRUC> = ZVTEST_215_02.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVTEST_215_02 .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVTEST_215_02.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVTEST_215_02-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTTEST_215_COM WHERE
  ZCODE = ZVTEST_215_02-ZCODE .
    IF SY-SUBRC = 0.
    DELETE ZTTEST_215_COM .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTTEST_215_COM WHERE
  ZCODE = ZVTEST_215_02-ZCODE .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTTEST_215_COM.
    ENDIF.
ZTTEST_215_COM-MANDT =
ZVTEST_215_02-MANDT .
ZTTEST_215_COM-ZCODE =
ZVTEST_215_02-ZCODE .
ZTTEST_215_COM-ZCERTI1 =
ZVTEST_215_02-ZCERTI1 .
ZTTEST_215_COM-ZCERTI_CNT =
ZVTEST_215_02-ZCERTI_CNT .
ZTTEST_215_COM-ZCERTI2 =
ZVTEST_215_02-ZCERTI2 .
ZTTEST_215_COM-ZCERTI3 =
ZVTEST_215_02-ZCERTI3 .
    IF SY-SUBRC = 0.
    UPDATE ZTTEST_215_COM ##WARN_OK.
    ELSE.
    INSERT ZTTEST_215_COM .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVTEST_215_02-UPD_FLAG,
STATUS_ZVTEST_215_02-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZVTEST_215_02.
  SELECT SINGLE * FROM ZTTEST_215_COM WHERE
ZCODE = ZVTEST_215_02-ZCODE .
ZVTEST_215_02-MANDT =
ZTTEST_215_COM-MANDT .
ZVTEST_215_02-ZCODE =
ZTTEST_215_COM-ZCODE .
ZVTEST_215_02-ZCERTI1 =
ZTTEST_215_COM-ZCERTI1 .
ZVTEST_215_02-ZCERTI_CNT =
ZTTEST_215_COM-ZCERTI_CNT .
ZVTEST_215_02-ZCERTI2 =
ZTTEST_215_COM-ZCERTI2 .
ZVTEST_215_02-ZCERTI3 =
ZTTEST_215_COM-ZCERTI3 .
    SELECT * FROM ZTTEST_215_CERTI WHERE
ZCERTI = ZTTEST_215_COM-ZCERTI1 .
ZVTEST_215_02-ZCERTI =
ZTTEST_215_CERTI-ZCERTI .
      EXIT.
    ENDSELECT.
    IF SY-SUBRC NE 0.
      CLEAR SY-SUBRC.
      CLEAR ZVTEST_215_02-ZCERTI .
    ENDIF.
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVTEST_215_02 USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVTEST_215_02-ZCODE TO
ZTTEST_215_COM-ZCODE .
MOVE ZVTEST_215_02-MANDT TO
ZTTEST_215_COM-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTTEST_215_COM'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTTEST_215_COM TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTTEST_215_COM'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
FORM COMPL_ZVTEST_215_02 USING WORKAREA.
*      provides (read-only) fields from secondary tables related
*      to primary tables by foreignkey relationships
ZTTEST_215_COM-MANDT =
ZVTEST_215_02-MANDT .
ZTTEST_215_COM-ZCODE =
ZVTEST_215_02-ZCODE .
ZTTEST_215_COM-ZCERTI1 =
ZVTEST_215_02-ZCERTI1 .
ZTTEST_215_COM-ZCERTI_CNT =
ZVTEST_215_02-ZCERTI_CNT .
ZTTEST_215_COM-ZCERTI2 =
ZVTEST_215_02-ZCERTI2 .
ZTTEST_215_COM-ZCERTI3 =
ZVTEST_215_02-ZCERTI3 .
    SELECT * FROM ZTTEST_215_CERTI WHERE
ZCERTI = ZTTEST_215_COM-ZCERTI1 .
ZVTEST_215_02-ZCERTI =
ZTTEST_215_CERTI-ZCERTI .
      EXIT.
    ENDSELECT.
    IF SY-SUBRC NE 0.
      CLEAR SY-SUBRC.
      CLEAR ZVTEST_215_02-ZCERTI .
    ENDIF.
ENDFORM.

* base table related FORM-routines.............
INCLUDE LSVIMFTX .
