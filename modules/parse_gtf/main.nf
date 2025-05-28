#!/usr/bin/env nextflow

process PARSE_GTF {
    label 'process_medium' // Assigns 4 CPUs

    input:
    path gtf_file

    output:
    path "parsed_gtf.tsv"

    script:
    """
    python3 ${workflow.projectDir}/bin/parse_gtf.py -i ${workflow.projectDir}/refs/gencode.v45.primary_assembly.annotation.gtf -o parsed_gtf.tsv
    mkdir -p ${params.outdir}  # Ensure the output directory exists
    mv parsed_gtf.tsv ${params.outdir}/parsed_gtf.tsv  # Move output file to results directory
    """
}
