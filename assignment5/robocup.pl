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
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: robocup_setup
%%%%%
%%%%% These lines allow you to write statements for a predicate that are not consecutive in your program
%%%%% Doing so enables the specification of an initial state in another file
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
:- dynamic hasBall/2.
:- dynamic robotLoc/4.
:- dynamic scored/1.

%%%%% This line loads the generic planner code from the file "planner.pl"
%%%%% Just ensure that that the planner.pl file is in the same directory as this one
:- [planner].

%%%%% SECTION: init_robocup
%%%%% Loads the initial state from either robocupInit1.pl or robocupInit2.pl
%%%%% Just leave whichever one uncommented that you want to test on
%%%%% NOTE, you can only uncomment one at a time
%%%%% HINT: You can create other files with other initial states to more easily test individual actions
%%%%%       To do so, just replace the line below with one loading in the file with your initial state
:- [robocupInit1].
%:- [robocupInit2].

%%%%% SECTION: goal_states_robocup
%%%%% Below we define different goal states, each with a different ID
%%%%% HINT: It may be useful to define "easier" goals when starting your program or when debugging
%%%%%       You can do so by adding more goal states below
%%%%% Goal XY should be read as goal Y for problem X

%% Goal states for robocupInit1
goal_state(11, S) :- robotLoc(r1, 0, 1, S).
goal_state(12, S) :- hasBall(r2, S).
goal_state(13, S) :- hasBall(r3, S).
goal_state(14, S) :- scored(S). 
goal_state(15, S) :- robotLoc(r1, 2, 2, S).
goal_state(16, S) :- robotLoc(r1, 3, 2, S).

%% Goal states for robocupInit1
goal_state(21, S) :- scored(S). 
goal_state(22, S) :- robotLoc(r1, 2, 4, S).

%%%%% SECTION: precondition_axioms_robocup
%%%%% Write precondition axioms for all actions in your domain. Recall that to avoid
%%%%% potential problems with negation in Prolog, you should not start bodies of your
%%%%% rules with negated predicates. Make sure that all variables in a predicate 
%%%%% are instantiated by constants before you apply negation to the predicate that 
%%%%% mentions these variables. 

inBoundsRow(Row) :- numRows(X), Row < X, Row >= 0.
inBoundsCol(Col) :- numCols(X), Col < X, Col >= 0.

occupied(Row,Col,S) :- robot(R),robotLoc(R,Row,Col,S).
occupied(Row,Col,S) :- opponentAt(Row,Col).

% Robot 1 has to be a robot, either can move 1 vert or horz, and no opponents  at the new pos and no ally robot at the new pos.
poss(move(Robot, Row1, Col1, Row2, Col2), S) :- 
    robot(Robot) , robotLoc(Robot,Row1,Col1,S), 
    Row2 is Row1 + 1, numRows(X), Row2 < X,
    Col1 = Col2, not occupied(Row2,Col2,S).

poss(move(Robot, Row1, Col1, Row2, Col2), S) :- 
    robot(Robot) , robotLoc(Robot,Row1,Col1,S), 
    Row2 is Row1 - 1, Row2 >= 0,
    Col1 = Col2, not occupied(Row2,Col2,S).

poss(move(Robot, Row1, Col1, Row2, Col2), S) :- 
    robot(Robot) , robotLoc(Robot,Row1,Col1,S),
    Row2 = Row1, Col2 is Col1 + 1, numCols(X), Col2 < X,
    not occupied(Row2,Col2,S).

poss(move(Robot, Row1, Col1, Row2, Col2), S) :- 
    robot(Robot) , robotLoc(Robot,Row1,Col1,S),
    Row2 = Row1, Col2 is Col1 - 1, Col2 >= 0,
    not occupied(Row2,Col2,S).

% move other way


% robot 1 and 2 has to be robot and robot 1 has ball in situation S. Robot can pass if they are on same row or column with no opponent at that row or column.
% horizontal 
% passing foward
poss(pass(Robot1, Robot2), S) :- 
    robot(Robot1), robot(Robot2), hasBall(Robot1,S), 
    robotLoc(Robot1,Row,Col1,S), robotLoc(Robot2,Row,Col2,S), Col1 < Col2, not (opponentAt(Row,Col), 
    Col > Col1, Col < Col2) .
% passing backward
poss(pass(Robot1, Robot2), S) :- 
    robot(Robot1), robot(Robot2), hasBall(Robot1,S), 
    robotLoc(Robot1,Row,Col1,S), robotLoc(Robot2,Row,Col2,S), Col1 > Col2, 
    not (opponentAt(Row,Col), Col > Col2, Col < Col1) .

% vertical 
poss(pass(Robot1, Robot2), S) :- 
    robot(Robot1), robot(Robot2), hasBall(Robot1,S), 
    robotLoc(Robot1,Row1,Col,S), robotLoc(Robot2,Row2,Col,S), Row1 < Row2,
    not ( opponentAt(Row,Col), Row > Row1, Row < Row2).

poss(pass(Robot1, Robot2), S) :- 
    robot(Robot1), robot(Robot2), hasBall(Robot1,S), 
    robotLoc(Robot1,Row1,Col,S), robotLoc(Robot2,Row2,Col,S), Row1 > Row2,
    not ( opponentAt(Row,Col), Row > Row2, Row < Row1).


% robot can shoot if it is robot and has ball and it is in same col as goal and if no opponent is at that col.
poss(shoot(Robot), S) :- 
    robot(Robot), hasBall(Robot,S), robotLoc(Robot,Row1,Col,S), 
    goalCol(Col), not (opponentAt(Row,Col), Row > Row1).

%%%%% SECTION: successor_state_axioms_robocup
%%%%% Write successor-state axioms that characterize how the truth value of all 
%%%%% fluents change from the current situation S to the next situation [A | S]. 
%%%%% You will need two types of rules for each fluent: 
%%%%% 	(a) rules that characterize when a fluent becomes true in the next situation 
%%%%%	as a result of the last action, and
%%%%%	(b) rules that characterize when a fluent remains true in the next situation,
%%%%%	unless the most recent action changes it to false.
%%%%% When you write successor state axioms, you can sometimes start bodies of rules 
%%%%% with negation of a predicate, e.g., with negation of equality. This can help 
%%%%% to make them a bit more efficient.
%%%%%
%%%%% Write your successor state rules here: you have to write brief comments %

% Robot loc changes if the most recent event tells the robot has moved to row and col.
robotLoc(Robot,Row,Col,[move(Robot,Row1,Col1,Row,Col)|S]).

% If not a move action, then search tail. The first clause make sures that there was no other movement to overwrite the location.
robotLoc(Robot,Row,Col, [A|S] ) :- not(A=move(Robot,_,_,_,_)), robotLoc(Robot,Row,Col,S). 

% robot has ball if the most recent action is that it has been passed ball
hasBall(Robot,[pass(Robot1,Robot)|S]).

% robot2 must not have been passed the ball
hasBall(Robot,[A|S]) :- not (A = pass(_,_)), hasBall(Robot,S).

% if most recent is scored
scored([shoot(Robot)|S]).

% you cant really unscore so just search for any scored action
scored([A|S]) :- not( A = shoot(Robot) ), scored(S).


%%%%% SECTION: declarative_heuristics_robocup
%%%%% The predicate useless(A,ListOfPastActions) is true if an action A is useless
%%%%% given the list of previously performed actions. The predicate useless(A,ListOfPastActions)
%%%%% helps to solve the planning problem by providing declarative heuristics to 
%%%%% the planner. If this predicate is correctly defined using a few rules, then it 
%%%%% helps to speed-up the search that your program is doing to find a list of actions
%%%%% that solves a planning problem. Write as many rules that define this predicate
%%%%% as you can: think about useless repetitions you would like to avoid, and about 
%%%%% order of execution (i.e., use common sense properties of the application domain). 
%%%%% Your rules have to be general enough to be applicable to any problem in your domain,
%%%%% in other words, they have to help in solving a planning problem for any instance
%%%%% (i.e., any initial and goal states).
%%%%%	
%%%%% write your rules implementing the predicate  useless(Action,History) here. %

% useless to move back to old pos immediately.
useless(move(Robot,Row1,Col1,Row2,Col2),[move(Robot,Row2,Col2,Row1,Col1)|S]).
% useless to pass back and forth immediately
useless(pass(Robot1,Robot2),[pass(Robot2,Robot1)|S]).


