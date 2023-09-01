FROM tomcat:9-jdk11-openjdk
ENV TZ=Asia/Seoul
RUN rm -Rf /usr/local/tomcat/webapps/ROOT
COPY Wallet_QQ136J9CXADGAP81 /home/Wallet_QQ136J9CXADGAP81
COPY ./target/*.war /usr/local/tomcat/webapps/ROOT.war