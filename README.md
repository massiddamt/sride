# sRIde RNA-Seq
Snakemake enabled pipeline for smallRNA-Seq identification

## Authors

* Gianmauro Cuccuru

## Tools
mirdeep2: https://www.mdc-berlin.de/n-rajewsky#t-data,software&resources

## Usage
### Execute workflow

Test your configuration by performing a dry-run via

    snakemake -n

Execute the workflow locally via

    snakemake --cores $N

using `$N` cores or run it in a cluster environment via

    snakemake --cluster qsub --jobs 100

or
    snakemake --drmaa --jobs 100

See the [Snakemake documentation](https://snakemake.readthedocs.io) for further details.