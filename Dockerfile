FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone --single-branch -b master https://github.com/yildiz-online/webapp-frontend.git

FROM moussavdb/build-nodejs as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/webapp-frontend /app
RUN yarn install
RUN ng build --prod

FROM nginx:alpine
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
COPY --from=build /app/dist /usr/share/nginx/html
