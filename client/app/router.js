import Ember from 'ember';
import config from './config/environment';
import { modifyRouteModuleForBodyClassHelper } from './helpers/body-class';

modifyRouteModuleForBodyClassHelper();

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('user.new', { path: '/register' });
  this.route('confirmation-pending');
  this.route('session.new', { path: '/login' });
  this.route('list', function() {
    this.route('new');
    this.route('edit', { path: ':list_id/edit' });
  });
});

export default Router;
