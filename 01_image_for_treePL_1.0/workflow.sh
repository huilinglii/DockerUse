# 默认只有root用户和具备sudo权限的用户才能运行Docker命令。
# 如果你希望允许非root用户运行Docker命令，你需要将user001用户添加到docker组
sudo usermod -aG docker user001

# 添加完毕后，你需要重新启动系统来使得用户组的变更生效
sudo systemctl daemon-reload
sudo systemctl restart docker

# 构建镜像
# 在当前目录下 . 使用 Dockerfile 构建名为 treepl 的镜像
docker build -t treepl .

# 建立并进入容器
docker run -it -d --entrypoint /bin/bash --name run_treepl --memory="50g" -v /data/LHL/004/:/treepl_1_0/  treepl

# 解释
# -it: 这是两个选项的组合：-i: 让容器的标准输入保持打开状态-t: 为容器分配一个伪终端，可以在容器内使用命令行界面
# --entrypoint /bin/bash: 指定了容器启动时要运行的入口点。这里将入口点设置为 /bin/bash，容器启动后将进入一个交互式的 Bash shell，而不是默认的命令
# --name run_treepl: 这为容器指定一个名称 run_treepl，不同用户的容器的名字不能重复。
#--memory="50g": 内存，根据需要自己设置内存上限
# -v /data/LHL/004/:/treepl_1_0/ : 挂载选项，表示将 /data/LHL/004/ 目录挂载到容器内部的 /treepl_1_0/ 目录
# treepl: 这是要使用的镜像名称，运行的是名为 treepl 的 Docker 镜像

#######
# 注意!
# /data/LHL/004/ 这个目录里面包含 treePL 需要的 configuration file，和 configuration file 里面的 input.tre
#######

# 进入容器之后，切换工作路径到挂载点
# 比如这里挂载点是/treepl_1_0/
cd /treepl_1_0/

# 运行treePL
/usr/local/src/treepl/treePL-1.0/treePL  config.txt

# 退出但不终止(注意是大写P和Q，先按P再快速按Q)
ctrl + P + Q

# 检查容器的状态，确保它仍然在后台运行
docker ps

# 查看容器 run_treepl 的日志并输出到当前目录下
docker logs run_treepl > log.txt

# 容器 run_treepl 跑完之后，记得删除
docker rm run_treep
