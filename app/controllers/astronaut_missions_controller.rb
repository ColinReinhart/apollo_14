class AstronautMissionsController < ApplicationController
  def create
    astronaut = Astronaut.find(params[:astronaut_id])
    mission = Mission.find(params[:mission_id])

    AstronautMission.create!(astronaut: astronaut, mission: mission)
    redirect_to astronaut_path(astronaut)
  end
end
