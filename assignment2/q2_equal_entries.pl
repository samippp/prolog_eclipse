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

%%%%% SECTION: equalEntries
%%%%% Put your rules for equalEntries below

equalEntries([],[],[]).

equalEntries([H1],[H1], [true]).
equalEntries([H1],[H2], [false]) :- H1 \= H2.

equalEntries([H1|T1],[H1|T2], [true|NewTail]) :- 
    equalEntries(T1, T2, NewTail).

equalEntries([H1|T1],[H2|T2], [false|NewTail]) :- 
    H1 \= H2 ,
    equalEntries(T1, T2, NewTail).