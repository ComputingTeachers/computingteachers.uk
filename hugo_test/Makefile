DOCKER_IMAGE='computingteachers'

.PHONEY: hugo
hugo: hugo.toml node_modules
	hugo serve
hugo.toml: themes/hugoplate
	cp -R themes/hugoplate/exampleSite/* .
	sed -i'' -e 's/https:\/\/example.org/\//g' hugo.toml
node_modules: package.json
	npm install
package.json: themes/hugoplate
	cp themes/hugoplate/package.json .
themes/hugoplate:
	git clone --recurse-submodules https://github.com/zeon-studio/hugoplate.git themes/hugoplate


public: clean
	docker build --tag ${DOCKER_IMAGE} --target site .

	docker create --name=${DOCKER_IMAGE} ${DOCKER_IMAGE}
	docker cp ${DOCKER_IMAGE}:/site/public/ public/
	docker rm ${DOCKER_IMAGE}

.PHONEY: serve_nginx
serve_nginx:
	docker build --tag ${DOCKER_IMAGE}nginx .
	docker run --rm --publish 80:80 ${DOCKER_IMAGE}nginx

clean:
	docker image rm --force ${DOCKER_IMAGE} ${DOCKER_IMAGE}nginx
	rm -rf \
		public \
		resources \
		go.* \
		hugo_stats.json \
		assets \
		.hugo_* \
		hugo.toml \
		config \
		content \
		data \
		i18n \
		package.json \
		package-lock.json \

clean_all: clean
	rm -rf \
		themes \
		node_modules \