FactoryBot.define do

  factory :user do
    email {"test@gmail.com"}
    password {"blahblah123"}
    first_name {"Taro"}
    last_name {"Doe"}
    nickname {"Taradoe"}
    role {"tutor"}
  end

end
