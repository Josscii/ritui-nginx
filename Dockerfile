FROM node:latest as build-stage
WORKDIR /app/ritui
COPY ./audit/package*.json .
RUN npm install
COPY ./audit/ .
RUN npm run build

FROM nginx:latest as production-stage
RUN mkdir -p /app/ritui
COPY --from=build-stage /app/ritui/dist /app/ritui
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080