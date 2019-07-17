::bat for windows
::author billon
::将指定docker镜像推送到仓库
@ECHO OFF

::定义docker仓库地址
SET docker_push_registry=registry.cn-beijing.aliyuncs.com/billon379/

::读取pom中的<module>.*</module>,遍历module当module下存在pom.xml及Dockerfile时才执行docker:push
::就是启用变量延迟,我们可以形象的认为是启用了"对变量动态捕获扩展变化".
::而!括起来的变量,就是要动态捕获扩展的目标变量,如果不需要,可以继续使用%括变量
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%i IN ('FINDSTR /R "<module>.*</module>" pom.xml') DO (
  SET module=%%i
  ::当module下存在pom.xml及Dockerfile时才执行docker:push
  IF EXIST "!module:~8,-9!/pom.xml" (
    IF EXIST "!module:~8,-9!/src/main/docker/Dockerfile" (
      CD !module:~8,-9!
      ::跳转至推送
      CALL :PUSH
      CD ..
    )
  )
)

::跳转至程序结束
GOTO :END

::读取pom文件第一行的<version>,执行docker push
:PUSH
FOR /F %%j IN ('FINDSTR /R "<version>.*</version>" pom.xml') DO (
  SET version=%%j
  ECHO ================ docker:push %docker_push_registry%!module:~8,-9!:!version:~9,-10! ================
  docker push %docker_push_registry%!module:~8,-9!:!version:~9,-10!
  GOTO :EOF
)

::程序结束
:END