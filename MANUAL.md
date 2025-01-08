Intro 
------

    Steps for manual installation / testing.

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

Manual steps 
-------------

    rsync -av ~/work-priv/mintos-homework/ ubuntu@3.76.80.132:/home/ubuntu/mintos-homework/ 
    terraform init
    terraform apply

Dashboard 
--------------

    minikube dashboard --url
    ssh -L 8081:localhost:46003 ubuntu@3.70.69.12
    curl http://127.0.0.1:8081/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/

Install postgresql
------------------

    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm upgrade --install postgresql bitnami/postgresql -f postgresql-cfg.yaml
    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
    kubectl run psql-client --image=postgres:latest --restart=Never -- bash -c "sleep infinity"
    kubectl exec -it psql-client -- /bin/bash
    psql -h postgresql.homework.svc.cluster.local -U sonaruser -d sonarqube 
      
    psql -h postgresql -U sonarUser -d sonarDb -W 

    -- check access 
    CREATE USER sonaruser WITH PASSWORD 'sonarPwd';
    SELECT * FROM pg_user;
    \du
    SELECT * FROM pg_roles;

    CREATE DATABASE sonardb OWNER sonarUser;
    \l 
    GRANT ALL PRIVILEGES ON DATABASE sonardb TO sonaruser;

Install sonarqube
------------------

    helm repo add sonarqube https://charts.bitnami.com/bitnami
    helm search repo bitnami/sonarqube --versions
    helm install sonarqube sonarqube/sonarqube
    helm repo update
    helm upgrade --install sonarqube bitnami/sonarqube -f sonarqube-cfg.yaml
    
    -- access on remote instance 
    minikube service sonarqube -n homework --url
    ssh -L 8081:192.168.49.2:32484 ubuntu@3.76.80.132
    curl http://127.0.0.1:8081

    -- access on local instance 
    minikube tunel 
    curl --resolve "sonarqube.homework.com:80:127.0.0.1" -i http://sonarqube.homework.com
    echo "127.0.0.1  sonarqube.homework.com" | sudo tee -a /etc/hosts
    open in browser http://sonarqube.homework.com (user: "user", password : "pwd")


Docs
----

    https://github.com/bitnami/charts/blob/main/bitnami/postgresql/
