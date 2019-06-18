rule bowtie_mapping:
    input:
        sample="reads/trimmed/{sample}-trimmed.fq",
        index_ready="bowtie_index_ready",
        fa=resolve_single_filepath(*references_abs_path(ref='references'), config.get("genome_fasta"))
    output:
        bam="reads/aligned/{sample}.bam"
    params:
         params=config.get("rules").get("bowtie_mapping").get("params"),
         basename="ucsc_hg19"
    threads: pipeline_cpu_count()
    conda:
        "../envs/bowtie.yaml"
    shell:
        "bowtie "
        "{params.params} "
        "{params.basename} "
        "{input.sample} "
        "--sam "
        "| samtools view "
        "-bT "
        "{input.fa} - "
        "| samtools sort - "
        "-o {output.bam}"

rule index:
    input:
        "reads/aligned/{sample}.bam"
    output:
        "reads/aligned/{sample}.bam.bai"
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools index "
        "{input}"

rule umi_dedup:
    input:
       bam="reads/aligned/{sample}.bam",
       bai="reads/aligned/{sample}.bam.bai"
    output:
        "reads/dedup/{sample}.bam"
    conda:
        "../envs/umi_tools.yaml"
    shell:
        "umi_tools dedup "
        "-I {input.bam} "
        "-S {output} "
        "--method=unique"

rule htseq:
    input:
        bam="reads/dedup/{sample}.bam",
        gff=config.get("htseq_gff")
    output:
        counts="htseq/{sample}.counts"
    conda:
        "../envs/htseq.yaml"
    shell:
        "htseq-count "
        "-f bam "
        "-r pos "
        "-t miRNA "
        "-i Name "
        "-q {input.bam} "
        "{input.gff} "
        ">{output.counts}"


