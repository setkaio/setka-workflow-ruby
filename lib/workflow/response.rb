module Workflow
  class Response
    attr_reader :code, :headers, :body

    def initialize(raw_response)
      @code = raw_response.status
      @body = raw_response.body
      @headers = raw_response.headers
    end
  end
end
