library(DESeq2)
#input readcount (integer)
dataall <-read.csv('data_DESeq2.csv',header = T)
#data <- data.frame(dataall[,11:16]) #A4A5
#data <- data.frame(dataall[,11:13],dataall[,17:19]) #A4A6
#data <- data.frame(dataall[,11:13],dataall[,20:22]) #A4A7


data <- data.frame(dataall[,11:13],dataall[,17:19]) #A4A6
rownames(data) = dataall[,1] #��������

#normal analysis
condition <- as.factor(c(rep("atmos",3),rep("HHP",3))) #˵������
coldata <- data.frame(id=colnames(data), condition = condition) #������������
coldata$condition <- relevel(coldata$condition, ref="atmos") #˵��������

dds <- DESeqDataSetFromMatrix(countData = data, colData = coldata, design = ~ condition) #����������������matrix
keep <- rowSums(counts(dds)) >= 1000 #�������ݣ����ټٻ���
dds <- dds[keep,]
head(dds) #���dds�Ĺ���

dds <- DESeq(dds) #���м���
resultsNames(dds) #���Ƚ϶���
res <- results(dds) #��ȡ���
#table(res$padj < 0.05)
diff_up_deseq2 <-subset(res, padj < 0.01 & log2FoldChange > 1) #ɸѡ����
diff_down_deseq2 <-subset(res, padj < 0.01 & log2FoldChange < -1) #ɸѡ����
#setwd("E:\\") #������񱣴�·��
write.csv(diff_up_deseq2,file= "diff_up_deseq2.csv")
write.csv(diff_down_deseq2,file= "diff_down_deseq2.csv")