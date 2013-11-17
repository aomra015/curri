custom_web: bundle exec thin start --socket /tmp/web_server.sock --pid /tmp/web_server.pid -e $RACK_ENV -d
faye: bundle exec thin -R $RAILS_STACK_PATH/private_pub.ru start