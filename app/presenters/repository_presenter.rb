require 'active_support/core_ext/module/delegation'

class RepositoryPresenter
  delegate :created_at,
           :description,
           :link,
           :owner,
           :pull_requests,
           :sorted_pull_requests,
           :title,
           to: :@repository

  def initialize(repository)
    @repository = repository
  end

  def descriptive_title
    "#{repository.owner}/#{repository.title} pull requests"
  end

  private

  attr_reader :repository
end
