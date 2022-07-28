sudo amazon-linux-extras install java-openjdk11
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
tar -xvzf apache-maven-3.8.6-bin.tar.gz
mv apache-maven-3.8.6 maven
./maven/bin/mvn -v
cd ~
sed -i '$d' .bash_profile
sed -i '$d' .bash_profile
sed -i '$d' .bash_profile
echo M2_HOME=/opt/maven >> .bash_profile
echo M2=/opt/maven/bin >> .bash_profile
echo JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-1.amzn2.0.3.x86_64 >> .bash_profile
echo PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2 >> .bash_profile
echo export PATH >> .bash_profile
source .bash_profile
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
tar -xvzf apache-tomcat-9.0.65.tar.gz
mv apache-tomcat-9.0.65 tomcat
cd tomcat/bin
./startup.sh
sed -i '21 s/^/<!--/' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '22 s/$/-->/' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '21 s/^/<!--/' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '22 s/$/-->/' /opt/tomcat/webapps/manager/META-INF/context.xml
./startup.sh
./shutdown.sh