class FeedsController < ApplicationController
  def show
    data = PullRequestFetcher.perform(repository_params)
    @repository = RepositorySerializer.perform(data)
    SubscriptionLogger.perform(request)

    fresh_when @repository.created_at
  end

  private

  def repository_params
    { owner: params[:owner], repo: params[:repo], q: params[:q] }
  end

  def repository
    @_repository ||= RepositoryPresenter.new(@repository)
  end
  helper_method :repository
end
