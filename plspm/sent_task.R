
install.packages("plspm")
library(plspm)

sat_data <- read.csv('../csv/all_normalized.csv')

INF <- c(0,0,0,0,0,0,0,0)
DER <- c(0,0,0,0,0,0,0,0)
LEX <- c(0,0,0,0,0,0,0,0)
ENC <- c(0,0,0,0,0,0,0,0)

#veceval_task
#SYN <- c(1,1,1,1,0,0)
#SEM <- c(1,1,1,1,0,0)

#POS <- c(1,1,1,1,0,0,0,0,0,0)
#CHU <- c(1,1,1,1,0,0,0,0,0,0)
#NER <- c(1,1,1,1,0,0,0,0,0,0)
#NLI <- c(1,1,1,1,0,0,0,0,0,0)
#SEN <- c(1,1,1,1,0,0,0,0,0,0)
#QUE <- c(1,1,1,1,0,0,0,0,0,0)
#sat_path <- rbind(INF, DER, LEX, ENC, SYN, SEM)

#senteval_task
CLA <- c(1,1,1,1,0,0,0,0)
NLI <- c(1,1,1,1,0,0,0,0)
STS <- c(1,1,1,1,0,0,0,0)
PD <- c(1,1,1,1,0,0,0,0)
sat_path <- rbind(INF, DER, LEX, ENC, CLA, NLI, STS, PD)

#syn/sem classification
#D_SYN <- c(1,1,0,0,0,0)
#D_SEM <- c(0,0,1,1,0,0)

colnames(sat_path) <- rownames(sat_path)

#INF_block <- c("I01", "I02", "I05", "I06")
INF_block <- c("I01", "I02", "I03", "I04", "I05", "I06", "I07", "I08", "I09", "I10")
DER_block <- c("D01", "D02", "D03", "D04", "D05", "D06", "D07", "D08", "D09", "D10")
LEX_block <- c("L01", "L02", "L03", "L04", "L05", "L06", "L07", "L08", "L09", "L10")
#ENC_block <- c("E01", "E02", "E03", "E04", "E05", "E06", "E07", "E09", "E10")
ENC_block <- c("E01", "E02", "E03", "E04", "E05", "E06", "E07", "E08", "E09", "E10")

#veceval task block
#SYN_block <- c("V_pos", "V_chunk")
#SEM_block <- c("V_ner", "V_nli", "V_sentiment", "V_questions")
#sat_blocks <- list(INF_block, DER_block, LEX_block, ENC_block, SYN_block, SEM_block)

#POS_block <- c("V_pos")
#CHU_block <- c("V_chunk")
#NER_block <- c("V_ner")
#NLI_block <- c("V_nli")
#SEN_block <- c("V_sentiment")
#QUE_block <- c("V_questions")

#senteval task block
CLA_block <- c("S_MR", "S_CR", "S_SUBJ", "S_MPQA", "S_TREC", "S_SST2", "S_SST5")
#CLA_block <- c("S_MR", "S_CR", "S_SUBJ", "S_MPQA", "S_SST2", "S_SST5")
NLI_block <- c("S_SICKEntailment")
STS_block <- c("S_SICKRelatedness", "S_STS12", "S_STS13", "S_STS14", "S_STS15", "S_STS16", "S_STSBenchmark")
PD_block <- c("S_MRPC")
sat_blocks <- list(INF_block, DER_block, LEX_block, ENC_block, CLA_block, NLI_block, STS_block, PD_block)

#veceval syn/sem block
#D_SYN_block <- c("V_pos", "V_chunk", "V_ner")
#D_SEM_block <- c("V_nli", "V_sentiment", "V_questions")

#senteval syn/sem block
#D_SYN_block <- c("S_MPQA")
#D_SEM_block <- c("S_CR", "S_MR", "S_MRPC", "S_SICKEntailment", "S_SICKRelatedness", "S_SST2", "S_SST5", "S_STS12", "S_STS13", "S_STS14", "S_STS15", "S_STS16", "S_STSBenchmark", "S_SUBJ", "S_TREC")


#INF_scale <- rep("raw", 10)
#DER_scale <- rep("raw", 10)
#LEX_scale <- rep("raw", 10)
#ENC_scale <- rep("raw", 10)

#D_SYN_scale <- rep("raw", 3)
#D_SEM_scale <- rep("raw", 3)

#sat_scale <- list(INF_scale, DER_scale, LEX_scale, ENC_scale, D_SYN_scale, D_SEM_scale)

sat_modes <- c("A", "A", "A", "A", "A", "A", "A", "A")

satpls <- plspm(sat_data, sat_path, sat_blocks, modes=sat_modes, boot.val = TRUE, br = 600)

# summary of results
summary(satpls)

# plot inner model results
plot(satpls, what = "inner", curve=0.1, box.size=0.02, arr.pos=0.7, cex.txt=0.7)

# plot outer model loadings
plot(satpls, what = "loadings", box.size=0.02)

# plot outer model weights
plot(satpls, what = "weights", box.size=0.02)
