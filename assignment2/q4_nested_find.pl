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

%%%%% SECTION: nestedLists
%%%%% Put your rules for nestedFindDepth, nestedFindIndex, and any helper predicates below

% nestedFindDepth/3

% Case 1: Item is found at the current level
nestedFindDepth([Item|_], Item, 0).

% Case 2: The head is a sublist, search recursively
nestedFindDepth([Head|_], Item, Depth) :-
    is_list(Head),
    nestedFindDepth(Head, Item, SubDepth),
    Depth is SubDepth + 1.

% Case 3: The head is not a match, search the tail
nestedFindDepth([_|Tail], Item, Depth) :-
    nestedFindDepth(Tail, Item, Depth).

% nestedFindIndex/4

% Case 1: Item is found at the top level
nestedFindIndex([Item|_], Item, 0, 0).

% Case 2: The head is a sublist, search recursively within the sublist, keeping the index fixed
nestedFindIndex([Head|_], Item, Depth, Index) :-
    is_list(Head),
    nestedFindIndex(Head, Item, SubDepth, _),  % We discard the internal index of the sublist
    Depth is SubDepth + 1,  % Increase depth
    Index = 0.  % Keep top-level index fixed when searching sublist

% Case 3: The head is not a match, search the tail, incrementing the top-level index
nestedFindIndex([_|Tail], Item, Depth, Index) :-
    nestedFindIndex(Tail, Item, Depth, TailIndex),
    Index is TailIndex + 1.