#!/bin/bash

# install gluon-nlp under this dir
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $THIS_DIR/gluon-nlp
python3 setup.py install

# prepare dict 
mkdir -p ~/.mxnet/models
cd ~/.mxnet/models 
wget https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/gluon/dataset/vocab/book_corpus_wiki_en_uncased-a6607397.zip
unzip *.zip
       
