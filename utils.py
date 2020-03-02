from collections import OrderedDict
import csv

# Usage :
# from utils import *
# data = aggregating(<WORD_EMBEDDING_ALGORITHM>, <WORD_EMBEDDING_CORPUS>, <WORD_EMBEDDING_DIMENSION_SIZE>, <WORD_EMBEDDING_CONTEXT_WINDOWS>, preprocess_bats(<BATS_RESULT_DICTIONARY>), parse_veceval(<VECEVAL_LOG_PATH>), preprocess_senteval(<SENTEVAL_RESULT_DICTIONARY>))
# print_csv(data, <OUTPUT_FILE_PATH>)

# assume that `res` is a dictionary of BATS results from vecto package
def preprocess_bats(res):
    for r in res:
        cor = 0
        total = 0
        for rd in r['details']:
            if type(rd) == type([]) and len(rd) == 1: rd = rd[0]
            if not rd: continue
            total += 1
            if rd['rank'] == 0: cor += 1
        r['result']['cnt_questions_total'] = total
        r['result']['cnt_questions_correct'] = cor
        r['result']['accuracy'] = float(cor / total)
    return res

# 2019-03-06 16:50:02   phdeval A_skipgram_C_nyt_S_100_W_9  nli fixed   train   1.0106343440149324  0.5917569640294889
def parse_veceval(log):
    veceval = {}
    for line in open(log):
        toks = line.strip().split('\t')
        if toks[5] != 'val': continue
        task = 'V_' + toks[3]
        score = toks[7]
        veceval[task] = score
    return veceval

# assume that `res` is a dictionary of SentEval results
def preprocess_senteval(res):
    senteval = {}
    for r in res.keys():
        if 'f1' in list(res[r].keys()):
            senteval[r] = res[r]['f1']
        elif 'acc' in list(res[r].keys()):
            senteval[r] = [r]['acc']
        elif 'pearson' in list(res[r].keys()):
            senteval[r] = res[r]['pearson']
        else:
            senteval[r] = res[r]['all']['pearson']['mean']
    return senteval

def aggregating(alg, cor, dim, win, bats, veceval, senteval):
    data = [alg, cor, dim, win]

    for b in bats:
        data.append(b['result']['accuracy'])

    for s in OrderedDict(sorted(senteval.items())):
        data.append(senteval[s])

    for v in OrderedDict(sorted(veceval.items())):
        data.append(veceval[v])

    return data

def print_csv(data, output='all_results.csv'):
    header = ['P_alg', 'P_cor', 'P_dim', 'P_win', 'I01', 'I02', 'I03', 'I04', 'I05', 'I06', 'I07', 'I08', 'I09', 'I10', 'D01', 'D02', 'D03', 'D04', 'D05', 'D06', 'D07', 'D08', 'D09', 'D10', 'E01', 'E02', 'E03', 'E04', 'E05', 'E06', 'E07', 'E08', 'E09', 'E10',  'L01', 'L02', 'L03', 'L04', 'L05', 'L06', 'L07', 'L08', 'L09', 'L10', 'S_CR', 'S_MPQA', 'S_MR', 'S_MRPC', 'S_SICKEntailment', 'S_SICKRelatedness', 'S_SST2', 'S_SST5', 'S_STS12', 'S_STS13', 'S_STS14', 'S_STS15', 'S_STS16', 'S_STSBenchmark', 'S_SUBJ', 'S_TREC', 'V_chunk', 'V_ner', 'V_nli', 'V_pos', 'V_questions', 'V_sentiment']

    with open(output, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        if type(data[0]) == type([]):
            for line in data:
                writer.writerow(line)
        else:
            writer.writerow(data)

    return 1

def main():
    pass

if __name__ == '__main__':
    main()
