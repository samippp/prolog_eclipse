
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

%%%%% SECTION: q2_kb
%%%%% You should put the atomic statements in your KB below in this section

totalDeposits(koleda, cibc, 25000). totalDeposits(ben, bmo, 15000). totalDeposits(koleda,bmo,40000).
totalDeposits(nicole,cibc,500).

totalWithdrawals(koleda,cibc, 10000). totalWithdrawals(ben,bmo,5000). totalWithdrawals(koleda,bmo,5000).
totalWithdrawals(nicole,cibc,1500).

monthlyRate(cibc, 0.5). monthlyRate(bmo, 0.6).

interestLevel(cibc, 1500). interestLevel(bmo, 1250).

penalty(cibc, 50). penalty(bmo, 100).


%%%%% SECTION: q2_rules
%%%%% Put statements for subtotal, accruedInterest, accruedPenalty, and endOfMonthBalance below.
%%%%% You may also put helper predicates here
%%%%% DO NOT PUT ATOMIC FACTS FOR hasAccount, totalDeposits, totalWithdrawals, monthlyRate, interestRate, or penalty below.

subtotal(Name,Bank,Subtotal) :- totalDeposits(Name,Bank,Y), totalWithdrawals(Name,Bank,X), Subtotal is (Y-X).

greater_or_equal(X,Y,1) :- X >= Y.
greater_or_equal(X,Y,0) :- X < Y.

accruedInterest(Name, Bank, I) :- subtotal(Name,Bank,Subtotal), interestLevel(Bank, Min), greater_or_equal(Subtotal,Min,Multiplier), 
monthlyRate(Bank,Rate), I is ((Rate / 100) *Subtotal)*Multiplier.

accruedPenalty(Name, Bank, 0) :-  subtotal(Name,Bank,Subtotal), Subtotal >= 0.
accruedPenalty(Name, Bank, P) :- subtotal(Name,Bank,Subtotal) , Subtotal < 0, penalty(Bank,Penalty), P is Penalty.

endOfMonthBalance(Name, Bank, Balance) :- subtotal(Name,Bank,Subtotal),accruedInterest(Name,Bank, I), accruedPenalty(Name,Bank,P), Balance is Subtotal + I - P.

endOfMonthBalance(Name, Balance) :- endOfMonthBalance(Name,cibc,B), not( endOfMonthBalance(Name,bmo,B2)), Balance is B. 
endOfMonthBalance(Name, Balance) :- endOfMonthBalance(Name,cibc,B), endOfMonthBalance(Name,bmo,B2), Balance is B + B2.
endOfMonthBalance(Name, Balance) :- endOfMonthBalance(Name,bmo,B), not( endOfMonthBalance(Name,cibc,B2)), Balance is B.
%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW
