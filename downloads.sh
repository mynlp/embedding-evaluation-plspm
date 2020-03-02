#!/bin/bash 

# download wiki dump
# WIKIDUMP=./wiki_complete_dump_2008.txt.tokenized
wget http://www.cs.cornell.edu/~schnabts/eval/wiki_2008.zip
unzip wiki_2008.zip
rm -rf wiki_2008.zip

# download and uncompress BATS
# BATS=./BATS_3.0
wget https://vecto-data.s3-us-west-1.amazonaws.com/BATS_3.0.zip
unzip BATS_3.0.zip
rm -rf BATS_3.0.zip

# clone VecEval
# VECEVAL=../veceval
git clone https://github.com/NehaNayak/veceval.git ../veceval

# clone SentEval
# SENTEVAL=../senteval
git clone https://github.com/facebookresearch/SentEval.git ../senteval


