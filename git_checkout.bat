::bat for window
::author billon
::读取pom中的module,将项目切换为对应分支
@ECHO OFF

::判断语法是否正确
IF "%1"=="" (
  ECHO invalid param, use command like 'git_checkout.bat [branch]'
  GOTO END
)

::读取pom中的<module>.*</module>,遍历module执行git checkout [branch].
::就是启用变量延迟,我们可以形象的认为是启用了"对变量动态捕获扩展变化",
::而!括起来的变量,就是要动态捕获扩展的目标变量,如果不需要,可以继续使用%括变量
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%i IN ('FINDSTR /R "<module>.*</module>" pom.xml') DO (
  SET module=%%i
  ::判断是否是git项目
  IF EXIST "!module:~8,-9!/.git" (
    ECHO ======================== !module:~8,-9! =============================
    CD !module:~8,-9!
    git checkout %1
    CD ..
  )
)

:END