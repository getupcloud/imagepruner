FROM openshift/origin:latest

MAINTAINER Diego Castro <diego.castro@getupcloud.com>

ENV BIN_DIR=/opt/pruner \
    KUBECONFIG=/etc/deploy/.kubeconfig \
    WRITE_KUBECONFIG=1

RUN mkdir -p ${BIN_DIR} && chmod 777 ${BIN_DIR}

COPY . ${BIN_DIR}

WORKDIR ${BIN_DIR}

ENTRYPOINT ["./container-entrypoint"]
CMD ["./run"]

USER 1000
