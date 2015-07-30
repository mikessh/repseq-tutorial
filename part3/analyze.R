require(ggplot2); require(plyr); require(reshape)

df <- read.table("intersect.batch.aa!nt.txt",header=T,sep="\t",comment="")

df$F <- as.numeric(as.character(df$F))

df.1 <- rbind(data.frame(sample=df$X.1_sample_id, div=df$div1, overlapF=df$F, overlapD=df$div12), 
              data.frame(sample=df$X2_sample_id, div=df$div2, overlapF=df$F, overlapD=df$div12))

df.2 <- ddply(df.1, .(sample), summarise,
              div=mean(div),
              overlapF=mean(overlapF),
              overlapD=mean(overlapD))

df.3 <- melt(df.2, id=c("sample","div"))

pdf("overlap.pdf")
ggplot(df.3, aes(x=div,y=value)) + geom_point() + geom_smooth(method=lm) + 
  xlab("Sample diversity") + ylab("Metric value") +
  facet_grid(variable~.,scales="free_y") + theme_bw()
dev.off()