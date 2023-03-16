import joblib
import numpy as np

# Load the trained logistic regression model through the joblib file.
model = joblib.load('logistic_regression.joblib')


def get_coef(_model):
    return _model.intercept_, [coef for coef in _model.coef_]


# Get the coefficients of the model
intercept, coeffs = get_coef(model)
print(model.coef_, type(model.coef_))

x_input = [1.9176202951984055, 2]
x_size = len(x_input)

# String that contains the C code that computes the prediction of the model
code_pred = f"""
#include <stdio.h>
#include <stdlib.h>

float exp_approx(float x, int n_term){{
    float f_i = 1;
    float x_i = 1;
    float exp_x = 1;

    for (int i = 1; i <= n_term; i++){{
        x_i *= x;
        f_i *= i;
        exp_x += (x_i/f_i);
    }}
    return exp_x;
}}

float sigmoid(float x){{
    float sig = 1 / (1 + exp_approx(-x, 10));
    return sig;
}}

float prediction(float* features, int n_feature){{
   float thetas[] = {{{', '.join(str(coef) for coef in coeffs[0].tolist())}}};
   float pred = {intercept[0]};

   for (int i = 0; i < n_feature; i++){{
       pred += features[i] * thetas[i];
   }}
   return sigmoid(pred);
}}

int main(){{
    float x_tab[{x_size}] = {{{', '.join(str(x) for x in x_input)}}};
    int n_feature = sizeof(x_tab)/sizeof(float);

    float y_pred = prediction(x_tab, n_feature);
    printf("The machine will break soon : %f", y_pred);

    return 0; 
}}
"""

code_file = open('logistic_regression_prediction.c', 'w')
code_file.write(code_pred)
code_file.close()

y_pred = model.predict(np.array(x_input).reshape(1, -1))
print("\nThe machine will break soon (in Python) : " + str(y_pred))
print(
    "\nTo compile the C file generated and compare the results, launch a terminal and launch the following command : ")
print("gcc -o logistic_regression_prediction logistic_regression_prediction.c\n")
print("\nTo execute the compiled file, use the following command in the terminal : ")
print("./logistic_regression_prediction.exe\n")
