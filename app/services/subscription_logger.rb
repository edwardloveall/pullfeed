class SubscriptionLogger
  def self.perform(request)
    new(request).perform
  end

  def initialize(request)
    @request = request
  end

  def perform
    subscription_params = SubscriptionParser.perform(request)
    subscription_params.merge!(repository_param)
    find_params = {
      subscriber: subscription_params[:subscriber],
      repository: subscription_params[:repository]
    }
    subscription = Subscription.find_or_initialize_by(find_params)
    subscription.update(subscription_params)
  end

  private

  attr :request

  def repository_param
    params = request.params
    repository = "#{params[:owner]}/#{params[:repo]}"
    { repository: repository }
  end
end
