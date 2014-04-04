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
    @tasks.insert('sleep')
    expect(@tasks.view_tasks).to eq([
                                      {:id => 1, :task => 'sleep', :completed => false}
                                    ])
  end

  it "updates the task in the table" do
    @tasks.insert('sleep')
    @tasks.insert('eat')
    @tasks.update(1, {:task => 'wake up', :completed => true})
    @tasks.update(2, {:task => 'dont eat', :completed => false})
    expect(@tasks.view_tasks).to eq([
                                      {:id => 1, :task => 'wake up', :completed => true},
                                      {:id => 2, :task => 'dont eat', :completed => false}])
  end

  it "deletes a task from the table" do
    @tasks.insert('sleep')
    @tasks.insert('eat')
    @tasks.delete(2)
    expect(@tasks.view_tasks).to eq(
                                   [{:id => 1, :task => 'sleep', :completed => false}
                                   ])
  end

  it "finds a task by id" do
    @tasks.insert('study')
    @tasks.insert('exercise')
    @tasks.insert('sleep')
    @tasks.insert('eat')
    @tasks.display_single_record(1)
    expect(@tasks.display_single_record(1)).to eq(
                                                 {:id => 1, :task => 'study', :completed => false}
                                               )
  end
end