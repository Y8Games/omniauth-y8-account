require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Idnet < OmniAuth::Strategies::OAuth2

      option :name, "idnet"

      option :fields, OmniAuth::Idnet::DEFAULT unless args.include?('fields')

      option :client_options, {
        :site             => "http://id.net/",
        :authorize_url    => "http://id.net/oauth/authorize",
        :access_token_url => "http://id.net/oauth/token"
      } unless args.include?('client_options')

      option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name    => 'oauth_token'
      }

      def request_phase
        options[:response_type] ||= 'code'
        super
      end

      uid { raw_info['pid'] }

      info do
        options.fields.inject({}) do |hash, field|
          hash[field] = raw_info[field.to_s]
          hash
        end
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/api/profile').parsed
      end

      def build_access_token
        super.tap do |token|
          token.options.merge!(access_token_options)
        end
      end

      def access_token_options
        options.access_token_options.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      end

      def authorize_params
        super.tap do |params|
          params.merge!(:display => request.params['display']) if request.params['display']
        end
      end
    end
  end
end
