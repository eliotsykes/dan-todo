import Ember from 'ember';

export function pageTitle(params) {
  var newTitle = params[0];
  document.title = newTitle;
}

export default Ember.HTMLBars.makeBoundHelper(pageTitle);
