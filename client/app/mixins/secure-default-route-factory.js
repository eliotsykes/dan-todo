import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';
import UnauthenticatedRouteMixin from 'simple-auth/mixins/unauthenticated-route-mixin';
import OpenRouteMixin from './open-route-mixin';

export default Ember.Mixin.create({
  create() {
    // Create the route using the normal technique:
    var route = this._super(...arguments);

    var authenticationRouteMixinApplied = ApplicationRouteMixin.detect(route) ||
      AuthenticatedRouteMixin.detect(route) ||
      UnauthenticatedRouteMixin.detect(route) ||
      OpenRouteMixin.detect(route);

    if (!authenticationRouteMixinApplied) {
      // The route was not created with any of the authentication-related route
      // mixins. Modify route so it requires authentication to be accessed:
      AuthenticatedRouteMixin.apply(route);
    }

    return route;
  }
});
