ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

Capybara.enable_aria_label = true

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def add_role_selector(role, xpath_expressions)
  Capybara.add_selector(role.to_sym, locator_type: [String, Symbol]) do
    xpath do |*|
      XPath.descendant[[
        XPath.attr(:role) == role.to_s,
        *xpath_expressions
      ].reduce(:|)]
    end

    locator_filter skip_if: nil do |node, locator, exact:, **|
      method = exact ? :eql? : :include?
      if node[:"aria-labelledby"]
        CapybaraAccessibleSelectors::Helpers.element_labelledby(node).public_send(method, locator)
      elsif node[:"aria-label"]
        node[:"aria-label"].public_send(method, locator.to_s)
      end
    end

    filter_set(:capybara_accessible_selectors, %i[aria described_by])
  end
end

# Based on https://github.com/A11yance/aria-query/blob/fff6f07c714e8048f4fe084cec74f24248e5673d/__tests__/src/roleElementMap-test.js#L28
add_role_selector(:progressbar, [XPath.self(:progress)])
