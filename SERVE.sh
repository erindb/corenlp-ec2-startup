#! usr/bin/bash

# source SERVE.sh

cd corenlp
java -mx2g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 12401 -timeout 15000
cd ..
