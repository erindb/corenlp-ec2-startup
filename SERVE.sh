#! usr/bin/bash

# source SERVE.sh

cd corenlp

# for file in `find . -name "*.jar"`; do export
# CLASSPATH="$CLASSPATH:`realpath $file`"; done

java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 12345 -timeout 15000 -quiet -preload tokenize,ssplit,pos,depparse # 2&>1 >/dev/null
cd ..
