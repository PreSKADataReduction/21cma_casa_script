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

PREFIX=./ms_
DATE=20130717
CH='6144:6400'
INPUT_PATH='/data/21cma/disk1/'
INIT_MODEL="components.cl"
SOL_INT="5min"
REF_ANT="E01"


singularity exec -B ${INPUT_PATH} ../casa.simg /usr/local/bin/raw2ms_splited ./ANTENNA/ ${PREFIX} ${DATE} ${INPUT_PATH} ${CH}

singularity exec ../casa.simg casa --nogui --logfile ./a.log -c ./init_process_cmd.py ${PREFIX}${CH} ${INIT_MODEL} ${SOL_INT} ${REF_ANT}

#singularity exec ../casa.simg casa --nogui --logfile ./a.log -c ./selfcal.py ${PREFIX}${CH} ${SOL_INT} ${REF_ANT}
