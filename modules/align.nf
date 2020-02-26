process align {
    label 'align'

    echo true
    scratch true

    input:
    set val(genome_id), file (fastqs)
    val aligner

    script:
    """
    echo "${genome_id}"
    echo "${aligner}"
    """
}
