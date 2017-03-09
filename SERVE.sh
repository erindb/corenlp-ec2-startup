#! usr/bin/bash

cd corenlp
sudo java -mx2g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 80 -timeout 15000
