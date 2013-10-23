require 'spec_helper'

describe OmniAuth::Strategies::Idnet do

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  subject do
    OmniAuth::Strategies::Idnet.new({})
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('idnet')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://www.id.net')
    end

    it 'should have correct authorize url' do
      expect(subject.client.options[:authorize_url]).to eq('/oauth/authorize')
      expect(subject.client.authorize_url).to eq('https://www.id.net/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.client.options[:token_url]).to eq("/oauth/token")
      expect(subject.client.token_url).to eq('https://www.id.net/oauth/token')
    end

    it 'should have correct authorize options' do
      expect(subject.options.authorize_options).to eq [:scope, :display]
    end
  end

  describe '#raw_info' do
    let(:access_token) { stub('AccessToken', :options => {}) }
    let(:parsed_response) { stub('ParsedResponse') }
    let(:response) { stub('Response', :parsed => parsed_response) }

    before do
      subject.stub!(:access_token).and_return(access_token)
    end

    it 'should fetch info from /api/profile' do
      access_token.should_receive(:get).with('/api/profile').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end

  describe 'auth_hash' do
    let(:info) do
      {
        'email' => 'you@example.com',
        "nickname" => nil,
        'first_name' => nil,
        'last_name' => nil,
        'dob' => nil,
        'gender' => nil,
        'language' => nil,
        "state_or_province" => nil,
        "street_address" => nil,
        "zipcode" => nil,
        'city' => nil,
        'country' => nil,
        'level' => 5,
        "risk" => nil,
        "avatars" => nil,
        "version" => nil
      }
    end

    before do
      subject.stub!(:raw_info).and_return(info.select{|k,v| ['email', 'level'].include?(k)}.merge('pid' => '123456'))
    end

    it 'should return email in info' do
      expect(subject.info['email']).to eq('you@example.com')
    end

    it 'should return correct uid' do
      expect(subject.uid).to eq('123456')
    end

    it 'should return correct level' do
      expect(subject.info['level']).to eq(5)
    end

    it 'should return info' do
      expect(subject.info).to eq(info)
    end
  end

  describe 'authorize_params' do
    let!(:request) do
      Rack::Request.new({
        'QUERY_STRING' => 'client_id=123456&prefill[alternate]=Site&meta[nickname]=john',
        'rack.input' => ''
      })
    end

    it 'should include meta' do
      expect(request.params).to eq({'client_id' => '123456', 'prefill' => {'alternate' => 'Site'}, 'meta' => {'nickname' => 'john'}})
      subject.stub!(:request).and_return(request)
      expect(subject.authorize_params).to eq({
        'meta[nickname]' => 'john',
        'state' => subject.options.authorize_params[:state],
        'prefill[alternate]' => 'Site'
      })
    end
  end
end
