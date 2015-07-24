import Ember from 'ember';
import Configuration from 'simple-auth/configuration';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend(ApplicationRouteMixin, {
  
  skipAuthentication: false,

  beforeModel: function(transition) {

    var superResult = this._super(transition);

    // function isAuthenticated() {
    //   this.get(Configuration.sessionPropertyName).get('isAuthenticated');
    // }

    // function requireAuthentication() {
    //   transition.abort();
    //   this.get(Configuration.sessionPropertyName).set('attemptedTransition', transition);
    //   Ember.assert('The route configured as Configuration.authenticationRoute cannot implement the AuthenticatedRouteMixin mixin as that leads to an infinite transitioning loop!', this.get('routeName') !== Configuration.authenticationRoute);
    //   transition.send('sessionRequiresAuthentication');
    // }
    
    var skip = this.get('skipAuthentication') === true;

    if (!skip && !this.get(Configuration.sessionPropertyName).get('isAuthenticated')) {
    // if (!skip && !isAuthenticated()) {
      // requireAuthentication();
      transition.abort();
      this.get(Configuration.sessionPropertyName).set('attemptedTransition', transition);
      Ember.assert('The route configured as Configuration.authenticationRoute cannot implement the AuthenticatedRouteMixin mixin as that leads to an infinite transitioning loop!', this.get('routeName') !== Configuration.authenticationRoute);
      transition.send('sessionRequiresAuthentication');
    }

    return superResult;
  }

});
