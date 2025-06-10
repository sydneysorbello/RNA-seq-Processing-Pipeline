#!/usr/bin/env nextflow

include { FASTQC } from './modules/fastqc'
include { STAR_INDEX } from './modules/star_index'
include { PARSE_GTF } from './modules/parse_gtf'
include {STAR_ALIGN} from './modules/star_align'
include { MULTIQC } from './modules/multiqc'
include { VERSE } from './modules/verse'
include { CONCAT_COUNTS } from './modules/concat_counts'

workflow {

    Channel.fromFilePairs(params.reads)
    | set { align_ch }

    Channel.fromFilePairs(params.reads).transpose()
    | set { fastqc_ch }

    gtf_parsed_ch = Channel.value("${params.outdir}/parsed_gtf.tsv")
    PARSE_GTF(params.gtf)

    FASTQC(fastqc_ch)
    
    STAR_INDEX(params.genome, params.gtf)

    STAR_ALIGN(STAR_INDEX.out, fastqc_ch)

    multiqc_ch = STAR_ALIGN.out.log.mix(FASTQC.out.zip).flatten().collect()
    
    MULTIQC(file(params.outdir))

    bam_ch = Channel.fromPath("results/*.bam")

    VERSE(bam_ch, params.gtf)

    CONCAT_COUNTS(VERSE.out.exon.collect())

}
