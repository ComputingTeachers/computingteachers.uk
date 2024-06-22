DOCKER_IMAGE_NIKOLA:=dragas/nikola:alpine

serve:
	python3 -m http.server

deploy:
	ssh computingteachers.uk \
		'cd computingteachers.uk && git pull'


nikola:
	#docker pull ${DOCKER_IMAGE_NIKOLA}
	docker run \
		--rm \
		-it \
		--volume ${PWD}:/nikola/ \
		--workdir /nikola/ \
		${DOCKER_IMAGE_NIKOLA} \
		/bin/sh

nikola_build:
	#

nikola_demo:
	#

remark-latest.min.js:
	curl -L -O http://remarkjs.com/downloads/remark-latest.min.js
