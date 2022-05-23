# frozen_string_literal: true

require "thor"
require "thor/actions"
require "runcom"

module Gdpr
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity::VERSION_LABEL

    def self.configuration
      Runcom::Config.new "#{Identity::NAME}/configuration.yml"
    end

    def initialize(args = [], options = {}, config = {})
      super args, options, config
      @configuration = self.class.configuration
    rescue Runcom::Errors::Base => e
      abort e.message
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit,
                  aliases: "-e",
                  desc: "Edit gem configuration.",
                  type: :boolean,
                  default: false
    method_option :info,
                  aliases: "-i",
                  desc: "Print gem configuration.",
                  type: :boolean,
                  default: false
    def config
      path = configuration.current

      if options.edit? then `#{ENV.fetch("EDITOR", nil)} #{path}`
      elsif options.info?
        say(path || "Configuration doesn't exist.")
      else
        help :config
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity::VERSION_LABEL
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help(task = nil)
      say and super
    end

    private

    attr_reader :configuration
  end
end
