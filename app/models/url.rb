class Url
  include MongoMapper::Document

  key :short_url, String, :required => true
  key :long_url, String, :required => true
  key :num_visits, Integer, :default => 0

  def self.shorten
    short = SecureRandom.urlsafe_base64(8)
    until self.find_by_short_url(short).nil?
      short = SecureRandom.urlsafe_base64(8)
    end
    short
  end

end
