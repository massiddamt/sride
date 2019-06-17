import pandas as pd
from snakemake.utils import validate, min_version
##### set minimum snakemake version #####
min_version("5.1.2")


##### load config and sample sheets #####
#configfile: "config.yaml"

## USER FILES ##
samples = pd.read_csv(config["samples"], index_col="sample", sep="\t")
## ---------- ##



##### local rules #####

localrules: all, pre_rename_fastq_se, post_rename_fastq, pre_mirdeep2_identification

rule all:
    input:
        "qc/multiqc.html",
        expand("discovering/{sample.sample}/{sample.sample}_result.html", sample=samples.reset_index().itertuples()),
        expand("discovering/{sample.sample}/{sample.sample}_result.csv", sample=samples.reset_index().itertuples()),
        expand("discovering/{sample.sample}/{sample.sample}_survey.csv", sample=samples.reset_index().itertuples()),
        expand("discovering/{sample.sample}/{sample.sample}_output.mrd", sample=samples.reset_index().itertuples())


include_prefix="rules"

include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/qc.smk"
include:
    include_prefix + "/trimming.smk"
include:
    include_prefix + "/discovering.smk"