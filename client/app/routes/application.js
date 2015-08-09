import Ember from 'ember';
import SecureDefaultRouteFactory from '../mixins/secure-default-route-factory';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

Ember.Route.reopenClass(SecureDefaultRouteFactory);

export default Ember.Route.extend(ApplicationRouteMixin, {

  notifier: Ember.inject.service('notifier'),

  actions: {
    invalidateSession() {
      this.get('session').invalidate();
      this.get('notifier').setMessage('You have been logged out');
    },

    sessionRequiresAuthentication() {
      this.get('notifier').setMessage('Please login to access this');
      this._super.apply(this, arguments);
    }
  }
});
