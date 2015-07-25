import Ember from 'ember';
import ConfigurableAuthenticationRouteMixinMixin from '../../../mixins/configurable-authentication-route-mixin';
import { module, test } from 'qunit';

module('Unit | Mixin | configurable authentication route mixin');

// Replace this with your real tests.
test('it works', function(assert) {
  var ConfigurableAuthenticationRouteMixinObject = Ember.Object.extend(ConfigurableAuthenticationRouteMixinMixin);
  var subject = ConfigurableAuthenticationRouteMixinObject.create();
  assert.ok(subject);
});
