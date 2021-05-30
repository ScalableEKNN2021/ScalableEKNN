#!/bin/bash

#SBATCH --job-name="spark"
#SBATCH --time=00:45:00
#SBATCH --nodes=120
#SBATCH --constraint=gpu
#SBATCH --output=sparkjob.%j.log
#SBATCH --account=xxx

# set some variables for Spark
export SPARK_WORKER_CORES=12
export SPARK_LOCAL_DIRS="/tmp"

# load modules
module load slurm
module load daint-gpu
module load Spark

# deploy of spark
start-all.sh

# some extra Spark configuration
SPARK_CONF="
--conf spark.default.parallelism=10
--conf spark.executor.cores=8
--conf spark.executor.memory=15g
"

# submit a Spark job
spark-submit ${SPARK_CONF} --master $SPARKURL --class org.apache.spark.run.SPARKEKNN /file_path/GEK-NN.jar \
		"/file_path/dataset.header" \
		"/file_path/training_set.txt" \
		"/file_path/testing_set.txt" \
		"3" \
		"1440" \
		"1" \
		"5" \
		"2" \
		"18" ;

# clean out Spark deployment
stop-all.sh