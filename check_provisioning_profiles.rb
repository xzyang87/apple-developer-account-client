require './login.rb'

class CheckProvisioningProfiles
  def self.find_targed_profiles
      all_profiles = self.fetch_all_provisioning_profiles

      self.find_expired_provisioning_profiles(all_profiles)
      sleep(2)
      self.two_month_to_expire_provisioning_profiles(all_profiles)
  end

  private

  def self.fetch_all_provisioning_profiles
    puts "*      ====================================================================="
    puts "*      Now fetching provisioning profiles..."

    all_profiles = Spaceship::Portal.provisioning_profile.all

    puts "*      There are #{all_profiles.count} provisioning profiles in this team"

    return all_profiles
  end

  def self.two_month_to_expire_provisioning_profiles(all_profiles)
    two_month_to_expire_profiles = []

    # print out all remaining days
    all_profiles.each do |current_profile|
      days_to_now = (current_profile.expires - DateTime.now).to_i
      if days_to_now < 60 && days_to_now >= 0
        two_month_to_expire_profiles << current_profile
      end
    end

    if two_month_to_expire_profiles.count == 0
      puts "*" + "      No Two-months-to-Expire provisioning profiles.".green.bold
    else
      puts "*" + "      #{two_month_to_expire_profiles.count} Within Two-months-to-Expire provisioning profiles are:".green.bold

      self.pretty_print_profiles(two_month_to_expire_profiles)
    end
  end

  def self.find_expired_provisioning_profiles(all_profiles)
    expired_profiles = []

    # print out all remaining days
    all_profiles.each do |current_profile|
      days_to_now = (current_profile.expires - DateTime.now).to_i
      if days_to_now < 0
        expired_profiles << current_profile
      end
    end

    if expired_profiles.count == 0
      puts "*" + "      No Expired provisioning profiles.".blue.bold
    else
      puts "*" + "      #{expired_profiles.count} expired provisioning profiles are:".blue.bold

      self.pretty_print_profiles(expired_profiles)
    end
  end

  def self.pretty_print_profiles(profiles)
    index_max_length = 5

    # configure longest name length
    longest_profile_name_length = 0
    profiles.each do |profile|
      if profile.name.to_s.length > longest_profile_name_length
        longest_profile_name_length = profile.name.to_s.length
      end
    end

    # configure underline
    underline_str = ''
    underline_index = index_max_length + "  |  ".length + longest_profile_name_length + "  |  ".length + "Days".length
        while underline_index > 0
      underline_str += '-'
      underline_index -= 1
    end

    puts "*            " + underline_str
    printf "*            %-#{index_max_length}s  |  %-#{longest_profile_name_length}s  |  %-s\n", "No.", "Provisioning Profile Name", "Days"
    puts "*            " + underline_str
    profiles.each_with_index do |profile, index|
      days_to_now = (profile.expires - DateTime.now).to_i
      printf "*            %-#{index_max_length}s  |  %-#{longest_profile_name_length}s  |  %-s\n", (index + 1).to_s, profile.name, days_to_now.to_s
    end
    puts "*            " + underline_str
  end

end