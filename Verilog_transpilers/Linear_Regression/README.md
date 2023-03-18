# Appels

Ce module implémente une régression linéaire simple avec une entrée et deux coefficients, dont l'intercept.
Pour cela, il fait appelle à module multiplieur 16 bits, faisant le produit de deux vecteurs 16 bits donnés en entrée, et renvoyant le produit sous la forme d'un vecteur 32 bits.
Il fait également appel à deux instances du module d'additionneur 16 bits pour pouvoir effectueur une addition entre deux vecteurs 32 bits.

Ce module implémente la formule de régression linéaire suivante :
```python
y = 10000 + x1 * 10000
```

Ce module d'additionneur 16 bits fait lui-même appel à deux instances du module additionneur 8 bits.

# Résultats

![image](https://user-images.githubusercontent.com/66918934/226139214-1c6ac56b-2ab8-4c92-b47d-d072629cc238.png)

![image](https://user-images.githubusercontent.com/66918934/226139305-2a7ed414-e902-4bd8-b2e1-5ff83c36abe4.png)

Les résultats sont cohérents pour l'implémentation de cette régression linéaire simple.
