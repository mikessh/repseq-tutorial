java -Xmx8G -jar ../vdjtools-1.0.2.jar Downsample -x 50000 -m ../part2/metadata.txt .
java -Xmx8G -jar ../vdjtools-1.0.2.jar CalcPairwiseDistances -i aa!nt -m metadata.txt .
Rscript analyze.R