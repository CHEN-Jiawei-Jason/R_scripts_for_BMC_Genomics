library(DESeq2)

dataall <-read.csv('data_DESeq2.csv',header = T) #input readcount
#data <- data.frame(dataall[,2:7]) #P15 vs P0.1
#data <- data.frame(dataall[,2:4],dataall[,8:10]) #P25 vs P0.1
#data <- data.frame(dataall[,5:10]) #P25 s P15
data <- data.frame(dataall[,2:7]) #P15 vs P0.1
rownames(data) = dataall[,1]

condition <- as.factor(c(rep("atmos",3),rep("HHP",3)))
coldata <- data.frame(id=colnames(data), condition = condition)
coldata$condition <- relevel(coldata$condition, ref="atmos")

dds <- DESeqDataSetFromMatrix(countData = data, colData = coldata, design = ~ condition)
keep <- rowSums(counts(dds)) >= 1000
dds <- dds[keep,]
head(dds)

dds <- DESeq(dds)
resultsNames(dds)
res <- results(dds)

diff_up_deseq2 <-subset(res, padj < 0.01 & log2FoldChange > 1)
write.csv(diff_up_deseq2,file = "diff_up_deseq2.csv")

