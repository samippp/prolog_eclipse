% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: 
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: listShift
%%%%% Put your rules for listShift and any helper predicates below

listShift(List, V, Result) :-
    length_list(List, Length),
    Shift is V mod Length,
    shift_by(List, Shift, Result).

shift_by(Result, 0, Result).
shift_by(next(H, T), V, Result) :-
    V > 0,
    append_to_end(T, H, TempList),
    V1 is V - 1,
    shift_by(TempList, V1, Result).


append_to_end(nil, Elem, next(Elem, nil)).
append_to_end(next(H, T), Elem, next(H, NewTail)) :-
    append_to_end(T, Elem, NewTail).


length_list(nil, 0).
length_list(next(_, T), Length) :-
    length_list(T, L1),
    Length is L1 + 1.
