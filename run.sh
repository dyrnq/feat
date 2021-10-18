#!/usr/bin/env bash
while read -r line; do
    # from https://serverfault.com/questions/417241/extract-repository-name-from-github-url-in-bash

    if grep "," <<< "${line}" >& /dev/null; then
        url=$(cut -d, -f1 <<< "${line}")
        shortname=$(cut -d, -f2 <<< "${line}")
    else
        url=$line
        shortname=""
    fi

    re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+)"

    if [[ $url =~ $re ]]; then    
        # protocol=${BASH_REMATCH[1]}
        # separator=${BASH_REMATCH[2]}
        # hostname=${BASH_REMATCH[3]}
        user=${BASH_REMATCH[4]}
        repo=${BASH_REMATCH[5]}
        # echo $repo
        # echo $user
        if [ "x" = "${shortname}x" ]; then
            shortname=$repo
        fi
    fi


    curl --retry 3 -fsSL "https://api.github.com/repos/${user}/${repo}/releases?per_page=100" | jq -r '.[].tag_name' > "${shortname}".txt

    unset shortname
    unset url
done < 000-list.txt





# exit 0
# curl --retry 3 -fsSL "https://api.github.com/repos/goharbor/harbor/releases?per_page=100" | jq -r '.[].tag_name' > harbor.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/docker/buildx/releases?per_page=100" | jq -r '.[].tag_name' > buildx.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/fluxcd/flagger/releases?per_page=100" | jq -r '.[].tag_name' > flagger.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/containers/podman/releases?per_page=100" | jq -r '.[].tag_name' > podman.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/flannel-io/flannel/releases?per_page=100" | jq -r '.[].tag_name' > flannel.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/istio/istio/releases?per_page=100" | jq -r '.[].tag_name' > istio.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/just-containers/s6-overlay/releases?per_page=100" | jq -r '.[].tag_name' > s6-overlay.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/moby/buildkit/releases?per_page=100" | jq -r '.[].tag_name' > buildkit.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/containers/buildah/releases?per_page=100" | jq -r '.[].tag_name' > buildah.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/moby/moby/releases?per_page=100" | jq -r '.[].tag_name' > moby.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/AliyunContainerService/image-syncer/releases?per_page=100" | jq -r '.[].tag_name' > image-syncer.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/tektoncd/pipeline/releases?per_page=100" | jq -r '.[].tag_name' > tekton.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/argoproj/argo-cd/releases?per_page=100" | jq -r '.[].tag_name' > argo-cd.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/argoproj/argo-rollouts/releases?per_page=100" | jq -r '.[].tag_name' > argo-rollouts.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/triton-io/triton/releases?per_page=100" | jq -r '.[].tag_name' > triton.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/openkruise/kruise/releases?per_page=100" | jq -r '.[].tag_name' > kruise.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/fluxcd/flux2/releases?per_page=100" | jq -r '.[].tag_name' > flux2.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/fluxcd/flux/releases?per_page=100" | jq -r '.[].tag_name' > flux.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/containers/skopeo/releases?per_page=100" | jq -r '.[].tag_name' > skopeo.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/apache/apisix/releases?per_page=100" | jq -r '.[].tag_name' > apisix.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/apache/apisix-dashboard/releases?per_page=100" | jq -r '.[].tag_name' > apisix-dashboard.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/containernetworking/plugins/releases?per_page=100" | jq -r '.[].tag_name' > cni-plugins.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/etcd-io/etcd/releases?per_page=100" | jq -r '.[].tag_name' > etcd.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/cloudflare/cfssl/releases?per_page=100" | jq -r '.[].tag_name' > cfssl.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/docker/compose/releases?per_page=100" | jq -r '.[].tag_name' > docker-compose.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/kubernetes/kubernetes/releases?per_page=100" | jq -r '.[].tag_name' > kubernetes.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/containerd/containerd/releases?per_page=100" | jq -r '.[].tag_name' > containerd.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/helm/helm/releases?per_page=100" | jq -r '.[].tag_name' > helm.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/kubernetes-sigs/cri-tools/releases?per_page=100" | jq -r '.[].tag_name' > cri-tools.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/containerd/nerdctl/releases?per_page=100" | jq -r '.[].tag_name' > nerdctl.txt
# curl --retry 3 -fsSL "https://api.github.com/repos/kubernetes-sigs/kustomize/releases?per_page=100" | jq -r '.[].tag_name' > kustomize.txt

