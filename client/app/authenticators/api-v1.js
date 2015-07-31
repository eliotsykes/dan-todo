import Ember from 'ember';
import Base from 'simple-auth/authenticators/base';

export default Base.extend({
  restore(/*data*/) {
    return Ember.RSVP.reject();
  },

  authenticate(credentials) {
    var authenticator = this;

    return new Ember.RSVP.Promise(function(resolve, reject) {

      var data = {
        user: {
          email: credentials.email,
          password: credentials.password
        }
      };

      return authenticator.makeRequest(data).then(function(response) {
        return resolve(response);
      }, function(xhr /*, status, error*/) {
        return reject(xhr.responseJSON || xhr.responseText);
      });
    });
  },

  invalidate(/*data*/) {
    return Ember.RSVP.resolve();
  },

  makeRequest(data) {
    return Ember.$.ajax({
      url:        '/api/v1/sessions',
      type:       'POST',
      contentType: 'application/json; charset=utf-8',
      dataType:   'json',
      data:       JSON.stringify(data),
      beforeSend: function(xhr, settings) {
        xhr.setRequestHeader('Accept', settings.accepts.json);
      }
    });
  }
});
