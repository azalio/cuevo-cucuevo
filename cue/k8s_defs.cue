package kube

import (
	"k8s.io/api/core/v1"
	apps_v1 "k8s.io/api/apps/v1"
	meta_v1 "k8s.io/apimachinery/pkg/apis/meta/v1"

)

service: [string]:    v1.#Service
deployment: [string]: apps_v1.#Deployment

metadata: meta_v1.#ObjectMeta
