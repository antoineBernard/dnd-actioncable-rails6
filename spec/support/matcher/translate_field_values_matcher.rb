# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :translate_field_values do |field_value, options = {}|
  translation_missing = /\Atranslation missing:/
  options[:in] = [options[:in] || I18n.available_locales].flatten
  options[:new_instance] ||= ->(_, value, object_class) { object_class.new(field_value.to_sym => value) }

  match do |actual|
    @problems = []
    options[:in].none? do |locale|
      I18n.with_locale locale do
        collection = actual.send(:"#{field_value}_collection")
        missing_in_collection?(collection, locale) ||
          missing_in_class_field?(collection.values, locale, actual, field_value) ||
          missing_in_instance_field?(collection.values, locale, actual, field_value)
      end
    end
  end

  define_method :missing_in_collection? do |collection, locale|
    missing = collection.select { |value, _| value =~ translation_missing }.values
    @problems << "- missing #{missing} in #{locale} (collection)" if missing.any?
    missing.any?
  end

  define_method :missing_in_class_field? do |values, locale, actual, field|
    missing = values.select { |value| actual.send(field, value) =~ translation_missing }
    @problems << "- missing #{missing} in #{locale} (class field)" if missing.any?
    missing.any?
  end

  define_method :missing_in_instance_field? do |values, locale, actual, field|
    missing = values.select { |value| new_instance_value_for(actual, field, value) =~ translation_missing }
    @problems << "- missing #{missing} in #{locale} (instance field)" if missing.any?
    missing.any?
  end

  define_method :new_instance_value_for do |actual, field, value|
    actual.new(options[:new_instance].call(field.to_sym, value, actual.object_class)).send(field)
  end

  description do
    "translate #{field} values in #{options[:in]}"
  end

  failure_message do |field|
    "expected that field #{field} would be translated in #{options[:in]}\n" +
      @problems.join("\n")
  end
end
