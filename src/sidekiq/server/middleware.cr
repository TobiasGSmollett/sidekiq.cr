require "../middleware"

class Sidekiq::Middleware::Logger < Sidekiq::Middleware::Entry
  def call(job, ctx)
    Sidekiq::Logger.with_context("JID=#{job.jid}") do
      a = Time.now.epoch_f
      ctx.logger.info "Start"
      yield
      ctx.logger.info "Done: #{"%.6f" % (Time.now.epoch_f - a)} sec"
    end
  end
end
