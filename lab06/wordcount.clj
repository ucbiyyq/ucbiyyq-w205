(ns wordcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn wordcount [options]
   [
    ;; spout configuration
    {"word-spout" (python-spout-spec
          options
          "spouts.sentences.Sentences"
          ["word"]
          )
    }
    ;; bolt configuration
    {
      ;;bolt parse
      "parse-bolt" (python-bolt-spec
          options
          {"word-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 2
          )
      ;;bold tweet counter
      "count-bolt" (python-bolt-spec
          options
          {"parse-bolt" :shuffle}
          "bolts.tweetcounter.TweetCounter"
          ["word" "count"]
          :p 2
          )

    }
  ]
)
