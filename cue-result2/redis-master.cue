package kube

_redis_master_labels: #global_labels & {
	app:  "redis"
	tier: "backend"
	role: "master"
}

_redis_master_name: #name & "redis-master"
_redis_master_port: #port & 6379

_redis_master_requests: #requests & {
	cpu:    "100m"
	memory: "256Mi"
}

service: "redis-master": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name:   _redis_master_name
		labels: _redis_master_labels
	}
	spec: {
		ports: [{
			port:       _redis_master_port
			targetPort: _redis_master_port
		}]
		selector: _redis_master_labels
	}
}
deployment: "redis-master": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: _redis_master_name
	spec: {
		selector: matchLabels: _redis_master_labels
		replicas: 1
		template: {
			metadata: labels: _redis_master_labels
			spec: containers: [{
				name:  "master"
				image: "registry.k8s.io/redis:e2e"
				resources: requests: _redis_master_requests
				ports: [{containerPort: _redis_master_port}]
			}]
		}
	}
}
