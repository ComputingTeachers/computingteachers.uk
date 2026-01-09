FROM hugomods/hugo:latest AS site
    WORKDIR /site/
    RUN git clone https://github.com/zeon-studio/hugoplate.git themes/hugoplate
    RUN cp themes/hugoplate/package.json . && npm install
    RUN cp -R themes/hugoplate/exampleSite/* .
    RUN hugo build --minify --baseURL /

FROM nginx:alpine AS nginx
    WORKDIR /usr/share/nginx/html
    COPY --from=site /site/public/ .
    COPY --from=site /site/resources/_gen/ .
    EXPOSE 80
