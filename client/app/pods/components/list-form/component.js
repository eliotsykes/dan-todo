import Ember from 'ember';

export default Ember.Component.extend({
  init() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a list to use in the template. Allows list.title to be
    // used in input helpers like: {{input value=list.title}}
    this.set('list', this.get('store').createRecord('list'));
  },

  actions: {
    // create() is called when form is submitted
    create() {
      // Get list model object from component. It will be auto-populated with
      // input values from the form:
      var list = this.get('list');

      // Get the notifier service:
      var notifier = this.get('notifier');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      var onCreate = () => {
        notifier.setMessage("New list saved successfully.");
        this.get('router').transitionTo('list.index');
      };

      function onCreateFailed(/*error*/) {
        notifier.setMessage("Sorry, list was not saved, please try again.");
      }

      // Register/save the list via an AJAX request to the server API:
      list.save().then(onCreate, onCreateFailed);
    }
  }

});
