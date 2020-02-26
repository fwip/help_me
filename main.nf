nextflow.preview.dsl=2

include { align } from './modules/align'


workflow {

    // Channel reading fq from fq_dir
    fq_pattern = '*.{1,2}.fq.gz'
    Channel
        .fromFilePairs("${reads_in}/${fq_pattern}")
        .ifEmpty { error "Cannot find any reads in ${reads_in}" }.dump( tag: 'reads_in')
        .set { input_fastqs }

    // All combinations of callers and aligners invoking align process
    aligners = aligners_callers_dic.collect { aligner, callers -> aligner }

    input_fastqs.combine(aligners) \
    | multiMap { val, files, aligner ->
      fastqs: [val, files]
      aligner: aligner
    } \
    | set { combined }

    align( combined.fastqs, combined.aligner )
}
