#!/usr/bin/env bash
#author billon
#读取pom中的module,执行docker:push

#定义docker仓库地址
docker_push_registry=registry.cn-beijing.aliyuncs.com/billon379/

#读取pom中的<module>.*</module>,遍历module,当module下存在pom.xml及Dockerfile时才执行docker:push
for var in `grep "<module>.*</module>" pom.xml | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
do
  #当module下存在pom.xml及Dockerfile时才执行后续操作
  if [ -f "${var}/pom.xml" ] && [ -f "${var}/src/main/docker/Dockerfile" ];then
    #从pom.xml中读取<version>信息
    version=`head -n 10 ${var}/pom.xml | grep "<version>.*</version>" | sed 's/^[[:space:]]*//g' | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
    echo -e "\033[36m================ docker push ${docker_push_registry}${var}:${version} ================\033[0m"
    docker push ${docker_push_registry}${var}:${version}
  fi
done