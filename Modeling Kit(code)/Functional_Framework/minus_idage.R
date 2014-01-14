##Removing ID 32 from 'data_formatted' with the dataframe 'minus_idage'

#If used, this should ONLY be applied after all desired data has been 
#formatted onto the datafram 'data_formatted' and before analysis

#ID 32 is an outlier who differs significantly from the rest of the subjects
#in terms of age. There is typically a correlation between age and disease, so
#ID 32 may skew our results. Looking at the boxplots presented below, ID 32 is
#the only individual to fall beyond an IQR and she raises the SD of age to 9.33.
#In her absence, the SD of age is 8.08 and the mean almost touches the median.

#Subtracting ID 32 may not be necessary, but it may make analysis easier.

source('dataextract.R')

minus_idage=subset(data_formatted, idage!='36')
minus_idage

#Evaluation follows

boxplot(idage)
windows()
boxplot(minus_idage$Age)

sd(idage)
summary(idage)

sd(minus_idage$Age)
summary(minus_idage$Age)
