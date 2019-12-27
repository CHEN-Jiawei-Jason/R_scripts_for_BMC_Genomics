library(pheatmap)
library(gplots)
library(permute)
library(lattice)
library(vegan)

#input data
data4<-read.csv('d:/Rmaterial/apheatmap1.csv',header=T,row.names = 1)
anno1<-read.csv('d:/Rmaterial/annoapheatmap1.csv',header=F,row.names = 1)
colnames(anno1)=c("Group")

#data4<-read.csv('d:/Rmaterial/apheatmap2.csv',header=T,row.names = 1)
#anno1<-read.csv('d:/Rmaterial/annoapheatmap2.csv',header=F,row.names = 1)
#colnames(anno1)=c("Group")

#data4<-read.csv('d:/Rmaterial/apheatmap3.csv',header=T,row.names = 1)
#anno1<-read.csv('d:/Rmaterial/annoapheatmap3.csv',header=F,row.names = 1)
#colnames(anno1)=c("Group")

data4<-as.matrix(data4)
drows<-vegdist(data4,method="bray")
dcols<-vegdist(t(data4),method="bray")
pheatmap(data4,cellwidth = 25, cellheight =8, treeheight_row = 0, cluster_rows = F,cluster_cols = F,
         treeheight_col = 10 ,color = colorRampPalette(c("yellow","firebrick3"))(100), scale="row", legend=TRUE,border_color=NA,fontsize_row=8, 
         fontsize_col=10, fontface="italic",clustering_distance_rows = drows,clustering_distance_cols = dcols,
         clustering_method="ward.D2",annotation_row = anno1,
         main="")
