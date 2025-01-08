Intro
-------

    This project automates the setup of a containerized development environment using Bash to install Docker, Minikube, Helm, and kubectl. Using Helm, it deploys PostgreSQL and SonarQube, with SonarQube persisting data using a Persistent Volume Claim (PVC). Resource limits are configured for both applications to optimize performance and prevent overuse of cluster resources. Additionally, SonarQube is exposed to external traffic through an Ingress resource, enabling easy access for code quality analysis. 

Requirements 
-------------

    Depednecys : 
        * packages : curl, git, wget 
        * resources : 8 GB of memory and 2x CPU 
        * `ubuntu` users with rights to escalate privileges without password

    Code is tested on : 
        * AWS ec2 instance with Ubuntu Noble 24.04
        * MacOS Sequoia 15.2

Installation 
-------------

On clean instance execute: 

    ubuntu@remote-host:~$ git clone git@github.com:ogavrisevs/mintos-homework.git
    ubuntu@remote-host:~$ cd mintos-homework
    ubuntu@remote-host:~$ ./run.sh

Access sonarqube (on remote insatnce): 

    ubuntu@remote-host:~$ minikube service sonarqube -n homework --url
    ubuntu@remote-host:~$ ssh -L 8081:192.168.49.2:32484 ubuntu@3.76.80.132
    mac@localhost-host:~$ (open browser) http://127.0.0.1:8081 // (user: "user", password : "pwd")

Access sonarqube (on localhost): 

    minikube tunel 
    echo "127.0.0.1  sonarqube.homework.com" | sudo tee -a /etc/hosts
    open browser http://sonarqube.homework.com  // (user: "user", password : "pwd")

Clean up 
--------

    terraform destroy 

Testing 
---------

    Run terrafrom `ec2.tf` from `test` folder, it will spin up ec2 instance in AWS (set up aws credentials on instance and replace aws.vpc, subnet , and profile id's), copy files and execute `run.sh` script. 

Limitations / known bugs 
--------------------------

    * Sometimes on clean install sonarqube pod can restart.
    * When accessing sonarqube on remote instance tunel is attached to service and ingress is obsolete. 
    * When files are copy from local host to remote it can take up to ~ 10 min because it copy also terraform temp files (providers / state / etc.). 


Feature improvments 
--------------------

    * Store passwords in k8s secret and/or secret manager. 
    * Collect logs and metrics.
    * Memory limitation is set on minikube and seperate services this can be set as variable. 
    * All endpoints in cluster must be secured with TLS.
