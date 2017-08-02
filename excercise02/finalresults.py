import sys
import psycopg2

# gets word from command line, or detects that there is no word
arglen = len(sys.argv)
if(arglen > 1):
    word = sys.argv[1]
else:
    word = ""

# creates a connection to the database
conn = psycopg2.connect(database="tcount", user="postgres", host="localhost", port="5432")
cur = conn.cursor()


# queries database for answer, depending on the word
if(word != ""):
    cur.execute( "SELECT COUNT(*) FROM tweetwordcount WHERE word = %s;", (word, ) )
    records = cur.fetchall()
    for rec in records:
        print "Total number of occurrences of %s: %d" % (word, rec[0])
else:
    cur.execute( "SELECT word, COUNT(*) FROM tweetwordcount GROUP BY word ORDER BY word ASC" )
    records = cur.fetchall()
    result = []
    for rec in records:
        result.append( (rec[0], rec[1]) )
    print result


# closes the connection
conn.close()

