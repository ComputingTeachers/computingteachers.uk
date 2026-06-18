DOCKER_IMAGE_BASE:=staticsitegenerator
DOCKER_IMAGE_BUILD:=computingteachersbuild
DOCKER_IMAGE_NGINX:=computingteachersnginx

build: staticSiteGenerator
	uv run \
		--no-dev \
		--directory staticSiteGenerator \
		--module static_site_generator.app \
		${PWD}/computingteachers.uk \
		--build ${PWD}/build

staticSiteGenerator:
	if [ -d '../$@' ] ; then \
		ln -s ../$@ $@ ; \
	else \
		git clone https://github.com/calaldees/staticSiteGenerator.git ; \
	fi

build_docker: staticSiteGenerator
	docker build --tag ${DOCKER_IMAGE_BASE} --target base staticSiteGenerator
	docker build --tag ${DOCKER_IMAGE_BUILD} --build-arg BASE=${DOCKER_IMAGE_BASE} .

	docker create --name=${DOCKER_IMAGE_BUILD}_container ${DOCKER_IMAGE_BUILD}
	docker cp ${DOCKER_IMAGE_BUILD}_container:/site/build/ build/
	docker rm ${DOCKER_IMAGE_BUILD}_container

serve_docker_nginx: build_docker
	docker build --tag ${DOCKER_IMAGE_NGINX} --file staticSiteGenerator/nginx.gzip_static.Dockerfile build/
	docker run --rm --publish 80:80 ${DOCKER_IMAGE_NGINX}

clean:
	rm -rf \
		build \
		staticSiteGenerator \


# Old --------------------------------------------------------------------------

serve: remark-latest.min.js
	python3 -m http.server

deploy:
	ssh computingteachers.uk \
		'cd computingteachers.uk && git pull'

remark-latest.min.js:
	curl -L -O http://remarkjs.com/downloads/remark-latest.min.js
