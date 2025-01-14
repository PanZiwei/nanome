#!/bin/bash -e
#SBATCH --job-name=nanome.google.demo
#SBATCH -p compute
#SBATCH -q batch
#SBATCH -N 1 # number of nodes
#SBATCH -n 2 # number of cores
#SBATCH --mem=6G # memory pool for all cores
#SBATCH --time=3-00:00:00 # time
#SBATCH --output=log/%x.%j.log # STDOUT & STDERR
#SBATCH --mail-user=yang.liu@jax.org
#SBATCH --mail-type=END

set -ex
date;hostname;pwd

###########################################
###########################################
###########################################
### Run Test pipeline on google cloud
## working and outputs dir
WORK_DIR_BUCKET=${1:-"gs://jax-nanopore-01-project-data/NANOME-TestData-work"}
OUTPUT_DIR_BUCKET=${2:-"gs://jax-nanopore-01-export-bucket/NANOME-TestData-ouputs"}

gsutil -m rm -rf ${WORK_DIR_BUCKET}  ${OUTPUT_DIR_BUCKET} >/dev/null 2>&1 || true

## Run test demo on google cloud
echo "### nanome pipeline for demo data on google START"
nextflow run main.nf\
    -profile docker,google \
    -config conf/executors/gcp_input.config\
	-w ${WORK_DIR_BUCKET} \
	--outputDir ${OUTPUT_DIR_BUCKET} \
	--dsname TestData \
	--input https://raw.githubusercontent.com/TheJacksonLaboratory/nanome/master/inputs/test.demo.filelist.txt

echo "### nanome pipeline for demo data on google DONE"

exit 0
###########################################
###########################################
###########################################
### Run Test pipeline on google 12878
## working and outputs dir
WORK_DIR_BUCKET=${1:-"gs://jax-nanopore-01-project-data/NANOME-na12878_chr17_p6-work"}
OUTPUT_DIR_BUCKET=${2:-"gs://jax-nanopore-01-export-bucket/NANOME-na12878_chr17_p6-ouputs"}

gsutil -m rm -rf ${WORK_DIR_BUCKET}  ${OUTPUT_DIR_BUCKET} >/dev/null 2>&1 || true

## Run test demo on google cloud
echo "### nanome pipeline for NA12878 some chr and part file on google START"
nextflow run main.nf\
    -profile docker,google -resume\
    -config conf/executors/gcp_input.config\
	-w ${WORK_DIR_BUCKET} \
	--outputDir ${OUTPUT_DIR_BUCKET} \
	--dsname na12878_chr17_p6 \
	--input 'http://s3.amazonaws.com/nanopore-human-wgs/rel3-fast5-chr17.part06.tar'\
	--cleanAnalyses true\
	--tomboResquiggleOptions '--signal-length-range 0 500000  --sequence-length-range 0 50000'

echo "### nanome pipeline for NA12878 some chr and part file on google DONE"
exit 0