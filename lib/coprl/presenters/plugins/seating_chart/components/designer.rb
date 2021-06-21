module Coprl
  module Presenters
    module Plugins
      module SeatingChart
        module Components
          class Designer < Base
            attr_reader :subaccount_id, :designer_key, :chart_key, :disabled, :readonly,
                        :language, :chart_js_url, :open_latest_drawing, :show_on_update,
                        :hide_on_update, :chart_key_input_id
            def initialize(subaccount_id, designer_key, **attribs, &block)
              @subaccount_id = subaccount_id
              @designer_key = designer_key
              @chart_key = attribs.delete(:chart_key){ nil }
              @disabled = attribs.delete(:disabled){ [] }
              @readonly = attribs.delete(:readonly){ [] }
              @language = attribs.delete(:language){ 'en' }
              @open_latest_drawing = attribs.delete(:open_latest_drawing){ true }
              @chart_js_url = attribs.fetch(:chart_js_url, Settings.config.chart_js_url)
              @show_on_update = attribs.fetch(:show_on_update){ nil }
              @hide_on_update = attribs.fetch(:hide_on_update){ nil }
              @chart_key_input_id = attribs.delete(:chart_key_input_id){ nil }
              @component_options = %i(subaccount_id designer_key chart_key disabled readonly
                                  language chart_js_url open_latest_drawing show_on_update
                                  hide_on_update chart_key_input_id)
              super(type: :seating_designer, **attribs, &block)
              expand!
            end

          end
        end
      end
    end
  end
end
