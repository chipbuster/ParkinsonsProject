#Implementation of LinTester Methods for generics declared in LT_Headers.R

#Reassigns bin numbers (re-randomization for 10-fold cross validation)

setMethod('rebin',
  signature = 'LinTester',
  definition = function(object, binnum = 10){
    #remove last column on object@data, then pass it into makebins w/ binnum arg
    object@data <- makebins(subset(object@data,select = -(dim(object@data)[2])), binnum)
    validObject(object)
    return(object)
  }
)


setMethod('validate',
  signature = 'LinTester',
  function(object){
    bincount = max(object@data[,dim(object@data)[2]]) #maximum value of bincount
    out = matrix(ncol = 4, nrow = 0)
    out = data.frame(out)
    colnames(out) <- c("ISE", "OSE", "IAE", "OAE") #In or Out, Squared Error or Abs. Error
    
    for (j in c(1:bincount)){
      xtrain = getMainframe(object@data, j)
      #Which elements of response do not have bin number (all other bins)
      ytrain = object@response[which(object@data$bin_num != j)]
      
      xtest = getTestframe(object@data, j)
      #Which elements of response do correspond to bin number (target bin)
      ytest = object@response[which(object@data$bin_num == j)]
      
      model = makemodel(object@form, xtrain)
      
      
      #Quick Hax Lines
      # print(model$coefficients) to check model coefficients
      # moo()
      
      
      
      
      out = rbind(out,testmodel(model, paste('M#',j), xtrain, ytrain, xtest, ytest))
    }
    
      out_means = colMeans(out)
      out_var = diag(var(out)) #var(out) generates sq. matrix of covariances. The diagonals are 
                              #self-covariation. Since Cov(a,a) = Var(a), these are the variances
    
      #bind means and variances to output and name it
      rownamevector<-row.names(out)
      final_out <- rbind(out,out_means,out_var)
      row.names(final_out) <- c(rownamevector,'Mean','Variance')
    
      #finally, edit object and return it
      object@errors <- final_out
      return(object)
      
  }
)

setMethod('getPredictions',
  signature='LinTester',
  definition = function(object){    
            
          out = vector()
          bincount = bincount = max(object@data[,dim(object@data)[2]])
          
          for (j in c(1:bincount)){
            xtrain = getMainframe(object@data, j)
            #Which elements of response do not have bin number (all other bins)
            ytrain = object@response[which(object@data$bin_num != j)]
            
            xtest = getTestframe(object@data, j)
            #Which elements of response do correspond to bin number (target bin)
            ytest = object@response[which(object@data$bin_num == j)]
            
            model = makemodel(object@form, xtrain)
            
            out = c(out,predict(model, newdata = xtest))
 
          }
          return(out)
  }          
)
