FROM ruby:3.0.1
LABEL author.name="Issac"\
      author.email="tran.chi.vi@moneyforward.vn"
RUN apt-get update && \
    apt-get install -y nodejs nano vim nginx
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV APP_PATH /my_all
WORKDIR $APP_PATH
COPY Gemfile Gemfile.lock $APP_PATH/
RUN bundle install --without production --retry 2 \
    --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1`
COPY . $APP_PATH
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

