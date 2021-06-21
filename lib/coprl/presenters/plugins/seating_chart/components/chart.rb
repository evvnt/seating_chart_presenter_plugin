module Coprl
  module Presenters
    module Plugins
      module SeatingChart
        module Components
          class Chart < Base
            attr_reader :chart_key, :public_key, :event_id, :hold_on_select, :pricing,
                        :currency, :locale, :price_level_tooltip, :available_categories,
                        :max_selected_objects, :chart_js_url
            def initialize(chart_key, public_key, **attribs, &block)
              @chart_key = chart_key
              @public_key = public_key
              @event_id = attribs.delete(:event_id){ nil }
              @hold_on_select = attribs.delete(:hold_on_select){ true }
              @pricing = attribs.delete(:pricing){ [] }
              @currency = attribs.delete(:currency){ 'USD' }  # https://www.iban.com/currency-codes
              @locale = attribs.delete(:locale){ 'en-US' }
              @price_level_tooltip = attribs.delete(:price_level_tooltip){ 'Select a price level' }
              @available_categories = attribs.delete(:available_categories){ [] }
              @max_selected_objects = attribs.delete(:max_selected_objects){ nil }
              @chart_js_url = attribs.fetch(:chart_js_url, Settings.config.chart_js_url)
              @component_options = %i(chart_key public_key event_id hold_on_select pricing currency
                                      locale price_level_tooltip available_categories max_selected_objects)
              super(type: :seating_chart, **attribs, &block)
              expand!
            end

          end
        end
      end
    end
  end
end
