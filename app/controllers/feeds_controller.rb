class FeedsController < ApplicationController
  def show
    data = PullRequestFetcher.perform(repository_params)
    @repository = RepositorySerializer.perform(data)

    respond_to do |format|
      format.rss { render layout: false }
    end
  end

  private

  def repository_params
    { owner: params[:owner], repo: params[:repo] }
  end
end
