require 'rails_helper'

RSpec.describe Webhook, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:project_name) }
  it { should validate_presence_of(:url) }

  it { should allow_value('http://bar.com').for(:url) }
  it { should_not allow_value('foo.bar').for(:url) }
end
