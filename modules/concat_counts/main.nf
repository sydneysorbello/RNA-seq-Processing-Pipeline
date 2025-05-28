#!/usr/bin/env nextflow

process CONCAT_COUNTS {
    container "ghcr.io/bf528/pandas:latest"
    label "process_low"
    publishDir params.outdir

    input:
    path verse_outputs
    //path script

    output:
    path("counts_matrix.csv"), emit: concat

    shell:
    """
    concat_counts.py -i ${verse_outputs.join(' ')} -o counts_matrix.csv
    """
}