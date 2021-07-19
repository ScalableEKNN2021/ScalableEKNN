#!/bin/sh

#SBATCH -J my_spark_job           # Job name
#SBATCH -o logs/spark.o%j       # Name of stdout output file
#SBATCH -e logs/spark.e%j       # Name of stderr error file
#SBATCH -p development             # Queue (partition) name
#SBATCH -N 21               # Total # of nodes (must be 1 for serial)
#SBATCH --ntasks-per-node 1
#SBATCH -t 01:00:00        # Run time (hh:mm:ss)

pwd
date

# load spark on your env

# deploy of spark
$SPARK_HOME/sbin/start-all.sh

# submit a Spark job
$SPARK_HOME/bin/spark-submit --master $SPARKURL \
		--class org.apache.spark.run.SPARK_EKNN_GLOBAL your_path/GEKNN.jar \
		"your_path/dataset_header.header" \
		"your_path/Higgs_train.txt" \
		"your_path/Higgs_test.txt" \
		"3" \
		"1120" \
		"1" \
		"5" \
		"2" \
		"28" ;

# clean out Spark deployment
$SPARK_HOME/sbin/stop-all.sh

date

