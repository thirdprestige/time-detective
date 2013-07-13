# Each integration will need several types of data
#
# Per-account, we need to track the API key or other authentication method
# for pulling data in.
#
# Per-project, we'll track the project name (Heroku app name, etc)
#
# Per-worker, track the integration username
# (nj@thirdprestige.com)
#
# Per-activity, we need to pull in our best guess at description & hours

module Integratable
  module Association
    extend ActiveSupport::Concern

    module ClassMethods
      def integrates name, using
        has_one name,
          class_name: "Integration::#{using.to_s.classify}Integration",
          foreign_key: :integration_id
      end
    end
  end

  module Identifiable
    extend ActiveSupport::Concern

    module ClassMethods
      def identifies name, using
        scope name, -> do
          includes(:project, integration: :account).
            where(integration_type: "Integration::#{using.to_s.classify}Integration")
        end
      end
    end
  end

  class Scaffold < Struct.new(:activity)
    %w(description hours).each do |method|
      define_method(method) do
        raise "Please implement `#{method}`"
      end
    end
  end

  def integration
    Scaffold.new(self)
  end
end
