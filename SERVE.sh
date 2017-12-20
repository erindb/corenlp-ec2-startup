#! usr/bin/bash

# SERVE.sh - A script to run a corenlp server

if [ "$1" == "" ] || [[ "$1" =~ ^(en|sp|ch)$ ]]; then
	if [ "$1" == "" ]; then
		language="en"
	else
		language=$1
	fi
	echo "running corenlp server for "$language

	case $language in
		sp )
			properties_tag="-props StanfordCoreNLP-spanish.properties -serverProperties StanfordCoreNLP-spanish.properties"
			port=12347 ;;
		ch )
			properties_tag="-props StanfordCoreNLP-chinese.properties -serverProperties StanfordCoreNLP-chinese.properties"
			port=12346 ;;
		en )
			properties_tag=""
			port=12345 ;;
	esac

	cd corenlp

	if [ "$2" == "--silent" ]; then
		silent_tag="2&>1 >/dev/null"
	else
		silent_tag=""
	fi

	server_params=$properties_tag' -port '$port' -timeout 15000 -quiet -preload tokenize,ssplit,pos,depparse '$silent_tag
	echo $server_params
	# pwd
	# echo $server_command
	# $server_command
	# java -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer $properties_tag -port $port -timeout 15000 -quiet -preload tokenize,ssplit,pos,depparse $silent_tag
	java -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer $server_params

	cd ..
else
	echo $1" is not a supported language."
	echo "Please choose: english OR spanish OR chinese"
fi
