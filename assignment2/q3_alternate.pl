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

%%%%% SECTION: alternatePlusMinus
%%%%% Put your rules for alternatePlusMinus and any helper predicates below

alternatePlusMinus([],Z) :- Z is 0.
alternatePlusMinus([H | T], Z) :- 
    meow(T,H, S, 0),
    Z is S.

meow([H| T],Acc , S, 1) :- 
    NextAcc is Acc - H,
    meow(T,NextAcc, S, 0).

meow([H| T],Acc, S, 0) :-
    NextAcc is Acc + H,
    meow(T, NextAcc, S, 1).

meow([],Acc,S,_) :- S is Acc.