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

  def update(id, updates)
    @tasks.where("id=#{id}").update(:task => updates[:task], :completed => updates[:completed])
  end

  def delete(id)
    @tasks.where("id =#{id}").delete
  end

  def display_single_record(id)
    @tasks[:id => id]
  end
end