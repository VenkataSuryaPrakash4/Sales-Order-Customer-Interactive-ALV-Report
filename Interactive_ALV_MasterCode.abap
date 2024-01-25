*&---------------------------------------------------------------------*
*& Report Z_SL_ALVINTERAVTIVE_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zissue_alv.

INCLUDE zdd_intalv.          "Data Declaration.
INCLUDE zss_intaalv.         "Selection Screen.
INCLUDE zvalidation_intalv.  "Validation.


START-OF-SELECTION.
  PERFORM getdata.
