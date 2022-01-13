FROM cypress/included:9.2.0

# Install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
  apt-get update -y && \
  apt-get install -y google-cloud-sdk libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# Install SOPS
RUN curl -Lo /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux && chmod +x /usr/local/bin/sops && \
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv && ln -s $HOME/.nodenv/bin/nodenv /usr/local/bin/nodenv && \
  mkdir -p "$(nodenv root)"/plugins && git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# Install chrome
RUN apt-get -y install fonts-liberation xdg-utils && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i google-chrome-stable_current_amd64.deb && \
  rm google-chrome-stable_current_amd64.deb

ENV LANG=C.UTF-8 PATH=/root/.asdf/bin:/root/.asdf/shims:$PATH

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.9.0 && \
  echo . $HOME/.asdf/asdf.sh >> $HOME/.bashrc && \
  echo . $HOME/.asdf/completions/asdf.bash >> $HOME/.bashrc && \
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
  echo legacy_version_file = yes > $HOME/.asdfrc

ENTRYPOINT []