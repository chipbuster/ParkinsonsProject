formula1 = (motor_UPDRS ~ age + I(age^2) + I(age^3) + I(age^4) + DFA + HNR )
mymod = lm(formula1, data = pd)


errors <-(pd$motor_UPDRS - predict(mymod))
lowerrors = pd[which(errors < -4),]
notlowerrors = pd[which(errors >= -4),]
hierrors = pd[which(errors > 3),]
nothierrors = pd[which(errors <= 3),]

for (j in c(1:22)){
  print(colnames(pd)[j])
  plot(density(lowerrors[,j]))
  lines(density(notlowerrors[,j]), col='red')
  readline("<RETURN> to continue")
  
}

#RPDE + DFA

