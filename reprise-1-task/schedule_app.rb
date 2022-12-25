# frozen_string_literal: true

require 'date'
require 'forme'
require 'roda'

# The application class
class ScheduleApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :hash_routes
  plugin :path
  plugin :render, layout: './layout'
  plugin :status_handler
  plugin :view_options

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  require_relative 'routes/schedule'

  status_handler(404) do
    view('./not_found')
  end

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches

    r.root do
      r.redirect schedule_path
    end
  end
end
