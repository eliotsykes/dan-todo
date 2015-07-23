import Ember from 'ember';
import OpenRouteMixin from '../../mixins/open-route-mixin';

// Make route available to both authenticated and non-authenticated users:
export default Ember.Route.extend(OpenRouteMixin);
