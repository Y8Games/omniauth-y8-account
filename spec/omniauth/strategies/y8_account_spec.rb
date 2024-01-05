require 'spec_helper'

describe OmniAuth::Strategies::Y8Account do
  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  subject do
    OmniAuth::Strategies::Y8Account.new({})
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('y8_account')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://account.y8.com')
    end

    it 'should have correct authorize url' do
      expect(subject.client.options[:authorize_url]).to eq('oauth/authorize')
      expect(subject.client.authorize_url).to eq('https://account.y8.com/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.client.options[:token_url]).to eq('oauth/token')
      expect(subject.client.token_url).to eq('https://account.y8.com/oauth/token')
    end

    it 'should have correct authorize options' do
      expect(subject.options.authorize_options).to eq [:scope, :display]
    end
  end

  describe '#raw_info' do
    let(:access_token) { double('AccessToken', :options => {}) }
    let(:parsed_response) { double('ParsedResponse') }
    let(:response) { double('Response', :parsed => parsed_response) }

    before do
      expect(subject).to receive(:access_token).and_return(access_token)
      expect(access_token).to receive(:get).with('/api/profile').and_return(response)
    end

    it 'should fetch info from /api/profile' do
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
        "zip" => nil,
        'city' => nil,
        'country' => nil,
        'level' => 5,
        "risk" => nil,
        "avatars" => nil,
        "version" => nil
      }
    end

    before do
      expect(subject).to receive(:raw_info).and_return(info.select{|k,v| ['email', 'level'].include?(k)}.merge('pid' => '123456')).at_least(:once)
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
      expect(subject).to receive(:request).and_return(request).at_least(:once)
      expect(subject.authorize_params).to eq({
        'meta[nickname]' => 'john',
        'state' => subject.options.authorize_params[:state],
        'prefill[alternate]' => 'Site'
      })
    end
  end
end
