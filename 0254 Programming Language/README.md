# 0254 - Programming Language
## Submitted challenge
```abap
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
```

## Teacher's feedback
> Voici le retour concernant ton challenge : 
> ![image](https://user-images.githubusercontent.com/389415/112306390-09ae3580-8ca0-11eb-9cef-99dc5ef88ed0.png)
> -	Ligne 10 et 11 : Il n'est pas nécessaire de déclarer les variables "airline(3)" et idemploye(10) car tu peux réutiliser les paramètres pa_01 et pa_02 qui contiennent la valeur > saisie par l'utilisateur
> De plus, pour ces variables, il aurait fallu utiliser les data-elments existant afin d'utiliser les principes de réutilisabilité et facilité de maintenance 😉
> 
> ![image](https://user-images.githubusercontent.com/389415/112306451-1a5eab80-8ca0-11eb-8c05-7628f89aa1cf.png)
>	- Ligne 29 : si tu arrives ici, c'est que l'utilisateur a saisi des valeurs sinon le programme se serait arrêté à la ligne 25 (EXIT.) Fait un test avec le debugger (/h dans la zone de commande avant d'exécuter le programme)
>	Tu peux donc juste afficher les valeurs des 2 paramètres sans utilisés les variables déclarées en ligne 10 et 11
