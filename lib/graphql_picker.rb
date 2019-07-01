require "graphql_picker/version"
require 'pry'
require 'graphql'

module GraphqlPicker

  class Picker
    def initialize(options)
      @name = options[:name]
      @path = options[:path] || "./"
    end

    def pick
      concat_string = ""
      search_files.each do |file|
        string = File.read(file)
        concat_string += string
      end
      parsed = parse(concat_string)
      target = search_by_name(@name, parsed.definitions)
      fragments = search_included_fragment(target)

      results = []
      results << "# #{search_file(target.name)}"
      results << target.to_query_string
      Array(fragments.keys).each do |fragment_name|
        results << "# #{search_file(fragment_name)}"
        results << search_by_name(fragment_name, parsed.definitions).to_query_string
      end
      results.join("\n")
    end

    def search_file(name)
      search_files.each do |file|
        string = File.read(file)
        parsed = parse(string)
        if search_by_name(name, parsed.definitions)
          return file.to_s
        end
      end
      nil
    end

    def search_by_name(name, definitions)
      definitions.each do |definition|
        if definition.respond_to?(:name)
          if name == definition.name
            return definition
          end
        elsif definition.respond_to?(:selections)
          if (obj = search_by_name(name, definition.selections)) && !obj.nil?
            return obj
          end
        end
      end
      nil
    end

    def search_included_fragment(definition, result = {})
      r = result
      if definition.is_a?(GraphQL::Language::Nodes::FragmentSpread)
        r[definition.name] = definition
      end
      if definition.respond_to?(:selections)
        definition.selections.each do |selection|
          r.merge(search_included_fragment(selection, r))
        end
      end
      return r
    end

    def search_files
      files = []
      Dir.glob("#{@path}/**/*.graphql") do |file|
        files << file
      end
      files
    end

    def parse(all)
      GraphQL.parse(all)
    end
  end


end
