<p align="center">
  <img src="gdpr.png" alt="Gdpr Icon"/>
</p>

# Gdpr

[![Gem Version](https://badge.fury.io/rb/gdpr-ruby.svg)](http://badge.fury.io/rb/gdpr-ruby)

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [TODO](#todo)
  - [Features](#features)
    - [Installing](#installing)
    - [Configuration](#configuration)
    - [Rails generator](#rails-generator)
    - [Schema less](#schema-less)
    - [Linting](#linting)
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
- [ ] Remove Thor from gemspec & cli
- [ ] Make sure gdpr-ruby name change works: add spec skeleton
- [ ] Setup combustion
- [ ] test DB + User model + assocations (belongs_to, has_many)

Refactorings
- [ ] Split core logic + DSL and make it independant from Rails. Add core-ext if `activesupport` is not defined. Use [dry constantize](https://rubydoc.info/gems/dry-inflector/Dry/Inflector#constantize-instance_method)

DSL
```ruby

```
### Installing

#### Rails application

* Add this gem to your Gemfile (you may make the gem available for all environments)

```rb
  gem "gdpr-ruby"
```

* Run `rails generate gdpr:install` *Coming soon!*
* Run `rails generate gdpr User` *Coming soon!*
* Run `rspec spec/models/gdpr_linter_spec.rb` and update your gdpr definitions until linter is green.


### Configuration

*Coming soon!*

### Schema less

You can define gdpr models for your schemaless models (e.g. PG Jsonb fields).
However, `gdpr-ruby` will not be able to lint these models.

## Features

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
