import Ember from 'ember';
import AuthConfig from 'simple-auth/configuration';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

var ConfigurableAuthenticationRouteMixin = Ember.Mixin.create({
  // The more secure default is to need authentication for all routes. Do not
  // change this value in this file. Only change needsAuthentication in the 
  // route.js file for the route that does not need authentication.
  needsAuthentication: true,

  getSession: function() {
    return this.get(AuthConfig.sessionPropertyName);
  },

  hasAuthenticatedSession: function() {
    this.getSession().get('isAuthenticated');
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

  beforeModel: function(transition) {
    console.log("needsAuthentication", this.get('needsAuthentication'), this);

    var superResult = this._super(transition);

    if (this.get('needsAuthentication') && !this.hasAuthenticatedSession()) {
      console.log("about to demand authentication", this.get('needsAuthentication'));
      this.demandAuthentication(transition);  
    }

    return superResult;
  }

});
Ember.Route.reopen(ConfigurableAuthenticationRouteMixin);

export default Ember.Route.extend(ApplicationRouteMixin, {
  needsAuthentication: false
});