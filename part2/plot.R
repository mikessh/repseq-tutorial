require(ggplot2)

df.e <- read.table("diversity.strict.exact.txt", header=T, comment="", sep="\t")
df.r <- read.table("diversity.strict.resampled.txt", header=T, comment="", sep="\t")

measures <- c("observedDiversity", "chaoE", "efronThisted", "chao1", "d50Index", "shannonWeinerIndex", "inverseSimpsonIndex")
methods <- c("exact", "resampled")

g <- as.data.frame(expand.grid(measures, methods))
colnames(g) <- c("measure", "method")
g[, "age"] <- numeric(nrow(g))
g[, "naive"] <- numeric(nrow(g))

for (i in 1:nrow(g)) {
  measure <- as.character(g[i,1])
  method <- as.character(g[i,2])
  
  if (method == "exact") {
    df <- df.e
  } else {
    df <- df.r
  }
  
  y <- as.numeric(as.character(df[,paste(measure, "mean", sep="_")]))  
  
  x <- as.numeric(as.character(df[,"age"]))  
  g[i, 3] <- cor(x, y, method="spearman") ^ 2
  x <- as.numeric(as.character(df[,"naive"]))  
  g[i, 4] <- cor(x, y, method="spearman") ^ 2
}

pdf("measure_comparison.pdf")
ggplot(g, aes(x=age, y=naive, color=method, label=measure)) +
  geom_point(size=3, alpha=0.3) + geom_text(cex=4, hjust=0) +
  scale_x_continuous(name = bquote('Correlation with age, Spearman '*R^2*' '), limits=c(0,1)) + 
  scale_y_continuous(name = bquote('Correlation with naive T-cell percentage, Spearman '*R^2*' '), limits=c(0,1)) +
  scale_color_brewer(palette="Set2") +
  facet_grid(~method) +
  theme_bw()+theme(legend.position="none")
dev.off()