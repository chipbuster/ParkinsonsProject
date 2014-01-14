#Accessor and Mutator functions for LinModTest_S4.R a.k.a LinTester
#setGeneric() calls can be found in LT_Headers.R


##### START Accessor/Mutator Block #####

#Implementations

#Accessor Implementations
setMethod(
  f = 'getData',
  signature = 'LinTester',
  definition = function(object, getbins = FALSE){
    if (getbins){
      return (object@data)
    }
    else{
      data = object@data[,-23]
      return(data)
    }
  }
)

setMethod(
  f = 'getResponse',
  signature = 'LinTester',
  definition = function(object){
    return(object@response)
  }
)

setMethod(
  f = 'getForm',
  signature = 'LinTester',
  definition = function(object){
    return(object@form)
  }
)

setMethod(
  f = 'getErrors',
  signature = 'LinTester',
  definition = function(object){
    return(object@errors)
  }
)

#Mutator Implementation

setMethod(
  f = 'setData',
  signature = 'LinTester',
  definition = function(object, value){
    object@data <- value
    validObject(object)
    return(object)
  }
)

setMethod(
  f = 'setResponse',
  signature = 'LinTester',
  definition = function(object, value){
    object@response <- value
    validObject(object)
    return(object)
  }
)

setMethod(
  f = 'setForm',
  signature = 'LinTester',
  definition = function(object, value){
    object@form <- value
    validObject(object)
    return(object)
  }
)

setMethod(
  f = 'setAll',
  signature = 'LinTester',
  definition = function(object, data, response){
    object@data <- data
    object@response <- response
    validObject(object)
    return(object)
  }
)


##### END Accessor/Mutator Block #####

