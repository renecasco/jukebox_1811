require 'rails_helper'

RSpec.describe 'when visitor visits songs show', type: :feature do
  before :each do
    @journey = Artist.create(name: 'Journey')
    @song_1 = @journey.songs.create(title: "Don't Stop Believin'", length: 345, play_count: 13)
    @song_2 = @journey.songs.create(title: "This Must Be the Place", length: 678, play_count: 5)

    award_1 = Award.create(name: "Emmy Award")
    award_2 = Award.create(name: "MTV Award")

    song_award_1 = @song_1.song_awards.create(award: award_1)
    song_award_2 = @song_1.song_awards.create(award: award_2)
  end

  it 'can get there from the index page' do
    visit songs_path

    expect(page).to have_link(@song_1.title)
    click_link(@song_1.title)

    expect(current_path).to eq(song_path(@song_1))
  end

  it 'can see a single song' do
    visit song_path(@song_1)

    within "#song-#{@song_1.id}" do
      expect(page).to have_content(@song_1.title)
      expect(page).to have_content("length: #{@song_1.length}")
      expect(page).to have_content("play count: #{@song_1.play_count}")
      expect(page).to have_content("Awards for this Song:")
      expect(page).to have_content("Emmy Award")
      expect(page).to have_content("MTV Award")
    end
    expect(page).to_not have_css("#song-#{@song_2.id}")
    expect(page).to have_no_content(@song_2.title)
    expect(page).to_not have_content("length: #{@song_2.length}")
  end
end
