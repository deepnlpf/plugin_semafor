# Install SEMAFOR
wget https://github.com/Noahs-ARK/semafor/archive/master.zip && \
unzip master.zip && \
rm -r master.zip && \
mv semafor-master resources && mkdir temp && \
# Config SEMAFOR
cd resources/bin && \
rm -r config.sh && \
echo "Enter the path to your java bin." \
read -p "Example:/usr/lib/jvm/java-8-openjdk-amd64/bin:" $java_home_bin \
echo -e '#!/bin/sh \n
\nexport USER=$USERNAME \n
\nexport BASE_DIR="/home/${USER}/deepnlpf_data/plugins" \n
\nexport SEMAFOR_HOME="${BASE_DIR}/semafor/resources" \n
\nexport CLASSPATH=".:${SEMAFOR_HOME}/target/Semafor-3.0-alpha-04.jar" \n
\nexport JAVA_HOME_BIN=$java_home_bin \n
\nexport MALT_MODEL_DIR="${BASE_DIR}/semafor/resources/models/semafor_malt_model_20121129" \n
\nexport TURBO_MODEL_DIR="{BASE_DIR}/semafor/resources/models/turbo_20130606" \n
\n\n echo "Environment variables:" \n
\n echo "SEMAFOR_HOME=${SEMAFOR_HOME}" \n
\n echo "CLASSPATH=${CLASSPATH}" \n
\n echo "JAVA_HOME_BIN=${JAVA_HOME_BIN}" \n
\n echo "MALT_MODEL_DIR=${MALT_MODEL_DIR}" \n
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
