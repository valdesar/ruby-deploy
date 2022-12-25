server {
	listen 80 default_server;
	listen [::]:80 default_server;

	server_name _;

	root /root/project/public/assets/;
	try_files  $uri $uri/ @ruby;

	location @ruby{
	proxy_pass http://localhost:9292;
}
}
