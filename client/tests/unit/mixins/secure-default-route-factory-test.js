import Ember from 'ember';
import SecureDefaultRouteFactoryMixin from '../../../mixins/secure-default-route-factory';
import { module, test } from 'qunit';

module('Unit | Mixin | secure default route factory');

// Replace this with your real tests.
test('it works', function(assert) {
  var SecureDefaultRouteFactoryObject = Ember.Object.extend(SecureDefaultRouteFactoryMixin);
  var subject = SecureDefaultRouteFactoryObject.create();
  assert.ok(subject);
});
