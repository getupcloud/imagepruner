# OpenShift Pruner
Keep your registry clean pruning builds, deployments and images.

**Atention:**

This is a experimental image, it intents to remove objects from the cluster!, **use at your own risk!!**
For more information, please see the [documentation](https://docs.openshift.org/latest/admin_guide/pruning_resources.html)


##Instalation:
You can either use our image from [dockerhub](https://hub.docker.com/r/getupcloud/imagepruner) or build at your local machine:

To use our image:
 ```
 $ docker pull getupcloud/imagepruner:latest
 ```

To build the image:

  ```
  $ git clone https://github.com/getupcloud/imagepruner.git
  $ cd imagepruner
  $ docker build -t imagepruner:latest .
  ```

##Requirements:
This image expects you have a service account with cluster-admin privileges. Please for more information see the official [documentation](https://docs.openshift.org/latest/architecture/additional_concepts/authorization.html#roles)

## Create Supporting ServiceAccounts

The image must run under a service account defined as follows:

  ```
  $ oc create -f - -n default <<EOF
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    name: image-pruner
  secrets:
  - name: image-pruner
  EOF

  $ oc policy add-role-to-user cluster-admin \
      system:serviceaccount:deafult:image-pruner
  ```

Note: change `:default:` above to match the project name.



  