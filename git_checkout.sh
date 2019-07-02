#!/usr/bin/env bash
#author billon
#读取pom中的module,将项目切换为对应分支

#判断语法是否正确
if [ ! -n "$1" ] ;then
  echo "invalid param, use command like 'git_checkout.sh [branch]'"
  exit 0
fi

#读取pom中的<module>.*</module>,遍历module执行git checkout [branch]
for var in `grep "<module>.*</module>" pom.xml | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
do
  #判断是否是git项目
  if [ -d "${var}/.git" ];then
    echo -e "\033[36m========================== ${var} ========================\033[0m"
    cd ${var}
    git checkout $1
    cd ..
  fi
done