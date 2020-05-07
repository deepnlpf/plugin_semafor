#!/bin/sh
# Install SEMAFOR
wget https://github.com/Noahs-ARK/semafor/archive/master.zip && \
unzip master.zip && \
rm -r master.zip && \
mv semafor-master resources && mkdir temp && \
# Config SEMAFOR
cd resources/bin && \
rm -r config.sh && \
echo "Enter the path to your java bin." && \
echo 'Path example: "/usr/lib/jvm/java-8-openjdk-amd64/bin"' && \
read path && \
echo '#!/bin/sh \n\n' >> config.sh && \
echo 'export USER=$USERNAME \n' >> config.sh && \
echo 'export BASE_DIR="/home/${USER}/deepnlpf_data/plugins" \n' >> config.sh && \
echo 'export SEMAFOR_HOME="${BASE_DIR}/semafor/resources" \n' >> config.sh && \
echo 'export CLASSPATH=".:${SEMAFOR_HOME}/target/Semafor-3.0-alpha-04.jar" \n' >> config.sh && \
echo "export JAVA_HOME_BIN=$path \n" >> config.sh && \
echo 'export MALT_MODEL_DIR="${BASE_DIR}/semafor/resources/models/semafor_malt_model_20121129" \n' >> config.sh && \
echo 'export TURBO_MODEL_DIR="{BASE_DIR}/semafor/resources/models/turbo_20130606" \n\n' >> config.sh && \
echo '"Environment variables:" \n\n' >> config.sh && \
echo '"SEMAFOR_HOME=${SEMAFOR_HOME}" \n\n' >> config.sh && \
echo '"CLASSPATH=${CLASSPATH}" \n\n' >> config.sh && \
echo '"JAVA_HOME_BIN=${JAVA_HOME_BIN}" \n\n' >> config.sh && \
echo '"MALT_MODEL_DIR=${MALT_MODEL_DIR}"' >> config.sh && \
echo 'Download Models..' && \
# to path: /home/you_user/deepnlpf_data/plugin/semafor
cd .. && mkdir -p models && cd models && \
# to path: /home/you_user/deepnlpf_data/plugin/semafor/models
wget http://www.ark.cs.cmu.edu/SEMAFOR/semafor_malt_model_20121129.tar.gz && \
tar -vzxf semafor_malt_model_20121129.tar.gz && \
rm -r semafor_malt_model_20121129.tar.gz && \
echo 'Install Maven..' && \
sudo apt install maven -y && \
cd .. && \
echo 'Compile SEMAFOR..' && \
mvn package
