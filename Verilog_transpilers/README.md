# Objet

Ce README aborde les points qui ne sont pas traités dans les répertoires associés aux codes d'exercices. Il s'agit des réponse aux questions rédactionnelles.
Ce répertoire contient également les dossiers associés aux exercices demandant l'implémentation de code.

## Différence Reg VS Wire

Reg et Wire sont des types de données qu'on utilise pour déclarer des variables. La différence entre les deux repose sur la manière dont ils sont utilisés en interne.

- Reg : Ils sont utilisés comme des registres conservant leur valeur jusqu'à modification. On ne peut pas appliquer un "assign" sur un type reg.
- Wire : Ils sont utilisés comme des fils électriques et transportent les signaux entre modules. Leur valeur est modifiable via un assign.

Il est plus intéressant d'utiliser le type reg en entrée de module pour éviter une écriture par-dessus la variable, tandis qu'il est préférable d'utiliser le type wire pour une sortie car cette dernière peut-être soumise à des changements au cours de la simulation.


## Différence Assign VS Always

Assign et Always sont deux moyens d'assigner des valeurs à des variables

- Assign: Permet de faire une affectation immédiate d'une variable.
- Always : Permet d'affecter une variable après qu'un event se déclenche.

Il est plus intéréssant d'utiliser assign de par sa simplicité et son efficacité. Pour des cas plus complexes d'affectation, il est intéressant d'utiliser always.
