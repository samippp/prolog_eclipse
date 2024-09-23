/*
%		example.pl :  a very simple PROLOG program.
%------------------------------------------------------------------
%
%  Assume that the predicate `likes' has as a first argument the person
%  and as a second argument a drink or a dessert. Assume also that
%  the predicate friendTo(X,Y) is true if X is a friend to Y.
%
%  You can load this program into the command-line version of ECLiPSe 
%  Prolog using the instruction 
%	>   [example].
%  If you work with a GUI version, read instructions about compiling at
%     http://www.scs.ryerson.ca/~mes/courses/cps721/ln/usingEclipse.txt
%  When you create your own databse, you have to type it first
%  in a file using your favorite text editor. Then you compile it
%  and ask testing queries.
*/

likes(mary,coffee).
likes(mary,tea).
likes(john,tea).
likes(fred,icecream).
likes(Person2,Something) :- friendTo(Person1,Person2), 
	likes(Person1,Something).
friendTo(mary,fred).
% The rule above is saying that if Person1 is a friend to Person2 and 
% Person1 likes something, then Person2 likes it too.


/* %% Save these logical statements in the file  example.pl  %% 
------------------------------------------------------------------


	A copy of my session with PROLOG.

Do the following: start your Prolog system and consult the Prolog 
program given above (in other words, compile your program).
Formulate queries in Prolog and then try to evaluate them. 
Compare your solutions with answers provided at the end of this handout.

1) Is there somebody who likes both coffee and pepsi?

2) Who likes icecream?

3) What is the name of a person who likes both coffee and tea?

4) What do both mary and fred like? List all things they like.


For simplicity, I consider here only a command-line version of Prolog.
Note that when Prolog replies, I can either hit the Enter key or type 
the semi-colon symbol ";" (or do another operation with the same meaning).
On some Prolog systems that provide graphical interface,
you can click on "more", but you cannot type ";" However, to consider 
both cases at once I talk below only about typing ";" symbol. If I typed
		  ;  
and there is a different reply to my query, then Prolog will give it 
to me. If there are no other answers besides those that Prolog has already 
generated, then Prolog will say "no" (i.e., "no more answers").

%%% TRY THIS EXERCISE YOURSELF BEFORE YOU READ THE SOLUTIONS %%%

^L
----------------------------------------------

 
?- [example].  %%you might need to type [example] to compile your file%%
yes


?- likes(X,coffee), likes(X,pepsi).
No (0.00s cpu)


?- likes(Person,icecream).
Person = fred
Yes (0.00s cpu, solution 1, maybe more) ? ;
No (0.00s cpu)


?- likes(Name, coffee), likes(Name, tea).
Name = mary
Yes (0.00s cpu, solution 1, maybe more) ? ;
Name = fred
Yes (0.00s cpu, solution 2, maybe more) ? ;
No (0.00s cpu)


?- likes(mary,What), likes(fred,What).

likes(mary,What), likes(fred,What).
What = coffee
Yes (0.00s cpu, solution 1, maybe more) ? ;
What = tea
Yes (0.01s cpu, solution 2, maybe more) ? ;
No (0.01s cpu)


?- halt.  %% On some Prolog systems you have to type   quit.  %%
*/
# 