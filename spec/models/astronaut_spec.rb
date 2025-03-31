require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe "class methods" do
    it ".average_age" do
      astronaut1 = Astronaut.create!(name: "Buzz", age: 1, job: "Pilot")
      astronaut2 = Astronaut.create!(name: "Neil", age: 2, job: "Mechanic")
      astronaut3 = Astronaut.create!(name: "Bob", age: 3, job: "Plumber")

      expect(Astronaut.average_age).to eq(2)
    end
  end
end
