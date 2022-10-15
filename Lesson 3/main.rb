require_relative './modules/options'
require_relative './controllers/carriages_controller'
require_relative './controllers/routes_controller'
require_relative './controllers/stations_controller'
require_relative './controllers/trains_controller'

class Railroad
  include Options

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
    start_app
  end

  def start_app
    loop do
      show_options('Choose the subject', %w[Trains Routes Carriages Stations])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when '1'
        TrainController.new(@trains, @routes, @carriages)
      when '2'
        RouteController.new(@routes, @stations)
      when '3'
        CarriageController.new(@carriages)
      when '4'
        StationController.new(@stations)
      else
        print_wrong_option
      end
    end
  end
end

Railroad.new
