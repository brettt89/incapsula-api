#!/bin/bash -e

if [ ! -x "$(command -v docker)" ]; then
    echo "Docker is required to build YAML file."
    echo "Go to https://www.docker.com to install docker"
    exit 1
fi

echo "Building Incapsula API v1 OpenAPI YAML file"

DEBUG=false
if [ "$1" = "--debug" ]; then
    DEBUG=true
fi

if [ ! -d "build/" ]; then
    mkdir build
fi

BASE_YAML='src/Base.yaml'
echo
echo "Base.yaml file:"
echo " - ${BASE_YAML}"

TAGS=()
while IFS=  read -r -d $'\0'; do
    TAGS+=("$REPLY")
done < <(find src/ -name "Tags.yaml" -print0)

echo
echo "Tags.yaml files:"
printf ' - %s\n' "${TAGS[@]}"

PATHS=()
while IFS=  read -r -d $'\0'; do
    PATHS+=("$REPLY")
done < <(find src/ -name "Paths.yaml" -print0)

echo
echo "Paths.yaml files:"
printf ' - %s\n' "${PATHS[@]}"

COMPONENTS=()
while IFS=  read -r -d $'\0'; do
    COMPONENTS+=("$REPLY")
done < <(find src/ -name "Components.yaml" -print0)

echo
echo "Components.yaml files:"
printf ' - %s\n' "${COMPONENTS[@]}"

echo
echo "Parsing ${BASE_YAML} into build/Base.yaml"
docker run -it -v ${PWD}:/data luislavena/yaml-combiner --out build/Base.yaml $BASE_YAML
echo "Combining 'Tags' into build/Tags.yaml"
docker run -it -v ${PWD}:/data luislavena/yaml-combiner --out build/Tags.yaml ${TAGS[@]}
echo "Combining 'Paths' into build/Paths.yaml"
docker run -it -v ${PWD}:/data luislavena/yaml-combiner --out build/Paths.yaml ${PATHS[@]}
echo "Combining 'Components' into build/Components.yaml"
docker run -it -v ${PWD}:/data luislavena/yaml-combiner --out build/Components.yaml ${COMPONENTS[@]}

echo
BUILD_YAML=$(find build/ -maxdepth 1 -name '*.yaml' -exec echo {} +)

echo "Building IncapsulaAPIv1.yaml"
docker run -it -v ${PWD}:/data luislavena/yaml-combiner --out IncapsulaAPIv1.yaml ${BUILD_YAML}

echo
echo "Cleaning up build/ directory"

if [ "$DEBUG" != true ]; then
    rm -rf build/
else
    echo " --skipped (DEBUG)"
fi