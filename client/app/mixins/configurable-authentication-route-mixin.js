import Ember from 'ember';
import AuthConfig from 'simple-auth/configuration';

export default Ember.Mixin.create({
  // The more secure default is to need authentication for all routes. Do not
  // change this value in this file. Only change needsAuthentication in the 
  // route.js file for the route that does not need authentication.
  needsAuthentication: true,

  getSession: function() {
    return this.get(AuthConfig.sessionPropertyName);
  },

  demandAuthentication: function(transition) {
    transition.abort();
    this.getSession().set('attemptedTransition', transition);
    Ember.assert(
      'Infinite transition loop detected. AuthConfig.authenticationRoute should not demand authentication.',
      this.get('routeName') !== AuthConfig.authenticationRoute
    );
    transition.send('sessionRequiresAuthentication');
  },

  demandAuthenticationIfRequired: function(transition) {
    var isRouteWithURL = this.routeName !== 'application';
    if (isRouteWithURL && this.get('needsAuthentication') && !this.getSession().get('isAuthenticated')) {
      this.demandAuthentication(transition);  
    }
  },

  beforeModel: function(transition) {
    var superResult = this._super(transition);
    this.demandAuthenticationIfRequired(transition);
    return superResult;
  }

});