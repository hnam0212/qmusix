# Install flutter
FROM ghcr.io/cirruslabs/flutter:stable AS build-env

# Run flutter doctor and enable web
RUN flutter doctor
RUN flutter config --enable-web

# Copy files to container and build
USER root
RUN mkdir /app/
COPY . /app/
WORKDIR /app/

RUN flutter doctor 

RUN flutter clean
RUN flutter pub get
RUN flutter build web --release --web-renderer html 

FROM nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 80
