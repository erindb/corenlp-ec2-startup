#! usr/bin/bash

# SERVE.sh - A script to install a corenlp server

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

cd corenlp

echo "downloading current english models"
wget http://nlp.stanford.edu/software/stanford-corenlp-models-current.jar
echo "downloading current spanish models"
wget http://nlp.stanford.edu/software/stanford-spanish-corenlp-models-current.jar
echo "downloading current chinese models"
wget http://nlp.stanford.edu/software/stanford-chinese-corenlp-models-current.jar

cd ..