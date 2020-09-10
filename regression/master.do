cd "C:\Users\alexw\Documents\GitHub\software_differences_paper\regression"

cap log close
log using ciclosporin, replace t
import delimited "ciclosporin_for_stata.csv",clear
do stata_mixed_effects_logistic_regression.do
cap log close


log using diltiazem, replace t
import delimited "diltiazem_for_stata.csv",clear
do stata_mixed_effects_logistic_regression.do
cap log close
