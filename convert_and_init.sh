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
DATA_PATH="./"
CONTAINER_PATH="./"
INPUT_PATH='/data/21cma/disk1/'

PREFIX="ms_"
DATE="20130717"
CH='6144:6400'
INIT_MODEL="components.cl"
SOL_INT="5min"
REF_ANT="E01"


singularity exec -B ${INPUT_PATH} ${CONTAINER_PATH}/casa.simg /usr/local/bin/raw2ms_splited ${DATA_PATH}/ANTENNA/ ${OUTPUT_PATH}/${PREFIX} ${DATE} ${INPUT_PATH} ${CH}

singularity exec ${CONTAINER_PATH}/casa.simg casa --nogui --logfile ${OUTPUT_PATH}/a.log -c ./init_process_cmd.py ${OUTPUT_PATH}/${PREFIX}${CH} ${DATA_PATH}/${INIT_MODEL} ${SOL_INT} ${REF_ANT}

#singularity exec ../casa.simg casa --nogui --logfile ./a.log -c ./selfcal.py ${PREFIX}${CH} ${SOL_INT} ${REF_ANT}
