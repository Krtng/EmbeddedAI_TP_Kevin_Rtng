
    #include <stdio.h>
    
    int simple_tree(float feature, int condition){
        return 1 - (feature > condition);
    }
    
    int decision_tree(float* features, int n_feature, int* conditions){
        for(int i = 0; i < n_feature; i++){
            if(simple_tree(features[i], conditions[i])){
                return 0;
            }
        }
        return 1;
    }
    
    int main(){
        
        float x_tab[3] = {1, 5, 9};
        int n_feature = sizeof(x_tab)/sizeof(float);
        int conditions[3] = {0, 1, 5};
        
        int decision = decision_tree(x_tab, n_feature, conditions);
        printf("Decision : %d", decision);
        
        return 0; 
    }
    