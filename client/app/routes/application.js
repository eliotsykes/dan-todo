import Ember from 'ember';
import ConfigurableAuthenticationRouteMixin from '../mixins/configurable-authentication-route-mixin';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';
import UnauthenticatedRouteMixin from 'simple-auth/mixins/unauthenticated-route-mixin';

// Ember.Route.reopen(ConfigurableAuthenticationRouteMixin);

var CustomExtend = Ember.Mixin.create({
  extend: function() {
    console.log("in custom extend, delegating", arguments);
    // return this._super(...arguments);
    var arg1 = arguments[0];
    // console.log("Is arg1 ApplicationRouteMixin?", arg1 == ApplicationRouteMixin);
    // console.log("Is arg1 AuthenticatedRouteMixin?", arg1 == AuthenticatedRouteMixin);
    // console.log("Is arg1 UnauthenticatedRouteMixin?", arg1 == UnauthenticatedRouteMixin);
    
    if (![ApplicationRouteMixin, AuthenticatedRouteMixin, UnauthenticatedRouteMixin].contains(arg1)) {
      // console.log('Applying UnauthenticatedRouteMixin');
      // arguments.unshift(AuthenticatedRouteMixin);
      // Array.prototype.unshift.call(arguments, AuthenticatedRouteMixin);
      // return this._super(AuthenticatedRouteMixin, ...arguments);
      // return this._super(UnauthenticatedRouteMixin, ...arguments);
      return this._super(...arguments);
      // return this._super(...arguments);
    } else {
      // console.log('NOT Applying UnauthenticatedRouteMixin');
      return this._super(...arguments);
    }
  }
});


Ember.Route.reopenClass(CustomExtend);

// var foo = Ember.Route.extend(ApplicationRouteMixin);
// console.log("application.js foo", foo);
// export default foo;

export default Ember.Route.extend(ApplicationRouteMixin);