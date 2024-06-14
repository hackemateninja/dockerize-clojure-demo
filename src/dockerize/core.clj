(ns dockerize.core
  (:require [ring.adapter.jetty :as jetty])
  (:gen-class))

(defn handler
  [request]
  {:status 200 :headers {"Content-Type" "text/html"} :body "Hello world ronindev"})

(defn -main 
  []
  (jetty/run-jetty handler {:port 3000 :join? true}))
