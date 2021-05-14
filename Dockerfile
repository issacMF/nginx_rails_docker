FROM ruby:3.0.1

LABEL author.name="Issac"\
    author.email="tran.chi.vi@moneyforward.vn"

RUN apt-get update && \
    apt-get install -y nodejs nano vim nginx npm

RUN npm install -g yarn

ENV TZ=Asia/Ho_Chi_Minh

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV APP_PATH /my_app

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN yarn install


RUN EDITOR="mate --wait" bundle exec rails credentials:edit


RUN chmod u+x $APP_PATH/docker/*

RUN chmod u+x $APP_PATH/docker/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["./docker/entrypoint.sh"]
