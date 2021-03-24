# 0453 Complex Objects
## Submitted challenge
```abap
*&---------------------------------------------------------------------*
*& Report ZPROG_COMPLEX_OBJECT2_E27
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_complex_object2_e27 MESSAGE-ID zmsg_e27.


DATA: gti_depments TYPE zti_depment2_e27,
      gs_depment   LIKE LINE OF gti_depments.


*-----------------------------------------------------------
START-OF-SELECTION . " Program Start at this point
*-----------------------------------------------------------

  gs_depment-carrier    = 'SR'.
  gs_depment-department = 'IT'.
  gs_depment-fax        = '0271234567'.
  gs_depment-tel        = '0271234568'.
  gs_depment-name       = 'Informatique'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'AF'.
  gs_depment-department = 'RH'.
  gs_depment-fax        = '0272234567'.
  gs_depment-tel        = '0272234568'.
  gs_depment-name       = 'Ressources humaines'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'LH'.
  gs_depment-department = 'LOG'.
  gs_depment-fax        = '0273234567'.
  gs_depment-tel        = '0273234568'.
  gs_depment-name       = 'Logistique'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'SR'.
  gs_depment-department = 'MRK'.
  gs_depment-fax        = '0274234567'.
  gs_depment-tel        = '0274234568'.
  gs_depment-name       = 'Marketing'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'LH'.
  gs_depment-department = 'ACH'.
  gs_depment-fax        = '0275234567'.
  gs_depment-tel        = '0275234568'.
  gs_depment-name       = 'Achats'.

  INSERT gs_depment INTO TABLE gti_depments.


* Afficher le contenu de la table
  SKIP .
  WRITE : / 'Display gti_depments' .
  ULINE.
  LOOP AT gti_depments INTO gs_depment.
    WRITE : / sy-tabix, gs_depment.
  ENDLOOP.

* Effectuer la lecture de la ligne numéro 3 (lecture index) + Afficher
  SKIP 2.
  WRITE : / 'Read by Index (3) :'.
  ULINE.
  WRITE :
          / '- Carrier', 30 gti_depments[ 3 ]-carrier,
          / '- Department', 30 gti_depments[ 3 ]-department,
          / '- Fax', 30 gti_depments[ 3 ]-fax,
          / '- Telephone', 30 gti_depments[ 3 ]-tel,
          / '- Name', 30 gti_depments[ 3 ]-name.

* Effectuer la lecture de la ligne selon la clé primaire de la ligne 4 (selon vos données saisies) + Afficher
* N'oubliez pas de gérer les erreurs si la ligne n'existe pas
  SKIP 2.
  WRITE : / 'Read by Key (target is line 4) :'.
  ULINE.
  TRY .
      gs_depment = gti_depments[ carrier = 'SR' department = 'MRK' ] .
      WRITE :
      / '- Carrier', 30 gs_depment-carrier,
      / '- Department', 30 gs_depment-department,
      / '- Fax', 30 gs_depment-fax,
      / '- Telephone', 30 gs_depment-tel,
      / '- Name', 30 gs_depment-name.
    CATCH cx_sy_itab_line_not_found.
      WRITE : / 'No Key found'.
  ENDTRY.


* A la fin du programme, supprimer le contenu de la table interne et libérer la mémoire occupée
  SKIP 2.
  WRITE : / 'Delete Internal Table :'.
  ULINE.
  FREE gti_depments .
  WRITE :
  / '- gti_depments deleted'.
```

## Teacher's feedback
> Voici ton feedback
> - DDIC
>   - Structure
>     - Champ = OK (nom et data element idem à la table DB => tip top)
>     - Enhancement category = OK
>   - Table interne
>     - Line = OK
>     - Primary Key = OK (idem PK table ZTT_DEPMENT_E27) Bravo
> - Program
>   - Declaration = OK (like line of) 😉
>   - Remplir la table interne = OK 
>   - Afficher le contenu de la table interne = OK (sy-tabix + structure-champs)
>     - Préférence pour mettre structure-champs => pas uniquement structure (au cas ou un autre développeur ajoute des champs à ta structure ZST_... => ton programme sera modifié :-/
>   - Lecture par index = OK (new synthax 😉)
>   - Lecture par key = OK (c'est juste)
>     - Tu aurais pu noter également en 1 seul "ligne" comme avec l'accès par index
>     WRITE :  / '- Carrier', 30 gti_depments[ carrier = 'SR' department = 'MRK' ]-carrier,
>   - Delete = OK
>   - Text Element = Aucune gestion des éléments écrit en dur (vert) ☹
>   

## Reworked challenge
```abap
*&---------------------------------------------------------------------*
*& Report ZPROG_COMPLEX_OBJECT2_E27
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_complex_object2_e27 MESSAGE-ID zmsg_e27.


DATA: gti_depments TYPE zti_depment2_e27,
      gs_depment   LIKE LINE OF gti_depments.


*-----------------------------------------------------------
START-OF-SELECTION . " Program Start at this point
*-----------------------------------------------------------

  gs_depment-carrier    = 'SR'.
  gs_depment-department = 'IT'.
  gs_depment-fax        = '0271234567'.
  gs_depment-tel        = '0271234568'.
  gs_depment-name       = 'Informatique'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'AF'.
  gs_depment-department = 'RH'.
  gs_depment-fax        = '0272234567'.
  gs_depment-tel        = '0272234568'.
  gs_depment-name       = 'Ressources humaines'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'LH'.
  gs_depment-department = 'LOG'.
  gs_depment-fax        = '0273234567'.
  gs_depment-tel        = '0273234568'.
  gs_depment-name       = 'Logistique'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'SR'.
  gs_depment-department = 'MRK'.
  gs_depment-fax        = '0274234567'.
  gs_depment-tel        = '0274234568'.
  gs_depment-name       = 'Marketing'.

  INSERT gs_depment INTO TABLE gti_depments.

  gs_depment-carrier    = 'LH'.
  gs_depment-department = 'ACH'.
  gs_depment-fax        = '0275234567'.
  gs_depment-tel        = '0275234568'.
  gs_depment-name       = 'Achats'.

  INSERT gs_depment INTO TABLE gti_depments.


* Afficher le contenu de la table
  SKIP .
  WRITE : / 'Display gti_depments'(t01) .
  ULINE.
  LOOP AT gti_depments INTO gs_depment.
    WRITE : / sy-tabix, gs_depment-carrier,
                        gs_depment-department,
                        gs_depment-fax,
                        gs_depment-tel,
                        gs_depment-name.
  ENDLOOP.

* Effectuer la lecture de la ligne numéro 3 (lecture index) + Afficher
  SKIP 2.
  WRITE : / 'Read by Index (3) :'(t02).
  ULINE.
  WRITE :
          / '- ', 'Carrier'(t03), 30 gti_depments[ 3 ]-carrier,
          / '- ', 'Department'(t04), 30 gti_depments[ 3 ]-department,
          / '- ', 'Fax'(t05), 30 gti_depments[ 3 ]-fax,
          / '- ', 'Telephone'(t06), 30 gti_depments[ 3 ]-tel,
          / '- ', 'Name'(t07), 30 gti_depments[ 3 ]-name.

* Effectuer la lecture de la ligne selon la clé primaire de la ligne 4 (selon vos données saisies) + Afficher
* N'oubliez pas de gérer les erreurs si la ligne n'existe pas
  SKIP 2.
  WRITE : / 'Read by Key (target is line 4) :'(t08).
  ULINE.
  TRY .
      gs_depment = gti_depments[ carrier = 'SR' department = 'MRK' ] .
      WRITE :
      / '- ', 'Carrier'(t03), 30 gs_depment-carrier,
      / '- ', 'Department'(t04), 30 gs_depment-department,
      / '- ', 'Fax'(t05), 30 gs_depment-fax,
      / '- ', 'Telephone'(t06), 30 gs_depment-tel,
      / '- ', 'Name'(t07), 30 gs_depment-name.
    CATCH cx_sy_itab_line_not_found.
      WRITE : / 'No Key found'(t09).
  ENDTRY.


* A la fin du programme, supprimer le contenu de la table interne et libérer la mémoire occupée
  SKIP 2.
  WRITE : / 'Delete Internal Table :'(t10).
  ULINE.
  FREE gti_depments .
  WRITE :
  / '- ', 'gti_depments deleted'(t11).
```
