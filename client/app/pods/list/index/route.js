import Ember from 'ember';

export default Ember.Route.extend({
  queryParams: {
    editsLocked: {
      replace: true
    }
  },

  model() {
    return this.store.findAll('list');
  }
});
