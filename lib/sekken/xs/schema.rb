require 'sekken/xs/types'

class Sekken
  class XS
    class Schema

      def initialize(schema, schemas)
        @schema = schema
        @schemas = schemas

        @target_namespace     = @schema['targetNamespace']
        @element_form_default = @schema['elementFormDefault'] || 'unqualified'

        @attributes       = {}
        @attribute_groups = {}
        @elements         = {}
        @complex_types    = {}
        @simple_types     = {}
        @imports          = {}
        @includes         = []

        parse
      end

      attr_accessor :target_namespace, :element_form_default, :imports, :includes,
                    :attributes, :attribute_groups, :elements, :complex_types, :simple_types


      def merge schema
        @attributes.merge! schema.attributes unless @attributes.nil?
        @attributes_groups.merge! schema.attribute_groups unless @attributes_groups.nil?
        @elements.merge! schema.elements unless @elements.nil?
        @complex_types.merge! schema.complex_types unless @complex_types.nil?
        @simple_types.merge! schema.simple_types unless @simple_types.nil?
        
      end
      
      private

      def parse
        schema = {
          :target_namespace => @target_namespace,
          :element_form_default => @element_form_default
        }
        
        @schema.element_children.each do |node|
          case node.name
          when 'attribute'      then store_element(@attributes, node, schema)
          when 'attributeGroup' then store_element(@attribute_groups, node, schema)
          when 'element'        then store_element(@elements, node, schema)
          when 'complexType'    then store_element(@complex_types, node, schema)
          when 'simpleType'     then store_element(@simple_types, node, schema)
          when 'import'         then store_import(node)
          when 'include'        then store_include(node)
          end
        end
      end

      def store_element(collection, node, schema)
        collection[node['name']] = XS.build(node, @schemas, schema)
      end

      def store_import(node)
        @imports[node['namespace']] = node['schemaLocation']
      end

      def store_include node
        @includes.push node['schemaLocation']
      end
      
    end
  end
end
