FROM ruby:3.0.1

LABEL author.name="Issac"\
      author.email="tran.chi.vi@moneyforward.vn"

RUN apt-get update && \
    apt-get install -y nodejs nano vim nginx npm

RUN npm install -g yarn

ENV TZ=Asia/Ho_Chi_Minh

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV APP_PATH /my_all

WORKDIR $APP_PATH

COPY docker/entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

COPY Gemfile Gemfile.lock ./

RUN gem install rails

EXPOSE 3000