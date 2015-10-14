# cafezin-ci

## Jenkins runner configuration
The following applications must be installed on the runner machine in order to use the CI pipeline. You need to install xcode first and execute it once to intall xcode command line tools, otherwise you won't be able to install the other tools.

- xcode
- fastalane
- java jdk 1.7
- cocoapods

Also you need to create a user called jenkins/jenkins (username/password) on the runner machine.

## How to run/test?
1. Copy and rename the file [jenkins_slave_attributes.rb.sampl](https://github.com/Cafezin/cafezin-ci/blob/master/site-cookbooks/main/attributes/jenkins_slave_attributes.rb.sample]) to jenkins_salve_attributes.rb. Inside this file, fill up the parameters with your credentials and the runner machine ip.
2. ```` bundle exec install ````
3. ```` bundle exec kitchen create ````
4. ```` bundle exec kitchen converge ````
5. Acess jenkins at 192.168.33.33:8080
