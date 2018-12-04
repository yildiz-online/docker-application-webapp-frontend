FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone --single-branch -b master https://github.com/yildiz-online/repo-web.git

FROM moussavdb/build-nodejs as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/repo-web /app
RUN yarn install
RUN ng build --prod

FROM nginx
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
COPY --from=build /app/dist /usr/share/nginx/html