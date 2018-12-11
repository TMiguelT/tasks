version 1.0

import "common.wdl"

task Bamtobed {
    input {
        String? preCommand
        File inputBam
        String bedPath
        Boolean bedpe = false
        Boolean mate1 = false
        Int threads = 1
        Int memory = 4
    }

    command {
        set -e -o pipefail
        ~{preCommand}
        bedtools bamtobed \
        ~{true="-bedpe" false="" bedpe} \
        ~{true="-mate1" false="" mate1} \
        -i ~{inputBam} | \
        gzip -nc > ~{bedPath}
    }

    output {
        File outputBed = bedPath
    }

    runtime {
        cpu: threads
        memory: memory
        docker: "quay.io/biocontainers/bedtools:2.27.0--1"
    }
}