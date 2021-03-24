*&---------------------------------------------------------------------*
*& Report ZPROG_BASIS2_E27
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_basis2_e27 MESSAGE-ID zmsg_e27.

* Variables
DATA :
  airline(2)     TYPE c, " pour stocker la companie aérienne entrée par l'utilisateur
  idemployee(10) TYPE n. " pour rajouter les 0 devant l'id employee

* Paramètres
PARAMETERS :
  pa_01 TYPE ztt_employee_e27-carrier DEFAULT 'AA', " Airline
  pa_02 TYPE ztt_employee_e27-id_employee DEFAULT 1. " ID Employee

* Début du programme
START-OF-SELECTION .
* Si les paramètres n'ont pas été saisis
  IF pa_01 IS INITIAL OR pa_02 IS INITIAL.
*   on affiche le message nécessaire
    message s000 with 'Airline'(p01) 'ID Employee'(p02).
*   Please, enter a correct parameter for &1 or &2
    EXIT.
  ENDIF.

* Si les paramètres ont été saisis
  IF pa_01 IS NOT INITIAL AND pa_02 IS NOT INITIAL.

*   on insère les paramètres dans les variables
    airline = pa_01.
    idemployee = pa_02.

*   on affiche tout ça
    WRITE : / 'Airline'(p01), 30 airline,
            / 'ID Employee'(p02), idemployee UNDER airline.
  ENDIF.
