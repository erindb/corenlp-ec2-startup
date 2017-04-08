#! usr/bin/bash

# source SERVE.sh

cd corenlp
sudo java -mx2g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 401 -timeout 15000
cd ..
