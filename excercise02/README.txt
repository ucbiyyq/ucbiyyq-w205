0 Setup

Confirm twitter app is running

Confirm EC2 instance is running, with /data attached, with Postgres running

Clone project to EC2 instance


1 Run the Storm application

cd .../excersize02/extweetwordcount
sparse run

run for a short duration, e.g. 30 seconds
* ctrl+c to stop the Storm script


2 Run the final results script to see the results

python finalresults.py

will give you the list of all words, in abc order, and their counts


python finalresults.py word

will give you the count of occurences for "word"



3 Run the histogram script

python histogram.py 100,200

will give you all the words, and their counts, that have occurences greater than or equal to 100, and less than 200