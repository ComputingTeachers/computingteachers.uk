DOCKER_IMAGE='computingteachers'

build_docker: clean
	docker build --tag ${DOCKER_IMAGE} --target site .

	docker create --name=${DOCKER_IMAGE}_container ${DOCKER_IMAGE}
	docker cp ${DOCKER_IMAGE}_container:/site/public/         site/
	docker cp ${DOCKER_IMAGE}_container:/site/resources/_gen/ site/
	docker rm ${DOCKER_IMAGE}_container

build_local: clean
	hugo build --minify --baseURL /
	hugo build --minify --baseURL /
	mkdir -p site
	cp -r public/ site/
	cp -r resources/_gen/ site/

serve_docker_nginx:
	docker build --tag ${DOCKER_IMAGE}nginx .
	docker run --rm --publish 80:80 ${DOCKER_IMAGE}nginx

serve_local: site
	python3 -m http.server --directory site

serve_hugo: node_modules
	hugo serve --baseURL /
node_modules:
	npm install

assets/images/og-image.png:
	"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
		--headless --screenshot --window-size=1200,630 \
		http://localhost:1313/
	mv screenshot.png $@
	optipng $@

clean:
	docker image rm --force ${DOCKER_IMAGE} ${DOCKER_IMAGE}nginx
	rm -rf \
		site \
		public \
		resources \
		hugo_stats.json \
		.hugo_* \
		package-lock.json \
		go.sum \

clean_all: clean
	rm -rf \
		node_modules \
