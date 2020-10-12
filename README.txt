How to run this application :
- Take clone : git clone git@github.com:raksul-code-review/userapi2-candidate-manishnagdewani96170-d2bf887968cae101a7db15cd287d5913.git
- cd Raksulapi
- create database for dev and test environments
  createdb raksul_dev;
  createdb raksul_test;
- Install all dependencies : bundle
- Start server : RACK_ENV=development rackup -p ENV['HOST']

How to run test suit :
- ruby test_suite.rb --verbose

