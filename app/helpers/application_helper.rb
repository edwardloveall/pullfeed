module ApplicationHelper
  def last_updated_date
    last_commit = Kernel.`'git show -s --format=%ad master'
    DateTime.parse(last_commit).strftime('%Y/%m/%d')
  end
end
