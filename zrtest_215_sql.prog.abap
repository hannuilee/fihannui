*&---------------------------------------------------------------------*
*& Report ZRTEST_215_SQL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_SQL.

DATA : LO_NATIVE_SQL TYPE REF TO CX_SY_NATIVE_SQL_ERROR.
CREATE OBJECT LO_NATIVE_SQL.

DATA LX_EXEC TYPE REF TO CX_ROOT.

DATA : LV_MSG TYPE STRING.

DATA : BEGIN OF GS_DATA,
        ITEMPARENT_CD TYPE I,
        ITEMCHILD_CD TYPE I,
        BOM_SQ TYPE I,
        JUST_QT TYPE I,
        USE_YN TYPE I,
        REMARK_DC(255),
       END OF GS_DATA.

DATA : GT_DATA LIKE GS_DATA OCCURS 0 WITH HEADER LINE.

DATA : BEGIN OF GS_DATA2,
        ONo TYPE I,
        OPos TYPE I,

        PlanedStart(100),
        PlanedEnd(100),
        Start(100),
        End(100),
*        PlanedEnd TYPE I,
*        Start TYPE I,
*        End TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,
*        OPos TYPE I,

       END OF GS_DATA2.

DATA : GT_DATA2 LIKE GS_DATA2 OCCURS 0 WITH HEADER LINE.


"MSSQL CONNECT
EXEC SQL.
  CONNECT TO 'MSSQL'
ENDEXEC.
IF SY-SUBRC <> 0.
  MESSAGE 'CONNECT FAIL' TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

*TRY.
*EXEC SQL.
*  DELETE FROM sapout.BOM
*ENDEXEC.
*
*LOOP AT GT_DATA INTO GS_DATA.
*"INSERT
**EXEC SQL.
**  INSERT INTO sapout.BOM
**              (ITEMPARENT_CD, ITEMCHILD_CD,
**               BOM_SQ, JUST_QT,
**               USE_YN, REMARK_DC)
**         VALUES (123, 10, 1, 1, 1, '{ FFFF }')
**ENDEXEC.
*
*  EXEC SQL.
*    INSERT INTO sapout.BOM
*                (ITEMPARENT_CD, ITEMCHILD_CD,
*                 BOM_SQ, JUST_QT,
*                 USE_YN, REMARK_DC)
*           VALUES (:GS_DATA-ITEMPARENT_CD,
*                   :GS_DATA-ITEMCHILD_CD,
*                   :GS_DATA-BOM_SQ,
*                   :GS_DATA-JUST_QT,
*                   :GS_DATA-USE_YN,
*                   :GS_DATA-REMARK_DC)
*  ENDEXEC.
*ENDLOOP.
*CATCH CX_SY_NATIVE_SQL_ERROR INTO LX_EXEC.
*  LV_MSG = LX_EXEC->GET_TEXT( ).
*  MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'E'.
*ENDTRY.
*
*IF LV_MSG IS INITIAL.
*  EXEC SQL.
*    COMMIT
*  ENDEXEC.
*
*ELSE.
*  EXEC SQL.
*    ROLLBACK
*  ENDEXEC.
*ENDIF.

"SELECT
"PART 1
EXEC SQL.
  OPEN dbcur FOR
    SELECT ONo, OPos,
           PlanedStart, PlanedEnd,
           Start, [End]
    FROM sapin.OrderPos
ENDEXEC.

"PART 2
DO.
  EXEC SQL.
    FETCH NEXT dbcur INTO :GS_DATA2
  ENDEXEC.
  IF SY-SUBRC <> 0.
    EXIT.
  ENDIF.

  APPEND GS_DATA2 TO GT_DATA2.
ENDDO.

"PART 3
EXEC SQL.
  CLOSE dbcur
ENDEXEC.

EXEC SQL.
  DISCONNECT 'MSSQL'
ENDEXEC.
IF SY-SUBRC <> 0.
  MESSAGE 'CONNECT FAIL' TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.




*"MSSQL CONNECT
*EXEC SQL.
*  CONNECT TO 'MSSQL'
*ENDEXEC.
*IF SY-SUBRC <> 0.
*  RAISE EXCEPTION TYPE CX_SY_NATIVE_SQL_ERROR
*    EXPORTING
*      TEXTID = CX_SY_NATIVE_SQL_ERROR=>CX_SY_NATIVE_SQL_ERROR.
*ENDIF.
*
*
*"MSSQP SELECT
*TRY.
**EXEC SQL.
**  OPEN dbcur FOR
**    SELECT ITEMPARENT_CD, ITEMCHILD_CD, BOM_SQ, JUST_QT, USE_YN, REMARK_DC
**    FROM SapGwDb.sapout.BOM
**ENDEXEC.
*
*EXEC SQL.
*  OPEN dbcur FOR
*    SELECT ONo, OPos, PlanedStart, PlanedEnd, Start, [End]
*    FROM sapin.OrderPos
*ENDEXEC.
*
**DO.
**  EXEC SQL.
**    FETCH NEXT dbcur INTO :GS_DATA
**  ENDEXEC.
**  IF SY-SUBRC <> 0.
**    EXIT.
**  ENDIF.
**  APPEND GS_DATA TO GT_DATA.
**ENDDO.
*
*DO.
*  EXEC SQL.
*    FETCH NEXT dbcur INTO :GS_DATA2
*  ENDEXEC.
*  IF SY-SUBRC <> 0.
*    EXIT.
*  ENDIF.
*  APPEND GS_DATA2 TO GT_DATA2.
*ENDDO.
*
*EXEC SQL.
*  CLOSE dbcur
*ENDEXEC.
*
*CATCH CX_SY_NATIVE_SQL_ERROR INTO LX_EXEC.
*  LV_MSG = LX_EXEC->GET_TEXT( ).
*  MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'E'.
*ENDTRY.
*
*"MSSQL DB UPDATE
*TRY.
**EXEC SQL.
**  DELETE FROM SapGwDb.sapout.BOm
**ENDEXEC.
*
*
**EXEC SQL.
**  INSERT INTO SapGwDb.sapout.BOM
**              (ITEMPARENT_CD, ITEMCHILD_CD, BOM_SQ, JUST_QT, USE_YN, REMARK_DC)
**          VALUES (:GS_DATA-ITEMPARENT_CD, :GS_DATA-ITEMCHILD_CD, :GS_DATA-BOM_SQ,
**                    :GS_DATA-JUST_QT, :GS_DATA-USE_YN, :GS_DATA-REMARK_DC)
**ENDEXEC.
*
*EXEC SQL.
*  INSERT INTO SapGwDb.sapout.BOM
*              (ITEMPARENT_CD, ITEMCHILD_CD, BOM_SQ, JUST_QT, USE_YN, REMARK_DC)
*          VALUES (123, 12, 1, 1, 1, '{ FFFF }')
*ENDEXEC.
*CATCH CX_SY_NATIVE_SQL_ERROR INTO LX_EXEC.
*  LV_MSG = LX_EXEC->GET_TEXT( ).
*  MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'E'.
*ENDTRY.
*
*IF LV_MSG IS INITIAL.
*EXEC SQL.
*  COMMIT
*ENDEXEC.
*
*ELSE.
*EXEC SQL.
*  ROLLBACK
*ENDEXEC.
*ENDIF.
*
*
*"MSSQL DISCONNECT
*EXEC SQL.
*  DISCONNECT 'MSSQL'
*ENDEXEC.
