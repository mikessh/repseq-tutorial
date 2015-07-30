# Compute diversity statistics
java -Xmx8G -jar ../vdjtools-1.0.2.jar CalcDiversityStats -m metadata.txt .

# Compare various estimates using correlation with age and %naive T-cells
Rscript plot.R