#!/usr/bin/env bash

./login.sh


PROJECT=knative-monitoring
oc delete project $PROJECT
oc adm new-project $PROJECT --node-selector='capability=infra' 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc adm new-project $PROJECT --node-selector='capability=infra' 2> /dev/null
done

oc adm policy add-scc-to-user anyuid -z kube-state-metrics -n knative-monitoring
oc adm policy add-scc-to-user anyuid -z node-exporter -n knative-monitoring
oc adm policy add-scc-to-user privileged -z node-exporter -n knative-monitoring
oc adm policy add-scc-to-user anyuid -z default -n knative-monitoring
oc adm policy add-scc-to-user privileged -z default -n knative-monitoring
oc adm policy add-scc-to-user anyuid -z prometheus-system -n knative-monitoring

PROJECT=knative-serving
oc delete project $PROJECT
oc adm new-project $PROJECT --node-selector='capability=infra' 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc adm new-project $PROJECT --node-selector='capability=infra' 2> /dev/null
done

oc adm policy add-scc-to-user anyuid -z controller -n knative-serving
oc adm policy add-scc-to-user anyuid -z autoscaler -n knative-serving
oc adm policy add-cluster-role-to-user cluster-admin -z controller -n knative-serving

PROJECT=knative-build
oc delete project $PROJECT
oc adm new-project $PROJECT --node-selector='capability=infra' 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc adm new-project $PROJECT --node-selector='capability=infra' 2> /dev/null
done

oc adm policy add-scc-to-user anyuid -z build-controller -n knative-build
oc adm policy add-cluster-role-to-user cluster-admin -z build-controller -n knative-build


curl -L https://storage.googleapis.com/knative-releases/serving/latest/release-lite.yaml \
  | sed 's/LoadBalancer/NodePort/' \
  | oc apply -f -

oc project knative-serving
oc get pods -n knative-serving


