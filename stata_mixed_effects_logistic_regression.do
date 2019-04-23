import delimited C:\Users\ajwalker\Documents\GitHub\jupyter-notebooks\measures_by_software\data_for_stata.csv,clear

gen prop_logit =  logit(calc_value)

encode supplier,gen(supplier_)
encode regional_team_id,gen(regional_team_id_)
encode stp_id,gen(stp_id_)
encode pct_id,gen(pct_id_)

mixed prop_logit i.supplier_ || regional_team_id: || stp_id: || pct_id:

predict predictions
qui corr prop_logit predictions
di "R-squared - fixed effects (%): " round(r(rho)^2*100,.1)

qui predict predictionsr1 predictionsr2 predictionsr3, reffects
qui corr prop_logit predictionsr1
di "R-squared - random effects (%): " round(r(rho)^2*100,.1)
qui corr prop_logit predictionsr2
di "R-squared - random effects (%): " round(r(rho)^2*100,.1)
qui corr prop_logit predictionsr3
di "R-squared - random effects (%): " round(r(rho)^2*100,.1)
