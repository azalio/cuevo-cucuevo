package kube

_redis_replica_labels: #global_labels & {
	app:  "redis"
	role: "replica"
	tier: "backend"
}

_redis_replica_name: #name & "redis-replica"
_redis_replica_port: #port & 6379

service: "redis-replica": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name:   _redis_replica_name
		labels: _redis_replica_labels
	}
	spec: {
		ports: [{port: 6379}]
		selector: _redis_replica_labels
	}
}
deployment: "redis-replica": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: _redis_replica_name
	spec: {
		selector: matchLabels: _redis_replica_labels
		replicas: 2
		template: {
			metadata: labels: _redis_replica_labels
			spec: containers: [{
				name:  "replica"
				image: "gcr.io/google_samples/gb-redisslave:v1"
				resources: requests: #requests
				env: #global_env
				ports: [{containerPort: _redis_replica_port}]
			}]
		}
	}
}
