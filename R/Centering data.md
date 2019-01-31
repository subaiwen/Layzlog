p.55 Gelman
Especially for models with interactions:
1. Centering by subtracting the mean of the data

2. Using a conventional centering point

The residual standard deviation and R2 do not change—linear transformation of the predictors does not affect the fit of a 
classical regression model—and the coefficient and standard error of the interaction do not change, but the main effects and 
the intercept move a lot and are now interpretable based on comparison to the mean/the conventional point of the data.

3. Standardizing
scale the difference

https://www3.nd.edu/~rwilliam/stats2/l53.pdf
https://biologyforfun.wordpress.com/2014/04/08/interpreting-interaction-coefficient-in-r-part1-lm/
Y = b0 + b1x1 + b2x2 +b3(x1x2)
b0: score of y for average x1 and average x2.
b1: main effect of x1 with average level of x2
b2: main effect of x1 with average level of x1
b3: 1 unit increase of one variable would cause an increase/decrease of b3 in the effect of the other variable
