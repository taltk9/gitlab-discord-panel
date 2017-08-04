class Webhook < ApplicationRecord
  validates :name, :project_name, :url, presence: true
  validates :url, format: { with: URI.regexp }
end
