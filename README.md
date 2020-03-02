# Analyzing Word Embedding using Structural Equation Modeling
This repository provides scripts for reproducing of a paper, Analyzing Word Embedding using Structural Equation Modeling, which will be appeared in LREC 2020.

## Reproduce PLS-PM models suggested in our paper
Run R scripts in `./plspm`. Each scripts contain its own PLS-PM model. All data used in our experiments can be found in `./csv`. We used R > 3.2. Note that our scripts not only print result log, but also generate a PDF file containing plots.

## If you want to follow our experiments from scratch

### Prepare data
Run `downloads.sh`. It assumes that current folder is not root. It includes wikipedia dump file [Schnabel+ 15], BATS [Gladkova+ 16], VecEval [Nayak+ 16], and SentEval [Conneau & Kiela 18].
Some data, for example `New York Times corpus`, are not available by this script because they are not free to download or share.

### Train a word embedding model
We used `gensim` python package for training word embeddings, like below. Further information can be found at [official gensim API](https://radimrehurek.com/gensim/index.html).
```
# example for skipgram
from gensim.models import KeyedVectors, FastText, Word2Vec
from gensim.models.word2vec import LineSentence
corpus = LineSentence(<CORPUS_PATH>)
model = Word2Vec(sentences=corpus, size=<DIMENSION_SIZE>, window=<CONTEXT_WINDOW>, sg=0)
```

### Test with [BATS](https://vecto.space/projects/BATS/), [VecEval](https://github.com/NehaNayak/veceval), and [SentEval](https://github.com/facebookresearch/SentEval)
In our experiments, basically we followed existing codes of above repositories, VecEval and SentEval. We recommend that you also follow their directions. For BATS, you can find official codes for evaluation of BATS from [vecto](https://github.com/vecto-ai/vecto), the official python package for BATS.

### Aggregate evaluation results
We assume that you follow basic scripts of existing packages. `utils.py` is our script for converting all results to one csv file, which is used for PLS-PM modeling. Details for each dataset will come below.

#### BATS
[vecto](https://github.com/vecto-ai/vecto) generates a dictionary data as an evaluation result of BATS. We need an accuracy for BATS, and it will be calculated in preprocessing.

#### VecEval
VecEval automatically generates a result log file as tsv format. So, Only to parse log file is enough.

#### SentEval
SentEval stores all evaluation results in one dictionary data, similar to `vecto`. In our experiments, we just treat all performance indicator as same, such as F1 score, accuracy, and pearson coefficient.

### Estimate a PLS-PM model
[The official repository for plspm R package](https://github.com/gastonstat/plspm) provides sample codes for PLS-PM modeling. You can follow its documents to design and estimate your own PLS-PM model.

## Reference
- Conneau, A. and Kiela, D. (2018). Senteval: An evaluation toolkit for universal sentence representations. arXiv preprint arXiv:1803.05449.
- Gladkova, A., Drozd, A., and Matsuoka, S. (2016). Analogy-based detection of morphological and semantic relations with word embeddings: What works and what doesn’t. In Proceedings of the NAACL-HLT SRW, pages47–54, San Diego, California, June 12-17, 2016. ACL.
- Nayak, N., Angeli, G., and Manning, C. D. (2016). Evaluating word embeddings using a representative suite of practical tasks. In Proceedings of the 1st Workshop on Evaluating Vector Space Representations for NLP, pages 19–23.
- Sanchez, G. (2013). Pls path modeling with r.Berkeley:Trowchez Editions, 383:2013.
- Schnabel, T., Labutov, I., Mimno, D., and Joachims, T.(2015). Evaluation methods for unsupervised word embeddings. In Proceedings of the 2015 Conference on Empirical Methods in Natural Language Processing, pages 298–307.

## Contact
If you have any questions, please mail to `namgi@nii.ac.jp`.


