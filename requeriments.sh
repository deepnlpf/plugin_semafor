#!/bin/sh
packagesNeeded='maven'
# Install SEMAFOR
wget https://github.com/Noahs-ARK/semafor/archive/master.zip && \
unzip master.zip && \
rm -r master.zip && \
mv -f semafor-master resources && mkdir -p temp && \
# Config SEMAFOR
cd resources/bin && \
rm -r config.sh && \
echo "Enter the path to your java bin." && \
echo 'Path example: "/usr/lib/jvm/java-8-openjdk-amd64/bin"' && \
read path && \
echo '#!/bin/sh \n\n' >> config.sh && \
echo 'export BASE_DIR="/home/$USER/deepnlpf_data/plugins"' >> config.sh && \
echo 'export SEMAFOR_HOME="${BASE_DIR}/semafor/resources"' >> config.sh && \
echo 'export CLASSPATH=".:${SEMAFOR_HOME}/target/Semafor-3.0-alpha-04.jar"' >> config.sh && \
echo "export JAVA_HOME_BIN=$path" >> config.sh && \
echo 'export MALT_MODEL_DIR="${BASE_DIR}/semafor/resources/models/semafor_malt_model_20121129"' >> config.sh && \
echo 'export TURBO_MODEL_DIR="{BASE_DIR}/semafor/resources/models/turbo_20130606" \n\n' >> config.sh && \
echo 'echo "Environment variables:"' >> config.sh && \
echo 'echo "SEMAFOR_HOME=${SEMAFOR_HOME}"' >> config.sh && \
echo 'echo "CLASSPATH=${CLASSPATH}"' >> config.sh && \
echo 'echo "JAVA_HOME_BIN=${JAVA_HOME_BIN}"' >> config.sh && \
echo 'echo "MALT_MODEL_DIR=${MALT_MODEL_DIR}"' >> config.sh && \
echo 'Download Models..' && \
# to path: /home/you_user/deepnlpf_data/plugin/semafor
cd .. && mkdir -p models && cd models && \
# to path: /home/you_user/deepnlpf_data/plugin/semafor/models
wget http://www.ark.cs.cmu.edu/SEMAFOR/semafor_malt_model_20121129.tar.gz && \
tar -vzxf semafor_malt_model_20121129.tar.gz && \
rm -r semafor_malt_model_20121129.tar.gz && \
echo 'Install Maven..' && \
if [ ! -x "$(command -v mvn)" ]; then
if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
elif [ -x "$(command -v pacman)" ];  then sudo pacman -Syu $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi;
else echo maven found $(which mvn); fi && \
cd .. && \
echo 'Compile SEMAFOR..' && \
mvn package
