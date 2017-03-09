#! usr/bin/bash

sudo apt-get update
sudo apt-get install unzip
sudo apt-get install default-jre
sudo apt-get install authbind

corenlp_dir="stanford-corenlp-full-2016-10-31"

wget "http://nlp.stanford.edu/software/$corenlp_dir.zip"
unzip $corenlp_dir.zip

ln -s $corenlp_dir corenlp