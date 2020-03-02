
install.packages("plspm")
library(plspm)

sat_data <- read.csv('../csv/all_normalized.csv')

ALG <- c(0,0,0,0,0,0,0,0,0,0,0,0)
COR <- c(0,0,0,0,0,0,0,0,0,0,0,0)
DIM <- c(0,0,0,0,0,0,0,0,0,0,0,0)
WIN <- c(0,0,0,0,0,0,0,0,0,0,0,0)

INF <- c(1,1,1,1,0,0,0,0,0,0,0,0)
DER <- c(1,1,1,1,0,0,0,0,0,0,0,0)
LEX <- c(1,1,1,1,0,0,0,0,0,0,0,0)
ENC <- c(1,1,1,1,0,0,0,0,0,0,0,0)

#senteval_task
CLA <- c(0,0,0,0,1,1,1,1,0,0,0,0)
NLI <- c(0,0,0,0,1,1,1,1,0,0,0,0)
STS <- c(0,0,0,0,1,1,1,1,0,0,0,0)
PD <- c(0,0,0,0,1,1,1,1,0,0,0,0)
sat_path <- rbind(ALG, COR, DIM, WIN, INF, DER, LEX, ENC, CLA, NLI, STS, PD)

colnames(sat_path) <- rownames(sat_path)

ALG_block <- c("P_alg")
COR_block <- c("P_cor")
DIM_block <- c("P_dim")
WIN_block <- c("P_win")

INF_block <- c("I01", "I02", "I03", "I04", "I05", "I06", "I07", "I08", "I09", "I10")
DER_block <- c("D01", "D02", "D03", "D04", "D05", "D06", "D07", "D08", "D09", "D10")
LEX_block <- c("L01", "L02", "L03", "L04", "L05", "L06", "L07", "L08", "L09", "L10")
ENC_block <- c("E01", "E02", "E03", "E04", "E05", "E06", "E07", "E08", "E09", "E10")

#senteval task block
CLA_block <- c("S_MR", "S_CR", "S_SUBJ", "S_MPQA", "S_TREC", "S_SST2", "S_SST5")
NLI_block <- c("S_SICKEntailment")
STS_block <- c("S_SICKRelatedness", "S_STS12", "S_STS13", "S_STS14", "S_STS15", "S_STS16", "S_STSBenchmark")
PD_block <- c("S_MRPC")

sat_blocks <- list(ALG_block, COR_block, DIM_block, WIN_block, INF_block, DER_block, LEX_block, ENC_block, CLA_block, NLI_block, STS_block, PD_block)

ALG_scale <- c("nom")
COR_scale <- c("nom")
DIM_scale <- c("num")
WIN_scale <- c("num")

INF_scale <- rep("raw", 10)
DER_scale <- rep("raw", 10)
LEX_scale <- rep("raw", 10)
ENC_scale <- rep("raw", 10)

CLA_scale <- rep("raw", 7)
NLI_scale <- c("raw")
STS_scale <- rep("raw", 7)
PD_scale <- c("raw")

sat_scale <- list(ALG_scale, COR_scale, DIM_scale, WIN_scale, INF_scale, DER_scale, LEX_scale, ENC_scale, CLA_scale, NLI_scale, STS_scale, PD_scale)

sat_modes <- c("A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A")

satpls <- plspm(sat_data, sat_path, sat_blocks, scaling=sat_scale, modes=sat_modes, boot.val = TRUE, br = 600)

# summary of results
summary(satpls)

# plot inner model results
plot(satpls, what = "inner", curve=0.1, box.size=0.02, arr.pos=0.75, cex.txt=0.4)

# plot outer model loadings
plot(satpls, what = "loadings", box.size=0.02)

# plot outer model weights
plot(satpls, what = "weights", box.size=0.02)
