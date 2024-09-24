
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Sami Peng
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%
%%%%% Below you can find the KB given in the assignment. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% However, the queries you give in part b should be tested on this original KB
robot(r1). robot(r2). robot(r3).
robot(r4). robot(r5). robot(r6).

hasBall(r3).

pathClear(r1, net).
pathClear(r2, r1).
pathClear(r3, r2).
pathClear(r3, net).
pathClear(r3, r1).
pathClear(r3, r4).
pathClear(r4, net).
pathClear(r1, r5).
pathClear(r5, r6).

%%%%% SECTION: q3_rules
%%%%% Put statements for canPass and canScore below. 
%%%%% You may also define helper predicates in this section
%%%%% DO NOT PUT ATOMIC FACTS for robot, hasBall, or pathClear below.

% Symmetrical pathClear definition
pathClearSym(R1, R2) :- pathClear(R1, R2).
pathClearSym(R1, R2) :- pathClear(R2, R1).

% Base case: direct pass if path is clear and M >= 1
canPass(R1, R2, M) :-
    M >= 1,
    robot(R1),  % Ensure R1 is a valid robot
    robot(R2),  % Ensure R2 is a valid robot
    pathClearSym(R1, R2).

% Recursive case: indirect pass if R1 can pass the ball to R3,
% and R3 can pass the ball to R2 in at most M-1 passes.
canPass(R1, R2, M) :-
    M > 1,
    robot(R1),  % Ensure R1 is a valid robot
    robot(R2),  % Ensure R2 is a valid robot
    pathClearSym(R1, R3),
    M1 is M - 1,
    canPass(R3, R2, M1).
pass(R1,R2,M,Leftover) :- 
    M >= 1,
    robot(R1),  % Ensure R1 is a valid robot
    robot(R2),  % Ensure R2 is a valid robot
    pathClearSym(R1, R2),
    Leftover is M - 1.

pass(R1,R2,M,Leftover) :- 
    M > 1,
    robot(R1),  % Ensure R1 is a valid robot
    robot(R2),  % Ensure R2 is a valid robot
    pathClearSym(R1, R3),
    M1 is M - 1,
    pass(R3, R2, M1, Leftover).

canScore(R1, M) :- 
    M >= 1,
    robot(R1),
    hasBall(R1),
    hasBallScore(R1,M).

canScore(R1, M) :-
    M >= 1,
    robot(R1),
    not hasBall(R1),
    hasBall(R2),
    pass(R2,R1,M,L),
    hasBallScore(R1,L).

hasBallScore(R1, M) :- 
    M >= 1,
    robot(R1),
    pathClear(R1,net).

hasBallScore(R1, M) :-
    M > 1,
    robot(R1),
    M1 is M - 1,
    pathClearSym(R1,R2),
    hasBallScore(R2,M1).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW
