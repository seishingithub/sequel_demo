class TaskRepos

  def initialize(db)
    @tasks = db[:tasks]
  end

  def insert(task)
    @tasks.insert(:task => task)
  end

  def view_tasks
    @tasks.all
  end
end