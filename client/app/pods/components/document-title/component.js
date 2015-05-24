import Ember from 'ember';

export default Ember.Component.extend({
  // There's no HTML rendered for this component, so make tagName blank:
  tagName: '',
  
  // init() runs when component is first processed by view
  init: function () {
    // Read the title attribute from the component declaration in the template.
    var newTitle = this.get("title");

    // Update the title in the head element using the document.title attribute:
    document.title = newTitle;

    // Continue with the standard initilization:
    this._super.apply(this, arguments);
  },
});