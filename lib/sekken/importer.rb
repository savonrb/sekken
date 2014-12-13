require 'nokogiri'
require 'sekken/wsdl/document'

class Sekken
  class Importer

    def initialize(resolver, documents, schemas)
      @logger = Logging.logger[self]

      @resolver = resolver
      @documents = documents
      @schemas = schemas
    end

    def import(location)
      @import_locations = []

      @logger.info("Resolving WSDL document #{location.inspect}.")
      import_document(location) do |document|
        @documents << document
        @schemas.push(document.schemas)
      end

      # resolve xml schema imports
      import_schemas do |schema_location|
        @logger.info("Resolving XML schema import #{schema_location.inspect}.")
        
        import_document(schema_location) do |document|
          @schemas.push(document.schemas)
        end
      end
      
      import_included_schemas do |schema_location|
        @logger.info("Resolving included schema  #{schema_location.inspect}.")
        
        import_document(schema_location) do |document|
          document.schemas.each do |schema|
            existing = @schemas.find_by_namespace(schema.target_namespace)
            existing.merge(schema)
          end
        end
      end
    end

    private

    def import_document(location, &block)
      @logger.info("Importing #{location.inspect}.")
      if @import_locations.include? location
        @logger.warn("Skipping already imported location #{location.inspect}.")
        return
      end

      xml = @resolver.resolve(location)
      
      @import_locations << location

      document = WSDL::Document.new Nokogiri.XML(xml), @schemas
      
      block.call(document)
      
      # resolve wsdl imports
      document.imports.each do |import_location|
        @logger.info("Resolving WSDL import #{import_location.inspect}.")
        import_document(import_location, &block)
      end
    end

    def import_schemas
      @schemas.each do |schema|
        schema.imports.each do |namespace, schema_location|
          next unless schema_location

          unless @resolver.can_resolve? schema_location
            @logger.warn("Skipping XML Schema import #{schema_location.inspect}.")
            next
          end

          # TODO: also skip if the schema was already imported
          yield(schema_location)
        end
      end
    end

    def import_included_schemas
      @schemas.each do |schema|
        schema.includes.each do |include_location|
          if @resolver.can_resolve? include_location
            yield include_location
          end
        end
      end
    end

  end
end
