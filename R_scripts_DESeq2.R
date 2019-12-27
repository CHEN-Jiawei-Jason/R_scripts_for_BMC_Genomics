library(DESeq2)
#input readcount (integer)
dataall <-read.csv('data_DESeq2.csv',header = T)
#data <- data.frame(dataall[,11:16]) #A4A5
#data <- data.frame(dataall[,11:13],dataall[,17:19]) #A4A6
#data <- data.frame(dataall[,11:13],dataall[,20:22]) #A4A7


data <- data.frame(dataall[,11:13],dataall[,17:19]) #A4A6
rownames(data) = dataall[,1] #行名添加

#normal analysis
condition <- as.factor(c(rep("atmos",3),rep("HHP",3))) #说明条件
coldata <- data.frame(id=colnames(data), condition = condition) #建立条件矩阵
coldata$condition <- relevel(coldata$condition, ref="atmos") #说明对照组

dds <- DESeqDataSetFromMatrix(countData = data, colData = coldata, design = ~ condition) #建立数据与条件的matrix
keep <- rowSums(counts(dds)) >= 1000 #过滤数据，减少假基因
dds <- dds[keep,]
head(dds) #检查dds的构建

dds <- DESeq(dds) #进行计算
resultsNames(dds) #检查比较对象
res <- results(dds) #获取结果
#table(res$padj < 0.05)
diff_up_deseq2 <-subset(res, padj < 0.01 & log2FoldChange > 1) #筛选数据
diff_down_deseq2 <-subset(res, padj < 0.01 & log2FoldChange < -1) #筛选数据
#setwd("E:\\") #输出表格保存路径
write.csv(diff_up_deseq2,file= "diff_up_deseq2.csv")
write.csv(diff_down_deseq2,file= "diff_down_deseq2.csv")