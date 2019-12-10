# frozen_string_literal: true

require 'jwt'

class Auth
  self.algorithm = 'HS256'

  def self.issue(payload)
    JWT.encode(payload, auth_secret, algorithm)
  end

  def self.decode(token)
      JWT.decode(token, auth_secret, true, algorithm: algorithm).first
    rescue StandardError
      nil
    end
  end

  def self.auth_secret
    ENV['AUTH_SECRET']
  end
end
