::bat for windows
::author billon
::读取pom文件中的module,从git仓库克隆代码
@ECHO OFF

::设置远程代码库url
SET remote_url=git@github.com:billon379/

::读取pom中的<module>.*</module>,遍历module执行git clone.
::就是启用变量延迟,我们可以形象的认为是启用了"对变量动态捕获扩展变化",
::而!括起来的变量,就是要动态捕获扩展的目标变量,如果不需要,可以继续使用%括变量
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%i IN ('FINDSTR /R "<module>.*</module>" pom.xml') DO (
  SET module=%%i
  ECHO "git clone %remote_url%!module:~8,-9!.git"
  git clone %remote_url%!module:~8,-9!.git
  CD !module:~8,-9!
  git checkout dev
  CD ..
)