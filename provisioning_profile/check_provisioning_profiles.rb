class CheckProvisioningProfiles
  def self.expired
    # Get all the teams
    teams = AppleDevClient.teams

    # Loop every team
    teams.each_with_index do |team, team_index|
      # print team header
      AppleDevClient.print_team_header(team, team_index)

      # Set current_team_id manually
      Spaceship.client.team_id = team["teamId"]

      # find & print expired certificates
      cellModels = convert_provisioning_profiles_to_table_cells(fetch_all_provisioning_profiles)
      AppleDevClient.find_expired_items(cellModels,
                                        TableCellModel::MODEL_TYPES[:is_provisioning_profile])

      # print team footer
      AppleDevClient.print_team_footer(team, team_index)
    end
  end

  # 60 days to expire
  def self.expiring
    # Get all the teams
    teams = AppleDevClient.teams

    # Loop every team
    teams.each_with_index do |team, team_index|
      # print team header
      AppleDevClient.print_team_header(team, team_index)

      # Set current_team_id manually
      Spaceship.client.team_id = team["teamId"]

      # find & print 60 days to expire certificates
      cellModels = convert_provisioning_profiles_to_table_cells(fetch_all_provisioning_profiles)
      AppleDevClient.find_60_days_to_expire_items(cellModels,
                                                  TableCellModel::MODEL_TYPES[:is_provisioning_profile])
      # print team footer
      AppleDevClient.print_team_footer(team, team_index)
    end
  end

  private

  def self.convert_provisioning_profiles_to_table_cells(provisioning_profiles)
    cellModels = []
    provisioning_profiles.each do |profile|
      cell = TableCellModel.new
      cell.name = profile.name.to_s
      days_to_now = (profile.expires - DateTime.now).to_i
      cell.days_to_now = days_to_now
      cellModels << cell
    end

    return cellModels
  end

  def self.fetch_all_provisioning_profiles
    AppleDevClient.write_to_file_and_puts_to_console("*      =====================================================================\n")
    puts "*      Now fetching provisioning profiles..."

    all_profiles = Spaceship::Portal.provisioning_profile.all

    puts "*      There are #{all_profiles.count} provisioning profiles in this team"
    return all_profiles
  end
end