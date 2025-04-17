function E_mat=E(par)
    
    %Ref Angular Frequency
    omega_ref=par(1);
    
    %Inertia
    H1=par(2);
    H2=par(3);
    
    %Time Constant of d-axis
    Tdo1=par(4);
    Tdo2=par(5);

    %Time Constant of q-axis
    Tqo1=par(6); 
    Tqo2=par(7);

    %E Matrix
    E_mat=zeros(18,18);
    E_mat(1,1)=Tdo1;
    E_mat(2,2)=Tdo2;
    E_mat(3,3)=Tqo1;
    E_mat(4,4)=Tqo2;
    E_mat(5,5)=1;
    E_mat(6,6)=1;
    E_mat(7,7)=(2*H1)/omega_ref;
    E_mat(8,8)=(2*H2)/omega_ref;
end