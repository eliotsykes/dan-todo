import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a user to use in the template. Allows user.email, user.password,
    // etc. to be used in input helpers like: {{input value=user.email}}
    this.set('user', this.store.createRecord('user'));
  },
  actions: {
    // create() is called when form is submitted
    create: function() {
      // Get user model object from component. It will be auto-populated with 
      // input values from the from:
      var user = this.get('user');

      // Register/save the user via an AJAX request to the server API:
      user.save().then(
        function success() { console.log("User saved!"); },
        function failure(e) { console.log("Oops, user not saved!", e); }
      );
    }
  }
});
