#const width=20.
param("width",width).
dim(1..width).

tile((X,Y)) :- dim(X), dim(Y).

adj((X1,Y1),(X2,Y2)) :-
 tile((X1,Y1)),
 tile((X2,Y2)),
 #abs(X1-X2)+#abs(Y1-Y2) == 1.

start((1,1)).
finish((width,width)).

% tiles have at most one named sprite
0 { sprite(T,wall;gem;altar) } 1 :- tile(T).

% there is exactly one altar and one gem in the whole level
1 { sprite(T,altar) : tile(T) } 1.
1 { sprite(T,gem) : tile(T) } 1.

wall(X,Y) :- sprite((X,Y),wall).
altar(X,Y) :- sprite((X,Y),altar).
gem(X,Y) :- sprite((X,Y),gem).
