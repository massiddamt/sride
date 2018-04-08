rule trim_galore_se:
    input:
        lambda wildcards: config["samples"][wildcards.sample]
    output:
        "trimmed/{sample}_trimmed.fq",
        "trimmed/{sample}.fastq.gz_trimming_report.txt"
    params:
        extra=config.get("rules").get("trim_galore_se").get("params" )
    log:
        "logs/trim_galore/{sample}.log"
    wrapper:
        "0.23.1/bio/trim_galore/se"

rule rename_trimmed_fastq:
    input:
        "trimmed/{sample}_trimmed.fq"
    output:
        "trimmed/{sample}-trimmed.fq"
    shell:
        "mv {input} {output} "