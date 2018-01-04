node {
    stage('Clone repository') {

    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'WipeWorkspace']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'f0cb8f80-44de-4c55-9f7b-b82b7efbd5d9', url: 'git@github.com:FIKUS0FIN/aws_demo.git']]])

    }

    stage('awless create EC2'){

    sh '''yes | awless create instance name=${NAME}*:_:*${TAG} image=ami-3f1bd150 keypair=ubuntu \\
    subnet=subnet-4e64b325 securitygroup=@EC2SecurityGroup \\
    userdata=https://raw.githubusercontent.com/FIKUS0FIN/aws_demo/master/provisionign_pakeges/py_min.sh > raw.txt'''

    }

    stage('create Tag for inctance  ') {

    sh '''AWS_ID=$(cat raw.txt | grep "instance = " | awk \'{print $6}\')
    AWS_DNS=$(awless show $AWS_ID | grep PublicDNS | awk \'{print $4}\')
    echo "$AWS_DNS" > ../aws_DNS.conf
    echo "$AWS_ID" > ../aws_id.conf
    yes | awless check instance id=$AWS_ID state=running
    yes | awless create tag key=TAG resource=$AWS_ID value=${TAG}
    echo "${TAG}" > ../aws_tag.conf
    awless show $AWS_ID
    sleep 10'''

    }

    stage ('waite provisioning for box '){

    sleep 60

    }

    stage('provision EC2 with Tomcat') {


    sh '''AWS_TAG=$(cat ../aws_tag.conf)
    AWS_ID=$(cat ../aws_id.conf)
    AWS_IP=$(awless show $AWS_ID | grep "Public IP" | awk \'{print $5}\')
  	sed -i "s/TOMCAT/${AWS_TAG}/" demo_ansible/new_ansible_folder/inventory
  	sed -i "s/AWS_IP/${AWS_IP}/" demo_ansible/new_ansible_folder/inventory
    cd demo_ansible/new_ansible_folder

  	ansible-playbook -i inventory simple_tomcat.yml
    echo "$AWS_TAG $AWS_ID $AWS_DNS" '''

    }
    stage ('buil app and deploy'){

    build 'build_war_app'

    }
}
