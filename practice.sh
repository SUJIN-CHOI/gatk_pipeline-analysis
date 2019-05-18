#!/bin/bash

###4. BWA mem : FASTQ to SAM
#PATH
BWA="/Tools/bwa-0.7.17/bwa"
REFERENCE="/Tools/reference/ucsc.hg19.fasta"

${BWA} mem -R "@RG\tID:test\tSM:SRR000982\tPL:ILLUMINA" ${REFERENCE} SRR000982_1.filt.fastq.gz SRR000982_2.filt.fa    stq.gz > SRR000982.mapped.sam

#Samtools : SAM to BAM
samtools view –Sb SRR000982.mapped.sam > SRR000982.mapped.bam

#Samtools sort : Make Sorted BAM
samtools sort –o SRR000982.mapped.sorted.bam SRR000982.mapped.bam
samtools view SRR000982.mapped.bam | head
samtools view SRR000982.mapped.sorted.bam | head # Sort chromosome ordered


###5. Mark Duplicate
#5.1. Picard MarkDuplicate : Sorted BAM to Markdup BAM
java –jar picard.jar MarkDuplicates I=SRR000982.
mapped.sorted.bam O=SRR000982.mapped.sorted.markdup.bam
M=SRR000982.markdup.metrics.txt

#5.2. Samtools index : Make BAM index
samtools index SRR000982.mapped.sorted.markdup.bam
###6. GATK
#6.1. GATK BaseRecalibrator
java -jar gatk-package-4.x.x.x-local.jar BaseRecalibrator -I SRR000982.mapped.sorted.markdup.bam -R ucsc.hg19.fast    a --known-sites dbsnp_138.hg19.vcf.gz --known-sites Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.gz -O SRR0    00982.recal_data.table

java -jar gatk-package-4.x.x.x-local.jar ApplyBQSR -R ucsc.hg19.fasta -I SRR000982.mapped.sorted.markdup.bam --bqs    r-recal-file SRR000982.recal_data.table -O SRR000982.mapped.sorted.markdup.recal.bam

samtools index SRR000982.mapped.sorted.markdup.recal.bam
