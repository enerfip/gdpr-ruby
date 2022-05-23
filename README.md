<p align="center">
  <img src="gdpr.png" alt="Gdpr Icon"/>
</p>

# Gdpr

[![Gem Version](https://badge.fury.io/rb/gdpr-ruby.svg)](http://badge.fury.io/rb/gdpr-ruby)

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [TODO](#todo)
  - [Installing](#installing)
    - [Rails application](#rails-application)
    - [Configuration](#configuration)
  - [Features](#features)
    - [Schema less](#schema-less)
    - [Linting](#linting)
      - [How to use it](#how-to-use-it)
    - [Export](#export)
    - [Anonymise](#anonymise)
    - [Fake data](#fake-data)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Development](#development)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## TODO

Boilerplate
- [ ] test DB + User model + assocations (belongs_to, has_many)
- [ ] Do we really need a `config.ru` file for a Rack app???
- [ ] Remove Thor from gemspec & cli ?

Refactorings
- [ ] Split core logic + DSL and make it independant from Rails. Add core-ext if `activesupport` is not defined. Use [dry constantize](https://rubydoc.info/gems/dry-inflector/Dry/Inflector#constantize-instance_method)

DSL
```ruby

```
## Installing

### Rails application

* Add this gem to your Gemfile (you may make the gem available for all environments)

```rb
  gem "gdpr-ruby"
```

* Run `rails generate gdpr:install` *Coming soon!*
* Run `rails generate gdpr User` *Coming soon!*
* Run `rspec spec/models/gdpr_linter_spec.rb` and update your gdpr definitions until linter is green.


### Configuration

*Coming soon!*

## Features

### DSL

gdpr-ruby DSL mimics ActiveRecord's DSL so you can mirror easily your data model with Gdpr definitions.

To use DSL, include it in your Gdpr definition classes, example:

```rb
module Gdpr::Model:::User
  include Gdpr::ModeDsl

  personal do
     # defining personal attributes here
  end
 
  non_personal do
     # defining non personal attributes here (they are never exported nor anonymized)
  end
end
```

All attributes and associations of any model handling personal data will have its Gdpr definition class, namespaced `Gdpr::Model`.
So if you have a `User` model, you will need to create a `Gdpr::Model::User` class including the `Gdpr::ModelDsl` module.

And EVERY field and association MUST appear in either the `Gdpr::Model::User`'s `personal` or `non_personal` block.
Yes, the initial boilerplate may be painful, but this guarantees that no field will be forgotten when adding it to your schema.

`Gdpr::ModelDsl` provides the following class methods:

* `personal` and `non_personal`, both methods accept a block without arguments.
* `attributes`: any regular attribute except: foreign keys, files, jsonb attributes can be specified here
* `file`: each attribute that stores a file path must be specified with this method. Currently only Carrierwave is supported
* `hash`: json/jsonb data can be declared with this method, and you can specify a schema-less class to define Gdpr data inside this attribute.
* `has_many`, `has_one` and `belongs_to`: to declare associations (will infer foreign key from your ORM - only ActiveRecord supported for now)

#### Example Model Definition

```rb

class User < ApplicationRecord; end

class Gdpr::Model::User
  include Gdpr::ModelDsl

  personal do
    attributes :email, :last_sign_in_ip, :last_signed_in_at
    file :profile_picture
    has_many :comments  
    hash :settings, class: Gdpr::Model::User::Settings
  end

  non_personal do
    attributes :id, :created_at, :updated_at, :encrypted_password
  end
end
```

### Schema less

You can define gdpr models for your schemaless models (e.g. PG Jsonb fields).
However, `gdpr-ruby` will not be able to lint these models.

### Linting

Gdpr linter relies on your database schema to make sure every database fields and associations are listed either
as personal or non personal fields.

#### How to use it

Add a `_spec.rb` file  (e.g. gdpr_linter_spec.rb) in your test suite with this describe block:
```ruby
  describe "#lint" do
    Gdpr:::Linter.lint.each do |kls, response|
      specify "#{kls} model gdpr definition" do
        expect(response.errors).to be_empty, "#{kls}: #{response.errors.inspect}"
      end
    end
  end
```

### Export
- JSON
- user files zipped
- AWS Zip

### Anonymise

*Coming soon!*
### Fake data

*Coming soon!*
## Requirements

1. [Ruby](https://www.ruby-lang.org)
2. Rails

## Setup

To install, run:

```
    gem install gdpr-ruby
```

## Usage

## Development

To contribute, run:

    git clone https://github.com/enerfip/gdpr-ruby.git
    cd gdpr-ruby
    bin/setup

You can also use the IRB console for direct access to all objects:

    bin/console

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2022 []().
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://www.alchemists.io/projects/gemsmith).

## Credits

Developed by [Arnaud Sellenet](https://www.github.com/enerfip-dev) at [Enerfip](https://www.enerfip.fr).
