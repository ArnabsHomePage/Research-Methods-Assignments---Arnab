
*** Assignment 03: 

*** Import the Data:
import delimited "/Users/ac5449/Documents/MGMT PHD/Fall 2023 - MGMT PhD - Arnab/Research Methods - 2/Assignment 03/sports-and-education.csv"

*** Variables and their distributions: 
summ 

***
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
   collegeid |        100        50.5    29.01149          1        100
academicqu~y |        100    .4908992    .2891613   .0002424   .9990026
athleticqu~y |        100    .4875922    .2846661    .001472   .9867587
nearbigmar~t |        100         .53    .5016136          0          1
  ranked2017 |        100          .5    .5025189          0          1
-------------+---------------------------------------------------------
alumnid~2018 |        100    853.5546    635.2617   10.07399   1628.631
***


*** Balance Table to show the average characteristics for treatment and control.
** Here the treatment is being ranked in 2017. Control includes schools not ranked. Covariates are academic quality, athletic quality and whether the university is near big market (dummy)
global balanceopts "prehead(\begin{tabular}{l*{6}{c}}) postfoot(\end{tabular}) noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast) starlevels(* 0.1 ** 0.05 *** 0.01)"
*** TTest of all the controls by treatment(ranked):
estpost ttest academicquality athleticquality nearbigmarket, by(ranked2017) unequal welch
esttab . using test.doc, cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels("Control" "Treatment" "Difference") noobs $balanceopts mlabels(none) eqlabels(none) replace mgroups(none)
*** The balance test failed. There seems to be non-random selection into who was ranked. 


*** Further to build a propsensity score model to create a matched sample between treatment and control:
logit ranked2017 academicquality athleticquality nearbigmarket 
*** To predict the score, i.e. the predictions from the logit model above/
predict propensity_score, pr

*** Output of the logit model: 
qui: logit ranked2017 academicquality athleticquality nearbigmarket 
outreg2 using Tlogittable.xls, append ctitle(Spec. 1) paren(pval) bdec(2) pdec(2) stats(coef pval) noas addstat(e(ll), e(r2_p))

*** Stacked histograms to show overlap in the between ranked and unranked schools:
twoway histogram propensity_score,  bc(red%30) freq || histogram propensity_score if ranked2017==0,  bc(blue%30) freq legend(order(1 "Treatment (Ranked)" 2 "Control (Unranked)"))
*** Save the graph:
graph save "Graph" "/Users/ac5449/Documents/MGMT PHD/Fall 2023 - MGMT PhD - Arnab/Research Methods - 2/Assignment 03/Graph.gph"


*** Grouping the observations into ``blocks'' based on propensity score.
sort propensity_score
gen block = floor(_n/4)


*** Finally analyzing the treatment effect of being ranked on alumni donations, while controlling for block-fixed effects as well as other covariates:
regress alumnidonations2018 ranked2017 academicquality athleticquality nearbigmarket i.block
*** output of the results:
outreg2 using resultsREG2.xls, append ctitle(Spec 01)


*** END ***




