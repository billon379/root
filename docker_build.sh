#!/usr/bin/env bash
#author billon
#读取pom中的module,执行docker:build

#调用git_pull脚本,对所有模块代码进行同步
./git_pull.sh

#读取pom中的<module>.*</module>,遍历module,当module下存在pom.xml及Dockerfile时才执行docker:build
for var in `grep "<module>.*</module>" pom.xml | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
do
  #当module下存在pom.xml及Dockerfile时才执行docker:build
  if [ -f "${var}/pom.xml" ] && [ -f "${var}/src/main/docker/Dockerfile" ];then
    echo -e "\033[36m================ docker:build ${var} ================\033[0m"
    mvn -f ${var}/pom.xml clean package docker:build -DskipTests=true
  fi
done