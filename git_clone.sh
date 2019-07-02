#!/usr/bin/env bash
#author billon
#读取pom文件中的module,从git仓库克隆代码

#设置远程代码库url
remote_url=git@github.com:billon379/

#读取pom中的<module>.*</module>,遍历module,执行git clone
for var in `grep "<module>.*</module>" pom.xml | sed 's/<[a-z]*>//g' | sed 's/<\/[a-z]*>//g'`
do
  echo -e "\033[36m===============git clone ${remote_url}${var}.git ===============\033[0m"
  git clone ${remote_url}${var}.git
  cd ${var}
  git checkout dev
  cd ..
done