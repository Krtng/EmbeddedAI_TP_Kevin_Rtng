import joblib
import numpy as np
from sklearn import linear_model, tree

# Load the trained model through the joblib file.
model = joblib.load('regression.joblib')

# If the model is a Linear Regression
if isinstance(model, linear_model.LinearRegression):
    coeffs = [model.intercept_] + [coef for coef in model.coef_]

    x_input = [1, 2, 3]
    x_size = len(x_input)

    code_linear = f"""
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

    code_file = open('transpiler_linear_regression.c', 'w')
    code_file.write(code_linear)
    code_file.close()

    y_pred_lr = model.predict(np.array(x_input).reshape(1, -1))
    print("\nLinear Regression prediction : " + str(y_pred_lr))
    print('Generated C file : transpiler_linear_regression.c')

# If the model is a Logistic Regression
elif isinstance(model, linear_model.LogisticRegression):
    intercept, coeffs = model.intercept_, [coef for coef in model.coef_]

    x_input = [1.9176202951984055, 2]
    x_size = len(x_input)

    code_logistic = f"""
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
        float sig = 1 / (1 + exp_approx(-x, 7));
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
        printf("Logistic Regression Prediction: %f", y_pred);

        return 0; 
    }}
    """

    code_file = open('transpiler_logistic_regression.c', 'w')
    code_file.write(code_logistic)
    code_file.close()

    y_pred = model.predict(np.array(x_input).reshape(1, -1))
    print("\nLogistic Regression Prediction : " + str(y_pred))
    print('Generated C file : transpiler_logistic_regression.c')

# If the model is a Decision Tree
elif isinstance(model, tree.DecisionTreeClassifier):
    x_input = [-5, 0, 3]
    x_size = len(x_input)
    conditions = [0, 1, 5]
    cond_size = len(conditions)

    if x_size == cond_size:
        code_dt = f"""
        #include <stdio.h>

        int simple_tree(float feature, int condition){{
            return 1 - (feature > condition);
        }}

        int decision_tree(float* features, int n_feature, int* conditions){{
            for(int i = 0; i < n_feature; i++){{
                if(simple_tree(features[i], conditions[i])){{
                    return 0;
                }}
            }}
            return 1;
        }}

        int main(){{

            float x_tab[{x_size}] = {{{', '.join(str(x) for x in x_input)}}};
            int n_feature = sizeof(x_tab)/sizeof(float);
            int conditions[{cond_size}] = {{{', '.join(str(x) for x in conditions)}}};

            int decision = decision_tree(x_tab, n_feature, conditions);
            printf("Decision : %d", decision);

            return 0; 
        }}
        """

        code_file = open('transpiler_decision_tree.c', 'w')
        code_file.write(code_dt)
        code_file.close()
        print('Generated C file : transpiler_decision_tree.c')

    else:
        print("\nYou should have the same number of conditions and inputs.")


print('\nTo compile your generated C program, use the following command in a terminal:')
print('gcc -o transpiler_model_type transpiler_model_type.c\n')

print('To execute the generated binary executable, use the following command in a terminal:')
print('./transpiler_model_type.exe\n')
