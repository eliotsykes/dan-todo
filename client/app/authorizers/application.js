import Ember from 'ember';
import Base from 'simple-auth/authorizers/base';

export default Base.extend({
  authorize(jqXHR/*, requestOptions*/) {
    let isAuthenticated = this.get('session.isAuthenticated');
    let token = this.get('session.secure.token');

    if (isAuthenticated && !Ember.isEmpty(token)) {
      jqXHR.setRequestHeader('X-Api-Key', token);
    }
  }
});
