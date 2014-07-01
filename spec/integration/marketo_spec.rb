require 'spec_helper'

describe 'Integration with Marketo Marketo Automation Software' do

 subject(:client) { Sekken.new fixture('wsdl/marketo') }

 let(:service_name) { :MktMktowsApiService }
 let(:port_name)    { :MktowsApiSoapPort }

 it 'returns header parts' do
   operation = client.operation(service_name, port_name, :getLead)
   expect(operation.example_header).to eq({
     AuthenticationHeader: {
      mktowsUserId: "string", 
      requestSignature: "string",
      requestTimestamp: "string",
      audit: "string",
      mode: "int" 
     }
   })
 end

 it 'creates an example body' do
   operation = client.operation(service_name, port_name, :getLead)

   expect(operation.example_body).to eq({
     paramsGetLead: {
       leadKey: {
         keyType: 'string',
         keyValue: 'string'
       }
     }
   })
 end

 it 'builds a request' do
   operation = client.operation(service_name, port_name, :getLead)
   
   operation.header = {
     AuthenticationHeader: {
       mktowsUserId: 'bigcorp1_461839624B16E06BA2D663',
       requestSignature: "ffbff4d4bef354807481e66dc7540f7890523a87",
       requestTimestamp: '2013-07-30T14:15:06-07:00'
     }
   }

   operation.body = {
     paramsGetLead: {
       leadKey: {
         keyType: "EMAIL",
         keyValue: "rufus@marketo.com"
       }
     }
   }

   expected = Nokogiri.XML(%{
     <SOAP-ENV:Envelope 
       xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
       xmlns:ns1="http://www.marketo.com/mktows/">
       <SOAP-ENV:Header>
         <ns1:AuthenticationHeader>
           <mktowsUserId>bigcorp1_461839624B16E06BA2D663</mktowsUserId>
           <requestSignature>ffbff4d4bef354807481e66dc7540f7890523a87</requestSignature>
           <requestTimestamp>2013-07-30T14:15:06-07:00</requestTimestamp>
         </ns1:AuthenticationHeader>
       </SOAP-ENV:Header>
       <SOAP-ENV:Body>
         <ns1:paramsGetLead>
           <leadKey>
             <keyType>EMAIL</keyType>
             <keyValue>rufus@marketo.com</keyValue>
           </leadKey>
        </ns1:paramsGetLead>
       </SOAP-ENV:Body>
     </SOAP-ENV:Envelope>
   })

   expect(Nokogiri.XML operation.build).
     to be_equivalent_to(expected).respecting_element_order
 end

end
