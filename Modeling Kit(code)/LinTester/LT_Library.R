##Library of functions for Linear Model Testing (LinTester class)

#This file was made by concatenating ("copy-pasting") together the following
#files from the functional-based version of R:

#crosscheck.R
#modeltools.R
#UsefulTools.R

#The functions within are central to the operation of the LinTester class.
#A few changes have been made to naming conventions in order to facilitate 
#function inside of the class. The core functions (what it does) remain unchanged.


##############################

#Added after initial code

##############################




###############################

# ---- From crosscheck.R ---- #

###############################

##A tool to randomize bins of data and check it.


#function that appends a column to the data, specifying it's "bin number."
#this can then be used to do a cross-check, or saved for later use.

makebins <- function(data, numbins = 10){ 

datalength = dim(data)[1] #grabs the number of rows of the input dataframe

binsize = round(datalength / numbins) #last bin will be of diff. size

#create bins vector, from 1 to numbins. There are binsize entries of each number
#Populate all but the last bin (last bin may be uneven)
bins = rep(c(1:(numbins - 1)), binsize)  
bins = c(bins, rep(numbins, datalength - length(bins))) #populate last bin

bin_num = sample(bins, length(bins), replace = FALSE) #randomize bins

binnedData = cbind(data, bin_num) #bind binnumber as an extra column on data

return(binnedData)

}



#Return a dataframe that HAS the appropriate binning (i.e. all bin_num == x)
#Use to get frames to TEST model

getTestframe <- function(data, targetbin){
  testframe = data[which(data$bin_num == targetbin), ] #get all rows where bin_num is target
  
  return(testframe)
}

#Return dataframe that DOES NOT HAVE the appropriate binning (i.e. bin_num != x)
#Use to get frames to MAKE model

getMainframe <- function(data, targetbin){
  testframe = data[which(data$bin_num != targetbin), ]
  
  return(testframe)
}



################################

# ---- From UsefulTools.R ---- #

################################

##Useful lower level tools for PWP Voice modeling
##These are used to support the functions found in modeltools.R

#NOTE: Unless you plan on passing in many arguments, you *must* use
#x and y for your model predictors/response, and xtest and ytest for your test!

#make predictions on model
#Call w/ model to predict and data to predict on
makepred <- function(model,testdata){
	prediction = predict(model, newdata = testdata)

	return(prediction)
}

#MSE (predict mean squared error between model and dataset)

mse <- function(model, data, testdata){
	prediction = makepred(model, testdata)
	mse = mean((data-prediction)^2)

	return(mse)
}

#MAE (Mean Absolute Error)

mae <- function(model, data, testdata){
  prediction = makepred(model, testdata)
  mae = mean(abs(data-prediction))
  
  return(mae)
}


#Because every good program needs at least one easter egg
moo <- function()
{
  cat("\n","         (__) ","\n")
  cat("          (oo)    ","\n")
  cat("   /-------\\/     ","\n")
  cat("  / |     ||      ","\n")
  cat(" *  ||----||      ","\n")
  cat("    ^^    ^^      ","\n")
  cat("     Moooooo","\n")
}



###############################

# ---- From modeltools.R ---- #

###############################

##Useful functions for datanalysis. Creates and tests models using tools from
##UsefulTools.R.

##YOU NEED TO MAINTAIN THE FIRST TWO FUNCTIONS!!!
##Edit them where there are comments to ensure that things don't break.

#load or source statement here

#Make a model from a given dataset
#Call function with dataframe to base predictions off of. It returns a model.

makemodel <- function(formula, datain){
  
  #You will need to manually enter the variables for the model. One model, one run.
  model = lm(formula, data=datain)
  
  return(model)
}




#Test a model that you have made
#The second argument must be of type string (encapsulate in quotes)
#This function returns a data frame with the modelname and In-sample/Out-of-sample
#MSE and MAE (mean).

testmodel <- function(model, modelname, xtrain, ytrain, xtest, ytest){
  z = matrix(ncol = 4, nrow = 1) #change numcol as needed to accomodate for #tests, save one col for name
  z = data.frame(z, row.names = c(modelname))
  colnames(z) <- c("ISE", "OSE", "IAE", "OAE")
  z[1] = mse(model, ytrain, xtrain)  #in-sample MSE
  z[2] = mse(model, ytest, xtest)    #out-of-sample MSE
  z[3] = mae(model, ytrain, xtrain)  #in-sample MAE
  z[4] = mae(model, ytest, xtest)    #out-of-sample MAE
  
  return(z)
}

  

#Tested Models
#age + Shimmer.APQ11 + RDPE + PPE
#  model = lm(motor_UPDRS ~ age + DFA + Shimmer.APQ11 + HNR, data=datain)

