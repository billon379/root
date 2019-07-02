::bat for windows
::author billon
::读取pom中的module,执行docker:build

@ECHO OFF

::调用git_pull脚本,对所有模块代码进行同步
CALL ./git_pull.bat

::读取pom中的<module>.*</module>,遍历module当module下存在pom.xml及Dockerfile时才执行docker:build
::就是启用变量延迟,我们可以形象的认为是启用了"对变量动态捕获扩展变化".
::而!括起来的变量,就是要动态捕获扩展的目标变量,如果不需要,可以继续使用%括变量
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%i IN ('FINDSTR /R "<module>.*</module>" pom.xml') DO (
  SET module=%%i
  ::当module下存在pom.xml及Dockerfile时才执行docker:build
  IF EXIST "!module:~8,-9!/pom.xml" (
    IF EXIST "!module:~8,-9!/src/main/docker/Dockerfile" (
      ECHO ==================================== docker:build !module:~8,-9! ====================================
      CALL mvn -f !module:~8,-9!/pom.xml clean package docker:build -DskipTests=true
    )
  )
)