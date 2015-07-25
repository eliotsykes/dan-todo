import Ember from 'ember';
import ConfigurableAuthenticationRouteMixin from '../mixins/configurable-authentication-route-mixin';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

// Order of beforeModels may not be right any longer - can authenticated routes
// redirect to session.new still?
Ember.Route.reopen(ConfigurableAuthenticationRouteMixin);

export default Ember.Route.extend(ApplicationRouteMixin);