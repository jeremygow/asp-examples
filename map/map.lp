#const width=21.
#const length=42.

dim(1..width).

{ solid(X,Y) :dim(X) :dim(Y) }.

start(1,1).
finish(width,width).

step(0,-1 ;; 0,1 ;; 1,0 ;; -1,0).

reachable(X,Y) :- start(X,Y), solid(X,Y).

reachable(NX,NY) :-
  reachable(X,Y),
  step(DX,DY),
  NX = X + DX,
  NY = Y + DY,
  solid(NX,NY).

at(X,Y, 0) :- start(X,Y), solid(X,Y).

at(NX,NY, T+1) :-
  at(X,Y, T),
  T < length,
  solid(NX,NY),
  step(DX,DY),
  NX = X + DX,
  NY = Y + DY,
  solid(NX,NY).

speedrunnable(X,Y) :- at(X,Y,T).

complete :- finish(X,Y), reachable(X,Y).
speedrun :- finish(X,Y), speedrunnable(X,Y).

:- not complete.
:- speedrun.

%% Symmetry
%horizontal_mismatch(X,Y) :- solid(X,Y), not solid(width-X+1,Y).
%vertical_mismatch(X,Y) :- solid(X,Y), not solid(X,width-Y+1).
%:- 1 { horizontal_mismatch(X,Y), vertical_mismatch(X,Y) }.

%% One-tile inland lakes
%lake(X,Y) :- dim(X;Y), solid(X+DX,Y+DY):step(DX,DY), not solid(X,Y).
%#maximize [ lake(X,Y) ].
%:- not 35 { lake(X,Y) }.
