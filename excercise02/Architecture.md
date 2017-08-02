
## Folder structure, the important parts

/excercise02/
* finalresults.py
* histogram.py
* extweetwordcount/
 * topologies/
   * extweetwordcount.clj
 * src/
   * bolts/
     * parse.py
     * wordcount.py
   * spouts/
     * tweets.py


## Notes on the project files

finalresults.py and historgram.py are the script-deliverables that we use at the end of a run
* See the README.txt on how to run them

The extweetwordcount folder holds the Storm project that consumes the twitter app data

The extweetwordcount.clj file defines the topology:
* 3 instances of tweets spouts, which consume the twitter feed
* 3 instances of parse bolts, which parses the twitter feed into words
* and 2 instances of wordcount bolts, which stores the word count data into the postgres database

## Dependencies

### Twitter application

The project depends on a twitter application
* credentials to the twitter application are stored in plain text in the tweets.py spout file

### Postgres database

The project depends on a local postgres *tcount* database, with a single table *tweetwordcount*
* credentials to the postgres database are stored in plain text in the
 * wordcount.py bolt file
 * and the finalresults.py and histogram.py script-deliverables
 
The intended use of the table is to store an instance of a word, and a 1-count, for each instance the word appears in the twitter feed. Counts and aggregations are performed by the script-deliverables.

tcount=# \dt
             List of relations
 Schema |      Name      | Type  |  Owner
--------+----------------+-------+----------
 public | tweetwordcount | table | postgres
(1 row)

tcount=# \d tweetwordcount
          Table "public.tweetwordcount"
   Column   |          Type          | Modifiers
------------+------------------------+-----------
 word       | character varying(200) |
 word_count | integer                |

tcount=#