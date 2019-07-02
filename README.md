##说明
>1. 该项目是根项目。pom.xml中定义了所有依赖项的版本号及子模块；另外有各服务的端口及名称说明。
>2. git_clone.bat/git_clone.sh。从git仓库clone所有子模块。
>3. git_pull.bat/git_pull.sh。对所有模块执行代码同步及mvn clean install -DskipTests=true。
>4. git_checkout.bat/git_checkout.sh。将所有子模块(不包含root)切换到对应分支。
```
    git_checkout dev
```
>5. docker_build.bat/docker_build.sh。对包含Dockerfile的模块进行镜像打包。
>6. docker_build.bat/docker_build.sh。将编译出来的镜像上传到镜像仓库(阿里云)。
需要配置pom.xml中的属性值<docker.repository.aliyun>及<docker.registry.aliyun.server.id>,并且需要在~/.m2/settings.xml中添加server节点。
>7. mvn_deploy.bat/mvn_deploy.sh。将包上传到maven私服。