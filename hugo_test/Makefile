DOCKER_IMAGE='hugotest'

build_docker: clean
	docker build --tag ${DOCKER_IMAGE} --target site .

	docker create --name=${DOCKER_IMAGE}_container ${DOCKER_IMAGE}
	docker cp ${DOCKER_IMAGE}_container:/site/public/         site/
	docker cp ${DOCKER_IMAGE}_container:/site/resources/_gen/ site/
	docker rm ${DOCKER_IMAGE}_container

build_local: clean hugo.toml node_modules
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

serve_hugo: hugo.toml node_modules
	hugo serve --baseURL /
hugo.toml: themes/hugoplate
	cp -R themes/hugoplate/exampleSite/* .
node_modules: package.json
	npm install
package.json: themes/hugoplate
	cp themes/hugoplate/package.json .
themes/hugoplate:
	git clone https://github.com/zeon-studio/hugoplate.git themes/hugoplate

clean:
	docker image rm --force ${DOCKER_IMAGE} ${DOCKER_IMAGE}nginx
	rm -rf \
		site \
		public \
		resources \
		go.* \
		hugo_stats.json \
		assets \
		.hugo_* \
		hugo.toml* \
		config \
		content \
		data \
		i18n \
		package.json \
		package-lock.json \
		static \

clean_all: clean
	rm -rf \
		themes \
		node_modules \