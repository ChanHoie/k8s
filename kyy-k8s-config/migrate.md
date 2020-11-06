将服务迁移到 k8s 集群的步骤.
## 创建 RDS 和 Redis

### 创建 RDS
实例选择(已加好配置单,已购买):
- 主库 8核 16G 版本 5.6 150G
- 题库 8核 16G 版本 5.7 200G
- 附属库 4核 8G 版本 5.6 150G
- 主库的只读库 8核 16G 版本 5.6(按量付费) 

注意事项:
- 跟同掣沟通,购买数据库(已沟通)
- 只读库可以先不创建 (数据迁移完成后看下效果)
#### 数据库用户创建

数据库名称|内网地址|用户|密码|权限|备注
---|--_|---|---|---|---
主库|rm-2ze8m2daqb051wp49.mysql.rds.aliyuncs.com|kyy_master|tdHRdT7V2o4d|读写|程序专用-勿删
题库|rm-2ze1284oau0bzbz97.mysql.rds.aliyuncs.com|kyy_question|Nd1Gt6IgddAu|读写|程序专用-勿删
附属库|rm-2zeb1f93086857hv0.mysql.rds.aliyuncs.com|kyy_yuncms|4PYmsab4Ukyh|读写|程序专用-勿删

原库同步账号: dts dts123Dts
注意事项:
- ✅️ 创建袋鼠云用户 用户名: dtdba 密码: dtdba123DT
#### 白名单配置

### 创建 Redis
实例选择(已加好配置单,已下单): redis 8G 版本 2.8 
链接地址|密码 
---|---
r-2ze6269f42e1f8c4.redis.rds.aliyuncs.com|9V3zrtA338ULq6N7s2

注意事项:
- 白名单配置 添加 ecs 白名单

## DTS 同步数据

步骤:
- 创建 DTS 全量和增量同步数据
- 检验数据完成性 

✅ 需要创建 DTS 同步实例包月(400元/月):
- user_video_likes      => sync_user_video_likes
- khome_spaces          => sync_khome_spaces
- edu_comments          => sync_edu_comments
- edu_classroom_member  => sync_edu_classroom_member
- edu_classroom         => sync_edu_classroom
注意事项:
- 白名单配置
- 选择最优链路
- 实例规格选择medium即可,整个同步过程2个小时之内就能完成
- mysql 5.7 默认有一个 `sys` 数据库,不需要同步 

疑问:
- 机构、三秒、考呀呀是否要分开(先不分开)

#### 升级负载均衡(SLB)、NAT 配置(✅)

>按量付费模式下可选择最大规格，规格费将根据每小时使用的实际规格进行收取，闲时免规格费
选择最大的规格  

`SLB` 规格(已升级):根据上述阿里云描述,所以直接选择最大的 slb 规格()
`NAT` 规格不需要升级,主要是用来 ecs 访问公网拉取镜像使用的,不需要很高的配置.现在作为公网访问青岛的数据库、Redis等使用。



#### 微信白名单配置
- ✅ nat ip 39.105.169.72

#### 机构域名解析修改通知(✅)
通过 `dig www.119test.com` 查看是否是使用了 `CNAME`,使用了 `CNAME`的就不用通知更换解析
- www.119test.com      # cname
- nxszslt.szsltedu.com  # cname
- qlwd.kkt9.cc          # cname
- yckj.yckjw.com        # cname
- nxszslt.ltpx.net      # cname
- kjks.szacc.com        # cname
- wx.ytxzkj.com         # cname
- sxtuby.0831yb.com     # cname

疑问: 
- 微信回调地址的域名解析他们会不会同步修改(不确定)

#### OSS 迁移
配置域名解析:
- ⭕ download-a 
- ⭕ keditor-attached

#### 讲解
- 采购单
- ECS 
- 安全组 ecs rds redis vpc
- SLB 
- VPC 


### 迁移计划(2019-7-18 00:00:00 - 06:00:00)

#### 修改本地域名解析
```
39.97.7.247 www.kaoyaya.com
39.97.7.247 wxws.kaoyaya.com
39.97.7.247 www.91sanmiao.com
39.97.7.247 www.119test.com
39.97.7.247 account.kaoyaya.com
39.97.7.247 account.accgg.com
39.97.7.247 www.accgg.com
39.97.7.247 sccs.accgg.com
39.97.7.247 1jiedai.com
39.97.7.247 www.kaoyaya.cn
39.97.7.247 www.kaoyaya.com.cn
39.97.7.247 m.kaoyaya.com
39.97.7.247 www.kyy1.cn
```
#### k8s 服务修改
部署以下目录服务
├── app 无状态应用
└── cronjobs 定时任务
注意：
- `website-music`需要修改代码
`for d in *;do kubectl create -f $d;done` 批量创建
#### 修改域名解析之前需要测试的服务(优先测试前台,再查看app,最后测后台)
- 前台
  - 手机端(先测考呀呀,注意 `http` 和 `https`都要测,其他域名只需要测 `http`)
    - ✅https://www.kaoyaya.com
    - ✅录播视频
    - ✅直播/回放
    - ✅班级提问
    - ✅下单,查看开通服务
    - ✅http://www.91sanmiao.com
    - ✅http://www.119test.com
    - ✅http://sccs.accgg.com
    - ✅http://1jiedai.com
    - ✅http://m.kaoyaya.com
    - ❌http://www.kaoyaya.com.cn
    - ✅http://www.kaoyaya.cn
    - ✅http://kyy1.cn/iQBJbBI 短链接服务
    - ✅http://qr.kaoyaya.com 二维码服务
  - 电脑端  
  - 题库
    - 做题
    - 评论
    - 答题记录是否更新
  - 凭证练习
   - [电脑端](http://account.kaoyaya.com/voucher/pc/#/account?testId=118080) 
   - [手机端](http://account.kaoyaya.com/voucher/pc/#/account?testId=118080) 
- 后台
  - 图片上传
    - [上传页面](https://www.kaoyaya.com/web/admin/marketing/content)  
    - [上传接口](https://www.kaoyaya.com/api/v1/file/image) 
  - 题库管理
    - [班级作业](https://www.kaoyaya.com/web/admin/subject/217/homework)
  - 视频/字幕上传
    - [上传页面](https://www.kaoyaya.com/web/admin/video/lesson/list?recordingTeacher=-1&keyword=&searchType=1&relationType=-1&disLikeNumber=-1&sortField=play_num&sortType=desc&page=1&pageSize=20&softDelState=0)
  - 微信客服 [客服页面](https://www.kaoyaya.com/wxim/)
- app
  - 视频
  - 直播
  - 题库

#### 修改域名解析
有解析记录的解析列表,打 ⭕ 的需要修改,打 ❌ 的不需要修改:
- ⭕91sanmiao.com
- ⭕kaoshishi.cn
- ⭕kyy1.cn
- ⭕kyy6.cn
- ⭕caishidian.com
- ⭕xueacc.com
- ⭕ncdeck.cn
- ⭕0791office.cn
- ⭕kaoyaya.com.cn
- ⭕1jiedai.com
- ⭕ncspw.cn
- ⭕kaoyaya.cn
- ⭕accgg.com
- ⭕kaoyaya.com
- kuaixuezaixian.com ❌
- kuaizuozhang.cn ❌
- kuaixuezaixian.cn ❌
- shengcaigu.com ❌
- for2000.com ❌
- xueacc.top ❌
- nctzjc.cn ❌
具体操作步骤:
 - ⭕️ 将所有原来解析到 `47.105.203.42`、`47.105.197.111` 按原来主机记录全部解析到 `39.97.7.247`
 - ⭕ 将原数据解析导出,搜索替换,记得备份文件

#### redis 同步
旧 redis :  test.kyy6.cn 6377 9kiz35jRjmE1EGxstI
新 redis :  r-2ze6269f42e1f8c4.redis.rds.aliyuncs.com 6379  9V3zrtA338ULq6N7s2
[Redis同步](https://help.aliyun.com/document_detail/117311.html?spm=5176.10695662.1996646101.searchclickresult.6cfc3cfaxxdiRZ)
在`worker-H-1`的`/root/redis`目录下执行
`./redis-shake -type=rump -conf=redis-shake.conf`
#### 分工
各个负责人可以先做准备工作.
文富: 停止旧服务, website 的服务,需要修改代码
子豪: 部署新服务
刘林: redis 同步,检验数据的完整性,修改 oss, 测试流量转发
李亮: 创建 DTS,定时任务检查,修改域名解析
蓝天: 测试服务的可用性

按一下步骤操作,每一步完成后才可进行下一步:
- 1. 切换监听到维护页面(文富),并测试旧服务已下线(蓝天)
- 2. 等待旧服务停止写入,停止定时服务(刘林),检验数据的完整性(李亮)-登录到新旧数据库 count 表用户表/订单/微信用户/题库做题记录/
- 3. 数据一致后,等待 DTS 增量无延迟(子豪) ,修改 OSS bucket(刘林),oss bucket域名解析修改
   - oss-cn-beijing.aliyuncs.com 公网
   - oss-cn-beijing-internal.aliyuncs.com vpc
   - bucket name (php 文富,go刘林)
- 4. 部署新服务(子豪/文富),先创主任务,创建 DST 同步实例(李亮)
   - 主库 sq_kaoyaya => 题库 question
   - 先删除题库下面的 sync_ 开头的
   - user_video_likes      => sync_user_video_likes
   - khome_spaces          => sync_khome_spaces
   - edu_comments          => sync_edu_comments
   - edu_classroom_member  => sync_edu_classroom_member
   - edu_classroom         => sync_edu_classroom
- 5. 创建定时任务,定时任务检查(后端),测试(蓝天)
- 6. 修改青岛负载均衡监听到 `nginx-test`(文富) 
- 7. 测试完成后修改域名解析(李亮)
- 8. 再次测试(全员)

#### 失败预案
- 1. 域名解析回滚
- 2. 青岛 slb 监听修改回 proxy














