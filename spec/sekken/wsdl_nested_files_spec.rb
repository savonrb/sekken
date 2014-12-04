require 'spec_helper'

describe Sekken::WSDL do
  describe 'with local files and imported wsdl' do
    it 'does not fail to create the wsdl' do
      expect{Sekken::WSDL.new(fixture('wsdl/import'), http_mock)}.to_not raise_error
    end
  end
end
