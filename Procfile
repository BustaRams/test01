web: bundle exec thin start -p $PORT
resque: env INTERVAL=0.1 TERM_CHILD=1 COUNT=2 QUEUE='*' RESQUE_TERM_TIMEOUT=9 bundle exec rake resque:work