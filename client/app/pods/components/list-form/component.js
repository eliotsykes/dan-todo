import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    // create() is called when form is submitted
    create() {
      // Get list model object from component. It will be auto-populated with
      // input values from the form:
      let list = this.get('list');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      let transitionToListIndex = () => {
        this.get('router').transitionTo(
          'list.index', { queryParams: { editsLocked: true } }
        );
      };

      let hasUnsavedChanges = list.get('isDirty');

      if (!hasUnsavedChanges) {
        transitionToListIndex();
        return;
      }

      // Get the notifier service:
      let notifier = this.get('notifier');

      function onCreate() {
        notifier.setMessage('New list saved successfully.');
        transitionToListIndex();
      }

      function onCreateFailed(error) {
        let errorMessage = "Sorry, list was not saved.";
        let errors = error.responseJSON.errors;
        if (Ember.isPresent(errors)) {
          errorMessage += " " + errors.join(". ");
        }
        notifier.setMessage(errorMessage);
      }

      // Register/save the list via an AJAX request to the server API:
      list.save().then(onCreate).catch(onCreateFailed);
    }
  }

});
