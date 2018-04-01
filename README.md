# Apple Developer Account Client

This tool is based on [Spaceship of fastlane](https://github.com/fastlane/fastlane/tree/master/spaceship). 

What **Apple Developer Account Client** do is to monitor all the expiring and expired certificates and provising profiles in all teams of an Apple developer account.

Requirements: (**ruby version >= 2.3.3**)

```ruby
# check Ruby version first
$ ruby -v
ruby 2.3.3p222 (2016-11-21 revision 56859) [universal.x86_64-darwin17]
```


## When should we use this tool?


If you are managing a complex Apple Developer Account like the above, you'll soon find a lot of problems, like creating new appIds and corresponding certificates and provisioning profiles several times a week. Among those problems, there is one dangerous and hard to manage: **EXPIRATION of certificates and provisioning profiles.**

Althought Apple did send you emails when your certificates are about to expire in a month. But provisioning profiles do not have this privilege. Take an in-house app for instance, Imagine the consequence of failing to notice an expiring provisioning profile, and boom, suddenly one morning, the provisioning profile expired, and the users just cannot open the app anymore!

To prevent this from happening, you either make an excel to record all sorts of certificates and provisioning profile, which will soon lead to another big headache: you just spend more and more time maintaining the ever growing excel - more and more apps and certificates and provisioning profiles just keep coming...

Thanks to [Spaceship of fastlane](https://github.com/fastlane/fastlane/tree/master/spaceship), it has done all the dirty work of categorizing and modeling of APIs of Apple Developer Center, we don't need to do the web scraping work anymore.


## Installation

1. **First**, you need to install fastlane, please refer to [here](https://docs.fastlane.tools/getting-started/ios/setup/)

2. **Secondly**, you need to fill in your apple developer account name and passwod in [consts.rb](https://github.com/xzyang87/apple-developer-account-client/blob/master/consts.rb)

	```ruby
	# change the value of ACCOUNT_NAME and ACCOUNT_PASSWORD
	class Consts
	    ACCOUNT_NAME = "fill in your apple developer account name"
	    ACCOUNT_PASSWORD = "fill in the password"
	end
	
	```

3. **Finally** paste the following command in your terminal:

	```ruby
	# run this tool
	ruby begin_test.rb
	
	```
That's all you have to do, press Enter, and all the expiring and expried certificates and provisionging profiles will have no where to excape! If you wish, you could use this tool on your CI machine, and run it once a week or even once a day.


