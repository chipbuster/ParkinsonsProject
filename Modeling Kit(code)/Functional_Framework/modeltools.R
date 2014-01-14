##Useful functions for datanalysis. Creates and tests models using tools from
##UsefulTools.R.

##YOU NEED TO MAINTAIN THE FIRST TWO FUNCTIONS!!!
##Edit them where there are comments to ensure that things don't break.

#load or source statement here

#Make a model from a given dataset
#Call function with dataframe to base predictions off of. It returns a model.

makemodel <- function(datain){
  
  #You will need to manually enter the variables for the model. One model, one run.
  model = lm(motor_UPDRS ~ age + I(age^2) + I(age^3) + I(age^4) + DFA + HNR, data=datain)
  
  return(model)
}




#Test a model that you have made
#The second argument must be of type string (encapsulate in quotes)
#This function returns a data frame with the modelname and In-sample/Out-of-sample
#MSE and MAE (mean).

testmodel <- function(model, modelname, x = x, y = y, xtest = xtest, ytest = ytest){
  z = matrix(ncol = 4, nrow = 1) #change numcol as needed to accomodate for #tests, save one col for name
  z = data.frame(z, row.names = c(modelname))
  colnames(z) <- c("ISE", "OSE", "IAE", "OAE")
  z[1] = msein(model)
  z[2] = mseout(model)
  z[3] = maein(model)
  z[4] = maeout(model)
  
  return(z)
}

  

#Tested Models
#age + Shimmer.APQ11 + RDPE + PPE
#  model = lm(motor_UPDRS ~ age + DFA + Shimmer.APQ11 + HNR, data=datain)
  
  
  
  
  


