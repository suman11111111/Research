%% Topology of the power system (IEEE 3 bus system)
% Information about the bus matrix
  % nd   V    Ang.    Pg      Qg      PL      QL      Gs       jBs    Type
  % (1) (2)   (3)     (4)     (5)     (6)     (7)     (8)      (9)    (10)
  % Colum 11: if the bus has shunt element =1, if it hasnt shunt element =0
bus=[1  1.00  0.000   0.00    0.00    0.00    0.00    0.000    0.000  1  0.0;
     2  1.00  0.000   0.25    0.00    0.00    0.00    0.000    0.000  2  0.0;
     3  1.00  0.000   0.00    0.00    0.45    0.15    0.000    0.000  3  0.0];
 
%Information about the line matrix
%COL 1.-  From bus
%COL 2.-  to bus
%COL 3.-  R P.U.
%COL 4.-  Xl P.U.
%COL 5.-  Xc (parallel) P.U.
%COL 6.-  Type of line: 0==Line ; 1==Transformer
%COL 7.- phase shifter angle
line=[1  2   0   0.1   0.0000   0.00   0.00;
      1  3   0   0.15  0.0000   0.00   0.00;
      2  3   0   0.1   0.0000   0.00   0.00]; 


