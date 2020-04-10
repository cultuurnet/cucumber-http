module Cucumber
  module Http
    module Parameters
      def parameters
        @parameters ||= {}
      end

      def add_parameter(key, value)
        parameters[key] = value
      end

      def remove_parameter(key)
        parameters.tap { |pars| pars.delete(key)}
      end

      def clear_parameters
        parameters.clear
      end
    end
  end
end
