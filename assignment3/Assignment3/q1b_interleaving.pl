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
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: puzzleInterleaving
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce

%%%%% The strategy we used for interleaving is computing the values as soon as they are assigned
%%%%% allowing us to exclude invalid solutions earlier.
%%%%%

solve([J, E, T, A, X, L, O, V]) :-
    digit(J), J > 0,                                      % J cannot be 0
    digit(A), A > 0,                                      % A cannot be 0
	digit(L), L > 0,                                      % L cannot be 0  


    digit(E), digit(T),                                    % Generate digits for E and T
    JET is 100 * J + 10 * E + T,                           % Compute JET

    digit(X), AX is 10 * A + X,                            % Generate X then Compute AX since A is already assigned

    digit(L), digit(O), digit(V),                          % Generate digits for L, O, V
    LOVE is 1000 * L + 100 * O + 10 * V + E,               % Compute LOVE

    LOVE is JET * AX,                                     % Test multiplication equation
    AXLE is 1000 * A + 100 * X + 10 * L + E,              % Test AXLE equation  
    LOVE is AXLE + 10 * JET,                              % Test addition equation

    all_diff([J, E, T, A, X, L, O, V]).                    % Ensure all letters have distinct values

% Define the digits 0-9
digit(0). digit(1). digit(2). digit(3). digit(4).          
digit(5). digit(6). digit(7). digit(8). digit(9).

% Custom all_diff helper
all_diff([]).                                               % Base case
all_diff([N|L]) :-                                          % Recursive step
    not(my_member(N, L)),                                   % Check N is not a member of the rest of the list
    all_diff(L).

% Custom member helper
my_member(N, [N|_]).
my_member(N, [_|L]) :- 
    my_member(N, L).


solve_and_print :-
    solve([J, E, T, A, X, L, O, V]),
    write('J = '), write(J), write(', E = '), write(E), write(', T = '), write(T), write(', A = '), write(A),
    write(', X = '), write(X), write(', L = '), write(L), write(', O = '), write(O), write(', V = '), writeln(V),
    JET is 100 * J + 10 * E + T,
    AX is 10 * A + X,
    LOVE is 1000 * L + 100 * O + 10 * V + E,
    write('JET = '), write(JET), write(', AX = '), write(AX), write(', LOVE = '), writeln(LOVE).