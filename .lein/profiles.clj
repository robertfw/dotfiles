{:user
 {:plugins [[com.jakemccrary/lein-test-refresh "0.23.0"]
            [org.clojure/tools.namespace "0.2.11"],
            [cider/cider-nrepl "0.18.0"]
            [jonase/eastwood "0.3.3"]]
  :dependencies [[cljfmt "0.6.1"]]
  :repl-options {:init (require 'cljfmt.core)}}}
