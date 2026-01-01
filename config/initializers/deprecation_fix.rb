# Fix for Rails 7.2 deprecation warning method change
# Some older gems call ActiveSupport::Deprecation.warn as a class method
# but Rails 7.2 made this an instance method only
if Rails.gem_version >= Gem::Version.new("7.2")
  module ActiveSupport
    class Deprecation
      class << self
        def warn(message = nil, callstack = nil)
          ActiveSupport::Deprecation.new.warn(message, callstack)
        end

        def silence(&block)
          ActiveSupport::Deprecation.new.silence(&block)
        end
      end
    end
  end
end
