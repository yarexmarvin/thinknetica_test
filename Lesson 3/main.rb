
require_relative "./modules/options_module.rb"
require_relative "./controllers/carriages_controller.rb"
require_relative "./controllers/routes_controller.rb"
require_relative "./controllers/stations_controller.rb"
require_relative "./controllers/trains_controller.rb"

class Railroad

  include Options

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def start_app
    loop do
      show_options("Choose the subject", ["Trains", "Routes", "Carriages", "Stations"])
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        TrainController.new(@trains, @routes, @carriages)
      when "2"
        RouteController.new(@routes, @stations)
      when "3"
        CarriageController.new(@carriages)
      when "4"
        StationController.new(@stations)
      else
        print_wrong_option
      end
    end
  end
end

app1 = Railroad.new
app1.start_app
