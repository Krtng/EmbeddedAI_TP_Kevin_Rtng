import joblib
import numpy as np

# Load the trained linear regression model through the joblib file.
model = joblib.load('regression.joblib')


def get_coef(_model):
    return [_model.intercept_] + [coef for coef in _model.coef_]


# Get the coefficients of the model
coeffs = get_coef(model)

x_input = [1, 2, 3]
x_size = len(x_input)

# String that contains the C code that computes the prediction of the model
code_pred = f"""
#include <stdio.h>
#include <stdlib.h>

float prediction(float* features, int n_feature){{
   float thetas[] = {{{', '.join(str(coef) for coef in coeffs)}}};
   float pred = thetas[0];
   
   for (int i = 0; i < n_feature; i++){{
       pred += features[i] * thetas[i+1];
   }}
   return pred;
}}

int main(){{
    float x_tab[{x_size}] = {{{', '.join(str(x) for x in x_input)}}};
    int n_feature = sizeof(x_tab)/sizeof(float);
    
    float y_pred = prediction(x_tab, n_feature);
    printf("Predicted house price : %f", y_pred);
    
    return 0; 
}}
"""

code_file = open('linear_regression_prediction.c', 'w')
code_file.write(code_pred)
code_file.close()

y_pred = model.predict(np.array(x_input).reshape(1, -1))
print("\nPredicted house price in Python : " + str(y_pred))
print("\nTo compile the C file generated and compare the results, launch a terminal and launch the following command : ")
print("gcc -o linear_regression_prediction linear_regression_prediction.c\n")
