# frozen_string_literal: true

if defined?(Rack::MiniProfiler)
  # Enable memory profiler (requires memory_profiler gem)
  Rack::MiniProfiler.config.enable_advanced_debugging_tools = true

  # Store results in memory (default)
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore

  # Show profiler on every page (can be toggled with Alt+P)
  Rack::MiniProfiler.config.start_hidden = false

  # Position of the profiler badge
  Rack::MiniProfiler.config.position = 'top-left'

  # Enable flamegraph support (requires stackprof gem)
  Rack::MiniProfiler.config.enable_hotwire_turbo_drive_support = true
end
