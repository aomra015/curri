# Landing Page for www.curriapp.com

## Getting Started

1. `$ bundle install`
1. `$ jekyll serve --watch`

Then just go to `localhost:4000` and you will see the site. Any changes that you make should be visible without needing to restart the Jekyll server.

## Editing CSS

CSS is written in Sass and compiled to CSS. You need to have Sass installed. We use the `sass-globbing` gem to import all files in a given folder, to be able to conveniently write modular CSS. Once you have Sass installed (`$ gem install sass`), navigate to `assets/css` in your terminal and enter the following command:
```
$ sass -r sass-globbing -w .
```
This command watches the directory for any changes to `style.scss` and compiles it to `style.css`.