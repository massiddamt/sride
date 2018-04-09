# sRIde RNA-Seq
Snakemake enabled pipeline for smallRNA-Seq identification

## Authors

* Gianmauro Cuccuru

## Tools
[trim galore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/),
[mirdeep2](https://www.mdc-berlin.de/n-rajewsky#t-data,software&resources),
[fastq-screen](https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen/)

## Requirements

Conda must be present in your computer.
To install it, see [https://conda.io/miniconda.html](https://conda.io/miniconda.html)

## Usage

## Getting started

### Prepare the environment

1. Create a conda virtual environment
    ```bash
    conda create -n _project_name_ -c bioconda --file requirements.txt
    ```

2. Activate the virtual environment
    ```bash
    source activate _project_name_
    ```

3. Clone the repository [sride](https://bitbucket.org/biopipelines/sride)
    ```bash
       git clone https://bitbucket.org/biopipelines/sride/src/master/
    ```

4. Change directory to sride
    ```bash
    cd sride
    ```

5. Edit config file as needed
    ```bash
    vi config.testdata.yaml
    ```


### Get reference and test data

This pipeline needs a data directory with all the refence and test data. Produce
 it is easy:

1. Clone the repository [sride_data](https://bitbucket.org/biopipelines/sride_data) into the sride directory
   ```bash
   git clone https://bitbucket.org/biopipelines/sride_data/src/master/ data
   ```

2. Change directory to data
   ```bash
   cd data
   ```

3. execute snakemake
   ```bash
   snakemake --use-conda --cores $N
   ```
$n is the number of cores to use.
At the end, the size of 'data' dir will be about 2.5GB

4. Change back to sride directory
   ```bash
   cd ..
   ```

### Execute workflow

1. Test your configuration by performing a dry-run via
    ```bash
    snakemake --use-conda --configfile config.testdata.yaml --directory test --dryrun
    ```

2. Execute the workflow locally with test data into a test directory
    ```bash
    snakemake --use-conda --cores $N --configfile config.testdata.yaml --directory test
    ```
using `$N` cores

More details to execute Snakemake at [Snakemake documentation](https://snakemake.readthedocs.io).
