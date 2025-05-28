#!/usr/bin/env nextflow

process STAR_ALIGN {

    container "ghcr.io/bf528/star:latest"
    label "process_high"
    publishDir params.outdir

    input:
    path genome
    tuple val(name), path(fastq)

    output:
    path("${name}.Aligned.out.bam"), emit: bam
    path("${name}.Log.final.out"), emit: log

    shell:
    """
    STAR --runThreadN $task.cpus --genomeDir $genome --readFilesIn $fastq --readFilesCommand zcat --outFileNamePrefix ${name}. --outSAMtype BAM Unsorted
    """
}