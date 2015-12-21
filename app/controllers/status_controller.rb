class StatusController < ApplicationController
  before_action :run_checks

  class << self
    def commit
      @commit ||= begin
        head = File.read '.git/HEAD'
        ref = head.match(/^ref: (.+)/)[1]
        File.read(".git/#{ref}").strip
      rescue
        'unknown'
      end
    end
  end

  def check
    render json: { commit: self.class.commit, errors: errors }, status: status
  end

  private

  def run_checks
    # Add separate methods to do some checks, like DB or REDIS connection,
    # The call them here.
  end

  def error(key, value)
    errors[key] = value
  end

  def errors
    @errors ||= {}
  end

  def status
    errors.empty? ? :ok : :service_unavailable
  end
end
