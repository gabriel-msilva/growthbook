# Helm chart

TO-DO
- Add volume .Values.uploadMethod
- Add extraEnv and extraEnvFrom
- ConfigMap to .Values.growthbookSettings.config

```shell
minikube start --driver=docker
docker context use default
```

```shell
helm install --namespace growthbook --atomic growthbook chart/
```

```shell
minikube ip
```

```shell
kubectl get ingress
```

```none
NAME         CLASS   HOSTS                               ADDRESS        PORTS   AGE
growthbook   nginx   gb.example.com,gb-api.example.com   172.17.0.15    80      38s
```

```shell
minikube service -n growthbook growthbook --url
```

## TLS certificates

```sh
openssl req -x509 -newkey rsa:4096 -keyout tls.key -out tls.crt -days 365 -nodes
kubectl create secret tls frontend-tls-secret --key tls.key --cert tls.crt
```

```sh
helm upgrade --install -n growthbook --atomic growthbook chart/ -f values.yaml --debug
```