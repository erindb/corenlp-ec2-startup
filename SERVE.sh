#! usr/bin/bash

# source SERVE.sh

cd corenlp
java -mx2g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 12345 -timeout 15000 -quiet  2&>1 >/dev/null
cd ..
