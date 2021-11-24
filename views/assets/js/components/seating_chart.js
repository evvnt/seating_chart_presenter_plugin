const ADD_ITEM_EVENT = 'object_selected';
const REMOVE_ITEM_EVENT = 'object_deselected';
const HOLD_FAILED_EVENT = 'hold_failed';

class SeatingChart {
  constructor(element) {
    console.log('\tSeatingChart');
    this.element = element;
    this.pricing = JSON.parse(element.dataset.pricing);
    let data = JSON.parse(element.dataset.seatingOptions);
    let chartConfig = {
      divId: element.id,
      publicKey: data.public_key,
      event: data.event_id,
      holdOnSelect: data.hold_on_select,
      pricing: data.pricing,
      priceFormatter: function (price) {
        let formatter = new Intl.NumberFormat(data.locale, {
          style: 'currency',
          currency: data.currency
        });
        return formatter.format(price);
      },
      availableCategories: data.available_categories,
      priceLevelsTooltipMessage: data.price_level_tooltip,
      maxSelectedObjects: data.max_selected_objects
    };
    chartConfig.onObjectSelected = this.itemSelectionCallback(ADD_ITEM_EVENT);
    chartConfig.onObjectDeselected = this.itemSelectionCallback(REMOVE_ITEM_EVENT);
    chartConfig.onHoldFailed = this.itemsSelectionCallback(HOLD_FAILED_EVENT);
    // onHoldTokenExpired
    // onBestAvailableSelected
    // onBestAvailableSelectionFailed

    this.seatingChart = new seatsio.SeatingChart(chartConfig);
    this.seatingChart.render();
  }

  // Callback for single object selection/deselection
  itemSelectionCallback(eventName) {
    return (object, ticketType) => {
      const payload = Object.assign({}, this.parseObject(object, ticketType))
      let event = new CustomEvent(eventName, {composed: true, detail: payload});
      this.element.dispatchEvent(event);
    }
  }

  // Callback for multiple object selection/deselection
  itemsSelectionCallback(eventName) {
    return (objects) => {
      let event = new CustomEvent(eventName, {composed: true, detail: {objects: objects}});
      this.element.dispatchEvent(event);
    }
  }

  parseObject(object, ticketType) {
    if (object.objectType === 'Table') {
      return this.parseTableObject(object, ticketType);
    }
    else {
      return this.parseSeatObject(object, ticketType);
    }
  }

  // Translate a Seatsio object into the parameters expected by the cart
  parseSeatObject(object, ticketType) {
    return {
      primary_uuid: object.uuid,
      item_id: object.uuid,
      ticket_type_id: object.category.key,
      seat_id: object.seatId,
      seat: object.labels.own,
      row: object.labels.parent,
      section: object.labels.section,
      price_level_name: ticketType === undefined ? this.findDefaultPriceLevel(object.category.key) : ticketType.ticketType,
      object_type: object.objectType,
      hold_token: object.chart.holdToken,
      quantity: object.objectType === 'GeneralAdmissionArea' ? 1 : null
    };
  }

  parseTableObject(object, ticketType) {
    let seats = object.seats.map(seat => this.parseSeatObject(
      Object.assign({}, seat, {seatId: object.seatId,
                                             category: object.category,
                                             chart: object.chart}), ticketType)
    );
    return {
      primary_uuid: object.uuid,
      object_type: object.objectType,
      hold_token: object.chart.holdToken,
      seats: seats
    }
  }

  findDefaultPriceLevel(categoryId) {
    return this.pricing.find(e => e.category === categoryId).ticketType
  }

}

class SeatingDesigner {
  constructor(element) {
    console.log('\tSeatingDesigner');
    let data = JSON.parse(element.dataset.designerOptions);
    let options = {
      divId: element.id,
      designerKey: data.designer_key,
      chartKey: data.chart_key,
      language: data.language,
      openLatestDrawing: data.open_latest_drawing,
      features: {
        disabled: data.disabled,
        readOnly: data.readonly
      }
    };
    if (data.chart_key_input_id) {
      options.onChartCreated = function (chartKey) {
        document.querySelector('#'+data.chart_key_input_id).value = chartKey;
      }
    }
    if (data.show_on_update || data.hide_on_update) {
      options.onChartUpdated = function (chartKey) {
        if(data.show_on_update) {
          document.querySelector('#'+data.show_on_update).classList.remove('v-hidden');
        }
        if (data.hide_on_update) {
          document.querySelector('#'+data.hide_on_update).classList.add('v-hidden');
        }
      }
    }
    new seatsio.SeatingChartDesigner(options).render();
  }
}

class EventManager {
  constructor(element) {
    console.log('\tEventManager');
    let data = JSON.parse(element.dataset.managerOptions);
    new seatsio.EventManager({
      divId: element.id,
      secretKey: data.secret_key,
      event: data.event_id,
      mode: data.mode
    }).render();
  }
}
