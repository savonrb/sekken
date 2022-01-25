require 'spec_helper'

describe 'Integration with Geotrust' do

  subject(:client) { Sekken.new fixture('wsdl/geotrust') }

  it 'knows the operations' do
    pending "this fixture is missing a message element! " \
            "find out if we need to handle this case or if the fixture is incomplete."

    operation = client.operation('GetQuickApproverList')
    expect(operation.name).to eq('THIS-TEST-FAILS')
    expect(operation.endpoint).to eq('https://test-api.geotrust.com:443/webtrust/query.jws')
  end

end
