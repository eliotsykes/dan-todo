import Ember from 'ember';

export default Ember.Service.extend({
  init: function() {
    this.initMessageFromAnyNotificationKeysInUrl();
  },

  message: '',
  
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
