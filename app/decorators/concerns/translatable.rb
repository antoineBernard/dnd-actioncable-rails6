# frozen_string_literal: true

module Translatable
  extend ActiveSupport::Concern

  module ClassMethods
    def self.default_options(source_class, field)
      default_translator = lambda do |value|
        value = value.to_s
        return '' if value.blank?

        I18n.t(
          "activerecord.values.#{source_class.name.underscore}.#{field}.#{value}",
          default: I18n.t(
            "values.#{field}.#{value}",
            default: I18n.t(value)
          )
        )
      end
      {
        collection: (begin
                       source_class.const_get("#{field.upcase}_VALUES")
                     rescue StandardError
                       nil
                     end),
        translator: default_translator
      }
    end

    def translate_values_of(field, options = {})
      options = Translatable::ClassMethods.default_options(object_class, field).merge options

      define_method field do
        self.class.send field, model.send(field)
      end

      define_singleton_method field, &options[:translator]

      define_singleton_method "#{field}_collection" do
        options[:collection].inject({}) do |r, value|
          r.tap { r[send(field, value)] = value }
        end
      end
    end
  end
end
