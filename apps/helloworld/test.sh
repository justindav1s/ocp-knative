#!/usr/bin/env bash

../../bin/login.sh


PROJECT=knative-apps

oc project $PROJECT

oc get svc knative-ingressgateway --namespace istio-system

export IP_ADDRESS=$(oc get node  --output 'jsonpath={.items[0].status.addresses[0].address}'):$(oc get svc knative-ingressgateway --namespace istio-system   --output 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')

echo $IP_ADDRESS

export HOST_URL=$(kubectl get ksvc helloworld-go  --output jsonpath='{.status.domain}')

echo $HOST_URL

curl -v -H "Host: ${HOST_URL}" http://${IP_ADDRESS}