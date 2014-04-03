require 'spec_helper'
require './task_repos'
require 'sequel'

describe "a task repository" do

  DB = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_test')

  before do
    DB.create_table! :tasks do
      primary_key :id
      String :task
      Boolean :completed, :default => false
    end
    @tasks = TaskRepos.new(DB)

  end

  it "creates tasks in a table" do
    @tasks.insert('study')
    expect(@tasks.view_tasks).to eq([
                                      {:id => 1, :task => 'study', :completed => false}
                                    ])
  end
end