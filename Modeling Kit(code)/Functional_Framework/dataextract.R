#Opening Script: This script takes the Parkinson's Data for MATH 032
#and loads it into several vectors / subframes to make it easier to use.
#In general, this script should be sourced first when working with the pd data.

# Feel free to set your own names for shell work, but PLEASE USE ORIGINAL
# VARIABLE NAMES when you are writing scripts for use by others!!


load('parkdata.RData')

pd = parkdata
upd = pd$motor_UPDRS


