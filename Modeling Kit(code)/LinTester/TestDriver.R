source('Main_LT_S4.R')
source('dataextract.R')

testpd <- function(input){
  derp1 = lintester(pd, pd$motor_UPDRS, input)
  derp1 = validate(derp1)
  return(derp1)
}

formula1 =
#Note: exp(age) scaled by (age)! and 1/age! do not scale better
#testpd(formula1)

#topsofar = formula(motor_UPDRS ~ age + I(age^2)  + I(age^3) + I(age^4) + I(DFA^2) +DFA + HNR + NHR+ RPDE +I(RPDE^2))
topsofar = formula(motor_UPDRS ~ age + I(age^2) + I(age^3) + I(age^4) + I(age^5) + I(DFA^2) + DFA + HNR + NHR+ PPE +I(PPE^2))

#formula used by the paper
paperformula = formula(motor_UPDRS ~ Jitter.Abs. + Shimmer + NHR + HNR + DFA + PPE)
testrun=testpd(topsofar)
print(testrun)