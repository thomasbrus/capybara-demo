require 'application_system_test_case'

class TodosTest < ApplicationSystemTestCase
  setup { @todo = todos(:one) }

  test 'visiting the index' do
    visit todos_url
    assert_selector 'h1', text: 'Todos'
  end

  test 'should create todo' do
    visit todos_url
    click_on 'New todo'

    fill_in 'Title', with: @todo.title
    fill_in 'Description', with: @todo.description
    fill_in 'Deadline', with: @todo.deadline

    click_on 'Create Todo'

    assert_text 'Todo was successfully created'
    click_on 'Back'
  end

  test 'should update todo' do
    visit todo_url(@todo)
    click_on 'Edit this todo', match: :first

    fill_in 'Title', with: @todo.title
    fill_in 'Description', with: @todo.description
    fill_in 'Deadline', with: @todo.deadline

    click_on 'Update Todo'

    assert_text 'Todo was successfully updated'
    click_on 'Back'
  end

  test 'should destroy todo' do
    visit todo_url(@todo)
    click_on 'Destroy', match: :first

    assert_text 'Todo was successfully destroyed'
  end
end
