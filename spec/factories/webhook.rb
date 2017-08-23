# This will guess the Webhook class
FactoryGirl.define do
  factory :webhook, class: Webhook do
    name "my-awesome-hook"
    project_name "My awesome hook"
    url "https://canary.discordapp.com/api/webhooks/123456789123456789/xyz"
  end

  factory :invalid_webhook, class: Webhook do
    name ""
    project_name ""
    url ""
  end
end
