function fp=fin_pol(J,E)

    J=full(J);

    %Finite Poles

    pol=eig(full(J),E);
    s_pol=size(pol);
    
    fp=[];
    
    for i=1:s_pol(1)
        if pol(i)~=Inf
            fp=[fp;pol(i)];
        end
    end

end