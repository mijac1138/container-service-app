# ContainerServiceApp

Gem for Class that is used to encapsulte behavior for container services

## IMPORTANT
Since this gem will be used only in Container service it is built with expectation that has access to ENV variables of the service

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'container_service_app', git: 'git@github.com:mijac1138/container-service-app.git', branch: 'master'
```

And then execute:

    $ bundle

In Container service application in app.rb:

  ```ruby
  require 'container_service_app'

  class App < ContainerServiceApp::App # <= inherits all behavior from App class in this gem
    route do |r|
      r.on '' do
      r.is do
        r.get do
          # ADD SERVICE LOGIC HERE
        end
      end
    end
  end
  ```
