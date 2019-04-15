require 'rails_helper'

RSpec.describe Award, type: :model do
  describe 'relationships' do

    it {should have_many :song_awards}
    it {should have_many(:songs).through(:song_awards)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end
end
