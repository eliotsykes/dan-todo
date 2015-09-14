import Ember from 'ember';

export default Ember.Route.extend({
  model(params) {
    return this.store.createRecord('list');
  },
  deactivate() {
    let preventUnsavedListFromBeingDisplayed = () => {
      let list = this.modelFor('list/new');
      if (list.get('isNew')) {
        list.destroyRecord();
      }
    };
    preventUnsavedListFromBeingDisplayed();
  }
});
