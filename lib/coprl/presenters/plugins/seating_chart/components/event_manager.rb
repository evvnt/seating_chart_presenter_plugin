module Coprl
  module Presenters
    module Plugins
      module SeatingChart
        module Components
          class EventManager < Base
            attr_reader :subaccount_id, :secret_key, :event_id, :mode, :chart_js_url
            def initialize(subaccount_id, secret_key, **attribs, &block)
              @subaccount_id = subaccount_id
              @secret_key = secret_key
              @event_id = attribs.delete(:event_id){ nil }.to_s
              @mode = attribs.delete(:mode){ 'manageForSaleConfig' } # 'manageObjectStatuses' or 'manageForSaleConfig'. More to follow.
              @chart_js_url = attribs.fetch(:chart_js_url, Settings.config.chart_js_url)
              @component_options = %i(subaccount_id secret_key event_id mode chart_js_url)
              super(type: :event_manager, **attribs, &block)
              expand!
            end

          end
        end
      end
    end
  end
end
