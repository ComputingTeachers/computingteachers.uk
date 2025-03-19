serve: remark-latest.min.js
	python3 -m http.server

deploy:
	ssh computingteachers.uk \
		'cd computingteachers.uk && git pull'

remark-latest.min.js:
	curl -L -O http://remarkjs.com/downloads/remark-latest.min.js
