#!/usr/bin/env bash

../../bin/login.sh


PROJECT=knative-helloworld

oc delete project $PROJECT
oc adm new-project $PROJECT --node-selector='capability=apps' 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc adm new-project $PROJECT --node-selector='capability=apps' 2> /dev/null
done

oc label namespace $PROJECT istio-injection=enabled
oc adm policy add-scc-to-user privileged -z default -n $PROJECT


oc apply -f helloworld.yaml -n $PROJECT

