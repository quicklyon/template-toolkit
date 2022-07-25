#!/bin/bash

APP_JSON=.template/app.json

APP_NAME="$(jq -r .Name $APP_JSON)"
APP_HOME="$(jq -r .Home $APP_JSON)"
APP_GIT_URL="$(jq -r .GitUrl $APP_JSON)"
APP_DOCKERFILE_GIT_URL="$(jq -r .DockerfileUrl $APP_JSON)"
APP_INSTALL_DOC_URL="$(jq -r .InstallDocUrl $APP_JSON)"
APP_DOCKER_IMAGE_NAME="$(jq -r .Docker.Name $APP_JSON)"
APP_DOCKER_HUB_URL="$(jq -r .Docker.Repo $APP_JSON)"
APP_DOCKER_HUB_TAG_URL="$(jq -r .Docker.TagUrl $APP_JSON)"

APP_DESC="$(cat .template/app-desc.md)"
APP_EXTRA_INFO="$(cat .template/app-extra-info.md)"
SUPPORT_TAGS="$(cat .template/support-tags.md)"
APP_ENVS="$(cat .template/app-envs.md)"
MAKE_EXTRA_INFO="$(cat .template/make-extra-info.md)"

export  APP_NAME \
        APP_HOME \
        APP_GIT_URL \
        APP_DOCKERFILE_GIT_URL \
        APP_INSTALL_DOC_URL \
        APP_DOCKER_IMAGE_NAME \
        APP_DOCKER_HUB_URL \
        APP_DOCKER_HUB_TAG_URL \
        APP_DESC \
        APP_EXTRA_INFO \
        SUPPORT_TAGS \
        APP_ENVS \
        MAKE_EXTRA_INFO

render-template .template/readme.md.tpl