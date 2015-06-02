import Ember from 'ember';

export function bodyClass(params) {
  var cssClass = params[0];
  var body = Ember.$('body');
  if (!body.hasClass(cssClass)) {
    body.addClass(cssClass);
  }
}

export function bodyClassReset() {
  var defaultBodyClass = 'ember-application';
  // Remove all body classes except for the default ember-application class.
  Ember.$('body').attr('class', defaultBodyClass);
}

export function modifyRouteModuleForBodyClassHelper() {
  Ember.Route.reopen({
    // deactivate runs when a route is exited. This will reset the body class
    // when a route is exited, so old body classes don't pile up.
    deactivate: bodyClassReset
  });
}

export default Ember.HTMLBars.makeBoundHelper(bodyClass);
