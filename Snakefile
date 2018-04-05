rule all:
    input:
        expand("qc/untrimmed_{sample}.html", sample=config.get('samples')),
        expand("qc/trimmed_{sample}.html", sample=config.get('samples')),
        "qc/multiqc.html",
        expand("discovering/mirdeep2.{sample}.end", sample=config.get('samples'))


include_prefix="rules"

include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/notify.smk"
include:
    include_prefix + "/qc.smk"
include:
    include_prefix + "/trimming.smk"
include:
    include_prefix + "/discovering.smk"