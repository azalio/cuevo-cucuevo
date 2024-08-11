package kube

service: frontend: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "frontend"
		labels: {
			app:  "guestbook"
			tier: "frontend"
		}
	}
	spec: {
		// comment or delete the following line if you want to use a LoadBalancer
		type: "NodePort"
		// if your cluster supports it, uncomment the following to automatically create
		// an external load-balanced IP for the frontend service.
		// type: LoadBalancer
		ports: [{port: 80}]
		selector: {
			app:  "guestbook"
			tier: "frontend"
		}
	}
}
deployment: frontend: {
	apiVersion: "apps/v1" //  for k8s versions before 1.9.0 use apps/v1beta2  and before 1.8.0 use extensions/v1beta1
	kind:       "Deployment"
	metadata: name: "frontend"
	spec: {
		selector: matchLabels: {
			app:  "guestbook"
			tier: "frontend"
		}
		replicas: 3
		template: {
			metadata: labels: {
				app:  "guestbook"
				tier: "frontend"
			}
			spec: containers: [{
				name:  "php-redis"
				image: "gcr.io/google-samples/gb-frontend:v4"
				resources: requests: {
					cpu:    "100m"
					memory: "100Mi"
				}
				env: [{
					name: "GET_HOSTS_FROM"
					// If your cluster config does not include a dns service, then to
					// instead access environment variables to find service host
					// info, comment out the 'value: dns' line above, and uncomment the
					// line below:
					// value: env
					value: "dns"
				}]
				ports: [{containerPort: 80}]
			}]
		}
	}
}
