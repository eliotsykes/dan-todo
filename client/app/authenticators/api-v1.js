import Ember from 'ember';
import Base from 'simple-auth/authenticators/base';

export default Base.extend({
  restore(data) {
    return Ember.RSVP.reject();
  },

  /**
    Authenticates the session with the specified `credentials`; the credentials
    are `POST`ed to the
    [`Authenticators.Devise#serverTokenEndpoint`](#SimpleAuth-Authenticators-Devise-serverTokenEndpoint)
    and if they are valid the server returns an auth token and email in
    response. __If the credentials are valid and authentication succeeds, a
    promise that resolves with the server's response is returned__, otherwise a
    promise that rejects with the server error is returned.
    @method authenticate
    @param {Object} options The credentials to authenticate the session with
    @return {Ember.RSVP.Promise} A promise that resolves when an auth token and email is successfully acquired from the server and rejects otherwise
  */
  authenticate(credentials) {
    var authenticator = this;

    // TODO: Replace authenticator with using ES6 arrow function => syntax so
    // this can be referenced inside instead of authenticator:
    return new Ember.RSVP.Promise(function(resolve, reject) {

      var data = {
        user: {
          email: credentials.email,
          password: credentials.password
        }
      };

      authenticator.makeRequest(data).then(function(response) {
        Ember.run(function() {
          resolve(response);
        });
      }, function(xhr, status, error) {
        Ember.run(function() {
          reject(xhr.responseJSON || xhr.responseText);
        });
      });
    });
  },

  invalidate(data) {
    return Ember.RSVP.resolve();
  },

  /**
    @method makeRequest
    @private
  */
  makeRequest(data, resolve, reject) {
    return Ember.$.ajax({
      url:        '/api/v1/sessions',
      type:       'POST',
      data:       data,
      dataType:   'json',
      contentType: 'application/json',
      beforeSend: function(xhr, settings) {
        xhr.setRequestHeader('Accept', settings.accepts.json);
      }
    });
  }
});

