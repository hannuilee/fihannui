*&---------------------------------------------------------------------*
*& Report ZRTEST_215_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_09.

CLASS C1 DEFINITION. "정의부
  PUBLIC SECTION. "PROTECTED / PRIVATE
  METHODS M1.
ENDCLASS.

CLASS C1 IMPLEMENTATION. "실행부
  METHOD M1.
    WRITE : / 'CLASS TEST!!'.
  ENDMETHOD.
ENDCLASS.

 DATA : GO_1 TYPE REF TO C1. "객체참조변수

START-OF-SELECTION.
 CREATE OBJECT GO_1. "객체생성

 CALL METHOD GO_1->M1. "메소드 호출
