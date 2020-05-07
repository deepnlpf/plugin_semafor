# Install SEMAFOR
wget https://github.com/Noahs-ARK/semafor/archive/master.zip && \
unzip master.zip && \
rm -r master.zip && \
mv semafor-master resources && mkdir temp && \
# Config SEMAFOR
cd semafor/bin && \
rm -r config.sh && \
echo "Enter the path to your java bin." \
read -p "Example:/usr/lib/jvm/java-8-openjdk-amd64/bin:" java_home_bin \
echo -e '#!/bin/sh \
\n export USER=$USERNAME \
\n export BASE_DIR="/home/${USER}/deepnlpf_data/plugins" \
\n export SEMAFOR_HOME="${BASE_DIR}/semafor" \
\n export CLASSPATH=".:${SEMAFOR_HOME}/target/Semafor-3.0-alpha-04.jar" \
\n export JAVA_HOME_BIN=$java_home_bin \
\n export MALT_MODEL_DIR="${BASE_DIR}/semafor/models/semafor_malt_model_20121129" \
\n export TURBO_MODEL_DIR="{BASE_DIR}/semafor/models/turbo_20130606" \
\n\n echo "Environment variables:" \
\n echo "SEMAFOR_HOME=${SEMAFOR_HOME}" \
\n echo "CLASSPATH=${CLASSPATH}" \
\n echo "JAVA_HOME_BIN=${JAVA_HOME_BIN}" \
\n echo "MALT_MODEL_DIR=${MALT_MODEL_DIR}" \
'>> config.sh && \
echo 'Download Models..' \ 
# to path: /home/you_user/deepnlpf_data/plugin/semafor
mkdir -p models && \
cd models && \
# to path: /home/you_user/deepnlpf_data/plugin/semafor/models
wget http://www.ark.cs.cmu.edu/SEMAFOR/semafor_malt_model_20121129.tar.gz && \
tar -vzxf semafor_malt_model_20121129.tar.gz && \
rm -r semafor_malt_model_20121129.tar.gz && \
echo 'Install Maven..' \
apt-get install maven -y
cd .. && \
echo 'Compile SEMAFOR..' \
mvn package
