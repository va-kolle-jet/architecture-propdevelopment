#!/bin/bash


# Создание пользователя admin
echo "Создание пользователя admin..."
openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -out admin.csr -subj "/CN=admin/O=Admins"
openssl x509 -req -in admin.csr -CA .minikube/ca.crt -CAkey .minikube/ca.key -CAcreateserial -out admin.crt -days 1000
kubectl config set-credentials admin --client-certificate=admin.crt --client-key=admin.key
kubectl config set-context admin-context --cluster=minikube --user=admin

# Создание пользователя u-read
echo "Создание пользователя u-reader..."
openssl genrsa -out u-reader.key 2048
openssl req -new -key u-reader.key -out u-reader.csr -subj "/CN=u-reader/O=Users"
openssl x509 -req -in u-reader.csr -CA .minikube/ca.crt -CAkey .minikube/ca.key -CAcreateserial -out u-reader.crt -days 1000
kubectl config set-credentials u-reader --client-certificate=u-reader.crt --client-key=u-reader.key
kubectl config set-context u-reader-context --cluster=minikube --user=u-reader

# Создание пользователя u-writer
echo "Создание пользователя u-writer..."
openssl genrsa -out u-writer.key 2048
openssl req -new -key u-writer.key -out u-writer.csr -subj "/CN=u-writer/O=Managers"
openssl x509 -req -in u-writer.csr -CA .minikube/ca.crt -CAkey  .minikube/ca.key -CAcreateserial -out u-writer.crt -days 1000
kubectl config set-credentials u-writer --client-certificate=u-writer.crt --client-key=u-writer.key
kubectl config set-context u-writer-context --cluster=minikube --user=u-writer