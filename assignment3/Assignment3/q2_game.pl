% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Sami Peng 501163935
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: fourExactly
%%%%% Below, you should define rules for the predicate "fourExactly(X,List)", 
%%%%% which takes in an input List and checks whether there are exactly 4 
%%%%% occurrences of a given element X in the list.
%%%%%
%%%%% If you introduce any other helper predicates for implementing fourExactly,
%%%%% they should be included in this section.

fourExactly(X, [X | Tail]) :- startfE(X,Tail,1).
fourExactly(X, [Y | Tail]) :- Y \= X, startfE(X,Tail,0).

startfE(X,[],C) :- C = 4.
startfE(X,[X|T],C) :- C < 4, C1 is C + 1, startfE(X,T,C1).
startfE(X,[Y|T],C) :- X \= Y, startfE(X, T,C).

%%%%% SECTION: gameSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than fourExactly and its helpers) that you choose to introduce.

exactlyX(E,[E | Tail], X) :- startX(E,Tail, X, 1).
exactlyX(E,[Y | Tail], X) :- Y \= E, startX(E,Tail, X, 0).

startX(E,[],X, C) :- X = C.
startX(E, [E|T], X, C) :- C < X, C1 is C + 1, startX(E,T,X,C1).
startX(E,[Y|T],X,C) :- E \= Y, startX(E, T,X,C).

outcome(n). outcome(l). outcome(d). outcome(w).

solve([Oakville1, Pickering1, Richmond_hill1, Scarborough1, Toronto1, Oakville2, Pickering2, Richmond_hill2, Scarborough2, Toronto2,
           Oakville3, Pickering3, Richmond_hill3, Scarborough3, Toronto3, Oakville4, Pickering4, Richmond_hill4, Scarborough4, Toronto4,
           Oakville5, Pickering5, Richmond_hill5, Scarborough5, Toronto5]) :-
    
    %constraint 1 
    %get basic info down first.
    outcome(Pickering1), outcome(Scarborough1), outcome(Pickering2), outcome(Oakville2),
    Pickering1 = l, Scarborough1 = w, Pickering2 = w, Oakville2 = l,

    %constrain 3
    %can verify contraint 1 and builds off of it. should be close together
    outcome(Oakville4), outcome(Oakville1), outcome(Oakville3),
    Oakville4 = n, exactlyX(w, [Oakville1,Oakville2,Oakville3], 2),

    %constraint 2 
    %once again, basic info
    outcome(Toronto1), outcome(Toronto2), outcome(Toronto3),
    Toronto3 = n, Toronto2 \= n, Toronto2 \= d, Toronto1 \= n, Toronto1 \= d, Toronto1 \= Toronto2,
    
    %constraint 5
    %should be here so that by the time constraint 6 is in place, it can have all info about round 1, 2, 3
    outcome(Richmond_hill3), outcome(Richmond_hill1), outcome(Richmond_hill2),
    exactlyX(w,[Richmond_hill1,Richmond_hill2,Richmond_hill3],1), exactlyX(l,[Richmond_hill1,Richmond_hill2,Richmond_hill3],1),

    %constraint 6
    %is put here because all previous constraints describe rounds 1, 2, and 3
    outcome(Scarborough2), outcome(Scarborough3), outcome(Pickering3),
    exactlyX(w,[Richmond_hill1,Oakville1,Scarborough1,Toronto1,Pickering1],2),
    exactlyX(l,[Richmond_hill1,Oakville1,Scarborough1,Toronto1,Pickering1],2),
    exactlyX(w,[Richmond_hill2,Oakville2,Scarborough2,Toronto2,Pickering2],2),
    exactlyX(l,[Richmond_hill2,Oakville2,Scarborough2,Toronto2,Pickering2],2),
    exactlyX(w,[Richmond_hill3,Oakville3,Scarborough3,Toronto3,Pickering3],2),
    exactlyX(l,[Richmond_hill3,Oakville3,Scarborough3,Toronto3,Pickering3],2),


    %constraint 4
    outcome(Pickering4),outcome(Oakville5), outcome(Pickering5), outcome(Richmond_hill5), 
    outcome(Richmond_hill4), outcome(Toronto4),outcome(Toronto5),outcome(Scarborough4),outcome(Scarborough5),
    fourExactly(d,[Oakville4,Pickering4, Richmond_hill4, Scarborough4, Toronto4]),fourExactly(d,[Oakville5,Pickering5, Richmond_hill5, Scarborough5, Toronto5]).



solve_and_print :- 
    solve([Oakville1, Pickering1, Richmond_hill1, Scarborough1, Toronto1, Oakville2, Pickering2, Richmond_hill2, Scarborough2, Toronto2,
           Oakville3, Pickering3, Richmond_hill3, Scarborough3, Toronto3, Oakville4, Pickering4, Richmond_hill4, Scarborough4, Toronto4,
           Oakville5, Pickering5, Richmond_hill5, Scarborough5, Toronto5]),
    
    write('----------------Match 1----------------'),
    nl,write('Oakville is '), write(Oakville1) ,nl,write('Pickering is '), write(Pickering1) , nl,write('Richmond Hill is '), write(Richmond_hill1),
    nl,write('Scarborough is '), write(Scarborough1),nl,write('Toronto is '), write(Toronto1),nl,
    write('----------------Match 2----------------'),
    nl,write('Oakville is '), write(Oakville2) ,nl,write('Pickering is '), write(Pickering2) , nl,write('Richmond Hill is '), write(Richmond_hill2),
    nl,write('Scarborough is '), write(Scarborough2),nl,write('Toronto is '), write(Toronto2),nl,
    write('----------------Match 3----------------'),
    nl,write('Oakville is '), write(Oakville3) ,nl,write('Pickering is '), write(Pickering3) , nl,write('Richmond Hill is '), write(Richmond_hill3),
    nl,write('Scarborough is '), write(Scarborough3),nl,write('Toronto is '), write(Toronto3),nl,
    write('----------------Match 4----------------'),
    nl,write('Oakville is '), write(Oakville4) ,nl,write('Pickering is '), write(Pickering4) , nl,write('Richmond Hill is '), write(Richmond_hill4),
    nl,write('Scarborough is '), write(Scarborough4),nl,write('Toronto is '), write(Toronto4),nl,
    write('----------------Match 5----------------'),
    nl,write('Oakville is '), write(Oakville5) ,nl,write('Pickering is '), write(Pickering5) , nl,write('Richmond Hill is '), write(Richmond_hill5),
    nl,write('Scarborough is '), write(Scarborough5),nl,write('Toronto is '), write(Toronto5),nl.



