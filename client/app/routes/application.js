import Ember from 'ember';
import ConfigurableAuthenticationRouteMixin from '../mixins/configurable-authentication-route-mixin';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

Ember.Route.reopen(ConfigurableAuthenticationRouteMixin);

export default Ember.Route.extend(ApplicationRouteMixin);