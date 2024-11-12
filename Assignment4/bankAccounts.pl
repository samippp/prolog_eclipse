
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

account(12,ann,metro_credit_union,4505).
account(13,robert,royal_bank_of_canada,1091).
account(14,feroz,cibc,5000).                    %account1 at cibc
account(15,marzy,bank_of_montreal,2500).
account(16,sami,td_canada_trust,4000).
account(17,feroz,cibc,8000).                    %account2 at cibc
account(18,mary,royal_bank_of_canada,3500).
account(19,sami,bank_of_montreal,6500).
account(20,raj,td_canada_trust,1500).
account(21,nancy,cibc,12000).
account(22,erica,metro_credit_union,8000).
account(23,philip,royal_bank_of_canada,7000).
account(24,feroz,scotiabank,500).


% created(AccountID, Name, Bank, Month, Year)

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

% lives(P, City), where P is a person name and City

lives(philip,richmondHill). lives(ann,markham). lives(marzy,toronto).
lives(sami,scarborough). lives(feroz,brampton). lives(robert, markham).
lives(mary,toronto). lives(erica, sanFrancisco). lives(raj,scarborough).
lives(nancy, markham).

% location(X, C), where either X is a city and C is a country, or X is bank and C is a city

%cities
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


%articles
article(a). article(an). article(the). article(any).
%Common nouns
common_noun(bank,X). common_noun(city, X). common_noun(country,X). common_noun(man,X).
common_noun(woman,X).common_noun(owner,X).common_noun(person,X).common_noun(account,X).
common_noun(balance,X).
%Proper_nouns

%Adjectives
adjective(american,X).adjective(british,X).adjective(female,X).adjective(male,X).adjective(local,X).
adjective(foreign,X).adjective(small,X).adjective(medium,X).adjective(large,X).adjective(old,X).adjective(recent,X).
adjective(canadian,X).

small(X) :- X < 1000.
large(X) :- X > 10000.
medium(X) :- X > 1000 and X < 10000.
new(X) :- X = 2024.

%prepositions
preposition(of,X,Y).preposition(from,X,Y).preposition(in,X,Y).preposition(with,X,Y).preposition(between,X,Y).preposition(around,X,Y).

%%%%% SECTION: parser
%%%%% For testing your lexicon for question 3, we will use the default parser initially given to you.
%%%%% ALL QUERIES IN QUESTION 3 and 4 SHOULD WORK WHEN USING THE DEFAULT PARSER
%%%%% For testing your answers for question 5, we will use your parser below
%%%%% You may include helper predicates for Question 5 here, but they
%%%%% should not be needed for Question 3
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

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

