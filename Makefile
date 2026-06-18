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
