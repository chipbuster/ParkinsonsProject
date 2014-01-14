##Useful lower level tools for PWP Voice modeling
##These are used to support the functions found in modeltools.R

#NOTE: Unless you plan on passing in many arguments, you *must* use
#x and y for your model predictors/response, and xtest and ytest for your test!

#make predictions on model
#Call w/ model to predict and data to predict on
makepred <- function(model,data = xtest){
	prediction = predict(model, newdata = data)

	return(prediction)
}

#MSE (predict mean squared error between model and dataset)

mse <- function(model, data = ytest, testdata = xtest){
	prediction = makepred(model, testdata)
	mse = mean((data-prediction)^2)

	return(mse)
}

#MAE (Mean Absolute Error)

mae <- function(model, data = ytest, testdata = xtest){
  prediction = makepred(model, testdata)
  mae = mean(abs(data-prediction))
  
  return(mae)
}





#In sample and out of sample specific implementations


#in sample
msein <- function(model, data = ytest, testdata = xtest){
	x = mse(model, y, x)
	return(x)
}

maein <- function(model, data = ytest, testdata = xtest){
  x = mae(model, y, x)
  return(x)
}

#out of sample
mseout <- function(model, data = ytest, testdata = xtest){
	x = mse(model)
	return(x)
}

maeout <- function(model, data = ytest, testdata = xtest){
  x = mae(model)
  return(x)
}

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

