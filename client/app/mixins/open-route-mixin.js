import Ember from 'ember';

// OpenRouteMixin is a tagging mixin. Apply it to routes that you want
// publicly viewable to all users, both authenticated and non-authenticated.
//
// Tagging mixins add no behaviour to a class themselves. Instead, they tag a
// class to allow other code to alter behaviour based on the tagging mixins it
// finds on a particular object.
//
// In this case, the SecureDefaultRouteFactory will alter its behaviour when
// it detects a route that is tagged with OpenRouteMixin. See
// SecureDefaultRouteFactory for more details.
export default Ember.Mixin.create({
});
