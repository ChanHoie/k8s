
ingress-nginx 安装
```
helm install stable/nginx-ingress \
-n nginx-ingress \
--namespace kube-system  \
-f ingress-nginx.yaml
```

dashboard 安装
```
helm install stable/kubernetes-dashboard \
-n dashboard \
--namespace kube-system  \
-f dashboard.yaml
```

登录 https://k8s.kuaixuezaixian.com/#!/login
`kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep tiller-token | awk '{print $1}')` 复制token

使用 `tiller-token`,为管理员权限
`
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJ0aWxsZXItdG9rZW4tdHcyc3EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoidGlsbGVyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiMzdlZjMxOTctMTU4Ny00NjI4LWIwY2YtOGE0ODRhYTgyZGNiIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOnRpbGxlciJ9.jgTCKl-T9E8XXwpQPE0xnD-jAoOYF-5GDO0yA0IvKiuT-pLmzYJmlP7GPZ0qtLpWI8VVe7DEtEABWah9MEkuXGZkpyqNMvjch-5SQ-bD1Bb0EcWT11FV8pRYq446m-6wJW-W029pixYdK9AYzpzNb2YZNt2tAzLD0RnxaGN6EtRvqNkd4VoaW8R3xNbXqxaTY7RYxg1HCBEf9MIx3oE6cQVHQXpHcwMTo8WWDpdy-pkzAchzufBFdPvV9_XFTuXnvoRPfizPaqUN2O5JVQiA5s56ISk1AFZzSG1X-FxAXP6EQmicWMe2qYL8NqvXEvV_9kwfbgc2Sz0ZA8yNVh-1SQ`
