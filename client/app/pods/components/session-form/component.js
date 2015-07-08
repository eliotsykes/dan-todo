import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a credentials object to use in the template. Allows credentials.email and 
    // credentials.password to be used in input helpers, e.g.:
    // {{input value=credentials.email}}
    this.set('credentials', {});
  },
  actions: {
    // authenticate() is called when form is submitted
    authenticate: function() {
      // Get credentials object from component. It will be auto-populated with 
      // input values from the form:
      var credentials = this.get('credentials');

      this.get('session')
        .authenticate('authenticator:api-v1', credentials)
        .then(onAuthentication, onAuthenticationFailed);

      var notifier = this.get('notifier');

      function onAuthentication() {
        notifier.setMessage("You are signed in.");
      }

      function onAuthenticationFailed(/*error*/) {
        notifier.setMessage("Sorry, we failed to sign you in, please try again.");
      }
    }
  }
});
