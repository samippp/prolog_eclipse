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

%%%%% SECTION: listShift
%%%%% Put your rules for listShift and any helper predicates below

listShift(List, V, Result) :-
    getLength(List, Length),
    Shift is V mod Length,
    shiftElements(List, Shift, Result).

shiftElements(Result, 0, Result).
shiftElements(next(H, T), V, Result) :-
    V > 0,
    moveToEnd(T, H, TempList),
    V1 is V - 1,
    shiftElements(TempList, V1, Result).


moveToEnd(nil, Elem, next(Elem, nil)).
moveToEnd(next(H, T), Elem, next(H, NewTail)) :-
    moveToEnd(T, Elem, NewTail).

getLength(nil, 0).
getLength(next(_, T), Length) :-
    getLength(T, L1),
    Length is L1 + 1.

