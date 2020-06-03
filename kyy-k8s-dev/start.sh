#!/usr/bin/env bash

kubectl create secret docker-registry beijing --docker-server=registry.cn-beijing.aliyuncs.com --docker-username=xuqizhi@gmail.com --docker-password=Caishidian168\* --docker-email=xuqizhi@gmail.com

kubectl create secret docker-registry qingdao --docker-server=registry.cn-qingdao.aliyuncs.com --docker-username=xuqizhi@gmail.com --docker-password=Caishidian168\* --docker-email=xuqizhi@gmail.com

kubectl apply -f ./namespcaes.yaml

kubectl apply -f ./mandatory.yaml

kubectl apply -f ./cloud-generic.yaml

kubectl get -n ingress-nginx pods
