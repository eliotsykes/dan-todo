import Ember from 'ember';

export default Ember.Component.extend({
  tagName: '',
  
  init: function () {
    document.title = this.get("title");
    this._super.apply(this, arguments);
  },
});
