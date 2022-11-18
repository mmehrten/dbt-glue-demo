set -e
rm -r hudi-jars
mkdir hudi-jars
cd hudi-jars

wget https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.9/httpclient-4.5.9.jar
wget https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.11/httpcore-4.4.11.jar
wget https://repo1.maven.org/maven2/org/apache/hudi/hudi-utilities-bundle_2.12/0.12.1/hudi-utilities-bundle_2.12-0.12.1.jar
wget https://repo1.maven.org/maven2/org/apache/hudi/hudi-spark3.1-bundle_2.12/0.12.1/hudi-spark3.1-bundle_2.12-0.12.1.jar
wget https://repo1.maven.org/maven2/org/apache/calcite/calcite-core/1.32.0/calcite-core-1.32.0.jar
wget https://repo1.maven.org/maven2/org/apache/spark/spark-avro_2.12/3.2.2/spark-avro_2.12-3.2.2.jar

aws s3 cp . s3://govglue.us-gov-west-1.s3.glue-infra/hudi/ --recursive --region us-gov-west-1
