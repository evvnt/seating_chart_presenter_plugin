# Seating chart Presenter Plugin

A [COPRL](http://github.com/coprl/coprl) presenter plugin that provides three components for implementing a [Seats.io](https://seats.io) integration.
The available components are Seating Chart, Chart Designer, and Event Manager

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seating_chart_presenter_plugin', git: 'https://github.com/evvnt/seating_chart_presenter_plugin', require: false
```

And then execute:

    $ bundle


## Usage in POMs

#### Seating Chart
```ruby
plugin :seating_chart

content do
  seating_chart('[SEATSIO_CHART_KEY]',
                       '[SEATSIO.PUBLIC_KEY]',
                       event_id: '[EVENT_ID]', # as a string
                       pricing: [
                          {category: 1, price: 30.0}, 
                          {category: 2, price: 35.0}
                       ],
                       available_categories: [1,2],
                       currency: 'USD',
                       locale: 'en-US')
end
```
#### Chart Designer
```ruby
plugin :seating_chart

content do
  seating_designer('[SUBACCOUNT_ID]',  # Now know as "workspace"
                          '[DESIGNER_KEY]',
                           chart_key: '[CHART KEY]',
                           disabled: [],  # list of disabled designer functions ie: 'focalPoint', 'backgroundImage', etc.
                           readonly: [],  # list of disabled functions ie: 'chartName', 'categoryList'
                           language: 'en',
                           open_latest_drawing: true,
                           show_on_update: '',  # ID of element to show on chart update (optional)
                           hide_on_update: '',  # ID of element to hide on chart update (optional)
                           chart_key_input_id: '' # ID of input element to store chart key (optional) 
                         )
end
```
#### Event Manager
```ruby
plugin :seating_chart

content do
  event_manager('[SUBACCOUNT_ID]', 
                       '[SECRET_KEY]',
                        event_id: '[EVENT_ID]',
                        mode: 'manageObjectStatuses' # or 'manageForSaleConfig'
                      )
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/evvnt/seating_chart_presenter_plugin.
