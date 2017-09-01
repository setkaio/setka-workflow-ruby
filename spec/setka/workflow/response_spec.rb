require 'spec_helper'

describe Setka::Workflow::Response do
  describe 'initialize' do
    it 'has specific attributes are get from raw response' do
      body = double(:body)
      headers = double(:headers)

      raw_response = double(
        :raw_response, status: 200, headers: headers, body: body
      )

      response = Setka::Workflow::Response.new(raw_response)

      expect(response.code).to eq(200)
      expect(response.headers).to eq(headers)
      expect(response.body).to eq(body)
    end
  end
end
