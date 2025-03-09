# frozen_string_literal: true

RSpec::Support.require_rspec_core "formatters/base_text_formatter"
RSpec::Support.require_rspec_core "formatters/console_codes"

# This custom formatter is here so I can put the context on the same line
# as the example... I think it will be less annoying
class ConDocFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register(
    self, :example_started, :example_group_started, :example_group_finished,
    :example_passed, :example_pending, :example_failed
  )

  # We set MAX_LEVEL at 2 so that we have our "describe class" like normal,
  # and then we have describe "#method_name" indented like normal, but then
  # everything after that gets condensed on the same line at level 2, joined
  # by a comma.
  MAX_LEVEL = 2

  def initialize(output)
    super
    @group_level = 0
    @nested_text = []

    @example_running = false
    @messages = []
  end

  def example_started(_notification)
    @example_running = true
  end

  def example_group_started(notification)
    output.puts if @group_level == 0

    if @group_level < MAX_LEVEL
      output.puts "#{current_indentation}#{notification.group.description.strip}"
    else
      @nested_text << notification.group.description.strip
    end

    @group_level += 1
  end

  def example_group_finished(_notification)
    @nested_text.pop
    @group_level -= 1 if @group_level > 0
  end

  def example_passed(passed)
    output.puts passed_output(passed.example)

    flush_messages
    @example_running = false
  end

  def example_pending(pending)
    content = pending_output(
      pending.example,
      pending.example.execution_result.pending_message
    )
    output.puts content

    flush_messages
    @example_running = false
  end

  def example_failed(failure)
    output.puts failure_output(failure.example)

    flush_messages
    @example_running = false
  end

  def message(notification)
    if @example_running
      @messages << notification.message
    else
      output.puts "#{current_indentation}#{notification.message}"
    end
  end

  private

  def flush_messages
    @messages.each do |message|
      output.puts "#{current_indentation(1)}#{message}"
    end

    @messages.clear
  end

  def passed_output(example)
    content = @nested_text.dup << example.description.strip
    content = "#{current_indentation}#{content.join(', ')}"
    RSpec::Core::Formatters::ConsoleCodes.wrap(content, :success)
  end

  def pending_output(example, message)
    content = @nested_text.dup << "#{example.description.strip} (PENDING: #{message})"
    content = "#{current_indentation}#{content.join(', ')}"
    RSpec::Core::Formatters::ConsoleCodes.wrap(content, :pending)
  end

  def failure_output(example)
    content = @nested_text.dup << "#{example.description.strip} (FAILED - #{next_failure_index})"
    content = "#{current_indentation}#{content.join(', ')}"
    RSpec::Core::Formatters::ConsoleCodes.wrap(content, :failure)
  end

  def next_failure_index
    @next_failure_index ||= 0
    @next_failure_index += 1
  end

  def current_indentation(offset = 0)
    indent = [@group_level, MAX_LEVEL].min
    "  " * (indent + offset)
  end
end
