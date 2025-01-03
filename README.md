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

    rsync -a ~/work-priv/mintos-home-work/ ubuntu@3.68.215.25:/home/ubuntu/mintos-home-work/ 
    terraform init
    terraform plan -target="aws_instance.ec2"

Dashboard 
--------------

    
    minikube dashboard --url
    ssh -L 8081:localhost:36127 ubuntu@3.68.215.25
    curl http://127.0.0.1:8081/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/