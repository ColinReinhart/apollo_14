require 'rails_helper'

RSpec.describe "Astronaut page" do

  before(:each) do
    @astronaut1 = Astronaut.create!(name: "Buzz", age: 1, job: "Pilot")
    @astronaut2 = Astronaut.create!(name: "Neil", age: 2, job: "Mechanic")
    @astronaut3 = Astronaut.create!(name: "Bob", age: 3, job: "Plumber")

    @mission1 = Mission.create!(title: "Apollo 13", time_in_space: 1)
    @mission2 = Mission.create!(title: "Capricorn 4", time_in_space: 2)
    @mission3 = Mission.create!(title: "Gemini 7", time_in_space: 3)

    @astro_miss7 = AstronautMission.create!(astronaut_id: @astronaut1.id, mission_id: @mission3.id)
    @astro_miss1 = AstronautMission.create!(astronaut_id: @astronaut1.id, mission_id: @mission1.id)
    @astro_miss2 = AstronautMission.create!(astronaut_id: @astronaut2.id, mission_id: @mission1.id)
    @astro_miss3 = AstronautMission.create!(astronaut_id: @astronaut3.id, mission_id: @mission1.id)
    @astro_miss4 = AstronautMission.create!(astronaut_id: @astronaut1.id, mission_id: @mission2.id)
    @astro_miss5 = AstronautMission.create!(astronaut_id: @astronaut2.id, mission_id: @mission3.id)
    @astro_miss6 = AstronautMission.create!(astronaut_id: @astronaut3.id, mission_id: @mission2.id)
  end

  it 'shows a list of all astronauts' do
    visit '/astronauts'

    expect(page).to have_content(@astronaut1.name)

    Astronaut.all.each do |astro|
      expect(page).to have_content(astro.name)
      expect(page).to have_content(astro.age)
      expect(page).to have_content(astro.job)
    end

  end

  it 'shows average age of all astronauts' do
    visit '/astronauts'

    expect(page).to have_content("Average Age: 2")
  end

  it 'shows a list of space missions in alphabetical order for each astronaut' do
    visit '/astronauts'

    expect(page).to have_content("Apollo 13")

    within "##{@astronaut1.id}" do
      expect("Apollo").to appear_before("Capricorn")
      expect("Capricorn").to appear_before("Gemini")
    end

    within "##{@astronaut2.id}" do
      expect("Apollo").to appear_before("Gemini")
    end

    within "##{@astronaut3.id}" do
      expect("Apollo").to appear_before("Capricorn")
    end
  end

  it 'shows the total time in space for each astronaut' do
    visit '/astronauts'

    within "##{@astronaut1.id}" do
      expect(page).to have_content("Total Time in Space: 6 days")
    end

    within "##{@astronaut2.id}" do
      expect(page).to have_content("Total Time in Space: 4 days")
    end

    within "##{@astronaut3.id}" do
      expect(page).to have_content("Total Time in Space: 3 days")
    end


  end

  it 'show page (/astronauts/:id) lists name of astronaut and list of missions' do
    visit "/astronauts/#{@astronaut2.id}"

    expect(page).to have_content("Neil")

    expect(page).to have_content("Apollo")
    expect(page).to have_content("Gemini")
    expect(page).to_not have_content("Capricorn")
  end

end
