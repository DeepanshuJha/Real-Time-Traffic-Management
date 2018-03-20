# Real-Time-Traffic-Management

Code in C++

/* ****************************************ALGORITHM**************************** */
#include <bits/stdc++.h>

using namespace std;

struct lane{
    int density;
    int id;
    int vis;
    int on_off;
}la[4];

int main()
{
    srand(time(NULL));
    for(int x=0;x<4;x++){
    for(int i=0;i<4;i++){
        if(la[i].on_off==0){
            la[i].density += rand()%50;
        }
    }
    int index=0,ma=0;
        for(int i=0;i<4;i++){
            if(ma<la[i].density && la[i].vis==0){
                ma=la[i].density;
                index=i;
            }
        }
        la[index].vis=1;
        la[index].on_off=1;
        for(int i=0;i<4;i++){
            if(i!=index){
                la[i].on_off=0;
            }
        }

        cout<<"0-"<<la[0].density<<" "<<"1-"<<la[1].density<<" "<<"2-"<<la[2].density<<" "<<"3-"<<la[3].density<<'\n';
        la[index].density=0;
        cout<<index<<"\n";
    }
}
