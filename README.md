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
- [ ] Do we really need a `config.ru` file for a Rack app???
- [ ] Remove Thor from gemspec & cli ?

Refactorings
- [ ] Split core logic + DSL and make it independant from Rails. Add core-ext if `activesupport` is not defined. Use [dry constantize](https://rubydoc.info/gems/dry-inflector/Dry/Inflector#constantize-instance_method)

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

`gdpr-ruby` DSL mimics ActiveRecord's DSL so you can mirror easily your data model with matching GDPR definitions.

By convention, all attributes and associations of a model dealing with personal data should be defined in a matching GDPR model class, inside `Gdpr::Model` namespace. To use the DSL, simply include `Gdpr::ModelDsl`.
For example, GDPR personal data for a  `User` model will be defined in a a `Gdpr::Model::User` class.

```rb
module Gdpr::Model:::User
  include Gdpr::ModelDsl

  personal do
     # define personal data here
  end

  non_personal do
     # define non personal data here (never exported nor anonymized)
  end
end
```

Please note that EVERY attribute and association must appear in either the `personal` or `non_personal` block.
Initial boilerplate might be time consuming, but this guarantees that no attribute will be forgotten when the data model further evolves.

`Gdpr::ModelDsl` provides the following class methods:

* `personal` and `non_personal`, both methods accept a block without an argument.
* `attributes` for any regular attribute except foreign keys, files and jsonb attributes.
* `file` for attributes storing a file path. Currently only [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) is supported.
* `hash` for json/jsonb data. You can specify a schema-less class to define GDPR data inside this attribute.
* `has_many`, `has_one` and `belongs_to` to declare associations. Iit will infer foreign key from your ORM. Only ActiveRecord is supported for now.

#### Example Model Definition

```rb
# schema.rb
ActiveRecord::Schema.define do
  create_table(:users, :force => true) do |t|
    t.string :name
    t.string :email
    t.datetime :last_sign_in_at
    t.string :last_sign_in_ip
    t.string :encrypted_password
    t.string :profile_picture
    t.jsonb :settings, default: {}
    t.timestamps
  end

  create_table(:comments, :force => true) do |t|
    t.string :name
    t.integer :user_id
    t.timestamps
  end
end

# app/models/user.rb
class User < ApplicationRecord
  mount_uploader :profile_picture, FileUploader

  has_many :comments
end

# app/models/gdpr/model/user.rb
class Gdpr::Model::User
  include Gdpr::ModelDsl

  personal do
    attributes :email, :last_sign_in_ip, :last_signed_in_at
    file :profile_picture
    has_many :comments
    hash :settings, class: Gdpr::Model::Settings
  end

  non_personal do
    attributes :id, :created_at, :updated_at, :encrypted_password
  end
end

# app/models/gdpr/model/settings.rb
class Gdpr::Model::Settings
  include Gdpr::ModelDsl

  # TODO implementation
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
