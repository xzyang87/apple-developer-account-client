require "spaceship"
require './consts'

class AppleDevClient
  # Get all the teams
  def self.teams
    if Spaceship.client == nil
      puts "================================================================================================================"
      puts "Welcome to this cute tool. With its help, managing complicated Apple Developer Accounts have never been so easy!"
      puts "====================================================================="
      puts "First, login with Account: " + Consts::ACCOUNT_NAME.bold
      self.login
    end

    teams = Spaceship.client.teams

    if teams.count <= 0
      puts "No teams available on the Developer Portal"
      puts "You must accept an invitation to a team for it to be available"
      puts "To learn more about teams and how to use them visit https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/ManagingYourTeam/ManagingYourTeam.html"
      raise "Your account is in no teams"
    else
      puts "====================================================================="
      puts "Multiple teams found on the " + "Developer Portal".yellow
      self.pretty_print_teams(teams)
    end
    return teams
  end

  private

  # Login
  def self.login
    Spaceship::Portal.login(Consts::ACCOUNT_NAME, Consts::ACCOUNT_PASSWORD)
  end

  def self.pretty_print_teams(teams)
    index_max_length = 5

    # configure longest id length
    longest_team_id_length = 0
    teams.each do |team|
      if team['teamId'].length > longest_team_id_length
        longest_team_id_length = team['teamId'].length
      end
    end

    # configure longest name length
    longest_team_name_length = 0
    teams.each do |team|
      if team['name'].length > longest_team_name_length
        longest_team_name_length = team['name'].length
      end
    end

    # configure longest type length
    longest_team_type_length = 0
    teams.each do |team|
      if team['type'].length > longest_team_type_length
        longest_team_type_length = team['type'].length
      end
    end

    # configure underline
    underline_str = ''
    underline_index = index_max_length + "  |  ".length + longest_team_id_length + "  |  ".length + longest_team_name_length + "  |  ".length + longest_team_type_length + "  |  ".length
    while underline_index > 0
      underline_str += '-'
      underline_index -= 1
    end

    puts "*            " + underline_str
    printf "*            %-#{index_max_length}s  |  %-#{longest_team_id_length}s  |  %-#{longest_team_name_length}s  |  %-#{longest_team_type_length}s\n", "No.", "Team Id", "Team Name", "Team Type"
    puts "*            " + underline_str
    teams.each_with_index do |team, index|
      printf "*            %-#{index_max_length}s  |  %-#{longest_team_id_length}s  |  %-#{longest_team_name_length}s  |  %-#{longest_team_type_length}s\n", (index + 1).to_s, team['teamId'], team['name'], team['type']
    end
    puts "*            " + underline_str
  end

end












