require 'application_system_test_case'

class TodosTest < ApplicationSystemTestCase
  setup do
    @todo1 = todos(:one)
    @todo2 = todos(:two)
  end

  test 'should display todos on the index page' do
    visit todos_url

    assert_selector :gridcell, @todo1.title, rowindex: 2
    assert_selector :gridcell, @todo1.description, rowindex: 2
    assert_selector :gridcell, @todo1.assignee, rowindex: 2

    assert_selector :gridcell, @todo2.title, rowindex: 3
    assert_selector :gridcell, @todo2.description, rowindex: 3
    assert_selector :gridcell, @todo2.assignee, rowindex: 3
  end

  test 'it should display todos progress' do
    @todo1.finish!

    visit todos_url

    assert_selector 'h1', text: 'Todos (1/2)'
    assert_selector :element, role: 'progress', aria: { label: 'Todos completed', valuenow: '50.0' }
  end

  test 'should display todo links in table on the index page' do
    visit todos_url

    within :grid do
      click_link @todo1.title
    end

    assert_equal page.current_path, todo_path(@todo1)
  end

  test 'should finish todo from index page' do
    use_selenium

    visit todos_url

    check 'Finish todo', match: :first

    assert_selector 'h1', text: 'Todos (1/2)'
    assert_selector :element, role: 'progress', aria: { label: 'Todos completed', valuenow: '50.0' }

    within :gridcell, colindex: 1, rowindex: 2 do
      assert_selector :checkbox, checked: true
    end

    within :gridcell, colindex: 2, rowindex: 2 do
      # Use CSS class selector because it reflects what the user looks for.
      assert_selector '.line-through', text: @todo1.title
    end
  end

  test 'should unfinish todo from index page' do
    use_selenium

    @todo1.finish!

    visit todos_url

    uncheck 'Finish todo', match: :first

    assert_selector 'h1', text: 'Todos (0/2)'
    assert_selector :element, role: 'progress', aria: { label: 'Todos completed', valuenow: '0.0' }

    within :gridcell, colindex: 1, rowindex: 2 do
      assert_selector :checkbox, checked: false
    end

    within :gridcell, colindex: 2, rowindex: 2 do
      # Use CSS class selector because it reflects what the user looks for.
      refute_selector '.line-through', text: @todo1.title
    end
  end

  test 'should create todo' do
    visit todos_url
    click_on 'New todo'

    fill_in 'Title', with: @todo1.title
    fill_in 'Description', with: @todo1.description
    select @todo1.assignee, from: 'Assignee'

    click_on 'Create Todo'

    assert_selector :alert, 'Todo was successfully created'

    within :banner, 'Links' do
      assert_selector :link, 'Back to todos'
    end
  end

  test 'should update todo' do
    visit todo_url(@todo1)
    click_on 'Edit this todo', match: :first

    fill_in 'Title', with: @todo1.title
    fill_in 'Description', with: @todo1.description
    select @todo1.assignee, from: 'Assignee'

    click_on 'Update Todo'

    assert_selector :alert, 'Todo was successfully updated'

    within :banner, 'Links' do
      assert_selector :link, 'Back to todos'
    end
  end

  test 'should destroy todo' do
    visit todo_url(@todo1)

    within :contentinfo, 'Actions' do
      click_on 'Destroy', match: :first
    end

    assert_selector :alert, 'Todo was successfully destroyed'
  end

  test 'should show todo' do
    visit todo_url(@todo1)

    within :section, @todo1.title do
      assert_selector 'h1', text: @todo1.title
      assert_selector :item, 'description', text: @todo1.description
      assert_selector :item, 'assignee', text: @todo1.assignee
    end
  end

  test 'should indicate when todo is finished' do
    @todo1.unfinish!

    visit todo_url(@todo1)

    within :section, @todo1.title do
      # Use CSS class selector because it reflects what the user looks for.
      refute_selector 'h1.line-through', text: @todo1.title
    end

    @todo1.finish!

    visit todo_url(@todo1)

    within :section, @todo1.title do
      # Use CSS class selector because it reflects what the user looks for.
      assert_selector 'h1.line-through', text: @todo1.title
    end
  end
end
