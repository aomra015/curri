custom_web: bundle exec thin start --socket /tmp/web_server.sock --pid /tmp/web_server.pid -e $RACK_ENV -d
faye: rackup private_pub.ru -s thin -E production