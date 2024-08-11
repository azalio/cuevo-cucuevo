package kube

_frontend_name: #name & "frontend"
_frontend_port: #port & 80

_frontend_labels: #global_labels & {
	app:  "guestbook"
	tier: _frontend_name
}

service: frontend: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name:   _frontend_name
		labels: _frontend_labels
	}
	spec: {
		type: "NodePort"
		ports: [{port: _frontend_port}]
		selector: _frontend_labels
	}
}

deployment: frontend: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: _frontend_name
	spec: {
		selector: matchLabels: _frontend_labels
		replicas: 3
		template: {
			metadata: labels: _frontend_labels
			spec: containers: [{
				name:  "php-redis"
				image: "gcr.io/google-samples/gb-frontend:v4"
				resources: requests: #requests
				env: #global_env
				ports: [{containerPort: _frontend_port}]
			}]
		}
	}
}
