FROM cypress/base:16.0.0

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb -y

RUN curl -Lo /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux && chmod +x /usr/local/bin/sops && \
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv && ln -s $HOME/.nodenv/bin/nodenv /usr/local/bin/nodenv && \
  mkdir -p "$(nodenv root)"/plugins && git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

