export JAVA_OPTS="-Xmx8G" # set memory limit
MIGEC="java -jar ../migec-1.2.1b.jar"
MITCR="java -jar ../mitcr.jar"
VDJTOOLS="java -jar ../vdjtools-1.0.2.jar"

## migec & mitcr
# de-multiplex
$MIGEC Checkout -ou barcodes.txt trb_R1.fastq.gz trb_R2.fastq.gz checkout/
# analyze umi coverage
$MIGEC Histogram checkout/ histogram/
cd histogram/
wget https://raw.githubusercontent.com/mikessh/migec/master/util/histogram.R
Rscript histogram.R
cd ..
# assemble
$MIGEC AssembleBatch --force-overseq 5 --force-collision-filter checkout/ histogram/ assemble/

# cdrblast    
# different quality thresholds
for q in 20 25 30 35; do 
   $MIGEC CdrBlast -R TRB -q $q checkout/S2-1-beta_R2.fastq cdrblast/S2-1-beta.raw$q.txt
done
# second sample, Q35, for replica-based filtering
$MIGEC CdrBlast -R TRB -q 35 checkout/S2-2-beta_R2.fastq cdrblast/S2-2-beta.raw35.txt
# frequency-based error correction (mitcr)
$MITCR -pset flex checkout/S2-1-beta_R2.fastq cdrblast/S2-1-beta.mitcr.txt
# assembled data
$MIGEC CdrBlast -a -R TRB assemble/S2-1-beta_R2.t5.cf.fastq cdrblast/S2-1-beta.asm.txt


## vdjtools
# convert
$VDJTOOLS Convert -S migec `ls cdrblast/S2-*-beta.raw*.txt` cdrblast/S2-1-beta.asm.txt convert/
$VDJTOOLS Convert -S mitcr cdrblast/S2-1-beta.mitcr.txt convert/
# all rarefaction curves
$VDJTOOLS RarefactionPlot -f sample_id `ls convert/S2-1-beta.raw*.txt` convert/S2-1-beta.mitcr.txt rarefaction/qual-and-freq
# plot curve for assembled data separately, as it uses #UMIs as count, not reads
$VDJTOOLS RarefactionPlot -f sample_id convert/S2-1-beta.asm.txt rarefaction/umi
# overlapped replicas
$VDJTOOLS OverlapPair convert/S2-1-beta.raw35.txt convert/S2-2-beta.raw35.txt convert/
$VDJTOOLS RarefactionPlot -f sample_id convert/S2-1-beta.raw35.txt convert/S2-2-beta.raw35.txt convert/paired.strict.table.txt rarefaction/overlap