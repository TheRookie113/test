#Install Java
sudo amazon-linux-extras install java-openjdk11

#Install Maven
cd ~
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
tar -xvzf apache-maven-3.8.6-bin.tar.gz
mv apache-maven-3.8.6 maven

#Setup environment variables
cd ~

sed -i '9 i M2_HOME=/opt/maven' /home/ec2-user/.bash_profile
sed -i '10 i M2=/opt/maven/bin' /home/ec2-user/.bash_profile
sed -i '11 i JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-1.amzn2.0.3.x86_64' /home/ec2-user/.bash_profile
sed -i '12d' /home/ec2-user/.bash_profile
sed -i '12 i PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2' /home/ec2-user/.bash_profile
echo $PATH
source .bash_profile
echo $PATH
mvn -v

#Install Tomcat (Web Server) 
cd ~
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
tar -xvzf apache-tomcat-9.0.65.tar.gz
mv apache-tomcat-9.0.65 tomcat

# Create symbolic links to start and stop Tomcat
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

# Editing host-manager and manager context.xml files
sed -i '21 s/^/<!--/' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '22 s/$/-->/' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '21 s/^/<!--/' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '22 s/$/-->/' /opt/tomcat/webapps/host-manager/META-INF/context.xml

tomcatup

sed -i 's/<\/tomcat-users>/<role rolename="manager-gui"\/><role rolename="manager-script"\/><role rolename="manager-jmx"\/><role rolename="manager-status"\/><user username="admin" password="s3cret" roles="admin-gui,manager-gui, manager-script, manager-jmx, manager-status"/><\/tomcat-users>/g' /opt/tomcat/conf/tomcat-users.xml                          

tomcatdown
tomcatup
echo "Install complete"
tomcatdown
echo "Rebooting Tomcat"
tomcatup