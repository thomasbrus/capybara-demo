require 'application_system_test_case'

class TodosTest < ApplicationSystemTestCase
  setup { @todo = todos(:one) }

  test 'visiting the index' do
    visit todos_url

    assert_selector :gridcell, @todo.title
    assert_selector :gridcell, @todo.description
    assert_selector :gridcell, @todo.assignee
    assert_selector :gridcell, @todo.deadline
  end

  test 'should create todo' do
    use_selenium

    visit todos_url
    click_on 'New todo'

    fill_in 'Title', with: @todo.title
    fill_in 'Description', with: @todo.description
    select @todo.assignee, from: 'Assignee'
    fill_in 'Deadline', with: @todo.deadline

    click_on 'Create Todo'

    assert_selector :alert, 'Todo was successfully created'

    within_banner 'Links' do
      assert_selector :link, 'Back to todos'
    end
  end

  test 'should update todo' do
    visit todo_url(@todo)
    click_on 'Edit this todo', match: :first

    fill_in 'Title', with: @todo.title
    fill_in 'Description', with: @todo.description
    select @todo.assignee, from: 'Assignee'
    fill_in 'Deadline', with: @todo.deadline

    binding.pry

    click_on 'Update Todo'

    assert_selector :alert, 'Todo was successfully updated'

    within_banner 'Links' do
      assert_selector :link, 'Back to todos'
    end
  end

  test 'should destroy todo' do
    visit todo_url(@todo)

    within_contentinfo 'Actions' do
      click_on 'Destroy', match: :first
    end

    assert_selector :alert, 'Todo was successfully destroyed'
  end

  test 'should show todo' do
    visit todo_url(@todo)

    within_section @todo.title do
      assert_selector 'h1', text: @todo.title
      assert_selector :item, 'description', text: @todo.description
      assert_selector :item, 'assignee', text: @todo.assignee
    end
  end
end
