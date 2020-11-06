测试滚动更新
- 部署服务 `kubectl create -f .`
- 检测服务更新状态 `while (true) do curl http://47.95.71.159/nginx/; done;`
- 更新镜像版本,观察版本更新
- 回退版本更新 `kubectl rollout undo deployment practice-rollupdate`
