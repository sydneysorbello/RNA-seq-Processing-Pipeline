#!/usr/bin/env nextflow

process VERSE {

    container "ghcr.io/bf528/verse:latest"
    label "process_single"
    publishDir params.outdir

    input:
    path input_file
    path gtf

    output:
    path("*exon.txt"), emit: exon
    path("*summary.txt"), emit: summary

    shell:
    def name = input_file.simpleName
    """
    verse -S -a ${gtf} -o ${name}_verse_counts.txt ${input_file}
    """
}