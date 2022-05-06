#! /bin/bash
#SBATCH --partition=master
#SBATCH --job-name=convert
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=22400
#SBATCH --time=1000:00:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

source ~/.bashrc

OUTPUT_PATH="./"
CONTAINER_PATH="./"
PREFIX="ms_"

CH='6144:6400'
SOL_INT="5min"
REF_ANT="E01"


singularity exec ${CONTAINER_PATH}/casa.simg casa --nogui --logfile ${OUTPUT_PATH}/a.log -c ./selfcal.py ${OUTPUT_PATH}/${PREFIX}${CH} ${SOL_INT} ${REF_ANT}
