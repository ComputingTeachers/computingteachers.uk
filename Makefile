DOCKER_IMAGE_NIKOLA:=dragas/nikola:alpine

run_local:
	python3 -m http.server

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
