## 步骤
参照[使用kubeadm安装Kubernetes 1.15](https://www.kubernetes.org.cn/5551.html)的步骤安装

## 踩坑点
- centos 7.2 安装 kubernetes 1.16会出现kubelet无法启动的问题
- 单机集群当集群启动后需要执行下列命令，[出于安全考虑默认情况下无法在master节点上部署pod](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)
`kubectl taint nodes --all node-role.kubernetes.io/master-`
`kubectl get no -o yaml | grep taint -A 5`

