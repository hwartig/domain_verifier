require 'domain_verifier/version'
require 'whois'

module DomainVerifier
  def self.verify(name)
    Domain.new(name).verify
  end

  class Domain
    attr_reader :name

    def initialize(name)
      @name = name.downcase
    end

    def whois
      @whois ||= Whois.whois(name)
    end

    def http_status
      @status ||= begin
        http = Net::HTTP.start(name)
        http.head('/').code
      end
    end

    def to_s
      name
    end

    def verify
      whois
      http_status
      self
    end
  end
end
