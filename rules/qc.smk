rule fastqc:
    input:
       lambda wildcards: config["samples"][wildcards.sample]
    output:
        html="qc/untrimmed_{sample}.html",
        zip="qc/untrimmed_{sample}_fastqc.zip"
    params: ""
    wrapper:
        "0.23.1/bio/fastqc"

rule fastqc_trimmed:
    input:
       "trimmed/{sample}-trimmed.fq"
    output:
        html="qc/trimmed_{sample}.html",
        zip="qc/trimmed_{sample}_fastqc.zip"
    params: ""
    wrapper:
        "0.23.1/bio/fastqc"

rule fastq_screen:
    input:
        "trimmed/{sample}-trimmed.fq"
    output:
        png="qc/trimmed_{sample}.fastq_screen.png",
        txt="qc/trimmed_{sample}.fastq_screen.txt",
        html="qc/trimmed_{sample}.fastq_screen.html"
    conda:
        "envs/fastq_screen.yaml"
    params:
        fastq_screen_config="../data/fastq_screen.config",
        subset=100000,
        aligner='bowtie2'
    threads: pipeline_cpu_count()
    shell:
        "fastq_screen  "
        "--force "
        "--aligner {params.aligner} "
        "--conf {params.fastq_screen_config} "
        "--subset {params.subset} "
        "--threads {threads} "
        "{input[0]} "
        "&& find ./ -name *_screen.txt -type f -print0 | xargs -0 -I file mv " \
        "file {output.txt} "
        "&& find ./ -name *_screen.png -type f -print0 | xargs -0 -I file mv " \
        "file {output.png} "
        "&& find ./ -name *_screen.html -type f -print0 | xargs -0 -I file mv " \
        "file {output.html} "

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
        "0.23.1/bio/multiqc"
