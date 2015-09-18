import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    // save() is called when form is submitted
    save() {
      this.sendAction();
    }
  }

});
