require_relative 'seating_chart/components/base'
require_relative 'seating_chart/components/chart'
require_relative 'seating_chart/components/designer'
require_relative 'seating_chart/components/event_manager'
require 'dry/configurable'

module Coprl
  module Presenters
    module Plugins
      module SeatingChart

        class Settings
          extend Dry::Configurable
          setting :chart_js_url, default: 'https://cdn.seatsio.net/chart.js'
        end

        module DSLComponents
          def seating_chart(chart_key, public_key, **attributes, &block)
            self << SeatingChart::Components::Chart.new(chart_key,
                                                        public_key,
                                                        parent: self, **attributes, &block)
          end

          def seating_designer(subaccount_id, designer_key, **attributes, &block)
            self << SeatingChart::Components::Designer.new(subaccount_id,
                                                           designer_key,
                                                           parent: self, **attributes, &block)
          end

          def event_manager(subaccount_id, secret_key, **attributes, &block)
            self << SeatingChart::Components::EventManager.new(subaccount_id,
                                                               secret_key,
                                                               parent: self, **attributes, &block)
          end
        end

        module WebClientComponents

          def view_dir_seating_chart(_pom)
            File.join(__dir__, '../../../..', 'views', 'components')
          end

          def render_header_seating_chart(pom, render:)
            render.call :erb, :seating_chart_header, views: view_dir_seating_chart(pom)
          end

          def render_seating_chart(comp,
                                   render:,
                                   components:,
                                   index:)
            render.call :erb, :seating_chart, views: view_dir_seating_chart(comp),
                        locals: {comp: comp,
                                 components: components,
                                 index: index}
          end

          def render_seating_designer(comp,
                                             render:,
                                             components:,
                                             index:)
            render.call :erb, :seating_designer, views: view_dir_seating_chart(comp),
                        locals: {comp: comp,
                                 components: components,
                                 index: index}
          end

          def render_event_manager(comp,
                                          render:,
                                          components:,
                                          index:)
            render.call :erb, :event_manager, views: view_dir_seating_chart(comp),
                        locals: {comp: comp,
                                 components: components,
                                 index: index}
          end
        end
      end
    end
  end
end
