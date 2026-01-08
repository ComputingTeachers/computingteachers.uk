FROM hugomods/hugo:latest AS site
    WORKDIR /site/
    RUN git clone https://github.com/zeon-studio/hugoplate.git themes/hugoplate
    RUN cp themes/hugoplate/package.json . && npm install
    RUN cp -R themes/hugoplate/exampleSite/* .
    RUN sed -i 's/https:\/\/example.org/\//g' hugo.toml
    #COPY . .
    RUN hugo

FROM nginx:alpine AS nginx
    WORKDIR /usr/share/nginx/html
    COPY --from=site /site/public/ .
    COPY --from=site /site/resources/_gen/ .
    EXPOSE 80
