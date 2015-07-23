import Ember from 'ember';
import OpenRouteMixinMixin from '../../../mixins/open-route-mixin';
import { module, test } from 'qunit';

module('Unit | Mixin | open route mixin');

// Replace this with your real tests.
test('it works', function(assert) {
  var OpenRouteMixinObject = Ember.Object.extend(OpenRouteMixinMixin);
  var subject = OpenRouteMixinObject.create();
  assert.ok(subject);
});
