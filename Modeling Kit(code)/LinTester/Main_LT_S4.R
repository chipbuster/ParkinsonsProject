#S4 Class to test a linear model and find its error, MSE+MAE, both in-sample and out
#of sample using n-fold cross validation.

#Short documentation can be found in the Documentation folder included in this tarball,
#and the code itself is not lacking in comments, although they may not always be the
#best comments.

#Written by Kevin Song, based off of algorithms by Matthew Bucci, for Math 032 @ UC Merced.


#Import crucial elementary functions (non-methods)
source('LT_Library.R')
source('LT_Headers.R')


setClass(
  Class='LinTester', 
  representation=representation(
      data='data.frame',
      response = 'vector',
      form = 'formula',
      errors = 'data.frame'
  ),
  validity = function(object){
    
    #if the response and data do not match in length
    if(length(object@response) != dim(object@data)[1]){
      stop('[Validity:LinTester]--The lengths of the predictors
           and responses are not equal! Aborting object construction. \n\n
           If you are using a mutator, note that response and data must be
           of same length. To change both simultaneously, use setAll()')
    }
    
    #if the response or data is zero length
    else if(length(object@response) == 0 || dim(object@data)[1] == 0){
      stop('[Validity:LinTester]--One or more of the input data is empty!')
    }
    else{
      return(TRUE)
    }
  }
)

#Set constructor (with 'new')
setMethod(
  f='initialize',
  signature = 'LinTester',
  definition = function(.Object, data, response, form){
    if(colnames(data)[dim(data)[2]] == 'bin_num'){ #if the table already has last col 'bin_num'
      .Object@data <- data #then just put data into object, don't override bin numbers
    }
    else{ #otherwise, generate bin numbers
    .Object@data <- makebins(data)
    }
    .Object@response <- response
    .Object@form <- form
    validObject(.Object)
    return(.Object)
  }
  
)

#user-friendly constructor
lintester <- function(data, response, form){
  object = new(Class='LinTester', data=data, response=response, form=form)
  return(object)
}

#Load methods for displaying info on object (show and print)
source('LT_Display.R')

#Load all other methods
source('LT_Methods.R')

#Load Accessors and Mutator methods
source('LT_AccessorMutator.R')



#for debugging
#derp = lintester(pd, pd$motor_UPDRS, formula(motor_UPDRS ~ age), binnum=15)

