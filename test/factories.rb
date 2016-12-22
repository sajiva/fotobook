FactoryGirl.define do

  factory :post do
    caption "caption"
    image_file_name "sunset.jpg"
    image_content_type "image/jpeg"
    user
  end

  factory :user do
    user_name "username"
    email { "#{user_name.downcase}@example.com" }
    password "password"
    password_confirmation "password"

    factory :user_with_posts do

      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end

    end
  end
end