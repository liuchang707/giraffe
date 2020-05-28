
library("ggplot2")
a=read.table("ENSBTAT00000000187.out",header=T)
pdf("ENSBTAT00000000187.pdf",width=5,height=3);
ggplot(a,aes(pos,depth,color=ind))+geom_line()+scale_color_manual(values=c("#025a8d","#2e8cbd","#a7bcda","#58955c","#BBFFFF","#B22222","#9B30FF","#FF6EB4","#EEEE00"))+labs(x="ENSBTAT00000000187")
dev.off();
