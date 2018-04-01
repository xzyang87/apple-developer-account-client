require './login.rb'

class CheckCertificates
  def self.find_targed_certificates
    all_certificates = self.fetch_all_certificates

    self.find_expired_certificates(all_certificates)
    sleep(2)
    self.two_month_to_expire_certificates(all_certificates)
  end

  private

  def self.fetch_all_certificates
    puts "*      ====================================================================="
    puts "*      Now fetching certificates..."

    all_certificates = Spaceship::Portal.certificate.all

    puts "*      There are #{all_certificates.count} certificates in this team"

    return all_certificates
  end

  def self.two_month_to_expire_certificates(all_certificates)
    two_month_to_expire_certificates = []

    # print out all remaining days
    all_certificates.each do |current_certificate|
      days_to_now = (current_certificate.expires.to_datetime - DateTime.now).to_i
      if days_to_now < 60 && days_to_now >= 0
        two_month_to_expire_certificates << current_certificate
      end
    end

    if two_month_to_expire_certificates.count == 0
      puts "*" + "      No Two-months-to-Expire certificates.".green.bold
    else
      puts "*" + "      #{two_month_to_expire_certificates.count} Within Two-months-to-Expire certificates are:".green.bold

      self.pretty_print_certificates(two_month_to_expire_certificates)
    end
  end

  def self.find_expired_certificates(all_certificates)
    expired_certificates = []

    # print out all remaining days
    all_certificates.each do |current_certificate|
      Date
      days_to_now = (current_certificate.expires.to_datetime - DateTime.now).to_i
      if days_to_now < 0
        expired_certificates << current_certificate
      end
    end

    if expired_certificates.count == 0
      puts "*" + "      No Expired certificates.".blue.bold
    else
      puts "*" + "      #{expired_certificates.count} expired certificates are:".blue.bold

      self.pretty_print_certificates(expired_certificates)
    end
  end

  def self.pretty_print_certificates(certificates)
    index_max_length = 5

    # configure longest name length
    longest_certificate_name_length = 0
    certificates.each do |certificate|
      if certificate.owner_name.to_s.length > longest_certificate_name_length
        longest_certificate_name_length = certificate.owner_name.to_s.length
      end
    end

    # configure underline
    underline_str = ''
    underline_index = index_max_length + "  |  ".length + longest_certificate_name_length + "  |  ".length + "Days".length
    while underline_index > 0
      underline_str += '-'
      underline_index -= 1
    end

    puts "*            " + underline_str
    printf "*            %-#{index_max_length}s  |  %-#{longest_certificate_name_length}s  |  %-s\n", "No.", "Certificate Name", "Days"
    puts "*            " + underline_str
    certificates.each_with_index do |certificate, index|
      days_to_now = (certificate.expires.to_datetime - DateTime.now).to_i
      printf "*            %-#{index_max_length}s  |  %-#{longest_certificate_name_length}s  |  %-s\n", (index + 1).to_s, certificate.owner_name, days_to_now.to_s
    end
    puts "*            " + underline_str
  end

end