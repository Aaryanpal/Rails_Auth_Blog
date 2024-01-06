# frozen_string_literal: true

module Api::V1::Services
    module Errors
      class UnAuthorizedRequest < StandardError
        def initialize(msg = "Unauthorized User")
          super(msg)
        end
      end
  
      class ParamsEmpty < StandardError
        def initialize(msg = "Params are empty")
          super(msg)
        end 
      end
  
      class ParamsMissing < StandardError
        def initialize(msg = "Missing Params")
          super(msg)
        end
      end
  
      class CustomError < StandardError
        attr_reader :error_code
  
        def initialize(msg = "Something Went Wrong", error_code = 500)
          super(msg)
          @error_code = error_code
        end
      end
    end
end