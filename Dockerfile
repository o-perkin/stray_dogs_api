FROM ruby:2.7.1

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list \
  && sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list \
  && sed -i '/buster-updates/d' /etc/apt/sources.list \
  && apt-get update -o Acquire::Check-Valid-Until=false -qq \
  && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    postgresql-client \
    shared-mime-info \
  && npm install -g yarn \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle update mimemagic && bundle install

COPY . .

CMD ["bash"]
