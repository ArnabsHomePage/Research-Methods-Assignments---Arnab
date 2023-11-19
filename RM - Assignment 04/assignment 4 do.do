
*** Assignment 04: 

** Import the data: 
import delimited "/Users/ac5449/Documents/MGMT PHD/Fall 2023 - MGMT PhD - Arnab/Research Methods - 2/Assignment 04/crime-iv.csv"

** Label Variables:
label var republicanjudge "Republican Judge"
label var severityofcrime "Severity of Crime"
label var monthsinjail "Months in Jail"
label var recidivates "Recidivates"


** Balance Table to show the average characteristics for treatment and control.
** Here the treatment is being assigned a Republican Judge. Control includes being not assigned a Republican Judge. Covariate is the Severity of Crime committed.
global balanceopts "prehead(\begin{tabular}{l*{6}{c}}) postfoot(\end{tabular}) noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast) starlevels(* 0.1 ** 0.05 *** 0.01)"
estpost ttest monthsinjail severityofcrime , by(republicanjudge) unequal welch
esttab . using test1.tex, cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels("Control" "Treatment" "Difference") noobs $balanceopts mlabels(none) eqlabels(none) replace mgroups(none)

*** First Stage Regression for IV:
reg monthsinjail republicanjudge severityofcrime 
outreg2 using results4_01.xls, append ctitle(Spec 01)

*** Second Stage (Reduced Form) Regression for IV: 
reg recidivates  republicanjudge severityofcrime 
outreg2 using results4_02.xls, append ctitle(Spec 01)

*** IV regression using IVREG2: 
ivreg2 recidivates  (monthsinjail =republicanjudge ) severityofcrime

** output of the second stage (along with the F-stat)
outreg2 using results4_03.xls, append ctitle(Spec 01) addstat("F test model", e(F)) 

***END***
