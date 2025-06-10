# Basic-RNA-seq-Processing-Pipeline
This repository stores code for a RNA-seq processing pipeline. It is important to note that the sequencing methodology used paired-end reads. This project was completed for Boston University graduate level course: BF528 and was closley guided by project parameters. 

The data used in this project was published Chandra et. al. in 'The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α' (Chandra, 2022). 

The nextflow pipeline requires the initial fasta files from an RNA-seq experiment with meta data for sample names and paired read information. This information can be stored in a samplesheet csv. 

## List of Required Packages:

**FASTQC:** Quality control tool that outputs a diagnostic html. In RNA-seq experiments it is expected that the per base sequence cntent, sequence duplication, and overrepresented sequence modules will fail. 

**STAR:** A splice aware aligner that can identify RNA transcripts and index them for downstream analysis. 

**MULTIQC:** Aggregates quality control for multiple samples or replicates to create one cohesive html diagnostic file.

**VERSE:** Produces counts for RNA transcripts for each individual replicate.

## Scripts:

There are two scripts needed for this pipeline located in the bin folder. 

**PARSE_GTF** This script will parse a gtf file to provide corresponsing gene symbols for the endsembl ids. The output is a single txt file that allows for more interpretable visualizations

**CONCAT_COUNTS** This script will concatenate the counts produced by VERSE to make one raw counts matrix. 


Work Cited:
1. Chandra, V., Ibrahim, H., Halliez, C. et al. The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α. Nat Commun 13, 6363 (2022). https://doi.org/10.1038/s41467-022-34069-z
