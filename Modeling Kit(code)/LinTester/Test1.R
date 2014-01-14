n=3000


#variance series for unaltered data
varnopower = c(1:n)*0
for(j in c(1:n)){
  
 derp = testpd(motor_UPDRS ~ age + DFA + Shimmer.APQ11 + HNR)
  varnopower[j] = getErrors(derp)[12,2]
  
  if(TRUE){
    if(j %% (n/100) == 0)
      print(paste('Progress: ', j/(n/100), '%', sep=''))
   }
 }
