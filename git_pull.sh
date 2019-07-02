#!/usr/bin/env bash
#author billon
#读取pom中的module,对所有项目进行同步,完成后执行mvn install

#同步root
echo -e "\033[36m========================== root ========================\033[0m"
git status
git pull

#读取pom中的<module>.*</module>,遍历module,执行git pull
for var in `grep "<module>.*</module>" pom.xml | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
do
  #判断是否是git项目
  if [ -d "${var}/.git" ];then
    echo -e "\033[36m========================== ${var} ========================\033[0m"
    cd ${var}
    git status
    git pull
    cd ..
  fi
done

#执行mvn install
echo -e "\033[36m========================== mvn install ========================\033[0m"
mvn clean install -DskipTests=true