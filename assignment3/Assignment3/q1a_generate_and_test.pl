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

%%%%% SECTION: puzzleGenerateAndTest
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce

solve([J, E, T, A, X, L, O, V]) :-
    digit(J), digit(E), digit(T), digit(A),
    digit(X), digit(L), digit(O), digit(V),            % generate
    
    J > 0, A > 0, L > 0,                               % leading digits can't be zero

    LOVE is 1000 * L + 100 * O + 10 * V + E,
    JET is 100 * J + 10 * E + T,
    AX is 10 * A + X,
    AXLE is 1000 * A + 100 * X + 10 * L + E,           % test
    
    LOVE is JET * AX,
    LOVE is AXLE + 10 * JET,

    all_diff([J, E, T, A, X, L, O, V]).                % test

digit(0). digit(1). digit(2). digit(3). digit(4).       % digit generation
digit(5). digit(6). digit(7). digit(8). digit(9).

all_diff([]).                                           % base case
all_diff([N|L]) :-                                      % recursive step
    not(my_member(N, L)),
    all_diff(L).

my_member(N, [N|_]).                                    % custom member check
my_member(N, [_|L]) :-
    my_member(N, L).

% Print the solution using built-in write/1
solve_and_print :-
    solve([J, E, T, A, X, L, O, V]),
    write('J = '), write(J), write(', E = '), write(E), write(', T = '), write(T), write(', A = '),
    write(A), write(', X = '), write(X), write(', L = '), write(L), write(', O = '), write(O), write(', V = '), writeln(V),
    JET is 100 * J + 10 * E + T,
    AX is 10 * A + X,
    LOVE is 1000 * L + 100 * O + 10 * V + E,
    write('JET = '), write(JET), write(', AX = '), write(AX), write(', LOVE = '), writeln(LOVE).
