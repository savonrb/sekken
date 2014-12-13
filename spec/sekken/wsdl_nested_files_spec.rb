require 'spec_helper'

describe Sekken::WSDL do
  describe 'with local files and imported wsdl' do
    it 'does not fail to create the wsdl' do
      expect{Sekken::WSDL.new(fixture('wsdl/import'), http_mock)}.to_not raise_error
    end
  end

  describe 'with local files and imported wsdl with two levels of import' do
    it 'does not fail to create the sample_header' do
      client = Sekken.new fixture('wsdl/sabre/SessionCreateRQ.wsdl')
      svc = client.operation("SessionCreateRQService","SessionCreatePortType", "SessionCreateRQ");
      expect{svc.example_header}.to_not raise_error
    end
  end

  describe 'with local files and imported wsdl with two levels of import' do
    it 'does not fail to create the sample_body' do
      client = Sekken.new fixture('wsdl/sabre/SessionCreateRQ.wsdl')
      svc = client.operation("SessionCreateRQService","SessionCreatePortType", "SessionCreateRQ");
      expect{svc.example_body}.to_not raise_error
    end
  end
end
