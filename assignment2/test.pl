dig(0). dig(1). dig(2). dig(3). dig(4).
dig(5). dig(6). dig(7). dig(8). dig(9).

all_diff([O,N,E,T,W]).
all_diff([]).
all_diff([N | L]) :- not member(N,L), all_diff(L).

solve( [O,N,E,T,W] ) :-
    dig(E),
    O is (E + E) mod 10, C1 is (E+E) // 10,
    O > 0,
    dig(N),
    W is (N+N+C1) mod 10, C2 is (N+N+C1) //10,
    T is (O+O+C2),
    T > 0,
    all_diff([O,N,E,T,W]).

print_solution :-
solve( [O,N,E,T,W] ),
write(''), write(S), write(E), write(N), write(D),nl,
write('+ '), write(M), write(O), write(R), write(E),nl,
write(' '),write("_____"),nl,
write(' '),write(M),write(O),write(N),write(E),write(Y),nl.