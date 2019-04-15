require 'rails_helper'

describe 'user sees award show page' do
  context 'as a visitor' do
    it 'displays all songs that received award and the year' do
      journey = Artist.create(name: 'Journey')
      song_1 = journey.songs.create(title: "Don't Stop Believin'", length: 345, play_count: 13)
      song_2 = journey.songs.create(title: "This Must Be the Place", length: 678, play_count: 5)

      award_1 = Award.create(name: "Emmy Award")
      award_2 = Award.create(name: "MTV Award")

      song_award_1 = SongAward.create(song: song_1, award: award_1)
      song_award_2 = SongAward.create(song: song_1, award: award_2)
      song_award_3 = SongAward.create(song: song_2, award: award_1)
      song_award_4 = SongAward.create(song: song_2, award: award_2)

      visit awards_path

      click_on award_1.name

      expect(current_path).to eq(award_path(award_1))
      expect(page).to have_content(award_1.name)

      expect(page).to have_content("Don't Stop Believin'")
      expect(page).to have_content("This Must Be the Place")
    end
  end
end
