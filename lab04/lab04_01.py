''' lab 4 submission 1 '''

from pyspark import SparkContext
from pyspark.sql import SQLContext

sc = SparkContext("local", "lab4submission1")


# loads data and preps data
crimedata = sc.textFile("file:///home/w205/Crimes_-_2001_to_present.csv")
noHeaderCrimedata = crimedata.zipWithIndex().filter(lambda (row,index): index > 0).keys()
narcoticsCrimes = noHeaderCrimedata.filter(lambda x: "NARCOTICS" in x)


def create_tuple(x):
    '''helper function that creates key-value tuples when given a csv string'''
    temp_list = x.split(",")
    temp_first = temp_list[0]
    temp_rest = temp_list[1:]
    temp_rest_str = ",".join(temp_rest)
    temp_tuple = (temp_first, temp_rest_str)
    return temp_tuple

# creates tuples
narcoticsCrimeTuples = narcoticsCrimes.map(create_tuple)


# prints out the first tuple
firstTuple = narcoticsCrimeTuples.first()
print("first tuple key is")
print(firstTuple[0])
print("first tuple value is")
print(firstTuple[1])
