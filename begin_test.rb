require './check_certificates'
require './check_provisioning_profiles'

# Get all the teams
teams = AppleDevClient.teams

# Loop every team
teams.each_with_index do |team, team_index|
  # configure output string for each team
  origin_str = "* " + "Now deal with team_id(" + team["teamId"] + ") team_name(" + team["name"] + ") team_type(" + team["type"] + ")"
  bold_str = "* " + "Now deal with team_id(".bold + team["teamId"].red.bold + ") team_name(".bold + team["name"].red.bold + ") team_type(".bold + team["type"].red.bold + ")".bold
  # configure stars line above
  star_index = 0
  stars_str = ''
  while star_index < origin_str.length
    if star_index == origin_str.length / 2
      progress_str = " #{team_index + 1} / #{teams.count} "
      stars_str += progress_str.yellow.bold
      star_index += progress_str.length
    else
      stars_str += "*"
      star_index += 1
    end
  end
  # output stars line and team string
  puts "\n\n"
  puts stars_str
  puts bold_str

  # Set current_team_id manually
  Spaceship.client.team_id = team["teamId"]

  # find targeted certificates
  CheckCertificates.find_targed_certificates

  # find targeted provisioning profiles
  CheckProvisioningProfiles.find_targed_profiles

  puts stars_str
end


