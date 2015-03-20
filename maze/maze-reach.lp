linked(1,1).
linked(X,Y) :- parent(X,Y,DX,DY), linked(X+DX,Y+DY).
:- dim(X;Y), not linked(X,Y).

