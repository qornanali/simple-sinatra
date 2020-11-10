# Simple Model testing for Sinatra app

This is a sample source code on how you do unit testing for models in Sinatra app

## Prequisites

1. Ruby `2.5.3`

You can install it using [rbenv](https://github.com/rbenv/rbenv#installing-ruby-versions).

If you prefer another version of ruby, you are free to change it to any version you want.

It controlled via file `.ruby_version`, you can either change it manually or execute:

```console
$ rbenv local <version> # e.g rbenv local 2.5.3
```

2. Bundler `2.1.4`

You can install via Gem. For example:

```console
$ gem install bundler -v 2.1.4
```

3. Docker

You can install it via this [link](https://www.docker.com/get-started)

## Getting started

1. Installing libraries (or we called it gems)

Open this project directory, execute this command below:

```console
$ bundle config --local set path 'vendor/bundle'
$ bundle install
```

2. Provisioning needed services

Open this project directory, execute this command below:

```console
$ docker-compose up -d
```

It will run containers with installed mysql and database schema.

To stop it, execute:

```console
$ docker-compose down
```

### Running unit test

Open this project directory, execute this command below:

```console
$ bundle exec rspec -fd
```
