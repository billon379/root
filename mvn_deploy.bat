::bat for window
::author billon
::读取pom中的module,发布项目到nexus
@ECHO OFF

::读取pom中的<module>.*</module>,遍历module执行mvn deploy.
::就是启用变量延迟,我们可以形象的认为是启用了"对变量动态捕获扩展变化",
::而!括起来的变量,就是要动态捕获扩展的目标变量,如果不需要,可以继续使用%括变量
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%i IN ('FINDSTR /R "<module>.*</module>" pom.xml') DO (
  SET module=%%i
  CALL mvn -f !module:~8,-9!/pom.xml clean deploy -DskipTests=true
)