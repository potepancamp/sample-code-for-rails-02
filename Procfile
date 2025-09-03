web: bundle exec rails server -p $PORT
release: yarn install && yarn build && yarn build:css && bundle exec rails assets:precompile && bundle exec rails db:migrate
