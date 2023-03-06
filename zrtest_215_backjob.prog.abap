*&---------------------------------------------------------------------*
*& Report ZRTEST_215_BACKJOB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_BACKJOB.

DATA : GT_ZTTEST_215_HR_T LIKE ZTTEST_215_HR_T OCCURS 0 WITH HEADER LINE.
DATA : GT_ZTTEST_215_HR LIKE ZTTEST_215_HR OCCURS 0 WITH HEADER LINE.

PARAMETERS : P_CHAR TYPE CHAR10.

INITIALIZATION.

START-OF-SELECTION.
  IF P_CHAR <> 'BACKGROUND'.
    MESSAGE '수행할 수 없습니다!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  DELETE FROM ZTTEST_215_HR_T.

  SELECT *
    INTO TABLE GT_ZTTEST_215_HR
    FROM ZTTEST_215_HR.
  IF GT_ZTTEST_215_HR[] IS NOT INITIAL.
    GT_ZTTEST_215_HR_T[] = GT_ZTTEST_215_HR[].

    MODIFY ZTTEST_215_HR_T FROM TABLE GT_ZTTEST_215_HR_T.
    IF SY-SUBRC = 0.
      IF SY-BATCH IS NOT INITIAL.
        MESSAGE '[BATCH] 임시 이전 완료되었습니다.' TYPE 'S'.
      ELSE.
        MESSAGE '임시 이전 완료되었습니다.' TYPE 'S'.
      ENDIF.
    ENDIF.
  ENDIF.
