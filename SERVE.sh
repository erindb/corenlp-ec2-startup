#! usr/bin/bash

# SERVE.sh - A script to run a corenlp server

if [ "$1" == "" ] || [[ "$1" =~ ^(english|spanish|chinese)$ ]]; then
	if [ "$1" == "" ]; then
		language="english"
	else
		language=$1
	fi
	echo "running corenlp server for "$language

	case $language in
		spanish )
			properties_tag="-props StanfordCoreNLP-spanish.properties -serverProperties StanfordCoreNLP-spanish.properties" ;;
		chinese )
			properties_tag="-props StanfordCoreNLP-chinese.properties -serverProperties StanfordCoreNLP-chinese.properties" ;;
		english )
			properties_tag="" ;;
	esac

	cd corenlp

	if [ "$2" == "--silent" ]; then
		silent_tag="2&>1 >/dev/null"
	else
		silent_tag=""
	fi

	java -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer \
		$properties_tag \
		-port 12345 -timeout 15000 -quiet -preload tokenize,ssplit,pos,depparse $silent_tag

	cd ..
else
	echo $1" is not a supported language."
	echo "Please choose: english OR spanish OR chinese"
fi
