import joblib

# Load the trained decision tree model through the joblib file.
model = joblib.load('decision_tree.joblib')

x_input = [1, 5, 9]
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

    code_file = open('simple_decision_tree.c', 'w')
    code_file.write(code_dt)
    code_file.close()

    print('\nTo compile your generated C program, use the following command in a terminal:')
    print('gcc -o simple_decision_tree simple_decision_tree.c\n')

    print('To execute the generated binary executable, use the following command in a terminal:')
    print('./simple_decision_tree.exe\n')

else:
    print("\nYou should have the same number of conditions and inputs.")
