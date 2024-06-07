module Ari
  module Generators
    class Property

      def initialize(name, specification)
        @name = name
        @specification = specification
      end

      def name
        @name
      end

      def required?
        @specification['required']
      end

      def type
        if is_a_list?
          @specification['type'][5..-2]
        else
          @specification['type'] == 'void' ? nil : @specification['type']
        end
      end

      def value_code(var_name)
        self.class.value_code type, var_name, is_a_list?
      end

      def self.value_code(type, var_name, list = false)
        if list
          "#{var_name}.map { |v| #{value_code(type, 'v')} }"
        elsif type == 'Date'
          "Time.parse(#{var_name})"
        elsif type == 'object'
          var_name
        else
          type + ".new(#{var_name})"
        end
      end

      def is_a_list?
        @specification['type'].start_with?('List[')
      end

      def description
        @specification['description']
      end

    end
  end
end
