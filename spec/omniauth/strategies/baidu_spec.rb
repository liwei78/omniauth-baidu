require 'spec_helper'

describe OmniAuth::Strategies::Baidu do
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  let(:enterprise_site)          { 'https://some.other.site.com/api/v3' }
  let(:enterprise_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:enterprise_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:enterprise) do
    OmniAuth::Strategies::Baidu.new('BAIDU_KEY', 'BAIDU_SECRET',
      {
        :client_options => {
          site:          enterprise_site,
          authorize_url: enterprise_authorize_url,
          token_url:     enterprise_token_url
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::Baidu.new({})
  end

  before(:each) do
    subject.stub(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://openapi.baidu.com")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('/oauth/2.0/authorize')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('/oauth/2.0/token')
    end

    describe "should be overrideable" do
      it "for site" do
        enterprise.options.client_options.site.should eq(enterprise_site)
      end

      it "for authorize url" do
        enterprise.options.client_options.authorize_url.should eq(enterprise_authorize_url)
      end

      it "for token url" do
        enterprise.options.client_options.token_url.should eq(enterprise_token_url)
      end
    end
  end

  context "#uid" do
    pending
  end

  context "#info" do
    it "should return name from raw_info if available" do
      subject.stub(:info).and_return({name: 'test'})
      subject.info[:name].should eq('test')
    end

    it "should return nil if there is no info and name access is not allowed" do
      subject.stub(:info).and_return({})
      subject.info[:name].should be_nil
    end
  end

  context "#extra" do
    pending
  end

  context "#raw_info" do
    pending
  end

  context "#authorize_params?" do
    pending
  end

end
