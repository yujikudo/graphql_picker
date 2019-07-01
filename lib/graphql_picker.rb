require "graphql_picker/version"
require 'pry'
require 'graphql'

module GraphqlPicker

  class Picker
    def initialize(name, path="./", extensions = [])
      @name = name
      @path = path
      @extensions = extensions
    end

    def pick
      concat_string = ""
      search_files.each do |file|
        string = File.read(file)
        concat_string += string
      end
      parsed = parse(concat_string)
      target = search_name(@name, parsed.definitions)
      fragments = search_included_fragment(target)

      puts target.to_query_string
      Array(fragments.keys).each do |fragment_name|
        puts search_name(fragment_name, parsed.definitions).to_query_string
      end
    end

    def search_name(name, definitions)
      definitions.each do |definition|
        if definition.respond_to?(:name)
          if name == definition.name
            return definition
          end
        elsif definition.respond_to?(:selections)
          if (obj = search_name(name, definition.selections)) && !obj.nil?
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

  def self.execute(name, path = "./", extensions = [])
    picker = GraphqlPicker::Picker.new(name, path, extensions)
    picker.pick
  end


end
