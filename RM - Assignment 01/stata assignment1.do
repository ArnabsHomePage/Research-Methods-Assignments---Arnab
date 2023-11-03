
clear

***Assignment 01 (Research Methods -2)

*** Import the data from assignment as csv:
import delimited "/Users/ac5449/Documents/MGMT PHD/Fall 2023 - MGMT PhD - Arnab/Research Methods - 2/Assignment 01/assignment1-research-methods.csv"

*** Basic regression to check the effect of being from elite school in getting a call back: 
reg calledback eliteschoolcandidate
*** Outreg the results as table:
outreg2 using results1.xls, append ctitle(Spec 01)

*** Regression to check the effect of being from elite school in getting a call back, controlling for all other factors, [REMOVING GENDER COVARIATE] : 
reg calledback eliteschoolcandidate  bigcompanycandidate recruiteriswhite recruiterismale
outreg2 using results1.xls, append ctitle(Spec 02)



*** Regression to check the interaction effect of being from elite school and being a big company candidate in getting a call back in a full specification: 
reg calledback i.eliteschoolcandidate##i.bigcompanycandidate recruiterismale recruiteriswhite
outreg2 using results2.xls, append ctitle(Spec 02)



** Try Logit Model

*** A logit specification of the basic regression (since the DV is binary): 
logit calledback eliteschoolcandidate
outreg2 using results3.xls, append ctitle(Spec 01)

logit calledback eliteschoolcandidate  bigcompanycandidate recruiteriswhite recruiterismale
outreg2 using results3.xls, append ctitle(Spec 02) 


***end***

