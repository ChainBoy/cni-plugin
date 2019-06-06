TAG="v1.0.0"
export REGISTRY="REGISTRYHOST"

echo $REGISTRY | grep -q REGISTRYHOST && echo please change REGISTRYHOST to you private registry host:port && exit 1

cat > docker-daemon.json <<EOF
{
  "insecure-registries":["$REGISTRY"]
}
EOF

# create docker.json
docker login -u admin -p admin $REGISTRY
cp /root/.docker/config.json docker.json


make clean
rm -rf bin/
make image
make IMAGETAG=$TAG
make tag-images-all push-all push-manifests push-non-manifests  IMAGETAG=$TAG
