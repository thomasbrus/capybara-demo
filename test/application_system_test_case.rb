require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test

  def use_selenium
    Capybara.current_driver = :selenium
  end

  def use_rack_test
    Capybara.current_driver = :rack_test
  end
end
