import Ember from 'ember';

export default Ember.Component.extend({
  // Ember will hide component when isVisible is false.
  isVisible: Ember.computed.readOnly('notifier.hasMessage'),
  
  actions: {
    // close action is called when `<button {{action "close"}}>Close</button>`
    // is pressed.
    close: function() {
      this.get('notifier').clear();
    }
  }
});
