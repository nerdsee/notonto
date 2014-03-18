#!/bin/bash

export JAVA=/opt/jdk1.6/bin/java

export CP=/opt/statusmail/mail.jar
export CP=$CP:/opt/statusmail/log4j-1.2.14.jar
export CP=$CP:/opt/statusmail/notontoMailer.jar
export CP=$CP:/opt/statusmail/mysql-connector-java-5.0.5-bin.jar

export DB_OPTS="-Ddb_user=notonto -Ddb_pass=notonto!21 -Ddb_server=notonto"

$JAVA -cp $CP $DB_OPTS -Dlog4j.configuration=file:/opt/brain/log4j.mailer.properties -Dfivetoknow.dir=/opt/brain org.stoevesand.brain.newsletter.NewsletterMailer
 