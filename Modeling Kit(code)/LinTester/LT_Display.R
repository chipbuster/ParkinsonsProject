##Functions to display object (show and print)

setMethod(
  f = 'print',
  signature = 'LinTester',
  definition = function(x = "LinTester"){
    
    cat(paste('****Linear Regression Tester**** \n'))
    
    cat(paste("Input data dimensions:", dim(x@data)[1], " rows and ", dim(x@data)[2], "columns. \n" ))
    cat('Column names for data: ')
    print(colnames(x@data))
    cat('\n')
    
    cat('Formula for Regression:  ')
    print(x@form)
    cat('\n')
    
    
    if (dim(x@errors)[1] == 0){
      cat('Model Evaluation has not yet taken place! \n
          Or, you forgot to update the object when you evaluated.\n
          Use myLinTest = validate(myLinTest) to update object. \n\n\n')
    }
    else{
      cat('Error Summary for Model: \n')
      print(x@errors)
    }
    
    cat('*********End of Model Summary********* \n\n\n\n')
  }
)

setMethod(
  f = 'show',  
  signature = 'LinTester',
  definition = function(object){
    
    cat(paste('****Linear Regression Tester**** \n'))
    
    cat(paste("Number of data points: "))
    cat(dim(object@data)[1])
    cat('\n')
    cat(paste("Number of unique predictors: "))
    cat(dim(object@data)[2])
    cat('\n')
    
    
    cat('Formula for Regression:  ')
    print(object@form)
    cat('\n')
    
    
    if (dim(object@errors)[1] == 0){
      cat('Model Evaluation has not yet taken place! \n')
    }
    else{
      cat('Error Summary for Model under cross-validation: \n')
      print(object@errors)
    }
  }  
)

#Destructors
#removeMethod(show,signature='LinTester')
#removeMethod(print,signature='LinTester')