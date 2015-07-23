import Ember from 'ember';
import SecureDefaultRouteFactory from '../mixins/secure-default-route-factory';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

Ember.Route.reopenClass(SecureDefaultRouteFactory);

export default Ember.Route.extend(ApplicationRouteMixin);