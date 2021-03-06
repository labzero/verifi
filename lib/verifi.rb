require 'rubygems'
require 'httpclient'
require 'xmlsimple'
require 'active_support'

module Verifi

  class Client
    def initialize api_key, api_secret, api_host="http://api.verifi.com/hpp"
      @api_key = api_key
      @api_secret = api_secret
      @api_host = api_host
    end

    #The attributes should simply be a hash of attribute name to value
    #i.e. should not be wrapped with payment[<attribute_name>]
    def create_payment_request attributes
      uri = '/payment_requests'

      params = {:payment => attributes}
      params.merge!(base_api_params.merge(:command => 'create_payment_request'))
      params.merge!(:sig => gen_sig(params, @api_secret))

      do_post "#{@api_host}#{uri}", params
    end

    def read_payment_request pay_key
      uri = "/payment_requests/#{pay_key}"

      params = base_api_params.merge(:command => 'read_payment_request')
      params.merge!(:sig => gen_sig(params, @api_secret))

      do_get "#{@api_host}#{uri}", params
    end

    private

    def base_api_params
      {:api_key => @api_key, :format => 'xml', :version => '1.0'}
    end

    def gen_sig params, secret
      req_params = CGI.unescape(params.to_query).split('&').sort.to_s
      Digest::SHA2.hexdigest("#{req_params}#{secret}")
    end

    def do_get url, params
      begin
        httpclient = HTTPClient.new
        resp = httpclient.get url, params.to_query
        return parse_resp(resp)
      rescue
        throw "GET #{url} with #{params.inspect} jus  t ate a fail sandwich: #{$!.inspect}"
      end
    end

    def do_post url, params
      begin
        httpclient = HTTPClient.new
        resp = httpclient.post url, params.to_query
        return parse_resp(resp)
      rescue
        throw "GET #{url} with #{params.inspect} jus  t ate a fail sandwich: #{$!.inspect}"
      end
    end

    def parse_resp resp
      begin
#        puts "about to parse: #{resp.content}"
        hash = XmlSimple.xml_in(resp.content, {'ForceArray' => false, 'keeproot' => false})
      rescue
        throw "Unable to parse response as xml: #{resp.content}"
      end

      unless resp.status == 200
        throw "Request was unsuccessful: #{hash['error'].inspect}"
      end

      hash
    end
  end

end
