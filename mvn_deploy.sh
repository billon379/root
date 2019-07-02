#!/usr/bin/env bash
#author billon
#读取pom中的module,发布项目到nexus

#读取pom中的<module>.*</module>,遍历module执行mvn deploy.
for var in `grep "<module>.*</module>" pom.xml | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
do
  echo -e "\033[36m================ mvn deploy ${var} ================\033[0m"
  mvn -f ${var}/pom.xml clean deploy -DskipTests=true
done