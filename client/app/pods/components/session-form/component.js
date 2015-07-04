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

      this.get('session').authenticate('authenticator:api-v1', credentials).then(function() {      
        // authentication was successful
        console.log("auth successful");
      }, function() {
        // authentication failed
        console.log("auth failed");
      });

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      // var transitionToListIndex = () => {
      //   this.get('router').transitionTo('list.index');
      // };
    }
  }
});
