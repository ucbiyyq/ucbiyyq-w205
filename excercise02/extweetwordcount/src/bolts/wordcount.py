from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
        self.conn = psycopg2.connect(database="tcount", user="postgres", password="", host="localhost", port="5432")

    def process(self, tup):
        word = tup.values[0]

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # writes the word count to the database
        self.flush(word)



    def flush(self, word):
        '''helper function that writes an instance of the word and a 1-count to the tweetwordcounts table'''
        
        # uses the self connection object to insert into table
        cur = self.conn.cursor()
        cur.execute("INSERT INTO tweetwordcount (word, word_count) VALUES (%s, %s);", (word,1))
        self.conn.commit()
        
        # Logs the count - just to see the topology running
        self.log("%s: %d" % (word, self.counts[word]))

        # for future, add a timestamp, add more columns to distinguish which word came from which tweet in which order
        # add a purge mechanism for scaling???


