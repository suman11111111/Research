function xdot = formODE(t,x,h,A,B)
xdot = A*x + B*(x-h);
end