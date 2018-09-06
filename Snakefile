##### local rules #####

localrules: all, rename_trimmed_fastq, pre_mirdeep2_identification

rule all:
    input:
        expand("qc/untrimmed_{sample}.html", sample=config.get('samples')),
        expand("qc/trimmed_{sample}.html", sample=config.get('samples')),
        expand("qc/trimmed_{sample}.fastq_screen.txt", sample=config.get('samples')),
        "qc/multiqc.html",
        expand("discovering/{sample}/{sample}_result.html", sample=config.get('samples')),
        expand("discovering/{sample}/{sample}_result.csv", sample=config.get('samples')),
        expand("discovering/{sample}/{sample}_survey.csv", sample=config.get('samples')),
        expand("discovering/{sample}/{sample}_output.mrd", sample=config.get('samples'))


include_prefix="rules"

include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/qc.smk"
include:
    include_prefix + "/trimming.smk"
include:
    include_prefix + "/discovering.smk"