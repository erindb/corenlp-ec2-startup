#! usr/bin/bash

if [[ $platform == 'linux' ]]; then
	sudo apt-get update
	sudo apt-get install unzip
	sudo apt-get install default-jre
	sudo apt-get install authbind
fi

corenlp_dir="stanford-corenlp-full-2016-10-31"

wget "http://nlp.stanford.edu/software/$corenlp_dir.zip"
unzip $corenlp_dir.zip

ln -s $corenlp_dir corenlp
