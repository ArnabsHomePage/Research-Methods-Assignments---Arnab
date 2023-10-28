
clear

***Assignment 01 (Research Methods -2)

*** Import the data from assignment as csv:
import delimited "C:\Users\lbsar\OneDrive\Desktop\assignment1-research-methods.csv"

*** Basic regression to check the effect of being from elite school in getting a call back: 
reg calledback eliteschoolcandidate
*** Outreg the results as table:
outreg2 using results1.xls, append ctitle(Spec 01)

*** Regression to check the effect of being from elite school in getting a call back, controlling for all other factors, i.e, a full specification: 
reg calledback eliteschoolcandidate malecandidate bigcompanycandidate recruiteriswhite recruiterismale
outreg2 using results1.xls, append ctitle(Spec 02)

*** Regression to check the interaction effect of being from elite school and being a male candidate in getting a call back: 
reg calledback i.eliteschoolcandidate##i.malecandidate
outreg2 using results2.xls, append ctitle(Spec 01)

*** Regression to check the interaction effect of being from elite school and being a male candidate in getting a call back in a full specification: 
reg calledback i.eliteschoolcandidate##i.malecandidate bigcompanycandidate recruiterismale recruiteriswhite
outreg2 using results2.xls, append ctitle(Spec 02)



/* Try Logit Model

*** A logit specification of the basic regression (since the DV is binary): 
logit calledback eliteschoolcandidate
outreg2 using results3.xls, append ctitle(Spec 01)

logit calledback eliteschoolcandidate malecandidate bigcompanycandidate recruiteriswhite recruiterismale
outreg2 using results3.xls, append ctitle(Spec 02) */


***end***

