import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a session to use in the template. Allows session.email and 
    // session.password to be used in input helpers, e.g.:
    // {{input value=session.email}}
    this.set('session', this.get('store').createRecord('session'));
  },
  actions: {
    // create() is called when form is submitted
    create: function() {
      // Get session model object from component. It will be auto-populated with 
      // input values from the form:
      var user = this.get('session');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      var transitionToListIndex = () => {
        this.get('router').transitionTo('list.index');
      };

      // Register/save the user via an AJAX request to the server API:
      session.save()
        .then(transitionToListIndex)
        .catch(
          function(reason) { window.alert("Oops, could not login! "  + reason); }
        );
    }
  }
});
