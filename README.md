# ocp-knative
Knative on openshift

https://github.com/knative/docs/blob/master/install/Knative-with-OpenShift.md


oc get svc knative-ingressgateway --namespace istio-system
oc get svc knative-ingressgateway --namespace istio-system --output 'jsonpath={.status.loadBalancer.ingress[0].ip}'



export IP_ADDRESS=$(oc get svc knative-ingressgateway --namespace istio-system --output 'jsonpath={.status.loadBalancer.ingress[0].ip}')

echo IP_ADDRESS : ${IP_ADDRESS}

export IP_ADDRESS=$(oc get node  --output 'jsonpath={.items[0].status.addresses[0].address}'):$(oc get svc knative-ingressgateway --namespace istio-system   --output 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')

echo IP_ADDRESS : ${IP_ADDRESS}


export DOMAIN=$(oc get ksvc helloworld-go  --output=custom-columns=NAME:.metadata.name,DOMAIN:.status.domain)

echo DOMAIN : ${DOMAIN}

export HOST_URL=$(oc get ksvc helloworld-go  --output jsonpath='{.status.domain}')

echo HOST_URL : ${HOST_URL}

curl -v -H "Host: ${HOST_URL}" http://192.168.33.11:32380

curl -v -H "Host: helloworld-go.knative-apps" http://192.168.33.11:32380
