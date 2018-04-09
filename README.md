# sRIde RNA-Seq
Snakemake enabled pipeline for smallRNA-Seq identification

## Authors

* Gianmauro Cuccuru

## Tools
[trim galore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/)
[fastq-screen](https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen/)

[mirdeep2](https://www.mdc-berlin.de/n-rajewsky#t-data,software&resources)

## Usage

### Reference and test data


### Execute workflow

Test your configuration by performing a dry-run via

    snakemake --use-conda --dryrun

Execute the workflow locally via

    snakemake --use-conda --cores $N

using `$N` cores

More details at [Snakemake documentation](https://snakemake.readthedocs.io).
