require 'spec_helper'

describe Sekken::WSDL::Document do

  describe '#messages' do
    it 'works with single element parts' do
      document = get_documents('wsdl/oracle').first

      expect(document.messages.keys).to include(
        'addReportToPageIn', 'addReportToPageOut', 'applyReportDefaultsIn', 'applyReportDefaultsOut'
      )

      # message

      message = document.messages['addReportToPageIn']
      expect(message.name).to eq('addReportToPageIn')

      namespaces = {
        'xmlns:sawsoap' => 'urn://oracle.bi.webservices/v7',
        'xmlns:soap'    => 'http://schemas.xmlsoap.org/wsdl/soap/',
        'xmlns:wsdl'    => 'http://schemas.xmlsoap.org/wsdl/',
        'xmlns:xsd'     => 'http://www.w3.org/2001/XMLSchema'
      }
      # On JRuby, there are more namespaces defined.
      if defined?(JRUBY_VERSION)
        namespaces['xmlns:jaxws'] = 'http://java.sun.com/xml/ns/jaxws'
      end

      expect(message.parts).to eq([
        { :name => 'parameters', :namespaces => namespaces,
          :type => nil, :element => 'sawsoap:addReportToPage' }
      ])
    end

    it 'works with multiple type parts' do
      document = get_documents('wsdl/telefonkatalogen').first

      expect(document.messages.keys).to include(
        'sendsmsRequest', 'sendsmsResponse'
      )

      # message

      message = document.messages['sendsmsRequest']
      expect(message.name).to eq('sendsmsRequest')

      namespaces = {
        'xmlns:tns'  => 'http://bedrift.telefonkatalogen.no',
        'xmlns:xsd'  => 'http://www.w3.org/2001/XMLSchema',
        'xmlns:soap' => 'http://schemas.xmlsoap.org/wsdl/soap/',
        'xmlns'      => 'http://schemas.xmlsoap.org/wsdl/'
      }

      expect(message.parts).to eq([
        { :name => 'sender',      :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'cellular',    :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'msg',         :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'smsnumgroup', :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'emailaddr',   :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'udh',         :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'datetime',    :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'format',      :namespaces => namespaces, :type  => 'xsd:string', :element => nil },
        { :name => 'dlrurl',      :namespaces => namespaces, :type  => 'xsd:string', :element => nil }
      ])
    end
  end

  describe '#port_types' do
    it 'works with multiple bindings' do
      document = get_documents('wsdl/oracle').first

      expect(document.port_types.keys).to match_array([
        'ConditionServiceSoap', 'HtmlViewServiceSoap', 'IBotServiceSoap',
        'JobManagementServiceSoap', 'MetadataServiceSoap', 'ReplicationServiceSoap',
        'ReportEditingServiceSoap', 'SAWSessionServiceSoap', 'SecurityServiceSoap',
        'WebCatalogServiceSoap', 'XmlViewServiceSoap'
      ])

      # port type

      port_type = document.port_types['IBotServiceSoap']
      expect(port_type.name).to eq('IBotServiceSoap')

      expect(port_type.operations.keys).to match_array([
        "deleteIBot", "executeIBotNow", "moveIBot", "sendMessage",
        "subscribe", "unsubscribe", "writeIBot"
      ])

      # port type operation

      port_type_operation = port_type.operations['moveIBot']
      expect(port_type_operation.name).to eq('moveIBot')

      expect(port_type_operation.input).to eq(:name => nil, :message => 'sawsoap:moveIBotIn')
      expect(port_type_operation.output).to eq(:name => nil, :message => 'sawsoap:moveIBotOut')
    end
  end

  describe '#bindings' do
    it 'works with multiple bindings' do
      document = get_documents('wsdl/oracle').first

      expect(document.bindings.keys).to match_array([
        'ConditionService', 'HtmlViewService', 'IBotService', 'JobManagementService',
        'MetadataService', 'ReplicationService', 'ReportEditingService', 'SAWSessionService',
        'SecurityService', 'WebCatalogService', 'XmlViewService'
      ])

      # binding

      binding = document.bindings['SecurityService']

      expect(binding.name).to eq('SecurityService')
      expect(binding.port_type).to eq('sawsoap:SecurityServiceSoap')
      expect(binding.style).to eq('document')
      expect(binding.transport).to eq('http://schemas.xmlsoap.org/soap/http')

      expect(binding.operations.keys).to match_array([
        'forgetAccounts', 'getAccountTenantID', 'getAccounts', 'getGlobalPrivilegeACL',
        'getGlobalPrivileges', 'getGroups', 'getMembers', 'getPermissions', 'getPrivilegesStatus',
        'isMember', 'joinGroups', 'leaveGroups', 'renameAccounts', 'updateGlobalPrivilegeACL'
      ])

      # binding operation

      binding_operation = binding.operations['getAccounts']
      expect(binding_operation.name).to eq('getAccounts')

      expect(binding_operation.soap_action).to eq('#getAccounts')
      expect(binding_operation.style).to eq('document')
    end
  end

  describe '#services' do
    it 'works with multiple services' do
      document = get_documents('wsdl/oracle').first

      expect(document.services.keys).to match_array([
        'SAWSessionService', 'WebCatalogService', 'XmlViewService', 'SecurityService',
        'ConditionService', 'HtmlViewService', 'IBotService', 'JobManagementService',
        'MetadataService', 'ReplicationService', 'ReportEditingService'
      ])

      service = document.services['ConditionService']
      expect(service.ports.keys).to eq(['ConditionServiceSoap'])

      # soap 1.1 port

      soap_port = service.ports['ConditionServiceSoap']

      expect(soap_port.name).to eq('ConditionServiceSoap')
      expect(soap_port.binding).to eq('sawsoap:ConditionService')

      expect(soap_port.type).to eq(Sekken::NS_SOAP_1_1)
      expect(soap_port.location).to eq('https://fap0023-bi.oracleads.com/analytics-ws/saw.dll?SoapImpl=conditionService')
    end

    it 'only knows about the SOAP ports of each service' do
      document = get_documents('wsdl/email_verification').first

      expect(document.services.keys).to eq(['EmailVerNoTestEmail'])

      service = document.services['EmailVerNoTestEmail']
      expect(service.ports.keys).to match_array([
        'EmailVerNoTestEmailSoap', 'EmailVerNoTestEmailSoap12'
      ])

      # soap 1.1 port

      soap_1_1_port = service.ports['EmailVerNoTestEmailSoap']

      expect(soap_1_1_port.name).to eq('EmailVerNoTestEmailSoap')
      expect(soap_1_1_port.binding).to eq('tns:EmailVerNoTestEmailSoap')

      expect(soap_1_1_port.type).to eq(Sekken::NS_SOAP_1_1)
      expect(soap_1_1_port.location).to eq('http://ws.cdyne.com/emailverify/Emailvernotestemail.asmx')

      # soap 1.2 port

      soap_1_2_port = service.ports['EmailVerNoTestEmailSoap12']

      expect(soap_1_2_port.name).to eq('EmailVerNoTestEmailSoap12')
      expect(soap_1_2_port.binding).to eq('tns:EmailVerNoTestEmailSoap12')

      expect(soap_1_2_port.type).to eq(Sekken::NS_SOAP_1_2)
      expect(soap_1_2_port.location).to eq('http://ws.cdyne.com/emailverify/Emailvernotestemail.asmx')
    end
  end

  def get_documents(fixture)
    client = Sekken.new fixture(fixture)
    client.wsdl.documents
  end

end
