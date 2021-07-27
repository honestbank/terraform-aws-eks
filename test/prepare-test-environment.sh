# #########################
# Set environment variables
# #########################

# #############################
# Download and install pre-reqs
# #############################

# Github Runner - supports passwordless sudo
if command -v sudo; then
  sudo apt-get update
fi

# nektos/act - doesn't have sudo
if ! command -v sudo; then
  apt-get update
  apt-get install -y sudo
fi

if ! command -v git; then
  apt-get install -y git
fi

if ! command -v go; then
  cd /tmp || mkdir /tmp && cd /tmp
  wget -O go.tgz https://dl.google.com/go/go1.15.1.linux-amd64.tar.gz
  tar -C /usr/local -xvf go.tgz
  export PATH="/usr/local/go/bin:$PATH"
  export GOPATH=/opt/go/
  export PATH=$PATH:$GOPATH/bin
fi

if ! command -v unzip; then
 apt-get install -y unzip
fi

if ! command -v terraform; then
  curl -O https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
  unzip terraform_0.14.2_linux_amd64.zip
  mv terraform /usr/bin
  terraform version || return
fi
