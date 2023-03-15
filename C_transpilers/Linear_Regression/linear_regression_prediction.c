
#include <stdio.h>
#include <stdlib.h>

float prediction(float* features, int n_feature){
   float thetas[] = {-8152.937710156577, 717.2583697096838, 36824.195974256305, 101571.84002157039};
   float pred = thetas[0];
   
   for (int i = 0; i < n_feature; i++){
       pred += features[i] * thetas[i+1];
   }
   return pred;
}

int main(){
    float x_tab[3] = {1, 2, 3};
    int n_feature = sizeof(x_tab)/sizeof(float);
    
    float y_pred = prediction(x_tab, n_feature);
    printf("Predicted house price : %f", y_pred);
    
    return 0; 
}
