import Ember from 'ember';

export default Ember.Component.extend({
  // Ember will hide component when isVisible is false.
  isVisible: false,

  // willInsertElement is a hook provided by Ember that runs before the markup
  // for the component is inserted into the page.
  willInsertElement: function() {
    var currentUrl = this.get('router.location.location.href');
    var showNotifier = currentUrl.indexOf('notifications=confirmed') >= 0;
    this.set('isVisible', showNotifier);
  },
  
  actions: {
    // close action is called when `<button {{action "close"}}>Close</button>`
    // is pressed.
    close: function() {
      this.set('isVisible', false);
    }
  }
});
