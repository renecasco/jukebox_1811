require 'rails_helper'

RSpec.describe 'awards index page' do
  describe 'when an admin visits the awards index' do
    it 'shows them all the awards, each one is a link to their show page' do
      journey = Artist.create(name: 'Journey')
      song_1 = journey.songs.create(title: "Don't Stop Believin'", length: 345, play_count: 13)
      song_2 = journey.songs.create(title: "This Must Be the Place", length: 678, play_count: 5)

      award_1 = Award.create(name: "Emmy Award")
      award_2 = Award.create(name: "MTV Award")

      song_award_1 = song_1.song_awards.create(award: award_1)
      song_award_2 = song_2.song_awards.create(award: award_2)

      admin = User.create(username: "Rene", password: "pass123", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit awards_path

      within "#award-#{award_1.id}" do
        expect(page).to have_link(award_1.name)
      end

      within "#award-#{award_2.id}" do
        expect(page).to have_link(award_2.name)
      end

      expect(page).to have_content("Add New Award")

      fill_in :award_name, with: "Award 3"

      click_on "Create Award"

      expect(current_path).to eq(awards_path)
      expect(page).to have_link(award_1.name)
      expect(page).to have_link(award_2.name)
      expect(page).to have_link(Award.last.name)
    end
  end
  describe 'when a user visits the awards index' do
    it 'shows them all the awards, each one is a link to their show page' do
      journey = Artist.create(name: 'Journey')
      song_1 = journey.songs.create(title: "Don't Stop Believin'", length: 345, play_count: 13)
      song_2 = journey.songs.create(title: "This Must Be the Place", length: 678, play_count: 5)

      award_1 = Award.create(name: "Emmy Award")
      award_2 = Award.create(name: "MTV Award")

      song_award_1 = song_1.song_awards.create(award: award_1)
      song_award_2 = song_2.song_awards.create(award: award_2)

      visit awards_path

      within "#award-#{award_1.id}" do
        expect(page).to have_link(award_1.name)
      end

      within "#award-#{award_2.id}" do
        expect(page).to have_link(award_2.name)
      end

      expect(page).to_not have_content("Add New Award")

      click_on (award_1.name)

      expect(current_path).to eq(award_path(award_1))
    end
  end
end
