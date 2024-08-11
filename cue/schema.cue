package kube

#global_labels: {
	app:   string
	tier:  string
	role?: string
	...
}

#name: string
#port: int

#requests: {
	cpu:    string | *"100m"
	memory: string | *"100Mi"
}

#EnvVar: {
	name:  string
	value: string
}

#EnvVars: [...#EnvVar]

#global_env: #EnvVars & [
	{
		name:  "GET_HOSTS_FROM"
		value: "dns"
	},
	...,
]
