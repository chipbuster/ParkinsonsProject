#Function to reassign bin numbers (for cross-validation)
setGeneric('rebin',
  function(object, binnum = 10){
    standardGeneric('rebin')
  }
)

#Function to run errors
setGeneric('validate',
  function(object){
    standardGeneric('validate')
  }   
)

setGeneric('getPredictions',
  function(object){
    standardGeneric('getPredictions')
  }
)





##### Accessor/Mutator Declarations #####

#Declarations
#Accessor Declarations
setGeneric('getData', 
           function(object, getbins = FALSE){
             standardGeneric('getData')
           }
)

setGeneric('getResponse', 
           function(object){
             standardGeneric('getResponse')
           }
)

setGeneric('getForm', 
           function(object){
             standardGeneric('getForm')
           }
)

setGeneric('getErrors', 
           function(object){
             standardGeneric('getErrors')
           }
)
#Mutator Declarations

setGeneric('setData', 
           function(object, value){
             standardGeneric('setData')
           }
)

setGeneric('setResponse', 
           function(object, value){
             standardGeneric('setResponse')
           }
)

setGeneric('setForm', 
           function(object, value){
             standardGeneric('setForm')
           }
)

setGeneric('setAll',
           function(object, data, response){
             standardGeneric('setAll')
           }           
           
)

#no way to set Errors (shouldn't need to)
