import DS from 'ember-data';
import Ember from 'ember';

export default DS.Model.extend({
  title: DS.attr('string'),
  notDeleted: Ember.computed.not('isDeleted'),
  isCreatingOrUpdating: Ember.computed.and('isSaving', 'notDeleted')
});
