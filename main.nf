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
    aligners_callers_dic.each {  aligner, callers ->
        
        align( input_fastqs, aligner)

    }
}
