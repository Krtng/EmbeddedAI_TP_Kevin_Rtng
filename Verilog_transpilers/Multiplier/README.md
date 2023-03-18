# Appels

Ce module, qui est un multiplieur 8 bits fournissant en sortie un vecteur 16 bits et une retenue, est le résultat d'un produit entre deux vecteurs 8 bits donnés en entrée.
Pour effectuer cette opération, nous multiplions chaque bit d'un des vecteurs par l'ensemble des bits de l'autre grâce à une porte "ET":

```verilog
wire [7:0] exemple = 8'b{entree1[bit_X]} & entree2;
```

Ensuite, on effectue la somme des multiplications grâce au module additionneur 8 bits implémentés dans le précédent exercice.
Après des additions successives et décalage de bits pour chaque addition, on obtient le produit de notre multiplication.

# Résultats

![image](https://user-images.githubusercontent.com/66918934/226138612-d7adf05a-3339-49a0-ae68-59321efc3ee5.png)

![image](https://user-images.githubusercontent.com/66918934/226138617-fc7a3693-5a19-4609-9190-57db3e3237e5.png)

Les résultats sont cohérents.
