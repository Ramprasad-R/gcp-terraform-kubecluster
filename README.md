## Terraform CFT to setup Kubernetes Cluster in GCP VM Instance

### Replace credential json file name in provider.tf and packer.json

ssh-keygen -f gcpkey

chmod +x kube-setup.sh

./kube-setup.sh

### To create a Image with required package for setting up master node

packer build packer.json
