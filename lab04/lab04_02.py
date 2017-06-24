'''lab 4 submission 2'''

from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql.types import *

sc = SparkContext("local", "lab4submission2")

# loads and preps the data
lines = sc.textFile("file:///home/w205/weblog_lab.csv")
parts = lines.map(lambda l: l.split('\t'))
Web_Session_Log = parts.map(lambda p: (p[0],p[1],p[2],p[3],p[4]))

# creates a schema object
schemaString = "DATETIME USERID SESSIONID PRODUCTID REFERERURL"
fields = [StructField(field_name, StringType(), True) for field_name in schemaString.split()]
schema = StructType(fields)


# creates a table from the data and schema
sqlContext = SQLContext(sc)
schemaWebData = sqlContext.createDataFrame(Web_Session_Log, schema)
schemaWebData.registerTempTable("Web_Session_Log")



# query the table for ebay urls
results = sqlContext.sql("SELECT COUNT(*) FROM Web_Session_Log WHERE REFERERURL = 'http://www.ebay.com'")
results.show()



