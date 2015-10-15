require "pluck_rdoc/version"

require 'rdoc'
require 'erb'

module RDoc
  module Generator
    class Pluck
      ::RDoc::RDoc.add_generator self

      def initialize(store, options)
        @store = store
        @options = options
      end

      def generate
        @methods = @store.all_classes_and_modules.uniq.map(&:method_list).flatten

        File.open('index.html', 'w') do |file|
          file << ERB.new(File.read(template_path)).result(binding)
        end
      end

      def class_dir; nil; end
      def file_dir; nil; end

      private

      def template_path
        File.join(File.dirname(__FILE__), 'pluck.html.erb')
      end
    end
  end
end