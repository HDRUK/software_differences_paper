encode supplier,gen(supp)
total numerator denominator, over(supp)

gen prop_logit =  logit(calc_value)

encode supplier,gen(supplier_)
encode regional_team_id,gen(regional_team_id_)
encode stp_id,gen(stp_id_)
encode pct_id,gen(pct_id_)
recode num_gps_sept min/1=1 2/max=0 .=0, gen(single_handed)
encode ruc11cd, gen(rural_urban_code)
*xtile volume = denominator,nq(5)
xtile over_65 = value_over_65,nq(5)
xtile under_18 = value_under_18,nq(5)
xtile long_term_health = value_long_term_health,nq(5)
xtile imd = value_imd, nq(5)
recode dispensing_patients 1/max=1


gen single_group = 1
meqrlogit numerator i.supplier_ || single_group:, binomial(denominator) or

meqrlogit numerator i.supplier_ ///
		|| pct_id_:, binomial(denominator) or
		
meqrlogit numerator i.supplier_ dispensing_patients i.over_65 i.under_18 i.long_term_health i.single_handed i.rural_urban_code i.imd ///
		|| pct_id_:, binomial(denominator) or


predict predictions_2,xb
qui corr numerator predictions_2
di "R-squared - fixed effects (%): " round(r(rho)^2*100,.1)

qui predict predictionsr1_2, reffects
qui corr prop_logit predictionsr1_2
di "R-squared - random effects (%): " round(r(rho)^2*100,.1)
