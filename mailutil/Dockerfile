FROM debian
RUN apt update -y && apt install ssmtp -y && apt install mailutils -y
RUN rm /usr/sbin/sendmail
RUN ln -s /usr/sbin/ssmtp /usr/sbin/sendmail
COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY revaliases /etc/ssmtp/revaliases