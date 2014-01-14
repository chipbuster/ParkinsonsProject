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

