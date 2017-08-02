import sys
import psycopg2


# gets the comment line numbers for greater then equal to and less than
args = sys.argv[1]
gte, lt = args.split(",")


# creates a connection to the database
conn = psycopg2.connect(database="tcount", user="postgres", host="localhost", port="5432")
cur = conn.cursor()


# queries database for answer, dpending on the gte and lt
cur.execute("SELECT word, COUNT(*) FROM tweetwordcount GROUP BY word HAVING COUNT(*) >= %s AND COUNT(*) < %s ORDER BY COUNT(*) DESC;", (gte, lt))
records = cur.fetchall()
for rec in records:
    print rec[0], rec[1]


# closes the connection
conn.close()
