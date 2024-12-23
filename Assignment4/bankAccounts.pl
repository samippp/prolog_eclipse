
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


%%%%% SECTION: database
%%%%% Put statements for account, created, lives, location and gender below

% account(AccountID, Name, Bank, Balance)

account(11,trump,cibc,100).
account(12,ann,metro_credit_union,4505).
account(13,robert,royal_bank_of_canada,1091).
account(14,feroz,cibc,5000).                    %account1 at cibc
account(15,marzy,bank_of_montreal,2500).
account(16,sami,td_canada_trust,14000).
account(17,feroz,cibc,8000).                    %account2 at cibc
account(18,mary,royal_bank_of_canada,3500).
account(19,sami,bank_of_montreal,6500).
account(20,raj,td_canada_trust,1500).
account(21,nancy,cibc,12000).
account(22,erica,metro_credit_union,11000).
account(23,philip,royal_bank_of_canada,7000).
account(24,feroz,scotiabank,500).
account(25,lebron,royal_bank_of_canada,600).

% created(AccountID, Name, Bank, Month, Year)

created(11,trump,cibc,11,2007).
created(12,ann,metro_credit_union,1,2008).
created(13,robert,royal_bank_of_canada,4,2018).
created(14,feroz,cibc,6,2007).                    %created1 at cibc
created(15,marzy,bank_of_montreal,2,2023).
created(16,sami,td_canada_trust,11,2016).
created(17,feroz,cibc,9,2023).                    %created2 at cibc
created(18,mary,royal_bank_of_canada,1,2018).
created(19,sami,bank_of_montreal,6, 2017).
created(20,raj,td_canada_trust,9,2012).
created(21,nancy,cibc,2, 2021).
created(22,erica,metro_credit_union,5, 2014).
created(23,philip,royal_bank_of_canada,6,2000).
created(24,feroz,scotiabank,9,2024).
created(25,lebron,royal_bank_of_canada,11,2024).

% lives(P, City), where P is a person name and City
lives(trump,seattle).
lives(lebron,losAngeles).
lives(philip,richmondHill). lives(ann,markham). lives(marzy,toronto).
lives(sami,scarborough). lives(feroz,brampton). lives(robert, markham).
lives(mary,toronto). lives(erica, sanFrancisco). lives(raj,scarborough).
lives(nancy, markham).

% location(X, C), where either X is a city and C is a country, or X is bank and C is a city

%cities
location(losAngeles,usa).
location(seattle,usa).
location(scarborough,canada). location(markham,canada).
location(sanFrancisco,usa). location(toronto,canada).
location(brampton,canada). location(missisauga,canada).
location(richmondHill,canada).

%banks
location(royal_bank_of_canada,toronto).
location(metro_credit_union,sanFrancisco).
location(cibc,markham).
location(td_canada_trust,brampton).
location(bank_of_montreal,scarborough).
location(scotiabank,toronto).

% gender(Name, X)specifies that a gender of a person N ame is X
gender(lebron,man).
gender(trump, man).
gender(ann, woman). gender(robert, man). gender(philip, man).
gender(feroz, man). gender(marzy, man). gender(sami, man).
gender(raj, man). gender(nancy, woman). gender(erica, woman).
gender(mary, woman).

%%%%% SECTION: lexicon
%%%%% Put the rules/statements defining articles, adjectives, proper nouns, common nouns,
%%%%% and prepositions in this section.
%%%%% You should also put your lexicon helpers in this section
%%%%% Your helpers should include at least the following:
%%%%%       bank(X), person(X), man(X), woman(X), city(X), country(X)
%%%%% You may introduce others as you see fit
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

%helpers

% Lexicon section

% Rule to identify cities
city(X) :- location(X, _), not(bank(X)).

% Rule to identify banks
bank(B) :- account(_, _, B, _).

% Rule to identify persons
person(P) :- account(_, P, _, _).
person(P) :- created(_, P, _, _, _).
person(P) :- lives(P, _).

% Rule to identify men
man(M) :- gender(M, man).

% Rule to identify women
woman(W) :- gender(W, woman).

% Rule to identify countries
country(X) :- location(_, X).
% Rule to find owner
owner(X) :- created(_,X,_,_,_).
% Rule to find account

%articles
article(a). article(an). article(the). article(any).
%Common nouns
common_noun(bank,X) :- bank(X). common_noun(city, X) :- city(X). common_noun(country,X) :- country(X). common_noun(man,X) :- man(X).
common_noun(woman,X) :- woman(X) . common_noun(owner,X) :- owner(X). common_noun(person,X) :- person(X). common_noun(account,X) :- account(X,_,_,_).
common_noun(balance,X) :- account(_,_,_,X). common_noun(american,X) :- lives(X,City), location(City,usa). common_noun(canadian,X) :- lives(X,City), location(City,canada).
common_noun(british,X) :- lives(X,City), location(City,uk).
%Proper_nouns
proper_noun(X) :- person(P). proper_noun(X) :- account(_, _, Bank, _). proper_noun(X) :- city(X). proper_noun(X) :- country(X). proper_noun(X) :- account(X,_,_,_). 
proper_noun(X) :- number(X).
%Adjectives

%lets deal with nations first.

%people
adjective(american,X) :- lives(X,Y), location(Y,usa). adjective(british,X) :- lives(X,Y), location(Y,uk). adjective(canadian,X) :- lives(X,Y), location(Y,canada).
%cities
adjective(american,X) :- location(X,usa). adjective(canadian,X) :- location(X,canada). adjective(X,british) :- location(X,uk).
%banks
adjective(american,X) :- location(X,City), location(City, usa). adjective(canadian,X) :- location(X,City), location(City,canada). adjective(british,X) :- location(X,City), location(City,uk).
%account
adjective(Y,X) :- account(X,_,B,_), adjective(Y,B). 

adjective(female,X) :- woman(X). adjective(male,X) :- man(X). 
%local means canadian.
adjective(local,X) :- adjective(canadian,X). 

%foreign means everything not canadian
adjective(foreign,X) :- adjective(american,X).
adjective(foreign,X) :- adjective(british,X).

adjective(small,X) :- account(X, _, _, Y), Y < 1000. adjective(medium,X) :- account(X, _, _, Y), Y > 1000, Y < 10000.
adjective(large,X) :- account(X, _, _, Y), Y > 10000. 
adjective(recent,X) :- created(X, _, _, _, Year), Year = 2024.
adjective(old,X) :- not adjective(recent,X).

adjective(largest, X) :- account(X, _, _, Balance), not((account(Y, _, _, OtherBalance), OtherBalance > Balance)).
adjective(oldest, X) :- created(X, _, _, _, Year), not((created(Y, _, _, _, OtherYear), OtherYear < Year)).

% account(AccountID, Name, Bank, Balance)
% created(AccountID, Name, Bank, Month, Year)
% location(X, C), where either X is a city and C is a country, or X is bank and C is a city
% lives(P, City), where P is a person name and City
% gender(Name, X)specifies that a gender of a person N ame is X

%prepositions
preposition(of,B,A) :- account(A, _, _, B). 
preposition(of,X,Y) :- lives(X,Y).
preposition(of,A,N) :- account(A, N, _, _). 
preposition(of,N,A) :- account(A, N, _, _). 
preposition(of,B,N) :- account(_, N, B, _). 
preposition(from,P,City) :- lives(P,City). 
preposition(from,P,Country) :- lives(P,City), location(City,Country).
preposition(in,X,Y) :- location(X,Y).
% rule for a bank in a country
preposition(in,Bank,Country) :- location(Bank,City), location(City,Country).
preposition(in,X,Y) :- lives(X,Y).
preposition(in,A,B) :- account(A,_,B,_).
preposition(in,Person,Country) :- lives(Person,City), location(City,Country).
preposition(with,N,A) :- account(A,N,_,_).
preposition(with,N,B) :- account(_,N,B,_).
preposition(with,A,B) :- account(A,_,_, B).
preposition(with,B,A) :- account(A,_,B,_).
preposition(with,B,Balance) :- account(_,_,B,Balance).

%%%%% SECTION: parser
%%%%% For testing your lexicon for question 3, we will use the default parser initially given to you.
%%%%% ALL QUERIES IN QUESTION 3 and 4 SHOULD WORK WHEN USING THE DEFAULT PARSER
%%%%% For testing your answers for question 5, we will use your parser below
%%%%% You may include helper predicates for Question 5 here, but they
%%%%% should not be needed for Question 3
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

what(Words, Ref) :- np(Words, Ref).
what([a, balance, between, Low, and, High], X) :-
    account(X, _, _, Balance), number(Low), number(High), Balance >= Low, Balance =< High.
/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */
np2([largest|Rest],What) :- np([a|Rest],What),adjective(largest,What).
np2([Adj|Rest],What) :- adjective(Adj,What), np2(Rest, What).
np2([Noun|Rest], What) :- common_noun(Noun, What), mods(Rest,What).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, What) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, What),	mods(End, What).

prepPhrase([Prep | Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H | L1], L2, [H | L3]) :-  appendLists(L1, L2, L3).

det(the, X) :- what(Desc, X), findall(X, what(Desc, X), Results), length(Results, 1).

