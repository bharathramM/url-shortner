# frozen_string_literal: true

class Url < ApplicationRecord #:nodoc:
  has_one :analytic

  before_save :validates
  before_create :assign_shorten

  def validates
    raise 'Invalid URL' unless source.include?('.')

    self.source = enhance_url
  end

  def assign_shorten
    self.shorten = SecureRandom.alphanumeric(5)
  end

  def generate_shorten
    [ENDPOINTS.domain, shorten].join('/')
  end

  def enhance_url(protocol: nil)
    return source unless source.present?

    protocol ||= 'https'
    if source[%r{\Ahttp:\/\/}] || source[%r{\Ahttps:\/\/}]
      source
    else
      [protocol, source].join('://')
    end
  end

  # Should be accessed in Background process
  def update_analytic(country, ip)
    analytic = self.analytic || Analytic.new(url_id: id)
    analytic.total_request += 1
    detail = analytic.detail
    detail[country] ||= { 'no_of_hits' => 0, 'ip_addresses' => [] }
    country_details = detail[country]
    country_details['no_of_hits'] += 1
    country_details['ip_addresses'] = country_details['ip_addresses']
                                      .push(ip).compact.uniq
    analytic.save!
  end

  def self.stats
    cols = ['urls.source as source', 'urls.shorten as shorten',
            'analytics.detail as detail', 'analytics.total_request as total_hits']
    mapping = cols.join(', ')
    joins(:analytic).select(mapping)
  end
end
