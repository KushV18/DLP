/*salary calculation*/
void main(){
    long int bs , da , hra , gs;
    //take basic salary as input
    scanf("%1d",&bs);
    //calculate allowances
    da = bs * 0.40;
    hra = bs * 0.20;
    gs = bs+da+hra;
    //display salary slip
    printf("\n\nbs : %1d",bs);
    printf("\nda : %1d",da);
    printf("\nhra : %1d",hra);
    printf("\ngs : %1d",gs);

}