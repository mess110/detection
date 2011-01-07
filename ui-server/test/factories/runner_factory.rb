# This will guess the User class
#FactoryGirl.define do
#  factory :user do
#    first_name 'John'
#    last_name  'Doe'
#    admin false
#  end
#
#  # This will use the User class (Admin would have been guessed)
#  factory :admin, :class => User do
#    first_name 'Admin'
#    last_name  'User'
#    admin true
#  end
#
#  # The same, but using a string instead of class constant
#  factory :admin, :class => 'user' do
#    first_name 'Admin'
#    last_name  'User'
#    admin true
#  end
#end
