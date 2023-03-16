
#include <stdio.h>
#include <stdlib.h>

float exp_approx(float x, int n_term){
    float f_i = 1;
    float x_i = 1;
    float exp_x = 1;

    for (int i = 1; i <= n_term; i++){
        x_i *= x;
        f_i *= i;
        exp_x += (x_i/f_i);
    }
    return exp_x;
}

float sigmoid(float x){
    float sig = 1 / (1 + exp_approx(-x, 10));
    return sig;
}

float prediction(float* features, int n_feature){
   float thetas[] = {0.9974656792058785, 0.40076944833674133};
   float pred = -53.01180860105963;

   for (int i = 0; i < n_feature; i++){
       pred += features[i] * thetas[i];
   }
   return sigmoid(pred);
}

int main(){
    float x_tab[2] = {1.9176202951984056, 2};
    int n_feature = sizeof(x_tab)/sizeof(float);

    float y_pred = prediction(x_tab, n_feature);
    printf("The machine will break soon : %f", y_pred);

    return 0; 
}
