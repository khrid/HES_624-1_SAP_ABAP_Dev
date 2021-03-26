# 0552 - Open SQL
## Submitted challenge
### Main program
```abap
*&---------------------------------------------------------------------*
*& Report ZPROG_DATA_OPENSQL2_E27
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_data_opensql2_e27 MESSAGE-ID zmsg_e27.

* Variables
DATA : gti_depments TYPE zti_depment2_e27,
       gs_depment   LIKE LINE OF gti_depments.

* Paramètres utilisateur
PARAMETERS :  pa_01 TYPE s_carr_id.

* Debut du programme
START-OF-SELECTION .

  " Si le paramètre est vide
  IF pa_01 IS INITIAL.
    " On affiche un message
    MESSAGE s000 WITH 'Airline'(p01) 'Carrier'(p02).
    " On reste sur l'écran de saisie
    EXIT.
  ENDIF.

  " Sinon on appelle notre fonction
  CALL FUNCTION 'Z_FM_DB_ACCESS_SELECT2_E27'
    EXPORTING
      " la saisie utilisateur pour le carrier
      iv_carrier  = pa_01
    IMPORTING
      " la table qui contiendra le retour s'il y en a
      et_depments = gti_depments
    EXCEPTIONS
      " retour vide
      ex_empty    = 1
      " erreur inconnue
      ex_unknown  = 2
      " le reste
      OTHERS      = 3.

  " switch case sur le code renvoyé
  CASE sy-subrc.
    WHEN 0. " si pas d'erreurs => on a du contenu
      WRITE : / 'Airline : '(t04), pa_01. " on affiche le carrier choisi
      LOOP AT gti_depments INTO gs_depment. " boucle sur la table
        WRITE :  /  sy-tabix,             " index
                    gs_depment-carrier,   " carrier
                    gs_depment-department," departement
                    gs_depment-fax,       " n° de fax
                    gs_depment-tel.       " n° de tel
      ENDLOOP. " fin de la boucle
    WHEN 1. " si erreur 1 => empty
      WRITE : / 'Empty Selection'(t01).
    WHEN 2. " si erreur 2 => unkown
      WRITE : / 'Unknown error'(t02).
    WHEN OTHERS. " les autres
      WRITE : / 'Unkown error code'(t03).
  ENDCASE.
  ```
  
  ### Function module
  ```abap
  FUNCTION Z_FM_DB_ACCESS_SELECT2_E27.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CARRIER) TYPE  S_CARR_ID
*"  EXPORTING
*"     REFERENCE(ET_DEPMENTS) TYPE  ZTI_DEPMENT2_E27
*"  EXCEPTIONS
*"      EX_EMPTY
*"      EX_UNKNOWN
*"----------------------------------------------------------------------
  SELECT carrier, department, tel, fax
  FROM ztt_depment_e27
  WHERE carrier = @iv_carrier
  INTO CORRESPONDING FIELDS OF TABLE @et_depments.
  IF sy-subrc = 4 .
    RAISE ex_empty .
  ENDIF .
  IF sy-subrc <> 0 .
    RAISE ex_unknown .
  ENDIF .
ENDFUNCTION.
  ```
