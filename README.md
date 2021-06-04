# Scalable Evidential K-nearest Neighbor Classifier for Big Data

Two scalable EK-NN classifier: Local approxiamate EK-NN and Global exact EK-NN.
We ran two scalable version of evidential K nearest neighbor (EK-NN) algorithms, respectively named as Local approximate EK-NN (LEK-NN) and Global exact EK-NN (GEK-NN), that is scaled up under Apache Spark. Our codes are written in Scala 2.11.8 and our experiments are carried on a single server and a supercomputer cluster. 

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

Then, LEK-NN and GEK-NN are run on a supercomputer cluster named Piz Daint from the Swiss National Supercomputing Centre. We use Cray XC50 compute nodes on Piz Daint and the nodes are connected by a high-bandwidth network. The CPU specifications of each node are Intel Xeon E5 2690 v3 @ 2.60GHz 12 cores 64GB RAM. 

## Requirements

For a single server, please install jdk-8u221-windows-x64, scala-2.11.8, hadoop-2.7.7, spark-2.4.3-bin-hadoop2.7, IDEAIC-2019.2.3 and configure the corresponding environment variables.

For a cluster, please use Spark. Version 2.4.3/2.4.7-CrayGNU-20.11-Hadoop-2.7.

## Usage

**LEK-NN and GEK-NN are run on a single server**

After unzipping the files named ``LEKNN/GEKNN.zip``, you can open the file named LEKNN/GEKNN.scala at `` \src\main\scala\run`` in the IDEA ideaIC-2019.2.3 Compiler. The parameters to be set are, 

```
val pathTrain = The path of training data
val pathTest = The path of testing data
val pathHeader = The path of header file
val pathOutput = The output path
val K = The value of K
val distanceType = 2 (default value, denoting the Euclidean distance)
val numPartition = The number of the data splits (referring to hyper-parameter U in our paper)
val numClasses= The number of classes in the dataset
val numFeatures= The number of dimensions in the dataset
val numIterations = 1 (default value)
var maxWeight = 10.0 (default value)
val numReduces = 1 (default value)
```

For example, we upload a dataset named ``page-blocks`` in the ``dataset`` file folder, including the training data, testing data and header files. After running the code, you can find the result in ``Report_result/part-00000`` at the output path. For more big datasets, you can download them from the http://archive.ics.uci.edu/ml/index.php.

**LEK-NN and GEK-NN are run on a supercomputer cluster**

We package our code into LEKNN/GEKNN.jar files, please use the corresponding LEKNN/GEKNN.slurm files to run them.  The parameters to be set are, 

```
--class org.apache.spark.run.SPARKEKNN /file_path/LEK-NN.jar Determine the jar file to be run;
"/file_path/dataset_header.header" is the path to header;
"/file_path/training_set.txt" is the path to train set;
"/file_path/testing_set.txt" is the path to test set;
"3" is the value of K (corresponding to K=3);
"1440" is the number of partitions, where we use 120 nodes and each node has 12 cores;
"1" is the number of reduce workers and we always set it to 1;
"1" is the number of segments of test set and we always set it to 1;
"2" is the number of class labels in the dataset;
"18" is the number of dimensions of the dataset.
```

The accuracy and running time are printed out after the execution of the program.