node {
    stage('Clone repository') {

    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'WipeWorkspace']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'f0cb8f80-44de-4c55-9f7b-b82b7efbd5d9', url: 'git@github.com:FIKUS0FIN/aws_demo.git']]])

    }

    stage('create AWS_EC2') {

    build job: 'awless_create', parameters: [string(name: 'NAME', value: 'JENKINS'), string(name: 'KILL', value: 'Falls'), string(name: 'TAG', value: 'proxied_tomcat')]

    }

    stage('provision EC2 with Tomcat') {
    
    build 'aws_demo_ansible'

    }
}
