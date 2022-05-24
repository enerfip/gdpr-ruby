require "spec_helper"

RSpec.describe Gdpr::ModelDsl do
  module Gdpr::Model
    class DummyUser; end
    class DummyAsset; end
  end

  class DummyUser
    include Gdpr::ModelDsl
    personal do
      attributes :email, :name
      has_many :friends, model: "Gdpr::Model::DummyUser"
      has_one :best_friend, model: "Gdpr::Model::DummyUser"
      belongs_to :father, model: "Gdpr::Model::DummyUser"
      file :document, driver: :carrierwave
    end

    non_personal do
      attributes :remember_token
      has_many :assets
      has_one :car
      belongs_to :building
      file :avatar
    end
  end

  it "stores definitions correctly" do
    expect(DummyUser.personal_attributes).to eq [:email, :name]
    expect(DummyUser.personal_has_manies).to eq [[:friends, "Gdpr::Model::DummyUser"]]
    expect(DummyUser.personal_has_ones).to eq [[:best_friend, "Gdpr::Model::DummyUser"]]
    expect(DummyUser.personal_belongs_tos).to eq [[:father, "Gdpr::Model::DummyUser"]]
    expect(DummyUser.non_personal_has_manies).to eq [:assets]
    expect(DummyUser.non_personal_has_ones).to eq [:car]
    expect(DummyUser.non_personal_belongs_tos).to eq [:building]
    expect(DummyUser.personal_hashes).to eq []
    expect(DummyUser.non_personal_hashes).to eq []
    expect(DummyUser.personal_files).to eq [[:document, :carrierwave]]
    expect(DummyUser.non_personal_files).to eq [:avatar]
  end
end
