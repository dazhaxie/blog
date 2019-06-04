# Pull base image  
FROM ubuntu:14.04
 
 
RUN mkdir -p /usr/lib/jvm
COPY ./jdk1.8.0_211/ /usr/lib/jvm/java8/

  
# Set Oracle JDK 8 as default Java  
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java8/bin/java 300     
RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java8/bin/javac 300     
  
ENV JAVA_HOME /usr/lib/jvm/java8  
  
# Install tomcat8.5  
RUN mkdir -p /opt/tomcat8
COPY ./apache-tomcat-8.5.39/ /opt/tomcat8/ 
  
ENV CATALINA_HOME /opt/tomcat8  
ENV PATH $PATH:$CATALINA_HOME/bin  
  
ADD tomcat8.sh /etc/init.d/tomcat8 
RUN chmod 755 /etc/init.d/tomcat8 
  
# Expose ports.  
EXPOSE 8080  
  
# Define default command.  
ENTRYPOINT service tomcat8 start && tail -f /opt/tomcat8/logs/catalina.out
