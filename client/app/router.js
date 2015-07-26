import Ember from 'ember';
import config from './config/environment';
import { modifyRouteModuleForBodyClassHelper } from './helpers/body-class';

modifyRouteModuleForBodyClassHelper();

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('user.new', { path: '/register' });
  // this.route('confirmation.pending', { path: '/confirmation/pending' });
  this.route('session.new', { path: '/login' });
  // this.route('list', function() {}); Yes do use list as the app supports multiple lists of todos,
  // but put it under /list(s)?
});

export default Router;
