集群搭建文章 https://www.kubernetes.org.cn/5551.html
搭建 `nginx-ingress` 时修改了 `service` 增加了
```
externalIPs:
  - 192.168.3.220
```

### 出现过的问题
- 只能上传 1M 的图片 是因为 ingress 限制了,需要修改 `nginx-ingress-configmap` `dev/cluster/nginx-ingress/nginx-ingress-configmap.yaml:2`
