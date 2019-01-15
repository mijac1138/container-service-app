require "container_service_app/version"
require "roda"
require "jwt"
require "openssl"

module ContainerServiceApp
  class App < Roda
    plugin :render
    plugin :json
    plugin :request_headers

    private

    def attach_response_headers(borg_response)
      response['Content-Type'] = "text/#{request.params.key?('layout') ? 'html' : 'plain'}; charset=UTF-8"
    end

    def has_valid_token?
      begin
        public_key = OpenSSL::PKey::RSA.new(ENV['JWT_PUBLIC_KEY'])
        JWT.decode(get_token, public_key, true, algorithm: 'RS256')
        is_valid = true
      rescue StandardError
        is_valid = false
      end
      is_valid
    end

    def has_valid_params?
      case_id = request.params['case_id']
      !case_id.nil? && !case_id.empty?
    end

    def get_token
      if request.params.key?('_jwt')
        return request.params['_jwt']
      elsif !request.headers['Authorization']
        return ''
      end
      request.headers['Authorization'].split(' ').last
    end

    def build_request_url(segment)
      URI("#{ENV['BORG_BASE_URL']}#{segment}?_jwt=#{get_token}")
    end
  end
end
