library(ggplot2)
data <-read.csv('d:/Rmaterial/barenr.csv',header=T) 
dorder = factor(as.integer(rownames(data)),labels=data$Description)

#GO
ggplot(data,aes(x=Description,y=Rich_factor,fill=Class))+
geom_bar(stat="identity",position=position_dodge(0.7),width=0.6,aes(x=dorder))+ 
coord_flip()+ 
labs( title="b. P15 down-regulated")+
scale_fill_discrete(name="GO Ontology")+ 
theme_bw() +
xlab("Enriched GO Term")+ 
theme(plot.title = element_text(size = 11)) 

#Pfam,KEGG
pfam <-read.csv('d:/Rmaterial/bubbleenr.csv',header=T)
ggplot(pfam,aes(Rich_factor,Gene_family))+  
 geom_point(aes(size=Gene_number,color=adjust_p_value))+  
 scale_colour_gradient(low="red",high="green",limits= c(0,0.01))+ 
 labs(color=expression(adjust_p_value),size="Gene number",x="Rich factor",y= NULL,
             title="a. P25 up-regulated")+ 
 theme_bw()+
 theme(axis.title.x= element_text(size=10))+ 
 theme(plot.title = element_text(size = 11))+ 
 theme(legend.title=element_text(size=9),legend.key.width=unit(0.38,'cm'),
              legend.text= element_text(size=7)) 