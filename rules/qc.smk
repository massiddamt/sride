rule fastqc:
    input:
       lambda wildcards: config["samples"][wildcards.sample]
    output:
        html="qc/untrimmed_{sample}.html",
        zip="qc/untrimmed_{sample}_fastqc.zip"
    params: ""
    wrapper:
        "0.22.0/bio/fastqc"

rule fastqc_trimmed:
    input:
       "trimmed/{sample}-trimmed.fq"
    output:
        html="qc/trimmed_{sample}.html",
        zip="qc/trimmed_{sample}_fastqc.zip"
    params: ""
    wrapper:
        "0.22.0/bio/fastqc"

rule multiqc:
    input:
        expand("qc/trimmed_{sample}_fastqc.zip", sample=config.get('samples')),
        expand("qc/untrimmed_{sample}_fastqc.zip", sample=config.get(
            'samples'))
    output:
        "qc/multiqc.html"
    params:
        ""  # Optional: extra parameters for multiqc.
    log:
        "logs/multiqc/multiqc.log"
    wrapper:
        "0.22.0/bio/multiqc"