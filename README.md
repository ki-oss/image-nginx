Generic nginx image notes

# Utilisation
If you would like to tweak/use this for your own purposes please conscider using the official nginx image. This is just a reference/example of how one can easily customise and tweak nginx images for your own use cases.


# Notes



## This has the following tweaks:


### `nginx.conf`
- `log_format` changed to log in json
- `server_tokens off` (clients do not see the webserver header)


### `default.conf.template`

This is the default configuration; note there are strings such as `${NGINX_PORT}`. This is the default way of dynamically configuring nginx containers.
When nginx starts up it will replace these strings with values from environmental variables.

> NOTE: All env vars must have their defaults defined in the `Dockerfile`

- `server_name` is removed; this config file will answer to any inbound query (regardless of hostname)
- `location /` returns a 301 to `https://${REDIRECT_HOST}/$request_uri` (`$scheme` is not used as `https://` is manditory)


# testing

There is a `docker-compose.yaml`; please run `docker-compose up --build` to test it.

EG:

```
❯ curl -v localhost:8080/was/baz
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080 (#0)
> GET /was/baz HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.85.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 301 Moved Permanently
< Server: nginx
< Date: Thu, 15 Jun 2023 12:40:45 GMT
< Content-Type: text/html
< Content-Length: 162
< Connection: keep-alive
< Location: https://www.acmecorp.org/was/baz
< 
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx</center>
</body>
</html>
* Connection #0 to host localhost left intact

```

# list of env vars

key | default | notes
---|---|---
`NGINX_PORT` | `8080` | default `TCP port` that nginx will listen to
`REDIRECT_HOST` | `www.acmecorp.org` | the default hostname to sive 301 redirects towards
`REDIRECT_SCHEME` | `https` | the client will be asked to redirect to `https://www.acmecorp.org` (not `http`)

