source('crosscheck.R')
source('modeltools.R')
source('UsefulTools.R')
graphics.off()
starttime=time=proc.time()
formatdata <- function(data){ 
data=data[-1] #id
data=data[-(4:5)] #motor and total UPDRS
data=data[-(20)] #bin number
data=data[-2] #sex
data=data.frame(data,data[1]^2,data[1]^3,data[1]^4,data[17]^2)
return(data)
}
varlist=vector("list", 50)
totalruns=10

for(test in c(1:totalruns)){
source('dataextract.R')
pd=pd[-(which(pd$sex==1)),]# exclude a sex
rbins = makebins(pd)
#test model with 10 bins (bn = 10)
bincount = 10
for(currentbin in c(1:bincount)){
#set x and y testing
x = getMainframe(rbins, currentbin)
y = x$motor_UPDRS
  
xtest = getTestframe(rbins,currentbin)
ytest = xtest$motor_UPDRS
    
# forward stepwise modeling


x=formatdata(x)
xtest=formatdata(xtest)

# stepwise linear regression
# using L2 linear regression on this data set

n = length(y)
numofvars=length(colnames(x))
optvars = vector()    # optimal variables to use
opterrs = vector()    # out-of-sample MSE
opterrsin = vector()  # in-sample MSE
for (j in seq(from=1,to=numofvars,by=1))  # j represents number of variables in the model
{
	nexterrors = Inf*c(1:numofvars)
	for (jj in seq(from=1,to=numofvars,by=1))  # jj represents the next candidate variable to include
   {
		if (length(which(optvars==jj))==0)
		{
			trainvars <- c(optvars,jj)
			traindata <- data.frame(x[,trainvars])
			colnames(traindata) = colnames(x)[trainvars]
			mylm = lm(y ~ ., data=traindata)
			ypred = predict(mylm,newdata=xtest)
			nexterrors[jj] = mean((ypred-ytest)^2)
		}
	}
	optvar = which.min(nexterrors)
	optvars = c(optvars,optvar)
	opterrs = c(opterrs,nexterrors[optvar])
	opterrsin = c(opterrsin,((n+j+1)/(n-j-1))*mean((y-predict(mylm))^2))
}
for(i in 1:numofvars){
varlist[[i]]=cbind(varlist[[i]],which(optvars==i))
}
cat("\nTEST NUMBER",test,"CROSSFOLD NUMBER --------------------", currentbin,"(",(test*bincount+currentbin-10)/(totalruns*bincount)*100,"%)\n")
cat( file = "output_new_female.txt",append = TRUE,"\nTEST NUMBER",test,"CROSSFOLD NUMBER --------------------", currentbin,"\n")
cat( file = "output_new_female.txt",append = TRUE,optvars,"\n")
cat( file = "output_new_female.txt",append = TRUE,colnames(x)[optvars],"\n")
cat( file = "output_new_female.txt",append = TRUE,opterrsin,"\n")
cat( file = "output_new_female.txt",append = TRUE,opterrs,"\n")
}
}
for(i in c(1:22)){
cat(colnames(x)[i],mean(varlist[[i]]),"\n")
plot(density(varlist[[i]]))
if(i!=22) dev.new()
}
endtime=proc.time()
cat("Time Elapsed:" ,(endtime-starttime)[3]/60,"Minutes")
save(varlist, list = character(),
     file = "varlist_new_female.RData",
     ascii = TRUE, version = NULL, envir = parent.frame(),
     eval.promises = TRUE, precheck = TRUE)
