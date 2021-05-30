# Scalable Evidential K-nearest Neighbor Classifier for Big Data

Two scalable EK-NN classifier: Local approxiamate EK-NN and Global exact EK-NN.
We ran two scalable version of evidential K nearest neighbor (EK-NN) algorithms, respectively named as Local approximate EK-NN (LEK-NN) and Global exact EK-NN (GEK-NN), that is scaled up under Apache Spark.

## Experimental Environment 

Firstly, LEK-NN and GEK-NN are run on a single server with,  

```
Processer: Intel(R) Xeon(R) Gold 6230 CPU @ 2.10GHz;
Cores: 160 cores; 
RAM: 256GB;
Operative System: Windows Server 2016;
Apache Spark version: 2.4.3;
Scala version: 2.11.8.
```

Then, LEK-NN and GEK-NN are run on a supercomputer cluster named Piz Daint from the Swiss National Supercomputing Centre. We use Cray XC50 compute nodes on Piz Daint and the nodes are connected by a high-bandwidth network. The CPU specifications of each node are Intel Xeon E5 2690 v3 @ 2.60GHz 12 cores 64GB RAM. The Spark version is Spark/2.4.7-CrayGNU-20.11-Hadoop-2.7.

## Requirements

```
Scala. Version 2.11.8
Spark. Version 2.4.3/2.4.7-CrayGNU-20.11-Hadoop-2.7
JVM. Java Virtual Machine. Version 1.8.0 because Scala run over it.
```

## Usage

We package our code into two .jar files, please use the corresponding .slurm files to run them. 

We provide some explanation about commands in the following slurm example:

```
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
spark-submit ${SPARK_CONF} --master $SPARKURL --class org.apache.spark.run.SPARKEKNN /file_path/LEK-NN.jar \
		"/file_path/dataset_header.header" \
		"/file_path/training_set.txt" \
		"/file_path/testing_set.txt" \
		"3" \
		"1440" \
		"1" \
		"1" \
		"2" \
		"18" ;

# clean out Spark deployment
stop-all.sh

--class org.apache.spark.run.SPARKEKNN /file_path/LEK-NN.jar Determine the jar file to be run;

"/file_path/dataset_header.header"  is the path to header ;

"/file_path/training_set.txt"  is the path to train set;

"/file_path/testing_set.txt"  is the path to test set;

"3"  is the value of K (corresponding to K=3);

"1440"  is the number of partitions, where we use 120 nodes and each node has 12 cores;

"1"  is the number of reduce workers and we always set it to 1;

"1"  is the number of segments of test set and we always set it to 1;

"2"  is the number of class labels in the dataset;

"18" is the number of dimensions of the dataset.

The accuracy and running time is printed out after the execution of program.
```
