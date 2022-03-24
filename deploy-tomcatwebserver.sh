#!/bin/bash

    #Author : Yaovi
    #Date : 03/24/22

## ---------- Deploy War File to Tomcat Webserver running as Docker Container by Jenkins  -----------------

rm -rf dockerimages
mkdir dockerimages
cd dockerimages
cp /usr/lib/jenkins/workspace/PackageJob/gameoflife-web/target/gameoflife.war .
touch dockerfile
cat <<EOT>> dockerfile
FROM tomcat
ADD gameoflife.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
EXPOSE 8080
EOT
sudo docker build -t  dodzi2022/tomcatwebserver:1.0 .
sudo docker push dodzi2022/tomcatwebserver:1.0 
sudo docker run -itd --name tomcatwebserver -p 8888:8080 dodzi2022/tomcatwebserver:1.0
