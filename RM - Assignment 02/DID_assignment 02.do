
*** DID Regressions ***

clear 
*** Load the data: 
import delimited "/Users/ac5449/Documents/MGMT PHD/Fall 2023 - MGMT PhD - Arnab/Research Methods - 2/Assignment 02/vaping-ban-panel.csv"

*** check the year and states: 
tab stateid 
tab year 

*** check states which adopted the vaping ban: 
tab stateid if vapingban ==1

*** generate the treatment variable: 
gen treated =1 if stateid <=23
recode treated .=0

*** check number of treated units: 
tab treated 

*** Set the balannced panel: 
xtset stateid year 

*** Regression to check "parallel trends" assumption: 
reg lunghospitalizations i.year##i.treated 
outreg2 using resultsdid01.xls, append ctitle(Spec 01)

*** get the marginal effects: 
margins treated, at(year=(2011(1)2030)) vsquish

*** marginsplot for graphical representation of the "parallel trends" assumption: 
marginsplot, noci xlabel(2010(2)2030) title("") xline(2020)
graph save "Graph" "/Users/ac5449/Documents/MGMT PHD/Fall 2023 - MGMT PhD - Arnab/Research Methods - 2/Assignment 02/Graph01.gph", replace



*** generating the post variable for DID regression: 
gen post_t =1 if year >=2021
recode post_t .=0

*** DID regression with state and year fixed effects and robust standard errors:
reg lunghospitalizations i.treated##i.post_t i.stateid i.year, robust
outreg2 using resultsdid02.xls, append ctitle(Spec 01)


*** Check if state fixed effects have effects on hospitalization caused by vaping ban: 
reg lunghospitalizations i.treated##i.post_t i.stateid i.year, robust
testparm i.stateid 


*** I have not clustered by state, since I have included state fixed effects. 

***END***
