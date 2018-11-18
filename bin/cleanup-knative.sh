#!/usr/bin/env bash

./login.sh

oc delete project knative-monitoring
oc delete project knative-serving
oc delete project knative-build
oc delete project knative-apps




