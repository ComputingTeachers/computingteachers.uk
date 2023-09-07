DOCKER_IMAGE_NIKOLA:=dragas/nikola:alpine

serve:
	python3 -m http.server

deploy:
	ssh computingteachers.uk \
		'cd computingteachers.uk && git pull'


run:
	#docker pull ${DOCKER_IMAGE_NIKOLA}
	docker run \
		--rm \
		-it \
		--volume ${PWD}:/nikola/ \
		--workdir /nikola/ \
		${DOCKER_IMAGE_NIKOLA} \
		/bin/sh

build:
	#

demo:
	#

