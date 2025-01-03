Intro
-------

    This repo contains Mintos homework 

Install on mac
---------------

    brew install minikube
    minikube start 
    minikube addons enable ingress
    minikube ip

Install / Test ingress 
--------------------------

    minikube addons enable ingress
    minikube addons list
    kubectl get pods -n ingress-nginx
    kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
    kubectl expose deployment web --type=NodePort --port=8080
    kubectl get service web
    minikube service web --url
    curl http://127.0.0.1:53915
    kubectl apply -f https://k8s.io/examples/service/networking/example-ingress.yaml
    curl --resolve "hello-world.example:80:192.168.49.2" -i http://hello-world.example

    curl --resolve "hello-world.example:31166:3.68.215.25" -i http://hello-world.example

Manual steps 
-------------

    rsync -a ~/work-priv/mintos-homework/ ubuntu@3.68.215.25:/home/ubuntu/mintos-homework/ 
    terraform init

Dashboard 
--------------

    minikube dashboard --url
    ssh -L 8081:localhost:36127 ubuntu@3.68.215.25
    curl http://127.0.0.1:8081/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/

Install postgresql
------------------

    helm install postgresql oci://registry-1.docker.io/bitnamicharts/postgresql
    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
    kubectl run -i --tty psql-client --image=postgres:latest --env="PGPASSWORD=yourpassword" --restart=Never -- bash -c "sleep infinity"
    kubectl exec -it psql-client -- /bin/bash
    psql -h postgresql.default.svc.cluster.local -U postgres -d postgres -W 
      - pwd  > vYDijhzkSs

Install sonarqube
------------------

    helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
    helm repo update
    helm upgrade --install sonarqube sonarqube/sonarqube -f sonarqube-cfg.yaml


    export POD_NAME=$(kubectl get pods --namespace default -l "app=sonarqube,release=sonarqube" -o jsonpath="{.items[0].metadata.name}")
    kubectl port-forward $POD_NAME 8080:9000 -n default