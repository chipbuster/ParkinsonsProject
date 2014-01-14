#Main data testing script.
#Relies on modeltools, crosscheck, and usefultools
#Copyright 2013 ahhh who am I even shitting.


#Source dependencies
source('crosscheck.R')
source('modeltools.R')
source('UsefulTools.R')
source('dataextract.R')


#model with binning
rbins = makebins(pd)

#test model with 10 bins (bn = 10)
bincount = 10
out = matrix(ncol = 4, nrow = 0)
out = data.frame(out)
colnames(out) <- c("ISE", "OSE", "IAE", "OAE") #In or Out, Squared Error or Abs. Error

#modified to check for problem frames in formula
problemframes = pd[0,]

for(j in c(1:bincount)){
  #set x and y testing
  x = getMainframe(rbins, j)
  y = x$motor_UPDRS
  
  xtest = getTestframe(rbins,j)
  ytest = xtest$motor_UPDRS
  
  model = makemodel(x)
  
  out = rbind(out,testmodel(model,paste('model',j), x, y, xtest, ytest))
  
}

out_means = colMeans(out)
out_var = diag(var(out)) #a vector of all variances. The matrix var(out) is all covariances, the diags
                    #are all variances (or self-covariances)


out_total = rbind(out,out_means,out_var)

if(out_total[12,2] >= 6){
  rbind(problemframes, xtest)
}

