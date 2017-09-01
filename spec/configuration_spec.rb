require 'spec_helper'

describe Workflow::Configuration do
  let(:configuration) { Workflow::Configuration.new }

  [
    :access_token,
    :space_name
  ].each do |attribute|
    it "has a #{attribute} attribute" do
      configuration.public_send(:"#{attribute}=", attribute.to_s)
      expect(configuration.public_send(attribute.to_s)).to eq attribute.to_s
    end
  end

  describe 'initialize' do
    it 'sets key attributes provided as a hash' do
      configuration = Workflow::Configuration.new(
        access_token: 'some_access_token',
        space_name: 'some_space_name'
      )

      expect(configuration.access_token).to eq('some_access_token')
      expect(configuration.space_name).to eq('some_space_name')
    end
  end


  describe '#attributes=' do
    it 'ignores unknown attributes' do
      configuration.attributes = {
        access_token: 'some_access_token',
        space_name: 'some_space_name',
        some_attribute_1: 'some_value_1',
        some_attribute_2: 'some_value_2'
      }

      expect(configuration.instance_variable_get('@some_attribute_1')).to be nil
      expect(configuration.instance_variable_get('@some_attribute_2')).to be nil
    end

    context 'when access token is invalid' do
      it 'raises specific error if access token is blank string' do
        expect do
          configuration.attributes = {
            access_token: '',
            space_name: 'some_space_name'
          }
        end.to raise_error(
          Workflow::ConfigurationError, 'access_token must be a filled string'
        )
      end

      it 'raises specific error if access token is not string' do
        expect do
          configuration.attributes = {
            access_token: Object.new,
            space_name: 'some_space_name'
          }
        end.to raise_error(
          Workflow::ConfigurationError, 'access_token must be a filled string'
        )
      end
    end

    context 'when space name is invalid' do
      it 'raises specific error if space name is not string' do
        expect do
          configuration.attributes = {
            access_token: 'some_access_token',
            space_name: Object.new
          }
        end.to raise_error(
          Workflow::ConfigurationError, 'space_name must be a filled string'
        )
      end

      it 'raises specific error if space name is blank string' do
        expect do
          configuration.attributes = {
            access_token: 'some_access_token',
            space_name: Object.new
          }
        end.to raise_error(
          Workflow::ConfigurationError, 'space_name must be a filled string'
        )
      end
    end
  end

  describe '#access_token=' do
    context 'when access token is valid' do
      it 'assignes access token' do
        configuration.access_token = 'some_access_token'
        expect(configuration.access_token).to eq('some_access_token')
      end
    end

    context 'when access token is invalid' do
      it 'raises specific error if access token is blank string' do
        expect { configuration.access_token = '' }.to raise_error(
          Workflow::ConfigurationError, 'access_token must be a filled string'
        )
      end

      it 'raises specific error if access token is not string' do
        expect { configuration.access_token = Object.new }.to raise_error(
          Workflow::ConfigurationError, 'access_token must be a filled string'
        )
      end
    end
  end

  describe '#space_name=' do
    context 'when space name is valid' do
      it 'assignes space name' do
        configuration.space_name = 'some_space_name'
        expect(configuration.space_name).to eq('some_space_name')
      end
    end

    context 'when space name is invalid' do
      it 'raises specific error if space name is blank string' do
        expect { configuration.space_name = '' }.to raise_error(
          Workflow::ConfigurationError, 'space_name must be a filled string'
        )
      end

      it 'raises specific error if space name is not string' do
        expect { configuration.space_name = Object.new }.to raise_error(
          Workflow::ConfigurationError, 'space_name must be a filled string'
        )
      end
    end
  end

  describe '#credentials?' do
    it 'raises specific error if credentials are not specified completely' do
      expect { configuration.credentials? }.to raise_error(
        Workflow::ConfigurationError, 'access_token is not specified, '\
          'space_name is not specified'
      )
    end
  end
end
