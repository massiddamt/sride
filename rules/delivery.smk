def get_sample_by_client(wildcards, reheader, label='LIMS', structure="folder/{sample}.extension"):
    re.sub(r"{sample}",reheader.loc[wildcards.Client,[label]][0], structure)
    return re.sub(r"{sample}",reheader.loc[wildcards.Client,[label]][0], structure)

rule delivery_multiqc:
    input:
        "qc/multiqc.html"
    output:
        "delivery/qc/multiqc.html"
    shell:
        "cp {input} {output}"


rule delivery_htseq:
    input:
        lambda wildcards: get_sample_by_client(wildcards, reheader, label=config.get("internal_sid"), structure='htseq/{sample}.counts')
    output:
        "delivery/htseq/{Client}_HTSeqcounts.cnt"
    shell:
        "cp {input} {output}"


