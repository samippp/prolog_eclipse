% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Sami Peng 501163935
%%%%% NAME: Feroz Noormohamed 500203723
%%%%% NAME: Mohammad Abdul Rahman 500961636
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%
%%%%% Below you can find the KB given in the assignment PDF. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% Do not put any part of the KB in the robocup section below. That section, should only
%%%%% have statements for the canPass, canScore, and any helper predicates needed for computing those
robot(r1).     robot(r2).     robot(r3).
robot(r4).     robot(r5).     robot(r6).
hasBall(r3).
pathClear(r1, net).    pathClear(r2, r1).    pathClear(r3, r2).
pathClear(r3, net).    pathClear(r3, r1).    pathClear(r3, r4).
pathClear(r4, net).    pathClear(r1, r5).    pathClear(r5, r6).

%%%%% SECTION: robocup
%%%%% Put your rules for canPass, canScore, and any helper predicates below

my_length([], 0).

my_length([_|Tail], Size) :-
    my_length(Tail, TailSize),
    Size is TailSize + 1.

pathClearSym(R1, R2) :- pathClear(R1, R2).
pathClearSym(R1, R2) :- pathClear(R2, R1).
append_list([], List, List).

append_list([Head|Tail1], List2, [Head|Result]) :-
    append(Tail1, List2, Result).

append_element(Element, [], [Element]).
append_element(Element, [Head|Tail], [Head|NewTail]) :-
    append_element(Element, Tail, NewTail).

notMember(_, []).
notMember(Element, [Head|Tail]) :-
    Element \= Head,          
    notMember(Element, Tail).  

canPass(R1, R2 , M, Path) :-
    robot(R1), robot(R2),
    R1 \= R2,
    pathClearSym(R1,R2),
    M >= 1,
    Path = [R1,R2].

canPass(R1, R2, M, Path) :-
    robot(R1), robot(R2),
    R1 \= R2,
    not pathClearSym(R1,R2),
    M > 1,
    pathClearSym(R1, R3),
    M1 is M - 1,
    meow(R3, R2, M1, [R1,R3], R),
    Path = R.

meow(R1,R2,M,Path, Res) :-
    robot(R1), robot(R2),
    not pathClearSym(R1,R2),
    M > 1,
    pathClearSym(R1, R3),
    M1 is M - 1,
    notMember(R3, Path),
    append_element(R3, Path, L),
    meow(R3,R2,M1,L,Res).

meow(R1,R2,M,Path, Res) :- 
    robot(R1), robot(R2),
    pathClearSym(R1,R2),
    M >= 1,
    M1 is M - 1,
    append_element(R2,Path, L),
    Res = L.


canScore(R, M, P) :-
    robot(R),
    pathClear(R,net),
    hasBall(R),
    P = [R,net].

canScore(R,M,P) :-
    hasBall(R2),
    canPass(R2,R,M,Path),
    my_length(Path, S),
    M1 is M - S + 1,
    gogo(R,M1,Path,Res),
    P = Res.

gogo(R,M,P,Res ) :-
    robot(R),
    not pathClear(R,net),
    M > 1,
    pathClearSym(R,R2),
    M1 is M - 1,
    notMember(R2, P),
    append_element(R2, P, L),
    gogo(R2,M1,L,Res).

gogo(R,M,P,Res) :-
    robot(R),
    pathClear(R,net),
    M >= 1,
    append_element(net,P, L),
    M1 is M - 1,
    Res = L.