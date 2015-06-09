import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a user to use in the template. Allows user.email, user.password,
    // etc. to be used in input helpers like: {{input value=user.email}}
    this.set('user', this.get('store').createRecord('user'));
  },
  actions: {
    // create() is called when form is submitted
    create: function() {
      // Get user model object from component. It will be auto-populated with 
      // input values from the from:
      var user = this.get('user');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      var transitionToConfirmationPending = () => {
        this.get('router').transitionTo('confirmation.pending');
      };

      // Register/save the user via an AJAX request to the server API:
      user.save()
        .then(transitionToConfirmationPending)
        .catch(
          function(reason) { window.alert("Oops, user not saved! "  + reason); }
        );
    }
  }
});
