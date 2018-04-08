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

rule fastq_screen:
    input:
        "trimmed/{sample}-trimmed.fq"
    output:
        txt="qc/trimmed_{sample}.fastq_screen.txt",
        png="qc/trimmed_{sample}.fastq_screen.png"
    params:
        fastq_screen_config=fastq_screen.config,
        subset=100000,
        aligner='bowtie2'
    threads: pipeline_cpu_count()
    wrapper:
        "0.23.1/bio/fastq_screen"

rule multiqc:
    input:
        expand("qc/trimmed_{sample}_fastqc.zip", sample=config.get('samples')),
        expand("qc/trimmed_{sample}.fastq_screen.txt", sample=config.get('samples')),
        expand("qc/untrimmed_{sample}_fastqc.zip", sample=config.get('samples'))
    output:
        "qc/multiqc.html"
    params:
        ""  # Optional: extra parameters for multiqc.
    log:
        "logs/multiqc/multiqc.log"
    wrapper:
        "0.22.0/bio/multiqc"
