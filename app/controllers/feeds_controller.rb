class FeedsController < ApplicationController
  def show
    data = PullRequestFetcher.perform(repository_params)
    @repository = RepositorySerializer.perform(data)
    SubscriptionLogger.perform(request)

    respond_to do |format|
      format.atom { fresh_when @repository }
    end
  end

  private

  def repository_params
    { owner: params[:owner], repo: params[:repo] }
  end

  def repository
    @_repository ||= RepositoryPresenter.new(@repository)
  end
  helper_method :repository
end
