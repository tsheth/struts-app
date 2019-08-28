FROM tomcat:7-alpine
RUN apk add go 
RUN apk add --no-cache --update vim zip curl
#RUN apt-get install curl
COPY src /application
COPY lib-apk-db-installed /lib/apk/db/installed

RUN  rm -rf /usr/local/tomcat/webapps/* \
    && cd /application \
    # && mkdir showcase \
    # && unzip struts2-showcase-2.3.12.war -d showcase \
    #&& sed -i "80i\ \n\t<action name=\"chain\">\n\t\t<result type=\"chain\">date</result>\n\t</action>" /application/WEB-INF/classes/struts.xml \
    && cd /application \
    && zip -r /ROOT.war ./ \
    && chmod a+x /usr/local/tomcat/bin/*.sh \
    && mv /ROOT.war /usr/local/tomcat/webapps/ 
ADD https://secure.eicar.org/eicar.com /eicar.com
EXPOSE 8080