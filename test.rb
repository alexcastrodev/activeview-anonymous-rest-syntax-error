# frozen_string_literal: true

require 'bundler/setup'
require 'action_view'

puts "Ruby version: #{RUBY_VERSION}"

# https://github.com/rails/rails/blob/v8.1.1/actionview/lib/action_view/helpers/capture_helper.rb
def capture(*, **, &block)
  value = nil
  @output_buffer ||= ActionView::OutputBuffer.new
  buffer = @output_buffer.capture { value = yield(*, **) }

  string = if @output_buffer.equal?(value)
    buffer
  else
    buffer.presence || value
  end

  case string
  when ActionView::OutputBuffer
    string.to_s
  when ActiveSupport::SafeBuffer
    string
  when String
    ERB::Util.html_escape(string)
  end
end


captured = capture do
  "<strong>Hello, World!</strong>"
end