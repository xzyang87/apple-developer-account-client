require './certificate/check_certificates'
require './provisioning_profile/check_provisioning_profiles'
require './client'

AppleDevClient.print_all_teams
CheckCertificates.expired
CheckCertificates.expiring
CheckProvisioningProfiles.expired
CheckProvisioningProfiles.expiring


