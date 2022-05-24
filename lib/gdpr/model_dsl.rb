module Gdpr
  module ModelDsl
    def self.included(kls)
      kls.extend ClassMethods
    end

    module ClassMethods
      def personal(&block)
        with_options(type: :personal, &block)
      end

      def non_personal(&block)
        with_options(type: :non_personal, &block)
      end

      def file(field, driver: nil, type:)
        if type == :personal
          raise "File driver is required for personal files" if driver.blank?
          personal_file(field, driver: driver)
        else
          non_personal_file(field)
        end
      end

      def attributes(*fields, type:)
        public_send("#{type}_attributes", *fields)
      end

      def hash(field, model: nil, type:)
        if type == :personal
          personal_hash(field, model: model)
        else
          non_personal_hash(field)
        end
      end

      def has_many(field, model: nil, type:)
        if type == :personal
          personal_has_many(field, model: model)
        else
          non_personal_has_many(field)
        end
      end

      def has_one(field, model: nil, type:)
        if type == :personal
          personal_has_one(field, model: model)
        else
          non_personal_has_one(field)
        end
      end

      def belongs_to(field, model: nil, type:)
        if type == :personal
          personal_belongs_to(field, model: model)
        else
          non_personal_belongs_to(field)
        end
      end

      def personal_attributes(*fields)
        @personal_attributes ||= []
        @personal_attributes += fields if fields.any?
        @personal_attributes
      end

      def non_personal_attributes(*fields)
        @non_personal_attributes ||= []
        @non_personal_attributes += fields if fields.any?
        @non_personal_attributes
      end

      def personal_file(file = nil, driver: nil)
        personal_files << [file, driver] if file.present?
        personal_files
      end

      def non_personal_file(file = nil)
        non_personal_files << file
      end

      def personal_files
        @personal_files ||= []
      end

      def non_personal_files
        @non_personal_files ||= []
      end

      def personal_hash(field, model:)
        personal_hashes << [field, model]
      end

      def non_personal_hash(field)
        non_personal_hashes << field
      end

      def personal_hashes
        @personal_hashes ||= []
      end

      def non_personal_hashes
        @non_personal_hashes ||= []
      end

      def personal_has_many(association, model:)
        personal_has_manies << [association, model]
      end

      def personal_has_manies
        @personal_has_manies ||= []
      end

      def non_personal_has_many(association)
        non_personal_has_manies << association
      end

      def non_personal_has_manies
        @non_personal_has_manies ||= []
      end

      def personal_has_one(association, model:)
        personal_has_ones << [association, model]
      end

      def personal_has_ones
        @personal_has_ones ||= []
      end

      def non_personal_has_one(association)
        non_personal_has_ones << association
      end

      def non_personal_has_ones
        @non_personal_has_ones ||= []
      end

      def personal_belongs_to(association, model:)
        personal_belongs_tos << [association, model]
      end

      def personal_belongs_tos
        @personal_belongs_tos ||= []
      end

      def non_personal_belongs_to(association)
        non_personal_belongs_tos << association
      end

      def non_personal_belongs_tos
        @non_personal_belongs_tos ||= []
      end
    end
  end
end
