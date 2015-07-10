import Ember from 'ember';

export default Ember.Service.extend({
  // init function is a hook provided to Ember Services that you can optionally
  // override. It is run once when the Ember application first loads.
  init: function() {
    this.initMessageFromAnyNotificationKeysInUrl();
  },

  message: '',
  
  // Thanks to computed properties, hasMessage will return true when the 
  // notifier message is not empty:
  hasMessage: Ember.computed.notEmpty('message'),
  
  setMessage: function(message) {
    this.set('message', message);
  },

  clear: function() {
    this.setMessage('');
  },

  initMessageFromAnyNotificationKeysInUrl: function() {
    var currentUrl = this.get('router.location.location.href');
    var hasNotificationKeysInUrl = currentUrl.indexOf('notifications=confirmed') >= 0;
    if (hasNotificationKeysInUrl) {
      this.setMessage('Your account has been confirmed, thank you!');
    }
  }
});
